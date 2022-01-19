
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
      1a:	0e258593          	addi	a1,a1,226 # 10f8 <buf>
      1e:	4505                	li	a0,1
      20:	00000097          	auipc	ra,0x0
      24:	612080e7          	jalr	1554(ra) # 632 <write>
      28:	87aa                	mv	a5,a0
      2a:	873e                	mv	a4,a5
      2c:	fec42783          	lw	a5,-20(s0)
      30:	2781                	sext.w	a5,a5
      32:	02e78063          	beq	a5,a4,52 <cat+0x52>
      fprintf(2, "cat: write error\n");
      36:	00001597          	auipc	a1,0x1
      3a:	00a58593          	addi	a1,a1,10 # 1040 <cv_init+0x18>
      3e:	4509                	li	a0,2
      40:	00001097          	auipc	ra,0x1
      44:	ab2080e7          	jalr	-1358(ra) # af2 <fprintf>
      exit(1);
      48:	4505                	li	a0,1
      4a:	00000097          	auipc	ra,0x0
      4e:	5c8080e7          	jalr	1480(ra) # 612 <exit>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
      52:	fdc42783          	lw	a5,-36(s0)
      56:	20000613          	li	a2,512
      5a:	00001597          	auipc	a1,0x1
      5e:	09e58593          	addi	a1,a1,158 # 10f8 <buf>
      62:	853e                	mv	a0,a5
      64:	00000097          	auipc	ra,0x0
      68:	5c6080e7          	jalr	1478(ra) # 62a <read>
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
      8a:	fd258593          	addi	a1,a1,-46 # 1058 <cv_init+0x30>
      8e:	4509                	li	a0,2
      90:	00001097          	auipc	ra,0x1
      94:	a62080e7          	jalr	-1438(ra) # af2 <fprintf>
    exit(1);
      98:	4505                	li	a0,1
      9a:	00000097          	auipc	ra,0x0
      9e:	578080e7          	jalr	1400(ra) # 612 <exit>
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
      dc:	53a080e7          	jalr	1338(ra) # 612 <exit>
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
      fe:	558080e7          	jalr	1368(ra) # 652 <open>
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
     126:	f4e58593          	addi	a1,a1,-178 # 1070 <cv_init+0x48>
     12a:	4509                	li	a0,2
     12c:	00001097          	auipc	ra,0x1
     130:	9c6080e7          	jalr	-1594(ra) # af2 <fprintf>
      exit(1);
     134:	4505                	li	a0,1
     136:	00000097          	auipc	ra,0x0
     13a:	4dc080e7          	jalr	1244(ra) # 612 <exit>
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
     156:	4e8080e7          	jalr	1256(ra) # 63a <close>
  for(i = 1; i < argc; i++){
     15a:	fec42783          	lw	a5,-20(s0)
     15e:	2785                	addiw	a5,a5,1
     160:	fef42623          	sw	a5,-20(s0)
     164:	fec42783          	lw	a5,-20(s0)
     168:	873e                	mv	a4,a5
     16a:	fdc42783          	lw	a5,-36(s0)
     16e:	2701                	sext.w	a4,a4
     170:	2781                	sext.w	a5,a5
     172:	f6f74be3          	blt	a4,a5,e8 <main+0x3c>
  }
  exit(0);
     176:	4501                	li	a0,0
     178:	00000097          	auipc	ra,0x0
     17c:	49a080e7          	jalr	1178(ra) # 612 <exit>

0000000000000180 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     180:	7179                	addi	sp,sp,-48
     182:	f422                	sd	s0,40(sp)
     184:	1800                	addi	s0,sp,48
     186:	fca43c23          	sd	a0,-40(s0)
     18a:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     18e:	fd843783          	ld	a5,-40(s0)
     192:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     196:	0001                	nop
     198:	fd043703          	ld	a4,-48(s0)
     19c:	00170793          	addi	a5,a4,1
     1a0:	fcf43823          	sd	a5,-48(s0)
     1a4:	fd843783          	ld	a5,-40(s0)
     1a8:	00178693          	addi	a3,a5,1
     1ac:	fcd43c23          	sd	a3,-40(s0)
     1b0:	00074703          	lbu	a4,0(a4)
     1b4:	00e78023          	sb	a4,0(a5)
     1b8:	0007c783          	lbu	a5,0(a5)
     1bc:	fff1                	bnez	a5,198 <strcpy+0x18>
    ;
  return os;
     1be:	fe843783          	ld	a5,-24(s0)
}
     1c2:	853e                	mv	a0,a5
     1c4:	7422                	ld	s0,40(sp)
     1c6:	6145                	addi	sp,sp,48
     1c8:	8082                	ret

00000000000001ca <strcmp>:

int
strcmp(const char *p, const char *q)
{
     1ca:	1101                	addi	sp,sp,-32
     1cc:	ec22                	sd	s0,24(sp)
     1ce:	1000                	addi	s0,sp,32
     1d0:	fea43423          	sd	a0,-24(s0)
     1d4:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     1d8:	a819                	j	1ee <strcmp+0x24>
    p++, q++;
     1da:	fe843783          	ld	a5,-24(s0)
     1de:	0785                	addi	a5,a5,1
     1e0:	fef43423          	sd	a5,-24(s0)
     1e4:	fe043783          	ld	a5,-32(s0)
     1e8:	0785                	addi	a5,a5,1
     1ea:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     1ee:	fe843783          	ld	a5,-24(s0)
     1f2:	0007c783          	lbu	a5,0(a5)
     1f6:	cb99                	beqz	a5,20c <strcmp+0x42>
     1f8:	fe843783          	ld	a5,-24(s0)
     1fc:	0007c703          	lbu	a4,0(a5)
     200:	fe043783          	ld	a5,-32(s0)
     204:	0007c783          	lbu	a5,0(a5)
     208:	fcf709e3          	beq	a4,a5,1da <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     20c:	fe843783          	ld	a5,-24(s0)
     210:	0007c783          	lbu	a5,0(a5)
     214:	0007871b          	sext.w	a4,a5
     218:	fe043783          	ld	a5,-32(s0)
     21c:	0007c783          	lbu	a5,0(a5)
     220:	2781                	sext.w	a5,a5
     222:	40f707bb          	subw	a5,a4,a5
     226:	2781                	sext.w	a5,a5
}
     228:	853e                	mv	a0,a5
     22a:	6462                	ld	s0,24(sp)
     22c:	6105                	addi	sp,sp,32
     22e:	8082                	ret

0000000000000230 <strlen>:

uint
strlen(const char *s)
{
     230:	7179                	addi	sp,sp,-48
     232:	f422                	sd	s0,40(sp)
     234:	1800                	addi	s0,sp,48
     236:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     23a:	fe042623          	sw	zero,-20(s0)
     23e:	a031                	j	24a <strlen+0x1a>
     240:	fec42783          	lw	a5,-20(s0)
     244:	2785                	addiw	a5,a5,1
     246:	fef42623          	sw	a5,-20(s0)
     24a:	fec42783          	lw	a5,-20(s0)
     24e:	fd843703          	ld	a4,-40(s0)
     252:	97ba                	add	a5,a5,a4
     254:	0007c783          	lbu	a5,0(a5)
     258:	f7e5                	bnez	a5,240 <strlen+0x10>
    ;
  return n;
     25a:	fec42783          	lw	a5,-20(s0)
}
     25e:	853e                	mv	a0,a5
     260:	7422                	ld	s0,40(sp)
     262:	6145                	addi	sp,sp,48
     264:	8082                	ret

0000000000000266 <memset>:

void*
memset(void *dst, int c, uint n)
{
     266:	7179                	addi	sp,sp,-48
     268:	f422                	sd	s0,40(sp)
     26a:	1800                	addi	s0,sp,48
     26c:	fca43c23          	sd	a0,-40(s0)
     270:	87ae                	mv	a5,a1
     272:	8732                	mv	a4,a2
     274:	fcf42a23          	sw	a5,-44(s0)
     278:	87ba                	mv	a5,a4
     27a:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     27e:	fd843783          	ld	a5,-40(s0)
     282:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     286:	fe042623          	sw	zero,-20(s0)
     28a:	a00d                	j	2ac <memset+0x46>
    cdst[i] = c;
     28c:	fec42783          	lw	a5,-20(s0)
     290:	fe043703          	ld	a4,-32(s0)
     294:	97ba                	add	a5,a5,a4
     296:	fd442703          	lw	a4,-44(s0)
     29a:	0ff77713          	zext.b	a4,a4
     29e:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     2a2:	fec42783          	lw	a5,-20(s0)
     2a6:	2785                	addiw	a5,a5,1
     2a8:	fef42623          	sw	a5,-20(s0)
     2ac:	fec42703          	lw	a4,-20(s0)
     2b0:	fd042783          	lw	a5,-48(s0)
     2b4:	2781                	sext.w	a5,a5
     2b6:	fcf76be3          	bltu	a4,a5,28c <memset+0x26>
  }
  return dst;
     2ba:	fd843783          	ld	a5,-40(s0)
}
     2be:	853e                	mv	a0,a5
     2c0:	7422                	ld	s0,40(sp)
     2c2:	6145                	addi	sp,sp,48
     2c4:	8082                	ret

