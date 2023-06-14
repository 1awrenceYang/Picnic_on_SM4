module top(
	input	wire			CLK_125_P		,
	input	wire			CLK_125_N		,
    //input  wire    sys_clk,
	input	wire			sys_rst_n2	,
	input	wire			uart_rxd	,
	output	wire			uart_txd	,
	output  wire            a1,
	output  wire            a2,
	output  wire            a3,
	output  wire            a4
);
wire sys_clk;
wire sys_rst_n=~sys_rst_n2;

//wire sys_rst_n=sys_rst_n2; 

 clk_wiz_0 clk
 (
 .clk_out1(sys_clk),
 .clk_in1_p(CLK_125_P),
 .clk_in1_n(CLK_125_N)
 );

//1
reg ur_ram_start;
reg ena;
reg recv_ok;

reg r_ram_for_verify_start;
wire r_ram_for_verify_end;
wire w_ram_from_uart_end;
wire [14:0] address_ram_for_uart_in;
wire [14:0] address_ram_for_verify_out;
wire wea;
wire [7:0]data_ram_for_uart_in;
wire [7:0]data_for_r_ram_to_uart;

wire [7:0] data_for_r_ram_to_verify;

wire [14:0] address=recv_ok?address_ram_for_verify_out:address_ram_for_uart_in;



//2
reg recv_ok2;
wire [14:0] address_ram_for_verify_in;
wire [14:0] address_ram_for_uart_out;
wire [14:0] address2=recv_ok2?address_ram_for_uart_out:address_ram_for_verify_in;


wire [7:0] data_ram_for_verify_in;

wire wea2;

wire ur_ram_end;

wire [7:0] data_for_r_ram;
reg w_ram_from_verify_start;

wire w_ram_from_verify_end;

reg [4:0] state;

reg w_ram_from_uart_start;

assign  a1=w_ram_from_uart_start;
assign  a2=r_ram_for_verify_start;
assign  a3=w_ram_from_verify_start;
assign  a4=ur_ram_start; 

always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		ena<=0;
		state<=0;
		recv_ok<=0;
		recv_ok2<=0;
		ur_ram_start<=0;
		w_ram_from_verify_start<=0;
		w_ram_from_uart_start<=0;
		r_ram_for_verify_start<=0;
		ur_ram_start<=0;
	end
	else begin
		if(state==0) begin
			ena<=1;
			state<=1;
		end
		if(state==1) begin
			if(w_ram_from_uart_end) begin
			    w_ram_from_uart_start<=0;
			    recv_ok<=1;
				state<=2;
			end
			else begin
			    w_ram_from_uart_start<=1;
			end
		end

		else if (state==2) begin
			state<=3;
		end
		else if (state==3) begin
			if(r_ram_for_verify_end) begin
			    recv_ok<=0;
				r_ram_for_verify_start<=0;
				state<=4;
			end
			else begin
				r_ram_for_verify_start<=1;
			end
		end
		else if (state==4) begin
			if(w_ram_from_verify_end) begin
			    recv_ok2<=1;
				w_ram_from_verify_start<=0;
				state<=5;
			end
			else begin
				w_ram_from_verify_start<=1;
			end
		end
		else if (state==5) begin
			state<=6;
		end
		else if (state==6) begin
			if(ur_ram_end) begin
			    recv_ok2<=0;
				ur_ram_start<=0;
				state<=7;
			end
			else begin
				ur_ram_start<=1;
			end
		end

		else if (state==7) begin
			ena<=0;
			state<=0;
		end
	end
end

wire[255:0] H;
wire verify_successful;

r_ram_for_verify rrfvy
(
	sys_clk,
	sys_rst_n,
    r_ram_for_verify_start,
	data_for_r_ram_to_verify, 
	address_ram_for_verify_out,
	H,
    verify_successful,
	r_ram_for_verify_end
);


w_ram_from_uart wrfu
(
	sys_clk,
	sys_rst_n,
	uart_rxd,
    w_ram_from_uart_start,
	data_ram_for_uart_in,
	address_ram_for_uart_in,
	wea,
	w_ram_from_uart_end
);

ram_for_uart_in ramforui(
    .clka(sys_clk),    
    .ena(ena),      
    .wea(wea),      
    .addra(address),  
    .dina(data_ram_for_uart_in),    
    .douta(data_for_r_ram_to_verify)  
);

ram_for_uart_out ramforuo(
    .clka(sys_clk),    
    .ena(ena),      
    .wea(wea2),      
    .addra(address2),  
    .dina(data_ram_for_verify_in),    
    .douta(data_for_r_ram)  
);


w_ram_from_verify wrfv
(
	sys_clk,
	sys_rst_n,
	H,
    w_ram_from_verify_start,
	data_ram_for_verify_in,
	address_ram_for_verify_in,
	wea2,
	w_ram_from_verify_end
);


 r_ram_from_uart rrfur
(
	sys_clk,
	sys_rst_n,
    ur_ram_start,
	data_for_r_ram,


	address_ram_for_uart_out,
    uart_txd,
	ur_ram_end
);
endmodule