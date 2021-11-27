
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
   8:	87aa                	mv	a5,a0
   a:	fcb43823          	sd	a1,-48(s0)
   e:	fcf42e23          	sw	a5,-36(s0)
  int i;

  if(argc < 2){
  12:	fdc42783          	lw	a5,-36(s0)
  16:	0007871b          	sext.w	a4,a5
  1a:	4785                	li	a5,1
  1c:	02e7c063          	blt	a5,a4,3c <main+0x3c>
    fprintf(2, "usage: kill pid...\n");
  20:	00001597          	auipc	a1,0x1
  24:	d7058593          	addi	a1,a1,-656 # d90 <malloc+0x144>
  28:	4509                	li	a0,2
  2a:	00001097          	auipc	ra,0x1
  2e:	9d8080e7          	jalr	-1576(ra) # a02 <fprintf>
    exit(1);
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	4e8080e7          	jalr	1256(ra) # 51c <exit>
  }
  for(i=1; i<argc; i++)
  3c:	4785                	li	a5,1
  3e:	fef42623          	sw	a5,-20(s0)
  42:	a805                	j	72 <main+0x72>
    kill(atoi(argv[i]));
  44:	fec42783          	lw	a5,-20(s0)
  48:	078e                	slli	a5,a5,0x3
  4a:	fd043703          	ld	a4,-48(s0)
  4e:	97ba                	add	a5,a5,a4
  50:	639c                	ld	a5,0(a5)
  52:	853e                	mv	a0,a5
  54:	00000097          	auipc	ra,0x0
  58:	2d0080e7          	jalr	720(ra) # 324 <atoi>
  5c:	87aa                	mv	a5,a0
  5e:	853e                	mv	a0,a5
  60:	00000097          	auipc	ra,0x0
  64:	4ec080e7          	jalr	1260(ra) # 54c <kill>
  for(i=1; i<argc; i++)
  68:	fec42783          	lw	a5,-20(s0)
  6c:	2785                	addiw	a5,a5,1
  6e:	fef42623          	sw	a5,-20(s0)
  72:	fec42703          	lw	a4,-20(s0)
  76:	fdc42783          	lw	a5,-36(s0)
  7a:	2701                	sext.w	a4,a4
  7c:	2781                	sext.w	a5,a5
  7e:	fcf743e3          	blt	a4,a5,44 <main+0x44>
  exit(0);
  82:	4501                	li	a0,0
  84:	00000097          	auipc	ra,0x0
  88:	498080e7          	jalr	1176(ra) # 51c <exit>

000000000000008c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  8c:	7179                	addi	sp,sp,-48
  8e:	f422                	sd	s0,40(sp)
  90:	1800                	addi	s0,sp,48
  92:	fca43c23          	sd	a0,-40(s0)
  96:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  9a:	fd843783          	ld	a5,-40(s0)
  9e:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  a2:	0001                	nop
  a4:	fd043703          	ld	a4,-48(s0)
  a8:	00170793          	addi	a5,a4,1
  ac:	fcf43823          	sd	a5,-48(s0)
  b0:	fd843783          	ld	a5,-40(s0)
  b4:	00178693          	addi	a3,a5,1
  b8:	fcd43c23          	sd	a3,-40(s0)
  bc:	00074703          	lbu	a4,0(a4)
  c0:	00e78023          	sb	a4,0(a5)
  c4:	0007c783          	lbu	a5,0(a5)
  c8:	fff1                	bnez	a5,a4 <strcpy+0x18>
    ;
  return os;
  ca:	fe843783          	ld	a5,-24(s0)
}
  ce:	853e                	mv	a0,a5
  d0:	7422                	ld	s0,40(sp)
  d2:	6145                	addi	sp,sp,48
  d4:	8082                	ret

00000000000000d6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d6:	1101                	addi	sp,sp,-32
  d8:	ec22                	sd	s0,24(sp)
  da:	1000                	addi	s0,sp,32
  dc:	fea43423          	sd	a0,-24(s0)
  e0:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
  e4:	a819                	j	fa <strcmp+0x24>
    p++, q++;
  e6:	fe843783          	ld	a5,-24(s0)
  ea:	0785                	addi	a5,a5,1
  ec:	fef43423          	sd	a5,-24(s0)
  f0:	fe043783          	ld	a5,-32(s0)
  f4:	0785                	addi	a5,a5,1
  f6:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
  fa:	fe843783          	ld	a5,-24(s0)
  fe:	0007c783          	lbu	a5,0(a5)
 102:	cb99                	beqz	a5,118 <strcmp+0x42>
 104:	fe843783          	ld	a5,-24(s0)
 108:	0007c703          	lbu	a4,0(a5)
 10c:	fe043783          	ld	a5,-32(s0)
 110:	0007c783          	lbu	a5,0(a5)
 114:	fcf709e3          	beq	a4,a5,e6 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 118:	fe843783          	ld	a5,-24(s0)
 11c:	0007c783          	lbu	a5,0(a5)
 120:	0007871b          	sext.w	a4,a5
 124:	fe043783          	ld	a5,-32(s0)
 128:	0007c783          	lbu	a5,0(a5)
 12c:	2781                	sext.w	a5,a5
 12e:	40f707bb          	subw	a5,a4,a5
 132:	2781                	sext.w	a5,a5
}
 134:	853e                	mv	a0,a5
 136:	6462                	ld	s0,24(sp)
 138:	6105                	addi	sp,sp,32
 13a:	8082                	ret

000000000000013c <strlen>:

uint
strlen(const char *s)
{
 13c:	7179                	addi	sp,sp,-48
 13e:	f422                	sd	s0,40(sp)
 140:	1800                	addi	s0,sp,48
 142:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 146:	fe042623          	sw	zero,-20(s0)
 14a:	a031                	j	156 <strlen+0x1a>
 14c:	fec42783          	lw	a5,-20(s0)
 150:	2785                	addiw	a5,a5,1
 152:	fef42623          	sw	a5,-20(s0)
 156:	fec42783          	lw	a5,-20(s0)
 15a:	fd843703          	ld	a4,-40(s0)
 15e:	97ba                	add	a5,a5,a4
 160:	0007c783          	lbu	a5,0(a5)
 164:	f7e5                	bnez	a5,14c <strlen+0x10>
    ;
  return n;
 166:	fec42783          	lw	a5,-20(s0)
}
 16a:	853e                	mv	a0,a5
 16c:	7422                	ld	s0,40(sp)
 16e:	6145                	addi	sp,sp,48
 170:	8082                	ret

0000000000000172 <memset>:

void*
memset(void *dst, int c, uint n)
{
 172:	7179                	addi	sp,sp,-48
 174:	f422                	sd	s0,40(sp)
 176:	1800                	addi	s0,sp,48
 178:	fca43c23          	sd	a0,-40(s0)
 17c:	87ae                	mv	a5,a1
 17e:	8732                	mv	a4,a2
 180:	fcf42a23          	sw	a5,-44(s0)
 184:	87ba                	mv	a5,a4
 186:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 18a:	fd843783          	ld	a5,-40(s0)
 18e:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 192:	fe042623          	sw	zero,-20(s0)
 196:	a00d                	j	1b8 <memset+0x46>
    cdst[i] = c;
 198:	fec42783          	lw	a5,-20(s0)
 19c:	fe043703          	ld	a4,-32(s0)
 1a0:	97ba                	add	a5,a5,a4
 1a2:	fd442703          	lw	a4,-44(s0)
 1a6:	0ff77713          	andi	a4,a4,255
 1aa:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1ae:	fec42783          	lw	a5,-20(s0)
 1b2:	2785                	addiw	a5,a5,1
 1b4:	fef42623          	sw	a5,-20(s0)
 1b8:	fec42703          	lw	a4,-20(s0)
 1bc:	fd042783          	lw	a5,-48(s0)
 1c0:	2781                	sext.w	a5,a5
 1c2:	fcf76be3          	bltu	a4,a5,198 <memset+0x26>
  }
  return dst;
 1c6:	fd843783          	ld	a5,-40(s0)
}
 1ca:	853e                	mv	a0,a5
 1cc:	7422                	ld	s0,40(sp)
 1ce:	6145                	addi	sp,sp,48
 1d0:	8082                	ret

