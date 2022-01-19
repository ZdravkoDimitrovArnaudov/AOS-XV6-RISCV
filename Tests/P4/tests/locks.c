/* test lock correctness */
#include "kernel/types.h"
#include "user/user.h"
//#include "user/thread_lib.h"

#undef NULL
#define NULL ((void*)0)

#define PGSIZE (4096)

int ppid;
int global = 0;
lock_t lock = 0;
int num_threads = 30;
int loops = 1000;


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

   lock_init(&lock);

   int i;
   for (i = 0; i < num_threads; i++) {
      int thread_pid = thread_create(worker, 0);
      assert(thread_pid > 0);
   }

   for (i = 0; i < num_threads; i++) {
      int join_pid = thread_join();
      assert(join_pid > 0);
   }

   printf ("Global = %d, num_threads = %d\n", global, num_threads*loops);
   printf ("\n");
   assert(global == num_threads * loops);

   printf("TEST PASSED\n");
   exit(0);
}

void
worker(void *arg_ptr) {
   int i, j, tmp;
   for (i = 0; i < loops; i++) {
      lock_acquire(&lock);
      tmp = global;
      for(j = 0; j < 50; j++); // take some time
      global = tmp + 1;
      lock_release(&lock);
   }
   exit(0);
}

