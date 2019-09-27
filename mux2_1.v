module mux2_1(a, b, control, S);//ok
	input[31:0] a;
	input [31:0] b;
	input control;
	output reg [31:0]S;
	always@(*)
		case (control)
			0: S = a;
			1: S = b;
		endcase
endmodule 