module updowncounter(clk,rst,prt,ld,ud,a,Q,QB);
input clk,rst,prt,ld,ud;
input [2:0] a;
output [2:0]Q,QB;
wire [2:0] w,wB;
tflipflop t0(clk,rst,prt,ld,a[0],1'b1,w[0],wB[0]);
tflipflop t1(clk,rst,prt,ld,a[1],ud ^ w[0],w[1],wB[1]);
tflipflop t2(clk,rst,prt,ld,a[2],(~ud & w[0] & w[1]) | (ud & wB[0] & wB[1]),w[2],wB[2]);
assign Q = w;
assign QB = wB;
endmodule