
user/_prueba_args:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

void muestra_numero(int numero);

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
    printf ("Antes de llamada función.\n");
  12:	00001517          	auipc	a0,0x1
  16:	e6e50513          	addi	a0,a0,-402 # e80 <lock_init+0x18>
  1a:	00001097          	auipc	ra,0x1
  1e:	a24080e7          	jalr	-1500(ra) # a3e <printf>
    muestra_numero(5);
  22:	4515                	li	a0,5
  24:	00000097          	auipc	ra,0x0
  28:	022080e7          	jalr	34(ra) # 46 <muestra_numero>
    printf ("Después de llamada a función.\n");
  2c:	00001517          	auipc	a0,0x1
  30:	e7450513          	addi	a0,a0,-396 # ea0 <lock_init+0x38>
  34:	00001097          	auipc	ra,0x1
  38:	a0a080e7          	jalr	-1526(ra) # a3e <printf>
    exit(0);
  3c:	4501                	li	a0,0
  3e:	00000097          	auipc	ra,0x0
  42:	4c8080e7          	jalr	1224(ra) # 506 <exit>

0000000000000046 <muestra_numero>:
}

void muestra_numero (int numero){
  46:	1101                	addi	sp,sp,-32
  48:	ec06                	sd	ra,24(sp)
  4a:	e822                	sd	s0,16(sp)
  4c:	1000                	addi	s0,sp,32
  4e:	87aa                	mv	a5,a0
  50:	fef42623          	sw	a5,-20(s0)
    printf ("El numero es: %d\n", numero);
  54:	fec42783          	lw	a5,-20(s0)
  58:	85be                	mv	a1,a5
  5a:	00001517          	auipc	a0,0x1
  5e:	e6e50513          	addi	a0,a0,-402 # ec8 <lock_init+0x60>
  62:	00001097          	auipc	ra,0x1
  66:	9dc080e7          	jalr	-1572(ra) # a3e <printf>
  6a:	0001                	nop
  6c:	60e2                	ld	ra,24(sp)
  6e:	6442                	ld	s0,16(sp)
  70:	6105                	addi	sp,sp,32
  72:	8082                	ret

0000000000000074 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  74:	7179                	addi	sp,sp,-48
  76:	f422                	sd	s0,40(sp)
  78:	1800                	addi	s0,sp,48
  7a:	fca43c23          	sd	a0,-40(s0)
  7e:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  82:	fd843783          	ld	a5,-40(s0)
  86:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  8a:	0001                	nop
  8c:	fd043703          	ld	a4,-48(s0)
  90:	00170793          	addi	a5,a4,1
  94:	fcf43823          	sd	a5,-48(s0)
  98:	fd843783          	ld	a5,-40(s0)
  9c:	00178693          	addi	a3,a5,1
  a0:	fcd43c23          	sd	a3,-40(s0)
  a4:	00074703          	lbu	a4,0(a4)
  a8:	00e78023          	sb	a4,0(a5)
  ac:	0007c783          	lbu	a5,0(a5)
  b0:	fff1                	bnez	a5,8c <strcpy+0x18>
    ;
  return os;
  b2:	fe843783          	ld	a5,-24(s0)
}
  b6:	853e                	mv	a0,a5
  b8:	7422                	ld	s0,40(sp)
  ba:	6145                	addi	sp,sp,48
  bc:	8082                	ret

00000000000000be <strcmp>:

int
strcmp(const char *p, const char *q)
{
  be:	1101                	addi	sp,sp,-32
  c0:	ec22                	sd	s0,24(sp)
  c2:	1000                	addi	s0,sp,32
  c4:	fea43423          	sd	a0,-24(s0)
  c8:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
  cc:	a819                	j	e2 <strcmp+0x24>
    p++, q++;
  ce:	fe843783          	ld	a5,-24(s0)
  d2:	0785                	addi	a5,a5,1
  d4:	fef43423          	sd	a5,-24(s0)
  d8:	fe043783          	ld	a5,-32(s0)
  dc:	0785                	addi	a5,a5,1
  de:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
  e2:	fe843783          	ld	a5,-24(s0)
  e6:	0007c783          	lbu	a5,0(a5)
  ea:	cb99                	beqz	a5,100 <strcmp+0x42>
  ec:	fe843783          	ld	a5,-24(s0)
  f0:	0007c703          	lbu	a4,0(a5)
  f4:	fe043783          	ld	a5,-32(s0)
  f8:	0007c783          	lbu	a5,0(a5)
  fc:	fcf709e3          	beq	a4,a5,ce <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 100:	fe843783          	ld	a5,-24(s0)
 104:	0007c783          	lbu	a5,0(a5)
 108:	0007871b          	sext.w	a4,a5
 10c:	fe043783          	ld	a5,-32(s0)
 110:	0007c783          	lbu	a5,0(a5)
 114:	2781                	sext.w	a5,a5
 116:	40f707bb          	subw	a5,a4,a5
 11a:	2781                	sext.w	a5,a5
}
 11c:	853e                	mv	a0,a5
 11e:	6462                	ld	s0,24(sp)
 120:	6105                	addi	sp,sp,32
 122:	8082                	ret

0000000000000124 <strlen>:

uint
strlen(const char *s)
{
 124:	7179                	addi	sp,sp,-48
 126:	f422                	sd	s0,40(sp)
 128:	1800                	addi	s0,sp,48
 12a:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 12e:	fe042623          	sw	zero,-20(s0)
 132:	a031                	j	13e <strlen+0x1a>
 134:	fec42783          	lw	a5,-20(s0)
 138:	2785                	addiw	a5,a5,1
 13a:	fef42623          	sw	a5,-20(s0)
 13e:	fec42783          	lw	a5,-20(s0)
 142:	fd843703          	ld	a4,-40(s0)
 146:	97ba                	add	a5,a5,a4
 148:	0007c783          	lbu	a5,0(a5)
 14c:	f7e5                	bnez	a5,134 <strlen+0x10>
    ;
  return n;
 14e:	fec42783          	lw	a5,-20(s0)
}
 152:	853e                	mv	a0,a5
 154:	7422                	ld	s0,40(sp)
 156:	6145                	addi	sp,sp,48
 158:	8082                	ret

000000000000015a <memset>:

void*
memset(void *dst, int c, uint n)
{
 15a:	7179                	addi	sp,sp,-48
 15c:	f422                	sd	s0,40(sp)
 15e:	1800                	addi	s0,sp,48
 160:	fca43c23          	sd	a0,-40(s0)
 164:	87ae                	mv	a5,a1
 166:	8732                	mv	a4,a2
 168:	fcf42a23          	sw	a5,-44(s0)
 16c:	87ba                	mv	a5,a4
 16e:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 172:	fd843783          	ld	a5,-40(s0)
 176:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 17a:	fe042623          	sw	zero,-20(s0)
 17e:	a00d                	j	1a0 <memset+0x46>
    cdst[i] = c;
 180:	fec42783          	lw	a5,-20(s0)
 184:	fe043703          	ld	a4,-32(s0)
 188:	97ba                	add	a5,a5,a4
 18a:	fd442703          	lw	a4,-44(s0)
 18e:	0ff77713          	zext.b	a4,a4
 192:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 196:	fec42783          	lw	a5,-20(s0)
 19a:	2785                	addiw	a5,a5,1
 19c:	fef42623          	sw	a5,-20(s0)
 1a0:	fec42703          	lw	a4,-20(s0)
 1a4:	fd042783          	lw	a5,-48(s0)
 1a8:	2781                	sext.w	a5,a5
 1aa:	fcf76be3          	bltu	a4,a5,180 <memset+0x26>
  }
  return dst;
 1ae:	fd843783          	ld	a5,-40(s0)
}
 1b2:	853e                	mv	a0,a5
 1b4:	7422                	ld	s0,40(sp)
 1b6:	6145                	addi	sp,sp,48
 1b8:	8082                	ret

00000000000001ba <strchr>:

char*
strchr(const char *s, char c)
{
 1ba:	1101                	addi	sp,sp,-32
 1bc:	ec22                	sd	s0,24(sp)
 1be:	1000                	addi	s0,sp,32
 1c0:	fea43423          	sd	a0,-24(s0)
 1c4:	87ae                	mv	a5,a1
 1c6:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 1ca:	a01d                	j	1f0 <strchr+0x36>
    if(*s == c)
 1cc:	fe843783          	ld	a5,-24(s0)
 1d0:	0007c703          	lbu	a4,0(a5)
 1d4:	fe744783          	lbu	a5,-25(s0)
 1d8:	0ff7f793          	zext.b	a5,a5
 1dc:	00e79563          	bne	a5,a4,1e6 <strchr+0x2c>
      return (char*)s;
 1e0:	fe843783          	ld	a5,-24(s0)
 1e4:	a821                	j	1fc <strchr+0x42>
  for(; *s; s++)
 1e6:	fe843783          	ld	a5,-24(s0)
 1ea:	0785                	addi	a5,a5,1
 1ec:	fef43423          	sd	a5,-24(s0)
 1f0:	fe843783          	ld	a5,-24(s0)
 1f4:	0007c783          	lbu	a5,0(a5)
 1f8:	fbf1                	bnez	a5,1cc <strchr+0x12>
  return 0;
 1fa:	4781                	li	a5,0
}
 1fc:	853e                	mv	a0,a5
 1fe:	6462                	ld	s0,24(sp)
 200:	6105                	addi	sp,sp,32
 202:	8082                	ret

0000000000000204 <gets>:

char*
gets(char *buf, int max)
{
 204:	7179                	addi	sp,sp,-48
 206:	f406                	sd	ra,40(sp)
 208:	f022                	sd	s0,32(sp)
 20a:	1800                	addi	s0,sp,48
 20c:	fca43c23          	sd	a0,-40(s0)
 210:	87ae                	mv	a5,a1
 212:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 216:	fe042623          	sw	zero,-20(s0)
 21a:	a8a1                	j	272 <gets+0x6e>
    cc = read(0, &c, 1);
 21c:	fe740793          	addi	a5,s0,-25
 220:	4605                	li	a2,1
 222:	85be                	mv	a1,a5
 224:	4501                	li	a0,0
 226:	00000097          	auipc	ra,0x0
 22a:	2f8080e7          	jalr	760(ra) # 51e <read>
 22e:	87aa                	mv	a5,a0
 230:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 234:	fe842783          	lw	a5,-24(s0)
 238:	2781                	sext.w	a5,a5
 23a:	04f05763          	blez	a5,288 <gets+0x84>
      break;
    buf[i++] = c;
 23e:	fec42783          	lw	a5,-20(s0)
 242:	0017871b          	addiw	a4,a5,1
 246:	fee42623          	sw	a4,-20(s0)
 24a:	873e                	mv	a4,a5
 24c:	fd843783          	ld	a5,-40(s0)
 250:	97ba                	add	a5,a5,a4
 252:	fe744703          	lbu	a4,-25(s0)
 256:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 25a:	fe744783          	lbu	a5,-25(s0)
 25e:	873e                	mv	a4,a5
 260:	47a9                	li	a5,10
 262:	02f70463          	beq	a4,a5,28a <gets+0x86>
 266:	fe744783          	lbu	a5,-25(s0)
 26a:	873e                	mv	a4,a5
 26c:	47b5                	li	a5,13
 26e:	00f70e63          	beq	a4,a5,28a <gets+0x86>
  for(i=0; i+1 < max; ){
 272:	fec42783          	lw	a5,-20(s0)
 276:	2785                	addiw	a5,a5,1
 278:	0007871b          	sext.w	a4,a5
 27c:	fd442783          	lw	a5,-44(s0)
 280:	2781                	sext.w	a5,a5
 282:	f8f74de3          	blt	a4,a5,21c <gets+0x18>
 286:	a011                	j	28a <gets+0x86>
      break;
 288:	0001                	nop
      break;
  }
  buf[i] = '\0';
 28a:	fec42783          	lw	a5,-20(s0)
 28e:	fd843703          	ld	a4,-40(s0)
 292:	97ba                	add	a5,a5,a4
 294:	00078023          	sb	zero,0(a5)
  return buf;
 298:	fd843783          	ld	a5,-40(s0)
}
 29c:	853e                	mv	a0,a5
 29e:	70a2                	ld	ra,40(sp)
 2a0:	7402                	ld	s0,32(sp)
 2a2:	6145                	addi	sp,sp,48
 2a4:	8082                	ret

00000000000002a6 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a6:	7179                	addi	sp,sp,-48
 2a8:	f406                	sd	ra,40(sp)
 2aa:	f022                	sd	s0,32(sp)
 2ac:	1800                	addi	s0,sp,48
 2ae:	fca43c23          	sd	a0,-40(s0)
 2b2:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b6:	4581                	li	a1,0
 2b8:	fd843503          	ld	a0,-40(s0)
 2bc:	00000097          	auipc	ra,0x0
 2c0:	28a080e7          	jalr	650(ra) # 546 <open>
 2c4:	87aa                	mv	a5,a0
 2c6:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 2ca:	fec42783          	lw	a5,-20(s0)
 2ce:	2781                	sext.w	a5,a5
 2d0:	0007d463          	bgez	a5,2d8 <stat+0x32>
    return -1;
 2d4:	57fd                	li	a5,-1
 2d6:	a035                	j	302 <stat+0x5c>
  r = fstat(fd, st);
 2d8:	fec42783          	lw	a5,-20(s0)
 2dc:	fd043583          	ld	a1,-48(s0)
 2e0:	853e                	mv	a0,a5
 2e2:	00000097          	auipc	ra,0x0
 2e6:	27c080e7          	jalr	636(ra) # 55e <fstat>
 2ea:	87aa                	mv	a5,a0
 2ec:	fef42423          	sw	a5,-24(s0)
  close(fd);
 2f0:	fec42783          	lw	a5,-20(s0)
 2f4:	853e                	mv	a0,a5
 2f6:	00000097          	auipc	ra,0x0
 2fa:	238080e7          	jalr	568(ra) # 52e <close>
  return r;
 2fe:	fe842783          	lw	a5,-24(s0)
}
 302:	853e                	mv	a0,a5
 304:	70a2                	ld	ra,40(sp)
 306:	7402                	ld	s0,32(sp)
 308:	6145                	addi	sp,sp,48
 30a:	8082                	ret

000000000000030c <atoi>:

int
atoi(const char *s)
{
 30c:	7179                	addi	sp,sp,-48
 30e:	f422                	sd	s0,40(sp)
 310:	1800                	addi	s0,sp,48
 312:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 316:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 31a:	a81d                	j	350 <atoi+0x44>
    n = n*10 + *s++ - '0';
 31c:	fec42783          	lw	a5,-20(s0)
 320:	873e                	mv	a4,a5
 322:	87ba                	mv	a5,a4
 324:	0027979b          	slliw	a5,a5,0x2
 328:	9fb9                	addw	a5,a5,a4
 32a:	0017979b          	slliw	a5,a5,0x1
 32e:	0007871b          	sext.w	a4,a5
 332:	fd843783          	ld	a5,-40(s0)
 336:	00178693          	addi	a3,a5,1
 33a:	fcd43c23          	sd	a3,-40(s0)
 33e:	0007c783          	lbu	a5,0(a5)
 342:	2781                	sext.w	a5,a5
 344:	9fb9                	addw	a5,a5,a4
 346:	2781                	sext.w	a5,a5
 348:	fd07879b          	addiw	a5,a5,-48
 34c:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 350:	fd843783          	ld	a5,-40(s0)
 354:	0007c783          	lbu	a5,0(a5)
 358:	873e                	mv	a4,a5
 35a:	02f00793          	li	a5,47
 35e:	00e7fb63          	bgeu	a5,a4,374 <atoi+0x68>
 362:	fd843783          	ld	a5,-40(s0)
 366:	0007c783          	lbu	a5,0(a5)
 36a:	873e                	mv	a4,a5
 36c:	03900793          	li	a5,57
 370:	fae7f6e3          	bgeu	a5,a4,31c <atoi+0x10>
  return n;
 374:	fec42783          	lw	a5,-20(s0)
}
 378:	853e                	mv	a0,a5
 37a:	7422                	ld	s0,40(sp)
 37c:	6145                	addi	sp,sp,48
 37e:	8082                	ret

