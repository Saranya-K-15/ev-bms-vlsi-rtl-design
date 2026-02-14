`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench for ev_bms_vlsi
//////////////////////////////////////////////////////////////////////////////////

module bms_ev_vlsi_tb;

    // Clock and reset
    reg clk;
    reg rst_n;

    // DUT input signals
    reg [11:0] cell_1_voltage_adc;
    reg [11:0] cell_2_voltage_adc;
    reg [11:0] cell_3_voltage_adc;
    reg [11:0] pack_current_adc;
    reg [11:0] temperature_adc;
    reg [7:0] soc_percent;

    // DUT output signals
    wire charge_en_fsm;
    wire discharge_en_fsm;
    wire system_fault;
    wire [7:0] soh_percent;
    wire soh_fault;

    // ----------------------
    // Instantiate DUT
    ev_bms_vlsi dut (
        .clk(clk),
        .rst_n(rst_n),
        .cell_1_voltage_adc(cell_1_voltage_adc),
        .cell_2_voltage_adc(cell_2_voltage_adc),
        .cell_3_voltage_adc(cell_3_voltage_adc),
        .pack_current_adc(pack_current_adc),
        .temperature_adc(temperature_adc),
        .soc_percent(soc_percent),
        .charge_en_fsm(charge_en_fsm),
        .discharge_en_fsm(discharge_en_fsm),
        .system_fault(system_fault),
        .soh_percent(soh_percent),
        .soh_fault(soh_fault)
    );

    // ----------------------
    // Clock generation (100 MHz)
    always #5 clk = ~clk;

    // ----------------------
    // Stimulus
    initial begin
        // Initialize
        clk = 0;
        rst_n = 0;
        cell_1_voltage_adc = 0;
        cell_2_voltage_adc = 0;
        cell_3_voltage_adc = 0;
        pack_current_adc = 0;
        temperature_adc = 0;
        soc_percent = 0;

        #20 rst_n = 1;  // Release reset

        $display("Normal operation");
        cell_1_voltage_adc = 12'd3600;
        cell_2_voltage_adc = 12'd3550;
        cell_3_voltage_adc = 12'd3580;
        pack_current_adc = 12'd100;
        temperature_adc = 12'd500;
        soc_percent = 8'd50;
        #100;

        $display("Over voltage fault");
        cell_1_voltage_adc = 12'd4095;
        #100;

        $display("Under voltage fault");
        cell_1_voltage_adc = 12'd2500;
        #100;

        $display("Over temperature fault");
        cell_1_voltage_adc = 12'd3600;
        temperature_adc = 12'd900;
        #100;

        $display("SOC low condition");
        soc_percent = 8'd4;
        #100;

        $display("SOC high condition");
        soc_percent = 8'd98;
        #100;

        $display("Clearing all faults");
        cell_1_voltage_adc = 12'd3600;
        cell_2_voltage_adc = 12'd3550;
        cell_3_voltage_adc = 12'd3580;
        pack_current_adc = 12'd100;
        temperature_adc = 12'd500;
        soc_percent = 8'd50;
        #150;

        $display("Test completed");
        $finish;
    end

    // ----------------------
    // Monitor
    initial begin
        $monitor("Time=%0t | Charge FET=%b | Discharge FET=%b | System Fault=%b | SOC=%0d | SOH=%0d | SOH Fault=%b",
                  $time,
                  charge_en_fsm,
                  discharge_en_fsm,
                  system_fault,
                  soc_percent,
                  soh_percent,
                  soh_fault);
    end

    // ----------------------
    // Waveform generation
    initial begin
        $dumpfile("ev_bms.vcd");
        $dumpvars(0, bms_ev_vlsi_tb);
    end

endmodule
