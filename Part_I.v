module Part_I (Data_A, Data_B, Data_C, output_sel, Clock, ld_a, ld_b, ld_c, data_out);
	input [7:0]Data_A, Data_B;
	input [15:0]Data_C;
	input [1:0]output_sel;
	input ld_a, ld_b, ld_c;
	input Clock;
	wire [7:0]out_A, out_B;
	wire [15:0]out_C;
	output [15:0]data_out;
	
	
	Reg_8bit RegA(Data_A, ld_a, Clock, out_A);
	Reg_8bit RegB(Data_B, ld_b, Clock, out_B);
	Reg_16bit RegC(Data_C, ld_c, Clock, out_C);
	
	mux4to1 mux(out_A, out_B, out_C, output_sel, Clock, data_out);
endmodule
	
//mux
module mux4to1(Data_A, Data_B, Data_C, output_sel, Clock, data_out);
	input [7:0]Data_A, Data_B;
	input [15:0]Data_C;
	input [1:0]output_sel;
	input Clock;
	output reg [15:0]data_out;
	
	always@(posedge Clock)
		if(output_sel == 2'b00)
			data_out <= Data_A;
		else if(output_sel == 2'b01)
			data_out <= Data_B;
		else if(output_sel == 2'b10)
			data_out <= Data_C;
		else if(output_sel == 2'b11)
			data_out <= 16'b0;
endmodule
	
//registers
module Reg_8bit(Data, ld, Clock, out);
	input [7:0]Data;
	input ld;
	input Clock;
	output reg [7:0]out;
		
	always@(posedge Clock)
		if(ld == 1)
			out <= Data;
endmodule
	

module Reg_16bit(Data_C, ld_c, Clock, out_C);
	input [7:0]Data_C;
	input ld_c;
	input Clock;
	output reg [7:0]out_C;
		
	always@(posedge Clock)
		if(ld_c == 1)
			out_C <= Data_C;
endmodule

