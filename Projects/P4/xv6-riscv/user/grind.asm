
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc22                	sd	s0,56(sp)
       4:	0080                	addi	s0,sp,64
       6:	fca43423          	sd	a0,-56(s0)
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       a:	fc843783          	ld	a5,-56(s0)
       e:	6398                	ld	a4,0(a5)
      10:	800007b7          	lui	a5,0x80000
      14:	ffe7c793          	xori	a5,a5,-2
      18:	02f777b3          	remu	a5,a4,a5
      1c:	0785                	addi	a5,a5,1
      1e:	fef43423          	sd	a5,-24(s0)
    hi = x / 127773;
      22:	fe843703          	ld	a4,-24(s0)
      26:	67fd                	lui	a5,0x1f
      28:	31d78793          	addi	a5,a5,797 # 1f31d <__global_pointer$+0x1cad5>
      2c:	02f747b3          	div	a5,a4,a5
      30:	fef43023          	sd	a5,-32(s0)
    lo = x % 127773;
      34:	fe843703          	ld	a4,-24(s0)
      38:	67fd                	lui	a5,0x1f
      3a:	31d78793          	addi	a5,a5,797 # 1f31d <__global_pointer$+0x1cad5>
      3e:	02f767b3          	rem	a5,a4,a5
      42:	fcf43c23          	sd	a5,-40(s0)
    x = 16807 * lo - 2836 * hi;
      46:	fd843703          	ld	a4,-40(s0)
      4a:	6791                	lui	a5,0x4
      4c:	1a778793          	addi	a5,a5,423 # 41a7 <__global_pointer$+0x195f>
      50:	02f70733          	mul	a4,a4,a5
      54:	fe043683          	ld	a3,-32(s0)
      58:	77fd                	lui	a5,0xfffff
      5a:	4ec78793          	addi	a5,a5,1260 # fffffffffffff4ec <__global_pointer$+0xffffffffffffcca4>
      5e:	02f687b3          	mul	a5,a3,a5
      62:	97ba                	add	a5,a5,a4
      64:	fef43423          	sd	a5,-24(s0)
    if (x < 0)
      68:	fe843783          	ld	a5,-24(s0)
      6c:	0007db63          	bgez	a5,82 <do_rand+0x82>
        x += 0x7fffffff;
      70:	fe843703          	ld	a4,-24(s0)
      74:	800007b7          	lui	a5,0x80000
      78:	fff7c793          	not	a5,a5
      7c:	97ba                	add	a5,a5,a4
      7e:	fef43423          	sd	a5,-24(s0)
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      82:	fe843783          	ld	a5,-24(s0)
      86:	17fd                	addi	a5,a5,-1
      88:	fef43423          	sd	a5,-24(s0)
    *ctx = x;
      8c:	fe843703          	ld	a4,-24(s0)
      90:	fc843783          	ld	a5,-56(s0)
      94:	e398                	sd	a4,0(a5)
    return (x);
      96:	fe843783          	ld	a5,-24(s0)
      9a:	2781                	sext.w	a5,a5
}
      9c:	853e                	mv	a0,a5
      9e:	7462                	ld	s0,56(sp)
      a0:	6121                	addi	sp,sp,64
      a2:	8082                	ret

00000000000000a4 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      a4:	1141                	addi	sp,sp,-16
      a6:	e406                	sd	ra,8(sp)
      a8:	e022                	sd	s0,0(sp)
      aa:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      ac:	00002517          	auipc	a0,0x2
      b0:	fb450513          	addi	a0,a0,-76 # 2060 <rand_next>
      b4:	00000097          	auipc	ra,0x0
      b8:	f4c080e7          	jalr	-180(ra) # 0 <do_rand>
      bc:	87aa                	mv	a5,a0
}
      be:	853e                	mv	a0,a5
      c0:	60a2                	ld	ra,8(sp)
      c2:	6402                	ld	s0,0(sp)
      c4:	0141                	addi	sp,sp,16
      c6:	8082                	ret

00000000000000c8 <go>:

void
go(int which_child)
{
      c8:	7155                	addi	sp,sp,-208
      ca:	e586                	sd	ra,200(sp)
      cc:	e1a2                	sd	s0,192(sp)
      ce:	0980                	addi	s0,sp,208
      d0:	87aa                	mv	a5,a0
      d2:	f2f42e23          	sw	a5,-196(s0)
  int fd = -1;
      d6:	57fd                	li	a5,-1
      d8:	fef42623          	sw	a5,-20(s0)
  static char buf[999];
  char *break0 = sbrk(0);
      dc:	4501                	li	a0,0
      de:	00001097          	auipc	ra,0x1
      e2:	30e080e7          	jalr	782(ra) # 13ec <sbrk>
      e6:	fca43c23          	sd	a0,-40(s0)
  uint64 iters = 0;
      ea:	fe043023          	sd	zero,-32(s0)

  mkdir("grindir");
      ee:	00002517          	auipc	a0,0x2
      f2:	c0250513          	addi	a0,a0,-1022 # 1cf0 <lock_init+0x1c>
      f6:	00001097          	auipc	ra,0x1
      fa:	2d6080e7          	jalr	726(ra) # 13cc <mkdir>
  if(chdir("grindir") != 0){
      fe:	00002517          	auipc	a0,0x2
     102:	bf250513          	addi	a0,a0,-1038 # 1cf0 <lock_init+0x1c>
     106:	00001097          	auipc	ra,0x1
     10a:	2ce080e7          	jalr	718(ra) # 13d4 <chdir>
     10e:	87aa                	mv	a5,a0
     110:	cf91                	beqz	a5,12c <go+0x64>
    printf("grind: chdir grindir failed\n");
     112:	00002517          	auipc	a0,0x2
     116:	be650513          	addi	a0,a0,-1050 # 1cf8 <lock_init+0x24>
     11a:	00001097          	auipc	ra,0x1
     11e:	782080e7          	jalr	1922(ra) # 189c <printf>
    exit(1);
     122:	4505                	li	a0,1
     124:	00001097          	auipc	ra,0x1
     128:	240080e7          	jalr	576(ra) # 1364 <exit>
  }
  chdir("/");
     12c:	00002517          	auipc	a0,0x2
     130:	bec50513          	addi	a0,a0,-1044 # 1d18 <lock_init+0x44>
     134:	00001097          	auipc	ra,0x1
     138:	2a0080e7          	jalr	672(ra) # 13d4 <chdir>
  
  while(1){
    iters++;
     13c:	fe043783          	ld	a5,-32(s0)
     140:	0785                	addi	a5,a5,1
     142:	fef43023          	sd	a5,-32(s0)
    if((iters % 500) == 0)
     146:	fe043703          	ld	a4,-32(s0)
     14a:	1f400793          	li	a5,500
     14e:	02f777b3          	remu	a5,a4,a5
     152:	e78d                	bnez	a5,17c <go+0xb4>
      write(1, which_child?"B":"A", 1);
     154:	f3c42783          	lw	a5,-196(s0)
     158:	2781                	sext.w	a5,a5
     15a:	c791                	beqz	a5,166 <go+0x9e>
     15c:	00002797          	auipc	a5,0x2
     160:	bc478793          	addi	a5,a5,-1084 # 1d20 <lock_init+0x4c>
     164:	a029                	j	16e <go+0xa6>
     166:	00002797          	auipc	a5,0x2
     16a:	bc278793          	addi	a5,a5,-1086 # 1d28 <lock_init+0x54>
     16e:	4605                	li	a2,1
     170:	85be                	mv	a1,a5
     172:	4505                	li	a0,1
     174:	00001097          	auipc	ra,0x1
     178:	210080e7          	jalr	528(ra) # 1384 <write>
    int what = rand() % 23;
     17c:	00000097          	auipc	ra,0x0
     180:	f28080e7          	jalr	-216(ra) # a4 <rand>
     184:	87aa                	mv	a5,a0
     186:	873e                	mv	a4,a5
     188:	47dd                	li	a5,23
     18a:	02f767bb          	remw	a5,a4,a5
     18e:	fcf42a23          	sw	a5,-44(s0)
    if(what == 1){
     192:	fd442783          	lw	a5,-44(s0)
     196:	0007871b          	sext.w	a4,a5
     19a:	4785                	li	a5,1
     19c:	02f71363          	bne	a4,a5,1c2 <go+0xfa>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     1a0:	20200593          	li	a1,514
     1a4:	00002517          	auipc	a0,0x2
     1a8:	b8c50513          	addi	a0,a0,-1140 # 1d30 <lock_init+0x5c>
     1ac:	00001097          	auipc	ra,0x1
     1b0:	1f8080e7          	jalr	504(ra) # 13a4 <open>
     1b4:	87aa                	mv	a5,a0
     1b6:	853e                	mv	a0,a5
     1b8:	00001097          	auipc	ra,0x1
     1bc:	1d4080e7          	jalr	468(ra) # 138c <close>
     1c0:	bfb5                	j	13c <go+0x74>
    } else if(what == 2){
     1c2:	fd442783          	lw	a5,-44(s0)
     1c6:	0007871b          	sext.w	a4,a5
     1ca:	4789                	li	a5,2
     1cc:	02f71363          	bne	a4,a5,1f2 <go+0x12a>
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     1d0:	20200593          	li	a1,514
     1d4:	00002517          	auipc	a0,0x2
     1d8:	b6c50513          	addi	a0,a0,-1172 # 1d40 <lock_init+0x6c>
     1dc:	00001097          	auipc	ra,0x1
     1e0:	1c8080e7          	jalr	456(ra) # 13a4 <open>
     1e4:	87aa                	mv	a5,a0
     1e6:	853e                	mv	a0,a5
     1e8:	00001097          	auipc	ra,0x1
     1ec:	1a4080e7          	jalr	420(ra) # 138c <close>
     1f0:	b7b1                	j	13c <go+0x74>
    } else if(what == 3){
     1f2:	fd442783          	lw	a5,-44(s0)
     1f6:	0007871b          	sext.w	a4,a5
     1fa:	478d                	li	a5,3
     1fc:	00f71b63          	bne	a4,a5,212 <go+0x14a>
      unlink("grindir/../a");
     200:	00002517          	auipc	a0,0x2
     204:	b3050513          	addi	a0,a0,-1232 # 1d30 <lock_init+0x5c>
     208:	00001097          	auipc	ra,0x1
     20c:	1ac080e7          	jalr	428(ra) # 13b4 <unlink>
     210:	b735                	j	13c <go+0x74>
    } else if(what == 4){
     212:	fd442783          	lw	a5,-44(s0)
     216:	0007871b          	sext.w	a4,a5
     21a:	4791                	li	a5,4
     21c:	04f71a63          	bne	a4,a5,270 <go+0x1a8>
      if(chdir("grindir") != 0){
     220:	00002517          	auipc	a0,0x2
     224:	ad050513          	addi	a0,a0,-1328 # 1cf0 <lock_init+0x1c>
     228:	00001097          	auipc	ra,0x1
     22c:	1ac080e7          	jalr	428(ra) # 13d4 <chdir>
     230:	87aa                	mv	a5,a0
     232:	cf91                	beqz	a5,24e <go+0x186>
        printf("grind: chdir grindir failed\n");
     234:	00002517          	auipc	a0,0x2
     238:	ac450513          	addi	a0,a0,-1340 # 1cf8 <lock_init+0x24>
     23c:	00001097          	auipc	ra,0x1
     240:	660080e7          	jalr	1632(ra) # 189c <printf>
        exit(1);
     244:	4505                	li	a0,1
     246:	00001097          	auipc	ra,0x1
     24a:	11e080e7          	jalr	286(ra) # 1364 <exit>
      }
      unlink("../b");
     24e:	00002517          	auipc	a0,0x2
     252:	b0a50513          	addi	a0,a0,-1270 # 1d58 <lock_init+0x84>
     256:	00001097          	auipc	ra,0x1
     25a:	15e080e7          	jalr	350(ra) # 13b4 <unlink>
      chdir("/");
     25e:	00002517          	auipc	a0,0x2
     262:	aba50513          	addi	a0,a0,-1350 # 1d18 <lock_init+0x44>
     266:	00001097          	auipc	ra,0x1
     26a:	16e080e7          	jalr	366(ra) # 13d4 <chdir>
     26e:	b5f9                	j	13c <go+0x74>
    } else if(what == 5){
     270:	fd442783          	lw	a5,-44(s0)
     274:	0007871b          	sext.w	a4,a5
     278:	4795                	li	a5,5
     27a:	02f71763          	bne	a4,a5,2a8 <go+0x1e0>
      close(fd);
     27e:	fec42783          	lw	a5,-20(s0)
     282:	853e                	mv	a0,a5
     284:	00001097          	auipc	ra,0x1
     288:	108080e7          	jalr	264(ra) # 138c <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     28c:	20200593          	li	a1,514
     290:	00002517          	auipc	a0,0x2
     294:	ad050513          	addi	a0,a0,-1328 # 1d60 <lock_init+0x8c>
     298:	00001097          	auipc	ra,0x1
     29c:	10c080e7          	jalr	268(ra) # 13a4 <open>
     2a0:	87aa                	mv	a5,a0
     2a2:	fef42623          	sw	a5,-20(s0)
     2a6:	bd59                	j	13c <go+0x74>
    } else if(what == 6){
     2a8:	fd442783          	lw	a5,-44(s0)
     2ac:	0007871b          	sext.w	a4,a5
     2b0:	4799                	li	a5,6
     2b2:	02f71763          	bne	a4,a5,2e0 <go+0x218>
      close(fd);
     2b6:	fec42783          	lw	a5,-20(s0)
     2ba:	853e                	mv	a0,a5
     2bc:	00001097          	auipc	ra,0x1
     2c0:	0d0080e7          	jalr	208(ra) # 138c <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     2c4:	20200593          	li	a1,514
     2c8:	00002517          	auipc	a0,0x2
     2cc:	aa850513          	addi	a0,a0,-1368 # 1d70 <lock_init+0x9c>
     2d0:	00001097          	auipc	ra,0x1
     2d4:	0d4080e7          	jalr	212(ra) # 13a4 <open>
     2d8:	87aa                	mv	a5,a0
     2da:	fef42623          	sw	a5,-20(s0)
     2de:	bdb9                	j	13c <go+0x74>
    } else if(what == 7){
     2e0:	fd442783          	lw	a5,-44(s0)
     2e4:	0007871b          	sext.w	a4,a5
     2e8:	479d                	li	a5,7
     2ea:	02f71063          	bne	a4,a5,30a <go+0x242>
      write(fd, buf, sizeof(buf));
     2ee:	fec42783          	lw	a5,-20(s0)
     2f2:	3e700613          	li	a2,999
     2f6:	00002597          	auipc	a1,0x2
     2fa:	d7258593          	addi	a1,a1,-654 # 2068 <buf.0>
     2fe:	853e                	mv	a0,a5
     300:	00001097          	auipc	ra,0x1
     304:	084080e7          	jalr	132(ra) # 1384 <write>
     308:	bd15                	j	13c <go+0x74>
    } else if(what == 8){
     30a:	fd442783          	lw	a5,-44(s0)
     30e:	0007871b          	sext.w	a4,a5
     312:	47a1                	li	a5,8
     314:	02f71063          	bne	a4,a5,334 <go+0x26c>
      read(fd, buf, sizeof(buf));
     318:	fec42783          	lw	a5,-20(s0)
     31c:	3e700613          	li	a2,999
     320:	00002597          	auipc	a1,0x2
     324:	d4858593          	addi	a1,a1,-696 # 2068 <buf.0>
     328:	853e                	mv	a0,a5
     32a:	00001097          	auipc	ra,0x1
     32e:	052080e7          	jalr	82(ra) # 137c <read>
     332:	b529                	j	13c <go+0x74>
    } else if(what == 9){
     334:	fd442783          	lw	a5,-44(s0)
     338:	0007871b          	sext.w	a4,a5
     33c:	47a5                	li	a5,9
     33e:	04f71363          	bne	a4,a5,384 <go+0x2bc>
      mkdir("grindir/../a");
     342:	00002517          	auipc	a0,0x2
     346:	9ee50513          	addi	a0,a0,-1554 # 1d30 <lock_init+0x5c>
     34a:	00001097          	auipc	ra,0x1
     34e:	082080e7          	jalr	130(ra) # 13cc <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     352:	20200593          	li	a1,514
     356:	00002517          	auipc	a0,0x2
     35a:	a3250513          	addi	a0,a0,-1486 # 1d88 <lock_init+0xb4>
     35e:	00001097          	auipc	ra,0x1
     362:	046080e7          	jalr	70(ra) # 13a4 <open>
     366:	87aa                	mv	a5,a0
     368:	853e                	mv	a0,a5
     36a:	00001097          	auipc	ra,0x1
     36e:	022080e7          	jalr	34(ra) # 138c <close>
      unlink("a/a");
     372:	00002517          	auipc	a0,0x2
     376:	a2650513          	addi	a0,a0,-1498 # 1d98 <lock_init+0xc4>
     37a:	00001097          	auipc	ra,0x1
     37e:	03a080e7          	jalr	58(ra) # 13b4 <unlink>
     382:	bb6d                	j	13c <go+0x74>
    } else if(what == 10){
     384:	fd442783          	lw	a5,-44(s0)
     388:	0007871b          	sext.w	a4,a5
     38c:	47a9                	li	a5,10
     38e:	04f71363          	bne	a4,a5,3d4 <go+0x30c>
      mkdir("/../b");
     392:	00002517          	auipc	a0,0x2
     396:	a0e50513          	addi	a0,a0,-1522 # 1da0 <lock_init+0xcc>
     39a:	00001097          	auipc	ra,0x1
     39e:	032080e7          	jalr	50(ra) # 13cc <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     3a2:	20200593          	li	a1,514
     3a6:	00002517          	auipc	a0,0x2
     3aa:	a0250513          	addi	a0,a0,-1534 # 1da8 <lock_init+0xd4>
     3ae:	00001097          	auipc	ra,0x1
     3b2:	ff6080e7          	jalr	-10(ra) # 13a4 <open>
     3b6:	87aa                	mv	a5,a0
     3b8:	853e                	mv	a0,a5
     3ba:	00001097          	auipc	ra,0x1
     3be:	fd2080e7          	jalr	-46(ra) # 138c <close>
      unlink("b/b");
     3c2:	00002517          	auipc	a0,0x2
     3c6:	9f650513          	addi	a0,a0,-1546 # 1db8 <lock_init+0xe4>
     3ca:	00001097          	auipc	ra,0x1
     3ce:	fea080e7          	jalr	-22(ra) # 13b4 <unlink>
     3d2:	b3ad                	j	13c <go+0x74>
    } else if(what == 11){
     3d4:	fd442783          	lw	a5,-44(s0)
     3d8:	0007871b          	sext.w	a4,a5
     3dc:	47ad                	li	a5,11
     3de:	02f71763          	bne	a4,a5,40c <go+0x344>
      unlink("b");
     3e2:	00002517          	auipc	a0,0x2
     3e6:	9de50513          	addi	a0,a0,-1570 # 1dc0 <lock_init+0xec>
     3ea:	00001097          	auipc	ra,0x1
     3ee:	fca080e7          	jalr	-54(ra) # 13b4 <unlink>
      link("../grindir/./../a", "../b");
     3f2:	00002597          	auipc	a1,0x2
     3f6:	96658593          	addi	a1,a1,-1690 # 1d58 <lock_init+0x84>
     3fa:	00002517          	auipc	a0,0x2
     3fe:	9ce50513          	addi	a0,a0,-1586 # 1dc8 <lock_init+0xf4>
     402:	00001097          	auipc	ra,0x1
     406:	fc2080e7          	jalr	-62(ra) # 13c4 <link>
     40a:	bb0d                	j	13c <go+0x74>
    } else if(what == 12){
     40c:	fd442783          	lw	a5,-44(s0)
     410:	0007871b          	sext.w	a4,a5
     414:	47b1                	li	a5,12
     416:	02f71763          	bne	a4,a5,444 <go+0x37c>
      unlink("../grindir/../a");
     41a:	00002517          	auipc	a0,0x2
     41e:	9c650513          	addi	a0,a0,-1594 # 1de0 <lock_init+0x10c>
     422:	00001097          	auipc	ra,0x1
     426:	f92080e7          	jalr	-110(ra) # 13b4 <unlink>
      link(".././b", "/grindir/../a");
     42a:	00002597          	auipc	a1,0x2
     42e:	93658593          	addi	a1,a1,-1738 # 1d60 <lock_init+0x8c>
     432:	00002517          	auipc	a0,0x2
     436:	9be50513          	addi	a0,a0,-1602 # 1df0 <lock_init+0x11c>
     43a:	00001097          	auipc	ra,0x1
     43e:	f8a080e7          	jalr	-118(ra) # 13c4 <link>
     442:	b9ed                	j	13c <go+0x74>
    } else if(what == 13){
     444:	fd442783          	lw	a5,-44(s0)
     448:	0007871b          	sext.w	a4,a5
     44c:	47b5                	li	a5,13
     44e:	04f71a63          	bne	a4,a5,4a2 <go+0x3da>
      int pid = fork();
     452:	00001097          	auipc	ra,0x1
     456:	f0a080e7          	jalr	-246(ra) # 135c <fork>
     45a:	87aa                	mv	a5,a0
     45c:	faf42823          	sw	a5,-80(s0)
      if(pid == 0){
     460:	fb042783          	lw	a5,-80(s0)
     464:	2781                	sext.w	a5,a5
     466:	e791                	bnez	a5,472 <go+0x3aa>
        exit(0);
     468:	4501                	li	a0,0
     46a:	00001097          	auipc	ra,0x1
     46e:	efa080e7          	jalr	-262(ra) # 1364 <exit>
      } else if(pid < 0){
     472:	fb042783          	lw	a5,-80(s0)
     476:	2781                	sext.w	a5,a5
     478:	0007df63          	bgez	a5,496 <go+0x3ce>
        printf("grind: fork failed\n");
     47c:	00002517          	auipc	a0,0x2
     480:	97c50513          	addi	a0,a0,-1668 # 1df8 <lock_init+0x124>
     484:	00001097          	auipc	ra,0x1
     488:	418080e7          	jalr	1048(ra) # 189c <printf>
        exit(1);
     48c:	4505                	li	a0,1
     48e:	00001097          	auipc	ra,0x1
     492:	ed6080e7          	jalr	-298(ra) # 1364 <exit>
      }
      wait(0);
     496:	4501                	li	a0,0
     498:	00001097          	auipc	ra,0x1
     49c:	ed4080e7          	jalr	-300(ra) # 136c <wait>
     4a0:	b971                	j	13c <go+0x74>
    } else if(what == 14){
     4a2:	fd442783          	lw	a5,-44(s0)
     4a6:	0007871b          	sext.w	a4,a5
     4aa:	47b9                	li	a5,14
     4ac:	06f71263          	bne	a4,a5,510 <go+0x448>
      int pid = fork();
     4b0:	00001097          	auipc	ra,0x1
     4b4:	eac080e7          	jalr	-340(ra) # 135c <fork>
     4b8:	87aa                	mv	a5,a0
     4ba:	faf42a23          	sw	a5,-76(s0)
      if(pid == 0){
     4be:	fb442783          	lw	a5,-76(s0)
     4c2:	2781                	sext.w	a5,a5
     4c4:	ef91                	bnez	a5,4e0 <go+0x418>
        fork();
     4c6:	00001097          	auipc	ra,0x1
     4ca:	e96080e7          	jalr	-362(ra) # 135c <fork>
        fork();
     4ce:	00001097          	auipc	ra,0x1
     4d2:	e8e080e7          	jalr	-370(ra) # 135c <fork>
        exit(0);
     4d6:	4501                	li	a0,0
     4d8:	00001097          	auipc	ra,0x1
     4dc:	e8c080e7          	jalr	-372(ra) # 1364 <exit>
      } else if(pid < 0){
     4e0:	fb442783          	lw	a5,-76(s0)
     4e4:	2781                	sext.w	a5,a5
     4e6:	0007df63          	bgez	a5,504 <go+0x43c>
        printf("grind: fork failed\n");
     4ea:	00002517          	auipc	a0,0x2
     4ee:	90e50513          	addi	a0,a0,-1778 # 1df8 <lock_init+0x124>
     4f2:	00001097          	auipc	ra,0x1
     4f6:	3aa080e7          	jalr	938(ra) # 189c <printf>
        exit(1);
     4fa:	4505                	li	a0,1
     4fc:	00001097          	auipc	ra,0x1
     500:	e68080e7          	jalr	-408(ra) # 1364 <exit>
      }
      wait(0);
     504:	4501                	li	a0,0
     506:	00001097          	auipc	ra,0x1
     50a:	e66080e7          	jalr	-410(ra) # 136c <wait>
     50e:	b13d                	j	13c <go+0x74>
    } else if(what == 15){
     510:	fd442783          	lw	a5,-44(s0)
     514:	0007871b          	sext.w	a4,a5
     518:	47bd                	li	a5,15
     51a:	00f71a63          	bne	a4,a5,52e <go+0x466>
      sbrk(6011);
     51e:	6785                	lui	a5,0x1
     520:	77b78513          	addi	a0,a5,1915 # 177b <vprintf+0x19d>
     524:	00001097          	auipc	ra,0x1
     528:	ec8080e7          	jalr	-312(ra) # 13ec <sbrk>
     52c:	b901                	j	13c <go+0x74>
    } else if(what == 16){
     52e:	fd442783          	lw	a5,-44(s0)
     532:	0007871b          	sext.w	a4,a5
     536:	47c1                	li	a5,16
     538:	02f71c63          	bne	a4,a5,570 <go+0x4a8>
      if(sbrk(0) > break0)
     53c:	4501                	li	a0,0
     53e:	00001097          	auipc	ra,0x1
     542:	eae080e7          	jalr	-338(ra) # 13ec <sbrk>
     546:	872a                	mv	a4,a0
     548:	fd843783          	ld	a5,-40(s0)
     54c:	bee7f8e3          	bgeu	a5,a4,13c <go+0x74>
        sbrk(-(sbrk(0) - break0));
     550:	4501                	li	a0,0
     552:	00001097          	auipc	ra,0x1
     556:	e9a080e7          	jalr	-358(ra) # 13ec <sbrk>
     55a:	872a                	mv	a4,a0
     55c:	fd843783          	ld	a5,-40(s0)
     560:	8f99                	sub	a5,a5,a4
     562:	2781                	sext.w	a5,a5
     564:	853e                	mv	a0,a5
     566:	00001097          	auipc	ra,0x1
     56a:	e86080e7          	jalr	-378(ra) # 13ec <sbrk>
     56e:	b6f9                	j	13c <go+0x74>
    } else if(what == 17){
     570:	fd442783          	lw	a5,-44(s0)
     574:	0007871b          	sext.w	a4,a5
     578:	47c5                	li	a5,17
     57a:	0af71863          	bne	a4,a5,62a <go+0x562>
      int pid = fork();
     57e:	00001097          	auipc	ra,0x1
     582:	dde080e7          	jalr	-546(ra) # 135c <fork>
     586:	87aa                	mv	a5,a0
     588:	faf42c23          	sw	a5,-72(s0)
      if(pid == 0){
     58c:	fb842783          	lw	a5,-72(s0)
     590:	2781                	sext.w	a5,a5
     592:	e795                	bnez	a5,5be <go+0x4f6>
        close(open("a", O_CREATE|O_RDWR));
     594:	20200593          	li	a1,514
     598:	00002517          	auipc	a0,0x2
     59c:	87850513          	addi	a0,a0,-1928 # 1e10 <lock_init+0x13c>
     5a0:	00001097          	auipc	ra,0x1
     5a4:	e04080e7          	jalr	-508(ra) # 13a4 <open>
     5a8:	87aa                	mv	a5,a0
     5aa:	853e                	mv	a0,a5
     5ac:	00001097          	auipc	ra,0x1
     5b0:	de0080e7          	jalr	-544(ra) # 138c <close>
        exit(0);
     5b4:	4501                	li	a0,0
     5b6:	00001097          	auipc	ra,0x1
     5ba:	dae080e7          	jalr	-594(ra) # 1364 <exit>
      } else if(pid < 0){
     5be:	fb842783          	lw	a5,-72(s0)
     5c2:	2781                	sext.w	a5,a5
     5c4:	0007df63          	bgez	a5,5e2 <go+0x51a>
        printf("grind: fork failed\n");
     5c8:	00002517          	auipc	a0,0x2
     5cc:	83050513          	addi	a0,a0,-2000 # 1df8 <lock_init+0x124>
     5d0:	00001097          	auipc	ra,0x1
     5d4:	2cc080e7          	jalr	716(ra) # 189c <printf>
        exit(1);
     5d8:	4505                	li	a0,1
     5da:	00001097          	auipc	ra,0x1
     5de:	d8a080e7          	jalr	-630(ra) # 1364 <exit>
      }
      if(chdir("../grindir/..") != 0){
     5e2:	00002517          	auipc	a0,0x2
     5e6:	83650513          	addi	a0,a0,-1994 # 1e18 <lock_init+0x144>
     5ea:	00001097          	auipc	ra,0x1
     5ee:	dea080e7          	jalr	-534(ra) # 13d4 <chdir>
     5f2:	87aa                	mv	a5,a0
     5f4:	cf91                	beqz	a5,610 <go+0x548>
        printf("grind: chdir failed\n");
     5f6:	00002517          	auipc	a0,0x2
     5fa:	83250513          	addi	a0,a0,-1998 # 1e28 <lock_init+0x154>
     5fe:	00001097          	auipc	ra,0x1
     602:	29e080e7          	jalr	670(ra) # 189c <printf>
        exit(1);
     606:	4505                	li	a0,1
     608:	00001097          	auipc	ra,0x1
     60c:	d5c080e7          	jalr	-676(ra) # 1364 <exit>
      }
      kill(pid);
     610:	fb842783          	lw	a5,-72(s0)
     614:	853e                	mv	a0,a5
     616:	00001097          	auipc	ra,0x1
     61a:	d7e080e7          	jalr	-642(ra) # 1394 <kill>
      wait(0);
     61e:	4501                	li	a0,0
     620:	00001097          	auipc	ra,0x1
     624:	d4c080e7          	jalr	-692(ra) # 136c <wait>
     628:	be11                	j	13c <go+0x74>
    } else if(what == 18){
     62a:	fd442783          	lw	a5,-44(s0)
     62e:	0007871b          	sext.w	a4,a5
     632:	47c9                	li	a5,18
     634:	06f71463          	bne	a4,a5,69c <go+0x5d4>
      int pid = fork();
     638:	00001097          	auipc	ra,0x1
     63c:	d24080e7          	jalr	-732(ra) # 135c <fork>
     640:	87aa                	mv	a5,a0
     642:	faf42e23          	sw	a5,-68(s0)
      if(pid == 0){
     646:	fbc42783          	lw	a5,-68(s0)
     64a:	2781                	sext.w	a5,a5
     64c:	e385                	bnez	a5,66c <go+0x5a4>
        kill(getpid());
     64e:	00001097          	auipc	ra,0x1
     652:	d96080e7          	jalr	-618(ra) # 13e4 <getpid>
     656:	87aa                	mv	a5,a0
     658:	853e                	mv	a0,a5
     65a:	00001097          	auipc	ra,0x1
     65e:	d3a080e7          	jalr	-710(ra) # 1394 <kill>
        exit(0);
     662:	4501                	li	a0,0
     664:	00001097          	auipc	ra,0x1
     668:	d00080e7          	jalr	-768(ra) # 1364 <exit>
      } else if(pid < 0){
     66c:	fbc42783          	lw	a5,-68(s0)
     670:	2781                	sext.w	a5,a5
     672:	0007df63          	bgez	a5,690 <go+0x5c8>
        printf("grind: fork failed\n");
     676:	00001517          	auipc	a0,0x1
     67a:	78250513          	addi	a0,a0,1922 # 1df8 <lock_init+0x124>
     67e:	00001097          	auipc	ra,0x1
     682:	21e080e7          	jalr	542(ra) # 189c <printf>
        exit(1);
     686:	4505                	li	a0,1
     688:	00001097          	auipc	ra,0x1
     68c:	cdc080e7          	jalr	-804(ra) # 1364 <exit>
      }
      wait(0);
     690:	4501                	li	a0,0
     692:	00001097          	auipc	ra,0x1
     696:	cda080e7          	jalr	-806(ra) # 136c <wait>
     69a:	b44d                	j	13c <go+0x74>
    } else if(what == 19){
     69c:	fd442783          	lw	a5,-44(s0)
     6a0:	0007871b          	sext.w	a4,a5
     6a4:	47cd                	li	a5,19
     6a6:	10f71863          	bne	a4,a5,7b6 <go+0x6ee>
      int fds[2];
      if(pipe(fds) < 0){
     6aa:	fa840793          	addi	a5,s0,-88
     6ae:	853e                	mv	a0,a5
     6b0:	00001097          	auipc	ra,0x1
     6b4:	cc4080e7          	jalr	-828(ra) # 1374 <pipe>
     6b8:	87aa                	mv	a5,a0
     6ba:	0007df63          	bgez	a5,6d8 <go+0x610>
        printf("grind: pipe failed\n");
     6be:	00001517          	auipc	a0,0x1
     6c2:	78250513          	addi	a0,a0,1922 # 1e40 <lock_init+0x16c>
     6c6:	00001097          	auipc	ra,0x1
     6ca:	1d6080e7          	jalr	470(ra) # 189c <printf>
        exit(1);
     6ce:	4505                	li	a0,1
     6d0:	00001097          	auipc	ra,0x1
     6d4:	c94080e7          	jalr	-876(ra) # 1364 <exit>
      }
      int pid = fork();
     6d8:	00001097          	auipc	ra,0x1
     6dc:	c84080e7          	jalr	-892(ra) # 135c <fork>
     6e0:	87aa                	mv	a5,a0
     6e2:	fcf42023          	sw	a5,-64(s0)
      if(pid == 0){
     6e6:	fc042783          	lw	a5,-64(s0)
     6ea:	2781                	sext.w	a5,a5
     6ec:	efbd                	bnez	a5,76a <go+0x6a2>
        fork();
     6ee:	00001097          	auipc	ra,0x1
     6f2:	c6e080e7          	jalr	-914(ra) # 135c <fork>
        fork();
     6f6:	00001097          	auipc	ra,0x1
     6fa:	c66080e7          	jalr	-922(ra) # 135c <fork>
        if(write(fds[1], "x", 1) != 1)
     6fe:	fac42783          	lw	a5,-84(s0)
     702:	4605                	li	a2,1
     704:	00001597          	auipc	a1,0x1
     708:	75458593          	addi	a1,a1,1876 # 1e58 <lock_init+0x184>
     70c:	853e                	mv	a0,a5
     70e:	00001097          	auipc	ra,0x1
     712:	c76080e7          	jalr	-906(ra) # 1384 <write>
     716:	87aa                	mv	a5,a0
     718:	873e                	mv	a4,a5
     71a:	4785                	li	a5,1
     71c:	00f70a63          	beq	a4,a5,730 <go+0x668>
          printf("grind: pipe write failed\n");
     720:	00001517          	auipc	a0,0x1
     724:	74050513          	addi	a0,a0,1856 # 1e60 <lock_init+0x18c>
     728:	00001097          	auipc	ra,0x1
     72c:	174080e7          	jalr	372(ra) # 189c <printf>
        char c;
        if(read(fds[0], &c, 1) != 1)
     730:	fa842783          	lw	a5,-88(s0)
     734:	fa740713          	addi	a4,s0,-89
     738:	4605                	li	a2,1
     73a:	85ba                	mv	a1,a4
     73c:	853e                	mv	a0,a5
     73e:	00001097          	auipc	ra,0x1
     742:	c3e080e7          	jalr	-962(ra) # 137c <read>
     746:	87aa                	mv	a5,a0
     748:	873e                	mv	a4,a5
     74a:	4785                	li	a5,1
     74c:	00f70a63          	beq	a4,a5,760 <go+0x698>
          printf("grind: pipe read failed\n");
     750:	00001517          	auipc	a0,0x1
     754:	73050513          	addi	a0,a0,1840 # 1e80 <lock_init+0x1ac>
     758:	00001097          	auipc	ra,0x1
     75c:	144080e7          	jalr	324(ra) # 189c <printf>
        exit(0);
     760:	4501                	li	a0,0
     762:	00001097          	auipc	ra,0x1
     766:	c02080e7          	jalr	-1022(ra) # 1364 <exit>
      } else if(pid < 0){
     76a:	fc042783          	lw	a5,-64(s0)
     76e:	2781                	sext.w	a5,a5
     770:	0007df63          	bgez	a5,78e <go+0x6c6>
        printf("grind: fork failed\n");
     774:	00001517          	auipc	a0,0x1
     778:	68450513          	addi	a0,a0,1668 # 1df8 <lock_init+0x124>
     77c:	00001097          	auipc	ra,0x1
     780:	120080e7          	jalr	288(ra) # 189c <printf>
        exit(1);
     784:	4505                	li	a0,1
     786:	00001097          	auipc	ra,0x1
     78a:	bde080e7          	jalr	-1058(ra) # 1364 <exit>
      }
      close(fds[0]);
     78e:	fa842783          	lw	a5,-88(s0)
     792:	853e                	mv	a0,a5
     794:	00001097          	auipc	ra,0x1
     798:	bf8080e7          	jalr	-1032(ra) # 138c <close>
      close(fds[1]);
     79c:	fac42783          	lw	a5,-84(s0)
     7a0:	853e                	mv	a0,a5
     7a2:	00001097          	auipc	ra,0x1
     7a6:	bea080e7          	jalr	-1046(ra) # 138c <close>
      wait(0);
     7aa:	4501                	li	a0,0
     7ac:	00001097          	auipc	ra,0x1
     7b0:	bc0080e7          	jalr	-1088(ra) # 136c <wait>
     7b4:	b261                	j	13c <go+0x74>
    } else if(what == 20){
     7b6:	fd442783          	lw	a5,-44(s0)
     7ba:	0007871b          	sext.w	a4,a5
     7be:	47d1                	li	a5,20
     7c0:	0af71f63          	bne	a4,a5,87e <go+0x7b6>
      int pid = fork();
     7c4:	00001097          	auipc	ra,0x1
     7c8:	b98080e7          	jalr	-1128(ra) # 135c <fork>
     7cc:	87aa                	mv	a5,a0
     7ce:	fcf42223          	sw	a5,-60(s0)
      if(pid == 0){
     7d2:	fc442783          	lw	a5,-60(s0)
     7d6:	2781                	sext.w	a5,a5
     7d8:	ebbd                	bnez	a5,84e <go+0x786>
        unlink("a");
     7da:	00001517          	auipc	a0,0x1
     7de:	63650513          	addi	a0,a0,1590 # 1e10 <lock_init+0x13c>
     7e2:	00001097          	auipc	ra,0x1
     7e6:	bd2080e7          	jalr	-1070(ra) # 13b4 <unlink>
        mkdir("a");
     7ea:	00001517          	auipc	a0,0x1
     7ee:	62650513          	addi	a0,a0,1574 # 1e10 <lock_init+0x13c>
     7f2:	00001097          	auipc	ra,0x1
     7f6:	bda080e7          	jalr	-1062(ra) # 13cc <mkdir>
        chdir("a");
     7fa:	00001517          	auipc	a0,0x1
     7fe:	61650513          	addi	a0,a0,1558 # 1e10 <lock_init+0x13c>
     802:	00001097          	auipc	ra,0x1
     806:	bd2080e7          	jalr	-1070(ra) # 13d4 <chdir>
        unlink("../a");
     80a:	00001517          	auipc	a0,0x1
     80e:	69650513          	addi	a0,a0,1686 # 1ea0 <lock_init+0x1cc>
     812:	00001097          	auipc	ra,0x1
     816:	ba2080e7          	jalr	-1118(ra) # 13b4 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     81a:	20200593          	li	a1,514
     81e:	00001517          	auipc	a0,0x1
     822:	63a50513          	addi	a0,a0,1594 # 1e58 <lock_init+0x184>
     826:	00001097          	auipc	ra,0x1
     82a:	b7e080e7          	jalr	-1154(ra) # 13a4 <open>
     82e:	87aa                	mv	a5,a0
     830:	fef42623          	sw	a5,-20(s0)
        unlink("x");
     834:	00001517          	auipc	a0,0x1
     838:	62450513          	addi	a0,a0,1572 # 1e58 <lock_init+0x184>
     83c:	00001097          	auipc	ra,0x1
     840:	b78080e7          	jalr	-1160(ra) # 13b4 <unlink>
        exit(0);
     844:	4501                	li	a0,0
     846:	00001097          	auipc	ra,0x1
     84a:	b1e080e7          	jalr	-1250(ra) # 1364 <exit>
      } else if(pid < 0){
     84e:	fc442783          	lw	a5,-60(s0)
     852:	2781                	sext.w	a5,a5
     854:	0007df63          	bgez	a5,872 <go+0x7aa>
        printf("grind: fork failed\n");
     858:	00001517          	auipc	a0,0x1
     85c:	5a050513          	addi	a0,a0,1440 # 1df8 <lock_init+0x124>
     860:	00001097          	auipc	ra,0x1
     864:	03c080e7          	jalr	60(ra) # 189c <printf>
        exit(1);
     868:	4505                	li	a0,1
     86a:	00001097          	auipc	ra,0x1
     86e:	afa080e7          	jalr	-1286(ra) # 1364 <exit>
      }
      wait(0);
     872:	4501                	li	a0,0
     874:	00001097          	auipc	ra,0x1
     878:	af8080e7          	jalr	-1288(ra) # 136c <wait>
     87c:	b0c1                	j	13c <go+0x74>
    } else if(what == 21){
     87e:	fd442783          	lw	a5,-44(s0)
     882:	0007871b          	sext.w	a4,a5
     886:	47d5                	li	a5,21
     888:	12f71e63          	bne	a4,a5,9c4 <go+0x8fc>
      unlink("c");
     88c:	00001517          	auipc	a0,0x1
     890:	61c50513          	addi	a0,a0,1564 # 1ea8 <lock_init+0x1d4>
     894:	00001097          	auipc	ra,0x1
     898:	b20080e7          	jalr	-1248(ra) # 13b4 <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     89c:	20200593          	li	a1,514
     8a0:	00001517          	auipc	a0,0x1
     8a4:	60850513          	addi	a0,a0,1544 # 1ea8 <lock_init+0x1d4>
     8a8:	00001097          	auipc	ra,0x1
     8ac:	afc080e7          	jalr	-1284(ra) # 13a4 <open>
     8b0:	87aa                	mv	a5,a0
     8b2:	fcf42423          	sw	a5,-56(s0)
      if(fd1 < 0){
     8b6:	fc842783          	lw	a5,-56(s0)
     8ba:	2781                	sext.w	a5,a5
     8bc:	0007df63          	bgez	a5,8da <go+0x812>
        printf("grind: create c failed\n");
     8c0:	00001517          	auipc	a0,0x1
     8c4:	5f050513          	addi	a0,a0,1520 # 1eb0 <lock_init+0x1dc>
     8c8:	00001097          	auipc	ra,0x1
     8cc:	fd4080e7          	jalr	-44(ra) # 189c <printf>
        exit(1);
     8d0:	4505                	li	a0,1
     8d2:	00001097          	auipc	ra,0x1
     8d6:	a92080e7          	jalr	-1390(ra) # 1364 <exit>
      }
      if(write(fd1, "x", 1) != 1){
     8da:	fc842783          	lw	a5,-56(s0)
     8de:	4605                	li	a2,1
     8e0:	00001597          	auipc	a1,0x1
     8e4:	57858593          	addi	a1,a1,1400 # 1e58 <lock_init+0x184>
     8e8:	853e                	mv	a0,a5
     8ea:	00001097          	auipc	ra,0x1
     8ee:	a9a080e7          	jalr	-1382(ra) # 1384 <write>
     8f2:	87aa                	mv	a5,a0
     8f4:	873e                	mv	a4,a5
     8f6:	4785                	li	a5,1
     8f8:	00f70f63          	beq	a4,a5,916 <go+0x84e>
        printf("grind: write c failed\n");
     8fc:	00001517          	auipc	a0,0x1
     900:	5cc50513          	addi	a0,a0,1484 # 1ec8 <lock_init+0x1f4>
     904:	00001097          	auipc	ra,0x1
     908:	f98080e7          	jalr	-104(ra) # 189c <printf>
        exit(1);
     90c:	4505                	li	a0,1
     90e:	00001097          	auipc	ra,0x1
     912:	a56080e7          	jalr	-1450(ra) # 1364 <exit>
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     916:	f8840713          	addi	a4,s0,-120
     91a:	fc842783          	lw	a5,-56(s0)
     91e:	85ba                	mv	a1,a4
     920:	853e                	mv	a0,a5
     922:	00001097          	auipc	ra,0x1
     926:	a9a080e7          	jalr	-1382(ra) # 13bc <fstat>
     92a:	87aa                	mv	a5,a0
     92c:	cf91                	beqz	a5,948 <go+0x880>
        printf("grind: fstat failed\n");
     92e:	00001517          	auipc	a0,0x1
     932:	5b250513          	addi	a0,a0,1458 # 1ee0 <lock_init+0x20c>
     936:	00001097          	auipc	ra,0x1
     93a:	f66080e7          	jalr	-154(ra) # 189c <printf>
        exit(1);
     93e:	4505                	li	a0,1
     940:	00001097          	auipc	ra,0x1
     944:	a24080e7          	jalr	-1500(ra) # 1364 <exit>
      }
      if(st.size != 1){
     948:	f9843703          	ld	a4,-104(s0)
     94c:	4785                	li	a5,1
     94e:	02f70363          	beq	a4,a5,974 <go+0x8ac>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     952:	f9843783          	ld	a5,-104(s0)
     956:	2781                	sext.w	a5,a5
     958:	85be                	mv	a1,a5
     95a:	00001517          	auipc	a0,0x1
     95e:	59e50513          	addi	a0,a0,1438 # 1ef8 <lock_init+0x224>
     962:	00001097          	auipc	ra,0x1
     966:	f3a080e7          	jalr	-198(ra) # 189c <printf>
        exit(1);
     96a:	4505                	li	a0,1
     96c:	00001097          	auipc	ra,0x1
     970:	9f8080e7          	jalr	-1544(ra) # 1364 <exit>
      }
      if(st.ino > 200){
     974:	f8c42783          	lw	a5,-116(s0)
     978:	873e                	mv	a4,a5
     97a:	0c800793          	li	a5,200
     97e:	02e7f263          	bgeu	a5,a4,9a2 <go+0x8da>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     982:	f8c42783          	lw	a5,-116(s0)
     986:	85be                	mv	a1,a5
     988:	00001517          	auipc	a0,0x1
     98c:	59850513          	addi	a0,a0,1432 # 1f20 <lock_init+0x24c>
     990:	00001097          	auipc	ra,0x1
     994:	f0c080e7          	jalr	-244(ra) # 189c <printf>
        exit(1);
     998:	4505                	li	a0,1
     99a:	00001097          	auipc	ra,0x1
     99e:	9ca080e7          	jalr	-1590(ra) # 1364 <exit>
      }
      close(fd1);
     9a2:	fc842783          	lw	a5,-56(s0)
     9a6:	853e                	mv	a0,a5
     9a8:	00001097          	auipc	ra,0x1
     9ac:	9e4080e7          	jalr	-1564(ra) # 138c <close>
      unlink("c");
     9b0:	00001517          	auipc	a0,0x1
     9b4:	4f850513          	addi	a0,a0,1272 # 1ea8 <lock_init+0x1d4>
     9b8:	00001097          	auipc	ra,0x1
     9bc:	9fc080e7          	jalr	-1540(ra) # 13b4 <unlink>
     9c0:	f7cff06f          	j	13c <go+0x74>
    } else if(what == 22){
     9c4:	fd442783          	lw	a5,-44(s0)
     9c8:	0007871b          	sext.w	a4,a5
     9cc:	47d9                	li	a5,22
     9ce:	f6f71763          	bne	a4,a5,13c <go+0x74>
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     9d2:	f8040793          	addi	a5,s0,-128
     9d6:	853e                	mv	a0,a5
     9d8:	00001097          	auipc	ra,0x1
     9dc:	99c080e7          	jalr	-1636(ra) # 1374 <pipe>
     9e0:	87aa                	mv	a5,a0
     9e2:	0207d063          	bgez	a5,a02 <go+0x93a>
        fprintf(2, "grind: pipe failed\n");
     9e6:	00001597          	auipc	a1,0x1
     9ea:	45a58593          	addi	a1,a1,1114 # 1e40 <lock_init+0x16c>
     9ee:	4509                	li	a0,2
     9f0:	00001097          	auipc	ra,0x1
     9f4:	e54080e7          	jalr	-428(ra) # 1844 <fprintf>
        exit(1);
     9f8:	4505                	li	a0,1
     9fa:	00001097          	auipc	ra,0x1
     9fe:	96a080e7          	jalr	-1686(ra) # 1364 <exit>
      }
      if(pipe(bb) < 0){
     a02:	f7840793          	addi	a5,s0,-136
     a06:	853e                	mv	a0,a5
     a08:	00001097          	auipc	ra,0x1
     a0c:	96c080e7          	jalr	-1684(ra) # 1374 <pipe>
     a10:	87aa                	mv	a5,a0
     a12:	0207d063          	bgez	a5,a32 <go+0x96a>
        fprintf(2, "grind: pipe failed\n");
     a16:	00001597          	auipc	a1,0x1
     a1a:	42a58593          	addi	a1,a1,1066 # 1e40 <lock_init+0x16c>
     a1e:	4509                	li	a0,2
     a20:	00001097          	auipc	ra,0x1
     a24:	e24080e7          	jalr	-476(ra) # 1844 <fprintf>
        exit(1);
     a28:	4505                	li	a0,1
     a2a:	00001097          	auipc	ra,0x1
     a2e:	93a080e7          	jalr	-1734(ra) # 1364 <exit>
      }
      int pid1 = fork();
     a32:	00001097          	auipc	ra,0x1
     a36:	92a080e7          	jalr	-1750(ra) # 135c <fork>
     a3a:	87aa                	mv	a5,a0
     a3c:	fcf42823          	sw	a5,-48(s0)
      if(pid1 == 0){
     a40:	fd042783          	lw	a5,-48(s0)
     a44:	2781                	sext.w	a5,a5
     a46:	e3f9                	bnez	a5,b0c <go+0xa44>
        close(bb[0]);
     a48:	f7842783          	lw	a5,-136(s0)
     a4c:	853e                	mv	a0,a5
     a4e:	00001097          	auipc	ra,0x1
     a52:	93e080e7          	jalr	-1730(ra) # 138c <close>
        close(bb[1]);
     a56:	f7c42783          	lw	a5,-132(s0)
     a5a:	853e                	mv	a0,a5
     a5c:	00001097          	auipc	ra,0x1
     a60:	930080e7          	jalr	-1744(ra) # 138c <close>
        close(aa[0]);
     a64:	f8042783          	lw	a5,-128(s0)
     a68:	853e                	mv	a0,a5
     a6a:	00001097          	auipc	ra,0x1
     a6e:	922080e7          	jalr	-1758(ra) # 138c <close>
        close(1);
     a72:	4505                	li	a0,1
     a74:	00001097          	auipc	ra,0x1
     a78:	918080e7          	jalr	-1768(ra) # 138c <close>
        if(dup(aa[1]) != 1){
     a7c:	f8442783          	lw	a5,-124(s0)
     a80:	853e                	mv	a0,a5
     a82:	00001097          	auipc	ra,0x1
     a86:	95a080e7          	jalr	-1702(ra) # 13dc <dup>
     a8a:	87aa                	mv	a5,a0
     a8c:	873e                	mv	a4,a5
     a8e:	4785                	li	a5,1
     a90:	02f70063          	beq	a4,a5,ab0 <go+0x9e8>
          fprintf(2, "grind: dup failed\n");
     a94:	00001597          	auipc	a1,0x1
     a98:	4b458593          	addi	a1,a1,1204 # 1f48 <lock_init+0x274>
     a9c:	4509                	li	a0,2
     a9e:	00001097          	auipc	ra,0x1
     aa2:	da6080e7          	jalr	-602(ra) # 1844 <fprintf>
          exit(1);
     aa6:	4505                	li	a0,1
     aa8:	00001097          	auipc	ra,0x1
     aac:	8bc080e7          	jalr	-1860(ra) # 1364 <exit>
        }
        close(aa[1]);
     ab0:	f8442783          	lw	a5,-124(s0)
     ab4:	853e                	mv	a0,a5
     ab6:	00001097          	auipc	ra,0x1
     aba:	8d6080e7          	jalr	-1834(ra) # 138c <close>
        char *args[3] = { "echo", "hi", 0 };
     abe:	00001797          	auipc	a5,0x1
     ac2:	4a278793          	addi	a5,a5,1186 # 1f60 <lock_init+0x28c>
     ac6:	f4f43823          	sd	a5,-176(s0)
     aca:	00001797          	auipc	a5,0x1
     ace:	49e78793          	addi	a5,a5,1182 # 1f68 <lock_init+0x294>
     ad2:	f4f43c23          	sd	a5,-168(s0)
     ad6:	f6043023          	sd	zero,-160(s0)
        exec("grindir/../echo", args);
     ada:	f5040793          	addi	a5,s0,-176
     ade:	85be                	mv	a1,a5
     ae0:	00001517          	auipc	a0,0x1
     ae4:	49050513          	addi	a0,a0,1168 # 1f70 <lock_init+0x29c>
     ae8:	00001097          	auipc	ra,0x1
     aec:	8b4080e7          	jalr	-1868(ra) # 139c <exec>
        fprintf(2, "grind: echo: not found\n");
     af0:	00001597          	auipc	a1,0x1
     af4:	49058593          	addi	a1,a1,1168 # 1f80 <lock_init+0x2ac>
     af8:	4509                	li	a0,2
     afa:	00001097          	auipc	ra,0x1
     afe:	d4a080e7          	jalr	-694(ra) # 1844 <fprintf>
        exit(2);
     b02:	4509                	li	a0,2
     b04:	00001097          	auipc	ra,0x1
     b08:	860080e7          	jalr	-1952(ra) # 1364 <exit>
      } else if(pid1 < 0){
     b0c:	fd042783          	lw	a5,-48(s0)
     b10:	2781                	sext.w	a5,a5
     b12:	0207d063          	bgez	a5,b32 <go+0xa6a>
        fprintf(2, "grind: fork failed\n");
     b16:	00001597          	auipc	a1,0x1
     b1a:	2e258593          	addi	a1,a1,738 # 1df8 <lock_init+0x124>
     b1e:	4509                	li	a0,2
     b20:	00001097          	auipc	ra,0x1
     b24:	d24080e7          	jalr	-732(ra) # 1844 <fprintf>
        exit(3);
     b28:	450d                	li	a0,3
     b2a:	00001097          	auipc	ra,0x1
     b2e:	83a080e7          	jalr	-1990(ra) # 1364 <exit>
      }
      int pid2 = fork();
     b32:	00001097          	auipc	ra,0x1
     b36:	82a080e7          	jalr	-2006(ra) # 135c <fork>
     b3a:	87aa                	mv	a5,a0
     b3c:	fcf42623          	sw	a5,-52(s0)
      if(pid2 == 0){
     b40:	fcc42783          	lw	a5,-52(s0)
     b44:	2781                	sext.w	a5,a5
     b46:	ebed                	bnez	a5,c38 <go+0xb70>
        close(aa[1]);
     b48:	f8442783          	lw	a5,-124(s0)
     b4c:	853e                	mv	a0,a5
     b4e:	00001097          	auipc	ra,0x1
     b52:	83e080e7          	jalr	-1986(ra) # 138c <close>
        close(bb[0]);
     b56:	f7842783          	lw	a5,-136(s0)
     b5a:	853e                	mv	a0,a5
     b5c:	00001097          	auipc	ra,0x1
     b60:	830080e7          	jalr	-2000(ra) # 138c <close>
        close(0);
     b64:	4501                	li	a0,0
     b66:	00001097          	auipc	ra,0x1
     b6a:	826080e7          	jalr	-2010(ra) # 138c <close>
        if(dup(aa[0]) != 0){
     b6e:	f8042783          	lw	a5,-128(s0)
     b72:	853e                	mv	a0,a5
     b74:	00001097          	auipc	ra,0x1
     b78:	868080e7          	jalr	-1944(ra) # 13dc <dup>
     b7c:	87aa                	mv	a5,a0
     b7e:	cf99                	beqz	a5,b9c <go+0xad4>
          fprintf(2, "grind: dup failed\n");
     b80:	00001597          	auipc	a1,0x1
     b84:	3c858593          	addi	a1,a1,968 # 1f48 <lock_init+0x274>
     b88:	4509                	li	a0,2
     b8a:	00001097          	auipc	ra,0x1
     b8e:	cba080e7          	jalr	-838(ra) # 1844 <fprintf>
          exit(4);
     b92:	4511                	li	a0,4
     b94:	00000097          	auipc	ra,0x0
     b98:	7d0080e7          	jalr	2000(ra) # 1364 <exit>
        }
        close(aa[0]);
     b9c:	f8042783          	lw	a5,-128(s0)
     ba0:	853e                	mv	a0,a5
     ba2:	00000097          	auipc	ra,0x0
     ba6:	7ea080e7          	jalr	2026(ra) # 138c <close>
        close(1);
     baa:	4505                	li	a0,1
     bac:	00000097          	auipc	ra,0x0
     bb0:	7e0080e7          	jalr	2016(ra) # 138c <close>
        if(dup(bb[1]) != 1){
     bb4:	f7c42783          	lw	a5,-132(s0)
     bb8:	853e                	mv	a0,a5
     bba:	00001097          	auipc	ra,0x1
     bbe:	822080e7          	jalr	-2014(ra) # 13dc <dup>
     bc2:	87aa                	mv	a5,a0
     bc4:	873e                	mv	a4,a5
     bc6:	4785                	li	a5,1
     bc8:	02f70063          	beq	a4,a5,be8 <go+0xb20>
          fprintf(2, "grind: dup failed\n");
     bcc:	00001597          	auipc	a1,0x1
     bd0:	37c58593          	addi	a1,a1,892 # 1f48 <lock_init+0x274>
     bd4:	4509                	li	a0,2
     bd6:	00001097          	auipc	ra,0x1
     bda:	c6e080e7          	jalr	-914(ra) # 1844 <fprintf>
          exit(5);
     bde:	4515                	li	a0,5
     be0:	00000097          	auipc	ra,0x0
     be4:	784080e7          	jalr	1924(ra) # 1364 <exit>
        }
        close(bb[1]);
     be8:	f7c42783          	lw	a5,-132(s0)
     bec:	853e                	mv	a0,a5
     bee:	00000097          	auipc	ra,0x0
     bf2:	79e080e7          	jalr	1950(ra) # 138c <close>
        char *args[2] = { "cat", 0 };
     bf6:	00001797          	auipc	a5,0x1
     bfa:	3a278793          	addi	a5,a5,930 # 1f98 <lock_init+0x2c4>
     bfe:	f4f43023          	sd	a5,-192(s0)
     c02:	f4043423          	sd	zero,-184(s0)
        exec("/cat", args);
     c06:	f4040793          	addi	a5,s0,-192
     c0a:	85be                	mv	a1,a5
     c0c:	00001517          	auipc	a0,0x1
     c10:	39450513          	addi	a0,a0,916 # 1fa0 <lock_init+0x2cc>
     c14:	00000097          	auipc	ra,0x0
     c18:	788080e7          	jalr	1928(ra) # 139c <exec>
        fprintf(2, "grind: cat: not found\n");
     c1c:	00001597          	auipc	a1,0x1
     c20:	38c58593          	addi	a1,a1,908 # 1fa8 <lock_init+0x2d4>
     c24:	4509                	li	a0,2
     c26:	00001097          	auipc	ra,0x1
     c2a:	c1e080e7          	jalr	-994(ra) # 1844 <fprintf>
        exit(6);
     c2e:	4519                	li	a0,6
     c30:	00000097          	auipc	ra,0x0
     c34:	734080e7          	jalr	1844(ra) # 1364 <exit>
      } else if(pid2 < 0){
     c38:	fcc42783          	lw	a5,-52(s0)
     c3c:	2781                	sext.w	a5,a5
     c3e:	0207d063          	bgez	a5,c5e <go+0xb96>
        fprintf(2, "grind: fork failed\n");
     c42:	00001597          	auipc	a1,0x1
     c46:	1b658593          	addi	a1,a1,438 # 1df8 <lock_init+0x124>
     c4a:	4509                	li	a0,2
     c4c:	00001097          	auipc	ra,0x1
     c50:	bf8080e7          	jalr	-1032(ra) # 1844 <fprintf>
        exit(7);
     c54:	451d                	li	a0,7
     c56:	00000097          	auipc	ra,0x0
     c5a:	70e080e7          	jalr	1806(ra) # 1364 <exit>
      }
      close(aa[0]);
     c5e:	f8042783          	lw	a5,-128(s0)
     c62:	853e                	mv	a0,a5
     c64:	00000097          	auipc	ra,0x0
     c68:	728080e7          	jalr	1832(ra) # 138c <close>
      close(aa[1]);
     c6c:	f8442783          	lw	a5,-124(s0)
     c70:	853e                	mv	a0,a5
     c72:	00000097          	auipc	ra,0x0
     c76:	71a080e7          	jalr	1818(ra) # 138c <close>
      close(bb[1]);
     c7a:	f7c42783          	lw	a5,-132(s0)
     c7e:	853e                	mv	a0,a5
     c80:	00000097          	auipc	ra,0x0
     c84:	70c080e7          	jalr	1804(ra) # 138c <close>
      char buf[4] = { 0, 0, 0, 0 };
     c88:	f6042823          	sw	zero,-144(s0)
      read(bb[0], buf+0, 1);
     c8c:	f7842783          	lw	a5,-136(s0)
     c90:	f7040713          	addi	a4,s0,-144
     c94:	4605                	li	a2,1
     c96:	85ba                	mv	a1,a4
     c98:	853e                	mv	a0,a5
     c9a:	00000097          	auipc	ra,0x0
     c9e:	6e2080e7          	jalr	1762(ra) # 137c <read>
      read(bb[0], buf+1, 1);
     ca2:	f7842703          	lw	a4,-136(s0)
     ca6:	f7040793          	addi	a5,s0,-144
     caa:	0785                	addi	a5,a5,1
     cac:	4605                	li	a2,1
     cae:	85be                	mv	a1,a5
     cb0:	853a                	mv	a0,a4
     cb2:	00000097          	auipc	ra,0x0
     cb6:	6ca080e7          	jalr	1738(ra) # 137c <read>
      read(bb[0], buf+2, 1);
     cba:	f7842703          	lw	a4,-136(s0)
     cbe:	f7040793          	addi	a5,s0,-144
     cc2:	0789                	addi	a5,a5,2
     cc4:	4605                	li	a2,1
     cc6:	85be                	mv	a1,a5
     cc8:	853a                	mv	a0,a4
     cca:	00000097          	auipc	ra,0x0
     cce:	6b2080e7          	jalr	1714(ra) # 137c <read>
      close(bb[0]);
     cd2:	f7842783          	lw	a5,-136(s0)
     cd6:	853e                	mv	a0,a5
     cd8:	00000097          	auipc	ra,0x0
     cdc:	6b4080e7          	jalr	1716(ra) # 138c <close>
      int st1, st2;
      wait(&st1);
     ce0:	f6c40793          	addi	a5,s0,-148
     ce4:	853e                	mv	a0,a5
     ce6:	00000097          	auipc	ra,0x0
     cea:	686080e7          	jalr	1670(ra) # 136c <wait>
      wait(&st2);
     cee:	f6840793          	addi	a5,s0,-152
     cf2:	853e                	mv	a0,a5
     cf4:	00000097          	auipc	ra,0x0
     cf8:	678080e7          	jalr	1656(ra) # 136c <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     cfc:	f6c42783          	lw	a5,-148(s0)
     d00:	e395                	bnez	a5,d24 <go+0xc5c>
     d02:	f6842783          	lw	a5,-152(s0)
     d06:	ef99                	bnez	a5,d24 <go+0xc5c>
     d08:	f7040793          	addi	a5,s0,-144
     d0c:	00001597          	auipc	a1,0x1
     d10:	2b458593          	addi	a1,a1,692 # 1fc0 <lock_init+0x2ec>
     d14:	853e                	mv	a0,a5
     d16:	00000097          	auipc	ra,0x0
     d1a:	206080e7          	jalr	518(ra) # f1c <strcmp>
     d1e:	87aa                	mv	a5,a0
     d20:	c0078e63          	beqz	a5,13c <go+0x74>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     d24:	f6c42783          	lw	a5,-148(s0)
     d28:	f6842703          	lw	a4,-152(s0)
     d2c:	f7040693          	addi	a3,s0,-144
     d30:	863a                	mv	a2,a4
     d32:	85be                	mv	a1,a5
     d34:	00001517          	auipc	a0,0x1
     d38:	29450513          	addi	a0,a0,660 # 1fc8 <lock_init+0x2f4>
     d3c:	00001097          	auipc	ra,0x1
     d40:	b60080e7          	jalr	-1184(ra) # 189c <printf>
        exit(1);
     d44:	4505                	li	a0,1
     d46:	00000097          	auipc	ra,0x0
     d4a:	61e080e7          	jalr	1566(ra) # 1364 <exit>

0000000000000d4e <iter>:
  }
}

