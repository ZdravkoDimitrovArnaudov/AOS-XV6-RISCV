
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
  16:	d2658593          	addi	a1,a1,-730 # d38 <malloc+0x144>
  1a:	00001517          	auipc	a0,0x1
  1e:	d4e50513          	addi	a0,a0,-690 # d68 <malloc+0x174>
  22:	00001097          	auipc	ra,0x1
  26:	9e0080e7          	jalr	-1568(ra) # a02 <printf>
  exit(0);
  2a:	4501                	li	a0,0
  2c:	00000097          	auipc	ra,0x0
  30:	498080e7          	jalr	1176(ra) # 4c4 <exit>

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
 14e:	0ff77713          	andi	a4,a4,255
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
 198:	0ff7f793          	andi	a5,a5,255
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
 1ea:	2f6080e7          	jalr	758(ra) # 4dc <read>
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
 280:	288080e7          	jalr	648(ra) # 504 <open>
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
 2a6:	27a080e7          	jalr	634(ra) # 51c <fstat>
 2aa:	87aa                	mv	a5,a0
 2ac:	fef42423          	sw	a5,-24(s0)
  close(fd);
 2b0:	fec42783          	lw	a5,-20(s0)
 2b4:	853e                	mv	a0,a5
 2b6:	00000097          	auipc	ra,0x0
 2ba:	236080e7          	jalr	566(ra) # 4ec <close>
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
 2da:	a815                	j	30e <atoi+0x42>
    n = n*10 + *s++ - '0';
 2dc:	fec42703          	lw	a4,-20(s0)
 2e0:	87ba                	mv	a5,a4
 2e2:	0027979b          	slliw	a5,a5,0x2
 2e6:	9fb9                	addw	a5,a5,a4
 2e8:	0017979b          	slliw	a5,a5,0x1
 2ec:	0007871b          	sext.w	a4,a5
 2f0:	fd843783          	ld	a5,-40(s0)
 2f4:	00178693          	addi	a3,a5,1
 2f8:	fcd43c23          	sd	a3,-40(s0)
 2fc:	0007c783          	lbu	a5,0(a5)
 300:	2781                	sext.w	a5,a5
 302:	9fb9                	addw	a5,a5,a4
 304:	2781                	sext.w	a5,a5
 306:	fd07879b          	addiw	a5,a5,-48
 30a:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 30e:	fd843783          	ld	a5,-40(s0)
 312:	0007c783          	lbu	a5,0(a5)
 316:	873e                	mv	a4,a5
 318:	02f00793          	li	a5,47
 31c:	00e7fb63          	bgeu	a5,a4,332 <atoi+0x66>
 320:	fd843783          	ld	a5,-40(s0)
 324:	0007c783          	lbu	a5,0(a5)
 328:	873e                	mv	a4,a5
 32a:	03900793          	li	a5,57
 32e:	fae7f7e3          	bgeu	a5,a4,2dc <atoi+0x10>
  return n;
 332:	fec42783          	lw	a5,-20(s0)
}
 336:	853e                	mv	a0,a5
 338:	7422                	ld	s0,40(sp)
 33a:	6145                	addi	sp,sp,48
 33c:	8082                	ret

000000000000033e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 33e:	7139                	addi	sp,sp,-64
 340:	fc22                	sd	s0,56(sp)
 342:	0080                	addi	s0,sp,64
 344:	fca43c23          	sd	a0,-40(s0)
 348:	fcb43823          	sd	a1,-48(s0)
 34c:	87b2                	mv	a5,a2
 34e:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 352:	fd843783          	ld	a5,-40(s0)
 356:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 35a:	fd043783          	ld	a5,-48(s0)
 35e:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 362:	fe043703          	ld	a4,-32(s0)
 366:	fe843783          	ld	a5,-24(s0)
 36a:	02e7fc63          	bgeu	a5,a4,3a2 <memmove+0x64>
    while(n-- > 0)
 36e:	a00d                	j	390 <memmove+0x52>
      *dst++ = *src++;
 370:	fe043703          	ld	a4,-32(s0)
 374:	00170793          	addi	a5,a4,1
 378:	fef43023          	sd	a5,-32(s0)
 37c:	fe843783          	ld	a5,-24(s0)
 380:	00178693          	addi	a3,a5,1
 384:	fed43423          	sd	a3,-24(s0)
 388:	00074703          	lbu	a4,0(a4)
 38c:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 390:	fcc42783          	lw	a5,-52(s0)
 394:	fff7871b          	addiw	a4,a5,-1
 398:	fce42623          	sw	a4,-52(s0)
 39c:	fcf04ae3          	bgtz	a5,370 <memmove+0x32>
 3a0:	a891                	j	3f4 <memmove+0xb6>
  } else {
    dst += n;
 3a2:	fcc42783          	lw	a5,-52(s0)
 3a6:	fe843703          	ld	a4,-24(s0)
 3aa:	97ba                	add	a5,a5,a4
 3ac:	fef43423          	sd	a5,-24(s0)
    src += n;
 3b0:	fcc42783          	lw	a5,-52(s0)
 3b4:	fe043703          	ld	a4,-32(s0)
 3b8:	97ba                	add	a5,a5,a4
 3ba:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 3be:	a01d                	j	3e4 <memmove+0xa6>
      *--dst = *--src;
 3c0:	fe043783          	ld	a5,-32(s0)
 3c4:	17fd                	addi	a5,a5,-1
 3c6:	fef43023          	sd	a5,-32(s0)
 3ca:	fe843783          	ld	a5,-24(s0)
 3ce:	17fd                	addi	a5,a5,-1
 3d0:	fef43423          	sd	a5,-24(s0)
 3d4:	fe043783          	ld	a5,-32(s0)
 3d8:	0007c703          	lbu	a4,0(a5)
 3dc:	fe843783          	ld	a5,-24(s0)
 3e0:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3e4:	fcc42783          	lw	a5,-52(s0)
 3e8:	fff7871b          	addiw	a4,a5,-1
 3ec:	fce42623          	sw	a4,-52(s0)
 3f0:	fcf048e3          	bgtz	a5,3c0 <memmove+0x82>
  }
  return vdst;
 3f4:	fd843783          	ld	a5,-40(s0)
}
 3f8:	853e                	mv	a0,a5
 3fa:	7462                	ld	s0,56(sp)
 3fc:	6121                	addi	sp,sp,64
 3fe:	8082                	ret

