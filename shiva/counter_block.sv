`default_nettype none

(* nolatches *)
module counter_block #(
		parameter int WIDTH           = 16,
		              NUM_COMPARATORS = 8,
		              NUM_ROUTES      = 16
	) (
		input  logic                       ctrclk,
		input  logic                       busclk,
		input  logic                       ctrrst,

		input  logic      [NUM_ROUTES-1:0] route_in,
		output wor logic  [NUM_ROUTES-1:0] route_out,

		input  logic      [NUM_ROUTES-1:0] route_con,
		input  logic      [WIDTH-1:0]      wide_data,
		input  logic      [7:0]            data_in,
		output wand logic [7:0]            data_out,
		input  logic      [1:0]            adr,
		input  logic                       cs,
		input  logic                       rd,
		input  logic                       wr
	);

	logic      [WIDTH-1:0]           value;
	logic      [WIDTH-1:0]           value_bus;
	logic      [WIDTH-1:0]           load_value;
	wire logic [WIDTH-1:0]           compare_value[0:NUM_COMPARATORS-1];
	logic                            load_set;
	logic      [NUM_COMPARATORS-1:0] compare_set;
	logic                            bus_trigger;
	logic                            r_bus_trigger;
	logic      [4:0]                 bus_trigger_sig;
	wire logic [NUM_ROUTES-1:0]      trigger_in[0:4];
	wire logic [NUM_ROUTES-1:0]      compare_trigger_out[0:NUM_COMPARATORS-1];
	logic      [4:0]                 trigger_in_set;
	logic      [NUM_COMPARATORS-1:0] compare_trigger_out_set;

	counter #(WIDTH) counter(
		.clk(ctrclk),
		.sysrst(ctrrst),

		.value(value),
		.ivalue(load_value),

		.start(bus_trigger_sig[0] || route_in & trigger_in[0]),
		.stop (bus_trigger_sig[1] || route_in & trigger_in[1]),
		.reset(bus_trigger_sig[2] || route_in & trigger_in[2]),
		.load (bus_trigger_sig[3] || route_in & trigger_in[3]),
		.count(bus_trigger_sig[4] || route_in & trigger_in[4])
	);

	dp_reg #(WIDTH) load_reg(
		.fclk(ctrclk),
		.sclk(busclk),
		.frst(ctrrst),

		.fvalue_out(load_value),

		.svalue_in(wide_data),
		.svalue_mask({WIDTH{load_set}})
	);

	dp_reg #(5) bus_trigger_reg(
		.fclk(ctrclk),
		.sclk(busclk),
		.frst(ctrrst),

		.fvalue_out(bus_trigger_sig),
		.fvalue_mask(5'b11111),

		.svalue_in(data_in[4:0]),
		.svalue_mask({5{(bus_trigger && !adr)}})
	);

	dp_reg #(WIDTH) value_reg2bus(
		.fclk(ctrclk),
		.sclk(busclk),

		.fvalue_in(value),
		.fvalue_mask({WIDTH{1'b1}}),

		.svalue_out(value_bus)
	);

	generate
		if (WIDTH > 24) begin
			assign data_out = (rd && cs && adr == 0) ? value_bus[7:0]        : 'hff;
			assign data_out = (rd && cs && adr == 1) ? value_bus[15:8]       : 'hff;
			assign data_out = (rd && cs && adr == 2) ? value_bus[23:16]      : 'hff;
			assign data_out = (rd && cs && adr == 3) ? value_bus[WIDTH-1:24] : 'hff;
		end else if (WIDTH > 16) begin
			assign data_out = (rd && cs && adr == 0) ? value_bus[7:0]        : 'hff;
			assign data_out = (rd && cs && adr == 1) ? value_bus[15:8]       : 'hff;
			assign data_out = (rd && cs && adr == 2) ? value_bus[WIDTH-1:16] : 'hff;
			assign data_out = (rd && cs && adr == 3) ? 0                     : 'hff;
		end else if (WIDTH > 8) begin
			assign data_out = (rd && cs && adr == 0) ? value_bus[7:0]        : 'hff;
			assign data_out = (rd && cs && adr == 1) ? value_bus[WIDTH-1:8]  : 'hff;
			assign data_out = (rd && cs && adr == 2) ? 0                     : 'hff;
			assign data_out = (rd && cs && adr == 3) ? 0                     : 'hff;
		end else begin
			assign data_out = (rd && cs && adr == 0) ? value_bus[WIDTH-1:0]  : 'hff;
			assign data_out = (rd && cs && adr == 1) ? 0                     : 'hff;
			assign data_out = (rd && cs && adr == 2) ? 0                     : 'hff;
			assign data_out = (rd && cs && adr == 3) ? 0                     : 'hff;
		end

		for (genvar i = 0; i < NUM_COMPARATORS; i++) begin
			dp_reg #(WIDTH) compare_reg(
				.fclk(ctrclk),
				.sclk(busclk),
				.frst(ctrrst),

				.fvalue_out(compare_value[i]),

				.svalue_in(wide_data),
				.svalue_mask({WIDTH{compare_set[i]}})
			);

			dp_reg #(NUM_ROUTES) compare_trigger_out_reg(
				.fclk(ctrclk),
				.sclk(busclk),
				.frst(ctrrst),

				.fvalue_out(compare_trigger_out[i]),

				.svalue_in(route_con),
				.svalue_mask({NUM_ROUTES{compare_trigger_out_set[i]}})
			);

			assign route_out = {NUM_ROUTES{compare_value[i] == value}} & compare_trigger_out[i];
		end

		for (genvar i = 0; i < 5; i++) begin
			dp_reg #(NUM_ROUTES) trigger_in_reg(
				.fclk(ctrclk),
				.sclk(busclk),
				.frst(ctrrst),

				.fvalue_out(trigger_in[i]),

				.svalue_in(route_con),
				.svalue_mask({NUM_ROUTES{trigger_in_set[i]}})
			);
		end
	endgenerate

	always_ff @(posedge busclk) r_bus_trigger <= wr && cs;
	assign bus_trigger             = wr && cs && !r_bus_trigger;
	assign load_set                = bus_trigger && !adr && data_in[7];
	assign compare_set             = {NUM_COMPARATORS{bus_trigger && adr == 1}} & data_in[NUM_COMPARATORS-1:0];
	assign trigger_in_set          = {5{bus_trigger && adr == 2}} & data_in[4:0];
	assign compare_trigger_out_set = {NUM_COMPARATORS{bus_trigger && &adr}} & data_in[NUM_COMPARATORS-1:0];

endmodule
