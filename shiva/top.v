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

	genvar  i, j;
	integer k;

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

	(* mem2reg *)
	reg  cs_cpu_counter[0:`NUM_COUNTERS-1];

	wire [7:0] data_cpu_out;
	wire [7:0] data_cpu_in;
	reg  [7:0] data_cpu_in_r;
	wand [7:0] data_cpu_in_wand;
	wire [7:0] data_cpureg_out;
	reg  [7:0] data_sysram_out;
	reg  [7:0] data_dutram_out;
	reg  [7:0] data_recram_out;
	wire [7:0] data_dbg_out;

	reg  [31:0] atom;

	wire [`COUNTER_WIDTH-1:0]   counter_value[0:`NUM_COUNTERS-1];
	wire [`COUNTER_WIDTH-1:0]   counter_value_cpu[0:`NUM_COUNTERS-1];
	wire [`COUNTER_WIDTH-1:0]   counter_load_value[0:`NUM_COUNTERS-1];
	wire [`COUNTER_WIDTH-1:0]   counter_compare_value[0:`NUM_COUNTERS-1][0:`NUM_COMPARATORS-1];
	wire                        counter_load_set[0:`NUM_COUNTERS-1];
	wire [`NUM_COMPARATORS-1:0] counter_compare_set[0:`NUM_COUNTERS-1];
	wire                        counter_cpu_trigger[0:`NUM_COUNTERS-1];
	(* mem2reg *)
	reg                         r_counter_cpu_trigger[0:`NUM_COUNTERS-1];
	wire [4:0]                  counter_cpu_trigger_sig[0:`NUM_COUNTERS-1];
	wire [`NUM_ROUTES-1:0]      counter_trigger_in[0:`NUM_COUNTERS-1][0:4];
	wire [`NUM_ROUTES-1:0]      counter_compare_trigger_out[0:`NUM_COUNTERS-1][0:`NUM_COMPARATORS-1];
	wire [4:0]                  counter_trigger_in_set[0:`NUM_COUNTERS-1];
	wire [`NUM_COMPARATORS-1:0] counter_compare_trigger_out_set[0:`NUM_COUNTERS-1];

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

	reg  [7:0] sysram[0:4095];
	reg  [7:0] dutram[0:4095];
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
		data_dutram_out <= dutram[adr_cpu[11:0]];
		data_recram_out <= recram[adr_cpu[11:0]];

		if (wr_cpu) case (1)
		cs_cpu_sysram:
			sysram[adr_cpu[11:0]] <= data_cpu_out;
		cs_cpu_dutram:
			dutram[adr_cpu[11:0]] <= data_cpu_out;
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
		cs_cpu_io_if || cs_cpu_io_ie:
			data_cpu_in_r = data_cpureg_out;
		endcase
	end

	assign data_cpu_in_wand = data_cpu_in_r;
	assign data_cpu_in = ddrv_dbg ? data_dbg_out : data_cpu_in_wand;

	always @* begin
		cs_cpu_sysram = 0;
		cs_cpu_dutram = 0;
		cs_cpu_recram = 0;
		cs_cpu_led0   = 0;
		cs_cpu_led1   = 0;
		cs_cpu_sw0    = 0;
		cs_cpu_sw1    = 0;
		cs_cpu_atom   = 0;
		cs_cpu_io_if  = 0;
		cs_cpu_io_ie  = 0;

		for (k = 0; k < `NUM_COUNTERS; k = k + 1)
			cs_cpu_counter[k] = 0;

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

	generate for (j = 0; j < `NUM_COUNTERS; j = j + 1) begin
		if (`COUNTER_WIDTH > 24) begin
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 0) ? counter_value_cpu[j][7:0] : 'hff;
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 1) ? counter_value_cpu[j][15:8] : 'hff;
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 2) ? counter_value_cpu[j][23:16] : 'hff;
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 3) ?
			                          counter_value_cpu[j][`COUNTER_WIDTH-1:24] : 'hff;
		end else if (`COUNTER_WIDTH > 16) begin
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 0) ? counter_value_cpu[j][7:0] : 'hff;
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 1) ? counter_value_cpu[j][15:8] : 'hff;
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 2) ?
			                          counter_value_cpu[j][`COUNTER_WIDTH-1:16] : 'hff;
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 3) ? 0 : 'hff;
		end else if (`COUNTER_WIDTH > 8) begin
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 0) ? counter_value_cpu[j][7:0] : 'hff;
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 1) ?
			                          counter_value_cpu[j][`COUNTER_WIDTH-1:8] : 'hff;
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 2) ? 0 : 'hff;
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 3) ? 0 : 'hff;
		end else begin
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 0) ?
			                          counter_value_cpu[j][`COUNTER_WIDTH-1:0] : 'hff;
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 1) ? 0 : 'hff;
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 2) ? 0 : 'hff;
			assign data_cpu_in_wand = (cs_cpu_counter[j] && adr_cpu[1:0] == 3) ? 0 : 'hff;
		end

		counter #(`COUNTER_WIDTH) counter(
			.clk(pllclk),
			.sysrst(f_reset),

			.value(counter_value[j]),
			.ivalue(counter_load_value[j]),

			.start(counter_cpu_trigger_sig[j][0] || route & counter_trigger_in[j][0]),
			.stop (counter_cpu_trigger_sig[j][1] || route & counter_trigger_in[j][1]),
			.reset(counter_cpu_trigger_sig[j][2] || route & counter_trigger_in[j][2]),
			.load (counter_cpu_trigger_sig[j][3] || route & counter_trigger_in[j][3]),
			.count(counter_cpu_trigger_sig[j][4] || route & counter_trigger_in[j][4]),
		);

		dp_reg #(`COUNTER_WIDTH) counter_load_reg(
			.fclk(pllclk),
			.sclk(cpuclk),
			.frst(f_reset),

			.fvalue_out(counter_load_value[j]),

			.svalue_in(atom[`COUNTER_WIDTH-1:0]),
			.svalue_mask({`COUNTER_WIDTH{counter_load_set[j]}}),
		);

		dp_reg #(5) counter_cpu_trigger_reg(
			.fclk(pllclk),
			.sclk(cpuclk),
			.frst(f_reset),

			.fvalue_out(counter_cpu_trigger_sig[j]),
			.fvalue_mask('b11111),

			.svalue_in(data_cpu_out[4:0]),
			.svalue_mask({5{(counter_cpu_trigger[j] && !adr_cpu[1:0])}}),
		);

		dp_reg #(`COUNTER_WIDTH) counter_value_reg2cpu(
			.fclk(pllclk),
			.sclk(cpuclk),

			.fvalue_in(counter_value[j]),
			.fvalue_mask({`COUNTER_WIDTH{1'b1}}),

			.svalue_out(counter_value_cpu[j]),
		);

		for (i = 0; i < `NUM_COMPARATORS; i = i + 1) begin
			dp_reg #(`COUNTER_WIDTH) counter_compare_reg(
				.fclk(pllclk),
				.sclk(cpuclk),
				.frst(f_reset),

				.fvalue_out(counter_compare_value[j][i]),

				.svalue_in(atom[`COUNTER_WIDTH-1:0]),
				.svalue_mask({`COUNTER_WIDTH{counter_compare_set[j][i]}}),
			);

			dp_reg #(`NUM_ROUTES) counter_compare_trigger_out_reg(
				.fclk(pllclk),
				.sclk(cpuclk),
				.frst(f_reset),

				.fvalue_out(counter_compare_trigger_out[j][i]),

				.svalue_in(atom[`NUM_ROUTES-1:0]),
				.svalue_mask({`NUM_ROUTES{counter_compare_trigger_out_set[j][i]}}),
			);

			assign route = {`NUM_ROUTES{counter_compare_value[j][i] == counter_value[j]}} &
			               counter_compare_trigger_out[j][i];
		end

		for (i = 0; i < 5; i = i + 1) begin
			dp_reg #(`NUM_ROUTES) counter_trigger_in_reg(
				.fclk(pllclk),
				.sclk(cpuclk),
				.frst(f_reset),

				.fvalue_out(counter_trigger_in[j][i]),

				.svalue_in(atom[`NUM_ROUTES-1:0]),
				.svalue_mask({`NUM_ROUTES{counter_trigger_in_set[j][i]}}),
			);
		end

		always @(posedge cpuclk) r_counter_cpu_trigger[j] <= wr_cpu && cs_cpu_counter[j];
		assign counter_cpu_trigger[j]             = wr_cpu && cs_cpu_counter[j] && !r_counter_cpu_trigger[j];
		assign counter_load_set[j]                = counter_cpu_trigger[j] && !adr_cpu[1:0] && data_cpu_out[7];
		assign counter_compare_set[j]             = {`NUM_COMPARATORS{counter_cpu_trigger[j] && adr_cpu[1:0] == 1}} &
		                                            data_cpu_out[`NUM_COMPARATORS-1:0];
		assign counter_trigger_in_set[j]          = {5{counter_cpu_trigger[j] && adr_cpu[1:0] == 2}} &
		                                            data_cpu_out[4:0];
		assign counter_compare_trigger_out_set[j] = {`NUM_COMPARATORS{counter_cpu_trigger[j] && &adr_cpu[1:0]}} &
		                                            data_cpu_out[`NUM_COMPARATORS-1:0];
	end endgenerate

endmodule
