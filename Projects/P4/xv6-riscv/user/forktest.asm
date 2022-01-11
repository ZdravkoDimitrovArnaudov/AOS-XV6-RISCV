
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
   8:	fea43423          	sd	a0,-24(s0)
  write(1, s, strlen(s));
   c:	fe843503          	ld	a0,-24(s0)
  10:	00000097          	auipc	ra,0x0
  14:	208080e7          	jalr	520(ra) # 218 <strlen>
  18:	87aa                	mv	a5,a0
  1a:	2781                	sext.w	a5,a5
  1c:	2781                	sext.w	a5,a5
  1e:	863e                	mv	a2,a5
  20:	fe843583          	ld	a1,-24(s0)
  24:	4505                	li	a0,1
  26:	00000097          	auipc	ra,0x0
  2a:	5f4080e7          	jalr	1524(ra) # 61a <write>
}
  2e:	0001                	nop
  30:	60e2                	ld	ra,24(sp)
  32:	6442                	ld	s0,16(sp)
  34:	6105                	addi	sp,sp,32
  36:	8082                	ret

0000000000000038 <forktest>:

void
forktest(void)
{
  38:	1101                	addi	sp,sp,-32
  3a:	ec06                	sd	ra,24(sp)
  3c:	e822                	sd	s0,16(sp)
  3e:	1000                	addi	s0,sp,32
  int n, pid;

  print("fork test\n");
  40:	00000517          	auipc	a0,0x0
  44:	67050513          	addi	a0,a0,1648 # 6b0 <join+0xe>
  48:	00000097          	auipc	ra,0x0
  4c:	fb8080e7          	jalr	-72(ra) # 0 <print>

  for(n=0; n<N; n++){
  50:	fe042623          	sw	zero,-20(s0)
  54:	a81d                	j	8a <forktest+0x52>
    pid = fork();
  56:	00000097          	auipc	ra,0x0
  5a:	59c080e7          	jalr	1436(ra) # 5f2 <fork>
  5e:	87aa                	mv	a5,a0
  60:	fef42423          	sw	a5,-24(s0)
    if(pid < 0)
  64:	fe842783          	lw	a5,-24(s0)
  68:	2781                	sext.w	a5,a5
  6a:	0207c963          	bltz	a5,9c <forktest+0x64>
      break;
    if(pid == 0)
  6e:	fe842783          	lw	a5,-24(s0)
  72:	2781                	sext.w	a5,a5
  74:	e791                	bnez	a5,80 <forktest+0x48>
      exit(0);
  76:	4501                	li	a0,0
  78:	00000097          	auipc	ra,0x0
  7c:	582080e7          	jalr	1410(ra) # 5fa <exit>
  for(n=0; n<N; n++){
  80:	fec42783          	lw	a5,-20(s0)
  84:	2785                	addiw	a5,a5,1
  86:	fef42623          	sw	a5,-20(s0)
  8a:	fec42783          	lw	a5,-20(s0)
  8e:	0007871b          	sext.w	a4,a5
  92:	3e700793          	li	a5,999
  96:	fce7d0e3          	bge	a5,a4,56 <forktest+0x1e>
  9a:	a011                	j	9e <forktest+0x66>
      break;
  9c:	0001                	nop
  }

  if(n == N){
  9e:	fec42783          	lw	a5,-20(s0)
  a2:	0007871b          	sext.w	a4,a5
  a6:	3e800793          	li	a5,1000
  aa:	04f71963          	bne	a4,a5,fc <forktest+0xc4>
    print("fork claimed to work N times!\n");
  ae:	00000517          	auipc	a0,0x0
  b2:	61250513          	addi	a0,a0,1554 # 6c0 <join+0x1e>
  b6:	00000097          	auipc	ra,0x0
  ba:	f4a080e7          	jalr	-182(ra) # 0 <print>
    exit(1);
  be:	4505                	li	a0,1
  c0:	00000097          	auipc	ra,0x0
  c4:	53a080e7          	jalr	1338(ra) # 5fa <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
  c8:	4501                	li	a0,0
  ca:	00000097          	auipc	ra,0x0
  ce:	538080e7          	jalr	1336(ra) # 602 <wait>
  d2:	87aa                	mv	a5,a0
  d4:	0007df63          	bgez	a5,f2 <forktest+0xba>
      print("wait stopped early\n");
  d8:	00000517          	auipc	a0,0x0
  dc:	60850513          	addi	a0,a0,1544 # 6e0 <join+0x3e>
  e0:	00000097          	auipc	ra,0x0
  e4:	f20080e7          	jalr	-224(ra) # 0 <print>
      exit(1);
  e8:	4505                	li	a0,1
  ea:	00000097          	auipc	ra,0x0
  ee:	510080e7          	jalr	1296(ra) # 5fa <exit>
  for(; n > 0; n--){
  f2:	fec42783          	lw	a5,-20(s0)
  f6:	37fd                	addiw	a5,a5,-1
  f8:	fef42623          	sw	a5,-20(s0)
  fc:	fec42783          	lw	a5,-20(s0)
 100:	2781                	sext.w	a5,a5
 102:	fcf043e3          	bgtz	a5,c8 <forktest+0x90>
    }
  }

  if(wait(0) != -1){
 106:	4501                	li	a0,0
 108:	00000097          	auipc	ra,0x0
 10c:	4fa080e7          	jalr	1274(ra) # 602 <wait>
 110:	87aa                	mv	a5,a0
 112:	873e                	mv	a4,a5
 114:	57fd                	li	a5,-1
 116:	00f70f63          	beq	a4,a5,134 <forktest+0xfc>
    print("wait got too many\n");
 11a:	00000517          	auipc	a0,0x0
 11e:	5de50513          	addi	a0,a0,1502 # 6f8 <join+0x56>
 122:	00000097          	auipc	ra,0x0
 126:	ede080e7          	jalr	-290(ra) # 0 <print>
    exit(1);
 12a:	4505                	li	a0,1
 12c:	00000097          	auipc	ra,0x0
 130:	4ce080e7          	jalr	1230(ra) # 5fa <exit>
  }

  print("fork test OK\n");
 134:	00000517          	auipc	a0,0x0
 138:	5dc50513          	addi	a0,a0,1500 # 710 <join+0x6e>
 13c:	00000097          	auipc	ra,0x0
 140:	ec4080e7          	jalr	-316(ra) # 0 <print>
}
 144:	0001                	nop
 146:	60e2                	ld	ra,24(sp)
 148:	6442                	ld	s0,16(sp)
 14a:	6105                	addi	sp,sp,32
 14c:	8082                	ret

000000000000014e <main>:

int
main(void)
{
 14e:	1141                	addi	sp,sp,-16
 150:	e406                	sd	ra,8(sp)
 152:	e022                	sd	s0,0(sp)
 154:	0800                	addi	s0,sp,16
  forktest();
 156:	00000097          	auipc	ra,0x0
 15a:	ee2080e7          	jalr	-286(ra) # 38 <forktest>
  exit(0);
 15e:	4501                	li	a0,0
 160:	00000097          	auipc	ra,0x0
 164:	49a080e7          	jalr	1178(ra) # 5fa <exit>

0000000000000168 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 168:	7179                	addi	sp,sp,-48
 16a:	f422                	sd	s0,40(sp)
 16c:	1800                	addi	s0,sp,48
 16e:	fca43c23          	sd	a0,-40(s0)
 172:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 176:	fd843783          	ld	a5,-40(s0)
 17a:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 17e:	0001                	nop
 180:	fd043703          	ld	a4,-48(s0)
 184:	00170793          	addi	a5,a4,1
 188:	fcf43823          	sd	a5,-48(s0)
 18c:	fd843783          	ld	a5,-40(s0)
 190:	00178693          	addi	a3,a5,1
 194:	fcd43c23          	sd	a3,-40(s0)
 198:	00074703          	lbu	a4,0(a4)
 19c:	00e78023          	sb	a4,0(a5)
 1a0:	0007c783          	lbu	a5,0(a5)
 1a4:	fff1                	bnez	a5,180 <strcpy+0x18>
    ;
  return os;
 1a6:	fe843783          	ld	a5,-24(s0)
}
 1aa:	853e                	mv	a0,a5
 1ac:	7422                	ld	s0,40(sp)
 1ae:	6145                	addi	sp,sp,48
 1b0:	8082                	ret

00000000000001b2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b2:	1101                	addi	sp,sp,-32
 1b4:	ec22                	sd	s0,24(sp)
 1b6:	1000                	addi	s0,sp,32
 1b8:	fea43423          	sd	a0,-24(s0)
 1bc:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 1c0:	a819                	j	1d6 <strcmp+0x24>
    p++, q++;
 1c2:	fe843783          	ld	a5,-24(s0)
 1c6:	0785                	addi	a5,a5,1
 1c8:	fef43423          	sd	a5,-24(s0)
 1cc:	fe043783          	ld	a5,-32(s0)
 1d0:	0785                	addi	a5,a5,1
 1d2:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 1d6:	fe843783          	ld	a5,-24(s0)
 1da:	0007c783          	lbu	a5,0(a5)
 1de:	cb99                	beqz	a5,1f4 <strcmp+0x42>
 1e0:	fe843783          	ld	a5,-24(s0)
 1e4:	0007c703          	lbu	a4,0(a5)
 1e8:	fe043783          	ld	a5,-32(s0)
 1ec:	0007c783          	lbu	a5,0(a5)
 1f0:	fcf709e3          	beq	a4,a5,1c2 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 1f4:	fe843783          	ld	a5,-24(s0)
 1f8:	0007c783          	lbu	a5,0(a5)
 1fc:	0007871b          	sext.w	a4,a5
 200:	fe043783          	ld	a5,-32(s0)
 204:	0007c783          	lbu	a5,0(a5)
 208:	2781                	sext.w	a5,a5
 20a:	40f707bb          	subw	a5,a4,a5
 20e:	2781                	sext.w	a5,a5
}
 210:	853e                	mv	a0,a5
 212:	6462                	ld	s0,24(sp)
 214:	6105                	addi	sp,sp,32
 216:	8082                	ret

