module signature(
    input clk,
    input reset,
    input [51199:0]M,
    input [255:0]root_seed,
    input [255:0]salt,
    input [254:0] sk,
    input sign_start,
    output reg sign_end,
    output reg [511:0]Cv_root,
    output reg [68*10-1:0] Lc,
    output reg [68*5-1:0] Lp
    );
    
    reg tree_start;
    reg stap4_start;
    reg m_tree_start;
    reg HCP_start;

    reg [16:0] t;
    //reg[256*601-1:0] iseed;
    reg [10:0] state;
    reg [512*601-1:0] Ch;
    reg [512*601-1:0] Cv;
    reg [255*601-1:0] masked_key;
    //reg [511:0]Cv_root;

    wire [511:0] ch;
    wire [511:0] cv;
    wire [254:0] maskedkey;
    wire[256*601-1:0] iseed;
    wire[16:0] T=601;
    wire[20:0] index= 512*601-1-t*512;
    wire[20:0] index2=255*601-1-t*255;
    wire[20:0] index3=256*601-1-t*256;
    wire[255:0] iseed_i=iseed[index3-:256];
    wire[511:0]Cvroot;
    wire[68*10-1:0] lc;
    wire[68*5-1:0] lp;
    
    wire tree_set_end;
    wire stap4_end;
    wire m_tree_set_end;
    wire HCP_end;

    wire [255:0] pk=0;
    
    
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            tree_start<=0;
            state<=0;
            t<=0;
           // iseed<=0;
            Ch<=0;
            Cv<=0;
            masked_key<=0;
            HCP_start<=0;
            Cv_root<=0;
            sign_end<=0;
        end
        else begin
            if(~sign_start) begin
                sign_end<=0;
            end
            else if(state==0 && sign_start)begin
                if (sign_end==0) begin
                    state<=1;
                end
            end
            if(state==1) begin
                tree_start<=1;
                if(tree_set_end) begin
                   // iseed<=iseed_t[256*602-1:256];
                    tree_start<=0;
                    state<=2;
                end
            end
            else if(state==2) begin
                stap4_start<=1;
                if(stap4_end) begin
                    masked_key[index2-:255]<=maskedkey;
                    Ch[index-:512]<=ch;
                    Cv[index-:512]<=cv;
                    stap4_start<=0;
                    t<=t+1;
                    if(t==T) begin
                        t<=0;
                        state<=3;
                    end
                end
            end
            else if(state==3) begin
                m_tree_start<=1;
                if(m_tree_set_end) begin
                    m_tree_start<=0;
                    Cv_root<=Cvroot;
                    state<=4;
                end
            end
            else if(state==4) begin
                HCP_start<=1;
                if(HCP_end) begin
                    Lc<=lc;
                    Lp<=lp;
                    HCP_start<=0;
                    state<=5;
                end
            end
            else if(state==5) begin
                sign_end<=1;
                state<=0;
            end
        end
    end

    seed_tree st(clk,reset,root_seed,salt,16'h0,tree_start,iseed,tree_set_end);
    stap4 stap(clk,reset,stap4_start,iseed_i,salt,t,sk,maskedkey,ch,cv,stap4_end);
    merkle_tree mt(clk,reset,Cv,salt,m_tree_start, Cvroot,m_tree_set_end);
    HCP hcp(clk,reset,Ch,Cv_root,salt,pk,M,HCP_start,HCP_end,lc,lp);

endmodule      