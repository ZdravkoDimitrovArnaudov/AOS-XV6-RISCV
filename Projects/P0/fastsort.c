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

// Librerias
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Constantes
#define DELIM " "

// Variables globales
int position = 1;

// Prototipos
int compareHandler(const void* a, const void* b);

// Funciones
int main(int argc, char *argv[]){
	int i;
	char *file_path;

	/* Lectura de los argumentos del programa. */
	if(argc == 2){
		file_path = argv[1];
	} else if(argc == 3){
		file_path = argv[2];
		position = atoi(strtok(argv[1],"-"));
	} else {
		fprintf(stderr, "usage: /fastsort [-3] file \n");
		exit(1);
	}

	/* Se accede al fichero en modo lectura. */
	FILE *fd = fopen(file_path, "r");
	if(fd == NULL){
		fprintf(stderr, "Error en la lectura del fichero");
		exit(1);
	}

	/* Se lee el número de lineas que contiene el archivo. */
	int number_lines = 0;
	char *line = NULL;
	size_t len = 0;
	while(getline(&line, &len, fd) != -1) {
		number_lines++;
 	}

	/* Se lee cada linea y se guarda en un array. */
	char *lines[number_lines];	
	rewind(fd);	
	while(getline(&line, &len, fd) != -1) {
		lines[i] = malloc(strlen(line) * sizeof(char *));
		strcpy(lines[i], line);
		i++;
 	}

	/* Se cierra el descriptor del fichero. */
	fclose(fd);

	/* Se ordena la array conforme al manejador de comparación. */
	qsort(lines, number_lines, sizeof(char *), compareHandler);

	/* Se imprime por pantalla el resultado. */
	for(i = 0; i < number_lines; i++)
		printf("%s", lines[i]);

	/* Se libera el heap reservado. */
	for(i = 0; i < number_lines; i++)
		free(lines[i]);
	free(line);

	return 0;
}

int compareHandler(const void* a, const void* b){
	int i;

	/* Se reserva en el heap array de caracteres. */
	char* tmp_a = malloc(strlen(*(char * const *) a) * sizeof(*(char * const *) a));
	char* tmp_b = malloc(strlen(*(char * const *) b) * sizeof(*(char * const *) b));

	/* Se copian las frases en las arrays temporales, */
	/* para no perder el contenido por el strtok() */
	strcpy(tmp_a, * (char * const *) a);
	strcpy(tmp_b, * (char * const *) b);

	/* Se obtienen las palabras a comparar. */
	char* word1 = strtok(tmp_a, DELIM);
	for(i = 0; i < position-1; i++){
		word1 = strtok(NULL, DELIM);
	}

	char* word2 = strtok(tmp_b, DELIM);
	for(i = 0; i < position-1; i++){
		word2 = strtok(NULL, DELIM);
	}

	/* Se comparan solo las palabras y no la frase entera. */
	int ret = strcmp(word1, word2);

	/* Se libera la reserva en el heap. */
	free(tmp_a);
	free(tmp_b);

	return ret;
}

