`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/03 01:29:36
// Design Name: 
// Module Name: simulate_part2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module get_lambda(
    input [4:0] round,
    input [1:0] index,
    input [3:0] user,
    
    output reg [7:0] lambda
);
    always@(*)
    begin
        case(user)
            4'd0:begin
                case(index)
                    2'd0:begin
                        case(round)
6'd0:lambda<=8'h21;
6'd1:lambda<=8'h33;
6'd2:lambda<=8'h5f;
6'd3:lambda<=8'he8;
6'd4:lambda<=8'h56;
6'd5:lambda<=8'h5;
6'd6:lambda<=8'h20;
6'd7:lambda<=8'h75;
6'd8:lambda<=8'h36;
6'd9:lambda<=8'hd7;
6'd10:lambda<=8'h70;
6'd11:lambda<=8'hb8;
6'd12:lambda<=8'hb9;
6'd13:lambda<=8'h12;
6'd14:lambda<=8'h68;
6'd15:lambda<=8'h9e;
6'd16:lambda<=8'h7b;
6'd17:lambda<=8'h5d;
6'd18:lambda<=8'h58;
6'd19:lambda<=8'h47;
6'd20:lambda<=8'h7c;
6'd21:lambda<=8'hcf;
6'd22:lambda<=8'h57;
6'd23:lambda<=8'h21;
6'd24:lambda<=8'hdf;
6'd25:lambda<=8'hcb;
6'd26:lambda<=8'hec;
6'd27:lambda<=8'hf9;
6'd28:lambda<=8'h5e;
6'd29:lambda<=8'h94;
6'd30:lambda<=8'h36;
6'd31:lambda<=8'h13;
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                            6'd0:lambda<=8'h7e;
6'd1:lambda<=8'hb7;
6'd2:lambda<=8'h71;
6'd3:lambda<=8'hd9;
6'd4:lambda<=8'h70;
6'd5:lambda<=8'h8;
6'd6:lambda<=8'hc4;
6'd7:lambda<=8'ha9;
6'd8:lambda<=8'h63;
6'd9:lambda<=8'h65;
6'd10:lambda<=8'hd;
6'd11:lambda<=8'h29;
6'd12:lambda<=8'h98;
6'd13:lambda<=8'h46;
6'd14:lambda<=8'h84;
6'd15:lambda<=8'h23;
6'd16:lambda<=8'hc2;
6'd17:lambda<=8'h6;
6'd18:lambda<=8'ha2;
6'd19:lambda<=8'hf8;
6'd20:lambda<=8'h82;
6'd21:lambda<=8'h74;
6'd22:lambda<=8'h78;
6'd23:lambda<=8'ha9;
6'd24:lambda<=8'h9d;
6'd25:lambda<=8'h9d;
6'd26:lambda<=8'h2b;
6'd27:lambda<=8'h5d;
6'd28:lambda<=8'h18;
6'd29:lambda<=8'h47;
6'd30:lambda<=8'h79;
6'd31:lambda<=8'h79;
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                            6'd0:lambda<=8'he1;
6'd1:lambda<=8'h68;
6'd2:lambda<=8'hf0;
6'd3:lambda<=8'h6e;
6'd4:lambda<=8'h1e;
6'd5:lambda<=8'h1c;
6'd6:lambda<=8'hd3;
6'd7:lambda<=8'ha5;
6'd8:lambda<=8'h94;
6'd9:lambda<=8'hab;
6'd10:lambda<=8'h6b;
6'd11:lambda<=8'hfb;
6'd12:lambda<=8'hc5;
6'd13:lambda<=8'he9;
6'd14:lambda<=8'h36;
6'd15:lambda<=8'h5e;
6'd16:lambda<=8'h96;
6'd17:lambda<=8'h2d;
6'd18:lambda<=8'h84;
6'd19:lambda<=8'h72;
6'd20:lambda<=8'ha9;
6'd21:lambda<=8'hb4;
6'd22:lambda<=8'h96;
6'd23:lambda<=8'h69;
6'd24:lambda<=8'h3;
6'd25:lambda<=8'h87;
6'd26:lambda<=8'hec;
6'd27:lambda<=8'h2f;
6'd28:lambda<=8'hc2;
6'd29:lambda<=8'he1;
6'd30:lambda<=8'hb0;
6'd31:lambda<=8'h8a;
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                            6'd0:lambda<=8'he1;
6'd1:lambda<=8'h68;
6'd2:lambda<=8'hf0;
6'd3:lambda<=8'h6e;
6'd4:lambda<=8'h1e;
6'd5:lambda<=8'h1c;
6'd6:lambda<=8'hd3;
6'd7:lambda<=8'ha5;
6'd8:lambda<=8'h94;
6'd9:lambda<=8'hab;
6'd10:lambda<=8'h6b;
6'd11:lambda<=8'hfb;
6'd12:lambda<=8'hc5;
6'd13:lambda<=8'he9;
6'd14:lambda<=8'h36;
6'd15:lambda<=8'h5e;
6'd16:lambda<=8'h96;
6'd17:lambda<=8'h2d;
6'd18:lambda<=8'h84;
6'd19:lambda<=8'h72;
6'd20:lambda<=8'ha9;
6'd21:lambda<=8'hb4;
6'd22:lambda<=8'h96;
6'd23:lambda<=8'h69;
6'd24:lambda<=8'h3;
6'd25:lambda<=8'h87;
6'd26:lambda<=8'hec;
6'd27:lambda<=8'h2f;
6'd28:lambda<=8'hc2;
6'd29:lambda<=8'he1;
6'd30:lambda<=8'hb0;
6'd31:lambda<=8'h8a;
                        endcase
                    end
                endcase
            end
            
            4'd1:begin
                case(index)
                    2'd0:begin
                        case(round)
                            6'd0:lambda<=8'h8;
6'd1:lambda<=8'hb5;
6'd2:lambda<=8'h7e;
6'd3:lambda<=8'hca;
6'd4:lambda<=8'h79;
6'd5:lambda<=8'hb8;
6'd6:lambda<=8'h17;
6'd7:lambda<=8'ha0;
6'd8:lambda<=8'h26;
6'd9:lambda<=8'hea;
6'd10:lambda<=8'hd5;
6'd11:lambda<=8'h64;
6'd12:lambda<=8'h8f;
6'd13:lambda<=8'hed;
6'd14:lambda<=8'h4b;
6'd15:lambda<=8'hc4;
6'd16:lambda<=8'h33;
6'd17:lambda<=8'h91;
6'd18:lambda<=8'hf6;
6'd19:lambda<=8'h79;
6'd20:lambda<=8'h1f;
6'd21:lambda<=8'h76;
6'd22:lambda<=8'hdd;
6'd23:lambda<=8'h8f;
6'd24:lambda<=8'h38;
6'd25:lambda<=8'h65;
6'd26:lambda<=8'h76;
6'd27:lambda<=8'haa;
6'd28:lambda<=8'h22;
6'd29:lambda<=8'h76;
6'd30:lambda<=8'h96;
6'd31:lambda<=8'h3b;
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                            6'd0:lambda<=8'hb3;
6'd1:lambda<=8'h85;
6'd2:lambda<=8'hd1;
6'd3:lambda<=8'he1;
6'd4:lambda<=8'hb4;
6'd5:lambda<=8'hb1;
6'd6:lambda<=8'h59;
6'd7:lambda<=8'h1e;
6'd8:lambda<=8'he6;
6'd9:lambda<=8'h25;
6'd10:lambda<=8'h9e;
6'd11:lambda<=8'h32;
6'd12:lambda<=8'h9;
6'd13:lambda<=8'h81;
6'd14:lambda<=8'h2e;
6'd15:lambda<=8'hc4;
6'd16:lambda<=8'hf7;
6'd17:lambda<=8'h15;
6'd18:lambda<=8'h0;
6'd19:lambda<=8'hef;
6'd20:lambda<=8'h76;
6'd21:lambda<=8'hb2;
6'd22:lambda<=8'hd3;
6'd23:lambda<=8'h85;
6'd24:lambda<=8'hee;
6'd25:lambda<=8'hb1;
6'd26:lambda<=8'h44;
6'd27:lambda<=8'h36;
6'd28:lambda<=8'h68;
6'd29:lambda<=8'h6a;
6'd30:lambda<=8'h29;
6'd31:lambda<=8'he3;
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                            6'd0:lambda<=8'hf7;
6'd1:lambda<=8'hab;
6'd2:lambda<=8'h55;
6'd3:lambda<=8'h54;
6'd4:lambda<=8'hb7;
6'd5:lambda<=8'h78;
6'd6:lambda<=8'h20;
6'd7:lambda<=8'h89;
6'd8:lambda<=8'h5c;
6'd9:lambda<=8'hbb;
6'd10:lambda<=8'hdf;
6'd11:lambda<=8'h3c;
6'd12:lambda<=8'h83;
6'd13:lambda<=8'h9a;
6'd14:lambda<=8'h47;
6'd15:lambda<=8'h2;
6'd16:lambda<=8'h2c;
6'd17:lambda<=8'hb2;
6'd18:lambda<=8'hdd;
6'd19:lambda<=8'h75;
6'd20:lambda<=8'h85;
6'd21:lambda<=8'h12;
6'd22:lambda<=8'h5f;
6'd23:lambda<=8'ha1;
6'd24:lambda<=8'hee;
6'd25:lambda<=8'h6;
6'd26:lambda<=8'h3a;
6'd27:lambda<=8'h20;
6'd28:lambda<=8'h7f;
6'd29:lambda<=8'h54;
6'd30:lambda<=8'ha4;
6'd31:lambda<=8'h95;
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                            6'd0:lambda<=8'h63;
6'd1:lambda<=8'h4d;
6'd2:lambda<=8'ha9;
6'd3:lambda<=8'ha4;
6'd4:lambda<=8'h6a;
6'd5:lambda<=8'hbe;
6'd6:lambda<=8'h4c;
6'd7:lambda<=8'h51;
6'd8:lambda<=8'hb9;
6'd9:lambda<=8'h4e;
6'd10:lambda<=8'h93;
6'd11:lambda<=8'he9;
6'd12:lambda<=8'hdb;
6'd13:lambda<=8'hb6;
6'd14:lambda<=8'h58;
6'd15:lambda<=8'h5e;
6'd16:lambda<=8'hb2;
6'd17:lambda<=8'h20;
6'd18:lambda<=8'h3f;
6'd19:lambda<=8'h48;
6'd20:lambda<=8'h89;
6'd21:lambda<=8'h32;
6'd22:lambda<=8'he6;
6'd23:lambda<=8'hca;
6'd24:lambda<=8'h93;
6'd25:lambda<=8'h62;
6'd26:lambda<=8'hbd;
6'd27:lambda<=8'h1a;
6'd28:lambda<=8'hde;
6'd29:lambda<=8'h4e;
6'd30:lambda<=8'h78;
6'd31:lambda<=8'h38;
                        endcase
                    end
                endcase
            end
            
            4'd2:begin
                case(index)
                    2'd0:begin
                        case(round)
                            6'd0:lambda<=8'h40;
6'd1:lambda<=8'h48;
6'd2:lambda<=8'h49;
6'd3:lambda<=8'hb;
6'd4:lambda<=8'hf7;
6'd5:lambda<=8'ha7;
6'd6:lambda<=8'h26;
6'd7:lambda<=8'h77;
6'd8:lambda<=8'h8a;
6'd9:lambda<=8'h9;
6'd10:lambda<=8'h35;
6'd11:lambda<=8'h5b;
6'd12:lambda<=8'hab;
6'd13:lambda<=8'hff;
6'd14:lambda<=8'he8;
6'd15:lambda<=8'hb0;
6'd16:lambda<=8'h99;
6'd17:lambda<=8'hd8;
6'd18:lambda<=8'h51;
6'd19:lambda<=8'h95;
6'd20:lambda<=8'h31;
6'd21:lambda<=8'h8;
6'd22:lambda<=8'heb;
6'd23:lambda<=8'h8d;
6'd24:lambda<=8'h6a;
6'd25:lambda<=8'he4;
6'd26:lambda<=8'ha4;
6'd27:lambda<=8'h8b;
6'd28:lambda<=8'hc0;
6'd29:lambda<=8'h2e;
6'd30:lambda<=8'h79;
6'd31:lambda<=8'hbd;
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                            6'd0:lambda<=8'hb2;
6'd1:lambda<=8'hbc;
6'd2:lambda<=8'hf5;
6'd3:lambda<=8'he4;
6'd4:lambda<=8'h7f;
6'd5:lambda<=8'hac;
6'd6:lambda<=8'h9a;
6'd7:lambda<=8'hc3;
6'd8:lambda<=8'h44;
6'd9:lambda<=8'h8b;
6'd10:lambda<=8'h1c;
6'd11:lambda<=8'ha2;
6'd12:lambda<=8'hb5;
6'd13:lambda<=8'h35;
6'd14:lambda<=8'h34;
6'd15:lambda<=8'h8e;
6'd16:lambda<=8'hb9;
6'd17:lambda<=8'h62;
6'd18:lambda<=8'h1d;
6'd19:lambda<=8'h44;
6'd20:lambda<=8'h57;
6'd21:lambda<=8'h37;
6'd22:lambda<=8'h9c;
6'd23:lambda<=8'hdd;
6'd24:lambda<=8'h39;
6'd25:lambda<=8'h23;
6'd26:lambda<=8'hd9;
6'd27:lambda<=8'h1;
6'd28:lambda<=8'h53;
6'd29:lambda<=8'he4;
6'd30:lambda<=8'hca;
6'd31:lambda<=8'hfc;
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                            6'd0:lambda<=8'h87;
6'd1:lambda<=8'h4a;
6'd2:lambda<=8'h27;
6'd3:lambda<=8'hd4;
6'd4:lambda<=8'h3c;
6'd5:lambda<=8'hcb;
6'd6:lambda<=8'h1c;
6'd7:lambda<=8'h4b;
6'd8:lambda<=8'hda;
6'd9:lambda<=8'h6d;
6'd10:lambda<=8'hee;
6'd11:lambda<=8'ha4;
6'd12:lambda<=8'hc2;
6'd13:lambda<=8'h20;
6'd14:lambda<=8'hf;
6'd15:lambda<=8'hbd;
6'd16:lambda<=8'h2f;
6'd17:lambda<=8'h19;
6'd18:lambda<=8'h85;
6'd19:lambda<=8'h1c;
6'd20:lambda<=8'h1e;
6'd21:lambda<=8'h25;
6'd22:lambda<=8'h29;
6'd23:lambda<=8'hdd;
6'd24:lambda<=8'hd9;
6'd25:lambda<=8'h56;
6'd26:lambda<=8'h11;
6'd27:lambda<=8'h99;
6'd28:lambda<=8'h8d;
6'd29:lambda<=8'heb;
6'd30:lambda<=8'hc2;
6'd31:lambda<=8'ha9;
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                            6'd0:lambda<=8'h3b;
6'd1:lambda<=8'hd5;
6'd2:lambda<=8'he1;
6'd3:lambda<=8'hd7;
6'd4:lambda<=8'h8b;
6'd5:lambda<=8'h64;
6'd6:lambda<=8'h78;
6'd7:lambda<=8'hc9;
6'd8:lambda<=8'h41;
6'd9:lambda<=8'h7b;
6'd10:lambda<=8'ha9;
6'd11:lambda<=8'hb4;
6'd12:lambda<=8'h92;
6'd13:lambda<=8'hf;
6'd14:lambda<=8'h58;
6'd15:lambda<=8'h38;
6'd16:lambda<=8'h9;
6'd17:lambda<=8'h65;
6'd18:lambda<=8'h6e;
6'd19:lambda<=8'ha0;
6'd20:lambda<=8'hf;
6'd21:lambda<=8'h55;
6'd22:lambda<=8'h2a;
6'd23:lambda<=8'h18;
6'd24:lambda<=8'h37;
6'd25:lambda<=8'hdc;
6'd26:lambda<=8'h75;
6'd27:lambda<=8'hf7;
6'd28:lambda<=8'h3c;
6'd29:lambda<=8'h22;
6'd30:lambda<=8'h81;
6'd31:lambda<=8'h5e;
                        endcase
                    end
                endcase
            end
            
            4'd3:begin
                case(index)
                    2'd0:begin
                        case(round)
                            6'd0:lambda<=8'h98;
6'd1:lambda<=8'h2e;
6'd2:lambda<=8'h60;
6'd3:lambda<=8'hb5;
6'd4:lambda<=8'hf7;
6'd5:lambda<=8'h1d;
6'd6:lambda<=8'h6c;
6'd7:lambda<=8'h2;
6'd8:lambda<=8'hfb;
6'd9:lambda<=8'h6;
6'd10:lambda<=8'hc7;
6'd11:lambda<=8'h6f;
6'd12:lambda<=8'h85;
6'd13:lambda<=8'h2b;
6'd14:lambda<=8'h2d;
6'd15:lambda<=8'h18;
6'd16:lambda<=8'h68;
6'd17:lambda<=8'hbc;
6'd18:lambda<=8'hca;
6'd19:lambda<=8'hf7;
6'd20:lambda<=8'hcf;
6'd21:lambda<=8'h61;
6'd22:lambda<=8'h33;
6'd23:lambda<=8'h90;
6'd24:lambda<=8'h96;
6'd25:lambda<=8'h39;
6'd26:lambda<=8'h3;
6'd27:lambda<=8'hea;
6'd28:lambda<=8'h22;
6'd29:lambda<=8'he3;
6'd30:lambda<=8'h33;
6'd31:lambda<=8'hd9;
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                            6'd0:lambda<=8'h79;
6'd1:lambda<=8'hc5;
6'd2:lambda<=8'h9d;
6'd3:lambda<=8'h0;
6'd4:lambda<=8'h3c;
6'd5:lambda<=8'h9b;
6'd6:lambda<=8'h4f;
6'd7:lambda<=8'h78;
6'd8:lambda<=8'hc8;
6'd9:lambda<=8'h32;
6'd10:lambda<=8'h94;
6'd11:lambda<=8'ha9;
6'd12:lambda<=8'hc2;
6'd13:lambda<=8'h8a;
6'd14:lambda<=8'h47;
6'd15:lambda<=8'h1c;
6'd16:lambda<=8'hd8;
6'd17:lambda<=8'h23;
6'd18:lambda<=8'h87;
6'd19:lambda<=8'h9a;
6'd20:lambda<=8'hb8;
6'd21:lambda<=8'h63;
6'd22:lambda<=8'h65;
6'd23:lambda<=8'h64;
6'd24:lambda<=8'ha2;
6'd25:lambda<=8'h62;
6'd26:lambda<=8'hc7;
6'd27:lambda<=8'h84;
6'd28:lambda<=8'hfa;
6'd29:lambda<=8'h6c;
6'd30:lambda<=8'h2d;
6'd31:lambda<=8'h8c;
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                       6'd0:lambda<=8'h3e;
6'd1:lambda<=8'ha;
6'd2:lambda<=8'hb8;
6'd3:lambda<=8'ha3;
6'd4:lambda<=8'h7a;
6'd5:lambda<=8'hb5;
6'd6:lambda<=8'hee;
6'd7:lambda<=8'h7;
6'd8:lambda<=8'ha2;
6'd9:lambda<=8'h99;
6'd10:lambda<=8'h44;
6'd11:lambda<=8'ha0;
6'd12:lambda<=8'h8f;
6'd13:lambda<=8'h9a;
6'd14:lambda<=8'h62;
6'd15:lambda<=8'h86;
6'd16:lambda<=8'hc;
6'd17:lambda<=8'h7e;
6'd18:lambda<=8'h1f;
6'd19:lambda<=8'ha3;
6'd20:lambda<=8'h93;
6'd21:lambda<=8'hb4;
6'd22:lambda<=8'h58;
6'd23:lambda<=8'h91;
6'd24:lambda<=8'ha7;
6'd25:lambda<=8'h39;
6'd26:lambda<=8'h9c;
6'd27:lambda<=8'hbf;
6'd28:lambda<=8'h9c;
6'd29:lambda<=8'hd9;
6'd30:lambda<=8'h18;
6'd31:lambda<=8'h76;     
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                            6'd0:lambda<=8'h4f;
6'd1:lambda<=8'h38;
6'd2:lambda<=8'hc6;
6'd3:lambda<=8'h7e;
6'd4:lambda<=8'he1;
6'd5:lambda<=8'hcf;
6'd6:lambda<=8'h7d;
6'd7:lambda<=8'hbe;
6'd8:lambda<=8'had;
6'd9:lambda<=8'hc1;
6'd10:lambda<=8'h5b;
6'd11:lambda<=8'hce;
6'd12:lambda<=8'h5d;
6'd13:lambda<=8'h15;
6'd14:lambda<=8'h0;
6'd15:lambda<=8'h3c;
6'd16:lambda<=8'h48;
6'd17:lambda<=8'h46;
6'd18:lambda<=8'he9;
6'd19:lambda<=8'h3e;
6'd20:lambda<=8'hb4;
6'd21:lambda<=8'hd1;
6'd22:lambda<=8'h98;
6'd23:lambda<=8'h5f;
6'd24:lambda<=8'h97;
6'd25:lambda<=8'hd3;
6'd26:lambda<=8'h1;
6'd27:lambda<=8'h91;
6'd28:lambda<=8'h3d;
6'd29:lambda<=8'h82;
6'd30:lambda<=8'ha0;
6'd31:lambda<=8'h9e;
                        endcase
                    end
                endcase
            end
            
            4'd4:begin
                case(index)
                    2'd0:begin
                        case(round)
                            6'd0:lambda<=8'h82;
6'd1:lambda<=8'h1e;
6'd2:lambda<=8'ha1;
6'd3:lambda<=8'h6;
6'd4:lambda<=8'h3a;
6'd5:lambda<=8'hd0;
6'd6:lambda<=8'h3e;
6'd7:lambda<=8'h5f;
6'd8:lambda<=8'hbd;
6'd9:lambda<=8'h46;
6'd10:lambda<=8'h67;
6'd11:lambda<=8'hac;
6'd12:lambda<=8'h13;
6'd13:lambda<=8'hd;
6'd14:lambda<=8'hf7;
6'd15:lambda<=8'h65;
6'd16:lambda<=8'hd2;
6'd17:lambda<=8'ha4;
6'd18:lambda<=8'ha0;
6'd19:lambda<=8'hc8;
6'd20:lambda<=8'hf2;
6'd21:lambda<=8'h85;
6'd22:lambda<=8'h4b;
6'd23:lambda<=8'h73;
6'd24:lambda<=8'h61;
6'd25:lambda<=8'h86;
6'd26:lambda<=8'h66;
6'd27:lambda<=8'h81;
6'd28:lambda<=8'hf;
6'd29:lambda<=8'ha5;
6'd30:lambda<=8'h87;
6'd31:lambda<=8'h75;
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                            6'd0:lambda<=8'h34;
6'd1:lambda<=8'h4e;
6'd2:lambda<=8'he9;
6'd3:lambda<=8'h0;
6'd4:lambda<=8'he0;
6'd5:lambda<=8'h8e;
6'd6:lambda<=8'h15;
6'd7:lambda<=8'hfc;
6'd8:lambda<=8'hcb;
6'd9:lambda<=8'hf7;
6'd10:lambda<=8'h13;
6'd11:lambda<=8'hd6;
6'd12:lambda<=8'hf3;
6'd13:lambda<=8'hfd;
6'd14:lambda<=8'h93;
6'd15:lambda<=8'h7c;
6'd16:lambda<=8'h1d;
6'd17:lambda<=8'hb0;
6'd18:lambda<=8'h7c;
6'd19:lambda<=8'h21;
6'd20:lambda<=8'h9a;
6'd21:lambda<=8'hb4;
6'd22:lambda<=8'h5b;
6'd23:lambda<=8'h0;
6'd24:lambda<=8'h7d;
6'd25:lambda<=8'h7c;
6'd26:lambda<=8'hc7;
6'd27:lambda<=8'h6c;
6'd28:lambda<=8'h2;
6'd29:lambda<=8'hf9;
6'd30:lambda<=8'h4;
6'd31:lambda<=8'h2;
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                        6'd0:lambda<=8'h99;
6'd1:lambda<=8'h20;
6'd2:lambda<=8'h88;
6'd3:lambda<=8'h45;
6'd4:lambda<=8'h2b;
6'd5:lambda<=8'hab;
6'd6:lambda<=8'hd5;
6'd7:lambda<=8'h3e;
6'd8:lambda<=8'h16;
6'd9:lambda<=8'h69;
6'd10:lambda<=8'hff;
6'd11:lambda<=8'h6f;
6'd12:lambda<=8'h3e;
6'd13:lambda<=8'h9d;
6'd14:lambda<=8'h2f;
6'd15:lambda<=8'h56;
6'd16:lambda<=8'h88;
6'd17:lambda<=8'hc5;
6'd18:lambda<=8'h4a;
6'd19:lambda<=8'hf7;
6'd20:lambda<=8'h84;
6'd21:lambda<=8'h4e;
6'd22:lambda<=8'h34;
6'd23:lambda<=8'h8b;
6'd24:lambda<=8'h4;
6'd25:lambda<=8'h5d;
6'd26:lambda<=8'he6;
6'd27:lambda<=8'he;
6'd28:lambda<=8'h3e;
6'd29:lambda<=8'h96;
6'd30:lambda<=8'h1a;
6'd31:lambda<=8'ha0;    
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                            6'd0:lambda<=8'hd0;
6'd1:lambda<=8'h4c;
6'd2:lambda<=8'h6b;
6'd3:lambda<=8'hed;
6'd4:lambda<=8'h9e;
6'd5:lambda<=8'h53;
6'd6:lambda<=8'h97;
6'd7:lambda<=8'hf1;
6'd8:lambda<=8'h64;
6'd9:lambda<=8'h9a;
6'd10:lambda<=8'hef;
6'd11:lambda<=8'hab;
6'd12:lambda<=8'he5;
6'd13:lambda<=8'hf9;
6'd14:lambda<=8'h3b;
6'd15:lambda<=8'hd7;
6'd16:lambda<=8'hc8;
6'd17:lambda<=8'h66;
6'd18:lambda<=8'hb6;
6'd19:lambda<=8'h64;
6'd20:lambda<=8'h93;
6'd21:lambda<=8'h2b;
6'd22:lambda<=8'h5a;
6'd23:lambda<=8'h70;
6'd24:lambda<=8'h1d;
6'd25:lambda<=8'h86;
6'd26:lambda<=8'h44;
6'd27:lambda<=8'h59;
6'd28:lambda<=8'h77;
6'd29:lambda<=8'h91;
6'd30:lambda<=8'hb1;
6'd31:lambda<=8'h13;
                        endcase
                    end
                endcase
            end
            
            4'd5:begin
                case(index)
                    2'd0:begin
                        case(round)
                          6'd0:lambda<=8'hb1;
6'd1:lambda<=8'hf6;
6'd2:lambda<=8'hf9;
6'd3:lambda<=8'hb3;
6'd4:lambda<=8'h30;
6'd5:lambda<=8'hdb;
6'd6:lambda<=8'he6;
6'd7:lambda<=8'h1b;
6'd8:lambda<=8'hdb;
6'd9:lambda<=8'hfa;
6'd10:lambda<=8'h6a;
6'd11:lambda<=8'h4;
6'd12:lambda<=8'h54;
6'd13:lambda<=8'hcd;
6'd14:lambda<=8'hec;
6'd15:lambda<=8'ha9;
6'd16:lambda<=8'h98;
6'd17:lambda<=8'hd2;
6'd18:lambda<=8'h42;
6'd19:lambda<=8'h45;
6'd20:lambda<=8'h4f;
6'd21:lambda<=8'hce;
6'd22:lambda<=8'h4c;
6'd23:lambda<=8'hb3;
6'd24:lambda<=8'h5f;
6'd25:lambda<=8'h98;
6'd26:lambda<=8'hdf;
6'd27:lambda<=8'hb2;
6'd28:lambda<=8'h16;
6'd29:lambda<=8'h8f;
6'd30:lambda<=8'h37;
6'd31:lambda<=8'h3d;  
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                         6'd0:lambda<=8'h57;
6'd1:lambda<=8'haa;
6'd2:lambda<=8'he4;
6'd3:lambda<=8'h81;
6'd4:lambda<=8'h12;
6'd5:lambda<=8'h2a;
6'd6:lambda<=8'h8b;
6'd7:lambda<=8'h2c;
6'd8:lambda<=8'h28;
6'd9:lambda<=8'hc6;
6'd10:lambda<=8'h6;
6'd11:lambda<=8'h2e;
6'd12:lambda<=8'hce;
6'd13:lambda<=8'hb1;
6'd14:lambda<=8'hc5;
6'd15:lambda<=8'h24;
6'd16:lambda<=8'h78;
6'd17:lambda<=8'h10;
6'd18:lambda<=8'h22;
6'd19:lambda<=8'h2;
6'd20:lambda<=8'ha1;
6'd21:lambda<=8'h54;
6'd22:lambda<=8'h82;
6'd23:lambda<=8'h2e;
6'd24:lambda<=8'h1e;
6'd25:lambda<=8'h40;
6'd26:lambda<=8'h94;
6'd27:lambda<=8'h3b;
6'd28:lambda<=8'h8f;
6'd29:lambda<=8'h67;
6'd30:lambda<=8'hf8;
6'd31:lambda<=8'h55;   
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                            6'd0:lambda<=8'h50;
6'd1:lambda<=8'h3a;
6'd2:lambda<=8'h3d;
6'd3:lambda<=8'hc9;
6'd4:lambda<=8'h8f;
6'd5:lambda<=8'h54;
6'd6:lambda<=8'h83;
6'd7:lambda<=8'ha8;
6'd8:lambda<=8'h66;
6'd9:lambda<=8'hf0;
6'd10:lambda<=8'h84;
6'd11:lambda<=8'h74;
6'd12:lambda<=8'h45;
6'd13:lambda<=8'h2;
6'd14:lambda<=8'hc9;
6'd15:lambda<=8'hfa;
6'd16:lambda<=8'h62;
6'd17:lambda<=8'hae;
6'd18:lambda<=8'hbd;
6'd19:lambda<=8'h46;
6'd20:lambda<=8'h98;
6'd21:lambda<=8'hb;
6'd22:lambda<=8'he5;
6'd23:lambda<=8'h7f;
6'd24:lambda<=8'h6b;
6'd25:lambda<=8'h1c;
6'd26:lambda<=8'h3a;
6'd27:lambda<=8'h4f;
6'd28:lambda<=8'hd;
6'd29:lambda<=8'hc1;
6'd30:lambda<=8'h31;
6'd31:lambda<=8'hb7;
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                            6'd0:lambda<=8'h89;
6'd1:lambda<=8'h51;
6'd2:lambda<=8'h66;
6'd3:lambda<=8'h6b;
6'd4:lambda<=8'h51;
6'd5:lambda<=8'hfb;
6'd6:lambda<=8'h5e;
6'd7:lambda<=8'h4d;
6'd8:lambda<=8'hf6;
6'd9:lambda<=8'he0;
6'd10:lambda<=8'h96;
6'd11:lambda<=8'h64;
6'd12:lambda<=8'hc7;
6'd13:lambda<=8'hd4;
6'd14:lambda<=8'h24;
6'd15:lambda<=8'hf5;
6'd16:lambda<=8'h61;
6'd17:lambda<=8'hc8;
6'd18:lambda<=8'h71;
6'd19:lambda<=8'hd;
6'd20:lambda<=8'h37;
6'd21:lambda<=8'h52;
6'd22:lambda<=8'h4f;
6'd23:lambda<=8'hf2;
6'd24:lambda<=8'h8e;
6'd25:lambda<=8'hd2;
6'd26:lambda<=8'h26;
6'd27:lambda<=8'h89;
6'd28:lambda<=8'hbb;
6'd29:lambda<=8'ha0;
6'd30:lambda<=8'h6f;
6'd31:lambda<=8'hdd;
                        endcase
                    end
                endcase
            end
            
            4'd6:begin
                case(index)
                    2'd0:begin
                        case(round)
                            6'd0:lambda<=8'h12;
6'd1:lambda<=8'he5;
6'd2:lambda<=8'ha6;
6'd3:lambda<=8'h1c;
6'd4:lambda<=8'hc0;
6'd5:lambda<=8'he2;
6'd6:lambda<=8'had;
6'd7:lambda<=8'h84;
6'd8:lambda<=8'h98;
6'd9:lambda<=8'h7;
6'd10:lambda<=8'h69;
6'd11:lambda<=8'h37;
6'd12:lambda<=8'hce;
6'd13:lambda<=8'h10;
6'd14:lambda<=8'hd1;
6'd15:lambda<=8'h1f;
6'd16:lambda<=8'h7b;
6'd17:lambda<=8'hbe;
6'd18:lambda<=8'h79;
6'd19:lambda<=8'h50;
6'd20:lambda<=8'h41;
6'd21:lambda<=8'h4d;
6'd22:lambda<=8'h28;
6'd23:lambda<=8'h29;
6'd24:lambda<=8'h23;
6'd25:lambda<=8'heb;
6'd26:lambda<=8'h25;
6'd27:lambda<=8'h73;
6'd28:lambda<=8'ha;
6'd29:lambda<=8'hd0;
6'd30:lambda<=8'h88;
6'd31:lambda<=8'h30;
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                            6'd0:lambda<=8'h46;
6'd1:lambda<=8'h4;
6'd2:lambda<=8'h1a;
6'd3:lambda<=8'h8a;
6'd4:lambda<=8'h9d;
6'd5:lambda<=8'h9c;
6'd6:lambda<=8'h88;
6'd7:lambda<=8'hd5;
6'd8:lambda<=8'h97;
6'd9:lambda<=8'h5d;
6'd10:lambda<=8'hfb;
6'd11:lambda<=8'h74;
6'd12:lambda<=8'h7a;
6'd13:lambda<=8'h30;
6'd14:lambda<=8'h85;
6'd15:lambda<=8'h2f;
6'd16:lambda<=8'h1b;
6'd17:lambda<=8'h11;
6'd18:lambda<=8'h36;
6'd19:lambda<=8'h7a;
6'd20:lambda<=8'h8c;
6'd21:lambda<=8'h94;
6'd22:lambda<=8'had;
6'd23:lambda<=8'hd2;
6'd24:lambda<=8'hb2;
6'd25:lambda<=8'h2f;
6'd26:lambda<=8'h51;
6'd27:lambda<=8'h65;
6'd28:lambda<=8'h42;
6'd29:lambda<=8'h96;
6'd30:lambda<=8'h25;
6'd31:lambda<=8'h6b;
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                         6'd0:lambda<=8'h22;
6'd1:lambda<=8'hf9;
6'd2:lambda<=8'hc9;
6'd3:lambda<=8'h3f;
6'd4:lambda<=8'hfd;
6'd5:lambda<=8'h9b;
6'd6:lambda<=8'hb8;
6'd7:lambda<=8'h4e;
6'd8:lambda<=8'hdd;
6'd9:lambda<=8'hdd;
6'd10:lambda<=8'hb0;
6'd11:lambda<=8'hf4;
6'd12:lambda<=8'h63;
6'd13:lambda<=8'h94;
6'd14:lambda<=8'h5c;
6'd15:lambda<=8'hd4;
6'd16:lambda<=8'hca;
6'd17:lambda<=8'hff;
6'd18:lambda<=8'hcc;
6'd19:lambda<=8'hbf;
6'd20:lambda<=8'had;
6'd21:lambda<=8'h15;
6'd22:lambda<=8'hb8;
6'd23:lambda<=8'h20;
6'd24:lambda<=8'h3;
6'd25:lambda<=8'he4;
6'd26:lambda<=8'h9b;
6'd27:lambda<=8'hab;
6'd28:lambda<=8'he;
6'd29:lambda<=8'hd1;
6'd30:lambda<=8'h2d;
6'd31:lambda<=8'h67;   
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                            6'd0:lambda<=8'h3a;
6'd1:lambda<=8'h70;
6'd2:lambda<=8'h90;
6'd3:lambda<=8'hcf;
6'd4:lambda<=8'h1d;
6'd5:lambda<=8'hc5;
6'd6:lambda<=8'ha7;
6'd7:lambda<=8'h47;
6'd8:lambda<=8'h8b;
6'd9:lambda<=8'hdc;
6'd10:lambda<=8'h25;
6'd11:lambda<=8'hee;
6'd12:lambda<=8'hff;
6'd13:lambda<=8'h93;
6'd14:lambda<=8'h3f;
6'd15:lambda<=8'h7b;
6'd16:lambda<=8'hc;
6'd17:lambda<=8'h78;
6'd18:lambda<=8'hb7;
6'd19:lambda<=8'h45;
6'd20:lambda<=8'h5d;
6'd21:lambda<=8'haa;
6'd22:lambda<=8'hd7;
6'd23:lambda<=8'hbf;
6'd24:lambda<=8'h85;
6'd25:lambda<=8'h43;
6'd26:lambda<=8'hff;
6'd27:lambda<=8'h9e;
6'd28:lambda<=8'h13;
6'd29:lambda<=8'h55;
6'd30:lambda<=8'h5e;
6'd31:lambda<=8'hf5;
                        endcase
                    end
                endcase
            end
            
            4'd7:begin
                case(index)
                    2'd0:begin
                        case(round)
                            6'd0:lambda<=8'h83;
6'd1:lambda<=8'hf1;
6'd2:lambda<=8'h25;
6'd3:lambda<=8'ha8;
6'd4:lambda<=8'hd2;
6'd5:lambda<=8'h62;
6'd6:lambda<=8'h60;
6'd7:lambda<=8'hb9;
6'd8:lambda<=8'h75;
6'd9:lambda<=8'h7a;
6'd10:lambda<=8'h20;
6'd11:lambda<=8'he;
6'd12:lambda<=8'hcb;
6'd13:lambda<=8'ha3;
6'd14:lambda<=8'hf5;
6'd15:lambda<=8'h49;
6'd16:lambda<=8'hc5;
6'd17:lambda<=8'hc2;
6'd18:lambda<=8'hf5;
6'd19:lambda<=8'h6a;
6'd20:lambda<=8'h33;
6'd21:lambda<=8'h1;
6'd22:lambda<=8'h7;
6'd23:lambda<=8'h24;
6'd24:lambda<=8'h2f;
6'd25:lambda<=8'hb8;
6'd26:lambda<=8'hc2;
6'd27:lambda<=8'h1;
6'd28:lambda<=8'h67;
6'd29:lambda<=8'h28;
6'd30:lambda<=8'h65;
6'd31:lambda<=8'h28;
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                            6'd0:lambda<=8'hac;
6'd1:lambda<=8'h12;
6'd2:lambda<=8'h5a;
6'd3:lambda<=8'ha7;
6'd4:lambda<=8'h63;
6'd5:lambda<=8'hbc;
6'd6:lambda<=8'h4b;
6'd7:lambda<=8'h9e;
6'd8:lambda<=8'h15;
6'd9:lambda<=8'h20;
6'd10:lambda<=8'h48;
6'd11:lambda<=8'h5b;
6'd12:lambda<=8'h85;
6'd13:lambda<=8'h35;
6'd14:lambda<=8'hff;
6'd15:lambda<=8'h28;
6'd16:lambda<=8'h1;
6'd17:lambda<=8'h63;
6'd18:lambda<=8'h26;
6'd19:lambda<=8'h16;
6'd20:lambda<=8'haf;
6'd21:lambda<=8'h85;
6'd22:lambda<=8'h34;
6'd23:lambda<=8'h9f;
6'd24:lambda<=8'hce;
6'd25:lambda<=8'h4b;
6'd26:lambda<=8'h14;
6'd27:lambda<=8'h19;
6'd28:lambda<=8'h2a;
6'd29:lambda<=8'ha9;
6'd30:lambda<=8'haf;
6'd31:lambda<=8'h74;
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                        6'd0:lambda<=8'hc8;
6'd1:lambda<=8'hcd;
6'd2:lambda<=8'h9b;
6'd3:lambda<=8'hcc;
6'd4:lambda<=8'h1e;
6'd5:lambda<=8'h6d;
6'd6:lambda<=8'h47;
6'd7:lambda<=8'h15;
6'd8:lambda<=8'hec;
6'd9:lambda<=8'he4;
6'd10:lambda<=8'h86;
6'd11:lambda<=8'h4b;
6'd12:lambda<=8'h54;
6'd13:lambda<=8'h3e;
6'd14:lambda<=8'hdd;
6'd15:lambda<=8'he;
6'd16:lambda<=8'h7f;
6'd17:lambda<=8'hed;
6'd18:lambda<=8'hdf;
6'd19:lambda<=8'ha8;
6'd20:lambda<=8'hf1;
6'd21:lambda<=8'h55;
6'd22:lambda<=8'hd9;
6'd23:lambda<=8'hfd;
6'd24:lambda<=8'h46;
6'd25:lambda<=8'h42;
6'd26:lambda<=8'he6;
6'd27:lambda<=8'h27;
6'd28:lambda<=8'hf0;
6'd29:lambda<=8'hdb;
6'd30:lambda<=8'h72;
6'd31:lambda<=8'h78;    
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                          6'd0:lambda<=8'h35;
6'd1:lambda<=8'h40;
6'd2:lambda<=8'h64;
6'd3:lambda<=8'h9b;
6'd4:lambda<=8'h91;
6'd5:lambda<=8'h10;
6'd6:lambda<=8'ha1;
6'd7:lambda<=8'h35;
6'd8:lambda<=8'h28;
6'd9:lambda<=8'h2f;
6'd10:lambda<=8'h9b;
6'd11:lambda<=8'hfd;
6'd12:lambda<=8'haf;
6'd13:lambda<=8'h5a;
6'd14:lambda<=8'h39;
6'd15:lambda<=8'h3f;
6'd16:lambda<=8'hc4;
6'd17:lambda<=8'hee;
6'd18:lambda<=8'hdf;
6'd19:lambda<=8'ha6;
6'd20:lambda<=8'ha1;
6'd21:lambda<=8'h2;
6'd22:lambda<=8'h39;
6'd23:lambda<=8'h39;
6'd24:lambda<=8'h39;
6'd25:lambda<=8'h7d;
6'd26:lambda<=8'h89;
6'd27:lambda<=8'hea;
6'd28:lambda<=8'h44;
6'd29:lambda<=8'h80;
6'd30:lambda<=8'hd7;
6'd31:lambda<=8'h25;  
                        endcase
                    end
                endcase
            end
            
            4'd8:begin
                case(index)
                    2'd0:begin
                        case(round)
                            6'd0:lambda<=8'hb8;
6'd1:lambda<=8'h5;
6'd2:lambda<=8'ha3;
6'd3:lambda<=8'h93;
6'd4:lambda<=8'h1a;
6'd5:lambda<=8'h68;
6'd6:lambda<=8'heb;
6'd7:lambda<=8'hee;
6'd8:lambda<=8'h4a;
6'd9:lambda<=8'hf0;
6'd10:lambda<=8'h6a;
6'd11:lambda<=8'h1b;
6'd12:lambda<=8'hdb;
6'd13:lambda<=8'hab;
6'd14:lambda<=8'hc0;
6'd15:lambda<=8'h9c;
6'd16:lambda<=8'h70;
6'd17:lambda<=8'h5c;
6'd18:lambda<=8'h99;
6'd19:lambda<=8'heb;
6'd20:lambda<=8'hc;
6'd21:lambda<=8'h10;
6'd22:lambda<=8'h2e;
6'd23:lambda<=8'h6d;
6'd24:lambda<=8'ha0;
6'd25:lambda<=8'h8c;
6'd26:lambda<=8'hea;
6'd27:lambda<=8'h3c;
6'd28:lambda<=8'h27;
6'd29:lambda<=8'h26;
6'd30:lambda<=8'h60;
6'd31:lambda<=8'hd3;
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                            6'd0:lambda<=8'h90;
6'd1:lambda<=8'hd8;
6'd2:lambda<=8'h46;
6'd3:lambda<=8'h44;
6'd4:lambda<=8'h6a;
6'd5:lambda<=8'h64;
6'd6:lambda<=8'h56;
6'd7:lambda<=8'h69;
6'd8:lambda<=8'h6;
6'd9:lambda<=8'h3d;
6'd10:lambda<=8'h8e;
6'd11:lambda<=8'hdb;
6'd12:lambda<=8'hd2;
6'd13:lambda<=8'h76;
6'd14:lambda<=8'h95;
6'd15:lambda<=8'h2c;
6'd16:lambda<=8'h99;
6'd17:lambda<=8'h4c;
6'd18:lambda<=8'he3;
6'd19:lambda<=8'he5;
6'd20:lambda<=8'h2b;
6'd21:lambda<=8'h2c;
6'd22:lambda<=8'hb7;
6'd23:lambda<=8'he3;
6'd24:lambda<=8'h4f;
6'd25:lambda<=8'hc5;
6'd26:lambda<=8'h1e;
6'd27:lambda<=8'h7e;
6'd28:lambda<=8'hd6;
6'd29:lambda<=8'h6d;
6'd30:lambda<=8'h16;
6'd31:lambda<=8'hd4;
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                            6'd0:lambda<=8'h92;
6'd1:lambda<=8'h9d;
6'd2:lambda<=8'h2d;
6'd3:lambda<=8'he6;
6'd4:lambda<=8'hb9;
6'd5:lambda<=8'h57;
6'd6:lambda<=8'h30;
6'd7:lambda<=8'h40;
6'd8:lambda<=8'h9b;
6'd9:lambda<=8'h70;
6'd10:lambda<=8'hdc;
6'd11:lambda<=8'h1a;
6'd12:lambda<=8'he;
6'd13:lambda<=8'h2;
6'd14:lambda<=8'h60;
6'd15:lambda<=8'hb0;
6'd16:lambda<=8'h59;
6'd17:lambda<=8'h17;
6'd18:lambda<=8'h59;
6'd19:lambda<=8'h3a;
6'd20:lambda<=8'hdb;
6'd21:lambda<=8'hf0;
6'd22:lambda<=8'h69;
6'd23:lambda<=8'h89;
6'd24:lambda<=8'hbd;
6'd25:lambda<=8'hc9;
6'd26:lambda<=8'h81;
6'd27:lambda<=8'h52;
6'd28:lambda<=8'h8f;
6'd29:lambda<=8'hea;
6'd30:lambda<=8'h84;
6'd31:lambda<=8'h1c;
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                            6'd0:lambda<=8'h69;
6'd1:lambda<=8'ha5;
6'd2:lambda<=8'hcd;
6'd3:lambda<=8'h38;
6'd4:lambda<=8'ha4;
6'd5:lambda<=8'h6;
6'd6:lambda<=8'hb7;
6'd7:lambda<=8'hd2;
6'd8:lambda<=8'he0;
6'd9:lambda<=8'h7f;
6'd10:lambda<=8'hfd;
6'd11:lambda<=8'hd;
6'd12:lambda<=8'hd;
6'd13:lambda<=8'h84;
6'd14:lambda<=8'h7b;
6'd15:lambda<=8'hd6;
6'd16:lambda<=8'h27;
6'd17:lambda<=8'ha6;
6'd18:lambda<=8'he9;
6'd19:lambda<=8'haf;
6'd20:lambda<=8'hbc;
6'd21:lambda<=8'h43;
6'd22:lambda<=8'h3f;
6'd23:lambda<=8'hb6;
6'd24:lambda<=8'h7f;
6'd25:lambda<=8'hb0;
6'd26:lambda<=8'h76;
6'd27:lambda<=8'hd0;
6'd28:lambda<=8'ha9;
6'd29:lambda<=8'hed;
6'd30:lambda<=8'h2c;
6'd31:lambda<=8'h69;
                        endcase
                    end
                endcase
            end
            
            4'd9:begin
                case(index)
                    2'd0:begin
                        case(round)
                           6'd0:lambda<=8'he2;
6'd1:lambda<=8'h8b;
6'd2:lambda<=8'h22;
6'd3:lambda<=8'hc0;
6'd4:lambda<=8'hc1;
6'd5:lambda<=8'h77;
6'd6:lambda<=8'hb4;
6'd7:lambda<=8'hf3;
6'd8:lambda<=8'h31;
6'd9:lambda<=8'h95;
6'd10:lambda<=8'h39;
6'd11:lambda<=8'h6e;
6'd12:lambda<=8'hce;
6'd13:lambda<=8'ha5;
6'd14:lambda<=8'h90;
6'd15:lambda<=8'hb;
6'd16:lambda<=8'hdd;
6'd17:lambda<=8'hce;
6'd18:lambda<=8'h86;
6'd19:lambda<=8'ha9;
6'd20:lambda<=8'hc5;
6'd21:lambda<=8'h28;
6'd22:lambda<=8'h47;
6'd23:lambda<=8'h72;
6'd24:lambda<=8'h30;
6'd25:lambda<=8'he4;
6'd26:lambda<=8'h1c;
6'd27:lambda<=8'h73;
6'd28:lambda<=8'h35;
6'd29:lambda<=8'hb9;
6'd30:lambda<=8'h6f;
6'd31:lambda<=8'h6c; 
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                            6'd0:lambda<=8'hb8;
6'd1:lambda<=8'hfc;
6'd2:lambda<=8'hba;
6'd3:lambda<=8'heb;
6'd4:lambda<=8'hbb;
6'd5:lambda<=8'h3;
6'd6:lambda<=8'h6f;
6'd7:lambda<=8'h8d;
6'd8:lambda<=8'hb1;
6'd9:lambda<=8'h44;
6'd10:lambda<=8'h74;
6'd11:lambda<=8'hc3;
6'd12:lambda<=8'h47;
6'd13:lambda<=8'hb1;
6'd14:lambda<=8'h14;
6'd15:lambda<=8'h82;
6'd16:lambda<=8'h40;
6'd17:lambda<=8'hf5;
6'd18:lambda<=8'h70;
6'd19:lambda<=8'he2;
6'd20:lambda<=8'hb4;
6'd21:lambda<=8'h2e;
6'd22:lambda<=8'h15;
6'd23:lambda<=8'hd9;
6'd24:lambda<=8'h46;
6'd25:lambda<=8'hda;
6'd26:lambda<=8'he2;
6'd27:lambda<=8'h77;
6'd28:lambda<=8'h7b;
6'd29:lambda<=8'ha6;
6'd30:lambda<=8'hf6;
6'd31:lambda<=8'hd1;
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                            6'd0:lambda<=8'h60;
6'd1:lambda<=8'h8a;
6'd2:lambda<=8'h60;
6'd3:lambda<=8'h69;
6'd4:lambda<=8'h58;
6'd5:lambda<=8'h1c;
6'd6:lambda<=8'h55;
6'd7:lambda<=8'hba;
6'd8:lambda<=8'h4b;
6'd9:lambda<=8'hfe;
6'd10:lambda<=8'h20;
6'd11:lambda<=8'hb1;
6'd12:lambda<=8'h63;
6'd13:lambda<=8'hfa;
6'd14:lambda<=8'hb9;
6'd15:lambda<=8'h35;
6'd16:lambda<=8'hc;
6'd17:lambda<=8'ha7;
6'd18:lambda<=8'h8;
6'd19:lambda<=8'hf8;
6'd20:lambda<=8'h71;
6'd21:lambda<=8'h49;
6'd22:lambda<=8'h8e;
6'd23:lambda<=8'he;
6'd24:lambda<=8'h15;
6'd25:lambda<=8'h2c;
6'd26:lambda<=8'ha6;
6'd27:lambda<=8'h7a;
6'd28:lambda<=8'h18;
6'd29:lambda<=8'h19;
6'd30:lambda<=8'h61;
6'd31:lambda<=8'hc3;
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                            6'd0:lambda<=8'h80;
6'd1:lambda<=8'h8f;
6'd2:lambda<=8'hc3;
6'd3:lambda<=8'h90;
6'd4:lambda<=8'h6a;
6'd5:lambda<=8'h14;
6'd6:lambda<=8'h88;
6'd7:lambda<=8'h31;
6'd8:lambda<=8'hcb;
6'd9:lambda<=8'h2e;
6'd10:lambda<=8'h6f;
6'd11:lambda<=8'h5;
6'd12:lambda<=8'h0;
6'd13:lambda<=8'h4b;
6'd14:lambda<=8'h9c;
6'd15:lambda<=8'hb1;
6'd16:lambda<=8'h19;
6'd17:lambda<=8'hb7;
6'd18:lambda<=8'ha7;
6'd19:lambda<=8'h3e;
6'd20:lambda<=8'h27;
6'd21:lambda<=8'hf5;
6'd22:lambda<=8'h14;
6'd23:lambda<=8'h2c;
6'd24:lambda<=8'hfe;
6'd25:lambda<=8'h79;
6'd26:lambda<=8'h5d;
6'd27:lambda<=8'h6b;
6'd28:lambda<=8'ha3;
6'd29:lambda<=8'h16;
6'd30:lambda<=8'h84;
6'd31:lambda<=8'h3e;
                        endcase
                    end
                endcase
            end
            
            4'd10:begin
                case(index)
                    2'd0:begin
                        case(round)
                            6'd0:lambda<=8'hea;
6'd1:lambda<=8'hee;
6'd2:lambda<=8'ha;
6'd3:lambda<=8'hd1;
6'd4:lambda<=8'h1f;
6'd5:lambda<=8'hb9;
6'd6:lambda<=8'hc5;
6'd7:lambda<=8'ha4;
6'd8:lambda<=8'h6c;
6'd9:lambda<=8'hf8;
6'd10:lambda<=8'hb4;
6'd11:lambda<=8'h4e;
6'd12:lambda<=8'h7e;
6'd13:lambda<=8'hb9;
6'd14:lambda<=8'h7f;
6'd15:lambda<=8'he1;
6'd16:lambda<=8'h6;
6'd17:lambda<=8'h55;
6'd18:lambda<=8'h34;
6'd19:lambda<=8'h3d;
6'd20:lambda<=8'h23;
6'd21:lambda<=8'h28;
6'd22:lambda<=8'hba;
6'd23:lambda<=8'h49;
6'd24:lambda<=8'h99;
6'd25:lambda<=8'h8e;
6'd26:lambda<=8'hbb;
6'd27:lambda<=8'h27;
6'd28:lambda<=8'h60;
6'd29:lambda<=8'h8f;
6'd30:lambda<=8'ha4;
6'd31:lambda<=8'hfc;
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                          6'd0:lambda<=8'hc3;
6'd1:lambda<=8'ha7;
6'd2:lambda<=8'h49;
6'd3:lambda<=8'h21;
6'd4:lambda<=8'h69;
6'd5:lambda<=8'h19;
6'd6:lambda<=8'h67;
6'd7:lambda<=8'hfd;
6'd8:lambda<=8'hd8;
6'd9:lambda<=8'h35;
6'd10:lambda<=8'hc3;
6'd11:lambda<=8'h3;
6'd12:lambda<=8'hf5;
6'd13:lambda<=8'h5f;
6'd14:lambda<=8'haa;
6'd15:lambda<=8'hc;
6'd16:lambda<=8'hd8;
6'd17:lambda<=8'h65;
6'd18:lambda<=8'h2d;
6'd19:lambda<=8'hc7;
6'd20:lambda<=8'h2;
6'd21:lambda<=8'h75;
6'd22:lambda<=8'he9;
6'd23:lambda<=8'h2d;
6'd24:lambda<=8'he5;
6'd25:lambda<=8'h8c;
6'd26:lambda<=8'hdc;
6'd27:lambda<=8'h4b;
6'd28:lambda<=8'h99;
6'd29:lambda<=8'hd7;
6'd30:lambda<=8'h4a;
6'd31:lambda<=8'h98;  
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                          6'd0:lambda<=8'h62;
6'd1:lambda<=8'hdd;
6'd2:lambda<=8'h2c;
6'd3:lambda<=8'h48;
6'd4:lambda<=8'hf;
6'd5:lambda<=8'h6f;
6'd6:lambda<=8'h9d;
6'd7:lambda<=8'h2d;
6'd8:lambda<=8'hc2;
6'd9:lambda<=8'hff;
6'd10:lambda<=8'h96;
6'd11:lambda<=8'h77;
6'd12:lambda<=8'h2e;
6'd13:lambda<=8'h69;
6'd14:lambda<=8'hc6;
6'd15:lambda<=8'h99;
6'd16:lambda<=8'hed;
6'd17:lambda<=8'h38;
6'd18:lambda<=8'h81;
6'd19:lambda<=8'h9d;
6'd20:lambda<=8'hf1;
6'd21:lambda<=8'h83;
6'd22:lambda<=8'hb0;
6'd23:lambda<=8'h61;
6'd24:lambda<=8'h77;
6'd25:lambda<=8'hda;
6'd26:lambda<=8'h90;
6'd27:lambda<=8'hfd;
6'd28:lambda<=8'h29;
6'd29:lambda<=8'h6b;
6'd30:lambda<=8'ha1;
6'd31:lambda<=8'hd1;  
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                            6'd0:lambda<=8'hf9;
6'd1:lambda<=8'hb;
6'd2:lambda<=8'hab;
6'd3:lambda<=8'had;
6'd4:lambda<=8'h36;
6'd5:lambda<=8'h2;
6'd6:lambda<=8'h50;
6'd7:lambda<=8'h33;
6'd8:lambda<=8'hbc;
6'd9:lambda<=8'h5a;
6'd10:lambda<=8'h6d;
6'd11:lambda<=8'h11;
6'd12:lambda<=8'hc4;
6'd13:lambda<=8'h82;
6'd14:lambda<=8'hc9;
6'd15:lambda<=8'hb6;
6'd16:lambda<=8'hda;
6'd17:lambda<=8'h7f;
6'd18:lambda<=8'h8f;
6'd19:lambda<=8'hb2;
6'd20:lambda<=8'he6;
6'd21:lambda<=8'h44;
6'd22:lambda<=8'h35;
6'd23:lambda<=8'hd7;
6'd24:lambda<=8'hb3;
6'd25:lambda<=8'h38;
6'd26:lambda<=8'h4b;
6'd27:lambda<=8'h8a;
6'd28:lambda<=8'h12;
6'd29:lambda<=8'h82;
6'd30:lambda<=8'h3e;
6'd31:lambda<=8'h6b;
                        endcase
                    end
                endcase
            end
            
            4'd11:begin
                case(index)
                    2'd0:begin
                        case(round)
                            6'd0:lambda<=8'hcd;
6'd1:lambda<=8'hac;
6'd2:lambda<=8'hb1;
6'd3:lambda<=8'he6;
6'd4:lambda<=8'h86;
6'd5:lambda<=8'h4;
6'd6:lambda<=8'h3;
6'd7:lambda<=8'h4e;
6'd8:lambda<=8'h90;
6'd9:lambda<=8'h3e;
6'd10:lambda<=8'h2c;
6'd11:lambda<=8'h25;
6'd12:lambda<=8'h9d;
6'd13:lambda<=8'hb4;
6'd14:lambda<=8'h85;
6'd15:lambda<=8'h2c;
6'd16:lambda<=8'h7;
6'd17:lambda<=8'h18;
6'd18:lambda<=8'he3;
6'd19:lambda<=8'h91;
6'd20:lambda<=8'h7e;
6'd21:lambda<=8'h18;
6'd22:lambda<=8'hdd;
6'd23:lambda<=8'he0;
6'd24:lambda<=8'h99;
6'd25:lambda<=8'hd1;
6'd26:lambda<=8'hdb;
6'd27:lambda<=8'ha;
6'd28:lambda<=8'h87;
6'd29:lambda<=8'hf2;
6'd30:lambda<=8'h12;
6'd31:lambda<=8'h6d;
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                           6'd0:lambda<=8'hb5;
6'd1:lambda<=8'he1;
6'd2:lambda<=8'hc2;
6'd3:lambda<=8'hec;
6'd4:lambda<=8'ha6;
6'd5:lambda<=8'h60;
6'd6:lambda<=8'had;
6'd7:lambda<=8'ha;
6'd8:lambda<=8'hb4;
6'd9:lambda<=8'h3e;
6'd10:lambda<=8'h7c;
6'd11:lambda<=8'h54;
6'd12:lambda<=8'hb6;
6'd13:lambda<=8'he4;
6'd14:lambda<=8'hdc;
6'd15:lambda<=8'haf;
6'd16:lambda<=8'h8f;
6'd17:lambda<=8'h87;
6'd18:lambda<=8'hc;
6'd19:lambda<=8'ha6;
6'd20:lambda<=8'h4b;
6'd21:lambda<=8'h3f;
6'd22:lambda<=8'h92;
6'd23:lambda<=8'hf1;
6'd24:lambda<=8'hfa;
6'd25:lambda<=8'he0;
6'd26:lambda<=8'h9a;
6'd27:lambda<=8'h87;
6'd28:lambda<=8'hb8;
6'd29:lambda<=8'h77;
6'd30:lambda<=8'h4b;
6'd31:lambda<=8'h28; 
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                            6'd0:lambda<=8'h1d;
6'd1:lambda<=8'he6;
6'd2:lambda<=8'hb4;
6'd3:lambda<=8'h47;
6'd4:lambda<=8'heb;
6'd5:lambda<=8'hdc;
6'd6:lambda<=8'h37;
6'd7:lambda<=8'h9;
6'd8:lambda<=8'hd;
6'd9:lambda<=8'he;
6'd10:lambda<=8'he9;
6'd11:lambda<=8'hc3;
6'd12:lambda<=8'hde;
6'd13:lambda<=8'haa;
6'd14:lambda<=8'hce;
6'd15:lambda<=8'h13;
6'd16:lambda<=8'hc1;
6'd17:lambda<=8'h6;
6'd18:lambda<=8'hb8;
6'd19:lambda<=8'h90;
6'd20:lambda<=8'hc0;
6'd21:lambda<=8'hd7;
6'd22:lambda<=8'h10;
6'd23:lambda<=8'h7f;
6'd24:lambda<=8'h4e;
6'd25:lambda<=8'he0;
6'd26:lambda<=8'hf1;
6'd27:lambda<=8'h2b;
6'd28:lambda<=8'hc3;
6'd29:lambda<=8'hb4;
6'd30:lambda<=8'h93;
6'd31:lambda<=8'h71;
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                          6'd0:lambda<=8'h94;
6'd1:lambda<=8'hcf;
6'd2:lambda<=8'hfb;
6'd3:lambda<=8'hdc;
6'd4:lambda<=8'hdf;
6'd5:lambda<=8'hc;
6'd6:lambda<=8'h7;
6'd7:lambda<=8'h1c;
6'd8:lambda<=8'hc4;
6'd9:lambda<=8'h13;
6'd10:lambda<=8'h2a;
6'd11:lambda<=8'he5;
6'd12:lambda<=8'h71;
6'd13:lambda<=8'hb8;
6'd14:lambda<=8'h2c;
6'd15:lambda<=8'h9b;
6'd16:lambda<=8'h2c;
6'd17:lambda<=8'hcb;
6'd18:lambda<=8'h6a;
6'd19:lambda<=8'he0;
6'd20:lambda<=8'h37;
6'd21:lambda<=8'h82;
6'd22:lambda<=8'h1d;
6'd23:lambda<=8'h39;
6'd24:lambda<=8'hab;
6'd25:lambda<=8'h5e;
6'd26:lambda<=8'hd6;
6'd27:lambda<=8'hca;
6'd28:lambda<=8'ha0;
6'd29:lambda<=8'hea;
6'd30:lambda<=8'h9e;
6'd31:lambda<=8'h99;  
                        endcase
                    end
                endcase
            end
            
            4'd12:begin
                case(index)
                    2'd0:begin
                        case(round)
                            6'd0:lambda<=8'h53;
6'd1:lambda<=8'h42;
6'd2:lambda<=8'hbe;
6'd3:lambda<=8'h54;
6'd4:lambda<=8'h2d;
6'd5:lambda<=8'hbd;
6'd6:lambda<=8'h34;
6'd7:lambda<=8'h91;
6'd8:lambda<=8'h49;
6'd9:lambda<=8'hfe;
6'd10:lambda<=8'h0;
6'd11:lambda<=8'h58;
6'd12:lambda<=8'h95;
6'd13:lambda<=8'h94;
6'd14:lambda<=8'ha8;
6'd15:lambda<=8'hd;
6'd16:lambda<=8'h7e;
6'd17:lambda<=8'h77;
6'd18:lambda<=8'hea;
6'd19:lambda<=8'h5f;
6'd20:lambda<=8'hd9;
6'd21:lambda<=8'hce;
6'd22:lambda<=8'hea;
6'd23:lambda<=8'hbe;
6'd24:lambda<=8'ha3;
6'd25:lambda<=8'hb;
6'd26:lambda<=8'hb9;
6'd27:lambda<=8'h3a;
6'd28:lambda<=8'hc6;
6'd29:lambda<=8'hc2;
6'd30:lambda<=8'h1;
6'd31:lambda<=8'hc1;
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                            6'd0:lambda<=8'hbc;
6'd1:lambda<=8'h45;
6'd2:lambda<=8'hd7;
6'd3:lambda<=8'ha;
6'd4:lambda<=8'h5;
6'd5:lambda<=8'hd5;
6'd6:lambda<=8'hac;
6'd7:lambda<=8'h98;
6'd8:lambda<=8'h58;
6'd9:lambda<=8'hcf;
6'd10:lambda<=8'h83;
6'd11:lambda<=8'h10;
6'd12:lambda<=8'h95;
6'd13:lambda<=8'h21;
6'd14:lambda<=8'hd0;
6'd15:lambda<=8'h53;
6'd16:lambda<=8'h21;
6'd17:lambda<=8'h65;
6'd18:lambda<=8'he6;
6'd19:lambda<=8'hab;
6'd20:lambda<=8'hb1;
6'd21:lambda<=8'hf4;
6'd22:lambda<=8'h66;
6'd23:lambda<=8'hde;
6'd24:lambda<=8'h57;
6'd25:lambda<=8'had;
6'd26:lambda<=8'he9;
6'd27:lambda<=8'h55;
6'd28:lambda<=8'h8f;
6'd29:lambda<=8'hea;
6'd30:lambda<=8'hca;
6'd31:lambda<=8'he1;
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                            6'd0:lambda<=8'h84;
6'd1:lambda<=8'ha1;
6'd2:lambda<=8'hfc;
6'd3:lambda<=8'h28;
6'd4:lambda<=8'h4e;
6'd5:lambda<=8'hf4;
6'd6:lambda<=8'h83;
6'd7:lambda<=8'hf1;
6'd8:lambda<=8'had;
6'd9:lambda<=8'h57;
6'd10:lambda<=8'h79;
6'd11:lambda<=8'h84;
6'd12:lambda<=8'hbc;
6'd13:lambda<=8'hfe;
6'd14:lambda<=8'ha0;
6'd15:lambda<=8'h64;
6'd16:lambda<=8'h5f;
6'd17:lambda<=8'h69;
6'd18:lambda<=8'h1a;
6'd19:lambda<=8'ha2;
6'd20:lambda<=8'h8d;
6'd21:lambda<=8'hc2;
6'd22:lambda<=8'h6d;
6'd23:lambda<=8'h76;
6'd24:lambda<=8'h67;
6'd25:lambda<=8'h42;
6'd26:lambda<=8'h85;
6'd27:lambda<=8'hb8;
6'd28:lambda<=8'h37;
6'd29:lambda<=8'h59;
6'd30:lambda<=8'hca;
6'd31:lambda<=8'h1e;
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                            6'd0:lambda<=8'h7a;
6'd1:lambda<=8'he0;
6'd2:lambda<=8'h91;
6'd3:lambda<=8'hf7;
6'd4:lambda<=8'h70;
6'd5:lambda<=8'ha4;
6'd6:lambda<=8'h40;
6'd7:lambda<=8'hcd;
6'd8:lambda<=8'h64;
6'd9:lambda<=8'hbf;
6'd10:lambda<=8'hc8;
6'd11:lambda<=8'hcb;
6'd12:lambda<=8'hda;
6'd13:lambda<=8'h51;
6'd14:lambda<=8'he9;
6'd15:lambda<=8'hc4;
6'd16:lambda<=8'h16;
6'd17:lambda<=8'h8f;
6'd18:lambda<=8'hf8;
6'd19:lambda<=8'he7;
6'd20:lambda<=8'h35;
6'd21:lambda<=8'hd8;
6'd22:lambda<=8'h33;
6'd23:lambda<=8'hb8;
6'd24:lambda<=8'h83;
6'd25:lambda<=8'hb4;
6'd26:lambda<=8'h6a;
6'd27:lambda<=8'h54;
6'd28:lambda<=8'h57;
6'd29:lambda<=8'h7b;
6'd30:lambda<=8'h76;
6'd31:lambda<=8'he6;
                        endcase
                    end
                endcase
            end
            
            4'd13:begin
                case(index)
                    2'd0:begin
                        case(round)
                            6'd0:lambda<=8'h14;
6'd1:lambda<=8'h30;
6'd2:lambda<=8'h1f;
6'd3:lambda<=8'h85;
6'd4:lambda<=8'h4e;
6'd5:lambda<=8'h5d;
6'd6:lambda<=8'hed;
6'd7:lambda<=8'hae;
6'd8:lambda<=8'h31;
6'd9:lambda<=8'h2f;
6'd10:lambda<=8'he7;
6'd11:lambda<=8'hbc;
6'd12:lambda<=8'hb9;
6'd13:lambda<=8'h37;
6'd14:lambda<=8'h8b;
6'd15:lambda<=8'h16;
6'd16:lambda<=8'hc6;
6'd17:lambda<=8'h72;
6'd18:lambda<=8'hc4;
6'd19:lambda<=8'h66;
6'd20:lambda<=8'hab;
6'd21:lambda<=8'h7;
6'd22:lambda<=8'h41;
6'd23:lambda<=8'h1b;
6'd24:lambda<=8'h4;
6'd25:lambda<=8'h50;
6'd26:lambda<=8'h82;
6'd27:lambda<=8'h6f;
6'd28:lambda<=8'h6e;
6'd29:lambda<=8'h3e;
6'd30:lambda<=8'h64;
6'd31:lambda<=8'he8;
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                            6'd0:lambda<=8'h68;
6'd1:lambda<=8'hd7;
6'd2:lambda<=8'h51;
6'd3:lambda<=8'hfd;
6'd4:lambda<=8'h47;
6'd5:lambda<=8'hbf;
6'd6:lambda<=8'h9c;
6'd7:lambda<=8'hc9;
6'd8:lambda<=8'h3d;
6'd9:lambda<=8'h36;
6'd10:lambda<=8'h74;
6'd11:lambda<=8'h7b;
6'd12:lambda<=8'hd4;
6'd13:lambda<=8'hf0;
6'd14:lambda<=8'he0;
6'd15:lambda<=8'h2b;
6'd16:lambda<=8'hd8;
6'd17:lambda<=8'hc4;
6'd18:lambda<=8'hcd;
6'd19:lambda<=8'h1c;
6'd20:lambda<=8'h38;
6'd21:lambda<=8'h72;
6'd22:lambda<=8'h24;
6'd23:lambda<=8'hd0;
6'd24:lambda<=8'hcc;
6'd25:lambda<=8'ha2;
6'd26:lambda<=8'he;
6'd27:lambda<=8'h32;
6'd28:lambda<=8'h7d;
6'd29:lambda<=8'h61;
6'd30:lambda<=8'h43;
6'd31:lambda<=8'ha7;
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                            6'd0:lambda<=8'hdf;
6'd1:lambda<=8'h6d;
6'd2:lambda<=8'h6b;
6'd3:lambda<=8'hb;
6'd4:lambda<=8'hc0;
6'd5:lambda<=8'h64;
6'd6:lambda<=8'he;
6'd7:lambda<=8'ha;
6'd8:lambda<=8'h1;
6'd9:lambda<=8'hc6;
6'd10:lambda<=8'h95;
6'd11:lambda<=8'h8f;
6'd12:lambda<=8'ha;
6'd13:lambda<=8'h14;
6'd14:lambda<=8'hc6;
6'd15:lambda<=8'h8c;
6'd16:lambda<=8'h6d;
6'd17:lambda<=8'h69;
6'd18:lambda<=8'ha0;
6'd19:lambda<=8'hdb;
6'd20:lambda<=8'hf6;
6'd21:lambda<=8'hc5;
6'd22:lambda<=8'h3f;
6'd23:lambda<=8'hba;
6'd24:lambda<=8'h72;
6'd25:lambda<=8'h50;
6'd26:lambda<=8'h38;
6'd27:lambda<=8'ha6;
6'd28:lambda<=8'h15;
6'd29:lambda<=8'ha9;
6'd30:lambda<=8'h80;
6'd31:lambda<=8'hec;
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                            6'd0:lambda<=8'h97;
6'd1:lambda<=8'h34;
6'd2:lambda<=8'h95;
6'd3:lambda<=8'h84;
6'd4:lambda<=8'he2;
6'd5:lambda<=8'h6c;
6'd6:lambda<=8'h86;
6'd7:lambda<=8'hef;
6'd8:lambda<=8'h9c;
6'd9:lambda<=8'h37;
6'd10:lambda<=8'ha4;
6'd11:lambda<=8'h91;
6'd12:lambda<=8'hb0;
6'd13:lambda<=8'h61;
6'd14:lambda<=8'h2c;
6'd15:lambda<=8'h1e;
6'd16:lambda<=8'h50;
6'd17:lambda<=8'hc7;
6'd18:lambda<=8'h45;
6'd19:lambda<=8'hc2;
6'd20:lambda<=8'h91;
6'd21:lambda<=8'ha9;
6'd22:lambda<=8'hd4;
6'd23:lambda<=8'h31;
6'd24:lambda<=8'h9c;
6'd25:lambda<=8'h8f;
6'd26:lambda<=8'h13;
6'd27:lambda<=8'h77;
6'd28:lambda<=8'hf5;
6'd29:lambda<=8'h8;
6'd30:lambda<=8'h86;
6'd31:lambda<=8'hcd;
                        endcase
                    end
                endcase
            end
            
            4'd14:begin
                case(index)
                    2'd0:begin
                        case(round)
                            6'd0:lambda<=8'h19;
6'd1:lambda<=8'h91;
6'd2:lambda<=8'h45;
6'd3:lambda<=8'hac;
6'd4:lambda<=8'h11;
6'd5:lambda<=8'h88;
6'd6:lambda<=8'h99;
6'd7:lambda<=8'h36;
6'd8:lambda<=8'h40;
6'd9:lambda<=8'hc2;
6'd10:lambda<=8'h2d;
6'd11:lambda<=8'hfe;
6'd12:lambda<=8'h26;
6'd13:lambda<=8'ha6;
6'd14:lambda<=8'h61;
6'd15:lambda<=8'h34;
6'd16:lambda<=8'h16;
6'd17:lambda<=8'h8f;
6'd18:lambda<=8'hab;
6'd19:lambda<=8'h7b;
6'd20:lambda<=8'h55;
6'd21:lambda<=8'h38;
6'd22:lambda<=8'h28;
6'd23:lambda<=8'hf6;
6'd24:lambda<=8'h2b;
6'd25:lambda<=8'hab;
6'd26:lambda<=8'hd0;
6'd27:lambda<=8'h6b;
6'd28:lambda<=8'h67;
6'd29:lambda<=8'h95;
6'd30:lambda<=8'ha4;
6'd31:lambda<=8'he4;
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                            6'd0:lambda<=8'hd7;
6'd1:lambda<=8'ha7;
6'd2:lambda<=8'h5c;
6'd3:lambda<=8'hc;
6'd4:lambda<=8'hac;
6'd5:lambda<=8'h16;
6'd6:lambda<=8'hf2;
6'd7:lambda<=8'h11;
6'd8:lambda<=8'hcc;
6'd9:lambda<=8'ha6;
6'd10:lambda<=8'hfc;
6'd11:lambda<=8'h86;
6'd12:lambda<=8'h54;
6'd13:lambda<=8'hf7;
6'd14:lambda<=8'h8b;
6'd15:lambda<=8'h8f;
6'd16:lambda<=8'h2d;
6'd17:lambda<=8'h9a;
6'd18:lambda<=8'h48;
6'd19:lambda<=8'h31;
6'd20:lambda<=8'h8b;
6'd21:lambda<=8'h39;
6'd22:lambda<=8'h33;
6'd23:lambda<=8'he2;
6'd24:lambda<=8'h0;
6'd25:lambda<=8'h1a;
6'd26:lambda<=8'h89;
6'd27:lambda<=8'ha7;
6'd28:lambda<=8'h4;
6'd29:lambda<=8'h57;
6'd30:lambda<=8'h29;
6'd31:lambda<=8'he1;
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                            6'd0:lambda<=8'hd;
6'd1:lambda<=8'h81;
6'd2:lambda<=8'h5d;
6'd3:lambda<=8'haa;
6'd4:lambda<=8'hc0;
6'd5:lambda<=8'hf6;
6'd6:lambda<=8'h21;
6'd7:lambda<=8'hfa;
6'd8:lambda<=8'h1;
6'd9:lambda<=8'h95;
6'd10:lambda<=8'hb3;
6'd11:lambda<=8'h1f;
6'd12:lambda<=8'h2c;
6'd13:lambda<=8'h59;
6'd14:lambda<=8'h4f;
6'd15:lambda<=8'h95;
6'd16:lambda<=8'hda;
6'd17:lambda<=8'h1c;
6'd18:lambda<=8'h3c;
6'd19:lambda<=8'hdf;
6'd20:lambda<=8'h92;
6'd21:lambda<=8'h8c;
6'd22:lambda<=8'h5e;
6'd23:lambda<=8'h24;
6'd24:lambda<=8'hc7;
6'd25:lambda<=8'h18;
6'd26:lambda<=8'h97;
6'd27:lambda<=8'h31;
6'd28:lambda<=8'h7c;
6'd29:lambda<=8'h3a;
6'd30:lambda<=8'h24;
6'd31:lambda<=8'he3;
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                            6'd0:lambda<=8'hf2;
6'd1:lambda<=8'h5d;
6'd2:lambda<=8'hd7;
6'd3:lambda<=8'h5b;
6'd4:lambda<=8'hc4;
6'd5:lambda<=8'h19;
6'd6:lambda<=8'h41;
6'd7:lambda<=8'hc0;
6'd8:lambda<=8'h88;
6'd9:lambda<=8'h55;
6'd10:lambda<=8'h2c;
6'd11:lambda<=8'h15;
6'd12:lambda<=8'hc;
6'd13:lambda<=8'he;
6'd14:lambda<=8'h27;
6'd15:lambda<=8'h60;
6'd16:lambda<=8'h18;
6'd17:lambda<=8'h4b;
6'd18:lambda<=8'h90;
6'd19:lambda<=8'h45;
6'd20:lambda<=8'h23;
6'd21:lambda<=8'h1b;
6'd22:lambda<=8'h3f;
6'd23:lambda<=8'ha5;
6'd24:lambda<=8'h71;
6'd25:lambda<=8'h63;
6'd26:lambda<=8'hac;
6'd27:lambda<=8'hd1;
6'd28:lambda<=8'h59;
6'd29:lambda<=8'h41;
6'd30:lambda<=8'h2f;
6'd31:lambda<=8'h91;
                        endcase
                    end
                endcase
            end
            
            4'd15:begin
                case(index)
                    2'd0:begin
                        case(round)
                            6'd0:lambda<=8'ha6;
6'd1:lambda<=8'h86;
6'd2:lambda<=8'hb5;
6'd3:lambda<=8'h94;
6'd4:lambda<=8'h48;
6'd5:lambda<=8'hec;
6'd6:lambda<=8'h29;
6'd7:lambda<=8'h3;
6'd8:lambda<=8'hd5;
6'd9:lambda<=8'hdf;
6'd10:lambda<=8'hac;
6'd11:lambda<=8'hca;
6'd12:lambda<=8'h6c;
6'd13:lambda<=8'h69;
6'd14:lambda<=8'h55;
6'd15:lambda<=8'hb2;
6'd16:lambda<=8'h95;
6'd17:lambda<=8'h7e;
6'd18:lambda<=8'h41;
6'd19:lambda<=8'h88;
6'd20:lambda<=8'h21;
6'd21:lambda<=8'h1e;
6'd22:lambda<=8'he6;
6'd23:lambda<=8'h54;
6'd24:lambda<=8'h3b;
6'd25:lambda<=8'hbc;
6'd26:lambda<=8'h63;
6'd27:lambda<=8'hdd;
6'd28:lambda<=8'he0;
6'd29:lambda<=8'he7;
6'd30:lambda<=8'h8e;
6'd31:lambda<=8'h4;
                        endcase
                    end
                    
                    2'd1:begin
                        case(round)
                            6'd0:lambda<=8'h99;
6'd1:lambda<=8'hd8;
6'd2:lambda<=8'h7e;
6'd3:lambda<=8'h77;
6'd4:lambda<=8'hf6;
6'd5:lambda<=8'h2;
6'd6:lambda<=8'h71;
6'd7:lambda<=8'h2d;
6'd8:lambda<=8'hb5;
6'd9:lambda<=8'h29;
6'd10:lambda<=8'h4;
6'd11:lambda<=8'h7f;
6'd12:lambda<=8'hb8;
6'd13:lambda<=8'h4d;
6'd14:lambda<=8'h4c;
6'd15:lambda<=8'h6d;
6'd16:lambda<=8'h93;
6'd17:lambda<=8'hf5;
6'd18:lambda<=8'h94;
6'd19:lambda<=8'hb6;
6'd20:lambda<=8'h71;
6'd21:lambda<=8'h51;
6'd22:lambda<=8'hc2;
6'd23:lambda<=8'h35;
6'd24:lambda<=8'h48;
6'd25:lambda<=8'h22;
6'd26:lambda<=8'hbb;
6'd27:lambda<=8'h34;
6'd28:lambda<=8'hd1;
6'd29:lambda<=8'h6a;
6'd30:lambda<=8'h62;
6'd31:lambda<=8'h6f;
                        endcase
                    end
                    
                    2'd2:begin
                        case(round)
                            6'd0:lambda<=8'ha1;
6'd1:lambda<=8'h1e;
6'd2:lambda<=8'h55;
6'd3:lambda<=8'haf;
6'd4:lambda<=8'hcb;
6'd5:lambda<=8'he3;
6'd6:lambda<=8'hc1;
6'd7:lambda<=8'hd1;
6'd8:lambda<=8'h17;
6'd9:lambda<=8'h1;
6'd10:lambda<=8'h60;
6'd11:lambda<=8'h5f;
6'd12:lambda<=8'h39;
6'd13:lambda<=8'he;
6'd14:lambda<=8'h8f;
6'd15:lambda<=8'h4d;
6'd16:lambda<=8'h62;
6'd17:lambda<=8'h96;
6'd18:lambda<=8'h9e;
6'd19:lambda<=8'h34;
6'd20:lambda<=8'hd6;
6'd21:lambda<=8'h1;
6'd22:lambda<=8'h8;
6'd23:lambda<=8'hee;
6'd24:lambda<=8'h5a;
6'd25:lambda<=8'h38;
6'd26:lambda<=8'hdb;
6'd27:lambda<=8'h4c;
6'd28:lambda<=8'hf6;
6'd29:lambda<=8'hbe;
6'd30:lambda<=8'hc1;
6'd31:lambda<=8'h2d;
                        endcase
                    end
                    
                    2'd3:begin
                        case(round)
                            6'd0:lambda<=8'h1f;
6'd1:lambda<=8'h3c;
6'd2:lambda<=8'h97;
6'd3:lambda<=8'h65;
6'd4:lambda<=8'hf3;
6'd5:lambda<=8'hdc;
6'd6:lambda<=8'h28;
6'd7:lambda<=8'hb2;
6'd8:lambda<=8'h1e;
6'd9:lambda<=8'h45;
6'd10:lambda<=8'h79;
6'd11:lambda<=8'h8a;
6'd12:lambda<=8'h44;
6'd13:lambda<=8'h62;
6'd14:lambda<=8'h6;
6'd15:lambda<=8'hf6;
6'd16:lambda<=8'h65;
6'd17:lambda<=8'hc5;
6'd18:lambda<=8'h6c;
6'd19:lambda<=8'h9b;
6'd20:lambda<=8'hde;
6'd21:lambda<=8'h7d;
6'd22:lambda<=8'h13;
6'd23:lambda<=8'h4f;
6'd24:lambda<=8'h76;
6'd25:lambda<=8'h9c;
6'd26:lambda<=8'h94;
6'd27:lambda<=8'he7;
6'd28:lambda<=8'hae;
6'd29:lambda<=8'h41;
6'd30:lambda<=8'h63;
6'd31:lambda<=8'h80;
                        endcase
                    end
                endcase
            end
            
            default:begin
                lambda<=8'h0;
            end
        endcase
    end
        
endmodule


module s_box(
    input [7:0] s_in,
    output reg [7:0] s_out														
);
 
always@(*)
	case(s_in)
	8'h00: s_out <=	8'hd6;
	8'h01: s_out <=	8'h90;
	8'h02: s_out <=	8'he9;
	8'h03: s_out <=	8'hfe;
	8'h04: s_out <=	8'hcc;
	8'h05: s_out <=	8'he1;
	8'h06: s_out <=	8'h3d;
	8'h07: s_out <=	8'hb7;
	8'h08: s_out <=	8'h16;
	8'h09: s_out <=	8'hb6;
	8'h0a: s_out <=	8'h14;
	8'h0b: s_out <=	8'hc2;
	8'h0c: s_out <=	8'h28;
	8'h0d: s_out <=	8'hfb;
	8'h0e: s_out <=	8'h2c;
	8'h0f: s_out <=	8'h05;
	8'h10: s_out <=	8'h2b;
	8'h11: s_out <=	8'h67;
	8'h12: s_out <=	8'h9a;
	8'h13: s_out <=	8'h76;
	8'h14: s_out <=	8'h2a;
	8'h15: s_out <=	8'hbe;
	8'h16: s_out <=	8'h04;
	8'h17: s_out <=	8'hc3;
	8'h18: s_out <=	8'haa;
	8'h19: s_out <=	8'h44;
	8'h1a: s_out <=	8'h13;
	8'h1b: s_out <=	8'h26;
	8'h1c: s_out <=	8'h49;
	8'h1d: s_out <=	8'h86;
	8'h1e: s_out <=	8'h06;
	8'h1f: s_out <=	8'h99;
	8'h20: s_out <=	8'h9c;
	8'h21: s_out <=	8'h42;
	8'h22: s_out <=	8'h50;
	8'h23: s_out <=	8'hf4;
	8'h24: s_out <=	8'h91;
	8'h25: s_out <=	8'hef;
	8'h26: s_out <=	8'h98;
	8'h27: s_out <=	8'h7a;
	8'h28: s_out <=	8'h33;
	8'h29: s_out <=	8'h54;
	8'h2a: s_out <=	8'h0b;
	8'h2b: s_out <=	8'h43;
	8'h2c: s_out <=	8'hed;
	8'h2d: s_out <=	8'hcf;
	8'h2e: s_out <=	8'hac;
	8'h2f: s_out <=	8'h62;
	8'h30: s_out <=	8'he4;
	8'h31: s_out <=	8'hb3;
	8'h32: s_out <=	8'h1c;
	8'h33: s_out <=	8'ha9;
	8'h34: s_out <=	8'hc9;
	8'h35: s_out <=	8'h08;
	8'h36: s_out <=	8'he8;
	8'h37: s_out <=	8'h95;
	8'h38: s_out <=	8'h80;
	8'h39: s_out <=	8'hdf;
	8'h3a: s_out <=	8'h94;
	8'h3b: s_out <=	8'hfa;
	8'h3c: s_out <=	8'h75;
	8'h3d: s_out <=	8'h8f;
	8'h3e: s_out <=	8'h3f;
	8'h3f: s_out <=	8'ha6;
	8'h40: s_out <=	8'h47;
	8'h41: s_out <=	8'h07;
	8'h42: s_out <=	8'ha7;
	8'h43: s_out <=	8'hfc;
	8'h44: s_out <=	8'hf3;
	8'h45: s_out <=	8'h73;
	8'h46: s_out <=	8'h17;
	8'h47: s_out <=	8'hba;
	8'h48: s_out <=	8'h83;
	8'h49: s_out <=	8'h59;
	8'h4a: s_out <=	8'h3c;
	8'h4b: s_out <=	8'h19;
	8'h4c: s_out <=	8'he6;
	8'h4d: s_out <=	8'h85;
	8'h4e: s_out <=	8'h4f;
	8'h4f: s_out <=	8'ha8;
	8'h50: s_out <=	8'h68;
	8'h51: s_out <=	8'h6b;
	8'h52: s_out <=	8'h81;
	8'h53: s_out <=	8'hb2;
	8'h54: s_out <=	8'h71;
	8'h55: s_out <=	8'h64;
	8'h56: s_out <=	8'hda;
	8'h57: s_out <=	8'h8b;
	8'h58: s_out <=	8'hf8;
	8'h59: s_out <=	8'heb;
	8'h5a: s_out <=	8'h0f;
	8'h5b: s_out <=	8'h4b;
	8'h5c: s_out <=	8'h70;
	8'h5d: s_out <=	8'h56;
	8'h5e: s_out <=	8'h9d;
	8'h5f: s_out <=	8'h35;
	8'h60: s_out <=	8'h1e;
	8'h61: s_out <=	8'h24;
	8'h62: s_out <=	8'h0e;
	8'h63: s_out <=	8'h5e;
	8'h64: s_out <=	8'h63;
	8'h65: s_out <=	8'h58;
	8'h66: s_out <=	8'hd1;
	8'h67: s_out <=	8'ha2;
	8'h68: s_out <=	8'h25;
	8'h69: s_out <=	8'h22;
	8'h6a: s_out <=	8'h7c;
	8'h6b: s_out <=	8'h3b;
	8'h6c: s_out <=	8'h01;
	8'h6d: s_out <=	8'h21;
	8'h6e: s_out <=	8'h78;
	8'h6f: s_out <=	8'h87;
	8'h70: s_out <=	8'hd4;
	8'h71: s_out <=	8'h00;
	8'h72: s_out <=	8'h46;
	8'h73: s_out <=	8'h57;
	8'h74: s_out <=	8'h9f;
	8'h75: s_out <=	8'hd3;
	8'h76: s_out <=	8'h27;
	8'h77: s_out <=	8'h52;
	8'h78: s_out <=	8'h4c;
	8'h79: s_out <=	8'h36;
	8'h7a: s_out <=	8'h02;
	8'h7b: s_out <=	8'he7;
	8'h7c: s_out <=	8'ha0;
	8'h7d: s_out <=	8'hc4;
	8'h7e: s_out <=	8'hc8;
	8'h7f: s_out <=	8'h9e;
	8'h80: s_out <=	8'hea;
	8'h81: s_out <=	8'hbf;
	8'h82: s_out <=	8'h8a;
	8'h83: s_out <=	8'hd2;
	8'h84: s_out <=	8'h40;
	8'h85: s_out <=	8'hc7;
	8'h86: s_out <=	8'h38;
	8'h87: s_out <=	8'hb5;
	8'h88: s_out <=	8'ha3;
	8'h89: s_out <=	8'hf7;
	8'h8a: s_out <=	8'hf2;
	8'h8b: s_out <=	8'hce;
	8'h8c: s_out <=	8'hf9;
	8'h8d: s_out <=	8'h61;
	8'h8e: s_out <=	8'h15;
	8'h8f: s_out <=	8'ha1;
	8'h90: s_out <=	8'he0;
	8'h91: s_out <=	8'hae;
	8'h92: s_out <=	8'h5d;
	8'h93: s_out <=	8'ha4;
	8'h94: s_out <=	8'h9b;
	8'h95: s_out <=	8'h34;
	8'h96: s_out <=	8'h1a;
	8'h97: s_out <=	8'h55;
	8'h98: s_out <=	8'had;
	8'h99: s_out <=	8'h93;
	8'h9a: s_out <=	8'h32;
	8'h9b: s_out <=	8'h30;
	8'h9c: s_out <=	8'hf5;
	8'h9d: s_out <=	8'h8c;
	8'h9e: s_out <=	8'hb1;
	8'h9f: s_out <=	8'he3;
	8'ha0: s_out <=	8'h1d;
	8'ha1: s_out <=	8'hf6;
	8'ha2: s_out <=	8'he2;
	8'ha3: s_out <=	8'h2e;
	8'ha4: s_out <=	8'h82;
	8'ha5: s_out <=	8'h66;
	8'ha6: s_out <=	8'hca;
	8'ha7: s_out <=	8'h60;
	8'ha8: s_out <=	8'hc0;
	8'ha9: s_out <=	8'h29;
	8'haa: s_out <=	8'h23;
	8'hab: s_out <=	8'hab;
	8'hac: s_out <=	8'h0d;
	8'had: s_out <=	8'h53;
	8'hae: s_out <=	8'h4e;
	8'haf: s_out <=	8'h6f;
	8'hb0: s_out <=	8'hd5;
	8'hb1: s_out <=	8'hdb;
	8'hb2: s_out <=	8'h37;
	8'hb3: s_out <=	8'h45;
	8'hb4: s_out <=	8'hde;
	8'hb5: s_out <=	8'hfd;
	8'hb6: s_out <=	8'h8e;
	8'hb7: s_out <=	8'h2f;
	8'hb8: s_out <=	8'h03;
	8'hb9: s_out <=	8'hff;
	8'hba: s_out <=	8'h6a;
	8'hbb: s_out <=	8'h72;
	8'hbc: s_out <=	8'h6d;
	8'hbd: s_out <=	8'h6c;
	8'hbe: s_out <=	8'h5b;
	8'hbf: s_out <=	8'h51;
	8'hc0: s_out <=	8'h8d;
	8'hc1: s_out <=	8'h1b;
	8'hc2: s_out <=	8'haf;
	8'hc3: s_out <=	8'h92;
	8'hc4: s_out <=	8'hbb;
	8'hc5: s_out <=	8'hdd;
	8'hc6: s_out <=	8'hbc;
	8'hc7: s_out <=	8'h7f;
	8'hc8: s_out <=	8'h11;
	8'hc9: s_out <=	8'hd9;
	8'hca: s_out <=	8'h5c;
	8'hcb: s_out <=	8'h41;
	8'hcc: s_out <=	8'h1f;
	8'hcd: s_out <=	8'h10;
	8'hce: s_out <=	8'h5a;
	8'hcf: s_out <=	8'hd8;
	8'hd0: s_out <=	8'h0a;
	8'hd1: s_out <=	8'hc1;
	8'hd2: s_out <=	8'h31;
	8'hd3: s_out <=	8'h88;
	8'hd4: s_out <=	8'ha5;
	8'hd5: s_out <=	8'hcd;
	8'hd6: s_out <=	8'h7b;
	8'hd7: s_out <=	8'hbd;
	8'hd8: s_out <=	8'h2d;
	8'hd9: s_out <=	8'h74;
	8'hda: s_out <=	8'hd0;
	8'hdb: s_out <=	8'h12;
	8'hdc: s_out <=	8'hb8;
	8'hdd: s_out <=	8'he5;
	8'hde: s_out <=	8'hb4;
	8'hdf: s_out <=	8'hb0;
	8'he0: s_out <=	8'h89;
	8'he1: s_out <=	8'h69;
	8'he2: s_out <=	8'h97;
	8'he3: s_out <=	8'h4a;
	8'he4: s_out <=	8'h0c;
	8'he5: s_out <=	8'h96;
	8'he6: s_out <=	8'h77;
	8'he7: s_out <=	8'h7e;
	8'he8: s_out <=	8'h65;
	8'he9: s_out <=	8'hb9;
	8'hea: s_out <=	8'hf1;
	8'heb: s_out <=	8'h09;
	8'hec: s_out <=	8'hc5;
	8'hed: s_out <=	8'h6e;
	8'hee: s_out <=	8'hc6;
	8'hef: s_out <=	8'h84;
	8'hf0: s_out <=	8'h18;
	8'hf1: s_out <=	8'hf0;
	8'hf2: s_out <=	8'h7d;
	8'hf3: s_out <=	8'hec;
	8'hf4: s_out <=	8'h3a;
	8'hf5: s_out <=	8'hdc;
	8'hf6: s_out <=	8'h4d;
	8'hf7: s_out <=	8'h20;
	8'hf8: s_out <=	8'h79;
	8'hf9: s_out <=	8'hee;
	8'hfa: s_out <=	8'h5f;
	8'hfb: s_out <=	8'h3e;
	8'hfc: s_out <=	8'hd7;
	8'hfd: s_out <=	8'hcb;
	8'hfe: s_out <=	8'h39;
	8'hff: s_out <=	8'h48;
	default: s_out <= 8'h00;
	endcase
endmodule


module get_cki(
   input [4:0] round_cnt,
	output reg [31:0] cki
);
 
always@(*)
	case(round_cnt)
	5'h00: cki <= 32'h00070e15;
	5'h01: cki <= 32'h1c232a31;
	5'h02: cki <= 32'h383f464d;
	5'h03: cki <= 32'h545b6269;
	5'h04: cki <= 32'h70777e85;
	5'h05: cki <= 32'h8c939aa1;
	5'h06: cki <= 32'ha8afb6bd;
	5'h07: cki <= 32'hc4cbd2d9;
	5'h08: cki <= 32'he0e7eef5;
	5'h09: cki <= 32'hfc030a11;
	5'h0a: cki <= 32'h181f262d;
	5'h0b: cki <= 32'h343b4249;
	5'h0c: cki <= 32'h50575e65;
	5'h0d: cki <= 32'h6c737a81;
	5'h0e: cki <= 32'h888f969d;
	5'h0f: cki <= 32'ha4abb2b9;
	5'h10: cki <= 32'hc0c7ced5;
	5'h11: cki <= 32'hdce3eaf1;
	5'h12: cki <= 32'hf8ff060d;
	5'h13: cki <= 32'h141b2229;
	5'h14: cki <= 32'h30373e45;
	5'h15: cki <= 32'h4c535a61;
	5'h16: cki <= 32'h686f767d;
	5'h17: cki <= 32'h848b9299;
	5'h18: cki <= 32'ha0a7aeb5;
	5'h19: cki <= 32'hbcc3cad1;
	5'h1a: cki <= 32'hd8dfe6ed;
	5'h1b: cki <= 32'hf4fb0209;
	5'h1c: cki <= 32'h10171e25;
	5'h1d: cki <= 32'h2c333a41;
	5'h1e: cki <= 32'h484f565d;
	5'h1f: cki <= 32'h646b7279;
	default: cki <= 32'h0;
	endcase
endmodule

module get_lambda_for_all_users(
    input [4:0] round,
    
    output [511:0] Lambda
);
    wire [31:0] user0, user1, user2, user3, user4, user5, user6, user7, user8, user9, user10, user11, user12, user13, user14, user15;
    assign Lambda={user15, user14, user13, user12, user11, user10, user9, user8, user7, user6, user5, user4, user3, user2, user1, user0};
    
    get_lambda GL1_user0(round, 2'd0, 4'd0, user0[7:0]);
    get_lambda GL2_user0(round, 2'd1, 4'd0, user0[15:8]);
    get_lambda GL3_user0(round, 2'd2, 4'd0, user0[23:16]);
    get_lambda GL4_user0(round, 2'd3, 4'd0, user0[31:24]);
    
    get_lambda GL1_user1(round, 2'd0, 4'd0, user1[7:0]);
    get_lambda GL2_user1(round, 2'd1, 4'd0, user1[15:8]);
    get_lambda GL3_user1(round, 2'd2, 4'd0, user1[23:16]);
    get_lambda GL4_user1(round, 2'd3, 4'd0, user1[31:24]);
    
    get_lambda GL1_user2(round, 2'd0, 4'd0, user2[7:0]);
    get_lambda GL2_user2(round, 2'd1, 4'd0, user2[15:8]);
    get_lambda GL3_user2(round, 2'd2, 4'd0, user2[23:16]);
    get_lambda GL4_user2(round, 2'd3, 4'd0, user2[31:24]);
    
    get_lambda GL1_user3(round, 2'd0, 4'd0, user3[7:0]);
    get_lambda GL2_user3(round, 2'd1, 4'd0, user3[15:8]);
    get_lambda GL3_user3(round, 2'd2, 4'd0, user3[23:16]);
    get_lambda GL4_user3(round, 2'd3, 4'd0, user3[31:24]);
    
    get_lambda GL1_user4(round, 2'd0, 4'd0, user4[7:0]);
    get_lambda GL2_user4(round, 2'd1, 4'd0, user4[15:8]);
    get_lambda GL3_user4(round, 2'd2, 4'd0, user4[23:16]);
    get_lambda GL4_user4(round, 2'd3, 4'd0, user4[31:24]);
    
    get_lambda GL1_user5(round, 2'd0, 4'd0, user5[7:0]);
    get_lambda GL2_user5(round, 2'd1, 4'd0, user5[15:8]);
    get_lambda GL3_user5(round, 2'd2, 4'd0, user5[23:16]);
    get_lambda GL4_user5(round, 2'd3, 4'd0, user5[31:24]);
    
    get_lambda GL1_user6(round, 2'd0, 4'd0, user6[7:0]);
    get_lambda GL2_user6(round, 2'd1, 4'd0, user6[15:8]);
    get_lambda GL3_user6(round, 2'd2, 4'd0, user6[23:16]);
    get_lambda GL4_user6(round, 2'd3, 4'd0, user6[31:24]);
    
    get_lambda GL1_user7(round, 2'd0, 4'd0, user7[7:0]);
    get_lambda GL2_user7(round, 2'd1, 4'd0, user7[15:8]);
    get_lambda GL3_user7(round, 2'd2, 4'd0, user7[23:16]);
    get_lambda GL4_user7(round, 2'd3, 4'd0, user7[31:24]);
    
    get_lambda GL1_user8(round, 2'd0, 4'd0, user8[7:0]);
    get_lambda GL2_user8(round, 2'd1, 4'd0, user8[15:8]);
    get_lambda GL3_user8(round, 2'd2, 4'd0, user8[23:16]);
    get_lambda GL4_user8(round, 2'd3, 4'd0, user8[31:24]);
    
    get_lambda GL1_user9(round, 2'd0, 4'd0, user9[7:0]);
    get_lambda GL2_user9(round, 2'd1, 4'd0, user9[15:8]);
    get_lambda GL3_user9(round, 2'd2, 4'd0, user9[23:16]);
    get_lambda GL4_user9(round, 2'd3, 4'd0, user9[31:24]);
    
    get_lambda GL1_user10(round, 2'd0, 4'd0, user10[7:0]);
    get_lambda GL2_user10(round, 2'd1, 4'd0, user10[15:8]);
    get_lambda GL3_user10(round, 2'd2, 4'd0, user10[23:16]);
    get_lambda GL4_user10(round, 2'd3, 4'd0, user10[31:24]);
    
    get_lambda GL1_user11(round, 2'd0, 4'd0, user11[7:0]);
    get_lambda GL2_user11(round, 2'd1, 4'd0, user11[15:8]);
    get_lambda GL3_user11(round, 2'd2, 4'd0, user11[23:16]);
    get_lambda GL4_user11(round, 2'd3, 4'd0, user11[31:24]);
    
    get_lambda GL1_user12(round, 2'd0, 4'd0, user12[7:0]);
    get_lambda GL2_user12(round, 2'd1, 4'd0, user12[15:8]);
    get_lambda GL3_user12(round, 2'd2, 4'd0, user12[23:16]);
    get_lambda GL4_user12(round, 2'd3, 4'd0, user12[31:24]);
    
    get_lambda GL1_user13(round, 2'd0, 4'd0, user13[7:0]);
    get_lambda GL2_user13(round, 2'd1, 4'd0, user13[15:8]);
    get_lambda GL3_user13(round, 2'd2, 4'd0, user13[23:16]);
    get_lambda GL4_user13(round, 2'd3, 4'd0, user13[31:24]);
    
    get_lambda GL1_user14(round, 2'd0, 4'd0, user14[7:0]);
    get_lambda GL2_user14(round, 2'd1, 4'd0, user14[15:8]);
    get_lambda GL3_user14(round, 2'd2, 4'd0, user14[23:16]);
    get_lambda GL4_user14(round, 2'd3, 4'd0, user14[31:24]);
    
    get_lambda GL1_user15(round, 2'd0, 4'd0, user15[7:0]);
    get_lambda GL2_user15(round, 2'd1, 4'd0, user15[15:8]);
    get_lambda GL3_user15(round, 2'd2, 4'd0, user15[23:16]);
    get_lambda GL4_user15(round, 2'd3, 4'd0, user15[31:24]);
    
endmodule


module shift_left_13(
    input [31:0] data,
    output [31:0] result
);
    assign result={data[18:0], data[31:19]};
endmodule

module shift_left_23(
    input [31:0] data,
    output [31:0] result
);
    assign result={data[8:0], data[31:9]};
endmodule

module L_matrix(
    input [31:0] data,
    output [31:0] result
);
    wire [31:0] result13, result23;
    shift_left_13 SL13(data, result13);
    shift_left_23 SL23(data, result23);
    assign result=result13 ^ result23;
endmodule

module get_tapes_final_8(
    input [3:0] tk,
    input [3:0] user,
    
    output reg [7:0] out_data
);
    always@(*)
    begin
        case(user)
            4'd0:begin
                case(tk)
                   4'd0:out_data<=8'ha1;
4'd1:out_data<=8'h2e;
4'd2:out_data<=8'h91;
4'd3:out_data<=8'hc4;
4'd4:out_data<=8'h98;
4'd5:out_data<=8'hc5;
4'd6:out_data<=8'h27;
4'd7:out_data<=8'ha6;
4'd8:out_data<=8'h25;
4'd9:out_data<=8'he7;
4'd10:out_data<=8'h44;
4'd11:out_data<=8'hdf;
4'd12:out_data<=8'h7c;
4'd13:out_data<=8'he5;
4'd14:out_data<=8'h1a;
4'd15:out_data<=8'h79; 
default:out_data<=8'h2e;
                endcase
            end
            
            4'd1:begin
                case(tk)
                    4'd0:out_data<=8'h69;
4'd1:out_data<=8'h3e;
4'd2:out_data<=8'hec;
4'd3:out_data<=8'h19;
4'd4:out_data<=8'h82;
4'd5:out_data<=8'h81;
4'd6:out_data<=8'h12;
4'd7:out_data<=8'h38;
4'd8:out_data<=8'h77;
4'd9:out_data<=8'h19;
4'd10:out_data<=8'hcb;
4'd11:out_data<=8'hae;
4'd12:out_data<=8'h86;
4'd13:out_data<=8'hf4;
4'd14:out_data<=8'ha5;
4'd15:out_data<=8'h7e;
default:out_data<=8'h3e;
                endcase
            end
            
            4'd2:begin
                case(tk)
                    4'd0:out_data<=8'h4d;
4'd1:out_data<=8'hb6;
4'd2:out_data<=8'hb2;
4'd3:out_data<=8'h9a;
4'd4:out_data<=8'h3e;
4'd5:out_data<=8'hf2;
4'd6:out_data<=8'hda;
4'd7:out_data<=8'h6;
4'd8:out_data<=8'h7e;
4'd9:out_data<=8'h53;
4'd10:out_data<=8'h17;
4'd11:out_data<=8'h2d;
4'd12:out_data<=8'hdb;
4'd13:out_data<=8'hda;
4'd14:out_data<=8'hca;
4'd15:out_data<=8'h5f;
default:out_data<=8'hb6;
                endcase
            end
            
            4'd3:begin
                case(tk)
                    4'd0:out_data<=8'h63;
4'd1:out_data<=8'h61;
4'd2:out_data<=8'h31;
4'd3:out_data<=8'hdb;
4'd4:out_data<=8'h87;
4'd5:out_data<=8'ha;
4'd6:out_data<=8'ha0;
4'd7:out_data<=8'hed;
4'd8:out_data<=8'h10;
4'd9:out_data<=8'h6f;
4'd10:out_data<=8'hc5;
4'd11:out_data<=8'h2d;
4'd12:out_data<=8'hb3;
4'd13:out_data<=8'hf7;
4'd14:out_data<=8'h58;
4'd15:out_data<=8'h4d;
default:out_data<=8'h61;
                endcase
            end
            
            4'd4:begin
                case(tk)
                    4'd0:out_data<=8'hef;
4'd1:out_data<=8'h31;
4'd2:out_data<=8'h34;
4'd3:out_data<=8'h53;
4'd4:out_data<=8'hb6;
4'd5:out_data<=8'hc4;
4'd6:out_data<=8'haa;
4'd7:out_data<=8'hdf;
4'd8:out_data<=8'h86;
4'd9:out_data<=8'h24;
4'd10:out_data<=8'h7;
4'd11:out_data<=8'h1;
4'd12:out_data<=8'hfa;
4'd13:out_data<=8'hc7;
4'd14:out_data<=8'h79;
4'd15:out_data<=8'hba;
default:out_data<=8'h31;
                endcase
            end
            
            4'd5:begin
                case(tk)
                    4'd0:out_data<=8'h73;
4'd1:out_data<=8'h4b;
4'd2:out_data<=8'h11;
4'd3:out_data<=8'hcd;
4'd4:out_data<=8'h9;
4'd5:out_data<=8'h2;
4'd6:out_data<=8'h41;
4'd7:out_data<=8'h3;
4'd8:out_data<=8'h47;
4'd9:out_data<=8'h0;
4'd10:out_data<=8'h4f;
4'd11:out_data<=8'hf3;
4'd12:out_data<=8'ha;
4'd13:out_data<=8'he8;
4'd14:out_data<=8'h32;
4'd15:out_data<=8'h7b;
default:out_data<=8'h4b;
                endcase
            end
            
            4'd6:begin
                case(tk)
                    4'd0:out_data<=8'ha1;
4'd1:out_data<=8'h31;
4'd2:out_data<=8'hae;
4'd3:out_data<=8'h83;
4'd4:out_data<=8'hb7;
4'd5:out_data<=8'hca;
4'd6:out_data<=8'h75;
4'd7:out_data<=8'h84;
4'd8:out_data<=8'he4;
4'd9:out_data<=8'h92;
4'd10:out_data<=8'h2a;
4'd11:out_data<=8'hdb;
4'd12:out_data<=8'hef;
4'd13:out_data<=8'hf8;
4'd14:out_data<=8'hea;
4'd15:out_data<=8'hd8;
default:out_data<=8'h31;
                endcase
            end
            
            4'd7:begin
                case(tk)
                    4'd0:out_data<=8'hb9;
4'd1:out_data<=8'h2b;
4'd2:out_data<=8'h86;
4'd3:out_data<=8'h97;
4'd4:out_data<=8'h72;
4'd5:out_data<=8'hcf;
4'd6:out_data<=8'h5a;
4'd7:out_data<=8'hc;
4'd8:out_data<=8'h9a;
4'd9:out_data<=8'h17;
4'd10:out_data<=8'hc8;
4'd11:out_data<=8'hdb;
4'd12:out_data<=8'h58;
4'd13:out_data<=8'h67;
4'd14:out_data<=8'h57;
4'd15:out_data<=8'h29;
default:out_data<=8'h2b;
                endcase
            end
            
            4'd8:begin
                case(tk)
                    4'd0:out_data<=8'hf9;
4'd1:out_data<=8'hb5;
4'd2:out_data<=8'h84;
4'd3:out_data<=8'ha7;
4'd4:out_data<=8'h3e;
4'd5:out_data<=8'hb0;
4'd6:out_data<=8'h65;
4'd7:out_data<=8'h70;
4'd8:out_data<=8'h54;
4'd9:out_data<=8'ha5;
4'd10:out_data<=8'h37;
4'd11:out_data<=8'h25;
4'd12:out_data<=8'h99;
4'd13:out_data<=8'h44;
4'd14:out_data<=8'h98;
4'd15:out_data<=8'hc3;
default:out_data<=8'hb5;
                endcase
            end
            
            4'd9:begin
                case(tk)
                    4'd0:out_data<=8'hc1;
4'd1:out_data<=8'ha8;
4'd2:out_data<=8'hcf;
4'd3:out_data<=8'hcd;
4'd4:out_data<=8'hf9;
4'd5:out_data<=8'h6b;
4'd6:out_data<=8'hd5;
4'd7:out_data<=8'h21;
4'd8:out_data<=8'hb4;
4'd9:out_data<=8'h9a;
4'd10:out_data<=8'hf1;
4'd11:out_data<=8'h99;
4'd12:out_data<=8'h57;
4'd13:out_data<=8'h5b;
4'd14:out_data<=8'hd8;
4'd15:out_data<=8'hd;
default:out_data<=8'ha8;
                endcase
            end
            
            4'd10:begin
                case(tk)
                    4'd0:out_data<=8'h2e;
4'd1:out_data<=8'h2c;
4'd2:out_data<=8'hd2;
4'd3:out_data<=8'he6;
4'd4:out_data<=8'h97;
4'd5:out_data<=8'h5d;
4'd6:out_data<=8'hb8;
4'd7:out_data<=8'h51;
4'd8:out_data<=8'hb4;
4'd9:out_data<=8'h7d;
4'd10:out_data<=8'h9;
4'd11:out_data<=8'h28;
4'd12:out_data<=8'h87;
4'd13:out_data<=8'h73;
4'd14:out_data<=8'ha4;
4'd15:out_data<=8'h54;
default:out_data<=8'h2e;
                endcase
            end
            
            4'd11:begin
                case(tk)
                    4'd0:out_data<=8'hd9;
4'd1:out_data<=8'hf3;
4'd2:out_data<=8'hc7;
4'd3:out_data<=8'hbd;
4'd4:out_data<=8'he4;
4'd5:out_data<=8'hb1;
4'd6:out_data<=8'h7d;
4'd7:out_data<=8'hb5;
4'd8:out_data<=8'h36;
4'd9:out_data<=8'hee;
4'd10:out_data<=8'h6f;
4'd11:out_data<=8'h83;
4'd12:out_data<=8'hd3;
4'd13:out_data<=8'h7e;
4'd14:out_data<=8'h59;
4'd15:out_data<=8'h76;
default:out_data<=8'hd9;
                endcase
            end
            
            4'd12:begin
                case(tk)
                    4'd0:out_data<=8'h38;
4'd1:out_data<=8'h49;
4'd2:out_data<=8'hda;
4'd3:out_data<=8'h5e;
4'd4:out_data<=8'h1b;
4'd5:out_data<=8'h2d;
4'd6:out_data<=8'h88;
4'd7:out_data<=8'he;
4'd8:out_data<=8'h3;
4'd9:out_data<=8'h88;
4'd10:out_data<=8'h46;
4'd11:out_data<=8'h63;
4'd12:out_data<=8'h63;
4'd13:out_data<=8'hd4;
4'd14:out_data<=8'h6a;
4'd15:out_data<=8'hbe;
default:out_data<=8'h38;
                endcase
            end
            
            4'd13:begin
                case(tk)
4'd0:out_data<=8'h95;
4'd1:out_data<=8'h82;
4'd2:out_data<=8'he9;
4'd3:out_data<=8'hec;
4'd4:out_data<=8'h9b;
4'd5:out_data<=8'h6;
4'd6:out_data<=8'h1d;
4'd7:out_data<=8'he7;
4'd8:out_data<=8'he9;
4'd9:out_data<=8'hac;
4'd10:out_data<=8'h6d;
4'd11:out_data<=8'hd8;
4'd12:out_data<=8'h93;
4'd13:out_data<=8'h71;
4'd14:out_data<=8'hca;
4'd15:out_data<=8'hc;
default:out_data<=8'h95;
                endcase
            end
            
            4'd14:begin
                case(tk)
                    4'd0:out_data<=8'h22;
4'd1:out_data<=8'h97;
4'd2:out_data<=8'h90;
4'd3:out_data<=8'h17;
4'd4:out_data<=8'hc;
4'd5:out_data<=8'ha9;
4'd6:out_data<=8'h5;
4'd7:out_data<=8'h22;
4'd8:out_data<=8'hfc;
4'd9:out_data<=8'h9e;
4'd10:out_data<=8'h5;
4'd11:out_data<=8'hb6;
4'd12:out_data<=8'hae;
4'd13:out_data<=8'hb8;
4'd14:out_data<=8'hc4;
4'd15:out_data<=8'h55;
default:out_data<=8'h22;
                endcase
            end
            
            4'd15:begin
                case(tk)
                    4'd0:out_data<=8'h90;
4'd1:out_data<=8'h49;
4'd2:out_data<=8'hca;
4'd3:out_data<=8'hfc;
4'd4:out_data<=8'hf8;
4'd5:out_data<=8'h61;
4'd6:out_data<=8'h55;
4'd7:out_data<=8'hb2;
4'd8:out_data<=8'hdd;
4'd9:out_data<=8'h20;
4'd10:out_data<=8'h43;
4'd11:out_data<=8'h60;
4'd12:out_data<=8'hc3;
4'd13:out_data<=8'h5;
4'd14:out_data<=8'ha;
4'd15:out_data<=8'hbc;
default:out_data<=8'h80;
                endcase
            end
            
            default:begin
                out_data<=8'd0;
            end
    endcase
    end

endmodule


module calculate_left_half(
    output [127:0] result
);

wire [7:0] User00, User01, User02, User03, User04, User05, User06, User07, User08, User09, User010, User011, User012, User013, User014, User015;
wire [7:0] User10, User11, User12, User13, User14, User15, User16, User17, User18, User19, User110x, User111x, User112x, User113x, User114x, User115x;
wire [7:0] User20, User21, User22, User23, User24, User25, User26, User27, User28, User29, User210, User211, User212, User213, User214, User215;
wire [7:0] User30, User31, User32, User33, User34, User35, User36, User37, User38, User39, User310, User311, User312, User313, User314, User315;
wire [7:0] User40, User41, User42, User43, User44, User45, User46, User47, User48, User49, User410, User411, User412, User413, User414, User415;
wire [7:0] User50, User51, User52, User53, User54, User55, User56, User57, User58, User59, User510, User511, User512, User513, User514, User515 ;
wire [7:0] User60, User61, User62, User63, User64, User65, User66, User67, User68, User69, User610, User611, User612, User613, User614, User615 ;
wire [7:0] User70, User71, User72, User73, User74, User75, User76, User77, User78, User79, User710, User711, User712, User713, User714, User715 ;
wire [7:0] User80, User81, User82, User83, User84, User85, User86, User87, User88, User89, User810, User811, User812, User813, User814, User815 ;
wire [7:0] User90, User91, User92, User93, User94, User95, User96, User97, User98, User99, User910, User911, User912, User913, User914, User915 ;
wire [7:0] User100, User101, User102, User103, User104, User105, User106, User107, User108, User109, User1010, User1011, User1012, User1013, User1014, User1015;
wire [7:0] User110, User111, User112, User113, User114, User115, User116, User117, User118, User119, User1110, User1111, User1112, User1113, User1114, User1115;
wire [7:0] User120, User121, User122, User123, User124, User125, User126, User127, User128, User129, User1210, User1211, User1212, User1213, User1214, User1215;
wire [7:0] User130, User131, User132, User133, User134, User135, User136, User137, User138, User139, User1310, User1311, User1312, User1313, User1314, User1315;
wire [7:0] User140, User141, User142, User143, User144, User145, User146, User147, User148, User149, User1410, User1411, User1412, User1413, User1414, User1415;
wire [7:0] User150, User151, User152, User153, User154, User155, User156, User157, User158, User159, User1510, User1511, User1512, User1513, User1514, User1515;

assign a0={User00, User01, User02, User03, User04, User05, User06, User07, User08, User09, User010, User011, User012, User013, User014, User015};
assign a1={User10, User11, User12, User13, User14, User15, User16, User17, User18, User19, User110, User111, User112, User113, User114, User115};
assign a2={User20, User21, User22, User23, User24, User25, User26, User27, User28, User29, User210, User211, User212, User213, User214, User215};
assign a3={User30, User31, User32, User33, User34, User35, User36, User37, User38, User39, User310, User311, User312, User313, User314, User315};
assign a4={User40, User41, User42, User43, User44, User45, User46, User47, User48, User49, User410, User411, User412, User413, User414, User415};
assign a5={User50, User51, User52, User53, User54, User55, User56, User57, User58, User59, User510, User511, User512, User513, User514, User515};
assign a6={User60, User61, User62, User63, User64, User65, User66, User67, User68, User69, User610, User611, User612, User613, User614, User615};
assign a7={User70, User71, User72, User73, User74, User75, User76, User77, User78, User79, User710, User711, User712, User713, User714, User715};
assign a8={User80, User81, User82, User83, User84, User85, User86, User87, User88, User89, User810, User811, User812, User813, User814, User815};
assign a9={User90, User91, User92, User93, User94, User95, User96, User97, User98, User99, User910, User911, User912, User913, User914, User915};
assign a10={User100, User101, User102, User103, User104, User105, User106, User107, User108, User109, User1010, User1011, User1012, User1013, User1014, User1015};
assign a11={User110, User111, User112, User113, User114, User115, User116, User117, User118, User119, User1110, User1111, User1112, User1113, User1114, User1115};
assign a12={User120, User121, User122, User123, User124, User125, User126, User127, User128, User129, User1210, User1211, User1212, User1213, User1214, User1215};
assign a13={User130, User131, User132, User133, User134, User135, User136, User137, User138, User139, User1310, User1311, User1312, User1313, User1314, User1315};
assign a14={User140, User141, User142, User143, User144, User145, User146, User147, User148, User149, User1410, User1411, User1412, User1413, User1414, User1415};
assign a15={User150, User151, User152, User153, User154, User155, User156, User157, User158, User159, User1510, User1511, User1512, User1513, User1514, User1515};

assign result=a0 ^ a1 ^ a2 ^ a3 ^ a4 ^ a5 ^ a6 ^ a7 ^ a8 ^ a9 ^ a10 ^ a11 ^ a12 ^ a13 ^ a14 ^ a15;

get_tapes_final_8 xuser00(4'd0,4'd0,User00);
get_tapes_final_8 xuser01(4'd0,4'd1,User01);
get_tapes_final_8 xuser02(4'd0,4'd2,User02);
get_tapes_final_8 xuser03(4'd0,4'd3,User03);
get_tapes_final_8 xuser04(4'd0,4'd4,User04);
get_tapes_final_8 xuser05(4'd0,4'd5,User05);
get_tapes_final_8 xuser06(4'd0,4'd6,User06);
get_tapes_final_8 xuser07(4'd0,4'd7,User07);
get_tapes_final_8 xuser08(4'd0,4'd8,User08);
get_tapes_final_8 xuser09(4'd0,4'd9,User09);
get_tapes_final_8 xuser010(4'd0,4'd10,User010);
get_tapes_final_8 xuser011(4'd0,4'd11,User011);
get_tapes_final_8 xuser012(4'd0,4'd12,User012);
get_tapes_final_8 xuser013(4'd0,4'd13,User013);
get_tapes_final_8 xuser014(4'd0,4'd14,User014);
get_tapes_final_8 xuser015(4'd0,4'd15,User015);
get_tapes_final_8 xuser10(4'd1,4'd0,User10);
get_tapes_final_8 xuser11(4'd1,4'd1,User11);
get_tapes_final_8 xuser12(4'd1,4'd2,User12);
get_tapes_final_8 xuser13(4'd1,4'd3,User13);
get_tapes_final_8 xuser14(4'd1,4'd4,User14);
get_tapes_final_8 xuser15(4'd1,4'd5,User15);
get_tapes_final_8 xuser16(4'd1,4'd6,User16);
get_tapes_final_8 xuser17(4'd1,4'd7,User17);
get_tapes_final_8 xuser18(4'd1,4'd8,User18);
get_tapes_final_8 xuser19(4'd1,4'd9,User19);
get_tapes_final_8 xuser110(4'd1,4'd10,User110x);
get_tapes_final_8 xuser111(4'd1,4'd11,User111x);
get_tapes_final_8 xuser112(4'd1,4'd12,User112x);
get_tapes_final_8 xuser113(4'd1,4'd13,User113x);
get_tapes_final_8 xuser114(4'd1,4'd14,User114x);
get_tapes_final_8 xuser115(4'd1,4'd15,User115x);
get_tapes_final_8 xuser20(4'd2,4'd0,User20);
get_tapes_final_8 xuser21(4'd2,4'd1,User21);
get_tapes_final_8 xuser22(4'd2,4'd2,User22);
get_tapes_final_8 xuser23(4'd2,4'd3,User23);
get_tapes_final_8 xuser24(4'd2,4'd4,User24);
get_tapes_final_8 xuser25(4'd2,4'd5,User25);
get_tapes_final_8 xuser26(4'd2,4'd6,User26);
get_tapes_final_8 xuser27(4'd2,4'd7,User27);
get_tapes_final_8 xuser28(4'd2,4'd8,User28);
get_tapes_final_8 xuser29(4'd2,4'd9,User29);
get_tapes_final_8 xuser210(4'd2,4'd10,User210);
get_tapes_final_8 xuser211(4'd2,4'd11,User211);
get_tapes_final_8 xuser212(4'd2,4'd12,User212);
get_tapes_final_8 xuser213(4'd2,4'd13,User213);
get_tapes_final_8 xuser214(4'd2,4'd14,User214);
get_tapes_final_8 xuser215(4'd2,4'd15,User215);
get_tapes_final_8 xuser30(4'd3,4'd0,User30);
get_tapes_final_8 xuser31(4'd3,4'd1,User31);
get_tapes_final_8 xuser32(4'd3,4'd2,User32);
get_tapes_final_8 xuser33(4'd3,4'd3,User33);
get_tapes_final_8 xuser34(4'd3,4'd4,User34);
get_tapes_final_8 xuser35(4'd3,4'd5,User35);
get_tapes_final_8 xuser36(4'd3,4'd6,User36);
get_tapes_final_8 xuser37(4'd3,4'd7,User37);
get_tapes_final_8 xuser38(4'd3,4'd8,User38);
get_tapes_final_8 xuser39(4'd3,4'd9,User39);
get_tapes_final_8 xuser310(4'd3,4'd10,User310);
get_tapes_final_8 xuser311(4'd3,4'd11,User311);
get_tapes_final_8 xuser312(4'd3,4'd12,User312);
get_tapes_final_8 xuser313(4'd3,4'd13,User313);
get_tapes_final_8 xuser314(4'd3,4'd14,User314);
get_tapes_final_8 xuser315(4'd3,4'd15,User315);
get_tapes_final_8 xuser40(4'd4,4'd0,User40);
get_tapes_final_8 xuser41(4'd4,4'd1,User41);
get_tapes_final_8 xuser42(4'd4,4'd2,User42);
get_tapes_final_8 xuser43(4'd4,4'd3,User43);
get_tapes_final_8 xuser44(4'd4,4'd4,User44);
get_tapes_final_8 xuser45(4'd4,4'd5,User45);
get_tapes_final_8 xuser46(4'd4,4'd6,User46);
get_tapes_final_8 xuser47(4'd4,4'd7,User47);
get_tapes_final_8 xuser48(4'd4,4'd8,User48);
get_tapes_final_8 xuser49(4'd4,4'd9,User49);
get_tapes_final_8 xuser410(4'd4,4'd10,User410);
get_tapes_final_8 xuser411(4'd4,4'd11,User411);
get_tapes_final_8 xuser412(4'd4,4'd12,User412);
get_tapes_final_8 xuser413(4'd4,4'd13,User413);
get_tapes_final_8 xuser414(4'd4,4'd14,User414);
get_tapes_final_8 xuser415(4'd4,4'd15,User415);
get_tapes_final_8 xuser50(4'd5,4'd0,User50);
get_tapes_final_8 xuser51(4'd5,4'd1,User51);
get_tapes_final_8 xuser52(4'd5,4'd2,User52);
get_tapes_final_8 xuser53(4'd5,4'd3,User53);
get_tapes_final_8 xuser54(4'd5,4'd4,User54);
get_tapes_final_8 xuser55(4'd5,4'd5,User55);
get_tapes_final_8 xuser56(4'd5,4'd6,User56);
get_tapes_final_8 xuser57(4'd5,4'd7,User57);
get_tapes_final_8 xuser58(4'd5,4'd8,User58);
get_tapes_final_8 xuser59(4'd5,4'd9,User59);
get_tapes_final_8 xuser510(4'd5,4'd10,User510);
get_tapes_final_8 xuser511(4'd5,4'd11,User511);
get_tapes_final_8 xuser512(4'd5,4'd12,User512);
get_tapes_final_8 xuser513(4'd5,4'd13,User513);
get_tapes_final_8 xuser514(4'd5,4'd14,User514);
get_tapes_final_8 xuser515(4'd5,4'd15,User515);
get_tapes_final_8 xuser60(4'd6,4'd0,User60);
get_tapes_final_8 xuser61(4'd6,4'd1,User61);
get_tapes_final_8 xuser62(4'd6,4'd2,User62);
get_tapes_final_8 xuser63(4'd6,4'd3,User63);
get_tapes_final_8 xuser64(4'd6,4'd4,User64);
get_tapes_final_8 xuser65(4'd6,4'd5,User65);
get_tapes_final_8 xuser66(4'd6,4'd6,User66);
get_tapes_final_8 xuser67(4'd6,4'd7,User67);
get_tapes_final_8 xuser68(4'd6,4'd8,User68);
get_tapes_final_8 xuser69(4'd6,4'd9,User69);
get_tapes_final_8 xuser610(4'd6,4'd10,User610);
get_tapes_final_8 xuser611(4'd6,4'd11,User611);
get_tapes_final_8 xuser612(4'd6,4'd12,User612);
get_tapes_final_8 xuser613(4'd6,4'd13,User613);
get_tapes_final_8 xuser614(4'd6,4'd14,User614);
get_tapes_final_8 xuser615(4'd6,4'd15,User615);
get_tapes_final_8 xuser70(4'd7,4'd0,User70);
get_tapes_final_8 xuser71(4'd7,4'd1,User71);
get_tapes_final_8 xuser72(4'd7,4'd2,User72);
get_tapes_final_8 xuser73(4'd7,4'd3,User73);
get_tapes_final_8 xuser74(4'd7,4'd4,User74);
get_tapes_final_8 xuser75(4'd7,4'd5,User75);
get_tapes_final_8 xuser76(4'd7,4'd6,User76);
get_tapes_final_8 xuser77(4'd7,4'd7,User77);
get_tapes_final_8 xuser78(4'd7,4'd8,User78);
get_tapes_final_8 xuser79(4'd7,4'd9,User79);
get_tapes_final_8 xuser710(4'd7,4'd10,User710);
get_tapes_final_8 xuser711(4'd7,4'd11,User711);
get_tapes_final_8 xuser712(4'd7,4'd12,User712);
get_tapes_final_8 xuser713(4'd7,4'd13,User713);
get_tapes_final_8 xuser714(4'd7,4'd14,User714);
get_tapes_final_8 xuser715(4'd7,4'd15,User715);
get_tapes_final_8 xuser80(4'd8,4'd0,User80);
get_tapes_final_8 xuser81(4'd8,4'd1,User81);
get_tapes_final_8 xuser82(4'd8,4'd2,User82);
get_tapes_final_8 xuser83(4'd8,4'd3,User83);
get_tapes_final_8 xuser84(4'd8,4'd4,User84);
get_tapes_final_8 xuser85(4'd8,4'd5,User85);
get_tapes_final_8 xuser86(4'd8,4'd6,User86);
get_tapes_final_8 xuser87(4'd8,4'd7,User87);
get_tapes_final_8 xuser88(4'd8,4'd8,User88);
get_tapes_final_8 xuser89(4'd8,4'd9,User89);
get_tapes_final_8 xuser810(4'd8,4'd10,User810);
get_tapes_final_8 xuser811(4'd8,4'd11,User811);
get_tapes_final_8 xuser812(4'd8,4'd12,User812);
get_tapes_final_8 xuser813(4'd8,4'd13,User813);
get_tapes_final_8 xuser814(4'd8,4'd14,User814);
get_tapes_final_8 xuser815(4'd8,4'd15,User815);
get_tapes_final_8 xuser90(4'd9,4'd0,User90);
get_tapes_final_8 xuser91(4'd9,4'd1,User91);
get_tapes_final_8 xuser92(4'd9,4'd2,User92);
get_tapes_final_8 xuser93(4'd9,4'd3,User93);
get_tapes_final_8 xuser94(4'd9,4'd4,User94);
get_tapes_final_8 xuser95(4'd9,4'd5,User95);
get_tapes_final_8 xuser96(4'd9,4'd6,User96);
get_tapes_final_8 xuser97(4'd9,4'd7,User97);
get_tapes_final_8 xuser98(4'd9,4'd8,User98);
get_tapes_final_8 xuser99(4'd9,4'd9,User99);
get_tapes_final_8 xuser910(4'd9,4'd10,User910);
get_tapes_final_8 xuser911(4'd9,4'd11,User911);
get_tapes_final_8 xuser912(4'd9,4'd12,User912);
get_tapes_final_8 xuser913(4'd9,4'd13,User913);
get_tapes_final_8 xuser914(4'd9,4'd14,User914);
get_tapes_final_8 xuser915(4'd9,4'd15,User915);
get_tapes_final_8 xuser100(4'd10,4'd0,User100);
get_tapes_final_8 xuser101(4'd10,4'd1,User101);
get_tapes_final_8 xuser102(4'd10,4'd2,User102);
get_tapes_final_8 xuser103(4'd10,4'd3,User103);
get_tapes_final_8 xuser104(4'd10,4'd4,User104);
get_tapes_final_8 xuser105(4'd10,4'd5,User105);
get_tapes_final_8 xuser106(4'd10,4'd6,User106);
get_tapes_final_8 xuser107(4'd10,4'd7,User107);
get_tapes_final_8 xuser108(4'd10,4'd8,User108);
get_tapes_final_8 xuser109(4'd10,4'd9,User109);
get_tapes_final_8 xuser1010(4'd10,4'd10,User1010);
get_tapes_final_8 xuser1011(4'd10,4'd11,User1011);
get_tapes_final_8 xuser1012(4'd10,4'd12,User1012);
get_tapes_final_8 xuser1013(4'd10,4'd13,User1013);
get_tapes_final_8 xuser1014(4'd10,4'd14,User1014);
get_tapes_final_8 xuser1015(4'd10,4'd15,User1015);
get_tapes_final_8 xuser11110(4'd11,4'd0,User110);
get_tapes_final_8 xuser11111(4'd11,4'd1,User111);
get_tapes_final_8 xuser11112(4'd11,4'd2,User112);
get_tapes_final_8 xuser11113(4'd11,4'd3,User113);
get_tapes_final_8 xuser11114(4'd11,4'd4,User114);
get_tapes_final_8 xuser11115(4'd11,4'd5,User115);
get_tapes_final_8 xuser116(4'd11,4'd6,User116);
get_tapes_final_8 xuser117(4'd11,4'd7,User117);
get_tapes_final_8 xuser118(4'd11,4'd8,User118);
get_tapes_final_8 xuser119(4'd11,4'd9,User119);
get_tapes_final_8 xuser1110(4'd11,4'd10,User1110);
get_tapes_final_8 xuser1111(4'd11,4'd11,User1111);
get_tapes_final_8 xuser1112(4'd11,4'd12,User1112);
get_tapes_final_8 xuser1113(4'd11,4'd13,User1113);
get_tapes_final_8 xuser1114(4'd11,4'd14,User1114);
get_tapes_final_8 xuser1115(4'd11,4'd15,User1115);
get_tapes_final_8 xuser120(4'd12,4'd0,User120);
get_tapes_final_8 xuser121(4'd12,4'd1,User121);
get_tapes_final_8 xuser122(4'd12,4'd2,User122);
get_tapes_final_8 xuser123(4'd12,4'd3,User123);
get_tapes_final_8 xuser124(4'd12,4'd4,User124);
get_tapes_final_8 xuser125(4'd12,4'd5,User125);
get_tapes_final_8 xuser126(4'd12,4'd6,User126);
get_tapes_final_8 xuser127(4'd12,4'd7,User127);
get_tapes_final_8 xuser128(4'd12,4'd8,User128);
get_tapes_final_8 xuser129(4'd12,4'd9,User129);
get_tapes_final_8 xuser1210(4'd12,4'd10,User1210);
get_tapes_final_8 xuser1211(4'd12,4'd11,User1211);
get_tapes_final_8 xuser1212(4'd12,4'd12,User1212);
get_tapes_final_8 xuser1213(4'd12,4'd13,User1213);
get_tapes_final_8 xuser1214(4'd12,4'd14,User1214);
get_tapes_final_8 xuser1215(4'd12,4'd15,User1215);
get_tapes_final_8 xuser130(4'd13,4'd0,User130);
get_tapes_final_8 xuser131(4'd13,4'd1,User131);
get_tapes_final_8 xuser132(4'd13,4'd2,User132);
get_tapes_final_8 xuser133(4'd13,4'd3,User133);
get_tapes_final_8 xuser134(4'd13,4'd4,User134);
get_tapes_final_8 xuser135(4'd13,4'd5,User135);
get_tapes_final_8 xuser136(4'd13,4'd6,User136);
get_tapes_final_8 xuser137(4'd13,4'd7,User137);
get_tapes_final_8 xuser138(4'd13,4'd8,User138);
get_tapes_final_8 xuser139(4'd13,4'd9,User139);
get_tapes_final_8 xuser1310(4'd13,4'd10,User1310);
get_tapes_final_8 xuser1311(4'd13,4'd11,User1311);
get_tapes_final_8 xuser1312(4'd13,4'd12,User1312);
get_tapes_final_8 xuser1313(4'd13,4'd13,User1313);
get_tapes_final_8 xuser1314(4'd13,4'd14,User1314);
get_tapes_final_8 xuser1315(4'd13,4'd15,User1315);
get_tapes_final_8 xuser140(4'd14,4'd0,User140);
get_tapes_final_8 xuser141(4'd14,4'd1,User141);
get_tapes_final_8 xuser142(4'd14,4'd2,User142);
get_tapes_final_8 xuser143(4'd14,4'd3,User143);
get_tapes_final_8 xuser144(4'd14,4'd4,User144);
get_tapes_final_8 xuser145(4'd14,4'd5,User145);
get_tapes_final_8 xuser146(4'd14,4'd6,User146);
get_tapes_final_8 xuser147(4'd14,4'd7,User147);
get_tapes_final_8 xuser148(4'd14,4'd8,User148);
get_tapes_final_8 xuser149(4'd14,4'd9,User149);
get_tapes_final_8 xuser1410(4'd14,4'd10,User1410);
get_tapes_final_8 xuser1411(4'd14,4'd11,User1411);
get_tapes_final_8 xuser1412(4'd14,4'd12,User1412);
get_tapes_final_8 xuser1413(4'd14,4'd13,User1413);
get_tapes_final_8 xuser1414(4'd14,4'd14,User1414);
get_tapes_final_8 xuser1415(4'd14,4'd15,User1415);
get_tapes_final_8 xuser150(4'd15,4'd0,User150);
get_tapes_final_8 xuser151(4'd15,4'd1,User151);
get_tapes_final_8 xuser152(4'd15,4'd2,User152);
get_tapes_final_8 xuser153(4'd15,4'd3,User153);
get_tapes_final_8 xuser154(4'd15,4'd4,User154);
get_tapes_final_8 xuser155(4'd15,4'd5,User155);
get_tapes_final_8 xuser156(4'd15,4'd6,User156);
get_tapes_final_8 xuser157(4'd15,4'd7,User157);
get_tapes_final_8 xuser158(4'd15,4'd8,User158);
get_tapes_final_8 xuser159(4'd15,4'd9,User159);
get_tapes_final_8 xuser1510(4'd15,4'd10,User1510);
get_tapes_final_8 xuser1511(4'd15,4'd11,User1511);
get_tapes_final_8 xuser1512(4'd15,4'd12,User1512);
get_tapes_final_8 xuser1513(4'd15,4'd13,User1513);
get_tapes_final_8 xuser1514(4'd15,4'd14,User1514);
get_tapes_final_8 xuser1515(4'd15,4'd15,User1515);
    
endmodule