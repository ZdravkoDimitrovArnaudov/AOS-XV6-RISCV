
user/_multi:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fib>:
   exit(0); \
}

void worker(void *arg_ptr);

unsigned int fib(unsigned int n) {
       0:	7179                	addi	sp,sp,-48
       2:	f406                	sd	ra,40(sp)
       4:	f022                	sd	s0,32(sp)
       6:	ec26                	sd	s1,24(sp)
       8:	1800                	addi	s0,sp,48
       a:	87aa                	mv	a5,a0
       c:	fcf42e23          	sw	a5,-36(s0)
   if (n == 0) {
      10:	fdc42783          	lw	a5,-36(s0)
      14:	2781                	sext.w	a5,a5
      16:	e399                	bnez	a5,1c <fib+0x1c>
      return 0;
      18:	4781                	li	a5,0
      1a:	a099                	j	60 <fib+0x60>
   } else if (n == 1) {
      1c:	fdc42783          	lw	a5,-36(s0)
      20:	0007871b          	sext.w	a4,a5
      24:	4785                	li	a5,1
      26:	00f71463          	bne	a4,a5,2e <fib+0x2e>
      return 1;
      2a:	4785                	li	a5,1
      2c:	a815                	j	60 <fib+0x60>
   } else {
      return fib(n - 1) + fib(n - 2);
      2e:	fdc42783          	lw	a5,-36(s0)
      32:	37fd                	addiw	a5,a5,-1
      34:	2781                	sext.w	a5,a5
      36:	853e                	mv	a0,a5
      38:	00000097          	auipc	ra,0x0
      3c:	fc8080e7          	jalr	-56(ra) # 0 <fib>
      40:	87aa                	mv	a5,a0
      42:	0007849b          	sext.w	s1,a5
      46:	fdc42783          	lw	a5,-36(s0)
      4a:	37f9                	addiw	a5,a5,-2
      4c:	2781                	sext.w	a5,a5
      4e:	853e                	mv	a0,a5
      50:	00000097          	auipc	ra,0x0
      54:	fb0080e7          	jalr	-80(ra) # 0 <fib>
      58:	87aa                	mv	a5,a0
      5a:	2781                	sext.w	a5,a5
      5c:	9fa5                	addw	a5,a5,s1
      5e:	2781                	sext.w	a5,a5
   }
}
      60:	853e                	mv	a0,a5
      62:	70a2                	ld	ra,40(sp)
      64:	7402                	ld	s0,32(sp)
      66:	64e2                	ld	s1,24(sp)
      68:	6145                	addi	sp,sp,48
      6a:	8082                	ret

000000000000006c <main>:


