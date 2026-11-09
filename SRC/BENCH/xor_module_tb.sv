`timescale 1ns / 1ps
module xor_module_tb

(
);

logic [127:0] a_s;
logic [127:0] b_s; 
logic [127:0] cipher_s;

xor_module DUT(
.a_i(a_s), 
.b_i(b_s), 
.cipher_o(cipher_s)
);


//affectation des stimulis 
initial begin
	a_s = 128'h00000000078900000000012340000000;
	b_s = 128'h11101110011111000011111111001111;

end


endmodule : xor_module_tb
