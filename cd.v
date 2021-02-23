// M = multiplicando (registro M)
module cd(input wire [2:0] M, input wire [2:0] Q, input wire carga_M,input wire carga_Q, input wire carga_A, input wire desplaza_A, input wire desplaza_Q, input wire clk, input wire reset, input wire reset_A, input wire carga_q0, input wire suma, output reg q_1);
 wire [3:0] salida_M;
 wire [3:0] salida_A;
 wire [2:0] salida_Q;
 wire [3:0] salida_Sum;
 assign carga_qminus1 = carga_Q | desplaza_Q; 
 registro4 A(salida_Sum,salida_A[3], carga_A, desplaza_A, clk, reset_A, salida_A);
 registro4 M({M[2],M},0,carga_M,0, clk, reset, salida_M);
 registro3 Q(Q,salida_A[0],carga_Q,desplaza_Q,clk,reset,salida_Q);
 ffdc Q0(clk,reset,carga_qminus1,salida_Q[0], q_1);
 sum_resta4 sum(salida_Sum,,salida_A, salida_M, suma);

endmodule