0000000000000380 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 380:	7139                	addi	sp,sp,-64
 382:	fc22                	sd	s0,56(sp)
 384:	0080                	addi	s0,sp,64
 386:	fca43c23          	sd	a0,-40(s0)
 38a:	fcb43823          	sd	a1,-48(s0)
 38e:	87b2                	mv	a5,a2
 390:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 394:	fd843783          	ld	a5,-40(s0)
 398:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 39c:	fd043783          	ld	a5,-48(s0)
 3a0:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3a4:	fe043703          	ld	a4,-32(s0)
 3a8:	fe843783          	ld	a5,-24(s0)
 3ac:	02e7fc63          	bgeu	a5,a4,3e4 <memmove+0x64>
    while(n-- > 0)
 3b0:	a00d                	j	3d2 <memmove+0x52>
      *dst++ = *src++;
 3b2:	fe043703          	ld	a4,-32(s0)
 3b6:	00170793          	addi	a5,a4,1
 3ba:	fef43023          	sd	a5,-32(s0)
 3be:	fe843783          	ld	a5,-24(s0)
 3c2:	00178693          	addi	a3,a5,1
 3c6:	fed43423          	sd	a3,-24(s0)
 3ca:	00074703          	lbu	a4,0(a4)
 3ce:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3d2:	fcc42783          	lw	a5,-52(s0)
 3d6:	fff7871b          	addiw	a4,a5,-1
 3da:	fce42623          	sw	a4,-52(s0)
 3de:	fcf04ae3          	bgtz	a5,3b2 <memmove+0x32>
 3e2:	a891                	j	436 <memmove+0xb6>
  } else {
    dst += n;
 3e4:	fcc42783          	lw	a5,-52(s0)
 3e8:	fe843703          	ld	a4,-24(s0)
 3ec:	97ba                	add	a5,a5,a4
 3ee:	fef43423          	sd	a5,-24(s0)
    src += n;
 3f2:	fcc42783          	lw	a5,-52(s0)
 3f6:	fe043703          	ld	a4,-32(s0)
 3fa:	97ba                	add	a5,a5,a4
 3fc:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 400:	a01d                	j	426 <memmove+0xa6>
      *--dst = *--src;
 402:	fe043783          	ld	a5,-32(s0)
 406:	17fd                	addi	a5,a5,-1
 408:	fef43023          	sd	a5,-32(s0)
 40c:	fe843783          	ld	a5,-24(s0)
 410:	17fd                	addi	a5,a5,-1
 412:	fef43423          	sd	a5,-24(s0)
 416:	fe043783          	ld	a5,-32(s0)
 41a:	0007c703          	lbu	a4,0(a5)
 41e:	fe843783          	ld	a5,-24(s0)
 422:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 426:	fcc42783          	lw	a5,-52(s0)
 42a:	fff7871b          	addiw	a4,a5,-1
 42e:	fce42623          	sw	a4,-52(s0)
 432:	fcf048e3          	bgtz	a5,402 <memmove+0x82>
  }
  return vdst;
 436:	fd843783          	ld	a5,-40(s0)
}
 43a:	853e                	mv	a0,a5
 43c:	7462                	ld	s0,56(sp)
 43e:	6121                	addi	sp,sp,64
 440:	8082                	ret

0000000000000442 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 442:	7139                	addi	sp,sp,-64
 444:	fc22                	sd	s0,56(sp)
 446:	0080                	addi	s0,sp,64
 448:	fca43c23          	sd	a0,-40(s0)
 44c:	fcb43823          	sd	a1,-48(s0)
 450:	87b2                	mv	a5,a2
 452:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 456:	fd843783          	ld	a5,-40(s0)
 45a:	fef43423          	sd	a5,-24(s0)
 45e:	fd043783          	ld	a5,-48(s0)
 462:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 466:	a0a1                	j	4ae <memcmp+0x6c>
    if (*p1 != *p2) {
 468:	fe843783          	ld	a5,-24(s0)
 46c:	0007c703          	lbu	a4,0(a5)
 470:	fe043783          	ld	a5,-32(s0)
 474:	0007c783          	lbu	a5,0(a5)
 478:	02f70163          	beq	a4,a5,49a <memcmp+0x58>
      return *p1 - *p2;
 47c:	fe843783          	ld	a5,-24(s0)
 480:	0007c783          	lbu	a5,0(a5)
 484:	0007871b          	sext.w	a4,a5
 488:	fe043783          	ld	a5,-32(s0)
 48c:	0007c783          	lbu	a5,0(a5)
 490:	2781                	sext.w	a5,a5
 492:	40f707bb          	subw	a5,a4,a5
 496:	2781                	sext.w	a5,a5
 498:	a01d                	j	4be <memcmp+0x7c>
    }
    p1++;
 49a:	fe843783          	ld	a5,-24(s0)
 49e:	0785                	addi	a5,a5,1
 4a0:	fef43423          	sd	a5,-24(s0)
    p2++;
 4a4:	fe043783          	ld	a5,-32(s0)
 4a8:	0785                	addi	a5,a5,1
 4aa:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4ae:	fcc42783          	lw	a5,-52(s0)
 4b2:	fff7871b          	addiw	a4,a5,-1
 4b6:	fce42623          	sw	a4,-52(s0)
 4ba:	f7dd                	bnez	a5,468 <memcmp+0x26>
  }
  return 0;
 4bc:	4781                	li	a5,0
}
 4be:	853e                	mv	a0,a5
 4c0:	7462                	ld	s0,56(sp)
 4c2:	6121                	addi	sp,sp,64
 4c4:	8082                	ret

00000000000004c6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4c6:	7179                	addi	sp,sp,-48
 4c8:	f406                	sd	ra,40(sp)
 4ca:	f022                	sd	s0,32(sp)
 4cc:	1800                	addi	s0,sp,48
 4ce:	fea43423          	sd	a0,-24(s0)
 4d2:	feb43023          	sd	a1,-32(s0)
 4d6:	87b2                	mv	a5,a2
 4d8:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 4dc:	fdc42783          	lw	a5,-36(s0)
 4e0:	863e                	mv	a2,a5
 4e2:	fe043583          	ld	a1,-32(s0)
 4e6:	fe843503          	ld	a0,-24(s0)
 4ea:	00000097          	auipc	ra,0x0
 4ee:	e96080e7          	jalr	-362(ra) # 380 <memmove>
 4f2:	87aa                	mv	a5,a0
}
 4f4:	853e                	mv	a0,a5
 4f6:	70a2                	ld	ra,40(sp)
 4f8:	7402                	ld	s0,32(sp)
 4fa:	6145                	addi	sp,sp,48
 4fc:	8082                	ret

00000000000004fe <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4fe:	4885                	li	a7,1
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <exit>:
.global exit
exit:
 li a7, SYS_exit
 506:	4889                	li	a7,2
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <wait>:
.global wait
wait:
 li a7, SYS_wait
 50e:	488d                	li	a7,3
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 516:	4891                	li	a7,4
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <read>:
.global read
read:
 li a7, SYS_read
 51e:	4895                	li	a7,5
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <write>:
.global write
write:
 li a7, SYS_write
 526:	48c1                	li	a7,16
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <close>:
.global close
close:
 li a7, SYS_close
 52e:	48d5                	li	a7,21
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <kill>:
.global kill
kill:
 li a7, SYS_kill
 536:	4899                	li	a7,6
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <exec>:
.global exec
exec:
 li a7, SYS_exec
 53e:	489d                	li	a7,7
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <open>:
.global open
open:
 li a7, SYS_open
 546:	48bd                	li	a7,15
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 54e:	48c5                	li	a7,17
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 556:	48c9                	li	a7,18
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 55e:	48a1                	li	a7,8
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <link>:
.global link
link:
 li a7, SYS_link
 566:	48cd                	li	a7,19
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 56e:	48d1                	li	a7,20
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 576:	48a5                	li	a7,9
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <dup>:
.global dup
dup:
 li a7, SYS_dup
 57e:	48a9                	li	a7,10
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 586:	48ad                	li	a7,11
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 58e:	48b1                	li	a7,12
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 596:	48b5                	li	a7,13
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 59e:	48b9                	li	a7,14
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <clone>:
.global clone
clone:
 li a7, SYS_clone
 5a6:	48d9                	li	a7,22
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <join>:
.global join
join:
 li a7, SYS_join
 5ae:	48dd                	li	a7,23
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5b6:	1101                	addi	sp,sp,-32
 5b8:	ec06                	sd	ra,24(sp)
 5ba:	e822                	sd	s0,16(sp)
 5bc:	1000                	addi	s0,sp,32
 5be:	87aa                	mv	a5,a0
 5c0:	872e                	mv	a4,a1
 5c2:	fef42623          	sw	a5,-20(s0)
 5c6:	87ba                	mv	a5,a4
 5c8:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 5cc:	feb40713          	addi	a4,s0,-21
 5d0:	fec42783          	lw	a5,-20(s0)
 5d4:	4605                	li	a2,1
 5d6:	85ba                	mv	a1,a4
 5d8:	853e                	mv	a0,a5
 5da:	00000097          	auipc	ra,0x0
 5de:	f4c080e7          	jalr	-180(ra) # 526 <write>
}
 5e2:	0001                	nop
 5e4:	60e2                	ld	ra,24(sp)
 5e6:	6442                	ld	s0,16(sp)
 5e8:	6105                	addi	sp,sp,32
 5ea:	8082                	ret