00000000000002c6 <strchr>:

char*
strchr(const char *s, char c)
{
     2c6:	1101                	addi	sp,sp,-32
     2c8:	ec22                	sd	s0,24(sp)
     2ca:	1000                	addi	s0,sp,32
     2cc:	fea43423          	sd	a0,-24(s0)
     2d0:	87ae                	mv	a5,a1
     2d2:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     2d6:	a01d                	j	2fc <strchr+0x36>
    if(*s == c)
     2d8:	fe843783          	ld	a5,-24(s0)
     2dc:	0007c703          	lbu	a4,0(a5)
     2e0:	fe744783          	lbu	a5,-25(s0)
     2e4:	0ff7f793          	zext.b	a5,a5
     2e8:	00e79563          	bne	a5,a4,2f2 <strchr+0x2c>
      return (char*)s;
     2ec:	fe843783          	ld	a5,-24(s0)
     2f0:	a821                	j	308 <strchr+0x42>
  for(; *s; s++)
     2f2:	fe843783          	ld	a5,-24(s0)
     2f6:	0785                	addi	a5,a5,1
     2f8:	fef43423          	sd	a5,-24(s0)
     2fc:	fe843783          	ld	a5,-24(s0)
     300:	0007c783          	lbu	a5,0(a5)
     304:	fbf1                	bnez	a5,2d8 <strchr+0x12>
  return 0;
     306:	4781                	li	a5,0
}
     308:	853e                	mv	a0,a5
     30a:	6462                	ld	s0,24(sp)
     30c:	6105                	addi	sp,sp,32
     30e:	8082                	ret

0000000000000310 <gets>:

char*
gets(char *buf, int max)
{
     310:	7179                	addi	sp,sp,-48
     312:	f406                	sd	ra,40(sp)
     314:	f022                	sd	s0,32(sp)
     316:	1800                	addi	s0,sp,48
     318:	fca43c23          	sd	a0,-40(s0)
     31c:	87ae                	mv	a5,a1
     31e:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     322:	fe042623          	sw	zero,-20(s0)
     326:	a8a1                	j	37e <gets+0x6e>
    cc = read(0, &c, 1);
     328:	fe740793          	addi	a5,s0,-25
     32c:	4605                	li	a2,1
     32e:	85be                	mv	a1,a5
     330:	4501                	li	a0,0
     332:	00000097          	auipc	ra,0x0
     336:	2f8080e7          	jalr	760(ra) # 62a <read>
     33a:	87aa                	mv	a5,a0
     33c:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     340:	fe842783          	lw	a5,-24(s0)
     344:	2781                	sext.w	a5,a5
     346:	04f05763          	blez	a5,394 <gets+0x84>
      break;
    buf[i++] = c;
     34a:	fec42783          	lw	a5,-20(s0)
     34e:	0017871b          	addiw	a4,a5,1
     352:	fee42623          	sw	a4,-20(s0)
     356:	873e                	mv	a4,a5
     358:	fd843783          	ld	a5,-40(s0)
     35c:	97ba                	add	a5,a5,a4
     35e:	fe744703          	lbu	a4,-25(s0)
     362:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     366:	fe744783          	lbu	a5,-25(s0)
     36a:	873e                	mv	a4,a5
     36c:	47a9                	li	a5,10
     36e:	02f70463          	beq	a4,a5,396 <gets+0x86>
     372:	fe744783          	lbu	a5,-25(s0)
     376:	873e                	mv	a4,a5
     378:	47b5                	li	a5,13
     37a:	00f70e63          	beq	a4,a5,396 <gets+0x86>
  for(i=0; i+1 < max; ){
     37e:	fec42783          	lw	a5,-20(s0)
     382:	2785                	addiw	a5,a5,1
     384:	0007871b          	sext.w	a4,a5
     388:	fd442783          	lw	a5,-44(s0)
     38c:	2781                	sext.w	a5,a5
     38e:	f8f74de3          	blt	a4,a5,328 <gets+0x18>
     392:	a011                	j	396 <gets+0x86>
      break;
     394:	0001                	nop
      break;
  }
  buf[i] = '\0';
     396:	fec42783          	lw	a5,-20(s0)
     39a:	fd843703          	ld	a4,-40(s0)
     39e:	97ba                	add	a5,a5,a4
     3a0:	00078023          	sb	zero,0(a5)
  return buf;
     3a4:	fd843783          	ld	a5,-40(s0)
}
     3a8:	853e                	mv	a0,a5
     3aa:	70a2                	ld	ra,40(sp)
     3ac:	7402                	ld	s0,32(sp)
     3ae:	6145                	addi	sp,sp,48
     3b0:	8082                	ret

00000000000003b2 <stat>:

int
stat(const char *n, struct stat *st)
{
     3b2:	7179                	addi	sp,sp,-48
     3b4:	f406                	sd	ra,40(sp)
     3b6:	f022                	sd	s0,32(sp)
     3b8:	1800                	addi	s0,sp,48
     3ba:	fca43c23          	sd	a0,-40(s0)
     3be:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3c2:	4581                	li	a1,0
     3c4:	fd843503          	ld	a0,-40(s0)
     3c8:	00000097          	auipc	ra,0x0
     3cc:	28a080e7          	jalr	650(ra) # 652 <open>
     3d0:	87aa                	mv	a5,a0
     3d2:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     3d6:	fec42783          	lw	a5,-20(s0)
     3da:	2781                	sext.w	a5,a5
     3dc:	0007d463          	bgez	a5,3e4 <stat+0x32>
    return -1;
     3e0:	57fd                	li	a5,-1
     3e2:	a035                	j	40e <stat+0x5c>
  r = fstat(fd, st);
     3e4:	fec42783          	lw	a5,-20(s0)
     3e8:	fd043583          	ld	a1,-48(s0)
     3ec:	853e                	mv	a0,a5
     3ee:	00000097          	auipc	ra,0x0
     3f2:	27c080e7          	jalr	636(ra) # 66a <fstat>
     3f6:	87aa                	mv	a5,a0
     3f8:	fef42423          	sw	a5,-24(s0)
  close(fd);
     3fc:	fec42783          	lw	a5,-20(s0)
     400:	853e                	mv	a0,a5
     402:	00000097          	auipc	ra,0x0
     406:	238080e7          	jalr	568(ra) # 63a <close>
  return r;
     40a:	fe842783          	lw	a5,-24(s0)
}
     40e:	853e                	mv	a0,a5
     410:	70a2                	ld	ra,40(sp)
     412:	7402                	ld	s0,32(sp)
     414:	6145                	addi	sp,sp,48
     416:	8082                	ret

0000000000000418 <atoi>:

int
atoi(const char *s)
{
     418:	7179                	addi	sp,sp,-48
     41a:	f422                	sd	s0,40(sp)
     41c:	1800                	addi	s0,sp,48
     41e:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     422:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     426:	a81d                	j	45c <atoi+0x44>
    n = n*10 + *s++ - '0';
     428:	fec42783          	lw	a5,-20(s0)
     42c:	873e                	mv	a4,a5
     42e:	87ba                	mv	a5,a4
     430:	0027979b          	slliw	a5,a5,0x2
     434:	9fb9                	addw	a5,a5,a4
     436:	0017979b          	slliw	a5,a5,0x1
     43a:	0007871b          	sext.w	a4,a5
     43e:	fd843783          	ld	a5,-40(s0)
     442:	00178693          	addi	a3,a5,1
     446:	fcd43c23          	sd	a3,-40(s0)
     44a:	0007c783          	lbu	a5,0(a5)
     44e:	2781                	sext.w	a5,a5
     450:	9fb9                	addw	a5,a5,a4
     452:	2781                	sext.w	a5,a5
     454:	fd07879b          	addiw	a5,a5,-48
     458:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     45c:	fd843783          	ld	a5,-40(s0)
     460:	0007c783          	lbu	a5,0(a5)
     464:	873e                	mv	a4,a5
     466:	02f00793          	li	a5,47
     46a:	00e7fb63          	bgeu	a5,a4,480 <atoi+0x68>
     46e:	fd843783          	ld	a5,-40(s0)
     472:	0007c783          	lbu	a5,0(a5)
     476:	873e                	mv	a4,a5
     478:	03900793          	li	a5,57
     47c:	fae7f6e3          	bgeu	a5,a4,428 <atoi+0x10>
  return n;
     480:	fec42783          	lw	a5,-20(s0)
}
     484:	853e                	mv	a0,a5
     486:	7422                	ld	s0,40(sp)
     488:	6145                	addi	sp,sp,48
     48a:	8082                	ret

