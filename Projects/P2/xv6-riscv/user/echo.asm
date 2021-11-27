
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
  3e:	12e080e7          	jalr	302(ra) # 168 <strlen>
  42:	87aa                	mv	a5,a0
  44:	2781                	sext.w	a5,a5
  46:	2781                	sext.w	a5,a5
  48:	863e                	mv	a2,a5
  4a:	85a6                	mv	a1,s1
  4c:	4505                	li	a0,1
  4e:	00000097          	auipc	ra,0x0
  52:	51a080e7          	jalr	1306(ra) # 568 <write>
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
  70:	d4c58593          	addi	a1,a1,-692 # db8 <malloc+0x140>
  74:	4505                	li	a0,1
  76:	00000097          	auipc	ra,0x0
  7a:	4f2080e7          	jalr	1266(ra) # 568 <write>
  7e:	a819                	j	94 <main+0x94>
    } else {
      write(1, "\n", 1);
  80:	4605                	li	a2,1
  82:	00001597          	auipc	a1,0x1
  86:	d3e58593          	addi	a1,a1,-706 # dc0 <malloc+0x148>
  8a:	4505                	li	a0,1
  8c:	00000097          	auipc	ra,0x0
  90:	4dc080e7          	jalr	1244(ra) # 568 <write>
  for(i = 1; i < argc; i++){
  94:	fdc42783          	lw	a5,-36(s0)
  98:	2785                	addiw	a5,a5,1
  9a:	fcf42e23          	sw	a5,-36(s0)
  9e:	fdc42703          	lw	a4,-36(s0)
  a2:	fcc42783          	lw	a5,-52(s0)
  a6:	2701                	sext.w	a4,a4
  a8:	2781                	sext.w	a5,a5
  aa:	f6f749e3          	blt	a4,a5,1c <main+0x1c>
    }
  }
  exit(0);
  ae:	4501                	li	a0,0
  b0:	00000097          	auipc	ra,0x0
  b4:	498080e7          	jalr	1176(ra) # 548 <exit>

00000000000000b8 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  b8:	7179                	addi	sp,sp,-48
  ba:	f422                	sd	s0,40(sp)
  bc:	1800                	addi	s0,sp,48
  be:	fca43c23          	sd	a0,-40(s0)
  c2:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  c6:	fd843783          	ld	a5,-40(s0)
  ca:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  ce:	0001                	nop
  d0:	fd043703          	ld	a4,-48(s0)
  d4:	00170793          	addi	a5,a4,1
  d8:	fcf43823          	sd	a5,-48(s0)
  dc:	fd843783          	ld	a5,-40(s0)
  e0:	00178693          	addi	a3,a5,1
  e4:	fcd43c23          	sd	a3,-40(s0)
  e8:	00074703          	lbu	a4,0(a4)
  ec:	00e78023          	sb	a4,0(a5)
  f0:	0007c783          	lbu	a5,0(a5)
  f4:	fff1                	bnez	a5,d0 <strcpy+0x18>
    ;
  return os;
  f6:	fe843783          	ld	a5,-24(s0)
}
  fa:	853e                	mv	a0,a5
  fc:	7422                	ld	s0,40(sp)
  fe:	6145                	addi	sp,sp,48
 100:	8082                	ret

0000000000000102 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 102:	1101                	addi	sp,sp,-32
 104:	ec22                	sd	s0,24(sp)
 106:	1000                	addi	s0,sp,32
 108:	fea43423          	sd	a0,-24(s0)
 10c:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 110:	a819                	j	126 <strcmp+0x24>
    p++, q++;
 112:	fe843783          	ld	a5,-24(s0)
 116:	0785                	addi	a5,a5,1
 118:	fef43423          	sd	a5,-24(s0)
 11c:	fe043783          	ld	a5,-32(s0)
 120:	0785                	addi	a5,a5,1
 122:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 126:	fe843783          	ld	a5,-24(s0)
 12a:	0007c783          	lbu	a5,0(a5)
 12e:	cb99                	beqz	a5,144 <strcmp+0x42>
 130:	fe843783          	ld	a5,-24(s0)
 134:	0007c703          	lbu	a4,0(a5)
 138:	fe043783          	ld	a5,-32(s0)
 13c:	0007c783          	lbu	a5,0(a5)
 140:	fcf709e3          	beq	a4,a5,112 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 144:	fe843783          	ld	a5,-24(s0)
 148:	0007c783          	lbu	a5,0(a5)
 14c:	0007871b          	sext.w	a4,a5
 150:	fe043783          	ld	a5,-32(s0)
 154:	0007c783          	lbu	a5,0(a5)
 158:	2781                	sext.w	a5,a5
 15a:	40f707bb          	subw	a5,a4,a5
 15e:	2781                	sext.w	a5,a5
}
 160:	853e                	mv	a0,a5
 162:	6462                	ld	s0,24(sp)
 164:	6105                	addi	sp,sp,32
 166:	8082                	ret

0000000000000168 <strlen>:

uint
strlen(const char *s)
{
 168:	7179                	addi	sp,sp,-48
 16a:	f422                	sd	s0,40(sp)
 16c:	1800                	addi	s0,sp,48
 16e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 172:	fe042623          	sw	zero,-20(s0)
 176:	a031                	j	182 <strlen+0x1a>
 178:	fec42783          	lw	a5,-20(s0)
 17c:	2785                	addiw	a5,a5,1
 17e:	fef42623          	sw	a5,-20(s0)
 182:	fec42783          	lw	a5,-20(s0)
 186:	fd843703          	ld	a4,-40(s0)
 18a:	97ba                	add	a5,a5,a4
 18c:	0007c783          	lbu	a5,0(a5)
 190:	f7e5                	bnez	a5,178 <strlen+0x10>
    ;
  return n;
 192:	fec42783          	lw	a5,-20(s0)
}
 196:	853e                	mv	a0,a5
 198:	7422                	ld	s0,40(sp)
 19a:	6145                	addi	sp,sp,48
 19c:	8082                	ret

000000000000019e <memset>:

void*
memset(void *dst, int c, uint n)
{
 19e:	7179                	addi	sp,sp,-48
 1a0:	f422                	sd	s0,40(sp)
 1a2:	1800                	addi	s0,sp,48
 1a4:	fca43c23          	sd	a0,-40(s0)
 1a8:	87ae                	mv	a5,a1
 1aa:	8732                	mv	a4,a2
 1ac:	fcf42a23          	sw	a5,-44(s0)
 1b0:	87ba                	mv	a5,a4
 1b2:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1b6:	fd843783          	ld	a5,-40(s0)
 1ba:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1be:	fe042623          	sw	zero,-20(s0)
 1c2:	a00d                	j	1e4 <memset+0x46>
    cdst[i] = c;
 1c4:	fec42783          	lw	a5,-20(s0)
 1c8:	fe043703          	ld	a4,-32(s0)
 1cc:	97ba                	add	a5,a5,a4
 1ce:	fd442703          	lw	a4,-44(s0)
 1d2:	0ff77713          	andi	a4,a4,255
 1d6:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1da:	fec42783          	lw	a5,-20(s0)
 1de:	2785                	addiw	a5,a5,1
 1e0:	fef42623          	sw	a5,-20(s0)
 1e4:	fec42703          	lw	a4,-20(s0)
 1e8:	fd042783          	lw	a5,-48(s0)
 1ec:	2781                	sext.w	a5,a5
 1ee:	fcf76be3          	bltu	a4,a5,1c4 <memset+0x26>
  }
  return dst;
 1f2:	fd843783          	ld	a5,-40(s0)
}
 1f6:	853e                	mv	a0,a5
 1f8:	7422                	ld	s0,40(sp)
 1fa:	6145                	addi	sp,sp,48
 1fc:	8082                	ret

