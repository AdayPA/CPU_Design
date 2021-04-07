//`timescale 1 ns / 10 ps
`timescale 1 us / 10 ps


// unidad de cuenta de simulacion / escala 
// frecuencia = 16'8 mhz

module cpu_tb;


reg clk, reset, ie1, ie2, ie3, ie4;
wire [7:0] o1, o2, o3, o4, i1, i2, i3, i4;

// generación de reloj clk
always //siempre activo, no hay condición de activación
begin
  clk = 1'b1;
  //#30;
  #25; // 50mhz  24
  clk = 1'b0;
  //#30;
  #25;
end

// instanciación del procesador
cpu micpu(clk, reset, ie1, ie2, ie3, ie4, o1, o2, o3, o4, i1, i2, i3, i4);

initial
begin
  $dumpfile("cpu_tb.vcd");
  //$dumpvars(0,cpu_tb.micpu.cd_1.banco.regb[0]); 
  $dumpvars;
  reset = 1;  //a partir del flanco de subida del reset empieza el funcionamiento normal
  #10;
  reset = 0;  //bajamos el reset 
  ie1 = 0;
  ie2 = 0;
  ie3 = 0;
  ie4 = 0;
end
/*
initial
begin
	#(2*60);
	ie1 = 1;
	#(60);
	ie1 = 0;
end
*/
initial
begin

  //#(9*60);  //Esperamos 9 ciclos o 9 instrucciones
  //#(9*40);  //Esperamos 9 ciclos o 9 instrucciones
  #(50000*50);  //Esperamos 9 ciclos o 9 instrucciones
  $finish;
end

endmodule
