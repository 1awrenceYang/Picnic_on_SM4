module uart_tx(
	input 			sys_clk,	
	input 			sys_rst_n,	
	input	[7:0] 	uart_data,	
	input			uart_tx_en,	
	output reg 		uart_txd,	
    output reg      send_ok
);
 
parameter	BPS=115200;
//parameter	BPS=3000000;					
parameter	SYS_CLK_FRE=100_000_000;
//parameter	SYS_CLK_FRE=500_000_000;             
localparam	BPS_CNT=SYS_CLK_FRE/BPS;  
 
reg	uart_tx_en_d0;			
reg uart_tx_en_d1;			
reg tx_flag;				
reg [7:0]  uart_data_reg;	
reg [15:0] clk_cnt;			
reg [3:0]  tx_cnt;			
 
wire pos_uart_en_txd=uart_tx_en;		

/*
assign pos_uart_en_txd= uart_tx_en_d0 && (~uart_tx_en_d1);
 
always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		uart_tx_en_d0<=1'b0;
		uart_tx_en_d1<=1'b0;		
	end
	else begin
		uart_tx_en_d0<=uart_tx_en;
		uart_tx_en_d1<=uart_tx_en_d0;
	end	
end
*/

reg[1:0] state;
always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		tx_flag<=1'b0;
		uart_data_reg<=8'd0;
		state<=0;
		send_ok<=0;
	end
	else begin
	if (~pos_uart_en_txd) begin
	   send_ok<=0;
	end
	else if(state==0 && pos_uart_en_txd && send_ok==0)begin
		uart_data_reg<=uart_data;
		tx_flag<=1'b1;
		send_ok<=0;
		state<=1;
	end
	else if(state==1) begin
	   if((tx_cnt==4'd9) && (clk_cnt==BPS_CNT/2))begin
		  tx_flag<=1'b0;
		  uart_data_reg<=8'd0;
		  send_ok<=1;
		  state<=0;
	   end
	   else begin
		  uart_data_reg<=uart_data_reg;
		  tx_flag<=tx_flag;	
	   end
	end
	end
end

always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		clk_cnt<=16'd0;
		tx_cnt <=4'd0;
	end
	else if(tx_flag) begin
		if(clk_cnt<BPS_CNT-1)begin
			clk_cnt<=clk_cnt+1'b1;
			tx_cnt <=tx_cnt;
		end
		else begin
			clk_cnt<=16'd0;
			tx_cnt <=tx_cnt+1'b1;
		end
	end
	else begin
		clk_cnt<=16'd0;
		tx_cnt<=4'd0;
	end
end

always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n) begin
		uart_txd<=1'b1;
    end
	else if(tx_flag)
		case(tx_cnt)
			4'd0:   uart_txd <= 1'b0;
			4'd1:	uart_txd<=uart_data_reg[0];
			4'd2:	uart_txd<=uart_data_reg[1];
			4'd3:	uart_txd<=uart_data_reg[2];
			4'd4:	uart_txd<=uart_data_reg[3];
			4'd5:	uart_txd<=uart_data_reg[4];
			4'd6:	uart_txd<=uart_data_reg[5];
			4'd7:	uart_txd<=uart_data_reg[6];
			4'd8:   uart_txd<=uart_data_reg[7];
			4'd9:   uart_txd<=1'b1;
            default: uart_txd <= 1'b1;
		endcase
	else begin
		 uart_txd<=1'b1;
	end
end
endmodule
