module MatrixPlanner
#(
	parameter maxWidthLen= 0, // maxWidth = 2 ^ maxWidtLen
	parameter sizeValue = 0 // Maksymalny rozmiar komórki w macierzy
)(
	inout clk,
	input rst,

	input start,
	
	input[maxWidthLen - 1 : 0] sizex,
	input[maxWidthLen - 1 : 0] sizey,
	
	input rdy1,
	input rdy2,
	input rdy3,
	input rdy4,
	input rdy5,
	
	output reg rdy,
	
	output reg signed[maxWidthLen - 1 : 0] rx,
	output reg signed[maxWidthLen - 1 : 0] ry,
	
	output[2:0] index,
	output reg startCore
);

reg[2:0] f_coreCount;
reg[2:0] n_coreCount;

reg f_work;
reg n_work;

reg f_wait;
reg n_wait;

reg f_waitForFinish;
reg n_waitForFinish;

reg signed[maxWidthLen - 1 : 0] f_rx;
reg signed[maxWidthLen - 1 : 0] f_ry;

reg signed[maxWidthLen - 1 : 0] n_rx;
reg signed[maxWidthLen - 1 : 0] n_ry;
	
always@(posedge clk or posedge rst) begin
	if(rst) f_coreCount <= 0;
	else f_coreCount <= n_coreCount;
end

always@(posedge clk or posedge rst) begin
	if(rst) begin
			f_work <= 0;
			f_wait <= 0;
			f_waitForFinish <= 0;
		end
	else begin
			f_work <= n_work;
			f_wait <= n_wait;
			f_waitForFinish <= n_waitForFinish;
		end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		f_rx <= 0;
		f_ry <= 0;
	end else
	begin
		f_ry <= n_ry;
		f_rx <= n_rx;
	end
end

always@(*)begin
	
	n_ry = f_ry;
	n_rx = f_rx;
	
	rx = 0;
	ry = 0;
	
	rdy = 0;
	startCore = 0;
	
	n_work = f_work;
	n_wait = f_wait;
	n_waitForFinish = f_waitForFinish;
	
	n_coreCount = f_coreCount;
	
	if(start)begin
		n_ry = 0;
		n_rx = 0;
		
		n_coreCount = 0;
		n_work = 1;
		n_wait = 0;
		n_waitForFinish = 0;
	end
	
	if(f_work)begin
		if(f_wait) begin
		
			case(f_coreCount)
				0: if(rdy1) if(f_waitForFinish) begin
									n_work = 0;
									rdy = 1;
								end
								else n_wait = 0;
				1: if(rdy2) if(f_waitForFinish) begin
									n_work = 0;
									rdy = 1;
								end
								else n_wait = 0;
				2: if(rdy3) if(f_waitForFinish) begin
									n_work = 0;
									rdy = 1;
								end
								else n_wait = 0;
				3: if(rdy4) if(f_waitForFinish) begin
									n_work = 0;
									rdy = 1;
								end
								else n_wait = 0;
				4: if(rdy5) if(f_waitForFinish) begin
									n_work = 0;
									rdy = 1;
								end
								else n_wait = 0;
				default:;
			endcase
			
			n_coreCount = 0;
		
		end else
		begin
			
			
			if(f_coreCount == 4) n_wait = 1;
			
			
			if(f_ry == sizey && f_rx == sizex)begin
				n_wait = 1;
				n_waitForFinish = 1;
			end
			
			if(f_rx == sizex) n_ry = f_ry + 1; 
			else n_rx = f_rx + 1;
			
			rx = f_rx;
			ry = f_ry;
			
			startCore = 1;
			
			n_coreCount = f_coreCount + 1;
			
			
			
		end
		
	end
	
end

assign index = f_coreCount; 
endmodule
