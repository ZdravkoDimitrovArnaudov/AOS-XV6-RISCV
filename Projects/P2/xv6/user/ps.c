#include "types.h"
#include "user.h"
#include "pstat.h"

int main (void){

    /*
    if (setpri(HIGH_PRIORITY) == -1){
        printf (1,"Se ha producido un error\n");
        exit();
    }

    if (setpri(LOW_PRIORITY) == -1){
        printf (1,"Se ha producido un error\n");
        exit();
    }*/

    //vamos a allocar espacio para la estructura pstat
    struct pstat *ps = malloc (sizeof (struct pstat));
    getpinfo(ps);
    
    //recorremos la tabla para imprimir cada uno de los procesos
    printf(1, "Procesos existentes: \n");
    for (int i = 0 ; i < NPROC; i++){
        if (ps->inuse[i] == 1){
            printf (1, "PID:%d\n", ps->pid[i]);
        }
    }
    free(ps); 
    exit();
}