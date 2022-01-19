
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
   a:	87aa                	mv	a5,a0
   c:	fcb43023          	sd	a1,-64(s0)
  10:	fcf42623          	sw	a5,-52(s0)
  int i;

  for(i = 1; i < argc; i++){
  14:	4785                	li	a5,1
  16:	fcf42e23          	sw	a5,-36(s0)
  1a:	a051                	j	9e <main+0x9e>
    write(1, argv[i], strlen(argv[i]));
  1c:	fdc42783          	lw	a5,-36(s0)
  20:	078e                	slli	a5,a5,0x3
  22:	fc043703          	ld	a4,-64(s0)
  26:	97ba                	add	a5,a5,a4
  28:	6384                	ld	s1,0(a5)
  2a:	fdc42783          	lw	a5,-36(s0)
  2e:	078e                	slli	a5,a5,0x3
  30:	fc043703          	ld	a4,-64(s0)
  34:	97ba                	add	a5,a5,a4
  36:	639c                	ld	a5,0(a5)
  38:	853e                	mv	a0,a5
  3a:	00000097          	auipc	ra,0x0
  3e:	130080e7          	jalr	304(ra) # 16a <strlen>
  42:	87aa                	mv	a5,a0
  44:	2781                	sext.w	a5,a5
  46:	2781                	sext.w	a5,a5
  48:	863e                	mv	a2,a5
  4a:	85a6                	mv	a1,s1
  4c:	4505                	li	a0,1
  4e:	00000097          	auipc	ra,0x0
  52:	51e080e7          	jalr	1310(ra) # 56c <write>
    if(i + 1 < argc){
  56:	fdc42783          	lw	a5,-36(s0)
  5a:	2785                	addiw	a5,a5,1
  5c:	0007871b          	sext.w	a4,a5
  60:	fcc42783          	lw	a5,-52(s0)
  64:	2781                	sext.w	a5,a5
  66:	00f75d63          	bge	a4,a5,80 <main+0x80>
      write(1, " ", 1);
  6a:	4605                	li	a2,1
  6c:	00001597          	auipc	a1,0x1
  70:	f0c58593          	addi	a1,a1,-244 # f78 <cv_init+0x16>
  74:	4505                	li	a0,1
  76:	00000097          	auipc	ra,0x0
  7a:	4f6080e7          	jalr	1270(ra) # 56c <write>
  7e:	a819                	j	94 <main+0x94>
    } else {
      write(1, "\n", 1);
  80:	4605                	li	a2,1
  82:	00001597          	auipc	a1,0x1
  86:	efe58593          	addi	a1,a1,-258 # f80 <cv_init+0x1e>
  8a:	4505                	li	a0,1
  8c:	00000097          	auipc	ra,0x0
  90:	4e0080e7          	jalr	1248(ra) # 56c <write>
  for(i = 1; i < argc; i++){
  94:	fdc42783          	lw	a5,-36(s0)
  98:	2785                	addiw	a5,a5,1
  9a:	fcf42e23          	sw	a5,-36(s0)
  9e:	fdc42783          	lw	a5,-36(s0)
  a2:	873e                	mv	a4,a5
  a4:	fcc42783          	lw	a5,-52(s0)
  a8:	2701                	sext.w	a4,a4
  aa:	2781                	sext.w	a5,a5
  ac:	f6f748e3          	blt	a4,a5,1c <main+0x1c>
    }
  }
  exit(0);
  b0:	4501                	li	a0,0
  b2:	00000097          	auipc	ra,0x0
  b6:	49a080e7          	jalr	1178(ra) # 54c <exit>

00000000000000ba <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  ba:	7179                	addi	sp,sp,-48
  bc:	f422                	sd	s0,40(sp)
  be:	1800                	addi	s0,sp,48
  c0:	fca43c23          	sd	a0,-40(s0)
  c4:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  c8:	fd843783          	ld	a5,-40(s0)
  cc:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  d0:	0001                	nop
  d2:	fd043703          	ld	a4,-48(s0)
  d6:	00170793          	addi	a5,a4,1
  da:	fcf43823          	sd	a5,-48(s0)
  de:	fd843783          	ld	a5,-40(s0)
  e2:	00178693          	addi	a3,a5,1
  e6:	fcd43c23          	sd	a3,-40(s0)
  ea:	00074703          	lbu	a4,0(a4)
  ee:	00e78023          	sb	a4,0(a5)
  f2:	0007c783          	lbu	a5,0(a5)
  f6:	fff1                	bnez	a5,d2 <strcpy+0x18>
    ;
  return os;
  f8:	fe843783          	ld	a5,-24(s0)
}
  fc:	853e                	mv	a0,a5
  fe:	7422                	ld	s0,40(sp)
 100:	6145                	addi	sp,sp,48
 102:	8082                	ret

0000000000000104 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 104:	1101                	addi	sp,sp,-32
 106:	ec22                	sd	s0,24(sp)
 108:	1000                	addi	s0,sp,32
 10a:	fea43423          	sd	a0,-24(s0)
 10e:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 112:	a819                	j	128 <strcmp+0x24>
    p++, q++;
 114:	fe843783          	ld	a5,-24(s0)
 118:	0785                	addi	a5,a5,1
 11a:	fef43423          	sd	a5,-24(s0)
 11e:	fe043783          	ld	a5,-32(s0)
 122:	0785                	addi	a5,a5,1
 124:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 128:	fe843783          	ld	a5,-24(s0)
 12c:	0007c783          	lbu	a5,0(a5)
 130:	cb99                	beqz	a5,146 <strcmp+0x42>
 132:	fe843783          	ld	a5,-24(s0)
 136:	0007c703          	lbu	a4,0(a5)
 13a:	fe043783          	ld	a5,-32(s0)
 13e:	0007c783          	lbu	a5,0(a5)
 142:	fcf709e3          	beq	a4,a5,114 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 146:	fe843783          	ld	a5,-24(s0)
 14a:	0007c783          	lbu	a5,0(a5)
 14e:	0007871b          	sext.w	a4,a5
 152:	fe043783          	ld	a5,-32(s0)
 156:	0007c783          	lbu	a5,0(a5)
 15a:	2781                	sext.w	a5,a5
 15c:	40f707bb          	subw	a5,a4,a5
 160:	2781                	sext.w	a5,a5
}
 162:	853e                	mv	a0,a5
 164:	6462                	ld	s0,24(sp)
 166:	6105                	addi	sp,sp,32
 168:	8082                	ret

000000000000016a <strlen>:

uint
strlen(const char *s)
{
 16a:	7179                	addi	sp,sp,-48
 16c:	f422                	sd	s0,40(sp)
 16e:	1800                	addi	s0,sp,48
 170:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 174:	fe042623          	sw	zero,-20(s0)
 178:	a031                	j	184 <strlen+0x1a>
 17a:	fec42783          	lw	a5,-20(s0)
 17e:	2785                	addiw	a5,a5,1
 180:	fef42623          	sw	a5,-20(s0)
 184:	fec42783          	lw	a5,-20(s0)
 188:	fd843703          	ld	a4,-40(s0)
 18c:	97ba                	add	a5,a5,a4
 18e:	0007c783          	lbu	a5,0(a5)
 192:	f7e5                	bnez	a5,17a <strlen+0x10>
    ;
  return n;
 194:	fec42783          	lw	a5,-20(s0)
}
 198:	853e                	mv	a0,a5
 19a:	7422                	ld	s0,40(sp)
 19c:	6145                	addi	sp,sp,48
 19e:	8082                	ret

00000000000001a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a0:	7179                	addi	sp,sp,-48
 1a2:	f422                	sd	s0,40(sp)
 1a4:	1800                	addi	s0,sp,48
 1a6:	fca43c23          	sd	a0,-40(s0)
 1aa:	87ae                	mv	a5,a1
 1ac:	8732                	mv	a4,a2
 1ae:	fcf42a23          	sw	a5,-44(s0)
 1b2:	87ba                	mv	a5,a4
 1b4:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1b8:	fd843783          	ld	a5,-40(s0)
 1bc:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1c0:	fe042623          	sw	zero,-20(s0)
 1c4:	a00d                	j	1e6 <memset+0x46>
    cdst[i] = c;
 1c6:	fec42783          	lw	a5,-20(s0)
 1ca:	fe043703          	ld	a4,-32(s0)
 1ce:	97ba                	add	a5,a5,a4
 1d0:	fd442703          	lw	a4,-44(s0)
 1d4:	0ff77713          	zext.b	a4,a4
 1d8:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1dc:	fec42783          	lw	a5,-20(s0)
 1e0:	2785                	addiw	a5,a5,1
 1e2:	fef42623          	sw	a5,-20(s0)
 1e6:	fec42703          	lw	a4,-20(s0)
 1ea:	fd042783          	lw	a5,-48(s0)
 1ee:	2781                	sext.w	a5,a5
 1f0:	fcf76be3          	bltu	a4,a5,1c6 <memset+0x26>
  }
  return dst;
 1f4:	fd843783          	ld	a5,-40(s0)
}
 1f8:	853e                	mv	a0,a5
 1fa:	7422                	ld	s0,40(sp)
 1fc:	6145                	addi	sp,sp,48
 1fe:	8082                	ret