0000000000000400 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 400:	7139                	addi	sp,sp,-64
 402:	fc22                	sd	s0,56(sp)
 404:	0080                	addi	s0,sp,64
 406:	fca43c23          	sd	a0,-40(s0)
 40a:	fcb43823          	sd	a1,-48(s0)
 40e:	87b2                	mv	a5,a2
 410:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 414:	fd843783          	ld	a5,-40(s0)
 418:	fef43423          	sd	a5,-24(s0)
 41c:	fd043783          	ld	a5,-48(s0)
 420:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 424:	a0a1                	j	46c <memcmp+0x6c>
    if (*p1 != *p2) {
 426:	fe843783          	ld	a5,-24(s0)
 42a:	0007c703          	lbu	a4,0(a5)
 42e:	fe043783          	ld	a5,-32(s0)
 432:	0007c783          	lbu	a5,0(a5)
 436:	02f70163          	beq	a4,a5,458 <memcmp+0x58>
      return *p1 - *p2;
 43a:	fe843783          	ld	a5,-24(s0)
 43e:	0007c783          	lbu	a5,0(a5)
 442:	0007871b          	sext.w	a4,a5
 446:	fe043783          	ld	a5,-32(s0)
 44a:	0007c783          	lbu	a5,0(a5)
 44e:	2781                	sext.w	a5,a5
 450:	40f707bb          	subw	a5,a4,a5
 454:	2781                	sext.w	a5,a5
 456:	a01d                	j	47c <memcmp+0x7c>
    }
    p1++;
 458:	fe843783          	ld	a5,-24(s0)
 45c:	0785                	addi	a5,a5,1
 45e:	fef43423          	sd	a5,-24(s0)
    p2++;
 462:	fe043783          	ld	a5,-32(s0)
 466:	0785                	addi	a5,a5,1
 468:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 46c:	fcc42783          	lw	a5,-52(s0)
 470:	fff7871b          	addiw	a4,a5,-1
 474:	fce42623          	sw	a4,-52(s0)
 478:	f7dd                	bnez	a5,426 <memcmp+0x26>
  }
  return 0;
 47a:	4781                	li	a5,0
}
 47c:	853e                	mv	a0,a5
 47e:	7462                	ld	s0,56(sp)
 480:	6121                	addi	sp,sp,64
 482:	8082                	ret

0000000000000484 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 484:	7179                	addi	sp,sp,-48
 486:	f406                	sd	ra,40(sp)
 488:	f022                	sd	s0,32(sp)
 48a:	1800                	addi	s0,sp,48
 48c:	fea43423          	sd	a0,-24(s0)
 490:	feb43023          	sd	a1,-32(s0)
 494:	87b2                	mv	a5,a2
 496:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 49a:	fdc42783          	lw	a5,-36(s0)
 49e:	863e                	mv	a2,a5
 4a0:	fe043583          	ld	a1,-32(s0)
 4a4:	fe843503          	ld	a0,-24(s0)
 4a8:	00000097          	auipc	ra,0x0
 4ac:	e96080e7          	jalr	-362(ra) # 33e <memmove>
 4b0:	87aa                	mv	a5,a0
}
 4b2:	853e                	mv	a0,a5
 4b4:	70a2                	ld	ra,40(sp)
 4b6:	7402                	ld	s0,32(sp)
 4b8:	6145                	addi	sp,sp,48
 4ba:	8082                	ret

00000000000004bc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4bc:	4885                	li	a7,1
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4c4:	4889                	li	a7,2
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <wait>:
.global wait
wait:
 li a7, SYS_wait
 4cc:	488d                	li	a7,3
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4d4:	4891                	li	a7,4
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <read>:
.global read
read:
 li a7, SYS_read
 4dc:	4895                	li	a7,5
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <write>:
.global write
write:
 li a7, SYS_write
 4e4:	48c1                	li	a7,16
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <close>:
.global close
close:
 li a7, SYS_close
 4ec:	48d5                	li	a7,21
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4f4:	4899                	li	a7,6
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <exec>:
.global exec
exec:
 li a7, SYS_exec
 4fc:	489d                	li	a7,7
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <open>:
.global open
open:
 li a7, SYS_open
 504:	48bd                	li	a7,15
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 50c:	48c5                	li	a7,17
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 514:	48c9                	li	a7,18
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 51c:	48a1                	li	a7,8
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <link>:
.global link
link:
 li a7, SYS_link
 524:	48cd                	li	a7,19
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 52c:	48d1                	li	a7,20
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 534:	48a5                	li	a7,9
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <dup>:
.global dup
dup:
 li a7, SYS_dup
 53c:	48a9                	li	a7,10
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 544:	48ad                	li	a7,11
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 54c:	48b1                	li	a7,12
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 554:	48b5                	li	a7,13
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 55c:	48b9                	li	a7,14
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 564:	48d9                	li	a7,22
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <setpri>:
.global setpri
setpri:
 li a7, SYS_setpri
 56c:	48dd                	li	a7,23
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 574:	1101                	addi	sp,sp,-32
 576:	ec06                	sd	ra,24(sp)
 578:	e822                	sd	s0,16(sp)
 57a:	1000                	addi	s0,sp,32
 57c:	87aa                	mv	a5,a0
 57e:	872e                	mv	a4,a1
 580:	fef42623          	sw	a5,-20(s0)
 584:	87ba                	mv	a5,a4
 586:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 58a:	feb40713          	addi	a4,s0,-21
 58e:	fec42783          	lw	a5,-20(s0)
 592:	4605                	li	a2,1
 594:	85ba                	mv	a1,a4
 596:	853e                	mv	a0,a5
 598:	00000097          	auipc	ra,0x0
 59c:	f4c080e7          	jalr	-180(ra) # 4e4 <write>
}
 5a0:	0001                	nop
 5a2:	60e2                	ld	ra,24(sp)
 5a4:	6442                	ld	s0,16(sp)
 5a6:	6105                	addi	sp,sp,32
 5a8:	8082                	ret

