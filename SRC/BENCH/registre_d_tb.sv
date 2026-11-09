`timescale 1ns / 1ps
module registre_d_tb (
//empty declarative part
);
// Internal net declaration
logic clock_s, resetb_s, d_s, q_s, sel_s;
//DUT : component instanciation
registre_d DUT (
	.state_i(d_s),
	.resetb_i(resetb_s),
	.clock_i(clock_s),
	.sel_i(sel_s),
	.state_o(q_s)
);
//clock generation
initial begin
	clock_s = 1'b0;
	forever #5 clock_s = ~clock_s;
end// stimuli
	initial begin
		resetb_s = 1'b0;
		sel_s = 1'b0;
		d_s = 1'b0;
		#20;
		sel_s=1'b1;
		#30;
		resetb_s = 1'b1;
		#25;
		d_s = 1'b1;
		#50;
		d_s = 1'b0;
		#50;
	end
endmodule : registre_d_tb
