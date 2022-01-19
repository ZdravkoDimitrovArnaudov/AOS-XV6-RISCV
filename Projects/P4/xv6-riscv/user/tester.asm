
user/_tester:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
   8:	87aa                	mv	a5,a0
   a:	feb43023          	sd	a1,-32(s0)
   e:	fef42623          	sw	a5,-20(s0)
  printf("%s", "** Placeholder program for grading scripts **\n");
  12:	00001597          	auipc	a1,0x1
  16:	e3e58593          	addi	a1,a1,-450 # e50 <lock_init+0x1a>
  1a:	00001517          	auipc	a0,0x1
  1e:	e6650513          	addi	a0,a0,-410 # e80 <lock_init+0x4a>
  22:	00001097          	auipc	ra,0x1
  26:	9dc080e7          	jalr	-1572(ra) # 9fe <printf>
  exit(0);
  2a:	4501                	li	a0,0
  2c:	00000097          	auipc	ra,0x0
  30:	49a080e7          	jalr	1178(ra) # 4c6 <exit>

0000000000000034 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  34:	7179                	addi	sp,sp,-48
  36:	f422                	sd	s0,40(sp)
  38:	1800                	addi	s0,sp,48
  3a:	fca43c23          	sd	a0,-40(s0)
  3e:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  42:	fd843783          	ld	a5,-40(s0)
  46:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  4a:	0001                	nop
  4c:	fd043703          	ld	a4,-48(s0)
  50:	00170793          	addi	a5,a4,1
  54:	fcf43823          	sd	a5,-48(s0)
  58:	fd843783          	ld	a5,-40(s0)
  5c:	00178693          	addi	a3,a5,1
  60:	fcd43c23          	sd	a3,-40(s0)
  64:	00074703          	lbu	a4,0(a4)
  68:	00e78023          	sb	a4,0(a5)
  6c:	0007c783          	lbu	a5,0(a5)
  70:	fff1                	bnez	a5,4c <strcpy+0x18>
    ;
  return os;
  72:	fe843783          	ld	a5,-24(s0)
}
  76:	853e                	mv	a0,a5
  78:	7422                	ld	s0,40(sp)
  7a:	6145                	addi	sp,sp,48
  7c:	8082                	ret

000000000000007e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7e:	1101                	addi	sp,sp,-32
  80:	ec22                	sd	s0,24(sp)
  82:	1000                	addi	s0,sp,32
  84:	fea43423          	sd	a0,-24(s0)
  88:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
  8c:	a819                	j	a2 <strcmp+0x24>
    p++, q++;
  8e:	fe843783          	ld	a5,-24(s0)
  92:	0785                	addi	a5,a5,1
  94:	fef43423          	sd	a5,-24(s0)
  98:	fe043783          	ld	a5,-32(s0)
  9c:	0785                	addi	a5,a5,1
  9e:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
  a2:	fe843783          	ld	a5,-24(s0)
  a6:	0007c783          	lbu	a5,0(a5)
  aa:	cb99                	beqz	a5,c0 <strcmp+0x42>
  ac:	fe843783          	ld	a5,-24(s0)
  b0:	0007c703          	lbu	a4,0(a5)
  b4:	fe043783          	ld	a5,-32(s0)
  b8:	0007c783          	lbu	a5,0(a5)
  bc:	fcf709e3          	beq	a4,a5,8e <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
  c0:	fe843783          	ld	a5,-24(s0)
  c4:	0007c783          	lbu	a5,0(a5)
  c8:	0007871b          	sext.w	a4,a5
  cc:	fe043783          	ld	a5,-32(s0)
  d0:	0007c783          	lbu	a5,0(a5)
  d4:	2781                	sext.w	a5,a5
  d6:	40f707bb          	subw	a5,a4,a5
  da:	2781                	sext.w	a5,a5
}
  dc:	853e                	mv	a0,a5
  de:	6462                	ld	s0,24(sp)
  e0:	6105                	addi	sp,sp,32
  e2:	8082                	ret

00000000000000e4 <strlen>:

uint
strlen(const char *s)
{
  e4:	7179                	addi	sp,sp,-48
  e6:	f422                	sd	s0,40(sp)
  e8:	1800                	addi	s0,sp,48
  ea:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
  ee:	fe042623          	sw	zero,-20(s0)
  f2:	a031                	j	fe <strlen+0x1a>
  f4:	fec42783          	lw	a5,-20(s0)
  f8:	2785                	addiw	a5,a5,1
  fa:	fef42623          	sw	a5,-20(s0)
  fe:	fec42783          	lw	a5,-20(s0)
 102:	fd843703          	ld	a4,-40(s0)
 106:	97ba                	add	a5,a5,a4
 108:	0007c783          	lbu	a5,0(a5)
 10c:	f7e5                	bnez	a5,f4 <strlen+0x10>
    ;
  return n;
 10e:	fec42783          	lw	a5,-20(s0)
}
 112:	853e                	mv	a0,a5
 114:	7422                	ld	s0,40(sp)
 116:	6145                	addi	sp,sp,48
 118:	8082                	ret

000000000000011a <memset>:

void*
memset(void *dst, int c, uint n)
{
 11a:	7179                	addi	sp,sp,-48
 11c:	f422                	sd	s0,40(sp)
 11e:	1800                	addi	s0,sp,48
 120:	fca43c23          	sd	a0,-40(s0)
 124:	87ae                	mv	a5,a1
 126:	8732                	mv	a4,a2
 128:	fcf42a23          	sw	a5,-44(s0)
 12c:	87ba                	mv	a5,a4
 12e:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 132:	fd843783          	ld	a5,-40(s0)
 136:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 13a:	fe042623          	sw	zero,-20(s0)
 13e:	a00d                	j	160 <memset+0x46>
    cdst[i] = c;
 140:	fec42783          	lw	a5,-20(s0)
 144:	fe043703          	ld	a4,-32(s0)
 148:	97ba                	add	a5,a5,a4
 14a:	fd442703          	lw	a4,-44(s0)
 14e:	0ff77713          	zext.b	a4,a4
 152:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 156:	fec42783          	lw	a5,-20(s0)
 15a:	2785                	addiw	a5,a5,1
 15c:	fef42623          	sw	a5,-20(s0)
 160:	fec42703          	lw	a4,-20(s0)
 164:	fd042783          	lw	a5,-48(s0)
 168:	2781                	sext.w	a5,a5
 16a:	fcf76be3          	bltu	a4,a5,140 <memset+0x26>
  }
  return dst;
 16e:	fd843783          	ld	a5,-40(s0)
}
 172:	853e                	mv	a0,a5
 174:	7422                	ld	s0,40(sp)
 176:	6145                	addi	sp,sp,48
 178:	8082                	ret

000000000000017a <strchr>:

char*
strchr(const char *s, char c)
{
 17a:	1101                	addi	sp,sp,-32
 17c:	ec22                	sd	s0,24(sp)
 17e:	1000                	addi	s0,sp,32
 180:	fea43423          	sd	a0,-24(s0)
 184:	87ae                	mv	a5,a1
 186:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 18a:	a01d                	j	1b0 <strchr+0x36>
    if(*s == c)
 18c:	fe843783          	ld	a5,-24(s0)
 190:	0007c703          	lbu	a4,0(a5)
 194:	fe744783          	lbu	a5,-25(s0)
 198:	0ff7f793          	zext.b	a5,a5
 19c:	00e79563          	bne	a5,a4,1a6 <strchr+0x2c>
      return (char*)s;
 1a0:	fe843783          	ld	a5,-24(s0)
 1a4:	a821                	j	1bc <strchr+0x42>
  for(; *s; s++)
 1a6:	fe843783          	ld	a5,-24(s0)
 1aa:	0785                	addi	a5,a5,1
 1ac:	fef43423          	sd	a5,-24(s0)
 1b0:	fe843783          	ld	a5,-24(s0)
 1b4:	0007c783          	lbu	a5,0(a5)
 1b8:	fbf1                	bnez	a5,18c <strchr+0x12>
  return 0;
 1ba:	4781                	li	a5,0
}
 1bc:	853e                	mv	a0,a5
 1be:	6462                	ld	s0,24(sp)
 1c0:	6105                	addi	sp,sp,32
 1c2:	8082                	ret

