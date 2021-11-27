
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
   8:	87aa                	mv	a5,a0
   a:	fcf42e23          	sw	a5,-36(s0)
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
   e:	a091                	j	52 <cat+0x52>
    if (write(1, buf, n) != n) {
  10:	fec42783          	lw	a5,-20(s0)
  14:	863e                	mv	a2,a5
  16:	00001597          	auipc	a1,0x1
  1a:	ed258593          	addi	a1,a1,-302 # ee8 <buf>
  1e:	4505                	li	a0,1
  20:	00000097          	auipc	ra,0x0
  24:	60e080e7          	jalr	1550(ra) # 62e <write>
  28:	87aa                	mv	a5,a0
  2a:	873e                	mv	a4,a5
  2c:	fec42783          	lw	a5,-20(s0)
  30:	2781                	sext.w	a5,a5
  32:	02e78063          	beq	a5,a4,52 <cat+0x52>
      fprintf(2, "cat: write error\n");
  36:	00001597          	auipc	a1,0x1
  3a:	e4a58593          	addi	a1,a1,-438 # e80 <malloc+0x142>
  3e:	4509                	li	a0,2
  40:	00001097          	auipc	ra,0x1
  44:	ab4080e7          	jalr	-1356(ra) # af4 <fprintf>
      exit(1);
  48:	4505                	li	a0,1
  4a:	00000097          	auipc	ra,0x0
  4e:	5c4080e7          	jalr	1476(ra) # 60e <exit>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  52:	fdc42783          	lw	a5,-36(s0)
  56:	20000613          	li	a2,512
  5a:	00001597          	auipc	a1,0x1
  5e:	e8e58593          	addi	a1,a1,-370 # ee8 <buf>
  62:	853e                	mv	a0,a5
  64:	00000097          	auipc	ra,0x0
  68:	5c2080e7          	jalr	1474(ra) # 626 <read>
  6c:	87aa                	mv	a5,a0
  6e:	fef42623          	sw	a5,-20(s0)
  72:	fec42783          	lw	a5,-20(s0)
  76:	2781                	sext.w	a5,a5
  78:	f8f04ce3          	bgtz	a5,10 <cat+0x10>
    }
  }
  if(n < 0){
  7c:	fec42783          	lw	a5,-20(s0)
  80:	2781                	sext.w	a5,a5
  82:	0207d063          	bgez	a5,a2 <cat+0xa2>
    fprintf(2, "cat: read error\n");
  86:	00001597          	auipc	a1,0x1
  8a:	e1258593          	addi	a1,a1,-494 # e98 <malloc+0x15a>
  8e:	4509                	li	a0,2
  90:	00001097          	auipc	ra,0x1
  94:	a64080e7          	jalr	-1436(ra) # af4 <fprintf>
    exit(1);
  98:	4505                	li	a0,1
  9a:	00000097          	auipc	ra,0x0
  9e:	574080e7          	jalr	1396(ra) # 60e <exit>
  }
}
  a2:	0001                	nop
  a4:	70a2                	ld	ra,40(sp)
  a6:	7402                	ld	s0,32(sp)
  a8:	6145                	addi	sp,sp,48
  aa:	8082                	ret

00000000000000ac <main>:

int
main(int argc, char *argv[])
{
  ac:	7179                	addi	sp,sp,-48
  ae:	f406                	sd	ra,40(sp)
  b0:	f022                	sd	s0,32(sp)
  b2:	1800                	addi	s0,sp,48
  b4:	87aa                	mv	a5,a0
  b6:	fcb43823          	sd	a1,-48(s0)
  ba:	fcf42e23          	sw	a5,-36(s0)
  int fd, i;

  if(argc <= 1){
  be:	fdc42783          	lw	a5,-36(s0)
  c2:	0007871b          	sext.w	a4,a5
  c6:	4785                	li	a5,1
  c8:	00e7cc63          	blt	a5,a4,e0 <main+0x34>
    cat(0);
  cc:	4501                	li	a0,0
  ce:	00000097          	auipc	ra,0x0
  d2:	f32080e7          	jalr	-206(ra) # 0 <cat>
    exit(0);
  d6:	4501                	li	a0,0
  d8:	00000097          	auipc	ra,0x0
  dc:	536080e7          	jalr	1334(ra) # 60e <exit>
  }

  for(i = 1; i < argc; i++){
  e0:	4785                	li	a5,1
  e2:	fef42623          	sw	a5,-20(s0)
  e6:	a8bd                	j	164 <main+0xb8>
    if((fd = open(argv[i], 0)) < 0){
  e8:	fec42783          	lw	a5,-20(s0)
  ec:	078e                	slli	a5,a5,0x3
  ee:	fd043703          	ld	a4,-48(s0)
  f2:	97ba                	add	a5,a5,a4
  f4:	639c                	ld	a5,0(a5)
  f6:	4581                	li	a1,0
  f8:	853e                	mv	a0,a5
  fa:	00000097          	auipc	ra,0x0
  fe:	554080e7          	jalr	1364(ra) # 64e <open>
 102:	87aa                	mv	a5,a0
 104:	fef42423          	sw	a5,-24(s0)
 108:	fe842783          	lw	a5,-24(s0)
 10c:	2781                	sext.w	a5,a5
 10e:	0207d863          	bgez	a5,13e <main+0x92>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
 112:	fec42783          	lw	a5,-20(s0)
 116:	078e                	slli	a5,a5,0x3
 118:	fd043703          	ld	a4,-48(s0)
 11c:	97ba                	add	a5,a5,a4
 11e:	639c                	ld	a5,0(a5)
 120:	863e                	mv	a2,a5
 122:	00001597          	auipc	a1,0x1
 126:	d8e58593          	addi	a1,a1,-626 # eb0 <malloc+0x172>
 12a:	4509                	li	a0,2
 12c:	00001097          	auipc	ra,0x1
 130:	9c8080e7          	jalr	-1592(ra) # af4 <fprintf>
      exit(1);
 134:	4505                	li	a0,1
 136:	00000097          	auipc	ra,0x0
 13a:	4d8080e7          	jalr	1240(ra) # 60e <exit>
    }
    cat(fd);
 13e:	fe842783          	lw	a5,-24(s0)
 142:	853e                	mv	a0,a5
 144:	00000097          	auipc	ra,0x0
 148:	ebc080e7          	jalr	-324(ra) # 0 <cat>
    close(fd);
 14c:	fe842783          	lw	a5,-24(s0)
 150:	853e                	mv	a0,a5
 152:	00000097          	auipc	ra,0x0
 156:	4e4080e7          	jalr	1252(ra) # 636 <close>
  for(i = 1; i < argc; i++){
 15a:	fec42783          	lw	a5,-20(s0)
 15e:	2785                	addiw	a5,a5,1
 160:	fef42623          	sw	a5,-20(s0)
 164:	fec42703          	lw	a4,-20(s0)
 168:	fdc42783          	lw	a5,-36(s0)
 16c:	2701                	sext.w	a4,a4
 16e:	2781                	sext.w	a5,a5
 170:	f6f74ce3          	blt	a4,a5,e8 <main+0x3c>
  }
  exit(0);
 174:	4501                	li	a0,0
 176:	00000097          	auipc	ra,0x0
 17a:	498080e7          	jalr	1176(ra) # 60e <exit>

000000000000017e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 17e:	7179                	addi	sp,sp,-48
 180:	f422                	sd	s0,40(sp)
 182:	1800                	addi	s0,sp,48
 184:	fca43c23          	sd	a0,-40(s0)
 188:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 18c:	fd843783          	ld	a5,-40(s0)
 190:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 194:	0001                	nop
 196:	fd043703          	ld	a4,-48(s0)
 19a:	00170793          	addi	a5,a4,1
 19e:	fcf43823          	sd	a5,-48(s0)
 1a2:	fd843783          	ld	a5,-40(s0)
 1a6:	00178693          	addi	a3,a5,1
 1aa:	fcd43c23          	sd	a3,-40(s0)
 1ae:	00074703          	lbu	a4,0(a4)
 1b2:	00e78023          	sb	a4,0(a5)
 1b6:	0007c783          	lbu	a5,0(a5)
 1ba:	fff1                	bnez	a5,196 <strcpy+0x18>
    ;
  return os;
 1bc:	fe843783          	ld	a5,-24(s0)
}
 1c0:	853e                	mv	a0,a5
 1c2:	7422                	ld	s0,40(sp)
 1c4:	6145                	addi	sp,sp,48
 1c6:	8082                	ret

00000000000001c8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c8:	1101                	addi	sp,sp,-32
 1ca:	ec22                	sd	s0,24(sp)
 1cc:	1000                	addi	s0,sp,32
 1ce:	fea43423          	sd	a0,-24(s0)
 1d2:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 1d6:	a819                	j	1ec <strcmp+0x24>
    p++, q++;
 1d8:	fe843783          	ld	a5,-24(s0)
 1dc:	0785                	addi	a5,a5,1
 1de:	fef43423          	sd	a5,-24(s0)
 1e2:	fe043783          	ld	a5,-32(s0)
 1e6:	0785                	addi	a5,a5,1
 1e8:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 1ec:	fe843783          	ld	a5,-24(s0)
 1f0:	0007c783          	lbu	a5,0(a5)
 1f4:	cb99                	beqz	a5,20a <strcmp+0x42>
 1f6:	fe843783          	ld	a5,-24(s0)
 1fa:	0007c703          	lbu	a4,0(a5)
 1fe:	fe043783          	ld	a5,-32(s0)
 202:	0007c783          	lbu	a5,0(a5)
 206:	fcf709e3          	beq	a4,a5,1d8 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 20a:	fe843783          	ld	a5,-24(s0)
 20e:	0007c783          	lbu	a5,0(a5)
 212:	0007871b          	sext.w	a4,a5
 216:	fe043783          	ld	a5,-32(s0)
 21a:	0007c783          	lbu	a5,0(a5)
 21e:	2781                	sext.w	a5,a5
 220:	40f707bb          	subw	a5,a4,a5
 224:	2781                	sext.w	a5,a5
}
 226:	853e                	mv	a0,a5
 228:	6462                	ld	s0,24(sp)
 22a:	6105                	addi	sp,sp,32
 22c:	8082                	ret

