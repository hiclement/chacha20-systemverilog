`timescale 1ns / 1ps

module quarter_round 
(
	input logic [31:0] a_i,
	input logic [31:0] b_i,
	input logic [31:0] c_i,
	input logic [31:0] d_i,
	output logic [31:0] a_o,
	output logic [31:0] b_o,
	output logic [31:0] c_o,
	output logic [31:0] d_o
);

// internal net declaration

logic [31:0] n1_s;
logic [31:0] n2_s;
logic [31:0] n3_s;
logic [31:0] n4_s;

// structural description

arx #(.nb_bits(16)) arx_1 (
    .augend_i(a_i),
    .addend_i(b_i),
    .xor_i(d_i),
    .sum_o(n1_s),
    .shift_o(n4_s)
    );

arx #(.nb_bits(12)) arx_2 (
    .augend_i(c_i),
    .addend_i(n4_s),
    .xor_i(b_i),
    .sum_o(n3_s),
    .shift_o(n2_s)
    );

arx #(.nb_bits(8)) arx_3 (
    .augend_i(n1_s),
    .addend_i(n2_s),
    .xor_i(n4_s),
    .sum_o(a_o),
    .shift_o(d_o)
    );

arx #(.nb_bits(7)) arx_4 (
    .augend_i(n3_s),
    .addend_i(d_o),
    .xor_i(n2_s),
    .sum_o(c_o),
    .shift_o(b_o)
    );

endmodule : quarter_round 
