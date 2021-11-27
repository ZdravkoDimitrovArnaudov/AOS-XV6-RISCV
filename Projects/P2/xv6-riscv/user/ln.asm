
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
  24:	d7058593          	addi	a1,a1,-656 # d90 <malloc+0x142>
  28:	4509                	li	a0,2
  2a:	00001097          	auipc	ra,0x1
  2e:	9da080e7          	jalr	-1574(ra) # a04 <fprintf>
    exit(1);
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	4ea080e7          	jalr	1258(ra) # 51e <exit>
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
  54:	52e080e7          	jalr	1326(ra) # 57e <link>
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
  76:	d3658593          	addi	a1,a1,-714 # da8 <malloc+0x15a>
  7a:	4509                	li	a0,2
  7c:	00001097          	auipc	ra,0x1
  80:	988080e7          	jalr	-1656(ra) # a04 <fprintf>
  exit(0);
  84:	4501                	li	a0,0
  86:	00000097          	auipc	ra,0x0
  8a:	498080e7          	jalr	1176(ra) # 51e <exit>

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
 1a8:	0ff77713          	andi	a4,a4,255
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
 1f2:	0ff7f793          	andi	a5,a5,255
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
 244:	2f6080e7          	jalr	758(ra) # 536 <read>
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
 2da:	288080e7          	jalr	648(ra) # 55e <open>
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
 300:	27a080e7          	jalr	634(ra) # 576 <fstat>
 304:	87aa                	mv	a5,a0
 306:	fef42423          	sw	a5,-24(s0)
  close(fd);
 30a:	fec42783          	lw	a5,-20(s0)
 30e:	853e                	mv	a0,a5
 310:	00000097          	auipc	ra,0x0
 314:	236080e7          	jalr	566(ra) # 546 <close>
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
 334:	a815                	j	368 <atoi+0x42>
    n = n*10 + *s++ - '0';
 336:	fec42703          	lw	a4,-20(s0)
 33a:	87ba                	mv	a5,a4
 33c:	0027979b          	slliw	a5,a5,0x2
 340:	9fb9                	addw	a5,a5,a4
 342:	0017979b          	slliw	a5,a5,0x1
 346:	0007871b          	sext.w	a4,a5
 34a:	fd843783          	ld	a5,-40(s0)
 34e:	00178693          	addi	a3,a5,1
 352:	fcd43c23          	sd	a3,-40(s0)
 356:	0007c783          	lbu	a5,0(a5)
 35a:	2781                	sext.w	a5,a5
 35c:	9fb9                	addw	a5,a5,a4
 35e:	2781                	sext.w	a5,a5
 360:	fd07879b          	addiw	a5,a5,-48
 364:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 368:	fd843783          	ld	a5,-40(s0)
 36c:	0007c783          	lbu	a5,0(a5)
 370:	873e                	mv	a4,a5
 372:	02f00793          	li	a5,47
 376:	00e7fb63          	bgeu	a5,a4,38c <atoi+0x66>
 37a:	fd843783          	ld	a5,-40(s0)
 37e:	0007c783          	lbu	a5,0(a5)
 382:	873e                	mv	a4,a5
 384:	03900793          	li	a5,57
 388:	fae7f7e3          	bgeu	a5,a4,336 <atoi+0x10>
  return n;
 38c:	fec42783          	lw	a5,-20(s0)
}
 390:	853e                	mv	a0,a5
 392:	7422                	ld	s0,40(sp)
 394:	6145                	addi	sp,sp,48
 396:	8082                	ret

0000000000000398 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 398:	7139                	addi	sp,sp,-64
 39a:	fc22                	sd	s0,56(sp)
 39c:	0080                	addi	s0,sp,64
 39e:	fca43c23          	sd	a0,-40(s0)
 3a2:	fcb43823          	sd	a1,-48(s0)
 3a6:	87b2                	mv	a5,a2
 3a8:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3ac:	fd843783          	ld	a5,-40(s0)
 3b0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3b4:	fd043783          	ld	a5,-48(s0)
 3b8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3bc:	fe043703          	ld	a4,-32(s0)
 3c0:	fe843783          	ld	a5,-24(s0)
 3c4:	02e7fc63          	bgeu	a5,a4,3fc <memmove+0x64>
    while(n-- > 0)
 3c8:	a00d                	j	3ea <memmove+0x52>
      *dst++ = *src++;
 3ca:	fe043703          	ld	a4,-32(s0)
 3ce:	00170793          	addi	a5,a4,1
 3d2:	fef43023          	sd	a5,-32(s0)
 3d6:	fe843783          	ld	a5,-24(s0)
 3da:	00178693          	addi	a3,a5,1
 3de:	fed43423          	sd	a3,-24(s0)
 3e2:	00074703          	lbu	a4,0(a4)
 3e6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3ea:	fcc42783          	lw	a5,-52(s0)
 3ee:	fff7871b          	addiw	a4,a5,-1
 3f2:	fce42623          	sw	a4,-52(s0)
 3f6:	fcf04ae3          	bgtz	a5,3ca <memmove+0x32>
 3fa:	a891                	j	44e <memmove+0xb6>
  } else {
    dst += n;
 3fc:	fcc42783          	lw	a5,-52(s0)
 400:	fe843703          	ld	a4,-24(s0)
 404:	97ba                	add	a5,a5,a4
 406:	fef43423          	sd	a5,-24(s0)
    src += n;
 40a:	fcc42783          	lw	a5,-52(s0)
 40e:	fe043703          	ld	a4,-32(s0)
 412:	97ba                	add	a5,a5,a4
 414:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 418:	a01d                	j	43e <memmove+0xa6>
      *--dst = *--src;
 41a:	fe043783          	ld	a5,-32(s0)
 41e:	17fd                	addi	a5,a5,-1
 420:	fef43023          	sd	a5,-32(s0)
 424:	fe843783          	ld	a5,-24(s0)
 428:	17fd                	addi	a5,a5,-1
 42a:	fef43423          	sd	a5,-24(s0)
 42e:	fe043783          	ld	a5,-32(s0)
 432:	0007c703          	lbu	a4,0(a5)
 436:	fe843783          	ld	a5,-24(s0)
 43a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 43e:	fcc42783          	lw	a5,-52(s0)
 442:	fff7871b          	addiw	a4,a5,-1
 446:	fce42623          	sw	a4,-52(s0)
 44a:	fcf048e3          	bgtz	a5,41a <memmove+0x82>
  }
  return vdst;
 44e:	fd843783          	ld	a5,-40(s0)
}
 452:	853e                	mv	a0,a5
 454:	7462                	ld	s0,56(sp)
 456:	6121                	addi	sp,sp,64
 458:	8082                	ret

