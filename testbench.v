`timescale 1ns/1ps
/*TODO:Fix Processing section*/
module testbench();
	reg [7:0]kernelData[3:0][3:0]; 
	reg [7:0]inMatrixData[5:0][5:0];
	reg [7:0]inMatrix=8'h0;
	reg [7:0]kernel=8'h0;
	wire [15:0]outMatrix;
	reg [3:0]inRow = 4'h5;
	reg [3:0]inCol = 4'h5;
	reg [3:0]kerRow = 4'h3;
	reg [3:0]kerCol = 4'h3;
	reg clk;
	reg[15:0] clkcycle = 16'h027f;
	reg[3:0]i = 4'h0;
	reg[3:0]j = 4'h0;
	reg[3:0]k = 4'h0;
	reg[3:0]l = 4'h0;  
	reg[3:0]m = 4'h0;
	reg[3:0]n = 4'h0;
	reg[3:0]o = 4'h0;
	reg[3:0]state=4'h0;
	reg[15:0]p=16'h0;

	initial begin
		//Assign test data
		kernelData[0][0] = 8'h1;
		kernelData[0][1] = 8'h0;
		kernelData[0][2] = 8'h1;
		kernelData[0][3] = 8'h0;
		kernelData[1][0] = 8'h0;
		kernelData[1][1] = 8'h1;
		kernelData[1][2] = 8'h0;
		kernelData[1][3] = 8'h0;
		kernelData[2][0] = 8'h1;
		kernelData[2][1] = 8'h0;
		kernelData[2][2] = 8'h1;
		kernelData[2][3] = 8'h0;
		kernelData[3][0] = 8'h0;
		kernelData[3][1] = 8'h0;
		kernelData[3][2] = 8'h0;
		kernelData[3][3] = 8'h0;
		inMatrixData[0][0] = 8'h1;
		inMatrixData[0][1] = 8'h0;
		inMatrixData[0][2] = 8'h2;
		inMatrixData[0][3] = 8'h3;
		inMatrixData[0][4] = 8'h4;
		inMatrixData[0][5] = 8'h0;
		inMatrixData[1][0] = 8'h5;
		inMatrixData[1][1] = 8'h6;
		inMatrixData[1][2] = 8'h7;
		inMatrixData[1][3] = 8'h8;
		inMatrixData[1][4] = 8'h9;
		inMatrixData[1][5] = 8'h0;
		inMatrixData[2][0] = 8'ha;
		inMatrixData[2][1] = 8'hb;
		inMatrixData[2][2] = 8'hc;
		inMatrixData[2][3] = 8'hd;
		inMatrixData[2][4] = 8'he;
		inMatrixData[2][5] = 8'h0;
		inMatrixData[3][0] = 8'hf;
		inMatrixData[3][1] = 8'h10;
		inMatrixData[3][2] = 8'h11;
		inMatrixData[3][3] = 8'h12;
		inMatrixData[3][4] = 8'h13;
		inMatrixData[3][5] = 8'h0;
		inMatrixData[4][0] = 8'h14;
		inMatrixData[4][1] = 8'h15;
		inMatrixData[4][2] = 8'h16;
		inMatrixData[4][3] = 8'h17;
		inMatrixData[4][4] = 8'h18;
		inMatrixData[4][5] = 8'h0;
		inMatrixData[5][0] = 8'h0;
		inMatrixData[5][1] = 8'h0;
		inMatrixData[5][2] = 8'h0;
		inMatrixData[5][3] = 8'h0;
		inMatrixData[5][4] = 8'h0;
		inMatrixData[5][5] = 8'h0;
		//outMatrix = 8'h0;
	end
	conv Module1(.inMatrix(inMatrix),
	             .inRow(inRow),
					 .inCol(inCol),
					 .kernel(kernel),
					 .kerRow(kerRow),
					 .kerCol(kerCol),
					 .clk(clk),
					 .outMatrix(outMatrix));
	initial begin 
		clk=0;
		for (p=0;p<clkcycle;p=p+1) begin
			#20 clk = ~clk;
		end
	end
	always@(posedge clk) begin
		if (state==4'h0) begin
			if (m<inRow+1) begin
				if (n<inCol+1) begin
					inMatrix = inMatrixData[m][n];
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
					kernel = kernelData[m][n];
					n = n + 4'h1;
					if(n==kerCol+1) begin
						n=4'h0;
						m=m+1;
						if(m==kerRow+1) begin
							m=4'h0;
							n=4'h0;
							state=4'h2;
						end
					end
				end
			end
		end
		else if (state==4'h2) begin
			if (o<4'h3) begin
				o=o+4'h1;
				if (o==4'h2) begin
					state=4'h3;
					o = 4'h0;
				end
			end
		end
		//Massive Block of Busy-waiting
		else if (state==4'h3) begin
			if (i<inRow-kerRow+1) begin
				if (j<inCol-kerCol+1) begin
					if (k<kerRow+1) begin
						if (l<kerCol+1) begin
							l=l+4'h1;
							if (l==kerCol+1) begin
								l=0;
								k=k+4'h1;
								if (k==kerRow+1) begin
									k=0;
									j=j+4'h1;
									if (j==inCol-kerCol+1) begin
										j=0;
										i=i+4'h1;
										if(i==inRow-kerRow+1) begin
											i=0;
											j=0;
											k=0;
											l=0;
											$display("Out matrix 1:");
											state=4'h5;
										end
									end
								end
							end 
						end
					end
				end
			end 
		end
		//Output data
		else if (state==4'h4) begin
			if (o<4'h2) begin
				o=o+1;
				if (o==4'h1) begin
					o=4'h0;
					$display("Out matrix 1:");
					state=4'h5;
				end
			end
		end
		else if (state==4'h5) begin
			if (m<inRow-kerRow+1) begin
				if (n<inCol-kerCol+1) begin
					$write("%d ",outMatrix);
					n=n+4'h1;
					if(n==inCol-kerCol+1) begin
						n=4'h0;
						m=m+4'h1;
						$write("\n");
						if(m==inRow-kerRow+1) begin
							m = 4'h0;
							n = 4'h0;
							o = 4'h0;
							state=4'h0;
						end
					end
				end
			end
		end	
	end	
endmodule
