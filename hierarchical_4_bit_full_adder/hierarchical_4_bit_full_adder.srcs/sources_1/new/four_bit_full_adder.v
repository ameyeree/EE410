`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2025 08:10:07 AM
// Design Name: 
// Module Name: four_bit_full_adder
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


module four_bit_full_adder(
input btn_rhs,
input btn_lhs,
input sw_0,
input sw_1,
input sysclk,
output wire [3:0]led,
output wire led5_r, // Active-high
output wire led5_g, // Active-high
output wire led5_b // Active-high
    );
    reg prev_rhs_btn = 0;
    reg prev_lhs_btn = 0;
    reg [2:0]led5;
    reg db;
    
    // stuff for final adder stuff
    reg [3:0]a = 0;
    reg [3:0]b = 0;
    reg c_in = 0;
    reg [3:0]sum = 0;
    reg c_out = 0;
    
    reg [4:0]out_disp;
    
    // handle input
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
      
    always @(posedge sysclk) begin
        if (!sw_1) begin
            if ( (btn_rhs && !prev_rhs_btn) || (btn_lhs && !prev_lhs_btn) ) begin
                db = 0;
            end else begin
                db = 1;
            end
            
            prev_rhs_btn <= btn_rhs;
            prev_lhs_btn <= btn_lhs;
        end
    end
    
    always @(posedge sysclk) begin
        // Update input a
        if (!sw_1 && sw_0) begin
            if (btn_rhs && !db) begin
                a[1:0] <= a[1:0] + 1'b1;
            end else if (btn_lhs && !db) begin
                a[3:2] <= a[3:2] + 1'b1;
            end    
        end
    end
    
    always @(posedge sysclk) begin
        // Update input b
        if (!sw_1 && !sw_0) begin  
            if (btn_rhs && !db) begin
                b[1:0] <= b[1:0] + 1'b1;
            end else if (btn_lhs && !db) begin
                b[3:2] <= b[3:2] + 1'b1;
            end
        end
    end
    
    assign led = out_disp[3:0];
    assign led5_r = led5[2];
    assign led5_g = led5[1];
    assign led5_b = led5[0];
    
endmodule