0000000000000218 <strlen>:

uint
strlen(const char *s)
{
 218:	7179                	addi	sp,sp,-48
 21a:	f422                	sd	s0,40(sp)
 21c:	1800                	addi	s0,sp,48
 21e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 222:	fe042623          	sw	zero,-20(s0)
 226:	a031                	j	232 <strlen+0x1a>
 228:	fec42783          	lw	a5,-20(s0)
 22c:	2785                	addiw	a5,a5,1
 22e:	fef42623          	sw	a5,-20(s0)
 232:	fec42783          	lw	a5,-20(s0)
 236:	fd843703          	ld	a4,-40(s0)
 23a:	97ba                	add	a5,a5,a4
 23c:	0007c783          	lbu	a5,0(a5)
 240:	f7e5                	bnez	a5,228 <strlen+0x10>
    ;
  return n;
 242:	fec42783          	lw	a5,-20(s0)
}
 246:	853e                	mv	a0,a5
 248:	7422                	ld	s0,40(sp)
 24a:	6145                	addi	sp,sp,48
 24c:	8082                	ret

000000000000024e <memset>:

void*
memset(void *dst, int c, uint n)
{
 24e:	7179                	addi	sp,sp,-48
 250:	f422                	sd	s0,40(sp)
 252:	1800                	addi	s0,sp,48
 254:	fca43c23          	sd	a0,-40(s0)
 258:	87ae                	mv	a5,a1
 25a:	8732                	mv	a4,a2
 25c:	fcf42a23          	sw	a5,-44(s0)
 260:	87ba                	mv	a5,a4
 262:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 266:	fd843783          	ld	a5,-40(s0)
 26a:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 26e:	fe042623          	sw	zero,-20(s0)
 272:	a00d                	j	294 <memset+0x46>
    cdst[i] = c;
 274:	fec42783          	lw	a5,-20(s0)
 278:	fe043703          	ld	a4,-32(s0)
 27c:	97ba                	add	a5,a5,a4
 27e:	fd442703          	lw	a4,-44(s0)
 282:	0ff77713          	zext.b	a4,a4
 286:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 28a:	fec42783          	lw	a5,-20(s0)
 28e:	2785                	addiw	a5,a5,1
 290:	fef42623          	sw	a5,-20(s0)
 294:	fec42703          	lw	a4,-20(s0)
 298:	fd042783          	lw	a5,-48(s0)
 29c:	2781                	sext.w	a5,a5
 29e:	fcf76be3          	bltu	a4,a5,274 <memset+0x26>
  }
  return dst;
 2a2:	fd843783          	ld	a5,-40(s0)
}
 2a6:	853e                	mv	a0,a5
 2a8:	7422                	ld	s0,40(sp)
 2aa:	6145                	addi	sp,sp,48
 2ac:	8082                	ret

