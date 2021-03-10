module uc(input wire [5:0] opcode, input wire z, output reg s_inc, s_inm, we3, wez, s_pila, push, pop,  output reg [2:0] op_alu);

always @(opcode)
casez (opcode)
	6'b0zzzzz:   // aritmetica
		begin
			op_alu = opcode[4:2];
			wez = 1; s_inm = 0;
			we3 = 1; s_inc = 1;
			s_pila = 0;
		end
	6'b100000:   // carga inmediata
		begin
			s_inm = 1; we3 = 1;
			s_inc = 1; s_pila = 0;
		end
	6'b100001:  // salto
		begin
			s_inc = 0; s_pila = 0;
		end
	6'b100010:  // salto si z
		begin
			s_pila = 0;
			// if ( z == 1b'1 ) begin
			if ( z == 1 ) begin
				s_inc = 0;
			end else begin
				s_inc = 1;
			end
		end
	6'b100011: // salto si no z
		begin
			s_pila = 0;
			if ( z == 0 ) begin
				s_inc = 0;
			end else begin
				s_inc = 1;
			end
		end
	6'b100100: // push pila
		begin
			push = 1;
			s_pila = 1;
		end
	6'b100101: // pop pila
		begin
			pop = 1;
			s_pila = 1;
		end

default: ;
endcase

endmodule
