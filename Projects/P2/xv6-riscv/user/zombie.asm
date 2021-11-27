
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
   c:	4aa080e7          	jalr	1194(ra) # 4b2 <fork>
  10:	87aa                	mv	a5,a0
  12:	00f05763          	blez	a5,20 <main+0x20>
    sleep(5);  // Let child exit before parent.
  16:	4515                	li	a0,5
  18:	00000097          	auipc	ra,0x0
  1c:	532080e7          	jalr	1330(ra) # 54a <sleep>
  exit(0);
  20:	4501                	li	a0,0
  22:	00000097          	auipc	ra,0x0
  26:	498080e7          	jalr	1176(ra) # 4ba <exit>

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
 144:	0ff77713          	andi	a4,a4,255
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
 18e:	0ff7f793          	andi	a5,a5,255
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
 1e0:	2f6080e7          	jalr	758(ra) # 4d2 <read>
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
 276:	288080e7          	jalr	648(ra) # 4fa <open>
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
 29c:	27a080e7          	jalr	634(ra) # 512 <fstat>
 2a0:	87aa                	mv	a5,a0
 2a2:	fef42423          	sw	a5,-24(s0)
  close(fd);
 2a6:	fec42783          	lw	a5,-20(s0)
 2aa:	853e                	mv	a0,a5
 2ac:	00000097          	auipc	ra,0x0
 2b0:	236080e7          	jalr	566(ra) # 4e2 <close>
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
 2d0:	a815                	j	304 <atoi+0x42>
    n = n*10 + *s++ - '0';
 2d2:	fec42703          	lw	a4,-20(s0)
 2d6:	87ba                	mv	a5,a4
 2d8:	0027979b          	slliw	a5,a5,0x2
 2dc:	9fb9                	addw	a5,a5,a4
 2de:	0017979b          	slliw	a5,a5,0x1
 2e2:	0007871b          	sext.w	a4,a5
 2e6:	fd843783          	ld	a5,-40(s0)
 2ea:	00178693          	addi	a3,a5,1
 2ee:	fcd43c23          	sd	a3,-40(s0)
 2f2:	0007c783          	lbu	a5,0(a5)
 2f6:	2781                	sext.w	a5,a5
 2f8:	9fb9                	addw	a5,a5,a4
 2fa:	2781                	sext.w	a5,a5
 2fc:	fd07879b          	addiw	a5,a5,-48
 300:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 304:	fd843783          	ld	a5,-40(s0)
 308:	0007c783          	lbu	a5,0(a5)
 30c:	873e                	mv	a4,a5
 30e:	02f00793          	li	a5,47
 312:	00e7fb63          	bgeu	a5,a4,328 <atoi+0x66>
 316:	fd843783          	ld	a5,-40(s0)
 31a:	0007c783          	lbu	a5,0(a5)
 31e:	873e                	mv	a4,a5
 320:	03900793          	li	a5,57
 324:	fae7f7e3          	bgeu	a5,a4,2d2 <atoi+0x10>
  return n;
 328:	fec42783          	lw	a5,-20(s0)
}
 32c:	853e                	mv	a0,a5
 32e:	7422                	ld	s0,40(sp)
 330:	6145                	addi	sp,sp,48
 332:	8082                	ret

0000000000000334 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 334:	7139                	addi	sp,sp,-64
 336:	fc22                	sd	s0,56(sp)
 338:	0080                	addi	s0,sp,64
 33a:	fca43c23          	sd	a0,-40(s0)
 33e:	fcb43823          	sd	a1,-48(s0)
 342:	87b2                	mv	a5,a2
 344:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 348:	fd843783          	ld	a5,-40(s0)
 34c:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 350:	fd043783          	ld	a5,-48(s0)
 354:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 358:	fe043703          	ld	a4,-32(s0)
 35c:	fe843783          	ld	a5,-24(s0)
 360:	02e7fc63          	bgeu	a5,a4,398 <memmove+0x64>
    while(n-- > 0)
 364:	a00d                	j	386 <memmove+0x52>
      *dst++ = *src++;
 366:	fe043703          	ld	a4,-32(s0)
 36a:	00170793          	addi	a5,a4,1
 36e:	fef43023          	sd	a5,-32(s0)
 372:	fe843783          	ld	a5,-24(s0)
 376:	00178693          	addi	a3,a5,1
 37a:	fed43423          	sd	a3,-24(s0)
 37e:	00074703          	lbu	a4,0(a4)
 382:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 386:	fcc42783          	lw	a5,-52(s0)
 38a:	fff7871b          	addiw	a4,a5,-1
 38e:	fce42623          	sw	a4,-52(s0)
 392:	fcf04ae3          	bgtz	a5,366 <memmove+0x32>
 396:	a891                	j	3ea <memmove+0xb6>
  } else {
    dst += n;
 398:	fcc42783          	lw	a5,-52(s0)
 39c:	fe843703          	ld	a4,-24(s0)
 3a0:	97ba                	add	a5,a5,a4
 3a2:	fef43423          	sd	a5,-24(s0)
    src += n;
 3a6:	fcc42783          	lw	a5,-52(s0)
 3aa:	fe043703          	ld	a4,-32(s0)
 3ae:	97ba                	add	a5,a5,a4
 3b0:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 3b4:	a01d                	j	3da <memmove+0xa6>
      *--dst = *--src;
 3b6:	fe043783          	ld	a5,-32(s0)
 3ba:	17fd                	addi	a5,a5,-1
 3bc:	fef43023          	sd	a5,-32(s0)
 3c0:	fe843783          	ld	a5,-24(s0)
 3c4:	17fd                	addi	a5,a5,-1
 3c6:	fef43423          	sd	a5,-24(s0)
 3ca:	fe043783          	ld	a5,-32(s0)
 3ce:	0007c703          	lbu	a4,0(a5)
 3d2:	fe843783          	ld	a5,-24(s0)
 3d6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3da:	fcc42783          	lw	a5,-52(s0)
 3de:	fff7871b          	addiw	a4,a5,-1
 3e2:	fce42623          	sw	a4,-52(s0)
 3e6:	fcf048e3          	bgtz	a5,3b6 <memmove+0x82>
  }
  return vdst;
 3ea:	fd843783          	ld	a5,-40(s0)
}
 3ee:	853e                	mv	a0,a5
 3f0:	7462                	ld	s0,56(sp)
 3f2:	6121                	addi	sp,sp,64
 3f4:	8082                	ret