void
iter()
{
     d4e:	1101                	addi	sp,sp,-32
     d50:	ec06                	sd	ra,24(sp)
     d52:	e822                	sd	s0,16(sp)
     d54:	1000                	addi	s0,sp,32
  unlink("a");
     d56:	00001517          	auipc	a0,0x1
     d5a:	0ba50513          	addi	a0,a0,186 # 1e10 <lock_init+0x13c>
     d5e:	00000097          	auipc	ra,0x0
     d62:	656080e7          	jalr	1622(ra) # 13b4 <unlink>
  unlink("b");
     d66:	00001517          	auipc	a0,0x1
     d6a:	05a50513          	addi	a0,a0,90 # 1dc0 <lock_init+0xec>
     d6e:	00000097          	auipc	ra,0x0
     d72:	646080e7          	jalr	1606(ra) # 13b4 <unlink>
  
  int pid1 = fork();
     d76:	00000097          	auipc	ra,0x0
     d7a:	5e6080e7          	jalr	1510(ra) # 135c <fork>
     d7e:	87aa                	mv	a5,a0
     d80:	fef42623          	sw	a5,-20(s0)
  if(pid1 < 0){
     d84:	fec42783          	lw	a5,-20(s0)
     d88:	2781                	sext.w	a5,a5
     d8a:	0007df63          	bgez	a5,da8 <iter+0x5a>
    printf("grind: fork failed\n");
     d8e:	00001517          	auipc	a0,0x1
     d92:	06a50513          	addi	a0,a0,106 # 1df8 <lock_init+0x124>
     d96:	00001097          	auipc	ra,0x1
     d9a:	b06080e7          	jalr	-1274(ra) # 189c <printf>
    exit(1);
     d9e:	4505                	li	a0,1
     da0:	00000097          	auipc	ra,0x0
     da4:	5c4080e7          	jalr	1476(ra) # 1364 <exit>
  }
  if(pid1 == 0){
     da8:	fec42783          	lw	a5,-20(s0)
     dac:	2781                	sext.w	a5,a5
     dae:	e38d                	bnez	a5,dd0 <iter+0x82>
    rand_next = 31;
     db0:	00001797          	auipc	a5,0x1
     db4:	2b078793          	addi	a5,a5,688 # 2060 <rand_next>
     db8:	477d                	li	a4,31
     dba:	e398                	sd	a4,0(a5)
    go(0);
     dbc:	4501                	li	a0,0
     dbe:	fffff097          	auipc	ra,0xfffff
     dc2:	30a080e7          	jalr	778(ra) # c8 <go>
    exit(0);
     dc6:	4501                	li	a0,0
     dc8:	00000097          	auipc	ra,0x0
     dcc:	59c080e7          	jalr	1436(ra) # 1364 <exit>
  }

  int pid2 = fork();
     dd0:	00000097          	auipc	ra,0x0
     dd4:	58c080e7          	jalr	1420(ra) # 135c <fork>
     dd8:	87aa                	mv	a5,a0
     dda:	fef42423          	sw	a5,-24(s0)
  if(pid2 < 0){
     dde:	fe842783          	lw	a5,-24(s0)
     de2:	2781                	sext.w	a5,a5
     de4:	0007df63          	bgez	a5,e02 <iter+0xb4>
    printf("grind: fork failed\n");
     de8:	00001517          	auipc	a0,0x1
     dec:	01050513          	addi	a0,a0,16 # 1df8 <lock_init+0x124>
     df0:	00001097          	auipc	ra,0x1
     df4:	aac080e7          	jalr	-1364(ra) # 189c <printf>
    exit(1);
     df8:	4505                	li	a0,1
     dfa:	00000097          	auipc	ra,0x0
     dfe:	56a080e7          	jalr	1386(ra) # 1364 <exit>
  }
  if(pid2 == 0){
     e02:	fe842783          	lw	a5,-24(s0)
     e06:	2781                	sext.w	a5,a5
     e08:	e39d                	bnez	a5,e2e <iter+0xe0>
    rand_next = 7177;
     e0a:	00001797          	auipc	a5,0x1
     e0e:	25678793          	addi	a5,a5,598 # 2060 <rand_next>
     e12:	6709                	lui	a4,0x2
     e14:	c0970713          	addi	a4,a4,-1015 # 1c09 <thread_create+0x3f>
     e18:	e398                	sd	a4,0(a5)
    go(1);
     e1a:	4505                	li	a0,1
     e1c:	fffff097          	auipc	ra,0xfffff
     e20:	2ac080e7          	jalr	684(ra) # c8 <go>
    exit(0);
     e24:	4501                	li	a0,0
     e26:	00000097          	auipc	ra,0x0
     e2a:	53e080e7          	jalr	1342(ra) # 1364 <exit>
  }

  int st1 = -1;
     e2e:	57fd                	li	a5,-1
     e30:	fef42223          	sw	a5,-28(s0)
  wait(&st1);
     e34:	fe440793          	addi	a5,s0,-28
     e38:	853e                	mv	a0,a5
     e3a:	00000097          	auipc	ra,0x0
     e3e:	532080e7          	jalr	1330(ra) # 136c <wait>
  if(st1 != 0){
     e42:	fe442783          	lw	a5,-28(s0)
     e46:	cf99                	beqz	a5,e64 <iter+0x116>
    kill(pid1);
     e48:	fec42783          	lw	a5,-20(s0)
     e4c:	853e                	mv	a0,a5
     e4e:	00000097          	auipc	ra,0x0
     e52:	546080e7          	jalr	1350(ra) # 1394 <kill>
    kill(pid2);
     e56:	fe842783          	lw	a5,-24(s0)
     e5a:	853e                	mv	a0,a5
     e5c:	00000097          	auipc	ra,0x0
     e60:	538080e7          	jalr	1336(ra) # 1394 <kill>
  }
  int st2 = -1;
     e64:	57fd                	li	a5,-1
     e66:	fef42023          	sw	a5,-32(s0)
  wait(&st2);
     e6a:	fe040793          	addi	a5,s0,-32
     e6e:	853e                	mv	a0,a5
     e70:	00000097          	auipc	ra,0x0
     e74:	4fc080e7          	jalr	1276(ra) # 136c <wait>

  exit(0);
     e78:	4501                	li	a0,0
     e7a:	00000097          	auipc	ra,0x0
     e7e:	4ea080e7          	jalr	1258(ra) # 1364 <exit>

0000000000000e82 <main>:
}