00000000000001c4 <gets>:

char*
gets(char *buf, int max)
{
 1c4:	7179                	addi	sp,sp,-48
 1c6:	f406                	sd	ra,40(sp)
 1c8:	f022                	sd	s0,32(sp)
 1ca:	1800                	addi	s0,sp,48
 1cc:	fca43c23          	sd	a0,-40(s0)
 1d0:	87ae                	mv	a5,a1
 1d2:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d6:	fe042623          	sw	zero,-20(s0)
 1da:	a8a1                	j	232 <gets+0x6e>
    cc = read(0, &c, 1);
 1dc:	fe740793          	addi	a5,s0,-25
 1e0:	4605                	li	a2,1
 1e2:	85be                	mv	a1,a5
 1e4:	4501                	li	a0,0
 1e6:	00000097          	auipc	ra,0x0
 1ea:	2f8080e7          	jalr	760(ra) # 4de <read>
 1ee:	87aa                	mv	a5,a0
 1f0:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 1f4:	fe842783          	lw	a5,-24(s0)
 1f8:	2781                	sext.w	a5,a5
 1fa:	04f05763          	blez	a5,248 <gets+0x84>
      break;
    buf[i++] = c;
 1fe:	fec42783          	lw	a5,-20(s0)
 202:	0017871b          	addiw	a4,a5,1
 206:	fee42623          	sw	a4,-20(s0)
 20a:	873e                	mv	a4,a5
 20c:	fd843783          	ld	a5,-40(s0)
 210:	97ba                	add	a5,a5,a4
 212:	fe744703          	lbu	a4,-25(s0)
 216:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 21a:	fe744783          	lbu	a5,-25(s0)
 21e:	873e                	mv	a4,a5
 220:	47a9                	li	a5,10
 222:	02f70463          	beq	a4,a5,24a <gets+0x86>
 226:	fe744783          	lbu	a5,-25(s0)
 22a:	873e                	mv	a4,a5
 22c:	47b5                	li	a5,13
 22e:	00f70e63          	beq	a4,a5,24a <gets+0x86>
  for(i=0; i+1 < max; ){
 232:	fec42783          	lw	a5,-20(s0)
 236:	2785                	addiw	a5,a5,1
 238:	0007871b          	sext.w	a4,a5
 23c:	fd442783          	lw	a5,-44(s0)
 240:	2781                	sext.w	a5,a5
 242:	f8f74de3          	blt	a4,a5,1dc <gets+0x18>
 246:	a011                	j	24a <gets+0x86>
      break;
 248:	0001                	nop
      break;
  }
  buf[i] = '\0';
 24a:	fec42783          	lw	a5,-20(s0)
 24e:	fd843703          	ld	a4,-40(s0)
 252:	97ba                	add	a5,a5,a4
 254:	00078023          	sb	zero,0(a5)
  return buf;
 258:	fd843783          	ld	a5,-40(s0)
}
 25c:	853e                	mv	a0,a5
 25e:	70a2                	ld	ra,40(sp)
 260:	7402                	ld	s0,32(sp)
 262:	6145                	addi	sp,sp,48
 264:	8082                	ret

0000000000000266 <stat>:

int
stat(const char *n, struct stat *st)
{
 266:	7179                	addi	sp,sp,-48
 268:	f406                	sd	ra,40(sp)
 26a:	f022                	sd	s0,32(sp)
 26c:	1800                	addi	s0,sp,48
 26e:	fca43c23          	sd	a0,-40(s0)
 272:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 276:	4581                	li	a1,0
 278:	fd843503          	ld	a0,-40(s0)
 27c:	00000097          	auipc	ra,0x0
 280:	28a080e7          	jalr	650(ra) # 506 <open>
 284:	87aa                	mv	a5,a0
 286:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 28a:	fec42783          	lw	a5,-20(s0)
 28e:	2781                	sext.w	a5,a5
 290:	0007d463          	bgez	a5,298 <stat+0x32>
    return -1;
 294:	57fd                	li	a5,-1
 296:	a035                	j	2c2 <stat+0x5c>
  r = fstat(fd, st);
 298:	fec42783          	lw	a5,-20(s0)
 29c:	fd043583          	ld	a1,-48(s0)
 2a0:	853e                	mv	a0,a5
 2a2:	00000097          	auipc	ra,0x0
 2a6:	27c080e7          	jalr	636(ra) # 51e <fstat>
 2aa:	87aa                	mv	a5,a0
 2ac:	fef42423          	sw	a5,-24(s0)
  close(fd);
 2b0:	fec42783          	lw	a5,-20(s0)
 2b4:	853e                	mv	a0,a5
 2b6:	00000097          	auipc	ra,0x0
 2ba:	238080e7          	jalr	568(ra) # 4ee <close>
  return r;
 2be:	fe842783          	lw	a5,-24(s0)
}
 2c2:	853e                	mv	a0,a5
 2c4:	70a2                	ld	ra,40(sp)
 2c6:	7402                	ld	s0,32(sp)
 2c8:	6145                	addi	sp,sp,48
 2ca:	8082                	ret

00000000000002cc <atoi>:

int
atoi(const char *s)
{
 2cc:	7179                	addi	sp,sp,-48
 2ce:	f422                	sd	s0,40(sp)
 2d0:	1800                	addi	s0,sp,48
 2d2:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 2d6:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 2da:	a81d                	j	310 <atoi+0x44>
    n = n*10 + *s++ - '0';
 2dc:	fec42783          	lw	a5,-20(s0)
 2e0:	873e                	mv	a4,a5
 2e2:	87ba                	mv	a5,a4
 2e4:	0027979b          	slliw	a5,a5,0x2
 2e8:	9fb9                	addw	a5,a5,a4
 2ea:	0017979b          	slliw	a5,a5,0x1
 2ee:	0007871b          	sext.w	a4,a5
 2f2:	fd843783          	ld	a5,-40(s0)
 2f6:	00178693          	addi	a3,a5,1
 2fa:	fcd43c23          	sd	a3,-40(s0)
 2fe:	0007c783          	lbu	a5,0(a5)
 302:	2781                	sext.w	a5,a5
 304:	9fb9                	addw	a5,a5,a4
 306:	2781                	sext.w	a5,a5
 308:	fd07879b          	addiw	a5,a5,-48
 30c:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 310:	fd843783          	ld	a5,-40(s0)
 314:	0007c783          	lbu	a5,0(a5)
 318:	873e                	mv	a4,a5
 31a:	02f00793          	li	a5,47
 31e:	00e7fb63          	bgeu	a5,a4,334 <atoi+0x68>
 322:	fd843783          	ld	a5,-40(s0)
 326:	0007c783          	lbu	a5,0(a5)
 32a:	873e                	mv	a4,a5
 32c:	03900793          	li	a5,57
 330:	fae7f6e3          	bgeu	a5,a4,2dc <atoi+0x10>
  return n;
 334:	fec42783          	lw	a5,-20(s0)
}
 338:	853e                	mv	a0,a5
 33a:	7422                	ld	s0,40(sp)
 33c:	6145                	addi	sp,sp,48
 33e:	8082                	ret

