
user/_ln:     file format elf64-littleriscv


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
  if(argc != 3){
  12:	fec42783          	lw	a5,-20(s0)
  16:	0007871b          	sext.w	a4,a5
  1a:	478d                	li	a5,3
  1c:	02f70063          	beq	a4,a5,3c <main+0x3c>
    fprintf(2, "Usage: ln old new\n");
  20:	00001597          	auipc	a1,0x1
  24:	e8858593          	addi	a1,a1,-376 # ea8 <lock_init+0x18>
  28:	4509                	li	a0,2
  2a:	00001097          	auipc	ra,0x1
  2e:	9d6080e7          	jalr	-1578(ra) # a00 <fprintf>
    exit(1);
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	4ec080e7          	jalr	1260(ra) # 520 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  3c:	fe043783          	ld	a5,-32(s0)
  40:	07a1                	addi	a5,a5,8
  42:	6398                	ld	a4,0(a5)
  44:	fe043783          	ld	a5,-32(s0)
  48:	07c1                	addi	a5,a5,16
  4a:	639c                	ld	a5,0(a5)
  4c:	85be                	mv	a1,a5
  4e:	853a                	mv	a0,a4
  50:	00000097          	auipc	ra,0x0
  54:	530080e7          	jalr	1328(ra) # 580 <link>
  58:	87aa                	mv	a5,a0
  5a:	0207d563          	bgez	a5,84 <main+0x84>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  5e:	fe043783          	ld	a5,-32(s0)
  62:	07a1                	addi	a5,a5,8
  64:	6398                	ld	a4,0(a5)
  66:	fe043783          	ld	a5,-32(s0)
  6a:	07c1                	addi	a5,a5,16
  6c:	639c                	ld	a5,0(a5)
  6e:	86be                	mv	a3,a5
  70:	863a                	mv	a2,a4
  72:	00001597          	auipc	a1,0x1
  76:	e4e58593          	addi	a1,a1,-434 # ec0 <lock_init+0x30>
  7a:	4509                	li	a0,2
  7c:	00001097          	auipc	ra,0x1
  80:	984080e7          	jalr	-1660(ra) # a00 <fprintf>
  exit(0);
  84:	4501                	li	a0,0
  86:	00000097          	auipc	ra,0x0
  8a:	49a080e7          	jalr	1178(ra) # 520 <exit>

000000000000008e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  8e:	7179                	addi	sp,sp,-48
  90:	f422                	sd	s0,40(sp)
  92:	1800                	addi	s0,sp,48
  94:	fca43c23          	sd	a0,-40(s0)
  98:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  9c:	fd843783          	ld	a5,-40(s0)
  a0:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  a4:	0001                	nop
  a6:	fd043703          	ld	a4,-48(s0)
  aa:	00170793          	addi	a5,a4,1
  ae:	fcf43823          	sd	a5,-48(s0)
  b2:	fd843783          	ld	a5,-40(s0)
  b6:	00178693          	addi	a3,a5,1
  ba:	fcd43c23          	sd	a3,-40(s0)
  be:	00074703          	lbu	a4,0(a4)
  c2:	00e78023          	sb	a4,0(a5)
  c6:	0007c783          	lbu	a5,0(a5)
  ca:	fff1                	bnez	a5,a6 <strcpy+0x18>
    ;
  return os;
  cc:	fe843783          	ld	a5,-24(s0)
}
  d0:	853e                	mv	a0,a5
  d2:	7422                	ld	s0,40(sp)
  d4:	6145                	addi	sp,sp,48
  d6:	8082                	ret

00000000000000d8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d8:	1101                	addi	sp,sp,-32
  da:	ec22                	sd	s0,24(sp)
  dc:	1000                	addi	s0,sp,32
  de:	fea43423          	sd	a0,-24(s0)
  e2:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
  e6:	a819                	j	fc <strcmp+0x24>
    p++, q++;
  e8:	fe843783          	ld	a5,-24(s0)
  ec:	0785                	addi	a5,a5,1
  ee:	fef43423          	sd	a5,-24(s0)
  f2:	fe043783          	ld	a5,-32(s0)
  f6:	0785                	addi	a5,a5,1
  f8:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
  fc:	fe843783          	ld	a5,-24(s0)
 100:	0007c783          	lbu	a5,0(a5)
 104:	cb99                	beqz	a5,11a <strcmp+0x42>
 106:	fe843783          	ld	a5,-24(s0)
 10a:	0007c703          	lbu	a4,0(a5)
 10e:	fe043783          	ld	a5,-32(s0)
 112:	0007c783          	lbu	a5,0(a5)
 116:	fcf709e3          	beq	a4,a5,e8 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 11a:	fe843783          	ld	a5,-24(s0)
 11e:	0007c783          	lbu	a5,0(a5)
 122:	0007871b          	sext.w	a4,a5
 126:	fe043783          	ld	a5,-32(s0)
 12a:	0007c783          	lbu	a5,0(a5)
 12e:	2781                	sext.w	a5,a5
 130:	40f707bb          	subw	a5,a4,a5
 134:	2781                	sext.w	a5,a5
}
 136:	853e                	mv	a0,a5
 138:	6462                	ld	s0,24(sp)
 13a:	6105                	addi	sp,sp,32
 13c:	8082                	ret

000000000000013e <strlen>:

uint
strlen(const char *s)
{
 13e:	7179                	addi	sp,sp,-48
 140:	f422                	sd	s0,40(sp)
 142:	1800                	addi	s0,sp,48
 144:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 148:	fe042623          	sw	zero,-20(s0)
 14c:	a031                	j	158 <strlen+0x1a>
 14e:	fec42783          	lw	a5,-20(s0)
 152:	2785                	addiw	a5,a5,1
 154:	fef42623          	sw	a5,-20(s0)
 158:	fec42783          	lw	a5,-20(s0)
 15c:	fd843703          	ld	a4,-40(s0)
 160:	97ba                	add	a5,a5,a4
 162:	0007c783          	lbu	a5,0(a5)
 166:	f7e5                	bnez	a5,14e <strlen+0x10>
    ;
  return n;
 168:	fec42783          	lw	a5,-20(s0)
}
 16c:	853e                	mv	a0,a5
 16e:	7422                	ld	s0,40(sp)
 170:	6145                	addi	sp,sp,48
 172:	8082                	ret

0000000000000174 <memset>:

void*
memset(void *dst, int c, uint n)
{
 174:	7179                	addi	sp,sp,-48
 176:	f422                	sd	s0,40(sp)
 178:	1800                	addi	s0,sp,48
 17a:	fca43c23          	sd	a0,-40(s0)
 17e:	87ae                	mv	a5,a1
 180:	8732                	mv	a4,a2
 182:	fcf42a23          	sw	a5,-44(s0)
 186:	87ba                	mv	a5,a4
 188:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 18c:	fd843783          	ld	a5,-40(s0)
 190:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 194:	fe042623          	sw	zero,-20(s0)
 198:	a00d                	j	1ba <memset+0x46>
    cdst[i] = c;
 19a:	fec42783          	lw	a5,-20(s0)
 19e:	fe043703          	ld	a4,-32(s0)
 1a2:	97ba                	add	a5,a5,a4
 1a4:	fd442703          	lw	a4,-44(s0)
 1a8:	0ff77713          	zext.b	a4,a4
 1ac:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1b0:	fec42783          	lw	a5,-20(s0)
 1b4:	2785                	addiw	a5,a5,1
 1b6:	fef42623          	sw	a5,-20(s0)
 1ba:	fec42703          	lw	a4,-20(s0)
 1be:	fd042783          	lw	a5,-48(s0)
 1c2:	2781                	sext.w	a5,a5
 1c4:	fcf76be3          	bltu	a4,a5,19a <memset+0x26>
  }
  return dst;
 1c8:	fd843783          	ld	a5,-40(s0)
}
 1cc:	853e                	mv	a0,a5
 1ce:	7422                	ld	s0,40(sp)
 1d0:	6145                	addi	sp,sp,48
 1d2:	8082                	ret

00000000000001d4 <strchr>:

char*
strchr(const char *s, char c)
{
 1d4:	1101                	addi	sp,sp,-32
 1d6:	ec22                	sd	s0,24(sp)
 1d8:	1000                	addi	s0,sp,32
 1da:	fea43423          	sd	a0,-24(s0)
 1de:	87ae                	mv	a5,a1
 1e0:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 1e4:	a01d                	j	20a <strchr+0x36>
    if(*s == c)
 1e6:	fe843783          	ld	a5,-24(s0)
 1ea:	0007c703          	lbu	a4,0(a5)
 1ee:	fe744783          	lbu	a5,-25(s0)
 1f2:	0ff7f793          	zext.b	a5,a5
 1f6:	00e79563          	bne	a5,a4,200 <strchr+0x2c>
      return (char*)s;
 1fa:	fe843783          	ld	a5,-24(s0)
 1fe:	a821                	j	216 <strchr+0x42>
  for(; *s; s++)
 200:	fe843783          	ld	a5,-24(s0)
 204:	0785                	addi	a5,a5,1
 206:	fef43423          	sd	a5,-24(s0)
 20a:	fe843783          	ld	a5,-24(s0)
 20e:	0007c783          	lbu	a5,0(a5)
 212:	fbf1                	bnez	a5,1e6 <strchr+0x12>
  return 0;
 214:	4781                	li	a5,0
}
 216:	853e                	mv	a0,a5
 218:	6462                	ld	s0,24(sp)
 21a:	6105                	addi	sp,sp,32
 21c:	8082                	ret

000000000000021e <gets>:

char*
gets(char *buf, int max)
{
 21e:	7179                	addi	sp,sp,-48
 220:	f406                	sd	ra,40(sp)
 222:	f022                	sd	s0,32(sp)
 224:	1800                	addi	s0,sp,48
 226:	fca43c23          	sd	a0,-40(s0)
 22a:	87ae                	mv	a5,a1
 22c:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 230:	fe042623          	sw	zero,-20(s0)
 234:	a8a1                	j	28c <gets+0x6e>
    cc = read(0, &c, 1);
 236:	fe740793          	addi	a5,s0,-25
 23a:	4605                	li	a2,1
 23c:	85be                	mv	a1,a5
 23e:	4501                	li	a0,0
 240:	00000097          	auipc	ra,0x0
 244:	2f8080e7          	jalr	760(ra) # 538 <read>
 248:	87aa                	mv	a5,a0
 24a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 24e:	fe842783          	lw	a5,-24(s0)
 252:	2781                	sext.w	a5,a5
 254:	04f05763          	blez	a5,2a2 <gets+0x84>
      break;
    buf[i++] = c;
 258:	fec42783          	lw	a5,-20(s0)
 25c:	0017871b          	addiw	a4,a5,1
 260:	fee42623          	sw	a4,-20(s0)
 264:	873e                	mv	a4,a5
 266:	fd843783          	ld	a5,-40(s0)
 26a:	97ba                	add	a5,a5,a4
 26c:	fe744703          	lbu	a4,-25(s0)
 270:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 274:	fe744783          	lbu	a5,-25(s0)
 278:	873e                	mv	a4,a5
 27a:	47a9                	li	a5,10
 27c:	02f70463          	beq	a4,a5,2a4 <gets+0x86>
 280:	fe744783          	lbu	a5,-25(s0)
 284:	873e                	mv	a4,a5
 286:	47b5                	li	a5,13
 288:	00f70e63          	beq	a4,a5,2a4 <gets+0x86>
  for(i=0; i+1 < max; ){
 28c:	fec42783          	lw	a5,-20(s0)
 290:	2785                	addiw	a5,a5,1
 292:	0007871b          	sext.w	a4,a5
 296:	fd442783          	lw	a5,-44(s0)
 29a:	2781                	sext.w	a5,a5
 29c:	f8f74de3          	blt	a4,a5,236 <gets+0x18>
 2a0:	a011                	j	2a4 <gets+0x86>
      break;
 2a2:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2a4:	fec42783          	lw	a5,-20(s0)
 2a8:	fd843703          	ld	a4,-40(s0)
 2ac:	97ba                	add	a5,a5,a4
 2ae:	00078023          	sb	zero,0(a5)
  return buf;
 2b2:	fd843783          	ld	a5,-40(s0)
}
 2b6:	853e                	mv	a0,a5
 2b8:	70a2                	ld	ra,40(sp)
 2ba:	7402                	ld	s0,32(sp)
 2bc:	6145                	addi	sp,sp,48
 2be:	8082                	ret

00000000000002c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2c0:	7179                	addi	sp,sp,-48
 2c2:	f406                	sd	ra,40(sp)
 2c4:	f022                	sd	s0,32(sp)
 2c6:	1800                	addi	s0,sp,48
 2c8:	fca43c23          	sd	a0,-40(s0)
 2cc:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d0:	4581                	li	a1,0
 2d2:	fd843503          	ld	a0,-40(s0)
 2d6:	00000097          	auipc	ra,0x0
 2da:	28a080e7          	jalr	650(ra) # 560 <open>
 2de:	87aa                	mv	a5,a0
 2e0:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 2e4:	fec42783          	lw	a5,-20(s0)
 2e8:	2781                	sext.w	a5,a5
 2ea:	0007d463          	bgez	a5,2f2 <stat+0x32>
    return -1;
 2ee:	57fd                	li	a5,-1
 2f0:	a035                	j	31c <stat+0x5c>
  r = fstat(fd, st);
 2f2:	fec42783          	lw	a5,-20(s0)
 2f6:	fd043583          	ld	a1,-48(s0)
 2fa:	853e                	mv	a0,a5
 2fc:	00000097          	auipc	ra,0x0
 300:	27c080e7          	jalr	636(ra) # 578 <fstat>
 304:	87aa                	mv	a5,a0
 306:	fef42423          	sw	a5,-24(s0)
  close(fd);
 30a:	fec42783          	lw	a5,-20(s0)
 30e:	853e                	mv	a0,a5
 310:	00000097          	auipc	ra,0x0
 314:	238080e7          	jalr	568(ra) # 548 <close>
  return r;
 318:	fe842783          	lw	a5,-24(s0)
}
 31c:	853e                	mv	a0,a5
 31e:	70a2                	ld	ra,40(sp)
 320:	7402                	ld	s0,32(sp)
 322:	6145                	addi	sp,sp,48
 324:	8082                	ret

0000000000000326 <atoi>:

int
atoi(const char *s)
{
 326:	7179                	addi	sp,sp,-48
 328:	f422                	sd	s0,40(sp)
 32a:	1800                	addi	s0,sp,48
 32c:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 330:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 334:	a81d                	j	36a <atoi+0x44>
    n = n*10 + *s++ - '0';
 336:	fec42783          	lw	a5,-20(s0)
 33a:	873e                	mv	a4,a5
 33c:	87ba                	mv	a5,a4
 33e:	0027979b          	slliw	a5,a5,0x2
 342:	9fb9                	addw	a5,a5,a4
 344:	0017979b          	slliw	a5,a5,0x1
 348:	0007871b          	sext.w	a4,a5
 34c:	fd843783          	ld	a5,-40(s0)
 350:	00178693          	addi	a3,a5,1
 354:	fcd43c23          	sd	a3,-40(s0)
 358:	0007c783          	lbu	a5,0(a5)
 35c:	2781                	sext.w	a5,a5
 35e:	9fb9                	addw	a5,a5,a4
 360:	2781                	sext.w	a5,a5
 362:	fd07879b          	addiw	a5,a5,-48
 366:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 36a:	fd843783          	ld	a5,-40(s0)
 36e:	0007c783          	lbu	a5,0(a5)
 372:	873e                	mv	a4,a5
 374:	02f00793          	li	a5,47
 378:	00e7fb63          	bgeu	a5,a4,38e <atoi+0x68>
 37c:	fd843783          	ld	a5,-40(s0)
 380:	0007c783          	lbu	a5,0(a5)
 384:	873e                	mv	a4,a5
 386:	03900793          	li	a5,57
 38a:	fae7f6e3          	bgeu	a5,a4,336 <atoi+0x10>
  return n;
 38e:	fec42783          	lw	a5,-20(s0)
}
 392:	853e                	mv	a0,a5
 394:	7422                	ld	s0,40(sp)
 396:	6145                	addi	sp,sp,48
 398:	8082                	ret