000000000000045a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 45a:	7139                	addi	sp,sp,-64
 45c:	fc22                	sd	s0,56(sp)
 45e:	0080                	addi	s0,sp,64
 460:	fca43c23          	sd	a0,-40(s0)
 464:	fcb43823          	sd	a1,-48(s0)
 468:	87b2                	mv	a5,a2
 46a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 46e:	fd843783          	ld	a5,-40(s0)
 472:	fef43423          	sd	a5,-24(s0)
 476:	fd043783          	ld	a5,-48(s0)
 47a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 47e:	a0a1                	j	4c6 <memcmp+0x6c>
    if (*p1 != *p2) {
 480:	fe843783          	ld	a5,-24(s0)
 484:	0007c703          	lbu	a4,0(a5)
 488:	fe043783          	ld	a5,-32(s0)
 48c:	0007c783          	lbu	a5,0(a5)
 490:	02f70163          	beq	a4,a5,4b2 <memcmp+0x58>
      return *p1 - *p2;
 494:	fe843783          	ld	a5,-24(s0)
 498:	0007c783          	lbu	a5,0(a5)
 49c:	0007871b          	sext.w	a4,a5
 4a0:	fe043783          	ld	a5,-32(s0)
 4a4:	0007c783          	lbu	a5,0(a5)
 4a8:	2781                	sext.w	a5,a5
 4aa:	40f707bb          	subw	a5,a4,a5
 4ae:	2781                	sext.w	a5,a5
 4b0:	a01d                	j	4d6 <memcmp+0x7c>
    }
    p1++;
 4b2:	fe843783          	ld	a5,-24(s0)
 4b6:	0785                	addi	a5,a5,1
 4b8:	fef43423          	sd	a5,-24(s0)
    p2++;
 4bc:	fe043783          	ld	a5,-32(s0)
 4c0:	0785                	addi	a5,a5,1
 4c2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4c6:	fcc42783          	lw	a5,-52(s0)
 4ca:	fff7871b          	addiw	a4,a5,-1
 4ce:	fce42623          	sw	a4,-52(s0)
 4d2:	f7dd                	bnez	a5,480 <memcmp+0x26>
  }
  return 0;
 4d4:	4781                	li	a5,0
}
 4d6:	853e                	mv	a0,a5
 4d8:	7462                	ld	s0,56(sp)
 4da:	6121                	addi	sp,sp,64
 4dc:	8082                	ret

00000000000004de <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4de:	7179                	addi	sp,sp,-48
 4e0:	f406                	sd	ra,40(sp)
 4e2:	f022                	sd	s0,32(sp)
 4e4:	1800                	addi	s0,sp,48
 4e6:	fea43423          	sd	a0,-24(s0)
 4ea:	feb43023          	sd	a1,-32(s0)
 4ee:	87b2                	mv	a5,a2
 4f0:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 4f4:	fdc42783          	lw	a5,-36(s0)
 4f8:	863e                	mv	a2,a5
 4fa:	fe043583          	ld	a1,-32(s0)
 4fe:	fe843503          	ld	a0,-24(s0)
 502:	00000097          	auipc	ra,0x0
 506:	e96080e7          	jalr	-362(ra) # 398 <memmove>
 50a:	87aa                	mv	a5,a0
}
 50c:	853e                	mv	a0,a5
 50e:	70a2                	ld	ra,40(sp)
 510:	7402                	ld	s0,32(sp)
 512:	6145                	addi	sp,sp,48
 514:	8082                	ret

0000000000000516 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 516:	4885                	li	a7,1
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <exit>:
.global exit
exit:
 li a7, SYS_exit
 51e:	4889                	li	a7,2
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <wait>:
.global wait
wait:
 li a7, SYS_wait
 526:	488d                	li	a7,3
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 52e:	4891                	li	a7,4
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <read>:
.global read
read:
 li a7, SYS_read
 536:	4895                	li	a7,5
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <write>:
.global write
write:
 li a7, SYS_write
 53e:	48c1                	li	a7,16
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <close>:
.global close
close:
 li a7, SYS_close
 546:	48d5                	li	a7,21
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <kill>:
.global kill
kill:
 li a7, SYS_kill
 54e:	4899                	li	a7,6
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <exec>:
.global exec
exec:
 li a7, SYS_exec
 556:	489d                	li	a7,7
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <open>:
.global open
open:
 li a7, SYS_open
 55e:	48bd                	li	a7,15
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 566:	48c5                	li	a7,17
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 56e:	48c9                	li	a7,18
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 576:	48a1                	li	a7,8
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <link>:
.global link
link:
 li a7, SYS_link
 57e:	48cd                	li	a7,19
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 586:	48d1                	li	a7,20
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 58e:	48a5                	li	a7,9
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <dup>:
.global dup
dup:
 li a7, SYS_dup
 596:	48a9                	li	a7,10
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 59e:	48ad                	li	a7,11
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5a6:	48b1                	li	a7,12
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5ae:	48b5                	li	a7,13
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5b6:	48b9                	li	a7,14
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 5be:	48d9                	li	a7,22
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <setpri>:
.global setpri
setpri:
 li a7, SYS_setpri
 5c6:	48dd                	li	a7,23
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5ce:	1101                	addi	sp,sp,-32
 5d0:	ec06                	sd	ra,24(sp)
 5d2:	e822                	sd	s0,16(sp)
 5d4:	1000                	addi	s0,sp,32
 5d6:	87aa                	mv	a5,a0
 5d8:	872e                	mv	a4,a1
 5da:	fef42623          	sw	a5,-20(s0)
 5de:	87ba                	mv	a5,a4
 5e0:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 5e4:	feb40713          	addi	a4,s0,-21
 5e8:	fec42783          	lw	a5,-20(s0)
 5ec:	4605                	li	a2,1
 5ee:	85ba                	mv	a1,a4
 5f0:	853e                	mv	a0,a5
 5f2:	00000097          	auipc	ra,0x0
 5f6:	f4c080e7          	jalr	-180(ra) # 53e <write>
}
 5fa:	0001                	nop
 5fc:	60e2                	ld	ra,24(sp)
 5fe:	6442                	ld	s0,16(sp)
 600:	6105                	addi	sp,sp,32
 602:	8082                	ret

