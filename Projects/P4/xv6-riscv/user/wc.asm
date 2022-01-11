
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	0080                	addi	s0,sp,64
       8:	87aa                	mv	a5,a0
       a:	fcb43023          	sd	a1,-64(s0)
       e:	fcf42623          	sw	a5,-52(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
      12:	fe042023          	sw	zero,-32(s0)
      16:	fe042783          	lw	a5,-32(s0)
      1a:	fef42223          	sw	a5,-28(s0)
      1e:	fe442783          	lw	a5,-28(s0)
      22:	fef42423          	sw	a5,-24(s0)
  inword = 0;
      26:	fc042e23          	sw	zero,-36(s0)
  while((n = read(fd, buf, sizeof(buf))) > 0){
      2a:	a861                	j	c2 <wc+0xc2>
    for(i=0; i<n; i++){
      2c:	fe042623          	sw	zero,-20(s0)
      30:	a041                	j	b0 <wc+0xb0>
      c++;
      32:	fe042783          	lw	a5,-32(s0)
      36:	2785                	addiw	a5,a5,1
      38:	fef42023          	sw	a5,-32(s0)
      if(buf[i] == '\n')
      3c:	00001717          	auipc	a4,0x1
      40:	0ac70713          	addi	a4,a4,172 # 10e8 <buf>
      44:	fec42783          	lw	a5,-20(s0)
      48:	97ba                	add	a5,a5,a4
      4a:	0007c783          	lbu	a5,0(a5)
      4e:	873e                	mv	a4,a5
      50:	47a9                	li	a5,10
      52:	00f71763          	bne	a4,a5,60 <wc+0x60>
        l++;
      56:	fe842783          	lw	a5,-24(s0)
      5a:	2785                	addiw	a5,a5,1
      5c:	fef42423          	sw	a5,-24(s0)
      if(strchr(" \r\t\n\v", buf[i]))
      60:	00001717          	auipc	a4,0x1
      64:	08870713          	addi	a4,a4,136 # 10e8 <buf>
      68:	fec42783          	lw	a5,-20(s0)
      6c:	97ba                	add	a5,a5,a4
      6e:	0007c783          	lbu	a5,0(a5)
      72:	85be                	mv	a1,a5
      74:	00001517          	auipc	a0,0x1
      78:	fbc50513          	addi	a0,a0,-68 # 1030 <lock_init+0x16>
      7c:	00000097          	auipc	ra,0x0
      80:	2f0080e7          	jalr	752(ra) # 36c <strchr>
      84:	87aa                	mv	a5,a0
      86:	c781                	beqz	a5,8e <wc+0x8e>
        inword = 0;
      88:	fc042e23          	sw	zero,-36(s0)
      8c:	a829                	j	a6 <wc+0xa6>
      else if(!inword){
      8e:	fdc42783          	lw	a5,-36(s0)
      92:	2781                	sext.w	a5,a5
      94:	eb89                	bnez	a5,a6 <wc+0xa6>
        w++;
      96:	fe442783          	lw	a5,-28(s0)
      9a:	2785                	addiw	a5,a5,1
      9c:	fef42223          	sw	a5,-28(s0)
        inword = 1;
      a0:	4785                	li	a5,1
      a2:	fcf42e23          	sw	a5,-36(s0)
    for(i=0; i<n; i++){
      a6:	fec42783          	lw	a5,-20(s0)
      aa:	2785                	addiw	a5,a5,1
      ac:	fef42623          	sw	a5,-20(s0)
      b0:	fec42783          	lw	a5,-20(s0)
      b4:	873e                	mv	a4,a5
      b6:	fd842783          	lw	a5,-40(s0)
      ba:	2701                	sext.w	a4,a4
      bc:	2781                	sext.w	a5,a5
      be:	f6f74ae3          	blt	a4,a5,32 <wc+0x32>
  while((n = read(fd, buf, sizeof(buf))) > 0){
      c2:	fcc42783          	lw	a5,-52(s0)
      c6:	20000613          	li	a2,512
      ca:	00001597          	auipc	a1,0x1
      ce:	01e58593          	addi	a1,a1,30 # 10e8 <buf>
      d2:	853e                	mv	a0,a5
      d4:	00000097          	auipc	ra,0x0
      d8:	5fc080e7          	jalr	1532(ra) # 6d0 <read>
      dc:	87aa                	mv	a5,a0
      de:	fcf42c23          	sw	a5,-40(s0)
      e2:	fd842783          	lw	a5,-40(s0)
      e6:	2781                	sext.w	a5,a5
      e8:	f4f042e3          	bgtz	a5,2c <wc+0x2c>
      }
    }
  }
  if(n < 0){
      ec:	fd842783          	lw	a5,-40(s0)
      f0:	2781                	sext.w	a5,a5
      f2:	0007df63          	bgez	a5,110 <wc+0x110>
    printf("wc: read error\n");
      f6:	00001517          	auipc	a0,0x1
      fa:	f4250513          	addi	a0,a0,-190 # 1038 <lock_init+0x1e>
      fe:	00001097          	auipc	ra,0x1
     102:	af2080e7          	jalr	-1294(ra) # bf0 <printf>
    exit(1);
     106:	4505                	li	a0,1
     108:	00000097          	auipc	ra,0x0
     10c:	5b0080e7          	jalr	1456(ra) # 6b8 <exit>
  }
  printf("%d %d %d %s\n", l, w, c, name);
     110:	fe042683          	lw	a3,-32(s0)
     114:	fe442603          	lw	a2,-28(s0)
     118:	fe842783          	lw	a5,-24(s0)
     11c:	fc043703          	ld	a4,-64(s0)
     120:	85be                	mv	a1,a5
     122:	00001517          	auipc	a0,0x1
     126:	f2650513          	addi	a0,a0,-218 # 1048 <lock_init+0x2e>
     12a:	00001097          	auipc	ra,0x1
     12e:	ac6080e7          	jalr	-1338(ra) # bf0 <printf>
}
     132:	0001                	nop
     134:	70e2                	ld	ra,56(sp)
     136:	7442                	ld	s0,48(sp)
     138:	6121                	addi	sp,sp,64
     13a:	8082                	ret

000000000000013c <main>:

int
main(int argc, char *argv[])
{
     13c:	7179                	addi	sp,sp,-48
     13e:	f406                	sd	ra,40(sp)
     140:	f022                	sd	s0,32(sp)
     142:	1800                	addi	s0,sp,48
     144:	87aa                	mv	a5,a0
     146:	fcb43823          	sd	a1,-48(s0)
     14a:	fcf42e23          	sw	a5,-36(s0)
  int fd, i;

  if(argc <= 1){
     14e:	fdc42783          	lw	a5,-36(s0)
     152:	0007871b          	sext.w	a4,a5
     156:	4785                	li	a5,1
     158:	02e7c063          	blt	a5,a4,178 <main+0x3c>
    wc(0, "");
     15c:	00001597          	auipc	a1,0x1
     160:	efc58593          	addi	a1,a1,-260 # 1058 <lock_init+0x3e>
     164:	4501                	li	a0,0
     166:	00000097          	auipc	ra,0x0
     16a:	e9a080e7          	jalr	-358(ra) # 0 <wc>
    exit(0);
     16e:	4501                	li	a0,0
     170:	00000097          	auipc	ra,0x0
     174:	548080e7          	jalr	1352(ra) # 6b8 <exit>
  }

  for(i = 1; i < argc; i++){
     178:	4785                	li	a5,1
     17a:	fef42623          	sw	a5,-20(s0)
     17e:	a071                	j	20a <main+0xce>
    if((fd = open(argv[i], 0)) < 0){
     180:	fec42783          	lw	a5,-20(s0)
     184:	078e                	slli	a5,a5,0x3
     186:	fd043703          	ld	a4,-48(s0)
     18a:	97ba                	add	a5,a5,a4
     18c:	639c                	ld	a5,0(a5)
     18e:	4581                	li	a1,0
     190:	853e                	mv	a0,a5
     192:	00000097          	auipc	ra,0x0
     196:	566080e7          	jalr	1382(ra) # 6f8 <open>
     19a:	87aa                	mv	a5,a0
     19c:	fef42423          	sw	a5,-24(s0)
     1a0:	fe842783          	lw	a5,-24(s0)
     1a4:	2781                	sext.w	a5,a5
     1a6:	0207d763          	bgez	a5,1d4 <main+0x98>
      printf("wc: cannot open %s\n", argv[i]);
     1aa:	fec42783          	lw	a5,-20(s0)
     1ae:	078e                	slli	a5,a5,0x3
     1b0:	fd043703          	ld	a4,-48(s0)
     1b4:	97ba                	add	a5,a5,a4
     1b6:	639c                	ld	a5,0(a5)
     1b8:	85be                	mv	a1,a5
     1ba:	00001517          	auipc	a0,0x1
     1be:	ea650513          	addi	a0,a0,-346 # 1060 <lock_init+0x46>
     1c2:	00001097          	auipc	ra,0x1
     1c6:	a2e080e7          	jalr	-1490(ra) # bf0 <printf>
      exit(1);
     1ca:	4505                	li	a0,1
     1cc:	00000097          	auipc	ra,0x0
     1d0:	4ec080e7          	jalr	1260(ra) # 6b8 <exit>
    }
    wc(fd, argv[i]);
     1d4:	fec42783          	lw	a5,-20(s0)
     1d8:	078e                	slli	a5,a5,0x3
     1da:	fd043703          	ld	a4,-48(s0)
     1de:	97ba                	add	a5,a5,a4
     1e0:	6398                	ld	a4,0(a5)
     1e2:	fe842783          	lw	a5,-24(s0)
     1e6:	85ba                	mv	a1,a4
     1e8:	853e                	mv	a0,a5
     1ea:	00000097          	auipc	ra,0x0
     1ee:	e16080e7          	jalr	-490(ra) # 0 <wc>
    close(fd);
     1f2:	fe842783          	lw	a5,-24(s0)
     1f6:	853e                	mv	a0,a5
     1f8:	00000097          	auipc	ra,0x0
     1fc:	4e8080e7          	jalr	1256(ra) # 6e0 <close>
  for(i = 1; i < argc; i++){
     200:	fec42783          	lw	a5,-20(s0)
     204:	2785                	addiw	a5,a5,1
     206:	fef42623          	sw	a5,-20(s0)
     20a:	fec42783          	lw	a5,-20(s0)
     20e:	873e                	mv	a4,a5
     210:	fdc42783          	lw	a5,-36(s0)
     214:	2701                	sext.w	a4,a4
     216:	2781                	sext.w	a5,a5
     218:	f6f744e3          	blt	a4,a5,180 <main+0x44>
  }
  exit(0);
     21c:	4501                	li	a0,0
     21e:	00000097          	auipc	ra,0x0
     222:	49a080e7          	jalr	1178(ra) # 6b8 <exit>

0000000000000226 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     226:	7179                	addi	sp,sp,-48
     228:	f422                	sd	s0,40(sp)
     22a:	1800                	addi	s0,sp,48
     22c:	fca43c23          	sd	a0,-40(s0)
     230:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     234:	fd843783          	ld	a5,-40(s0)
     238:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     23c:	0001                	nop
     23e:	fd043703          	ld	a4,-48(s0)
     242:	00170793          	addi	a5,a4,1
     246:	fcf43823          	sd	a5,-48(s0)
     24a:	fd843783          	ld	a5,-40(s0)
     24e:	00178693          	addi	a3,a5,1
     252:	fcd43c23          	sd	a3,-40(s0)
     256:	00074703          	lbu	a4,0(a4)
     25a:	00e78023          	sb	a4,0(a5)
     25e:	0007c783          	lbu	a5,0(a5)
     262:	fff1                	bnez	a5,23e <strcpy+0x18>
    ;
  return os;
     264:	fe843783          	ld	a5,-24(s0)
}
     268:	853e                	mv	a0,a5
     26a:	7422                	ld	s0,40(sp)
     26c:	6145                	addi	sp,sp,48
     26e:	8082                	ret

0000000000000270 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     270:	1101                	addi	sp,sp,-32
     272:	ec22                	sd	s0,24(sp)
     274:	1000                	addi	s0,sp,32
     276:	fea43423          	sd	a0,-24(s0)
     27a:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     27e:	a819                	j	294 <strcmp+0x24>
    p++, q++;
     280:	fe843783          	ld	a5,-24(s0)
     284:	0785                	addi	a5,a5,1
     286:	fef43423          	sd	a5,-24(s0)
     28a:	fe043783          	ld	a5,-32(s0)
     28e:	0785                	addi	a5,a5,1
     290:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     294:	fe843783          	ld	a5,-24(s0)
     298:	0007c783          	lbu	a5,0(a5)
     29c:	cb99                	beqz	a5,2b2 <strcmp+0x42>
     29e:	fe843783          	ld	a5,-24(s0)
     2a2:	0007c703          	lbu	a4,0(a5)
     2a6:	fe043783          	ld	a5,-32(s0)
     2aa:	0007c783          	lbu	a5,0(a5)
     2ae:	fcf709e3          	beq	a4,a5,280 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     2b2:	fe843783          	ld	a5,-24(s0)
     2b6:	0007c783          	lbu	a5,0(a5)
     2ba:	0007871b          	sext.w	a4,a5
     2be:	fe043783          	ld	a5,-32(s0)
     2c2:	0007c783          	lbu	a5,0(a5)
     2c6:	2781                	sext.w	a5,a5
     2c8:	40f707bb          	subw	a5,a4,a5
     2cc:	2781                	sext.w	a5,a5
}
     2ce:	853e                	mv	a0,a5
     2d0:	6462                	ld	s0,24(sp)
     2d2:	6105                	addi	sp,sp,32
     2d4:	8082                	ret

00000000000002d6 <strlen>:

uint
strlen(const char *s)
{
     2d6:	7179                	addi	sp,sp,-48
     2d8:	f422                	sd	s0,40(sp)
     2da:	1800                	addi	s0,sp,48
     2dc:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     2e0:	fe042623          	sw	zero,-20(s0)
     2e4:	a031                	j	2f0 <strlen+0x1a>
     2e6:	fec42783          	lw	a5,-20(s0)
     2ea:	2785                	addiw	a5,a5,1
     2ec:	fef42623          	sw	a5,-20(s0)
     2f0:	fec42783          	lw	a5,-20(s0)
     2f4:	fd843703          	ld	a4,-40(s0)
     2f8:	97ba                	add	a5,a5,a4
     2fa:	0007c783          	lbu	a5,0(a5)
     2fe:	f7e5                	bnez	a5,2e6 <strlen+0x10>
    ;
  return n;
     300:	fec42783          	lw	a5,-20(s0)
}
     304:	853e                	mv	a0,a5
     306:	7422                	ld	s0,40(sp)
     308:	6145                	addi	sp,sp,48
     30a:	8082                	ret

000000000000030c <memset>:

void*
memset(void *dst, int c, uint n)
{
     30c:	7179                	addi	sp,sp,-48
     30e:	f422                	sd	s0,40(sp)
     310:	1800                	addi	s0,sp,48
     312:	fca43c23          	sd	a0,-40(s0)
     316:	87ae                	mv	a5,a1
     318:	8732                	mv	a4,a2
     31a:	fcf42a23          	sw	a5,-44(s0)
     31e:	87ba                	mv	a5,a4
     320:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     324:	fd843783          	ld	a5,-40(s0)
     328:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     32c:	fe042623          	sw	zero,-20(s0)
     330:	a00d                	j	352 <memset+0x46>
    cdst[i] = c;
     332:	fec42783          	lw	a5,-20(s0)
     336:	fe043703          	ld	a4,-32(s0)
     33a:	97ba                	add	a5,a5,a4
     33c:	fd442703          	lw	a4,-44(s0)
     340:	0ff77713          	zext.b	a4,a4
     344:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     348:	fec42783          	lw	a5,-20(s0)
     34c:	2785                	addiw	a5,a5,1
     34e:	fef42623          	sw	a5,-20(s0)
     352:	fec42703          	lw	a4,-20(s0)
     356:	fd042783          	lw	a5,-48(s0)
     35a:	2781                	sext.w	a5,a5
     35c:	fcf76be3          	bltu	a4,a5,332 <memset+0x26>
  }
  return dst;
     360:	fd843783          	ld	a5,-40(s0)
}
     364:	853e                	mv	a0,a5
     366:	7422                	ld	s0,40(sp)
     368:	6145                	addi	sp,sp,48
     36a:	8082                	ret

000000000000036c <strchr>:

char*
strchr(const char *s, char c)
{
     36c:	1101                	addi	sp,sp,-32
     36e:	ec22                	sd	s0,24(sp)
     370:	1000                	addi	s0,sp,32
     372:	fea43423          	sd	a0,-24(s0)
     376:	87ae                	mv	a5,a1
     378:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     37c:	a01d                	j	3a2 <strchr+0x36>
    if(*s == c)
     37e:	fe843783          	ld	a5,-24(s0)
     382:	0007c703          	lbu	a4,0(a5)
     386:	fe744783          	lbu	a5,-25(s0)
     38a:	0ff7f793          	zext.b	a5,a5
     38e:	00e79563          	bne	a5,a4,398 <strchr+0x2c>
      return (char*)s;
     392:	fe843783          	ld	a5,-24(s0)
     396:	a821                	j	3ae <strchr+0x42>
  for(; *s; s++)
     398:	fe843783          	ld	a5,-24(s0)
     39c:	0785                	addi	a5,a5,1
     39e:	fef43423          	sd	a5,-24(s0)
     3a2:	fe843783          	ld	a5,-24(s0)
     3a6:	0007c783          	lbu	a5,0(a5)
     3aa:	fbf1                	bnez	a5,37e <strchr+0x12>
  return 0;
     3ac:	4781                	li	a5,0
}
     3ae:	853e                	mv	a0,a5
     3b0:	6462                	ld	s0,24(sp)
     3b2:	6105                	addi	sp,sp,32
     3b4:	8082                	ret

00000000000003b6 <gets>:

char*
gets(char *buf, int max)
{
     3b6:	7179                	addi	sp,sp,-48
     3b8:	f406                	sd	ra,40(sp)
     3ba:	f022                	sd	s0,32(sp)
     3bc:	1800                	addi	s0,sp,48
     3be:	fca43c23          	sd	a0,-40(s0)
     3c2:	87ae                	mv	a5,a1
     3c4:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     3c8:	fe042623          	sw	zero,-20(s0)
     3cc:	a8a1                	j	424 <gets+0x6e>
    cc = read(0, &c, 1);
     3ce:	fe740793          	addi	a5,s0,-25
     3d2:	4605                	li	a2,1
     3d4:	85be                	mv	a1,a5
     3d6:	4501                	li	a0,0
     3d8:	00000097          	auipc	ra,0x0
     3dc:	2f8080e7          	jalr	760(ra) # 6d0 <read>
     3e0:	87aa                	mv	a5,a0
     3e2:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     3e6:	fe842783          	lw	a5,-24(s0)
     3ea:	2781                	sext.w	a5,a5
     3ec:	04f05763          	blez	a5,43a <gets+0x84>
      break;
    buf[i++] = c;
     3f0:	fec42783          	lw	a5,-20(s0)
     3f4:	0017871b          	addiw	a4,a5,1
     3f8:	fee42623          	sw	a4,-20(s0)
     3fc:	873e                	mv	a4,a5
     3fe:	fd843783          	ld	a5,-40(s0)
     402:	97ba                	add	a5,a5,a4
     404:	fe744703          	lbu	a4,-25(s0)
     408:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     40c:	fe744783          	lbu	a5,-25(s0)
     410:	873e                	mv	a4,a5
     412:	47a9                	li	a5,10
     414:	02f70463          	beq	a4,a5,43c <gets+0x86>
     418:	fe744783          	lbu	a5,-25(s0)
     41c:	873e                	mv	a4,a5
     41e:	47b5                	li	a5,13
     420:	00f70e63          	beq	a4,a5,43c <gets+0x86>
  for(i=0; i+1 < max; ){
     424:	fec42783          	lw	a5,-20(s0)
     428:	2785                	addiw	a5,a5,1
     42a:	0007871b          	sext.w	a4,a5
     42e:	fd442783          	lw	a5,-44(s0)
     432:	2781                	sext.w	a5,a5
     434:	f8f74de3          	blt	a4,a5,3ce <gets+0x18>
     438:	a011                	j	43c <gets+0x86>
      break;
     43a:	0001                	nop
      break;
  }
  buf[i] = '\0';
     43c:	fec42783          	lw	a5,-20(s0)
     440:	fd843703          	ld	a4,-40(s0)
     444:	97ba                	add	a5,a5,a4
     446:	00078023          	sb	zero,0(a5)
  return buf;
     44a:	fd843783          	ld	a5,-40(s0)
}
     44e:	853e                	mv	a0,a5
     450:	70a2                	ld	ra,40(sp)
     452:	7402                	ld	s0,32(sp)
     454:	6145                	addi	sp,sp,48
     456:	8082                	ret

0000000000000458 <stat>:

int
stat(const char *n, struct stat *st)
{
     458:	7179                	addi	sp,sp,-48
     45a:	f406                	sd	ra,40(sp)
     45c:	f022                	sd	s0,32(sp)
     45e:	1800                	addi	s0,sp,48
     460:	fca43c23          	sd	a0,-40(s0)
     464:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     468:	4581                	li	a1,0
     46a:	fd843503          	ld	a0,-40(s0)
     46e:	00000097          	auipc	ra,0x0
     472:	28a080e7          	jalr	650(ra) # 6f8 <open>
     476:	87aa                	mv	a5,a0
     478:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     47c:	fec42783          	lw	a5,-20(s0)
     480:	2781                	sext.w	a5,a5
     482:	0007d463          	bgez	a5,48a <stat+0x32>
    return -1;
     486:	57fd                	li	a5,-1
     488:	a035                	j	4b4 <stat+0x5c>
  r = fstat(fd, st);
     48a:	fec42783          	lw	a5,-20(s0)
     48e:	fd043583          	ld	a1,-48(s0)
     492:	853e                	mv	a0,a5
     494:	00000097          	auipc	ra,0x0
     498:	27c080e7          	jalr	636(ra) # 710 <fstat>
     49c:	87aa                	mv	a5,a0
     49e:	fef42423          	sw	a5,-24(s0)
  close(fd);
     4a2:	fec42783          	lw	a5,-20(s0)
     4a6:	853e                	mv	a0,a5
     4a8:	00000097          	auipc	ra,0x0
     4ac:	238080e7          	jalr	568(ra) # 6e0 <close>
  return r;
     4b0:	fe842783          	lw	a5,-24(s0)
}
     4b4:	853e                	mv	a0,a5
     4b6:	70a2                	ld	ra,40(sp)
     4b8:	7402                	ld	s0,32(sp)
     4ba:	6145                	addi	sp,sp,48
     4bc:	8082                	ret

00000000000004be <atoi>:

int
atoi(const char *s)
{
     4be:	7179                	addi	sp,sp,-48
     4c0:	f422                	sd	s0,40(sp)
     4c2:	1800                	addi	s0,sp,48
     4c4:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     4c8:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     4cc:	a81d                	j	502 <atoi+0x44>
    n = n*10 + *s++ - '0';
     4ce:	fec42783          	lw	a5,-20(s0)
     4d2:	873e                	mv	a4,a5
     4d4:	87ba                	mv	a5,a4
     4d6:	0027979b          	slliw	a5,a5,0x2
     4da:	9fb9                	addw	a5,a5,a4
     4dc:	0017979b          	slliw	a5,a5,0x1
     4e0:	0007871b          	sext.w	a4,a5
     4e4:	fd843783          	ld	a5,-40(s0)
     4e8:	00178693          	addi	a3,a5,1
     4ec:	fcd43c23          	sd	a3,-40(s0)
     4f0:	0007c783          	lbu	a5,0(a5)
     4f4:	2781                	sext.w	a5,a5
     4f6:	9fb9                	addw	a5,a5,a4
     4f8:	2781                	sext.w	a5,a5
     4fa:	fd07879b          	addiw	a5,a5,-48
     4fe:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     502:	fd843783          	ld	a5,-40(s0)
     506:	0007c783          	lbu	a5,0(a5)
     50a:	873e                	mv	a4,a5
     50c:	02f00793          	li	a5,47
     510:	00e7fb63          	bgeu	a5,a4,526 <atoi+0x68>
     514:	fd843783          	ld	a5,-40(s0)
     518:	0007c783          	lbu	a5,0(a5)
     51c:	873e                	mv	a4,a5
     51e:	03900793          	li	a5,57
     522:	fae7f6e3          	bgeu	a5,a4,4ce <atoi+0x10>
  return n;
     526:	fec42783          	lw	a5,-20(s0)
}
     52a:	853e                	mv	a0,a5
     52c:	7422                	ld	s0,40(sp)
     52e:	6145                	addi	sp,sp,48
     530:	8082                	ret

0000000000000532 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     532:	7139                	addi	sp,sp,-64
     534:	fc22                	sd	s0,56(sp)
     536:	0080                	addi	s0,sp,64
     538:	fca43c23          	sd	a0,-40(s0)
     53c:	fcb43823          	sd	a1,-48(s0)
     540:	87b2                	mv	a5,a2
     542:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     546:	fd843783          	ld	a5,-40(s0)
     54a:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     54e:	fd043783          	ld	a5,-48(s0)
     552:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     556:	fe043703          	ld	a4,-32(s0)
     55a:	fe843783          	ld	a5,-24(s0)
     55e:	02e7fc63          	bgeu	a5,a4,596 <memmove+0x64>
    while(n-- > 0)
     562:	a00d                	j	584 <memmove+0x52>
      *dst++ = *src++;
     564:	fe043703          	ld	a4,-32(s0)
     568:	00170793          	addi	a5,a4,1
     56c:	fef43023          	sd	a5,-32(s0)
     570:	fe843783          	ld	a5,-24(s0)
     574:	00178693          	addi	a3,a5,1
     578:	fed43423          	sd	a3,-24(s0)
     57c:	00074703          	lbu	a4,0(a4)
     580:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     584:	fcc42783          	lw	a5,-52(s0)
     588:	fff7871b          	addiw	a4,a5,-1
     58c:	fce42623          	sw	a4,-52(s0)
     590:	fcf04ae3          	bgtz	a5,564 <memmove+0x32>
     594:	a891                	j	5e8 <memmove+0xb6>
  } else {
    dst += n;
     596:	fcc42783          	lw	a5,-52(s0)
     59a:	fe843703          	ld	a4,-24(s0)
     59e:	97ba                	add	a5,a5,a4
     5a0:	fef43423          	sd	a5,-24(s0)
    src += n;
     5a4:	fcc42783          	lw	a5,-52(s0)
     5a8:	fe043703          	ld	a4,-32(s0)
     5ac:	97ba                	add	a5,a5,a4
     5ae:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     5b2:	a01d                	j	5d8 <memmove+0xa6>
      *--dst = *--src;
     5b4:	fe043783          	ld	a5,-32(s0)
     5b8:	17fd                	addi	a5,a5,-1
     5ba:	fef43023          	sd	a5,-32(s0)
     5be:	fe843783          	ld	a5,-24(s0)
     5c2:	17fd                	addi	a5,a5,-1
     5c4:	fef43423          	sd	a5,-24(s0)
     5c8:	fe043783          	ld	a5,-32(s0)
     5cc:	0007c703          	lbu	a4,0(a5)
     5d0:	fe843783          	ld	a5,-24(s0)
     5d4:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     5d8:	fcc42783          	lw	a5,-52(s0)
     5dc:	fff7871b          	addiw	a4,a5,-1
     5e0:	fce42623          	sw	a4,-52(s0)
     5e4:	fcf048e3          	bgtz	a5,5b4 <memmove+0x82>
  }
  return vdst;
     5e8:	fd843783          	ld	a5,-40(s0)
}
     5ec:	853e                	mv	a0,a5
     5ee:	7462                	ld	s0,56(sp)
     5f0:	6121                	addi	sp,sp,64
     5f2:	8082                	ret

