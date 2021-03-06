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
 *
 * Startup:
 * 1. Switch off GameBoy and FPGA board (unplug USB).
 * 2. Power up FPGA.
 * 3. Switch on GameBoy. It won't start because it doesn't get clocked yet.
 * 5. Press SW1. GameBoy should start running.
 * 6. After the chime, the number of clocks until the GameBoy reads address
 *    0x100 is displayed on LEDs 0-7. These are four bytes that get repeatedly
 *    cycled through. LEDs 12-15 tell which of the four bytes is currently
 *    displayed by LEDs 0-7.
 *
 * There mustn't be anything connected to the reset line of the GameBoy. The
 * result seems to always differ by a few clocks if the reset line is messed
 * with. Leave it open. The clock wire must be kept short (~10cm). Unplug the
 * jumpers of all unused components of the FPGA board. If too many components
 * on the board are active or the wire is too long, it also causes the results
 * to differ by a few clocks. The clock input of the GameBoy is very
 * sensitive to small voltage fluctuations.
 */

parameter int CLKREG_WIDTH = 4;

/* Only show the least significant 15 bits of the counter instead of cycling
 * through each byte. */
parameter bit ONLY15 = 1;

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
		output logic            t1,
		output logic            t2
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

	logic [31:0] count,    r_count = 0;
	logic [31:0] r100_at,  r_r100_at = 0;
	logic        r100,     r_r100 = 0;
	logic        clocking, r_clocking = 0;

	logic [15:0] ledreg = 0;
	logic [1:0]  ledstate = 0;

	logic [7:0]  rom[0:127];
	initial $readmemh("rom.hex", rom, 0, 127);

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

	assign led      = ONLY15 ? { r_count[20], r_r100_at[14:0] } : ledreg;
	assign clkout   = r_clkreg[CLKREG_WIDTH-1];

	assign t1       = btnin[2] && btnin[3] || swin[14];
	assign t2       = btnin[2] && btnin[3] || swin[15];

	always_ff @(posedge clk)
		rdrom <= rom[adr_in[6:0]];

	always_ff @(posedge clk)
		data_out <= rdrom;

	always_comb begin
		clkreg   = r_clkreg;
		count    = r_count;
		r100_at  = r_r100_at;
		r100     = r_r100;
		clocking = r_clocking;

		if (btnin[1])
			clocking = 1;

		if (r_clocking)
			clkreg = r_clkreg + 1;

		if (!clkout && clkreg[CLKREG_WIDTH-1]) begin
			if (!r_r100 && !nrd && !ncs && adr_in == 'h100) begin
				r100    = 1;
				r100_at = r_count;
			end

			count = r_count + 1;
		end

		/* Stop the clock only when the total amount of ticks the gameboy got
		 * is dividable by four (but add up to 3 extra ticks set by DIP
		 * switches). */
		if (btnin[2] && (r_count[1:0] != swin[9:8] && count[1:0] == swin[9:8]))
			clocking = 0;

		if (btnin[0]) begin
			clocking = 0;
			count    = 0;
			clkreg   = 0;
			r100     = 0;
			r100_at  = 0;
		end
	end

	always_ff @(posedge clk) begin
		r_clkreg   <= clkreg;
		r_count    <= count;
		r_r100_at  <= r100_at;
		r_r100     <= r100;
		r_clocking <= clocking;
	end

	always_ff @(posedge r_count[20]) begin
		case (ledstate)
			0: ledreg <= { 8'b10000000, r_r100_at[31:24] };
			1: ledreg <= { 8'b01000000, r_r100_at[23:16] };
			2: ledreg <= { 8'b00100000, r_r100_at[15:8] };
			3: ledreg <= { 8'b00010000, r_r100_at[7:0] };
		endcase
		ledstate <= ledstate + 1;
	end

endmodule

