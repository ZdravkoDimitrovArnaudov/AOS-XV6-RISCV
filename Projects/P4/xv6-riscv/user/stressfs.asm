
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dc010113          	addi	sp,sp,-576
   4:	22113c23          	sd	ra,568(sp)
   8:	22813823          	sd	s0,560(sp)
   c:	0480                	addi	s0,sp,576
   e:	87aa                	mv	a5,a0
  10:	dcb43023          	sd	a1,-576(s0)
  14:	dcf42623          	sw	a5,-564(s0)
  int fd, i;
  char path[] = "stressfs0";
  18:	00001797          	auipc	a5,0x1
  1c:	fa878793          	addi	a5,a5,-88 # fc0 <lock_init+0x42>
  20:	6398                	ld	a4,0(a5)
  22:	fce43c23          	sd	a4,-40(s0)
  26:	0087d783          	lhu	a5,8(a5)
  2a:	fef41023          	sh	a5,-32(s0)
  char data[512];

  printf("stressfs starting\n");
  2e:	00001517          	auipc	a0,0x1
  32:	f6250513          	addi	a0,a0,-158 # f90 <lock_init+0x12>
  36:	00001097          	auipc	ra,0x1
  3a:	b1e080e7          	jalr	-1250(ra) # b54 <printf>
  memset(data, 'a', sizeof(data));
  3e:	dd840793          	addi	a5,s0,-552
  42:	20000613          	li	a2,512
  46:	06100593          	li	a1,97
  4a:	853e                	mv	a0,a5
  4c:	00000097          	auipc	ra,0x0
  50:	224080e7          	jalr	548(ra) # 270 <memset>

  for(i = 0; i < 4; i++)
  54:	fe042623          	sw	zero,-20(s0)
  58:	a829                	j	72 <main+0x72>
    if(fork() > 0)
  5a:	00000097          	auipc	ra,0x0
  5e:	5ba080e7          	jalr	1466(ra) # 614 <fork>
  62:	87aa                	mv	a5,a0
  64:	00f04f63          	bgtz	a5,82 <main+0x82>
  for(i = 0; i < 4; i++)
  68:	fec42783          	lw	a5,-20(s0)
  6c:	2785                	addiw	a5,a5,1
  6e:	fef42623          	sw	a5,-20(s0)
  72:	fec42783          	lw	a5,-20(s0)
  76:	0007871b          	sext.w	a4,a5
  7a:	478d                	li	a5,3
  7c:	fce7dfe3          	bge	a5,a4,5a <main+0x5a>
  80:	a011                	j	84 <main+0x84>
      break;
  82:	0001                	nop

  printf("write %d\n", i);
  84:	fec42783          	lw	a5,-20(s0)
  88:	85be                	mv	a1,a5
  8a:	00001517          	auipc	a0,0x1
  8e:	f1e50513          	addi	a0,a0,-226 # fa8 <lock_init+0x2a>
  92:	00001097          	auipc	ra,0x1
  96:	ac2080e7          	jalr	-1342(ra) # b54 <printf>

  path[8] += i;
  9a:	fe044703          	lbu	a4,-32(s0)
  9e:	fec42783          	lw	a5,-20(s0)
  a2:	0ff7f793          	zext.b	a5,a5
  a6:	9fb9                	addw	a5,a5,a4
  a8:	0ff7f793          	zext.b	a5,a5
  ac:	fef40023          	sb	a5,-32(s0)
  fd = open(path, O_CREATE | O_RDWR);
  b0:	fd840793          	addi	a5,s0,-40
  b4:	20200593          	li	a1,514
  b8:	853e                	mv	a0,a5
  ba:	00000097          	auipc	ra,0x0
  be:	5a2080e7          	jalr	1442(ra) # 65c <open>
  c2:	87aa                	mv	a5,a0
  c4:	fef42423          	sw	a5,-24(s0)
  for(i = 0; i < 20; i++)
  c8:	fe042623          	sw	zero,-20(s0)
  cc:	a015                	j	f0 <main+0xf0>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  ce:	dd840713          	addi	a4,s0,-552
  d2:	fe842783          	lw	a5,-24(s0)
  d6:	20000613          	li	a2,512
  da:	85ba                	mv	a1,a4
  dc:	853e                	mv	a0,a5
  de:	00000097          	auipc	ra,0x0
  e2:	55e080e7          	jalr	1374(ra) # 63c <write>
  for(i = 0; i < 20; i++)
  e6:	fec42783          	lw	a5,-20(s0)
  ea:	2785                	addiw	a5,a5,1
  ec:	fef42623          	sw	a5,-20(s0)
  f0:	fec42783          	lw	a5,-20(s0)
  f4:	0007871b          	sext.w	a4,a5
  f8:	47cd                	li	a5,19
  fa:	fce7dae3          	bge	a5,a4,ce <main+0xce>
  close(fd);
  fe:	fe842783          	lw	a5,-24(s0)
 102:	853e                	mv	a0,a5
 104:	00000097          	auipc	ra,0x0
 108:	540080e7          	jalr	1344(ra) # 644 <close>

  printf("read\n");
 10c:	00001517          	auipc	a0,0x1
 110:	eac50513          	addi	a0,a0,-340 # fb8 <lock_init+0x3a>
 114:	00001097          	auipc	ra,0x1
 118:	a40080e7          	jalr	-1472(ra) # b54 <printf>

  fd = open(path, O_RDONLY);
 11c:	fd840793          	addi	a5,s0,-40
 120:	4581                	li	a1,0
 122:	853e                	mv	a0,a5
 124:	00000097          	auipc	ra,0x0
 128:	538080e7          	jalr	1336(ra) # 65c <open>
 12c:	87aa                	mv	a5,a0
 12e:	fef42423          	sw	a5,-24(s0)
  for (i = 0; i < 20; i++)
 132:	fe042623          	sw	zero,-20(s0)
 136:	a015                	j	15a <main+0x15a>
    read(fd, data, sizeof(data));
 138:	dd840713          	addi	a4,s0,-552
 13c:	fe842783          	lw	a5,-24(s0)
 140:	20000613          	li	a2,512
 144:	85ba                	mv	a1,a4
 146:	853e                	mv	a0,a5
 148:	00000097          	auipc	ra,0x0
 14c:	4ec080e7          	jalr	1260(ra) # 634 <read>
  for (i = 0; i < 20; i++)
 150:	fec42783          	lw	a5,-20(s0)
 154:	2785                	addiw	a5,a5,1
 156:	fef42623          	sw	a5,-20(s0)
 15a:	fec42783          	lw	a5,-20(s0)
 15e:	0007871b          	sext.w	a4,a5
 162:	47cd                	li	a5,19
 164:	fce7dae3          	bge	a5,a4,138 <main+0x138>
  close(fd);
 168:	fe842783          	lw	a5,-24(s0)
 16c:	853e                	mv	a0,a5
 16e:	00000097          	auipc	ra,0x0
 172:	4d6080e7          	jalr	1238(ra) # 644 <close>

  wait(0);
 176:	4501                	li	a0,0
 178:	00000097          	auipc	ra,0x0
 17c:	4ac080e7          	jalr	1196(ra) # 624 <wait>

  exit(0);
 180:	4501                	li	a0,0
 182:	00000097          	auipc	ra,0x0
 186:	49a080e7          	jalr	1178(ra) # 61c <exit>

000000000000018a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 18a:	7179                	addi	sp,sp,-48
 18c:	f422                	sd	s0,40(sp)
 18e:	1800                	addi	s0,sp,48
 190:	fca43c23          	sd	a0,-40(s0)
 194:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 198:	fd843783          	ld	a5,-40(s0)
 19c:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 1a0:	0001                	nop
 1a2:	fd043703          	ld	a4,-48(s0)
 1a6:	00170793          	addi	a5,a4,1
 1aa:	fcf43823          	sd	a5,-48(s0)
 1ae:	fd843783          	ld	a5,-40(s0)
 1b2:	00178693          	addi	a3,a5,1
 1b6:	fcd43c23          	sd	a3,-40(s0)
 1ba:	00074703          	lbu	a4,0(a4)
 1be:	00e78023          	sb	a4,0(a5)
 1c2:	0007c783          	lbu	a5,0(a5)
 1c6:	fff1                	bnez	a5,1a2 <strcpy+0x18>
    ;
  return os;
 1c8:	fe843783          	ld	a5,-24(s0)
}
 1cc:	853e                	mv	a0,a5
 1ce:	7422                	ld	s0,40(sp)
 1d0:	6145                	addi	sp,sp,48
 1d2:	8082                	ret

