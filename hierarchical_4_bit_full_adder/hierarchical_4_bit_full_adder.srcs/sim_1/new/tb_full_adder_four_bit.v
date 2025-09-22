`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sonoma State University
// Engineer: Anthony Meyer Slechta
// 
// Create Date: 09/22/2025 07:22:33 AM
// Design Name: Four Bit Full Adder (Hierarchical design) Testbench
// Module Name: tb_full_adder_four_bit
// Project Name: Four Bit Full Adder (Hierarchical design)
// Target Devices: PYNQ-Z2
// Tool Versions: 
// Description: This testbench only tests the hierarchical four bit adder design. 
//  In order for this code to work properly, the driver code MUST be commented out.
//  This test will output all permutation to the TCL console if you select "run all" 
//  during sim, and has built in logic to confirm the results match the expected
//  values. The pass_fail column will output 1 for a pass, and 0 for a fail.
//
// Dependencies: four_bit_full_adder.v
// 
// Revision: 1.0 Initial Final Commit
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_full_adder_four_bit();
    // Values to test the adder
    reg [3:0]a;
    reg [3:0]b;
    reg c_in;
    wire [3:0]sum;
    wire c_out;

    // Variables for testbench
    integer ia, ib, ic;
    reg pass_fail;
    reg [4:0]expected;

    // Instantiate the DUT (copied from previous tb files)
    full_adder_four_bit uut (
        .sum(sum),
        .c_out(c_out),
        .a(a),
        .b(b),
        .c_in(c_in)
    );

    // Stimulus
    initial begin
        // Set initial inputs to all zeros
        a = 4'b0000;
        b = 4'b0000;
        c_in = 1'b0;
        # 5

        // Do nested loops to iterate through all permutations
        // First loop is c_in: 0-->1
        for (ic = 0; ic <=1; ic = ic + 1) begin
            c_in = ic;
            // second loop is a: 0-->15
            for (ia = 4'd0; ia <= 4'd15; ia = ia + 4'd1) begin
                a = ia;
                // Third loop is b: 0-->15
                for (ib = 4'd0; ib <= 4'd15; ib = ib + 4'd1) begin
                    b = ib;
                    #5 //Give time for the logic to settle, or will get false negatives
                    
                    // Confirm results by calculated expected
                    expected = a + b + c_in;

                    if ( {c_out, sum} == expected) begin
                        // Results are a pass
                        pass_fail = 1'b1;
                    end else begin
                        // Results are a fail
                        pass_fail = 1'b0;
                    end
                end
            end
        end
        
        // End simulation at this point
        $finish;
    end

    // TCL output showing results
    initial begin
        $display("Time\tc_in\ta\t\tb\t\tsum\t\tc_out\t\tpass_fail");
        $monitor("%0t\t%b\t%04b\t\t%04b\t\t%04b\t\t%b\t\t%b", $time, c_in, a, b, sum, c_out, pass_fail);
    end
endmodule