00000000000002ae <strchr>:

char*
strchr(const char *s, char c)
{
 2ae:	1101                	addi	sp,sp,-32
 2b0:	ec22                	sd	s0,24(sp)
 2b2:	1000                	addi	s0,sp,32
 2b4:	fea43423          	sd	a0,-24(s0)
 2b8:	87ae                	mv	a5,a1
 2ba:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 2be:	a01d                	j	2e4 <strchr+0x36>
    if(*s == c)
 2c0:	fe843783          	ld	a5,-24(s0)
 2c4:	0007c703          	lbu	a4,0(a5)
 2c8:	fe744783          	lbu	a5,-25(s0)
 2cc:	0ff7f793          	zext.b	a5,a5
 2d0:	00e79563          	bne	a5,a4,2da <strchr+0x2c>
      return (char*)s;
 2d4:	fe843783          	ld	a5,-24(s0)
 2d8:	a821                	j	2f0 <strchr+0x42>
  for(; *s; s++)
 2da:	fe843783          	ld	a5,-24(s0)
 2de:	0785                	addi	a5,a5,1
 2e0:	fef43423          	sd	a5,-24(s0)
 2e4:	fe843783          	ld	a5,-24(s0)
 2e8:	0007c783          	lbu	a5,0(a5)
 2ec:	fbf1                	bnez	a5,2c0 <strchr+0x12>
  return 0;
 2ee:	4781                	li	a5,0
}
 2f0:	853e                	mv	a0,a5
 2f2:	6462                	ld	s0,24(sp)
 2f4:	6105                	addi	sp,sp,32
 2f6:	8082                	ret