int
main(int argc, char *argv[])
{
      6c:	7139                	addi	sp,sp,-64
      6e:	fc06                	sd	ra,56(sp)
      70:	f822                	sd	s0,48(sp)
      72:	0080                	addi	s0,sp,64
      74:	87aa                	mv	a5,a0
      76:	fcb43023          	sd	a1,-64(s0)
      7a:	fcf42623          	sw	a5,-52(s0)
   ppid = getpid();
      7e:	00001097          	auipc	ra,0x1
      82:	a02080e7          	jalr	-1534(ra) # a80 <getpid>
      86:	87aa                	mv	a5,a0
      88:	873e                	mv	a4,a5
      8a:	00001797          	auipc	a5,0x1
      8e:	50278793          	addi	a5,a5,1282 # 158c <ppid>
      92:	c398                	sw	a4,0(a5)

   assert(fib(28) == 317811);
      94:	4571                	li	a0,28
      96:	00000097          	auipc	ra,0x0
      9a:	f6a080e7          	jalr	-150(ra) # 0 <fib>
      9e:	87aa                	mv	a5,a0
      a0:	2781                	sext.w	a5,a5
      a2:	873e                	mv	a4,a5
      a4:	0004e7b7          	lui	a5,0x4e
      a8:	97378793          	addi	a5,a5,-1677 # 4d973 <__global_pointer$+0x4bc03>
      ac:	06f70363          	beq	a4,a5,112 <main+0xa6>
      b0:	02e00613          	li	a2,46
      b4:	00001597          	auipc	a1,0x1
      b8:	37c58593          	addi	a1,a1,892 # 1430 <cv_init+0x1a>
      bc:	00001517          	auipc	a0,0x1
      c0:	38450513          	addi	a0,a0,900 # 1440 <cv_init+0x2a>
      c4:	00001097          	auipc	ra,0x1
      c8:	e74080e7          	jalr	-396(ra) # f38 <printf>
      cc:	00001597          	auipc	a1,0x1
      d0:	37c58593          	addi	a1,a1,892 # 1448 <cv_init+0x32>
      d4:	00001517          	auipc	a0,0x1
      d8:	38c50513          	addi	a0,a0,908 # 1460 <cv_init+0x4a>
      dc:	00001097          	auipc	ra,0x1
      e0:	e5c080e7          	jalr	-420(ra) # f38 <printf>
      e4:	00001517          	auipc	a0,0x1
      e8:	39450513          	addi	a0,a0,916 # 1478 <cv_init+0x62>
      ec:	00001097          	auipc	ra,0x1
      f0:	e4c080e7          	jalr	-436(ra) # f38 <printf>
      f4:	00001797          	auipc	a5,0x1
      f8:	49878793          	addi	a5,a5,1176 # 158c <ppid>
      fc:	439c                	lw	a5,0(a5)
      fe:	853e                	mv	a0,a5
     100:	00001097          	auipc	ra,0x1
     104:	930080e7          	jalr	-1744(ra) # a30 <kill>
     108:	4501                	li	a0,0
     10a:	00001097          	auipc	ra,0x1
     10e:	8f6080e7          	jalr	-1802(ra) # a00 <exit>

   int arg = 101;
     112:	06500793          	li	a5,101
     116:	fcf42a23          	sw	a5,-44(s0)
   void *arg_ptr = &arg;
     11a:	fd440793          	addi	a5,s0,-44
     11e:	fef43023          	sd	a5,-32(s0)

   int i;
   for (i = 0; i < num_threads; i++) {
     122:	fe042623          	sw	zero,-20(s0)
     126:	a849                	j	1b8 <main+0x14c>
      int thread_pid = thread_create(worker, arg_ptr);
     128:	fe043583          	ld	a1,-32(s0)
     12c:	00000517          	auipc	a0,0x0
     130:	15850513          	addi	a0,a0,344 # 284 <worker>
     134:	00001097          	auipc	ra,0x1
     138:	132080e7          	jalr	306(ra) # 1266 <thread_create>
     13c:	87aa                	mv	a5,a0
     13e:	fcf42c23          	sw	a5,-40(s0)
      assert(thread_pid > 0);
     142:	fd842783          	lw	a5,-40(s0)
     146:	2781                	sext.w	a5,a5
     148:	06f04363          	bgtz	a5,1ae <main+0x142>
     14c:	03600613          	li	a2,54
     150:	00001597          	auipc	a1,0x1
     154:	2e058593          	addi	a1,a1,736 # 1430 <cv_init+0x1a>
     158:	00001517          	auipc	a0,0x1
     15c:	2e850513          	addi	a0,a0,744 # 1440 <cv_init+0x2a>
     160:	00001097          	auipc	ra,0x1
     164:	dd8080e7          	jalr	-552(ra) # f38 <printf>
     168:	00001597          	auipc	a1,0x1
     16c:	32058593          	addi	a1,a1,800 # 1488 <cv_init+0x72>
     170:	00001517          	auipc	a0,0x1
     174:	2f050513          	addi	a0,a0,752 # 1460 <cv_init+0x4a>
     178:	00001097          	auipc	ra,0x1
     17c:	dc0080e7          	jalr	-576(ra) # f38 <printf>
     180:	00001517          	auipc	a0,0x1
     184:	2f850513          	addi	a0,a0,760 # 1478 <cv_init+0x62>
     188:	00001097          	auipc	ra,0x1
     18c:	db0080e7          	jalr	-592(ra) # f38 <printf>
     190:	00001797          	auipc	a5,0x1
     194:	3fc78793          	addi	a5,a5,1020 # 158c <ppid>
     198:	439c                	lw	a5,0(a5)
     19a:	853e                	mv	a0,a5
     19c:	00001097          	auipc	ra,0x1
     1a0:	894080e7          	jalr	-1900(ra) # a30 <kill>
     1a4:	4501                	li	a0,0
     1a6:	00001097          	auipc	ra,0x1
     1aa:	85a080e7          	jalr	-1958(ra) # a00 <exit>
   for (i = 0; i < num_threads; i++) {
     1ae:	fec42783          	lw	a5,-20(s0)
     1b2:	2785                	addiw	a5,a5,1
     1b4:	fef42623          	sw	a5,-20(s0)
     1b8:	00001797          	auipc	a5,0x1
     1bc:	3d078793          	addi	a5,a5,976 # 1588 <num_threads>
     1c0:	4398                	lw	a4,0(a5)
     1c2:	fec42783          	lw	a5,-20(s0)
     1c6:	2781                	sext.w	a5,a5
     1c8:	f6e7c0e3          	blt	a5,a4,128 <main+0xbc>
   }

   for (i = 0; i < num_threads; i++) {
     1cc:	fe042623          	sw	zero,-20(s0)
     1d0:	a059                	j	256 <main+0x1ea>
      int join_pid = thread_join();
     1d2:	00001097          	auipc	ra,0x1
     1d6:	126080e7          	jalr	294(ra) # 12f8 <thread_join>
     1da:	87aa                	mv	a5,a0
     1dc:	fcf42e23          	sw	a5,-36(s0)
      assert(join_pid > 0);
     1e0:	fdc42783          	lw	a5,-36(s0)
     1e4:	2781                	sext.w	a5,a5
     1e6:	06f04363          	bgtz	a5,24c <main+0x1e0>
     1ea:	03b00613          	li	a2,59
     1ee:	00001597          	auipc	a1,0x1
     1f2:	24258593          	addi	a1,a1,578 # 1430 <cv_init+0x1a>
     1f6:	00001517          	auipc	a0,0x1
     1fa:	24a50513          	addi	a0,a0,586 # 1440 <cv_init+0x2a>
     1fe:	00001097          	auipc	ra,0x1
     202:	d3a080e7          	jalr	-710(ra) # f38 <printf>
     206:	00001597          	auipc	a1,0x1
     20a:	29258593          	addi	a1,a1,658 # 1498 <cv_init+0x82>
     20e:	00001517          	auipc	a0,0x1
     212:	25250513          	addi	a0,a0,594 # 1460 <cv_init+0x4a>
     216:	00001097          	auipc	ra,0x1
     21a:	d22080e7          	jalr	-734(ra) # f38 <printf>
     21e:	00001517          	auipc	a0,0x1
     222:	25a50513          	addi	a0,a0,602 # 1478 <cv_init+0x62>
     226:	00001097          	auipc	ra,0x1
     22a:	d12080e7          	jalr	-750(ra) # f38 <printf>
     22e:	00001797          	auipc	a5,0x1
     232:	35e78793          	addi	a5,a5,862 # 158c <ppid>
     236:	439c                	lw	a5,0(a5)
     238:	853e                	mv	a0,a5
     23a:	00000097          	auipc	ra,0x0
     23e:	7f6080e7          	jalr	2038(ra) # a30 <kill>
     242:	4501                	li	a0,0
     244:	00000097          	auipc	ra,0x0
     248:	7bc080e7          	jalr	1980(ra) # a00 <exit>
   for (i = 0; i < num_threads; i++) {
     24c:	fec42783          	lw	a5,-20(s0)
     250:	2785                	addiw	a5,a5,1
     252:	fef42623          	sw	a5,-20(s0)
     256:	00001797          	auipc	a5,0x1
     25a:	33278793          	addi	a5,a5,818 # 1588 <num_threads>
     25e:	4398                	lw	a4,0(a5)
     260:	fec42783          	lw	a5,-20(s0)
     264:	2781                	sext.w	a5,a5
     266:	f6e7c6e3          	blt	a5,a4,1d2 <main+0x166>
   }

   printf("TEST PASSED\n");
     26a:	00001517          	auipc	a0,0x1
     26e:	23e50513          	addi	a0,a0,574 # 14a8 <cv_init+0x92>
     272:	00001097          	auipc	ra,0x1
     276:	cc6080e7          	jalr	-826(ra) # f38 <printf>
   exit(0);
     27a:	4501                	li	a0,0
     27c:	00000097          	auipc	ra,0x0
     280:	784080e7          	jalr	1924(ra) # a00 <exit>

0000000000000284 <worker>:
}

void
worker(void *arg_ptr) {
     284:	7179                	addi	sp,sp,-48
     286:	f406                	sd	ra,40(sp)
     288:	f022                	sd	s0,32(sp)
     28a:	1800                	addi	s0,sp,48
     28c:	fca43c23          	sd	a0,-40(s0)
   int arg = *(int*)arg_ptr;
     290:	fd843783          	ld	a5,-40(s0)
     294:	439c                	lw	a5,0(a5)
     296:	fef42623          	sw	a5,-20(s0)
   assert(arg == 101);
     29a:	fec42783          	lw	a5,-20(s0)
     29e:	0007871b          	sext.w	a4,a5
     2a2:	06500793          	li	a5,101
     2a6:	06f70363          	beq	a4,a5,30c <worker+0x88>
     2aa:	04500613          	li	a2,69
     2ae:	00001597          	auipc	a1,0x1
     2b2:	18258593          	addi	a1,a1,386 # 1430 <cv_init+0x1a>
     2b6:	00001517          	auipc	a0,0x1
     2ba:	18a50513          	addi	a0,a0,394 # 1440 <cv_init+0x2a>
     2be:	00001097          	auipc	ra,0x1
     2c2:	c7a080e7          	jalr	-902(ra) # f38 <printf>
     2c6:	00001597          	auipc	a1,0x1
     2ca:	1f258593          	addi	a1,a1,498 # 14b8 <cv_init+0xa2>
     2ce:	00001517          	auipc	a0,0x1
     2d2:	19250513          	addi	a0,a0,402 # 1460 <cv_init+0x4a>
     2d6:	00001097          	auipc	ra,0x1
     2da:	c62080e7          	jalr	-926(ra) # f38 <printf>
     2de:	00001517          	auipc	a0,0x1
     2e2:	19a50513          	addi	a0,a0,410 # 1478 <cv_init+0x62>
     2e6:	00001097          	auipc	ra,0x1
     2ea:	c52080e7          	jalr	-942(ra) # f38 <printf>
     2ee:	00001797          	auipc	a5,0x1
     2f2:	29e78793          	addi	a5,a5,670 # 158c <ppid>
     2f6:	439c                	lw	a5,0(a5)
     2f8:	853e                	mv	a0,a5
     2fa:	00000097          	auipc	ra,0x0
     2fe:	736080e7          	jalr	1846(ra) # a30 <kill>
     302:	4501                	li	a0,0
     304:	00000097          	auipc	ra,0x0
     308:	6fc080e7          	jalr	1788(ra) # a00 <exit>
   assert(global == 1);
     30c:	00001797          	auipc	a5,0x1
     310:	27878793          	addi	a5,a5,632 # 1584 <global>
     314:	439c                	lw	a5,0(a5)
     316:	873e                	mv	a4,a5
     318:	4785                	li	a5,1
     31a:	06f70363          	beq	a4,a5,380 <worker+0xfc>
     31e:	04600613          	li	a2,70
     322:	00001597          	auipc	a1,0x1
     326:	10e58593          	addi	a1,a1,270 # 1430 <cv_init+0x1a>
     32a:	00001517          	auipc	a0,0x1
     32e:	11650513          	addi	a0,a0,278 # 1440 <cv_init+0x2a>
     332:	00001097          	auipc	ra,0x1
     336:	c06080e7          	jalr	-1018(ra) # f38 <printf>
     33a:	00001597          	auipc	a1,0x1
     33e:	18e58593          	addi	a1,a1,398 # 14c8 <cv_init+0xb2>
     342:	00001517          	auipc	a0,0x1
     346:	11e50513          	addi	a0,a0,286 # 1460 <cv_init+0x4a>
     34a:	00001097          	auipc	ra,0x1
     34e:	bee080e7          	jalr	-1042(ra) # f38 <printf>
     352:	00001517          	auipc	a0,0x1
     356:	12650513          	addi	a0,a0,294 # 1478 <cv_init+0x62>
     35a:	00001097          	auipc	ra,0x1
     35e:	bde080e7          	jalr	-1058(ra) # f38 <printf>
     362:	00001797          	auipc	a5,0x1
     366:	22a78793          	addi	a5,a5,554 # 158c <ppid>
     36a:	439c                	lw	a5,0(a5)
     36c:	853e                	mv	a0,a5
     36e:	00000097          	auipc	ra,0x0
     372:	6c2080e7          	jalr	1730(ra) # a30 <kill>
     376:	4501                	li	a0,0
     378:	00000097          	auipc	ra,0x0
     37c:	688080e7          	jalr	1672(ra) # a00 <exit>
   assert(fib(2) == 1);
     380:	4509                	li	a0,2
     382:	00000097          	auipc	ra,0x0
     386:	c7e080e7          	jalr	-898(ra) # 0 <fib>
     38a:	87aa                	mv	a5,a0
     38c:	2781                	sext.w	a5,a5
     38e:	873e                	mv	a4,a5
     390:	4785                	li	a5,1
     392:	06f70363          	beq	a4,a5,3f8 <worker+0x174>
     396:	04700613          	li	a2,71
     39a:	00001597          	auipc	a1,0x1
     39e:	09658593          	addi	a1,a1,150 # 1430 <cv_init+0x1a>
     3a2:	00001517          	auipc	a0,0x1
     3a6:	09e50513          	addi	a0,a0,158 # 1440 <cv_init+0x2a>
     3aa:	00001097          	auipc	ra,0x1
     3ae:	b8e080e7          	jalr	-1138(ra) # f38 <printf>
     3b2:	00001597          	auipc	a1,0x1
     3b6:	12658593          	addi	a1,a1,294 # 14d8 <cv_init+0xc2>
     3ba:	00001517          	auipc	a0,0x1
     3be:	0a650513          	addi	a0,a0,166 # 1460 <cv_init+0x4a>
     3c2:	00001097          	auipc	ra,0x1
     3c6:	b76080e7          	jalr	-1162(ra) # f38 <printf>
     3ca:	00001517          	auipc	a0,0x1
     3ce:	0ae50513          	addi	a0,a0,174 # 1478 <cv_init+0x62>
     3d2:	00001097          	auipc	ra,0x1
     3d6:	b66080e7          	jalr	-1178(ra) # f38 <printf>
     3da:	00001797          	auipc	a5,0x1
     3de:	1b278793          	addi	a5,a5,434 # 158c <ppid>
     3e2:	439c                	lw	a5,0(a5)
     3e4:	853e                	mv	a0,a5
     3e6:	00000097          	auipc	ra,0x0
     3ea:	64a080e7          	jalr	1610(ra) # a30 <kill>
     3ee:	4501                	li	a0,0
     3f0:	00000097          	auipc	ra,0x0
     3f4:	610080e7          	jalr	1552(ra) # a00 <exit>
   assert(fib(3) == 2);
     3f8:	450d                	li	a0,3
     3fa:	00000097          	auipc	ra,0x0
     3fe:	c06080e7          	jalr	-1018(ra) # 0 <fib>
     402:	87aa                	mv	a5,a0
     404:	2781                	sext.w	a5,a5
     406:	873e                	mv	a4,a5
     408:	4789                	li	a5,2
     40a:	06f70363          	beq	a4,a5,470 <worker+0x1ec>
     40e:	04800613          	li	a2,72
     412:	00001597          	auipc	a1,0x1
     416:	01e58593          	addi	a1,a1,30 # 1430 <cv_init+0x1a>
     41a:	00001517          	auipc	a0,0x1
     41e:	02650513          	addi	a0,a0,38 # 1440 <cv_init+0x2a>
     422:	00001097          	auipc	ra,0x1
     426:	b16080e7          	jalr	-1258(ra) # f38 <printf>
     42a:	00001597          	auipc	a1,0x1
     42e:	0be58593          	addi	a1,a1,190 # 14e8 <cv_init+0xd2>
     432:	00001517          	auipc	a0,0x1
     436:	02e50513          	addi	a0,a0,46 # 1460 <cv_init+0x4a>
     43a:	00001097          	auipc	ra,0x1
     43e:	afe080e7          	jalr	-1282(ra) # f38 <printf>
     442:	00001517          	auipc	a0,0x1
     446:	03650513          	addi	a0,a0,54 # 1478 <cv_init+0x62>
     44a:	00001097          	auipc	ra,0x1
     44e:	aee080e7          	jalr	-1298(ra) # f38 <printf>
     452:	00001797          	auipc	a5,0x1
     456:	13a78793          	addi	a5,a5,314 # 158c <ppid>
     45a:	439c                	lw	a5,0(a5)
     45c:	853e                	mv	a0,a5
     45e:	00000097          	auipc	ra,0x0
     462:	5d2080e7          	jalr	1490(ra) # a30 <kill>
     466:	4501                	li	a0,0
     468:	00000097          	auipc	ra,0x0
     46c:	598080e7          	jalr	1432(ra) # a00 <exit>
   assert(fib(9) == 34);
     470:	4525                	li	a0,9
     472:	00000097          	auipc	ra,0x0
     476:	b8e080e7          	jalr	-1138(ra) # 0 <fib>
     47a:	87aa                	mv	a5,a0
     47c:	2781                	sext.w	a5,a5
     47e:	873e                	mv	a4,a5
     480:	02200793          	li	a5,34
     484:	06f70363          	beq	a4,a5,4ea <worker+0x266>
     488:	04900613          	li	a2,73
     48c:	00001597          	auipc	a1,0x1
     490:	fa458593          	addi	a1,a1,-92 # 1430 <cv_init+0x1a>
     494:	00001517          	auipc	a0,0x1
     498:	fac50513          	addi	a0,a0,-84 # 1440 <cv_init+0x2a>
     49c:	00001097          	auipc	ra,0x1
     4a0:	a9c080e7          	jalr	-1380(ra) # f38 <printf>
     4a4:	00001597          	auipc	a1,0x1
     4a8:	05458593          	addi	a1,a1,84 # 14f8 <cv_init+0xe2>
     4ac:	00001517          	auipc	a0,0x1
     4b0:	fb450513          	addi	a0,a0,-76 # 1460 <cv_init+0x4a>
     4b4:	00001097          	auipc	ra,0x1
     4b8:	a84080e7          	jalr	-1404(ra) # f38 <printf>
     4bc:	00001517          	auipc	a0,0x1
     4c0:	fbc50513          	addi	a0,a0,-68 # 1478 <cv_init+0x62>
     4c4:	00001097          	auipc	ra,0x1
     4c8:	a74080e7          	jalr	-1420(ra) # f38 <printf>
     4cc:	00001797          	auipc	a5,0x1
     4d0:	0c078793          	addi	a5,a5,192 # 158c <ppid>
     4d4:	439c                	lw	a5,0(a5)
     4d6:	853e                	mv	a0,a5
     4d8:	00000097          	auipc	ra,0x0
     4dc:	558080e7          	jalr	1368(ra) # a30 <kill>
     4e0:	4501                	li	a0,0
     4e2:	00000097          	auipc	ra,0x0
     4e6:	51e080e7          	jalr	1310(ra) # a00 <exit>
   assert(fib(15) == 610);
     4ea:	453d                	li	a0,15
     4ec:	00000097          	auipc	ra,0x0
     4f0:	b14080e7          	jalr	-1260(ra) # 0 <fib>
     4f4:	87aa                	mv	a5,a0
     4f6:	2781                	sext.w	a5,a5
     4f8:	873e                	mv	a4,a5
     4fa:	26200793          	li	a5,610
     4fe:	06f70363          	beq	a4,a5,564 <worker+0x2e0>
     502:	04a00613          	li	a2,74
     506:	00001597          	auipc	a1,0x1
     50a:	f2a58593          	addi	a1,a1,-214 # 1430 <cv_init+0x1a>
     50e:	00001517          	auipc	a0,0x1
     512:	f3250513          	addi	a0,a0,-206 # 1440 <cv_init+0x2a>
     516:	00001097          	auipc	ra,0x1
     51a:	a22080e7          	jalr	-1502(ra) # f38 <printf>
     51e:	00001597          	auipc	a1,0x1
     522:	fea58593          	addi	a1,a1,-22 # 1508 <cv_init+0xf2>
     526:	00001517          	auipc	a0,0x1
     52a:	f3a50513          	addi	a0,a0,-198 # 1460 <cv_init+0x4a>
     52e:	00001097          	auipc	ra,0x1
     532:	a0a080e7          	jalr	-1526(ra) # f38 <printf>
     536:	00001517          	auipc	a0,0x1
     53a:	f4250513          	addi	a0,a0,-190 # 1478 <cv_init+0x62>
     53e:	00001097          	auipc	ra,0x1
     542:	9fa080e7          	jalr	-1542(ra) # f38 <printf>
     546:	00001797          	auipc	a5,0x1
     54a:	04678793          	addi	a5,a5,70 # 158c <ppid>
     54e:	439c                	lw	a5,0(a5)
     550:	853e                	mv	a0,a5
     552:	00000097          	auipc	ra,0x0
     556:	4de080e7          	jalr	1246(ra) # a30 <kill>
     55a:	4501                	li	a0,0
     55c:	00000097          	auipc	ra,0x0
     560:	4a4080e7          	jalr	1188(ra) # a00 <exit>
   exit(0);
     564:	4501                	li	a0,0
     566:	00000097          	auipc	ra,0x0
     56a:	49a080e7          	jalr	1178(ra) # a00 <exit>

000000000000056e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     56e:	7179                	addi	sp,sp,-48
     570:	f422                	sd	s0,40(sp)
     572:	1800                	addi	s0,sp,48
     574:	fca43c23          	sd	a0,-40(s0)
     578:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     57c:	fd843783          	ld	a5,-40(s0)
     580:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     584:	0001                	nop
     586:	fd043703          	ld	a4,-48(s0)
     58a:	00170793          	addi	a5,a4,1
     58e:	fcf43823          	sd	a5,-48(s0)
     592:	fd843783          	ld	a5,-40(s0)
     596:	00178693          	addi	a3,a5,1
     59a:	fcd43c23          	sd	a3,-40(s0)
     59e:	00074703          	lbu	a4,0(a4)
     5a2:	00e78023          	sb	a4,0(a5)
     5a6:	0007c783          	lbu	a5,0(a5)
     5aa:	fff1                	bnez	a5,586 <strcpy+0x18>
    ;
  return os;
     5ac:	fe843783          	ld	a5,-24(s0)
}
     5b0:	853e                	mv	a0,a5
     5b2:	7422                	ld	s0,40(sp)
     5b4:	6145                	addi	sp,sp,48
     5b6:	8082                	ret

00000000000005b8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     5b8:	1101                	addi	sp,sp,-32
     5ba:	ec22                	sd	s0,24(sp)
     5bc:	1000                	addi	s0,sp,32
     5be:	fea43423          	sd	a0,-24(s0)
     5c2:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     5c6:	a819                	j	5dc <strcmp+0x24>
    p++, q++;
     5c8:	fe843783          	ld	a5,-24(s0)
     5cc:	0785                	addi	a5,a5,1
     5ce:	fef43423          	sd	a5,-24(s0)
     5d2:	fe043783          	ld	a5,-32(s0)
     5d6:	0785                	addi	a5,a5,1
     5d8:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     5dc:	fe843783          	ld	a5,-24(s0)
     5e0:	0007c783          	lbu	a5,0(a5)
     5e4:	cb99                	beqz	a5,5fa <strcmp+0x42>
     5e6:	fe843783          	ld	a5,-24(s0)
     5ea:	0007c703          	lbu	a4,0(a5)
     5ee:	fe043783          	ld	a5,-32(s0)
     5f2:	0007c783          	lbu	a5,0(a5)
     5f6:	fcf709e3          	beq	a4,a5,5c8 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     5fa:	fe843783          	ld	a5,-24(s0)
     5fe:	0007c783          	lbu	a5,0(a5)
     602:	0007871b          	sext.w	a4,a5
     606:	fe043783          	ld	a5,-32(s0)
     60a:	0007c783          	lbu	a5,0(a5)
     60e:	2781                	sext.w	a5,a5
     610:	40f707bb          	subw	a5,a4,a5
     614:	2781                	sext.w	a5,a5
}
     616:	853e                	mv	a0,a5
     618:	6462                	ld	s0,24(sp)
     61a:	6105                	addi	sp,sp,32
     61c:	8082                	ret

000000000000061e <strlen>:

uint
strlen(const char *s)
{
     61e:	7179                	addi	sp,sp,-48
     620:	f422                	sd	s0,40(sp)
     622:	1800                	addi	s0,sp,48
     624:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     628:	fe042623          	sw	zero,-20(s0)
     62c:	a031                	j	638 <strlen+0x1a>
     62e:	fec42783          	lw	a5,-20(s0)
     632:	2785                	addiw	a5,a5,1
     634:	fef42623          	sw	a5,-20(s0)
     638:	fec42783          	lw	a5,-20(s0)
     63c:	fd843703          	ld	a4,-40(s0)
     640:	97ba                	add	a5,a5,a4
     642:	0007c783          	lbu	a5,0(a5)
     646:	f7e5                	bnez	a5,62e <strlen+0x10>
    ;
  return n;
     648:	fec42783          	lw	a5,-20(s0)
}
     64c:	853e                	mv	a0,a5
     64e:	7422                	ld	s0,40(sp)
     650:	6145                	addi	sp,sp,48
     652:	8082                	ret

0000000000000654 <memset>:

void*
memset(void *dst, int c, uint n)
{
     654:	7179                	addi	sp,sp,-48
     656:	f422                	sd	s0,40(sp)
     658:	1800                	addi	s0,sp,48
     65a:	fca43c23          	sd	a0,-40(s0)
     65e:	87ae                	mv	a5,a1
     660:	8732                	mv	a4,a2
     662:	fcf42a23          	sw	a5,-44(s0)
     666:	87ba                	mv	a5,a4
     668:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     66c:	fd843783          	ld	a5,-40(s0)
     670:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     674:	fe042623          	sw	zero,-20(s0)
     678:	a00d                	j	69a <memset+0x46>
    cdst[i] = c;
     67a:	fec42783          	lw	a5,-20(s0)
     67e:	fe043703          	ld	a4,-32(s0)
     682:	97ba                	add	a5,a5,a4
     684:	fd442703          	lw	a4,-44(s0)
     688:	0ff77713          	zext.b	a4,a4
     68c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     690:	fec42783          	lw	a5,-20(s0)
     694:	2785                	addiw	a5,a5,1
     696:	fef42623          	sw	a5,-20(s0)
     69a:	fec42703          	lw	a4,-20(s0)
     69e:	fd042783          	lw	a5,-48(s0)
     6a2:	2781                	sext.w	a5,a5
     6a4:	fcf76be3          	bltu	a4,a5,67a <memset+0x26>
  }
  return dst;
     6a8:	fd843783          	ld	a5,-40(s0)
}
     6ac:	853e                	mv	a0,a5
     6ae:	7422                	ld	s0,40(sp)
     6b0:	6145                	addi	sp,sp,48
     6b2:	8082                	ret