0000000000000200 <strchr>:

char*
strchr(const char *s, char c)
{
 200:	1101                	addi	sp,sp,-32
 202:	ec22                	sd	s0,24(sp)
 204:	1000                	addi	s0,sp,32
 206:	fea43423          	sd	a0,-24(s0)
 20a:	87ae                	mv	a5,a1
 20c:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 210:	a01d                	j	236 <strchr+0x36>
    if(*s == c)
 212:	fe843783          	ld	a5,-24(s0)
 216:	0007c703          	lbu	a4,0(a5)
 21a:	fe744783          	lbu	a5,-25(s0)
 21e:	0ff7f793          	zext.b	a5,a5
 222:	00e79563          	bne	a5,a4,22c <strchr+0x2c>
      return (char*)s;
 226:	fe843783          	ld	a5,-24(s0)
 22a:	a821                	j	242 <strchr+0x42>
  for(; *s; s++)
 22c:	fe843783          	ld	a5,-24(s0)
 230:	0785                	addi	a5,a5,1
 232:	fef43423          	sd	a5,-24(s0)
 236:	fe843783          	ld	a5,-24(s0)
 23a:	0007c783          	lbu	a5,0(a5)
 23e:	fbf1                	bnez	a5,212 <strchr+0x12>
  return 0;
 240:	4781                	li	a5,0
}
 242:	853e                	mv	a0,a5
 244:	6462                	ld	s0,24(sp)
 246:	6105                	addi	sp,sp,32
 248:	8082                	ret

000000000000024a <gets>:

char*
gets(char *buf, int max)
{
 24a:	7179                	addi	sp,sp,-48
 24c:	f406                	sd	ra,40(sp)
 24e:	f022                	sd	s0,32(sp)
 250:	1800                	addi	s0,sp,48
 252:	fca43c23          	sd	a0,-40(s0)
 256:	87ae                	mv	a5,a1
 258:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 25c:	fe042623          	sw	zero,-20(s0)
 260:	a8a1                	j	2b8 <gets+0x6e>
    cc = read(0, &c, 1);
 262:	fe740793          	addi	a5,s0,-25
 266:	4605                	li	a2,1
 268:	85be                	mv	a1,a5
 26a:	4501                	li	a0,0
 26c:	00000097          	auipc	ra,0x0
 270:	2f8080e7          	jalr	760(ra) # 564 <read>
 274:	87aa                	mv	a5,a0
 276:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 27a:	fe842783          	lw	a5,-24(s0)
 27e:	2781                	sext.w	a5,a5
 280:	04f05763          	blez	a5,2ce <gets+0x84>
      break;
    buf[i++] = c;
 284:	fec42783          	lw	a5,-20(s0)
 288:	0017871b          	addiw	a4,a5,1
 28c:	fee42623          	sw	a4,-20(s0)
 290:	873e                	mv	a4,a5
 292:	fd843783          	ld	a5,-40(s0)
 296:	97ba                	add	a5,a5,a4
 298:	fe744703          	lbu	a4,-25(s0)
 29c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 2a0:	fe744783          	lbu	a5,-25(s0)
 2a4:	873e                	mv	a4,a5
 2a6:	47a9                	li	a5,10
 2a8:	02f70463          	beq	a4,a5,2d0 <gets+0x86>
 2ac:	fe744783          	lbu	a5,-25(s0)
 2b0:	873e                	mv	a4,a5
 2b2:	47b5                	li	a5,13
 2b4:	00f70e63          	beq	a4,a5,2d0 <gets+0x86>
  for(i=0; i+1 < max; ){
 2b8:	fec42783          	lw	a5,-20(s0)
 2bc:	2785                	addiw	a5,a5,1
 2be:	0007871b          	sext.w	a4,a5
 2c2:	fd442783          	lw	a5,-44(s0)
 2c6:	2781                	sext.w	a5,a5
 2c8:	f8f74de3          	blt	a4,a5,262 <gets+0x18>
 2cc:	a011                	j	2d0 <gets+0x86>
      break;
 2ce:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2d0:	fec42783          	lw	a5,-20(s0)
 2d4:	fd843703          	ld	a4,-40(s0)
 2d8:	97ba                	add	a5,a5,a4
 2da:	00078023          	sb	zero,0(a5)
  return buf;
 2de:	fd843783          	ld	a5,-40(s0)
}
 2e2:	853e                	mv	a0,a5
 2e4:	70a2                	ld	ra,40(sp)
 2e6:	7402                	ld	s0,32(sp)
 2e8:	6145                	addi	sp,sp,48
 2ea:	8082                	ret

00000000000002ec <stat>:

int
stat(const char *n, struct stat *st)
{
 2ec:	7179                	addi	sp,sp,-48
 2ee:	f406                	sd	ra,40(sp)
 2f0:	f022                	sd	s0,32(sp)
 2f2:	1800                	addi	s0,sp,48
 2f4:	fca43c23          	sd	a0,-40(s0)
 2f8:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2fc:	4581                	li	a1,0
 2fe:	fd843503          	ld	a0,-40(s0)
 302:	00000097          	auipc	ra,0x0
 306:	28a080e7          	jalr	650(ra) # 58c <open>
 30a:	87aa                	mv	a5,a0
 30c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 310:	fec42783          	lw	a5,-20(s0)
 314:	2781                	sext.w	a5,a5
 316:	0007d463          	bgez	a5,31e <stat+0x32>
    return -1;
 31a:	57fd                	li	a5,-1
 31c:	a035                	j	348 <stat+0x5c>
  r = fstat(fd, st);
 31e:	fec42783          	lw	a5,-20(s0)
 322:	fd043583          	ld	a1,-48(s0)
 326:	853e                	mv	a0,a5
 328:	00000097          	auipc	ra,0x0
 32c:	27c080e7          	jalr	636(ra) # 5a4 <fstat>
 330:	87aa                	mv	a5,a0
 332:	fef42423          	sw	a5,-24(s0)
  close(fd);
 336:	fec42783          	lw	a5,-20(s0)
 33a:	853e                	mv	a0,a5
 33c:	00000097          	auipc	ra,0x0
 340:	238080e7          	jalr	568(ra) # 574 <close>
  return r;
 344:	fe842783          	lw	a5,-24(s0)
}
 348:	853e                	mv	a0,a5
 34a:	70a2                	ld	ra,40(sp)
 34c:	7402                	ld	s0,32(sp)
 34e:	6145                	addi	sp,sp,48
 350:	8082                	ret

0000000000000352 <atoi>:

int
atoi(const char *s)
{
 352:	7179                	addi	sp,sp,-48
 354:	f422                	sd	s0,40(sp)
 356:	1800                	addi	s0,sp,48
 358:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 35c:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 360:	a81d                	j	396 <atoi+0x44>
    n = n*10 + *s++ - '0';
 362:	fec42783          	lw	a5,-20(s0)
 366:	873e                	mv	a4,a5
 368:	87ba                	mv	a5,a4
 36a:	0027979b          	slliw	a5,a5,0x2
 36e:	9fb9                	addw	a5,a5,a4
 370:	0017979b          	slliw	a5,a5,0x1
 374:	0007871b          	sext.w	a4,a5
 378:	fd843783          	ld	a5,-40(s0)
 37c:	00178693          	addi	a3,a5,1
 380:	fcd43c23          	sd	a3,-40(s0)
 384:	0007c783          	lbu	a5,0(a5)
 388:	2781                	sext.w	a5,a5
 38a:	9fb9                	addw	a5,a5,a4
 38c:	2781                	sext.w	a5,a5
 38e:	fd07879b          	addiw	a5,a5,-48
 392:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 396:	fd843783          	ld	a5,-40(s0)
 39a:	0007c783          	lbu	a5,0(a5)
 39e:	873e                	mv	a4,a5
 3a0:	02f00793          	li	a5,47
 3a4:	00e7fb63          	bgeu	a5,a4,3ba <atoi+0x68>
 3a8:	fd843783          	ld	a5,-40(s0)
 3ac:	0007c783          	lbu	a5,0(a5)
 3b0:	873e                	mv	a4,a5
 3b2:	03900793          	li	a5,57
 3b6:	fae7f6e3          	bgeu	a5,a4,362 <atoi+0x10>
  return n;
 3ba:	fec42783          	lw	a5,-20(s0)
}
 3be:	853e                	mv	a0,a5
 3c0:	7422                	ld	s0,40(sp)
 3c2:	6145                	addi	sp,sp,48
 3c4:	8082                	ret

00000000000003c6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3c6:	7139                	addi	sp,sp,-64
 3c8:	fc22                	sd	s0,56(sp)
 3ca:	0080                	addi	s0,sp,64
 3cc:	fca43c23          	sd	a0,-40(s0)
 3d0:	fcb43823          	sd	a1,-48(s0)
 3d4:	87b2                	mv	a5,a2
 3d6:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3da:	fd843783          	ld	a5,-40(s0)
 3de:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3e2:	fd043783          	ld	a5,-48(s0)
 3e6:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3ea:	fe043703          	ld	a4,-32(s0)
 3ee:	fe843783          	ld	a5,-24(s0)
 3f2:	02e7fc63          	bgeu	a5,a4,42a <memmove+0x64>
    while(n-- > 0)
 3f6:	a00d                	j	418 <memmove+0x52>
      *dst++ = *src++;
 3f8:	fe043703          	ld	a4,-32(s0)
 3fc:	00170793          	addi	a5,a4,1
 400:	fef43023          	sd	a5,-32(s0)
 404:	fe843783          	ld	a5,-24(s0)
 408:	00178693          	addi	a3,a5,1
 40c:	fed43423          	sd	a3,-24(s0)
 410:	00074703          	lbu	a4,0(a4)
 414:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 418:	fcc42783          	lw	a5,-52(s0)
 41c:	fff7871b          	addiw	a4,a5,-1
 420:	fce42623          	sw	a4,-52(s0)
 424:	fcf04ae3          	bgtz	a5,3f8 <memmove+0x32>
 428:	a891                	j	47c <memmove+0xb6>
  } else {
    dst += n;
 42a:	fcc42783          	lw	a5,-52(s0)
 42e:	fe843703          	ld	a4,-24(s0)
 432:	97ba                	add	a5,a5,a4
 434:	fef43423          	sd	a5,-24(s0)
    src += n;
 438:	fcc42783          	lw	a5,-52(s0)
 43c:	fe043703          	ld	a4,-32(s0)
 440:	97ba                	add	a5,a5,a4
 442:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 446:	a01d                	j	46c <memmove+0xa6>
      *--dst = *--src;
 448:	fe043783          	ld	a5,-32(s0)
 44c:	17fd                	addi	a5,a5,-1
 44e:	fef43023          	sd	a5,-32(s0)
 452:	fe843783          	ld	a5,-24(s0)
 456:	17fd                	addi	a5,a5,-1
 458:	fef43423          	sd	a5,-24(s0)
 45c:	fe043783          	ld	a5,-32(s0)
 460:	0007c703          	lbu	a4,0(a5)
 464:	fe843783          	ld	a5,-24(s0)
 468:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 46c:	fcc42783          	lw	a5,-52(s0)
 470:	fff7871b          	addiw	a4,a5,-1
 474:	fce42623          	sw	a4,-52(s0)
 478:	fcf048e3          	bgtz	a5,448 <memmove+0x82>
  }
  return vdst;
 47c:	fd843783          	ld	a5,-40(s0)
}
 480:	853e                	mv	a0,a5
 482:	7462                	ld	s0,56(sp)
 484:	6121                	addi	sp,sp,64
 486:	8082                	ret

