/* test cv_wait and cv_signal, signal, don't broadcast */
#include "kernel/types.h"
#include "user/user.h"
//#include "user/thread_lib.h"

#undef NULL
#define NULL ((void*)0)

#define PGSIZE (4096)

int ppid;
int global = 0;
lock_t lock;
cond_t cond;
int nthreads = 30;

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
   for(i = 0; i < nthreads; i++) {
     int thread_pid = thread_create(worker, 0);
     assert(thread_pid > 0);
   }

   sleep(50);

   for(i = 0; i < nthreads; i++) {
     lock_acquire(&lock);
     assert(global == i);
     cv_signal(&cond);
     lock_release(&lock);

     int join_pid = thread_join();
     assert(join_pid > 0);

     sleep(10);
     lock_acquire(&lock);
     assert(global == i+1);
     lock_release(&lock);
   }

   printf("TEST PASSED\n");
   exit(0);
}

void
worker(void *arg_ptr) {
  lock_acquire(&lock);
  cv_wait(&cond, &lock);
  global++;
  lock_release(&lock);
  exit(0);
}
