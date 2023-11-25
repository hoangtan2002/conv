// Copyright (C) 2022  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.


// Generated by Quartus Prime Version 22.1 (Build Build 915 10/25/2022)
// Created on Mon Nov 20 16:43:02 2023

conv conv_inst
(
	.inMatrix(inMatrix_sig) ,	// input [7:0] inMatrix_sig
	.inRow(inRow_sig) ,	// input [3:0] inRow_sig
	.inCol(inCol_sig) ,	// input [3:0] inCol_sig
	.kernel(kernel_sig) ,	// input [7:0] kernel_sig
	.kerRow(kerRow_sig) ,	// input [3:0] kerRow_sig
	.kerCol(kerCol_sig) ,	// input [3:0] kerCol_sig
	.clk(clk_sig) ,	// input  clk_sig
	.outMatrix(outMatrix_sig) ,	// output [15:0] outMatrix_sig
	.accumulator(accumulator_sig) ,	// output [15:0] accumulator_sig
	.regionResult(regionResult_sig) 	// output [15:0] regionResult_sig
);

