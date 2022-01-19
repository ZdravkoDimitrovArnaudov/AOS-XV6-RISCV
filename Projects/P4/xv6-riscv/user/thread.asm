
user/_thread:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

void worker(void *arg_ptr);

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
   ppid = getpid();
      12:	00000097          	auipc	ra,0x0
      16:	7e6080e7          	jalr	2022(ra) # 7f8 <getpid>
      1a:	87aa                	mv	a5,a0
      1c:	873e                	mv	a4,a5
      1e:	00001797          	auipc	a5,0x1
      22:	2a278793          	addi	a5,a5,674 # 12c0 <ppid>
      26:	c398                	sw	a4,0(a5)

   int arg = 35;
      28:	02300793          	li	a5,35
      2c:	fef42223          	sw	a5,-28(s0)
   int thread_pid = thread_create(worker, &arg);
      30:	fe440793          	addi	a5,s0,-28
      34:	85be                	mv	a1,a5
      36:	00000517          	auipc	a0,0x0
      3a:	19050513          	addi	a0,a0,400 # 1c6 <worker>
      3e:	00001097          	auipc	ra,0x1
      42:	fa0080e7          	jalr	-96(ra) # fde <thread_create>
      46:	87aa                	mv	a5,a0
      48:	fef42623          	sw	a5,-20(s0)
   assert(thread_pid > 0);
      4c:	fec42783          	lw	a5,-20(s0)
      50:	2781                	sext.w	a5,a5
      52:	06f04263          	bgtz	a5,b6 <main+0xb6>
      56:	467d                	li	a2,31
      58:	00001597          	auipc	a1,0x1
      5c:	15058593          	addi	a1,a1,336 # 11a8 <cv_init+0x1a>
      60:	00001517          	auipc	a0,0x1
      64:	15850513          	addi	a0,a0,344 # 11b8 <cv_init+0x2a>
      68:	00001097          	auipc	ra,0x1
      6c:	c48080e7          	jalr	-952(ra) # cb0 <printf>
      70:	00001597          	auipc	a1,0x1
      74:	15058593          	addi	a1,a1,336 # 11c0 <cv_init+0x32>
      78:	00001517          	auipc	a0,0x1
      7c:	15850513          	addi	a0,a0,344 # 11d0 <cv_init+0x42>
      80:	00001097          	auipc	ra,0x1
      84:	c30080e7          	jalr	-976(ra) # cb0 <printf>
      88:	00001517          	auipc	a0,0x1
      8c:	16050513          	addi	a0,a0,352 # 11e8 <cv_init+0x5a>
      90:	00001097          	auipc	ra,0x1
      94:	c20080e7          	jalr	-992(ra) # cb0 <printf>
      98:	00001797          	auipc	a5,0x1
      9c:	22878793          	addi	a5,a5,552 # 12c0 <ppid>
      a0:	439c                	lw	a5,0(a5)
      a2:	853e                	mv	a0,a5
      a4:	00000097          	auipc	ra,0x0
      a8:	704080e7          	jalr	1796(ra) # 7a8 <kill>
      ac:	4501                	li	a0,0
      ae:	00000097          	auipc	ra,0x0
      b2:	6ca080e7          	jalr	1738(ra) # 778 <exit>

   int join_pid = thread_join();
      b6:	00001097          	auipc	ra,0x1
      ba:	fba080e7          	jalr	-70(ra) # 1070 <thread_join>
      be:	87aa                	mv	a5,a0
      c0:	fef42423          	sw	a5,-24(s0)
   assert(join_pid == thread_pid);
      c4:	fe842783          	lw	a5,-24(s0)
      c8:	873e                	mv	a4,a5
      ca:	fec42783          	lw	a5,-20(s0)
      ce:	2701                	sext.w	a4,a4
      d0:	2781                	sext.w	a5,a5
      d2:	06f70363          	beq	a4,a5,138 <main+0x138>
      d6:	02200613          	li	a2,34
      da:	00001597          	auipc	a1,0x1
      de:	0ce58593          	addi	a1,a1,206 # 11a8 <cv_init+0x1a>
      e2:	00001517          	auipc	a0,0x1
      e6:	0d650513          	addi	a0,a0,214 # 11b8 <cv_init+0x2a>
      ea:	00001097          	auipc	ra,0x1
      ee:	bc6080e7          	jalr	-1082(ra) # cb0 <printf>
      f2:	00001597          	auipc	a1,0x1
      f6:	10658593          	addi	a1,a1,262 # 11f8 <cv_init+0x6a>
      fa:	00001517          	auipc	a0,0x1
      fe:	0d650513          	addi	a0,a0,214 # 11d0 <cv_init+0x42>
     102:	00001097          	auipc	ra,0x1
     106:	bae080e7          	jalr	-1106(ra) # cb0 <printf>
     10a:	00001517          	auipc	a0,0x1
     10e:	0de50513          	addi	a0,a0,222 # 11e8 <cv_init+0x5a>
     112:	00001097          	auipc	ra,0x1
     116:	b9e080e7          	jalr	-1122(ra) # cb0 <printf>
     11a:	00001797          	auipc	a5,0x1
     11e:	1a678793          	addi	a5,a5,422 # 12c0 <ppid>
     122:	439c                	lw	a5,0(a5)
     124:	853e                	mv	a0,a5
     126:	00000097          	auipc	ra,0x0
     12a:	682080e7          	jalr	1666(ra) # 7a8 <kill>
     12e:	4501                	li	a0,0
     130:	00000097          	auipc	ra,0x0
     134:	648080e7          	jalr	1608(ra) # 778 <exit>
   assert(global == 2);
     138:	00001797          	auipc	a5,0x1
     13c:	18478793          	addi	a5,a5,388 # 12bc <global>
     140:	439c                	lw	a5,0(a5)
     142:	873e                	mv	a4,a5
     144:	4789                	li	a5,2
     146:	06f70363          	beq	a4,a5,1ac <main+0x1ac>
     14a:	02300613          	li	a2,35
     14e:	00001597          	auipc	a1,0x1
     152:	05a58593          	addi	a1,a1,90 # 11a8 <cv_init+0x1a>
     156:	00001517          	auipc	a0,0x1
     15a:	06250513          	addi	a0,a0,98 # 11b8 <cv_init+0x2a>
     15e:	00001097          	auipc	ra,0x1
     162:	b52080e7          	jalr	-1198(ra) # cb0 <printf>
     166:	00001597          	auipc	a1,0x1
     16a:	0aa58593          	addi	a1,a1,170 # 1210 <cv_init+0x82>
     16e:	00001517          	auipc	a0,0x1
     172:	06250513          	addi	a0,a0,98 # 11d0 <cv_init+0x42>
     176:	00001097          	auipc	ra,0x1
     17a:	b3a080e7          	jalr	-1222(ra) # cb0 <printf>
     17e:	00001517          	auipc	a0,0x1
     182:	06a50513          	addi	a0,a0,106 # 11e8 <cv_init+0x5a>
     186:	00001097          	auipc	ra,0x1
     18a:	b2a080e7          	jalr	-1238(ra) # cb0 <printf>
     18e:	00001797          	auipc	a5,0x1
     192:	13278793          	addi	a5,a5,306 # 12c0 <ppid>
     196:	439c                	lw	a5,0(a5)
     198:	853e                	mv	a0,a5
     19a:	00000097          	auipc	ra,0x0
     19e:	60e080e7          	jalr	1550(ra) # 7a8 <kill>
     1a2:	4501                	li	a0,0
     1a4:	00000097          	auipc	ra,0x0
     1a8:	5d4080e7          	jalr	1492(ra) # 778 <exit>

   printf("TEST PASSED\n");
     1ac:	00001517          	auipc	a0,0x1
     1b0:	07450513          	addi	a0,a0,116 # 1220 <cv_init+0x92>
     1b4:	00001097          	auipc	ra,0x1
     1b8:	afc080e7          	jalr	-1284(ra) # cb0 <printf>
   exit(0);
     1bc:	4501                	li	a0,0
     1be:	00000097          	auipc	ra,0x0
     1c2:	5ba080e7          	jalr	1466(ra) # 778 <exit>

00000000000001c6 <worker>:
}

