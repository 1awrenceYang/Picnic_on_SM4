module H_for_HCP1(
    input clk,
    input reset,
    input [255:0] C_star,
    input [255:0] salt,
    input [127:0] pk,
    input [51199:0]M,
    input Hstart,
    output [255:0] hashValue,
    output reg en_end
    );
    reg[0:4] state;
    reg cf_start;
    wire cf_end;
    reg [255:0] iv;
    reg [7:0]counter;

    wire [52223:0]hashin={C_star,salt,pk,M,8'h80,312'h0,64'd51840};
    wire [511:0]hashin2[101:0];
    assign {hashin2[0],hashin2[1],hashin2[2],hashin2[3],hashin2[4],hashin2[5],hashin2[6],hashin2[7],hashin2[8],hashin2[9],hashin2[10],hashin2[11],hashin2[12],hashin2[13],hashin2[14],hashin2[15],hashin2[16],hashin2[17],hashin2[18],hashin2[19],hashin2[20],hashin2[21],hashin2[22],hashin2[23],hashin2[24],hashin2[25],hashin2[26],hashin2[27],hashin2[28],hashin2[29],hashin2[30],hashin2[31],hashin2[32],hashin2[33],hashin2[34],hashin2[35],hashin2[36],hashin2[37],hashin2[38],hashin2[39],hashin2[40],hashin2[41],hashin2[42],hashin2[43],hashin2[44],hashin2[45],hashin2[46],hashin2[47],hashin2[48],hashin2[49],hashin2[50],hashin2[51],hashin2[52],hashin2[53],hashin2[54],hashin2[55],hashin2[56],hashin2[57],hashin2[58],hashin2[59],hashin2[60],hashin2[61],hashin2[62],hashin2[63],hashin2[64],hashin2[65],hashin2[66],hashin2[67],hashin2[68],hashin2[69],hashin2[70],hashin2[71],hashin2[72],hashin2[73],hashin2[74],hashin2[75],hashin2[76],hashin2[77],hashin2[78],hashin2[79],hashin2[80],hashin2[81],hashin2[82],hashin2[83],hashin2[84],hashin2[85],hashin2[86],hashin2[87],hashin2[88],hashin2[89],hashin2[90],hashin2[91],hashin2[92],hashin2[93],hashin2[94],hashin2[95],hashin2[96],hashin2[97],hashin2[98],hashin2[99],hashin2[100],hashin2[101]}=hashin;
    wire [511:0] h_in;
    reg r_ok;
    
    reg [7:0] index;
    
    reg ena;
    reg wea;      
    wire [7:0] addra=r_ok==0?index:counter;  
    reg [511:0] dina;    
    always @ (*) begin
        if(~reset) begin
            dina <= 512'h0;
        end
        else begin
        dina = hashin2[index];
        end
    end

    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            cf_start<=0;
            en_end<=0;
            state <= 0;
            ena<= 0;
            wea<= 0;
            index<=8'hff;      
            r_ok<=0; 
            counter<=0;
            iv<=256'h7380166f4914b2b9172442d7da8a0600a96f30bc163138aae38dee4db0fb0e4e;
        end
        else begin
            if(~Hstart) begin
                en_end<=0;
                counter<=0;
                index<=8'hff;
                iv<=256'h7380166f4914b2b9172442d7da8a0600a96f30bc163138aae38dee4db0fb0e4e;
            end
            if(state==0&& Hstart&&en_end==0) begin
                if(index == 5) begin
                    wea<=0;
                    r_ok<=1;
                    state<=1;
                end
                else begin
                    ena<= 1;
                    wea<= 1;
                    index <= index+1;                
                end
            end
            else if(state==1)begin
                state<=2;
            end
            else if(state==2)begin
                state<=3;
            end
            else if(state==3)begin
                state<=4;
            end
            else if(state==4)begin
                state<=5;
            end
            else if(state==5)begin
                if (en_end==0) begin
                    cf_start<=1;
                    state<=6;
                    counter<=counter+1;
                end
            end
            else if(state == 6) begin
                if(cf_end) begin
                    //hashin2<=hashin2<<512;
                    cf_start<=0;
                    iv<=hashValue;
                    if(counter==101) begin
                        state<=7;
                    end
                    else begin
                        state<=1;
                    end
                end
            end 
            else if (state ==7) begin
                en_end<=1;
                state <=0; 
                counter<=0;
                r_ok<=0;
                ena<= 0;
                index<=0;
            end
        end
    end
    ram_for_H ramforH(
        .clka(clk),    // input wire clka
        .ena(ena),      // input wire ena
        .wea(wea),      // input wire [0 : 0] wea
        .addra(addra),  // input wire [7 : 0] addra
        .dina(dina),    // input wire [511 : 0] dina
        .douta(h_in)  // output wire [511 : 0] douta
    );
    
    
    sm3_CF sc(
        clk,
        reset,
        cf_start,
        iv,
        h_in,
        hashValue,
        cf_end 
    );
    


endmodule