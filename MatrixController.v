
module MatrixController
#(
	parameter maxWidthLen= 0, // maxWidth = 2 ^ maxWidtLen
	parameter sizeValue = 0 // Maksymalny rozmiar komórki w macierzy
)(
	input clk,
	input rst,
	
	input start,
	input[2:0] index,
	input[(maxWidthLen-1):0] x, // Parametry odczytu macierzy 1
	input[(maxWidthLen-1):0] y,
	
	
	output reg starta,
	output reg[(maxWidthLen-1):0] xa,
	output reg[(maxWidthLen-1):0] ya,
	
	
	
	
	
	output reg startb,
	output reg[(maxWidthLen-1):0] xb,
	output reg[(maxWidthLen-1):0] yb,
	
	
	
	
	
	
	output reg startc,
	output reg[(maxWidthLen-1):0] xc,
	output reg[(maxWidthLen-1):0] yc,
	
	
	
	
	
	
	output reg startd,
	output reg[(maxWidthLen-1):0] xd,
	output reg[(maxWidthLen-1):0] yd,
	
	
	
	output reg[(maxWidthLen-1):0] f_xam,
	output reg[(maxWidthLen-1):0] f_xbm,
	output reg[(maxWidthLen-1):0] f_xcm,
	output reg[(maxWidthLen-1):0] f_xdm,
	output reg[(maxWidthLen-1):0] f_xem,

	output reg[(maxWidthLen-1):0] f_yam,
	output reg[(maxWidthLen-1):0] f_ybm,
	output reg[(maxWidthLen-1):0] f_ycm,
	output reg[(maxWidthLen-1):0] f_ydm,
	output reg[(maxWidthLen-1):0] f_yem,
	
	output reg starte,
	output reg[(maxWidthLen-1):0] xe,
	output reg[(maxWidthLen-1):0] ye
	
	
	
	
	
	
	
);



reg[(maxWidthLen-1):0] n_xam;
reg[(maxWidthLen-1):0] n_xbm;
reg[(maxWidthLen-1):0] n_xcm;
reg[(maxWidthLen-1):0] n_xdm;
reg[(maxWidthLen-1):0] n_xem;

reg[(maxWidthLen-1):0] n_yam;
reg[(maxWidthLen-1):0] n_ybm;
reg[(maxWidthLen-1):0] n_ycm;
reg[(maxWidthLen-1):0] n_ydm;
reg[(maxWidthLen-1):0] n_yem;


reg[2:0] f_index;
reg[2:0] n_index;

reg[(maxWidthLen-1):0] xmem;
reg[(maxWidthLen-1):0] ymem;

reg[(maxWidthLen-1):0] f_xmem;
reg[(maxWidthLen-1):0] f_ymem;


always@(posedge clk or posedge rst)
	if(rst) begin
		f_xam <= 0;
		f_yam <= 0;
		
		f_xbm <= 0;
		f_ybm <= 0;
		
		f_xcm <= 0;
		f_ycm <= 0;
		
		f_xdm <= 0;
		f_ydm <= 0;
		
		f_xem <= 0;
		f_yem <= 0;
	end
	else begin
		f_xam <= n_xam;
		f_yam <= n_yam;
		
		f_xbm <= n_xbm;
		f_ybm <= n_ybm;
		
		f_xcm <= n_xcm;
		f_ycm <= n_ycm;
		
		f_xdm <= n_xdm;
		f_ydm <= n_ydm;
		
		f_xem <= n_xem;
		f_yem <= n_yem;
	end



always@(*)begin
	starta = 0;
	xa = 0;
	ya = 0;
	
	startb = 0;
	xb = 0;
	yb = 0;
	
	startc = 0;
	xc = 0;
	yc = 0;
	
	startd = 0;
	xd = 0;
	yd = 0;

	starte = 0;
	xe = 0;
	ye = 0;
	
	n_xam = f_xam;
	n_yam = f_yam;
	
	n_xbm = f_xbm;
	n_ybm = f_ybm;
	
	n_xcm = f_xcm;
	n_ycm = f_ycm;
	
	n_xdm = f_xdm;
	n_ydm = f_ydm;
	
	n_xem = f_xem;
	n_yem = f_yem;
	
	case(index)
		1:begin
			starta = 1;
			xa = x;
			ya = y;
			
			n_xam = x;
			n_yam = y;
		end
		2:begin
			startb = 1;
			xb = x;
			yb = y;
			
			n_xbm = x;
			n_ybm = y;
		end
		3:begin
			startc = 1;
			xc = x;
			yc = y;
			
			n_xcm = x;
			n_ycm = y;
		end
		4:begin
			startd = 1;
			xd = x;
			yd = y;
			
			n_xdm = x;
			n_ydm = y;
		end
		5:begin
			starte = 1;
			xe = x;
			ye = y;
			
			n_xem = x;
			n_yem = y;
		end
	endcase
end

endmodule
