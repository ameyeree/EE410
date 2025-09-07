`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SSU
// Engineer: Anthony Meyer Slechta
// 
// Create Date: 09/07/2025 07:03:02 AM
// Design Name: And Or Combinational
// Module Name: and_or_combinational
// Project Name: PBL 1: AND-OR Combinational
// Target Devices: PYNQ-Z2
// Tool Versions: 
// Description: Testing and-or combinational logic and testbench simulation.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module and_or_combinational(
    input a,
    input b,
    input c,
    input d,
    output e);

    assign e = (a & b) | (c & d);
endmodule
