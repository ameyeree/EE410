`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SSU
// Engineer: Anthony Meyer Slechta
// 
// Create Date: 09/07/2025 12:02:58 PM
// Design Name: And Mux Combinational
// Module Name: tb_and_mux_combinational
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


module tb_and_mux_combinational;
    reg a;
    reg b;
    reg c;
    reg d;
    reg sel;
    wire e;

    // Instantiate DUT
    and_mux_combinational uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel),
        .e(e)
    );

    // Test the 4 test cases given for assignment
    initial begin
        // initialization
        sel = 1'b0;
        a = 1'b0;
        b = 1'b0;
        c = 1'b0;
        d = 1'b0;

        // sel = 0, a=b=d=1, c = 0
        // Expected output: e = 1
        #2;
        sel = 1'b0;
        a = 1'b1;
        b = 1'b1;
        c = 1'b0;
        d = 1'b1;

        // sel = 1, a=b=d=1, c = 0
        // Expected output: e = 0
        #10;
        sel = 1'b1;
        a = 1'b1;
        b = 1'b1;
        c = 1'b0;
        d = 1'b1;

        // sel = 0, a = 0, b=c=d=1
        // Expected output: e = 0
        #10;
        sel = 1'b0;
        a = 1'b0;
        b = 1'b1;
        c = 1'b1;
        d = 1'b1;

        // sel = 1, a = 0, b=c=d=1
        // Expected output: e = 1
        #10;
        sel = 1'b1;
        a = 1'b0;
        b = 1'b1;
        c = 1'b1;
        d = 1'b1;
        
        #10;

        $finish;
    end

    // Output results
    initial begin
        $display("sel\ta\tb\tc\td\t\te");
        $monitor("%b\t%b\t%b\t%b\t%b\t\t%b", sel, a, b, c, d, e);
    end    

endmodule
