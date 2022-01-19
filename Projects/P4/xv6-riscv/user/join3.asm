
user/_join3:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
   exit(0); \
}

int
main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
   8:	87aa                	mv	a5,a0
   a:	fcb43823          	sd	a1,-48(s0)
   e:	fcf42e23          	sw	a5,-36(s0)
   ppid = getpid();
  12:	00000097          	auipc	ra,0x0
  16:	650080e7          	jalr	1616(ra) # 662 <getpid>
  1a:	87aa                	mv	a5,a0
  1c:	873e                	mv	a4,a5
  1e:	00001797          	auipc	a5,0x1
  22:	02a78793          	addi	a5,a5,42 # 1048 <ppid>
  26:	c398                	sw	a4,0(a5)

   int fork_pid = fork();
  28:	00000097          	auipc	ra,0x0
  2c:	5b2080e7          	jalr	1458(ra) # 5da <fork>
  30:	87aa                	mv	a5,a0
  32:	fef42623          	sw	a5,-20(s0)
   if(fork_pid == 0) {
  36:	fec42783          	lw	a5,-20(s0)
  3a:	2781                	sext.w	a5,a5
  3c:	e791                	bnez	a5,48 <main+0x48>
     exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	5a2080e7          	jalr	1442(ra) # 5e2 <exit>
   }
   assert(fork_pid > 0);
  48:	fec42783          	lw	a5,-20(s0)
  4c:	2781                	sext.w	a5,a5
  4e:	06f04263          	bgtz	a5,b2 <main+0xb2>
  52:	4679                	li	a2,30
  54:	00001597          	auipc	a1,0x1
  58:	f1458593          	addi	a1,a1,-236 # f68 <lock_init+0x16>
  5c:	00001517          	auipc	a0,0x1
  60:	f1c50513          	addi	a0,a0,-228 # f78 <lock_init+0x26>
  64:	00001097          	auipc	ra,0x1
  68:	ab6080e7          	jalr	-1354(ra) # b1a <printf>
  6c:	00001597          	auipc	a1,0x1
  70:	f1458593          	addi	a1,a1,-236 # f80 <lock_init+0x2e>
  74:	00001517          	auipc	a0,0x1
  78:	f1c50513          	addi	a0,a0,-228 # f90 <lock_init+0x3e>
  7c:	00001097          	auipc	ra,0x1
  80:	a9e080e7          	jalr	-1378(ra) # b1a <printf>
  84:	00001517          	auipc	a0,0x1
  88:	f2450513          	addi	a0,a0,-220 # fa8 <lock_init+0x56>
  8c:	00001097          	auipc	ra,0x1
  90:	a8e080e7          	jalr	-1394(ra) # b1a <printf>
  94:	00001797          	auipc	a5,0x1
  98:	fb478793          	addi	a5,a5,-76 # 1048 <ppid>
  9c:	439c                	lw	a5,0(a5)
  9e:	853e                	mv	a0,a5
  a0:	00000097          	auipc	ra,0x0
  a4:	572080e7          	jalr	1394(ra) # 612 <kill>
  a8:	4501                	li	a0,0
  aa:	00000097          	auipc	ra,0x0
  ae:	538080e7          	jalr	1336(ra) # 5e2 <exit>

   void *join_stack;
   int join_pid = join(&join_stack);
  b2:	fe040793          	addi	a5,s0,-32
  b6:	853e                	mv	a0,a5
  b8:	00000097          	auipc	ra,0x0
  bc:	5d2080e7          	jalr	1490(ra) # 68a <join>
  c0:	87aa                	mv	a5,a0
  c2:	fef42423          	sw	a5,-24(s0)
   assert(join_pid == -1);
  c6:	fe842783          	lw	a5,-24(s0)
  ca:	0007871b          	sext.w	a4,a5
  ce:	57fd                	li	a5,-1
  d0:	06f70363          	beq	a4,a5,136 <main+0x136>
  d4:	02200613          	li	a2,34
  d8:	00001597          	auipc	a1,0x1
  dc:	e9058593          	addi	a1,a1,-368 # f68 <lock_init+0x16>
  e0:	00001517          	auipc	a0,0x1
  e4:	e9850513          	addi	a0,a0,-360 # f78 <lock_init+0x26>
  e8:	00001097          	auipc	ra,0x1
  ec:	a32080e7          	jalr	-1486(ra) # b1a <printf>
  f0:	00001597          	auipc	a1,0x1
  f4:	ec858593          	addi	a1,a1,-312 # fb8 <lock_init+0x66>
  f8:	00001517          	auipc	a0,0x1
  fc:	e9850513          	addi	a0,a0,-360 # f90 <lock_init+0x3e>
 100:	00001097          	auipc	ra,0x1
 104:	a1a080e7          	jalr	-1510(ra) # b1a <printf>
 108:	00001517          	auipc	a0,0x1
 10c:	ea050513          	addi	a0,a0,-352 # fa8 <lock_init+0x56>
 110:	00001097          	auipc	ra,0x1
 114:	a0a080e7          	jalr	-1526(ra) # b1a <printf>
 118:	00001797          	auipc	a5,0x1
 11c:	f3078793          	addi	a5,a5,-208 # 1048 <ppid>
 120:	439c                	lw	a5,0(a5)
 122:	853e                	mv	a0,a5
 124:	00000097          	auipc	ra,0x0
 128:	4ee080e7          	jalr	1262(ra) # 612 <kill>
 12c:	4501                	li	a0,0
 12e:	00000097          	auipc	ra,0x0
 132:	4b4080e7          	jalr	1204(ra) # 5e2 <exit>

   printf("TEST PASSED\n");
 136:	00001517          	auipc	a0,0x1
 13a:	e9250513          	addi	a0,a0,-366 # fc8 <lock_init+0x76>
 13e:	00001097          	auipc	ra,0x1
 142:	9dc080e7          	jalr	-1572(ra) # b1a <printf>
   exit(0);
 146:	4501                	li	a0,0
 148:	00000097          	auipc	ra,0x0
 14c:	49a080e7          	jalr	1178(ra) # 5e2 <exit>

0000000000000150 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 150:	7179                	addi	sp,sp,-48
 152:	f422                	sd	s0,40(sp)
 154:	1800                	addi	s0,sp,48
 156:	fca43c23          	sd	a0,-40(s0)
 15a:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 15e:	fd843783          	ld	a5,-40(s0)
 162:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 166:	0001                	nop
 168:	fd043703          	ld	a4,-48(s0)
 16c:	00170793          	addi	a5,a4,1
 170:	fcf43823          	sd	a5,-48(s0)
 174:	fd843783          	ld	a5,-40(s0)
 178:	00178693          	addi	a3,a5,1
 17c:	fcd43c23          	sd	a3,-40(s0)
 180:	00074703          	lbu	a4,0(a4)
 184:	00e78023          	sb	a4,0(a5)
 188:	0007c783          	lbu	a5,0(a5)
 18c:	fff1                	bnez	a5,168 <strcpy+0x18>
    ;
  return os;
 18e:	fe843783          	ld	a5,-24(s0)
}
 192:	853e                	mv	a0,a5
 194:	7422                	ld	s0,40(sp)
 196:	6145                	addi	sp,sp,48
 198:	8082                	ret

000000000000019a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 19a:	1101                	addi	sp,sp,-32
 19c:	ec22                	sd	s0,24(sp)
 19e:	1000                	addi	s0,sp,32
 1a0:	fea43423          	sd	a0,-24(s0)
 1a4:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 1a8:	a819                	j	1be <strcmp+0x24>
    p++, q++;
 1aa:	fe843783          	ld	a5,-24(s0)
 1ae:	0785                	addi	a5,a5,1
 1b0:	fef43423          	sd	a5,-24(s0)
 1b4:	fe043783          	ld	a5,-32(s0)
 1b8:	0785                	addi	a5,a5,1
 1ba:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 1be:	fe843783          	ld	a5,-24(s0)
 1c2:	0007c783          	lbu	a5,0(a5)
 1c6:	cb99                	beqz	a5,1dc <strcmp+0x42>
 1c8:	fe843783          	ld	a5,-24(s0)
 1cc:	0007c703          	lbu	a4,0(a5)
 1d0:	fe043783          	ld	a5,-32(s0)
 1d4:	0007c783          	lbu	a5,0(a5)
 1d8:	fcf709e3          	beq	a4,a5,1aa <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 1dc:	fe843783          	ld	a5,-24(s0)
 1e0:	0007c783          	lbu	a5,0(a5)
 1e4:	0007871b          	sext.w	a4,a5
 1e8:	fe043783          	ld	a5,-32(s0)
 1ec:	0007c783          	lbu	a5,0(a5)
 1f0:	2781                	sext.w	a5,a5
 1f2:	40f707bb          	subw	a5,a4,a5
 1f6:	2781                	sext.w	a5,a5
}
 1f8:	853e                	mv	a0,a5
 1fa:	6462                	ld	s0,24(sp)
 1fc:	6105                	addi	sp,sp,32
 1fe:	8082                	ret

