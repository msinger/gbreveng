`default_nettype none

(* nolatches *)
(* top *)
module test_hw(
		input  logic        clk12m,        /* 12 MHz clock input */
		input  logic        clk16m,        /* 16 MiHz clock input */
		output logic        clk16m_en,     /* 16 MiHz clock enable */

		output logic [15:0] led,
		input  logic [15:0] sw,
		input  logic [3:0]  btn,

		inout  logic [7:0]  ft245_d,
		input  logic        ft245_n_rxf,
		input  logic        ft245_n_txe,
		output logic        ft245_n_rd,
		output logic        ft245_n_wr,
		output logic        ft245_siwu,

		output logic        chl,           /* left audio PWM channel */
		output logic        chr,           /* right audio PWM channel */
		output logic        chm,           /* mono audio PWM channel */

		input  logic        p10,
		input  logic        p11,
		input  logic        p12,
		input  logic        p13,
		input  logic        p14,
		input  logic        p15,

		output logic [20:0] madr,
		inout  logic [7:0]  mdata,
		output logic        n_mrd,
		output logic        n_mwr,
		output logic        n_prog,
		output logic        n_mcs_rom,
		output logic        n_mcs_xram,
		output logic        n_mcs_wram,
		output logic        n_mcs_crom,
		output logic        n_mcs_cram,
		output logic        mphi,
		inout  logic        n_mreset,
		output logic        n_moe,
		output logic        n_moed,
		output logic        mdir,

		input  logic [14:0] adr,
		inout  logic [7:0]  data,
		input  logic        n_rd,
		input  logic        n_wr,
		input  logic        n_cs_rom,
		input  logic        n_cs_xram,
		input  logic        phi,
		inout  logic        n_reset,
		output logic        n_soe,
		output logic        sdir,

		output logic [13:0] vadr,
		inout  logic [7:0]  vdata,
		output logic        n_vrd,
		output logic        n_vwr,
		output logic        n_vcs,

		inout  logic [7:0]  pa,
		output logic        n_pa_oe,
		output logic        pa_dir,

		inout  logic [7:0]  pb,
		output logic        n_pb_oe,
		output logic        pb_dir,

		input  logic        sin,
		output logic        sout,

		input  logic        sd_sw,
		input  logic        sd_clk,
		input  logic        sd_cmd,
		input  logic [3:0]  sd_data,

		output logic        lcd_hsync,
		output logic        lcd_vsync,
		output logic        lcd_latch,
		output logic        lcd_altsig,
		output logic        lcd_ctrl,
		output logic        lcd_clk,
		output logic [1:0]  lcd_data,
	);

	logic pllclk;

	logic [7:0] ft245_d_out, ft245_d_in;
	logic       ft245_dir_out;

	SB_IO #(
			.PIN_TYPE('b 1101_00),
			.PULLUP(1),
		) ft245_d_io[7:0] (
			.PACKAGE_PIN(ft245_d),
			.OUTPUT_CLK(clk12m),
			.INPUT_CLK(clk12m),
			.OUTPUT_ENABLE(ft245_dir_out),
			.D_OUT_0(ft245_d_out),
			.D_IN_0(ft245_d_in),
		);

	SB_PLL40_CORE #(
			.FEEDBACK_PATH("SIMPLE"),
			.DIVR(0),
			.DIVF(55),
			.DIVQ(5),
			.FILTER_RANGE(1),
		) pll0 (
			.RESETB(1),
			.BYPASS(0),
			.REFERENCECLK(clk12m),
			.PLLOUTCORE(pllclk),
		);

	logic [23:0] cyc;
	logic [20:0] cyc16;
	logic [20:0] cycpll;

	always_ff @(posedge clk12m) cyc++;
	always_ff @(posedge clk16m) cyc16++;
	always_ff @(posedge pllclk) cycpll++;

	always_ff @(posedge clk12m) clk16m_en = cyc[23];

	localparam MA   = 0;
	localparam MAW  = 21;
	localparam MAE  = MA + MAW - 1;
	localparam SA   = MA + MAW;
	localparam SAW  = 15;
	localparam SAE  = SA + SAW - 1;
	localparam PXX  = SA + SAW;
	localparam PXXW = 6;
	localparam PXXE = PXX + PXXW - 1;
	localparam LCD  = PXX + PXXW;
	localparam LCDW = 8;
	localparam LCDE = LCD + LCDW - 1;
	localparam PXXT = LCD + LCDW;
	localparam LCDT = PXXT + 1;
	localparam SW   = LCDT + 1;
	localparam SE   = SW - 1;

	logic [SE:0] sr[0:511];
	logic [SE:0] s;

	initial begin :init_sr
		logic   [SE:0] t;
		integer        i;

		for (i = 0; i < 512; i++)
			sr[i] = 0;

		/*
		 * For testing p10-p15 place the following jumper:
		 *   J14: +-+
		 *        |*|* *
		 *        |#|* *
		 *        +-+
		 * and make the following connections:
		 *       J12 or J13   J7
		 *  Pin    6 (ma0)    1 (p10)
		 *  Pin    7 (ma1)    2 (p11)
		 *  Pin    8 (ma2)    3 (p12)
		 *  Pin    9 (ma3)    6 (p13)
		 *  Pin   10 (ma4)    7 (p14)
		 *  Pin   11 (ma5)    8 (p15)
		 *
		 * For testing the LCD pins place the following jumpers:
		 *   J19: +-+       J3: +-+
		 *        |*|* *        |*|* *
		 *        |#|* *        |#|* *
		 *        +-+           +-+
		 * and make the following connections:
		 *       J18         J6
		 *  Pin   6 (sa0)    13 (alt;   lcd4)
		 *  Pin   7 (sa1)    12 (vsync; lcd6)
		 *  Pin   8 (sa2)    15 (d1;    lcd1)
		 *  Pin   9 (sa3)    14 (clk;   lcd2)
		 *  Pin  10 (sa4)    17 (hsync; lcd7)
		 *  Pin  11 (sa5)    16 (d0;    lcd0)
		 *  Pin  12 (sa6)    19 (ctrl;  lcd3)
		 *  Pin  13 (sa7)    18 (latch; lcd5)
		 */
		t           = 0;
		t[MAE:MA]   =    'b010101;
		t[LCDE:LCD] =              'b10101010;
		sr[0]       = t;
		t           = 0;
		t[PXXE:PXX] =    'b010101;
		t[SAE:SA]   =              'b11010100;
		t[PXXT]     = 1;
		t[LCDT]     = 1;
		t[MAE:MA]   =    'b101010;
		t[LCDE:LCD] =              'b01010101;
		sr[1]       = t;
		t           = 0;
		t[PXXE:PXX] =    'b101010;
		t[SAE:SA]   =              'b00101011;
		t[PXXT]     = 1;
		t[LCDT]     = 1;
		t[MAE:MA]   =    'b000011;
		t[LCDE:LCD] =              'b01010100;
		sr[2]       = t;
		t           = 0;
		t[PXXE:PXX] =    'b000011;
		t[SAE:SA]   =              'b00001011;
		t[PXXT]     = 1;
		t[LCDT]     = 1;
		t[MAE:MA]   =    'b111100;
		t[LCDE:LCD] =              'b01010001;
		sr[3]       = t;
		t           = 0;
		t[PXXE:PXX] =    'b111100;
		t[SAE:SA]   =              'b00100011;
		t[PXXT]     = 1;
		t[LCDT]     = 1;
		sr[4]       = t;
	end

	logic [8:0] c = cyc[12:4];
	logic       d = cyc[3:0] == 4;

	always_ff @(posedge clk12m) s = sr[c];

	logic [5:0] pxx_good, pxx_led;
	logic [7:0] lcd_good, lcd_led;

	always_ff @(posedge clk12m) if (d) begin
		if (&c) begin
			pxx_led  = pxx_good;
			pxx_good = 'h3f;
			lcd_led  = lcd_good;
			lcd_good = 'hff;
		end
		if (s[PXXT]) begin
			pxx_good &= ~s[PXXE:PXX] ^ { p15, p14, p13, p12, p11, p10 };
		end
		if (s[LCDT]) begin
			lcd_good &= ~s[SA+7:SA] ^ adr[7:0];
		end
		madr = s[MAE:MA];
		lcd_hsync  = s[LCD+7];
		lcd_vsync  = s[LCD+6];
		lcd_latch  = s[LCD+5];
		lcd_altsig = s[LCD+4];
		lcd_ctrl   = s[LCD+3];
		lcd_clk    = s[LCD+2];
		lcd_data   = s[LCD+1:LCD];
	end

	logic [7:0] led_mode = 0;

	always_ff @(posedge clk12m) if (btn[0]) led_mode = sw[7:0];

	always_comb case (led_mode)
	0: begin
		led[15] = cyc[19];
		led[14] = cyc16[20];
		led[13] = cycpll[20];
		led[12] = btn[1];
		led[11] = btn[2];
		led[10] = btn[3];
		led[9:2] = 0;
		led[1]  = &lcd_led;
		led[0]  = &pxx_led;
	end
	1: begin
		led = sw;
	end
	2: begin
		led[15:8] = lcd_led;
		led[7:6]  = 0;
		led[5:0]  = pxx_led;
	end
	default: begin
		led[15:0] = 0;
	end
	endcase

endmodule
