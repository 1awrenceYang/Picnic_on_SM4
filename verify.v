module signature(
    input clk,
    input reset,
    input [51199:0]M,
    input [255:0]root_seed,
    input [255:0]salt,
    input [254:0] sk,
    input sign_start,
    output reg sign_end,
    output reg [511:0]Cv_root,
    output reg [68*10-1:0] Lc,
    output reg [68*5-1:0] Lp
    );
    
 

endmodule      