00000000000003f6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3f6:	7139                	addi	sp,sp,-64
 3f8:	fc22                	sd	s0,56(sp)
 3fa:	0080                	addi	s0,sp,64
 3fc:	fca43c23          	sd	a0,-40(s0)
 400:	fcb43823          	sd	a1,-48(s0)
 404:	87b2                	mv	a5,a2
 406:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 40a:	fd843783          	ld	a5,-40(s0)
 40e:	fef43423          	sd	a5,-24(s0)
 412:	fd043783          	ld	a5,-48(s0)
 416:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 41a:	a0a1                	j	462 <memcmp+0x6c>
    if (*p1 != *p2) {
 41c:	fe843783          	ld	a5,-24(s0)
 420:	0007c703          	lbu	a4,0(a5)
 424:	fe043783          	ld	a5,-32(s0)
 428:	0007c783          	lbu	a5,0(a5)
 42c:	02f70163          	beq	a4,a5,44e <memcmp+0x58>
      return *p1 - *p2;
 430:	fe843783          	ld	a5,-24(s0)
 434:	0007c783          	lbu	a5,0(a5)
 438:	0007871b          	sext.w	a4,a5
 43c:	fe043783          	ld	a5,-32(s0)
 440:	0007c783          	lbu	a5,0(a5)
 444:	2781                	sext.w	a5,a5
 446:	40f707bb          	subw	a5,a4,a5
 44a:	2781                	sext.w	a5,a5
 44c:	a01d                	j	472 <memcmp+0x7c>
    }
    p1++;
 44e:	fe843783          	ld	a5,-24(s0)
 452:	0785                	addi	a5,a5,1
 454:	fef43423          	sd	a5,-24(s0)
    p2++;
 458:	fe043783          	ld	a5,-32(s0)
 45c:	0785                	addi	a5,a5,1
 45e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 462:	fcc42783          	lw	a5,-52(s0)
 466:	fff7871b          	addiw	a4,a5,-1
 46a:	fce42623          	sw	a4,-52(s0)
 46e:	f7dd                	bnez	a5,41c <memcmp+0x26>
  }
  return 0;
 470:	4781                	li	a5,0
}
 472:	853e                	mv	a0,a5
 474:	7462                	ld	s0,56(sp)
 476:	6121                	addi	sp,sp,64
 478:	8082                	ret

000000000000047a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 47a:	7179                	addi	sp,sp,-48
 47c:	f406                	sd	ra,40(sp)
 47e:	f022                	sd	s0,32(sp)
 480:	1800                	addi	s0,sp,48
 482:	fea43423          	sd	a0,-24(s0)
 486:	feb43023          	sd	a1,-32(s0)
 48a:	87b2                	mv	a5,a2
 48c:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 490:	fdc42783          	lw	a5,-36(s0)
 494:	863e                	mv	a2,a5
 496:	fe043583          	ld	a1,-32(s0)
 49a:	fe843503          	ld	a0,-24(s0)
 49e:	00000097          	auipc	ra,0x0
 4a2:	e96080e7          	jalr	-362(ra) # 334 <memmove>
 4a6:	87aa                	mv	a5,a0
}
 4a8:	853e                	mv	a0,a5
 4aa:	70a2                	ld	ra,40(sp)
 4ac:	7402                	ld	s0,32(sp)
 4ae:	6145                	addi	sp,sp,48
 4b0:	8082                	ret

00000000000004b2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4b2:	4885                	li	a7,1
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <exit>:
.global exit
exit:
 li a7, SYS_exit
 4ba:	4889                	li	a7,2
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4c2:	488d                	li	a7,3
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4ca:	4891                	li	a7,4
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <read>:
.global read
read:
 li a7, SYS_read
 4d2:	4895                	li	a7,5
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <write>:
.global write
write:
 li a7, SYS_write
 4da:	48c1                	li	a7,16
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <close>:
.global close
close:
 li a7, SYS_close
 4e2:	48d5                	li	a7,21
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <kill>:
.global kill
kill:
 li a7, SYS_kill
 4ea:	4899                	li	a7,6
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4f2:	489d                	li	a7,7
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <open>:
.global open
open:
 li a7, SYS_open
 4fa:	48bd                	li	a7,15
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 502:	48c5                	li	a7,17
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 50a:	48c9                	li	a7,18
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 512:	48a1                	li	a7,8
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <link>:
.global link
link:
 li a7, SYS_link
 51a:	48cd                	li	a7,19
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 522:	48d1                	li	a7,20
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 52a:	48a5                	li	a7,9
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <dup>:
.global dup
dup:
 li a7, SYS_dup
 532:	48a9                	li	a7,10
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 53a:	48ad                	li	a7,11
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 542:	48b1                	li	a7,12
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 54a:	48b5                	li	a7,13
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 552:	48b9                	li	a7,14
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 55a:	48d9                	li	a7,22
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <setpri>:
.global setpri
setpri:
 li a7, SYS_setpri
 562:	48dd                	li	a7,23
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 56a:	1101                	addi	sp,sp,-32
 56c:	ec06                	sd	ra,24(sp)
 56e:	e822                	sd	s0,16(sp)
 570:	1000                	addi	s0,sp,32
 572:	87aa                	mv	a5,a0
 574:	872e                	mv	a4,a1
 576:	fef42623          	sw	a5,-20(s0)
 57a:	87ba                	mv	a5,a4
 57c:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 580:	feb40713          	addi	a4,s0,-21
 584:	fec42783          	lw	a5,-20(s0)
 588:	4605                	li	a2,1
 58a:	85ba                	mv	a1,a4
 58c:	853e                	mv	a0,a5
 58e:	00000097          	auipc	ra,0x0
 592:	f4c080e7          	jalr	-180(ra) # 4da <write>
}
 596:	0001                	nop
 598:	60e2                	ld	ra,24(sp)
 59a:	6442                	ld	s0,16(sp)
 59c:	6105                	addi	sp,sp,32
 59e:	8082                	ret

