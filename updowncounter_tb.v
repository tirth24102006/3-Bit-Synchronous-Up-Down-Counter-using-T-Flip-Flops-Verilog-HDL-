`timescale 1ns / 1ps
module updowncounter_tb;
reg clk,rst,prt,ld;
reg [2:0] a;
wire [2:0]Q,QB;
reg ud;
updowncounter u1(clk,rst,prt,ld,ud,a,Q,QB);
initial begin
clk=0;
end
always #5 clk=~clk;
initial begin
$dumpfile("dump.vcd");
$dumpvars(0, updowncounter_tb);
$monitor("at time %t: clk=%b rst=%b prt=%b ld=%b a=%d ud=%b Q=%d",$time,clk,rst,prt,ld,a,ud,Q);
                rst = 1; ud = 0; ld = 0; prt = 0;#10;
                rst = 0; ud = 0; ld = 0; prt = 0;#90;
                prt = 1; ud = 0; ld = 0; #10;
                prt = 0; ud = 0; ld = 0; #90;
                rst = 1; ud = 1; ld = 0; #10;
                rst = 0; ud = 1; ld = 0; #90;
                prt = 1; ud = 1; ld = 0; #10;
                prt = 0; ud = 1; ld = 0; #90;
                ud = 0; ld = 1; a = 3'b101; #11; 
                ld = 0; #89;
                ud = 1; ld = 1; a = 3'b100; #11;
                ld = 0; #89;
                ud = 0; #100;
        $finish;
end
endmodule