0000000000000604 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 604:	7139                	addi	sp,sp,-64
 606:	fc06                	sd	ra,56(sp)
 608:	f822                	sd	s0,48(sp)
 60a:	0080                	addi	s0,sp,64
 60c:	87aa                	mv	a5,a0
 60e:	8736                	mv	a4,a3
 610:	fcf42623          	sw	a5,-52(s0)
 614:	87ae                	mv	a5,a1
 616:	fcf42423          	sw	a5,-56(s0)
 61a:	87b2                	mv	a5,a2
 61c:	fcf42223          	sw	a5,-60(s0)
 620:	87ba                	mv	a5,a4
 622:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 626:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 62a:	fc042783          	lw	a5,-64(s0)
 62e:	2781                	sext.w	a5,a5
 630:	c38d                	beqz	a5,652 <printint+0x4e>
 632:	fc842783          	lw	a5,-56(s0)
 636:	2781                	sext.w	a5,a5
 638:	0007dd63          	bgez	a5,652 <printint+0x4e>
    neg = 1;
 63c:	4785                	li	a5,1
 63e:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 642:	fc842783          	lw	a5,-56(s0)
 646:	40f007bb          	negw	a5,a5
 64a:	2781                	sext.w	a5,a5
 64c:	fef42223          	sw	a5,-28(s0)
 650:	a029                	j	65a <printint+0x56>
  } else {
    x = xx;
 652:	fc842783          	lw	a5,-56(s0)
 656:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 65a:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 65e:	fc442783          	lw	a5,-60(s0)
 662:	fe442703          	lw	a4,-28(s0)
 666:	02f777bb          	remuw	a5,a4,a5
 66a:	0007861b          	sext.w	a2,a5
 66e:	fec42783          	lw	a5,-20(s0)
 672:	0017871b          	addiw	a4,a5,1
 676:	fee42623          	sw	a4,-20(s0)
 67a:	00000697          	auipc	a3,0x0
 67e:	74e68693          	addi	a3,a3,1870 # dc8 <digits>
 682:	02061713          	slli	a4,a2,0x20
 686:	9301                	srli	a4,a4,0x20
 688:	9736                	add	a4,a4,a3
 68a:	00074703          	lbu	a4,0(a4)
 68e:	ff040693          	addi	a3,s0,-16
 692:	97b6                	add	a5,a5,a3
 694:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 698:	fc442783          	lw	a5,-60(s0)
 69c:	fe442703          	lw	a4,-28(s0)
 6a0:	02f757bb          	divuw	a5,a4,a5
 6a4:	fef42223          	sw	a5,-28(s0)
 6a8:	fe442783          	lw	a5,-28(s0)
 6ac:	2781                	sext.w	a5,a5
 6ae:	fbc5                	bnez	a5,65e <printint+0x5a>
  if(neg)
 6b0:	fe842783          	lw	a5,-24(s0)
 6b4:	2781                	sext.w	a5,a5
 6b6:	cf95                	beqz	a5,6f2 <printint+0xee>
    buf[i++] = '-';
 6b8:	fec42783          	lw	a5,-20(s0)
 6bc:	0017871b          	addiw	a4,a5,1
 6c0:	fee42623          	sw	a4,-20(s0)
 6c4:	ff040713          	addi	a4,s0,-16
 6c8:	97ba                	add	a5,a5,a4
 6ca:	02d00713          	li	a4,45
 6ce:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6d2:	a005                	j	6f2 <printint+0xee>
    putc(fd, buf[i]);
 6d4:	fec42783          	lw	a5,-20(s0)
 6d8:	ff040713          	addi	a4,s0,-16
 6dc:	97ba                	add	a5,a5,a4
 6de:	fe07c703          	lbu	a4,-32(a5)
 6e2:	fcc42783          	lw	a5,-52(s0)
 6e6:	85ba                	mv	a1,a4
 6e8:	853e                	mv	a0,a5
 6ea:	00000097          	auipc	ra,0x0
 6ee:	ee4080e7          	jalr	-284(ra) # 5ce <putc>
  while(--i >= 0)
 6f2:	fec42783          	lw	a5,-20(s0)
 6f6:	37fd                	addiw	a5,a5,-1
 6f8:	fef42623          	sw	a5,-20(s0)
 6fc:	fec42783          	lw	a5,-20(s0)
 700:	2781                	sext.w	a5,a5
 702:	fc07d9e3          	bgez	a5,6d4 <printint+0xd0>
}
 706:	0001                	nop
 708:	0001                	nop
 70a:	70e2                	ld	ra,56(sp)
 70c:	7442                	ld	s0,48(sp)
 70e:	6121                	addi	sp,sp,64
 710:	8082                	ret

0000000000000712 <printptr>:

static void
printptr(int fd, uint64 x) {
 712:	7179                	addi	sp,sp,-48
 714:	f406                	sd	ra,40(sp)
 716:	f022                	sd	s0,32(sp)
 718:	1800                	addi	s0,sp,48
 71a:	87aa                	mv	a5,a0
 71c:	fcb43823          	sd	a1,-48(s0)
 720:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 724:	fdc42783          	lw	a5,-36(s0)
 728:	03000593          	li	a1,48
 72c:	853e                	mv	a0,a5
 72e:	00000097          	auipc	ra,0x0
 732:	ea0080e7          	jalr	-352(ra) # 5ce <putc>
  putc(fd, 'x');
 736:	fdc42783          	lw	a5,-36(s0)
 73a:	07800593          	li	a1,120
 73e:	853e                	mv	a0,a5
 740:	00000097          	auipc	ra,0x0
 744:	e8e080e7          	jalr	-370(ra) # 5ce <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 748:	fe042623          	sw	zero,-20(s0)
 74c:	a82d                	j	786 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 74e:	fd043783          	ld	a5,-48(s0)
 752:	93f1                	srli	a5,a5,0x3c
 754:	00000717          	auipc	a4,0x0
 758:	67470713          	addi	a4,a4,1652 # dc8 <digits>
 75c:	97ba                	add	a5,a5,a4
 75e:	0007c703          	lbu	a4,0(a5)
 762:	fdc42783          	lw	a5,-36(s0)
 766:	85ba                	mv	a1,a4
 768:	853e                	mv	a0,a5
 76a:	00000097          	auipc	ra,0x0
 76e:	e64080e7          	jalr	-412(ra) # 5ce <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 772:	fec42783          	lw	a5,-20(s0)
 776:	2785                	addiw	a5,a5,1
 778:	fef42623          	sw	a5,-20(s0)
 77c:	fd043783          	ld	a5,-48(s0)
 780:	0792                	slli	a5,a5,0x4
 782:	fcf43823          	sd	a5,-48(s0)
 786:	fec42783          	lw	a5,-20(s0)
 78a:	873e                	mv	a4,a5
 78c:	47bd                	li	a5,15
 78e:	fce7f0e3          	bgeu	a5,a4,74e <printptr+0x3c>
}
 792:	0001                	nop
 794:	0001                	nop
 796:	70a2                	ld	ra,40(sp)
 798:	7402                	ld	s0,32(sp)
 79a:	6145                	addi	sp,sp,48
 79c:	8082                	ret

