`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SSU
// Engineer: Anthony Meyer Slechta
// 
// Create Date: 08/27/2025 05:43:52 PM
// Design Name: 
// Module Name: pmod_ssd_tb
// Project Name: Seven Segment LED Display Counter (PMOD)
// Target Devices: PYNQ-Z2
// Tool Versions: 
// Description: Simple testbench just showing continuous loop of SSD.
//              Timer count need to be set to 5 max to show up.
//
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_pmod_ssd;
    reg sys_clk;
    reg rst_n;
    wire [6:0] ssd;
    wire sel;

    // Instantiate the DUT (copied from previous tb files)
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
        // Test Reset
        rst_n = 0;
        #50;
        rst_n = 1;

        // Let sim run long enough to show a continuous loop 
        #1000_000;

        $finish;
    end

    // Output
    initial begin
        $display("Time\tReset\t\tSSD");
        $monitor("%0t\t%b\t\t%07b", $time, rst_n, ssd);
    end

endmodule

