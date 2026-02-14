`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2026 17:40:31
// Design Name: 
// Module Name: fet_control
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


module fet_control(
    input wire clk,
    input wire rst_n,
    input wire charge_en_fsm,
    input wire discharge_en_fsm,
    input wire system_fault,
    output reg charge_fet_gate,
    output reg discharge_fet_gate
);
reg fault_latched;
always @(posedge clk) begin
if(!rst_n)
  fault_latched<=1'b0;
else if(system_fault)
  fault_latched<=1'b1;
else 
  fault_latched<=fault_latched;
end

always @(posedge clk)begin
if(!rst_n)begin
charge_fet_gate<=1'b0;
discharge_fet_gate<=1'b0;
end
else if(fault_latched)begin
charge_fet_gate<=1'b0;
discharge_fet_gate<=1'b0;
end
else begin
charge_fet_gate<=charge_en_fsm;
discharge_fet_gate<=discharge_en_fsm;
end
end
endmodule