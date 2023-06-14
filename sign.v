module sign_on_sm4_res1(
        input clk,
        input reset,
        input signature_start,
        input [51199:0] M,
        input [127:0] sk,
        input [127:0] pk,
        
        output reg signature_stop,
        output [19584-1:0] sigma_out
    );


reg [4:0]state;

//set_seed_salt_start;
reg set_seed_salt_start;
wire [127:0] root_seed;
wire [255:0] salt;
wire [127:0] seed_trangle;
wire set_seed_salt_end;


//tree_for_inseeds
reg tree_for_inseeds_start;
wire  [1023:0] inseeds;
wire [127:0] inseed_list[7:0];
assign {inseed_list[0],inseed_list[1],inseed_list[2],inseed_list[3],inseed_list[4],inseed_list[5],inseed_list[6],inseed_list[7]}=inseeds;
wire tree_for_inseeds_end;

//tree_seed_star
reg tree_seed_star_start;
wire [1023:0] seed_star;
wire[127:0] seed_star_list[7:0];
assign {seed_star_list[0],seed_star_list[1],seed_star_list[2],seed_star_list[3],seed_star_list[4],seed_star_list[5],seed_star_list[6],seed_star_list[7]}=seed_star;

wire tree_seed_star_end;

//stap4
reg stap4_start;
wire stap4_end;
reg[7:0] j;
wire [127:0] masked_key_1;
wire [255:0] Ch_1;
wire [255:0] Cv_1;
wire [255:0] Cn_1;
wire [511:0] aux_1;
wire [511:0] msgs_1;
wire [4095:0] C_1;
wire [511:0] seed_lambda_1;
wire [1023:0]aux_triangle_1;
wire [2047:0] seed_1;

reg [127:0] masked_key_0[0:7];
reg [255:0] Ch_0[0:7];
reg [255:0] Cv_0[0:7];
reg [255:0] Cn_0[0:7];
reg [511:0] aux_0[0:7];
reg [511:0] msgs_0[0:7];
reg [4095:0] C_0[0:7];
reg [511:0] seed_lambda_0[0:7];
reg [1023:0]aux_triangle_0[0:7];
reg [2047:0] seed_0[0:7];
//seed
wire [128*15*8-1:0] seed;
assign seed={seed_0[0][2047:128],seed_0[1][2047:128],seed_0[2][2047:128],seed_0[3][2047:128],seed_0[4][2047:128],seed_0[5][2047:128],seed_0[6][2047:128],seed_0[7][2047:128]};

//C
wire [8*256-1:0] C;
assign C={C_0[0][255:0],C_0[1][255:0],C_0[2][255:0],C_0[3][255:0],C_0[4][255:0],C_0[5][255:0],C_0[6][255:0],C_0[7][255:0]};


// aux 
wire [8*512-1:0] aux;
assign aux={aux_0[0],aux_0[1],aux_0[2],aux_0[3],aux_0[4],aux_0[5],aux_0[6],aux_0[7]};

// msgs 
wire [8*512-1:0] msgs;
assign msgs={msgs_0[0],msgs_0[1],msgs_0[2],msgs_0[3],msgs_0[4],msgs_0[5],msgs_0[6],msgs_0[7]};

// masked_key 
wire [8*128-1:0] masked_key;
assign masked_key={masked_key_0[0],masked_key_0[1],masked_key_0[2],masked_key_0[3],masked_key_0[4],masked_key_0[5],masked_key_0[6],masked_key_0[7]};

//wire seed_lambda
wire [8*512-1:0]seed_lambda;
assign seed_lambda={seed_lambda_0[0],seed_lambda_0[1],seed_lambda_0[2],seed_lambda_0[3],seed_lambda_0[4],seed_lambda_0[5],seed_lambda_0[6],seed_lambda_0[7]};

//wire aux_triangle
wire [8*1024-1:0]aux_triangle;
assign aux_triangle={aux_triangle_0[0],aux_triangle_0[1],aux_triangle_0[2],aux_triangle_0[3],aux_triangle_0[4],aux_triangle_0[5],aux_triangle_0[6],aux_triangle_0[7]};


//chroot
wire [8*256-1:0] ch;
assign ch={Ch_0[0],Ch_0[1],Ch_0[2],Ch_0[3],Ch_0[4],Ch_0[5],Ch_0[6],Ch_0[7]};
reg chroot_start;
wire [255:0] chroot;
wire chroot_set_end;

//cvroot
wire [8*256-1:0] cv;
assign cv={Cv_0[0],Cv_0[1],Cv_0[2],Cv_0[3],Cv_0[4],Cv_0[5],Cv_0[6],Cv_0[7]};
reg cvroot_start;
wire [255:0] cvroot;
wire cvroot_set_end;

//cvroot
wire [8*256-1:0] cn;
assign cn={Cn_0[0],Cn_0[1],Cn_0[2],Cn_0[3],Cn_0[4],Cn_0[5],Cn_0[6],Cn_0[7]};
reg csn_start;
wire [255:0] csn;
wire csn_set_end;

