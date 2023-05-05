module w_ram_from_verify
(
	input wire sys_clk,
	input wire sys_rst_n,
	input [255:0] H,
    input wire w_ram_from_verify_start,
	output reg [7:0] data,
	output[14:0] address,
	output reg wea,
	output reg w_ram_from_verify_end
);

wire[14:0] full_number=32;

wire[7:0] uart_rx_data;


reg[14:0] counter;

reg[2:0] state;

assign address = counter;

wire [7:0]H_list[31:0];
assign {H_list[0],H_list[1],H_list[2],H_list[3],H_list[4],H_list[5],H_list[6],H_list[7],H_list[8],H_list[9],H_list[10],H_list[11],H_list[12],H_list[13],H_list[14],H_list[15],H_list[16],H_list[17],H_list[18],H_list[19],H_list[20],H_list[21],H_list[22],H_list[23],H_list[24],H_list[25],H_list[26],H_list[27],H_list[28],H_list[29],H_list[30],H_list[31]}=H;



always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		counter<=0;
		wea<=0;
		w_ram_from_verify_end<=0;
		state<=0;
	end
	else begin
	    if(~w_ram_from_verify_start) begin
	       w_ram_from_verify_end<=0;
	    end
	    if(w_ram_from_verify_start==1&&state==0&&w_ram_from_verify_end==0)begin
			data<=H_list[counter];
			wea<=1;
			state<=1;
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
			w_ram_from_verify_end<=1;
			state<=0;
		end
	end
end

endmodule
