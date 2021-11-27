
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
  1c:	ea078793          	addi	a5,a5,-352 # eb8 <malloc+0x16e>
  20:	6398                	ld	a4,0(a5)
  22:	fce43c23          	sd	a4,-40(s0)
  26:	0087d783          	lhu	a5,8(a5)
  2a:	fef41023          	sh	a5,-32(s0)
  char data[512];

  printf("stressfs starting\n");
  2e:	00001517          	auipc	a0,0x1
  32:	e5a50513          	addi	a0,a0,-422 # e88 <malloc+0x13e>
  36:	00001097          	auipc	ra,0x1
  3a:	b22080e7          	jalr	-1246(ra) # b58 <printf>
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
  5e:	5b8080e7          	jalr	1464(ra) # 612 <fork>
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
  8e:	e1650513          	addi	a0,a0,-490 # ea0 <malloc+0x156>
  92:	00001097          	auipc	ra,0x1
  96:	ac6080e7          	jalr	-1338(ra) # b58 <printf>

  path[8] += i;
  9a:	fe044703          	lbu	a4,-32(s0)
  9e:	fec42783          	lw	a5,-20(s0)
  a2:	0ff7f793          	andi	a5,a5,255
  a6:	9fb9                	addw	a5,a5,a4
  a8:	0ff7f793          	andi	a5,a5,255
  ac:	fef40023          	sb	a5,-32(s0)
  fd = open(path, O_CREATE | O_RDWR);
  b0:	fd840793          	addi	a5,s0,-40
  b4:	20200593          	li	a1,514
  b8:	853e                	mv	a0,a5
  ba:	00000097          	auipc	ra,0x0
  be:	5a0080e7          	jalr	1440(ra) # 65a <open>
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
  e2:	55c080e7          	jalr	1372(ra) # 63a <write>
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
 108:	53e080e7          	jalr	1342(ra) # 642 <close>

  printf("read\n");
 10c:	00001517          	auipc	a0,0x1
 110:	da450513          	addi	a0,a0,-604 # eb0 <malloc+0x166>
 114:	00001097          	auipc	ra,0x1
 118:	a44080e7          	jalr	-1468(ra) # b58 <printf>

  fd = open(path, O_RDONLY);
 11c:	fd840793          	addi	a5,s0,-40
 120:	4581                	li	a1,0
 122:	853e                	mv	a0,a5
 124:	00000097          	auipc	ra,0x0
 128:	536080e7          	jalr	1334(ra) # 65a <open>
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
 14c:	4ea080e7          	jalr	1258(ra) # 632 <read>
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
 172:	4d4080e7          	jalr	1236(ra) # 642 <close>

  wait(0);
 176:	4501                	li	a0,0
 178:	00000097          	auipc	ra,0x0
 17c:	4aa080e7          	jalr	1194(ra) # 622 <wait>

  exit(0);
 180:	4501                	li	a0,0
 182:	00000097          	auipc	ra,0x0
 186:	498080e7          	jalr	1176(ra) # 61a <exit>

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
 2a4:	0ff77713          	andi	a4,a4,255
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
 2ee:	0ff7f793          	andi	a5,a5,255
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
 340:	2f6080e7          	jalr	758(ra) # 632 <read>
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
 3d6:	288080e7          	jalr	648(ra) # 65a <open>
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
 3fc:	27a080e7          	jalr	634(ra) # 672 <fstat>
 400:	87aa                	mv	a5,a0
 402:	fef42423          	sw	a5,-24(s0)
  close(fd);
 406:	fec42783          	lw	a5,-20(s0)
 40a:	853e                	mv	a0,a5
 40c:	00000097          	auipc	ra,0x0
 410:	236080e7          	jalr	566(ra) # 642 <close>
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
 430:	a815                	j	464 <atoi+0x42>
    n = n*10 + *s++ - '0';
 432:	fec42703          	lw	a4,-20(s0)
 436:	87ba                	mv	a5,a4
 438:	0027979b          	slliw	a5,a5,0x2
 43c:	9fb9                	addw	a5,a5,a4
 43e:	0017979b          	slliw	a5,a5,0x1
 442:	0007871b          	sext.w	a4,a5
 446:	fd843783          	ld	a5,-40(s0)
 44a:	00178693          	addi	a3,a5,1
 44e:	fcd43c23          	sd	a3,-40(s0)
 452:	0007c783          	lbu	a5,0(a5)
 456:	2781                	sext.w	a5,a5
 458:	9fb9                	addw	a5,a5,a4
 45a:	2781                	sext.w	a5,a5
 45c:	fd07879b          	addiw	a5,a5,-48
 460:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 464:	fd843783          	ld	a5,-40(s0)
 468:	0007c783          	lbu	a5,0(a5)
 46c:	873e                	mv	a4,a5
 46e:	02f00793          	li	a5,47
 472:	00e7fb63          	bgeu	a5,a4,488 <atoi+0x66>
 476:	fd843783          	ld	a5,-40(s0)
 47a:	0007c783          	lbu	a5,0(a5)
 47e:	873e                	mv	a4,a5
 480:	03900793          	li	a5,57
 484:	fae7f7e3          	bgeu	a5,a4,432 <atoi+0x10>
  return n;
 488:	fec42783          	lw	a5,-20(s0)
}
 48c:	853e                	mv	a0,a5
 48e:	7422                	ld	s0,40(sp)
 490:	6145                	addi	sp,sp,48
 492:	8082                	ret

