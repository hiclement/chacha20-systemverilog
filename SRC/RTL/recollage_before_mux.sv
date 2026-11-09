`timescale 1ns / 1ps

module recollage_before_mux 
import chacha_pck::*;
(
    input  logic [1:0]   sel_i,   
    input  state_t       data_i,  
    output logic [127:0] data_o   
);

always_comb begin : comb_0
    case (sel_i)
        2'd0: begin
            data_o = {data_i[3], data_i[2], data_i[1], data_i[0]};
        end 
        2'd1: begin
            data_o = {data_i[7], data_i[6], data_i[5], data_i[4]};
        end 
        2'd2: begin
            data_o = {data_i[11], data_i[10], data_i[9], data_i[8]};
        end 
        default: begin
            data_o = '0; 
        end
    endcase
end : comb_0

endmodule : recollage_before_mux
