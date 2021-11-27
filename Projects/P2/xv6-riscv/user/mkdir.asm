
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
  24:	d8858593          	addi	a1,a1,-632 # da8 <malloc+0x13e>
  28:	4509                	li	a0,2
  2a:	00001097          	auipc	ra,0x1
  2e:	9f6080e7          	jalr	-1546(ra) # a20 <fprintf>
    exit(1);
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	506080e7          	jalr	1286(ra) # 53a <exit>
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
  58:	54e080e7          	jalr	1358(ra) # 5a2 <mkdir>
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
  76:	d4e58593          	addi	a1,a1,-690 # dc0 <malloc+0x156>
  7a:	4509                	li	a0,2
  7c:	00001097          	auipc	ra,0x1
  80:	9a4080e7          	jalr	-1628(ra) # a20 <fprintf>
      break;
  84:	a831                	j	a0 <main+0xa0>
  for(i = 1; i < argc; i++){
  86:	fec42783          	lw	a5,-20(s0)
  8a:	2785                	addiw	a5,a5,1
  8c:	fef42623          	sw	a5,-20(s0)
  90:	fec42703          	lw	a4,-20(s0)
  94:	fdc42783          	lw	a5,-36(s0)
  98:	2701                	sext.w	a4,a4
  9a:	2781                	sext.w	a5,a5
  9c:	faf744e3          	blt	a4,a5,44 <main+0x44>
    }
  }

  exit(0);
  a0:	4501                	li	a0,0
  a2:	00000097          	auipc	ra,0x0
  a6:	498080e7          	jalr	1176(ra) # 53a <exit>

00000000000000aa <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  aa:	7179                	addi	sp,sp,-48
  ac:	f422                	sd	s0,40(sp)
  ae:	1800                	addi	s0,sp,48
  b0:	fca43c23          	sd	a0,-40(s0)
  b4:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  b8:	fd843783          	ld	a5,-40(s0)
  bc:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  c0:	0001                	nop
  c2:	fd043703          	ld	a4,-48(s0)
  c6:	00170793          	addi	a5,a4,1
  ca:	fcf43823          	sd	a5,-48(s0)
  ce:	fd843783          	ld	a5,-40(s0)
  d2:	00178693          	addi	a3,a5,1
  d6:	fcd43c23          	sd	a3,-40(s0)
  da:	00074703          	lbu	a4,0(a4)
  de:	00e78023          	sb	a4,0(a5)
  e2:	0007c783          	lbu	a5,0(a5)
  e6:	fff1                	bnez	a5,c2 <strcpy+0x18>
    ;
  return os;
  e8:	fe843783          	ld	a5,-24(s0)
}
  ec:	853e                	mv	a0,a5
  ee:	7422                	ld	s0,40(sp)
  f0:	6145                	addi	sp,sp,48
  f2:	8082                	ret

00000000000000f4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f4:	1101                	addi	sp,sp,-32
  f6:	ec22                	sd	s0,24(sp)
  f8:	1000                	addi	s0,sp,32
  fa:	fea43423          	sd	a0,-24(s0)
  fe:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 102:	a819                	j	118 <strcmp+0x24>
    p++, q++;
 104:	fe843783          	ld	a5,-24(s0)
 108:	0785                	addi	a5,a5,1
 10a:	fef43423          	sd	a5,-24(s0)
 10e:	fe043783          	ld	a5,-32(s0)
 112:	0785                	addi	a5,a5,1
 114:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 118:	fe843783          	ld	a5,-24(s0)
 11c:	0007c783          	lbu	a5,0(a5)
 120:	cb99                	beqz	a5,136 <strcmp+0x42>
 122:	fe843783          	ld	a5,-24(s0)
 126:	0007c703          	lbu	a4,0(a5)
 12a:	fe043783          	ld	a5,-32(s0)
 12e:	0007c783          	lbu	a5,0(a5)
 132:	fcf709e3          	beq	a4,a5,104 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 136:	fe843783          	ld	a5,-24(s0)
 13a:	0007c783          	lbu	a5,0(a5)
 13e:	0007871b          	sext.w	a4,a5
 142:	fe043783          	ld	a5,-32(s0)
 146:	0007c783          	lbu	a5,0(a5)
 14a:	2781                	sext.w	a5,a5
 14c:	40f707bb          	subw	a5,a4,a5
 150:	2781                	sext.w	a5,a5
}
 152:	853e                	mv	a0,a5
 154:	6462                	ld	s0,24(sp)
 156:	6105                	addi	sp,sp,32
 158:	8082                	ret

000000000000015a <strlen>:

uint
strlen(const char *s)
{
 15a:	7179                	addi	sp,sp,-48
 15c:	f422                	sd	s0,40(sp)
 15e:	1800                	addi	s0,sp,48
 160:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 164:	fe042623          	sw	zero,-20(s0)
 168:	a031                	j	174 <strlen+0x1a>
 16a:	fec42783          	lw	a5,-20(s0)
 16e:	2785                	addiw	a5,a5,1
 170:	fef42623          	sw	a5,-20(s0)
 174:	fec42783          	lw	a5,-20(s0)
 178:	fd843703          	ld	a4,-40(s0)
 17c:	97ba                	add	a5,a5,a4
 17e:	0007c783          	lbu	a5,0(a5)
 182:	f7e5                	bnez	a5,16a <strlen+0x10>
    ;
  return n;
 184:	fec42783          	lw	a5,-20(s0)
}
 188:	853e                	mv	a0,a5
 18a:	7422                	ld	s0,40(sp)
 18c:	6145                	addi	sp,sp,48
 18e:	8082                	ret

0000000000000190 <memset>:

void*
memset(void *dst, int c, uint n)
{
 190:	7179                	addi	sp,sp,-48
 192:	f422                	sd	s0,40(sp)
 194:	1800                	addi	s0,sp,48
 196:	fca43c23          	sd	a0,-40(s0)
 19a:	87ae                	mv	a5,a1
 19c:	8732                	mv	a4,a2
 19e:	fcf42a23          	sw	a5,-44(s0)
 1a2:	87ba                	mv	a5,a4
 1a4:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1a8:	fd843783          	ld	a5,-40(s0)
 1ac:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1b0:	fe042623          	sw	zero,-20(s0)
 1b4:	a00d                	j	1d6 <memset+0x46>
    cdst[i] = c;
 1b6:	fec42783          	lw	a5,-20(s0)
 1ba:	fe043703          	ld	a4,-32(s0)
 1be:	97ba                	add	a5,a5,a4
 1c0:	fd442703          	lw	a4,-44(s0)
 1c4:	0ff77713          	andi	a4,a4,255
 1c8:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1cc:	fec42783          	lw	a5,-20(s0)
 1d0:	2785                	addiw	a5,a5,1
 1d2:	fef42623          	sw	a5,-20(s0)
 1d6:	fec42703          	lw	a4,-20(s0)
 1da:	fd042783          	lw	a5,-48(s0)
 1de:	2781                	sext.w	a5,a5
 1e0:	fcf76be3          	bltu	a4,a5,1b6 <memset+0x26>
  }
  return dst;
 1e4:	fd843783          	ld	a5,-40(s0)
}
 1e8:	853e                	mv	a0,a5
 1ea:	7422                	ld	s0,40(sp)
 1ec:	6145                	addi	sp,sp,48
 1ee:	8082                	ret