0000000000000494 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 494:	7139                	addi	sp,sp,-64
 496:	fc22                	sd	s0,56(sp)
 498:	0080                	addi	s0,sp,64
 49a:	fca43c23          	sd	a0,-40(s0)
 49e:	fcb43823          	sd	a1,-48(s0)
 4a2:	87b2                	mv	a5,a2
 4a4:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 4a8:	fd843783          	ld	a5,-40(s0)
 4ac:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 4b0:	fd043783          	ld	a5,-48(s0)
 4b4:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 4b8:	fe043703          	ld	a4,-32(s0)
 4bc:	fe843783          	ld	a5,-24(s0)
 4c0:	02e7fc63          	bgeu	a5,a4,4f8 <memmove+0x64>
    while(n-- > 0)
 4c4:	a00d                	j	4e6 <memmove+0x52>
      *dst++ = *src++;
 4c6:	fe043703          	ld	a4,-32(s0)
 4ca:	00170793          	addi	a5,a4,1
 4ce:	fef43023          	sd	a5,-32(s0)
 4d2:	fe843783          	ld	a5,-24(s0)
 4d6:	00178693          	addi	a3,a5,1
 4da:	fed43423          	sd	a3,-24(s0)
 4de:	00074703          	lbu	a4,0(a4)
 4e2:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4e6:	fcc42783          	lw	a5,-52(s0)
 4ea:	fff7871b          	addiw	a4,a5,-1
 4ee:	fce42623          	sw	a4,-52(s0)
 4f2:	fcf04ae3          	bgtz	a5,4c6 <memmove+0x32>
 4f6:	a891                	j	54a <memmove+0xb6>
  } else {
    dst += n;
 4f8:	fcc42783          	lw	a5,-52(s0)
 4fc:	fe843703          	ld	a4,-24(s0)
 500:	97ba                	add	a5,a5,a4
 502:	fef43423          	sd	a5,-24(s0)
    src += n;
 506:	fcc42783          	lw	a5,-52(s0)
 50a:	fe043703          	ld	a4,-32(s0)
 50e:	97ba                	add	a5,a5,a4
 510:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 514:	a01d                	j	53a <memmove+0xa6>
      *--dst = *--src;
 516:	fe043783          	ld	a5,-32(s0)
 51a:	17fd                	addi	a5,a5,-1
 51c:	fef43023          	sd	a5,-32(s0)
 520:	fe843783          	ld	a5,-24(s0)
 524:	17fd                	addi	a5,a5,-1
 526:	fef43423          	sd	a5,-24(s0)
 52a:	fe043783          	ld	a5,-32(s0)
 52e:	0007c703          	lbu	a4,0(a5)
 532:	fe843783          	ld	a5,-24(s0)
 536:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 53a:	fcc42783          	lw	a5,-52(s0)
 53e:	fff7871b          	addiw	a4,a5,-1
 542:	fce42623          	sw	a4,-52(s0)
 546:	fcf048e3          	bgtz	a5,516 <memmove+0x82>
  }
  return vdst;
 54a:	fd843783          	ld	a5,-40(s0)
}
 54e:	853e                	mv	a0,a5
 550:	7462                	ld	s0,56(sp)
 552:	6121                	addi	sp,sp,64
 554:	8082                	ret

0000000000000556 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 556:	7139                	addi	sp,sp,-64
 558:	fc22                	sd	s0,56(sp)
 55a:	0080                	addi	s0,sp,64
 55c:	fca43c23          	sd	a0,-40(s0)
 560:	fcb43823          	sd	a1,-48(s0)
 564:	87b2                	mv	a5,a2
 566:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 56a:	fd843783          	ld	a5,-40(s0)
 56e:	fef43423          	sd	a5,-24(s0)
 572:	fd043783          	ld	a5,-48(s0)
 576:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 57a:	a0a1                	j	5c2 <memcmp+0x6c>
    if (*p1 != *p2) {
 57c:	fe843783          	ld	a5,-24(s0)
 580:	0007c703          	lbu	a4,0(a5)
 584:	fe043783          	ld	a5,-32(s0)
 588:	0007c783          	lbu	a5,0(a5)
 58c:	02f70163          	beq	a4,a5,5ae <memcmp+0x58>
      return *p1 - *p2;
 590:	fe843783          	ld	a5,-24(s0)
 594:	0007c783          	lbu	a5,0(a5)
 598:	0007871b          	sext.w	a4,a5
 59c:	fe043783          	ld	a5,-32(s0)
 5a0:	0007c783          	lbu	a5,0(a5)
 5a4:	2781                	sext.w	a5,a5
 5a6:	40f707bb          	subw	a5,a4,a5
 5aa:	2781                	sext.w	a5,a5
 5ac:	a01d                	j	5d2 <memcmp+0x7c>
    }
    p1++;
 5ae:	fe843783          	ld	a5,-24(s0)
 5b2:	0785                	addi	a5,a5,1
 5b4:	fef43423          	sd	a5,-24(s0)
    p2++;
 5b8:	fe043783          	ld	a5,-32(s0)
 5bc:	0785                	addi	a5,a5,1
 5be:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 5c2:	fcc42783          	lw	a5,-52(s0)
 5c6:	fff7871b          	addiw	a4,a5,-1
 5ca:	fce42623          	sw	a4,-52(s0)
 5ce:	f7dd                	bnez	a5,57c <memcmp+0x26>
  }
  return 0;
 5d0:	4781                	li	a5,0
}
 5d2:	853e                	mv	a0,a5
 5d4:	7462                	ld	s0,56(sp)
 5d6:	6121                	addi	sp,sp,64
 5d8:	8082                	ret

00000000000005da <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5da:	7179                	addi	sp,sp,-48
 5dc:	f406                	sd	ra,40(sp)
 5de:	f022                	sd	s0,32(sp)
 5e0:	1800                	addi	s0,sp,48
 5e2:	fea43423          	sd	a0,-24(s0)
 5e6:	feb43023          	sd	a1,-32(s0)
 5ea:	87b2                	mv	a5,a2
 5ec:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 5f0:	fdc42783          	lw	a5,-36(s0)
 5f4:	863e                	mv	a2,a5
 5f6:	fe043583          	ld	a1,-32(s0)
 5fa:	fe843503          	ld	a0,-24(s0)
 5fe:	00000097          	auipc	ra,0x0
 602:	e96080e7          	jalr	-362(ra) # 494 <memmove>
 606:	87aa                	mv	a5,a0
}
 608:	853e                	mv	a0,a5
 60a:	70a2                	ld	ra,40(sp)
 60c:	7402                	ld	s0,32(sp)
 60e:	6145                	addi	sp,sp,48
 610:	8082                	ret

