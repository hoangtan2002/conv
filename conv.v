module conv(
  input [7:0]inMatrix,
  input [3:0]inRow,
  input [3:0]inCol,
  input [7:0]kernel,
  input [3:0]kerRow,
  input [3:0]kerCol,
  input clk,
  output reg[15:0]outMatrix);
	
	reg[5:0]a = 5'h0;
	reg[5:0]b = 5'h0;
	reg[3:0]i = 4'h0;
	reg[3:0]j = 4'h0;
	reg[3:0]k = 4'h0;
	reg[3:0]l = 4'h0;  
	reg[3:0]m = 4'h0;
	reg[3:0]n = 4'h0;
	reg[3:0]o = 4'h0;
	reg[3:0]state = 4'h0;
	reg[15:0]accumulator = 16'h0000;
	//reg[15:0]accumulator = 16'h0;
	reg[7:0]kernelBuf[15:0][15:0];
	reg[7:0]inMatrixBuf[15:0][15:0];
	reg[15:0]outMatrixBuf[15:0][15:0];
	initial begin
		//reset buffer
		for(a=0; a<16; a=a+1) begin
			for(b=0; b<16;b=b+1) begin
				inMatrixBuf[a][b] =8'h00;
				kernelBuf[a][b] = 8'h00;
				outMatrixBuf[a][b] = 16'h0000;
			end
		end
		accumulator = 16'h0;
		outMatrix = 16'h0;
	end
	
	always@(posedge clk) begin
		//Stream in data 
		if (state==4'h0) begin
			if (m<inRow+1) begin
				if (n<inCol+1) begin
					inMatrixBuf[m][n] = inMatrix;
					n=n+4'h1;
					if (n==inCol+1) begin
						n = 4'h0;
						m = m + 4'h1;
						if (m==inRow+1) begin 
							state = 4'h1;
							m=4'h0;
							n=4'h0;
						end
					end
				end
			end
		end
		else if (state==4'h1) begin
			//stream in kernel
			if(m<kerRow+1) begin
				if(n<kerCol+1) begin
					kernelBuf[m][n] = kernel;
					n = n + 4'h1;
					if(n==kerCol+1) begin
						n=4'h0;
						m=m+4'h1;
						if(m==kerRow+1) begin
							m=4'h0;
							n=4'h0;
							i=4'h0;
							j=4'h0;
							k=4'h0;
							l=4'h0;
							state=4'h3;
						end
					end	
				end
			end
		end
		else if (state==4'h3) begin
		//Convolution operation
		if (i<inRow-kerRow+1) begin
				if (j<inCol-kerCol+1) begin
					if (k<kerRow+1) begin
						if (l<kerCol+1) begin
							accumulator = accumulator + inMatrixBuf[i+k][j+l]*kernelBuf[k][l];
							l=l+4'h1;
							if (l==kerCol+1) begin
								l=0;
								k=k+4'h1;
								if (k==kerRow+1) begin
									outMatrixBuf[i][j] = accumulator;
									accumulator=16'h0;
									k=4'h0;
									j=j+4'h1;
									if (j==inCol-kerCol+1) begin
										j=0;
										i=i+4'h1;
										if(i==inRow-kerRow+1) begin
											i=4'h0;
											j=4'h0;
											k=4'h0;
											l=4'h00;
											state=4'h4;
										end
									end
								end
							end 
						end
					end
				end
			end
		end
		else if (state==4'h4) begin
			if(o<4'h1) begin
				o=o+4'h1;
				if (o==4'h1) begin
					o = 4'h0;
					state=4'h5;
				end
			end
		end
		//Output data
		else if (state==4'h5) begin
			 if (m<inRow-kerRow+1) begin
				if (n<inCol-kerCol+1) begin
					outMatrix=outMatrixBuf[m][n];
					n=n+4'h1;
					if(n==inCol-kerCol+1) begin
						n=4'h0;
						m=m+4'h1;
						if(m==inRow-kerRow+1) begin
							m = 4'h0;
							n = 4'h0;
							state = 4'h0;
						end
					end
				end
			end
		end	
	end
endmodule 

/*

module conv(
input a,
input b,
output c);

	assign c = a + b;

endmodule
*/
