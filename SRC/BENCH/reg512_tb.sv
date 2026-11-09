`timescale 1ns / 1ps
module reg512_tb 
import chacha_pck::*;
(
);

 state_t state_is;
 logic clock_s;
 logic resetb_s;
 logic sel_s;
 state_t state_os;
 
 reg512 DUT (
.state_i(state_is),
.clock_i(clock_s),
.resetb_i(resetb_s),
.sel_i(sel_s),
.state_o(state_os)

 );
 
initial begin
	clock_s = 1'b0;
	forever #5 clock_s = ~clock_s;
end

initial begin
resetb_s = 1'b0;
sel_s      = 1'b0;
state_is[0} = 32'h99999999;
#20
sel_s      = 1'b1;
resetb_s = 1'b1;
#20
state_is[0]= 32'h00000000;
#30
state_is[0]= 32'h11111111;
#30
resetb_s = 1'b1;
end
 

endmodule : reg512_tb


