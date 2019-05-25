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

(* nolatches *)
(* top *)
module top(
		input  wire        clk12m,    /* 12 MHz clock input */
		output wire        clkout,
		output wire        clkoe,
		output wire        clkdir,
		output wire        boe,
		output wire        bdir,
		input  wire [14:0] adr,
		inout  wire [7:0]  data,
		input  wire        n_read,
		input  wire        n_write,
		input  wire        n_cs,      /* A15 */
		inout  wire        n_reset,
		input  wire [15:0] sw,
		output wire [15:0] led,
		input  wire [3:0]  btn,
	);

	wire        clk;
	wire [14:0] adr_in;
	reg  [7:0]  data_out;
	wire [7:0]  data_in;
	wire        data_drv;
	wire        nrd;
	wire        nwr;
	wire        ncs;
	reg  [7:0]  rdrom;
	wire [15:0] swin;
	wire [3:0]  btnin;

	reg  [3:0]  clkreg,   r_clkreg = 0;
	reg  [31:0] count,    r_count = 0;
	reg  [31:0] r100_at,  r_r100_at = 0;
	reg         r100,     r_r100 = 0;
	reg         clocking, r_clocking = 0;

	reg  [15:0] ledreg = 0;
	reg  [1:0]  ledstate = 0;

	reg  [7:0]  rom[0:127];
	initial $readmemh("rom.hex", rom, 0, 127);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) adr_io[14:0] (
			.PACKAGE_PIN(adr),
			.INPUT_CLK(clk),
			.D_IN_0(adr_in),
		);

	SB_IO #(
			.PIN_TYPE('b 1101_00),
			.PULLUP(1),
		) data_io[7:0] (
			.PACKAGE_PIN(data),
			.OUTPUT_CLK(clk),
			.INPUT_CLK(clk),
			.OUTPUT_ENABLE(data_drv),
			.D_OUT_0(data_out),
			.D_IN_0(data_in),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) n_read_io (
			.PACKAGE_PIN(n_read),
			.INPUT_CLK(clk),
			.D_IN_0(nrd),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) n_write_io (
			.PACKAGE_PIN(n_write),
			.INPUT_CLK(clk),
			.D_IN_0(nwr),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) n_cs_io (
			.PACKAGE_PIN(n_cs),
			.INPUT_CLK(clk),
			.D_IN_0(ncs),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) sw_io[15:0] (
			.PACKAGE_PIN(sw),
			.INPUT_CLK(clk),
			.D_IN_0(swin),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) btn_io[3:0] (
			.PACKAGE_PIN(btn),
			.INPUT_CLK(clk),
			.D_IN_0(btnin),
		);

	SB_IO #(
			.PIN_TYPE('b 1101_00),
			.PULLUP(1),
		) n_reset_io (
			.PACKAGE_PIN(n_reset),
			.OUTPUT_CLK(clk),
			.OUTPUT_ENABLE(btnin[0]),
			.D_OUT_0(0),
		);

	pll pll_inst(
		.clock_in(clk12m),
		.clock_out(clk),
	);

	assign clkoe    = 0;
	assign clkdir   = 1;

	assign boe      = 0;
	assign bdir     = data_drv;

	assign data_drv = !nrd && !ncs;

	assign led      = ledreg;
	assign clkout   = r_clkreg[3];

	always @(posedge clk)
		rdrom <= rom[adr_in[6:0]];

	always @(posedge clk)
		data_out <= rdrom;

	always @(posedge clk) begin
		clkreg   = r_clkreg;
		count    = r_count;
		r100_at  = r_r100_at;
		r100     = r_r100;
		clocking = r_clocking;

		if (btnin[1])
			clocking = 1;

		if (r_clocking)
			clkreg = r_clkreg + 1;

		if (!clkout && clkreg[3]) begin
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

	always @(posedge clk) begin
		r_clkreg   <= clkreg;
		r_count    <= count;
		r_r100_at  <= r100_at;
		r_r100     <= r100;
		r_clocking <= clocking;
	end

	always @(posedge r_count[20]) begin
		case (ledstate)
			0: ledreg <= { 8'b10000000, r_r100_at[31:24] };
			1: ledreg <= { 8'b01000000, r_r100_at[23:16] };
			2: ledreg <= { 8'b00100000, r_r100_at[15:8] };
			3: ledreg <= { 8'b00010000, r_r100_at[7:0] };
		endcase
		ledstate <= ledstate + 1;
	end

endmodule

