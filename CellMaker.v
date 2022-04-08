
module CellMaker // Obliczanie wartości danej komórki
#(
	parameter maxWidthLen= 0, // maxWidth = 2 ^ maxWidtLen
	parameter sizeValue = 0 // Maksymalny rozmiar komórki w macierzy
)(
	input clk,
	input rst,
	
	input[(maxWidthLen-1):0] limit, // Maksymalny rozmiar wspólny macierzy
	
	input start, // Parametry startowe
	input[(maxWidthLen-1):0] x,
	input[(maxWidthLen-1):0] y,
	
	output reg[(maxWidthLen-1):0] rx1, // Parametry odczytu macierzy 1
	output reg[(maxWidthLen-1):0] ry1,
	input signed[(sizeValue-1):0] out1,
	
	output reg[(maxWidthLen-1):0] rx2, // Parametry odczytu macierzy 2
	output reg[(maxWidthLen-1):0] ry2,
	input signed[(sizeValue-1):0] out2,
	
	output reg[(sizeValue-1):0] out, // Wyjscie
	output reg rdy,
	output reg read
);

// Stany automatu ASMD
localparam idle = 3'd0;
localparam get = 3'd1;
localparam load = 3'd2;
localparam mul = 3'd3;
localparam add = 3'd4;
localparam count=3'd5;
localparam fin= 3'd6;

reg[2:0] state; // Stan automatu
reg[2:0] f_state;

reg[(maxWidthLen-1):0] counterCell; // Wskaznik komórki
reg[(maxWidthLen-1):0] f_counterCell;

reg[(maxWidthLen-1):0] f_x;
reg[(maxWidthLen-1):0] f_y;

reg[(maxWidthLen-1):0] n_x;
reg[(maxWidthLen-1):0] n_y;

reg[(sizeValue-1):0] sum; // Rejestr podliczenia war komorki
reg[(sizeValue-1):0] f_sum;

reg[(sizeValue-1):0] f_memMul;
reg[(sizeValue-1):0] memMul;

reg[(sizeValue-1):0] f_out1;
reg[(sizeValue-1):0] n_out1;

reg[(sizeValue-1):0] f_out2;
reg[(sizeValue-1):0] n_out2;

wire[((sizeValue * 2)-1):0] MulReg = f_out1 * f_out2;

always@(posedge clk or posedge rst)
	if(rst) begin
		f_x <=0;
		f_y <=0;
	end
	else begin
		f_x <= n_x;
		f_y<= n_y;
	end
	
always@(posedge clk or posedge rst)
	if(rst) f_state <= 0;
	else f_state <= state;
	
always@(posedge clk or posedge rst)
	if(rst) f_counterCell <= 0;
	else f_counterCell<= counterCell;
	
always@(posedge clk or posedge rst)
	if(rst) f_sum <= 0;
	else f_sum<= sum;

always@(posedge clk or posedge rst)
	if(rst) f_memMul <= 0;
	else f_memMul<= memMul;

always@(posedge clk or posedge rst)
	if(rst) begin
		f_out1 <=0;
		f_out2 <=0;
	end
	else begin
		f_out1 <= n_out1;
		f_out2 <= n_out2;
	end
	
always@(*)begin // Stany
	state = f_state;
	
	case(f_state)
				idle: if(start) state = get;
						else state = idle;
				get: state = load;
				load: state = mul;
				mul: state = add;
				add: state = count;
			 count: if(f_counterCell == limit - 1) state = fin;
						else state = get;
				fin: state = idle;
				
	endcase
	end
	
always@(*)begin // Operacje
	counterCell = f_counterCell;
	sum = f_sum;
	memMul = f_memMul;
	
	n_out1 = f_out1;
	n_out2 = f_out2;
		
	rx1 = 0;
	ry1 = 0;
	
	rx2 = 0;
	ry2 = 0;
	
	out = 0;
	
	rdy = 0;
	read = 0;
	
	n_x = f_x;
	n_y = f_y;
	
	case(f_state)
		idle: begin
			counterCell = 0;
			sum = 0;
			memMul = 0;
			
			n_x = x;
			n_y = y;
			
			memMul = 0;
			n_out1 = 0;
			n_out2 = 0;
		end
		get: begin
			rx1 = f_counterCell;
			ry1 = f_y;
			
			rx2 = f_x;
			ry2 = f_counterCell;
			
			read = 1;
			
		end
		load: begin
			n_out1 = out1;
			n_out2 = out2;
		end
		mul: memMul = MulReg[(((sizeValue * 3)/2)-1):(sizeValue/2)];
		add: sum = f_sum + f_memMul;
		count: counterCell = f_counterCell + 1;
		
		fin: begin
			rdy = 1;
			out = sum;
		end
		
		endcase
end
	

	
endmodule