000000000000079e <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 79e:	715d                	addi	sp,sp,-80
 7a0:	e486                	sd	ra,72(sp)
 7a2:	e0a2                	sd	s0,64(sp)
 7a4:	0880                	addi	s0,sp,80
 7a6:	87aa                	mv	a5,a0
 7a8:	fcb43023          	sd	a1,-64(s0)
 7ac:	fac43c23          	sd	a2,-72(s0)
 7b0:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 7b4:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7b8:	fe042223          	sw	zero,-28(s0)
 7bc:	a42d                	j	9e6 <vprintf+0x248>
    c = fmt[i] & 0xff;
 7be:	fe442783          	lw	a5,-28(s0)
 7c2:	fc043703          	ld	a4,-64(s0)
 7c6:	97ba                	add	a5,a5,a4
 7c8:	0007c783          	lbu	a5,0(a5)
 7cc:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7d0:	fe042783          	lw	a5,-32(s0)
 7d4:	2781                	sext.w	a5,a5
 7d6:	eb9d                	bnez	a5,80c <vprintf+0x6e>
      if(c == '%'){
 7d8:	fdc42783          	lw	a5,-36(s0)
 7dc:	0007871b          	sext.w	a4,a5
 7e0:	02500793          	li	a5,37
 7e4:	00f71763          	bne	a4,a5,7f2 <vprintf+0x54>
        state = '%';
 7e8:	02500793          	li	a5,37
 7ec:	fef42023          	sw	a5,-32(s0)
 7f0:	a2f5                	j	9dc <vprintf+0x23e>
      } else {
        putc(fd, c);
 7f2:	fdc42783          	lw	a5,-36(s0)
 7f6:	0ff7f713          	andi	a4,a5,255
 7fa:	fcc42783          	lw	a5,-52(s0)
 7fe:	85ba                	mv	a1,a4
 800:	853e                	mv	a0,a5
 802:	00000097          	auipc	ra,0x0
 806:	dcc080e7          	jalr	-564(ra) # 5ce <putc>
 80a:	aac9                	j	9dc <vprintf+0x23e>
      }
    } else if(state == '%'){
 80c:	fe042783          	lw	a5,-32(s0)
 810:	0007871b          	sext.w	a4,a5
 814:	02500793          	li	a5,37
 818:	1cf71263          	bne	a4,a5,9dc <vprintf+0x23e>
      if(c == 'd'){
 81c:	fdc42783          	lw	a5,-36(s0)
 820:	0007871b          	sext.w	a4,a5
 824:	06400793          	li	a5,100
 828:	02f71463          	bne	a4,a5,850 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 82c:	fb843783          	ld	a5,-72(s0)
 830:	00878713          	addi	a4,a5,8
 834:	fae43c23          	sd	a4,-72(s0)
 838:	4398                	lw	a4,0(a5)
 83a:	fcc42783          	lw	a5,-52(s0)
 83e:	4685                	li	a3,1
 840:	4629                	li	a2,10
 842:	85ba                	mv	a1,a4
 844:	853e                	mv	a0,a5
 846:	00000097          	auipc	ra,0x0
 84a:	dbe080e7          	jalr	-578(ra) # 604 <printint>
 84e:	a269                	j	9d8 <vprintf+0x23a>
      } else if(c == 'l') {
 850:	fdc42783          	lw	a5,-36(s0)
 854:	0007871b          	sext.w	a4,a5
 858:	06c00793          	li	a5,108
 85c:	02f71663          	bne	a4,a5,888 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 860:	fb843783          	ld	a5,-72(s0)
 864:	00878713          	addi	a4,a5,8
 868:	fae43c23          	sd	a4,-72(s0)
 86c:	639c                	ld	a5,0(a5)
 86e:	0007871b          	sext.w	a4,a5
 872:	fcc42783          	lw	a5,-52(s0)
 876:	4681                	li	a3,0
 878:	4629                	li	a2,10
 87a:	85ba                	mv	a1,a4
 87c:	853e                	mv	a0,a5
 87e:	00000097          	auipc	ra,0x0
 882:	d86080e7          	jalr	-634(ra) # 604 <printint>
 886:	aa89                	j	9d8 <vprintf+0x23a>
      } else if(c == 'x') {
 888:	fdc42783          	lw	a5,-36(s0)
 88c:	0007871b          	sext.w	a4,a5
 890:	07800793          	li	a5,120
 894:	02f71463          	bne	a4,a5,8bc <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 898:	fb843783          	ld	a5,-72(s0)
 89c:	00878713          	addi	a4,a5,8
 8a0:	fae43c23          	sd	a4,-72(s0)
 8a4:	4398                	lw	a4,0(a5)
 8a6:	fcc42783          	lw	a5,-52(s0)
 8aa:	4681                	li	a3,0
 8ac:	4641                	li	a2,16
 8ae:	85ba                	mv	a1,a4
 8b0:	853e                	mv	a0,a5
 8b2:	00000097          	auipc	ra,0x0
 8b6:	d52080e7          	jalr	-686(ra) # 604 <printint>
 8ba:	aa39                	j	9d8 <vprintf+0x23a>
      } else if(c == 'p') {
 8bc:	fdc42783          	lw	a5,-36(s0)
 8c0:	0007871b          	sext.w	a4,a5
 8c4:	07000793          	li	a5,112
 8c8:	02f71263          	bne	a4,a5,8ec <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8cc:	fb843783          	ld	a5,-72(s0)
 8d0:	00878713          	addi	a4,a5,8
 8d4:	fae43c23          	sd	a4,-72(s0)
 8d8:	6398                	ld	a4,0(a5)
 8da:	fcc42783          	lw	a5,-52(s0)
 8de:	85ba                	mv	a1,a4
 8e0:	853e                	mv	a0,a5
 8e2:	00000097          	auipc	ra,0x0
 8e6:	e30080e7          	jalr	-464(ra) # 712 <printptr>
 8ea:	a0fd                	j	9d8 <vprintf+0x23a>
      } else if(c == 's'){
 8ec:	fdc42783          	lw	a5,-36(s0)
 8f0:	0007871b          	sext.w	a4,a5
 8f4:	07300793          	li	a5,115
 8f8:	04f71c63          	bne	a4,a5,950 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 8fc:	fb843783          	ld	a5,-72(s0)
 900:	00878713          	addi	a4,a5,8
 904:	fae43c23          	sd	a4,-72(s0)
 908:	639c                	ld	a5,0(a5)
 90a:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 90e:	fe843783          	ld	a5,-24(s0)
 912:	eb8d                	bnez	a5,944 <vprintf+0x1a6>
          s = "(null)";
 914:	00000797          	auipc	a5,0x0
 918:	4ac78793          	addi	a5,a5,1196 # dc0 <malloc+0x172>
 91c:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 920:	a015                	j	944 <vprintf+0x1a6>
          putc(fd, *s);
 922:	fe843783          	ld	a5,-24(s0)
 926:	0007c703          	lbu	a4,0(a5)
 92a:	fcc42783          	lw	a5,-52(s0)
 92e:	85ba                	mv	a1,a4
 930:	853e                	mv	a0,a5
 932:	00000097          	auipc	ra,0x0
 936:	c9c080e7          	jalr	-868(ra) # 5ce <putc>
          s++;
 93a:	fe843783          	ld	a5,-24(s0)
 93e:	0785                	addi	a5,a5,1
 940:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 944:	fe843783          	ld	a5,-24(s0)
 948:	0007c783          	lbu	a5,0(a5)
 94c:	fbf9                	bnez	a5,922 <vprintf+0x184>
 94e:	a069                	j	9d8 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 950:	fdc42783          	lw	a5,-36(s0)
 954:	0007871b          	sext.w	a4,a5
 958:	06300793          	li	a5,99
 95c:	02f71463          	bne	a4,a5,984 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 960:	fb843783          	ld	a5,-72(s0)
 964:	00878713          	addi	a4,a5,8
 968:	fae43c23          	sd	a4,-72(s0)
 96c:	439c                	lw	a5,0(a5)
 96e:	0ff7f713          	andi	a4,a5,255
 972:	fcc42783          	lw	a5,-52(s0)
 976:	85ba                	mv	a1,a4
 978:	853e                	mv	a0,a5
 97a:	00000097          	auipc	ra,0x0
 97e:	c54080e7          	jalr	-940(ra) # 5ce <putc>
 982:	a899                	j	9d8 <vprintf+0x23a>
      } else if(c == '%'){
 984:	fdc42783          	lw	a5,-36(s0)
 988:	0007871b          	sext.w	a4,a5
 98c:	02500793          	li	a5,37
 990:	00f71f63          	bne	a4,a5,9ae <vprintf+0x210>
        putc(fd, c);
 994:	fdc42783          	lw	a5,-36(s0)
 998:	0ff7f713          	andi	a4,a5,255
 99c:	fcc42783          	lw	a5,-52(s0)
 9a0:	85ba                	mv	a1,a4
 9a2:	853e                	mv	a0,a5
 9a4:	00000097          	auipc	ra,0x0
 9a8:	c2a080e7          	jalr	-982(ra) # 5ce <putc>
 9ac:	a035                	j	9d8 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9ae:	fcc42783          	lw	a5,-52(s0)
 9b2:	02500593          	li	a1,37
 9b6:	853e                	mv	a0,a5
 9b8:	00000097          	auipc	ra,0x0
 9bc:	c16080e7          	jalr	-1002(ra) # 5ce <putc>
        putc(fd, c);
 9c0:	fdc42783          	lw	a5,-36(s0)
 9c4:	0ff7f713          	andi	a4,a5,255
 9c8:	fcc42783          	lw	a5,-52(s0)
 9cc:	85ba                	mv	a1,a4
 9ce:	853e                	mv	a0,a5
 9d0:	00000097          	auipc	ra,0x0
 9d4:	bfe080e7          	jalr	-1026(ra) # 5ce <putc>
      }
      state = 0;
 9d8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 9dc:	fe442783          	lw	a5,-28(s0)
 9e0:	2785                	addiw	a5,a5,1
 9e2:	fef42223          	sw	a5,-28(s0)
 9e6:	fe442783          	lw	a5,-28(s0)
 9ea:	fc043703          	ld	a4,-64(s0)
 9ee:	97ba                	add	a5,a5,a4
 9f0:	0007c783          	lbu	a5,0(a5)
 9f4:	dc0795e3          	bnez	a5,7be <vprintf+0x20>
    }
  }
}
 9f8:	0001                	nop
 9fa:	0001                	nop
 9fc:	60a6                	ld	ra,72(sp)
 9fe:	6406                	ld	s0,64(sp)
 a00:	6161                	addi	sp,sp,80
 a02:	8082                	ret