00000000000005aa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5aa:	7139                	addi	sp,sp,-64
 5ac:	fc06                	sd	ra,56(sp)
 5ae:	f822                	sd	s0,48(sp)
 5b0:	0080                	addi	s0,sp,64
 5b2:	87aa                	mv	a5,a0
 5b4:	8736                	mv	a4,a3
 5b6:	fcf42623          	sw	a5,-52(s0)
 5ba:	87ae                	mv	a5,a1
 5bc:	fcf42423          	sw	a5,-56(s0)
 5c0:	87b2                	mv	a5,a2
 5c2:	fcf42223          	sw	a5,-60(s0)
 5c6:	87ba                	mv	a5,a4
 5c8:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5cc:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 5d0:	fc042783          	lw	a5,-64(s0)
 5d4:	2781                	sext.w	a5,a5
 5d6:	c38d                	beqz	a5,5f8 <printint+0x4e>
 5d8:	fc842783          	lw	a5,-56(s0)
 5dc:	2781                	sext.w	a5,a5
 5de:	0007dd63          	bgez	a5,5f8 <printint+0x4e>
    neg = 1;
 5e2:	4785                	li	a5,1
 5e4:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 5e8:	fc842783          	lw	a5,-56(s0)
 5ec:	40f007bb          	negw	a5,a5
 5f0:	2781                	sext.w	a5,a5
 5f2:	fef42223          	sw	a5,-28(s0)
 5f6:	a029                	j	600 <printint+0x56>
  } else {
    x = xx;
 5f8:	fc842783          	lw	a5,-56(s0)
 5fc:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 600:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 604:	fc442783          	lw	a5,-60(s0)
 608:	fe442703          	lw	a4,-28(s0)
 60c:	02f777bb          	remuw	a5,a4,a5
 610:	0007861b          	sext.w	a2,a5
 614:	fec42783          	lw	a5,-20(s0)
 618:	0017871b          	addiw	a4,a5,1
 61c:	fee42623          	sw	a4,-20(s0)
 620:	00000697          	auipc	a3,0x0
 624:	75868693          	addi	a3,a3,1880 # d78 <digits>
 628:	02061713          	slli	a4,a2,0x20
 62c:	9301                	srli	a4,a4,0x20
 62e:	9736                	add	a4,a4,a3
 630:	00074703          	lbu	a4,0(a4)
 634:	ff040693          	addi	a3,s0,-16
 638:	97b6                	add	a5,a5,a3
 63a:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 63e:	fc442783          	lw	a5,-60(s0)
 642:	fe442703          	lw	a4,-28(s0)
 646:	02f757bb          	divuw	a5,a4,a5
 64a:	fef42223          	sw	a5,-28(s0)
 64e:	fe442783          	lw	a5,-28(s0)
 652:	2781                	sext.w	a5,a5
 654:	fbc5                	bnez	a5,604 <printint+0x5a>
  if(neg)
 656:	fe842783          	lw	a5,-24(s0)
 65a:	2781                	sext.w	a5,a5
 65c:	cf95                	beqz	a5,698 <printint+0xee>
    buf[i++] = '-';
 65e:	fec42783          	lw	a5,-20(s0)
 662:	0017871b          	addiw	a4,a5,1
 666:	fee42623          	sw	a4,-20(s0)
 66a:	ff040713          	addi	a4,s0,-16
 66e:	97ba                	add	a5,a5,a4
 670:	02d00713          	li	a4,45
 674:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 678:	a005                	j	698 <printint+0xee>
    putc(fd, buf[i]);
 67a:	fec42783          	lw	a5,-20(s0)
 67e:	ff040713          	addi	a4,s0,-16
 682:	97ba                	add	a5,a5,a4
 684:	fe07c703          	lbu	a4,-32(a5)
 688:	fcc42783          	lw	a5,-52(s0)
 68c:	85ba                	mv	a1,a4
 68e:	853e                	mv	a0,a5
 690:	00000097          	auipc	ra,0x0
 694:	ee4080e7          	jalr	-284(ra) # 574 <putc>
  while(--i >= 0)
 698:	fec42783          	lw	a5,-20(s0)
 69c:	37fd                	addiw	a5,a5,-1
 69e:	fef42623          	sw	a5,-20(s0)
 6a2:	fec42783          	lw	a5,-20(s0)
 6a6:	2781                	sext.w	a5,a5
 6a8:	fc07d9e3          	bgez	a5,67a <printint+0xd0>
}
 6ac:	0001                	nop
 6ae:	0001                	nop
 6b0:	70e2                	ld	ra,56(sp)
 6b2:	7442                	ld	s0,48(sp)
 6b4:	6121                	addi	sp,sp,64
 6b6:	8082                	ret

00000000000006b8 <printptr>:

static void
printptr(int fd, uint64 x) {
 6b8:	7179                	addi	sp,sp,-48
 6ba:	f406                	sd	ra,40(sp)
 6bc:	f022                	sd	s0,32(sp)
 6be:	1800                	addi	s0,sp,48
 6c0:	87aa                	mv	a5,a0
 6c2:	fcb43823          	sd	a1,-48(s0)
 6c6:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 6ca:	fdc42783          	lw	a5,-36(s0)
 6ce:	03000593          	li	a1,48
 6d2:	853e                	mv	a0,a5
 6d4:	00000097          	auipc	ra,0x0
 6d8:	ea0080e7          	jalr	-352(ra) # 574 <putc>
  putc(fd, 'x');
 6dc:	fdc42783          	lw	a5,-36(s0)
 6e0:	07800593          	li	a1,120
 6e4:	853e                	mv	a0,a5
 6e6:	00000097          	auipc	ra,0x0
 6ea:	e8e080e7          	jalr	-370(ra) # 574 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6ee:	fe042623          	sw	zero,-20(s0)
 6f2:	a82d                	j	72c <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6f4:	fd043783          	ld	a5,-48(s0)
 6f8:	93f1                	srli	a5,a5,0x3c
 6fa:	00000717          	auipc	a4,0x0
 6fe:	67e70713          	addi	a4,a4,1662 # d78 <digits>
 702:	97ba                	add	a5,a5,a4
 704:	0007c703          	lbu	a4,0(a5)
 708:	fdc42783          	lw	a5,-36(s0)
 70c:	85ba                	mv	a1,a4
 70e:	853e                	mv	a0,a5
 710:	00000097          	auipc	ra,0x0
 714:	e64080e7          	jalr	-412(ra) # 574 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 718:	fec42783          	lw	a5,-20(s0)
 71c:	2785                	addiw	a5,a5,1
 71e:	fef42623          	sw	a5,-20(s0)
 722:	fd043783          	ld	a5,-48(s0)
 726:	0792                	slli	a5,a5,0x4
 728:	fcf43823          	sd	a5,-48(s0)
 72c:	fec42783          	lw	a5,-20(s0)
 730:	873e                	mv	a4,a5
 732:	47bd                	li	a5,15
 734:	fce7f0e3          	bgeu	a5,a4,6f4 <printptr+0x3c>
}
 738:	0001                	nop
 73a:	0001                	nop
 73c:	70a2                	ld	ra,40(sp)
 73e:	7402                	ld	s0,32(sp)
 740:	6145                	addi	sp,sp,48
 742:	8082                	ret

