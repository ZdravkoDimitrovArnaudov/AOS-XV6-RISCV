
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	4ac080e7          	jalr	1196(ra) # 4b4 <fork>
  10:	87aa                	mv	a5,a0
  12:	00f05763          	blez	a5,20 <main+0x20>
    sleep(5);  // Let child exit before parent.
  16:	4515                	li	a0,5
  18:	00000097          	auipc	ra,0x0
  1c:	534080e7          	jalr	1332(ra) # 54c <sleep>
  exit(0);
  20:	4501                	li	a0,0
  22:	00000097          	auipc	ra,0x0
  26:	49a080e7          	jalr	1178(ra) # 4bc <exit>

000000000000002a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  2a:	7179                	addi	sp,sp,-48
  2c:	f422                	sd	s0,40(sp)
  2e:	1800                	addi	s0,sp,48
  30:	fca43c23          	sd	a0,-40(s0)
  34:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  38:	fd843783          	ld	a5,-40(s0)
  3c:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  40:	0001                	nop
  42:	fd043703          	ld	a4,-48(s0)
  46:	00170793          	addi	a5,a4,1
  4a:	fcf43823          	sd	a5,-48(s0)
  4e:	fd843783          	ld	a5,-40(s0)
  52:	00178693          	addi	a3,a5,1
  56:	fcd43c23          	sd	a3,-40(s0)
  5a:	00074703          	lbu	a4,0(a4)
  5e:	00e78023          	sb	a4,0(a5)
  62:	0007c783          	lbu	a5,0(a5)
  66:	fff1                	bnez	a5,42 <strcpy+0x18>
    ;
  return os;
  68:	fe843783          	ld	a5,-24(s0)
}
  6c:	853e                	mv	a0,a5
  6e:	7422                	ld	s0,40(sp)
  70:	6145                	addi	sp,sp,48
  72:	8082                	ret

0000000000000074 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  74:	1101                	addi	sp,sp,-32
  76:	ec22                	sd	s0,24(sp)
  78:	1000                	addi	s0,sp,32
  7a:	fea43423          	sd	a0,-24(s0)
  7e:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
  82:	a819                	j	98 <strcmp+0x24>
    p++, q++;
  84:	fe843783          	ld	a5,-24(s0)
  88:	0785                	addi	a5,a5,1
  8a:	fef43423          	sd	a5,-24(s0)
  8e:	fe043783          	ld	a5,-32(s0)
  92:	0785                	addi	a5,a5,1
  94:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
  98:	fe843783          	ld	a5,-24(s0)
  9c:	0007c783          	lbu	a5,0(a5)
  a0:	cb99                	beqz	a5,b6 <strcmp+0x42>
  a2:	fe843783          	ld	a5,-24(s0)
  a6:	0007c703          	lbu	a4,0(a5)
  aa:	fe043783          	ld	a5,-32(s0)
  ae:	0007c783          	lbu	a5,0(a5)
  b2:	fcf709e3          	beq	a4,a5,84 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
  b6:	fe843783          	ld	a5,-24(s0)
  ba:	0007c783          	lbu	a5,0(a5)
  be:	0007871b          	sext.w	a4,a5
  c2:	fe043783          	ld	a5,-32(s0)
  c6:	0007c783          	lbu	a5,0(a5)
  ca:	2781                	sext.w	a5,a5
  cc:	40f707bb          	subw	a5,a4,a5
  d0:	2781                	sext.w	a5,a5
}
  d2:	853e                	mv	a0,a5
  d4:	6462                	ld	s0,24(sp)
  d6:	6105                	addi	sp,sp,32
  d8:	8082                	ret

00000000000000da <strlen>:

uint
strlen(const char *s)
{
  da:	7179                	addi	sp,sp,-48
  dc:	f422                	sd	s0,40(sp)
  de:	1800                	addi	s0,sp,48
  e0:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
  e4:	fe042623          	sw	zero,-20(s0)
  e8:	a031                	j	f4 <strlen+0x1a>
  ea:	fec42783          	lw	a5,-20(s0)
  ee:	2785                	addiw	a5,a5,1
  f0:	fef42623          	sw	a5,-20(s0)
  f4:	fec42783          	lw	a5,-20(s0)
  f8:	fd843703          	ld	a4,-40(s0)
  fc:	97ba                	add	a5,a5,a4
  fe:	0007c783          	lbu	a5,0(a5)
 102:	f7e5                	bnez	a5,ea <strlen+0x10>
    ;
  return n;
 104:	fec42783          	lw	a5,-20(s0)
}
 108:	853e                	mv	a0,a5
 10a:	7422                	ld	s0,40(sp)
 10c:	6145                	addi	sp,sp,48
 10e:	8082                	ret

0000000000000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	7179                	addi	sp,sp,-48
 112:	f422                	sd	s0,40(sp)
 114:	1800                	addi	s0,sp,48
 116:	fca43c23          	sd	a0,-40(s0)
 11a:	87ae                	mv	a5,a1
 11c:	8732                	mv	a4,a2
 11e:	fcf42a23          	sw	a5,-44(s0)
 122:	87ba                	mv	a5,a4
 124:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 128:	fd843783          	ld	a5,-40(s0)
 12c:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 130:	fe042623          	sw	zero,-20(s0)
 134:	a00d                	j	156 <memset+0x46>
    cdst[i] = c;
 136:	fec42783          	lw	a5,-20(s0)
 13a:	fe043703          	ld	a4,-32(s0)
 13e:	97ba                	add	a5,a5,a4
 140:	fd442703          	lw	a4,-44(s0)
 144:	0ff77713          	zext.b	a4,a4
 148:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 14c:	fec42783          	lw	a5,-20(s0)
 150:	2785                	addiw	a5,a5,1
 152:	fef42623          	sw	a5,-20(s0)
 156:	fec42703          	lw	a4,-20(s0)
 15a:	fd042783          	lw	a5,-48(s0)
 15e:	2781                	sext.w	a5,a5
 160:	fcf76be3          	bltu	a4,a5,136 <memset+0x26>
  }
  return dst;
 164:	fd843783          	ld	a5,-40(s0)
}
 168:	853e                	mv	a0,a5
 16a:	7422                	ld	s0,40(sp)
 16c:	6145                	addi	sp,sp,48
 16e:	8082                	ret

0000000000000170 <strchr>:

char*
strchr(const char *s, char c)
{
 170:	1101                	addi	sp,sp,-32
 172:	ec22                	sd	s0,24(sp)
 174:	1000                	addi	s0,sp,32
 176:	fea43423          	sd	a0,-24(s0)
 17a:	87ae                	mv	a5,a1
 17c:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 180:	a01d                	j	1a6 <strchr+0x36>
    if(*s == c)
 182:	fe843783          	ld	a5,-24(s0)
 186:	0007c703          	lbu	a4,0(a5)
 18a:	fe744783          	lbu	a5,-25(s0)
 18e:	0ff7f793          	zext.b	a5,a5
 192:	00e79563          	bne	a5,a4,19c <strchr+0x2c>
      return (char*)s;
 196:	fe843783          	ld	a5,-24(s0)
 19a:	a821                	j	1b2 <strchr+0x42>
  for(; *s; s++)
 19c:	fe843783          	ld	a5,-24(s0)
 1a0:	0785                	addi	a5,a5,1
 1a2:	fef43423          	sd	a5,-24(s0)
 1a6:	fe843783          	ld	a5,-24(s0)
 1aa:	0007c783          	lbu	a5,0(a5)
 1ae:	fbf1                	bnez	a5,182 <strchr+0x12>
  return 0;
 1b0:	4781                	li	a5,0
}
 1b2:	853e                	mv	a0,a5
 1b4:	6462                	ld	s0,24(sp)
 1b6:	6105                	addi	sp,sp,32
 1b8:	8082                	ret

00000000000001ba <gets>:

char*
gets(char *buf, int max)
{
 1ba:	7179                	addi	sp,sp,-48
 1bc:	f406                	sd	ra,40(sp)
 1be:	f022                	sd	s0,32(sp)
 1c0:	1800                	addi	s0,sp,48
 1c2:	fca43c23          	sd	a0,-40(s0)
 1c6:	87ae                	mv	a5,a1
 1c8:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1cc:	fe042623          	sw	zero,-20(s0)
 1d0:	a8a1                	j	228 <gets+0x6e>
    cc = read(0, &c, 1);
 1d2:	fe740793          	addi	a5,s0,-25
 1d6:	4605                	li	a2,1
 1d8:	85be                	mv	a1,a5
 1da:	4501                	li	a0,0
 1dc:	00000097          	auipc	ra,0x0
 1e0:	2f8080e7          	jalr	760(ra) # 4d4 <read>
 1e4:	87aa                	mv	a5,a0
 1e6:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 1ea:	fe842783          	lw	a5,-24(s0)
 1ee:	2781                	sext.w	a5,a5
 1f0:	04f05763          	blez	a5,23e <gets+0x84>
      break;
    buf[i++] = c;
 1f4:	fec42783          	lw	a5,-20(s0)
 1f8:	0017871b          	addiw	a4,a5,1
 1fc:	fee42623          	sw	a4,-20(s0)
 200:	873e                	mv	a4,a5
 202:	fd843783          	ld	a5,-40(s0)
 206:	97ba                	add	a5,a5,a4
 208:	fe744703          	lbu	a4,-25(s0)
 20c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 210:	fe744783          	lbu	a5,-25(s0)
 214:	873e                	mv	a4,a5
 216:	47a9                	li	a5,10
 218:	02f70463          	beq	a4,a5,240 <gets+0x86>
 21c:	fe744783          	lbu	a5,-25(s0)
 220:	873e                	mv	a4,a5
 222:	47b5                	li	a5,13
 224:	00f70e63          	beq	a4,a5,240 <gets+0x86>
  for(i=0; i+1 < max; ){
 228:	fec42783          	lw	a5,-20(s0)
 22c:	2785                	addiw	a5,a5,1
 22e:	0007871b          	sext.w	a4,a5
 232:	fd442783          	lw	a5,-44(s0)
 236:	2781                	sext.w	a5,a5
 238:	f8f74de3          	blt	a4,a5,1d2 <gets+0x18>
 23c:	a011                	j	240 <gets+0x86>
      break;
 23e:	0001                	nop
      break;
  }
  buf[i] = '\0';
 240:	fec42783          	lw	a5,-20(s0)
 244:	fd843703          	ld	a4,-40(s0)
 248:	97ba                	add	a5,a5,a4
 24a:	00078023          	sb	zero,0(a5)
  return buf;
 24e:	fd843783          	ld	a5,-40(s0)
}
 252:	853e                	mv	a0,a5
 254:	70a2                	ld	ra,40(sp)
 256:	7402                	ld	s0,32(sp)
 258:	6145                	addi	sp,sp,48
 25a:	8082                	ret

000000000000025c <stat>:

int
stat(const char *n, struct stat *st)
{
 25c:	7179                	addi	sp,sp,-48
 25e:	f406                	sd	ra,40(sp)
 260:	f022                	sd	s0,32(sp)
 262:	1800                	addi	s0,sp,48
 264:	fca43c23          	sd	a0,-40(s0)
 268:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 26c:	4581                	li	a1,0
 26e:	fd843503          	ld	a0,-40(s0)
 272:	00000097          	auipc	ra,0x0
 276:	28a080e7          	jalr	650(ra) # 4fc <open>
 27a:	87aa                	mv	a5,a0
 27c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 280:	fec42783          	lw	a5,-20(s0)
 284:	2781                	sext.w	a5,a5
 286:	0007d463          	bgez	a5,28e <stat+0x32>
    return -1;
 28a:	57fd                	li	a5,-1
 28c:	a035                	j	2b8 <stat+0x5c>
  r = fstat(fd, st);
 28e:	fec42783          	lw	a5,-20(s0)
 292:	fd043583          	ld	a1,-48(s0)
 296:	853e                	mv	a0,a5
 298:	00000097          	auipc	ra,0x0
 29c:	27c080e7          	jalr	636(ra) # 514 <fstat>
 2a0:	87aa                	mv	a5,a0
 2a2:	fef42423          	sw	a5,-24(s0)
  close(fd);
 2a6:	fec42783          	lw	a5,-20(s0)
 2aa:	853e                	mv	a0,a5
 2ac:	00000097          	auipc	ra,0x0
 2b0:	238080e7          	jalr	568(ra) # 4e4 <close>
  return r;
 2b4:	fe842783          	lw	a5,-24(s0)
}
 2b8:	853e                	mv	a0,a5
 2ba:	70a2                	ld	ra,40(sp)
 2bc:	7402                	ld	s0,32(sp)
 2be:	6145                	addi	sp,sp,48
 2c0:	8082                	ret

00000000000002c2 <atoi>:

int
atoi(const char *s)
{
 2c2:	7179                	addi	sp,sp,-48
 2c4:	f422                	sd	s0,40(sp)
 2c6:	1800                	addi	s0,sp,48
 2c8:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 2cc:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 2d0:	a81d                	j	306 <atoi+0x44>
    n = n*10 + *s++ - '0';
 2d2:	fec42783          	lw	a5,-20(s0)
 2d6:	873e                	mv	a4,a5
 2d8:	87ba                	mv	a5,a4
 2da:	0027979b          	slliw	a5,a5,0x2
 2de:	9fb9                	addw	a5,a5,a4
 2e0:	0017979b          	slliw	a5,a5,0x1
 2e4:	0007871b          	sext.w	a4,a5
 2e8:	fd843783          	ld	a5,-40(s0)
 2ec:	00178693          	addi	a3,a5,1
 2f0:	fcd43c23          	sd	a3,-40(s0)
 2f4:	0007c783          	lbu	a5,0(a5)
 2f8:	2781                	sext.w	a5,a5
 2fa:	9fb9                	addw	a5,a5,a4
 2fc:	2781                	sext.w	a5,a5
 2fe:	fd07879b          	addiw	a5,a5,-48
 302:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 306:	fd843783          	ld	a5,-40(s0)
 30a:	0007c783          	lbu	a5,0(a5)
 30e:	873e                	mv	a4,a5
 310:	02f00793          	li	a5,47
 314:	00e7fb63          	bgeu	a5,a4,32a <atoi+0x68>
 318:	fd843783          	ld	a5,-40(s0)
 31c:	0007c783          	lbu	a5,0(a5)
 320:	873e                	mv	a4,a5
 322:	03900793          	li	a5,57
 326:	fae7f6e3          	bgeu	a5,a4,2d2 <atoi+0x10>
  return n;
 32a:	fec42783          	lw	a5,-20(s0)
}
 32e:	853e                	mv	a0,a5
 330:	7422                	ld	s0,40(sp)
 332:	6145                	addi	sp,sp,48
 334:	8082                	ret

