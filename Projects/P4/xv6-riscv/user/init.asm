
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   8:	4589                	li	a1,2
   a:	00001517          	auipc	a0,0x1
   e:	fde50513          	addi	a0,a0,-34 # fe8 <cv_init+0x20>
  12:	00000097          	auipc	ra,0x0
  16:	5e0080e7          	jalr	1504(ra) # 5f2 <open>
  1a:	87aa                	mv	a5,a0
  1c:	0207d563          	bgez	a5,46 <main+0x46>
    mknod("console", CONSOLE, 0);
  20:	4601                	li	a2,0
  22:	4585                	li	a1,1
  24:	00001517          	auipc	a0,0x1
  28:	fc450513          	addi	a0,a0,-60 # fe8 <cv_init+0x20>
  2c:	00000097          	auipc	ra,0x0
  30:	5ce080e7          	jalr	1486(ra) # 5fa <mknod>
    open("console", O_RDWR);
  34:	4589                	li	a1,2
  36:	00001517          	auipc	a0,0x1
  3a:	fb250513          	addi	a0,a0,-78 # fe8 <cv_init+0x20>
  3e:	00000097          	auipc	ra,0x0
  42:	5b4080e7          	jalr	1460(ra) # 5f2 <open>
  }
  dup(0);  // stdout
  46:	4501                	li	a0,0
  48:	00000097          	auipc	ra,0x0
  4c:	5e2080e7          	jalr	1506(ra) # 62a <dup>
  dup(0);  // stderr
  50:	4501                	li	a0,0
  52:	00000097          	auipc	ra,0x0
  56:	5d8080e7          	jalr	1496(ra) # 62a <dup>

  for(;;){
    printf("init: starting sh\n");
  5a:	00001517          	auipc	a0,0x1
  5e:	f9650513          	addi	a0,a0,-106 # ff0 <cv_init+0x28>
  62:	00001097          	auipc	ra,0x1
  66:	a88080e7          	jalr	-1400(ra) # aea <printf>
    pid = fork();
  6a:	00000097          	auipc	ra,0x0
  6e:	540080e7          	jalr	1344(ra) # 5aa <fork>
  72:	87aa                	mv	a5,a0
  74:	fef42623          	sw	a5,-20(s0)
    if(pid < 0){
  78:	fec42783          	lw	a5,-20(s0)
  7c:	2781                	sext.w	a5,a5
  7e:	0007df63          	bgez	a5,9c <main+0x9c>
      printf("init: fork failed\n");
  82:	00001517          	auipc	a0,0x1
  86:	f8650513          	addi	a0,a0,-122 # 1008 <cv_init+0x40>
  8a:	00001097          	auipc	ra,0x1
  8e:	a60080e7          	jalr	-1440(ra) # aea <printf>
      exit(1);
  92:	4505                	li	a0,1
  94:	00000097          	auipc	ra,0x0
  98:	51e080e7          	jalr	1310(ra) # 5b2 <exit>
    }
    if(pid == 0){
  9c:	fec42783          	lw	a5,-20(s0)
  a0:	2781                	sext.w	a5,a5
  a2:	eb95                	bnez	a5,d6 <main+0xd6>
      exec("sh", argv);
  a4:	00001597          	auipc	a1,0x1
  a8:	00c58593          	addi	a1,a1,12 # 10b0 <argv>
  ac:	00001517          	auipc	a0,0x1
  b0:	f3450513          	addi	a0,a0,-204 # fe0 <cv_init+0x18>
  b4:	00000097          	auipc	ra,0x0
  b8:	536080e7          	jalr	1334(ra) # 5ea <exec>
      printf("init: exec sh failed\n");
  bc:	00001517          	auipc	a0,0x1
  c0:	f6450513          	addi	a0,a0,-156 # 1020 <cv_init+0x58>
  c4:	00001097          	auipc	ra,0x1
  c8:	a26080e7          	jalr	-1498(ra) # aea <printf>
      exit(1);
  cc:	4505                	li	a0,1
  ce:	00000097          	auipc	ra,0x0
  d2:	4e4080e7          	jalr	1252(ra) # 5b2 <exit>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  d6:	4501                	li	a0,0
  d8:	00000097          	auipc	ra,0x0
  dc:	4e2080e7          	jalr	1250(ra) # 5ba <wait>
  e0:	87aa                	mv	a5,a0
  e2:	fef42423          	sw	a5,-24(s0)
      if(wpid == pid){
  e6:	fe842783          	lw	a5,-24(s0)
  ea:	873e                	mv	a4,a5
  ec:	fec42783          	lw	a5,-20(s0)
  f0:	2701                	sext.w	a4,a4
  f2:	2781                	sext.w	a5,a5
  f4:	02f70463          	beq	a4,a5,11c <main+0x11c>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  f8:	fe842783          	lw	a5,-24(s0)
  fc:	2781                	sext.w	a5,a5
  fe:	fc07dce3          	bgez	a5,d6 <main+0xd6>
        printf("init: wait returned an error\n");
 102:	00001517          	auipc	a0,0x1
 106:	f3650513          	addi	a0,a0,-202 # 1038 <cv_init+0x70>
 10a:	00001097          	auipc	ra,0x1
 10e:	9e0080e7          	jalr	-1568(ra) # aea <printf>
        exit(1);
 112:	4505                	li	a0,1
 114:	00000097          	auipc	ra,0x0
 118:	49e080e7          	jalr	1182(ra) # 5b2 <exit>
        break;
 11c:	0001                	nop
    printf("init: starting sh\n");
 11e:	bf35                	j	5a <main+0x5a>

0000000000000120 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 120:	7179                	addi	sp,sp,-48
 122:	f422                	sd	s0,40(sp)
 124:	1800                	addi	s0,sp,48
 126:	fca43c23          	sd	a0,-40(s0)
 12a:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 12e:	fd843783          	ld	a5,-40(s0)
 132:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 136:	0001                	nop
 138:	fd043703          	ld	a4,-48(s0)
 13c:	00170793          	addi	a5,a4,1
 140:	fcf43823          	sd	a5,-48(s0)
 144:	fd843783          	ld	a5,-40(s0)
 148:	00178693          	addi	a3,a5,1
 14c:	fcd43c23          	sd	a3,-40(s0)
 150:	00074703          	lbu	a4,0(a4)
 154:	00e78023          	sb	a4,0(a5)
 158:	0007c783          	lbu	a5,0(a5)
 15c:	fff1                	bnez	a5,138 <strcpy+0x18>
    ;
  return os;
 15e:	fe843783          	ld	a5,-24(s0)
}
 162:	853e                	mv	a0,a5
 164:	7422                	ld	s0,40(sp)
 166:	6145                	addi	sp,sp,48
 168:	8082                	ret

000000000000016a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 16a:	1101                	addi	sp,sp,-32
 16c:	ec22                	sd	s0,24(sp)
 16e:	1000                	addi	s0,sp,32
 170:	fea43423          	sd	a0,-24(s0)
 174:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 178:	a819                	j	18e <strcmp+0x24>
    p++, q++;
 17a:	fe843783          	ld	a5,-24(s0)
 17e:	0785                	addi	a5,a5,1
 180:	fef43423          	sd	a5,-24(s0)
 184:	fe043783          	ld	a5,-32(s0)
 188:	0785                	addi	a5,a5,1
 18a:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 18e:	fe843783          	ld	a5,-24(s0)
 192:	0007c783          	lbu	a5,0(a5)
 196:	cb99                	beqz	a5,1ac <strcmp+0x42>
 198:	fe843783          	ld	a5,-24(s0)
 19c:	0007c703          	lbu	a4,0(a5)
 1a0:	fe043783          	ld	a5,-32(s0)
 1a4:	0007c783          	lbu	a5,0(a5)
 1a8:	fcf709e3          	beq	a4,a5,17a <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 1ac:	fe843783          	ld	a5,-24(s0)
 1b0:	0007c783          	lbu	a5,0(a5)
 1b4:	0007871b          	sext.w	a4,a5
 1b8:	fe043783          	ld	a5,-32(s0)
 1bc:	0007c783          	lbu	a5,0(a5)
 1c0:	2781                	sext.w	a5,a5
 1c2:	40f707bb          	subw	a5,a4,a5
 1c6:	2781                	sext.w	a5,a5
}
 1c8:	853e                	mv	a0,a5
 1ca:	6462                	ld	s0,24(sp)
 1cc:	6105                	addi	sp,sp,32
 1ce:	8082                	ret

00000000000001d0 <strlen>:

uint
strlen(const char *s)
{
 1d0:	7179                	addi	sp,sp,-48
 1d2:	f422                	sd	s0,40(sp)
 1d4:	1800                	addi	s0,sp,48
 1d6:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 1da:	fe042623          	sw	zero,-20(s0)
 1de:	a031                	j	1ea <strlen+0x1a>
 1e0:	fec42783          	lw	a5,-20(s0)
 1e4:	2785                	addiw	a5,a5,1
 1e6:	fef42623          	sw	a5,-20(s0)
 1ea:	fec42783          	lw	a5,-20(s0)
 1ee:	fd843703          	ld	a4,-40(s0)
 1f2:	97ba                	add	a5,a5,a4
 1f4:	0007c783          	lbu	a5,0(a5)
 1f8:	f7e5                	bnez	a5,1e0 <strlen+0x10>
    ;
  return n;
 1fa:	fec42783          	lw	a5,-20(s0)
}
 1fe:	853e                	mv	a0,a5
 200:	7422                	ld	s0,40(sp)
 202:	6145                	addi	sp,sp,48
 204:	8082                	ret

0000000000000206 <memset>:

void*
memset(void *dst, int c, uint n)
{
 206:	7179                	addi	sp,sp,-48
 208:	f422                	sd	s0,40(sp)
 20a:	1800                	addi	s0,sp,48
 20c:	fca43c23          	sd	a0,-40(s0)
 210:	87ae                	mv	a5,a1
 212:	8732                	mv	a4,a2
 214:	fcf42a23          	sw	a5,-44(s0)
 218:	87ba                	mv	a5,a4
 21a:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 21e:	fd843783          	ld	a5,-40(s0)
 222:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 226:	fe042623          	sw	zero,-20(s0)
 22a:	a00d                	j	24c <memset+0x46>
    cdst[i] = c;
 22c:	fec42783          	lw	a5,-20(s0)
 230:	fe043703          	ld	a4,-32(s0)
 234:	97ba                	add	a5,a5,a4
 236:	fd442703          	lw	a4,-44(s0)
 23a:	0ff77713          	zext.b	a4,a4
 23e:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 242:	fec42783          	lw	a5,-20(s0)
 246:	2785                	addiw	a5,a5,1
 248:	fef42623          	sw	a5,-20(s0)
 24c:	fec42703          	lw	a4,-20(s0)
 250:	fd042783          	lw	a5,-48(s0)
 254:	2781                	sext.w	a5,a5
 256:	fcf76be3          	bltu	a4,a5,22c <memset+0x26>
  }
  return dst;
 25a:	fd843783          	ld	a5,-40(s0)
}
 25e:	853e                	mv	a0,a5
 260:	7422                	ld	s0,40(sp)
 262:	6145                	addi	sp,sp,48
 264:	8082                	ret

