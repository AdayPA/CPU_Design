module cd(input wire clk, reset, s_inc, we3, wez, s_pila, push, pop, we4, input wire [1:0] s_inm, input wire [2:0] op_alu, output wire z, output wire [5:0] opcode);
//Camino de datos de instrucciones de un solo ciclo
wire [9:0] mux_to_pc, pc_to_mem, sum_to_mux, mux_to_mux, pila_to_mux;
wire [7:0] rd1, rd2, alu_to_mux, wd3, memdat_to_mux;
wire [15:0] sal_mem_pro;
wire zalu;

//1
mux2 #10 mux_1(sal_mem_pro[9:0], sum_to_mux, s_inc, mux_to_mux);
//2
registro #10 pc(clk, reset, mux_to_pc, pc_to_mem);
//3
memprog mem_prog(clk, pc_to_mem, sal_mem_pro);
//4
regfile banco(clk, we3, sal_mem_pro[11:8], sal_mem_pro[7:4], sal_mem_pro[3:0], wd3, rd1, rd2);
//5
mux41 #8 mux_2(alu_to_mux, sal_mem_pro[11:4] ,memdat_to_mux, , s_inm, wd3);
//6
alu alu1(rd1, rd2, op_alu, alu_to_mux, zalu);
//7
ffd ffz(clk, reset, zalu, wez, z);
//8 
sum sum1(pc_to_mem, 10'b1 , sum_to_mux);
//9 
mux2 #10 mux_3(mux_to_mux, pila_to_mux, s_pila, mux_to_pc);
//10
pila pila1(clk, reset, push, pop, pc_to_mem, pila_to_mux);
//11
regprog regpro1(clk,we4,sal_mem_pro[11:0],rd1,memdat_to_mux);

assign opcode = sal_mem_pro[15:10];


endmodule

