module uc(input wire [15:0] opcode, input wire z, output reg s_inc, we3, wez, s_pila, push, pop, we4, s_out, we5, timer_enable, output reg [1:0] s_port, s_data, output reg [1:0] s_inm,  output reg [2:0] op_alu, input wire ie1, ie2, ie3, ie4);

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
			wez = 1;
		        s_port = 2'b00;
			s_out = 0;
			s_data = 2'b00;
		end
	6'b1000zz:   // carga inmediata
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
			s_out = 0;
			s_port = 2'b00;
			wez = 0;
			s_data = 2'b00;
		end
	6'b110000:  // salto
		begin
			s_inc = 0; 
			s_pila = 0;
			push = 0; 
			pop = 0;
			we3 = 0;
			we4 = 0;
			we5 = 0;
			wez = 0;
			s_out = 0;
			s_port = 2'b00;
			op_alu = 3'b000;
			s_inm = 2'b00;
			s_data = 2'b00;
		end
	6'b110001:  // salto si z
		begin
			s_pila = 0; 
			we3 = 0;
		        we4 = 0;
			we5 = 0;
			wez = 0;
			push = 0; 
			pop = 0;
			s_port = 2'b00;
			s_inm = 2'b00;
			s_out = 0;
			op_alu = 3'b000;
			s_data = 2'b00;
			// if ( z == 1b'1 ) begin
			if ( z == 1 ) begin
				s_inc = 0;
			end else begin
				s_inc = 1;
			end
		end
	6'b110010: // salto si no z
		begin
		       	we3 = 0;
			we4 = 0;
		       	we5 = 0;
			wez = 0;
			push = 0; 
			pop = 0;
			s_pila = 0;
			s_port = 2'b00;
			s_inm = 2'b00;
			s_out = 0;
			op_alu = 3'b000;
			s_data = 2'b00;
			if ( z == 0 ) begin
				s_inc = 0;
			end else begin
				s_inc = 1;
			end
		end
	6'b110011: // push pila
		begin
			push = 1; 
			pop = 0;
			we3 = 0; 
			we4 = 0;
			we5 = 0;
			wez = 0;
			s_pila = 0;
			s_port = 2'b00;
			s_out = 0;
			s_inc = 1;
			s_inm = 2'b00;
			op_alu = 3'b000;
			s_data = 2'b00;
		end
	6'b110100: // pop pila
		begin
			pop = 1; 
			push = 0;
			we3 = 0; 
			we4 = 0;
			we5 = 0;
			wez = 0;
			s_pila = 1;
			s_port = 2'b00;
			s_out = 0;
			s_inc = 1;
			s_inm = 2'b00;
			op_alu = 3'b000;
			s_data = 2'b00;
		end
	6'b110101: // input to reg  100110 empty[4] s_port[2] dir reg[4]
		begin
			push = 0; 
			pop = 0;
			we3 = 1; 
			we4 = 0;
			we5 = 0;
			wez = 0; 
			s_pila = 0; 
			s_port = opcode[5:4]; 
			s_out = 0;
			s_inc = 1;
			s_inm = 2'b11;
			op_alu = 3'b000;
			s_data = 2'b00;
		end
	6'b110110: // reg to output  100111 empty[9:8] reg[7:4] empty[3:2]  port_out[1:0] 
		begin
			push = 0; 
			pop = 0;
		       	we3 = 0;	
			we4 = 0;
			we5 = 1;
			wez = 0;
			s_pila = 0;
			s_port = 2'b00;
			s_out = 0;
			s_inc = 1;
			s_inm = 2'b00;
			op_alu = 3'b000;
			s_data = 2'b00;
		end
	6'b110111: // mem prog to out (salida inmediato) 101000 inmediato[9:2] port_out[1:0]
		begin
			push = 0; 
			pop = 0;
			we3 = 0;
			we4 = 0;
			we5 = 1;
			wez = 0;
			s_pila = 0;
			s_port = 2'b00;
			s_out = 1;
			s_inc = 1;
			s_inm = 2'b00;
			op_alu = 3'b000;
			s_data = 2'b00;
		end
	6'b101001: // timer  opcode[6] + enable[1] + base[3] + umbral[6]
		begin
			push = 0;
			pop = 0;
			we3 = 0;
			we4 = 0;
			we5 = 0;
			wez = 0;
			s_pila = 0;
			s_port = 2'b00;
			s_out = 1;
			s_inc = 1;
			s_inm = 2'b00;
			op_alu = 3'b000;
			timer_enable = opcode[9];
			s_data = 2'b00;
		end
	6'b1110zz: // load word [DIR](mem datos ----> banco registros)  1110 mem dato[8] banc[4]
		begin
		        push = 0; 
			pop = 0;	
			we3 = 1; 
			we4 = 0;
		       	we5 = 0;
			wez = 0;
			s_pila = 0;
			s_port = 2'b00;
			s_out = 0;
			s_inc = 1; 
			s_inm = 2'b10;
			op_alu = 3'b000;
			s_data = 2'b00;
		end
        6'b101010: // load word [REG](mem datos ----> banco registros)  1110 mem dato[8] banc[4]
                begin
                        push = 0;
                        pop = 0;
                        we3 = 1;
                        we4 = 0;
                        we5 = 0;
                        wez = 0;
                        s_pila = 0;
                        s_port = 2'b00;
                        s_out = 0;
                        s_inc = 1;
                        s_inm = 2'b10;
                        op_alu = 3'b000;
                        s_data = 2'b01;
                end
	6'b1111zz: // store word [DIR] (banco registros ----> mem datos[inm])  1111 banc[4] mem dato[8]
		begin
			s_inc = 1; 
			push = 0; 
			pop = 0;
			we3 = 0; 
			we4 = 1;
		       	we5 = 0;
			wez = 0;
			s_pila = 0;
			s_port = 2'b00;
			s_out = 0;
			s_inc = 1;
			s_inm = 2'b00;
			op_alu = 3'b000;
			s_data = 2'b00;
		end
        6'b101000: // store word [REG] (banco registros ----> mem datos[reg]) 
                begin
                        s_inc = 1;
                        push = 0;
                        pop = 0;
                        we3 = 0;
                        we4 = 1;
                        we5 = 0;
                        wez = 0;
                        s_pila = 0;
                        s_port = 2'b00;
                        s_out = 0;
                        s_inc = 1;
                        s_inm = 2'b00;
                        op_alu = 3'b000;
			s_data = 2'b10;
                end
default:  ;
endcase

endmodule
