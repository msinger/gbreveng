`default_nettype none

(* nolatches *)
module counter #(
		parameter WIDTH = 16,
	) (
		input  wire             clk,
		input  wire             sysrst,

		output reg  [WIDTH-1:0] value,
		input  wire [WIDTH-1:0] ivalue,

		input  wire             start,
		input  wire             stop,
		input  wire             reset,
		input  wire             load,
		input  wire             count,
	);

	reg running;

	always @(posedge clk) begin
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