000000000000039a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 39a:	7139                	addi	sp,sp,-64
 39c:	fc22                	sd	s0,56(sp)
 39e:	0080                	addi	s0,sp,64
 3a0:	fca43c23          	sd	a0,-40(s0)
 3a4:	fcb43823          	sd	a1,-48(s0)
 3a8:	87b2                	mv	a5,a2
 3aa:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3ae:	fd843783          	ld	a5,-40(s0)
 3b2:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3b6:	fd043783          	ld	a5,-48(s0)
 3ba:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3be:	fe043703          	ld	a4,-32(s0)
 3c2:	fe843783          	ld	a5,-24(s0)
 3c6:	02e7fc63          	bgeu	a5,a4,3fe <memmove+0x64>
    while(n-- > 0)
 3ca:	a00d                	j	3ec <memmove+0x52>
      *dst++ = *src++;
 3cc:	fe043703          	ld	a4,-32(s0)
 3d0:	00170793          	addi	a5,a4,1
 3d4:	fef43023          	sd	a5,-32(s0)
 3d8:	fe843783          	ld	a5,-24(s0)
 3dc:	00178693          	addi	a3,a5,1
 3e0:	fed43423          	sd	a3,-24(s0)
 3e4:	00074703          	lbu	a4,0(a4)
 3e8:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3ec:	fcc42783          	lw	a5,-52(s0)
 3f0:	fff7871b          	addiw	a4,a5,-1
 3f4:	fce42623          	sw	a4,-52(s0)
 3f8:	fcf04ae3          	bgtz	a5,3cc <memmove+0x32>
 3fc:	a891                	j	450 <memmove+0xb6>
  } else {
    dst += n;
 3fe:	fcc42783          	lw	a5,-52(s0)
 402:	fe843703          	ld	a4,-24(s0)
 406:	97ba                	add	a5,a5,a4
 408:	fef43423          	sd	a5,-24(s0)
    src += n;
 40c:	fcc42783          	lw	a5,-52(s0)
 410:	fe043703          	ld	a4,-32(s0)
 414:	97ba                	add	a5,a5,a4
 416:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 41a:	a01d                	j	440 <memmove+0xa6>
      *--dst = *--src;
 41c:	fe043783          	ld	a5,-32(s0)
 420:	17fd                	addi	a5,a5,-1
 422:	fef43023          	sd	a5,-32(s0)
 426:	fe843783          	ld	a5,-24(s0)
 42a:	17fd                	addi	a5,a5,-1
 42c:	fef43423          	sd	a5,-24(s0)
 430:	fe043783          	ld	a5,-32(s0)
 434:	0007c703          	lbu	a4,0(a5)
 438:	fe843783          	ld	a5,-24(s0)
 43c:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 440:	fcc42783          	lw	a5,-52(s0)
 444:	fff7871b          	addiw	a4,a5,-1
 448:	fce42623          	sw	a4,-52(s0)
 44c:	fcf048e3          	bgtz	a5,41c <memmove+0x82>
  }
  return vdst;
 450:	fd843783          	ld	a5,-40(s0)
}
 454:	853e                	mv	a0,a5
 456:	7462                	ld	s0,56(sp)
 458:	6121                	addi	sp,sp,64
 45a:	8082                	ret

000000000000045c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 45c:	7139                	addi	sp,sp,-64
 45e:	fc22                	sd	s0,56(sp)
 460:	0080                	addi	s0,sp,64
 462:	fca43c23          	sd	a0,-40(s0)
 466:	fcb43823          	sd	a1,-48(s0)
 46a:	87b2                	mv	a5,a2
 46c:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 470:	fd843783          	ld	a5,-40(s0)
 474:	fef43423          	sd	a5,-24(s0)
 478:	fd043783          	ld	a5,-48(s0)
 47c:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 480:	a0a1                	j	4c8 <memcmp+0x6c>
    if (*p1 != *p2) {
 482:	fe843783          	ld	a5,-24(s0)
 486:	0007c703          	lbu	a4,0(a5)
 48a:	fe043783          	ld	a5,-32(s0)
 48e:	0007c783          	lbu	a5,0(a5)
 492:	02f70163          	beq	a4,a5,4b4 <memcmp+0x58>
      return *p1 - *p2;
 496:	fe843783          	ld	a5,-24(s0)
 49a:	0007c783          	lbu	a5,0(a5)
 49e:	0007871b          	sext.w	a4,a5
 4a2:	fe043783          	ld	a5,-32(s0)
 4a6:	0007c783          	lbu	a5,0(a5)
 4aa:	2781                	sext.w	a5,a5
 4ac:	40f707bb          	subw	a5,a4,a5
 4b0:	2781                	sext.w	a5,a5
 4b2:	a01d                	j	4d8 <memcmp+0x7c>
    }
    p1++;
 4b4:	fe843783          	ld	a5,-24(s0)
 4b8:	0785                	addi	a5,a5,1
 4ba:	fef43423          	sd	a5,-24(s0)
    p2++;
 4be:	fe043783          	ld	a5,-32(s0)
 4c2:	0785                	addi	a5,a5,1
 4c4:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4c8:	fcc42783          	lw	a5,-52(s0)
 4cc:	fff7871b          	addiw	a4,a5,-1
 4d0:	fce42623          	sw	a4,-52(s0)
 4d4:	f7dd                	bnez	a5,482 <memcmp+0x26>
  }
  return 0;
 4d6:	4781                	li	a5,0
}
 4d8:	853e                	mv	a0,a5
 4da:	7462                	ld	s0,56(sp)
 4dc:	6121                	addi	sp,sp,64
 4de:	8082                	ret

00000000000004e0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4e0:	7179                	addi	sp,sp,-48
 4e2:	f406                	sd	ra,40(sp)
 4e4:	f022                	sd	s0,32(sp)
 4e6:	1800                	addi	s0,sp,48
 4e8:	fea43423          	sd	a0,-24(s0)
 4ec:	feb43023          	sd	a1,-32(s0)
 4f0:	87b2                	mv	a5,a2
 4f2:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 4f6:	fdc42783          	lw	a5,-36(s0)
 4fa:	863e                	mv	a2,a5
 4fc:	fe043583          	ld	a1,-32(s0)
 500:	fe843503          	ld	a0,-24(s0)
 504:	00000097          	auipc	ra,0x0
 508:	e96080e7          	jalr	-362(ra) # 39a <memmove>
 50c:	87aa                	mv	a5,a0
}
 50e:	853e                	mv	a0,a5
 510:	70a2                	ld	ra,40(sp)
 512:	7402                	ld	s0,32(sp)
 514:	6145                	addi	sp,sp,48
 516:	8082                	ret

0000000000000518 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 518:	4885                	li	a7,1
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <exit>:
.global exit
exit:
 li a7, SYS_exit
 520:	4889                	li	a7,2
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <wait>:
.global wait
wait:
 li a7, SYS_wait
 528:	488d                	li	a7,3
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 530:	4891                	li	a7,4
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <read>:
.global read
read:
 li a7, SYS_read
 538:	4895                	li	a7,5
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <write>:
.global write
write:
 li a7, SYS_write
 540:	48c1                	li	a7,16
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <close>:
.global close
close:
 li a7, SYS_close
 548:	48d5                	li	a7,21
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <kill>:
.global kill
kill:
 li a7, SYS_kill
 550:	4899                	li	a7,6
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <exec>:
.global exec
exec:
 li a7, SYS_exec
 558:	489d                	li	a7,7
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <open>:
.global open
open:
 li a7, SYS_open
 560:	48bd                	li	a7,15
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 568:	48c5                	li	a7,17
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 570:	48c9                	li	a7,18
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 578:	48a1                	li	a7,8
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <link>:
.global link
link:
 li a7, SYS_link
 580:	48cd                	li	a7,19
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 588:	48d1                	li	a7,20
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 590:	48a5                	li	a7,9
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <dup>:
.global dup
dup:
 li a7, SYS_dup
 598:	48a9                	li	a7,10
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5a0:	48ad                	li	a7,11
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5a8:	48b1                	li	a7,12
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5b0:	48b5                	li	a7,13
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5b8:	48b9                	li	a7,14
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <clone>:
.global clone
clone:
 li a7, SYS_clone
 5c0:	48d9                	li	a7,22
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <join>:
.global join
join:
 li a7, SYS_join
 5c8:	48dd                	li	a7,23
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5d0:	1101                	addi	sp,sp,-32
 5d2:	ec06                	sd	ra,24(sp)
 5d4:	e822                	sd	s0,16(sp)
 5d6:	1000                	addi	s0,sp,32
 5d8:	87aa                	mv	a5,a0
 5da:	872e                	mv	a4,a1
 5dc:	fef42623          	sw	a5,-20(s0)
 5e0:	87ba                	mv	a5,a4
 5e2:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 5e6:	feb40713          	addi	a4,s0,-21
 5ea:	fec42783          	lw	a5,-20(s0)
 5ee:	4605                	li	a2,1
 5f0:	85ba                	mv	a1,a4
 5f2:	853e                	mv	a0,a5
 5f4:	00000097          	auipc	ra,0x0
 5f8:	f4c080e7          	jalr	-180(ra) # 540 <write>
}
 5fc:	0001                	nop
 5fe:	60e2                	ld	ra,24(sp)
 600:	6442                	ld	s0,16(sp)
 602:	6105                	addi	sp,sp,32
 604:	8082                	ret

