module commitment_without_aux(
    input clk,
    input reset,
    input[128*15-1:0] seed,
    input[255:0] salt,
    input[7:0] t,
    input[7:0] j,
    input com_start,
    output reg com_end,
    output [3839:0] C 
);
    reg [255:0] c[14:0];
    assign C = {c[0],c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12],c[13],c[14]};
    wire [127:0] seed_list[14:0];
    assign {seed_list[0],seed_list[1],seed_list[2],seed_list[3],seed_list[4],seed_list[5],seed_list[6],seed_list[7],seed_list[8],seed_list[9],seed_list[10],seed_list[11],seed_list[12],seed_list[13],seed_list[14],seed_list[15]}=seed;
    
    reg [7:0] i;
    wire [127:0] seed_in=seed_list[i];
    reg [4:0] state;
    reg Hstart1;
    wire[255:0] hashValue1;
    wire[5:0] N=14;
    wire en_end1;
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            {c[0],c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12],c[13],c[14]}<=3840'h0;
            i<=8'h0;
            com_end<=0;
            state<=0;
        end
        else begin
            if(state==0) begin
                if(com_start==0) begin
                    com_end<=0;
                end
                else if(com_start==1 && com_end==0) begin
                    if(en_end1) begin
                        Hstart1<=0;
                        i<=i+1;
                        c[i]=hashValue1;
                        if(i==N) begin
                            state<=1;
                        end
                    end 
                    else begin
                        Hstart1<=1;
                    end
                end
            end
            if(state==1) begin
                com_end<=1;
                i<=16'h0;
                state<=0;
            end      
        end
    end

H_for_C1 H1(clk,reset,seed_in,salt,t,j,i,Hstart1,hashValue1,en_end1);
endmodule