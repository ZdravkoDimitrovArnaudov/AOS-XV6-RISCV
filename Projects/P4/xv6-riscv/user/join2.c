/* join argument checking */
#include "kernel/types.h"
#include "user/user.h"

#undef NULL
#define NULL ((void*)0)

#define PGSIZE (4096)

int ppid;
int global = 1;

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
   ppid = getpid();
    //alocatadas dos paginas y alineadas a página
   void *stack = malloc(PGSIZE*2);
   assert(stack != NULL);
   if((uint64)stack % PGSIZE)
     stack = stack + (4096 - (uint64)stack % PGSIZE);

   printf ("Valor de stack: %d\n", stack); 

  

   //el argumento a pasar es 42
   int arg = 42;
   int clone_pid = clone(worker, &arg, stack);
   assert(clone_pid > 0);

   /*
    OBSERVACIONES

    El test a continuación se divide en 3 partes:
        1. Asignación de join_stack a sbrk(0) - 4
        2. Ejecuta join (join_stack + 2) == -1;
        3. Ejecuta join (join_stack) == clone_pid
    


    1.

    Privamente a la asignación, se hace sbrk(PGSIZE). Esto hace que el stack pase a ocupar
    3 paginas. 

    Cuando depuramos, vemos que:
         -el valor de stack es: 0x0000000000012000
         -el valor que se asigna a join_stack es: 0x0000000000014FFC

    En estas circunstancias, solo vemos que la variable apunta a un valor más alto que la base 
    del stack. Además, el join_stack se hace apuntar al sz - 4. 

    2.

    La dirección que pasamos por argumento, join_stack +2, no está alineada a word. Con lo cual,
    nuestro código debería ser capaz de darse cuenta.

    3.

    Esta llamada debería obtener un retorno natual, pero nuestro código siguen interpretando que la 
    dirección no es alineada a word.

   
   */

   sbrk(PGSIZE); 
   printf ("Asignación join_stack: %d\n", (uint64)sbrk(0) - 8);
   void **join_stack = (void**) ((uint64)sbrk(0) - 8);
      
   
   assert(join((void**)((uint64)join_stack +2)) == -1); // +2
   printf ("Primer join pasado.\n");

   assert(join(join_stack) == clone_pid); //devuelve -1

   printf ("Join stack aqui vale: %d\n", *join_stack);

   assert(stack == *join_stack);
   assert(global == 2);

   printf("TEST PASSED\n");
   exit(0);
}

void
worker(void *arg_ptr) {
   int arg = *(int*)arg_ptr;
   //printf ("WORKER: arg = %d\n", arg); //debe haber recogido el argumento correctamente y valer 42
   assert(arg == 42);
   assert(global == 1);
   global++;
   exit(0);
}

