/*
 *	███▄ ▄███▓ ▄▄▄     ▄▄▄█████▓▓█████ ▓█████ ██▒   █▓
 *	▓██▒▀█▀ ██▒▒████▄   ▓  ██▒ ▓▒▓█   ▀ ▓█   ▀▓██░   █▒
 *	▓██    ▓██░▒██  ▀█▄ ▒ ▓██░ ▒░▒███   ▒███   ▓██  █▒░
 *	▒██    ▒██ ░██▄▄▄▄██░ ▓██▓ ░ ▒▓█  ▄ ▒▓█  ▄  ▒██ █░░
 *	▒██▒   ░██▒ ▓█   ▓██▒ ▒██▒ ░ ░▒████▒░▒████▒  ▒▀█░
 *	░ ▒░   ░  ░ ▒▒   ▓▒█░ ▒ ░░   ░░ ▒░ ░░░ ▒░ ░  ░ ▐░
 *	░  ░      ░  ▒   ▒▒ ░   ░     ░ ░  ░ ░ ░  ░  ░ ░░
 *	░      ░     ░   ▒    ░         ░      ░       ░░
 *	░         ░  ░           ░  ░   ░  ░     ░
 *											░
 *	Author:		Vladimir Kirilov Mateev
 *	Date:		09/2020
 *	Language:	C
 */

// Libraries
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Constants
#define DELIM_SPACE " "
#define DELIM_DASH "-"

// Global variables
int position = 1;

// Prototypes
int compareHandler(const void* a, const void* b);

/**
 * Gets the phrases from a file and
 * sorts them alphabetically
 */
int main(int argc, char *argv[]){
	int i;
	char *file_path;

	/* Reading the program arguments. */
	if(argc == 2){
		file_path = argv[1];
	} else if(argc == 3 && strstr(argv[1], DELIM_DASH) != NULL){
		file_path = argv[2];
		position = atoi(strtok(argv[1],"-"));
		if(position == 0) {
			fprintf(stderr, "Error: Bad command line parameters\n");
			exit(1);
		}
	} else {
		fprintf(stderr, "Error: Bad command line parameters\n");
		exit(1);
	}

	/* The file is accessed in read mode. */
	FILE *fd = fopen(file_path, "r");
	if(fd == NULL){
		fprintf(stderr, "Error: Cannot open file %s\n", file_path);
		exit(1);
	}

	/* The number of lines that the file contains is read. */
	int number_lines = 0;
	char *line = NULL;
	size_t len = 0;
	while(getline(&line, &len, fd) != -1) {
		if(strlen(line) > 128){
			fprintf(stderr, "Line too long\n");
			exit(1);
		}

		number_lines++;
 	}

	/* Each line is read and stored in an array. */
	char *lines[number_lines];	
	rewind(fd);	
	while(getline(&line, &len, fd) != -1) {
		lines[i] = malloc(strlen(line) * sizeof(char *));
		if(lines[i] == NULL || line == NULL){
			fprintf(stderr, "malloc failed\n");
			exit(1);
		}
		strcpy(lines[i], line);
		i++;
 	}

	/* The file descriptor closes. */
	fclose(fd);

	/* The array is ordered according to the comparison handler. */
	qsort(lines, number_lines, sizeof(char *), compareHandler);

	/* The result is printed on the screen. */
	for(i = 0; i < number_lines; i++)
		printf("%s", lines[i]);

	/* The reserved heap is released. */
	for(i = 0; i < number_lines; i++)
		free(lines[i]);
	free(line);

	exit(0);
}

/**
 * Get the words indicated by the given position 
 * in the program of two sentences and compares them
 * 
 * @param a Phrase 1
 * @param b Phrase 2
 * @return Word_a > Word_b, Word_a < Word_b, Word_a = Word_b
 */
int compareHandler(const void* a, const void* b){
	int i;

	/* It is reserved in the heap array of characters. */
	char* tmp_a = malloc(strlen(*(char * const *) a) * sizeof(*(char * const *) a));
	if(tmp_a == NULL){
		fprintf(stderr, "malloc failed\n");
		exit(1);
	}

	char* tmp_b = malloc(strlen(*(char * const *) b) * sizeof(*(char * const *) b));
	if(tmp_b == NULL){
		fprintf(stderr, "malloc failed\n");
		exit(1);
	}

	/* Phrases are copied into temporary arrays, */
	/* so as not to lose the content for the strtok() */
	strcpy(tmp_a, * (char * const *) a);
	strcpy(tmp_b, * (char * const *) b);

	/* The words to compare are obtained. */
	char* token1;
	char* word1 = strtok(tmp_a, DELIM_SPACE);
	for(i = 0; i < position-1; i++){
			if((token1=strtok(NULL,DELIM_SPACE)) != NULL){
				word1 = token1;
			}
				
	}

	char* token2;
	char* word2 = strtok(tmp_b, DELIM_SPACE);
	for(i = 0; i < position-1; i++){
			if((token2=strtok(NULL,DELIM_SPACE)) != NULL){
				word2 = token2;
			}
	}

	/* Only the words are compared and not the entire sentence. */
	int ret = strcmp(word1, word2);

	/* The reserved heap is released. */
	free(tmp_a);
	free(tmp_b);

	return ret;
}

