`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2026 10:21:32
// Design Name: 
// Module Name: cell_balancer
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


module cell_balancer(
  input wire clk,
  input wire rst_n,
  input wire[11:0]cell_1_voltage,
  input wire[11:0]cell_2_voltage,
  input wire[11:0]cell_3_voltage,
  output reg balance_1,
  output reg balance_2,
  output reg balance_3
 );
 always@(posedge clk)begin
  if(!rst_n)begin
    balance_1<=1'b0;
    balance_2<=1'b0;
    balance_3<=1'b0;
    end
  else begin
      balance_1<=1'b0;
      balance_2<=1'b0;
      balance_3<=1'b0;
      
      if((cell_1_voltage>cell_2_voltage)&&(cell_1_voltage>cell_3_voltage))begin
           balance_1<=1'b1;
         end
      else if((cell_2_voltage>cell_1_voltage)&&(cell_2_voltage>cell_3_voltage))begin
           balance_2<=1'b1;
           end
      else if((cell_3_voltage>cell_1_voltage)&&(cell_3_voltage>cell_2_voltage))begin
          balance_3<=1'b1;
          end
          end
          end
       endmodule