0000000000000488 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 488:	7139                	addi	sp,sp,-64
 48a:	fc22                	sd	s0,56(sp)
 48c:	0080                	addi	s0,sp,64
 48e:	fca43c23          	sd	a0,-40(s0)
 492:	fcb43823          	sd	a1,-48(s0)
 496:	87b2                	mv	a5,a2
 498:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 49c:	fd843783          	ld	a5,-40(s0)
 4a0:	fef43423          	sd	a5,-24(s0)
 4a4:	fd043783          	ld	a5,-48(s0)
 4a8:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4ac:	a0a1                	j	4f4 <memcmp+0x6c>
    if (*p1 != *p2) {
 4ae:	fe843783          	ld	a5,-24(s0)
 4b2:	0007c703          	lbu	a4,0(a5)
 4b6:	fe043783          	ld	a5,-32(s0)
 4ba:	0007c783          	lbu	a5,0(a5)
 4be:	02f70163          	beq	a4,a5,4e0 <memcmp+0x58>
      return *p1 - *p2;
 4c2:	fe843783          	ld	a5,-24(s0)
 4c6:	0007c783          	lbu	a5,0(a5)
 4ca:	0007871b          	sext.w	a4,a5
 4ce:	fe043783          	ld	a5,-32(s0)
 4d2:	0007c783          	lbu	a5,0(a5)
 4d6:	2781                	sext.w	a5,a5
 4d8:	40f707bb          	subw	a5,a4,a5
 4dc:	2781                	sext.w	a5,a5
 4de:	a01d                	j	504 <memcmp+0x7c>
    }
    p1++;
 4e0:	fe843783          	ld	a5,-24(s0)
 4e4:	0785                	addi	a5,a5,1
 4e6:	fef43423          	sd	a5,-24(s0)
    p2++;
 4ea:	fe043783          	ld	a5,-32(s0)
 4ee:	0785                	addi	a5,a5,1
 4f0:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4f4:	fcc42783          	lw	a5,-52(s0)
 4f8:	fff7871b          	addiw	a4,a5,-1
 4fc:	fce42623          	sw	a4,-52(s0)
 500:	f7dd                	bnez	a5,4ae <memcmp+0x26>
  }
  return 0;
 502:	4781                	li	a5,0
}
 504:	853e                	mv	a0,a5
 506:	7462                	ld	s0,56(sp)
 508:	6121                	addi	sp,sp,64
 50a:	8082                	ret

000000000000050c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 50c:	7179                	addi	sp,sp,-48
 50e:	f406                	sd	ra,40(sp)
 510:	f022                	sd	s0,32(sp)
 512:	1800                	addi	s0,sp,48
 514:	fea43423          	sd	a0,-24(s0)
 518:	feb43023          	sd	a1,-32(s0)
 51c:	87b2                	mv	a5,a2
 51e:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 522:	fdc42783          	lw	a5,-36(s0)
 526:	863e                	mv	a2,a5
 528:	fe043583          	ld	a1,-32(s0)
 52c:	fe843503          	ld	a0,-24(s0)
 530:	00000097          	auipc	ra,0x0
 534:	e96080e7          	jalr	-362(ra) # 3c6 <memmove>
 538:	87aa                	mv	a5,a0
}
 53a:	853e                	mv	a0,a5
 53c:	70a2                	ld	ra,40(sp)
 53e:	7402                	ld	s0,32(sp)
 540:	6145                	addi	sp,sp,48
 542:	8082                	ret

0000000000000544 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 544:	4885                	li	a7,1
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <exit>:
.global exit
exit:
 li a7, SYS_exit
 54c:	4889                	li	a7,2
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <wait>:
.global wait
wait:
 li a7, SYS_wait
 554:	488d                	li	a7,3
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 55c:	4891                	li	a7,4
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <read>:
.global read
read:
 li a7, SYS_read
 564:	4895                	li	a7,5
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <write>:
.global write
write:
 li a7, SYS_write
 56c:	48c1                	li	a7,16
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <close>:
.global close
close:
 li a7, SYS_close
 574:	48d5                	li	a7,21
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <kill>:
.global kill
kill:
 li a7, SYS_kill
 57c:	4899                	li	a7,6
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <exec>:
.global exec
exec:
 li a7, SYS_exec
 584:	489d                	li	a7,7
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <open>:
.global open
open:
 li a7, SYS_open
 58c:	48bd                	li	a7,15
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 594:	48c5                	li	a7,17
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 59c:	48c9                	li	a7,18
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5a4:	48a1                	li	a7,8
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <link>:
.global link
link:
 li a7, SYS_link
 5ac:	48cd                	li	a7,19
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5b4:	48d1                	li	a7,20
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5bc:	48a5                	li	a7,9
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5c4:	48a9                	li	a7,10
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5cc:	48ad                	li	a7,11
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5d4:	48b1                	li	a7,12
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5dc:	48b5                	li	a7,13
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5e4:	48b9                	li	a7,14
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <clone>:
.global clone
clone:
 li a7, SYS_clone
 5ec:	48d9                	li	a7,22
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <join>:
.global join
join:
 li a7, SYS_join
 5f4:	48dd                	li	a7,23
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5fc:	1101                	addi	sp,sp,-32
 5fe:	ec06                	sd	ra,24(sp)
 600:	e822                	sd	s0,16(sp)
 602:	1000                	addi	s0,sp,32
 604:	87aa                	mv	a5,a0
 606:	872e                	mv	a4,a1
 608:	fef42623          	sw	a5,-20(s0)
 60c:	87ba                	mv	a5,a4
 60e:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 612:	feb40713          	addi	a4,s0,-21
 616:	fec42783          	lw	a5,-20(s0)
 61a:	4605                	li	a2,1
 61c:	85ba                	mv	a1,a4
 61e:	853e                	mv	a0,a5
 620:	00000097          	auipc	ra,0x0
 624:	f4c080e7          	jalr	-180(ra) # 56c <write>
}
 628:	0001                	nop
 62a:	60e2                	ld	ra,24(sp)
 62c:	6442                	ld	s0,16(sp)
 62e:	6105                	addi	sp,sp,32
 630:	8082                	ret

