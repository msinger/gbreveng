`default_nettype none

(* nolatches *)
module counter #(
		parameter int WIDTH = 16
	) (
		input  logic             clk,
		input  logic             sysrst,

		output logic [WIDTH-1:0] value,
		input  logic [WIDTH-1:0] ivalue,

		input  logic             start,
		input  logic             stop,
		input  logic             reset,
		input  logic             load,
		input  logic             count
	);

	logic running;

	always_ff @(posedge clk) begin
		case (1)
		start && stop:
			running <= !running;
		start:
			running <= 1;
		stop:
			running <= 0;
		endcase

		case (1)
		reset:
			value <= 0;
		load:
			value <= ivalue;
		count && running:
			value <= value + 1;
		endcase

		if (sysrst) begin
			value   <= 0;
			running <= 0;
		end
	end

endmodule
