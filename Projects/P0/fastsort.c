#include <stdio.h> //fopen(), fgets(), fclose(), qsort()
#include <stdlib.h> //atoi(), 
#include <sys/stat.h> //stat() y fstat()
#include <string.h> //strcmp(), strtok()

#define DEBUG
#define MAX_ROWS 100
#define SIZE_R0W 128



int main (int argc, char *argv[]){

    //gestión de errores
    if (argc < 2 || argc > 3) {
        fprintf (stderr, "Error: Bad comman line parameters");
        return 1;
    }

    char *filename;
    int key = 0; //key para saber qué palabra de cada fila escoger
    int row = 0; //para contar las filas al leer del fichero
    char **text; //almacena el texto completo


    //recogemos argumentos de entrada
    if (argc == 2){ 
        filename = argv[1];

    } else {
        key = atoi(argv[1]);
        filename = argv[2];

    }

    //Abrimos el fichero 
    FILE *fptr = fopen (filename, "r");
    if (fptr == NULL){ 
        fprintf (stderr, "Error: Cannot open file %s\n", filename);
        return 1;

    }

    //estructura de datos para leer el texto
    text = malloc(MAX_ROWS * sizeof(char*));
    for (int i = 0; i < MAX_ROWS; i++){
        text[i] = malloc(SIZE_R0W * sizeof(char));
    }

    //leemos el texto completo
    while (fgets(text[row], SIZE_R0W, fptr)){
        #ifdef DEBUG
        printf ("%d: %s", row,  text[row]);
        #endif
        row++;
    
    }   

}