00000000000001d2 <strchr>:

char*
strchr(const char *s, char c)
{
 1d2:	1101                	addi	sp,sp,-32
 1d4:	ec22                	sd	s0,24(sp)
 1d6:	1000                	addi	s0,sp,32
 1d8:	fea43423          	sd	a0,-24(s0)
 1dc:	87ae                	mv	a5,a1
 1de:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 1e2:	a01d                	j	208 <strchr+0x36>
    if(*s == c)
 1e4:	fe843783          	ld	a5,-24(s0)
 1e8:	0007c703          	lbu	a4,0(a5)
 1ec:	fe744783          	lbu	a5,-25(s0)
 1f0:	0ff7f793          	andi	a5,a5,255
 1f4:	00e79563          	bne	a5,a4,1fe <strchr+0x2c>
      return (char*)s;
 1f8:	fe843783          	ld	a5,-24(s0)
 1fc:	a821                	j	214 <strchr+0x42>
  for(; *s; s++)
 1fe:	fe843783          	ld	a5,-24(s0)
 202:	0785                	addi	a5,a5,1
 204:	fef43423          	sd	a5,-24(s0)
 208:	fe843783          	ld	a5,-24(s0)
 20c:	0007c783          	lbu	a5,0(a5)
 210:	fbf1                	bnez	a5,1e4 <strchr+0x12>
  return 0;
 212:	4781                	li	a5,0
}
 214:	853e                	mv	a0,a5
 216:	6462                	ld	s0,24(sp)
 218:	6105                	addi	sp,sp,32
 21a:	8082                	ret

000000000000021c <gets>:

char*
gets(char *buf, int max)
{
 21c:	7179                	addi	sp,sp,-48
 21e:	f406                	sd	ra,40(sp)
 220:	f022                	sd	s0,32(sp)
 222:	1800                	addi	s0,sp,48
 224:	fca43c23          	sd	a0,-40(s0)
 228:	87ae                	mv	a5,a1
 22a:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22e:	fe042623          	sw	zero,-20(s0)
 232:	a8a1                	j	28a <gets+0x6e>
    cc = read(0, &c, 1);
 234:	fe740793          	addi	a5,s0,-25
 238:	4605                	li	a2,1
 23a:	85be                	mv	a1,a5
 23c:	4501                	li	a0,0
 23e:	00000097          	auipc	ra,0x0
 242:	2f6080e7          	jalr	758(ra) # 534 <read>
 246:	87aa                	mv	a5,a0
 248:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 24c:	fe842783          	lw	a5,-24(s0)
 250:	2781                	sext.w	a5,a5
 252:	04f05763          	blez	a5,2a0 <gets+0x84>
      break;
    buf[i++] = c;
 256:	fec42783          	lw	a5,-20(s0)
 25a:	0017871b          	addiw	a4,a5,1
 25e:	fee42623          	sw	a4,-20(s0)
 262:	873e                	mv	a4,a5
 264:	fd843783          	ld	a5,-40(s0)
 268:	97ba                	add	a5,a5,a4
 26a:	fe744703          	lbu	a4,-25(s0)
 26e:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 272:	fe744783          	lbu	a5,-25(s0)
 276:	873e                	mv	a4,a5
 278:	47a9                	li	a5,10
 27a:	02f70463          	beq	a4,a5,2a2 <gets+0x86>
 27e:	fe744783          	lbu	a5,-25(s0)
 282:	873e                	mv	a4,a5
 284:	47b5                	li	a5,13
 286:	00f70e63          	beq	a4,a5,2a2 <gets+0x86>
  for(i=0; i+1 < max; ){
 28a:	fec42783          	lw	a5,-20(s0)
 28e:	2785                	addiw	a5,a5,1
 290:	0007871b          	sext.w	a4,a5
 294:	fd442783          	lw	a5,-44(s0)
 298:	2781                	sext.w	a5,a5
 29a:	f8f74de3          	blt	a4,a5,234 <gets+0x18>
 29e:	a011                	j	2a2 <gets+0x86>
      break;
 2a0:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2a2:	fec42783          	lw	a5,-20(s0)
 2a6:	fd843703          	ld	a4,-40(s0)
 2aa:	97ba                	add	a5,a5,a4
 2ac:	00078023          	sb	zero,0(a5)
  return buf;
 2b0:	fd843783          	ld	a5,-40(s0)
}
 2b4:	853e                	mv	a0,a5
 2b6:	70a2                	ld	ra,40(sp)
 2b8:	7402                	ld	s0,32(sp)
 2ba:	6145                	addi	sp,sp,48
 2bc:	8082                	ret

00000000000002be <stat>:

int
stat(const char *n, struct stat *st)
{
 2be:	7179                	addi	sp,sp,-48
 2c0:	f406                	sd	ra,40(sp)
 2c2:	f022                	sd	s0,32(sp)
 2c4:	1800                	addi	s0,sp,48
 2c6:	fca43c23          	sd	a0,-40(s0)
 2ca:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ce:	4581                	li	a1,0
 2d0:	fd843503          	ld	a0,-40(s0)
 2d4:	00000097          	auipc	ra,0x0
 2d8:	288080e7          	jalr	648(ra) # 55c <open>
 2dc:	87aa                	mv	a5,a0
 2de:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 2e2:	fec42783          	lw	a5,-20(s0)
 2e6:	2781                	sext.w	a5,a5
 2e8:	0007d463          	bgez	a5,2f0 <stat+0x32>
    return -1;
 2ec:	57fd                	li	a5,-1
 2ee:	a035                	j	31a <stat+0x5c>
  r = fstat(fd, st);
 2f0:	fec42783          	lw	a5,-20(s0)
 2f4:	fd043583          	ld	a1,-48(s0)
 2f8:	853e                	mv	a0,a5
 2fa:	00000097          	auipc	ra,0x0
 2fe:	27a080e7          	jalr	634(ra) # 574 <fstat>
 302:	87aa                	mv	a5,a0
 304:	fef42423          	sw	a5,-24(s0)
  close(fd);
 308:	fec42783          	lw	a5,-20(s0)
 30c:	853e                	mv	a0,a5
 30e:	00000097          	auipc	ra,0x0
 312:	236080e7          	jalr	566(ra) # 544 <close>
  return r;
 316:	fe842783          	lw	a5,-24(s0)
}
 31a:	853e                	mv	a0,a5
 31c:	70a2                	ld	ra,40(sp)
 31e:	7402                	ld	s0,32(sp)
 320:	6145                	addi	sp,sp,48
 322:	8082                	ret

0000000000000324 <atoi>:

int
atoi(const char *s)
{
 324:	7179                	addi	sp,sp,-48
 326:	f422                	sd	s0,40(sp)
 328:	1800                	addi	s0,sp,48
 32a:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 32e:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 332:	a815                	j	366 <atoi+0x42>
    n = n*10 + *s++ - '0';
 334:	fec42703          	lw	a4,-20(s0)
 338:	87ba                	mv	a5,a4
 33a:	0027979b          	slliw	a5,a5,0x2
 33e:	9fb9                	addw	a5,a5,a4
 340:	0017979b          	slliw	a5,a5,0x1
 344:	0007871b          	sext.w	a4,a5
 348:	fd843783          	ld	a5,-40(s0)
 34c:	00178693          	addi	a3,a5,1
 350:	fcd43c23          	sd	a3,-40(s0)
 354:	0007c783          	lbu	a5,0(a5)
 358:	2781                	sext.w	a5,a5
 35a:	9fb9                	addw	a5,a5,a4
 35c:	2781                	sext.w	a5,a5
 35e:	fd07879b          	addiw	a5,a5,-48
 362:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 366:	fd843783          	ld	a5,-40(s0)
 36a:	0007c783          	lbu	a5,0(a5)
 36e:	873e                	mv	a4,a5
 370:	02f00793          	li	a5,47
 374:	00e7fb63          	bgeu	a5,a4,38a <atoi+0x66>
 378:	fd843783          	ld	a5,-40(s0)
 37c:	0007c783          	lbu	a5,0(a5)
 380:	873e                	mv	a4,a5
 382:	03900793          	li	a5,57
 386:	fae7f7e3          	bgeu	a5,a4,334 <atoi+0x10>
  return n;
 38a:	fec42783          	lw	a5,-20(s0)
}
 38e:	853e                	mv	a0,a5
 390:	7422                	ld	s0,40(sp)
 392:	6145                	addi	sp,sp,48
 394:	8082                	ret

0000000000000396 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 396:	7139                	addi	sp,sp,-64
 398:	fc22                	sd	s0,56(sp)
 39a:	0080                	addi	s0,sp,64
 39c:	fca43c23          	sd	a0,-40(s0)
 3a0:	fcb43823          	sd	a1,-48(s0)
 3a4:	87b2                	mv	a5,a2
 3a6:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3aa:	fd843783          	ld	a5,-40(s0)
 3ae:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3b2:	fd043783          	ld	a5,-48(s0)
 3b6:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3ba:	fe043703          	ld	a4,-32(s0)
 3be:	fe843783          	ld	a5,-24(s0)
 3c2:	02e7fc63          	bgeu	a5,a4,3fa <memmove+0x64>
    while(n-- > 0)
 3c6:	a00d                	j	3e8 <memmove+0x52>
      *dst++ = *src++;
 3c8:	fe043703          	ld	a4,-32(s0)
 3cc:	00170793          	addi	a5,a4,1
 3d0:	fef43023          	sd	a5,-32(s0)
 3d4:	fe843783          	ld	a5,-24(s0)
 3d8:	00178693          	addi	a3,a5,1
 3dc:	fed43423          	sd	a3,-24(s0)
 3e0:	00074703          	lbu	a4,0(a4)
 3e4:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3e8:	fcc42783          	lw	a5,-52(s0)
 3ec:	fff7871b          	addiw	a4,a5,-1
 3f0:	fce42623          	sw	a4,-52(s0)
 3f4:	fcf04ae3          	bgtz	a5,3c8 <memmove+0x32>
 3f8:	a891                	j	44c <memmove+0xb6>
  } else {
    dst += n;
 3fa:	fcc42783          	lw	a5,-52(s0)
 3fe:	fe843703          	ld	a4,-24(s0)
 402:	97ba                	add	a5,a5,a4
 404:	fef43423          	sd	a5,-24(s0)
    src += n;
 408:	fcc42783          	lw	a5,-52(s0)
 40c:	fe043703          	ld	a4,-32(s0)
 410:	97ba                	add	a5,a5,a4
 412:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 416:	a01d                	j	43c <memmove+0xa6>
      *--dst = *--src;
 418:	fe043783          	ld	a5,-32(s0)
 41c:	17fd                	addi	a5,a5,-1
 41e:	fef43023          	sd	a5,-32(s0)
 422:	fe843783          	ld	a5,-24(s0)
 426:	17fd                	addi	a5,a5,-1
 428:	fef43423          	sd	a5,-24(s0)
 42c:	fe043783          	ld	a5,-32(s0)
 430:	0007c703          	lbu	a4,0(a5)
 434:	fe843783          	ld	a5,-24(s0)
 438:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 43c:	fcc42783          	lw	a5,-52(s0)
 440:	fff7871b          	addiw	a4,a5,-1
 444:	fce42623          	sw	a4,-52(s0)
 448:	fcf048e3          	bgtz	a5,418 <memmove+0x82>
  }
  return vdst;
 44c:	fd843783          	ld	a5,-40(s0)
}
 450:	853e                	mv	a0,a5
 452:	7462                	ld	s0,56(sp)
 454:	6121                	addi	sp,sp,64
 456:	8082                	ret