int
main()
{
     e82:	1101                	addi	sp,sp,-32
     e84:	ec06                	sd	ra,24(sp)
     e86:	e822                	sd	s0,16(sp)
     e88:	1000                	addi	s0,sp,32
  while(1){
    int pid = fork();
     e8a:	00000097          	auipc	ra,0x0
     e8e:	4d2080e7          	jalr	1234(ra) # 135c <fork>
     e92:	87aa                	mv	a5,a0
     e94:	fef42623          	sw	a5,-20(s0)
    if(pid == 0){
     e98:	fec42783          	lw	a5,-20(s0)
     e9c:	2781                	sext.w	a5,a5
     e9e:	eb91                	bnez	a5,eb2 <main+0x30>
      iter();
     ea0:	00000097          	auipc	ra,0x0
     ea4:	eae080e7          	jalr	-338(ra) # d4e <iter>
      exit(0);
     ea8:	4501                	li	a0,0
     eaa:	00000097          	auipc	ra,0x0
     eae:	4ba080e7          	jalr	1210(ra) # 1364 <exit>
    }
    if(pid > 0){
     eb2:	fec42783          	lw	a5,-20(s0)
     eb6:	2781                	sext.w	a5,a5
     eb8:	00f05763          	blez	a5,ec6 <main+0x44>
      wait(0);
     ebc:	4501                	li	a0,0
     ebe:	00000097          	auipc	ra,0x0
     ec2:	4ae080e7          	jalr	1198(ra) # 136c <wait>
    }
    sleep(20);
     ec6:	4551                	li	a0,20
     ec8:	00000097          	auipc	ra,0x0
     ecc:	52c080e7          	jalr	1324(ra) # 13f4 <sleep>
  while(1){
     ed0:	bf6d                	j	e8a <main+0x8>

0000000000000ed2 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     ed2:	7179                	addi	sp,sp,-48
     ed4:	f422                	sd	s0,40(sp)
     ed6:	1800                	addi	s0,sp,48
     ed8:	fca43c23          	sd	a0,-40(s0)
     edc:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     ee0:	fd843783          	ld	a5,-40(s0)
     ee4:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     ee8:	0001                	nop
     eea:	fd043703          	ld	a4,-48(s0)
     eee:	00170793          	addi	a5,a4,1
     ef2:	fcf43823          	sd	a5,-48(s0)
     ef6:	fd843783          	ld	a5,-40(s0)
     efa:	00178693          	addi	a3,a5,1
     efe:	fcd43c23          	sd	a3,-40(s0)
     f02:	00074703          	lbu	a4,0(a4)
     f06:	00e78023          	sb	a4,0(a5)
     f0a:	0007c783          	lbu	a5,0(a5)
     f0e:	fff1                	bnez	a5,eea <strcpy+0x18>
    ;
  return os;
     f10:	fe843783          	ld	a5,-24(s0)
}
     f14:	853e                	mv	a0,a5
     f16:	7422                	ld	s0,40(sp)
     f18:	6145                	addi	sp,sp,48
     f1a:	8082                	ret

0000000000000f1c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     f1c:	1101                	addi	sp,sp,-32
     f1e:	ec22                	sd	s0,24(sp)
     f20:	1000                	addi	s0,sp,32
     f22:	fea43423          	sd	a0,-24(s0)
     f26:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     f2a:	a819                	j	f40 <strcmp+0x24>
    p++, q++;
     f2c:	fe843783          	ld	a5,-24(s0)
     f30:	0785                	addi	a5,a5,1
     f32:	fef43423          	sd	a5,-24(s0)
     f36:	fe043783          	ld	a5,-32(s0)
     f3a:	0785                	addi	a5,a5,1
     f3c:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     f40:	fe843783          	ld	a5,-24(s0)
     f44:	0007c783          	lbu	a5,0(a5)
     f48:	cb99                	beqz	a5,f5e <strcmp+0x42>
     f4a:	fe843783          	ld	a5,-24(s0)
     f4e:	0007c703          	lbu	a4,0(a5)
     f52:	fe043783          	ld	a5,-32(s0)
     f56:	0007c783          	lbu	a5,0(a5)
     f5a:	fcf709e3          	beq	a4,a5,f2c <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     f5e:	fe843783          	ld	a5,-24(s0)
     f62:	0007c783          	lbu	a5,0(a5)
     f66:	0007871b          	sext.w	a4,a5
     f6a:	fe043783          	ld	a5,-32(s0)
     f6e:	0007c783          	lbu	a5,0(a5)
     f72:	2781                	sext.w	a5,a5
     f74:	40f707bb          	subw	a5,a4,a5
     f78:	2781                	sext.w	a5,a5
}
     f7a:	853e                	mv	a0,a5
     f7c:	6462                	ld	s0,24(sp)
     f7e:	6105                	addi	sp,sp,32
     f80:	8082                	ret

0000000000000f82 <strlen>:

uint
strlen(const char *s)
{
     f82:	7179                	addi	sp,sp,-48
     f84:	f422                	sd	s0,40(sp)
     f86:	1800                	addi	s0,sp,48
     f88:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     f8c:	fe042623          	sw	zero,-20(s0)
     f90:	a031                	j	f9c <strlen+0x1a>
     f92:	fec42783          	lw	a5,-20(s0)
     f96:	2785                	addiw	a5,a5,1
     f98:	fef42623          	sw	a5,-20(s0)
     f9c:	fec42783          	lw	a5,-20(s0)
     fa0:	fd843703          	ld	a4,-40(s0)
     fa4:	97ba                	add	a5,a5,a4
     fa6:	0007c783          	lbu	a5,0(a5)
     faa:	f7e5                	bnez	a5,f92 <strlen+0x10>
    ;
  return n;
     fac:	fec42783          	lw	a5,-20(s0)
}
     fb0:	853e                	mv	a0,a5
     fb2:	7422                	ld	s0,40(sp)
     fb4:	6145                	addi	sp,sp,48
     fb6:	8082                	ret

0000000000000fb8 <memset>:

void*
memset(void *dst, int c, uint n)
{
     fb8:	7179                	addi	sp,sp,-48
     fba:	f422                	sd	s0,40(sp)
     fbc:	1800                	addi	s0,sp,48
     fbe:	fca43c23          	sd	a0,-40(s0)
     fc2:	87ae                	mv	a5,a1
     fc4:	8732                	mv	a4,a2
     fc6:	fcf42a23          	sw	a5,-44(s0)
     fca:	87ba                	mv	a5,a4
     fcc:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     fd0:	fd843783          	ld	a5,-40(s0)
     fd4:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     fd8:	fe042623          	sw	zero,-20(s0)
     fdc:	a00d                	j	ffe <memset+0x46>
    cdst[i] = c;
     fde:	fec42783          	lw	a5,-20(s0)
     fe2:	fe043703          	ld	a4,-32(s0)
     fe6:	97ba                	add	a5,a5,a4
     fe8:	fd442703          	lw	a4,-44(s0)
     fec:	0ff77713          	zext.b	a4,a4
     ff0:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     ff4:	fec42783          	lw	a5,-20(s0)
     ff8:	2785                	addiw	a5,a5,1
     ffa:	fef42623          	sw	a5,-20(s0)
     ffe:	fec42703          	lw	a4,-20(s0)
    1002:	fd042783          	lw	a5,-48(s0)
    1006:	2781                	sext.w	a5,a5
    1008:	fcf76be3          	bltu	a4,a5,fde <memset+0x26>
  }
  return dst;
    100c:	fd843783          	ld	a5,-40(s0)
}
    1010:	853e                	mv	a0,a5
    1012:	7422                	ld	s0,40(sp)
    1014:	6145                	addi	sp,sp,48
    1016:	8082                	ret

