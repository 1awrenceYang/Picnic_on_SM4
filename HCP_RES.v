module HCP_RES(
    input clk,
    input reset,
    input [255:0]C_star,
    input [255:0]salt,
    input [127:0]pk,
    input [51199:0]M,
    input HCP_start,
    output reg HCP_end,
    output [255:0] H,
    output reg [4*5-1:0] Lp
    );


    reg[4:0] LP[3:0];


    wire[255:0] hashValue;
    wire[255:0] hashValue2;
    assign H=hashValue;

    reg helloworld;
    reg one_hash_ok;
    wire[511:0] h=~helloworld?{hashValue,8'h1f,560'h0,8'h80}:{hashValue2,8'h1f,560'h0,8'h80};
    reg Hstart;
    reg Hstart2;
    reg[255:0] hhhh;
    wire en_end;
    wire en_end2;
    reg[4:0] state;
    reg[6:0] index;

    reg[10:0] index_Lp;

    wire[4:0] Lp_temp=hhhh[255:251];

   
    always @(posedge clk or negedge reset) begin
        if(~reset) begin

            {LP[0],LP[1],LP[2],LP[3]}=20'h0;
            Hstart<=0;
            Hstart2<=0;
            HCP_end<=0;
            state <= 0;
            index<=0;

            one_hash_ok<=0;

            index_Lp<=0;
            helloworld<=0;
        end
        else begin
            if(~HCP_start) begin

                {LP[0],LP[1],LP[2],LP[3]}=20'h0;
                HCP_end<=0;
            end
            else if(state==0 && HCP_start&&HCP_end==0)begin

                index_Lp<=0;
                if(one_hash_ok == 0) begin
                    Hstart<=1;
                    if(en_end) begin
                        hhhh<=hashValue;
                        state<=1;
                        one_hash_ok<=1;
                    end
                end
                else begin
                    Hstart2<=1;
                    if(en_end2) begin
                        helloworld<=1;
                        hhhh<=hashValue2;
                        state<=1;
                    end
                end
            end
            else if(state==1) begin
                Hstart<=0;
                Hstart2<=0;
                if(index_Lp<50) begin
                    if(Lp_temp>=16)begin
                        index_Lp<=index_Lp+1;
                        hhhh<=hhhh<<5;
                    end
                    else begin
                        LP[index]<=Lp_temp;
                        index_Lp<=index_Lp+1;
                        hhhh<=hhhh<<5;
                        index<=index+1;
                    end
                    if(index == 4) begin
                        state<=3;
                        index<=0;
                    end
                end
                else begin
                    state<=0;
                end   
            end
            else if(state==3) begin 
                Lp<={LP[0],LP[1],LP[2],LP[3]};
                HCP_end<=1;
                Hstart<=0;
                Hstart2<=0;
                state <= 0;
                index<=0;
                helloworld<=0;
                one_hash_ok<=0;
            end
        end
    end

    H_for_HCP1 H1(clk,reset,C_star,salt,pk,M,Hstart,hashValue,en_end);
    H_for_HCP2 H2(clk,reset,h,Hstart2,hashValue2,en_end2);

endmodule