00000000000001fe <strchr>:

char*
strchr(const char *s, char c)
{
 1fe:	1101                	addi	sp,sp,-32
 200:	ec22                	sd	s0,24(sp)
 202:	1000                	addi	s0,sp,32
 204:	fea43423          	sd	a0,-24(s0)
 208:	87ae                	mv	a5,a1
 20a:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 20e:	a01d                	j	234 <strchr+0x36>
    if(*s == c)
 210:	fe843783          	ld	a5,-24(s0)
 214:	0007c703          	lbu	a4,0(a5)
 218:	fe744783          	lbu	a5,-25(s0)
 21c:	0ff7f793          	andi	a5,a5,255
 220:	00e79563          	bne	a5,a4,22a <strchr+0x2c>
      return (char*)s;
 224:	fe843783          	ld	a5,-24(s0)
 228:	a821                	j	240 <strchr+0x42>
  for(; *s; s++)
 22a:	fe843783          	ld	a5,-24(s0)
 22e:	0785                	addi	a5,a5,1
 230:	fef43423          	sd	a5,-24(s0)
 234:	fe843783          	ld	a5,-24(s0)
 238:	0007c783          	lbu	a5,0(a5)
 23c:	fbf1                	bnez	a5,210 <strchr+0x12>
  return 0;
 23e:	4781                	li	a5,0
}
 240:	853e                	mv	a0,a5
 242:	6462                	ld	s0,24(sp)
 244:	6105                	addi	sp,sp,32
 246:	8082                	ret

0000000000000248 <gets>:

char*
gets(char *buf, int max)
{
 248:	7179                	addi	sp,sp,-48
 24a:	f406                	sd	ra,40(sp)
 24c:	f022                	sd	s0,32(sp)
 24e:	1800                	addi	s0,sp,48
 250:	fca43c23          	sd	a0,-40(s0)
 254:	87ae                	mv	a5,a1
 256:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 25a:	fe042623          	sw	zero,-20(s0)
 25e:	a8a1                	j	2b6 <gets+0x6e>
    cc = read(0, &c, 1);
 260:	fe740793          	addi	a5,s0,-25
 264:	4605                	li	a2,1
 266:	85be                	mv	a1,a5
 268:	4501                	li	a0,0
 26a:	00000097          	auipc	ra,0x0
 26e:	2f6080e7          	jalr	758(ra) # 560 <read>
 272:	87aa                	mv	a5,a0
 274:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 278:	fe842783          	lw	a5,-24(s0)
 27c:	2781                	sext.w	a5,a5
 27e:	04f05763          	blez	a5,2cc <gets+0x84>
      break;
    buf[i++] = c;
 282:	fec42783          	lw	a5,-20(s0)
 286:	0017871b          	addiw	a4,a5,1
 28a:	fee42623          	sw	a4,-20(s0)
 28e:	873e                	mv	a4,a5
 290:	fd843783          	ld	a5,-40(s0)
 294:	97ba                	add	a5,a5,a4
 296:	fe744703          	lbu	a4,-25(s0)
 29a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 29e:	fe744783          	lbu	a5,-25(s0)
 2a2:	873e                	mv	a4,a5
 2a4:	47a9                	li	a5,10
 2a6:	02f70463          	beq	a4,a5,2ce <gets+0x86>
 2aa:	fe744783          	lbu	a5,-25(s0)
 2ae:	873e                	mv	a4,a5
 2b0:	47b5                	li	a5,13
 2b2:	00f70e63          	beq	a4,a5,2ce <gets+0x86>
  for(i=0; i+1 < max; ){
 2b6:	fec42783          	lw	a5,-20(s0)
 2ba:	2785                	addiw	a5,a5,1
 2bc:	0007871b          	sext.w	a4,a5
 2c0:	fd442783          	lw	a5,-44(s0)
 2c4:	2781                	sext.w	a5,a5
 2c6:	f8f74de3          	blt	a4,a5,260 <gets+0x18>
 2ca:	a011                	j	2ce <gets+0x86>
      break;
 2cc:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2ce:	fec42783          	lw	a5,-20(s0)
 2d2:	fd843703          	ld	a4,-40(s0)
 2d6:	97ba                	add	a5,a5,a4
 2d8:	00078023          	sb	zero,0(a5)
  return buf;
 2dc:	fd843783          	ld	a5,-40(s0)
}
 2e0:	853e                	mv	a0,a5
 2e2:	70a2                	ld	ra,40(sp)
 2e4:	7402                	ld	s0,32(sp)
 2e6:	6145                	addi	sp,sp,48
 2e8:	8082                	ret

00000000000002ea <stat>:

int
stat(const char *n, struct stat *st)
{
 2ea:	7179                	addi	sp,sp,-48
 2ec:	f406                	sd	ra,40(sp)
 2ee:	f022                	sd	s0,32(sp)
 2f0:	1800                	addi	s0,sp,48
 2f2:	fca43c23          	sd	a0,-40(s0)
 2f6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2fa:	4581                	li	a1,0
 2fc:	fd843503          	ld	a0,-40(s0)
 300:	00000097          	auipc	ra,0x0
 304:	288080e7          	jalr	648(ra) # 588 <open>
 308:	87aa                	mv	a5,a0
 30a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 30e:	fec42783          	lw	a5,-20(s0)
 312:	2781                	sext.w	a5,a5
 314:	0007d463          	bgez	a5,31c <stat+0x32>
    return -1;
 318:	57fd                	li	a5,-1
 31a:	a035                	j	346 <stat+0x5c>
  r = fstat(fd, st);
 31c:	fec42783          	lw	a5,-20(s0)
 320:	fd043583          	ld	a1,-48(s0)
 324:	853e                	mv	a0,a5
 326:	00000097          	auipc	ra,0x0
 32a:	27a080e7          	jalr	634(ra) # 5a0 <fstat>
 32e:	87aa                	mv	a5,a0
 330:	fef42423          	sw	a5,-24(s0)
  close(fd);
 334:	fec42783          	lw	a5,-20(s0)
 338:	853e                	mv	a0,a5
 33a:	00000097          	auipc	ra,0x0
 33e:	236080e7          	jalr	566(ra) # 570 <close>
  return r;
 342:	fe842783          	lw	a5,-24(s0)
}
 346:	853e                	mv	a0,a5
 348:	70a2                	ld	ra,40(sp)
 34a:	7402                	ld	s0,32(sp)
 34c:	6145                	addi	sp,sp,48
 34e:	8082                	ret

0000000000000350 <atoi>:

int
atoi(const char *s)
{
 350:	7179                	addi	sp,sp,-48
 352:	f422                	sd	s0,40(sp)
 354:	1800                	addi	s0,sp,48
 356:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 35a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 35e:	a815                	j	392 <atoi+0x42>
    n = n*10 + *s++ - '0';
 360:	fec42703          	lw	a4,-20(s0)
 364:	87ba                	mv	a5,a4
 366:	0027979b          	slliw	a5,a5,0x2
 36a:	9fb9                	addw	a5,a5,a4
 36c:	0017979b          	slliw	a5,a5,0x1
 370:	0007871b          	sext.w	a4,a5
 374:	fd843783          	ld	a5,-40(s0)
 378:	00178693          	addi	a3,a5,1
 37c:	fcd43c23          	sd	a3,-40(s0)
 380:	0007c783          	lbu	a5,0(a5)
 384:	2781                	sext.w	a5,a5
 386:	9fb9                	addw	a5,a5,a4
 388:	2781                	sext.w	a5,a5
 38a:	fd07879b          	addiw	a5,a5,-48
 38e:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 392:	fd843783          	ld	a5,-40(s0)
 396:	0007c783          	lbu	a5,0(a5)
 39a:	873e                	mv	a4,a5
 39c:	02f00793          	li	a5,47
 3a0:	00e7fb63          	bgeu	a5,a4,3b6 <atoi+0x66>
 3a4:	fd843783          	ld	a5,-40(s0)
 3a8:	0007c783          	lbu	a5,0(a5)
 3ac:	873e                	mv	a4,a5
 3ae:	03900793          	li	a5,57
 3b2:	fae7f7e3          	bgeu	a5,a4,360 <atoi+0x10>
  return n;
 3b6:	fec42783          	lw	a5,-20(s0)
}
 3ba:	853e                	mv	a0,a5
 3bc:	7422                	ld	s0,40(sp)
 3be:	6145                	addi	sp,sp,48
 3c0:	8082                	ret

00000000000003c2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3c2:	7139                	addi	sp,sp,-64
 3c4:	fc22                	sd	s0,56(sp)
 3c6:	0080                	addi	s0,sp,64
 3c8:	fca43c23          	sd	a0,-40(s0)
 3cc:	fcb43823          	sd	a1,-48(s0)
 3d0:	87b2                	mv	a5,a2
 3d2:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3d6:	fd843783          	ld	a5,-40(s0)
 3da:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3de:	fd043783          	ld	a5,-48(s0)
 3e2:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3e6:	fe043703          	ld	a4,-32(s0)
 3ea:	fe843783          	ld	a5,-24(s0)
 3ee:	02e7fc63          	bgeu	a5,a4,426 <memmove+0x64>
    while(n-- > 0)
 3f2:	a00d                	j	414 <memmove+0x52>
      *dst++ = *src++;
 3f4:	fe043703          	ld	a4,-32(s0)
 3f8:	00170793          	addi	a5,a4,1
 3fc:	fef43023          	sd	a5,-32(s0)
 400:	fe843783          	ld	a5,-24(s0)
 404:	00178693          	addi	a3,a5,1
 408:	fed43423          	sd	a3,-24(s0)
 40c:	00074703          	lbu	a4,0(a4)
 410:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 414:	fcc42783          	lw	a5,-52(s0)
 418:	fff7871b          	addiw	a4,a5,-1
 41c:	fce42623          	sw	a4,-52(s0)
 420:	fcf04ae3          	bgtz	a5,3f4 <memmove+0x32>
 424:	a891                	j	478 <memmove+0xb6>
  } else {
    dst += n;
 426:	fcc42783          	lw	a5,-52(s0)
 42a:	fe843703          	ld	a4,-24(s0)
 42e:	97ba                	add	a5,a5,a4
 430:	fef43423          	sd	a5,-24(s0)
    src += n;
 434:	fcc42783          	lw	a5,-52(s0)
 438:	fe043703          	ld	a4,-32(s0)
 43c:	97ba                	add	a5,a5,a4
 43e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 442:	a01d                	j	468 <memmove+0xa6>
      *--dst = *--src;
 444:	fe043783          	ld	a5,-32(s0)
 448:	17fd                	addi	a5,a5,-1
 44a:	fef43023          	sd	a5,-32(s0)
 44e:	fe843783          	ld	a5,-24(s0)
 452:	17fd                	addi	a5,a5,-1
 454:	fef43423          	sd	a5,-24(s0)
 458:	fe043783          	ld	a5,-32(s0)
 45c:	0007c703          	lbu	a4,0(a5)
 460:	fe843783          	ld	a5,-24(s0)
 464:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 468:	fcc42783          	lw	a5,-52(s0)
 46c:	fff7871b          	addiw	a4,a5,-1
 470:	fce42623          	sw	a4,-52(s0)
 474:	fcf048e3          	bgtz	a5,444 <memmove+0x82>
  }
  return vdst;
 478:	fd843783          	ld	a5,-40(s0)
}
 47c:	853e                	mv	a0,a5
 47e:	7462                	ld	s0,56(sp)
 480:	6121                	addi	sp,sp,64
 482:	8082                	ret

