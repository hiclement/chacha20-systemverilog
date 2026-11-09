`timescale 1ns / 1ps
module FSM_tb;
import rotation_pck::*;

logic       clockin_s;
logic       resetbin_s;
logic       startin_s;
logic       data_validin_s;
logic [4:0] cptin_s;
logic       en_cptout_s;
logic       init_cptout_s;
logic       cipher_validout_s;
logic       endout_s;
logic       initout_s;
rotation_t  rotationout_s;
logic       reg_selout_s;
logic       keystream_selout_s;
logic       cipher_reg_selout_s;
logic [1:0] xor_cptout_s;

FSM DUT (
  .clock_i         (clockin_s),
  .resetb_i        (resetbin_s),
  .start_i         (startin_s),
  .data_valid_i    (data_validin_s),
  .cpt_i           (cptin_s),
  .en_cpt_o        (en_cptout_s),
  .init_cpt_o      (init_cptout_s),
  .cipher_valid_o  (cipher_validout_s),
  .end_o           (endout_s),
  .init_o          (initout_s),
  .rotation_o      (rotationout_s),
  .reg_sel_o       (reg_selout_s),
  .keystream_sel_o (keystream_selout_s),
  .cipher_reg_sel_o(cipher_reg_selout_s),
  .xor_cpt_o       (xor_cptout_s)
);

compteur_init DUT2 (
  .clock_i  (clockin_s),
  .resetb_i (resetbin_s),
  .en_i     (en_cptout_s),
  .init_i   (init_cptout_s),
  .cpt_o    (cptin_s)
);


//clock generation
initial begin
	clockin_s = 1'b0;
	forever #5 clockin_s = ~clockin_s;
end
//affectation des stimulis 
initial begin
	#10
	resetbin_s     = 1'b0; 
    	startin_s      = 1'b0;
    	data_validin_s = 1'b0;
    	#10
    	resetbin_s     = 1'b1; 
    	#5
	startin_s = 1'b1;
	

end
endmodule : FSM_tb




