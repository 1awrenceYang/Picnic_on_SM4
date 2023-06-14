module kdf_for_tapes(
    input clk,
    input reset,
    input kdf_start,
    input [127:0] seed,
    input [255:0] salt,
    input [7:0] t,
    input [7:0] i, 
    output reg wea,
    output reg[11:0] address,
    output [527:0] data_for_ram,
    output reg kdf_end
);
integer depth_for_ram= 2048;
wire [1087:0] sha3_out;
reg hellow;
assign data_for_ram=hellow?sha3_out[1055:528]:sha3_out[527:0];
reg sha3_start;
reg [0:1599]S_in;

wire [0:1599]S_out;
wire sha3_end;

reg [4:0] state;
always @(posedge clk or negedge reset) begin
    if(~reset) begin
       S_in<=0;
       sha3_start<=0;
       kdf_end<=0;
       state<=0;
       address<=0;
       wea<=0;
       hellow<=0;
      // data_for_ram<=0;
    end
    else begin
        if(~kdf_start) begin
            wea<=0;
            S_in<=0;
            sha3_start<=0;
            kdf_end<=0;
            state<=0;
            address<=0;
            hellow<=0;
       //     data_for_ram<=0;
        end
        if(state==0&& kdf_start &&~kdf_end) begin
            state<=1;
        end
        else if(state==1) begin
            if(sha3_end) begin
                sha3_start<=0;
                S_in<=S_out;
                state<=2;
            end
            else begin
                S_in<={seed,salt,t,i,8'h1f,672'h0,8'h80,512'h0};
                sha3_start<=1;
            end
        end
        else if(state==2) begin
            wea<=1;
            state<=3;
        end
        else if(state==3)begin
            wea<=0;
            state<=6;
            hellow<=hellow+1;
            address<=address+1;
        end
        else if(state==6) begin
            wea<=1;
            state<=7;
        end
        else if(state==7)begin
            wea<=0;
            state<=4;
            hellow<=hellow+1;
            address<=address+1;
        end
        else if(state==4)begin
            if(address < depth_for_ram) begin
                if(sha3_end) begin
                    sha3_start<=0;
                    S_in<=S_out;
                    state<=2;
                end
                else begin
                    sha3_start<=1;
                end
            end
            else begin
                state<=5;
            end
        end
        else if(state==5) begin
            kdf_end<=1;
            S_in<=0;
            sha3_start<=0;
            state<=0;
            address<=0;
        //    data_for_ram<=0;
        end
    end
end

sha3_f_func sha3_ff(
    clk,
    reset,
    sha3_start,
    S_in,
    S_out,
    sha3_out,
    sha3_end
);




endmodule