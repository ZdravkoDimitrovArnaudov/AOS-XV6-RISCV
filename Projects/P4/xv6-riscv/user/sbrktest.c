/* clone and verify that address space is shared */
#include "kernel/types.h"
#include "user/user.h"

#undef NULL
#define NULL ((void*)0)

int ppid;
#define PGSIZE (4096)

volatile int global = 1;

#define assert(x) if (x) {} else { \
   printf("%s: %d ", __FILE__, __LINE__); \
   printf("assert failed (%s)\n", # x); \
   printf("TEST FAILED\n"); \
   kill(ppid); \
   exit(0); \
}

void worker(void *arg_ptr);

int
main(int argc, char *argv[])
{
   ppid = getpid();//recoge pid del proceso
   void *stack = malloc(PGSIZE*2);//reserva dos páginas para el malloc
   assert(stack != NULL); //comprueba que se haya podido crear bien memoria dinámica
   if((uint64)stack % PGSIZE) //si la pagina no está alineada
     stack = stack + (4096 - (uint64)stack % PGSIZE); //alinea el stack a página

   int clone_pid = clone(worker, 0, stack); //crea un thread para operar una funcion worker con argumento 0 y dispone stack de 2 páginas
   assert(clone_pid > 0); //comprueba que no haya fallado el clone

   
   void **join_stack = (void**) ((uint64)sbrk(0) - 8);
   while(global != 5); //comprueba si el thread ha modificado correctamente la variable global a 5 y no es otro valor distinto.
   assert(join((void**)((uint64)join_stack + 2)) == -1);
  
   printf("TEST PASSED\n");
   exit(0);
}

void
worker(void *arg_ptr) {
   assert(global == 1);
   sbrk(PGSIZE);
   global = 5;
   exit(0);
}