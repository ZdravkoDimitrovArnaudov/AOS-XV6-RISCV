/* set up stack correctly (and without extra items) */
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
   ppid = getpid();
   void *stack = malloc(PGSIZE*2);
   assert(stack != NULL);
   if((uint64)stack % PGSIZE)
     stack = stack + (4096 - (uint64)stack % PGSIZE);

   printf ("El stack esta en: %d\n", stack);

   int clone_pid = clone(worker, stack, stack);
   assert(clone_pid > 0);
   while(global != 5);
   printf("TEST PASSED\n");
   exit(0);
}

void
worker(void *arg_ptr) {
   printf("Direccion arg: %d\n",(uint64)&arg_ptr);
   printf ("Donde arg deberia estar: %d\n", ((uint64)arg_ptr + PGSIZE)); //

   /*char *stack_top = (char *) (uint64)(arg_ptr+ PGSIZE);
   printf ("TOP_USTACK: %x \n", *(stack_top));
   printf ("TOP_USTACK-3: %x\n", *(stack_top - 3));
   printf ("TOP_USTACK-4: %x\n", *(stack_top - 4));
   printf ("TOP_USTACK-8: %x \n", *(stack_top - 8));
   printf ("TOP_USTACK-12: %x \n", *(stack_top - 12));
   printf ("TOP_USTACK-16: %x \n", *(stack_top - 16));
   printf ("TOP_USTACK-20: %x \n", *(stack_top - 20));
   printf ("TOP_USTACK-24: %x \n", *(stack_top - 24));
   printf ("TOP_USTACK-28: %x \n", *(stack_top - 28));
   printf ("TOP_USTACK-32: %x \n", *(stack_top - 32));
   printf ("TOP_USTACK-33: %x \n", *(stack_top - 33));
   printf ("TOP_USTACK-34: %x \n", *(stack_top - 34));
   printf ("TOP_USTACK-36: %x \n", *(stack_top - 36));
   printf ("TOP_USTACK-40: %x \n", *(stack_top - 40));
   printf ("TOP_USTACK-44: %x \n", *(stack_top - 44));
   printf ("TOP_USTACK-48: %x \n", *(stack_top - 48));
   printf ("TOP_USTACK-52: %x \n", *(stack_top - 52));
   printf ("TOP_USTACK-53: %x \n", *(stack_top - 53));
   printf ("TOP_USTACK-54: %x \n", *(stack_top - 54));
   printf ("TOP_USTACK-55: %x \n", *(stack_top - 55));
   printf ("TOP_USTACK-56: %x \n", *(stack_top - 56));
   printf ("TOP_USTACK-60: %x \n", *(stack_top - 60));
   printf ("TOP_USTACK-64: %x \n", *(stack_top - 64));
   printf ("TOP_USTACK-68: %x \n", *(stack_top - 68));*/

   assert((uint64)&arg_ptr == ((uint64)arg_ptr + PGSIZE - 32)); // -8
   assert(*((uint64*) (arg_ptr + PGSIZE - 8)) == 0xffffffff);
   global = 5;
   exit(0);
}
