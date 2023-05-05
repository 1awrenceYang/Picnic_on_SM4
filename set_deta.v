`timescale 1ns / 1ps
module set_deta(
    input clk,
    input reset,
    input[127:0] instseeds,
    input set_tapes_start,
    output [1023:0] deta,
    output reg set_tapes_end 
);
    reg  Hstart;
    reg  restart;
    wire  en_end;
    reg[4:0] state; 

    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            state<=0;
            set_tapes_end<=0;
        end
        else begin
            if(~set_tapes_start) begin
                set_tapes_end<=0;
            end
            if(state==0) begin
                if(set_tapes_start &&set_tapes_end==0) begin
                    set_tapes_end<=0;
                    Hstart<=1;
                    restart<=0;
                    state<=1;
                end
                
            end
            if(state==1) begin
                if(en_end) begin
                    Hstart<=0;
                    state<=2;
                end                  
            end
            if(state==2) begin
                set_tapes_end<=1;
                state <= 0;
            end
        end

    end

    KDF_for_seed_deta kdf0(clk,reset,Hstart,restart,instseeds,deta,en_end);
endmodule

module KDF_for_seed_deta(
    input clk,
    input reset,
    input Hstart,
    input restart,
    input[127:0] instseeds,
    output reg [1023:0] deta,
    output reg en_end
    );
    reg[0:1] state;
    reg out_start;
    reg start;
    wire sha3_busy;
    reg[0:9] counter;


    
    wire out_ok;
    wire[0:9] groupNum=8;
    wire[1088:0] h_in={instseeds,8'h1f,944'h0,8'h80};
    wire[1087:0] hashValue;
    wire[1087:0] d_out;
    



    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            start<=0;
            out_start<=0;
            en_end<=0;
            state <= 0;
            deta<=0;
        end
        else begin
            if(~Hstart) begin
                en_end<=0;
                out_start<=0;
            end
            if(state==0 && Hstart)begin
                if (en_end==0) begin
                    start<=1;
                    state<=1;
                end
            end
            else if(state == 1 && en_end==0) begin
                if(sha3_busy==1)begin
                    start<=0;
                    deta<=hashValue;
                    state <=2;
                end
            end 
            else if (state ==2) begin
                out_start<=1;
                en_end<=1;
                state <=0;
            end
        end
    end

    
    sha3_core_forkdf3 sc(
    .clk_i(clk),  // system clk input
    .reset_i(reset),  // async reset active high
    .start_i(start) ,  // pulse to start hashing next msg
    .out_start_i(out_start),
    .out_ok(out_ok),
    .sha3_busy(sha3_busy),  // sha3 is ready for next msg (level signal)      
    .data_ii(h_in),     
    .md_data_o_2(hashValue)  // message digest output (256 bits)
    );
    
endmodule


`define PARMS                                                         /*                                                                 */  
                                                                      /*                                                                 */  
`define SHA3_B             1600                                       /*  bit width of Keccak-p permuation                               */  
`define SHA3_W             64                                         /*  (64) lane size of Keccak-p permuation in bits                  */  
`define SHA3_NROUNDS       24                                         /*  Max rounds Keccak-p permutation 1600 = 12+2*SHA3_L =12+2*6 =24 */  
`define SHA3_D             512                                        /*  digest length for sha3                                         */  
`define SHA3_BITLEN        11                                         /*  Bit length {0..1088}                                           */  
`define SHA3_L             25   