00000000000005ec <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5ec:	7139                	addi	sp,sp,-64
 5ee:	fc06                	sd	ra,56(sp)
 5f0:	f822                	sd	s0,48(sp)
 5f2:	0080                	addi	s0,sp,64
 5f4:	87aa                	mv	a5,a0
 5f6:	8736                	mv	a4,a3
 5f8:	fcf42623          	sw	a5,-52(s0)
 5fc:	87ae                	mv	a5,a1
 5fe:	fcf42423          	sw	a5,-56(s0)
 602:	87b2                	mv	a5,a2
 604:	fcf42223          	sw	a5,-60(s0)
 608:	87ba                	mv	a5,a4
 60a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 60e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 612:	fc042783          	lw	a5,-64(s0)
 616:	2781                	sext.w	a5,a5
 618:	c38d                	beqz	a5,63a <printint+0x4e>
 61a:	fc842783          	lw	a5,-56(s0)
 61e:	2781                	sext.w	a5,a5
 620:	0007dd63          	bgez	a5,63a <printint+0x4e>
    neg = 1;
 624:	4785                	li	a5,1
 626:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 62a:	fc842783          	lw	a5,-56(s0)
 62e:	40f007bb          	negw	a5,a5
 632:	2781                	sext.w	a5,a5
 634:	fef42223          	sw	a5,-28(s0)
 638:	a029                	j	642 <printint+0x56>
  } else {
    x = xx;
 63a:	fc842783          	lw	a5,-56(s0)
 63e:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 642:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 646:	fc442783          	lw	a5,-60(s0)
 64a:	fe442703          	lw	a4,-28(s0)
 64e:	02f777bb          	remuw	a5,a4,a5
 652:	0007861b          	sext.w	a2,a5
 656:	fec42783          	lw	a5,-20(s0)
 65a:	0017871b          	addiw	a4,a5,1
 65e:	fee42623          	sw	a4,-20(s0)
 662:	00001697          	auipc	a3,0x1
 666:	8d668693          	addi	a3,a3,-1834 # f38 <digits>
 66a:	02061713          	slli	a4,a2,0x20
 66e:	9301                	srli	a4,a4,0x20
 670:	9736                	add	a4,a4,a3
 672:	00074703          	lbu	a4,0(a4)
 676:	17c1                	addi	a5,a5,-16
 678:	97a2                	add	a5,a5,s0
 67a:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 67e:	fc442783          	lw	a5,-60(s0)
 682:	fe442703          	lw	a4,-28(s0)
 686:	02f757bb          	divuw	a5,a4,a5
 68a:	fef42223          	sw	a5,-28(s0)
 68e:	fe442783          	lw	a5,-28(s0)
 692:	2781                	sext.w	a5,a5
 694:	fbcd                	bnez	a5,646 <printint+0x5a>
  if(neg)
 696:	fe842783          	lw	a5,-24(s0)
 69a:	2781                	sext.w	a5,a5
 69c:	cf85                	beqz	a5,6d4 <printint+0xe8>
    buf[i++] = '-';
 69e:	fec42783          	lw	a5,-20(s0)
 6a2:	0017871b          	addiw	a4,a5,1
 6a6:	fee42623          	sw	a4,-20(s0)
 6aa:	17c1                	addi	a5,a5,-16
 6ac:	97a2                	add	a5,a5,s0
 6ae:	02d00713          	li	a4,45
 6b2:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6b6:	a839                	j	6d4 <printint+0xe8>
    putc(fd, buf[i]);
 6b8:	fec42783          	lw	a5,-20(s0)
 6bc:	17c1                	addi	a5,a5,-16
 6be:	97a2                	add	a5,a5,s0
 6c0:	fe07c703          	lbu	a4,-32(a5)
 6c4:	fcc42783          	lw	a5,-52(s0)
 6c8:	85ba                	mv	a1,a4
 6ca:	853e                	mv	a0,a5
 6cc:	00000097          	auipc	ra,0x0
 6d0:	eea080e7          	jalr	-278(ra) # 5b6 <putc>
  while(--i >= 0)
 6d4:	fec42783          	lw	a5,-20(s0)
 6d8:	37fd                	addiw	a5,a5,-1
 6da:	fef42623          	sw	a5,-20(s0)
 6de:	fec42783          	lw	a5,-20(s0)
 6e2:	2781                	sext.w	a5,a5
 6e4:	fc07dae3          	bgez	a5,6b8 <printint+0xcc>
}
 6e8:	0001                	nop
 6ea:	0001                	nop
 6ec:	70e2                	ld	ra,56(sp)
 6ee:	7442                	ld	s0,48(sp)
 6f0:	6121                	addi	sp,sp,64
 6f2:	8082                	ret

00000000000006f4 <printptr>:

static void
printptr(int fd, uint64 x) {
 6f4:	7179                	addi	sp,sp,-48
 6f6:	f406                	sd	ra,40(sp)
 6f8:	f022                	sd	s0,32(sp)
 6fa:	1800                	addi	s0,sp,48
 6fc:	87aa                	mv	a5,a0
 6fe:	fcb43823          	sd	a1,-48(s0)
 702:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 706:	fdc42783          	lw	a5,-36(s0)
 70a:	03000593          	li	a1,48
 70e:	853e                	mv	a0,a5
 710:	00000097          	auipc	ra,0x0
 714:	ea6080e7          	jalr	-346(ra) # 5b6 <putc>
  putc(fd, 'x');
 718:	fdc42783          	lw	a5,-36(s0)
 71c:	07800593          	li	a1,120
 720:	853e                	mv	a0,a5
 722:	00000097          	auipc	ra,0x0
 726:	e94080e7          	jalr	-364(ra) # 5b6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 72a:	fe042623          	sw	zero,-20(s0)
 72e:	a82d                	j	768 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 730:	fd043783          	ld	a5,-48(s0)
 734:	93f1                	srli	a5,a5,0x3c
 736:	00001717          	auipc	a4,0x1
 73a:	80270713          	addi	a4,a4,-2046 # f38 <digits>
 73e:	97ba                	add	a5,a5,a4
 740:	0007c703          	lbu	a4,0(a5)
 744:	fdc42783          	lw	a5,-36(s0)
 748:	85ba                	mv	a1,a4
 74a:	853e                	mv	a0,a5
 74c:	00000097          	auipc	ra,0x0
 750:	e6a080e7          	jalr	-406(ra) # 5b6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 754:	fec42783          	lw	a5,-20(s0)
 758:	2785                	addiw	a5,a5,1
 75a:	fef42623          	sw	a5,-20(s0)
 75e:	fd043783          	ld	a5,-48(s0)
 762:	0792                	slli	a5,a5,0x4
 764:	fcf43823          	sd	a5,-48(s0)
 768:	fec42783          	lw	a5,-20(s0)
 76c:	873e                	mv	a4,a5
 76e:	47bd                	li	a5,15
 770:	fce7f0e3          	bgeu	a5,a4,730 <printptr+0x3c>
}
 774:	0001                	nop
 776:	0001                	nop
 778:	70a2                	ld	ra,40(sp)
 77a:	7402                	ld	s0,32(sp)
 77c:	6145                	addi	sp,sp,48
 77e:	8082                	ret