000000000000048c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     48c:	7139                	addi	sp,sp,-64
     48e:	fc22                	sd	s0,56(sp)
     490:	0080                	addi	s0,sp,64
     492:	fca43c23          	sd	a0,-40(s0)
     496:	fcb43823          	sd	a1,-48(s0)
     49a:	87b2                	mv	a5,a2
     49c:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     4a0:	fd843783          	ld	a5,-40(s0)
     4a4:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     4a8:	fd043783          	ld	a5,-48(s0)
     4ac:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     4b0:	fe043703          	ld	a4,-32(s0)
     4b4:	fe843783          	ld	a5,-24(s0)
     4b8:	02e7fc63          	bgeu	a5,a4,4f0 <memmove+0x64>
    while(n-- > 0)
     4bc:	a00d                	j	4de <memmove+0x52>
      *dst++ = *src++;
     4be:	fe043703          	ld	a4,-32(s0)
     4c2:	00170793          	addi	a5,a4,1
     4c6:	fef43023          	sd	a5,-32(s0)
     4ca:	fe843783          	ld	a5,-24(s0)
     4ce:	00178693          	addi	a3,a5,1
     4d2:	fed43423          	sd	a3,-24(s0)
     4d6:	00074703          	lbu	a4,0(a4)
     4da:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     4de:	fcc42783          	lw	a5,-52(s0)
     4e2:	fff7871b          	addiw	a4,a5,-1
     4e6:	fce42623          	sw	a4,-52(s0)
     4ea:	fcf04ae3          	bgtz	a5,4be <memmove+0x32>
     4ee:	a891                	j	542 <memmove+0xb6>
  } else {
    dst += n;
     4f0:	fcc42783          	lw	a5,-52(s0)
     4f4:	fe843703          	ld	a4,-24(s0)
     4f8:	97ba                	add	a5,a5,a4
     4fa:	fef43423          	sd	a5,-24(s0)
    src += n;
     4fe:	fcc42783          	lw	a5,-52(s0)
     502:	fe043703          	ld	a4,-32(s0)
     506:	97ba                	add	a5,a5,a4
     508:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     50c:	a01d                	j	532 <memmove+0xa6>
      *--dst = *--src;
     50e:	fe043783          	ld	a5,-32(s0)
     512:	17fd                	addi	a5,a5,-1
     514:	fef43023          	sd	a5,-32(s0)
     518:	fe843783          	ld	a5,-24(s0)
     51c:	17fd                	addi	a5,a5,-1
     51e:	fef43423          	sd	a5,-24(s0)
     522:	fe043783          	ld	a5,-32(s0)
     526:	0007c703          	lbu	a4,0(a5)
     52a:	fe843783          	ld	a5,-24(s0)
     52e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     532:	fcc42783          	lw	a5,-52(s0)
     536:	fff7871b          	addiw	a4,a5,-1
     53a:	fce42623          	sw	a4,-52(s0)
     53e:	fcf048e3          	bgtz	a5,50e <memmove+0x82>
  }
  return vdst;
     542:	fd843783          	ld	a5,-40(s0)
}
     546:	853e                	mv	a0,a5
     548:	7462                	ld	s0,56(sp)
     54a:	6121                	addi	sp,sp,64
     54c:	8082                	ret

000000000000054e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     54e:	7139                	addi	sp,sp,-64
     550:	fc22                	sd	s0,56(sp)
     552:	0080                	addi	s0,sp,64
     554:	fca43c23          	sd	a0,-40(s0)
     558:	fcb43823          	sd	a1,-48(s0)
     55c:	87b2                	mv	a5,a2
     55e:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     562:	fd843783          	ld	a5,-40(s0)
     566:	fef43423          	sd	a5,-24(s0)
     56a:	fd043783          	ld	a5,-48(s0)
     56e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     572:	a0a1                	j	5ba <memcmp+0x6c>
    if (*p1 != *p2) {
     574:	fe843783          	ld	a5,-24(s0)
     578:	0007c703          	lbu	a4,0(a5)
     57c:	fe043783          	ld	a5,-32(s0)
     580:	0007c783          	lbu	a5,0(a5)
     584:	02f70163          	beq	a4,a5,5a6 <memcmp+0x58>
      return *p1 - *p2;
     588:	fe843783          	ld	a5,-24(s0)
     58c:	0007c783          	lbu	a5,0(a5)
     590:	0007871b          	sext.w	a4,a5
     594:	fe043783          	ld	a5,-32(s0)
     598:	0007c783          	lbu	a5,0(a5)
     59c:	2781                	sext.w	a5,a5
     59e:	40f707bb          	subw	a5,a4,a5
     5a2:	2781                	sext.w	a5,a5
     5a4:	a01d                	j	5ca <memcmp+0x7c>
    }
    p1++;
     5a6:	fe843783          	ld	a5,-24(s0)
     5aa:	0785                	addi	a5,a5,1
     5ac:	fef43423          	sd	a5,-24(s0)
    p2++;
     5b0:	fe043783          	ld	a5,-32(s0)
     5b4:	0785                	addi	a5,a5,1
     5b6:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     5ba:	fcc42783          	lw	a5,-52(s0)
     5be:	fff7871b          	addiw	a4,a5,-1
     5c2:	fce42623          	sw	a4,-52(s0)
     5c6:	f7dd                	bnez	a5,574 <memcmp+0x26>
  }
  return 0;
     5c8:	4781                	li	a5,0
}
     5ca:	853e                	mv	a0,a5
     5cc:	7462                	ld	s0,56(sp)
     5ce:	6121                	addi	sp,sp,64
     5d0:	8082                	ret

00000000000005d2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     5d2:	7179                	addi	sp,sp,-48
     5d4:	f406                	sd	ra,40(sp)
     5d6:	f022                	sd	s0,32(sp)
     5d8:	1800                	addi	s0,sp,48
     5da:	fea43423          	sd	a0,-24(s0)
     5de:	feb43023          	sd	a1,-32(s0)
     5e2:	87b2                	mv	a5,a2
     5e4:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     5e8:	fdc42783          	lw	a5,-36(s0)
     5ec:	863e                	mv	a2,a5
     5ee:	fe043583          	ld	a1,-32(s0)
     5f2:	fe843503          	ld	a0,-24(s0)
     5f6:	00000097          	auipc	ra,0x0
     5fa:	e96080e7          	jalr	-362(ra) # 48c <memmove>
     5fe:	87aa                	mv	a5,a0
}
     600:	853e                	mv	a0,a5
     602:	70a2                	ld	ra,40(sp)
     604:	7402                	ld	s0,32(sp)
     606:	6145                	addi	sp,sp,48
     608:	8082                	ret

000000000000060a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     60a:	4885                	li	a7,1
 ecall
     60c:	00000073          	ecall
 ret
     610:	8082                	ret

0000000000000612 <exit>:
.global exit
exit:
 li a7, SYS_exit
     612:	4889                	li	a7,2
 ecall
     614:	00000073          	ecall
 ret
     618:	8082                	ret

000000000000061a <wait>:
.global wait
wait:
 li a7, SYS_wait
     61a:	488d                	li	a7,3
 ecall
     61c:	00000073          	ecall
 ret
     620:	8082                	ret

0000000000000622 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     622:	4891                	li	a7,4
 ecall
     624:	00000073          	ecall
 ret
     628:	8082                	ret

000000000000062a <read>:
.global read
read:
 li a7, SYS_read
     62a:	4895                	li	a7,5
 ecall
     62c:	00000073          	ecall
 ret
     630:	8082                	ret

0000000000000632 <write>:
.global write
write:
 li a7, SYS_write
     632:	48c1                	li	a7,16
 ecall
     634:	00000073          	ecall
 ret
     638:	8082                	ret

000000000000063a <close>:
.global close
close:
 li a7, SYS_close
     63a:	48d5                	li	a7,21
 ecall
     63c:	00000073          	ecall
 ret
     640:	8082                	ret

0000000000000642 <kill>:
.global kill
kill:
 li a7, SYS_kill
     642:	4899                	li	a7,6
 ecall
     644:	00000073          	ecall
 ret
     648:	8082                	ret

000000000000064a <exec>:
.global exec
exec:
 li a7, SYS_exec
     64a:	489d                	li	a7,7
 ecall
     64c:	00000073          	ecall
 ret
     650:	8082                	ret

0000000000000652 <open>:
.global open
open:
 li a7, SYS_open
     652:	48bd                	li	a7,15
 ecall
     654:	00000073          	ecall
 ret
     658:	8082                	ret

000000000000065a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     65a:	48c5                	li	a7,17
 ecall
     65c:	00000073          	ecall
 ret
     660:	8082                	ret

0000000000000662 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     662:	48c9                	li	a7,18
 ecall
     664:	00000073          	ecall
 ret
     668:	8082                	ret

000000000000066a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     66a:	48a1                	li	a7,8
 ecall
     66c:	00000073          	ecall
 ret
     670:	8082                	ret

0000000000000672 <link>:
.global link
link:
 li a7, SYS_link
     672:	48cd                	li	a7,19
 ecall
     674:	00000073          	ecall
 ret
     678:	8082                	ret

000000000000067a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     67a:	48d1                	li	a7,20
 ecall
     67c:	00000073          	ecall
 ret
     680:	8082                	ret

0000000000000682 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     682:	48a5                	li	a7,9
 ecall
     684:	00000073          	ecall
 ret
     688:	8082                	ret

000000000000068a <dup>:
.global dup
dup:
 li a7, SYS_dup
     68a:	48a9                	li	a7,10
 ecall
     68c:	00000073          	ecall
 ret
     690:	8082                	ret

0000000000000692 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     692:	48ad                	li	a7,11
 ecall
     694:	00000073          	ecall
 ret
     698:	8082                	ret

000000000000069a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     69a:	48b1                	li	a7,12
 ecall
     69c:	00000073          	ecall
 ret
     6a0:	8082                	ret