0000000000000632 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 632:	7139                	addi	sp,sp,-64
 634:	fc06                	sd	ra,56(sp)
 636:	f822                	sd	s0,48(sp)
 638:	0080                	addi	s0,sp,64
 63a:	87aa                	mv	a5,a0
 63c:	8736                	mv	a4,a3
 63e:	fcf42623          	sw	a5,-52(s0)
 642:	87ae                	mv	a5,a1
 644:	fcf42423          	sw	a5,-56(s0)
 648:	87b2                	mv	a5,a2
 64a:	fcf42223          	sw	a5,-60(s0)
 64e:	87ba                	mv	a5,a4
 650:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 654:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 658:	fc042783          	lw	a5,-64(s0)
 65c:	2781                	sext.w	a5,a5
 65e:	c38d                	beqz	a5,680 <printint+0x4e>
 660:	fc842783          	lw	a5,-56(s0)
 664:	2781                	sext.w	a5,a5
 666:	0007dd63          	bgez	a5,680 <printint+0x4e>
    neg = 1;
 66a:	4785                	li	a5,1
 66c:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 670:	fc842783          	lw	a5,-56(s0)
 674:	40f007bb          	negw	a5,a5
 678:	2781                	sext.w	a5,a5
 67a:	fef42223          	sw	a5,-28(s0)
 67e:	a029                	j	688 <printint+0x56>
  } else {
    x = xx;
 680:	fc842783          	lw	a5,-56(s0)
 684:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 688:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 68c:	fc442783          	lw	a5,-60(s0)
 690:	fe442703          	lw	a4,-28(s0)
 694:	02f777bb          	remuw	a5,a4,a5
 698:	0007861b          	sext.w	a2,a5
 69c:	fec42783          	lw	a5,-20(s0)
 6a0:	0017871b          	addiw	a4,a5,1
 6a4:	fee42623          	sw	a4,-20(s0)
 6a8:	00001697          	auipc	a3,0x1
 6ac:	93868693          	addi	a3,a3,-1736 # fe0 <digits>
 6b0:	02061713          	slli	a4,a2,0x20
 6b4:	9301                	srli	a4,a4,0x20
 6b6:	9736                	add	a4,a4,a3
 6b8:	00074703          	lbu	a4,0(a4)
 6bc:	17c1                	addi	a5,a5,-16
 6be:	97a2                	add	a5,a5,s0
 6c0:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 6c4:	fc442783          	lw	a5,-60(s0)
 6c8:	fe442703          	lw	a4,-28(s0)
 6cc:	02f757bb          	divuw	a5,a4,a5
 6d0:	fef42223          	sw	a5,-28(s0)
 6d4:	fe442783          	lw	a5,-28(s0)
 6d8:	2781                	sext.w	a5,a5
 6da:	fbcd                	bnez	a5,68c <printint+0x5a>
  if(neg)
 6dc:	fe842783          	lw	a5,-24(s0)
 6e0:	2781                	sext.w	a5,a5
 6e2:	cf85                	beqz	a5,71a <printint+0xe8>
    buf[i++] = '-';
 6e4:	fec42783          	lw	a5,-20(s0)
 6e8:	0017871b          	addiw	a4,a5,1
 6ec:	fee42623          	sw	a4,-20(s0)
 6f0:	17c1                	addi	a5,a5,-16
 6f2:	97a2                	add	a5,a5,s0
 6f4:	02d00713          	li	a4,45
 6f8:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6fc:	a839                	j	71a <printint+0xe8>
    putc(fd, buf[i]);
 6fe:	fec42783          	lw	a5,-20(s0)
 702:	17c1                	addi	a5,a5,-16
 704:	97a2                	add	a5,a5,s0
 706:	fe07c703          	lbu	a4,-32(a5)
 70a:	fcc42783          	lw	a5,-52(s0)
 70e:	85ba                	mv	a1,a4
 710:	853e                	mv	a0,a5
 712:	00000097          	auipc	ra,0x0
 716:	eea080e7          	jalr	-278(ra) # 5fc <putc>
  while(--i >= 0)
 71a:	fec42783          	lw	a5,-20(s0)
 71e:	37fd                	addiw	a5,a5,-1
 720:	fef42623          	sw	a5,-20(s0)
 724:	fec42783          	lw	a5,-20(s0)
 728:	2781                	sext.w	a5,a5
 72a:	fc07dae3          	bgez	a5,6fe <printint+0xcc>
}
 72e:	0001                	nop
 730:	0001                	nop
 732:	70e2                	ld	ra,56(sp)
 734:	7442                	ld	s0,48(sp)
 736:	6121                	addi	sp,sp,64
 738:	8082                	ret

000000000000073a <printptr>:

static void
printptr(int fd, uint64 x) {
 73a:	7179                	addi	sp,sp,-48
 73c:	f406                	sd	ra,40(sp)
 73e:	f022                	sd	s0,32(sp)
 740:	1800                	addi	s0,sp,48
 742:	87aa                	mv	a5,a0
 744:	fcb43823          	sd	a1,-48(s0)
 748:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 74c:	fdc42783          	lw	a5,-36(s0)
 750:	03000593          	li	a1,48
 754:	853e                	mv	a0,a5
 756:	00000097          	auipc	ra,0x0
 75a:	ea6080e7          	jalr	-346(ra) # 5fc <putc>
  putc(fd, 'x');
 75e:	fdc42783          	lw	a5,-36(s0)
 762:	07800593          	li	a1,120
 766:	853e                	mv	a0,a5
 768:	00000097          	auipc	ra,0x0
 76c:	e94080e7          	jalr	-364(ra) # 5fc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 770:	fe042623          	sw	zero,-20(s0)
 774:	a82d                	j	7ae <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 776:	fd043783          	ld	a5,-48(s0)
 77a:	93f1                	srli	a5,a5,0x3c
 77c:	00001717          	auipc	a4,0x1
 780:	86470713          	addi	a4,a4,-1948 # fe0 <digits>
 784:	97ba                	add	a5,a5,a4
 786:	0007c703          	lbu	a4,0(a5)
 78a:	fdc42783          	lw	a5,-36(s0)
 78e:	85ba                	mv	a1,a4
 790:	853e                	mv	a0,a5
 792:	00000097          	auipc	ra,0x0
 796:	e6a080e7          	jalr	-406(ra) # 5fc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 79a:	fec42783          	lw	a5,-20(s0)
 79e:	2785                	addiw	a5,a5,1
 7a0:	fef42623          	sw	a5,-20(s0)
 7a4:	fd043783          	ld	a5,-48(s0)
 7a8:	0792                	slli	a5,a5,0x4
 7aa:	fcf43823          	sd	a5,-48(s0)
 7ae:	fec42783          	lw	a5,-20(s0)
 7b2:	873e                	mv	a4,a5
 7b4:	47bd                	li	a5,15
 7b6:	fce7f0e3          	bgeu	a5,a4,776 <printptr+0x3c>
}
 7ba:	0001                	nop
 7bc:	0001                	nop
 7be:	70a2                	ld	ra,40(sp)
 7c0:	7402                	ld	s0,32(sp)
 7c2:	6145                	addi	sp,sp,48
 7c4:	8082                	ret

