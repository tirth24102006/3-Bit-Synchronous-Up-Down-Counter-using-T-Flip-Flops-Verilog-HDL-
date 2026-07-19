module tflipflop(clk,rst,prt,ld,a,t,Q,QB);
input clk,rst,prt,t,ld,a;
output reg Q,QB;
always @ (posedge clk) begin
        if(rst) begin
                Q<=0;
                QB<=1;
        end else if(prt) begin
                Q<=1;
                QB<=0;
        end else if(ld) begin
                Q<=a;
                QB<=~a;
        end else begin
                if(t) begin
                        Q<=~Q;
                        QB<=~QB;
                end else begin
                        Q<=Q;
                        QB<=QB;
                end
        end
end
endmodule