0000000000000340 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 340:	7139                	addi	sp,sp,-64
 342:	fc22                	sd	s0,56(sp)
 344:	0080                	addi	s0,sp,64
 346:	fca43c23          	sd	a0,-40(s0)
 34a:	fcb43823          	sd	a1,-48(s0)
 34e:	87b2                	mv	a5,a2
 350:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 354:	fd843783          	ld	a5,-40(s0)
 358:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 35c:	fd043783          	ld	a5,-48(s0)
 360:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 364:	fe043703          	ld	a4,-32(s0)
 368:	fe843783          	ld	a5,-24(s0)
 36c:	02e7fc63          	bgeu	a5,a4,3a4 <memmove+0x64>
    while(n-- > 0)
 370:	a00d                	j	392 <memmove+0x52>
      *dst++ = *src++;
 372:	fe043703          	ld	a4,-32(s0)
 376:	00170793          	addi	a5,a4,1
 37a:	fef43023          	sd	a5,-32(s0)
 37e:	fe843783          	ld	a5,-24(s0)
 382:	00178693          	addi	a3,a5,1
 386:	fed43423          	sd	a3,-24(s0)
 38a:	00074703          	lbu	a4,0(a4)
 38e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 392:	fcc42783          	lw	a5,-52(s0)
 396:	fff7871b          	addiw	a4,a5,-1
 39a:	fce42623          	sw	a4,-52(s0)
 39e:	fcf04ae3          	bgtz	a5,372 <memmove+0x32>
 3a2:	a891                	j	3f6 <memmove+0xb6>
  } else {
    dst += n;
 3a4:	fcc42783          	lw	a5,-52(s0)
 3a8:	fe843703          	ld	a4,-24(s0)
 3ac:	97ba                	add	a5,a5,a4
 3ae:	fef43423          	sd	a5,-24(s0)
    src += n;
 3b2:	fcc42783          	lw	a5,-52(s0)
 3b6:	fe043703          	ld	a4,-32(s0)
 3ba:	97ba                	add	a5,a5,a4
 3bc:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 3c0:	a01d                	j	3e6 <memmove+0xa6>
      *--dst = *--src;
 3c2:	fe043783          	ld	a5,-32(s0)
 3c6:	17fd                	addi	a5,a5,-1
 3c8:	fef43023          	sd	a5,-32(s0)
 3cc:	fe843783          	ld	a5,-24(s0)
 3d0:	17fd                	addi	a5,a5,-1
 3d2:	fef43423          	sd	a5,-24(s0)
 3d6:	fe043783          	ld	a5,-32(s0)
 3da:	0007c703          	lbu	a4,0(a5)
 3de:	fe843783          	ld	a5,-24(s0)
 3e2:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3e6:	fcc42783          	lw	a5,-52(s0)
 3ea:	fff7871b          	addiw	a4,a5,-1
 3ee:	fce42623          	sw	a4,-52(s0)
 3f2:	fcf048e3          	bgtz	a5,3c2 <memmove+0x82>
  }
  return vdst;
 3f6:	fd843783          	ld	a5,-40(s0)
}
 3fa:	853e                	mv	a0,a5
 3fc:	7462                	ld	s0,56(sp)
 3fe:	6121                	addi	sp,sp,64
 400:	8082                	ret

0000000000000402 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 402:	7139                	addi	sp,sp,-64
 404:	fc22                	sd	s0,56(sp)
 406:	0080                	addi	s0,sp,64
 408:	fca43c23          	sd	a0,-40(s0)
 40c:	fcb43823          	sd	a1,-48(s0)
 410:	87b2                	mv	a5,a2
 412:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 416:	fd843783          	ld	a5,-40(s0)
 41a:	fef43423          	sd	a5,-24(s0)
 41e:	fd043783          	ld	a5,-48(s0)
 422:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 426:	a0a1                	j	46e <memcmp+0x6c>
    if (*p1 != *p2) {
 428:	fe843783          	ld	a5,-24(s0)
 42c:	0007c703          	lbu	a4,0(a5)
 430:	fe043783          	ld	a5,-32(s0)
 434:	0007c783          	lbu	a5,0(a5)
 438:	02f70163          	beq	a4,a5,45a <memcmp+0x58>
      return *p1 - *p2;
 43c:	fe843783          	ld	a5,-24(s0)
 440:	0007c783          	lbu	a5,0(a5)
 444:	0007871b          	sext.w	a4,a5
 448:	fe043783          	ld	a5,-32(s0)
 44c:	0007c783          	lbu	a5,0(a5)
 450:	2781                	sext.w	a5,a5
 452:	40f707bb          	subw	a5,a4,a5
 456:	2781                	sext.w	a5,a5
 458:	a01d                	j	47e <memcmp+0x7c>
    }
    p1++;
 45a:	fe843783          	ld	a5,-24(s0)
 45e:	0785                	addi	a5,a5,1
 460:	fef43423          	sd	a5,-24(s0)
    p2++;
 464:	fe043783          	ld	a5,-32(s0)
 468:	0785                	addi	a5,a5,1
 46a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 46e:	fcc42783          	lw	a5,-52(s0)
 472:	fff7871b          	addiw	a4,a5,-1
 476:	fce42623          	sw	a4,-52(s0)
 47a:	f7dd                	bnez	a5,428 <memcmp+0x26>
  }
  return 0;
 47c:	4781                	li	a5,0
}
 47e:	853e                	mv	a0,a5
 480:	7462                	ld	s0,56(sp)
 482:	6121                	addi	sp,sp,64
 484:	8082                	ret

0000000000000486 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 486:	7179                	addi	sp,sp,-48
 488:	f406                	sd	ra,40(sp)
 48a:	f022                	sd	s0,32(sp)
 48c:	1800                	addi	s0,sp,48
 48e:	fea43423          	sd	a0,-24(s0)
 492:	feb43023          	sd	a1,-32(s0)
 496:	87b2                	mv	a5,a2
 498:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 49c:	fdc42783          	lw	a5,-36(s0)
 4a0:	863e                	mv	a2,a5
 4a2:	fe043583          	ld	a1,-32(s0)
 4a6:	fe843503          	ld	a0,-24(s0)
 4aa:	00000097          	auipc	ra,0x0
 4ae:	e96080e7          	jalr	-362(ra) # 340 <memmove>
 4b2:	87aa                	mv	a5,a0
}
 4b4:	853e                	mv	a0,a5
 4b6:	70a2                	ld	ra,40(sp)
 4b8:	7402                	ld	s0,32(sp)
 4ba:	6145                	addi	sp,sp,48
 4bc:	8082                	ret

00000000000004be <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4be:	4885                	li	a7,1
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4c6:	4889                	li	a7,2
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <wait>:
.global wait
wait:
 li a7, SYS_wait
 4ce:	488d                	li	a7,3
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4d6:	4891                	li	a7,4
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <read>:
.global read
read:
 li a7, SYS_read
 4de:	4895                	li	a7,5
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <write>:
.global write
write:
 li a7, SYS_write
 4e6:	48c1                	li	a7,16
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <close>:
.global close
close:
 li a7, SYS_close
 4ee:	48d5                	li	a7,21
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4f6:	4899                	li	a7,6
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <exec>:
.global exec
exec:
 li a7, SYS_exec
 4fe:	489d                	li	a7,7
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <open>:
.global open
open:
 li a7, SYS_open
 506:	48bd                	li	a7,15
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 50e:	48c5                	li	a7,17
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 516:	48c9                	li	a7,18
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 51e:	48a1                	li	a7,8
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <link>:
.global link
link:
 li a7, SYS_link
 526:	48cd                	li	a7,19
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 52e:	48d1                	li	a7,20
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 536:	48a5                	li	a7,9
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <dup>:
.global dup
dup:
 li a7, SYS_dup
 53e:	48a9                	li	a7,10
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 546:	48ad                	li	a7,11
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 54e:	48b1                	li	a7,12
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 556:	48b5                	li	a7,13
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 55e:	48b9                	li	a7,14
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <clone>:
.global clone
clone:
 li a7, SYS_clone
 566:	48d9                	li	a7,22
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <join>:
.global join
join:
 li a7, SYS_join
 56e:	48dd                	li	a7,23
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 576:	1101                	addi	sp,sp,-32
 578:	ec06                	sd	ra,24(sp)
 57a:	e822                	sd	s0,16(sp)
 57c:	1000                	addi	s0,sp,32
 57e:	87aa                	mv	a5,a0
 580:	872e                	mv	a4,a1
 582:	fef42623          	sw	a5,-20(s0)
 586:	87ba                	mv	a5,a4
 588:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 58c:	feb40713          	addi	a4,s0,-21
 590:	fec42783          	lw	a5,-20(s0)
 594:	4605                	li	a2,1
 596:	85ba                	mv	a1,a4
 598:	853e                	mv	a0,a5
 59a:	00000097          	auipc	ra,0x0
 59e:	f4c080e7          	jalr	-180(ra) # 4e6 <write>
}
 5a2:	0001                	nop
 5a4:	60e2                	ld	ra,24(sp)
 5a6:	6442                	ld	s0,16(sp)
 5a8:	6105                	addi	sp,sp,32
 5aa:	8082                	ret

