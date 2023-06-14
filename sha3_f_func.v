module sha3_f_func(
    input clk,
    input reset,
    input sha3_start,
    input [0:1599]S_in,
    output [0:1599]S_out,
    output [0:1087]r_out,
    output reg sha3_end
);

function [0:63] byteswap(input [0:63] data);
byteswap = { data[56:63],
             data[48:55],
             data[40:47],
             data[32:39],
             data[24:31],
             data[16:23],
             data[ 8:15],
             data[ 0: 7]
           };
endfunction

wire [0:63] A_array[0:24];
assign A_array[ 0] = byteswap(S_in[   0:  63]);
assign A_array[ 1] = byteswap(S_in[  64: 127]);
assign A_array[ 2] = byteswap(S_in[ 128: 191]);
assign A_array[ 3] = byteswap(S_in[ 192: 255]);
assign A_array[ 4] = byteswap(S_in[ 256: 319]);
assign A_array[ 5] = byteswap(S_in[ 320: 383]);
assign A_array[ 6] = byteswap(S_in[ 384: 447]);
assign A_array[ 7] = byteswap(S_in[ 448: 511]);
assign A_array[ 8] = byteswap(S_in[ 512: 575]);
assign A_array[ 9] = byteswap(S_in[ 576: 639]);
assign A_array[10] = byteswap(S_in[ 640: 703]);
assign A_array[11] = byteswap(S_in[ 704: 767]);
assign A_array[12] = byteswap(S_in[ 768: 831]);
assign A_array[13] = byteswap(S_in[ 832: 895]);
assign A_array[14] = byteswap(S_in[ 896: 959]);
assign A_array[15] = byteswap(S_in[ 960:1023]);
assign A_array[16] = byteswap(S_in[1024:1087]);
assign A_array[17] = byteswap(S_in[1088:1151]);
assign A_array[18] = byteswap(S_in[1152:1215]);
assign A_array[19] = byteswap(S_in[1216:1279]);
assign A_array[20] = byteswap(S_in[1280:1343]);
assign A_array[21] = byteswap(S_in[1344:1407]);
assign A_array[22] = byteswap(S_in[1408:1471]);
assign A_array[23] = byteswap(S_in[1472:1535]);
assign A_array[24] = byteswap(S_in[1536:1599]);

wire [0:1599] A={A_array[ 0], A_array[ 1], A_array[ 2], A_array[ 3], A_array[ 4], A_array[ 5], A_array[ 6], A_array[ 7], A_array[ 8], A_array[ 9], A_array[10], A_array[11], A_array[12], A_array[13], A_array[14], A_array[15], A_array[16], A_array[17], A_array[18], A_array[19], A_array[20], A_array[21], A_array[22], A_array[23], A_array[24]};

wire [0:63] Ako, Aku, Aka, Ake, Aki;
wire [0:63] Ago, Agu, Aga, Age, Agi;
wire [0:63] Abo, Abu, Aba, Abe, Abi;
wire [0:63] Aso, Asu, Asa, Ase, Asi;
wire [0:63] Amo, Amu, Ama, Ame, Ami;


reg [0:63] state_array [0:24];

wire[0:1599] state_reg;

assign state_reg = {state_array[ 0], state_array[ 1], state_array[ 2], state_array[ 3], state_array[ 4], 
                    state_array[ 5], state_array[ 6], state_array[ 7], state_array[ 8], state_array[ 9], 
                    state_array[10], state_array[11], state_array[12], state_array[13], state_array[14], 
                    state_array[15], state_array[16], state_array[17], state_array[18], state_array[19], 
                    state_array[20], state_array[21], state_array[22], state_array[23], state_array[24]
                   };

