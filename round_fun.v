`define TapesLength 16*2295
module stap4(
    input clk,
    input reset,
    input stap4_start,
    input [127:0] seed_star,
    input [127:0] instseeds,
    input[255:0] salt,
    input[7:0] t,
    input[7:0] j,
    input[127:0] sk,
    output reg [127:0] masked_key,
    output reg [255:0] Ch,
    output reg [255:0] Cv,
    output [255:0] Cn,
    output [4095:0] C,
    output [511:0]seed_lambda_0,
    output [1023:0]aux_triangle,
    output [2047:0]seed,
    output wire [511:0] aux,
    output wire [511:0] msgs,
    output reg stap4_end
    );
   // wire [`TapesLength-1:0] tapes;
   // wire pos=11'b00000000010;
   // wire [`TapesLength-1:0] updated_tapes;
    wire [16*4*128-1:0] seed_lambda;
    assign seed_lambda_0=seed_lambda[511:0];
    //wire [4095:0] C;
    //wire [36863:0]msgs=0;
    wire [255:0]hashValue1;
    wire [255:0]hashValue2;

    wire set_tapes_end=1;
    wire tree_set_end;
    reg ca_end;
    reg mpc_end;
    wire com_end;
    wire en_end1;
    wire en_end2;

    //wire [2047:0] seed;
    reg [10:0] state;

    reg tree_start;
    reg ca_start;
    reg set_tapes_start;
    reg mpc_start;
    reg com_start;
    reg Hstart1;
    reg Hstart2;


    // set_deta
    reg set_deta_start;
    wire [1023:0] deta;
    wire set_deta_end; 
   
    // hcn
    reg Hcnstart;
    wire [255:0] hashValue;
    wire hcn_end;
    
    //seed_lambda
    reg seed_lambda_start;
    //wire [16*4*128-1:0] seed_lambda;
    wire seed_lambda_end; 

    //AUX_and_MPC
    reg AUX_MPC_start;
    wire AUX_MPC_end;
    wire [255:0] lambda_masked_key_out;
    wire [255:0] inter_masked_key_out;
    assign aux_triangle=deta^{lambda_masked_key_out,lambda_masked_key_out,lambda_masked_key_out,lambda_masked_key_out};
    
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            state<=0;
            masked_key<=128'h0;

            AUX_MPC_start<=0;

            Ch<=0;
            Cv<=0;
            tree_start<=0;
            ca_start<=0;
            set_tapes_start<=0;
            mpc_start<=0;
            com_start<=0;
            Hstart1<=0;
            Hstart2<=0;
            seed_lambda_start<=0;
            stap4_end<=0;

        end
        else begin
            if(~stap4_start) begin
                stap4_end<=0;
            end
            else if(state==0 && stap4_start&&stap4_end==0)begin
                if(seed_lambda_end) begin
                    seed_lambda_start<=0;
                    state<=1;
                end
                else begin
                    seed_lambda_start<=1;
                end
            end
            else if(state==1) begin
                if(tree_set_end) begin
                    tree_start<=0;
                    state<=3;
                end
                else begin
                    tree_start<=1;
                end
            end
      
            else if(state==3) begin
                if(AUX_MPC_end) begin
                    masked_key<=inter_masked_key_out[255:128];
                    AUX_MPC_start<=0;
                    state<=4;
                end
                else begin
                    AUX_MPC_start<=1;
                end
            end
            else if(state==4) begin
                if(com_end) begin

                    com_start<=0;
                    state<=5;
                end
                else begin
                    com_start<=1;
                end
            end
            else if(state==5) begin
                state<=6;
            end
            else if(state==6) begin
                if(en_end1) begin
                    Hstart1<=0;
                    Ch<=hashValue1;
                    state<=7;
                end
                else begin
                    Hstart1<=1;
                end
            end
            else if(state==7) begin
                if(en_end2) begin
                    Hstart2<=0;
                    Cv<=hashValue2;
                    state<=8;
                end
                else begin
                    Hstart2<=1;
                end
            end
            else if(state==8) begin
                if(set_deta_end) begin
                    set_deta_start<=0;
                    state<=9;
                end
                else begin
                    set_deta_start<=1;
                end
            end
            else if(state==9) begin
                if(hcn_end) begin
                    Hcnstart<=0;
                    state<=10;
                end
                else begin
                    Hcnstart<=1;
                end
            end
            else if(state==10) begin
                stap4_end<=1;
                state<=0;
            end
        end
    end
seed_tree_for_round_fun stfrf(clk,reset,seed_star,salt,j,tree_start,seed,tree_set_end);
//set_tapes st(clk,reset,seed,salt,t,set_tapes_start,tapes,set_tapes_end);
//compute_aux ca(tapes,pos,clk,reset,ca_start,mpc_inputs,updated_tapes,aux,ca_end);
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
    
commitment co(clk,reset, seed,aux,salt,t,j,com_start, com_end,C);
//mpc_simulate mpc(clk,reset,mpc_start,masked_key,
H_for_Ch HH1(clk,reset,C,Hstart1,hashValue1,en_end1);
H_for_Cv HH2(clk,reset,masked_key,msgs,Hstart2,hashValue2,en_end2);
set_deta sd(clk,reset,instseeds,set_deta_start,deta,set_deta_end);
H_for_Cn hfc(clk,reset,seed_lambda[511:0],aux_triangle,salt,Hcnstart,Cn,hcn_end);
set_seed_lambda sslam(clk,reset,seed_star,salt,j,8'd128,seed_lambda_start,seed_lambda,seed_lambda_end );
endmodule