00000000000005f4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     5f4:	7139                	addi	sp,sp,-64
     5f6:	fc22                	sd	s0,56(sp)
     5f8:	0080                	addi	s0,sp,64
     5fa:	fca43c23          	sd	a0,-40(s0)
     5fe:	fcb43823          	sd	a1,-48(s0)
     602:	87b2                	mv	a5,a2
     604:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     608:	fd843783          	ld	a5,-40(s0)
     60c:	fef43423          	sd	a5,-24(s0)
     610:	fd043783          	ld	a5,-48(s0)
     614:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     618:	a0a1                	j	660 <memcmp+0x6c>
    if (*p1 != *p2) {
     61a:	fe843783          	ld	a5,-24(s0)
     61e:	0007c703          	lbu	a4,0(a5)
     622:	fe043783          	ld	a5,-32(s0)
     626:	0007c783          	lbu	a5,0(a5)
     62a:	02f70163          	beq	a4,a5,64c <memcmp+0x58>
      return *p1 - *p2;
     62e:	fe843783          	ld	a5,-24(s0)
     632:	0007c783          	lbu	a5,0(a5)
     636:	0007871b          	sext.w	a4,a5
     63a:	fe043783          	ld	a5,-32(s0)
     63e:	0007c783          	lbu	a5,0(a5)
     642:	2781                	sext.w	a5,a5
     644:	40f707bb          	subw	a5,a4,a5
     648:	2781                	sext.w	a5,a5
     64a:	a01d                	j	670 <memcmp+0x7c>
    }
    p1++;
     64c:	fe843783          	ld	a5,-24(s0)
     650:	0785                	addi	a5,a5,1
     652:	fef43423          	sd	a5,-24(s0)
    p2++;
     656:	fe043783          	ld	a5,-32(s0)
     65a:	0785                	addi	a5,a5,1
     65c:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     660:	fcc42783          	lw	a5,-52(s0)
     664:	fff7871b          	addiw	a4,a5,-1
     668:	fce42623          	sw	a4,-52(s0)
     66c:	f7dd                	bnez	a5,61a <memcmp+0x26>
  }
  return 0;
     66e:	4781                	li	a5,0
}
     670:	853e                	mv	a0,a5
     672:	7462                	ld	s0,56(sp)
     674:	6121                	addi	sp,sp,64
     676:	8082                	ret

