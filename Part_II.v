module Part_II(Counter, Data_A, Data_B,, Clock, data_out);
	input [1:0]Counter;
	input Clock;
	input [7:0]Data_A, Data_B;
	output [15:0]data_out;
	
	wire [7:0]Reg_A, Reg_B;
	wire [15:0]Reg_Sum;
	wire ld;
	
	assign ld = ~(Counter[1] | Counter[0]);
	
	Reg8bit RegA(Data_A, ld, Clock, Reg_A);
	Reg8bit RegB(Data_B, ld, Clock, Reg_B);
	bitAdder RegSum(Reg_A, Reg_B, Reg_Sum, Clock);
	
	Fourto1Mux mux(Reg_A, Reg_B, Reg_Sum, Clock, Counter, data_out);
	
endmodule 

//mux
module Fourto1Mux(Data_A, Data_B, Data_Sum, Clock, Counter, Data_out);
	input [7:0]Data_A, Data_B;
	input [15:0]Data_Sum;
	input [1:0]Counter;
	input Clock;
	output reg [15:0]Data_out;
	
	always @(posedge Clock)
		if (Counter == 2'b00)
			Data_out <= 16'b0;
		else if(Counter == 2'b01)
			Data_out <= Data_A;
		else if(Counter == 2'b10)
			Data_out <= Data_B;
		else if(Counter == 2'b11)
			Data_out <= Data_Sum;
endmodule
			
	
//register
module Reg8bit(Data_in, ld_sel, Clock, Data_out);
	input [7:0]Data_in;
	input ld_sel, Clock;
	output reg [7:0]Data_out;
	
	always @(posedge Clock)
		if(ld_sel == 1)
			Data_out <= Data_in;
endmodule		


//adder
module bitAdder(Data_A, Data_B, Data_out, Clock);
	input [7:0]Data_A, Data_B;
	input Clock;
	output reg [15:0]Data_out;
	
	always @(posedge Clock)
		Data_out <= Data_A+Data_B;
endmodule
	
	
