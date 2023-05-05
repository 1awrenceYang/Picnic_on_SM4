module round_fun1_for_verify_res1(
    input clk,
    input reset,
    input [7:0] t,
    input [7:0] j,
    input [127:0] seed_star,
    input [255:0] salt,
    input [127:0] instseeds,
    input round_fun1_start,
    output [255:0] Ch,
    output [255:0] Cn,
    output reg round_fun1_end
    );

    reg[9:0] state;
    
    
    
    //tree
    reg tree_start;
    wire tree_set_end; 
    wire [2047:0] seed;
    
    //compute_aux
    wire[511:0] aux=0;

    //commitment
    reg com_start;
    wire com_end;
    wire [4095:0] C;

    //mpc
    wire msgs;
    wire[255:0] lambda_masked_key=0;
    wire inter_masked_key;
    wire[1023:0] aux_triangle = lambda_masked_key;


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

    //Cn
    reg Cn_start;
    wire Cn_end;
    wire [255:0] cn;


    assign Ch=ch;
    assign Cn=cn;
    
    always @(posedge clk or negedge reset) begin
        if(~reset) 
        begin
            round_fun1_end<=0;
            tree_start<=0;
            state<=0;
            com_start<=0;
            ch_start<=0;
            
        end
        else begin
            if(~round_fun1_start) begin
                round_fun1_end<=0;
            end
            if(state==0 && round_fun1_start&&round_fun1_end==0)begin
                state<=1;
            end
            else if(state==1) begin
                tree_start<=1;
                if(tree_set_end==1) begin
                    tree_start<=0;
                    state<=2;
                end
            end
            else if(state==2) 
                begin//for compute_aux
                        state<=3;
                
                end
            else if(state==3) begin
                com_start<=1;
                if(com_end==1) begin
                    com_start<=0;
                    state<=4;
                end
            end
            else if(state==4) begin//for mpc_simulate
                state<=5;
            end

            else if(state==5) begin
                ch_start<=1;
                if(ch_end==1) begin
                    ch_start<=0;
                    state<=6;
                end
            end
            else if(state==6) begin
                set_seed_lambda_start<=1;
                if(set_seed_lambda_end==1) begin
                    set_seed_lambda_start<=0;
                    state<=7;
                end
            end
            else if(state==7) begin
                set_deta_start<=1;
                if(set_deta_end==1) begin
                    set_deta_start<=0;
                    state<=8;
                end
            end
            else if(state==8) begin
                Cn_start<=1;
                if(Cn_end==1) begin
                    Cn_start<=0;
                    state<=9;
                end
            end
            else if(state==9) begin
                round_fun1_end<=1;
                state<=0;
            end



        end
    end









    seed_tree_for_round_fun st(clk,reset,seed_star,salt,j,tree_start,seed,tree_set_end);
    commitment co(clk,reset,seed,aux,salt,t,j,com_start,com_end,C);
    H_for_Ch hfch(clk,reset,C,ch_start,ch,ch_end);
    set_seed_lambda ssl(clk,reset,seed_star,salt,j,8'd128,set_seed_lambda_start,seed_lambda,set_seed_lambda_end);
    set_deta sd(clk,reset,instseeds,set_deta_start,deta,set_deta_end);
    H_for_Cn hfc(clk,reset,seed_lambda[511:0],aux_triangle,salt, Cn_start,cn,Cn_end);
    
    

endmodule 