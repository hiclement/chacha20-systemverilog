`timescale 1ns / 1ps

module chacha_bloc
import chacha_pck::*;
import rotation_pck::*;
(
  input  logic      clock_i,
  input  logic      resetb_i,
  input  state_t    init_state_i,
  input  logic      init_i,
  input  rotation_t rotation_i,
  input  logic      reg_sel_i,
  output state_t    keystream_o
);

  state_t n1_s;  
  state_t n2_s;  
  state_t n3_s;  
  state_t n4_s;  


  assign n1_s = init_i ? init_state_i : n4_s;


  round_colonne round (
    .round_i (n1_s),
    .round_o (n2_s)
  );


  rotation rota (
    .state_i (n2_s),
    .mode_i  (rotation_i),
    .state_o (n3_s)
  );


  registre_d reg_state (
    .state_i  (n3_s),
    .clock_i  (clock_i),
    .resetb_i (resetb_i),
    .sel_i    (reg_sel_i),
    .state_o  (n4_s)
  );


  additionneur adder (
    .chachaed_i  (n4_s),
    .initial_i   (init_state_i),
    .keystream_o (keystream_o)
  );

endmodule : chacha_bloc
