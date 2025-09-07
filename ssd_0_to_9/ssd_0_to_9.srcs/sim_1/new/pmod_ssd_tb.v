`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2025 05:43:52 PM
// Design Name: 
// Module Name: pmod_ssd_tb
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


`timescale 1ns/1ps

module tb_pmod_ssd;

    // Testbench signals
    reg sys_clk;
    reg rst_n;
    wire [6:0] ssd;
    wire sel;

    // Instantiate the DUT
    pmod_ssd uut (
        .sys_clk(sys_clk),
        .rst_n(rst_n),
        .ssd(ssd),
        .sel(sel)
    );

    // Clock generation: 10ns period = 100MHz
    initial sys_clk = 0;
    always #5 sys_clk = ~sys_clk;

    // Stimulus
    initial begin
        // Dump waves if using iverilog/gtkwave
        $dumpfile("tb_pmod_ssd.vcd");
        $dumpvars(0, tb_pmod_ssd);

        // Apply reset
        rst_n = 0;
        #50;   // hold reset for a few cycles
        rst_n = 1;

        // Run simulation long enough to see several increments
        #1000_000;  // adjust as needed (simulation delay)

        $finish;
    end

    // Monitor outputs
    initial begin
        $display("Time\tReset\tBinaryCnt?\tSSD\tSel");
        $monitor("%0t\t%b\t\t%07b\t%b", $time, rst_n, ssd, sel);
    end

endmodule