0000000000000612 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 612:	4885                	li	a7,1
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <exit>:
.global exit
exit:
 li a7, SYS_exit
 61a:	4889                	li	a7,2
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <wait>:
.global wait
wait:
 li a7, SYS_wait
 622:	488d                	li	a7,3
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 62a:	4891                	li	a7,4
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <read>:
.global read
read:
 li a7, SYS_read
 632:	4895                	li	a7,5
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <write>:
.global write
write:
 li a7, SYS_write
 63a:	48c1                	li	a7,16
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <close>:
.global close
close:
 li a7, SYS_close
 642:	48d5                	li	a7,21
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <kill>:
.global kill
kill:
 li a7, SYS_kill
 64a:	4899                	li	a7,6
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <exec>:
.global exec
exec:
 li a7, SYS_exec
 652:	489d                	li	a7,7
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <open>:
.global open
open:
 li a7, SYS_open
 65a:	48bd                	li	a7,15
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 662:	48c5                	li	a7,17
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 66a:	48c9                	li	a7,18
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 672:	48a1                	li	a7,8
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <link>:
.global link
link:
 li a7, SYS_link
 67a:	48cd                	li	a7,19
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 682:	48d1                	li	a7,20
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 68a:	48a5                	li	a7,9
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <dup>:
.global dup
dup:
 li a7, SYS_dup
 692:	48a9                	li	a7,10
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 69a:	48ad                	li	a7,11
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6a2:	48b1                	li	a7,12
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6aa:	48b5                	li	a7,13
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6b2:	48b9                	li	a7,14
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 6ba:	48d9                	li	a7,22
 ecall
 6bc:	00000073          	ecall
 ret
 6c0:	8082                	ret

00000000000006c2 <setpri>:
.global setpri
setpri:
 li a7, SYS_setpri
 6c2:	48dd                	li	a7,23
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6ca:	1101                	addi	sp,sp,-32
 6cc:	ec06                	sd	ra,24(sp)
 6ce:	e822                	sd	s0,16(sp)
 6d0:	1000                	addi	s0,sp,32
 6d2:	87aa                	mv	a5,a0
 6d4:	872e                	mv	a4,a1
 6d6:	fef42623          	sw	a5,-20(s0)
 6da:	87ba                	mv	a5,a4
 6dc:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 6e0:	feb40713          	addi	a4,s0,-21
 6e4:	fec42783          	lw	a5,-20(s0)
 6e8:	4605                	li	a2,1
 6ea:	85ba                	mv	a1,a4
 6ec:	853e                	mv	a0,a5
 6ee:	00000097          	auipc	ra,0x0
 6f2:	f4c080e7          	jalr	-180(ra) # 63a <write>
}
 6f6:	0001                	nop
 6f8:	60e2                	ld	ra,24(sp)
 6fa:	6442                	ld	s0,16(sp)
 6fc:	6105                	addi	sp,sp,32
 6fe:	8082                	ret

0000000000000700 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 700:	7139                	addi	sp,sp,-64
 702:	fc06                	sd	ra,56(sp)
 704:	f822                	sd	s0,48(sp)
 706:	0080                	addi	s0,sp,64
 708:	87aa                	mv	a5,a0
 70a:	8736                	mv	a4,a3
 70c:	fcf42623          	sw	a5,-52(s0)
 710:	87ae                	mv	a5,a1
 712:	fcf42423          	sw	a5,-56(s0)
 716:	87b2                	mv	a5,a2
 718:	fcf42223          	sw	a5,-60(s0)
 71c:	87ba                	mv	a5,a4
 71e:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 722:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 726:	fc042783          	lw	a5,-64(s0)
 72a:	2781                	sext.w	a5,a5
 72c:	c38d                	beqz	a5,74e <printint+0x4e>
 72e:	fc842783          	lw	a5,-56(s0)
 732:	2781                	sext.w	a5,a5
 734:	0007dd63          	bgez	a5,74e <printint+0x4e>
    neg = 1;
 738:	4785                	li	a5,1
 73a:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 73e:	fc842783          	lw	a5,-56(s0)
 742:	40f007bb          	negw	a5,a5
 746:	2781                	sext.w	a5,a5
 748:	fef42223          	sw	a5,-28(s0)
 74c:	a029                	j	756 <printint+0x56>
  } else {
    x = xx;
 74e:	fc842783          	lw	a5,-56(s0)
 752:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 756:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 75a:	fc442783          	lw	a5,-60(s0)
 75e:	fe442703          	lw	a4,-28(s0)
 762:	02f777bb          	remuw	a5,a4,a5
 766:	0007861b          	sext.w	a2,a5
 76a:	fec42783          	lw	a5,-20(s0)
 76e:	0017871b          	addiw	a4,a5,1
 772:	fee42623          	sw	a4,-20(s0)
 776:	00000697          	auipc	a3,0x0
 77a:	75a68693          	addi	a3,a3,1882 # ed0 <digits>
 77e:	02061713          	slli	a4,a2,0x20
 782:	9301                	srli	a4,a4,0x20
 784:	9736                	add	a4,a4,a3
 786:	00074703          	lbu	a4,0(a4)
 78a:	ff040693          	addi	a3,s0,-16
 78e:	97b6                	add	a5,a5,a3
 790:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 794:	fc442783          	lw	a5,-60(s0)
 798:	fe442703          	lw	a4,-28(s0)
 79c:	02f757bb          	divuw	a5,a4,a5
 7a0:	fef42223          	sw	a5,-28(s0)
 7a4:	fe442783          	lw	a5,-28(s0)
 7a8:	2781                	sext.w	a5,a5
 7aa:	fbc5                	bnez	a5,75a <printint+0x5a>
  if(neg)
 7ac:	fe842783          	lw	a5,-24(s0)
 7b0:	2781                	sext.w	a5,a5
 7b2:	cf95                	beqz	a5,7ee <printint+0xee>
    buf[i++] = '-';
 7b4:	fec42783          	lw	a5,-20(s0)
 7b8:	0017871b          	addiw	a4,a5,1
 7bc:	fee42623          	sw	a4,-20(s0)
 7c0:	ff040713          	addi	a4,s0,-16
 7c4:	97ba                	add	a5,a5,a4
 7c6:	02d00713          	li	a4,45
 7ca:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 7ce:	a005                	j	7ee <printint+0xee>
    putc(fd, buf[i]);
 7d0:	fec42783          	lw	a5,-20(s0)
 7d4:	ff040713          	addi	a4,s0,-16
 7d8:	97ba                	add	a5,a5,a4
 7da:	fe07c703          	lbu	a4,-32(a5)
 7de:	fcc42783          	lw	a5,-52(s0)
 7e2:	85ba                	mv	a1,a4
 7e4:	853e                	mv	a0,a5
 7e6:	00000097          	auipc	ra,0x0
 7ea:	ee4080e7          	jalr	-284(ra) # 6ca <putc>
  while(--i >= 0)
 7ee:	fec42783          	lw	a5,-20(s0)
 7f2:	37fd                	addiw	a5,a5,-1
 7f4:	fef42623          	sw	a5,-20(s0)
 7f8:	fec42783          	lw	a5,-20(s0)
 7fc:	2781                	sext.w	a5,a5
 7fe:	fc07d9e3          	bgez	a5,7d0 <printint+0xd0>
}
 802:	0001                	nop
 804:	0001                	nop
 806:	70e2                	ld	ra,56(sp)
 808:	7442                	ld	s0,48(sp)
 80a:	6121                	addi	sp,sp,64
 80c:	8082                	ret

