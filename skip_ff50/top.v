`default_nettype none

/*
 * Prepare GameBoy:
 * 1. Desolder quartz and both capacitors from GameBoy CPU board. (The 1 meg
 *    resistor may stay.)
 * 2. Wire your FPGA clock output to DMG pin 73 (X0). This is the oscillator
 *    output. Input pin 74 (X1) won't work! DMG seems to get its internal
 *    clock from the amplified output pin. If we attach to the input, the
 *    signal seems to get too washed up at the output when passing through the
 *    amplifier. Voltage range must be 0-5V. I used Nexperia 74LVCH8T245PW as
 *    voltage translator. Drive as hard as possible (no resistor between the
 *    outputs).
 * 3. Leave clock input pin 74 open. Do not attach any probes to it! For some
 *    reason, when it's open, it won't override the output. My GameBoy won't
 *    boot if something is attached to pin 74 while I'm raping pin 73.
 *
 * Startup:
 * 1. Switch off GameBoy and FPGA board (unplug USB).
 * 2. Set switch inputs on FPGA to LXXLHHLH (from bit 7 to bit 0; X = don't
 *    care). Bits 4-0 represent the value 13. This gets substracted from the
 *    FIRST_INSTR clock ticks defined below. These bits can be used for fine
 *    tuning the exact clock tick when to start overclocking.
 * 3. Power up FPGA.
 * 4. Switch on GameBoy. It won't start because it doesn't get clocked yet.
 * 5. Flip bit 7 of switch inputs to high. GameBoy should start running.
 * 6. After the chime, the first byte of the boot ROM should be displayed by
 *    the LEDs (00110001).
 */

/* Number of clock ticks until first instruction at 0x100 gets fetched. */
`define FIRST_INSTR 23_571_404

/* Bit-widtth of clock tick counter. FIRST_INSTR needs to fit in there. */
`define COUNTER_WIDTH 25

(* nolatches *)
(* top *)
module top(
		input  wire       clk12m,    /* 12 MHz clock input */
		output wire       clkout,
		input  wire [8:0] adr,
		inout  wire [7:0] data,
		input  wire       n_read,
		input  wire       n_write,
		input  wire       n_cs,
		input  wire [7:0] sw,
		output wire [7:0] led,
	);

	wire       clk;
	wire [8:0] adr_in;
	wire [7:0] data_out;
	wire [7:0] data_in;
	wire       data_drv;
	wire       nrd;
	wire       nwr;
	wire       ncs;
	wire [7:0] rdrom;
	wire [7:0] swin;

	reg  [3:0] clkreg = 0;
	reg  [7:0] ledreg = 8'haa;
	reg        clocking = 0;
	reg  [5:0] done = 0;

	reg [`COUNTER_WIDTH-1:0] count = 0;
	reg [`COUNTER_WIDTH-1:0] comp = 0;

	reg  [7:0] rom[0:511];
	initial $readmemh("rom.hex", rom, 0, 511);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) adr_io[8:0] (
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
		) sw_io[7:0] (
			.PACKAGE_PIN(sw),
			.INPUT_CLK(clk),
			.D_IN_0(swin),
		);

	pll pll_inst(
		.clock_in(clk12m),
		.clock_out(clk),
	);

	assign data_drv = !nrd && !ncs;

	assign led      = ledreg;
	assign clkout   = clkreg[3];

	always @(posedge clk)
		rdrom <= rom[adr_in];

	always @(posedge clk)
		data_out <= rdrom;

	always @(posedge clk) if (swin[7])
		clocking <= 1;

	always @(posedge clk) if (clocking) begin
		if ((done == 0 && count == comp) || (done != 0 && done != 32)) begin
			clkreg <= ~clkreg;
			done <= done + 1;
		end else
			clkreg <= clkreg + 1;
	end

	always @(posedge clkout)
		count <= count + 1;

	always @(posedge clk)
		comp <= `FIRST_INSTR - swin[4:0];

	always @(posedge clk) if (!ncs && !nwr && adr_in == 'h1ff)
		ledreg = data_in;
endmodule

