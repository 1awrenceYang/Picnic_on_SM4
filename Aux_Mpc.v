module tapes_operation(
    input clk,
    input rst,
    input start_of_kdf,
    input [127:0] seed,
    input [255:0] salt,
    input [7:0] t,
    input [7:0] i,
    input [4:0] round,
    input [1:0] k,
    input read_start,
    input [1:0] operating_mode,//from 00-11 for compute_aux_sign_first_right, compute_aux_sign_first_left, 
    output [254:0] xor_result,
    output [254:0] xor_result2,
    output reg read_stop,
    output reg write_stop
    );
//Write
wire tapes_write_en;
wire [527:0] tapes_data_in;
wire kdf_stop;
wire [10:0] tapes_write_address;

reg kdf_start;
reg RW_control;
reg [7:0] WriteControlState;

//Read
reg [254:0] tape0_result;
reg [254:0] tape1_result;
reg [3:0] counter;
reg [3:0] ReadState;
reg Read_en;
reg [10:0] Read_Address;

wire [527:0] tapes_xor_result;
wire [10:0] ReadAddress_wire;


assign xor_result=tape0_result;
assign xor_result2=tape1_result;

kdf_for_tapes generate_tapes
(
    .clk(clk),
    .reset(rst),
    .kdf_start(kdf_start),
    .seed(seed),
    .salt(salt),
    .t(t),
    .i(i),
    .wea(tapes_write_en),
    .address(tapes_write_address),
    .data_for_ram(tapes_data_in),
    .kdf_end(kdf_stop)
);
    
test_tape random_tapes
(
    clk,
    RW_control,
    tapes_write_en,
    tapes_write_address,
    tapes_data_in,
    clk,
    Read_en,
    Read_Address,
    tapes_xor_result
);

always@(posedge clk or negedge rst)//write
begin
    if(!rst)
        begin
            WriteControlState<=0;
            kdf_start<=0;
            RW_control<=1;
            write_stop<=0;
        end
    else
        begin
            
            if(WriteControlState==0)
                begin
                    
                    if(start_of_kdf==0)
                    begin
            WriteControlState<=0;
            kdf_start<=0;
            RW_control<=1;
            write_stop<=0;
                    end
                        
                    else if(start_of_kdf && write_stop==0)
                        begin
                            kdf_start<=1;
                            WriteControlState<=1;
                        end
                end
                
            else if(WriteControlState==1)
                begin
                    kdf_start<=1'b1;
                    WriteControlState<=2;
                end
                
            else if(WriteControlState==2)
                begin
                    if(kdf_stop)
                        begin
                            WriteControlState<=0;
                            kdf_start<=0;
                            write_stop<=1;
                        end
                end
                
        end
end

Get_Read_Address GRA1(round, k, ReadAddress_wire);