0000000000000200 <strlen>:

uint
strlen(const char *s)
{
 200:	7179                	addi	sp,sp,-48
 202:	f422                	sd	s0,40(sp)
 204:	1800                	addi	s0,sp,48
 206:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 20a:	fe042623          	sw	zero,-20(s0)
 20e:	a031                	j	21a <strlen+0x1a>
 210:	fec42783          	lw	a5,-20(s0)
 214:	2785                	addiw	a5,a5,1
 216:	fef42623          	sw	a5,-20(s0)
 21a:	fec42783          	lw	a5,-20(s0)
 21e:	fd843703          	ld	a4,-40(s0)
 222:	97ba                	add	a5,a5,a4
 224:	0007c783          	lbu	a5,0(a5)
 228:	f7e5                	bnez	a5,210 <strlen+0x10>
    ;
  return n;
 22a:	fec42783          	lw	a5,-20(s0)
}
 22e:	853e                	mv	a0,a5
 230:	7422                	ld	s0,40(sp)
 232:	6145                	addi	sp,sp,48
 234:	8082                	ret

0000000000000236 <memset>:

void*
memset(void *dst, int c, uint n)
{
 236:	7179                	addi	sp,sp,-48
 238:	f422                	sd	s0,40(sp)
 23a:	1800                	addi	s0,sp,48
 23c:	fca43c23          	sd	a0,-40(s0)
 240:	87ae                	mv	a5,a1
 242:	8732                	mv	a4,a2
 244:	fcf42a23          	sw	a5,-44(s0)
 248:	87ba                	mv	a5,a4
 24a:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 24e:	fd843783          	ld	a5,-40(s0)
 252:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 256:	fe042623          	sw	zero,-20(s0)
 25a:	a00d                	j	27c <memset+0x46>
    cdst[i] = c;
 25c:	fec42783          	lw	a5,-20(s0)
 260:	fe043703          	ld	a4,-32(s0)
 264:	97ba                	add	a5,a5,a4
 266:	fd442703          	lw	a4,-44(s0)
 26a:	0ff77713          	zext.b	a4,a4
 26e:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 272:	fec42783          	lw	a5,-20(s0)
 276:	2785                	addiw	a5,a5,1
 278:	fef42623          	sw	a5,-20(s0)
 27c:	fec42703          	lw	a4,-20(s0)
 280:	fd042783          	lw	a5,-48(s0)
 284:	2781                	sext.w	a5,a5
 286:	fcf76be3          	bltu	a4,a5,25c <memset+0x26>
  }
  return dst;
 28a:	fd843783          	ld	a5,-40(s0)
}
 28e:	853e                	mv	a0,a5
 290:	7422                	ld	s0,40(sp)
 292:	6145                	addi	sp,sp,48
 294:	8082                	ret

0000000000000296 <strchr>:

char*
strchr(const char *s, char c)
{
 296:	1101                	addi	sp,sp,-32
 298:	ec22                	sd	s0,24(sp)
 29a:	1000                	addi	s0,sp,32
 29c:	fea43423          	sd	a0,-24(s0)
 2a0:	87ae                	mv	a5,a1
 2a2:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 2a6:	a01d                	j	2cc <strchr+0x36>
    if(*s == c)
 2a8:	fe843783          	ld	a5,-24(s0)
 2ac:	0007c703          	lbu	a4,0(a5)
 2b0:	fe744783          	lbu	a5,-25(s0)
 2b4:	0ff7f793          	zext.b	a5,a5
 2b8:	00e79563          	bne	a5,a4,2c2 <strchr+0x2c>
      return (char*)s;
 2bc:	fe843783          	ld	a5,-24(s0)
 2c0:	a821                	j	2d8 <strchr+0x42>
  for(; *s; s++)
 2c2:	fe843783          	ld	a5,-24(s0)
 2c6:	0785                	addi	a5,a5,1
 2c8:	fef43423          	sd	a5,-24(s0)
 2cc:	fe843783          	ld	a5,-24(s0)
 2d0:	0007c783          	lbu	a5,0(a5)
 2d4:	fbf1                	bnez	a5,2a8 <strchr+0x12>
  return 0;
 2d6:	4781                	li	a5,0
}
 2d8:	853e                	mv	a0,a5
 2da:	6462                	ld	s0,24(sp)
 2dc:	6105                	addi	sp,sp,32
 2de:	8082                	ret

00000000000002e0 <gets>:

char*
gets(char *buf, int max)
{
 2e0:	7179                	addi	sp,sp,-48
 2e2:	f406                	sd	ra,40(sp)
 2e4:	f022                	sd	s0,32(sp)
 2e6:	1800                	addi	s0,sp,48
 2e8:	fca43c23          	sd	a0,-40(s0)
 2ec:	87ae                	mv	a5,a1
 2ee:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f2:	fe042623          	sw	zero,-20(s0)
 2f6:	a8a1                	j	34e <gets+0x6e>
    cc = read(0, &c, 1);
 2f8:	fe740793          	addi	a5,s0,-25
 2fc:	4605                	li	a2,1
 2fe:	85be                	mv	a1,a5
 300:	4501                	li	a0,0
 302:	00000097          	auipc	ra,0x0
 306:	2f8080e7          	jalr	760(ra) # 5fa <read>
 30a:	87aa                	mv	a5,a0
 30c:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 310:	fe842783          	lw	a5,-24(s0)
 314:	2781                	sext.w	a5,a5
 316:	04f05763          	blez	a5,364 <gets+0x84>
      break;
    buf[i++] = c;
 31a:	fec42783          	lw	a5,-20(s0)
 31e:	0017871b          	addiw	a4,a5,1
 322:	fee42623          	sw	a4,-20(s0)
 326:	873e                	mv	a4,a5
 328:	fd843783          	ld	a5,-40(s0)
 32c:	97ba                	add	a5,a5,a4
 32e:	fe744703          	lbu	a4,-25(s0)
 332:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 336:	fe744783          	lbu	a5,-25(s0)
 33a:	873e                	mv	a4,a5
 33c:	47a9                	li	a5,10
 33e:	02f70463          	beq	a4,a5,366 <gets+0x86>
 342:	fe744783          	lbu	a5,-25(s0)
 346:	873e                	mv	a4,a5
 348:	47b5                	li	a5,13
 34a:	00f70e63          	beq	a4,a5,366 <gets+0x86>
  for(i=0; i+1 < max; ){
 34e:	fec42783          	lw	a5,-20(s0)
 352:	2785                	addiw	a5,a5,1
 354:	0007871b          	sext.w	a4,a5
 358:	fd442783          	lw	a5,-44(s0)
 35c:	2781                	sext.w	a5,a5
 35e:	f8f74de3          	blt	a4,a5,2f8 <gets+0x18>
 362:	a011                	j	366 <gets+0x86>
      break;
 364:	0001                	nop
      break;
  }
  buf[i] = '\0';
 366:	fec42783          	lw	a5,-20(s0)
 36a:	fd843703          	ld	a4,-40(s0)
 36e:	97ba                	add	a5,a5,a4
 370:	00078023          	sb	zero,0(a5)
  return buf;
 374:	fd843783          	ld	a5,-40(s0)
}
 378:	853e                	mv	a0,a5
 37a:	70a2                	ld	ra,40(sp)
 37c:	7402                	ld	s0,32(sp)
 37e:	6145                	addi	sp,sp,48
 380:	8082                	ret

0000000000000382 <stat>:

int
stat(const char *n, struct stat *st)
{
 382:	7179                	addi	sp,sp,-48
 384:	f406                	sd	ra,40(sp)
 386:	f022                	sd	s0,32(sp)
 388:	1800                	addi	s0,sp,48
 38a:	fca43c23          	sd	a0,-40(s0)
 38e:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 392:	4581                	li	a1,0
 394:	fd843503          	ld	a0,-40(s0)
 398:	00000097          	auipc	ra,0x0
 39c:	28a080e7          	jalr	650(ra) # 622 <open>
 3a0:	87aa                	mv	a5,a0
 3a2:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 3a6:	fec42783          	lw	a5,-20(s0)
 3aa:	2781                	sext.w	a5,a5
 3ac:	0007d463          	bgez	a5,3b4 <stat+0x32>
    return -1;
 3b0:	57fd                	li	a5,-1
 3b2:	a035                	j	3de <stat+0x5c>
  r = fstat(fd, st);
 3b4:	fec42783          	lw	a5,-20(s0)
 3b8:	fd043583          	ld	a1,-48(s0)
 3bc:	853e                	mv	a0,a5
 3be:	00000097          	auipc	ra,0x0
 3c2:	27c080e7          	jalr	636(ra) # 63a <fstat>
 3c6:	87aa                	mv	a5,a0
 3c8:	fef42423          	sw	a5,-24(s0)
  close(fd);
 3cc:	fec42783          	lw	a5,-20(s0)
 3d0:	853e                	mv	a0,a5
 3d2:	00000097          	auipc	ra,0x0
 3d6:	238080e7          	jalr	568(ra) # 60a <close>
  return r;
 3da:	fe842783          	lw	a5,-24(s0)
}
 3de:	853e                	mv	a0,a5
 3e0:	70a2                	ld	ra,40(sp)
 3e2:	7402                	ld	s0,32(sp)
 3e4:	6145                	addi	sp,sp,48
 3e6:	8082                	ret

