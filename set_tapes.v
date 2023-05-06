`timescale 1ns / 1ps

module set_tapes(
    input clk,
    input reset,
    input[4095:0] seed,
    input[255:0] salt,
    input[15:0] t,
    input set_tapes_start,
    output [16*2295-1:0] tapes,
    output reg set_tapes_end 
);
    reg [15:0] Hstart;
    reg [15:0] restart;
    wire [15:0] en_end;
    reg[4:0] state; 

    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            state<=0;
            set_tapes_end<=0;
        end
        else begin
            if(state==0) begin
                if(set_tapes_start) begin
                    set_tapes_end<=0;
                    Hstart<=16'hffff;
                    restart<=0;
                    state<=1;
                end
                
            end
            if(state==1) begin
                if(en_end==16'hffff) begin
                    restart<=Hstart;
                    Hstart<=0;
                    state<=2;
                end                  
            end
            if(state==2) begin
                set_tapes_end<=1;
                state <= 3;
            end
            if(state==3) begin
                set_tapes_end <= 0;
                state<=0;
            end
        end

    end

    KDF kdf0(clk,reset,Hstart[0],restart[0],seed[255:0],salt,t,16'h0,tapes[2294:0],en_end[0]);
    KDF kdf1(clk,reset,Hstart[1],restart[1],seed[511:256],salt,t,16'h1,tapes[4589:2295],en_end[1]);
    KDF kdf2(clk,reset,Hstart[2],restart[2],seed[767:512],salt,t,16'h2,tapes[6884:4590],en_end[2]);
    KDF kdf3(clk,reset,Hstart[3],restart[3],seed[1023:768],salt,t,16'h3,tapes[9179:6885],en_end[3]);
    KDF kdf4(clk,reset,Hstart[4],restart[4],seed[1279:1024],salt,t,16'h4,tapes[11474:9180],en_end[4]);
    KDF kdf5(clk,reset,Hstart[5],restart[5],seed[1535:1280],salt,t,16'h5,tapes[13769:11475],en_end[5]);
    KDF kdf6(clk,reset,Hstart[6],restart[6],seed[1791:1536],salt,t,16'h6,tapes[16064:13770],en_end[6]);
    KDF kdf7(clk,reset,Hstart[7],restart[7],seed[2047:1792],salt,t,16'h7,tapes[18359:16065],en_end[7]);
    KDF kdf8(clk,reset,Hstart[8],restart[8],seed[2303:2048],salt,t,16'h8,tapes[20654:18360],en_end[8]);
    KDF kdf9(clk,reset,Hstart[9],restart[9],seed[2559:2304],salt,t,16'h9,tapes[22949:20655],en_end[9]);
    KDF kdf10(clk,reset,Hstart[10],restart[10],seed[2815:2560],salt,t,16'ha,tapes[25244:22950],en_end[10]);
    KDF kdf11(clk,reset,Hstart[11],restart[11],seed[3071:2816],salt,t,16'hb,tapes[27539:25245],en_end[11]);
    KDF kdf12(clk,reset,Hstart[12],restart[12],seed[3327:3072],salt,t,16'hc,tapes[29834:27540],en_end[12]);
    KDF kdf13(clk,reset,Hstart[13],restart[13],seed[3583:3328],salt,t,16'hd,tapes[32129:29835],en_end[13]);
    KDF kdf14(clk,reset,Hstart[14],restart[14],seed[3839:3584],salt,t,16'he,tapes[34424:32130],en_end[14]);
    KDF kdf15(clk,reset,Hstart[15],restart[15],seed[4095:3840],salt,t,16'hf,tapes[36719:34425],en_end[15]);
endmodule

module KDF(
    input clk,
    input reset,
    input Hstart,
    input restart,
    input[255:0] seed,
    input[255:0] salt,
    input [15:0] t,
    input [15:0] i,
    output reg [2295-1:0] tapes,
    output reg en_end
    );
    reg[0:1] state;
    reg out_start;
    reg [2295-1:0] tapes2;
    reg start;
    wire sha3_busy;
    reg[0:9] counter;
    reg[1087:0] data;
    wire[0:20] index=2295-1-(counter)*1088;
    wire[0:20] index_i=3263-(counter)*1088;
    
    wire out_ok;
    wire[0:9] groupNum=3;
    wire[3263:0] h_in={seed,salt,t,i,8'h1f,528'h0,8'h80,2176'h0};
    wire[1087:0] hashValue;
    always @(*)begin
        data = h_in[index_i-: 1088];
    end
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            counter <= 0;
            start<=0;
            out_start<=0;
            en_end<=0;
            state <= 0;
            tapes<=0;
        end
        else begin
            if(state==0 && Hstart)begin
                if(restart) begin
                    en_end<=0;
                    out_start<=0;
                end
                if (en_end==0) begin
                    start<=1;
                    state<=1;
                end
            end
            else if(state == 1 && en_end==0) begin
                if(sha3_busy==1)begin
                    counter<=counter+1;
                    if (counter==2) begin
                        tapes2[118:0] <= hashValue[1087-:119];
                    //    tapes<=tapes2;
                    end
                    else begin
                        tapes2[index-:1088] <= hashValue;
                    end
                end
                if(counter==groupNum) begin
                    tapes<=tapes2;
                    start<=0;
                    state <=2 ;
                end
            end 
            else if (state ==2) begin
                out_start<=1;
                en_end<=1;
                state <=0;
                counter<=0;
            end
        end
    end
    sha3_core_forkdf sc(
    .clk_i(clk),  // system clk input
    .reset_i(reset),  // async reset active high
    .start_i(start) ,  // pulse to start hashing next msg
    .out_start_i(out_start),
    .out_ok(out_ok),
    .sha3_busy(sha3_busy),  // sha3 is ready for next msg (level signal)      
    .data_ii(data),     
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

module sha3_core_forkdf (  
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
        else begin
              if (sha3_busy==1);begin
                    sha3_busy<=0;
              end
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

