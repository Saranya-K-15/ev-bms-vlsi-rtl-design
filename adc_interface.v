`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2026 14:24:50
// Design Name: 
// Module Name: adc_interface
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


module adc_interface(
input wire clk,
input wire rst_n,
input wire [11:0]cell_1_voltage_adc,
input wire[11:0]cell_2_voltage_adc,
input wire [11:0]cell_3_voltage_adc,
input wire [11:0]pack_current_adc,
input wire[11:0]temperature_adc,
output reg[11:0]cell_1_voltage_reg,
output reg[11:0]cell_2_voltage_reg,
output reg[11:0]cell_3_voltage_reg,
output reg[11:0]pack_current_reg,
output reg[11:0]temperature_reg,
output reg ov_fault,
output reg uv_fault,
output reg oc_fault,
output reg ot_fault
);
//adc threshold parameters
parameter ov_adc=12'd4090;
parameter uv_adc=12'd2790;
parameter ot_adc=12'd745;
parameter oc_adc=12'd3072;
//adc registering + protection
always@(posedge clk )begin
if(!rst_n)begin
cell_1_voltage_reg<=12'b0;
cell_2_voltage_reg<=12'b0;
cell_3_voltage_reg<=12'b0;
pack_current_reg<=12'b0;
temperature_reg<=12'b0;

ov_fault <=1'b0;
uv_fault<=1'b0;
oc_fault<=1'b0;
ot_fault<=1'b0;


end
else begin
cell_1_voltage_reg<=cell_1_voltage_adc;
cell_2_voltage_reg<=cell_2_voltage_adc;
cell_3_voltage_reg<=cell_3_voltage_adc;
pack_current_reg<=pack_current_adc;
temperature_reg<=temperature_adc;

//voltage protection
ov_fault<=(cell_1_voltage_adc>=ov_adc)||(cell_2_voltage_adc>=ov_adc)
||(cell_3_voltage_adc>=ov_adc);
uv_fault<=(cell_1_voltage_adc<=uv_adc)||(cell_2_voltage_adc<=uv_adc)||
(cell_3_voltage_adc<=uv_adc);

//temperature protection
ot_fault<=(temperature_adc>=ot_adc);
//current protection
oc_fault<=(pack_current_adc>=oc_adc);

end
end
endmodule