0000000000000336 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 336:	7139                	addi	sp,sp,-64
 338:	fc22                	sd	s0,56(sp)
 33a:	0080                	addi	s0,sp,64
 33c:	fca43c23          	sd	a0,-40(s0)
 340:	fcb43823          	sd	a1,-48(s0)
 344:	87b2                	mv	a5,a2
 346:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 34a:	fd843783          	ld	a5,-40(s0)
 34e:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 352:	fd043783          	ld	a5,-48(s0)
 356:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 35a:	fe043703          	ld	a4,-32(s0)
 35e:	fe843783          	ld	a5,-24(s0)
 362:	02e7fc63          	bgeu	a5,a4,39a <memmove+0x64>
    while(n-- > 0)
 366:	a00d                	j	388 <memmove+0x52>
      *dst++ = *src++;
 368:	fe043703          	ld	a4,-32(s0)
 36c:	00170793          	addi	a5,a4,1
 370:	fef43023          	sd	a5,-32(s0)
 374:	fe843783          	ld	a5,-24(s0)
 378:	00178693          	addi	a3,a5,1
 37c:	fed43423          	sd	a3,-24(s0)
 380:	00074703          	lbu	a4,0(a4)
 384:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 388:	fcc42783          	lw	a5,-52(s0)
 38c:	fff7871b          	addiw	a4,a5,-1
 390:	fce42623          	sw	a4,-52(s0)
 394:	fcf04ae3          	bgtz	a5,368 <memmove+0x32>
 398:	a891                	j	3ec <memmove+0xb6>
  } else {
    dst += n;
 39a:	fcc42783          	lw	a5,-52(s0)
 39e:	fe843703          	ld	a4,-24(s0)
 3a2:	97ba                	add	a5,a5,a4
 3a4:	fef43423          	sd	a5,-24(s0)
    src += n;
 3a8:	fcc42783          	lw	a5,-52(s0)
 3ac:	fe043703          	ld	a4,-32(s0)
 3b0:	97ba                	add	a5,a5,a4
 3b2:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 3b6:	a01d                	j	3dc <memmove+0xa6>
      *--dst = *--src;
 3b8:	fe043783          	ld	a5,-32(s0)
 3bc:	17fd                	addi	a5,a5,-1
 3be:	fef43023          	sd	a5,-32(s0)
 3c2:	fe843783          	ld	a5,-24(s0)
 3c6:	17fd                	addi	a5,a5,-1
 3c8:	fef43423          	sd	a5,-24(s0)
 3cc:	fe043783          	ld	a5,-32(s0)
 3d0:	0007c703          	lbu	a4,0(a5)
 3d4:	fe843783          	ld	a5,-24(s0)
 3d8:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3dc:	fcc42783          	lw	a5,-52(s0)
 3e0:	fff7871b          	addiw	a4,a5,-1
 3e4:	fce42623          	sw	a4,-52(s0)
 3e8:	fcf048e3          	bgtz	a5,3b8 <memmove+0x82>
  }
  return vdst;
 3ec:	fd843783          	ld	a5,-40(s0)
}
 3f0:	853e                	mv	a0,a5
 3f2:	7462                	ld	s0,56(sp)
 3f4:	6121                	addi	sp,sp,64
 3f6:	8082                	ret

00000000000003f8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3f8:	7139                	addi	sp,sp,-64
 3fa:	fc22                	sd	s0,56(sp)
 3fc:	0080                	addi	s0,sp,64
 3fe:	fca43c23          	sd	a0,-40(s0)
 402:	fcb43823          	sd	a1,-48(s0)
 406:	87b2                	mv	a5,a2
 408:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 40c:	fd843783          	ld	a5,-40(s0)
 410:	fef43423          	sd	a5,-24(s0)
 414:	fd043783          	ld	a5,-48(s0)
 418:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 41c:	a0a1                	j	464 <memcmp+0x6c>
    if (*p1 != *p2) {
 41e:	fe843783          	ld	a5,-24(s0)
 422:	0007c703          	lbu	a4,0(a5)
 426:	fe043783          	ld	a5,-32(s0)
 42a:	0007c783          	lbu	a5,0(a5)
 42e:	02f70163          	beq	a4,a5,450 <memcmp+0x58>
      return *p1 - *p2;
 432:	fe843783          	ld	a5,-24(s0)
 436:	0007c783          	lbu	a5,0(a5)
 43a:	0007871b          	sext.w	a4,a5
 43e:	fe043783          	ld	a5,-32(s0)
 442:	0007c783          	lbu	a5,0(a5)
 446:	2781                	sext.w	a5,a5
 448:	40f707bb          	subw	a5,a4,a5
 44c:	2781                	sext.w	a5,a5
 44e:	a01d                	j	474 <memcmp+0x7c>
    }
    p1++;
 450:	fe843783          	ld	a5,-24(s0)
 454:	0785                	addi	a5,a5,1
 456:	fef43423          	sd	a5,-24(s0)
    p2++;
 45a:	fe043783          	ld	a5,-32(s0)
 45e:	0785                	addi	a5,a5,1
 460:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 464:	fcc42783          	lw	a5,-52(s0)
 468:	fff7871b          	addiw	a4,a5,-1
 46c:	fce42623          	sw	a4,-52(s0)
 470:	f7dd                	bnez	a5,41e <memcmp+0x26>
  }
  return 0;
 472:	4781                	li	a5,0
}
 474:	853e                	mv	a0,a5
 476:	7462                	ld	s0,56(sp)
 478:	6121                	addi	sp,sp,64
 47a:	8082                	ret

000000000000047c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 47c:	7179                	addi	sp,sp,-48
 47e:	f406                	sd	ra,40(sp)
 480:	f022                	sd	s0,32(sp)
 482:	1800                	addi	s0,sp,48
 484:	fea43423          	sd	a0,-24(s0)
 488:	feb43023          	sd	a1,-32(s0)
 48c:	87b2                	mv	a5,a2
 48e:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 492:	fdc42783          	lw	a5,-36(s0)
 496:	863e                	mv	a2,a5
 498:	fe043583          	ld	a1,-32(s0)
 49c:	fe843503          	ld	a0,-24(s0)
 4a0:	00000097          	auipc	ra,0x0
 4a4:	e96080e7          	jalr	-362(ra) # 336 <memmove>
 4a8:	87aa                	mv	a5,a0
}
 4aa:	853e                	mv	a0,a5
 4ac:	70a2                	ld	ra,40(sp)
 4ae:	7402                	ld	s0,32(sp)
 4b0:	6145                	addi	sp,sp,48
 4b2:	8082                	ret

00000000000004b4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4b4:	4885                	li	a7,1
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <exit>:
.global exit
exit:
 li a7, SYS_exit
 4bc:	4889                	li	a7,2
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4c4:	488d                	li	a7,3
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4cc:	4891                	li	a7,4
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <read>:
.global read
read:
 li a7, SYS_read
 4d4:	4895                	li	a7,5
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <write>:
.global write
write:
 li a7, SYS_write
 4dc:	48c1                	li	a7,16
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <close>:
.global close
close:
 li a7, SYS_close
 4e4:	48d5                	li	a7,21
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <kill>:
.global kill
kill:
 li a7, SYS_kill
 4ec:	4899                	li	a7,6
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4f4:	489d                	li	a7,7
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <open>:
.global open
open:
 li a7, SYS_open
 4fc:	48bd                	li	a7,15
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 504:	48c5                	li	a7,17
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 50c:	48c9                	li	a7,18
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 514:	48a1                	li	a7,8
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <link>:
.global link
link:
 li a7, SYS_link
 51c:	48cd                	li	a7,19
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 524:	48d1                	li	a7,20
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 52c:	48a5                	li	a7,9
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <dup>:
.global dup
dup:
 li a7, SYS_dup
 534:	48a9                	li	a7,10
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 53c:	48ad                	li	a7,11
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 544:	48b1                	li	a7,12
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 54c:	48b5                	li	a7,13
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 554:	48b9                	li	a7,14
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <clone>:
.global clone
clone:
 li a7, SYS_clone
 55c:	48d9                	li	a7,22
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <join>:
.global join
join:
 li a7, SYS_join
 564:	48dd                	li	a7,23
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 56c:	1101                	addi	sp,sp,-32
 56e:	ec06                	sd	ra,24(sp)
 570:	e822                	sd	s0,16(sp)
 572:	1000                	addi	s0,sp,32
 574:	87aa                	mv	a5,a0
 576:	872e                	mv	a4,a1
 578:	fef42623          	sw	a5,-20(s0)
 57c:	87ba                	mv	a5,a4
 57e:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 582:	feb40713          	addi	a4,s0,-21
 586:	fec42783          	lw	a5,-20(s0)
 58a:	4605                	li	a2,1
 58c:	85ba                	mv	a1,a4
 58e:	853e                	mv	a0,a5
 590:	00000097          	auipc	ra,0x0
 594:	f4c080e7          	jalr	-180(ra) # 4dc <write>
}
 598:	0001                	nop
 59a:	60e2                	ld	ra,24(sp)
 59c:	6442                	ld	s0,16(sp)
 59e:	6105                	addi	sp,sp,32
 5a0:	8082                	ret

