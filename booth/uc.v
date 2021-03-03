module unidad_control (input wire [2:0] q, input wire qsub1, reset, clk, output wire CargaQ, DesplazaAQ, CargaA, CargaM, Resta, Fin);
// Variables reg que almacenan el estado actual y el siguiente
reg [2:0] estado, estado_siguiente;
// Codificación de estados
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
parameter S5 = 3'b101;
parameter S6 = 3'b110;
parameter S7 = 3'b111;
// Cambios en flacos de subida de clk o reset
always @(posedge clk, posedge reset)
if (reset)
estado <= S0;
else
estado <= estado_siguiente;
// Funcion de transicion
always @(*)
case (estado)
S0: estado_siguiente = S1;
S1: estado_siguiente = S2;
S2: estado_siguiente = S3;
S3: estado_siguiente = S4;
S4: estado_siguiente = S5;
S5: estado_siguiente = S6;
S6: estado_siguiente = S7;
S7: estado_siguiente = S7;
default: estado_siguiente = S0;
endcase
// Funcion de salida
// Utilizar un solo Reset en S0 para todos los registros

assign CargaQ = (estado == S0) ? 1:0;
assign CargaM = (estado == S0) ? 1:0;
assign Reset_A = (estado == S0) ? 1:0;
assign DesplazaAQ = ((estado == S2) || (estado == S4) || (estado == S6)) ? 1:0;

assign CargaA = ( ((estado == S1) || (estado == S3) || (estado == S5)) && (((q[0] == 0) && (qsub1 == 1)) || ((q[0] == 1) && (qsub1 == 0)))) ? 1:0;

assign Resta = ((q[0] == 1) && (qsub1 == 0)) ? 1:0;

assign Fin = (estado == S7) ? 1:0;
endmodule

