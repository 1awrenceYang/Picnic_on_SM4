module verify_res2(
    input clk,
    input reset,
    input [7:0]t,
    input [255:0]Ht_i,
    input [255:0]salt_i,
    input [255:0]C_star_i,

    input [127:0] seed_triangle_i,
    //Z
    input [128*4-1:0]masked_key,
    input [512*4-1:0]msgs,
    input [512*4-1:0]seed_lambda,
    input [1024*4-1:0]aux_triangle,


    //vstate
    input [128*4-1:0]instseeds,

    input [51199:0]M,
    input [127:0]pk,
    input verify_res2_start,
    output reg verify_successful,
    output reg verify_res2_end
    );


    //seed_lambda
    wire [511:0] seed_lambda_list[3:0];
    assign {seed_lambda_list[0],seed_lambda_list[1],seed_lambda_list[2],seed_lambda_list[3]}=seed_lambda;

    //aux_triangle
    wire [1023:0] aux_triangle_list[3:0];
    assign {aux_triangle_list[0],aux_triangle_list[1],aux_triangle_list[2],aux_triangle_list[3]}=aux_triangle;

    //masked_key
    wire [127:0] masked_key_list[3:0];
    assign {masked_key_list[0],masked_key_list[1],masked_key_list[2],masked_key_list[3]}=masked_key;

    //mags
    wire [511:0] msgs_list[3:0];
    assign {msgs_list[0],msgs_list[1],msgs_list[2],msgs_list[3]}=msgs;

    //insteeds
    wire [127:0] insteeds_list[3:0];
    assign {insteeds_list[0],insteeds_list[1],insteeds_list[2],insteeds_list[3]}=instseeds;


    reg[9:0] state;
    reg [4:0] counter;

    //HCP_RES_V
    reg HCP_RES_v_start;
    wire HCP_RES_v_end;
    wire [19:0]Lp;

    //Cn
    wire[511:0] seed_lambda_i=seed_lambda_list[counter];
    wire[1023:0] aux_triangle_i=aux_triangle_list[counter];
    reg Cn_start;
    wire Cn_end;
    wire [255:0] cn;
    reg [255:0] cn_list [3:0];
    wire [256*4-1:0] Cn= {cn_list[0],cn_list[1],cn_list[2],cn_list[3]};


    //Csn
    reg Csn_start;
    wire Csn_end;
    wire [255:0] Csn;

    //Cv
    wire[127:0] masked_key_i=masked_key_list[counter];
    wire[511:0] msgs_i=msgs_list[counter];
    wire [127:0] insteeds_i=insteeds_list[counter];
    reg Cv_start;
    wire Cv_end;
    wire [255:0] cv;
    reg [255:0] cv_list [3:0];
    wire [256*4-1:0] Cv= {cv_list[0],cv_list[1],cv_list[2],cv_list[3]};
    
    //cvroot_tree
    reg cvroot_tree_start;
    wire cvroot_tree_end;
    wire [255:0] cvroot;

    //c_star
    reg c_star_start;
    wire c_star_end;
    wire [255:0] c_star;

    //Hcpres
    reg HCP_res_start;
    wire HCP_res_end;
    wire [255:0]H;
    wire [19:0]Lp2;

    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            verify_res2_end<=0;
            verify_successful<=0;
            state<=0;
            HCP_RES_v_start<=0;
            Cn_start<=0;
            Csn_start<=0;
            Cv_start<=0;
            cvroot_tree_start<=0;
        end
        else begin
            if(~verify_res2_start) begin
                verify_res2_end<=0;
            end
            if(state==0 && verify_res2_start&&verify_res2_end==0)begin
                state<=1;
            end
            else if(state==1) begin
                if(HCP_RES_v_end==1) begin
                    HCP_RES_v_start<=0;
                    state<=2;
                end
                else begin
                    HCP_RES_v_start<=1;
                end
            end
            else if(state==2) begin
                if(Cn_end==1) begin
                    Cn_start<=0;
                    cn_list[counter]<=cn;
                    if(counter==3) begin
                        counter<=0;
                        state<=3;
                    end
                    else begin
                        counter<=counter+1;
                        state<=2;
                    end
                end
                else begin
                    Cn_start<=1;
                end
            end
            else if(state==3) begin
                if(Csn_end==1) begin
                    Csn_start<=0;
                    state<=4;
                end
                else begin
                    Csn_start<=1;
                end
            end
            else if(state==4) 
            begin
                state<=5;
            end
            else if(state==5) begin
                if(Cv_end==1) begin
                    Cv_start<=0;
                    cv_list[counter]<=cv;
                    if(counter==3) begin
                        counter<=0;
                        state<=6;
                    end
                    else begin
                        counter<=counter+1;
                        state<=5;
                    end
                end
                else begin
                    Cv_start<=1;
                end
            end
            else if(state==6) begin
                if(c_star_end==1) begin
                    c_star_start<=0;
                    state<=7;
                end
                else begin
                    c_star_start<=1;
                end
            end
            else if(state==7) begin
                if(HCP_res_end==1) begin
                    HCP_res_start<=0;
                    state<=8;
                end
                else begin
                    HCP_res_start<=1;
                end
            end
            else if (state<=8) begin
                if(H==Ht_i) begin
                    verify_successful<=1;
                end
                verify_res2_end<=1;
                state<=0;
            end
        end
    end
    HCP_RES_for_verify hcpresv(clk,reset,Ht_i,HCP_RES_v_start,HCP_RES_v_end,Lp);
    H_for_Cn hfcn(clk,reset,seed_lambda_i,aux_triangle_i,salt_i, Cn_start,cn,Cn_end);
    H_for_Csn_for_res2 hfcsnfr2(clk,reset,seed_triangle_i,Cn,Csn_start,Csn,Csn_end);  
    H_for_Cv_for_res2 hfcvfr2(clk,reset, masked_key_i,insteeds_i,msgs_i,Cv_start,cv,Cv_end);
    merkle_tree_for_cvroot_res2 mtfcvr2(clk,reset,Cv,salt_i,cvroot_tree_start,cvroot,cvroot_tree_end);
    H_for_C_star_res2 hfcstarres2(clk,reset,cvroot,Csn,c_star_start,c_star,c_star_end);
    HCP_RES hcpres(clk,reset,c_star,salt,pk,M,HCP_res_start,HCP_res_end,H,Lp2);


endmodule