000000000000022e <strlen>:

uint
strlen(const char *s)
{
 22e:	7179                	addi	sp,sp,-48
 230:	f422                	sd	s0,40(sp)
 232:	1800                	addi	s0,sp,48
 234:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 238:	fe042623          	sw	zero,-20(s0)
 23c:	a031                	j	248 <strlen+0x1a>
 23e:	fec42783          	lw	a5,-20(s0)
 242:	2785                	addiw	a5,a5,1
 244:	fef42623          	sw	a5,-20(s0)
 248:	fec42783          	lw	a5,-20(s0)
 24c:	fd843703          	ld	a4,-40(s0)
 250:	97ba                	add	a5,a5,a4
 252:	0007c783          	lbu	a5,0(a5)
 256:	f7e5                	bnez	a5,23e <strlen+0x10>
    ;
  return n;
 258:	fec42783          	lw	a5,-20(s0)
}
 25c:	853e                	mv	a0,a5
 25e:	7422                	ld	s0,40(sp)
 260:	6145                	addi	sp,sp,48
 262:	8082                	ret

0000000000000264 <memset>:

void*
memset(void *dst, int c, uint n)
{
 264:	7179                	addi	sp,sp,-48
 266:	f422                	sd	s0,40(sp)
 268:	1800                	addi	s0,sp,48
 26a:	fca43c23          	sd	a0,-40(s0)
 26e:	87ae                	mv	a5,a1
 270:	8732                	mv	a4,a2
 272:	fcf42a23          	sw	a5,-44(s0)
 276:	87ba                	mv	a5,a4
 278:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 27c:	fd843783          	ld	a5,-40(s0)
 280:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 284:	fe042623          	sw	zero,-20(s0)
 288:	a00d                	j	2aa <memset+0x46>
    cdst[i] = c;
 28a:	fec42783          	lw	a5,-20(s0)
 28e:	fe043703          	ld	a4,-32(s0)
 292:	97ba                	add	a5,a5,a4
 294:	fd442703          	lw	a4,-44(s0)
 298:	0ff77713          	andi	a4,a4,255
 29c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 2a0:	fec42783          	lw	a5,-20(s0)
 2a4:	2785                	addiw	a5,a5,1
 2a6:	fef42623          	sw	a5,-20(s0)
 2aa:	fec42703          	lw	a4,-20(s0)
 2ae:	fd042783          	lw	a5,-48(s0)
 2b2:	2781                	sext.w	a5,a5
 2b4:	fcf76be3          	bltu	a4,a5,28a <memset+0x26>
  }
  return dst;
 2b8:	fd843783          	ld	a5,-40(s0)
}
 2bc:	853e                	mv	a0,a5
 2be:	7422                	ld	s0,40(sp)
 2c0:	6145                	addi	sp,sp,48
 2c2:	8082                	ret

00000000000002c4 <strchr>:

char*
strchr(const char *s, char c)
{
 2c4:	1101                	addi	sp,sp,-32
 2c6:	ec22                	sd	s0,24(sp)
 2c8:	1000                	addi	s0,sp,32
 2ca:	fea43423          	sd	a0,-24(s0)
 2ce:	87ae                	mv	a5,a1
 2d0:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 2d4:	a01d                	j	2fa <strchr+0x36>
    if(*s == c)
 2d6:	fe843783          	ld	a5,-24(s0)
 2da:	0007c703          	lbu	a4,0(a5)
 2de:	fe744783          	lbu	a5,-25(s0)
 2e2:	0ff7f793          	andi	a5,a5,255
 2e6:	00e79563          	bne	a5,a4,2f0 <strchr+0x2c>
      return (char*)s;
 2ea:	fe843783          	ld	a5,-24(s0)
 2ee:	a821                	j	306 <strchr+0x42>
  for(; *s; s++)
 2f0:	fe843783          	ld	a5,-24(s0)
 2f4:	0785                	addi	a5,a5,1
 2f6:	fef43423          	sd	a5,-24(s0)
 2fa:	fe843783          	ld	a5,-24(s0)
 2fe:	0007c783          	lbu	a5,0(a5)
 302:	fbf1                	bnez	a5,2d6 <strchr+0x12>
  return 0;
 304:	4781                	li	a5,0
}
 306:	853e                	mv	a0,a5
 308:	6462                	ld	s0,24(sp)
 30a:	6105                	addi	sp,sp,32
 30c:	8082                	ret

000000000000030e <gets>:

char*
gets(char *buf, int max)
{
 30e:	7179                	addi	sp,sp,-48
 310:	f406                	sd	ra,40(sp)
 312:	f022                	sd	s0,32(sp)
 314:	1800                	addi	s0,sp,48
 316:	fca43c23          	sd	a0,-40(s0)
 31a:	87ae                	mv	a5,a1
 31c:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 320:	fe042623          	sw	zero,-20(s0)
 324:	a8a1                	j	37c <gets+0x6e>
    cc = read(0, &c, 1);
 326:	fe740793          	addi	a5,s0,-25
 32a:	4605                	li	a2,1
 32c:	85be                	mv	a1,a5
 32e:	4501                	li	a0,0
 330:	00000097          	auipc	ra,0x0
 334:	2f6080e7          	jalr	758(ra) # 626 <read>
 338:	87aa                	mv	a5,a0
 33a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 33e:	fe842783          	lw	a5,-24(s0)
 342:	2781                	sext.w	a5,a5
 344:	04f05763          	blez	a5,392 <gets+0x84>
      break;
    buf[i++] = c;
 348:	fec42783          	lw	a5,-20(s0)
 34c:	0017871b          	addiw	a4,a5,1
 350:	fee42623          	sw	a4,-20(s0)
 354:	873e                	mv	a4,a5
 356:	fd843783          	ld	a5,-40(s0)
 35a:	97ba                	add	a5,a5,a4
 35c:	fe744703          	lbu	a4,-25(s0)
 360:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 364:	fe744783          	lbu	a5,-25(s0)
 368:	873e                	mv	a4,a5
 36a:	47a9                	li	a5,10
 36c:	02f70463          	beq	a4,a5,394 <gets+0x86>
 370:	fe744783          	lbu	a5,-25(s0)
 374:	873e                	mv	a4,a5
 376:	47b5                	li	a5,13
 378:	00f70e63          	beq	a4,a5,394 <gets+0x86>
  for(i=0; i+1 < max; ){
 37c:	fec42783          	lw	a5,-20(s0)
 380:	2785                	addiw	a5,a5,1
 382:	0007871b          	sext.w	a4,a5
 386:	fd442783          	lw	a5,-44(s0)
 38a:	2781                	sext.w	a5,a5
 38c:	f8f74de3          	blt	a4,a5,326 <gets+0x18>
 390:	a011                	j	394 <gets+0x86>
      break;
 392:	0001                	nop
      break;
  }
  buf[i] = '\0';
 394:	fec42783          	lw	a5,-20(s0)
 398:	fd843703          	ld	a4,-40(s0)
 39c:	97ba                	add	a5,a5,a4
 39e:	00078023          	sb	zero,0(a5)
  return buf;
 3a2:	fd843783          	ld	a5,-40(s0)
}
 3a6:	853e                	mv	a0,a5
 3a8:	70a2                	ld	ra,40(sp)
 3aa:	7402                	ld	s0,32(sp)
 3ac:	6145                	addi	sp,sp,48
 3ae:	8082                	ret

