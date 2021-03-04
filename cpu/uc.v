module uc(input wire [5:0] opcode, input wire z, output reg s_inc, s_inm, we3, wez, output reg [2:0] op_alu);

always @(opcode)
casez (opcode)
	6'b0zzzzz:   // aritmetica
		begin
			op_alu = opcode[4:2];
			wez = 1; s_inm = 0;
			we3 = 1; s_inc = 1;
		end
	6'b10zzzz:   // carga inmediata
		begin
			s_inm = 1; we3 = 1;
			s_inc = 1;
		end
	6'b110zzz:  // salto
		begin
			s_inc = 0; 
		end
	6'b1110zz:  // salto si z
		begin
			// if ( z == 1b'1 ) begin
			if ( z == 1 ) begin
				s_inc = 0;
			end else begin
				s_inc = 1;
			end
		end
	6'b1111zz: // salto si no z
		begin
			if ( z == 0 ) begin
				s_inc = 0;
			end else begin
				s_inc = 1;
			end
		end
default: ;
endcase

endmodule