0000000000000744 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 744:	715d                	addi	sp,sp,-80
 746:	e486                	sd	ra,72(sp)
 748:	e0a2                	sd	s0,64(sp)
 74a:	0880                	addi	s0,sp,80
 74c:	87aa                	mv	a5,a0
 74e:	fcb43023          	sd	a1,-64(s0)
 752:	fac43c23          	sd	a2,-72(s0)
 756:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 75a:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 75e:	fe042223          	sw	zero,-28(s0)
 762:	a42d                	j	98c <vprintf+0x248>
    c = fmt[i] & 0xff;
 764:	fe442783          	lw	a5,-28(s0)
 768:	fc043703          	ld	a4,-64(s0)
 76c:	97ba                	add	a5,a5,a4
 76e:	0007c783          	lbu	a5,0(a5)
 772:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 776:	fe042783          	lw	a5,-32(s0)
 77a:	2781                	sext.w	a5,a5
 77c:	eb9d                	bnez	a5,7b2 <vprintf+0x6e>
      if(c == '%'){
 77e:	fdc42783          	lw	a5,-36(s0)
 782:	0007871b          	sext.w	a4,a5
 786:	02500793          	li	a5,37
 78a:	00f71763          	bne	a4,a5,798 <vprintf+0x54>
        state = '%';
 78e:	02500793          	li	a5,37
 792:	fef42023          	sw	a5,-32(s0)
 796:	a2f5                	j	982 <vprintf+0x23e>
      } else {
        putc(fd, c);
 798:	fdc42783          	lw	a5,-36(s0)
 79c:	0ff7f713          	andi	a4,a5,255
 7a0:	fcc42783          	lw	a5,-52(s0)
 7a4:	85ba                	mv	a1,a4
 7a6:	853e                	mv	a0,a5
 7a8:	00000097          	auipc	ra,0x0
 7ac:	dcc080e7          	jalr	-564(ra) # 574 <putc>
 7b0:	aac9                	j	982 <vprintf+0x23e>
      }
    } else if(state == '%'){
 7b2:	fe042783          	lw	a5,-32(s0)
 7b6:	0007871b          	sext.w	a4,a5
 7ba:	02500793          	li	a5,37
 7be:	1cf71263          	bne	a4,a5,982 <vprintf+0x23e>
      if(c == 'd'){
 7c2:	fdc42783          	lw	a5,-36(s0)
 7c6:	0007871b          	sext.w	a4,a5
 7ca:	06400793          	li	a5,100
 7ce:	02f71463          	bne	a4,a5,7f6 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 7d2:	fb843783          	ld	a5,-72(s0)
 7d6:	00878713          	addi	a4,a5,8
 7da:	fae43c23          	sd	a4,-72(s0)
 7de:	4398                	lw	a4,0(a5)
 7e0:	fcc42783          	lw	a5,-52(s0)
 7e4:	4685                	li	a3,1
 7e6:	4629                	li	a2,10
 7e8:	85ba                	mv	a1,a4
 7ea:	853e                	mv	a0,a5
 7ec:	00000097          	auipc	ra,0x0
 7f0:	dbe080e7          	jalr	-578(ra) # 5aa <printint>
 7f4:	a269                	j	97e <vprintf+0x23a>
      } else if(c == 'l') {
 7f6:	fdc42783          	lw	a5,-36(s0)
 7fa:	0007871b          	sext.w	a4,a5
 7fe:	06c00793          	li	a5,108
 802:	02f71663          	bne	a4,a5,82e <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 806:	fb843783          	ld	a5,-72(s0)
 80a:	00878713          	addi	a4,a5,8
 80e:	fae43c23          	sd	a4,-72(s0)
 812:	639c                	ld	a5,0(a5)
 814:	0007871b          	sext.w	a4,a5
 818:	fcc42783          	lw	a5,-52(s0)
 81c:	4681                	li	a3,0
 81e:	4629                	li	a2,10
 820:	85ba                	mv	a1,a4
 822:	853e                	mv	a0,a5
 824:	00000097          	auipc	ra,0x0
 828:	d86080e7          	jalr	-634(ra) # 5aa <printint>
 82c:	aa89                	j	97e <vprintf+0x23a>
      } else if(c == 'x') {
 82e:	fdc42783          	lw	a5,-36(s0)
 832:	0007871b          	sext.w	a4,a5
 836:	07800793          	li	a5,120
 83a:	02f71463          	bne	a4,a5,862 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 83e:	fb843783          	ld	a5,-72(s0)
 842:	00878713          	addi	a4,a5,8
 846:	fae43c23          	sd	a4,-72(s0)
 84a:	4398                	lw	a4,0(a5)
 84c:	fcc42783          	lw	a5,-52(s0)
 850:	4681                	li	a3,0
 852:	4641                	li	a2,16
 854:	85ba                	mv	a1,a4
 856:	853e                	mv	a0,a5
 858:	00000097          	auipc	ra,0x0
 85c:	d52080e7          	jalr	-686(ra) # 5aa <printint>
 860:	aa39                	j	97e <vprintf+0x23a>
      } else if(c == 'p') {
 862:	fdc42783          	lw	a5,-36(s0)
 866:	0007871b          	sext.w	a4,a5
 86a:	07000793          	li	a5,112
 86e:	02f71263          	bne	a4,a5,892 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 872:	fb843783          	ld	a5,-72(s0)
 876:	00878713          	addi	a4,a5,8
 87a:	fae43c23          	sd	a4,-72(s0)
 87e:	6398                	ld	a4,0(a5)
 880:	fcc42783          	lw	a5,-52(s0)
 884:	85ba                	mv	a1,a4
 886:	853e                	mv	a0,a5
 888:	00000097          	auipc	ra,0x0
 88c:	e30080e7          	jalr	-464(ra) # 6b8 <printptr>
 890:	a0fd                	j	97e <vprintf+0x23a>
      } else if(c == 's'){
 892:	fdc42783          	lw	a5,-36(s0)
 896:	0007871b          	sext.w	a4,a5
 89a:	07300793          	li	a5,115
 89e:	04f71c63          	bne	a4,a5,8f6 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 8a2:	fb843783          	ld	a5,-72(s0)
 8a6:	00878713          	addi	a4,a5,8
 8aa:	fae43c23          	sd	a4,-72(s0)
 8ae:	639c                	ld	a5,0(a5)
 8b0:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 8b4:	fe843783          	ld	a5,-24(s0)
 8b8:	eb8d                	bnez	a5,8ea <vprintf+0x1a6>
          s = "(null)";
 8ba:	00000797          	auipc	a5,0x0
 8be:	4b678793          	addi	a5,a5,1206 # d70 <malloc+0x17c>
 8c2:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 8c6:	a015                	j	8ea <vprintf+0x1a6>
          putc(fd, *s);
 8c8:	fe843783          	ld	a5,-24(s0)
 8cc:	0007c703          	lbu	a4,0(a5)
 8d0:	fcc42783          	lw	a5,-52(s0)
 8d4:	85ba                	mv	a1,a4
 8d6:	853e                	mv	a0,a5
 8d8:	00000097          	auipc	ra,0x0
 8dc:	c9c080e7          	jalr	-868(ra) # 574 <putc>
          s++;
 8e0:	fe843783          	ld	a5,-24(s0)
 8e4:	0785                	addi	a5,a5,1
 8e6:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 8ea:	fe843783          	ld	a5,-24(s0)
 8ee:	0007c783          	lbu	a5,0(a5)
 8f2:	fbf9                	bnez	a5,8c8 <vprintf+0x184>
 8f4:	a069                	j	97e <vprintf+0x23a>
        }
      } else if(c == 'c'){
 8f6:	fdc42783          	lw	a5,-36(s0)
 8fa:	0007871b          	sext.w	a4,a5
 8fe:	06300793          	li	a5,99
 902:	02f71463          	bne	a4,a5,92a <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 906:	fb843783          	ld	a5,-72(s0)
 90a:	00878713          	addi	a4,a5,8
 90e:	fae43c23          	sd	a4,-72(s0)
 912:	439c                	lw	a5,0(a5)
 914:	0ff7f713          	andi	a4,a5,255
 918:	fcc42783          	lw	a5,-52(s0)
 91c:	85ba                	mv	a1,a4
 91e:	853e                	mv	a0,a5
 920:	00000097          	auipc	ra,0x0
 924:	c54080e7          	jalr	-940(ra) # 574 <putc>
 928:	a899                	j	97e <vprintf+0x23a>
      } else if(c == '%'){
 92a:	fdc42783          	lw	a5,-36(s0)
 92e:	0007871b          	sext.w	a4,a5
 932:	02500793          	li	a5,37
 936:	00f71f63          	bne	a4,a5,954 <vprintf+0x210>
        putc(fd, c);
 93a:	fdc42783          	lw	a5,-36(s0)
 93e:	0ff7f713          	andi	a4,a5,255
 942:	fcc42783          	lw	a5,-52(s0)
 946:	85ba                	mv	a1,a4
 948:	853e                	mv	a0,a5
 94a:	00000097          	auipc	ra,0x0
 94e:	c2a080e7          	jalr	-982(ra) # 574 <putc>
 952:	a035                	j	97e <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 954:	fcc42783          	lw	a5,-52(s0)
 958:	02500593          	li	a1,37
 95c:	853e                	mv	a0,a5
 95e:	00000097          	auipc	ra,0x0
 962:	c16080e7          	jalr	-1002(ra) # 574 <putc>
        putc(fd, c);
 966:	fdc42783          	lw	a5,-36(s0)
 96a:	0ff7f713          	andi	a4,a5,255
 96e:	fcc42783          	lw	a5,-52(s0)
 972:	85ba                	mv	a1,a4
 974:	853e                	mv	a0,a5
 976:	00000097          	auipc	ra,0x0
 97a:	bfe080e7          	jalr	-1026(ra) # 574 <putc>
      }
      state = 0;
 97e:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 982:	fe442783          	lw	a5,-28(s0)
 986:	2785                	addiw	a5,a5,1
 988:	fef42223          	sw	a5,-28(s0)
 98c:	fe442783          	lw	a5,-28(s0)
 990:	fc043703          	ld	a4,-64(s0)
 994:	97ba                	add	a5,a5,a4
 996:	0007c783          	lbu	a5,0(a5)
 99a:	dc0795e3          	bnez	a5,764 <vprintf+0x20>
    }
  }
}
 99e:	0001                	nop
 9a0:	0001                	nop
 9a2:	60a6                	ld	ra,72(sp)
 9a4:	6406                	ld	s0,64(sp)
 9a6:	6161                	addi	sp,sp,80
 9a8:	8082                	ret