0000000000000780 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 780:	715d                	addi	sp,sp,-80
 782:	e486                	sd	ra,72(sp)
 784:	e0a2                	sd	s0,64(sp)
 786:	0880                	addi	s0,sp,80
 788:	87aa                	mv	a5,a0
 78a:	fcb43023          	sd	a1,-64(s0)
 78e:	fac43c23          	sd	a2,-72(s0)
 792:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 796:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 79a:	fe042223          	sw	zero,-28(s0)
 79e:	a42d                	j	9c8 <vprintf+0x248>
    c = fmt[i] & 0xff;
 7a0:	fe442783          	lw	a5,-28(s0)
 7a4:	fc043703          	ld	a4,-64(s0)
 7a8:	97ba                	add	a5,a5,a4
 7aa:	0007c783          	lbu	a5,0(a5)
 7ae:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7b2:	fe042783          	lw	a5,-32(s0)
 7b6:	2781                	sext.w	a5,a5
 7b8:	eb9d                	bnez	a5,7ee <vprintf+0x6e>
      if(c == '%'){
 7ba:	fdc42783          	lw	a5,-36(s0)
 7be:	0007871b          	sext.w	a4,a5
 7c2:	02500793          	li	a5,37
 7c6:	00f71763          	bne	a4,a5,7d4 <vprintf+0x54>
        state = '%';
 7ca:	02500793          	li	a5,37
 7ce:	fef42023          	sw	a5,-32(s0)
 7d2:	a2f5                	j	9be <vprintf+0x23e>
      } else {
        putc(fd, c);
 7d4:	fdc42783          	lw	a5,-36(s0)
 7d8:	0ff7f713          	zext.b	a4,a5
 7dc:	fcc42783          	lw	a5,-52(s0)
 7e0:	85ba                	mv	a1,a4
 7e2:	853e                	mv	a0,a5
 7e4:	00000097          	auipc	ra,0x0
 7e8:	dd2080e7          	jalr	-558(ra) # 5b6 <putc>
 7ec:	aac9                	j	9be <vprintf+0x23e>
      }
    } else if(state == '%'){
 7ee:	fe042783          	lw	a5,-32(s0)
 7f2:	0007871b          	sext.w	a4,a5
 7f6:	02500793          	li	a5,37
 7fa:	1cf71263          	bne	a4,a5,9be <vprintf+0x23e>
      if(c == 'd'){
 7fe:	fdc42783          	lw	a5,-36(s0)
 802:	0007871b          	sext.w	a4,a5
 806:	06400793          	li	a5,100
 80a:	02f71463          	bne	a4,a5,832 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 80e:	fb843783          	ld	a5,-72(s0)
 812:	00878713          	addi	a4,a5,8
 816:	fae43c23          	sd	a4,-72(s0)
 81a:	4398                	lw	a4,0(a5)
 81c:	fcc42783          	lw	a5,-52(s0)
 820:	4685                	li	a3,1
 822:	4629                	li	a2,10
 824:	85ba                	mv	a1,a4
 826:	853e                	mv	a0,a5
 828:	00000097          	auipc	ra,0x0
 82c:	dc4080e7          	jalr	-572(ra) # 5ec <printint>
 830:	a269                	j	9ba <vprintf+0x23a>
      } else if(c == 'l') {
 832:	fdc42783          	lw	a5,-36(s0)
 836:	0007871b          	sext.w	a4,a5
 83a:	06c00793          	li	a5,108
 83e:	02f71663          	bne	a4,a5,86a <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 842:	fb843783          	ld	a5,-72(s0)
 846:	00878713          	addi	a4,a5,8
 84a:	fae43c23          	sd	a4,-72(s0)
 84e:	639c                	ld	a5,0(a5)
 850:	0007871b          	sext.w	a4,a5
 854:	fcc42783          	lw	a5,-52(s0)
 858:	4681                	li	a3,0
 85a:	4629                	li	a2,10
 85c:	85ba                	mv	a1,a4
 85e:	853e                	mv	a0,a5
 860:	00000097          	auipc	ra,0x0
 864:	d8c080e7          	jalr	-628(ra) # 5ec <printint>
 868:	aa89                	j	9ba <vprintf+0x23a>
      } else if(c == 'x') {
 86a:	fdc42783          	lw	a5,-36(s0)
 86e:	0007871b          	sext.w	a4,a5
 872:	07800793          	li	a5,120
 876:	02f71463          	bne	a4,a5,89e <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 87a:	fb843783          	ld	a5,-72(s0)
 87e:	00878713          	addi	a4,a5,8
 882:	fae43c23          	sd	a4,-72(s0)
 886:	4398                	lw	a4,0(a5)
 888:	fcc42783          	lw	a5,-52(s0)
 88c:	4681                	li	a3,0
 88e:	4641                	li	a2,16
 890:	85ba                	mv	a1,a4
 892:	853e                	mv	a0,a5
 894:	00000097          	auipc	ra,0x0
 898:	d58080e7          	jalr	-680(ra) # 5ec <printint>
 89c:	aa39                	j	9ba <vprintf+0x23a>
      } else if(c == 'p') {
 89e:	fdc42783          	lw	a5,-36(s0)
 8a2:	0007871b          	sext.w	a4,a5
 8a6:	07000793          	li	a5,112
 8aa:	02f71263          	bne	a4,a5,8ce <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8ae:	fb843783          	ld	a5,-72(s0)
 8b2:	00878713          	addi	a4,a5,8
 8b6:	fae43c23          	sd	a4,-72(s0)
 8ba:	6398                	ld	a4,0(a5)
 8bc:	fcc42783          	lw	a5,-52(s0)
 8c0:	85ba                	mv	a1,a4
 8c2:	853e                	mv	a0,a5
 8c4:	00000097          	auipc	ra,0x0
 8c8:	e30080e7          	jalr	-464(ra) # 6f4 <printptr>
 8cc:	a0fd                	j	9ba <vprintf+0x23a>
      } else if(c == 's'){
 8ce:	fdc42783          	lw	a5,-36(s0)
 8d2:	0007871b          	sext.w	a4,a5
 8d6:	07300793          	li	a5,115
 8da:	04f71c63          	bne	a4,a5,932 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 8de:	fb843783          	ld	a5,-72(s0)
 8e2:	00878713          	addi	a4,a5,8
 8e6:	fae43c23          	sd	a4,-72(s0)
 8ea:	639c                	ld	a5,0(a5)
 8ec:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 8f0:	fe843783          	ld	a5,-24(s0)
 8f4:	eb8d                	bnez	a5,926 <vprintf+0x1a6>
          s = "(null)";
 8f6:	00000797          	auipc	a5,0x0
 8fa:	5ea78793          	addi	a5,a5,1514 # ee0 <lock_init+0x78>
 8fe:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 902:	a015                	j	926 <vprintf+0x1a6>
          putc(fd, *s);
 904:	fe843783          	ld	a5,-24(s0)
 908:	0007c703          	lbu	a4,0(a5)
 90c:	fcc42783          	lw	a5,-52(s0)
 910:	85ba                	mv	a1,a4
 912:	853e                	mv	a0,a5
 914:	00000097          	auipc	ra,0x0
 918:	ca2080e7          	jalr	-862(ra) # 5b6 <putc>
          s++;
 91c:	fe843783          	ld	a5,-24(s0)
 920:	0785                	addi	a5,a5,1
 922:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 926:	fe843783          	ld	a5,-24(s0)
 92a:	0007c783          	lbu	a5,0(a5)
 92e:	fbf9                	bnez	a5,904 <vprintf+0x184>
 930:	a069                	j	9ba <vprintf+0x23a>
        }
      } else if(c == 'c'){
 932:	fdc42783          	lw	a5,-36(s0)
 936:	0007871b          	sext.w	a4,a5
 93a:	06300793          	li	a5,99
 93e:	02f71463          	bne	a4,a5,966 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 942:	fb843783          	ld	a5,-72(s0)
 946:	00878713          	addi	a4,a5,8
 94a:	fae43c23          	sd	a4,-72(s0)
 94e:	439c                	lw	a5,0(a5)
 950:	0ff7f713          	zext.b	a4,a5
 954:	fcc42783          	lw	a5,-52(s0)
 958:	85ba                	mv	a1,a4
 95a:	853e                	mv	a0,a5
 95c:	00000097          	auipc	ra,0x0
 960:	c5a080e7          	jalr	-934(ra) # 5b6 <putc>
 964:	a899                	j	9ba <vprintf+0x23a>
      } else if(c == '%'){
 966:	fdc42783          	lw	a5,-36(s0)
 96a:	0007871b          	sext.w	a4,a5
 96e:	02500793          	li	a5,37
 972:	00f71f63          	bne	a4,a5,990 <vprintf+0x210>
        putc(fd, c);
 976:	fdc42783          	lw	a5,-36(s0)
 97a:	0ff7f713          	zext.b	a4,a5
 97e:	fcc42783          	lw	a5,-52(s0)
 982:	85ba                	mv	a1,a4
 984:	853e                	mv	a0,a5
 986:	00000097          	auipc	ra,0x0
 98a:	c30080e7          	jalr	-976(ra) # 5b6 <putc>
 98e:	a035                	j	9ba <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 990:	fcc42783          	lw	a5,-52(s0)
 994:	02500593          	li	a1,37
 998:	853e                	mv	a0,a5
 99a:	00000097          	auipc	ra,0x0
 99e:	c1c080e7          	jalr	-996(ra) # 5b6 <putc>
        putc(fd, c);
 9a2:	fdc42783          	lw	a5,-36(s0)
 9a6:	0ff7f713          	zext.b	a4,a5
 9aa:	fcc42783          	lw	a5,-52(s0)
 9ae:	85ba                	mv	a1,a4
 9b0:	853e                	mv	a0,a5
 9b2:	00000097          	auipc	ra,0x0
 9b6:	c04080e7          	jalr	-1020(ra) # 5b6 <putc>
      }
      state = 0;
 9ba:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 9be:	fe442783          	lw	a5,-28(s0)
 9c2:	2785                	addiw	a5,a5,1
 9c4:	fef42223          	sw	a5,-28(s0)
 9c8:	fe442783          	lw	a5,-28(s0)
 9cc:	fc043703          	ld	a4,-64(s0)
 9d0:	97ba                	add	a5,a5,a4
 9d2:	0007c783          	lbu	a5,0(a5)
 9d6:	dc0795e3          	bnez	a5,7a0 <vprintf+0x20>
    }
  }
}
 9da:	0001                	nop
 9dc:	0001                	nop
 9de:	60a6                	ld	ra,72(sp)
 9e0:	6406                	ld	s0,64(sp)
 9e2:	6161                	addi	sp,sp,80
 9e4:	8082                	ret

