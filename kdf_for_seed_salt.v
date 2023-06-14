module kdf_for_seed_salt(
        input clk,
        input rst,
        input signature_start,
        input [51199:0] M,
        input [127:0] sk,
        input [127:0] pk,
        
        output signature_stop,
        output [19708-1:0] sigma_out
    );



endmodule