void
worker(void *arg_ptr) {
     1c6:	7179                	addi	sp,sp,-48
     1c8:	f406                	sd	ra,40(sp)
     1ca:	f022                	sd	s0,32(sp)
     1cc:	1800                	addi	s0,sp,48
     1ce:	fca43c23          	sd	a0,-40(s0)
   int arg = *(int*)arg_ptr;
     1d2:	fd843783          	ld	a5,-40(s0)
     1d6:	439c                	lw	a5,0(a5)
     1d8:	fef42623          	sw	a5,-20(s0)
   assert(arg == 35);
     1dc:	fec42783          	lw	a5,-20(s0)
     1e0:	0007871b          	sext.w	a4,a5
     1e4:	02300793          	li	a5,35
     1e8:	06f70363          	beq	a4,a5,24e <worker+0x88>
     1ec:	02c00613          	li	a2,44
     1f0:	00001597          	auipc	a1,0x1
     1f4:	fb858593          	addi	a1,a1,-72 # 11a8 <cv_init+0x1a>
     1f8:	00001517          	auipc	a0,0x1
     1fc:	fc050513          	addi	a0,a0,-64 # 11b8 <cv_init+0x2a>
     200:	00001097          	auipc	ra,0x1
     204:	ab0080e7          	jalr	-1360(ra) # cb0 <printf>
     208:	00001597          	auipc	a1,0x1
     20c:	02858593          	addi	a1,a1,40 # 1230 <cv_init+0xa2>
     210:	00001517          	auipc	a0,0x1
     214:	fc050513          	addi	a0,a0,-64 # 11d0 <cv_init+0x42>
     218:	00001097          	auipc	ra,0x1
     21c:	a98080e7          	jalr	-1384(ra) # cb0 <printf>
     220:	00001517          	auipc	a0,0x1
     224:	fc850513          	addi	a0,a0,-56 # 11e8 <cv_init+0x5a>
     228:	00001097          	auipc	ra,0x1
     22c:	a88080e7          	jalr	-1400(ra) # cb0 <printf>
     230:	00001797          	auipc	a5,0x1
     234:	09078793          	addi	a5,a5,144 # 12c0 <ppid>
     238:	439c                	lw	a5,0(a5)
     23a:	853e                	mv	a0,a5
     23c:	00000097          	auipc	ra,0x0
     240:	56c080e7          	jalr	1388(ra) # 7a8 <kill>
     244:	4501                	li	a0,0
     246:	00000097          	auipc	ra,0x0
     24a:	532080e7          	jalr	1330(ra) # 778 <exit>
   assert(global == 1);
     24e:	00001797          	auipc	a5,0x1
     252:	06e78793          	addi	a5,a5,110 # 12bc <global>
     256:	439c                	lw	a5,0(a5)
     258:	873e                	mv	a4,a5
     25a:	4785                	li	a5,1
     25c:	06f70363          	beq	a4,a5,2c2 <worker+0xfc>
     260:	02d00613          	li	a2,45
     264:	00001597          	auipc	a1,0x1
     268:	f4458593          	addi	a1,a1,-188 # 11a8 <cv_init+0x1a>
     26c:	00001517          	auipc	a0,0x1
     270:	f4c50513          	addi	a0,a0,-180 # 11b8 <cv_init+0x2a>
     274:	00001097          	auipc	ra,0x1
     278:	a3c080e7          	jalr	-1476(ra) # cb0 <printf>
     27c:	00001597          	auipc	a1,0x1
     280:	fc458593          	addi	a1,a1,-60 # 1240 <cv_init+0xb2>
     284:	00001517          	auipc	a0,0x1
     288:	f4c50513          	addi	a0,a0,-180 # 11d0 <cv_init+0x42>
     28c:	00001097          	auipc	ra,0x1
     290:	a24080e7          	jalr	-1500(ra) # cb0 <printf>
     294:	00001517          	auipc	a0,0x1
     298:	f5450513          	addi	a0,a0,-172 # 11e8 <cv_init+0x5a>
     29c:	00001097          	auipc	ra,0x1
     2a0:	a14080e7          	jalr	-1516(ra) # cb0 <printf>
     2a4:	00001797          	auipc	a5,0x1
     2a8:	01c78793          	addi	a5,a5,28 # 12c0 <ppid>
     2ac:	439c                	lw	a5,0(a5)
     2ae:	853e                	mv	a0,a5
     2b0:	00000097          	auipc	ra,0x0
     2b4:	4f8080e7          	jalr	1272(ra) # 7a8 <kill>
     2b8:	4501                	li	a0,0
     2ba:	00000097          	auipc	ra,0x0
     2be:	4be080e7          	jalr	1214(ra) # 778 <exit>
   global++;
     2c2:	00001797          	auipc	a5,0x1
     2c6:	ffa78793          	addi	a5,a5,-6 # 12bc <global>
     2ca:	439c                	lw	a5,0(a5)
     2cc:	2785                	addiw	a5,a5,1
     2ce:	0007871b          	sext.w	a4,a5
     2d2:	00001797          	auipc	a5,0x1
     2d6:	fea78793          	addi	a5,a5,-22 # 12bc <global>
     2da:	c398                	sw	a4,0(a5)
   exit(0);
     2dc:	4501                	li	a0,0
     2de:	00000097          	auipc	ra,0x0
     2e2:	49a080e7          	jalr	1178(ra) # 778 <exit>

00000000000002e6 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     2e6:	7179                	addi	sp,sp,-48
     2e8:	f422                	sd	s0,40(sp)
     2ea:	1800                	addi	s0,sp,48
     2ec:	fca43c23          	sd	a0,-40(s0)
     2f0:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     2f4:	fd843783          	ld	a5,-40(s0)
     2f8:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     2fc:	0001                	nop
     2fe:	fd043703          	ld	a4,-48(s0)
     302:	00170793          	addi	a5,a4,1
     306:	fcf43823          	sd	a5,-48(s0)
     30a:	fd843783          	ld	a5,-40(s0)
     30e:	00178693          	addi	a3,a5,1
     312:	fcd43c23          	sd	a3,-40(s0)
     316:	00074703          	lbu	a4,0(a4)
     31a:	00e78023          	sb	a4,0(a5)
     31e:	0007c783          	lbu	a5,0(a5)
     322:	fff1                	bnez	a5,2fe <strcpy+0x18>
    ;
  return os;
     324:	fe843783          	ld	a5,-24(s0)
}
     328:	853e                	mv	a0,a5
     32a:	7422                	ld	s0,40(sp)
     32c:	6145                	addi	sp,sp,48
     32e:	8082                	ret

0000000000000330 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     330:	1101                	addi	sp,sp,-32
     332:	ec22                	sd	s0,24(sp)
     334:	1000                	addi	s0,sp,32
     336:	fea43423          	sd	a0,-24(s0)
     33a:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     33e:	a819                	j	354 <strcmp+0x24>
    p++, q++;
     340:	fe843783          	ld	a5,-24(s0)
     344:	0785                	addi	a5,a5,1
     346:	fef43423          	sd	a5,-24(s0)
     34a:	fe043783          	ld	a5,-32(s0)
     34e:	0785                	addi	a5,a5,1
     350:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     354:	fe843783          	ld	a5,-24(s0)
     358:	0007c783          	lbu	a5,0(a5)
     35c:	cb99                	beqz	a5,372 <strcmp+0x42>
     35e:	fe843783          	ld	a5,-24(s0)
     362:	0007c703          	lbu	a4,0(a5)
     366:	fe043783          	ld	a5,-32(s0)
     36a:	0007c783          	lbu	a5,0(a5)
     36e:	fcf709e3          	beq	a4,a5,340 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     372:	fe843783          	ld	a5,-24(s0)
     376:	0007c783          	lbu	a5,0(a5)
     37a:	0007871b          	sext.w	a4,a5
     37e:	fe043783          	ld	a5,-32(s0)
     382:	0007c783          	lbu	a5,0(a5)
     386:	2781                	sext.w	a5,a5
     388:	40f707bb          	subw	a5,a4,a5
     38c:	2781                	sext.w	a5,a5
}
     38e:	853e                	mv	a0,a5
     390:	6462                	ld	s0,24(sp)
     392:	6105                	addi	sp,sp,32
     394:	8082                	ret

0000000000000396 <strlen>:

uint
strlen(const char *s)
{
     396:	7179                	addi	sp,sp,-48
     398:	f422                	sd	s0,40(sp)
     39a:	1800                	addi	s0,sp,48
     39c:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     3a0:	fe042623          	sw	zero,-20(s0)
     3a4:	a031                	j	3b0 <strlen+0x1a>
     3a6:	fec42783          	lw	a5,-20(s0)
     3aa:	2785                	addiw	a5,a5,1
     3ac:	fef42623          	sw	a5,-20(s0)
     3b0:	fec42783          	lw	a5,-20(s0)
     3b4:	fd843703          	ld	a4,-40(s0)
     3b8:	97ba                	add	a5,a5,a4
     3ba:	0007c783          	lbu	a5,0(a5)
     3be:	f7e5                	bnez	a5,3a6 <strlen+0x10>
    ;
  return n;
     3c0:	fec42783          	lw	a5,-20(s0)
}
     3c4:	853e                	mv	a0,a5
     3c6:	7422                	ld	s0,40(sp)
     3c8:	6145                	addi	sp,sp,48
     3ca:	8082                	ret

00000000000003cc <memset>:

void*
memset(void *dst, int c, uint n)
{
     3cc:	7179                	addi	sp,sp,-48
     3ce:	f422                	sd	s0,40(sp)
     3d0:	1800                	addi	s0,sp,48
     3d2:	fca43c23          	sd	a0,-40(s0)
     3d6:	87ae                	mv	a5,a1
     3d8:	8732                	mv	a4,a2
     3da:	fcf42a23          	sw	a5,-44(s0)
     3de:	87ba                	mv	a5,a4
     3e0:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     3e4:	fd843783          	ld	a5,-40(s0)
     3e8:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     3ec:	fe042623          	sw	zero,-20(s0)
     3f0:	a00d                	j	412 <memset+0x46>
    cdst[i] = c;
     3f2:	fec42783          	lw	a5,-20(s0)
     3f6:	fe043703          	ld	a4,-32(s0)
     3fa:	97ba                	add	a5,a5,a4
     3fc:	fd442703          	lw	a4,-44(s0)
     400:	0ff77713          	zext.b	a4,a4
     404:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     408:	fec42783          	lw	a5,-20(s0)
     40c:	2785                	addiw	a5,a5,1
     40e:	fef42623          	sw	a5,-20(s0)
     412:	fec42703          	lw	a4,-20(s0)
     416:	fd042783          	lw	a5,-48(s0)
     41a:	2781                	sext.w	a5,a5
     41c:	fcf76be3          	bltu	a4,a5,3f2 <memset+0x26>
  }
  return dst;
     420:	fd843783          	ld	a5,-40(s0)
}
     424:	853e                	mv	a0,a5
     426:	7422                	ld	s0,40(sp)
     428:	6145                	addi	sp,sp,48
     42a:	8082                	ret

000000000000042c <strchr>:

char*
strchr(const char *s, char c)
{
     42c:	1101                	addi	sp,sp,-32
     42e:	ec22                	sd	s0,24(sp)
     430:	1000                	addi	s0,sp,32
     432:	fea43423          	sd	a0,-24(s0)
     436:	87ae                	mv	a5,a1
     438:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     43c:	a01d                	j	462 <strchr+0x36>
    if(*s == c)
     43e:	fe843783          	ld	a5,-24(s0)
     442:	0007c703          	lbu	a4,0(a5)
     446:	fe744783          	lbu	a5,-25(s0)
     44a:	0ff7f793          	zext.b	a5,a5
     44e:	00e79563          	bne	a5,a4,458 <strchr+0x2c>
      return (char*)s;
     452:	fe843783          	ld	a5,-24(s0)
     456:	a821                	j	46e <strchr+0x42>
  for(; *s; s++)
     458:	fe843783          	ld	a5,-24(s0)
     45c:	0785                	addi	a5,a5,1
     45e:	fef43423          	sd	a5,-24(s0)
     462:	fe843783          	ld	a5,-24(s0)
     466:	0007c783          	lbu	a5,0(a5)
     46a:	fbf1                	bnez	a5,43e <strchr+0x12>
  return 0;
     46c:	4781                	li	a5,0
}
     46e:	853e                	mv	a0,a5
     470:	6462                	ld	s0,24(sp)
     472:	6105                	addi	sp,sp,32
     474:	8082                	ret

0000000000000476 <gets>:

char*
gets(char *buf, int max)
{
     476:	7179                	addi	sp,sp,-48
     478:	f406                	sd	ra,40(sp)
     47a:	f022                	sd	s0,32(sp)
     47c:	1800                	addi	s0,sp,48
     47e:	fca43c23          	sd	a0,-40(s0)
     482:	87ae                	mv	a5,a1
     484:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     488:	fe042623          	sw	zero,-20(s0)
     48c:	a8a1                	j	4e4 <gets+0x6e>
    cc = read(0, &c, 1);
     48e:	fe740793          	addi	a5,s0,-25
     492:	4605                	li	a2,1
     494:	85be                	mv	a1,a5
     496:	4501                	li	a0,0
     498:	00000097          	auipc	ra,0x0
     49c:	2f8080e7          	jalr	760(ra) # 790 <read>
     4a0:	87aa                	mv	a5,a0
     4a2:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     4a6:	fe842783          	lw	a5,-24(s0)
     4aa:	2781                	sext.w	a5,a5
     4ac:	04f05763          	blez	a5,4fa <gets+0x84>
      break;
    buf[i++] = c;
     4b0:	fec42783          	lw	a5,-20(s0)
     4b4:	0017871b          	addiw	a4,a5,1
     4b8:	fee42623          	sw	a4,-20(s0)
     4bc:	873e                	mv	a4,a5
     4be:	fd843783          	ld	a5,-40(s0)
     4c2:	97ba                	add	a5,a5,a4
     4c4:	fe744703          	lbu	a4,-25(s0)
     4c8:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     4cc:	fe744783          	lbu	a5,-25(s0)
     4d0:	873e                	mv	a4,a5
     4d2:	47a9                	li	a5,10
     4d4:	02f70463          	beq	a4,a5,4fc <gets+0x86>
     4d8:	fe744783          	lbu	a5,-25(s0)
     4dc:	873e                	mv	a4,a5
     4de:	47b5                	li	a5,13
     4e0:	00f70e63          	beq	a4,a5,4fc <gets+0x86>
  for(i=0; i+1 < max; ){
     4e4:	fec42783          	lw	a5,-20(s0)
     4e8:	2785                	addiw	a5,a5,1
     4ea:	0007871b          	sext.w	a4,a5
     4ee:	fd442783          	lw	a5,-44(s0)
     4f2:	2781                	sext.w	a5,a5
     4f4:	f8f74de3          	blt	a4,a5,48e <gets+0x18>
     4f8:	a011                	j	4fc <gets+0x86>
      break;
     4fa:	0001                	nop
      break;
  }
  buf[i] = '\0';
     4fc:	fec42783          	lw	a5,-20(s0)
     500:	fd843703          	ld	a4,-40(s0)
     504:	97ba                	add	a5,a5,a4
     506:	00078023          	sb	zero,0(a5)
  return buf;
     50a:	fd843783          	ld	a5,-40(s0)
}
     50e:	853e                	mv	a0,a5
     510:	70a2                	ld	ra,40(sp)
     512:	7402                	ld	s0,32(sp)
     514:	6145                	addi	sp,sp,48
     516:	8082                	ret

0000000000000518 <stat>:

int
stat(const char *n, struct stat *st)
{
     518:	7179                	addi	sp,sp,-48
     51a:	f406                	sd	ra,40(sp)
     51c:	f022                	sd	s0,32(sp)
     51e:	1800                	addi	s0,sp,48
     520:	fca43c23          	sd	a0,-40(s0)
     524:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     528:	4581                	li	a1,0
     52a:	fd843503          	ld	a0,-40(s0)
     52e:	00000097          	auipc	ra,0x0
     532:	28a080e7          	jalr	650(ra) # 7b8 <open>
     536:	87aa                	mv	a5,a0
     538:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     53c:	fec42783          	lw	a5,-20(s0)
     540:	2781                	sext.w	a5,a5
     542:	0007d463          	bgez	a5,54a <stat+0x32>
    return -1;
     546:	57fd                	li	a5,-1
     548:	a035                	j	574 <stat+0x5c>
  r = fstat(fd, st);
     54a:	fec42783          	lw	a5,-20(s0)
     54e:	fd043583          	ld	a1,-48(s0)
     552:	853e                	mv	a0,a5
     554:	00000097          	auipc	ra,0x0
     558:	27c080e7          	jalr	636(ra) # 7d0 <fstat>
     55c:	87aa                	mv	a5,a0
     55e:	fef42423          	sw	a5,-24(s0)
  close(fd);
     562:	fec42783          	lw	a5,-20(s0)
     566:	853e                	mv	a0,a5
     568:	00000097          	auipc	ra,0x0
     56c:	238080e7          	jalr	568(ra) # 7a0 <close>
  return r;
     570:	fe842783          	lw	a5,-24(s0)
}
     574:	853e                	mv	a0,a5
     576:	70a2                	ld	ra,40(sp)
     578:	7402                	ld	s0,32(sp)
     57a:	6145                	addi	sp,sp,48
     57c:	8082                	ret

000000000000057e <atoi>:

int
atoi(const char *s)
{
     57e:	7179                	addi	sp,sp,-48
     580:	f422                	sd	s0,40(sp)
     582:	1800                	addi	s0,sp,48
     584:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     588:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     58c:	a81d                	j	5c2 <atoi+0x44>
    n = n*10 + *s++ - '0';
     58e:	fec42783          	lw	a5,-20(s0)
     592:	873e                	mv	a4,a5
     594:	87ba                	mv	a5,a4
     596:	0027979b          	slliw	a5,a5,0x2
     59a:	9fb9                	addw	a5,a5,a4
     59c:	0017979b          	slliw	a5,a5,0x1
     5a0:	0007871b          	sext.w	a4,a5
     5a4:	fd843783          	ld	a5,-40(s0)
     5a8:	00178693          	addi	a3,a5,1
     5ac:	fcd43c23          	sd	a3,-40(s0)
     5b0:	0007c783          	lbu	a5,0(a5)
     5b4:	2781                	sext.w	a5,a5
     5b6:	9fb9                	addw	a5,a5,a4
     5b8:	2781                	sext.w	a5,a5
     5ba:	fd07879b          	addiw	a5,a5,-48
     5be:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     5c2:	fd843783          	ld	a5,-40(s0)
     5c6:	0007c783          	lbu	a5,0(a5)
     5ca:	873e                	mv	a4,a5
     5cc:	02f00793          	li	a5,47
     5d0:	00e7fb63          	bgeu	a5,a4,5e6 <atoi+0x68>
     5d4:	fd843783          	ld	a5,-40(s0)
     5d8:	0007c783          	lbu	a5,0(a5)
     5dc:	873e                	mv	a4,a5
     5de:	03900793          	li	a5,57
     5e2:	fae7f6e3          	bgeu	a5,a4,58e <atoi+0x10>
  return n;
     5e6:	fec42783          	lw	a5,-20(s0)
}
     5ea:	853e                	mv	a0,a5
     5ec:	7422                	ld	s0,40(sp)
     5ee:	6145                	addi	sp,sp,48
     5f0:	8082                	ret

00000000000005f2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     5f2:	7139                	addi	sp,sp,-64
     5f4:	fc22                	sd	s0,56(sp)
     5f6:	0080                	addi	s0,sp,64
     5f8:	fca43c23          	sd	a0,-40(s0)
     5fc:	fcb43823          	sd	a1,-48(s0)
     600:	87b2                	mv	a5,a2
     602:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     606:	fd843783          	ld	a5,-40(s0)
     60a:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     60e:	fd043783          	ld	a5,-48(s0)
     612:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     616:	fe043703          	ld	a4,-32(s0)
     61a:	fe843783          	ld	a5,-24(s0)
     61e:	02e7fc63          	bgeu	a5,a4,656 <memmove+0x64>
    while(n-- > 0)
     622:	a00d                	j	644 <memmove+0x52>
      *dst++ = *src++;
     624:	fe043703          	ld	a4,-32(s0)
     628:	00170793          	addi	a5,a4,1
     62c:	fef43023          	sd	a5,-32(s0)
     630:	fe843783          	ld	a5,-24(s0)
     634:	00178693          	addi	a3,a5,1
     638:	fed43423          	sd	a3,-24(s0)
     63c:	00074703          	lbu	a4,0(a4)
     640:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     644:	fcc42783          	lw	a5,-52(s0)
     648:	fff7871b          	addiw	a4,a5,-1
     64c:	fce42623          	sw	a4,-52(s0)
     650:	fcf04ae3          	bgtz	a5,624 <memmove+0x32>
     654:	a891                	j	6a8 <memmove+0xb6>
  } else {
    dst += n;
     656:	fcc42783          	lw	a5,-52(s0)
     65a:	fe843703          	ld	a4,-24(s0)
     65e:	97ba                	add	a5,a5,a4
     660:	fef43423          	sd	a5,-24(s0)
    src += n;
     664:	fcc42783          	lw	a5,-52(s0)
     668:	fe043703          	ld	a4,-32(s0)
     66c:	97ba                	add	a5,a5,a4
     66e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     672:	a01d                	j	698 <memmove+0xa6>
      *--dst = *--src;
     674:	fe043783          	ld	a5,-32(s0)
     678:	17fd                	addi	a5,a5,-1
     67a:	fef43023          	sd	a5,-32(s0)
     67e:	fe843783          	ld	a5,-24(s0)
     682:	17fd                	addi	a5,a5,-1
     684:	fef43423          	sd	a5,-24(s0)
     688:	fe043783          	ld	a5,-32(s0)
     68c:	0007c703          	lbu	a4,0(a5)
     690:	fe843783          	ld	a5,-24(s0)
     694:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     698:	fcc42783          	lw	a5,-52(s0)
     69c:	fff7871b          	addiw	a4,a5,-1
     6a0:	fce42623          	sw	a4,-52(s0)
     6a4:	fcf048e3          	bgtz	a5,674 <memmove+0x82>
  }
  return vdst;
     6a8:	fd843783          	ld	a5,-40(s0)
}
     6ac:	853e                	mv	a0,a5
     6ae:	7462                	ld	s0,56(sp)
     6b0:	6121                	addi	sp,sp,64
     6b2:	8082                	ret

