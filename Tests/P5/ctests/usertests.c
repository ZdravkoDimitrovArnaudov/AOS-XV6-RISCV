/* user regression tests */
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#include "kernel/fs.h"
#include "kernel/syscall.h"
#include "kernel/riscv.h"
//#include "kernel/defs.h"

#define PAGE (4096)
#define MAX_PROC_MEM (640 * 1024)

char buf[2048];
char name[3];
char *echoargv[] = { "echo", "TEST", "PASSED", 0 };

// simple file system tests

void
opentest(void)
{
  int fd;

  printf("open test: ");
  fd = open("echo", 0);
  if(fd < 0){
    printf("open echo failed!\n");
    exit(0);
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf("open doesnotexist succeeded!\n");
    exit(0);
  }
  printf("ok\n");
}

void
writetest(void)
{
  int fd;
  int i;

  printf("small file test: ");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    //printf("creat small succeeded; ok\n");
  } else {
    printf("error: creat small failed!\n");
    exit(0);
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf("error: write aa %d new file failed\n", i);
      exit(0);
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf("error: write bb %d new file failed\n", i);
      exit(0);
    }
  }
  //printf("writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    //printf("open small succeeded ok\n");
  } else {
    printf("error: open small failed!\n");
    exit(0);
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    //printf("read succeeded ok\n");
  } else {
    printf("read failed\n");
    exit(0);
  }
  close(fd);

  if(unlink("small") < 0){
    printf("unlink small failed\n");
    exit(0);
  }
  printf("ok\n");
}

void
writetest1(void)
{
  int i, fd, n;

  printf("big files test: ");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf("error: creat big failed!\n");
    exit(0);
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
      printf("error: write big file failed\n", i);
      exit(0);
    }
  }

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf("error: open big failed!\n");
    exit(0);
  }

  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
        printf("read only %d blocks from big", n);
        exit(0);
      }
      break;
    } else if(i != 512){
      printf("read failed %d\n", i);
      exit(0);
    }
    if(((int*)buf)[0] != n){
      printf("read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit(0);
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0){
    printf("unlink big failed\n");
    exit(0);
  }
  printf("ok\n");
}

void
createtest(void)
{
  int i, fd;

  printf("create test: ");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    unlink(name);
  }
  printf("ok\n");
}

void dirtest(void)
{
  printf("mkdir test: ");

  if(mkdir("dir0") < 0){
    printf("mkdir failed\n");
    exit(0);
  }

  if(chdir("dir0") < 0){
    printf("chdir dir0 failed\n");
    exit(0);
  }

  if(chdir("..") < 0){
    printf("chdir .. failed\n");
    exit(0);
  }

  if(unlink("dir0") < 0){
    printf("unlink dir0 failed\n");
    exit(0);
  }
  printf("ok\n");
}

void
exectest(void)
{
  printf("exec test\n");
  if(exec("echo", echoargv) < 0){
    printf("exec echo failed\n");
    exit(0);
  }
}

// simple fork and pipe read/write

void
pipe1(void)
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  printf("pipe1: ");
  if(pipe(fds) != 0){
    printf("pipe() failed\n");
    exit(0);
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf("pipe1 oops 1\n");
        exit(0);
      }
    }
    exit(0);
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf("pipe1 oops 2\n");
          return;
        }
      }
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033)
      printf("pipe1 oops 3 total %d\n", total);
    close(fds[0]);
    wait(0);
  } else {
    printf("fork() failed\n");
    exit(0);
  }
  printf("ok\n");
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
  int pid1, pid2, pid3;
  int pfds[2];

  printf("preempt: ");
  pid1 = fork();
  if(pid1 == 0)
    for(;;)
      ;

  pid2 = fork();
  if(pid2 == 0)
    for(;;)
      ;

  pipe(pfds);
  pid3 = fork();
  if(pid3 == 0){
    close(pfds[0]);
    if(write(pfds[1], "x", 1) != 1)
      printf("preempt write error");
    close(pfds[1]);
    for(;;)
      ;
  }

  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf("preempt read error");
    return;
  }
  close(pfds[0]);
  printf("kill... ");
  kill(pid1);
  kill(pid2);
  kill(pid3);
  printf("wait... ");
  wait(0);
  wait(0);
  wait(0);
  printf("ok\n");
}

// try to find any races between exit and wait
void
exitwait(void)
{
  int i, pid;

  printf("exitwait: ");
  for(i = 0; i < 100; i++){
    pid = fork();
    if(pid < 0){
      printf("fork failed\n");
      return;
    }
    if(pid){
      if(wait(0) != pid){
        printf("wait wrong pid\n");
        return;
      }
    } else {
      exit(0);
    }
  }
  printf("ok\n");
}

void
mem(void)
{
  void *m1, *m2;
  int pid, ppid;

  printf("mem test: ");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0){
      printf("couldn't allocate mem?!!\n");
      kill(ppid);
      exit(0);
    }
    free(m1);
    printf("ok\n");
    exit(0);
  } else {
    wait(0);
  }
}

// More file system tests

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf("sharedfd: ");
  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf("fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
  memset(buf, pid==0?'c':'p', sizeof(buf));
  for(i = 0; i < 100; i++){
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
      printf("fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
    exit(0);
  else
    wait(0);
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf("fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
  unlink("sharedfd");
  if(nc == 1000 && np == 1000)
    printf("ok\n");
  else
    printf("sharedfd oops %d %d\n", nc, np);
}

// two processes write two different files at the same
// time, to test block allocation.
void
twofiles(void)
{
  int fd, pid, i, j, n, total;
  char *fname;

  printf("twofiles test: ");

  unlink("f1");
  unlink("f2");

  pid = fork();
  if(pid < 0){
    printf("fork failed\n");
    return;
  }

  fname = pid ? "f1" : "f2";
  fd = open(fname, O_CREATE | O_RDWR);
  if(fd < 0){
    printf("create failed\n");
    exit(0);
  }

  memset(buf, pid?'p':'c', 512);
  for(i = 0; i < 12; i++){
    if((n = write(fd, buf, 500)) != 500){
      printf("write failed %d\n", n);
      exit(0);
    }
  }
  close(fd);
  if(pid)
    wait(0);
  else
    exit(0);

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != (i?'p':'c')){
          printf("wrong char\n");
          exit(0);
        }
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf("wrong length %d\n", total);
      exit(0);
    }
  }

  unlink("f1");
  unlink("f2");

  printf("ok\n");
}

// two processes create and delete different files in same directory
void
createdelete(void)
{
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf("createdelete test: ");
  pid = fork();
  if(pid < 0){
    printf("fork failed\n");
    exit(0);
  }

  name[0] = pid ? 'p' : 'c';
  name[2] = '\0';
  for(i = 0; i < N; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE | O_RDWR);
    if(fd < 0){
      printf("create failed\n");
      exit(0);
    }
    close(fd);
    if(i > 0 && (i % 2 ) == 0){
      name[1] = '0' + (i / 2);
      if(unlink(name) < 0){
        printf("unlink failed\n");
        exit(0);
      }
    }
  }

  if(pid==0)
    exit(0);
  else
    wait(0);

  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf("oops createdelete %s didn't exist\n", name);
      exit(0);
    } else if((i >= 1 && i < N/2) && fd >= 0){
      printf("oops createdelete %s did exist\n", name);
      exit(0);
    }
    if(fd >= 0)
      close(fd);

    name[0] = 'c';
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf("oops createdelete %s didn't exist\n", name);
      exit(0);
    } else if((i >= 1 && i < N/2) && fd >= 0){
      printf("oops createdelete %s did exist\n", name);
      exit(0);
    }
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    unlink(name);
    name[0] = 'c';
    unlink(name);
  }

  printf("ok\n");
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
  int fd, fd1;

  printf("unlinkread test: ");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf("create unlinkread failed\n");
    exit(0);
  }
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf("open unlinkread failed\n");
    exit(0);
  }
  if(unlink("unlinkread") != 0){
    printf("unlink unlinkread failed\n");
    exit(0);
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf("unlinkread read failed");
    exit(0);
  }
  if(buf[0] != 'h'){
    printf("unlinkread wrong data\n");
    exit(0);
  }
  if(write(fd, buf, 10) != 10){
    printf("unlinkread write failed\n");
    exit(0);
  }
  close(fd);
  unlink("unlinkread");
  printf("ok\n");
}

void
linktest(void)
{
  int fd;

  printf("linktest: ");

  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf("create lf1 failed\n");
    exit(0);
  }
  if(write(fd, "hello", 5) != 5){
    printf("write lf1 failed\n");
    exit(0);
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf("link lf1 lf2 failed\n");
    exit(0);
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf("unlinked lf1 but it is still there!\n");
    exit(0);
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf("open lf2 failed\n");
    exit(0);
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf("read lf2 failed\n");
    exit(0);
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf("link lf2 lf2 succeeded! oops\n");
    exit(0);
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf("link non-existant succeeded! oops\n");
    exit(0);
  }

  if(link(".", "lf1") >= 0){
    printf("link . lf1 succeeded! oops\n");
    exit(0);
  }

  printf("ok\n");
}

// test concurrent create and unlink of the same file
void
concreate(void)
{
  char file[3];
  int i, pid, n, fd;
  char fa[40];
  struct {
    ushort inum;
    char name[14];
  } de;

  printf("concreate test: ");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf("concreate create %s failed\n", file);
        exit(0);
      }
      close(fd);
    }
    if(pid == 0)
      exit(0);
    else
      wait(0);
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf("concreate weird file %s\n", de.name);
        exit(0);
      }
      if(fa[i]){
        printf("concreate duplicate file %s\n", de.name);
        exit(0);
      }
      fa[i] = 1;
      n++;
    }
  }
  close(fd);

  if(n != 40){
    printf("concreate not enough files in directory listing\n");
    exit(0);
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf("fork failed\n");
      exit(0);
    }
    if(((i % 3) == 0 && pid == 0) ||
       ((i % 3) == 1 && pid != 0)){
      fd = open(file, 0);
      close(fd);
    } else {
      unlink(file);
    }
    if(pid == 0)
      exit(0);
    else
      wait(0);
  }

  printf("ok\n");
}

// directory that uses indirect blocks
void
bigdir(void)
{
  int i, fd;
  char name[10];

  printf("bigdir test: ");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf("bigdir create failed\n");
    exit(0);
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf("bigdir link failed\n");
      exit(0);
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf("bigdir unlink failed");
      exit(0);
    }
  }

  printf("ok\n");
}

void
subdir(void)
{
  int fd, cc;

  printf("subdir test: ");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf("subdir mkdir dd failed\n");
    exit(0);
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf("create dd/ff failed\n");
    exit(0);
  }
  write(fd, "ff", 2);
  close(fd);
  
  if(unlink("dd") >= 0){
    printf("unlink dd (non-empty dir) succeeded!\n");
    exit(0);
  }

  if(mkdir("/dd/dd") != 0){
    printf("subdir mkdir dd/dd failed\n");
    exit(0);
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf("create dd/dd/ff failed\n");
    exit(0);
  }
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf("open dd/dd/../ff failed\n");
    exit(0);
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf("dd/dd/../ff wrong content\n");
    exit(0);
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf("link dd/dd/ff dd/dd/ffff failed\n");
    exit(0);
  }

  if(unlink("dd/dd/ff") != 0){
    printf("unlink dd/dd/ff failed\n");
    exit(0);
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf("open (unlinked) dd/dd/ff succeeded\n");
    exit(0);
  }

  if(chdir("dd") != 0){
    printf("chdir dd failed\n");
    exit(0);
  }
  if(chdir("dd/../../dd") != 0){
    printf("chdir dd/../../dd failed\n");
    exit(0);
  }
  if(chdir("dd/../../../dd") != 0){
    printf("chdir dd/../../dd failed\n");
    exit(0);
  }
  if(chdir("./..") != 0){
    printf("chdir ./.. failed\n");
    exit(0);
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf("open dd/dd/ffff failed\n");
    exit(0);
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf("read dd/dd/ffff wrong len\n");
    exit(0);
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf("open (unlinked) dd/dd/ff succeeded!\n");
    exit(0);
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf("create dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf("create dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(open("dd", O_CREATE) >= 0){
    printf("create dd succeeded!\n");
    exit(0);
  }
  if(open("dd", O_RDWR) >= 0){
    printf("open dd rdwr succeeded!\n");
    exit(0);
  }
  if(open("dd", O_WRONLY) >= 0){
    printf("open dd wronly succeeded!\n");
    exit(0);
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf("link dd/ff/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf("link dd/xx/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf("link dd/ff dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/ff/ff") == 0){
    printf("mkdir dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/xx/ff") == 0){
    printf("mkdir dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf("mkdir dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/xx/ff") == 0){
    printf("unlink dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/ff/ff") == 0){
    printf("unlink dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/ff") == 0){
    printf("chdir dd/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/xx") == 0){
    printf("chdir dd/xx succeeded!\n");
    exit(0);
  }

  if(unlink("dd/dd/ffff") != 0){
    printf("unlink dd/dd/ff failed\n");
    exit(0);
  }
  if(unlink("dd/ff") != 0){
    printf("unlink dd/ff failed\n");
    exit(0);
  }
  if(unlink("dd") == 0){
    printf("unlink non-empty dd succeeded!\n");
    exit(0);
  }
  if(unlink("dd/dd") < 0){
    printf("unlink dd/dd failed\n");
    exit(0);
  }
  if(unlink("dd") < 0){
    printf("unlink dd failed\n");
    exit(0);
  }

  printf("ok\n");
}

void
bigfile(void)
{
  int fd, i, total, cc;

  printf("bigfile test: ");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf("cannot create bigfile");
    exit(0);
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf("write bigfile failed\n");
      exit(0);
    }
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf("cannot open bigfile\n");
    exit(0);
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf("read bigfile failed\n");
      exit(0);
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf("short read bigfile\n");
      exit(0);
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf("read bigfile wrong data\n");
      exit(0);
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf("read bigfile wrong total\n");
    exit(0);
  }
  unlink("bigfile");

  printf("ok\n");
}

void
fourteen(void)
{
  int fd;

  // DIRSIZ is 14.
  printf("fourteen test: ");

  if(mkdir("12345678901234") != 0){
    printf("mkdir 12345678901234 failed\n");
    exit(0);
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf("mkdir 12345678901234/123456789012345 failed\n");
    exit(0);
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf("create 123456789012345/123456789012345/123456789012345 failed\n");
    exit(0);
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf("open 12345678901234/12345678901234/12345678901234 failed\n");
    exit(0);
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf("mkdir 12345678901234/12345678901234 succeeded!\n");
    exit(0);
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf("mkdir 12345678901234/123456789012345 succeeded!\n");
    exit(0);
  }

  printf("ok\n");
}

void
rmdot(void)
{
  printf("rmdot test: ");
  if(mkdir("dots") != 0){
    printf("mkdir dots failed\n");
    exit(0);
  }
  if(chdir("dots") != 0){
    printf("chdir dots failed\n");
    exit(0);
  }
  if(unlink(".") == 0){
    printf("rm . worked!\n");
    exit(0);
  }
  if(unlink("..") == 0){
    printf("rm .. worked!\n");
    exit(0);
  }
  if(chdir("/") != 0){
    printf("chdir / failed\n");
    exit(0);
  }
  if(unlink("dots/.") == 0){
    printf("unlink dots/. worked!\n");
    exit(0);
  }
  if(unlink("dots/..") == 0){
    printf("unlink dots/.. worked!\n");
    exit(0);
  }
  if(unlink("dots") != 0){
    printf("unlink dots failed!\n");
    exit(0);
  }
  printf("ok\n");
}

void
dirfile(void)
{
  int fd;

  printf("dir vs file: ");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf("create dirfile failed\n");
    exit(0);
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf("chdir dirfile succeeded!\n");
    exit(0);
  }
  fd = open("dirfile/xx", 0);
  if(fd >= 0){
    printf("create dirfile/xx succeeded!\n");
    exit(0);
  }
  fd = open("dirfile/xx", O_CREATE);
  if(fd >= 0){
    printf("create dirfile/xx succeeded!\n");
    exit(0);
  }
  if(mkdir("dirfile/xx") == 0){
    printf("mkdir dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile/xx") == 0){
    printf("unlink dirfile/xx succeeded!\n");
    exit(0);
  }
  if(link("README", "dirfile/xx") == 0){
    printf("link to dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile") != 0){
    printf("unlink dirfile failed!\n");
    exit(0);
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf("open . for writing succeeded!\n");
    exit(0);
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf("write . succeeded!\n");
    exit(0);
  }
  close(fd);

  printf("ok\n");
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
  int i, fd;

  printf("empty file name: ");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf("mkdir irefd failed\n");
      exit(0);
    }
    if(chdir("irefd") != 0){
      printf("chdir irefd failed\n");
      exit(0);
    }

    mkdir("");
    link("README", "");
    fd = open("", O_CREATE);
    if(fd >= 0)
      close(fd);
    fd = open("xx", O_CREATE);
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
  printf("ok\n");
}

// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
  int n, pid;

  printf("fork test: ");

  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
      exit(0);
  }
  
  if(n == 1000){
    printf("fork claimed to work 1000 times!\n");
    exit(0);
  }
  
  for(; n > 0; n--){
    if(wait(0) < 0){
      printf("wait stopped early\n");
      exit(0);
    }
  }
  
  if(wait(0) != -1){
    printf("wait got too many\n");
    exit(0);
  }
  
  printf("ok\n");
}

void
sbrktest(void)
{
  int pid, ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p;
  uint64 amt;

  printf("sbrk test\n");
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    if(b != a){
      printf("sbrk test failed %d %x %x\n", i, a, b);
      exit(0);
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
  if(pid < 0){
    printf("sbrk test fork failed\n");
    exit(0);
  }
  c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf("sbrk test failed post-fork\n");
    exit(0);
  }
  if(pid == 0)
    exit(0);
  wait(0);

  // can one allocate the full 640K?
  a = sbrk(0);
  amt = (640 * 1024) - (uint64)a;
  p = sbrk(amt);
  if(p != a){
    printf("sbrk test failed 640K test, p %x a %x\n", p, a);
    exit(0);
  }
  lastaddr = (char*)(640 * 1024 - 1);
  *lastaddr = 99;

  //on RISCV we can allocate more than 640K
  // is one forbidden from allocating more than 640K?
  /*c = sbrk(4096);
  if(c != (char*)0xffffffff){
    printf("sbrk allocated more than 640K, c %x\n", c);
    exit(0);
  }*/

  // can one de-allocate?
  a = sbrk(0);
  c = sbrk(-4096);
  if(c == (char*)0xffffffff){
    printf("sbrk could not deallocate\n");
    exit(0);
  }
  c = sbrk(0);
  if(c != a - 4096){
    printf("sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit(0);
  }

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
  if(c != a || sbrk(0) != a + 4096){
    printf("sbrk re-allocation failed, a %x c %x\n", a, c);
    exit(0);
  }
  if(*lastaddr == 99){
    // should be zero
    printf("sbrk de-allocation didn't really deallocate\n");
    exit(0);
  }

  //on RISCV we can allocate more than 640K
  /*
  c = sbrk(4096);
  if(c != (char*)0xffffffff){
    printf("sbrk was able to re-allocate beyond 640K, c %x\n", c);
    exit(0);
  }*/

  // can we read the kernel's memory?
  for(a = (char*)(640*1024); a < (char*)2000000; a += 50000){
    ppid = getpid();
    pid = fork();
    if(pid < 0){
      printf("fork failed\n");
      exit(0);
    }
    if(pid == 0){
      printf("oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit(0);
    }
    wait(0);
  }

  if(sbrk(0) > oldbrk)
    sbrk(-(sbrk(0) - oldbrk));

  printf("sbrk test ok\n");
}

void leaktest() {
  int pids[32];
  int fds[2];
  char scratch, *oldbrk, *c;
  int i;

  oldbrk = sbrk(0);

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  sbrk(-(sbrk(0) - oldbrk));
  if(pipe(fds) != 0){
    printf("pipe() failed\n");
    exit(0);
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
      // allocate the full 640K - 1 page
      sbrk(MAX_PROC_MEM - (1 * PAGE) - (uint64)sbrk(0));
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  kill(pids[0]);
  wait(0);
  if((pids[0] = fork()) == 0){
     // allocate the full 640K page
     sbrk(MAX_PROC_MEM - (uint64)sbrk(0));
     write(fds[1], "x", 1);
     // sit around until killed
     for(;;) sleep(1000);
    }
  if(pids[0] != -1) {
     read(fds[0], &scratch, 1);
  } else {
     printf("fork failed\n");
     exit(0);
  }

  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(PAGE);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait(0);
  }
  if(c == (char*)0xffffffff){
    printf("failed sbrk leaked memory\n");
    exit(0);
  }

  if(sbrk(0) > oldbrk)
    sbrk(-(sbrk(0) - oldbrk));

}

/*void
validateint(int *p)
{
  int res;
  asm("mov %%esp, %%ebx\n\t"
      "mov %3, %%esp\n\t"
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}*/

/*void
validatetest(void)
{
  int hi, pid;
  uint64 p;

  printf("validate test: ");
  hi = 1100*1024;

  for(p = 0; p <= (uint64)hi; p += 4096){
    if((pid = fork()) == 0){
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit(0);
    }
    sleep(0);
    sleep(0);
    kill(pid);
    wait(0);

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
      printf("link should not succeed\n");
      exit(0);
    }
  }

  printf("ok\n");
}*/

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
  int i;

  printf("bss test: ");
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
      printf("bss test failed\n");
      exit(0);
    }
  }
  printf("ok\n");
}

// does exec do something sensible if the arguments
// are larger than a page?
void
bigargtest(void)
{
  int pid;

  pid = fork();
  if(pid == 0){
    char *args[32+1];
    int i;
    for(i = 0; i < 32; i++)
      args[i] = "bigargs test: failed\n                                                                                                                     ";
    args[32] = 0;
    printf("bigarg test: ");
    exec("echo", args);
    printf("ok\n");
    exit(0);
  } else if(pid < 0){
    printf("bigargtest: fork failed\n");
    exit(0);
  }
  wait(0);
}

int
main(int argc, char *argv[])
{
  printf("usertests starting\n");

  if(open("usertests.ran", 0) >= 0){
    printf("already ran user tests -- rebuild fs.img\n");
    exit(0);
  }
  close(open("usertests.ran", O_CREATE));

  bigargtest();
  bsstest();
  sbrktest();
  //validatetest();

  opentest();
  writetest();
  writetest1();
  createtest();

  mem();
  pipe1();
  preempt();
  exitwait();

  rmdot();
  fourteen();
  bigfile();
  subdir();
  concreate();
  linktest();
  unlinkread();
  createdelete();
  twofiles();
  sharedfd();
  dirfile();
  iref();
  forktest();
  bigdir(); // slow

  exectest();

  exit(0);
}
