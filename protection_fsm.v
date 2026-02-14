`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2026 16:31:25
// Design Name: 
// Module Name: protection_fsm
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


module protection_fsm(
    input wire clk,
    input wire rst_n,
    input wire ov_fault,
    input wire uv_fault,
    input wire oc_fault,
    input wire ot_fault,
    input wire[7:0]soc_percent,
    output reg charge_en_fsm,
    output reg discharge_en_fsm,
    output reg system_fault
    );
    parameter init=2'b00;
    parameter normal=2'b01;
    parameter charge_only=2'b10;
    parameter fault=2'b11;
    
    reg[1:0]current_state;
    reg[1:0]next_state;
    
    wire soc_low_fault;
    wire soc_high_fault;
    
    soc_protection soc_inst(
       .soc_percent(soc_percent),
       .soc_low_fault(soc_low_fault),
       .soc_high_fault(soc_high_fault)
       );
    //state register 
    
    always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
    current_state<=init;
    end
    else
    current_state<=next_state;
    end
    
    always@(*)begin
    next_state=current_state;
    case(current_state)
      init:begin
      if(ov_fault||oc_fault||ot_fault||soc_high_fault)
       next_state=fault;
      else 
       next_state=normal;
      end
      
      normal:begin
       if(ov_fault||oc_fault||ot_fault||soc_high_fault)
       next_state=fault;
       else if(uv_fault||soc_low_fault)
       next_state=charge_only;
       else
       next_state=normal;
       end
       
      charge_only:begin
      if(ov_fault||oc_fault||ot_fault||soc_high_fault)
      next_state=fault;
      else if(!uv_fault &&!soc_low_fault)
      next_state=normal;
      else
      next_state=charge_only;
      end
      fault:begin
        next_state=fault;
      end
      
      default:next_state=init;
      endcase
      end
      //default output
      always @(*)begin
      charge_en_fsm=1'b0;
      discharge_en_fsm=1'b0;
      system_fault=1'b0;
      
      case(current_state)
      init:begin
      charge_en_fsm=1'b0;
      discharge_en_fsm=1'b0;
      end
      normal:begin
      charge_en_fsm=1'b1;
      discharge_en_fsm=1'b1;
      end
      charge_only:begin
      charge_en_fsm=1'b1;
      discharge_en_fsm=1'b0;
      end
      fault:begin
      charge_en_fsm=1'b0;
      discharge_en_fsm=1'b0;
      system_fault=1'b1;
      end
      endcase
      end
endmodule