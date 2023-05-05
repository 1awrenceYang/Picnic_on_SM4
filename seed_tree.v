

module seed_tree(
    input clk,
    input reset,
    input[127:0] root_seed,
    input[255:0] salt,
    input[7:0] t,
    input tree_start,
    output  [16383:0] iseed,
    output reg tree_set_end
    );
    reg [511:0] h1InSeedSet0;
    wire [511:0] h1InSeedSet [63:0];
    reg[7:0] j;
    reg[7:0] j2;
    wire [103:0]padding={8'h80,32'h0,64'h198};
    reg [63:0] Hstart;
    wire [255:0] hashValue[63:0];
    wire [63:0] en_end; 
    reg[4:0] state; 
    reg[4:0] counter;
    wire [0:63] start_marsk[0:9];
    assign start_marsk[0] = 1; 
    assign start_marsk[1] = 301'h3; 
    assign start_marsk[2] = 301'hf;   
    assign start_marsk[3] = 301'hff; 
    assign start_marsk[4] = 301'hffff;  
    assign start_marsk[5] = 301'hffffffff; 
    assign start_marsk[6] = 301'hffffffffffffffff;
    
    assign iseed[16383:16128] = hashValue[0];
    assign iseed[16127:15872] = hashValue[1];
    assign iseed[15871:15616] = hashValue[2];
    assign iseed[15615:15360] = hashValue[3];
    assign iseed[15359:15104] = hashValue[4];
    assign iseed[15103:14848] = hashValue[5];
    assign iseed[14847:14592] = hashValue[6];
    assign iseed[14591:14336] = hashValue[7];
    assign iseed[14335:14080] = hashValue[8];
    assign iseed[14079:13824] = hashValue[9];
    assign iseed[13823:13568] = hashValue[10];
    assign iseed[13567:13312] = hashValue[11];
    assign iseed[13311:13056] = hashValue[12];
    assign iseed[13055:12800] = hashValue[13];
    assign iseed[12799:12544] = hashValue[14];
    assign iseed[12543:12288] = hashValue[15];
    assign iseed[12287:12032] = hashValue[16];
    assign iseed[12031:11776] = hashValue[17];
    assign iseed[11775:11520] = hashValue[18];
    assign iseed[11519:11264] = hashValue[19];
    assign iseed[11263:11008] = hashValue[20];
    assign iseed[11007:10752] = hashValue[21];
    assign iseed[10751:10496] = hashValue[22];
    assign iseed[10495:10240] = hashValue[23];
    assign iseed[10239:9984] = hashValue[24];
    assign iseed[9983:9728] = hashValue[25];
    assign iseed[9727:9472] = hashValue[26];
    assign iseed[9471:9216] = hashValue[27];
    assign iseed[9215:8960] = hashValue[28];
    assign iseed[8959:8704] = hashValue[29];
    assign iseed[8703:8448] = hashValue[30];
    assign iseed[8447:8192] = hashValue[31];
    assign iseed[8191:7936] = hashValue[32];
    assign iseed[7935:7680] = hashValue[33];
    assign iseed[7679:7424] = hashValue[34];
    assign iseed[7423:7168] = hashValue[35];
    assign iseed[7167:6912] = hashValue[36];
    assign iseed[6911:6656] = hashValue[37];
    assign iseed[6655:6400] = hashValue[38];
    assign iseed[6399:6144] = hashValue[39];
    assign iseed[6143:5888] = hashValue[40];
    assign iseed[5887:5632] = hashValue[41];
    assign iseed[5631:5376] = hashValue[42];
    assign iseed[5375:5120] = hashValue[43];
    assign iseed[5119:4864] = hashValue[44];
    assign iseed[4863:4608] = hashValue[45];
    assign iseed[4607:4352] = hashValue[46];
    assign iseed[4351:4096] = hashValue[47];
    assign iseed[4095:3840] = hashValue[48];
    assign iseed[3839:3584] = hashValue[49];
    assign iseed[3583:3328] = hashValue[50];
    assign iseed[3327:3072] = hashValue[51];
    assign iseed[3071:2816] = hashValue[52];
    assign iseed[2815:2560] = hashValue[53];
    assign iseed[2559:2304] = hashValue[54];
    assign iseed[2303:2048] = hashValue[55];
    assign iseed[2047:1792] = hashValue[56];
    assign iseed[1791:1536] = hashValue[57];
    assign iseed[1535:1280] = hashValue[58];
    assign iseed[1279:1024] = hashValue[59];
    assign iseed[1023:768] = hashValue[60];
    assign iseed[767:512] = hashValue[61];
    assign iseed[511:256] = hashValue[62];
    assign iseed[255:0] = hashValue[63];

    //assign h1InSeedSet[0]={8'h01,hashValue[0][255:128],salt,t,j+0,padding};
    assign h1InSeedSet[1]={8'h01,hashValue[0][127:0],salt,t,j+1,padding};
    assign h1InSeedSet[2]={8'h01,hashValue[1][255:128],salt,t,j+2,padding};
    assign h1InSeedSet[3]={8'h01,hashValue[1][127:0],salt,t,j+3,padding};
    assign h1InSeedSet[4]={8'h01,hashValue[2][255:128],salt,t,j+4,padding};
    assign h1InSeedSet[5]={8'h01,hashValue[2][127:0],salt,t,j+5,padding};
    assign h1InSeedSet[6]={8'h01,hashValue[3][255:128],salt,t,j+6,padding};
    assign h1InSeedSet[7]={8'h01,hashValue[3][127:0],salt,t,j+7,padding};
    assign h1InSeedSet[8]={8'h01,hashValue[4][255:128],salt,t,j+8,padding};
    assign h1InSeedSet[9]={8'h01,hashValue[4][127:0],salt,t,j+9,padding};
    assign h1InSeedSet[10]={8'h01,hashValue[5][255:128],salt,t,j+10,padding};
    assign h1InSeedSet[11]={8'h01,hashValue[5][127:0],salt,t,j+11,padding};
    assign h1InSeedSet[12]={8'h01,hashValue[6][255:128],salt,t,j+12,padding};
    assign h1InSeedSet[13]={8'h01,hashValue[6][127:0],salt,t,j+13,padding};
    assign h1InSeedSet[14]={8'h01,hashValue[7][255:128],salt,t,j+14,padding};
    assign h1InSeedSet[15]={8'h01,hashValue[7][127:0],salt,t,j+15,padding};
    assign h1InSeedSet[16]={8'h01,hashValue[8][255:128],salt,t,j+16,padding};
    assign h1InSeedSet[17]={8'h01,hashValue[8][127:0],salt,t,j+17,padding};
    assign h1InSeedSet[18]={8'h01,hashValue[9][255:128],salt,t,j+18,padding};
    assign h1InSeedSet[19]={8'h01,hashValue[9][127:0],salt,t,j+19,padding};
    assign h1InSeedSet[20]={8'h01,hashValue[10][255:128],salt,t,j+20,padding};
    assign h1InSeedSet[21]={8'h01,hashValue[10][127:0],salt,t,j+21,padding};
    assign h1InSeedSet[22]={8'h01,hashValue[11][255:128],salt,t,j+22,padding};
    assign h1InSeedSet[23]={8'h01,hashValue[11][127:0],salt,t,j+23,padding};
    assign h1InSeedSet[24]={8'h01,hashValue[12][255:128],salt,t,j+24,padding};
    assign h1InSeedSet[25]={8'h01,hashValue[12][127:0],salt,t,j+25,padding};
    assign h1InSeedSet[26]={8'h01,hashValue[13][255:128],salt,t,j+26,padding};
    assign h1InSeedSet[27]={8'h01,hashValue[13][127:0],salt,t,j+27,padding};
    assign h1InSeedSet[28]={8'h01,hashValue[14][255:128],salt,t,j+28,padding};
    assign h1InSeedSet[29]={8'h01,hashValue[14][127:0],salt,t,j+29,padding};
    assign h1InSeedSet[30]={8'h01,hashValue[15][255:128],salt,t,j+30,padding};
    assign h1InSeedSet[31]={8'h01,hashValue[15][127:0],salt,t,j+31,padding};
    assign h1InSeedSet[32]={8'h01,hashValue[16][255:128],salt,t,j+32,padding};
    assign h1InSeedSet[33]={8'h01,hashValue[16][127:0],salt,t,j+33,padding};
    assign h1InSeedSet[34]={8'h01,hashValue[17][255:128],salt,t,j+34,padding};
    assign h1InSeedSet[35]={8'h01,hashValue[17][127:0],salt,t,j+35,padding};
    assign h1InSeedSet[36]={8'h01,hashValue[18][255:128],salt,t,j+36,padding};
    assign h1InSeedSet[37]={8'h01,hashValue[18][127:0],salt,t,j+37,padding};
    assign h1InSeedSet[38]={8'h01,hashValue[19][255:128],salt,t,j+38,padding};
    assign h1InSeedSet[39]={8'h01,hashValue[19][127:0],salt,t,j+39,padding};
    assign h1InSeedSet[40]={8'h01,hashValue[20][255:128],salt,t,j+40,padding};
    assign h1InSeedSet[41]={8'h01,hashValue[20][127:0],salt,t,j+41,padding};
    assign h1InSeedSet[42]={8'h01,hashValue[21][255:128],salt,t,j+42,padding};
    assign h1InSeedSet[43]={8'h01,hashValue[21][127:0],salt,t,j+43,padding};
    assign h1InSeedSet[44]={8'h01,hashValue[22][255:128],salt,t,j+44,padding};
    assign h1InSeedSet[45]={8'h01,hashValue[22][127:0],salt,t,j+45,padding};
    assign h1InSeedSet[46]={8'h01,hashValue[23][255:128],salt,t,j+46,padding};
    assign h1InSeedSet[47]={8'h01,hashValue[23][127:0],salt,t,j+47,padding};
    assign h1InSeedSet[48]={8'h01,hashValue[24][255:128],salt,t,j+48,padding};
    assign h1InSeedSet[49]={8'h01,hashValue[24][127:0],salt,t,j+49,padding};
    assign h1InSeedSet[50]={8'h01,hashValue[25][255:128],salt,t,j+50,padding};
    assign h1InSeedSet[51]={8'h01,hashValue[25][127:0],salt,t,j+51,padding};
    assign h1InSeedSet[52]={8'h01,hashValue[26][255:128],salt,t,j+52,padding};
    assign h1InSeedSet[53]={8'h01,hashValue[26][127:0],salt,t,j+53,padding};
    assign h1InSeedSet[54]={8'h01,hashValue[27][255:128],salt,t,j+54,padding};
    assign h1InSeedSet[55]={8'h01,hashValue[27][127:0],salt,t,j+55,padding};
    assign h1InSeedSet[56]={8'h01,hashValue[28][255:128],salt,t,j+56,padding};
    assign h1InSeedSet[57]={8'h01,hashValue[28][127:0],salt,t,j+57,padding};
    assign h1InSeedSet[58]={8'h01,hashValue[29][255:128],salt,t,j+58,padding};
    assign h1InSeedSet[59]={8'h01,hashValue[29][127:0],salt,t,j+59,padding};
    assign h1InSeedSet[60]={8'h01,hashValue[30][255:128],salt,t,j+60,padding};
    assign h1InSeedSet[61]={8'h01,hashValue[30][127:0],salt,t,j+61,padding};
    assign h1InSeedSet[62]={8'h01,hashValue[31][255:128],salt,t,j+62,padding};
    assign h1InSeedSet[63]={8'h01,hashValue[31][127:0],salt,t,j+63,padding};
                        
    
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            counter <= 0;
            state<=0;
            tree_set_end<=0;
            j<=1;
            j2<=1;
        end
        else begin
            if(state==0) begin
                if(tree_start) begin
                    if(counter==0)begin
                        j<=1;
                        j2<=1;
                        h1InSeedSet0<={8'h01,root_seed,salt,t,8'h0,padding};
                    end
                    tree_set_end<=0;
                    Hstart<=start_marsk[counter];
                    state<=1;
                    
                end
                
            end
            if(state==1) begin
                if(en_end==start_marsk[counter]) begin
                        counter<=counter+1;
                        Hstart<=0;
                        j<=j2;
                        j2<=j2<<1;
                        h1InSeedSet0<={8'h01,hashValue[0][255:128],salt,t,j+0,padding};
                        if(en_end == start_marsk[6]) begin
                            state<=2;
                        end
                        else begin
                            state<=0;
                        end
                        
            end
                                   
        end
            if(state==2) begin
                tree_set_end<=1;
                state <= 3;
            end
            if(state==3) begin
                tree_set_end <= 0;
                state<=0;
                counter <= 0;
            end
        end

    end
    H_for_s_tree h0(clk,reset,h1InSeedSet0,Hstart[0],hashValue[0],en_end[0]);
    H_for_s_tree h1(clk,reset,h1InSeedSet[1],Hstart[1],hashValue[1],en_end[1]);
    H_for_s_tree h2(clk,reset,h1InSeedSet[2],Hstart[2],hashValue[2],en_end[2]);
    H_for_s_tree h3(clk,reset,h1InSeedSet[3],Hstart[3],hashValue[3],en_end[3]);
    H_for_s_tree h4(clk,reset,h1InSeedSet[4],Hstart[4],hashValue[4],en_end[4]);
    H_for_s_tree h5(clk,reset,h1InSeedSet[5],Hstart[5],hashValue[5],en_end[5]);
    H_for_s_tree h6(clk,reset,h1InSeedSet[6],Hstart[6],hashValue[6],en_end[6]);
    H_for_s_tree h7(clk,reset,h1InSeedSet[7],Hstart[7],hashValue[7],en_end[7]);
    H_for_s_tree h8(clk,reset,h1InSeedSet[8],Hstart[8],hashValue[8],en_end[8]);
    H_for_s_tree h9(clk,reset,h1InSeedSet[9],Hstart[9],hashValue[9],en_end[9]);
    H_for_s_tree h10(clk,reset,h1InSeedSet[10],Hstart[10],hashValue[10],en_end[10]);
    H_for_s_tree h11(clk,reset,h1InSeedSet[11],Hstart[11],hashValue[11],en_end[11]);
    H_for_s_tree h12(clk,reset,h1InSeedSet[12],Hstart[12],hashValue[12],en_end[12]);
    H_for_s_tree h13(clk,reset,h1InSeedSet[13],Hstart[13],hashValue[13],en_end[13]);
    H_for_s_tree h14(clk,reset,h1InSeedSet[14],Hstart[14],hashValue[14],en_end[14]);
    H_for_s_tree h15(clk,reset,h1InSeedSet[15],Hstart[15],hashValue[15],en_end[15]);
    H_for_s_tree h16(clk,reset,h1InSeedSet[16],Hstart[16],hashValue[16],en_end[16]);
    H_for_s_tree h17(clk,reset,h1InSeedSet[17],Hstart[17],hashValue[17],en_end[17]);
    H_for_s_tree h18(clk,reset,h1InSeedSet[18],Hstart[18],hashValue[18],en_end[18]);
    H_for_s_tree h19(clk,reset,h1InSeedSet[19],Hstart[19],hashValue[19],en_end[19]);
    H_for_s_tree h20(clk,reset,h1InSeedSet[20],Hstart[20],hashValue[20],en_end[20]);
    H_for_s_tree h21(clk,reset,h1InSeedSet[21],Hstart[21],hashValue[21],en_end[21]);
    H_for_s_tree h22(clk,reset,h1InSeedSet[22],Hstart[22],hashValue[22],en_end[22]);
    H_for_s_tree h23(clk,reset,h1InSeedSet[23],Hstart[23],hashValue[23],en_end[23]);
    H_for_s_tree h24(clk,reset,h1InSeedSet[24],Hstart[24],hashValue[24],en_end[24]);
    H_for_s_tree h25(clk,reset,h1InSeedSet[25],Hstart[25],hashValue[25],en_end[25]);
    H_for_s_tree h26(clk,reset,h1InSeedSet[26],Hstart[26],hashValue[26],en_end[26]);
    H_for_s_tree h27(clk,reset,h1InSeedSet[27],Hstart[27],hashValue[27],en_end[27]);
    H_for_s_tree h28(clk,reset,h1InSeedSet[28],Hstart[28],hashValue[28],en_end[28]);
    H_for_s_tree h29(clk,reset,h1InSeedSet[29],Hstart[29],hashValue[29],en_end[29]);
    H_for_s_tree h30(clk,reset,h1InSeedSet[30],Hstart[30],hashValue[30],en_end[30]);
    H_for_s_tree h31(clk,reset,h1InSeedSet[31],Hstart[31],hashValue[31],en_end[31]);
    H_for_s_tree h32(clk,reset,h1InSeedSet[32],Hstart[32],hashValue[32],en_end[32]);
    H_for_s_tree h33(clk,reset,h1InSeedSet[33],Hstart[33],hashValue[33],en_end[33]);
    H_for_s_tree h34(clk,reset,h1InSeedSet[34],Hstart[34],hashValue[34],en_end[34]);
    H_for_s_tree h35(clk,reset,h1InSeedSet[35],Hstart[35],hashValue[35],en_end[35]);
    H_for_s_tree h36(clk,reset,h1InSeedSet[36],Hstart[36],hashValue[36],en_end[36]);
    H_for_s_tree h37(clk,reset,h1InSeedSet[37],Hstart[37],hashValue[37],en_end[37]);
    H_for_s_tree h38(clk,reset,h1InSeedSet[38],Hstart[38],hashValue[38],en_end[38]);
    H_for_s_tree h39(clk,reset,h1InSeedSet[39],Hstart[39],hashValue[39],en_end[39]);
    H_for_s_tree h40(clk,reset,h1InSeedSet[40],Hstart[40],hashValue[40],en_end[40]);
    H_for_s_tree h41(clk,reset,h1InSeedSet[41],Hstart[41],hashValue[41],en_end[41]);
    H_for_s_tree h42(clk,reset,h1InSeedSet[42],Hstart[42],hashValue[42],en_end[42]);
    H_for_s_tree h43(clk,reset,h1InSeedSet[43],Hstart[43],hashValue[43],en_end[43]);
    H_for_s_tree h44(clk,reset,h1InSeedSet[44],Hstart[44],hashValue[44],en_end[44]);
    H_for_s_tree h45(clk,reset,h1InSeedSet[45],Hstart[45],hashValue[45],en_end[45]);
    H_for_s_tree h46(clk,reset,h1InSeedSet[46],Hstart[46],hashValue[46],en_end[46]);
    H_for_s_tree h47(clk,reset,h1InSeedSet[47],Hstart[47],hashValue[47],en_end[47]);
    H_for_s_tree h48(clk,reset,h1InSeedSet[48],Hstart[48],hashValue[48],en_end[48]);
    H_for_s_tree h49(clk,reset,h1InSeedSet[49],Hstart[49],hashValue[49],en_end[49]);
    H_for_s_tree h50(clk,reset,h1InSeedSet[50],Hstart[50],hashValue[50],en_end[50]);
    H_for_s_tree h51(clk,reset,h1InSeedSet[51],Hstart[51],hashValue[51],en_end[51]);
    H_for_s_tree h52(clk,reset,h1InSeedSet[52],Hstart[52],hashValue[52],en_end[52]);
    H_for_s_tree h53(clk,reset,h1InSeedSet[53],Hstart[53],hashValue[53],en_end[53]);
    H_for_s_tree h54(clk,reset,h1InSeedSet[54],Hstart[54],hashValue[54],en_end[54]);
    H_for_s_tree h55(clk,reset,h1InSeedSet[55],Hstart[55],hashValue[55],en_end[55]);
    H_for_s_tree h56(clk,reset,h1InSeedSet[56],Hstart[56],hashValue[56],en_end[56]);
    H_for_s_tree h57(clk,reset,h1InSeedSet[57],Hstart[57],hashValue[57],en_end[57]);
    H_for_s_tree h58(clk,reset,h1InSeedSet[58],Hstart[58],hashValue[58],en_end[58]);
    H_for_s_tree h59(clk,reset,h1InSeedSet[59],Hstart[59],hashValue[59],en_end[59]);
    H_for_s_tree h60(clk,reset,h1InSeedSet[60],Hstart[60],hashValue[60],en_end[60]);
    H_for_s_tree h61(clk,reset,h1InSeedSet[61],Hstart[61],hashValue[61],en_end[61]);
    H_for_s_tree h62(clk,reset,h1InSeedSet[62],Hstart[62],hashValue[62],en_end[62]);
    H_for_s_tree h63(clk,reset,h1InSeedSet[63],Hstart[63],hashValue[63],en_end[63]);
endmodule