00000000000005a2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5a2:	7139                	addi	sp,sp,-64
 5a4:	fc06                	sd	ra,56(sp)
 5a6:	f822                	sd	s0,48(sp)
 5a8:	0080                	addi	s0,sp,64
 5aa:	87aa                	mv	a5,a0
 5ac:	8736                	mv	a4,a3
 5ae:	fcf42623          	sw	a5,-52(s0)
 5b2:	87ae                	mv	a5,a1
 5b4:	fcf42423          	sw	a5,-56(s0)
 5b8:	87b2                	mv	a5,a2
 5ba:	fcf42223          	sw	a5,-60(s0)
 5be:	87ba                	mv	a5,a4
 5c0:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5c4:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 5c8:	fc042783          	lw	a5,-64(s0)
 5cc:	2781                	sext.w	a5,a5
 5ce:	c38d                	beqz	a5,5f0 <printint+0x4e>
 5d0:	fc842783          	lw	a5,-56(s0)
 5d4:	2781                	sext.w	a5,a5
 5d6:	0007dd63          	bgez	a5,5f0 <printint+0x4e>
    neg = 1;
 5da:	4785                	li	a5,1
 5dc:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 5e0:	fc842783          	lw	a5,-56(s0)
 5e4:	40f007bb          	negw	a5,a5
 5e8:	2781                	sext.w	a5,a5
 5ea:	fef42223          	sw	a5,-28(s0)
 5ee:	a029                	j	5f8 <printint+0x56>
  } else {
    x = xx;
 5f0:	fc842783          	lw	a5,-56(s0)
 5f4:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 5f8:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 5fc:	fc442783          	lw	a5,-60(s0)
 600:	fe442703          	lw	a4,-28(s0)
 604:	02f777bb          	remuw	a5,a4,a5
 608:	0007861b          	sext.w	a2,a5
 60c:	fec42783          	lw	a5,-20(s0)
 610:	0017871b          	addiw	a4,a5,1
 614:	fee42623          	sw	a4,-20(s0)
 618:	00001697          	auipc	a3,0x1
 61c:	88868693          	addi	a3,a3,-1912 # ea0 <digits>
 620:	02061713          	slli	a4,a2,0x20
 624:	9301                	srli	a4,a4,0x20
 626:	9736                	add	a4,a4,a3
 628:	00074703          	lbu	a4,0(a4)
 62c:	17c1                	addi	a5,a5,-16
 62e:	97a2                	add	a5,a5,s0
 630:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 634:	fc442783          	lw	a5,-60(s0)
 638:	fe442703          	lw	a4,-28(s0)
 63c:	02f757bb          	divuw	a5,a4,a5
 640:	fef42223          	sw	a5,-28(s0)
 644:	fe442783          	lw	a5,-28(s0)
 648:	2781                	sext.w	a5,a5
 64a:	fbcd                	bnez	a5,5fc <printint+0x5a>
  if(neg)
 64c:	fe842783          	lw	a5,-24(s0)
 650:	2781                	sext.w	a5,a5
 652:	cf85                	beqz	a5,68a <printint+0xe8>
    buf[i++] = '-';
 654:	fec42783          	lw	a5,-20(s0)
 658:	0017871b          	addiw	a4,a5,1
 65c:	fee42623          	sw	a4,-20(s0)
 660:	17c1                	addi	a5,a5,-16
 662:	97a2                	add	a5,a5,s0
 664:	02d00713          	li	a4,45
 668:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 66c:	a839                	j	68a <printint+0xe8>
    putc(fd, buf[i]);
 66e:	fec42783          	lw	a5,-20(s0)
 672:	17c1                	addi	a5,a5,-16
 674:	97a2                	add	a5,a5,s0
 676:	fe07c703          	lbu	a4,-32(a5)
 67a:	fcc42783          	lw	a5,-52(s0)
 67e:	85ba                	mv	a1,a4
 680:	853e                	mv	a0,a5
 682:	00000097          	auipc	ra,0x0
 686:	eea080e7          	jalr	-278(ra) # 56c <putc>
  while(--i >= 0)
 68a:	fec42783          	lw	a5,-20(s0)
 68e:	37fd                	addiw	a5,a5,-1
 690:	fef42623          	sw	a5,-20(s0)
 694:	fec42783          	lw	a5,-20(s0)
 698:	2781                	sext.w	a5,a5
 69a:	fc07dae3          	bgez	a5,66e <printint+0xcc>
}
 69e:	0001                	nop
 6a0:	0001                	nop
 6a2:	70e2                	ld	ra,56(sp)
 6a4:	7442                	ld	s0,48(sp)
 6a6:	6121                	addi	sp,sp,64
 6a8:	8082                	ret

00000000000006aa <printptr>:

static void
printptr(int fd, uint64 x) {
 6aa:	7179                	addi	sp,sp,-48
 6ac:	f406                	sd	ra,40(sp)
 6ae:	f022                	sd	s0,32(sp)
 6b0:	1800                	addi	s0,sp,48
 6b2:	87aa                	mv	a5,a0
 6b4:	fcb43823          	sd	a1,-48(s0)
 6b8:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 6bc:	fdc42783          	lw	a5,-36(s0)
 6c0:	03000593          	li	a1,48
 6c4:	853e                	mv	a0,a5
 6c6:	00000097          	auipc	ra,0x0
 6ca:	ea6080e7          	jalr	-346(ra) # 56c <putc>
  putc(fd, 'x');
 6ce:	fdc42783          	lw	a5,-36(s0)
 6d2:	07800593          	li	a1,120
 6d6:	853e                	mv	a0,a5
 6d8:	00000097          	auipc	ra,0x0
 6dc:	e94080e7          	jalr	-364(ra) # 56c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6e0:	fe042623          	sw	zero,-20(s0)
 6e4:	a82d                	j	71e <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6e6:	fd043783          	ld	a5,-48(s0)
 6ea:	93f1                	srli	a5,a5,0x3c
 6ec:	00000717          	auipc	a4,0x0
 6f0:	7b470713          	addi	a4,a4,1972 # ea0 <digits>
 6f4:	97ba                	add	a5,a5,a4
 6f6:	0007c703          	lbu	a4,0(a5)
 6fa:	fdc42783          	lw	a5,-36(s0)
 6fe:	85ba                	mv	a1,a4
 700:	853e                	mv	a0,a5
 702:	00000097          	auipc	ra,0x0
 706:	e6a080e7          	jalr	-406(ra) # 56c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 70a:	fec42783          	lw	a5,-20(s0)
 70e:	2785                	addiw	a5,a5,1
 710:	fef42623          	sw	a5,-20(s0)
 714:	fd043783          	ld	a5,-48(s0)
 718:	0792                	slli	a5,a5,0x4
 71a:	fcf43823          	sd	a5,-48(s0)
 71e:	fec42783          	lw	a5,-20(s0)
 722:	873e                	mv	a4,a5
 724:	47bd                	li	a5,15
 726:	fce7f0e3          	bgeu	a5,a4,6e6 <printptr+0x3c>
}
 72a:	0001                	nop
 72c:	0001                	nop
 72e:	70a2                	ld	ra,40(sp)
 730:	7402                	ld	s0,32(sp)
 732:	6145                	addi	sp,sp,48
 734:	8082                	ret

