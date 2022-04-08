

module MatrixConnector
#(
	parameter maxWidthLen= 0, // maxWidth = 2 ^ maxWidtLen
	parameter sizeValue = 0 // Maksymalny rozmiar komórki w macierzy
)(
	input clk,
	input rst,
	
	
	
	input reada,
	input[(maxWidthLen-1):0] rx1a, // Parametry odczytu macierzy 1
	input[(maxWidthLen-1):0] ry1a,
	output reg signed[(sizeValue-1):0] out1a,
	
	input[(maxWidthLen-1):0] rx2a, // Parametry odczytu macierzy 2
	input[(maxWidthLen-1):0] ry2a,
	output reg signed[(sizeValue-1):0] out2a,
	
	
	
	input readb,
	input[(maxWidthLen-1):0] rx1b, // Parametry odczytu macierzy 1
	input[(maxWidthLen-1):0] ry1b,
	output reg signed[(sizeValue-1):0] out1b,
	
	input[(maxWidthLen-1):0] rx2b, // Parametry odczytu macierzy 2
	input[(maxWidthLen-1):0] ry2b,
	output reg signed[(sizeValue-1):0] out2b,
	
	
	
	input readc,
	input[(maxWidthLen-1):0] rx1c, // Parametry odczytu macierzy 1
	input[(maxWidthLen-1):0] ry1c,
	output reg signed[(sizeValue-1):0] out1c,
	
	input[(maxWidthLen-1):0] rx2c, // Parametry odczytu macierzy 2
	input[(maxWidthLen-1):0] ry2c,
	output reg signed[(sizeValue-1):0] out2c,
	
	
	
	input readd,
	input[(maxWidthLen-1):0] rx1d, // Parametry odczytu macierzy 1
	input[(maxWidthLen-1):0] ry1d,
	output reg signed[(sizeValue-1):0] out1d,
	
	input[(maxWidthLen-1):0] rx2d, // Parametry odczytu macierzy 2
	input[(maxWidthLen-1):0] ry2d,
	output reg signed[(sizeValue-1):0] out2d,
	
	
	
	input reade,
	input[(maxWidthLen-1):0] rx1e, // Parametry odczytu macierzy 1
	input[(maxWidthLen-1):0] ry1e,
	output reg signed[(sizeValue-1):0] out1e,
	
	input[(maxWidthLen-1):0] rx2e, // Parametry odczytu macierzy 2
	input[(maxWidthLen-1):0] ry2e,
	output reg signed[(sizeValue-1):0] out2e,
	
	
	
	output reg[(maxWidthLen-1):0] rx1matrix, // Parametry odczytu macierzy 1
	output reg[(maxWidthLen-1):0] ry1matrix,
	input signed[(sizeValue-1):0] out1matrix,
	
	output reg[(maxWidthLen-1):0] rx2matrix, // Parametry odczytu macierzy 2
	output reg[(maxWidthLen-1):0] ry2matrix,
	input signed[(sizeValue-1):0] out2matrix
	
);

reg[2:0] f_readS;
reg[2:0] n_readS;

always@(posedge clk or posedge rst)begin
	if(rst) f_readS <= 0;
	else f_readS <= n_readS; 
end

always@(*)begin
	n_readS = f_readS;
	
	if(reada) n_readS = 1;
	else if(readb) n_readS = 2;
	else if(readc) n_readS = 3;
	else if(readd) n_readS = 4;
	else if(reade) n_readS = 5;
	else n_readS = 0;
end

always@(*)begin
	
	rx1matrix = 0;
	ry1matrix = 0;
	rx2matrix = 0;
	ry2matrix = 0;
	
	if(reada)begin
		
		rx1matrix = rx1a;
		ry1matrix = ry1a;
		rx2matrix = rx2a;
		ry2matrix = ry2a;
	end
	
	if(readb)begin
		
		rx1matrix = rx1b;
		ry1matrix = ry1b;
		rx2matrix = rx2b;
		ry2matrix = ry2b;
	end
	
	
	if(readc)begin
		
		rx1matrix = rx1c;
		ry1matrix = ry1c;
		rx2matrix = rx2c;
		ry2matrix = ry2c;
	end
	
	if(readd)begin
		
		rx1matrix = rx1d;
		ry1matrix = ry1d;
		rx2matrix = rx2d;
		ry2matrix = ry2d;
	end
	
	if(reade)begin
		
		rx1matrix = rx1e;
		ry1matrix = ry1e;
		rx2matrix = rx2e;
		ry2matrix = ry2e;
	end
	
	
end

always@(*)begin

	out1a = 0;
	out2a = 0;
	
	out1b = 0;
	out2b = 0;
	
	out1c = 0;
	out2c = 0;
	
	out1d = 0;
	out2d = 0;
	
	out1e = 0;
	out2e = 0;
	
	case(f_readS)
		1: begin
			out1a = out1matrix;
			out2a = out2matrix;
		end
		2: begin
			out1b = out1matrix;
			out2b = out2matrix;
		end
		3: begin
			out1c = out1matrix;
			out2c = out2matrix;
		end
		4: begin
			out1d = out1matrix;
			out2d = out2matrix;
		end
		5: begin
			out1e = out1matrix;
			out2e = out2matrix;
		end
		default:;
	endcase
	
end

endmodule