0000000000000484 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 484:	7139                	addi	sp,sp,-64
 486:	fc22                	sd	s0,56(sp)
 488:	0080                	addi	s0,sp,64
 48a:	fca43c23          	sd	a0,-40(s0)
 48e:	fcb43823          	sd	a1,-48(s0)
 492:	87b2                	mv	a5,a2
 494:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 498:	fd843783          	ld	a5,-40(s0)
 49c:	fef43423          	sd	a5,-24(s0)
 4a0:	fd043783          	ld	a5,-48(s0)
 4a4:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4a8:	a0a1                	j	4f0 <memcmp+0x6c>
    if (*p1 != *p2) {
 4aa:	fe843783          	ld	a5,-24(s0)
 4ae:	0007c703          	lbu	a4,0(a5)
 4b2:	fe043783          	ld	a5,-32(s0)
 4b6:	0007c783          	lbu	a5,0(a5)
 4ba:	02f70163          	beq	a4,a5,4dc <memcmp+0x58>
      return *p1 - *p2;
 4be:	fe843783          	ld	a5,-24(s0)
 4c2:	0007c783          	lbu	a5,0(a5)
 4c6:	0007871b          	sext.w	a4,a5
 4ca:	fe043783          	ld	a5,-32(s0)
 4ce:	0007c783          	lbu	a5,0(a5)
 4d2:	2781                	sext.w	a5,a5
 4d4:	40f707bb          	subw	a5,a4,a5
 4d8:	2781                	sext.w	a5,a5
 4da:	a01d                	j	500 <memcmp+0x7c>
    }
    p1++;
 4dc:	fe843783          	ld	a5,-24(s0)
 4e0:	0785                	addi	a5,a5,1
 4e2:	fef43423          	sd	a5,-24(s0)
    p2++;
 4e6:	fe043783          	ld	a5,-32(s0)
 4ea:	0785                	addi	a5,a5,1
 4ec:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4f0:	fcc42783          	lw	a5,-52(s0)
 4f4:	fff7871b          	addiw	a4,a5,-1
 4f8:	fce42623          	sw	a4,-52(s0)
 4fc:	f7dd                	bnez	a5,4aa <memcmp+0x26>
  }
  return 0;
 4fe:	4781                	li	a5,0
}
 500:	853e                	mv	a0,a5
 502:	7462                	ld	s0,56(sp)
 504:	6121                	addi	sp,sp,64
 506:	8082                	ret

0000000000000508 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 508:	7179                	addi	sp,sp,-48
 50a:	f406                	sd	ra,40(sp)
 50c:	f022                	sd	s0,32(sp)
 50e:	1800                	addi	s0,sp,48
 510:	fea43423          	sd	a0,-24(s0)
 514:	feb43023          	sd	a1,-32(s0)
 518:	87b2                	mv	a5,a2
 51a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 51e:	fdc42783          	lw	a5,-36(s0)
 522:	863e                	mv	a2,a5
 524:	fe043583          	ld	a1,-32(s0)
 528:	fe843503          	ld	a0,-24(s0)
 52c:	00000097          	auipc	ra,0x0
 530:	e96080e7          	jalr	-362(ra) # 3c2 <memmove>
 534:	87aa                	mv	a5,a0
}
 536:	853e                	mv	a0,a5
 538:	70a2                	ld	ra,40(sp)
 53a:	7402                	ld	s0,32(sp)
 53c:	6145                	addi	sp,sp,48
 53e:	8082                	ret

