`timescale 1ns / 1ps
module chacha20_bloc_tb;
import chacha_pck::*;
import rotation_pck::*;

logic      clock_s;
logic      resetb_s;
state_t    init_state_s;
logic      init_s;
rotation_t rotation_s;
logic      reg_sel_s;
state_t    keystream_s;

chacha_bloc DUT (
  .clock_i     (clock_s),
  .resetb_i    (resetb_s),
  .init_state_i(init_state_s),
  .init_i      (init_s),
  .rotation_i  (rotation_s),
  .reg_sel_i   (reg_sel_s),
  .keystream_o (keystream_s)
);

initial begin
  clock_s = 1'b0;
  forever #5 clock_s = ~clock_s;
end

initial begin
  resetb_s   = 1'b0;
  init_s     = 1'b0;
  reg_sel_s  = 1'b0;
  rotation_s = COL2DIAG;

  init_state_s[0]  = 32'h61707865;
  init_state_s[1]  = 32'h3320646e;
  init_state_s[2]  = 32'h79622d32;
  init_state_s[3]  = 32'h6b206574;
  init_state_s[4]  = 32'he921c73a;
  init_state_s[5]  = 32'h76a2b5ea;
  init_state_s[6]  = 32'h322fdc9a;
  init_state_s[7]  = 32'h27a09386;
  init_state_s[8]  = 32'hd52a3eec;
  init_state_s[9]  = 32'hd3a53fef;
  init_state_s[10] = 32'h860e69ae;
  init_state_s[11] = 32'h4e7ced7e;
  init_state_s[12] = 32'h00000001;
  init_state_s[13] = 32'h06e46ce3;
  init_state_s[14] = 32'hcaccf259;
  init_state_s[15] = 32'hd4ac91b9;

  #20;
  resetb_s = 1'b1;
  #1;

  @(posedge clock_s);
  init_s    = 1'b1;
  reg_sel_s = 1'b1;
  $display("t=%0t : chargement init", $time);

  @(posedge clock_s);
  init_s = 1'b0;
  $display("t=%0t : debut rondes", $time);

  repeat(10) begin
    rotation_s = COL2DIAG;
    @(posedge clock_s);
    rotation_s = DIAG2COL;
    @(posedge clock_s);
  end

  reg_sel_s = 1'b0;
  $display("t=%0t : keystream_o[0] = %h (attendu 345557b1)", $time, keystream_s[0]);
  $display("t=%0t : keystream_o[1] = %h (attendu e062951b)", $time, keystream_s[1]);
  $display("t=%0t : keystream_o[2] = %h (attendu 5983d837)", $time, keystream_s[2]);
  $display("t=%0t : keystream_o[3] = %h (attendu 57556c97)", $time, keystream_s[3]);
  #20;
  $finish;
end

endmodule : chacha20_bloc_tb
