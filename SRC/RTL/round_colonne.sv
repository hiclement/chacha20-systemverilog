`timescale 1ns / 1ps

module round_colonne 
import chacha_pck::*;
(
input state_t round_i, 
output state_t round_o
);

quarter_round quarter_round_1 (
 	 .a_i (round_i[0]),
 	 .b_i (round_i[4]),
 	 .c_i (round_i[8]),
 	 .d_i (round_i[12]),
 	 .a_o (round_o[0]),
 	 .b_o (round_o[4]),
 	 .c_o (round_o[8]),
 	 .d_o (round_o[12])
);

quarter_round quarter_round_2 (
 	 .a_i (round_i[1]),
 	 .b_i (round_i[5]),
 	 .c_i (round_i[9]),
 	 .d_i (round_i[13]),
 	 .a_o (round_o[1]),
 	 .b_o (round_o[5]),
 	 .c_o (round_o[9]),
 	 .d_o (round_o[13])
);
 		
quarter_round quarter_round_3 (
 	 .a_i (round_i[2]),
 	 .b_i (round_i[6]),
 	 .c_i (round_i[10]),
 	 .d_i (round_i[14]),
 	 .a_o (round_o[2]),
 	 .b_o (round_o[6]),
 	 .c_o (round_o[10]),
 	 .d_o (round_o[14])
);

quarter_round quarter_round_4 (
 	 .a_i (round_i[3]),
 	 .b_i (round_i[7]),
 	 .c_i (round_i[11]),
 	 .d_i (round_i[15]),
 	 .a_o (round_o[3]),
 	 .b_o (round_o[7]),
 	 .c_o (round_o[11]),
 	 .d_o (round_o[15])
);
 			
endmodule : round_colonne 
