#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"



int
main(int argc, char *argv[])
{
   int x = getprocs();
   //printf(1, x);
   printf(1, "hello world %d, \n", x);
  exit();
}
