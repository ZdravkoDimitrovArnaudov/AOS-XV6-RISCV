/*
███▄ ▄███▓ ▄▄▄     ▄▄▄█████▓▓█████ ▓█████ ██▒   █▓
▓██▒▀█▀ ██▒▒████▄   ▓  ██▒ ▓▒▓█   ▀ ▓█   ▀▓██░   █▒
▓██    ▓██░▒██  ▀█▄ ▒ ▓██░ ▒░▒███   ▒███   ▓██  █▒░
▒██    ▒██ ░██▄▄▄▄██░ ▓██▓ ░ ▒▓█  ▄ ▒▓█  ▄  ▒██ █░░
▒██▒   ░██▒ ▓█   ▓██▒ ▒██▒ ░ ░▒████▒░▒████▒  ▒▀█░
░ ▒░   ░  ░ ▒▒   ▓▒█░ ▒ ░░   ░░ ▒░ ░░░ ▒░ ░  ░ ▐░
░  ░      ░  ▒   ▒▒ ░   ░     ░ ░  ░ ░ ░  ░  ░ ░░
░      ░     ░   ▒    ░         ░      ░       ░░
  ░         ░  ░           ░  ░   ░  ░     ░
                                          ░
Autor:    Vladimir Kirilov Mateev
Fecha:	  sept 2020
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#define DELIM " "

int posicion = 1;
int compareHandler(const void* a, const void* b);

int main(int argc, char *argv[]){

	char* lineas[]  = 	{
						"this line is first",
						"but this line is second",
						"finally there is this line",
						};
	size_t strings_len = sizeof(lineas) / sizeof(char *);

	int i;
	for(i = 0; i < strings_len; i++){
		printf("%s \n", lineas[i]);
	}

	printf("\n");

	qsort(lineas, strings_len, sizeof(char *), compareHandler);

	printf("\n");

	for(i = 0; i < strings_len; i++){
		printf("%s \n", lineas[i]);
	}

	return 0;
}

int compareHandler(const void* a, const void* b){
	
	int i;

	char* tmp_l1 = malloc(strlen((char *)a) * sizeof((char *)a));
	char* tmp_l2 = malloc(strlen((char *)b) * sizeof((char *)b));

	  
	/* Copia de las lineas para obtener la palabra
	 * con X posicion sin modificar el contenido
	 * original
	 */  
	
	strcpy(tmp_l1, * (char * const *) a);
	strcpy(tmp_l2, * (char * const *) b);

	char* Letra1 = strtok(tmp_l1, DELIM);
	for(i = 0; i < posicion-1; i++){
		Letra1 = strtok(NULL, DELIM);
	}

	char* Letra2 = strtok(tmp_l2, DELIM);
	for(i = 0; i < posicion-1; i++){
		Letra2 = strtok(NULL, DELIM);
	}

	return strcmp(Letra1, Letra2);
}



/* http://www.cplusplus.com/reference/cstdlib/qsort/ */
