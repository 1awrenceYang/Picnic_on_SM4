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
    
    
    reg compute_aux_start, computeAux_stop;
    reg mpc_start, mpc_stop;
    reg [7:0] compute_aux_state;
    reg computeAux_read_tapes_strat;
    reg [1:0] computeAux_sbox_index;
    reg [254:0] AuxBits1, AuxBits2;
    wire [1019:0] Lambda_i, Lambda_i_2;
    wire [254:0] computeAux_read_result1, computeAux_read_result2;
    reg [511:0] data_in;
    reg AuxBits_write_en, AuxBits_read_en, AuxBits_rw_Control;
    wire [511:0] AuxBits_test_out;
    wire [6:0] compute_aux_write_address;
    wire [31:0] masked_output1;
    reg [4:0] computeAux_round;
    reg [31:0] masked_input1;
    wire [1019:0] Lambda_i_mpc;
    wire [31:0] ZT_Lambda_i;
    reg [4:0] mpc_round;
    wire [31:0] CKi_wire;
    reg [1:0] computeAux_operating_mode;
    wire computeAux_read_stop;
    wire [511:0] Lambda_output_t;
    reg [31:0] S;
    wire [31:0] S_result;
    reg msgs_rw_Control, msgs_write_en, msgs_read_en;
    reg [5:0] msgs_write_address, msgs_read_address;
    reg [511:0] msgs_data_in;
    wire [511:0] msgs_test_out;
    wire [31:0] round_key_xor_result;
    wire [31:0] round_key_xor_result2;
    wire [31:0] GP1_result, GP2_result, GP3_result;
    wire [31:0] CAB2_input;
    

    reg[9:0] state;

    //tree
    reg tree_start;
    wire tree_set_end; 
    wire [2047:0] seed;
    
    //compute_aux
    wire[127:0] masked_key=0;
    wire[511:0] aux=0;

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
    wire[511:0] msgs=0;
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

    wire [4095:0] aux_triangle = t_in_LC?aux_triangle_i:{4{lambda_masked_key}}^deta;
    wire [511:0] seed_lambda_for_cn_in=t_in_LC?seed_lambda_i:seed_lambda[511:0];
    //Cn
    reg Cn_start;
    wire Cn_end;
    wire [255:0] cn;

    //Cv
    wire[128:0]masked_key_cv_in =t_in_LC?masked_key_i:masked_key;
    wire[511:0]msgs_cv_in=t_in_LC?msgs_i:msgs;
    reg Cv_start;
    wire Cv_end;
    wire [255:0] cv;


    assign Ch=ch;
    assign Cn=cn;
    assign Cv=cv;
    assign CAB2_input=round_key_xor_result2 ^ GP1_result ^GP2_result ^GP3_result;
    
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            round_fun1_end<=0;
            tree_start<=0;
            state<=0;
            com_start<=0;
            ch_start<=0;

            set_seed_lambda_start<=0;
            
            compute_aux_start<=1'b0;
            computeAux_stop<=1'b0;
            mpc_start<=1'b0;
            mpc_stop<=1'b0;
            set_seed_lambda_start<=0;
            compute_aux_state<=8'd0;
            computeAux_read_tapes_strat<=1'b0;
            computeAux_sbox_index<=2'b0;
            AuxBits1<=255'b0;
            AuxBits2<=255'b0;
            data_in<=512'b0;
            AuxBits_write_en<=1'b0;
            AuxBits_read_en<=1'b0;
            AuxBits_rw_Control<=1'b0;
            computeAux_round<=5'b0;
            masked_input1<=32'b0;
            mpc_round<=5'b0;
            computeAux_operating_mode<=2'b0;
            S<=32'b0;
            msgs_rw_Control<=1'b0;
            msgs_read_en<=1'b0;
            msgs_write_en<=1'b0;
            msgs_write_address<=6'b0;
            msgs_read_address<=6'b0;
            msgs_data_in<=512'b0;
            
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
            else if(state==2) 
            begin
                if(t_in_LC==0) 
                begin
                    compute_aux_start<=1'b1;
                    state<=255;
                end
                
                else if(t_in_LC==1) 
                begin
                    state<=3;
                end
            end
            else if(state==255)
            begin
                    if(computeAux_stop)
                        state<=3;
            end        
            
            else if(state==3) 
            begin
                if(t_in_LC==0) 
                begin
                    if(com_end==1) 
                    begin
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


