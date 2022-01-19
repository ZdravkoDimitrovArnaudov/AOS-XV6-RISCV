
user/_mkdir:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
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
    fprintf(2, "Usage: mkdir files...\n");
  20:	00001597          	auipc	a1,0x1
  24:	ea858593          	addi	a1,a1,-344 # ec8 <lock_init+0x1a>
  28:	4509                	li	a0,2
  2a:	00001097          	auipc	ra,0x1
  2e:	9f4080e7          	jalr	-1548(ra) # a1e <fprintf>
    exit(1);
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	50a080e7          	jalr	1290(ra) # 53e <exit>
  }

  for(i = 1; i < argc; i++){
  3c:	4785                	li	a5,1
  3e:	fef42623          	sw	a5,-20(s0)
  42:	a0b9                	j	90 <main+0x90>
    if(mkdir(argv[i]) < 0){
  44:	fec42783          	lw	a5,-20(s0)
  48:	078e                	slli	a5,a5,0x3
  4a:	fd043703          	ld	a4,-48(s0)
  4e:	97ba                	add	a5,a5,a4
  50:	639c                	ld	a5,0(a5)
  52:	853e                	mv	a0,a5
  54:	00000097          	auipc	ra,0x0
  58:	552080e7          	jalr	1362(ra) # 5a6 <mkdir>
  5c:	87aa                	mv	a5,a0
  5e:	0207d463          	bgez	a5,86 <main+0x86>
      fprintf(2, "mkdir: %s failed to create\n", argv[i]);
  62:	fec42783          	lw	a5,-20(s0)
  66:	078e                	slli	a5,a5,0x3
  68:	fd043703          	ld	a4,-48(s0)
  6c:	97ba                	add	a5,a5,a4
  6e:	639c                	ld	a5,0(a5)
  70:	863e                	mv	a2,a5
  72:	00001597          	auipc	a1,0x1
  76:	e6e58593          	addi	a1,a1,-402 # ee0 <lock_init+0x32>
  7a:	4509                	li	a0,2
  7c:	00001097          	auipc	ra,0x1
  80:	9a2080e7          	jalr	-1630(ra) # a1e <fprintf>
      break;
  84:	a839                	j	a2 <main+0xa2>
  for(i = 1; i < argc; i++){
  86:	fec42783          	lw	a5,-20(s0)
  8a:	2785                	addiw	a5,a5,1
  8c:	fef42623          	sw	a5,-20(s0)
  90:	fec42783          	lw	a5,-20(s0)
  94:	873e                	mv	a4,a5
  96:	fdc42783          	lw	a5,-36(s0)
  9a:	2701                	sext.w	a4,a4
  9c:	2781                	sext.w	a5,a5
  9e:	faf743e3          	blt	a4,a5,44 <main+0x44>
    }
  }

  exit(0);
  a2:	4501                	li	a0,0
  a4:	00000097          	auipc	ra,0x0
  a8:	49a080e7          	jalr	1178(ra) # 53e <exit>

00000000000000ac <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  ac:	7179                	addi	sp,sp,-48
  ae:	f422                	sd	s0,40(sp)
  b0:	1800                	addi	s0,sp,48
  b2:	fca43c23          	sd	a0,-40(s0)
  b6:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  ba:	fd843783          	ld	a5,-40(s0)
  be:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  c2:	0001                	nop
  c4:	fd043703          	ld	a4,-48(s0)
  c8:	00170793          	addi	a5,a4,1
  cc:	fcf43823          	sd	a5,-48(s0)
  d0:	fd843783          	ld	a5,-40(s0)
  d4:	00178693          	addi	a3,a5,1
  d8:	fcd43c23          	sd	a3,-40(s0)
  dc:	00074703          	lbu	a4,0(a4)
  e0:	00e78023          	sb	a4,0(a5)
  e4:	0007c783          	lbu	a5,0(a5)
  e8:	fff1                	bnez	a5,c4 <strcpy+0x18>
    ;
  return os;
  ea:	fe843783          	ld	a5,-24(s0)
}
  ee:	853e                	mv	a0,a5
  f0:	7422                	ld	s0,40(sp)
  f2:	6145                	addi	sp,sp,48
  f4:	8082                	ret

00000000000000f6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f6:	1101                	addi	sp,sp,-32
  f8:	ec22                	sd	s0,24(sp)
  fa:	1000                	addi	s0,sp,32
  fc:	fea43423          	sd	a0,-24(s0)
 100:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 104:	a819                	j	11a <strcmp+0x24>
    p++, q++;
 106:	fe843783          	ld	a5,-24(s0)
 10a:	0785                	addi	a5,a5,1
 10c:	fef43423          	sd	a5,-24(s0)
 110:	fe043783          	ld	a5,-32(s0)
 114:	0785                	addi	a5,a5,1
 116:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 11a:	fe843783          	ld	a5,-24(s0)
 11e:	0007c783          	lbu	a5,0(a5)
 122:	cb99                	beqz	a5,138 <strcmp+0x42>
 124:	fe843783          	ld	a5,-24(s0)
 128:	0007c703          	lbu	a4,0(a5)
 12c:	fe043783          	ld	a5,-32(s0)
 130:	0007c783          	lbu	a5,0(a5)
 134:	fcf709e3          	beq	a4,a5,106 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 138:	fe843783          	ld	a5,-24(s0)
 13c:	0007c783          	lbu	a5,0(a5)
 140:	0007871b          	sext.w	a4,a5
 144:	fe043783          	ld	a5,-32(s0)
 148:	0007c783          	lbu	a5,0(a5)
 14c:	2781                	sext.w	a5,a5
 14e:	40f707bb          	subw	a5,a4,a5
 152:	2781                	sext.w	a5,a5
}
 154:	853e                	mv	a0,a5
 156:	6462                	ld	s0,24(sp)
 158:	6105                	addi	sp,sp,32
 15a:	8082                	ret

000000000000015c <strlen>:

uint
strlen(const char *s)
{
 15c:	7179                	addi	sp,sp,-48
 15e:	f422                	sd	s0,40(sp)
 160:	1800                	addi	s0,sp,48
 162:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 166:	fe042623          	sw	zero,-20(s0)
 16a:	a031                	j	176 <strlen+0x1a>
 16c:	fec42783          	lw	a5,-20(s0)
 170:	2785                	addiw	a5,a5,1
 172:	fef42623          	sw	a5,-20(s0)
 176:	fec42783          	lw	a5,-20(s0)
 17a:	fd843703          	ld	a4,-40(s0)
 17e:	97ba                	add	a5,a5,a4
 180:	0007c783          	lbu	a5,0(a5)
 184:	f7e5                	bnez	a5,16c <strlen+0x10>
    ;
  return n;
 186:	fec42783          	lw	a5,-20(s0)
}
 18a:	853e                	mv	a0,a5
 18c:	7422                	ld	s0,40(sp)
 18e:	6145                	addi	sp,sp,48
 190:	8082                	ret

0000000000000192 <memset>:

void*
memset(void *dst, int c, uint n)
{
 192:	7179                	addi	sp,sp,-48
 194:	f422                	sd	s0,40(sp)
 196:	1800                	addi	s0,sp,48
 198:	fca43c23          	sd	a0,-40(s0)
 19c:	87ae                	mv	a5,a1
 19e:	8732                	mv	a4,a2
 1a0:	fcf42a23          	sw	a5,-44(s0)
 1a4:	87ba                	mv	a5,a4
 1a6:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1aa:	fd843783          	ld	a5,-40(s0)
 1ae:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1b2:	fe042623          	sw	zero,-20(s0)
 1b6:	a00d                	j	1d8 <memset+0x46>
    cdst[i] = c;
 1b8:	fec42783          	lw	a5,-20(s0)
 1bc:	fe043703          	ld	a4,-32(s0)
 1c0:	97ba                	add	a5,a5,a4
 1c2:	fd442703          	lw	a4,-44(s0)
 1c6:	0ff77713          	zext.b	a4,a4
 1ca:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1ce:	fec42783          	lw	a5,-20(s0)
 1d2:	2785                	addiw	a5,a5,1
 1d4:	fef42623          	sw	a5,-20(s0)
 1d8:	fec42703          	lw	a4,-20(s0)
 1dc:	fd042783          	lw	a5,-48(s0)
 1e0:	2781                	sext.w	a5,a5
 1e2:	fcf76be3          	bltu	a4,a5,1b8 <memset+0x26>
  }
  return dst;
 1e6:	fd843783          	ld	a5,-40(s0)
}
 1ea:	853e                	mv	a0,a5
 1ec:	7422                	ld	s0,40(sp)
 1ee:	6145                	addi	sp,sp,48
 1f0:	8082                	ret

