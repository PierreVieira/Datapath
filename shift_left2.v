module shift_left2(entrada, saida);
	input [31:0]entrada;
	output [31:0]saida;
	assign saida = entrada << 2;
endmodule 