00000000000005ac <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5ac:	7139                	addi	sp,sp,-64
 5ae:	fc06                	sd	ra,56(sp)
 5b0:	f822                	sd	s0,48(sp)
 5b2:	0080                	addi	s0,sp,64
 5b4:	87aa                	mv	a5,a0
 5b6:	8736                	mv	a4,a3
 5b8:	fcf42623          	sw	a5,-52(s0)
 5bc:	87ae                	mv	a5,a1
 5be:	fcf42423          	sw	a5,-56(s0)
 5c2:	87b2                	mv	a5,a2
 5c4:	fcf42223          	sw	a5,-60(s0)
 5c8:	87ba                	mv	a5,a4
 5ca:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5ce:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 5d2:	fc042783          	lw	a5,-64(s0)
 5d6:	2781                	sext.w	a5,a5
 5d8:	c38d                	beqz	a5,5fa <printint+0x4e>
 5da:	fc842783          	lw	a5,-56(s0)
 5de:	2781                	sext.w	a5,a5
 5e0:	0007dd63          	bgez	a5,5fa <printint+0x4e>
    neg = 1;
 5e4:	4785                	li	a5,1
 5e6:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 5ea:	fc842783          	lw	a5,-56(s0)
 5ee:	40f007bb          	negw	a5,a5
 5f2:	2781                	sext.w	a5,a5
 5f4:	fef42223          	sw	a5,-28(s0)
 5f8:	a029                	j	602 <printint+0x56>
  } else {
    x = xx;
 5fa:	fc842783          	lw	a5,-56(s0)
 5fe:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 602:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 606:	fc442783          	lw	a5,-60(s0)
 60a:	fe442703          	lw	a4,-28(s0)
 60e:	02f777bb          	remuw	a5,a4,a5
 612:	0007861b          	sext.w	a2,a5
 616:	fec42783          	lw	a5,-20(s0)
 61a:	0017871b          	addiw	a4,a5,1
 61e:	fee42623          	sw	a4,-20(s0)
 622:	00001697          	auipc	a3,0x1
 626:	8be68693          	addi	a3,a3,-1858 # ee0 <digits>
 62a:	02061713          	slli	a4,a2,0x20
 62e:	9301                	srli	a4,a4,0x20
 630:	9736                	add	a4,a4,a3
 632:	00074703          	lbu	a4,0(a4)
 636:	17c1                	addi	a5,a5,-16
 638:	97a2                	add	a5,a5,s0
 63a:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 63e:	fc442783          	lw	a5,-60(s0)
 642:	fe442703          	lw	a4,-28(s0)
 646:	02f757bb          	divuw	a5,a4,a5
 64a:	fef42223          	sw	a5,-28(s0)
 64e:	fe442783          	lw	a5,-28(s0)
 652:	2781                	sext.w	a5,a5
 654:	fbcd                	bnez	a5,606 <printint+0x5a>
  if(neg)
 656:	fe842783          	lw	a5,-24(s0)
 65a:	2781                	sext.w	a5,a5
 65c:	cf85                	beqz	a5,694 <printint+0xe8>
    buf[i++] = '-';
 65e:	fec42783          	lw	a5,-20(s0)
 662:	0017871b          	addiw	a4,a5,1
 666:	fee42623          	sw	a4,-20(s0)
 66a:	17c1                	addi	a5,a5,-16
 66c:	97a2                	add	a5,a5,s0
 66e:	02d00713          	li	a4,45
 672:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 676:	a839                	j	694 <printint+0xe8>
    putc(fd, buf[i]);
 678:	fec42783          	lw	a5,-20(s0)
 67c:	17c1                	addi	a5,a5,-16
 67e:	97a2                	add	a5,a5,s0
 680:	fe07c703          	lbu	a4,-32(a5)
 684:	fcc42783          	lw	a5,-52(s0)
 688:	85ba                	mv	a1,a4
 68a:	853e                	mv	a0,a5
 68c:	00000097          	auipc	ra,0x0
 690:	eea080e7          	jalr	-278(ra) # 576 <putc>
  while(--i >= 0)
 694:	fec42783          	lw	a5,-20(s0)
 698:	37fd                	addiw	a5,a5,-1
 69a:	fef42623          	sw	a5,-20(s0)
 69e:	fec42783          	lw	a5,-20(s0)
 6a2:	2781                	sext.w	a5,a5
 6a4:	fc07dae3          	bgez	a5,678 <printint+0xcc>
}
 6a8:	0001                	nop
 6aa:	0001                	nop
 6ac:	70e2                	ld	ra,56(sp)
 6ae:	7442                	ld	s0,48(sp)
 6b0:	6121                	addi	sp,sp,64
 6b2:	8082                	ret

00000000000006b4 <printptr>:

static void
printptr(int fd, uint64 x) {
 6b4:	7179                	addi	sp,sp,-48
 6b6:	f406                	sd	ra,40(sp)
 6b8:	f022                	sd	s0,32(sp)
 6ba:	1800                	addi	s0,sp,48
 6bc:	87aa                	mv	a5,a0
 6be:	fcb43823          	sd	a1,-48(s0)
 6c2:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 6c6:	fdc42783          	lw	a5,-36(s0)
 6ca:	03000593          	li	a1,48
 6ce:	853e                	mv	a0,a5
 6d0:	00000097          	auipc	ra,0x0
 6d4:	ea6080e7          	jalr	-346(ra) # 576 <putc>
  putc(fd, 'x');
 6d8:	fdc42783          	lw	a5,-36(s0)
 6dc:	07800593          	li	a1,120
 6e0:	853e                	mv	a0,a5
 6e2:	00000097          	auipc	ra,0x0
 6e6:	e94080e7          	jalr	-364(ra) # 576 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6ea:	fe042623          	sw	zero,-20(s0)
 6ee:	a82d                	j	728 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6f0:	fd043783          	ld	a5,-48(s0)
 6f4:	93f1                	srli	a5,a5,0x3c
 6f6:	00000717          	auipc	a4,0x0
 6fa:	7ea70713          	addi	a4,a4,2026 # ee0 <digits>
 6fe:	97ba                	add	a5,a5,a4
 700:	0007c703          	lbu	a4,0(a5)
 704:	fdc42783          	lw	a5,-36(s0)
 708:	85ba                	mv	a1,a4
 70a:	853e                	mv	a0,a5
 70c:	00000097          	auipc	ra,0x0
 710:	e6a080e7          	jalr	-406(ra) # 576 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 714:	fec42783          	lw	a5,-20(s0)
 718:	2785                	addiw	a5,a5,1
 71a:	fef42623          	sw	a5,-20(s0)
 71e:	fd043783          	ld	a5,-48(s0)
 722:	0792                	slli	a5,a5,0x4
 724:	fcf43823          	sd	a5,-48(s0)
 728:	fec42783          	lw	a5,-20(s0)
 72c:	873e                	mv	a4,a5
 72e:	47bd                	li	a5,15
 730:	fce7f0e3          	bgeu	a5,a4,6f0 <printptr+0x3c>
}
 734:	0001                	nop
 736:	0001                	nop
 738:	70a2                	ld	ra,40(sp)
 73a:	7402                	ld	s0,32(sp)
 73c:	6145                	addi	sp,sp,48
 73e:	8082                	ret

