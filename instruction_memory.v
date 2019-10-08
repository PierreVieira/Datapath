module instruction_memory(read_adress, saida_andress);
	input [31:0] read_adress;
	output [31:0]saida_andress;
	
	assign saida_andress = read_adress;
	
endmodule 