00000000000003b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3b0:	7179                	addi	sp,sp,-48
 3b2:	f406                	sd	ra,40(sp)
 3b4:	f022                	sd	s0,32(sp)
 3b6:	1800                	addi	s0,sp,48
 3b8:	fca43c23          	sd	a0,-40(s0)
 3bc:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3c0:	4581                	li	a1,0
 3c2:	fd843503          	ld	a0,-40(s0)
 3c6:	00000097          	auipc	ra,0x0
 3ca:	288080e7          	jalr	648(ra) # 64e <open>
 3ce:	87aa                	mv	a5,a0
 3d0:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 3d4:	fec42783          	lw	a5,-20(s0)
 3d8:	2781                	sext.w	a5,a5
 3da:	0007d463          	bgez	a5,3e2 <stat+0x32>
    return -1;
 3de:	57fd                	li	a5,-1
 3e0:	a035                	j	40c <stat+0x5c>
  r = fstat(fd, st);
 3e2:	fec42783          	lw	a5,-20(s0)
 3e6:	fd043583          	ld	a1,-48(s0)
 3ea:	853e                	mv	a0,a5
 3ec:	00000097          	auipc	ra,0x0
 3f0:	27a080e7          	jalr	634(ra) # 666 <fstat>
 3f4:	87aa                	mv	a5,a0
 3f6:	fef42423          	sw	a5,-24(s0)
  close(fd);
 3fa:	fec42783          	lw	a5,-20(s0)
 3fe:	853e                	mv	a0,a5
 400:	00000097          	auipc	ra,0x0
 404:	236080e7          	jalr	566(ra) # 636 <close>
  return r;
 408:	fe842783          	lw	a5,-24(s0)
}
 40c:	853e                	mv	a0,a5
 40e:	70a2                	ld	ra,40(sp)
 410:	7402                	ld	s0,32(sp)
 412:	6145                	addi	sp,sp,48
 414:	8082                	ret

0000000000000416 <atoi>:

int
atoi(const char *s)
{
 416:	7179                	addi	sp,sp,-48
 418:	f422                	sd	s0,40(sp)
 41a:	1800                	addi	s0,sp,48
 41c:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 420:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 424:	a815                	j	458 <atoi+0x42>
    n = n*10 + *s++ - '0';
 426:	fec42703          	lw	a4,-20(s0)
 42a:	87ba                	mv	a5,a4
 42c:	0027979b          	slliw	a5,a5,0x2
 430:	9fb9                	addw	a5,a5,a4
 432:	0017979b          	slliw	a5,a5,0x1
 436:	0007871b          	sext.w	a4,a5
 43a:	fd843783          	ld	a5,-40(s0)
 43e:	00178693          	addi	a3,a5,1
 442:	fcd43c23          	sd	a3,-40(s0)
 446:	0007c783          	lbu	a5,0(a5)
 44a:	2781                	sext.w	a5,a5
 44c:	9fb9                	addw	a5,a5,a4
 44e:	2781                	sext.w	a5,a5
 450:	fd07879b          	addiw	a5,a5,-48
 454:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 458:	fd843783          	ld	a5,-40(s0)
 45c:	0007c783          	lbu	a5,0(a5)
 460:	873e                	mv	a4,a5
 462:	02f00793          	li	a5,47
 466:	00e7fb63          	bgeu	a5,a4,47c <atoi+0x66>
 46a:	fd843783          	ld	a5,-40(s0)
 46e:	0007c783          	lbu	a5,0(a5)
 472:	873e                	mv	a4,a5
 474:	03900793          	li	a5,57
 478:	fae7f7e3          	bgeu	a5,a4,426 <atoi+0x10>
  return n;
 47c:	fec42783          	lw	a5,-20(s0)
}
 480:	853e                	mv	a0,a5
 482:	7422                	ld	s0,40(sp)
 484:	6145                	addi	sp,sp,48
 486:	8082                	ret

0000000000000488 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 488:	7139                	addi	sp,sp,-64
 48a:	fc22                	sd	s0,56(sp)
 48c:	0080                	addi	s0,sp,64
 48e:	fca43c23          	sd	a0,-40(s0)
 492:	fcb43823          	sd	a1,-48(s0)
 496:	87b2                	mv	a5,a2
 498:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 49c:	fd843783          	ld	a5,-40(s0)
 4a0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 4a4:	fd043783          	ld	a5,-48(s0)
 4a8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 4ac:	fe043703          	ld	a4,-32(s0)
 4b0:	fe843783          	ld	a5,-24(s0)
 4b4:	02e7fc63          	bgeu	a5,a4,4ec <memmove+0x64>
    while(n-- > 0)
 4b8:	a00d                	j	4da <memmove+0x52>
      *dst++ = *src++;
 4ba:	fe043703          	ld	a4,-32(s0)
 4be:	00170793          	addi	a5,a4,1
 4c2:	fef43023          	sd	a5,-32(s0)
 4c6:	fe843783          	ld	a5,-24(s0)
 4ca:	00178693          	addi	a3,a5,1
 4ce:	fed43423          	sd	a3,-24(s0)
 4d2:	00074703          	lbu	a4,0(a4)
 4d6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4da:	fcc42783          	lw	a5,-52(s0)
 4de:	fff7871b          	addiw	a4,a5,-1
 4e2:	fce42623          	sw	a4,-52(s0)
 4e6:	fcf04ae3          	bgtz	a5,4ba <memmove+0x32>
 4ea:	a891                	j	53e <memmove+0xb6>
  } else {
    dst += n;
 4ec:	fcc42783          	lw	a5,-52(s0)
 4f0:	fe843703          	ld	a4,-24(s0)
 4f4:	97ba                	add	a5,a5,a4
 4f6:	fef43423          	sd	a5,-24(s0)
    src += n;
 4fa:	fcc42783          	lw	a5,-52(s0)
 4fe:	fe043703          	ld	a4,-32(s0)
 502:	97ba                	add	a5,a5,a4
 504:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 508:	a01d                	j	52e <memmove+0xa6>
      *--dst = *--src;
 50a:	fe043783          	ld	a5,-32(s0)
 50e:	17fd                	addi	a5,a5,-1
 510:	fef43023          	sd	a5,-32(s0)
 514:	fe843783          	ld	a5,-24(s0)
 518:	17fd                	addi	a5,a5,-1
 51a:	fef43423          	sd	a5,-24(s0)
 51e:	fe043783          	ld	a5,-32(s0)
 522:	0007c703          	lbu	a4,0(a5)
 526:	fe843783          	ld	a5,-24(s0)
 52a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 52e:	fcc42783          	lw	a5,-52(s0)
 532:	fff7871b          	addiw	a4,a5,-1
 536:	fce42623          	sw	a4,-52(s0)
 53a:	fcf048e3          	bgtz	a5,50a <memmove+0x82>
  }
  return vdst;
 53e:	fd843783          	ld	a5,-40(s0)
}
 542:	853e                	mv	a0,a5
 544:	7462                	ld	s0,56(sp)
 546:	6121                	addi	sp,sp,64
 548:	8082                	ret