00000000000001f2 <strchr>:

char*
strchr(const char *s, char c)
{
 1f2:	1101                	addi	sp,sp,-32
 1f4:	ec22                	sd	s0,24(sp)
 1f6:	1000                	addi	s0,sp,32
 1f8:	fea43423          	sd	a0,-24(s0)
 1fc:	87ae                	mv	a5,a1
 1fe:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 202:	a01d                	j	228 <strchr+0x36>
    if(*s == c)
 204:	fe843783          	ld	a5,-24(s0)
 208:	0007c703          	lbu	a4,0(a5)
 20c:	fe744783          	lbu	a5,-25(s0)
 210:	0ff7f793          	zext.b	a5,a5
 214:	00e79563          	bne	a5,a4,21e <strchr+0x2c>
      return (char*)s;
 218:	fe843783          	ld	a5,-24(s0)
 21c:	a821                	j	234 <strchr+0x42>
  for(; *s; s++)
 21e:	fe843783          	ld	a5,-24(s0)
 222:	0785                	addi	a5,a5,1
 224:	fef43423          	sd	a5,-24(s0)
 228:	fe843783          	ld	a5,-24(s0)
 22c:	0007c783          	lbu	a5,0(a5)
 230:	fbf1                	bnez	a5,204 <strchr+0x12>
  return 0;
 232:	4781                	li	a5,0
}
 234:	853e                	mv	a0,a5
 236:	6462                	ld	s0,24(sp)
 238:	6105                	addi	sp,sp,32
 23a:	8082                	ret

000000000000023c <gets>:

char*
gets(char *buf, int max)
{
 23c:	7179                	addi	sp,sp,-48
 23e:	f406                	sd	ra,40(sp)
 240:	f022                	sd	s0,32(sp)
 242:	1800                	addi	s0,sp,48
 244:	fca43c23          	sd	a0,-40(s0)
 248:	87ae                	mv	a5,a1
 24a:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 24e:	fe042623          	sw	zero,-20(s0)
 252:	a8a1                	j	2aa <gets+0x6e>
    cc = read(0, &c, 1);
 254:	fe740793          	addi	a5,s0,-25
 258:	4605                	li	a2,1
 25a:	85be                	mv	a1,a5
 25c:	4501                	li	a0,0
 25e:	00000097          	auipc	ra,0x0
 262:	2f8080e7          	jalr	760(ra) # 556 <read>
 266:	87aa                	mv	a5,a0
 268:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 26c:	fe842783          	lw	a5,-24(s0)
 270:	2781                	sext.w	a5,a5
 272:	04f05763          	blez	a5,2c0 <gets+0x84>
      break;
    buf[i++] = c;
 276:	fec42783          	lw	a5,-20(s0)
 27a:	0017871b          	addiw	a4,a5,1
 27e:	fee42623          	sw	a4,-20(s0)
 282:	873e                	mv	a4,a5
 284:	fd843783          	ld	a5,-40(s0)
 288:	97ba                	add	a5,a5,a4
 28a:	fe744703          	lbu	a4,-25(s0)
 28e:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 292:	fe744783          	lbu	a5,-25(s0)
 296:	873e                	mv	a4,a5
 298:	47a9                	li	a5,10
 29a:	02f70463          	beq	a4,a5,2c2 <gets+0x86>
 29e:	fe744783          	lbu	a5,-25(s0)
 2a2:	873e                	mv	a4,a5
 2a4:	47b5                	li	a5,13
 2a6:	00f70e63          	beq	a4,a5,2c2 <gets+0x86>
  for(i=0; i+1 < max; ){
 2aa:	fec42783          	lw	a5,-20(s0)
 2ae:	2785                	addiw	a5,a5,1
 2b0:	0007871b          	sext.w	a4,a5
 2b4:	fd442783          	lw	a5,-44(s0)
 2b8:	2781                	sext.w	a5,a5
 2ba:	f8f74de3          	blt	a4,a5,254 <gets+0x18>
 2be:	a011                	j	2c2 <gets+0x86>
      break;
 2c0:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2c2:	fec42783          	lw	a5,-20(s0)
 2c6:	fd843703          	ld	a4,-40(s0)
 2ca:	97ba                	add	a5,a5,a4
 2cc:	00078023          	sb	zero,0(a5)
  return buf;
 2d0:	fd843783          	ld	a5,-40(s0)
}
 2d4:	853e                	mv	a0,a5
 2d6:	70a2                	ld	ra,40(sp)
 2d8:	7402                	ld	s0,32(sp)
 2da:	6145                	addi	sp,sp,48
 2dc:	8082                	ret

00000000000002de <stat>:

int
stat(const char *n, struct stat *st)
{
 2de:	7179                	addi	sp,sp,-48
 2e0:	f406                	sd	ra,40(sp)
 2e2:	f022                	sd	s0,32(sp)
 2e4:	1800                	addi	s0,sp,48
 2e6:	fca43c23          	sd	a0,-40(s0)
 2ea:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ee:	4581                	li	a1,0
 2f0:	fd843503          	ld	a0,-40(s0)
 2f4:	00000097          	auipc	ra,0x0
 2f8:	28a080e7          	jalr	650(ra) # 57e <open>
 2fc:	87aa                	mv	a5,a0
 2fe:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 302:	fec42783          	lw	a5,-20(s0)
 306:	2781                	sext.w	a5,a5
 308:	0007d463          	bgez	a5,310 <stat+0x32>
    return -1;
 30c:	57fd                	li	a5,-1
 30e:	a035                	j	33a <stat+0x5c>
  r = fstat(fd, st);
 310:	fec42783          	lw	a5,-20(s0)
 314:	fd043583          	ld	a1,-48(s0)
 318:	853e                	mv	a0,a5
 31a:	00000097          	auipc	ra,0x0
 31e:	27c080e7          	jalr	636(ra) # 596 <fstat>
 322:	87aa                	mv	a5,a0
 324:	fef42423          	sw	a5,-24(s0)
  close(fd);
 328:	fec42783          	lw	a5,-20(s0)
 32c:	853e                	mv	a0,a5
 32e:	00000097          	auipc	ra,0x0
 332:	238080e7          	jalr	568(ra) # 566 <close>
  return r;
 336:	fe842783          	lw	a5,-24(s0)
}
 33a:	853e                	mv	a0,a5
 33c:	70a2                	ld	ra,40(sp)
 33e:	7402                	ld	s0,32(sp)
 340:	6145                	addi	sp,sp,48
 342:	8082                	ret

0000000000000344 <atoi>:

int
atoi(const char *s)
{
 344:	7179                	addi	sp,sp,-48
 346:	f422                	sd	s0,40(sp)
 348:	1800                	addi	s0,sp,48
 34a:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 34e:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 352:	a81d                	j	388 <atoi+0x44>
    n = n*10 + *s++ - '0';
 354:	fec42783          	lw	a5,-20(s0)
 358:	873e                	mv	a4,a5
 35a:	87ba                	mv	a5,a4
 35c:	0027979b          	slliw	a5,a5,0x2
 360:	9fb9                	addw	a5,a5,a4
 362:	0017979b          	slliw	a5,a5,0x1
 366:	0007871b          	sext.w	a4,a5
 36a:	fd843783          	ld	a5,-40(s0)
 36e:	00178693          	addi	a3,a5,1
 372:	fcd43c23          	sd	a3,-40(s0)
 376:	0007c783          	lbu	a5,0(a5)
 37a:	2781                	sext.w	a5,a5
 37c:	9fb9                	addw	a5,a5,a4
 37e:	2781                	sext.w	a5,a5
 380:	fd07879b          	addiw	a5,a5,-48
 384:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 388:	fd843783          	ld	a5,-40(s0)
 38c:	0007c783          	lbu	a5,0(a5)
 390:	873e                	mv	a4,a5
 392:	02f00793          	li	a5,47
 396:	00e7fb63          	bgeu	a5,a4,3ac <atoi+0x68>
 39a:	fd843783          	ld	a5,-40(s0)
 39e:	0007c783          	lbu	a5,0(a5)
 3a2:	873e                	mv	a4,a5
 3a4:	03900793          	li	a5,57
 3a8:	fae7f6e3          	bgeu	a5,a4,354 <atoi+0x10>
  return n;
 3ac:	fec42783          	lw	a5,-20(s0)
}
 3b0:	853e                	mv	a0,a5
 3b2:	7422                	ld	s0,40(sp)
 3b4:	6145                	addi	sp,sp,48
 3b6:	8082                	ret

00000000000003b8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b8:	7139                	addi	sp,sp,-64
 3ba:	fc22                	sd	s0,56(sp)
 3bc:	0080                	addi	s0,sp,64
 3be:	fca43c23          	sd	a0,-40(s0)
 3c2:	fcb43823          	sd	a1,-48(s0)
 3c6:	87b2                	mv	a5,a2
 3c8:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3cc:	fd843783          	ld	a5,-40(s0)
 3d0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3d4:	fd043783          	ld	a5,-48(s0)
 3d8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3dc:	fe043703          	ld	a4,-32(s0)
 3e0:	fe843783          	ld	a5,-24(s0)
 3e4:	02e7fc63          	bgeu	a5,a4,41c <memmove+0x64>
    while(n-- > 0)
 3e8:	a00d                	j	40a <memmove+0x52>
      *dst++ = *src++;
 3ea:	fe043703          	ld	a4,-32(s0)
 3ee:	00170793          	addi	a5,a4,1
 3f2:	fef43023          	sd	a5,-32(s0)
 3f6:	fe843783          	ld	a5,-24(s0)
 3fa:	00178693          	addi	a3,a5,1
 3fe:	fed43423          	sd	a3,-24(s0)
 402:	00074703          	lbu	a4,0(a4)
 406:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 40a:	fcc42783          	lw	a5,-52(s0)
 40e:	fff7871b          	addiw	a4,a5,-1
 412:	fce42623          	sw	a4,-52(s0)
 416:	fcf04ae3          	bgtz	a5,3ea <memmove+0x32>
 41a:	a891                	j	46e <memmove+0xb6>
  } else {
    dst += n;
 41c:	fcc42783          	lw	a5,-52(s0)
 420:	fe843703          	ld	a4,-24(s0)
 424:	97ba                	add	a5,a5,a4
 426:	fef43423          	sd	a5,-24(s0)
    src += n;
 42a:	fcc42783          	lw	a5,-52(s0)
 42e:	fe043703          	ld	a4,-32(s0)
 432:	97ba                	add	a5,a5,a4
 434:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 438:	a01d                	j	45e <memmove+0xa6>
      *--dst = *--src;
 43a:	fe043783          	ld	a5,-32(s0)
 43e:	17fd                	addi	a5,a5,-1
 440:	fef43023          	sd	a5,-32(s0)
 444:	fe843783          	ld	a5,-24(s0)
 448:	17fd                	addi	a5,a5,-1
 44a:	fef43423          	sd	a5,-24(s0)
 44e:	fe043783          	ld	a5,-32(s0)
 452:	0007c703          	lbu	a4,0(a5)
 456:	fe843783          	ld	a5,-24(s0)
 45a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 45e:	fcc42783          	lw	a5,-52(s0)
 462:	fff7871b          	addiw	a4,a5,-1
 466:	fce42623          	sw	a4,-52(s0)
 46a:	fcf048e3          	bgtz	a5,43a <memmove+0x82>
  }
  return vdst;
 46e:	fd843783          	ld	a5,-40(s0)
}
 472:	853e                	mv	a0,a5
 474:	7462                	ld	s0,56(sp)
 476:	6121                	addi	sp,sp,64
 478:	8082                	ret