0000000000000266 <strchr>:

char*
strchr(const char *s, char c)
{
 266:	1101                	addi	sp,sp,-32
 268:	ec22                	sd	s0,24(sp)
 26a:	1000                	addi	s0,sp,32
 26c:	fea43423          	sd	a0,-24(s0)
 270:	87ae                	mv	a5,a1
 272:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 276:	a01d                	j	29c <strchr+0x36>
    if(*s == c)
 278:	fe843783          	ld	a5,-24(s0)
 27c:	0007c703          	lbu	a4,0(a5)
 280:	fe744783          	lbu	a5,-25(s0)
 284:	0ff7f793          	zext.b	a5,a5
 288:	00e79563          	bne	a5,a4,292 <strchr+0x2c>
      return (char*)s;
 28c:	fe843783          	ld	a5,-24(s0)
 290:	a821                	j	2a8 <strchr+0x42>
  for(; *s; s++)
 292:	fe843783          	ld	a5,-24(s0)
 296:	0785                	addi	a5,a5,1
 298:	fef43423          	sd	a5,-24(s0)
 29c:	fe843783          	ld	a5,-24(s0)
 2a0:	0007c783          	lbu	a5,0(a5)
 2a4:	fbf1                	bnez	a5,278 <strchr+0x12>
  return 0;
 2a6:	4781                	li	a5,0
}
 2a8:	853e                	mv	a0,a5
 2aa:	6462                	ld	s0,24(sp)
 2ac:	6105                	addi	sp,sp,32
 2ae:	8082                	ret

00000000000002b0 <gets>:

char*
gets(char *buf, int max)
{
 2b0:	7179                	addi	sp,sp,-48
 2b2:	f406                	sd	ra,40(sp)
 2b4:	f022                	sd	s0,32(sp)
 2b6:	1800                	addi	s0,sp,48
 2b8:	fca43c23          	sd	a0,-40(s0)
 2bc:	87ae                	mv	a5,a1
 2be:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2c2:	fe042623          	sw	zero,-20(s0)
 2c6:	a8a1                	j	31e <gets+0x6e>
    cc = read(0, &c, 1);
 2c8:	fe740793          	addi	a5,s0,-25
 2cc:	4605                	li	a2,1
 2ce:	85be                	mv	a1,a5
 2d0:	4501                	li	a0,0
 2d2:	00000097          	auipc	ra,0x0
 2d6:	2f8080e7          	jalr	760(ra) # 5ca <read>
 2da:	87aa                	mv	a5,a0
 2dc:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 2e0:	fe842783          	lw	a5,-24(s0)
 2e4:	2781                	sext.w	a5,a5
 2e6:	04f05763          	blez	a5,334 <gets+0x84>
      break;
    buf[i++] = c;
 2ea:	fec42783          	lw	a5,-20(s0)
 2ee:	0017871b          	addiw	a4,a5,1
 2f2:	fee42623          	sw	a4,-20(s0)
 2f6:	873e                	mv	a4,a5
 2f8:	fd843783          	ld	a5,-40(s0)
 2fc:	97ba                	add	a5,a5,a4
 2fe:	fe744703          	lbu	a4,-25(s0)
 302:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 306:	fe744783          	lbu	a5,-25(s0)
 30a:	873e                	mv	a4,a5
 30c:	47a9                	li	a5,10
 30e:	02f70463          	beq	a4,a5,336 <gets+0x86>
 312:	fe744783          	lbu	a5,-25(s0)
 316:	873e                	mv	a4,a5
 318:	47b5                	li	a5,13
 31a:	00f70e63          	beq	a4,a5,336 <gets+0x86>
  for(i=0; i+1 < max; ){
 31e:	fec42783          	lw	a5,-20(s0)
 322:	2785                	addiw	a5,a5,1
 324:	0007871b          	sext.w	a4,a5
 328:	fd442783          	lw	a5,-44(s0)
 32c:	2781                	sext.w	a5,a5
 32e:	f8f74de3          	blt	a4,a5,2c8 <gets+0x18>
 332:	a011                	j	336 <gets+0x86>
      break;
 334:	0001                	nop
      break;
  }
  buf[i] = '\0';
 336:	fec42783          	lw	a5,-20(s0)
 33a:	fd843703          	ld	a4,-40(s0)
 33e:	97ba                	add	a5,a5,a4
 340:	00078023          	sb	zero,0(a5)
  return buf;
 344:	fd843783          	ld	a5,-40(s0)
}
 348:	853e                	mv	a0,a5
 34a:	70a2                	ld	ra,40(sp)
 34c:	7402                	ld	s0,32(sp)
 34e:	6145                	addi	sp,sp,48
 350:	8082                	ret

0000000000000352 <stat>:

int
stat(const char *n, struct stat *st)
{
 352:	7179                	addi	sp,sp,-48
 354:	f406                	sd	ra,40(sp)
 356:	f022                	sd	s0,32(sp)
 358:	1800                	addi	s0,sp,48
 35a:	fca43c23          	sd	a0,-40(s0)
 35e:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 362:	4581                	li	a1,0
 364:	fd843503          	ld	a0,-40(s0)
 368:	00000097          	auipc	ra,0x0
 36c:	28a080e7          	jalr	650(ra) # 5f2 <open>
 370:	87aa                	mv	a5,a0
 372:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 376:	fec42783          	lw	a5,-20(s0)
 37a:	2781                	sext.w	a5,a5
 37c:	0007d463          	bgez	a5,384 <stat+0x32>
    return -1;
 380:	57fd                	li	a5,-1
 382:	a035                	j	3ae <stat+0x5c>
  r = fstat(fd, st);
 384:	fec42783          	lw	a5,-20(s0)
 388:	fd043583          	ld	a1,-48(s0)
 38c:	853e                	mv	a0,a5
 38e:	00000097          	auipc	ra,0x0
 392:	27c080e7          	jalr	636(ra) # 60a <fstat>
 396:	87aa                	mv	a5,a0
 398:	fef42423          	sw	a5,-24(s0)
  close(fd);
 39c:	fec42783          	lw	a5,-20(s0)
 3a0:	853e                	mv	a0,a5
 3a2:	00000097          	auipc	ra,0x0
 3a6:	238080e7          	jalr	568(ra) # 5da <close>
  return r;
 3aa:	fe842783          	lw	a5,-24(s0)
}
 3ae:	853e                	mv	a0,a5
 3b0:	70a2                	ld	ra,40(sp)
 3b2:	7402                	ld	s0,32(sp)
 3b4:	6145                	addi	sp,sp,48
 3b6:	8082                	ret

00000000000003b8 <atoi>:

