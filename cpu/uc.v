module uc(input wire [15:0] opcode, input wire z, output reg s_inc, we3, wez, s_pila, push, pop, we4, s_out, we5, we6, we7, we8,  output reg [1:0] s_port ,output reg [1:0] s_inm,  output reg [2:0] op_alu);

always @(opcode)
casez (opcode[15:10])
	6'b0zzzzz:   // aritmetica
		begin
			op_alu = opcode[14:12];
			s_inc = 1;
			s_inm = 2'b00;
			s_pila = 0; 
			we3 = 1; 
			push = 0;
			pop = 0; 
			we4 = 0;
			we5 = 0;
			we6 = 0;
			we7 = 0;
			we8 = 0;
			wez = 1;
		        s_port = 2'b00;
			s_out = 0;	
		end
	6'b100000:   // carga inmediata
		begin
			op_alu = 3'b000;
			s_inm = 2'b01; 
			we3 = 1;
			s_inc = 1; 
			s_pila = 0;
			push = 0; 
			pop = 0;
			we4 = 0;
			we5 = 0;
			we6 = 0;
			we7 = 0;
			we8 = 0;
			s_out = 0;
			s_port = 2'b00;
			wez = 0;

		end
	6'b100001:  // salto
		begin
			s_inc = 0; 
			s_pila = 0;
			push = 0; 
			pop = 0;
			we3 = 0;
			we4 = 0;
			we5 = 0;
			we6 = 0;
			we7 = 0;
			we8 = 0;
			wez = 0;
			s_out = 0;
			s_port = 2'b00;
			op_alu = 3'b00;
			s_inm = 2'b00;
		end
	6'b100010:  // salto si z
		begin
			s_pila = 0; 
			we3 = 0;
		        we4 = 0;
			we5 = 0;
			we6 = 0;
			we7 = 0;
			we8 = 0;	
			wez = 0;
			push = 0; 
			pop = 0;
			s_port = 2'b00;
			s_inm = 2'b00;
			s_out = 0;
			op_alu = 3'b000;
			// if ( z == 1b'1 ) begin
			if ( z == 1 ) begin
				s_inc = 0;
			end else begin
				s_inc = 1;
			end
		end
	6'b100011: // salto si no z
		begin
		       	we3 = 0;
			we4 = 0;
		       	we5 = 0;
			we6 = 0;
			we7 = 0;
			we8 = 0;
			wez = 0;
			push = 0; 
			pop = 0;
			s_pila = 0;
			s_port = 2'b00;
			s_inm = 2'b00;
			s_out = 0;
			op_alu = 3'b000;
			if ( z == 0 ) begin
				s_inc = 0;
			end else begin
				s_inc = 1;
			end
		end
	6'b100100: // push pila
		begin
			push = 1; 
			pop = 0;
			we3 = 0; 
			we4 = 0;
			we5 = 0;
			we6 = 0;
			we7 = 0;
			we8 = 0;
			wez = 0;
			s_pila = 0;
			s_port = 2'b00;
			s_out = 0;
			s_inc = 1;
			s_inm = 2'b00;
			op_alu = 3'b000;
		end
	6'b100101: // pop pila
		begin
			pop = 1; 
			push = 0;
			we3 = 0; 
			we4 = 0;
			we5 = 0;
			we6 = 0;
			we7 = 0;
			we8 = 0;
			wez = 0;
			s_pila = 1;
			s_port = 2'b00;
			s_out = 0;
			s_inc = 1;
			s_inm = 2'b00;
			op_alu = 3'b000;
		end
	6'b100110: // input to reg  100110 empty[4] s_port[2] dir reg[4]
		begin
			push = 0; 
			pop = 0;
			we3 = 1; 
			we4 = 0;
			we5 = 0;
			we6 = 0;
			we7 = 0;
			we8 = 0;
			wez = 0; 
			s_pila = 0; 
			s_port = opcode[5:4]; 
			s_out = 0;
			s_inc = 1;
			s_inm = 2'b11;
			op_alu = 3'b000;

		end
	6'b100111: // reg to output  100111 reg[11:8] empty[7:2] port_out[1:0] 
		begin
			push = 0; 
			pop = 0;
		       	we3 = 0;	
			we4 = 0;
			we5 = -opcode[0] & -opcode[1];
			we6 = -opcode[0] & opcode[1];
			we7 = opcode[0] & -opcode[1];
			we8 = opcode[0] & opcode[1];
			wez = 0;
			s_pila = 0;
			s_port = 2'b00;
			s_out = 0;
			s_inc = 1;
			s_inm = 2'b00;
			op_alu = 3'b000;
		end
	6'b101000: // mem prog to out (salida inmediato) 101000 inmediato[9:2] port_out[1:0]
		begin
			push = 0; 
			pop = 0;
			we4 = 0;
			we3 = 0;
			we5 = -opcode[0] & -opcode[1];
			we6 = -opcode[0] & -opcode[1];
			we7 = -opcode[0] & -opcode[1];
			we8 = -opcode[0] & -opcode[1];
			wez = 0;
			s_pila = 0;
			s_port = 2'b00;
			s_out = 1;
			s_inc = 1;
			s_inm = 2'b00;
			op_alu = 3'b000;

		end
	6'b111000: // load word (mem datos ----> banco registros)  1110 mem dato[8] banc[4]
		begin
		        push = 0; 
			pop = 0;	
			we3 = 1; 
			we4 = 0;
		       	we5 = 0;
			we6 = 0;
			we7 = 0;
			we8 = 0;	
			wez = 0;
			s_pila = 0;
			s_port = 2'b00;
			s_out = 0;
			s_inc = 1; 
			s_inm = 2'b10;
			op_alu = 3'b000;
		end
	6'b1111zz: // save word (banco registros ----> mem datos)  1111 banc[4] mem dato[8]
		begin
			s_inc = 1; 
			push = 0; 
			pop = 0;
			we3 = 0; 
			we4 = 1;
		       	we5 = 0;
			we6 = 0;
			we7 = 0;
			we8 = 0;	
			wez = 0;
			s_pila = 0;
			s_port = 2'b00;
			s_out = 0;
			s_inc = 1;
			s_inm = 2'b00;
			op_alu = 3'b000;
		end

default:  ;
endcase

endmodule
