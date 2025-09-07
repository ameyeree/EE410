`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SSU
// Engineer: Anthony Meyer Slechta
// 
// Create Date: 09/07/2025 11:59:46 AM
// Design Name: And Mux Combinational
// Module Name: and_mux_combinational
// Project Name: PBL 2: AND-MUX Combinational
// Target Devices: PYNQ-Z2
// Tool Versions: 
// Description: Testing and-mux combinational logic and testbench simulation.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module and_mux_combinational(
    input a,
    input b,
    input c,
    input d,
    input sel,
    output e
    );

    // two and gates: a & b and c & d
    // If sel == 0, e = a & b, else e = c & d
    assign e = ~sel ? (a & b) : (c & d);
endmodule