00000000000006a2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     6a2:	48b5                	li	a7,13
 ecall
     6a4:	00000073          	ecall
 ret
     6a8:	8082                	ret

00000000000006aa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     6aa:	48b9                	li	a7,14
 ecall
     6ac:	00000073          	ecall
 ret
     6b0:	8082                	ret

00000000000006b2 <clone>:
.global clone
clone:
 li a7, SYS_clone
     6b2:	48d9                	li	a7,22
 ecall
     6b4:	00000073          	ecall
 ret
     6b8:	8082                	ret

00000000000006ba <join>:
.global join
join:
 li a7, SYS_join
     6ba:	48dd                	li	a7,23
 ecall
     6bc:	00000073          	ecall
 ret
     6c0:	8082                	ret

00000000000006c2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     6c2:	1101                	addi	sp,sp,-32
     6c4:	ec06                	sd	ra,24(sp)
     6c6:	e822                	sd	s0,16(sp)
     6c8:	1000                	addi	s0,sp,32
     6ca:	87aa                	mv	a5,a0
     6cc:	872e                	mv	a4,a1
     6ce:	fef42623          	sw	a5,-20(s0)
     6d2:	87ba                	mv	a5,a4
     6d4:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     6d8:	feb40713          	addi	a4,s0,-21
     6dc:	fec42783          	lw	a5,-20(s0)
     6e0:	4605                	li	a2,1
     6e2:	85ba                	mv	a1,a4
     6e4:	853e                	mv	a0,a5
     6e6:	00000097          	auipc	ra,0x0
     6ea:	f4c080e7          	jalr	-180(ra) # 632 <write>
}
     6ee:	0001                	nop
     6f0:	60e2                	ld	ra,24(sp)
     6f2:	6442                	ld	s0,16(sp)
     6f4:	6105                	addi	sp,sp,32
     6f6:	8082                	ret

00000000000006f8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     6f8:	7139                	addi	sp,sp,-64
     6fa:	fc06                	sd	ra,56(sp)
     6fc:	f822                	sd	s0,48(sp)
     6fe:	0080                	addi	s0,sp,64
     700:	87aa                	mv	a5,a0
     702:	8736                	mv	a4,a3
     704:	fcf42623          	sw	a5,-52(s0)
     708:	87ae                	mv	a5,a1
     70a:	fcf42423          	sw	a5,-56(s0)
     70e:	87b2                	mv	a5,a2
     710:	fcf42223          	sw	a5,-60(s0)
     714:	87ba                	mv	a5,a4
     716:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     71a:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     71e:	fc042783          	lw	a5,-64(s0)
     722:	2781                	sext.w	a5,a5
     724:	c38d                	beqz	a5,746 <printint+0x4e>
     726:	fc842783          	lw	a5,-56(s0)
     72a:	2781                	sext.w	a5,a5
     72c:	0007dd63          	bgez	a5,746 <printint+0x4e>
    neg = 1;
     730:	4785                	li	a5,1
     732:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     736:	fc842783          	lw	a5,-56(s0)
     73a:	40f007bb          	negw	a5,a5
     73e:	2781                	sext.w	a5,a5
     740:	fef42223          	sw	a5,-28(s0)
     744:	a029                	j	74e <printint+0x56>
  } else {
    x = xx;
     746:	fc842783          	lw	a5,-56(s0)
     74a:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     74e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     752:	fc442783          	lw	a5,-60(s0)
     756:	fe442703          	lw	a4,-28(s0)
     75a:	02f777bb          	remuw	a5,a4,a5
     75e:	0007861b          	sext.w	a2,a5
     762:	fec42783          	lw	a5,-20(s0)
     766:	0017871b          	addiw	a4,a5,1
     76a:	fee42623          	sw	a4,-20(s0)
     76e:	00001697          	auipc	a3,0x1
     772:	97268693          	addi	a3,a3,-1678 # 10e0 <digits>
     776:	02061713          	slli	a4,a2,0x20
     77a:	9301                	srli	a4,a4,0x20
     77c:	9736                	add	a4,a4,a3
     77e:	00074703          	lbu	a4,0(a4)
     782:	17c1                	addi	a5,a5,-16
     784:	97a2                	add	a5,a5,s0
     786:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     78a:	fc442783          	lw	a5,-60(s0)
     78e:	fe442703          	lw	a4,-28(s0)
     792:	02f757bb          	divuw	a5,a4,a5
     796:	fef42223          	sw	a5,-28(s0)
     79a:	fe442783          	lw	a5,-28(s0)
     79e:	2781                	sext.w	a5,a5
     7a0:	fbcd                	bnez	a5,752 <printint+0x5a>
  if(neg)
     7a2:	fe842783          	lw	a5,-24(s0)
     7a6:	2781                	sext.w	a5,a5
     7a8:	cf85                	beqz	a5,7e0 <printint+0xe8>
    buf[i++] = '-';
     7aa:	fec42783          	lw	a5,-20(s0)
     7ae:	0017871b          	addiw	a4,a5,1
     7b2:	fee42623          	sw	a4,-20(s0)
     7b6:	17c1                	addi	a5,a5,-16
     7b8:	97a2                	add	a5,a5,s0
     7ba:	02d00713          	li	a4,45
     7be:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     7c2:	a839                	j	7e0 <printint+0xe8>
    putc(fd, buf[i]);
     7c4:	fec42783          	lw	a5,-20(s0)
     7c8:	17c1                	addi	a5,a5,-16
     7ca:	97a2                	add	a5,a5,s0
     7cc:	fe07c703          	lbu	a4,-32(a5)
     7d0:	fcc42783          	lw	a5,-52(s0)
     7d4:	85ba                	mv	a1,a4
     7d6:	853e                	mv	a0,a5
     7d8:	00000097          	auipc	ra,0x0
     7dc:	eea080e7          	jalr	-278(ra) # 6c2 <putc>
  while(--i >= 0)
     7e0:	fec42783          	lw	a5,-20(s0)
     7e4:	37fd                	addiw	a5,a5,-1
     7e6:	fef42623          	sw	a5,-20(s0)
     7ea:	fec42783          	lw	a5,-20(s0)
     7ee:	2781                	sext.w	a5,a5
     7f0:	fc07dae3          	bgez	a5,7c4 <printint+0xcc>
}
     7f4:	0001                	nop
     7f6:	0001                	nop
     7f8:	70e2                	ld	ra,56(sp)
     7fa:	7442                	ld	s0,48(sp)
     7fc:	6121                	addi	sp,sp,64
     7fe:	8082                	ret

0000000000000800 <printptr>:

static void
printptr(int fd, uint64 x) {
     800:	7179                	addi	sp,sp,-48
     802:	f406                	sd	ra,40(sp)
     804:	f022                	sd	s0,32(sp)
     806:	1800                	addi	s0,sp,48
     808:	87aa                	mv	a5,a0
     80a:	fcb43823          	sd	a1,-48(s0)
     80e:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     812:	fdc42783          	lw	a5,-36(s0)
     816:	03000593          	li	a1,48
     81a:	853e                	mv	a0,a5
     81c:	00000097          	auipc	ra,0x0
     820:	ea6080e7          	jalr	-346(ra) # 6c2 <putc>
  putc(fd, 'x');
     824:	fdc42783          	lw	a5,-36(s0)
     828:	07800593          	li	a1,120
     82c:	853e                	mv	a0,a5
     82e:	00000097          	auipc	ra,0x0
     832:	e94080e7          	jalr	-364(ra) # 6c2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     836:	fe042623          	sw	zero,-20(s0)
     83a:	a82d                	j	874 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     83c:	fd043783          	ld	a5,-48(s0)
     840:	93f1                	srli	a5,a5,0x3c
     842:	00001717          	auipc	a4,0x1
     846:	89e70713          	addi	a4,a4,-1890 # 10e0 <digits>
     84a:	97ba                	add	a5,a5,a4
     84c:	0007c703          	lbu	a4,0(a5)
     850:	fdc42783          	lw	a5,-36(s0)
     854:	85ba                	mv	a1,a4
     856:	853e                	mv	a0,a5
     858:	00000097          	auipc	ra,0x0
     85c:	e6a080e7          	jalr	-406(ra) # 6c2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     860:	fec42783          	lw	a5,-20(s0)
     864:	2785                	addiw	a5,a5,1
     866:	fef42623          	sw	a5,-20(s0)
     86a:	fd043783          	ld	a5,-48(s0)
     86e:	0792                	slli	a5,a5,0x4
     870:	fcf43823          	sd	a5,-48(s0)
     874:	fec42783          	lw	a5,-20(s0)
     878:	873e                	mv	a4,a5
     87a:	47bd                	li	a5,15
     87c:	fce7f0e3          	bgeu	a5,a4,83c <printptr+0x3c>
}
     880:	0001                	nop
     882:	0001                	nop
     884:	70a2                	ld	ra,40(sp)
     886:	7402                	ld	s0,32(sp)
     888:	6145                	addi	sp,sp,48
     88a:	8082                	ret