000000000000080e <printptr>:

static void
printptr(int fd, uint64 x) {
 80e:	7179                	addi	sp,sp,-48
 810:	f406                	sd	ra,40(sp)
 812:	f022                	sd	s0,32(sp)
 814:	1800                	addi	s0,sp,48
 816:	87aa                	mv	a5,a0
 818:	fcb43823          	sd	a1,-48(s0)
 81c:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 820:	fdc42783          	lw	a5,-36(s0)
 824:	03000593          	li	a1,48
 828:	853e                	mv	a0,a5
 82a:	00000097          	auipc	ra,0x0
 82e:	ea0080e7          	jalr	-352(ra) # 6ca <putc>
  putc(fd, 'x');
 832:	fdc42783          	lw	a5,-36(s0)
 836:	07800593          	li	a1,120
 83a:	853e                	mv	a0,a5
 83c:	00000097          	auipc	ra,0x0
 840:	e8e080e7          	jalr	-370(ra) # 6ca <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 844:	fe042623          	sw	zero,-20(s0)
 848:	a82d                	j	882 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 84a:	fd043783          	ld	a5,-48(s0)
 84e:	93f1                	srli	a5,a5,0x3c
 850:	00000717          	auipc	a4,0x0
 854:	68070713          	addi	a4,a4,1664 # ed0 <digits>
 858:	97ba                	add	a5,a5,a4
 85a:	0007c703          	lbu	a4,0(a5)
 85e:	fdc42783          	lw	a5,-36(s0)
 862:	85ba                	mv	a1,a4
 864:	853e                	mv	a0,a5
 866:	00000097          	auipc	ra,0x0
 86a:	e64080e7          	jalr	-412(ra) # 6ca <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 86e:	fec42783          	lw	a5,-20(s0)
 872:	2785                	addiw	a5,a5,1
 874:	fef42623          	sw	a5,-20(s0)
 878:	fd043783          	ld	a5,-48(s0)
 87c:	0792                	slli	a5,a5,0x4
 87e:	fcf43823          	sd	a5,-48(s0)
 882:	fec42783          	lw	a5,-20(s0)
 886:	873e                	mv	a4,a5
 888:	47bd                	li	a5,15
 88a:	fce7f0e3          	bgeu	a5,a4,84a <printptr+0x3c>
}
 88e:	0001                	nop
 890:	0001                	nop
 892:	70a2                	ld	ra,40(sp)
 894:	7402                	ld	s0,32(sp)
 896:	6145                	addi	sp,sp,48
 898:	8082                	ret

