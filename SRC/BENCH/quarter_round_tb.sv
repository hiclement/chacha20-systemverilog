`timescale 1ns / 1ps
module quarter_round_tb (
//empty declarative part
);

// internal net declaration
logic [31:0] ain_s;
logic [31:0] bin_s;
logic [31:0] cin_s; 
logic [31:0] din_s;
logic [31:0] aout_s; 
logic [31:0] bout_s; 
logic [31:0] cout_s; 
logic [31:0] dout_s;

//DUT : component instanciation
quarter_round DUT (

	.a_i(ain_s),
	.b_i(bin_s),
	.c_i(cin_s),
	.d_i(din_s),
	.a_o(aout_s),
	.b_o(bout_s),
	.c_o(cout_s),
	.d_o(dout_s)
);

//affectation des stimulis 
initial begin
	ain_s = 32'h11111111;
	bin_s = 32'h01020304;
	cin_s = 32'h9b8d6f43;
	din_s = 32'h01234567;
end
endmodule : quarter_round_tb