0000000000000736 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 736:	715d                	addi	sp,sp,-80
 738:	e486                	sd	ra,72(sp)
 73a:	e0a2                	sd	s0,64(sp)
 73c:	0880                	addi	s0,sp,80
 73e:	87aa                	mv	a5,a0
 740:	fcb43023          	sd	a1,-64(s0)
 744:	fac43c23          	sd	a2,-72(s0)
 748:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 74c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 750:	fe042223          	sw	zero,-28(s0)
 754:	a42d                	j	97e <vprintf+0x248>
    c = fmt[i] & 0xff;
 756:	fe442783          	lw	a5,-28(s0)
 75a:	fc043703          	ld	a4,-64(s0)
 75e:	97ba                	add	a5,a5,a4
 760:	0007c783          	lbu	a5,0(a5)
 764:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 768:	fe042783          	lw	a5,-32(s0)
 76c:	2781                	sext.w	a5,a5
 76e:	eb9d                	bnez	a5,7a4 <vprintf+0x6e>
      if(c == '%'){
 770:	fdc42783          	lw	a5,-36(s0)
 774:	0007871b          	sext.w	a4,a5
 778:	02500793          	li	a5,37
 77c:	00f71763          	bne	a4,a5,78a <vprintf+0x54>
        state = '%';
 780:	02500793          	li	a5,37
 784:	fef42023          	sw	a5,-32(s0)
 788:	a2f5                	j	974 <vprintf+0x23e>
      } else {
        putc(fd, c);
 78a:	fdc42783          	lw	a5,-36(s0)
 78e:	0ff7f713          	zext.b	a4,a5
 792:	fcc42783          	lw	a5,-52(s0)
 796:	85ba                	mv	a1,a4
 798:	853e                	mv	a0,a5
 79a:	00000097          	auipc	ra,0x0
 79e:	dd2080e7          	jalr	-558(ra) # 56c <putc>
 7a2:	aac9                	j	974 <vprintf+0x23e>
      }
    } else if(state == '%'){
 7a4:	fe042783          	lw	a5,-32(s0)
 7a8:	0007871b          	sext.w	a4,a5
 7ac:	02500793          	li	a5,37
 7b0:	1cf71263          	bne	a4,a5,974 <vprintf+0x23e>
      if(c == 'd'){
 7b4:	fdc42783          	lw	a5,-36(s0)
 7b8:	0007871b          	sext.w	a4,a5
 7bc:	06400793          	li	a5,100
 7c0:	02f71463          	bne	a4,a5,7e8 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 7c4:	fb843783          	ld	a5,-72(s0)
 7c8:	00878713          	addi	a4,a5,8
 7cc:	fae43c23          	sd	a4,-72(s0)
 7d0:	4398                	lw	a4,0(a5)
 7d2:	fcc42783          	lw	a5,-52(s0)
 7d6:	4685                	li	a3,1
 7d8:	4629                	li	a2,10
 7da:	85ba                	mv	a1,a4
 7dc:	853e                	mv	a0,a5
 7de:	00000097          	auipc	ra,0x0
 7e2:	dc4080e7          	jalr	-572(ra) # 5a2 <printint>
 7e6:	a269                	j	970 <vprintf+0x23a>
      } else if(c == 'l') {
 7e8:	fdc42783          	lw	a5,-36(s0)
 7ec:	0007871b          	sext.w	a4,a5
 7f0:	06c00793          	li	a5,108
 7f4:	02f71663          	bne	a4,a5,820 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7f8:	fb843783          	ld	a5,-72(s0)
 7fc:	00878713          	addi	a4,a5,8
 800:	fae43c23          	sd	a4,-72(s0)
 804:	639c                	ld	a5,0(a5)
 806:	0007871b          	sext.w	a4,a5
 80a:	fcc42783          	lw	a5,-52(s0)
 80e:	4681                	li	a3,0
 810:	4629                	li	a2,10
 812:	85ba                	mv	a1,a4
 814:	853e                	mv	a0,a5
 816:	00000097          	auipc	ra,0x0
 81a:	d8c080e7          	jalr	-628(ra) # 5a2 <printint>
 81e:	aa89                	j	970 <vprintf+0x23a>
      } else if(c == 'x') {
 820:	fdc42783          	lw	a5,-36(s0)
 824:	0007871b          	sext.w	a4,a5
 828:	07800793          	li	a5,120
 82c:	02f71463          	bne	a4,a5,854 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 830:	fb843783          	ld	a5,-72(s0)
 834:	00878713          	addi	a4,a5,8
 838:	fae43c23          	sd	a4,-72(s0)
 83c:	4398                	lw	a4,0(a5)
 83e:	fcc42783          	lw	a5,-52(s0)
 842:	4681                	li	a3,0
 844:	4641                	li	a2,16
 846:	85ba                	mv	a1,a4
 848:	853e                	mv	a0,a5
 84a:	00000097          	auipc	ra,0x0
 84e:	d58080e7          	jalr	-680(ra) # 5a2 <printint>
 852:	aa39                	j	970 <vprintf+0x23a>
      } else if(c == 'p') {
 854:	fdc42783          	lw	a5,-36(s0)
 858:	0007871b          	sext.w	a4,a5
 85c:	07000793          	li	a5,112
 860:	02f71263          	bne	a4,a5,884 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 864:	fb843783          	ld	a5,-72(s0)
 868:	00878713          	addi	a4,a5,8
 86c:	fae43c23          	sd	a4,-72(s0)
 870:	6398                	ld	a4,0(a5)
 872:	fcc42783          	lw	a5,-52(s0)
 876:	85ba                	mv	a1,a4
 878:	853e                	mv	a0,a5
 87a:	00000097          	auipc	ra,0x0
 87e:	e30080e7          	jalr	-464(ra) # 6aa <printptr>
 882:	a0fd                	j	970 <vprintf+0x23a>
      } else if(c == 's'){
 884:	fdc42783          	lw	a5,-36(s0)
 888:	0007871b          	sext.w	a4,a5
 88c:	07300793          	li	a5,115
 890:	04f71c63          	bne	a4,a5,8e8 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 894:	fb843783          	ld	a5,-72(s0)
 898:	00878713          	addi	a4,a5,8
 89c:	fae43c23          	sd	a4,-72(s0)
 8a0:	639c                	ld	a5,0(a5)
 8a2:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 8a6:	fe843783          	ld	a5,-24(s0)
 8aa:	eb8d                	bnez	a5,8dc <vprintf+0x1a6>
          s = "(null)";
 8ac:	00000797          	auipc	a5,0x0
 8b0:	59c78793          	addi	a5,a5,1436 # e48 <lock_init+0x1c>
 8b4:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 8b8:	a015                	j	8dc <vprintf+0x1a6>
          putc(fd, *s);
 8ba:	fe843783          	ld	a5,-24(s0)
 8be:	0007c703          	lbu	a4,0(a5)
 8c2:	fcc42783          	lw	a5,-52(s0)
 8c6:	85ba                	mv	a1,a4
 8c8:	853e                	mv	a0,a5
 8ca:	00000097          	auipc	ra,0x0
 8ce:	ca2080e7          	jalr	-862(ra) # 56c <putc>
          s++;
 8d2:	fe843783          	ld	a5,-24(s0)
 8d6:	0785                	addi	a5,a5,1
 8d8:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 8dc:	fe843783          	ld	a5,-24(s0)
 8e0:	0007c783          	lbu	a5,0(a5)
 8e4:	fbf9                	bnez	a5,8ba <vprintf+0x184>
 8e6:	a069                	j	970 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 8e8:	fdc42783          	lw	a5,-36(s0)
 8ec:	0007871b          	sext.w	a4,a5
 8f0:	06300793          	li	a5,99
 8f4:	02f71463          	bne	a4,a5,91c <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 8f8:	fb843783          	ld	a5,-72(s0)
 8fc:	00878713          	addi	a4,a5,8
 900:	fae43c23          	sd	a4,-72(s0)
 904:	439c                	lw	a5,0(a5)
 906:	0ff7f713          	zext.b	a4,a5
 90a:	fcc42783          	lw	a5,-52(s0)
 90e:	85ba                	mv	a1,a4
 910:	853e                	mv	a0,a5
 912:	00000097          	auipc	ra,0x0
 916:	c5a080e7          	jalr	-934(ra) # 56c <putc>
 91a:	a899                	j	970 <vprintf+0x23a>
      } else if(c == '%'){
 91c:	fdc42783          	lw	a5,-36(s0)
 920:	0007871b          	sext.w	a4,a5
 924:	02500793          	li	a5,37
 928:	00f71f63          	bne	a4,a5,946 <vprintf+0x210>
        putc(fd, c);
 92c:	fdc42783          	lw	a5,-36(s0)
 930:	0ff7f713          	zext.b	a4,a5
 934:	fcc42783          	lw	a5,-52(s0)
 938:	85ba                	mv	a1,a4
 93a:	853e                	mv	a0,a5
 93c:	00000097          	auipc	ra,0x0
 940:	c30080e7          	jalr	-976(ra) # 56c <putc>
 944:	a035                	j	970 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 946:	fcc42783          	lw	a5,-52(s0)
 94a:	02500593          	li	a1,37
 94e:	853e                	mv	a0,a5
 950:	00000097          	auipc	ra,0x0
 954:	c1c080e7          	jalr	-996(ra) # 56c <putc>
        putc(fd, c);
 958:	fdc42783          	lw	a5,-36(s0)
 95c:	0ff7f713          	zext.b	a4,a5
 960:	fcc42783          	lw	a5,-52(s0)
 964:	85ba                	mv	a1,a4
 966:	853e                	mv	a0,a5
 968:	00000097          	auipc	ra,0x0
 96c:	c04080e7          	jalr	-1020(ra) # 56c <putc>
      }
      state = 0;
 970:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 974:	fe442783          	lw	a5,-28(s0)
 978:	2785                	addiw	a5,a5,1
 97a:	fef42223          	sw	a5,-28(s0)
 97e:	fe442783          	lw	a5,-28(s0)
 982:	fc043703          	ld	a4,-64(s0)
 986:	97ba                	add	a5,a5,a4
 988:	0007c783          	lbu	a5,0(a5)
 98c:	dc0795e3          	bnez	a5,756 <vprintf+0x20>
    }
  }
}
 990:	0001                	nop
 992:	0001                	nop
 994:	60a6                	ld	ra,72(sp)
 996:	6406                	ld	s0,64(sp)
 998:	6161                	addi	sp,sp,80
 99a:	8082                	ret

