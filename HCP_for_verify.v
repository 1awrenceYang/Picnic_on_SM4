module HCP_for_verify(
    input clk,
    input reset,
    input [255:0]H,
    input HCP_start,
    output reg HCP_end,
    output reg [4*5-1:0] Lc,
    output reg [4*5-1:0] Lp
    );

    reg[4:0] LC[3:0];
    reg[4:0] LP[3:0];

    wire[255:0] hashValue2;
    reg lc_ok;
    reg helloworld;
    reg one_hash_ok;
    wire[511:0] h=~helloworld?{H,8'h1f,560'h0,8'h80}:{hashValue2,8'h1f,560'h0,8'h80};
    reg Hstart2;

    reg[255:0] hhhh;
    wire en_end;
    wire en_end2;
    reg[4:0] state;
    reg[6:0] index;
    reg[10:0] index_Lc;
    reg[10:0] index_Lp;
    wire[4:0] Lc_temp=hhhh[255:251];
    wire[4:0] Lp_temp=hhhh[255:251];
    wire Lc_temp3=(Lc_temp==LC[0])||(Lc_temp==LC[1])||(Lc_temp==LC[2])||(Lc_temp==LC[3]);   
   
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            {LC[0],LC[1],LC[2],LC[3]}=20'h0;
            {LP[0],LP[1],LP[2],LP[3]}=20'h0;
            Hstart2<=0;
            HCP_end<=0;
            state <= 0;
            index<=0;
            lc_ok<=0;
            one_hash_ok<=0;
            index_Lc<=0;
            index_Lp<=0;
            helloworld<=0;
        end
        else begin
            if(~HCP_start) begin
                HCP_end<=0;
                {LC[0],LC[1],LC[2],LC[3]}=20'h0;
                {LP[0],LP[1],LP[2],LP[3]}=20'h0;
            end
            else if(state==0 && HCP_start&&HCP_end==0)begin
                index_Lc<=0;
                index_Lp<=0;
                if(one_hash_ok == 0) begin
                    hhhh<=H;
                    state<=1;
                    one_hash_ok<=1;
                end
                else begin
                    Hstart2<=1;
                    if(en_end2) begin
                        helloworld<=1;
                        hhhh<=hashValue2;
                        if(lc_ok==0) begin
                            state<=1;
                        end
                        else begin
                            state<=2;
                        end
                    end
                end
            end
            else if(state==1) begin
                Hstart2<=0;
                if(index_Lc<50) begin
                    if(Lc_temp3==1 || Lc_temp>=8)begin
                        index_Lc<=index_Lc+1;
                        hhhh<=hhhh<<5;
                    end
                    else begin
                        LC[index]<=Lc_temp;
                        index_Lc<=index_Lc+1;
                        hhhh<=hhhh<<5;
                        index<=index+1;
                    end
                    if(index == 4) begin
                        lc_ok<=1;
                        state<=0;
                        index<=0;
                    end
                end
                else begin
                    state<=0;
                end
                
            end
            else if(state==2) begin
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
                Lc<={LC[0],LC[1],LC[2],LC[3]};
                Lp<={LP[0],LP[1],LP[2],LP[3]};
                HCP_end<=1;
                Hstart2<=0;
                state <= 0;
                index<=0;
                lc_ok<=0;
                helloworld<=0;
                one_hash_ok<=0;
            end
        end
    end

    H_for_HCP2 H2(clk,reset,h,Hstart2,hashValue2,en_end2);

endmodule

