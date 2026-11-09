`timescale 1ns / 1ps

module FSM
import rotation_pck::*;

(
input  logic       clock_i,
input  logic       resetb_i,
input  logic       start_i,
input  logic       data_valid_i,
input  logic [4:0] cpt_i,
output logic       en_cpt_o,
output logic       init_cpt_o,
output logic       cipher_valid_o,
output logic       end_o,
output logic       init_o,
output rotation_t  rotation_o,
output logic       reg_sel_o,
// ports supplementaires necessaires au chacha20_top
output logic       keystream_sel_o,
output logic       cipher_reg_sel_o,
output logic [1:0] xor_cpt_o
);

typedef enum {idle, init_cpt, chacha_bloc, addition, init_loop, xor_state, end_loop, fin} state_t;

state_t current_state;
state_t next_state;

logic cpt_lsb_s;
logic [1:0] cpt_2lsb_s;
assign cpt_lsb_s  = cpt_i[0];
assign cpt_2lsb_s = cpt_i[1:0];

always_ff @(posedge clock_i or negedge resetb_i)
  begin : seq_0
    if (resetb_i == 1'b0)
      current_state <= idle;
    else
      current_state <= next_state;
  end : seq_0

always_comb begin : comb_0
  case (current_state)
    idle:
      if (start_i == 1'b1) next_state = init_cpt;
      else                  next_state = idle;
    init_cpt:
      next_state = chacha_bloc;
    chacha_bloc:
      if (cpt_i < 19) next_state = chacha_bloc;
      else            next_state = addition;
    addition:
      next_state = init_loop;
    init_loop:
      if (data_valid_i == 1'b1) next_state = xor_state;
      else                       next_state = init_loop;
    xor_state:
      next_state = end_loop;
    end_loop:
      if (cpt_i < 3) next_state = init_loop;
      else           next_state = fin;
    fin:
      next_state = idle;
    default: next_state = idle;
  endcase
end : comb_0

always_comb begin : comb_1
  en_cpt_o         = 1'b0;
  init_cpt_o       = 1'b0;
  reg_sel_o        = 1'b0;
  rotation_o       = COL2DIAG;
  init_o           = 1'b0;
  cipher_valid_o   = 1'b0;
  end_o            = 1'b0;
  keystream_sel_o  = 1'b0;
  cipher_reg_sel_o = 1'b0;
  xor_cpt_o        = 2'd0;

  case (current_state)
    idle: ;
    init_cpt: begin
      init_cpt_o = 1'b1;
      en_cpt_o   = 1'b1;
    end
    chacha_bloc: begin
      en_cpt_o  = 1'b1;
      reg_sel_o = 1'b1;
      if (cpt_i == 0) init_o = 1'b1;
      else            init_o = 1'b0;
      if (cpt_lsb_s)  rotation_o = DIAG2COL;
      else            rotation_o = COL2DIAG;
    end
    addition: begin
      keystream_sel_o = 1'b1;
      init_cpt_o      = 1'b1;
      en_cpt_o        = 1'b1;
    end
    init_loop: begin
      end_o = 1'b1;
    end
    xor_state: begin
      cipher_reg_sel_o = 1'b1;
      en_cpt_o         = 1'b1;
      xor_cpt_o        = cpt_2lsb_s;
    end
    end_loop: begin
      cipher_valid_o = 1'b1;
    end
    fin: begin
      init_cpt_o = 1'b1;
    end
  endcase
end : comb_1

endmodule : FSM