0000000000000a04 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a04:	7159                	addi	sp,sp,-112
 a06:	fc06                	sd	ra,56(sp)
 a08:	f822                	sd	s0,48(sp)
 a0a:	0080                	addi	s0,sp,64
 a0c:	fcb43823          	sd	a1,-48(s0)
 a10:	e010                	sd	a2,0(s0)
 a12:	e414                	sd	a3,8(s0)
 a14:	e818                	sd	a4,16(s0)
 a16:	ec1c                	sd	a5,24(s0)
 a18:	03043023          	sd	a6,32(s0)
 a1c:	03143423          	sd	a7,40(s0)
 a20:	87aa                	mv	a5,a0
 a22:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a26:	03040793          	addi	a5,s0,48
 a2a:	fcf43423          	sd	a5,-56(s0)
 a2e:	fc843783          	ld	a5,-56(s0)
 a32:	fd078793          	addi	a5,a5,-48
 a36:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a3a:	fe843703          	ld	a4,-24(s0)
 a3e:	fdc42783          	lw	a5,-36(s0)
 a42:	863a                	mv	a2,a4
 a44:	fd043583          	ld	a1,-48(s0)
 a48:	853e                	mv	a0,a5
 a4a:	00000097          	auipc	ra,0x0
 a4e:	d54080e7          	jalr	-684(ra) # 79e <vprintf>
}
 a52:	0001                	nop
 a54:	70e2                	ld	ra,56(sp)
 a56:	7442                	ld	s0,48(sp)
 a58:	6165                	addi	sp,sp,112
 a5a:	8082                	ret

0000000000000a5c <printf>:

void
printf(const char *fmt, ...)
{
 a5c:	7159                	addi	sp,sp,-112
 a5e:	f406                	sd	ra,40(sp)
 a60:	f022                	sd	s0,32(sp)
 a62:	1800                	addi	s0,sp,48
 a64:	fca43c23          	sd	a0,-40(s0)
 a68:	e40c                	sd	a1,8(s0)
 a6a:	e810                	sd	a2,16(s0)
 a6c:	ec14                	sd	a3,24(s0)
 a6e:	f018                	sd	a4,32(s0)
 a70:	f41c                	sd	a5,40(s0)
 a72:	03043823          	sd	a6,48(s0)
 a76:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a7a:	04040793          	addi	a5,s0,64
 a7e:	fcf43823          	sd	a5,-48(s0)
 a82:	fd043783          	ld	a5,-48(s0)
 a86:	fc878793          	addi	a5,a5,-56
 a8a:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 a8e:	fe843783          	ld	a5,-24(s0)
 a92:	863e                	mv	a2,a5
 a94:	fd843583          	ld	a1,-40(s0)
 a98:	4505                	li	a0,1
 a9a:	00000097          	auipc	ra,0x0
 a9e:	d04080e7          	jalr	-764(ra) # 79e <vprintf>
}
 aa2:	0001                	nop
 aa4:	70a2                	ld	ra,40(sp)
 aa6:	7402                	ld	s0,32(sp)
 aa8:	6165                	addi	sp,sp,112
 aaa:	8082                	ret