//cstar
reg cstarstart;
wire [255:0] cstar;
wire cstar_en_end;

//hcp
reg HCP_start;
wire HCP_end;
wire [255:0] H;
wire [4*5-1:0] Lc;
wire [4*5-1:0] Lp;

//get_sign
reg get_sign_start;
wire get_sign_end;


always @(posedge clk or negedge reset) begin
    if(~reset) begin
        state<=0;
        signature_stop<=0;
        set_seed_salt_start<=0;
        tree_for_inseeds_start<=0;
        chroot_start<=0;
        stap4_start<=0;
        HCP_start<=0;
        cstarstart<=0;
        csn_start<=0;
        cvroot_start<=0;
        chroot_start<=0;
        get_sign_start<=0;
        j<=0;
    end
    else begin
        if(~signature_start) begin
            signature_stop<=0;
            j<=0;
        end
        if(state==0 && signature_start &&signature_stop==0)begin
            state<=1;
        end
        else if(state==1) begin
            if(set_seed_salt_end==1) begin
                state<=2;
                set_seed_salt_start<=0;
            end 
            else begin
                  set_seed_salt_start<=1;
            end
        end
        else if(state==2) begin
            if(tree_for_inseeds_end==1) begin
                state<=3;
                tree_for_inseeds_start<=0;
            end 
            else begin
                tree_for_inseeds_start<=1;
            end
        end
        else if(state==3) begin
            if(tree_seed_star_end==1) begin
                state<=4;
                tree_seed_star_start<=0;
            end 
            else begin
                tree_seed_star_start<=1;
            end
        end
        else if(state==4) begin
            if(stap4_end==1) begin
                masked_key_0[j]<=masked_key_1;
                Ch_0[j]<=Ch_1;
                Cv_0[j]<=Cv_1;
                Cn_0[j]<=Cn_1;
                aux_0[j]<=aux_1;
                msgs_0[j]<=msgs_1;
                C_0[j]<=C_1;
                seed_lambda_0[j]<=seed_lambda_1;
                aux_triangle_0[j]<=aux_triangle_1;
                seed_0[j]<=seed_1;
                j<=j+1;
                stap4_start<=0;
                if(j==7) begin
                    state<=5;
                end
                else begin
                    state<=12;
                end
            end 
            else begin
                stap4_start<=1;
            end
        end
        else if(state==12) begin
            state<=4;
        end
        else if(state==5) begin
            if(chroot_set_end==1) begin
                chroot_start<=0;
                state<=6;
            end 
            else begin
                chroot_start<=1;
            end
        end
        else if(state==6) begin
            if(cvroot_set_end==1) begin
                cvroot_start<=0;
                state<=7;
            end 
            else begin
                cvroot_start<=1;
            end
        end
        else if(state==7) begin
            if(csn_set_end==1) begin
                csn_start<=0;
                state<=8;
            end 
            else begin
                csn_start<=1;
            end
        end
        else if(state==8) begin
            if(cstar_en_end==1) begin
                cstarstart<=0;
                state<=9;
            end 
            else begin
                cstarstart<=1;
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
            if(get_sign_end==1) begin
                get_sign_start<=0;
                state<=11;
            end 
            else begin
                get_sign_start<=1;
            end
        end
        else if(state==11) begin
            signature_stop<=1;
            state<=0;
        end
    end
end 

set_seed_salt sss(clk,reset,sk,set_seed_salt_start,root_seed,salt,seed_trangle,set_seed_salt_end);
seed_tree_for_seed_star stfss(clk,reset,root_seed,salt,8'h1,tree_seed_star_start,seed_star,tree_seed_star_end);
seed_tree_for_inseeds stfi(clk,reset,seed_trangle,salt,8'h1,tree_for_inseeds_start,inseeds,tree_for_inseeds_end);
stap4 st4(clk,reset,stap4_start,seed_star_list[j],inseed_list[j],salt,8'h1,j,sk,masked_key_1,Ch_1,Cv_1,Cn_1,C_1,seed_lambda_1,aux_triangle_1,seed_1,aux_1,msgs_1,stap4_end);
merkle_tree_for_chroot mtfc(clk,reset,ch,salt,chroot_start,chroot,chroot_set_end);
merkle_tree_for_cvroot mtfcv(clk,reset,cv,salt,cvroot_start,cvroot,cvroot_set_end);
H_for_Csn hfcsn(clk,reset,seed_trangle,cn,csn_start,csn,csn_set_end);
H_for_C_star hfcsr(clk,reset,chroot,cvroot,csn,cstarstart,cstar,cstar_en_end);
HCP hcp(clk,reset,cstar,salt,pk,M,HCP_start,HCP_end,H,Lc,Lp);
get_sign gs(clk,reset,get_sign_start,Lc,Lp,H,salt,seed_star,cv,seed,aux,masked_key, msgs,C, seed_lambda,aux_triangle,seed_trangle,sigma_out,get_sign_end);
endmodule