00000000000006b4 <strchr>:

char*
strchr(const char *s, char c)
{
     6b4:	1101                	addi	sp,sp,-32
     6b6:	ec22                	sd	s0,24(sp)
     6b8:	1000                	addi	s0,sp,32
     6ba:	fea43423          	sd	a0,-24(s0)
     6be:	87ae                	mv	a5,a1
     6c0:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     6c4:	a01d                	j	6ea <strchr+0x36>
    if(*s == c)
     6c6:	fe843783          	ld	a5,-24(s0)
     6ca:	0007c703          	lbu	a4,0(a5)
     6ce:	fe744783          	lbu	a5,-25(s0)
     6d2:	0ff7f793          	zext.b	a5,a5
     6d6:	00e79563          	bne	a5,a4,6e0 <strchr+0x2c>
      return (char*)s;
     6da:	fe843783          	ld	a5,-24(s0)
     6de:	a821                	j	6f6 <strchr+0x42>
  for(; *s; s++)
     6e0:	fe843783          	ld	a5,-24(s0)
     6e4:	0785                	addi	a5,a5,1
     6e6:	fef43423          	sd	a5,-24(s0)
     6ea:	fe843783          	ld	a5,-24(s0)
     6ee:	0007c783          	lbu	a5,0(a5)
     6f2:	fbf1                	bnez	a5,6c6 <strchr+0x12>
  return 0;
     6f4:	4781                	li	a5,0
}
     6f6:	853e                	mv	a0,a5
     6f8:	6462                	ld	s0,24(sp)
     6fa:	6105                	addi	sp,sp,32
     6fc:	8082                	ret

00000000000006fe <gets>:

char*
gets(char *buf, int max)
{
     6fe:	7179                	addi	sp,sp,-48
     700:	f406                	sd	ra,40(sp)
     702:	f022                	sd	s0,32(sp)
     704:	1800                	addi	s0,sp,48
     706:	fca43c23          	sd	a0,-40(s0)
     70a:	87ae                	mv	a5,a1
     70c:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     710:	fe042623          	sw	zero,-20(s0)
     714:	a8a1                	j	76c <gets+0x6e>
    cc = read(0, &c, 1);
     716:	fe740793          	addi	a5,s0,-25
     71a:	4605                	li	a2,1
     71c:	85be                	mv	a1,a5
     71e:	4501                	li	a0,0
     720:	00000097          	auipc	ra,0x0
     724:	2f8080e7          	jalr	760(ra) # a18 <read>
     728:	87aa                	mv	a5,a0
     72a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     72e:	fe842783          	lw	a5,-24(s0)
     732:	2781                	sext.w	a5,a5
     734:	04f05763          	blez	a5,782 <gets+0x84>
      break;
    buf[i++] = c;
     738:	fec42783          	lw	a5,-20(s0)
     73c:	0017871b          	addiw	a4,a5,1
     740:	fee42623          	sw	a4,-20(s0)
     744:	873e                	mv	a4,a5
     746:	fd843783          	ld	a5,-40(s0)
     74a:	97ba                	add	a5,a5,a4
     74c:	fe744703          	lbu	a4,-25(s0)
     750:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     754:	fe744783          	lbu	a5,-25(s0)
     758:	873e                	mv	a4,a5
     75a:	47a9                	li	a5,10
     75c:	02f70463          	beq	a4,a5,784 <gets+0x86>
     760:	fe744783          	lbu	a5,-25(s0)
     764:	873e                	mv	a4,a5
     766:	47b5                	li	a5,13
     768:	00f70e63          	beq	a4,a5,784 <gets+0x86>
  for(i=0; i+1 < max; ){
     76c:	fec42783          	lw	a5,-20(s0)
     770:	2785                	addiw	a5,a5,1
     772:	0007871b          	sext.w	a4,a5
     776:	fd442783          	lw	a5,-44(s0)
     77a:	2781                	sext.w	a5,a5
     77c:	f8f74de3          	blt	a4,a5,716 <gets+0x18>
     780:	a011                	j	784 <gets+0x86>
      break;
     782:	0001                	nop
      break;
  }
  buf[i] = '\0';
     784:	fec42783          	lw	a5,-20(s0)
     788:	fd843703          	ld	a4,-40(s0)
     78c:	97ba                	add	a5,a5,a4
     78e:	00078023          	sb	zero,0(a5)
  return buf;
     792:	fd843783          	ld	a5,-40(s0)
}
     796:	853e                	mv	a0,a5
     798:	70a2                	ld	ra,40(sp)
     79a:	7402                	ld	s0,32(sp)
     79c:	6145                	addi	sp,sp,48
     79e:	8082                	ret

