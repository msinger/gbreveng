`default_nettype none

(* nolatches *)
module img #(
		parameter width  = 160,
		parameter height = 144
	) (
		input  wire [7:0] x,
		input  wire [7:0] y,
		output reg  [1:0] value
	);

	always @* begin
		value = 0;

		if (y == 0 || y == height - 1) begin
			if (x <= 4 || x >= width - 5)
				value = 3;
		end

		if (x == 0 || x == width - 1) begin
			if (y <= 4 || y >= height - 5)
				value = 3;
		end

		if (y >= 20 && y < height - 20) begin
			if (x < width / 4)
				value = (y < height / 2) ? 0 : 3;
			else if (x < width / 2)
				value = (y < height / 2) ? 1 : 2;
			else if (x < width / 2 + width / 4)
				value = (y < height / 2) ? 2 : 1;
			else
				value = (y < height / 2) ? 3 : 0;
		end
	end

endmodule