0000000000000540 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 540:	4885                	li	a7,1
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <exit>:
.global exit
exit:
 li a7, SYS_exit
 548:	4889                	li	a7,2
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <wait>:
.global wait
wait:
 li a7, SYS_wait
 550:	488d                	li	a7,3
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 558:	4891                	li	a7,4
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <read>:
.global read
read:
 li a7, SYS_read
 560:	4895                	li	a7,5
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <write>:
.global write
write:
 li a7, SYS_write
 568:	48c1                	li	a7,16
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <close>:
.global close
close:
 li a7, SYS_close
 570:	48d5                	li	a7,21
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <kill>:
.global kill
kill:
 li a7, SYS_kill
 578:	4899                	li	a7,6
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <exec>:
.global exec
exec:
 li a7, SYS_exec
 580:	489d                	li	a7,7
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <open>:
.global open
open:
 li a7, SYS_open
 588:	48bd                	li	a7,15
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 590:	48c5                	li	a7,17
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 598:	48c9                	li	a7,18
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5a0:	48a1                	li	a7,8
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <link>:
.global link
link:
 li a7, SYS_link
 5a8:	48cd                	li	a7,19
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5b0:	48d1                	li	a7,20
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5b8:	48a5                	li	a7,9
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5c0:	48a9                	li	a7,10
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5c8:	48ad                	li	a7,11
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5d0:	48b1                	li	a7,12
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5d8:	48b5                	li	a7,13
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5e0:	48b9                	li	a7,14
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 5e8:	48d9                	li	a7,22
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <setpri>:
.global setpri
setpri:
 li a7, SYS_setpri
 5f0:	48dd                	li	a7,23
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5f8:	1101                	addi	sp,sp,-32
 5fa:	ec06                	sd	ra,24(sp)
 5fc:	e822                	sd	s0,16(sp)
 5fe:	1000                	addi	s0,sp,32
 600:	87aa                	mv	a5,a0
 602:	872e                	mv	a4,a1
 604:	fef42623          	sw	a5,-20(s0)
 608:	87ba                	mv	a5,a4
 60a:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 60e:	feb40713          	addi	a4,s0,-21
 612:	fec42783          	lw	a5,-20(s0)
 616:	4605                	li	a2,1
 618:	85ba                	mv	a1,a4
 61a:	853e                	mv	a0,a5
 61c:	00000097          	auipc	ra,0x0
 620:	f4c080e7          	jalr	-180(ra) # 568 <write>
}
 624:	0001                	nop
 626:	60e2                	ld	ra,24(sp)
 628:	6442                	ld	s0,16(sp)
 62a:	6105                	addi	sp,sp,32
 62c:	8082                	ret

000000000000062e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 62e:	7139                	addi	sp,sp,-64
 630:	fc06                	sd	ra,56(sp)
 632:	f822                	sd	s0,48(sp)
 634:	0080                	addi	s0,sp,64
 636:	87aa                	mv	a5,a0
 638:	8736                	mv	a4,a3
 63a:	fcf42623          	sw	a5,-52(s0)
 63e:	87ae                	mv	a5,a1
 640:	fcf42423          	sw	a5,-56(s0)
 644:	87b2                	mv	a5,a2
 646:	fcf42223          	sw	a5,-60(s0)
 64a:	87ba                	mv	a5,a4
 64c:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 650:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 654:	fc042783          	lw	a5,-64(s0)
 658:	2781                	sext.w	a5,a5
 65a:	c38d                	beqz	a5,67c <printint+0x4e>
 65c:	fc842783          	lw	a5,-56(s0)
 660:	2781                	sext.w	a5,a5
 662:	0007dd63          	bgez	a5,67c <printint+0x4e>
    neg = 1;
 666:	4785                	li	a5,1
 668:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 66c:	fc842783          	lw	a5,-56(s0)
 670:	40f007bb          	negw	a5,a5
 674:	2781                	sext.w	a5,a5
 676:	fef42223          	sw	a5,-28(s0)
 67a:	a029                	j	684 <printint+0x56>
  } else {
    x = xx;
 67c:	fc842783          	lw	a5,-56(s0)
 680:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 684:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 688:	fc442783          	lw	a5,-60(s0)
 68c:	fe442703          	lw	a4,-28(s0)
 690:	02f777bb          	remuw	a5,a4,a5
 694:	0007861b          	sext.w	a2,a5
 698:	fec42783          	lw	a5,-20(s0)
 69c:	0017871b          	addiw	a4,a5,1
 6a0:	fee42623          	sw	a4,-20(s0)
 6a4:	00000697          	auipc	a3,0x0
 6a8:	72c68693          	addi	a3,a3,1836 # dd0 <digits>
 6ac:	02061713          	slli	a4,a2,0x20
 6b0:	9301                	srli	a4,a4,0x20
 6b2:	9736                	add	a4,a4,a3
 6b4:	00074703          	lbu	a4,0(a4)
 6b8:	ff040693          	addi	a3,s0,-16
 6bc:	97b6                	add	a5,a5,a3
 6be:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 6c2:	fc442783          	lw	a5,-60(s0)
 6c6:	fe442703          	lw	a4,-28(s0)
 6ca:	02f757bb          	divuw	a5,a4,a5
 6ce:	fef42223          	sw	a5,-28(s0)
 6d2:	fe442783          	lw	a5,-28(s0)
 6d6:	2781                	sext.w	a5,a5
 6d8:	fbc5                	bnez	a5,688 <printint+0x5a>
  if(neg)
 6da:	fe842783          	lw	a5,-24(s0)
 6de:	2781                	sext.w	a5,a5
 6e0:	cf95                	beqz	a5,71c <printint+0xee>
    buf[i++] = '-';
 6e2:	fec42783          	lw	a5,-20(s0)
 6e6:	0017871b          	addiw	a4,a5,1
 6ea:	fee42623          	sw	a4,-20(s0)
 6ee:	ff040713          	addi	a4,s0,-16
 6f2:	97ba                	add	a5,a5,a4
 6f4:	02d00713          	li	a4,45
 6f8:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6fc:	a005                	j	71c <printint+0xee>
    putc(fd, buf[i]);
 6fe:	fec42783          	lw	a5,-20(s0)
 702:	ff040713          	addi	a4,s0,-16
 706:	97ba                	add	a5,a5,a4
 708:	fe07c703          	lbu	a4,-32(a5)
 70c:	fcc42783          	lw	a5,-52(s0)
 710:	85ba                	mv	a1,a4
 712:	853e                	mv	a0,a5
 714:	00000097          	auipc	ra,0x0
 718:	ee4080e7          	jalr	-284(ra) # 5f8 <putc>
  while(--i >= 0)
 71c:	fec42783          	lw	a5,-20(s0)
 720:	37fd                	addiw	a5,a5,-1
 722:	fef42623          	sw	a5,-20(s0)
 726:	fec42783          	lw	a5,-20(s0)
 72a:	2781                	sext.w	a5,a5
 72c:	fc07d9e3          	bgez	a5,6fe <printint+0xd0>
}
 730:	0001                	nop
 732:	0001                	nop
 734:	70e2                	ld	ra,56(sp)
 736:	7442                	ld	s0,48(sp)
 738:	6121                	addi	sp,sp,64
 73a:	8082                	ret

