//#include "kernel/defs.h"
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/param.h"
//#include "kernel/proc.h"


#define PAGE_SIZE (4096)
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
        free(stack);
        return -1;
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
    if ((va % PAGE_SIZE) != 0){
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
    }
    
    return clone (start_routine, arg, stack);
}


int thread_join()
{
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
    } 

    return child_tid;
}


void lock_acquire (lock_t *)
{

}

void lock_release (lock_t *)
{
    
}

void lock_init (lock_t *)
{
    
}

