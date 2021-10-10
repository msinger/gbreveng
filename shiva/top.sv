`default_nettype none

(* nolatches *)
(* top *)
module top(
		input  logic            clk12m,        /* 12 MHz clock input */
		input  logic            clk16m,        /* 16 MiHz clock input */
		output logic            clk16m_en = 0, /* 16 MiHz clock enable */

		output logic     [15:0] led,
		input  logic     [15:0] sw,
		input  logic     [3:0]  btn,

		inout  tri logic [7:0]  ft245_d,
		input  logic            ft245_n_rxf,
		input  logic            ft245_n_txe,
		output logic            ft245_n_rd,
		output logic            ft245_n_wr,
		output logic            ft245_siwu,

		output logic            chl = 0,       /* left audio PWM channel */
		output logic            chr = 0,       /* right audio PWM channel */
		output logic            chm = 0,       /* mono audio PWM channel */

		input  logic            p10,
		input  logic            p11,
		input  logic            p12,
		input  logic            p13,
		output logic            p14 = 1,
		output logic            p15 = 1,

		output logic     [20:0] madr       = 0,
		output logic     [7:0]  mdata      = '1,
		output logic            n_mrd      = 1,
		output logic            n_mwr      = 1,
		output logic            n_prog     = 1,
		output logic            n_mcs_rom  = 1,
		output logic            n_mcs_xram = 1,
		output logic            n_mcs_wram = 1,
		output logic            n_mcs_crom = 1,
		output logic            n_mcs_cram = 1,
		output logic            mphi       = 1,
		inout  tri logic        n_mreset,
		output logic            n_moe      = 0,
		output logic            n_moed     = 0,
		output logic            mdir       = 1,

		input  logic     [14:0] adr,
		inout  tri logic [7:0]  data,
		input  logic            n_rd,
		input  logic            n_wr,
		input  logic            n_cs_rom,
		input  logic            n_cs_xram,
		input  logic            phi,
		inout  tri logic        n_reset,
		output logic            n_soe,
		output logic            sdir,

		output logic     [13:0] vadr  = 0,
		output logic     [7:0]  vdata = '1,
		output logic            n_vrd = 1,
		output logic            n_vwr = 1,
		output logic            n_vcs = 1,

		inout  logic     [7:0]  pa,
		output logic            n_pa_oe = 0,
		output logic            pa_dir  = 1,

		output logic     [7:0]  pb      = 1,
		output logic            n_pb_oe = 0,
		output logic            pb_dir  = 1,

		input  logic            sin,
		output logic            sout = 0,

		input  logic            sd_sw,
		input  logic            sd_clk,
		input  logic            sd_cmd,
		input  logic     [3:0]  sd_data,

		output logic            lcd_hsync  = 0,
		output logic            lcd_vsync  = 0,
		output logic            lcd_latch  = 0,
		output logic            lcd_altsig = 0,
		output logic            lcd_ctrl   = 0,
		output logic            lcd_clk    = 0,
		output logic     [1:0]  lcd_data   = 0
	);

	localparam int COUNTER_WIDTH           = 7;
	localparam int NUM_COUNTERS            = 2;
	localparam int NUM_COUNTER_COMPARATORS = 5;
	localparam int NUM_BUS_COMPARATORS     = 1;
	localparam int NUM_ROUTES              = 6;

	logic pllclk;
	logic cpuclk;

	logic [1:0] r_reset_state         = 0, reset_state;
	logic [3:0] r_reset_ticks         = 0, reset_ticks;
	logic [3:0] r_initial_reset_ticks = 0, initial_reset_ticks;
	logic       r_initial_reset_done  = 0, initial_reset_done;
	logic       r_reset_done          = 0, reset_done;
	logic       f_reset;
	cdc f_reset_cdc(pllclk, !reset_done, f_reset);

	logic [15:0] sw_in,  sw_ext;
	logic [3:0]  btn_in, btn_ext;
	cdc #(1) sw_cdc[15:0](cpuclk, sw_ext,  sw_in);
	cdc #(1) btn_cdc[3:0](cpuclk, btn_ext, btn_in);

	logic [7:0] ft245_d_out, ft245_d_in;
	logic       ft245_dir_out;
	logic       ft245_n_rxf_in, ft245_n_rxf_ext;
	logic       ft245_n_txe_in, ft245_n_txe_ext;
	logic       ft245_rd_out, ft245_wr_out;
	logic       ft245_siwu_out;
	cdc #(1) ft245_n_rxf_cdc(cpuclk, ft245_n_rxf_ext, ft245_n_rxf_in);
	cdc #(1) ft245_n_txe_cdc(cpuclk, ft245_n_txe_ext, ft245_n_txe_in);

	logic [15:0] adr_cpu;

	logic rd_cpu, wr_cpu;

	logic cs_cpu_sysram, cs_cpu_dutram, cs_cpu_recram;
	logic cs_cpu_led0, cs_cpu_led1;
	logic cs_cpu_sw0, cs_cpu_sw1;
	logic cs_cpu_io_if, cs_cpu_io_ie;
	logic cs_cpu_atom;
	logic cs_cpu_ones_set;
	logic cs_cpu_rec;
	logic cs_cpu_pa;
	logic cs_cpu_dut;

	logic [NUM_COUNTERS-1:0] cs_cpu_counter;

	logic      [7:0]  data_cpu_out;
	logic      [7:0]  data_cpu_in;
	wand logic [7:0]  data_cpu_in_wand;
	logic      [7:0]  data_cpureg_out;
	logic      [7:0]  data_sysram_out;
	logic      [7:0]  data_dutram_out;
	logic      [31:0] data_recram_out;
	logic      [7:0]  data_dbg_out;

	logic     [7:0] data_pa_in;
	logic     [7:0] data_pa_out;
	logic     [7:0] pa_out;
	logic     [7:0] pa_ext, pa_in;
	logic           pa_set_sig, pa_reset_sig;
	wor logic [7:0] pa_set_mask, pa_reset_mask;
	logic           pa_trigger;
	logic           r_pa_trigger;
	logic           pa_trigger_set_set, pa_trigger_reset_set;
	logic [NUM_ROUTES-1:0] pa_trigger_set, pa_trigger_reset;
	cdc #(1) pa_cdc[7:0](pllclk, pa_ext, pa_in);

	logic [31:0] atom;

	logic                  ones_set_trigger;
	logic [NUM_ROUTES-1:0] ones_set;

	wor logic [NUM_ROUTES-1:0] route;
	logic     [NUM_ROUTES-1:0] piped_route;

	logic [15:0] pc, sp;
	logic [7:4]  flags;
	logic [7:0]  dbg_probe;
	logic        halt, no_inc, ime;
	logic        ddrv_dbg;

	logic [7:0] dbg_data_rx;
	logic       dbg_data_rx_seq;
	logic       dbg_data_rx_ack;
	logic [7:0] dbg_data_tx;
	logic       dbg_data_tx_seq;
	logic       dbg_data_tx_ack;

	logic [29:0] data_dut_in,          dut_in;
	(* mem2reg *)
	logic [30:0] dut_data_compare[0:NUM_BUS_COMPARATORS-1];
	(* mem2reg *)
	logic [30:0] dut_data_compare_mask[0:NUM_BUS_COMPARATORS-1];
	wire logic [NUM_ROUTES-1:0] dut_data_compare_trig_set[0:NUM_BUS_COMPARATORS-1];
	wire logic [NUM_ROUTES-1:0] dut_data_compare_edge_trig_set[0:NUM_BUS_COMPARATORS-1];
	logic [14:0] dut_adr_ext,          dut_adr_in;
	logic        dut_data_dir_out,     r_dut_data_dir_out;
	logic        dut_data_lvl_dir_out, r_dut_data_lvl_dir_out;
	logic        dut_data_lvl_ena;
	logic [7:0]  dut_data_out;
	logic [7:0]  dut_data_ovr_out;
	logic [7:0]  dut_data_ext,         dut_data_in;
	logic        n_dut_rd_ext,         dut_rd_in;
	logic        n_dut_wr_ext,         dut_wr_in;
	logic        n_dut_cs_rom_ext,     dut_cs_rom_in;
	logic        n_dut_cs_xram_ext,    dut_cs_xram_in;
	logic        dut_phi_ext,          dut_phi_in;
	logic        dut_reset_out,        r_dut_reset_out;
	logic        n_dut_reset_ext,      dut_reset_in;
	cdc #(1) dut_adr_cdc[14:0](pllclk, dut_adr_ext,        dut_adr_in);
	cdc #(1) dut_data_cdc[7:0](pllclk, dut_data_ext,       dut_data_in);
	cdc #(1) dut_rd_cdc       (pllclk, !n_dut_rd_ext,      dut_rd_in);
	cdc #(1) dut_wr_cdc       (pllclk, !n_dut_wr_ext,      dut_wr_in);
	cdc #(1) dut_cs_rom_cdc   (pllclk, !n_dut_cs_rom_ext,  dut_cs_rom_in);
	cdc #(1) dut_cs_xram_cdc  (pllclk, !n_dut_cs_xram_ext, dut_cs_xram_in);
	cdc #(1) dut_phi_cdc      (pllclk, dut_phi_ext,        dut_phi_in);
	cdc #(1) dut_reset_cdc    (pllclk, !n_dut_reset_ext,   dut_reset_in);

	logic dut_any_cs;

	logic r_dut_trigger;
	logic dut_trigger;
	logic dut_data_ovr;
	logic dut_ctl_sig, dut_trig_sig, dut_data_sig, dut_cmp_sig;
	logic dut_reset_set_mask;
	logic dut_reset_reset_mask;
	logic dut_data_set_mask;
	logic dut_data_reset_mask;
	logic [NUM_BUS_COMPARATORS-1:0] dut_data_compare_set, dut_data_compare_mask_set;

	logic [7:0] irq, f_irq;

	logic [7:0]  sysram[0:4095];
	logic [7:0]  dut_ro_ram[0:4095];
	logic [7:0]  dut_wo_ram[0:4095];
	logic [31:0] recram[0:1023];

	/* Place jump instruction at $0000 that jumps onto itself. */
	initial sysram[0] = 'h18; /* JR */
	initial sysram[1] = 'hfe; /* -2 */

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(0)
		) sw_io[15:0] (
			.PACKAGE_PIN(sw),
			.INPUT_CLK(cpuclk),
			.D_IN_0(sw_ext)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(0)
		) btn_io[3:0] (
			.PACKAGE_PIN(btn),
			.INPUT_CLK(cpuclk),
			.D_IN_0(btn_ext)
		);

	SB_IO #(
			.PIN_TYPE('b 1101_00),
			.PULLUP(1)
		) ft245_d_io[7:0] (
			.PACKAGE_PIN(ft245_d),
			.OUTPUT_CLK(cpuclk),
			.INPUT_CLK(cpuclk),
			.OUTPUT_ENABLE(r_reset_done && ft245_dir_out),
			.D_OUT_0(ft245_d_out),
			.D_IN_0(ft245_d_in)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1)
		) ft245_n_rxf_io (
			.PACKAGE_PIN(ft245_n_rxf),
			.INPUT_CLK(cpuclk),
			.D_IN_0(ft245_n_rxf_ext)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1)
		) ft245_n_txe_io (
			.PACKAGE_PIN(ft245_n_txe),
			.INPUT_CLK(cpuclk),
			.D_IN_0(ft245_n_txe_ext)
		);

	SB_IO #(
			.PIN_TYPE('b 0101_01)
		) ft245_n_rd_io (
			.PACKAGE_PIN(ft245_n_rd),
			.OUTPUT_CLK(cpuclk),
			.D_OUT_0(!r_reset_done || !ft245_rd_out)
		);

	SB_IO #(
			.PIN_TYPE('b 0101_01)
		) ft245_n_wr_io (
			.PACKAGE_PIN(ft245_n_wr),
			.OUTPUT_CLK(cpuclk),
			.D_OUT_0(!r_reset_done || !ft245_wr_out)
		);

	SB_IO #(
			.PIN_TYPE('b 0101_01)
		) ft245_siwu_io (
			.PACKAGE_PIN(ft245_siwu),
			.OUTPUT_CLK(cpuclk),
			.D_OUT_0(!r_reset_done || !ft245_siwu_out)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1)
		) p10_io (
			.PACKAGE_PIN(p10)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1)
		) p11_io (
			.PACKAGE_PIN(p11)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1)
		) p12_io (
			.PACKAGE_PIN(p12)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1)
		) p13_io (
			.PACKAGE_PIN(p13)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1)
		) n_mreset_io (
			.PACKAGE_PIN(n_mreset)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1)
		) adr_io[14:0] (
			.PACKAGE_PIN(adr),
			.INPUT_CLK(pllclk),
			.D_IN_0(dut_adr_ext)
		);

	SB_IO #(
			.PIN_TYPE('b 1101_00),
			.PULLUP(1)
		) data_io[7:0] (
			.PACKAGE_PIN(data),
			.OUTPUT_CLK(pllclk),
			.INPUT_CLK(pllclk),
			.OUTPUT_ENABLE(!f_reset && dut_data_dir_out),
			.D_OUT_0(dut_data_ovr ? dut_data_ovr_out : dut_data_out),
			.D_IN_0(dut_data_ext)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1)
		) n_rd_io (
			.PACKAGE_PIN(n_rd),
			.INPUT_CLK(pllclk),
			.D_IN_0(n_dut_rd_ext)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1)
		) n_wr_io (
			.PACKAGE_PIN(n_wr),
			.INPUT_CLK(pllclk),
			.D_IN_0(n_dut_wr_ext)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1)
		) n_cs_rom_io (
			.PACKAGE_PIN(n_cs_rom),
			.INPUT_CLK(pllclk),
			.D_IN_0(n_dut_cs_rom_ext)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1)
		) n_cs_xram_io (
			.PACKAGE_PIN(n_cs_xram),
			.INPUT_CLK(pllclk),
			.D_IN_0(n_dut_cs_xram_ext)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1)
		) phi_io (
			.PACKAGE_PIN(phi),
			.INPUT_CLK(pllclk),
			.D_IN_0(dut_phi_ext)
		);

	SB_IO #(
			.PIN_TYPE('b 1101_00),
			.PULLUP(1)
		) n_reset_io (
			.PACKAGE_PIN(n_reset),
			.OUTPUT_CLK(pllclk),
			.INPUT_CLK(pllclk),
			.OUTPUT_ENABLE(!f_reset && dut_reset_out),
			.D_IN_0(n_dut_reset_ext)
		);

	SB_IO #(
			.PIN_TYPE('b 0101_01)
		) n_soe_io (
			.PACKAGE_PIN(n_soe),
			.OUTPUT_CLK(pllclk),
			.D_OUT_0(f_reset || !dut_data_lvl_ena)
		);

	SB_IO #(
			.PIN_TYPE('b 0101_01)
		) sdir_io (
			.PACKAGE_PIN(sdir),
			.OUTPUT_CLK(pllclk),
			.D_OUT_0(!f_reset && dut_data_lvl_dir_out)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(1)
		) sin_io (
			.PACKAGE_PIN(sin)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_01),
			.PULLUP(0)
		) sd_sw_io (
			.PACKAGE_PIN(sd_sw)
		);

	SB_IO #(
			.PIN_TYPE('b 0101_00)
		) pa_io[7:0] (
			.PACKAGE_PIN(pa),
			.OUTPUT_CLK(pllclk),
			.INPUT_CLK(pllclk),
			.D_OUT_0(pa_out),
			.D_IN_0(pa_ext)
		);

	pll pll_inst(
		.clock_in(clk12m),
		.clock_out(pllclk)
	);

	assign cpuclk = clk12m;

	always_comb begin
		localparam int rst_assert  = 0;
		localparam int rst_release = 1;
		localparam int rst_done    = 2;

		initial_reset_ticks = r_initial_reset_ticks + 1;
		initial_reset_done  = r_initial_reset_done;
		reset_ticks         = 'x;
		reset_state         = r_reset_state;

		if (&r_initial_reset_ticks)
			initial_reset_done = 1;

		if (btn_in[3]) begin
			reset_state = rst_assert;
			reset_ticks = 0;
		end

		if (r_initial_reset_done) case (reset_state)
		rst_assert:
			if (&r_reset_ticks) begin
				reset_state = rst_release;
				reset_ticks = 0;
			end else
				reset_ticks = r_reset_ticks + 1;
		rst_release:
			if (&r_reset_ticks)
				reset_state = rst_done;
			else
				reset_ticks = r_reset_ticks + 1;
		endcase

		reset_done = reset_state == rst_done;
	end

	always_ff @(posedge cpuclk) begin
		r_initial_reset_ticks <= initial_reset_ticks;
		r_initial_reset_done  <= initial_reset_done;
		r_reset_ticks         <= reset_ticks;
		r_reset_state         <= reset_state;
		r_reset_done          <= reset_done;
	end

	always_ff @(posedge cpuclk) begin
		data_sysram_out <= sysram[adr_cpu[11:0]];
		data_dutram_out <= dut_wo_ram[adr_cpu[11:0]];
		data_recram_out <= recram[adr_cpu[11:2]];

		if (wr_cpu) unique0 case (1)
		cs_cpu_sysram:
			sysram[adr_cpu[11:0]] <= data_cpu_out;
		cs_cpu_dutram:
			dut_ro_ram[adr_cpu[11:0]] <= data_cpu_out;
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

	always_comb begin
		data_cpu_in = '1;

		unique0 case (1)
		cs_cpu_sysram:
			data_cpu_in = data_sysram_out;
		cs_cpu_dutram:
			data_cpu_in = data_dutram_out;
		cs_cpu_recram:
			case (adr_cpu[1:0])
				0: data_cpu_in = data_recram_out[7:0];
				1: data_cpu_in = data_recram_out[15:8];
				2: data_cpu_in = data_recram_out[23:16];
				3: data_cpu_in = data_recram_out[31:24];
			endcase
		cs_cpu_led0:
			data_cpu_in = led[7:0];
		cs_cpu_led1:
			data_cpu_in = led[15:8];
		cs_cpu_sw0:
			data_cpu_in = sw_in[7:0];
		cs_cpu_sw1:
			data_cpu_in = sw_in[15:8];
		cs_cpu_atom && adr_cpu[1:0] == 0:
			data_cpu_in = atom[7:0];
		cs_cpu_atom && adr_cpu[1:0] == 1:
			data_cpu_in = atom[15:8];
		cs_cpu_atom && adr_cpu[1:0] == 2:
			data_cpu_in = atom[23:16];
		cs_cpu_atom && adr_cpu[1:0] == 3:
			data_cpu_in = atom[31:24];
		cs_cpu_pa && adr_cpu[1:0] == 0:
			data_cpu_in = data_pa_out[7:0];
		cs_cpu_pa && adr_cpu[1:0] == 1:
			data_cpu_in = data_pa_in[7:0];
		cs_cpu_dut && adr_cpu[1:0] == 0:
			data_cpu_in = data_dut_in[7:0];
		cs_cpu_dut && adr_cpu[1:0] == 1:
			data_cpu_in = data_dut_in[15:8];
		cs_cpu_dut && adr_cpu[1:0] == 2:
			data_cpu_in = data_dut_in[23:16];
		cs_cpu_dut && adr_cpu[1:0] == 3:
			data_cpu_in = { 1'b0, data_pa_in[0], data_dut_in[29:24] };
		cs_cpu_io_if || cs_cpu_io_ie:
			data_cpu_in = data_cpureg_out;
		endcase

		data_cpu_in &= data_cpu_in_wand;

		if (ddrv_dbg)
			data_cpu_in = data_dbg_out;
	end

	always_comb begin
		cs_cpu_sysram   = 0;
		cs_cpu_dutram   = 0;
		cs_cpu_recram   = 0;
		cs_cpu_led0     = 0;
		cs_cpu_led1     = 0;
		cs_cpu_sw0      = 0;
		cs_cpu_sw1      = 0;
		cs_cpu_atom     = 0;
		cs_cpu_ones_set = 0;
		cs_cpu_rec      = 0;
		cs_cpu_pa       = 0;
		cs_cpu_dut      = 0;
		cs_cpu_io_if    = 0;
		cs_cpu_io_ie    = 0;

		for (int i = 0; i < NUM_COUNTERS; i++)
			cs_cpu_counter[i] = 0;

		if (r_reset_done) casez (adr_cpu)
		/* A15....A8 A7.....A0 */
		'b 0000_????_????_????: /* 0x0000-0x0fff: System RAM */
			cs_cpu_sysram = 1;
		'b 0001_????_????_????: /* 0x1000-0x1fff: Device-Under-Test RAM */
			cs_cpu_dutram = 1;
		'b 0010_????_????_????: /* 0x2000-0x2fff: Recording RAM */
			cs_cpu_recram = 1;
		'b 1111_1111_0000_0000: /* 0xff00:        LED 0-7 */
			cs_cpu_led0 = 1;
		'b 1111_1111_0000_0001: /* 0xff01:        LED 8-15 */
			cs_cpu_led1 = 1;
		'b 1111_1111_0000_0010: /* 0xff02:        SW 0-7 */
			cs_cpu_sw0 = 1;
		'b 1111_1111_0000_0011: /* 0xff03:        SW 8-15 */
			cs_cpu_sw1 = 1;
		'b 1111_1111_0001_00??: /* 0xff10-0xff13: Atomic load register */
			cs_cpu_atom = 1;
		'b 1111_1111_0001_0100: /* 0xff14:        Always one trigger */
			cs_cpu_ones_set = 1;
		'b 1111_1111_0001_0101: /* 0xff15:        Recording Control */
			cs_cpu_rec = 1;
		'b 1111_1111_0010_00??: /* 0xff20-0xff23: Counter 0 */
			if (NUM_COUNTERS > 0) cs_cpu_counter[0] = 1;
		'b 1111_1111_0010_01??: /* 0xff24-0xff27: Counter 1 */
			if (NUM_COUNTERS > 1) cs_cpu_counter[1] = 1;
		'b 1111_1111_0010_10??: /* 0xff28-0xff2b: Counter 2 */
			if (NUM_COUNTERS > 2) cs_cpu_counter[2] = 1;
		'b 1111_1111_0010_11??: /* 0xff2c-0xff2f: Counter 3 */
			if (NUM_COUNTERS > 3) cs_cpu_counter[3] = 1;
		'b 1111_1111_0011_00??: /* 0xff30-0xff33: Counter 4 */
			if (NUM_COUNTERS > 4) cs_cpu_counter[4] = 1;
		'b 1111_1111_0011_01??: /* 0xff34-0xff37: Counter 5 */
			if (NUM_COUNTERS > 5) cs_cpu_counter[5] = 1;
		'b 1111_1111_0011_10??: /* 0xff38-0xff3b: Counter 6 */
			if (NUM_COUNTERS > 6) cs_cpu_counter[6] = 1;
		'b 1111_1111_0011_11??: /* 0xff3c-0xff3f: Counter 7 */
			if (NUM_COUNTERS > 7) cs_cpu_counter[7] = 1;
		'b 1111_1111_0100_00??: /* 0xff40-0xff43: Port A */
			cs_cpu_pa = 1;
		'b 1111_1111_0101_00??: /* 0xff50-0xff53: DUT Bus */
			cs_cpu_dut = 1;
		'b 1111_1111_1111_1111: /* 0xffff:        Interrupt Enable */
			cs_cpu_io_ie = 1;
		'b 1111_1111_1111_1110: /* 0xfffe:        Interrupt Flag */
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
		.dbg_no_inc(no_inc)
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
		.siwu(ft245_siwu_out)
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
		.data_rx_valid('1),
		.data_rx_seq(dbg_data_rx_seq),
		.data_rx_ack(dbg_data_rx_ack),
		.data_tx(dbg_data_tx),
		.data_tx_seq(dbg_data_tx_seq),
		.data_tx_ack(dbg_data_tx_ack)
	);

	counter_block #(COUNTER_WIDTH, NUM_COUNTER_COMPARATORS, NUM_ROUTES) counter[0:NUM_COUNTERS-1](
		.ctrclk(pllclk),
		.busclk(cpuclk),
		.ctrrst(f_reset),

		.route_in(route),
		.route_out(route),

		.route_con(atom[NUM_ROUTES-1:0]),
		.wide_data(atom[COUNTER_WIDTH-1:0]),
		.data_in(data_cpu_out),
		.data_out(data_cpu_in_wand),
		.adr(adr_cpu[1:0]),
		.cs(cs_cpu_counter),
		.rd(rd_cpu),
		.wr(wr_cpu)
	);

	always_comb begin
		dut_data_dir_out     = r_dut_data_dir_out;
		dut_data_lvl_dir_out = r_dut_data_lvl_dir_out;
		dut_reset_out        = r_dut_reset_out;

		dut_any_cs = dut_cs_rom_in || (dut_cs_xram_in && dut_adr_in[13] && !dut_adr_in[14]);

		dut_data_lvl_ena = dut_any_cs;

		if (dut_rd_in && dut_any_cs) begin
			dut_data_lvl_dir_out = 1;

			if (r_dut_data_lvl_dir_out)
				dut_data_dir_out = 1;
		end else begin
			dut_data_dir_out = 0;

			if (!r_dut_data_dir_out)
				dut_data_lvl_dir_out = 0;
			else
				dut_data_lvl_ena = 0;
		end

		dut_reset_out = (dut_reset_out || dut_reset_set_mask) && !dut_reset_reset_mask;

		if (f_reset)
			dut_reset_out = 0;
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
		.fvalue_mask(8'hff),

		.svalue_out(data_pa_in)
	);

	dp_reg #(8) pa_out_reg2bus(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_in(pa_out),
		.fvalue_mask(8'hff),

		.svalue_out(data_pa_out)
	);

	dp_reg #(8) pa_out_set_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_out(pa_set_mask),
		.fvalue_mask(8'hff),

		.svalue_in(data_cpu_out),
		.svalue_mask({8{pa_set_sig}})
	);

	dp_reg #(8) pa_out_reset_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_out(pa_reset_mask),
		.fvalue_mask(8'hff),

		.svalue_in(data_cpu_out),
		.svalue_mask({8{pa_reset_sig}})
	);

	dp_reg #(NUM_ROUTES) pa_trigger_set_reg(
		.fclk(pllclk),
		.sclk(cpuclk),
		.frst(f_reset),

		.fvalue_out(pa_trigger_set),

		.svalue_in(atom[NUM_ROUTES-1:0]),
		.svalue_mask({NUM_ROUTES{pa_trigger_set_set}})
	);

	dp_reg #(NUM_ROUTES) pa_trigger_reset_reg(
		.fclk(pllclk),
		.sclk(cpuclk),
		.frst(f_reset),

		.fvalue_out(pa_trigger_reset),

		.svalue_in(atom[NUM_ROUTES-1:0]),
		.svalue_mask({NUM_ROUTES{pa_trigger_reset_set}})
	);

	always_ff @(posedge pllclk) begin
		pa_out <= ((pa_out | pa_set_mask) & ~pa_reset_mask);

		if (f_reset)
			pa_out <= 0;
	end

	always_ff @(posedge cpuclk) r_pa_trigger <= wr_cpu && cs_cpu_pa;
	assign pa_trigger = wr_cpu && cs_cpu_pa && !r_pa_trigger;
	assign pa_set_sig = pa_trigger && !adr_cpu[1:0];
	assign pa_reset_sig = pa_trigger && adr_cpu[1:0] == 1;
	assign pa_trigger_set_set = pa_trigger && adr_cpu[1:0] == 2 && data_cpu_out == 1;
	assign pa_trigger_reset_set = pa_trigger && &adr_cpu[1:0] && data_cpu_out == 1;

	assign pa_set_mask[0]   = |(pa_trigger_set   & route);
	assign pa_reset_mask[0] = |(pa_trigger_reset & route);

	dp_reg #(NUM_ROUTES) ones_set_reg(
		.fclk(pllclk),
		.sclk(cpuclk),
		.frst(f_reset),

		.fvalue_out(ones_set),

		.svalue_in(atom[NUM_ROUTES-1:0]),
		.svalue_mask({NUM_ROUTES{ones_set_trigger}})
	);

	assign ones_set_trigger = wr_cpu && cs_cpu_ones_set;

	dp_reg #(8) route2irq_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_in(f_irq),
		.fvalue_mask(f_irq),

		.svalue_out(irq),
		.svalue_mask(8'hff)
	);

	assign f_irq = {{(NUM_ROUTES > 8 ? 0 : 8-NUM_ROUTES){1'b0}}, route[(NUM_ROUTES > 8 ? 7 : NUM_ROUTES-1):0]};

	dp_reg #(30) dut_reg2bus(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_in(dut_in),
		.fvalue_mask(30'h3fffffff),

		.svalue_out(data_dut_in)
	);

	assign dut_in = { dut_reset_in, dut_phi_in,
	                  dut_wr_in, dut_rd_in,
	                  dut_cs_xram_in, dut_data_dir_out, dut_data_in,
	                  dut_cs_rom_in, dut_adr_in };

	dp_reg dut_reset_set_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_out(dut_reset_set_mask),
		.fvalue_mask('1),

		.svalue_in(data_cpu_out[0]),
		.svalue_mask(dut_ctl_sig)
	);

	dp_reg dut_reset_reset_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_out(dut_reset_reset_mask),
		.fvalue_mask('1),

		.svalue_in(data_cpu_out[2]),
		.svalue_mask(dut_ctl_sig)
	);

	dp_reg dut_data_set_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_out(dut_data_set_mask),
		.fvalue_mask('1),

		.svalue_in(data_cpu_out[1]),
		.svalue_mask(dut_ctl_sig)
	);

	dp_reg dut_data_reset_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_out(dut_data_reset_mask),
		.fvalue_mask('1),

		.svalue_in(data_cpu_out[3]),
		.svalue_mask(dut_ctl_sig)
	);

	dp_reg #(8) dut_data_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_out(dut_data_ovr_out),

		.svalue_in(data_cpu_out),
		.svalue_mask({8{dut_data_sig}})
	);

	dp_reg #(NUM_BUS_COMPARATORS) dut_data_compare_set_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_out(dut_data_compare_set),
		.fvalue_mask({NUM_BUS_COMPARATORS{1'b1}}),

		.svalue_in(data_cpu_out[NUM_BUS_COMPARATORS-1:0]),
		.svalue_mask({NUM_BUS_COMPARATORS{dut_cmp_sig}})
	);

	dp_reg #(NUM_BUS_COMPARATORS) dut_data_compare_mask_set_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_out(dut_data_compare_mask_set),
		.fvalue_mask({NUM_BUS_COMPARATORS{1'b1}}),

		.svalue_in(data_cpu_out[NUM_BUS_COMPARATORS-1+4:4]),
		.svalue_mask({NUM_BUS_COMPARATORS{dut_cmp_sig}})
	);

	generate for (genvar i = 0; i < NUM_BUS_COMPARATORS; i++)
		dp_reg #(NUM_ROUTES) dut_trigger_set_reg(
			.fclk(pllclk),
			.sclk(cpuclk),
			.frst(f_reset),

			.fvalue_out(dut_data_compare_trig_set[i]),

			.svalue_in(atom[NUM_ROUTES-1:0]),
			.svalue_mask({NUM_ROUTES{dut_trig_sig && data_cpu_out[i]}})
		);
	endgenerate

	generate for (genvar i = 0; i < NUM_BUS_COMPARATORS; i++)
		dp_reg #(NUM_ROUTES) dut_edge_trigger_set_reg(
			.fclk(pllclk),
			.sclk(cpuclk),
			.frst(f_reset),

			.fvalue_out(dut_data_compare_edge_trig_set[i]),

			.svalue_in(atom[NUM_ROUTES-1:0]),
			.svalue_mask({NUM_ROUTES{dut_trig_sig && data_cpu_out[i+4]}})
		);
	endgenerate

	always_ff @(posedge cpuclk) r_dut_trigger <= wr_cpu && cs_cpu_dut;
	assign dut_trigger = wr_cpu && cs_cpu_dut && !r_dut_trigger;
	assign dut_ctl_sig = dut_trigger && !adr_cpu[1:0];
	assign dut_trig_sig = dut_trigger && adr_cpu[1:0] == 1;
	assign dut_data_sig = dut_trigger && adr_cpu[1:0] == 2;
	assign dut_cmp_sig = dut_trigger && &adr_cpu[1:0];

	always_ff @(posedge pllclk) begin
		dut_data_ovr <= (dut_data_ovr | dut_data_set_mask) & !dut_data_reset_mask;

		for (int i = 0; i < NUM_BUS_COMPARATORS; i++) begin
			if (dut_data_compare_set[i])
				dut_data_compare[i] <= atom;
			if (dut_data_compare_mask_set[i])
				dut_data_compare_mask[i] <= atom;
		end

		if (f_reset) begin
			dut_data_ovr <= 0;
			for (int i = 0; i < NUM_BUS_COMPARATORS; i++) begin
				dut_data_compare[i]      <= 0;
				dut_data_compare_mask[i] <= 0;
			end
		end
	end

	always_ff @(posedge pllclk) begin
		logic [NUM_BUS_COMPARATORS-1:0] prev_matches;
		logic [NUM_ROUTES-1:0]          route_tmp;

		route_tmp = ones_set;

		for (int i = 0; i < NUM_BUS_COMPARATORS; i++) begin
			logic matches;
			matches = ({ pa_in[0], dut_in } & dut_data_compare_mask[i]) ==
			          (dut_data_compare[i] & dut_data_compare_mask[i]);
			if (matches) begin
				route_tmp |= dut_data_compare_trig_set[i];
				if (!prev_matches[i])
					route_tmp |= dut_data_compare_edge_trig_set[i];
			end
			prev_matches[i] = matches;
		end

		piped_route <= route_tmp;
	end

	assign route = piped_route;

	logic [9:0] rec_adr;
	logic [9:0] rec_adr_new;
	logic       rec_adr_set;
	logic rec_running;
	logic rec_trigger;
	logic [NUM_ROUTES-1:0] rec_capture;
	logic [NUM_ROUTES-1:0] rec_start;
	logic [NUM_ROUTES-1:0] rec_stop;
	logic rec_cap_trig, rec_start_trig, rec_stop_trig;

	dp_reg #(NUM_ROUTES) rec_start_reg(
		.fclk(pllclk),
		.sclk(cpuclk),
		.frst(f_reset),

		.fvalue_out(rec_start),

		.svalue_in(atom[NUM_ROUTES-1:0]),
		.svalue_mask({NUM_ROUTES{rec_trigger && data_cpu_out[0]}})
	);

	dp_reg #(NUM_ROUTES) rec_stop_reg(
		.fclk(pllclk),
		.sclk(cpuclk),
		.frst(f_reset),

		.fvalue_out(rec_stop),

		.svalue_in(atom[NUM_ROUTES-1:0]),
		.svalue_mask({NUM_ROUTES{rec_trigger && data_cpu_out[1]}})
	);

	dp_reg #(NUM_ROUTES) rec_capture_reg(
		.fclk(pllclk),
		.sclk(cpuclk),
		.frst(f_reset),

		.fvalue_out(rec_capture),

		.svalue_in(atom[NUM_ROUTES-1:0]),
		.svalue_mask({NUM_ROUTES{rec_trigger && data_cpu_out[2]}})
	);

	dp_reg rec_start_trig_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_out(rec_start_trig),
		.fvalue_mask('1),

		.svalue_in(data_cpu_out[3]),
		.svalue_mask(rec_trigger)
	);

	dp_reg rec_stop_trig_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_out(rec_stop_trig),
		.fvalue_mask('1),

		.svalue_in(data_cpu_out[4]),
		.svalue_mask(rec_trigger)
	);

	dp_reg rec_cap_trig_reg(
		.fclk(pllclk),
		.sclk(cpuclk),

		.fvalue_out(rec_cap_trig),
		.fvalue_mask('1),

		.svalue_in(data_cpu_out[5]),
		.svalue_mask(rec_trigger)
	);

	dp_reg #(11) rec_adr_reg(
		.fclk(pllclk),
		.sclk(cpuclk),
		.frst(f_reset),

		.fvalue_out({ rec_adr_set, rec_adr_new }),
		.fvalue_mask(11'b1xxxxxxxxxx),
		.fvalue_in(11'b0xxxxxxxxxx),

		.svalue_in({ 1'b1, atom[9:0] }),
		.svalue_mask({11{rec_trigger && data_cpu_out[7]}})
	);

	assign rec_trigger = wr_cpu && cs_cpu_rec;

	always_ff @(posedge pllclk) begin
		logic start, stop, capture;

		start   = (rec_start & route) || rec_start_trig;
		stop    = (rec_stop & route) || rec_stop_trig;
		capture = rec_running && ((rec_capture & route) || rec_cap_trig);

		/* Toggle if start and stop are signaled at the same time */
		if (start && rec_running)
			start = 0;
		if (stop && !rec_running)
			stop = 0;

		/* Always do one capture when stopping with bit 31 set */
		if (stop)
			capture = 1;

		if (capture) begin
			recram[rec_adr] <= { stop, pa_in[0], dut_in[29:0] };
			rec_adr         <= rec_adr + 1;
		end

		if (rec_adr_set)
			rec_adr <= rec_adr_new;

		if (start || stop)
			rec_running <= start;
	end

endmodule