000000000000054a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 54a:	7139                	addi	sp,sp,-64
 54c:	fc22                	sd	s0,56(sp)
 54e:	0080                	addi	s0,sp,64
 550:	fca43c23          	sd	a0,-40(s0)
 554:	fcb43823          	sd	a1,-48(s0)
 558:	87b2                	mv	a5,a2
 55a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 55e:	fd843783          	ld	a5,-40(s0)
 562:	fef43423          	sd	a5,-24(s0)
 566:	fd043783          	ld	a5,-48(s0)
 56a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 56e:	a0a1                	j	5b6 <memcmp+0x6c>
    if (*p1 != *p2) {
 570:	fe843783          	ld	a5,-24(s0)
 574:	0007c703          	lbu	a4,0(a5)
 578:	fe043783          	ld	a5,-32(s0)
 57c:	0007c783          	lbu	a5,0(a5)
 580:	02f70163          	beq	a4,a5,5a2 <memcmp+0x58>
      return *p1 - *p2;
 584:	fe843783          	ld	a5,-24(s0)
 588:	0007c783          	lbu	a5,0(a5)
 58c:	0007871b          	sext.w	a4,a5
 590:	fe043783          	ld	a5,-32(s0)
 594:	0007c783          	lbu	a5,0(a5)
 598:	2781                	sext.w	a5,a5
 59a:	40f707bb          	subw	a5,a4,a5
 59e:	2781                	sext.w	a5,a5
 5a0:	a01d                	j	5c6 <memcmp+0x7c>
    }
    p1++;
 5a2:	fe843783          	ld	a5,-24(s0)
 5a6:	0785                	addi	a5,a5,1
 5a8:	fef43423          	sd	a5,-24(s0)
    p2++;
 5ac:	fe043783          	ld	a5,-32(s0)
 5b0:	0785                	addi	a5,a5,1
 5b2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 5b6:	fcc42783          	lw	a5,-52(s0)
 5ba:	fff7871b          	addiw	a4,a5,-1
 5be:	fce42623          	sw	a4,-52(s0)
 5c2:	f7dd                	bnez	a5,570 <memcmp+0x26>
  }
  return 0;
 5c4:	4781                	li	a5,0
}
 5c6:	853e                	mv	a0,a5
 5c8:	7462                	ld	s0,56(sp)
 5ca:	6121                	addi	sp,sp,64
 5cc:	8082                	ret

00000000000005ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5ce:	7179                	addi	sp,sp,-48
 5d0:	f406                	sd	ra,40(sp)
 5d2:	f022                	sd	s0,32(sp)
 5d4:	1800                	addi	s0,sp,48
 5d6:	fea43423          	sd	a0,-24(s0)
 5da:	feb43023          	sd	a1,-32(s0)
 5de:	87b2                	mv	a5,a2
 5e0:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 5e4:	fdc42783          	lw	a5,-36(s0)
 5e8:	863e                	mv	a2,a5
 5ea:	fe043583          	ld	a1,-32(s0)
 5ee:	fe843503          	ld	a0,-24(s0)
 5f2:	00000097          	auipc	ra,0x0
 5f6:	e96080e7          	jalr	-362(ra) # 488 <memmove>
 5fa:	87aa                	mv	a5,a0
}
 5fc:	853e                	mv	a0,a5
 5fe:	70a2                	ld	ra,40(sp)
 600:	7402                	ld	s0,32(sp)
 602:	6145                	addi	sp,sp,48
 604:	8082                	ret

0000000000000606 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 606:	4885                	li	a7,1
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <exit>:
.global exit
exit:
 li a7, SYS_exit
 60e:	4889                	li	a7,2
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <wait>:
.global wait
wait:
 li a7, SYS_wait
 616:	488d                	li	a7,3
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 61e:	4891                	li	a7,4
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <read>:
.global read
read:
 li a7, SYS_read
 626:	4895                	li	a7,5
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <write>:
.global write
write:
 li a7, SYS_write
 62e:	48c1                	li	a7,16
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <close>:
.global close
close:
 li a7, SYS_close
 636:	48d5                	li	a7,21
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <kill>:
.global kill
kill:
 li a7, SYS_kill
 63e:	4899                	li	a7,6
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <exec>:
.global exec
exec:
 li a7, SYS_exec
 646:	489d                	li	a7,7
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <open>:
.global open
open:
 li a7, SYS_open
 64e:	48bd                	li	a7,15
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 656:	48c5                	li	a7,17
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 65e:	48c9                	li	a7,18
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 666:	48a1                	li	a7,8
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <link>:
.global link
link:
 li a7, SYS_link
 66e:	48cd                	li	a7,19
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 676:	48d1                	li	a7,20
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 67e:	48a5                	li	a7,9
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <dup>:
.global dup
dup:
 li a7, SYS_dup
 686:	48a9                	li	a7,10
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 68e:	48ad                	li	a7,11
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret

0000000000000696 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 696:	48b1                	li	a7,12
 ecall
 698:	00000073          	ecall
 ret
 69c:	8082                	ret

000000000000069e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 69e:	48b5                	li	a7,13
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6a6:	48b9                	li	a7,14
 ecall
 6a8:	00000073          	ecall
 ret
 6ac:	8082                	ret

00000000000006ae <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 6ae:	48d9                	li	a7,22
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <setpri>:
.global setpri
setpri:
 li a7, SYS_setpri
 6b6:	48dd                	li	a7,23
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6be:	1101                	addi	sp,sp,-32
 6c0:	ec06                	sd	ra,24(sp)
 6c2:	e822                	sd	s0,16(sp)
 6c4:	1000                	addi	s0,sp,32
 6c6:	87aa                	mv	a5,a0
 6c8:	872e                	mv	a4,a1
 6ca:	fef42623          	sw	a5,-20(s0)
 6ce:	87ba                	mv	a5,a4
 6d0:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 6d4:	feb40713          	addi	a4,s0,-21
 6d8:	fec42783          	lw	a5,-20(s0)
 6dc:	4605                	li	a2,1
 6de:	85ba                	mv	a1,a4
 6e0:	853e                	mv	a0,a5
 6e2:	00000097          	auipc	ra,0x0
 6e6:	f4c080e7          	jalr	-180(ra) # 62e <write>
}
 6ea:	0001                	nop
 6ec:	60e2                	ld	ra,24(sp)
 6ee:	6442                	ld	s0,16(sp)
 6f0:	6105                	addi	sp,sp,32
 6f2:	8082                	ret