0000000000001018 <strchr>:

char*
strchr(const char *s, char c)
{
    1018:	1101                	addi	sp,sp,-32
    101a:	ec22                	sd	s0,24(sp)
    101c:	1000                	addi	s0,sp,32
    101e:	fea43423          	sd	a0,-24(s0)
    1022:	87ae                	mv	a5,a1
    1024:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
    1028:	a01d                	j	104e <strchr+0x36>
    if(*s == c)
    102a:	fe843783          	ld	a5,-24(s0)
    102e:	0007c703          	lbu	a4,0(a5)
    1032:	fe744783          	lbu	a5,-25(s0)
    1036:	0ff7f793          	zext.b	a5,a5
    103a:	00e79563          	bne	a5,a4,1044 <strchr+0x2c>
      return (char*)s;
    103e:	fe843783          	ld	a5,-24(s0)
    1042:	a821                	j	105a <strchr+0x42>
  for(; *s; s++)
    1044:	fe843783          	ld	a5,-24(s0)
    1048:	0785                	addi	a5,a5,1
    104a:	fef43423          	sd	a5,-24(s0)
    104e:	fe843783          	ld	a5,-24(s0)
    1052:	0007c783          	lbu	a5,0(a5)
    1056:	fbf1                	bnez	a5,102a <strchr+0x12>
  return 0;
    1058:	4781                	li	a5,0
}
    105a:	853e                	mv	a0,a5
    105c:	6462                	ld	s0,24(sp)
    105e:	6105                	addi	sp,sp,32
    1060:	8082                	ret

0000000000001062 <gets>:

char*
gets(char *buf, int max)
{
    1062:	7179                	addi	sp,sp,-48
    1064:	f406                	sd	ra,40(sp)
    1066:	f022                	sd	s0,32(sp)
    1068:	1800                	addi	s0,sp,48
    106a:	fca43c23          	sd	a0,-40(s0)
    106e:	87ae                	mv	a5,a1
    1070:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1074:	fe042623          	sw	zero,-20(s0)
    1078:	a8a1                	j	10d0 <gets+0x6e>
    cc = read(0, &c, 1);
    107a:	fe740793          	addi	a5,s0,-25
    107e:	4605                	li	a2,1
    1080:	85be                	mv	a1,a5
    1082:	4501                	li	a0,0
    1084:	00000097          	auipc	ra,0x0
    1088:	2f8080e7          	jalr	760(ra) # 137c <read>
    108c:	87aa                	mv	a5,a0
    108e:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
    1092:	fe842783          	lw	a5,-24(s0)
    1096:	2781                	sext.w	a5,a5
    1098:	04f05763          	blez	a5,10e6 <gets+0x84>
      break;
    buf[i++] = c;
    109c:	fec42783          	lw	a5,-20(s0)
    10a0:	0017871b          	addiw	a4,a5,1
    10a4:	fee42623          	sw	a4,-20(s0)
    10a8:	873e                	mv	a4,a5
    10aa:	fd843783          	ld	a5,-40(s0)
    10ae:	97ba                	add	a5,a5,a4
    10b0:	fe744703          	lbu	a4,-25(s0)
    10b4:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
    10b8:	fe744783          	lbu	a5,-25(s0)
    10bc:	873e                	mv	a4,a5
    10be:	47a9                	li	a5,10
    10c0:	02f70463          	beq	a4,a5,10e8 <gets+0x86>
    10c4:	fe744783          	lbu	a5,-25(s0)
    10c8:	873e                	mv	a4,a5
    10ca:	47b5                	li	a5,13
    10cc:	00f70e63          	beq	a4,a5,10e8 <gets+0x86>
  for(i=0; i+1 < max; ){
    10d0:	fec42783          	lw	a5,-20(s0)
    10d4:	2785                	addiw	a5,a5,1
    10d6:	0007871b          	sext.w	a4,a5
    10da:	fd442783          	lw	a5,-44(s0)
    10de:	2781                	sext.w	a5,a5
    10e0:	f8f74de3          	blt	a4,a5,107a <gets+0x18>
    10e4:	a011                	j	10e8 <gets+0x86>
      break;
    10e6:	0001                	nop
      break;
  }
  buf[i] = '\0';
    10e8:	fec42783          	lw	a5,-20(s0)
    10ec:	fd843703          	ld	a4,-40(s0)
    10f0:	97ba                	add	a5,a5,a4
    10f2:	00078023          	sb	zero,0(a5)
  return buf;
    10f6:	fd843783          	ld	a5,-40(s0)
}
    10fa:	853e                	mv	a0,a5
    10fc:	70a2                	ld	ra,40(sp)
    10fe:	7402                	ld	s0,32(sp)
    1100:	6145                	addi	sp,sp,48
    1102:	8082                	ret

0000000000001104 <stat>:

int
stat(const char *n, struct stat *st)
{
    1104:	7179                	addi	sp,sp,-48
    1106:	f406                	sd	ra,40(sp)
    1108:	f022                	sd	s0,32(sp)
    110a:	1800                	addi	s0,sp,48
    110c:	fca43c23          	sd	a0,-40(s0)
    1110:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1114:	4581                	li	a1,0
    1116:	fd843503          	ld	a0,-40(s0)
    111a:	00000097          	auipc	ra,0x0
    111e:	28a080e7          	jalr	650(ra) # 13a4 <open>
    1122:	87aa                	mv	a5,a0
    1124:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
    1128:	fec42783          	lw	a5,-20(s0)
    112c:	2781                	sext.w	a5,a5
    112e:	0007d463          	bgez	a5,1136 <stat+0x32>
    return -1;
    1132:	57fd                	li	a5,-1
    1134:	a035                	j	1160 <stat+0x5c>
  r = fstat(fd, st);
    1136:	fec42783          	lw	a5,-20(s0)
    113a:	fd043583          	ld	a1,-48(s0)
    113e:	853e                	mv	a0,a5
    1140:	00000097          	auipc	ra,0x0
    1144:	27c080e7          	jalr	636(ra) # 13bc <fstat>
    1148:	87aa                	mv	a5,a0
    114a:	fef42423          	sw	a5,-24(s0)
  close(fd);
    114e:	fec42783          	lw	a5,-20(s0)
    1152:	853e                	mv	a0,a5
    1154:	00000097          	auipc	ra,0x0
    1158:	238080e7          	jalr	568(ra) # 138c <close>
  return r;
    115c:	fe842783          	lw	a5,-24(s0)
}
    1160:	853e                	mv	a0,a5
    1162:	70a2                	ld	ra,40(sp)
    1164:	7402                	ld	s0,32(sp)
    1166:	6145                	addi	sp,sp,48
    1168:	8082                	ret

000000000000116a <atoi>:

int
atoi(const char *s)
{
    116a:	7179                	addi	sp,sp,-48
    116c:	f422                	sd	s0,40(sp)
    116e:	1800                	addi	s0,sp,48
    1170:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
    1174:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
    1178:	a81d                	j	11ae <atoi+0x44>
    n = n*10 + *s++ - '0';
    117a:	fec42783          	lw	a5,-20(s0)
    117e:	873e                	mv	a4,a5
    1180:	87ba                	mv	a5,a4
    1182:	0027979b          	slliw	a5,a5,0x2
    1186:	9fb9                	addw	a5,a5,a4
    1188:	0017979b          	slliw	a5,a5,0x1
    118c:	0007871b          	sext.w	a4,a5
    1190:	fd843783          	ld	a5,-40(s0)
    1194:	00178693          	addi	a3,a5,1
    1198:	fcd43c23          	sd	a3,-40(s0)
    119c:	0007c783          	lbu	a5,0(a5)
    11a0:	2781                	sext.w	a5,a5
    11a2:	9fb9                	addw	a5,a5,a4
    11a4:	2781                	sext.w	a5,a5
    11a6:	fd07879b          	addiw	a5,a5,-48
    11aa:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
    11ae:	fd843783          	ld	a5,-40(s0)
    11b2:	0007c783          	lbu	a5,0(a5)
    11b6:	873e                	mv	a4,a5
    11b8:	02f00793          	li	a5,47
    11bc:	00e7fb63          	bgeu	a5,a4,11d2 <atoi+0x68>
    11c0:	fd843783          	ld	a5,-40(s0)
    11c4:	0007c783          	lbu	a5,0(a5)
    11c8:	873e                	mv	a4,a5
    11ca:	03900793          	li	a5,57
    11ce:	fae7f6e3          	bgeu	a5,a4,117a <atoi+0x10>
  return n;
    11d2:	fec42783          	lw	a5,-20(s0)
}
    11d6:	853e                	mv	a0,a5
    11d8:	7422                	ld	s0,40(sp)
    11da:	6145                	addi	sp,sp,48
    11dc:	8082                	ret

