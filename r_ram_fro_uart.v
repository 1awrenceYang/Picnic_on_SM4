module r_ram_from_uart
(
	input wire clk,
	input wire reset,
    input ur_ram_start,
	input [7:0] data, 


	output[14:0] address,
    output uart_txd,
	output reg ur_ram_end
);

wire[14:0] full_number=2704;
reg uart_tx_do;
reg[14:0] counter;
reg[4:0] state;
wire send_ok;

assign address=counter;

always @(posedge clk or negedge reset) begin
    if(~reset) begin
        ur_ram_end<=0;
        counter<=0;
        state<=0;
    end
    else begin
        if(~ur_ram_start) begin
            ur_ram_end<=0;
            counter<=0;
            uart_tx_do<=0;
            state<=0;
        end
        if(state==0&& ur_ram_start&&ur_ram_end==0) begin
            
            if(send_ok) begin
                uart_tx_do<=0;
                counter<=counter+1;
                if(counter==full_number-1) begin
                    state<=2;
                end
                else begin
                    state<=1;
                end           
            end
            else begin
                uart_tx_do<=1;
            end
        end
        else if(state==1) begin
            state<=3;
        end
        else if(state==3) begin
            state<=0;
        end
        else if(state==2) begin
            ur_ram_end<=1;
            state<=0;
        end
    end
end


uart_tx tx(
	clk,	
	reset,	
	data,	
	uart_tx_do,	
	uart_txd,	
    send_ok
);

endmodule