000000000000088c <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     88c:	715d                	addi	sp,sp,-80
     88e:	e486                	sd	ra,72(sp)
     890:	e0a2                	sd	s0,64(sp)
     892:	0880                	addi	s0,sp,80
     894:	87aa                	mv	a5,a0
     896:	fcb43023          	sd	a1,-64(s0)
     89a:	fac43c23          	sd	a2,-72(s0)
     89e:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     8a2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     8a6:	fe042223          	sw	zero,-28(s0)
     8aa:	a42d                	j	ad4 <vprintf+0x248>
    c = fmt[i] & 0xff;
     8ac:	fe442783          	lw	a5,-28(s0)
     8b0:	fc043703          	ld	a4,-64(s0)
     8b4:	97ba                	add	a5,a5,a4
     8b6:	0007c783          	lbu	a5,0(a5)
     8ba:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     8be:	fe042783          	lw	a5,-32(s0)
     8c2:	2781                	sext.w	a5,a5
     8c4:	eb9d                	bnez	a5,8fa <vprintf+0x6e>
      if(c == '%'){
     8c6:	fdc42783          	lw	a5,-36(s0)
     8ca:	0007871b          	sext.w	a4,a5
     8ce:	02500793          	li	a5,37
     8d2:	00f71763          	bne	a4,a5,8e0 <vprintf+0x54>
        state = '%';
     8d6:	02500793          	li	a5,37
     8da:	fef42023          	sw	a5,-32(s0)
     8de:	a2f5                	j	aca <vprintf+0x23e>
      } else {
        putc(fd, c);
     8e0:	fdc42783          	lw	a5,-36(s0)
     8e4:	0ff7f713          	zext.b	a4,a5
     8e8:	fcc42783          	lw	a5,-52(s0)
     8ec:	85ba                	mv	a1,a4
     8ee:	853e                	mv	a0,a5
     8f0:	00000097          	auipc	ra,0x0
     8f4:	dd2080e7          	jalr	-558(ra) # 6c2 <putc>
     8f8:	aac9                	j	aca <vprintf+0x23e>
      }
    } else if(state == '%'){
     8fa:	fe042783          	lw	a5,-32(s0)
     8fe:	0007871b          	sext.w	a4,a5
     902:	02500793          	li	a5,37
     906:	1cf71263          	bne	a4,a5,aca <vprintf+0x23e>
      if(c == 'd'){
     90a:	fdc42783          	lw	a5,-36(s0)
     90e:	0007871b          	sext.w	a4,a5
     912:	06400793          	li	a5,100
     916:	02f71463          	bne	a4,a5,93e <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     91a:	fb843783          	ld	a5,-72(s0)
     91e:	00878713          	addi	a4,a5,8
     922:	fae43c23          	sd	a4,-72(s0)
     926:	4398                	lw	a4,0(a5)
     928:	fcc42783          	lw	a5,-52(s0)
     92c:	4685                	li	a3,1
     92e:	4629                	li	a2,10
     930:	85ba                	mv	a1,a4
     932:	853e                	mv	a0,a5
     934:	00000097          	auipc	ra,0x0
     938:	dc4080e7          	jalr	-572(ra) # 6f8 <printint>
     93c:	a269                	j	ac6 <vprintf+0x23a>
      } else if(c == 'l') {
     93e:	fdc42783          	lw	a5,-36(s0)
     942:	0007871b          	sext.w	a4,a5
     946:	06c00793          	li	a5,108
     94a:	02f71663          	bne	a4,a5,976 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     94e:	fb843783          	ld	a5,-72(s0)
     952:	00878713          	addi	a4,a5,8
     956:	fae43c23          	sd	a4,-72(s0)
     95a:	639c                	ld	a5,0(a5)
     95c:	0007871b          	sext.w	a4,a5
     960:	fcc42783          	lw	a5,-52(s0)
     964:	4681                	li	a3,0
     966:	4629                	li	a2,10
     968:	85ba                	mv	a1,a4
     96a:	853e                	mv	a0,a5
     96c:	00000097          	auipc	ra,0x0
     970:	d8c080e7          	jalr	-628(ra) # 6f8 <printint>
     974:	aa89                	j	ac6 <vprintf+0x23a>
      } else if(c == 'x') {
     976:	fdc42783          	lw	a5,-36(s0)
     97a:	0007871b          	sext.w	a4,a5
     97e:	07800793          	li	a5,120
     982:	02f71463          	bne	a4,a5,9aa <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     986:	fb843783          	ld	a5,-72(s0)
     98a:	00878713          	addi	a4,a5,8
     98e:	fae43c23          	sd	a4,-72(s0)
     992:	4398                	lw	a4,0(a5)
     994:	fcc42783          	lw	a5,-52(s0)
     998:	4681                	li	a3,0
     99a:	4641                	li	a2,16
     99c:	85ba                	mv	a1,a4
     99e:	853e                	mv	a0,a5
     9a0:	00000097          	auipc	ra,0x0
     9a4:	d58080e7          	jalr	-680(ra) # 6f8 <printint>
     9a8:	aa39                	j	ac6 <vprintf+0x23a>
      } else if(c == 'p') {
     9aa:	fdc42783          	lw	a5,-36(s0)
     9ae:	0007871b          	sext.w	a4,a5
     9b2:	07000793          	li	a5,112
     9b6:	02f71263          	bne	a4,a5,9da <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     9ba:	fb843783          	ld	a5,-72(s0)
     9be:	00878713          	addi	a4,a5,8
     9c2:	fae43c23          	sd	a4,-72(s0)
     9c6:	6398                	ld	a4,0(a5)
     9c8:	fcc42783          	lw	a5,-52(s0)
     9cc:	85ba                	mv	a1,a4
     9ce:	853e                	mv	a0,a5
     9d0:	00000097          	auipc	ra,0x0
     9d4:	e30080e7          	jalr	-464(ra) # 800 <printptr>
     9d8:	a0fd                	j	ac6 <vprintf+0x23a>
      } else if(c == 's'){
     9da:	fdc42783          	lw	a5,-36(s0)
     9de:	0007871b          	sext.w	a4,a5
     9e2:	07300793          	li	a5,115
     9e6:	04f71c63          	bne	a4,a5,a3e <vprintf+0x1b2>
        s = va_arg(ap, char*);
     9ea:	fb843783          	ld	a5,-72(s0)
     9ee:	00878713          	addi	a4,a5,8
     9f2:	fae43c23          	sd	a4,-72(s0)
     9f6:	639c                	ld	a5,0(a5)
     9f8:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     9fc:	fe843783          	ld	a5,-24(s0)
     a00:	eb8d                	bnez	a5,a32 <vprintf+0x1a6>
          s = "(null)";
     a02:	00000797          	auipc	a5,0x0
     a06:	68678793          	addi	a5,a5,1670 # 1088 <cv_init+0x60>
     a0a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     a0e:	a015                	j	a32 <vprintf+0x1a6>
          putc(fd, *s);
     a10:	fe843783          	ld	a5,-24(s0)
     a14:	0007c703          	lbu	a4,0(a5)
     a18:	fcc42783          	lw	a5,-52(s0)
     a1c:	85ba                	mv	a1,a4
     a1e:	853e                	mv	a0,a5
     a20:	00000097          	auipc	ra,0x0
     a24:	ca2080e7          	jalr	-862(ra) # 6c2 <putc>
          s++;
     a28:	fe843783          	ld	a5,-24(s0)
     a2c:	0785                	addi	a5,a5,1
     a2e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     a32:	fe843783          	ld	a5,-24(s0)
     a36:	0007c783          	lbu	a5,0(a5)
     a3a:	fbf9                	bnez	a5,a10 <vprintf+0x184>
     a3c:	a069                	j	ac6 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     a3e:	fdc42783          	lw	a5,-36(s0)
     a42:	0007871b          	sext.w	a4,a5
     a46:	06300793          	li	a5,99
     a4a:	02f71463          	bne	a4,a5,a72 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     a4e:	fb843783          	ld	a5,-72(s0)
     a52:	00878713          	addi	a4,a5,8
     a56:	fae43c23          	sd	a4,-72(s0)
     a5a:	439c                	lw	a5,0(a5)
     a5c:	0ff7f713          	zext.b	a4,a5
     a60:	fcc42783          	lw	a5,-52(s0)
     a64:	85ba                	mv	a1,a4
     a66:	853e                	mv	a0,a5
     a68:	00000097          	auipc	ra,0x0
     a6c:	c5a080e7          	jalr	-934(ra) # 6c2 <putc>
     a70:	a899                	j	ac6 <vprintf+0x23a>
      } else if(c == '%'){
     a72:	fdc42783          	lw	a5,-36(s0)
     a76:	0007871b          	sext.w	a4,a5
     a7a:	02500793          	li	a5,37
     a7e:	00f71f63          	bne	a4,a5,a9c <vprintf+0x210>
        putc(fd, c);
     a82:	fdc42783          	lw	a5,-36(s0)
     a86:	0ff7f713          	zext.b	a4,a5
     a8a:	fcc42783          	lw	a5,-52(s0)
     a8e:	85ba                	mv	a1,a4
     a90:	853e                	mv	a0,a5
     a92:	00000097          	auipc	ra,0x0
     a96:	c30080e7          	jalr	-976(ra) # 6c2 <putc>
     a9a:	a035                	j	ac6 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     a9c:	fcc42783          	lw	a5,-52(s0)
     aa0:	02500593          	li	a1,37
     aa4:	853e                	mv	a0,a5
     aa6:	00000097          	auipc	ra,0x0
     aaa:	c1c080e7          	jalr	-996(ra) # 6c2 <putc>
        putc(fd, c);
     aae:	fdc42783          	lw	a5,-36(s0)
     ab2:	0ff7f713          	zext.b	a4,a5
     ab6:	fcc42783          	lw	a5,-52(s0)
     aba:	85ba                	mv	a1,a4
     abc:	853e                	mv	a0,a5
     abe:	00000097          	auipc	ra,0x0
     ac2:	c04080e7          	jalr	-1020(ra) # 6c2 <putc>
      }
      state = 0;
     ac6:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     aca:	fe442783          	lw	a5,-28(s0)
     ace:	2785                	addiw	a5,a5,1
     ad0:	fef42223          	sw	a5,-28(s0)
     ad4:	fe442783          	lw	a5,-28(s0)
     ad8:	fc043703          	ld	a4,-64(s0)
     adc:	97ba                	add	a5,a5,a4
     ade:	0007c783          	lbu	a5,0(a5)
     ae2:	dc0795e3          	bnez	a5,8ac <vprintf+0x20>
    }
  }
}
     ae6:	0001                	nop
     ae8:	0001                	nop
     aea:	60a6                	ld	ra,72(sp)
     aec:	6406                	ld	s0,64(sp)
     aee:	6161                	addi	sp,sp,80
     af0:	8082                	ret