00000000000006f4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6f4:	7139                	addi	sp,sp,-64
 6f6:	fc06                	sd	ra,56(sp)
 6f8:	f822                	sd	s0,48(sp)
 6fa:	0080                	addi	s0,sp,64
 6fc:	87aa                	mv	a5,a0
 6fe:	8736                	mv	a4,a3
 700:	fcf42623          	sw	a5,-52(s0)
 704:	87ae                	mv	a5,a1
 706:	fcf42423          	sw	a5,-56(s0)
 70a:	87b2                	mv	a5,a2
 70c:	fcf42223          	sw	a5,-60(s0)
 710:	87ba                	mv	a5,a4
 712:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 716:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 71a:	fc042783          	lw	a5,-64(s0)
 71e:	2781                	sext.w	a5,a5
 720:	c38d                	beqz	a5,742 <printint+0x4e>
 722:	fc842783          	lw	a5,-56(s0)
 726:	2781                	sext.w	a5,a5
 728:	0007dd63          	bgez	a5,742 <printint+0x4e>
    neg = 1;
 72c:	4785                	li	a5,1
 72e:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 732:	fc842783          	lw	a5,-56(s0)
 736:	40f007bb          	negw	a5,a5
 73a:	2781                	sext.w	a5,a5
 73c:	fef42223          	sw	a5,-28(s0)
 740:	a029                	j	74a <printint+0x56>
  } else {
    x = xx;
 742:	fc842783          	lw	a5,-56(s0)
 746:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 74a:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 74e:	fc442783          	lw	a5,-60(s0)
 752:	fe442703          	lw	a4,-28(s0)
 756:	02f777bb          	remuw	a5,a4,a5
 75a:	0007861b          	sext.w	a2,a5
 75e:	fec42783          	lw	a5,-20(s0)
 762:	0017871b          	addiw	a4,a5,1
 766:	fee42623          	sw	a4,-20(s0)
 76a:	00000697          	auipc	a3,0x0
 76e:	76668693          	addi	a3,a3,1894 # ed0 <digits>
 772:	02061713          	slli	a4,a2,0x20
 776:	9301                	srli	a4,a4,0x20
 778:	9736                	add	a4,a4,a3
 77a:	00074703          	lbu	a4,0(a4)
 77e:	ff040693          	addi	a3,s0,-16
 782:	97b6                	add	a5,a5,a3
 784:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 788:	fc442783          	lw	a5,-60(s0)
 78c:	fe442703          	lw	a4,-28(s0)
 790:	02f757bb          	divuw	a5,a4,a5
 794:	fef42223          	sw	a5,-28(s0)
 798:	fe442783          	lw	a5,-28(s0)
 79c:	2781                	sext.w	a5,a5
 79e:	fbc5                	bnez	a5,74e <printint+0x5a>
  if(neg)
 7a0:	fe842783          	lw	a5,-24(s0)
 7a4:	2781                	sext.w	a5,a5
 7a6:	cf95                	beqz	a5,7e2 <printint+0xee>
    buf[i++] = '-';
 7a8:	fec42783          	lw	a5,-20(s0)
 7ac:	0017871b          	addiw	a4,a5,1
 7b0:	fee42623          	sw	a4,-20(s0)
 7b4:	ff040713          	addi	a4,s0,-16
 7b8:	97ba                	add	a5,a5,a4
 7ba:	02d00713          	li	a4,45
 7be:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 7c2:	a005                	j	7e2 <printint+0xee>
    putc(fd, buf[i]);
 7c4:	fec42783          	lw	a5,-20(s0)
 7c8:	ff040713          	addi	a4,s0,-16
 7cc:	97ba                	add	a5,a5,a4
 7ce:	fe07c703          	lbu	a4,-32(a5)
 7d2:	fcc42783          	lw	a5,-52(s0)
 7d6:	85ba                	mv	a1,a4
 7d8:	853e                	mv	a0,a5
 7da:	00000097          	auipc	ra,0x0
 7de:	ee4080e7          	jalr	-284(ra) # 6be <putc>
  while(--i >= 0)
 7e2:	fec42783          	lw	a5,-20(s0)
 7e6:	37fd                	addiw	a5,a5,-1
 7e8:	fef42623          	sw	a5,-20(s0)
 7ec:	fec42783          	lw	a5,-20(s0)
 7f0:	2781                	sext.w	a5,a5
 7f2:	fc07d9e3          	bgez	a5,7c4 <printint+0xd0>
}
 7f6:	0001                	nop
 7f8:	0001                	nop
 7fa:	70e2                	ld	ra,56(sp)
 7fc:	7442                	ld	s0,48(sp)
 7fe:	6121                	addi	sp,sp,64
 800:	8082                	ret

0000000000000802 <printptr>:

static void
printptr(int fd, uint64 x) {
 802:	7179                	addi	sp,sp,-48
 804:	f406                	sd	ra,40(sp)
 806:	f022                	sd	s0,32(sp)
 808:	1800                	addi	s0,sp,48
 80a:	87aa                	mv	a5,a0
 80c:	fcb43823          	sd	a1,-48(s0)
 810:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 814:	fdc42783          	lw	a5,-36(s0)
 818:	03000593          	li	a1,48
 81c:	853e                	mv	a0,a5
 81e:	00000097          	auipc	ra,0x0
 822:	ea0080e7          	jalr	-352(ra) # 6be <putc>
  putc(fd, 'x');
 826:	fdc42783          	lw	a5,-36(s0)
 82a:	07800593          	li	a1,120
 82e:	853e                	mv	a0,a5
 830:	00000097          	auipc	ra,0x0
 834:	e8e080e7          	jalr	-370(ra) # 6be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 838:	fe042623          	sw	zero,-20(s0)
 83c:	a82d                	j	876 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 83e:	fd043783          	ld	a5,-48(s0)
 842:	93f1                	srli	a5,a5,0x3c
 844:	00000717          	auipc	a4,0x0
 848:	68c70713          	addi	a4,a4,1676 # ed0 <digits>
 84c:	97ba                	add	a5,a5,a4
 84e:	0007c703          	lbu	a4,0(a5)
 852:	fdc42783          	lw	a5,-36(s0)
 856:	85ba                	mv	a1,a4
 858:	853e                	mv	a0,a5
 85a:	00000097          	auipc	ra,0x0
 85e:	e64080e7          	jalr	-412(ra) # 6be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 862:	fec42783          	lw	a5,-20(s0)
 866:	2785                	addiw	a5,a5,1
 868:	fef42623          	sw	a5,-20(s0)
 86c:	fd043783          	ld	a5,-48(s0)
 870:	0792                	slli	a5,a5,0x4
 872:	fcf43823          	sd	a5,-48(s0)
 876:	fec42783          	lw	a5,-20(s0)
 87a:	873e                	mv	a4,a5
 87c:	47bd                	li	a5,15
 87e:	fce7f0e3          	bgeu	a5,a4,83e <printptr+0x3c>
}
 882:	0001                	nop
 884:	0001                	nop
 886:	70a2                	ld	ra,40(sp)
 888:	7402                	ld	s0,32(sp)
 88a:	6145                	addi	sp,sp,48
 88c:	8082                	ret

