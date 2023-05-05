module seed_tree_for_stap4(
    input clk,
    input reset,
    input[127:0] iseed,
    input[255:0] salt,
    input[7:0] t,
    input tree_start,
    output [2047:0] seed,
    output reg tree_set_end
    );
    reg [511:0] h1InSeedSet0;
    wire [511:0] h1InSeedSet [7:0];
    reg[7:0] j;
    reg[7:0] j2;
    wire [103:0]padding={8'h80,32'h0,64'h198};
    reg [7:0] Hstart;
    wire [255:0] hashValue[7:0];
    wire [7:0] en_end; 
    reg[4:0] state; 
    reg[4:0] counter;
    wire [0:7] start_marsk[0:3];
    assign start_marsk[0] = 1; 
    assign start_marsk[1] = 8'h3; 
    assign start_marsk[2] = 8'hf;  
    assign start_marsk[3] = 8'hff;  
    
    assign seed[2047:1792] = hashValue[0];
    assign seed[1791:1536] = hashValue[1];
    assign seed[1535:1280] = hashValue[2];
    assign seed[1279:1024] = hashValue[3];
    assign seed[1023:768] = hashValue[4];
    assign seed[767:512] = hashValue[5];
    assign seed[511:256] = hashValue[6];
    assign seed[255:0] = hashValue[7];

    assign h1InSeedSet[1]={8'h01,hashValue[0][127:0],salt,t,j+1,padding};
    assign h1InSeedSet[2]={8'h01,hashValue[1][255:128],salt,t,j+2,padding};
    assign h1InSeedSet[3]={8'h01,hashValue[1][127:0],salt,t,j+3,padding};
    assign h1InSeedSet[4]={8'h01,hashValue[2][255:128],salt,t,j+4,padding};
    assign h1InSeedSet[5]={8'h01,hashValue[2][127:0],salt,t,j+5,padding};
    assign h1InSeedSet[6]={8'h01,hashValue[3][255:128],salt,t,j+6,padding};
    assign h1InSeedSet[7]={8'h01,hashValue[3][127:0],salt,t,j+7,padding};              
    
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            counter <= 0;
            state<=0;
            tree_set_end<=0;
            j<=1;
            j2<=1;
        end
        else begin
            if(state==0) begin
                if(tree_start) begin
                    if(counter==0)begin
                        j<=1;
                        j2<=1;
                        h1InSeedSet0<={8'h01,iseed,salt,t,8'h0,padding};
                    end
                    tree_set_end<=0;
                    Hstart<=start_marsk[counter];
                    state<=1;
                    
                end
                
            end
            if(state==1) begin
                if(en_end==start_marsk[counter]) begin
                        counter<=counter+1;
                        Hstart<=0;
                        j<=j2;
                        j2<=j2<<1;
                        h1InSeedSet0<={8'h01,hashValue[0][255:128],salt,t,j+0,padding};
                        if(en_end == start_marsk[3]) begin
                            state<=2;
                        end
                        else begin
                            state<=0;
                        end
                        
            end
                                   
        end
            if(state==2) begin
                tree_set_end<=1;
                state <= 3;
            end
            if(state==3) begin
                tree_set_end <= 0;
                state<=0;
                counter <= 0;
            end
        end

    end
    H_for_s_tree h0(clk,reset,h1InSeedSet0,Hstart[0],hashValue[0],en_end[0]);
    H_for_s_tree h1(clk,reset,h1InSeedSet[1],Hstart[1],hashValue[1],en_end[1]);
    H_for_s_tree h2(clk,reset,h1InSeedSet[2],Hstart[2],hashValue[2],en_end[2]);
    H_for_s_tree h3(clk,reset,h1InSeedSet[3],Hstart[3],hashValue[3],en_end[3]);
    H_for_s_tree h4(clk,reset,h1InSeedSet[4],Hstart[4],hashValue[4],en_end[4]);
    H_for_s_tree h5(clk,reset,h1InSeedSet[5],Hstart[5],hashValue[5],en_end[5]);
    H_for_s_tree h6(clk,reset,h1InSeedSet[6],Hstart[6],hashValue[6],en_end[6]);
    H_for_s_tree h7(clk,reset,h1InSeedSet[7],Hstart[7],hashValue[7],en_end[7]);

endmodule