0000000000000458 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 458:	7139                	addi	sp,sp,-64
 45a:	fc22                	sd	s0,56(sp)
 45c:	0080                	addi	s0,sp,64
 45e:	fca43c23          	sd	a0,-40(s0)
 462:	fcb43823          	sd	a1,-48(s0)
 466:	87b2                	mv	a5,a2
 468:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 46c:	fd843783          	ld	a5,-40(s0)
 470:	fef43423          	sd	a5,-24(s0)
 474:	fd043783          	ld	a5,-48(s0)
 478:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 47c:	a0a1                	j	4c4 <memcmp+0x6c>
    if (*p1 != *p2) {
 47e:	fe843783          	ld	a5,-24(s0)
 482:	0007c703          	lbu	a4,0(a5)
 486:	fe043783          	ld	a5,-32(s0)
 48a:	0007c783          	lbu	a5,0(a5)
 48e:	02f70163          	beq	a4,a5,4b0 <memcmp+0x58>
      return *p1 - *p2;
 492:	fe843783          	ld	a5,-24(s0)
 496:	0007c783          	lbu	a5,0(a5)
 49a:	0007871b          	sext.w	a4,a5
 49e:	fe043783          	ld	a5,-32(s0)
 4a2:	0007c783          	lbu	a5,0(a5)
 4a6:	2781                	sext.w	a5,a5
 4a8:	40f707bb          	subw	a5,a4,a5
 4ac:	2781                	sext.w	a5,a5
 4ae:	a01d                	j	4d4 <memcmp+0x7c>
    }
    p1++;
 4b0:	fe843783          	ld	a5,-24(s0)
 4b4:	0785                	addi	a5,a5,1
 4b6:	fef43423          	sd	a5,-24(s0)
    p2++;
 4ba:	fe043783          	ld	a5,-32(s0)
 4be:	0785                	addi	a5,a5,1
 4c0:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4c4:	fcc42783          	lw	a5,-52(s0)
 4c8:	fff7871b          	addiw	a4,a5,-1
 4cc:	fce42623          	sw	a4,-52(s0)
 4d0:	f7dd                	bnez	a5,47e <memcmp+0x26>
  }
  return 0;
 4d2:	4781                	li	a5,0
}
 4d4:	853e                	mv	a0,a5
 4d6:	7462                	ld	s0,56(sp)
 4d8:	6121                	addi	sp,sp,64
 4da:	8082                	ret

