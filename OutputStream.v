module StreamOutput
#(
	parameter maxWidthLen= 0, // maxWidth = 2 ^ maxWidtLen
	parameter sizeValue = 0 // Maksymalny rozmiar komórki w macierzy
)(
	input clk,
	input rst,
	
	input rdy,
	
	input[maxWidthLen - 1 : 0] sizeX,
	input[maxWidthLen - 1 : 0] sizeY,
	
	output reg mRdy,
	output reg signed[maxWidthLen - 1 : 0] out,
	
	output reg[maxWidthLen - 1:0] readx,
	output reg[maxWidthLen - 1:0] ready,
	
	input signed[sizeValue - 1:0] in
	
);

reg f_work;
reg n_work;

reg f_status;
reg n_status;

reg signed[sizeValue - 1:0] f_out;

reg[maxWidthLen - 1:0] rx;
reg[maxWidthLen - 1:0] ry;

reg[maxWidthLen - 1:0] f_rx;
reg[maxWidthLen - 1:0] f_ry;

always@(posedge clk or posedge rst)begin
	if(rst) begin
		f_work = 0;
		f_status = 0;
		end
	else begin
		f_work = n_work;
		f_status = n_status;
		end
end

always@(posedge clk or posedge rst)begin
	if(rst) begin
		f_rx = 0;
		f_ry = 0;
		f_out = 0;
	end else
	begin
		f_rx = rx;
		f_ry = ry;
		f_out = out;
	end
end

always@(*)begin

	rx = f_rx;
	ry = f_ry;
	
	readx = 0;
	ready = 0;
	
	mRdy = 0;
	out = f_out;
	
	n_work = f_work;
	n_status = f_status;
	
	if(rdy)begin
		rx = 0;
		ry = 0;
		n_work = 1;
		n_status = 0;
		out = 0;
	end
	
	if(f_work) begin
		
		
		if(f_rx == sizeX && f_ry == sizeY) begin
			f_work = 0;
			mRdy = 1;
		end
		
		n_status = ~f_status;
		
		if(f_status) begin
			readx = f_rx;
			ready = f_ry;
		end else
		begin
			if(f_rx == sizeX) begin
				rx = 0;
				ry = f_ry + 1;
			end else
			begin
				rx = f_rx + 1;
			end
			
			out = in;
		end
	end else out = 0;
	
end

endmodule