00000000000009aa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9aa:	7159                	addi	sp,sp,-112
 9ac:	fc06                	sd	ra,56(sp)
 9ae:	f822                	sd	s0,48(sp)
 9b0:	0080                	addi	s0,sp,64
 9b2:	fcb43823          	sd	a1,-48(s0)
 9b6:	e010                	sd	a2,0(s0)
 9b8:	e414                	sd	a3,8(s0)
 9ba:	e818                	sd	a4,16(s0)
 9bc:	ec1c                	sd	a5,24(s0)
 9be:	03043023          	sd	a6,32(s0)
 9c2:	03143423          	sd	a7,40(s0)
 9c6:	87aa                	mv	a5,a0
 9c8:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 9cc:	03040793          	addi	a5,s0,48
 9d0:	fcf43423          	sd	a5,-56(s0)
 9d4:	fc843783          	ld	a5,-56(s0)
 9d8:	fd078793          	addi	a5,a5,-48
 9dc:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 9e0:	fe843703          	ld	a4,-24(s0)
 9e4:	fdc42783          	lw	a5,-36(s0)
 9e8:	863a                	mv	a2,a4
 9ea:	fd043583          	ld	a1,-48(s0)
 9ee:	853e                	mv	a0,a5
 9f0:	00000097          	auipc	ra,0x0
 9f4:	d54080e7          	jalr	-684(ra) # 744 <vprintf>
}
 9f8:	0001                	nop
 9fa:	70e2                	ld	ra,56(sp)
 9fc:	7442                	ld	s0,48(sp)
 9fe:	6165                	addi	sp,sp,112
 a00:	8082                	ret

0000000000000a02 <printf>:

void
printf(const char *fmt, ...)
{
 a02:	7159                	addi	sp,sp,-112
 a04:	f406                	sd	ra,40(sp)
 a06:	f022                	sd	s0,32(sp)
 a08:	1800                	addi	s0,sp,48
 a0a:	fca43c23          	sd	a0,-40(s0)
 a0e:	e40c                	sd	a1,8(s0)
 a10:	e810                	sd	a2,16(s0)
 a12:	ec14                	sd	a3,24(s0)
 a14:	f018                	sd	a4,32(s0)
 a16:	f41c                	sd	a5,40(s0)
 a18:	03043823          	sd	a6,48(s0)
 a1c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a20:	04040793          	addi	a5,s0,64
 a24:	fcf43823          	sd	a5,-48(s0)
 a28:	fd043783          	ld	a5,-48(s0)
 a2c:	fc878793          	addi	a5,a5,-56
 a30:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 a34:	fe843783          	ld	a5,-24(s0)
 a38:	863e                	mv	a2,a5
 a3a:	fd843583          	ld	a1,-40(s0)
 a3e:	4505                	li	a0,1
 a40:	00000097          	auipc	ra,0x0
 a44:	d04080e7          	jalr	-764(ra) # 744 <vprintf>
}
 a48:	0001                	nop
 a4a:	70a2                	ld	ra,40(sp)
 a4c:	7402                	ld	s0,32(sp)
 a4e:	6165                	addi	sp,sp,112
 a50:	8082                	ret