00000000000006b4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     6b4:	7139                	addi	sp,sp,-64
     6b6:	fc22                	sd	s0,56(sp)
     6b8:	0080                	addi	s0,sp,64
     6ba:	fca43c23          	sd	a0,-40(s0)
     6be:	fcb43823          	sd	a1,-48(s0)
     6c2:	87b2                	mv	a5,a2
     6c4:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     6c8:	fd843783          	ld	a5,-40(s0)
     6cc:	fef43423          	sd	a5,-24(s0)
     6d0:	fd043783          	ld	a5,-48(s0)
     6d4:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     6d8:	a0a1                	j	720 <memcmp+0x6c>
    if (*p1 != *p2) {
     6da:	fe843783          	ld	a5,-24(s0)
     6de:	0007c703          	lbu	a4,0(a5)
     6e2:	fe043783          	ld	a5,-32(s0)
     6e6:	0007c783          	lbu	a5,0(a5)
     6ea:	02f70163          	beq	a4,a5,70c <memcmp+0x58>
      return *p1 - *p2;
     6ee:	fe843783          	ld	a5,-24(s0)
     6f2:	0007c783          	lbu	a5,0(a5)
     6f6:	0007871b          	sext.w	a4,a5
     6fa:	fe043783          	ld	a5,-32(s0)
     6fe:	0007c783          	lbu	a5,0(a5)
     702:	2781                	sext.w	a5,a5
     704:	40f707bb          	subw	a5,a4,a5
     708:	2781                	sext.w	a5,a5
     70a:	a01d                	j	730 <memcmp+0x7c>
    }
    p1++;
     70c:	fe843783          	ld	a5,-24(s0)
     710:	0785                	addi	a5,a5,1
     712:	fef43423          	sd	a5,-24(s0)
    p2++;
     716:	fe043783          	ld	a5,-32(s0)
     71a:	0785                	addi	a5,a5,1
     71c:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     720:	fcc42783          	lw	a5,-52(s0)
     724:	fff7871b          	addiw	a4,a5,-1
     728:	fce42623          	sw	a4,-52(s0)
     72c:	f7dd                	bnez	a5,6da <memcmp+0x26>
  }
  return 0;
     72e:	4781                	li	a5,0
}
     730:	853e                	mv	a0,a5
     732:	7462                	ld	s0,56(sp)
     734:	6121                	addi	sp,sp,64
     736:	8082                	ret

0000000000000738 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     738:	7179                	addi	sp,sp,-48
     73a:	f406                	sd	ra,40(sp)
     73c:	f022                	sd	s0,32(sp)
     73e:	1800                	addi	s0,sp,48
     740:	fea43423          	sd	a0,-24(s0)
     744:	feb43023          	sd	a1,-32(s0)
     748:	87b2                	mv	a5,a2
     74a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     74e:	fdc42783          	lw	a5,-36(s0)
     752:	863e                	mv	a2,a5
     754:	fe043583          	ld	a1,-32(s0)
     758:	fe843503          	ld	a0,-24(s0)
     75c:	00000097          	auipc	ra,0x0
     760:	e96080e7          	jalr	-362(ra) # 5f2 <memmove>
     764:	87aa                	mv	a5,a0
}
     766:	853e                	mv	a0,a5
     768:	70a2                	ld	ra,40(sp)
     76a:	7402                	ld	s0,32(sp)
     76c:	6145                	addi	sp,sp,48
     76e:	8082                	ret

0000000000000770 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     770:	4885                	li	a7,1
 ecall
     772:	00000073          	ecall
 ret
     776:	8082                	ret

0000000000000778 <exit>:
.global exit
exit:
 li a7, SYS_exit
     778:	4889                	li	a7,2
 ecall
     77a:	00000073          	ecall
 ret
     77e:	8082                	ret

0000000000000780 <wait>:
.global wait
wait:
 li a7, SYS_wait
     780:	488d                	li	a7,3
 ecall
     782:	00000073          	ecall
 ret
     786:	8082                	ret

0000000000000788 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     788:	4891                	li	a7,4
 ecall
     78a:	00000073          	ecall
 ret
     78e:	8082                	ret

0000000000000790 <read>:
.global read
read:
 li a7, SYS_read
     790:	4895                	li	a7,5
 ecall
     792:	00000073          	ecall
 ret
     796:	8082                	ret

0000000000000798 <write>:
.global write
write:
 li a7, SYS_write
     798:	48c1                	li	a7,16
 ecall
     79a:	00000073          	ecall
 ret
     79e:	8082                	ret

00000000000007a0 <close>:
.global close
close:
 li a7, SYS_close
     7a0:	48d5                	li	a7,21
 ecall
     7a2:	00000073          	ecall
 ret
     7a6:	8082                	ret

00000000000007a8 <kill>:
.global kill
kill:
 li a7, SYS_kill
     7a8:	4899                	li	a7,6
 ecall
     7aa:	00000073          	ecall
 ret
     7ae:	8082                	ret

00000000000007b0 <exec>:
.global exec
exec:
 li a7, SYS_exec
     7b0:	489d                	li	a7,7
 ecall
     7b2:	00000073          	ecall
 ret
     7b6:	8082                	ret

00000000000007b8 <open>:
.global open
open:
 li a7, SYS_open
     7b8:	48bd                	li	a7,15
 ecall
     7ba:	00000073          	ecall
 ret
     7be:	8082                	ret

00000000000007c0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     7c0:	48c5                	li	a7,17
 ecall
     7c2:	00000073          	ecall
 ret
     7c6:	8082                	ret

00000000000007c8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     7c8:	48c9                	li	a7,18
 ecall
     7ca:	00000073          	ecall
 ret
     7ce:	8082                	ret

00000000000007d0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     7d0:	48a1                	li	a7,8
 ecall
     7d2:	00000073          	ecall
 ret
     7d6:	8082                	ret

00000000000007d8 <link>:
.global link
link:
 li a7, SYS_link
     7d8:	48cd                	li	a7,19
 ecall
     7da:	00000073          	ecall
 ret
     7de:	8082                	ret

00000000000007e0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     7e0:	48d1                	li	a7,20
 ecall
     7e2:	00000073          	ecall
 ret
     7e6:	8082                	ret

00000000000007e8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     7e8:	48a5                	li	a7,9
 ecall
     7ea:	00000073          	ecall
 ret
     7ee:	8082                	ret

00000000000007f0 <dup>:
.global dup
dup:
 li a7, SYS_dup
     7f0:	48a9                	li	a7,10
 ecall
     7f2:	00000073          	ecall
 ret
     7f6:	8082                	ret

00000000000007f8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     7f8:	48ad                	li	a7,11
 ecall
     7fa:	00000073          	ecall
 ret
     7fe:	8082                	ret

0000000000000800 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     800:	48b1                	li	a7,12
 ecall
     802:	00000073          	ecall
 ret
     806:	8082                	ret

0000000000000808 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     808:	48b5                	li	a7,13
 ecall
     80a:	00000073          	ecall
 ret
     80e:	8082                	ret

0000000000000810 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     810:	48b9                	li	a7,14
 ecall
     812:	00000073          	ecall
 ret
     816:	8082                	ret

0000000000000818 <clone>:
.global clone
clone:
 li a7, SYS_clone
     818:	48d9                	li	a7,22
 ecall
     81a:	00000073          	ecall
 ret
     81e:	8082                	ret

0000000000000820 <join>:
.global join
join:
 li a7, SYS_join
     820:	48dd                	li	a7,23
 ecall
     822:	00000073          	ecall
 ret
     826:	8082                	ret

0000000000000828 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     828:	1101                	addi	sp,sp,-32
     82a:	ec06                	sd	ra,24(sp)
     82c:	e822                	sd	s0,16(sp)
     82e:	1000                	addi	s0,sp,32
     830:	87aa                	mv	a5,a0
     832:	872e                	mv	a4,a1
     834:	fef42623          	sw	a5,-20(s0)
     838:	87ba                	mv	a5,a4
     83a:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     83e:	feb40713          	addi	a4,s0,-21
     842:	fec42783          	lw	a5,-20(s0)
     846:	4605                	li	a2,1
     848:	85ba                	mv	a1,a4
     84a:	853e                	mv	a0,a5
     84c:	00000097          	auipc	ra,0x0
     850:	f4c080e7          	jalr	-180(ra) # 798 <write>
}
     854:	0001                	nop
     856:	60e2                	ld	ra,24(sp)
     858:	6442                	ld	s0,16(sp)
     85a:	6105                	addi	sp,sp,32
     85c:	8082                	ret

000000000000085e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     85e:	7139                	addi	sp,sp,-64
     860:	fc06                	sd	ra,56(sp)
     862:	f822                	sd	s0,48(sp)
     864:	0080                	addi	s0,sp,64
     866:	87aa                	mv	a5,a0
     868:	8736                	mv	a4,a3
     86a:	fcf42623          	sw	a5,-52(s0)
     86e:	87ae                	mv	a5,a1
     870:	fcf42423          	sw	a5,-56(s0)
     874:	87b2                	mv	a5,a2
     876:	fcf42223          	sw	a5,-60(s0)
     87a:	87ba                	mv	a5,a4
     87c:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     880:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     884:	fc042783          	lw	a5,-64(s0)
     888:	2781                	sext.w	a5,a5
     88a:	c38d                	beqz	a5,8ac <printint+0x4e>
     88c:	fc842783          	lw	a5,-56(s0)
     890:	2781                	sext.w	a5,a5
     892:	0007dd63          	bgez	a5,8ac <printint+0x4e>
    neg = 1;
     896:	4785                	li	a5,1
     898:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     89c:	fc842783          	lw	a5,-56(s0)
     8a0:	40f007bb          	negw	a5,a5
     8a4:	2781                	sext.w	a5,a5
     8a6:	fef42223          	sw	a5,-28(s0)
     8aa:	a029                	j	8b4 <printint+0x56>
  } else {
    x = xx;
     8ac:	fc842783          	lw	a5,-56(s0)
     8b0:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     8b4:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     8b8:	fc442783          	lw	a5,-60(s0)
     8bc:	fe442703          	lw	a4,-28(s0)
     8c0:	02f777bb          	remuw	a5,a4,a5
     8c4:	0007861b          	sext.w	a2,a5
     8c8:	fec42783          	lw	a5,-20(s0)
     8cc:	0017871b          	addiw	a4,a5,1
     8d0:	fee42623          	sw	a4,-20(s0)
     8d4:	00001697          	auipc	a3,0x1
     8d8:	9d468693          	addi	a3,a3,-1580 # 12a8 <digits>
     8dc:	02061713          	slli	a4,a2,0x20
     8e0:	9301                	srli	a4,a4,0x20
     8e2:	9736                	add	a4,a4,a3
     8e4:	00074703          	lbu	a4,0(a4)
     8e8:	17c1                	addi	a5,a5,-16
     8ea:	97a2                	add	a5,a5,s0
     8ec:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     8f0:	fc442783          	lw	a5,-60(s0)
     8f4:	fe442703          	lw	a4,-28(s0)
     8f8:	02f757bb          	divuw	a5,a4,a5
     8fc:	fef42223          	sw	a5,-28(s0)
     900:	fe442783          	lw	a5,-28(s0)
     904:	2781                	sext.w	a5,a5
     906:	fbcd                	bnez	a5,8b8 <printint+0x5a>
  if(neg)
     908:	fe842783          	lw	a5,-24(s0)
     90c:	2781                	sext.w	a5,a5
     90e:	cf85                	beqz	a5,946 <printint+0xe8>
    buf[i++] = '-';
     910:	fec42783          	lw	a5,-20(s0)
     914:	0017871b          	addiw	a4,a5,1
     918:	fee42623          	sw	a4,-20(s0)
     91c:	17c1                	addi	a5,a5,-16
     91e:	97a2                	add	a5,a5,s0
     920:	02d00713          	li	a4,45
     924:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     928:	a839                	j	946 <printint+0xe8>
    putc(fd, buf[i]);
     92a:	fec42783          	lw	a5,-20(s0)
     92e:	17c1                	addi	a5,a5,-16
     930:	97a2                	add	a5,a5,s0
     932:	fe07c703          	lbu	a4,-32(a5)
     936:	fcc42783          	lw	a5,-52(s0)
     93a:	85ba                	mv	a1,a4
     93c:	853e                	mv	a0,a5
     93e:	00000097          	auipc	ra,0x0
     942:	eea080e7          	jalr	-278(ra) # 828 <putc>
  while(--i >= 0)
     946:	fec42783          	lw	a5,-20(s0)
     94a:	37fd                	addiw	a5,a5,-1
     94c:	fef42623          	sw	a5,-20(s0)
     950:	fec42783          	lw	a5,-20(s0)
     954:	2781                	sext.w	a5,a5
     956:	fc07dae3          	bgez	a5,92a <printint+0xcc>
}
     95a:	0001                	nop
     95c:	0001                	nop
     95e:	70e2                	ld	ra,56(sp)
     960:	7442                	ld	s0,48(sp)
     962:	6121                	addi	sp,sp,64
     964:	8082                	ret