00000000000004dc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4dc:	7179                	addi	sp,sp,-48
 4de:	f406                	sd	ra,40(sp)
 4e0:	f022                	sd	s0,32(sp)
 4e2:	1800                	addi	s0,sp,48
 4e4:	fea43423          	sd	a0,-24(s0)
 4e8:	feb43023          	sd	a1,-32(s0)
 4ec:	87b2                	mv	a5,a2
 4ee:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 4f2:	fdc42783          	lw	a5,-36(s0)
 4f6:	863e                	mv	a2,a5
 4f8:	fe043583          	ld	a1,-32(s0)
 4fc:	fe843503          	ld	a0,-24(s0)
 500:	00000097          	auipc	ra,0x0
 504:	e96080e7          	jalr	-362(ra) # 396 <memmove>
 508:	87aa                	mv	a5,a0
}
 50a:	853e                	mv	a0,a5
 50c:	70a2                	ld	ra,40(sp)
 50e:	7402                	ld	s0,32(sp)
 510:	6145                	addi	sp,sp,48
 512:	8082                	ret

0000000000000514 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 514:	4885                	li	a7,1
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <exit>:
.global exit
exit:
 li a7, SYS_exit
 51c:	4889                	li	a7,2
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <wait>:
.global wait
wait:
 li a7, SYS_wait
 524:	488d                	li	a7,3
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 52c:	4891                	li	a7,4
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <read>:
.global read
read:
 li a7, SYS_read
 534:	4895                	li	a7,5
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <write>:
.global write
write:
 li a7, SYS_write
 53c:	48c1                	li	a7,16
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <close>:
.global close
close:
 li a7, SYS_close
 544:	48d5                	li	a7,21
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <kill>:
.global kill
kill:
 li a7, SYS_kill
 54c:	4899                	li	a7,6
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <exec>:
.global exec
exec:
 li a7, SYS_exec
 554:	489d                	li	a7,7
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <open>:
.global open
open:
 li a7, SYS_open
 55c:	48bd                	li	a7,15
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 564:	48c5                	li	a7,17
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 56c:	48c9                	li	a7,18
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 574:	48a1                	li	a7,8
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <link>:
.global link
link:
 li a7, SYS_link
 57c:	48cd                	li	a7,19
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 584:	48d1                	li	a7,20
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 58c:	48a5                	li	a7,9
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <dup>:
.global dup
dup:
 li a7, SYS_dup
 594:	48a9                	li	a7,10
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 59c:	48ad                	li	a7,11
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5a4:	48b1                	li	a7,12
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5ac:	48b5                	li	a7,13
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5b4:	48b9                	li	a7,14
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 5bc:	48d9                	li	a7,22
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <setpri>:
.global setpri
setpri:
 li a7, SYS_setpri
 5c4:	48dd                	li	a7,23
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5cc:	1101                	addi	sp,sp,-32
 5ce:	ec06                	sd	ra,24(sp)
 5d0:	e822                	sd	s0,16(sp)
 5d2:	1000                	addi	s0,sp,32
 5d4:	87aa                	mv	a5,a0
 5d6:	872e                	mv	a4,a1
 5d8:	fef42623          	sw	a5,-20(s0)
 5dc:	87ba                	mv	a5,a4
 5de:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 5e2:	feb40713          	addi	a4,s0,-21
 5e6:	fec42783          	lw	a5,-20(s0)
 5ea:	4605                	li	a2,1
 5ec:	85ba                	mv	a1,a4
 5ee:	853e                	mv	a0,a5
 5f0:	00000097          	auipc	ra,0x0
 5f4:	f4c080e7          	jalr	-180(ra) # 53c <write>
}
 5f8:	0001                	nop
 5fa:	60e2                	ld	ra,24(sp)
 5fc:	6442                	ld	s0,16(sp)
 5fe:	6105                	addi	sp,sp,32
 600:	8082                	ret

0000000000000602 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 602:	7139                	addi	sp,sp,-64
 604:	fc06                	sd	ra,56(sp)
 606:	f822                	sd	s0,48(sp)
 608:	0080                	addi	s0,sp,64
 60a:	87aa                	mv	a5,a0
 60c:	8736                	mv	a4,a3
 60e:	fcf42623          	sw	a5,-52(s0)
 612:	87ae                	mv	a5,a1
 614:	fcf42423          	sw	a5,-56(s0)
 618:	87b2                	mv	a5,a2
 61a:	fcf42223          	sw	a5,-60(s0)
 61e:	87ba                	mv	a5,a4
 620:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 624:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 628:	fc042783          	lw	a5,-64(s0)
 62c:	2781                	sext.w	a5,a5
 62e:	c38d                	beqz	a5,650 <printint+0x4e>
 630:	fc842783          	lw	a5,-56(s0)
 634:	2781                	sext.w	a5,a5
 636:	0007dd63          	bgez	a5,650 <printint+0x4e>
    neg = 1;
 63a:	4785                	li	a5,1
 63c:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 640:	fc842783          	lw	a5,-56(s0)
 644:	40f007bb          	negw	a5,a5
 648:	2781                	sext.w	a5,a5
 64a:	fef42223          	sw	a5,-28(s0)
 64e:	a029                	j	658 <printint+0x56>
  } else {
    x = xx;
 650:	fc842783          	lw	a5,-56(s0)
 654:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 658:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 65c:	fc442783          	lw	a5,-60(s0)
 660:	fe442703          	lw	a4,-28(s0)
 664:	02f777bb          	remuw	a5,a4,a5
 668:	0007861b          	sext.w	a2,a5
 66c:	fec42783          	lw	a5,-20(s0)
 670:	0017871b          	addiw	a4,a5,1
 674:	fee42623          	sw	a4,-20(s0)
 678:	00000697          	auipc	a3,0x0
 67c:	73868693          	addi	a3,a3,1848 # db0 <digits>
 680:	02061713          	slli	a4,a2,0x20
 684:	9301                	srli	a4,a4,0x20
 686:	9736                	add	a4,a4,a3
 688:	00074703          	lbu	a4,0(a4)
 68c:	ff040693          	addi	a3,s0,-16
 690:	97b6                	add	a5,a5,a3
 692:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 696:	fc442783          	lw	a5,-60(s0)
 69a:	fe442703          	lw	a4,-28(s0)
 69e:	02f757bb          	divuw	a5,a4,a5
 6a2:	fef42223          	sw	a5,-28(s0)
 6a6:	fe442783          	lw	a5,-28(s0)
 6aa:	2781                	sext.w	a5,a5
 6ac:	fbc5                	bnez	a5,65c <printint+0x5a>
  if(neg)
 6ae:	fe842783          	lw	a5,-24(s0)
 6b2:	2781                	sext.w	a5,a5
 6b4:	cf95                	beqz	a5,6f0 <printint+0xee>
    buf[i++] = '-';
 6b6:	fec42783          	lw	a5,-20(s0)
 6ba:	0017871b          	addiw	a4,a5,1
 6be:	fee42623          	sw	a4,-20(s0)
 6c2:	ff040713          	addi	a4,s0,-16
 6c6:	97ba                	add	a5,a5,a4
 6c8:	02d00713          	li	a4,45
 6cc:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6d0:	a005                	j	6f0 <printint+0xee>
    putc(fd, buf[i]);
 6d2:	fec42783          	lw	a5,-20(s0)
 6d6:	ff040713          	addi	a4,s0,-16
 6da:	97ba                	add	a5,a5,a4
 6dc:	fe07c703          	lbu	a4,-32(a5)
 6e0:	fcc42783          	lw	a5,-52(s0)
 6e4:	85ba                	mv	a1,a4
 6e6:	853e                	mv	a0,a5
 6e8:	00000097          	auipc	ra,0x0
 6ec:	ee4080e7          	jalr	-284(ra) # 5cc <putc>
  while(--i >= 0)
 6f0:	fec42783          	lw	a5,-20(s0)
 6f4:	37fd                	addiw	a5,a5,-1
 6f6:	fef42623          	sw	a5,-20(s0)
 6fa:	fec42783          	lw	a5,-20(s0)
 6fe:	2781                	sext.w	a5,a5
 700:	fc07d9e3          	bgez	a5,6d2 <printint+0xd0>
}
 704:	0001                	nop
 706:	0001                	nop
 708:	70e2                	ld	ra,56(sp)
 70a:	7442                	ld	s0,48(sp)
 70c:	6121                	addi	sp,sp,64
 70e:	8082                	ret