0000000000000af2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     af2:	7159                	addi	sp,sp,-112
     af4:	fc06                	sd	ra,56(sp)
     af6:	f822                	sd	s0,48(sp)
     af8:	0080                	addi	s0,sp,64
     afa:	fcb43823          	sd	a1,-48(s0)
     afe:	e010                	sd	a2,0(s0)
     b00:	e414                	sd	a3,8(s0)
     b02:	e818                	sd	a4,16(s0)
     b04:	ec1c                	sd	a5,24(s0)
     b06:	03043023          	sd	a6,32(s0)
     b0a:	03143423          	sd	a7,40(s0)
     b0e:	87aa                	mv	a5,a0
     b10:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     b14:	03040793          	addi	a5,s0,48
     b18:	fcf43423          	sd	a5,-56(s0)
     b1c:	fc843783          	ld	a5,-56(s0)
     b20:	fd078793          	addi	a5,a5,-48
     b24:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     b28:	fe843703          	ld	a4,-24(s0)
     b2c:	fdc42783          	lw	a5,-36(s0)
     b30:	863a                	mv	a2,a4
     b32:	fd043583          	ld	a1,-48(s0)
     b36:	853e                	mv	a0,a5
     b38:	00000097          	auipc	ra,0x0
     b3c:	d54080e7          	jalr	-684(ra) # 88c <vprintf>
}
     b40:	0001                	nop
     b42:	70e2                	ld	ra,56(sp)
     b44:	7442                	ld	s0,48(sp)
     b46:	6165                	addi	sp,sp,112
     b48:	8082                	ret

0000000000000b4a <printf>:

void
printf(const char *fmt, ...)
{
     b4a:	7159                	addi	sp,sp,-112
     b4c:	f406                	sd	ra,40(sp)
     b4e:	f022                	sd	s0,32(sp)
     b50:	1800                	addi	s0,sp,48
     b52:	fca43c23          	sd	a0,-40(s0)
     b56:	e40c                	sd	a1,8(s0)
     b58:	e810                	sd	a2,16(s0)
     b5a:	ec14                	sd	a3,24(s0)
     b5c:	f018                	sd	a4,32(s0)
     b5e:	f41c                	sd	a5,40(s0)
     b60:	03043823          	sd	a6,48(s0)
     b64:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     b68:	04040793          	addi	a5,s0,64
     b6c:	fcf43823          	sd	a5,-48(s0)
     b70:	fd043783          	ld	a5,-48(s0)
     b74:	fc878793          	addi	a5,a5,-56
     b78:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     b7c:	fe843783          	ld	a5,-24(s0)
     b80:	863e                	mv	a2,a5
     b82:	fd843583          	ld	a1,-40(s0)
     b86:	4505                	li	a0,1
     b88:	00000097          	auipc	ra,0x0
     b8c:	d04080e7          	jalr	-764(ra) # 88c <vprintf>
}
     b90:	0001                	nop
     b92:	70a2                	ld	ra,40(sp)
     b94:	7402                	ld	s0,32(sp)
     b96:	6165                	addi	sp,sp,112
     b98:	8082                	ret

0000000000000b9a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     b9a:	7179                	addi	sp,sp,-48
     b9c:	f422                	sd	s0,40(sp)
     b9e:	1800                	addi	s0,sp,48
     ba0:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     ba4:	fd843783          	ld	a5,-40(s0)
     ba8:	17c1                	addi	a5,a5,-16
     baa:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bae:	00000797          	auipc	a5,0x0
     bb2:	75a78793          	addi	a5,a5,1882 # 1308 <freep>
     bb6:	639c                	ld	a5,0(a5)
     bb8:	fef43423          	sd	a5,-24(s0)
     bbc:	a815                	j	bf0 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     bbe:	fe843783          	ld	a5,-24(s0)
     bc2:	639c                	ld	a5,0(a5)
     bc4:	fe843703          	ld	a4,-24(s0)
     bc8:	00f76f63          	bltu	a4,a5,be6 <free+0x4c>
     bcc:	fe043703          	ld	a4,-32(s0)
     bd0:	fe843783          	ld	a5,-24(s0)
     bd4:	02e7eb63          	bltu	a5,a4,c0a <free+0x70>
     bd8:	fe843783          	ld	a5,-24(s0)
     bdc:	639c                	ld	a5,0(a5)
     bde:	fe043703          	ld	a4,-32(s0)
     be2:	02f76463          	bltu	a4,a5,c0a <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     be6:	fe843783          	ld	a5,-24(s0)
     bea:	639c                	ld	a5,0(a5)
     bec:	fef43423          	sd	a5,-24(s0)
     bf0:	fe043703          	ld	a4,-32(s0)
     bf4:	fe843783          	ld	a5,-24(s0)
     bf8:	fce7f3e3          	bgeu	a5,a4,bbe <free+0x24>
     bfc:	fe843783          	ld	a5,-24(s0)
     c00:	639c                	ld	a5,0(a5)
     c02:	fe043703          	ld	a4,-32(s0)
     c06:	faf77ce3          	bgeu	a4,a5,bbe <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     c0a:	fe043783          	ld	a5,-32(s0)
     c0e:	479c                	lw	a5,8(a5)
     c10:	1782                	slli	a5,a5,0x20
     c12:	9381                	srli	a5,a5,0x20
     c14:	0792                	slli	a5,a5,0x4
     c16:	fe043703          	ld	a4,-32(s0)
     c1a:	973e                	add	a4,a4,a5
     c1c:	fe843783          	ld	a5,-24(s0)
     c20:	639c                	ld	a5,0(a5)
     c22:	02f71763          	bne	a4,a5,c50 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     c26:	fe043783          	ld	a5,-32(s0)
     c2a:	4798                	lw	a4,8(a5)
     c2c:	fe843783          	ld	a5,-24(s0)
     c30:	639c                	ld	a5,0(a5)
     c32:	479c                	lw	a5,8(a5)
     c34:	9fb9                	addw	a5,a5,a4
     c36:	0007871b          	sext.w	a4,a5
     c3a:	fe043783          	ld	a5,-32(s0)
     c3e:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     c40:	fe843783          	ld	a5,-24(s0)
     c44:	639c                	ld	a5,0(a5)
     c46:	6398                	ld	a4,0(a5)
     c48:	fe043783          	ld	a5,-32(s0)
     c4c:	e398                	sd	a4,0(a5)
     c4e:	a039                	j	c5c <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     c50:	fe843783          	ld	a5,-24(s0)
     c54:	6398                	ld	a4,0(a5)
     c56:	fe043783          	ld	a5,-32(s0)
     c5a:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     c5c:	fe843783          	ld	a5,-24(s0)
     c60:	479c                	lw	a5,8(a5)
     c62:	1782                	slli	a5,a5,0x20
     c64:	9381                	srli	a5,a5,0x20
     c66:	0792                	slli	a5,a5,0x4
     c68:	fe843703          	ld	a4,-24(s0)
     c6c:	97ba                	add	a5,a5,a4
     c6e:	fe043703          	ld	a4,-32(s0)
     c72:	02f71563          	bne	a4,a5,c9c <free+0x102>
    p->s.size += bp->s.size;
     c76:	fe843783          	ld	a5,-24(s0)
     c7a:	4798                	lw	a4,8(a5)
     c7c:	fe043783          	ld	a5,-32(s0)
     c80:	479c                	lw	a5,8(a5)
     c82:	9fb9                	addw	a5,a5,a4
     c84:	0007871b          	sext.w	a4,a5
     c88:	fe843783          	ld	a5,-24(s0)
     c8c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     c8e:	fe043783          	ld	a5,-32(s0)
     c92:	6398                	ld	a4,0(a5)
     c94:	fe843783          	ld	a5,-24(s0)
     c98:	e398                	sd	a4,0(a5)
     c9a:	a031                	j	ca6 <free+0x10c>
  } else
    p->s.ptr = bp;
     c9c:	fe843783          	ld	a5,-24(s0)
     ca0:	fe043703          	ld	a4,-32(s0)
     ca4:	e398                	sd	a4,0(a5)
  freep = p;
     ca6:	00000797          	auipc	a5,0x0
     caa:	66278793          	addi	a5,a5,1634 # 1308 <freep>
     cae:	fe843703          	ld	a4,-24(s0)
     cb2:	e398                	sd	a4,0(a5)
}
     cb4:	0001                	nop
     cb6:	7422                	ld	s0,40(sp)
     cb8:	6145                	addi	sp,sp,48
     cba:	8082                	ret