00000000000011de <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11de:	7139                	addi	sp,sp,-64
    11e0:	fc22                	sd	s0,56(sp)
    11e2:	0080                	addi	s0,sp,64
    11e4:	fca43c23          	sd	a0,-40(s0)
    11e8:	fcb43823          	sd	a1,-48(s0)
    11ec:	87b2                	mv	a5,a2
    11ee:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
    11f2:	fd843783          	ld	a5,-40(s0)
    11f6:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
    11fa:	fd043783          	ld	a5,-48(s0)
    11fe:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
    1202:	fe043703          	ld	a4,-32(s0)
    1206:	fe843783          	ld	a5,-24(s0)
    120a:	02e7fc63          	bgeu	a5,a4,1242 <memmove+0x64>
    while(n-- > 0)
    120e:	a00d                	j	1230 <memmove+0x52>
      *dst++ = *src++;
    1210:	fe043703          	ld	a4,-32(s0)
    1214:	00170793          	addi	a5,a4,1
    1218:	fef43023          	sd	a5,-32(s0)
    121c:	fe843783          	ld	a5,-24(s0)
    1220:	00178693          	addi	a3,a5,1
    1224:	fed43423          	sd	a3,-24(s0)
    1228:	00074703          	lbu	a4,0(a4)
    122c:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    1230:	fcc42783          	lw	a5,-52(s0)
    1234:	fff7871b          	addiw	a4,a5,-1
    1238:	fce42623          	sw	a4,-52(s0)
    123c:	fcf04ae3          	bgtz	a5,1210 <memmove+0x32>
    1240:	a891                	j	1294 <memmove+0xb6>
  } else {
    dst += n;
    1242:	fcc42783          	lw	a5,-52(s0)
    1246:	fe843703          	ld	a4,-24(s0)
    124a:	97ba                	add	a5,a5,a4
    124c:	fef43423          	sd	a5,-24(s0)
    src += n;
    1250:	fcc42783          	lw	a5,-52(s0)
    1254:	fe043703          	ld	a4,-32(s0)
    1258:	97ba                	add	a5,a5,a4
    125a:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    125e:	a01d                	j	1284 <memmove+0xa6>
      *--dst = *--src;
    1260:	fe043783          	ld	a5,-32(s0)
    1264:	17fd                	addi	a5,a5,-1
    1266:	fef43023          	sd	a5,-32(s0)
    126a:	fe843783          	ld	a5,-24(s0)
    126e:	17fd                	addi	a5,a5,-1
    1270:	fef43423          	sd	a5,-24(s0)
    1274:	fe043783          	ld	a5,-32(s0)
    1278:	0007c703          	lbu	a4,0(a5)
    127c:	fe843783          	ld	a5,-24(s0)
    1280:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    1284:	fcc42783          	lw	a5,-52(s0)
    1288:	fff7871b          	addiw	a4,a5,-1
    128c:	fce42623          	sw	a4,-52(s0)
    1290:	fcf048e3          	bgtz	a5,1260 <memmove+0x82>
  }
  return vdst;
    1294:	fd843783          	ld	a5,-40(s0)
}
    1298:	853e                	mv	a0,a5
    129a:	7462                	ld	s0,56(sp)
    129c:	6121                	addi	sp,sp,64
    129e:	8082                	ret

00000000000012a0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    12a0:	7139                	addi	sp,sp,-64
    12a2:	fc22                	sd	s0,56(sp)
    12a4:	0080                	addi	s0,sp,64
    12a6:	fca43c23          	sd	a0,-40(s0)
    12aa:	fcb43823          	sd	a1,-48(s0)
    12ae:	87b2                	mv	a5,a2
    12b0:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
    12b4:	fd843783          	ld	a5,-40(s0)
    12b8:	fef43423          	sd	a5,-24(s0)
    12bc:	fd043783          	ld	a5,-48(s0)
    12c0:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    12c4:	a0a1                	j	130c <memcmp+0x6c>
    if (*p1 != *p2) {
    12c6:	fe843783          	ld	a5,-24(s0)
    12ca:	0007c703          	lbu	a4,0(a5)
    12ce:	fe043783          	ld	a5,-32(s0)
    12d2:	0007c783          	lbu	a5,0(a5)
    12d6:	02f70163          	beq	a4,a5,12f8 <memcmp+0x58>
      return *p1 - *p2;
    12da:	fe843783          	ld	a5,-24(s0)
    12de:	0007c783          	lbu	a5,0(a5)
    12e2:	0007871b          	sext.w	a4,a5
    12e6:	fe043783          	ld	a5,-32(s0)
    12ea:	0007c783          	lbu	a5,0(a5)
    12ee:	2781                	sext.w	a5,a5
    12f0:	40f707bb          	subw	a5,a4,a5
    12f4:	2781                	sext.w	a5,a5
    12f6:	a01d                	j	131c <memcmp+0x7c>
    }
    p1++;
    12f8:	fe843783          	ld	a5,-24(s0)
    12fc:	0785                	addi	a5,a5,1
    12fe:	fef43423          	sd	a5,-24(s0)
    p2++;
    1302:	fe043783          	ld	a5,-32(s0)
    1306:	0785                	addi	a5,a5,1
    1308:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    130c:	fcc42783          	lw	a5,-52(s0)
    1310:	fff7871b          	addiw	a4,a5,-1
    1314:	fce42623          	sw	a4,-52(s0)
    1318:	f7dd                	bnez	a5,12c6 <memcmp+0x26>
  }
  return 0;
    131a:	4781                	li	a5,0
}
    131c:	853e                	mv	a0,a5
    131e:	7462                	ld	s0,56(sp)
    1320:	6121                	addi	sp,sp,64
    1322:	8082                	ret

0000000000001324 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    1324:	7179                	addi	sp,sp,-48
    1326:	f406                	sd	ra,40(sp)
    1328:	f022                	sd	s0,32(sp)
    132a:	1800                	addi	s0,sp,48
    132c:	fea43423          	sd	a0,-24(s0)
    1330:	feb43023          	sd	a1,-32(s0)
    1334:	87b2                	mv	a5,a2
    1336:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    133a:	fdc42783          	lw	a5,-36(s0)
    133e:	863e                	mv	a2,a5
    1340:	fe043583          	ld	a1,-32(s0)
    1344:	fe843503          	ld	a0,-24(s0)
    1348:	00000097          	auipc	ra,0x0
    134c:	e96080e7          	jalr	-362(ra) # 11de <memmove>
    1350:	87aa                	mv	a5,a0
}
    1352:	853e                	mv	a0,a5
    1354:	70a2                	ld	ra,40(sp)
    1356:	7402                	ld	s0,32(sp)
    1358:	6145                	addi	sp,sp,48
    135a:	8082                	ret

000000000000135c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    135c:	4885                	li	a7,1
 ecall
    135e:	00000073          	ecall
 ret
    1362:	8082                	ret

0000000000001364 <exit>:
.global exit
exit:
 li a7, SYS_exit
    1364:	4889                	li	a7,2
 ecall
    1366:	00000073          	ecall
 ret
    136a:	8082                	ret

000000000000136c <wait>:
.global wait
wait:
 li a7, SYS_wait
    136c:	488d                	li	a7,3
 ecall
    136e:	00000073          	ecall
 ret
    1372:	8082                	ret

0000000000001374 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    1374:	4891                	li	a7,4
 ecall
    1376:	00000073          	ecall
 ret
    137a:	8082                	ret

000000000000137c <read>:
.global read
read:
 li a7, SYS_read
    137c:	4895                	li	a7,5
 ecall
    137e:	00000073          	ecall
 ret
    1382:	8082                	ret

0000000000001384 <write>:
.global write
write:
 li a7, SYS_write
    1384:	48c1                	li	a7,16
 ecall
    1386:	00000073          	ecall
 ret
    138a:	8082                	ret

000000000000138c <close>:
.global close
close:
 li a7, SYS_close
    138c:	48d5                	li	a7,21
 ecall
    138e:	00000073          	ecall
 ret
    1392:	8082                	ret

0000000000001394 <kill>:
.global kill
kill:
 li a7, SYS_kill
    1394:	4899                	li	a7,6
 ecall
    1396:	00000073          	ecall
 ret
    139a:	8082                	ret

000000000000139c <exec>:
.global exec
exec:
 li a7, SYS_exec
    139c:	489d                	li	a7,7
 ecall
    139e:	00000073          	ecall
 ret
    13a2:	8082                	ret

00000000000013a4 <open>:
.global open
open:
 li a7, SYS_open
    13a4:	48bd                	li	a7,15
 ecall
    13a6:	00000073          	ecall
 ret
    13aa:	8082                	ret

00000000000013ac <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    13ac:	48c5                	li	a7,17
 ecall
    13ae:	00000073          	ecall
 ret
    13b2:	8082                	ret

00000000000013b4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    13b4:	48c9                	li	a7,18
 ecall
    13b6:	00000073          	ecall
 ret
    13ba:	8082                	ret

00000000000013bc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    13bc:	48a1                	li	a7,8
 ecall
    13be:	00000073          	ecall
 ret
    13c2:	8082                	ret

00000000000013c4 <link>:
.global link
link:
 li a7, SYS_link
    13c4:	48cd                	li	a7,19
 ecall
    13c6:	00000073          	ecall
 ret
    13ca:	8082                	ret

00000000000013cc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    13cc:	48d1                	li	a7,20
 ecall
    13ce:	00000073          	ecall
 ret
    13d2:	8082                	ret

00000000000013d4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    13d4:	48a5                	li	a7,9
 ecall
    13d6:	00000073          	ecall
 ret
    13da:	8082                	ret

00000000000013dc <dup>:
.global dup
dup:
 li a7, SYS_dup
    13dc:	48a9                	li	a7,10
 ecall
    13de:	00000073          	ecall
 ret
    13e2:	8082                	ret

00000000000013e4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    13e4:	48ad                	li	a7,11
 ecall
    13e6:	00000073          	ecall
 ret
    13ea:	8082                	ret

00000000000013ec <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    13ec:	48b1                	li	a7,12
 ecall
    13ee:	00000073          	ecall
 ret
    13f2:	8082                	ret

00000000000013f4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    13f4:	48b5                	li	a7,13
 ecall
    13f6:	00000073          	ecall
 ret
    13fa:	8082                	ret

00000000000013fc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    13fc:	48b9                	li	a7,14
 ecall
    13fe:	00000073          	ecall
 ret
    1402:	8082                	ret

0000000000001404 <clone>:
.global clone
clone:
 li a7, SYS_clone
    1404:	48d9                	li	a7,22
 ecall
    1406:	00000073          	ecall
 ret
    140a:	8082                	ret

000000000000140c <join>:
.global join
join:
 li a7, SYS_join
    140c:	48dd                	li	a7,23
 ecall
    140e:	00000073          	ecall
 ret
    1412:	8082                	ret

0000000000001414 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    1414:	1101                	addi	sp,sp,-32
    1416:	ec06                	sd	ra,24(sp)
    1418:	e822                	sd	s0,16(sp)
    141a:	1000                	addi	s0,sp,32
    141c:	87aa                	mv	a5,a0
    141e:	872e                	mv	a4,a1
    1420:	fef42623          	sw	a5,-20(s0)
    1424:	87ba                	mv	a5,a4
    1426:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
    142a:	feb40713          	addi	a4,s0,-21
    142e:	fec42783          	lw	a5,-20(s0)
    1432:	4605                	li	a2,1
    1434:	85ba                	mv	a1,a4
    1436:	853e                	mv	a0,a5
    1438:	00000097          	auipc	ra,0x0
    143c:	f4c080e7          	jalr	-180(ra) # 1384 <write>
}
    1440:	0001                	nop
    1442:	60e2                	ld	ra,24(sp)
    1444:	6442                	ld	s0,16(sp)
    1446:	6105                	addi	sp,sp,32
    1448:	8082                	ret

000000000000144a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    144a:	7139                	addi	sp,sp,-64
    144c:	fc06                	sd	ra,56(sp)
    144e:	f822                	sd	s0,48(sp)
    1450:	0080                	addi	s0,sp,64
    1452:	87aa                	mv	a5,a0
    1454:	8736                	mv	a4,a3
    1456:	fcf42623          	sw	a5,-52(s0)
    145a:	87ae                	mv	a5,a1
    145c:	fcf42423          	sw	a5,-56(s0)
    1460:	87b2                	mv	a5,a2
    1462:	fcf42223          	sw	a5,-60(s0)
    1466:	87ba                	mv	a5,a4
    1468:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    146c:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
    1470:	fc042783          	lw	a5,-64(s0)
    1474:	2781                	sext.w	a5,a5
    1476:	c38d                	beqz	a5,1498 <printint+0x4e>
    1478:	fc842783          	lw	a5,-56(s0)
    147c:	2781                	sext.w	a5,a5
    147e:	0007dd63          	bgez	a5,1498 <printint+0x4e>
    neg = 1;
    1482:	4785                	li	a5,1
    1484:	fef42423          	sw	a5,-24(s0)
    x = -xx;
    1488:	fc842783          	lw	a5,-56(s0)
    148c:	40f007bb          	negw	a5,a5
    1490:	2781                	sext.w	a5,a5
    1492:	fef42223          	sw	a5,-28(s0)
    1496:	a029                	j	14a0 <printint+0x56>
  } else {
    x = xx;
    1498:	fc842783          	lw	a5,-56(s0)
    149c:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
    14a0:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
    14a4:	fc442783          	lw	a5,-60(s0)
    14a8:	fe442703          	lw	a4,-28(s0)
    14ac:	02f777bb          	remuw	a5,a4,a5
    14b0:	0007861b          	sext.w	a2,a5
    14b4:	fec42783          	lw	a5,-20(s0)
    14b8:	0017871b          	addiw	a4,a5,1
    14bc:	fee42623          	sw	a4,-20(s0)
    14c0:	00001697          	auipc	a3,0x1
    14c4:	b8868693          	addi	a3,a3,-1144 # 2048 <digits>
    14c8:	02061713          	slli	a4,a2,0x20
    14cc:	9301                	srli	a4,a4,0x20
    14ce:	9736                	add	a4,a4,a3
    14d0:	00074703          	lbu	a4,0(a4)
    14d4:	17c1                	addi	a5,a5,-16
    14d6:	97a2                	add	a5,a5,s0
    14d8:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
    14dc:	fc442783          	lw	a5,-60(s0)
    14e0:	fe442703          	lw	a4,-28(s0)
    14e4:	02f757bb          	divuw	a5,a4,a5
    14e8:	fef42223          	sw	a5,-28(s0)
    14ec:	fe442783          	lw	a5,-28(s0)
    14f0:	2781                	sext.w	a5,a5
    14f2:	fbcd                	bnez	a5,14a4 <printint+0x5a>
  if(neg)
    14f4:	fe842783          	lw	a5,-24(s0)
    14f8:	2781                	sext.w	a5,a5
    14fa:	cf85                	beqz	a5,1532 <printint+0xe8>
    buf[i++] = '-';
    14fc:	fec42783          	lw	a5,-20(s0)
    1500:	0017871b          	addiw	a4,a5,1
    1504:	fee42623          	sw	a4,-20(s0)
    1508:	17c1                	addi	a5,a5,-16
    150a:	97a2                	add	a5,a5,s0
    150c:	02d00713          	li	a4,45
    1510:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
    1514:	a839                	j	1532 <printint+0xe8>
    putc(fd, buf[i]);
    1516:	fec42783          	lw	a5,-20(s0)
    151a:	17c1                	addi	a5,a5,-16
    151c:	97a2                	add	a5,a5,s0
    151e:	fe07c703          	lbu	a4,-32(a5)
    1522:	fcc42783          	lw	a5,-52(s0)
    1526:	85ba                	mv	a1,a4
    1528:	853e                	mv	a0,a5
    152a:	00000097          	auipc	ra,0x0
    152e:	eea080e7          	jalr	-278(ra) # 1414 <putc>
  while(--i >= 0)
    1532:	fec42783          	lw	a5,-20(s0)
    1536:	37fd                	addiw	a5,a5,-1
    1538:	fef42623          	sw	a5,-20(s0)
    153c:	fec42783          	lw	a5,-20(s0)
    1540:	2781                	sext.w	a5,a5
    1542:	fc07dae3          	bgez	a5,1516 <printint+0xcc>
}
    1546:	0001                	nop
    1548:	0001                	nop
    154a:	70e2                	ld	ra,56(sp)
    154c:	7442                	ld	s0,48(sp)
    154e:	6121                	addi	sp,sp,64
    1550:	8082                	ret

0000000000001552 <printptr>:

static void
printptr(int fd, uint64 x) {
    1552:	7179                	addi	sp,sp,-48
    1554:	f406                	sd	ra,40(sp)
    1556:	f022                	sd	s0,32(sp)
    1558:	1800                	addi	s0,sp,48
    155a:	87aa                	mv	a5,a0
    155c:	fcb43823          	sd	a1,-48(s0)
    1560:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    1564:	fdc42783          	lw	a5,-36(s0)
    1568:	03000593          	li	a1,48
    156c:	853e                	mv	a0,a5
    156e:	00000097          	auipc	ra,0x0
    1572:	ea6080e7          	jalr	-346(ra) # 1414 <putc>
  putc(fd, 'x');
    1576:	fdc42783          	lw	a5,-36(s0)
    157a:	07800593          	li	a1,120
    157e:	853e                	mv	a0,a5
    1580:	00000097          	auipc	ra,0x0
    1584:	e94080e7          	jalr	-364(ra) # 1414 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1588:	fe042623          	sw	zero,-20(s0)
    158c:	a82d                	j	15c6 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    158e:	fd043783          	ld	a5,-48(s0)
    1592:	93f1                	srli	a5,a5,0x3c
    1594:	00001717          	auipc	a4,0x1
    1598:	ab470713          	addi	a4,a4,-1356 # 2048 <digits>
    159c:	97ba                	add	a5,a5,a4
    159e:	0007c703          	lbu	a4,0(a5)
    15a2:	fdc42783          	lw	a5,-36(s0)
    15a6:	85ba                	mv	a1,a4
    15a8:	853e                	mv	a0,a5
    15aa:	00000097          	auipc	ra,0x0
    15ae:	e6a080e7          	jalr	-406(ra) # 1414 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    15b2:	fec42783          	lw	a5,-20(s0)
    15b6:	2785                	addiw	a5,a5,1
    15b8:	fef42623          	sw	a5,-20(s0)
    15bc:	fd043783          	ld	a5,-48(s0)
    15c0:	0792                	slli	a5,a5,0x4
    15c2:	fcf43823          	sd	a5,-48(s0)
    15c6:	fec42783          	lw	a5,-20(s0)
    15ca:	873e                	mv	a4,a5
    15cc:	47bd                	li	a5,15
    15ce:	fce7f0e3          	bgeu	a5,a4,158e <printptr+0x3c>
}
    15d2:	0001                	nop
    15d4:	0001                	nop
    15d6:	70a2                	ld	ra,40(sp)
    15d8:	7402                	ld	s0,32(sp)
    15da:	6145                	addi	sp,sp,48
    15dc:	8082                	ret

00000000000015de <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    15de:	715d                	addi	sp,sp,-80
    15e0:	e486                	sd	ra,72(sp)
    15e2:	e0a2                	sd	s0,64(sp)
    15e4:	0880                	addi	s0,sp,80
    15e6:	87aa                	mv	a5,a0
    15e8:	fcb43023          	sd	a1,-64(s0)
    15ec:	fac43c23          	sd	a2,-72(s0)
    15f0:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
    15f4:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    15f8:	fe042223          	sw	zero,-28(s0)
    15fc:	a42d                	j	1826 <vprintf+0x248>
    c = fmt[i] & 0xff;
    15fe:	fe442783          	lw	a5,-28(s0)
    1602:	fc043703          	ld	a4,-64(s0)
    1606:	97ba                	add	a5,a5,a4
    1608:	0007c783          	lbu	a5,0(a5)
    160c:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
    1610:	fe042783          	lw	a5,-32(s0)
    1614:	2781                	sext.w	a5,a5
    1616:	eb9d                	bnez	a5,164c <vprintf+0x6e>
      if(c == '%'){
    1618:	fdc42783          	lw	a5,-36(s0)
    161c:	0007871b          	sext.w	a4,a5
    1620:	02500793          	li	a5,37
    1624:	00f71763          	bne	a4,a5,1632 <vprintf+0x54>
        state = '%';
    1628:	02500793          	li	a5,37
    162c:	fef42023          	sw	a5,-32(s0)
    1630:	a2f5                	j	181c <vprintf+0x23e>
      } else {
        putc(fd, c);
    1632:	fdc42783          	lw	a5,-36(s0)
    1636:	0ff7f713          	zext.b	a4,a5
    163a:	fcc42783          	lw	a5,-52(s0)
    163e:	85ba                	mv	a1,a4
    1640:	853e                	mv	a0,a5
    1642:	00000097          	auipc	ra,0x0
    1646:	dd2080e7          	jalr	-558(ra) # 1414 <putc>
    164a:	aac9                	j	181c <vprintf+0x23e>
      }
    } else if(state == '%'){
    164c:	fe042783          	lw	a5,-32(s0)
    1650:	0007871b          	sext.w	a4,a5
    1654:	02500793          	li	a5,37
    1658:	1cf71263          	bne	a4,a5,181c <vprintf+0x23e>
      if(c == 'd'){
    165c:	fdc42783          	lw	a5,-36(s0)
    1660:	0007871b          	sext.w	a4,a5
    1664:	06400793          	li	a5,100
    1668:	02f71463          	bne	a4,a5,1690 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
    166c:	fb843783          	ld	a5,-72(s0)
    1670:	00878713          	addi	a4,a5,8
    1674:	fae43c23          	sd	a4,-72(s0)
    1678:	4398                	lw	a4,0(a5)
    167a:	fcc42783          	lw	a5,-52(s0)
    167e:	4685                	li	a3,1
    1680:	4629                	li	a2,10
    1682:	85ba                	mv	a1,a4
    1684:	853e                	mv	a0,a5
    1686:	00000097          	auipc	ra,0x0
    168a:	dc4080e7          	jalr	-572(ra) # 144a <printint>
    168e:	a269                	j	1818 <vprintf+0x23a>
      } else if(c == 'l') {
    1690:	fdc42783          	lw	a5,-36(s0)
    1694:	0007871b          	sext.w	a4,a5
    1698:	06c00793          	li	a5,108
    169c:	02f71663          	bne	a4,a5,16c8 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
    16a0:	fb843783          	ld	a5,-72(s0)
    16a4:	00878713          	addi	a4,a5,8
    16a8:	fae43c23          	sd	a4,-72(s0)
    16ac:	639c                	ld	a5,0(a5)
    16ae:	0007871b          	sext.w	a4,a5
    16b2:	fcc42783          	lw	a5,-52(s0)
    16b6:	4681                	li	a3,0
    16b8:	4629                	li	a2,10
    16ba:	85ba                	mv	a1,a4
    16bc:	853e                	mv	a0,a5
    16be:	00000097          	auipc	ra,0x0
    16c2:	d8c080e7          	jalr	-628(ra) # 144a <printint>
    16c6:	aa89                	j	1818 <vprintf+0x23a>
      } else if(c == 'x') {
    16c8:	fdc42783          	lw	a5,-36(s0)
    16cc:	0007871b          	sext.w	a4,a5
    16d0:	07800793          	li	a5,120
    16d4:	02f71463          	bne	a4,a5,16fc <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
    16d8:	fb843783          	ld	a5,-72(s0)
    16dc:	00878713          	addi	a4,a5,8
    16e0:	fae43c23          	sd	a4,-72(s0)
    16e4:	4398                	lw	a4,0(a5)
    16e6:	fcc42783          	lw	a5,-52(s0)
    16ea:	4681                	li	a3,0
    16ec:	4641                	li	a2,16
    16ee:	85ba                	mv	a1,a4
    16f0:	853e                	mv	a0,a5
    16f2:	00000097          	auipc	ra,0x0
    16f6:	d58080e7          	jalr	-680(ra) # 144a <printint>
    16fa:	aa39                	j	1818 <vprintf+0x23a>
      } else if(c == 'p') {
    16fc:	fdc42783          	lw	a5,-36(s0)
    1700:	0007871b          	sext.w	a4,a5
    1704:	07000793          	li	a5,112
    1708:	02f71263          	bne	a4,a5,172c <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
    170c:	fb843783          	ld	a5,-72(s0)
    1710:	00878713          	addi	a4,a5,8
    1714:	fae43c23          	sd	a4,-72(s0)
    1718:	6398                	ld	a4,0(a5)
    171a:	fcc42783          	lw	a5,-52(s0)
    171e:	85ba                	mv	a1,a4
    1720:	853e                	mv	a0,a5
    1722:	00000097          	auipc	ra,0x0
    1726:	e30080e7          	jalr	-464(ra) # 1552 <printptr>
    172a:	a0fd                	j	1818 <vprintf+0x23a>
      } else if(c == 's'){
    172c:	fdc42783          	lw	a5,-36(s0)
    1730:	0007871b          	sext.w	a4,a5
    1734:	07300793          	li	a5,115
    1738:	04f71c63          	bne	a4,a5,1790 <vprintf+0x1b2>
        s = va_arg(ap, char*);
    173c:	fb843783          	ld	a5,-72(s0)
    1740:	00878713          	addi	a4,a5,8
    1744:	fae43c23          	sd	a4,-72(s0)
    1748:	639c                	ld	a5,0(a5)
    174a:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
    174e:	fe843783          	ld	a5,-24(s0)
    1752:	eb8d                	bnez	a5,1784 <vprintf+0x1a6>
          s = "(null)";
    1754:	00001797          	auipc	a5,0x1
    1758:	89c78793          	addi	a5,a5,-1892 # 1ff0 <lock_init+0x31c>
    175c:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    1760:	a015                	j	1784 <vprintf+0x1a6>
          putc(fd, *s);
    1762:	fe843783          	ld	a5,-24(s0)
    1766:	0007c703          	lbu	a4,0(a5)
    176a:	fcc42783          	lw	a5,-52(s0)
    176e:	85ba                	mv	a1,a4
    1770:	853e                	mv	a0,a5
    1772:	00000097          	auipc	ra,0x0
    1776:	ca2080e7          	jalr	-862(ra) # 1414 <putc>
          s++;
    177a:	fe843783          	ld	a5,-24(s0)
    177e:	0785                	addi	a5,a5,1
    1780:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    1784:	fe843783          	ld	a5,-24(s0)
    1788:	0007c783          	lbu	a5,0(a5)
    178c:	fbf9                	bnez	a5,1762 <vprintf+0x184>
    178e:	a069                	j	1818 <vprintf+0x23a>
        }
      } else if(c == 'c'){
    1790:	fdc42783          	lw	a5,-36(s0)
    1794:	0007871b          	sext.w	a4,a5
    1798:	06300793          	li	a5,99
    179c:	02f71463          	bne	a4,a5,17c4 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
    17a0:	fb843783          	ld	a5,-72(s0)
    17a4:	00878713          	addi	a4,a5,8
    17a8:	fae43c23          	sd	a4,-72(s0)
    17ac:	439c                	lw	a5,0(a5)
    17ae:	0ff7f713          	zext.b	a4,a5
    17b2:	fcc42783          	lw	a5,-52(s0)
    17b6:	85ba                	mv	a1,a4
    17b8:	853e                	mv	a0,a5
    17ba:	00000097          	auipc	ra,0x0
    17be:	c5a080e7          	jalr	-934(ra) # 1414 <putc>
    17c2:	a899                	j	1818 <vprintf+0x23a>
      } else if(c == '%'){
    17c4:	fdc42783          	lw	a5,-36(s0)
    17c8:	0007871b          	sext.w	a4,a5
    17cc:	02500793          	li	a5,37
    17d0:	00f71f63          	bne	a4,a5,17ee <vprintf+0x210>
        putc(fd, c);
    17d4:	fdc42783          	lw	a5,-36(s0)
    17d8:	0ff7f713          	zext.b	a4,a5
    17dc:	fcc42783          	lw	a5,-52(s0)
    17e0:	85ba                	mv	a1,a4
    17e2:	853e                	mv	a0,a5
    17e4:	00000097          	auipc	ra,0x0
    17e8:	c30080e7          	jalr	-976(ra) # 1414 <putc>
    17ec:	a035                	j	1818 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    17ee:	fcc42783          	lw	a5,-52(s0)
    17f2:	02500593          	li	a1,37
    17f6:	853e                	mv	a0,a5
    17f8:	00000097          	auipc	ra,0x0
    17fc:	c1c080e7          	jalr	-996(ra) # 1414 <putc>
        putc(fd, c);
    1800:	fdc42783          	lw	a5,-36(s0)
    1804:	0ff7f713          	zext.b	a4,a5
    1808:	fcc42783          	lw	a5,-52(s0)
    180c:	85ba                	mv	a1,a4
    180e:	853e                	mv	a0,a5
    1810:	00000097          	auipc	ra,0x0
    1814:	c04080e7          	jalr	-1020(ra) # 1414 <putc>
      }
      state = 0;
    1818:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    181c:	fe442783          	lw	a5,-28(s0)
    1820:	2785                	addiw	a5,a5,1
    1822:	fef42223          	sw	a5,-28(s0)
    1826:	fe442783          	lw	a5,-28(s0)
    182a:	fc043703          	ld	a4,-64(s0)
    182e:	97ba                	add	a5,a5,a4
    1830:	0007c783          	lbu	a5,0(a5)
    1834:	dc0795e3          	bnez	a5,15fe <vprintf+0x20>
    }
  }
}
    1838:	0001                	nop
    183a:	0001                	nop
    183c:	60a6                	ld	ra,72(sp)
    183e:	6406                	ld	s0,64(sp)
    1840:	6161                	addi	sp,sp,80
    1842:	8082                	ret

0000000000001844 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1844:	7159                	addi	sp,sp,-112
    1846:	fc06                	sd	ra,56(sp)
    1848:	f822                	sd	s0,48(sp)
    184a:	0080                	addi	s0,sp,64
    184c:	fcb43823          	sd	a1,-48(s0)
    1850:	e010                	sd	a2,0(s0)
    1852:	e414                	sd	a3,8(s0)
    1854:	e818                	sd	a4,16(s0)
    1856:	ec1c                	sd	a5,24(s0)
    1858:	03043023          	sd	a6,32(s0)
    185c:	03143423          	sd	a7,40(s0)
    1860:	87aa                	mv	a5,a0
    1862:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    1866:	03040793          	addi	a5,s0,48
    186a:	fcf43423          	sd	a5,-56(s0)
    186e:	fc843783          	ld	a5,-56(s0)
    1872:	fd078793          	addi	a5,a5,-48
    1876:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    187a:	fe843703          	ld	a4,-24(s0)
    187e:	fdc42783          	lw	a5,-36(s0)
    1882:	863a                	mv	a2,a4
    1884:	fd043583          	ld	a1,-48(s0)
    1888:	853e                	mv	a0,a5
    188a:	00000097          	auipc	ra,0x0
    188e:	d54080e7          	jalr	-684(ra) # 15de <vprintf>
}
    1892:	0001                	nop
    1894:	70e2                	ld	ra,56(sp)
    1896:	7442                	ld	s0,48(sp)
    1898:	6165                	addi	sp,sp,112
    189a:	8082                	ret

000000000000189c <printf>:

void
printf(const char *fmt, ...)
{
    189c:	7159                	addi	sp,sp,-112
    189e:	f406                	sd	ra,40(sp)
    18a0:	f022                	sd	s0,32(sp)
    18a2:	1800                	addi	s0,sp,48
    18a4:	fca43c23          	sd	a0,-40(s0)
    18a8:	e40c                	sd	a1,8(s0)
    18aa:	e810                	sd	a2,16(s0)
    18ac:	ec14                	sd	a3,24(s0)
    18ae:	f018                	sd	a4,32(s0)
    18b0:	f41c                	sd	a5,40(s0)
    18b2:	03043823          	sd	a6,48(s0)
    18b6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    18ba:	04040793          	addi	a5,s0,64
    18be:	fcf43823          	sd	a5,-48(s0)
    18c2:	fd043783          	ld	a5,-48(s0)
    18c6:	fc878793          	addi	a5,a5,-56
    18ca:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    18ce:	fe843783          	ld	a5,-24(s0)
    18d2:	863e                	mv	a2,a5
    18d4:	fd843583          	ld	a1,-40(s0)
    18d8:	4505                	li	a0,1
    18da:	00000097          	auipc	ra,0x0
    18de:	d04080e7          	jalr	-764(ra) # 15de <vprintf>
}
    18e2:	0001                	nop
    18e4:	70a2                	ld	ra,40(sp)
    18e6:	7402                	ld	s0,32(sp)
    18e8:	6165                	addi	sp,sp,112
    18ea:	8082                	ret

