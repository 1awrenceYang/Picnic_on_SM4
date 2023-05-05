module merkle_tree_for_chroot(
    input clk,
    input reset,
    input [8*256-1:0] ch,
    input [255:0]salt,
    input tree_start,
    output reg [255:0] chroot,
    output reg tree_set_end
    );
    reg [1023:0] h3InCommitment [3:0];
    reg[7:0] j;
    wire [215:0]padding={8'h80,216'h0,16'h310};
    reg [3:0] Hstart;
    wire [255:0] hashValue[3:0];
    wire [3:0] en_end;
    wire [9:0] groupNum=1;
    reg[4:0] state; 
    reg[9:0] counter;
    wire [0:3] start_marsk[0:2];
    assign start_marsk[2] = 1;
    assign start_marsk[1] = 4'h3;
    assign start_marsk[0] = 4'hf;

    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            counter <= 0;
            state<=0;
            chroot<=0;
            tree_set_end<=0;
            j<=8'd3;
        end
        else begin
            if(tree_start==0) begin
                tree_set_end<=0;
            end
            if(state==0) begin
                if(tree_start && tree_set_end==0) begin
                    tree_set_end<=0;
                    Hstart<=start_marsk[counter];
                    state<=1;
                    if(counter==0)begin
                        h3InCommitment[0]<={8'h03,ch[2047:1792],ch[1791:1536],salt,j+0,padding};
                        h3InCommitment[1]<={8'h03,ch[1535:1280],ch[1279:1024],salt,j+1,padding};
                        h3InCommitment[2]<={8'h03,ch[1023:768],ch[767:512],salt,j+2,padding};
                        h3InCommitment[3]<={8'h03,ch[511:256],ch[255:0],salt,j+3,padding};
                    end
                end
                
            end
            if(state==1) begin
                if(en_end==start_marsk[counter]) begin
                    counter<=counter+1;
                    Hstart<=0;
                    j<=j>>1;
                    if(en_end == start_marsk[2]) begin
                        state<=2;
                    end
                    else begin
                        state<=0;
                    end                        
                    h3InCommitment[0]<={8'h03,hashValue[0],hashValue[1],salt,j+0,padding};
                    h3InCommitment[1]<={8'h03,hashValue[2],hashValue[3],salt,j+1,padding};
                end               
            end
            if(state==2) begin
                j<=8'd3;
                tree_set_end<=1;
                state <= 0;
                chroot<=hashValue[0];
                counter<=0;
            end
            
        end
    end
    H_for_m_tree h0(clk,reset,h3InCommitment[0],Hstart[0],hashValue[0],en_end[0]);
    H_for_m_tree h1(clk,reset,h3InCommitment[1],Hstart[1],hashValue[1],en_end[1]);
    H_for_m_tree h2(clk,reset,h3InCommitment[2],Hstart[2],hashValue[2],en_end[2]);
    H_for_m_tree h3(clk,reset,h3InCommitment[3],Hstart[3],hashValue[3],en_end[3]);
endmodule