0000000000000cbc <morecore>:

static Header*
morecore(uint nu)
{
     cbc:	7179                	addi	sp,sp,-48
     cbe:	f406                	sd	ra,40(sp)
     cc0:	f022                	sd	s0,32(sp)
     cc2:	1800                	addi	s0,sp,48
     cc4:	87aa                	mv	a5,a0
     cc6:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     cca:	fdc42783          	lw	a5,-36(s0)
     cce:	0007871b          	sext.w	a4,a5
     cd2:	6785                	lui	a5,0x1
     cd4:	00f77563          	bgeu	a4,a5,cde <morecore+0x22>
    nu = 4096;
     cd8:	6785                	lui	a5,0x1
     cda:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     cde:	fdc42783          	lw	a5,-36(s0)
     ce2:	0047979b          	slliw	a5,a5,0x4
     ce6:	2781                	sext.w	a5,a5
     ce8:	2781                	sext.w	a5,a5
     cea:	853e                	mv	a0,a5
     cec:	00000097          	auipc	ra,0x0
     cf0:	9ae080e7          	jalr	-1618(ra) # 69a <sbrk>
     cf4:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     cf8:	fe843703          	ld	a4,-24(s0)
     cfc:	57fd                	li	a5,-1
     cfe:	00f71463          	bne	a4,a5,d06 <morecore+0x4a>
    return 0;
     d02:	4781                	li	a5,0
     d04:	a03d                	j	d32 <morecore+0x76>
  hp = (Header*)p;
     d06:	fe843783          	ld	a5,-24(s0)
     d0a:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     d0e:	fe043783          	ld	a5,-32(s0)
     d12:	fdc42703          	lw	a4,-36(s0)
     d16:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     d18:	fe043783          	ld	a5,-32(s0)
     d1c:	07c1                	addi	a5,a5,16
     d1e:	853e                	mv	a0,a5
     d20:	00000097          	auipc	ra,0x0
     d24:	e7a080e7          	jalr	-390(ra) # b9a <free>
  return freep;
     d28:	00000797          	auipc	a5,0x0
     d2c:	5e078793          	addi	a5,a5,1504 # 1308 <freep>
     d30:	639c                	ld	a5,0(a5)
}
     d32:	853e                	mv	a0,a5
     d34:	70a2                	ld	ra,40(sp)
     d36:	7402                	ld	s0,32(sp)
     d38:	6145                	addi	sp,sp,48
     d3a:	8082                	ret

0000000000000d3c <malloc>:

void*
malloc(uint nbytes)
{
     d3c:	7139                	addi	sp,sp,-64
     d3e:	fc06                	sd	ra,56(sp)
     d40:	f822                	sd	s0,48(sp)
     d42:	0080                	addi	s0,sp,64
     d44:	87aa                	mv	a5,a0
     d46:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     d4a:	fcc46783          	lwu	a5,-52(s0)
     d4e:	07bd                	addi	a5,a5,15
     d50:	8391                	srli	a5,a5,0x4
     d52:	2781                	sext.w	a5,a5
     d54:	2785                	addiw	a5,a5,1
     d56:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     d5a:	00000797          	auipc	a5,0x0
     d5e:	5ae78793          	addi	a5,a5,1454 # 1308 <freep>
     d62:	639c                	ld	a5,0(a5)
     d64:	fef43023          	sd	a5,-32(s0)
     d68:	fe043783          	ld	a5,-32(s0)
     d6c:	ef95                	bnez	a5,da8 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     d6e:	00000797          	auipc	a5,0x0
     d72:	58a78793          	addi	a5,a5,1418 # 12f8 <base>
     d76:	fef43023          	sd	a5,-32(s0)
     d7a:	00000797          	auipc	a5,0x0
     d7e:	58e78793          	addi	a5,a5,1422 # 1308 <freep>
     d82:	fe043703          	ld	a4,-32(s0)
     d86:	e398                	sd	a4,0(a5)
     d88:	00000797          	auipc	a5,0x0
     d8c:	58078793          	addi	a5,a5,1408 # 1308 <freep>
     d90:	6398                	ld	a4,0(a5)
     d92:	00000797          	auipc	a5,0x0
     d96:	56678793          	addi	a5,a5,1382 # 12f8 <base>
     d9a:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     d9c:	00000797          	auipc	a5,0x0
     da0:	55c78793          	addi	a5,a5,1372 # 12f8 <base>
     da4:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     da8:	fe043783          	ld	a5,-32(s0)
     dac:	639c                	ld	a5,0(a5)
     dae:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     db2:	fe843783          	ld	a5,-24(s0)
     db6:	4798                	lw	a4,8(a5)
     db8:	fdc42783          	lw	a5,-36(s0)
     dbc:	2781                	sext.w	a5,a5
     dbe:	06f76763          	bltu	a4,a5,e2c <malloc+0xf0>
      if(p->s.size == nunits)
     dc2:	fe843783          	ld	a5,-24(s0)
     dc6:	4798                	lw	a4,8(a5)
     dc8:	fdc42783          	lw	a5,-36(s0)
     dcc:	2781                	sext.w	a5,a5
     dce:	00e79963          	bne	a5,a4,de0 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     dd2:	fe843783          	ld	a5,-24(s0)
     dd6:	6398                	ld	a4,0(a5)
     dd8:	fe043783          	ld	a5,-32(s0)
     ddc:	e398                	sd	a4,0(a5)
     dde:	a825                	j	e16 <malloc+0xda>
      else {
        p->s.size -= nunits;
     de0:	fe843783          	ld	a5,-24(s0)
     de4:	479c                	lw	a5,8(a5)
     de6:	fdc42703          	lw	a4,-36(s0)
     dea:	9f99                	subw	a5,a5,a4
     dec:	0007871b          	sext.w	a4,a5
     df0:	fe843783          	ld	a5,-24(s0)
     df4:	c798                	sw	a4,8(a5)
        p += p->s.size;
     df6:	fe843783          	ld	a5,-24(s0)
     dfa:	479c                	lw	a5,8(a5)
     dfc:	1782                	slli	a5,a5,0x20
     dfe:	9381                	srli	a5,a5,0x20
     e00:	0792                	slli	a5,a5,0x4
     e02:	fe843703          	ld	a4,-24(s0)
     e06:	97ba                	add	a5,a5,a4
     e08:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     e0c:	fe843783          	ld	a5,-24(s0)
     e10:	fdc42703          	lw	a4,-36(s0)
     e14:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     e16:	00000797          	auipc	a5,0x0
     e1a:	4f278793          	addi	a5,a5,1266 # 1308 <freep>
     e1e:	fe043703          	ld	a4,-32(s0)
     e22:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     e24:	fe843783          	ld	a5,-24(s0)
     e28:	07c1                	addi	a5,a5,16
     e2a:	a091                	j	e6e <malloc+0x132>
    }
    if(p == freep)
     e2c:	00000797          	auipc	a5,0x0
     e30:	4dc78793          	addi	a5,a5,1244 # 1308 <freep>
     e34:	639c                	ld	a5,0(a5)
     e36:	fe843703          	ld	a4,-24(s0)
     e3a:	02f71063          	bne	a4,a5,e5a <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
     e3e:	fdc42783          	lw	a5,-36(s0)
     e42:	853e                	mv	a0,a5
     e44:	00000097          	auipc	ra,0x0
     e48:	e78080e7          	jalr	-392(ra) # cbc <morecore>
     e4c:	fea43423          	sd	a0,-24(s0)
     e50:	fe843783          	ld	a5,-24(s0)
     e54:	e399                	bnez	a5,e5a <malloc+0x11e>
        return 0;
     e56:	4781                	li	a5,0
     e58:	a819                	j	e6e <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e5a:	fe843783          	ld	a5,-24(s0)
     e5e:	fef43023          	sd	a5,-32(s0)
     e62:	fe843783          	ld	a5,-24(s0)
     e66:	639c                	ld	a5,0(a5)
     e68:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     e6c:	b799                	j	db2 <malloc+0x76>
  }
}
     e6e:	853e                	mv	a0,a5
     e70:	70e2                	ld	ra,56(sp)
     e72:	7442                	ld	s0,48(sp)
     e74:	6121                	addi	sp,sp,64
     e76:	8082                	ret