00000000000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	1101                	addi	sp,sp,-32
 1f2:	ec22                	sd	s0,24(sp)
 1f4:	1000                	addi	s0,sp,32
 1f6:	fea43423          	sd	a0,-24(s0)
 1fa:	87ae                	mv	a5,a1
 1fc:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 200:	a01d                	j	226 <strchr+0x36>
    if(*s == c)
 202:	fe843783          	ld	a5,-24(s0)
 206:	0007c703          	lbu	a4,0(a5)
 20a:	fe744783          	lbu	a5,-25(s0)
 20e:	0ff7f793          	andi	a5,a5,255
 212:	00e79563          	bne	a5,a4,21c <strchr+0x2c>
      return (char*)s;
 216:	fe843783          	ld	a5,-24(s0)
 21a:	a821                	j	232 <strchr+0x42>
  for(; *s; s++)
 21c:	fe843783          	ld	a5,-24(s0)
 220:	0785                	addi	a5,a5,1
 222:	fef43423          	sd	a5,-24(s0)
 226:	fe843783          	ld	a5,-24(s0)
 22a:	0007c783          	lbu	a5,0(a5)
 22e:	fbf1                	bnez	a5,202 <strchr+0x12>
  return 0;
 230:	4781                	li	a5,0
}
 232:	853e                	mv	a0,a5
 234:	6462                	ld	s0,24(sp)
 236:	6105                	addi	sp,sp,32
 238:	8082                	ret

000000000000023a <gets>:

char*
gets(char *buf, int max)
{
 23a:	7179                	addi	sp,sp,-48
 23c:	f406                	sd	ra,40(sp)
 23e:	f022                	sd	s0,32(sp)
 240:	1800                	addi	s0,sp,48
 242:	fca43c23          	sd	a0,-40(s0)
 246:	87ae                	mv	a5,a1
 248:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 24c:	fe042623          	sw	zero,-20(s0)
 250:	a8a1                	j	2a8 <gets+0x6e>
    cc = read(0, &c, 1);
 252:	fe740793          	addi	a5,s0,-25
 256:	4605                	li	a2,1
 258:	85be                	mv	a1,a5
 25a:	4501                	li	a0,0
 25c:	00000097          	auipc	ra,0x0
 260:	2f6080e7          	jalr	758(ra) # 552 <read>
 264:	87aa                	mv	a5,a0
 266:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 26a:	fe842783          	lw	a5,-24(s0)
 26e:	2781                	sext.w	a5,a5
 270:	04f05763          	blez	a5,2be <gets+0x84>
      break;
    buf[i++] = c;
 274:	fec42783          	lw	a5,-20(s0)
 278:	0017871b          	addiw	a4,a5,1
 27c:	fee42623          	sw	a4,-20(s0)
 280:	873e                	mv	a4,a5
 282:	fd843783          	ld	a5,-40(s0)
 286:	97ba                	add	a5,a5,a4
 288:	fe744703          	lbu	a4,-25(s0)
 28c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 290:	fe744783          	lbu	a5,-25(s0)
 294:	873e                	mv	a4,a5
 296:	47a9                	li	a5,10
 298:	02f70463          	beq	a4,a5,2c0 <gets+0x86>
 29c:	fe744783          	lbu	a5,-25(s0)
 2a0:	873e                	mv	a4,a5
 2a2:	47b5                	li	a5,13
 2a4:	00f70e63          	beq	a4,a5,2c0 <gets+0x86>
  for(i=0; i+1 < max; ){
 2a8:	fec42783          	lw	a5,-20(s0)
 2ac:	2785                	addiw	a5,a5,1
 2ae:	0007871b          	sext.w	a4,a5
 2b2:	fd442783          	lw	a5,-44(s0)
 2b6:	2781                	sext.w	a5,a5
 2b8:	f8f74de3          	blt	a4,a5,252 <gets+0x18>
 2bc:	a011                	j	2c0 <gets+0x86>
      break;
 2be:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2c0:	fec42783          	lw	a5,-20(s0)
 2c4:	fd843703          	ld	a4,-40(s0)
 2c8:	97ba                	add	a5,a5,a4
 2ca:	00078023          	sb	zero,0(a5)
  return buf;
 2ce:	fd843783          	ld	a5,-40(s0)
}
 2d2:	853e                	mv	a0,a5
 2d4:	70a2                	ld	ra,40(sp)
 2d6:	7402                	ld	s0,32(sp)
 2d8:	6145                	addi	sp,sp,48
 2da:	8082                	ret

00000000000002dc <stat>:

int
stat(const char *n, struct stat *st)
{
 2dc:	7179                	addi	sp,sp,-48
 2de:	f406                	sd	ra,40(sp)
 2e0:	f022                	sd	s0,32(sp)
 2e2:	1800                	addi	s0,sp,48
 2e4:	fca43c23          	sd	a0,-40(s0)
 2e8:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ec:	4581                	li	a1,0
 2ee:	fd843503          	ld	a0,-40(s0)
 2f2:	00000097          	auipc	ra,0x0
 2f6:	288080e7          	jalr	648(ra) # 57a <open>
 2fa:	87aa                	mv	a5,a0
 2fc:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 300:	fec42783          	lw	a5,-20(s0)
 304:	2781                	sext.w	a5,a5
 306:	0007d463          	bgez	a5,30e <stat+0x32>
    return -1;
 30a:	57fd                	li	a5,-1
 30c:	a035                	j	338 <stat+0x5c>
  r = fstat(fd, st);
 30e:	fec42783          	lw	a5,-20(s0)
 312:	fd043583          	ld	a1,-48(s0)
 316:	853e                	mv	a0,a5
 318:	00000097          	auipc	ra,0x0
 31c:	27a080e7          	jalr	634(ra) # 592 <fstat>
 320:	87aa                	mv	a5,a0
 322:	fef42423          	sw	a5,-24(s0)
  close(fd);
 326:	fec42783          	lw	a5,-20(s0)
 32a:	853e                	mv	a0,a5
 32c:	00000097          	auipc	ra,0x0
 330:	236080e7          	jalr	566(ra) # 562 <close>
  return r;
 334:	fe842783          	lw	a5,-24(s0)
}
 338:	853e                	mv	a0,a5
 33a:	70a2                	ld	ra,40(sp)
 33c:	7402                	ld	s0,32(sp)
 33e:	6145                	addi	sp,sp,48
 340:	8082                	ret

0000000000000342 <atoi>:

int
atoi(const char *s)
{
 342:	7179                	addi	sp,sp,-48
 344:	f422                	sd	s0,40(sp)
 346:	1800                	addi	s0,sp,48
 348:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 34c:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 350:	a815                	j	384 <atoi+0x42>
    n = n*10 + *s++ - '0';
 352:	fec42703          	lw	a4,-20(s0)
 356:	87ba                	mv	a5,a4
 358:	0027979b          	slliw	a5,a5,0x2
 35c:	9fb9                	addw	a5,a5,a4
 35e:	0017979b          	slliw	a5,a5,0x1
 362:	0007871b          	sext.w	a4,a5
 366:	fd843783          	ld	a5,-40(s0)
 36a:	00178693          	addi	a3,a5,1
 36e:	fcd43c23          	sd	a3,-40(s0)
 372:	0007c783          	lbu	a5,0(a5)
 376:	2781                	sext.w	a5,a5
 378:	9fb9                	addw	a5,a5,a4
 37a:	2781                	sext.w	a5,a5
 37c:	fd07879b          	addiw	a5,a5,-48
 380:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 384:	fd843783          	ld	a5,-40(s0)
 388:	0007c783          	lbu	a5,0(a5)
 38c:	873e                	mv	a4,a5
 38e:	02f00793          	li	a5,47
 392:	00e7fb63          	bgeu	a5,a4,3a8 <atoi+0x66>
 396:	fd843783          	ld	a5,-40(s0)
 39a:	0007c783          	lbu	a5,0(a5)
 39e:	873e                	mv	a4,a5
 3a0:	03900793          	li	a5,57
 3a4:	fae7f7e3          	bgeu	a5,a4,352 <atoi+0x10>
  return n;
 3a8:	fec42783          	lw	a5,-20(s0)
}
 3ac:	853e                	mv	a0,a5
 3ae:	7422                	ld	s0,40(sp)
 3b0:	6145                	addi	sp,sp,48
 3b2:	8082                	ret

00000000000003b4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b4:	7139                	addi	sp,sp,-64
 3b6:	fc22                	sd	s0,56(sp)
 3b8:	0080                	addi	s0,sp,64
 3ba:	fca43c23          	sd	a0,-40(s0)
 3be:	fcb43823          	sd	a1,-48(s0)
 3c2:	87b2                	mv	a5,a2
 3c4:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3c8:	fd843783          	ld	a5,-40(s0)
 3cc:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3d0:	fd043783          	ld	a5,-48(s0)
 3d4:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3d8:	fe043703          	ld	a4,-32(s0)
 3dc:	fe843783          	ld	a5,-24(s0)
 3e0:	02e7fc63          	bgeu	a5,a4,418 <memmove+0x64>
    while(n-- > 0)
 3e4:	a00d                	j	406 <memmove+0x52>
      *dst++ = *src++;
 3e6:	fe043703          	ld	a4,-32(s0)
 3ea:	00170793          	addi	a5,a4,1
 3ee:	fef43023          	sd	a5,-32(s0)
 3f2:	fe843783          	ld	a5,-24(s0)
 3f6:	00178693          	addi	a3,a5,1
 3fa:	fed43423          	sd	a3,-24(s0)
 3fe:	00074703          	lbu	a4,0(a4)
 402:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 406:	fcc42783          	lw	a5,-52(s0)
 40a:	fff7871b          	addiw	a4,a5,-1
 40e:	fce42623          	sw	a4,-52(s0)
 412:	fcf04ae3          	bgtz	a5,3e6 <memmove+0x32>
 416:	a891                	j	46a <memmove+0xb6>
  } else {
    dst += n;
 418:	fcc42783          	lw	a5,-52(s0)
 41c:	fe843703          	ld	a4,-24(s0)
 420:	97ba                	add	a5,a5,a4
 422:	fef43423          	sd	a5,-24(s0)
    src += n;
 426:	fcc42783          	lw	a5,-52(s0)
 42a:	fe043703          	ld	a4,-32(s0)
 42e:	97ba                	add	a5,a5,a4
 430:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 434:	a01d                	j	45a <memmove+0xa6>
      *--dst = *--src;
 436:	fe043783          	ld	a5,-32(s0)
 43a:	17fd                	addi	a5,a5,-1
 43c:	fef43023          	sd	a5,-32(s0)
 440:	fe843783          	ld	a5,-24(s0)
 444:	17fd                	addi	a5,a5,-1
 446:	fef43423          	sd	a5,-24(s0)
 44a:	fe043783          	ld	a5,-32(s0)
 44e:	0007c703          	lbu	a4,0(a5)
 452:	fe843783          	ld	a5,-24(s0)
 456:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 45a:	fcc42783          	lw	a5,-52(s0)
 45e:	fff7871b          	addiw	a4,a5,-1
 462:	fce42623          	sw	a4,-52(s0)
 466:	fcf048e3          	bgtz	a5,436 <memmove+0x82>
  }
  return vdst;
 46a:	fd843783          	ld	a5,-40(s0)
}
 46e:	853e                	mv	a0,a5
 470:	7462                	ld	s0,56(sp)
 472:	6121                	addi	sp,sp,64
 474:	8082                	ret

