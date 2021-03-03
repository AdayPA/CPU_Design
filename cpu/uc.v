module uc(input wire [5:0] opcode, input wire z, output reg s_inc, s_inm, we3, wez, output reg [2:0] op_alu);

always @(opcode)
casez (opcode)
	6'b0zzzzz:
		begin
			op_alu = opcode[4:2];
			wez = 1; s_inm = 0;
			we3 = 1;
		end
	6'b10zzzz:
		begin
			s_inm = 1; we3 = 1;
		end
default: ;
endcase

endmodule