000000000000047a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 47a:	7139                	addi	sp,sp,-64
 47c:	fc22                	sd	s0,56(sp)
 47e:	0080                	addi	s0,sp,64
 480:	fca43c23          	sd	a0,-40(s0)
 484:	fcb43823          	sd	a1,-48(s0)
 488:	87b2                	mv	a5,a2
 48a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 48e:	fd843783          	ld	a5,-40(s0)
 492:	fef43423          	sd	a5,-24(s0)
 496:	fd043783          	ld	a5,-48(s0)
 49a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 49e:	a0a1                	j	4e6 <memcmp+0x6c>
    if (*p1 != *p2) {
 4a0:	fe843783          	ld	a5,-24(s0)
 4a4:	0007c703          	lbu	a4,0(a5)
 4a8:	fe043783          	ld	a5,-32(s0)
 4ac:	0007c783          	lbu	a5,0(a5)
 4b0:	02f70163          	beq	a4,a5,4d2 <memcmp+0x58>
      return *p1 - *p2;
 4b4:	fe843783          	ld	a5,-24(s0)
 4b8:	0007c783          	lbu	a5,0(a5)
 4bc:	0007871b          	sext.w	a4,a5
 4c0:	fe043783          	ld	a5,-32(s0)
 4c4:	0007c783          	lbu	a5,0(a5)
 4c8:	2781                	sext.w	a5,a5
 4ca:	40f707bb          	subw	a5,a4,a5
 4ce:	2781                	sext.w	a5,a5
 4d0:	a01d                	j	4f6 <memcmp+0x7c>
    }
    p1++;
 4d2:	fe843783          	ld	a5,-24(s0)
 4d6:	0785                	addi	a5,a5,1
 4d8:	fef43423          	sd	a5,-24(s0)
    p2++;
 4dc:	fe043783          	ld	a5,-32(s0)
 4e0:	0785                	addi	a5,a5,1
 4e2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4e6:	fcc42783          	lw	a5,-52(s0)
 4ea:	fff7871b          	addiw	a4,a5,-1
 4ee:	fce42623          	sw	a4,-52(s0)
 4f2:	f7dd                	bnez	a5,4a0 <memcmp+0x26>
  }
  return 0;
 4f4:	4781                	li	a5,0
}
 4f6:	853e                	mv	a0,a5
 4f8:	7462                	ld	s0,56(sp)
 4fa:	6121                	addi	sp,sp,64
 4fc:	8082                	ret

00000000000004fe <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4fe:	7179                	addi	sp,sp,-48
 500:	f406                	sd	ra,40(sp)
 502:	f022                	sd	s0,32(sp)
 504:	1800                	addi	s0,sp,48
 506:	fea43423          	sd	a0,-24(s0)
 50a:	feb43023          	sd	a1,-32(s0)
 50e:	87b2                	mv	a5,a2
 510:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 514:	fdc42783          	lw	a5,-36(s0)
 518:	863e                	mv	a2,a5
 51a:	fe043583          	ld	a1,-32(s0)
 51e:	fe843503          	ld	a0,-24(s0)
 522:	00000097          	auipc	ra,0x0
 526:	e96080e7          	jalr	-362(ra) # 3b8 <memmove>
 52a:	87aa                	mv	a5,a0
}
 52c:	853e                	mv	a0,a5
 52e:	70a2                	ld	ra,40(sp)
 530:	7402                	ld	s0,32(sp)
 532:	6145                	addi	sp,sp,48
 534:	8082                	ret

