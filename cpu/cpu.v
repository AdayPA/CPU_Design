module cpu(input wire clk, reset);
//Procesador sin memoria de datos de un solo ciclo

wire s_inc, s_inm, we3, wez, z;
wire [5:0] opcode;
wire [3:0] op_alu;

cd cd_1(clk, reset, s_inc, s_inm, we3, wez, op_alu, z, opcode);
uc uc_1(opcode, z, s_inc, s_inm, we3, wez, op_alu);




endmodule