000000000000099c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 99c:	7159                	addi	sp,sp,-112
 99e:	fc06                	sd	ra,56(sp)
 9a0:	f822                	sd	s0,48(sp)
 9a2:	0080                	addi	s0,sp,64
 9a4:	fcb43823          	sd	a1,-48(s0)
 9a8:	e010                	sd	a2,0(s0)
 9aa:	e414                	sd	a3,8(s0)
 9ac:	e818                	sd	a4,16(s0)
 9ae:	ec1c                	sd	a5,24(s0)
 9b0:	03043023          	sd	a6,32(s0)
 9b4:	03143423          	sd	a7,40(s0)
 9b8:	87aa                	mv	a5,a0
 9ba:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 9be:	03040793          	addi	a5,s0,48
 9c2:	fcf43423          	sd	a5,-56(s0)
 9c6:	fc843783          	ld	a5,-56(s0)
 9ca:	fd078793          	addi	a5,a5,-48
 9ce:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 9d2:	fe843703          	ld	a4,-24(s0)
 9d6:	fdc42783          	lw	a5,-36(s0)
 9da:	863a                	mv	a2,a4
 9dc:	fd043583          	ld	a1,-48(s0)
 9e0:	853e                	mv	a0,a5
 9e2:	00000097          	auipc	ra,0x0
 9e6:	d54080e7          	jalr	-684(ra) # 736 <vprintf>
}
 9ea:	0001                	nop
 9ec:	70e2                	ld	ra,56(sp)
 9ee:	7442                	ld	s0,48(sp)
 9f0:	6165                	addi	sp,sp,112
 9f2:	8082                	ret

00000000000009f4 <printf>:

void
printf(const char *fmt, ...)
{
 9f4:	7159                	addi	sp,sp,-112
 9f6:	f406                	sd	ra,40(sp)
 9f8:	f022                	sd	s0,32(sp)
 9fa:	1800                	addi	s0,sp,48
 9fc:	fca43c23          	sd	a0,-40(s0)
 a00:	e40c                	sd	a1,8(s0)
 a02:	e810                	sd	a2,16(s0)
 a04:	ec14                	sd	a3,24(s0)
 a06:	f018                	sd	a4,32(s0)
 a08:	f41c                	sd	a5,40(s0)
 a0a:	03043823          	sd	a6,48(s0)
 a0e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a12:	04040793          	addi	a5,s0,64
 a16:	fcf43823          	sd	a5,-48(s0)
 a1a:	fd043783          	ld	a5,-48(s0)
 a1e:	fc878793          	addi	a5,a5,-56
 a22:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 a26:	fe843783          	ld	a5,-24(s0)
 a2a:	863e                	mv	a2,a5
 a2c:	fd843583          	ld	a1,-40(s0)
 a30:	4505                	li	a0,1
 a32:	00000097          	auipc	ra,0x0
 a36:	d04080e7          	jalr	-764(ra) # 736 <vprintf>
}
 a3a:	0001                	nop
 a3c:	70a2                	ld	ra,40(sp)
 a3e:	7402                	ld	s0,32(sp)
 a40:	6165                	addi	sp,sp,112
 a42:	8082                	ret

0000000000000a44 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a44:	7179                	addi	sp,sp,-48
 a46:	f422                	sd	s0,40(sp)
 a48:	1800                	addi	s0,sp,48
 a4a:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a4e:	fd843783          	ld	a5,-40(s0)
 a52:	17c1                	addi	a5,a5,-16
 a54:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a58:	00000797          	auipc	a5,0x0
 a5c:	47078793          	addi	a5,a5,1136 # ec8 <freep>
 a60:	639c                	ld	a5,0(a5)
 a62:	fef43423          	sd	a5,-24(s0)
 a66:	a815                	j	a9a <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a68:	fe843783          	ld	a5,-24(s0)
 a6c:	639c                	ld	a5,0(a5)
 a6e:	fe843703          	ld	a4,-24(s0)
 a72:	00f76f63          	bltu	a4,a5,a90 <free+0x4c>
 a76:	fe043703          	ld	a4,-32(s0)
 a7a:	fe843783          	ld	a5,-24(s0)
 a7e:	02e7eb63          	bltu	a5,a4,ab4 <free+0x70>
 a82:	fe843783          	ld	a5,-24(s0)
 a86:	639c                	ld	a5,0(a5)
 a88:	fe043703          	ld	a4,-32(s0)
 a8c:	02f76463          	bltu	a4,a5,ab4 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a90:	fe843783          	ld	a5,-24(s0)
 a94:	639c                	ld	a5,0(a5)
 a96:	fef43423          	sd	a5,-24(s0)
 a9a:	fe043703          	ld	a4,-32(s0)
 a9e:	fe843783          	ld	a5,-24(s0)
 aa2:	fce7f3e3          	bgeu	a5,a4,a68 <free+0x24>
 aa6:	fe843783          	ld	a5,-24(s0)
 aaa:	639c                	ld	a5,0(a5)
 aac:	fe043703          	ld	a4,-32(s0)
 ab0:	faf77ce3          	bgeu	a4,a5,a68 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 ab4:	fe043783          	ld	a5,-32(s0)
 ab8:	479c                	lw	a5,8(a5)
 aba:	1782                	slli	a5,a5,0x20
 abc:	9381                	srli	a5,a5,0x20
 abe:	0792                	slli	a5,a5,0x4
 ac0:	fe043703          	ld	a4,-32(s0)
 ac4:	973e                	add	a4,a4,a5
 ac6:	fe843783          	ld	a5,-24(s0)
 aca:	639c                	ld	a5,0(a5)
 acc:	02f71763          	bne	a4,a5,afa <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 ad0:	fe043783          	ld	a5,-32(s0)
 ad4:	4798                	lw	a4,8(a5)
 ad6:	fe843783          	ld	a5,-24(s0)
 ada:	639c                	ld	a5,0(a5)
 adc:	479c                	lw	a5,8(a5)
 ade:	9fb9                	addw	a5,a5,a4
 ae0:	0007871b          	sext.w	a4,a5
 ae4:	fe043783          	ld	a5,-32(s0)
 ae8:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 aea:	fe843783          	ld	a5,-24(s0)
 aee:	639c                	ld	a5,0(a5)
 af0:	6398                	ld	a4,0(a5)
 af2:	fe043783          	ld	a5,-32(s0)
 af6:	e398                	sd	a4,0(a5)
 af8:	a039                	j	b06 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 afa:	fe843783          	ld	a5,-24(s0)
 afe:	6398                	ld	a4,0(a5)
 b00:	fe043783          	ld	a5,-32(s0)
 b04:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b06:	fe843783          	ld	a5,-24(s0)
 b0a:	479c                	lw	a5,8(a5)
 b0c:	1782                	slli	a5,a5,0x20
 b0e:	9381                	srli	a5,a5,0x20
 b10:	0792                	slli	a5,a5,0x4
 b12:	fe843703          	ld	a4,-24(s0)
 b16:	97ba                	add	a5,a5,a4
 b18:	fe043703          	ld	a4,-32(s0)
 b1c:	02f71563          	bne	a4,a5,b46 <free+0x102>
    p->s.size += bp->s.size;
 b20:	fe843783          	ld	a5,-24(s0)
 b24:	4798                	lw	a4,8(a5)
 b26:	fe043783          	ld	a5,-32(s0)
 b2a:	479c                	lw	a5,8(a5)
 b2c:	9fb9                	addw	a5,a5,a4
 b2e:	0007871b          	sext.w	a4,a5
 b32:	fe843783          	ld	a5,-24(s0)
 b36:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b38:	fe043783          	ld	a5,-32(s0)
 b3c:	6398                	ld	a4,0(a5)
 b3e:	fe843783          	ld	a5,-24(s0)
 b42:	e398                	sd	a4,0(a5)
 b44:	a031                	j	b50 <free+0x10c>
  } else
    p->s.ptr = bp;
 b46:	fe843783          	ld	a5,-24(s0)
 b4a:	fe043703          	ld	a4,-32(s0)
 b4e:	e398                	sd	a4,0(a5)
  freep = p;
 b50:	00000797          	auipc	a5,0x0
 b54:	37878793          	addi	a5,a5,888 # ec8 <freep>
 b58:	fe843703          	ld	a4,-24(s0)
 b5c:	e398                	sd	a4,0(a5)
}
 b5e:	0001                	nop
 b60:	7422                	ld	s0,40(sp)
 b62:	6145                	addi	sp,sp,48
 b64:	8082                	ret