always@(posedge clk)//step 5.3  compute aux control logic
    begin
        if(compute_aux_state==8'd0)
            begin
                if(compute_aux_start)
                    compute_aux_state<=8'd1;
            end
        else if(compute_aux_state==8'd1)
            begin
                computeAux_read_tapes_strat<=1'b1;
                computeAux_sbox_index<=2'b00;
                compute_aux_state<=8'd2;
            end
        else if(compute_aux_state==8'd2)
            begin
                if(computeAux_read_stop)
                    begin
                        computeAux_sbox_index<=2'b01;
                        compute_aux_state<=8'd3;
                        computeAux_read_tapes_strat<=1'b0;
                        AuxBits1<=AuxBits1^computeAux_read_result1;
                        AuxBits2<=AuxBits2^computeAux_read_result2;
                    end
            end
        else if(compute_aux_state==8'd3)
            begin
                computeAux_read_tapes_strat<=1'b1;
                compute_aux_state<=8'd4;
            end
            
        else if(compute_aux_state==8'd4)
            begin
                if(computeAux_read_stop)
                    begin
                        computeAux_sbox_index<=2'b10;
                        compute_aux_state<=8'd5;
                        computeAux_read_tapes_strat<=1'b0;
                        AuxBits1<=AuxBits1^computeAux_read_result1;
                        AuxBits2<=AuxBits2^computeAux_read_result2;
                    end
            end
        else if(compute_aux_state==8'd5)
            begin
                computeAux_read_tapes_strat<=1'b1;
                compute_aux_state<=8'd6;
            end
        else if(compute_aux_state==8'd6)
            begin
                if(computeAux_read_stop)
                    begin
                        computeAux_sbox_index<=2'b11;
                        compute_aux_state<=8'd7;
                        computeAux_read_tapes_strat<=1'b0;
                        AuxBits1<=AuxBits1^computeAux_read_result1;
                        AuxBits2<=AuxBits2^computeAux_read_result2;
                    end
            end
        else if(compute_aux_state==8'd7)
            begin
                computeAux_read_tapes_strat<=1'b1;
                compute_aux_state<=8'd8;
            end
        else if(compute_aux_state==8'd8)
            begin
                if(computeAux_read_stop)
                    begin
                        computeAux_sbox_index<=2'b00;
                        computeAux_read_tapes_strat<=1'b0;
                        compute_aux_state<=8'd9;
                        AuxBits1<=AuxBits1^computeAux_read_result1 ^ Lambda_i;
                        AuxBits2<=AuxBits2^computeAux_read_result2 ^ Lambda_i_2;
                    end
            end
        else if(compute_aux_state==8'd9)//data is read from tapes and xored with Lambda_i, AuxBits are calculated, next step is write it into aux
            begin
                data_in<={AuxBits2, 1'b0, AuxBits1, 1'b0};
                AuxBits_write_en<=1'b1;
                AuxBits_read_en<=1'b0;
                AuxBits_rw_Control<=1'b1;
                AuxBits1<=255'b0;
                AuxBits2<=255'b0;
                compute_aux_state<=8'd10;
            end
        else if(compute_aux_state<=8'd10)
                compute_aux_state<=8'd11;
        else if(compute_aux_state==8'd11)//write AuxBits complete
            begin
                AuxBits_write_en<=1'b0;
                AuxBits_read_en<=1'b1;
                AuxBits_rw_Control<=1'b0;
                compute_aux_state<=8'd12;
            end
        else if(compute_aux_state==8'd12)
            begin
                if(computeAux_round==8'd31)
                    begin
                        computeAux_stop<=1'b1;
                        compute_aux_start<=1'b0;
                        compute_aux_state<=8'd0;
                    end
                else
                    begin
                        computeAux_round<=computeAux_round+1;
                        compute_aux_state<=8'd1;
                    end
            end
        
    end





    Get_RoundKey_xor get_round_key_xor_result(computeAux_round, computeAux_sbox_index, round_key_xor_result);
    Get_RoundKey_xor get_round_key_xor_result2(computeAux_round, 2'b11, round_key_xor_result2);
    
    Get_Plaintext GP1(computeAux_round, GP1_result);
    Get_Plaintext GP2(computeAux_round+1, GP2_result);
    Get_Plaintext GP3(computeAux_round+2, GP3_result);
    
    compute_aux_bits CAB(round_key_xor_result, Lambda_i);
    compute_aux_bits CAB2(CAB2_input, Lambda_i_2);
    
    compute_aux_read_tapes CART(clk, reset, computeAux_round, computeAux_sbox_index, computeAux_read_tapes_strat, computeAux_operating_mode, computeAux_read_result1,  computeAux_read_result2, computeAux_read_stop);
    Get_Write_Address GWA(computeAux_round, compute_aux_write_address);
    get_cki GC(mpc_round, CKi_wire);
    compute_aux_bits mpc_CAB1(masked_input1, Lambda_i_mpc);
    s_box S11(masked_input1[7:0], masked_output1[7:0]);
    s_box S12(masked_input1[15:8], masked_output1[15:8]);
    s_box S13(masked_input1[23:16], masked_output1[23:16]);
    s_box S14(masked_input1[31:24], masked_output1[31:24]);
    
    simulate_part1 sbox1(Lambda_i_mpc[254:0], masked_input1[7:0], ZT_Lambda_i[7:0]);//ZT_Lambda includes Lambda_i on left side and Lambda(i-T) on the right side
    simulate_part1 sbox2(Lambda_i_mpc[509:255], masked_input1[15:8], ZT_Lambda_i[15:8]);
    simulate_part1 sbox3(Lambda_i_mpc[764:150], masked_input1[23:16], ZT_Lambda_i[23:16]);
    simulate_part1 sbox4(Lambda_i_mpc[1019:765], masked_input1[31:24], ZT_Lambda_i[31:24]);
    
    get_lambda_for_all_users mpc_GLFAU(mpc_round, Lambda_output_t);
    
    L_matrix L(S, S_result);

    seed_tree_for_round_fun st(clk,reset,seed_star,salt,j,tree_start,seed,tree_set_end);
    commitment co(clk,reset,seed,aux,salt,t,j,com_start,com_end,C1);
    commitment_without_aux cowa(clk,reset,seed_i,salt,t,j,com_wa_start,com_wa_end,C2);
    H_for_Ch hfch(clk,reset,C,ch_start,ch,ch_end);
    set_seed_lambda ssl(clk,reset,seed_star,salt,j,8'd128,set_seed_lambda_start,seed_lambda,set_seed_lambda_end);
    set_deta sd(clk,reset,instseeds,set_deta_start,deta,set_deta_end);
    H_for_Cn hfcn(clk,reset,seed_lambda_for_cn_in,aux_triangle,salt, Cn_start,cn,Cn_end);
    H_for_Cv hfcv(clk,reset,masked_key_cv_in,msgs_cv_in,Cv_start,cv,Cv_end);
    
    
    
    
        aux_bits compute_aux_bits_result 
(
  .clka(clk),    // input wire clka
  .ena(AuxBits_write_en),      // input wire ena
  .wea(AuxBits_rw_Control),      // input wire [0 : 0] wea
  .addra(compute_aux_write_address),  // input wire [6 : 0] addra
  .dina(data_in),    // input wire [511 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(AuxBits_read_en),      // input wire enb
  .addrb(compute_aux_write_address),  // input wire [6 : 0] addrb
  .doutb(AuxBits_test_out)  // output wire [511 : 0] doutb
);

msgs boardcast_msgs 
(
  .clka(clk),    // input wire clka
  .ena(msgs_write_en),      // input wire ena
  .wea(msgs_rw_Control),      // input wire [0 : 0] wea
  .addra(msgs_write_address),  // input wire [5 : 0] addra
  .dina(msgs_data_in),    // input wire [511 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(msgs_read_en),      // input wire enb
  .addrb(msgs_read_address),  // input wire [5 : 0] addrb
  .doutb(msgs_test_out)  // output wire [511 : 0] doutb
);
endmodule 