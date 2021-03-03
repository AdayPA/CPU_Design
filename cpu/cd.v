module cd(input wire clk, reset, s_inc, s_inm, we3, wez, input wire [2:0] op_alu, output wire z, output wire [5:0] opcode);
//Camino de datos de instrucciones de un solo ciclo
wire [9:0] mux_to_pc, pc_to_mem, sum_to_mux;
wire [7:0] rd1, rd2, alu_to_mux, wd3;
wire [15:0] sal_mem_pro;
wire zalu;

//1
mux2 #10 mux_1(sal_mem_pro[9:0], sum_to_mux, s_inc, mux_to_pc);
//2
registro #10 pc(clk, reset, mux_to_pc, pc_to_mem);
//3
memprog mem_prog(clk, pc_to_mem, sal_mem_pro);
//4
regfile banco(clk, we3, sal_mem_pro[11:8], sal_mem_pro[7:4], sal_mem_pro[3:0], wd3, rd1, rd2);
//5
mux2 #8 mux_2(alu_to_mux, sal_mem_pro[11:4], s_inm, wd3);
//6
alu alu1(rd1, rd2, op_alu, alu_to_mux, zalu);
//7
ffd ffz(clk, reset, zalu, wez, z);
//8 
sum sum1(pc_to_mem, 0000000001 , sum_to_mux);

assign opcode = sal_mem_pro[15:10];


endmodule

