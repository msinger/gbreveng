`default_nettype none

(* nolatches *)
(* top *)
module test_hw(
		input  logic            clk12m,        /* 12 MHz clock input */
		input  logic            clk16m,        /* 16 MiHz clock input */
		output logic            clk16m_en,     /* 16 MiHz clock enable */

		output logic     [15:0] led,
		input  logic     [15:0] sw,
		input  logic     [3:0]  btn,

		inout  tri logic [7:0]  ft245_d,
		input  logic            ft245_n_rxf,
		input  logic            ft245_n_txe,
		output logic            ft245_n_rd,
		output logic            ft245_n_wr,
		output logic            ft245_siwu,

		output logic            chl,           /* left audio PWM channel */
		output logic            chr,           /* right audio PWM channel */
		output logic            chm,           /* mono audio PWM channel */

		input  logic            p10,
		input  logic            p11,
		input  logic            p12,
		input  logic            p13,
		input  logic            p14,
		input  logic            p15,

		output logic     [20:0] madr,
		inout  tri logic [7:0]  mdata,
		output logic            n_mrd,
		output logic            n_mwr,
		output logic            n_prog,
		output logic            n_mcs_rom = 1,
		output logic            n_mcs_xram = 1,
		output logic            n_mcs_wram,
		output logic            n_mcs_crom,
		output logic            n_mcs_cram,
		output logic            mphi,
		inout  tri logic        n_mreset = 1,
		output logic            n_moe = 1,
		output logic            n_moed = 1,
		output logic            mdir,

		input  logic     [14:0] adr,
		inout  tri logic [7:0]  data,
		input  logic            n_rd,
		input  logic            n_wr,
		input  logic            n_cs_rom,
		input  logic            n_cs_xram,
		input  logic            phi,
		inout  tri logic        n_reset = 1,
		output logic            n_soe = 1,
		output logic            sdir,

		output logic     [13:0] vadr,
		inout  tri logic [7:0]  vdata,
		output logic            n_vrd,
		output logic            n_vwr,
		output logic            n_vcs,

		inout  tri logic [7:0]  pa,
		output logic            n_pa_oe = 1,
		output logic            pa_dir,

		inout  tri logic [7:0]  pb,
		output logic            n_pb_oe = 1,
		output logic            pb_dir,

		input  logic            sin,
		output logic            sout,

		input  logic            sd_sw,
		input  logic            sd_clk,
		input  logic            sd_cmd,
		input  logic     [3:0]  sd_data,

		output logic            lcd_hsync,
		output logic            lcd_vsync,
		output logic            lcd_latch,
		output logic            lcd_altsig,
		output logic            lcd_ctrl,
		output logic            lcd_clk,
		output logic     [1:0]  lcd_data
	);

	logic pllclk;

	logic [7:0] ft245_d_out, ft245_d_in;
	logic       ft245_dir_out;

	logic [7:0] md_out, md_in;
	logic       md_dir_out;

	logic [7:0] vd_out, vd_in;
	logic       vd_dir_out;

	SB_IO #(
			.PIN_TYPE('b 1101_00),
			.PULLUP(1)
		) ft245_d_io[7:0] (
			.PACKAGE_PIN(ft245_d),
			.OUTPUT_CLK(clk12m),
			.INPUT_CLK(clk12m),
			.OUTPUT_ENABLE(ft245_dir_out),
			.D_OUT_0(ft245_d_out),
			.D_IN_0(ft245_d_in)
		);

	SB_IO #(
			.PIN_TYPE('b 1101_00),
			.PULLUP(1)
		) mdata_io[7:0] (
			.PACKAGE_PIN(mdata),
			.OUTPUT_CLK(clk12m),
			.INPUT_CLK(clk12m),
			.OUTPUT_ENABLE(md_dir_out),
			.D_OUT_0(md_out),
			.D_IN_0(md_in)
		);

	SB_IO #(
			.PIN_TYPE('b 1101_00),
			.PULLUP(1)
		) vdata_io[7:0] (
			.PACKAGE_PIN(vdata),
			.OUTPUT_CLK(clk12m),
			.INPUT_CLK(clk12m),
			.OUTPUT_ENABLE(vd_dir_out),
			.D_OUT_0(vd_out),
			.D_IN_0(vd_in)
		);

	SB_PLL40_CORE #(
			.FEEDBACK_PATH("SIMPLE"),
			.DIVR(0),
			.DIVF(55),
			.DIVQ(5),
			.FILTER_RANGE(1)
		) pll0 (
			.RESETB('1),
			.BYPASS('0),
			.REFERENCECLK(clk12m),
			.PLLOUTCORE(pllclk)
		);

	logic [23:0] cyc;
	logic [20:0] cyc16;
	logic [20:0] cycpll;

	always_ff @(posedge clk12m) cyc    <= cyc    + 1;
	always_ff @(posedge clk16m) cyc16  <= cyc16  + 1;
	always_ff @(posedge pllclk) cycpll <= cycpll + 1;

	always_ff @(posedge clk12m) clk16m_en <= cyc[23];

	localparam int MA   = 0;
	localparam int MAW  = 21;
	localparam int MAE  = MA + MAW - 1;
	localparam int MD   = MA + MAW;
	localparam int MDW  = 8;
	localparam int MDE  = MD + MDW - 1;
	localparam int MDO  = MD + MDW;
	localparam int MDT  = MDO + 1;
	localparam int MRD  = MDT + 1;
	localparam int MWR  = MRD + 1;
	localparam int MPRG = MWR + 1;
	localparam int MSW  = MPRG + 1;
	localparam int MSCR = MSW + 1;
	localparam int MSCX = MSCR + 1;
	localparam int SA   = MSCX + 1;
	localparam int SAW  = 15;
	localparam int SAE  = SA + SAW - 1;
	localparam int VA   = SA + SAW;
	localparam int VAW  = 14;
	localparam int VAE  = VA + VAW - 1;
	localparam int VD   = VA + VAW;
	localparam int VDW  = 8;
	localparam int VDE  = VD + VDW - 1;
	localparam int VDO  = VD + VDW;
	localparam int VDT  = VDO + 1;
	localparam int VRD  = VDT + 1;
	localparam int VWR  = VRD + 1;
	localparam int VCS  = VWR + 1;
	localparam int PXX  = VCS + 1;
	localparam int PXXW = 6;
	localparam int PXXE = PXX + PXXW - 1;
	localparam int LCD  = PXX + PXXW;
	localparam int LCDW = 8;
	localparam int LCDE = LCD + LCDW - 1;
	localparam int PXXT = LCD + LCDW;
	localparam int LCDT = PXXT + 1;
	localparam int SW   = LCDT + 1;
	localparam int SE   = SW - 1;

	logic [SE:0] sr[0:511];
	logic [SE:0] s;

	initial begin
		logic [SE:0] t;

		for (int i = 0; i < 512; i++)
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

		/* Fill onboard ROM */
		t           = 0;
		t[MDO]      = 1;
		t[VDO]      = 1;
		t[MSCR]     = 1;
		t[MDE:MD]   = 'b01010101;
		sr[10]      = t;
		t[MPRG]     = 1;
		sr[11]      = t;
		t[MPRG]     = 0;
		sr[12]      = t;
		t[MDE:MD]   = 'b10101010;
		t[MAE:MA]   = 'h000001;
		sr[13]      = t;
		t[MPRG]     = 1;
		sr[14]      = t;
		t[MPRG]     = 0;
		sr[15]      = t;
		t[MDE:MD]   = 'b00110011;
		t[MAE:MA]   = 'h000002;
		sr[16]      = t;
		t[MPRG]     = 1;
		sr[17]      = t;
		t[MPRG]     = 0;
		sr[18]      = t;
		t[MDE:MD]   = 'b11001100;
		t[MAE:MA]   = 'h000004;
		sr[19]      = t;
		t[MPRG]     = 1;
		sr[20]      = t;
		t[MPRG]     = 0;
		sr[21]      = t;
		t[MDE:MD]   = 'b00001111;
		t[MAE:MA]   = 'h000008;
		sr[22]      = t;
		t[MPRG]     = 1;
		sr[23]      = t;
		t[MPRG]     = 0;
		sr[24]      = t;
		t[MDE:MD]   = 'b11110000;
		t[MAE:MA]   = 'h000010;
		sr[25]      = t;
		t[MPRG]     = 1;
		sr[26]      = t;
		t[MPRG]     = 0;
		sr[27]      = t;
		t[MDE:MD]   = 'hb0;
		t[MAE:MA]   = 'h000020;
		sr[28]      = t;
		t[MPRG]     = 1;
		sr[29]      = t;
		t[MPRG]     = 0;
		sr[30]      = t;
		t[MDE:MD]   = 'hb1;
		t[MAE:MA]   = 'h000040;
		sr[31]      = t;
		t[MPRG]     = 1;
		sr[32]      = t;
		t[MPRG]     = 0;
		sr[33]      = t;
		t[MDE:MD]   = 'hb2;
		t[MAE:MA]   = 'h000080;
		sr[34]      = t;
		t[MPRG]     = 1;
		sr[35]      = t;
		t[MPRG]     = 0;
		sr[36]      = t;
		t[MDE:MD]   = 'hb3;
		t[MAE:MA]   = 'h000100;
		sr[37]      = t;
		t[MPRG]     = 1;
		sr[38]      = t;
		t[MPRG]     = 0;
		sr[39]      = t;
		t[MDE:MD]   = 'hb4;
		t[MAE:MA]   = 'h000200;
		sr[40]      = t;
		t[MPRG]     = 1;
		sr[41]      = t;
		t[MPRG]     = 0;
		sr[42]      = t;
		t[MDE:MD]   = 'hb5;
		t[MAE:MA]   = 'h000400;
		sr[43]      = t;
		t[MPRG]     = 1;
		sr[44]      = t;
		t[MPRG]     = 0;
		sr[45]      = t;
		t[MDE:MD]   = 'hb6;
		t[MAE:MA]   = 'h000800;
		sr[46]      = t;
		t[MPRG]     = 1;
		sr[47]      = t;
		t[MPRG]     = 0;
		sr[48]      = t;
		t[MDE:MD]   = 'hb7;
		t[MAE:MA]   = 'h001000;
		sr[49]      = t;
		t[MPRG]     = 1;
		sr[50]      = t;
		t[MPRG]     = 0;
		sr[51]      = t;
		t[MDE:MD]   = 'hb8;
		t[MAE:MA]   = 'h002000;
		sr[52]      = t;
		t[MPRG]     = 1;
		sr[53]      = t;
		t[MPRG]     = 0;
		sr[54]      = t;
		t[MDE:MD]   = 'hb9;
		t[MAE:MA]   = 'h004000;
		sr[55]      = t;
		t[MPRG]     = 1;
		sr[56]      = t;
		t[MPRG]     = 0;
		sr[57]      = t;
		t[MDE:MD]   = 'hba;
		t[MAE:MA]   = 'h008000;
		sr[58]      = t;
		t[MPRG]     = 1;
		sr[59]      = t;
		t[MPRG]     = 0;
		sr[60]      = t;
		t[MDE:MD]   = 'hbb;
		t[MAE:MA]   = 'h010000;
		sr[61]      = t;
		t[MPRG]     = 1;
		sr[62]      = t;
		t[MPRG]     = 0;
		sr[63]      = t;
		t[MDE:MD]   = 'hbc;
		t[MAE:MA]   = 'h020000;
		sr[64]      = t;
		t[MPRG]     = 1;
		sr[65]      = t;
		t[MPRG]     = 0;
		sr[66]      = t;
		t[MDE:MD]   = 'hbd;
		t[MAE:MA]   = 'h040000;
		sr[67]      = t;
		t[MPRG]     = 1;
		sr[68]      = t;
		t[MPRG]     = 0;
		sr[69]      = t;
		t[MDE:MD]   = 'hbe;
		t[MAE:MA]   = 'h080000;
		sr[70]      = t;
		t[MPRG]     = 1;
		sr[71]      = t;
		t[MPRG]     = 0;
		sr[72]      = t;
		t[MDE:MD]   = 'hbf;
		t[MAE:MA]   = 'h100000;
		sr[73]      = t;
		t[MPRG]     = 1;
		sr[74]      = t;
		t[MPRG]     = 0;
		sr[75]      = t;
		/* Tick a 0 at ROM address 0 without write strobe */
		t[MDE:MD]   = 0;
		t[MAE:MA]   = 0;
		sr[76]      = t;
		/* Write strobe a 0 at ROM address 0 without chip select */
		t[MSCR]     = 0;
		sr[77]      = t;
		t[MPRG]     = 1;
		sr[78]      = t;
		t[MPRG]     = 0;
		sr[79]      = t;
		/* Fill onboard XRAM and VRAM */
		t[MSCX]     = 1;
		t[VCS]      = 1;
		t[MDE:MD]   = 'h40;
		t[VDE:VD]   = 'b01010101;
		sr[80]      = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[81]      = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[82]      = t;
		t[MDE:MD]   = 'h41;
		t[VDE:VD]   = 'b10101010;
		t[MAE:MA]   = 'h00001;
		t[VAE:VA]   = 'h0001;
		sr[83]      = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[84]      = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[85]      = t;
		t[MDE:MD]   = 'h42;
		t[VDE:VD]   = 'b00110011;
		t[MAE:MA]   = 'h00002;
		t[VAE:VA]   = 'h0002;
		sr[86]      = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[87]      = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[88]      = t;
		t[MDE:MD]   = 'h43;
		t[VDE:VD]   = 'b11001100;
		t[MAE:MA]   = 'h00004;
		t[VAE:VA]   = 'h0004;
		sr[89]      = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[90]      = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[91]      = t;
		t[MDE:MD]   = 'h44;
		t[VDE:VD]   = 'b00001111;
		t[MAE:MA]   = 'h00008;
		t[VAE:VA]   = 'h0008;
		sr[92]      = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[93]      = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[94]      = t;
		t[MDE:MD]   = 'h45;
		t[VDE:VD]   = 'b11110000;
		t[MAE:MA]   = 'h00010;
		t[VAE:VA]   = 'h0010;
		sr[95]      = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[96]      = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[97]      = t;
		t[MDE:MD]   = 'h46;
		t[VDE:VD]   = 'hb0;
		t[MAE:MA]   = 'h00020;
		t[VAE:VA]   = 'h0020;
		sr[98]      = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[99]      = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[100]     = t;
		t[MDE:MD]   = 'h47;
		t[VDE:VD]   = 'hb1;
		t[MAE:MA]   = 'h00040;
		t[VAE:VA]   = 'h0040;
		sr[101]     = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[102]     = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[103]     = t;
		t[MDE:MD]   = 'h48;
		t[VDE:VD]   = 'hb2;
		t[MAE:MA]   = 'h00080;
		t[VAE:VA]   = 'h0080;
		sr[104]     = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[105]     = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[106]     = t;
		t[MDE:MD]   = 'h49;
		t[VDE:VD]   = 'hb3;
		t[MAE:MA]   = 'h00100;
		t[VAE:VA]   = 'h0100;
		sr[107]     = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[108]     = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[109]     = t;
		t[MDE:MD]   = 'h4a;
		t[VDE:VD]   = 'hb4;
		t[MAE:MA]   = 'h00200;
		t[VAE:VA]   = 'h0200;
		sr[110]     = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[111]     = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[112]     = t;
		t[MDE:MD]   = 'h4b;
		t[VDE:VD]   = 'hb5;
		t[MAE:MA]   = 'h00400;
		t[VAE:VA]   = 'h0400;
		sr[113]     = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[114]     = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[115]     = t;
		t[MDE:MD]   = 'h4c;
		t[VDE:VD]   = 'hb6;
		t[MAE:MA]   = 'h00800;
		t[VAE:VA]   = 'h0800;
		sr[116]     = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[117]     = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[118]     = t;
		t[MDE:MD]   = 'h4d;
		t[VDE:VD]   = 'hb7;
		t[MAE:MA]   = 'h01000;
		t[VAE:VA]   = 'h1000;
		sr[119]     = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[120]     = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[121]     = t;
		t[MDE:MD]   = 'h4e;
		t[VDE:VD]   = 'hb8;
		t[MAE:MA]   = 'h10000;
		t[VAE:VA]   = 'h2000;
		sr[122]     = t;
		t[MWR]      = 1;
		t[VWR]      = 1;
		sr[123]     = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[124]     = t;
		t[MDE:MD]   = 'h4f;
		t[VDE:VD]   = 0;
		t[MAE:MA]   = 'h20000;
		t[VAE:VA]   = 0; /* Tick a 0 at VRAM address 0 without write strobe */
		sr[125]     = t;
		t[MWR]      = 1;
		sr[126]     = t;
		t[MWR]      = 0;
		sr[127]     = t;
		t[VCS]      = 0;
		t[MDE:MD]   = 'he0;
		t[MAE:MA]   = 'h40000;
		sr[128]     = t;
		t[MWR]      = 1;
		t[VWR]      = 1; /* Write strobe a 0 at VRAM address 0 without chip select */
		sr[129]     = t;
		t[MWR]      = 0;
		t[VWR]      = 0;
		sr[130]     = t;
		t[MDE:MD]   = 'he1;
		t[MAE:MA]   = 'h80000;
		sr[131]     = t;
		t[MWR]      = 1;
		sr[132]     = t;
		t[MWR]      = 0;
		sr[133]     = t;
		/* Tick a 0 at XRAM address 0 without write strobe */
		t[MDE:MD]   = 0;
		t[MAE:MA]   = 0;
		sr[134]     = t;
		/* Write strobe a 0 at XRAM address 0 without chip select */
		t[MSCX]     = 0;
		sr[135]     = t;
		t[MWR]      = 1;
		sr[136]     = t;
		t[MWR]      = 0;
		sr[137]     = t;
		/* Write one byte of WRAM to test its CS */
		t           = 0;
		t[MDO]      = 1;
		t[MSW]      = 1;
		t[MDE:MD]   = 'h7a;
		t[MAE:MA]   = 'h04000; /* WRAM has second chip select on A14 */
		sr[138]     = t;
		t[MWR]      = 1;
		sr[139]     = t;
		t[MWR]      = 0;
		sr[140]     = t;
		/* Tick a 0 at WRAM address 0 without write strobe */
		t[MDE:MD]   = 0;
		sr[141]     = t;
		/* Write strobe a 0 at WRAM address 0 without chip select */
		t[MSW]      = 0;
		sr[142]     = t;
		t[MWR]      = 1;
		sr[143]     = t;
		t[MWR]      = 0;
		sr[144]     = t;
		/* Read back onboard ROM */
		t           = 0;
		t[MSCR]     = 1;
		sr[160]     = t;
		t[MRD]      = 1;
		sr[161]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'b01010101;
		t[MDT]      = 1;
		sr[162]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h000001;
		sr[163]     = t;
		t[MRD]      = 1;
		sr[164]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'b10101010;
		t[MDT]      = 1;
		sr[165]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h000002;
		sr[166]     = t;
		t[MRD]      = 1;
		sr[167]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'b00110011;
		t[MDT]      = 1;
		sr[168]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h000004;
		sr[169]     = t;
		t[MRD]      = 1;
		sr[170]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'b11001100;
		t[MDT]      = 1;
		sr[171]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h000008;
		sr[172]     = t;
		t[MRD]      = 1;
		sr[173]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'b00001111;
		t[MDT]      = 1;
		sr[174]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h000010;
		sr[175]     = t;
		t[MRD]      = 1;
		sr[176]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'b11110000;
		t[MDT]      = 1;
		sr[177]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h000020;
		sr[178]     = t;
		t[MRD]      = 1;
		sr[179]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hb0;
		t[MDT]      = 1;
		sr[180]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h000040;
		sr[181]     = t;
		t[MRD]      = 1;
		sr[182]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hb1;
		t[MDT]      = 1;
		sr[183]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h000080;
		sr[184]     = t;
		t[MRD]      = 1;
		sr[185]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hb2;
		t[MDT]      = 1;
		sr[186]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h000100;
		sr[187]     = t;
		t[MRD]      = 1;
		sr[188]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hb3;
		t[MDT]      = 1;
		sr[189]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h000200;
		sr[190]     = t;
		t[MRD]      = 1;
		sr[191]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hb4;
		t[MDT]      = 1;
		sr[192]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h000400;
		sr[193]     = t;
		t[MRD]      = 1;
		sr[194]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hb5;
		t[MDT]      = 1;
		sr[195]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h000800;
		sr[196]     = t;
		t[MRD]      = 1;
		sr[197]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hb6;
		t[MDT]      = 1;
		sr[198]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h001000;
		sr[199]     = t;
		t[MRD]      = 1;
		sr[200]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hb7;
		t[MDT]      = 1;
		sr[201]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h002000;
		sr[202]     = t;
		t[MRD]      = 1;
		sr[203]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hb8;
		t[MDT]      = 1;
		sr[204]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h004000;
		sr[205]     = t;
		t[MRD]      = 1;
		sr[206]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hb9;
		t[MDT]      = 1;
		sr[207]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h008000;
		sr[208]     = t;
		t[MRD]      = 1;
		sr[209]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hba;
		t[MDT]      = 1;
		sr[210]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h010000;
		sr[211]     = t;
		t[MRD]      = 1;
		sr[212]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hbb;
		t[MDT]      = 1;
		sr[213]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h020000;
		sr[214]     = t;
		t[MRD]      = 1;
		sr[215]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hbc;
		t[MDT]      = 1;
		sr[216]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h040000;
		sr[217]     = t;
		t[MRD]      = 1;
		sr[218]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hbd;
		t[MDT]      = 1;
		sr[219]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h080000;
		sr[220]     = t;
		t[MRD]      = 1;
		sr[221]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hbe;
		t[MDT]      = 1;
		sr[222]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h100000;
		sr[223]     = t;
		t[MRD]      = 1;
		sr[224]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'hbf;
		t[MDT]      = 1;
		sr[225]     = t;
		/* Read back onboard XRAM and VRAM */
		t           = 0;
		t[MSCX]     = 1;
		t[VCS]      = 1;
		sr[226]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[227]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h40;
		t[VDE:VD]   = 'b01010101;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[228]     = t;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h00001;
		t[VAE:VA]   = 'h0001;
		sr[229]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[230]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h41;
		t[VDE:VD]   = 'b10101010;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[231]     = t;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h00002;
		t[VAE:VA]   = 'h0002;
		sr[232]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[233]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h42;
		t[VDE:VD]   = 'b00110011;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[234]     = t;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h00004;
		t[VAE:VA]   = 'h0004;
		sr[235]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[236]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h43;
		t[VDE:VD]   = 'b11001100;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[237]     = t;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h00008;
		t[VAE:VA]   = 'h0008;
		sr[238]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[239]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h44;
		t[VDE:VD]   = 'b00001111;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[240]     = t;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h00010;
		t[VAE:VA]   = 'h0010;
		sr[241]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[242]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h45;
		t[VDE:VD]   = 'b11110000;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[243]     = t;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h00020;
		t[VAE:VA]   = 'h0020;
		sr[244]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[245]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h46;
		t[VDE:VD]   = 'hb0;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[246]     = t;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h00040;
		t[VAE:VA]   = 'h0040;
		sr[247]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[248]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h47;
		t[VDE:VD]   = 'hb1;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[249]     = t;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h00080;
		t[VAE:VA]   = 'h0080;
		sr[250]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[251]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h48;
		t[VDE:VD]   = 'hb2;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[252]     = t;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h00100;
		t[VAE:VA]   = 'h0100;
		sr[253]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[254]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h49;
		t[VDE:VD]   = 'hb3;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[255]     = t;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h00200;
		t[VAE:VA]   = 'h0200;
		sr[256]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[257]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h4a;
		t[VDE:VD]   = 'hb4;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[258]     = t;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h00400;
		t[VAE:VA]   = 'h0400;
		sr[259]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[260]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h4b;
		t[VDE:VD]   = 'hb5;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[261]     = t;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h00800;
		t[VAE:VA]   = 'h0800;
		sr[262]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[263]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h4c;
		t[VDE:VD]   = 'hb6;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[264]     = t;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h01000;
		t[VAE:VA]   = 'h1000;
		sr[265]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[266]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h4d;
		t[VDE:VD]   = 'hb7;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[267]     = t;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h10000;
		t[VAE:VA]   = 'h2000;
		sr[268]     = t;
		t[MRD]      = 1;
		t[VRD]      = 1;
		sr[269]     = t;
		t[MRD]      = 0;
		t[VRD]      = 0;
		t[MDE:MD]   = 'h4e;
		t[VDE:VD]   = 'hb8;
		t[MDT]      = 1;
		t[VDT]      = 1;
		sr[270]     = t;
		t[VCS]      = 0;
		t[MDT]      = 0;
		t[VDT]      = 0;
		t[MAE:MA]   = 'h20000;
		t[VAE:VA]   = 0;
		sr[271]     = t;
		t[MRD]      = 1;
		sr[272]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'h4f;
		t[VDE:VD]   = 0;
		t[MDT]      = 1;
		sr[273]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h40000;
		sr[274]     = t;
		t[MRD]      = 1;
		sr[275]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'he0;
		t[MDT]      = 1;
		sr[276]     = t;
		t[MDT]      = 0;
		t[MAE:MA]   = 'h80000;
		sr[277]     = t;
		t[MRD]      = 1;
		sr[278]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'he1;
		t[MDT]      = 1;
		sr[279]     = t;
		/* Read one byte from WRAM */
		t           = 0;
		t[MSW]      = 1;
		t[MAE:MA]   = 'h04000; /* WRAM has second chip select on A14 */
		sr[280]     = t;
		t[MRD]      = 1;
		sr[281]     = t;
		t[MRD]      = 0;
		t[MDE:MD]   = 'h7a;
		t[MDT]      = 1;
		sr[282]     = t;
	end

	wire logic [8:0] c = cyc[12:4];
	wire logic       d = cyc[3:0] == 4;

	always_ff @(posedge clk12m) s <= sr[c];

	logic [5:0] pxx_good, pxx_led;
	logic [7:0] lcd_good, lcd_led;
	logic       md_good,  md_led;
	logic       vd_good,  vd_led;

	always_ff @(posedge clk12m) if (d) begin
		if (&c) begin
			pxx_led  <= pxx_good;
			pxx_good  = 'h3f;
			lcd_led  <= lcd_good;
			lcd_good  = 'hff;
			md_led   <= md_good;
			md_good   = 1;
			vd_led   <= vd_good;
			vd_good   = 1;
		end
		if (s[PXXT]) begin
			pxx_good &= ~s[PXXE:PXX] ^ { p15, p14, p13, p12, p11, p10 };
		end
		if (s[LCDT]) begin
			lcd_good &= ~s[SA+7:SA] ^ adr[7:0];
		end
		if (s[MDT]) begin
			md_good &= s[MDE:MD] == md_in;
		end
		if (s[VDT]) begin
			vd_good &= s[VDE:VD] == vd_in;
		end
		madr       <= s[MAE:MA];
		md_out     <= s[MDE:MD];
		md_dir_out <= s[MDO];
		n_mrd      <= !s[MRD];
		n_mwr      <= !s[MWR];
		n_prog     <= !s[MPRG];
		n_mcs_wram <= !s[MSW];
		n_mcs_crom <= !s[MSCR];
		n_mcs_cram <= !s[MSCX];
		vadr       <= s[VAE:VA];
		vd_out     <= s[VDE:VD];
		vd_dir_out <= s[VDO];
		n_vrd      <= !s[VRD];
		n_vwr      <= !s[VWR];
		n_vcs      <= !s[VCS];
		lcd_hsync  <= s[LCD+7];
		lcd_vsync  <= s[LCD+6];
		lcd_latch  <= s[LCD+5];
		lcd_altsig <= s[LCD+4];
		lcd_ctrl   <= s[LCD+3];
		lcd_clk    <= s[LCD+2];
		lcd_data   <= s[LCD+1:LCD];
	end

	logic [7:0] led_mode = 0;

	always_ff @(posedge clk12m) if (btn[0]) led_mode <= sw[7:0];

	always_comb case (led_mode)
	0: begin
		led[15] = cyc[19];
		led[14] = cyc16[20];
		led[13] = cycpll[20];
		led[12] = btn[1];
		led[11] = btn[2];
		led[10] = btn[3];
		led[9:4] = 0;
		led[3]  = vd_led;
		led[2]  = md_led;
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