int
atoi(const char *s)
{
 3b8:	7179                	addi	sp,sp,-48
 3ba:	f422                	sd	s0,40(sp)
 3bc:	1800                	addi	s0,sp,48
 3be:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 3c2:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 3c6:	a81d                	j	3fc <atoi+0x44>
    n = n*10 + *s++ - '0';
 3c8:	fec42783          	lw	a5,-20(s0)
 3cc:	873e                	mv	a4,a5
 3ce:	87ba                	mv	a5,a4
 3d0:	0027979b          	slliw	a5,a5,0x2
 3d4:	9fb9                	addw	a5,a5,a4
 3d6:	0017979b          	slliw	a5,a5,0x1
 3da:	0007871b          	sext.w	a4,a5
 3de:	fd843783          	ld	a5,-40(s0)
 3e2:	00178693          	addi	a3,a5,1
 3e6:	fcd43c23          	sd	a3,-40(s0)
 3ea:	0007c783          	lbu	a5,0(a5)
 3ee:	2781                	sext.w	a5,a5
 3f0:	9fb9                	addw	a5,a5,a4
 3f2:	2781                	sext.w	a5,a5
 3f4:	fd07879b          	addiw	a5,a5,-48
 3f8:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 3fc:	fd843783          	ld	a5,-40(s0)
 400:	0007c783          	lbu	a5,0(a5)
 404:	873e                	mv	a4,a5
 406:	02f00793          	li	a5,47
 40a:	00e7fb63          	bgeu	a5,a4,420 <atoi+0x68>
 40e:	fd843783          	ld	a5,-40(s0)
 412:	0007c783          	lbu	a5,0(a5)
 416:	873e                	mv	a4,a5
 418:	03900793          	li	a5,57
 41c:	fae7f6e3          	bgeu	a5,a4,3c8 <atoi+0x10>
  return n;
 420:	fec42783          	lw	a5,-20(s0)
}
 424:	853e                	mv	a0,a5
 426:	7422                	ld	s0,40(sp)
 428:	6145                	addi	sp,sp,48
 42a:	8082                	ret

000000000000042c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 42c:	7139                	addi	sp,sp,-64
 42e:	fc22                	sd	s0,56(sp)
 430:	0080                	addi	s0,sp,64
 432:	fca43c23          	sd	a0,-40(s0)
 436:	fcb43823          	sd	a1,-48(s0)
 43a:	87b2                	mv	a5,a2
 43c:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 440:	fd843783          	ld	a5,-40(s0)
 444:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 448:	fd043783          	ld	a5,-48(s0)
 44c:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 450:	fe043703          	ld	a4,-32(s0)
 454:	fe843783          	ld	a5,-24(s0)
 458:	02e7fc63          	bgeu	a5,a4,490 <memmove+0x64>
    while(n-- > 0)
 45c:	a00d                	j	47e <memmove+0x52>
      *dst++ = *src++;
 45e:	fe043703          	ld	a4,-32(s0)
 462:	00170793          	addi	a5,a4,1
 466:	fef43023          	sd	a5,-32(s0)
 46a:	fe843783          	ld	a5,-24(s0)
 46e:	00178693          	addi	a3,a5,1
 472:	fed43423          	sd	a3,-24(s0)
 476:	00074703          	lbu	a4,0(a4)
 47a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 47e:	fcc42783          	lw	a5,-52(s0)
 482:	fff7871b          	addiw	a4,a5,-1
 486:	fce42623          	sw	a4,-52(s0)
 48a:	fcf04ae3          	bgtz	a5,45e <memmove+0x32>
 48e:	a891                	j	4e2 <memmove+0xb6>
  } else {
    dst += n;
 490:	fcc42783          	lw	a5,-52(s0)
 494:	fe843703          	ld	a4,-24(s0)
 498:	97ba                	add	a5,a5,a4
 49a:	fef43423          	sd	a5,-24(s0)
    src += n;
 49e:	fcc42783          	lw	a5,-52(s0)
 4a2:	fe043703          	ld	a4,-32(s0)
 4a6:	97ba                	add	a5,a5,a4
 4a8:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 4ac:	a01d                	j	4d2 <memmove+0xa6>
      *--dst = *--src;
 4ae:	fe043783          	ld	a5,-32(s0)
 4b2:	17fd                	addi	a5,a5,-1
 4b4:	fef43023          	sd	a5,-32(s0)
 4b8:	fe843783          	ld	a5,-24(s0)
 4bc:	17fd                	addi	a5,a5,-1
 4be:	fef43423          	sd	a5,-24(s0)
 4c2:	fe043783          	ld	a5,-32(s0)
 4c6:	0007c703          	lbu	a4,0(a5)
 4ca:	fe843783          	ld	a5,-24(s0)
 4ce:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4d2:	fcc42783          	lw	a5,-52(s0)
 4d6:	fff7871b          	addiw	a4,a5,-1
 4da:	fce42623          	sw	a4,-52(s0)
 4de:	fcf048e3          	bgtz	a5,4ae <memmove+0x82>
  }
  return vdst;
 4e2:	fd843783          	ld	a5,-40(s0)
}
 4e6:	853e                	mv	a0,a5
 4e8:	7462                	ld	s0,56(sp)
 4ea:	6121                	addi	sp,sp,64
 4ec:	8082                	ret

00000000000004ee <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4ee:	7139                	addi	sp,sp,-64
 4f0:	fc22                	sd	s0,56(sp)
 4f2:	0080                	addi	s0,sp,64
 4f4:	fca43c23          	sd	a0,-40(s0)
 4f8:	fcb43823          	sd	a1,-48(s0)
 4fc:	87b2                	mv	a5,a2
 4fe:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 502:	fd843783          	ld	a5,-40(s0)
 506:	fef43423          	sd	a5,-24(s0)
 50a:	fd043783          	ld	a5,-48(s0)
 50e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 512:	a0a1                	j	55a <memcmp+0x6c>
    if (*p1 != *p2) {
 514:	fe843783          	ld	a5,-24(s0)
 518:	0007c703          	lbu	a4,0(a5)
 51c:	fe043783          	ld	a5,-32(s0)
 520:	0007c783          	lbu	a5,0(a5)
 524:	02f70163          	beq	a4,a5,546 <memcmp+0x58>
      return *p1 - *p2;
 528:	fe843783          	ld	a5,-24(s0)
 52c:	0007c783          	lbu	a5,0(a5)
 530:	0007871b          	sext.w	a4,a5
 534:	fe043783          	ld	a5,-32(s0)
 538:	0007c783          	lbu	a5,0(a5)
 53c:	2781                	sext.w	a5,a5
 53e:	40f707bb          	subw	a5,a4,a5
 542:	2781                	sext.w	a5,a5
 544:	a01d                	j	56a <memcmp+0x7c>
    }
    p1++;
 546:	fe843783          	ld	a5,-24(s0)
 54a:	0785                	addi	a5,a5,1
 54c:	fef43423          	sd	a5,-24(s0)
    p2++;
 550:	fe043783          	ld	a5,-32(s0)
 554:	0785                	addi	a5,a5,1
 556:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 55a:	fcc42783          	lw	a5,-52(s0)
 55e:	fff7871b          	addiw	a4,a5,-1
 562:	fce42623          	sw	a4,-52(s0)
 566:	f7dd                	bnez	a5,514 <memcmp+0x26>
  }
  return 0;
 568:	4781                	li	a5,0
}
 56a:	853e                	mv	a0,a5
 56c:	7462                	ld	s0,56(sp)
 56e:	6121                	addi	sp,sp,64
 570:	8082                	ret

0000000000000572 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 572:	7179                	addi	sp,sp,-48
 574:	f406                	sd	ra,40(sp)
 576:	f022                	sd	s0,32(sp)
 578:	1800                	addi	s0,sp,48
 57a:	fea43423          	sd	a0,-24(s0)
 57e:	feb43023          	sd	a1,-32(s0)
 582:	87b2                	mv	a5,a2
 584:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 588:	fdc42783          	lw	a5,-36(s0)
 58c:	863e                	mv	a2,a5
 58e:	fe043583          	ld	a1,-32(s0)
 592:	fe843503          	ld	a0,-24(s0)
 596:	00000097          	auipc	ra,0x0
 59a:	e96080e7          	jalr	-362(ra) # 42c <memmove>
 59e:	87aa                	mv	a5,a0
}
 5a0:	853e                	mv	a0,a5
 5a2:	70a2                	ld	ra,40(sp)
 5a4:	7402                	ld	s0,32(sp)
 5a6:	6145                	addi	sp,sp,48
 5a8:	8082                	ret