0000000000000b66 <morecore>:

static Header*
morecore(uint nu)
{
 b66:	7179                	addi	sp,sp,-48
 b68:	f406                	sd	ra,40(sp)
 b6a:	f022                	sd	s0,32(sp)
 b6c:	1800                	addi	s0,sp,48
 b6e:	87aa                	mv	a5,a0
 b70:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 b74:	fdc42783          	lw	a5,-36(s0)
 b78:	0007871b          	sext.w	a4,a5
 b7c:	6785                	lui	a5,0x1
 b7e:	00f77563          	bgeu	a4,a5,b88 <morecore+0x22>
    nu = 4096;
 b82:	6785                	lui	a5,0x1
 b84:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 b88:	fdc42783          	lw	a5,-36(s0)
 b8c:	0047979b          	slliw	a5,a5,0x4
 b90:	2781                	sext.w	a5,a5
 b92:	2781                	sext.w	a5,a5
 b94:	853e                	mv	a0,a5
 b96:	00000097          	auipc	ra,0x0
 b9a:	9ae080e7          	jalr	-1618(ra) # 544 <sbrk>
 b9e:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 ba2:	fe843703          	ld	a4,-24(s0)
 ba6:	57fd                	li	a5,-1
 ba8:	00f71463          	bne	a4,a5,bb0 <morecore+0x4a>
    return 0;
 bac:	4781                	li	a5,0
 bae:	a03d                	j	bdc <morecore+0x76>
  hp = (Header*)p;
 bb0:	fe843783          	ld	a5,-24(s0)
 bb4:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 bb8:	fe043783          	ld	a5,-32(s0)
 bbc:	fdc42703          	lw	a4,-36(s0)
 bc0:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 bc2:	fe043783          	ld	a5,-32(s0)
 bc6:	07c1                	addi	a5,a5,16
 bc8:	853e                	mv	a0,a5
 bca:	00000097          	auipc	ra,0x0
 bce:	e7a080e7          	jalr	-390(ra) # a44 <free>
  return freep;
 bd2:	00000797          	auipc	a5,0x0
 bd6:	2f678793          	addi	a5,a5,758 # ec8 <freep>
 bda:	639c                	ld	a5,0(a5)
}
 bdc:	853e                	mv	a0,a5
 bde:	70a2                	ld	ra,40(sp)
 be0:	7402                	ld	s0,32(sp)
 be2:	6145                	addi	sp,sp,48
 be4:	8082                	ret

0000000000000be6 <malloc>:

void*
malloc(uint nbytes)
{
 be6:	7139                	addi	sp,sp,-64
 be8:	fc06                	sd	ra,56(sp)
 bea:	f822                	sd	s0,48(sp)
 bec:	0080                	addi	s0,sp,64
 bee:	87aa                	mv	a5,a0
 bf0:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bf4:	fcc46783          	lwu	a5,-52(s0)
 bf8:	07bd                	addi	a5,a5,15
 bfa:	8391                	srli	a5,a5,0x4
 bfc:	2781                	sext.w	a5,a5
 bfe:	2785                	addiw	a5,a5,1
 c00:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c04:	00000797          	auipc	a5,0x0
 c08:	2c478793          	addi	a5,a5,708 # ec8 <freep>
 c0c:	639c                	ld	a5,0(a5)
 c0e:	fef43023          	sd	a5,-32(s0)
 c12:	fe043783          	ld	a5,-32(s0)
 c16:	ef95                	bnez	a5,c52 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c18:	00000797          	auipc	a5,0x0
 c1c:	2a078793          	addi	a5,a5,672 # eb8 <base>
 c20:	fef43023          	sd	a5,-32(s0)
 c24:	00000797          	auipc	a5,0x0
 c28:	2a478793          	addi	a5,a5,676 # ec8 <freep>
 c2c:	fe043703          	ld	a4,-32(s0)
 c30:	e398                	sd	a4,0(a5)
 c32:	00000797          	auipc	a5,0x0
 c36:	29678793          	addi	a5,a5,662 # ec8 <freep>
 c3a:	6398                	ld	a4,0(a5)
 c3c:	00000797          	auipc	a5,0x0
 c40:	27c78793          	addi	a5,a5,636 # eb8 <base>
 c44:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 c46:	00000797          	auipc	a5,0x0
 c4a:	27278793          	addi	a5,a5,626 # eb8 <base>
 c4e:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c52:	fe043783          	ld	a5,-32(s0)
 c56:	639c                	ld	a5,0(a5)
 c58:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 c5c:	fe843783          	ld	a5,-24(s0)
 c60:	4798                	lw	a4,8(a5)
 c62:	fdc42783          	lw	a5,-36(s0)
 c66:	2781                	sext.w	a5,a5
 c68:	06f76763          	bltu	a4,a5,cd6 <malloc+0xf0>
      if(p->s.size == nunits)
 c6c:	fe843783          	ld	a5,-24(s0)
 c70:	4798                	lw	a4,8(a5)
 c72:	fdc42783          	lw	a5,-36(s0)
 c76:	2781                	sext.w	a5,a5
 c78:	00e79963          	bne	a5,a4,c8a <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 c7c:	fe843783          	ld	a5,-24(s0)
 c80:	6398                	ld	a4,0(a5)
 c82:	fe043783          	ld	a5,-32(s0)
 c86:	e398                	sd	a4,0(a5)
 c88:	a825                	j	cc0 <malloc+0xda>
      else {
        p->s.size -= nunits;
 c8a:	fe843783          	ld	a5,-24(s0)
 c8e:	479c                	lw	a5,8(a5)
 c90:	fdc42703          	lw	a4,-36(s0)
 c94:	9f99                	subw	a5,a5,a4
 c96:	0007871b          	sext.w	a4,a5
 c9a:	fe843783          	ld	a5,-24(s0)
 c9e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ca0:	fe843783          	ld	a5,-24(s0)
 ca4:	479c                	lw	a5,8(a5)
 ca6:	1782                	slli	a5,a5,0x20
 ca8:	9381                	srli	a5,a5,0x20
 caa:	0792                	slli	a5,a5,0x4
 cac:	fe843703          	ld	a4,-24(s0)
 cb0:	97ba                	add	a5,a5,a4
 cb2:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 cb6:	fe843783          	ld	a5,-24(s0)
 cba:	fdc42703          	lw	a4,-36(s0)
 cbe:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 cc0:	00000797          	auipc	a5,0x0
 cc4:	20878793          	addi	a5,a5,520 # ec8 <freep>
 cc8:	fe043703          	ld	a4,-32(s0)
 ccc:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 cce:	fe843783          	ld	a5,-24(s0)
 cd2:	07c1                	addi	a5,a5,16
 cd4:	a091                	j	d18 <malloc+0x132>
    }
    if(p == freep)
 cd6:	00000797          	auipc	a5,0x0
 cda:	1f278793          	addi	a5,a5,498 # ec8 <freep>
 cde:	639c                	ld	a5,0(a5)
 ce0:	fe843703          	ld	a4,-24(s0)
 ce4:	02f71063          	bne	a4,a5,d04 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 ce8:	fdc42783          	lw	a5,-36(s0)
 cec:	853e                	mv	a0,a5
 cee:	00000097          	auipc	ra,0x0
 cf2:	e78080e7          	jalr	-392(ra) # b66 <morecore>
 cf6:	fea43423          	sd	a0,-24(s0)
 cfa:	fe843783          	ld	a5,-24(s0)
 cfe:	e399                	bnez	a5,d04 <malloc+0x11e>
        return 0;
 d00:	4781                	li	a5,0
 d02:	a819                	j	d18 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d04:	fe843783          	ld	a5,-24(s0)
 d08:	fef43023          	sd	a5,-32(s0)
 d0c:	fe843783          	ld	a5,-24(s0)
 d10:	639c                	ld	a5,0(a5)
 d12:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d16:	b799                	j	c5c <malloc+0x76>
  }
}
 d18:	853e                	mv	a0,a5
 d1a:	70e2                	ld	ra,56(sp)
 d1c:	7442                	ld	s0,48(sp)
 d1e:	6121                	addi	sp,sp,64
 d20:	8082                	ret

