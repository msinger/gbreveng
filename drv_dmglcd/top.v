`default_nettype none

`define width  160
`define height 144

`define first_px 95

(* nolatches *)
(* top *)
module top(
		input  wire        clk16m,
		output wire        clk16m_en,
		output wire [15:0] led,
		input  wire [15:0] sw,
		input  wire [3:0]  btn,

		output reg  [1:0]  lcd_d,
		output reg         lcd_clk,
		output reg         lcd_hsync,
		output reg         lcd_vsync,
		output reg         lcd_latch,
		output reg         lcd_pol,
		output reg         lcd_tim,

		output wire        p10
	);

	reg  [1:0] d;
	reg        pclk;
	reg        hsync;
	reg        vsync;
	reg        latch;
	reg        pol;
	reg        tim;

	reg        clk;

	reg        r_fe  = 0, fe;
	reg  [8:0] r_cyc = 0, cyc;
	reg  [7:0] r_ly  = 0, ly;

	wire [7:0] ix;
	wire [1:0] px;

	assign clk16m_en = 1;

	assign led = r_cyc;

	assign p10 = !r_fe;

	assign ix = cyc - `first_px;

	img #(
		.width(`width),
		.height(`height)
	) image(
		.x(ix),
		.y(ly),
		.value(px)
	);

	always @* begin
		d     = lcd_d;
		pclk  = lcd_clk;
		hsync = lcd_hsync;
		vsync = lcd_vsync;
		latch = lcd_latch;
		pol   = lcd_pol;
		tim   = lcd_tim;
		cyc   = r_cyc;
		ly    = r_ly;

		fe = !r_fe;
		if (!fe)
			cyc = cyc + 1;
		if (cyc == 456) begin
			cyc = 0;
			ly  = ly + 1;
		end
		if (ly == 154)
			ly  = 0;

		if (fe && cyc == 0) begin
			latch = 1;
			tim   = 1;
		end
		if (fe && cyc == 2 && ly == `height)
			pol   = !pol;
		if (fe && cyc == 4) begin
			latch = 0;
			pol   = !pol;
		end
		if (fe && cyc == 6)
			vsync = ly == 0;
		if (fe && cyc == 8)
			tim   = 0;
		if (fe && cyc == 32)
			tim   = 1;
		if (fe && cyc == 36)
			tim   = 0;
		if (fe && cyc == 81 && ly < `height)
			hsync = 1;
		if (!fe && cyc == 88 && ly < `height)
			pclk  = 1;
		if (fe && cyc == 88)
			pclk  = 0;
		if (!fe && cyc == 96)
			hsync = 0;
		if (fe && cyc == 184)
			tim   = 1;
		if (fe && cyc == 188)
			tim   = 0;
		if (fe && cyc == 336)
			tim   = 1;
		if (fe && cyc == 340)
			tim   = 0;

		if (fe && cyc >= `first_px && cyc < `first_px + `width && ly < `height)
			d = px;

		if (!fe && cyc > `first_px && cyc < `first_px + `width && ly < `height)
			pclk = 0;
		if (fe && cyc > `first_px && cyc < `first_px + `width - 1 && ly < `height)
			pclk = 1;
	end

	always @(posedge clk16m)
		clk <= !clk;

	always @(posedge clk) begin
		lcd_d     <= d;
		lcd_clk   <= pclk;
		lcd_hsync <= hsync;
		lcd_vsync <= vsync;
		lcd_latch <= latch;
		lcd_pol   <= pol;
		lcd_tim   <= tim;

		r_fe  <= fe;
		r_cyc <= cyc;
		r_ly  <= ly;
	end

endmodule