00000000000005aa <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5aa:	4885                	li	a7,1
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5b2:	4889                	li	a7,2
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <wait>:
.global wait
wait:
 li a7, SYS_wait
 5ba:	488d                	li	a7,3
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5c2:	4891                	li	a7,4
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <read>:
.global read
read:
 li a7, SYS_read
 5ca:	4895                	li	a7,5
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <write>:
.global write
write:
 li a7, SYS_write
 5d2:	48c1                	li	a7,16
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <close>:
.global close
close:
 li a7, SYS_close
 5da:	48d5                	li	a7,21
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5e2:	4899                	li	a7,6
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <exec>:
.global exec
exec:
 li a7, SYS_exec
 5ea:	489d                	li	a7,7
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <open>:
.global open
open:
 li a7, SYS_open
 5f2:	48bd                	li	a7,15
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5fa:	48c5                	li	a7,17
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 602:	48c9                	li	a7,18
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 60a:	48a1                	li	a7,8
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <link>:
.global link
link:
 li a7, SYS_link
 612:	48cd                	li	a7,19
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 61a:	48d1                	li	a7,20
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 622:	48a5                	li	a7,9
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <dup>:
.global dup
dup:
 li a7, SYS_dup
 62a:	48a9                	li	a7,10
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 632:	48ad                	li	a7,11
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 63a:	48b1                	li	a7,12
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 642:	48b5                	li	a7,13
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 64a:	48b9                	li	a7,14
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <clone>:
.global clone
clone:
 li a7, SYS_clone
 652:	48d9                	li	a7,22
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <join>:
.global join
join:
 li a7, SYS_join
 65a:	48dd                	li	a7,23
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 662:	1101                	addi	sp,sp,-32
 664:	ec06                	sd	ra,24(sp)
 666:	e822                	sd	s0,16(sp)
 668:	1000                	addi	s0,sp,32
 66a:	87aa                	mv	a5,a0
 66c:	872e                	mv	a4,a1
 66e:	fef42623          	sw	a5,-20(s0)
 672:	87ba                	mv	a5,a4
 674:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 678:	feb40713          	addi	a4,s0,-21
 67c:	fec42783          	lw	a5,-20(s0)
 680:	4605                	li	a2,1
 682:	85ba                	mv	a1,a4
 684:	853e                	mv	a0,a5
 686:	00000097          	auipc	ra,0x0
 68a:	f4c080e7          	jalr	-180(ra) # 5d2 <write>
}
 68e:	0001                	nop
 690:	60e2                	ld	ra,24(sp)
 692:	6442                	ld	s0,16(sp)
 694:	6105                	addi	sp,sp,32
 696:	8082                	ret

0000000000000698 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 698:	7139                	addi	sp,sp,-64
 69a:	fc06                	sd	ra,56(sp)
 69c:	f822                	sd	s0,48(sp)
 69e:	0080                	addi	s0,sp,64
 6a0:	87aa                	mv	a5,a0
 6a2:	8736                	mv	a4,a3
 6a4:	fcf42623          	sw	a5,-52(s0)
 6a8:	87ae                	mv	a5,a1
 6aa:	fcf42423          	sw	a5,-56(s0)
 6ae:	87b2                	mv	a5,a2
 6b0:	fcf42223          	sw	a5,-60(s0)
 6b4:	87ba                	mv	a5,a4
 6b6:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6ba:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 6be:	fc042783          	lw	a5,-64(s0)
 6c2:	2781                	sext.w	a5,a5
 6c4:	c38d                	beqz	a5,6e6 <printint+0x4e>
 6c6:	fc842783          	lw	a5,-56(s0)
 6ca:	2781                	sext.w	a5,a5
 6cc:	0007dd63          	bgez	a5,6e6 <printint+0x4e>
    neg = 1;
 6d0:	4785                	li	a5,1
 6d2:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 6d6:	fc842783          	lw	a5,-56(s0)
 6da:	40f007bb          	negw	a5,a5
 6de:	2781                	sext.w	a5,a5
 6e0:	fef42223          	sw	a5,-28(s0)
 6e4:	a029                	j	6ee <printint+0x56>
  } else {
    x = xx;
 6e6:	fc842783          	lw	a5,-56(s0)
 6ea:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 6ee:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 6f2:	fc442783          	lw	a5,-60(s0)
 6f6:	fe442703          	lw	a4,-28(s0)
 6fa:	02f777bb          	remuw	a5,a4,a5
 6fe:	0007861b          	sext.w	a2,a5
 702:	fec42783          	lw	a5,-20(s0)
 706:	0017871b          	addiw	a4,a5,1
 70a:	fee42623          	sw	a4,-20(s0)
 70e:	00001697          	auipc	a3,0x1
 712:	9b268693          	addi	a3,a3,-1614 # 10c0 <digits>
 716:	02061713          	slli	a4,a2,0x20
 71a:	9301                	srli	a4,a4,0x20
 71c:	9736                	add	a4,a4,a3
 71e:	00074703          	lbu	a4,0(a4)
 722:	17c1                	addi	a5,a5,-16
 724:	97a2                	add	a5,a5,s0
 726:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 72a:	fc442783          	lw	a5,-60(s0)
 72e:	fe442703          	lw	a4,-28(s0)
 732:	02f757bb          	divuw	a5,a4,a5
 736:	fef42223          	sw	a5,-28(s0)
 73a:	fe442783          	lw	a5,-28(s0)
 73e:	2781                	sext.w	a5,a5
 740:	fbcd                	bnez	a5,6f2 <printint+0x5a>
  if(neg)
 742:	fe842783          	lw	a5,-24(s0)
 746:	2781                	sext.w	a5,a5
 748:	cf85                	beqz	a5,780 <printint+0xe8>
    buf[i++] = '-';
 74a:	fec42783          	lw	a5,-20(s0)
 74e:	0017871b          	addiw	a4,a5,1
 752:	fee42623          	sw	a4,-20(s0)
 756:	17c1                	addi	a5,a5,-16
 758:	97a2                	add	a5,a5,s0
 75a:	02d00713          	li	a4,45
 75e:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 762:	a839                	j	780 <printint+0xe8>
    putc(fd, buf[i]);
 764:	fec42783          	lw	a5,-20(s0)
 768:	17c1                	addi	a5,a5,-16
 76a:	97a2                	add	a5,a5,s0
 76c:	fe07c703          	lbu	a4,-32(a5)
 770:	fcc42783          	lw	a5,-52(s0)
 774:	85ba                	mv	a1,a4
 776:	853e                	mv	a0,a5
 778:	00000097          	auipc	ra,0x0
 77c:	eea080e7          	jalr	-278(ra) # 662 <putc>
  while(--i >= 0)
 780:	fec42783          	lw	a5,-20(s0)
 784:	37fd                	addiw	a5,a5,-1
 786:	fef42623          	sw	a5,-20(s0)
 78a:	fec42783          	lw	a5,-20(s0)
 78e:	2781                	sext.w	a5,a5
 790:	fc07dae3          	bgez	a5,764 <printint+0xcc>
}
 794:	0001                	nop
 796:	0001                	nop
 798:	70e2                	ld	ra,56(sp)
 79a:	7442                	ld	s0,48(sp)
 79c:	6121                	addi	sp,sp,64
 79e:	8082                	ret

00000000000007a0 <printptr>:

static void
printptr(int fd, uint64 x) {
 7a0:	7179                	addi	sp,sp,-48
 7a2:	f406                	sd	ra,40(sp)
 7a4:	f022                	sd	s0,32(sp)
 7a6:	1800                	addi	s0,sp,48
 7a8:	87aa                	mv	a5,a0
 7aa:	fcb43823          	sd	a1,-48(s0)
 7ae:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 7b2:	fdc42783          	lw	a5,-36(s0)
 7b6:	03000593          	li	a1,48
 7ba:	853e                	mv	a0,a5
 7bc:	00000097          	auipc	ra,0x0
 7c0:	ea6080e7          	jalr	-346(ra) # 662 <putc>
  putc(fd, 'x');
 7c4:	fdc42783          	lw	a5,-36(s0)
 7c8:	07800593          	li	a1,120
 7cc:	853e                	mv	a0,a5
 7ce:	00000097          	auipc	ra,0x0
 7d2:	e94080e7          	jalr	-364(ra) # 662 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7d6:	fe042623          	sw	zero,-20(s0)
 7da:	a82d                	j	814 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7dc:	fd043783          	ld	a5,-48(s0)
 7e0:	93f1                	srli	a5,a5,0x3c
 7e2:	00001717          	auipc	a4,0x1
 7e6:	8de70713          	addi	a4,a4,-1826 # 10c0 <digits>
 7ea:	97ba                	add	a5,a5,a4
 7ec:	0007c703          	lbu	a4,0(a5)
 7f0:	fdc42783          	lw	a5,-36(s0)
 7f4:	85ba                	mv	a1,a4
 7f6:	853e                	mv	a0,a5
 7f8:	00000097          	auipc	ra,0x0
 7fc:	e6a080e7          	jalr	-406(ra) # 662 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 800:	fec42783          	lw	a5,-20(s0)
 804:	2785                	addiw	a5,a5,1
 806:	fef42623          	sw	a5,-20(s0)
 80a:	fd043783          	ld	a5,-48(s0)
 80e:	0792                	slli	a5,a5,0x4
 810:	fcf43823          	sd	a5,-48(s0)
 814:	fec42783          	lw	a5,-20(s0)
 818:	873e                	mv	a4,a5
 81a:	47bd                	li	a5,15
 81c:	fce7f0e3          	bgeu	a5,a4,7dc <printptr+0x3c>
}
 820:	0001                	nop
 822:	0001                	nop
 824:	70a2                	ld	ra,40(sp)
 826:	7402                	ld	s0,32(sp)
 828:	6145                	addi	sp,sp,48
 82a:	8082                	ret

