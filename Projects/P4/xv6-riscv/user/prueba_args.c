#include "kernel/types.h"
#include "user/user.h"


void muestra_numero(int numero);

int
main(int argc, char *argv[])
{
    printf ("Antes de llamada función.\n");
    muestra_numero(5);
    printf ("Después de llamada a función.\n");
    exit(0);
}

void muestra_numero (int numero){
    printf ("El numero es: %d\n", numero);
}