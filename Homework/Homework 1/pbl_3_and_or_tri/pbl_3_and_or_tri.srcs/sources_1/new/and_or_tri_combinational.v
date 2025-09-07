`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SSU
// Engineer: Anthony Meyer Slechta
// 
// Create Date: 09/07/2025 12:41:08 PM
// Design Name: And Or Tri Combinational
// Module Name: and_or_tri_combinational
// Project Name: PBL 3: AND-OR-Tri Combinational
// Target Devices: PYNQ-Z2
// Tool Versions: 
// Description: Testing and-or-tri combinational logic and tesbench
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module and_or_tri_combinational(
    input a,
    input b,
    input c,
    input d,
    input en,
    output f
    );
    
    // Create the output e, which is a wire since it's in the logic block
    wire e;
    assign e = (a & b) | (c & d);
    
    // tri-state buffer is done using ?: logic and 1'bz
    // 1'bz is a high inpedance, which means disconnect the bus
    assign f = en ? e : 1'bz;
    
endmodule