0000000000000606 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 606:	7139                	addi	sp,sp,-64
 608:	fc06                	sd	ra,56(sp)
 60a:	f822                	sd	s0,48(sp)
 60c:	0080                	addi	s0,sp,64
 60e:	87aa                	mv	a5,a0
 610:	8736                	mv	a4,a3
 612:	fcf42623          	sw	a5,-52(s0)
 616:	87ae                	mv	a5,a1
 618:	fcf42423          	sw	a5,-56(s0)
 61c:	87b2                	mv	a5,a2
 61e:	fcf42223          	sw	a5,-60(s0)
 622:	87ba                	mv	a5,a4
 624:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 628:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 62c:	fc042783          	lw	a5,-64(s0)
 630:	2781                	sext.w	a5,a5
 632:	c38d                	beqz	a5,654 <printint+0x4e>
 634:	fc842783          	lw	a5,-56(s0)
 638:	2781                	sext.w	a5,a5
 63a:	0007dd63          	bgez	a5,654 <printint+0x4e>
    neg = 1;
 63e:	4785                	li	a5,1
 640:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 644:	fc842783          	lw	a5,-56(s0)
 648:	40f007bb          	negw	a5,a5
 64c:	2781                	sext.w	a5,a5
 64e:	fef42223          	sw	a5,-28(s0)
 652:	a029                	j	65c <printint+0x56>
  } else {
    x = xx;
 654:	fc842783          	lw	a5,-56(s0)
 658:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 65c:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 660:	fc442783          	lw	a5,-60(s0)
 664:	fe442703          	lw	a4,-28(s0)
 668:	02f777bb          	remuw	a5,a4,a5
 66c:	0007861b          	sext.w	a2,a5
 670:	fec42783          	lw	a5,-20(s0)
 674:	0017871b          	addiw	a4,a5,1
 678:	fee42623          	sw	a4,-20(s0)
 67c:	00001697          	auipc	a3,0x1
 680:	8b468693          	addi	a3,a3,-1868 # f30 <digits>
 684:	02061713          	slli	a4,a2,0x20
 688:	9301                	srli	a4,a4,0x20
 68a:	9736                	add	a4,a4,a3
 68c:	00074703          	lbu	a4,0(a4)
 690:	17c1                	addi	a5,a5,-16
 692:	97a2                	add	a5,a5,s0
 694:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 698:	fc442783          	lw	a5,-60(s0)
 69c:	fe442703          	lw	a4,-28(s0)
 6a0:	02f757bb          	divuw	a5,a4,a5
 6a4:	fef42223          	sw	a5,-28(s0)
 6a8:	fe442783          	lw	a5,-28(s0)
 6ac:	2781                	sext.w	a5,a5
 6ae:	fbcd                	bnez	a5,660 <printint+0x5a>
  if(neg)
 6b0:	fe842783          	lw	a5,-24(s0)
 6b4:	2781                	sext.w	a5,a5
 6b6:	cf85                	beqz	a5,6ee <printint+0xe8>
    buf[i++] = '-';
 6b8:	fec42783          	lw	a5,-20(s0)
 6bc:	0017871b          	addiw	a4,a5,1
 6c0:	fee42623          	sw	a4,-20(s0)
 6c4:	17c1                	addi	a5,a5,-16
 6c6:	97a2                	add	a5,a5,s0
 6c8:	02d00713          	li	a4,45
 6cc:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6d0:	a839                	j	6ee <printint+0xe8>
    putc(fd, buf[i]);
 6d2:	fec42783          	lw	a5,-20(s0)
 6d6:	17c1                	addi	a5,a5,-16
 6d8:	97a2                	add	a5,a5,s0
 6da:	fe07c703          	lbu	a4,-32(a5)
 6de:	fcc42783          	lw	a5,-52(s0)
 6e2:	85ba                	mv	a1,a4
 6e4:	853e                	mv	a0,a5
 6e6:	00000097          	auipc	ra,0x0
 6ea:	eea080e7          	jalr	-278(ra) # 5d0 <putc>
  while(--i >= 0)
 6ee:	fec42783          	lw	a5,-20(s0)
 6f2:	37fd                	addiw	a5,a5,-1
 6f4:	fef42623          	sw	a5,-20(s0)
 6f8:	fec42783          	lw	a5,-20(s0)
 6fc:	2781                	sext.w	a5,a5
 6fe:	fc07dae3          	bgez	a5,6d2 <printint+0xcc>
}
 702:	0001                	nop
 704:	0001                	nop
 706:	70e2                	ld	ra,56(sp)
 708:	7442                	ld	s0,48(sp)
 70a:	6121                	addi	sp,sp,64
 70c:	8082                	ret

000000000000070e <printptr>:

static void
printptr(int fd, uint64 x) {
 70e:	7179                	addi	sp,sp,-48
 710:	f406                	sd	ra,40(sp)
 712:	f022                	sd	s0,32(sp)
 714:	1800                	addi	s0,sp,48
 716:	87aa                	mv	a5,a0
 718:	fcb43823          	sd	a1,-48(s0)
 71c:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 720:	fdc42783          	lw	a5,-36(s0)
 724:	03000593          	li	a1,48
 728:	853e                	mv	a0,a5
 72a:	00000097          	auipc	ra,0x0
 72e:	ea6080e7          	jalr	-346(ra) # 5d0 <putc>
  putc(fd, 'x');
 732:	fdc42783          	lw	a5,-36(s0)
 736:	07800593          	li	a1,120
 73a:	853e                	mv	a0,a5
 73c:	00000097          	auipc	ra,0x0
 740:	e94080e7          	jalr	-364(ra) # 5d0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 744:	fe042623          	sw	zero,-20(s0)
 748:	a82d                	j	782 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 74a:	fd043783          	ld	a5,-48(s0)
 74e:	93f1                	srli	a5,a5,0x3c
 750:	00000717          	auipc	a4,0x0
 754:	7e070713          	addi	a4,a4,2016 # f30 <digits>
 758:	97ba                	add	a5,a5,a4
 75a:	0007c703          	lbu	a4,0(a5)
 75e:	fdc42783          	lw	a5,-36(s0)
 762:	85ba                	mv	a1,a4
 764:	853e                	mv	a0,a5
 766:	00000097          	auipc	ra,0x0
 76a:	e6a080e7          	jalr	-406(ra) # 5d0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 76e:	fec42783          	lw	a5,-20(s0)
 772:	2785                	addiw	a5,a5,1
 774:	fef42623          	sw	a5,-20(s0)
 778:	fd043783          	ld	a5,-48(s0)
 77c:	0792                	slli	a5,a5,0x4
 77e:	fcf43823          	sd	a5,-48(s0)
 782:	fec42783          	lw	a5,-20(s0)
 786:	873e                	mv	a4,a5
 788:	47bd                	li	a5,15
 78a:	fce7f0e3          	bgeu	a5,a4,74a <printptr+0x3c>
}
 78e:	0001                	nop
 790:	0001                	nop
 792:	70a2                	ld	ra,40(sp)
 794:	7402                	ld	s0,32(sp)
 796:	6145                	addi	sp,sp,48
 798:	8082                	ret