0000000000000966 <printptr>:

static void
printptr(int fd, uint64 x) {
     966:	7179                	addi	sp,sp,-48
     968:	f406                	sd	ra,40(sp)
     96a:	f022                	sd	s0,32(sp)
     96c:	1800                	addi	s0,sp,48
     96e:	87aa                	mv	a5,a0
     970:	fcb43823          	sd	a1,-48(s0)
     974:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     978:	fdc42783          	lw	a5,-36(s0)
     97c:	03000593          	li	a1,48
     980:	853e                	mv	a0,a5
     982:	00000097          	auipc	ra,0x0
     986:	ea6080e7          	jalr	-346(ra) # 828 <putc>
  putc(fd, 'x');
     98a:	fdc42783          	lw	a5,-36(s0)
     98e:	07800593          	li	a1,120
     992:	853e                	mv	a0,a5
     994:	00000097          	auipc	ra,0x0
     998:	e94080e7          	jalr	-364(ra) # 828 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     99c:	fe042623          	sw	zero,-20(s0)
     9a0:	a82d                	j	9da <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     9a2:	fd043783          	ld	a5,-48(s0)
     9a6:	93f1                	srli	a5,a5,0x3c
     9a8:	00001717          	auipc	a4,0x1
     9ac:	90070713          	addi	a4,a4,-1792 # 12a8 <digits>
     9b0:	97ba                	add	a5,a5,a4
     9b2:	0007c703          	lbu	a4,0(a5)
     9b6:	fdc42783          	lw	a5,-36(s0)
     9ba:	85ba                	mv	a1,a4
     9bc:	853e                	mv	a0,a5
     9be:	00000097          	auipc	ra,0x0
     9c2:	e6a080e7          	jalr	-406(ra) # 828 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     9c6:	fec42783          	lw	a5,-20(s0)
     9ca:	2785                	addiw	a5,a5,1
     9cc:	fef42623          	sw	a5,-20(s0)
     9d0:	fd043783          	ld	a5,-48(s0)
     9d4:	0792                	slli	a5,a5,0x4
     9d6:	fcf43823          	sd	a5,-48(s0)
     9da:	fec42783          	lw	a5,-20(s0)
     9de:	873e                	mv	a4,a5
     9e0:	47bd                	li	a5,15
     9e2:	fce7f0e3          	bgeu	a5,a4,9a2 <printptr+0x3c>
}
     9e6:	0001                	nop
     9e8:	0001                	nop
     9ea:	70a2                	ld	ra,40(sp)
     9ec:	7402                	ld	s0,32(sp)
     9ee:	6145                	addi	sp,sp,48
     9f0:	8082                	ret

00000000000009f2 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     9f2:	715d                	addi	sp,sp,-80
     9f4:	e486                	sd	ra,72(sp)
     9f6:	e0a2                	sd	s0,64(sp)
     9f8:	0880                	addi	s0,sp,80
     9fa:	87aa                	mv	a5,a0
     9fc:	fcb43023          	sd	a1,-64(s0)
     a00:	fac43c23          	sd	a2,-72(s0)
     a04:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     a08:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     a0c:	fe042223          	sw	zero,-28(s0)
     a10:	a42d                	j	c3a <vprintf+0x248>
    c = fmt[i] & 0xff;
     a12:	fe442783          	lw	a5,-28(s0)
     a16:	fc043703          	ld	a4,-64(s0)
     a1a:	97ba                	add	a5,a5,a4
     a1c:	0007c783          	lbu	a5,0(a5)
     a20:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     a24:	fe042783          	lw	a5,-32(s0)
     a28:	2781                	sext.w	a5,a5
     a2a:	eb9d                	bnez	a5,a60 <vprintf+0x6e>
      if(c == '%'){
     a2c:	fdc42783          	lw	a5,-36(s0)
     a30:	0007871b          	sext.w	a4,a5
     a34:	02500793          	li	a5,37
     a38:	00f71763          	bne	a4,a5,a46 <vprintf+0x54>
        state = '%';
     a3c:	02500793          	li	a5,37
     a40:	fef42023          	sw	a5,-32(s0)
     a44:	a2f5                	j	c30 <vprintf+0x23e>
      } else {
        putc(fd, c);
     a46:	fdc42783          	lw	a5,-36(s0)
     a4a:	0ff7f713          	zext.b	a4,a5
     a4e:	fcc42783          	lw	a5,-52(s0)
     a52:	85ba                	mv	a1,a4
     a54:	853e                	mv	a0,a5
     a56:	00000097          	auipc	ra,0x0
     a5a:	dd2080e7          	jalr	-558(ra) # 828 <putc>
     a5e:	aac9                	j	c30 <vprintf+0x23e>
      }
    } else if(state == '%'){
     a60:	fe042783          	lw	a5,-32(s0)
     a64:	0007871b          	sext.w	a4,a5
     a68:	02500793          	li	a5,37
     a6c:	1cf71263          	bne	a4,a5,c30 <vprintf+0x23e>
      if(c == 'd'){
     a70:	fdc42783          	lw	a5,-36(s0)
     a74:	0007871b          	sext.w	a4,a5
     a78:	06400793          	li	a5,100
     a7c:	02f71463          	bne	a4,a5,aa4 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     a80:	fb843783          	ld	a5,-72(s0)
     a84:	00878713          	addi	a4,a5,8
     a88:	fae43c23          	sd	a4,-72(s0)
     a8c:	4398                	lw	a4,0(a5)
     a8e:	fcc42783          	lw	a5,-52(s0)
     a92:	4685                	li	a3,1
     a94:	4629                	li	a2,10
     a96:	85ba                	mv	a1,a4
     a98:	853e                	mv	a0,a5
     a9a:	00000097          	auipc	ra,0x0
     a9e:	dc4080e7          	jalr	-572(ra) # 85e <printint>
     aa2:	a269                	j	c2c <vprintf+0x23a>
      } else if(c == 'l') {
     aa4:	fdc42783          	lw	a5,-36(s0)
     aa8:	0007871b          	sext.w	a4,a5
     aac:	06c00793          	li	a5,108
     ab0:	02f71663          	bne	a4,a5,adc <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     ab4:	fb843783          	ld	a5,-72(s0)
     ab8:	00878713          	addi	a4,a5,8
     abc:	fae43c23          	sd	a4,-72(s0)
     ac0:	639c                	ld	a5,0(a5)
     ac2:	0007871b          	sext.w	a4,a5
     ac6:	fcc42783          	lw	a5,-52(s0)
     aca:	4681                	li	a3,0
     acc:	4629                	li	a2,10
     ace:	85ba                	mv	a1,a4
     ad0:	853e                	mv	a0,a5
     ad2:	00000097          	auipc	ra,0x0
     ad6:	d8c080e7          	jalr	-628(ra) # 85e <printint>
     ada:	aa89                	j	c2c <vprintf+0x23a>
      } else if(c == 'x') {
     adc:	fdc42783          	lw	a5,-36(s0)
     ae0:	0007871b          	sext.w	a4,a5
     ae4:	07800793          	li	a5,120
     ae8:	02f71463          	bne	a4,a5,b10 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     aec:	fb843783          	ld	a5,-72(s0)
     af0:	00878713          	addi	a4,a5,8
     af4:	fae43c23          	sd	a4,-72(s0)
     af8:	4398                	lw	a4,0(a5)
     afa:	fcc42783          	lw	a5,-52(s0)
     afe:	4681                	li	a3,0
     b00:	4641                	li	a2,16
     b02:	85ba                	mv	a1,a4
     b04:	853e                	mv	a0,a5
     b06:	00000097          	auipc	ra,0x0
     b0a:	d58080e7          	jalr	-680(ra) # 85e <printint>
     b0e:	aa39                	j	c2c <vprintf+0x23a>
      } else if(c == 'p') {
     b10:	fdc42783          	lw	a5,-36(s0)
     b14:	0007871b          	sext.w	a4,a5
     b18:	07000793          	li	a5,112
     b1c:	02f71263          	bne	a4,a5,b40 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     b20:	fb843783          	ld	a5,-72(s0)
     b24:	00878713          	addi	a4,a5,8
     b28:	fae43c23          	sd	a4,-72(s0)
     b2c:	6398                	ld	a4,0(a5)
     b2e:	fcc42783          	lw	a5,-52(s0)
     b32:	85ba                	mv	a1,a4
     b34:	853e                	mv	a0,a5
     b36:	00000097          	auipc	ra,0x0
     b3a:	e30080e7          	jalr	-464(ra) # 966 <printptr>
     b3e:	a0fd                	j	c2c <vprintf+0x23a>
      } else if(c == 's'){
     b40:	fdc42783          	lw	a5,-36(s0)
     b44:	0007871b          	sext.w	a4,a5
     b48:	07300793          	li	a5,115
     b4c:	04f71c63          	bne	a4,a5,ba4 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     b50:	fb843783          	ld	a5,-72(s0)
     b54:	00878713          	addi	a4,a5,8
     b58:	fae43c23          	sd	a4,-72(s0)
     b5c:	639c                	ld	a5,0(a5)
     b5e:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     b62:	fe843783          	ld	a5,-24(s0)
     b66:	eb8d                	bnez	a5,b98 <vprintf+0x1a6>
          s = "(null)";
     b68:	00000797          	auipc	a5,0x0
     b6c:	6e878793          	addi	a5,a5,1768 # 1250 <cv_init+0xc2>
     b70:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     b74:	a015                	j	b98 <vprintf+0x1a6>
          putc(fd, *s);
     b76:	fe843783          	ld	a5,-24(s0)
     b7a:	0007c703          	lbu	a4,0(a5)
     b7e:	fcc42783          	lw	a5,-52(s0)
     b82:	85ba                	mv	a1,a4
     b84:	853e                	mv	a0,a5
     b86:	00000097          	auipc	ra,0x0
     b8a:	ca2080e7          	jalr	-862(ra) # 828 <putc>
          s++;
     b8e:	fe843783          	ld	a5,-24(s0)
     b92:	0785                	addi	a5,a5,1
     b94:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     b98:	fe843783          	ld	a5,-24(s0)
     b9c:	0007c783          	lbu	a5,0(a5)
     ba0:	fbf9                	bnez	a5,b76 <vprintf+0x184>
     ba2:	a069                	j	c2c <vprintf+0x23a>
        }
      } else if(c == 'c'){
     ba4:	fdc42783          	lw	a5,-36(s0)
     ba8:	0007871b          	sext.w	a4,a5
     bac:	06300793          	li	a5,99
     bb0:	02f71463          	bne	a4,a5,bd8 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     bb4:	fb843783          	ld	a5,-72(s0)
     bb8:	00878713          	addi	a4,a5,8
     bbc:	fae43c23          	sd	a4,-72(s0)
     bc0:	439c                	lw	a5,0(a5)
     bc2:	0ff7f713          	zext.b	a4,a5
     bc6:	fcc42783          	lw	a5,-52(s0)
     bca:	85ba                	mv	a1,a4
     bcc:	853e                	mv	a0,a5
     bce:	00000097          	auipc	ra,0x0
     bd2:	c5a080e7          	jalr	-934(ra) # 828 <putc>
     bd6:	a899                	j	c2c <vprintf+0x23a>
      } else if(c == '%'){
     bd8:	fdc42783          	lw	a5,-36(s0)
     bdc:	0007871b          	sext.w	a4,a5
     be0:	02500793          	li	a5,37
     be4:	00f71f63          	bne	a4,a5,c02 <vprintf+0x210>
        putc(fd, c);
     be8:	fdc42783          	lw	a5,-36(s0)
     bec:	0ff7f713          	zext.b	a4,a5
     bf0:	fcc42783          	lw	a5,-52(s0)
     bf4:	85ba                	mv	a1,a4
     bf6:	853e                	mv	a0,a5
     bf8:	00000097          	auipc	ra,0x0
     bfc:	c30080e7          	jalr	-976(ra) # 828 <putc>
     c00:	a035                	j	c2c <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     c02:	fcc42783          	lw	a5,-52(s0)
     c06:	02500593          	li	a1,37
     c0a:	853e                	mv	a0,a5
     c0c:	00000097          	auipc	ra,0x0
     c10:	c1c080e7          	jalr	-996(ra) # 828 <putc>
        putc(fd, c);
     c14:	fdc42783          	lw	a5,-36(s0)
     c18:	0ff7f713          	zext.b	a4,a5
     c1c:	fcc42783          	lw	a5,-52(s0)
     c20:	85ba                	mv	a1,a4
     c22:	853e                	mv	a0,a5
     c24:	00000097          	auipc	ra,0x0
     c28:	c04080e7          	jalr	-1020(ra) # 828 <putc>
      }
      state = 0;
     c2c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     c30:	fe442783          	lw	a5,-28(s0)
     c34:	2785                	addiw	a5,a5,1
     c36:	fef42223          	sw	a5,-28(s0)
     c3a:	fe442783          	lw	a5,-28(s0)
     c3e:	fc043703          	ld	a4,-64(s0)
     c42:	97ba                	add	a5,a5,a4
     c44:	0007c783          	lbu	a5,0(a5)
     c48:	dc0795e3          	bnez	a5,a12 <vprintf+0x20>
    }
  }
}
     c4c:	0001                	nop
     c4e:	0001                	nop
     c50:	60a6                	ld	ra,72(sp)
     c52:	6406                	ld	s0,64(sp)
     c54:	6161                	addi	sp,sp,80
     c56:	8082                	ret

