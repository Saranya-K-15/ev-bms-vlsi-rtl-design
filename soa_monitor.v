`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2026 10:07:23
// Design Name: 
// Module Name: soa_monitor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module soa_monitor(
 input wire clk,
 input wire rst_n,
 input wire ov_fault,
 input wire uv_fault,
 input wire ot_fault,
 input wire oc_fault,
 input wire [7:0] soc_percent,
 output reg soa_violation
 );
 parameter soc_low_limit=8'd5;
 parameter soc_high_limit=8'd95;
 always@(posedge clk)begin
  if(!rst_n)begin
     soa_violation=1'b1;
     end
   else begin
     if(ov_fault||oc_fault||ot_fault||uv_fault||soc_percent<soc_low_limit
      ||soc_percent>soc_high_limit)begin
        soa_violation=1'b0;
        end
     else begin
         soa_violation=1'b0;
         end
       end
      end
   endmodule