
module MatrixMultiplier
#(
	parameter maxWidthLen= 6, // maxWidth = 2 ^ maxWidtLen
	parameter sizeValue = 16 // Maksymalny rozmiar komórki w macierzy
)
(
	input clk,
	input rst,
	
	// in1
	input[(maxWidthLen-1):0] wx1,
	input[(maxWidthLen-1):0] wy1,
	
	input signed[(sizeValue-1):0] in1,
	
	input w1,
	
	
	// in2
	input[(maxWidthLen-1):0] wx2,
	input[(maxWidthLen-1):0] wy2,
	
	input signed[(sizeValue-1):0] in2,
	
	input w2,
	
	// start
	
	input start,
	input[maxWidthLen - 1: 0] sizeX,
	input[maxWidthLen - 1: 0] sizeY,
	
	// out
	
	
	input[(maxWidthLen-1):0] resx,
	input[(maxWidthLen-1):0] resy,
	
	output signed[(sizeValue-1):0] outres,
	
	output rdy
);

	wire[(maxWidthLen-1):0] x1matrix; // Polaczenia z macierza 1
	wire[(maxWidthLen-1):0] y1matrix;
	wire signed[(sizeValue-1):0] out1matrix;

	wire[(maxWidthLen-1):0] x2matrix; // Polaczenia z macierza 2
	wire[(maxWidthLen-1):0] y2matrix;
	wire signed[(sizeValue-1):0] out2matrix;

	
	
	wire starta;
	wire[(maxWidthLen-1):0] xa;
	wire[(maxWidthLen-1):0] ya;
	
	wire reada;
	wire[(maxWidthLen-1):0] x1a; // Polaczenia z macierza 1
	wire[(maxWidthLen-1):0] y1a;
	wire signed[(sizeValue-1):0] out1a;

	wire[(maxWidthLen-1):0] x2a; // Polaczenia z macierza 2
	wire[(maxWidthLen-1):0] y2a;
	wire signed[(sizeValue-1):0] out2a;
	
	
	
	wire startb;
	wire[(maxWidthLen-1):0] xb;
	wire[(maxWidthLen-1):0] yb;
	
	wire readb;
	wire[(maxWidthLen-1):0] x1b; // Polaczenia z macierza 1
	wire[(maxWidthLen-1):0] y1b;
	wire signed[(sizeValue-1):0] out1b;

	wire[(maxWidthLen-1):0] x2b; // Polaczenia z macierza 2
	wire[(maxWidthLen-1):0] y2b;
	wire signed[(sizeValue-1):0] out2b;
	
	
	
	wire startc;
	wire[(maxWidthLen-1):0] xc;
	wire[(maxWidthLen-1):0] yc;
	
	wire readc;
	wire[(maxWidthLen-1):0] x1c; // Polaczenia z macierza 1
	wire[(maxWidthLen-1):0] y1c;
	wire signed[(sizeValue-1):0] out1c;

	wire[(maxWidthLen-1):0] x2c; // Polaczenia z macierza 2
	wire[(maxWidthLen-1):0] y2c;
	wire signed[(sizeValue-1):0] out2c;
	
	
	
	wire startd;
	wire[(maxWidthLen-1):0] xd;
	wire[(maxWidthLen-1):0] yd;
	
	wire readd;
	wire[(maxWidthLen-1):0] x1d; // Polaczenia z macierza 1
	wire[(maxWidthLen-1):0] y1d;
	wire signed[(sizeValue-1):0] out1d;

	wire[(maxWidthLen-1):0] x2d; // Polaczenia z macierza 2
	wire[(maxWidthLen-1):0] y2d;
	wire signed[(sizeValue-1):0] out2d;
	
	
	wire starte;
	wire[(maxWidthLen-1):0] xe;
	wire[(maxWidthLen-1):0] ye;
	
	wire reade;
	wire[(maxWidthLen-1):0] x1e; // Polaczenia z macierza 1
	wire[(maxWidthLen-1):0] y1e;
	wire signed[(sizeValue-1):0] out1e;

	wire[(maxWidthLen-1):0] x2e; // Polaczenia z macierza 2
	wire[(maxWidthLen-1):0] y2e;
	wire signed[(sizeValue-1):0] out2e;
	
	
	
	Matrix #(maxWidthLen, sizeValue) mat1( // Macierz 1
					.clk(clk),
					.wx(wx1),
					.wy(wy1),
					
					.in(in1),
					
					.w(w1),
					
					.x(x1matrix),
					.y(y1matrix),
					.out(out1matrix)
					
					
	);

	Matrix #(maxWidthLen, sizeValue) mat2( // Macierz 2
					.clk(clk),
					.wx(wx2),
					.wy(wy2),
					
					.in(in2),
					
					.w(w2),
					
					.x(x2matrix),
					.y(y2matrix),
					.out(out2matrix)
	);
	
	
	wire[(maxWidthLen-1):0] ox;
	wire[(maxWidthLen-1):0] oy;
	wire signed[(sizeValue-1):0] out;
	wire w;
	
	Matrix #(maxWidthLen, sizeValue) buffer( // Macierz wynikowa
					.clk(clk),
					.wx(ox),
					.wy(oy),
					
					.in(out),
					
					.w(w),
					
					.x(resx),
					.y(resy),
					.out(outres)
	);
	

	MatrixConnector #(maxWidthLen, sizeValue) matcon(
		.clk(clk),
		.rst(rst),
		
		.reada(reada),
		.rx1a(x1a), // Parametry odczytu macierzy 1
		.ry1a(y1a),
		.out1a(out1a),
		
		.rx2a(x2a), // Parametry odczytu macierzy 2
		.ry2a(y2a),
		.out2a(out2a),
		
		
		
		.readb(readb),
		.rx1b(x1b), // Parametry odczytu macierzy 1
		.ry1b(y1b),
		.out1b(out1b),
		
		.rx2b(x2b), // Parametry odczytu macierzy 2
		.ry2b(y2b),
		.out2b(out2b),
		
		
		
		
		.readc(readc),
		.rx1c(x1c), // Parametry odczytu macierzy 1
		.ry1c(y1c),
		.out1c(out1c),
		
		.rx2c(x2c), // Parametry odczytu macierzy 2
		.ry2c(y2c),
		.out2c(out2c),
		
		
		
		
		.readd(readd),
		.rx1d(x1d), // Parametry odczytu macierzy 1
		.ry1d(y1d),
		.out1d(out1d),
		
		.rx2d(x2d), // Parametry odczytu macierzy 2
		.ry2d(y2d),
		.out2d(out2d),
		
		
		
		
		.reade(reade),
		.rx1e(x1e), // Parametry odczytu macierzy 1
		.ry1e(y1e),
		.out1e(out1e),
		
		.rx2e(x2e), // Parametry odczytu macierzy 2
		.ry2e(y2e),
		.out2e(out2e),
		
		
		
		
		
		.rx1matrix(x1matrix), // Parametry odczytu macierzy 1
		.ry1matrix(y1matrix),
		.out1matrix(out1matrix),
		
		.rx2matrix(x2matrix), // Parametry odczytu macierzy 2
		.ry2matrix(y2matrix),
		.out2matrix(out2matrix)
		
	);

	wire signed[(sizeValue-1):0] outa;
	wire rdya;
	
	wire signed[(sizeValue-1):0] outb;
	wire rdyb;
	
	wire signed[(sizeValue-1):0] outc;
	wire rdyc;
	
	wire signed[(sizeValue-1):0] outd;
	wire rdyd;
	
	wire signed[(sizeValue-1):0] oute;
	wire rdye;
	
	
	CellMaker #(maxWidthLen, sizeValue) cellMa( // Mnoznik macierzy
		.clk(clk),
		.rst(rst),
		
		.limit(32), // Maksymalny rozmiar wspólny macierzy
		
		.start(starta), // Parametry startowe
		.x(xa),
		.y(ya),
		
		.rx1(x1a), // Parametry odczytu macierzy 1
		.ry1(y1a),
		.out1(out1a),
		
		.rx2(x2a), // Parametry odczytu macierzy 2
		.ry2(y2a),
		.out2(out2a),
		
		.out(outa), // Wyjscie
		.rdy(rdya),
		
		.read(reada)
	);				

	CellMaker #(maxWidthLen, sizeValue) cellMb( // Mnoznik macierzy
		.clk(clk),
		.rst(rst),
		
		.limit(32), // Maksymalny rozmiar wspólny macierzy
		
		.start(startb), // Parametry startowe
		.x(xb),
		.y(yb),
		
		.rx1(x1b), // Parametry odczytu macierzy 1
		.ry1(y1b),
		.out1(out1b),
		
		.rx2(x2b), // Parametry odczytu macierzy 2
		.ry2(y2b),
		.out2(out2b),
		
		.out(outb), // Wyjscie
		.rdy(rdyb),
		
		.read(readb)
	);		
	
	CellMaker #(maxWidthLen, sizeValue) cellMc( // Mnoznik macierzy
		.clk(clk),
		.rst(rst),
		
		.limit(32), // Maksymalny rozmiar wspólny macierzy
		
		.start(startc), // Parametry startowe
		.x(xc),
		.y(yc),
		
		.rx1(x1c), // Parametry odczytu macierzy 1
		.ry1(y1c),
		.out1(out1c),
		
		.rx2(x2c), // Parametry odczytu macierzy 2
		.ry2(y2c),
		.out2(out2c),
		
		.out(outc), // Wyjscie
		.rdy(rdyc),
		
		.read(readc)
	);		
	
	CellMaker #(maxWidthLen, sizeValue) cellMd( // Mnoznik macierzy
		.clk(clk),
		.rst(rst),
		
		.limit(32), // Maksymalny rozmiar wspólny macierzy
		
		.start(startd), // Parametry startowe
		.x(xd),
		.y(yd),
		
		.rx1(x1d), // Parametry odczytu macierzy 1
		.ry1(y1d),
		.out1(out1d),
		
		.rx2(x2d), // Parametry odczytu macierzy 2
		.ry2(y2d),
		.out2(out2d),
		
		.out(outd), // Wyjscie
		.rdy(rdyd),
		
		.read(readd)
	);	


	
	CellMaker #(maxWidthLen, sizeValue) cellMe( // Mnoznik macierzy
		.clk(clk),
		.rst(rst),
		
		.limit(32), // Maksymalny rozmiar wspólny macierzy
		
		.start(starte), // Parametry startowe
		.x(xe),
		.y(ye),
		
		.rx1(x1e), // Parametry odczytu macierzy 1
		.ry1(y1e),
		.out1(out1e),
		
		.rx2(x2e), // Parametry odczytu macierzy 2
		.ry2(y2e),
		.out2(out2e),
		
		.out(oute), // Wyjscie
		.rdy(rdye),
		
		.read(reade)
	);		
	
	wire[(maxWidthLen-1):0] f_xam;
	wire[(maxWidthLen-1):0] f_xbm;
	wire[(maxWidthLen-1):0] f_xcm;
	wire[(maxWidthLen-1):0] f_xdm;
	wire[(maxWidthLen-1):0] f_xem;

	wire[(maxWidthLen-1):0] f_yam;
	wire[(maxWidthLen-1):0] f_ybm;
	wire[(maxWidthLen-1):0] f_ycm;
	wire[(maxWidthLen-1):0] f_ydm;
	wire[(maxWidthLen-1):0] f_yem;
	
	MatrixReceiver #(maxWidthLen, sizeValue) cellMRe(
		.clk(clk),
		
		.f_xam(f_xam),
		.f_xbm(f_xbm),
		.f_xcm(f_xcm),
		.f_xdm(f_xdm),
		.f_xem(f_xem),

		.f_yam(f_yam),
		.f_ybm(f_ybm),
		.f_ycm(f_ycm),
		.f_ydm(f_ydm),
		.f_yem(f_yem),
		
		.rdya(rdya),
		.outa(outa),
		
		.rdyb(rdyb),
		.outb(outb),
		
		.rdyc(rdyc),
		.outc(outc),
		
		.rdyd(rdyd),
		.outd(outd),
		
		
		.rdye(rdye),
		.oute(oute),
		
		
		.rdy(w),
		.ox(ox),
		.oy(oy),
		
		.out(out)
	);
	
