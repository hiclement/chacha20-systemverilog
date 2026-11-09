`timescale 1ns / 1ps
module mux_tb ();
import chacha_pck::*;

    state_t        keystream_s;
    logic [1:0]    cpt_s;
    logic [127:0]  data_o_s;

mux DUT (
    .keystream_i(keystream_s),
    .cpt_i(cpt_s),
    .data_o(data_o_s)
);

// Affectation des stimuli
initial begin

    keystream_s = '{default: 32'h00000000};
    

    keystream_s[0] = 32'h00000001; 
    keystream_s[4] = 32'h00000002; 


    cpt_s = 2'b00;
    #50;
    cpt_s = 2'b01;
    #50;
    cpt_s = 2'b10;
    #50;
    cpt_s = 2'b11;
    #50;

end

endmodule : mux_tb
