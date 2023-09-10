`default_nettype none
module tt_um_blink(rst_n, clk, ena, q);
   input rst_n, clk, ena;
   output [7:0] q;

   reg [7:0] cnt;
   wire ck;
   
   always @(posedge ck) begin
     if (rst_n == 1'b0) cnt <= 0;
     else cnt <= cnt + 1;
   end

   wire [20:0] n;
   assign n[20:1] = ~n[19:0];
   assign n[0] = ~n[20];
   assign ck = ~n[0];
		    
endmodule
