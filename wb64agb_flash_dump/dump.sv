`default_nettype none

/*
 * The flash requires n_reset to be low during power up, so you need
 * to power up the FPGA first and then plug in VCC of the flash before
 * triggering the dump.
 */

(* nolatches *)
module dump(
		input  logic        clk12m,
		output logic [7:0]  led     = 0,
		input  logic        rx,
		output logic        tx      = 1,
		input  logic        rts,
		output logic        cts     = 0,
		input  logic        dtr,
		output logic        dsr     = 0,
		output logic        dcd     = 0,
		input  logic        start,
		output logic [21:0] a       = 0,
		inout  logic [7:0]  d,
		input  logic        ready,
		output logic        n_reset = 0,
		output logic        n_ce    = 1,
		output logic        n_oe    = 1,
		output logic        n_we    = 1
	);

	localparam bit read_identifier_codes = 0;

	logic start_trigger = 0;
	logic start_in;

	logic [7:0] d_out    = 0;
	logic [7:0] d_in;
	logic       d_outdir = 0;
	logic       ready_in;

	logic [3:0] count  = 0;

	logic [7:0] dout   = 0;
	logic       dvalid = 0;

	logic [7:0] state  = 0;

	logic [3:0] clkdiv = 0;
	logic clk1m        = clkdiv[3];

	always_ff @(posedge clk12m) begin
		logic [3:0] clk_tmp;
		clk_tmp = clkdiv + 1;
		if (clk_tmp >= 14)
			clk_tmp = 2;
		clkdiv <= clk_tmp;
	end

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1)
		) start_io (
			.PACKAGE_PIN(start),
			.INPUT_CLK(clk12m),
			.D_IN_0(start_in)
		);

	SB_IO #(
			.PIN_TYPE('b 1010_00),
			.PULLUP(1)
		) d_io[7:0] (
			.PACKAGE_PIN(d),
			.INPUT_CLK(clk12m),
			.OUTPUT_ENABLE(d_outdir),
			.D_OUT_0(d_out),
			.D_IN_0(d_in)
		);

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1)
		) ready_io[7:0] (
			.PACKAGE_PIN(ready),
			.INPUT_CLK(clk12m),
			.D_IN_0(ready_in)
		);

	always_ff @(posedge clk1m) start_trigger <= start_in;

	always_ff @(posedge clk1m) count <= count + 1;

	always_ff @(posedge clk1m) case (state)
		0: begin
			led      <= 0;
			n_reset  <= 0;
			n_ce     <= 1;
			n_oe     <= 1;
			n_we     <= 1;
			a        <= 0;
			d_outdir <= 0;
			d_out    <= 0;
			dvalid   <= 0;
			dout     <= 0;

			if (count == 15)
				state <= 1;
		end

		1: begin
			if (count == 15 && start_trigger)
				state <= 2;
		end

		2: begin
			if (count >= 4)
				n_reset <= 1;

			if (read_identifier_codes) begin
				if (count == 8) begin
					n_ce     <= 0;
					d_outdir <= 1;
					d_out    <= 'h90;
				end
				if (count == 9)
					n_we     <= 0;
				if (count == 10)
					n_we     <= 1;
				if (count == 11) begin
					n_ce     <= 1;
					d_outdir <= 0;
					d_out    <= 0;
				end
			end

			if (count == 15) begin
				a     <= '1;
				state <= 3;
			end
		end

		3: begin
			if (count == 0) begin
				n_ce <= 1;
				n_oe <= 1;
			end

			if (count == 1)
				a <= a + 1;

			if (count == 8)
				n_ce <= 0;

			if (count == 11)
				n_oe <= 0;

			if (count == 15) begin
				dout   <= d_in;
				dvalid <= 1;
				if (!&led)
					led <= { a[21:15], &a[14:0] };
			end
		end
	endcase

	always_ff @(posedge clk1m) begin
		tx <= 1;

		if (state == 3 && dvalid) begin
			if (count == 7)
				tx <= 0;

			if (count >= 8)
				tx <= dout[count[2:0]];
		end
	end

endmodule