0000000000000aac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 aac:	7179                	addi	sp,sp,-48
 aae:	f422                	sd	s0,40(sp)
 ab0:	1800                	addi	s0,sp,48
 ab2:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ab6:	fd843783          	ld	a5,-40(s0)
 aba:	17c1                	addi	a5,a5,-16
 abc:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac0:	00000797          	auipc	a5,0x0
 ac4:	33078793          	addi	a5,a5,816 # df0 <freep>
 ac8:	639c                	ld	a5,0(a5)
 aca:	fef43423          	sd	a5,-24(s0)
 ace:	a815                	j	b02 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad0:	fe843783          	ld	a5,-24(s0)
 ad4:	639c                	ld	a5,0(a5)
 ad6:	fe843703          	ld	a4,-24(s0)
 ada:	00f76f63          	bltu	a4,a5,af8 <free+0x4c>
 ade:	fe043703          	ld	a4,-32(s0)
 ae2:	fe843783          	ld	a5,-24(s0)
 ae6:	02e7eb63          	bltu	a5,a4,b1c <free+0x70>
 aea:	fe843783          	ld	a5,-24(s0)
 aee:	639c                	ld	a5,0(a5)
 af0:	fe043703          	ld	a4,-32(s0)
 af4:	02f76463          	bltu	a4,a5,b1c <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af8:	fe843783          	ld	a5,-24(s0)
 afc:	639c                	ld	a5,0(a5)
 afe:	fef43423          	sd	a5,-24(s0)
 b02:	fe043703          	ld	a4,-32(s0)
 b06:	fe843783          	ld	a5,-24(s0)
 b0a:	fce7f3e3          	bgeu	a5,a4,ad0 <free+0x24>
 b0e:	fe843783          	ld	a5,-24(s0)
 b12:	639c                	ld	a5,0(a5)
 b14:	fe043703          	ld	a4,-32(s0)
 b18:	faf77ce3          	bgeu	a4,a5,ad0 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b1c:	fe043783          	ld	a5,-32(s0)
 b20:	479c                	lw	a5,8(a5)
 b22:	1782                	slli	a5,a5,0x20
 b24:	9381                	srli	a5,a5,0x20
 b26:	0792                	slli	a5,a5,0x4
 b28:	fe043703          	ld	a4,-32(s0)
 b2c:	973e                	add	a4,a4,a5
 b2e:	fe843783          	ld	a5,-24(s0)
 b32:	639c                	ld	a5,0(a5)
 b34:	02f71763          	bne	a4,a5,b62 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b38:	fe043783          	ld	a5,-32(s0)
 b3c:	4798                	lw	a4,8(a5)
 b3e:	fe843783          	ld	a5,-24(s0)
 b42:	639c                	ld	a5,0(a5)
 b44:	479c                	lw	a5,8(a5)
 b46:	9fb9                	addw	a5,a5,a4
 b48:	0007871b          	sext.w	a4,a5
 b4c:	fe043783          	ld	a5,-32(s0)
 b50:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b52:	fe843783          	ld	a5,-24(s0)
 b56:	639c                	ld	a5,0(a5)
 b58:	6398                	ld	a4,0(a5)
 b5a:	fe043783          	ld	a5,-32(s0)
 b5e:	e398                	sd	a4,0(a5)
 b60:	a039                	j	b6e <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b62:	fe843783          	ld	a5,-24(s0)
 b66:	6398                	ld	a4,0(a5)
 b68:	fe043783          	ld	a5,-32(s0)
 b6c:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b6e:	fe843783          	ld	a5,-24(s0)
 b72:	479c                	lw	a5,8(a5)
 b74:	1782                	slli	a5,a5,0x20
 b76:	9381                	srli	a5,a5,0x20
 b78:	0792                	slli	a5,a5,0x4
 b7a:	fe843703          	ld	a4,-24(s0)
 b7e:	97ba                	add	a5,a5,a4
 b80:	fe043703          	ld	a4,-32(s0)
 b84:	02f71563          	bne	a4,a5,bae <free+0x102>
    p->s.size += bp->s.size;
 b88:	fe843783          	ld	a5,-24(s0)
 b8c:	4798                	lw	a4,8(a5)
 b8e:	fe043783          	ld	a5,-32(s0)
 b92:	479c                	lw	a5,8(a5)
 b94:	9fb9                	addw	a5,a5,a4
 b96:	0007871b          	sext.w	a4,a5
 b9a:	fe843783          	ld	a5,-24(s0)
 b9e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 ba0:	fe043783          	ld	a5,-32(s0)
 ba4:	6398                	ld	a4,0(a5)
 ba6:	fe843783          	ld	a5,-24(s0)
 baa:	e398                	sd	a4,0(a5)
 bac:	a031                	j	bb8 <free+0x10c>
  } else
    p->s.ptr = bp;
 bae:	fe843783          	ld	a5,-24(s0)
 bb2:	fe043703          	ld	a4,-32(s0)
 bb6:	e398                	sd	a4,0(a5)
  freep = p;
 bb8:	00000797          	auipc	a5,0x0
 bbc:	23878793          	addi	a5,a5,568 # df0 <freep>
 bc0:	fe843703          	ld	a4,-24(s0)
 bc4:	e398                	sd	a4,0(a5)
}
 bc6:	0001                	nop
 bc8:	7422                	ld	s0,40(sp)
 bca:	6145                	addi	sp,sp,48
 bcc:	8082                	ret

0000000000000bce <morecore>:

static Header*
morecore(uint nu)
{
 bce:	7179                	addi	sp,sp,-48
 bd0:	f406                	sd	ra,40(sp)
 bd2:	f022                	sd	s0,32(sp)
 bd4:	1800                	addi	s0,sp,48
 bd6:	87aa                	mv	a5,a0
 bd8:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 bdc:	fdc42783          	lw	a5,-36(s0)
 be0:	0007871b          	sext.w	a4,a5
 be4:	6785                	lui	a5,0x1
 be6:	00f77563          	bgeu	a4,a5,bf0 <morecore+0x22>
    nu = 4096;
 bea:	6785                	lui	a5,0x1
 bec:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 bf0:	fdc42783          	lw	a5,-36(s0)
 bf4:	0047979b          	slliw	a5,a5,0x4
 bf8:	2781                	sext.w	a5,a5
 bfa:	2781                	sext.w	a5,a5
 bfc:	853e                	mv	a0,a5
 bfe:	00000097          	auipc	ra,0x0
 c02:	9a8080e7          	jalr	-1624(ra) # 5a6 <sbrk>
 c06:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c0a:	fe843703          	ld	a4,-24(s0)
 c0e:	57fd                	li	a5,-1
 c10:	00f71463          	bne	a4,a5,c18 <morecore+0x4a>
    return 0;
 c14:	4781                	li	a5,0
 c16:	a03d                	j	c44 <morecore+0x76>
  hp = (Header*)p;
 c18:	fe843783          	ld	a5,-24(s0)
 c1c:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c20:	fe043783          	ld	a5,-32(s0)
 c24:	fdc42703          	lw	a4,-36(s0)
 c28:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c2a:	fe043783          	ld	a5,-32(s0)
 c2e:	07c1                	addi	a5,a5,16
 c30:	853e                	mv	a0,a5
 c32:	00000097          	auipc	ra,0x0
 c36:	e7a080e7          	jalr	-390(ra) # aac <free>
  return freep;
 c3a:	00000797          	auipc	a5,0x0
 c3e:	1b678793          	addi	a5,a5,438 # df0 <freep>
 c42:	639c                	ld	a5,0(a5)
}
 c44:	853e                	mv	a0,a5
 c46:	70a2                	ld	ra,40(sp)
 c48:	7402                	ld	s0,32(sp)
 c4a:	6145                	addi	sp,sp,48
 c4c:	8082                	ret

