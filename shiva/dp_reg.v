`default_nettype none

(* nolatches *)
module dp_reg #(
		parameter WIDTH       = 16,
		          RESET_VALUE = 0,
		          RESET_MASK  = 'hffffffff,
	) (
		input  wire             fclk,
		input  wire             sclk,
		input  wire             frst        = 0,

		input  wire [WIDTH-1:0] fvalue_mask = 0,
		input  wire [WIDTH-1:0] fvalue_in   = 0,
		output reg  [WIDTH-1:0] fvalue_out,

		input  wire [WIDTH-1:0] svalue_mask = 0,
		input  wire [WIDTH-1:0] svalue_in   = 0,
		output reg  [WIDTH-1:0] svalue_out,
	);

	reg f2s_fseq, f2s_sseq;
	reg f2s_fack, f2s_sack;
	cdc f2s_seq_cdc(sclk, f2s_fseq, f2s_sseq);
	cdc f2s_ack_cdc(fclk, f2s_sack, f2s_fack);
	reg [WIDTH-1:0] f2s_value;

	reg s2f_fseq, s2f_sseq;
	reg s2f_fack, s2f_sack;
	cdc s2f_seq_cdc(fclk, s2f_sseq, s2f_fseq);
	cdc s2f_ack_cdc(sclk, s2f_fack, s2f_sack);
	reg [WIDTH-1:0] s2f_mask;
	reg [WIDTH-1:0] s2f_value;

	always @(posedge sclk) begin
		if (f2s_sseq != f2s_sack) begin
			svalue_out <= f2s_value;
			f2s_sack   <= f2s_sseq;
		end

		if (s2f_sseq == s2f_sack && svalue_mask) begin
			s2f_mask  <= svalue_mask;
			s2f_value <= svalue_in;
			s2f_sseq  <= !s2f_sack;
		end
	end

	always @(posedge fclk) begin
		fvalue_out <= (fvalue_in & fvalue_mask) | (fvalue_out & ~fvalue_mask);

		if (f2s_fseq == f2s_fack) begin
			f2s_value <= fvalue_out;
			f2s_fseq  <= !f2s_fack;
		end

		if (s2f_fseq != s2f_fack) begin
			fvalue_out <= (s2f_value & s2f_mask) | (fvalue_out & ~s2f_mask);
			s2f_fack   <= s2f_fseq;
		end

		if (frst) begin
			s2f_fack   <= s2f_fseq;
			fvalue_out <= (RESET_VALUE & RESET_MASK) | (fvalue_out & ~RESET_MASK);
		end
	end

endmodule
