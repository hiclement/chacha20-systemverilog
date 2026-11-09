`timescale 1ns / 1ps
module arx_tb ();

// internal net declaration pour les stimuli
logic [31:0] augend_s;
logic [31:0] addend_s; 
logic [31:0] xor_s;
logic [31:0] sum_s; 
logic [31:0] shift_s;

//DUT : component instanciation
arx #(.nb_bits(7)) DUT
( 
	.augend_i(augend_s),
	.addend_i(addend_s),
	.xor_i(xor_s),
	.sum_o(sum_s),
	.shift_o(shift_s)
);

//affectation des stimulis 
initial begin
	augend_s = 32'h77777777;
	addend_s = 32'h01234567;
	xor_s = 32'h01020304;

end
endmodule : arx_tb