000000000000082c <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 82c:	715d                	addi	sp,sp,-80
 82e:	e486                	sd	ra,72(sp)
 830:	e0a2                	sd	s0,64(sp)
 832:	0880                	addi	s0,sp,80
 834:	87aa                	mv	a5,a0
 836:	fcb43023          	sd	a1,-64(s0)
 83a:	fac43c23          	sd	a2,-72(s0)
 83e:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 842:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 846:	fe042223          	sw	zero,-28(s0)
 84a:	a42d                	j	a74 <vprintf+0x248>
    c = fmt[i] & 0xff;
 84c:	fe442783          	lw	a5,-28(s0)
 850:	fc043703          	ld	a4,-64(s0)
 854:	97ba                	add	a5,a5,a4
 856:	0007c783          	lbu	a5,0(a5)
 85a:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 85e:	fe042783          	lw	a5,-32(s0)
 862:	2781                	sext.w	a5,a5
 864:	eb9d                	bnez	a5,89a <vprintf+0x6e>
      if(c == '%'){
 866:	fdc42783          	lw	a5,-36(s0)
 86a:	0007871b          	sext.w	a4,a5
 86e:	02500793          	li	a5,37
 872:	00f71763          	bne	a4,a5,880 <vprintf+0x54>
        state = '%';
 876:	02500793          	li	a5,37
 87a:	fef42023          	sw	a5,-32(s0)
 87e:	a2f5                	j	a6a <vprintf+0x23e>
      } else {
        putc(fd, c);
 880:	fdc42783          	lw	a5,-36(s0)
 884:	0ff7f713          	zext.b	a4,a5
 888:	fcc42783          	lw	a5,-52(s0)
 88c:	85ba                	mv	a1,a4
 88e:	853e                	mv	a0,a5
 890:	00000097          	auipc	ra,0x0
 894:	dd2080e7          	jalr	-558(ra) # 662 <putc>
 898:	aac9                	j	a6a <vprintf+0x23e>
      }
    } else if(state == '%'){
 89a:	fe042783          	lw	a5,-32(s0)
 89e:	0007871b          	sext.w	a4,a5
 8a2:	02500793          	li	a5,37
 8a6:	1cf71263          	bne	a4,a5,a6a <vprintf+0x23e>
      if(c == 'd'){
 8aa:	fdc42783          	lw	a5,-36(s0)
 8ae:	0007871b          	sext.w	a4,a5
 8b2:	06400793          	li	a5,100
 8b6:	02f71463          	bne	a4,a5,8de <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 8ba:	fb843783          	ld	a5,-72(s0)
 8be:	00878713          	addi	a4,a5,8
 8c2:	fae43c23          	sd	a4,-72(s0)
 8c6:	4398                	lw	a4,0(a5)
 8c8:	fcc42783          	lw	a5,-52(s0)
 8cc:	4685                	li	a3,1
 8ce:	4629                	li	a2,10
 8d0:	85ba                	mv	a1,a4
 8d2:	853e                	mv	a0,a5
 8d4:	00000097          	auipc	ra,0x0
 8d8:	dc4080e7          	jalr	-572(ra) # 698 <printint>
 8dc:	a269                	j	a66 <vprintf+0x23a>
      } else if(c == 'l') {
 8de:	fdc42783          	lw	a5,-36(s0)
 8e2:	0007871b          	sext.w	a4,a5
 8e6:	06c00793          	li	a5,108
 8ea:	02f71663          	bne	a4,a5,916 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ee:	fb843783          	ld	a5,-72(s0)
 8f2:	00878713          	addi	a4,a5,8
 8f6:	fae43c23          	sd	a4,-72(s0)
 8fa:	639c                	ld	a5,0(a5)
 8fc:	0007871b          	sext.w	a4,a5
 900:	fcc42783          	lw	a5,-52(s0)
 904:	4681                	li	a3,0
 906:	4629                	li	a2,10
 908:	85ba                	mv	a1,a4
 90a:	853e                	mv	a0,a5
 90c:	00000097          	auipc	ra,0x0
 910:	d8c080e7          	jalr	-628(ra) # 698 <printint>
 914:	aa89                	j	a66 <vprintf+0x23a>
      } else if(c == 'x') {
 916:	fdc42783          	lw	a5,-36(s0)
 91a:	0007871b          	sext.w	a4,a5
 91e:	07800793          	li	a5,120
 922:	02f71463          	bne	a4,a5,94a <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 926:	fb843783          	ld	a5,-72(s0)
 92a:	00878713          	addi	a4,a5,8
 92e:	fae43c23          	sd	a4,-72(s0)
 932:	4398                	lw	a4,0(a5)
 934:	fcc42783          	lw	a5,-52(s0)
 938:	4681                	li	a3,0
 93a:	4641                	li	a2,16
 93c:	85ba                	mv	a1,a4
 93e:	853e                	mv	a0,a5
 940:	00000097          	auipc	ra,0x0
 944:	d58080e7          	jalr	-680(ra) # 698 <printint>
 948:	aa39                	j	a66 <vprintf+0x23a>
      } else if(c == 'p') {
 94a:	fdc42783          	lw	a5,-36(s0)
 94e:	0007871b          	sext.w	a4,a5
 952:	07000793          	li	a5,112
 956:	02f71263          	bne	a4,a5,97a <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 95a:	fb843783          	ld	a5,-72(s0)
 95e:	00878713          	addi	a4,a5,8
 962:	fae43c23          	sd	a4,-72(s0)
 966:	6398                	ld	a4,0(a5)
 968:	fcc42783          	lw	a5,-52(s0)
 96c:	85ba                	mv	a1,a4
 96e:	853e                	mv	a0,a5
 970:	00000097          	auipc	ra,0x0
 974:	e30080e7          	jalr	-464(ra) # 7a0 <printptr>
 978:	a0fd                	j	a66 <vprintf+0x23a>
      } else if(c == 's'){
 97a:	fdc42783          	lw	a5,-36(s0)
 97e:	0007871b          	sext.w	a4,a5
 982:	07300793          	li	a5,115
 986:	04f71c63          	bne	a4,a5,9de <vprintf+0x1b2>
        s = va_arg(ap, char*);
 98a:	fb843783          	ld	a5,-72(s0)
 98e:	00878713          	addi	a4,a5,8
 992:	fae43c23          	sd	a4,-72(s0)
 996:	639c                	ld	a5,0(a5)
 998:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 99c:	fe843783          	ld	a5,-24(s0)
 9a0:	eb8d                	bnez	a5,9d2 <vprintf+0x1a6>
          s = "(null)";
 9a2:	00000797          	auipc	a5,0x0
 9a6:	6b678793          	addi	a5,a5,1718 # 1058 <cv_init+0x90>
 9aa:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 9ae:	a015                	j	9d2 <vprintf+0x1a6>
          putc(fd, *s);
 9b0:	fe843783          	ld	a5,-24(s0)
 9b4:	0007c703          	lbu	a4,0(a5)
 9b8:	fcc42783          	lw	a5,-52(s0)
 9bc:	85ba                	mv	a1,a4
 9be:	853e                	mv	a0,a5
 9c0:	00000097          	auipc	ra,0x0
 9c4:	ca2080e7          	jalr	-862(ra) # 662 <putc>
          s++;
 9c8:	fe843783          	ld	a5,-24(s0)
 9cc:	0785                	addi	a5,a5,1
 9ce:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 9d2:	fe843783          	ld	a5,-24(s0)
 9d6:	0007c783          	lbu	a5,0(a5)
 9da:	fbf9                	bnez	a5,9b0 <vprintf+0x184>
 9dc:	a069                	j	a66 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 9de:	fdc42783          	lw	a5,-36(s0)
 9e2:	0007871b          	sext.w	a4,a5
 9e6:	06300793          	li	a5,99
 9ea:	02f71463          	bne	a4,a5,a12 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 9ee:	fb843783          	ld	a5,-72(s0)
 9f2:	00878713          	addi	a4,a5,8
 9f6:	fae43c23          	sd	a4,-72(s0)
 9fa:	439c                	lw	a5,0(a5)
 9fc:	0ff7f713          	zext.b	a4,a5
 a00:	fcc42783          	lw	a5,-52(s0)
 a04:	85ba                	mv	a1,a4
 a06:	853e                	mv	a0,a5
 a08:	00000097          	auipc	ra,0x0
 a0c:	c5a080e7          	jalr	-934(ra) # 662 <putc>
 a10:	a899                	j	a66 <vprintf+0x23a>
      } else if(c == '%'){
 a12:	fdc42783          	lw	a5,-36(s0)
 a16:	0007871b          	sext.w	a4,a5
 a1a:	02500793          	li	a5,37
 a1e:	00f71f63          	bne	a4,a5,a3c <vprintf+0x210>
        putc(fd, c);
 a22:	fdc42783          	lw	a5,-36(s0)
 a26:	0ff7f713          	zext.b	a4,a5
 a2a:	fcc42783          	lw	a5,-52(s0)
 a2e:	85ba                	mv	a1,a4
 a30:	853e                	mv	a0,a5
 a32:	00000097          	auipc	ra,0x0
 a36:	c30080e7          	jalr	-976(ra) # 662 <putc>
 a3a:	a035                	j	a66 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a3c:	fcc42783          	lw	a5,-52(s0)
 a40:	02500593          	li	a1,37
 a44:	853e                	mv	a0,a5
 a46:	00000097          	auipc	ra,0x0
 a4a:	c1c080e7          	jalr	-996(ra) # 662 <putc>
        putc(fd, c);
 a4e:	fdc42783          	lw	a5,-36(s0)
 a52:	0ff7f713          	zext.b	a4,a5
 a56:	fcc42783          	lw	a5,-52(s0)
 a5a:	85ba                	mv	a1,a4
 a5c:	853e                	mv	a0,a5
 a5e:	00000097          	auipc	ra,0x0
 a62:	c04080e7          	jalr	-1020(ra) # 662 <putc>
      }
      state = 0;
 a66:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 a6a:	fe442783          	lw	a5,-28(s0)
 a6e:	2785                	addiw	a5,a5,1
 a70:	fef42223          	sw	a5,-28(s0)
 a74:	fe442783          	lw	a5,-28(s0)
 a78:	fc043703          	ld	a4,-64(s0)
 a7c:	97ba                	add	a5,a5,a4
 a7e:	0007c783          	lbu	a5,0(a5)
 a82:	dc0795e3          	bnez	a5,84c <vprintf+0x20>
    }
  }
}
 a86:	0001                	nop
 a88:	0001                	nop
 a8a:	60a6                	ld	ra,72(sp)
 a8c:	6406                	ld	s0,64(sp)
 a8e:	6161                	addi	sp,sp,80
 a90:	8082                	ret