00000000000005a0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5a0:	7139                	addi	sp,sp,-64
 5a2:	fc06                	sd	ra,56(sp)
 5a4:	f822                	sd	s0,48(sp)
 5a6:	0080                	addi	s0,sp,64
 5a8:	87aa                	mv	a5,a0
 5aa:	8736                	mv	a4,a3
 5ac:	fcf42623          	sw	a5,-52(s0)
 5b0:	87ae                	mv	a5,a1
 5b2:	fcf42423          	sw	a5,-56(s0)
 5b6:	87b2                	mv	a5,a2
 5b8:	fcf42223          	sw	a5,-60(s0)
 5bc:	87ba                	mv	a5,a4
 5be:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5c2:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 5c6:	fc042783          	lw	a5,-64(s0)
 5ca:	2781                	sext.w	a5,a5
 5cc:	c38d                	beqz	a5,5ee <printint+0x4e>
 5ce:	fc842783          	lw	a5,-56(s0)
 5d2:	2781                	sext.w	a5,a5
 5d4:	0007dd63          	bgez	a5,5ee <printint+0x4e>
    neg = 1;
 5d8:	4785                	li	a5,1
 5da:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 5de:	fc842783          	lw	a5,-56(s0)
 5e2:	40f007bb          	negw	a5,a5
 5e6:	2781                	sext.w	a5,a5
 5e8:	fef42223          	sw	a5,-28(s0)
 5ec:	a029                	j	5f6 <printint+0x56>
  } else {
    x = xx;
 5ee:	fc842783          	lw	a5,-56(s0)
 5f2:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 5f6:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 5fa:	fc442783          	lw	a5,-60(s0)
 5fe:	fe442703          	lw	a4,-28(s0)
 602:	02f777bb          	remuw	a5,a4,a5
 606:	0007861b          	sext.w	a2,a5
 60a:	fec42783          	lw	a5,-20(s0)
 60e:	0017871b          	addiw	a4,a5,1
 612:	fee42623          	sw	a4,-20(s0)
 616:	00000697          	auipc	a3,0x0
 61a:	71a68693          	addi	a3,a3,1818 # d30 <digits>
 61e:	02061713          	slli	a4,a2,0x20
 622:	9301                	srli	a4,a4,0x20
 624:	9736                	add	a4,a4,a3
 626:	00074703          	lbu	a4,0(a4)
 62a:	ff040693          	addi	a3,s0,-16
 62e:	97b6                	add	a5,a5,a3
 630:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 634:	fc442783          	lw	a5,-60(s0)
 638:	fe442703          	lw	a4,-28(s0)
 63c:	02f757bb          	divuw	a5,a4,a5
 640:	fef42223          	sw	a5,-28(s0)
 644:	fe442783          	lw	a5,-28(s0)
 648:	2781                	sext.w	a5,a5
 64a:	fbc5                	bnez	a5,5fa <printint+0x5a>
  if(neg)
 64c:	fe842783          	lw	a5,-24(s0)
 650:	2781                	sext.w	a5,a5
 652:	cf95                	beqz	a5,68e <printint+0xee>
    buf[i++] = '-';
 654:	fec42783          	lw	a5,-20(s0)
 658:	0017871b          	addiw	a4,a5,1
 65c:	fee42623          	sw	a4,-20(s0)
 660:	ff040713          	addi	a4,s0,-16
 664:	97ba                	add	a5,a5,a4
 666:	02d00713          	li	a4,45
 66a:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 66e:	a005                	j	68e <printint+0xee>
    putc(fd, buf[i]);
 670:	fec42783          	lw	a5,-20(s0)
 674:	ff040713          	addi	a4,s0,-16
 678:	97ba                	add	a5,a5,a4
 67a:	fe07c703          	lbu	a4,-32(a5)
 67e:	fcc42783          	lw	a5,-52(s0)
 682:	85ba                	mv	a1,a4
 684:	853e                	mv	a0,a5
 686:	00000097          	auipc	ra,0x0
 68a:	ee4080e7          	jalr	-284(ra) # 56a <putc>
  while(--i >= 0)
 68e:	fec42783          	lw	a5,-20(s0)
 692:	37fd                	addiw	a5,a5,-1
 694:	fef42623          	sw	a5,-20(s0)
 698:	fec42783          	lw	a5,-20(s0)
 69c:	2781                	sext.w	a5,a5
 69e:	fc07d9e3          	bgez	a5,670 <printint+0xd0>
}
 6a2:	0001                	nop
 6a4:	0001                	nop
 6a6:	70e2                	ld	ra,56(sp)
 6a8:	7442                	ld	s0,48(sp)
 6aa:	6121                	addi	sp,sp,64
 6ac:	8082                	ret

00000000000006ae <printptr>:

static void
printptr(int fd, uint64 x) {
 6ae:	7179                	addi	sp,sp,-48
 6b0:	f406                	sd	ra,40(sp)
 6b2:	f022                	sd	s0,32(sp)
 6b4:	1800                	addi	s0,sp,48
 6b6:	87aa                	mv	a5,a0
 6b8:	fcb43823          	sd	a1,-48(s0)
 6bc:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 6c0:	fdc42783          	lw	a5,-36(s0)
 6c4:	03000593          	li	a1,48
 6c8:	853e                	mv	a0,a5
 6ca:	00000097          	auipc	ra,0x0
 6ce:	ea0080e7          	jalr	-352(ra) # 56a <putc>
  putc(fd, 'x');
 6d2:	fdc42783          	lw	a5,-36(s0)
 6d6:	07800593          	li	a1,120
 6da:	853e                	mv	a0,a5
 6dc:	00000097          	auipc	ra,0x0
 6e0:	e8e080e7          	jalr	-370(ra) # 56a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6e4:	fe042623          	sw	zero,-20(s0)
 6e8:	a82d                	j	722 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6ea:	fd043783          	ld	a5,-48(s0)
 6ee:	93f1                	srli	a5,a5,0x3c
 6f0:	00000717          	auipc	a4,0x0
 6f4:	64070713          	addi	a4,a4,1600 # d30 <digits>
 6f8:	97ba                	add	a5,a5,a4
 6fa:	0007c703          	lbu	a4,0(a5)
 6fe:	fdc42783          	lw	a5,-36(s0)
 702:	85ba                	mv	a1,a4
 704:	853e                	mv	a0,a5
 706:	00000097          	auipc	ra,0x0
 70a:	e64080e7          	jalr	-412(ra) # 56a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 70e:	fec42783          	lw	a5,-20(s0)
 712:	2785                	addiw	a5,a5,1
 714:	fef42623          	sw	a5,-20(s0)
 718:	fd043783          	ld	a5,-48(s0)
 71c:	0792                	slli	a5,a5,0x4
 71e:	fcf43823          	sd	a5,-48(s0)
 722:	fec42783          	lw	a5,-20(s0)
 726:	873e                	mv	a4,a5
 728:	47bd                	li	a5,15
 72a:	fce7f0e3          	bgeu	a5,a4,6ea <printptr+0x3c>
}
 72e:	0001                	nop
 730:	0001                	nop
 732:	70a2                	ld	ra,40(sp)
 734:	7402                	ld	s0,32(sp)
 736:	6145                	addi	sp,sp,48
 738:	8082                	ret

