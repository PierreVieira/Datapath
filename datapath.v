module datapath(instrucao, clock, ALUctl, wr_en, PCSrc, ALUSrc, MemtoReg, Regwrite);
	input [31:0] instrucao;
	input wr_en, clock, Regwrite;
	input [3:0]ALUctl;
	input	PCSrc,ALUSrc,MemtoReg;
	
	// Bloco PC onde começa o caminho de dados
	wire [31:0]saida_instrucao;
	PC BLOCO_0(instrucao, saida_instrucao);
	
	//add depois do PC
	wire [31:0]saida_add_PC;
	somador BLOCO_10(saida_instrucao, 00000000000000000000000000000100);
	
	//Bloco que divide a instrução do PC
	wire [31:0]saida_andress;
	instruction_memory BLOCO_1 (saida_instrucao, saida_andress);
	
	// Banco de resitradores 
	wire [31:0]Data1, Data2;
	//registers (         Read1,            Read2,             WriteReg,              WriteData,       RegWrite, Data1, Data2, clock);
	registers BLOCO_2 (saida_andress[31:27], saida_andress[26:22], saida_andress[21:17], saida_mux_memory, Regwrite, Data1, Data2, clock);
	
	// entende o sinal de instrucao
	wire [31:0]saida_extensor;
	extensor BLOCO_3 (saida_andress[16:0], saida_extensor); 
		
	// mux depois do bloco de registradores
	wire [31:0]saida_mux2_1;
	mux2_1 BLOCO_4 (Data2, saida_extensor, ALUSrc, saida_mux2_1);
	
	// ULA
	wire Zero;
	wire [31:0] saida_ula;
	ula BLOCO_5 (ALUctl, Data1, saida_mux, saida_ula, Zero);

	// Shift desloca dois pra esquerda
	wire [31:0] saida_shift;
	shift_left2 BLOCO_6(saida_extensor, saida_shift);
	
	//Somador depois do shift
	wire[31:0]saida_add_shift;
	somador BLOCO_7 (saida_shift, saida_add_PC, saida_somador);
	
	// mux que tem a saida que volta no PC
	wire [31:0] saida_mux_pc;
	mux2_1 BLOCO_11(saida_add_PC, saida_add_shift, PCSrc, saida_mux_pc);
	
	// bloco de memoria
	 wire[15:0] saida_memory;
	data_memory BLOCO_8 (saida_ula, Data2, wr_en, saida_memory);
	
	//mux depois do data memory
	wire [31:0] saida_Mux_Memory;
	mux2_1 BLOCO_9 (saida_memory, saida_ula, MemtoReg, saida_Mux_Memory);
	
endmodule 