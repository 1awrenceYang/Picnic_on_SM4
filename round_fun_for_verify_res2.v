module round_fun_for_verify_res2(
    input clk,
    input reset,
    input t_in_LC,
    input [7:0] t,
    input [7:0] j,
    input [127:0] seed_star,
    input [255:0] salt,
    input [127:0] instseeds,
    input [128*15-1:0] seed_i,
    input [255:0] C_i,
    input [511:0] seed_lambda_i,
    input [1023:0] aux_triangle_i,
    input [127:0]masked_key_i,
    input [511:0] msgs_i,
    input round_fun_res2_start,
    output [255:0] Ch,
    output [255:0] Cn,
    output [255:0] Cv,
    output reg round_fun_res2_end
    );

    reg[9:0] state;

    //Cn
    reg Cn_start;
    wire Cn_end;
    wire [255:0] cn;

    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            round_fun_res2_end<=0;
            tree_start<=0;
            state<=0;
            com_start<=0;
            ch_start<=0;

            set_seed_lambda_start<=0;
        end
        else begin
            if(~round_fun_res2_start) begin
                round_fun_res2_end<=0;
            end
            if(state==0 && round_fun_res2_start&&round_fun_res2_end==0)begin
                state<=1;
            end
            else if(state==1) begin
                if(Cn_end==1) begin
                    Cn_start<=0;
                    state<=2;
                end
                else begin
                    Cn_start<=1;
                end
            end
        end
    end

    H_for_Cn hfcn(clk,reset,seed_lambda_i,aux_triangle,salt, Cn_start,cn,Cn_end);

    
endmodule 