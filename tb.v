module tb();
    reg clk;
    reg reset;
    //input root_seed,
    //input salt
    reg sign_start;

    wire tapes;
     
     wire [255:0]Ch;
     wire [255:0]Cv;
     wire sign_end;
     
initial
begin
clk = 1'b0; 
reset = 1'b0; 

#100 reset = 1'b1; 
sign_start = 1'b1;

//data_i =1088'h0;
//#1000 wait(!sha3_busy) 
//h1InSeedSet[0:1087] =1088'h61616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161;
//h1InSeedSet[1088:1088*2-1]=0;
//h1InSeedSet[1088+1024]=1;
//h1InSeedSet[1088+59]=1;
//h1InSeedSet[1088+60]=1;
//h1InSeedSet[1088+61]=1;
//h1InSeedSet[1088+62]=1;
//h1InSeedSet[1088+63]=1;
wait(sign_end) sign_start =0; #3000 sign_start =1'b1;

wait(sign_end) sign_start =0;

end


verify_res1 vv(
     clk,
     reset,
     8'h1,
    256'h0-1,
   // 256'h10943403a30f1c647944319670976830d926a7bd2613e17a2651041962654156,
    256'h0-1,
    
    512'h0-1,
    1024'h0-1,
    128'h0-1,
    //Z
    9680'h0-1,
    512'h0-1,
    2048'h0-1,
    1024'h0-1,
    2048'h0-1,
    4096'h0-1,

    51200'h0,
    128'h0,
    sign_start,
        Ch,
     Cv,
    sign_end
    );
    
always #20 clk = ~clk; 


endmodule