0000000000000a92 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a92:	7159                	addi	sp,sp,-112
 a94:	fc06                	sd	ra,56(sp)
 a96:	f822                	sd	s0,48(sp)
 a98:	0080                	addi	s0,sp,64
 a9a:	fcb43823          	sd	a1,-48(s0)
 a9e:	e010                	sd	a2,0(s0)
 aa0:	e414                	sd	a3,8(s0)
 aa2:	e818                	sd	a4,16(s0)
 aa4:	ec1c                	sd	a5,24(s0)
 aa6:	03043023          	sd	a6,32(s0)
 aaa:	03143423          	sd	a7,40(s0)
 aae:	87aa                	mv	a5,a0
 ab0:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 ab4:	03040793          	addi	a5,s0,48
 ab8:	fcf43423          	sd	a5,-56(s0)
 abc:	fc843783          	ld	a5,-56(s0)
 ac0:	fd078793          	addi	a5,a5,-48
 ac4:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 ac8:	fe843703          	ld	a4,-24(s0)
 acc:	fdc42783          	lw	a5,-36(s0)
 ad0:	863a                	mv	a2,a4
 ad2:	fd043583          	ld	a1,-48(s0)
 ad6:	853e                	mv	a0,a5
 ad8:	00000097          	auipc	ra,0x0
 adc:	d54080e7          	jalr	-684(ra) # 82c <vprintf>
}
 ae0:	0001                	nop
 ae2:	70e2                	ld	ra,56(sp)
 ae4:	7442                	ld	s0,48(sp)
 ae6:	6165                	addi	sp,sp,112
 ae8:	8082                	ret

0000000000000aea <printf>:

void
printf(const char *fmt, ...)
{
 aea:	7159                	addi	sp,sp,-112
 aec:	f406                	sd	ra,40(sp)
 aee:	f022                	sd	s0,32(sp)
 af0:	1800                	addi	s0,sp,48
 af2:	fca43c23          	sd	a0,-40(s0)
 af6:	e40c                	sd	a1,8(s0)
 af8:	e810                	sd	a2,16(s0)
 afa:	ec14                	sd	a3,24(s0)
 afc:	f018                	sd	a4,32(s0)
 afe:	f41c                	sd	a5,40(s0)
 b00:	03043823          	sd	a6,48(s0)
 b04:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b08:	04040793          	addi	a5,s0,64
 b0c:	fcf43823          	sd	a5,-48(s0)
 b10:	fd043783          	ld	a5,-48(s0)
 b14:	fc878793          	addi	a5,a5,-56
 b18:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 b1c:	fe843783          	ld	a5,-24(s0)
 b20:	863e                	mv	a2,a5
 b22:	fd843583          	ld	a1,-40(s0)
 b26:	4505                	li	a0,1
 b28:	00000097          	auipc	ra,0x0
 b2c:	d04080e7          	jalr	-764(ra) # 82c <vprintf>
}
 b30:	0001                	nop
 b32:	70a2                	ld	ra,40(sp)
 b34:	7402                	ld	s0,32(sp)
 b36:	6165                	addi	sp,sp,112
 b38:	8082                	ret

0000000000000b3a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b3a:	7179                	addi	sp,sp,-48
 b3c:	f422                	sd	s0,40(sp)
 b3e:	1800                	addi	s0,sp,48
 b40:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b44:	fd843783          	ld	a5,-40(s0)
 b48:	17c1                	addi	a5,a5,-16
 b4a:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b4e:	00000797          	auipc	a5,0x0
 b52:	59a78793          	addi	a5,a5,1434 # 10e8 <freep>
 b56:	639c                	ld	a5,0(a5)
 b58:	fef43423          	sd	a5,-24(s0)
 b5c:	a815                	j	b90 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b5e:	fe843783          	ld	a5,-24(s0)
 b62:	639c                	ld	a5,0(a5)
 b64:	fe843703          	ld	a4,-24(s0)
 b68:	00f76f63          	bltu	a4,a5,b86 <free+0x4c>
 b6c:	fe043703          	ld	a4,-32(s0)
 b70:	fe843783          	ld	a5,-24(s0)
 b74:	02e7eb63          	bltu	a5,a4,baa <free+0x70>
 b78:	fe843783          	ld	a5,-24(s0)
 b7c:	639c                	ld	a5,0(a5)
 b7e:	fe043703          	ld	a4,-32(s0)
 b82:	02f76463          	bltu	a4,a5,baa <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b86:	fe843783          	ld	a5,-24(s0)
 b8a:	639c                	ld	a5,0(a5)
 b8c:	fef43423          	sd	a5,-24(s0)
 b90:	fe043703          	ld	a4,-32(s0)
 b94:	fe843783          	ld	a5,-24(s0)
 b98:	fce7f3e3          	bgeu	a5,a4,b5e <free+0x24>
 b9c:	fe843783          	ld	a5,-24(s0)
 ba0:	639c                	ld	a5,0(a5)
 ba2:	fe043703          	ld	a4,-32(s0)
 ba6:	faf77ce3          	bgeu	a4,a5,b5e <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 baa:	fe043783          	ld	a5,-32(s0)
 bae:	479c                	lw	a5,8(a5)
 bb0:	1782                	slli	a5,a5,0x20
 bb2:	9381                	srli	a5,a5,0x20
 bb4:	0792                	slli	a5,a5,0x4
 bb6:	fe043703          	ld	a4,-32(s0)
 bba:	973e                	add	a4,a4,a5
 bbc:	fe843783          	ld	a5,-24(s0)
 bc0:	639c                	ld	a5,0(a5)
 bc2:	02f71763          	bne	a4,a5,bf0 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 bc6:	fe043783          	ld	a5,-32(s0)
 bca:	4798                	lw	a4,8(a5)
 bcc:	fe843783          	ld	a5,-24(s0)
 bd0:	639c                	ld	a5,0(a5)
 bd2:	479c                	lw	a5,8(a5)
 bd4:	9fb9                	addw	a5,a5,a4
 bd6:	0007871b          	sext.w	a4,a5
 bda:	fe043783          	ld	a5,-32(s0)
 bde:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 be0:	fe843783          	ld	a5,-24(s0)
 be4:	639c                	ld	a5,0(a5)
 be6:	6398                	ld	a4,0(a5)
 be8:	fe043783          	ld	a5,-32(s0)
 bec:	e398                	sd	a4,0(a5)
 bee:	a039                	j	bfc <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 bf0:	fe843783          	ld	a5,-24(s0)
 bf4:	6398                	ld	a4,0(a5)
 bf6:	fe043783          	ld	a5,-32(s0)
 bfa:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 bfc:	fe843783          	ld	a5,-24(s0)
 c00:	479c                	lw	a5,8(a5)
 c02:	1782                	slli	a5,a5,0x20
 c04:	9381                	srli	a5,a5,0x20
 c06:	0792                	slli	a5,a5,0x4
 c08:	fe843703          	ld	a4,-24(s0)
 c0c:	97ba                	add	a5,a5,a4
 c0e:	fe043703          	ld	a4,-32(s0)
 c12:	02f71563          	bne	a4,a5,c3c <free+0x102>
    p->s.size += bp->s.size;
 c16:	fe843783          	ld	a5,-24(s0)
 c1a:	4798                	lw	a4,8(a5)
 c1c:	fe043783          	ld	a5,-32(s0)
 c20:	479c                	lw	a5,8(a5)
 c22:	9fb9                	addw	a5,a5,a4
 c24:	0007871b          	sext.w	a4,a5
 c28:	fe843783          	ld	a5,-24(s0)
 c2c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c2e:	fe043783          	ld	a5,-32(s0)
 c32:	6398                	ld	a4,0(a5)
 c34:	fe843783          	ld	a5,-24(s0)
 c38:	e398                	sd	a4,0(a5)
 c3a:	a031                	j	c46 <free+0x10c>
  } else
    p->s.ptr = bp;
 c3c:	fe843783          	ld	a5,-24(s0)
 c40:	fe043703          	ld	a4,-32(s0)
 c44:	e398                	sd	a4,0(a5)
  freep = p;
 c46:	00000797          	auipc	a5,0x0
 c4a:	4a278793          	addi	a5,a5,1186 # 10e8 <freep>
 c4e:	fe843703          	ld	a4,-24(s0)
 c52:	e398                	sd	a4,0(a5)
}
 c54:	0001                	nop
 c56:	7422                	ld	s0,40(sp)
 c58:	6145                	addi	sp,sp,48
 c5a:	8082                	ret