00000000000001d4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d4:	1101                	addi	sp,sp,-32
 1d6:	ec22                	sd	s0,24(sp)
 1d8:	1000                	addi	s0,sp,32
 1da:	fea43423          	sd	a0,-24(s0)
 1de:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 1e2:	a819                	j	1f8 <strcmp+0x24>
    p++, q++;
 1e4:	fe843783          	ld	a5,-24(s0)
 1e8:	0785                	addi	a5,a5,1
 1ea:	fef43423          	sd	a5,-24(s0)
 1ee:	fe043783          	ld	a5,-32(s0)
 1f2:	0785                	addi	a5,a5,1
 1f4:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 1f8:	fe843783          	ld	a5,-24(s0)
 1fc:	0007c783          	lbu	a5,0(a5)
 200:	cb99                	beqz	a5,216 <strcmp+0x42>
 202:	fe843783          	ld	a5,-24(s0)
 206:	0007c703          	lbu	a4,0(a5)
 20a:	fe043783          	ld	a5,-32(s0)
 20e:	0007c783          	lbu	a5,0(a5)
 212:	fcf709e3          	beq	a4,a5,1e4 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 216:	fe843783          	ld	a5,-24(s0)
 21a:	0007c783          	lbu	a5,0(a5)
 21e:	0007871b          	sext.w	a4,a5
 222:	fe043783          	ld	a5,-32(s0)
 226:	0007c783          	lbu	a5,0(a5)
 22a:	2781                	sext.w	a5,a5
 22c:	40f707bb          	subw	a5,a4,a5
 230:	2781                	sext.w	a5,a5
}
 232:	853e                	mv	a0,a5
 234:	6462                	ld	s0,24(sp)
 236:	6105                	addi	sp,sp,32
 238:	8082                	ret

000000000000023a <strlen>:

uint
strlen(const char *s)
{
 23a:	7179                	addi	sp,sp,-48
 23c:	f422                	sd	s0,40(sp)
 23e:	1800                	addi	s0,sp,48
 240:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 244:	fe042623          	sw	zero,-20(s0)
 248:	a031                	j	254 <strlen+0x1a>
 24a:	fec42783          	lw	a5,-20(s0)
 24e:	2785                	addiw	a5,a5,1
 250:	fef42623          	sw	a5,-20(s0)
 254:	fec42783          	lw	a5,-20(s0)
 258:	fd843703          	ld	a4,-40(s0)
 25c:	97ba                	add	a5,a5,a4
 25e:	0007c783          	lbu	a5,0(a5)
 262:	f7e5                	bnez	a5,24a <strlen+0x10>
    ;
  return n;
 264:	fec42783          	lw	a5,-20(s0)
}
 268:	853e                	mv	a0,a5
 26a:	7422                	ld	s0,40(sp)
 26c:	6145                	addi	sp,sp,48
 26e:	8082                	ret

0000000000000270 <memset>:

void*
memset(void *dst, int c, uint n)
{
 270:	7179                	addi	sp,sp,-48
 272:	f422                	sd	s0,40(sp)
 274:	1800                	addi	s0,sp,48
 276:	fca43c23          	sd	a0,-40(s0)
 27a:	87ae                	mv	a5,a1
 27c:	8732                	mv	a4,a2
 27e:	fcf42a23          	sw	a5,-44(s0)
 282:	87ba                	mv	a5,a4
 284:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 288:	fd843783          	ld	a5,-40(s0)
 28c:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 290:	fe042623          	sw	zero,-20(s0)
 294:	a00d                	j	2b6 <memset+0x46>
    cdst[i] = c;
 296:	fec42783          	lw	a5,-20(s0)
 29a:	fe043703          	ld	a4,-32(s0)
 29e:	97ba                	add	a5,a5,a4
 2a0:	fd442703          	lw	a4,-44(s0)
 2a4:	0ff77713          	zext.b	a4,a4
 2a8:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 2ac:	fec42783          	lw	a5,-20(s0)
 2b0:	2785                	addiw	a5,a5,1
 2b2:	fef42623          	sw	a5,-20(s0)
 2b6:	fec42703          	lw	a4,-20(s0)
 2ba:	fd042783          	lw	a5,-48(s0)
 2be:	2781                	sext.w	a5,a5
 2c0:	fcf76be3          	bltu	a4,a5,296 <memset+0x26>
  }
  return dst;
 2c4:	fd843783          	ld	a5,-40(s0)
}
 2c8:	853e                	mv	a0,a5
 2ca:	7422                	ld	s0,40(sp)
 2cc:	6145                	addi	sp,sp,48
 2ce:	8082                	ret

00000000000002d0 <strchr>:

char*
strchr(const char *s, char c)
{
 2d0:	1101                	addi	sp,sp,-32
 2d2:	ec22                	sd	s0,24(sp)
 2d4:	1000                	addi	s0,sp,32
 2d6:	fea43423          	sd	a0,-24(s0)
 2da:	87ae                	mv	a5,a1
 2dc:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 2e0:	a01d                	j	306 <strchr+0x36>
    if(*s == c)
 2e2:	fe843783          	ld	a5,-24(s0)
 2e6:	0007c703          	lbu	a4,0(a5)
 2ea:	fe744783          	lbu	a5,-25(s0)
 2ee:	0ff7f793          	zext.b	a5,a5
 2f2:	00e79563          	bne	a5,a4,2fc <strchr+0x2c>
      return (char*)s;
 2f6:	fe843783          	ld	a5,-24(s0)
 2fa:	a821                	j	312 <strchr+0x42>
  for(; *s; s++)
 2fc:	fe843783          	ld	a5,-24(s0)
 300:	0785                	addi	a5,a5,1
 302:	fef43423          	sd	a5,-24(s0)
 306:	fe843783          	ld	a5,-24(s0)
 30a:	0007c783          	lbu	a5,0(a5)
 30e:	fbf1                	bnez	a5,2e2 <strchr+0x12>
  return 0;
 310:	4781                	li	a5,0
}
 312:	853e                	mv	a0,a5
 314:	6462                	ld	s0,24(sp)
 316:	6105                	addi	sp,sp,32
 318:	8082                	ret

000000000000031a <gets>:

char*
gets(char *buf, int max)
{
 31a:	7179                	addi	sp,sp,-48
 31c:	f406                	sd	ra,40(sp)
 31e:	f022                	sd	s0,32(sp)
 320:	1800                	addi	s0,sp,48
 322:	fca43c23          	sd	a0,-40(s0)
 326:	87ae                	mv	a5,a1
 328:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 32c:	fe042623          	sw	zero,-20(s0)
 330:	a8a1                	j	388 <gets+0x6e>
    cc = read(0, &c, 1);
 332:	fe740793          	addi	a5,s0,-25
 336:	4605                	li	a2,1
 338:	85be                	mv	a1,a5
 33a:	4501                	li	a0,0
 33c:	00000097          	auipc	ra,0x0
 340:	2f8080e7          	jalr	760(ra) # 634 <read>
 344:	87aa                	mv	a5,a0
 346:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 34a:	fe842783          	lw	a5,-24(s0)
 34e:	2781                	sext.w	a5,a5
 350:	04f05763          	blez	a5,39e <gets+0x84>
      break;
    buf[i++] = c;
 354:	fec42783          	lw	a5,-20(s0)
 358:	0017871b          	addiw	a4,a5,1
 35c:	fee42623          	sw	a4,-20(s0)
 360:	873e                	mv	a4,a5
 362:	fd843783          	ld	a5,-40(s0)
 366:	97ba                	add	a5,a5,a4
 368:	fe744703          	lbu	a4,-25(s0)
 36c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 370:	fe744783          	lbu	a5,-25(s0)
 374:	873e                	mv	a4,a5
 376:	47a9                	li	a5,10
 378:	02f70463          	beq	a4,a5,3a0 <gets+0x86>
 37c:	fe744783          	lbu	a5,-25(s0)
 380:	873e                	mv	a4,a5
 382:	47b5                	li	a5,13
 384:	00f70e63          	beq	a4,a5,3a0 <gets+0x86>
  for(i=0; i+1 < max; ){
 388:	fec42783          	lw	a5,-20(s0)
 38c:	2785                	addiw	a5,a5,1
 38e:	0007871b          	sext.w	a4,a5
 392:	fd442783          	lw	a5,-44(s0)
 396:	2781                	sext.w	a5,a5
 398:	f8f74de3          	blt	a4,a5,332 <gets+0x18>
 39c:	a011                	j	3a0 <gets+0x86>
      break;
 39e:	0001                	nop
      break;
  }
  buf[i] = '\0';
 3a0:	fec42783          	lw	a5,-20(s0)
 3a4:	fd843703          	ld	a4,-40(s0)
 3a8:	97ba                	add	a5,a5,a4
 3aa:	00078023          	sb	zero,0(a5)
  return buf;
 3ae:	fd843783          	ld	a5,-40(s0)
}
 3b2:	853e                	mv	a0,a5
 3b4:	70a2                	ld	ra,40(sp)
 3b6:	7402                	ld	s0,32(sp)
 3b8:	6145                	addi	sp,sp,48
 3ba:	8082                	ret

00000000000003bc <stat>:

int
stat(const char *n, struct stat *st)
{
 3bc:	7179                	addi	sp,sp,-48
 3be:	f406                	sd	ra,40(sp)
 3c0:	f022                	sd	s0,32(sp)
 3c2:	1800                	addi	s0,sp,48
 3c4:	fca43c23          	sd	a0,-40(s0)
 3c8:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3cc:	4581                	li	a1,0
 3ce:	fd843503          	ld	a0,-40(s0)
 3d2:	00000097          	auipc	ra,0x0
 3d6:	28a080e7          	jalr	650(ra) # 65c <open>
 3da:	87aa                	mv	a5,a0
 3dc:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 3e0:	fec42783          	lw	a5,-20(s0)
 3e4:	2781                	sext.w	a5,a5
 3e6:	0007d463          	bgez	a5,3ee <stat+0x32>
    return -1;
 3ea:	57fd                	li	a5,-1
 3ec:	a035                	j	418 <stat+0x5c>
  r = fstat(fd, st);
 3ee:	fec42783          	lw	a5,-20(s0)
 3f2:	fd043583          	ld	a1,-48(s0)
 3f6:	853e                	mv	a0,a5
 3f8:	00000097          	auipc	ra,0x0
 3fc:	27c080e7          	jalr	636(ra) # 674 <fstat>
 400:	87aa                	mv	a5,a0
 402:	fef42423          	sw	a5,-24(s0)
  close(fd);
 406:	fec42783          	lw	a5,-20(s0)
 40a:	853e                	mv	a0,a5
 40c:	00000097          	auipc	ra,0x0
 410:	238080e7          	jalr	568(ra) # 644 <close>
  return r;
 414:	fe842783          	lw	a5,-24(s0)
}
 418:	853e                	mv	a0,a5
 41a:	70a2                	ld	ra,40(sp)
 41c:	7402                	ld	s0,32(sp)
 41e:	6145                	addi	sp,sp,48
 420:	8082                	ret

0000000000000422 <atoi>:

int
atoi(const char *s)
{
 422:	7179                	addi	sp,sp,-48
 424:	f422                	sd	s0,40(sp)
 426:	1800                	addi	s0,sp,48
 428:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 42c:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 430:	a81d                	j	466 <atoi+0x44>
    n = n*10 + *s++ - '0';
 432:	fec42783          	lw	a5,-20(s0)
 436:	873e                	mv	a4,a5
 438:	87ba                	mv	a5,a4
 43a:	0027979b          	slliw	a5,a5,0x2
 43e:	9fb9                	addw	a5,a5,a4
 440:	0017979b          	slliw	a5,a5,0x1
 444:	0007871b          	sext.w	a4,a5
 448:	fd843783          	ld	a5,-40(s0)
 44c:	00178693          	addi	a3,a5,1
 450:	fcd43c23          	sd	a3,-40(s0)
 454:	0007c783          	lbu	a5,0(a5)
 458:	2781                	sext.w	a5,a5
 45a:	9fb9                	addw	a5,a5,a4
 45c:	2781                	sext.w	a5,a5
 45e:	fd07879b          	addiw	a5,a5,-48
 462:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 466:	fd843783          	ld	a5,-40(s0)
 46a:	0007c783          	lbu	a5,0(a5)
 46e:	873e                	mv	a4,a5
 470:	02f00793          	li	a5,47
 474:	00e7fb63          	bgeu	a5,a4,48a <atoi+0x68>
 478:	fd843783          	ld	a5,-40(s0)
 47c:	0007c783          	lbu	a5,0(a5)
 480:	873e                	mv	a4,a5
 482:	03900793          	li	a5,57
 486:	fae7f6e3          	bgeu	a5,a4,432 <atoi+0x10>
  return n;
 48a:	fec42783          	lw	a5,-20(s0)
}
 48e:	853e                	mv	a0,a5
 490:	7422                	ld	s0,40(sp)
 492:	6145                	addi	sp,sp,48
 494:	8082                	ret

0000000000000496 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 496:	7139                	addi	sp,sp,-64
 498:	fc22                	sd	s0,56(sp)
 49a:	0080                	addi	s0,sp,64
 49c:	fca43c23          	sd	a0,-40(s0)
 4a0:	fcb43823          	sd	a1,-48(s0)
 4a4:	87b2                	mv	a5,a2
 4a6:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 4aa:	fd843783          	ld	a5,-40(s0)
 4ae:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 4b2:	fd043783          	ld	a5,-48(s0)
 4b6:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 4ba:	fe043703          	ld	a4,-32(s0)
 4be:	fe843783          	ld	a5,-24(s0)
 4c2:	02e7fc63          	bgeu	a5,a4,4fa <memmove+0x64>
    while(n-- > 0)
 4c6:	a00d                	j	4e8 <memmove+0x52>
      *dst++ = *src++;
 4c8:	fe043703          	ld	a4,-32(s0)
 4cc:	00170793          	addi	a5,a4,1
 4d0:	fef43023          	sd	a5,-32(s0)
 4d4:	fe843783          	ld	a5,-24(s0)
 4d8:	00178693          	addi	a3,a5,1
 4dc:	fed43423          	sd	a3,-24(s0)
 4e0:	00074703          	lbu	a4,0(a4)
 4e4:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4e8:	fcc42783          	lw	a5,-52(s0)
 4ec:	fff7871b          	addiw	a4,a5,-1
 4f0:	fce42623          	sw	a4,-52(s0)
 4f4:	fcf04ae3          	bgtz	a5,4c8 <memmove+0x32>
 4f8:	a891                	j	54c <memmove+0xb6>
  } else {
    dst += n;
 4fa:	fcc42783          	lw	a5,-52(s0)
 4fe:	fe843703          	ld	a4,-24(s0)
 502:	97ba                	add	a5,a5,a4
 504:	fef43423          	sd	a5,-24(s0)
    src += n;
 508:	fcc42783          	lw	a5,-52(s0)
 50c:	fe043703          	ld	a4,-32(s0)
 510:	97ba                	add	a5,a5,a4
 512:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 516:	a01d                	j	53c <memmove+0xa6>
      *--dst = *--src;
 518:	fe043783          	ld	a5,-32(s0)
 51c:	17fd                	addi	a5,a5,-1
 51e:	fef43023          	sd	a5,-32(s0)
 522:	fe843783          	ld	a5,-24(s0)
 526:	17fd                	addi	a5,a5,-1
 528:	fef43423          	sd	a5,-24(s0)
 52c:	fe043783          	ld	a5,-32(s0)
 530:	0007c703          	lbu	a4,0(a5)
 534:	fe843783          	ld	a5,-24(s0)
 538:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 53c:	fcc42783          	lw	a5,-52(s0)
 540:	fff7871b          	addiw	a4,a5,-1
 544:	fce42623          	sw	a4,-52(s0)
 548:	fcf048e3          	bgtz	a5,518 <memmove+0x82>
  }
  return vdst;
 54c:	fd843783          	ld	a5,-40(s0)
}
 550:	853e                	mv	a0,a5
 552:	7462                	ld	s0,56(sp)
 554:	6121                	addi	sp,sp,64
 556:	8082                	ret

0000000000000558 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 558:	7139                	addi	sp,sp,-64
 55a:	fc22                	sd	s0,56(sp)
 55c:	0080                	addi	s0,sp,64
 55e:	fca43c23          	sd	a0,-40(s0)
 562:	fcb43823          	sd	a1,-48(s0)
 566:	87b2                	mv	a5,a2
 568:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 56c:	fd843783          	ld	a5,-40(s0)
 570:	fef43423          	sd	a5,-24(s0)
 574:	fd043783          	ld	a5,-48(s0)
 578:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 57c:	a0a1                	j	5c4 <memcmp+0x6c>
    if (*p1 != *p2) {
 57e:	fe843783          	ld	a5,-24(s0)
 582:	0007c703          	lbu	a4,0(a5)
 586:	fe043783          	ld	a5,-32(s0)
 58a:	0007c783          	lbu	a5,0(a5)
 58e:	02f70163          	beq	a4,a5,5b0 <memcmp+0x58>
      return *p1 - *p2;
 592:	fe843783          	ld	a5,-24(s0)
 596:	0007c783          	lbu	a5,0(a5)
 59a:	0007871b          	sext.w	a4,a5
 59e:	fe043783          	ld	a5,-32(s0)
 5a2:	0007c783          	lbu	a5,0(a5)
 5a6:	2781                	sext.w	a5,a5
 5a8:	40f707bb          	subw	a5,a4,a5
 5ac:	2781                	sext.w	a5,a5
 5ae:	a01d                	j	5d4 <memcmp+0x7c>
    }
    p1++;
 5b0:	fe843783          	ld	a5,-24(s0)
 5b4:	0785                	addi	a5,a5,1
 5b6:	fef43423          	sd	a5,-24(s0)
    p2++;
 5ba:	fe043783          	ld	a5,-32(s0)
 5be:	0785                	addi	a5,a5,1
 5c0:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 5c4:	fcc42783          	lw	a5,-52(s0)
 5c8:	fff7871b          	addiw	a4,a5,-1
 5cc:	fce42623          	sw	a4,-52(s0)
 5d0:	f7dd                	bnez	a5,57e <memcmp+0x26>
  }
  return 0;
 5d2:	4781                	li	a5,0
}
 5d4:	853e                	mv	a0,a5
 5d6:	7462                	ld	s0,56(sp)
 5d8:	6121                	addi	sp,sp,64
 5da:	8082                	ret

