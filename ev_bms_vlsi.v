`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Module Name: ev_bms_vlsi
// Description: BMS top module (Vivado-compatible)
//////////////////////////////////////////////////////////////////////////////////

module ev_bms_vlsi(
    input wire clk,
    input wire rst_n,
    input wire [11:0] cell_1_voltage_adc,
    input wire [11:0] cell_2_voltage_adc,
    input wire [11:0] cell_3_voltage_adc,
    input wire [11:0] pack_current_adc,
    input wire [11:0] temperature_adc,
    input wire [7:0] soc_percent,
    output wire charge_en_fsm,
    output wire discharge_en_fsm,
    output wire system_fault,
    output wire [7:0] soh_percent,
    output wire soh_fault
);

    // ADC registered outputs
    wire [11:0] cell_1_voltage_reg;
    wire [11:0] cell_2_voltage_reg;
    wire [11:0] cell_3_voltage_reg;
    wire [11:0] pack_current_reg;
    wire [11:0] temperature_reg;

    // Fault signals
    wire ov_fault, uv_fault, oc_fault, ot_fault;
    wire soc_low_fault, soc_high_fault;

    // ----------------------
    // ADC interface
    adc_interface adc_inst(
        .clk(clk),
        .rst_n(rst_n),
        .cell_1_voltage_adc(cell_1_voltage_adc),
        .cell_2_voltage_adc(cell_2_voltage_adc),
        .cell_3_voltage_adc(cell_3_voltage_adc),
        .pack_current_adc(pack_current_adc),
        .temperature_adc(temperature_adc),
        .cell_1_voltage_reg(cell_1_voltage_reg),
        .cell_2_voltage_reg(cell_2_voltage_reg),
        .cell_3_voltage_reg(cell_3_voltage_reg),
        .pack_current_reg(pack_current_reg),
        .temperature_reg(temperature_reg),
        .ov_fault(ov_fault),
        .uv_fault(uv_fault),
        .oc_fault(oc_fault),
        .ot_fault(ot_fault)
    );

    // ----------------------
    // SOH Estimator
    soh_estimator soh_inst(
        .clk(clk),
        .rst_n(rst_n),
        .cell_1_voltage(cell_1_voltage_reg),
        .cell_2_voltage(cell_2_voltage_reg),
        .cell_3_voltage(cell_3_voltage_reg),
        .soc_percent(soc_percent),
        .soh_percent(soh_percent),
        .soh_fault(soh_fault)
    );

    // ----------------------
    // Protection FSM
    protection_fsm fsm_inst(
        .clk(clk),
        .rst_n(rst_n),
        .ov_fault(ov_fault),
        .uv_fault(uv_fault),
        .oc_fault(oc_fault),
        .ot_fault(ot_fault),
        .soc_percent(soc_percent),
        .charge_en_fsm(charge_en_fsm),
        .discharge_en_fsm(discharge_en_fsm),
        .system_fault(system_fault)
    );

endmodule
