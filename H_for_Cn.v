module H_for_Cn(
    input clk,
    input reset,
    input  [511:0] seed,
    input  [1023:0] aux_triangle,
    input  [255:0] salt,
    input Hstart,
    output [255:0] hashValue,
    output reg en_end
    );
    reg[0:1] state;
    reg cf_start;
    wire cf_end;
    reg [255:0] iv;
    reg [3:0]counter;

    wire [2047:0]hashin={seed,aux_triangle,salt,8'h80,184'h0,64'd1792};
    wire [511:0]hashin2[73:0];
    assign{hashin2[0],hashin2[1],hashin2[2],hashin2[3]}=hashin;

    wire [511:0] h_in=hashin2[counter];
    




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
            if(state==0 && Hstart&&en_end==0)begin
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
                    if(counter==3) begin
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