module sha3_core_forkdf3 (  
//module sha3_core #(`PARMS) (   // pass parameters here (SystemVerilog prob)

  input  clk_i                           ,  // system clk input
  input  reset_i                         ,  // async reset active high
  input  start_i                         ,  // pulse to start hashing next msg
  input  out_start_i      ,
  output reg sha3_busy                    ,  // sha3 is ready for next msg (level signal)      
  output reg out_ok,
  //output round_tc,
  input  [1088-1:0] data_ii            ,  // String of data input (576 bits)   
  output reg [1088-1:0] md_data_o_2       // message digest output (256 bits)

  );
 wire  [0:1088-1] data_i=data_ii[1088-1:0]; 
 reg ready_o;
 reg [10:0] RATEBITS ; 
 reg[1:0] get_ok;
   //-------------------------------------------------------
   // ena, round control
   //-------------------------------------------------------
   reg [0:`SHA3_B-1] data_o;
   wire start =  start_i & ready_o;// & ready_o;        // start ignored when ready_o=0
   reg ena;
   reg md_valid;
   reg md_last;
   reg [4:0] round ;
   wire round_tc = (round == `SHA3_NROUNDS-1);  // 23 rounds  
   reg init_reg;
   reg start_reg;
   reg squeeze_reg;
    reg [0:`SHA3_B-1] S;
    reg finish_init;
    reg init2;
    wire init = start;  //&& md_valid ;  // initialize state register of next msg
    wire[1088-1:0] md_data_o_3;
    reg[1088-1:0] md_data_o;
    wire [0:`SHA3_B-1] state_reg ;       // state array output (25lanes x 64bits)
    always @(posedge clk_i or negedge reset_i)
    if (~reset_i)
	  begin
	    ena <= 1'b0;
        round <= 5'd0;
        //data_o<=0;
		init_reg <= 1'b0;
		start_reg <= 1'b0;
		squeeze_reg <= 1'b0;
		
		sha3_busy<=0;
		md_data_o <=0;
		S<=0;
		out_ok<=0;
		//get_ok<=0;
	  end
    else
	  begin
	      if(~start) begin
	           sha3_busy<=0;
	      end
	      if (start) begin
	           if(~finish_init) begin
	               init2<=1;
	           end
	        else if(finish_init) begin
	           ena <= 1'b1;
	           init2<=0;
	        end
	      end		
        else if (round_tc) begin
	      ena <= 1'b0;
	      get_ok<=1;
	      
        end         
        if (ena  && ~start) begin
          //sha3_busy<=0;
          round <= round + 5'd1;
        end
		    init_reg <= init;
		    start_reg <= start;
		
	    if(get_ok&&start_i) begin          
          
              S<=state_reg;             
              data_o<=state_reg;
              md_data_o_2<=md_data_o_3;
              //round<=0;              
              round<=0;
              sha3_busy<=1;
              get_ok<=0;
        end
        
        if(out_start_i) begin
              md_data_o<=md_data_o_2;
		      S<=0;
		      out_ok<=1;
		      //round<=0;
        end
        else begin
              out_ok<=0;
        end
        
		
		
		
       
      ready_o <= ~ena;