00000000000007c6 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7c6:	715d                	addi	sp,sp,-80
 7c8:	e486                	sd	ra,72(sp)
 7ca:	e0a2                	sd	s0,64(sp)
 7cc:	0880                	addi	s0,sp,80
 7ce:	87aa                	mv	a5,a0
 7d0:	fcb43023          	sd	a1,-64(s0)
 7d4:	fac43c23          	sd	a2,-72(s0)
 7d8:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 7dc:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7e0:	fe042223          	sw	zero,-28(s0)
 7e4:	a42d                	j	a0e <vprintf+0x248>
    c = fmt[i] & 0xff;
 7e6:	fe442783          	lw	a5,-28(s0)
 7ea:	fc043703          	ld	a4,-64(s0)
 7ee:	97ba                	add	a5,a5,a4
 7f0:	0007c783          	lbu	a5,0(a5)
 7f4:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7f8:	fe042783          	lw	a5,-32(s0)
 7fc:	2781                	sext.w	a5,a5
 7fe:	eb9d                	bnez	a5,834 <vprintf+0x6e>
      if(c == '%'){
 800:	fdc42783          	lw	a5,-36(s0)
 804:	0007871b          	sext.w	a4,a5
 808:	02500793          	li	a5,37
 80c:	00f71763          	bne	a4,a5,81a <vprintf+0x54>
        state = '%';
 810:	02500793          	li	a5,37
 814:	fef42023          	sw	a5,-32(s0)
 818:	a2f5                	j	a04 <vprintf+0x23e>
      } else {
        putc(fd, c);
 81a:	fdc42783          	lw	a5,-36(s0)
 81e:	0ff7f713          	zext.b	a4,a5
 822:	fcc42783          	lw	a5,-52(s0)
 826:	85ba                	mv	a1,a4
 828:	853e                	mv	a0,a5
 82a:	00000097          	auipc	ra,0x0
 82e:	dd2080e7          	jalr	-558(ra) # 5fc <putc>
 832:	aac9                	j	a04 <vprintf+0x23e>
      }
    } else if(state == '%'){
 834:	fe042783          	lw	a5,-32(s0)
 838:	0007871b          	sext.w	a4,a5
 83c:	02500793          	li	a5,37
 840:	1cf71263          	bne	a4,a5,a04 <vprintf+0x23e>
      if(c == 'd'){
 844:	fdc42783          	lw	a5,-36(s0)
 848:	0007871b          	sext.w	a4,a5
 84c:	06400793          	li	a5,100
 850:	02f71463          	bne	a4,a5,878 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 854:	fb843783          	ld	a5,-72(s0)
 858:	00878713          	addi	a4,a5,8
 85c:	fae43c23          	sd	a4,-72(s0)
 860:	4398                	lw	a4,0(a5)
 862:	fcc42783          	lw	a5,-52(s0)
 866:	4685                	li	a3,1
 868:	4629                	li	a2,10
 86a:	85ba                	mv	a1,a4
 86c:	853e                	mv	a0,a5
 86e:	00000097          	auipc	ra,0x0
 872:	dc4080e7          	jalr	-572(ra) # 632 <printint>
 876:	a269                	j	a00 <vprintf+0x23a>
      } else if(c == 'l') {
 878:	fdc42783          	lw	a5,-36(s0)
 87c:	0007871b          	sext.w	a4,a5
 880:	06c00793          	li	a5,108
 884:	02f71663          	bne	a4,a5,8b0 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 888:	fb843783          	ld	a5,-72(s0)
 88c:	00878713          	addi	a4,a5,8
 890:	fae43c23          	sd	a4,-72(s0)
 894:	639c                	ld	a5,0(a5)
 896:	0007871b          	sext.w	a4,a5
 89a:	fcc42783          	lw	a5,-52(s0)
 89e:	4681                	li	a3,0
 8a0:	4629                	li	a2,10
 8a2:	85ba                	mv	a1,a4
 8a4:	853e                	mv	a0,a5
 8a6:	00000097          	auipc	ra,0x0
 8aa:	d8c080e7          	jalr	-628(ra) # 632 <printint>
 8ae:	aa89                	j	a00 <vprintf+0x23a>
      } else if(c == 'x') {
 8b0:	fdc42783          	lw	a5,-36(s0)
 8b4:	0007871b          	sext.w	a4,a5
 8b8:	07800793          	li	a5,120
 8bc:	02f71463          	bne	a4,a5,8e4 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 8c0:	fb843783          	ld	a5,-72(s0)
 8c4:	00878713          	addi	a4,a5,8
 8c8:	fae43c23          	sd	a4,-72(s0)
 8cc:	4398                	lw	a4,0(a5)
 8ce:	fcc42783          	lw	a5,-52(s0)
 8d2:	4681                	li	a3,0
 8d4:	4641                	li	a2,16
 8d6:	85ba                	mv	a1,a4
 8d8:	853e                	mv	a0,a5
 8da:	00000097          	auipc	ra,0x0
 8de:	d58080e7          	jalr	-680(ra) # 632 <printint>
 8e2:	aa39                	j	a00 <vprintf+0x23a>
      } else if(c == 'p') {
 8e4:	fdc42783          	lw	a5,-36(s0)
 8e8:	0007871b          	sext.w	a4,a5
 8ec:	07000793          	li	a5,112
 8f0:	02f71263          	bne	a4,a5,914 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8f4:	fb843783          	ld	a5,-72(s0)
 8f8:	00878713          	addi	a4,a5,8
 8fc:	fae43c23          	sd	a4,-72(s0)
 900:	6398                	ld	a4,0(a5)
 902:	fcc42783          	lw	a5,-52(s0)
 906:	85ba                	mv	a1,a4
 908:	853e                	mv	a0,a5
 90a:	00000097          	auipc	ra,0x0
 90e:	e30080e7          	jalr	-464(ra) # 73a <printptr>
 912:	a0fd                	j	a00 <vprintf+0x23a>
      } else if(c == 's'){
 914:	fdc42783          	lw	a5,-36(s0)
 918:	0007871b          	sext.w	a4,a5
 91c:	07300793          	li	a5,115
 920:	04f71c63          	bne	a4,a5,978 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 924:	fb843783          	ld	a5,-72(s0)
 928:	00878713          	addi	a4,a5,8
 92c:	fae43c23          	sd	a4,-72(s0)
 930:	639c                	ld	a5,0(a5)
 932:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 936:	fe843783          	ld	a5,-24(s0)
 93a:	eb8d                	bnez	a5,96c <vprintf+0x1a6>
          s = "(null)";
 93c:	00000797          	auipc	a5,0x0
 940:	64c78793          	addi	a5,a5,1612 # f88 <cv_init+0x26>
 944:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 948:	a015                	j	96c <vprintf+0x1a6>
          putc(fd, *s);
 94a:	fe843783          	ld	a5,-24(s0)
 94e:	0007c703          	lbu	a4,0(a5)
 952:	fcc42783          	lw	a5,-52(s0)
 956:	85ba                	mv	a1,a4
 958:	853e                	mv	a0,a5
 95a:	00000097          	auipc	ra,0x0
 95e:	ca2080e7          	jalr	-862(ra) # 5fc <putc>
          s++;
 962:	fe843783          	ld	a5,-24(s0)
 966:	0785                	addi	a5,a5,1
 968:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 96c:	fe843783          	ld	a5,-24(s0)
 970:	0007c783          	lbu	a5,0(a5)
 974:	fbf9                	bnez	a5,94a <vprintf+0x184>
 976:	a069                	j	a00 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 978:	fdc42783          	lw	a5,-36(s0)
 97c:	0007871b          	sext.w	a4,a5
 980:	06300793          	li	a5,99
 984:	02f71463          	bne	a4,a5,9ac <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 988:	fb843783          	ld	a5,-72(s0)
 98c:	00878713          	addi	a4,a5,8
 990:	fae43c23          	sd	a4,-72(s0)
 994:	439c                	lw	a5,0(a5)
 996:	0ff7f713          	zext.b	a4,a5
 99a:	fcc42783          	lw	a5,-52(s0)
 99e:	85ba                	mv	a1,a4
 9a0:	853e                	mv	a0,a5
 9a2:	00000097          	auipc	ra,0x0
 9a6:	c5a080e7          	jalr	-934(ra) # 5fc <putc>
 9aa:	a899                	j	a00 <vprintf+0x23a>
      } else if(c == '%'){
 9ac:	fdc42783          	lw	a5,-36(s0)
 9b0:	0007871b          	sext.w	a4,a5
 9b4:	02500793          	li	a5,37
 9b8:	00f71f63          	bne	a4,a5,9d6 <vprintf+0x210>
        putc(fd, c);
 9bc:	fdc42783          	lw	a5,-36(s0)
 9c0:	0ff7f713          	zext.b	a4,a5
 9c4:	fcc42783          	lw	a5,-52(s0)
 9c8:	85ba                	mv	a1,a4
 9ca:	853e                	mv	a0,a5
 9cc:	00000097          	auipc	ra,0x0
 9d0:	c30080e7          	jalr	-976(ra) # 5fc <putc>
 9d4:	a035                	j	a00 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9d6:	fcc42783          	lw	a5,-52(s0)
 9da:	02500593          	li	a1,37
 9de:	853e                	mv	a0,a5
 9e0:	00000097          	auipc	ra,0x0
 9e4:	c1c080e7          	jalr	-996(ra) # 5fc <putc>
        putc(fd, c);
 9e8:	fdc42783          	lw	a5,-36(s0)
 9ec:	0ff7f713          	zext.b	a4,a5
 9f0:	fcc42783          	lw	a5,-52(s0)
 9f4:	85ba                	mv	a1,a4
 9f6:	853e                	mv	a0,a5
 9f8:	00000097          	auipc	ra,0x0
 9fc:	c04080e7          	jalr	-1020(ra) # 5fc <putc>
      }
      state = 0;
 a00:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 a04:	fe442783          	lw	a5,-28(s0)
 a08:	2785                	addiw	a5,a5,1
 a0a:	fef42223          	sw	a5,-28(s0)
 a0e:	fe442783          	lw	a5,-28(s0)
 a12:	fc043703          	ld	a4,-64(s0)
 a16:	97ba                	add	a5,a5,a4
 a18:	0007c783          	lbu	a5,0(a5)
 a1c:	dc0795e3          	bnez	a5,7e6 <vprintf+0x20>
    }
  }
}
 a20:	0001                	nop
 a22:	0001                	nop
 a24:	60a6                	ld	ra,72(sp)
 a26:	6406                	ld	s0,64(sp)
 a28:	6161                	addi	sp,sp,80
 a2a:	8082                	ret