0000000000000710 <printptr>:

static void
printptr(int fd, uint64 x) {
 710:	7179                	addi	sp,sp,-48
 712:	f406                	sd	ra,40(sp)
 714:	f022                	sd	s0,32(sp)
 716:	1800                	addi	s0,sp,48
 718:	87aa                	mv	a5,a0
 71a:	fcb43823          	sd	a1,-48(s0)
 71e:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 722:	fdc42783          	lw	a5,-36(s0)
 726:	03000593          	li	a1,48
 72a:	853e                	mv	a0,a5
 72c:	00000097          	auipc	ra,0x0
 730:	ea0080e7          	jalr	-352(ra) # 5cc <putc>
  putc(fd, 'x');
 734:	fdc42783          	lw	a5,-36(s0)
 738:	07800593          	li	a1,120
 73c:	853e                	mv	a0,a5
 73e:	00000097          	auipc	ra,0x0
 742:	e8e080e7          	jalr	-370(ra) # 5cc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 746:	fe042623          	sw	zero,-20(s0)
 74a:	a82d                	j	784 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 74c:	fd043783          	ld	a5,-48(s0)
 750:	93f1                	srli	a5,a5,0x3c
 752:	00000717          	auipc	a4,0x0
 756:	65e70713          	addi	a4,a4,1630 # db0 <digits>
 75a:	97ba                	add	a5,a5,a4
 75c:	0007c703          	lbu	a4,0(a5)
 760:	fdc42783          	lw	a5,-36(s0)
 764:	85ba                	mv	a1,a4
 766:	853e                	mv	a0,a5
 768:	00000097          	auipc	ra,0x0
 76c:	e64080e7          	jalr	-412(ra) # 5cc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 770:	fec42783          	lw	a5,-20(s0)
 774:	2785                	addiw	a5,a5,1
 776:	fef42623          	sw	a5,-20(s0)
 77a:	fd043783          	ld	a5,-48(s0)
 77e:	0792                	slli	a5,a5,0x4
 780:	fcf43823          	sd	a5,-48(s0)
 784:	fec42783          	lw	a5,-20(s0)
 788:	873e                	mv	a4,a5
 78a:	47bd                	li	a5,15
 78c:	fce7f0e3          	bgeu	a5,a4,74c <printptr+0x3c>
}
 790:	0001                	nop
 792:	0001                	nop
 794:	70a2                	ld	ra,40(sp)
 796:	7402                	ld	s0,32(sp)
 798:	6145                	addi	sp,sp,48
 79a:	8082                	ret

