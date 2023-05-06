`timescale 1ns / 1ps
module HForStap4(
    input clk,
    input reset,
    input[0:3] mode,
    input[255:0] seed,
    input[1019:0] aux,
    input[255:0] salt,
    input[8191:0] C,
    input[600:0]masked_key,
    input[20399:0]msgs,
    input[15:0] t,
    input[15:0] i,
    input Hstart,
    //input restart,
    output [511:0] hashValue,
    output reg en_end
    );
    reg[0:9] groupNum;
    reg[0:1] state;
    reg out_start;
    reg start;
    wire sha3_busy;
    reg[0:9] counter;
    reg[1087:0] data;
    wire[0:20] index1=1088-(counter)*1088-1;
    wire[0:20] index2=2176-(counter)*1088-1;
    wire[0:20] index3=8704-(counter)*1088-1;
    wire[0:20] index4=21760-(counter)*1088-1;
    wire out_ok;
    wire[1087:0] h0={seed,salt,t,i,8'h1f,528'h0,8'h80};
    wire[2176-1:0] h1={seed,aux,salt,t,i,8'h1f,596'h0,8'h80};
    wire[8704-1:0] h2={C,8'h1f,560'h0,8'h80};
    wire[21760-1:0] h3={masked_key,msgs,8'h1f,743'h0,8'h80};
    always @(*)begin
        case(mode) 
            0: begin
                data = h0[index1-: 1088];
                groupNum = 1;
            end
            1: begin
                data = h1[index2-: 1088];
                groupNum = 2;
            end
             
            2: begin
                data = h2[index3-: 1088];
                groupNum = 8;
            end
            3: begin
                data = h3[index4-: 1088];
                groupNum = 20;
            end
            
        endcase
    end
    always @(posedge clk or negedge reset) begin
        if(~reset) 
        begin
            counter <= 0;
            start<=0;
            out_start<=0;
            en_end<=0;
            state <= 0;
        end
        else begin
            if(!Hstart) 
            begin
                en_end<=0;
            end
            else if(state==0 && Hstart)
            begin
                if (en_end==0) 
                begin
                    start<=1;
                    state<=1;
                end
            end
            else if(state == 1 && en_end==0) 
            begin
                if(sha3_busy==1)
                begin
                    counter<=counter+1; 
                end
                if(counter==groupNum) 
                begin
                    start<=0;
                    state <=2 ;
                    out_start<=1;
                end
            end 
            else if (state ==2) 
            begin
                if(out_ok==1) 
                begin
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