00000000000009e6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9e6:	7159                	addi	sp,sp,-112
 9e8:	fc06                	sd	ra,56(sp)
 9ea:	f822                	sd	s0,48(sp)
 9ec:	0080                	addi	s0,sp,64
 9ee:	fcb43823          	sd	a1,-48(s0)
 9f2:	e010                	sd	a2,0(s0)
 9f4:	e414                	sd	a3,8(s0)
 9f6:	e818                	sd	a4,16(s0)
 9f8:	ec1c                	sd	a5,24(s0)
 9fa:	03043023          	sd	a6,32(s0)
 9fe:	03143423          	sd	a7,40(s0)
 a02:	87aa                	mv	a5,a0
 a04:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a08:	03040793          	addi	a5,s0,48
 a0c:	fcf43423          	sd	a5,-56(s0)
 a10:	fc843783          	ld	a5,-56(s0)
 a14:	fd078793          	addi	a5,a5,-48
 a18:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a1c:	fe843703          	ld	a4,-24(s0)
 a20:	fdc42783          	lw	a5,-36(s0)
 a24:	863a                	mv	a2,a4
 a26:	fd043583          	ld	a1,-48(s0)
 a2a:	853e                	mv	a0,a5
 a2c:	00000097          	auipc	ra,0x0
 a30:	d54080e7          	jalr	-684(ra) # 780 <vprintf>
}
 a34:	0001                	nop
 a36:	70e2                	ld	ra,56(sp)
 a38:	7442                	ld	s0,48(sp)
 a3a:	6165                	addi	sp,sp,112
 a3c:	8082                	ret

0000000000000a3e <printf>:

void
printf(const char *fmt, ...)
{
 a3e:	7159                	addi	sp,sp,-112
 a40:	f406                	sd	ra,40(sp)
 a42:	f022                	sd	s0,32(sp)
 a44:	1800                	addi	s0,sp,48
 a46:	fca43c23          	sd	a0,-40(s0)
 a4a:	e40c                	sd	a1,8(s0)
 a4c:	e810                	sd	a2,16(s0)
 a4e:	ec14                	sd	a3,24(s0)
 a50:	f018                	sd	a4,32(s0)
 a52:	f41c                	sd	a5,40(s0)
 a54:	03043823          	sd	a6,48(s0)
 a58:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a5c:	04040793          	addi	a5,s0,64
 a60:	fcf43823          	sd	a5,-48(s0)
 a64:	fd043783          	ld	a5,-48(s0)
 a68:	fc878793          	addi	a5,a5,-56
 a6c:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 a70:	fe843783          	ld	a5,-24(s0)
 a74:	863e                	mv	a2,a5
 a76:	fd843583          	ld	a1,-40(s0)
 a7a:	4505                	li	a0,1
 a7c:	00000097          	auipc	ra,0x0
 a80:	d04080e7          	jalr	-764(ra) # 780 <vprintf>
}
 a84:	0001                	nop
 a86:	70a2                	ld	ra,40(sp)
 a88:	7402                	ld	s0,32(sp)
 a8a:	6165                	addi	sp,sp,112
 a8c:	8082                	ret