00000000000007a0 <stat>:

int
stat(const char *n, struct stat *st)
{
     7a0:	7179                	addi	sp,sp,-48
     7a2:	f406                	sd	ra,40(sp)
     7a4:	f022                	sd	s0,32(sp)
     7a6:	1800                	addi	s0,sp,48
     7a8:	fca43c23          	sd	a0,-40(s0)
     7ac:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     7b0:	4581                	li	a1,0
     7b2:	fd843503          	ld	a0,-40(s0)
     7b6:	00000097          	auipc	ra,0x0
     7ba:	28a080e7          	jalr	650(ra) # a40 <open>
     7be:	87aa                	mv	a5,a0
     7c0:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     7c4:	fec42783          	lw	a5,-20(s0)
     7c8:	2781                	sext.w	a5,a5
     7ca:	0007d463          	bgez	a5,7d2 <stat+0x32>
    return -1;
     7ce:	57fd                	li	a5,-1
     7d0:	a035                	j	7fc <stat+0x5c>
  r = fstat(fd, st);
     7d2:	fec42783          	lw	a5,-20(s0)
     7d6:	fd043583          	ld	a1,-48(s0)
     7da:	853e                	mv	a0,a5
     7dc:	00000097          	auipc	ra,0x0
     7e0:	27c080e7          	jalr	636(ra) # a58 <fstat>
     7e4:	87aa                	mv	a5,a0
     7e6:	fef42423          	sw	a5,-24(s0)
  close(fd);
     7ea:	fec42783          	lw	a5,-20(s0)
     7ee:	853e                	mv	a0,a5
     7f0:	00000097          	auipc	ra,0x0
     7f4:	238080e7          	jalr	568(ra) # a28 <close>
  return r;
     7f8:	fe842783          	lw	a5,-24(s0)
}
     7fc:	853e                	mv	a0,a5
     7fe:	70a2                	ld	ra,40(sp)
     800:	7402                	ld	s0,32(sp)
     802:	6145                	addi	sp,sp,48
     804:	8082                	ret

0000000000000806 <atoi>:

int
atoi(const char *s)
{
     806:	7179                	addi	sp,sp,-48
     808:	f422                	sd	s0,40(sp)
     80a:	1800                	addi	s0,sp,48
     80c:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     810:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     814:	a81d                	j	84a <atoi+0x44>
    n = n*10 + *s++ - '0';
     816:	fec42783          	lw	a5,-20(s0)
     81a:	873e                	mv	a4,a5
     81c:	87ba                	mv	a5,a4
     81e:	0027979b          	slliw	a5,a5,0x2
     822:	9fb9                	addw	a5,a5,a4
     824:	0017979b          	slliw	a5,a5,0x1
     828:	0007871b          	sext.w	a4,a5
     82c:	fd843783          	ld	a5,-40(s0)
     830:	00178693          	addi	a3,a5,1
     834:	fcd43c23          	sd	a3,-40(s0)
     838:	0007c783          	lbu	a5,0(a5)
     83c:	2781                	sext.w	a5,a5
     83e:	9fb9                	addw	a5,a5,a4
     840:	2781                	sext.w	a5,a5
     842:	fd07879b          	addiw	a5,a5,-48
     846:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     84a:	fd843783          	ld	a5,-40(s0)
     84e:	0007c783          	lbu	a5,0(a5)
     852:	873e                	mv	a4,a5
     854:	02f00793          	li	a5,47
     858:	00e7fb63          	bgeu	a5,a4,86e <atoi+0x68>
     85c:	fd843783          	ld	a5,-40(s0)
     860:	0007c783          	lbu	a5,0(a5)
     864:	873e                	mv	a4,a5
     866:	03900793          	li	a5,57
     86a:	fae7f6e3          	bgeu	a5,a4,816 <atoi+0x10>
  return n;
     86e:	fec42783          	lw	a5,-20(s0)
}
     872:	853e                	mv	a0,a5
     874:	7422                	ld	s0,40(sp)
     876:	6145                	addi	sp,sp,48
     878:	8082                	ret

000000000000087a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     87a:	7139                	addi	sp,sp,-64
     87c:	fc22                	sd	s0,56(sp)
     87e:	0080                	addi	s0,sp,64
     880:	fca43c23          	sd	a0,-40(s0)
     884:	fcb43823          	sd	a1,-48(s0)
     888:	87b2                	mv	a5,a2
     88a:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     88e:	fd843783          	ld	a5,-40(s0)
     892:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     896:	fd043783          	ld	a5,-48(s0)
     89a:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     89e:	fe043703          	ld	a4,-32(s0)
     8a2:	fe843783          	ld	a5,-24(s0)
     8a6:	02e7fc63          	bgeu	a5,a4,8de <memmove+0x64>
    while(n-- > 0)
     8aa:	a00d                	j	8cc <memmove+0x52>
      *dst++ = *src++;
     8ac:	fe043703          	ld	a4,-32(s0)
     8b0:	00170793          	addi	a5,a4,1
     8b4:	fef43023          	sd	a5,-32(s0)
     8b8:	fe843783          	ld	a5,-24(s0)
     8bc:	00178693          	addi	a3,a5,1
     8c0:	fed43423          	sd	a3,-24(s0)
     8c4:	00074703          	lbu	a4,0(a4)
     8c8:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     8cc:	fcc42783          	lw	a5,-52(s0)
     8d0:	fff7871b          	addiw	a4,a5,-1
     8d4:	fce42623          	sw	a4,-52(s0)
     8d8:	fcf04ae3          	bgtz	a5,8ac <memmove+0x32>
     8dc:	a891                	j	930 <memmove+0xb6>
  } else {
    dst += n;
     8de:	fcc42783          	lw	a5,-52(s0)
     8e2:	fe843703          	ld	a4,-24(s0)
     8e6:	97ba                	add	a5,a5,a4
     8e8:	fef43423          	sd	a5,-24(s0)
    src += n;
     8ec:	fcc42783          	lw	a5,-52(s0)
     8f0:	fe043703          	ld	a4,-32(s0)
     8f4:	97ba                	add	a5,a5,a4
     8f6:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     8fa:	a01d                	j	920 <memmove+0xa6>
      *--dst = *--src;
     8fc:	fe043783          	ld	a5,-32(s0)
     900:	17fd                	addi	a5,a5,-1
     902:	fef43023          	sd	a5,-32(s0)
     906:	fe843783          	ld	a5,-24(s0)
     90a:	17fd                	addi	a5,a5,-1
     90c:	fef43423          	sd	a5,-24(s0)
     910:	fe043783          	ld	a5,-32(s0)
     914:	0007c703          	lbu	a4,0(a5)
     918:	fe843783          	ld	a5,-24(s0)
     91c:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     920:	fcc42783          	lw	a5,-52(s0)
     924:	fff7871b          	addiw	a4,a5,-1
     928:	fce42623          	sw	a4,-52(s0)
     92c:	fcf048e3          	bgtz	a5,8fc <memmove+0x82>
  }
  return vdst;
     930:	fd843783          	ld	a5,-40(s0)
}
     934:	853e                	mv	a0,a5
     936:	7462                	ld	s0,56(sp)
     938:	6121                	addi	sp,sp,64
     93a:	8082                	ret

000000000000093c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     93c:	7139                	addi	sp,sp,-64
     93e:	fc22                	sd	s0,56(sp)
     940:	0080                	addi	s0,sp,64
     942:	fca43c23          	sd	a0,-40(s0)
     946:	fcb43823          	sd	a1,-48(s0)
     94a:	87b2                	mv	a5,a2
     94c:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     950:	fd843783          	ld	a5,-40(s0)
     954:	fef43423          	sd	a5,-24(s0)
     958:	fd043783          	ld	a5,-48(s0)
     95c:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     960:	a0a1                	j	9a8 <memcmp+0x6c>
    if (*p1 != *p2) {
     962:	fe843783          	ld	a5,-24(s0)
     966:	0007c703          	lbu	a4,0(a5)
     96a:	fe043783          	ld	a5,-32(s0)
     96e:	0007c783          	lbu	a5,0(a5)
     972:	02f70163          	beq	a4,a5,994 <memcmp+0x58>
      return *p1 - *p2;
     976:	fe843783          	ld	a5,-24(s0)
     97a:	0007c783          	lbu	a5,0(a5)
     97e:	0007871b          	sext.w	a4,a5
     982:	fe043783          	ld	a5,-32(s0)
     986:	0007c783          	lbu	a5,0(a5)
     98a:	2781                	sext.w	a5,a5
     98c:	40f707bb          	subw	a5,a4,a5
     990:	2781                	sext.w	a5,a5
     992:	a01d                	j	9b8 <memcmp+0x7c>
    }
    p1++;
     994:	fe843783          	ld	a5,-24(s0)
     998:	0785                	addi	a5,a5,1
     99a:	fef43423          	sd	a5,-24(s0)
    p2++;
     99e:	fe043783          	ld	a5,-32(s0)
     9a2:	0785                	addi	a5,a5,1
     9a4:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     9a8:	fcc42783          	lw	a5,-52(s0)
     9ac:	fff7871b          	addiw	a4,a5,-1
     9b0:	fce42623          	sw	a4,-52(s0)
     9b4:	f7dd                	bnez	a5,962 <memcmp+0x26>
  }
  return 0;
     9b6:	4781                	li	a5,0
}
     9b8:	853e                	mv	a0,a5
     9ba:	7462                	ld	s0,56(sp)
     9bc:	6121                	addi	sp,sp,64
     9be:	8082                	ret

00000000000009c0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     9c0:	7179                	addi	sp,sp,-48
     9c2:	f406                	sd	ra,40(sp)
     9c4:	f022                	sd	s0,32(sp)
     9c6:	1800                	addi	s0,sp,48
     9c8:	fea43423          	sd	a0,-24(s0)
     9cc:	feb43023          	sd	a1,-32(s0)
     9d0:	87b2                	mv	a5,a2
     9d2:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     9d6:	fdc42783          	lw	a5,-36(s0)
     9da:	863e                	mv	a2,a5
     9dc:	fe043583          	ld	a1,-32(s0)
     9e0:	fe843503          	ld	a0,-24(s0)
     9e4:	00000097          	auipc	ra,0x0
     9e8:	e96080e7          	jalr	-362(ra) # 87a <memmove>
     9ec:	87aa                	mv	a5,a0
}
     9ee:	853e                	mv	a0,a5
     9f0:	70a2                	ld	ra,40(sp)
     9f2:	7402                	ld	s0,32(sp)
     9f4:	6145                	addi	sp,sp,48
     9f6:	8082                	ret

00000000000009f8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     9f8:	4885                	li	a7,1
 ecall
     9fa:	00000073          	ecall
 ret
     9fe:	8082                	ret

0000000000000a00 <exit>:
.global exit
exit:
 li a7, SYS_exit
     a00:	4889                	li	a7,2
 ecall
     a02:	00000073          	ecall
 ret
     a06:	8082                	ret

0000000000000a08 <wait>:
.global wait
wait:
 li a7, SYS_wait
     a08:	488d                	li	a7,3
 ecall
     a0a:	00000073          	ecall
 ret
     a0e:	8082                	ret

0000000000000a10 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     a10:	4891                	li	a7,4
 ecall
     a12:	00000073          	ecall
 ret
     a16:	8082                	ret

0000000000000a18 <read>:
.global read
read:
 li a7, SYS_read
     a18:	4895                	li	a7,5
 ecall
     a1a:	00000073          	ecall
 ret
     a1e:	8082                	ret

0000000000000a20 <write>:
.global write
write:
 li a7, SYS_write
     a20:	48c1                	li	a7,16
 ecall
     a22:	00000073          	ecall
 ret
     a26:	8082                	ret

0000000000000a28 <close>:
.global close
close:
 li a7, SYS_close
     a28:	48d5                	li	a7,21
 ecall
     a2a:	00000073          	ecall
 ret
     a2e:	8082                	ret

