`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2026 10:57:51
// Design Name: 
// Module Name: bms_watchdog
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


module bms_watchdog(
 input wire clk,
 input wire rst_n,
 input wire kick,
 output reg wd_fault
 );
 parameter time_out=24'd5000000;
 reg[23:0]wd_counter;
 always@(posedge clk )begin
  if(!rst_n)begin
      wd_counter<=24'd0;
      wd_fault<=1'b0;
      end
     else if(kick)begin
       wd_counter<=24'd0;
       wd_fault<=1'b0;
       end
     else if( wd_counter<time_out)begin
       wd_counter<=wd_counter+1'b1;
       wd_fault<=1'b0;
       end
     else begin
        wd_fault<=1'b1;
       end
      end
     
  endmodule