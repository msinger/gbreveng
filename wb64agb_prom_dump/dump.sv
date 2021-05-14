`default_nettype none

(* nolatches *)
module dump(
		input  logic       clk12m,
		output logic [7:0] led     = 0,
		input  logic       rx,
		output logic       tx      = 1,
		input  logic       rts,
		output logic       cts     = 0,
		input  logic       dtr,
		output logic       dsr     = 0,
		output logic       dcd     = 0,
		input  logic       start,
		input  logic       data,
		output logic       clk     = 0,
		output logic       n_reset = 0,
		output logic       n_ce    = 1,
	);

	logic start_trigger = 0;
	logic start_in;

	logic [3:0] count  = 0;

	logic [7:0] din    = 0;
	logic [7:0] dout   = 0;
	logic       dvalid = 0;

	logic [7:0] state = 0;

	logic [3:0] clkdiv = 0;
	logic clk1m        = clkdiv[3];

	always_ff @(posedge clk12m) begin
		clkdiv++;
		if (clkdiv >= 14)
			clkdiv = 2;
	end

	SB_IO #(
			.PIN_TYPE('b 0000_00),
			.PULLUP(1),
		) start_io (
			.PACKAGE_PIN(start),
			.INPUT_CLK(clk12m),
			.D_IN_0(start_in),
		);

	always_ff @(posedge clk1m) start_trigger <= start_in;

	always_ff @(posedge clk1m) count++;

	always_ff @(posedge clk1m) case (state)
		0: begin
			led     <= 0;
			n_reset <= 0;
			n_ce    <= 1;
			clk     <= 0;
			dvalid  <= 0;

			if (count == 15)
				state <= 1;
		end

		1: begin
			if (count == 15 && start_trigger)
				state <= 2;
		end

		2: begin
			n_reset <= 0;
			n_ce    <= 0;
			clk     <= 0;
			dvalid  <= 0;

			if (count >= 4)
				n_reset <= 1;

			if (count == 15)
				state <= 3;
		end

		3: begin
			if (!count[0]) begin
				clk <= 1;
				din <= { data, din[7:1] };
			end

			if (count[0])
				clk <= 0;

			if (count == 15) begin
				dout   <= din;
				dvalid <= 1;
				led++;
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