0000000000000c58 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     c58:	7159                	addi	sp,sp,-112
     c5a:	fc06                	sd	ra,56(sp)
     c5c:	f822                	sd	s0,48(sp)
     c5e:	0080                	addi	s0,sp,64
     c60:	fcb43823          	sd	a1,-48(s0)
     c64:	e010                	sd	a2,0(s0)
     c66:	e414                	sd	a3,8(s0)
     c68:	e818                	sd	a4,16(s0)
     c6a:	ec1c                	sd	a5,24(s0)
     c6c:	03043023          	sd	a6,32(s0)
     c70:	03143423          	sd	a7,40(s0)
     c74:	87aa                	mv	a5,a0
     c76:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     c7a:	03040793          	addi	a5,s0,48
     c7e:	fcf43423          	sd	a5,-56(s0)
     c82:	fc843783          	ld	a5,-56(s0)
     c86:	fd078793          	addi	a5,a5,-48
     c8a:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     c8e:	fe843703          	ld	a4,-24(s0)
     c92:	fdc42783          	lw	a5,-36(s0)
     c96:	863a                	mv	a2,a4
     c98:	fd043583          	ld	a1,-48(s0)
     c9c:	853e                	mv	a0,a5
     c9e:	00000097          	auipc	ra,0x0
     ca2:	d54080e7          	jalr	-684(ra) # 9f2 <vprintf>
}
     ca6:	0001                	nop
     ca8:	70e2                	ld	ra,56(sp)
     caa:	7442                	ld	s0,48(sp)
     cac:	6165                	addi	sp,sp,112
     cae:	8082                	ret

0000000000000cb0 <printf>:

void
printf(const char *fmt, ...)
{
     cb0:	7159                	addi	sp,sp,-112
     cb2:	f406                	sd	ra,40(sp)
     cb4:	f022                	sd	s0,32(sp)
     cb6:	1800                	addi	s0,sp,48
     cb8:	fca43c23          	sd	a0,-40(s0)
     cbc:	e40c                	sd	a1,8(s0)
     cbe:	e810                	sd	a2,16(s0)
     cc0:	ec14                	sd	a3,24(s0)
     cc2:	f018                	sd	a4,32(s0)
     cc4:	f41c                	sd	a5,40(s0)
     cc6:	03043823          	sd	a6,48(s0)
     cca:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     cce:	04040793          	addi	a5,s0,64
     cd2:	fcf43823          	sd	a5,-48(s0)
     cd6:	fd043783          	ld	a5,-48(s0)
     cda:	fc878793          	addi	a5,a5,-56
     cde:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     ce2:	fe843783          	ld	a5,-24(s0)
     ce6:	863e                	mv	a2,a5
     ce8:	fd843583          	ld	a1,-40(s0)
     cec:	4505                	li	a0,1
     cee:	00000097          	auipc	ra,0x0
     cf2:	d04080e7          	jalr	-764(ra) # 9f2 <vprintf>
}
     cf6:	0001                	nop
     cf8:	70a2                	ld	ra,40(sp)
     cfa:	7402                	ld	s0,32(sp)
     cfc:	6165                	addi	sp,sp,112
     cfe:	8082                	ret

