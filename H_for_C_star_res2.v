`timescale 1ns / 1ps
module H_for_C_star_res2(
    input clk,
    input reset,
    input[255:0] cvroot,
    input[255:0] Csn,
    input Hstart,
    output [255:0] hashValue,
    output reg en_end
    );
    reg[0:1] state;
    reg cf_start;
    wire cf_end;
    reg [255:0] iv;
    reg [1:0]counter;
    wire[1023:0] Hin={cvroot,Csn,8'h80,440'h0,64'h512};
    
    wire [511:0] h_in=(counter==0)?Hin[1023:512]:Hin[511:0];
    
    

    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            cf_start<=0;
            en_end<=0;
            state <= 0;
            counter<=0;
            iv<=256'h7380166f4914b2b9172442d7da8a0600a96f30bc163138aae38dee4db0fb0e4e;
        end
        else begin
            if(~Hstart) begin
                en_end<=0;
                counter<=0;
                iv<=256'h7380166f4914b2b9172442d7da8a0600a96f30bc163138aae38dee4db0fb0e4e;
            end
            if(state==0 && Hstart &&en_end==0)begin
                if (en_end==0) begin
                    cf_start<=1;
                    state<=1;
                end
            end
            else if(state == 1) begin
                if(cf_end) begin
                    counter<=counter+1;
                    cf_start<=0;
                    iv<=hashValue;
                    if(counter==1) begin
                        state<=2;
                    end
                    else begin
                        state<=0;
                    end
                end
            end 
            else if (state ==2) begin
                    en_end<=1;
                    state <=0; 
                    counter<=0;
            end
        end
    end
    sm3_CF sc(
        clk,
        reset,
        cf_start,
        iv,
        h_in,
        hashValue,
        cf_end 
    );
    
endmodule