000000000000079c <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 79c:	715d                	addi	sp,sp,-80
 79e:	e486                	sd	ra,72(sp)
 7a0:	e0a2                	sd	s0,64(sp)
 7a2:	0880                	addi	s0,sp,80
 7a4:	87aa                	mv	a5,a0
 7a6:	fcb43023          	sd	a1,-64(s0)
 7aa:	fac43c23          	sd	a2,-72(s0)
 7ae:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 7b2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7b6:	fe042223          	sw	zero,-28(s0)
 7ba:	a42d                	j	9e4 <vprintf+0x248>
    c = fmt[i] & 0xff;
 7bc:	fe442783          	lw	a5,-28(s0)
 7c0:	fc043703          	ld	a4,-64(s0)
 7c4:	97ba                	add	a5,a5,a4
 7c6:	0007c783          	lbu	a5,0(a5)
 7ca:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7ce:	fe042783          	lw	a5,-32(s0)
 7d2:	2781                	sext.w	a5,a5
 7d4:	eb9d                	bnez	a5,80a <vprintf+0x6e>
      if(c == '%'){
 7d6:	fdc42783          	lw	a5,-36(s0)
 7da:	0007871b          	sext.w	a4,a5
 7de:	02500793          	li	a5,37
 7e2:	00f71763          	bne	a4,a5,7f0 <vprintf+0x54>
        state = '%';
 7e6:	02500793          	li	a5,37
 7ea:	fef42023          	sw	a5,-32(s0)
 7ee:	a2f5                	j	9da <vprintf+0x23e>
      } else {
        putc(fd, c);
 7f0:	fdc42783          	lw	a5,-36(s0)
 7f4:	0ff7f713          	andi	a4,a5,255
 7f8:	fcc42783          	lw	a5,-52(s0)
 7fc:	85ba                	mv	a1,a4
 7fe:	853e                	mv	a0,a5
 800:	00000097          	auipc	ra,0x0
 804:	dcc080e7          	jalr	-564(ra) # 5cc <putc>
 808:	aac9                	j	9da <vprintf+0x23e>
      }
    } else if(state == '%'){
 80a:	fe042783          	lw	a5,-32(s0)
 80e:	0007871b          	sext.w	a4,a5
 812:	02500793          	li	a5,37
 816:	1cf71263          	bne	a4,a5,9da <vprintf+0x23e>
      if(c == 'd'){
 81a:	fdc42783          	lw	a5,-36(s0)
 81e:	0007871b          	sext.w	a4,a5
 822:	06400793          	li	a5,100
 826:	02f71463          	bne	a4,a5,84e <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 82a:	fb843783          	ld	a5,-72(s0)
 82e:	00878713          	addi	a4,a5,8
 832:	fae43c23          	sd	a4,-72(s0)
 836:	4398                	lw	a4,0(a5)
 838:	fcc42783          	lw	a5,-52(s0)
 83c:	4685                	li	a3,1
 83e:	4629                	li	a2,10
 840:	85ba                	mv	a1,a4
 842:	853e                	mv	a0,a5
 844:	00000097          	auipc	ra,0x0
 848:	dbe080e7          	jalr	-578(ra) # 602 <printint>
 84c:	a269                	j	9d6 <vprintf+0x23a>
      } else if(c == 'l') {
 84e:	fdc42783          	lw	a5,-36(s0)
 852:	0007871b          	sext.w	a4,a5
 856:	06c00793          	li	a5,108
 85a:	02f71663          	bne	a4,a5,886 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 85e:	fb843783          	ld	a5,-72(s0)
 862:	00878713          	addi	a4,a5,8
 866:	fae43c23          	sd	a4,-72(s0)
 86a:	639c                	ld	a5,0(a5)
 86c:	0007871b          	sext.w	a4,a5
 870:	fcc42783          	lw	a5,-52(s0)
 874:	4681                	li	a3,0
 876:	4629                	li	a2,10
 878:	85ba                	mv	a1,a4
 87a:	853e                	mv	a0,a5
 87c:	00000097          	auipc	ra,0x0
 880:	d86080e7          	jalr	-634(ra) # 602 <printint>
 884:	aa89                	j	9d6 <vprintf+0x23a>
      } else if(c == 'x') {
 886:	fdc42783          	lw	a5,-36(s0)
 88a:	0007871b          	sext.w	a4,a5
 88e:	07800793          	li	a5,120
 892:	02f71463          	bne	a4,a5,8ba <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 896:	fb843783          	ld	a5,-72(s0)
 89a:	00878713          	addi	a4,a5,8
 89e:	fae43c23          	sd	a4,-72(s0)
 8a2:	4398                	lw	a4,0(a5)
 8a4:	fcc42783          	lw	a5,-52(s0)
 8a8:	4681                	li	a3,0
 8aa:	4641                	li	a2,16
 8ac:	85ba                	mv	a1,a4
 8ae:	853e                	mv	a0,a5
 8b0:	00000097          	auipc	ra,0x0
 8b4:	d52080e7          	jalr	-686(ra) # 602 <printint>
 8b8:	aa39                	j	9d6 <vprintf+0x23a>
      } else if(c == 'p') {
 8ba:	fdc42783          	lw	a5,-36(s0)
 8be:	0007871b          	sext.w	a4,a5
 8c2:	07000793          	li	a5,112
 8c6:	02f71263          	bne	a4,a5,8ea <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8ca:	fb843783          	ld	a5,-72(s0)
 8ce:	00878713          	addi	a4,a5,8
 8d2:	fae43c23          	sd	a4,-72(s0)
 8d6:	6398                	ld	a4,0(a5)
 8d8:	fcc42783          	lw	a5,-52(s0)
 8dc:	85ba                	mv	a1,a4
 8de:	853e                	mv	a0,a5
 8e0:	00000097          	auipc	ra,0x0
 8e4:	e30080e7          	jalr	-464(ra) # 710 <printptr>
 8e8:	a0fd                	j	9d6 <vprintf+0x23a>
      } else if(c == 's'){
 8ea:	fdc42783          	lw	a5,-36(s0)
 8ee:	0007871b          	sext.w	a4,a5
 8f2:	07300793          	li	a5,115
 8f6:	04f71c63          	bne	a4,a5,94e <vprintf+0x1b2>
        s = va_arg(ap, char*);
 8fa:	fb843783          	ld	a5,-72(s0)
 8fe:	00878713          	addi	a4,a5,8
 902:	fae43c23          	sd	a4,-72(s0)
 906:	639c                	ld	a5,0(a5)
 908:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 90c:	fe843783          	ld	a5,-24(s0)
 910:	eb8d                	bnez	a5,942 <vprintf+0x1a6>
          s = "(null)";
 912:	00000797          	auipc	a5,0x0
 916:	49678793          	addi	a5,a5,1174 # da8 <malloc+0x15c>
 91a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 91e:	a015                	j	942 <vprintf+0x1a6>
          putc(fd, *s);
 920:	fe843783          	ld	a5,-24(s0)
 924:	0007c703          	lbu	a4,0(a5)
 928:	fcc42783          	lw	a5,-52(s0)
 92c:	85ba                	mv	a1,a4
 92e:	853e                	mv	a0,a5
 930:	00000097          	auipc	ra,0x0
 934:	c9c080e7          	jalr	-868(ra) # 5cc <putc>
          s++;
 938:	fe843783          	ld	a5,-24(s0)
 93c:	0785                	addi	a5,a5,1
 93e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 942:	fe843783          	ld	a5,-24(s0)
 946:	0007c783          	lbu	a5,0(a5)
 94a:	fbf9                	bnez	a5,920 <vprintf+0x184>
 94c:	a069                	j	9d6 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 94e:	fdc42783          	lw	a5,-36(s0)
 952:	0007871b          	sext.w	a4,a5
 956:	06300793          	li	a5,99
 95a:	02f71463          	bne	a4,a5,982 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 95e:	fb843783          	ld	a5,-72(s0)
 962:	00878713          	addi	a4,a5,8
 966:	fae43c23          	sd	a4,-72(s0)
 96a:	439c                	lw	a5,0(a5)
 96c:	0ff7f713          	andi	a4,a5,255
 970:	fcc42783          	lw	a5,-52(s0)
 974:	85ba                	mv	a1,a4
 976:	853e                	mv	a0,a5
 978:	00000097          	auipc	ra,0x0
 97c:	c54080e7          	jalr	-940(ra) # 5cc <putc>
 980:	a899                	j	9d6 <vprintf+0x23a>
      } else if(c == '%'){
 982:	fdc42783          	lw	a5,-36(s0)
 986:	0007871b          	sext.w	a4,a5
 98a:	02500793          	li	a5,37
 98e:	00f71f63          	bne	a4,a5,9ac <vprintf+0x210>
        putc(fd, c);
 992:	fdc42783          	lw	a5,-36(s0)
 996:	0ff7f713          	andi	a4,a5,255
 99a:	fcc42783          	lw	a5,-52(s0)
 99e:	85ba                	mv	a1,a4
 9a0:	853e                	mv	a0,a5
 9a2:	00000097          	auipc	ra,0x0
 9a6:	c2a080e7          	jalr	-982(ra) # 5cc <putc>
 9aa:	a035                	j	9d6 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9ac:	fcc42783          	lw	a5,-52(s0)
 9b0:	02500593          	li	a1,37
 9b4:	853e                	mv	a0,a5
 9b6:	00000097          	auipc	ra,0x0
 9ba:	c16080e7          	jalr	-1002(ra) # 5cc <putc>
        putc(fd, c);
 9be:	fdc42783          	lw	a5,-36(s0)
 9c2:	0ff7f713          	andi	a4,a5,255
 9c6:	fcc42783          	lw	a5,-52(s0)
 9ca:	85ba                	mv	a1,a4
 9cc:	853e                	mv	a0,a5
 9ce:	00000097          	auipc	ra,0x0
 9d2:	bfe080e7          	jalr	-1026(ra) # 5cc <putc>
      }
      state = 0;
 9d6:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 9da:	fe442783          	lw	a5,-28(s0)
 9de:	2785                	addiw	a5,a5,1
 9e0:	fef42223          	sw	a5,-28(s0)
 9e4:	fe442783          	lw	a5,-28(s0)
 9e8:	fc043703          	ld	a4,-64(s0)
 9ec:	97ba                	add	a5,a5,a4
 9ee:	0007c783          	lbu	a5,0(a5)
 9f2:	dc0795e3          	bnez	a5,7bc <vprintf+0x20>
    }
  }
}
 9f6:	0001                	nop
 9f8:	0001                	nop
 9fa:	60a6                	ld	ra,72(sp)
 9fc:	6406                	ld	s0,64(sp)
 9fe:	6161                	addi	sp,sp,80
 a00:	8082                	ret

0000000000000a02 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a02:	7159                	addi	sp,sp,-112
 a04:	fc06                	sd	ra,56(sp)
 a06:	f822                	sd	s0,48(sp)
 a08:	0080                	addi	s0,sp,64
 a0a:	fcb43823          	sd	a1,-48(s0)
 a0e:	e010                	sd	a2,0(s0)
 a10:	e414                	sd	a3,8(s0)
 a12:	e818                	sd	a4,16(s0)
 a14:	ec1c                	sd	a5,24(s0)
 a16:	03043023          	sd	a6,32(s0)
 a1a:	03143423          	sd	a7,40(s0)
 a1e:	87aa                	mv	a5,a0
 a20:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a24:	03040793          	addi	a5,s0,48
 a28:	fcf43423          	sd	a5,-56(s0)
 a2c:	fc843783          	ld	a5,-56(s0)
 a30:	fd078793          	addi	a5,a5,-48
 a34:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a38:	fe843703          	ld	a4,-24(s0)
 a3c:	fdc42783          	lw	a5,-36(s0)
 a40:	863a                	mv	a2,a4
 a42:	fd043583          	ld	a1,-48(s0)
 a46:	853e                	mv	a0,a5
 a48:	00000097          	auipc	ra,0x0
 a4c:	d54080e7          	jalr	-684(ra) # 79c <vprintf>
}
 a50:	0001                	nop
 a52:	70e2                	ld	ra,56(sp)
 a54:	7442                	ld	s0,48(sp)
 a56:	6165                	addi	sp,sp,112
 a58:	8082                	ret

