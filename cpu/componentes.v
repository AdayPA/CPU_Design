//Componentes varios

//Banco de registros de dos salidas y una entrada
module regfile(input  wire        clk, 
               input  wire        we3,           //señal de habilitación de escritura
               input  wire [3:0]  ra1, ra2, wa3, //direcciones de regs leidos y reg a escribir
               input  wire [7:0]  wd3, 			 //dato a escribir
               output wire [7:0]  rd1, rd2);     //datos leidos

  reg [7:0] regb[0:15]; //memoria de 16 registros de 8 bits de ancho

  initial
  begin
    $readmemb("regfile.dat",regb); // inicializa los registros a valores conocidos
  end  
  
  // El registro 0 siempre es cero
  // se leen dos reg combinacionalmente
  // y la escritura del tercero ocurre en flanco de subida del reloj
  
  always @(posedge clk)
    if (we3) regb[wa3] <= wd3;	
  
  assign rd1 = (ra1 != 0) ? regb[ra1] : 0;
  assign rd2 = (ra2 != 0) ? regb[ra2] : 0;

endmodule

//modulo sumador  
module sum(input  wire [9:0] a, b,
             output wire [9:0] y);

  assign y = a + b;

endmodule

//modulo registro para modelar el PC, cambia en cada flanco de subida de reloj o de reset
module registro #(parameter WIDTH = 8)
              (input wire             clk, reset,
               input wire [WIDTH-1:0] d, 
               output reg [WIDTH-1:0] q);

  always @(posedge clk, posedge reset)
    if (reset) q <= 0;
    else       q <= d;

endmodule

//modulo multiplexor, si s=1 sale d1, s=0 sale d0
module mux2 #(parameter WIDTH = 8)
             (input  wire [WIDTH-1:0] d0, d1, 
              input  wire             s, 
              output wire [WIDTH-1:0] y);

  assign y = s ? d1 : d0; 

endmodule

//Biestable para el flag de cero
//Biestable tipo D síncrono con reset asíncrono por flanco y entrada de habilitación de carga
module ffd(input wire clk, reset, d, carga, output reg q);

  always @(posedge clk, posedge reset)
    if (reset)
	    q <= 1'b0;
	  else
	    if (carga)
	      q <= d;

endmodule 

module  pila(input wire clk, reset, push, pop, input wire [9:0] inpush, output reg [9:0] outpop );
  reg [2:0] sp;
  //integer sp = 0;
  reg [9:0] mem[0:7];
  initial 
    begin
      sp = 0;
    end

    always @(push, pop, posedge reset) begin
	if ( reset )
		sp = 3'b000;
	if ( push ) 
		begin
	        	mem[sp] = inpush;	
			sp = sp + 3'b001;
			outpop = 3'b000;
		end
	  if ( pop ) 
		begin
			sp = sp - 3'b001;
			outpop = mem[sp];
		end
	end

endmodule

//memoria de datos

module regprog (input wire clk, input wire we4, input wire [11:0] wra, input wire [7:0] wd, output wire [7:0] rd);
	
	// we4 : write enable
	// wra : write/read addres
	// wd : write data
	// rd : read data
	reg [7:0] regb[0:255];  //memoria de 255 de 8 bits de ancho

	initial
	begin
		$readmemb("regdata.dat", regb);
	end
	// sw -> 
	always @(posedge clk)
		if (we4) regb[wra[7:0]] <= wd;

	assign rd = regb[wra[11:4]];

endmodule

module mux41 #(parameter WIDTH = 8) (input wire [WIDTH-1:0] a, b, c, d, input wire [1:0] s, output reg [WIDTH-1:0] out);
	always@(a or b or c or d or s)
	begin
		case(s)
			2'b00: out <= a;
			2'b01: out <= b;
			2'b10: out <= c;
			2'b11: out <= d;
		endcase
	end
endmodule

module deco24 (input wire s0, s1, output wire a, b, c, d);
	assign a = (~s0 & ~s1);
	assign b = (s0 & ~s1);
	assign c = (~s0 & s1);
	assign d = (s0 & s1);