000000000000073c <printptr>:

static void
printptr(int fd, uint64 x) {
 73c:	7179                	addi	sp,sp,-48
 73e:	f406                	sd	ra,40(sp)
 740:	f022                	sd	s0,32(sp)
 742:	1800                	addi	s0,sp,48
 744:	87aa                	mv	a5,a0
 746:	fcb43823          	sd	a1,-48(s0)
 74a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 74e:	fdc42783          	lw	a5,-36(s0)
 752:	03000593          	li	a1,48
 756:	853e                	mv	a0,a5
 758:	00000097          	auipc	ra,0x0
 75c:	ea0080e7          	jalr	-352(ra) # 5f8 <putc>
  putc(fd, 'x');
 760:	fdc42783          	lw	a5,-36(s0)
 764:	07800593          	li	a1,120
 768:	853e                	mv	a0,a5
 76a:	00000097          	auipc	ra,0x0
 76e:	e8e080e7          	jalr	-370(ra) # 5f8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 772:	fe042623          	sw	zero,-20(s0)
 776:	a82d                	j	7b0 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 778:	fd043783          	ld	a5,-48(s0)
 77c:	93f1                	srli	a5,a5,0x3c
 77e:	00000717          	auipc	a4,0x0
 782:	65270713          	addi	a4,a4,1618 # dd0 <digits>
 786:	97ba                	add	a5,a5,a4
 788:	0007c703          	lbu	a4,0(a5)
 78c:	fdc42783          	lw	a5,-36(s0)
 790:	85ba                	mv	a1,a4
 792:	853e                	mv	a0,a5
 794:	00000097          	auipc	ra,0x0
 798:	e64080e7          	jalr	-412(ra) # 5f8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 79c:	fec42783          	lw	a5,-20(s0)
 7a0:	2785                	addiw	a5,a5,1
 7a2:	fef42623          	sw	a5,-20(s0)
 7a6:	fd043783          	ld	a5,-48(s0)
 7aa:	0792                	slli	a5,a5,0x4
 7ac:	fcf43823          	sd	a5,-48(s0)
 7b0:	fec42783          	lw	a5,-20(s0)
 7b4:	873e                	mv	a4,a5
 7b6:	47bd                	li	a5,15
 7b8:	fce7f0e3          	bgeu	a5,a4,778 <printptr+0x3c>
}
 7bc:	0001                	nop
 7be:	0001                	nop
 7c0:	70a2                	ld	ra,40(sp)
 7c2:	7402                	ld	s0,32(sp)
 7c4:	6145                	addi	sp,sp,48
 7c6:	8082                	ret