000000000000079a <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 79a:	715d                	addi	sp,sp,-80
 79c:	e486                	sd	ra,72(sp)
 79e:	e0a2                	sd	s0,64(sp)
 7a0:	0880                	addi	s0,sp,80
 7a2:	87aa                	mv	a5,a0
 7a4:	fcb43023          	sd	a1,-64(s0)
 7a8:	fac43c23          	sd	a2,-72(s0)
 7ac:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 7b0:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7b4:	fe042223          	sw	zero,-28(s0)
 7b8:	a42d                	j	9e2 <vprintf+0x248>
    c = fmt[i] & 0xff;
 7ba:	fe442783          	lw	a5,-28(s0)
 7be:	fc043703          	ld	a4,-64(s0)
 7c2:	97ba                	add	a5,a5,a4
 7c4:	0007c783          	lbu	a5,0(a5)
 7c8:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7cc:	fe042783          	lw	a5,-32(s0)
 7d0:	2781                	sext.w	a5,a5
 7d2:	eb9d                	bnez	a5,808 <vprintf+0x6e>
      if(c == '%'){
 7d4:	fdc42783          	lw	a5,-36(s0)
 7d8:	0007871b          	sext.w	a4,a5
 7dc:	02500793          	li	a5,37
 7e0:	00f71763          	bne	a4,a5,7ee <vprintf+0x54>
        state = '%';
 7e4:	02500793          	li	a5,37
 7e8:	fef42023          	sw	a5,-32(s0)
 7ec:	a2f5                	j	9d8 <vprintf+0x23e>
      } else {
        putc(fd, c);
 7ee:	fdc42783          	lw	a5,-36(s0)
 7f2:	0ff7f713          	zext.b	a4,a5
 7f6:	fcc42783          	lw	a5,-52(s0)
 7fa:	85ba                	mv	a1,a4
 7fc:	853e                	mv	a0,a5
 7fe:	00000097          	auipc	ra,0x0
 802:	dd2080e7          	jalr	-558(ra) # 5d0 <putc>
 806:	aac9                	j	9d8 <vprintf+0x23e>
      }
    } else if(state == '%'){
 808:	fe042783          	lw	a5,-32(s0)
 80c:	0007871b          	sext.w	a4,a5
 810:	02500793          	li	a5,37
 814:	1cf71263          	bne	a4,a5,9d8 <vprintf+0x23e>
      if(c == 'd'){
 818:	fdc42783          	lw	a5,-36(s0)
 81c:	0007871b          	sext.w	a4,a5
 820:	06400793          	li	a5,100
 824:	02f71463          	bne	a4,a5,84c <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 828:	fb843783          	ld	a5,-72(s0)
 82c:	00878713          	addi	a4,a5,8
 830:	fae43c23          	sd	a4,-72(s0)
 834:	4398                	lw	a4,0(a5)
 836:	fcc42783          	lw	a5,-52(s0)
 83a:	4685                	li	a3,1
 83c:	4629                	li	a2,10
 83e:	85ba                	mv	a1,a4
 840:	853e                	mv	a0,a5
 842:	00000097          	auipc	ra,0x0
 846:	dc4080e7          	jalr	-572(ra) # 606 <printint>
 84a:	a269                	j	9d4 <vprintf+0x23a>
      } else if(c == 'l') {
 84c:	fdc42783          	lw	a5,-36(s0)
 850:	0007871b          	sext.w	a4,a5
 854:	06c00793          	li	a5,108
 858:	02f71663          	bne	a4,a5,884 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 85c:	fb843783          	ld	a5,-72(s0)
 860:	00878713          	addi	a4,a5,8
 864:	fae43c23          	sd	a4,-72(s0)
 868:	639c                	ld	a5,0(a5)
 86a:	0007871b          	sext.w	a4,a5
 86e:	fcc42783          	lw	a5,-52(s0)
 872:	4681                	li	a3,0
 874:	4629                	li	a2,10
 876:	85ba                	mv	a1,a4
 878:	853e                	mv	a0,a5
 87a:	00000097          	auipc	ra,0x0
 87e:	d8c080e7          	jalr	-628(ra) # 606 <printint>
 882:	aa89                	j	9d4 <vprintf+0x23a>
      } else if(c == 'x') {
 884:	fdc42783          	lw	a5,-36(s0)
 888:	0007871b          	sext.w	a4,a5
 88c:	07800793          	li	a5,120
 890:	02f71463          	bne	a4,a5,8b8 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 894:	fb843783          	ld	a5,-72(s0)
 898:	00878713          	addi	a4,a5,8
 89c:	fae43c23          	sd	a4,-72(s0)
 8a0:	4398                	lw	a4,0(a5)
 8a2:	fcc42783          	lw	a5,-52(s0)
 8a6:	4681                	li	a3,0
 8a8:	4641                	li	a2,16
 8aa:	85ba                	mv	a1,a4
 8ac:	853e                	mv	a0,a5
 8ae:	00000097          	auipc	ra,0x0
 8b2:	d58080e7          	jalr	-680(ra) # 606 <printint>
 8b6:	aa39                	j	9d4 <vprintf+0x23a>
      } else if(c == 'p') {
 8b8:	fdc42783          	lw	a5,-36(s0)
 8bc:	0007871b          	sext.w	a4,a5
 8c0:	07000793          	li	a5,112
 8c4:	02f71263          	bne	a4,a5,8e8 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8c8:	fb843783          	ld	a5,-72(s0)
 8cc:	00878713          	addi	a4,a5,8
 8d0:	fae43c23          	sd	a4,-72(s0)
 8d4:	6398                	ld	a4,0(a5)
 8d6:	fcc42783          	lw	a5,-52(s0)
 8da:	85ba                	mv	a1,a4
 8dc:	853e                	mv	a0,a5
 8de:	00000097          	auipc	ra,0x0
 8e2:	e30080e7          	jalr	-464(ra) # 70e <printptr>
 8e6:	a0fd                	j	9d4 <vprintf+0x23a>
      } else if(c == 's'){
 8e8:	fdc42783          	lw	a5,-36(s0)
 8ec:	0007871b          	sext.w	a4,a5
 8f0:	07300793          	li	a5,115
 8f4:	04f71c63          	bne	a4,a5,94c <vprintf+0x1b2>
        s = va_arg(ap, char*);
 8f8:	fb843783          	ld	a5,-72(s0)
 8fc:	00878713          	addi	a4,a5,8
 900:	fae43c23          	sd	a4,-72(s0)
 904:	639c                	ld	a5,0(a5)
 906:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 90a:	fe843783          	ld	a5,-24(s0)
 90e:	eb8d                	bnez	a5,940 <vprintf+0x1a6>
          s = "(null)";
 910:	00000797          	auipc	a5,0x0
 914:	5c878793          	addi	a5,a5,1480 # ed8 <lock_init+0x48>
 918:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 91c:	a015                	j	940 <vprintf+0x1a6>
          putc(fd, *s);
 91e:	fe843783          	ld	a5,-24(s0)
 922:	0007c703          	lbu	a4,0(a5)
 926:	fcc42783          	lw	a5,-52(s0)
 92a:	85ba                	mv	a1,a4
 92c:	853e                	mv	a0,a5
 92e:	00000097          	auipc	ra,0x0
 932:	ca2080e7          	jalr	-862(ra) # 5d0 <putc>
          s++;
 936:	fe843783          	ld	a5,-24(s0)
 93a:	0785                	addi	a5,a5,1
 93c:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 940:	fe843783          	ld	a5,-24(s0)
 944:	0007c783          	lbu	a5,0(a5)
 948:	fbf9                	bnez	a5,91e <vprintf+0x184>
 94a:	a069                	j	9d4 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 94c:	fdc42783          	lw	a5,-36(s0)
 950:	0007871b          	sext.w	a4,a5
 954:	06300793          	li	a5,99
 958:	02f71463          	bne	a4,a5,980 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 95c:	fb843783          	ld	a5,-72(s0)
 960:	00878713          	addi	a4,a5,8
 964:	fae43c23          	sd	a4,-72(s0)
 968:	439c                	lw	a5,0(a5)
 96a:	0ff7f713          	zext.b	a4,a5
 96e:	fcc42783          	lw	a5,-52(s0)
 972:	85ba                	mv	a1,a4
 974:	853e                	mv	a0,a5
 976:	00000097          	auipc	ra,0x0
 97a:	c5a080e7          	jalr	-934(ra) # 5d0 <putc>
 97e:	a899                	j	9d4 <vprintf+0x23a>
      } else if(c == '%'){
 980:	fdc42783          	lw	a5,-36(s0)
 984:	0007871b          	sext.w	a4,a5
 988:	02500793          	li	a5,37
 98c:	00f71f63          	bne	a4,a5,9aa <vprintf+0x210>
        putc(fd, c);
 990:	fdc42783          	lw	a5,-36(s0)
 994:	0ff7f713          	zext.b	a4,a5
 998:	fcc42783          	lw	a5,-52(s0)
 99c:	85ba                	mv	a1,a4
 99e:	853e                	mv	a0,a5
 9a0:	00000097          	auipc	ra,0x0
 9a4:	c30080e7          	jalr	-976(ra) # 5d0 <putc>
 9a8:	a035                	j	9d4 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9aa:	fcc42783          	lw	a5,-52(s0)
 9ae:	02500593          	li	a1,37
 9b2:	853e                	mv	a0,a5
 9b4:	00000097          	auipc	ra,0x0
 9b8:	c1c080e7          	jalr	-996(ra) # 5d0 <putc>
        putc(fd, c);
 9bc:	fdc42783          	lw	a5,-36(s0)
 9c0:	0ff7f713          	zext.b	a4,a5
 9c4:	fcc42783          	lw	a5,-52(s0)
 9c8:	85ba                	mv	a1,a4
 9ca:	853e                	mv	a0,a5
 9cc:	00000097          	auipc	ra,0x0
 9d0:	c04080e7          	jalr	-1020(ra) # 5d0 <putc>
      }
      state = 0;
 9d4:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 9d8:	fe442783          	lw	a5,-28(s0)
 9dc:	2785                	addiw	a5,a5,1
 9de:	fef42223          	sw	a5,-28(s0)
 9e2:	fe442783          	lw	a5,-28(s0)
 9e6:	fc043703          	ld	a4,-64(s0)
 9ea:	97ba                	add	a5,a5,a4
 9ec:	0007c783          	lbu	a5,0(a5)
 9f0:	dc0795e3          	bnez	a5,7ba <vprintf+0x20>
    }
  }
}
 9f4:	0001                	nop
 9f6:	0001                	nop
 9f8:	60a6                	ld	ra,72(sp)
 9fa:	6406                	ld	s0,64(sp)
 9fc:	6161                	addi	sp,sp,80
 9fe:	8082                	ret