000000000000089a <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 89a:	715d                	addi	sp,sp,-80
 89c:	e486                	sd	ra,72(sp)
 89e:	e0a2                	sd	s0,64(sp)
 8a0:	0880                	addi	s0,sp,80
 8a2:	87aa                	mv	a5,a0
 8a4:	fcb43023          	sd	a1,-64(s0)
 8a8:	fac43c23          	sd	a2,-72(s0)
 8ac:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 8b0:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 8b4:	fe042223          	sw	zero,-28(s0)
 8b8:	a42d                	j	ae2 <vprintf+0x248>
    c = fmt[i] & 0xff;
 8ba:	fe442783          	lw	a5,-28(s0)
 8be:	fc043703          	ld	a4,-64(s0)
 8c2:	97ba                	add	a5,a5,a4
 8c4:	0007c783          	lbu	a5,0(a5)
 8c8:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 8cc:	fe042783          	lw	a5,-32(s0)
 8d0:	2781                	sext.w	a5,a5
 8d2:	eb9d                	bnez	a5,908 <vprintf+0x6e>
      if(c == '%'){
 8d4:	fdc42783          	lw	a5,-36(s0)
 8d8:	0007871b          	sext.w	a4,a5
 8dc:	02500793          	li	a5,37
 8e0:	00f71763          	bne	a4,a5,8ee <vprintf+0x54>
        state = '%';
 8e4:	02500793          	li	a5,37
 8e8:	fef42023          	sw	a5,-32(s0)
 8ec:	a2f5                	j	ad8 <vprintf+0x23e>
      } else {
        putc(fd, c);
 8ee:	fdc42783          	lw	a5,-36(s0)
 8f2:	0ff7f713          	andi	a4,a5,255
 8f6:	fcc42783          	lw	a5,-52(s0)
 8fa:	85ba                	mv	a1,a4
 8fc:	853e                	mv	a0,a5
 8fe:	00000097          	auipc	ra,0x0
 902:	dcc080e7          	jalr	-564(ra) # 6ca <putc>
 906:	aac9                	j	ad8 <vprintf+0x23e>
      }
    } else if(state == '%'){
 908:	fe042783          	lw	a5,-32(s0)
 90c:	0007871b          	sext.w	a4,a5
 910:	02500793          	li	a5,37
 914:	1cf71263          	bne	a4,a5,ad8 <vprintf+0x23e>
      if(c == 'd'){
 918:	fdc42783          	lw	a5,-36(s0)
 91c:	0007871b          	sext.w	a4,a5
 920:	06400793          	li	a5,100
 924:	02f71463          	bne	a4,a5,94c <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 928:	fb843783          	ld	a5,-72(s0)
 92c:	00878713          	addi	a4,a5,8
 930:	fae43c23          	sd	a4,-72(s0)
 934:	4398                	lw	a4,0(a5)
 936:	fcc42783          	lw	a5,-52(s0)
 93a:	4685                	li	a3,1
 93c:	4629                	li	a2,10
 93e:	85ba                	mv	a1,a4
 940:	853e                	mv	a0,a5
 942:	00000097          	auipc	ra,0x0
 946:	dbe080e7          	jalr	-578(ra) # 700 <printint>
 94a:	a269                	j	ad4 <vprintf+0x23a>
      } else if(c == 'l') {
 94c:	fdc42783          	lw	a5,-36(s0)
 950:	0007871b          	sext.w	a4,a5
 954:	06c00793          	li	a5,108
 958:	02f71663          	bne	a4,a5,984 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 95c:	fb843783          	ld	a5,-72(s0)
 960:	00878713          	addi	a4,a5,8
 964:	fae43c23          	sd	a4,-72(s0)
 968:	639c                	ld	a5,0(a5)
 96a:	0007871b          	sext.w	a4,a5
 96e:	fcc42783          	lw	a5,-52(s0)
 972:	4681                	li	a3,0
 974:	4629                	li	a2,10
 976:	85ba                	mv	a1,a4
 978:	853e                	mv	a0,a5
 97a:	00000097          	auipc	ra,0x0
 97e:	d86080e7          	jalr	-634(ra) # 700 <printint>
 982:	aa89                	j	ad4 <vprintf+0x23a>
      } else if(c == 'x') {
 984:	fdc42783          	lw	a5,-36(s0)
 988:	0007871b          	sext.w	a4,a5
 98c:	07800793          	li	a5,120
 990:	02f71463          	bne	a4,a5,9b8 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 994:	fb843783          	ld	a5,-72(s0)
 998:	00878713          	addi	a4,a5,8
 99c:	fae43c23          	sd	a4,-72(s0)
 9a0:	4398                	lw	a4,0(a5)
 9a2:	fcc42783          	lw	a5,-52(s0)
 9a6:	4681                	li	a3,0
 9a8:	4641                	li	a2,16
 9aa:	85ba                	mv	a1,a4
 9ac:	853e                	mv	a0,a5
 9ae:	00000097          	auipc	ra,0x0
 9b2:	d52080e7          	jalr	-686(ra) # 700 <printint>
 9b6:	aa39                	j	ad4 <vprintf+0x23a>
      } else if(c == 'p') {
 9b8:	fdc42783          	lw	a5,-36(s0)
 9bc:	0007871b          	sext.w	a4,a5
 9c0:	07000793          	li	a5,112
 9c4:	02f71263          	bne	a4,a5,9e8 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 9c8:	fb843783          	ld	a5,-72(s0)
 9cc:	00878713          	addi	a4,a5,8
 9d0:	fae43c23          	sd	a4,-72(s0)
 9d4:	6398                	ld	a4,0(a5)
 9d6:	fcc42783          	lw	a5,-52(s0)
 9da:	85ba                	mv	a1,a4
 9dc:	853e                	mv	a0,a5
 9de:	00000097          	auipc	ra,0x0
 9e2:	e30080e7          	jalr	-464(ra) # 80e <printptr>
 9e6:	a0fd                	j	ad4 <vprintf+0x23a>
      } else if(c == 's'){
 9e8:	fdc42783          	lw	a5,-36(s0)
 9ec:	0007871b          	sext.w	a4,a5
 9f0:	07300793          	li	a5,115
 9f4:	04f71c63          	bne	a4,a5,a4c <vprintf+0x1b2>
        s = va_arg(ap, char*);
 9f8:	fb843783          	ld	a5,-72(s0)
 9fc:	00878713          	addi	a4,a5,8
 a00:	fae43c23          	sd	a4,-72(s0)
 a04:	639c                	ld	a5,0(a5)
 a06:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 a0a:	fe843783          	ld	a5,-24(s0)
 a0e:	eb8d                	bnez	a5,a40 <vprintf+0x1a6>
          s = "(null)";
 a10:	00000797          	auipc	a5,0x0
 a14:	4b878793          	addi	a5,a5,1208 # ec8 <malloc+0x17e>
 a18:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 a1c:	a015                	j	a40 <vprintf+0x1a6>
          putc(fd, *s);
 a1e:	fe843783          	ld	a5,-24(s0)
 a22:	0007c703          	lbu	a4,0(a5)
 a26:	fcc42783          	lw	a5,-52(s0)
 a2a:	85ba                	mv	a1,a4
 a2c:	853e                	mv	a0,a5
 a2e:	00000097          	auipc	ra,0x0
 a32:	c9c080e7          	jalr	-868(ra) # 6ca <putc>
          s++;
 a36:	fe843783          	ld	a5,-24(s0)
 a3a:	0785                	addi	a5,a5,1
 a3c:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 a40:	fe843783          	ld	a5,-24(s0)
 a44:	0007c783          	lbu	a5,0(a5)
 a48:	fbf9                	bnez	a5,a1e <vprintf+0x184>
 a4a:	a069                	j	ad4 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 a4c:	fdc42783          	lw	a5,-36(s0)
 a50:	0007871b          	sext.w	a4,a5
 a54:	06300793          	li	a5,99
 a58:	02f71463          	bne	a4,a5,a80 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 a5c:	fb843783          	ld	a5,-72(s0)
 a60:	00878713          	addi	a4,a5,8
 a64:	fae43c23          	sd	a4,-72(s0)
 a68:	439c                	lw	a5,0(a5)
 a6a:	0ff7f713          	andi	a4,a5,255
 a6e:	fcc42783          	lw	a5,-52(s0)
 a72:	85ba                	mv	a1,a4
 a74:	853e                	mv	a0,a5
 a76:	00000097          	auipc	ra,0x0
 a7a:	c54080e7          	jalr	-940(ra) # 6ca <putc>
 a7e:	a899                	j	ad4 <vprintf+0x23a>
      } else if(c == '%'){
 a80:	fdc42783          	lw	a5,-36(s0)
 a84:	0007871b          	sext.w	a4,a5
 a88:	02500793          	li	a5,37
 a8c:	00f71f63          	bne	a4,a5,aaa <vprintf+0x210>
        putc(fd, c);
 a90:	fdc42783          	lw	a5,-36(s0)
 a94:	0ff7f713          	andi	a4,a5,255
 a98:	fcc42783          	lw	a5,-52(s0)
 a9c:	85ba                	mv	a1,a4
 a9e:	853e                	mv	a0,a5
 aa0:	00000097          	auipc	ra,0x0
 aa4:	c2a080e7          	jalr	-982(ra) # 6ca <putc>
 aa8:	a035                	j	ad4 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 aaa:	fcc42783          	lw	a5,-52(s0)
 aae:	02500593          	li	a1,37
 ab2:	853e                	mv	a0,a5
 ab4:	00000097          	auipc	ra,0x0
 ab8:	c16080e7          	jalr	-1002(ra) # 6ca <putc>
        putc(fd, c);
 abc:	fdc42783          	lw	a5,-36(s0)
 ac0:	0ff7f713          	andi	a4,a5,255
 ac4:	fcc42783          	lw	a5,-52(s0)
 ac8:	85ba                	mv	a1,a4
 aca:	853e                	mv	a0,a5
 acc:	00000097          	auipc	ra,0x0
 ad0:	bfe080e7          	jalr	-1026(ra) # 6ca <putc>
      }
      state = 0;
 ad4:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 ad8:	fe442783          	lw	a5,-28(s0)
 adc:	2785                	addiw	a5,a5,1
 ade:	fef42223          	sw	a5,-28(s0)
 ae2:	fe442783          	lw	a5,-28(s0)
 ae6:	fc043703          	ld	a4,-64(s0)
 aea:	97ba                	add	a5,a5,a4
 aec:	0007c783          	lbu	a5,0(a5)
 af0:	dc0795e3          	bnez	a5,8ba <vprintf+0x20>
    }
  }
}
 af4:	0001                	nop
 af6:	0001                	nop
 af8:	60a6                	ld	ra,72(sp)
 afa:	6406                	ld	s0,64(sp)
 afc:	6161                	addi	sp,sp,80
 afe:	8082                	ret

