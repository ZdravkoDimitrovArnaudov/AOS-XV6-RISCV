/**
 * Programa fastsort.c
 * @autor Zdravko Dimitrov Arnuadov.
 * Para DEBUG, usar #define DEBUG.
 * @version 2.0
 * */


#include <stdio.h> //fopen(), fgets(), fclose(), qsort()
#include <stdlib.h> //atoi(), 
#include <sys/stat.h> //stat() y fstat()
#include <string.h> //strcmp(), strtok()
#include <ctype.h> //isdigit

//#define DEBUG
#define MAX_ROWS 100
#define SIZE_R0W 128


struct sorted_word{
    int row;
    char *word;

}typedef sorted_word_t;

/**
 * @brief Lo usamos porque no puede pasarse strcmp directamente a qsort.
 * Strcmp espera punteros a const char y Qsort espera punteros a void.
 * Because strcmp cant be passed directly into qsort. 
 * strcmp expects pointers to const char and qsort expects pointers to void.
 * */
int compare_string (void const *a, void const *b);

/**
 * @brief Dada la lista de palabras ordenadas, para cada una de ellas buscaremos
 * su posicón de linea asociada. 
 * @param sorted_word_t *col : puntero al array de estructuras
 * @param int size : tamaño del array de estructuras
 * @param char* word : la palabra de la que necesitamos su posición
 * @return int pos : la posición de la palabra
 * */
int position_search (sorted_word_t *col, int size, char* word);


int main (int argc, char *argv[]){

    char *filename;
    char *arg_key; //para poder recoger key y gestión de errores
    long key = 1; //key para saber qué palabra de cada fila escoger
    int row = 0; //para contar las filas al leer del fichero
    int counter; //para seleccionar la palabra correspondiente de cada fila (strtok)
    int pos = 0; //para imprimir correctamente las líneas ordenadas al final, según la posición de cada palabra
    char **text; //almacena el texto completo
    char **text_aux; //estructura auxiliar para conseguir seccionar las lineas y obtener las palabras
    char *token; //para seleccionar las palabras
    char *token_aux; //para ayudar a obtener la palabra correcta de la linea, missing key
    sorted_word_t *column; //para almacenar las palabras a ordenar con su posición en fila
    char **sorted_column; //para almacenar las palabras ordenadas

  

    //Recogemos los argumentos de entrada y gestión de errores
    if (argc < 2 || argc > 3) {
        fprintf (stderr, "Error: Bad command line parameters\n");
        return 1;

    }

    if (argc == 2) { 
        filename = argv[1];


    } else { 

        //obtención de key y gestión de errores
        arg_key = malloc ( 3 * sizeof(char));
        arg_key = argv[1];
        char char1 = arg_key[0]; // -
        
        if ( strcmp(&char1, "-") == 0 && isdigit(arg_key[1])) { //nos aseguramos de que key cumple el patrón
            char *ptr;
            key = strtol (&arg_key[1], &ptr, 10); //convertimos a long int el key

            if (isalpha(*ptr) != 0){ 
                fprintf (stderr, "Error: Bad command line parameters\n"); 
                return 1;
            }
            

        } else {
            fprintf (stderr, "Error: Bad command line parameters\n");
            return 1;

        }

        if (key < 1){
            fprintf (stderr, "Error: Bad command line parameters\n");
            return 1;

        }
        filename = argv[2];

    }

    //Abrimos el fichero 
    FILE *fptr = fopen (filename, "r");
    if (fptr == NULL){ 
        fprintf (stderr, "Error: Cannot open file %s\n", filename);
        return 1;

    }

    //estructura de datos para leer el texto y ordenarlo
    text = malloc(MAX_ROWS * sizeof(char*));
    text_aux = malloc (MAX_ROWS* sizeof(char*));
    column = malloc (MAX_ROWS * sizeof (sorted_word_t));
    sorted_column = malloc (SIZE_R0W * 2 * sizeof(char));

    for (int i = 0; i < MAX_ROWS; i++){
        text[i] = malloc(SIZE_R0W * sizeof(char));
        text_aux[i] = malloc(SIZE_R0W * sizeof(char));

    }

    if (text == NULL || text_aux == NULL || column == NULL || sorted_column == NULL) { //si malloc falla
        fprintf(stderr, "Error: malloc failed\n");
    }

    /*
        1. Leemos el texto linea por linea
        2. Hacemos uso de otra matriz para seccionar las frases y obtener las palabras que usaremos para ordenar
        3. Guardamos palabra  posición en estructura y en buffer para ordenar
    */
    while (fgets(text[row], SIZE_R0W, fptr)){
        
        if (isalpha(text[row][126]) != 0){
            fprintf(stderr, "Line too long\n");
            return 1;
        }
         
        #ifdef DEBUG
        printf ("%d: %s", row,  text[row]);
        #endif

        
        strcpy (text_aux[row], text[row]);
        strtok (text_aux[row], "\n"); //quitamos salto de línea
        token = strtok (text_aux[row], " ");
        if (key != 1) { 

            counter = 0;
            while (counter < key -1 && token != NULL) {
                token =  strtok (NULL, " ");
                if (token != NULL){
                    token_aux = token;
                }
                counter++;
            }

            token = token_aux;
        }

        //guardamos cada palabra con su correspondiente fila 
        column[row].word=token;
        column[row].row=row;
        sorted_column[row] = token; //para ser ordenada con qsort()
        row++;
    
    }  

    //comprobamos que el array de estructuras se ha completado correctamente
    #ifdef DEBUG
    printf ("\n");
    for (int i = 0; i < row; i++){
        printf ("word: %s, row: %d\n", column[i].word, column[i].row);
        
    }
    printf ("\n");
    #endif

    //ordenamos las palabras
    qsort (sorted_column, row, sizeof(char*), compare_string); 


    //comprobamos que las palabras se ordenan adecuadamente en el buffer
    #ifdef DEBUG
    printf("Palabras ordenadas: \n");
    for (int i = 0; i < row; i++){
        printf ("%d: %s\n", i, sorted_column[i]);
    }
    printf ("\n");
    #endif
   
    

    //imprimimos el texto final ordenado

   
    for (int i = 0; i < row; i++){
        pos = position_search(column, row, sorted_column[i]);
        printf ("%s", text[pos]);
        }
    
    
    
    //liberamos el espacio
    free(text);
    free(text_aux);
    free(column);
    free(sorted_column);


    return 0;
}


int position_search (sorted_word_t *col, int size, char* word){
    int pos = 0;
    for (int i = 0; i < size; i++){
        if (strcmp(word, col[i].word)==0){
            pos = col[i].row;
            col[i].row = -1;
            col[i].word = "";
            return pos; 

        }
        
    }
 
    return -1;
}



int compare_string (void const *a, void const *b){
    char const **aa = (char const **)a;
    char const **bb = (char const **)b;

    return strcmp(*aa, *bb);
}