0000000000000c5c <morecore>:

static Header*
morecore(uint nu)
{
 c5c:	7179                	addi	sp,sp,-48
 c5e:	f406                	sd	ra,40(sp)
 c60:	f022                	sd	s0,32(sp)
 c62:	1800                	addi	s0,sp,48
 c64:	87aa                	mv	a5,a0
 c66:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 c6a:	fdc42783          	lw	a5,-36(s0)
 c6e:	0007871b          	sext.w	a4,a5
 c72:	6785                	lui	a5,0x1
 c74:	00f77563          	bgeu	a4,a5,c7e <morecore+0x22>
    nu = 4096;
 c78:	6785                	lui	a5,0x1
 c7a:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c7e:	fdc42783          	lw	a5,-36(s0)
 c82:	0047979b          	slliw	a5,a5,0x4
 c86:	2781                	sext.w	a5,a5
 c88:	2781                	sext.w	a5,a5
 c8a:	853e                	mv	a0,a5
 c8c:	00000097          	auipc	ra,0x0
 c90:	9ae080e7          	jalr	-1618(ra) # 63a <sbrk>
 c94:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c98:	fe843703          	ld	a4,-24(s0)
 c9c:	57fd                	li	a5,-1
 c9e:	00f71463          	bne	a4,a5,ca6 <morecore+0x4a>
    return 0;
 ca2:	4781                	li	a5,0
 ca4:	a03d                	j	cd2 <morecore+0x76>
  hp = (Header*)p;
 ca6:	fe843783          	ld	a5,-24(s0)
 caa:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 cae:	fe043783          	ld	a5,-32(s0)
 cb2:	fdc42703          	lw	a4,-36(s0)
 cb6:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 cb8:	fe043783          	ld	a5,-32(s0)
 cbc:	07c1                	addi	a5,a5,16
 cbe:	853e                	mv	a0,a5
 cc0:	00000097          	auipc	ra,0x0
 cc4:	e7a080e7          	jalr	-390(ra) # b3a <free>
  return freep;
 cc8:	00000797          	auipc	a5,0x0
 ccc:	42078793          	addi	a5,a5,1056 # 10e8 <freep>
 cd0:	639c                	ld	a5,0(a5)
}
 cd2:	853e                	mv	a0,a5
 cd4:	70a2                	ld	ra,40(sp)
 cd6:	7402                	ld	s0,32(sp)
 cd8:	6145                	addi	sp,sp,48
 cda:	8082                	ret

0000000000000cdc <malloc>:

void*
malloc(uint nbytes)
{
 cdc:	7139                	addi	sp,sp,-64
 cde:	fc06                	sd	ra,56(sp)
 ce0:	f822                	sd	s0,48(sp)
 ce2:	0080                	addi	s0,sp,64
 ce4:	87aa                	mv	a5,a0
 ce6:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 cea:	fcc46783          	lwu	a5,-52(s0)
 cee:	07bd                	addi	a5,a5,15
 cf0:	8391                	srli	a5,a5,0x4
 cf2:	2781                	sext.w	a5,a5
 cf4:	2785                	addiw	a5,a5,1
 cf6:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 cfa:	00000797          	auipc	a5,0x0
 cfe:	3ee78793          	addi	a5,a5,1006 # 10e8 <freep>
 d02:	639c                	ld	a5,0(a5)
 d04:	fef43023          	sd	a5,-32(s0)
 d08:	fe043783          	ld	a5,-32(s0)
 d0c:	ef95                	bnez	a5,d48 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 d0e:	00000797          	auipc	a5,0x0
 d12:	3ca78793          	addi	a5,a5,970 # 10d8 <base>
 d16:	fef43023          	sd	a5,-32(s0)
 d1a:	00000797          	auipc	a5,0x0
 d1e:	3ce78793          	addi	a5,a5,974 # 10e8 <freep>
 d22:	fe043703          	ld	a4,-32(s0)
 d26:	e398                	sd	a4,0(a5)
 d28:	00000797          	auipc	a5,0x0
 d2c:	3c078793          	addi	a5,a5,960 # 10e8 <freep>
 d30:	6398                	ld	a4,0(a5)
 d32:	00000797          	auipc	a5,0x0
 d36:	3a678793          	addi	a5,a5,934 # 10d8 <base>
 d3a:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 d3c:	00000797          	auipc	a5,0x0
 d40:	39c78793          	addi	a5,a5,924 # 10d8 <base>
 d44:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d48:	fe043783          	ld	a5,-32(s0)
 d4c:	639c                	ld	a5,0(a5)
 d4e:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d52:	fe843783          	ld	a5,-24(s0)
 d56:	4798                	lw	a4,8(a5)
 d58:	fdc42783          	lw	a5,-36(s0)
 d5c:	2781                	sext.w	a5,a5
 d5e:	06f76763          	bltu	a4,a5,dcc <malloc+0xf0>
      if(p->s.size == nunits)
 d62:	fe843783          	ld	a5,-24(s0)
 d66:	4798                	lw	a4,8(a5)
 d68:	fdc42783          	lw	a5,-36(s0)
 d6c:	2781                	sext.w	a5,a5
 d6e:	00e79963          	bne	a5,a4,d80 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d72:	fe843783          	ld	a5,-24(s0)
 d76:	6398                	ld	a4,0(a5)
 d78:	fe043783          	ld	a5,-32(s0)
 d7c:	e398                	sd	a4,0(a5)
 d7e:	a825                	j	db6 <malloc+0xda>
      else {
        p->s.size -= nunits;
 d80:	fe843783          	ld	a5,-24(s0)
 d84:	479c                	lw	a5,8(a5)
 d86:	fdc42703          	lw	a4,-36(s0)
 d8a:	9f99                	subw	a5,a5,a4
 d8c:	0007871b          	sext.w	a4,a5
 d90:	fe843783          	ld	a5,-24(s0)
 d94:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d96:	fe843783          	ld	a5,-24(s0)
 d9a:	479c                	lw	a5,8(a5)
 d9c:	1782                	slli	a5,a5,0x20
 d9e:	9381                	srli	a5,a5,0x20
 da0:	0792                	slli	a5,a5,0x4
 da2:	fe843703          	ld	a4,-24(s0)
 da6:	97ba                	add	a5,a5,a4
 da8:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 dac:	fe843783          	ld	a5,-24(s0)
 db0:	fdc42703          	lw	a4,-36(s0)
 db4:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 db6:	00000797          	auipc	a5,0x0
 dba:	33278793          	addi	a5,a5,818 # 10e8 <freep>
 dbe:	fe043703          	ld	a4,-32(s0)
 dc2:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 dc4:	fe843783          	ld	a5,-24(s0)
 dc8:	07c1                	addi	a5,a5,16
 dca:	a091                	j	e0e <malloc+0x132>
    }
    if(p == freep)
 dcc:	00000797          	auipc	a5,0x0
 dd0:	31c78793          	addi	a5,a5,796 # 10e8 <freep>
 dd4:	639c                	ld	a5,0(a5)
 dd6:	fe843703          	ld	a4,-24(s0)
 dda:	02f71063          	bne	a4,a5,dfa <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 dde:	fdc42783          	lw	a5,-36(s0)
 de2:	853e                	mv	a0,a5
 de4:	00000097          	auipc	ra,0x0
 de8:	e78080e7          	jalr	-392(ra) # c5c <morecore>
 dec:	fea43423          	sd	a0,-24(s0)
 df0:	fe843783          	ld	a5,-24(s0)
 df4:	e399                	bnez	a5,dfa <malloc+0x11e>
        return 0;
 df6:	4781                	li	a5,0
 df8:	a819                	j	e0e <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dfa:	fe843783          	ld	a5,-24(s0)
 dfe:	fef43023          	sd	a5,-32(s0)
 e02:	fe843783          	ld	a5,-24(s0)
 e06:	639c                	ld	a5,0(a5)
 e08:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 e0c:	b799                	j	d52 <malloc+0x76>
  }
}
 e0e:	853e                	mv	a0,a5
 e10:	70e2                	ld	ra,56(sp)
 e12:	7442                	ld	s0,48(sp)
 e14:	6121                	addi	sp,sp,64
 e16:	8082                	ret