0000000000000a2c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a2c:	7159                	addi	sp,sp,-112
 a2e:	fc06                	sd	ra,56(sp)
 a30:	f822                	sd	s0,48(sp)
 a32:	0080                	addi	s0,sp,64
 a34:	fcb43823          	sd	a1,-48(s0)
 a38:	e010                	sd	a2,0(s0)
 a3a:	e414                	sd	a3,8(s0)
 a3c:	e818                	sd	a4,16(s0)
 a3e:	ec1c                	sd	a5,24(s0)
 a40:	03043023          	sd	a6,32(s0)
 a44:	03143423          	sd	a7,40(s0)
 a48:	87aa                	mv	a5,a0
 a4a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a4e:	03040793          	addi	a5,s0,48
 a52:	fcf43423          	sd	a5,-56(s0)
 a56:	fc843783          	ld	a5,-56(s0)
 a5a:	fd078793          	addi	a5,a5,-48
 a5e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a62:	fe843703          	ld	a4,-24(s0)
 a66:	fdc42783          	lw	a5,-36(s0)
 a6a:	863a                	mv	a2,a4
 a6c:	fd043583          	ld	a1,-48(s0)
 a70:	853e                	mv	a0,a5
 a72:	00000097          	auipc	ra,0x0
 a76:	d54080e7          	jalr	-684(ra) # 7c6 <vprintf>
}
 a7a:	0001                	nop
 a7c:	70e2                	ld	ra,56(sp)
 a7e:	7442                	ld	s0,48(sp)
 a80:	6165                	addi	sp,sp,112
 a82:	8082                	ret

0000000000000a84 <printf>:

void
printf(const char *fmt, ...)
{
 a84:	7159                	addi	sp,sp,-112
 a86:	f406                	sd	ra,40(sp)
 a88:	f022                	sd	s0,32(sp)
 a8a:	1800                	addi	s0,sp,48
 a8c:	fca43c23          	sd	a0,-40(s0)
 a90:	e40c                	sd	a1,8(s0)
 a92:	e810                	sd	a2,16(s0)
 a94:	ec14                	sd	a3,24(s0)
 a96:	f018                	sd	a4,32(s0)
 a98:	f41c                	sd	a5,40(s0)
 a9a:	03043823          	sd	a6,48(s0)
 a9e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 aa2:	04040793          	addi	a5,s0,64
 aa6:	fcf43823          	sd	a5,-48(s0)
 aaa:	fd043783          	ld	a5,-48(s0)
 aae:	fc878793          	addi	a5,a5,-56
 ab2:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 ab6:	fe843783          	ld	a5,-24(s0)
 aba:	863e                	mv	a2,a5
 abc:	fd843583          	ld	a1,-40(s0)
 ac0:	4505                	li	a0,1
 ac2:	00000097          	auipc	ra,0x0
 ac6:	d04080e7          	jalr	-764(ra) # 7c6 <vprintf>
}
 aca:	0001                	nop
 acc:	70a2                	ld	ra,40(sp)
 ace:	7402                	ld	s0,32(sp)
 ad0:	6165                	addi	sp,sp,112
 ad2:	8082                	ret

0000000000000ad4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ad4:	7179                	addi	sp,sp,-48
 ad6:	f422                	sd	s0,40(sp)
 ad8:	1800                	addi	s0,sp,48
 ada:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ade:	fd843783          	ld	a5,-40(s0)
 ae2:	17c1                	addi	a5,a5,-16
 ae4:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae8:	00000797          	auipc	a5,0x0
 aec:	52078793          	addi	a5,a5,1312 # 1008 <freep>
 af0:	639c                	ld	a5,0(a5)
 af2:	fef43423          	sd	a5,-24(s0)
 af6:	a815                	j	b2a <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 af8:	fe843783          	ld	a5,-24(s0)
 afc:	639c                	ld	a5,0(a5)
 afe:	fe843703          	ld	a4,-24(s0)
 b02:	00f76f63          	bltu	a4,a5,b20 <free+0x4c>
 b06:	fe043703          	ld	a4,-32(s0)
 b0a:	fe843783          	ld	a5,-24(s0)
 b0e:	02e7eb63          	bltu	a5,a4,b44 <free+0x70>
 b12:	fe843783          	ld	a5,-24(s0)
 b16:	639c                	ld	a5,0(a5)
 b18:	fe043703          	ld	a4,-32(s0)
 b1c:	02f76463          	bltu	a4,a5,b44 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b20:	fe843783          	ld	a5,-24(s0)
 b24:	639c                	ld	a5,0(a5)
 b26:	fef43423          	sd	a5,-24(s0)
 b2a:	fe043703          	ld	a4,-32(s0)
 b2e:	fe843783          	ld	a5,-24(s0)
 b32:	fce7f3e3          	bgeu	a5,a4,af8 <free+0x24>
 b36:	fe843783          	ld	a5,-24(s0)
 b3a:	639c                	ld	a5,0(a5)
 b3c:	fe043703          	ld	a4,-32(s0)
 b40:	faf77ce3          	bgeu	a4,a5,af8 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b44:	fe043783          	ld	a5,-32(s0)
 b48:	479c                	lw	a5,8(a5)
 b4a:	1782                	slli	a5,a5,0x20
 b4c:	9381                	srli	a5,a5,0x20
 b4e:	0792                	slli	a5,a5,0x4
 b50:	fe043703          	ld	a4,-32(s0)
 b54:	973e                	add	a4,a4,a5
 b56:	fe843783          	ld	a5,-24(s0)
 b5a:	639c                	ld	a5,0(a5)
 b5c:	02f71763          	bne	a4,a5,b8a <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b60:	fe043783          	ld	a5,-32(s0)
 b64:	4798                	lw	a4,8(a5)
 b66:	fe843783          	ld	a5,-24(s0)
 b6a:	639c                	ld	a5,0(a5)
 b6c:	479c                	lw	a5,8(a5)
 b6e:	9fb9                	addw	a5,a5,a4
 b70:	0007871b          	sext.w	a4,a5
 b74:	fe043783          	ld	a5,-32(s0)
 b78:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b7a:	fe843783          	ld	a5,-24(s0)
 b7e:	639c                	ld	a5,0(a5)
 b80:	6398                	ld	a4,0(a5)
 b82:	fe043783          	ld	a5,-32(s0)
 b86:	e398                	sd	a4,0(a5)
 b88:	a039                	j	b96 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b8a:	fe843783          	ld	a5,-24(s0)
 b8e:	6398                	ld	a4,0(a5)
 b90:	fe043783          	ld	a5,-32(s0)
 b94:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b96:	fe843783          	ld	a5,-24(s0)
 b9a:	479c                	lw	a5,8(a5)
 b9c:	1782                	slli	a5,a5,0x20
 b9e:	9381                	srli	a5,a5,0x20
 ba0:	0792                	slli	a5,a5,0x4
 ba2:	fe843703          	ld	a4,-24(s0)
 ba6:	97ba                	add	a5,a5,a4
 ba8:	fe043703          	ld	a4,-32(s0)
 bac:	02f71563          	bne	a4,a5,bd6 <free+0x102>
    p->s.size += bp->s.size;
 bb0:	fe843783          	ld	a5,-24(s0)
 bb4:	4798                	lw	a4,8(a5)
 bb6:	fe043783          	ld	a5,-32(s0)
 bba:	479c                	lw	a5,8(a5)
 bbc:	9fb9                	addw	a5,a5,a4
 bbe:	0007871b          	sext.w	a4,a5
 bc2:	fe843783          	ld	a5,-24(s0)
 bc6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bc8:	fe043783          	ld	a5,-32(s0)
 bcc:	6398                	ld	a4,0(a5)
 bce:	fe843783          	ld	a5,-24(s0)
 bd2:	e398                	sd	a4,0(a5)
 bd4:	a031                	j	be0 <free+0x10c>
  } else
    p->s.ptr = bp;
 bd6:	fe843783          	ld	a5,-24(s0)
 bda:	fe043703          	ld	a4,-32(s0)
 bde:	e398                	sd	a4,0(a5)
  freep = p;
 be0:	00000797          	auipc	a5,0x0
 be4:	42878793          	addi	a5,a5,1064 # 1008 <freep>
 be8:	fe843703          	ld	a4,-24(s0)
 bec:	e398                	sd	a4,0(a5)
}
 bee:	0001                	nop
 bf0:	7422                	ld	s0,40(sp)
 bf2:	6145                	addi	sp,sp,48
 bf4:	8082                	ret