assign r_out = {state_array[0][56:63], state_array[0][48:55], state_array[0][40:47], state_array[0][32:39], state_array[0][24:31], state_array[0][16:23], state_array[0][8:15], state_array[0][0:7], 
                state_array[1][56:63], state_array[1][48:55], state_array[1][40:47], state_array[1][32:39], state_array[1][24:31], state_array[1][16:23], state_array[1][8:15], state_array[1][0:7], 
                state_array[2][56:63], state_array[2][48:55], state_array[2][40:47], state_array[2][32:39], state_array[2][24:31], state_array[2][16:23], state_array[2][8:15], state_array[2][0:7], 
                state_array[3][56:63], state_array[3][48:55], state_array[3][40:47], state_array[3][32:39], state_array[3][24:31], state_array[3][16:23], state_array[3][8:15], state_array[3][0:7],
                state_array[4][56:63], state_array[4][48:55], state_array[4][40:47], state_array[4][32:39], state_array[4][24:31], state_array[4][16:23], state_array[4][8:15], state_array[4][0:7], 
                state_array[5][56:63], state_array[5][48:55], state_array[5][40:47], state_array[5][32:39], state_array[5][24:31], state_array[5][16:23], state_array[5][8:15], state_array[5][0:7], 
                state_array[6][56:63], state_array[6][48:55], state_array[6][40:47], state_array[6][32:39], state_array[6][24:31], state_array[6][16:23], state_array[6][8:15], state_array[6][0:7], 
                state_array[7][56:63], state_array[7][48:55], state_array[7][40:47], state_array[7][32:39], state_array[7][24:31], state_array[7][16:23], state_array[7][8:15], state_array[7][0:7],  
                state_array[8][56:63], state_array[8][48:55], state_array[8][40:47], state_array[8][32:39], state_array[8][24:31], state_array[8][16:23], state_array[8][8:15], state_array[8][0:7],
                state_array[9][56:63], state_array[9][48:55], state_array[9][40:47], state_array[9][32:39], state_array[9][24:31], state_array[9][16:23], state_array[9][8:15], state_array[9][0:7],
                state_array[10][56:63], state_array[10][48:55], state_array[10][40:47], state_array[10][32:39], state_array[10][24:31], state_array[10][16:23], state_array[10][8:15], state_array[10][0:7],
                state_array[11][56:63], state_array[11][48:55], state_array[11][40:47], state_array[11][32:39], state_array[11][24:31], state_array[11][16:23], state_array[11][8:15], state_array[11][0:7],
                state_array[12][56:63], state_array[12][48:55], state_array[12][40:47], state_array[12][32:39], state_array[12][24:31], state_array[12][16:23], state_array[12][8:15], state_array[12][0:7],
                state_array[13][56:63], state_array[13][48:55], state_array[13][40:47], state_array[13][32:39], state_array[13][24:31], state_array[13][16:23], state_array[13][8:15], state_array[13][0:7],
                state_array[14][56:63], state_array[14][48:55], state_array[14][40:47], state_array[14][32:39], state_array[14][24:31], state_array[14][16:23], state_array[14][8:15], state_array[14][0:7],
                state_array[15][56:63], state_array[15][48:55], state_array[15][40:47], state_array[15][32:39], state_array[15][24:31], state_array[15][16:23], state_array[15][8:15], state_array[15][0:7],
                state_array[16][56:63], state_array[16][48:55], state_array[16][40:47], state_array[16][32:39], state_array[16][24:31], state_array[16][16:23], state_array[16][8:15], state_array[16][0:7]
                };



assign S_out=state_reg;

reg[4:0] round;
reg[4:0] state;

wire[0:1599] A_in=(round==0)?A:state_reg;

always @(posedge clk or negedge reset) begin
    if(~reset) begin
        {state_array[0],state_array[1],state_array[2],state_array[3],state_array[4],state_array[5],state_array[6],state_array[7],state_array[8],state_array[9],state_array[10] ,state_array[11] ,state_array[12] ,state_array[13] ,state_array[14] ,state_array[15] ,state_array[16] ,state_array[17] ,state_array[18] ,state_array[19] ,state_array[20] ,state_array[21] ,state_array[22] ,state_array[23] ,state_array[24]} <= 0;
        state<=0;
        sha3_end<=0;
        round<=0;
    end
    else begin
        if(~sha3_start) begin
            sha3_end<=0;
            state<=0;
            round<=0;
            //{state_array[0],state_array[1],state_array[2],state_array[3],state_array[4],state_array[5],state_array[6],state_array[7],state_array[8],state_array[9],state_array[10] ,state_array[11] ,state_array[12] ,state_array[13] ,state_array[14] ,state_array[15] ,state_array[16] ,state_array[17] ,state_array[18] ,state_array[19] ,state_array[20] ,state_array[21] ,state_array[22] ,state_array[23] ,state_array[24]} <= 0;
        end
        if(state==0&& sha3_start &&~sha3_end) begin
            state<=1;
        end
        else if(state==1) begin
            round<=round+1;
            state_array[0] <= Aba;
            state_array[1] <= Abe;
            state_array[2] <= Abi;
            state_array[3] <= Abo;
            state_array[4] <= Abu;
            state_array[5] <= Aga;
            state_array[6] <= Age;
            state_array[7] <= Agi;
            state_array[8] <= Ago;
            state_array[9] <= Agu;
            state_array[10] <= Aka;
            state_array[11] <= Ake;
            state_array[12] <= Aki;
            state_array[13] <= Ako;
            state_array[14] <= Aku;
            state_array[15] <= Ama;
            state_array[16] <= Ame;
            state_array[17] <= Ami;
            state_array[18] <= Amo;
            state_array[19] <= Amu;
            state_array[20] <= Asa;
            state_array[21] <= Ase;
            state_array[22] <= Asi;
            state_array[23] <= Aso;
            state_array[24] <= Asu;
            if(round==23) begin
                state<=2;
            end
        end
        else if(state==2) begin
            round<=0;
            sha3_end<=1;
            state<=0;
        end
    end
end


sha3_rnd inst_sha3_rnd(
    .round_i (round),
    .string_i (A_in),
    .Aba_o (Aba),
    .Abe_o (Abe),
    .Abi_o (Abi),
    .Abo_o (Abo),
    .Abu_o (Abu),
    .Aga_o (Aga),
    .Age_o (Age),
    .Agi_o (Agi),
    .Ago_o (Ago),
    .Agu_o (Agu),
    .Aka_o (Aka),
    .Ake_o (Ake),
    .Aki_o (Aki),
    .Ako_o (Ako),
    .Aku_o (Aku),
    .Ama_o (Ama),
    .Ame_o (Ame),
    .Ami_o (Ami),
    .Amo_o (Amo),
    .Amu_o (Amu),
    .Asa_o (Asa),
    .Ase_o (Ase),
    .Asi_o (Asi),
    .Aso_o (Aso),
    .Asu_o (Asu) 
);


endmodule