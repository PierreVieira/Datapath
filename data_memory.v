module data_memory (addr, data, wr_en, Clock, q);
input [4:0] addr; 
input [15:0] data;
input wr_en, Clock;
output [15:0] q;

reg [15:0] Mem [0:31];

initial 
begin
  
// Coloque o seu programa nas posições de memória

Mem[5'h0] = 32'b00100000000100010000000000000001;
Mem[5'h1] = 32'b00100000000100100000000000000010;
Mem[5'h2] = 32'b00000010001100100100000000100000;

//	...
    
end

assign q = Mem[addr];

always @(posedge Clock)
begin
  if (wr_en) Mem[addr] = data;
  
end

endmodule
