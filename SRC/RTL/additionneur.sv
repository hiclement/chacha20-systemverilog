`timescale 1ns / 1ps
module additionneur 
import chacha_pck::*;

(
input state_t chachaed_i, 
input state_t initial_i,
output state_t keystream_o
);

//structural description
always_comb begin
	for (int i =0; i<16 ; i++) begin
		  keystream_o[i]= chachaed_i[i] + initial_i[i] ;
		end
	end



endmodule : additionneur