0000000000000740 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 740:	715d                	addi	sp,sp,-80
 742:	e486                	sd	ra,72(sp)
 744:	e0a2                	sd	s0,64(sp)
 746:	0880                	addi	s0,sp,80
 748:	87aa                	mv	a5,a0
 74a:	fcb43023          	sd	a1,-64(s0)
 74e:	fac43c23          	sd	a2,-72(s0)
 752:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 756:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 75a:	fe042223          	sw	zero,-28(s0)
 75e:	a42d                	j	988 <vprintf+0x248>
    c = fmt[i] & 0xff;
 760:	fe442783          	lw	a5,-28(s0)
 764:	fc043703          	ld	a4,-64(s0)
 768:	97ba                	add	a5,a5,a4
 76a:	0007c783          	lbu	a5,0(a5)
 76e:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 772:	fe042783          	lw	a5,-32(s0)
 776:	2781                	sext.w	a5,a5
 778:	eb9d                	bnez	a5,7ae <vprintf+0x6e>
      if(c == '%'){
 77a:	fdc42783          	lw	a5,-36(s0)
 77e:	0007871b          	sext.w	a4,a5
 782:	02500793          	li	a5,37
 786:	00f71763          	bne	a4,a5,794 <vprintf+0x54>
        state = '%';
 78a:	02500793          	li	a5,37
 78e:	fef42023          	sw	a5,-32(s0)
 792:	a2f5                	j	97e <vprintf+0x23e>
      } else {
        putc(fd, c);
 794:	fdc42783          	lw	a5,-36(s0)
 798:	0ff7f713          	zext.b	a4,a5
 79c:	fcc42783          	lw	a5,-52(s0)
 7a0:	85ba                	mv	a1,a4
 7a2:	853e                	mv	a0,a5
 7a4:	00000097          	auipc	ra,0x0
 7a8:	dd2080e7          	jalr	-558(ra) # 576 <putc>
 7ac:	aac9                	j	97e <vprintf+0x23e>
      }
    } else if(state == '%'){
 7ae:	fe042783          	lw	a5,-32(s0)
 7b2:	0007871b          	sext.w	a4,a5
 7b6:	02500793          	li	a5,37
 7ba:	1cf71263          	bne	a4,a5,97e <vprintf+0x23e>
      if(c == 'd'){
 7be:	fdc42783          	lw	a5,-36(s0)
 7c2:	0007871b          	sext.w	a4,a5
 7c6:	06400793          	li	a5,100
 7ca:	02f71463          	bne	a4,a5,7f2 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 7ce:	fb843783          	ld	a5,-72(s0)
 7d2:	00878713          	addi	a4,a5,8
 7d6:	fae43c23          	sd	a4,-72(s0)
 7da:	4398                	lw	a4,0(a5)
 7dc:	fcc42783          	lw	a5,-52(s0)
 7e0:	4685                	li	a3,1
 7e2:	4629                	li	a2,10
 7e4:	85ba                	mv	a1,a4
 7e6:	853e                	mv	a0,a5
 7e8:	00000097          	auipc	ra,0x0
 7ec:	dc4080e7          	jalr	-572(ra) # 5ac <printint>
 7f0:	a269                	j	97a <vprintf+0x23a>
      } else if(c == 'l') {
 7f2:	fdc42783          	lw	a5,-36(s0)
 7f6:	0007871b          	sext.w	a4,a5
 7fa:	06c00793          	li	a5,108
 7fe:	02f71663          	bne	a4,a5,82a <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 802:	fb843783          	ld	a5,-72(s0)
 806:	00878713          	addi	a4,a5,8
 80a:	fae43c23          	sd	a4,-72(s0)
 80e:	639c                	ld	a5,0(a5)
 810:	0007871b          	sext.w	a4,a5
 814:	fcc42783          	lw	a5,-52(s0)
 818:	4681                	li	a3,0
 81a:	4629                	li	a2,10
 81c:	85ba                	mv	a1,a4
 81e:	853e                	mv	a0,a5
 820:	00000097          	auipc	ra,0x0
 824:	d8c080e7          	jalr	-628(ra) # 5ac <printint>
 828:	aa89                	j	97a <vprintf+0x23a>
      } else if(c == 'x') {
 82a:	fdc42783          	lw	a5,-36(s0)
 82e:	0007871b          	sext.w	a4,a5
 832:	07800793          	li	a5,120
 836:	02f71463          	bne	a4,a5,85e <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 83a:	fb843783          	ld	a5,-72(s0)
 83e:	00878713          	addi	a4,a5,8
 842:	fae43c23          	sd	a4,-72(s0)
 846:	4398                	lw	a4,0(a5)
 848:	fcc42783          	lw	a5,-52(s0)
 84c:	4681                	li	a3,0
 84e:	4641                	li	a2,16
 850:	85ba                	mv	a1,a4
 852:	853e                	mv	a0,a5
 854:	00000097          	auipc	ra,0x0
 858:	d58080e7          	jalr	-680(ra) # 5ac <printint>
 85c:	aa39                	j	97a <vprintf+0x23a>
      } else if(c == 'p') {
 85e:	fdc42783          	lw	a5,-36(s0)
 862:	0007871b          	sext.w	a4,a5
 866:	07000793          	li	a5,112
 86a:	02f71263          	bne	a4,a5,88e <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 86e:	fb843783          	ld	a5,-72(s0)
 872:	00878713          	addi	a4,a5,8
 876:	fae43c23          	sd	a4,-72(s0)
 87a:	6398                	ld	a4,0(a5)
 87c:	fcc42783          	lw	a5,-52(s0)
 880:	85ba                	mv	a1,a4
 882:	853e                	mv	a0,a5
 884:	00000097          	auipc	ra,0x0
 888:	e30080e7          	jalr	-464(ra) # 6b4 <printptr>
 88c:	a0fd                	j	97a <vprintf+0x23a>
      } else if(c == 's'){
 88e:	fdc42783          	lw	a5,-36(s0)
 892:	0007871b          	sext.w	a4,a5
 896:	07300793          	li	a5,115
 89a:	04f71c63          	bne	a4,a5,8f2 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 89e:	fb843783          	ld	a5,-72(s0)
 8a2:	00878713          	addi	a4,a5,8
 8a6:	fae43c23          	sd	a4,-72(s0)
 8aa:	639c                	ld	a5,0(a5)
 8ac:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 8b0:	fe843783          	ld	a5,-24(s0)
 8b4:	eb8d                	bnez	a5,8e6 <vprintf+0x1a6>
          s = "(null)";
 8b6:	00000797          	auipc	a5,0x0
 8ba:	5d278793          	addi	a5,a5,1490 # e88 <lock_init+0x52>
 8be:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 8c2:	a015                	j	8e6 <vprintf+0x1a6>
          putc(fd, *s);
 8c4:	fe843783          	ld	a5,-24(s0)
 8c8:	0007c703          	lbu	a4,0(a5)
 8cc:	fcc42783          	lw	a5,-52(s0)
 8d0:	85ba                	mv	a1,a4
 8d2:	853e                	mv	a0,a5
 8d4:	00000097          	auipc	ra,0x0
 8d8:	ca2080e7          	jalr	-862(ra) # 576 <putc>
          s++;
 8dc:	fe843783          	ld	a5,-24(s0)
 8e0:	0785                	addi	a5,a5,1
 8e2:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 8e6:	fe843783          	ld	a5,-24(s0)
 8ea:	0007c783          	lbu	a5,0(a5)
 8ee:	fbf9                	bnez	a5,8c4 <vprintf+0x184>
 8f0:	a069                	j	97a <vprintf+0x23a>
        }
      } else if(c == 'c'){
 8f2:	fdc42783          	lw	a5,-36(s0)
 8f6:	0007871b          	sext.w	a4,a5
 8fa:	06300793          	li	a5,99
 8fe:	02f71463          	bne	a4,a5,926 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 902:	fb843783          	ld	a5,-72(s0)
 906:	00878713          	addi	a4,a5,8
 90a:	fae43c23          	sd	a4,-72(s0)
 90e:	439c                	lw	a5,0(a5)
 910:	0ff7f713          	zext.b	a4,a5
 914:	fcc42783          	lw	a5,-52(s0)
 918:	85ba                	mv	a1,a4
 91a:	853e                	mv	a0,a5
 91c:	00000097          	auipc	ra,0x0
 920:	c5a080e7          	jalr	-934(ra) # 576 <putc>
 924:	a899                	j	97a <vprintf+0x23a>
      } else if(c == '%'){
 926:	fdc42783          	lw	a5,-36(s0)
 92a:	0007871b          	sext.w	a4,a5
 92e:	02500793          	li	a5,37
 932:	00f71f63          	bne	a4,a5,950 <vprintf+0x210>
        putc(fd, c);
 936:	fdc42783          	lw	a5,-36(s0)
 93a:	0ff7f713          	zext.b	a4,a5
 93e:	fcc42783          	lw	a5,-52(s0)
 942:	85ba                	mv	a1,a4
 944:	853e                	mv	a0,a5
 946:	00000097          	auipc	ra,0x0
 94a:	c30080e7          	jalr	-976(ra) # 576 <putc>
 94e:	a035                	j	97a <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 950:	fcc42783          	lw	a5,-52(s0)
 954:	02500593          	li	a1,37
 958:	853e                	mv	a0,a5
 95a:	00000097          	auipc	ra,0x0
 95e:	c1c080e7          	jalr	-996(ra) # 576 <putc>
        putc(fd, c);
 962:	fdc42783          	lw	a5,-36(s0)
 966:	0ff7f713          	zext.b	a4,a5
 96a:	fcc42783          	lw	a5,-52(s0)
 96e:	85ba                	mv	a1,a4
 970:	853e                	mv	a0,a5
 972:	00000097          	auipc	ra,0x0
 976:	c04080e7          	jalr	-1020(ra) # 576 <putc>
      }
      state = 0;
 97a:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 97e:	fe442783          	lw	a5,-28(s0)
 982:	2785                	addiw	a5,a5,1
 984:	fef42223          	sw	a5,-28(s0)
 988:	fe442783          	lw	a5,-28(s0)
 98c:	fc043703          	ld	a4,-64(s0)
 990:	97ba                	add	a5,a5,a4
 992:	0007c783          	lbu	a5,0(a5)
 996:	dc0795e3          	bnez	a5,760 <vprintf+0x20>
    }
  }
}
 99a:	0001                	nop
 99c:	0001                	nop
 99e:	60a6                	ld	ra,72(sp)
 9a0:	6406                	ld	s0,64(sp)
 9a2:	6161                	addi	sp,sp,80
 9a4:	8082                	ret