0000000000000a52 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a52:	7179                	addi	sp,sp,-48
 a54:	f422                	sd	s0,40(sp)
 a56:	1800                	addi	s0,sp,48
 a58:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a5c:	fd843783          	ld	a5,-40(s0)
 a60:	17c1                	addi	a5,a5,-16
 a62:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a66:	00000797          	auipc	a5,0x0
 a6a:	33a78793          	addi	a5,a5,826 # da0 <freep>
 a6e:	639c                	ld	a5,0(a5)
 a70:	fef43423          	sd	a5,-24(s0)
 a74:	a815                	j	aa8 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a76:	fe843783          	ld	a5,-24(s0)
 a7a:	639c                	ld	a5,0(a5)
 a7c:	fe843703          	ld	a4,-24(s0)
 a80:	00f76f63          	bltu	a4,a5,a9e <free+0x4c>
 a84:	fe043703          	ld	a4,-32(s0)
 a88:	fe843783          	ld	a5,-24(s0)
 a8c:	02e7eb63          	bltu	a5,a4,ac2 <free+0x70>
 a90:	fe843783          	ld	a5,-24(s0)
 a94:	639c                	ld	a5,0(a5)
 a96:	fe043703          	ld	a4,-32(s0)
 a9a:	02f76463          	bltu	a4,a5,ac2 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a9e:	fe843783          	ld	a5,-24(s0)
 aa2:	639c                	ld	a5,0(a5)
 aa4:	fef43423          	sd	a5,-24(s0)
 aa8:	fe043703          	ld	a4,-32(s0)
 aac:	fe843783          	ld	a5,-24(s0)
 ab0:	fce7f3e3          	bgeu	a5,a4,a76 <free+0x24>
 ab4:	fe843783          	ld	a5,-24(s0)
 ab8:	639c                	ld	a5,0(a5)
 aba:	fe043703          	ld	a4,-32(s0)
 abe:	faf77ce3          	bgeu	a4,a5,a76 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 ac2:	fe043783          	ld	a5,-32(s0)
 ac6:	479c                	lw	a5,8(a5)
 ac8:	1782                	slli	a5,a5,0x20
 aca:	9381                	srli	a5,a5,0x20
 acc:	0792                	slli	a5,a5,0x4
 ace:	fe043703          	ld	a4,-32(s0)
 ad2:	973e                	add	a4,a4,a5
 ad4:	fe843783          	ld	a5,-24(s0)
 ad8:	639c                	ld	a5,0(a5)
 ada:	02f71763          	bne	a4,a5,b08 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 ade:	fe043783          	ld	a5,-32(s0)
 ae2:	4798                	lw	a4,8(a5)
 ae4:	fe843783          	ld	a5,-24(s0)
 ae8:	639c                	ld	a5,0(a5)
 aea:	479c                	lw	a5,8(a5)
 aec:	9fb9                	addw	a5,a5,a4
 aee:	0007871b          	sext.w	a4,a5
 af2:	fe043783          	ld	a5,-32(s0)
 af6:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 af8:	fe843783          	ld	a5,-24(s0)
 afc:	639c                	ld	a5,0(a5)
 afe:	6398                	ld	a4,0(a5)
 b00:	fe043783          	ld	a5,-32(s0)
 b04:	e398                	sd	a4,0(a5)
 b06:	a039                	j	b14 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b08:	fe843783          	ld	a5,-24(s0)
 b0c:	6398                	ld	a4,0(a5)
 b0e:	fe043783          	ld	a5,-32(s0)
 b12:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b14:	fe843783          	ld	a5,-24(s0)
 b18:	479c                	lw	a5,8(a5)
 b1a:	1782                	slli	a5,a5,0x20
 b1c:	9381                	srli	a5,a5,0x20
 b1e:	0792                	slli	a5,a5,0x4
 b20:	fe843703          	ld	a4,-24(s0)
 b24:	97ba                	add	a5,a5,a4
 b26:	fe043703          	ld	a4,-32(s0)
 b2a:	02f71563          	bne	a4,a5,b54 <free+0x102>
    p->s.size += bp->s.size;
 b2e:	fe843783          	ld	a5,-24(s0)
 b32:	4798                	lw	a4,8(a5)
 b34:	fe043783          	ld	a5,-32(s0)
 b38:	479c                	lw	a5,8(a5)
 b3a:	9fb9                	addw	a5,a5,a4
 b3c:	0007871b          	sext.w	a4,a5
 b40:	fe843783          	ld	a5,-24(s0)
 b44:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b46:	fe043783          	ld	a5,-32(s0)
 b4a:	6398                	ld	a4,0(a5)
 b4c:	fe843783          	ld	a5,-24(s0)
 b50:	e398                	sd	a4,0(a5)
 b52:	a031                	j	b5e <free+0x10c>
  } else
    p->s.ptr = bp;
 b54:	fe843783          	ld	a5,-24(s0)
 b58:	fe043703          	ld	a4,-32(s0)
 b5c:	e398                	sd	a4,0(a5)
  freep = p;
 b5e:	00000797          	auipc	a5,0x0
 b62:	24278793          	addi	a5,a5,578 # da0 <freep>
 b66:	fe843703          	ld	a4,-24(s0)
 b6a:	e398                	sd	a4,0(a5)
}
 b6c:	0001                	nop
 b6e:	7422                	ld	s0,40(sp)
 b70:	6145                	addi	sp,sp,48
 b72:	8082                	ret

0000000000000b74 <morecore>:

static Header*
morecore(uint nu)
{
 b74:	7179                	addi	sp,sp,-48
 b76:	f406                	sd	ra,40(sp)
 b78:	f022                	sd	s0,32(sp)
 b7a:	1800                	addi	s0,sp,48
 b7c:	87aa                	mv	a5,a0
 b7e:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 b82:	fdc42783          	lw	a5,-36(s0)
 b86:	0007871b          	sext.w	a4,a5
 b8a:	6785                	lui	a5,0x1
 b8c:	00f77563          	bgeu	a4,a5,b96 <morecore+0x22>
    nu = 4096;
 b90:	6785                	lui	a5,0x1
 b92:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 b96:	fdc42783          	lw	a5,-36(s0)
 b9a:	0047979b          	slliw	a5,a5,0x4
 b9e:	2781                	sext.w	a5,a5
 ba0:	2781                	sext.w	a5,a5
 ba2:	853e                	mv	a0,a5
 ba4:	00000097          	auipc	ra,0x0
 ba8:	9a8080e7          	jalr	-1624(ra) # 54c <sbrk>
 bac:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 bb0:	fe843703          	ld	a4,-24(s0)
 bb4:	57fd                	li	a5,-1
 bb6:	00f71463          	bne	a4,a5,bbe <morecore+0x4a>
    return 0;
 bba:	4781                	li	a5,0
 bbc:	a03d                	j	bea <morecore+0x76>
  hp = (Header*)p;
 bbe:	fe843783          	ld	a5,-24(s0)
 bc2:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 bc6:	fe043783          	ld	a5,-32(s0)
 bca:	fdc42703          	lw	a4,-36(s0)
 bce:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 bd0:	fe043783          	ld	a5,-32(s0)
 bd4:	07c1                	addi	a5,a5,16
 bd6:	853e                	mv	a0,a5
 bd8:	00000097          	auipc	ra,0x0
 bdc:	e7a080e7          	jalr	-390(ra) # a52 <free>
  return freep;
 be0:	00000797          	auipc	a5,0x0
 be4:	1c078793          	addi	a5,a5,448 # da0 <freep>
 be8:	639c                	ld	a5,0(a5)
}
 bea:	853e                	mv	a0,a5
 bec:	70a2                	ld	ra,40(sp)
 bee:	7402                	ld	s0,32(sp)
 bf0:	6145                	addi	sp,sp,48
 bf2:	8082                	ret

