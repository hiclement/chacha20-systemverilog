
`timescale 1ns / 1ps
module rotation_tb (
//empty declarative part
);

import chacha_pck::*;
import rotation_pck::*;
// internal net declaration
state_t    state_is;
rotation_t mode_s;
state_t    state_os;

//DUT : component instanciation
rotation DUT (
	.state_i(state_is),
	.mode_i(mode_s),
	.state_o(state_os)
);

initial begin

  state_is[0]  = 32'h00000000;
  state_is[1]  = 32'h00000001;
  state_is[2]  = 32'h00000002;
  state_is[3]  = 32'h00000003;
  state_is[4]  = 32'h00000000;
  state_is[5]  = 32'h00000001;
  state_is[6]  = 32'h00000002;
  state_is[7]  = 32'h00000003;
  state_is[8]  = 32'h00000000;
  state_is[9]  = 32'h00000001;
  state_is[10] = 32'h00000002;
  state_is[11] = 32'h00000003;
  state_is[12] = 32'h00000000;
  state_is[13] = 32'h00000001;
  state_is[14] = 32'h00000002;
  state_is[15] = 32'h00000003;

  mode_s = COL2DIAG;
  #100;
  state_is = state_os;
  mode_s = DIAG2COL;
  #100;

end
endmodule : rotation_tb