0000000000000678 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     678:	7179                	addi	sp,sp,-48
     67a:	f406                	sd	ra,40(sp)
     67c:	f022                	sd	s0,32(sp)
     67e:	1800                	addi	s0,sp,48
     680:	fea43423          	sd	a0,-24(s0)
     684:	feb43023          	sd	a1,-32(s0)
     688:	87b2                	mv	a5,a2
     68a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     68e:	fdc42783          	lw	a5,-36(s0)
     692:	863e                	mv	a2,a5
     694:	fe043583          	ld	a1,-32(s0)
     698:	fe843503          	ld	a0,-24(s0)
     69c:	00000097          	auipc	ra,0x0
     6a0:	e96080e7          	jalr	-362(ra) # 532 <memmove>
     6a4:	87aa                	mv	a5,a0
}
     6a6:	853e                	mv	a0,a5
     6a8:	70a2                	ld	ra,40(sp)
     6aa:	7402                	ld	s0,32(sp)
     6ac:	6145                	addi	sp,sp,48
     6ae:	8082                	ret

00000000000006b0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     6b0:	4885                	li	a7,1
 ecall
     6b2:	00000073          	ecall
 ret
     6b6:	8082                	ret

00000000000006b8 <exit>:
.global exit
exit:
 li a7, SYS_exit
     6b8:	4889                	li	a7,2
 ecall
     6ba:	00000073          	ecall
 ret
     6be:	8082                	ret

