`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SSU
// Engineer: Anthony Meyer Slechta
// 
// Create Date: 09/07/2025 12:41:25 PM
// Design Name: And Or Tri Combinational
// Module Name: tb_and_or_tri_combinational
// Project Name: PBL 3: AND-OR-Tri Combinational
// Target Devices: PYNQ-Z2
// Tool Versions: 
// Description: Testing and-or-tri combinational logic and testbench
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_and_or_tri_combinational;
    reg a;
    reg b;
    reg c;
    reg d;
    reg en;
    wire f;

    // Instnatiate DUT
    and_or_tri_combinational uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .en(en),
        .f(f)
    );

    // Test the 5 test cases given for the assignment
    initial begin
        // Initialization
        en = 1'b0;
        a = 1'b0;
        b = 1'b0;
        c = 1'b0;
        d = 1'b0;

        // en = 0, a=b=c=d=1
        // Expected output: f = z
        #10;
        en = 1'b0;
        a = 1'b1;
        b = 1'b1;
        c = 1'b1;
        d = 1'b1;

        // en = 1, a=b=d=1, c = 0
        // Expected output: f = 1
        #10;
        en = 1'b1;
        a = 1'b1;
        b = 1'b1;
        c = 1'b0;
        d = 1'b1;

        // en = 1, b=c=1, a=d=0
        // Expected output: f = 0
        #10;
        en = 1'b1;
        a = 1'b0;
        b = 1'b1;
        c = 1'b1;
        d = 1'b0;

        // en = 1, a=c=d=1, b = 0
        // Expected output: f = 1
        #10;
        en = 1'b1;
        a = 1'b1;
        b = 1'b0;
        c = 1'b1;
        d = 1'b1;

        // en = 1, a=b=1, c=d=0
        // Expected output: f = 1
        #10;
        en = 1'b1;
        a = 1'b0;
        b = 1'b0;
        c = 1'b1;
        d = 1'b1;
        
        #10;
        $finish;
        
    end

    // Output results
    initial begin
        $display("en\ta\tb\tc\td\t\tf");
        $monitor("%b\t%b\t%b\t%b\t%b\t\t%b", en, a, b, c, d, f);
    end    

endmodule