000000000000073a <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 73a:	715d                	addi	sp,sp,-80
 73c:	e486                	sd	ra,72(sp)
 73e:	e0a2                	sd	s0,64(sp)
 740:	0880                	addi	s0,sp,80
 742:	87aa                	mv	a5,a0
 744:	fcb43023          	sd	a1,-64(s0)
 748:	fac43c23          	sd	a2,-72(s0)
 74c:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 750:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 754:	fe042223          	sw	zero,-28(s0)
 758:	a42d                	j	982 <vprintf+0x248>
    c = fmt[i] & 0xff;
 75a:	fe442783          	lw	a5,-28(s0)
 75e:	fc043703          	ld	a4,-64(s0)
 762:	97ba                	add	a5,a5,a4
 764:	0007c783          	lbu	a5,0(a5)
 768:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 76c:	fe042783          	lw	a5,-32(s0)
 770:	2781                	sext.w	a5,a5
 772:	eb9d                	bnez	a5,7a8 <vprintf+0x6e>
      if(c == '%'){
 774:	fdc42783          	lw	a5,-36(s0)
 778:	0007871b          	sext.w	a4,a5
 77c:	02500793          	li	a5,37
 780:	00f71763          	bne	a4,a5,78e <vprintf+0x54>
        state = '%';
 784:	02500793          	li	a5,37
 788:	fef42023          	sw	a5,-32(s0)
 78c:	a2f5                	j	978 <vprintf+0x23e>
      } else {
        putc(fd, c);
 78e:	fdc42783          	lw	a5,-36(s0)
 792:	0ff7f713          	andi	a4,a5,255
 796:	fcc42783          	lw	a5,-52(s0)
 79a:	85ba                	mv	a1,a4
 79c:	853e                	mv	a0,a5
 79e:	00000097          	auipc	ra,0x0
 7a2:	dcc080e7          	jalr	-564(ra) # 56a <putc>
 7a6:	aac9                	j	978 <vprintf+0x23e>
      }
    } else if(state == '%'){
 7a8:	fe042783          	lw	a5,-32(s0)
 7ac:	0007871b          	sext.w	a4,a5
 7b0:	02500793          	li	a5,37
 7b4:	1cf71263          	bne	a4,a5,978 <vprintf+0x23e>
      if(c == 'd'){
 7b8:	fdc42783          	lw	a5,-36(s0)
 7bc:	0007871b          	sext.w	a4,a5
 7c0:	06400793          	li	a5,100
 7c4:	02f71463          	bne	a4,a5,7ec <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 7c8:	fb843783          	ld	a5,-72(s0)
 7cc:	00878713          	addi	a4,a5,8
 7d0:	fae43c23          	sd	a4,-72(s0)
 7d4:	4398                	lw	a4,0(a5)
 7d6:	fcc42783          	lw	a5,-52(s0)
 7da:	4685                	li	a3,1
 7dc:	4629                	li	a2,10
 7de:	85ba                	mv	a1,a4
 7e0:	853e                	mv	a0,a5
 7e2:	00000097          	auipc	ra,0x0
 7e6:	dbe080e7          	jalr	-578(ra) # 5a0 <printint>
 7ea:	a269                	j	974 <vprintf+0x23a>
      } else if(c == 'l') {
 7ec:	fdc42783          	lw	a5,-36(s0)
 7f0:	0007871b          	sext.w	a4,a5
 7f4:	06c00793          	li	a5,108
 7f8:	02f71663          	bne	a4,a5,824 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7fc:	fb843783          	ld	a5,-72(s0)
 800:	00878713          	addi	a4,a5,8
 804:	fae43c23          	sd	a4,-72(s0)
 808:	639c                	ld	a5,0(a5)
 80a:	0007871b          	sext.w	a4,a5
 80e:	fcc42783          	lw	a5,-52(s0)
 812:	4681                	li	a3,0
 814:	4629                	li	a2,10
 816:	85ba                	mv	a1,a4
 818:	853e                	mv	a0,a5
 81a:	00000097          	auipc	ra,0x0
 81e:	d86080e7          	jalr	-634(ra) # 5a0 <printint>
 822:	aa89                	j	974 <vprintf+0x23a>
      } else if(c == 'x') {
 824:	fdc42783          	lw	a5,-36(s0)
 828:	0007871b          	sext.w	a4,a5
 82c:	07800793          	li	a5,120
 830:	02f71463          	bne	a4,a5,858 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 834:	fb843783          	ld	a5,-72(s0)
 838:	00878713          	addi	a4,a5,8
 83c:	fae43c23          	sd	a4,-72(s0)
 840:	4398                	lw	a4,0(a5)
 842:	fcc42783          	lw	a5,-52(s0)
 846:	4681                	li	a3,0
 848:	4641                	li	a2,16
 84a:	85ba                	mv	a1,a4
 84c:	853e                	mv	a0,a5
 84e:	00000097          	auipc	ra,0x0
 852:	d52080e7          	jalr	-686(ra) # 5a0 <printint>
 856:	aa39                	j	974 <vprintf+0x23a>
      } else if(c == 'p') {
 858:	fdc42783          	lw	a5,-36(s0)
 85c:	0007871b          	sext.w	a4,a5
 860:	07000793          	li	a5,112
 864:	02f71263          	bne	a4,a5,888 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 868:	fb843783          	ld	a5,-72(s0)
 86c:	00878713          	addi	a4,a5,8
 870:	fae43c23          	sd	a4,-72(s0)
 874:	6398                	ld	a4,0(a5)
 876:	fcc42783          	lw	a5,-52(s0)
 87a:	85ba                	mv	a1,a4
 87c:	853e                	mv	a0,a5
 87e:	00000097          	auipc	ra,0x0
 882:	e30080e7          	jalr	-464(ra) # 6ae <printptr>
 886:	a0fd                	j	974 <vprintf+0x23a>
      } else if(c == 's'){
 888:	fdc42783          	lw	a5,-36(s0)
 88c:	0007871b          	sext.w	a4,a5
 890:	07300793          	li	a5,115
 894:	04f71c63          	bne	a4,a5,8ec <vprintf+0x1b2>
        s = va_arg(ap, char*);
 898:	fb843783          	ld	a5,-72(s0)
 89c:	00878713          	addi	a4,a5,8
 8a0:	fae43c23          	sd	a4,-72(s0)
 8a4:	639c                	ld	a5,0(a5)
 8a6:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 8aa:	fe843783          	ld	a5,-24(s0)
 8ae:	eb8d                	bnez	a5,8e0 <vprintf+0x1a6>
          s = "(null)";
 8b0:	00000797          	auipc	a5,0x0
 8b4:	47878793          	addi	a5,a5,1144 # d28 <malloc+0x13e>
 8b8:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 8bc:	a015                	j	8e0 <vprintf+0x1a6>
          putc(fd, *s);
 8be:	fe843783          	ld	a5,-24(s0)
 8c2:	0007c703          	lbu	a4,0(a5)
 8c6:	fcc42783          	lw	a5,-52(s0)
 8ca:	85ba                	mv	a1,a4
 8cc:	853e                	mv	a0,a5
 8ce:	00000097          	auipc	ra,0x0
 8d2:	c9c080e7          	jalr	-868(ra) # 56a <putc>
          s++;
 8d6:	fe843783          	ld	a5,-24(s0)
 8da:	0785                	addi	a5,a5,1
 8dc:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 8e0:	fe843783          	ld	a5,-24(s0)
 8e4:	0007c783          	lbu	a5,0(a5)
 8e8:	fbf9                	bnez	a5,8be <vprintf+0x184>
 8ea:	a069                	j	974 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 8ec:	fdc42783          	lw	a5,-36(s0)
 8f0:	0007871b          	sext.w	a4,a5
 8f4:	06300793          	li	a5,99
 8f8:	02f71463          	bne	a4,a5,920 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 8fc:	fb843783          	ld	a5,-72(s0)
 900:	00878713          	addi	a4,a5,8
 904:	fae43c23          	sd	a4,-72(s0)
 908:	439c                	lw	a5,0(a5)
 90a:	0ff7f713          	andi	a4,a5,255
 90e:	fcc42783          	lw	a5,-52(s0)
 912:	85ba                	mv	a1,a4
 914:	853e                	mv	a0,a5
 916:	00000097          	auipc	ra,0x0
 91a:	c54080e7          	jalr	-940(ra) # 56a <putc>
 91e:	a899                	j	974 <vprintf+0x23a>
      } else if(c == '%'){
 920:	fdc42783          	lw	a5,-36(s0)
 924:	0007871b          	sext.w	a4,a5
 928:	02500793          	li	a5,37
 92c:	00f71f63          	bne	a4,a5,94a <vprintf+0x210>
        putc(fd, c);
 930:	fdc42783          	lw	a5,-36(s0)
 934:	0ff7f713          	andi	a4,a5,255
 938:	fcc42783          	lw	a5,-52(s0)
 93c:	85ba                	mv	a1,a4
 93e:	853e                	mv	a0,a5
 940:	00000097          	auipc	ra,0x0
 944:	c2a080e7          	jalr	-982(ra) # 56a <putc>
 948:	a035                	j	974 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 94a:	fcc42783          	lw	a5,-52(s0)
 94e:	02500593          	li	a1,37
 952:	853e                	mv	a0,a5
 954:	00000097          	auipc	ra,0x0
 958:	c16080e7          	jalr	-1002(ra) # 56a <putc>
        putc(fd, c);
 95c:	fdc42783          	lw	a5,-36(s0)
 960:	0ff7f713          	andi	a4,a5,255
 964:	fcc42783          	lw	a5,-52(s0)
 968:	85ba                	mv	a1,a4
 96a:	853e                	mv	a0,a5
 96c:	00000097          	auipc	ra,0x0
 970:	bfe080e7          	jalr	-1026(ra) # 56a <putc>
      }
      state = 0;
 974:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 978:	fe442783          	lw	a5,-28(s0)
 97c:	2785                	addiw	a5,a5,1
 97e:	fef42223          	sw	a5,-28(s0)
 982:	fe442783          	lw	a5,-28(s0)
 986:	fc043703          	ld	a4,-64(s0)
 98a:	97ba                	add	a5,a5,a4
 98c:	0007c783          	lbu	a5,0(a5)
 990:	dc0795e3          	bnez	a5,75a <vprintf+0x20>
    }
  }
}
 994:	0001                	nop
 996:	0001                	nop
 998:	60a6                	ld	ra,72(sp)
 99a:	6406                	ld	s0,64(sp)
 99c:	6161                	addi	sp,sp,80
 99e:	8082                	ret