0000000000000476 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 476:	7139                	addi	sp,sp,-64
 478:	fc22                	sd	s0,56(sp)
 47a:	0080                	addi	s0,sp,64
 47c:	fca43c23          	sd	a0,-40(s0)
 480:	fcb43823          	sd	a1,-48(s0)
 484:	87b2                	mv	a5,a2
 486:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 48a:	fd843783          	ld	a5,-40(s0)
 48e:	fef43423          	sd	a5,-24(s0)
 492:	fd043783          	ld	a5,-48(s0)
 496:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 49a:	a0a1                	j	4e2 <memcmp+0x6c>
    if (*p1 != *p2) {
 49c:	fe843783          	ld	a5,-24(s0)
 4a0:	0007c703          	lbu	a4,0(a5)
 4a4:	fe043783          	ld	a5,-32(s0)
 4a8:	0007c783          	lbu	a5,0(a5)
 4ac:	02f70163          	beq	a4,a5,4ce <memcmp+0x58>
      return *p1 - *p2;
 4b0:	fe843783          	ld	a5,-24(s0)
 4b4:	0007c783          	lbu	a5,0(a5)
 4b8:	0007871b          	sext.w	a4,a5
 4bc:	fe043783          	ld	a5,-32(s0)
 4c0:	0007c783          	lbu	a5,0(a5)
 4c4:	2781                	sext.w	a5,a5
 4c6:	40f707bb          	subw	a5,a4,a5
 4ca:	2781                	sext.w	a5,a5
 4cc:	a01d                	j	4f2 <memcmp+0x7c>
    }
    p1++;
 4ce:	fe843783          	ld	a5,-24(s0)
 4d2:	0785                	addi	a5,a5,1
 4d4:	fef43423          	sd	a5,-24(s0)
    p2++;
 4d8:	fe043783          	ld	a5,-32(s0)
 4dc:	0785                	addi	a5,a5,1
 4de:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4e2:	fcc42783          	lw	a5,-52(s0)
 4e6:	fff7871b          	addiw	a4,a5,-1
 4ea:	fce42623          	sw	a4,-52(s0)
 4ee:	f7dd                	bnez	a5,49c <memcmp+0x26>
  }
  return 0;
 4f0:	4781                	li	a5,0
}
 4f2:	853e                	mv	a0,a5
 4f4:	7462                	ld	s0,56(sp)
 4f6:	6121                	addi	sp,sp,64
 4f8:	8082                	ret

00000000000004fa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4fa:	7179                	addi	sp,sp,-48
 4fc:	f406                	sd	ra,40(sp)
 4fe:	f022                	sd	s0,32(sp)
 500:	1800                	addi	s0,sp,48
 502:	fea43423          	sd	a0,-24(s0)
 506:	feb43023          	sd	a1,-32(s0)
 50a:	87b2                	mv	a5,a2
 50c:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 510:	fdc42783          	lw	a5,-36(s0)
 514:	863e                	mv	a2,a5
 516:	fe043583          	ld	a1,-32(s0)
 51a:	fe843503          	ld	a0,-24(s0)
 51e:	00000097          	auipc	ra,0x0
 522:	e96080e7          	jalr	-362(ra) # 3b4 <memmove>
 526:	87aa                	mv	a5,a0
}
 528:	853e                	mv	a0,a5
 52a:	70a2                	ld	ra,40(sp)
 52c:	7402                	ld	s0,32(sp)
 52e:	6145                	addi	sp,sp,48
 530:	8082                	ret