00000000000009a6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9a6:	7159                	addi	sp,sp,-112
 9a8:	fc06                	sd	ra,56(sp)
 9aa:	f822                	sd	s0,48(sp)
 9ac:	0080                	addi	s0,sp,64
 9ae:	fcb43823          	sd	a1,-48(s0)
 9b2:	e010                	sd	a2,0(s0)
 9b4:	e414                	sd	a3,8(s0)
 9b6:	e818                	sd	a4,16(s0)
 9b8:	ec1c                	sd	a5,24(s0)
 9ba:	03043023          	sd	a6,32(s0)
 9be:	03143423          	sd	a7,40(s0)
 9c2:	87aa                	mv	a5,a0
 9c4:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 9c8:	03040793          	addi	a5,s0,48
 9cc:	fcf43423          	sd	a5,-56(s0)
 9d0:	fc843783          	ld	a5,-56(s0)
 9d4:	fd078793          	addi	a5,a5,-48
 9d8:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 9dc:	fe843703          	ld	a4,-24(s0)
 9e0:	fdc42783          	lw	a5,-36(s0)
 9e4:	863a                	mv	a2,a4
 9e6:	fd043583          	ld	a1,-48(s0)
 9ea:	853e                	mv	a0,a5
 9ec:	00000097          	auipc	ra,0x0
 9f0:	d54080e7          	jalr	-684(ra) # 740 <vprintf>
}
 9f4:	0001                	nop
 9f6:	70e2                	ld	ra,56(sp)
 9f8:	7442                	ld	s0,48(sp)
 9fa:	6165                	addi	sp,sp,112
 9fc:	8082                	ret

00000000000009fe <printf>:

void
printf(const char *fmt, ...)
{
 9fe:	7159                	addi	sp,sp,-112
 a00:	f406                	sd	ra,40(sp)
 a02:	f022                	sd	s0,32(sp)
 a04:	1800                	addi	s0,sp,48
 a06:	fca43c23          	sd	a0,-40(s0)
 a0a:	e40c                	sd	a1,8(s0)
 a0c:	e810                	sd	a2,16(s0)
 a0e:	ec14                	sd	a3,24(s0)
 a10:	f018                	sd	a4,32(s0)
 a12:	f41c                	sd	a5,40(s0)
 a14:	03043823          	sd	a6,48(s0)
 a18:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a1c:	04040793          	addi	a5,s0,64
 a20:	fcf43823          	sd	a5,-48(s0)
 a24:	fd043783          	ld	a5,-48(s0)
 a28:	fc878793          	addi	a5,a5,-56
 a2c:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 a30:	fe843783          	ld	a5,-24(s0)
 a34:	863e                	mv	a2,a5
 a36:	fd843583          	ld	a1,-40(s0)
 a3a:	4505                	li	a0,1
 a3c:	00000097          	auipc	ra,0x0
 a40:	d04080e7          	jalr	-764(ra) # 740 <vprintf>
}
 a44:	0001                	nop
 a46:	70a2                	ld	ra,40(sp)
 a48:	7402                	ld	s0,32(sp)
 a4a:	6165                	addi	sp,sp,112
 a4c:	8082                	ret

0000000000000a4e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a4e:	7179                	addi	sp,sp,-48
 a50:	f422                	sd	s0,40(sp)
 a52:	1800                	addi	s0,sp,48
 a54:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a58:	fd843783          	ld	a5,-40(s0)
 a5c:	17c1                	addi	a5,a5,-16
 a5e:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a62:	00000797          	auipc	a5,0x0
 a66:	4a678793          	addi	a5,a5,1190 # f08 <freep>
 a6a:	639c                	ld	a5,0(a5)
 a6c:	fef43423          	sd	a5,-24(s0)
 a70:	a815                	j	aa4 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a72:	fe843783          	ld	a5,-24(s0)
 a76:	639c                	ld	a5,0(a5)
 a78:	fe843703          	ld	a4,-24(s0)
 a7c:	00f76f63          	bltu	a4,a5,a9a <free+0x4c>
 a80:	fe043703          	ld	a4,-32(s0)
 a84:	fe843783          	ld	a5,-24(s0)
 a88:	02e7eb63          	bltu	a5,a4,abe <free+0x70>
 a8c:	fe843783          	ld	a5,-24(s0)
 a90:	639c                	ld	a5,0(a5)
 a92:	fe043703          	ld	a4,-32(s0)
 a96:	02f76463          	bltu	a4,a5,abe <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a9a:	fe843783          	ld	a5,-24(s0)
 a9e:	639c                	ld	a5,0(a5)
 aa0:	fef43423          	sd	a5,-24(s0)
 aa4:	fe043703          	ld	a4,-32(s0)
 aa8:	fe843783          	ld	a5,-24(s0)
 aac:	fce7f3e3          	bgeu	a5,a4,a72 <free+0x24>
 ab0:	fe843783          	ld	a5,-24(s0)
 ab4:	639c                	ld	a5,0(a5)
 ab6:	fe043703          	ld	a4,-32(s0)
 aba:	faf77ce3          	bgeu	a4,a5,a72 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 abe:	fe043783          	ld	a5,-32(s0)
 ac2:	479c                	lw	a5,8(a5)
 ac4:	1782                	slli	a5,a5,0x20
 ac6:	9381                	srli	a5,a5,0x20
 ac8:	0792                	slli	a5,a5,0x4
 aca:	fe043703          	ld	a4,-32(s0)
 ace:	973e                	add	a4,a4,a5
 ad0:	fe843783          	ld	a5,-24(s0)
 ad4:	639c                	ld	a5,0(a5)
 ad6:	02f71763          	bne	a4,a5,b04 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 ada:	fe043783          	ld	a5,-32(s0)
 ade:	4798                	lw	a4,8(a5)
 ae0:	fe843783          	ld	a5,-24(s0)
 ae4:	639c                	ld	a5,0(a5)
 ae6:	479c                	lw	a5,8(a5)
 ae8:	9fb9                	addw	a5,a5,a4
 aea:	0007871b          	sext.w	a4,a5
 aee:	fe043783          	ld	a5,-32(s0)
 af2:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 af4:	fe843783          	ld	a5,-24(s0)
 af8:	639c                	ld	a5,0(a5)
 afa:	6398                	ld	a4,0(a5)
 afc:	fe043783          	ld	a5,-32(s0)
 b00:	e398                	sd	a4,0(a5)
 b02:	a039                	j	b10 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b04:	fe843783          	ld	a5,-24(s0)
 b08:	6398                	ld	a4,0(a5)
 b0a:	fe043783          	ld	a5,-32(s0)
 b0e:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b10:	fe843783          	ld	a5,-24(s0)
 b14:	479c                	lw	a5,8(a5)
 b16:	1782                	slli	a5,a5,0x20
 b18:	9381                	srli	a5,a5,0x20
 b1a:	0792                	slli	a5,a5,0x4
 b1c:	fe843703          	ld	a4,-24(s0)
 b20:	97ba                	add	a5,a5,a4
 b22:	fe043703          	ld	a4,-32(s0)
 b26:	02f71563          	bne	a4,a5,b50 <free+0x102>
    p->s.size += bp->s.size;
 b2a:	fe843783          	ld	a5,-24(s0)
 b2e:	4798                	lw	a4,8(a5)
 b30:	fe043783          	ld	a5,-32(s0)
 b34:	479c                	lw	a5,8(a5)
 b36:	9fb9                	addw	a5,a5,a4
 b38:	0007871b          	sext.w	a4,a5
 b3c:	fe843783          	ld	a5,-24(s0)
 b40:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b42:	fe043783          	ld	a5,-32(s0)
 b46:	6398                	ld	a4,0(a5)
 b48:	fe843783          	ld	a5,-24(s0)
 b4c:	e398                	sd	a4,0(a5)
 b4e:	a031                	j	b5a <free+0x10c>
  } else
    p->s.ptr = bp;
 b50:	fe843783          	ld	a5,-24(s0)
 b54:	fe043703          	ld	a4,-32(s0)
 b58:	e398                	sd	a4,0(a5)
  freep = p;
 b5a:	00000797          	auipc	a5,0x0
 b5e:	3ae78793          	addi	a5,a5,942 # f08 <freep>
 b62:	fe843703          	ld	a4,-24(s0)
 b66:	e398                	sd	a4,0(a5)
}
 b68:	0001                	nop
 b6a:	7422                	ld	s0,40(sp)
 b6c:	6145                	addi	sp,sp,48
 b6e:	8082                	ret