0000000000000d00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     d00:	7179                	addi	sp,sp,-48
     d02:	f422                	sd	s0,40(sp)
     d04:	1800                	addi	s0,sp,48
     d06:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     d0a:	fd843783          	ld	a5,-40(s0)
     d0e:	17c1                	addi	a5,a5,-16
     d10:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d14:	00000797          	auipc	a5,0x0
     d18:	5c478793          	addi	a5,a5,1476 # 12d8 <freep>
     d1c:	639c                	ld	a5,0(a5)
     d1e:	fef43423          	sd	a5,-24(s0)
     d22:	a815                	j	d56 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     d24:	fe843783          	ld	a5,-24(s0)
     d28:	639c                	ld	a5,0(a5)
     d2a:	fe843703          	ld	a4,-24(s0)
     d2e:	00f76f63          	bltu	a4,a5,d4c <free+0x4c>
     d32:	fe043703          	ld	a4,-32(s0)
     d36:	fe843783          	ld	a5,-24(s0)
     d3a:	02e7eb63          	bltu	a5,a4,d70 <free+0x70>
     d3e:	fe843783          	ld	a5,-24(s0)
     d42:	639c                	ld	a5,0(a5)
     d44:	fe043703          	ld	a4,-32(s0)
     d48:	02f76463          	bltu	a4,a5,d70 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d4c:	fe843783          	ld	a5,-24(s0)
     d50:	639c                	ld	a5,0(a5)
     d52:	fef43423          	sd	a5,-24(s0)
     d56:	fe043703          	ld	a4,-32(s0)
     d5a:	fe843783          	ld	a5,-24(s0)
     d5e:	fce7f3e3          	bgeu	a5,a4,d24 <free+0x24>
     d62:	fe843783          	ld	a5,-24(s0)
     d66:	639c                	ld	a5,0(a5)
     d68:	fe043703          	ld	a4,-32(s0)
     d6c:	faf77ce3          	bgeu	a4,a5,d24 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     d70:	fe043783          	ld	a5,-32(s0)
     d74:	479c                	lw	a5,8(a5)
     d76:	1782                	slli	a5,a5,0x20
     d78:	9381                	srli	a5,a5,0x20
     d7a:	0792                	slli	a5,a5,0x4
     d7c:	fe043703          	ld	a4,-32(s0)
     d80:	973e                	add	a4,a4,a5
     d82:	fe843783          	ld	a5,-24(s0)
     d86:	639c                	ld	a5,0(a5)
     d88:	02f71763          	bne	a4,a5,db6 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     d8c:	fe043783          	ld	a5,-32(s0)
     d90:	4798                	lw	a4,8(a5)
     d92:	fe843783          	ld	a5,-24(s0)
     d96:	639c                	ld	a5,0(a5)
     d98:	479c                	lw	a5,8(a5)
     d9a:	9fb9                	addw	a5,a5,a4
     d9c:	0007871b          	sext.w	a4,a5
     da0:	fe043783          	ld	a5,-32(s0)
     da4:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     da6:	fe843783          	ld	a5,-24(s0)
     daa:	639c                	ld	a5,0(a5)
     dac:	6398                	ld	a4,0(a5)
     dae:	fe043783          	ld	a5,-32(s0)
     db2:	e398                	sd	a4,0(a5)
     db4:	a039                	j	dc2 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     db6:	fe843783          	ld	a5,-24(s0)
     dba:	6398                	ld	a4,0(a5)
     dbc:	fe043783          	ld	a5,-32(s0)
     dc0:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     dc2:	fe843783          	ld	a5,-24(s0)
     dc6:	479c                	lw	a5,8(a5)
     dc8:	1782                	slli	a5,a5,0x20
     dca:	9381                	srli	a5,a5,0x20
     dcc:	0792                	slli	a5,a5,0x4
     dce:	fe843703          	ld	a4,-24(s0)
     dd2:	97ba                	add	a5,a5,a4
     dd4:	fe043703          	ld	a4,-32(s0)
     dd8:	02f71563          	bne	a4,a5,e02 <free+0x102>
    p->s.size += bp->s.size;
     ddc:	fe843783          	ld	a5,-24(s0)
     de0:	4798                	lw	a4,8(a5)
     de2:	fe043783          	ld	a5,-32(s0)
     de6:	479c                	lw	a5,8(a5)
     de8:	9fb9                	addw	a5,a5,a4
     dea:	0007871b          	sext.w	a4,a5
     dee:	fe843783          	ld	a5,-24(s0)
     df2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     df4:	fe043783          	ld	a5,-32(s0)
     df8:	6398                	ld	a4,0(a5)
     dfa:	fe843783          	ld	a5,-24(s0)
     dfe:	e398                	sd	a4,0(a5)
     e00:	a031                	j	e0c <free+0x10c>
  } else
    p->s.ptr = bp;
     e02:	fe843783          	ld	a5,-24(s0)
     e06:	fe043703          	ld	a4,-32(s0)
     e0a:	e398                	sd	a4,0(a5)
  freep = p;
     e0c:	00000797          	auipc	a5,0x0
     e10:	4cc78793          	addi	a5,a5,1228 # 12d8 <freep>
     e14:	fe843703          	ld	a4,-24(s0)
     e18:	e398                	sd	a4,0(a5)
}
     e1a:	0001                	nop
     e1c:	7422                	ld	s0,40(sp)
     e1e:	6145                	addi	sp,sp,48
     e20:	8082                	ret

0000000000000e22 <morecore>:

static Header*
morecore(uint nu)
{
     e22:	7179                	addi	sp,sp,-48
     e24:	f406                	sd	ra,40(sp)
     e26:	f022                	sd	s0,32(sp)
     e28:	1800                	addi	s0,sp,48
     e2a:	87aa                	mv	a5,a0
     e2c:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     e30:	fdc42783          	lw	a5,-36(s0)
     e34:	0007871b          	sext.w	a4,a5
     e38:	6785                	lui	a5,0x1
     e3a:	00f77563          	bgeu	a4,a5,e44 <morecore+0x22>
    nu = 4096;
     e3e:	6785                	lui	a5,0x1
     e40:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     e44:	fdc42783          	lw	a5,-36(s0)
     e48:	0047979b          	slliw	a5,a5,0x4
     e4c:	2781                	sext.w	a5,a5
     e4e:	2781                	sext.w	a5,a5
     e50:	853e                	mv	a0,a5
     e52:	00000097          	auipc	ra,0x0
     e56:	9ae080e7          	jalr	-1618(ra) # 800 <sbrk>
     e5a:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     e5e:	fe843703          	ld	a4,-24(s0)
     e62:	57fd                	li	a5,-1
     e64:	00f71463          	bne	a4,a5,e6c <morecore+0x4a>
    return 0;
     e68:	4781                	li	a5,0
     e6a:	a03d                	j	e98 <morecore+0x76>
  hp = (Header*)p;
     e6c:	fe843783          	ld	a5,-24(s0)
     e70:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     e74:	fe043783          	ld	a5,-32(s0)
     e78:	fdc42703          	lw	a4,-36(s0)
     e7c:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     e7e:	fe043783          	ld	a5,-32(s0)
     e82:	07c1                	addi	a5,a5,16
     e84:	853e                	mv	a0,a5
     e86:	00000097          	auipc	ra,0x0
     e8a:	e7a080e7          	jalr	-390(ra) # d00 <free>
  return freep;
     e8e:	00000797          	auipc	a5,0x0
     e92:	44a78793          	addi	a5,a5,1098 # 12d8 <freep>
     e96:	639c                	ld	a5,0(a5)
}
     e98:	853e                	mv	a0,a5
     e9a:	70a2                	ld	ra,40(sp)
     e9c:	7402                	ld	s0,32(sp)
     e9e:	6145                	addi	sp,sp,48
     ea0:	8082                	ret

0000000000000ea2 <malloc>:

void*
malloc(uint nbytes)
{
     ea2:	7139                	addi	sp,sp,-64
     ea4:	fc06                	sd	ra,56(sp)
     ea6:	f822                	sd	s0,48(sp)
     ea8:	0080                	addi	s0,sp,64
     eaa:	87aa                	mv	a5,a0
     eac:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     eb0:	fcc46783          	lwu	a5,-52(s0)
     eb4:	07bd                	addi	a5,a5,15
     eb6:	8391                	srli	a5,a5,0x4
     eb8:	2781                	sext.w	a5,a5
     eba:	2785                	addiw	a5,a5,1
     ebc:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     ec0:	00000797          	auipc	a5,0x0
     ec4:	41878793          	addi	a5,a5,1048 # 12d8 <freep>
     ec8:	639c                	ld	a5,0(a5)
     eca:	fef43023          	sd	a5,-32(s0)
     ece:	fe043783          	ld	a5,-32(s0)
     ed2:	ef95                	bnez	a5,f0e <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     ed4:	00000797          	auipc	a5,0x0
     ed8:	3f478793          	addi	a5,a5,1012 # 12c8 <base>
     edc:	fef43023          	sd	a5,-32(s0)
     ee0:	00000797          	auipc	a5,0x0
     ee4:	3f878793          	addi	a5,a5,1016 # 12d8 <freep>
     ee8:	fe043703          	ld	a4,-32(s0)
     eec:	e398                	sd	a4,0(a5)
     eee:	00000797          	auipc	a5,0x0
     ef2:	3ea78793          	addi	a5,a5,1002 # 12d8 <freep>
     ef6:	6398                	ld	a4,0(a5)
     ef8:	00000797          	auipc	a5,0x0
     efc:	3d078793          	addi	a5,a5,976 # 12c8 <base>
     f00:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     f02:	00000797          	auipc	a5,0x0
     f06:	3c678793          	addi	a5,a5,966 # 12c8 <base>
     f0a:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f0e:	fe043783          	ld	a5,-32(s0)
     f12:	639c                	ld	a5,0(a5)
     f14:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     f18:	fe843783          	ld	a5,-24(s0)
     f1c:	4798                	lw	a4,8(a5)
     f1e:	fdc42783          	lw	a5,-36(s0)
     f22:	2781                	sext.w	a5,a5
     f24:	06f76763          	bltu	a4,a5,f92 <malloc+0xf0>
      if(p->s.size == nunits)
     f28:	fe843783          	ld	a5,-24(s0)
     f2c:	4798                	lw	a4,8(a5)
     f2e:	fdc42783          	lw	a5,-36(s0)
     f32:	2781                	sext.w	a5,a5
     f34:	00e79963          	bne	a5,a4,f46 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     f38:	fe843783          	ld	a5,-24(s0)
     f3c:	6398                	ld	a4,0(a5)
     f3e:	fe043783          	ld	a5,-32(s0)
     f42:	e398                	sd	a4,0(a5)
     f44:	a825                	j	f7c <malloc+0xda>
      else {
        p->s.size -= nunits;
     f46:	fe843783          	ld	a5,-24(s0)
     f4a:	479c                	lw	a5,8(a5)
     f4c:	fdc42703          	lw	a4,-36(s0)
     f50:	9f99                	subw	a5,a5,a4
     f52:	0007871b          	sext.w	a4,a5
     f56:	fe843783          	ld	a5,-24(s0)
     f5a:	c798                	sw	a4,8(a5)
        p += p->s.size;
     f5c:	fe843783          	ld	a5,-24(s0)
     f60:	479c                	lw	a5,8(a5)
     f62:	1782                	slli	a5,a5,0x20
     f64:	9381                	srli	a5,a5,0x20
     f66:	0792                	slli	a5,a5,0x4
     f68:	fe843703          	ld	a4,-24(s0)
     f6c:	97ba                	add	a5,a5,a4
     f6e:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     f72:	fe843783          	ld	a5,-24(s0)
     f76:	fdc42703          	lw	a4,-36(s0)
     f7a:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     f7c:	00000797          	auipc	a5,0x0
     f80:	35c78793          	addi	a5,a5,860 # 12d8 <freep>
     f84:	fe043703          	ld	a4,-32(s0)
     f88:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     f8a:	fe843783          	ld	a5,-24(s0)
     f8e:	07c1                	addi	a5,a5,16
     f90:	a091                	j	fd4 <malloc+0x132>
    }
    if(p == freep)
     f92:	00000797          	auipc	a5,0x0
     f96:	34678793          	addi	a5,a5,838 # 12d8 <freep>
     f9a:	639c                	ld	a5,0(a5)
     f9c:	fe843703          	ld	a4,-24(s0)
     fa0:	02f71063          	bne	a4,a5,fc0 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
     fa4:	fdc42783          	lw	a5,-36(s0)
     fa8:	853e                	mv	a0,a5
     faa:	00000097          	auipc	ra,0x0
     fae:	e78080e7          	jalr	-392(ra) # e22 <morecore>
     fb2:	fea43423          	sd	a0,-24(s0)
     fb6:	fe843783          	ld	a5,-24(s0)
     fba:	e399                	bnez	a5,fc0 <malloc+0x11e>
        return 0;
     fbc:	4781                	li	a5,0
     fbe:	a819                	j	fd4 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fc0:	fe843783          	ld	a5,-24(s0)
     fc4:	fef43023          	sd	a5,-32(s0)
     fc8:	fe843783          	ld	a5,-24(s0)
     fcc:	639c                	ld	a5,0(a5)
     fce:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     fd2:	b799                	j	f18 <malloc+0x76>
  }
}
     fd4:	853e                	mv	a0,a5
     fd6:	70e2                	ld	ra,56(sp)
     fd8:	7442                	ld	s0,48(sp)
     fda:	6121                	addi	sp,sp,64
     fdc:	8082                	ret

