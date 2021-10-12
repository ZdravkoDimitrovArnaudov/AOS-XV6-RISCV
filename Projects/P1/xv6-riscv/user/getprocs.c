#include "kernel/types.h"
#include "user/user.h"


int main (void)
{
    //mostramos por pantalla el retorno de la llamada al sistema.
    printf ("El número de procesos existentes en el sistema es: %d\n", getprocs());
    return exit (0);
}