00000000000018ec <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    18ec:	7179                	addi	sp,sp,-48
    18ee:	f422                	sd	s0,40(sp)
    18f0:	1800                	addi	s0,sp,48
    18f2:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    18f6:	fd843783          	ld	a5,-40(s0)
    18fa:	17c1                	addi	a5,a5,-16
    18fc:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1900:	00001797          	auipc	a5,0x1
    1904:	b6078793          	addi	a5,a5,-1184 # 2460 <freep>
    1908:	639c                	ld	a5,0(a5)
    190a:	fef43423          	sd	a5,-24(s0)
    190e:	a815                	j	1942 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1910:	fe843783          	ld	a5,-24(s0)
    1914:	639c                	ld	a5,0(a5)
    1916:	fe843703          	ld	a4,-24(s0)
    191a:	00f76f63          	bltu	a4,a5,1938 <free+0x4c>
    191e:	fe043703          	ld	a4,-32(s0)
    1922:	fe843783          	ld	a5,-24(s0)
    1926:	02e7eb63          	bltu	a5,a4,195c <free+0x70>
    192a:	fe843783          	ld	a5,-24(s0)
    192e:	639c                	ld	a5,0(a5)
    1930:	fe043703          	ld	a4,-32(s0)
    1934:	02f76463          	bltu	a4,a5,195c <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1938:	fe843783          	ld	a5,-24(s0)
    193c:	639c                	ld	a5,0(a5)
    193e:	fef43423          	sd	a5,-24(s0)
    1942:	fe043703          	ld	a4,-32(s0)
    1946:	fe843783          	ld	a5,-24(s0)
    194a:	fce7f3e3          	bgeu	a5,a4,1910 <free+0x24>
    194e:	fe843783          	ld	a5,-24(s0)
    1952:	639c                	ld	a5,0(a5)
    1954:	fe043703          	ld	a4,-32(s0)
    1958:	faf77ce3          	bgeu	a4,a5,1910 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    195c:	fe043783          	ld	a5,-32(s0)
    1960:	479c                	lw	a5,8(a5)
    1962:	1782                	slli	a5,a5,0x20
    1964:	9381                	srli	a5,a5,0x20
    1966:	0792                	slli	a5,a5,0x4
    1968:	fe043703          	ld	a4,-32(s0)
    196c:	973e                	add	a4,a4,a5
    196e:	fe843783          	ld	a5,-24(s0)
    1972:	639c                	ld	a5,0(a5)
    1974:	02f71763          	bne	a4,a5,19a2 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    1978:	fe043783          	ld	a5,-32(s0)
    197c:	4798                	lw	a4,8(a5)
    197e:	fe843783          	ld	a5,-24(s0)
    1982:	639c                	ld	a5,0(a5)
    1984:	479c                	lw	a5,8(a5)
    1986:	9fb9                	addw	a5,a5,a4
    1988:	0007871b          	sext.w	a4,a5
    198c:	fe043783          	ld	a5,-32(s0)
    1990:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    1992:	fe843783          	ld	a5,-24(s0)
    1996:	639c                	ld	a5,0(a5)
    1998:	6398                	ld	a4,0(a5)
    199a:	fe043783          	ld	a5,-32(s0)
    199e:	e398                	sd	a4,0(a5)
    19a0:	a039                	j	19ae <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    19a2:	fe843783          	ld	a5,-24(s0)
    19a6:	6398                	ld	a4,0(a5)
    19a8:	fe043783          	ld	a5,-32(s0)
    19ac:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    19ae:	fe843783          	ld	a5,-24(s0)
    19b2:	479c                	lw	a5,8(a5)
    19b4:	1782                	slli	a5,a5,0x20
    19b6:	9381                	srli	a5,a5,0x20
    19b8:	0792                	slli	a5,a5,0x4
    19ba:	fe843703          	ld	a4,-24(s0)
    19be:	97ba                	add	a5,a5,a4
    19c0:	fe043703          	ld	a4,-32(s0)
    19c4:	02f71563          	bne	a4,a5,19ee <free+0x102>
    p->s.size += bp->s.size;
    19c8:	fe843783          	ld	a5,-24(s0)
    19cc:	4798                	lw	a4,8(a5)
    19ce:	fe043783          	ld	a5,-32(s0)
    19d2:	479c                	lw	a5,8(a5)
    19d4:	9fb9                	addw	a5,a5,a4
    19d6:	0007871b          	sext.w	a4,a5
    19da:	fe843783          	ld	a5,-24(s0)
    19de:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    19e0:	fe043783          	ld	a5,-32(s0)
    19e4:	6398                	ld	a4,0(a5)
    19e6:	fe843783          	ld	a5,-24(s0)
    19ea:	e398                	sd	a4,0(a5)
    19ec:	a031                	j	19f8 <free+0x10c>
  } else
    p->s.ptr = bp;
    19ee:	fe843783          	ld	a5,-24(s0)
    19f2:	fe043703          	ld	a4,-32(s0)
    19f6:	e398                	sd	a4,0(a5)
  freep = p;
    19f8:	00001797          	auipc	a5,0x1
    19fc:	a6878793          	addi	a5,a5,-1432 # 2460 <freep>
    1a00:	fe843703          	ld	a4,-24(s0)
    1a04:	e398                	sd	a4,0(a5)
}
    1a06:	0001                	nop
    1a08:	7422                	ld	s0,40(sp)
    1a0a:	6145                	addi	sp,sp,48
    1a0c:	8082                	ret

0000000000001a0e <morecore>:

static Header*
morecore(uint nu)
{
    1a0e:	7179                	addi	sp,sp,-48
    1a10:	f406                	sd	ra,40(sp)
    1a12:	f022                	sd	s0,32(sp)
    1a14:	1800                	addi	s0,sp,48
    1a16:	87aa                	mv	a5,a0
    1a18:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    1a1c:	fdc42783          	lw	a5,-36(s0)
    1a20:	0007871b          	sext.w	a4,a5
    1a24:	6785                	lui	a5,0x1
    1a26:	00f77563          	bgeu	a4,a5,1a30 <morecore+0x22>
    nu = 4096;
    1a2a:	6785                	lui	a5,0x1
    1a2c:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    1a30:	fdc42783          	lw	a5,-36(s0)
    1a34:	0047979b          	slliw	a5,a5,0x4
    1a38:	2781                	sext.w	a5,a5
    1a3a:	2781                	sext.w	a5,a5
    1a3c:	853e                	mv	a0,a5
    1a3e:	00000097          	auipc	ra,0x0
    1a42:	9ae080e7          	jalr	-1618(ra) # 13ec <sbrk>
    1a46:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    1a4a:	fe843703          	ld	a4,-24(s0)
    1a4e:	57fd                	li	a5,-1
    1a50:	00f71463          	bne	a4,a5,1a58 <morecore+0x4a>
    return 0;
    1a54:	4781                	li	a5,0
    1a56:	a03d                	j	1a84 <morecore+0x76>
  hp = (Header*)p;
    1a58:	fe843783          	ld	a5,-24(s0)
    1a5c:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    1a60:	fe043783          	ld	a5,-32(s0)
    1a64:	fdc42703          	lw	a4,-36(s0)
    1a68:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    1a6a:	fe043783          	ld	a5,-32(s0)
    1a6e:	07c1                	addi	a5,a5,16
    1a70:	853e                	mv	a0,a5
    1a72:	00000097          	auipc	ra,0x0
    1a76:	e7a080e7          	jalr	-390(ra) # 18ec <free>
  return freep;
    1a7a:	00001797          	auipc	a5,0x1
    1a7e:	9e678793          	addi	a5,a5,-1562 # 2460 <freep>
    1a82:	639c                	ld	a5,0(a5)
}
    1a84:	853e                	mv	a0,a5
    1a86:	70a2                	ld	ra,40(sp)
    1a88:	7402                	ld	s0,32(sp)
    1a8a:	6145                	addi	sp,sp,48
    1a8c:	8082                	ret

0000000000001a8e <malloc>:

void*
malloc(uint nbytes)
{
    1a8e:	7139                	addi	sp,sp,-64
    1a90:	fc06                	sd	ra,56(sp)
    1a92:	f822                	sd	s0,48(sp)
    1a94:	0080                	addi	s0,sp,64
    1a96:	87aa                	mv	a5,a0
    1a98:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1a9c:	fcc46783          	lwu	a5,-52(s0)
    1aa0:	07bd                	addi	a5,a5,15
    1aa2:	8391                	srli	a5,a5,0x4
    1aa4:	2781                	sext.w	a5,a5
    1aa6:	2785                	addiw	a5,a5,1
    1aa8:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1aac:	00001797          	auipc	a5,0x1
    1ab0:	9b478793          	addi	a5,a5,-1612 # 2460 <freep>
    1ab4:	639c                	ld	a5,0(a5)
    1ab6:	fef43023          	sd	a5,-32(s0)
    1aba:	fe043783          	ld	a5,-32(s0)
    1abe:	ef95                	bnez	a5,1afa <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1ac0:	00001797          	auipc	a5,0x1
    1ac4:	99078793          	addi	a5,a5,-1648 # 2450 <base>
    1ac8:	fef43023          	sd	a5,-32(s0)
    1acc:	00001797          	auipc	a5,0x1
    1ad0:	99478793          	addi	a5,a5,-1644 # 2460 <freep>
    1ad4:	fe043703          	ld	a4,-32(s0)
    1ad8:	e398                	sd	a4,0(a5)
    1ada:	00001797          	auipc	a5,0x1
    1ade:	98678793          	addi	a5,a5,-1658 # 2460 <freep>
    1ae2:	6398                	ld	a4,0(a5)
    1ae4:	00001797          	auipc	a5,0x1
    1ae8:	96c78793          	addi	a5,a5,-1684 # 2450 <base>
    1aec:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1aee:	00001797          	auipc	a5,0x1
    1af2:	96278793          	addi	a5,a5,-1694 # 2450 <base>
    1af6:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1afa:	fe043783          	ld	a5,-32(s0)
    1afe:	639c                	ld	a5,0(a5)
    1b00:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1b04:	fe843783          	ld	a5,-24(s0)
    1b08:	4798                	lw	a4,8(a5)
    1b0a:	fdc42783          	lw	a5,-36(s0)
    1b0e:	2781                	sext.w	a5,a5
    1b10:	06f76763          	bltu	a4,a5,1b7e <malloc+0xf0>
      if(p->s.size == nunits)
    1b14:	fe843783          	ld	a5,-24(s0)
    1b18:	4798                	lw	a4,8(a5)
    1b1a:	fdc42783          	lw	a5,-36(s0)
    1b1e:	2781                	sext.w	a5,a5
    1b20:	00e79963          	bne	a5,a4,1b32 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1b24:	fe843783          	ld	a5,-24(s0)
    1b28:	6398                	ld	a4,0(a5)
    1b2a:	fe043783          	ld	a5,-32(s0)
    1b2e:	e398                	sd	a4,0(a5)
    1b30:	a825                	j	1b68 <malloc+0xda>
      else {
        p->s.size -= nunits;
    1b32:	fe843783          	ld	a5,-24(s0)
    1b36:	479c                	lw	a5,8(a5)
    1b38:	fdc42703          	lw	a4,-36(s0)
    1b3c:	9f99                	subw	a5,a5,a4
    1b3e:	0007871b          	sext.w	a4,a5
    1b42:	fe843783          	ld	a5,-24(s0)
    1b46:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1b48:	fe843783          	ld	a5,-24(s0)
    1b4c:	479c                	lw	a5,8(a5)
    1b4e:	1782                	slli	a5,a5,0x20
    1b50:	9381                	srli	a5,a5,0x20
    1b52:	0792                	slli	a5,a5,0x4
    1b54:	fe843703          	ld	a4,-24(s0)
    1b58:	97ba                	add	a5,a5,a4
    1b5a:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1b5e:	fe843783          	ld	a5,-24(s0)
    1b62:	fdc42703          	lw	a4,-36(s0)
    1b66:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1b68:	00001797          	auipc	a5,0x1
    1b6c:	8f878793          	addi	a5,a5,-1800 # 2460 <freep>
    1b70:	fe043703          	ld	a4,-32(s0)
    1b74:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1b76:	fe843783          	ld	a5,-24(s0)
    1b7a:	07c1                	addi	a5,a5,16
    1b7c:	a091                	j	1bc0 <malloc+0x132>
    }
    if(p == freep)
    1b7e:	00001797          	auipc	a5,0x1
    1b82:	8e278793          	addi	a5,a5,-1822 # 2460 <freep>
    1b86:	639c                	ld	a5,0(a5)
    1b88:	fe843703          	ld	a4,-24(s0)
    1b8c:	02f71063          	bne	a4,a5,1bac <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    1b90:	fdc42783          	lw	a5,-36(s0)
    1b94:	853e                	mv	a0,a5
    1b96:	00000097          	auipc	ra,0x0
    1b9a:	e78080e7          	jalr	-392(ra) # 1a0e <morecore>
    1b9e:	fea43423          	sd	a0,-24(s0)
    1ba2:	fe843783          	ld	a5,-24(s0)
    1ba6:	e399                	bnez	a5,1bac <malloc+0x11e>
        return 0;
    1ba8:	4781                	li	a5,0
    1baa:	a819                	j	1bc0 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1bac:	fe843783          	ld	a5,-24(s0)
    1bb0:	fef43023          	sd	a5,-32(s0)
    1bb4:	fe843783          	ld	a5,-24(s0)
    1bb8:	639c                	ld	a5,0(a5)
    1bba:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1bbe:	b799                	j	1b04 <malloc+0x76>
  }
}
    1bc0:	853e                	mv	a0,a5
    1bc2:	70e2                	ld	ra,56(sp)
    1bc4:	7442                	ld	s0,48(sp)
    1bc6:	6121                	addi	sp,sp,64
    1bc8:	8082                	ret

0000000000001bca <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
    1bca:	7179                	addi	sp,sp,-48
    1bcc:	f406                	sd	ra,40(sp)
    1bce:	f022                	sd	s0,32(sp)
    1bd0:	1800                	addi	s0,sp,48
    1bd2:	fca43c23          	sd	a0,-40(s0)
    1bd6:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
    1bda:	6505                	lui	a0,0x1
    1bdc:	00000097          	auipc	ra,0x0
    1be0:	eb2080e7          	jalr	-334(ra) # 1a8e <malloc>
    1be4:	fea43423          	sd	a0,-24(s0)
    1be8:	fe843783          	ld	a5,-24(s0)
    1bec:	e38d                	bnez	a5,1c0e <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
    1bee:	00000517          	auipc	a0,0x0
    1bf2:	40a50513          	addi	a0,a0,1034 # 1ff8 <lock_init+0x324>
    1bf6:	00000097          	auipc	ra,0x0
    1bfa:	ca6080e7          	jalr	-858(ra) # 189c <printf>
        free(stack);
    1bfe:	fe843503          	ld	a0,-24(s0)
    1c02:	00000097          	auipc	ra,0x0
    1c06:	cea080e7          	jalr	-790(ra) # 18ec <free>
        return -1;
    1c0a:	57fd                	li	a5,-1
    1c0c:	a099                	j	1c52 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
    1c0e:	fe843783          	ld	a5,-24(s0)
    1c12:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
    1c16:	fe043703          	ld	a4,-32(s0)
    1c1a:	6785                	lui	a5,0x1
    1c1c:	17fd                	addi	a5,a5,-1
    1c1e:	8ff9                	and	a5,a5,a4
    1c20:	cf91                	beqz	a5,1c3c <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
    1c22:	fe043703          	ld	a4,-32(s0)
    1c26:	6785                	lui	a5,0x1
    1c28:	17fd                	addi	a5,a5,-1
    1c2a:	8ff9                	and	a5,a5,a4
    1c2c:	6705                	lui	a4,0x1
    1c2e:	40f707b3          	sub	a5,a4,a5
    1c32:	fe843703          	ld	a4,-24(s0)
    1c36:	97ba                	add	a5,a5,a4
    1c38:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
    1c3c:	fe843603          	ld	a2,-24(s0)
    1c40:	fd043583          	ld	a1,-48(s0)
    1c44:	fd843503          	ld	a0,-40(s0)
    1c48:	fffff097          	auipc	ra,0xfffff
    1c4c:	7bc080e7          	jalr	1980(ra) # 1404 <clone>
    1c50:	87aa                	mv	a5,a0
}
    1c52:	853e                	mv	a0,a5
    1c54:	70a2                	ld	ra,40(sp)
    1c56:	7402                	ld	s0,32(sp)
    1c58:	6145                	addi	sp,sp,48
    1c5a:	8082                	ret

0000000000001c5c <thread_join>:


int thread_join()
{
    1c5c:	1101                	addi	sp,sp,-32
    1c5e:	ec06                	sd	ra,24(sp)
    1c60:	e822                	sd	s0,16(sp)
    1c62:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
    1c64:	fe040793          	addi	a5,s0,-32
    1c68:	853e                	mv	a0,a5
    1c6a:	fffff097          	auipc	ra,0xfffff
    1c6e:	7a2080e7          	jalr	1954(ra) # 140c <join>
    1c72:	87aa                	mv	a5,a0
    1c74:	fef42623          	sw	a5,-20(s0)
    1c78:	fec42783          	lw	a5,-20(s0)
    1c7c:	0007871b          	sext.w	a4,a5
    1c80:	57fd                	li	a5,-1
    1c82:	00f70963          	beq	a4,a5,1c94 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
    1c86:	fe043783          	ld	a5,-32(s0)
    1c8a:	853e                	mv	a0,a5
    1c8c:	00000097          	auipc	ra,0x0
    1c90:	c60080e7          	jalr	-928(ra) # 18ec <free>
    } 

    return child_tid;
    1c94:	fec42783          	lw	a5,-20(s0)
}
    1c98:	853e                	mv	a0,a5
    1c9a:	60e2                	ld	ra,24(sp)
    1c9c:	6442                	ld	s0,16(sp)
    1c9e:	6105                	addi	sp,sp,32
    1ca0:	8082                	ret

0000000000001ca2 <lock_acquire>:


void lock_acquire (lock_t *lock)
{
    1ca2:	1101                	addi	sp,sp,-32
    1ca4:	ec22                	sd	s0,24(sp)
    1ca6:	1000                	addi	s0,sp,32
    1ca8:	fea43423          	sd	a0,-24(s0)
        lock = 0;
    1cac:	fe043423          	sd	zero,-24(s0)

}
    1cb0:	0001                	nop
    1cb2:	6462                	ld	s0,24(sp)
    1cb4:	6105                	addi	sp,sp,32
    1cb6:	8082                	ret

0000000000001cb8 <lock_release>:

void lock_release (lock_t *lock)
{
    1cb8:	1101                	addi	sp,sp,-32
    1cba:	ec22                	sd	s0,24(sp)
    1cbc:	1000                	addi	s0,sp,32
    1cbe:	fea43423          	sd	a0,-24(s0)
        __sync_lock_test_and_set(lock, 1);
    1cc2:	fe843783          	ld	a5,-24(s0)
    1cc6:	4705                	li	a4,1
    1cc8:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    
}
    1ccc:	0001                	nop
    1cce:	6462                	ld	s0,24(sp)
    1cd0:	6105                	addi	sp,sp,32
    1cd2:	8082                	ret

0000000000001cd4 <lock_init>:

void lock_init (lock_t *lock)
{
    1cd4:	1101                	addi	sp,sp,-32
    1cd6:	ec22                	sd	s0,24(sp)
    1cd8:	1000                	addi	s0,sp,32
    1cda:	fea43423          	sd	a0,-24(s0)
    lock = 0;
    1cde:	fe043423          	sd	zero,-24(s0)
    
}
    1ce2:	0001                	nop
    1ce4:	6462                	ld	s0,24(sp)
    1ce6:	6105                	addi	sp,sp,32
    1ce8:	8082                	ret