0000000000000536 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 536:	4885                	li	a7,1
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <exit>:
.global exit
exit:
 li a7, SYS_exit
 53e:	4889                	li	a7,2
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <wait>:
.global wait
wait:
 li a7, SYS_wait
 546:	488d                	li	a7,3
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 54e:	4891                	li	a7,4
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <read>:
.global read
read:
 li a7, SYS_read
 556:	4895                	li	a7,5
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <write>:
.global write
write:
 li a7, SYS_write
 55e:	48c1                	li	a7,16
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <close>:
.global close
close:
 li a7, SYS_close
 566:	48d5                	li	a7,21
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <kill>:
.global kill
kill:
 li a7, SYS_kill
 56e:	4899                	li	a7,6
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <exec>:
.global exec
exec:
 li a7, SYS_exec
 576:	489d                	li	a7,7
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <open>:
.global open
open:
 li a7, SYS_open
 57e:	48bd                	li	a7,15
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 586:	48c5                	li	a7,17
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 58e:	48c9                	li	a7,18
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 596:	48a1                	li	a7,8
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <link>:
.global link
link:
 li a7, SYS_link
 59e:	48cd                	li	a7,19
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5a6:	48d1                	li	a7,20
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5ae:	48a5                	li	a7,9
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5b6:	48a9                	li	a7,10
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5be:	48ad                	li	a7,11
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5c6:	48b1                	li	a7,12
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5ce:	48b5                	li	a7,13
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5d6:	48b9                	li	a7,14
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <clone>:
.global clone
clone:
 li a7, SYS_clone
 5de:	48d9                	li	a7,22
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <join>:
.global join
join:
 li a7, SYS_join
 5e6:	48dd                	li	a7,23
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5ee:	1101                	addi	sp,sp,-32
 5f0:	ec06                	sd	ra,24(sp)
 5f2:	e822                	sd	s0,16(sp)
 5f4:	1000                	addi	s0,sp,32
 5f6:	87aa                	mv	a5,a0
 5f8:	872e                	mv	a4,a1
 5fa:	fef42623          	sw	a5,-20(s0)
 5fe:	87ba                	mv	a5,a4
 600:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 604:	feb40713          	addi	a4,s0,-21
 608:	fec42783          	lw	a5,-20(s0)
 60c:	4605                	li	a2,1
 60e:	85ba                	mv	a1,a4
 610:	853e                	mv	a0,a5
 612:	00000097          	auipc	ra,0x0
 616:	f4c080e7          	jalr	-180(ra) # 55e <write>
}
 61a:	0001                	nop
 61c:	60e2                	ld	ra,24(sp)
 61e:	6442                	ld	s0,16(sp)
 620:	6105                	addi	sp,sp,32
 622:	8082                	ret

0000000000000624 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 624:	7139                	addi	sp,sp,-64
 626:	fc06                	sd	ra,56(sp)
 628:	f822                	sd	s0,48(sp)
 62a:	0080                	addi	s0,sp,64
 62c:	87aa                	mv	a5,a0
 62e:	8736                	mv	a4,a3
 630:	fcf42623          	sw	a5,-52(s0)
 634:	87ae                	mv	a5,a1
 636:	fcf42423          	sw	a5,-56(s0)
 63a:	87b2                	mv	a5,a2
 63c:	fcf42223          	sw	a5,-60(s0)
 640:	87ba                	mv	a5,a4
 642:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 646:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 64a:	fc042783          	lw	a5,-64(s0)
 64e:	2781                	sext.w	a5,a5
 650:	c38d                	beqz	a5,672 <printint+0x4e>
 652:	fc842783          	lw	a5,-56(s0)
 656:	2781                	sext.w	a5,a5
 658:	0007dd63          	bgez	a5,672 <printint+0x4e>
    neg = 1;
 65c:	4785                	li	a5,1
 65e:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 662:	fc842783          	lw	a5,-56(s0)
 666:	40f007bb          	negw	a5,a5
 66a:	2781                	sext.w	a5,a5
 66c:	fef42223          	sw	a5,-28(s0)
 670:	a029                	j	67a <printint+0x56>
  } else {
    x = xx;
 672:	fc842783          	lw	a5,-56(s0)
 676:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 67a:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 67e:	fc442783          	lw	a5,-60(s0)
 682:	fe442703          	lw	a4,-28(s0)
 686:	02f777bb          	remuw	a5,a4,a5
 68a:	0007861b          	sext.w	a2,a5
 68e:	fec42783          	lw	a5,-20(s0)
 692:	0017871b          	addiw	a4,a5,1
 696:	fee42623          	sw	a4,-20(s0)
 69a:	00001697          	auipc	a3,0x1
 69e:	8be68693          	addi	a3,a3,-1858 # f58 <digits>
 6a2:	02061713          	slli	a4,a2,0x20
 6a6:	9301                	srli	a4,a4,0x20
 6a8:	9736                	add	a4,a4,a3
 6aa:	00074703          	lbu	a4,0(a4)
 6ae:	17c1                	addi	a5,a5,-16
 6b0:	97a2                	add	a5,a5,s0
 6b2:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 6b6:	fc442783          	lw	a5,-60(s0)
 6ba:	fe442703          	lw	a4,-28(s0)
 6be:	02f757bb          	divuw	a5,a4,a5
 6c2:	fef42223          	sw	a5,-28(s0)
 6c6:	fe442783          	lw	a5,-28(s0)
 6ca:	2781                	sext.w	a5,a5
 6cc:	fbcd                	bnez	a5,67e <printint+0x5a>
  if(neg)
 6ce:	fe842783          	lw	a5,-24(s0)
 6d2:	2781                	sext.w	a5,a5
 6d4:	cf85                	beqz	a5,70c <printint+0xe8>
    buf[i++] = '-';
 6d6:	fec42783          	lw	a5,-20(s0)
 6da:	0017871b          	addiw	a4,a5,1
 6de:	fee42623          	sw	a4,-20(s0)
 6e2:	17c1                	addi	a5,a5,-16
 6e4:	97a2                	add	a5,a5,s0
 6e6:	02d00713          	li	a4,45
 6ea:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6ee:	a839                	j	70c <printint+0xe8>
    putc(fd, buf[i]);
 6f0:	fec42783          	lw	a5,-20(s0)
 6f4:	17c1                	addi	a5,a5,-16
 6f6:	97a2                	add	a5,a5,s0
 6f8:	fe07c703          	lbu	a4,-32(a5)
 6fc:	fcc42783          	lw	a5,-52(s0)
 700:	85ba                	mv	a1,a4
 702:	853e                	mv	a0,a5
 704:	00000097          	auipc	ra,0x0
 708:	eea080e7          	jalr	-278(ra) # 5ee <putc>
  while(--i >= 0)
 70c:	fec42783          	lw	a5,-20(s0)
 710:	37fd                	addiw	a5,a5,-1
 712:	fef42623          	sw	a5,-20(s0)
 716:	fec42783          	lw	a5,-20(s0)
 71a:	2781                	sext.w	a5,a5
 71c:	fc07dae3          	bgez	a5,6f0 <printint+0xcc>
}
 720:	0001                	nop
 722:	0001                	nop
 724:	70e2                	ld	ra,56(sp)
 726:	7442                	ld	s0,48(sp)
 728:	6121                	addi	sp,sp,64
 72a:	8082                	ret

000000000000072c <printptr>:

static void
printptr(int fd, uint64 x) {
 72c:	7179                	addi	sp,sp,-48
 72e:	f406                	sd	ra,40(sp)
 730:	f022                	sd	s0,32(sp)
 732:	1800                	addi	s0,sp,48
 734:	87aa                	mv	a5,a0
 736:	fcb43823          	sd	a1,-48(s0)
 73a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 73e:	fdc42783          	lw	a5,-36(s0)
 742:	03000593          	li	a1,48
 746:	853e                	mv	a0,a5
 748:	00000097          	auipc	ra,0x0
 74c:	ea6080e7          	jalr	-346(ra) # 5ee <putc>
  putc(fd, 'x');
 750:	fdc42783          	lw	a5,-36(s0)
 754:	07800593          	li	a1,120
 758:	853e                	mv	a0,a5
 75a:	00000097          	auipc	ra,0x0
 75e:	e94080e7          	jalr	-364(ra) # 5ee <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 762:	fe042623          	sw	zero,-20(s0)
 766:	a82d                	j	7a0 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 768:	fd043783          	ld	a5,-48(s0)
 76c:	93f1                	srli	a5,a5,0x3c
 76e:	00000717          	auipc	a4,0x0
 772:	7ea70713          	addi	a4,a4,2026 # f58 <digits>
 776:	97ba                	add	a5,a5,a4
 778:	0007c703          	lbu	a4,0(a5)
 77c:	fdc42783          	lw	a5,-36(s0)
 780:	85ba                	mv	a1,a4
 782:	853e                	mv	a0,a5
 784:	00000097          	auipc	ra,0x0
 788:	e6a080e7          	jalr	-406(ra) # 5ee <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 78c:	fec42783          	lw	a5,-20(s0)
 790:	2785                	addiw	a5,a5,1
 792:	fef42623          	sw	a5,-20(s0)
 796:	fd043783          	ld	a5,-48(s0)
 79a:	0792                	slli	a5,a5,0x4
 79c:	fcf43823          	sd	a5,-48(s0)
 7a0:	fec42783          	lw	a5,-20(s0)
 7a4:	873e                	mv	a4,a5
 7a6:	47bd                	li	a5,15
 7a8:	fce7f0e3          	bgeu	a5,a4,768 <printptr+0x3c>
}
 7ac:	0001                	nop
 7ae:	0001                	nop
 7b0:	70a2                	ld	ra,40(sp)
 7b2:	7402                	ld	s0,32(sp)
 7b4:	6145                	addi	sp,sp,48
 7b6:	8082                	ret