0000000000000a30 <kill>:
.global kill
kill:
 li a7, SYS_kill
     a30:	4899                	li	a7,6
 ecall
     a32:	00000073          	ecall
 ret
     a36:	8082                	ret

0000000000000a38 <exec>:
.global exec
exec:
 li a7, SYS_exec
     a38:	489d                	li	a7,7
 ecall
     a3a:	00000073          	ecall
 ret
     a3e:	8082                	ret

0000000000000a40 <open>:
.global open
open:
 li a7, SYS_open
     a40:	48bd                	li	a7,15
 ecall
     a42:	00000073          	ecall
 ret
     a46:	8082                	ret

0000000000000a48 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     a48:	48c5                	li	a7,17
 ecall
     a4a:	00000073          	ecall
 ret
     a4e:	8082                	ret

0000000000000a50 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     a50:	48c9                	li	a7,18
 ecall
     a52:	00000073          	ecall
 ret
     a56:	8082                	ret

0000000000000a58 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     a58:	48a1                	li	a7,8
 ecall
     a5a:	00000073          	ecall
 ret
     a5e:	8082                	ret

0000000000000a60 <link>:
.global link
link:
 li a7, SYS_link
     a60:	48cd                	li	a7,19
 ecall
     a62:	00000073          	ecall
 ret
     a66:	8082                	ret

0000000000000a68 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     a68:	48d1                	li	a7,20
 ecall
     a6a:	00000073          	ecall
 ret
     a6e:	8082                	ret

0000000000000a70 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     a70:	48a5                	li	a7,9
 ecall
     a72:	00000073          	ecall
 ret
     a76:	8082                	ret

0000000000000a78 <dup>:
.global dup
dup:
 li a7, SYS_dup
     a78:	48a9                	li	a7,10
 ecall
     a7a:	00000073          	ecall
 ret
     a7e:	8082                	ret

0000000000000a80 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     a80:	48ad                	li	a7,11
 ecall
     a82:	00000073          	ecall
 ret
     a86:	8082                	ret

0000000000000a88 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     a88:	48b1                	li	a7,12
 ecall
     a8a:	00000073          	ecall
 ret
     a8e:	8082                	ret

0000000000000a90 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     a90:	48b5                	li	a7,13
 ecall
     a92:	00000073          	ecall
 ret
     a96:	8082                	ret

0000000000000a98 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     a98:	48b9                	li	a7,14
 ecall
     a9a:	00000073          	ecall
 ret
     a9e:	8082                	ret

0000000000000aa0 <clone>:
.global clone
clone:
 li a7, SYS_clone
     aa0:	48d9                	li	a7,22
 ecall
     aa2:	00000073          	ecall
 ret
     aa6:	8082                	ret

0000000000000aa8 <join>:
.global join
join:
 li a7, SYS_join
     aa8:	48dd                	li	a7,23
 ecall
     aaa:	00000073          	ecall
 ret
     aae:	8082                	ret

0000000000000ab0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     ab0:	1101                	addi	sp,sp,-32
     ab2:	ec06                	sd	ra,24(sp)
     ab4:	e822                	sd	s0,16(sp)
     ab6:	1000                	addi	s0,sp,32
     ab8:	87aa                	mv	a5,a0
     aba:	872e                	mv	a4,a1
     abc:	fef42623          	sw	a5,-20(s0)
     ac0:	87ba                	mv	a5,a4
     ac2:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     ac6:	feb40713          	addi	a4,s0,-21
     aca:	fec42783          	lw	a5,-20(s0)
     ace:	4605                	li	a2,1
     ad0:	85ba                	mv	a1,a4
     ad2:	853e                	mv	a0,a5
     ad4:	00000097          	auipc	ra,0x0
     ad8:	f4c080e7          	jalr	-180(ra) # a20 <write>
}
     adc:	0001                	nop
     ade:	60e2                	ld	ra,24(sp)
     ae0:	6442                	ld	s0,16(sp)
     ae2:	6105                	addi	sp,sp,32
     ae4:	8082                	ret

0000000000000ae6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     ae6:	7139                	addi	sp,sp,-64
     ae8:	fc06                	sd	ra,56(sp)
     aea:	f822                	sd	s0,48(sp)
     aec:	0080                	addi	s0,sp,64
     aee:	87aa                	mv	a5,a0
     af0:	8736                	mv	a4,a3
     af2:	fcf42623          	sw	a5,-52(s0)
     af6:	87ae                	mv	a5,a1
     af8:	fcf42423          	sw	a5,-56(s0)
     afc:	87b2                	mv	a5,a2
     afe:	fcf42223          	sw	a5,-60(s0)
     b02:	87ba                	mv	a5,a4
     b04:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     b08:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     b0c:	fc042783          	lw	a5,-64(s0)
     b10:	2781                	sext.w	a5,a5
     b12:	c38d                	beqz	a5,b34 <printint+0x4e>
     b14:	fc842783          	lw	a5,-56(s0)
     b18:	2781                	sext.w	a5,a5
     b1a:	0007dd63          	bgez	a5,b34 <printint+0x4e>
    neg = 1;
     b1e:	4785                	li	a5,1
     b20:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     b24:	fc842783          	lw	a5,-56(s0)
     b28:	40f007bb          	negw	a5,a5
     b2c:	2781                	sext.w	a5,a5
     b2e:	fef42223          	sw	a5,-28(s0)
     b32:	a029                	j	b3c <printint+0x56>
  } else {
    x = xx;
     b34:	fc842783          	lw	a5,-56(s0)
     b38:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     b3c:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     b40:	fc442783          	lw	a5,-60(s0)
     b44:	fe442703          	lw	a4,-28(s0)
     b48:	02f777bb          	remuw	a5,a4,a5
     b4c:	0007861b          	sext.w	a2,a5
     b50:	fec42783          	lw	a5,-20(s0)
     b54:	0017871b          	addiw	a4,a5,1
     b58:	fee42623          	sw	a4,-20(s0)
     b5c:	00001697          	auipc	a3,0x1
     b60:	a1468693          	addi	a3,a3,-1516 # 1570 <digits>
     b64:	02061713          	slli	a4,a2,0x20
     b68:	9301                	srli	a4,a4,0x20
     b6a:	9736                	add	a4,a4,a3
     b6c:	00074703          	lbu	a4,0(a4)
     b70:	17c1                	addi	a5,a5,-16
     b72:	97a2                	add	a5,a5,s0
     b74:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     b78:	fc442783          	lw	a5,-60(s0)
     b7c:	fe442703          	lw	a4,-28(s0)
     b80:	02f757bb          	divuw	a5,a4,a5
     b84:	fef42223          	sw	a5,-28(s0)
     b88:	fe442783          	lw	a5,-28(s0)
     b8c:	2781                	sext.w	a5,a5
     b8e:	fbcd                	bnez	a5,b40 <printint+0x5a>
  if(neg)
     b90:	fe842783          	lw	a5,-24(s0)
     b94:	2781                	sext.w	a5,a5
     b96:	cf85                	beqz	a5,bce <printint+0xe8>
    buf[i++] = '-';
     b98:	fec42783          	lw	a5,-20(s0)
     b9c:	0017871b          	addiw	a4,a5,1
     ba0:	fee42623          	sw	a4,-20(s0)
     ba4:	17c1                	addi	a5,a5,-16
     ba6:	97a2                	add	a5,a5,s0
     ba8:	02d00713          	li	a4,45
     bac:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     bb0:	a839                	j	bce <printint+0xe8>
    putc(fd, buf[i]);
     bb2:	fec42783          	lw	a5,-20(s0)
     bb6:	17c1                	addi	a5,a5,-16
     bb8:	97a2                	add	a5,a5,s0
     bba:	fe07c703          	lbu	a4,-32(a5)
     bbe:	fcc42783          	lw	a5,-52(s0)
     bc2:	85ba                	mv	a1,a4
     bc4:	853e                	mv	a0,a5
     bc6:	00000097          	auipc	ra,0x0
     bca:	eea080e7          	jalr	-278(ra) # ab0 <putc>
  while(--i >= 0)
     bce:	fec42783          	lw	a5,-20(s0)
     bd2:	37fd                	addiw	a5,a5,-1
     bd4:	fef42623          	sw	a5,-20(s0)
     bd8:	fec42783          	lw	a5,-20(s0)
     bdc:	2781                	sext.w	a5,a5
     bde:	fc07dae3          	bgez	a5,bb2 <printint+0xcc>
}
     be2:	0001                	nop
     be4:	0001                	nop
     be6:	70e2                	ld	ra,56(sp)
     be8:	7442                	ld	s0,48(sp)
     bea:	6121                	addi	sp,sp,64
     bec:	8082                	ret

0000000000000bee <printptr>:

static void
printptr(int fd, uint64 x) {
     bee:	7179                	addi	sp,sp,-48
     bf0:	f406                	sd	ra,40(sp)
     bf2:	f022                	sd	s0,32(sp)
     bf4:	1800                	addi	s0,sp,48
     bf6:	87aa                	mv	a5,a0
     bf8:	fcb43823          	sd	a1,-48(s0)
     bfc:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     c00:	fdc42783          	lw	a5,-36(s0)
     c04:	03000593          	li	a1,48
     c08:	853e                	mv	a0,a5
     c0a:	00000097          	auipc	ra,0x0
     c0e:	ea6080e7          	jalr	-346(ra) # ab0 <putc>
  putc(fd, 'x');
     c12:	fdc42783          	lw	a5,-36(s0)
     c16:	07800593          	li	a1,120
     c1a:	853e                	mv	a0,a5
     c1c:	00000097          	auipc	ra,0x0
     c20:	e94080e7          	jalr	-364(ra) # ab0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     c24:	fe042623          	sw	zero,-20(s0)
     c28:	a82d                	j	c62 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     c2a:	fd043783          	ld	a5,-48(s0)
     c2e:	93f1                	srli	a5,a5,0x3c
     c30:	00001717          	auipc	a4,0x1
     c34:	94070713          	addi	a4,a4,-1728 # 1570 <digits>
     c38:	97ba                	add	a5,a5,a4
     c3a:	0007c703          	lbu	a4,0(a5)
     c3e:	fdc42783          	lw	a5,-36(s0)
     c42:	85ba                	mv	a1,a4
     c44:	853e                	mv	a0,a5
     c46:	00000097          	auipc	ra,0x0
     c4a:	e6a080e7          	jalr	-406(ra) # ab0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     c4e:	fec42783          	lw	a5,-20(s0)
     c52:	2785                	addiw	a5,a5,1
     c54:	fef42623          	sw	a5,-20(s0)
     c58:	fd043783          	ld	a5,-48(s0)
     c5c:	0792                	slli	a5,a5,0x4
     c5e:	fcf43823          	sd	a5,-48(s0)
     c62:	fec42783          	lw	a5,-20(s0)
     c66:	873e                	mv	a4,a5
     c68:	47bd                	li	a5,15
     c6a:	fce7f0e3          	bgeu	a5,a4,c2a <printptr+0x3c>
}
     c6e:	0001                	nop
     c70:	0001                	nop
     c72:	70a2                	ld	ra,40(sp)
     c74:	7402                	ld	s0,32(sp)
     c76:	6145                	addi	sp,sp,48
     c78:	8082                	ret

