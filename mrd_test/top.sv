`default_nettype none

(* nolatches *)
(* top *)
module top(
		input  logic            clk12m,    /* 12 MHz clock input */
		output logic            boe,
		output logic            bdir,
		input  logic     [14:0] adr,
		inout  tri logic [7:0]  data,
		input  logic            n_read,
		input  logic            n_write,
		input  logic            n_cs,      /* A15 */
		inout  logic            n_reset,
		input  logic     [15:0] sw,
		output logic     [15:0] led,
		output logic     [3:0]  btn
	);

	logic        clk;
	logic [14:0] adr_in;
	logic [7:0]  data_out;
	logic [7:0]  data_in;
	logic        data_drv;
	logic        wrff;
	logic        nrd;
	logic        nwr;
	logic        ncs;
	logic [7:0]  comp;
	logic [7:0]  rdrom;
	logic [15:0] swin;
	logic [3:0]  btnin;

	logic [7:0]  ff;
	logic [7:0]  count;
	logic        r_wrff;

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
			.OUTPUT_ENABLE(btnin[0]),
			.D_OUT_0('0)
		);

	pll pll_inst(
		.clock_in(clk12m),
		.clock_out(clk)
	);

	assign boe      = 0;
	assign bdir     = data_drv;

	assign comp     = swin[7:0];

	assign led      = ff;
	assign wrff     = !nwr && !ncs && adr_in == 'hff;
	assign data_drv = !nrd && !ncs;

	always_ff @(posedge clk) begin
		ff <= (!wrff && r_wrff) ? data_in : ff;
		r_wrff <= wrff;
	end

	always_ff @(posedge clk)
		count <= !wrff ? count + 1 : 0;

	always_ff @(posedge clk)
		rdrom <= rom[adr_in[6:0]];

	always_ff @(posedge clk)
		data_out <= adr_in == 'hff ? {8{count > comp}} : rdrom;

endmodule

