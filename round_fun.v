`define TapesLength 16*2295
module stap4(
    input clk,
    input reset,
    input stap4_start,
    input [127:0] iseed,
    input[255:0] salt,
    input[7:0] t,
    input[127:0] sk,
    output reg [127:0] masked_key,
    output reg [255:0] Ch,
    output reg [255:0] Cv,
    output reg stap4_end
    );
   // wire [`TapesLength-1:0] tapes;
   // wire pos=11'b00000000010;
   // wire [`TapesLength-1:0] updated_tapes;
    wire [69631:0] aux=0;
    wire [4095:0] C;
    //wire [253:0] 
    wire [127:0] mpc_inputs=127'h1;
    wire [36863:0]msgs=0;
    wire [255:0]hashValue1;
    wire [255:0]hashValue2;

    wire set_tapes_end;
    wire tree_set_end;
    reg ca_end;
    reg mpc_end;
    wire com_end;
    wire en_end1;
    wire en_end2;

    wire [2047:0] seed;
    reg [10:0] state;

    reg tree_start;
    reg ca_start;
    reg set_tapes_start;
    reg mpc_start;
    reg com_start;
    reg Hstart1;
    reg Hstart2;

    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            state<=0;
            masked_key<=128'h1;
            Ch<=0;
            Cv<=0;
            tree_start<=0;
            ca_start<=0;
            set_tapes_start<=0;
            mpc_start<=0;
            com_start<=0;
            Hstart1<=0;
            Hstart2<=0;
            stap4_end<=0;

        end
        else begin
            if(~stap4_start) begin
                stap4_end<=0;
            end
            else if(state==0 && stap4_start)begin
                if (stap4_end==0) begin
                    state<=1;
                end
            end
            else if(state==1) begin
                tree_start<=1;
                if(tree_set_end) begin
                    tree_start<=0;
                    state<=3;
                end
            end
            else if(state==2) begin
                set_tapes_start<=1;
                if(set_tapes_end) begin
                    set_tapes_start<=0;
                    state<=3;
                end
            end
            else if(state==3) begin
                ca_start<=1;
                ca_end<=1;
                if(ca_end) begin
                    ca_start<=0;
                    ca_end<=0;
                    masked_key<=sk^mpc_inputs;
                    state<=4;
                end
            end
            else if(state==4) begin
                com_start<=1;
                if(com_end) begin
                    com_start<=0;
                    state<=5;
                end
            end
            else if(state==5) begin
                mpc_start<=1;
                mpc_end<=1;
                if(mpc_end) begin
                    mpc_start<=0;
                    mpc_end<=0;
                    masked_key<=sk^mpc_inputs;
                    state<=6;
                end
            end
            else if(state==6) begin
                Hstart1<=1;
                if(en_end1) begin
                    Hstart1<=0;
                    Ch<=hashValue1;
                    state<=7;
                end
            end
            else if(state==7) begin
                Hstart2<=1;
                if(en_end2) begin
                    Hstart2<=0;
                    Cv<=hashValue2;
                    state<=8;
                end
            end
            else if(state==8) begin
                stap4_end<=1;
                state=0;
            end
        end
    end
seed_tree_for_stap4 seedt(clk,reset,iseed,salt,t,tree_start,seed,tree_set_end);
//set_tapes st(clk,reset,seed,salt,t,set_tapes_start,tapes,set_tapes_end);
//compute_aux ca(tapes,pos,clk,reset,ca_start,mpc_inputs,updated_tapes,aux,ca_end);
commitment co(clk,reset, seed,aux,salt,t,com_start,com_end,C);
//mpc_simulate mpc(clk,reset,mpc_start,masked_key,
H_for_Ch HH1(clk,reset,C,Hstart1,hashValue1,en_end1);
H_for_Cv HH2(clk,reset,masked_key,msgs,Hstart2,hashValue2,en_end2);

endmodule