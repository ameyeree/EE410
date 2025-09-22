`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sonoma State University
// Engineer: Anthony Meyer Slechta
// 
// Create Date: 09/21/2025 08:10:07 AM
// Design Name: Four Bit Full Adder (Hierarchical design)
// Module Name: four_bit_full_adder
// Project Name: Four Bit Full Adder (Hierarchical design)
// Target Devices: PYNQ-Z2  
// Tool Versions: 
// Description: This project is to practice Hierarchical design. It uses given
//  1-bit half adder and 1-bit full adder code given from class (1-bit insantiates
//  2 half adders). It then builds on that to create a 4-bit adder, which 
//  instantiates 4 1-bit half adders.
//  This project also required us to demonstrate the 4-bit full adder on the PYNQ
//  board. In order to do that, this project utilizes:
//  --4 regular LEDs: Displays both inputs (a[3:0] $ b[3:0]) and output (sum[3:0])
//  --2 RGBs: LED5 used for showing what output is being displayed, LED4 used as c_in
//              --> Red: a --> Blue: b --> Green: Sum
//  --3 Push Buttons
//              --> btn0 increments bits [1:0] of inputs a and b
//              --> btn1 increments bits [3:2] of inputs a and b
//              --> btn2 toggles c_in as 1 or 0
//  --2 Switches
//              --> sw0 toggles between a (switch down, or 0), and b (switch up, or 1)
//              --> sw1 toggles between displaying inputs or outputs. If sw1 is high (up)
//                  only output is viewable, and all input presses are ignored.
// Dependencies: none
// 
// Revision: 1.0 Initial Final Commit
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module half_adder (
input a,
input b,
output sum,
output c_out
);
    // This is a 1-bit half adder, directly taken from the book and slides
    assign sum = a ^ b;
    assign c_out = a & b;
endmodule

module full_adder_one_bit(
input a,
input b,
input c_in,
output sum,
output c_out
);
    // This is a 1-bit full adder, directly taken from the book and slides
    wire w1;
    wire w2;
    wire w3;
    
    // Instantiate first half-adder as shown in report
    half_adder u1_half_adder (.sum (w1),
                                .c_out (w2),
                                .a (a),
                                .b (b)
                                );
                                
    // Instantiat second half-adder as shown in report
    half_adder u2_half_adder (.sum (sum),
                                .c_out (w3),
                                .a (w1),
                                .b (c_in)
                                );
    
    // Utilizes an OR gate for c_out
    assign c_out = w2 | w3;
endmodule

module full_adder_four_bit(
input [3:0]a,
input [3:0]b,
input c_in,
output [3:0]sum,
output c_out
);
    // Wires used for interconnections between c_ins and c_outs as shown in report
    wire w1;
    wire w2;
    wire w3;

    // All Four instances of the 1-bit full adders.
    // NOTE: Only full_adder_zero takes c_in as an outside input and only
    //        full_adder_three outputs c_out. 
    full_adder_one_bit full_adder_zero(.sum (sum[0]),
                                        .c_out (w1),
                                        .a (a[0]),
                                        .b (b[0]),
                                        .c_in (c_in)
                                        );
    full_adder_one_bit full_adder_one(.sum (sum[1]),
                                        .c_out (w2),
                                        .a (a[1]),
                                        .b (b[1]),
                                        .c_in (w1)
                                        );
    full_adder_one_bit full_adder_two(.sum (sum[2]),
                                        .c_out (w3),
                                        .a (a[2]),
                                        .b (b[2]),
                                        .c_in (w2)
                                        );
    full_adder_one_bit full_adder_three(.sum (sum[3]),
                                        .c_out (c_out),
                                        .a (a[3]),
                                        .b (b[3]),
                                        .c_in (w3)
                                        );
endmodule

module four_bit_full_adder_driver(
input btn_rhs,
input btn_lhs,
input btn_cin,
input sw_0,
input sw_1,
input sysclk,
output wire [3:0]led,
output wire led5_r, // Active-high
output wire led5_g, // Active-high
output wire led5_b,  // Active-high
output wire led4_g  //Active-high
    );
    // This module is used as a driver for outputting and interacting with the
    //  full adder code on the PYNQ Board
    
    // These are used to records previous button presses in order to avoid multiple
    //  high values being recorded from one button press
    reg prev_rhs_btn = 0;
    reg prev_lhs_btn = 0;
    reg prev_btn_cin = 0;

    // Debounce boolean variable, it does not have a default value because it throws an error
    reg db;    
    
    // Registers to update to store into our actual outputs. These values are the ones changed
    //  in the always statements.
    // They do not have a default value because they throw an error if they do
    reg [3:0]out_disp;
    reg [2:0]led5;
    
    // 4-bit Full adder values. reg values are inputs, wire values are outputs
    reg [3:0]a = 0;
    reg [3:0]b = 0;
    reg c_in = 0;
    wire [3:0]sum;
    wire c_out;  
  
    // Changes color of LED5 based on output, or which input is being displayed
    // Also determines which output will be displayed on led wire.
    always @ (posedge sysclk) begin
        // Switch 1 determines whether output or input is displayed
        if (sw_1) begin      
            // Make LED5 green
            led5 <= 3'b010;
            out_disp[3:0] <= sum;
        end else if (!sw_1 && sw_0) begin
            // LED red
            led5 <= 3'b100;
            out_disp[3:0] <= a;
        end else if (!sw_1 && !sw_0) begin
            // LED blue
            led5 <= 3'b001;
            out_disp[3:0] <= b;
        end
    end
      
    // Simple debounce algorithm.
    //  Helps to avoid not having duplicate presses for each button press (due to clock speed)
    always @(posedge sysclk) begin
        // Handle some debounce (simple algorithm, still has some issues)
        if (!sw_1) begin
            // Is only reachable if we are NOT in output mode
            if ( (btn_rhs && !prev_rhs_btn) || (btn_lhs && !prev_lhs_btn) || (btn_cin && !prev_btn_cin)) begin
                db <= 0;
            end else begin
                db <= 1;
            end
            
            // Store previous button press
            prev_rhs_btn <= btn_rhs;
            prev_lhs_btn <= btn_lhs;
            prev_btn_cin <= btn_cin;
        end
    end
    
    // Handles updating input a[3:0]
    // Increments based on button presses. 
    // btn0 will increment a[1:0], btn1 will increment a[3:2]
    always @(posedge sysclk) begin
        // Update input a
        if (!sw_1 && sw_0) begin
            // Only works if NOT in output mode and sw_0 is high
            if (btn_rhs && !db) begin
                a[1:0] <= a[1:0] + 1'b1;
            end else if (btn_lhs && !db) begin
                a[3:2] <= a[3:2] + 1'b1;
            end    
        end
    end
    
    // Handles updating input b[3:0]
    // Increments based on button presses. 
    // btn0 will increment b[1:0], btn1 will increment b[3:2]
    always @(posedge sysclk) begin
        // Update input b
        if (!sw_1 && !sw_0) begin
            // Only works if NOT in output mode and sw_1 is low  
            if (btn_rhs && !db) begin
                b[1:0] <= b[1:0] + 1'b1;
            end else if (btn_lhs && !db) begin
                b[3:2] <= b[3:2] + 1'b1;
            end
        end
    end
    
    // This toggles c_in
    always @(posedge sysclk) begin
        // Update c_in
        if (!sw_1) begin
            // Only toggleable when not in output mode (sw_1 is low)
            if (btn_cin && !db) begin
                c_in <= !c_in;
            end
        end
    end
    
    // Instantiate four bit full adder
    full_adder_four_bit final_full_adder(.sum (sum),
                                    .c_out (c_out),
                                    .a (a),
                                    .b (b),
                                    .c_in (c_in));
    
    // Running updates on outputs
    assign led = out_disp[3:0];             // 4-bit output: sum, a, or b
    assign led5_r = led5[2];                // RGB is red is this is high
    assign led5_g = led5[1];                // RGB is green is this is high
    assign led5_b = led5[0];                // RGB is blue is this is high
    assign led4_g = sw_1 ? c_out : c_in;    // RGB is green is this is high
    
endmodule