end

  localparam [10:0] SHA3512_R  = 11'd1088;
  reg [0:`SHA3_B-1] string ;   // String of data input (1600 bits)

always @(posedge clk_i)
begin
    string = {data_i[0:SHA3512_R-1],512'h0}^S;   // default. avoid latch
end



   //-------------------------------------------------------
   // Endian Byte Swap
   //-------------------------------------------------------

   // function to endian byte swap (64-bit)
   //function [0:`SHA3_W-1] byteswap(input [0:`SHA3_W-1] data);
   // byteswap = data;

   //endfunction
   
      function [0:`SHA3_W-1] byteswap(input [0:`SHA3_W-1] data);
    byteswap = { data[56:63],
                 data[48:55],
                 data[40:47],
                 data[32:39],
                 data[24:31],
                 data[16:23],
                 data[ 8:15],
                 data[ 0: 7]
	           };
   endfunction


   // convert data_i to a_array to be able to (Endian) byte swap

   wire [0:`SHA3_W-1] a_array [0:`SHA3_L-1] ;  // 5x5 (x,y) array [0:63]

assign a_array[ 0] = byteswap(string[   0:  63]);
assign a_array[ 1] = byteswap(string[  64: 127]);
assign a_array[ 2] = byteswap(string[ 128: 191]);
assign a_array[ 3] = byteswap(string[ 192: 255]);
assign a_array[ 4] = byteswap(string[ 256: 319]);
assign a_array[ 5] = byteswap(string[ 320: 383]);
assign a_array[ 6] = byteswap(string[ 384: 447]);
assign a_array[ 7] = byteswap(string[ 448: 511]);
assign a_array[ 8] = byteswap(string[ 512: 575]);
assign a_array[ 9] = byteswap(string[ 576: 639]);
assign a_array[10] = byteswap(string[ 640: 703]);
assign a_array[11] = byteswap(string[ 704: 767]);
assign a_array[12] = byteswap(string[ 768: 831]);
assign a_array[13] = byteswap(string[ 832: 895]);
assign a_array[14] = byteswap(string[ 896: 959]);
assign a_array[15] = byteswap(string[ 960:1023]);
assign a_array[16] = byteswap(string[1024:1087]);
assign a_array[17] = byteswap(string[1088:1151]);
assign a_array[18] = byteswap(string[1152:1215]);
assign a_array[19] = byteswap(string[1216:1279]);
assign a_array[20] = byteswap(string[1280:1343]);
assign a_array[21] = byteswap(string[1344:1407]);
assign a_array[22] = byteswap(string[1408:1471]);
assign a_array[23] = byteswap(string[1472:1535]);
assign a_array[24] = byteswap(string[1536:1599]);


  wire  [0:`SHA3_B-1] a_string;  // String of data  (1600 bits)
  
  assign a_string = { a_array[ 0], a_array[ 1], a_array[ 2], a_array[ 3], a_array[ 4], 
                      a_array[ 5], a_array[ 6], a_array[ 7], a_array[ 8], a_array[ 9], 
                      a_array[10], a_array[11], a_array[12], a_array[13], a_array[14], 
                      a_array[15], a_array[16], a_array[17], a_array[18], a_array[19], 
                      a_array[20], a_array[21], a_array[22], a_array[23], a_array[24]
                     };
 


   wire [0:`SHA3_W-1] Ako, Aku, Aka, Ake, Aki;     // x={3,4,0,1,2} ; y=2
   wire [0:`SHA3_W-1] Ago, Agu, Aga, Age, Agi;     // x={3,4,0,1,2} ; y=1
   wire [0:`SHA3_W-1] Abo, Abu, Aba, Abe, Abi;     // x={3,4,0,1,2} ; y=0
   wire [0:`SHA3_W-1] Aso, Asu, Asa, Ase, Asi;     // x={3,4,0,1,2} ; y=4
   wire [0:`SHA3_W-1] Amo, Amu, Ama, Ame, Ami;     // x={3,4,0,1,2} ; y=3

   // feedback state_array
   wire [0:`SHA3_B-1] string_xor_state =                             init_reg ?             a_string : 
                                      ( start_reg && (round==0)) ? state_reg ^ a_string : 
									                                            state_reg            ;
	                                     
sha3_rnd_a inst_sha3_rnd_a(
    .clk_i (clk_i),
    .reset_i (reset_i),
    .round_i (round),
    .string_i (string_xor_state),
    .Aba_o (Aba),    // (0,0)
    .Abe_o (Abe),    // (1,0)
    .Abi_o (Abi),    // (2,0)
    .Abo_o (Abo),    // (3,0)
    .Abu_o (Abu),    // (4,0)
    .Aga_o (Aga),    // (0,1)
    .Age_o (Age),    // (1,1)
    .Agi_o (Agi),    // (2,1)
    .Ago_o (Ago),    // (3,1)
    .Agu_o (Agu),    // (4,1)
    .Aka_o (Aka),    // (0,2)
    .Ake_o (Ake),    // (1,2)
    .Aki_o (Aki),    // (2,2)
    .Ako_o (Ako),    // (3,2)
    .Aku_o (Aku),    // (4,2)
    .Ama_o (Ama),    // (0,3)
    .Ame_o (Ame),    // (1,3)
    .Ami_o (Ami),    // (2,3)
    .Amo_o (Amo),    // (3,3)
    .Amu_o (Amu),    // (4,3)
    .Asa_o (Asa),    // (0,4)
    .Ase_o (Ase),    // (1,4)
    .Asi_o (Asi),    // (2,4)
    .Aso_o (Aso),    // (3,4)
    .Asu_o (Asu)     // (3,4)
);


   //-------------------------------------------------------
   // State Register
   //-------------------------------------------------------


 integer i;
 reg [0:`SHA3_W-1] state_array [0:`SHA3_L-1] ;  // 5x5 (x,y) array [0:63]

always @(posedge clk_i or negedge reset_i) begin
    if (~reset_i)begin
        finish_init<=0;
        state_array[0] <=0;
        state_array[1] <=0;
        state_array[2] <=0;
        state_array[3] <=0;
        state_array[4] <=0;
        state_array[5] <=0;
        state_array[6] <=0;
        state_array[7] <=0;
        state_array[8] <=0;
        state_array[9] <=0;
        state_array[10] <= 0;
        state_array[11] <= 0;
        state_array[12] <= 0;
        state_array[13] <= 0;
        state_array[14] <= 0;
        state_array[15] <= 0;
        state_array[16] <= 0;
        state_array[17] <= 0;
        state_array[18] <= 0;
        state_array[19] <= 0;
        state_array[20] <= 0;
        state_array[21] <= 0;
        state_array[22] <= 0;
        state_array[23] <= 0;
        state_array[24] <= 0;
	end
    else begin
        if(ena) begin
            finish_init<=0;
        end       
        if (init2) begin
            state_array[0] <=0;
            state_array[1] <=0;
            state_array[2] <=0;
            state_array[3] <=0;
            state_array[4] <=0;
            state_array[5] <=0;
            state_array[6] <=0;
            state_array[7] <=0;
            state_array[8] <=0;
            state_array[9] <=0;
            state_array[10] <= 0;
            state_array[11] <= 0;
            state_array[12] <= 0;
            state_array[13] <= 0;
            state_array[14] <= 0;
            state_array[15] <= 0;
            state_array[16] <= 0;
            state_array[17] <= 0;
            state_array[18] <= 0;
            state_array[19] <= 0;
            state_array[20] <= 0;
            state_array[21] <= 0;
            state_array[22] <= 0;
            state_array[23] <= 0;
            state_array[24] <= 0;
	        finish_init<=1;
	    end
     else if (ena && ~start)begin
       state_array[0] <= Aba;
       state_array[1] <= Abe;
       state_array[2] <= Abi;
       state_array[3] <= Abo;
       state_array[4] <= Abu;

       state_array[5] <= Aga;
       state_array[6] <= Age;
       state_array[7] <= Agi;
       state_array[8] <= Ago;
       state_array[9] <= Agu;

       state_array[10] <= Aka;
       state_array[11] <= Ake;
       state_array[12] <= Aki;
       state_array[13] <= Ako;
       state_array[14] <= Aku;

       state_array[15] <= Ama;
       state_array[16] <= Ame;
       state_array[17] <= Ami;
       state_array[18] <= Amo;
       state_array[19] <= Amu;

       state_array[20] <= Asa;
       state_array[21] <= Ase;
       state_array[22] <= Asi;
       state_array[23] <= Aso;
       state_array[24] <= Asu;
      end
   end
end
  // feedback state_array into rnd(a) .
  assign state_reg = {state_array[ 0], state_array[ 1], state_array[ 2], state_array[ 3], state_array[ 4], 
                      state_array[ 5], state_array[ 6], state_array[ 7], state_array[ 8], state_array[ 9], 
                      state_array[10], state_array[11], state_array[12], state_array[13], state_array[14], 
                      state_array[15], state_array[16], state_array[17], state_array[18], state_array[19], 
                      state_array[20], state_array[21], state_array[22], state_array[23], state_array[24]
                     };
                     

assign md_data_o_3 = {state_array[0][56:63], state_array[0][48:55], state_array[0][40:47], state_array[0][32:39], state_array[0][24:31], state_array[0][16:23], state_array[0][8:15], state_array[0][0:7], 
                      state_array[1][56:63], state_array[1][48:55], state_array[1][40:47], state_array[1][32:39], state_array[1][24:31], state_array[1][16:23], state_array[1][8:15], state_array[1][0:7], 
                      state_array[2][56:63], state_array[2][48:55], state_array[2][40:47], state_array[2][32:39], state_array[2][24:31], state_array[2][16:23], state_array[2][8:15], state_array[2][0:7], 
                      state_array[3][56:63], state_array[3][48:55], state_array[3][40:47], state_array[3][32:39], state_array[3][24:31], state_array[3][16:23], state_array[3][8:15], state_array[3][0:7],
                      state_array[4][56:63], state_array[4][48:55], state_array[4][40:47], state_array[4][32:39], state_array[4][24:31], state_array[4][16:23], state_array[4][8:15], state_array[4][0:7], 
                      state_array[5][56:63], state_array[5][48:55], state_array[5][40:47], state_array[5][32:39], state_array[5][24:31], state_array[5][16:23], state_array[5][8:15], state_array[5][0:7], 
                      state_array[6][56:63], state_array[6][48:55], state_array[6][40:47], state_array[6][32:39], state_array[6][24:31], state_array[6][16:23], state_array[6][8:15], state_array[6][0:7], 
                      state_array[7][56:63], state_array[7][48:55], state_array[7][40:47], state_array[7][32:39], state_array[7][24:31], state_array[7][16:23], state_array[7][8:15], state_array[7][0:7],  
                      state_array[8][56:63], state_array[8][48:55], state_array[8][40:47], state_array[8][32:39], state_array[8][24:31], state_array[8][16:23], state_array[8][8:15], state_array[8][0:7],
                      state_array[9][56:63], state_array[9][48:55], state_array[9][40:47], state_array[9][32:39], state_array[9][24:31], state_array[9][16:23], state_array[9][8:15], state_array[9][0:7],
                      state_array[10][56:63], state_array[10][48:55], state_array[10][40:47], state_array[10][32:39], state_array[10][24:31], state_array[10][16:23], state_array[10][8:15], state_array[10][0:7],
                      state_array[11][56:63], state_array[11][48:55], state_array[11][40:47], state_array[11][32:39], state_array[11][24:31], state_array[11][16:23], state_array[11][8:15], state_array[11][0:7],
                      state_array[12][56:63], state_array[12][48:55], state_array[12][40:47], state_array[12][32:39], state_array[12][24:31], state_array[12][16:23], state_array[12][8:15], state_array[12][0:7],
                      state_array[13][56:63], state_array[13][48:55], state_array[13][40:47], state_array[13][32:39], state_array[13][24:31], state_array[13][16:23], state_array[13][8:15], state_array[13][0:7],
                      state_array[14][56:63], state_array[14][48:55], state_array[14][40:47], state_array[14][32:39], state_array[14][24:31], state_array[14][16:23], state_array[14][8:15], state_array[14][0:7],
                      state_array[15][56:63], state_array[15][48:55], state_array[15][40:47], state_array[15][32:39], state_array[15][24:31], state_array[15][16:23], state_array[15][8:15], state_array[15][0:7],
                      state_array[16][56:63], state_array[16][48:55], state_array[16][40:47], state_array[16][32:39], state_array[16][24:31], state_array[16][16:23], state_array[16][8:15], state_array[16][0:7]
                      };

endmodule