00000000000003e8 <atoi>:

int
atoi(const char *s)
{
 3e8:	7179                	addi	sp,sp,-48
 3ea:	f422                	sd	s0,40(sp)
 3ec:	1800                	addi	s0,sp,48
 3ee:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 3f2:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 3f6:	a81d                	j	42c <atoi+0x44>
    n = n*10 + *s++ - '0';
 3f8:	fec42783          	lw	a5,-20(s0)
 3fc:	873e                	mv	a4,a5
 3fe:	87ba                	mv	a5,a4
 400:	0027979b          	slliw	a5,a5,0x2
 404:	9fb9                	addw	a5,a5,a4
 406:	0017979b          	slliw	a5,a5,0x1
 40a:	0007871b          	sext.w	a4,a5
 40e:	fd843783          	ld	a5,-40(s0)
 412:	00178693          	addi	a3,a5,1
 416:	fcd43c23          	sd	a3,-40(s0)
 41a:	0007c783          	lbu	a5,0(a5)
 41e:	2781                	sext.w	a5,a5
 420:	9fb9                	addw	a5,a5,a4
 422:	2781                	sext.w	a5,a5
 424:	fd07879b          	addiw	a5,a5,-48
 428:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 42c:	fd843783          	ld	a5,-40(s0)
 430:	0007c783          	lbu	a5,0(a5)
 434:	873e                	mv	a4,a5
 436:	02f00793          	li	a5,47
 43a:	00e7fb63          	bgeu	a5,a4,450 <atoi+0x68>
 43e:	fd843783          	ld	a5,-40(s0)
 442:	0007c783          	lbu	a5,0(a5)
 446:	873e                	mv	a4,a5
 448:	03900793          	li	a5,57
 44c:	fae7f6e3          	bgeu	a5,a4,3f8 <atoi+0x10>
  return n;
 450:	fec42783          	lw	a5,-20(s0)
}
 454:	853e                	mv	a0,a5
 456:	7422                	ld	s0,40(sp)
 458:	6145                	addi	sp,sp,48
 45a:	8082                	ret

000000000000045c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 45c:	7139                	addi	sp,sp,-64
 45e:	fc22                	sd	s0,56(sp)
 460:	0080                	addi	s0,sp,64
 462:	fca43c23          	sd	a0,-40(s0)
 466:	fcb43823          	sd	a1,-48(s0)
 46a:	87b2                	mv	a5,a2
 46c:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 470:	fd843783          	ld	a5,-40(s0)
 474:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 478:	fd043783          	ld	a5,-48(s0)
 47c:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 480:	fe043703          	ld	a4,-32(s0)
 484:	fe843783          	ld	a5,-24(s0)
 488:	02e7fc63          	bgeu	a5,a4,4c0 <memmove+0x64>
    while(n-- > 0)
 48c:	a00d                	j	4ae <memmove+0x52>
      *dst++ = *src++;
 48e:	fe043703          	ld	a4,-32(s0)
 492:	00170793          	addi	a5,a4,1
 496:	fef43023          	sd	a5,-32(s0)
 49a:	fe843783          	ld	a5,-24(s0)
 49e:	00178693          	addi	a3,a5,1
 4a2:	fed43423          	sd	a3,-24(s0)
 4a6:	00074703          	lbu	a4,0(a4)
 4aa:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4ae:	fcc42783          	lw	a5,-52(s0)
 4b2:	fff7871b          	addiw	a4,a5,-1
 4b6:	fce42623          	sw	a4,-52(s0)
 4ba:	fcf04ae3          	bgtz	a5,48e <memmove+0x32>
 4be:	a891                	j	512 <memmove+0xb6>
  } else {
    dst += n;
 4c0:	fcc42783          	lw	a5,-52(s0)
 4c4:	fe843703          	ld	a4,-24(s0)
 4c8:	97ba                	add	a5,a5,a4
 4ca:	fef43423          	sd	a5,-24(s0)
    src += n;
 4ce:	fcc42783          	lw	a5,-52(s0)
 4d2:	fe043703          	ld	a4,-32(s0)
 4d6:	97ba                	add	a5,a5,a4
 4d8:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 4dc:	a01d                	j	502 <memmove+0xa6>
      *--dst = *--src;
 4de:	fe043783          	ld	a5,-32(s0)
 4e2:	17fd                	addi	a5,a5,-1
 4e4:	fef43023          	sd	a5,-32(s0)
 4e8:	fe843783          	ld	a5,-24(s0)
 4ec:	17fd                	addi	a5,a5,-1
 4ee:	fef43423          	sd	a5,-24(s0)
 4f2:	fe043783          	ld	a5,-32(s0)
 4f6:	0007c703          	lbu	a4,0(a5)
 4fa:	fe843783          	ld	a5,-24(s0)
 4fe:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 502:	fcc42783          	lw	a5,-52(s0)
 506:	fff7871b          	addiw	a4,a5,-1
 50a:	fce42623          	sw	a4,-52(s0)
 50e:	fcf048e3          	bgtz	a5,4de <memmove+0x82>
  }
  return vdst;
 512:	fd843783          	ld	a5,-40(s0)
}
 516:	853e                	mv	a0,a5
 518:	7462                	ld	s0,56(sp)
 51a:	6121                	addi	sp,sp,64
 51c:	8082                	ret

000000000000051e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 51e:	7139                	addi	sp,sp,-64
 520:	fc22                	sd	s0,56(sp)
 522:	0080                	addi	s0,sp,64
 524:	fca43c23          	sd	a0,-40(s0)
 528:	fcb43823          	sd	a1,-48(s0)
 52c:	87b2                	mv	a5,a2
 52e:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 532:	fd843783          	ld	a5,-40(s0)
 536:	fef43423          	sd	a5,-24(s0)
 53a:	fd043783          	ld	a5,-48(s0)
 53e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 542:	a0a1                	j	58a <memcmp+0x6c>
    if (*p1 != *p2) {
 544:	fe843783          	ld	a5,-24(s0)
 548:	0007c703          	lbu	a4,0(a5)
 54c:	fe043783          	ld	a5,-32(s0)
 550:	0007c783          	lbu	a5,0(a5)
 554:	02f70163          	beq	a4,a5,576 <memcmp+0x58>
      return *p1 - *p2;
 558:	fe843783          	ld	a5,-24(s0)
 55c:	0007c783          	lbu	a5,0(a5)
 560:	0007871b          	sext.w	a4,a5
 564:	fe043783          	ld	a5,-32(s0)
 568:	0007c783          	lbu	a5,0(a5)
 56c:	2781                	sext.w	a5,a5
 56e:	40f707bb          	subw	a5,a4,a5
 572:	2781                	sext.w	a5,a5
 574:	a01d                	j	59a <memcmp+0x7c>
    }
    p1++;
 576:	fe843783          	ld	a5,-24(s0)
 57a:	0785                	addi	a5,a5,1
 57c:	fef43423          	sd	a5,-24(s0)
    p2++;
 580:	fe043783          	ld	a5,-32(s0)
 584:	0785                	addi	a5,a5,1
 586:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 58a:	fcc42783          	lw	a5,-52(s0)
 58e:	fff7871b          	addiw	a4,a5,-1
 592:	fce42623          	sw	a4,-52(s0)
 596:	f7dd                	bnez	a5,544 <memcmp+0x26>
  }
  return 0;
 598:	4781                	li	a5,0
}
 59a:	853e                	mv	a0,a5
 59c:	7462                	ld	s0,56(sp)
 59e:	6121                	addi	sp,sp,64
 5a0:	8082                	ret

