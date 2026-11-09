`timescale 1ns / 1ps
module rotation
import chacha_pck::*;
import rotation_pck::*;
(
  input  state_t    state_i,
  input  rotation_t mode_i,
  output state_t    state_o
);

  always_comb begin

    // la premiere ligne reste la même peu importe DIAG/COL
    state_o[0]  = state_i[0];
    state_o[1]  = state_i[1];
    state_o[2]  = state_i[2];
    state_o[3]  = state_i[3];

    if (mode_i == COL2DIAG) begin
      
      state_o[4]  = state_i[5];
      state_o[5]  = state_i[6];
      state_o[6]  = state_i[7];
      state_o[7]  = state_i[4];

      state_o[8]  = state_i[10];
      state_o[9]  = state_i[11];
      state_o[10] = state_i[8];
      state_o[11] = state_i[9];

      state_o[12] = state_i[15];
      state_o[13] = state_i[12];
      state_o[14] = state_i[13];
      state_o[15] = state_i[14];
    end 
    else begin

      state_o[4]  = state_i[7];
      state_o[5]  = state_i[4];
      state_o[6]  = state_i[5];
      state_o[7]  = state_i[6];

      state_o[8]  = state_i[10];
      state_o[9]  = state_i[11];
      state_o[10] = state_i[8];
      state_o[11] = state_i[9];

      state_o[12] = state_i[13];
      state_o[13] = state_i[14];
      state_o[14] = state_i[15];
      state_o[15] = state_i[12];
    end

  end

endmodule : rotation
