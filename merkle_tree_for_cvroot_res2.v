module merkle_tree_for_cvroot_res2(
    input clk,
    input reset,
    input [4*256-1:0] cv,
    input [255:0]salt,
    input tree_start,
    output reg [255:0] cvroot,
    output reg tree_set_end
    );
    reg [1023:0] h3InCommitment [3:0];
    reg[7:0] j;
    wire [215:0]padding={8'h80,216'h0,16'h310};
    reg [2:0] Hstart;
    wire [255:0] hashValue[3:0];
    wire [2:0] en_end;
    wire [9:0] groupNum=1;
    reg[4:0] state; 
    reg[9:0] counter;
    wire [0:2] start_marsk[0:1];
    assign start_marsk[1] = 1;
    assign start_marsk[0] = 64'h3;

    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            counter <= 0;
            state<=0;
            cvroot<=0;
            tree_set_end<=0;
            j<=8'd3;
        end
        else begin
            if(~tree_start) begin 
                tree_set_end<=0;
            end
            if(state==0) begin
                if(tree_start && tree_set_end==0) begin
                    tree_set_end<=0;
                    Hstart<=start_marsk[counter];
                    state<=1;
                    if(counter==0)begin
                        h3InCommitment[0]={8'h03,cv[1023:768],cv[767:512],salt,j+2,padding};
                        h3InCommitment[1]={8'h03,cv[511:256],cv[255:0],salt,j+3,padding};
                    end
                end
                
            end
            if(state==1) begin
                if(en_end==start_marsk[counter]) begin
                    counter<=counter+1;
                    Hstart<=0;
                    j<=j>>1;
                    if(en_end == start_marsk[1]) begin
                        state<=2;
                    end
                    else begin
                        state<=0;
                    end                        
                    h3InCommitment[0]<={8'h03,hashValue[0],hashValue[1],salt,j+0,padding};
                end               
            end
            if(state==2) begin
                j<=8'd3;
                tree_set_end<=1;
                state <= 0;
                cvroot<=hashValue[0];
                counter<=0;
            end
        end

    end
    H_for_m_tree h0(clk,reset,h3InCommitment[0],Hstart[0],hashValue[0],en_end[0]);
    H_for_m_tree h1(clk,reset,h3InCommitment[1],Hstart[1],hashValue[1],en_end[1]);
endmodule