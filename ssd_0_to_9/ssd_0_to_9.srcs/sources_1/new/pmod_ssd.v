`timescale 1ns / 1ps


module pmod_ssd(
    input sys_clk,
    input rst_n,
    output reg[6:0] ssd
);

    reg[31:0] timer_cnt;
    reg[3:0] binary_cnt;
    
    always@(posedge sys_clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            ssd <= 7'b1111110;

            binary_cnt <= 4'b0000;

            timer_cnt <= 32'd0;
        end
        else if(binary_cnt > 4'b1001 && timer_cnt >= 32'd50_000_000)
        begin
            ssd <= 7'b1111110;

            binary_cnt <= 4'b0000;

            timer_cnt <= 32'd0;
        end
        else if(timer_cnt >= 32'd50_000_000)
        begin
            binary_cnt <= binary_cnt + 1;

            timer_cnt <= 32'd0;

            if(binary_cnt == 4'b0000)
            begin
                ssd <= 7'b1111110;
            end
            else if(binary_cnt == 4'b0001)
            begin
                ssd <= 7'b0110000;
            end
            else if(binary_cnt == 4'b0010)
            begin
                ssd <= 7'b1101101;
            end
            else if(binary_cnt == 4'b0011)
            begin
                ssd <= 7'b1111001;
            end
            else if(binary_cnt == 4'b0100)
            begin
                ssd <= 7'b0110011;
            end
            else if(binary_cnt == 4'b0101)
            begin
                ssd <= 7'b1011011;
            end
            else if(binary_cnt == 4'b0110)
            begin
                ssd <= 7'b0011111;
            end
            else if(binary_cnt == 4'b0111)
            begin
                ssd <= 7'b1110000;
            end
            else if(binary_cnt == 4'b1000)
            begin
                ssd <= 7'b1111111;
            end
            else if(binary_cnt == 4'b1001)
            begin
                ssd <= 7'b1111011;
            end
        end
        else
        begin
            ssd <= ssd;

            timer_cnt <= timer_cnt + 32'd1;
        end
    end
endmodule