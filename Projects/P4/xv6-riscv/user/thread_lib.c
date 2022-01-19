//#include "kernel/defs.h"
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/param.h"
//#include "kernel/proc.h"


#define PAGE_SIZE (4096)
typedef uint lock_t;
typedef uint cont_t;

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


void lock_acquire (lock_t *lock){
    while( __sync_lock_test_and_set(lock, 1)!=0){

    ;
    }
     __sync_synchronize();
        

}

void lock_release (lock_t *lock){
     __sync_synchronize();
    __sync_lock_release(lock);
   
}

void lock_init (lock_t *lock){
    lock = 0;
    
}


void cv_wait (cont_t *cv, lock_t *lock){
    while( __sync_lock_test_and_set(cv, 0)!=1){
        lock_release(lock);
        sleep(1);
        lock_acquire(lock);
    }

     __sync_synchronize();

}


void cv_signal (cont_t *cv){
     __sync_synchronize();
     __sync_lock_test_and_set(cv, 1);

}


void cv_init (cont_t *cv){
    cv = 0;
}