00000000000005a2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5a2:	7179                	addi	sp,sp,-48
 5a4:	f406                	sd	ra,40(sp)
 5a6:	f022                	sd	s0,32(sp)
 5a8:	1800                	addi	s0,sp,48
 5aa:	fea43423          	sd	a0,-24(s0)
 5ae:	feb43023          	sd	a1,-32(s0)
 5b2:	87b2                	mv	a5,a2
 5b4:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 5b8:	fdc42783          	lw	a5,-36(s0)
 5bc:	863e                	mv	a2,a5
 5be:	fe043583          	ld	a1,-32(s0)
 5c2:	fe843503          	ld	a0,-24(s0)
 5c6:	00000097          	auipc	ra,0x0
 5ca:	e96080e7          	jalr	-362(ra) # 45c <memmove>
 5ce:	87aa                	mv	a5,a0
}
 5d0:	853e                	mv	a0,a5
 5d2:	70a2                	ld	ra,40(sp)
 5d4:	7402                	ld	s0,32(sp)
 5d6:	6145                	addi	sp,sp,48
 5d8:	8082                	ret

00000000000005da <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5da:	4885                	li	a7,1
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5e2:	4889                	li	a7,2
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <wait>:
.global wait
wait:
 li a7, SYS_wait
 5ea:	488d                	li	a7,3
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5f2:	4891                	li	a7,4
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <read>:
.global read
read:
 li a7, SYS_read
 5fa:	4895                	li	a7,5
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <write>:
.global write
write:
 li a7, SYS_write
 602:	48c1                	li	a7,16
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <close>:
.global close
close:
 li a7, SYS_close
 60a:	48d5                	li	a7,21
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <kill>:
.global kill
kill:
 li a7, SYS_kill
 612:	4899                	li	a7,6
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <exec>:
.global exec
exec:
 li a7, SYS_exec
 61a:	489d                	li	a7,7
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <open>:
.global open
open:
 li a7, SYS_open
 622:	48bd                	li	a7,15
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 62a:	48c5                	li	a7,17
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 632:	48c9                	li	a7,18
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 63a:	48a1                	li	a7,8
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <link>:
.global link
link:
 li a7, SYS_link
 642:	48cd                	li	a7,19
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 64a:	48d1                	li	a7,20
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 652:	48a5                	li	a7,9
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <dup>:
.global dup
dup:
 li a7, SYS_dup
 65a:	48a9                	li	a7,10
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 662:	48ad                	li	a7,11
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 66a:	48b1                	li	a7,12
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 672:	48b5                	li	a7,13
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 67a:	48b9                	li	a7,14
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <clone>:
.global clone
clone:
 li a7, SYS_clone
 682:	48d9                	li	a7,22
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <join>:
.global join
join:
 li a7, SYS_join
 68a:	48dd                	li	a7,23
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 692:	1101                	addi	sp,sp,-32
 694:	ec06                	sd	ra,24(sp)
 696:	e822                	sd	s0,16(sp)
 698:	1000                	addi	s0,sp,32
 69a:	87aa                	mv	a5,a0
 69c:	872e                	mv	a4,a1
 69e:	fef42623          	sw	a5,-20(s0)
 6a2:	87ba                	mv	a5,a4
 6a4:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 6a8:	feb40713          	addi	a4,s0,-21
 6ac:	fec42783          	lw	a5,-20(s0)
 6b0:	4605                	li	a2,1
 6b2:	85ba                	mv	a1,a4
 6b4:	853e                	mv	a0,a5
 6b6:	00000097          	auipc	ra,0x0
 6ba:	f4c080e7          	jalr	-180(ra) # 602 <write>
}
 6be:	0001                	nop
 6c0:	60e2                	ld	ra,24(sp)
 6c2:	6442                	ld	s0,16(sp)
 6c4:	6105                	addi	sp,sp,32
 6c6:	8082                	ret

00000000000006c8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6c8:	7139                	addi	sp,sp,-64
 6ca:	fc06                	sd	ra,56(sp)
 6cc:	f822                	sd	s0,48(sp)
 6ce:	0080                	addi	s0,sp,64
 6d0:	87aa                	mv	a5,a0
 6d2:	8736                	mv	a4,a3
 6d4:	fcf42623          	sw	a5,-52(s0)
 6d8:	87ae                	mv	a5,a1
 6da:	fcf42423          	sw	a5,-56(s0)
 6de:	87b2                	mv	a5,a2
 6e0:	fcf42223          	sw	a5,-60(s0)
 6e4:	87ba                	mv	a5,a4
 6e6:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6ea:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 6ee:	fc042783          	lw	a5,-64(s0)
 6f2:	2781                	sext.w	a5,a5
 6f4:	c38d                	beqz	a5,716 <printint+0x4e>
 6f6:	fc842783          	lw	a5,-56(s0)
 6fa:	2781                	sext.w	a5,a5
 6fc:	0007dd63          	bgez	a5,716 <printint+0x4e>
    neg = 1;
 700:	4785                	li	a5,1
 702:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 706:	fc842783          	lw	a5,-56(s0)
 70a:	40f007bb          	negw	a5,a5
 70e:	2781                	sext.w	a5,a5
 710:	fef42223          	sw	a5,-28(s0)
 714:	a029                	j	71e <printint+0x56>
  } else {
    x = xx;
 716:	fc842783          	lw	a5,-56(s0)
 71a:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 71e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 722:	fc442783          	lw	a5,-60(s0)
 726:	fe442703          	lw	a4,-28(s0)
 72a:	02f777bb          	remuw	a5,a4,a5
 72e:	0007861b          	sext.w	a2,a5
 732:	fec42783          	lw	a5,-20(s0)
 736:	0017871b          	addiw	a4,a5,1
 73a:	fee42623          	sw	a4,-20(s0)
 73e:	00001697          	auipc	a3,0x1
 742:	8f268693          	addi	a3,a3,-1806 # 1030 <digits>
 746:	02061713          	slli	a4,a2,0x20
 74a:	9301                	srli	a4,a4,0x20
 74c:	9736                	add	a4,a4,a3
 74e:	00074703          	lbu	a4,0(a4)
 752:	17c1                	addi	a5,a5,-16
 754:	97a2                	add	a5,a5,s0
 756:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 75a:	fc442783          	lw	a5,-60(s0)
 75e:	fe442703          	lw	a4,-28(s0)
 762:	02f757bb          	divuw	a5,a4,a5
 766:	fef42223          	sw	a5,-28(s0)
 76a:	fe442783          	lw	a5,-28(s0)
 76e:	2781                	sext.w	a5,a5
 770:	fbcd                	bnez	a5,722 <printint+0x5a>
  if(neg)
 772:	fe842783          	lw	a5,-24(s0)
 776:	2781                	sext.w	a5,a5
 778:	cf85                	beqz	a5,7b0 <printint+0xe8>
    buf[i++] = '-';
 77a:	fec42783          	lw	a5,-20(s0)
 77e:	0017871b          	addiw	a4,a5,1
 782:	fee42623          	sw	a4,-20(s0)
 786:	17c1                	addi	a5,a5,-16
 788:	97a2                	add	a5,a5,s0
 78a:	02d00713          	li	a4,45
 78e:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 792:	a839                	j	7b0 <printint+0xe8>
    putc(fd, buf[i]);
 794:	fec42783          	lw	a5,-20(s0)
 798:	17c1                	addi	a5,a5,-16
 79a:	97a2                	add	a5,a5,s0
 79c:	fe07c703          	lbu	a4,-32(a5)
 7a0:	fcc42783          	lw	a5,-52(s0)
 7a4:	85ba                	mv	a1,a4
 7a6:	853e                	mv	a0,a5
 7a8:	00000097          	auipc	ra,0x0
 7ac:	eea080e7          	jalr	-278(ra) # 692 <putc>
  while(--i >= 0)
 7b0:	fec42783          	lw	a5,-20(s0)
 7b4:	37fd                	addiw	a5,a5,-1
 7b6:	fef42623          	sw	a5,-20(s0)
 7ba:	fec42783          	lw	a5,-20(s0)
 7be:	2781                	sext.w	a5,a5
 7c0:	fc07dae3          	bgez	a5,794 <printint+0xcc>
}
 7c4:	0001                	nop
 7c6:	0001                	nop
 7c8:	70e2                	ld	ra,56(sp)
 7ca:	7442                	ld	s0,48(sp)
 7cc:	6121                	addi	sp,sp,64
 7ce:	8082                	ret

00000000000007d0 <printptr>:

static void
printptr(int fd, uint64 x) {
 7d0:	7179                	addi	sp,sp,-48
 7d2:	f406                	sd	ra,40(sp)
 7d4:	f022                	sd	s0,32(sp)
 7d6:	1800                	addi	s0,sp,48
 7d8:	87aa                	mv	a5,a0
 7da:	fcb43823          	sd	a1,-48(s0)
 7de:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 7e2:	fdc42783          	lw	a5,-36(s0)
 7e6:	03000593          	li	a1,48
 7ea:	853e                	mv	a0,a5
 7ec:	00000097          	auipc	ra,0x0
 7f0:	ea6080e7          	jalr	-346(ra) # 692 <putc>
  putc(fd, 'x');
 7f4:	fdc42783          	lw	a5,-36(s0)
 7f8:	07800593          	li	a1,120
 7fc:	853e                	mv	a0,a5
 7fe:	00000097          	auipc	ra,0x0
 802:	e94080e7          	jalr	-364(ra) # 692 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 806:	fe042623          	sw	zero,-20(s0)
 80a:	a82d                	j	844 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 80c:	fd043783          	ld	a5,-48(s0)
 810:	93f1                	srli	a5,a5,0x3c
 812:	00001717          	auipc	a4,0x1
 816:	81e70713          	addi	a4,a4,-2018 # 1030 <digits>
 81a:	97ba                	add	a5,a5,a4
 81c:	0007c703          	lbu	a4,0(a5)
 820:	fdc42783          	lw	a5,-36(s0)
 824:	85ba                	mv	a1,a4
 826:	853e                	mv	a0,a5
 828:	00000097          	auipc	ra,0x0
 82c:	e6a080e7          	jalr	-406(ra) # 692 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 830:	fec42783          	lw	a5,-20(s0)
 834:	2785                	addiw	a5,a5,1
 836:	fef42623          	sw	a5,-20(s0)
 83a:	fd043783          	ld	a5,-48(s0)
 83e:	0792                	slli	a5,a5,0x4
 840:	fcf43823          	sd	a5,-48(s0)
 844:	fec42783          	lw	a5,-20(s0)
 848:	873e                	mv	a4,a5
 84a:	47bd                	li	a5,15
 84c:	fce7f0e3          	bgeu	a5,a4,80c <printptr+0x3c>
}
 850:	0001                	nop
 852:	0001                	nop
 854:	70a2                	ld	ra,40(sp)
 856:	7402                	ld	s0,32(sp)
 858:	6145                	addi	sp,sp,48
 85a:	8082                	ret

000000000000085c <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 85c:	715d                	addi	sp,sp,-80
 85e:	e486                	sd	ra,72(sp)
 860:	e0a2                	sd	s0,64(sp)
 862:	0880                	addi	s0,sp,80
 864:	87aa                	mv	a5,a0
 866:	fcb43023          	sd	a1,-64(s0)
 86a:	fac43c23          	sd	a2,-72(s0)
 86e:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 872:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 876:	fe042223          	sw	zero,-28(s0)
 87a:	a42d                	j	aa4 <vprintf+0x248>
    c = fmt[i] & 0xff;
 87c:	fe442783          	lw	a5,-28(s0)
 880:	fc043703          	ld	a4,-64(s0)
 884:	97ba                	add	a5,a5,a4
 886:	0007c783          	lbu	a5,0(a5)
 88a:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 88e:	fe042783          	lw	a5,-32(s0)
 892:	2781                	sext.w	a5,a5
 894:	eb9d                	bnez	a5,8ca <vprintf+0x6e>
      if(c == '%'){
 896:	fdc42783          	lw	a5,-36(s0)
 89a:	0007871b          	sext.w	a4,a5
 89e:	02500793          	li	a5,37
 8a2:	00f71763          	bne	a4,a5,8b0 <vprintf+0x54>
        state = '%';
 8a6:	02500793          	li	a5,37
 8aa:	fef42023          	sw	a5,-32(s0)
 8ae:	a2f5                	j	a9a <vprintf+0x23e>
      } else {
        putc(fd, c);
 8b0:	fdc42783          	lw	a5,-36(s0)
 8b4:	0ff7f713          	zext.b	a4,a5
 8b8:	fcc42783          	lw	a5,-52(s0)
 8bc:	85ba                	mv	a1,a4
 8be:	853e                	mv	a0,a5
 8c0:	00000097          	auipc	ra,0x0
 8c4:	dd2080e7          	jalr	-558(ra) # 692 <putc>
 8c8:	aac9                	j	a9a <vprintf+0x23e>
      }
    } else if(state == '%'){
 8ca:	fe042783          	lw	a5,-32(s0)
 8ce:	0007871b          	sext.w	a4,a5
 8d2:	02500793          	li	a5,37
 8d6:	1cf71263          	bne	a4,a5,a9a <vprintf+0x23e>
      if(c == 'd'){
 8da:	fdc42783          	lw	a5,-36(s0)
 8de:	0007871b          	sext.w	a4,a5
 8e2:	06400793          	li	a5,100
 8e6:	02f71463          	bne	a4,a5,90e <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 8ea:	fb843783          	ld	a5,-72(s0)
 8ee:	00878713          	addi	a4,a5,8
 8f2:	fae43c23          	sd	a4,-72(s0)
 8f6:	4398                	lw	a4,0(a5)
 8f8:	fcc42783          	lw	a5,-52(s0)
 8fc:	4685                	li	a3,1
 8fe:	4629                	li	a2,10
 900:	85ba                	mv	a1,a4
 902:	853e                	mv	a0,a5
 904:	00000097          	auipc	ra,0x0
 908:	dc4080e7          	jalr	-572(ra) # 6c8 <printint>
 90c:	a269                	j	a96 <vprintf+0x23a>
      } else if(c == 'l') {
 90e:	fdc42783          	lw	a5,-36(s0)
 912:	0007871b          	sext.w	a4,a5
 916:	06c00793          	li	a5,108
 91a:	02f71663          	bne	a4,a5,946 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 91e:	fb843783          	ld	a5,-72(s0)
 922:	00878713          	addi	a4,a5,8
 926:	fae43c23          	sd	a4,-72(s0)
 92a:	639c                	ld	a5,0(a5)
 92c:	0007871b          	sext.w	a4,a5
 930:	fcc42783          	lw	a5,-52(s0)
 934:	4681                	li	a3,0
 936:	4629                	li	a2,10
 938:	85ba                	mv	a1,a4
 93a:	853e                	mv	a0,a5
 93c:	00000097          	auipc	ra,0x0
 940:	d8c080e7          	jalr	-628(ra) # 6c8 <printint>
 944:	aa89                	j	a96 <vprintf+0x23a>
      } else if(c == 'x') {
 946:	fdc42783          	lw	a5,-36(s0)
 94a:	0007871b          	sext.w	a4,a5
 94e:	07800793          	li	a5,120
 952:	02f71463          	bne	a4,a5,97a <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 956:	fb843783          	ld	a5,-72(s0)
 95a:	00878713          	addi	a4,a5,8
 95e:	fae43c23          	sd	a4,-72(s0)
 962:	4398                	lw	a4,0(a5)
 964:	fcc42783          	lw	a5,-52(s0)
 968:	4681                	li	a3,0
 96a:	4641                	li	a2,16
 96c:	85ba                	mv	a1,a4
 96e:	853e                	mv	a0,a5
 970:	00000097          	auipc	ra,0x0
 974:	d58080e7          	jalr	-680(ra) # 6c8 <printint>
 978:	aa39                	j	a96 <vprintf+0x23a>
      } else if(c == 'p') {
 97a:	fdc42783          	lw	a5,-36(s0)
 97e:	0007871b          	sext.w	a4,a5
 982:	07000793          	li	a5,112
 986:	02f71263          	bne	a4,a5,9aa <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 98a:	fb843783          	ld	a5,-72(s0)
 98e:	00878713          	addi	a4,a5,8
 992:	fae43c23          	sd	a4,-72(s0)
 996:	6398                	ld	a4,0(a5)
 998:	fcc42783          	lw	a5,-52(s0)
 99c:	85ba                	mv	a1,a4
 99e:	853e                	mv	a0,a5
 9a0:	00000097          	auipc	ra,0x0
 9a4:	e30080e7          	jalr	-464(ra) # 7d0 <printptr>
 9a8:	a0fd                	j	a96 <vprintf+0x23a>
      } else if(c == 's'){
 9aa:	fdc42783          	lw	a5,-36(s0)
 9ae:	0007871b          	sext.w	a4,a5
 9b2:	07300793          	li	a5,115
 9b6:	04f71c63          	bne	a4,a5,a0e <vprintf+0x1b2>
        s = va_arg(ap, char*);
 9ba:	fb843783          	ld	a5,-72(s0)
 9be:	00878713          	addi	a4,a5,8
 9c2:	fae43c23          	sd	a4,-72(s0)
 9c6:	639c                	ld	a5,0(a5)
 9c8:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 9cc:	fe843783          	ld	a5,-24(s0)
 9d0:	eb8d                	bnez	a5,a02 <vprintf+0x1a6>
          s = "(null)";
 9d2:	00000797          	auipc	a5,0x0
 9d6:	60678793          	addi	a5,a5,1542 # fd8 <lock_init+0x86>
 9da:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 9de:	a015                	j	a02 <vprintf+0x1a6>
          putc(fd, *s);
 9e0:	fe843783          	ld	a5,-24(s0)
 9e4:	0007c703          	lbu	a4,0(a5)
 9e8:	fcc42783          	lw	a5,-52(s0)
 9ec:	85ba                	mv	a1,a4
 9ee:	853e                	mv	a0,a5
 9f0:	00000097          	auipc	ra,0x0
 9f4:	ca2080e7          	jalr	-862(ra) # 692 <putc>
          s++;
 9f8:	fe843783          	ld	a5,-24(s0)
 9fc:	0785                	addi	a5,a5,1
 9fe:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 a02:	fe843783          	ld	a5,-24(s0)
 a06:	0007c783          	lbu	a5,0(a5)
 a0a:	fbf9                	bnez	a5,9e0 <vprintf+0x184>
 a0c:	a069                	j	a96 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 a0e:	fdc42783          	lw	a5,-36(s0)
 a12:	0007871b          	sext.w	a4,a5
 a16:	06300793          	li	a5,99
 a1a:	02f71463          	bne	a4,a5,a42 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 a1e:	fb843783          	ld	a5,-72(s0)
 a22:	00878713          	addi	a4,a5,8
 a26:	fae43c23          	sd	a4,-72(s0)
 a2a:	439c                	lw	a5,0(a5)
 a2c:	0ff7f713          	zext.b	a4,a5
 a30:	fcc42783          	lw	a5,-52(s0)
 a34:	85ba                	mv	a1,a4
 a36:	853e                	mv	a0,a5
 a38:	00000097          	auipc	ra,0x0
 a3c:	c5a080e7          	jalr	-934(ra) # 692 <putc>
 a40:	a899                	j	a96 <vprintf+0x23a>
      } else if(c == '%'){
 a42:	fdc42783          	lw	a5,-36(s0)
 a46:	0007871b          	sext.w	a4,a5
 a4a:	02500793          	li	a5,37
 a4e:	00f71f63          	bne	a4,a5,a6c <vprintf+0x210>
        putc(fd, c);
 a52:	fdc42783          	lw	a5,-36(s0)
 a56:	0ff7f713          	zext.b	a4,a5
 a5a:	fcc42783          	lw	a5,-52(s0)
 a5e:	85ba                	mv	a1,a4
 a60:	853e                	mv	a0,a5
 a62:	00000097          	auipc	ra,0x0
 a66:	c30080e7          	jalr	-976(ra) # 692 <putc>
 a6a:	a035                	j	a96 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a6c:	fcc42783          	lw	a5,-52(s0)
 a70:	02500593          	li	a1,37
 a74:	853e                	mv	a0,a5
 a76:	00000097          	auipc	ra,0x0
 a7a:	c1c080e7          	jalr	-996(ra) # 692 <putc>
        putc(fd, c);
 a7e:	fdc42783          	lw	a5,-36(s0)
 a82:	0ff7f713          	zext.b	a4,a5
 a86:	fcc42783          	lw	a5,-52(s0)
 a8a:	85ba                	mv	a1,a4
 a8c:	853e                	mv	a0,a5
 a8e:	00000097          	auipc	ra,0x0
 a92:	c04080e7          	jalr	-1020(ra) # 692 <putc>
      }
      state = 0;
 a96:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 a9a:	fe442783          	lw	a5,-28(s0)
 a9e:	2785                	addiw	a5,a5,1
 aa0:	fef42223          	sw	a5,-28(s0)
 aa4:	fe442783          	lw	a5,-28(s0)
 aa8:	fc043703          	ld	a4,-64(s0)
 aac:	97ba                	add	a5,a5,a4
 aae:	0007c783          	lbu	a5,0(a5)
 ab2:	dc0795e3          	bnez	a5,87c <vprintf+0x20>
    }
  }
}
 ab6:	0001                	nop
 ab8:	0001                	nop
 aba:	60a6                	ld	ra,72(sp)
 abc:	6406                	ld	s0,64(sp)
 abe:	6161                	addi	sp,sp,80
 ac0:	8082                	ret

