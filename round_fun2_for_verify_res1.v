module round_fun2_for_verify_res1(
    input clk,
    input reset,
    input t_in_LC,
    input [7:0] t,
    input [7:0] j,
    input [127:0] seed_star,
    input [255:0] salt,
    input [127:0] instseeds,
    input [128*15-1:0] seed_i,
    input [255:0] C_i,
    input [511:0] seed_lambda_i,
    input [1023:0] aux_triangle_i,
    input [127:0]masked_key_i,
    input [511:0] msgs_i,
    input round_fun1_start,
    output [255:0] Ch,
    output [255:0] Cn,
    output [255:0] Cv,
    output reg round_fun1_end
    );

    reg[9:0] state;

    //tree
    reg tree_start;
    wire tree_set_end; 
    wire [2047:0] seed;
    
    //compute_aux
    wire [511:0] aux;
    reg AUX_MPC_start;
    wire AUX_MPC_end;
    wire [255:0] lambda_masked_key_out;
    wire [255:0] inter_masked_key_out;
    //commitment
    reg com_start;
    wire com_end;
    wire [4095:0] C1;

    //commitment_without_aux
    reg com_wa_start;
    wire com_wa_end;
    wire [3839:0] C2;

    wire [4095:0] C= t_in_LC?{C2,C_i}:C1;

    
    //mpc
    wire[511:0] msgs;
    wire[255:0] lambda_masked_key=0;
    wire inter_masked_key;





    //Ch
    reg ch_start;
    wire[255:0] ch;
    wire ch_end;

    //set_seed_lambda
    reg set_seed_lambda_start;
    wire set_seed_lambda_end;
    wire [16*4*128-1:0] seed_lambda;

    //set_deta
    reg set_deta_start;
    wire set_deta_end;
    wire [1023:0] deta;

    wire [1023:0] aux_triangle = t_in_LC?aux_triangle_i:{4{lambda_masked_key_out}}^deta;
    wire [511:0] seed_lambda_for_cn_in=t_in_LC?seed_lambda_i:seed_lambda[511:0];
    //Cn
    reg Cn_start;
    wire Cn_end;
    wire [255:0] cn;

    //Cv
    wire[128:0]masked_key_cv_in =t_in_LC?masked_key_i:inter_masked_key_out[255:128];
    wire[511:0]msgs_cv_in=t_in_LC?msgs_i:msgs;
    reg Cv_start;
    wire Cv_end;
    wire [255:0] cv;


    assign Ch=ch;
    assign Cn=cn;
    assign Cv=cv;
    
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            round_fun1_end<=0;
            tree_start<=0;
            state<=0;
            com_start<=0;
            ch_start<=0;

            set_seed_lambda_start<=0;
        end
        else begin
            if(~round_fun1_start) begin
                round_fun1_end<=0;
            end
            if(state==0 && round_fun1_start&&round_fun1_end==0)begin
                state<=1;
            end
            else if(state==1) begin
                if(tree_set_end==1) begin
                    tree_start<=0;
                    state<=2;
                end
                else begin
                    tree_start<=1;
                end
            end
            //aux
            else if(state==2) begin
            if(t_in_LC==0) begin
                if(AUX_MPC_end) begin
                    
                    AUX_MPC_start<=0;
                    state<=3;
                end
                else begin
                    AUX_MPC_start<=1;
                end
            end
            
            else if(t_in_LC==1) begin
                    state<=3;
             end
             end
            else if(state==3) begin
                if(t_in_LC==0) begin
                    if(com_end==1) begin
                        com_start<=0;
                        state<=4;
                    end
                    else begin
                        com_start<=1;
                    end 
                end
                else if(t_in_LC==1) begin
                    com_wa_start<=1;
                    if(com_wa_end==1) begin
                        com_wa_start<=0;
                        state<=4;
                    end
                    else begin
                        com_wa_start<=1;
                    end  
                end
            end
            //mpc
            else if(state==4) begin
                if(t_in_LC==0) begin
                    state<=5;
                end        
                else if(t_in_LC==1) begin
                    state<=5;
                end
            end
            else if(state==5) begin
                if(ch_end==1) begin
                    ch_start<=0;
                    state<=6;
                end
                else begin
                    ch_start<=1;
                end
            end
            else if(state==6) begin
                if(t_in_LC==0) begin
                    if(set_seed_lambda_end==1) begin
                        set_seed_lambda_start<=0;
                        state<=7;
                    end
                    else begin
                        set_seed_lambda_start<=1;
                    end
                end
                else if(t_in_LC==1) begin
                    state<=7;
                end
            end
            else if(state==7) begin
                if(t_in_LC==0) begin
                    if(set_deta_end==1) begin
                        set_deta_start<=0;
                        state<=8;
                    end
                    else begin
                        set_deta_start<=1;
                    end
                end
                else if(t_in_LC==1) begin
                    state<=8;
                end
            end
            else if(state==8) begin
                if(Cn_end==1) begin
                    Cn_start<=0;
                    state<=9;
                end
                else begin
                    Cn_start<=1;
                end
            end
            else if(state==9) begin
                if(Cv_end==1) begin
                    Cv_start<=0;
                    state<=10;
                end
                else begin
                    Cv_start<=1;
                end
            end
            else if(state==10) begin
                round_fun1_end<=1;
                state<=0;
            end
        end
    end

    AUX_and_MPC aux_and_mpc(
    clk,
    reset,
    AUX_MPC_start,
    seed_star,
    salt,
     t,
     j,
    AUX_MPC_end,
    aux,
   lambda_masked_key_out,
    inter_masked_key_out,
     msgs
    );
    
    seed_tree_for_round_fun st(clk,reset,seed_star,salt,j,tree_start,seed,tree_set_end);
    commitment co(clk,reset,seed,aux,salt,t,j,com_start,com_end,C1);
    commitment_without_aux cowa(clk,reset,seed_i,salt,t,j,com_wa_start,com_wa_end,C2);
    H_for_Ch hfch(clk,reset,C,ch_start,ch,ch_end);
    set_seed_lambda ssl(clk,reset,seed_star,salt,j,8'd128,set_seed_lambda_start,seed_lambda,set_seed_lambda_end);
    set_deta sd(clk,reset,instseeds,set_deta_start,deta,set_deta_end);
    H_for_Cn hfcn(clk,reset,seed_lambda_for_cn_in,aux_triangle,salt, Cn_start,cn,Cn_end);
    H_for_Cv hfcv(clk,reset,masked_key_cv_in,msgs_cv_in,Cv_start,cv,Cv_end);
endmodule 