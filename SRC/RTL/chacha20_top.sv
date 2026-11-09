`timescale 1ns / 1ps

module chacha20_top
import chacha_pck::*;
import rotation_pck::*;
(
  input  logic         clock_i,
  input  logic         resetb_i,
  input  logic         start_i,
  input  logic [127:0] data_i,
  input  logic         data_valid_i,
  input  logic [255:0] key_i,
  input  logic [95:0]  nonce_i,
  output logic [127:0] cipher_o,
  output logic         cipher_valid_o,
  output logic         end_o
);

  localparam [31:0] constant0          = 32'h61707865;
  localparam [31:0] constant1          = 32'h3320646e;
  localparam [31:0] constant2          = 32'h79622d32;
  localparam [31:0] constant3          = 32'h6b206574;
  localparam [31:0] block = 32'h00000001;

  state_t      init_state_s;
  logic [4:0]  cpt_s;
  logic        en_cpt_s;
  logic        init_cpt_s;
  logic        init_s;
  rotation_t   rotation_s;
  logic        reg_sel_s;
  logic        keystream_sel_s;
  logic        cipher_reg_sel_s;
  logic [1:0]  xor_cpt_s;

  state_t      keystream_s;
  state_t      keystream_registre_s;
  logic [127:0] keystream_morceau_s;
  logic [127:0] resultat_s;


//on assigne l'état courant, la matrice de départ
  assign init_state_s[0]  = constant0;
  assign init_state_s[1]  = constant1;
  assign init_state_s[2]  = constant2;
  assign init_state_s[3]  = constant3;
  assign init_state_s[4]  = key_i[31:0];
  assign init_state_s[5]  = key_i[63:32];
  assign init_state_s[6]  = key_i[95:64];
  assign init_state_s[7]  = key_i[127:96];
  assign init_state_s[8]  = key_i[159:128];
  assign init_state_s[9]  = key_i[191:160];
  assign init_state_s[10] = key_i[223:192];
  assign init_state_s[11] = key_i[255:224];
  assign init_state_s[12] = block;
  assign init_state_s[13] = nonce_i[31:0];
  assign init_state_s[14] = nonce_i[63:32];
  assign init_state_s[15] = nonce_i[95:64];

  FSM fsm (
    .clock_i         (clock_i),
    .resetb_i        (resetb_i),
    .start_i         (start_i),
    .data_valid_i    (data_valid_i),
    .cpt_i           (cpt_s),
    .en_cpt_o        (en_cpt_s),
    .init_cpt_o      (init_cpt_s),
    .init_o          (init_s),
    .rotation_o      (rotation_s),
    .reg_sel_o       (reg_sel_s),
    .keystream_sel_o (keystream_sel_s),
    .cipher_reg_sel_o(cipher_reg_sel_s),
    .xor_cpt_o       (xor_cpt_s),
    .cipher_valid_o  (cipher_valid_o),
    .end_o           (end_o)
  );

  compteur_init cpt_rondes (
    .clock_i  (clock_i),
    .resetb_i (resetb_i),
    .en_i     (en_cpt_s),
    .init_i   (init_cpt_s),
    .cpt_o    (cpt_s)
  );

  chacha_bloc chacha_bloc (
    .clock_i      (clock_i),
    .resetb_i     (resetb_i),
    .init_state_i (init_state_s),
    .init_i       (init_s),
    .rotation_i   (rotation_s),
    .reg_sel_i    (reg_sel_s),
    .keystream_o  (keystream_s)
  );

  reg512 keystream_registre (
    .state_i  (keystream_s),
    .clock_i  (clock_i),
    .resetb_i (resetb_i),
    .sel_i    (keystream_sel_s),
    .state_o  (keystream_registre_s)
  );
  
  recollage_before_mux selection_morceau_inst (
    .sel_i  (xor_cpt_s),
    .data_i (keystream_registre_s),
    .data_o (keystream_morceau_s)
  );

  xor_module xor_inst (
    .a_i      (keystream_morceau_s),
    .b_i      (data_i),
    .cipher_o (resultat_s)
  );

  always_ff @(posedge clock_i or negedge resetb_i) begin : cipher_reg
    if (!resetb_i)
      cipher_o <= 128'b0;
    else if (cipher_reg_sel_s)
      cipher_o <= resultat_s;
  end : cipher_reg

endmodule : chacha20_top