00000000000002f8 <gets>:

char*
gets(char *buf, int max)
{
 2f8:	7179                	addi	sp,sp,-48
 2fa:	f406                	sd	ra,40(sp)
 2fc:	f022                	sd	s0,32(sp)
 2fe:	1800                	addi	s0,sp,48
 300:	fca43c23          	sd	a0,-40(s0)
 304:	87ae                	mv	a5,a1
 306:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 30a:	fe042623          	sw	zero,-20(s0)
 30e:	a8a1                	j	366 <gets+0x6e>
    cc = read(0, &c, 1);
 310:	fe740793          	addi	a5,s0,-25
 314:	4605                	li	a2,1
 316:	85be                	mv	a1,a5
 318:	4501                	li	a0,0
 31a:	00000097          	auipc	ra,0x0
 31e:	2f8080e7          	jalr	760(ra) # 612 <read>
 322:	87aa                	mv	a5,a0
 324:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 328:	fe842783          	lw	a5,-24(s0)
 32c:	2781                	sext.w	a5,a5
 32e:	04f05763          	blez	a5,37c <gets+0x84>
      break;
    buf[i++] = c;
 332:	fec42783          	lw	a5,-20(s0)
 336:	0017871b          	addiw	a4,a5,1
 33a:	fee42623          	sw	a4,-20(s0)
 33e:	873e                	mv	a4,a5
 340:	fd843783          	ld	a5,-40(s0)
 344:	97ba                	add	a5,a5,a4
 346:	fe744703          	lbu	a4,-25(s0)
 34a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 34e:	fe744783          	lbu	a5,-25(s0)
 352:	873e                	mv	a4,a5
 354:	47a9                	li	a5,10
 356:	02f70463          	beq	a4,a5,37e <gets+0x86>
 35a:	fe744783          	lbu	a5,-25(s0)
 35e:	873e                	mv	a4,a5
 360:	47b5                	li	a5,13
 362:	00f70e63          	beq	a4,a5,37e <gets+0x86>
  for(i=0; i+1 < max; ){
 366:	fec42783          	lw	a5,-20(s0)
 36a:	2785                	addiw	a5,a5,1
 36c:	0007871b          	sext.w	a4,a5
 370:	fd442783          	lw	a5,-44(s0)
 374:	2781                	sext.w	a5,a5
 376:	f8f74de3          	blt	a4,a5,310 <gets+0x18>
 37a:	a011                	j	37e <gets+0x86>
      break;
 37c:	0001                	nop
      break;
  }
  buf[i] = '\0';
 37e:	fec42783          	lw	a5,-20(s0)
 382:	fd843703          	ld	a4,-40(s0)
 386:	97ba                	add	a5,a5,a4
 388:	00078023          	sb	zero,0(a5)
  return buf;
 38c:	fd843783          	ld	a5,-40(s0)
}
 390:	853e                	mv	a0,a5
 392:	70a2                	ld	ra,40(sp)
 394:	7402                	ld	s0,32(sp)
 396:	6145                	addi	sp,sp,48
 398:	8082                	ret

