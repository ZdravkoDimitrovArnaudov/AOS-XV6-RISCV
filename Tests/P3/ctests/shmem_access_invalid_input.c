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

int
main(int argc, char *argv[])
{
  void *ptr;
	
	ptr = shmem_access(-1);
	if (ptr != NULL) {
		test_failed();
	}
	printf("Test argumento 1: pasado\n");

	ptr = shmem_access(-100);
	if (ptr != NULL) {
		test_failed();
	}
	printf("Test argumento 2: pasado\n");

	ptr = shmem_access(4);
	if (ptr != NULL) {
		test_failed();
	}
	printf("Test argumento 3: pasado\n");

	ptr = shmem_access(100);
	if (ptr != NULL) {
		test_failed();
	}
	printf("Test argumento 4: pasado\n");

	test_passed();
	exit(0);
}
