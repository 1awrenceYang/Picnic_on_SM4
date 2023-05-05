module get_sign(
    input clk,
    input reset,
    input get_sign_start,
    input [4*5-1:0] lc,
    input [4*5-1:0] lp,
    //res1
    input [255:0] h_t_i,
    input [255:0] salt_i,
    input [128*8-1:0] seed_star_i,
    input [256*8-1:0] Cv_i,
    input [128*15*8-1:0] seed_i,
    input [512*8-1:0] aux_i, //这个你给512就行 //这个不给也行，空�?，因为是�?后一个用户的
    input [128*8-1:0] masked_key_i,  
    input [512*8-1:0] msgs_i, //同样512就行，给�?后一个用户的mag 
    input [256*8-1:0] C_i, //都给�?后一�?
    input [512*8-1:0] seed_lambda_i,
    input [1024*8-1:0] aux_triangle_i,
    input [127:0] seed_triangle_i,

    output [19708-1:0] sigma,
    output reg get_sign_end
);

    //lc
    wire [4:0] LC_list [3:0] ;
    assign {LC_list[0],LC_list[1],LC_list[2],LC_list[3]} =lc;

    //lp
    wire [4:0] LP_list [3:0] ;
    assign {LP_list[0],LP_list[1],LP_list[2],LP_list[3]} =lp;

    reg[4:0] j;

    wire j_in_LC=(j[4:0]==LC_list[0])||(j[4:0]==LC_list[1])||(j[4:0]==LC_list[2])||(j[4:0]==LC_list[3]);

    //Cv_i
    wire [255:0] Cv_list [7:0];
    assign {Cv_list[0],Cv_list[1],Cv_list[2],Cv_list[3],Cv_list[4],Cv_list[5],Cv_list[6],Cv_list[7]} =Cv_i;


    //seed_star_i
    wire [127:0] seed_star_list [7:0];
    assign {seed_star_list[0],seed_star_list[1],seed_star_list[2],seed_star_list[3],seed_star_list[4],seed_star_list[5],seed_star_list[6],seed_star_list[7]} =seed_star_i;

    //seed_i
    wire [128*15-1:0] seed_list [7:0];
    assign {seed_list[0],seed_list[1],seed_list[2],seed_list[3],seed_list[4],seed_list[5],seed_list[6],seed_list[7]} =seed_i;

    //aux_i
    wire [511:0] aux_list [7:0];
    assign {aux_list[0],aux_list[1],aux_list[2],aux_list[3],aux_list[4],aux_list[5],aux_list[6],aux_list[7]} =aux_i;

    //masked_key_i
    wire [127:0] masked_key_list [7:0];
    assign {masked_key_list[0],masked_key_list[1],masked_key_list[2],masked_key_list[3],masked_key_list[4],masked_key_list[5],masked_key_list[6],masked_key_list[7]} =masked_key_i;

    //msgs_i
    wire [511:0] msgs_list[7:0] ;
    assign {msgs_list[0],msgs_list[1],msgs_list[2],msgs_list[3],msgs_list[4],msgs_list[5],msgs_list[6],msgs_list[7]} =msgs_i;

    //msgs_i
    wire [255:0] C_list[7:0] ;
    assign {C_list[0],C_list[1],C_list[2],C_list[3],C_list[4],C_list[5],C_list[6],C_list[7]} =C_i;

    //seed_lambda
    wire [511:0] seed_lambda_list[7:0] ;
    assign {seed_lambda_list[0],seed_lambda_list[1],seed_lambda_list[2],seed_lambda_list[3],seed_lambda_list[4],seed_lambda_list[5],seed_lambda_list[6],seed_lambda_list[7]} =seed_lambda_i;

    //aux_triangle_i;
    wire [1023:0]aux_triangle_list[7:0];
    assign {aux_triangle_list[0],aux_triangle_list[1],aux_triangle_list[2],aux_triangle_list[3],aux_triangle_list[4],aux_triangle_list[5],aux_triangle_list[6],aux_triangle_list[7]} =aux_triangle_i;


    reg [127:0] iSeedInfo_list[3:0];
    reg [255:0] cvInfo_list[3:0];
    reg [4863:0] Z[3:0];
    
    reg [4:0] state;

    reg[4:0] counter1;
    reg[4:0] counter2;

//    wire[6271:0] sigma;
    assign sigma={h_t_i,salt_i,iSeedInfo_list[0],iSeedInfo_list[1],iSeedInfo_list[2],iSeedInfo_list[3],cvInfo_list[0],cvInfo_list[1],cvInfo_list[2],cvInfo_list[3], Z[0], Z[1], Z[2], Z[3],seed_triangle_i};

    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            {iSeedInfo_list[0],iSeedInfo_list[1],iSeedInfo_list[2],iSeedInfo_list[3]}=0;           
            {cvInfo_list[0],cvInfo_list[1],cvInfo_list[2],cvInfo_list[3]}=0;            
            { Z[0], Z[1], Z[2], Z[3]}=0;
            get_sign_end<=0;            
            j<=0;
            counter1<=0;
            counter2<=0;
            state<=0;
        end
        else begin
            if(~get_sign_start) begin
                counter2<=0;
                counter1<=0;
                get_sign_end<=0;
                j<=0;
            end
            if(state==0 && get_sign_start &&get_sign_end==0)begin
                state<=1;
            end
            else if(state==1) begin
                j<=j+1;
                if(j==8) begin
                    state<=2;
                end
                else begin
                    if(j_in_LC) begin
                        Z[counter2]<={seed_list[j],masked_key_list[j],msgs_list[j],C_list[j],seed_lambda_list[j],aux_triangle_list[j]};
                        counter2<=counter2+1;
                    end
                    else begin
                        iSeedInfo_list[counter1]<=seed_star_list[j];
                        cvInfo_list[counter1]<=Cv_list[j];
                        counter1<=counter1+1;
                    end
                end
            end
            else if(state==2) begin
                counter2<=0;
                counter1<=0;
                j<=0;
                get_sign_end<=1;
                state<=0;
            end
        end
    end

endmodule