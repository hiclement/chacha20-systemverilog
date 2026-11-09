`timescale 1ns / 1ps
module arx #(parameter nb_bits=16)

(
	input logic [31:0] augend_i, 
	input logic [31:0] addend_i, 
	input logic [31:0] xor_i,
	output logic [31:0] sum_o, 
	output logic [31:0] shift_o
);

//internal net declaration
logic [31:0] sum_s;
logic [31:0] xor_s;


//structural description
assign sum_s = augend_i + addend_i;
assign xor_s = xor_i ^ sum_s;
assign shift_o = {xor_s[31-nb_bits:0],xor_s[31:(31-nb_bits)+1]};

assign sum_o=sum_s;

endmodule : arx

