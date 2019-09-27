module ula(ALUctl, A, B, ALUOut, Zero);//ok
	input [3:0] ALUctl;
	input [31:0] A,B;
	output reg [31:0] ALUOut;
	output Zero;
	assign Zero = (ALUOut==0); // Zero é true se ALUOut é 0
	always @(ALUctl, A, B) begin // reavalia se isso mudar
		case (ALUctl)
			0: ALUOut <= A & B; //and
			1: ALUOut <= A | B; //or
			2: ALUOut <= A + B; //adição
			6: ALUOut <= A - B; //subtracao
			7: ALUOut <= A < B ? 1 : 0; //resultado é set-on-less-than
			12: ALUOut <= ~(A | B); // resultado é nor
			default: ALUOut <= 0;
		endcase
	end
endmodule 