00000000000007b8 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7b8:	715d                	addi	sp,sp,-80
 7ba:	e486                	sd	ra,72(sp)
 7bc:	e0a2                	sd	s0,64(sp)
 7be:	0880                	addi	s0,sp,80
 7c0:	87aa                	mv	a5,a0
 7c2:	fcb43023          	sd	a1,-64(s0)
 7c6:	fac43c23          	sd	a2,-72(s0)
 7ca:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 7ce:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7d2:	fe042223          	sw	zero,-28(s0)
 7d6:	a42d                	j	a00 <vprintf+0x248>
    c = fmt[i] & 0xff;
 7d8:	fe442783          	lw	a5,-28(s0)
 7dc:	fc043703          	ld	a4,-64(s0)
 7e0:	97ba                	add	a5,a5,a4
 7e2:	0007c783          	lbu	a5,0(a5)
 7e6:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7ea:	fe042783          	lw	a5,-32(s0)
 7ee:	2781                	sext.w	a5,a5
 7f0:	eb9d                	bnez	a5,826 <vprintf+0x6e>
      if(c == '%'){
 7f2:	fdc42783          	lw	a5,-36(s0)
 7f6:	0007871b          	sext.w	a4,a5
 7fa:	02500793          	li	a5,37
 7fe:	00f71763          	bne	a4,a5,80c <vprintf+0x54>
        state = '%';
 802:	02500793          	li	a5,37
 806:	fef42023          	sw	a5,-32(s0)
 80a:	a2f5                	j	9f6 <vprintf+0x23e>
      } else {
        putc(fd, c);
 80c:	fdc42783          	lw	a5,-36(s0)
 810:	0ff7f713          	zext.b	a4,a5
 814:	fcc42783          	lw	a5,-52(s0)
 818:	85ba                	mv	a1,a4
 81a:	853e                	mv	a0,a5
 81c:	00000097          	auipc	ra,0x0
 820:	dd2080e7          	jalr	-558(ra) # 5ee <putc>
 824:	aac9                	j	9f6 <vprintf+0x23e>
      }
    } else if(state == '%'){
 826:	fe042783          	lw	a5,-32(s0)
 82a:	0007871b          	sext.w	a4,a5
 82e:	02500793          	li	a5,37
 832:	1cf71263          	bne	a4,a5,9f6 <vprintf+0x23e>
      if(c == 'd'){
 836:	fdc42783          	lw	a5,-36(s0)
 83a:	0007871b          	sext.w	a4,a5
 83e:	06400793          	li	a5,100
 842:	02f71463          	bne	a4,a5,86a <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 846:	fb843783          	ld	a5,-72(s0)
 84a:	00878713          	addi	a4,a5,8
 84e:	fae43c23          	sd	a4,-72(s0)
 852:	4398                	lw	a4,0(a5)
 854:	fcc42783          	lw	a5,-52(s0)
 858:	4685                	li	a3,1
 85a:	4629                	li	a2,10
 85c:	85ba                	mv	a1,a4
 85e:	853e                	mv	a0,a5
 860:	00000097          	auipc	ra,0x0
 864:	dc4080e7          	jalr	-572(ra) # 624 <printint>
 868:	a269                	j	9f2 <vprintf+0x23a>
      } else if(c == 'l') {
 86a:	fdc42783          	lw	a5,-36(s0)
 86e:	0007871b          	sext.w	a4,a5
 872:	06c00793          	li	a5,108
 876:	02f71663          	bne	a4,a5,8a2 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 87a:	fb843783          	ld	a5,-72(s0)
 87e:	00878713          	addi	a4,a5,8
 882:	fae43c23          	sd	a4,-72(s0)
 886:	639c                	ld	a5,0(a5)
 888:	0007871b          	sext.w	a4,a5
 88c:	fcc42783          	lw	a5,-52(s0)
 890:	4681                	li	a3,0
 892:	4629                	li	a2,10
 894:	85ba                	mv	a1,a4
 896:	853e                	mv	a0,a5
 898:	00000097          	auipc	ra,0x0
 89c:	d8c080e7          	jalr	-628(ra) # 624 <printint>
 8a0:	aa89                	j	9f2 <vprintf+0x23a>
      } else if(c == 'x') {
 8a2:	fdc42783          	lw	a5,-36(s0)
 8a6:	0007871b          	sext.w	a4,a5
 8aa:	07800793          	li	a5,120
 8ae:	02f71463          	bne	a4,a5,8d6 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 8b2:	fb843783          	ld	a5,-72(s0)
 8b6:	00878713          	addi	a4,a5,8
 8ba:	fae43c23          	sd	a4,-72(s0)
 8be:	4398                	lw	a4,0(a5)
 8c0:	fcc42783          	lw	a5,-52(s0)
 8c4:	4681                	li	a3,0
 8c6:	4641                	li	a2,16
 8c8:	85ba                	mv	a1,a4
 8ca:	853e                	mv	a0,a5
 8cc:	00000097          	auipc	ra,0x0
 8d0:	d58080e7          	jalr	-680(ra) # 624 <printint>
 8d4:	aa39                	j	9f2 <vprintf+0x23a>
      } else if(c == 'p') {
 8d6:	fdc42783          	lw	a5,-36(s0)
 8da:	0007871b          	sext.w	a4,a5
 8de:	07000793          	li	a5,112
 8e2:	02f71263          	bne	a4,a5,906 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8e6:	fb843783          	ld	a5,-72(s0)
 8ea:	00878713          	addi	a4,a5,8
 8ee:	fae43c23          	sd	a4,-72(s0)
 8f2:	6398                	ld	a4,0(a5)
 8f4:	fcc42783          	lw	a5,-52(s0)
 8f8:	85ba                	mv	a1,a4
 8fa:	853e                	mv	a0,a5
 8fc:	00000097          	auipc	ra,0x0
 900:	e30080e7          	jalr	-464(ra) # 72c <printptr>
 904:	a0fd                	j	9f2 <vprintf+0x23a>
      } else if(c == 's'){
 906:	fdc42783          	lw	a5,-36(s0)
 90a:	0007871b          	sext.w	a4,a5
 90e:	07300793          	li	a5,115
 912:	04f71c63          	bne	a4,a5,96a <vprintf+0x1b2>
        s = va_arg(ap, char*);
 916:	fb843783          	ld	a5,-72(s0)
 91a:	00878713          	addi	a4,a5,8
 91e:	fae43c23          	sd	a4,-72(s0)
 922:	639c                	ld	a5,0(a5)
 924:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 928:	fe843783          	ld	a5,-24(s0)
 92c:	eb8d                	bnez	a5,95e <vprintf+0x1a6>
          s = "(null)";
 92e:	00000797          	auipc	a5,0x0
 932:	5d278793          	addi	a5,a5,1490 # f00 <lock_init+0x52>
 936:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 93a:	a015                	j	95e <vprintf+0x1a6>
          putc(fd, *s);
 93c:	fe843783          	ld	a5,-24(s0)
 940:	0007c703          	lbu	a4,0(a5)
 944:	fcc42783          	lw	a5,-52(s0)
 948:	85ba                	mv	a1,a4
 94a:	853e                	mv	a0,a5
 94c:	00000097          	auipc	ra,0x0
 950:	ca2080e7          	jalr	-862(ra) # 5ee <putc>
          s++;
 954:	fe843783          	ld	a5,-24(s0)
 958:	0785                	addi	a5,a5,1
 95a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 95e:	fe843783          	ld	a5,-24(s0)
 962:	0007c783          	lbu	a5,0(a5)
 966:	fbf9                	bnez	a5,93c <vprintf+0x184>
 968:	a069                	j	9f2 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 96a:	fdc42783          	lw	a5,-36(s0)
 96e:	0007871b          	sext.w	a4,a5
 972:	06300793          	li	a5,99
 976:	02f71463          	bne	a4,a5,99e <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 97a:	fb843783          	ld	a5,-72(s0)
 97e:	00878713          	addi	a4,a5,8
 982:	fae43c23          	sd	a4,-72(s0)
 986:	439c                	lw	a5,0(a5)
 988:	0ff7f713          	zext.b	a4,a5
 98c:	fcc42783          	lw	a5,-52(s0)
 990:	85ba                	mv	a1,a4
 992:	853e                	mv	a0,a5
 994:	00000097          	auipc	ra,0x0
 998:	c5a080e7          	jalr	-934(ra) # 5ee <putc>
 99c:	a899                	j	9f2 <vprintf+0x23a>
      } else if(c == '%'){
 99e:	fdc42783          	lw	a5,-36(s0)
 9a2:	0007871b          	sext.w	a4,a5
 9a6:	02500793          	li	a5,37
 9aa:	00f71f63          	bne	a4,a5,9c8 <vprintf+0x210>
        putc(fd, c);
 9ae:	fdc42783          	lw	a5,-36(s0)
 9b2:	0ff7f713          	zext.b	a4,a5
 9b6:	fcc42783          	lw	a5,-52(s0)
 9ba:	85ba                	mv	a1,a4
 9bc:	853e                	mv	a0,a5
 9be:	00000097          	auipc	ra,0x0
 9c2:	c30080e7          	jalr	-976(ra) # 5ee <putc>
 9c6:	a035                	j	9f2 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9c8:	fcc42783          	lw	a5,-52(s0)
 9cc:	02500593          	li	a1,37
 9d0:	853e                	mv	a0,a5
 9d2:	00000097          	auipc	ra,0x0
 9d6:	c1c080e7          	jalr	-996(ra) # 5ee <putc>
        putc(fd, c);
 9da:	fdc42783          	lw	a5,-36(s0)
 9de:	0ff7f713          	zext.b	a4,a5
 9e2:	fcc42783          	lw	a5,-52(s0)
 9e6:	85ba                	mv	a1,a4
 9e8:	853e                	mv	a0,a5
 9ea:	00000097          	auipc	ra,0x0
 9ee:	c04080e7          	jalr	-1020(ra) # 5ee <putc>
      }
      state = 0;
 9f2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 9f6:	fe442783          	lw	a5,-28(s0)
 9fa:	2785                	addiw	a5,a5,1
 9fc:	fef42223          	sw	a5,-28(s0)
 a00:	fe442783          	lw	a5,-28(s0)
 a04:	fc043703          	ld	a4,-64(s0)
 a08:	97ba                	add	a5,a5,a4
 a0a:	0007c783          	lbu	a5,0(a5)
 a0e:	dc0795e3          	bnez	a5,7d8 <vprintf+0x20>
    }
  }
}
 a12:	0001                	nop
 a14:	0001                	nop
 a16:	60a6                	ld	ra,72(sp)
 a18:	6406                	ld	s0,64(sp)
 a1a:	6161                	addi	sp,sp,80
 a1c:	8082                	ret