0000000000000532 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 532:	4885                	li	a7,1
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <exit>:
.global exit
exit:
 li a7, SYS_exit
 53a:	4889                	li	a7,2
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <wait>:
.global wait
wait:
 li a7, SYS_wait
 542:	488d                	li	a7,3
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 54a:	4891                	li	a7,4
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <read>:
.global read
read:
 li a7, SYS_read
 552:	4895                	li	a7,5
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <write>:
.global write
write:
 li a7, SYS_write
 55a:	48c1                	li	a7,16
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <close>:
.global close
close:
 li a7, SYS_close
 562:	48d5                	li	a7,21
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <kill>:
.global kill
kill:
 li a7, SYS_kill
 56a:	4899                	li	a7,6
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <exec>:
.global exec
exec:
 li a7, SYS_exec
 572:	489d                	li	a7,7
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <open>:
.global open
open:
 li a7, SYS_open
 57a:	48bd                	li	a7,15
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 582:	48c5                	li	a7,17
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 58a:	48c9                	li	a7,18
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 592:	48a1                	li	a7,8
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <link>:
.global link
link:
 li a7, SYS_link
 59a:	48cd                	li	a7,19
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5a2:	48d1                	li	a7,20
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5aa:	48a5                	li	a7,9
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5b2:	48a9                	li	a7,10
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5ba:	48ad                	li	a7,11
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5c2:	48b1                	li	a7,12
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5ca:	48b5                	li	a7,13
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5d2:	48b9                	li	a7,14
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 5da:	48d9                	li	a7,22
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <setpri>:
.global setpri
setpri:
 li a7, SYS_setpri
 5e2:	48dd                	li	a7,23
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5ea:	1101                	addi	sp,sp,-32
 5ec:	ec06                	sd	ra,24(sp)
 5ee:	e822                	sd	s0,16(sp)
 5f0:	1000                	addi	s0,sp,32
 5f2:	87aa                	mv	a5,a0
 5f4:	872e                	mv	a4,a1
 5f6:	fef42623          	sw	a5,-20(s0)
 5fa:	87ba                	mv	a5,a4
 5fc:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 600:	feb40713          	addi	a4,s0,-21
 604:	fec42783          	lw	a5,-20(s0)
 608:	4605                	li	a2,1
 60a:	85ba                	mv	a1,a4
 60c:	853e                	mv	a0,a5
 60e:	00000097          	auipc	ra,0x0
 612:	f4c080e7          	jalr	-180(ra) # 55a <write>
}
 616:	0001                	nop
 618:	60e2                	ld	ra,24(sp)
 61a:	6442                	ld	s0,16(sp)
 61c:	6105                	addi	sp,sp,32
 61e:	8082                	ret

0000000000000620 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 620:	7139                	addi	sp,sp,-64
 622:	fc06                	sd	ra,56(sp)
 624:	f822                	sd	s0,48(sp)
 626:	0080                	addi	s0,sp,64
 628:	87aa                	mv	a5,a0
 62a:	8736                	mv	a4,a3
 62c:	fcf42623          	sw	a5,-52(s0)
 630:	87ae                	mv	a5,a1
 632:	fcf42423          	sw	a5,-56(s0)
 636:	87b2                	mv	a5,a2
 638:	fcf42223          	sw	a5,-60(s0)
 63c:	87ba                	mv	a5,a4
 63e:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 642:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 646:	fc042783          	lw	a5,-64(s0)
 64a:	2781                	sext.w	a5,a5
 64c:	c38d                	beqz	a5,66e <printint+0x4e>
 64e:	fc842783          	lw	a5,-56(s0)
 652:	2781                	sext.w	a5,a5
 654:	0007dd63          	bgez	a5,66e <printint+0x4e>
    neg = 1;
 658:	4785                	li	a5,1
 65a:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 65e:	fc842783          	lw	a5,-56(s0)
 662:	40f007bb          	negw	a5,a5
 666:	2781                	sext.w	a5,a5
 668:	fef42223          	sw	a5,-28(s0)
 66c:	a029                	j	676 <printint+0x56>
  } else {
    x = xx;
 66e:	fc842783          	lw	a5,-56(s0)
 672:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 676:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 67a:	fc442783          	lw	a5,-60(s0)
 67e:	fe442703          	lw	a4,-28(s0)
 682:	02f777bb          	remuw	a5,a4,a5
 686:	0007861b          	sext.w	a2,a5
 68a:	fec42783          	lw	a5,-20(s0)
 68e:	0017871b          	addiw	a4,a5,1
 692:	fee42623          	sw	a4,-20(s0)
 696:	00000697          	auipc	a3,0x0
 69a:	75268693          	addi	a3,a3,1874 # de8 <digits>
 69e:	02061713          	slli	a4,a2,0x20
 6a2:	9301                	srli	a4,a4,0x20
 6a4:	9736                	add	a4,a4,a3
 6a6:	00074703          	lbu	a4,0(a4)
 6aa:	ff040693          	addi	a3,s0,-16
 6ae:	97b6                	add	a5,a5,a3
 6b0:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 6b4:	fc442783          	lw	a5,-60(s0)
 6b8:	fe442703          	lw	a4,-28(s0)
 6bc:	02f757bb          	divuw	a5,a4,a5
 6c0:	fef42223          	sw	a5,-28(s0)
 6c4:	fe442783          	lw	a5,-28(s0)
 6c8:	2781                	sext.w	a5,a5
 6ca:	fbc5                	bnez	a5,67a <printint+0x5a>
  if(neg)
 6cc:	fe842783          	lw	a5,-24(s0)
 6d0:	2781                	sext.w	a5,a5
 6d2:	cf95                	beqz	a5,70e <printint+0xee>
    buf[i++] = '-';
 6d4:	fec42783          	lw	a5,-20(s0)
 6d8:	0017871b          	addiw	a4,a5,1
 6dc:	fee42623          	sw	a4,-20(s0)
 6e0:	ff040713          	addi	a4,s0,-16
 6e4:	97ba                	add	a5,a5,a4
 6e6:	02d00713          	li	a4,45
 6ea:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6ee:	a005                	j	70e <printint+0xee>
    putc(fd, buf[i]);
 6f0:	fec42783          	lw	a5,-20(s0)
 6f4:	ff040713          	addi	a4,s0,-16
 6f8:	97ba                	add	a5,a5,a4
 6fa:	fe07c703          	lbu	a4,-32(a5)
 6fe:	fcc42783          	lw	a5,-52(s0)
 702:	85ba                	mv	a1,a4
 704:	853e                	mv	a0,a5
 706:	00000097          	auipc	ra,0x0
 70a:	ee4080e7          	jalr	-284(ra) # 5ea <putc>
  while(--i >= 0)
 70e:	fec42783          	lw	a5,-20(s0)
 712:	37fd                	addiw	a5,a5,-1
 714:	fef42623          	sw	a5,-20(s0)
 718:	fec42783          	lw	a5,-20(s0)
 71c:	2781                	sext.w	a5,a5
 71e:	fc07d9e3          	bgez	a5,6f0 <printint+0xd0>
}
 722:	0001                	nop
 724:	0001                	nop
 726:	70e2                	ld	ra,56(sp)
 728:	7442                	ld	s0,48(sp)
 72a:	6121                	addi	sp,sp,64
 72c:	8082                	ret

000000000000072e <printptr>:

static void
printptr(int fd, uint64 x) {
 72e:	7179                	addi	sp,sp,-48
 730:	f406                	sd	ra,40(sp)
 732:	f022                	sd	s0,32(sp)
 734:	1800                	addi	s0,sp,48
 736:	87aa                	mv	a5,a0
 738:	fcb43823          	sd	a1,-48(s0)
 73c:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 740:	fdc42783          	lw	a5,-36(s0)
 744:	03000593          	li	a1,48
 748:	853e                	mv	a0,a5
 74a:	00000097          	auipc	ra,0x0
 74e:	ea0080e7          	jalr	-352(ra) # 5ea <putc>
  putc(fd, 'x');
 752:	fdc42783          	lw	a5,-36(s0)
 756:	07800593          	li	a1,120
 75a:	853e                	mv	a0,a5
 75c:	00000097          	auipc	ra,0x0
 760:	e8e080e7          	jalr	-370(ra) # 5ea <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 764:	fe042623          	sw	zero,-20(s0)
 768:	a82d                	j	7a2 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 76a:	fd043783          	ld	a5,-48(s0)
 76e:	93f1                	srli	a5,a5,0x3c
 770:	00000717          	auipc	a4,0x0
 774:	67870713          	addi	a4,a4,1656 # de8 <digits>
 778:	97ba                	add	a5,a5,a4
 77a:	0007c703          	lbu	a4,0(a5)
 77e:	fdc42783          	lw	a5,-36(s0)
 782:	85ba                	mv	a1,a4
 784:	853e                	mv	a0,a5
 786:	00000097          	auipc	ra,0x0
 78a:	e64080e7          	jalr	-412(ra) # 5ea <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 78e:	fec42783          	lw	a5,-20(s0)
 792:	2785                	addiw	a5,a5,1
 794:	fef42623          	sw	a5,-20(s0)
 798:	fd043783          	ld	a5,-48(s0)
 79c:	0792                	slli	a5,a5,0x4
 79e:	fcf43823          	sd	a5,-48(s0)
 7a2:	fec42783          	lw	a5,-20(s0)
 7a6:	873e                	mv	a4,a5
 7a8:	47bd                	li	a5,15
 7aa:	fce7f0e3          	bgeu	a5,a4,76a <printptr+0x3c>
}
 7ae:	0001                	nop
 7b0:	0001                	nop
 7b2:	70a2                	ld	ra,40(sp)
 7b4:	7402                	ld	s0,32(sp)
 7b6:	6145                	addi	sp,sp,48
 7b8:	8082                	ret

