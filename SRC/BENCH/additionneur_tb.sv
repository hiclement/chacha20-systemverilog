`timescale 1ns / 1ps
module additionneur_tb
import chacha_pck::*;
(
// vide
);

// declaration des stimuli 
state_t chachaed_s;
state_t initial_s;
state_t keystream_s;

//DUT : component instanciation
additionneur DUT
( 
	.chachaed_i(chachaed_s),
	.initial_i(initial_s),
	.keystream_o(keystream_s)
);

//affectation des stimulis 
initial begin
	chachaed_s[0]= 1'b1;
	chachaed_s[1]= 1'b0;
	initial_s[0]=1'b1;
	initial_s[1]= 1'b0;


end
endmodule : additionneur_tb
