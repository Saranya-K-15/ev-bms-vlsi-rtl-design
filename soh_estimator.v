`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2026 09:10:35
// Design Name: 
// Module Name: soh_estimator
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


module soh_estimator(
input wire clk,
input wire rst_n,
input wire [11:0]cell_1_voltage,
input wire[11:0]cell_2_voltage,
input wire[11:0]cell_3_voltage,
input wire[7:0] soc_percent,
output reg[7:0]soh_percent,
output reg soh_fault
 );
 parameter soh_min_voltage=12'd2800;
 parameter soh_max_voltage=12'd4090;
 always @(posedge clk or negedge rst_n)begin
 if(!rst_n)begin
   soh_percent<=8'd100;
   soh_fault<=1'b0;
   end
 else begin
   if(cell_1_voltage<soh_min_voltage||cell_2_voltage<soh_min_voltage||
        cell_3_voltage<soh_min_voltage)begin
       soh_percent<=8'd50;
       soh_fault<=1'b1;
       end
   else begin
      soh_fault<=1'b0;
      soh_percent<=8'd100-((100-soc_percent)/2);
      end
      end
      end
endmodule