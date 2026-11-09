
`timescale 1ns / 1ps
module round_tb (
//empty declarative part
);

import chacha_pck::*;
// internal net declaration
state_t round_i_s;
state_t round_o_s;

//DUT : component instanciation
round_colonne DUT (
	.round_i(round_i_s),
	.round_o(round_o_s)
);

initial begin
	round_i_s[0] = 32'h61707865 ;
	round_i_s[1] = 32'h3320646e ;
	round_i_s[2] = 32'h79622d32 ;
	round_i_s[3] = 32'h6b206574 ;
	round_i_s[4] = 32'he921c73a ;
	round_i_s[5] = 32'h76a2b5ea ;
	round_i_s[6] = 32'h322fdc9a ;
	round_i_s[7] = 32'h27a09386 ;
	round_i_s[8] = 32'hd52a3eec ;
	round_i_s[9] = 32'hd3a53fef ;
	round_i_s[10] = 32'h860e69ae ;
	round_i_s[11] = 32'h4e7ced7e ;
	round_i_s[12] = 32'h00000001 ;
	round_i_s[13] = 32'h06e46ce3 ;
	round_i_s[14] = 32'hcaccf259 ;
	round_i_s[15] = 32'hd4ac91b9 ;
end
endmodule : round_tb