0000000000000a8e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a8e:	7179                	addi	sp,sp,-48
 a90:	f422                	sd	s0,40(sp)
 a92:	1800                	addi	s0,sp,48
 a94:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a98:	fd843783          	ld	a5,-40(s0)
 a9c:	17c1                	addi	a5,a5,-16
 a9e:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aa2:	00000797          	auipc	a5,0x0
 aa6:	4be78793          	addi	a5,a5,1214 # f60 <freep>
 aaa:	639c                	ld	a5,0(a5)
 aac:	fef43423          	sd	a5,-24(s0)
 ab0:	a815                	j	ae4 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ab2:	fe843783          	ld	a5,-24(s0)
 ab6:	639c                	ld	a5,0(a5)
 ab8:	fe843703          	ld	a4,-24(s0)
 abc:	00f76f63          	bltu	a4,a5,ada <free+0x4c>
 ac0:	fe043703          	ld	a4,-32(s0)
 ac4:	fe843783          	ld	a5,-24(s0)
 ac8:	02e7eb63          	bltu	a5,a4,afe <free+0x70>
 acc:	fe843783          	ld	a5,-24(s0)
 ad0:	639c                	ld	a5,0(a5)
 ad2:	fe043703          	ld	a4,-32(s0)
 ad6:	02f76463          	bltu	a4,a5,afe <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ada:	fe843783          	ld	a5,-24(s0)
 ade:	639c                	ld	a5,0(a5)
 ae0:	fef43423          	sd	a5,-24(s0)
 ae4:	fe043703          	ld	a4,-32(s0)
 ae8:	fe843783          	ld	a5,-24(s0)
 aec:	fce7f3e3          	bgeu	a5,a4,ab2 <free+0x24>
 af0:	fe843783          	ld	a5,-24(s0)
 af4:	639c                	ld	a5,0(a5)
 af6:	fe043703          	ld	a4,-32(s0)
 afa:	faf77ce3          	bgeu	a4,a5,ab2 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 afe:	fe043783          	ld	a5,-32(s0)
 b02:	479c                	lw	a5,8(a5)
 b04:	1782                	slli	a5,a5,0x20
 b06:	9381                	srli	a5,a5,0x20
 b08:	0792                	slli	a5,a5,0x4
 b0a:	fe043703          	ld	a4,-32(s0)
 b0e:	973e                	add	a4,a4,a5
 b10:	fe843783          	ld	a5,-24(s0)
 b14:	639c                	ld	a5,0(a5)
 b16:	02f71763          	bne	a4,a5,b44 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b1a:	fe043783          	ld	a5,-32(s0)
 b1e:	4798                	lw	a4,8(a5)
 b20:	fe843783          	ld	a5,-24(s0)
 b24:	639c                	ld	a5,0(a5)
 b26:	479c                	lw	a5,8(a5)
 b28:	9fb9                	addw	a5,a5,a4
 b2a:	0007871b          	sext.w	a4,a5
 b2e:	fe043783          	ld	a5,-32(s0)
 b32:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b34:	fe843783          	ld	a5,-24(s0)
 b38:	639c                	ld	a5,0(a5)
 b3a:	6398                	ld	a4,0(a5)
 b3c:	fe043783          	ld	a5,-32(s0)
 b40:	e398                	sd	a4,0(a5)
 b42:	a039                	j	b50 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b44:	fe843783          	ld	a5,-24(s0)
 b48:	6398                	ld	a4,0(a5)
 b4a:	fe043783          	ld	a5,-32(s0)
 b4e:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b50:	fe843783          	ld	a5,-24(s0)
 b54:	479c                	lw	a5,8(a5)
 b56:	1782                	slli	a5,a5,0x20
 b58:	9381                	srli	a5,a5,0x20
 b5a:	0792                	slli	a5,a5,0x4
 b5c:	fe843703          	ld	a4,-24(s0)
 b60:	97ba                	add	a5,a5,a4
 b62:	fe043703          	ld	a4,-32(s0)
 b66:	02f71563          	bne	a4,a5,b90 <free+0x102>
    p->s.size += bp->s.size;
 b6a:	fe843783          	ld	a5,-24(s0)
 b6e:	4798                	lw	a4,8(a5)
 b70:	fe043783          	ld	a5,-32(s0)
 b74:	479c                	lw	a5,8(a5)
 b76:	9fb9                	addw	a5,a5,a4
 b78:	0007871b          	sext.w	a4,a5
 b7c:	fe843783          	ld	a5,-24(s0)
 b80:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b82:	fe043783          	ld	a5,-32(s0)
 b86:	6398                	ld	a4,0(a5)
 b88:	fe843783          	ld	a5,-24(s0)
 b8c:	e398                	sd	a4,0(a5)
 b8e:	a031                	j	b9a <free+0x10c>
  } else
    p->s.ptr = bp;
 b90:	fe843783          	ld	a5,-24(s0)
 b94:	fe043703          	ld	a4,-32(s0)
 b98:	e398                	sd	a4,0(a5)
  freep = p;
 b9a:	00000797          	auipc	a5,0x0
 b9e:	3c678793          	addi	a5,a5,966 # f60 <freep>
 ba2:	fe843703          	ld	a4,-24(s0)
 ba6:	e398                	sd	a4,0(a5)
}
 ba8:	0001                	nop
 baa:	7422                	ld	s0,40(sp)
 bac:	6145                	addi	sp,sp,48
 bae:	8082                	ret

0000000000000bb0 <morecore>:

static Header*
morecore(uint nu)
{
 bb0:	7179                	addi	sp,sp,-48
 bb2:	f406                	sd	ra,40(sp)
 bb4:	f022                	sd	s0,32(sp)
 bb6:	1800                	addi	s0,sp,48
 bb8:	87aa                	mv	a5,a0
 bba:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 bbe:	fdc42783          	lw	a5,-36(s0)
 bc2:	0007871b          	sext.w	a4,a5
 bc6:	6785                	lui	a5,0x1
 bc8:	00f77563          	bgeu	a4,a5,bd2 <morecore+0x22>
    nu = 4096;
 bcc:	6785                	lui	a5,0x1
 bce:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 bd2:	fdc42783          	lw	a5,-36(s0)
 bd6:	0047979b          	slliw	a5,a5,0x4
 bda:	2781                	sext.w	a5,a5
 bdc:	2781                	sext.w	a5,a5
 bde:	853e                	mv	a0,a5
 be0:	00000097          	auipc	ra,0x0
 be4:	9ae080e7          	jalr	-1618(ra) # 58e <sbrk>
 be8:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 bec:	fe843703          	ld	a4,-24(s0)
 bf0:	57fd                	li	a5,-1
 bf2:	00f71463          	bne	a4,a5,bfa <morecore+0x4a>
    return 0;
 bf6:	4781                	li	a5,0
 bf8:	a03d                	j	c26 <morecore+0x76>
  hp = (Header*)p;
 bfa:	fe843783          	ld	a5,-24(s0)
 bfe:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c02:	fe043783          	ld	a5,-32(s0)
 c06:	fdc42703          	lw	a4,-36(s0)
 c0a:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c0c:	fe043783          	ld	a5,-32(s0)
 c10:	07c1                	addi	a5,a5,16
 c12:	853e                	mv	a0,a5
 c14:	00000097          	auipc	ra,0x0
 c18:	e7a080e7          	jalr	-390(ra) # a8e <free>
  return freep;
 c1c:	00000797          	auipc	a5,0x0
 c20:	34478793          	addi	a5,a5,836 # f60 <freep>
 c24:	639c                	ld	a5,0(a5)
}
 c26:	853e                	mv	a0,a5
 c28:	70a2                	ld	ra,40(sp)
 c2a:	7402                	ld	s0,32(sp)
 c2c:	6145                	addi	sp,sp,48
 c2e:	8082                	ret

0000000000000c30 <malloc>:

void*
malloc(uint nbytes)
{
 c30:	7139                	addi	sp,sp,-64
 c32:	fc06                	sd	ra,56(sp)
 c34:	f822                	sd	s0,48(sp)
 c36:	0080                	addi	s0,sp,64
 c38:	87aa                	mv	a5,a0
 c3a:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c3e:	fcc46783          	lwu	a5,-52(s0)
 c42:	07bd                	addi	a5,a5,15
 c44:	8391                	srli	a5,a5,0x4
 c46:	2781                	sext.w	a5,a5
 c48:	2785                	addiw	a5,a5,1
 c4a:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c4e:	00000797          	auipc	a5,0x0
 c52:	31278793          	addi	a5,a5,786 # f60 <freep>
 c56:	639c                	ld	a5,0(a5)
 c58:	fef43023          	sd	a5,-32(s0)
 c5c:	fe043783          	ld	a5,-32(s0)
 c60:	ef95                	bnez	a5,c9c <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c62:	00000797          	auipc	a5,0x0
 c66:	2ee78793          	addi	a5,a5,750 # f50 <base>
 c6a:	fef43023          	sd	a5,-32(s0)
 c6e:	00000797          	auipc	a5,0x0
 c72:	2f278793          	addi	a5,a5,754 # f60 <freep>
 c76:	fe043703          	ld	a4,-32(s0)
 c7a:	e398                	sd	a4,0(a5)
 c7c:	00000797          	auipc	a5,0x0
 c80:	2e478793          	addi	a5,a5,740 # f60 <freep>
 c84:	6398                	ld	a4,0(a5)
 c86:	00000797          	auipc	a5,0x0
 c8a:	2ca78793          	addi	a5,a5,714 # f50 <base>
 c8e:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 c90:	00000797          	auipc	a5,0x0
 c94:	2c078793          	addi	a5,a5,704 # f50 <base>
 c98:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c9c:	fe043783          	ld	a5,-32(s0)
 ca0:	639c                	ld	a5,0(a5)
 ca2:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 ca6:	fe843783          	ld	a5,-24(s0)
 caa:	4798                	lw	a4,8(a5)
 cac:	fdc42783          	lw	a5,-36(s0)
 cb0:	2781                	sext.w	a5,a5
 cb2:	06f76763          	bltu	a4,a5,d20 <malloc+0xf0>
      if(p->s.size == nunits)
 cb6:	fe843783          	ld	a5,-24(s0)
 cba:	4798                	lw	a4,8(a5)
 cbc:	fdc42783          	lw	a5,-36(s0)
 cc0:	2781                	sext.w	a5,a5
 cc2:	00e79963          	bne	a5,a4,cd4 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 cc6:	fe843783          	ld	a5,-24(s0)
 cca:	6398                	ld	a4,0(a5)
 ccc:	fe043783          	ld	a5,-32(s0)
 cd0:	e398                	sd	a4,0(a5)
 cd2:	a825                	j	d0a <malloc+0xda>
      else {
        p->s.size -= nunits;
 cd4:	fe843783          	ld	a5,-24(s0)
 cd8:	479c                	lw	a5,8(a5)
 cda:	fdc42703          	lw	a4,-36(s0)
 cde:	9f99                	subw	a5,a5,a4
 ce0:	0007871b          	sext.w	a4,a5
 ce4:	fe843783          	ld	a5,-24(s0)
 ce8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 cea:	fe843783          	ld	a5,-24(s0)
 cee:	479c                	lw	a5,8(a5)
 cf0:	1782                	slli	a5,a5,0x20
 cf2:	9381                	srli	a5,a5,0x20
 cf4:	0792                	slli	a5,a5,0x4
 cf6:	fe843703          	ld	a4,-24(s0)
 cfa:	97ba                	add	a5,a5,a4
 cfc:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d00:	fe843783          	ld	a5,-24(s0)
 d04:	fdc42703          	lw	a4,-36(s0)
 d08:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d0a:	00000797          	auipc	a5,0x0
 d0e:	25678793          	addi	a5,a5,598 # f60 <freep>
 d12:	fe043703          	ld	a4,-32(s0)
 d16:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d18:	fe843783          	ld	a5,-24(s0)
 d1c:	07c1                	addi	a5,a5,16
 d1e:	a091                	j	d62 <malloc+0x132>
    }
    if(p == freep)
 d20:	00000797          	auipc	a5,0x0
 d24:	24078793          	addi	a5,a5,576 # f60 <freep>
 d28:	639c                	ld	a5,0(a5)
 d2a:	fe843703          	ld	a4,-24(s0)
 d2e:	02f71063          	bne	a4,a5,d4e <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 d32:	fdc42783          	lw	a5,-36(s0)
 d36:	853e                	mv	a0,a5
 d38:	00000097          	auipc	ra,0x0
 d3c:	e78080e7          	jalr	-392(ra) # bb0 <morecore>
 d40:	fea43423          	sd	a0,-24(s0)
 d44:	fe843783          	ld	a5,-24(s0)
 d48:	e399                	bnez	a5,d4e <malloc+0x11e>
        return 0;
 d4a:	4781                	li	a5,0
 d4c:	a819                	j	d62 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d4e:	fe843783          	ld	a5,-24(s0)
 d52:	fef43023          	sd	a5,-32(s0)
 d56:	fe843783          	ld	a5,-24(s0)
 d5a:	639c                	ld	a5,0(a5)
 d5c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d60:	b799                	j	ca6 <malloc+0x76>
  }
}
 d62:	853e                	mv	a0,a5
 d64:	70e2                	ld	ra,56(sp)
 d66:	7442                	ld	s0,48(sp)
 d68:	6121                	addi	sp,sp,64
 d6a:	8082                	ret