0000000000000a1e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a1e:	7159                	addi	sp,sp,-112
 a20:	fc06                	sd	ra,56(sp)
 a22:	f822                	sd	s0,48(sp)
 a24:	0080                	addi	s0,sp,64
 a26:	fcb43823          	sd	a1,-48(s0)
 a2a:	e010                	sd	a2,0(s0)
 a2c:	e414                	sd	a3,8(s0)
 a2e:	e818                	sd	a4,16(s0)
 a30:	ec1c                	sd	a5,24(s0)
 a32:	03043023          	sd	a6,32(s0)
 a36:	03143423          	sd	a7,40(s0)
 a3a:	87aa                	mv	a5,a0
 a3c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a40:	03040793          	addi	a5,s0,48
 a44:	fcf43423          	sd	a5,-56(s0)
 a48:	fc843783          	ld	a5,-56(s0)
 a4c:	fd078793          	addi	a5,a5,-48
 a50:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a54:	fe843703          	ld	a4,-24(s0)
 a58:	fdc42783          	lw	a5,-36(s0)
 a5c:	863a                	mv	a2,a4
 a5e:	fd043583          	ld	a1,-48(s0)
 a62:	853e                	mv	a0,a5
 a64:	00000097          	auipc	ra,0x0
 a68:	d54080e7          	jalr	-684(ra) # 7b8 <vprintf>
}
 a6c:	0001                	nop
 a6e:	70e2                	ld	ra,56(sp)
 a70:	7442                	ld	s0,48(sp)
 a72:	6165                	addi	sp,sp,112
 a74:	8082                	ret

0000000000000a76 <printf>:

void
printf(const char *fmt, ...)
{
 a76:	7159                	addi	sp,sp,-112
 a78:	f406                	sd	ra,40(sp)
 a7a:	f022                	sd	s0,32(sp)
 a7c:	1800                	addi	s0,sp,48
 a7e:	fca43c23          	sd	a0,-40(s0)
 a82:	e40c                	sd	a1,8(s0)
 a84:	e810                	sd	a2,16(s0)
 a86:	ec14                	sd	a3,24(s0)
 a88:	f018                	sd	a4,32(s0)
 a8a:	f41c                	sd	a5,40(s0)
 a8c:	03043823          	sd	a6,48(s0)
 a90:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a94:	04040793          	addi	a5,s0,64
 a98:	fcf43823          	sd	a5,-48(s0)
 a9c:	fd043783          	ld	a5,-48(s0)
 aa0:	fc878793          	addi	a5,a5,-56
 aa4:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 aa8:	fe843783          	ld	a5,-24(s0)
 aac:	863e                	mv	a2,a5
 aae:	fd843583          	ld	a1,-40(s0)
 ab2:	4505                	li	a0,1
 ab4:	00000097          	auipc	ra,0x0
 ab8:	d04080e7          	jalr	-764(ra) # 7b8 <vprintf>
}
 abc:	0001                	nop
 abe:	70a2                	ld	ra,40(sp)
 ac0:	7402                	ld	s0,32(sp)
 ac2:	6165                	addi	sp,sp,112
 ac4:	8082                	ret