00000000000009a0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9a0:	7159                	addi	sp,sp,-112
 9a2:	fc06                	sd	ra,56(sp)
 9a4:	f822                	sd	s0,48(sp)
 9a6:	0080                	addi	s0,sp,64
 9a8:	fcb43823          	sd	a1,-48(s0)
 9ac:	e010                	sd	a2,0(s0)
 9ae:	e414                	sd	a3,8(s0)
 9b0:	e818                	sd	a4,16(s0)
 9b2:	ec1c                	sd	a5,24(s0)
 9b4:	03043023          	sd	a6,32(s0)
 9b8:	03143423          	sd	a7,40(s0)
 9bc:	87aa                	mv	a5,a0
 9be:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 9c2:	03040793          	addi	a5,s0,48
 9c6:	fcf43423          	sd	a5,-56(s0)
 9ca:	fc843783          	ld	a5,-56(s0)
 9ce:	fd078793          	addi	a5,a5,-48
 9d2:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 9d6:	fe843703          	ld	a4,-24(s0)
 9da:	fdc42783          	lw	a5,-36(s0)
 9de:	863a                	mv	a2,a4
 9e0:	fd043583          	ld	a1,-48(s0)
 9e4:	853e                	mv	a0,a5
 9e6:	00000097          	auipc	ra,0x0
 9ea:	d54080e7          	jalr	-684(ra) # 73a <vprintf>
}
 9ee:	0001                	nop
 9f0:	70e2                	ld	ra,56(sp)
 9f2:	7442                	ld	s0,48(sp)
 9f4:	6165                	addi	sp,sp,112
 9f6:	8082                	ret

00000000000009f8 <printf>:

void
printf(const char *fmt, ...)
{
 9f8:	7159                	addi	sp,sp,-112
 9fa:	f406                	sd	ra,40(sp)
 9fc:	f022                	sd	s0,32(sp)
 9fe:	1800                	addi	s0,sp,48
 a00:	fca43c23          	sd	a0,-40(s0)
 a04:	e40c                	sd	a1,8(s0)
 a06:	e810                	sd	a2,16(s0)
 a08:	ec14                	sd	a3,24(s0)
 a0a:	f018                	sd	a4,32(s0)
 a0c:	f41c                	sd	a5,40(s0)
 a0e:	03043823          	sd	a6,48(s0)
 a12:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a16:	04040793          	addi	a5,s0,64
 a1a:	fcf43823          	sd	a5,-48(s0)
 a1e:	fd043783          	ld	a5,-48(s0)
 a22:	fc878793          	addi	a5,a5,-56
 a26:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 a2a:	fe843783          	ld	a5,-24(s0)
 a2e:	863e                	mv	a2,a5
 a30:	fd843583          	ld	a1,-40(s0)
 a34:	4505                	li	a0,1
 a36:	00000097          	auipc	ra,0x0
 a3a:	d04080e7          	jalr	-764(ra) # 73a <vprintf>
}
 a3e:	0001                	nop
 a40:	70a2                	ld	ra,40(sp)
 a42:	7402                	ld	s0,32(sp)
 a44:	6165                	addi	sp,sp,112
 a46:	8082                	ret