0000000000000e78 <thread_create>:
typedef uint cont_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
     e78:	7179                	addi	sp,sp,-48
     e7a:	f406                	sd	ra,40(sp)
     e7c:	f022                	sd	s0,32(sp)
     e7e:	1800                	addi	s0,sp,48
     e80:	fca43c23          	sd	a0,-40(s0)
     e84:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
     e88:	6505                	lui	a0,0x1
     e8a:	00000097          	auipc	ra,0x0
     e8e:	eb2080e7          	jalr	-334(ra) # d3c <malloc>
     e92:	fea43423          	sd	a0,-24(s0)
     e96:	fe843783          	ld	a5,-24(s0)
     e9a:	e38d                	bnez	a5,ebc <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
     e9c:	00000517          	auipc	a0,0x0
     ea0:	1f450513          	addi	a0,a0,500 # 1090 <cv_init+0x68>
     ea4:	00000097          	auipc	ra,0x0
     ea8:	ca6080e7          	jalr	-858(ra) # b4a <printf>
        free(stack);
     eac:	fe843503          	ld	a0,-24(s0)
     eb0:	00000097          	auipc	ra,0x0
     eb4:	cea080e7          	jalr	-790(ra) # b9a <free>
        return -1;
     eb8:	57fd                	li	a5,-1
     eba:	a099                	j	f00 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
     ebc:	fe843783          	ld	a5,-24(s0)
     ec0:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
     ec4:	fe043703          	ld	a4,-32(s0)
     ec8:	6785                	lui	a5,0x1
     eca:	17fd                	addi	a5,a5,-1
     ecc:	8ff9                	and	a5,a5,a4
     ece:	cf91                	beqz	a5,eea <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
     ed0:	fe043703          	ld	a4,-32(s0)
     ed4:	6785                	lui	a5,0x1
     ed6:	17fd                	addi	a5,a5,-1
     ed8:	8ff9                	and	a5,a5,a4
     eda:	6705                	lui	a4,0x1
     edc:	40f707b3          	sub	a5,a4,a5
     ee0:	fe843703          	ld	a4,-24(s0)
     ee4:	97ba                	add	a5,a5,a4
     ee6:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
     eea:	fe843603          	ld	a2,-24(s0)
     eee:	fd043583          	ld	a1,-48(s0)
     ef2:	fd843503          	ld	a0,-40(s0)
     ef6:	fffff097          	auipc	ra,0xfffff
     efa:	7bc080e7          	jalr	1980(ra) # 6b2 <clone>
     efe:	87aa                	mv	a5,a0
}
     f00:	853e                	mv	a0,a5
     f02:	70a2                	ld	ra,40(sp)
     f04:	7402                	ld	s0,32(sp)
     f06:	6145                	addi	sp,sp,48
     f08:	8082                	ret

0000000000000f0a <thread_join>:


int thread_join()
{
     f0a:	1101                	addi	sp,sp,-32
     f0c:	ec06                	sd	ra,24(sp)
     f0e:	e822                	sd	s0,16(sp)
     f10:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
     f12:	fe040793          	addi	a5,s0,-32
     f16:	853e                	mv	a0,a5
     f18:	fffff097          	auipc	ra,0xfffff
     f1c:	7a2080e7          	jalr	1954(ra) # 6ba <join>
     f20:	87aa                	mv	a5,a0
     f22:	fef42623          	sw	a5,-20(s0)
     f26:	fec42783          	lw	a5,-20(s0)
     f2a:	0007871b          	sext.w	a4,a5
     f2e:	57fd                	li	a5,-1
     f30:	00f70963          	beq	a4,a5,f42 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
     f34:	fe043783          	ld	a5,-32(s0)
     f38:	853e                	mv	a0,a5
     f3a:	00000097          	auipc	ra,0x0
     f3e:	c60080e7          	jalr	-928(ra) # b9a <free>
    } 

    return child_tid;
     f42:	fec42783          	lw	a5,-20(s0)
}
     f46:	853e                	mv	a0,a5
     f48:	60e2                	ld	ra,24(sp)
     f4a:	6442                	ld	s0,16(sp)
     f4c:	6105                	addi	sp,sp,32
     f4e:	8082                	ret

0000000000000f50 <lock_acquire>:


void lock_acquire (lock_t *lock){
     f50:	1101                	addi	sp,sp,-32
     f52:	ec22                	sd	s0,24(sp)
     f54:	1000                	addi	s0,sp,32
     f56:	fea43423          	sd	a0,-24(s0)
    while( __sync_lock_test_and_set(lock, 1)!=0){
     f5a:	0001                	nop
     f5c:	fe843783          	ld	a5,-24(s0)
     f60:	4705                	li	a4,1
     f62:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
     f66:	0007079b          	sext.w	a5,a4
     f6a:	fbed                	bnez	a5,f5c <lock_acquire+0xc>

    ;
    }
     __sync_synchronize();
     f6c:	0ff0000f          	fence
        

}
     f70:	0001                	nop
     f72:	6462                	ld	s0,24(sp)
     f74:	6105                	addi	sp,sp,32
     f76:	8082                	ret

0000000000000f78 <lock_release>:

void lock_release (lock_t *lock){
     f78:	1101                	addi	sp,sp,-32
     f7a:	ec22                	sd	s0,24(sp)
     f7c:	1000                	addi	s0,sp,32
     f7e:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
     f82:	0ff0000f          	fence
    __sync_lock_release(lock);
     f86:	fe843783          	ld	a5,-24(s0)
     f8a:	0f50000f          	fence	iorw,ow
     f8e:	0807a02f          	amoswap.w	zero,zero,(a5)
   
}
     f92:	0001                	nop
     f94:	6462                	ld	s0,24(sp)
     f96:	6105                	addi	sp,sp,32
     f98:	8082                	ret

0000000000000f9a <lock_init>:

void lock_init (lock_t *lock){
     f9a:	1101                	addi	sp,sp,-32
     f9c:	ec22                	sd	s0,24(sp)
     f9e:	1000                	addi	s0,sp,32
     fa0:	fea43423          	sd	a0,-24(s0)
    lock = 0;
     fa4:	fe043423          	sd	zero,-24(s0)
    
}
     fa8:	0001                	nop
     faa:	6462                	ld	s0,24(sp)
     fac:	6105                	addi	sp,sp,32
     fae:	8082                	ret

0000000000000fb0 <cv_wait>:


void cv_wait (cont_t *cv, lock_t *lock){
     fb0:	1101                	addi	sp,sp,-32
     fb2:	ec06                	sd	ra,24(sp)
     fb4:	e822                	sd	s0,16(sp)
     fb6:	1000                	addi	s0,sp,32
     fb8:	fea43423          	sd	a0,-24(s0)
     fbc:	feb43023          	sd	a1,-32(s0)
    while( __sync_lock_test_and_set(cv, 0)!=1){
     fc0:	a015                	j	fe4 <cv_wait+0x34>
        lock_release(lock);
     fc2:	fe043503          	ld	a0,-32(s0)
     fc6:	00000097          	auipc	ra,0x0
     fca:	fb2080e7          	jalr	-78(ra) # f78 <lock_release>
        sleep(1);
     fce:	4505                	li	a0,1
     fd0:	fffff097          	auipc	ra,0xfffff
     fd4:	6d2080e7          	jalr	1746(ra) # 6a2 <sleep>
        lock_acquire(lock);
     fd8:	fe043503          	ld	a0,-32(s0)
     fdc:	00000097          	auipc	ra,0x0
     fe0:	f74080e7          	jalr	-140(ra) # f50 <lock_acquire>
    while( __sync_lock_test_and_set(cv, 0)!=1){
     fe4:	fe843783          	ld	a5,-24(s0)
     fe8:	4701                	li	a4,0
     fea:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
     fee:	0007079b          	sext.w	a5,a4
     ff2:	873e                	mv	a4,a5
     ff4:	4785                	li	a5,1
     ff6:	fcf716e3          	bne	a4,a5,fc2 <cv_wait+0x12>
    }

     __sync_synchronize();
     ffa:	0ff0000f          	fence

}
     ffe:	0001                	nop
    1000:	60e2                	ld	ra,24(sp)
    1002:	6442                	ld	s0,16(sp)
    1004:	6105                	addi	sp,sp,32
    1006:	8082                	ret

0000000000001008 <cv_signal>:


void cv_signal (cont_t *cv){
    1008:	1101                	addi	sp,sp,-32
    100a:	ec22                	sd	s0,24(sp)
    100c:	1000                	addi	s0,sp,32
    100e:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
    1012:	0ff0000f          	fence
     __sync_lock_test_and_set(cv, 1);
    1016:	fe843783          	ld	a5,-24(s0)
    101a:	4705                	li	a4,1
    101c:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)

}
    1020:	0001                	nop
    1022:	6462                	ld	s0,24(sp)
    1024:	6105                	addi	sp,sp,32
    1026:	8082                	ret

0000000000001028 <cv_init>:


void cv_init (cont_t *cv){
    1028:	1101                	addi	sp,sp,-32
    102a:	ec22                	sd	s0,24(sp)
    102c:	1000                	addi	s0,sp,32
    102e:	fea43423          	sd	a0,-24(s0)
    cv = 0;
    1032:	fe043423          	sd	zero,-24(s0)
    1036:	0001                	nop
    1038:	6462                	ld	s0,24(sp)
    103a:	6105                	addi	sp,sp,32
    103c:	8082                	ret
