`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SSU
// Engineer: Anthjony Meyer Slechta
// 
// Create Date: 08/25/2025 05:01:42 PM
// Design Name: 
// Module Name: pmod_ssd
// Project Name: Seven Segment LED Display Counter (PMOD)
// Target Devices: PYNQ-Z2
// Tool Versions: 
// Description: 0-9 loop utilizing a seven segment display (PMOD). Timer count needs
//              to be set to 5 for TB, otherwise 50_000_000.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pmod_ssd(
    input sys_clk,
    input rst_n,
    output reg[6:0] ssd,
    output sel
);

    reg[31:0] timer_cnt;
    reg[3:0] binary_cnt;
    
    assign sel = 0;
    
    // Seven Seg MUX
    // Had to put in module or it would fail during simulation
    function [6:0] seven_seg;
        input [3:0] binary_cnt;
        case(binary_cnt)
            4'd0: seven_seg = 7'b1111110;
            4'd1: seven_seg = 7'b0110000;
            4'd2: seven_seg = 7'b1101101;
            4'd3: seven_seg = 7'b1111001;
            4'd4: seven_seg = 7'b0110011;
            4'd5: seven_seg = 7'b1011011;
            4'd6: seven_seg = 7'b0011111;
            4'd7: seven_seg = 7'b1110000;
            4'd8: seven_seg = 7'b1111111;
            4'd9: seven_seg = 7'b1111011;
            default: seven_seg = 7'b0000000;
        endcase    
    endfunction
    
    always@(posedge sys_clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            //ssd <= 7'b1111110;

            binary_cnt <= 4'b0000;

            timer_cnt <= 32'd0;
            
            ssd <= seven_seg(binary_cnt);
        end
        else if(binary_cnt >= 4'b1001 && timer_cnt >= 32'd5)
        begin
            // If binary count is greater than 0, and the delay has been long enough
            //      reset the binary counter, and timer counter.
            binary_cnt <= 4'b0000;

            timer_cnt <= 32'd0;
            
            ssd <= seven_seg(binary_cnt);
        end
        else if(timer_cnt >= 32'd5)
        begin
            binary_cnt <= binary_cnt + 1;

            timer_cnt <= 32'd0;
            
            ssd <= seven_seg(binary_cnt);
        end
        else
        begin

            ssd <= seven_seg(binary_cnt);
            timer_cnt <= timer_cnt + 32'd1;
        end
        // Tried with having this being the only place ssd was updated
        //      But it would not compile, not sure why.
       // ssd <= seven_seg(binary_cnt);
    end
endmodule

