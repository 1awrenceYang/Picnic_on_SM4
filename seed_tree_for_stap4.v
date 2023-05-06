`timescale 1ns / 1ps
module seed_tree_for_stap4(
    input clk,
    input reset,
    input[255:0] iseed,
    input[255:0] salt,
    input[15:0] t,
    input tree_start,
    output reg [4095:0] seed,
    output reg tree_set_end
    );
    reg [1087:0] h1InSeedSet [7:0];
    reg[15:0] j;
    wire [519:0]padding={8'h1f,560'h0,8'h80};
    reg [7:0] Hstart;
    reg [7:0] restart;
    wire [511:0] hashValue[7:0];
    wire [7:0] en_end;
    wire [9:0] groupNum=1;
    reg[4:0] state; 
    reg[9:0] counter;
    wire [0:7] start_marsk[0:2];
    assign start_marsk[0] = 1;
    assign start_marsk[1] = 8'h3;
    assign start_marsk[2] = 8'hf;

    always @(posedge clk or negedge reset) begin
        if(~reset) 
        begin
            counter <= 0;
            state<=0;
            tree_set_end<=0;
            j<=1;
        end
        else 
        begin
            if(state==0) 
            begin
                j<=1;
                if(tree_start) 
                begin
                    tree_set_end<=0;
                    Hstart<=start_marsk[counter];
                    restart<=0;
                    state<=1;
                    if(counter==0)
                    begin
                        h1InSeedSet[0]={8'h01,iseed,salt,t,16'h0,padding};
                        //h1InSeedSet[0]<=0;
                    end
                end
                
            end
            if(state==1) 
            begin
                if(en_end==start_marsk[counter]) 
                begin
                        counter<=counter+1;
                        restart<=Hstart;
                        if(en_end == start_marsk[2]) 
                        begin
                            state<=2;
                        end
                        else 
                        begin
                            state<=0;
                        end
                        h1InSeedSet[0]<={8'h01,hashValue[0][511:256],salt,t,j+0,padding};
                        h1InSeedSet[1]<={8'h01,hashValue[0][255:0],salt,t,j+1,padding};
                        h1InSeedSet[2]<={8'h01,hashValue[1][511:256],salt,t,j+2,padding};
                        h1InSeedSet[3]<={8'h01,hashValue[1][255:0],salt,t,j+3,padding};
                        h1InSeedSet[4]<={8'h01,hashValue[2][511:256],salt,t,j+4,padding};
                        h1InSeedSet[5]<={8'h01,hashValue[2][255:0],salt,t,j+5,padding};
                        h1InSeedSet[6]<={8'h01,hashValue[3][511:256],salt,t,j+6,padding};
                        h1InSeedSet[7]<={8'h01,hashValue[3][255:0],salt,t,j+7,padding};
                    end
                    j<=j<<1;
                                   
            end
            if(state==2) 
            begin
                seed[4095:3584] <= hashValue[0];
                seed[3583:3072] <= hashValue[1];
                seed[3071:2560] <= hashValue[2];
                seed[2559:2048] <= hashValue[3];
                seed[2047:1536] <= hashValue[4];
                seed[1535:1024] <= hashValue[5];
                seed[1023:512] <= hashValue[6];
                seed[511:0] <= hashValue[7];
                tree_set_end<=1;
                state <= 3;
            end
            if(state==3) 
            begin
                tree_set_end <= 0;
                state<=0;
                counter <= 0;
            end
        end

    end

    

H h0(clk,reset,4'h0,h1InSeedSet[0],1088'h0,Hstart[0],restart[0],groupNum,hashValue[0],en_end[0]);
H h1(clk,reset,4'h0,h1InSeedSet[1],1088'h0,Hstart[1],restart[1],groupNum,hashValue[1],en_end[1]);
H h2(clk,reset,4'h0,h1InSeedSet[2],1088'h0,Hstart[2],restart[2],groupNum,hashValue[2],en_end[2]);
H h3(clk,reset,4'h0,h1InSeedSet[3],1088'h0,Hstart[3],restart[3],groupNum,hashValue[3],en_end[3]);
H h4(clk,reset,4'h0,h1InSeedSet[4],1088'h0,Hstart[4],restart[4],groupNum,hashValue[4],en_end[4]);
H h5(clk,reset,4'h0,h1InSeedSet[5],1088'h0,Hstart[5],restart[5],groupNum,hashValue[5],en_end[5]);
H h6(clk,reset,4'h0,h1InSeedSet[6],1088'h0,Hstart[6],restart[6],groupNum,hashValue[6],en_end[6]);
H h7(clk,reset,4'h0,h1InSeedSet[7],1088'h0,Hstart[7],restart[7],groupNum,hashValue[7],en_end[7]);
endmodule