00000000000006c0 <wait>:
.global wait
wait:
 li a7, SYS_wait
     6c0:	488d                	li	a7,3
 ecall
     6c2:	00000073          	ecall
 ret
     6c6:	8082                	ret

00000000000006c8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     6c8:	4891                	li	a7,4
 ecall
     6ca:	00000073          	ecall
 ret
     6ce:	8082                	ret

00000000000006d0 <read>:
.global read
read:
 li a7, SYS_read
     6d0:	4895                	li	a7,5
 ecall
     6d2:	00000073          	ecall
 ret
     6d6:	8082                	ret

00000000000006d8 <write>:
.global write
write:
 li a7, SYS_write
     6d8:	48c1                	li	a7,16
 ecall
     6da:	00000073          	ecall
 ret
     6de:	8082                	ret

00000000000006e0 <close>:
.global close
close:
 li a7, SYS_close
     6e0:	48d5                	li	a7,21
 ecall
     6e2:	00000073          	ecall
 ret
     6e6:	8082                	ret

00000000000006e8 <kill>:
.global kill
kill:
 li a7, SYS_kill
     6e8:	4899                	li	a7,6
 ecall
     6ea:	00000073          	ecall
 ret
     6ee:	8082                	ret

00000000000006f0 <exec>:
.global exec
exec:
 li a7, SYS_exec
     6f0:	489d                	li	a7,7
 ecall
     6f2:	00000073          	ecall
 ret
     6f6:	8082                	ret

00000000000006f8 <open>:
.global open
open:
 li a7, SYS_open
     6f8:	48bd                	li	a7,15
 ecall
     6fa:	00000073          	ecall
 ret
     6fe:	8082                	ret

0000000000000700 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     700:	48c5                	li	a7,17
 ecall
     702:	00000073          	ecall
 ret
     706:	8082                	ret

0000000000000708 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     708:	48c9                	li	a7,18
 ecall
     70a:	00000073          	ecall
 ret
     70e:	8082                	ret

0000000000000710 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     710:	48a1                	li	a7,8
 ecall
     712:	00000073          	ecall
 ret
     716:	8082                	ret

0000000000000718 <link>:
.global link
link:
 li a7, SYS_link
     718:	48cd                	li	a7,19
 ecall
     71a:	00000073          	ecall
 ret
     71e:	8082                	ret

0000000000000720 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     720:	48d1                	li	a7,20
 ecall
     722:	00000073          	ecall
 ret
     726:	8082                	ret

0000000000000728 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     728:	48a5                	li	a7,9
 ecall
     72a:	00000073          	ecall
 ret
     72e:	8082                	ret

0000000000000730 <dup>:
.global dup
dup:
 li a7, SYS_dup
     730:	48a9                	li	a7,10
 ecall
     732:	00000073          	ecall
 ret
     736:	8082                	ret

0000000000000738 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     738:	48ad                	li	a7,11
 ecall
     73a:	00000073          	ecall
 ret
     73e:	8082                	ret

0000000000000740 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     740:	48b1                	li	a7,12
 ecall
     742:	00000073          	ecall
 ret
     746:	8082                	ret

0000000000000748 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     748:	48b5                	li	a7,13
 ecall
     74a:	00000073          	ecall
 ret
     74e:	8082                	ret

0000000000000750 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     750:	48b9                	li	a7,14
 ecall
     752:	00000073          	ecall
 ret
     756:	8082                	ret

0000000000000758 <clone>:
.global clone
clone:
 li a7, SYS_clone
     758:	48d9                	li	a7,22
 ecall
     75a:	00000073          	ecall
 ret
     75e:	8082                	ret

0000000000000760 <join>:
.global join
join:
 li a7, SYS_join
     760:	48dd                	li	a7,23
 ecall
     762:	00000073          	ecall
 ret
     766:	8082                	ret

0000000000000768 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     768:	1101                	addi	sp,sp,-32
     76a:	ec06                	sd	ra,24(sp)
     76c:	e822                	sd	s0,16(sp)
     76e:	1000                	addi	s0,sp,32
     770:	87aa                	mv	a5,a0
     772:	872e                	mv	a4,a1
     774:	fef42623          	sw	a5,-20(s0)
     778:	87ba                	mv	a5,a4
     77a:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     77e:	feb40713          	addi	a4,s0,-21
     782:	fec42783          	lw	a5,-20(s0)
     786:	4605                	li	a2,1
     788:	85ba                	mv	a1,a4
     78a:	853e                	mv	a0,a5
     78c:	00000097          	auipc	ra,0x0
     790:	f4c080e7          	jalr	-180(ra) # 6d8 <write>
}
     794:	0001                	nop
     796:	60e2                	ld	ra,24(sp)
     798:	6442                	ld	s0,16(sp)
     79a:	6105                	addi	sp,sp,32
     79c:	8082                	ret