000000000000088e <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 88e:	715d                	addi	sp,sp,-80
 890:	e486                	sd	ra,72(sp)
 892:	e0a2                	sd	s0,64(sp)
 894:	0880                	addi	s0,sp,80
 896:	87aa                	mv	a5,a0
 898:	fcb43023          	sd	a1,-64(s0)
 89c:	fac43c23          	sd	a2,-72(s0)
 8a0:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 8a4:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 8a8:	fe042223          	sw	zero,-28(s0)
 8ac:	a42d                	j	ad6 <vprintf+0x248>
    c = fmt[i] & 0xff;
 8ae:	fe442783          	lw	a5,-28(s0)
 8b2:	fc043703          	ld	a4,-64(s0)
 8b6:	97ba                	add	a5,a5,a4
 8b8:	0007c783          	lbu	a5,0(a5)
 8bc:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 8c0:	fe042783          	lw	a5,-32(s0)
 8c4:	2781                	sext.w	a5,a5
 8c6:	eb9d                	bnez	a5,8fc <vprintf+0x6e>
      if(c == '%'){
 8c8:	fdc42783          	lw	a5,-36(s0)
 8cc:	0007871b          	sext.w	a4,a5
 8d0:	02500793          	li	a5,37
 8d4:	00f71763          	bne	a4,a5,8e2 <vprintf+0x54>
        state = '%';
 8d8:	02500793          	li	a5,37
 8dc:	fef42023          	sw	a5,-32(s0)
 8e0:	a2f5                	j	acc <vprintf+0x23e>
      } else {
        putc(fd, c);
 8e2:	fdc42783          	lw	a5,-36(s0)
 8e6:	0ff7f713          	andi	a4,a5,255
 8ea:	fcc42783          	lw	a5,-52(s0)
 8ee:	85ba                	mv	a1,a4
 8f0:	853e                	mv	a0,a5
 8f2:	00000097          	auipc	ra,0x0
 8f6:	dcc080e7          	jalr	-564(ra) # 6be <putc>
 8fa:	aac9                	j	acc <vprintf+0x23e>
      }
    } else if(state == '%'){
 8fc:	fe042783          	lw	a5,-32(s0)
 900:	0007871b          	sext.w	a4,a5
 904:	02500793          	li	a5,37
 908:	1cf71263          	bne	a4,a5,acc <vprintf+0x23e>
      if(c == 'd'){
 90c:	fdc42783          	lw	a5,-36(s0)
 910:	0007871b          	sext.w	a4,a5
 914:	06400793          	li	a5,100
 918:	02f71463          	bne	a4,a5,940 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 91c:	fb843783          	ld	a5,-72(s0)
 920:	00878713          	addi	a4,a5,8
 924:	fae43c23          	sd	a4,-72(s0)
 928:	4398                	lw	a4,0(a5)
 92a:	fcc42783          	lw	a5,-52(s0)
 92e:	4685                	li	a3,1
 930:	4629                	li	a2,10
 932:	85ba                	mv	a1,a4
 934:	853e                	mv	a0,a5
 936:	00000097          	auipc	ra,0x0
 93a:	dbe080e7          	jalr	-578(ra) # 6f4 <printint>
 93e:	a269                	j	ac8 <vprintf+0x23a>
      } else if(c == 'l') {
 940:	fdc42783          	lw	a5,-36(s0)
 944:	0007871b          	sext.w	a4,a5
 948:	06c00793          	li	a5,108
 94c:	02f71663          	bne	a4,a5,978 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 950:	fb843783          	ld	a5,-72(s0)
 954:	00878713          	addi	a4,a5,8
 958:	fae43c23          	sd	a4,-72(s0)
 95c:	639c                	ld	a5,0(a5)
 95e:	0007871b          	sext.w	a4,a5
 962:	fcc42783          	lw	a5,-52(s0)
 966:	4681                	li	a3,0
 968:	4629                	li	a2,10
 96a:	85ba                	mv	a1,a4
 96c:	853e                	mv	a0,a5
 96e:	00000097          	auipc	ra,0x0
 972:	d86080e7          	jalr	-634(ra) # 6f4 <printint>
 976:	aa89                	j	ac8 <vprintf+0x23a>
      } else if(c == 'x') {
 978:	fdc42783          	lw	a5,-36(s0)
 97c:	0007871b          	sext.w	a4,a5
 980:	07800793          	li	a5,120
 984:	02f71463          	bne	a4,a5,9ac <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 988:	fb843783          	ld	a5,-72(s0)
 98c:	00878713          	addi	a4,a5,8
 990:	fae43c23          	sd	a4,-72(s0)
 994:	4398                	lw	a4,0(a5)
 996:	fcc42783          	lw	a5,-52(s0)
 99a:	4681                	li	a3,0
 99c:	4641                	li	a2,16
 99e:	85ba                	mv	a1,a4
 9a0:	853e                	mv	a0,a5
 9a2:	00000097          	auipc	ra,0x0
 9a6:	d52080e7          	jalr	-686(ra) # 6f4 <printint>
 9aa:	aa39                	j	ac8 <vprintf+0x23a>
      } else if(c == 'p') {
 9ac:	fdc42783          	lw	a5,-36(s0)
 9b0:	0007871b          	sext.w	a4,a5
 9b4:	07000793          	li	a5,112
 9b8:	02f71263          	bne	a4,a5,9dc <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 9bc:	fb843783          	ld	a5,-72(s0)
 9c0:	00878713          	addi	a4,a5,8
 9c4:	fae43c23          	sd	a4,-72(s0)
 9c8:	6398                	ld	a4,0(a5)
 9ca:	fcc42783          	lw	a5,-52(s0)
 9ce:	85ba                	mv	a1,a4
 9d0:	853e                	mv	a0,a5
 9d2:	00000097          	auipc	ra,0x0
 9d6:	e30080e7          	jalr	-464(ra) # 802 <printptr>
 9da:	a0fd                	j	ac8 <vprintf+0x23a>
      } else if(c == 's'){
 9dc:	fdc42783          	lw	a5,-36(s0)
 9e0:	0007871b          	sext.w	a4,a5
 9e4:	07300793          	li	a5,115
 9e8:	04f71c63          	bne	a4,a5,a40 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 9ec:	fb843783          	ld	a5,-72(s0)
 9f0:	00878713          	addi	a4,a5,8
 9f4:	fae43c23          	sd	a4,-72(s0)
 9f8:	639c                	ld	a5,0(a5)
 9fa:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 9fe:	fe843783          	ld	a5,-24(s0)
 a02:	eb8d                	bnez	a5,a34 <vprintf+0x1a6>
          s = "(null)";
 a04:	00000797          	auipc	a5,0x0
 a08:	4c478793          	addi	a5,a5,1220 # ec8 <malloc+0x18a>
 a0c:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 a10:	a015                	j	a34 <vprintf+0x1a6>
          putc(fd, *s);
 a12:	fe843783          	ld	a5,-24(s0)
 a16:	0007c703          	lbu	a4,0(a5)
 a1a:	fcc42783          	lw	a5,-52(s0)
 a1e:	85ba                	mv	a1,a4
 a20:	853e                	mv	a0,a5
 a22:	00000097          	auipc	ra,0x0
 a26:	c9c080e7          	jalr	-868(ra) # 6be <putc>
          s++;
 a2a:	fe843783          	ld	a5,-24(s0)
 a2e:	0785                	addi	a5,a5,1
 a30:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 a34:	fe843783          	ld	a5,-24(s0)
 a38:	0007c783          	lbu	a5,0(a5)
 a3c:	fbf9                	bnez	a5,a12 <vprintf+0x184>
 a3e:	a069                	j	ac8 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 a40:	fdc42783          	lw	a5,-36(s0)
 a44:	0007871b          	sext.w	a4,a5
 a48:	06300793          	li	a5,99
 a4c:	02f71463          	bne	a4,a5,a74 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 a50:	fb843783          	ld	a5,-72(s0)
 a54:	00878713          	addi	a4,a5,8
 a58:	fae43c23          	sd	a4,-72(s0)
 a5c:	439c                	lw	a5,0(a5)
 a5e:	0ff7f713          	andi	a4,a5,255
 a62:	fcc42783          	lw	a5,-52(s0)
 a66:	85ba                	mv	a1,a4
 a68:	853e                	mv	a0,a5
 a6a:	00000097          	auipc	ra,0x0
 a6e:	c54080e7          	jalr	-940(ra) # 6be <putc>
 a72:	a899                	j	ac8 <vprintf+0x23a>
      } else if(c == '%'){
 a74:	fdc42783          	lw	a5,-36(s0)
 a78:	0007871b          	sext.w	a4,a5
 a7c:	02500793          	li	a5,37
 a80:	00f71f63          	bne	a4,a5,a9e <vprintf+0x210>
        putc(fd, c);
 a84:	fdc42783          	lw	a5,-36(s0)
 a88:	0ff7f713          	andi	a4,a5,255
 a8c:	fcc42783          	lw	a5,-52(s0)
 a90:	85ba                	mv	a1,a4
 a92:	853e                	mv	a0,a5
 a94:	00000097          	auipc	ra,0x0
 a98:	c2a080e7          	jalr	-982(ra) # 6be <putc>
 a9c:	a035                	j	ac8 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a9e:	fcc42783          	lw	a5,-52(s0)
 aa2:	02500593          	li	a1,37
 aa6:	853e                	mv	a0,a5
 aa8:	00000097          	auipc	ra,0x0
 aac:	c16080e7          	jalr	-1002(ra) # 6be <putc>
        putc(fd, c);
 ab0:	fdc42783          	lw	a5,-36(s0)
 ab4:	0ff7f713          	andi	a4,a5,255
 ab8:	fcc42783          	lw	a5,-52(s0)
 abc:	85ba                	mv	a1,a4
 abe:	853e                	mv	a0,a5
 ac0:	00000097          	auipc	ra,0x0
 ac4:	bfe080e7          	jalr	-1026(ra) # 6be <putc>
      }
      state = 0;
 ac8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 acc:	fe442783          	lw	a5,-28(s0)
 ad0:	2785                	addiw	a5,a5,1
 ad2:	fef42223          	sw	a5,-28(s0)
 ad6:	fe442783          	lw	a5,-28(s0)
 ada:	fc043703          	ld	a4,-64(s0)
 ade:	97ba                	add	a5,a5,a4
 ae0:	0007c783          	lbu	a5,0(a5)
 ae4:	dc0795e3          	bnez	a5,8ae <vprintf+0x20>
    }
  }
}
 ae8:	0001                	nop
 aea:	0001                	nop
 aec:	60a6                	ld	ra,72(sp)
 aee:	6406                	ld	s0,64(sp)
 af0:	6161                	addi	sp,sp,80
 af2:	8082                	ret