0000000000000e18 <thread_create>:
typedef uint cont_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
 e18:	7179                	addi	sp,sp,-48
 e1a:	f406                	sd	ra,40(sp)
 e1c:	f022                	sd	s0,32(sp)
 e1e:	1800                	addi	s0,sp,48
 e20:	fca43c23          	sd	a0,-40(s0)
 e24:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
 e28:	6505                	lui	a0,0x1
 e2a:	00000097          	auipc	ra,0x0
 e2e:	eb2080e7          	jalr	-334(ra) # cdc <malloc>
 e32:	fea43423          	sd	a0,-24(s0)
 e36:	fe843783          	ld	a5,-24(s0)
 e3a:	e38d                	bnez	a5,e5c <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
 e3c:	00000517          	auipc	a0,0x0
 e40:	22450513          	addi	a0,a0,548 # 1060 <cv_init+0x98>
 e44:	00000097          	auipc	ra,0x0
 e48:	ca6080e7          	jalr	-858(ra) # aea <printf>
        free(stack);
 e4c:	fe843503          	ld	a0,-24(s0)
 e50:	00000097          	auipc	ra,0x0
 e54:	cea080e7          	jalr	-790(ra) # b3a <free>
        return -1;
 e58:	57fd                	li	a5,-1
 e5a:	a099                	j	ea0 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
 e5c:	fe843783          	ld	a5,-24(s0)
 e60:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
 e64:	fe043703          	ld	a4,-32(s0)
 e68:	6785                	lui	a5,0x1
 e6a:	17fd                	addi	a5,a5,-1
 e6c:	8ff9                	and	a5,a5,a4
 e6e:	cf91                	beqz	a5,e8a <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
 e70:	fe043703          	ld	a4,-32(s0)
 e74:	6785                	lui	a5,0x1
 e76:	17fd                	addi	a5,a5,-1
 e78:	8ff9                	and	a5,a5,a4
 e7a:	6705                	lui	a4,0x1
 e7c:	40f707b3          	sub	a5,a4,a5
 e80:	fe843703          	ld	a4,-24(s0)
 e84:	97ba                	add	a5,a5,a4
 e86:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
 e8a:	fe843603          	ld	a2,-24(s0)
 e8e:	fd043583          	ld	a1,-48(s0)
 e92:	fd843503          	ld	a0,-40(s0)
 e96:	fffff097          	auipc	ra,0xfffff
 e9a:	7bc080e7          	jalr	1980(ra) # 652 <clone>
 e9e:	87aa                	mv	a5,a0
}
 ea0:	853e                	mv	a0,a5
 ea2:	70a2                	ld	ra,40(sp)
 ea4:	7402                	ld	s0,32(sp)
 ea6:	6145                	addi	sp,sp,48
 ea8:	8082                	ret

0000000000000eaa <thread_join>:


int thread_join()
{
 eaa:	1101                	addi	sp,sp,-32
 eac:	ec06                	sd	ra,24(sp)
 eae:	e822                	sd	s0,16(sp)
 eb0:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
 eb2:	fe040793          	addi	a5,s0,-32
 eb6:	853e                	mv	a0,a5
 eb8:	fffff097          	auipc	ra,0xfffff
 ebc:	7a2080e7          	jalr	1954(ra) # 65a <join>
 ec0:	87aa                	mv	a5,a0
 ec2:	fef42623          	sw	a5,-20(s0)
 ec6:	fec42783          	lw	a5,-20(s0)
 eca:	0007871b          	sext.w	a4,a5
 ece:	57fd                	li	a5,-1
 ed0:	00f70963          	beq	a4,a5,ee2 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
 ed4:	fe043783          	ld	a5,-32(s0)
 ed8:	853e                	mv	a0,a5
 eda:	00000097          	auipc	ra,0x0
 ede:	c60080e7          	jalr	-928(ra) # b3a <free>
    } 

    return child_tid;
 ee2:	fec42783          	lw	a5,-20(s0)
}
 ee6:	853e                	mv	a0,a5
 ee8:	60e2                	ld	ra,24(sp)
 eea:	6442                	ld	s0,16(sp)
 eec:	6105                	addi	sp,sp,32
 eee:	8082                	ret

0000000000000ef0 <lock_acquire>:


void lock_acquire (lock_t *lock){
 ef0:	1101                	addi	sp,sp,-32
 ef2:	ec22                	sd	s0,24(sp)
 ef4:	1000                	addi	s0,sp,32
 ef6:	fea43423          	sd	a0,-24(s0)
    while( __sync_lock_test_and_set(lock, 1)!=0){
 efa:	0001                	nop
 efc:	fe843783          	ld	a5,-24(s0)
 f00:	4705                	li	a4,1
 f02:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
 f06:	0007079b          	sext.w	a5,a4
 f0a:	fbed                	bnez	a5,efc <lock_acquire+0xc>

    ;
    }
     __sync_synchronize();
 f0c:	0ff0000f          	fence
        

}
 f10:	0001                	nop
 f12:	6462                	ld	s0,24(sp)
 f14:	6105                	addi	sp,sp,32
 f16:	8082                	ret

0000000000000f18 <lock_release>:

void lock_release (lock_t *lock){
 f18:	1101                	addi	sp,sp,-32
 f1a:	ec22                	sd	s0,24(sp)
 f1c:	1000                	addi	s0,sp,32
 f1e:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
 f22:	0ff0000f          	fence
    __sync_lock_release(lock);
 f26:	fe843783          	ld	a5,-24(s0)
 f2a:	0f50000f          	fence	iorw,ow
 f2e:	0807a02f          	amoswap.w	zero,zero,(a5)
   
}
 f32:	0001                	nop
 f34:	6462                	ld	s0,24(sp)
 f36:	6105                	addi	sp,sp,32
 f38:	8082                	ret

0000000000000f3a <lock_init>:

void lock_init (lock_t *lock){
 f3a:	1101                	addi	sp,sp,-32
 f3c:	ec22                	sd	s0,24(sp)
 f3e:	1000                	addi	s0,sp,32
 f40:	fea43423          	sd	a0,-24(s0)
    lock = 0;
 f44:	fe043423          	sd	zero,-24(s0)
    
}
 f48:	0001                	nop
 f4a:	6462                	ld	s0,24(sp)
 f4c:	6105                	addi	sp,sp,32
 f4e:	8082                	ret

0000000000000f50 <cv_wait>:


void cv_wait (cont_t *cv, lock_t *lock){
 f50:	1101                	addi	sp,sp,-32
 f52:	ec06                	sd	ra,24(sp)
 f54:	e822                	sd	s0,16(sp)
 f56:	1000                	addi	s0,sp,32
 f58:	fea43423          	sd	a0,-24(s0)
 f5c:	feb43023          	sd	a1,-32(s0)
    while( __sync_lock_test_and_set(cv, 0)!=1){
 f60:	a015                	j	f84 <cv_wait+0x34>
        lock_release(lock);
 f62:	fe043503          	ld	a0,-32(s0)
 f66:	00000097          	auipc	ra,0x0
 f6a:	fb2080e7          	jalr	-78(ra) # f18 <lock_release>
        sleep(1);
 f6e:	4505                	li	a0,1
 f70:	fffff097          	auipc	ra,0xfffff
 f74:	6d2080e7          	jalr	1746(ra) # 642 <sleep>
        lock_acquire(lock);
 f78:	fe043503          	ld	a0,-32(s0)
 f7c:	00000097          	auipc	ra,0x0
 f80:	f74080e7          	jalr	-140(ra) # ef0 <lock_acquire>
    while( __sync_lock_test_and_set(cv, 0)!=1){
 f84:	fe843783          	ld	a5,-24(s0)
 f88:	4701                	li	a4,0
 f8a:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
 f8e:	0007079b          	sext.w	a5,a4
 f92:	873e                	mv	a4,a5
 f94:	4785                	li	a5,1
 f96:	fcf716e3          	bne	a4,a5,f62 <cv_wait+0x12>
    }

     __sync_synchronize();
 f9a:	0ff0000f          	fence

}
 f9e:	0001                	nop
 fa0:	60e2                	ld	ra,24(sp)
 fa2:	6442                	ld	s0,16(sp)
 fa4:	6105                	addi	sp,sp,32
 fa6:	8082                	ret

0000000000000fa8 <cv_signal>:


void cv_signal (cont_t *cv){
 fa8:	1101                	addi	sp,sp,-32
 faa:	ec22                	sd	s0,24(sp)
 fac:	1000                	addi	s0,sp,32
 fae:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
 fb2:	0ff0000f          	fence
     __sync_lock_test_and_set(cv, 1);
 fb6:	fe843783          	ld	a5,-24(s0)
 fba:	4705                	li	a4,1
 fbc:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)

}
 fc0:	0001                	nop
 fc2:	6462                	ld	s0,24(sp)
 fc4:	6105                	addi	sp,sp,32
 fc6:	8082                	ret

0000000000000fc8 <cv_init>:


void cv_init (cont_t *cv){
 fc8:	1101                	addi	sp,sp,-32
 fca:	ec22                	sd	s0,24(sp)
 fcc:	1000                	addi	s0,sp,32
 fce:	fea43423          	sd	a0,-24(s0)
    cv = 0;
 fd2:	fe043423          	sd	zero,-24(s0)
 fd6:	0001                	nop
 fd8:	6462                	ld	s0,24(sp)
 fda:	6105                	addi	sp,sp,32
 fdc:	8082                	ret
