module uc(input wire [5:0] opcode, input wire z, output reg s_inc, s_inm, we3, wez, s_pila, push, pop, we4, s_data,  output reg [2:0] op_alu);

always @(opcode)
casez (opcode)
	6'b0zzzzz:   // aritmetica
		begin
			op_alu = opcode[4:2];
			wez = 1; s_inm = 0;
			we3 = 1; s_inc = 1;
			s_pila = 0; push = 0;
			pop = 0; we4 = 0;
		end
	6'b100000:   // carga inmediata
		begin
			s_inm = 1; we3 = 1;
			s_inc = 1; s_pila = 0;
			push = 0; pop = 0;
			s_data = 0; we4 = 0;
		end
	6'b100001:  // salto
		begin
			s_inc = 0; s_pila = 0;
			push = 0; pop = 0;
			we4 = 0;
		end
	6'b100010:  // salto si z
		begin
			s_pila = 0; we4 = 0;
			we3 = 0; wez = 0;
			push = 0; pop = 0;
			// if ( z == 1b'1 ) begin
			if ( z == 1 ) begin
				s_inc = 0;
			end else begin
				s_inc = 1;
			end
		end
	6'b100011: // salto si no z
		begin
			s_pila = 0; we4 = 0;
			we3 = 0; wez = 0;
			push = 0; pop = 0;
			if ( z == 0 ) begin
				s_inc = 0;
			end else begin
				s_inc = 1;
			end
		end
	6'b100100: // push pila
		begin
			s_inc = 1;
			push = 1; pop = 0;
			s_pila = 0;
			we3 = 0; wez = 0;
			we4 = 0;
		end
	6'b100101: // pop pila
		begin
			pop = 1; push = 0;
			s_pila = 1;
			we3 = 0; wez = 0;
			we4 = 0;
		end
	6'b100110: // load word (mem datos ----> banco registros)
		begin
			s_inc = 0; s_pila = 0; 
			we3 = 1; wez = 0;
			we4 = 0; s_data = 1;
			s_inm = 1;
		end
	6'b100111: // save word (banco registros ----> mem datos)
		begin
			s_inc = 0; s_pila = 0;
			we3 = 0; wez = 0;
			we4 = 1; s_data = 1;
			s_inm = 1;
		end

default: ;
endcase

endmodule