0000000000000af4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 af4:	7159                	addi	sp,sp,-112
 af6:	fc06                	sd	ra,56(sp)
 af8:	f822                	sd	s0,48(sp)
 afa:	0080                	addi	s0,sp,64
 afc:	fcb43823          	sd	a1,-48(s0)
 b00:	e010                	sd	a2,0(s0)
 b02:	e414                	sd	a3,8(s0)
 b04:	e818                	sd	a4,16(s0)
 b06:	ec1c                	sd	a5,24(s0)
 b08:	03043023          	sd	a6,32(s0)
 b0c:	03143423          	sd	a7,40(s0)
 b10:	87aa                	mv	a5,a0
 b12:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 b16:	03040793          	addi	a5,s0,48
 b1a:	fcf43423          	sd	a5,-56(s0)
 b1e:	fc843783          	ld	a5,-56(s0)
 b22:	fd078793          	addi	a5,a5,-48
 b26:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 b2a:	fe843703          	ld	a4,-24(s0)
 b2e:	fdc42783          	lw	a5,-36(s0)
 b32:	863a                	mv	a2,a4
 b34:	fd043583          	ld	a1,-48(s0)
 b38:	853e                	mv	a0,a5
 b3a:	00000097          	auipc	ra,0x0
 b3e:	d54080e7          	jalr	-684(ra) # 88e <vprintf>
}
 b42:	0001                	nop
 b44:	70e2                	ld	ra,56(sp)
 b46:	7442                	ld	s0,48(sp)
 b48:	6165                	addi	sp,sp,112
 b4a:	8082                	ret

0000000000000b4c <printf>:

void
printf(const char *fmt, ...)
{
 b4c:	7159                	addi	sp,sp,-112
 b4e:	f406                	sd	ra,40(sp)
 b50:	f022                	sd	s0,32(sp)
 b52:	1800                	addi	s0,sp,48
 b54:	fca43c23          	sd	a0,-40(s0)
 b58:	e40c                	sd	a1,8(s0)
 b5a:	e810                	sd	a2,16(s0)
 b5c:	ec14                	sd	a3,24(s0)
 b5e:	f018                	sd	a4,32(s0)
 b60:	f41c                	sd	a5,40(s0)
 b62:	03043823          	sd	a6,48(s0)
 b66:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b6a:	04040793          	addi	a5,s0,64
 b6e:	fcf43823          	sd	a5,-48(s0)
 b72:	fd043783          	ld	a5,-48(s0)
 b76:	fc878793          	addi	a5,a5,-56
 b7a:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 b7e:	fe843783          	ld	a5,-24(s0)
 b82:	863e                	mv	a2,a5
 b84:	fd843583          	ld	a1,-40(s0)
 b88:	4505                	li	a0,1
 b8a:	00000097          	auipc	ra,0x0
 b8e:	d04080e7          	jalr	-764(ra) # 88e <vprintf>
}
 b92:	0001                	nop
 b94:	70a2                	ld	ra,40(sp)
 b96:	7402                	ld	s0,32(sp)
 b98:	6165                	addi	sp,sp,112
 b9a:	8082                	ret

0000000000000b9c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b9c:	7179                	addi	sp,sp,-48
 b9e:	f422                	sd	s0,40(sp)
 ba0:	1800                	addi	s0,sp,48
 ba2:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ba6:	fd843783          	ld	a5,-40(s0)
 baa:	17c1                	addi	a5,a5,-16
 bac:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bb0:	00000797          	auipc	a5,0x0
 bb4:	54878793          	addi	a5,a5,1352 # 10f8 <freep>
 bb8:	639c                	ld	a5,0(a5)
 bba:	fef43423          	sd	a5,-24(s0)
 bbe:	a815                	j	bf2 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bc0:	fe843783          	ld	a5,-24(s0)
 bc4:	639c                	ld	a5,0(a5)
 bc6:	fe843703          	ld	a4,-24(s0)
 bca:	00f76f63          	bltu	a4,a5,be8 <free+0x4c>
 bce:	fe043703          	ld	a4,-32(s0)
 bd2:	fe843783          	ld	a5,-24(s0)
 bd6:	02e7eb63          	bltu	a5,a4,c0c <free+0x70>
 bda:	fe843783          	ld	a5,-24(s0)
 bde:	639c                	ld	a5,0(a5)
 be0:	fe043703          	ld	a4,-32(s0)
 be4:	02f76463          	bltu	a4,a5,c0c <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 be8:	fe843783          	ld	a5,-24(s0)
 bec:	639c                	ld	a5,0(a5)
 bee:	fef43423          	sd	a5,-24(s0)
 bf2:	fe043703          	ld	a4,-32(s0)
 bf6:	fe843783          	ld	a5,-24(s0)
 bfa:	fce7f3e3          	bgeu	a5,a4,bc0 <free+0x24>
 bfe:	fe843783          	ld	a5,-24(s0)
 c02:	639c                	ld	a5,0(a5)
 c04:	fe043703          	ld	a4,-32(s0)
 c08:	faf77ce3          	bgeu	a4,a5,bc0 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c0c:	fe043783          	ld	a5,-32(s0)
 c10:	479c                	lw	a5,8(a5)
 c12:	1782                	slli	a5,a5,0x20
 c14:	9381                	srli	a5,a5,0x20
 c16:	0792                	slli	a5,a5,0x4
 c18:	fe043703          	ld	a4,-32(s0)
 c1c:	973e                	add	a4,a4,a5
 c1e:	fe843783          	ld	a5,-24(s0)
 c22:	639c                	ld	a5,0(a5)
 c24:	02f71763          	bne	a4,a5,c52 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 c28:	fe043783          	ld	a5,-32(s0)
 c2c:	4798                	lw	a4,8(a5)
 c2e:	fe843783          	ld	a5,-24(s0)
 c32:	639c                	ld	a5,0(a5)
 c34:	479c                	lw	a5,8(a5)
 c36:	9fb9                	addw	a5,a5,a4
 c38:	0007871b          	sext.w	a4,a5
 c3c:	fe043783          	ld	a5,-32(s0)
 c40:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 c42:	fe843783          	ld	a5,-24(s0)
 c46:	639c                	ld	a5,0(a5)
 c48:	6398                	ld	a4,0(a5)
 c4a:	fe043783          	ld	a5,-32(s0)
 c4e:	e398                	sd	a4,0(a5)
 c50:	a039                	j	c5e <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 c52:	fe843783          	ld	a5,-24(s0)
 c56:	6398                	ld	a4,0(a5)
 c58:	fe043783          	ld	a5,-32(s0)
 c5c:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 c5e:	fe843783          	ld	a5,-24(s0)
 c62:	479c                	lw	a5,8(a5)
 c64:	1782                	slli	a5,a5,0x20
 c66:	9381                	srli	a5,a5,0x20
 c68:	0792                	slli	a5,a5,0x4
 c6a:	fe843703          	ld	a4,-24(s0)
 c6e:	97ba                	add	a5,a5,a4
 c70:	fe043703          	ld	a4,-32(s0)
 c74:	02f71563          	bne	a4,a5,c9e <free+0x102>
    p->s.size += bp->s.size;
 c78:	fe843783          	ld	a5,-24(s0)
 c7c:	4798                	lw	a4,8(a5)
 c7e:	fe043783          	ld	a5,-32(s0)
 c82:	479c                	lw	a5,8(a5)
 c84:	9fb9                	addw	a5,a5,a4
 c86:	0007871b          	sext.w	a4,a5
 c8a:	fe843783          	ld	a5,-24(s0)
 c8e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c90:	fe043783          	ld	a5,-32(s0)
 c94:	6398                	ld	a4,0(a5)
 c96:	fe843783          	ld	a5,-24(s0)
 c9a:	e398                	sd	a4,0(a5)
 c9c:	a031                	j	ca8 <free+0x10c>
  } else
    p->s.ptr = bp;
 c9e:	fe843783          	ld	a5,-24(s0)
 ca2:	fe043703          	ld	a4,-32(s0)
 ca6:	e398                	sd	a4,0(a5)
  freep = p;
 ca8:	00000797          	auipc	a5,0x0
 cac:	45078793          	addi	a5,a5,1104 # 10f8 <freep>
 cb0:	fe843703          	ld	a4,-24(s0)
 cb4:	e398                	sd	a4,0(a5)
}
 cb6:	0001                	nop
 cb8:	7422                	ld	s0,40(sp)
 cba:	6145                	addi	sp,sp,48
 cbc:	8082                	ret

