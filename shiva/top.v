`default_nettype none

(* nolatches *)
(* top *)
module top(
		input  wire        clk12m,        /* 12 MHz clock input */
		input  wire        clk16m,        /* 16 MiHz clock input */
		output wire        clk16m_en = 0, /* 16 MiHz clock enable */

		output wire [15:0] led,
		input  wire [15:0] sw,
		input  wire [3:0]  btn,

		inout  wire [7:0]  ft245_d,
		input  wire        ft245_n_rxf,
		input  wire        ft245_n_txe,
		output wire        ft245_n_rd,
		output wire        ft245_n_wr,
		output wire        ft245_siwu,

		output wire        chl = 0,       /* left audio PWM channel */
		output wire        chr = 0,       /* right audio PWM channel */
		output wire        chm = 0,       /* mono audio PWM channel */

		input  wire        p10,
		input  wire        p11,
		input  wire        p12,
		input  wire        p13,
		output wire        p14 = 1,
		output wire        p15 = 1,

		output wire [20:0] madr       = 0,
		output wire [7:0]  mdata      = 'hff,
		output wire        n_mrd      = 1,
		output wire        n_mwr      = 1,
		output wire        n_prog     = 1,
		output wire        n_mcs_rom  = 1,
		output wire        n_mcs_xram = 1,
		output wire        n_mcs_wram = 1,
		output wire        n_mcs_crom = 1,
		output wire        n_mcs_cram = 1,
		output wire        mphi       = 1,
		inout  wire        n_mreset,
		output wire        n_moe      = 0,
		output wire        n_moed     = 0,
		output wire        mdir       = 1,

		input  wire [14:0] adr,
		inout  wire [7:0]  data,
		input  wire        n_rd,
		input  wire        n_wr,
		input  wire        n_cs_rom,
		input  wire        n_cs_xram,
		input  wire        phi,
		inout  wire        n_reset,
		output wire        n_soe     = 0,
		output wire        sdir      = 0,

		output wire [13:0] vadr  = 0,
		output wire [7:0]  vdata = 'hff,
		output wire        n_vrd = 1,
		output wire        n_vwr = 1,
		output wire        n_vcs = 1,

		output wire [7:0]  pa      = 0,
		output wire        n_pa_oe = 0,
		output wire        pa_dir  = 1,

		output wire [7:0]  pb      = 1,
		output wire        n_pb_oe = 0,
		output wire        pb_dir  = 1,

		input  wire        sin,
		output wire        sout = 0,

		input  wire        sd_sw,
		input  wire        sd_clk,
		input  wire        sd_cmd,
		input  wire [3:0]  sd_data,

		output wire        lcd_hsync  = 0,
		output wire        lcd_vsync  = 0,
		output wire        lcd_latch  = 0,
		output wire        lcd_altsig = 0,
		output wire        lcd_ctrl   = 0,
		output wire        lcd_clk    = 0,
		output wire [1:0]  lcd_data   = 0,
	);

`define rst_assert  0
`define rst_release 1
`define rst_done    2
	(* onehot *)
	reg  [1:0] r_reset_state         = 0, reset_state;
	reg  [3:0] r_reset_ticks         = 0, reset_ticks;
	reg  [3:0] r_initial_reset_ticks = 0, initial_reset_ticks;
	reg        r_initial_reset_done  = 0, initial_reset_done;
	reg        reset_done;

	wire pllclk;
	wire cpuclk;

	wire [15:0] sw_in,  sw_ext;
	wire [3:0]  btn_in, btn_ext;
	cdc #(1) sw_cdc[15:0](cpuclk, sw_ext,  sw_in);
	cdc #(1) btn_cdc[3:0](cpuclk, btn_ext, btn_in);

	wire [7:0] ft245_d_out, ft245_d_in;
	wire       ft245_dir_out;
	wire       ft245_n_rxf_in, ft245_n_rxf_ext;
	wire       ft245_n_txe_in, ft245_n_txe_ext;
	wire       ft245_rd_out, ft245_wr_out;
	wire       ft245_siwu_out;
	cdc #(1) ft245_n_rxf_cdc(cpuclk, ft245_n_rxf_ext, ft245_n_rxf_in);
	cdc #(1) ft245_n_txe_cdc(cpuclk, ft245_n_txe_ext, ft245_n_txe_in);

	wire [15:0] adr_cpu;

	wire rd_cpu, wr_cpu;

	reg  cs_cpu_io_if, cs_cpu_io_ie;

	wire [7:0] data_cpu_out;
	reg  [7:0] data_cpu_in;
	wire [7:0] data_cpureg_out;
	wire [7:0] data_dbg_out;

	wire [15:0] pc, sp;
	wire [7:4]  flags;
	wire [7:0]  dbg_probe;
	wire        halt, no_inc, ime;
	wire        ddrv_dbg;

	wire [7:0] dbg_data_rx;
	wire       dbg_data_rx_seq;
	wire       dbg_data_rx_ack;
	wire [7:0] dbg_data_tx;
	wire       dbg_data_tx_seq;
	wire       dbg_data_tx_ack;

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(0),
		) sw_io[15:0] (
			.PACKAGE_PIN(sw),
			.INPUT_CLK(cpuclk),
			.D_IN_0(sw_ext),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(0),
		) btn_io[3:0] (
			.PACKAGE_PIN(btn),
			.INPUT_CLK(cpuclk),
			.D_IN_0(btn_ext),
		);

	SB_IO #(
			.PIN_TYPE('b 1101_00),
			.PULLUP(1),
		) ft245_d_io[7:0] (
			.PACKAGE_PIN(ft245_d),
			.OUTPUT_CLK(cpuclk),
			.INPUT_CLK(cpuclk),
			.OUTPUT_ENABLE(reset_done && ft245_dir_out),
			.D_OUT_0(ft245_d_out),
			.D_IN_0(ft245_d_in),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) ft245_n_rxf_io (
			.PACKAGE_PIN(ft245_n_rxf),
			.INPUT_CLK(cpuclk),
			.D_IN_0(ft245_n_rxf_ext),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) ft245_n_txe_io (
			.PACKAGE_PIN(ft245_n_txe),
			.INPUT_CLK(cpuclk),
			.D_IN_0(ft245_n_txe_ext),
		);

	SB_IO #(
			.PIN_TYPE('b 0101_01),
		) ft245_n_rd_io (
			.PACKAGE_PIN(ft245_n_rd),
			.OUTPUT_CLK(cpuclk),
			.D_OUT_0(!reset_done || !ft245_rd_out),
		);

	SB_IO #(
			.PIN_TYPE('b 0101_01),
		) ft245_n_wr_io (
			.PACKAGE_PIN(ft245_n_wr),
			.OUTPUT_CLK(cpuclk),
			.D_OUT_0(!reset_done || !ft245_wr_out),
		);

	SB_IO #(
			.PIN_TYPE('b 0101_01),
		) ft245_siwu_io (
			.PACKAGE_PIN(ft245_siwu),
			.OUTPUT_CLK(cpuclk),
			.D_OUT_0(!reset_done || !ft245_siwu_out),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1),
		) p10_io (
			.PACKAGE_PIN(p10),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1),
		) p11_io (
			.PACKAGE_PIN(p11),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1),
		) p12_io (
			.PACKAGE_PIN(p12),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1),
		) p13_io (
			.PACKAGE_PIN(p13),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1),
		) n_mreset_io (
			.PACKAGE_PIN(n_mreset),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1),
		) adr_io[14:0] (
			.PACKAGE_PIN(adr),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1),
		) data_io[7:0] (
			.PACKAGE_PIN(data),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1),
		) n_rd_io (
			.PACKAGE_PIN(n_rd),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1),
		) n_wr_io (
			.PACKAGE_PIN(n_wr),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1),
		) n_cs_rom_io (
			.PACKAGE_PIN(n_cs_rom),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1),
		) n_cs_xram_io (
			.PACKAGE_PIN(n_cs_xram),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1),
		) phi_io (
			.PACKAGE_PIN(phi),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1),
		) n_reset_io (
			.PACKAGE_PIN(n_reset),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1),
		) sin_io (
			.PACKAGE_PIN(sin),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(0),
		) sd_sw_io (
			.PACKAGE_PIN(sd_sw),
		);

	pll pll_inst(
		.clock_in(clk12m),
		.clock_out(pllclk),
	);

	assign led = { !ft245_n_rxf_in, ft245_n_txe_in };

	assign cpuclk = clk12m;

	always @* begin
		initial_reset_ticks = r_initial_reset_ticks + 1;
		initial_reset_done  = r_initial_reset_done;
		reset_ticks         = 'bx;
		reset_state         = r_reset_state;

		if (&r_initial_reset_ticks)
			initial_reset_done = 1;

		if (btn_in[3]) begin
			reset_state = `rst_assert;
			reset_ticks = 0;
		end

		if (r_initial_reset_done) case (reset_state)
		`rst_assert:
			if (&r_reset_ticks) begin
				reset_state = `rst_release;
				reset_ticks = 0;
			end else
				reset_ticks = r_reset_ticks + 1;
		`rst_release:
			if (&r_reset_ticks)
				reset_state = `rst_done;
			else
				reset_ticks = r_reset_ticks + 1;
		endcase

		reset_done = reset_state == `rst_done;
	end

	always @(posedge cpuclk) begin
		r_initial_reset_ticks <= initial_reset_ticks;
		r_initial_reset_done  <= initial_reset_done;
		r_reset_ticks         <= reset_ticks;
		r_reset_state         <= reset_state;
	end

	always @* begin
		data_cpu_in = 'hff;

		(* parallelcase *)
		case (1)
		cs_cpu_io_if || cs_cpu_io_ie:
			data_cpu_in = data_cpureg_out;
		endcase

		if (ddrv_dbg)
			data_cpu_in = data_dbg_out;
	end

	always @* begin
		cs_cpu_io_if = 0;
		cs_cpu_io_ie = 0;

		if (reset_done) casez (adr_cpu)
		/* A15....A8 A7.....A0 */
		'b_1111_1111_1111_1111: /* 0xffff: Interrupt Enable */
			cs_cpu_io_ie = 1;
		'b_1111_1111_1111_1110: /* 0xfffe: Interrupt Flag */
			cs_cpu_io_if = 1;
		endcase
	end

	lr35902_cpu cpu(
		.clk(cpuclk),
		.reset(!reset_done),

		.adr(adr_cpu),
		.din(data_cpu_in),
		.dout(data_cpu_out),
		.write(wr_cpu),
		.read(rd_cpu),
		.irq(0),

		.cs_if(cs_cpu_io_if),
		.cs_ie(cs_cpu_io_ie),
		.din_reg(data_cpu_out),
		.dout_reg(data_cpureg_out),
		.write_reg(wr_cpu),
		.read_reg(rd_cpu),

		.r_pc(pc),
		.r_sp(sp),
		.r_f(flags[7:4]),
		.r_ime(ime),
		.dbg_probe(dbg_probe),
		.dbg_halt(halt),
		.dbg_no_inc(no_inc),
	);

	ft245_ifc dbg_ft245(
		.clk(cpuclk),
		.reset(!reset_done),

		.rx_data(dbg_data_rx),
		.rx_seq(dbg_data_rx_seq),
		.rx_ack(dbg_data_rx_ack),
		.tx_data(dbg_data_tx),
		.tx_seq(dbg_data_tx_seq),
		.tx_ack(dbg_data_tx_ack),

		.data_in(ft245_d_in),
		.data_out(ft245_d_out),
		.dir_out(ft245_dir_out),
		.rxf(!ft245_n_rxf_in),
		.txe(!ft245_n_txe_in),
		.rd(ft245_rd_out),
		.wr(ft245_wr_out),
		.siwu(ft245_siwu_out),
	);

	lr35902_dbg_ifc dbg_ifc(
		.clk(cpuclk),
		.reset(!initial_reset_done),

		.pc(pc),
		.sp(sp),
		.f(flags[7:4]),
		.ime(ime),
		.probe(dbg_probe),
		.data(data_dbg_out),
		.drv(ddrv_dbg),
		.halt(halt),
		.no_inc(no_inc),

		.data_rx(dbg_data_rx),
		.data_rx_valid(1),
		.data_rx_seq(dbg_data_rx_seq),
		.data_rx_ack(dbg_data_rx_ack),
		.data_tx(dbg_data_tx),
		.data_tx_seq(dbg_data_tx_seq),
		.data_tx_ack(dbg_data_tx_ack),
	);

endmodule