0000000000000b00 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b00:	7159                	addi	sp,sp,-112
 b02:	fc06                	sd	ra,56(sp)
 b04:	f822                	sd	s0,48(sp)
 b06:	0080                	addi	s0,sp,64
 b08:	fcb43823          	sd	a1,-48(s0)
 b0c:	e010                	sd	a2,0(s0)
 b0e:	e414                	sd	a3,8(s0)
 b10:	e818                	sd	a4,16(s0)
 b12:	ec1c                	sd	a5,24(s0)
 b14:	03043023          	sd	a6,32(s0)
 b18:	03143423          	sd	a7,40(s0)
 b1c:	87aa                	mv	a5,a0
 b1e:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 b22:	03040793          	addi	a5,s0,48
 b26:	fcf43423          	sd	a5,-56(s0)
 b2a:	fc843783          	ld	a5,-56(s0)
 b2e:	fd078793          	addi	a5,a5,-48
 b32:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 b36:	fe843703          	ld	a4,-24(s0)
 b3a:	fdc42783          	lw	a5,-36(s0)
 b3e:	863a                	mv	a2,a4
 b40:	fd043583          	ld	a1,-48(s0)
 b44:	853e                	mv	a0,a5
 b46:	00000097          	auipc	ra,0x0
 b4a:	d54080e7          	jalr	-684(ra) # 89a <vprintf>
}
 b4e:	0001                	nop
 b50:	70e2                	ld	ra,56(sp)
 b52:	7442                	ld	s0,48(sp)
 b54:	6165                	addi	sp,sp,112
 b56:	8082                	ret

0000000000000b58 <printf>:

void
printf(const char *fmt, ...)
{
 b58:	7159                	addi	sp,sp,-112
 b5a:	f406                	sd	ra,40(sp)
 b5c:	f022                	sd	s0,32(sp)
 b5e:	1800                	addi	s0,sp,48
 b60:	fca43c23          	sd	a0,-40(s0)
 b64:	e40c                	sd	a1,8(s0)
 b66:	e810                	sd	a2,16(s0)
 b68:	ec14                	sd	a3,24(s0)
 b6a:	f018                	sd	a4,32(s0)
 b6c:	f41c                	sd	a5,40(s0)
 b6e:	03043823          	sd	a6,48(s0)
 b72:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b76:	04040793          	addi	a5,s0,64
 b7a:	fcf43823          	sd	a5,-48(s0)
 b7e:	fd043783          	ld	a5,-48(s0)
 b82:	fc878793          	addi	a5,a5,-56
 b86:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 b8a:	fe843783          	ld	a5,-24(s0)
 b8e:	863e                	mv	a2,a5
 b90:	fd843583          	ld	a1,-40(s0)
 b94:	4505                	li	a0,1
 b96:	00000097          	auipc	ra,0x0
 b9a:	d04080e7          	jalr	-764(ra) # 89a <vprintf>
}
 b9e:	0001                	nop
 ba0:	70a2                	ld	ra,40(sp)
 ba2:	7402                	ld	s0,32(sp)
 ba4:	6165                	addi	sp,sp,112
 ba6:	8082                	ret

