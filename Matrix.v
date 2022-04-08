module Matrix
#(
	parameter maxWidthLen= 0, // maxWidth = 2 ^ maxWidtLen
	parameter sizeValue = 0 // Maksymalny rozmiar komórki w macierzy
)
(

	input clk,
	
	// Save
	input[(maxWidthLen-1):0] wx,
	input[(maxWidthLen-1):0] wy,
	
	input signed[(sizeValue-1):0] in,
	
	input w,
	
	// Read
	
	input[(maxWidthLen-1):0] x,
	input[(maxWidthLen-1):0] y,
	
	output reg signed[(sizeValue-1):0] out
	
);


reg signed[(sizeValue-1):0] memory[(((2 ** maxWidthLen) * (2 ** maxWidthLen)) - 1):0]; // pamiec

reg[{maxWidthLen+maxWidthLen}:0] n = 0;

initial // Zerowanie wstepne macierzy
	begin
		for(n=0;n<((2 ** maxWidthLen) * (2 ** maxWidthLen));n=n + 1)begin
			memory[n] = 0;
		end
	end	

always@(posedge clk)begin
	if(w) memory[{wx,wy}] <= in; // Zapis
	
	out <= memory[{x,y}];
	end


endmodule
