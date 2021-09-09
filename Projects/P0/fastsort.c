#include <stdio.h> //fopen(), fgets(), fclose(), qsort()
#include <stdlib.h> //atoi(), 
#include <sys/stat.h> //stat() y fstat()
#include <string.h> //strcmp(), strtok()

#define DEBUG
#define MAX_LINES 100

int main (int argc, char *argv[]){

/*PSEUDOCÓDIGO INCREMENTAL
    1.Recoger los parámetros X
    2.Leer las líneas del fichero
    3.Mostrarlas por pantalla

PSEUDOCÓDIGO FASTSORT
    1.Recoger los parámetros
    2.Averiguar las dimensiones del fichero
    3.Leer el texto
    4.Separar adecuadamente
    5.Ordenar adecuadamente
*/



if (argc < 2 || argc > 3) {
    fprintf (stderr, "Error: Bad comman line parameters");
    return 1;
}

char *filename;
int key = 0;
struct stat stats;
//char **filas;

//RECOGEMOS ARGUMENTOS DE ENTRADA

if (argc == 2){ //solo se proporciona el fichero
    filename = argv[1];

} else {
    key = atoi(argv[1]);
    filename = argv[2];

}

FILE *fp = fopen (filename, "r");
if (fp == NULL){ //el fichero no se ha leido correctamente.
    fprintf (stderr, "Error: Cannot open file %s\n", filename);
    return 1;

}


//IDENTIFICAR DIMENSIONES DEL TEXTO
//filas = malloc(MAX_LINES * sizeof(char*));
stat (filename, &stats);
int size = stats.st_size;
printf ("El tamaño del texto es: %d\n", size);
printf ("La llave para ordenar es: %d\n", key);



 return 0;
}
