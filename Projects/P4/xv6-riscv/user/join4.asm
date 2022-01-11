
user/_join4:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

void worker(void *arg_ptr);

int
main(int argc, char *argv[])
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	0080                	addi	s0,sp,64
       8:	87aa                	mv	a5,a0
       a:	fcb43023          	sd	a1,-64(s0)
       e:	fcf42623          	sw	a5,-52(s0)
   ppid = getpid();
      12:	00001097          	auipc	ra,0x1
      16:	97c080e7          	jalr	-1668(ra) # 98e <getpid>
      1a:	87aa                	mv	a5,a0
      1c:	873e                	mv	a4,a5
      1e:	00001797          	auipc	a5,0x1
      22:	3ba78793          	addi	a5,a5,954 # 13d8 <ppid>
      26:	c398                	sw	a4,0(a5)

   void *stack = malloc(PGSIZE*2);
      28:	6509                	lui	a0,0x2
      2a:	00001097          	auipc	ra,0x1
      2e:	00e080e7          	jalr	14(ra) # 1038 <malloc>
      32:	fea43423          	sd	a0,-24(s0)
   assert(stack != NULL);
      36:	fe843783          	ld	a5,-24(s0)
      3a:	e3ad                	bnez	a5,9c <main+0x9c>
      3c:	4675                	li	a2,29
      3e:	00001597          	auipc	a1,0x1
      42:	24a58593          	addi	a1,a1,586 # 1288 <lock_init+0x18>
      46:	00001517          	auipc	a0,0x1
      4a:	25250513          	addi	a0,a0,594 # 1298 <lock_init+0x28>
      4e:	00001097          	auipc	ra,0x1
      52:	df8080e7          	jalr	-520(ra) # e46 <printf>
      56:	00001597          	auipc	a1,0x1
      5a:	24a58593          	addi	a1,a1,586 # 12a0 <lock_init+0x30>
      5e:	00001517          	auipc	a0,0x1
      62:	25250513          	addi	a0,a0,594 # 12b0 <lock_init+0x40>
      66:	00001097          	auipc	ra,0x1
      6a:	de0080e7          	jalr	-544(ra) # e46 <printf>
      6e:	00001517          	auipc	a0,0x1
      72:	25a50513          	addi	a0,a0,602 # 12c8 <lock_init+0x58>
      76:	00001097          	auipc	ra,0x1
      7a:	dd0080e7          	jalr	-560(ra) # e46 <printf>
      7e:	00001797          	auipc	a5,0x1
      82:	35a78793          	addi	a5,a5,858 # 13d8 <ppid>
      86:	439c                	lw	a5,0(a5)
      88:	853e                	mv	a0,a5
      8a:	00001097          	auipc	ra,0x1
      8e:	8b4080e7          	jalr	-1868(ra) # 93e <kill>
      92:	4501                	li	a0,0
      94:	00001097          	auipc	ra,0x1
      98:	87a080e7          	jalr	-1926(ra) # 90e <exit>
   if((uint64)stack % PGSIZE)
      9c:	fe843703          	ld	a4,-24(s0)
      a0:	6785                	lui	a5,0x1
      a2:	17fd                	addi	a5,a5,-1
      a4:	8ff9                	and	a5,a5,a4
      a6:	cf91                	beqz	a5,c2 <main+0xc2>
     stack = stack + (4096 - (uint64)stack % PGSIZE);
      a8:	fe843703          	ld	a4,-24(s0)
      ac:	6785                	lui	a5,0x1
      ae:	17fd                	addi	a5,a5,-1
      b0:	8ff9                	and	a5,a5,a4
      b2:	6705                	lui	a4,0x1
      b4:	40f707b3          	sub	a5,a4,a5
      b8:	fe843703          	ld	a4,-24(s0)
      bc:	97ba                	add	a5,a5,a4
      be:	fef43423          	sd	a5,-24(s0)

   int arg = 42;
      c2:	02a00793          	li	a5,42
      c6:	fcf42e23          	sw	a5,-36(s0)
   int clone_pid = clone(worker, &arg, stack);
      ca:	fdc40793          	addi	a5,s0,-36
      ce:	fe843603          	ld	a2,-24(s0)
      d2:	85be                	mv	a1,a5
      d4:	00000517          	auipc	a0,0x0
      d8:	28850513          	addi	a0,a0,648 # 35c <worker>
      dc:	00001097          	auipc	ra,0x1
      e0:	8d2080e7          	jalr	-1838(ra) # 9ae <clone>
      e4:	87aa                	mv	a5,a0
      e6:	fef42223          	sw	a5,-28(s0)
   assert(clone_pid > 0);
      ea:	fe442783          	lw	a5,-28(s0)
      ee:	2781                	sext.w	a5,a5
      f0:	06f04363          	bgtz	a5,156 <main+0x156>
      f4:	02300613          	li	a2,35
      f8:	00001597          	auipc	a1,0x1
      fc:	19058593          	addi	a1,a1,400 # 1288 <lock_init+0x18>
     100:	00001517          	auipc	a0,0x1
     104:	19850513          	addi	a0,a0,408 # 1298 <lock_init+0x28>
     108:	00001097          	auipc	ra,0x1
     10c:	d3e080e7          	jalr	-706(ra) # e46 <printf>
     110:	00001597          	auipc	a1,0x1
     114:	1c858593          	addi	a1,a1,456 # 12d8 <lock_init+0x68>
     118:	00001517          	auipc	a0,0x1
     11c:	19850513          	addi	a0,a0,408 # 12b0 <lock_init+0x40>
     120:	00001097          	auipc	ra,0x1
     124:	d26080e7          	jalr	-730(ra) # e46 <printf>
     128:	00001517          	auipc	a0,0x1
     12c:	1a050513          	addi	a0,a0,416 # 12c8 <lock_init+0x58>
     130:	00001097          	auipc	ra,0x1
     134:	d16080e7          	jalr	-746(ra) # e46 <printf>
     138:	00001797          	auipc	a5,0x1
     13c:	2a078793          	addi	a5,a5,672 # 13d8 <ppid>
     140:	439c                	lw	a5,0(a5)
     142:	853e                	mv	a0,a5
     144:	00000097          	auipc	ra,0x0
     148:	7fa080e7          	jalr	2042(ra) # 93e <kill>
     14c:	4501                	li	a0,0
     14e:	00000097          	auipc	ra,0x0
     152:	7c0080e7          	jalr	1984(ra) # 90e <exit>

   sleep(250);
     156:	0fa00513          	li	a0,250
     15a:	00001097          	auipc	ra,0x1
     15e:	844080e7          	jalr	-1980(ra) # 99e <sleep>
   assert(wait(0) == -1);
     162:	4501                	li	a0,0
     164:	00000097          	auipc	ra,0x0
     168:	7b2080e7          	jalr	1970(ra) # 916 <wait>
     16c:	87aa                	mv	a5,a0
     16e:	873e                	mv	a4,a5
     170:	57fd                	li	a5,-1
     172:	06f70363          	beq	a4,a5,1d8 <main+0x1d8>
     176:	02600613          	li	a2,38
     17a:	00001597          	auipc	a1,0x1
     17e:	10e58593          	addi	a1,a1,270 # 1288 <lock_init+0x18>
     182:	00001517          	auipc	a0,0x1
     186:	11650513          	addi	a0,a0,278 # 1298 <lock_init+0x28>
     18a:	00001097          	auipc	ra,0x1
     18e:	cbc080e7          	jalr	-836(ra) # e46 <printf>
     192:	00001597          	auipc	a1,0x1
     196:	15658593          	addi	a1,a1,342 # 12e8 <lock_init+0x78>
     19a:	00001517          	auipc	a0,0x1
     19e:	11650513          	addi	a0,a0,278 # 12b0 <lock_init+0x40>
     1a2:	00001097          	auipc	ra,0x1
     1a6:	ca4080e7          	jalr	-860(ra) # e46 <printf>
     1aa:	00001517          	auipc	a0,0x1
     1ae:	11e50513          	addi	a0,a0,286 # 12c8 <lock_init+0x58>
     1b2:	00001097          	auipc	ra,0x1
     1b6:	c94080e7          	jalr	-876(ra) # e46 <printf>
     1ba:	00001797          	auipc	a5,0x1
     1be:	21e78793          	addi	a5,a5,542 # 13d8 <ppid>
     1c2:	439c                	lw	a5,0(a5)
     1c4:	853e                	mv	a0,a5
     1c6:	00000097          	auipc	ra,0x0
     1ca:	778080e7          	jalr	1912(ra) # 93e <kill>
     1ce:	4501                	li	a0,0
     1d0:	00000097          	auipc	ra,0x0
     1d4:	73e080e7          	jalr	1854(ra) # 90e <exit>

   void *join_stack;
   int join_pid = join(&join_stack);
     1d8:	fd040793          	addi	a5,s0,-48
     1dc:	853e                	mv	a0,a5
     1de:	00000097          	auipc	ra,0x0
     1e2:	7d8080e7          	jalr	2008(ra) # 9b6 <join>
     1e6:	87aa                	mv	a5,a0
     1e8:	fef42023          	sw	a5,-32(s0)
   assert(join_pid == clone_pid);
     1ec:	fe042783          	lw	a5,-32(s0)
     1f0:	873e                	mv	a4,a5
     1f2:	fe442783          	lw	a5,-28(s0)
     1f6:	2701                	sext.w	a4,a4
     1f8:	2781                	sext.w	a5,a5
     1fa:	06f70363          	beq	a4,a5,260 <main+0x260>
     1fe:	02a00613          	li	a2,42
     202:	00001597          	auipc	a1,0x1
     206:	08658593          	addi	a1,a1,134 # 1288 <lock_init+0x18>
     20a:	00001517          	auipc	a0,0x1
     20e:	08e50513          	addi	a0,a0,142 # 1298 <lock_init+0x28>
     212:	00001097          	auipc	ra,0x1
     216:	c34080e7          	jalr	-972(ra) # e46 <printf>
     21a:	00001597          	auipc	a1,0x1
     21e:	0de58593          	addi	a1,a1,222 # 12f8 <lock_init+0x88>
     222:	00001517          	auipc	a0,0x1
     226:	08e50513          	addi	a0,a0,142 # 12b0 <lock_init+0x40>
     22a:	00001097          	auipc	ra,0x1
     22e:	c1c080e7          	jalr	-996(ra) # e46 <printf>
     232:	00001517          	auipc	a0,0x1
     236:	09650513          	addi	a0,a0,150 # 12c8 <lock_init+0x58>
     23a:	00001097          	auipc	ra,0x1
     23e:	c0c080e7          	jalr	-1012(ra) # e46 <printf>
     242:	00001797          	auipc	a5,0x1
     246:	19678793          	addi	a5,a5,406 # 13d8 <ppid>
     24a:	439c                	lw	a5,0(a5)
     24c:	853e                	mv	a0,a5
     24e:	00000097          	auipc	ra,0x0
     252:	6f0080e7          	jalr	1776(ra) # 93e <kill>
     256:	4501                	li	a0,0
     258:	00000097          	auipc	ra,0x0
     25c:	6b6080e7          	jalr	1718(ra) # 90e <exit>
   assert(stack == join_stack);
     260:	fd043783          	ld	a5,-48(s0)
     264:	fe843703          	ld	a4,-24(s0)
     268:	06f70363          	beq	a4,a5,2ce <main+0x2ce>
     26c:	02b00613          	li	a2,43
     270:	00001597          	auipc	a1,0x1
     274:	01858593          	addi	a1,a1,24 # 1288 <lock_init+0x18>
     278:	00001517          	auipc	a0,0x1
     27c:	02050513          	addi	a0,a0,32 # 1298 <lock_init+0x28>
     280:	00001097          	auipc	ra,0x1
     284:	bc6080e7          	jalr	-1082(ra) # e46 <printf>
     288:	00001597          	auipc	a1,0x1
     28c:	08858593          	addi	a1,a1,136 # 1310 <lock_init+0xa0>
     290:	00001517          	auipc	a0,0x1
     294:	02050513          	addi	a0,a0,32 # 12b0 <lock_init+0x40>
     298:	00001097          	auipc	ra,0x1
     29c:	bae080e7          	jalr	-1106(ra) # e46 <printf>
     2a0:	00001517          	auipc	a0,0x1
     2a4:	02850513          	addi	a0,a0,40 # 12c8 <lock_init+0x58>
     2a8:	00001097          	auipc	ra,0x1
     2ac:	b9e080e7          	jalr	-1122(ra) # e46 <printf>
     2b0:	00001797          	auipc	a5,0x1
     2b4:	12878793          	addi	a5,a5,296 # 13d8 <ppid>
     2b8:	439c                	lw	a5,0(a5)
     2ba:	853e                	mv	a0,a5
     2bc:	00000097          	auipc	ra,0x0
     2c0:	682080e7          	jalr	1666(ra) # 93e <kill>
     2c4:	4501                	li	a0,0
     2c6:	00000097          	auipc	ra,0x0
     2ca:	648080e7          	jalr	1608(ra) # 90e <exit>
   assert(global == 2);
     2ce:	00001797          	auipc	a5,0x1
     2d2:	10678793          	addi	a5,a5,262 # 13d4 <global>
     2d6:	439c                	lw	a5,0(a5)
     2d8:	873e                	mv	a4,a5
     2da:	4789                	li	a5,2
     2dc:	06f70363          	beq	a4,a5,342 <main+0x342>
     2e0:	02c00613          	li	a2,44
     2e4:	00001597          	auipc	a1,0x1
     2e8:	fa458593          	addi	a1,a1,-92 # 1288 <lock_init+0x18>
     2ec:	00001517          	auipc	a0,0x1
     2f0:	fac50513          	addi	a0,a0,-84 # 1298 <lock_init+0x28>
     2f4:	00001097          	auipc	ra,0x1
     2f8:	b52080e7          	jalr	-1198(ra) # e46 <printf>
     2fc:	00001597          	auipc	a1,0x1
     300:	02c58593          	addi	a1,a1,44 # 1328 <lock_init+0xb8>
     304:	00001517          	auipc	a0,0x1
     308:	fac50513          	addi	a0,a0,-84 # 12b0 <lock_init+0x40>
     30c:	00001097          	auipc	ra,0x1
     310:	b3a080e7          	jalr	-1222(ra) # e46 <printf>
     314:	00001517          	auipc	a0,0x1
     318:	fb450513          	addi	a0,a0,-76 # 12c8 <lock_init+0x58>
     31c:	00001097          	auipc	ra,0x1
     320:	b2a080e7          	jalr	-1238(ra) # e46 <printf>
     324:	00001797          	auipc	a5,0x1
     328:	0b478793          	addi	a5,a5,180 # 13d8 <ppid>
     32c:	439c                	lw	a5,0(a5)
     32e:	853e                	mv	a0,a5
     330:	00000097          	auipc	ra,0x0
     334:	60e080e7          	jalr	1550(ra) # 93e <kill>
     338:	4501                	li	a0,0
     33a:	00000097          	auipc	ra,0x0
     33e:	5d4080e7          	jalr	1492(ra) # 90e <exit>

   printf("TEST PASSED\n");
     342:	00001517          	auipc	a0,0x1
     346:	ff650513          	addi	a0,a0,-10 # 1338 <lock_init+0xc8>
     34a:	00001097          	auipc	ra,0x1
     34e:	afc080e7          	jalr	-1284(ra) # e46 <printf>
   exit(0);
     352:	4501                	li	a0,0
     354:	00000097          	auipc	ra,0x0
     358:	5ba080e7          	jalr	1466(ra) # 90e <exit>

000000000000035c <worker>:
}

void
worker(void *arg_ptr) {
     35c:	7179                	addi	sp,sp,-48
     35e:	f406                	sd	ra,40(sp)
     360:	f022                	sd	s0,32(sp)
     362:	1800                	addi	s0,sp,48
     364:	fca43c23          	sd	a0,-40(s0)
   int arg = *(int*)arg_ptr;
     368:	fd843783          	ld	a5,-40(s0)
     36c:	439c                	lw	a5,0(a5)
     36e:	fef42623          	sw	a5,-20(s0)
   assert(arg == 42);
     372:	fec42783          	lw	a5,-20(s0)
     376:	0007871b          	sext.w	a4,a5
     37a:	02a00793          	li	a5,42
     37e:	06f70363          	beq	a4,a5,3e4 <worker+0x88>
     382:	03500613          	li	a2,53
     386:	00001597          	auipc	a1,0x1
     38a:	f0258593          	addi	a1,a1,-254 # 1288 <lock_init+0x18>
     38e:	00001517          	auipc	a0,0x1
     392:	f0a50513          	addi	a0,a0,-246 # 1298 <lock_init+0x28>
     396:	00001097          	auipc	ra,0x1
     39a:	ab0080e7          	jalr	-1360(ra) # e46 <printf>
     39e:	00001597          	auipc	a1,0x1
     3a2:	faa58593          	addi	a1,a1,-86 # 1348 <lock_init+0xd8>
     3a6:	00001517          	auipc	a0,0x1
     3aa:	f0a50513          	addi	a0,a0,-246 # 12b0 <lock_init+0x40>
     3ae:	00001097          	auipc	ra,0x1
     3b2:	a98080e7          	jalr	-1384(ra) # e46 <printf>
     3b6:	00001517          	auipc	a0,0x1
     3ba:	f1250513          	addi	a0,a0,-238 # 12c8 <lock_init+0x58>
     3be:	00001097          	auipc	ra,0x1
     3c2:	a88080e7          	jalr	-1400(ra) # e46 <printf>
     3c6:	00001797          	auipc	a5,0x1
     3ca:	01278793          	addi	a5,a5,18 # 13d8 <ppid>
     3ce:	439c                	lw	a5,0(a5)
     3d0:	853e                	mv	a0,a5
     3d2:	00000097          	auipc	ra,0x0
     3d6:	56c080e7          	jalr	1388(ra) # 93e <kill>
     3da:	4501                	li	a0,0
     3dc:	00000097          	auipc	ra,0x0
     3e0:	532080e7          	jalr	1330(ra) # 90e <exit>
   assert(global == 1);
     3e4:	00001797          	auipc	a5,0x1
     3e8:	ff078793          	addi	a5,a5,-16 # 13d4 <global>
     3ec:	439c                	lw	a5,0(a5)
     3ee:	873e                	mv	a4,a5
     3f0:	4785                	li	a5,1
     3f2:	06f70363          	beq	a4,a5,458 <worker+0xfc>
     3f6:	03600613          	li	a2,54
     3fa:	00001597          	auipc	a1,0x1
     3fe:	e8e58593          	addi	a1,a1,-370 # 1288 <lock_init+0x18>
     402:	00001517          	auipc	a0,0x1
     406:	e9650513          	addi	a0,a0,-362 # 1298 <lock_init+0x28>
     40a:	00001097          	auipc	ra,0x1
     40e:	a3c080e7          	jalr	-1476(ra) # e46 <printf>
     412:	00001597          	auipc	a1,0x1
     416:	f4658593          	addi	a1,a1,-186 # 1358 <lock_init+0xe8>
     41a:	00001517          	auipc	a0,0x1
     41e:	e9650513          	addi	a0,a0,-362 # 12b0 <lock_init+0x40>
     422:	00001097          	auipc	ra,0x1
     426:	a24080e7          	jalr	-1500(ra) # e46 <printf>
     42a:	00001517          	auipc	a0,0x1
     42e:	e9e50513          	addi	a0,a0,-354 # 12c8 <lock_init+0x58>
     432:	00001097          	auipc	ra,0x1
     436:	a14080e7          	jalr	-1516(ra) # e46 <printf>
     43a:	00001797          	auipc	a5,0x1
     43e:	f9e78793          	addi	a5,a5,-98 # 13d8 <ppid>
     442:	439c                	lw	a5,0(a5)
     444:	853e                	mv	a0,a5
     446:	00000097          	auipc	ra,0x0
     44a:	4f8080e7          	jalr	1272(ra) # 93e <kill>
     44e:	4501                	li	a0,0
     450:	00000097          	auipc	ra,0x0
     454:	4be080e7          	jalr	1214(ra) # 90e <exit>
   global++;
     458:	00001797          	auipc	a5,0x1
     45c:	f7c78793          	addi	a5,a5,-132 # 13d4 <global>
     460:	439c                	lw	a5,0(a5)
     462:	2785                	addiw	a5,a5,1
     464:	0007871b          	sext.w	a4,a5
     468:	00001797          	auipc	a5,0x1
     46c:	f6c78793          	addi	a5,a5,-148 # 13d4 <global>
     470:	c398                	sw	a4,0(a5)
   exit(0);
     472:	4501                	li	a0,0
     474:	00000097          	auipc	ra,0x0
     478:	49a080e7          	jalr	1178(ra) # 90e <exit>

000000000000047c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     47c:	7179                	addi	sp,sp,-48
     47e:	f422                	sd	s0,40(sp)
     480:	1800                	addi	s0,sp,48
     482:	fca43c23          	sd	a0,-40(s0)
     486:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     48a:	fd843783          	ld	a5,-40(s0)
     48e:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     492:	0001                	nop
     494:	fd043703          	ld	a4,-48(s0)
     498:	00170793          	addi	a5,a4,1 # 1001 <morecore+0x49>
     49c:	fcf43823          	sd	a5,-48(s0)
     4a0:	fd843783          	ld	a5,-40(s0)
     4a4:	00178693          	addi	a3,a5,1
     4a8:	fcd43c23          	sd	a3,-40(s0)
     4ac:	00074703          	lbu	a4,0(a4)
     4b0:	00e78023          	sb	a4,0(a5)
     4b4:	0007c783          	lbu	a5,0(a5)
     4b8:	fff1                	bnez	a5,494 <strcpy+0x18>
    ;
  return os;
     4ba:	fe843783          	ld	a5,-24(s0)
}
     4be:	853e                	mv	a0,a5
     4c0:	7422                	ld	s0,40(sp)
     4c2:	6145                	addi	sp,sp,48
     4c4:	8082                	ret

00000000000004c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     4c6:	1101                	addi	sp,sp,-32
     4c8:	ec22                	sd	s0,24(sp)
     4ca:	1000                	addi	s0,sp,32
     4cc:	fea43423          	sd	a0,-24(s0)
     4d0:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     4d4:	a819                	j	4ea <strcmp+0x24>
    p++, q++;
     4d6:	fe843783          	ld	a5,-24(s0)
     4da:	0785                	addi	a5,a5,1
     4dc:	fef43423          	sd	a5,-24(s0)
     4e0:	fe043783          	ld	a5,-32(s0)
     4e4:	0785                	addi	a5,a5,1
     4e6:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     4ea:	fe843783          	ld	a5,-24(s0)
     4ee:	0007c783          	lbu	a5,0(a5)
     4f2:	cb99                	beqz	a5,508 <strcmp+0x42>
     4f4:	fe843783          	ld	a5,-24(s0)
     4f8:	0007c703          	lbu	a4,0(a5)
     4fc:	fe043783          	ld	a5,-32(s0)
     500:	0007c783          	lbu	a5,0(a5)
     504:	fcf709e3          	beq	a4,a5,4d6 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     508:	fe843783          	ld	a5,-24(s0)
     50c:	0007c783          	lbu	a5,0(a5)
     510:	0007871b          	sext.w	a4,a5
     514:	fe043783          	ld	a5,-32(s0)
     518:	0007c783          	lbu	a5,0(a5)
     51c:	2781                	sext.w	a5,a5
     51e:	40f707bb          	subw	a5,a4,a5
     522:	2781                	sext.w	a5,a5
}
     524:	853e                	mv	a0,a5
     526:	6462                	ld	s0,24(sp)
     528:	6105                	addi	sp,sp,32
     52a:	8082                	ret

000000000000052c <strlen>:

uint
strlen(const char *s)
{
     52c:	7179                	addi	sp,sp,-48
     52e:	f422                	sd	s0,40(sp)
     530:	1800                	addi	s0,sp,48
     532:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     536:	fe042623          	sw	zero,-20(s0)
     53a:	a031                	j	546 <strlen+0x1a>
     53c:	fec42783          	lw	a5,-20(s0)
     540:	2785                	addiw	a5,a5,1
     542:	fef42623          	sw	a5,-20(s0)
     546:	fec42783          	lw	a5,-20(s0)
     54a:	fd843703          	ld	a4,-40(s0)
     54e:	97ba                	add	a5,a5,a4
     550:	0007c783          	lbu	a5,0(a5)
     554:	f7e5                	bnez	a5,53c <strlen+0x10>
    ;
  return n;
     556:	fec42783          	lw	a5,-20(s0)
}
     55a:	853e                	mv	a0,a5
     55c:	7422                	ld	s0,40(sp)
     55e:	6145                	addi	sp,sp,48
     560:	8082                	ret

0000000000000562 <memset>:

void*
memset(void *dst, int c, uint n)
{
     562:	7179                	addi	sp,sp,-48
     564:	f422                	sd	s0,40(sp)
     566:	1800                	addi	s0,sp,48
     568:	fca43c23          	sd	a0,-40(s0)
     56c:	87ae                	mv	a5,a1
     56e:	8732                	mv	a4,a2
     570:	fcf42a23          	sw	a5,-44(s0)
     574:	87ba                	mv	a5,a4
     576:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     57a:	fd843783          	ld	a5,-40(s0)
     57e:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     582:	fe042623          	sw	zero,-20(s0)
     586:	a00d                	j	5a8 <memset+0x46>
    cdst[i] = c;
     588:	fec42783          	lw	a5,-20(s0)
     58c:	fe043703          	ld	a4,-32(s0)
     590:	97ba                	add	a5,a5,a4
     592:	fd442703          	lw	a4,-44(s0)
     596:	0ff77713          	zext.b	a4,a4
     59a:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     59e:	fec42783          	lw	a5,-20(s0)
     5a2:	2785                	addiw	a5,a5,1
     5a4:	fef42623          	sw	a5,-20(s0)
     5a8:	fec42703          	lw	a4,-20(s0)
     5ac:	fd042783          	lw	a5,-48(s0)
     5b0:	2781                	sext.w	a5,a5
     5b2:	fcf76be3          	bltu	a4,a5,588 <memset+0x26>
  }
  return dst;
     5b6:	fd843783          	ld	a5,-40(s0)
}
     5ba:	853e                	mv	a0,a5
     5bc:	7422                	ld	s0,40(sp)
     5be:	6145                	addi	sp,sp,48
     5c0:	8082                	ret

00000000000005c2 <strchr>:

char*
strchr(const char *s, char c)
{
     5c2:	1101                	addi	sp,sp,-32
     5c4:	ec22                	sd	s0,24(sp)
     5c6:	1000                	addi	s0,sp,32
     5c8:	fea43423          	sd	a0,-24(s0)
     5cc:	87ae                	mv	a5,a1
     5ce:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     5d2:	a01d                	j	5f8 <strchr+0x36>
    if(*s == c)
     5d4:	fe843783          	ld	a5,-24(s0)
     5d8:	0007c703          	lbu	a4,0(a5)
     5dc:	fe744783          	lbu	a5,-25(s0)
     5e0:	0ff7f793          	zext.b	a5,a5
     5e4:	00e79563          	bne	a5,a4,5ee <strchr+0x2c>
      return (char*)s;
     5e8:	fe843783          	ld	a5,-24(s0)
     5ec:	a821                	j	604 <strchr+0x42>
  for(; *s; s++)
     5ee:	fe843783          	ld	a5,-24(s0)
     5f2:	0785                	addi	a5,a5,1
     5f4:	fef43423          	sd	a5,-24(s0)
     5f8:	fe843783          	ld	a5,-24(s0)
     5fc:	0007c783          	lbu	a5,0(a5)
     600:	fbf1                	bnez	a5,5d4 <strchr+0x12>
  return 0;
     602:	4781                	li	a5,0
}
     604:	853e                	mv	a0,a5
     606:	6462                	ld	s0,24(sp)
     608:	6105                	addi	sp,sp,32
     60a:	8082                	ret

000000000000060c <gets>:

char*
gets(char *buf, int max)
{
     60c:	7179                	addi	sp,sp,-48
     60e:	f406                	sd	ra,40(sp)
     610:	f022                	sd	s0,32(sp)
     612:	1800                	addi	s0,sp,48
     614:	fca43c23          	sd	a0,-40(s0)
     618:	87ae                	mv	a5,a1
     61a:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     61e:	fe042623          	sw	zero,-20(s0)
     622:	a8a1                	j	67a <gets+0x6e>
    cc = read(0, &c, 1);
     624:	fe740793          	addi	a5,s0,-25
     628:	4605                	li	a2,1
     62a:	85be                	mv	a1,a5
     62c:	4501                	li	a0,0
     62e:	00000097          	auipc	ra,0x0
     632:	2f8080e7          	jalr	760(ra) # 926 <read>
     636:	87aa                	mv	a5,a0
     638:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     63c:	fe842783          	lw	a5,-24(s0)
     640:	2781                	sext.w	a5,a5
     642:	04f05763          	blez	a5,690 <gets+0x84>
      break;
    buf[i++] = c;
     646:	fec42783          	lw	a5,-20(s0)
     64a:	0017871b          	addiw	a4,a5,1
     64e:	fee42623          	sw	a4,-20(s0)
     652:	873e                	mv	a4,a5
     654:	fd843783          	ld	a5,-40(s0)
     658:	97ba                	add	a5,a5,a4
     65a:	fe744703          	lbu	a4,-25(s0)
     65e:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     662:	fe744783          	lbu	a5,-25(s0)
     666:	873e                	mv	a4,a5
     668:	47a9                	li	a5,10
     66a:	02f70463          	beq	a4,a5,692 <gets+0x86>
     66e:	fe744783          	lbu	a5,-25(s0)
     672:	873e                	mv	a4,a5
     674:	47b5                	li	a5,13
     676:	00f70e63          	beq	a4,a5,692 <gets+0x86>
  for(i=0; i+1 < max; ){
     67a:	fec42783          	lw	a5,-20(s0)
     67e:	2785                	addiw	a5,a5,1
     680:	0007871b          	sext.w	a4,a5
     684:	fd442783          	lw	a5,-44(s0)
     688:	2781                	sext.w	a5,a5
     68a:	f8f74de3          	blt	a4,a5,624 <gets+0x18>
     68e:	a011                	j	692 <gets+0x86>
      break;
     690:	0001                	nop
      break;
  }
  buf[i] = '\0';
     692:	fec42783          	lw	a5,-20(s0)
     696:	fd843703          	ld	a4,-40(s0)
     69a:	97ba                	add	a5,a5,a4
     69c:	00078023          	sb	zero,0(a5)
  return buf;
     6a0:	fd843783          	ld	a5,-40(s0)
}
     6a4:	853e                	mv	a0,a5
     6a6:	70a2                	ld	ra,40(sp)
     6a8:	7402                	ld	s0,32(sp)
     6aa:	6145                	addi	sp,sp,48
     6ac:	8082                	ret

00000000000006ae <stat>:

int
stat(const char *n, struct stat *st)
{
     6ae:	7179                	addi	sp,sp,-48
     6b0:	f406                	sd	ra,40(sp)
     6b2:	f022                	sd	s0,32(sp)
     6b4:	1800                	addi	s0,sp,48
     6b6:	fca43c23          	sd	a0,-40(s0)
     6ba:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     6be:	4581                	li	a1,0
     6c0:	fd843503          	ld	a0,-40(s0)
     6c4:	00000097          	auipc	ra,0x0
     6c8:	28a080e7          	jalr	650(ra) # 94e <open>
     6cc:	87aa                	mv	a5,a0
     6ce:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     6d2:	fec42783          	lw	a5,-20(s0)
     6d6:	2781                	sext.w	a5,a5
     6d8:	0007d463          	bgez	a5,6e0 <stat+0x32>
    return -1;
     6dc:	57fd                	li	a5,-1
     6de:	a035                	j	70a <stat+0x5c>
  r = fstat(fd, st);
     6e0:	fec42783          	lw	a5,-20(s0)
     6e4:	fd043583          	ld	a1,-48(s0)
     6e8:	853e                	mv	a0,a5
     6ea:	00000097          	auipc	ra,0x0
     6ee:	27c080e7          	jalr	636(ra) # 966 <fstat>
     6f2:	87aa                	mv	a5,a0
     6f4:	fef42423          	sw	a5,-24(s0)
  close(fd);
     6f8:	fec42783          	lw	a5,-20(s0)
     6fc:	853e                	mv	a0,a5
     6fe:	00000097          	auipc	ra,0x0
     702:	238080e7          	jalr	568(ra) # 936 <close>
  return r;
     706:	fe842783          	lw	a5,-24(s0)
}
     70a:	853e                	mv	a0,a5
     70c:	70a2                	ld	ra,40(sp)
     70e:	7402                	ld	s0,32(sp)
     710:	6145                	addi	sp,sp,48
     712:	8082                	ret

0000000000000714 <atoi>:

int
atoi(const char *s)
{
     714:	7179                	addi	sp,sp,-48
     716:	f422                	sd	s0,40(sp)
     718:	1800                	addi	s0,sp,48
     71a:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     71e:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     722:	a81d                	j	758 <atoi+0x44>
    n = n*10 + *s++ - '0';
     724:	fec42783          	lw	a5,-20(s0)
     728:	873e                	mv	a4,a5
     72a:	87ba                	mv	a5,a4
     72c:	0027979b          	slliw	a5,a5,0x2
     730:	9fb9                	addw	a5,a5,a4
     732:	0017979b          	slliw	a5,a5,0x1
     736:	0007871b          	sext.w	a4,a5
     73a:	fd843783          	ld	a5,-40(s0)
     73e:	00178693          	addi	a3,a5,1
     742:	fcd43c23          	sd	a3,-40(s0)
     746:	0007c783          	lbu	a5,0(a5)
     74a:	2781                	sext.w	a5,a5
     74c:	9fb9                	addw	a5,a5,a4
     74e:	2781                	sext.w	a5,a5
     750:	fd07879b          	addiw	a5,a5,-48
     754:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     758:	fd843783          	ld	a5,-40(s0)
     75c:	0007c783          	lbu	a5,0(a5)
     760:	873e                	mv	a4,a5
     762:	02f00793          	li	a5,47
     766:	00e7fb63          	bgeu	a5,a4,77c <atoi+0x68>
     76a:	fd843783          	ld	a5,-40(s0)
     76e:	0007c783          	lbu	a5,0(a5)
     772:	873e                	mv	a4,a5
     774:	03900793          	li	a5,57
     778:	fae7f6e3          	bgeu	a5,a4,724 <atoi+0x10>
  return n;
     77c:	fec42783          	lw	a5,-20(s0)
}
     780:	853e                	mv	a0,a5
     782:	7422                	ld	s0,40(sp)
     784:	6145                	addi	sp,sp,48
     786:	8082                	ret

0000000000000788 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     788:	7139                	addi	sp,sp,-64
     78a:	fc22                	sd	s0,56(sp)
     78c:	0080                	addi	s0,sp,64
     78e:	fca43c23          	sd	a0,-40(s0)
     792:	fcb43823          	sd	a1,-48(s0)
     796:	87b2                	mv	a5,a2
     798:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     79c:	fd843783          	ld	a5,-40(s0)
     7a0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     7a4:	fd043783          	ld	a5,-48(s0)
     7a8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     7ac:	fe043703          	ld	a4,-32(s0)
     7b0:	fe843783          	ld	a5,-24(s0)
     7b4:	02e7fc63          	bgeu	a5,a4,7ec <memmove+0x64>
    while(n-- > 0)
     7b8:	a00d                	j	7da <memmove+0x52>
      *dst++ = *src++;
     7ba:	fe043703          	ld	a4,-32(s0)
     7be:	00170793          	addi	a5,a4,1
     7c2:	fef43023          	sd	a5,-32(s0)
     7c6:	fe843783          	ld	a5,-24(s0)
     7ca:	00178693          	addi	a3,a5,1
     7ce:	fed43423          	sd	a3,-24(s0)
     7d2:	00074703          	lbu	a4,0(a4)
     7d6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     7da:	fcc42783          	lw	a5,-52(s0)
     7de:	fff7871b          	addiw	a4,a5,-1
     7e2:	fce42623          	sw	a4,-52(s0)
     7e6:	fcf04ae3          	bgtz	a5,7ba <memmove+0x32>
     7ea:	a891                	j	83e <memmove+0xb6>
  } else {
    dst += n;
     7ec:	fcc42783          	lw	a5,-52(s0)
     7f0:	fe843703          	ld	a4,-24(s0)
     7f4:	97ba                	add	a5,a5,a4
     7f6:	fef43423          	sd	a5,-24(s0)
    src += n;
     7fa:	fcc42783          	lw	a5,-52(s0)
     7fe:	fe043703          	ld	a4,-32(s0)
     802:	97ba                	add	a5,a5,a4
     804:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     808:	a01d                	j	82e <memmove+0xa6>
      *--dst = *--src;
     80a:	fe043783          	ld	a5,-32(s0)
     80e:	17fd                	addi	a5,a5,-1
     810:	fef43023          	sd	a5,-32(s0)
     814:	fe843783          	ld	a5,-24(s0)
     818:	17fd                	addi	a5,a5,-1
     81a:	fef43423          	sd	a5,-24(s0)
     81e:	fe043783          	ld	a5,-32(s0)
     822:	0007c703          	lbu	a4,0(a5)
     826:	fe843783          	ld	a5,-24(s0)
     82a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     82e:	fcc42783          	lw	a5,-52(s0)
     832:	fff7871b          	addiw	a4,a5,-1
     836:	fce42623          	sw	a4,-52(s0)
     83a:	fcf048e3          	bgtz	a5,80a <memmove+0x82>
  }
  return vdst;
     83e:	fd843783          	ld	a5,-40(s0)
}
     842:	853e                	mv	a0,a5
     844:	7462                	ld	s0,56(sp)
     846:	6121                	addi	sp,sp,64
     848:	8082                	ret

000000000000084a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     84a:	7139                	addi	sp,sp,-64
     84c:	fc22                	sd	s0,56(sp)
     84e:	0080                	addi	s0,sp,64
     850:	fca43c23          	sd	a0,-40(s0)
     854:	fcb43823          	sd	a1,-48(s0)
     858:	87b2                	mv	a5,a2
     85a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     85e:	fd843783          	ld	a5,-40(s0)
     862:	fef43423          	sd	a5,-24(s0)
     866:	fd043783          	ld	a5,-48(s0)
     86a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     86e:	a0a1                	j	8b6 <memcmp+0x6c>
    if (*p1 != *p2) {
     870:	fe843783          	ld	a5,-24(s0)
     874:	0007c703          	lbu	a4,0(a5)
     878:	fe043783          	ld	a5,-32(s0)
     87c:	0007c783          	lbu	a5,0(a5)
     880:	02f70163          	beq	a4,a5,8a2 <memcmp+0x58>
      return *p1 - *p2;
     884:	fe843783          	ld	a5,-24(s0)
     888:	0007c783          	lbu	a5,0(a5)
     88c:	0007871b          	sext.w	a4,a5
     890:	fe043783          	ld	a5,-32(s0)
     894:	0007c783          	lbu	a5,0(a5)
     898:	2781                	sext.w	a5,a5
     89a:	40f707bb          	subw	a5,a4,a5
     89e:	2781                	sext.w	a5,a5
     8a0:	a01d                	j	8c6 <memcmp+0x7c>
    }
    p1++;
     8a2:	fe843783          	ld	a5,-24(s0)
     8a6:	0785                	addi	a5,a5,1
     8a8:	fef43423          	sd	a5,-24(s0)
    p2++;
     8ac:	fe043783          	ld	a5,-32(s0)
     8b0:	0785                	addi	a5,a5,1
     8b2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     8b6:	fcc42783          	lw	a5,-52(s0)
     8ba:	fff7871b          	addiw	a4,a5,-1
     8be:	fce42623          	sw	a4,-52(s0)
     8c2:	f7dd                	bnez	a5,870 <memcmp+0x26>
  }
  return 0;
     8c4:	4781                	li	a5,0
}
     8c6:	853e                	mv	a0,a5
     8c8:	7462                	ld	s0,56(sp)
     8ca:	6121                	addi	sp,sp,64
     8cc:	8082                	ret

00000000000008ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     8ce:	7179                	addi	sp,sp,-48
     8d0:	f406                	sd	ra,40(sp)
     8d2:	f022                	sd	s0,32(sp)
     8d4:	1800                	addi	s0,sp,48
     8d6:	fea43423          	sd	a0,-24(s0)
     8da:	feb43023          	sd	a1,-32(s0)
     8de:	87b2                	mv	a5,a2
     8e0:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     8e4:	fdc42783          	lw	a5,-36(s0)
     8e8:	863e                	mv	a2,a5
     8ea:	fe043583          	ld	a1,-32(s0)
     8ee:	fe843503          	ld	a0,-24(s0)
     8f2:	00000097          	auipc	ra,0x0
     8f6:	e96080e7          	jalr	-362(ra) # 788 <memmove>
     8fa:	87aa                	mv	a5,a0
}
     8fc:	853e                	mv	a0,a5
     8fe:	70a2                	ld	ra,40(sp)
     900:	7402                	ld	s0,32(sp)
     902:	6145                	addi	sp,sp,48
     904:	8082                	ret

0000000000000906 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     906:	4885                	li	a7,1
 ecall
     908:	00000073          	ecall
 ret
     90c:	8082                	ret

000000000000090e <exit>:
.global exit
exit:
 li a7, SYS_exit
     90e:	4889                	li	a7,2
 ecall
     910:	00000073          	ecall
 ret
     914:	8082                	ret

0000000000000916 <wait>:
.global wait
wait:
 li a7, SYS_wait
     916:	488d                	li	a7,3
 ecall
     918:	00000073          	ecall
 ret
     91c:	8082                	ret

000000000000091e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     91e:	4891                	li	a7,4
 ecall
     920:	00000073          	ecall
 ret
     924:	8082                	ret

0000000000000926 <read>:
.global read
read:
 li a7, SYS_read
     926:	4895                	li	a7,5
 ecall
     928:	00000073          	ecall
 ret
     92c:	8082                	ret

000000000000092e <write>:
.global write
write:
 li a7, SYS_write
     92e:	48c1                	li	a7,16
 ecall
     930:	00000073          	ecall
 ret
     934:	8082                	ret

0000000000000936 <close>:
.global close
close:
 li a7, SYS_close
     936:	48d5                	li	a7,21
 ecall
     938:	00000073          	ecall
 ret
     93c:	8082                	ret

000000000000093e <kill>:
.global kill
kill:
 li a7, SYS_kill
     93e:	4899                	li	a7,6
 ecall
     940:	00000073          	ecall
 ret
     944:	8082                	ret

0000000000000946 <exec>:
.global exec
exec:
 li a7, SYS_exec
     946:	489d                	li	a7,7
 ecall
     948:	00000073          	ecall
 ret
     94c:	8082                	ret

000000000000094e <open>:
.global open
open:
 li a7, SYS_open
     94e:	48bd                	li	a7,15
 ecall
     950:	00000073          	ecall
 ret
     954:	8082                	ret

0000000000000956 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     956:	48c5                	li	a7,17
 ecall
     958:	00000073          	ecall
 ret
     95c:	8082                	ret

000000000000095e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     95e:	48c9                	li	a7,18
 ecall
     960:	00000073          	ecall
 ret
     964:	8082                	ret

0000000000000966 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     966:	48a1                	li	a7,8
 ecall
     968:	00000073          	ecall
 ret
     96c:	8082                	ret

000000000000096e <link>:
.global link
link:
 li a7, SYS_link
     96e:	48cd                	li	a7,19
 ecall
     970:	00000073          	ecall
 ret
     974:	8082                	ret

0000000000000976 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     976:	48d1                	li	a7,20
 ecall
     978:	00000073          	ecall
 ret
     97c:	8082                	ret

000000000000097e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     97e:	48a5                	li	a7,9
 ecall
     980:	00000073          	ecall
 ret
     984:	8082                	ret

0000000000000986 <dup>:
.global dup
dup:
 li a7, SYS_dup
     986:	48a9                	li	a7,10
 ecall
     988:	00000073          	ecall
 ret
     98c:	8082                	ret

000000000000098e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     98e:	48ad                	li	a7,11
 ecall
     990:	00000073          	ecall
 ret
     994:	8082                	ret

0000000000000996 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     996:	48b1                	li	a7,12
 ecall
     998:	00000073          	ecall
 ret
     99c:	8082                	ret

000000000000099e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     99e:	48b5                	li	a7,13
 ecall
     9a0:	00000073          	ecall
 ret
     9a4:	8082                	ret

00000000000009a6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     9a6:	48b9                	li	a7,14
 ecall
     9a8:	00000073          	ecall
 ret
     9ac:	8082                	ret

00000000000009ae <clone>:
.global clone
clone:
 li a7, SYS_clone
     9ae:	48d9                	li	a7,22
 ecall
     9b0:	00000073          	ecall
 ret
     9b4:	8082                	ret

00000000000009b6 <join>:
.global join
join:
 li a7, SYS_join
     9b6:	48dd                	li	a7,23
 ecall
     9b8:	00000073          	ecall
 ret
     9bc:	8082                	ret

00000000000009be <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     9be:	1101                	addi	sp,sp,-32
     9c0:	ec06                	sd	ra,24(sp)
     9c2:	e822                	sd	s0,16(sp)
     9c4:	1000                	addi	s0,sp,32
     9c6:	87aa                	mv	a5,a0
     9c8:	872e                	mv	a4,a1
     9ca:	fef42623          	sw	a5,-20(s0)
     9ce:	87ba                	mv	a5,a4
     9d0:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     9d4:	feb40713          	addi	a4,s0,-21
     9d8:	fec42783          	lw	a5,-20(s0)
     9dc:	4605                	li	a2,1
     9de:	85ba                	mv	a1,a4
     9e0:	853e                	mv	a0,a5
     9e2:	00000097          	auipc	ra,0x0
     9e6:	f4c080e7          	jalr	-180(ra) # 92e <write>
}
     9ea:	0001                	nop
     9ec:	60e2                	ld	ra,24(sp)
     9ee:	6442                	ld	s0,16(sp)
     9f0:	6105                	addi	sp,sp,32
     9f2:	8082                	ret

00000000000009f4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     9f4:	7139                	addi	sp,sp,-64
     9f6:	fc06                	sd	ra,56(sp)
     9f8:	f822                	sd	s0,48(sp)
     9fa:	0080                	addi	s0,sp,64
     9fc:	87aa                	mv	a5,a0
     9fe:	8736                	mv	a4,a3
     a00:	fcf42623          	sw	a5,-52(s0)
     a04:	87ae                	mv	a5,a1
     a06:	fcf42423          	sw	a5,-56(s0)
     a0a:	87b2                	mv	a5,a2
     a0c:	fcf42223          	sw	a5,-60(s0)
     a10:	87ba                	mv	a5,a4
     a12:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     a16:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     a1a:	fc042783          	lw	a5,-64(s0)
     a1e:	2781                	sext.w	a5,a5
     a20:	c38d                	beqz	a5,a42 <printint+0x4e>
     a22:	fc842783          	lw	a5,-56(s0)
     a26:	2781                	sext.w	a5,a5
     a28:	0007dd63          	bgez	a5,a42 <printint+0x4e>
    neg = 1;
     a2c:	4785                	li	a5,1
     a2e:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     a32:	fc842783          	lw	a5,-56(s0)
     a36:	40f007bb          	negw	a5,a5
     a3a:	2781                	sext.w	a5,a5
     a3c:	fef42223          	sw	a5,-28(s0)
     a40:	a029                	j	a4a <printint+0x56>
  } else {
    x = xx;
     a42:	fc842783          	lw	a5,-56(s0)
     a46:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     a4a:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     a4e:	fc442783          	lw	a5,-60(s0)
     a52:	fe442703          	lw	a4,-28(s0)
     a56:	02f777bb          	remuw	a5,a4,a5
     a5a:	0007861b          	sext.w	a2,a5
     a5e:	fec42783          	lw	a5,-20(s0)
     a62:	0017871b          	addiw	a4,a5,1
     a66:	fee42623          	sw	a4,-20(s0)
     a6a:	00001697          	auipc	a3,0x1
     a6e:	95668693          	addi	a3,a3,-1706 # 13c0 <digits>
     a72:	02061713          	slli	a4,a2,0x20
     a76:	9301                	srli	a4,a4,0x20
     a78:	9736                	add	a4,a4,a3
     a7a:	00074703          	lbu	a4,0(a4)
     a7e:	17c1                	addi	a5,a5,-16
     a80:	97a2                	add	a5,a5,s0
     a82:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     a86:	fc442783          	lw	a5,-60(s0)
     a8a:	fe442703          	lw	a4,-28(s0)
     a8e:	02f757bb          	divuw	a5,a4,a5
     a92:	fef42223          	sw	a5,-28(s0)
     a96:	fe442783          	lw	a5,-28(s0)
     a9a:	2781                	sext.w	a5,a5
     a9c:	fbcd                	bnez	a5,a4e <printint+0x5a>
  if(neg)
     a9e:	fe842783          	lw	a5,-24(s0)
     aa2:	2781                	sext.w	a5,a5
     aa4:	cf85                	beqz	a5,adc <printint+0xe8>
    buf[i++] = '-';
     aa6:	fec42783          	lw	a5,-20(s0)
     aaa:	0017871b          	addiw	a4,a5,1
     aae:	fee42623          	sw	a4,-20(s0)
     ab2:	17c1                	addi	a5,a5,-16
     ab4:	97a2                	add	a5,a5,s0
     ab6:	02d00713          	li	a4,45
     aba:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     abe:	a839                	j	adc <printint+0xe8>
    putc(fd, buf[i]);
     ac0:	fec42783          	lw	a5,-20(s0)
     ac4:	17c1                	addi	a5,a5,-16
     ac6:	97a2                	add	a5,a5,s0
     ac8:	fe07c703          	lbu	a4,-32(a5)
     acc:	fcc42783          	lw	a5,-52(s0)
     ad0:	85ba                	mv	a1,a4
     ad2:	853e                	mv	a0,a5
     ad4:	00000097          	auipc	ra,0x0
     ad8:	eea080e7          	jalr	-278(ra) # 9be <putc>
  while(--i >= 0)
     adc:	fec42783          	lw	a5,-20(s0)
     ae0:	37fd                	addiw	a5,a5,-1
     ae2:	fef42623          	sw	a5,-20(s0)
     ae6:	fec42783          	lw	a5,-20(s0)
     aea:	2781                	sext.w	a5,a5
     aec:	fc07dae3          	bgez	a5,ac0 <printint+0xcc>
}
     af0:	0001                	nop
     af2:	0001                	nop
     af4:	70e2                	ld	ra,56(sp)
     af6:	7442                	ld	s0,48(sp)
     af8:	6121                	addi	sp,sp,64
     afa:	8082                	ret

0000000000000afc <printptr>:

static void
printptr(int fd, uint64 x) {
     afc:	7179                	addi	sp,sp,-48
     afe:	f406                	sd	ra,40(sp)
     b00:	f022                	sd	s0,32(sp)
     b02:	1800                	addi	s0,sp,48
     b04:	87aa                	mv	a5,a0
     b06:	fcb43823          	sd	a1,-48(s0)
     b0a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     b0e:	fdc42783          	lw	a5,-36(s0)
     b12:	03000593          	li	a1,48
     b16:	853e                	mv	a0,a5
     b18:	00000097          	auipc	ra,0x0
     b1c:	ea6080e7          	jalr	-346(ra) # 9be <putc>
  putc(fd, 'x');
     b20:	fdc42783          	lw	a5,-36(s0)
     b24:	07800593          	li	a1,120
     b28:	853e                	mv	a0,a5
     b2a:	00000097          	auipc	ra,0x0
     b2e:	e94080e7          	jalr	-364(ra) # 9be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     b32:	fe042623          	sw	zero,-20(s0)
     b36:	a82d                	j	b70 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     b38:	fd043783          	ld	a5,-48(s0)
     b3c:	93f1                	srli	a5,a5,0x3c
     b3e:	00001717          	auipc	a4,0x1
     b42:	88270713          	addi	a4,a4,-1918 # 13c0 <digits>
     b46:	97ba                	add	a5,a5,a4
     b48:	0007c703          	lbu	a4,0(a5)
     b4c:	fdc42783          	lw	a5,-36(s0)
     b50:	85ba                	mv	a1,a4
     b52:	853e                	mv	a0,a5
     b54:	00000097          	auipc	ra,0x0
     b58:	e6a080e7          	jalr	-406(ra) # 9be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     b5c:	fec42783          	lw	a5,-20(s0)
     b60:	2785                	addiw	a5,a5,1
     b62:	fef42623          	sw	a5,-20(s0)
     b66:	fd043783          	ld	a5,-48(s0)
     b6a:	0792                	slli	a5,a5,0x4
     b6c:	fcf43823          	sd	a5,-48(s0)
     b70:	fec42783          	lw	a5,-20(s0)
     b74:	873e                	mv	a4,a5
     b76:	47bd                	li	a5,15
     b78:	fce7f0e3          	bgeu	a5,a4,b38 <printptr+0x3c>
}
     b7c:	0001                	nop
     b7e:	0001                	nop
     b80:	70a2                	ld	ra,40(sp)
     b82:	7402                	ld	s0,32(sp)
     b84:	6145                	addi	sp,sp,48
     b86:	8082                	ret

0000000000000b88 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     b88:	715d                	addi	sp,sp,-80
     b8a:	e486                	sd	ra,72(sp)
     b8c:	e0a2                	sd	s0,64(sp)
     b8e:	0880                	addi	s0,sp,80
     b90:	87aa                	mv	a5,a0
     b92:	fcb43023          	sd	a1,-64(s0)
     b96:	fac43c23          	sd	a2,-72(s0)
     b9a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     b9e:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     ba2:	fe042223          	sw	zero,-28(s0)
     ba6:	a42d                	j	dd0 <vprintf+0x248>
    c = fmt[i] & 0xff;
     ba8:	fe442783          	lw	a5,-28(s0)
     bac:	fc043703          	ld	a4,-64(s0)
     bb0:	97ba                	add	a5,a5,a4
     bb2:	0007c783          	lbu	a5,0(a5)
     bb6:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     bba:	fe042783          	lw	a5,-32(s0)
     bbe:	2781                	sext.w	a5,a5
     bc0:	eb9d                	bnez	a5,bf6 <vprintf+0x6e>
      if(c == '%'){
     bc2:	fdc42783          	lw	a5,-36(s0)
     bc6:	0007871b          	sext.w	a4,a5
     bca:	02500793          	li	a5,37
     bce:	00f71763          	bne	a4,a5,bdc <vprintf+0x54>
        state = '%';
     bd2:	02500793          	li	a5,37
     bd6:	fef42023          	sw	a5,-32(s0)
     bda:	a2f5                	j	dc6 <vprintf+0x23e>
      } else {
        putc(fd, c);
     bdc:	fdc42783          	lw	a5,-36(s0)
     be0:	0ff7f713          	zext.b	a4,a5
     be4:	fcc42783          	lw	a5,-52(s0)
     be8:	85ba                	mv	a1,a4
     bea:	853e                	mv	a0,a5
     bec:	00000097          	auipc	ra,0x0
     bf0:	dd2080e7          	jalr	-558(ra) # 9be <putc>
     bf4:	aac9                	j	dc6 <vprintf+0x23e>
      }
    } else if(state == '%'){
     bf6:	fe042783          	lw	a5,-32(s0)
     bfa:	0007871b          	sext.w	a4,a5
     bfe:	02500793          	li	a5,37
     c02:	1cf71263          	bne	a4,a5,dc6 <vprintf+0x23e>
      if(c == 'd'){
     c06:	fdc42783          	lw	a5,-36(s0)
     c0a:	0007871b          	sext.w	a4,a5
     c0e:	06400793          	li	a5,100
     c12:	02f71463          	bne	a4,a5,c3a <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     c16:	fb843783          	ld	a5,-72(s0)
     c1a:	00878713          	addi	a4,a5,8
     c1e:	fae43c23          	sd	a4,-72(s0)
     c22:	4398                	lw	a4,0(a5)
     c24:	fcc42783          	lw	a5,-52(s0)
     c28:	4685                	li	a3,1
     c2a:	4629                	li	a2,10
     c2c:	85ba                	mv	a1,a4
     c2e:	853e                	mv	a0,a5
     c30:	00000097          	auipc	ra,0x0
     c34:	dc4080e7          	jalr	-572(ra) # 9f4 <printint>
     c38:	a269                	j	dc2 <vprintf+0x23a>
      } else if(c == 'l') {
     c3a:	fdc42783          	lw	a5,-36(s0)
     c3e:	0007871b          	sext.w	a4,a5
     c42:	06c00793          	li	a5,108
     c46:	02f71663          	bne	a4,a5,c72 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     c4a:	fb843783          	ld	a5,-72(s0)
     c4e:	00878713          	addi	a4,a5,8
     c52:	fae43c23          	sd	a4,-72(s0)
     c56:	639c                	ld	a5,0(a5)
     c58:	0007871b          	sext.w	a4,a5
     c5c:	fcc42783          	lw	a5,-52(s0)
     c60:	4681                	li	a3,0
     c62:	4629                	li	a2,10
     c64:	85ba                	mv	a1,a4
     c66:	853e                	mv	a0,a5
     c68:	00000097          	auipc	ra,0x0
     c6c:	d8c080e7          	jalr	-628(ra) # 9f4 <printint>
     c70:	aa89                	j	dc2 <vprintf+0x23a>
      } else if(c == 'x') {
     c72:	fdc42783          	lw	a5,-36(s0)
     c76:	0007871b          	sext.w	a4,a5
     c7a:	07800793          	li	a5,120
     c7e:	02f71463          	bne	a4,a5,ca6 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     c82:	fb843783          	ld	a5,-72(s0)
     c86:	00878713          	addi	a4,a5,8
     c8a:	fae43c23          	sd	a4,-72(s0)
     c8e:	4398                	lw	a4,0(a5)
     c90:	fcc42783          	lw	a5,-52(s0)
     c94:	4681                	li	a3,0
     c96:	4641                	li	a2,16
     c98:	85ba                	mv	a1,a4
     c9a:	853e                	mv	a0,a5
     c9c:	00000097          	auipc	ra,0x0
     ca0:	d58080e7          	jalr	-680(ra) # 9f4 <printint>
     ca4:	aa39                	j	dc2 <vprintf+0x23a>
      } else if(c == 'p') {
     ca6:	fdc42783          	lw	a5,-36(s0)
     caa:	0007871b          	sext.w	a4,a5
     cae:	07000793          	li	a5,112
     cb2:	02f71263          	bne	a4,a5,cd6 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     cb6:	fb843783          	ld	a5,-72(s0)
     cba:	00878713          	addi	a4,a5,8
     cbe:	fae43c23          	sd	a4,-72(s0)
     cc2:	6398                	ld	a4,0(a5)
     cc4:	fcc42783          	lw	a5,-52(s0)
     cc8:	85ba                	mv	a1,a4
     cca:	853e                	mv	a0,a5
     ccc:	00000097          	auipc	ra,0x0
     cd0:	e30080e7          	jalr	-464(ra) # afc <printptr>
     cd4:	a0fd                	j	dc2 <vprintf+0x23a>
      } else if(c == 's'){
     cd6:	fdc42783          	lw	a5,-36(s0)
     cda:	0007871b          	sext.w	a4,a5
     cde:	07300793          	li	a5,115
     ce2:	04f71c63          	bne	a4,a5,d3a <vprintf+0x1b2>
        s = va_arg(ap, char*);
     ce6:	fb843783          	ld	a5,-72(s0)
     cea:	00878713          	addi	a4,a5,8
     cee:	fae43c23          	sd	a4,-72(s0)
     cf2:	639c                	ld	a5,0(a5)
     cf4:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     cf8:	fe843783          	ld	a5,-24(s0)
     cfc:	eb8d                	bnez	a5,d2e <vprintf+0x1a6>
          s = "(null)";
     cfe:	00000797          	auipc	a5,0x0
     d02:	66a78793          	addi	a5,a5,1642 # 1368 <lock_init+0xf8>
     d06:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     d0a:	a015                	j	d2e <vprintf+0x1a6>
          putc(fd, *s);
     d0c:	fe843783          	ld	a5,-24(s0)
     d10:	0007c703          	lbu	a4,0(a5)
     d14:	fcc42783          	lw	a5,-52(s0)
     d18:	85ba                	mv	a1,a4
     d1a:	853e                	mv	a0,a5
     d1c:	00000097          	auipc	ra,0x0
     d20:	ca2080e7          	jalr	-862(ra) # 9be <putc>
          s++;
     d24:	fe843783          	ld	a5,-24(s0)
     d28:	0785                	addi	a5,a5,1
     d2a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     d2e:	fe843783          	ld	a5,-24(s0)
     d32:	0007c783          	lbu	a5,0(a5)
     d36:	fbf9                	bnez	a5,d0c <vprintf+0x184>
     d38:	a069                	j	dc2 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     d3a:	fdc42783          	lw	a5,-36(s0)
     d3e:	0007871b          	sext.w	a4,a5
     d42:	06300793          	li	a5,99
     d46:	02f71463          	bne	a4,a5,d6e <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     d4a:	fb843783          	ld	a5,-72(s0)
     d4e:	00878713          	addi	a4,a5,8
     d52:	fae43c23          	sd	a4,-72(s0)
     d56:	439c                	lw	a5,0(a5)
     d58:	0ff7f713          	zext.b	a4,a5
     d5c:	fcc42783          	lw	a5,-52(s0)
     d60:	85ba                	mv	a1,a4
     d62:	853e                	mv	a0,a5
     d64:	00000097          	auipc	ra,0x0
     d68:	c5a080e7          	jalr	-934(ra) # 9be <putc>
     d6c:	a899                	j	dc2 <vprintf+0x23a>
      } else if(c == '%'){
     d6e:	fdc42783          	lw	a5,-36(s0)
     d72:	0007871b          	sext.w	a4,a5
     d76:	02500793          	li	a5,37
     d7a:	00f71f63          	bne	a4,a5,d98 <vprintf+0x210>
        putc(fd, c);
     d7e:	fdc42783          	lw	a5,-36(s0)
     d82:	0ff7f713          	zext.b	a4,a5
     d86:	fcc42783          	lw	a5,-52(s0)
     d8a:	85ba                	mv	a1,a4
     d8c:	853e                	mv	a0,a5
     d8e:	00000097          	auipc	ra,0x0
     d92:	c30080e7          	jalr	-976(ra) # 9be <putc>
     d96:	a035                	j	dc2 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     d98:	fcc42783          	lw	a5,-52(s0)
     d9c:	02500593          	li	a1,37
     da0:	853e                	mv	a0,a5
     da2:	00000097          	auipc	ra,0x0
     da6:	c1c080e7          	jalr	-996(ra) # 9be <putc>
        putc(fd, c);
     daa:	fdc42783          	lw	a5,-36(s0)
     dae:	0ff7f713          	zext.b	a4,a5
     db2:	fcc42783          	lw	a5,-52(s0)
     db6:	85ba                	mv	a1,a4
     db8:	853e                	mv	a0,a5
     dba:	00000097          	auipc	ra,0x0
     dbe:	c04080e7          	jalr	-1020(ra) # 9be <putc>
      }
      state = 0;
     dc2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     dc6:	fe442783          	lw	a5,-28(s0)
     dca:	2785                	addiw	a5,a5,1
     dcc:	fef42223          	sw	a5,-28(s0)
     dd0:	fe442783          	lw	a5,-28(s0)
     dd4:	fc043703          	ld	a4,-64(s0)
     dd8:	97ba                	add	a5,a5,a4
     dda:	0007c783          	lbu	a5,0(a5)
     dde:	dc0795e3          	bnez	a5,ba8 <vprintf+0x20>
    }
  }
}
     de2:	0001                	nop
     de4:	0001                	nop
     de6:	60a6                	ld	ra,72(sp)
     de8:	6406                	ld	s0,64(sp)
     dea:	6161                	addi	sp,sp,80
     dec:	8082                	ret

0000000000000dee <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     dee:	7159                	addi	sp,sp,-112
     df0:	fc06                	sd	ra,56(sp)
     df2:	f822                	sd	s0,48(sp)
     df4:	0080                	addi	s0,sp,64
     df6:	fcb43823          	sd	a1,-48(s0)
     dfa:	e010                	sd	a2,0(s0)
     dfc:	e414                	sd	a3,8(s0)
     dfe:	e818                	sd	a4,16(s0)
     e00:	ec1c                	sd	a5,24(s0)
     e02:	03043023          	sd	a6,32(s0)
     e06:	03143423          	sd	a7,40(s0)
     e0a:	87aa                	mv	a5,a0
     e0c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     e10:	03040793          	addi	a5,s0,48
     e14:	fcf43423          	sd	a5,-56(s0)
     e18:	fc843783          	ld	a5,-56(s0)
     e1c:	fd078793          	addi	a5,a5,-48
     e20:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     e24:	fe843703          	ld	a4,-24(s0)
     e28:	fdc42783          	lw	a5,-36(s0)
     e2c:	863a                	mv	a2,a4
     e2e:	fd043583          	ld	a1,-48(s0)
     e32:	853e                	mv	a0,a5
     e34:	00000097          	auipc	ra,0x0
     e38:	d54080e7          	jalr	-684(ra) # b88 <vprintf>
}
     e3c:	0001                	nop
     e3e:	70e2                	ld	ra,56(sp)
     e40:	7442                	ld	s0,48(sp)
     e42:	6165                	addi	sp,sp,112
     e44:	8082                	ret

0000000000000e46 <printf>:

void
printf(const char *fmt, ...)
{
     e46:	7159                	addi	sp,sp,-112
     e48:	f406                	sd	ra,40(sp)
     e4a:	f022                	sd	s0,32(sp)
     e4c:	1800                	addi	s0,sp,48
     e4e:	fca43c23          	sd	a0,-40(s0)
     e52:	e40c                	sd	a1,8(s0)
     e54:	e810                	sd	a2,16(s0)
     e56:	ec14                	sd	a3,24(s0)
     e58:	f018                	sd	a4,32(s0)
     e5a:	f41c                	sd	a5,40(s0)
     e5c:	03043823          	sd	a6,48(s0)
     e60:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     e64:	04040793          	addi	a5,s0,64
     e68:	fcf43823          	sd	a5,-48(s0)
     e6c:	fd043783          	ld	a5,-48(s0)
     e70:	fc878793          	addi	a5,a5,-56
     e74:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     e78:	fe843783          	ld	a5,-24(s0)
     e7c:	863e                	mv	a2,a5
     e7e:	fd843583          	ld	a1,-40(s0)
     e82:	4505                	li	a0,1
     e84:	00000097          	auipc	ra,0x0
     e88:	d04080e7          	jalr	-764(ra) # b88 <vprintf>
}
     e8c:	0001                	nop
     e8e:	70a2                	ld	ra,40(sp)
     e90:	7402                	ld	s0,32(sp)
     e92:	6165                	addi	sp,sp,112
     e94:	8082                	ret

0000000000000e96 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e96:	7179                	addi	sp,sp,-48
     e98:	f422                	sd	s0,40(sp)
     e9a:	1800                	addi	s0,sp,48
     e9c:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     ea0:	fd843783          	ld	a5,-40(s0)
     ea4:	17c1                	addi	a5,a5,-16
     ea6:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     eaa:	00000797          	auipc	a5,0x0
     eae:	54678793          	addi	a5,a5,1350 # 13f0 <freep>
     eb2:	639c                	ld	a5,0(a5)
     eb4:	fef43423          	sd	a5,-24(s0)
     eb8:	a815                	j	eec <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     eba:	fe843783          	ld	a5,-24(s0)
     ebe:	639c                	ld	a5,0(a5)
     ec0:	fe843703          	ld	a4,-24(s0)
     ec4:	00f76f63          	bltu	a4,a5,ee2 <free+0x4c>
     ec8:	fe043703          	ld	a4,-32(s0)
     ecc:	fe843783          	ld	a5,-24(s0)
     ed0:	02e7eb63          	bltu	a5,a4,f06 <free+0x70>
     ed4:	fe843783          	ld	a5,-24(s0)
     ed8:	639c                	ld	a5,0(a5)
     eda:	fe043703          	ld	a4,-32(s0)
     ede:	02f76463          	bltu	a4,a5,f06 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ee2:	fe843783          	ld	a5,-24(s0)
     ee6:	639c                	ld	a5,0(a5)
     ee8:	fef43423          	sd	a5,-24(s0)
     eec:	fe043703          	ld	a4,-32(s0)
     ef0:	fe843783          	ld	a5,-24(s0)
     ef4:	fce7f3e3          	bgeu	a5,a4,eba <free+0x24>
     ef8:	fe843783          	ld	a5,-24(s0)
     efc:	639c                	ld	a5,0(a5)
     efe:	fe043703          	ld	a4,-32(s0)
     f02:	faf77ce3          	bgeu	a4,a5,eba <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     f06:	fe043783          	ld	a5,-32(s0)
     f0a:	479c                	lw	a5,8(a5)
     f0c:	1782                	slli	a5,a5,0x20
     f0e:	9381                	srli	a5,a5,0x20
     f10:	0792                	slli	a5,a5,0x4
     f12:	fe043703          	ld	a4,-32(s0)
     f16:	973e                	add	a4,a4,a5
     f18:	fe843783          	ld	a5,-24(s0)
     f1c:	639c                	ld	a5,0(a5)
     f1e:	02f71763          	bne	a4,a5,f4c <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     f22:	fe043783          	ld	a5,-32(s0)
     f26:	4798                	lw	a4,8(a5)
     f28:	fe843783          	ld	a5,-24(s0)
     f2c:	639c                	ld	a5,0(a5)
     f2e:	479c                	lw	a5,8(a5)
     f30:	9fb9                	addw	a5,a5,a4
     f32:	0007871b          	sext.w	a4,a5
     f36:	fe043783          	ld	a5,-32(s0)
     f3a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     f3c:	fe843783          	ld	a5,-24(s0)
     f40:	639c                	ld	a5,0(a5)
     f42:	6398                	ld	a4,0(a5)
     f44:	fe043783          	ld	a5,-32(s0)
     f48:	e398                	sd	a4,0(a5)
     f4a:	a039                	j	f58 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     f4c:	fe843783          	ld	a5,-24(s0)
     f50:	6398                	ld	a4,0(a5)
     f52:	fe043783          	ld	a5,-32(s0)
     f56:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     f58:	fe843783          	ld	a5,-24(s0)
     f5c:	479c                	lw	a5,8(a5)
     f5e:	1782                	slli	a5,a5,0x20
     f60:	9381                	srli	a5,a5,0x20
     f62:	0792                	slli	a5,a5,0x4
     f64:	fe843703          	ld	a4,-24(s0)
     f68:	97ba                	add	a5,a5,a4
     f6a:	fe043703          	ld	a4,-32(s0)
     f6e:	02f71563          	bne	a4,a5,f98 <free+0x102>
    p->s.size += bp->s.size;
     f72:	fe843783          	ld	a5,-24(s0)
     f76:	4798                	lw	a4,8(a5)
     f78:	fe043783          	ld	a5,-32(s0)
     f7c:	479c                	lw	a5,8(a5)
     f7e:	9fb9                	addw	a5,a5,a4
     f80:	0007871b          	sext.w	a4,a5
     f84:	fe843783          	ld	a5,-24(s0)
     f88:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     f8a:	fe043783          	ld	a5,-32(s0)
     f8e:	6398                	ld	a4,0(a5)
     f90:	fe843783          	ld	a5,-24(s0)
     f94:	e398                	sd	a4,0(a5)
     f96:	a031                	j	fa2 <free+0x10c>
  } else
    p->s.ptr = bp;
     f98:	fe843783          	ld	a5,-24(s0)
     f9c:	fe043703          	ld	a4,-32(s0)
     fa0:	e398                	sd	a4,0(a5)
  freep = p;
     fa2:	00000797          	auipc	a5,0x0
     fa6:	44e78793          	addi	a5,a5,1102 # 13f0 <freep>
     faa:	fe843703          	ld	a4,-24(s0)
     fae:	e398                	sd	a4,0(a5)
}
     fb0:	0001                	nop
     fb2:	7422                	ld	s0,40(sp)
     fb4:	6145                	addi	sp,sp,48
     fb6:	8082                	ret

0000000000000fb8 <morecore>:

static Header*
morecore(uint nu)
{
     fb8:	7179                	addi	sp,sp,-48
     fba:	f406                	sd	ra,40(sp)
     fbc:	f022                	sd	s0,32(sp)
     fbe:	1800                	addi	s0,sp,48
     fc0:	87aa                	mv	a5,a0
     fc2:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     fc6:	fdc42783          	lw	a5,-36(s0)
     fca:	0007871b          	sext.w	a4,a5
     fce:	6785                	lui	a5,0x1
     fd0:	00f77563          	bgeu	a4,a5,fda <morecore+0x22>
    nu = 4096;
     fd4:	6785                	lui	a5,0x1
     fd6:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     fda:	fdc42783          	lw	a5,-36(s0)
     fde:	0047979b          	slliw	a5,a5,0x4
     fe2:	2781                	sext.w	a5,a5
     fe4:	2781                	sext.w	a5,a5
     fe6:	853e                	mv	a0,a5
     fe8:	00000097          	auipc	ra,0x0
     fec:	9ae080e7          	jalr	-1618(ra) # 996 <sbrk>
     ff0:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     ff4:	fe843703          	ld	a4,-24(s0)
     ff8:	57fd                	li	a5,-1
     ffa:	00f71463          	bne	a4,a5,1002 <morecore+0x4a>
    return 0;
     ffe:	4781                	li	a5,0
    1000:	a03d                	j	102e <morecore+0x76>
  hp = (Header*)p;
    1002:	fe843783          	ld	a5,-24(s0)
    1006:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    100a:	fe043783          	ld	a5,-32(s0)
    100e:	fdc42703          	lw	a4,-36(s0)
    1012:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    1014:	fe043783          	ld	a5,-32(s0)
    1018:	07c1                	addi	a5,a5,16
    101a:	853e                	mv	a0,a5
    101c:	00000097          	auipc	ra,0x0
    1020:	e7a080e7          	jalr	-390(ra) # e96 <free>
  return freep;
    1024:	00000797          	auipc	a5,0x0
    1028:	3cc78793          	addi	a5,a5,972 # 13f0 <freep>
    102c:	639c                	ld	a5,0(a5)
}
    102e:	853e                	mv	a0,a5
    1030:	70a2                	ld	ra,40(sp)
    1032:	7402                	ld	s0,32(sp)
    1034:	6145                	addi	sp,sp,48
    1036:	8082                	ret

0000000000001038 <malloc>:

void*
malloc(uint nbytes)
{
    1038:	7139                	addi	sp,sp,-64
    103a:	fc06                	sd	ra,56(sp)
    103c:	f822                	sd	s0,48(sp)
    103e:	0080                	addi	s0,sp,64
    1040:	87aa                	mv	a5,a0
    1042:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1046:	fcc46783          	lwu	a5,-52(s0)
    104a:	07bd                	addi	a5,a5,15
    104c:	8391                	srli	a5,a5,0x4
    104e:	2781                	sext.w	a5,a5
    1050:	2785                	addiw	a5,a5,1
    1052:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1056:	00000797          	auipc	a5,0x0
    105a:	39a78793          	addi	a5,a5,922 # 13f0 <freep>
    105e:	639c                	ld	a5,0(a5)
    1060:	fef43023          	sd	a5,-32(s0)
    1064:	fe043783          	ld	a5,-32(s0)
    1068:	ef95                	bnez	a5,10a4 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    106a:	00000797          	auipc	a5,0x0
    106e:	37678793          	addi	a5,a5,886 # 13e0 <base>
    1072:	fef43023          	sd	a5,-32(s0)
    1076:	00000797          	auipc	a5,0x0
    107a:	37a78793          	addi	a5,a5,890 # 13f0 <freep>
    107e:	fe043703          	ld	a4,-32(s0)
    1082:	e398                	sd	a4,0(a5)
    1084:	00000797          	auipc	a5,0x0
    1088:	36c78793          	addi	a5,a5,876 # 13f0 <freep>
    108c:	6398                	ld	a4,0(a5)
    108e:	00000797          	auipc	a5,0x0
    1092:	35278793          	addi	a5,a5,850 # 13e0 <base>
    1096:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1098:	00000797          	auipc	a5,0x0
    109c:	34878793          	addi	a5,a5,840 # 13e0 <base>
    10a0:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10a4:	fe043783          	ld	a5,-32(s0)
    10a8:	639c                	ld	a5,0(a5)
    10aa:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    10ae:	fe843783          	ld	a5,-24(s0)
    10b2:	4798                	lw	a4,8(a5)
    10b4:	fdc42783          	lw	a5,-36(s0)
    10b8:	2781                	sext.w	a5,a5
    10ba:	06f76763          	bltu	a4,a5,1128 <malloc+0xf0>
      if(p->s.size == nunits)
    10be:	fe843783          	ld	a5,-24(s0)
    10c2:	4798                	lw	a4,8(a5)
    10c4:	fdc42783          	lw	a5,-36(s0)
    10c8:	2781                	sext.w	a5,a5
    10ca:	00e79963          	bne	a5,a4,10dc <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    10ce:	fe843783          	ld	a5,-24(s0)
    10d2:	6398                	ld	a4,0(a5)
    10d4:	fe043783          	ld	a5,-32(s0)
    10d8:	e398                	sd	a4,0(a5)
    10da:	a825                	j	1112 <malloc+0xda>
      else {
        p->s.size -= nunits;
    10dc:	fe843783          	ld	a5,-24(s0)
    10e0:	479c                	lw	a5,8(a5)
    10e2:	fdc42703          	lw	a4,-36(s0)
    10e6:	9f99                	subw	a5,a5,a4
    10e8:	0007871b          	sext.w	a4,a5
    10ec:	fe843783          	ld	a5,-24(s0)
    10f0:	c798                	sw	a4,8(a5)
        p += p->s.size;
    10f2:	fe843783          	ld	a5,-24(s0)
    10f6:	479c                	lw	a5,8(a5)
    10f8:	1782                	slli	a5,a5,0x20
    10fa:	9381                	srli	a5,a5,0x20
    10fc:	0792                	slli	a5,a5,0x4
    10fe:	fe843703          	ld	a4,-24(s0)
    1102:	97ba                	add	a5,a5,a4
    1104:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1108:	fe843783          	ld	a5,-24(s0)
    110c:	fdc42703          	lw	a4,-36(s0)
    1110:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1112:	00000797          	auipc	a5,0x0
    1116:	2de78793          	addi	a5,a5,734 # 13f0 <freep>
    111a:	fe043703          	ld	a4,-32(s0)
    111e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1120:	fe843783          	ld	a5,-24(s0)
    1124:	07c1                	addi	a5,a5,16
    1126:	a091                	j	116a <malloc+0x132>
    }
    if(p == freep)
    1128:	00000797          	auipc	a5,0x0
    112c:	2c878793          	addi	a5,a5,712 # 13f0 <freep>
    1130:	639c                	ld	a5,0(a5)
    1132:	fe843703          	ld	a4,-24(s0)
    1136:	02f71063          	bne	a4,a5,1156 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    113a:	fdc42783          	lw	a5,-36(s0)
    113e:	853e                	mv	a0,a5
    1140:	00000097          	auipc	ra,0x0
    1144:	e78080e7          	jalr	-392(ra) # fb8 <morecore>
    1148:	fea43423          	sd	a0,-24(s0)
    114c:	fe843783          	ld	a5,-24(s0)
    1150:	e399                	bnez	a5,1156 <malloc+0x11e>
        return 0;
    1152:	4781                	li	a5,0
    1154:	a819                	j	116a <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1156:	fe843783          	ld	a5,-24(s0)
    115a:	fef43023          	sd	a5,-32(s0)
    115e:	fe843783          	ld	a5,-24(s0)
    1162:	639c                	ld	a5,0(a5)
    1164:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1168:	b799                	j	10ae <malloc+0x76>
  }
}
    116a:	853e                	mv	a0,a5
    116c:	70e2                	ld	ra,56(sp)
    116e:	7442                	ld	s0,48(sp)
    1170:	6121                	addi	sp,sp,64
    1172:	8082                	ret

0000000000001174 <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
    1174:	7179                	addi	sp,sp,-48
    1176:	f406                	sd	ra,40(sp)
    1178:	f022                	sd	s0,32(sp)
    117a:	1800                	addi	s0,sp,48
    117c:	fca43c23          	sd	a0,-40(s0)
    1180:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
    1184:	6505                	lui	a0,0x1
    1186:	00000097          	auipc	ra,0x0
    118a:	eb2080e7          	jalr	-334(ra) # 1038 <malloc>
    118e:	fea43423          	sd	a0,-24(s0)
    1192:	fe843783          	ld	a5,-24(s0)
    1196:	e38d                	bnez	a5,11b8 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
    1198:	00000517          	auipc	a0,0x0
    119c:	1d850513          	addi	a0,a0,472 # 1370 <lock_init+0x100>
    11a0:	00000097          	auipc	ra,0x0
    11a4:	ca6080e7          	jalr	-858(ra) # e46 <printf>
        free(stack);
    11a8:	fe843503          	ld	a0,-24(s0)
    11ac:	00000097          	auipc	ra,0x0
    11b0:	cea080e7          	jalr	-790(ra) # e96 <free>
        return -1;
    11b4:	57fd                	li	a5,-1
    11b6:	a099                	j	11fc <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
    11b8:	fe843783          	ld	a5,-24(s0)
    11bc:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
    11c0:	fe043703          	ld	a4,-32(s0)
    11c4:	6785                	lui	a5,0x1
    11c6:	17fd                	addi	a5,a5,-1
    11c8:	8ff9                	and	a5,a5,a4
    11ca:	cf91                	beqz	a5,11e6 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
    11cc:	fe043703          	ld	a4,-32(s0)
    11d0:	6785                	lui	a5,0x1
    11d2:	17fd                	addi	a5,a5,-1
    11d4:	8ff9                	and	a5,a5,a4
    11d6:	6705                	lui	a4,0x1
    11d8:	40f707b3          	sub	a5,a4,a5
    11dc:	fe843703          	ld	a4,-24(s0)
    11e0:	97ba                	add	a5,a5,a4
    11e2:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
    11e6:	fe843603          	ld	a2,-24(s0)
    11ea:	fd043583          	ld	a1,-48(s0)
    11ee:	fd843503          	ld	a0,-40(s0)
    11f2:	fffff097          	auipc	ra,0xfffff
    11f6:	7bc080e7          	jalr	1980(ra) # 9ae <clone>
    11fa:	87aa                	mv	a5,a0
}
    11fc:	853e                	mv	a0,a5
    11fe:	70a2                	ld	ra,40(sp)
    1200:	7402                	ld	s0,32(sp)
    1202:	6145                	addi	sp,sp,48
    1204:	8082                	ret

0000000000001206 <thread_join>:


int thread_join()
{
    1206:	1101                	addi	sp,sp,-32
    1208:	ec06                	sd	ra,24(sp)
    120a:	e822                	sd	s0,16(sp)
    120c:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
    120e:	fe040793          	addi	a5,s0,-32
    1212:	853e                	mv	a0,a5
    1214:	fffff097          	auipc	ra,0xfffff
    1218:	7a2080e7          	jalr	1954(ra) # 9b6 <join>
    121c:	87aa                	mv	a5,a0
    121e:	fef42623          	sw	a5,-20(s0)
    1222:	fec42783          	lw	a5,-20(s0)
    1226:	0007871b          	sext.w	a4,a5
    122a:	57fd                	li	a5,-1
    122c:	00f70963          	beq	a4,a5,123e <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
    1230:	fe043783          	ld	a5,-32(s0)
    1234:	853e                	mv	a0,a5
    1236:	00000097          	auipc	ra,0x0
    123a:	c60080e7          	jalr	-928(ra) # e96 <free>
    } 

    return child_tid;
    123e:	fec42783          	lw	a5,-20(s0)
}
    1242:	853e                	mv	a0,a5
    1244:	60e2                	ld	ra,24(sp)
    1246:	6442                	ld	s0,16(sp)
    1248:	6105                	addi	sp,sp,32
    124a:	8082                	ret

000000000000124c <lock_acquire>:


void lock_acquire (lock_t *)
{
    124c:	1101                	addi	sp,sp,-32
    124e:	ec22                	sd	s0,24(sp)
    1250:	1000                	addi	s0,sp,32
    1252:	fea43423          	sd	a0,-24(s0)

}
    1256:	0001                	nop
    1258:	6462                	ld	s0,24(sp)
    125a:	6105                	addi	sp,sp,32
    125c:	8082                	ret

000000000000125e <lock_release>:

void lock_release (lock_t *)
{
    125e:	1101                	addi	sp,sp,-32
    1260:	ec22                	sd	s0,24(sp)
    1262:	1000                	addi	s0,sp,32
    1264:	fea43423          	sd	a0,-24(s0)
    
}
    1268:	0001                	nop
    126a:	6462                	ld	s0,24(sp)
    126c:	6105                	addi	sp,sp,32
    126e:	8082                	ret

0000000000001270 <lock_init>:

void lock_init (lock_t *)
{
    1270:	1101                	addi	sp,sp,-32
    1272:	ec22                	sd	s0,24(sp)
    1274:	1000                	addi	s0,sp,32
    1276:	fea43423          	sd	a0,-24(s0)
    
}
    127a:	0001                	nop
    127c:	6462                	ld	s0,24(sp)
    127e:	6105                	addi	sp,sp,32
    1280:	8082                	ret
