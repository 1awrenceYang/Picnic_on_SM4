`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/01 15:00:40
// Design Name: 
// Module Name: sign_on_sm4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sign_on_sm4_res1(
        input clk,
        input rst,
        input signature_start,
        input [51199:0] M,
        input [127:0] pk,
        
        output signature_stop,
        output [21632-1:0] sigma_out
    );
    
    
    

    reg signature_stop_reg;
    reg [4:0] computeAux_round;
    reg [4:0] mpc_round;
    reg [7:0] compute_aux_state;
    reg [7:0] mpc_state;
    reg [7:0] signature_state;
    reg [7:0] instance_round_state;
    reg [7:0] instance_round;
    reg [127:0] root_seed, seed_delta;
    reg [255:0] salt;
    reg step3_start, step4_start, step51_start, compute_aux_start;
    reg step5_stop;
    reg [1023:0] seed_star;
    reg [1023:0] instseeds;
    reg [16*128*8-1:0] seed;
    reg [127:0] seed_tree_input;
    reg instance_iteration_start;
    reg AuxBits_rw_Control, AuxBits_write_en, AuxBits_read_en;
    reg computeAux_stop, mpc_stop;
    reg [1:0] computeAux_sbox_index;
    reg computeAux_read_tapes_strat;
    reg [1:0] computeAux_operating_mode;
    reg [254:0] AuxBits1, AuxBits2;
    reg [511:0] data_in;
    reg Commitment_Start;
    reg Ch_start;
    reg [4095:0] C;
    reg [256*8-1:0] Ch;
    reg mpc_start;
    reg [1151:0] K_hat;
    reg [1151:0] X_hat;
    reg [31:0] masked_input1, masked_input2;
    reg [511:0] s_clothes, s_clothes2;
    reg [31:0] S;
    reg msgs_rw_Control, msgs_write_en, msgs_read_en;
    reg [5:0] msgs_write_address, msgs_read_address;
    reg [31:0] Rki;
    reg [511:0] msgs_data_in;
    reg [255:0] inter_masked_key;
    reg [127:0] msgs_last_128;
    reg [255:0] Lambda_masked_key;
    reg [256*8-1:0] Cv;
    reg Cv_start;
    reg Step58_KDF_start;
    reg [1023:0] Step58_delta;
    reg [1023:0] aux_delta;
    reg [1024*8-1:0] true_aux_delta;
    reg Step511_start;
    reg [16*4*128-1:0] seed_lambda;
    reg Cn_start;
    reg [256*8-1:0] Cn;
    reg merkle_tree_for_cvroot_start;
    reg merkle_tree_for_chroot_start;
    reg [255:0] Cv_root;
    reg [255:0] Ch_root;
    reg [255:0] Csn;
    reg Csn_start;
    reg C_star_start;
    reg [255:0] C_star;
   // reg [127:0] pk;
  //  reg [51199:0] M;
    reg HCP_begin;
    reg [255:0] HCP_result;
    reg [19:0] LP;
    reg [19:0] LC;
    reg get_sign_start;
    
    
    
    wire step3_stop, step4_stop, step51_stop;
    wire [1023:0] seed_star_wire;
    wire [1023:0] instseeds_wire;
    wire [2047:0] seed_wire;
    wire [31:0] round_key_xor_result;
    wire [31:0] round_key_xor_result2;
    wire [1019:0] Lambda_i, Lambda_i_2;
    wire [254:0] computeAux_read_result1, computeAux_read_result2;
    wire [31:0] GP1_result, GP2_result, GP3_result;
    wire computeAux_read_stop;
    wire [31:0] CAB2_input;
    wire [6:0] compute_aux_write_address;
    wire [511:0] AuxBits_test_out;
    wire Commitment_Stop;
    wire Ch_Stop;
    wire [4095:0] C_wire;
    wire [255:0] Ch_wire;
    wire [31:0] CKi_wire;
    wire [1019:0] Lambda_i_mpc;
    wire [31:0] ZT_Lambda_i;
    wire [31:0] masked_output1;
    wire [511:0] Lambda_output_t;
    wire [511:0] msgs_test_out;
    wire [31:0] S_result;
    wire [255:0] Cv_wire;
    wire Cv_stop;
    wire Step58_stop;
    wire [1023:0] Step58_delta_wire;
    wire Step511_stop;
    wire [16*4*128-1:0] seed_lambda_wire;
    wire Cn_stop;
    wire [255:0] Cn_wire;
    wire merkle_tree_for_cvroot_stop;
    wire merkle_tree_for_chroot_stop;
    wire [255:0] Cv_root_wire;
    wire [255:0] Ch_root_wire;
    wire [255:0] Csn_wire;
    wire Csn_stop;
    wire C_star_stop;
    wire [255:0] C_star_wire;
    wire [255:0] HCP_result_wire;
    wire [19:0] LP_wire;
    wire [19:0] LC_wire;
    wire HCP_end;
    wire [127:0] masked_key;
    
    wire [21632-1:0] sigma;
    wire get_sign_stop;

    
    assign signature_stop=signature_stop_reg;
    //assign out_state=signature_state;
    assign masked_key=128'h73446ba9a3e4adf0d28e07f091e47f13;
    assign CAB2_input=round_key_xor_result2 ^ GP1_result ^GP2_result ^GP3_result;
    //assign aux_delta_out=Step58_delta_wire;
    
    //assign HCP_stop_out=HCP_end;
    //assign H_output=HCP_result;
    //assign LC_output=LC;
    //assign LP_output=LP;
    //assign HCP_start_out=HCP_begin;
    
    assign sigma_out=sigma;
    
    seed_tree_for_seed_star Compute_SeedStar(clk, rst, root_seed, salt, 8'b00000001, step3_start, seed_star_wire, step3_stop);
    seed_tree_for_inseeds Compute_inseeds(clk, rst, seed_delta, salt, 8'b00000001, step4_start, instseeds_wire, step4_stop);
    seed_tree_for_round_fun Compute_seeds(clk, rst, seed_tree_input, salt, 8'b00000001, step51_start, seed_wire, step51_stop);
    
    Get_RoundKey_xor get_round_key_xor_result(computeAux_round, computeAux_sbox_index, round_key_xor_result);
    Get_RoundKey_xor get_round_key_xor_result2(computeAux_round, 2'b11, round_key_xor_result2);
    
    Get_Plaintext GP1(computeAux_round, GP1_result);
    Get_Plaintext GP2(computeAux_round+1, GP2_result);
    Get_Plaintext GP3(computeAux_round+2, GP3_result);
    
    compute_aux_bits CAB(round_key_xor_result, Lambda_i);
    compute_aux_bits CAB2(CAB2_input, Lambda_i_2);
    compute_aux_read_tapes CART(clk, rst, computeAux_round, computeAux_sbox_index, computeAux_read_tapes_strat, computeAux_operating_mode, computeAux_read_result1,  computeAux_read_result2, computeAux_read_stop);
    
    Get_Write_Address GWA(computeAux_round, compute_aux_write_address);
    
    commitment Caltulate_C(clk, rst, seed, data_in, salt, 8'd1, instance_round, Commitment_Start, Commitment_Stop, C_wire);
    
    H_for_Ch Calculate_Ch(clk, rst, C, Ch_start, Ch_wire, Ch_Stop);
    
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
    
    H_for_Cv HFC(clk, rst, masked_key, msgs_test_out, Cv_start, Cv_wire, Cv_stop);
    set_deta SD(clk, rst, instseeds[instance_round*128+:128], Step58_KDF_start, Step58_delta_wire, Step58_stop);
    set_seed_lambda SSL(clk, rst, seed_star[instance_round*128+:128], salt, instance_round, 8'd128, Step511_start, seed_lambda_wire, Step511_stop);
    H_for_Cn HFCN(clk, rst, seed_lambda[511:0], aux_delta, salt, Cn_start, Cn_wire, Cn_stop);
    
    merkle_tree_for_cvroot Calculate_Cv_root(clk, rst, Cv, salt, merkle_tree_for_cvroot_start, Cv_root_wire, merkle_tree_for_cvroot_stop);
    merkle_tree_for_chroot Calculate_Ch_root(clk, rst, Ch, salt, merkle_tree_for_chroot_start, Ch_root_wire, merkle_tree_for_chroot_stop);
    H_for_Csn Calculate_Csn(clk, rst, seed_delta, Cn, Csn_start, Csn_wire, Csn_stop);
    H_for_C_star Calculate_C_star(clk, rst, Ch_root, Cv_root, Csn, C_star_start, C_star_wire, C_star_stop);
    HCP Calculate_HCP_step(clk, rst, C_star, salt, pk, M, HCP_begin, HCP_end, HCP_result_wire, LC_wire, LP_wire); 
    
get_sign OutputSign
(
    clk, 
    rst, 
    get_sign_start, 
    LC, 
    LP, 
    HCP_result, 
    salt, 
    seed_star, 
    Cv, 
    seed,
    {3584'b0, AuxBits_test_out},
    {masked_key, masked_key, masked_key, masked_key, masked_key, masked_key, masked_key, masked_key},
    {3584'b0, msgs_test_out},
    {1792'b0, C[255:0]},
    seed_lambda[4095:0],
    true_aux_delta,
    seed_delta,
    sigma,
    get_sign_stop
);
always@(posedge clk or negedge rst)//main control logic
    begin
        if(!rst)
            begin
                true_aux_delta<=8192'b0;
                get_sign_start<=1'b0;
           //     M<=51200'b0;
           //     pk<=128'h681edf34d206965e86b3e94f536e4246;
                HCP_result<=256'b0;
                LP<=20'b0;
                LC<=20'b0;
                HCP_begin<=1'b0;
                Csn<=256'b0;
                Csn_start<=1'b1;
                merkle_tree_for_chroot_start<=1'b0;
                Cv_root<=256'b0;
                merkle_tree_for_cvroot_start<=1'b0;
                Step58_delta<=1024'B0;
                Cn<=2048'b0;
                Cn_start<=1'b0;
                aux_delta<=1024'b0;
                seed_lambda<=8192'b0;
                Step511_start<=1'b1;
                Step58_KDF_start<=1'b0;
                Cv<=2048'b0;
                Cv_start<=1'b0;
                Lambda_masked_key<=256'b0;
                msgs_last_128<=128'h7f1f3d434e86e8395cf2dff02de1ebc7;
                inter_masked_key<=256'b0;
                msgs_data_in<=512'b0;
                s_clothes2<=512'b0;
                Rki<=32'b0;
                S<=32'b0;
                msgs_rw_Control<=1'b0;
                msgs_read_en<=1'b0;
                msgs_write_en<=1'b0;
                msgs_write_address<=6'b0;
                msgs_read_address<=6'b0;
                s_clothes<=512'b0;
                masked_input1<=32'b0;
                masked_input2<=32'b0;
                mpc_round<=5'd0;
                K_hat<={1024'b0, 128'hd0f5d16ff54e9ea0b5f3966723945dcf};
                X_hat<=1152'b0;
                Ch<=2048'b0;
                Ch_start<=1'b0;
                computeAux_round<=5'b0;
                signature_state<=8'b0;
                compute_aux_state<=8'b0;
                signature_stop_reg<=1'b0;
                step3_start<=1'b0;
                step4_start<=1'b0;
                seed_star<=1024'b0;
                instseeds<=1024'b0;
                seed<=16384'b0;
                seed_tree_input<=128'b0;
                step51_start<=1'b0;
                instance_round_state<=8'b0;
                instance_iteration_start<=1'b0;
                compute_aux_start<=1'b0;
                AuxBits_rw_Control<=1'b0;
                AuxBits_write_en<=1'b0;
                AuxBits_read_en<=1'b0;
                computeAux_stop<=1'b0;
                computeAux_sbox_index<=2'b00;
                computeAux_read_tapes_strat<=1'b0;
                computeAux_operating_mode<=2'b00;
                AuxBits1<=255'b0;
                AuxBits2<=255'b0;
                data_in<=512'b0;
                AuxBits_rw_Control<=1'b0;
                AuxBits_read_en<=1'b0;
                AuxBits_write_en<=1'b0;
                instance_round<=8'b0;
                Commitment_Start<=1'b0;
                C<=4096'b0;
                mpc_start<=1'b0;
                mpc_stop<=1'b0;
                mpc_state<=8'b0;
                step5_stop<=1'b0;
                Step58_KDF_start<=1'b0;
                Ch_root<=256'b0;
            end
        else
            begin
                if(signature_state==8'b00000000 )//initialize a few parameters
                    begin
                        root_seed<=128'hf3ca11270ae60ba88ddb71c583a8f1fa;
                        seed_delta<=128'hcb8984fa9cb6ec32b902e03964adf99f;
                        salt<={128'h0, 128'he4ae4aa5804c971a0285fea80bdbe4d4};
                        if(signature_start)
                            begin
                                signature_state<=8'b00000010;
                                signature_stop_reg<=1'b0;
                            end
                    end
                    //next state is using KDF to generate tapes
                    
                else if(signature_state==8'b00000010)//KDF complete, start generate seed*[t][M]
                    begin
                        step3_start<=1'b1;
                        signature_state<=8'b00000011;
                    end
                else if(signature_state==8'b00000011)
                    begin
                        if(step3_stop)//generate seed* [t][M] complete
                            begin
                                step3_start<=1'b0;
                                seed_star<=seed_star_wire;
                                signature_state<=8'b00000100;
                            end
                    end
                    
                else if(signature_state==8'b00000100)//start generate instseeds[t+1][M]
                    begin
                       step4_start<=1'b1;
                       signature_state<=8'b00000101;
                    end
                    
                else if(signature_state==8'b00000101)
                    begin
                        if(step4_stop)//generate instseeds[t+1][M] complete
                            begin
                                step4_start<=1'b0;
                                instseeds<=instseeds_wire;
                                signature_state<=8'b00000110;
                            end
                    end
                    
                else if(signature_state==8'b00000110)//enter step5
                    begin
                        instance_iteration_start<=1'b1;
                        signature_state<=8'b00000111;
                    end
                else if(signature_state==8'b00000111)
                    begin
                        if(step5_stop)
                            signature_state<=8'd8;
                    end
                else if(signature_state==8'd8)
                    begin
                        merkle_tree_for_cvroot_start<=1'b1;
                        signature_state<=8'd9;
                    end
                else if(signature_state==8'd9)
                    begin
                        if(merkle_tree_for_cvroot_stop)
                            begin
                                merkle_tree_for_cvroot_start<=1'b0;
                                signature_state<=8'd10;
                                Cv_root<=Cv_root_wire;
                            end
                    end
                else if(signature_state==8'd10)
                    begin
                        merkle_tree_for_chroot_start<=1'b1;
                        signature_state<=8'd11;
                    end
                else if(signature_state==8'd11)
                    begin
                        if(merkle_tree_for_chroot_stop)
                            begin
                                merkle_tree_for_chroot_start<=1'b0;
                                signature_state<=8'd12;           
                                Ch_root<=Ch_root_wire;
                            end
                    end
                else if(signature_state==8'd12)
                    begin
                        Csn_start<=1'b1;
                        signature_state<=8'd13;
                    end
                else if(signature_state==8'd13)
                    begin
                        if(Csn_stop)
                            begin
                                Csn_start<=1'b0;
                                signature_state<=8'd14;
                                Csn<=Csn_wire;
                            end
                    end
                else if(signature_state==8'd14)
                    begin
                        C_star_start<=1'b1;
                        signature_state<=8'd15;
                    end
                else if(signature_state==8'd15)
                    begin
                        if(C_star_stop)
                            begin
                                C_star<=C_star_wire;
                                signature_state<=8'd16;
                                C_star_start<=1'b0;
                            end
                    end
                    
                else if(signature_state==8'd16)
                    begin
                        HCP_begin<=1'b1;
                        signature_state<=8'd17;
                    end
                else if(signature_state==8'd17)
                    begin
                        if(HCP_end)
                            begin
                                HCP_result<=HCP_result_wire;
                                LP<=LP_wire;
                                LC<=LC_wire;
                                HCP_begin<=1'b0;
                                signature_state<=8'd18;
                            end
                    end
                else if(signature_state==8'd18)
                    begin
                        get_sign_start<=1'b1;
                        signature_state<=8'd19;
                    end
                else if(signature_state==8'd19)
                    begin
                        if(get_sign_stop)
                            begin
                                signature_state<=8'd20;
                                get_sign_start<=1'b0;
                                signature_stop_reg<=1'b1;
                            end
                    end
                else if(signature_state==8'd20)
                    begin
                        signature_state<=8'd0;
                    end
            end
    end
    
    
    
    
    
    
always@(posedge clk)//step5 control logic
    begin
        if(instance_round_state<=8'd0)
            begin
                if(instance_iteration_start)
                    instance_round_state<=8'd1;
            end
        else if(instance_round_state==8'd1)
            begin
                step51_start<=1'b1;
                seed_tree_input<=seed_star[(instance_round)*128+:128];
                instance_round_state<=8'd2;
            end
        else if(instance_round_state ==8'd2)
            begin
                if(step51_stop)//seed tree generate complete
                    begin
                        step51_start<=1'b0;
                        instance_round_state<=8'd3;
                        seed[(instance_round)*2048+:2048]<=seed_wire;
                    end
            end
            
        else if(instance_round_state==8'd3)//KDF1 start
            begin
                instance_round_state<=8'd4;
            end
            
        else if(instance_round_state==8'd4)//KDF1 complete
            begin
                instance_round_state<=8'd5;
            end
            
        else if(instance_round_state==8'd5)//KDF2 start
            begin
                instance_round_state<=8'd6;
            end
            
        else if(instance_round_state==8'd6)//KDF2 complete
            begin
                instance_round_state<=8'd7;
            end
            
        else if(instance_round_state==8'd7)//KDF2 complete
            begin
                instance_round_state<=8'd8;
            end
            
        else if(instance_round_state==8'd8)//compute_aux start
            begin
                compute_aux_start<=1'b1;
                instance_round_state<=8'd9;
            end
            
        else if(instance_round_state==8'd9)
            begin
                if(computeAux_stop)
                    instance_round_state<=8'd10;
            end
            
        else if(instance_round_state==8'd10)
            begin
                Commitment_Start<=1'b1;
                instance_round_state<=8'd11;
                computeAux_stop<=1'b0;
            end
        else if(instance_round_state==8'd11)
            begin
                if(Commitment_Stop)
                    begin
                        Commitment_Start<=1'b0;
                        C<=C_wire;
                        instance_round_state<=8'd12;
                    end
            end
        else if(instance_round_state==8'd12)
            begin
                Ch_start<=1'b1;
                instance_round_state<=8'd13;
            end
        else if(instance_round_state==8'd13)
            begin
                if(Ch_Stop)
                    begin
                        Ch_start<=1'b0;
                        Ch[(instance_round)*256+:256]<=Ch_wire;
                        instance_round_state<=8'd14;
                    end
            end
        else if(instance_round_state==8'd14)
            begin
                mpc_start<=1'b1;
                instance_round_state<=8'd15;
            end
        else if(instance_round_state==8'd15)
            begin
                if(mpc_stop)
                    instance_round_state<=8'd16;
            end
        else if(instance_round_state==8'd16)
            begin
                mpc_stop<=1'b0;
                Cv_start<=1'b1;
                instance_round_state<=8'd17;
            end
        else if(instance_round_state==8'd17)
            begin
                if(Cv_stop)
                    begin
                        Cv[(instance_round)*256+:256]<=Cv_wire;
                        Cv_start<=1'b0;
                        instance_round_state<=8'd18;
                    end
            end
        else if(instance_round_state==8'd18)
            begin
                Step58_KDF_start<=1'b1;
                instance_round_state<=8'd19;
            end
        else if(instance_round_state==8'd19)
            begin
                if(Step58_stop)
                    begin
                        Step58_KDF_start<=1'b0;
                        Step58_delta<=Step58_delta_wire;
                        instance_round_state<=8'd20;
                        aux_delta[255:0]<=Step58_delta_wire[255:0] ^ Lambda_masked_key;
                        aux_delta[511:256]<=Step58_delta_wire[511:256] ^ Lambda_masked_key;
                        aux_delta[767:512]<=Step58_delta_wire[767:512] ^ Lambda_masked_key;
                        aux_delta[1023:768]<=Step58_delta_wire[1023:768] ^ Lambda_masked_key;
                    end
            end
            
        else if(instance_round_state==8'd20)
            begin
                true_aux_delta[(instance_round)*1024+:1024]<=aux_delta;
                Step511_start<=1'b1;
                instance_round_state<=8'd21;
            end
        else if(instance_round_state<=8'd21)
            begin
                if(Step511_stop)
                    begin
                        seed_lambda<=seed_lambda_wire;
                        Step511_start<=1'b0;
                        instance_round_state<=8'd22;
                    end
            end
        else if(instance_round_state<=8'd22)
            begin
                Cn_start<=1'b1;
                instance_round_state<=8'd23;
            end
        else if(instance_round_state<=8'd24)
            begin
                if(Cn_stop)
                    begin
                        Cn[(instance_round)*256+:256]<=Cn_wire;
                        Cn_start<=1'b0;
                        instance_round_state<=8'd25;
                    end
            end
        else if(instance_round_state==8'd25)
            begin
                if(instance_round==8'd7)
                    begin
                        step5_stop<=1'b1;
                        instance_iteration_start<=1'b0;
                        instance_round_state<=8'd0;
                    end
                else
                    begin
                        instance_round<=instance_round+1;
                        instance_round_state<=8'd1;
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
    
always@(posedge clk)//mpc_simulate control logic
begin
    if(mpc_state==8'd0)
        begin
            if(mpc_start)
                mpc_state<=8'd1;
        end
    else if(mpc_state==8'd1)//calculating [s], [s] has 32bits, 8bits for each sbox , 4 sboxs
        begin
            masked_input1<=K_hat[(mpc_round+1)*32 +:32] ^ K_hat[(mpc_round+2)*32 +:32] ^ K_hat[(mpc_round+3)*32 +:32] ^ CKi_wire;
            mpc_state<=8'd254;
            
        end
    else if(mpc_state==8'd254)
        begin
            s_clothes[31:0]<=ZT_Lambda_i ^ Lambda_output_t[31:0] ;//^ Lambda_output_t[63:32] ^ Lambda_output_t[95:64] ^ Lambda_output_t[127:96] ^ Lambda_output_t[159:128] ^ Lambda_output_t[191:160] ^ Lambda_output_t[223:192] ^ Lambda_output_t[255:224] ^ Lambda_output_t[287:256] ^ Lambda_output_t[319:288] ^ Lambda_output_t[351:320] ^ Lambda_output_t[383:352] ^ Lambda_output_t[415:384] ^ Lambda_output_t[447:416] ^ Lambda_output_t[479:448] ^ Lambda_output_t[511:480];
            s_clothes[63:32]<=ZT_Lambda_i ^ Lambda_output_t[63:32] ;
            s_clothes[95:64]<=ZT_Lambda_i ^ Lambda_output_t[95:64] ;
            s_clothes[127:96]<=ZT_Lambda_i ^ Lambda_output_t[127:96] ;
            s_clothes[159:128]<=ZT_Lambda_i ^ Lambda_output_t[159:128] ;
            s_clothes[191:160]<=ZT_Lambda_i ^ Lambda_output_t[191:160] ;
            s_clothes[223:192]<=ZT_Lambda_i ^ Lambda_output_t[223:192] ;
            s_clothes[255:224]<=ZT_Lambda_i ^ Lambda_output_t[255:224] ;
            s_clothes[287:256]<=ZT_Lambda_i ^ Lambda_output_t[287:256] ;
            s_clothes[319:288]<=ZT_Lambda_i ^ Lambda_output_t[319:288] ;
            s_clothes[351:320]<=ZT_Lambda_i ^ Lambda_output_t[351:320] ;
            s_clothes[383:352]<=ZT_Lambda_i ^ Lambda_output_t[383:352] ;
            s_clothes[415:384]<=ZT_Lambda_i ^ Lambda_output_t[415:384] ;
            s_clothes[447:416]<=ZT_Lambda_i ^ Lambda_output_t[447:416] ;
            s_clothes[479:448]<=ZT_Lambda_i ^ Lambda_output_t[479:448] ;
            s_clothes[511:480]<=ZT_Lambda_i ^ Lambda_output_t[511:480] ;
            mpc_state<=8'd3;
        end    
    
    else if(mpc_state==8'd2)//start writing into msgs
        begin
            msgs_rw_Control<=1'b1;
            msgs_write_en<=1'b1;
            //msgs_read_en<=1'b1;
            mpc_state<=8'd3;
        end
    else if(mpc_state==8'd3)//write complete
        begin
            mpc_state<=8'd4;
            //this S is the true masked_output
            S<=masked_output1 ^ s_clothes[31:0] ^ s_clothes[63:32] ^ s_clothes[95:64] ^ s_clothes[127:96] ^ s_clothes[159:128] ^ s_clothes[191:160] ^ s_clothes[223:192] ^ s_clothes[255:224] ^ s_clothes[287:256] ^ s_clothes[319:288] ^ s_clothes[351:320] ^ s_clothes[383:352] ^ s_clothes[415:384] ^ s_clothes[447:416] ^ s_clothes[479:448] ^ s_clothes[511:480];
            //masked_output1 ^ Lambda_output_t[31:0] ^ Lambda_output_t[63:32] ^ Lambda_output_t[95:64] ^ Lambda_output_t[127:96] ^ Lambda_output_t[159:128] ^ Lambda_output_t[191:160] ^ Lambda_output_t[223:192] ^ Lambda_output_t[255:224] ^ Lambda_output_t[287:256] ^ Lambda_output_t[319:288] ^ Lambda_output_t[351:320] ^ Lambda_output_t[383:352] ^ Lambda_output_t[415:384] ^ Lambda_output_t[447:416] ^ Lambda_output_t[479:448] ^ Lambda_output_t[511:480];
        end
    else if(mpc_state==8'd4)
        begin
            msgs_write_en<=1'b0;
            K_hat[(mpc_round+4)*32+:32]<=S_result ^ K_hat[(mpc_round)*32 +:32];
            Rki<=S_result^ K_hat[(mpc_round)*32 +:32];
            mpc_state<=8'd5;
        end
    else if(mpc_state==8'd5)
        begin
            masked_input1<=X_hat[(mpc_round+1)*32 +:32] ^ X_hat[(mpc_round+2)*32 +:32] ^ X_hat[(mpc_round+3)*32 +:32] ^ Rki;
            mpc_state<=8'd6;
        end
    else if(mpc_state==8'd6)
        begin
            s_clothes2[31:0]<=ZT_Lambda_i ^ Lambda_output_t[31:0] ;//^ Lambda_output_t[63:32] ^ Lambda_output_t[95:64] ^ Lambda_output_t[127:96] ^ Lambda_output_t[159:128] ^ Lambda_output_t[191:160] ^ Lambda_output_t[223:192] ^ Lambda_output_t[255:224] ^ Lambda_output_t[287:256] ^ Lambda_output_t[319:288] ^ Lambda_output_t[351:320] ^ Lambda_output_t[383:352] ^ Lambda_output_t[415:384] ^ Lambda_output_t[447:416] ^ Lambda_output_t[479:448] ^ Lambda_output_t[511:480];
            s_clothes2[63:32]<=ZT_Lambda_i ^ Lambda_output_t[63:32] ;
            s_clothes2[95:64]<=ZT_Lambda_i ^ Lambda_output_t[95:64] ;
            s_clothes2[127:96]<=ZT_Lambda_i ^ Lambda_output_t[127:96] ;
            s_clothes2[159:128]<=ZT_Lambda_i ^ Lambda_output_t[159:128] ;
            s_clothes2[191:160]<=ZT_Lambda_i ^ Lambda_output_t[191:160] ;
            s_clothes2[223:192]<=ZT_Lambda_i ^ Lambda_output_t[223:192] ;
            s_clothes2[255:224]<=ZT_Lambda_i ^ Lambda_output_t[255:224] ;
            s_clothes2[287:256]<=ZT_Lambda_i ^ Lambda_output_t[287:256] ;
            s_clothes2[319:288]<=ZT_Lambda_i ^ Lambda_output_t[319:288] ;
            s_clothes2[351:320]<=ZT_Lambda_i ^ Lambda_output_t[351:320] ;
            s_clothes2[383:352]<=ZT_Lambda_i ^ Lambda_output_t[383:352] ;
            s_clothes2[415:384]<=ZT_Lambda_i ^ Lambda_output_t[415:384] ;
            s_clothes2[447:416]<=ZT_Lambda_i ^ Lambda_output_t[447:416] ;
            s_clothes2[479:448]<=ZT_Lambda_i ^ Lambda_output_t[479:448] ;
            s_clothes2[511:480]<=ZT_Lambda_i ^ Lambda_output_t[511:480] ;
            mpc_state<=8'd7;
        end
    else if(mpc_state==8'd7)//write first [s]
        begin
            msgs_rw_Control<=1'b1;
            msgs_write_en<=1'b1;
            msgs_data_in<=s_clothes;
            msgs_write_address<=mpc_round;
            mpc_state<=8'd8;
        end
    else if(mpc_state==8'd8)
            mpc_state<=8'd9;
    else if(mpc_state==8'd9)//write second [s]
        begin
            msgs_data_in<=s_clothes2;
            msgs_write_address<=mpc_round+32;
            mpc_state<=8'd10;
        end
    else if(mpc_state==8'd10)
        begin
            msgs_read_en<=1'b1;
            mpc_state<=8'd11;
        end
     else if(mpc_state==8'd11)//write_complete
        begin
            msgs_rw_Control<=1'b0;
            msgs_write_en<=1'b0;
            mpc_state<=8'd12;
            S<=masked_output1 ^ s_clothes2[31:0] ^ s_clothes2[63:32] ^ s_clothes2[95:64] ^ s_clothes2[127:96] ^ s_clothes2[159:128] ^ s_clothes2[191:160] ^ s_clothes2[223:192] ^ s_clothes2[255:224] ^ s_clothes2[287:256] ^ s_clothes2[319:288] ^ s_clothes2[351:320] ^ s_clothes2[383:352] ^ s_clothes2[415:384] ^ s_clothes2[447:416] ^ s_clothes2[479:448] ^ s_clothes2[511:480];
        end
    else if(mpc_state==8'd12)
        begin
            X_hat[(mpc_round+4)*32+:32]<=S_result ^ X_hat[(mpc_round)*32 +:32];
            mpc_state<=8'd13;
        end
    else if(mpc_state==8'd13)
        begin
            if(mpc_round==5'd28)
                begin
                    inter_masked_key[31:0]<=S_result;
                    mpc_state<=8'd1;
                    mpc_round<=mpc_round+1;
                end
            else if(mpc_round==5'd29)
                begin
                    inter_masked_key[63:32]<=S_result;
                    mpc_state<=8'd1;
                    mpc_round<=mpc_round+1;
                end
            else if(mpc_round==5'd30)
                begin
                    inter_masked_key[95:64]<=S_result;
                    mpc_state<=8'd1;
                    mpc_round<=mpc_round+1;
                end 
            else if(mpc_round==5'd31)
                begin
                    inter_masked_key[127:96]<=S_result;
                    mpc_state<=8'd14;
                end
            else
                mpc_round<=mpc_round+1;
        end
    else if(mpc_state==8'd14)
        begin
            inter_masked_key[255:128]<=msgs_last_128;
            Lambda_masked_key<={msgs_last_128, 128'h5e10e0396f3c3be468cc5e6b1164d311};
            mpc_stop<=1'b1;
            mpc_start<=1'b0;
            mpc_state<=8'd0;
        end
end

aux_bits aux 
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