0000000000000a48 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a48:	7179                	addi	sp,sp,-48
 a4a:	f422                	sd	s0,40(sp)
 a4c:	1800                	addi	s0,sp,48
 a4e:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a52:	fd843783          	ld	a5,-40(s0)
 a56:	17c1                	addi	a5,a5,-16
 a58:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a5c:	00000797          	auipc	a5,0x0
 a60:	2fc78793          	addi	a5,a5,764 # d58 <freep>
 a64:	639c                	ld	a5,0(a5)
 a66:	fef43423          	sd	a5,-24(s0)
 a6a:	a815                	j	a9e <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a6c:	fe843783          	ld	a5,-24(s0)
 a70:	639c                	ld	a5,0(a5)
 a72:	fe843703          	ld	a4,-24(s0)
 a76:	00f76f63          	bltu	a4,a5,a94 <free+0x4c>
 a7a:	fe043703          	ld	a4,-32(s0)
 a7e:	fe843783          	ld	a5,-24(s0)
 a82:	02e7eb63          	bltu	a5,a4,ab8 <free+0x70>
 a86:	fe843783          	ld	a5,-24(s0)
 a8a:	639c                	ld	a5,0(a5)
 a8c:	fe043703          	ld	a4,-32(s0)
 a90:	02f76463          	bltu	a4,a5,ab8 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a94:	fe843783          	ld	a5,-24(s0)
 a98:	639c                	ld	a5,0(a5)
 a9a:	fef43423          	sd	a5,-24(s0)
 a9e:	fe043703          	ld	a4,-32(s0)
 aa2:	fe843783          	ld	a5,-24(s0)
 aa6:	fce7f3e3          	bgeu	a5,a4,a6c <free+0x24>
 aaa:	fe843783          	ld	a5,-24(s0)
 aae:	639c                	ld	a5,0(a5)
 ab0:	fe043703          	ld	a4,-32(s0)
 ab4:	faf77ce3          	bgeu	a4,a5,a6c <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 ab8:	fe043783          	ld	a5,-32(s0)
 abc:	479c                	lw	a5,8(a5)
 abe:	1782                	slli	a5,a5,0x20
 ac0:	9381                	srli	a5,a5,0x20
 ac2:	0792                	slli	a5,a5,0x4
 ac4:	fe043703          	ld	a4,-32(s0)
 ac8:	973e                	add	a4,a4,a5
 aca:	fe843783          	ld	a5,-24(s0)
 ace:	639c                	ld	a5,0(a5)
 ad0:	02f71763          	bne	a4,a5,afe <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 ad4:	fe043783          	ld	a5,-32(s0)
 ad8:	4798                	lw	a4,8(a5)
 ada:	fe843783          	ld	a5,-24(s0)
 ade:	639c                	ld	a5,0(a5)
 ae0:	479c                	lw	a5,8(a5)
 ae2:	9fb9                	addw	a5,a5,a4
 ae4:	0007871b          	sext.w	a4,a5
 ae8:	fe043783          	ld	a5,-32(s0)
 aec:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 aee:	fe843783          	ld	a5,-24(s0)
 af2:	639c                	ld	a5,0(a5)
 af4:	6398                	ld	a4,0(a5)
 af6:	fe043783          	ld	a5,-32(s0)
 afa:	e398                	sd	a4,0(a5)
 afc:	a039                	j	b0a <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 afe:	fe843783          	ld	a5,-24(s0)
 b02:	6398                	ld	a4,0(a5)
 b04:	fe043783          	ld	a5,-32(s0)
 b08:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b0a:	fe843783          	ld	a5,-24(s0)
 b0e:	479c                	lw	a5,8(a5)
 b10:	1782                	slli	a5,a5,0x20
 b12:	9381                	srli	a5,a5,0x20
 b14:	0792                	slli	a5,a5,0x4
 b16:	fe843703          	ld	a4,-24(s0)
 b1a:	97ba                	add	a5,a5,a4
 b1c:	fe043703          	ld	a4,-32(s0)
 b20:	02f71563          	bne	a4,a5,b4a <free+0x102>
    p->s.size += bp->s.size;
 b24:	fe843783          	ld	a5,-24(s0)
 b28:	4798                	lw	a4,8(a5)
 b2a:	fe043783          	ld	a5,-32(s0)
 b2e:	479c                	lw	a5,8(a5)
 b30:	9fb9                	addw	a5,a5,a4
 b32:	0007871b          	sext.w	a4,a5
 b36:	fe843783          	ld	a5,-24(s0)
 b3a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b3c:	fe043783          	ld	a5,-32(s0)
 b40:	6398                	ld	a4,0(a5)
 b42:	fe843783          	ld	a5,-24(s0)
 b46:	e398                	sd	a4,0(a5)
 b48:	a031                	j	b54 <free+0x10c>
  } else
    p->s.ptr = bp;
 b4a:	fe843783          	ld	a5,-24(s0)
 b4e:	fe043703          	ld	a4,-32(s0)
 b52:	e398                	sd	a4,0(a5)
  freep = p;
 b54:	00000797          	auipc	a5,0x0
 b58:	20478793          	addi	a5,a5,516 # d58 <freep>
 b5c:	fe843703          	ld	a4,-24(s0)
 b60:	e398                	sd	a4,0(a5)
}
 b62:	0001                	nop
 b64:	7422                	ld	s0,40(sp)
 b66:	6145                	addi	sp,sp,48
 b68:	8082                	ret

0000000000000b6a <morecore>:

static Header*
morecore(uint nu)
{
 b6a:	7179                	addi	sp,sp,-48
 b6c:	f406                	sd	ra,40(sp)
 b6e:	f022                	sd	s0,32(sp)
 b70:	1800                	addi	s0,sp,48
 b72:	87aa                	mv	a5,a0
 b74:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 b78:	fdc42783          	lw	a5,-36(s0)
 b7c:	0007871b          	sext.w	a4,a5
 b80:	6785                	lui	a5,0x1
 b82:	00f77563          	bgeu	a4,a5,b8c <morecore+0x22>
    nu = 4096;
 b86:	6785                	lui	a5,0x1
 b88:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 b8c:	fdc42783          	lw	a5,-36(s0)
 b90:	0047979b          	slliw	a5,a5,0x4
 b94:	2781                	sext.w	a5,a5
 b96:	2781                	sext.w	a5,a5
 b98:	853e                	mv	a0,a5
 b9a:	00000097          	auipc	ra,0x0
 b9e:	9a8080e7          	jalr	-1624(ra) # 542 <sbrk>
 ba2:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 ba6:	fe843703          	ld	a4,-24(s0)
 baa:	57fd                	li	a5,-1
 bac:	00f71463          	bne	a4,a5,bb4 <morecore+0x4a>
    return 0;
 bb0:	4781                	li	a5,0
 bb2:	a03d                	j	be0 <morecore+0x76>
  hp = (Header*)p;
 bb4:	fe843783          	ld	a5,-24(s0)
 bb8:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 bbc:	fe043783          	ld	a5,-32(s0)
 bc0:	fdc42703          	lw	a4,-36(s0)
 bc4:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 bc6:	fe043783          	ld	a5,-32(s0)
 bca:	07c1                	addi	a5,a5,16
 bcc:	853e                	mv	a0,a5
 bce:	00000097          	auipc	ra,0x0
 bd2:	e7a080e7          	jalr	-390(ra) # a48 <free>
  return freep;
 bd6:	00000797          	auipc	a5,0x0
 bda:	18278793          	addi	a5,a5,386 # d58 <freep>
 bde:	639c                	ld	a5,0(a5)
}
 be0:	853e                	mv	a0,a5
 be2:	70a2                	ld	ra,40(sp)
 be4:	7402                	ld	s0,32(sp)
 be6:	6145                	addi	sp,sp,48
 be8:	8082                	ret

