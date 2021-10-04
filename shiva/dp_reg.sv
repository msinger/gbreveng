`default_nettype none

(* nolatches *)
module dp_reg #(
		parameter int WIDTH       = 1,
		              RESET_VALUE = 0,
		              RESET_MASK  = '1
	) (
		input  logic             fclk,
		input  logic             sclk,
		input  logic             frst        = 0,

		input  logic [WIDTH-1:0] fvalue_mask = 0,
		input  logic [WIDTH-1:0] fvalue_in   = 0,
		output logic [WIDTH-1:0] fvalue_out,

		input  logic [WIDTH-1:0] svalue_mask = 0,
		input  logic [WIDTH-1:0] svalue_in   = 0,
		output logic [WIDTH-1:0] svalue_out
	);

	logic f2s_fseq, f2s_sseq;
	logic f2s_fack, f2s_sack;
	cdc f2s_seq_cdc(sclk, f2s_fseq, f2s_sseq);
	cdc f2s_ack_cdc(fclk, f2s_sack, f2s_fack);
	logic [WIDTH-1:0] f2s_value;

	logic s2f_fseq, s2f_sseq;
	logic s2f_fack, s2f_sack;
	cdc s2f_seq_cdc(fclk, s2f_sseq, s2f_fseq);
	cdc s2f_ack_cdc(sclk, s2f_fack, s2f_sack);
	logic [WIDTH-1:0] s2f_mask;
	logic [WIDTH-1:0] s2f_value;

	always_ff @(posedge sclk) begin
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

	always_ff @(posedge fclk) begin
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
