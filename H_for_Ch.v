module H_for_Ch(
    input clk,
    input reset,
    input [4095:0] C,
    input Hstart,
    output [255:0] hashValue,
    output reg en_end
    );
    reg[0:4] state;
    reg cf_start;
    wire cf_end;
    reg [255:0] iv;
    reg [7:0]counter;

    wire [4607:0]hashin={C,8'h80,440'h0,64'd4096};
    wire [511:0]hashin2[9:0];
    assign{hashin2[0],hashin2[1],hashin2[2],hashin2[3],hashin2[4],hashin2[5],hashin2[6],hashin2[7],hashin2[8]}=hashin;
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
                    if(counter==9) begin
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