0000000000000cbe <morecore>:

static Header*
morecore(uint nu)
{
 cbe:	7179                	addi	sp,sp,-48
 cc0:	f406                	sd	ra,40(sp)
 cc2:	f022                	sd	s0,32(sp)
 cc4:	1800                	addi	s0,sp,48
 cc6:	87aa                	mv	a5,a0
 cc8:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 ccc:	fdc42783          	lw	a5,-36(s0)
 cd0:	0007871b          	sext.w	a4,a5
 cd4:	6785                	lui	a5,0x1
 cd6:	00f77563          	bgeu	a4,a5,ce0 <morecore+0x22>
    nu = 4096;
 cda:	6785                	lui	a5,0x1
 cdc:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 ce0:	fdc42783          	lw	a5,-36(s0)
 ce4:	0047979b          	slliw	a5,a5,0x4
 ce8:	2781                	sext.w	a5,a5
 cea:	2781                	sext.w	a5,a5
 cec:	853e                	mv	a0,a5
 cee:	00000097          	auipc	ra,0x0
 cf2:	9a8080e7          	jalr	-1624(ra) # 696 <sbrk>
 cf6:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 cfa:	fe843703          	ld	a4,-24(s0)
 cfe:	57fd                	li	a5,-1
 d00:	00f71463          	bne	a4,a5,d08 <morecore+0x4a>
    return 0;
 d04:	4781                	li	a5,0
 d06:	a03d                	j	d34 <morecore+0x76>
  hp = (Header*)p;
 d08:	fe843783          	ld	a5,-24(s0)
 d0c:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 d10:	fe043783          	ld	a5,-32(s0)
 d14:	fdc42703          	lw	a4,-36(s0)
 d18:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 d1a:	fe043783          	ld	a5,-32(s0)
 d1e:	07c1                	addi	a5,a5,16
 d20:	853e                	mv	a0,a5
 d22:	00000097          	auipc	ra,0x0
 d26:	e7a080e7          	jalr	-390(ra) # b9c <free>
  return freep;
 d2a:	00000797          	auipc	a5,0x0
 d2e:	3ce78793          	addi	a5,a5,974 # 10f8 <freep>
 d32:	639c                	ld	a5,0(a5)
}
 d34:	853e                	mv	a0,a5
 d36:	70a2                	ld	ra,40(sp)
 d38:	7402                	ld	s0,32(sp)
 d3a:	6145                	addi	sp,sp,48
 d3c:	8082                	ret

0000000000000d3e <malloc>:

void*
malloc(uint nbytes)
{
 d3e:	7139                	addi	sp,sp,-64
 d40:	fc06                	sd	ra,56(sp)
 d42:	f822                	sd	s0,48(sp)
 d44:	0080                	addi	s0,sp,64
 d46:	87aa                	mv	a5,a0
 d48:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d4c:	fcc46783          	lwu	a5,-52(s0)
 d50:	07bd                	addi	a5,a5,15
 d52:	8391                	srli	a5,a5,0x4
 d54:	2781                	sext.w	a5,a5
 d56:	2785                	addiw	a5,a5,1
 d58:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 d5c:	00000797          	auipc	a5,0x0
 d60:	39c78793          	addi	a5,a5,924 # 10f8 <freep>
 d64:	639c                	ld	a5,0(a5)
 d66:	fef43023          	sd	a5,-32(s0)
 d6a:	fe043783          	ld	a5,-32(s0)
 d6e:	ef95                	bnez	a5,daa <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 d70:	00000797          	auipc	a5,0x0
 d74:	37878793          	addi	a5,a5,888 # 10e8 <base>
 d78:	fef43023          	sd	a5,-32(s0)
 d7c:	00000797          	auipc	a5,0x0
 d80:	37c78793          	addi	a5,a5,892 # 10f8 <freep>
 d84:	fe043703          	ld	a4,-32(s0)
 d88:	e398                	sd	a4,0(a5)
 d8a:	00000797          	auipc	a5,0x0
 d8e:	36e78793          	addi	a5,a5,878 # 10f8 <freep>
 d92:	6398                	ld	a4,0(a5)
 d94:	00000797          	auipc	a5,0x0
 d98:	35478793          	addi	a5,a5,852 # 10e8 <base>
 d9c:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 d9e:	00000797          	auipc	a5,0x0
 da2:	34a78793          	addi	a5,a5,842 # 10e8 <base>
 da6:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 daa:	fe043783          	ld	a5,-32(s0)
 dae:	639c                	ld	a5,0(a5)
 db0:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 db4:	fe843783          	ld	a5,-24(s0)
 db8:	4798                	lw	a4,8(a5)
 dba:	fdc42783          	lw	a5,-36(s0)
 dbe:	2781                	sext.w	a5,a5
 dc0:	06f76863          	bltu	a4,a5,e30 <malloc+0xf2>
      if(p->s.size == nunits)
 dc4:	fe843783          	ld	a5,-24(s0)
 dc8:	4798                	lw	a4,8(a5)
 dca:	fdc42783          	lw	a5,-36(s0)
 dce:	2781                	sext.w	a5,a5
 dd0:	00e79963          	bne	a5,a4,de2 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 dd4:	fe843783          	ld	a5,-24(s0)
 dd8:	6398                	ld	a4,0(a5)
 dda:	fe043783          	ld	a5,-32(s0)
 dde:	e398                	sd	a4,0(a5)
 de0:	a82d                	j	e1a <malloc+0xdc>
      else {
        p->s.size -= nunits;
 de2:	fe843783          	ld	a5,-24(s0)
 de6:	4798                	lw	a4,8(a5)
 de8:	fdc42783          	lw	a5,-36(s0)
 dec:	40f707bb          	subw	a5,a4,a5
 df0:	0007871b          	sext.w	a4,a5
 df4:	fe843783          	ld	a5,-24(s0)
 df8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 dfa:	fe843783          	ld	a5,-24(s0)
 dfe:	479c                	lw	a5,8(a5)
 e00:	1782                	slli	a5,a5,0x20
 e02:	9381                	srli	a5,a5,0x20
 e04:	0792                	slli	a5,a5,0x4
 e06:	fe843703          	ld	a4,-24(s0)
 e0a:	97ba                	add	a5,a5,a4
 e0c:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 e10:	fe843783          	ld	a5,-24(s0)
 e14:	fdc42703          	lw	a4,-36(s0)
 e18:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 e1a:	00000797          	auipc	a5,0x0
 e1e:	2de78793          	addi	a5,a5,734 # 10f8 <freep>
 e22:	fe043703          	ld	a4,-32(s0)
 e26:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 e28:	fe843783          	ld	a5,-24(s0)
 e2c:	07c1                	addi	a5,a5,16
 e2e:	a091                	j	e72 <malloc+0x134>
    }
    if(p == freep)
 e30:	00000797          	auipc	a5,0x0
 e34:	2c878793          	addi	a5,a5,712 # 10f8 <freep>
 e38:	639c                	ld	a5,0(a5)
 e3a:	fe843703          	ld	a4,-24(s0)
 e3e:	02f71063          	bne	a4,a5,e5e <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 e42:	fdc42783          	lw	a5,-36(s0)
 e46:	853e                	mv	a0,a5
 e48:	00000097          	auipc	ra,0x0
 e4c:	e76080e7          	jalr	-394(ra) # cbe <morecore>
 e50:	fea43423          	sd	a0,-24(s0)
 e54:	fe843783          	ld	a5,-24(s0)
 e58:	e399                	bnez	a5,e5e <malloc+0x120>
        return 0;
 e5a:	4781                	li	a5,0
 e5c:	a819                	j	e72 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e5e:	fe843783          	ld	a5,-24(s0)
 e62:	fef43023          	sd	a5,-32(s0)
 e66:	fe843783          	ld	a5,-24(s0)
 e6a:	639c                	ld	a5,0(a5)
 e6c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 e70:	b791                	j	db4 <malloc+0x76>
  }
}
 e72:	853e                	mv	a0,a5
 e74:	70e2                	ld	ra,56(sp)
 e76:	7442                	ld	s0,48(sp)
 e78:	6121                	addi	sp,sp,64
 e7a:	8082                	ret