0000000000000bea <malloc>:

void*
malloc(uint nbytes)
{
 bea:	7139                	addi	sp,sp,-64
 bec:	fc06                	sd	ra,56(sp)
 bee:	f822                	sd	s0,48(sp)
 bf0:	0080                	addi	s0,sp,64
 bf2:	87aa                	mv	a5,a0
 bf4:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bf8:	fcc46783          	lwu	a5,-52(s0)
 bfc:	07bd                	addi	a5,a5,15
 bfe:	8391                	srli	a5,a5,0x4
 c00:	2781                	sext.w	a5,a5
 c02:	2785                	addiw	a5,a5,1
 c04:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c08:	00000797          	auipc	a5,0x0
 c0c:	15078793          	addi	a5,a5,336 # d58 <freep>
 c10:	639c                	ld	a5,0(a5)
 c12:	fef43023          	sd	a5,-32(s0)
 c16:	fe043783          	ld	a5,-32(s0)
 c1a:	ef95                	bnez	a5,c56 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c1c:	00000797          	auipc	a5,0x0
 c20:	12c78793          	addi	a5,a5,300 # d48 <base>
 c24:	fef43023          	sd	a5,-32(s0)
 c28:	00000797          	auipc	a5,0x0
 c2c:	13078793          	addi	a5,a5,304 # d58 <freep>
 c30:	fe043703          	ld	a4,-32(s0)
 c34:	e398                	sd	a4,0(a5)
 c36:	00000797          	auipc	a5,0x0
 c3a:	12278793          	addi	a5,a5,290 # d58 <freep>
 c3e:	6398                	ld	a4,0(a5)
 c40:	00000797          	auipc	a5,0x0
 c44:	10878793          	addi	a5,a5,264 # d48 <base>
 c48:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 c4a:	00000797          	auipc	a5,0x0
 c4e:	0fe78793          	addi	a5,a5,254 # d48 <base>
 c52:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c56:	fe043783          	ld	a5,-32(s0)
 c5a:	639c                	ld	a5,0(a5)
 c5c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 c60:	fe843783          	ld	a5,-24(s0)
 c64:	4798                	lw	a4,8(a5)
 c66:	fdc42783          	lw	a5,-36(s0)
 c6a:	2781                	sext.w	a5,a5
 c6c:	06f76863          	bltu	a4,a5,cdc <malloc+0xf2>
      if(p->s.size == nunits)
 c70:	fe843783          	ld	a5,-24(s0)
 c74:	4798                	lw	a4,8(a5)
 c76:	fdc42783          	lw	a5,-36(s0)
 c7a:	2781                	sext.w	a5,a5
 c7c:	00e79963          	bne	a5,a4,c8e <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 c80:	fe843783          	ld	a5,-24(s0)
 c84:	6398                	ld	a4,0(a5)
 c86:	fe043783          	ld	a5,-32(s0)
 c8a:	e398                	sd	a4,0(a5)
 c8c:	a82d                	j	cc6 <malloc+0xdc>
      else {
        p->s.size -= nunits;
 c8e:	fe843783          	ld	a5,-24(s0)
 c92:	4798                	lw	a4,8(a5)
 c94:	fdc42783          	lw	a5,-36(s0)
 c98:	40f707bb          	subw	a5,a4,a5
 c9c:	0007871b          	sext.w	a4,a5
 ca0:	fe843783          	ld	a5,-24(s0)
 ca4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ca6:	fe843783          	ld	a5,-24(s0)
 caa:	479c                	lw	a5,8(a5)
 cac:	1782                	slli	a5,a5,0x20
 cae:	9381                	srli	a5,a5,0x20
 cb0:	0792                	slli	a5,a5,0x4
 cb2:	fe843703          	ld	a4,-24(s0)
 cb6:	97ba                	add	a5,a5,a4
 cb8:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 cbc:	fe843783          	ld	a5,-24(s0)
 cc0:	fdc42703          	lw	a4,-36(s0)
 cc4:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 cc6:	00000797          	auipc	a5,0x0
 cca:	09278793          	addi	a5,a5,146 # d58 <freep>
 cce:	fe043703          	ld	a4,-32(s0)
 cd2:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 cd4:	fe843783          	ld	a5,-24(s0)
 cd8:	07c1                	addi	a5,a5,16
 cda:	a091                	j	d1e <malloc+0x134>
    }
    if(p == freep)
 cdc:	00000797          	auipc	a5,0x0
 ce0:	07c78793          	addi	a5,a5,124 # d58 <freep>
 ce4:	639c                	ld	a5,0(a5)
 ce6:	fe843703          	ld	a4,-24(s0)
 cea:	02f71063          	bne	a4,a5,d0a <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 cee:	fdc42783          	lw	a5,-36(s0)
 cf2:	853e                	mv	a0,a5
 cf4:	00000097          	auipc	ra,0x0
 cf8:	e76080e7          	jalr	-394(ra) # b6a <morecore>
 cfc:	fea43423          	sd	a0,-24(s0)
 d00:	fe843783          	ld	a5,-24(s0)
 d04:	e399                	bnez	a5,d0a <malloc+0x120>
        return 0;
 d06:	4781                	li	a5,0
 d08:	a819                	j	d1e <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d0a:	fe843783          	ld	a5,-24(s0)
 d0e:	fef43023          	sd	a5,-32(s0)
 d12:	fe843783          	ld	a5,-24(s0)
 d16:	639c                	ld	a5,0(a5)
 d18:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d1c:	b791                	j	c60 <malloc+0x76>
  }
}
 d1e:	853e                	mv	a0,a5
 d20:	70e2                	ld	ra,56(sp)
 d22:	7442                	ld	s0,48(sp)
 d24:	6121                	addi	sp,sp,64
 d26:	8082                	ret