0000000000000a00 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a00:	7159                	addi	sp,sp,-112
 a02:	fc06                	sd	ra,56(sp)
 a04:	f822                	sd	s0,48(sp)
 a06:	0080                	addi	s0,sp,64
 a08:	fcb43823          	sd	a1,-48(s0)
 a0c:	e010                	sd	a2,0(s0)
 a0e:	e414                	sd	a3,8(s0)
 a10:	e818                	sd	a4,16(s0)
 a12:	ec1c                	sd	a5,24(s0)
 a14:	03043023          	sd	a6,32(s0)
 a18:	03143423          	sd	a7,40(s0)
 a1c:	87aa                	mv	a5,a0
 a1e:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a22:	03040793          	addi	a5,s0,48
 a26:	fcf43423          	sd	a5,-56(s0)
 a2a:	fc843783          	ld	a5,-56(s0)
 a2e:	fd078793          	addi	a5,a5,-48
 a32:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a36:	fe843703          	ld	a4,-24(s0)
 a3a:	fdc42783          	lw	a5,-36(s0)
 a3e:	863a                	mv	a2,a4
 a40:	fd043583          	ld	a1,-48(s0)
 a44:	853e                	mv	a0,a5
 a46:	00000097          	auipc	ra,0x0
 a4a:	d54080e7          	jalr	-684(ra) # 79a <vprintf>
}
 a4e:	0001                	nop
 a50:	70e2                	ld	ra,56(sp)
 a52:	7442                	ld	s0,48(sp)
 a54:	6165                	addi	sp,sp,112
 a56:	8082                	ret

0000000000000a58 <printf>:

void
printf(const char *fmt, ...)
{
 a58:	7159                	addi	sp,sp,-112
 a5a:	f406                	sd	ra,40(sp)
 a5c:	f022                	sd	s0,32(sp)
 a5e:	1800                	addi	s0,sp,48
 a60:	fca43c23          	sd	a0,-40(s0)
 a64:	e40c                	sd	a1,8(s0)
 a66:	e810                	sd	a2,16(s0)
 a68:	ec14                	sd	a3,24(s0)
 a6a:	f018                	sd	a4,32(s0)
 a6c:	f41c                	sd	a5,40(s0)
 a6e:	03043823          	sd	a6,48(s0)
 a72:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a76:	04040793          	addi	a5,s0,64
 a7a:	fcf43823          	sd	a5,-48(s0)
 a7e:	fd043783          	ld	a5,-48(s0)
 a82:	fc878793          	addi	a5,a5,-56
 a86:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 a8a:	fe843783          	ld	a5,-24(s0)
 a8e:	863e                	mv	a2,a5
 a90:	fd843583          	ld	a1,-40(s0)
 a94:	4505                	li	a0,1
 a96:	00000097          	auipc	ra,0x0
 a9a:	d04080e7          	jalr	-764(ra) # 79a <vprintf>
}
 a9e:	0001                	nop
 aa0:	70a2                	ld	ra,40(sp)
 aa2:	7402                	ld	s0,32(sp)
 aa4:	6165                	addi	sp,sp,112
 aa6:	8082                	ret

0000000000000aa8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 aa8:	7179                	addi	sp,sp,-48
 aaa:	f422                	sd	s0,40(sp)
 aac:	1800                	addi	s0,sp,48
 aae:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ab2:	fd843783          	ld	a5,-40(s0)
 ab6:	17c1                	addi	a5,a5,-16
 ab8:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 abc:	00000797          	auipc	a5,0x0
 ac0:	49c78793          	addi	a5,a5,1180 # f58 <freep>
 ac4:	639c                	ld	a5,0(a5)
 ac6:	fef43423          	sd	a5,-24(s0)
 aca:	a815                	j	afe <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 acc:	fe843783          	ld	a5,-24(s0)
 ad0:	639c                	ld	a5,0(a5)
 ad2:	fe843703          	ld	a4,-24(s0)
 ad6:	00f76f63          	bltu	a4,a5,af4 <free+0x4c>
 ada:	fe043703          	ld	a4,-32(s0)
 ade:	fe843783          	ld	a5,-24(s0)
 ae2:	02e7eb63          	bltu	a5,a4,b18 <free+0x70>
 ae6:	fe843783          	ld	a5,-24(s0)
 aea:	639c                	ld	a5,0(a5)
 aec:	fe043703          	ld	a4,-32(s0)
 af0:	02f76463          	bltu	a4,a5,b18 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af4:	fe843783          	ld	a5,-24(s0)
 af8:	639c                	ld	a5,0(a5)
 afa:	fef43423          	sd	a5,-24(s0)
 afe:	fe043703          	ld	a4,-32(s0)
 b02:	fe843783          	ld	a5,-24(s0)
 b06:	fce7f3e3          	bgeu	a5,a4,acc <free+0x24>
 b0a:	fe843783          	ld	a5,-24(s0)
 b0e:	639c                	ld	a5,0(a5)
 b10:	fe043703          	ld	a4,-32(s0)
 b14:	faf77ce3          	bgeu	a4,a5,acc <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b18:	fe043783          	ld	a5,-32(s0)
 b1c:	479c                	lw	a5,8(a5)
 b1e:	1782                	slli	a5,a5,0x20
 b20:	9381                	srli	a5,a5,0x20
 b22:	0792                	slli	a5,a5,0x4
 b24:	fe043703          	ld	a4,-32(s0)
 b28:	973e                	add	a4,a4,a5
 b2a:	fe843783          	ld	a5,-24(s0)
 b2e:	639c                	ld	a5,0(a5)
 b30:	02f71763          	bne	a4,a5,b5e <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b34:	fe043783          	ld	a5,-32(s0)
 b38:	4798                	lw	a4,8(a5)
 b3a:	fe843783          	ld	a5,-24(s0)
 b3e:	639c                	ld	a5,0(a5)
 b40:	479c                	lw	a5,8(a5)
 b42:	9fb9                	addw	a5,a5,a4
 b44:	0007871b          	sext.w	a4,a5
 b48:	fe043783          	ld	a5,-32(s0)
 b4c:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b4e:	fe843783          	ld	a5,-24(s0)
 b52:	639c                	ld	a5,0(a5)
 b54:	6398                	ld	a4,0(a5)
 b56:	fe043783          	ld	a5,-32(s0)
 b5a:	e398                	sd	a4,0(a5)
 b5c:	a039                	j	b6a <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b5e:	fe843783          	ld	a5,-24(s0)
 b62:	6398                	ld	a4,0(a5)
 b64:	fe043783          	ld	a5,-32(s0)
 b68:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b6a:	fe843783          	ld	a5,-24(s0)
 b6e:	479c                	lw	a5,8(a5)
 b70:	1782                	slli	a5,a5,0x20
 b72:	9381                	srli	a5,a5,0x20
 b74:	0792                	slli	a5,a5,0x4
 b76:	fe843703          	ld	a4,-24(s0)
 b7a:	97ba                	add	a5,a5,a4
 b7c:	fe043703          	ld	a4,-32(s0)
 b80:	02f71563          	bne	a4,a5,baa <free+0x102>
    p->s.size += bp->s.size;
 b84:	fe843783          	ld	a5,-24(s0)
 b88:	4798                	lw	a4,8(a5)
 b8a:	fe043783          	ld	a5,-32(s0)
 b8e:	479c                	lw	a5,8(a5)
 b90:	9fb9                	addw	a5,a5,a4
 b92:	0007871b          	sext.w	a4,a5
 b96:	fe843783          	ld	a5,-24(s0)
 b9a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b9c:	fe043783          	ld	a5,-32(s0)
 ba0:	6398                	ld	a4,0(a5)
 ba2:	fe843783          	ld	a5,-24(s0)
 ba6:	e398                	sd	a4,0(a5)
 ba8:	a031                	j	bb4 <free+0x10c>
  } else
    p->s.ptr = bp;
 baa:	fe843783          	ld	a5,-24(s0)
 bae:	fe043703          	ld	a4,-32(s0)
 bb2:	e398                	sd	a4,0(a5)
  freep = p;
 bb4:	00000797          	auipc	a5,0x0
 bb8:	3a478793          	addi	a5,a5,932 # f58 <freep>
 bbc:	fe843703          	ld	a4,-24(s0)
 bc0:	e398                	sd	a4,0(a5)
}
 bc2:	0001                	nop
 bc4:	7422                	ld	s0,40(sp)
 bc6:	6145                	addi	sp,sp,48
 bc8:	8082                	ret

