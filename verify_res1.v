module verify_res1(
    input clk,
    input reset,
    input [7:0]t,
    input [255:0]Ht_i,
    input [255:0]salt_i,
    input [128*4-1:0]seed_star_i,
    input [256*4-1:0]Cv_i,
    input [127:0] seed_triangle_i,
    //Z
    input [128*15*4-1:0]seedInfo,
    input [128*4-1:0]masked_key,
    input [512*4-1:0]msgs,
    input [256*4-1:0]C,
    input [512*4-1:0]seed_lambda,
    input [1024*4-1:0]aux_triangle,

    input [51199:0]M,
    input [127:0]pk,
    input verify_res1_start,
    output [255:0] H,
    output reg verify_successful,
    output reg verify_res1_end
    );

    reg[9:0] state;


    //HCP
    reg HCP_for_verify_start;
    wire HCP_for_verify_end;
    wire [19:0] Lc;
    wire [19:0] Lp;
    
    wire [19:0] Lc2;
    wire [19:0] Lp2;

    //round_fun
    reg [4:0]j;
    wire[4:0] LC[3:0] ;
    wire[4:0] LP[3:0] ;

    assign {LC[0],LC[1],LC[2],LC[3]}=Lc;
    assign {LP[0],LP[1],LP[2],LP[3]}=Lp;

    wire j_in_LC=(j[4:0]==LC[0])||(j[4:0]==LC[1])||(j[4:0]==LC[2])||(j[4:0]==LC[3]);

    //seed_star
    wire[127:0] seed_star_list[3:0];
    assign {seed_star_list[0],seed_star_list[1],seed_star_list[2],seed_star_list[3]}=seed_star_i;

    //Cv
    wire [255:0]Cv;
    wire[255:0] Cv_list[3:0];
    assign {Cv_list[0],Cv_list[1],Cv_list[2],Cv_list[3]}=Cv_i;
    reg[255:0] Cv_list2[7:0];
    wire[2047:0] Cv_in_tree={Cv_list2[0],Cv_list2[1],Cv_list2[2],Cv_list2[3],Cv_list2[4],Cv_list2[5],Cv_list2[6],Cv_list2[7]};

    //Cn
    wire [255:0]Cn;
    reg[255:0] Cn_list[7:0];
    wire[2047:0] Cn_in_H={Cn_list[0],Cn_list[1],Cn_list[2],Cn_list[3],Cn_list[4],Cn_list[5],Cn_list[6],Cn_list[7]};
    //Ch
    wire [255:0]Ch;
    reg[255:0] Ch_list[7:0];
    wire[2047:0] Ch_in_tree={Ch_list[0],Ch_list[1],Ch_list[2],Ch_list[3],Ch_list[4],Ch_list[5],Ch_list[6],Ch_list[7]};


    //inseed
    wire [8*128-1:0]inseeds;
    wire [127:0] inseed_list[7:0];
    assign {inseed_list[0],inseed_list[1],inseed_list[2],inseed_list[3],inseed_list[4],inseed_list[5],inseed_list[6],inseed_list[7]}=inseeds;

    //seed
    wire [128*15-1:0] seed_list[3:0];
    assign {seed_list[0],seed_list[1],seed_list[2],seed_list[3]}=seedInfo;

    //masked_key
    wire [127:0] masked_key_list[3:0];
    assign {masked_key_list[0],masked_key_list[1],masked_key_list[2],masked_key_list[3]}=masked_key;

    //msgs
    wire [511:0] msgs_list[3:0];
    assign {msgs_list[0],msgs_list[1],msgs_list[2],msgs_list[3]}=msgs;
    
    //C
    wire [255:0] C_list[3:0];
    assign {C_list[0],C_list[1],C_list[2],C_list[3]}=C;
    
    //seed_lambda
    wire [511:0] seed_lambda_list[3:0];
    assign {seed_lambda_list[0],seed_lambda_list[1],seed_lambda_list[2],seed_lambda_list[3]}=seed_lambda;
    
    //aux_triangle
    wire [1023:0] aux_triangle_list[3:0];
    assign {aux_triangle_list[0],aux_triangle_list[1],aux_triangle_list[2],aux_triangle_list[3]}=aux_triangle;

    //inseed
    reg inseed_tree_start;
    wire inseed_tree_end;
    
    //round_func
    reg add_flag;
    reg [2:0] counter2;
    reg [2:0] counter3;
    reg round_fun1_start;
    wire round_fun1_end;
    wire[4:0] the_index = LC[counter2];


    //ch mktree
    reg ch_tree_start;
    wire[255:0]chroot;
    wire ch_tree_end;
    
    //cv mktree
    reg cv_tree_start;
    wire[255:0]cvroot;
    wire cv_tree_end;

    //csn
    reg csn_Hstart;
    wire [255:0] Csn;
    wire csn_Hend;

    //cstar
    reg cstar_Hstart;
    wire [255:0]C_star;
    wire cstar_Hend;

    //HCP
    reg HCP_start;
    wire HCP_end;

    
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            verify_res1_end<=0;
            state<=0;
            HCP_for_verify_start<=0;
            inseed_tree_start<=0;
            j<=0;
            round_fun1_start<=0;
            counter2<=0;
            counter3<=0;
            add_flag<=0;
            ch_tree_start<=0;
            cv_tree_start<=0;
            csn_Hstart<=0;
            cstar_Hstart<=0;
            verify_successful<=0;
            HCP_start<=0;
        end
        else begin
            if(~verify_res1_start) begin
                verify_successful<=0;
                verify_res1_end<=0;
            end
            if(state==0 && verify_res1_start &&verify_res1_end==0)begin
                state<=1;
            end
            else if(state==1) begin
                if(HCP_for_verify_end==1) begin
                    HCP_for_verify_start<=0;
                    state<=2;
                end
                else begin
                    HCP_for_verify_start<=1;
                end
            end
            else if(state==2) begin
                if(inseed_tree_end==1) begin
                    inseed_tree_start<=0;
                    state<=3;
                end
                else begin
                    inseed_tree_start<=1;
                end
            end

            else if(state==3) begin
                if(j<8) begin
                    if(j_in_LC) begin
                        add_flag<=1;
                    end
                    if(round_fun1_end==1) begin
                        round_fun1_start<=0;
                        if(add_flag) begin
                            counter2<=counter2+1;
                            Cv_list2[j]<=Cv_list[counter2];
                            Cn_list[j]<=Cn;
                            Ch_list[j]<=Ch;
                        end
                        else begin
                            counter3<=counter3+1;
                            Cv_list2[j]<=Cv;
                            Cn_list[j]<=Cn;
                            Ch_list[j]<=Ch;
                        end
                        state<=4;
                    end
                    else begin
                        round_fun1_start<=1;
                    end
                end
                else begin
                    j<=0;
                    counter2<=0;
                    counter3<=0;
                    state<=5;
                end
            end
            else if(state==4) begin
                add_flag<=0;
                j<=j+1;
                state<=3;
            end
            else if(state==5) begin
                if(ch_tree_end==1) begin
                    ch_tree_start<=0;
                    state<=6;
                end
                else begin
                    ch_tree_start<=1;
                end
            end
            else if(state==6) begin
                if(cv_tree_end==1) begin
                    cv_tree_start<=0;
                    state<=7;
                end
                else begin
                    cv_tree_start<=1;
                end
            end
            else if(state==7) begin
                if(csn_Hend==1) begin
                    csn_Hstart<=0;
                    state<=8;
                end
                else begin
                    csn_Hstart<=1;
                end
            end
            else if(state==8) begin
                if(cstar_Hend==1) begin
                    cstar_Hstart<=0;
                    state<=9;
                end
                else begin
                    cstar_Hstart<=1;
                end
            end
            else if(state==9) begin
                if(HCP_end==1) begin
                    HCP_start<=0;
                    state<=10;
                end
                else begin
                    HCP_start<=1;
                end 
            end
            else if(state==10) begin
                if(H==Ht_i) begin
                    verify_successful<=1;
                end
                verify_res1_end<=1;
                state<=0;
            end
        end
    end


    HCP_for_verify HCPfv(clk,reset,Ht_i,HCP_for_verify_start,HCP_for_verify_end,Lc,Lp);
    seed_tree_for_inseeds stfi(clk,reset,seed_triangle_i,salt_i,t,inseed_tree_start,inseeds,inseed_tree_end);
    round_fun2_for_verify_res1 round_fun(
    clk,
    reset,
    j_in_LC,
    t,
    {3'h0,j},
    seed_star_list[counter3],  // 1
    salt_i,
    inseed_list[j],
    seed_list[counter2],
    C_list[counter2],
    seed_lambda_list[counter2],
    aux_triangle_list[counter2],
    masked_key_list[counter2],
    msgs_list[counter2],
    round_fun1_start,
    Ch,
    Cn,
    Cv,
    round_fun1_end
    );
    merkle_tree_for_chroot mtfch(clk,reset,Ch_in_tree,salt_i,ch_tree_start,chroot,ch_tree_end);
    merkle_tree_for_cvroot mtfcv(clk,reset,Cv_in_tree,salt_i,cv_tree_start,cvroot,cv_tree_end);
    H_for_Csn Hfcsn(clk,reset,seed_triangle_i,Cn_in_H,csn_Hstart,Csn,csn_Hend);
    H_for_C_star HfCstar(clk,reset,chroot,cvroot,Csn,cstar_Hstart,C_star,cstar_Hend);
    HCP hcp(clk,reset,C_star,salt_i,pk,M, HCP_start,HCP_end,H,Lc2,Lp2);
endmodule