00000000000007c8 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7c8:	715d                	addi	sp,sp,-80
 7ca:	e486                	sd	ra,72(sp)
 7cc:	e0a2                	sd	s0,64(sp)
 7ce:	0880                	addi	s0,sp,80
 7d0:	87aa                	mv	a5,a0
 7d2:	fcb43023          	sd	a1,-64(s0)
 7d6:	fac43c23          	sd	a2,-72(s0)
 7da:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 7de:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7e2:	fe042223          	sw	zero,-28(s0)
 7e6:	a42d                	j	a10 <vprintf+0x248>
    c = fmt[i] & 0xff;
 7e8:	fe442783          	lw	a5,-28(s0)
 7ec:	fc043703          	ld	a4,-64(s0)
 7f0:	97ba                	add	a5,a5,a4
 7f2:	0007c783          	lbu	a5,0(a5)
 7f6:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7fa:	fe042783          	lw	a5,-32(s0)
 7fe:	2781                	sext.w	a5,a5
 800:	eb9d                	bnez	a5,836 <vprintf+0x6e>
      if(c == '%'){
 802:	fdc42783          	lw	a5,-36(s0)
 806:	0007871b          	sext.w	a4,a5
 80a:	02500793          	li	a5,37
 80e:	00f71763          	bne	a4,a5,81c <vprintf+0x54>
        state = '%';
 812:	02500793          	li	a5,37
 816:	fef42023          	sw	a5,-32(s0)
 81a:	a2f5                	j	a06 <vprintf+0x23e>
      } else {
        putc(fd, c);
 81c:	fdc42783          	lw	a5,-36(s0)
 820:	0ff7f713          	andi	a4,a5,255
 824:	fcc42783          	lw	a5,-52(s0)
 828:	85ba                	mv	a1,a4
 82a:	853e                	mv	a0,a5
 82c:	00000097          	auipc	ra,0x0
 830:	dcc080e7          	jalr	-564(ra) # 5f8 <putc>
 834:	aac9                	j	a06 <vprintf+0x23e>
      }
    } else if(state == '%'){
 836:	fe042783          	lw	a5,-32(s0)
 83a:	0007871b          	sext.w	a4,a5
 83e:	02500793          	li	a5,37
 842:	1cf71263          	bne	a4,a5,a06 <vprintf+0x23e>
      if(c == 'd'){
 846:	fdc42783          	lw	a5,-36(s0)
 84a:	0007871b          	sext.w	a4,a5
 84e:	06400793          	li	a5,100
 852:	02f71463          	bne	a4,a5,87a <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 856:	fb843783          	ld	a5,-72(s0)
 85a:	00878713          	addi	a4,a5,8
 85e:	fae43c23          	sd	a4,-72(s0)
 862:	4398                	lw	a4,0(a5)
 864:	fcc42783          	lw	a5,-52(s0)
 868:	4685                	li	a3,1
 86a:	4629                	li	a2,10
 86c:	85ba                	mv	a1,a4
 86e:	853e                	mv	a0,a5
 870:	00000097          	auipc	ra,0x0
 874:	dbe080e7          	jalr	-578(ra) # 62e <printint>
 878:	a269                	j	a02 <vprintf+0x23a>
      } else if(c == 'l') {
 87a:	fdc42783          	lw	a5,-36(s0)
 87e:	0007871b          	sext.w	a4,a5
 882:	06c00793          	li	a5,108
 886:	02f71663          	bne	a4,a5,8b2 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 88a:	fb843783          	ld	a5,-72(s0)
 88e:	00878713          	addi	a4,a5,8
 892:	fae43c23          	sd	a4,-72(s0)
 896:	639c                	ld	a5,0(a5)
 898:	0007871b          	sext.w	a4,a5
 89c:	fcc42783          	lw	a5,-52(s0)
 8a0:	4681                	li	a3,0
 8a2:	4629                	li	a2,10
 8a4:	85ba                	mv	a1,a4
 8a6:	853e                	mv	a0,a5
 8a8:	00000097          	auipc	ra,0x0
 8ac:	d86080e7          	jalr	-634(ra) # 62e <printint>
 8b0:	aa89                	j	a02 <vprintf+0x23a>
      } else if(c == 'x') {
 8b2:	fdc42783          	lw	a5,-36(s0)
 8b6:	0007871b          	sext.w	a4,a5
 8ba:	07800793          	li	a5,120
 8be:	02f71463          	bne	a4,a5,8e6 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 8c2:	fb843783          	ld	a5,-72(s0)
 8c6:	00878713          	addi	a4,a5,8
 8ca:	fae43c23          	sd	a4,-72(s0)
 8ce:	4398                	lw	a4,0(a5)
 8d0:	fcc42783          	lw	a5,-52(s0)
 8d4:	4681                	li	a3,0
 8d6:	4641                	li	a2,16
 8d8:	85ba                	mv	a1,a4
 8da:	853e                	mv	a0,a5
 8dc:	00000097          	auipc	ra,0x0
 8e0:	d52080e7          	jalr	-686(ra) # 62e <printint>
 8e4:	aa39                	j	a02 <vprintf+0x23a>
      } else if(c == 'p') {
 8e6:	fdc42783          	lw	a5,-36(s0)
 8ea:	0007871b          	sext.w	a4,a5
 8ee:	07000793          	li	a5,112
 8f2:	02f71263          	bne	a4,a5,916 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8f6:	fb843783          	ld	a5,-72(s0)
 8fa:	00878713          	addi	a4,a5,8
 8fe:	fae43c23          	sd	a4,-72(s0)
 902:	6398                	ld	a4,0(a5)
 904:	fcc42783          	lw	a5,-52(s0)
 908:	85ba                	mv	a1,a4
 90a:	853e                	mv	a0,a5
 90c:	00000097          	auipc	ra,0x0
 910:	e30080e7          	jalr	-464(ra) # 73c <printptr>
 914:	a0fd                	j	a02 <vprintf+0x23a>
      } else if(c == 's'){
 916:	fdc42783          	lw	a5,-36(s0)
 91a:	0007871b          	sext.w	a4,a5
 91e:	07300793          	li	a5,115
 922:	04f71c63          	bne	a4,a5,97a <vprintf+0x1b2>
        s = va_arg(ap, char*);
 926:	fb843783          	ld	a5,-72(s0)
 92a:	00878713          	addi	a4,a5,8
 92e:	fae43c23          	sd	a4,-72(s0)
 932:	639c                	ld	a5,0(a5)
 934:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 938:	fe843783          	ld	a5,-24(s0)
 93c:	eb8d                	bnez	a5,96e <vprintf+0x1a6>
          s = "(null)";
 93e:	00000797          	auipc	a5,0x0
 942:	48a78793          	addi	a5,a5,1162 # dc8 <malloc+0x150>
 946:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 94a:	a015                	j	96e <vprintf+0x1a6>
          putc(fd, *s);
 94c:	fe843783          	ld	a5,-24(s0)
 950:	0007c703          	lbu	a4,0(a5)
 954:	fcc42783          	lw	a5,-52(s0)
 958:	85ba                	mv	a1,a4
 95a:	853e                	mv	a0,a5
 95c:	00000097          	auipc	ra,0x0
 960:	c9c080e7          	jalr	-868(ra) # 5f8 <putc>
          s++;
 964:	fe843783          	ld	a5,-24(s0)
 968:	0785                	addi	a5,a5,1
 96a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 96e:	fe843783          	ld	a5,-24(s0)
 972:	0007c783          	lbu	a5,0(a5)
 976:	fbf9                	bnez	a5,94c <vprintf+0x184>
 978:	a069                	j	a02 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 97a:	fdc42783          	lw	a5,-36(s0)
 97e:	0007871b          	sext.w	a4,a5
 982:	06300793          	li	a5,99
 986:	02f71463          	bne	a4,a5,9ae <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 98a:	fb843783          	ld	a5,-72(s0)
 98e:	00878713          	addi	a4,a5,8
 992:	fae43c23          	sd	a4,-72(s0)
 996:	439c                	lw	a5,0(a5)
 998:	0ff7f713          	andi	a4,a5,255
 99c:	fcc42783          	lw	a5,-52(s0)
 9a0:	85ba                	mv	a1,a4
 9a2:	853e                	mv	a0,a5
 9a4:	00000097          	auipc	ra,0x0
 9a8:	c54080e7          	jalr	-940(ra) # 5f8 <putc>
 9ac:	a899                	j	a02 <vprintf+0x23a>
      } else if(c == '%'){
 9ae:	fdc42783          	lw	a5,-36(s0)
 9b2:	0007871b          	sext.w	a4,a5
 9b6:	02500793          	li	a5,37
 9ba:	00f71f63          	bne	a4,a5,9d8 <vprintf+0x210>
        putc(fd, c);
 9be:	fdc42783          	lw	a5,-36(s0)
 9c2:	0ff7f713          	andi	a4,a5,255
 9c6:	fcc42783          	lw	a5,-52(s0)
 9ca:	85ba                	mv	a1,a4
 9cc:	853e                	mv	a0,a5
 9ce:	00000097          	auipc	ra,0x0
 9d2:	c2a080e7          	jalr	-982(ra) # 5f8 <putc>
 9d6:	a035                	j	a02 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9d8:	fcc42783          	lw	a5,-52(s0)
 9dc:	02500593          	li	a1,37
 9e0:	853e                	mv	a0,a5
 9e2:	00000097          	auipc	ra,0x0
 9e6:	c16080e7          	jalr	-1002(ra) # 5f8 <putc>
        putc(fd, c);
 9ea:	fdc42783          	lw	a5,-36(s0)
 9ee:	0ff7f713          	andi	a4,a5,255
 9f2:	fcc42783          	lw	a5,-52(s0)
 9f6:	85ba                	mv	a1,a4
 9f8:	853e                	mv	a0,a5
 9fa:	00000097          	auipc	ra,0x0
 9fe:	bfe080e7          	jalr	-1026(ra) # 5f8 <putc>
      }
      state = 0;
 a02:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 a06:	fe442783          	lw	a5,-28(s0)
 a0a:	2785                	addiw	a5,a5,1
 a0c:	fef42223          	sw	a5,-28(s0)
 a10:	fe442783          	lw	a5,-28(s0)
 a14:	fc043703          	ld	a4,-64(s0)
 a18:	97ba                	add	a5,a5,a4
 a1a:	0007c783          	lbu	a5,0(a5)
 a1e:	dc0795e3          	bnez	a5,7e8 <vprintf+0x20>
    }
  }
}
 a22:	0001                	nop
 a24:	0001                	nop
 a26:	60a6                	ld	ra,72(sp)
 a28:	6406                	ld	s0,64(sp)
 a2a:	6161                	addi	sp,sp,80
 a2c:	8082                	ret

0000000000000a2e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a2e:	7159                	addi	sp,sp,-112
 a30:	fc06                	sd	ra,56(sp)
 a32:	f822                	sd	s0,48(sp)
 a34:	0080                	addi	s0,sp,64
 a36:	fcb43823          	sd	a1,-48(s0)
 a3a:	e010                	sd	a2,0(s0)
 a3c:	e414                	sd	a3,8(s0)
 a3e:	e818                	sd	a4,16(s0)
 a40:	ec1c                	sd	a5,24(s0)
 a42:	03043023          	sd	a6,32(s0)
 a46:	03143423          	sd	a7,40(s0)
 a4a:	87aa                	mv	a5,a0
 a4c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a50:	03040793          	addi	a5,s0,48
 a54:	fcf43423          	sd	a5,-56(s0)
 a58:	fc843783          	ld	a5,-56(s0)
 a5c:	fd078793          	addi	a5,a5,-48
 a60:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a64:	fe843703          	ld	a4,-24(s0)
 a68:	fdc42783          	lw	a5,-36(s0)
 a6c:	863a                	mv	a2,a4
 a6e:	fd043583          	ld	a1,-48(s0)
 a72:	853e                	mv	a0,a5
 a74:	00000097          	auipc	ra,0x0
 a78:	d54080e7          	jalr	-684(ra) # 7c8 <vprintf>
}
 a7c:	0001                	nop
 a7e:	70e2                	ld	ra,56(sp)
 a80:	7442                	ld	s0,48(sp)
 a82:	6165                	addi	sp,sp,112
 a84:	8082                	ret

0000000000000a86 <printf>:

void
printf(const char *fmt, ...)
{
 a86:	7159                	addi	sp,sp,-112
 a88:	f406                	sd	ra,40(sp)
 a8a:	f022                	sd	s0,32(sp)
 a8c:	1800                	addi	s0,sp,48
 a8e:	fca43c23          	sd	a0,-40(s0)
 a92:	e40c                	sd	a1,8(s0)
 a94:	e810                	sd	a2,16(s0)
 a96:	ec14                	sd	a3,24(s0)
 a98:	f018                	sd	a4,32(s0)
 a9a:	f41c                	sd	a5,40(s0)
 a9c:	03043823          	sd	a6,48(s0)
 aa0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 aa4:	04040793          	addi	a5,s0,64
 aa8:	fcf43823          	sd	a5,-48(s0)
 aac:	fd043783          	ld	a5,-48(s0)
 ab0:	fc878793          	addi	a5,a5,-56
 ab4:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 ab8:	fe843783          	ld	a5,-24(s0)
 abc:	863e                	mv	a2,a5
 abe:	fd843583          	ld	a1,-40(s0)
 ac2:	4505                	li	a0,1
 ac4:	00000097          	auipc	ra,0x0
 ac8:	d04080e7          	jalr	-764(ra) # 7c8 <vprintf>
}
 acc:	0001                	nop
 ace:	70a2                	ld	ra,40(sp)
 ad0:	7402                	ld	s0,32(sp)
 ad2:	6165                	addi	sp,sp,112
 ad4:	8082                	ret

0000000000000ad6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ad6:	7179                	addi	sp,sp,-48
 ad8:	f422                	sd	s0,40(sp)
 ada:	1800                	addi	s0,sp,48
 adc:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ae0:	fd843783          	ld	a5,-40(s0)
 ae4:	17c1                	addi	a5,a5,-16
 ae6:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aea:	00000797          	auipc	a5,0x0
 aee:	30e78793          	addi	a5,a5,782 # df8 <freep>
 af2:	639c                	ld	a5,0(a5)
 af4:	fef43423          	sd	a5,-24(s0)
 af8:	a815                	j	b2c <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 afa:	fe843783          	ld	a5,-24(s0)
 afe:	639c                	ld	a5,0(a5)
 b00:	fe843703          	ld	a4,-24(s0)
 b04:	00f76f63          	bltu	a4,a5,b22 <free+0x4c>
 b08:	fe043703          	ld	a4,-32(s0)
 b0c:	fe843783          	ld	a5,-24(s0)
 b10:	02e7eb63          	bltu	a5,a4,b46 <free+0x70>
 b14:	fe843783          	ld	a5,-24(s0)
 b18:	639c                	ld	a5,0(a5)
 b1a:	fe043703          	ld	a4,-32(s0)
 b1e:	02f76463          	bltu	a4,a5,b46 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b22:	fe843783          	ld	a5,-24(s0)
 b26:	639c                	ld	a5,0(a5)
 b28:	fef43423          	sd	a5,-24(s0)
 b2c:	fe043703          	ld	a4,-32(s0)
 b30:	fe843783          	ld	a5,-24(s0)
 b34:	fce7f3e3          	bgeu	a5,a4,afa <free+0x24>
 b38:	fe843783          	ld	a5,-24(s0)
 b3c:	639c                	ld	a5,0(a5)
 b3e:	fe043703          	ld	a4,-32(s0)
 b42:	faf77ce3          	bgeu	a4,a5,afa <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b46:	fe043783          	ld	a5,-32(s0)
 b4a:	479c                	lw	a5,8(a5)
 b4c:	1782                	slli	a5,a5,0x20
 b4e:	9381                	srli	a5,a5,0x20
 b50:	0792                	slli	a5,a5,0x4
 b52:	fe043703          	ld	a4,-32(s0)
 b56:	973e                	add	a4,a4,a5
 b58:	fe843783          	ld	a5,-24(s0)
 b5c:	639c                	ld	a5,0(a5)
 b5e:	02f71763          	bne	a4,a5,b8c <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b62:	fe043783          	ld	a5,-32(s0)
 b66:	4798                	lw	a4,8(a5)
 b68:	fe843783          	ld	a5,-24(s0)
 b6c:	639c                	ld	a5,0(a5)
 b6e:	479c                	lw	a5,8(a5)
 b70:	9fb9                	addw	a5,a5,a4
 b72:	0007871b          	sext.w	a4,a5
 b76:	fe043783          	ld	a5,-32(s0)
 b7a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b7c:	fe843783          	ld	a5,-24(s0)
 b80:	639c                	ld	a5,0(a5)
 b82:	6398                	ld	a4,0(a5)
 b84:	fe043783          	ld	a5,-32(s0)
 b88:	e398                	sd	a4,0(a5)
 b8a:	a039                	j	b98 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b8c:	fe843783          	ld	a5,-24(s0)
 b90:	6398                	ld	a4,0(a5)
 b92:	fe043783          	ld	a5,-32(s0)
 b96:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b98:	fe843783          	ld	a5,-24(s0)
 b9c:	479c                	lw	a5,8(a5)
 b9e:	1782                	slli	a5,a5,0x20
 ba0:	9381                	srli	a5,a5,0x20
 ba2:	0792                	slli	a5,a5,0x4
 ba4:	fe843703          	ld	a4,-24(s0)
 ba8:	97ba                	add	a5,a5,a4
 baa:	fe043703          	ld	a4,-32(s0)
 bae:	02f71563          	bne	a4,a5,bd8 <free+0x102>
    p->s.size += bp->s.size;
 bb2:	fe843783          	ld	a5,-24(s0)
 bb6:	4798                	lw	a4,8(a5)
 bb8:	fe043783          	ld	a5,-32(s0)
 bbc:	479c                	lw	a5,8(a5)
 bbe:	9fb9                	addw	a5,a5,a4
 bc0:	0007871b          	sext.w	a4,a5
 bc4:	fe843783          	ld	a5,-24(s0)
 bc8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bca:	fe043783          	ld	a5,-32(s0)
 bce:	6398                	ld	a4,0(a5)
 bd0:	fe843783          	ld	a5,-24(s0)
 bd4:	e398                	sd	a4,0(a5)
 bd6:	a031                	j	be2 <free+0x10c>
  } else
    p->s.ptr = bp;
 bd8:	fe843783          	ld	a5,-24(s0)
 bdc:	fe043703          	ld	a4,-32(s0)
 be0:	e398                	sd	a4,0(a5)
  freep = p;
 be2:	00000797          	auipc	a5,0x0
 be6:	21678793          	addi	a5,a5,534 # df8 <freep>
 bea:	fe843703          	ld	a4,-24(s0)
 bee:	e398                	sd	a4,0(a5)
}
 bf0:	0001                	nop
 bf2:	7422                	ld	s0,40(sp)
 bf4:	6145                	addi	sp,sp,48
 bf6:	8082                	ret

0000000000000bf8 <morecore>:

static Header*
morecore(uint nu)
{
 bf8:	7179                	addi	sp,sp,-48
 bfa:	f406                	sd	ra,40(sp)
 bfc:	f022                	sd	s0,32(sp)
 bfe:	1800                	addi	s0,sp,48
 c00:	87aa                	mv	a5,a0
 c02:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 c06:	fdc42783          	lw	a5,-36(s0)
 c0a:	0007871b          	sext.w	a4,a5
 c0e:	6785                	lui	a5,0x1
 c10:	00f77563          	bgeu	a4,a5,c1a <morecore+0x22>
    nu = 4096;
 c14:	6785                	lui	a5,0x1
 c16:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c1a:	fdc42783          	lw	a5,-36(s0)
 c1e:	0047979b          	slliw	a5,a5,0x4
 c22:	2781                	sext.w	a5,a5
 c24:	2781                	sext.w	a5,a5
 c26:	853e                	mv	a0,a5
 c28:	00000097          	auipc	ra,0x0
 c2c:	9a8080e7          	jalr	-1624(ra) # 5d0 <sbrk>
 c30:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c34:	fe843703          	ld	a4,-24(s0)
 c38:	57fd                	li	a5,-1
 c3a:	00f71463          	bne	a4,a5,c42 <morecore+0x4a>
    return 0;
 c3e:	4781                	li	a5,0
 c40:	a03d                	j	c6e <morecore+0x76>
  hp = (Header*)p;
 c42:	fe843783          	ld	a5,-24(s0)
 c46:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c4a:	fe043783          	ld	a5,-32(s0)
 c4e:	fdc42703          	lw	a4,-36(s0)
 c52:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c54:	fe043783          	ld	a5,-32(s0)
 c58:	07c1                	addi	a5,a5,16
 c5a:	853e                	mv	a0,a5
 c5c:	00000097          	auipc	ra,0x0
 c60:	e7a080e7          	jalr	-390(ra) # ad6 <free>
  return freep;
 c64:	00000797          	auipc	a5,0x0
 c68:	19478793          	addi	a5,a5,404 # df8 <freep>
 c6c:	639c                	ld	a5,0(a5)
}
 c6e:	853e                	mv	a0,a5
 c70:	70a2                	ld	ra,40(sp)
 c72:	7402                	ld	s0,32(sp)
 c74:	6145                	addi	sp,sp,48
 c76:	8082                	ret

0000000000000c78 <malloc>:

void*
malloc(uint nbytes)
{
 c78:	7139                	addi	sp,sp,-64
 c7a:	fc06                	sd	ra,56(sp)
 c7c:	f822                	sd	s0,48(sp)
 c7e:	0080                	addi	s0,sp,64
 c80:	87aa                	mv	a5,a0
 c82:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c86:	fcc46783          	lwu	a5,-52(s0)
 c8a:	07bd                	addi	a5,a5,15
 c8c:	8391                	srli	a5,a5,0x4
 c8e:	2781                	sext.w	a5,a5
 c90:	2785                	addiw	a5,a5,1
 c92:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c96:	00000797          	auipc	a5,0x0
 c9a:	16278793          	addi	a5,a5,354 # df8 <freep>
 c9e:	639c                	ld	a5,0(a5)
 ca0:	fef43023          	sd	a5,-32(s0)
 ca4:	fe043783          	ld	a5,-32(s0)
 ca8:	ef95                	bnez	a5,ce4 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 caa:	00000797          	auipc	a5,0x0
 cae:	13e78793          	addi	a5,a5,318 # de8 <base>
 cb2:	fef43023          	sd	a5,-32(s0)
 cb6:	00000797          	auipc	a5,0x0
 cba:	14278793          	addi	a5,a5,322 # df8 <freep>
 cbe:	fe043703          	ld	a4,-32(s0)
 cc2:	e398                	sd	a4,0(a5)
 cc4:	00000797          	auipc	a5,0x0
 cc8:	13478793          	addi	a5,a5,308 # df8 <freep>
 ccc:	6398                	ld	a4,0(a5)
 cce:	00000797          	auipc	a5,0x0
 cd2:	11a78793          	addi	a5,a5,282 # de8 <base>
 cd6:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 cd8:	00000797          	auipc	a5,0x0
 cdc:	11078793          	addi	a5,a5,272 # de8 <base>
 ce0:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ce4:	fe043783          	ld	a5,-32(s0)
 ce8:	639c                	ld	a5,0(a5)
 cea:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 cee:	fe843783          	ld	a5,-24(s0)
 cf2:	4798                	lw	a4,8(a5)
 cf4:	fdc42783          	lw	a5,-36(s0)
 cf8:	2781                	sext.w	a5,a5
 cfa:	06f76863          	bltu	a4,a5,d6a <malloc+0xf2>
      if(p->s.size == nunits)
 cfe:	fe843783          	ld	a5,-24(s0)
 d02:	4798                	lw	a4,8(a5)
 d04:	fdc42783          	lw	a5,-36(s0)
 d08:	2781                	sext.w	a5,a5
 d0a:	00e79963          	bne	a5,a4,d1c <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d0e:	fe843783          	ld	a5,-24(s0)
 d12:	6398                	ld	a4,0(a5)
 d14:	fe043783          	ld	a5,-32(s0)
 d18:	e398                	sd	a4,0(a5)
 d1a:	a82d                	j	d54 <malloc+0xdc>
      else {
        p->s.size -= nunits;
 d1c:	fe843783          	ld	a5,-24(s0)
 d20:	4798                	lw	a4,8(a5)
 d22:	fdc42783          	lw	a5,-36(s0)
 d26:	40f707bb          	subw	a5,a4,a5
 d2a:	0007871b          	sext.w	a4,a5
 d2e:	fe843783          	ld	a5,-24(s0)
 d32:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d34:	fe843783          	ld	a5,-24(s0)
 d38:	479c                	lw	a5,8(a5)
 d3a:	1782                	slli	a5,a5,0x20
 d3c:	9381                	srli	a5,a5,0x20
 d3e:	0792                	slli	a5,a5,0x4
 d40:	fe843703          	ld	a4,-24(s0)
 d44:	97ba                	add	a5,a5,a4
 d46:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d4a:	fe843783          	ld	a5,-24(s0)
 d4e:	fdc42703          	lw	a4,-36(s0)
 d52:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d54:	00000797          	auipc	a5,0x0
 d58:	0a478793          	addi	a5,a5,164 # df8 <freep>
 d5c:	fe043703          	ld	a4,-32(s0)
 d60:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d62:	fe843783          	ld	a5,-24(s0)
 d66:	07c1                	addi	a5,a5,16
 d68:	a091                	j	dac <malloc+0x134>
    }
    if(p == freep)
 d6a:	00000797          	auipc	a5,0x0
 d6e:	08e78793          	addi	a5,a5,142 # df8 <freep>
 d72:	639c                	ld	a5,0(a5)
 d74:	fe843703          	ld	a4,-24(s0)
 d78:	02f71063          	bne	a4,a5,d98 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 d7c:	fdc42783          	lw	a5,-36(s0)
 d80:	853e                	mv	a0,a5
 d82:	00000097          	auipc	ra,0x0
 d86:	e76080e7          	jalr	-394(ra) # bf8 <morecore>
 d8a:	fea43423          	sd	a0,-24(s0)
 d8e:	fe843783          	ld	a5,-24(s0)
 d92:	e399                	bnez	a5,d98 <malloc+0x120>
        return 0;
 d94:	4781                	li	a5,0
 d96:	a819                	j	dac <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d98:	fe843783          	ld	a5,-24(s0)
 d9c:	fef43023          	sd	a5,-32(s0)
 da0:	fe843783          	ld	a5,-24(s0)
 da4:	639c                	ld	a5,0(a5)
 da6:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 daa:	b791                	j	cee <malloc+0x76>
  }
}
 dac:	853e                	mv	a0,a5
 dae:	70e2                	ld	ra,56(sp)
 db0:	7442                	ld	s0,48(sp)
 db2:	6121                	addi	sp,sp,64
 db4:	8082                	ret
