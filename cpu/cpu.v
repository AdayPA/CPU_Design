module cpu(input wire clk, reset, ie1, ie2, ie3, ie4, output wire [7:0] reg1_out, reg2_out, reg3_out, reg4_out, input wire [7:0] i1, i2, i3, i4);
//Procesador sin memoria de datos de un solo ciclo

wire s_inc, we3, wez, z, s_pila, push, pop, we4, s_out, we5, enable_timer;
wire [15:0] opcode;
wire [2:0] op_alu;
wire [1:0] s_inm; 
wire [1:0] s_port;

cd cd_1(clk, reset, s_inc, we3, wez, s_pila, push, pop, we4, s_out, we5, ie1, ie2, ie3, ie4, enable_timer, s_port, s_inm,  op_alu, z, opcode, reg1_out, reg2_out, reg3_out, reg4_out, i1, i2, i3, i4);
uc uc_1(opcode, z, s_inc, we3, wez, s_pila, push, pop, we4, s_out, we5, enable_timer, s_port,  s_inm, op_alu, ie1, ie2, ie3, ie4);




endmodule