00000000000005dc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5dc:	7179                	addi	sp,sp,-48
 5de:	f406                	sd	ra,40(sp)
 5e0:	f022                	sd	s0,32(sp)
 5e2:	1800                	addi	s0,sp,48
 5e4:	fea43423          	sd	a0,-24(s0)
 5e8:	feb43023          	sd	a1,-32(s0)
 5ec:	87b2                	mv	a5,a2
 5ee:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 5f2:	fdc42783          	lw	a5,-36(s0)
 5f6:	863e                	mv	a2,a5
 5f8:	fe043583          	ld	a1,-32(s0)
 5fc:	fe843503          	ld	a0,-24(s0)
 600:	00000097          	auipc	ra,0x0
 604:	e96080e7          	jalr	-362(ra) # 496 <memmove>
 608:	87aa                	mv	a5,a0
}
 60a:	853e                	mv	a0,a5
 60c:	70a2                	ld	ra,40(sp)
 60e:	7402                	ld	s0,32(sp)
 610:	6145                	addi	sp,sp,48
 612:	8082                	ret

0000000000000614 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 614:	4885                	li	a7,1
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <exit>:
.global exit
exit:
 li a7, SYS_exit
 61c:	4889                	li	a7,2
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <wait>:
.global wait
wait:
 li a7, SYS_wait
 624:	488d                	li	a7,3
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 62c:	4891                	li	a7,4
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <read>:
.global read
read:
 li a7, SYS_read
 634:	4895                	li	a7,5
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <write>:
.global write
write:
 li a7, SYS_write
 63c:	48c1                	li	a7,16
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <close>:
.global close
close:
 li a7, SYS_close
 644:	48d5                	li	a7,21
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <kill>:
.global kill
kill:
 li a7, SYS_kill
 64c:	4899                	li	a7,6
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <exec>:
.global exec
exec:
 li a7, SYS_exec
 654:	489d                	li	a7,7
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <open>:
.global open
open:
 li a7, SYS_open
 65c:	48bd                	li	a7,15
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 664:	48c5                	li	a7,17
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 66c:	48c9                	li	a7,18
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 674:	48a1                	li	a7,8
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <link>:
.global link
link:
 li a7, SYS_link
 67c:	48cd                	li	a7,19
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 684:	48d1                	li	a7,20
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 68c:	48a5                	li	a7,9
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <dup>:
.global dup
dup:
 li a7, SYS_dup
 694:	48a9                	li	a7,10
 ecall
 696:	00000073          	ecall
 ret
 69a:	8082                	ret

000000000000069c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 69c:	48ad                	li	a7,11
 ecall
 69e:	00000073          	ecall
 ret
 6a2:	8082                	ret

00000000000006a4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6a4:	48b1                	li	a7,12
 ecall
 6a6:	00000073          	ecall
 ret
 6aa:	8082                	ret

00000000000006ac <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6ac:	48b5                	li	a7,13
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6b4:	48b9                	li	a7,14
 ecall
 6b6:	00000073          	ecall
 ret
 6ba:	8082                	ret

00000000000006bc <clone>:
.global clone
clone:
 li a7, SYS_clone
 6bc:	48d9                	li	a7,22
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <join>:
.global join
join:
 li a7, SYS_join
 6c4:	48dd                	li	a7,23
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6cc:	1101                	addi	sp,sp,-32
 6ce:	ec06                	sd	ra,24(sp)
 6d0:	e822                	sd	s0,16(sp)
 6d2:	1000                	addi	s0,sp,32
 6d4:	87aa                	mv	a5,a0
 6d6:	872e                	mv	a4,a1
 6d8:	fef42623          	sw	a5,-20(s0)
 6dc:	87ba                	mv	a5,a4
 6de:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 6e2:	feb40713          	addi	a4,s0,-21
 6e6:	fec42783          	lw	a5,-20(s0)
 6ea:	4605                	li	a2,1
 6ec:	85ba                	mv	a1,a4
 6ee:	853e                	mv	a0,a5
 6f0:	00000097          	auipc	ra,0x0
 6f4:	f4c080e7          	jalr	-180(ra) # 63c <write>
}
 6f8:	0001                	nop
 6fa:	60e2                	ld	ra,24(sp)
 6fc:	6442                	ld	s0,16(sp)
 6fe:	6105                	addi	sp,sp,32
 700:	8082                	ret

0000000000000702 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 702:	7139                	addi	sp,sp,-64
 704:	fc06                	sd	ra,56(sp)
 706:	f822                	sd	s0,48(sp)
 708:	0080                	addi	s0,sp,64
 70a:	87aa                	mv	a5,a0
 70c:	8736                	mv	a4,a3
 70e:	fcf42623          	sw	a5,-52(s0)
 712:	87ae                	mv	a5,a1
 714:	fcf42423          	sw	a5,-56(s0)
 718:	87b2                	mv	a5,a2
 71a:	fcf42223          	sw	a5,-60(s0)
 71e:	87ba                	mv	a5,a4
 720:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 724:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 728:	fc042783          	lw	a5,-64(s0)
 72c:	2781                	sext.w	a5,a5
 72e:	c38d                	beqz	a5,750 <printint+0x4e>
 730:	fc842783          	lw	a5,-56(s0)
 734:	2781                	sext.w	a5,a5
 736:	0007dd63          	bgez	a5,750 <printint+0x4e>
    neg = 1;
 73a:	4785                	li	a5,1
 73c:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 740:	fc842783          	lw	a5,-56(s0)
 744:	40f007bb          	negw	a5,a5
 748:	2781                	sext.w	a5,a5
 74a:	fef42223          	sw	a5,-28(s0)
 74e:	a029                	j	758 <printint+0x56>
  } else {
    x = xx;
 750:	fc842783          	lw	a5,-56(s0)
 754:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 758:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 75c:	fc442783          	lw	a5,-60(s0)
 760:	fe442703          	lw	a4,-28(s0)
 764:	02f777bb          	remuw	a5,a4,a5
 768:	0007861b          	sext.w	a2,a5
 76c:	fec42783          	lw	a5,-20(s0)
 770:	0017871b          	addiw	a4,a5,1
 774:	fee42623          	sw	a4,-20(s0)
 778:	00001697          	auipc	a3,0x1
 77c:	8b068693          	addi	a3,a3,-1872 # 1028 <digits>
 780:	02061713          	slli	a4,a2,0x20
 784:	9301                	srli	a4,a4,0x20
 786:	9736                	add	a4,a4,a3
 788:	00074703          	lbu	a4,0(a4)
 78c:	17c1                	addi	a5,a5,-16
 78e:	97a2                	add	a5,a5,s0
 790:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 794:	fc442783          	lw	a5,-60(s0)
 798:	fe442703          	lw	a4,-28(s0)
 79c:	02f757bb          	divuw	a5,a4,a5
 7a0:	fef42223          	sw	a5,-28(s0)
 7a4:	fe442783          	lw	a5,-28(s0)
 7a8:	2781                	sext.w	a5,a5
 7aa:	fbcd                	bnez	a5,75c <printint+0x5a>
  if(neg)
 7ac:	fe842783          	lw	a5,-24(s0)
 7b0:	2781                	sext.w	a5,a5
 7b2:	cf85                	beqz	a5,7ea <printint+0xe8>
    buf[i++] = '-';
 7b4:	fec42783          	lw	a5,-20(s0)
 7b8:	0017871b          	addiw	a4,a5,1
 7bc:	fee42623          	sw	a4,-20(s0)
 7c0:	17c1                	addi	a5,a5,-16
 7c2:	97a2                	add	a5,a5,s0
 7c4:	02d00713          	li	a4,45
 7c8:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 7cc:	a839                	j	7ea <printint+0xe8>
    putc(fd, buf[i]);
 7ce:	fec42783          	lw	a5,-20(s0)
 7d2:	17c1                	addi	a5,a5,-16
 7d4:	97a2                	add	a5,a5,s0
 7d6:	fe07c703          	lbu	a4,-32(a5)
 7da:	fcc42783          	lw	a5,-52(s0)
 7de:	85ba                	mv	a1,a4
 7e0:	853e                	mv	a0,a5
 7e2:	00000097          	auipc	ra,0x0
 7e6:	eea080e7          	jalr	-278(ra) # 6cc <putc>
  while(--i >= 0)
 7ea:	fec42783          	lw	a5,-20(s0)
 7ee:	37fd                	addiw	a5,a5,-1
 7f0:	fef42623          	sw	a5,-20(s0)
 7f4:	fec42783          	lw	a5,-20(s0)
 7f8:	2781                	sext.w	a5,a5
 7fa:	fc07dae3          	bgez	a5,7ce <printint+0xcc>
}
 7fe:	0001                	nop
 800:	0001                	nop
 802:	70e2                	ld	ra,56(sp)
 804:	7442                	ld	s0,48(sp)
 806:	6121                	addi	sp,sp,64
 808:	8082                	ret

