module cd(input wire clk, reset, s_inc, we3, wez, s_pila, push, pop, we4, s_out, we5, ie1, ie2, ie3, ie4, enable_timer, input wire [1:0] s_port, s_data,input wire [1:0] s_inm, input wire [2:0] op_alu, output wire z, output wire [15:0] opcode, output wire [7:0] reg1_out, reg2_out, reg3_out, reg4_out, input wire [7:0] i1, i2, i3, i4);
//Camino de datos de instrucciones de un solo ciclo
wire [9:0] mux6_to_pc, pc_to_mem, sum_to_mux, mux_to_mux, pila_to_mux, mux3_to_mux6, mux7_to_mux6, reg5_to_mux7, reg6_to_mux7, reg7_to_mux7, reg8_to_mux7;
wire [7:0] rd1, rd2, alu_to_mux, wd3, memdat_to_mux, mux_to_reg, input_mux_to_mux;
wire [15:0] sal_mem_pro;
wire zalu, sal_dec_1, sal_dec_2, sal_dec_3, sal_dec_4, and1_to_reg, and2_to_reg, and3_to_reg, and4_to_reg, or_to_mux6, cod42_0_to_mux7, cod42_1_to_mux7, or_to_pila, and_to_ie4, ie4_timer;
wire [11:0] mux8_to_memdata;

//1
mux2 #10 mux_1(sal_mem_pro[9:0], sum_to_mux, s_inc, mux_to_mux);
//2
registro #10 pc(clk, reset, mux6_to_pc, pc_to_mem);
//3
memprog mem_prog(clk, pc_to_mem, sal_mem_pro);
//4
regfile banco(clk, we3, sal_mem_pro[11:8], sal_mem_pro[7:4], sal_mem_pro[3:0], wd3, rd1, rd2);
//5
mux41 #8 mux_2(alu_to_mux, sal_mem_pro[11:4] ,memdat_to_mux, input_mux_to_mux, s_inm, wd3);
//6
alu alu1(rd1, rd2, op_alu, alu_to_mux, zalu);
//7
ffd ffz(clk, reset, zalu, wez, z);
//8 
sum sum1(pc_to_mem, 10'b1 , sum_to_mux);
//9 
mux2 #10 mux_3(mux_to_mux, pila_to_mux, s_pila, mux3_to_mux6);
//10
//pila pila1(clk, reset, or_to_pila, pop, pc_to_mem, pila_to_mux);
pila pila1(clk, reset, or_to_pila, pop, mux3_to_mux6, pila_to_mux);
//11
regprog regpro1(clk, we4, mux8_to_memdata, rd1, memdat_to_mux);
//12
mux41 #8 mux_4(i1, i2, i3, i4, s_port, input_mux_to_mux);
//13
mux2 #8 mux_5(rd2, sal_mem_pro[9:2], s_out, mux_to_reg);
//14
registro_mod #8 reg1(and1_to_reg, reset, mux_to_reg, reg1_out); 
//15
registro_mod #8 reg2(and2_to_reg, reset, mux_to_reg, reg2_out);
//16
registro_mod #8 reg3(and3_to_reg, reset, mux_to_reg, reg3_out); 
//17
registro_mod #8 reg4(and4_to_reg, reset, mux_to_reg, reg4_out); 
//18
deco24 dec_1(sal_mem_pro[0], sal_mem_pro[1],sal_dec_1, sal_dec_2, sal_del_3, sal_dec_4);
//19
assign and1_to_reg = we5 & sal_dec_1;
//20
assign and2_to_reg = we5 & sal_dec_2;
//21
assign and3_to_reg = we5 & sal_dec_3;
//22
assign and4_to_reg = we5 & sal_dec_4;
//23
mux2 #10 mux_6(mux3_to_mux6, mux7_to_mux6, or_to_mux6, mux6_to_pc);
//24
mux41 #10 mux_7(reg5_to_mux7, reg6_to_mux7, reg7_to_mux7, reg8_to_mux7, {cod42_1_to_mux7, cod42_0_to_mux7}, mux7_to_mux6);
//25
reg_int_1 reg_int_1(reg5_to_mux7);
//26
reg_int_2 reg_int_2(reg6_to_mux7);
//27
reg_int_3 reg_int_3(reg7_to_mux7);
//28
reg_int_4 reg_int_4(reg8_to_mux7);
//29
codificador42 codificador(ie1, ie2, ie3, ie4_timer, cod42_0_to_mux7, cod42_1_to_mux7 );
//30
assign or_to_mux6 = ie1 | ie2 | ie3 | ie4_timer;
//31 
assign or_to_pila = push | or_to_mux6;
//32
assign ie4_timer = ie4 | clk_out;
//33
Clock_divider divisor(clk,reset, enable_timer, sal_mem_pro[8:6], sal_mem_pro[5:0], clk_out);
//Clock_divider divisor(clk,reset, 3'b001, 6'b000001, clk_out);
//34
mux41 #12 mux_8 (sal_mem_pro[11:0], {rd2, 4'b0000}, {4'b0000 ,rd2}, , s_data, mux8_to_memdata);
assign opcode = sal_mem_pro;


endmodule

