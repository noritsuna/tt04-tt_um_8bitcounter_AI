`default_nettype none
module tt_um_blink(
		   input  wire [7:0] ui_in,  // Dedicated inputs
		   output wire [7:0] uo_out, // Dedicated outputs
		   input  wire [7:0] uio_in, // IOs: Bidirectional Input path
		   output wire [7:0] uio_out,// IOs: Bidirectional Output path
		   output wire [7:0] uio_oe, // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
		   input wire 	     ena, // will go high when the design is enabled
		   input wire 	     clk, // clock
		   input wire 	     rst_n     // reset_n - low to reset
		   );

   reg [7:0] 			     count;
   assign uo_out  = count[7:0];
   assign uio_out = count[7:0];
   assign uio_oe = 8'b11111111; // set bidir as outputs
   always @(posedge clk) begin
      if (rst_n == 1'b0) begin
         count <= 'b0;
      end else begin
         count <= count + 1'b1;
      end
   end
endmodule