0000000000000b70 <morecore>:

static Header*
morecore(uint nu)
{
 b70:	7179                	addi	sp,sp,-48
 b72:	f406                	sd	ra,40(sp)
 b74:	f022                	sd	s0,32(sp)
 b76:	1800                	addi	s0,sp,48
 b78:	87aa                	mv	a5,a0
 b7a:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 b7e:	fdc42783          	lw	a5,-36(s0)
 b82:	0007871b          	sext.w	a4,a5
 b86:	6785                	lui	a5,0x1
 b88:	00f77563          	bgeu	a4,a5,b92 <morecore+0x22>
    nu = 4096;
 b8c:	6785                	lui	a5,0x1
 b8e:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 b92:	fdc42783          	lw	a5,-36(s0)
 b96:	0047979b          	slliw	a5,a5,0x4
 b9a:	2781                	sext.w	a5,a5
 b9c:	2781                	sext.w	a5,a5
 b9e:	853e                	mv	a0,a5
 ba0:	00000097          	auipc	ra,0x0
 ba4:	9ae080e7          	jalr	-1618(ra) # 54e <sbrk>
 ba8:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 bac:	fe843703          	ld	a4,-24(s0)
 bb0:	57fd                	li	a5,-1
 bb2:	00f71463          	bne	a4,a5,bba <morecore+0x4a>
    return 0;
 bb6:	4781                	li	a5,0
 bb8:	a03d                	j	be6 <morecore+0x76>
  hp = (Header*)p;
 bba:	fe843783          	ld	a5,-24(s0)
 bbe:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 bc2:	fe043783          	ld	a5,-32(s0)
 bc6:	fdc42703          	lw	a4,-36(s0)
 bca:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 bcc:	fe043783          	ld	a5,-32(s0)
 bd0:	07c1                	addi	a5,a5,16
 bd2:	853e                	mv	a0,a5
 bd4:	00000097          	auipc	ra,0x0
 bd8:	e7a080e7          	jalr	-390(ra) # a4e <free>
  return freep;
 bdc:	00000797          	auipc	a5,0x0
 be0:	32c78793          	addi	a5,a5,812 # f08 <freep>
 be4:	639c                	ld	a5,0(a5)
}
 be6:	853e                	mv	a0,a5
 be8:	70a2                	ld	ra,40(sp)
 bea:	7402                	ld	s0,32(sp)
 bec:	6145                	addi	sp,sp,48
 bee:	8082                	ret

0000000000000bf0 <malloc>:

void*
malloc(uint nbytes)
{
 bf0:	7139                	addi	sp,sp,-64
 bf2:	fc06                	sd	ra,56(sp)
 bf4:	f822                	sd	s0,48(sp)
 bf6:	0080                	addi	s0,sp,64
 bf8:	87aa                	mv	a5,a0
 bfa:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bfe:	fcc46783          	lwu	a5,-52(s0)
 c02:	07bd                	addi	a5,a5,15
 c04:	8391                	srli	a5,a5,0x4
 c06:	2781                	sext.w	a5,a5
 c08:	2785                	addiw	a5,a5,1
 c0a:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c0e:	00000797          	auipc	a5,0x0
 c12:	2fa78793          	addi	a5,a5,762 # f08 <freep>
 c16:	639c                	ld	a5,0(a5)
 c18:	fef43023          	sd	a5,-32(s0)
 c1c:	fe043783          	ld	a5,-32(s0)
 c20:	ef95                	bnez	a5,c5c <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c22:	00000797          	auipc	a5,0x0
 c26:	2d678793          	addi	a5,a5,726 # ef8 <base>
 c2a:	fef43023          	sd	a5,-32(s0)
 c2e:	00000797          	auipc	a5,0x0
 c32:	2da78793          	addi	a5,a5,730 # f08 <freep>
 c36:	fe043703          	ld	a4,-32(s0)
 c3a:	e398                	sd	a4,0(a5)
 c3c:	00000797          	auipc	a5,0x0
 c40:	2cc78793          	addi	a5,a5,716 # f08 <freep>
 c44:	6398                	ld	a4,0(a5)
 c46:	00000797          	auipc	a5,0x0
 c4a:	2b278793          	addi	a5,a5,690 # ef8 <base>
 c4e:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 c50:	00000797          	auipc	a5,0x0
 c54:	2a878793          	addi	a5,a5,680 # ef8 <base>
 c58:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c5c:	fe043783          	ld	a5,-32(s0)
 c60:	639c                	ld	a5,0(a5)
 c62:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 c66:	fe843783          	ld	a5,-24(s0)
 c6a:	4798                	lw	a4,8(a5)
 c6c:	fdc42783          	lw	a5,-36(s0)
 c70:	2781                	sext.w	a5,a5
 c72:	06f76763          	bltu	a4,a5,ce0 <malloc+0xf0>
      if(p->s.size == nunits)
 c76:	fe843783          	ld	a5,-24(s0)
 c7a:	4798                	lw	a4,8(a5)
 c7c:	fdc42783          	lw	a5,-36(s0)
 c80:	2781                	sext.w	a5,a5
 c82:	00e79963          	bne	a5,a4,c94 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 c86:	fe843783          	ld	a5,-24(s0)
 c8a:	6398                	ld	a4,0(a5)
 c8c:	fe043783          	ld	a5,-32(s0)
 c90:	e398                	sd	a4,0(a5)
 c92:	a825                	j	cca <malloc+0xda>
      else {
        p->s.size -= nunits;
 c94:	fe843783          	ld	a5,-24(s0)
 c98:	479c                	lw	a5,8(a5)
 c9a:	fdc42703          	lw	a4,-36(s0)
 c9e:	9f99                	subw	a5,a5,a4
 ca0:	0007871b          	sext.w	a4,a5
 ca4:	fe843783          	ld	a5,-24(s0)
 ca8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 caa:	fe843783          	ld	a5,-24(s0)
 cae:	479c                	lw	a5,8(a5)
 cb0:	1782                	slli	a5,a5,0x20
 cb2:	9381                	srli	a5,a5,0x20
 cb4:	0792                	slli	a5,a5,0x4
 cb6:	fe843703          	ld	a4,-24(s0)
 cba:	97ba                	add	a5,a5,a4
 cbc:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 cc0:	fe843783          	ld	a5,-24(s0)
 cc4:	fdc42703          	lw	a4,-36(s0)
 cc8:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 cca:	00000797          	auipc	a5,0x0
 cce:	23e78793          	addi	a5,a5,574 # f08 <freep>
 cd2:	fe043703          	ld	a4,-32(s0)
 cd6:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 cd8:	fe843783          	ld	a5,-24(s0)
 cdc:	07c1                	addi	a5,a5,16
 cde:	a091                	j	d22 <malloc+0x132>
    }
    if(p == freep)
 ce0:	00000797          	auipc	a5,0x0
 ce4:	22878793          	addi	a5,a5,552 # f08 <freep>
 ce8:	639c                	ld	a5,0(a5)
 cea:	fe843703          	ld	a4,-24(s0)
 cee:	02f71063          	bne	a4,a5,d0e <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 cf2:	fdc42783          	lw	a5,-36(s0)
 cf6:	853e                	mv	a0,a5
 cf8:	00000097          	auipc	ra,0x0
 cfc:	e78080e7          	jalr	-392(ra) # b70 <morecore>
 d00:	fea43423          	sd	a0,-24(s0)
 d04:	fe843783          	ld	a5,-24(s0)
 d08:	e399                	bnez	a5,d0e <malloc+0x11e>
        return 0;
 d0a:	4781                	li	a5,0
 d0c:	a819                	j	d22 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d0e:	fe843783          	ld	a5,-24(s0)
 d12:	fef43023          	sd	a5,-32(s0)
 d16:	fe843783          	ld	a5,-24(s0)
 d1a:	639c                	ld	a5,0(a5)
 d1c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d20:	b799                	j	c66 <malloc+0x76>
  }
}
 d22:	853e                	mv	a0,a5
 d24:	70e2                	ld	ra,56(sp)
 d26:	7442                	ld	s0,48(sp)
 d28:	6121                	addi	sp,sp,64
 d2a:	8082                	ret