always@(posedge clk or negedge rst)//Read
begin
    if(!rst)
        begin
            tape0_result<=255'b0;
            tape1_result<=255'b0;
            counter<=4'b0;
            ReadState<=4'b0;
            Read_en<=0;
            Read_Address<=0;
            read_stop<=0;
        end
        
    else
        begin
            if(operating_mode==2'd0)
                begin
                    if(ReadState==4'd0)
                            begin
                                if(~read_start)
                                begin
                                    tape0_result<=255'b0;
            tape1_result<=255'b0;
            counter<=4'b0;
            ReadState<=4'b0;
            Read_en<=0;
            Read_Address<=0;
            read_stop<=0;
                                end
                                else if(read_start &&read_stop==0)
                                    begin
                                        Read_Address<=ReadAddress_wire;
                                        Read_en<=1'b1;
                                        ReadState=4'd1;
                                    end
                            end
                            
                        else if(ReadState==4'd1)
                            begin
                                if(counter==4'd15)
                                    begin
                                        tape0_result<=tape0_result^tapes_xor_result[255:1];
                                        tape1_result<=tape1_result^tapes_xor_result[511:257];
                                        ReadState<=4'd2;
                                        
                                    end
                                else
                                    begin
                                        tape0_result<=tape0_result^tapes_xor_result[255:1];
                                        tape1_result<=tape1_result^tapes_xor_result[511:257];
                                        counter<=counter+1;
                                        Read_Address<=Read_Address+128;
                                    end
                            end
                            
                        else if(ReadState==4'd2)
                            begin
                                ReadState<=4'd3;
                                read_stop<=1'b1;
                                Read_en<=1'b0;
                            end
                            
                        else if(ReadState==4'd3)
                            begin
                                ReadState<=4'd0;
                                Read_en<=1'b1;
                            end
                end
                
                
                
            else if(operating_mode==2'b1)
                begin
                    if(ReadState==4'd0)
                            begin
                                if(~read_start)
                                begin
                                    read_stop<=1'b0;
                                    tape0_result<=255'b0;
                                    tape1_result<=255'b0;
                                    counter<=0;
                                end if(read_start)
                                    begin
                                        Read_Address<=ReadAddress_wire;
                                        Read_en<=1'b1;
                                        ReadState=4'd1;
                                    end
                            end
                            
                        else if(ReadState==4'd1)
                            begin
                                if(counter==4'd15)
                                    begin
                                        tape0_result<=tape0_result^tapes_xor_result[511:257];
                                        ReadState<=4'd2;
                                    end
                                else
                                    begin
                                        tape0_result<=tape0_result^tapes_xor_result[511:257];
                                        counter<=counter+1;
                                        Read_Address<=Read_Address+128;
                                    end
                            end
                            
                        else if(ReadState==4'd2)
                            begin
                                ReadState<=4'd3;
                                read_stop<=1'b1;
                                Read_en<=1'b0;
                            end
                            
                        else if(ReadState==4'd3)
                            begin
                                ReadState<=4'd0;
                                read_stop<=1'b1;
                            end
                end
        end
end
    
endmodule
















module AUX_and_MPC(
    input clk,
    input rst,
    input start,
    input [127:0] seed,
    input [255:0] salt,
    input [7:0] t,
    input [7:0] i,
    output reg stop,
    output reg [511:0] aux_bits_out,
    output reg [255:0] lambda_masked_key_out,
    output reg [255:0] inter_masked_key_out,
    output reg [511:0] msgs_out
    );
    
reg [7:0] MainControlState, compute_aux_state, mpc_state;
reg kdf_start, computeAux_read_tapes_strat;
reg [4:0] round;
reg [1:0] computeAux_sbox_index;
reg compute_aux_start, computeAux_stop;
reg mpc_start, mpc_stop;
reg [1:0] operating_mode;
reg [254:0] AuxBits1, AuxBits2;
reg [4:0] computeAux_round;
reg AuxBits_rw_Control, AuxBits_write_en, AuxBits_read_en;
reg [511:0] data_in;
reg [254:0] aux_bits_write_temp1, aux_bits_write_temp2;
reg [6:0] compute_aux_write_address_reg;
reg [1151:0] K_hat;
reg [4:0] mpc_round;
reg [31:0] masked_input1, masked_input2;
reg [511:0] s_clothes, s_clothes2;
reg [31:0] masked_input1, masked_input2;
reg msgs_rw_Control, msgs_write_en, msgs_read_en;
reg [5:0] msgs_write_address, msgs_read_address;
reg [511:0] msgs_data_in;
reg [31:0] S;
reg [31:0] Rki;
reg [1151:0] X_hat;
reg [255:0] inter_masked_key;
reg [255:0] Lambda_masked_key;
reg [127:0] msgs_last_128;

wire kdf_stop, computeAux_read_stop;
wire [254:0] computeAux_read_result1, computeAux_read_result2;
wire [1019:0] Lambda_i, Lambda_i_2;
wire [31:0] round_key_xor_result;
wire [31:0] round_key_xor_result2;
wire [31:0] CAB2_input;
wire [31:0] GP1_result, GP2_result, GP3_result;
wire [6:0] compute_aux_write_address;
wire [511:0] AuxBits_test_out;
wire [31:0] CKi_wire;
wire [31:0] ZT_Lambda_i;
wire [511:0] Lambda_output_t;
wire [31:0] masked_output1;
wire [1019:0] Lambda_i_mpc;
wire [511:0] msgs_test_out;

assign CAB2_input=round_key_xor_result2 ^ GP1_result ^GP2_result ^GP3_result;


Get_RoundKey_xor get_round_key_xor_result(computeAux_round, computeAux_sbox_index, round_key_xor_result);
Get_RoundKey_xor get_round_key_xor_result2(computeAux_round, 2'b11, round_key_xor_result2);

Get_Plaintext GP1(computeAux_round, GP1_result);
Get_Plaintext GP2(computeAux_round+1, GP2_result);
Get_Plaintext GP3(computeAux_round+2, GP3_result);

compute_aux_bits CAB(round_key_xor_result, Lambda_i);
compute_aux_bits CAB2(CAB2_input, Lambda_i_2);


tapes_operation TO
(
    .clk(clk),
    .rst(rst),
    .start_of_kdf(kdf_start),
    .seed(seed),
    .salt(salt),
    .t(t),
    .i(i),
    .round(round),
    .k(computeAux_sbox_index),
    .read_start(computeAux_read_tapes_strat),
    .operating_mode(operating_mode),
    .xor_result(computeAux_read_result1),
    .xor_result2(computeAux_read_result2),
    .read_stop(computeAux_read_stop),
    .write_stop(kdf_stop)
);

Get_Write_Address GWA(computeAux_round, compute_aux_write_address);

get_cki GC(mpc_round, CKi_wire);
compute_aux_bits mpc_CAB1(masked_input1, Lambda_i_mpc);
s_box S11(masked_input1[7:0], masked_output1[7:0]);
s_box S12(masked_input1[15:8], masked_output1[15:8]);
s_box S13(masked_input1[23:16], masked_output1[23:16]);
s_box S14(masked_input1[31:24], masked_output1[31:24]);
    
assign ZT_Lambda_i=0;
//simulate_part1 sbox1(Lambda_i_mpc[254:0], masked_input1[7:0], ZT_Lambda_i[7:0]);//ZT_Lambda includes Lambda_i on left side and Lambda(i-T) on the right side
//simulate_part1 sbox2(Lambda_i_mpc[509:255], masked_input1[15:8], ZT_Lambda_i[15:8]);
//simulate_part1 sbox3(Lambda_i_mpc[764:150], masked_input1[23:16], ZT_Lambda_i[23:16]);
//simulate_part1 sbox4(Lambda_i_mpc[1019:765], masked_input1[31:24], ZT_Lambda_i[31:24]);
    
get_lambda_for_all_users mpc_GLFAU(mpc_round, Lambda_output_t);
    
L_matrix L(S, S_result);
    
always@(posedge clk or negedge rst)
begin
    if(!rst)
        begin
          //  compute_aux_write_address_reg<=0; 2
            kdf_start<=0;
            round<=0; 
          //  computeAux_sbox_index<=0; 2
          //  computeAux_read_tapes_strat<=0; 2
            operating_mode<=0;
            MainControlState<=0;
            stop<=0;
            compute_aux_start<=0;
         //   computeAux_stop<=0 ; 2
          //   compute_aux_state<=0; 2
         //   AuxBits1<=0;2
         //   AuxBits2<=0;2
          //  computeAux_round<=0;2
         //   AuxBits_rw_Control<=1'b0;2
         //   AuxBits_write_en<=1'b0;2
         //   AuxBits_read_en<=1'b0;2
        //    data_in<=0;
        //    aux_bits_write_temp1<=0;2
       //     aux_bits_write_temp2<=0;2
        //    aux_bits_out<=0;2
         //   mpc_state<=0;
            mpc_start<=0;
         //   mpc_stop<=0;
         //   K_hat<={1024'b0, 128'hd0f5d16ff54e9ea0b5f3966723945dcf};
         //   mpc_round<=5'd0;
         //   s_clothes<=0;
         //   s_clothes2<=0;
         //   masked_input1<=0;
         //   masked_input2<=0;
         //   msgs_rw_Control<=0;
         //   msgs_read_en<=1'b0;
         //   msgs_write_en<=1'b0;
         //   msgs_write_address<=0;
         //   msgs_read_address<=0;
         //   msgs_data_in<=0;
         //   S<=0;
         //   Rki<=0;
         //   X_hat<=0;
         //   inter_masked_key<=0;
         //   Lambda_masked_key<=256'b0;
         //   msgs_last_128<=128'h7f1f3d434e86e8395cf2dff02de1ebc7;
         //   lambda_masked_key_out<=0;
         //   inter_masked_key_out<=0;
         //   msgs_out<=0;
        end
    
    else
        begin
            if(MainControlState==0)//KDF
                begin
                if (~start) begin
                     kdf_start<=0;
                     round<=0; 
                    //  computeAux_sbox_index<=0; 2
                    //  computeAux_read_tapes_strat<=0; 2
                    operating_mode<=0;
                    MainControlState<=0;
                    stop<=0;
                    compute_aux_start<=0;
                       mpc_start<=0;
                end
                else if(start && stop==0)
                    begin
                        kdf_start<=1;
                        MainControlState<=1;
                    end
                end
                
            else if(MainControlState==1)
                begin
                    if(kdf_stop)//KDF stop
                        begin
                            kdf_start<=0;
                            MainControlState<=2;
                            compute_aux_start<=1;
                            
                        end
                end
                
            else if(MainControlState==2)
                begin
                    if(computeAux_stop)
                        begin
                            MainControlState<=3;
                            mpc_start<=1;
                              compute_aux_start<=1'b0;
                        end
                end
                
            else if(MainControlState==3)
                begin
                    if(mpc_stop)
                        MainControlState<=4;
                        mpc_start<=1'b0;
                end
            else if(MainControlState==4)
                begin
                    stop<=1;
                    MainControlState<=0;
                end
        end
end


always@(posedge clk)
begin
    if(!rst)
        begin
           compute_aux_write_address_reg<=0; 
            computeAux_sbox_index<=0; 
            computeAux_read_tapes_strat<=0; 
            computeAux_stop<=0 ; 
             compute_aux_state<=0; 
            AuxBits1<=0;
            AuxBits2<=0;
            computeAux_round<=0;
            AuxBits_rw_Control<=1'b0;
            AuxBits_write_en<=1'b0;
            AuxBits_read_en<=1'b0;
            data_in<=0;
            aux_bits_write_temp1<=0;
            aux_bits_write_temp2<=0;
            aux_bits_out<=0;

        end
    else begin
    if (~start) begin
        compute_aux_write_address_reg<=0; 
        computeAux_sbox_index<=0; 
        computeAux_read_tapes_strat<=0; 
        computeAux_stop<=0 ; 
         compute_aux_state<=0; 
        AuxBits1<=0;
        AuxBits2<=0;
        computeAux_round<=0;
        AuxBits_rw_Control<=1'b0;
        AuxBits_write_en<=1'b0;
        AuxBits_read_en<=1'b0;
        data_in<=0;
        aux_bits_write_temp1<=0;
        aux_bits_write_temp2<=0;
        aux_bits_out<=0;
    end
    else if(compute_aux_state==0)
        begin
            if(compute_aux_start)
                compute_aux_state<=1;
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
                        AuxBits1<=AuxBits1^computeAux_read_result1 ^ Lambda_i[254:0];
                        AuxBits2<=AuxBits2^computeAux_read_result2 ^ Lambda_i_2[254:0];
                        aux_bits_write_temp1<=AuxBits1^computeAux_read_result1;
                        aux_bits_write_temp2<=AuxBits2^computeAux_read_result2;
                    end
            end
        else if(compute_aux_state==8'd9)//data is read from tapes and xored with Lambda_i, AuxBits are calculated, next step is write it into aux
            begin
                data_in<={AuxBits2, 1'b0, AuxBits1, 1'b0};
                compute_aux_write_address_reg<=compute_aux_write_address;
                AuxBits_write_en<=1'b1;
                AuxBits_read_en<=1'b0;
                AuxBits_rw_Control<=1'b1;
                AuxBits1<=255'b0;
                AuxBits2<=255'b0;
                compute_aux_state<=8'd10;
            end
        else if(compute_aux_state<=8'd10)
                compute_aux_state<=8'd11;
                
        else if(compute_aux_state==8'd11)
            begin
                data_in<={aux_bits_write_temp1 ^ Lambda_i[509:255], 1'b0, aux_bits_write_temp2 ^ Lambda_i_2[509:255], 1'b0};
                compute_aux_write_address_reg<=compute_aux_write_address_reg+1;
                compute_aux_state<=8'd12;
            end
            
        else if(compute_aux_state == 8'd12)
            compute_aux_state<=8'd13;
        
        else if(compute_aux_state==8'd13)
            begin
                data_in<={aux_bits_write_temp1 ^ Lambda_i[764:510], 1'b0, aux_bits_write_temp2 ^ Lambda_i_2[764:510], 1'b0};
                compute_aux_write_address_reg<=compute_aux_write_address_reg+1;
                compute_aux_state<=8'd14;
            end
            
        else if(compute_aux_state==8'd14)
            compute_aux_state<=8'd15;
            
        else if(compute_aux_state==8'd15)
            begin
                data_in<={aux_bits_write_temp1 ^ Lambda_i[1019:765], 1'b0, aux_bits_write_temp2 ^ Lambda_i_2[1019:765], 1'b0};
                compute_aux_write_address_reg<=compute_aux_write_address_reg+1;
                compute_aux_state<=8'd16;
            end
            
            
        else if(compute_aux_state==8'd16)
            begin
                compute_aux_state<=8'd17;
                AuxBits_write_en<=0;
                AuxBits_read_en<=1;
                AuxBits_rw_Control<=1;
            end
            
        else if(compute_aux_state==8'd17)
            begin
                if(computeAux_round==8'd31)
                    begin
                        computeAux_stop<=1'b1;
                      //  compute_aux_start<=1'b0;
                        compute_aux_state<=8'd0;
                        aux_bits_out<=AuxBits_test_out;
                    end
                else
                    begin
                        computeAux_round<=computeAux_round+1;
                        compute_aux_state<=8'd0;
                    end
            end
    end
end

always@(posedge clk)
begin
    if(!rst)
        begin
           mpc_state<=0;
          //mpc_start<=0;
          mpc_stop<=0;
          K_hat<={1024'b0, 128'hd0f5d16ff54e9ea0b5f3966723945dcf};
          mpc_round<=5'd0;
          s_clothes<=0;
          s_clothes2<=0;
          masked_input1<=0;
          masked_input2<=0;
          msgs_rw_Control<=0;
          msgs_read_en<=1'b0;
          msgs_write_en<=1'b0;
          msgs_write_address<=0;
          msgs_read_address<=0;
          msgs_data_in<=0;
          S<=0;
          Rki<=0;
          X_hat<=0;
          inter_masked_key<=0;
          Lambda_masked_key<=256'b0;
          msgs_last_128<=128'h7f1f3d434e86e8395cf2dff02de1ebc7;
          lambda_masked_key_out<=0;
          inter_masked_key_out<=0;
          msgs_out<=0;

        end
    else begin
    if (~start) begin
          mpc_state<=0;
         // mpc_start<=0;
          mpc_stop<=0;
          K_hat<={1024'b0, 128'hd0f5d16ff54e9ea0b5f3966723945dcf};
          mpc_round<=5'd0;
          s_clothes<=0;
          s_clothes2<=0;
          masked_input1<=0;
          masked_input2<=0;
          msgs_rw_Control<=0;
          msgs_read_en<=1'b0;
          msgs_write_en<=1'b0;
          msgs_write_address<=0;
          msgs_read_address<=0;
          msgs_data_in<=0;
          S<=0;
          Rki<=0;
          X_hat<=0;
        //  inter_masked_key<=0;
        //  Lambda_masked_key<=256'b0;
          msgs_last_128<=128'h7f1f3d434e86e8395cf2dff02de1ebc7;
        //  lambda_masked_key_out<=0;
        //  inter_masked_key_out<=0;
        //  msgs_out<=0;
    end
    else if(mpc_state==0)
        begin
            if(mpc_start)
                mpc_state<=1;
                mpc_round<=0;
        end
        
    else if(mpc_state==1)
        begin
            masked_input1<=K_hat[(mpc_round+1)*32 +:32] ^ K_hat[(mpc_round+2)*32 +:32] ^ K_hat[(mpc_round+3)*32 +:32] ^ CKi_wire;
            mpc_state<=8'd254;
        end
        
    else if(mpc_state==8'd254)
        begin
            s_clothes[31:0]<=      ZT_Lambda_i ^ Lambda_output_t[31:0] ;//^ Lambda_output_t[63:32] ^ Lambda_output_t[95:64] ^ Lambda_output_t[127:96] ^ Lambda_output_t[159:128] ^ Lambda_output_t[191:160] ^ Lambda_output_t[223:192] ^ Lambda_output_t[255:224] ^ Lambda_output_t[287:256] ^ Lambda_output_t[319:288] ^ Lambda_output_t[351:320] ^ Lambda_output_t[383:352] ^ Lambda_output_t[415:384] ^ Lambda_output_t[447:416] ^ Lambda_output_t[479:448] ^ Lambda_output_t[511:480];
            s_clothes[63:32]<=    ZT_Lambda_i ^ Lambda_output_t[63:32] ;
            s_clothes[95:64]<=    ZT_Lambda_i ^ Lambda_output_t[95:64] ;
            s_clothes[127:96]<=  ZT_Lambda_i ^ Lambda_output_t[127:96] ;
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
            lambda_masked_key_out<={msgs_last_128, 128'h5e10e0396f3c3be468cc5e6b1164d311};
            inter_masked_key_out[255:128]<=msgs_last_128;
            inter_masked_key_out[127:0] <=inter_masked_key[127:0];
            Lambda_masked_key<={msgs_last_128, 128'h5e10e0396f3c3be468cc5e6b1164d311};
            mpc_stop<=1'b1;

            mpc_state<=8'd0;
            msgs_out<=msgs_data_in;
        end
    end
end






aux_bits aux 
(
  .clka(clk),    // input wire clka
  .ena(AuxBits_write_en),      // input wire ena
  .wea(AuxBits_rw_Control),      // input wire [0 : 0] wea
  .addra(compute_aux_write_address_reg),  // input wire [6 : 0] addra
  .dina(data_in),    // input wire [511 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(AuxBits_read_en),      // input wire enb
  .addrb(compute_aux_write_address_reg),  // input wire [6 : 0] addrb
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