0000000000000c7a <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     c7a:	715d                	addi	sp,sp,-80
     c7c:	e486                	sd	ra,72(sp)
     c7e:	e0a2                	sd	s0,64(sp)
     c80:	0880                	addi	s0,sp,80
     c82:	87aa                	mv	a5,a0
     c84:	fcb43023          	sd	a1,-64(s0)
     c88:	fac43c23          	sd	a2,-72(s0)
     c8c:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     c90:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     c94:	fe042223          	sw	zero,-28(s0)
     c98:	a42d                	j	ec2 <vprintf+0x248>
    c = fmt[i] & 0xff;
     c9a:	fe442783          	lw	a5,-28(s0)
     c9e:	fc043703          	ld	a4,-64(s0)
     ca2:	97ba                	add	a5,a5,a4
     ca4:	0007c783          	lbu	a5,0(a5)
     ca8:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     cac:	fe042783          	lw	a5,-32(s0)
     cb0:	2781                	sext.w	a5,a5
     cb2:	eb9d                	bnez	a5,ce8 <vprintf+0x6e>
      if(c == '%'){
     cb4:	fdc42783          	lw	a5,-36(s0)
     cb8:	0007871b          	sext.w	a4,a5
     cbc:	02500793          	li	a5,37
     cc0:	00f71763          	bne	a4,a5,cce <vprintf+0x54>
        state = '%';
     cc4:	02500793          	li	a5,37
     cc8:	fef42023          	sw	a5,-32(s0)
     ccc:	a2f5                	j	eb8 <vprintf+0x23e>
      } else {
        putc(fd, c);
     cce:	fdc42783          	lw	a5,-36(s0)
     cd2:	0ff7f713          	zext.b	a4,a5
     cd6:	fcc42783          	lw	a5,-52(s0)
     cda:	85ba                	mv	a1,a4
     cdc:	853e                	mv	a0,a5
     cde:	00000097          	auipc	ra,0x0
     ce2:	dd2080e7          	jalr	-558(ra) # ab0 <putc>
     ce6:	aac9                	j	eb8 <vprintf+0x23e>
      }
    } else if(state == '%'){
     ce8:	fe042783          	lw	a5,-32(s0)
     cec:	0007871b          	sext.w	a4,a5
     cf0:	02500793          	li	a5,37
     cf4:	1cf71263          	bne	a4,a5,eb8 <vprintf+0x23e>
      if(c == 'd'){
     cf8:	fdc42783          	lw	a5,-36(s0)
     cfc:	0007871b          	sext.w	a4,a5
     d00:	06400793          	li	a5,100
     d04:	02f71463          	bne	a4,a5,d2c <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     d08:	fb843783          	ld	a5,-72(s0)
     d0c:	00878713          	addi	a4,a5,8
     d10:	fae43c23          	sd	a4,-72(s0)
     d14:	4398                	lw	a4,0(a5)
     d16:	fcc42783          	lw	a5,-52(s0)
     d1a:	4685                	li	a3,1
     d1c:	4629                	li	a2,10
     d1e:	85ba                	mv	a1,a4
     d20:	853e                	mv	a0,a5
     d22:	00000097          	auipc	ra,0x0
     d26:	dc4080e7          	jalr	-572(ra) # ae6 <printint>
     d2a:	a269                	j	eb4 <vprintf+0x23a>
      } else if(c == 'l') {
     d2c:	fdc42783          	lw	a5,-36(s0)
     d30:	0007871b          	sext.w	a4,a5
     d34:	06c00793          	li	a5,108
     d38:	02f71663          	bne	a4,a5,d64 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     d3c:	fb843783          	ld	a5,-72(s0)
     d40:	00878713          	addi	a4,a5,8
     d44:	fae43c23          	sd	a4,-72(s0)
     d48:	639c                	ld	a5,0(a5)
     d4a:	0007871b          	sext.w	a4,a5
     d4e:	fcc42783          	lw	a5,-52(s0)
     d52:	4681                	li	a3,0
     d54:	4629                	li	a2,10
     d56:	85ba                	mv	a1,a4
     d58:	853e                	mv	a0,a5
     d5a:	00000097          	auipc	ra,0x0
     d5e:	d8c080e7          	jalr	-628(ra) # ae6 <printint>
     d62:	aa89                	j	eb4 <vprintf+0x23a>
      } else if(c == 'x') {
     d64:	fdc42783          	lw	a5,-36(s0)
     d68:	0007871b          	sext.w	a4,a5
     d6c:	07800793          	li	a5,120
     d70:	02f71463          	bne	a4,a5,d98 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     d74:	fb843783          	ld	a5,-72(s0)
     d78:	00878713          	addi	a4,a5,8
     d7c:	fae43c23          	sd	a4,-72(s0)
     d80:	4398                	lw	a4,0(a5)
     d82:	fcc42783          	lw	a5,-52(s0)
     d86:	4681                	li	a3,0
     d88:	4641                	li	a2,16
     d8a:	85ba                	mv	a1,a4
     d8c:	853e                	mv	a0,a5
     d8e:	00000097          	auipc	ra,0x0
     d92:	d58080e7          	jalr	-680(ra) # ae6 <printint>
     d96:	aa39                	j	eb4 <vprintf+0x23a>
      } else if(c == 'p') {
     d98:	fdc42783          	lw	a5,-36(s0)
     d9c:	0007871b          	sext.w	a4,a5
     da0:	07000793          	li	a5,112
     da4:	02f71263          	bne	a4,a5,dc8 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     da8:	fb843783          	ld	a5,-72(s0)
     dac:	00878713          	addi	a4,a5,8
     db0:	fae43c23          	sd	a4,-72(s0)
     db4:	6398                	ld	a4,0(a5)
     db6:	fcc42783          	lw	a5,-52(s0)
     dba:	85ba                	mv	a1,a4
     dbc:	853e                	mv	a0,a5
     dbe:	00000097          	auipc	ra,0x0
     dc2:	e30080e7          	jalr	-464(ra) # bee <printptr>
     dc6:	a0fd                	j	eb4 <vprintf+0x23a>
      } else if(c == 's'){
     dc8:	fdc42783          	lw	a5,-36(s0)
     dcc:	0007871b          	sext.w	a4,a5
     dd0:	07300793          	li	a5,115
     dd4:	04f71c63          	bne	a4,a5,e2c <vprintf+0x1b2>
        s = va_arg(ap, char*);
     dd8:	fb843783          	ld	a5,-72(s0)
     ddc:	00878713          	addi	a4,a5,8
     de0:	fae43c23          	sd	a4,-72(s0)
     de4:	639c                	ld	a5,0(a5)
     de6:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     dea:	fe843783          	ld	a5,-24(s0)
     dee:	eb8d                	bnez	a5,e20 <vprintf+0x1a6>
          s = "(null)";
     df0:	00000797          	auipc	a5,0x0
     df4:	72878793          	addi	a5,a5,1832 # 1518 <cv_init+0x102>
     df8:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     dfc:	a015                	j	e20 <vprintf+0x1a6>
          putc(fd, *s);
     dfe:	fe843783          	ld	a5,-24(s0)
     e02:	0007c703          	lbu	a4,0(a5)
     e06:	fcc42783          	lw	a5,-52(s0)
     e0a:	85ba                	mv	a1,a4
     e0c:	853e                	mv	a0,a5
     e0e:	00000097          	auipc	ra,0x0
     e12:	ca2080e7          	jalr	-862(ra) # ab0 <putc>
          s++;
     e16:	fe843783          	ld	a5,-24(s0)
     e1a:	0785                	addi	a5,a5,1
     e1c:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     e20:	fe843783          	ld	a5,-24(s0)
     e24:	0007c783          	lbu	a5,0(a5)
     e28:	fbf9                	bnez	a5,dfe <vprintf+0x184>
     e2a:	a069                	j	eb4 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     e2c:	fdc42783          	lw	a5,-36(s0)
     e30:	0007871b          	sext.w	a4,a5
     e34:	06300793          	li	a5,99
     e38:	02f71463          	bne	a4,a5,e60 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     e3c:	fb843783          	ld	a5,-72(s0)
     e40:	00878713          	addi	a4,a5,8
     e44:	fae43c23          	sd	a4,-72(s0)
     e48:	439c                	lw	a5,0(a5)
     e4a:	0ff7f713          	zext.b	a4,a5
     e4e:	fcc42783          	lw	a5,-52(s0)
     e52:	85ba                	mv	a1,a4
     e54:	853e                	mv	a0,a5
     e56:	00000097          	auipc	ra,0x0
     e5a:	c5a080e7          	jalr	-934(ra) # ab0 <putc>
     e5e:	a899                	j	eb4 <vprintf+0x23a>
      } else if(c == '%'){
     e60:	fdc42783          	lw	a5,-36(s0)
     e64:	0007871b          	sext.w	a4,a5
     e68:	02500793          	li	a5,37
     e6c:	00f71f63          	bne	a4,a5,e8a <vprintf+0x210>
        putc(fd, c);
     e70:	fdc42783          	lw	a5,-36(s0)
     e74:	0ff7f713          	zext.b	a4,a5
     e78:	fcc42783          	lw	a5,-52(s0)
     e7c:	85ba                	mv	a1,a4
     e7e:	853e                	mv	a0,a5
     e80:	00000097          	auipc	ra,0x0
     e84:	c30080e7          	jalr	-976(ra) # ab0 <putc>
     e88:	a035                	j	eb4 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     e8a:	fcc42783          	lw	a5,-52(s0)
     e8e:	02500593          	li	a1,37
     e92:	853e                	mv	a0,a5
     e94:	00000097          	auipc	ra,0x0
     e98:	c1c080e7          	jalr	-996(ra) # ab0 <putc>
        putc(fd, c);
     e9c:	fdc42783          	lw	a5,-36(s0)
     ea0:	0ff7f713          	zext.b	a4,a5
     ea4:	fcc42783          	lw	a5,-52(s0)
     ea8:	85ba                	mv	a1,a4
     eaa:	853e                	mv	a0,a5
     eac:	00000097          	auipc	ra,0x0
     eb0:	c04080e7          	jalr	-1020(ra) # ab0 <putc>
      }
      state = 0;
     eb4:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     eb8:	fe442783          	lw	a5,-28(s0)
     ebc:	2785                	addiw	a5,a5,1
     ebe:	fef42223          	sw	a5,-28(s0)
     ec2:	fe442783          	lw	a5,-28(s0)
     ec6:	fc043703          	ld	a4,-64(s0)
     eca:	97ba                	add	a5,a5,a4
     ecc:	0007c783          	lbu	a5,0(a5)
     ed0:	dc0795e3          	bnez	a5,c9a <vprintf+0x20>
    }
  }
}
     ed4:	0001                	nop
     ed6:	0001                	nop
     ed8:	60a6                	ld	ra,72(sp)
     eda:	6406                	ld	s0,64(sp)
     edc:	6161                	addi	sp,sp,80
     ede:	8082                	ret

0000000000000ee0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     ee0:	7159                	addi	sp,sp,-112
     ee2:	fc06                	sd	ra,56(sp)
     ee4:	f822                	sd	s0,48(sp)
     ee6:	0080                	addi	s0,sp,64
     ee8:	fcb43823          	sd	a1,-48(s0)
     eec:	e010                	sd	a2,0(s0)
     eee:	e414                	sd	a3,8(s0)
     ef0:	e818                	sd	a4,16(s0)
     ef2:	ec1c                	sd	a5,24(s0)
     ef4:	03043023          	sd	a6,32(s0)
     ef8:	03143423          	sd	a7,40(s0)
     efc:	87aa                	mv	a5,a0
     efe:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     f02:	03040793          	addi	a5,s0,48
     f06:	fcf43423          	sd	a5,-56(s0)
     f0a:	fc843783          	ld	a5,-56(s0)
     f0e:	fd078793          	addi	a5,a5,-48
     f12:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     f16:	fe843703          	ld	a4,-24(s0)
     f1a:	fdc42783          	lw	a5,-36(s0)
     f1e:	863a                	mv	a2,a4
     f20:	fd043583          	ld	a1,-48(s0)
     f24:	853e                	mv	a0,a5
     f26:	00000097          	auipc	ra,0x0
     f2a:	d54080e7          	jalr	-684(ra) # c7a <vprintf>
}
     f2e:	0001                	nop
     f30:	70e2                	ld	ra,56(sp)
     f32:	7442                	ld	s0,48(sp)
     f34:	6165                	addi	sp,sp,112
     f36:	8082                	ret

0000000000000f38 <printf>:

