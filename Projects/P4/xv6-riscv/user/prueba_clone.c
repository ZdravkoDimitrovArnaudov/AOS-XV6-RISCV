#include "kernel/types.h"
#include "user/user.h"

#undef NULL
#define NULL ((void*)0)

int ppid;
#define PGSIZE (4096)

volatile int global = 1;

/* #define assert(x) if (x) {} else { \
   printf("%s: %d ", __FILE__, __LINE__); \
   printf("assert failed (%s)\n", # x); \
   printf("TEST FAILED\n"); \
   kill(ppid); \
   exit(0); \
}
 */
void worker(void *arg_ptr);

int 
main(int argc, char *argv[])
{
  
   ppid = getpid();
   printf ("PID padre: %d\n", ppid);



   void *stack = malloc(PGSIZE*2);
   if((uint64)stack % PGSIZE){
     stack = stack + (4096 - (uint64)stack % PGSIZE);
   }
   printf ("Stack alocatado y listo para usarse\n");

   int clone_pid = clone(worker, (void*)6 , stack); // (void*)6, stack
   //wait(0);
   printf ("Resultado clone: %d\n", clone_pid);

   printf ("El valor de la variable global ha pasado a valer: %d\n", global);
   exit(0);
}

void
worker(void *arg_ptr) {
   //assert(global == 1);
   global = 5;
   printf ("El thread ha entrado en la función worker\n");
   exit(0);
}