000000000000039a <stat>:

int
stat(const char *n, struct stat *st)
{
 39a:	7179                	addi	sp,sp,-48
 39c:	f406                	sd	ra,40(sp)
 39e:	f022                	sd	s0,32(sp)
 3a0:	1800                	addi	s0,sp,48
 3a2:	fca43c23          	sd	a0,-40(s0)
 3a6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3aa:	4581                	li	a1,0
 3ac:	fd843503          	ld	a0,-40(s0)
 3b0:	00000097          	auipc	ra,0x0
 3b4:	28a080e7          	jalr	650(ra) # 63a <open>
 3b8:	87aa                	mv	a5,a0
 3ba:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 3be:	fec42783          	lw	a5,-20(s0)
 3c2:	2781                	sext.w	a5,a5
 3c4:	0007d463          	bgez	a5,3cc <stat+0x32>
    return -1;
 3c8:	57fd                	li	a5,-1
 3ca:	a035                	j	3f6 <stat+0x5c>
  r = fstat(fd, st);
 3cc:	fec42783          	lw	a5,-20(s0)
 3d0:	fd043583          	ld	a1,-48(s0)
 3d4:	853e                	mv	a0,a5
 3d6:	00000097          	auipc	ra,0x0
 3da:	27c080e7          	jalr	636(ra) # 652 <fstat>
 3de:	87aa                	mv	a5,a0
 3e0:	fef42423          	sw	a5,-24(s0)
  close(fd);
 3e4:	fec42783          	lw	a5,-20(s0)
 3e8:	853e                	mv	a0,a5
 3ea:	00000097          	auipc	ra,0x0
 3ee:	238080e7          	jalr	568(ra) # 622 <close>
  return r;
 3f2:	fe842783          	lw	a5,-24(s0)
}
 3f6:	853e                	mv	a0,a5
 3f8:	70a2                	ld	ra,40(sp)
 3fa:	7402                	ld	s0,32(sp)
 3fc:	6145                	addi	sp,sp,48
 3fe:	8082                	ret

0000000000000400 <atoi>:

int
atoi(const char *s)
{
 400:	7179                	addi	sp,sp,-48
 402:	f422                	sd	s0,40(sp)
 404:	1800                	addi	s0,sp,48
 406:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 40a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 40e:	a81d                	j	444 <atoi+0x44>
    n = n*10 + *s++ - '0';
 410:	fec42783          	lw	a5,-20(s0)
 414:	873e                	mv	a4,a5
 416:	87ba                	mv	a5,a4
 418:	0027979b          	slliw	a5,a5,0x2
 41c:	9fb9                	addw	a5,a5,a4
 41e:	0017979b          	slliw	a5,a5,0x1
 422:	0007871b          	sext.w	a4,a5
 426:	fd843783          	ld	a5,-40(s0)
 42a:	00178693          	addi	a3,a5,1
 42e:	fcd43c23          	sd	a3,-40(s0)
 432:	0007c783          	lbu	a5,0(a5)
 436:	2781                	sext.w	a5,a5
 438:	9fb9                	addw	a5,a5,a4
 43a:	2781                	sext.w	a5,a5
 43c:	fd07879b          	addiw	a5,a5,-48
 440:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 444:	fd843783          	ld	a5,-40(s0)
 448:	0007c783          	lbu	a5,0(a5)
 44c:	873e                	mv	a4,a5
 44e:	02f00793          	li	a5,47
 452:	00e7fb63          	bgeu	a5,a4,468 <atoi+0x68>
 456:	fd843783          	ld	a5,-40(s0)
 45a:	0007c783          	lbu	a5,0(a5)
 45e:	873e                	mv	a4,a5
 460:	03900793          	li	a5,57
 464:	fae7f6e3          	bgeu	a5,a4,410 <atoi+0x10>
  return n;
 468:	fec42783          	lw	a5,-20(s0)
}
 46c:	853e                	mv	a0,a5
 46e:	7422                	ld	s0,40(sp)
 470:	6145                	addi	sp,sp,48
 472:	8082                	ret

