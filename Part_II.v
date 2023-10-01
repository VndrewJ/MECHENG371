module Part_II(Data_A, Data_B, Clock, Data_out, reg_A_check, reg_B_check, counter_check);
	input [7:0]Data_A, Data_B;
	input Clock;
	
	wire[15:0]sum;
	wire [7:0]Reg_A, Reg_B;
	wire [1:0]Counter;
	wire ld;
	
	output [15:0]Data_out;
	output [7:0] reg_A_check, reg_B_check;
	output [1:0]counter_check;
	
	counter(Clock, Counter);
	assign counter_check = Counter;
	
	assign ld = ~(Counter[1] | Counter[0]);
	
	register(Data_A, Clock, ld, Reg_A);
	register(Data_B, Clock, ld, Reg_B);
	
	assign reg_A_check = Reg_A;
	assign reg_B_check = Reg_B;
	
	adder(Reg_A, Reg_B, sum);
	
	mux(Reg_A, Reg_B, sum, Counter, Data_out);
endmodule

//counter
module counter(Clock, counter_out);
	input Clock;
	output reg [1:0]counter_out;
	
	always @(posedge Clock)
		counter_out <= counter_out+1;

endmodule

//registers
module register(Data_in, Clock, ld, Data_out);
	input [7:0]Data_in;
	input Clock, ld;
	output reg [7:0]Data_out;
	
	always @(posedge Clock)
		if(ld)
			Data_out <= Data_in;
endmodule

//adder
module adder(Data_A, Data_B, Data_out);
	input [7:0]Data_A, Data_B;
	output reg [15:0]Data_out;
	
	always @(*)
		Data_out <= Data_A+Data_B;
		
endmodule

//mux
module mux(Data_A, Data_B, Data_Sum, Counter, Data_Out);
	input [7:0]Data_A, Data_B;
	input [15:0]Data_Sum;
	input [1:0]Counter;
	output reg [15:0]Data_Out;
	
	always @(*)
		case(Counter)
			2'b00: Data_Out <= 0;
			2'b01: Data_Out <= Data_A;
			2'b10: Data_Out <= Data_B;
			2'b11: Data_Out <= Data_Sum;
			
		endcase
		
endmodule
