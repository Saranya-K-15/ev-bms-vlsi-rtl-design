`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.01.2026 17:08:19
// Design Name: 
// Module Name: soc_protection
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


module soc_protection(
  input wire [7:0]soc_percent,
  output reg soc_low_fault,
  output reg soc_high_fault
);
parameter soc_low_limit=8'd10;
parameter soc_high_limit=8'd95;
always @(*)begin
soc_low_fault=1'b0;
soc_high_fault=1'b0;

 if(soc_percent<=soc_low_limit)begin
  soc_low_fault=1'b1;
  
 end
 else if(soc_percent>=soc_high_limit)begin
 soc_high_fault=1'b1;
 end
end
endmodule