000000000000079e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     79e:	7139                	addi	sp,sp,-64
     7a0:	fc06                	sd	ra,56(sp)
     7a2:	f822                	sd	s0,48(sp)
     7a4:	0080                	addi	s0,sp,64
     7a6:	87aa                	mv	a5,a0
     7a8:	8736                	mv	a4,a3
     7aa:	fcf42623          	sw	a5,-52(s0)
     7ae:	87ae                	mv	a5,a1
     7b0:	fcf42423          	sw	a5,-56(s0)
     7b4:	87b2                	mv	a5,a2
     7b6:	fcf42223          	sw	a5,-60(s0)
     7ba:	87ba                	mv	a5,a4
     7bc:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     7c0:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     7c4:	fc042783          	lw	a5,-64(s0)
     7c8:	2781                	sext.w	a5,a5
     7ca:	c38d                	beqz	a5,7ec <printint+0x4e>
     7cc:	fc842783          	lw	a5,-56(s0)
     7d0:	2781                	sext.w	a5,a5
     7d2:	0007dd63          	bgez	a5,7ec <printint+0x4e>
    neg = 1;
     7d6:	4785                	li	a5,1
     7d8:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     7dc:	fc842783          	lw	a5,-56(s0)
     7e0:	40f007bb          	negw	a5,a5
     7e4:	2781                	sext.w	a5,a5
     7e6:	fef42223          	sw	a5,-28(s0)
     7ea:	a029                	j	7f4 <printint+0x56>
  } else {
    x = xx;
     7ec:	fc842783          	lw	a5,-56(s0)
     7f0:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     7f4:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     7f8:	fc442783          	lw	a5,-60(s0)
     7fc:	fe442703          	lw	a4,-28(s0)
     800:	02f777bb          	remuw	a5,a4,a5
     804:	0007861b          	sext.w	a2,a5
     808:	fec42783          	lw	a5,-20(s0)
     80c:	0017871b          	addiw	a4,a5,1
     810:	fee42623          	sw	a4,-20(s0)
     814:	00001697          	auipc	a3,0x1
     818:	8bc68693          	addi	a3,a3,-1860 # 10d0 <digits>
     81c:	02061713          	slli	a4,a2,0x20
     820:	9301                	srli	a4,a4,0x20
     822:	9736                	add	a4,a4,a3
     824:	00074703          	lbu	a4,0(a4)
     828:	17c1                	addi	a5,a5,-16
     82a:	97a2                	add	a5,a5,s0
     82c:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     830:	fc442783          	lw	a5,-60(s0)
     834:	fe442703          	lw	a4,-28(s0)
     838:	02f757bb          	divuw	a5,a4,a5
     83c:	fef42223          	sw	a5,-28(s0)
     840:	fe442783          	lw	a5,-28(s0)
     844:	2781                	sext.w	a5,a5
     846:	fbcd                	bnez	a5,7f8 <printint+0x5a>
  if(neg)
     848:	fe842783          	lw	a5,-24(s0)
     84c:	2781                	sext.w	a5,a5
     84e:	cf85                	beqz	a5,886 <printint+0xe8>
    buf[i++] = '-';
     850:	fec42783          	lw	a5,-20(s0)
     854:	0017871b          	addiw	a4,a5,1
     858:	fee42623          	sw	a4,-20(s0)
     85c:	17c1                	addi	a5,a5,-16
     85e:	97a2                	add	a5,a5,s0
     860:	02d00713          	li	a4,45
     864:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     868:	a839                	j	886 <printint+0xe8>
    putc(fd, buf[i]);
     86a:	fec42783          	lw	a5,-20(s0)
     86e:	17c1                	addi	a5,a5,-16
     870:	97a2                	add	a5,a5,s0
     872:	fe07c703          	lbu	a4,-32(a5)
     876:	fcc42783          	lw	a5,-52(s0)
     87a:	85ba                	mv	a1,a4
     87c:	853e                	mv	a0,a5
     87e:	00000097          	auipc	ra,0x0
     882:	eea080e7          	jalr	-278(ra) # 768 <putc>
  while(--i >= 0)
     886:	fec42783          	lw	a5,-20(s0)
     88a:	37fd                	addiw	a5,a5,-1
     88c:	fef42623          	sw	a5,-20(s0)
     890:	fec42783          	lw	a5,-20(s0)
     894:	2781                	sext.w	a5,a5
     896:	fc07dae3          	bgez	a5,86a <printint+0xcc>
}
     89a:	0001                	nop
     89c:	0001                	nop
     89e:	70e2                	ld	ra,56(sp)
     8a0:	7442                	ld	s0,48(sp)
     8a2:	6121                	addi	sp,sp,64
     8a4:	8082                	ret

00000000000008a6 <printptr>:

static void
printptr(int fd, uint64 x) {
     8a6:	7179                	addi	sp,sp,-48
     8a8:	f406                	sd	ra,40(sp)
     8aa:	f022                	sd	s0,32(sp)
     8ac:	1800                	addi	s0,sp,48
     8ae:	87aa                	mv	a5,a0
     8b0:	fcb43823          	sd	a1,-48(s0)
     8b4:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     8b8:	fdc42783          	lw	a5,-36(s0)
     8bc:	03000593          	li	a1,48
     8c0:	853e                	mv	a0,a5
     8c2:	00000097          	auipc	ra,0x0
     8c6:	ea6080e7          	jalr	-346(ra) # 768 <putc>
  putc(fd, 'x');
     8ca:	fdc42783          	lw	a5,-36(s0)
     8ce:	07800593          	li	a1,120
     8d2:	853e                	mv	a0,a5
     8d4:	00000097          	auipc	ra,0x0
     8d8:	e94080e7          	jalr	-364(ra) # 768 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     8dc:	fe042623          	sw	zero,-20(s0)
     8e0:	a82d                	j	91a <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     8e2:	fd043783          	ld	a5,-48(s0)
     8e6:	93f1                	srli	a5,a5,0x3c
     8e8:	00000717          	auipc	a4,0x0
     8ec:	7e870713          	addi	a4,a4,2024 # 10d0 <digits>
     8f0:	97ba                	add	a5,a5,a4
     8f2:	0007c703          	lbu	a4,0(a5)
     8f6:	fdc42783          	lw	a5,-36(s0)
     8fa:	85ba                	mv	a1,a4
     8fc:	853e                	mv	a0,a5
     8fe:	00000097          	auipc	ra,0x0
     902:	e6a080e7          	jalr	-406(ra) # 768 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     906:	fec42783          	lw	a5,-20(s0)
     90a:	2785                	addiw	a5,a5,1
     90c:	fef42623          	sw	a5,-20(s0)
     910:	fd043783          	ld	a5,-48(s0)
     914:	0792                	slli	a5,a5,0x4
     916:	fcf43823          	sd	a5,-48(s0)
     91a:	fec42783          	lw	a5,-20(s0)
     91e:	873e                	mv	a4,a5
     920:	47bd                	li	a5,15
     922:	fce7f0e3          	bgeu	a5,a4,8e2 <printptr+0x3c>
}
     926:	0001                	nop
     928:	0001                	nop
     92a:	70a2                	ld	ra,40(sp)
     92c:	7402                	ld	s0,32(sp)
     92e:	6145                	addi	sp,sp,48
     930:	8082                	ret