0000000000000d22 <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
 d22:	7179                	addi	sp,sp,-48
 d24:	f406                	sd	ra,40(sp)
 d26:	f022                	sd	s0,32(sp)
 d28:	1800                	addi	s0,sp,48
 d2a:	fca43c23          	sd	a0,-40(s0)
 d2e:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
 d32:	6505                	lui	a0,0x1
 d34:	00000097          	auipc	ra,0x0
 d38:	eb2080e7          	jalr	-334(ra) # be6 <malloc>
 d3c:	fea43423          	sd	a0,-24(s0)
 d40:	fe843783          	ld	a5,-24(s0)
 d44:	e38d                	bnez	a5,d66 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
 d46:	00000517          	auipc	a0,0x0
 d4a:	10a50513          	addi	a0,a0,266 # e50 <lock_init+0x24>
 d4e:	00000097          	auipc	ra,0x0
 d52:	ca6080e7          	jalr	-858(ra) # 9f4 <printf>
        free(stack);
 d56:	fe843503          	ld	a0,-24(s0)
 d5a:	00000097          	auipc	ra,0x0
 d5e:	cea080e7          	jalr	-790(ra) # a44 <free>
        return -1;
 d62:	57fd                	li	a5,-1
 d64:	a099                	j	daa <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
 d66:	fe843783          	ld	a5,-24(s0)
 d6a:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
 d6e:	fe043703          	ld	a4,-32(s0)
 d72:	6785                	lui	a5,0x1
 d74:	17fd                	addi	a5,a5,-1
 d76:	8ff9                	and	a5,a5,a4
 d78:	cf91                	beqz	a5,d94 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
 d7a:	fe043703          	ld	a4,-32(s0)
 d7e:	6785                	lui	a5,0x1
 d80:	17fd                	addi	a5,a5,-1
 d82:	8ff9                	and	a5,a5,a4
 d84:	6705                	lui	a4,0x1
 d86:	40f707b3          	sub	a5,a4,a5
 d8a:	fe843703          	ld	a4,-24(s0)
 d8e:	97ba                	add	a5,a5,a4
 d90:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
 d94:	fe843603          	ld	a2,-24(s0)
 d98:	fd043583          	ld	a1,-48(s0)
 d9c:	fd843503          	ld	a0,-40(s0)
 da0:	fffff097          	auipc	ra,0xfffff
 da4:	7bc080e7          	jalr	1980(ra) # 55c <clone>
 da8:	87aa                	mv	a5,a0
}
 daa:	853e                	mv	a0,a5
 dac:	70a2                	ld	ra,40(sp)
 dae:	7402                	ld	s0,32(sp)
 db0:	6145                	addi	sp,sp,48
 db2:	8082                	ret

0000000000000db4 <thread_join>:


int thread_join()
{
 db4:	1101                	addi	sp,sp,-32
 db6:	ec06                	sd	ra,24(sp)
 db8:	e822                	sd	s0,16(sp)
 dba:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
 dbc:	fe040793          	addi	a5,s0,-32
 dc0:	853e                	mv	a0,a5
 dc2:	fffff097          	auipc	ra,0xfffff
 dc6:	7a2080e7          	jalr	1954(ra) # 564 <join>
 dca:	87aa                	mv	a5,a0
 dcc:	fef42623          	sw	a5,-20(s0)
 dd0:	fec42783          	lw	a5,-20(s0)
 dd4:	0007871b          	sext.w	a4,a5
 dd8:	57fd                	li	a5,-1
 dda:	00f70963          	beq	a4,a5,dec <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
 dde:	fe043783          	ld	a5,-32(s0)
 de2:	853e                	mv	a0,a5
 de4:	00000097          	auipc	ra,0x0
 de8:	c60080e7          	jalr	-928(ra) # a44 <free>
    } 

    return child_tid;
 dec:	fec42783          	lw	a5,-20(s0)
}
 df0:	853e                	mv	a0,a5
 df2:	60e2                	ld	ra,24(sp)
 df4:	6442                	ld	s0,16(sp)
 df6:	6105                	addi	sp,sp,32
 df8:	8082                	ret

0000000000000dfa <lock_acquire>:


void lock_acquire (lock_t *lock)
{
 dfa:	1101                	addi	sp,sp,-32
 dfc:	ec22                	sd	s0,24(sp)
 dfe:	1000                	addi	s0,sp,32
 e00:	fea43423          	sd	a0,-24(s0)
        lock = 0;
 e04:	fe043423          	sd	zero,-24(s0)

}
 e08:	0001                	nop
 e0a:	6462                	ld	s0,24(sp)
 e0c:	6105                	addi	sp,sp,32
 e0e:	8082                	ret

0000000000000e10 <lock_release>:

void lock_release (lock_t *lock)
{
 e10:	1101                	addi	sp,sp,-32
 e12:	ec22                	sd	s0,24(sp)
 e14:	1000                	addi	s0,sp,32
 e16:	fea43423          	sd	a0,-24(s0)
        __sync_lock_test_and_set(lock, 1);
 e1a:	fe843783          	ld	a5,-24(s0)
 e1e:	4705                	li	a4,1
 e20:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    
}
 e24:	0001                	nop
 e26:	6462                	ld	s0,24(sp)
 e28:	6105                	addi	sp,sp,32
 e2a:	8082                	ret

0000000000000e2c <lock_init>:

void lock_init (lock_t *lock)
{
 e2c:	1101                	addi	sp,sp,-32
 e2e:	ec22                	sd	s0,24(sp)
 e30:	1000                	addi	s0,sp,32
 e32:	fea43423          	sd	a0,-24(s0)
    lock = 0;
 e36:	fe043423          	sd	zero,-24(s0)
    
}
 e3a:	0001                	nop
 e3c:	6462                	ld	s0,24(sp)
 e3e:	6105                	addi	sp,sp,32
 e40:	8082                	ret