0000000000000bf6 <morecore>:

static Header*
morecore(uint nu)
{
 bf6:	7179                	addi	sp,sp,-48
 bf8:	f406                	sd	ra,40(sp)
 bfa:	f022                	sd	s0,32(sp)
 bfc:	1800                	addi	s0,sp,48
 bfe:	87aa                	mv	a5,a0
 c00:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 c04:	fdc42783          	lw	a5,-36(s0)
 c08:	0007871b          	sext.w	a4,a5
 c0c:	6785                	lui	a5,0x1
 c0e:	00f77563          	bgeu	a4,a5,c18 <morecore+0x22>
    nu = 4096;
 c12:	6785                	lui	a5,0x1
 c14:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c18:	fdc42783          	lw	a5,-36(s0)
 c1c:	0047979b          	slliw	a5,a5,0x4
 c20:	2781                	sext.w	a5,a5
 c22:	2781                	sext.w	a5,a5
 c24:	853e                	mv	a0,a5
 c26:	00000097          	auipc	ra,0x0
 c2a:	9ae080e7          	jalr	-1618(ra) # 5d4 <sbrk>
 c2e:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c32:	fe843703          	ld	a4,-24(s0)
 c36:	57fd                	li	a5,-1
 c38:	00f71463          	bne	a4,a5,c40 <morecore+0x4a>
    return 0;
 c3c:	4781                	li	a5,0
 c3e:	a03d                	j	c6c <morecore+0x76>
  hp = (Header*)p;
 c40:	fe843783          	ld	a5,-24(s0)
 c44:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c48:	fe043783          	ld	a5,-32(s0)
 c4c:	fdc42703          	lw	a4,-36(s0)
 c50:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c52:	fe043783          	ld	a5,-32(s0)
 c56:	07c1                	addi	a5,a5,16
 c58:	853e                	mv	a0,a5
 c5a:	00000097          	auipc	ra,0x0
 c5e:	e7a080e7          	jalr	-390(ra) # ad4 <free>
  return freep;
 c62:	00000797          	auipc	a5,0x0
 c66:	3a678793          	addi	a5,a5,934 # 1008 <freep>
 c6a:	639c                	ld	a5,0(a5)
}
 c6c:	853e                	mv	a0,a5
 c6e:	70a2                	ld	ra,40(sp)
 c70:	7402                	ld	s0,32(sp)
 c72:	6145                	addi	sp,sp,48
 c74:	8082                	ret

0000000000000c76 <malloc>:

void*
malloc(uint nbytes)
{
 c76:	7139                	addi	sp,sp,-64
 c78:	fc06                	sd	ra,56(sp)
 c7a:	f822                	sd	s0,48(sp)
 c7c:	0080                	addi	s0,sp,64
 c7e:	87aa                	mv	a5,a0
 c80:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c84:	fcc46783          	lwu	a5,-52(s0)
 c88:	07bd                	addi	a5,a5,15
 c8a:	8391                	srli	a5,a5,0x4
 c8c:	2781                	sext.w	a5,a5
 c8e:	2785                	addiw	a5,a5,1
 c90:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c94:	00000797          	auipc	a5,0x0
 c98:	37478793          	addi	a5,a5,884 # 1008 <freep>
 c9c:	639c                	ld	a5,0(a5)
 c9e:	fef43023          	sd	a5,-32(s0)
 ca2:	fe043783          	ld	a5,-32(s0)
 ca6:	ef95                	bnez	a5,ce2 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 ca8:	00000797          	auipc	a5,0x0
 cac:	35078793          	addi	a5,a5,848 # ff8 <base>
 cb0:	fef43023          	sd	a5,-32(s0)
 cb4:	00000797          	auipc	a5,0x0
 cb8:	35478793          	addi	a5,a5,852 # 1008 <freep>
 cbc:	fe043703          	ld	a4,-32(s0)
 cc0:	e398                	sd	a4,0(a5)
 cc2:	00000797          	auipc	a5,0x0
 cc6:	34678793          	addi	a5,a5,838 # 1008 <freep>
 cca:	6398                	ld	a4,0(a5)
 ccc:	00000797          	auipc	a5,0x0
 cd0:	32c78793          	addi	a5,a5,812 # ff8 <base>
 cd4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 cd6:	00000797          	auipc	a5,0x0
 cda:	32278793          	addi	a5,a5,802 # ff8 <base>
 cde:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ce2:	fe043783          	ld	a5,-32(s0)
 ce6:	639c                	ld	a5,0(a5)
 ce8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 cec:	fe843783          	ld	a5,-24(s0)
 cf0:	4798                	lw	a4,8(a5)
 cf2:	fdc42783          	lw	a5,-36(s0)
 cf6:	2781                	sext.w	a5,a5
 cf8:	06f76763          	bltu	a4,a5,d66 <malloc+0xf0>
      if(p->s.size == nunits)
 cfc:	fe843783          	ld	a5,-24(s0)
 d00:	4798                	lw	a4,8(a5)
 d02:	fdc42783          	lw	a5,-36(s0)
 d06:	2781                	sext.w	a5,a5
 d08:	00e79963          	bne	a5,a4,d1a <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d0c:	fe843783          	ld	a5,-24(s0)
 d10:	6398                	ld	a4,0(a5)
 d12:	fe043783          	ld	a5,-32(s0)
 d16:	e398                	sd	a4,0(a5)
 d18:	a825                	j	d50 <malloc+0xda>
      else {
        p->s.size -= nunits;
 d1a:	fe843783          	ld	a5,-24(s0)
 d1e:	479c                	lw	a5,8(a5)
 d20:	fdc42703          	lw	a4,-36(s0)
 d24:	9f99                	subw	a5,a5,a4
 d26:	0007871b          	sext.w	a4,a5
 d2a:	fe843783          	ld	a5,-24(s0)
 d2e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d30:	fe843783          	ld	a5,-24(s0)
 d34:	479c                	lw	a5,8(a5)
 d36:	1782                	slli	a5,a5,0x20
 d38:	9381                	srli	a5,a5,0x20
 d3a:	0792                	slli	a5,a5,0x4
 d3c:	fe843703          	ld	a4,-24(s0)
 d40:	97ba                	add	a5,a5,a4
 d42:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d46:	fe843783          	ld	a5,-24(s0)
 d4a:	fdc42703          	lw	a4,-36(s0)
 d4e:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d50:	00000797          	auipc	a5,0x0
 d54:	2b878793          	addi	a5,a5,696 # 1008 <freep>
 d58:	fe043703          	ld	a4,-32(s0)
 d5c:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d5e:	fe843783          	ld	a5,-24(s0)
 d62:	07c1                	addi	a5,a5,16
 d64:	a091                	j	da8 <malloc+0x132>
    }
    if(p == freep)
 d66:	00000797          	auipc	a5,0x0
 d6a:	2a278793          	addi	a5,a5,674 # 1008 <freep>
 d6e:	639c                	ld	a5,0(a5)
 d70:	fe843703          	ld	a4,-24(s0)
 d74:	02f71063          	bne	a4,a5,d94 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 d78:	fdc42783          	lw	a5,-36(s0)
 d7c:	853e                	mv	a0,a5
 d7e:	00000097          	auipc	ra,0x0
 d82:	e78080e7          	jalr	-392(ra) # bf6 <morecore>
 d86:	fea43423          	sd	a0,-24(s0)
 d8a:	fe843783          	ld	a5,-24(s0)
 d8e:	e399                	bnez	a5,d94 <malloc+0x11e>
        return 0;
 d90:	4781                	li	a5,0
 d92:	a819                	j	da8 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d94:	fe843783          	ld	a5,-24(s0)
 d98:	fef43023          	sd	a5,-32(s0)
 d9c:	fe843783          	ld	a5,-24(s0)
 da0:	639c                	ld	a5,0(a5)
 da2:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 da6:	b799                	j	cec <malloc+0x76>
  }
}
 da8:	853e                	mv	a0,a5
 daa:	70e2                	ld	ra,56(sp)
 dac:	7442                	ld	s0,48(sp)
 dae:	6121                	addi	sp,sp,64
 db0:	8082                	ret

0000000000000db2 <thread_create>:
typedef uint cont_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
 db2:	7179                	addi	sp,sp,-48
 db4:	f406                	sd	ra,40(sp)
 db6:	f022                	sd	s0,32(sp)
 db8:	1800                	addi	s0,sp,48
 dba:	fca43c23          	sd	a0,-40(s0)
 dbe:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
 dc2:	6505                	lui	a0,0x1
 dc4:	00000097          	auipc	ra,0x0
 dc8:	eb2080e7          	jalr	-334(ra) # c76 <malloc>
 dcc:	fea43423          	sd	a0,-24(s0)
 dd0:	fe843783          	ld	a5,-24(s0)
 dd4:	e38d                	bnez	a5,df6 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
 dd6:	00000517          	auipc	a0,0x0
 dda:	1ba50513          	addi	a0,a0,442 # f90 <cv_init+0x2e>
 dde:	00000097          	auipc	ra,0x0
 de2:	ca6080e7          	jalr	-858(ra) # a84 <printf>
        free(stack);
 de6:	fe843503          	ld	a0,-24(s0)
 dea:	00000097          	auipc	ra,0x0
 dee:	cea080e7          	jalr	-790(ra) # ad4 <free>
        return -1;
 df2:	57fd                	li	a5,-1
 df4:	a099                	j	e3a <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
 df6:	fe843783          	ld	a5,-24(s0)
 dfa:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
 dfe:	fe043703          	ld	a4,-32(s0)
 e02:	6785                	lui	a5,0x1
 e04:	17fd                	addi	a5,a5,-1
 e06:	8ff9                	and	a5,a5,a4
 e08:	cf91                	beqz	a5,e24 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
 e0a:	fe043703          	ld	a4,-32(s0)
 e0e:	6785                	lui	a5,0x1
 e10:	17fd                	addi	a5,a5,-1
 e12:	8ff9                	and	a5,a5,a4
 e14:	6705                	lui	a4,0x1
 e16:	40f707b3          	sub	a5,a4,a5
 e1a:	fe843703          	ld	a4,-24(s0)
 e1e:	97ba                	add	a5,a5,a4
 e20:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
 e24:	fe843603          	ld	a2,-24(s0)
 e28:	fd043583          	ld	a1,-48(s0)
 e2c:	fd843503          	ld	a0,-40(s0)
 e30:	fffff097          	auipc	ra,0xfffff
 e34:	7bc080e7          	jalr	1980(ra) # 5ec <clone>
 e38:	87aa                	mv	a5,a0
}
 e3a:	853e                	mv	a0,a5
 e3c:	70a2                	ld	ra,40(sp)
 e3e:	7402                	ld	s0,32(sp)
 e40:	6145                	addi	sp,sp,48
 e42:	8082                	ret

0000000000000e44 <thread_join>:


int thread_join()
{
 e44:	1101                	addi	sp,sp,-32
 e46:	ec06                	sd	ra,24(sp)
 e48:	e822                	sd	s0,16(sp)
 e4a:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
 e4c:	fe040793          	addi	a5,s0,-32
 e50:	853e                	mv	a0,a5
 e52:	fffff097          	auipc	ra,0xfffff
 e56:	7a2080e7          	jalr	1954(ra) # 5f4 <join>
 e5a:	87aa                	mv	a5,a0
 e5c:	fef42623          	sw	a5,-20(s0)
 e60:	fec42783          	lw	a5,-20(s0)
 e64:	0007871b          	sext.w	a4,a5
 e68:	57fd                	li	a5,-1
 e6a:	00f70963          	beq	a4,a5,e7c <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
 e6e:	fe043783          	ld	a5,-32(s0)
 e72:	853e                	mv	a0,a5
 e74:	00000097          	auipc	ra,0x0
 e78:	c60080e7          	jalr	-928(ra) # ad4 <free>
    } 

    return child_tid;
 e7c:	fec42783          	lw	a5,-20(s0)
}
 e80:	853e                	mv	a0,a5
 e82:	60e2                	ld	ra,24(sp)
 e84:	6442                	ld	s0,16(sp)
 e86:	6105                	addi	sp,sp,32
 e88:	8082                	ret

0000000000000e8a <lock_acquire>:


void lock_acquire (lock_t *lock){
 e8a:	1101                	addi	sp,sp,-32
 e8c:	ec22                	sd	s0,24(sp)
 e8e:	1000                	addi	s0,sp,32
 e90:	fea43423          	sd	a0,-24(s0)
    while( __sync_lock_test_and_set(lock, 1)!=0){
 e94:	0001                	nop
 e96:	fe843783          	ld	a5,-24(s0)
 e9a:	4705                	li	a4,1
 e9c:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
 ea0:	0007079b          	sext.w	a5,a4
 ea4:	fbed                	bnez	a5,e96 <lock_acquire+0xc>

    ;
    }
     __sync_synchronize();
 ea6:	0ff0000f          	fence
        

}
 eaa:	0001                	nop
 eac:	6462                	ld	s0,24(sp)
 eae:	6105                	addi	sp,sp,32
 eb0:	8082                	ret

0000000000000eb2 <lock_release>:

void lock_release (lock_t *lock){
 eb2:	1101                	addi	sp,sp,-32
 eb4:	ec22                	sd	s0,24(sp)
 eb6:	1000                	addi	s0,sp,32
 eb8:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
 ebc:	0ff0000f          	fence
    __sync_lock_release(lock);
 ec0:	fe843783          	ld	a5,-24(s0)
 ec4:	0f50000f          	fence	iorw,ow
 ec8:	0807a02f          	amoswap.w	zero,zero,(a5)
   
}
 ecc:	0001                	nop
 ece:	6462                	ld	s0,24(sp)
 ed0:	6105                	addi	sp,sp,32
 ed2:	8082                	ret

0000000000000ed4 <lock_init>:

void lock_init (lock_t *lock){
 ed4:	1101                	addi	sp,sp,-32
 ed6:	ec22                	sd	s0,24(sp)
 ed8:	1000                	addi	s0,sp,32
 eda:	fea43423          	sd	a0,-24(s0)
    lock = 0;
 ede:	fe043423          	sd	zero,-24(s0)
    
}
 ee2:	0001                	nop
 ee4:	6462                	ld	s0,24(sp)
 ee6:	6105                	addi	sp,sp,32
 ee8:	8082                	ret

0000000000000eea <cv_wait>:


void cv_wait (cont_t *cv, lock_t *lock){
 eea:	1101                	addi	sp,sp,-32
 eec:	ec06                	sd	ra,24(sp)
 eee:	e822                	sd	s0,16(sp)
 ef0:	1000                	addi	s0,sp,32
 ef2:	fea43423          	sd	a0,-24(s0)
 ef6:	feb43023          	sd	a1,-32(s0)
    while( __sync_lock_test_and_set(cv, 0)!=1){
 efa:	a015                	j	f1e <cv_wait+0x34>
        lock_release(lock);
 efc:	fe043503          	ld	a0,-32(s0)
 f00:	00000097          	auipc	ra,0x0
 f04:	fb2080e7          	jalr	-78(ra) # eb2 <lock_release>
        sleep(1);
 f08:	4505                	li	a0,1
 f0a:	fffff097          	auipc	ra,0xfffff
 f0e:	6d2080e7          	jalr	1746(ra) # 5dc <sleep>
        lock_acquire(lock);
 f12:	fe043503          	ld	a0,-32(s0)
 f16:	00000097          	auipc	ra,0x0
 f1a:	f74080e7          	jalr	-140(ra) # e8a <lock_acquire>
    while( __sync_lock_test_and_set(cv, 0)!=1){
 f1e:	fe843783          	ld	a5,-24(s0)
 f22:	4701                	li	a4,0
 f24:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
 f28:	0007079b          	sext.w	a5,a4
 f2c:	873e                	mv	a4,a5
 f2e:	4785                	li	a5,1
 f30:	fcf716e3          	bne	a4,a5,efc <cv_wait+0x12>
    }

     __sync_synchronize();
 f34:	0ff0000f          	fence

}
 f38:	0001                	nop
 f3a:	60e2                	ld	ra,24(sp)
 f3c:	6442                	ld	s0,16(sp)
 f3e:	6105                	addi	sp,sp,32
 f40:	8082                	ret

0000000000000f42 <cv_signal>:


void cv_signal (cont_t *cv){
 f42:	1101                	addi	sp,sp,-32
 f44:	ec22                	sd	s0,24(sp)
 f46:	1000                	addi	s0,sp,32
 f48:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
 f4c:	0ff0000f          	fence
     __sync_lock_test_and_set(cv, 1);
 f50:	fe843783          	ld	a5,-24(s0)
 f54:	4705                	li	a4,1
 f56:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)

}
 f5a:	0001                	nop
 f5c:	6462                	ld	s0,24(sp)
 f5e:	6105                	addi	sp,sp,32
 f60:	8082                	ret

0000000000000f62 <cv_init>:


void cv_init (cont_t *cv){
 f62:	1101                	addi	sp,sp,-32
 f64:	ec22                	sd	s0,24(sp)
 f66:	1000                	addi	s0,sp,32
 f68:	fea43423          	sd	a0,-24(s0)
    cv = 0;
 f6c:	fe043423          	sd	zero,-24(s0)
 f70:	0001                	nop
 f72:	6462                	ld	s0,24(sp)
 f74:	6105                	addi	sp,sp,32
 f76:	8082                	ret