0000000000000932 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     932:	715d                	addi	sp,sp,-80
     934:	e486                	sd	ra,72(sp)
     936:	e0a2                	sd	s0,64(sp)
     938:	0880                	addi	s0,sp,80
     93a:	87aa                	mv	a5,a0
     93c:	fcb43023          	sd	a1,-64(s0)
     940:	fac43c23          	sd	a2,-72(s0)
     944:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     948:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     94c:	fe042223          	sw	zero,-28(s0)
     950:	a42d                	j	b7a <vprintf+0x248>
    c = fmt[i] & 0xff;
     952:	fe442783          	lw	a5,-28(s0)
     956:	fc043703          	ld	a4,-64(s0)
     95a:	97ba                	add	a5,a5,a4
     95c:	0007c783          	lbu	a5,0(a5)
     960:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     964:	fe042783          	lw	a5,-32(s0)
     968:	2781                	sext.w	a5,a5
     96a:	eb9d                	bnez	a5,9a0 <vprintf+0x6e>
      if(c == '%'){
     96c:	fdc42783          	lw	a5,-36(s0)
     970:	0007871b          	sext.w	a4,a5
     974:	02500793          	li	a5,37
     978:	00f71763          	bne	a4,a5,986 <vprintf+0x54>
        state = '%';
     97c:	02500793          	li	a5,37
     980:	fef42023          	sw	a5,-32(s0)
     984:	a2f5                	j	b70 <vprintf+0x23e>
      } else {
        putc(fd, c);
     986:	fdc42783          	lw	a5,-36(s0)
     98a:	0ff7f713          	zext.b	a4,a5
     98e:	fcc42783          	lw	a5,-52(s0)
     992:	85ba                	mv	a1,a4
     994:	853e                	mv	a0,a5
     996:	00000097          	auipc	ra,0x0
     99a:	dd2080e7          	jalr	-558(ra) # 768 <putc>
     99e:	aac9                	j	b70 <vprintf+0x23e>
      }
    } else if(state == '%'){
     9a0:	fe042783          	lw	a5,-32(s0)
     9a4:	0007871b          	sext.w	a4,a5
     9a8:	02500793          	li	a5,37
     9ac:	1cf71263          	bne	a4,a5,b70 <vprintf+0x23e>
      if(c == 'd'){
     9b0:	fdc42783          	lw	a5,-36(s0)
     9b4:	0007871b          	sext.w	a4,a5
     9b8:	06400793          	li	a5,100
     9bc:	02f71463          	bne	a4,a5,9e4 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     9c0:	fb843783          	ld	a5,-72(s0)
     9c4:	00878713          	addi	a4,a5,8
     9c8:	fae43c23          	sd	a4,-72(s0)
     9cc:	4398                	lw	a4,0(a5)
     9ce:	fcc42783          	lw	a5,-52(s0)
     9d2:	4685                	li	a3,1
     9d4:	4629                	li	a2,10
     9d6:	85ba                	mv	a1,a4
     9d8:	853e                	mv	a0,a5
     9da:	00000097          	auipc	ra,0x0
     9de:	dc4080e7          	jalr	-572(ra) # 79e <printint>
     9e2:	a269                	j	b6c <vprintf+0x23a>
      } else if(c == 'l') {
     9e4:	fdc42783          	lw	a5,-36(s0)
     9e8:	0007871b          	sext.w	a4,a5
     9ec:	06c00793          	li	a5,108
     9f0:	02f71663          	bne	a4,a5,a1c <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     9f4:	fb843783          	ld	a5,-72(s0)
     9f8:	00878713          	addi	a4,a5,8
     9fc:	fae43c23          	sd	a4,-72(s0)
     a00:	639c                	ld	a5,0(a5)
     a02:	0007871b          	sext.w	a4,a5
     a06:	fcc42783          	lw	a5,-52(s0)
     a0a:	4681                	li	a3,0
     a0c:	4629                	li	a2,10
     a0e:	85ba                	mv	a1,a4
     a10:	853e                	mv	a0,a5
     a12:	00000097          	auipc	ra,0x0
     a16:	d8c080e7          	jalr	-628(ra) # 79e <printint>
     a1a:	aa89                	j	b6c <vprintf+0x23a>
      } else if(c == 'x') {
     a1c:	fdc42783          	lw	a5,-36(s0)
     a20:	0007871b          	sext.w	a4,a5
     a24:	07800793          	li	a5,120
     a28:	02f71463          	bne	a4,a5,a50 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     a2c:	fb843783          	ld	a5,-72(s0)
     a30:	00878713          	addi	a4,a5,8
     a34:	fae43c23          	sd	a4,-72(s0)
     a38:	4398                	lw	a4,0(a5)
     a3a:	fcc42783          	lw	a5,-52(s0)
     a3e:	4681                	li	a3,0
     a40:	4641                	li	a2,16
     a42:	85ba                	mv	a1,a4
     a44:	853e                	mv	a0,a5
     a46:	00000097          	auipc	ra,0x0
     a4a:	d58080e7          	jalr	-680(ra) # 79e <printint>
     a4e:	aa39                	j	b6c <vprintf+0x23a>
      } else if(c == 'p') {
     a50:	fdc42783          	lw	a5,-36(s0)
     a54:	0007871b          	sext.w	a4,a5
     a58:	07000793          	li	a5,112
     a5c:	02f71263          	bne	a4,a5,a80 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     a60:	fb843783          	ld	a5,-72(s0)
     a64:	00878713          	addi	a4,a5,8
     a68:	fae43c23          	sd	a4,-72(s0)
     a6c:	6398                	ld	a4,0(a5)
     a6e:	fcc42783          	lw	a5,-52(s0)
     a72:	85ba                	mv	a1,a4
     a74:	853e                	mv	a0,a5
     a76:	00000097          	auipc	ra,0x0
     a7a:	e30080e7          	jalr	-464(ra) # 8a6 <printptr>
     a7e:	a0fd                	j	b6c <vprintf+0x23a>
      } else if(c == 's'){
     a80:	fdc42783          	lw	a5,-36(s0)
     a84:	0007871b          	sext.w	a4,a5
     a88:	07300793          	li	a5,115
     a8c:	04f71c63          	bne	a4,a5,ae4 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     a90:	fb843783          	ld	a5,-72(s0)
     a94:	00878713          	addi	a4,a5,8
     a98:	fae43c23          	sd	a4,-72(s0)
     a9c:	639c                	ld	a5,0(a5)
     a9e:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     aa2:	fe843783          	ld	a5,-24(s0)
     aa6:	eb8d                	bnez	a5,ad8 <vprintf+0x1a6>
          s = "(null)";
     aa8:	00000797          	auipc	a5,0x0
     aac:	5d078793          	addi	a5,a5,1488 # 1078 <lock_init+0x5e>
     ab0:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     ab4:	a015                	j	ad8 <vprintf+0x1a6>
          putc(fd, *s);
     ab6:	fe843783          	ld	a5,-24(s0)
     aba:	0007c703          	lbu	a4,0(a5)
     abe:	fcc42783          	lw	a5,-52(s0)
     ac2:	85ba                	mv	a1,a4
     ac4:	853e                	mv	a0,a5
     ac6:	00000097          	auipc	ra,0x0
     aca:	ca2080e7          	jalr	-862(ra) # 768 <putc>
          s++;
     ace:	fe843783          	ld	a5,-24(s0)
     ad2:	0785                	addi	a5,a5,1
     ad4:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     ad8:	fe843783          	ld	a5,-24(s0)
     adc:	0007c783          	lbu	a5,0(a5)
     ae0:	fbf9                	bnez	a5,ab6 <vprintf+0x184>
     ae2:	a069                	j	b6c <vprintf+0x23a>
        }
      } else if(c == 'c'){
     ae4:	fdc42783          	lw	a5,-36(s0)
     ae8:	0007871b          	sext.w	a4,a5
     aec:	06300793          	li	a5,99
     af0:	02f71463          	bne	a4,a5,b18 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     af4:	fb843783          	ld	a5,-72(s0)
     af8:	00878713          	addi	a4,a5,8
     afc:	fae43c23          	sd	a4,-72(s0)
     b00:	439c                	lw	a5,0(a5)
     b02:	0ff7f713          	zext.b	a4,a5
     b06:	fcc42783          	lw	a5,-52(s0)
     b0a:	85ba                	mv	a1,a4
     b0c:	853e                	mv	a0,a5
     b0e:	00000097          	auipc	ra,0x0
     b12:	c5a080e7          	jalr	-934(ra) # 768 <putc>
     b16:	a899                	j	b6c <vprintf+0x23a>
      } else if(c == '%'){
     b18:	fdc42783          	lw	a5,-36(s0)
     b1c:	0007871b          	sext.w	a4,a5
     b20:	02500793          	li	a5,37
     b24:	00f71f63          	bne	a4,a5,b42 <vprintf+0x210>
        putc(fd, c);
     b28:	fdc42783          	lw	a5,-36(s0)
     b2c:	0ff7f713          	zext.b	a4,a5
     b30:	fcc42783          	lw	a5,-52(s0)
     b34:	85ba                	mv	a1,a4
     b36:	853e                	mv	a0,a5
     b38:	00000097          	auipc	ra,0x0
     b3c:	c30080e7          	jalr	-976(ra) # 768 <putc>
     b40:	a035                	j	b6c <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     b42:	fcc42783          	lw	a5,-52(s0)
     b46:	02500593          	li	a1,37
     b4a:	853e                	mv	a0,a5
     b4c:	00000097          	auipc	ra,0x0
     b50:	c1c080e7          	jalr	-996(ra) # 768 <putc>
        putc(fd, c);
     b54:	fdc42783          	lw	a5,-36(s0)
     b58:	0ff7f713          	zext.b	a4,a5
     b5c:	fcc42783          	lw	a5,-52(s0)
     b60:	85ba                	mv	a1,a4
     b62:	853e                	mv	a0,a5
     b64:	00000097          	auipc	ra,0x0
     b68:	c04080e7          	jalr	-1020(ra) # 768 <putc>
      }
      state = 0;
     b6c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     b70:	fe442783          	lw	a5,-28(s0)
     b74:	2785                	addiw	a5,a5,1
     b76:	fef42223          	sw	a5,-28(s0)
     b7a:	fe442783          	lw	a5,-28(s0)
     b7e:	fc043703          	ld	a4,-64(s0)
     b82:	97ba                	add	a5,a5,a4
     b84:	0007c783          	lbu	a5,0(a5)
     b88:	dc0795e3          	bnez	a5,952 <vprintf+0x20>
    }
  }
}
     b8c:	0001                	nop
     b8e:	0001                	nop
     b90:	60a6                	ld	ra,72(sp)
     b92:	6406                	ld	s0,64(sp)
     b94:	6161                	addi	sp,sp,80
     b96:	8082                	ret

0000000000000b98 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     b98:	7159                	addi	sp,sp,-112
     b9a:	fc06                	sd	ra,56(sp)
     b9c:	f822                	sd	s0,48(sp)
     b9e:	0080                	addi	s0,sp,64
     ba0:	fcb43823          	sd	a1,-48(s0)
     ba4:	e010                	sd	a2,0(s0)
     ba6:	e414                	sd	a3,8(s0)
     ba8:	e818                	sd	a4,16(s0)
     baa:	ec1c                	sd	a5,24(s0)
     bac:	03043023          	sd	a6,32(s0)
     bb0:	03143423          	sd	a7,40(s0)
     bb4:	87aa                	mv	a5,a0
     bb6:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     bba:	03040793          	addi	a5,s0,48
     bbe:	fcf43423          	sd	a5,-56(s0)
     bc2:	fc843783          	ld	a5,-56(s0)
     bc6:	fd078793          	addi	a5,a5,-48
     bca:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     bce:	fe843703          	ld	a4,-24(s0)
     bd2:	fdc42783          	lw	a5,-36(s0)
     bd6:	863a                	mv	a2,a4
     bd8:	fd043583          	ld	a1,-48(s0)
     bdc:	853e                	mv	a0,a5
     bde:	00000097          	auipc	ra,0x0
     be2:	d54080e7          	jalr	-684(ra) # 932 <vprintf>
}
     be6:	0001                	nop
     be8:	70e2                	ld	ra,56(sp)
     bea:	7442                	ld	s0,48(sp)
     bec:	6165                	addi	sp,sp,112
     bee:	8082                	ret

0000000000000bf0 <printf>:

void
printf(const char *fmt, ...)
{
     bf0:	7159                	addi	sp,sp,-112
     bf2:	f406                	sd	ra,40(sp)
     bf4:	f022                	sd	s0,32(sp)
     bf6:	1800                	addi	s0,sp,48
     bf8:	fca43c23          	sd	a0,-40(s0)
     bfc:	e40c                	sd	a1,8(s0)
     bfe:	e810                	sd	a2,16(s0)
     c00:	ec14                	sd	a3,24(s0)
     c02:	f018                	sd	a4,32(s0)
     c04:	f41c                	sd	a5,40(s0)
     c06:	03043823          	sd	a6,48(s0)
     c0a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     c0e:	04040793          	addi	a5,s0,64
     c12:	fcf43823          	sd	a5,-48(s0)
     c16:	fd043783          	ld	a5,-48(s0)
     c1a:	fc878793          	addi	a5,a5,-56
     c1e:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     c22:	fe843783          	ld	a5,-24(s0)
     c26:	863e                	mv	a2,a5
     c28:	fd843583          	ld	a1,-40(s0)
     c2c:	4505                	li	a0,1
     c2e:	00000097          	auipc	ra,0x0
     c32:	d04080e7          	jalr	-764(ra) # 932 <vprintf>
}
     c36:	0001                	nop
     c38:	70a2                	ld	ra,40(sp)
     c3a:	7402                	ld	s0,32(sp)
     c3c:	6165                	addi	sp,sp,112
     c3e:	8082                	ret