0000000000000474 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 474:	7139                	addi	sp,sp,-64
 476:	fc22                	sd	s0,56(sp)
 478:	0080                	addi	s0,sp,64
 47a:	fca43c23          	sd	a0,-40(s0)
 47e:	fcb43823          	sd	a1,-48(s0)
 482:	87b2                	mv	a5,a2
 484:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 488:	fd843783          	ld	a5,-40(s0)
 48c:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 490:	fd043783          	ld	a5,-48(s0)
 494:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 498:	fe043703          	ld	a4,-32(s0)
 49c:	fe843783          	ld	a5,-24(s0)
 4a0:	02e7fc63          	bgeu	a5,a4,4d8 <memmove+0x64>
    while(n-- > 0)
 4a4:	a00d                	j	4c6 <memmove+0x52>
      *dst++ = *src++;
 4a6:	fe043703          	ld	a4,-32(s0)
 4aa:	00170793          	addi	a5,a4,1
 4ae:	fef43023          	sd	a5,-32(s0)
 4b2:	fe843783          	ld	a5,-24(s0)
 4b6:	00178693          	addi	a3,a5,1
 4ba:	fed43423          	sd	a3,-24(s0)
 4be:	00074703          	lbu	a4,0(a4)
 4c2:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4c6:	fcc42783          	lw	a5,-52(s0)
 4ca:	fff7871b          	addiw	a4,a5,-1
 4ce:	fce42623          	sw	a4,-52(s0)
 4d2:	fcf04ae3          	bgtz	a5,4a6 <memmove+0x32>
 4d6:	a891                	j	52a <memmove+0xb6>
  } else {
    dst += n;
 4d8:	fcc42783          	lw	a5,-52(s0)
 4dc:	fe843703          	ld	a4,-24(s0)
 4e0:	97ba                	add	a5,a5,a4
 4e2:	fef43423          	sd	a5,-24(s0)
    src += n;
 4e6:	fcc42783          	lw	a5,-52(s0)
 4ea:	fe043703          	ld	a4,-32(s0)
 4ee:	97ba                	add	a5,a5,a4
 4f0:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 4f4:	a01d                	j	51a <memmove+0xa6>
      *--dst = *--src;
 4f6:	fe043783          	ld	a5,-32(s0)
 4fa:	17fd                	addi	a5,a5,-1
 4fc:	fef43023          	sd	a5,-32(s0)
 500:	fe843783          	ld	a5,-24(s0)
 504:	17fd                	addi	a5,a5,-1
 506:	fef43423          	sd	a5,-24(s0)
 50a:	fe043783          	ld	a5,-32(s0)
 50e:	0007c703          	lbu	a4,0(a5)
 512:	fe843783          	ld	a5,-24(s0)
 516:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 51a:	fcc42783          	lw	a5,-52(s0)
 51e:	fff7871b          	addiw	a4,a5,-1
 522:	fce42623          	sw	a4,-52(s0)
 526:	fcf048e3          	bgtz	a5,4f6 <memmove+0x82>
  }
  return vdst;
 52a:	fd843783          	ld	a5,-40(s0)
}
 52e:	853e                	mv	a0,a5
 530:	7462                	ld	s0,56(sp)
 532:	6121                	addi	sp,sp,64
 534:	8082                	ret

