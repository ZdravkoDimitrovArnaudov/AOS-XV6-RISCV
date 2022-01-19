
user/_open:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <test_failed>:
#include "user/user.h"
#include "kernel/fcntl.h"

void
test_failed()
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
	printf("TEST FAILED\n");
   8:	00001517          	auipc	a0,0x1
   c:	98850513          	addi	a0,a0,-1656 # 990 <malloc+0xe6>
  10:	00000097          	auipc	ra,0x0
  14:	7e2080e7          	jalr	2018(ra) # 7f2 <printf>
	exit(0);
  18:	4501                	li	a0,0
  1a:	00000097          	auipc	ra,0x0
  1e:	45e080e7          	jalr	1118(ra) # 478 <exit>

0000000000000022 <test_passed>:
}

void
test_passed()
{
  22:	1141                	addi	sp,sp,-16
  24:	e406                	sd	ra,8(sp)
  26:	e022                	sd	s0,0(sp)
  28:	0800                	addi	s0,sp,16
 printf("TEST PASSED\n");
  2a:	00001517          	auipc	a0,0x1
  2e:	97650513          	addi	a0,a0,-1674 # 9a0 <malloc+0xf6>
  32:	00000097          	auipc	ra,0x0
  36:	7c0080e7          	jalr	1984(ra) # 7f2 <printf>
 exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	43c080e7          	jalr	1084(ra) # 478 <exit>

0000000000000044 <main>:

#define MAX 50

int
main(int argc, char *argv[])
{
  44:	7171                	addi	sp,sp,-176
  46:	f506                	sd	ra,168(sp)
  48:	f122                	sd	s0,160(sp)
  4a:	ed26                	sd	s1,152(sp)
  4c:	1900                	addi	s0,sp,176
  int fd, i;
  struct stat st;
  char buf[MAX];
  char buf2[MAX];

  for(i = 0; i < MAX; i++){
  4e:	f9040713          	addi	a4,s0,-112
  52:	fc240613          	addi	a2,s0,-62
{
  56:	87ba                	mv	a5,a4
    buf[i] = (char)(i+(int)'0');
  58:	03000693          	li	a3,48
  5c:	9e99                	subw	a3,a3,a4
  5e:	00f6873b          	addw	a4,a3,a5
  62:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < MAX; i++){
  66:	0785                	addi	a5,a5,1
  68:	fec79be3          	bne	a5,a2,5e <main+0x1a>
  }
  
  
  //create
  if((fd = open("test_file.txt", O_CREATE | O_SMALLFILE)) < 0){
  6c:	6585                	lui	a1,0x1
  6e:	a0058593          	addi	a1,a1,-1536 # a00 <malloc+0x156>
  72:	00001517          	auipc	a0,0x1
  76:	93e50513          	addi	a0,a0,-1730 # 9b0 <malloc+0x106>
  7a:	00000097          	auipc	ra,0x0
  7e:	43e080e7          	jalr	1086(ra) # 4b8 <open>
  82:	04054b63          	bltz	a0,d8 <main+0x94>
    printf("Failed to create a small file\n");
    test_failed();
  }
  close(fd);
  86:	00000097          	auipc	ra,0x0
  8a:	41a080e7          	jalr	1050(ra) # 4a0 <close>
  
  
  //type check and write
  if((fd = open("test_file.txt", O_RDWR)) < 0){
  8e:	4589                	li	a1,2
  90:	00001517          	auipc	a0,0x1
  94:	92050513          	addi	a0,a0,-1760 # 9b0 <malloc+0x106>
  98:	00000097          	auipc	ra,0x0
  9c:	420080e7          	jalr	1056(ra) # 4b8 <open>
  a0:	84aa                	mv	s1,a0
  a2:	04054763          	bltz	a0,f0 <main+0xac>
    printf("Failed to open a small file\n");
    test_failed();
  }
  
  if(fstat(fd, &st) < 0){
  a6:	fc840593          	addi	a1,s0,-56
  aa:	00000097          	auipc	ra,0x0
  ae:	426080e7          	jalr	1062(ra) # 4d0 <fstat>
  b2:	04054b63          	bltz	a0,108 <main+0xc4>
    printf("Failed to get stat on the small file\n");
    test_failed();
  }
  
  if (st.type != T_SMALLFILE) {
  b6:	fd041703          	lh	a4,-48(s0)
  ba:	4791                	li	a5,4
  bc:	06f70263          	beq	a4,a5,120 <main+0xdc>
    printf("Did not create a small file\n");
  c0:	00001517          	auipc	a0,0x1
  c4:	96850513          	addi	a0,a0,-1688 # a28 <malloc+0x17e>
  c8:	00000097          	auipc	ra,0x0
  cc:	72a080e7          	jalr	1834(ra) # 7f2 <printf>
    test_failed();
  d0:	00000097          	auipc	ra,0x0
  d4:	f30080e7          	jalr	-208(ra) # 0 <test_failed>
    printf("Failed to create a small file\n");
  d8:	00001517          	auipc	a0,0x1
  dc:	8e850513          	addi	a0,a0,-1816 # 9c0 <malloc+0x116>
  e0:	00000097          	auipc	ra,0x0
  e4:	712080e7          	jalr	1810(ra) # 7f2 <printf>
    test_failed();
  e8:	00000097          	auipc	ra,0x0
  ec:	f18080e7          	jalr	-232(ra) # 0 <test_failed>
    printf("Failed to open a small file\n");
  f0:	00001517          	auipc	a0,0x1
  f4:	8f050513          	addi	a0,a0,-1808 # 9e0 <malloc+0x136>
  f8:	00000097          	auipc	ra,0x0
  fc:	6fa080e7          	jalr	1786(ra) # 7f2 <printf>
    test_failed();
 100:	00000097          	auipc	ra,0x0
 104:	f00080e7          	jalr	-256(ra) # 0 <test_failed>
    printf("Failed to get stat on the small file\n");
 108:	00001517          	auipc	a0,0x1
 10c:	8f850513          	addi	a0,a0,-1800 # a00 <malloc+0x156>
 110:	00000097          	auipc	ra,0x0
 114:	6e2080e7          	jalr	1762(ra) # 7f2 <printf>
    test_failed();
 118:	00000097          	auipc	ra,0x0
 11c:	ee8080e7          	jalr	-280(ra) # 0 <test_failed>
  }
 
  if(write(fd, buf, MAX) != MAX){
 120:	03200613          	li	a2,50
 124:	f9040593          	addi	a1,s0,-112
 128:	8526                	mv	a0,s1
 12a:	00000097          	auipc	ra,0x0
 12e:	36e080e7          	jalr	878(ra) # 498 <write>
 132:	03200793          	li	a5,50
 136:	00f50e63          	beq	a0,a5,152 <main+0x10e>
    printf("Write failed!\n");
 13a:	00001517          	auipc	a0,0x1
 13e:	90e50513          	addi	a0,a0,-1778 # a48 <malloc+0x19e>
 142:	00000097          	auipc	ra,0x0
 146:	6b0080e7          	jalr	1712(ra) # 7f2 <printf>
    test_failed();
 14a:	00000097          	auipc	ra,0x0
 14e:	eb6080e7          	jalr	-330(ra) # 0 <test_failed>
  }
  close(fd);
 152:	8526                	mv	a0,s1
 154:	00000097          	auipc	ra,0x0
 158:	34c080e7          	jalr	844(ra) # 4a0 <close>

  
  //read
  if((fd = open("test_file.txt", O_RDWR)) < 0){
 15c:	4589                	li	a1,2
 15e:	00001517          	auipc	a0,0x1
 162:	85250513          	addi	a0,a0,-1966 # 9b0 <malloc+0x106>
 166:	00000097          	auipc	ra,0x0
 16a:	352080e7          	jalr	850(ra) # 4b8 <open>
 16e:	84aa                	mv	s1,a0
 170:	02054a63          	bltz	a0,1a4 <main+0x160>
    printf("Failed to open a small file\n");
    test_failed();
  }
  
  if(read(fd, buf2, MAX) != MAX){
 174:	03200613          	li	a2,50
 178:	f5840593          	addi	a1,s0,-168
 17c:	00000097          	auipc	ra,0x0
 180:	314080e7          	jalr	788(ra) # 490 <read>
 184:	03200793          	li	a5,50
 188:	02f50a63          	beq	a0,a5,1bc <main+0x178>
    printf("Read failed!\n");
 18c:	00001517          	auipc	a0,0x1
 190:	8cc50513          	addi	a0,a0,-1844 # a58 <malloc+0x1ae>
 194:	00000097          	auipc	ra,0x0
 198:	65e080e7          	jalr	1630(ra) # 7f2 <printf>
    test_failed();
 19c:	00000097          	auipc	ra,0x0
 1a0:	e64080e7          	jalr	-412(ra) # 0 <test_failed>
    printf("Failed to open a small file\n");
 1a4:	00001517          	auipc	a0,0x1
 1a8:	83c50513          	addi	a0,a0,-1988 # 9e0 <malloc+0x136>
 1ac:	00000097          	auipc	ra,0x0
 1b0:	646080e7          	jalr	1606(ra) # 7f2 <printf>
    test_failed();
 1b4:	00000097          	auipc	ra,0x0
 1b8:	e4c080e7          	jalr	-436(ra) # 0 <test_failed>
  }
  close(fd);
 1bc:	8526                	mv	a0,s1
 1be:	00000097          	auipc	ra,0x0
 1c2:	2e2080e7          	jalr	738(ra) # 4a0 <close>
 1c6:	4781                	li	a5,0
  
  for(i = 0; i < MAX; i++){
 1c8:	03200613          	li	a2,50
    if(buf[i] != buf2[i]){
 1cc:	f9040713          	addi	a4,s0,-112
 1d0:	00f706b3          	add	a3,a4,a5
 1d4:	f5840713          	addi	a4,s0,-168
 1d8:	973e                	add	a4,a4,a5
 1da:	0006c683          	lbu	a3,0(a3)
 1de:	00074703          	lbu	a4,0(a4)
 1e2:	00e69963          	bne	a3,a4,1f4 <main+0x1b0>
  for(i = 0; i < MAX; i++){
 1e6:	0785                	addi	a5,a5,1
 1e8:	fec792e3          	bne	a5,a2,1cc <main+0x188>
      printf("Data mismatch.\n");
      test_failed();
    }
  }
  
  test_passed();
 1ec:	00000097          	auipc	ra,0x0
 1f0:	e36080e7          	jalr	-458(ra) # 22 <test_passed>
      printf("Data mismatch.\n");
 1f4:	00001517          	auipc	a0,0x1
 1f8:	87450513          	addi	a0,a0,-1932 # a68 <malloc+0x1be>
 1fc:	00000097          	auipc	ra,0x0
 200:	5f6080e7          	jalr	1526(ra) # 7f2 <printf>
      test_failed();
 204:	00000097          	auipc	ra,0x0
 208:	dfc080e7          	jalr	-516(ra) # 0 <test_failed>

000000000000020c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 20c:	1141                	addi	sp,sp,-16
 20e:	e422                	sd	s0,8(sp)
 210:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 212:	87aa                	mv	a5,a0
 214:	0585                	addi	a1,a1,1
 216:	0785                	addi	a5,a5,1
 218:	fff5c703          	lbu	a4,-1(a1)
 21c:	fee78fa3          	sb	a4,-1(a5)
 220:	fb75                	bnez	a4,214 <strcpy+0x8>
    ;
  return os;
}
 222:	6422                	ld	s0,8(sp)
 224:	0141                	addi	sp,sp,16
 226:	8082                	ret

0000000000000228 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 228:	1141                	addi	sp,sp,-16
 22a:	e422                	sd	s0,8(sp)
 22c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 22e:	00054783          	lbu	a5,0(a0)
 232:	cb91                	beqz	a5,246 <strcmp+0x1e>
 234:	0005c703          	lbu	a4,0(a1)
 238:	00f71763          	bne	a4,a5,246 <strcmp+0x1e>
    p++, q++;
 23c:	0505                	addi	a0,a0,1
 23e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 240:	00054783          	lbu	a5,0(a0)
 244:	fbe5                	bnez	a5,234 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 246:	0005c503          	lbu	a0,0(a1)
}
 24a:	40a7853b          	subw	a0,a5,a0
 24e:	6422                	ld	s0,8(sp)
 250:	0141                	addi	sp,sp,16
 252:	8082                	ret

0000000000000254 <strlen>:

uint
strlen(const char *s)
{
 254:	1141                	addi	sp,sp,-16
 256:	e422                	sd	s0,8(sp)
 258:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 25a:	00054783          	lbu	a5,0(a0)
 25e:	cf91                	beqz	a5,27a <strlen+0x26>
 260:	0505                	addi	a0,a0,1
 262:	87aa                	mv	a5,a0
 264:	4685                	li	a3,1
 266:	9e89                	subw	a3,a3,a0
 268:	00f6853b          	addw	a0,a3,a5
 26c:	0785                	addi	a5,a5,1
 26e:	fff7c703          	lbu	a4,-1(a5)
 272:	fb7d                	bnez	a4,268 <strlen+0x14>
    ;
  return n;
}
 274:	6422                	ld	s0,8(sp)
 276:	0141                	addi	sp,sp,16
 278:	8082                	ret
  for(n = 0; s[n]; n++)
 27a:	4501                	li	a0,0
 27c:	bfe5                	j	274 <strlen+0x20>

000000000000027e <memset>:

void*
memset(void *dst, int c, uint n)
{
 27e:	1141                	addi	sp,sp,-16
 280:	e422                	sd	s0,8(sp)
 282:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 284:	ca19                	beqz	a2,29a <memset+0x1c>
 286:	87aa                	mv	a5,a0
 288:	1602                	slli	a2,a2,0x20
 28a:	9201                	srli	a2,a2,0x20
 28c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 290:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 294:	0785                	addi	a5,a5,1
 296:	fee79de3          	bne	a5,a4,290 <memset+0x12>
  }
  return dst;
}
 29a:	6422                	ld	s0,8(sp)
 29c:	0141                	addi	sp,sp,16
 29e:	8082                	ret

00000000000002a0 <strchr>:

char*
strchr(const char *s, char c)
{
 2a0:	1141                	addi	sp,sp,-16
 2a2:	e422                	sd	s0,8(sp)
 2a4:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2a6:	00054783          	lbu	a5,0(a0)
 2aa:	cb99                	beqz	a5,2c0 <strchr+0x20>
    if(*s == c)
 2ac:	00f58763          	beq	a1,a5,2ba <strchr+0x1a>
  for(; *s; s++)
 2b0:	0505                	addi	a0,a0,1
 2b2:	00054783          	lbu	a5,0(a0)
 2b6:	fbfd                	bnez	a5,2ac <strchr+0xc>
      return (char*)s;
  return 0;
 2b8:	4501                	li	a0,0
}
 2ba:	6422                	ld	s0,8(sp)
 2bc:	0141                	addi	sp,sp,16
 2be:	8082                	ret
  return 0;
 2c0:	4501                	li	a0,0
 2c2:	bfe5                	j	2ba <strchr+0x1a>

00000000000002c4 <gets>:

char*
gets(char *buf, int max)
{
 2c4:	711d                	addi	sp,sp,-96
 2c6:	ec86                	sd	ra,88(sp)
 2c8:	e8a2                	sd	s0,80(sp)
 2ca:	e4a6                	sd	s1,72(sp)
 2cc:	e0ca                	sd	s2,64(sp)
 2ce:	fc4e                	sd	s3,56(sp)
 2d0:	f852                	sd	s4,48(sp)
 2d2:	f456                	sd	s5,40(sp)
 2d4:	f05a                	sd	s6,32(sp)
 2d6:	ec5e                	sd	s7,24(sp)
 2d8:	1080                	addi	s0,sp,96
 2da:	8baa                	mv	s7,a0
 2dc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2de:	892a                	mv	s2,a0
 2e0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2e2:	4aa9                	li	s5,10
 2e4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2e6:	89a6                	mv	s3,s1
 2e8:	2485                	addiw	s1,s1,1
 2ea:	0344d863          	bge	s1,s4,31a <gets+0x56>
    cc = read(0, &c, 1);
 2ee:	4605                	li	a2,1
 2f0:	faf40593          	addi	a1,s0,-81
 2f4:	4501                	li	a0,0
 2f6:	00000097          	auipc	ra,0x0
 2fa:	19a080e7          	jalr	410(ra) # 490 <read>
    if(cc < 1)
 2fe:	00a05e63          	blez	a0,31a <gets+0x56>
    buf[i++] = c;
 302:	faf44783          	lbu	a5,-81(s0)
 306:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 30a:	01578763          	beq	a5,s5,318 <gets+0x54>
 30e:	0905                	addi	s2,s2,1
 310:	fd679be3          	bne	a5,s6,2e6 <gets+0x22>
  for(i=0; i+1 < max; ){
 314:	89a6                	mv	s3,s1
 316:	a011                	j	31a <gets+0x56>
 318:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 31a:	99de                	add	s3,s3,s7
 31c:	00098023          	sb	zero,0(s3)
  return buf;
}
 320:	855e                	mv	a0,s7
 322:	60e6                	ld	ra,88(sp)
 324:	6446                	ld	s0,80(sp)
 326:	64a6                	ld	s1,72(sp)
 328:	6906                	ld	s2,64(sp)
 32a:	79e2                	ld	s3,56(sp)
 32c:	7a42                	ld	s4,48(sp)
 32e:	7aa2                	ld	s5,40(sp)
 330:	7b02                	ld	s6,32(sp)
 332:	6be2                	ld	s7,24(sp)
 334:	6125                	addi	sp,sp,96
 336:	8082                	ret

0000000000000338 <stat>:

int
stat(const char *n, struct stat *st)
{
 338:	1101                	addi	sp,sp,-32
 33a:	ec06                	sd	ra,24(sp)
 33c:	e822                	sd	s0,16(sp)
 33e:	e426                	sd	s1,8(sp)
 340:	e04a                	sd	s2,0(sp)
 342:	1000                	addi	s0,sp,32
 344:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 346:	4581                	li	a1,0
 348:	00000097          	auipc	ra,0x0
 34c:	170080e7          	jalr	368(ra) # 4b8 <open>
  if(fd < 0)
 350:	02054563          	bltz	a0,37a <stat+0x42>
 354:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 356:	85ca                	mv	a1,s2
 358:	00000097          	auipc	ra,0x0
 35c:	178080e7          	jalr	376(ra) # 4d0 <fstat>
 360:	892a                	mv	s2,a0
  close(fd);
 362:	8526                	mv	a0,s1
 364:	00000097          	auipc	ra,0x0
 368:	13c080e7          	jalr	316(ra) # 4a0 <close>
  return r;
}
 36c:	854a                	mv	a0,s2
 36e:	60e2                	ld	ra,24(sp)
 370:	6442                	ld	s0,16(sp)
 372:	64a2                	ld	s1,8(sp)
 374:	6902                	ld	s2,0(sp)
 376:	6105                	addi	sp,sp,32
 378:	8082                	ret
    return -1;
 37a:	597d                	li	s2,-1
 37c:	bfc5                	j	36c <stat+0x34>

000000000000037e <atoi>:

int
atoi(const char *s)
{
 37e:	1141                	addi	sp,sp,-16
 380:	e422                	sd	s0,8(sp)
 382:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 384:	00054683          	lbu	a3,0(a0)
 388:	fd06879b          	addiw	a5,a3,-48
 38c:	0ff7f793          	zext.b	a5,a5
 390:	4625                	li	a2,9
 392:	02f66863          	bltu	a2,a5,3c2 <atoi+0x44>
 396:	872a                	mv	a4,a0
  n = 0;
 398:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 39a:	0705                	addi	a4,a4,1
 39c:	0025179b          	slliw	a5,a0,0x2
 3a0:	9fa9                	addw	a5,a5,a0
 3a2:	0017979b          	slliw	a5,a5,0x1
 3a6:	9fb5                	addw	a5,a5,a3
 3a8:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3ac:	00074683          	lbu	a3,0(a4)
 3b0:	fd06879b          	addiw	a5,a3,-48
 3b4:	0ff7f793          	zext.b	a5,a5
 3b8:	fef671e3          	bgeu	a2,a5,39a <atoi+0x1c>
  return n;
}
 3bc:	6422                	ld	s0,8(sp)
 3be:	0141                	addi	sp,sp,16
 3c0:	8082                	ret
  n = 0;
 3c2:	4501                	li	a0,0
 3c4:	bfe5                	j	3bc <atoi+0x3e>

00000000000003c6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3c6:	1141                	addi	sp,sp,-16
 3c8:	e422                	sd	s0,8(sp)
 3ca:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3cc:	02b57463          	bgeu	a0,a1,3f4 <memmove+0x2e>
    while(n-- > 0)
 3d0:	00c05f63          	blez	a2,3ee <memmove+0x28>
 3d4:	1602                	slli	a2,a2,0x20
 3d6:	9201                	srli	a2,a2,0x20
 3d8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3dc:	872a                	mv	a4,a0
      *dst++ = *src++;
 3de:	0585                	addi	a1,a1,1
 3e0:	0705                	addi	a4,a4,1
 3e2:	fff5c683          	lbu	a3,-1(a1)
 3e6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3ea:	fee79ae3          	bne	a5,a4,3de <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3ee:	6422                	ld	s0,8(sp)
 3f0:	0141                	addi	sp,sp,16
 3f2:	8082                	ret
    dst += n;
 3f4:	00c50733          	add	a4,a0,a2
    src += n;
 3f8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3fa:	fec05ae3          	blez	a2,3ee <memmove+0x28>
 3fe:	fff6079b          	addiw	a5,a2,-1
 402:	1782                	slli	a5,a5,0x20
 404:	9381                	srli	a5,a5,0x20
 406:	fff7c793          	not	a5,a5
 40a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 40c:	15fd                	addi	a1,a1,-1
 40e:	177d                	addi	a4,a4,-1
 410:	0005c683          	lbu	a3,0(a1)
 414:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 418:	fee79ae3          	bne	a5,a4,40c <memmove+0x46>
 41c:	bfc9                	j	3ee <memmove+0x28>

000000000000041e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 41e:	1141                	addi	sp,sp,-16
 420:	e422                	sd	s0,8(sp)
 422:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 424:	ca05                	beqz	a2,454 <memcmp+0x36>
 426:	fff6069b          	addiw	a3,a2,-1
 42a:	1682                	slli	a3,a3,0x20
 42c:	9281                	srli	a3,a3,0x20
 42e:	0685                	addi	a3,a3,1
 430:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 432:	00054783          	lbu	a5,0(a0)
 436:	0005c703          	lbu	a4,0(a1)
 43a:	00e79863          	bne	a5,a4,44a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 43e:	0505                	addi	a0,a0,1
    p2++;
 440:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 442:	fed518e3          	bne	a0,a3,432 <memcmp+0x14>
  }
  return 0;
 446:	4501                	li	a0,0
 448:	a019                	j	44e <memcmp+0x30>
      return *p1 - *p2;
 44a:	40e7853b          	subw	a0,a5,a4
}
 44e:	6422                	ld	s0,8(sp)
 450:	0141                	addi	sp,sp,16
 452:	8082                	ret
  return 0;
 454:	4501                	li	a0,0
 456:	bfe5                	j	44e <memcmp+0x30>

0000000000000458 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 458:	1141                	addi	sp,sp,-16
 45a:	e406                	sd	ra,8(sp)
 45c:	e022                	sd	s0,0(sp)
 45e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 460:	00000097          	auipc	ra,0x0
 464:	f66080e7          	jalr	-154(ra) # 3c6 <memmove>
}
 468:	60a2                	ld	ra,8(sp)
 46a:	6402                	ld	s0,0(sp)
 46c:	0141                	addi	sp,sp,16
 46e:	8082                	ret

0000000000000470 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 470:	4885                	li	a7,1
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <exit>:
.global exit
exit:
 li a7, SYS_exit
 478:	4889                	li	a7,2
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <wait>:
.global wait
wait:
 li a7, SYS_wait
 480:	488d                	li	a7,3
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 488:	4891                	li	a7,4
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <read>:
.global read
read:
 li a7, SYS_read
 490:	4895                	li	a7,5
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <write>:
.global write
write:
 li a7, SYS_write
 498:	48c1                	li	a7,16
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <close>:
.global close
close:
 li a7, SYS_close
 4a0:	48d5                	li	a7,21
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4a8:	4899                	li	a7,6
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4b0:	489d                	li	a7,7
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <open>:
.global open
open:
 li a7, SYS_open
 4b8:	48bd                	li	a7,15
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4c0:	48c5                	li	a7,17
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4c8:	48c9                	li	a7,18
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4d0:	48a1                	li	a7,8
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <link>:
.global link
link:
 li a7, SYS_link
 4d8:	48cd                	li	a7,19
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4e0:	48d1                	li	a7,20
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4e8:	48a5                	li	a7,9
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4f0:	48a9                	li	a7,10
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4f8:	48ad                	li	a7,11
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 500:	48b1                	li	a7,12
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 508:	48b5                	li	a7,13
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 510:	48b9                	li	a7,14
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 518:	1101                	addi	sp,sp,-32
 51a:	ec06                	sd	ra,24(sp)
 51c:	e822                	sd	s0,16(sp)
 51e:	1000                	addi	s0,sp,32
 520:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 524:	4605                	li	a2,1
 526:	fef40593          	addi	a1,s0,-17
 52a:	00000097          	auipc	ra,0x0
 52e:	f6e080e7          	jalr	-146(ra) # 498 <write>
}
 532:	60e2                	ld	ra,24(sp)
 534:	6442                	ld	s0,16(sp)
 536:	6105                	addi	sp,sp,32
 538:	8082                	ret

000000000000053a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 53a:	7139                	addi	sp,sp,-64
 53c:	fc06                	sd	ra,56(sp)
 53e:	f822                	sd	s0,48(sp)
 540:	f426                	sd	s1,40(sp)
 542:	f04a                	sd	s2,32(sp)
 544:	ec4e                	sd	s3,24(sp)
 546:	0080                	addi	s0,sp,64
 548:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 54a:	c299                	beqz	a3,550 <printint+0x16>
 54c:	0805c963          	bltz	a1,5de <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 550:	2581                	sext.w	a1,a1
  neg = 0;
 552:	4881                	li	a7,0
 554:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 558:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 55a:	2601                	sext.w	a2,a2
 55c:	00000517          	auipc	a0,0x0
 560:	57c50513          	addi	a0,a0,1404 # ad8 <digits>
 564:	883a                	mv	a6,a4
 566:	2705                	addiw	a4,a4,1
 568:	02c5f7bb          	remuw	a5,a1,a2
 56c:	1782                	slli	a5,a5,0x20
 56e:	9381                	srli	a5,a5,0x20
 570:	97aa                	add	a5,a5,a0
 572:	0007c783          	lbu	a5,0(a5)
 576:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 57a:	0005879b          	sext.w	a5,a1
 57e:	02c5d5bb          	divuw	a1,a1,a2
 582:	0685                	addi	a3,a3,1
 584:	fec7f0e3          	bgeu	a5,a2,564 <printint+0x2a>
  if(neg)
 588:	00088c63          	beqz	a7,5a0 <printint+0x66>
    buf[i++] = '-';
 58c:	fd070793          	addi	a5,a4,-48
 590:	00878733          	add	a4,a5,s0
 594:	02d00793          	li	a5,45
 598:	fef70823          	sb	a5,-16(a4)
 59c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5a0:	02e05863          	blez	a4,5d0 <printint+0x96>
 5a4:	fc040793          	addi	a5,s0,-64
 5a8:	00e78933          	add	s2,a5,a4
 5ac:	fff78993          	addi	s3,a5,-1
 5b0:	99ba                	add	s3,s3,a4
 5b2:	377d                	addiw	a4,a4,-1
 5b4:	1702                	slli	a4,a4,0x20
 5b6:	9301                	srli	a4,a4,0x20
 5b8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5bc:	fff94583          	lbu	a1,-1(s2)
 5c0:	8526                	mv	a0,s1
 5c2:	00000097          	auipc	ra,0x0
 5c6:	f56080e7          	jalr	-170(ra) # 518 <putc>
  while(--i >= 0)
 5ca:	197d                	addi	s2,s2,-1
 5cc:	ff3918e3          	bne	s2,s3,5bc <printint+0x82>
}
 5d0:	70e2                	ld	ra,56(sp)
 5d2:	7442                	ld	s0,48(sp)
 5d4:	74a2                	ld	s1,40(sp)
 5d6:	7902                	ld	s2,32(sp)
 5d8:	69e2                	ld	s3,24(sp)
 5da:	6121                	addi	sp,sp,64
 5dc:	8082                	ret
    x = -xx;
 5de:	40b005bb          	negw	a1,a1
    neg = 1;
 5e2:	4885                	li	a7,1
    x = -xx;
 5e4:	bf85                	j	554 <printint+0x1a>

00000000000005e6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5e6:	7119                	addi	sp,sp,-128
 5e8:	fc86                	sd	ra,120(sp)
 5ea:	f8a2                	sd	s0,112(sp)
 5ec:	f4a6                	sd	s1,104(sp)
 5ee:	f0ca                	sd	s2,96(sp)
 5f0:	ecce                	sd	s3,88(sp)
 5f2:	e8d2                	sd	s4,80(sp)
 5f4:	e4d6                	sd	s5,72(sp)
 5f6:	e0da                	sd	s6,64(sp)
 5f8:	fc5e                	sd	s7,56(sp)
 5fa:	f862                	sd	s8,48(sp)
 5fc:	f466                	sd	s9,40(sp)
 5fe:	f06a                	sd	s10,32(sp)
 600:	ec6e                	sd	s11,24(sp)
 602:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 604:	0005c903          	lbu	s2,0(a1)
 608:	18090f63          	beqz	s2,7a6 <vprintf+0x1c0>
 60c:	8aaa                	mv	s5,a0
 60e:	8b32                	mv	s6,a2
 610:	00158493          	addi	s1,a1,1
  state = 0;
 614:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 616:	02500a13          	li	s4,37
 61a:	4c55                	li	s8,21
 61c:	00000c97          	auipc	s9,0x0
 620:	464c8c93          	addi	s9,s9,1124 # a80 <malloc+0x1d6>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 624:	02800d93          	li	s11,40
  putc(fd, 'x');
 628:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 62a:	00000b97          	auipc	s7,0x0
 62e:	4aeb8b93          	addi	s7,s7,1198 # ad8 <digits>
 632:	a839                	j	650 <vprintf+0x6a>
        putc(fd, c);
 634:	85ca                	mv	a1,s2
 636:	8556                	mv	a0,s5
 638:	00000097          	auipc	ra,0x0
 63c:	ee0080e7          	jalr	-288(ra) # 518 <putc>
 640:	a019                	j	646 <vprintf+0x60>
    } else if(state == '%'){
 642:	01498d63          	beq	s3,s4,65c <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 646:	0485                	addi	s1,s1,1
 648:	fff4c903          	lbu	s2,-1(s1)
 64c:	14090d63          	beqz	s2,7a6 <vprintf+0x1c0>
    if(state == 0){
 650:	fe0999e3          	bnez	s3,642 <vprintf+0x5c>
      if(c == '%'){
 654:	ff4910e3          	bne	s2,s4,634 <vprintf+0x4e>
        state = '%';
 658:	89d2                	mv	s3,s4
 65a:	b7f5                	j	646 <vprintf+0x60>
      if(c == 'd'){
 65c:	11490c63          	beq	s2,s4,774 <vprintf+0x18e>
 660:	f9d9079b          	addiw	a5,s2,-99
 664:	0ff7f793          	zext.b	a5,a5
 668:	10fc6e63          	bltu	s8,a5,784 <vprintf+0x19e>
 66c:	f9d9079b          	addiw	a5,s2,-99
 670:	0ff7f713          	zext.b	a4,a5
 674:	10ec6863          	bltu	s8,a4,784 <vprintf+0x19e>
 678:	00271793          	slli	a5,a4,0x2
 67c:	97e6                	add	a5,a5,s9
 67e:	439c                	lw	a5,0(a5)
 680:	97e6                	add	a5,a5,s9
 682:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 684:	008b0913          	addi	s2,s6,8
 688:	4685                	li	a3,1
 68a:	4629                	li	a2,10
 68c:	000b2583          	lw	a1,0(s6)
 690:	8556                	mv	a0,s5
 692:	00000097          	auipc	ra,0x0
 696:	ea8080e7          	jalr	-344(ra) # 53a <printint>
 69a:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 69c:	4981                	li	s3,0
 69e:	b765                	j	646 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a0:	008b0913          	addi	s2,s6,8
 6a4:	4681                	li	a3,0
 6a6:	4629                	li	a2,10
 6a8:	000b2583          	lw	a1,0(s6)
 6ac:	8556                	mv	a0,s5
 6ae:	00000097          	auipc	ra,0x0
 6b2:	e8c080e7          	jalr	-372(ra) # 53a <printint>
 6b6:	8b4a                	mv	s6,s2
      state = 0;
 6b8:	4981                	li	s3,0
 6ba:	b771                	j	646 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6bc:	008b0913          	addi	s2,s6,8
 6c0:	4681                	li	a3,0
 6c2:	866a                	mv	a2,s10
 6c4:	000b2583          	lw	a1,0(s6)
 6c8:	8556                	mv	a0,s5
 6ca:	00000097          	auipc	ra,0x0
 6ce:	e70080e7          	jalr	-400(ra) # 53a <printint>
 6d2:	8b4a                	mv	s6,s2
      state = 0;
 6d4:	4981                	li	s3,0
 6d6:	bf85                	j	646 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6d8:	008b0793          	addi	a5,s6,8
 6dc:	f8f43423          	sd	a5,-120(s0)
 6e0:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6e4:	03000593          	li	a1,48
 6e8:	8556                	mv	a0,s5
 6ea:	00000097          	auipc	ra,0x0
 6ee:	e2e080e7          	jalr	-466(ra) # 518 <putc>
  putc(fd, 'x');
 6f2:	07800593          	li	a1,120
 6f6:	8556                	mv	a0,s5
 6f8:	00000097          	auipc	ra,0x0
 6fc:	e20080e7          	jalr	-480(ra) # 518 <putc>
 700:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 702:	03c9d793          	srli	a5,s3,0x3c
 706:	97de                	add	a5,a5,s7
 708:	0007c583          	lbu	a1,0(a5)
 70c:	8556                	mv	a0,s5
 70e:	00000097          	auipc	ra,0x0
 712:	e0a080e7          	jalr	-502(ra) # 518 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 716:	0992                	slli	s3,s3,0x4
 718:	397d                	addiw	s2,s2,-1
 71a:	fe0914e3          	bnez	s2,702 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 71e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 722:	4981                	li	s3,0
 724:	b70d                	j	646 <vprintf+0x60>
        s = va_arg(ap, char*);
 726:	008b0913          	addi	s2,s6,8
 72a:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 72e:	02098163          	beqz	s3,750 <vprintf+0x16a>
        while(*s != 0){
 732:	0009c583          	lbu	a1,0(s3)
 736:	c5ad                	beqz	a1,7a0 <vprintf+0x1ba>
          putc(fd, *s);
 738:	8556                	mv	a0,s5
 73a:	00000097          	auipc	ra,0x0
 73e:	dde080e7          	jalr	-546(ra) # 518 <putc>
          s++;
 742:	0985                	addi	s3,s3,1
        while(*s != 0){
 744:	0009c583          	lbu	a1,0(s3)
 748:	f9e5                	bnez	a1,738 <vprintf+0x152>
        s = va_arg(ap, char*);
 74a:	8b4a                	mv	s6,s2
      state = 0;
 74c:	4981                	li	s3,0
 74e:	bde5                	j	646 <vprintf+0x60>
          s = "(null)";
 750:	00000997          	auipc	s3,0x0
 754:	32898993          	addi	s3,s3,808 # a78 <malloc+0x1ce>
        while(*s != 0){
 758:	85ee                	mv	a1,s11
 75a:	bff9                	j	738 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 75c:	008b0913          	addi	s2,s6,8
 760:	000b4583          	lbu	a1,0(s6)
 764:	8556                	mv	a0,s5
 766:	00000097          	auipc	ra,0x0
 76a:	db2080e7          	jalr	-590(ra) # 518 <putc>
 76e:	8b4a                	mv	s6,s2
      state = 0;
 770:	4981                	li	s3,0
 772:	bdd1                	j	646 <vprintf+0x60>
        putc(fd, c);
 774:	85d2                	mv	a1,s4
 776:	8556                	mv	a0,s5
 778:	00000097          	auipc	ra,0x0
 77c:	da0080e7          	jalr	-608(ra) # 518 <putc>
      state = 0;
 780:	4981                	li	s3,0
 782:	b5d1                	j	646 <vprintf+0x60>
        putc(fd, '%');
 784:	85d2                	mv	a1,s4
 786:	8556                	mv	a0,s5
 788:	00000097          	auipc	ra,0x0
 78c:	d90080e7          	jalr	-624(ra) # 518 <putc>
        putc(fd, c);
 790:	85ca                	mv	a1,s2
 792:	8556                	mv	a0,s5
 794:	00000097          	auipc	ra,0x0
 798:	d84080e7          	jalr	-636(ra) # 518 <putc>
      state = 0;
 79c:	4981                	li	s3,0
 79e:	b565                	j	646 <vprintf+0x60>
        s = va_arg(ap, char*);
 7a0:	8b4a                	mv	s6,s2
      state = 0;
 7a2:	4981                	li	s3,0
 7a4:	b54d                	j	646 <vprintf+0x60>
    }
  }
}
 7a6:	70e6                	ld	ra,120(sp)
 7a8:	7446                	ld	s0,112(sp)
 7aa:	74a6                	ld	s1,104(sp)
 7ac:	7906                	ld	s2,96(sp)
 7ae:	69e6                	ld	s3,88(sp)
 7b0:	6a46                	ld	s4,80(sp)
 7b2:	6aa6                	ld	s5,72(sp)
 7b4:	6b06                	ld	s6,64(sp)
 7b6:	7be2                	ld	s7,56(sp)
 7b8:	7c42                	ld	s8,48(sp)
 7ba:	7ca2                	ld	s9,40(sp)
 7bc:	7d02                	ld	s10,32(sp)
 7be:	6de2                	ld	s11,24(sp)
 7c0:	6109                	addi	sp,sp,128
 7c2:	8082                	ret

00000000000007c4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7c4:	715d                	addi	sp,sp,-80
 7c6:	ec06                	sd	ra,24(sp)
 7c8:	e822                	sd	s0,16(sp)
 7ca:	1000                	addi	s0,sp,32
 7cc:	e010                	sd	a2,0(s0)
 7ce:	e414                	sd	a3,8(s0)
 7d0:	e818                	sd	a4,16(s0)
 7d2:	ec1c                	sd	a5,24(s0)
 7d4:	03043023          	sd	a6,32(s0)
 7d8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7dc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7e0:	8622                	mv	a2,s0
 7e2:	00000097          	auipc	ra,0x0
 7e6:	e04080e7          	jalr	-508(ra) # 5e6 <vprintf>
}
 7ea:	60e2                	ld	ra,24(sp)
 7ec:	6442                	ld	s0,16(sp)
 7ee:	6161                	addi	sp,sp,80
 7f0:	8082                	ret

00000000000007f2 <printf>:

void
printf(const char *fmt, ...)
{
 7f2:	711d                	addi	sp,sp,-96
 7f4:	ec06                	sd	ra,24(sp)
 7f6:	e822                	sd	s0,16(sp)
 7f8:	1000                	addi	s0,sp,32
 7fa:	e40c                	sd	a1,8(s0)
 7fc:	e810                	sd	a2,16(s0)
 7fe:	ec14                	sd	a3,24(s0)
 800:	f018                	sd	a4,32(s0)
 802:	f41c                	sd	a5,40(s0)
 804:	03043823          	sd	a6,48(s0)
 808:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 80c:	00840613          	addi	a2,s0,8
 810:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 814:	85aa                	mv	a1,a0
 816:	4505                	li	a0,1
 818:	00000097          	auipc	ra,0x0
 81c:	dce080e7          	jalr	-562(ra) # 5e6 <vprintf>
}
 820:	60e2                	ld	ra,24(sp)
 822:	6442                	ld	s0,16(sp)
 824:	6125                	addi	sp,sp,96
 826:	8082                	ret

0000000000000828 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 828:	1141                	addi	sp,sp,-16
 82a:	e422                	sd	s0,8(sp)
 82c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 82e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 832:	00000797          	auipc	a5,0x0
 836:	2be7b783          	ld	a5,702(a5) # af0 <freep>
 83a:	a02d                	j	864 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 83c:	4618                	lw	a4,8(a2)
 83e:	9f2d                	addw	a4,a4,a1
 840:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 844:	6398                	ld	a4,0(a5)
 846:	6310                	ld	a2,0(a4)
 848:	a83d                	j	886 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 84a:	ff852703          	lw	a4,-8(a0)
 84e:	9f31                	addw	a4,a4,a2
 850:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 852:	ff053683          	ld	a3,-16(a0)
 856:	a091                	j	89a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 858:	6398                	ld	a4,0(a5)
 85a:	00e7e463          	bltu	a5,a4,862 <free+0x3a>
 85e:	00e6ea63          	bltu	a3,a4,872 <free+0x4a>
{
 862:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 864:	fed7fae3          	bgeu	a5,a3,858 <free+0x30>
 868:	6398                	ld	a4,0(a5)
 86a:	00e6e463          	bltu	a3,a4,872 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 86e:	fee7eae3          	bltu	a5,a4,862 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 872:	ff852583          	lw	a1,-8(a0)
 876:	6390                	ld	a2,0(a5)
 878:	02059813          	slli	a6,a1,0x20
 87c:	01c85713          	srli	a4,a6,0x1c
 880:	9736                	add	a4,a4,a3
 882:	fae60de3          	beq	a2,a4,83c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 886:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 88a:	4790                	lw	a2,8(a5)
 88c:	02061593          	slli	a1,a2,0x20
 890:	01c5d713          	srli	a4,a1,0x1c
 894:	973e                	add	a4,a4,a5
 896:	fae68ae3          	beq	a3,a4,84a <free+0x22>
    p->s.ptr = bp->s.ptr;
 89a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 89c:	00000717          	auipc	a4,0x0
 8a0:	24f73a23          	sd	a5,596(a4) # af0 <freep>
}
 8a4:	6422                	ld	s0,8(sp)
 8a6:	0141                	addi	sp,sp,16
 8a8:	8082                	ret

00000000000008aa <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8aa:	7139                	addi	sp,sp,-64
 8ac:	fc06                	sd	ra,56(sp)
 8ae:	f822                	sd	s0,48(sp)
 8b0:	f426                	sd	s1,40(sp)
 8b2:	f04a                	sd	s2,32(sp)
 8b4:	ec4e                	sd	s3,24(sp)
 8b6:	e852                	sd	s4,16(sp)
 8b8:	e456                	sd	s5,8(sp)
 8ba:	e05a                	sd	s6,0(sp)
 8bc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8be:	02051493          	slli	s1,a0,0x20
 8c2:	9081                	srli	s1,s1,0x20
 8c4:	04bd                	addi	s1,s1,15
 8c6:	8091                	srli	s1,s1,0x4
 8c8:	0014899b          	addiw	s3,s1,1
 8cc:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8ce:	00000517          	auipc	a0,0x0
 8d2:	22253503          	ld	a0,546(a0) # af0 <freep>
 8d6:	c515                	beqz	a0,902 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8da:	4798                	lw	a4,8(a5)
 8dc:	02977f63          	bgeu	a4,s1,91a <malloc+0x70>
 8e0:	8a4e                	mv	s4,s3
 8e2:	0009871b          	sext.w	a4,s3
 8e6:	6685                	lui	a3,0x1
 8e8:	00d77363          	bgeu	a4,a3,8ee <malloc+0x44>
 8ec:	6a05                	lui	s4,0x1
 8ee:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8f2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8f6:	00000917          	auipc	s2,0x0
 8fa:	1fa90913          	addi	s2,s2,506 # af0 <freep>
  if(p == (char*)-1)
 8fe:	5afd                	li	s5,-1
 900:	a895                	j	974 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 902:	00000797          	auipc	a5,0x0
 906:	1f678793          	addi	a5,a5,502 # af8 <base>
 90a:	00000717          	auipc	a4,0x0
 90e:	1ef73323          	sd	a5,486(a4) # af0 <freep>
 912:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 914:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 918:	b7e1                	j	8e0 <malloc+0x36>
      if(p->s.size == nunits)
 91a:	02e48c63          	beq	s1,a4,952 <malloc+0xa8>
        p->s.size -= nunits;
 91e:	4137073b          	subw	a4,a4,s3
 922:	c798                	sw	a4,8(a5)
        p += p->s.size;
 924:	02071693          	slli	a3,a4,0x20
 928:	01c6d713          	srli	a4,a3,0x1c
 92c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 92e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 932:	00000717          	auipc	a4,0x0
 936:	1aa73f23          	sd	a0,446(a4) # af0 <freep>
      return (void*)(p + 1);
 93a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 93e:	70e2                	ld	ra,56(sp)
 940:	7442                	ld	s0,48(sp)
 942:	74a2                	ld	s1,40(sp)
 944:	7902                	ld	s2,32(sp)
 946:	69e2                	ld	s3,24(sp)
 948:	6a42                	ld	s4,16(sp)
 94a:	6aa2                	ld	s5,8(sp)
 94c:	6b02                	ld	s6,0(sp)
 94e:	6121                	addi	sp,sp,64
 950:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 952:	6398                	ld	a4,0(a5)
 954:	e118                	sd	a4,0(a0)
 956:	bff1                	j	932 <malloc+0x88>
  hp->s.size = nu;
 958:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 95c:	0541                	addi	a0,a0,16
 95e:	00000097          	auipc	ra,0x0
 962:	eca080e7          	jalr	-310(ra) # 828 <free>
  return freep;
 966:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 96a:	d971                	beqz	a0,93e <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 96c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 96e:	4798                	lw	a4,8(a5)
 970:	fa9775e3          	bgeu	a4,s1,91a <malloc+0x70>
    if(p == freep)
 974:	00093703          	ld	a4,0(s2)
 978:	853e                	mv	a0,a5
 97a:	fef719e3          	bne	a4,a5,96c <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 97e:	8552                	mv	a0,s4
 980:	00000097          	auipc	ra,0x0
 984:	b80080e7          	jalr	-1152(ra) # 500 <sbrk>
  if(p == (char*)-1)
 988:	fd5518e3          	bne	a0,s5,958 <malloc+0xae>
        return 0;
 98c:	4501                	li	a0,0
 98e:	bf45                	j	93e <malloc+0x94>
