`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.01.2026 16:01:45
// Design Name: 
// Module Name: soc_estimator
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


module soc_estimator(
input wire clk,
input wire rst_n,
input wire [11:0]pack_current_adc,
input wire charge_en_fsm,
input wire discharge_en_fsm,
output reg [7:0]soc_percent
);
parameter soc_max=16'd10000;
parameter soc_min=16'd0;
reg [15:0]soc_accumulator;
always@(posedge clk)begin
if(!rst_n)begin
soc_accumulator<=soc_max;
soc_percent<=8'd100;
end
else begin
  if(discharge_en_fsm && soc_accumulator>soc_min)begin
     soc_accumulator<=soc_accumulator-pack_current_adc;
     end
   else if(charge_en_fsm && soc_accumulator<soc_max)begin
      soc_accumulator<=soc_accumulator+pack_current_adc;
      end
   
   soc_percent<=soc_accumulator/16'd100;
   end
   end
  endmodule