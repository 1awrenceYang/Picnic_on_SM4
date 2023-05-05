module get_sign_for_res2(
    input clk,
    input reset,
    input get_sign_start,
    
    input [255:0] h_t_i,
    input [255:0] salt_i,
    input [255:0] C_star_i,
    input [127:0] seed_triangle_i,


    input [512*4-1:0] msgs_i, //同样512就行，给�?后一个用户的mag 
    input [15*512*4-1:0] seed_lambda_i, //别给第一个就行�??
    input [1024*4-1:0] aux_triangle_i,

    output [37759:0] sigma,
    output reg get_sign_end
);

    wire [511:0] msgs_list[3:0] ;
    assign {msgs_list[0],msgs_list[1],msgs_list[2],msgs_list[3]} =msgs_i;

    //seed_lambda
    wire [512*15-1:0] seed_lambda_list[3:0] ;
    assign {seed_lambda_list[0],seed_lambda_list[1],seed_lambda_list[2],seed_lambda_list[3]} =seed_lambda_i;

    //aux_triangle_i;
    wire [1023:0]aux_triangle_list[3:0];
    assign {aux_triangle_list[0],aux_triangle_list[1],aux_triangle_list[2],aux_triangle_list[3]} =aux_triangle_i;

    wire[9215:0] Z[3:0];
    assign Z[0] ={msgs_list[0],seed_lambda_list[0],aux_triangle_list[0]};
    assign Z[1] ={msgs_list[1],seed_lambda_list[1],aux_triangle_list[1]};
    assign Z[2] ={msgs_list[2],seed_lambda_list[2],aux_triangle_list[2]};
    assign Z[3] ={msgs_list[3],seed_lambda_list[3],aux_triangle_list[3]};

    assign sigma={h_t_i,salt_i,C_star_i,seed_triangle_i,Z[0], Z[1], Z[2], Z[3]};
    
    reg [1:0] state;
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            get_sign_end<=0;
        end
        else begin
            if(~get_sign_start) begin
                get_sign_end<=0;
            end
            if(state==0 && get_sign_start &&get_sign_end==0)begin
                state<=1;
            end
            else if(state==1) begin
                get_sign_end<=1;
                state<=0;
            end 
        end
    end
endmodule