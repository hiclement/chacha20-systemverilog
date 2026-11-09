`timescale 1ns / 1ps
module xor_module 

(
	input logic [127:0] a_i, 
	input logic [127:0] b_i, 
	output logic [127:0] cipher_o

);

//structural description
assign cipher_o = a_i ^ b_i;


endmodule : xor_module

