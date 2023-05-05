
`timescale 1ns / 1ps
module testbench;
localparam
    CLK_FREQ    = 50_000_000,
    BAUD_RATE   = 115200,
    WORD_LENGTH = 8,
    STOP_BITS   = 2,
    PARITY      = "NONE";
reg clk, rst_n;
reg rx;
wire tx;

 top_uart_led aa
(
				clk		,
				rst_n	,
				rx	,
				tx	
);


integer bitTime, idx, idxWord, idxBit;
reg [7:0] word [0:2];
initial begin
    clk = 0; rst_n = 0; rx = 1'b1; #10000; rst_n = 1; #10000;
    bitTime = 8680;  // 根据波特率设置位时间周期
    word[0] = 8'hfa; word[1] = 8'hff; word[2] = 8'ha5;
    for (idx=0; idx<10; idx=idx+1) begin  // 传输次数
        for (idxWord=0; idxWord<1000000000; idxWord=idxWord+1) begin  // 传输字节
            rx = 1'b0; #bitTime; //start
            for (idxBit=0; idxBit<8; idxBit=idxBit+1) begin  // 传输位
                rx = word[0][idxBit];
                #bitTime;
            end
            rx = 1'b1; #bitTime; //stop
        end
        #1000000;
    end
end
always begin
    #10 clk = ~clk;
end
endmodule