0000000000000c40 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     c40:	7179                	addi	sp,sp,-48
     c42:	f422                	sd	s0,40(sp)
     c44:	1800                	addi	s0,sp,48
     c46:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     c4a:	fd843783          	ld	a5,-40(s0)
     c4e:	17c1                	addi	a5,a5,-16
     c50:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     c54:	00000797          	auipc	a5,0x0
     c58:	6a478793          	addi	a5,a5,1700 # 12f8 <freep>
     c5c:	639c                	ld	a5,0(a5)
     c5e:	fef43423          	sd	a5,-24(s0)
     c62:	a815                	j	c96 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     c64:	fe843783          	ld	a5,-24(s0)
     c68:	639c                	ld	a5,0(a5)
     c6a:	fe843703          	ld	a4,-24(s0)
     c6e:	00f76f63          	bltu	a4,a5,c8c <free+0x4c>
     c72:	fe043703          	ld	a4,-32(s0)
     c76:	fe843783          	ld	a5,-24(s0)
     c7a:	02e7eb63          	bltu	a5,a4,cb0 <free+0x70>
     c7e:	fe843783          	ld	a5,-24(s0)
     c82:	639c                	ld	a5,0(a5)
     c84:	fe043703          	ld	a4,-32(s0)
     c88:	02f76463          	bltu	a4,a5,cb0 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     c8c:	fe843783          	ld	a5,-24(s0)
     c90:	639c                	ld	a5,0(a5)
     c92:	fef43423          	sd	a5,-24(s0)
     c96:	fe043703          	ld	a4,-32(s0)
     c9a:	fe843783          	ld	a5,-24(s0)
     c9e:	fce7f3e3          	bgeu	a5,a4,c64 <free+0x24>
     ca2:	fe843783          	ld	a5,-24(s0)
     ca6:	639c                	ld	a5,0(a5)
     ca8:	fe043703          	ld	a4,-32(s0)
     cac:	faf77ce3          	bgeu	a4,a5,c64 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     cb0:	fe043783          	ld	a5,-32(s0)
     cb4:	479c                	lw	a5,8(a5)
     cb6:	1782                	slli	a5,a5,0x20
     cb8:	9381                	srli	a5,a5,0x20
     cba:	0792                	slli	a5,a5,0x4
     cbc:	fe043703          	ld	a4,-32(s0)
     cc0:	973e                	add	a4,a4,a5
     cc2:	fe843783          	ld	a5,-24(s0)
     cc6:	639c                	ld	a5,0(a5)
     cc8:	02f71763          	bne	a4,a5,cf6 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     ccc:	fe043783          	ld	a5,-32(s0)
     cd0:	4798                	lw	a4,8(a5)
     cd2:	fe843783          	ld	a5,-24(s0)
     cd6:	639c                	ld	a5,0(a5)
     cd8:	479c                	lw	a5,8(a5)
     cda:	9fb9                	addw	a5,a5,a4
     cdc:	0007871b          	sext.w	a4,a5
     ce0:	fe043783          	ld	a5,-32(s0)
     ce4:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     ce6:	fe843783          	ld	a5,-24(s0)
     cea:	639c                	ld	a5,0(a5)
     cec:	6398                	ld	a4,0(a5)
     cee:	fe043783          	ld	a5,-32(s0)
     cf2:	e398                	sd	a4,0(a5)
     cf4:	a039                	j	d02 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     cf6:	fe843783          	ld	a5,-24(s0)
     cfa:	6398                	ld	a4,0(a5)
     cfc:	fe043783          	ld	a5,-32(s0)
     d00:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     d02:	fe843783          	ld	a5,-24(s0)
     d06:	479c                	lw	a5,8(a5)
     d08:	1782                	slli	a5,a5,0x20
     d0a:	9381                	srli	a5,a5,0x20
     d0c:	0792                	slli	a5,a5,0x4
     d0e:	fe843703          	ld	a4,-24(s0)
     d12:	97ba                	add	a5,a5,a4
     d14:	fe043703          	ld	a4,-32(s0)
     d18:	02f71563          	bne	a4,a5,d42 <free+0x102>
    p->s.size += bp->s.size;
     d1c:	fe843783          	ld	a5,-24(s0)
     d20:	4798                	lw	a4,8(a5)
     d22:	fe043783          	ld	a5,-32(s0)
     d26:	479c                	lw	a5,8(a5)
     d28:	9fb9                	addw	a5,a5,a4
     d2a:	0007871b          	sext.w	a4,a5
     d2e:	fe843783          	ld	a5,-24(s0)
     d32:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     d34:	fe043783          	ld	a5,-32(s0)
     d38:	6398                	ld	a4,0(a5)
     d3a:	fe843783          	ld	a5,-24(s0)
     d3e:	e398                	sd	a4,0(a5)
     d40:	a031                	j	d4c <free+0x10c>
  } else
    p->s.ptr = bp;
     d42:	fe843783          	ld	a5,-24(s0)
     d46:	fe043703          	ld	a4,-32(s0)
     d4a:	e398                	sd	a4,0(a5)
  freep = p;
     d4c:	00000797          	auipc	a5,0x0
     d50:	5ac78793          	addi	a5,a5,1452 # 12f8 <freep>
     d54:	fe843703          	ld	a4,-24(s0)
     d58:	e398                	sd	a4,0(a5)
}
     d5a:	0001                	nop
     d5c:	7422                	ld	s0,40(sp)
     d5e:	6145                	addi	sp,sp,48
     d60:	8082                	ret

0000000000000d62 <morecore>:

static Header*
morecore(uint nu)
{
     d62:	7179                	addi	sp,sp,-48
     d64:	f406                	sd	ra,40(sp)
     d66:	f022                	sd	s0,32(sp)
     d68:	1800                	addi	s0,sp,48
     d6a:	87aa                	mv	a5,a0
     d6c:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     d70:	fdc42783          	lw	a5,-36(s0)
     d74:	0007871b          	sext.w	a4,a5
     d78:	6785                	lui	a5,0x1
     d7a:	00f77563          	bgeu	a4,a5,d84 <morecore+0x22>
    nu = 4096;
     d7e:	6785                	lui	a5,0x1
     d80:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     d84:	fdc42783          	lw	a5,-36(s0)
     d88:	0047979b          	slliw	a5,a5,0x4
     d8c:	2781                	sext.w	a5,a5
     d8e:	2781                	sext.w	a5,a5
     d90:	853e                	mv	a0,a5
     d92:	00000097          	auipc	ra,0x0
     d96:	9ae080e7          	jalr	-1618(ra) # 740 <sbrk>
     d9a:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     d9e:	fe843703          	ld	a4,-24(s0)
     da2:	57fd                	li	a5,-1
     da4:	00f71463          	bne	a4,a5,dac <morecore+0x4a>
    return 0;
     da8:	4781                	li	a5,0
     daa:	a03d                	j	dd8 <morecore+0x76>
  hp = (Header*)p;
     dac:	fe843783          	ld	a5,-24(s0)
     db0:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     db4:	fe043783          	ld	a5,-32(s0)
     db8:	fdc42703          	lw	a4,-36(s0)
     dbc:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     dbe:	fe043783          	ld	a5,-32(s0)
     dc2:	07c1                	addi	a5,a5,16
     dc4:	853e                	mv	a0,a5
     dc6:	00000097          	auipc	ra,0x0
     dca:	e7a080e7          	jalr	-390(ra) # c40 <free>
  return freep;
     dce:	00000797          	auipc	a5,0x0
     dd2:	52a78793          	addi	a5,a5,1322 # 12f8 <freep>
     dd6:	639c                	ld	a5,0(a5)
}
     dd8:	853e                	mv	a0,a5
     dda:	70a2                	ld	ra,40(sp)
     ddc:	7402                	ld	s0,32(sp)
     dde:	6145                	addi	sp,sp,48
     de0:	8082                	ret

0000000000000de2 <malloc>:

void*
malloc(uint nbytes)
{
     de2:	7139                	addi	sp,sp,-64
     de4:	fc06                	sd	ra,56(sp)
     de6:	f822                	sd	s0,48(sp)
     de8:	0080                	addi	s0,sp,64
     dea:	87aa                	mv	a5,a0
     dec:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     df0:	fcc46783          	lwu	a5,-52(s0)
     df4:	07bd                	addi	a5,a5,15
     df6:	8391                	srli	a5,a5,0x4
     df8:	2781                	sext.w	a5,a5
     dfa:	2785                	addiw	a5,a5,1
     dfc:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     e00:	00000797          	auipc	a5,0x0
     e04:	4f878793          	addi	a5,a5,1272 # 12f8 <freep>
     e08:	639c                	ld	a5,0(a5)
     e0a:	fef43023          	sd	a5,-32(s0)
     e0e:	fe043783          	ld	a5,-32(s0)
     e12:	ef95                	bnez	a5,e4e <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     e14:	00000797          	auipc	a5,0x0
     e18:	4d478793          	addi	a5,a5,1236 # 12e8 <base>
     e1c:	fef43023          	sd	a5,-32(s0)
     e20:	00000797          	auipc	a5,0x0
     e24:	4d878793          	addi	a5,a5,1240 # 12f8 <freep>
     e28:	fe043703          	ld	a4,-32(s0)
     e2c:	e398                	sd	a4,0(a5)
     e2e:	00000797          	auipc	a5,0x0
     e32:	4ca78793          	addi	a5,a5,1226 # 12f8 <freep>
     e36:	6398                	ld	a4,0(a5)
     e38:	00000797          	auipc	a5,0x0
     e3c:	4b078793          	addi	a5,a5,1200 # 12e8 <base>
     e40:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     e42:	00000797          	auipc	a5,0x0
     e46:	4a678793          	addi	a5,a5,1190 # 12e8 <base>
     e4a:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e4e:	fe043783          	ld	a5,-32(s0)
     e52:	639c                	ld	a5,0(a5)
     e54:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     e58:	fe843783          	ld	a5,-24(s0)
     e5c:	4798                	lw	a4,8(a5)
     e5e:	fdc42783          	lw	a5,-36(s0)
     e62:	2781                	sext.w	a5,a5
     e64:	06f76763          	bltu	a4,a5,ed2 <malloc+0xf0>
      if(p->s.size == nunits)
     e68:	fe843783          	ld	a5,-24(s0)
     e6c:	4798                	lw	a4,8(a5)
     e6e:	fdc42783          	lw	a5,-36(s0)
     e72:	2781                	sext.w	a5,a5
     e74:	00e79963          	bne	a5,a4,e86 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     e78:	fe843783          	ld	a5,-24(s0)
     e7c:	6398                	ld	a4,0(a5)
     e7e:	fe043783          	ld	a5,-32(s0)
     e82:	e398                	sd	a4,0(a5)
     e84:	a825                	j	ebc <malloc+0xda>
      else {
        p->s.size -= nunits;
     e86:	fe843783          	ld	a5,-24(s0)
     e8a:	479c                	lw	a5,8(a5)
     e8c:	fdc42703          	lw	a4,-36(s0)
     e90:	9f99                	subw	a5,a5,a4
     e92:	0007871b          	sext.w	a4,a5
     e96:	fe843783          	ld	a5,-24(s0)
     e9a:	c798                	sw	a4,8(a5)
        p += p->s.size;
     e9c:	fe843783          	ld	a5,-24(s0)
     ea0:	479c                	lw	a5,8(a5)
     ea2:	1782                	slli	a5,a5,0x20
     ea4:	9381                	srli	a5,a5,0x20
     ea6:	0792                	slli	a5,a5,0x4
     ea8:	fe843703          	ld	a4,-24(s0)
     eac:	97ba                	add	a5,a5,a4
     eae:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     eb2:	fe843783          	ld	a5,-24(s0)
     eb6:	fdc42703          	lw	a4,-36(s0)
     eba:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     ebc:	00000797          	auipc	a5,0x0
     ec0:	43c78793          	addi	a5,a5,1084 # 12f8 <freep>
     ec4:	fe043703          	ld	a4,-32(s0)
     ec8:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     eca:	fe843783          	ld	a5,-24(s0)
     ece:	07c1                	addi	a5,a5,16
     ed0:	a091                	j	f14 <malloc+0x132>
    }
    if(p == freep)
     ed2:	00000797          	auipc	a5,0x0
     ed6:	42678793          	addi	a5,a5,1062 # 12f8 <freep>
     eda:	639c                	ld	a5,0(a5)
     edc:	fe843703          	ld	a4,-24(s0)
     ee0:	02f71063          	bne	a4,a5,f00 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
     ee4:	fdc42783          	lw	a5,-36(s0)
     ee8:	853e                	mv	a0,a5
     eea:	00000097          	auipc	ra,0x0
     eee:	e78080e7          	jalr	-392(ra) # d62 <morecore>
     ef2:	fea43423          	sd	a0,-24(s0)
     ef6:	fe843783          	ld	a5,-24(s0)
     efa:	e399                	bnez	a5,f00 <malloc+0x11e>
        return 0;
     efc:	4781                	li	a5,0
     efe:	a819                	j	f14 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f00:	fe843783          	ld	a5,-24(s0)
     f04:	fef43023          	sd	a5,-32(s0)
     f08:	fe843783          	ld	a5,-24(s0)
     f0c:	639c                	ld	a5,0(a5)
     f0e:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     f12:	b799                	j	e58 <malloc+0x76>
  }
}
     f14:	853e                	mv	a0,a5
     f16:	70e2                	ld	ra,56(sp)
     f18:	7442                	ld	s0,48(sp)
     f1a:	6121                	addi	sp,sp,64
     f1c:	8082                	ret

0000000000000f1e <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
     f1e:	7179                	addi	sp,sp,-48
     f20:	f406                	sd	ra,40(sp)
     f22:	f022                	sd	s0,32(sp)
     f24:	1800                	addi	s0,sp,48
     f26:	fca43c23          	sd	a0,-40(s0)
     f2a:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
     f2e:	6505                	lui	a0,0x1
     f30:	00000097          	auipc	ra,0x0
     f34:	eb2080e7          	jalr	-334(ra) # de2 <malloc>
     f38:	fea43423          	sd	a0,-24(s0)
     f3c:	fe843783          	ld	a5,-24(s0)
     f40:	e38d                	bnez	a5,f62 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
     f42:	00000517          	auipc	a0,0x0
     f46:	13e50513          	addi	a0,a0,318 # 1080 <lock_init+0x66>
     f4a:	00000097          	auipc	ra,0x0
     f4e:	ca6080e7          	jalr	-858(ra) # bf0 <printf>
        free(stack);
     f52:	fe843503          	ld	a0,-24(s0)
     f56:	00000097          	auipc	ra,0x0
     f5a:	cea080e7          	jalr	-790(ra) # c40 <free>
        return -1;
     f5e:	57fd                	li	a5,-1
     f60:	a099                	j	fa6 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
     f62:	fe843783          	ld	a5,-24(s0)
     f66:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
     f6a:	fe043703          	ld	a4,-32(s0)
     f6e:	6785                	lui	a5,0x1
     f70:	17fd                	addi	a5,a5,-1
     f72:	8ff9                	and	a5,a5,a4
     f74:	cf91                	beqz	a5,f90 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
     f76:	fe043703          	ld	a4,-32(s0)
     f7a:	6785                	lui	a5,0x1
     f7c:	17fd                	addi	a5,a5,-1
     f7e:	8ff9                	and	a5,a5,a4
     f80:	6705                	lui	a4,0x1
     f82:	40f707b3          	sub	a5,a4,a5
     f86:	fe843703          	ld	a4,-24(s0)
     f8a:	97ba                	add	a5,a5,a4
     f8c:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
     f90:	fe843603          	ld	a2,-24(s0)
     f94:	fd043583          	ld	a1,-48(s0)
     f98:	fd843503          	ld	a0,-40(s0)
     f9c:	fffff097          	auipc	ra,0xfffff
     fa0:	7bc080e7          	jalr	1980(ra) # 758 <clone>
     fa4:	87aa                	mv	a5,a0
}
     fa6:	853e                	mv	a0,a5
     fa8:	70a2                	ld	ra,40(sp)
     faa:	7402                	ld	s0,32(sp)
     fac:	6145                	addi	sp,sp,48
     fae:	8082                	ret

0000000000000fb0 <thread_join>:


int thread_join()
{
     fb0:	1101                	addi	sp,sp,-32
     fb2:	ec06                	sd	ra,24(sp)
     fb4:	e822                	sd	s0,16(sp)
     fb6:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
     fb8:	fe040793          	addi	a5,s0,-32
     fbc:	853e                	mv	a0,a5
     fbe:	fffff097          	auipc	ra,0xfffff
     fc2:	7a2080e7          	jalr	1954(ra) # 760 <join>
     fc6:	87aa                	mv	a5,a0
     fc8:	fef42623          	sw	a5,-20(s0)
     fcc:	fec42783          	lw	a5,-20(s0)
     fd0:	0007871b          	sext.w	a4,a5
     fd4:	57fd                	li	a5,-1
     fd6:	00f70963          	beq	a4,a5,fe8 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
     fda:	fe043783          	ld	a5,-32(s0)
     fde:	853e                	mv	a0,a5
     fe0:	00000097          	auipc	ra,0x0
     fe4:	c60080e7          	jalr	-928(ra) # c40 <free>
    } 

    return child_tid;
     fe8:	fec42783          	lw	a5,-20(s0)
}
     fec:	853e                	mv	a0,a5
     fee:	60e2                	ld	ra,24(sp)
     ff0:	6442                	ld	s0,16(sp)
     ff2:	6105                	addi	sp,sp,32
     ff4:	8082                	ret

0000000000000ff6 <lock_acquire>:


void lock_acquire (lock_t *)
{
     ff6:	1101                	addi	sp,sp,-32
     ff8:	ec22                	sd	s0,24(sp)
     ffa:	1000                	addi	s0,sp,32
     ffc:	fea43423          	sd	a0,-24(s0)

}
    1000:	0001                	nop
    1002:	6462                	ld	s0,24(sp)
    1004:	6105                	addi	sp,sp,32
    1006:	8082                	ret

0000000000001008 <lock_release>:

void lock_release (lock_t *)
{
    1008:	1101                	addi	sp,sp,-32
    100a:	ec22                	sd	s0,24(sp)
    100c:	1000                	addi	s0,sp,32
    100e:	fea43423          	sd	a0,-24(s0)
    
}
    1012:	0001                	nop
    1014:	6462                	ld	s0,24(sp)
    1016:	6105                	addi	sp,sp,32
    1018:	8082                	ret

000000000000101a <lock_init>:

void lock_init (lock_t *)
{
    101a:	1101                	addi	sp,sp,-32
    101c:	ec22                	sd	s0,24(sp)
    101e:	1000                	addi	s0,sp,32
    1020:	fea43423          	sd	a0,-24(s0)
    
}
    1024:	0001                	nop
    1026:	6462                	ld	s0,24(sp)
    1028:	6105                	addi	sp,sp,32
    102a:	8082                	ret
