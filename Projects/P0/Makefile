CC=gcc
FLAGS=-Wall -Werror

practica : fastsort

fastsort : fastsort.c
	$(CC) -o $@ $^ $(FLAGS)

clean:
	rm -f fastsort