00000000000007ba <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7ba:	715d                	addi	sp,sp,-80
 7bc:	e486                	sd	ra,72(sp)
 7be:	e0a2                	sd	s0,64(sp)
 7c0:	0880                	addi	s0,sp,80
 7c2:	87aa                	mv	a5,a0
 7c4:	fcb43023          	sd	a1,-64(s0)
 7c8:	fac43c23          	sd	a2,-72(s0)
 7cc:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 7d0:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7d4:	fe042223          	sw	zero,-28(s0)
 7d8:	a42d                	j	a02 <vprintf+0x248>
    c = fmt[i] & 0xff;
 7da:	fe442783          	lw	a5,-28(s0)
 7de:	fc043703          	ld	a4,-64(s0)
 7e2:	97ba                	add	a5,a5,a4
 7e4:	0007c783          	lbu	a5,0(a5)
 7e8:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7ec:	fe042783          	lw	a5,-32(s0)
 7f0:	2781                	sext.w	a5,a5
 7f2:	eb9d                	bnez	a5,828 <vprintf+0x6e>
      if(c == '%'){
 7f4:	fdc42783          	lw	a5,-36(s0)
 7f8:	0007871b          	sext.w	a4,a5
 7fc:	02500793          	li	a5,37
 800:	00f71763          	bne	a4,a5,80e <vprintf+0x54>
        state = '%';
 804:	02500793          	li	a5,37
 808:	fef42023          	sw	a5,-32(s0)
 80c:	a2f5                	j	9f8 <vprintf+0x23e>
      } else {
        putc(fd, c);
 80e:	fdc42783          	lw	a5,-36(s0)
 812:	0ff7f713          	andi	a4,a5,255
 816:	fcc42783          	lw	a5,-52(s0)
 81a:	85ba                	mv	a1,a4
 81c:	853e                	mv	a0,a5
 81e:	00000097          	auipc	ra,0x0
 822:	dcc080e7          	jalr	-564(ra) # 5ea <putc>
 826:	aac9                	j	9f8 <vprintf+0x23e>
      }
    } else if(state == '%'){
 828:	fe042783          	lw	a5,-32(s0)
 82c:	0007871b          	sext.w	a4,a5
 830:	02500793          	li	a5,37
 834:	1cf71263          	bne	a4,a5,9f8 <vprintf+0x23e>
      if(c == 'd'){
 838:	fdc42783          	lw	a5,-36(s0)
 83c:	0007871b          	sext.w	a4,a5
 840:	06400793          	li	a5,100
 844:	02f71463          	bne	a4,a5,86c <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 848:	fb843783          	ld	a5,-72(s0)
 84c:	00878713          	addi	a4,a5,8
 850:	fae43c23          	sd	a4,-72(s0)
 854:	4398                	lw	a4,0(a5)
 856:	fcc42783          	lw	a5,-52(s0)
 85a:	4685                	li	a3,1
 85c:	4629                	li	a2,10
 85e:	85ba                	mv	a1,a4
 860:	853e                	mv	a0,a5
 862:	00000097          	auipc	ra,0x0
 866:	dbe080e7          	jalr	-578(ra) # 620 <printint>
 86a:	a269                	j	9f4 <vprintf+0x23a>
      } else if(c == 'l') {
 86c:	fdc42783          	lw	a5,-36(s0)
 870:	0007871b          	sext.w	a4,a5
 874:	06c00793          	li	a5,108
 878:	02f71663          	bne	a4,a5,8a4 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 87c:	fb843783          	ld	a5,-72(s0)
 880:	00878713          	addi	a4,a5,8
 884:	fae43c23          	sd	a4,-72(s0)
 888:	639c                	ld	a5,0(a5)
 88a:	0007871b          	sext.w	a4,a5
 88e:	fcc42783          	lw	a5,-52(s0)
 892:	4681                	li	a3,0
 894:	4629                	li	a2,10
 896:	85ba                	mv	a1,a4
 898:	853e                	mv	a0,a5
 89a:	00000097          	auipc	ra,0x0
 89e:	d86080e7          	jalr	-634(ra) # 620 <printint>
 8a2:	aa89                	j	9f4 <vprintf+0x23a>
      } else if(c == 'x') {
 8a4:	fdc42783          	lw	a5,-36(s0)
 8a8:	0007871b          	sext.w	a4,a5
 8ac:	07800793          	li	a5,120
 8b0:	02f71463          	bne	a4,a5,8d8 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 8b4:	fb843783          	ld	a5,-72(s0)
 8b8:	00878713          	addi	a4,a5,8
 8bc:	fae43c23          	sd	a4,-72(s0)
 8c0:	4398                	lw	a4,0(a5)
 8c2:	fcc42783          	lw	a5,-52(s0)
 8c6:	4681                	li	a3,0
 8c8:	4641                	li	a2,16
 8ca:	85ba                	mv	a1,a4
 8cc:	853e                	mv	a0,a5
 8ce:	00000097          	auipc	ra,0x0
 8d2:	d52080e7          	jalr	-686(ra) # 620 <printint>
 8d6:	aa39                	j	9f4 <vprintf+0x23a>
      } else if(c == 'p') {
 8d8:	fdc42783          	lw	a5,-36(s0)
 8dc:	0007871b          	sext.w	a4,a5
 8e0:	07000793          	li	a5,112
 8e4:	02f71263          	bne	a4,a5,908 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8e8:	fb843783          	ld	a5,-72(s0)
 8ec:	00878713          	addi	a4,a5,8
 8f0:	fae43c23          	sd	a4,-72(s0)
 8f4:	6398                	ld	a4,0(a5)
 8f6:	fcc42783          	lw	a5,-52(s0)
 8fa:	85ba                	mv	a1,a4
 8fc:	853e                	mv	a0,a5
 8fe:	00000097          	auipc	ra,0x0
 902:	e30080e7          	jalr	-464(ra) # 72e <printptr>
 906:	a0fd                	j	9f4 <vprintf+0x23a>
      } else if(c == 's'){
 908:	fdc42783          	lw	a5,-36(s0)
 90c:	0007871b          	sext.w	a4,a5
 910:	07300793          	li	a5,115
 914:	04f71c63          	bne	a4,a5,96c <vprintf+0x1b2>
        s = va_arg(ap, char*);
 918:	fb843783          	ld	a5,-72(s0)
 91c:	00878713          	addi	a4,a5,8
 920:	fae43c23          	sd	a4,-72(s0)
 924:	639c                	ld	a5,0(a5)
 926:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 92a:	fe843783          	ld	a5,-24(s0)
 92e:	eb8d                	bnez	a5,960 <vprintf+0x1a6>
          s = "(null)";
 930:	00000797          	auipc	a5,0x0
 934:	4b078793          	addi	a5,a5,1200 # de0 <malloc+0x176>
 938:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 93c:	a015                	j	960 <vprintf+0x1a6>
          putc(fd, *s);
 93e:	fe843783          	ld	a5,-24(s0)
 942:	0007c703          	lbu	a4,0(a5)
 946:	fcc42783          	lw	a5,-52(s0)
 94a:	85ba                	mv	a1,a4
 94c:	853e                	mv	a0,a5
 94e:	00000097          	auipc	ra,0x0
 952:	c9c080e7          	jalr	-868(ra) # 5ea <putc>
          s++;
 956:	fe843783          	ld	a5,-24(s0)
 95a:	0785                	addi	a5,a5,1
 95c:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 960:	fe843783          	ld	a5,-24(s0)
 964:	0007c783          	lbu	a5,0(a5)
 968:	fbf9                	bnez	a5,93e <vprintf+0x184>
 96a:	a069                	j	9f4 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 96c:	fdc42783          	lw	a5,-36(s0)
 970:	0007871b          	sext.w	a4,a5
 974:	06300793          	li	a5,99
 978:	02f71463          	bne	a4,a5,9a0 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 97c:	fb843783          	ld	a5,-72(s0)
 980:	00878713          	addi	a4,a5,8
 984:	fae43c23          	sd	a4,-72(s0)
 988:	439c                	lw	a5,0(a5)
 98a:	0ff7f713          	andi	a4,a5,255
 98e:	fcc42783          	lw	a5,-52(s0)
 992:	85ba                	mv	a1,a4
 994:	853e                	mv	a0,a5
 996:	00000097          	auipc	ra,0x0
 99a:	c54080e7          	jalr	-940(ra) # 5ea <putc>
 99e:	a899                	j	9f4 <vprintf+0x23a>
      } else if(c == '%'){
 9a0:	fdc42783          	lw	a5,-36(s0)
 9a4:	0007871b          	sext.w	a4,a5
 9a8:	02500793          	li	a5,37
 9ac:	00f71f63          	bne	a4,a5,9ca <vprintf+0x210>
        putc(fd, c);
 9b0:	fdc42783          	lw	a5,-36(s0)
 9b4:	0ff7f713          	andi	a4,a5,255
 9b8:	fcc42783          	lw	a5,-52(s0)
 9bc:	85ba                	mv	a1,a4
 9be:	853e                	mv	a0,a5
 9c0:	00000097          	auipc	ra,0x0
 9c4:	c2a080e7          	jalr	-982(ra) # 5ea <putc>
 9c8:	a035                	j	9f4 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9ca:	fcc42783          	lw	a5,-52(s0)
 9ce:	02500593          	li	a1,37
 9d2:	853e                	mv	a0,a5
 9d4:	00000097          	auipc	ra,0x0
 9d8:	c16080e7          	jalr	-1002(ra) # 5ea <putc>
        putc(fd, c);
 9dc:	fdc42783          	lw	a5,-36(s0)
 9e0:	0ff7f713          	andi	a4,a5,255
 9e4:	fcc42783          	lw	a5,-52(s0)
 9e8:	85ba                	mv	a1,a4
 9ea:	853e                	mv	a0,a5
 9ec:	00000097          	auipc	ra,0x0
 9f0:	bfe080e7          	jalr	-1026(ra) # 5ea <putc>
      }
      state = 0;
 9f4:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 9f8:	fe442783          	lw	a5,-28(s0)
 9fc:	2785                	addiw	a5,a5,1
 9fe:	fef42223          	sw	a5,-28(s0)
 a02:	fe442783          	lw	a5,-28(s0)
 a06:	fc043703          	ld	a4,-64(s0)
 a0a:	97ba                	add	a5,a5,a4
 a0c:	0007c783          	lbu	a5,0(a5)
 a10:	dc0795e3          	bnez	a5,7da <vprintf+0x20>
    }
  }
}
 a14:	0001                	nop
 a16:	0001                	nop
 a18:	60a6                	ld	ra,72(sp)
 a1a:	6406                	ld	s0,64(sp)
 a1c:	6161                	addi	sp,sp,80
 a1e:	8082                	ret

0000000000000a20 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a20:	7159                	addi	sp,sp,-112
 a22:	fc06                	sd	ra,56(sp)
 a24:	f822                	sd	s0,48(sp)
 a26:	0080                	addi	s0,sp,64
 a28:	fcb43823          	sd	a1,-48(s0)
 a2c:	e010                	sd	a2,0(s0)
 a2e:	e414                	sd	a3,8(s0)
 a30:	e818                	sd	a4,16(s0)
 a32:	ec1c                	sd	a5,24(s0)
 a34:	03043023          	sd	a6,32(s0)
 a38:	03143423          	sd	a7,40(s0)
 a3c:	87aa                	mv	a5,a0
 a3e:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a42:	03040793          	addi	a5,s0,48
 a46:	fcf43423          	sd	a5,-56(s0)
 a4a:	fc843783          	ld	a5,-56(s0)
 a4e:	fd078793          	addi	a5,a5,-48
 a52:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a56:	fe843703          	ld	a4,-24(s0)
 a5a:	fdc42783          	lw	a5,-36(s0)
 a5e:	863a                	mv	a2,a4
 a60:	fd043583          	ld	a1,-48(s0)
 a64:	853e                	mv	a0,a5
 a66:	00000097          	auipc	ra,0x0
 a6a:	d54080e7          	jalr	-684(ra) # 7ba <vprintf>
}
 a6e:	0001                	nop
 a70:	70e2                	ld	ra,56(sp)
 a72:	7442                	ld	s0,48(sp)
 a74:	6165                	addi	sp,sp,112
 a76:	8082                	ret

0000000000000a78 <printf>:

