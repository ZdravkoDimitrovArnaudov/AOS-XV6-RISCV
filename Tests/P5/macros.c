#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

void
test_failed()
{
	printf(1, "TEST FAILED\n");
	exit();
}

void
test_passed()
{
 printf(1, "TEST PASSED\n");
 exit();
}

int
main(int argc, char *argv[])
{

  if (T_SMALLFILE != 4) {
	test_failed();	
  }

  if (O_SMALLFILE != 0x400) {
	test_failed();	
  }

  test_passed();
  
  exit();
}