0000000000000ac6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ac6:	7179                	addi	sp,sp,-48
 ac8:	f422                	sd	s0,40(sp)
 aca:	1800                	addi	s0,sp,48
 acc:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ad0:	fd843783          	ld	a5,-40(s0)
 ad4:	17c1                	addi	a5,a5,-16
 ad6:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ada:	00000797          	auipc	a5,0x0
 ade:	4a678793          	addi	a5,a5,1190 # f80 <freep>
 ae2:	639c                	ld	a5,0(a5)
 ae4:	fef43423          	sd	a5,-24(s0)
 ae8:	a815                	j	b1c <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aea:	fe843783          	ld	a5,-24(s0)
 aee:	639c                	ld	a5,0(a5)
 af0:	fe843703          	ld	a4,-24(s0)
 af4:	00f76f63          	bltu	a4,a5,b12 <free+0x4c>
 af8:	fe043703          	ld	a4,-32(s0)
 afc:	fe843783          	ld	a5,-24(s0)
 b00:	02e7eb63          	bltu	a5,a4,b36 <free+0x70>
 b04:	fe843783          	ld	a5,-24(s0)
 b08:	639c                	ld	a5,0(a5)
 b0a:	fe043703          	ld	a4,-32(s0)
 b0e:	02f76463          	bltu	a4,a5,b36 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b12:	fe843783          	ld	a5,-24(s0)
 b16:	639c                	ld	a5,0(a5)
 b18:	fef43423          	sd	a5,-24(s0)
 b1c:	fe043703          	ld	a4,-32(s0)
 b20:	fe843783          	ld	a5,-24(s0)
 b24:	fce7f3e3          	bgeu	a5,a4,aea <free+0x24>
 b28:	fe843783          	ld	a5,-24(s0)
 b2c:	639c                	ld	a5,0(a5)
 b2e:	fe043703          	ld	a4,-32(s0)
 b32:	faf77ce3          	bgeu	a4,a5,aea <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b36:	fe043783          	ld	a5,-32(s0)
 b3a:	479c                	lw	a5,8(a5)
 b3c:	1782                	slli	a5,a5,0x20
 b3e:	9381                	srli	a5,a5,0x20
 b40:	0792                	slli	a5,a5,0x4
 b42:	fe043703          	ld	a4,-32(s0)
 b46:	973e                	add	a4,a4,a5
 b48:	fe843783          	ld	a5,-24(s0)
 b4c:	639c                	ld	a5,0(a5)
 b4e:	02f71763          	bne	a4,a5,b7c <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b52:	fe043783          	ld	a5,-32(s0)
 b56:	4798                	lw	a4,8(a5)
 b58:	fe843783          	ld	a5,-24(s0)
 b5c:	639c                	ld	a5,0(a5)
 b5e:	479c                	lw	a5,8(a5)
 b60:	9fb9                	addw	a5,a5,a4
 b62:	0007871b          	sext.w	a4,a5
 b66:	fe043783          	ld	a5,-32(s0)
 b6a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b6c:	fe843783          	ld	a5,-24(s0)
 b70:	639c                	ld	a5,0(a5)
 b72:	6398                	ld	a4,0(a5)
 b74:	fe043783          	ld	a5,-32(s0)
 b78:	e398                	sd	a4,0(a5)
 b7a:	a039                	j	b88 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b7c:	fe843783          	ld	a5,-24(s0)
 b80:	6398                	ld	a4,0(a5)
 b82:	fe043783          	ld	a5,-32(s0)
 b86:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b88:	fe843783          	ld	a5,-24(s0)
 b8c:	479c                	lw	a5,8(a5)
 b8e:	1782                	slli	a5,a5,0x20
 b90:	9381                	srli	a5,a5,0x20
 b92:	0792                	slli	a5,a5,0x4
 b94:	fe843703          	ld	a4,-24(s0)
 b98:	97ba                	add	a5,a5,a4
 b9a:	fe043703          	ld	a4,-32(s0)
 b9e:	02f71563          	bne	a4,a5,bc8 <free+0x102>
    p->s.size += bp->s.size;
 ba2:	fe843783          	ld	a5,-24(s0)
 ba6:	4798                	lw	a4,8(a5)
 ba8:	fe043783          	ld	a5,-32(s0)
 bac:	479c                	lw	a5,8(a5)
 bae:	9fb9                	addw	a5,a5,a4
 bb0:	0007871b          	sext.w	a4,a5
 bb4:	fe843783          	ld	a5,-24(s0)
 bb8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bba:	fe043783          	ld	a5,-32(s0)
 bbe:	6398                	ld	a4,0(a5)
 bc0:	fe843783          	ld	a5,-24(s0)
 bc4:	e398                	sd	a4,0(a5)
 bc6:	a031                	j	bd2 <free+0x10c>
  } else
    p->s.ptr = bp;
 bc8:	fe843783          	ld	a5,-24(s0)
 bcc:	fe043703          	ld	a4,-32(s0)
 bd0:	e398                	sd	a4,0(a5)
  freep = p;
 bd2:	00000797          	auipc	a5,0x0
 bd6:	3ae78793          	addi	a5,a5,942 # f80 <freep>
 bda:	fe843703          	ld	a4,-24(s0)
 bde:	e398                	sd	a4,0(a5)
}
 be0:	0001                	nop
 be2:	7422                	ld	s0,40(sp)
 be4:	6145                	addi	sp,sp,48
 be6:	8082                	ret

0000000000000be8 <morecore>:

static Header*
morecore(uint nu)
{
 be8:	7179                	addi	sp,sp,-48
 bea:	f406                	sd	ra,40(sp)
 bec:	f022                	sd	s0,32(sp)
 bee:	1800                	addi	s0,sp,48
 bf0:	87aa                	mv	a5,a0
 bf2:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 bf6:	fdc42783          	lw	a5,-36(s0)
 bfa:	0007871b          	sext.w	a4,a5
 bfe:	6785                	lui	a5,0x1
 c00:	00f77563          	bgeu	a4,a5,c0a <morecore+0x22>
    nu = 4096;
 c04:	6785                	lui	a5,0x1
 c06:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c0a:	fdc42783          	lw	a5,-36(s0)
 c0e:	0047979b          	slliw	a5,a5,0x4
 c12:	2781                	sext.w	a5,a5
 c14:	2781                	sext.w	a5,a5
 c16:	853e                	mv	a0,a5
 c18:	00000097          	auipc	ra,0x0
 c1c:	9ae080e7          	jalr	-1618(ra) # 5c6 <sbrk>
 c20:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c24:	fe843703          	ld	a4,-24(s0)
 c28:	57fd                	li	a5,-1
 c2a:	00f71463          	bne	a4,a5,c32 <morecore+0x4a>
    return 0;
 c2e:	4781                	li	a5,0
 c30:	a03d                	j	c5e <morecore+0x76>
  hp = (Header*)p;
 c32:	fe843783          	ld	a5,-24(s0)
 c36:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c3a:	fe043783          	ld	a5,-32(s0)
 c3e:	fdc42703          	lw	a4,-36(s0)
 c42:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c44:	fe043783          	ld	a5,-32(s0)
 c48:	07c1                	addi	a5,a5,16
 c4a:	853e                	mv	a0,a5
 c4c:	00000097          	auipc	ra,0x0
 c50:	e7a080e7          	jalr	-390(ra) # ac6 <free>
  return freep;
 c54:	00000797          	auipc	a5,0x0
 c58:	32c78793          	addi	a5,a5,812 # f80 <freep>
 c5c:	639c                	ld	a5,0(a5)
}
 c5e:	853e                	mv	a0,a5
 c60:	70a2                	ld	ra,40(sp)
 c62:	7402                	ld	s0,32(sp)
 c64:	6145                	addi	sp,sp,48
 c66:	8082                	ret

0000000000000c68 <malloc>:

void*
malloc(uint nbytes)
{
 c68:	7139                	addi	sp,sp,-64
 c6a:	fc06                	sd	ra,56(sp)
 c6c:	f822                	sd	s0,48(sp)
 c6e:	0080                	addi	s0,sp,64
 c70:	87aa                	mv	a5,a0
 c72:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c76:	fcc46783          	lwu	a5,-52(s0)
 c7a:	07bd                	addi	a5,a5,15
 c7c:	8391                	srli	a5,a5,0x4
 c7e:	2781                	sext.w	a5,a5
 c80:	2785                	addiw	a5,a5,1
 c82:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c86:	00000797          	auipc	a5,0x0
 c8a:	2fa78793          	addi	a5,a5,762 # f80 <freep>
 c8e:	639c                	ld	a5,0(a5)
 c90:	fef43023          	sd	a5,-32(s0)
 c94:	fe043783          	ld	a5,-32(s0)
 c98:	ef95                	bnez	a5,cd4 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c9a:	00000797          	auipc	a5,0x0
 c9e:	2d678793          	addi	a5,a5,726 # f70 <base>
 ca2:	fef43023          	sd	a5,-32(s0)
 ca6:	00000797          	auipc	a5,0x0
 caa:	2da78793          	addi	a5,a5,730 # f80 <freep>
 cae:	fe043703          	ld	a4,-32(s0)
 cb2:	e398                	sd	a4,0(a5)
 cb4:	00000797          	auipc	a5,0x0
 cb8:	2cc78793          	addi	a5,a5,716 # f80 <freep>
 cbc:	6398                	ld	a4,0(a5)
 cbe:	00000797          	auipc	a5,0x0
 cc2:	2b278793          	addi	a5,a5,690 # f70 <base>
 cc6:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 cc8:	00000797          	auipc	a5,0x0
 ccc:	2a878793          	addi	a5,a5,680 # f70 <base>
 cd0:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cd4:	fe043783          	ld	a5,-32(s0)
 cd8:	639c                	ld	a5,0(a5)
 cda:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 cde:	fe843783          	ld	a5,-24(s0)
 ce2:	4798                	lw	a4,8(a5)
 ce4:	fdc42783          	lw	a5,-36(s0)
 ce8:	2781                	sext.w	a5,a5
 cea:	06f76763          	bltu	a4,a5,d58 <malloc+0xf0>
      if(p->s.size == nunits)
 cee:	fe843783          	ld	a5,-24(s0)
 cf2:	4798                	lw	a4,8(a5)
 cf4:	fdc42783          	lw	a5,-36(s0)
 cf8:	2781                	sext.w	a5,a5
 cfa:	00e79963          	bne	a5,a4,d0c <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 cfe:	fe843783          	ld	a5,-24(s0)
 d02:	6398                	ld	a4,0(a5)
 d04:	fe043783          	ld	a5,-32(s0)
 d08:	e398                	sd	a4,0(a5)
 d0a:	a825                	j	d42 <malloc+0xda>
      else {
        p->s.size -= nunits;
 d0c:	fe843783          	ld	a5,-24(s0)
 d10:	479c                	lw	a5,8(a5)
 d12:	fdc42703          	lw	a4,-36(s0)
 d16:	9f99                	subw	a5,a5,a4
 d18:	0007871b          	sext.w	a4,a5
 d1c:	fe843783          	ld	a5,-24(s0)
 d20:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d22:	fe843783          	ld	a5,-24(s0)
 d26:	479c                	lw	a5,8(a5)
 d28:	1782                	slli	a5,a5,0x20
 d2a:	9381                	srli	a5,a5,0x20
 d2c:	0792                	slli	a5,a5,0x4
 d2e:	fe843703          	ld	a4,-24(s0)
 d32:	97ba                	add	a5,a5,a4
 d34:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d38:	fe843783          	ld	a5,-24(s0)
 d3c:	fdc42703          	lw	a4,-36(s0)
 d40:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d42:	00000797          	auipc	a5,0x0
 d46:	23e78793          	addi	a5,a5,574 # f80 <freep>
 d4a:	fe043703          	ld	a4,-32(s0)
 d4e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d50:	fe843783          	ld	a5,-24(s0)
 d54:	07c1                	addi	a5,a5,16
 d56:	a091                	j	d9a <malloc+0x132>
    }
    if(p == freep)
 d58:	00000797          	auipc	a5,0x0
 d5c:	22878793          	addi	a5,a5,552 # f80 <freep>
 d60:	639c                	ld	a5,0(a5)
 d62:	fe843703          	ld	a4,-24(s0)
 d66:	02f71063          	bne	a4,a5,d86 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 d6a:	fdc42783          	lw	a5,-36(s0)
 d6e:	853e                	mv	a0,a5
 d70:	00000097          	auipc	ra,0x0
 d74:	e78080e7          	jalr	-392(ra) # be8 <morecore>
 d78:	fea43423          	sd	a0,-24(s0)
 d7c:	fe843783          	ld	a5,-24(s0)
 d80:	e399                	bnez	a5,d86 <malloc+0x11e>
        return 0;
 d82:	4781                	li	a5,0
 d84:	a819                	j	d9a <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d86:	fe843783          	ld	a5,-24(s0)
 d8a:	fef43023          	sd	a5,-32(s0)
 d8e:	fe843783          	ld	a5,-24(s0)
 d92:	639c                	ld	a5,0(a5)
 d94:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d98:	b799                	j	cde <malloc+0x76>
  }
}
 d9a:	853e                	mv	a0,a5
 d9c:	70e2                	ld	ra,56(sp)
 d9e:	7442                	ld	s0,48(sp)
 da0:	6121                	addi	sp,sp,64
 da2:	8082                	ret