0000000000000bca <morecore>:

static Header*
morecore(uint nu)
{
 bca:	7179                	addi	sp,sp,-48
 bcc:	f406                	sd	ra,40(sp)
 bce:	f022                	sd	s0,32(sp)
 bd0:	1800                	addi	s0,sp,48
 bd2:	87aa                	mv	a5,a0
 bd4:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 bd8:	fdc42783          	lw	a5,-36(s0)
 bdc:	0007871b          	sext.w	a4,a5
 be0:	6785                	lui	a5,0x1
 be2:	00f77563          	bgeu	a4,a5,bec <morecore+0x22>
    nu = 4096;
 be6:	6785                	lui	a5,0x1
 be8:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 bec:	fdc42783          	lw	a5,-36(s0)
 bf0:	0047979b          	slliw	a5,a5,0x4
 bf4:	2781                	sext.w	a5,a5
 bf6:	2781                	sext.w	a5,a5
 bf8:	853e                	mv	a0,a5
 bfa:	00000097          	auipc	ra,0x0
 bfe:	9ae080e7          	jalr	-1618(ra) # 5a8 <sbrk>
 c02:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c06:	fe843703          	ld	a4,-24(s0)
 c0a:	57fd                	li	a5,-1
 c0c:	00f71463          	bne	a4,a5,c14 <morecore+0x4a>
    return 0;
 c10:	4781                	li	a5,0
 c12:	a03d                	j	c40 <morecore+0x76>
  hp = (Header*)p;
 c14:	fe843783          	ld	a5,-24(s0)
 c18:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c1c:	fe043783          	ld	a5,-32(s0)
 c20:	fdc42703          	lw	a4,-36(s0)
 c24:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c26:	fe043783          	ld	a5,-32(s0)
 c2a:	07c1                	addi	a5,a5,16
 c2c:	853e                	mv	a0,a5
 c2e:	00000097          	auipc	ra,0x0
 c32:	e7a080e7          	jalr	-390(ra) # aa8 <free>
  return freep;
 c36:	00000797          	auipc	a5,0x0
 c3a:	32278793          	addi	a5,a5,802 # f58 <freep>
 c3e:	639c                	ld	a5,0(a5)
}
 c40:	853e                	mv	a0,a5
 c42:	70a2                	ld	ra,40(sp)
 c44:	7402                	ld	s0,32(sp)
 c46:	6145                	addi	sp,sp,48
 c48:	8082                	ret

0000000000000c4a <malloc>:

void*
malloc(uint nbytes)
{
 c4a:	7139                	addi	sp,sp,-64
 c4c:	fc06                	sd	ra,56(sp)
 c4e:	f822                	sd	s0,48(sp)
 c50:	0080                	addi	s0,sp,64
 c52:	87aa                	mv	a5,a0
 c54:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c58:	fcc46783          	lwu	a5,-52(s0)
 c5c:	07bd                	addi	a5,a5,15
 c5e:	8391                	srli	a5,a5,0x4
 c60:	2781                	sext.w	a5,a5
 c62:	2785                	addiw	a5,a5,1
 c64:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c68:	00000797          	auipc	a5,0x0
 c6c:	2f078793          	addi	a5,a5,752 # f58 <freep>
 c70:	639c                	ld	a5,0(a5)
 c72:	fef43023          	sd	a5,-32(s0)
 c76:	fe043783          	ld	a5,-32(s0)
 c7a:	ef95                	bnez	a5,cb6 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c7c:	00000797          	auipc	a5,0x0
 c80:	2cc78793          	addi	a5,a5,716 # f48 <base>
 c84:	fef43023          	sd	a5,-32(s0)
 c88:	00000797          	auipc	a5,0x0
 c8c:	2d078793          	addi	a5,a5,720 # f58 <freep>
 c90:	fe043703          	ld	a4,-32(s0)
 c94:	e398                	sd	a4,0(a5)
 c96:	00000797          	auipc	a5,0x0
 c9a:	2c278793          	addi	a5,a5,706 # f58 <freep>
 c9e:	6398                	ld	a4,0(a5)
 ca0:	00000797          	auipc	a5,0x0
 ca4:	2a878793          	addi	a5,a5,680 # f48 <base>
 ca8:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 caa:	00000797          	auipc	a5,0x0
 cae:	29e78793          	addi	a5,a5,670 # f48 <base>
 cb2:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cb6:	fe043783          	ld	a5,-32(s0)
 cba:	639c                	ld	a5,0(a5)
 cbc:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 cc0:	fe843783          	ld	a5,-24(s0)
 cc4:	4798                	lw	a4,8(a5)
 cc6:	fdc42783          	lw	a5,-36(s0)
 cca:	2781                	sext.w	a5,a5
 ccc:	06f76763          	bltu	a4,a5,d3a <malloc+0xf0>
      if(p->s.size == nunits)
 cd0:	fe843783          	ld	a5,-24(s0)
 cd4:	4798                	lw	a4,8(a5)
 cd6:	fdc42783          	lw	a5,-36(s0)
 cda:	2781                	sext.w	a5,a5
 cdc:	00e79963          	bne	a5,a4,cee <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 ce0:	fe843783          	ld	a5,-24(s0)
 ce4:	6398                	ld	a4,0(a5)
 ce6:	fe043783          	ld	a5,-32(s0)
 cea:	e398                	sd	a4,0(a5)
 cec:	a825                	j	d24 <malloc+0xda>
      else {
        p->s.size -= nunits;
 cee:	fe843783          	ld	a5,-24(s0)
 cf2:	479c                	lw	a5,8(a5)
 cf4:	fdc42703          	lw	a4,-36(s0)
 cf8:	9f99                	subw	a5,a5,a4
 cfa:	0007871b          	sext.w	a4,a5
 cfe:	fe843783          	ld	a5,-24(s0)
 d02:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d04:	fe843783          	ld	a5,-24(s0)
 d08:	479c                	lw	a5,8(a5)
 d0a:	1782                	slli	a5,a5,0x20
 d0c:	9381                	srli	a5,a5,0x20
 d0e:	0792                	slli	a5,a5,0x4
 d10:	fe843703          	ld	a4,-24(s0)
 d14:	97ba                	add	a5,a5,a4
 d16:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d1a:	fe843783          	ld	a5,-24(s0)
 d1e:	fdc42703          	lw	a4,-36(s0)
 d22:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d24:	00000797          	auipc	a5,0x0
 d28:	23478793          	addi	a5,a5,564 # f58 <freep>
 d2c:	fe043703          	ld	a4,-32(s0)
 d30:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d32:	fe843783          	ld	a5,-24(s0)
 d36:	07c1                	addi	a5,a5,16
 d38:	a091                	j	d7c <malloc+0x132>
    }
    if(p == freep)
 d3a:	00000797          	auipc	a5,0x0
 d3e:	21e78793          	addi	a5,a5,542 # f58 <freep>
 d42:	639c                	ld	a5,0(a5)
 d44:	fe843703          	ld	a4,-24(s0)
 d48:	02f71063          	bne	a4,a5,d68 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 d4c:	fdc42783          	lw	a5,-36(s0)
 d50:	853e                	mv	a0,a5
 d52:	00000097          	auipc	ra,0x0
 d56:	e78080e7          	jalr	-392(ra) # bca <morecore>
 d5a:	fea43423          	sd	a0,-24(s0)
 d5e:	fe843783          	ld	a5,-24(s0)
 d62:	e399                	bnez	a5,d68 <malloc+0x11e>
        return 0;
 d64:	4781                	li	a5,0
 d66:	a819                	j	d7c <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d68:	fe843783          	ld	a5,-24(s0)
 d6c:	fef43023          	sd	a5,-32(s0)
 d70:	fe843783          	ld	a5,-24(s0)
 d74:	639c                	ld	a5,0(a5)
 d76:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d7a:	b799                	j	cc0 <malloc+0x76>
  }
}
 d7c:	853e                	mv	a0,a5
 d7e:	70e2                	ld	ra,56(sp)
 d80:	7442                	ld	s0,48(sp)
 d82:	6121                	addi	sp,sp,64
 d84:	8082                	ret

