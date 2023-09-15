`default_nettype none
module tt_um_blink(
        input wire [7:0] ui_in,
        output wire [7:0] uo_out,
        input  wire [7:0] uio_in,
        output wire [7:0] uio_out,
        output wire [7:0] uio_oe,
        input wire ena,
        input wire clk,
        input wire rst_n);

reg [7:0] count;
assign uo_out = count[7:0];
assign uio_out = count[7:0];
assign uio_oe = ena == 1'b1 && count < 8'b11111111;
always @(posedge clk) begin
        if (rst_n == 1'b0) begin
                count <= 'b0;
        end else if (ena == 1'b1) begin
                count <= count + 1'b1;
        end
end
endmodule // tt_um_noritsuna_8bitcounter_AI

