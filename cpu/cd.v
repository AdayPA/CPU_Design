module cd(input wire clk, reset, s_inc, we3, wez, s_pila, push, pop, we4, s_out, we5, we6, we7, we8,  input wire [1:0] s_port, input wire [1:0] s_inm, input wire [2:0] op_alu, output wire z, output wire [15:0] opcode, output wire [7:0] reg1_out, reg2_out, reg3_out, reg4_out, input wire [7:0] i1, i2, i3, i4);
//Camino de datos de instrucciones de un solo ciclo
wire [9:0] mux_to_pc, pc_to_mem, sum_to_mux, mux_to_mux, pila_to_mux;
wire [7:0] rd1, rd2, alu_to_mux, wd3, memdat_to_mux, mux_to_reg, input_mux_to_mux;
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
//12
mux41 #8 mux_4(i1,i2,i3,i4,s_port,input_mux_to_mux);
//13
mux2 #8 mux_5(rd1,sal_mem_pro[9:2],s_out,mux_to_reg);
//14
registro #8 reg1(we5,reset,mux_to_reg,reg1_out); 
//15
registro #8 reg2(we6,reset,mux_to_reg,reg2_out);
//16
registro #8 reg3(we7,reset,mux_to_reg,reg3_out); 
//17
registro #8 reg4(we8,reset,mux_to_reg,reg4_out); 


assign opcode = sal_mem_pro;


endmodule