0000000000000d86 <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
 d86:	7179                	addi	sp,sp,-48
 d88:	f406                	sd	ra,40(sp)
 d8a:	f022                	sd	s0,32(sp)
 d8c:	1800                	addi	s0,sp,48
 d8e:	fca43c23          	sd	a0,-40(s0)
 d92:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
 d96:	6505                	lui	a0,0x1
 d98:	00000097          	auipc	ra,0x0
 d9c:	eb2080e7          	jalr	-334(ra) # c4a <malloc>
 da0:	fea43423          	sd	a0,-24(s0)
 da4:	fe843783          	ld	a5,-24(s0)
 da8:	e38d                	bnez	a5,dca <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
 daa:	00000517          	auipc	a0,0x0
 dae:	13650513          	addi	a0,a0,310 # ee0 <lock_init+0x50>
 db2:	00000097          	auipc	ra,0x0
 db6:	ca6080e7          	jalr	-858(ra) # a58 <printf>
        free(stack);
 dba:	fe843503          	ld	a0,-24(s0)
 dbe:	00000097          	auipc	ra,0x0
 dc2:	cea080e7          	jalr	-790(ra) # aa8 <free>
        return -1;
 dc6:	57fd                	li	a5,-1
 dc8:	a099                	j	e0e <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
 dca:	fe843783          	ld	a5,-24(s0)
 dce:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
 dd2:	fe043703          	ld	a4,-32(s0)
 dd6:	6785                	lui	a5,0x1
 dd8:	17fd                	addi	a5,a5,-1
 dda:	8ff9                	and	a5,a5,a4
 ddc:	cf91                	beqz	a5,df8 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
 dde:	fe043703          	ld	a4,-32(s0)
 de2:	6785                	lui	a5,0x1
 de4:	17fd                	addi	a5,a5,-1
 de6:	8ff9                	and	a5,a5,a4
 de8:	6705                	lui	a4,0x1
 dea:	40f707b3          	sub	a5,a4,a5
 dee:	fe843703          	ld	a4,-24(s0)
 df2:	97ba                	add	a5,a5,a4
 df4:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
 df8:	fe843603          	ld	a2,-24(s0)
 dfc:	fd043583          	ld	a1,-48(s0)
 e00:	fd843503          	ld	a0,-40(s0)
 e04:	fffff097          	auipc	ra,0xfffff
 e08:	7bc080e7          	jalr	1980(ra) # 5c0 <clone>
 e0c:	87aa                	mv	a5,a0
}
 e0e:	853e                	mv	a0,a5
 e10:	70a2                	ld	ra,40(sp)
 e12:	7402                	ld	s0,32(sp)
 e14:	6145                	addi	sp,sp,48
 e16:	8082                	ret

0000000000000e18 <thread_join>:


int thread_join()
{
 e18:	1101                	addi	sp,sp,-32
 e1a:	ec06                	sd	ra,24(sp)
 e1c:	e822                	sd	s0,16(sp)
 e1e:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
 e20:	fe040793          	addi	a5,s0,-32
 e24:	853e                	mv	a0,a5
 e26:	fffff097          	auipc	ra,0xfffff
 e2a:	7a2080e7          	jalr	1954(ra) # 5c8 <join>
 e2e:	87aa                	mv	a5,a0
 e30:	fef42623          	sw	a5,-20(s0)
 e34:	fec42783          	lw	a5,-20(s0)
 e38:	0007871b          	sext.w	a4,a5
 e3c:	57fd                	li	a5,-1
 e3e:	00f70963          	beq	a4,a5,e50 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
 e42:	fe043783          	ld	a5,-32(s0)
 e46:	853e                	mv	a0,a5
 e48:	00000097          	auipc	ra,0x0
 e4c:	c60080e7          	jalr	-928(ra) # aa8 <free>
    } 

    return child_tid;
 e50:	fec42783          	lw	a5,-20(s0)
}
 e54:	853e                	mv	a0,a5
 e56:	60e2                	ld	ra,24(sp)
 e58:	6442                	ld	s0,16(sp)
 e5a:	6105                	addi	sp,sp,32
 e5c:	8082                	ret

0000000000000e5e <lock_acquire>:


void lock_acquire (lock_t *lock)
{
 e5e:	1101                	addi	sp,sp,-32
 e60:	ec22                	sd	s0,24(sp)
 e62:	1000                	addi	s0,sp,32
 e64:	fea43423          	sd	a0,-24(s0)
        lock = 0;
 e68:	fe043423          	sd	zero,-24(s0)

}
 e6c:	0001                	nop
 e6e:	6462                	ld	s0,24(sp)
 e70:	6105                	addi	sp,sp,32
 e72:	8082                	ret

0000000000000e74 <lock_release>:

void lock_release (lock_t *lock)
{
 e74:	1101                	addi	sp,sp,-32
 e76:	ec22                	sd	s0,24(sp)
 e78:	1000                	addi	s0,sp,32
 e7a:	fea43423          	sd	a0,-24(s0)
        __sync_lock_test_and_set(lock, 1);
 e7e:	fe843783          	ld	a5,-24(s0)
 e82:	4705                	li	a4,1
 e84:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    
}
 e88:	0001                	nop
 e8a:	6462                	ld	s0,24(sp)
 e8c:	6105                	addi	sp,sp,32
 e8e:	8082                	ret

0000000000000e90 <lock_init>:

void lock_init (lock_t *lock)
{
 e90:	1101                	addi	sp,sp,-32
 e92:	ec22                	sd	s0,24(sp)
 e94:	1000                	addi	s0,sp,32
 e96:	fea43423          	sd	a0,-24(s0)
    lock = 0;
 e9a:	fe043423          	sd	zero,-24(s0)
    
}
 e9e:	0001                	nop
 ea0:	6462                	ld	s0,24(sp)
 ea2:	6105                	addi	sp,sp,32
 ea4:	8082                	ret
