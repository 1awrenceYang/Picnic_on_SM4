
module seed_tree_for_seed_star(
    input clk,
    input reset,
    input[127:0] root_seed,
    input[255:0] salt,
    input[7:0] t,
    input tree_start,
    output  [1023:0] seed_star,
    output reg tree_set_end
    );
    reg [511:0] h1InSeedSet0;
    wire [511:0] h1InSeedSet [3:0];
    reg[7:0] j;
    wire [103:0]padding={8'h80,32'h0,64'h198};
    reg [3:0] Hstart;
    wire [255:0] hashValue[3:0];
    wire [3:0] en_end; 
    reg[4:0] state; 
    reg[4:0] counter;
    wire [0:3] start_marsk[0:2];
    assign start_marsk[0] = 1; 
    assign start_marsk[1] = 8'h3; 
    assign start_marsk[2] = 8'hf;  
    
    assign seed_star[1023:768] = hashValue[0];
    assign seed_star[767:512] = hashValue[1];
    assign seed_star[511:256] = hashValue[2];
    assign seed_star[255:0] = hashValue[3];

    assign h1InSeedSet[1]={8'h01,hashValue[0][127:0],salt,t,j+1,padding};
    assign h1InSeedSet[2]={8'h01,hashValue[1][255:128],salt,t,j+2,padding};
    assign h1InSeedSet[3]={8'h01,hashValue[1][127:0],salt,t,j+3,padding};
           
    
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            counter <= 0;
            state<=0;
            tree_set_end<=0;
            j<=1;
        end
        else begin
            if(~tree_start) begin
                tree_set_end<=0;
            end
            if(state==0) begin
                if(tree_start && tree_set_end==0) begin
                    if(counter==0)begin
                        j<=1;
                        h1InSeedSet0<={8'h01,root_seed,salt,t,8'h0,padding};
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
                        j<=j<<1;
                        h1InSeedSet0<={8'h01,hashValue[0][255:128],salt,t,j+0,padding};
                        if(en_end == start_marsk[2]) begin
                            state<=2;
                        end
                        else begin
                            state<=0;
                        end
                        
            end
                                   
        end
            if(state==2) begin
                tree_set_end<=1;
                state <= 0;
                counter <= 0;
            end
        end

    end
    H_for_s_tree h0(clk,reset,h1InSeedSet0,Hstart[0],hashValue[0],en_end[0]);
    H_for_s_tree h1(clk,reset,h1InSeedSet[1],Hstart[1],hashValue[1],en_end[1]);
    H_for_s_tree h2(clk,reset,h1InSeedSet[2],Hstart[2],hashValue[2],en_end[2]);
    H_for_s_tree h3(clk,reset,h1InSeedSet[3],Hstart[3],hashValue[3],en_end[3]);


endmodule