`timescale 1ns / 1ps
module H(
    input clk,
    input reset,
    input[0:3] mode,
    input[2*1088-1:0] h1InSeedSet,
    input[1088-1:0] h3InCommitment,
    input Hstart,
    input restart,
    input[0:9] groupNum,
    output [511:0] hashValue,
    output reg en_end
    );
    reg[0:1] state;
    reg out_start;
    reg start;
    wire sha3_busy;
    reg[0:9] counter;
    reg[1087:0] data;
    wire[0:20] index=(counter+1)*1088-1;
    wire out_ok;
    always @(*)begin
        case(mode) 
            0: begin
                data = h1InSeedSet[index-: 1088];
            end
            1: begin
                data = h3InCommitment[index-: 1088];
            end
        endcase
    end
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            counter <= 0;
            start<=0;
            out_start<=0;
            en_end<=0;
            state <= 0;
        end
        else begin
            if(state==0 && Hstart)begin
                if(restart) begin
                    en_end<=0;
                end
                if (en_end==0) begin
                    start<=1;
                    state<=1;
                end
            end
            else if(state == 1 && en_end==0) begin
                if(sha3_busy==1)begin
                    counter<=counter+1; 
                end
                if(counter==groupNum) begin
                    start<=0;
                    state <=2 ;
                    out_start<=1;
                end
            end 
            else if (state ==2) begin
                if(out_ok==1) begin
                    out_start<=0;
                    en_end<=1;
                    state <=0;
                    counter<=0;
                end
            end
        end
    end
    sha3_core sc(
    .clk_i(clk),  // system clk input
    .reset_i(reset),  // async reset active high
    .start_i(start) ,  // pulse to start hashing next msg
    .out_start_i(out_start),
    .out_ok(out_ok),
    .sha3_busy(sha3_busy),  // sha3 is ready for next msg (level signal)      
    .data_ii(data),     
    .md_data_o(hashValue)  // message digest output (256 bits)
    );
    
endmodule