0000000000000d6c <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
 d6c:	7179                	addi	sp,sp,-48
 d6e:	f406                	sd	ra,40(sp)
 d70:	f022                	sd	s0,32(sp)
 d72:	1800                	addi	s0,sp,48
 d74:	fca43c23          	sd	a0,-40(s0)
 d78:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
 d7c:	6505                	lui	a0,0x1
 d7e:	00000097          	auipc	ra,0x0
 d82:	eb2080e7          	jalr	-334(ra) # c30 <malloc>
 d86:	fea43423          	sd	a0,-24(s0)
 d8a:	fe843783          	ld	a5,-24(s0)
 d8e:	e38d                	bnez	a5,db0 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
 d90:	00000517          	auipc	a0,0x0
 d94:	15850513          	addi	a0,a0,344 # ee8 <lock_init+0x80>
 d98:	00000097          	auipc	ra,0x0
 d9c:	ca6080e7          	jalr	-858(ra) # a3e <printf>
        free(stack);
 da0:	fe843503          	ld	a0,-24(s0)
 da4:	00000097          	auipc	ra,0x0
 da8:	cea080e7          	jalr	-790(ra) # a8e <free>
        return -1;
 dac:	57fd                	li	a5,-1
 dae:	a099                	j	df4 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
 db0:	fe843783          	ld	a5,-24(s0)
 db4:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
 db8:	fe043703          	ld	a4,-32(s0)
 dbc:	6785                	lui	a5,0x1
 dbe:	17fd                	addi	a5,a5,-1
 dc0:	8ff9                	and	a5,a5,a4
 dc2:	cf91                	beqz	a5,dde <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
 dc4:	fe043703          	ld	a4,-32(s0)
 dc8:	6785                	lui	a5,0x1
 dca:	17fd                	addi	a5,a5,-1
 dcc:	8ff9                	and	a5,a5,a4
 dce:	6705                	lui	a4,0x1
 dd0:	40f707b3          	sub	a5,a4,a5
 dd4:	fe843703          	ld	a4,-24(s0)
 dd8:	97ba                	add	a5,a5,a4
 dda:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
 dde:	fe843603          	ld	a2,-24(s0)
 de2:	fd043583          	ld	a1,-48(s0)
 de6:	fd843503          	ld	a0,-40(s0)
 dea:	fffff097          	auipc	ra,0xfffff
 dee:	7bc080e7          	jalr	1980(ra) # 5a6 <clone>
 df2:	87aa                	mv	a5,a0
}
 df4:	853e                	mv	a0,a5
 df6:	70a2                	ld	ra,40(sp)
 df8:	7402                	ld	s0,32(sp)
 dfa:	6145                	addi	sp,sp,48
 dfc:	8082                	ret

0000000000000dfe <thread_join>:


int thread_join()
{
 dfe:	1101                	addi	sp,sp,-32
 e00:	ec06                	sd	ra,24(sp)
 e02:	e822                	sd	s0,16(sp)
 e04:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
 e06:	fe040793          	addi	a5,s0,-32
 e0a:	853e                	mv	a0,a5
 e0c:	fffff097          	auipc	ra,0xfffff
 e10:	7a2080e7          	jalr	1954(ra) # 5ae <join>
 e14:	87aa                	mv	a5,a0
 e16:	fef42623          	sw	a5,-20(s0)
 e1a:	fec42783          	lw	a5,-20(s0)
 e1e:	0007871b          	sext.w	a4,a5
 e22:	57fd                	li	a5,-1
 e24:	00f70963          	beq	a4,a5,e36 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
 e28:	fe043783          	ld	a5,-32(s0)
 e2c:	853e                	mv	a0,a5
 e2e:	00000097          	auipc	ra,0x0
 e32:	c60080e7          	jalr	-928(ra) # a8e <free>
    } 

    return child_tid;
 e36:	fec42783          	lw	a5,-20(s0)
}
 e3a:	853e                	mv	a0,a5
 e3c:	60e2                	ld	ra,24(sp)
 e3e:	6442                	ld	s0,16(sp)
 e40:	6105                	addi	sp,sp,32
 e42:	8082                	ret

0000000000000e44 <lock_acquire>:


void lock_acquire (lock_t *)
{
 e44:	1101                	addi	sp,sp,-32
 e46:	ec22                	sd	s0,24(sp)
 e48:	1000                	addi	s0,sp,32
 e4a:	fea43423          	sd	a0,-24(s0)

}
 e4e:	0001                	nop
 e50:	6462                	ld	s0,24(sp)
 e52:	6105                	addi	sp,sp,32
 e54:	8082                	ret

0000000000000e56 <lock_release>:

void lock_release (lock_t *)
{
 e56:	1101                	addi	sp,sp,-32
 e58:	ec22                	sd	s0,24(sp)
 e5a:	1000                	addi	s0,sp,32
 e5c:	fea43423          	sd	a0,-24(s0)
    
}
 e60:	0001                	nop
 e62:	6462                	ld	s0,24(sp)
 e64:	6105                	addi	sp,sp,32
 e66:	8082                	ret

0000000000000e68 <lock_init>:

void lock_init (lock_t *)
{
 e68:	1101                	addi	sp,sp,-32
 e6a:	ec22                	sd	s0,24(sp)
 e6c:	1000                	addi	s0,sp,32
 e6e:	fea43423          	sd	a0,-24(s0)
    
}
 e72:	0001                	nop
 e74:	6462                	ld	s0,24(sp)
 e76:	6105                	addi	sp,sp,32
 e78:	8082                	ret
