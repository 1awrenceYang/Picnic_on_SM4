`timescale 1ns / 1ps
module H_for_HCP2(
    input clk,
    input reset,
    input[511:0] h1In,
    input Hstart,
    output [255:0] hashValue,
    output reg en_end
    );
    reg[0:1] state;
    reg cf_start;
    wire cf_end;
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            cf_start<=0;
            en_end<=0;
            state <= 0;
        end
        else begin
            if(~Hstart) begin
                en_end<=0;
            end
            if(state==0 && Hstart&&en_end==0)begin
                if (en_end==0) begin
                    cf_start<=1;
                    state<=1;
                end
            end
            else if(state == 1) begin
                if(cf_end) begin
                    cf_start<=0;
                    state<=2;
                end
            end 
            else if (state ==2) begin
                    en_end<=1;
                    state <=0; 
            end
        end
    end
    sm3_CF sc(
        clk,
        reset,
        cf_start,
        256'h7380166f4914b2b9172442d7da8a0600a96f30bc163138aae38dee4db0fb0e4e,
        h1In,
        hashValue,
        cf_end 
    );
    
endmodule