0000000000000ac2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ac2:	7159                	addi	sp,sp,-112
 ac4:	fc06                	sd	ra,56(sp)
 ac6:	f822                	sd	s0,48(sp)
 ac8:	0080                	addi	s0,sp,64
 aca:	fcb43823          	sd	a1,-48(s0)
 ace:	e010                	sd	a2,0(s0)
 ad0:	e414                	sd	a3,8(s0)
 ad2:	e818                	sd	a4,16(s0)
 ad4:	ec1c                	sd	a5,24(s0)
 ad6:	03043023          	sd	a6,32(s0)
 ada:	03143423          	sd	a7,40(s0)
 ade:	87aa                	mv	a5,a0
 ae0:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 ae4:	03040793          	addi	a5,s0,48
 ae8:	fcf43423          	sd	a5,-56(s0)
 aec:	fc843783          	ld	a5,-56(s0)
 af0:	fd078793          	addi	a5,a5,-48
 af4:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 af8:	fe843703          	ld	a4,-24(s0)
 afc:	fdc42783          	lw	a5,-36(s0)
 b00:	863a                	mv	a2,a4
 b02:	fd043583          	ld	a1,-48(s0)
 b06:	853e                	mv	a0,a5
 b08:	00000097          	auipc	ra,0x0
 b0c:	d54080e7          	jalr	-684(ra) # 85c <vprintf>
}
 b10:	0001                	nop
 b12:	70e2                	ld	ra,56(sp)
 b14:	7442                	ld	s0,48(sp)
 b16:	6165                	addi	sp,sp,112
 b18:	8082                	ret

0000000000000b1a <printf>:

void
printf(const char *fmt, ...)
{
 b1a:	7159                	addi	sp,sp,-112
 b1c:	f406                	sd	ra,40(sp)
 b1e:	f022                	sd	s0,32(sp)
 b20:	1800                	addi	s0,sp,48
 b22:	fca43c23          	sd	a0,-40(s0)
 b26:	e40c                	sd	a1,8(s0)
 b28:	e810                	sd	a2,16(s0)
 b2a:	ec14                	sd	a3,24(s0)
 b2c:	f018                	sd	a4,32(s0)
 b2e:	f41c                	sd	a5,40(s0)
 b30:	03043823          	sd	a6,48(s0)
 b34:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b38:	04040793          	addi	a5,s0,64
 b3c:	fcf43823          	sd	a5,-48(s0)
 b40:	fd043783          	ld	a5,-48(s0)
 b44:	fc878793          	addi	a5,a5,-56
 b48:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 b4c:	fe843783          	ld	a5,-24(s0)
 b50:	863e                	mv	a2,a5
 b52:	fd843583          	ld	a1,-40(s0)
 b56:	4505                	li	a0,1
 b58:	00000097          	auipc	ra,0x0
 b5c:	d04080e7          	jalr	-764(ra) # 85c <vprintf>
}
 b60:	0001                	nop
 b62:	70a2                	ld	ra,40(sp)
 b64:	7402                	ld	s0,32(sp)
 b66:	6165                	addi	sp,sp,112
 b68:	8082                	ret

