`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SSU
// Engineer: Anthony Meyer Slechta
// 
// Create Date: 09/07/2025 07:11:43 AM
// Design Name: And Or Combinational
// Module Name: and_or_combinational_tb
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


module and_or_combinational_tb;
    reg a;
    reg b;
    reg c;
    reg d;
    wire e;

    // Instantiate DUT
    and_or_combinational uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e)
    );

    // Testing the 3 test cases given for assignment
    initial begin
        a = 1'b0;
        b = 1'b0;
        c = 1'b0;
        d = 1'b0;

        #10;
        a = 1'b1;
        b = 1'b1;
        c = 1'b0;
        d = 1'b1;

        #10;
        a = 1'b1;
        b = 1'b0;
        c = 1'b1;
        d = 1'b1;

        #10;
        a = 1'b1;
        b = 1'b0;
        c = 1'b1;
        d = 1'b0;

        $finish;

    end

    // Output results
    initial begin
        $display("a\tb\tc\td\t\te");
        $monitor("%b\t%b\t%b\t%b\t\t%b", a, b, c, d, e);
    end
endmodule