endmodule

module registro_mod #(parameter WIDTH = 8)
              (input wire             clk, reset,
               input wire [WIDTH-1:0] d,
               output reg [WIDTH-1:0] q);

  always @(negedge clk, posedge reset)
    if (reset) q <= 0;
    else       q <= d;

endmodule

module reg_int_1(output wire[9:0] s);
	reg [9:0] reg_dat = 10'b1111111011;
	/*
	initial
	begin
		$readmemb("reg_interrupt_1.dat",reg_dat);
	end */
	assign s = reg_dat;
endmodule

module reg_int_2(output wire [9:0] s);
	reg [9:0] reg_dat = 10'b1111111110;
	/*
	initial
	begin
		$readmemb("reg_interrupt_2.dat", reg_dat);
	end
	*/
	assign s = reg_dat;
endmodule

module reg_int_3(output wire [9:0] s);
        reg [9:0] reg_dat = 10'b1111111101;
	/*
        initial
        begin   
                $readmemb("reg_interrupt_3.dat", reg_dat);
        end */     
        assign s = reg_dat;
endmodule

module reg_int_4(output wire [9:0] s);
        reg [9:0] reg_dat = 10'b1111111100;
        /*
	initial
        begin   
                $readmemb("reg_interrupt_4.dat", reg_dat);
        end */     
        assign s = reg_dat;
endmodule

module codificador42(input wire ie1, ie2, ie3, ie4, output wire s0, s1);
	assign s0 = (ie2 | ie4) & ~ie1;
	assign s1 = (ie3 | ie4) & ~ie1;
endmodule

//module timer(input wire reinicio, clk, input wire [2:0] base, input wire [3:0] umbral, output wire s, state);
// clk de 50 Mhz (usar flip flops para reducir los Hz)
module Clock_divider(input clock_in, reset,  enable, input wire [2:0] base, input wire [5:0] umbral, output reg clock_out);

	// añadir enable
	//reg [8:0] base_th = 9'b000000001;
	reg [8:0] base_th;
	always @(enable) 
		if (enable)  base_th <= {base,umbral};
	reg[27:0] counter = 28'd0;
	//reg[27:0] divisor = 28'b0000000000000000000000000000;
	reg[27:0] divisor;
	always @(base_th[8:6])
	begin
		case (base_th[8:6])
			3'b000: //milis
				begin
					divisor = 20;
				end
			3'b001: // centesimas de segundos
                       		begin
					divisor = 200;
                	        end
			3'b010: // decimas de segundos
        	                begin
					divisor = 2000;
        	                end
			3'b011: //segundos
                	        begin
					divisor = 20000;
                	        end
			3'b100: // minutos  20000 * 60 = 1200000
                	        begin
					divisor = 1200000;
        	                end
		default:
			begin
	
			end
		endcase
	end
// The frequency of the output clk_DIVISOR = 28'd4;
// For example: Fclk_in = 50Mhz, if you want to get 1Hz signal to blink LEDs
// You will modify the DIVISOR parameter value to 28'd50.000.000
// Then the frequency of the output clk_out = 50Mhz/50.000.000 = 1Hz
/*
always @(posedge clock_in)
begin
 counter <= counter + 28'd1;
 if(counter>=(DIVISOR-1))
  counter <= 28'd0;

 clock_out <= (counter<DIVISOR/2)?1'b1:1'b0;

end*/
	reg [5:0] temp = 6'b000000;
	always @(posedge clock_in)
	begin
/*
if(counter %divisor == 0)

	clock_out = 1'b1;
else
	clock_out = 1'b0;

*/
		if (counter %divisor == 0) 
			begin
				temp = temp + 6'b000001;
				clock_out = 1'b1 & enable;
			end
		else
			begin
				clock_out = 1'b0;
				temp = temp;
			end
		if (temp == base_th[5:0]) 
			begin
				temp = 6'b000000;
			end
		else
			begin
				clock_out = 1'b0;
			end

		counter <= counter + 28'd1;
	end
endmodule


//endmodule