000000000000080a <printptr>:

static void
printptr(int fd, uint64 x) {
 80a:	7179                	addi	sp,sp,-48
 80c:	f406                	sd	ra,40(sp)
 80e:	f022                	sd	s0,32(sp)
 810:	1800                	addi	s0,sp,48
 812:	87aa                	mv	a5,a0
 814:	fcb43823          	sd	a1,-48(s0)
 818:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 81c:	fdc42783          	lw	a5,-36(s0)
 820:	03000593          	li	a1,48
 824:	853e                	mv	a0,a5
 826:	00000097          	auipc	ra,0x0
 82a:	ea6080e7          	jalr	-346(ra) # 6cc <putc>
  putc(fd, 'x');
 82e:	fdc42783          	lw	a5,-36(s0)
 832:	07800593          	li	a1,120
 836:	853e                	mv	a0,a5
 838:	00000097          	auipc	ra,0x0
 83c:	e94080e7          	jalr	-364(ra) # 6cc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 840:	fe042623          	sw	zero,-20(s0)
 844:	a82d                	j	87e <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 846:	fd043783          	ld	a5,-48(s0)
 84a:	93f1                	srli	a5,a5,0x3c
 84c:	00000717          	auipc	a4,0x0
 850:	7dc70713          	addi	a4,a4,2012 # 1028 <digits>
 854:	97ba                	add	a5,a5,a4
 856:	0007c703          	lbu	a4,0(a5)
 85a:	fdc42783          	lw	a5,-36(s0)
 85e:	85ba                	mv	a1,a4
 860:	853e                	mv	a0,a5
 862:	00000097          	auipc	ra,0x0
 866:	e6a080e7          	jalr	-406(ra) # 6cc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 86a:	fec42783          	lw	a5,-20(s0)
 86e:	2785                	addiw	a5,a5,1
 870:	fef42623          	sw	a5,-20(s0)
 874:	fd043783          	ld	a5,-48(s0)
 878:	0792                	slli	a5,a5,0x4
 87a:	fcf43823          	sd	a5,-48(s0)
 87e:	fec42783          	lw	a5,-20(s0)
 882:	873e                	mv	a4,a5
 884:	47bd                	li	a5,15
 886:	fce7f0e3          	bgeu	a5,a4,846 <printptr+0x3c>
}
 88a:	0001                	nop
 88c:	0001                	nop
 88e:	70a2                	ld	ra,40(sp)
 890:	7402                	ld	s0,32(sp)
 892:	6145                	addi	sp,sp,48
 894:	8082                	ret

0000000000000896 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 896:	715d                	addi	sp,sp,-80
 898:	e486                	sd	ra,72(sp)
 89a:	e0a2                	sd	s0,64(sp)
 89c:	0880                	addi	s0,sp,80
 89e:	87aa                	mv	a5,a0
 8a0:	fcb43023          	sd	a1,-64(s0)
 8a4:	fac43c23          	sd	a2,-72(s0)
 8a8:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 8ac:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 8b0:	fe042223          	sw	zero,-28(s0)
 8b4:	a42d                	j	ade <vprintf+0x248>
    c = fmt[i] & 0xff;
 8b6:	fe442783          	lw	a5,-28(s0)
 8ba:	fc043703          	ld	a4,-64(s0)
 8be:	97ba                	add	a5,a5,a4
 8c0:	0007c783          	lbu	a5,0(a5)
 8c4:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 8c8:	fe042783          	lw	a5,-32(s0)
 8cc:	2781                	sext.w	a5,a5
 8ce:	eb9d                	bnez	a5,904 <vprintf+0x6e>
      if(c == '%'){
 8d0:	fdc42783          	lw	a5,-36(s0)
 8d4:	0007871b          	sext.w	a4,a5
 8d8:	02500793          	li	a5,37
 8dc:	00f71763          	bne	a4,a5,8ea <vprintf+0x54>
        state = '%';
 8e0:	02500793          	li	a5,37
 8e4:	fef42023          	sw	a5,-32(s0)
 8e8:	a2f5                	j	ad4 <vprintf+0x23e>
      } else {
        putc(fd, c);
 8ea:	fdc42783          	lw	a5,-36(s0)
 8ee:	0ff7f713          	zext.b	a4,a5
 8f2:	fcc42783          	lw	a5,-52(s0)
 8f6:	85ba                	mv	a1,a4
 8f8:	853e                	mv	a0,a5
 8fa:	00000097          	auipc	ra,0x0
 8fe:	dd2080e7          	jalr	-558(ra) # 6cc <putc>
 902:	aac9                	j	ad4 <vprintf+0x23e>
      }
    } else if(state == '%'){
 904:	fe042783          	lw	a5,-32(s0)
 908:	0007871b          	sext.w	a4,a5
 90c:	02500793          	li	a5,37
 910:	1cf71263          	bne	a4,a5,ad4 <vprintf+0x23e>
      if(c == 'd'){
 914:	fdc42783          	lw	a5,-36(s0)
 918:	0007871b          	sext.w	a4,a5
 91c:	06400793          	li	a5,100
 920:	02f71463          	bne	a4,a5,948 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 924:	fb843783          	ld	a5,-72(s0)
 928:	00878713          	addi	a4,a5,8
 92c:	fae43c23          	sd	a4,-72(s0)
 930:	4398                	lw	a4,0(a5)
 932:	fcc42783          	lw	a5,-52(s0)
 936:	4685                	li	a3,1
 938:	4629                	li	a2,10
 93a:	85ba                	mv	a1,a4
 93c:	853e                	mv	a0,a5
 93e:	00000097          	auipc	ra,0x0
 942:	dc4080e7          	jalr	-572(ra) # 702 <printint>
 946:	a269                	j	ad0 <vprintf+0x23a>
      } else if(c == 'l') {
 948:	fdc42783          	lw	a5,-36(s0)
 94c:	0007871b          	sext.w	a4,a5
 950:	06c00793          	li	a5,108
 954:	02f71663          	bne	a4,a5,980 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 958:	fb843783          	ld	a5,-72(s0)
 95c:	00878713          	addi	a4,a5,8
 960:	fae43c23          	sd	a4,-72(s0)
 964:	639c                	ld	a5,0(a5)
 966:	0007871b          	sext.w	a4,a5
 96a:	fcc42783          	lw	a5,-52(s0)
 96e:	4681                	li	a3,0
 970:	4629                	li	a2,10
 972:	85ba                	mv	a1,a4
 974:	853e                	mv	a0,a5
 976:	00000097          	auipc	ra,0x0
 97a:	d8c080e7          	jalr	-628(ra) # 702 <printint>
 97e:	aa89                	j	ad0 <vprintf+0x23a>
      } else if(c == 'x') {
 980:	fdc42783          	lw	a5,-36(s0)
 984:	0007871b          	sext.w	a4,a5
 988:	07800793          	li	a5,120
 98c:	02f71463          	bne	a4,a5,9b4 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 990:	fb843783          	ld	a5,-72(s0)
 994:	00878713          	addi	a4,a5,8
 998:	fae43c23          	sd	a4,-72(s0)
 99c:	4398                	lw	a4,0(a5)
 99e:	fcc42783          	lw	a5,-52(s0)
 9a2:	4681                	li	a3,0
 9a4:	4641                	li	a2,16
 9a6:	85ba                	mv	a1,a4
 9a8:	853e                	mv	a0,a5
 9aa:	00000097          	auipc	ra,0x0
 9ae:	d58080e7          	jalr	-680(ra) # 702 <printint>
 9b2:	aa39                	j	ad0 <vprintf+0x23a>
      } else if(c == 'p') {
 9b4:	fdc42783          	lw	a5,-36(s0)
 9b8:	0007871b          	sext.w	a4,a5
 9bc:	07000793          	li	a5,112
 9c0:	02f71263          	bne	a4,a5,9e4 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 9c4:	fb843783          	ld	a5,-72(s0)
 9c8:	00878713          	addi	a4,a5,8
 9cc:	fae43c23          	sd	a4,-72(s0)
 9d0:	6398                	ld	a4,0(a5)
 9d2:	fcc42783          	lw	a5,-52(s0)
 9d6:	85ba                	mv	a1,a4
 9d8:	853e                	mv	a0,a5
 9da:	00000097          	auipc	ra,0x0
 9de:	e30080e7          	jalr	-464(ra) # 80a <printptr>
 9e2:	a0fd                	j	ad0 <vprintf+0x23a>
      } else if(c == 's'){
 9e4:	fdc42783          	lw	a5,-36(s0)
 9e8:	0007871b          	sext.w	a4,a5
 9ec:	07300793          	li	a5,115
 9f0:	04f71c63          	bne	a4,a5,a48 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 9f4:	fb843783          	ld	a5,-72(s0)
 9f8:	00878713          	addi	a4,a5,8
 9fc:	fae43c23          	sd	a4,-72(s0)
 a00:	639c                	ld	a5,0(a5)
 a02:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 a06:	fe843783          	ld	a5,-24(s0)
 a0a:	eb8d                	bnez	a5,a3c <vprintf+0x1a6>
          s = "(null)";
 a0c:	00000797          	auipc	a5,0x0
 a10:	5c478793          	addi	a5,a5,1476 # fd0 <lock_init+0x52>
 a14:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 a18:	a015                	j	a3c <vprintf+0x1a6>
          putc(fd, *s);
 a1a:	fe843783          	ld	a5,-24(s0)
 a1e:	0007c703          	lbu	a4,0(a5)
 a22:	fcc42783          	lw	a5,-52(s0)
 a26:	85ba                	mv	a1,a4
 a28:	853e                	mv	a0,a5
 a2a:	00000097          	auipc	ra,0x0
 a2e:	ca2080e7          	jalr	-862(ra) # 6cc <putc>
          s++;
 a32:	fe843783          	ld	a5,-24(s0)
 a36:	0785                	addi	a5,a5,1
 a38:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 a3c:	fe843783          	ld	a5,-24(s0)
 a40:	0007c783          	lbu	a5,0(a5)
 a44:	fbf9                	bnez	a5,a1a <vprintf+0x184>
 a46:	a069                	j	ad0 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 a48:	fdc42783          	lw	a5,-36(s0)
 a4c:	0007871b          	sext.w	a4,a5
 a50:	06300793          	li	a5,99
 a54:	02f71463          	bne	a4,a5,a7c <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 a58:	fb843783          	ld	a5,-72(s0)
 a5c:	00878713          	addi	a4,a5,8
 a60:	fae43c23          	sd	a4,-72(s0)
 a64:	439c                	lw	a5,0(a5)
 a66:	0ff7f713          	zext.b	a4,a5
 a6a:	fcc42783          	lw	a5,-52(s0)
 a6e:	85ba                	mv	a1,a4
 a70:	853e                	mv	a0,a5
 a72:	00000097          	auipc	ra,0x0
 a76:	c5a080e7          	jalr	-934(ra) # 6cc <putc>
 a7a:	a899                	j	ad0 <vprintf+0x23a>
      } else if(c == '%'){
 a7c:	fdc42783          	lw	a5,-36(s0)
 a80:	0007871b          	sext.w	a4,a5
 a84:	02500793          	li	a5,37
 a88:	00f71f63          	bne	a4,a5,aa6 <vprintf+0x210>
        putc(fd, c);
 a8c:	fdc42783          	lw	a5,-36(s0)
 a90:	0ff7f713          	zext.b	a4,a5
 a94:	fcc42783          	lw	a5,-52(s0)
 a98:	85ba                	mv	a1,a4
 a9a:	853e                	mv	a0,a5
 a9c:	00000097          	auipc	ra,0x0
 aa0:	c30080e7          	jalr	-976(ra) # 6cc <putc>
 aa4:	a035                	j	ad0 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 aa6:	fcc42783          	lw	a5,-52(s0)
 aaa:	02500593          	li	a1,37
 aae:	853e                	mv	a0,a5
 ab0:	00000097          	auipc	ra,0x0
 ab4:	c1c080e7          	jalr	-996(ra) # 6cc <putc>
        putc(fd, c);
 ab8:	fdc42783          	lw	a5,-36(s0)
 abc:	0ff7f713          	zext.b	a4,a5
 ac0:	fcc42783          	lw	a5,-52(s0)
 ac4:	85ba                	mv	a1,a4
 ac6:	853e                	mv	a0,a5
 ac8:	00000097          	auipc	ra,0x0
 acc:	c04080e7          	jalr	-1020(ra) # 6cc <putc>
      }
      state = 0;
 ad0:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 ad4:	fe442783          	lw	a5,-28(s0)
 ad8:	2785                	addiw	a5,a5,1
 ada:	fef42223          	sw	a5,-28(s0)
 ade:	fe442783          	lw	a5,-28(s0)
 ae2:	fc043703          	ld	a4,-64(s0)
 ae6:	97ba                	add	a5,a5,a4
 ae8:	0007c783          	lbu	a5,0(a5)
 aec:	dc0795e3          	bnez	a5,8b6 <vprintf+0x20>
    }
  }
}
 af0:	0001                	nop
 af2:	0001                	nop
 af4:	60a6                	ld	ra,72(sp)
 af6:	6406                	ld	s0,64(sp)
 af8:	6161                	addi	sp,sp,80
 afa:	8082                	ret

