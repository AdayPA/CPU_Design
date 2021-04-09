#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

int main(void) {
	int memoria_de_datos[1024];	
	int registros[16];
	srand(time(0));
	int indice = 0;						// R1 posicion para guardar el dato en la memoria de datos 

	while (indice <= 1024){				 	// salto si z, sera la linea numero dos
		memoria_de_datos[indice] = rand();		// input a banco de registros en R2
								// pasar del registro a la memoria de datos (el r2)
		
		
		sleep(1);					// espero la interrupcion
		indice++;					// r1 = r1 + 1;
//		if (indice == 1023) indice = 0;
	
		//printf("%d\n", memoria_de_datos[0]);
	}
/*
	for (int i = 0; i < 1024; i++){
		printf("%d\n", memoria_de_datos[i]);
	}
*/

	return 0;
};

0000_0000_0000_0000 // habilito el timer
0000_0000_0000_0000 // no hago nada
0000_0000_0000_0000 // salto a la linea anterior
0000_0000_0000_0000
0000_0000_0000_0000
0000_0000_0000_0000
0000_0000_0000_0000



0000_0000_0000_0000 // salto si z a etiqueta jump
asd:
0000_0000_0000_0000 // input a reg r1 
0000_0000_0000_0000 // r1 a memoria de datos de la posicion de r2
0000_0000_0000_0000 // r2 = r2 + 1
0000_0000_0000_0000 // ponemos en salida 1 el valor de r1
0000_0000_0000_0000 // pop


jump:
0000_0000_0000_0000 // r2 = 0
0000_0000_0000_0000 // salto a asd
0000_0000_0000_0000
0000_0000_0000_0000
0000_0000_0000_0000


//ajedrez
//
0000_0000_0000_0000 // timer
0000_0000_0000_0000 // no hago nada
0000_0000_0000_0000 // vuelvo atras
0000_0000_0000_0000


0000_0000_0000_0000 // timer jugardor 1
0000_0000_0000_0000 
0000_0000_0000_0000
0000_0000_0000_0000
0000_0000_0000_0000

0000_0000_0000_0000
0000_0000_0000_0000
0000_0000_0000_0000
0000_0000_0000_0000
0000_0000_0000_0000
