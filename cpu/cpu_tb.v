`timescale 1 ns / 10 ps

module cpu_tb;


reg clk, reset;
wire [7:0] o1, o2, o3, o4, i1, i2, i3, i4;


// generación de reloj clk
always //siempre activo, no hay condición de activación
begin
  clk = 1'b1;
  #30;
  clk = 1'b0;
  #30;
end

// instanciación del procesador
cpu micpu(clk, reset, o1, o2, o3, o4, i1, i2, i3, i4);

initial
begin
  $dumpfile("cpu_tb.vcd");
  //$dumpvars(0,cpu_tb.micpu.cd_1.banco.regb[); TODO
  $dumpvars;
  reset = 1;  //a partir del flanco de subida del reset empieza el funcionamiento normal
  #10;
  reset = 0;  //bajamos el reset 
end

initial
begin

  #(9*60);  //Esperamos 9 ciclos o 9 instrucciones
  $finish;
end

endmodule
