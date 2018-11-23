`default_nettype none

(* nolatches *)
(* top *)
module top(
		input  wire       clk12m,    /* 12 MHz clock input */
		output wire       clkout,
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
	wire [7:0] data_out;
	wire [7:0] data_in;
	wire       data_drv;
	wire       nrd;
	wire       nwr;
	wire       ncs;
	wire [7:0] rdrom;
	wire [7:0] swin;

	reg  [3:0]  clkreg = 0;
	reg  [31:0] count = 0;
	reg  [31:0] r100_at = 0;
	reg         r100 = 0;
	reg  [7:0]  ledreg = 8'haa;
	reg  [2:0]  ledstate = 0;
	reg         clocking = 0;

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

	always @(posedge clk) if (clocking)
		clkreg <= clkreg + 1;

	always @(posedge clkout)
		count <= count + 1;

	always @(posedge clkout) if (!r100 && !nrd && !ncs && !adr_in) begin
		r100    <= 1;
		r100_at <= count;
	end

	always @(posedge count[20]) begin
		case (ledstate)
			0: ledreg <= 8'h88;
			1: ledreg <= 8'h44;
			2: ledreg <= 8'h22;
			3: ledreg <= 8'h11;
			4: ledreg <= r100_at[31:24];
			5: ledreg <= r100_at[23:16];
			6: ledreg <= r100_at[15:8];
			7: ledreg <= r100_at[7:0];
		endcase
		ledstate <= ledstate + 1;
	end

endmodule