void
printf(const char *fmt, ...)
{
     f38:	7159                	addi	sp,sp,-112
     f3a:	f406                	sd	ra,40(sp)
     f3c:	f022                	sd	s0,32(sp)
     f3e:	1800                	addi	s0,sp,48
     f40:	fca43c23          	sd	a0,-40(s0)
     f44:	e40c                	sd	a1,8(s0)
     f46:	e810                	sd	a2,16(s0)
     f48:	ec14                	sd	a3,24(s0)
     f4a:	f018                	sd	a4,32(s0)
     f4c:	f41c                	sd	a5,40(s0)
     f4e:	03043823          	sd	a6,48(s0)
     f52:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     f56:	04040793          	addi	a5,s0,64
     f5a:	fcf43823          	sd	a5,-48(s0)
     f5e:	fd043783          	ld	a5,-48(s0)
     f62:	fc878793          	addi	a5,a5,-56
     f66:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     f6a:	fe843783          	ld	a5,-24(s0)
     f6e:	863e                	mv	a2,a5
     f70:	fd843583          	ld	a1,-40(s0)
     f74:	4505                	li	a0,1
     f76:	00000097          	auipc	ra,0x0
     f7a:	d04080e7          	jalr	-764(ra) # c7a <vprintf>
}
     f7e:	0001                	nop
     f80:	70a2                	ld	ra,40(sp)
     f82:	7402                	ld	s0,32(sp)
     f84:	6165                	addi	sp,sp,112
     f86:	8082                	ret

0000000000000f88 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     f88:	7179                	addi	sp,sp,-48
     f8a:	f422                	sd	s0,40(sp)
     f8c:	1800                	addi	s0,sp,48
     f8e:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     f92:	fd843783          	ld	a5,-40(s0)
     f96:	17c1                	addi	a5,a5,-16
     f98:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f9c:	00000797          	auipc	a5,0x0
     fa0:	60478793          	addi	a5,a5,1540 # 15a0 <freep>
     fa4:	639c                	ld	a5,0(a5)
     fa6:	fef43423          	sd	a5,-24(s0)
     faa:	a815                	j	fde <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fac:	fe843783          	ld	a5,-24(s0)
     fb0:	639c                	ld	a5,0(a5)
     fb2:	fe843703          	ld	a4,-24(s0)
     fb6:	00f76f63          	bltu	a4,a5,fd4 <free+0x4c>
     fba:	fe043703          	ld	a4,-32(s0)
     fbe:	fe843783          	ld	a5,-24(s0)
     fc2:	02e7eb63          	bltu	a5,a4,ff8 <free+0x70>
     fc6:	fe843783          	ld	a5,-24(s0)
     fca:	639c                	ld	a5,0(a5)
     fcc:	fe043703          	ld	a4,-32(s0)
     fd0:	02f76463          	bltu	a4,a5,ff8 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fd4:	fe843783          	ld	a5,-24(s0)
     fd8:	639c                	ld	a5,0(a5)
     fda:	fef43423          	sd	a5,-24(s0)
     fde:	fe043703          	ld	a4,-32(s0)
     fe2:	fe843783          	ld	a5,-24(s0)
     fe6:	fce7f3e3          	bgeu	a5,a4,fac <free+0x24>
     fea:	fe843783          	ld	a5,-24(s0)
     fee:	639c                	ld	a5,0(a5)
     ff0:	fe043703          	ld	a4,-32(s0)
     ff4:	faf77ce3          	bgeu	a4,a5,fac <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     ff8:	fe043783          	ld	a5,-32(s0)
     ffc:	479c                	lw	a5,8(a5)
     ffe:	1782                	slli	a5,a5,0x20
    1000:	9381                	srli	a5,a5,0x20
    1002:	0792                	slli	a5,a5,0x4
    1004:	fe043703          	ld	a4,-32(s0)
    1008:	973e                	add	a4,a4,a5
    100a:	fe843783          	ld	a5,-24(s0)
    100e:	639c                	ld	a5,0(a5)
    1010:	02f71763          	bne	a4,a5,103e <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    1014:	fe043783          	ld	a5,-32(s0)
    1018:	4798                	lw	a4,8(a5)
    101a:	fe843783          	ld	a5,-24(s0)
    101e:	639c                	ld	a5,0(a5)
    1020:	479c                	lw	a5,8(a5)
    1022:	9fb9                	addw	a5,a5,a4
    1024:	0007871b          	sext.w	a4,a5
    1028:	fe043783          	ld	a5,-32(s0)
    102c:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    102e:	fe843783          	ld	a5,-24(s0)
    1032:	639c                	ld	a5,0(a5)
    1034:	6398                	ld	a4,0(a5)
    1036:	fe043783          	ld	a5,-32(s0)
    103a:	e398                	sd	a4,0(a5)
    103c:	a039                	j	104a <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    103e:	fe843783          	ld	a5,-24(s0)
    1042:	6398                	ld	a4,0(a5)
    1044:	fe043783          	ld	a5,-32(s0)
    1048:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    104a:	fe843783          	ld	a5,-24(s0)
    104e:	479c                	lw	a5,8(a5)
    1050:	1782                	slli	a5,a5,0x20
    1052:	9381                	srli	a5,a5,0x20
    1054:	0792                	slli	a5,a5,0x4
    1056:	fe843703          	ld	a4,-24(s0)
    105a:	97ba                	add	a5,a5,a4
    105c:	fe043703          	ld	a4,-32(s0)
    1060:	02f71563          	bne	a4,a5,108a <free+0x102>
    p->s.size += bp->s.size;
    1064:	fe843783          	ld	a5,-24(s0)
    1068:	4798                	lw	a4,8(a5)
    106a:	fe043783          	ld	a5,-32(s0)
    106e:	479c                	lw	a5,8(a5)
    1070:	9fb9                	addw	a5,a5,a4
    1072:	0007871b          	sext.w	a4,a5
    1076:	fe843783          	ld	a5,-24(s0)
    107a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    107c:	fe043783          	ld	a5,-32(s0)
    1080:	6398                	ld	a4,0(a5)
    1082:	fe843783          	ld	a5,-24(s0)
    1086:	e398                	sd	a4,0(a5)
    1088:	a031                	j	1094 <free+0x10c>
  } else
    p->s.ptr = bp;
    108a:	fe843783          	ld	a5,-24(s0)
    108e:	fe043703          	ld	a4,-32(s0)
    1092:	e398                	sd	a4,0(a5)
  freep = p;
    1094:	00000797          	auipc	a5,0x0
    1098:	50c78793          	addi	a5,a5,1292 # 15a0 <freep>
    109c:	fe843703          	ld	a4,-24(s0)
    10a0:	e398                	sd	a4,0(a5)
}
    10a2:	0001                	nop
    10a4:	7422                	ld	s0,40(sp)
    10a6:	6145                	addi	sp,sp,48
    10a8:	8082                	ret

00000000000010aa <morecore>:

static Header*
morecore(uint nu)
{
    10aa:	7179                	addi	sp,sp,-48
    10ac:	f406                	sd	ra,40(sp)
    10ae:	f022                	sd	s0,32(sp)
    10b0:	1800                	addi	s0,sp,48
    10b2:	87aa                	mv	a5,a0
    10b4:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    10b8:	fdc42783          	lw	a5,-36(s0)
    10bc:	0007871b          	sext.w	a4,a5
    10c0:	6785                	lui	a5,0x1
    10c2:	00f77563          	bgeu	a4,a5,10cc <morecore+0x22>
    nu = 4096;
    10c6:	6785                	lui	a5,0x1
    10c8:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    10cc:	fdc42783          	lw	a5,-36(s0)
    10d0:	0047979b          	slliw	a5,a5,0x4
    10d4:	2781                	sext.w	a5,a5
    10d6:	2781                	sext.w	a5,a5
    10d8:	853e                	mv	a0,a5
    10da:	00000097          	auipc	ra,0x0
    10de:	9ae080e7          	jalr	-1618(ra) # a88 <sbrk>
    10e2:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    10e6:	fe843703          	ld	a4,-24(s0)
    10ea:	57fd                	li	a5,-1
    10ec:	00f71463          	bne	a4,a5,10f4 <morecore+0x4a>
    return 0;
    10f0:	4781                	li	a5,0
    10f2:	a03d                	j	1120 <morecore+0x76>
  hp = (Header*)p;
    10f4:	fe843783          	ld	a5,-24(s0)
    10f8:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    10fc:	fe043783          	ld	a5,-32(s0)
    1100:	fdc42703          	lw	a4,-36(s0)
    1104:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    1106:	fe043783          	ld	a5,-32(s0)
    110a:	07c1                	addi	a5,a5,16
    110c:	853e                	mv	a0,a5
    110e:	00000097          	auipc	ra,0x0
    1112:	e7a080e7          	jalr	-390(ra) # f88 <free>
  return freep;
    1116:	00000797          	auipc	a5,0x0
    111a:	48a78793          	addi	a5,a5,1162 # 15a0 <freep>
    111e:	639c                	ld	a5,0(a5)
}
    1120:	853e                	mv	a0,a5
    1122:	70a2                	ld	ra,40(sp)
    1124:	7402                	ld	s0,32(sp)
    1126:	6145                	addi	sp,sp,48
    1128:	8082                	ret

000000000000112a <malloc>:

void*
malloc(uint nbytes)
{
    112a:	7139                	addi	sp,sp,-64
    112c:	fc06                	sd	ra,56(sp)
    112e:	f822                	sd	s0,48(sp)
    1130:	0080                	addi	s0,sp,64
    1132:	87aa                	mv	a5,a0
    1134:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1138:	fcc46783          	lwu	a5,-52(s0)
    113c:	07bd                	addi	a5,a5,15
    113e:	8391                	srli	a5,a5,0x4
    1140:	2781                	sext.w	a5,a5
    1142:	2785                	addiw	a5,a5,1
    1144:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1148:	00000797          	auipc	a5,0x0
    114c:	45878793          	addi	a5,a5,1112 # 15a0 <freep>
    1150:	639c                	ld	a5,0(a5)
    1152:	fef43023          	sd	a5,-32(s0)
    1156:	fe043783          	ld	a5,-32(s0)
    115a:	ef95                	bnez	a5,1196 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    115c:	00000797          	auipc	a5,0x0
    1160:	43478793          	addi	a5,a5,1076 # 1590 <base>
    1164:	fef43023          	sd	a5,-32(s0)
    1168:	00000797          	auipc	a5,0x0
    116c:	43878793          	addi	a5,a5,1080 # 15a0 <freep>
    1170:	fe043703          	ld	a4,-32(s0)
    1174:	e398                	sd	a4,0(a5)
    1176:	00000797          	auipc	a5,0x0
    117a:	42a78793          	addi	a5,a5,1066 # 15a0 <freep>
    117e:	6398                	ld	a4,0(a5)
    1180:	00000797          	auipc	a5,0x0
    1184:	41078793          	addi	a5,a5,1040 # 1590 <base>
    1188:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    118a:	00000797          	auipc	a5,0x0
    118e:	40678793          	addi	a5,a5,1030 # 1590 <base>
    1192:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1196:	fe043783          	ld	a5,-32(s0)
    119a:	639c                	ld	a5,0(a5)
    119c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    11a0:	fe843783          	ld	a5,-24(s0)
    11a4:	4798                	lw	a4,8(a5)
    11a6:	fdc42783          	lw	a5,-36(s0)
    11aa:	2781                	sext.w	a5,a5
    11ac:	06f76763          	bltu	a4,a5,121a <malloc+0xf0>
      if(p->s.size == nunits)
    11b0:	fe843783          	ld	a5,-24(s0)
    11b4:	4798                	lw	a4,8(a5)
    11b6:	fdc42783          	lw	a5,-36(s0)
    11ba:	2781                	sext.w	a5,a5
    11bc:	00e79963          	bne	a5,a4,11ce <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    11c0:	fe843783          	ld	a5,-24(s0)
    11c4:	6398                	ld	a4,0(a5)
    11c6:	fe043783          	ld	a5,-32(s0)
    11ca:	e398                	sd	a4,0(a5)
    11cc:	a825                	j	1204 <malloc+0xda>
      else {
        p->s.size -= nunits;
    11ce:	fe843783          	ld	a5,-24(s0)
    11d2:	479c                	lw	a5,8(a5)
    11d4:	fdc42703          	lw	a4,-36(s0)
    11d8:	9f99                	subw	a5,a5,a4
    11da:	0007871b          	sext.w	a4,a5
    11de:	fe843783          	ld	a5,-24(s0)
    11e2:	c798                	sw	a4,8(a5)
        p += p->s.size;
    11e4:	fe843783          	ld	a5,-24(s0)
    11e8:	479c                	lw	a5,8(a5)
    11ea:	1782                	slli	a5,a5,0x20
    11ec:	9381                	srli	a5,a5,0x20
    11ee:	0792                	slli	a5,a5,0x4
    11f0:	fe843703          	ld	a4,-24(s0)
    11f4:	97ba                	add	a5,a5,a4
    11f6:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    11fa:	fe843783          	ld	a5,-24(s0)
    11fe:	fdc42703          	lw	a4,-36(s0)
    1202:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1204:	00000797          	auipc	a5,0x0
    1208:	39c78793          	addi	a5,a5,924 # 15a0 <freep>
    120c:	fe043703          	ld	a4,-32(s0)
    1210:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1212:	fe843783          	ld	a5,-24(s0)
    1216:	07c1                	addi	a5,a5,16
    1218:	a091                	j	125c <malloc+0x132>
    }
    if(p == freep)
    121a:	00000797          	auipc	a5,0x0
    121e:	38678793          	addi	a5,a5,902 # 15a0 <freep>
    1222:	639c                	ld	a5,0(a5)
    1224:	fe843703          	ld	a4,-24(s0)
    1228:	02f71063          	bne	a4,a5,1248 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    122c:	fdc42783          	lw	a5,-36(s0)
    1230:	853e                	mv	a0,a5
    1232:	00000097          	auipc	ra,0x0
    1236:	e78080e7          	jalr	-392(ra) # 10aa <morecore>
    123a:	fea43423          	sd	a0,-24(s0)
    123e:	fe843783          	ld	a5,-24(s0)
    1242:	e399                	bnez	a5,1248 <malloc+0x11e>
        return 0;
    1244:	4781                	li	a5,0
    1246:	a819                	j	125c <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1248:	fe843783          	ld	a5,-24(s0)
    124c:	fef43023          	sd	a5,-32(s0)
    1250:	fe843783          	ld	a5,-24(s0)
    1254:	639c                	ld	a5,0(a5)
    1256:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    125a:	b799                	j	11a0 <malloc+0x76>
  }
}
    125c:	853e                	mv	a0,a5
    125e:	70e2                	ld	ra,56(sp)
    1260:	7442                	ld	s0,48(sp)
    1262:	6121                	addi	sp,sp,64
    1264:	8082                	ret

0000000000001266 <thread_create>:
typedef uint cont_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
    1266:	7179                	addi	sp,sp,-48
    1268:	f406                	sd	ra,40(sp)
    126a:	f022                	sd	s0,32(sp)
    126c:	1800                	addi	s0,sp,48
    126e:	fca43c23          	sd	a0,-40(s0)
    1272:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
    1276:	6505                	lui	a0,0x1
    1278:	00000097          	auipc	ra,0x0
    127c:	eb2080e7          	jalr	-334(ra) # 112a <malloc>
    1280:	fea43423          	sd	a0,-24(s0)
    1284:	fe843783          	ld	a5,-24(s0)
    1288:	e38d                	bnez	a5,12aa <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
    128a:	00000517          	auipc	a0,0x0
    128e:	29650513          	addi	a0,a0,662 # 1520 <cv_init+0x10a>
    1292:	00000097          	auipc	ra,0x0
    1296:	ca6080e7          	jalr	-858(ra) # f38 <printf>
        free(stack);
    129a:	fe843503          	ld	a0,-24(s0)
    129e:	00000097          	auipc	ra,0x0
    12a2:	cea080e7          	jalr	-790(ra) # f88 <free>
        return -1;
    12a6:	57fd                	li	a5,-1
    12a8:	a099                	j	12ee <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
    12aa:	fe843783          	ld	a5,-24(s0)
    12ae:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
    12b2:	fe043703          	ld	a4,-32(s0)
    12b6:	6785                	lui	a5,0x1
    12b8:	17fd                	addi	a5,a5,-1
    12ba:	8ff9                	and	a5,a5,a4
    12bc:	cf91                	beqz	a5,12d8 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
    12be:	fe043703          	ld	a4,-32(s0)
    12c2:	6785                	lui	a5,0x1
    12c4:	17fd                	addi	a5,a5,-1
    12c6:	8ff9                	and	a5,a5,a4
    12c8:	6705                	lui	a4,0x1
    12ca:	40f707b3          	sub	a5,a4,a5
    12ce:	fe843703          	ld	a4,-24(s0)
    12d2:	97ba                	add	a5,a5,a4
    12d4:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
    12d8:	fe843603          	ld	a2,-24(s0)
    12dc:	fd043583          	ld	a1,-48(s0)
    12e0:	fd843503          	ld	a0,-40(s0)
    12e4:	fffff097          	auipc	ra,0xfffff
    12e8:	7bc080e7          	jalr	1980(ra) # aa0 <clone>
    12ec:	87aa                	mv	a5,a0
}
    12ee:	853e                	mv	a0,a5
    12f0:	70a2                	ld	ra,40(sp)
    12f2:	7402                	ld	s0,32(sp)
    12f4:	6145                	addi	sp,sp,48
    12f6:	8082                	ret

00000000000012f8 <thread_join>:


int thread_join()
{
    12f8:	1101                	addi	sp,sp,-32
    12fa:	ec06                	sd	ra,24(sp)
    12fc:	e822                	sd	s0,16(sp)
    12fe:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
    1300:	fe040793          	addi	a5,s0,-32
    1304:	853e                	mv	a0,a5
    1306:	fffff097          	auipc	ra,0xfffff
    130a:	7a2080e7          	jalr	1954(ra) # aa8 <join>
    130e:	87aa                	mv	a5,a0
    1310:	fef42623          	sw	a5,-20(s0)
    1314:	fec42783          	lw	a5,-20(s0)
    1318:	0007871b          	sext.w	a4,a5
    131c:	57fd                	li	a5,-1
    131e:	00f70963          	beq	a4,a5,1330 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
    1322:	fe043783          	ld	a5,-32(s0)
    1326:	853e                	mv	a0,a5
    1328:	00000097          	auipc	ra,0x0
    132c:	c60080e7          	jalr	-928(ra) # f88 <free>
    } 

    return child_tid;
    1330:	fec42783          	lw	a5,-20(s0)
}
    1334:	853e                	mv	a0,a5
    1336:	60e2                	ld	ra,24(sp)
    1338:	6442                	ld	s0,16(sp)
    133a:	6105                	addi	sp,sp,32
    133c:	8082                	ret

000000000000133e <lock_acquire>:


void lock_acquire (lock_t *lock){
    133e:	1101                	addi	sp,sp,-32
    1340:	ec22                	sd	s0,24(sp)
    1342:	1000                	addi	s0,sp,32
    1344:	fea43423          	sd	a0,-24(s0)
    while( __sync_lock_test_and_set(lock, 1)!=0){
    1348:	0001                	nop
    134a:	fe843783          	ld	a5,-24(s0)
    134e:	4705                	li	a4,1
    1350:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    1354:	0007079b          	sext.w	a5,a4
    1358:	fbed                	bnez	a5,134a <lock_acquire+0xc>

    ;
    }
     __sync_synchronize();
    135a:	0ff0000f          	fence
        

}
    135e:	0001                	nop
    1360:	6462                	ld	s0,24(sp)
    1362:	6105                	addi	sp,sp,32
    1364:	8082                	ret

0000000000001366 <lock_release>:

void lock_release (lock_t *lock){
    1366:	1101                	addi	sp,sp,-32
    1368:	ec22                	sd	s0,24(sp)
    136a:	1000                	addi	s0,sp,32
    136c:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
    1370:	0ff0000f          	fence
    __sync_lock_release(lock);
    1374:	fe843783          	ld	a5,-24(s0)
    1378:	0f50000f          	fence	iorw,ow
    137c:	0807a02f          	amoswap.w	zero,zero,(a5)
   
}
    1380:	0001                	nop
    1382:	6462                	ld	s0,24(sp)
    1384:	6105                	addi	sp,sp,32
    1386:	8082                	ret

0000000000001388 <lock_init>:

void lock_init (lock_t *lock){
    1388:	1101                	addi	sp,sp,-32
    138a:	ec22                	sd	s0,24(sp)
    138c:	1000                	addi	s0,sp,32
    138e:	fea43423          	sd	a0,-24(s0)
    lock = 0;
    1392:	fe043423          	sd	zero,-24(s0)
    
}
    1396:	0001                	nop
    1398:	6462                	ld	s0,24(sp)
    139a:	6105                	addi	sp,sp,32
    139c:	8082                	ret

000000000000139e <cv_wait>:


void cv_wait (cont_t *cv, lock_t *lock){
    139e:	1101                	addi	sp,sp,-32
    13a0:	ec06                	sd	ra,24(sp)
    13a2:	e822                	sd	s0,16(sp)
    13a4:	1000                	addi	s0,sp,32
    13a6:	fea43423          	sd	a0,-24(s0)
    13aa:	feb43023          	sd	a1,-32(s0)
    while( __sync_lock_test_and_set(cv, 0)!=1){
    13ae:	a015                	j	13d2 <cv_wait+0x34>
        lock_release(lock);
    13b0:	fe043503          	ld	a0,-32(s0)
    13b4:	00000097          	auipc	ra,0x0
    13b8:	fb2080e7          	jalr	-78(ra) # 1366 <lock_release>
        sleep(1);
    13bc:	4505                	li	a0,1
    13be:	fffff097          	auipc	ra,0xfffff
    13c2:	6d2080e7          	jalr	1746(ra) # a90 <sleep>
        lock_acquire(lock);
    13c6:	fe043503          	ld	a0,-32(s0)
    13ca:	00000097          	auipc	ra,0x0
    13ce:	f74080e7          	jalr	-140(ra) # 133e <lock_acquire>
    while( __sync_lock_test_and_set(cv, 0)!=1){
    13d2:	fe843783          	ld	a5,-24(s0)
    13d6:	4701                	li	a4,0
    13d8:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    13dc:	0007079b          	sext.w	a5,a4
    13e0:	873e                	mv	a4,a5
    13e2:	4785                	li	a5,1
    13e4:	fcf716e3          	bne	a4,a5,13b0 <cv_wait+0x12>
    }

     __sync_synchronize();
    13e8:	0ff0000f          	fence

}
    13ec:	0001                	nop
    13ee:	60e2                	ld	ra,24(sp)
    13f0:	6442                	ld	s0,16(sp)
    13f2:	6105                	addi	sp,sp,32
    13f4:	8082                	ret

00000000000013f6 <cv_signal>:


void cv_signal (cont_t *cv){
    13f6:	1101                	addi	sp,sp,-32
    13f8:	ec22                	sd	s0,24(sp)
    13fa:	1000                	addi	s0,sp,32
    13fc:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
    1400:	0ff0000f          	fence
     __sync_lock_test_and_set(cv, 1);
    1404:	fe843783          	ld	a5,-24(s0)
    1408:	4705                	li	a4,1
    140a:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)

}
    140e:	0001                	nop
    1410:	6462                	ld	s0,24(sp)
    1412:	6105                	addi	sp,sp,32
    1414:	8082                	ret

0000000000001416 <cv_init>:


void cv_init (cont_t *cv){
    1416:	1101                	addi	sp,sp,-32
    1418:	ec22                	sd	s0,24(sp)
    141a:	1000                	addi	s0,sp,32
    141c:	fea43423          	sd	a0,-24(s0)
    cv = 0;
    1420:	fe043423          	sd	zero,-24(s0)
    1424:	0001                	nop
    1426:	6462                	ld	s0,24(sp)
    1428:	6105                	addi	sp,sp,32
    142a:	8082                	ret