wire startCore;
	
wire[(maxWidthLen-1):0] x;
wire[(maxWidthLen-1):0] y;
	
wire[2:0] index;

MatrixController #(maxWidthLen, sizeValue) cellMCo(
		.clk(clk),
		.rst(rst),
		
		.index(index),
		.f_xam(f_xam),
		.f_xbm(f_xbm),
		.f_xcm(f_xcm),
		.f_xdm(f_xdm),
		.f_xem(f_xem),

		.f_yam(f_yam),
		.f_ybm(f_ybm),
		.f_ycm(f_ycm),
		.f_ydm(f_ydm),
		.f_yem(f_yem),
	
	
		.start(startCore),
		.x(x), // Parametry odczytu macierzy 1
		.y(y),
		
		
		.starta(starta),
		.xa(xa),
		.ya(ya),
		
		
		
		.startb(startb),
		.xb(xb),
		.yb(yb),
		
		
		
		.startc(startc),
		.xc(xc),
		.yc(yc),
		
		
		
		.startd(startd),
		.xd(xd),
		.yd(yd),
		
		
		
		.starte(starte),
		.xe(xe),
		.ye(ye)
		
	);

MatrixPlanner#(maxWidthLen, sizeValue) mPla(
	.clk(clk),
	.rst(rst),

	.start(start),
	.index(index),
	
	.sizex(sizeX),
	.sizey(sizeY),
	
	.rdy1(rdya),
	.rdy2(rdyb),
	.rdy3(rdyc),
	.rdy4(rdyd),
	.rdy5(rdye),
	
	
	.rdy(rdy),
	
	.rx(x),
	.ry(y),
	
	.startCore(startCore)
);


endmodule