0000000000000afc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 afc:	7159                	addi	sp,sp,-112
 afe:	fc06                	sd	ra,56(sp)
 b00:	f822                	sd	s0,48(sp)
 b02:	0080                	addi	s0,sp,64
 b04:	fcb43823          	sd	a1,-48(s0)
 b08:	e010                	sd	a2,0(s0)
 b0a:	e414                	sd	a3,8(s0)
 b0c:	e818                	sd	a4,16(s0)
 b0e:	ec1c                	sd	a5,24(s0)
 b10:	03043023          	sd	a6,32(s0)
 b14:	03143423          	sd	a7,40(s0)
 b18:	87aa                	mv	a5,a0
 b1a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 b1e:	03040793          	addi	a5,s0,48
 b22:	fcf43423          	sd	a5,-56(s0)
 b26:	fc843783          	ld	a5,-56(s0)
 b2a:	fd078793          	addi	a5,a5,-48
 b2e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 b32:	fe843703          	ld	a4,-24(s0)
 b36:	fdc42783          	lw	a5,-36(s0)
 b3a:	863a                	mv	a2,a4
 b3c:	fd043583          	ld	a1,-48(s0)
 b40:	853e                	mv	a0,a5
 b42:	00000097          	auipc	ra,0x0
 b46:	d54080e7          	jalr	-684(ra) # 896 <vprintf>
}
 b4a:	0001                	nop
 b4c:	70e2                	ld	ra,56(sp)
 b4e:	7442                	ld	s0,48(sp)
 b50:	6165                	addi	sp,sp,112
 b52:	8082                	ret

0000000000000b54 <printf>:

void
printf(const char *fmt, ...)
{
 b54:	7159                	addi	sp,sp,-112
 b56:	f406                	sd	ra,40(sp)
 b58:	f022                	sd	s0,32(sp)
 b5a:	1800                	addi	s0,sp,48
 b5c:	fca43c23          	sd	a0,-40(s0)
 b60:	e40c                	sd	a1,8(s0)
 b62:	e810                	sd	a2,16(s0)
 b64:	ec14                	sd	a3,24(s0)
 b66:	f018                	sd	a4,32(s0)
 b68:	f41c                	sd	a5,40(s0)
 b6a:	03043823          	sd	a6,48(s0)
 b6e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b72:	04040793          	addi	a5,s0,64
 b76:	fcf43823          	sd	a5,-48(s0)
 b7a:	fd043783          	ld	a5,-48(s0)
 b7e:	fc878793          	addi	a5,a5,-56
 b82:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 b86:	fe843783          	ld	a5,-24(s0)
 b8a:	863e                	mv	a2,a5
 b8c:	fd843583          	ld	a1,-40(s0)
 b90:	4505                	li	a0,1
 b92:	00000097          	auipc	ra,0x0
 b96:	d04080e7          	jalr	-764(ra) # 896 <vprintf>
}
 b9a:	0001                	nop
 b9c:	70a2                	ld	ra,40(sp)
 b9e:	7402                	ld	s0,32(sp)
 ba0:	6165                	addi	sp,sp,112
 ba2:	8082                	ret

