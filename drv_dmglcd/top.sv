`default_nettype none

(* nolatches *)
(* top *)
module top(
		input  logic        clk16m,
		output logic        clk16m_en,
		output logic [15:0] led,
		input  logic [15:0] sw,
		input  logic [3:0]  btn,

		output logic [1:0]  lcd_d,
		output logic        lcd_clk,
		output logic        lcd_hsync,
		output logic        lcd_vsync,
		output logic        lcd_latch,
		output logic        lcd_pol,
		output logic        lcd_tim,

		output logic        p10
	);

	localparam int width  = 160;
	localparam int height = 144;

	localparam int first_px = 95;

	logic [1:0] d;
	logic       pclk;
	logic       hsync;
	logic       vsync;
	logic       latch;
	logic       pol;
	logic       tim;

	logic       clk;

	logic       r_fe  = 0, fe;
	logic [8:0] r_cyc = 0, cyc;
	logic [7:0] r_ly  = 0, ly;

	logic [7:0] ix;
	logic [1:0] px;

	assign clk16m_en = 1;

	assign led = r_cyc;

	assign p10 = !r_fe;

	assign ix = cyc - first_px;

	img #(
		.width(width),
		.height(height)
	) image(
		.x(ix),
		.y(ly),
		.value(px)
	);

	always_comb begin
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
			cyc++;
		if (cyc == 456) begin
			cyc = 0;
			ly++;
		end
		if (ly == 154)
			ly  = 0;

		if (fe && cyc == 0) begin
			latch = 1;
			tim   = 1;
		end
		if (fe && cyc == 2 && ly == height)
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
		if (fe && cyc == 81 && ly < height)
			hsync = 1;
		if (!fe && cyc == 88 && ly < height)
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

		if (fe && cyc >= first_px && cyc < first_px + width && ly < height)
			d = px;

		if (!fe && cyc > first_px && cyc < first_px + width && ly < height)
			pclk = 0;
		if (fe && cyc > first_px && cyc < first_px + width - 1 && ly < height)
			pclk = 1;
	end

	always_ff @(posedge clk16m)
		clk <= !clk;

	always_ff @(posedge clk) begin
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