0000000000000536 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 536:	7139                	addi	sp,sp,-64
 538:	fc22                	sd	s0,56(sp)
 53a:	0080                	addi	s0,sp,64
 53c:	fca43c23          	sd	a0,-40(s0)
 540:	fcb43823          	sd	a1,-48(s0)
 544:	87b2                	mv	a5,a2
 546:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 54a:	fd843783          	ld	a5,-40(s0)
 54e:	fef43423          	sd	a5,-24(s0)
 552:	fd043783          	ld	a5,-48(s0)
 556:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 55a:	a0a1                	j	5a2 <memcmp+0x6c>
    if (*p1 != *p2) {
 55c:	fe843783          	ld	a5,-24(s0)
 560:	0007c703          	lbu	a4,0(a5)
 564:	fe043783          	ld	a5,-32(s0)
 568:	0007c783          	lbu	a5,0(a5)
 56c:	02f70163          	beq	a4,a5,58e <memcmp+0x58>
      return *p1 - *p2;
 570:	fe843783          	ld	a5,-24(s0)
 574:	0007c783          	lbu	a5,0(a5)
 578:	0007871b          	sext.w	a4,a5
 57c:	fe043783          	ld	a5,-32(s0)
 580:	0007c783          	lbu	a5,0(a5)
 584:	2781                	sext.w	a5,a5
 586:	40f707bb          	subw	a5,a4,a5
 58a:	2781                	sext.w	a5,a5
 58c:	a01d                	j	5b2 <memcmp+0x7c>
    }
    p1++;
 58e:	fe843783          	ld	a5,-24(s0)
 592:	0785                	addi	a5,a5,1
 594:	fef43423          	sd	a5,-24(s0)
    p2++;
 598:	fe043783          	ld	a5,-32(s0)
 59c:	0785                	addi	a5,a5,1
 59e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 5a2:	fcc42783          	lw	a5,-52(s0)
 5a6:	fff7871b          	addiw	a4,a5,-1
 5aa:	fce42623          	sw	a4,-52(s0)
 5ae:	f7dd                	bnez	a5,55c <memcmp+0x26>
  }
  return 0;
 5b0:	4781                	li	a5,0
}
 5b2:	853e                	mv	a0,a5
 5b4:	7462                	ld	s0,56(sp)
 5b6:	6121                	addi	sp,sp,64
 5b8:	8082                	ret

00000000000005ba <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5ba:	7179                	addi	sp,sp,-48
 5bc:	f406                	sd	ra,40(sp)
 5be:	f022                	sd	s0,32(sp)
 5c0:	1800                	addi	s0,sp,48
 5c2:	fea43423          	sd	a0,-24(s0)
 5c6:	feb43023          	sd	a1,-32(s0)
 5ca:	87b2                	mv	a5,a2
 5cc:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 5d0:	fdc42783          	lw	a5,-36(s0)
 5d4:	863e                	mv	a2,a5
 5d6:	fe043583          	ld	a1,-32(s0)
 5da:	fe843503          	ld	a0,-24(s0)
 5de:	00000097          	auipc	ra,0x0
 5e2:	e96080e7          	jalr	-362(ra) # 474 <memmove>
 5e6:	87aa                	mv	a5,a0
}
 5e8:	853e                	mv	a0,a5
 5ea:	70a2                	ld	ra,40(sp)
 5ec:	7402                	ld	s0,32(sp)
 5ee:	6145                	addi	sp,sp,48
 5f0:	8082                	ret

00000000000005f2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5f2:	4885                	li	a7,1
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <exit>:
.global exit
exit:
 li a7, SYS_exit
 5fa:	4889                	li	a7,2
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <wait>:
.global wait
wait:
 li a7, SYS_wait
 602:	488d                	li	a7,3
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 60a:	4891                	li	a7,4
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <read>:
.global read
read:
 li a7, SYS_read
 612:	4895                	li	a7,5
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <write>:
.global write
write:
 li a7, SYS_write
 61a:	48c1                	li	a7,16
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <close>:
.global close
close:
 li a7, SYS_close
 622:	48d5                	li	a7,21
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <kill>:
.global kill
kill:
 li a7, SYS_kill
 62a:	4899                	li	a7,6
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <exec>:
.global exec
exec:
 li a7, SYS_exec
 632:	489d                	li	a7,7
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <open>:
.global open
open:
 li a7, SYS_open
 63a:	48bd                	li	a7,15
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 642:	48c5                	li	a7,17
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 64a:	48c9                	li	a7,18
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 652:	48a1                	li	a7,8
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <link>:
.global link
link:
 li a7, SYS_link
 65a:	48cd                	li	a7,19
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 662:	48d1                	li	a7,20
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 66a:	48a5                	li	a7,9
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <dup>:
.global dup
dup:
 li a7, SYS_dup
 672:	48a9                	li	a7,10
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 67a:	48ad                	li	a7,11
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 682:	48b1                	li	a7,12
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 68a:	48b5                	li	a7,13
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 692:	48b9                	li	a7,14
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <clone>:
.global clone
clone:
 li a7, SYS_clone
 69a:	48d9                	li	a7,22
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <join>:
.global join
join:
 li a7, SYS_join
 6a2:	48dd                	li	a7,23
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret
