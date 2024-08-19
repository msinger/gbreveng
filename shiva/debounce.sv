`default_nettype none

(* nolatches *)
module debounce #(
		parameter int   DEPTH   = 4,
		parameter logic INITIAL = 0
	) (
		input  logic clk,
		input  logic in,
		output logic out,
		output logic nout
	);

	initial out  = INITIAL;
	initial nout = !INITIAL;

	always_ff @(posedge clk) begin
		logic [DEPTH-1:0] hist;
		logic             equal;
		logic             inv;

		inv <= !in;

		for (int i = 0; i < DEPTH - 1; i++)
			hist[i] = hist[i + 1];
		hist[DEPTH - 1] = in;

		equal = 1;

		for (int i = 0; i < DEPTH - 1; i++)
			equal = equal && hist[i] == hist[i + 1];

		if (equal) begin
			out <= hist[0];
			nout <= inv;
		end
	end

endmodule