void
printf(const char *fmt, ...)
{
 a78:	7159                	addi	sp,sp,-112
 a7a:	f406                	sd	ra,40(sp)
 a7c:	f022                	sd	s0,32(sp)
 a7e:	1800                	addi	s0,sp,48
 a80:	fca43c23          	sd	a0,-40(s0)
 a84:	e40c                	sd	a1,8(s0)
 a86:	e810                	sd	a2,16(s0)
 a88:	ec14                	sd	a3,24(s0)
 a8a:	f018                	sd	a4,32(s0)
 a8c:	f41c                	sd	a5,40(s0)
 a8e:	03043823          	sd	a6,48(s0)
 a92:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a96:	04040793          	addi	a5,s0,64
 a9a:	fcf43823          	sd	a5,-48(s0)
 a9e:	fd043783          	ld	a5,-48(s0)
 aa2:	fc878793          	addi	a5,a5,-56
 aa6:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 aaa:	fe843783          	ld	a5,-24(s0)
 aae:	863e                	mv	a2,a5
 ab0:	fd843583          	ld	a1,-40(s0)
 ab4:	4505                	li	a0,1
 ab6:	00000097          	auipc	ra,0x0
 aba:	d04080e7          	jalr	-764(ra) # 7ba <vprintf>
}
 abe:	0001                	nop
 ac0:	70a2                	ld	ra,40(sp)
 ac2:	7402                	ld	s0,32(sp)
 ac4:	6165                	addi	sp,sp,112
 ac6:	8082                	ret

0000000000000ac8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ac8:	7179                	addi	sp,sp,-48
 aca:	f422                	sd	s0,40(sp)
 acc:	1800                	addi	s0,sp,48
 ace:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ad2:	fd843783          	ld	a5,-40(s0)
 ad6:	17c1                	addi	a5,a5,-16
 ad8:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 adc:	00000797          	auipc	a5,0x0
 ae0:	33478793          	addi	a5,a5,820 # e10 <freep>
 ae4:	639c                	ld	a5,0(a5)
 ae6:	fef43423          	sd	a5,-24(s0)
 aea:	a815                	j	b1e <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aec:	fe843783          	ld	a5,-24(s0)
 af0:	639c                	ld	a5,0(a5)
 af2:	fe843703          	ld	a4,-24(s0)
 af6:	00f76f63          	bltu	a4,a5,b14 <free+0x4c>
 afa:	fe043703          	ld	a4,-32(s0)
 afe:	fe843783          	ld	a5,-24(s0)
 b02:	02e7eb63          	bltu	a5,a4,b38 <free+0x70>
 b06:	fe843783          	ld	a5,-24(s0)
 b0a:	639c                	ld	a5,0(a5)
 b0c:	fe043703          	ld	a4,-32(s0)
 b10:	02f76463          	bltu	a4,a5,b38 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b14:	fe843783          	ld	a5,-24(s0)
 b18:	639c                	ld	a5,0(a5)
 b1a:	fef43423          	sd	a5,-24(s0)
 b1e:	fe043703          	ld	a4,-32(s0)
 b22:	fe843783          	ld	a5,-24(s0)
 b26:	fce7f3e3          	bgeu	a5,a4,aec <free+0x24>
 b2a:	fe843783          	ld	a5,-24(s0)
 b2e:	639c                	ld	a5,0(a5)
 b30:	fe043703          	ld	a4,-32(s0)
 b34:	faf77ce3          	bgeu	a4,a5,aec <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b38:	fe043783          	ld	a5,-32(s0)
 b3c:	479c                	lw	a5,8(a5)
 b3e:	1782                	slli	a5,a5,0x20
 b40:	9381                	srli	a5,a5,0x20
 b42:	0792                	slli	a5,a5,0x4
 b44:	fe043703          	ld	a4,-32(s0)
 b48:	973e                	add	a4,a4,a5
 b4a:	fe843783          	ld	a5,-24(s0)
 b4e:	639c                	ld	a5,0(a5)
 b50:	02f71763          	bne	a4,a5,b7e <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b54:	fe043783          	ld	a5,-32(s0)
 b58:	4798                	lw	a4,8(a5)
 b5a:	fe843783          	ld	a5,-24(s0)
 b5e:	639c                	ld	a5,0(a5)
 b60:	479c                	lw	a5,8(a5)
 b62:	9fb9                	addw	a5,a5,a4
 b64:	0007871b          	sext.w	a4,a5
 b68:	fe043783          	ld	a5,-32(s0)
 b6c:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b6e:	fe843783          	ld	a5,-24(s0)
 b72:	639c                	ld	a5,0(a5)
 b74:	6398                	ld	a4,0(a5)
 b76:	fe043783          	ld	a5,-32(s0)
 b7a:	e398                	sd	a4,0(a5)
 b7c:	a039                	j	b8a <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b7e:	fe843783          	ld	a5,-24(s0)
 b82:	6398                	ld	a4,0(a5)
 b84:	fe043783          	ld	a5,-32(s0)
 b88:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b8a:	fe843783          	ld	a5,-24(s0)
 b8e:	479c                	lw	a5,8(a5)
 b90:	1782                	slli	a5,a5,0x20
 b92:	9381                	srli	a5,a5,0x20
 b94:	0792                	slli	a5,a5,0x4
 b96:	fe843703          	ld	a4,-24(s0)
 b9a:	97ba                	add	a5,a5,a4
 b9c:	fe043703          	ld	a4,-32(s0)
 ba0:	02f71563          	bne	a4,a5,bca <free+0x102>
    p->s.size += bp->s.size;
 ba4:	fe843783          	ld	a5,-24(s0)
 ba8:	4798                	lw	a4,8(a5)
 baa:	fe043783          	ld	a5,-32(s0)
 bae:	479c                	lw	a5,8(a5)
 bb0:	9fb9                	addw	a5,a5,a4
 bb2:	0007871b          	sext.w	a4,a5
 bb6:	fe843783          	ld	a5,-24(s0)
 bba:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bbc:	fe043783          	ld	a5,-32(s0)
 bc0:	6398                	ld	a4,0(a5)
 bc2:	fe843783          	ld	a5,-24(s0)
 bc6:	e398                	sd	a4,0(a5)
 bc8:	a031                	j	bd4 <free+0x10c>
  } else
    p->s.ptr = bp;
 bca:	fe843783          	ld	a5,-24(s0)
 bce:	fe043703          	ld	a4,-32(s0)
 bd2:	e398                	sd	a4,0(a5)
  freep = p;
 bd4:	00000797          	auipc	a5,0x0
 bd8:	23c78793          	addi	a5,a5,572 # e10 <freep>
 bdc:	fe843703          	ld	a4,-24(s0)
 be0:	e398                	sd	a4,0(a5)
}
 be2:	0001                	nop
 be4:	7422                	ld	s0,40(sp)
 be6:	6145                	addi	sp,sp,48
 be8:	8082                	ret

0000000000000bea <morecore>:

