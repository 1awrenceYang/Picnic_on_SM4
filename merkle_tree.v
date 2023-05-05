module merkle_tree(
    input clk,
    input reset,
    input [128*256-1:0] c,
    input [255:0]salt,
    input tree_start,
    output reg [255:0] commitment,
    output reg tree_set_end
    );
    reg [1023:0] h3InCommitment [63:0];
    reg[7:0] j;
    wire [215:0]padding={8'h80,216'h0,16'h310};
    reg [63:0] Hstart;
    wire [255:0] hashValue[63:0];
    wire [63:0] en_end;
    wire [9:0] groupNum=1;
    reg[4:0] state; 
    reg[9:0] counter;
    wire [0:63] start_marsk[0:6];
    assign start_marsk[6] = 1;
    assign start_marsk[5] = 64'h3;
    assign start_marsk[4] = 64'hf;
    assign start_marsk[3] = 64'hff;
    assign start_marsk[2] = 64'hffff;
    assign start_marsk[1] = 64'hffffffff;
    assign start_marsk[0] = 64'hffffffffffffffff;
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            counter <= 0;
            state<=0;
            commitment<=0;
            tree_set_end<=0;
            j<=8'd64;
        end
        else begin
            if(state==0) begin
                if(tree_start) begin
                    tree_set_end<=0;
                    Hstart<=start_marsk[counter];
                    state<=1;
                    if(counter==0)begin
                        j<=8'd64;
                        h3InCommitment[0]={8'h03,c[32767:32512],c[32511:32256],salt,j+0,padding};
                        h3InCommitment[1]={8'h03,c[32255:32000],c[31999:31744],salt,j+1,padding};
                        h3InCommitment[2]={8'h03,c[31743:31488],c[31487:31232],salt,j+2,padding};
                        h3InCommitment[3]={8'h03,c[31231:30976],c[30975:30720],salt,j+3,padding};
                        h3InCommitment[4]={8'h03,c[30719:30464],c[30463:30208],salt,j+4,padding};
                        h3InCommitment[5]={8'h03,c[30207:29952],c[29951:29696],salt,j+5,padding};
                        h3InCommitment[6]={8'h03,c[29695:29440],c[29439:29184],salt,j+6,padding};
                        h3InCommitment[7]={8'h03,c[29183:28928],c[28927:28672],salt,j+7,padding};
                        h3InCommitment[8]={8'h03,c[28671:28416],c[28415:28160],salt,j+8,padding};
                        h3InCommitment[9]={8'h03,c[28159:27904],c[27903:27648],salt,j+9,padding};
                        h3InCommitment[10]={8'h03,c[27647:27392],c[27391:27136],salt,j+10,padding};
                        h3InCommitment[11]={8'h03,c[27135:26880],c[26879:26624],salt,j+11,padding};
                        h3InCommitment[12]={8'h03,c[26623:26368],c[26367:26112],salt,j+12,padding};
                        h3InCommitment[13]={8'h03,c[26111:25856],c[25855:25600],salt,j+13,padding};
                        h3InCommitment[14]={8'h03,c[25599:25344],c[25343:25088],salt,j+14,padding};
                        h3InCommitment[15]={8'h03,c[25087:24832],c[24831:24576],salt,j+15,padding};
                        h3InCommitment[16]={8'h03,c[24575:24320],c[24319:24064],salt,j+16,padding};
                        h3InCommitment[17]={8'h03,c[24063:23808],c[23807:23552],salt,j+17,padding};
                        h3InCommitment[18]={8'h03,c[23551:23296],c[23295:23040],salt,j+18,padding};
                        h3InCommitment[19]={8'h03,c[23039:22784],c[22783:22528],salt,j+19,padding};
                        h3InCommitment[20]={8'h03,c[22527:22272],c[22271:22016],salt,j+20,padding};
                        h3InCommitment[21]={8'h03,c[22015:21760],c[21759:21504],salt,j+21,padding};
                        h3InCommitment[22]={8'h03,c[21503:21248],c[21247:20992],salt,j+22,padding};
                        h3InCommitment[23]={8'h03,c[20991:20736],c[20735:20480],salt,j+23,padding};
                        h3InCommitment[24]={8'h03,c[20479:20224],c[20223:19968],salt,j+24,padding};
                        h3InCommitment[25]={8'h03,c[19967:19712],c[19711:19456],salt,j+25,padding};
                        h3InCommitment[26]={8'h03,c[19455:19200],c[19199:18944],salt,j+26,padding};
                        h3InCommitment[27]={8'h03,c[18943:18688],c[18687:18432],salt,j+27,padding};
                        h3InCommitment[28]={8'h03,c[18431:18176],c[18175:17920],salt,j+28,padding};
                        h3InCommitment[29]={8'h03,c[17919:17664],c[17663:17408],salt,j+29,padding};
                        h3InCommitment[30]={8'h03,c[17407:17152],c[17151:16896],salt,j+30,padding};
                        h3InCommitment[31]={8'h03,c[16895:16640],c[16639:16384],salt,j+31,padding};
                        h3InCommitment[32]={8'h03,c[16383:16128],c[16127:15872],salt,j+32,padding};
                        h3InCommitment[33]={8'h03,c[15871:15616],c[15615:15360],salt,j+33,padding};
                        h3InCommitment[34]={8'h03,c[15359:15104],c[15103:14848],salt,j+34,padding};
                        h3InCommitment[35]={8'h03,c[14847:14592],c[14591:14336],salt,j+35,padding};
                        h3InCommitment[36]={8'h03,c[14335:14080],c[14079:13824],salt,j+36,padding};
                        h3InCommitment[37]={8'h03,c[13823:13568],c[13567:13312],salt,j+37,padding};
                        h3InCommitment[38]={8'h03,c[13311:13056],c[13055:12800],salt,j+38,padding};
                        h3InCommitment[39]={8'h03,c[12799:12544],c[12543:12288],salt,j+39,padding};
                        h3InCommitment[40]={8'h03,c[12287:12032],c[12031:11776],salt,j+40,padding};
                        h3InCommitment[41]={8'h03,c[11775:11520],c[11519:11264],salt,j+41,padding};
                        h3InCommitment[42]={8'h03,c[11263:11008],c[11007:10752],salt,j+42,padding};
                        h3InCommitment[43]={8'h03,c[10751:10496],c[10495:10240],salt,j+43,padding};
                        h3InCommitment[44]={8'h03,c[10239:9984],c[9983:9728],salt,j+44,padding};
                        h3InCommitment[45]={8'h03,c[9727:9472],c[9471:9216],salt,j+45,padding};
                        h3InCommitment[46]={8'h03,c[9215:8960],c[8959:8704],salt,j+46,padding};
                        h3InCommitment[47]={8'h03,c[8703:8448],c[8447:8192],salt,j+47,padding};
                        h3InCommitment[48]={8'h03,c[8191:7936],c[7935:7680],salt,j+48,padding};
                        h3InCommitment[49]={8'h03,c[7679:7424],c[7423:7168],salt,j+49,padding};
                        h3InCommitment[50]={8'h03,c[7167:6912],c[6911:6656],salt,j+50,padding};
                        h3InCommitment[51]={8'h03,c[6655:6400],c[6399:6144],salt,j+51,padding};
                        h3InCommitment[52]={8'h03,c[6143:5888],c[5887:5632],salt,j+52,padding};
                        h3InCommitment[53]={8'h03,c[5631:5376],c[5375:5120],salt,j+53,padding};
                        h3InCommitment[54]={8'h03,c[5119:4864],c[4863:4608],salt,j+54,padding};
                        h3InCommitment[55]={8'h03,c[4607:4352],c[4351:4096],salt,j+55,padding};
                        h3InCommitment[56]={8'h03,c[4095:3840],c[3839:3584],salt,j+56,padding};
                        h3InCommitment[57]={8'h03,c[3583:3328],c[3327:3072],salt,j+57,padding};
                        h3InCommitment[58]={8'h03,c[3071:2816],c[2815:2560],salt,j+58,padding};
                        h3InCommitment[59]={8'h03,c[2559:2304],c[2303:2048],salt,j+59,padding};
                        h3InCommitment[60]={8'h03,c[2047:1792],c[1791:1536],salt,j+60,padding};
                        h3InCommitment[61]={8'h03,c[1535:1280],c[1279:1024],salt,j+61,padding};
                        h3InCommitment[62]={8'h03,c[1023:768],c[767:512],salt,j+62,padding};
                        h3InCommitment[63]={8'h03,c[511:256],c[255:0],salt,j+63,padding};
                    end
                end
                
            end
            if(state==1) begin
                if(en_end==start_marsk[counter]) begin
                    counter<=counter+1;
                    Hstart<=0;
                    j<=j>>1;
                    if(en_end == start_marsk[6]) begin
                        state<=2;
                    end
                    else begin
                        state<=0;
                    end                        
                    h3InCommitment[0]<={8'h03,hashValue[0],hashValue[1],salt,j+0,padding};
                    h3InCommitment[1]<={8'h03,hashValue[2],hashValue[3],salt,j+1,padding};
                    h3InCommitment[2]<={8'h03,hashValue[4],hashValue[5],salt,j+2,padding};
                    h3InCommitment[3]<={8'h03,hashValue[6],hashValue[7],salt,j+3,padding};
                    h3InCommitment[4]<={8'h03,hashValue[8],hashValue[9],salt,j+4,padding};
                    h3InCommitment[5]<={8'h03,hashValue[10],hashValue[11],salt,j+5,padding};
                    h3InCommitment[6]<={8'h03,hashValue[12],hashValue[13],salt,j+6,padding};
                    h3InCommitment[7]<={8'h03,hashValue[14],hashValue[15],salt,j+7,padding};
                    h3InCommitment[8]<={8'h03,hashValue[16],hashValue[17],salt,j+8,padding};
                    h3InCommitment[9]<={8'h03,hashValue[18],hashValue[19],salt,j+9,padding};
                    h3InCommitment[10]<={8'h03,hashValue[20],hashValue[21],salt,j+10,padding};
                    h3InCommitment[11]<={8'h03,hashValue[22],hashValue[23],salt,j+11,padding};
                    h3InCommitment[12]<={8'h03,hashValue[24],hashValue[25],salt,j+12,padding};
                    h3InCommitment[13]<={8'h03,hashValue[26],hashValue[27],salt,j+13,padding};
                    h3InCommitment[14]<={8'h03,hashValue[28],hashValue[29],salt,j+14,padding};
                    h3InCommitment[15]<={8'h03,hashValue[30],hashValue[31],salt,j+15,padding};
                    h3InCommitment[16]<={8'h03,hashValue[32],hashValue[33],salt,j+16,padding};
                    h3InCommitment[17]<={8'h03,hashValue[34],hashValue[35],salt,j+17,padding};
                    h3InCommitment[18]<={8'h03,hashValue[36],hashValue[37],salt,j+18,padding};
                    h3InCommitment[19]<={8'h03,hashValue[38],hashValue[39],salt,j+19,padding};
                    h3InCommitment[20]<={8'h03,hashValue[40],hashValue[41],salt,j+20,padding};
                    h3InCommitment[21]<={8'h03,hashValue[42],hashValue[43],salt,j+21,padding};
                    h3InCommitment[22]<={8'h03,hashValue[44],hashValue[45],salt,j+22,padding};
                    h3InCommitment[23]<={8'h03,hashValue[46],hashValue[47],salt,j+23,padding};
                    h3InCommitment[24]<={8'h03,hashValue[48],hashValue[49],salt,j+24,padding};
                    h3InCommitment[25]<={8'h03,hashValue[50],hashValue[51],salt,j+25,padding};
                    h3InCommitment[26]<={8'h03,hashValue[52],hashValue[53],salt,j+26,padding};
                    h3InCommitment[27]<={8'h03,hashValue[54],hashValue[55],salt,j+27,padding};
                    h3InCommitment[28]<={8'h03,hashValue[56],hashValue[57],salt,j+28,padding};
                    h3InCommitment[29]<={8'h03,hashValue[58],hashValue[59],salt,j+29,padding};
                    h3InCommitment[30]<={8'h03,hashValue[60],hashValue[61],salt,j+30,padding};
                    h3InCommitment[31]<={8'h03,hashValue[62],hashValue[63],salt,j+31,padding};
                end               
            end
            if(state==2) begin
                tree_set_end<=1;
                state <= 3;
                commitment<=hashValue[0];
            end
            if(state==3) begin
                tree_set_end <= 0;
                state<=0;
            end
        end

    end
    H_for_m_tree h0(clk,reset,h3InCommitment[0],Hstart[0],hashValue[0],en_end[0]);
    H_for_m_tree h1(clk,reset,h3InCommitment[1],Hstart[1],hashValue[1],en_end[1]);
    H_for_m_tree h2(clk,reset,h3InCommitment[2],Hstart[2],hashValue[2],en_end[2]);
    H_for_m_tree h3(clk,reset,h3InCommitment[3],Hstart[3],hashValue[3],en_end[3]);
    H_for_m_tree h4(clk,reset,h3InCommitment[4],Hstart[4],hashValue[4],en_end[4]);
    H_for_m_tree h5(clk,reset,h3InCommitment[5],Hstart[5],hashValue[5],en_end[5]);
    H_for_m_tree h6(clk,reset,h3InCommitment[6],Hstart[6],hashValue[6],en_end[6]);
    H_for_m_tree h7(clk,reset,h3InCommitment[7],Hstart[7],hashValue[7],en_end[7]);
    H_for_m_tree h8(clk,reset,h3InCommitment[8],Hstart[8],hashValue[8],en_end[8]);
    H_for_m_tree h9(clk,reset,h3InCommitment[9],Hstart[9],hashValue[9],en_end[9]);
    H_for_m_tree h10(clk,reset,h3InCommitment[10],Hstart[10],hashValue[10],en_end[10]);
    H_for_m_tree h11(clk,reset,h3InCommitment[11],Hstart[11],hashValue[11],en_end[11]);
    H_for_m_tree h12(clk,reset,h3InCommitment[12],Hstart[12],hashValue[12],en_end[12]);
    H_for_m_tree h13(clk,reset,h3InCommitment[13],Hstart[13],hashValue[13],en_end[13]);
    H_for_m_tree h14(clk,reset,h3InCommitment[14],Hstart[14],hashValue[14],en_end[14]);
    H_for_m_tree h15(clk,reset,h3InCommitment[15],Hstart[15],hashValue[15],en_end[15]);
    H_for_m_tree h16(clk,reset,h3InCommitment[16],Hstart[16],hashValue[16],en_end[16]);
    H_for_m_tree h17(clk,reset,h3InCommitment[17],Hstart[17],hashValue[17],en_end[17]);
    H_for_m_tree h18(clk,reset,h3InCommitment[18],Hstart[18],hashValue[18],en_end[18]);
    H_for_m_tree h19(clk,reset,h3InCommitment[19],Hstart[19],hashValue[19],en_end[19]);
    H_for_m_tree h20(clk,reset,h3InCommitment[20],Hstart[20],hashValue[20],en_end[20]);
    H_for_m_tree h21(clk,reset,h3InCommitment[21],Hstart[21],hashValue[21],en_end[21]);
    H_for_m_tree h22(clk,reset,h3InCommitment[22],Hstart[22],hashValue[22],en_end[22]);
    H_for_m_tree h23(clk,reset,h3InCommitment[23],Hstart[23],hashValue[23],en_end[23]);
    H_for_m_tree h24(clk,reset,h3InCommitment[24],Hstart[24],hashValue[24],en_end[24]);
    H_for_m_tree h25(clk,reset,h3InCommitment[25],Hstart[25],hashValue[25],en_end[25]);
    H_for_m_tree h26(clk,reset,h3InCommitment[26],Hstart[26],hashValue[26],en_end[26]);
    H_for_m_tree h27(clk,reset,h3InCommitment[27],Hstart[27],hashValue[27],en_end[27]);
    H_for_m_tree h28(clk,reset,h3InCommitment[28],Hstart[28],hashValue[28],en_end[28]);
    H_for_m_tree h29(clk,reset,h3InCommitment[29],Hstart[29],hashValue[29],en_end[29]);
    H_for_m_tree h30(clk,reset,h3InCommitment[30],Hstart[30],hashValue[30],en_end[30]);
    H_for_m_tree h31(clk,reset,h3InCommitment[31],Hstart[31],hashValue[31],en_end[31]);
    H_for_m_tree h32(clk,reset,h3InCommitment[32],Hstart[32],hashValue[32],en_end[32]);
    H_for_m_tree h33(clk,reset,h3InCommitment[33],Hstart[33],hashValue[33],en_end[33]);
    H_for_m_tree h34(clk,reset,h3InCommitment[34],Hstart[34],hashValue[34],en_end[34]);
    H_for_m_tree h35(clk,reset,h3InCommitment[35],Hstart[35],hashValue[35],en_end[35]);
    H_for_m_tree h36(clk,reset,h3InCommitment[36],Hstart[36],hashValue[36],en_end[36]);
    H_for_m_tree h37(clk,reset,h3InCommitment[37],Hstart[37],hashValue[37],en_end[37]);
    H_for_m_tree h38(clk,reset,h3InCommitment[38],Hstart[38],hashValue[38],en_end[38]);
    H_for_m_tree h39(clk,reset,h3InCommitment[39],Hstart[39],hashValue[39],en_end[39]);
    H_for_m_tree h40(clk,reset,h3InCommitment[40],Hstart[40],hashValue[40],en_end[40]);
    H_for_m_tree h41(clk,reset,h3InCommitment[41],Hstart[41],hashValue[41],en_end[41]);
    H_for_m_tree h42(clk,reset,h3InCommitment[42],Hstart[42],hashValue[42],en_end[42]);
    H_for_m_tree h43(clk,reset,h3InCommitment[43],Hstart[43],hashValue[43],en_end[43]);
    H_for_m_tree h44(clk,reset,h3InCommitment[44],Hstart[44],hashValue[44],en_end[44]);
    H_for_m_tree h45(clk,reset,h3InCommitment[45],Hstart[45],hashValue[45],en_end[45]);
    H_for_m_tree h46(clk,reset,h3InCommitment[46],Hstart[46],hashValue[46],en_end[46]);
    H_for_m_tree h47(clk,reset,h3InCommitment[47],Hstart[47],hashValue[47],en_end[47]);
    H_for_m_tree h48(clk,reset,h3InCommitment[48],Hstart[48],hashValue[48],en_end[48]);
    H_for_m_tree h49(clk,reset,h3InCommitment[49],Hstart[49],hashValue[49],en_end[49]);
    H_for_m_tree h50(clk,reset,h3InCommitment[50],Hstart[50],hashValue[50],en_end[50]);
    H_for_m_tree h51(clk,reset,h3InCommitment[51],Hstart[51],hashValue[51],en_end[51]);
    H_for_m_tree h52(clk,reset,h3InCommitment[52],Hstart[52],hashValue[52],en_end[52]);
    H_for_m_tree h53(clk,reset,h3InCommitment[53],Hstart[53],hashValue[53],en_end[53]);
    H_for_m_tree h54(clk,reset,h3InCommitment[54],Hstart[54],hashValue[54],en_end[54]);
    H_for_m_tree h55(clk,reset,h3InCommitment[55],Hstart[55],hashValue[55],en_end[55]);
    H_for_m_tree h56(clk,reset,h3InCommitment[56],Hstart[56],hashValue[56],en_end[56]);
    H_for_m_tree h57(clk,reset,h3InCommitment[57],Hstart[57],hashValue[57],en_end[57]);
    H_for_m_tree h58(clk,reset,h3InCommitment[58],Hstart[58],hashValue[58],en_end[58]);
    H_for_m_tree h59(clk,reset,h3InCommitment[59],Hstart[59],hashValue[59],en_end[59]);
    H_for_m_tree h60(clk,reset,h3InCommitment[60],Hstart[60],hashValue[60],en_end[60]);
    H_for_m_tree h61(clk,reset,h3InCommitment[61],Hstart[61],hashValue[61],en_end[61]);
    H_for_m_tree h62(clk,reset,h3InCommitment[62],Hstart[62],hashValue[62],en_end[62]);
    H_for_m_tree h63(clk,reset,h3InCommitment[63],Hstart[63],hashValue[63],en_end[63]);
endmodule