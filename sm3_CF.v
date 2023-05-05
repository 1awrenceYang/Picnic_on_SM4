module sm3_CF (
    input clk,
    input rst_n,
    input cf_start,
    input [255:0] V1,
    input [511:0] msg_block,
    output reg [255:0] V2,
    output reg  cf_end
);

reg[9:0] state;

reg [31:0] w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15;


wire [31:0] tmp0 = w0^w7^{w13[16:0],w13[31:17]};
wire [31:0] tmp1 = tmp0^{tmp0[16:0],tmp0[31:17]}^{tmp0[8:0],tmp0[31:9]};
wire [31:0] w16 = tmp1^{w3[24:0],w3[31:25]}^w10;

wire [31:0] wj0 = w0;
wire [31:0] wj1 = w0^w4;

reg [6:0] j;

reg [255:0] VV1;


wire [255:0] VV2;


always @(posedge clk,negedge rst_n)begin
    if(~rst_n) begin
        state<=10'd0;
        j<=6'd0;
        V2<=256'h0;
        cf_end<=0;
        {w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15}<=512'd0;
    end
    else begin
        if(cf_start==0) begin
            cf_end<=0;
            state<=10'd0;
        end
        else if(cf_start==1 && state==10'd0) begin
            j<=6'd0;
            VV1<=V1;
            {w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15}<=msg_block;
            state<=10'd1;
        end
        else if(state==10'd1) begin
            VV1<=VV2;
            j<=j+1;
            {w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15}<={w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16};
            if(j==64) begin
                V2<=VV1^V1;
                cf_end<=1;
                state<=10'd0;
            end
        end
    end
end



msg_compression mc(j,VV1,wj0,wj1,VV2);

endmodule



module msg_compression (
    input [6:0] j,
    input [255:0] VV1,
    input [31:0] wj0,
    input [31:0] wj1,
    output [255:0] VV2
);

localparam TJ0=32'h79cc4519;
localparam TJ1=32'h7a879d8a;

wire [31:0] A,B,C,D,E,F,G,H;
wire [31:0] A2,B2,C2,D2,E2,F2,G2,H2;


wire j_less16 = (j<=6'd15);


wire [31:0] FFj=j_less16?(A^B^C):((A&B)|(A&C)|(B&C));
wire [31:0] GGj=j_less16?(E^F^G):((E&F)|(~E&G));

wire [31:0] s0,c0,s1,c1,s2,c2,s3,c3;


wire [4:0]J=j[4:0];


//SS1
wire [31:0] Tj=j_less16?TJ0:TJ1;
wire [31:0] Tj_shift=((Tj<<J)^(Tj>>(32-J)));
wire [31:0] ss0={A[19:0],A[31:20]}^E^Tj_shift;
wire [31:0] cc0=(({A[19:0],A[31:20]}&E)|({A[19:0],A[31:20]}&Tj_shift)|(E&Tj_shift))<<1;
wire [31:0] tmp_for_ss1=ss0+cc0;
wire [31:0] SS1={tmp_for_ss1[24:0],tmp_for_ss1[31:25]};

//SS2
wire [31:0] SS2=SS1^{A[19:0],A[31:20]};

assign s0=FFj^D^SS2;
assign c0=((FFj&D)|(FFj&SS2)|(D&SS2))<<1;
assign s1=s0^c0^wj1;
assign c1=((s0&c0)|(s0&wj1)|(c0&wj1))<<1;
assign s2=GGj^H^SS1;
assign c2=((GGj&H)|(GGj&SS1)|(H&SS1))<<1;
assign s3=s2^c2^wj0;
assign c3=((s2&c2)|(s2&wj0)|(c2&wj0))<<1;


//TT1
wire [31:0] TT1=s1+c1;

//TT2
wire [31:0] TT2=s3+c3;

assign {A,B,C,D,E,F,G,H}=VV1;

assign {A2,B2,C2,D2,E2,F2,G2,H2}={
        TT1,A,{B[22:0],B[31:23]},C,
        TT2^{TT2[22:0],TT2[31:23]}^{TT2[14:0],TT2[31:15]},
        E,{F[12:0],F[31:13]},G
        }; 

assign VV2={A2,B2,C2,D2,E2,F2,G2,H2};

endmodule