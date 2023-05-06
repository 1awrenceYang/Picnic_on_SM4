`timescale 1ns / 1ps
module HCP(
    input clk,
    input reset,
    input [308223:0]Ch,
    input [511:0]Cv_root,
    input [255:0]salt,
    input [511:0]pk,
    input [51199:0]M,
    input HCP_start,
    output reg HCP_end,
    output reg[68*10-1:0] Lc,
    output reg[68*5-1:0] Lp
    );
    wire[511:0] hashValue;
    wire[511:0] hashValue2;
    reg lc_ok;
    reg helloworld;
    wire[290*1088-1:0] d={Ch,Cv_root,salt,pk,M,8'h1f,880'h0,8'h80};
    //wire[1087:0] h1={hashValue,8'h06,560'h0,8'h80};
    reg one_hash_ok;
    wire[1087:0] h=~helloworld?{hashValue,8'h1f,560'h0,8'h80}:{hashValue2,8'h1f,560'h0,8'h80};
   // wire[1087:0] h=~helloworld?h1:h2;
    reg Hstart;
    reg restart;
    reg Hstart2;
    reg restart2;
    reg[511:0] hhhh;
    wire en_end;
    wire en_end2;
    reg[4:0] state;
    reg[6:0] index;
    reg[6:0] index_Lc;
    reg[7:0] index_Lp;
    wire[11:0] Lc_index=(68-index)*10-1;
    wire[11:0] Lp_index=(68-index)*5-1;
    wire[9:0] Lc_temp =hhhh[511-index_Lc*10-:10];
    wire[4:0] Lp_temp =hhhh[511-index_Lp*5-:5];
    wire[68*10-1:0] Lc_temp2 ={68{Lc_temp}}^Lc;
    wire Lc_temp3 = (Lc_temp2[0] | Lc_temp2[1] | Lc_temp2[2] | Lc_temp2[3] | Lc_temp2[4] | Lc_temp2[5] | Lc_temp2[6] | Lc_temp2[7] | Lc_temp2[8] | Lc_temp2[9]) &
                    (Lc_temp2[10] | Lc_temp2[11] | Lc_temp2[12] | Lc_temp2[13] | Lc_temp2[14] | Lc_temp2[15] | Lc_temp2[16] | Lc_temp2[17] | Lc_temp2[18] | Lc_temp2[19]) &
                    (Lc_temp2[20] | Lc_temp2[21] | Lc_temp2[22] | Lc_temp2[23] | Lc_temp2[24] | Lc_temp2[25] | Lc_temp2[26] | Lc_temp2[27] | Lc_temp2[28] | Lc_temp2[29]) &
                    (Lc_temp2[30] | Lc_temp2[31] | Lc_temp2[32] | Lc_temp2[33] | Lc_temp2[34] | Lc_temp2[35] | Lc_temp2[36] | Lc_temp2[37] | Lc_temp2[38] | Lc_temp2[39]) &
                    (Lc_temp2[40] | Lc_temp2[41] | Lc_temp2[42] | Lc_temp2[43] | Lc_temp2[44] | Lc_temp2[45] | Lc_temp2[46] | Lc_temp2[47] | Lc_temp2[48] | Lc_temp2[49]) &
                    (Lc_temp2[50] | Lc_temp2[51] | Lc_temp2[52] | Lc_temp2[53] | Lc_temp2[54] | Lc_temp2[55] | Lc_temp2[56] | Lc_temp2[57] | Lc_temp2[58] | Lc_temp2[59]) &
                    (Lc_temp2[60] | Lc_temp2[61] | Lc_temp2[62] | Lc_temp2[63] | Lc_temp2[64] | Lc_temp2[65] | Lc_temp2[66] | Lc_temp2[67] | Lc_temp2[68] | Lc_temp2[69]) &
                    (Lc_temp2[70] | Lc_temp2[71] | Lc_temp2[72] | Lc_temp2[73] | Lc_temp2[74] | Lc_temp2[75] | Lc_temp2[76] | Lc_temp2[77] | Lc_temp2[78] | Lc_temp2[79]) &
                    (Lc_temp2[80] | Lc_temp2[81] | Lc_temp2[82] | Lc_temp2[83] | Lc_temp2[84] | Lc_temp2[85] | Lc_temp2[86] | Lc_temp2[87] | Lc_temp2[88] | Lc_temp2[89]) &
                    (Lc_temp2[90] | Lc_temp2[91] | Lc_temp2[92] | Lc_temp2[93] | Lc_temp2[94] | Lc_temp2[95] | Lc_temp2[96] | Lc_temp2[97] | Lc_temp2[98] | Lc_temp2[99]) &
                    (Lc_temp2[100] | Lc_temp2[101] | Lc_temp2[102] | Lc_temp2[103] | Lc_temp2[104] | Lc_temp2[105] | Lc_temp2[106] | Lc_temp2[107] | Lc_temp2[108] | Lc_temp2[109]) &
                    (Lc_temp2[110] | Lc_temp2[111] | Lc_temp2[112] | Lc_temp2[113] | Lc_temp2[114] | Lc_temp2[115] | Lc_temp2[116] | Lc_temp2[117] | Lc_temp2[118] | Lc_temp2[119]) &
                    (Lc_temp2[120] | Lc_temp2[121] | Lc_temp2[122] | Lc_temp2[123] | Lc_temp2[124] | Lc_temp2[125] | Lc_temp2[126] | Lc_temp2[127] | Lc_temp2[128] | Lc_temp2[129]) &
                    (Lc_temp2[130] | Lc_temp2[131] | Lc_temp2[132] | Lc_temp2[133] | Lc_temp2[134] | Lc_temp2[135] | Lc_temp2[136] | Lc_temp2[137] | Lc_temp2[138] | Lc_temp2[139]) &
                    (Lc_temp2[140] | Lc_temp2[141] | Lc_temp2[142] | Lc_temp2[143] | Lc_temp2[144] | Lc_temp2[145] | Lc_temp2[146] | Lc_temp2[147] | Lc_temp2[148] | Lc_temp2[149]) &
                    (Lc_temp2[150] | Lc_temp2[151] | Lc_temp2[152] | Lc_temp2[153] | Lc_temp2[154] | Lc_temp2[155] | Lc_temp2[156] | Lc_temp2[157] | Lc_temp2[158] | Lc_temp2[159]) &
                    (Lc_temp2[160] | Lc_temp2[161] | Lc_temp2[162] | Lc_temp2[163] | Lc_temp2[164] | Lc_temp2[165] | Lc_temp2[166] | Lc_temp2[167] | Lc_temp2[168] | Lc_temp2[169]) &
                    (Lc_temp2[170] | Lc_temp2[171] | Lc_temp2[172] | Lc_temp2[173] | Lc_temp2[174] | Lc_temp2[175] | Lc_temp2[176] | Lc_temp2[177] | Lc_temp2[178] | Lc_temp2[179]) &
                    (Lc_temp2[180] | Lc_temp2[181] | Lc_temp2[182] | Lc_temp2[183] | Lc_temp2[184] | Lc_temp2[185] | Lc_temp2[186] | Lc_temp2[187] | Lc_temp2[188] | Lc_temp2[189]) &
                    (Lc_temp2[190] | Lc_temp2[191] | Lc_temp2[192] | Lc_temp2[193] | Lc_temp2[194] | Lc_temp2[195] | Lc_temp2[196] | Lc_temp2[197] | Lc_temp2[198] | Lc_temp2[199]) &
                    (Lc_temp2[200] | Lc_temp2[201] | Lc_temp2[202] | Lc_temp2[203] | Lc_temp2[204] | Lc_temp2[205] | Lc_temp2[206] | Lc_temp2[207] | Lc_temp2[208] | Lc_temp2[209]) &
                    (Lc_temp2[210] | Lc_temp2[211] | Lc_temp2[212] | Lc_temp2[213] | Lc_temp2[214] | Lc_temp2[215] | Lc_temp2[216] | Lc_temp2[217] | Lc_temp2[218] | Lc_temp2[219]) &
                    (Lc_temp2[220] | Lc_temp2[221] | Lc_temp2[222] | Lc_temp2[223] | Lc_temp2[224] | Lc_temp2[225] | Lc_temp2[226] | Lc_temp2[227] | Lc_temp2[228] | Lc_temp2[229]) &
                    (Lc_temp2[230] | Lc_temp2[231] | Lc_temp2[232] | Lc_temp2[233] | Lc_temp2[234] | Lc_temp2[235] | Lc_temp2[236] | Lc_temp2[237] | Lc_temp2[238] | Lc_temp2[239]) &
                    (Lc_temp2[240] | Lc_temp2[241] | Lc_temp2[242] | Lc_temp2[243] | Lc_temp2[244] | Lc_temp2[245] | Lc_temp2[246] | Lc_temp2[247] | Lc_temp2[248] | Lc_temp2[249]) &
                    (Lc_temp2[250] | Lc_temp2[251] | Lc_temp2[252] | Lc_temp2[253] | Lc_temp2[254] | Lc_temp2[255] | Lc_temp2[256] | Lc_temp2[257] | Lc_temp2[258] | Lc_temp2[259]) &
                    (Lc_temp2[260] | Lc_temp2[261] | Lc_temp2[262] | Lc_temp2[263] | Lc_temp2[264] | Lc_temp2[265] | Lc_temp2[266] | Lc_temp2[267] | Lc_temp2[268] | Lc_temp2[269]) &
                    (Lc_temp2[270] | Lc_temp2[271] | Lc_temp2[272] | Lc_temp2[273] | Lc_temp2[274] | Lc_temp2[275] | Lc_temp2[276] | Lc_temp2[277] | Lc_temp2[278] | Lc_temp2[279]) &
                    (Lc_temp2[280] | Lc_temp2[281] | Lc_temp2[282] | Lc_temp2[283] | Lc_temp2[284] | Lc_temp2[285] | Lc_temp2[286] | Lc_temp2[287] | Lc_temp2[288] | Lc_temp2[289]) &
                    (Lc_temp2[290] | Lc_temp2[291] | Lc_temp2[292] | Lc_temp2[293] | Lc_temp2[294] | Lc_temp2[295] | Lc_temp2[296] | Lc_temp2[297] | Lc_temp2[298] | Lc_temp2[299]) &
                    (Lc_temp2[300] | Lc_temp2[301] | Lc_temp2[302] | Lc_temp2[303] | Lc_temp2[304] | Lc_temp2[305] | Lc_temp2[306] | Lc_temp2[307] | Lc_temp2[308] | Lc_temp2[309]) &
                    (Lc_temp2[310] | Lc_temp2[311] | Lc_temp2[312] | Lc_temp2[313] | Lc_temp2[314] | Lc_temp2[315] | Lc_temp2[316] | Lc_temp2[317] | Lc_temp2[318] | Lc_temp2[319]) &
                    (Lc_temp2[320] | Lc_temp2[321] | Lc_temp2[322] | Lc_temp2[323] | Lc_temp2[324] | Lc_temp2[325] | Lc_temp2[326] | Lc_temp2[327] | Lc_temp2[328] | Lc_temp2[329]) &
                    (Lc_temp2[330] | Lc_temp2[331] | Lc_temp2[332] | Lc_temp2[333] | Lc_temp2[334] | Lc_temp2[335] | Lc_temp2[336] | Lc_temp2[337] | Lc_temp2[338] | Lc_temp2[339]) &
                    (Lc_temp2[340] | Lc_temp2[341] | Lc_temp2[342] | Lc_temp2[343] | Lc_temp2[344] | Lc_temp2[345] | Lc_temp2[346] | Lc_temp2[347] | Lc_temp2[348] | Lc_temp2[349]) &
                    (Lc_temp2[350] | Lc_temp2[351] | Lc_temp2[352] | Lc_temp2[353] | Lc_temp2[354] | Lc_temp2[355] | Lc_temp2[356] | Lc_temp2[357] | Lc_temp2[358] | Lc_temp2[359]) &
                    (Lc_temp2[360] | Lc_temp2[361] | Lc_temp2[362] | Lc_temp2[363] | Lc_temp2[364] | Lc_temp2[365] | Lc_temp2[366] | Lc_temp2[367] | Lc_temp2[368] | Lc_temp2[369]) &
                    (Lc_temp2[370] | Lc_temp2[371] | Lc_temp2[372] | Lc_temp2[373] | Lc_temp2[374] | Lc_temp2[375] | Lc_temp2[376] | Lc_temp2[377] | Lc_temp2[378] | Lc_temp2[379]) &
                    (Lc_temp2[380] | Lc_temp2[381] | Lc_temp2[382] | Lc_temp2[383] | Lc_temp2[384] | Lc_temp2[385] | Lc_temp2[386] | Lc_temp2[387] | Lc_temp2[388] | Lc_temp2[389]) &
                    (Lc_temp2[390] | Lc_temp2[391] | Lc_temp2[392] | Lc_temp2[393] | Lc_temp2[394] | Lc_temp2[395] | Lc_temp2[396] | Lc_temp2[397] | Lc_temp2[398] | Lc_temp2[399]) &
                    (Lc_temp2[400] | Lc_temp2[401] | Lc_temp2[402] | Lc_temp2[403] | Lc_temp2[404] | Lc_temp2[405] | Lc_temp2[406] | Lc_temp2[407] | Lc_temp2[408] | Lc_temp2[409]) &
                    (Lc_temp2[410] | Lc_temp2[411] | Lc_temp2[412] | Lc_temp2[413] | Lc_temp2[414] | Lc_temp2[415] | Lc_temp2[416] | Lc_temp2[417] | Lc_temp2[418] | Lc_temp2[419]) &
                    (Lc_temp2[420] | Lc_temp2[421] | Lc_temp2[422] | Lc_temp2[423] | Lc_temp2[424] | Lc_temp2[425] | Lc_temp2[426] | Lc_temp2[427] | Lc_temp2[428] | Lc_temp2[429]) &
                    (Lc_temp2[430] | Lc_temp2[431] | Lc_temp2[432] | Lc_temp2[433] | Lc_temp2[434] | Lc_temp2[435] | Lc_temp2[436] | Lc_temp2[437] | Lc_temp2[438] | Lc_temp2[439]) &
                    (Lc_temp2[440] | Lc_temp2[441] | Lc_temp2[442] | Lc_temp2[443] | Lc_temp2[444] | Lc_temp2[445] | Lc_temp2[446] | Lc_temp2[447] | Lc_temp2[448] | Lc_temp2[449]) &
                    (Lc_temp2[450] | Lc_temp2[451] | Lc_temp2[452] | Lc_temp2[453] | Lc_temp2[454] | Lc_temp2[455] | Lc_temp2[456] | Lc_temp2[457] | Lc_temp2[458] | Lc_temp2[459]) &
                    (Lc_temp2[460] | Lc_temp2[461] | Lc_temp2[462] | Lc_temp2[463] | Lc_temp2[464] | Lc_temp2[465] | Lc_temp2[466] | Lc_temp2[467] | Lc_temp2[468] | Lc_temp2[469]) &
                    (Lc_temp2[470] | Lc_temp2[471] | Lc_temp2[472] | Lc_temp2[473] | Lc_temp2[474] | Lc_temp2[475] | Lc_temp2[476] | Lc_temp2[477] | Lc_temp2[478] | Lc_temp2[479]) &
                    (Lc_temp2[480] | Lc_temp2[481] | Lc_temp2[482] | Lc_temp2[483] | Lc_temp2[484] | Lc_temp2[485] | Lc_temp2[486] | Lc_temp2[487] | Lc_temp2[488] | Lc_temp2[489]) &
                    (Lc_temp2[490] | Lc_temp2[491] | Lc_temp2[492] | Lc_temp2[493] | Lc_temp2[494] | Lc_temp2[495] | Lc_temp2[496] | Lc_temp2[497] | Lc_temp2[498] | Lc_temp2[499]) &
                    (Lc_temp2[500] | Lc_temp2[501] | Lc_temp2[502] | Lc_temp2[503] | Lc_temp2[504] | Lc_temp2[505] | Lc_temp2[506] | Lc_temp2[507] | Lc_temp2[508] | Lc_temp2[509]) &
                    (Lc_temp2[510] | Lc_temp2[511] | Lc_temp2[512] | Lc_temp2[513] | Lc_temp2[514] | Lc_temp2[515] | Lc_temp2[516] | Lc_temp2[517] | Lc_temp2[518] | Lc_temp2[519]) &
                    (Lc_temp2[520] | Lc_temp2[521] | Lc_temp2[522] | Lc_temp2[523] | Lc_temp2[524] | Lc_temp2[525] | Lc_temp2[526] | Lc_temp2[527] | Lc_temp2[528] | Lc_temp2[529]) &
                    (Lc_temp2[530] | Lc_temp2[531] | Lc_temp2[532] | Lc_temp2[533] | Lc_temp2[534] | Lc_temp2[535] | Lc_temp2[536] | Lc_temp2[537] | Lc_temp2[538] | Lc_temp2[539]) &
                    (Lc_temp2[540] | Lc_temp2[541] | Lc_temp2[542] | Lc_temp2[543] | Lc_temp2[544] | Lc_temp2[545] | Lc_temp2[546] | Lc_temp2[547] | Lc_temp2[548] | Lc_temp2[549]) &
                    (Lc_temp2[550] | Lc_temp2[551] | Lc_temp2[552] | Lc_temp2[553] | Lc_temp2[554] | Lc_temp2[555] | Lc_temp2[556] | Lc_temp2[557] | Lc_temp2[558] | Lc_temp2[559]) &
                    (Lc_temp2[560] | Lc_temp2[561] | Lc_temp2[562] | Lc_temp2[563] | Lc_temp2[564] | Lc_temp2[565] | Lc_temp2[566] | Lc_temp2[567] | Lc_temp2[568] | Lc_temp2[569]) &
                    (Lc_temp2[570] | Lc_temp2[571] | Lc_temp2[572] | Lc_temp2[573] | Lc_temp2[574] | Lc_temp2[575] | Lc_temp2[576] | Lc_temp2[577] | Lc_temp2[578] | Lc_temp2[579]) &
                    (Lc_temp2[580] | Lc_temp2[581] | Lc_temp2[582] | Lc_temp2[583] | Lc_temp2[584] | Lc_temp2[585] | Lc_temp2[586] | Lc_temp2[587] | Lc_temp2[588] | Lc_temp2[589]) &
                    (Lc_temp2[590] | Lc_temp2[591] | Lc_temp2[592] | Lc_temp2[593] | Lc_temp2[594] | Lc_temp2[595] | Lc_temp2[596] | Lc_temp2[597] | Lc_temp2[598] | Lc_temp2[599]) &
                    (Lc_temp2[600] | Lc_temp2[601] | Lc_temp2[602] | Lc_temp2[603] | Lc_temp2[604] | Lc_temp2[605] | Lc_temp2[606] | Lc_temp2[607] | Lc_temp2[608] | Lc_temp2[609]) &
                    (Lc_temp2[610] | Lc_temp2[611] | Lc_temp2[612] | Lc_temp2[613] | Lc_temp2[614] | Lc_temp2[615] | Lc_temp2[616] | Lc_temp2[617] | Lc_temp2[618] | Lc_temp2[619]) &
                    (Lc_temp2[620] | Lc_temp2[621] | Lc_temp2[622] | Lc_temp2[623] | Lc_temp2[624] | Lc_temp2[625] | Lc_temp2[626] | Lc_temp2[627] | Lc_temp2[628] | Lc_temp2[629]) &
                    (Lc_temp2[630] | Lc_temp2[631] | Lc_temp2[632] | Lc_temp2[633] | Lc_temp2[634] | Lc_temp2[635] | Lc_temp2[636] | Lc_temp2[637] | Lc_temp2[638] | Lc_temp2[639]) &
                    (Lc_temp2[640] | Lc_temp2[641] | Lc_temp2[642] | Lc_temp2[643] | Lc_temp2[644] | Lc_temp2[645] | Lc_temp2[646] | Lc_temp2[647] | Lc_temp2[648] | Lc_temp2[649]) &
                    (Lc_temp2[650] | Lc_temp2[651] | Lc_temp2[652] | Lc_temp2[653] | Lc_temp2[654] | Lc_temp2[655] | Lc_temp2[656] | Lc_temp2[657] | Lc_temp2[658] | Lc_temp2[659]) &
                    (Lc_temp2[670] | Lc_temp2[671] | Lc_temp2[672] | Lc_temp2[673] | Lc_temp2[674] | Lc_temp2[675] | Lc_temp2[676] | Lc_temp2[677] | Lc_temp2[678] | Lc_temp2[679]) &
                    (Lc_temp2[660] | Lc_temp2[661] | Lc_temp2[662] | Lc_temp2[663] | Lc_temp2[664] | Lc_temp2[665] | Lc_temp2[666] | Lc_temp2[667] | Lc_temp2[668] | Lc_temp2[669]) ;
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            Hstart<=0;
            restart<=0;
            Hstart2<=0;
            restart2<=0;
            HCP_end<=0;
            state <= 0;
            index<=0;
            Lc<=0;
            Lp<=0;
            lc_ok<=0;
            one_hash_ok<=0;
            index_Lc<=0;
            index_Lp<=0;
            helloworld<=0;
        end
        else begin
            if(state==0 && HCP_start)begin
                index_Lc<=0;
                index_Lp<=0;
                if(one_hash_ok == 0) begin
                    Hstart<=1;
                    if(en_end) begin
                        restart<=1;
                        hhhh<=hashValue;
                        state<=1;
                        one_hash_ok<=1;
                    end
                end
                else begin
                    Hstart2<=1;
                    if(en_end2) begin
                        helloworld<=1;
                        restart2<=1;
                        hhhh<=hashValue2;
                        if(lc_ok==0) begin
                            state<=1;
                        end
                        else begin
                            state<=2;
                        end
                    end
                end
            end
            else if(state==0 && ~HCP_start) begin
                HCP_end<=0;
            end
            else if(state==1) begin
                Hstart<=0;
                Hstart2<=0;
                if(index_Lc<51) begin
                    if(Lc_temp3==0 || Lc_temp>=601)begin
                        index_Lc<=index_Lc+1;
                    end
                    else begin
                        Lc[Lc_index-:10]<=Lc_temp;
                        index_Lc<=index_Lc+1;
                        index<=index+1;
                    end
                    if(index == 68) begin
                        lc_ok<=1;
                        state<=0;
                        index<=0;
                    end
                end
                else begin
                    state<=0;
                end
                
            end
            else if(state==2) begin
                Hstart<=0;
                Hstart2<=0;
                if(index_Lp<102) begin
                    if(Lp_temp>=16)begin
                        index_Lp<=index_Lp+1;
                    end
                    else begin
                        Lp[Lp_index-:5]<=Lp_temp;
                        index_Lp<=index_Lp+1;
                        index<=index+1;
                    end
                    if(index == 68) begin
                        state<=3;
                        index<=0;
                    end
                end
                else begin
                    state<=0;
                end
            end
            else if(state==3) begin 
                HCP_end<=1;
                Hstart<=0;
                restart<=0;
                Hstart2<=0;
                restart2<=0;
                state <= 0;
                index<=0;
                Lc<=0;
                lc_ok<=0;
                helloworld<=0;
                one_hash_ok<=0;
            end
        end
    end

    H_for_HCP H1(clk,reset,0,d,0,Hstart,restart,290,hashValue,en_end);
    H_for_HCP H2(clk,reset,1,0,h,Hstart2,restart2,1,hashValue2,en_end2);

endmodule


module H_for_HCP(
    input clk,
    input reset,
    input mode,
    input[290*1088-1:0] d,
    input[1087:0] h,
    input Hstart,
    input restart,
    input[0:9] groupNum,
    output [511:0] hashValue,
    output reg en_end
    );
    reg[0:1] state;
    reg out_start;
    reg start;
    wire sha3_busy;
    reg[0:9] counter;
    reg[1087:0] data;
    wire[0:20] index=(counter+1)*1088-1;
    wire out_ok;
    always @(*)begin
        case(mode) 
            0: begin
                data = d[index-: 1088];
            end
            1: begin
                data = h[index-: 1088];
            end
        endcase
    end
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            counter <= 0;
            start<=0;
            out_start<=0;
            en_end<=0;
            state <= 0;
        end
        else begin
            if(state==0 && Hstart)begin
                if(restart) begin
                    en_end<=0;
                end
                if (en_end==0) begin
                    start<=1;
                    state<=1;
                end
            end
            else if(state == 1 && en_end==0) begin
                if(sha3_busy==1)begin
                    counter<=counter+1; 
                end
                if(counter==groupNum) begin
                    start<=0;
                    state <=2 ;
                    out_start<=1;
                end
            end 
            else if (state ==2) begin
                if(out_ok==1) begin
                    out_start<=0;
                    en_end<=1;
                    state <=0;
                    counter<=0;
                end
            end
        end
    end
    sha3_core sc(
    .clk_i(clk),  // system clk input
    .reset_i(reset),  // async reset active high
    .start_i(start) ,  // pulse to start hashing next msg
    .out_start_i(out_start),
    .out_ok(out_ok),
    .sha3_busy(sha3_busy),  // sha3 is ready for next msg (level signal)      
    .data_ii(data),     
    .md_data_o(hashValue)  // message digest output (256 bits)
    );
    
endmodule