0000000000000da4 <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
 da4:	7179                	addi	sp,sp,-48
 da6:	f406                	sd	ra,40(sp)
 da8:	f022                	sd	s0,32(sp)
 daa:	1800                	addi	s0,sp,48
 dac:	fca43c23          	sd	a0,-40(s0)
 db0:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
 db4:	6505                	lui	a0,0x1
 db6:	00000097          	auipc	ra,0x0
 dba:	eb2080e7          	jalr	-334(ra) # c68 <malloc>
 dbe:	fea43423          	sd	a0,-24(s0)
 dc2:	fe843783          	ld	a5,-24(s0)
 dc6:	e38d                	bnez	a5,de8 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
 dc8:	00000517          	auipc	a0,0x0
 dcc:	14050513          	addi	a0,a0,320 # f08 <lock_init+0x5a>
 dd0:	00000097          	auipc	ra,0x0
 dd4:	ca6080e7          	jalr	-858(ra) # a76 <printf>
        free(stack);
 dd8:	fe843503          	ld	a0,-24(s0)
 ddc:	00000097          	auipc	ra,0x0
 de0:	cea080e7          	jalr	-790(ra) # ac6 <free>
        return -1;
 de4:	57fd                	li	a5,-1
 de6:	a099                	j	e2c <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
 de8:	fe843783          	ld	a5,-24(s0)
 dec:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
 df0:	fe043703          	ld	a4,-32(s0)
 df4:	6785                	lui	a5,0x1
 df6:	17fd                	addi	a5,a5,-1
 df8:	8ff9                	and	a5,a5,a4
 dfa:	cf91                	beqz	a5,e16 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
 dfc:	fe043703          	ld	a4,-32(s0)
 e00:	6785                	lui	a5,0x1
 e02:	17fd                	addi	a5,a5,-1
 e04:	8ff9                	and	a5,a5,a4
 e06:	6705                	lui	a4,0x1
 e08:	40f707b3          	sub	a5,a4,a5
 e0c:	fe843703          	ld	a4,-24(s0)
 e10:	97ba                	add	a5,a5,a4
 e12:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
 e16:	fe843603          	ld	a2,-24(s0)
 e1a:	fd043583          	ld	a1,-48(s0)
 e1e:	fd843503          	ld	a0,-40(s0)
 e22:	fffff097          	auipc	ra,0xfffff
 e26:	7bc080e7          	jalr	1980(ra) # 5de <clone>
 e2a:	87aa                	mv	a5,a0
}
 e2c:	853e                	mv	a0,a5
 e2e:	70a2                	ld	ra,40(sp)
 e30:	7402                	ld	s0,32(sp)
 e32:	6145                	addi	sp,sp,48
 e34:	8082                	ret

0000000000000e36 <thread_join>:


int thread_join()
{
 e36:	1101                	addi	sp,sp,-32
 e38:	ec06                	sd	ra,24(sp)
 e3a:	e822                	sd	s0,16(sp)
 e3c:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
 e3e:	fe040793          	addi	a5,s0,-32
 e42:	853e                	mv	a0,a5
 e44:	fffff097          	auipc	ra,0xfffff
 e48:	7a2080e7          	jalr	1954(ra) # 5e6 <join>
 e4c:	87aa                	mv	a5,a0
 e4e:	fef42623          	sw	a5,-20(s0)
 e52:	fec42783          	lw	a5,-20(s0)
 e56:	0007871b          	sext.w	a4,a5
 e5a:	57fd                	li	a5,-1
 e5c:	00f70963          	beq	a4,a5,e6e <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
 e60:	fe043783          	ld	a5,-32(s0)
 e64:	853e                	mv	a0,a5
 e66:	00000097          	auipc	ra,0x0
 e6a:	c60080e7          	jalr	-928(ra) # ac6 <free>
    } 

    return child_tid;
 e6e:	fec42783          	lw	a5,-20(s0)
}
 e72:	853e                	mv	a0,a5
 e74:	60e2                	ld	ra,24(sp)
 e76:	6442                	ld	s0,16(sp)
 e78:	6105                	addi	sp,sp,32
 e7a:	8082                	ret

0000000000000e7c <lock_acquire>:


void lock_acquire (lock_t *lock)
{
 e7c:	1101                	addi	sp,sp,-32
 e7e:	ec22                	sd	s0,24(sp)
 e80:	1000                	addi	s0,sp,32
 e82:	fea43423          	sd	a0,-24(s0)
        lock = 0;
 e86:	fe043423          	sd	zero,-24(s0)

}
 e8a:	0001                	nop
 e8c:	6462                	ld	s0,24(sp)
 e8e:	6105                	addi	sp,sp,32
 e90:	8082                	ret

0000000000000e92 <lock_release>:

void lock_release (lock_t *lock)
{
 e92:	1101                	addi	sp,sp,-32
 e94:	ec22                	sd	s0,24(sp)
 e96:	1000                	addi	s0,sp,32
 e98:	fea43423          	sd	a0,-24(s0)
        __sync_lock_test_and_set(lock, 1);
 e9c:	fe843783          	ld	a5,-24(s0)
 ea0:	4705                	li	a4,1
 ea2:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    
}
 ea6:	0001                	nop
 ea8:	6462                	ld	s0,24(sp)
 eaa:	6105                	addi	sp,sp,32
 eac:	8082                	ret

0000000000000eae <lock_init>:

void lock_init (lock_t *lock)
{
 eae:	1101                	addi	sp,sp,-32
 eb0:	ec22                	sd	s0,24(sp)
 eb2:	1000                	addi	s0,sp,32
 eb4:	fea43423          	sd	a0,-24(s0)
    lock = 0;
 eb8:	fe043423          	sd	zero,-24(s0)
    
}
 ebc:	0001                	nop
 ebe:	6462                	ld	s0,24(sp)
 ec0:	6105                	addi	sp,sp,32
 ec2:	8082                	ret