0000000000000c4e <malloc>:

void*
malloc(uint nbytes)
{
 c4e:	7139                	addi	sp,sp,-64
 c50:	fc06                	sd	ra,56(sp)
 c52:	f822                	sd	s0,48(sp)
 c54:	0080                	addi	s0,sp,64
 c56:	87aa                	mv	a5,a0
 c58:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c5c:	fcc46783          	lwu	a5,-52(s0)
 c60:	07bd                	addi	a5,a5,15
 c62:	8391                	srli	a5,a5,0x4
 c64:	2781                	sext.w	a5,a5
 c66:	2785                	addiw	a5,a5,1
 c68:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c6c:	00000797          	auipc	a5,0x0
 c70:	18478793          	addi	a5,a5,388 # df0 <freep>
 c74:	639c                	ld	a5,0(a5)
 c76:	fef43023          	sd	a5,-32(s0)
 c7a:	fe043783          	ld	a5,-32(s0)
 c7e:	ef95                	bnez	a5,cba <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c80:	00000797          	auipc	a5,0x0
 c84:	16078793          	addi	a5,a5,352 # de0 <base>
 c88:	fef43023          	sd	a5,-32(s0)
 c8c:	00000797          	auipc	a5,0x0
 c90:	16478793          	addi	a5,a5,356 # df0 <freep>
 c94:	fe043703          	ld	a4,-32(s0)
 c98:	e398                	sd	a4,0(a5)
 c9a:	00000797          	auipc	a5,0x0
 c9e:	15678793          	addi	a5,a5,342 # df0 <freep>
 ca2:	6398                	ld	a4,0(a5)
 ca4:	00000797          	auipc	a5,0x0
 ca8:	13c78793          	addi	a5,a5,316 # de0 <base>
 cac:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 cae:	00000797          	auipc	a5,0x0
 cb2:	13278793          	addi	a5,a5,306 # de0 <base>
 cb6:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cba:	fe043783          	ld	a5,-32(s0)
 cbe:	639c                	ld	a5,0(a5)
 cc0:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 cc4:	fe843783          	ld	a5,-24(s0)
 cc8:	4798                	lw	a4,8(a5)
 cca:	fdc42783          	lw	a5,-36(s0)
 cce:	2781                	sext.w	a5,a5
 cd0:	06f76863          	bltu	a4,a5,d40 <malloc+0xf2>
      if(p->s.size == nunits)
 cd4:	fe843783          	ld	a5,-24(s0)
 cd8:	4798                	lw	a4,8(a5)
 cda:	fdc42783          	lw	a5,-36(s0)
 cde:	2781                	sext.w	a5,a5
 ce0:	00e79963          	bne	a5,a4,cf2 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 ce4:	fe843783          	ld	a5,-24(s0)
 ce8:	6398                	ld	a4,0(a5)
 cea:	fe043783          	ld	a5,-32(s0)
 cee:	e398                	sd	a4,0(a5)
 cf0:	a82d                	j	d2a <malloc+0xdc>
      else {
        p->s.size -= nunits;
 cf2:	fe843783          	ld	a5,-24(s0)
 cf6:	4798                	lw	a4,8(a5)
 cf8:	fdc42783          	lw	a5,-36(s0)
 cfc:	40f707bb          	subw	a5,a4,a5
 d00:	0007871b          	sext.w	a4,a5
 d04:	fe843783          	ld	a5,-24(s0)
 d08:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d0a:	fe843783          	ld	a5,-24(s0)
 d0e:	479c                	lw	a5,8(a5)
 d10:	1782                	slli	a5,a5,0x20
 d12:	9381                	srli	a5,a5,0x20
 d14:	0792                	slli	a5,a5,0x4
 d16:	fe843703          	ld	a4,-24(s0)
 d1a:	97ba                	add	a5,a5,a4
 d1c:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d20:	fe843783          	ld	a5,-24(s0)
 d24:	fdc42703          	lw	a4,-36(s0)
 d28:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d2a:	00000797          	auipc	a5,0x0
 d2e:	0c678793          	addi	a5,a5,198 # df0 <freep>
 d32:	fe043703          	ld	a4,-32(s0)
 d36:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d38:	fe843783          	ld	a5,-24(s0)
 d3c:	07c1                	addi	a5,a5,16
 d3e:	a091                	j	d82 <malloc+0x134>
    }
    if(p == freep)
 d40:	00000797          	auipc	a5,0x0
 d44:	0b078793          	addi	a5,a5,176 # df0 <freep>
 d48:	639c                	ld	a5,0(a5)
 d4a:	fe843703          	ld	a4,-24(s0)
 d4e:	02f71063          	bne	a4,a5,d6e <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 d52:	fdc42783          	lw	a5,-36(s0)
 d56:	853e                	mv	a0,a5
 d58:	00000097          	auipc	ra,0x0
 d5c:	e76080e7          	jalr	-394(ra) # bce <morecore>
 d60:	fea43423          	sd	a0,-24(s0)
 d64:	fe843783          	ld	a5,-24(s0)
 d68:	e399                	bnez	a5,d6e <malloc+0x120>
        return 0;
 d6a:	4781                	li	a5,0
 d6c:	a819                	j	d82 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d6e:	fe843783          	ld	a5,-24(s0)
 d72:	fef43023          	sd	a5,-32(s0)
 d76:	fe843783          	ld	a5,-24(s0)
 d7a:	639c                	ld	a5,0(a5)
 d7c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d80:	b791                	j	cc4 <malloc+0x76>
  }
}
 d82:	853e                	mv	a0,a5
 d84:	70e2                	ld	ra,56(sp)
 d86:	7442                	ld	s0,48(sp)
 d88:	6121                	addi	sp,sp,64
 d8a:	8082                	ret
