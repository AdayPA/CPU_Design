module multiplicador(input wire [2:0] Q1, input wire [2:0] M1, input wire clk, input wire reset, output wire [5:0] resultado, output fin);

wire carga_M;
wire carga_Q;
wire carga_A;
wire desplazaAQ;
wire suma;
wire q_1;
wire [2:0] salidaq;
wire [3:0] salidaA;
unidad_control uc1(salidaq,q_1,reset,clk,carga_Q,desplazaAQ,carga_A,carga_M,suma,fin);
wire reset_a;
//uc_2 uc1(salidaq[0],q_1,reset,clk,carga_Q,desplazaAQ,carga_A,carga_M,suma,fin,reset_a);
cd cd1(M1,Q1,salidaq,salidaA,carga_M,carga_Q,carga_A,desplazaAQ,desplazaAQ,clk,reset,reset,carga_Q,suma,q_1);
//cd cd1(M1,Q1,salidaq,salidaA,carga_M,carga_Q,carga_A,desplazaAQ,desplazaAQ,clk,reset,reset_a,carga_Q,suma,q_1);

assign resultado = {salidaA[2],salidaA[1],salidaA[0],salidaq[2],salidaq[1],salidaq[0]};

endmodule