0000000000000ba4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ba4:	7179                	addi	sp,sp,-48
 ba6:	f422                	sd	s0,40(sp)
 ba8:	1800                	addi	s0,sp,48
 baa:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bae:	fd843783          	ld	a5,-40(s0)
 bb2:	17c1                	addi	a5,a5,-16
 bb4:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bb8:	00000797          	auipc	a5,0x0
 bbc:	49878793          	addi	a5,a5,1176 # 1050 <freep>
 bc0:	639c                	ld	a5,0(a5)
 bc2:	fef43423          	sd	a5,-24(s0)
 bc6:	a815                	j	bfa <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bc8:	fe843783          	ld	a5,-24(s0)
 bcc:	639c                	ld	a5,0(a5)
 bce:	fe843703          	ld	a4,-24(s0)
 bd2:	00f76f63          	bltu	a4,a5,bf0 <free+0x4c>
 bd6:	fe043703          	ld	a4,-32(s0)
 bda:	fe843783          	ld	a5,-24(s0)
 bde:	02e7eb63          	bltu	a5,a4,c14 <free+0x70>
 be2:	fe843783          	ld	a5,-24(s0)
 be6:	639c                	ld	a5,0(a5)
 be8:	fe043703          	ld	a4,-32(s0)
 bec:	02f76463          	bltu	a4,a5,c14 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bf0:	fe843783          	ld	a5,-24(s0)
 bf4:	639c                	ld	a5,0(a5)
 bf6:	fef43423          	sd	a5,-24(s0)
 bfa:	fe043703          	ld	a4,-32(s0)
 bfe:	fe843783          	ld	a5,-24(s0)
 c02:	fce7f3e3          	bgeu	a5,a4,bc8 <free+0x24>
 c06:	fe843783          	ld	a5,-24(s0)
 c0a:	639c                	ld	a5,0(a5)
 c0c:	fe043703          	ld	a4,-32(s0)
 c10:	faf77ce3          	bgeu	a4,a5,bc8 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c14:	fe043783          	ld	a5,-32(s0)
 c18:	479c                	lw	a5,8(a5)
 c1a:	1782                	slli	a5,a5,0x20
 c1c:	9381                	srli	a5,a5,0x20
 c1e:	0792                	slli	a5,a5,0x4
 c20:	fe043703          	ld	a4,-32(s0)
 c24:	973e                	add	a4,a4,a5
 c26:	fe843783          	ld	a5,-24(s0)
 c2a:	639c                	ld	a5,0(a5)
 c2c:	02f71763          	bne	a4,a5,c5a <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 c30:	fe043783          	ld	a5,-32(s0)
 c34:	4798                	lw	a4,8(a5)
 c36:	fe843783          	ld	a5,-24(s0)
 c3a:	639c                	ld	a5,0(a5)
 c3c:	479c                	lw	a5,8(a5)
 c3e:	9fb9                	addw	a5,a5,a4
 c40:	0007871b          	sext.w	a4,a5
 c44:	fe043783          	ld	a5,-32(s0)
 c48:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 c4a:	fe843783          	ld	a5,-24(s0)
 c4e:	639c                	ld	a5,0(a5)
 c50:	6398                	ld	a4,0(a5)
 c52:	fe043783          	ld	a5,-32(s0)
 c56:	e398                	sd	a4,0(a5)
 c58:	a039                	j	c66 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 c5a:	fe843783          	ld	a5,-24(s0)
 c5e:	6398                	ld	a4,0(a5)
 c60:	fe043783          	ld	a5,-32(s0)
 c64:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 c66:	fe843783          	ld	a5,-24(s0)
 c6a:	479c                	lw	a5,8(a5)
 c6c:	1782                	slli	a5,a5,0x20
 c6e:	9381                	srli	a5,a5,0x20
 c70:	0792                	slli	a5,a5,0x4
 c72:	fe843703          	ld	a4,-24(s0)
 c76:	97ba                	add	a5,a5,a4
 c78:	fe043703          	ld	a4,-32(s0)
 c7c:	02f71563          	bne	a4,a5,ca6 <free+0x102>
    p->s.size += bp->s.size;
 c80:	fe843783          	ld	a5,-24(s0)
 c84:	4798                	lw	a4,8(a5)
 c86:	fe043783          	ld	a5,-32(s0)
 c8a:	479c                	lw	a5,8(a5)
 c8c:	9fb9                	addw	a5,a5,a4
 c8e:	0007871b          	sext.w	a4,a5
 c92:	fe843783          	ld	a5,-24(s0)
 c96:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c98:	fe043783          	ld	a5,-32(s0)
 c9c:	6398                	ld	a4,0(a5)
 c9e:	fe843783          	ld	a5,-24(s0)
 ca2:	e398                	sd	a4,0(a5)
 ca4:	a031                	j	cb0 <free+0x10c>
  } else
    p->s.ptr = bp;
 ca6:	fe843783          	ld	a5,-24(s0)
 caa:	fe043703          	ld	a4,-32(s0)
 cae:	e398                	sd	a4,0(a5)
  freep = p;
 cb0:	00000797          	auipc	a5,0x0
 cb4:	3a078793          	addi	a5,a5,928 # 1050 <freep>
 cb8:	fe843703          	ld	a4,-24(s0)
 cbc:	e398                	sd	a4,0(a5)
}
 cbe:	0001                	nop
 cc0:	7422                	ld	s0,40(sp)
 cc2:	6145                	addi	sp,sp,48
 cc4:	8082                	ret

0000000000000cc6 <morecore>:

static Header*
morecore(uint nu)
{
 cc6:	7179                	addi	sp,sp,-48
 cc8:	f406                	sd	ra,40(sp)
 cca:	f022                	sd	s0,32(sp)
 ccc:	1800                	addi	s0,sp,48
 cce:	87aa                	mv	a5,a0
 cd0:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 cd4:	fdc42783          	lw	a5,-36(s0)
 cd8:	0007871b          	sext.w	a4,a5
 cdc:	6785                	lui	a5,0x1
 cde:	00f77563          	bgeu	a4,a5,ce8 <morecore+0x22>
    nu = 4096;
 ce2:	6785                	lui	a5,0x1
 ce4:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 ce8:	fdc42783          	lw	a5,-36(s0)
 cec:	0047979b          	slliw	a5,a5,0x4
 cf0:	2781                	sext.w	a5,a5
 cf2:	2781                	sext.w	a5,a5
 cf4:	853e                	mv	a0,a5
 cf6:	00000097          	auipc	ra,0x0
 cfa:	9ae080e7          	jalr	-1618(ra) # 6a4 <sbrk>
 cfe:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 d02:	fe843703          	ld	a4,-24(s0)
 d06:	57fd                	li	a5,-1
 d08:	00f71463          	bne	a4,a5,d10 <morecore+0x4a>
    return 0;
 d0c:	4781                	li	a5,0
 d0e:	a03d                	j	d3c <morecore+0x76>
  hp = (Header*)p;
 d10:	fe843783          	ld	a5,-24(s0)
 d14:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 d18:	fe043783          	ld	a5,-32(s0)
 d1c:	fdc42703          	lw	a4,-36(s0)
 d20:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 d22:	fe043783          	ld	a5,-32(s0)
 d26:	07c1                	addi	a5,a5,16
 d28:	853e                	mv	a0,a5
 d2a:	00000097          	auipc	ra,0x0
 d2e:	e7a080e7          	jalr	-390(ra) # ba4 <free>
  return freep;
 d32:	00000797          	auipc	a5,0x0
 d36:	31e78793          	addi	a5,a5,798 # 1050 <freep>
 d3a:	639c                	ld	a5,0(a5)
}
 d3c:	853e                	mv	a0,a5
 d3e:	70a2                	ld	ra,40(sp)
 d40:	7402                	ld	s0,32(sp)
 d42:	6145                	addi	sp,sp,48
 d44:	8082                	ret

0000000000000d46 <malloc>:

