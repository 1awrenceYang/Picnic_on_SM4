`timescale 1ns / 1ps
module set_seed_salt(
    input clk,
    input reset,
    input[127:0] sk,
    input set_tapes_start,
    output[127:0] root_seed,
    output[255:0] salt,
    output[127:0] seed_trangle,
    output reg set_tapes_end 
);
    wire [1023:0] deta;
    assign {root_seed,salt,seed_trangle}=deta[511:0];
    reg  Hstart;
    reg  restart;
    wire  en_end;
    reg[4:0] state; 

    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            state<=0;
            set_tapes_end<=0;
        end
        else begin
            if(~set_tapes_start) begin
                set_tapes_end<=0;
            end
            if(state==0) begin
                if(set_tapes_start &&set_tapes_end==0) begin
                    set_tapes_end<=0;
                    Hstart<=1;
                    restart<=0;
                    state<=1;
                end
                
            end
            if(state==1) begin
                if(en_end) begin
                    Hstart<=0;
                    state<=2;
                end                  
            end
            if(state==2) begin
                set_tapes_end<=1;
                state <= 0;
            end
        end

    end

    KDF_for_seed_deta kdf0(clk,reset,Hstart,restart,sk,deta,en_end);
endmodule