0000000000000a5a <printf>:

void
printf(const char *fmt, ...)
{
 a5a:	7159                	addi	sp,sp,-112
 a5c:	f406                	sd	ra,40(sp)
 a5e:	f022                	sd	s0,32(sp)
 a60:	1800                	addi	s0,sp,48
 a62:	fca43c23          	sd	a0,-40(s0)
 a66:	e40c                	sd	a1,8(s0)
 a68:	e810                	sd	a2,16(s0)
 a6a:	ec14                	sd	a3,24(s0)
 a6c:	f018                	sd	a4,32(s0)
 a6e:	f41c                	sd	a5,40(s0)
 a70:	03043823          	sd	a6,48(s0)
 a74:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a78:	04040793          	addi	a5,s0,64
 a7c:	fcf43823          	sd	a5,-48(s0)
 a80:	fd043783          	ld	a5,-48(s0)
 a84:	fc878793          	addi	a5,a5,-56
 a88:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 a8c:	fe843783          	ld	a5,-24(s0)
 a90:	863e                	mv	a2,a5
 a92:	fd843583          	ld	a1,-40(s0)
 a96:	4505                	li	a0,1
 a98:	00000097          	auipc	ra,0x0
 a9c:	d04080e7          	jalr	-764(ra) # 79c <vprintf>
}
 aa0:	0001                	nop
 aa2:	70a2                	ld	ra,40(sp)
 aa4:	7402                	ld	s0,32(sp)
 aa6:	6165                	addi	sp,sp,112
 aa8:	8082                	ret

0000000000000aaa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 aaa:	7179                	addi	sp,sp,-48
 aac:	f422                	sd	s0,40(sp)
 aae:	1800                	addi	s0,sp,48
 ab0:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ab4:	fd843783          	ld	a5,-40(s0)
 ab8:	17c1                	addi	a5,a5,-16
 aba:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 abe:	00000797          	auipc	a5,0x0
 ac2:	31a78793          	addi	a5,a5,794 # dd8 <freep>
 ac6:	639c                	ld	a5,0(a5)
 ac8:	fef43423          	sd	a5,-24(s0)
 acc:	a815                	j	b00 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ace:	fe843783          	ld	a5,-24(s0)
 ad2:	639c                	ld	a5,0(a5)
 ad4:	fe843703          	ld	a4,-24(s0)
 ad8:	00f76f63          	bltu	a4,a5,af6 <free+0x4c>
 adc:	fe043703          	ld	a4,-32(s0)
 ae0:	fe843783          	ld	a5,-24(s0)
 ae4:	02e7eb63          	bltu	a5,a4,b1a <free+0x70>
 ae8:	fe843783          	ld	a5,-24(s0)
 aec:	639c                	ld	a5,0(a5)
 aee:	fe043703          	ld	a4,-32(s0)
 af2:	02f76463          	bltu	a4,a5,b1a <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af6:	fe843783          	ld	a5,-24(s0)
 afa:	639c                	ld	a5,0(a5)
 afc:	fef43423          	sd	a5,-24(s0)
 b00:	fe043703          	ld	a4,-32(s0)
 b04:	fe843783          	ld	a5,-24(s0)
 b08:	fce7f3e3          	bgeu	a5,a4,ace <free+0x24>
 b0c:	fe843783          	ld	a5,-24(s0)
 b10:	639c                	ld	a5,0(a5)
 b12:	fe043703          	ld	a4,-32(s0)
 b16:	faf77ce3          	bgeu	a4,a5,ace <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b1a:	fe043783          	ld	a5,-32(s0)
 b1e:	479c                	lw	a5,8(a5)
 b20:	1782                	slli	a5,a5,0x20
 b22:	9381                	srli	a5,a5,0x20
 b24:	0792                	slli	a5,a5,0x4
 b26:	fe043703          	ld	a4,-32(s0)
 b2a:	973e                	add	a4,a4,a5
 b2c:	fe843783          	ld	a5,-24(s0)
 b30:	639c                	ld	a5,0(a5)
 b32:	02f71763          	bne	a4,a5,b60 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b36:	fe043783          	ld	a5,-32(s0)
 b3a:	4798                	lw	a4,8(a5)
 b3c:	fe843783          	ld	a5,-24(s0)
 b40:	639c                	ld	a5,0(a5)
 b42:	479c                	lw	a5,8(a5)
 b44:	9fb9                	addw	a5,a5,a4
 b46:	0007871b          	sext.w	a4,a5
 b4a:	fe043783          	ld	a5,-32(s0)
 b4e:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b50:	fe843783          	ld	a5,-24(s0)
 b54:	639c                	ld	a5,0(a5)
 b56:	6398                	ld	a4,0(a5)
 b58:	fe043783          	ld	a5,-32(s0)
 b5c:	e398                	sd	a4,0(a5)
 b5e:	a039                	j	b6c <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b60:	fe843783          	ld	a5,-24(s0)
 b64:	6398                	ld	a4,0(a5)
 b66:	fe043783          	ld	a5,-32(s0)
 b6a:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b6c:	fe843783          	ld	a5,-24(s0)
 b70:	479c                	lw	a5,8(a5)
 b72:	1782                	slli	a5,a5,0x20
 b74:	9381                	srli	a5,a5,0x20
 b76:	0792                	slli	a5,a5,0x4
 b78:	fe843703          	ld	a4,-24(s0)
 b7c:	97ba                	add	a5,a5,a4
 b7e:	fe043703          	ld	a4,-32(s0)
 b82:	02f71563          	bne	a4,a5,bac <free+0x102>
    p->s.size += bp->s.size;
 b86:	fe843783          	ld	a5,-24(s0)
 b8a:	4798                	lw	a4,8(a5)
 b8c:	fe043783          	ld	a5,-32(s0)
 b90:	479c                	lw	a5,8(a5)
 b92:	9fb9                	addw	a5,a5,a4
 b94:	0007871b          	sext.w	a4,a5
 b98:	fe843783          	ld	a5,-24(s0)
 b9c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b9e:	fe043783          	ld	a5,-32(s0)
 ba2:	6398                	ld	a4,0(a5)
 ba4:	fe843783          	ld	a5,-24(s0)
 ba8:	e398                	sd	a4,0(a5)
 baa:	a031                	j	bb6 <free+0x10c>
  } else
    p->s.ptr = bp;
 bac:	fe843783          	ld	a5,-24(s0)
 bb0:	fe043703          	ld	a4,-32(s0)
 bb4:	e398                	sd	a4,0(a5)
  freep = p;
 bb6:	00000797          	auipc	a5,0x0
 bba:	22278793          	addi	a5,a5,546 # dd8 <freep>
 bbe:	fe843703          	ld	a4,-24(s0)
 bc2:	e398                	sd	a4,0(a5)
}
 bc4:	0001                	nop
 bc6:	7422                	ld	s0,40(sp)
 bc8:	6145                	addi	sp,sp,48
 bca:	8082                	ret

0000000000000bcc <morecore>:

static Header*
morecore(uint nu)
{
 bcc:	7179                	addi	sp,sp,-48
 bce:	f406                	sd	ra,40(sp)
 bd0:	f022                	sd	s0,32(sp)
 bd2:	1800                	addi	s0,sp,48
 bd4:	87aa                	mv	a5,a0
 bd6:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 bda:	fdc42783          	lw	a5,-36(s0)
 bde:	0007871b          	sext.w	a4,a5
 be2:	6785                	lui	a5,0x1
 be4:	00f77563          	bgeu	a4,a5,bee <morecore+0x22>
    nu = 4096;
 be8:	6785                	lui	a5,0x1
 bea:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 bee:	fdc42783          	lw	a5,-36(s0)
 bf2:	0047979b          	slliw	a5,a5,0x4
 bf6:	2781                	sext.w	a5,a5
 bf8:	2781                	sext.w	a5,a5
 bfa:	853e                	mv	a0,a5
 bfc:	00000097          	auipc	ra,0x0
 c00:	9a8080e7          	jalr	-1624(ra) # 5a4 <sbrk>
 c04:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c08:	fe843703          	ld	a4,-24(s0)
 c0c:	57fd                	li	a5,-1
 c0e:	00f71463          	bne	a4,a5,c16 <morecore+0x4a>
    return 0;
 c12:	4781                	li	a5,0
 c14:	a03d                	j	c42 <morecore+0x76>
  hp = (Header*)p;
 c16:	fe843783          	ld	a5,-24(s0)
 c1a:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c1e:	fe043783          	ld	a5,-32(s0)
 c22:	fdc42703          	lw	a4,-36(s0)
 c26:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c28:	fe043783          	ld	a5,-32(s0)
 c2c:	07c1                	addi	a5,a5,16
 c2e:	853e                	mv	a0,a5
 c30:	00000097          	auipc	ra,0x0
 c34:	e7a080e7          	jalr	-390(ra) # aaa <free>
  return freep;
 c38:	00000797          	auipc	a5,0x0
 c3c:	1a078793          	addi	a5,a5,416 # dd8 <freep>
 c40:	639c                	ld	a5,0(a5)
}
 c42:	853e                	mv	a0,a5
 c44:	70a2                	ld	ra,40(sp)
 c46:	7402                	ld	s0,32(sp)
 c48:	6145                	addi	sp,sp,48
 c4a:	8082                	ret

0000000000000c4c <malloc>:

void*
malloc(uint nbytes)
{
 c4c:	7139                	addi	sp,sp,-64
 c4e:	fc06                	sd	ra,56(sp)
 c50:	f822                	sd	s0,48(sp)
 c52:	0080                	addi	s0,sp,64
 c54:	87aa                	mv	a5,a0
 c56:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c5a:	fcc46783          	lwu	a5,-52(s0)
 c5e:	07bd                	addi	a5,a5,15
 c60:	8391                	srli	a5,a5,0x4
 c62:	2781                	sext.w	a5,a5
 c64:	2785                	addiw	a5,a5,1
 c66:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c6a:	00000797          	auipc	a5,0x0
 c6e:	16e78793          	addi	a5,a5,366 # dd8 <freep>
 c72:	639c                	ld	a5,0(a5)
 c74:	fef43023          	sd	a5,-32(s0)
 c78:	fe043783          	ld	a5,-32(s0)
 c7c:	ef95                	bnez	a5,cb8 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c7e:	00000797          	auipc	a5,0x0
 c82:	14a78793          	addi	a5,a5,330 # dc8 <base>
 c86:	fef43023          	sd	a5,-32(s0)
 c8a:	00000797          	auipc	a5,0x0
 c8e:	14e78793          	addi	a5,a5,334 # dd8 <freep>
 c92:	fe043703          	ld	a4,-32(s0)
 c96:	e398                	sd	a4,0(a5)
 c98:	00000797          	auipc	a5,0x0
 c9c:	14078793          	addi	a5,a5,320 # dd8 <freep>
 ca0:	6398                	ld	a4,0(a5)
 ca2:	00000797          	auipc	a5,0x0
 ca6:	12678793          	addi	a5,a5,294 # dc8 <base>
 caa:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 cac:	00000797          	auipc	a5,0x0
 cb0:	11c78793          	addi	a5,a5,284 # dc8 <base>
 cb4:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cb8:	fe043783          	ld	a5,-32(s0)
 cbc:	639c                	ld	a5,0(a5)
 cbe:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 cc2:	fe843783          	ld	a5,-24(s0)
 cc6:	4798                	lw	a4,8(a5)
 cc8:	fdc42783          	lw	a5,-36(s0)
 ccc:	2781                	sext.w	a5,a5
 cce:	06f76863          	bltu	a4,a5,d3e <malloc+0xf2>
      if(p->s.size == nunits)
 cd2:	fe843783          	ld	a5,-24(s0)
 cd6:	4798                	lw	a4,8(a5)
 cd8:	fdc42783          	lw	a5,-36(s0)
 cdc:	2781                	sext.w	a5,a5
 cde:	00e79963          	bne	a5,a4,cf0 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 ce2:	fe843783          	ld	a5,-24(s0)
 ce6:	6398                	ld	a4,0(a5)
 ce8:	fe043783          	ld	a5,-32(s0)
 cec:	e398                	sd	a4,0(a5)
 cee:	a82d                	j	d28 <malloc+0xdc>
      else {
        p->s.size -= nunits;
 cf0:	fe843783          	ld	a5,-24(s0)
 cf4:	4798                	lw	a4,8(a5)
 cf6:	fdc42783          	lw	a5,-36(s0)
 cfa:	40f707bb          	subw	a5,a4,a5
 cfe:	0007871b          	sext.w	a4,a5
 d02:	fe843783          	ld	a5,-24(s0)
 d06:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d08:	fe843783          	ld	a5,-24(s0)
 d0c:	479c                	lw	a5,8(a5)
 d0e:	1782                	slli	a5,a5,0x20
 d10:	9381                	srli	a5,a5,0x20
 d12:	0792                	slli	a5,a5,0x4
 d14:	fe843703          	ld	a4,-24(s0)
 d18:	97ba                	add	a5,a5,a4
 d1a:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d1e:	fe843783          	ld	a5,-24(s0)
 d22:	fdc42703          	lw	a4,-36(s0)
 d26:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d28:	00000797          	auipc	a5,0x0
 d2c:	0b078793          	addi	a5,a5,176 # dd8 <freep>
 d30:	fe043703          	ld	a4,-32(s0)
 d34:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d36:	fe843783          	ld	a5,-24(s0)
 d3a:	07c1                	addi	a5,a5,16
 d3c:	a091                	j	d80 <malloc+0x134>
    }
    if(p == freep)
 d3e:	00000797          	auipc	a5,0x0
 d42:	09a78793          	addi	a5,a5,154 # dd8 <freep>
 d46:	639c                	ld	a5,0(a5)
 d48:	fe843703          	ld	a4,-24(s0)
 d4c:	02f71063          	bne	a4,a5,d6c <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 d50:	fdc42783          	lw	a5,-36(s0)
 d54:	853e                	mv	a0,a5
 d56:	00000097          	auipc	ra,0x0
 d5a:	e76080e7          	jalr	-394(ra) # bcc <morecore>
 d5e:	fea43423          	sd	a0,-24(s0)
 d62:	fe843783          	ld	a5,-24(s0)
 d66:	e399                	bnez	a5,d6c <malloc+0x120>
        return 0;
 d68:	4781                	li	a5,0
 d6a:	a819                	j	d80 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d6c:	fe843783          	ld	a5,-24(s0)
 d70:	fef43023          	sd	a5,-32(s0)
 d74:	fe843783          	ld	a5,-24(s0)
 d78:	639c                	ld	a5,0(a5)
 d7a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d7e:	b791                	j	cc2 <malloc+0x76>
  }
}
 d80:	853e                	mv	a0,a5
 d82:	70e2                	ld	ra,56(sp)
 d84:	7442                	ld	s0,48(sp)
 d86:	6121                	addi	sp,sp,64
 d88:	8082                	ret