static Header*
morecore(uint nu)
{
 bea:	7179                	addi	sp,sp,-48
 bec:	f406                	sd	ra,40(sp)
 bee:	f022                	sd	s0,32(sp)
 bf0:	1800                	addi	s0,sp,48
 bf2:	87aa                	mv	a5,a0
 bf4:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 bf8:	fdc42783          	lw	a5,-36(s0)
 bfc:	0007871b          	sext.w	a4,a5
 c00:	6785                	lui	a5,0x1
 c02:	00f77563          	bgeu	a4,a5,c0c <morecore+0x22>
    nu = 4096;
 c06:	6785                	lui	a5,0x1
 c08:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c0c:	fdc42783          	lw	a5,-36(s0)
 c10:	0047979b          	slliw	a5,a5,0x4
 c14:	2781                	sext.w	a5,a5
 c16:	2781                	sext.w	a5,a5
 c18:	853e                	mv	a0,a5
 c1a:	00000097          	auipc	ra,0x0
 c1e:	9a8080e7          	jalr	-1624(ra) # 5c2 <sbrk>
 c22:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c26:	fe843703          	ld	a4,-24(s0)
 c2a:	57fd                	li	a5,-1
 c2c:	00f71463          	bne	a4,a5,c34 <morecore+0x4a>
    return 0;
 c30:	4781                	li	a5,0
 c32:	a03d                	j	c60 <morecore+0x76>
  hp = (Header*)p;
 c34:	fe843783          	ld	a5,-24(s0)
 c38:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c3c:	fe043783          	ld	a5,-32(s0)
 c40:	fdc42703          	lw	a4,-36(s0)
 c44:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c46:	fe043783          	ld	a5,-32(s0)
 c4a:	07c1                	addi	a5,a5,16
 c4c:	853e                	mv	a0,a5
 c4e:	00000097          	auipc	ra,0x0
 c52:	e7a080e7          	jalr	-390(ra) # ac8 <free>
  return freep;
 c56:	00000797          	auipc	a5,0x0
 c5a:	1ba78793          	addi	a5,a5,442 # e10 <freep>
 c5e:	639c                	ld	a5,0(a5)
}
 c60:	853e                	mv	a0,a5
 c62:	70a2                	ld	ra,40(sp)
 c64:	7402                	ld	s0,32(sp)
 c66:	6145                	addi	sp,sp,48
 c68:	8082                	ret

0000000000000c6a <malloc>:

void*
malloc(uint nbytes)
{
 c6a:	7139                	addi	sp,sp,-64
 c6c:	fc06                	sd	ra,56(sp)
 c6e:	f822                	sd	s0,48(sp)
 c70:	0080                	addi	s0,sp,64
 c72:	87aa                	mv	a5,a0
 c74:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c78:	fcc46783          	lwu	a5,-52(s0)
 c7c:	07bd                	addi	a5,a5,15
 c7e:	8391                	srli	a5,a5,0x4
 c80:	2781                	sext.w	a5,a5
 c82:	2785                	addiw	a5,a5,1
 c84:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c88:	00000797          	auipc	a5,0x0
 c8c:	18878793          	addi	a5,a5,392 # e10 <freep>
 c90:	639c                	ld	a5,0(a5)
 c92:	fef43023          	sd	a5,-32(s0)
 c96:	fe043783          	ld	a5,-32(s0)
 c9a:	ef95                	bnez	a5,cd6 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c9c:	00000797          	auipc	a5,0x0
 ca0:	16478793          	addi	a5,a5,356 # e00 <base>
 ca4:	fef43023          	sd	a5,-32(s0)
 ca8:	00000797          	auipc	a5,0x0
 cac:	16878793          	addi	a5,a5,360 # e10 <freep>
 cb0:	fe043703          	ld	a4,-32(s0)
 cb4:	e398                	sd	a4,0(a5)
 cb6:	00000797          	auipc	a5,0x0
 cba:	15a78793          	addi	a5,a5,346 # e10 <freep>
 cbe:	6398                	ld	a4,0(a5)
 cc0:	00000797          	auipc	a5,0x0
 cc4:	14078793          	addi	a5,a5,320 # e00 <base>
 cc8:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 cca:	00000797          	auipc	a5,0x0
 cce:	13678793          	addi	a5,a5,310 # e00 <base>
 cd2:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cd6:	fe043783          	ld	a5,-32(s0)
 cda:	639c                	ld	a5,0(a5)
 cdc:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 ce0:	fe843783          	ld	a5,-24(s0)
 ce4:	4798                	lw	a4,8(a5)
 ce6:	fdc42783          	lw	a5,-36(s0)
 cea:	2781                	sext.w	a5,a5
 cec:	06f76863          	bltu	a4,a5,d5c <malloc+0xf2>
      if(p->s.size == nunits)
 cf0:	fe843783          	ld	a5,-24(s0)
 cf4:	4798                	lw	a4,8(a5)
 cf6:	fdc42783          	lw	a5,-36(s0)
 cfa:	2781                	sext.w	a5,a5
 cfc:	00e79963          	bne	a5,a4,d0e <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d00:	fe843783          	ld	a5,-24(s0)
 d04:	6398                	ld	a4,0(a5)
 d06:	fe043783          	ld	a5,-32(s0)
 d0a:	e398                	sd	a4,0(a5)
 d0c:	a82d                	j	d46 <malloc+0xdc>
      else {
        p->s.size -= nunits;
 d0e:	fe843783          	ld	a5,-24(s0)
 d12:	4798                	lw	a4,8(a5)
 d14:	fdc42783          	lw	a5,-36(s0)
 d18:	40f707bb          	subw	a5,a4,a5
 d1c:	0007871b          	sext.w	a4,a5
 d20:	fe843783          	ld	a5,-24(s0)
 d24:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d26:	fe843783          	ld	a5,-24(s0)
 d2a:	479c                	lw	a5,8(a5)
 d2c:	1782                	slli	a5,a5,0x20
 d2e:	9381                	srli	a5,a5,0x20
 d30:	0792                	slli	a5,a5,0x4
 d32:	fe843703          	ld	a4,-24(s0)
 d36:	97ba                	add	a5,a5,a4
 d38:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d3c:	fe843783          	ld	a5,-24(s0)
 d40:	fdc42703          	lw	a4,-36(s0)
 d44:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d46:	00000797          	auipc	a5,0x0
 d4a:	0ca78793          	addi	a5,a5,202 # e10 <freep>
 d4e:	fe043703          	ld	a4,-32(s0)
 d52:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d54:	fe843783          	ld	a5,-24(s0)
 d58:	07c1                	addi	a5,a5,16
 d5a:	a091                	j	d9e <malloc+0x134>
    }
    if(p == freep)
 d5c:	00000797          	auipc	a5,0x0
 d60:	0b478793          	addi	a5,a5,180 # e10 <freep>
 d64:	639c                	ld	a5,0(a5)
 d66:	fe843703          	ld	a4,-24(s0)
 d6a:	02f71063          	bne	a4,a5,d8a <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 d6e:	fdc42783          	lw	a5,-36(s0)
 d72:	853e                	mv	a0,a5
 d74:	00000097          	auipc	ra,0x0
 d78:	e76080e7          	jalr	-394(ra) # bea <morecore>
 d7c:	fea43423          	sd	a0,-24(s0)
 d80:	fe843783          	ld	a5,-24(s0)
 d84:	e399                	bnez	a5,d8a <malloc+0x120>
        return 0;
 d86:	4781                	li	a5,0
 d88:	a819                	j	d9e <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d8a:	fe843783          	ld	a5,-24(s0)
 d8e:	fef43023          	sd	a5,-32(s0)
 d92:	fe843783          	ld	a5,-24(s0)
 d96:	639c                	ld	a5,0(a5)
 d98:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d9c:	b791                	j	ce0 <malloc+0x76>
  }
}
 d9e:	853e                	mv	a0,a5
 da0:	70e2                	ld	ra,56(sp)
 da2:	7442                	ld	s0,48(sp)
 da4:	6121                	addi	sp,sp,64
 da6:	8082                	ret
