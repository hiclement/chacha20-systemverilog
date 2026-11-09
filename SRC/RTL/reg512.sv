`timescale 1ns / 1ps
module reg512 
import chacha_pck::*;
(

input state_t state_i,
input logic clock_i,
input logic resetb_i,
input logic sel_i,
output state_t state_o
);
//sequential process
always_ff @(posedge clock_i or negedge resetb_i)
begin : seq_0
if (resetb_i == 1'b0)
//affectation non bloquante <=
	state_o <= '0; // pour toutes les cases du tableau,  state_o<='{default;'0}
else 
	if (sel_i == 1'b1)
		state_o <= state_i;
end : seq_0
endmodule : reg512