void*
malloc(uint nbytes)
{
 d46:	7139                	addi	sp,sp,-64
 d48:	fc06                	sd	ra,56(sp)
 d4a:	f822                	sd	s0,48(sp)
 d4c:	0080                	addi	s0,sp,64
 d4e:	87aa                	mv	a5,a0
 d50:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d54:	fcc46783          	lwu	a5,-52(s0)
 d58:	07bd                	addi	a5,a5,15
 d5a:	8391                	srli	a5,a5,0x4
 d5c:	2781                	sext.w	a5,a5
 d5e:	2785                	addiw	a5,a5,1
 d60:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 d64:	00000797          	auipc	a5,0x0
 d68:	2ec78793          	addi	a5,a5,748 # 1050 <freep>
 d6c:	639c                	ld	a5,0(a5)
 d6e:	fef43023          	sd	a5,-32(s0)
 d72:	fe043783          	ld	a5,-32(s0)
 d76:	ef95                	bnez	a5,db2 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 d78:	00000797          	auipc	a5,0x0
 d7c:	2c878793          	addi	a5,a5,712 # 1040 <base>
 d80:	fef43023          	sd	a5,-32(s0)
 d84:	00000797          	auipc	a5,0x0
 d88:	2cc78793          	addi	a5,a5,716 # 1050 <freep>
 d8c:	fe043703          	ld	a4,-32(s0)
 d90:	e398                	sd	a4,0(a5)
 d92:	00000797          	auipc	a5,0x0
 d96:	2be78793          	addi	a5,a5,702 # 1050 <freep>
 d9a:	6398                	ld	a4,0(a5)
 d9c:	00000797          	auipc	a5,0x0
 da0:	2a478793          	addi	a5,a5,676 # 1040 <base>
 da4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 da6:	00000797          	auipc	a5,0x0
 daa:	29a78793          	addi	a5,a5,666 # 1040 <base>
 dae:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 db2:	fe043783          	ld	a5,-32(s0)
 db6:	639c                	ld	a5,0(a5)
 db8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 dbc:	fe843783          	ld	a5,-24(s0)
 dc0:	4798                	lw	a4,8(a5)
 dc2:	fdc42783          	lw	a5,-36(s0)
 dc6:	2781                	sext.w	a5,a5
 dc8:	06f76763          	bltu	a4,a5,e36 <malloc+0xf0>
      if(p->s.size == nunits)
 dcc:	fe843783          	ld	a5,-24(s0)
 dd0:	4798                	lw	a4,8(a5)
 dd2:	fdc42783          	lw	a5,-36(s0)
 dd6:	2781                	sext.w	a5,a5
 dd8:	00e79963          	bne	a5,a4,dea <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 ddc:	fe843783          	ld	a5,-24(s0)
 de0:	6398                	ld	a4,0(a5)
 de2:	fe043783          	ld	a5,-32(s0)
 de6:	e398                	sd	a4,0(a5)
 de8:	a825                	j	e20 <malloc+0xda>
      else {
        p->s.size -= nunits;
 dea:	fe843783          	ld	a5,-24(s0)
 dee:	479c                	lw	a5,8(a5)
 df0:	fdc42703          	lw	a4,-36(s0)
 df4:	9f99                	subw	a5,a5,a4
 df6:	0007871b          	sext.w	a4,a5
 dfa:	fe843783          	ld	a5,-24(s0)
 dfe:	c798                	sw	a4,8(a5)
        p += p->s.size;
 e00:	fe843783          	ld	a5,-24(s0)
 e04:	479c                	lw	a5,8(a5)
 e06:	1782                	slli	a5,a5,0x20
 e08:	9381                	srli	a5,a5,0x20
 e0a:	0792                	slli	a5,a5,0x4
 e0c:	fe843703          	ld	a4,-24(s0)
 e10:	97ba                	add	a5,a5,a4
 e12:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 e16:	fe843783          	ld	a5,-24(s0)
 e1a:	fdc42703          	lw	a4,-36(s0)
 e1e:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 e20:	00000797          	auipc	a5,0x0
 e24:	23078793          	addi	a5,a5,560 # 1050 <freep>
 e28:	fe043703          	ld	a4,-32(s0)
 e2c:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 e2e:	fe843783          	ld	a5,-24(s0)
 e32:	07c1                	addi	a5,a5,16
 e34:	a091                	j	e78 <malloc+0x132>
    }
    if(p == freep)
 e36:	00000797          	auipc	a5,0x0
 e3a:	21a78793          	addi	a5,a5,538 # 1050 <freep>
 e3e:	639c                	ld	a5,0(a5)
 e40:	fe843703          	ld	a4,-24(s0)
 e44:	02f71063          	bne	a4,a5,e64 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 e48:	fdc42783          	lw	a5,-36(s0)
 e4c:	853e                	mv	a0,a5
 e4e:	00000097          	auipc	ra,0x0
 e52:	e78080e7          	jalr	-392(ra) # cc6 <morecore>
 e56:	fea43423          	sd	a0,-24(s0)
 e5a:	fe843783          	ld	a5,-24(s0)
 e5e:	e399                	bnez	a5,e64 <malloc+0x11e>
        return 0;
 e60:	4781                	li	a5,0
 e62:	a819                	j	e78 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e64:	fe843783          	ld	a5,-24(s0)
 e68:	fef43023          	sd	a5,-32(s0)
 e6c:	fe843783          	ld	a5,-24(s0)
 e70:	639c                	ld	a5,0(a5)
 e72:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 e76:	b799                	j	dbc <malloc+0x76>
  }
}
 e78:	853e                	mv	a0,a5
 e7a:	70e2                	ld	ra,56(sp)
 e7c:	7442                	ld	s0,48(sp)
 e7e:	6121                	addi	sp,sp,64
 e80:	8082                	ret

0000000000000e82 <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
 e82:	7179                	addi	sp,sp,-48
 e84:	f406                	sd	ra,40(sp)
 e86:	f022                	sd	s0,32(sp)
 e88:	1800                	addi	s0,sp,48
 e8a:	fca43c23          	sd	a0,-40(s0)
 e8e:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
 e92:	6505                	lui	a0,0x1
 e94:	00000097          	auipc	ra,0x0
 e98:	eb2080e7          	jalr	-334(ra) # d46 <malloc>
 e9c:	fea43423          	sd	a0,-24(s0)
 ea0:	fe843783          	ld	a5,-24(s0)
 ea4:	e38d                	bnez	a5,ec6 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
 ea6:	00000517          	auipc	a0,0x0
 eaa:	13250513          	addi	a0,a0,306 # fd8 <lock_init+0x5a>
 eae:	00000097          	auipc	ra,0x0
 eb2:	ca6080e7          	jalr	-858(ra) # b54 <printf>
        free(stack);
 eb6:	fe843503          	ld	a0,-24(s0)
 eba:	00000097          	auipc	ra,0x0
 ebe:	cea080e7          	jalr	-790(ra) # ba4 <free>
        return -1;
 ec2:	57fd                	li	a5,-1
 ec4:	a099                	j	f0a <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
 ec6:	fe843783          	ld	a5,-24(s0)
 eca:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
 ece:	fe043703          	ld	a4,-32(s0)
 ed2:	6785                	lui	a5,0x1
 ed4:	17fd                	addi	a5,a5,-1
 ed6:	8ff9                	and	a5,a5,a4
 ed8:	cf91                	beqz	a5,ef4 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
 eda:	fe043703          	ld	a4,-32(s0)
 ede:	6785                	lui	a5,0x1
 ee0:	17fd                	addi	a5,a5,-1
 ee2:	8ff9                	and	a5,a5,a4
 ee4:	6705                	lui	a4,0x1
 ee6:	40f707b3          	sub	a5,a4,a5
 eea:	fe843703          	ld	a4,-24(s0)
 eee:	97ba                	add	a5,a5,a4
 ef0:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
 ef4:	fe843603          	ld	a2,-24(s0)
 ef8:	fd043583          	ld	a1,-48(s0)
 efc:	fd843503          	ld	a0,-40(s0)
 f00:	fffff097          	auipc	ra,0xfffff
 f04:	7bc080e7          	jalr	1980(ra) # 6bc <clone>
 f08:	87aa                	mv	a5,a0
}
 f0a:	853e                	mv	a0,a5
 f0c:	70a2                	ld	ra,40(sp)
 f0e:	7402                	ld	s0,32(sp)
 f10:	6145                	addi	sp,sp,48
 f12:	8082                	ret

0000000000000f14 <thread_join>:


int thread_join()
{
 f14:	1101                	addi	sp,sp,-32
 f16:	ec06                	sd	ra,24(sp)
 f18:	e822                	sd	s0,16(sp)
 f1a:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
 f1c:	fe040793          	addi	a5,s0,-32
 f20:	853e                	mv	a0,a5
 f22:	fffff097          	auipc	ra,0xfffff
 f26:	7a2080e7          	jalr	1954(ra) # 6c4 <join>
 f2a:	87aa                	mv	a5,a0
 f2c:	fef42623          	sw	a5,-20(s0)
 f30:	fec42783          	lw	a5,-20(s0)
 f34:	0007871b          	sext.w	a4,a5
 f38:	57fd                	li	a5,-1
 f3a:	00f70963          	beq	a4,a5,f4c <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
 f3e:	fe043783          	ld	a5,-32(s0)
 f42:	853e                	mv	a0,a5
 f44:	00000097          	auipc	ra,0x0
 f48:	c60080e7          	jalr	-928(ra) # ba4 <free>
    } 

    return child_tid;
 f4c:	fec42783          	lw	a5,-20(s0)
}
 f50:	853e                	mv	a0,a5
 f52:	60e2                	ld	ra,24(sp)
 f54:	6442                	ld	s0,16(sp)
 f56:	6105                	addi	sp,sp,32
 f58:	8082                	ret

0000000000000f5a <lock_acquire>:


void lock_acquire (lock_t *)
{
 f5a:	1101                	addi	sp,sp,-32
 f5c:	ec22                	sd	s0,24(sp)
 f5e:	1000                	addi	s0,sp,32
 f60:	fea43423          	sd	a0,-24(s0)

}
 f64:	0001                	nop
 f66:	6462                	ld	s0,24(sp)
 f68:	6105                	addi	sp,sp,32
 f6a:	8082                	ret

0000000000000f6c <lock_release>:

void lock_release (lock_t *)
{
 f6c:	1101                	addi	sp,sp,-32
 f6e:	ec22                	sd	s0,24(sp)
 f70:	1000                	addi	s0,sp,32
 f72:	fea43423          	sd	a0,-24(s0)
    
}
 f76:	0001                	nop
 f78:	6462                	ld	s0,24(sp)
 f7a:	6105                	addi	sp,sp,32
 f7c:	8082                	ret

0000000000000f7e <lock_init>:

void lock_init (lock_t *)
{
 f7e:	1101                	addi	sp,sp,-32
 f80:	ec22                	sd	s0,24(sp)
 f82:	1000                	addi	s0,sp,32
 f84:	fea43423          	sd	a0,-24(s0)
    
}
 f88:	0001                	nop
 f8a:	6462                	ld	s0,24(sp)
 f8c:	6105                	addi	sp,sp,32
 f8e:	8082                	ret
