module w_ram_from_uart
(
	input wire sys_clk,
	input wire sys_rst_n,
	input wire uart_rxd,
    input wire w_ram_from_uart_start,
	output reg [7:0] data,
	output[14:0] address,
	output reg wea,
	output reg w_ram_from_uart_end
);

wire[14:0] full_number=14'd6416;
//wire[14:0] full_number=14'd;

wire[7:0] uart_rx_data;


wire uart_rx_done;
reg	uart_rx_done_d0;			
reg uart_rx_done_d1;			
wire pos_uart_rx_done;
assign pos_uart_rx_done= uart_rx_done_d0 && (~uart_rx_done_d1);
 
always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		uart_rx_done_d0<=1'b0;
		uart_rx_done_d1<=1'b0;		
	end
	else begin
		uart_rx_done_d0<=uart_rx_done;
		uart_rx_done_d1<=uart_rx_done_d0;
	end	
end



reg[14:0] counter;

reg[2:0] state;

assign address = counter;

always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		counter<=0;
		wea<=0;
		w_ram_from_uart_end<=0;
		state<=0;
		data<=0;
	end
	else begin
	    if(~w_ram_from_uart_start) begin
	       w_ram_from_uart_end<=0;
	    end
	    if(w_ram_from_uart_start==1&&state==0&&w_ram_from_uart_end==0)begin
			if(pos_uart_rx_done) begin
				data<=uart_rx_data;
				//data<=data+5;
				wea<=1;
				state<=1;
			end
		end
		else if(state==1) begin
			state<=2;
		end
		else if(state==2) begin
			counter<=counter+1;
			wea<=0;
			if(counter==full_number-1) begin
				state<=3;
			end
			else begin
				state<=0;
			end
		end
		else if(state==3) begin
		    wea<=0;
			counter<=0;
			w_ram_from_uart_end<=1;
			state<=0;
		end
	end
end


uart_rx rx(
	sys_clk,			
	sys_rst_n,			
	uart_rxd,			
	uart_rx_done,		
	uart_rx_data		
);

endmodule