0000000000000d2c <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
 d2c:	7179                	addi	sp,sp,-48
 d2e:	f406                	sd	ra,40(sp)
 d30:	f022                	sd	s0,32(sp)
 d32:	1800                	addi	s0,sp,48
 d34:	fca43c23          	sd	a0,-40(s0)
 d38:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
 d3c:	6505                	lui	a0,0x1
 d3e:	00000097          	auipc	ra,0x0
 d42:	eb2080e7          	jalr	-334(ra) # bf0 <malloc>
 d46:	fea43423          	sd	a0,-24(s0)
 d4a:	fe843783          	ld	a5,-24(s0)
 d4e:	e38d                	bnez	a5,d70 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
 d50:	00000517          	auipc	a0,0x0
 d54:	14050513          	addi	a0,a0,320 # e90 <lock_init+0x5a>
 d58:	00000097          	auipc	ra,0x0
 d5c:	ca6080e7          	jalr	-858(ra) # 9fe <printf>
        free(stack);
 d60:	fe843503          	ld	a0,-24(s0)
 d64:	00000097          	auipc	ra,0x0
 d68:	cea080e7          	jalr	-790(ra) # a4e <free>
        return -1;
 d6c:	57fd                	li	a5,-1
 d6e:	a099                	j	db4 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
 d70:	fe843783          	ld	a5,-24(s0)
 d74:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
 d78:	fe043703          	ld	a4,-32(s0)
 d7c:	6785                	lui	a5,0x1
 d7e:	17fd                	addi	a5,a5,-1
 d80:	8ff9                	and	a5,a5,a4
 d82:	cf91                	beqz	a5,d9e <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
 d84:	fe043703          	ld	a4,-32(s0)
 d88:	6785                	lui	a5,0x1
 d8a:	17fd                	addi	a5,a5,-1
 d8c:	8ff9                	and	a5,a5,a4
 d8e:	6705                	lui	a4,0x1
 d90:	40f707b3          	sub	a5,a4,a5
 d94:	fe843703          	ld	a4,-24(s0)
 d98:	97ba                	add	a5,a5,a4
 d9a:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
 d9e:	fe843603          	ld	a2,-24(s0)
 da2:	fd043583          	ld	a1,-48(s0)
 da6:	fd843503          	ld	a0,-40(s0)
 daa:	fffff097          	auipc	ra,0xfffff
 dae:	7bc080e7          	jalr	1980(ra) # 566 <clone>
 db2:	87aa                	mv	a5,a0
}
 db4:	853e                	mv	a0,a5
 db6:	70a2                	ld	ra,40(sp)
 db8:	7402                	ld	s0,32(sp)
 dba:	6145                	addi	sp,sp,48
 dbc:	8082                	ret

0000000000000dbe <thread_join>:


int thread_join()
{
 dbe:	1101                	addi	sp,sp,-32
 dc0:	ec06                	sd	ra,24(sp)
 dc2:	e822                	sd	s0,16(sp)
 dc4:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
 dc6:	fe040793          	addi	a5,s0,-32
 dca:	853e                	mv	a0,a5
 dcc:	fffff097          	auipc	ra,0xfffff
 dd0:	7a2080e7          	jalr	1954(ra) # 56e <join>
 dd4:	87aa                	mv	a5,a0
 dd6:	fef42623          	sw	a5,-20(s0)
 dda:	fec42783          	lw	a5,-20(s0)
 dde:	0007871b          	sext.w	a4,a5
 de2:	57fd                	li	a5,-1
 de4:	00f70963          	beq	a4,a5,df6 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
 de8:	fe043783          	ld	a5,-32(s0)
 dec:	853e                	mv	a0,a5
 dee:	00000097          	auipc	ra,0x0
 df2:	c60080e7          	jalr	-928(ra) # a4e <free>
    } 

    return child_tid;
 df6:	fec42783          	lw	a5,-20(s0)
}
 dfa:	853e                	mv	a0,a5
 dfc:	60e2                	ld	ra,24(sp)
 dfe:	6442                	ld	s0,16(sp)
 e00:	6105                	addi	sp,sp,32
 e02:	8082                	ret

0000000000000e04 <lock_acquire>:


void lock_acquire (lock_t *lock)
{
 e04:	1101                	addi	sp,sp,-32
 e06:	ec22                	sd	s0,24(sp)
 e08:	1000                	addi	s0,sp,32
 e0a:	fea43423          	sd	a0,-24(s0)
        lock = 0;
 e0e:	fe043423          	sd	zero,-24(s0)

}
 e12:	0001                	nop
 e14:	6462                	ld	s0,24(sp)
 e16:	6105                	addi	sp,sp,32
 e18:	8082                	ret

0000000000000e1a <lock_release>:

void lock_release (lock_t *lock)
{
 e1a:	1101                	addi	sp,sp,-32
 e1c:	ec22                	sd	s0,24(sp)
 e1e:	1000                	addi	s0,sp,32
 e20:	fea43423          	sd	a0,-24(s0)
        __sync_lock_test_and_set(lock, 1);
 e24:	fe843783          	ld	a5,-24(s0)
 e28:	4705                	li	a4,1
 e2a:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    
}
 e2e:	0001                	nop
 e30:	6462                	ld	s0,24(sp)
 e32:	6105                	addi	sp,sp,32
 e34:	8082                	ret

0000000000000e36 <lock_init>:

void lock_init (lock_t *lock)
{
 e36:	1101                	addi	sp,sp,-32
 e38:	ec22                	sd	s0,24(sp)
 e3a:	1000                	addi	s0,sp,32
 e3c:	fea43423          	sd	a0,-24(s0)
    lock = 0;
 e40:	fe043423          	sd	zero,-24(s0)
    
}
 e44:	0001                	nop
 e46:	6462                	ld	s0,24(sp)
 e48:	6105                	addi	sp,sp,32
 e4a:	8082                	ret
