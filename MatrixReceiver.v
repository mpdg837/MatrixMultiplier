module MatrixReceiver
#(
	parameter maxWidthLen= 0, // maxWidth = 2 ^ maxWidtLen
	parameter sizeValue = 0 // Maksymalny rozmiar komórki w macierzy
)(
	input clk,
	
	input rdya,
	input signed[(sizeValue-1):0] outa,
	
	
	input rdyb,
	input signed[(sizeValue-1):0] outb,
	
	
	input rdyc,
	input signed[(sizeValue-1):0] outc,
	
	
	input rdyd,
	input signed[(sizeValue-1):0] outd,
	
	
	input rdye,
	input signed[(sizeValue-1):0] oute,
	
	input[(maxWidthLen-1):0] f_xam,
	input[(maxWidthLen-1):0] f_xbm,
	input[(maxWidthLen-1):0] f_xcm,
	input[(maxWidthLen-1):0] f_xdm,
	input[(maxWidthLen-1):0] f_xem,

	input[(maxWidthLen-1):0] f_yam,
	input[(maxWidthLen-1):0] f_ybm,
	input[(maxWidthLen-1):0] f_ycm,
	input[(maxWidthLen-1):0] f_ydm,
	input[(maxWidthLen-1):0] f_yem,
	
	
	output reg rdy,
	output reg[(maxWidthLen-1):0] ox,
	output reg[(maxWidthLen-1):0] oy,
	
	output reg signed[(sizeValue-1):0] out
);


always@(posedge clk)begin
	rdy = 0;
	out = 0;
	ox = 0;
	oy = 0;
	
	if(rdya)begin
		rdy = 1;
		out = outa;
		ox = f_xam;
		oy = f_yam;
	end
	
	if(rdyb)begin
		rdy = 1;
		out = outb;
		ox = f_xbm;
		oy = f_ybm;
	end
	
	if(rdyc)begin
		rdy = 1;
		out = outc;
		ox = f_xcm;
		oy = f_ycm;
	end
	
	if(rdyd)begin
		rdy = 1;
		out = outd;
		ox = f_xdm;
		oy = f_ydm;
	end
	
	if(rdye)begin
		rdy = 1;
		out = oute;
		ox = f_xem;
		oy = f_yem;
	end
	
	
end


endmodule