0000000000000bf4 <malloc>:

void*
malloc(uint nbytes)
{
 bf4:	7139                	addi	sp,sp,-64
 bf6:	fc06                	sd	ra,56(sp)
 bf8:	f822                	sd	s0,48(sp)
 bfa:	0080                	addi	s0,sp,64
 bfc:	87aa                	mv	a5,a0
 bfe:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c02:	fcc46783          	lwu	a5,-52(s0)
 c06:	07bd                	addi	a5,a5,15
 c08:	8391                	srli	a5,a5,0x4
 c0a:	2781                	sext.w	a5,a5
 c0c:	2785                	addiw	a5,a5,1
 c0e:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c12:	00000797          	auipc	a5,0x0
 c16:	18e78793          	addi	a5,a5,398 # da0 <freep>
 c1a:	639c                	ld	a5,0(a5)
 c1c:	fef43023          	sd	a5,-32(s0)
 c20:	fe043783          	ld	a5,-32(s0)
 c24:	ef95                	bnez	a5,c60 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c26:	00000797          	auipc	a5,0x0
 c2a:	16a78793          	addi	a5,a5,362 # d90 <base>
 c2e:	fef43023          	sd	a5,-32(s0)
 c32:	00000797          	auipc	a5,0x0
 c36:	16e78793          	addi	a5,a5,366 # da0 <freep>
 c3a:	fe043703          	ld	a4,-32(s0)
 c3e:	e398                	sd	a4,0(a5)
 c40:	00000797          	auipc	a5,0x0
 c44:	16078793          	addi	a5,a5,352 # da0 <freep>
 c48:	6398                	ld	a4,0(a5)
 c4a:	00000797          	auipc	a5,0x0
 c4e:	14678793          	addi	a5,a5,326 # d90 <base>
 c52:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 c54:	00000797          	auipc	a5,0x0
 c58:	13c78793          	addi	a5,a5,316 # d90 <base>
 c5c:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c60:	fe043783          	ld	a5,-32(s0)
 c64:	639c                	ld	a5,0(a5)
 c66:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 c6a:	fe843783          	ld	a5,-24(s0)
 c6e:	4798                	lw	a4,8(a5)
 c70:	fdc42783          	lw	a5,-36(s0)
 c74:	2781                	sext.w	a5,a5
 c76:	06f76863          	bltu	a4,a5,ce6 <malloc+0xf2>
      if(p->s.size == nunits)
 c7a:	fe843783          	ld	a5,-24(s0)
 c7e:	4798                	lw	a4,8(a5)
 c80:	fdc42783          	lw	a5,-36(s0)
 c84:	2781                	sext.w	a5,a5
 c86:	00e79963          	bne	a5,a4,c98 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 c8a:	fe843783          	ld	a5,-24(s0)
 c8e:	6398                	ld	a4,0(a5)
 c90:	fe043783          	ld	a5,-32(s0)
 c94:	e398                	sd	a4,0(a5)
 c96:	a82d                	j	cd0 <malloc+0xdc>
      else {
        p->s.size -= nunits;
 c98:	fe843783          	ld	a5,-24(s0)
 c9c:	4798                	lw	a4,8(a5)
 c9e:	fdc42783          	lw	a5,-36(s0)
 ca2:	40f707bb          	subw	a5,a4,a5
 ca6:	0007871b          	sext.w	a4,a5
 caa:	fe843783          	ld	a5,-24(s0)
 cae:	c798                	sw	a4,8(a5)
        p += p->s.size;
 cb0:	fe843783          	ld	a5,-24(s0)
 cb4:	479c                	lw	a5,8(a5)
 cb6:	1782                	slli	a5,a5,0x20
 cb8:	9381                	srli	a5,a5,0x20
 cba:	0792                	slli	a5,a5,0x4
 cbc:	fe843703          	ld	a4,-24(s0)
 cc0:	97ba                	add	a5,a5,a4
 cc2:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 cc6:	fe843783          	ld	a5,-24(s0)
 cca:	fdc42703          	lw	a4,-36(s0)
 cce:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 cd0:	00000797          	auipc	a5,0x0
 cd4:	0d078793          	addi	a5,a5,208 # da0 <freep>
 cd8:	fe043703          	ld	a4,-32(s0)
 cdc:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 cde:	fe843783          	ld	a5,-24(s0)
 ce2:	07c1                	addi	a5,a5,16
 ce4:	a091                	j	d28 <malloc+0x134>
    }
    if(p == freep)
 ce6:	00000797          	auipc	a5,0x0
 cea:	0ba78793          	addi	a5,a5,186 # da0 <freep>
 cee:	639c                	ld	a5,0(a5)
 cf0:	fe843703          	ld	a4,-24(s0)
 cf4:	02f71063          	bne	a4,a5,d14 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 cf8:	fdc42783          	lw	a5,-36(s0)
 cfc:	853e                	mv	a0,a5
 cfe:	00000097          	auipc	ra,0x0
 d02:	e76080e7          	jalr	-394(ra) # b74 <morecore>
 d06:	fea43423          	sd	a0,-24(s0)
 d0a:	fe843783          	ld	a5,-24(s0)
 d0e:	e399                	bnez	a5,d14 <malloc+0x120>
        return 0;
 d10:	4781                	li	a5,0
 d12:	a819                	j	d28 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d14:	fe843783          	ld	a5,-24(s0)
 d18:	fef43023          	sd	a5,-32(s0)
 d1c:	fe843783          	ld	a5,-24(s0)
 d20:	639c                	ld	a5,0(a5)
 d22:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d26:	b791                	j	c6a <malloc+0x76>
  }
}
 d28:	853e                	mv	a0,a5
 d2a:	70e2                	ld	ra,56(sp)
 d2c:	7442                	ld	s0,48(sp)
 d2e:	6121                	addi	sp,sp,64
 d30:	8082                	ret
