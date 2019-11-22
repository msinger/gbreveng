`default_nettype none

`define COUNTER_WIDTH    20
`define NUM_COUNTERS     2
`define NUM_COMPARATORS  4
`define NUM_ROUTES       4

(* nolatches *)
(* top *)
module top(
		input  wire        clk12m,        /* 12 MHz clock input */
		input  wire        clk16m,        /* 16 MiHz clock input */
		output wire        clk16m_en = 0, /* 16 MiHz clock enable */

		output reg  [15:0] led,
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
		output wire        n_soe,
		output wire        sdir,

		output wire [13:0] vadr  = 0,
		output wire [7:0]  vdata = 'hff,
		output wire        n_vrd = 1,
		output wire        n_vwr = 1,
		output wire        n_vcs = 1,

		inout  wire [7:0]  pa,
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

	integer i;

	wire pllclk;
	wire cpuclk;

`define rst_assert  0
`define rst_release 1
`define rst_done    2
	(* onehot *)
	reg  [1:0] r_reset_state         = 0, reset_state;
	reg  [3:0] r_reset_ticks         = 0, reset_ticks;
	reg  [3:0] r_initial_reset_ticks = 0, initial_reset_ticks;
	reg        r_initial_reset_done  = 0, initial_reset_done;
	reg        r_reset_done          = 0, reset_done;
	wire       f_reset;
	cdc f_reset_cdc(pllclk, !reset_done, f_reset);

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

	reg  cs_cpu_sysram, cs_cpu_dutram, cs_cpu_recram;
	reg  cs_cpu_led0, cs_cpu_led1;
	reg  cs_cpu_sw0, cs_cpu_sw1;
	reg  cs_cpu_io_if, cs_cpu_io_ie;
	reg  cs_cpu_atom;
	reg  cs_cpu_ones_set;
	reg  cs_cpu_pa;

	reg  [`NUM_COUNTERS-1:0] cs_cpu_counter;

	wire [7:0] data_cpu_out;
	wire [7:0] data_cpu_in;
	reg  [7:0] data_cpu_in_r;
	wand [7:0] data_cpu_in_wand;
	wire [7:0] data_cpureg_out;
	reg  [7:0] data_sysram_out;
	reg  [7:0] data_dutram_out;
	reg  [7:0] data_recram_out;
	wire [7:0] data_dbg_out;

	wire [7:0]  data_pa_in;
	wire [7:0]  data_pa_out;
	reg  [7:0]  pa_out;
	wire [7:0]  pa_ext, pa_in;
	wire        pa_set_sig, pa_reset_sig;
	wor  [7:0]  pa_set_mask, pa_reset_mask;
	wire        pa_trigger;
	reg         r_pa_trigger;
	wire        pa_trigger_set_set, pa_trigger_reset_set;
	wire [`NUM_ROUTES-1:0] pa_trigger_set, pa_trigger_reset;
	cdc #(1) pa_cdc[7:0](pllclk, pa_ext, pa_in);

	reg  [31:0] atom;

	wire                   ones_set_trigger;
	wire [`NUM_ROUTES-1:0] ones_set;

	wor  [`NUM_ROUTES-1:0] route;

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

	wire [14:0] dut_adr_ext,          dut_adr_in;
	reg         dut_data_dir_out,     r_dut_data_dir_out;
	reg         dut_data_lvl_dir_out, r_dut_data_lvl_dir_out;
	reg         dut_data_lvl_ena;
	reg  [7:0]  dut_data_out;
	wire [7:0]  dut_data_ext,         dut_data_in;
	wire        n_dut_rd_ext,         dut_rd_in;
	wire        n_dut_wr_ext,         dut_wr_in;
	wire        n_dut_cs_rom_ext,     dut_cs_rom_in;
	wire        n_dut_cs_xram_ext,    dut_cs_xram_in;
	wire        dut_phi_ext,          dut_phi_in;
	reg         dut_reset_out,        r_dut_reset_out;
	wire        n_dut_reset_ext,      dut_reset_in;
	cdc #(1) dut_adr_cdc[14:0](pllclk, dut_adr_ext,        dut_adr_in);
	cdc #(1) dut_data_cdc[7:0](pllclk, dut_data_ext,       dut_data_in);
	cdc #(1) dut_rd_cdc       (pllclk, !n_dut_rd_ext,      dut_rd_in);
	cdc #(1) dut_wr_cdc       (pllclk, !n_dut_wr_ext,      dut_wr_in);
	cdc #(1) dut_cs_rom_cdc   (pllclk, !n_dut_cs_rom_ext,  dut_cs_rom_in);
	cdc #(1) dut_cs_xram_cdc  (pllclk, !n_dut_cs_xram_ext, dut_cs_xram_in);
	cdc #(1) dut_phi_cdc      (pllclk, dut_phi_ext,        dut_phi_in);
	cdc #(1) dut_reset_cdc    (pllclk, !n_dut_reset_ext,   dut_reset_in);

	reg dut_any_cs;

	wire [7:0] irq, f_irq;

	reg  [7:0] sysram[0:4095];
	reg  [7:0] dut_ro_ram[0:4095];
	reg  [7:0] dut_wo_ram[0:4095];
	reg  [7:0] recram[0:4095];

	/* Place jump instruction at $0000 that jumps onto itself. */
	initial sysram[0] = 'h18; /* JR */
	initial sysram[1] = 'hfe; /* -2 */

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
			.OUTPUT_ENABLE(r_reset_done && ft245_dir_out),
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
			.D_OUT_0(!r_reset_done || !ft245_rd_out),
		);

	SB_IO #(
			.PIN_TYPE('b 0101_01),
		) ft245_n_wr_io (
			.PACKAGE_PIN(ft245_n_wr),
			.OUTPUT_CLK(cpuclk),
			.D_OUT_0(!r_reset_done || !ft245_wr_out),
		);

	SB_IO #(
			.PIN_TYPE('b 0101_01),
		) ft245_siwu_io (
			.PACKAGE_PIN(ft245_siwu),
			.OUTPUT_CLK(cpuclk),
			.D_OUT_0(!r_reset_done || !ft245_siwu_out),
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
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) adr_io[14:0] (
			.PACKAGE_PIN(adr),
			.INPUT_CLK(pllclk),
			.D_IN_0(dut_adr_ext),
		);

	SB_IO #(
			.PIN_TYPE('b 1101_00),
			.PULLUP(1),
		) data_io[7:0] (
			.PACKAGE_PIN(data),
			.OUTPUT_CLK(pllclk),
			.INPUT_CLK(pllclk),
			.OUTPUT_ENABLE(!f_reset && dut_data_dir_out),
			.D_OUT_0(dut_data_out),
			.D_IN_0(dut_data_ext),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) n_rd_io (
			.PACKAGE_PIN(n_rd),
			.INPUT_CLK(pllclk),
			.D_IN_0(n_dut_rd_ext),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) n_wr_io (
			.PACKAGE_PIN(n_wr),
			.INPUT_CLK(pllclk),
			.D_IN_0(n_dut_wr_ext),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) n_cs_rom_io (
			.PACKAGE_PIN(n_cs_rom),
			.INPUT_CLK(pllclk),
			.D_IN_0(n_dut_cs_rom_ext),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) n_cs_xram_io (
			.PACKAGE_PIN(n_cs_xram),
			.INPUT_CLK(pllclk),
			.D_IN_0(n_dut_cs_xram_ext),
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) phi_io (
			.PACKAGE_PIN(phi),
			.INPUT_CLK(pllclk),
			.D_IN_0(dut_phi_ext),
		);

	SB_IO #(
			.PIN_TYPE('b 1101_00),
			.PULLUP(1),
		) n_reset_io (
			.PACKAGE_PIN(n_reset),
			.OUTPUT_CLK(pllclk),
			.INPUT_CLK(pllclk),
			.OUTPUT_ENABLE(!f_reset && dut_reset_out),
			.D_IN_0(n_dut_reset_ext),
		);

	SB_IO #(
			.PIN_TYPE('b 0101_01),
		) n_soe_io (
			.PACKAGE_PIN(n_soe),
			.OUTPUT_CLK(pllclk),
			.D_OUT_0(f_reset || !dut_data_lvl_ena),
		);

	SB_IO #(
			.PIN_TYPE('b 0101_01),
		) sdir_io (
			.PACKAGE_PIN(sdir),
			.OUTPUT_CLK(pllclk),
			.D_OUT_0(!f_reset && dut_data_lvl_dir_out),
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

	SB_IO #(
			.PIN_TYPE('b 0101_00),
		) pa_io[7:0] (
			.PACKAGE_PIN(pa),
			.OUTPUT_CLK(pllclk),
			.INPUT_CLK(pllclk),
			.D_OUT_0(pa_out),
			.D_IN_0(pa_ext),
		);

	pll pll_inst(
		.clock_in(clk12m),
		.clock_out(pllclk),
	);

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
		r_reset_done          <= reset_done;
	end

	always @(posedge cpuclk) begin
		data_sysram_out <= sysram[adr_cpu[11:0]];
		data_dutram_out <= dut_wo_ram[adr_cpu[11:0]];
		data_recram_out <= recram[adr_cpu[11:0]];

		if (wr_cpu) case (1)
		cs_cpu_sysram:
			sysram[adr_cpu[11:0]] <= data_cpu_out;
		cs_cpu_dutram:
			dut_ro_ram[adr_cpu[11:0]] <= data_cpu_out;
		cs_cpu_recram:
			recram[adr_cpu[11:0]] <= data_cpu_out;
		cs_cpu_led0:
			led[7:0] <= data_cpu_out;
		cs_cpu_led1:
			led[15:8] <= data_cpu_out;
		cs_cpu_atom && adr_cpu[1:0] == 0:
			atom[7:0] <= data_cpu_out;
		cs_cpu_atom && adr_cpu[1:0] == 1:
			atom[15:8] <= data_cpu_out;
		cs_cpu_atom && adr_cpu[1:0] == 2:
			atom[23:16] <= data_cpu_out;
		cs_cpu_atom && adr_cpu[1:0] == 3:
			atom[31:24] <= data_cpu_out;
		endcase
	end

	always @* begin
		data_cpu_in_r = 'hff;

		(* parallelcase *)
		case (1)
		cs_cpu_sysram:
			data_cpu_in_r = data_sysram_out;
		cs_cpu_dutram:
			data_cpu_in_r = data_dutram_out;
		cs_cpu_recram:
			data_cpu_in_r = data_recram_out;
		cs_cpu_led0:
			data_cpu_in_r = led[7:0];
		cs_cpu_led1:
			data_cpu_in_r = led[15:8];
		cs_cpu_sw0:
			data_cpu_in_r = sw_in[7:0];
		cs_cpu_sw1:
			data_cpu_in_r = sw_in[15:8];
		cs_cpu_atom && adr_cpu[1:0] == 0:
			data_cpu_in_r = atom[7:0];
		cs_cpu_atom && adr_cpu[1:0] == 1:
			data_cpu_in_r = atom[15:8];
		cs_cpu_atom && adr_cpu[1:0] == 2:
			data_cpu_in_r = atom[23:16];
		cs_cpu_atom && adr_cpu[1:0] == 3:
			data_cpu_in_r = atom[31:24];
		cs_cpu_pa && adr_cpu[1:0] == 0:
			data_cpu_in_r = data_pa_out[7:0];
		cs_cpu_pa && adr_cpu[1:0] == 1:
			data_cpu_in_r = data_pa_in[7:0];
		cs_cpu_io_if || cs_cpu_io_ie:
			data_cpu_in_r = data_cpureg_out;
		endcase
	end

	assign data_cpu_in_wand = data_cpu_in_r;
	assign data_cpu_in = ddrv_dbg ? data_dbg_out : data_cpu_in_wand;

	always @* begin
		cs_cpu_sysram   = 0;
		cs_cpu_dutram   = 0;
		cs_cpu_recram   = 0;
		cs_cpu_led0     = 0;
		cs_cpu_led1     = 0;
		cs_cpu_sw0      = 0;
		cs_cpu_sw1      = 0;
		cs_cpu_atom     = 0;
		cs_cpu_ones_set = 0;
		cs_cpu_io_if    = 0;
		cs_cpu_io_ie    = 0;
		cs_cpu_pa       = 0;

		for (i = 0; i < `NUM_COUNTERS; i = i + 1)
			cs_cpu_counter[i] = 0;

		if (r_reset_done) casez (adr_cpu)
		/* A15....A8 A7.....A0 */
		'b_0000_????_????_????: /* 0x0000-0x0fff: System RAM */
			cs_cpu_sysram = 1;
		'b_0001_????_????_????: /* 0x1000-0x1fff: Device-Under-Test RAM */
			cs_cpu_dutram = 1;
		'b_0010_????_????_????: /* 0x2000-0x2fff: Recording RAM */
			cs_cpu_recram = 1;
		'b_1111_1111_0000_0000: /* 0xff00:        LED 0-7 */
			cs_cpu_led0 = 1;
		'b_1111_1111_0000_0001: /* 0xff01:        LED 8-15 */
			cs_cpu_led1 = 1;
		'b_1111_1111_0000_0010: /* 0xff02:        SW 0-7 */
			cs_cpu_sw0 = 1;
		'b_1111_1111_0000_0011: /* 0xff03:        SW 8-15 */
			cs_cpu_sw1 = 1;
		'b_1111_1111_0001_00??: /* 0xff10-0xff13: Atomic load register */
			cs_cpu_atom = 1;
		'b_1111_1111_0001_0100: /* 0xff14:        Always one trigger */
			cs_cpu_ones_set = 1;
		'b_1111_1111_0010_00??: /* 0xff20-0xff23: Counter 0 */
			if (`NUM_COUNTERS > 0) cs_cpu_counter[0] = 1;
		'b_1111_1111_0010_01??: /* 0xff24-0xff27: Counter 1 */
			if (`NUM_COUNTERS > 1) cs_cpu_counter[1] = 1;
		'b_1111_1111_0010_10??: /* 0xff28-0xff2b: Counter 2 */
			if (`NUM_COUNTERS > 2) cs_cpu_counter[2] = 1;
		'b_1111_1111_0010_11??: /* 0xff2c-0xff2f: Counter 3 */
			if (`NUM_COUNTERS > 3) cs_cpu_counter[3] = 1;
		'b_1111_1111_0011_00??: /* 0xff30-0xff33: Counter 4 */
			if (`NUM_COUNTERS > 4) cs_cpu_counter[4] = 1;
		'b_1111_1111_0011_01??: /* 0xff34-0xff37: Counter 5 */
			if (`NUM_COUNTERS > 5) cs_cpu_counter[5] = 1;
		'b_1111_1111_0011_10??: /* 0xff38-0xff3b: Counter 6 */
			if (`NUM_COUNTERS > 6) cs_cpu_counter[6] = 1;
		'b_1111_1111_0011_11??: /* 0xff3c-0xff3f: Counter 7 */
			if (`NUM_COUNTERS > 7) cs_cpu_counter[7] = 1;
		'b_1111_1111_0100_00??: /* 0xff40-0xff43: Port A */
			cs_cpu_pa = 1;
		'b_1111_1111_1111_1111: /* 0xffff:        Interrupt Enable */
			cs_cpu_io_ie = 1;
		'b_1111_1111_1111_1110: /* 0xfffe:        Interrupt Flag */
			cs_cpu_io_if = 1;
		endcase
	end

	lr35902_cpu cpu(
		.clk(cpuclk),
		.reset(!r_reset_done),

		.adr(adr_cpu),
		.din(data_cpu_in),
		.dout(data_cpu_out),
		.write(wr_cpu),
		.read(rd_cpu),
		.irq(irq),

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
		.reset(!r_reset_done),

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

	counter_block #(`COUNTER_WIDTH, `NUM_COMPARATORS, `NUM_ROUTES) counter[`NUM_COUNTERS-1:0](
		.ctrclk(pllclk),
		.busclk(cpuclk),
		.ctrrst(f_reset),

		.route_in(route),
		.route_out(route),

		.route_con(atom[`NUM_ROUTES-1:0]),
		.wide_data(atom[`COUNTER_WIDTH-1:0]),
		.data_in(data_cpu_out),
		.data_out(data_cpu_in_wand),
		.adr(adr_cpu[1:0]),
		.cs(cs_cpu_counter),
		.rd(rd_cpu),
		.wr(wr_cpu),
	);

	always @* begin
		dut_data_dir_out     = r_dut_data_dir_out;
		dut_data_lvl_dir_out = r_dut_data_lvl_dir_out;
		dut_reset_out        = 0;

		dut_any_cs = dut_cs_rom_in || (dut_cs_xram_in && dut_adr_in[13] && !dut_adr_in[14]);

		dut_data_lvl_ena = dut_any_cs;

		if (dut_rd_in && dut_any_cs) begin
			dut_data_lvl_dir_out = 1;

			if (r_dut_data_lvl_dir_out)
				dut_data_dir_out = 1;
		end else begin
			dut_data_dir_out = 0;

			if (r_dut_data_dir_out)
				dut_data_lvl_dir_out = 0;
			else
				dut_data_lvl_ena = 0;
		end
	end

	always @(posedge pllclk) begin
		r_dut_data_dir_out     <= dut_data_dir_out;
		r_dut_data_lvl_dir_out <= dut_data_lvl_dir_out;
		r_dut_reset_out        <= dut_reset_out;

		dut_data_out <= dut_ro_ram[dut_adr_in[11:0]];

		if (dut_wr_in && dut_cs_xram_in && dut_adr_in[13])
			dut_wo_ram[dut_adr_in[11:0]] <= dut_data_in;
	end

	dp_reg #(8) pa_in_reg2bus(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_in(pa_in),
		.fvalue_mask('hff),

		.svalue_out(data_pa_in),
	);

	dp_reg #(8) pa_out_reg2bus(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_in(pa_out),
		.fvalue_mask('hff),

		.svalue_out(data_pa_out),
	);

	dp_reg #(8) pa_out_set_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_out(pa_set_mask),
		.fvalue_mask('hff),

		.svalue_in(data_cpu_out),
		.svalue_mask({8{pa_set_sig}}),
	);

	dp_reg #(8) pa_out_reset_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_out(pa_reset_mask),
		.fvalue_mask('hff),

		.svalue_in(data_cpu_out),
		.svalue_mask({8{pa_reset_sig}}),
	);

	dp_reg #(`NUM_ROUTES) pa_trigger_set_reg(
		.fclk(pllclk),
		.sclk(cpuclk),
		.frst(f_reset),

		.fvalue_out(pa_trigger_set),

		.svalue_in(atom[`NUM_ROUTES-1:0]),
		.svalue_mask({`NUM_ROUTES{pa_trigger_set_set}}),
	);

	dp_reg #(`NUM_ROUTES) pa_trigger_reset_reg(
		.fclk(pllclk),
		.sclk(cpuclk),
		.frst(f_reset),

		.fvalue_out(pa_trigger_reset),

		.svalue_in(atom[`NUM_ROUTES-1:0]),
		.svalue_mask({`NUM_ROUTES{pa_trigger_reset_set}}),
	);

	always @(posedge pllclk) begin
		pa_out <= ((pa_out | pa_set_mask) & ~pa_reset_mask);

		if (f_reset)
			pa_out <= 0;
	end

	always @(posedge cpuclk) r_pa_trigger <= wr_cpu && cs_cpu_pa;
	assign pa_trigger = wr_cpu && cs_cpu_pa && !r_pa_trigger;
	assign pa_set_sig = pa_trigger && !adr_cpu[1:0];
	assign pa_reset_sig = pa_trigger && adr_cpu[1:0] == 1;
	assign pa_trigger_set_set = pa_trigger && adr_cpu[1:0] == 2 && data_cpu_out == 1;
	assign pa_trigger_reset_set = pa_trigger && &adr_cpu[1:0] && data_cpu_out == 1;

	assign pa_set_mask[0] = |(pa_trigger_set & route);
	assign pa_reset_mask[0] = |(pa_trigger_reset & route);

	dp_reg #(`NUM_ROUTES) ones_set_reg(
		.fclk(pllclk),
		.sclk(cpuclk),
		.frst(f_reset),

		.fvalue_out(ones_set),

		.svalue_in(atom[`NUM_ROUTES-1:0]),
		.svalue_mask({`NUM_ROUTES{ones_set_trigger}}),
	);

	assign ones_set_trigger = wr_cpu && cs_cpu_ones_set;

	assign route = ones_set;

	dp_reg #(8) route2irq_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_in(f_irq),
		.fvalue_mask(f_irq),

		.svalue_out(irq),
		.svalue_mask('hff),
	);

	assign f_irq = {{(`NUM_ROUTES > 8 ? 0 : 8-`NUM_ROUTES){1'b0}}, route[(`NUM_ROUTES > 8 ? 7 : `NUM_ROUTES-1):0]};

endmodule