0000000000000fde <thread_create>:
typedef uint cont_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
     fde:	7179                	addi	sp,sp,-48
     fe0:	f406                	sd	ra,40(sp)
     fe2:	f022                	sd	s0,32(sp)
     fe4:	1800                	addi	s0,sp,48
     fe6:	fca43c23          	sd	a0,-40(s0)
     fea:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
     fee:	6505                	lui	a0,0x1
     ff0:	00000097          	auipc	ra,0x0
     ff4:	eb2080e7          	jalr	-334(ra) # ea2 <malloc>
     ff8:	fea43423          	sd	a0,-24(s0)
     ffc:	fe843783          	ld	a5,-24(s0)
    1000:	e38d                	bnez	a5,1022 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
    1002:	00000517          	auipc	a0,0x0
    1006:	25650513          	addi	a0,a0,598 # 1258 <cv_init+0xca>
    100a:	00000097          	auipc	ra,0x0
    100e:	ca6080e7          	jalr	-858(ra) # cb0 <printf>
        free(stack);
    1012:	fe843503          	ld	a0,-24(s0)
    1016:	00000097          	auipc	ra,0x0
    101a:	cea080e7          	jalr	-790(ra) # d00 <free>
        return -1;
    101e:	57fd                	li	a5,-1
    1020:	a099                	j	1066 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
    1022:	fe843783          	ld	a5,-24(s0)
    1026:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
    102a:	fe043703          	ld	a4,-32(s0)
    102e:	6785                	lui	a5,0x1
    1030:	17fd                	addi	a5,a5,-1
    1032:	8ff9                	and	a5,a5,a4
    1034:	cf91                	beqz	a5,1050 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
    1036:	fe043703          	ld	a4,-32(s0)
    103a:	6785                	lui	a5,0x1
    103c:	17fd                	addi	a5,a5,-1
    103e:	8ff9                	and	a5,a5,a4
    1040:	6705                	lui	a4,0x1
    1042:	40f707b3          	sub	a5,a4,a5
    1046:	fe843703          	ld	a4,-24(s0)
    104a:	97ba                	add	a5,a5,a4
    104c:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
    1050:	fe843603          	ld	a2,-24(s0)
    1054:	fd043583          	ld	a1,-48(s0)
    1058:	fd843503          	ld	a0,-40(s0)
    105c:	fffff097          	auipc	ra,0xfffff
    1060:	7bc080e7          	jalr	1980(ra) # 818 <clone>
    1064:	87aa                	mv	a5,a0
}
    1066:	853e                	mv	a0,a5
    1068:	70a2                	ld	ra,40(sp)
    106a:	7402                	ld	s0,32(sp)
    106c:	6145                	addi	sp,sp,48
    106e:	8082                	ret

0000000000001070 <thread_join>:


int thread_join()
{
    1070:	1101                	addi	sp,sp,-32
    1072:	ec06                	sd	ra,24(sp)
    1074:	e822                	sd	s0,16(sp)
    1076:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
    1078:	fe040793          	addi	a5,s0,-32
    107c:	853e                	mv	a0,a5
    107e:	fffff097          	auipc	ra,0xfffff
    1082:	7a2080e7          	jalr	1954(ra) # 820 <join>
    1086:	87aa                	mv	a5,a0
    1088:	fef42623          	sw	a5,-20(s0)
    108c:	fec42783          	lw	a5,-20(s0)
    1090:	0007871b          	sext.w	a4,a5
    1094:	57fd                	li	a5,-1
    1096:	00f70963          	beq	a4,a5,10a8 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
    109a:	fe043783          	ld	a5,-32(s0)
    109e:	853e                	mv	a0,a5
    10a0:	00000097          	auipc	ra,0x0
    10a4:	c60080e7          	jalr	-928(ra) # d00 <free>
    } 

    return child_tid;
    10a8:	fec42783          	lw	a5,-20(s0)
}
    10ac:	853e                	mv	a0,a5
    10ae:	60e2                	ld	ra,24(sp)
    10b0:	6442                	ld	s0,16(sp)
    10b2:	6105                	addi	sp,sp,32
    10b4:	8082                	ret

00000000000010b6 <lock_acquire>:


void lock_acquire (lock_t *lock){
    10b6:	1101                	addi	sp,sp,-32
    10b8:	ec22                	sd	s0,24(sp)
    10ba:	1000                	addi	s0,sp,32
    10bc:	fea43423          	sd	a0,-24(s0)
    while( __sync_lock_test_and_set(lock, 1)!=0){
    10c0:	0001                	nop
    10c2:	fe843783          	ld	a5,-24(s0)
    10c6:	4705                	li	a4,1
    10c8:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    10cc:	0007079b          	sext.w	a5,a4
    10d0:	fbed                	bnez	a5,10c2 <lock_acquire+0xc>

    ;
    }
     __sync_synchronize();
    10d2:	0ff0000f          	fence
        

}
    10d6:	0001                	nop
    10d8:	6462                	ld	s0,24(sp)
    10da:	6105                	addi	sp,sp,32
    10dc:	8082                	ret

00000000000010de <lock_release>:

void lock_release (lock_t *lock){
    10de:	1101                	addi	sp,sp,-32
    10e0:	ec22                	sd	s0,24(sp)
    10e2:	1000                	addi	s0,sp,32
    10e4:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
    10e8:	0ff0000f          	fence
    __sync_lock_release(lock);
    10ec:	fe843783          	ld	a5,-24(s0)
    10f0:	0f50000f          	fence	iorw,ow
    10f4:	0807a02f          	amoswap.w	zero,zero,(a5)
   
}
    10f8:	0001                	nop
    10fa:	6462                	ld	s0,24(sp)
    10fc:	6105                	addi	sp,sp,32
    10fe:	8082                	ret

0000000000001100 <lock_init>:

void lock_init (lock_t *lock){
    1100:	1101                	addi	sp,sp,-32
    1102:	ec22                	sd	s0,24(sp)
    1104:	1000                	addi	s0,sp,32
    1106:	fea43423          	sd	a0,-24(s0)
    lock = 0;
    110a:	fe043423          	sd	zero,-24(s0)
    
}
    110e:	0001                	nop
    1110:	6462                	ld	s0,24(sp)
    1112:	6105                	addi	sp,sp,32
    1114:	8082                	ret

0000000000001116 <cv_wait>:


void cv_wait (cont_t *cv, lock_t *lock){
    1116:	1101                	addi	sp,sp,-32
    1118:	ec06                	sd	ra,24(sp)
    111a:	e822                	sd	s0,16(sp)
    111c:	1000                	addi	s0,sp,32
    111e:	fea43423          	sd	a0,-24(s0)
    1122:	feb43023          	sd	a1,-32(s0)
    while( __sync_lock_test_and_set(cv, 0)!=1){
    1126:	a015                	j	114a <cv_wait+0x34>
        lock_release(lock);
    1128:	fe043503          	ld	a0,-32(s0)
    112c:	00000097          	auipc	ra,0x0
    1130:	fb2080e7          	jalr	-78(ra) # 10de <lock_release>
        sleep(1);
    1134:	4505                	li	a0,1
    1136:	fffff097          	auipc	ra,0xfffff
    113a:	6d2080e7          	jalr	1746(ra) # 808 <sleep>
        lock_acquire(lock);
    113e:	fe043503          	ld	a0,-32(s0)
    1142:	00000097          	auipc	ra,0x0
    1146:	f74080e7          	jalr	-140(ra) # 10b6 <lock_acquire>
    while( __sync_lock_test_and_set(cv, 0)!=1){
    114a:	fe843783          	ld	a5,-24(s0)
    114e:	4701                	li	a4,0
    1150:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    1154:	0007079b          	sext.w	a5,a4
    1158:	873e                	mv	a4,a5
    115a:	4785                	li	a5,1
    115c:	fcf716e3          	bne	a4,a5,1128 <cv_wait+0x12>
    }

     __sync_synchronize();
    1160:	0ff0000f          	fence

}
    1164:	0001                	nop
    1166:	60e2                	ld	ra,24(sp)
    1168:	6442                	ld	s0,16(sp)
    116a:	6105                	addi	sp,sp,32
    116c:	8082                	ret

000000000000116e <cv_signal>:


void cv_signal (cont_t *cv){
    116e:	1101                	addi	sp,sp,-32
    1170:	ec22                	sd	s0,24(sp)
    1172:	1000                	addi	s0,sp,32
    1174:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
    1178:	0ff0000f          	fence
     __sync_lock_test_and_set(cv, 1);
    117c:	fe843783          	ld	a5,-24(s0)
    1180:	4705                	li	a4,1
    1182:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)

}
    1186:	0001                	nop
    1188:	6462                	ld	s0,24(sp)
    118a:	6105                	addi	sp,sp,32
    118c:	8082                	ret

000000000000118e <cv_init>:


void cv_init (cont_t *cv){
    118e:	1101                	addi	sp,sp,-32
    1190:	ec22                	sd	s0,24(sp)
    1192:	1000                	addi	s0,sp,32
    1194:	fea43423          	sd	a0,-24(s0)
    cv = 0;
    1198:	fe043423          	sd	zero,-24(s0)
    119c:	0001                	nop
    119e:	6462                	ld	s0,24(sp)
    11a0:	6105                	addi	sp,sp,32
    11a2:	8082                	ret