0000000000000ba8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ba8:	7179                	addi	sp,sp,-48
 baa:	f422                	sd	s0,40(sp)
 bac:	1800                	addi	s0,sp,48
 bae:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bb2:	fd843783          	ld	a5,-40(s0)
 bb6:	17c1                	addi	a5,a5,-16
 bb8:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bbc:	00000797          	auipc	a5,0x0
 bc0:	33c78793          	addi	a5,a5,828 # ef8 <freep>
 bc4:	639c                	ld	a5,0(a5)
 bc6:	fef43423          	sd	a5,-24(s0)
 bca:	a815                	j	bfe <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bcc:	fe843783          	ld	a5,-24(s0)
 bd0:	639c                	ld	a5,0(a5)
 bd2:	fe843703          	ld	a4,-24(s0)
 bd6:	00f76f63          	bltu	a4,a5,bf4 <free+0x4c>
 bda:	fe043703          	ld	a4,-32(s0)
 bde:	fe843783          	ld	a5,-24(s0)
 be2:	02e7eb63          	bltu	a5,a4,c18 <free+0x70>
 be6:	fe843783          	ld	a5,-24(s0)
 bea:	639c                	ld	a5,0(a5)
 bec:	fe043703          	ld	a4,-32(s0)
 bf0:	02f76463          	bltu	a4,a5,c18 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bf4:	fe843783          	ld	a5,-24(s0)
 bf8:	639c                	ld	a5,0(a5)
 bfa:	fef43423          	sd	a5,-24(s0)
 bfe:	fe043703          	ld	a4,-32(s0)
 c02:	fe843783          	ld	a5,-24(s0)
 c06:	fce7f3e3          	bgeu	a5,a4,bcc <free+0x24>
 c0a:	fe843783          	ld	a5,-24(s0)
 c0e:	639c                	ld	a5,0(a5)
 c10:	fe043703          	ld	a4,-32(s0)
 c14:	faf77ce3          	bgeu	a4,a5,bcc <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c18:	fe043783          	ld	a5,-32(s0)
 c1c:	479c                	lw	a5,8(a5)
 c1e:	1782                	slli	a5,a5,0x20
 c20:	9381                	srli	a5,a5,0x20
 c22:	0792                	slli	a5,a5,0x4
 c24:	fe043703          	ld	a4,-32(s0)
 c28:	973e                	add	a4,a4,a5
 c2a:	fe843783          	ld	a5,-24(s0)
 c2e:	639c                	ld	a5,0(a5)
 c30:	02f71763          	bne	a4,a5,c5e <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 c34:	fe043783          	ld	a5,-32(s0)
 c38:	4798                	lw	a4,8(a5)
 c3a:	fe843783          	ld	a5,-24(s0)
 c3e:	639c                	ld	a5,0(a5)
 c40:	479c                	lw	a5,8(a5)
 c42:	9fb9                	addw	a5,a5,a4
 c44:	0007871b          	sext.w	a4,a5
 c48:	fe043783          	ld	a5,-32(s0)
 c4c:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 c4e:	fe843783          	ld	a5,-24(s0)
 c52:	639c                	ld	a5,0(a5)
 c54:	6398                	ld	a4,0(a5)
 c56:	fe043783          	ld	a5,-32(s0)
 c5a:	e398                	sd	a4,0(a5)
 c5c:	a039                	j	c6a <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 c5e:	fe843783          	ld	a5,-24(s0)
 c62:	6398                	ld	a4,0(a5)
 c64:	fe043783          	ld	a5,-32(s0)
 c68:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 c6a:	fe843783          	ld	a5,-24(s0)
 c6e:	479c                	lw	a5,8(a5)
 c70:	1782                	slli	a5,a5,0x20
 c72:	9381                	srli	a5,a5,0x20
 c74:	0792                	slli	a5,a5,0x4
 c76:	fe843703          	ld	a4,-24(s0)
 c7a:	97ba                	add	a5,a5,a4
 c7c:	fe043703          	ld	a4,-32(s0)
 c80:	02f71563          	bne	a4,a5,caa <free+0x102>
    p->s.size += bp->s.size;
 c84:	fe843783          	ld	a5,-24(s0)
 c88:	4798                	lw	a4,8(a5)
 c8a:	fe043783          	ld	a5,-32(s0)
 c8e:	479c                	lw	a5,8(a5)
 c90:	9fb9                	addw	a5,a5,a4
 c92:	0007871b          	sext.w	a4,a5
 c96:	fe843783          	ld	a5,-24(s0)
 c9a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c9c:	fe043783          	ld	a5,-32(s0)
 ca0:	6398                	ld	a4,0(a5)
 ca2:	fe843783          	ld	a5,-24(s0)
 ca6:	e398                	sd	a4,0(a5)
 ca8:	a031                	j	cb4 <free+0x10c>
  } else
    p->s.ptr = bp;
 caa:	fe843783          	ld	a5,-24(s0)
 cae:	fe043703          	ld	a4,-32(s0)
 cb2:	e398                	sd	a4,0(a5)
  freep = p;
 cb4:	00000797          	auipc	a5,0x0
 cb8:	24478793          	addi	a5,a5,580 # ef8 <freep>
 cbc:	fe843703          	ld	a4,-24(s0)
 cc0:	e398                	sd	a4,0(a5)
}
 cc2:	0001                	nop
 cc4:	7422                	ld	s0,40(sp)
 cc6:	6145                	addi	sp,sp,48
 cc8:	8082                	ret

0000000000000cca <morecore>:

static Header*
morecore(uint nu)
{
 cca:	7179                	addi	sp,sp,-48
 ccc:	f406                	sd	ra,40(sp)
 cce:	f022                	sd	s0,32(sp)
 cd0:	1800                	addi	s0,sp,48
 cd2:	87aa                	mv	a5,a0
 cd4:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 cd8:	fdc42783          	lw	a5,-36(s0)
 cdc:	0007871b          	sext.w	a4,a5
 ce0:	6785                	lui	a5,0x1
 ce2:	00f77563          	bgeu	a4,a5,cec <morecore+0x22>
    nu = 4096;
 ce6:	6785                	lui	a5,0x1
 ce8:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 cec:	fdc42783          	lw	a5,-36(s0)
 cf0:	0047979b          	slliw	a5,a5,0x4
 cf4:	2781                	sext.w	a5,a5
 cf6:	2781                	sext.w	a5,a5
 cf8:	853e                	mv	a0,a5
 cfa:	00000097          	auipc	ra,0x0
 cfe:	9a8080e7          	jalr	-1624(ra) # 6a2 <sbrk>
 d02:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 d06:	fe843703          	ld	a4,-24(s0)
 d0a:	57fd                	li	a5,-1
 d0c:	00f71463          	bne	a4,a5,d14 <morecore+0x4a>
    return 0;
 d10:	4781                	li	a5,0
 d12:	a03d                	j	d40 <morecore+0x76>
  hp = (Header*)p;
 d14:	fe843783          	ld	a5,-24(s0)
 d18:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 d1c:	fe043783          	ld	a5,-32(s0)
 d20:	fdc42703          	lw	a4,-36(s0)
 d24:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 d26:	fe043783          	ld	a5,-32(s0)
 d2a:	07c1                	addi	a5,a5,16
 d2c:	853e                	mv	a0,a5
 d2e:	00000097          	auipc	ra,0x0
 d32:	e7a080e7          	jalr	-390(ra) # ba8 <free>
  return freep;
 d36:	00000797          	auipc	a5,0x0
 d3a:	1c278793          	addi	a5,a5,450 # ef8 <freep>
 d3e:	639c                	ld	a5,0(a5)
}
 d40:	853e                	mv	a0,a5
 d42:	70a2                	ld	ra,40(sp)
 d44:	7402                	ld	s0,32(sp)
 d46:	6145                	addi	sp,sp,48
 d48:	8082                	ret