0000000000000b6a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b6a:	7179                	addi	sp,sp,-48
 b6c:	f422                	sd	s0,40(sp)
 b6e:	1800                	addi	s0,sp,48
 b70:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b74:	fd843783          	ld	a5,-40(s0)
 b78:	17c1                	addi	a5,a5,-16
 b7a:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b7e:	00000797          	auipc	a5,0x0
 b82:	4e278793          	addi	a5,a5,1250 # 1060 <freep>
 b86:	639c                	ld	a5,0(a5)
 b88:	fef43423          	sd	a5,-24(s0)
 b8c:	a815                	j	bc0 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b8e:	fe843783          	ld	a5,-24(s0)
 b92:	639c                	ld	a5,0(a5)
 b94:	fe843703          	ld	a4,-24(s0)
 b98:	00f76f63          	bltu	a4,a5,bb6 <free+0x4c>
 b9c:	fe043703          	ld	a4,-32(s0)
 ba0:	fe843783          	ld	a5,-24(s0)
 ba4:	02e7eb63          	bltu	a5,a4,bda <free+0x70>
 ba8:	fe843783          	ld	a5,-24(s0)
 bac:	639c                	ld	a5,0(a5)
 bae:	fe043703          	ld	a4,-32(s0)
 bb2:	02f76463          	bltu	a4,a5,bda <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bb6:	fe843783          	ld	a5,-24(s0)
 bba:	639c                	ld	a5,0(a5)
 bbc:	fef43423          	sd	a5,-24(s0)
 bc0:	fe043703          	ld	a4,-32(s0)
 bc4:	fe843783          	ld	a5,-24(s0)
 bc8:	fce7f3e3          	bgeu	a5,a4,b8e <free+0x24>
 bcc:	fe843783          	ld	a5,-24(s0)
 bd0:	639c                	ld	a5,0(a5)
 bd2:	fe043703          	ld	a4,-32(s0)
 bd6:	faf77ce3          	bgeu	a4,a5,b8e <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 bda:	fe043783          	ld	a5,-32(s0)
 bde:	479c                	lw	a5,8(a5)
 be0:	1782                	slli	a5,a5,0x20
 be2:	9381                	srli	a5,a5,0x20
 be4:	0792                	slli	a5,a5,0x4
 be6:	fe043703          	ld	a4,-32(s0)
 bea:	973e                	add	a4,a4,a5
 bec:	fe843783          	ld	a5,-24(s0)
 bf0:	639c                	ld	a5,0(a5)
 bf2:	02f71763          	bne	a4,a5,c20 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 bf6:	fe043783          	ld	a5,-32(s0)
 bfa:	4798                	lw	a4,8(a5)
 bfc:	fe843783          	ld	a5,-24(s0)
 c00:	639c                	ld	a5,0(a5)
 c02:	479c                	lw	a5,8(a5)
 c04:	9fb9                	addw	a5,a5,a4
 c06:	0007871b          	sext.w	a4,a5
 c0a:	fe043783          	ld	a5,-32(s0)
 c0e:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 c10:	fe843783          	ld	a5,-24(s0)
 c14:	639c                	ld	a5,0(a5)
 c16:	6398                	ld	a4,0(a5)
 c18:	fe043783          	ld	a5,-32(s0)
 c1c:	e398                	sd	a4,0(a5)
 c1e:	a039                	j	c2c <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 c20:	fe843783          	ld	a5,-24(s0)
 c24:	6398                	ld	a4,0(a5)
 c26:	fe043783          	ld	a5,-32(s0)
 c2a:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 c2c:	fe843783          	ld	a5,-24(s0)
 c30:	479c                	lw	a5,8(a5)
 c32:	1782                	slli	a5,a5,0x20
 c34:	9381                	srli	a5,a5,0x20
 c36:	0792                	slli	a5,a5,0x4
 c38:	fe843703          	ld	a4,-24(s0)
 c3c:	97ba                	add	a5,a5,a4
 c3e:	fe043703          	ld	a4,-32(s0)
 c42:	02f71563          	bne	a4,a5,c6c <free+0x102>
    p->s.size += bp->s.size;
 c46:	fe843783          	ld	a5,-24(s0)
 c4a:	4798                	lw	a4,8(a5)
 c4c:	fe043783          	ld	a5,-32(s0)
 c50:	479c                	lw	a5,8(a5)
 c52:	9fb9                	addw	a5,a5,a4
 c54:	0007871b          	sext.w	a4,a5
 c58:	fe843783          	ld	a5,-24(s0)
 c5c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c5e:	fe043783          	ld	a5,-32(s0)
 c62:	6398                	ld	a4,0(a5)
 c64:	fe843783          	ld	a5,-24(s0)
 c68:	e398                	sd	a4,0(a5)
 c6a:	a031                	j	c76 <free+0x10c>
  } else
    p->s.ptr = bp;
 c6c:	fe843783          	ld	a5,-24(s0)
 c70:	fe043703          	ld	a4,-32(s0)
 c74:	e398                	sd	a4,0(a5)
  freep = p;
 c76:	00000797          	auipc	a5,0x0
 c7a:	3ea78793          	addi	a5,a5,1002 # 1060 <freep>
 c7e:	fe843703          	ld	a4,-24(s0)
 c82:	e398                	sd	a4,0(a5)
}
 c84:	0001                	nop
 c86:	7422                	ld	s0,40(sp)
 c88:	6145                	addi	sp,sp,48
 c8a:	8082                	ret

0000000000000c8c <morecore>:

static Header*
morecore(uint nu)
{
 c8c:	7179                	addi	sp,sp,-48
 c8e:	f406                	sd	ra,40(sp)
 c90:	f022                	sd	s0,32(sp)
 c92:	1800                	addi	s0,sp,48
 c94:	87aa                	mv	a5,a0
 c96:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 c9a:	fdc42783          	lw	a5,-36(s0)
 c9e:	0007871b          	sext.w	a4,a5
 ca2:	6785                	lui	a5,0x1
 ca4:	00f77563          	bgeu	a4,a5,cae <morecore+0x22>
    nu = 4096;
 ca8:	6785                	lui	a5,0x1
 caa:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 cae:	fdc42783          	lw	a5,-36(s0)
 cb2:	0047979b          	slliw	a5,a5,0x4
 cb6:	2781                	sext.w	a5,a5
 cb8:	2781                	sext.w	a5,a5
 cba:	853e                	mv	a0,a5
 cbc:	00000097          	auipc	ra,0x0
 cc0:	9ae080e7          	jalr	-1618(ra) # 66a <sbrk>
 cc4:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 cc8:	fe843703          	ld	a4,-24(s0)
 ccc:	57fd                	li	a5,-1
 cce:	00f71463          	bne	a4,a5,cd6 <morecore+0x4a>
    return 0;
 cd2:	4781                	li	a5,0
 cd4:	a03d                	j	d02 <morecore+0x76>
  hp = (Header*)p;
 cd6:	fe843783          	ld	a5,-24(s0)
 cda:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 cde:	fe043783          	ld	a5,-32(s0)
 ce2:	fdc42703          	lw	a4,-36(s0)
 ce6:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 ce8:	fe043783          	ld	a5,-32(s0)
 cec:	07c1                	addi	a5,a5,16
 cee:	853e                	mv	a0,a5
 cf0:	00000097          	auipc	ra,0x0
 cf4:	e7a080e7          	jalr	-390(ra) # b6a <free>
  return freep;
 cf8:	00000797          	auipc	a5,0x0
 cfc:	36878793          	addi	a5,a5,872 # 1060 <freep>
 d00:	639c                	ld	a5,0(a5)
}
 d02:	853e                	mv	a0,a5
 d04:	70a2                	ld	ra,40(sp)
 d06:	7402                	ld	s0,32(sp)
 d08:	6145                	addi	sp,sp,48
 d0a:	8082                	ret

0000000000000d0c <malloc>:

void*
malloc(uint nbytes)
{
 d0c:	7139                	addi	sp,sp,-64
 d0e:	fc06                	sd	ra,56(sp)
 d10:	f822                	sd	s0,48(sp)
 d12:	0080                	addi	s0,sp,64
 d14:	87aa                	mv	a5,a0
 d16:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d1a:	fcc46783          	lwu	a5,-52(s0)
 d1e:	07bd                	addi	a5,a5,15
 d20:	8391                	srli	a5,a5,0x4
 d22:	2781                	sext.w	a5,a5
 d24:	2785                	addiw	a5,a5,1
 d26:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 d2a:	00000797          	auipc	a5,0x0
 d2e:	33678793          	addi	a5,a5,822 # 1060 <freep>
 d32:	639c                	ld	a5,0(a5)
 d34:	fef43023          	sd	a5,-32(s0)
 d38:	fe043783          	ld	a5,-32(s0)
 d3c:	ef95                	bnez	a5,d78 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 d3e:	00000797          	auipc	a5,0x0
 d42:	31278793          	addi	a5,a5,786 # 1050 <base>
 d46:	fef43023          	sd	a5,-32(s0)
 d4a:	00000797          	auipc	a5,0x0
 d4e:	31678793          	addi	a5,a5,790 # 1060 <freep>
 d52:	fe043703          	ld	a4,-32(s0)
 d56:	e398                	sd	a4,0(a5)
 d58:	00000797          	auipc	a5,0x0
 d5c:	30878793          	addi	a5,a5,776 # 1060 <freep>
 d60:	6398                	ld	a4,0(a5)
 d62:	00000797          	auipc	a5,0x0
 d66:	2ee78793          	addi	a5,a5,750 # 1050 <base>
 d6a:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 d6c:	00000797          	auipc	a5,0x0
 d70:	2e478793          	addi	a5,a5,740 # 1050 <base>
 d74:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d78:	fe043783          	ld	a5,-32(s0)
 d7c:	639c                	ld	a5,0(a5)
 d7e:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d82:	fe843783          	ld	a5,-24(s0)
 d86:	4798                	lw	a4,8(a5)
 d88:	fdc42783          	lw	a5,-36(s0)
 d8c:	2781                	sext.w	a5,a5
 d8e:	06f76763          	bltu	a4,a5,dfc <malloc+0xf0>
      if(p->s.size == nunits)
 d92:	fe843783          	ld	a5,-24(s0)
 d96:	4798                	lw	a4,8(a5)
 d98:	fdc42783          	lw	a5,-36(s0)
 d9c:	2781                	sext.w	a5,a5
 d9e:	00e79963          	bne	a5,a4,db0 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 da2:	fe843783          	ld	a5,-24(s0)
 da6:	6398                	ld	a4,0(a5)
 da8:	fe043783          	ld	a5,-32(s0)
 dac:	e398                	sd	a4,0(a5)
 dae:	a825                	j	de6 <malloc+0xda>
      else {
        p->s.size -= nunits;
 db0:	fe843783          	ld	a5,-24(s0)
 db4:	479c                	lw	a5,8(a5)
 db6:	fdc42703          	lw	a4,-36(s0)
 dba:	9f99                	subw	a5,a5,a4
 dbc:	0007871b          	sext.w	a4,a5
 dc0:	fe843783          	ld	a5,-24(s0)
 dc4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 dc6:	fe843783          	ld	a5,-24(s0)
 dca:	479c                	lw	a5,8(a5)
 dcc:	1782                	slli	a5,a5,0x20
 dce:	9381                	srli	a5,a5,0x20
 dd0:	0792                	slli	a5,a5,0x4
 dd2:	fe843703          	ld	a4,-24(s0)
 dd6:	97ba                	add	a5,a5,a4
 dd8:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 ddc:	fe843783          	ld	a5,-24(s0)
 de0:	fdc42703          	lw	a4,-36(s0)
 de4:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 de6:	00000797          	auipc	a5,0x0
 dea:	27a78793          	addi	a5,a5,634 # 1060 <freep>
 dee:	fe043703          	ld	a4,-32(s0)
 df2:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 df4:	fe843783          	ld	a5,-24(s0)
 df8:	07c1                	addi	a5,a5,16
 dfa:	a091                	j	e3e <malloc+0x132>
    }
    if(p == freep)
 dfc:	00000797          	auipc	a5,0x0
 e00:	26478793          	addi	a5,a5,612 # 1060 <freep>
 e04:	639c                	ld	a5,0(a5)
 e06:	fe843703          	ld	a4,-24(s0)
 e0a:	02f71063          	bne	a4,a5,e2a <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 e0e:	fdc42783          	lw	a5,-36(s0)
 e12:	853e                	mv	a0,a5
 e14:	00000097          	auipc	ra,0x0
 e18:	e78080e7          	jalr	-392(ra) # c8c <morecore>
 e1c:	fea43423          	sd	a0,-24(s0)
 e20:	fe843783          	ld	a5,-24(s0)
 e24:	e399                	bnez	a5,e2a <malloc+0x11e>
        return 0;
 e26:	4781                	li	a5,0
 e28:	a819                	j	e3e <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e2a:	fe843783          	ld	a5,-24(s0)
 e2e:	fef43023          	sd	a5,-32(s0)
 e32:	fe843783          	ld	a5,-24(s0)
 e36:	639c                	ld	a5,0(a5)
 e38:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 e3c:	b799                	j	d82 <malloc+0x76>
  }
}
 e3e:	853e                	mv	a0,a5
 e40:	70e2                	ld	ra,56(sp)
 e42:	7442                	ld	s0,48(sp)
 e44:	6121                	addi	sp,sp,64
 e46:	8082                	ret

0000000000000e48 <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
 e48:	7179                	addi	sp,sp,-48
 e4a:	f406                	sd	ra,40(sp)
 e4c:	f022                	sd	s0,32(sp)
 e4e:	1800                	addi	s0,sp,48
 e50:	fca43c23          	sd	a0,-40(s0)
 e54:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
 e58:	6505                	lui	a0,0x1
 e5a:	00000097          	auipc	ra,0x0
 e5e:	eb2080e7          	jalr	-334(ra) # d0c <malloc>
 e62:	fea43423          	sd	a0,-24(s0)
 e66:	fe843783          	ld	a5,-24(s0)
 e6a:	e38d                	bnez	a5,e8c <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
 e6c:	00000517          	auipc	a0,0x0
 e70:	17450513          	addi	a0,a0,372 # fe0 <lock_init+0x8e>
 e74:	00000097          	auipc	ra,0x0
 e78:	ca6080e7          	jalr	-858(ra) # b1a <printf>
        free(stack);
 e7c:	fe843503          	ld	a0,-24(s0)
 e80:	00000097          	auipc	ra,0x0
 e84:	cea080e7          	jalr	-790(ra) # b6a <free>
        return -1;
 e88:	57fd                	li	a5,-1
 e8a:	a099                	j	ed0 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
 e8c:	fe843783          	ld	a5,-24(s0)
 e90:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
 e94:	fe043703          	ld	a4,-32(s0)
 e98:	6785                	lui	a5,0x1
 e9a:	17fd                	addi	a5,a5,-1
 e9c:	8ff9                	and	a5,a5,a4
 e9e:	cf91                	beqz	a5,eba <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
 ea0:	fe043703          	ld	a4,-32(s0)
 ea4:	6785                	lui	a5,0x1
 ea6:	17fd                	addi	a5,a5,-1
 ea8:	8ff9                	and	a5,a5,a4
 eaa:	6705                	lui	a4,0x1
 eac:	40f707b3          	sub	a5,a4,a5
 eb0:	fe843703          	ld	a4,-24(s0)
 eb4:	97ba                	add	a5,a5,a4
 eb6:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
 eba:	fe843603          	ld	a2,-24(s0)
 ebe:	fd043583          	ld	a1,-48(s0)
 ec2:	fd843503          	ld	a0,-40(s0)
 ec6:	fffff097          	auipc	ra,0xfffff
 eca:	7bc080e7          	jalr	1980(ra) # 682 <clone>
 ece:	87aa                	mv	a5,a0
}
 ed0:	853e                	mv	a0,a5
 ed2:	70a2                	ld	ra,40(sp)
 ed4:	7402                	ld	s0,32(sp)
 ed6:	6145                	addi	sp,sp,48
 ed8:	8082                	ret

0000000000000eda <thread_join>:


int thread_join()
{
 eda:	1101                	addi	sp,sp,-32
 edc:	ec06                	sd	ra,24(sp)
 ede:	e822                	sd	s0,16(sp)
 ee0:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
 ee2:	fe040793          	addi	a5,s0,-32
 ee6:	853e                	mv	a0,a5
 ee8:	fffff097          	auipc	ra,0xfffff
 eec:	7a2080e7          	jalr	1954(ra) # 68a <join>
 ef0:	87aa                	mv	a5,a0
 ef2:	fef42623          	sw	a5,-20(s0)
 ef6:	fec42783          	lw	a5,-20(s0)
 efa:	0007871b          	sext.w	a4,a5
 efe:	57fd                	li	a5,-1
 f00:	00f70963          	beq	a4,a5,f12 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
 f04:	fe043783          	ld	a5,-32(s0)
 f08:	853e                	mv	a0,a5
 f0a:	00000097          	auipc	ra,0x0
 f0e:	c60080e7          	jalr	-928(ra) # b6a <free>
    } 

    return child_tid;
 f12:	fec42783          	lw	a5,-20(s0)
}
 f16:	853e                	mv	a0,a5
 f18:	60e2                	ld	ra,24(sp)
 f1a:	6442                	ld	s0,16(sp)
 f1c:	6105                	addi	sp,sp,32
 f1e:	8082                	ret

0000000000000f20 <lock_acquire>:


void lock_acquire (lock_t *lock)
{
 f20:	1101                	addi	sp,sp,-32
 f22:	ec22                	sd	s0,24(sp)
 f24:	1000                	addi	s0,sp,32
 f26:	fea43423          	sd	a0,-24(s0)
        lock = 0;
 f2a:	fe043423          	sd	zero,-24(s0)

}
 f2e:	0001                	nop
 f30:	6462                	ld	s0,24(sp)
 f32:	6105                	addi	sp,sp,32
 f34:	8082                	ret

0000000000000f36 <lock_release>:

void lock_release (lock_t *lock)
{
 f36:	1101                	addi	sp,sp,-32
 f38:	ec22                	sd	s0,24(sp)
 f3a:	1000                	addi	s0,sp,32
 f3c:	fea43423          	sd	a0,-24(s0)
        __sync_lock_test_and_set(lock, 1);
 f40:	fe843783          	ld	a5,-24(s0)
 f44:	4705                	li	a4,1
 f46:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    
}
 f4a:	0001                	nop
 f4c:	6462                	ld	s0,24(sp)
 f4e:	6105                	addi	sp,sp,32
 f50:	8082                	ret

0000000000000f52 <lock_init>:

void lock_init (lock_t *lock)
{
 f52:	1101                	addi	sp,sp,-32
 f54:	ec22                	sd	s0,24(sp)
 f56:	1000                	addi	s0,sp,32
 f58:	fea43423          	sd	a0,-24(s0)
    lock = 0;
 f5c:	fe043423          	sd	zero,-24(s0)
    
}
 f60:	0001                	nop
 f62:	6462                	ld	s0,24(sp)
 f64:	6105                	addi	sp,sp,32
 f66:	8082                	ret
