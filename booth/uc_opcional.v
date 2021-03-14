module uc_2 (input wire q_0, q_1, reset, clk, output wire cargaq, desplaza, cargaa, cargam, suma, fin, reseta );

wire q0, q1, q2, clk2, and_carga_1, and_carga_2, suma1, resta1;
assign S0 = -q0 & -q1 & -q2;
assign S1 = q0 & -q1 & -q2;
assign S2 = -q0 & q1 & -q2;
assign S3 = q0 & q1 & -q2;
assign S4 = -q0 & -q1 & q2;
assign S5 = q0 & -q1 & q2;
assign S6 = -q0 & q1 & q2;
assign S7 = q0 & q1 & q2;

assign reseta = S0;
assign cargaq = S0;
assign cargam = S0;
assign desplaza = S2 || S4 || S6;
assign fin = S7;
assign clk2 = clk & -S7;
assign and_carga_1 = S1 || S3 || S5;
assign suma1 = q_1 & -q_0;
assign resta1 = -q_1 & q_0;
assign and_carga_2 = suma1 || resta1;
assign cargaa = and_carga_1 & and_carga_2;
assign suma = -suma1 || resta1;

contador contador1(clk2,reset,q0,q1,q2);





endmodule
