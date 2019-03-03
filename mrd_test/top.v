`default_nettype none

(* nolatches *)
(* top *)
module top(
		input  wire       clk12m,    /* 12 MHz clock input */
		input  wire [6:0] adr,
		inout  wire [7:0] data,
		input  wire       n_read,
		input  wire       n_write,
		input  wire       n_cs,
		input  wire [7:0] sw,
		output wire [7:0] led,
	);

	wire       clk;
	wire [6:0] adr_in;
	reg  [7:0] data_out;
	wire [7:0] data_in;
	wire       data_drv;
	wire       wrff;
	wire       nrd;
	wire       nwr;
	wire       ncs;
	wire [7:0] comp;
	reg  [7:0] rdrom;

	reg  [7:0] ff;
	reg  [7:0] count;
	reg        r_wrff;

	reg  [7:0] rom[0:127];
	initial $readmemh("rom.hex", rom, 0, 127);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) adr_io[6:0] (
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
			.D_IN_0(comp),
		);

	pll pll_inst(
		.clock_in(clk12m),
		.clock_out(clk),
	);

	assign led      = ff;
	assign wrff     = !nwr && !ncs && &adr_in;
	assign data_drv = !nrd && !ncs;

	always @(posedge clk) begin
		ff <= (!wrff && r_wrff) ? data_in : ff;
		r_wrff <= wrff;
	end

	always @(posedge clk)
		count <= !wrff ? count + 1 : 0;

	always @(posedge clk)
		rdrom <= rom[adr_in];

	always @(posedge clk)
		data_out <= &adr_in ? {8{count > comp}} : rdrom;

endmodule

