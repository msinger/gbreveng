`default_nettype none

/*
 * Prepare GameBoy:
 * 1. Desolder quartz and both capacitors from GameBoy CPU board. (The 1 meg
 *    resistor may stay.)
 * 2. Wire your FPGA clock output to DMG pin 74 (X1). This is the oscillator
 *    input. Voltage range should be 0-5V. I used Nexperia 74LVCH8T245PW as
 *    voltage translator.
 * 3. Hook up all data lines D0-D7, #wr, #rd, address lines A0-A14 and the ROM
 *    chip select A15 to the FPGA.
 * 4. Optional: Lift T1 and T2 test pins from DMG CPU and connect them to
 *    FPGA.
 *
 * Startup (without T1 and T2 connected):
 * 1. Switch off GameBoy and FPGA board (unplug USB).
 * 2. Set DipSW 0-5 inputs on FPGA to HHLHLH (from bit 5 to bit 0). Bits 5-0
 *    represent the value 53. This gets substracted from the FIRST_INSTR clock
 *    ticks defined below. These bits can be used for fine tuning the exact
 *    clock tick that gets overclocked. The value 53 targets the first tick of
 *    the second cycle of the last INC HL instruction of the boot ROM. It causes
 *    the PC to jump to 0x1fe and HL gets set to 0x1ff instead of getting
 *    incremented to 0x14d. (53 can vary by a little bit, depending on the
 *    device I guess. Just play around with the lower bits of the switches.)
 * 3. Power up FPGA.
 * 4. Switch on GameBoy. It won't start because it doesn't get clocked yet.
 * 5. Press SW1. GameBoy should start running.
 * 6. After the chime, the first byte of the boot ROM should be displayed by
 *    the LEDs 0-7 (00110001).
 *
 * Startup (with T1 and T2 connected):
 * 1. Switch on GameBoy and FPGA board in any order.
 * 2. Set DipSW 0-5 inputs on FPGA to HHLHLL (from bit 5 to bit 0). Bits 5-0
 *    represent the value 52. This gets substracted from the FIRST_INSTR clock
 *    ticks defined below. These bits can be used for fine tuning the exact
 *    clock tick that gets overclocked. The value 52 targets the first tick of
 *    the second cycle of the last INC HL instruction of the boot ROM. It causes
 *    the PC to jump to 0x1fe and HL gets set to 0x1ff instead of getting
 *    incremented to 0x14d.
 * 3. Press SW3. GameBoy gets fully reset with T1 and T2 high.
 * 4. Press SW1. GameBoy should start running.
 * 5. After the chime, the first byte of the boot ROM should be displayed by
 *    the LEDs 0-7 (00110001).
 *
 * Buttons:
 *  SW0: Reset FPGA state machine.
 *  SW1: Start clock.
 *  SW2: Stop clock.
 *  SW3: Reset GameBoy.
 *
 * If you can't get it working, try cranking up the PLL output clock.
 */

/* Number of clock ticks until first instruction at 0x100 gets fetched. */
parameter int FIRST_INSTR = 23_571_404;

/* Bit-width of clock tick counter. FIRST_INSTR needs to fit in there. */
parameter int COUNTER_WIDTH = 25;

parameter int CLKREG_WIDTH = 4;

(* nolatches *)
(* top *)
module top(
		input  logic            clk12m,    /* 12 MHz clock input */
		output logic            clkout,
		output logic            clkoe,
		output logic            clkdir,
		output logic            boe,
		output logic            bdir,
		input  logic     [14:0] adr,
		inout  tri logic [7:0]  data,
		input  logic            n_read,
		input  logic            n_write,
		input  logic            n_cs,      /* A15 */
		inout  tri logic        n_reset,
		input  logic     [15:0] sw,
		output logic     [15:0] led,
		input  logic     [3:0]  btn,
		output logic            t1 = 1,
		output logic            t2 = 1
	);

	logic        clk;
	logic [14:0] adr_in;
	logic [7:0]  data_out;
	logic [7:0]  data_in;
	logic        data_drv;
	logic        nrd;
	logic        nwr;
	logic        ncs;
	logic [7:0]  rdrom;
	logic [15:0] swin;
	logic [3:0]  btnin;

	logic [CLKREG_WIDTH-1:0] clkreg, r_clkreg = 0;

	logic       clocking, r_clocking = 0;
	logic [1:0] done,     r_done = 0;

	logic [15:0] ledreg = 8'haa;

	logic[COUNTER_WIDTH-1:0] count, r_count = 0;
	logic[COUNTER_WIDTH-1:0] comp = 0;

	logic [7:0] rom[0:511];
	initial $readmemh("rom.hex", rom, 0, 511);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1)
		) adr_io[14:0] (
			.PACKAGE_PIN(adr),
			.INPUT_CLK(clk),
			.D_IN_0(adr_in)
		);

	SB_IO #(
			.PIN_TYPE('b 1101_00),
			.PULLUP(1)
		) data_io[7:0] (
			.PACKAGE_PIN(data),
			.OUTPUT_CLK(clk),
			.INPUT_CLK(clk),
			.OUTPUT_ENABLE(data_drv),
			.D_OUT_0(data_out),
			.D_IN_0(data_in)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1)
		) n_read_io (
			.PACKAGE_PIN(n_read),
			.INPUT_CLK(clk),
			.D_IN_0(nrd)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1)
		) n_write_io (
			.PACKAGE_PIN(n_write),
			.INPUT_CLK(clk),
			.D_IN_0(nwr)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1)
		) n_cs_io (
			.PACKAGE_PIN(n_cs),
			.INPUT_CLK(clk),
			.D_IN_0(ncs)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(0)
		) sw_io[15:0] (
			.PACKAGE_PIN(sw),
			.INPUT_CLK(clk),
			.D_IN_0(swin)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(0)
		) btn_io[3:0] (
			.PACKAGE_PIN(btn),
			.INPUT_CLK(clk),
			.D_IN_0(btnin)
		);

	SB_IO #(
			.PIN_TYPE('b 1101_00),
			.PULLUP(1)
		) n_reset_io (
			.PACKAGE_PIN(n_reset),
			.OUTPUT_CLK(clk),
			.OUTPUT_ENABLE(btnin[3]),
			.D_OUT_0('0)
		);

	pll pll_inst(
		.clock_in(clk12m),
		.clock_out(clk)
	);

	assign clkoe    = 0;
	assign clkdir   = 1;

	assign boe      = 0;
	assign bdir     = data_drv;

	assign data_drv = !nrd && !ncs;

	assign led      = ledreg;
	assign clkout   = r_clkreg[CLKREG_WIDTH-1];

	always_ff @(posedge clk)
		rdrom <= rom[adr_in[8:0]];

	always_ff @(posedge clk)
		data_out <= rdrom;

	always_comb begin
		clkreg   = r_clkreg;
		clocking = r_clocking;
		done     = r_done;
		count    = r_count;

		if (btnin[1])
			clocking = 1;

		if (r_clocking) begin
			if ((!r_done[1] && r_count == comp) || r_done[0]) begin /* overclock one high and one low phase */
				clkreg[CLKREG_WIDTH-1] = !r_clkreg[CLKREG_WIDTH-1];
				done                   = r_done + 1;
			end else
				clkreg                 = r_clkreg + 1;
		end

		if (!clkout && clkreg[CLKREG_WIDTH-1]) begin
			count = r_count + 1;
		end

		/* Stop the clock only when the total amount of ticks the gameboy got
		 * is dividable by four (but add up to 3 extra ticks set by DIP
		 * switches). */
		if (btnin[2] && (r_count[1:0] != swin[9:8] && count[1:0] == swin[9:8]))
			clocking = 0;

		if (btnin[0]) begin
			clkreg   = 0;
			clocking = 0;
			done     = 0;
			count    = 0;
		end
	end

	always_ff @(posedge clk) begin
		r_clkreg   <= clkreg;
		r_clocking <= clocking;
		r_done     <= done;
		r_count    <= count;
	end

	always_ff @(posedge clk)
		comp <= FIRST_INSTR - swin[5:0];

	always_ff @(posedge clk) begin
		if (!ncs && !nwr && adr_in == 'h1ff) /* display what GameBoy writes to 0x1ff */
			ledreg <= data_in;

		if (btnin[0])
			ledreg <= 8'haa;
	end

endmodule