0000000000000d4a <malloc>:

void*
malloc(uint nbytes)
{
 d4a:	7139                	addi	sp,sp,-64
 d4c:	fc06                	sd	ra,56(sp)
 d4e:	f822                	sd	s0,48(sp)
 d50:	0080                	addi	s0,sp,64
 d52:	87aa                	mv	a5,a0
 d54:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d58:	fcc46783          	lwu	a5,-52(s0)
 d5c:	07bd                	addi	a5,a5,15
 d5e:	8391                	srli	a5,a5,0x4
 d60:	2781                	sext.w	a5,a5
 d62:	2785                	addiw	a5,a5,1
 d64:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 d68:	00000797          	auipc	a5,0x0
 d6c:	19078793          	addi	a5,a5,400 # ef8 <freep>
 d70:	639c                	ld	a5,0(a5)
 d72:	fef43023          	sd	a5,-32(s0)
 d76:	fe043783          	ld	a5,-32(s0)
 d7a:	ef95                	bnez	a5,db6 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 d7c:	00000797          	auipc	a5,0x0
 d80:	16c78793          	addi	a5,a5,364 # ee8 <base>
 d84:	fef43023          	sd	a5,-32(s0)
 d88:	00000797          	auipc	a5,0x0
 d8c:	17078793          	addi	a5,a5,368 # ef8 <freep>
 d90:	fe043703          	ld	a4,-32(s0)
 d94:	e398                	sd	a4,0(a5)
 d96:	00000797          	auipc	a5,0x0
 d9a:	16278793          	addi	a5,a5,354 # ef8 <freep>
 d9e:	6398                	ld	a4,0(a5)
 da0:	00000797          	auipc	a5,0x0
 da4:	14878793          	addi	a5,a5,328 # ee8 <base>
 da8:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 daa:	00000797          	auipc	a5,0x0
 dae:	13e78793          	addi	a5,a5,318 # ee8 <base>
 db2:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 db6:	fe043783          	ld	a5,-32(s0)
 dba:	639c                	ld	a5,0(a5)
 dbc:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 dc0:	fe843783          	ld	a5,-24(s0)
 dc4:	4798                	lw	a4,8(a5)
 dc6:	fdc42783          	lw	a5,-36(s0)
 dca:	2781                	sext.w	a5,a5
 dcc:	06f76863          	bltu	a4,a5,e3c <malloc+0xf2>
      if(p->s.size == nunits)
 dd0:	fe843783          	ld	a5,-24(s0)
 dd4:	4798                	lw	a4,8(a5)
 dd6:	fdc42783          	lw	a5,-36(s0)
 dda:	2781                	sext.w	a5,a5
 ddc:	00e79963          	bne	a5,a4,dee <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 de0:	fe843783          	ld	a5,-24(s0)
 de4:	6398                	ld	a4,0(a5)
 de6:	fe043783          	ld	a5,-32(s0)
 dea:	e398                	sd	a4,0(a5)
 dec:	a82d                	j	e26 <malloc+0xdc>
      else {
        p->s.size -= nunits;
 dee:	fe843783          	ld	a5,-24(s0)
 df2:	4798                	lw	a4,8(a5)
 df4:	fdc42783          	lw	a5,-36(s0)
 df8:	40f707bb          	subw	a5,a4,a5
 dfc:	0007871b          	sext.w	a4,a5
 e00:	fe843783          	ld	a5,-24(s0)
 e04:	c798                	sw	a4,8(a5)
        p += p->s.size;
 e06:	fe843783          	ld	a5,-24(s0)
 e0a:	479c                	lw	a5,8(a5)
 e0c:	1782                	slli	a5,a5,0x20
 e0e:	9381                	srli	a5,a5,0x20
 e10:	0792                	slli	a5,a5,0x4
 e12:	fe843703          	ld	a4,-24(s0)
 e16:	97ba                	add	a5,a5,a4
 e18:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 e1c:	fe843783          	ld	a5,-24(s0)
 e20:	fdc42703          	lw	a4,-36(s0)
 e24:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 e26:	00000797          	auipc	a5,0x0
 e2a:	0d278793          	addi	a5,a5,210 # ef8 <freep>
 e2e:	fe043703          	ld	a4,-32(s0)
 e32:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 e34:	fe843783          	ld	a5,-24(s0)
 e38:	07c1                	addi	a5,a5,16
 e3a:	a091                	j	e7e <malloc+0x134>
    }
    if(p == freep)
 e3c:	00000797          	auipc	a5,0x0
 e40:	0bc78793          	addi	a5,a5,188 # ef8 <freep>
 e44:	639c                	ld	a5,0(a5)
 e46:	fe843703          	ld	a4,-24(s0)
 e4a:	02f71063          	bne	a4,a5,e6a <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 e4e:	fdc42783          	lw	a5,-36(s0)
 e52:	853e                	mv	a0,a5
 e54:	00000097          	auipc	ra,0x0
 e58:	e76080e7          	jalr	-394(ra) # cca <morecore>
 e5c:	fea43423          	sd	a0,-24(s0)
 e60:	fe843783          	ld	a5,-24(s0)
 e64:	e399                	bnez	a5,e6a <malloc+0x120>
        return 0;
 e66:	4781                	li	a5,0
 e68:	a819                	j	e7e <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e6a:	fe843783          	ld	a5,-24(s0)
 e6e:	fef43023          	sd	a5,-32(s0)
 e72:	fe843783          	ld	a5,-24(s0)
 e76:	639c                	ld	a5,0(a5)
 e78:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 e7c:	b791                	j	dc0 <malloc+0x76>
  }
}
 e7e:	853e                	mv	a0,a5
 e80:	70e2                	ld	ra,56(sp)
 e82:	7442                	ld	s0,48(sp)
 e84:	6121                	addi	sp,sp,64
 e86:	8082                	ret
