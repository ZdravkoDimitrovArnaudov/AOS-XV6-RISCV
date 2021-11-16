#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "stddef.h"

void
test_failed()
{
	printf("TEST FAILED\n");
	exit(0);
}

void
test_passed()
{
 printf("TEST PASSED\n");
 exit(0);
}

char *args[] = { "echo", 0 };

int
main(int argc, char *argv[])
{
	void *ptr;
 	int n;
	int i;

	for (i = 0; i < 4; i++) {
		ptr = shmem_access(i);
		if (ptr == NULL) {
			test_failed();
		}
	}
  
  for (i = 0; i < 4; i++) {
    n = shmem_count(i);
	printf("\nParent count = %d",n);
    if (n != 1) {
      test_failed();
    }
  }
	
	int pid = fork();
	if (pid < 0) {
		test_failed();
	}
	else if (pid == 0) {
		for (i = 0; i < 4; i++) {
			n = shmem_count(i);
			printf("\nChildren count = %d",n);
			if (n != 2) {
				test_failed();
			}
		}
    
    exec("echo", args); //echo represents shmem_count_exec_helper.c
    printf("exec failed!\n");
    test_failed();
		exit(0);	
	}
	else {
		wait(0);
	}

	test_passed();
	exit(0);
}
