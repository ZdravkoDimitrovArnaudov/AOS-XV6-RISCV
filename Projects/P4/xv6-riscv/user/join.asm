
user/_join:     file format elf64-littleriscv


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
      16:	b72080e7          	jalr	-1166(ra) # b84 <getpid>
      1a:	87aa                	mv	a5,a0
      1c:	873e                	mv	a4,a5
      1e:	00001797          	auipc	a5,0x1
      22:	76a78793          	addi	a5,a5,1898 # 1788 <ppid>
      26:	c398                	sw	a4,0(a5)

   void *stack = malloc(PGSIZE*2);
      28:	6509                	lui	a0,0x2
      2a:	00001097          	auipc	ra,0x1
      2e:	204080e7          	jalr	516(ra) # 122e <malloc>
      32:	fea43423          	sd	a0,-24(s0)
   assert(stack != NULL);
      36:	fe843783          	ld	a5,-24(s0)
      3a:	e3b5                	bnez	a5,9e <main+0x9e>
      3c:	02000613          	li	a2,32
      40:	00001597          	auipc	a1,0x1
      44:	43858593          	addi	a1,a1,1080 # 1478 <lock_init+0x12>
      48:	00001517          	auipc	a0,0x1
      4c:	44050513          	addi	a0,a0,1088 # 1488 <lock_init+0x22>
      50:	00001097          	auipc	ra,0x1
      54:	fec080e7          	jalr	-20(ra) # 103c <printf>
      58:	00001597          	auipc	a1,0x1
      5c:	43858593          	addi	a1,a1,1080 # 1490 <lock_init+0x2a>
      60:	00001517          	auipc	a0,0x1
      64:	44050513          	addi	a0,a0,1088 # 14a0 <lock_init+0x3a>
      68:	00001097          	auipc	ra,0x1
      6c:	fd4080e7          	jalr	-44(ra) # 103c <printf>
      70:	00001517          	auipc	a0,0x1
      74:	44850513          	addi	a0,a0,1096 # 14b8 <lock_init+0x52>
      78:	00001097          	auipc	ra,0x1
      7c:	fc4080e7          	jalr	-60(ra) # 103c <printf>
      80:	00001797          	auipc	a5,0x1
      84:	70878793          	addi	a5,a5,1800 # 1788 <ppid>
      88:	439c                	lw	a5,0(a5)
      8a:	853e                	mv	a0,a5
      8c:	00001097          	auipc	ra,0x1
      90:	aa8080e7          	jalr	-1368(ra) # b34 <kill>
      94:	4501                	li	a0,0
      96:	00001097          	auipc	ra,0x1
      9a:	a6e080e7          	jalr	-1426(ra) # b04 <exit>
   if((uint64)stack % PGSIZE)
      9e:	fe843703          	ld	a4,-24(s0)
      a2:	6785                	lui	a5,0x1
      a4:	17fd                	addi	a5,a5,-1
      a6:	8ff9                	and	a5,a5,a4
      a8:	cf91                	beqz	a5,c4 <main+0xc4>
     stack = stack + (4096 - (uint64)stack % PGSIZE);
      aa:	fe843703          	ld	a4,-24(s0)
      ae:	6785                	lui	a5,0x1
      b0:	17fd                	addi	a5,a5,-1
      b2:	8ff9                	and	a5,a5,a4
      b4:	6705                	lui	a4,0x1
      b6:	40f707b3          	sub	a5,a4,a5
      ba:	fe843703          	ld	a4,-24(s0)
      be:	97ba                	add	a5,a5,a4
      c0:	fef43423          	sd	a5,-24(s0)

   stack_global = stack;
      c4:	00001797          	auipc	a5,0x1
      c8:	6cc78793          	addi	a5,a5,1740 # 1790 <stack_global>
      cc:	fe843703          	ld	a4,-24(s0)
      d0:	e398                	sd	a4,0(a5)

   int arg = 42;
      d2:	02a00793          	li	a5,42
      d6:	fcf42e23          	sw	a5,-36(s0)
   int clone_pid = clone(worker, &arg, stack);
      da:	fdc40793          	addi	a5,s0,-36
      de:	fe843603          	ld	a2,-24(s0)
      e2:	85be                	mv	a1,a5
      e4:	00000517          	auipc	a0,0x0
      e8:	23050513          	addi	a0,a0,560 # 314 <worker>
      ec:	00001097          	auipc	ra,0x1
      f0:	ab8080e7          	jalr	-1352(ra) # ba4 <clone>
      f4:	87aa                	mv	a5,a0
      f6:	fef42223          	sw	a5,-28(s0)
   assert(clone_pid > 0);
      fa:	fe442783          	lw	a5,-28(s0)
      fe:	2781                	sext.w	a5,a5
     100:	06f04363          	bgtz	a5,166 <main+0x166>
     104:	02800613          	li	a2,40
     108:	00001597          	auipc	a1,0x1
     10c:	37058593          	addi	a1,a1,880 # 1478 <lock_init+0x12>
     110:	00001517          	auipc	a0,0x1
     114:	37850513          	addi	a0,a0,888 # 1488 <lock_init+0x22>
     118:	00001097          	auipc	ra,0x1
     11c:	f24080e7          	jalr	-220(ra) # 103c <printf>
     120:	00001597          	auipc	a1,0x1
     124:	3a858593          	addi	a1,a1,936 # 14c8 <lock_init+0x62>
     128:	00001517          	auipc	a0,0x1
     12c:	37850513          	addi	a0,a0,888 # 14a0 <lock_init+0x3a>
     130:	00001097          	auipc	ra,0x1
     134:	f0c080e7          	jalr	-244(ra) # 103c <printf>
     138:	00001517          	auipc	a0,0x1
     13c:	38050513          	addi	a0,a0,896 # 14b8 <lock_init+0x52>
     140:	00001097          	auipc	ra,0x1
     144:	efc080e7          	jalr	-260(ra) # 103c <printf>
     148:	00001797          	auipc	a5,0x1
     14c:	64078793          	addi	a5,a5,1600 # 1788 <ppid>
     150:	439c                	lw	a5,0(a5)
     152:	853e                	mv	a0,a5
     154:	00001097          	auipc	ra,0x1
     158:	9e0080e7          	jalr	-1568(ra) # b34 <kill>
     15c:	4501                	li	a0,0
     15e:	00001097          	auipc	ra,0x1
     162:	9a6080e7          	jalr	-1626(ra) # b04 <exit>

   void *join_stack;
   int join_pid = join(&join_stack);
     166:	fd040793          	addi	a5,s0,-48
     16a:	853e                	mv	a0,a5
     16c:	00001097          	auipc	ra,0x1
     170:	a40080e7          	jalr	-1472(ra) # bac <join>
     174:	87aa                	mv	a5,a0
     176:	fef42023          	sw	a5,-32(s0)
   assert(join_pid == clone_pid);
     17a:	fe042783          	lw	a5,-32(s0)
     17e:	873e                	mv	a4,a5
     180:	fe442783          	lw	a5,-28(s0)
     184:	2701                	sext.w	a4,a4
     186:	2781                	sext.w	a5,a5
     188:	06f70363          	beq	a4,a5,1ee <main+0x1ee>
     18c:	02c00613          	li	a2,44
     190:	00001597          	auipc	a1,0x1
     194:	2e858593          	addi	a1,a1,744 # 1478 <lock_init+0x12>
     198:	00001517          	auipc	a0,0x1
     19c:	2f050513          	addi	a0,a0,752 # 1488 <lock_init+0x22>
     1a0:	00001097          	auipc	ra,0x1
     1a4:	e9c080e7          	jalr	-356(ra) # 103c <printf>
     1a8:	00001597          	auipc	a1,0x1
     1ac:	33058593          	addi	a1,a1,816 # 14d8 <lock_init+0x72>
     1b0:	00001517          	auipc	a0,0x1
     1b4:	2f050513          	addi	a0,a0,752 # 14a0 <lock_init+0x3a>
     1b8:	00001097          	auipc	ra,0x1
     1bc:	e84080e7          	jalr	-380(ra) # 103c <printf>
     1c0:	00001517          	auipc	a0,0x1
     1c4:	2f850513          	addi	a0,a0,760 # 14b8 <lock_init+0x52>
     1c8:	00001097          	auipc	ra,0x1
     1cc:	e74080e7          	jalr	-396(ra) # 103c <printf>
     1d0:	00001797          	auipc	a5,0x1
     1d4:	5b878793          	addi	a5,a5,1464 # 1788 <ppid>
     1d8:	439c                	lw	a5,0(a5)
     1da:	853e                	mv	a0,a5
     1dc:	00001097          	auipc	ra,0x1
     1e0:	958080e7          	jalr	-1704(ra) # b34 <kill>
     1e4:	4501                	li	a0,0
     1e6:	00001097          	auipc	ra,0x1
     1ea:	91e080e7          	jalr	-1762(ra) # b04 <exit>

                
   printf("stack %p\n", stack);
     1ee:	fe843583          	ld	a1,-24(s0)
     1f2:	00001517          	auipc	a0,0x1
     1f6:	2fe50513          	addi	a0,a0,766 # 14f0 <lock_init+0x8a>
     1fa:	00001097          	auipc	ra,0x1
     1fe:	e42080e7          	jalr	-446(ra) # 103c <printf>
   printf("Join stack %p\n", join_stack);
     202:	fd043783          	ld	a5,-48(s0)
     206:	85be                	mv	a1,a5
     208:	00001517          	auipc	a0,0x1
     20c:	2f850513          	addi	a0,a0,760 # 1500 <lock_init+0x9a>
     210:	00001097          	auipc	ra,0x1
     214:	e2c080e7          	jalr	-468(ra) # 103c <printf>
   assert(stack == join_stack);
     218:	fd043783          	ld	a5,-48(s0)
     21c:	fe843703          	ld	a4,-24(s0)
     220:	06f70363          	beq	a4,a5,286 <main+0x286>
     224:	03100613          	li	a2,49
     228:	00001597          	auipc	a1,0x1
     22c:	25058593          	addi	a1,a1,592 # 1478 <lock_init+0x12>
     230:	00001517          	auipc	a0,0x1
     234:	25850513          	addi	a0,a0,600 # 1488 <lock_init+0x22>
     238:	00001097          	auipc	ra,0x1
     23c:	e04080e7          	jalr	-508(ra) # 103c <printf>
     240:	00001597          	auipc	a1,0x1
     244:	2d058593          	addi	a1,a1,720 # 1510 <lock_init+0xaa>
     248:	00001517          	auipc	a0,0x1
     24c:	25850513          	addi	a0,a0,600 # 14a0 <lock_init+0x3a>
     250:	00001097          	auipc	ra,0x1
     254:	dec080e7          	jalr	-532(ra) # 103c <printf>
     258:	00001517          	auipc	a0,0x1
     25c:	26050513          	addi	a0,a0,608 # 14b8 <lock_init+0x52>
     260:	00001097          	auipc	ra,0x1
     264:	ddc080e7          	jalr	-548(ra) # 103c <printf>
     268:	00001797          	auipc	a5,0x1
     26c:	52078793          	addi	a5,a5,1312 # 1788 <ppid>
     270:	439c                	lw	a5,0(a5)
     272:	853e                	mv	a0,a5
     274:	00001097          	auipc	ra,0x1
     278:	8c0080e7          	jalr	-1856(ra) # b34 <kill>
     27c:	4501                	li	a0,0
     27e:	00001097          	auipc	ra,0x1
     282:	886080e7          	jalr	-1914(ra) # b04 <exit>
   assert(global == 2);
     286:	00001797          	auipc	a5,0x1
     28a:	4fe78793          	addi	a5,a5,1278 # 1784 <global>
     28e:	439c                	lw	a5,0(a5)
     290:	873e                	mv	a4,a5
     292:	4789                	li	a5,2
     294:	06f70363          	beq	a4,a5,2fa <main+0x2fa>
     298:	03200613          	li	a2,50
     29c:	00001597          	auipc	a1,0x1
     2a0:	1dc58593          	addi	a1,a1,476 # 1478 <lock_init+0x12>
     2a4:	00001517          	auipc	a0,0x1
     2a8:	1e450513          	addi	a0,a0,484 # 1488 <lock_init+0x22>
     2ac:	00001097          	auipc	ra,0x1
     2b0:	d90080e7          	jalr	-624(ra) # 103c <printf>
     2b4:	00001597          	auipc	a1,0x1
     2b8:	27458593          	addi	a1,a1,628 # 1528 <lock_init+0xc2>
     2bc:	00001517          	auipc	a0,0x1
     2c0:	1e450513          	addi	a0,a0,484 # 14a0 <lock_init+0x3a>
     2c4:	00001097          	auipc	ra,0x1
     2c8:	d78080e7          	jalr	-648(ra) # 103c <printf>
     2cc:	00001517          	auipc	a0,0x1
     2d0:	1ec50513          	addi	a0,a0,492 # 14b8 <lock_init+0x52>
     2d4:	00001097          	auipc	ra,0x1
     2d8:	d68080e7          	jalr	-664(ra) # 103c <printf>
     2dc:	00001797          	auipc	a5,0x1
     2e0:	4ac78793          	addi	a5,a5,1196 # 1788 <ppid>
     2e4:	439c                	lw	a5,0(a5)
     2e6:	853e                	mv	a0,a5
     2e8:	00001097          	auipc	ra,0x1
     2ec:	84c080e7          	jalr	-1972(ra) # b34 <kill>
     2f0:	4501                	li	a0,0
     2f2:	00001097          	auipc	ra,0x1
     2f6:	812080e7          	jalr	-2030(ra) # b04 <exit>

   printf("TEST PASSED\n");
     2fa:	00001517          	auipc	a0,0x1
     2fe:	23e50513          	addi	a0,a0,574 # 1538 <lock_init+0xd2>
     302:	00001097          	auipc	ra,0x1
     306:	d3a080e7          	jalr	-710(ra) # 103c <printf>
   exit(0);
     30a:	4501                	li	a0,0
     30c:	00000097          	auipc	ra,0x0
     310:	7f8080e7          	jalr	2040(ra) # b04 <exit>

0000000000000314 <worker>:
}

void
worker(void *arg_ptr) {
     314:	7179                	addi	sp,sp,-48
     316:	f406                	sd	ra,40(sp)
     318:	f022                	sd	s0,32(sp)
     31a:	1800                	addi	s0,sp,48
     31c:	fca43c23          	sd	a0,-40(s0)
   int arg = *(int*)arg_ptr;
     320:	fd843783          	ld	a5,-40(s0)
     324:	439c                	lw	a5,0(a5)
     326:	fef42623          	sw	a5,-20(s0)
   char *stack_top = (char *) (uint64)(stack_global + PGSIZE);
     32a:	00001797          	auipc	a5,0x1
     32e:	46678793          	addi	a5,a5,1126 # 1790 <stack_global>
     332:	6398                	ld	a4,0(a5)
     334:	6785                	lui	a5,0x1
     336:	97ba                	add	a5,a5,a4
     338:	fef43023          	sd	a5,-32(s0)

   printf ("TOP_USTACK: %x \n", *(stack_top));
     33c:	fe043783          	ld	a5,-32(s0)
     340:	0007c783          	lbu	a5,0(a5) # 1000 <fprintf+0x1c>
     344:	2781                	sext.w	a5,a5
     346:	85be                	mv	a1,a5
     348:	00001517          	auipc	a0,0x1
     34c:	20050513          	addi	a0,a0,512 # 1548 <lock_init+0xe2>
     350:	00001097          	auipc	ra,0x1
     354:	cec080e7          	jalr	-788(ra) # 103c <printf>
   printf ("TOP_USTACK-4: %x\n", *(stack_top - 4));
     358:	fe043783          	ld	a5,-32(s0)
     35c:	17f1                	addi	a5,a5,-4
     35e:	0007c783          	lbu	a5,0(a5)
     362:	2781                	sext.w	a5,a5
     364:	85be                	mv	a1,a5
     366:	00001517          	auipc	a0,0x1
     36a:	1fa50513          	addi	a0,a0,506 # 1560 <lock_init+0xfa>
     36e:	00001097          	auipc	ra,0x1
     372:	cce080e7          	jalr	-818(ra) # 103c <printf>
   printf ("TOP_USTACK-8: %x \n", *(stack_top - 8));
     376:	fe043783          	ld	a5,-32(s0)
     37a:	17e1                	addi	a5,a5,-8
     37c:	0007c783          	lbu	a5,0(a5)
     380:	2781                	sext.w	a5,a5
     382:	85be                	mv	a1,a5
     384:	00001517          	auipc	a0,0x1
     388:	1f450513          	addi	a0,a0,500 # 1578 <lock_init+0x112>
     38c:	00001097          	auipc	ra,0x1
     390:	cb0080e7          	jalr	-848(ra) # 103c <printf>
   printf ("TOP_USTACK-12: %x \n", *(stack_top - 12));
     394:	fe043783          	ld	a5,-32(s0)
     398:	17d1                	addi	a5,a5,-12
     39a:	0007c783          	lbu	a5,0(a5)
     39e:	2781                	sext.w	a5,a5
     3a0:	85be                	mv	a1,a5
     3a2:	00001517          	auipc	a0,0x1
     3a6:	1ee50513          	addi	a0,a0,494 # 1590 <lock_init+0x12a>
     3aa:	00001097          	auipc	ra,0x1
     3ae:	c92080e7          	jalr	-878(ra) # 103c <printf>
   printf ("TOP_USTACK-16: %x \n", *(stack_top - 16));
     3b2:	fe043783          	ld	a5,-32(s0)
     3b6:	17c1                	addi	a5,a5,-16
     3b8:	0007c783          	lbu	a5,0(a5)
     3bc:	2781                	sext.w	a5,a5
     3be:	85be                	mv	a1,a5
     3c0:	00001517          	auipc	a0,0x1
     3c4:	1e850513          	addi	a0,a0,488 # 15a8 <lock_init+0x142>
     3c8:	00001097          	auipc	ra,0x1
     3cc:	c74080e7          	jalr	-908(ra) # 103c <printf>
   printf ("TOP_USTACK-20: %x \n", *(stack_top - 20));
     3d0:	fe043783          	ld	a5,-32(s0)
     3d4:	17b1                	addi	a5,a5,-20
     3d6:	0007c783          	lbu	a5,0(a5)
     3da:	2781                	sext.w	a5,a5
     3dc:	85be                	mv	a1,a5
     3de:	00001517          	auipc	a0,0x1
     3e2:	1e250513          	addi	a0,a0,482 # 15c0 <lock_init+0x15a>
     3e6:	00001097          	auipc	ra,0x1
     3ea:	c56080e7          	jalr	-938(ra) # 103c <printf>
   printf ("TOP_USTACK-24: %x \n", *(stack_top - 24));
     3ee:	fe043783          	ld	a5,-32(s0)
     3f2:	17a1                	addi	a5,a5,-24
     3f4:	0007c783          	lbu	a5,0(a5)
     3f8:	2781                	sext.w	a5,a5
     3fa:	85be                	mv	a1,a5
     3fc:	00001517          	auipc	a0,0x1
     400:	1dc50513          	addi	a0,a0,476 # 15d8 <lock_init+0x172>
     404:	00001097          	auipc	ra,0x1
     408:	c38080e7          	jalr	-968(ra) # 103c <printf>
   printf ("TOP_USTACK-28: %x \n", *(stack_top - 28));
     40c:	fe043783          	ld	a5,-32(s0)
     410:	1791                	addi	a5,a5,-28
     412:	0007c783          	lbu	a5,0(a5)
     416:	2781                	sext.w	a5,a5
     418:	85be                	mv	a1,a5
     41a:	00001517          	auipc	a0,0x1
     41e:	1d650513          	addi	a0,a0,470 # 15f0 <lock_init+0x18a>
     422:	00001097          	auipc	ra,0x1
     426:	c1a080e7          	jalr	-998(ra) # 103c <printf>
   printf ("TOP_USTACK-32: %x \n", *(stack_top - 32));
     42a:	fe043783          	ld	a5,-32(s0)
     42e:	1781                	addi	a5,a5,-32
     430:	0007c783          	lbu	a5,0(a5)
     434:	2781                	sext.w	a5,a5
     436:	85be                	mv	a1,a5
     438:	00001517          	auipc	a0,0x1
     43c:	1d050513          	addi	a0,a0,464 # 1608 <lock_init+0x1a2>
     440:	00001097          	auipc	ra,0x1
     444:	bfc080e7          	jalr	-1028(ra) # 103c <printf>
   printf ("TOP_USTACK-36: %x \n", *(stack_top - 36));
     448:	fe043783          	ld	a5,-32(s0)
     44c:	fdc78793          	addi	a5,a5,-36
     450:	0007c783          	lbu	a5,0(a5)
     454:	2781                	sext.w	a5,a5
     456:	85be                	mv	a1,a5
     458:	00001517          	auipc	a0,0x1
     45c:	1c850513          	addi	a0,a0,456 # 1620 <lock_init+0x1ba>
     460:	00001097          	auipc	ra,0x1
     464:	bdc080e7          	jalr	-1060(ra) # 103c <printf>
   printf ("TOP_USTACK-40: %x \n", *(stack_top - 40));
     468:	fe043783          	ld	a5,-32(s0)
     46c:	fd878793          	addi	a5,a5,-40
     470:	0007c783          	lbu	a5,0(a5)
     474:	2781                	sext.w	a5,a5
     476:	85be                	mv	a1,a5
     478:	00001517          	auipc	a0,0x1
     47c:	1c050513          	addi	a0,a0,448 # 1638 <lock_init+0x1d2>
     480:	00001097          	auipc	ra,0x1
     484:	bbc080e7          	jalr	-1092(ra) # 103c <printf>
   printf ("TOP_USTACK-44: %x \n", *(stack_top - 44));
     488:	fe043783          	ld	a5,-32(s0)
     48c:	fd478793          	addi	a5,a5,-44
     490:	0007c783          	lbu	a5,0(a5)
     494:	2781                	sext.w	a5,a5
     496:	85be                	mv	a1,a5
     498:	00001517          	auipc	a0,0x1
     49c:	1b850513          	addi	a0,a0,440 # 1650 <lock_init+0x1ea>
     4a0:	00001097          	auipc	ra,0x1
     4a4:	b9c080e7          	jalr	-1124(ra) # 103c <printf>
   printf ("TOP_USTACK-48: %x \n", *(stack_top - 48));
     4a8:	fe043783          	ld	a5,-32(s0)
     4ac:	fd078793          	addi	a5,a5,-48
     4b0:	0007c783          	lbu	a5,0(a5)
     4b4:	2781                	sext.w	a5,a5
     4b6:	85be                	mv	a1,a5
     4b8:	00001517          	auipc	a0,0x1
     4bc:	1b050513          	addi	a0,a0,432 # 1668 <lock_init+0x202>
     4c0:	00001097          	auipc	ra,0x1
     4c4:	b7c080e7          	jalr	-1156(ra) # 103c <printf>
   printf ("TOP_USTACK-52: %x \n", *(stack_top - 52));
     4c8:	fe043783          	ld	a5,-32(s0)
     4cc:	fcc78793          	addi	a5,a5,-52
     4d0:	0007c783          	lbu	a5,0(a5)
     4d4:	2781                	sext.w	a5,a5
     4d6:	85be                	mv	a1,a5
     4d8:	00001517          	auipc	a0,0x1
     4dc:	1a850513          	addi	a0,a0,424 # 1680 <lock_init+0x21a>
     4e0:	00001097          	auipc	ra,0x1
     4e4:	b5c080e7          	jalr	-1188(ra) # 103c <printf>
   printf ("TOP_USTACK-56: %x \n", *(stack_top - 56));
     4e8:	fe043783          	ld	a5,-32(s0)
     4ec:	fc878793          	addi	a5,a5,-56
     4f0:	0007c783          	lbu	a5,0(a5)
     4f4:	2781                	sext.w	a5,a5
     4f6:	85be                	mv	a1,a5
     4f8:	00001517          	auipc	a0,0x1
     4fc:	1a050513          	addi	a0,a0,416 # 1698 <lock_init+0x232>
     500:	00001097          	auipc	ra,0x1
     504:	b3c080e7          	jalr	-1220(ra) # 103c <printf>
   printf ("TOP_USTACK-60: %x \n", *(stack_top - 60));
     508:	fe043783          	ld	a5,-32(s0)
     50c:	fc478793          	addi	a5,a5,-60
     510:	0007c783          	lbu	a5,0(a5)
     514:	2781                	sext.w	a5,a5
     516:	85be                	mv	a1,a5
     518:	00001517          	auipc	a0,0x1
     51c:	19850513          	addi	a0,a0,408 # 16b0 <lock_init+0x24a>
     520:	00001097          	auipc	ra,0x1
     524:	b1c080e7          	jalr	-1252(ra) # 103c <printf>
   printf ("TOP_USTACK-64: %x \n", *(stack_top - 64));
     528:	fe043783          	ld	a5,-32(s0)
     52c:	fc078793          	addi	a5,a5,-64
     530:	0007c783          	lbu	a5,0(a5)
     534:	2781                	sext.w	a5,a5
     536:	85be                	mv	a1,a5
     538:	00001517          	auipc	a0,0x1
     53c:	19050513          	addi	a0,a0,400 # 16c8 <lock_init+0x262>
     540:	00001097          	auipc	ra,0x1
     544:	afc080e7          	jalr	-1284(ra) # 103c <printf>
   printf ("TOP_USTACK-68: %x \n", *(stack_top - 68));
     548:	fe043783          	ld	a5,-32(s0)
     54c:	fbc78793          	addi	a5,a5,-68
     550:	0007c783          	lbu	a5,0(a5)
     554:	2781                	sext.w	a5,a5
     556:	85be                	mv	a1,a5
     558:	00001517          	auipc	a0,0x1
     55c:	18850513          	addi	a0,a0,392 # 16e0 <lock_init+0x27a>
     560:	00001097          	auipc	ra,0x1
     564:	adc080e7          	jalr	-1316(ra) # 103c <printf>

   assert(arg == 42);
     568:	fec42783          	lw	a5,-20(s0)
     56c:	0007871b          	sext.w	a4,a5
     570:	02a00793          	li	a5,42
     574:	06f70363          	beq	a4,a5,5da <worker+0x2c6>
     578:	05000613          	li	a2,80
     57c:	00001597          	auipc	a1,0x1
     580:	efc58593          	addi	a1,a1,-260 # 1478 <lock_init+0x12>
     584:	00001517          	auipc	a0,0x1
     588:	f0450513          	addi	a0,a0,-252 # 1488 <lock_init+0x22>
     58c:	00001097          	auipc	ra,0x1
     590:	ab0080e7          	jalr	-1360(ra) # 103c <printf>
     594:	00001597          	auipc	a1,0x1
     598:	16458593          	addi	a1,a1,356 # 16f8 <lock_init+0x292>
     59c:	00001517          	auipc	a0,0x1
     5a0:	f0450513          	addi	a0,a0,-252 # 14a0 <lock_init+0x3a>
     5a4:	00001097          	auipc	ra,0x1
     5a8:	a98080e7          	jalr	-1384(ra) # 103c <printf>
     5ac:	00001517          	auipc	a0,0x1
     5b0:	f0c50513          	addi	a0,a0,-244 # 14b8 <lock_init+0x52>
     5b4:	00001097          	auipc	ra,0x1
     5b8:	a88080e7          	jalr	-1400(ra) # 103c <printf>
     5bc:	00001797          	auipc	a5,0x1
     5c0:	1cc78793          	addi	a5,a5,460 # 1788 <ppid>
     5c4:	439c                	lw	a5,0(a5)
     5c6:	853e                	mv	a0,a5
     5c8:	00000097          	auipc	ra,0x0
     5cc:	56c080e7          	jalr	1388(ra) # b34 <kill>
     5d0:	4501                	li	a0,0
     5d2:	00000097          	auipc	ra,0x0
     5d6:	532080e7          	jalr	1330(ra) # b04 <exit>
   assert(global == 1);
     5da:	00001797          	auipc	a5,0x1
     5de:	1aa78793          	addi	a5,a5,426 # 1784 <global>
     5e2:	439c                	lw	a5,0(a5)
     5e4:	873e                	mv	a4,a5
     5e6:	4785                	li	a5,1
     5e8:	06f70363          	beq	a4,a5,64e <worker+0x33a>
     5ec:	05100613          	li	a2,81
     5f0:	00001597          	auipc	a1,0x1
     5f4:	e8858593          	addi	a1,a1,-376 # 1478 <lock_init+0x12>
     5f8:	00001517          	auipc	a0,0x1
     5fc:	e9050513          	addi	a0,a0,-368 # 1488 <lock_init+0x22>
     600:	00001097          	auipc	ra,0x1
     604:	a3c080e7          	jalr	-1476(ra) # 103c <printf>
     608:	00001597          	auipc	a1,0x1
     60c:	10058593          	addi	a1,a1,256 # 1708 <lock_init+0x2a2>
     610:	00001517          	auipc	a0,0x1
     614:	e9050513          	addi	a0,a0,-368 # 14a0 <lock_init+0x3a>
     618:	00001097          	auipc	ra,0x1
     61c:	a24080e7          	jalr	-1500(ra) # 103c <printf>
     620:	00001517          	auipc	a0,0x1
     624:	e9850513          	addi	a0,a0,-360 # 14b8 <lock_init+0x52>
     628:	00001097          	auipc	ra,0x1
     62c:	a14080e7          	jalr	-1516(ra) # 103c <printf>
     630:	00001797          	auipc	a5,0x1
     634:	15878793          	addi	a5,a5,344 # 1788 <ppid>
     638:	439c                	lw	a5,0(a5)
     63a:	853e                	mv	a0,a5
     63c:	00000097          	auipc	ra,0x0
     640:	4f8080e7          	jalr	1272(ra) # b34 <kill>
     644:	4501                	li	a0,0
     646:	00000097          	auipc	ra,0x0
     64a:	4be080e7          	jalr	1214(ra) # b04 <exit>
   global++;
     64e:	00001797          	auipc	a5,0x1
     652:	13678793          	addi	a5,a5,310 # 1784 <global>
     656:	439c                	lw	a5,0(a5)
     658:	2785                	addiw	a5,a5,1
     65a:	0007871b          	sext.w	a4,a5
     65e:	00001797          	auipc	a5,0x1
     662:	12678793          	addi	a5,a5,294 # 1784 <global>
     666:	c398                	sw	a4,0(a5)
   exit(0);
     668:	4501                	li	a0,0
     66a:	00000097          	auipc	ra,0x0
     66e:	49a080e7          	jalr	1178(ra) # b04 <exit>

0000000000000672 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     672:	7179                	addi	sp,sp,-48
     674:	f422                	sd	s0,40(sp)
     676:	1800                	addi	s0,sp,48
     678:	fca43c23          	sd	a0,-40(s0)
     67c:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     680:	fd843783          	ld	a5,-40(s0)
     684:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     688:	0001                	nop
     68a:	fd043703          	ld	a4,-48(s0)
     68e:	00170793          	addi	a5,a4,1 # 1001 <fprintf+0x1d>
     692:	fcf43823          	sd	a5,-48(s0)
     696:	fd843783          	ld	a5,-40(s0)
     69a:	00178693          	addi	a3,a5,1
     69e:	fcd43c23          	sd	a3,-40(s0)
     6a2:	00074703          	lbu	a4,0(a4)
     6a6:	00e78023          	sb	a4,0(a5)
     6aa:	0007c783          	lbu	a5,0(a5)
     6ae:	fff1                	bnez	a5,68a <strcpy+0x18>
    ;
  return os;
     6b0:	fe843783          	ld	a5,-24(s0)
}
     6b4:	853e                	mv	a0,a5
     6b6:	7422                	ld	s0,40(sp)
     6b8:	6145                	addi	sp,sp,48
     6ba:	8082                	ret

00000000000006bc <strcmp>:

int
strcmp(const char *p, const char *q)
{
     6bc:	1101                	addi	sp,sp,-32
     6be:	ec22                	sd	s0,24(sp)
     6c0:	1000                	addi	s0,sp,32
     6c2:	fea43423          	sd	a0,-24(s0)
     6c6:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     6ca:	a819                	j	6e0 <strcmp+0x24>
    p++, q++;
     6cc:	fe843783          	ld	a5,-24(s0)
     6d0:	0785                	addi	a5,a5,1
     6d2:	fef43423          	sd	a5,-24(s0)
     6d6:	fe043783          	ld	a5,-32(s0)
     6da:	0785                	addi	a5,a5,1
     6dc:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     6e0:	fe843783          	ld	a5,-24(s0)
     6e4:	0007c783          	lbu	a5,0(a5)
     6e8:	cb99                	beqz	a5,6fe <strcmp+0x42>
     6ea:	fe843783          	ld	a5,-24(s0)
     6ee:	0007c703          	lbu	a4,0(a5)
     6f2:	fe043783          	ld	a5,-32(s0)
     6f6:	0007c783          	lbu	a5,0(a5)
     6fa:	fcf709e3          	beq	a4,a5,6cc <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     6fe:	fe843783          	ld	a5,-24(s0)
     702:	0007c783          	lbu	a5,0(a5)
     706:	0007871b          	sext.w	a4,a5
     70a:	fe043783          	ld	a5,-32(s0)
     70e:	0007c783          	lbu	a5,0(a5)
     712:	2781                	sext.w	a5,a5
     714:	40f707bb          	subw	a5,a4,a5
     718:	2781                	sext.w	a5,a5
}
     71a:	853e                	mv	a0,a5
     71c:	6462                	ld	s0,24(sp)
     71e:	6105                	addi	sp,sp,32
     720:	8082                	ret

0000000000000722 <strlen>:

uint
strlen(const char *s)
{
     722:	7179                	addi	sp,sp,-48
     724:	f422                	sd	s0,40(sp)
     726:	1800                	addi	s0,sp,48
     728:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     72c:	fe042623          	sw	zero,-20(s0)
     730:	a031                	j	73c <strlen+0x1a>
     732:	fec42783          	lw	a5,-20(s0)
     736:	2785                	addiw	a5,a5,1
     738:	fef42623          	sw	a5,-20(s0)
     73c:	fec42783          	lw	a5,-20(s0)
     740:	fd843703          	ld	a4,-40(s0)
     744:	97ba                	add	a5,a5,a4
     746:	0007c783          	lbu	a5,0(a5)
     74a:	f7e5                	bnez	a5,732 <strlen+0x10>
    ;
  return n;
     74c:	fec42783          	lw	a5,-20(s0)
}
     750:	853e                	mv	a0,a5
     752:	7422                	ld	s0,40(sp)
     754:	6145                	addi	sp,sp,48
     756:	8082                	ret

0000000000000758 <memset>:

void*
memset(void *dst, int c, uint n)
{
     758:	7179                	addi	sp,sp,-48
     75a:	f422                	sd	s0,40(sp)
     75c:	1800                	addi	s0,sp,48
     75e:	fca43c23          	sd	a0,-40(s0)
     762:	87ae                	mv	a5,a1
     764:	8732                	mv	a4,a2
     766:	fcf42a23          	sw	a5,-44(s0)
     76a:	87ba                	mv	a5,a4
     76c:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     770:	fd843783          	ld	a5,-40(s0)
     774:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     778:	fe042623          	sw	zero,-20(s0)
     77c:	a00d                	j	79e <memset+0x46>
    cdst[i] = c;
     77e:	fec42783          	lw	a5,-20(s0)
     782:	fe043703          	ld	a4,-32(s0)
     786:	97ba                	add	a5,a5,a4
     788:	fd442703          	lw	a4,-44(s0)
     78c:	0ff77713          	zext.b	a4,a4
     790:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     794:	fec42783          	lw	a5,-20(s0)
     798:	2785                	addiw	a5,a5,1
     79a:	fef42623          	sw	a5,-20(s0)
     79e:	fec42703          	lw	a4,-20(s0)
     7a2:	fd042783          	lw	a5,-48(s0)
     7a6:	2781                	sext.w	a5,a5
     7a8:	fcf76be3          	bltu	a4,a5,77e <memset+0x26>
  }
  return dst;
     7ac:	fd843783          	ld	a5,-40(s0)
}
     7b0:	853e                	mv	a0,a5
     7b2:	7422                	ld	s0,40(sp)
     7b4:	6145                	addi	sp,sp,48
     7b6:	8082                	ret

00000000000007b8 <strchr>:

char*
strchr(const char *s, char c)
{
     7b8:	1101                	addi	sp,sp,-32
     7ba:	ec22                	sd	s0,24(sp)
     7bc:	1000                	addi	s0,sp,32
     7be:	fea43423          	sd	a0,-24(s0)
     7c2:	87ae                	mv	a5,a1
     7c4:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     7c8:	a01d                	j	7ee <strchr+0x36>
    if(*s == c)
     7ca:	fe843783          	ld	a5,-24(s0)
     7ce:	0007c703          	lbu	a4,0(a5)
     7d2:	fe744783          	lbu	a5,-25(s0)
     7d6:	0ff7f793          	zext.b	a5,a5
     7da:	00e79563          	bne	a5,a4,7e4 <strchr+0x2c>
      return (char*)s;
     7de:	fe843783          	ld	a5,-24(s0)
     7e2:	a821                	j	7fa <strchr+0x42>
  for(; *s; s++)
     7e4:	fe843783          	ld	a5,-24(s0)
     7e8:	0785                	addi	a5,a5,1
     7ea:	fef43423          	sd	a5,-24(s0)
     7ee:	fe843783          	ld	a5,-24(s0)
     7f2:	0007c783          	lbu	a5,0(a5)
     7f6:	fbf1                	bnez	a5,7ca <strchr+0x12>
  return 0;
     7f8:	4781                	li	a5,0
}
     7fa:	853e                	mv	a0,a5
     7fc:	6462                	ld	s0,24(sp)
     7fe:	6105                	addi	sp,sp,32
     800:	8082                	ret

0000000000000802 <gets>:

char*
gets(char *buf, int max)
{
     802:	7179                	addi	sp,sp,-48
     804:	f406                	sd	ra,40(sp)
     806:	f022                	sd	s0,32(sp)
     808:	1800                	addi	s0,sp,48
     80a:	fca43c23          	sd	a0,-40(s0)
     80e:	87ae                	mv	a5,a1
     810:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     814:	fe042623          	sw	zero,-20(s0)
     818:	a8a1                	j	870 <gets+0x6e>
    cc = read(0, &c, 1);
     81a:	fe740793          	addi	a5,s0,-25
     81e:	4605                	li	a2,1
     820:	85be                	mv	a1,a5
     822:	4501                	li	a0,0
     824:	00000097          	auipc	ra,0x0
     828:	2f8080e7          	jalr	760(ra) # b1c <read>
     82c:	87aa                	mv	a5,a0
     82e:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     832:	fe842783          	lw	a5,-24(s0)
     836:	2781                	sext.w	a5,a5
     838:	04f05763          	blez	a5,886 <gets+0x84>
      break;
    buf[i++] = c;
     83c:	fec42783          	lw	a5,-20(s0)
     840:	0017871b          	addiw	a4,a5,1
     844:	fee42623          	sw	a4,-20(s0)
     848:	873e                	mv	a4,a5
     84a:	fd843783          	ld	a5,-40(s0)
     84e:	97ba                	add	a5,a5,a4
     850:	fe744703          	lbu	a4,-25(s0)
     854:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     858:	fe744783          	lbu	a5,-25(s0)
     85c:	873e                	mv	a4,a5
     85e:	47a9                	li	a5,10
     860:	02f70463          	beq	a4,a5,888 <gets+0x86>
     864:	fe744783          	lbu	a5,-25(s0)
     868:	873e                	mv	a4,a5
     86a:	47b5                	li	a5,13
     86c:	00f70e63          	beq	a4,a5,888 <gets+0x86>
  for(i=0; i+1 < max; ){
     870:	fec42783          	lw	a5,-20(s0)
     874:	2785                	addiw	a5,a5,1
     876:	0007871b          	sext.w	a4,a5
     87a:	fd442783          	lw	a5,-44(s0)
     87e:	2781                	sext.w	a5,a5
     880:	f8f74de3          	blt	a4,a5,81a <gets+0x18>
     884:	a011                	j	888 <gets+0x86>
      break;
     886:	0001                	nop
      break;
  }
  buf[i] = '\0';
     888:	fec42783          	lw	a5,-20(s0)
     88c:	fd843703          	ld	a4,-40(s0)
     890:	97ba                	add	a5,a5,a4
     892:	00078023          	sb	zero,0(a5)
  return buf;
     896:	fd843783          	ld	a5,-40(s0)
}
     89a:	853e                	mv	a0,a5
     89c:	70a2                	ld	ra,40(sp)
     89e:	7402                	ld	s0,32(sp)
     8a0:	6145                	addi	sp,sp,48
     8a2:	8082                	ret

00000000000008a4 <stat>:

int
stat(const char *n, struct stat *st)
{
     8a4:	7179                	addi	sp,sp,-48
     8a6:	f406                	sd	ra,40(sp)
     8a8:	f022                	sd	s0,32(sp)
     8aa:	1800                	addi	s0,sp,48
     8ac:	fca43c23          	sd	a0,-40(s0)
     8b0:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     8b4:	4581                	li	a1,0
     8b6:	fd843503          	ld	a0,-40(s0)
     8ba:	00000097          	auipc	ra,0x0
     8be:	28a080e7          	jalr	650(ra) # b44 <open>
     8c2:	87aa                	mv	a5,a0
     8c4:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     8c8:	fec42783          	lw	a5,-20(s0)
     8cc:	2781                	sext.w	a5,a5
     8ce:	0007d463          	bgez	a5,8d6 <stat+0x32>
    return -1;
     8d2:	57fd                	li	a5,-1
     8d4:	a035                	j	900 <stat+0x5c>
  r = fstat(fd, st);
     8d6:	fec42783          	lw	a5,-20(s0)
     8da:	fd043583          	ld	a1,-48(s0)
     8de:	853e                	mv	a0,a5
     8e0:	00000097          	auipc	ra,0x0
     8e4:	27c080e7          	jalr	636(ra) # b5c <fstat>
     8e8:	87aa                	mv	a5,a0
     8ea:	fef42423          	sw	a5,-24(s0)
  close(fd);
     8ee:	fec42783          	lw	a5,-20(s0)
     8f2:	853e                	mv	a0,a5
     8f4:	00000097          	auipc	ra,0x0
     8f8:	238080e7          	jalr	568(ra) # b2c <close>
  return r;
     8fc:	fe842783          	lw	a5,-24(s0)
}
     900:	853e                	mv	a0,a5
     902:	70a2                	ld	ra,40(sp)
     904:	7402                	ld	s0,32(sp)
     906:	6145                	addi	sp,sp,48
     908:	8082                	ret

000000000000090a <atoi>:

int
atoi(const char *s)
{
     90a:	7179                	addi	sp,sp,-48
     90c:	f422                	sd	s0,40(sp)
     90e:	1800                	addi	s0,sp,48
     910:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     914:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     918:	a81d                	j	94e <atoi+0x44>
    n = n*10 + *s++ - '0';
     91a:	fec42783          	lw	a5,-20(s0)
     91e:	873e                	mv	a4,a5
     920:	87ba                	mv	a5,a4
     922:	0027979b          	slliw	a5,a5,0x2
     926:	9fb9                	addw	a5,a5,a4
     928:	0017979b          	slliw	a5,a5,0x1
     92c:	0007871b          	sext.w	a4,a5
     930:	fd843783          	ld	a5,-40(s0)
     934:	00178693          	addi	a3,a5,1
     938:	fcd43c23          	sd	a3,-40(s0)
     93c:	0007c783          	lbu	a5,0(a5)
     940:	2781                	sext.w	a5,a5
     942:	9fb9                	addw	a5,a5,a4
     944:	2781                	sext.w	a5,a5
     946:	fd07879b          	addiw	a5,a5,-48
     94a:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     94e:	fd843783          	ld	a5,-40(s0)
     952:	0007c783          	lbu	a5,0(a5)
     956:	873e                	mv	a4,a5
     958:	02f00793          	li	a5,47
     95c:	00e7fb63          	bgeu	a5,a4,972 <atoi+0x68>
     960:	fd843783          	ld	a5,-40(s0)
     964:	0007c783          	lbu	a5,0(a5)
     968:	873e                	mv	a4,a5
     96a:	03900793          	li	a5,57
     96e:	fae7f6e3          	bgeu	a5,a4,91a <atoi+0x10>
  return n;
     972:	fec42783          	lw	a5,-20(s0)
}
     976:	853e                	mv	a0,a5
     978:	7422                	ld	s0,40(sp)
     97a:	6145                	addi	sp,sp,48
     97c:	8082                	ret

000000000000097e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     97e:	7139                	addi	sp,sp,-64
     980:	fc22                	sd	s0,56(sp)
     982:	0080                	addi	s0,sp,64
     984:	fca43c23          	sd	a0,-40(s0)
     988:	fcb43823          	sd	a1,-48(s0)
     98c:	87b2                	mv	a5,a2
     98e:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     992:	fd843783          	ld	a5,-40(s0)
     996:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     99a:	fd043783          	ld	a5,-48(s0)
     99e:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     9a2:	fe043703          	ld	a4,-32(s0)
     9a6:	fe843783          	ld	a5,-24(s0)
     9aa:	02e7fc63          	bgeu	a5,a4,9e2 <memmove+0x64>
    while(n-- > 0)
     9ae:	a00d                	j	9d0 <memmove+0x52>
      *dst++ = *src++;
     9b0:	fe043703          	ld	a4,-32(s0)
     9b4:	00170793          	addi	a5,a4,1
     9b8:	fef43023          	sd	a5,-32(s0)
     9bc:	fe843783          	ld	a5,-24(s0)
     9c0:	00178693          	addi	a3,a5,1
     9c4:	fed43423          	sd	a3,-24(s0)
     9c8:	00074703          	lbu	a4,0(a4)
     9cc:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     9d0:	fcc42783          	lw	a5,-52(s0)
     9d4:	fff7871b          	addiw	a4,a5,-1
     9d8:	fce42623          	sw	a4,-52(s0)
     9dc:	fcf04ae3          	bgtz	a5,9b0 <memmove+0x32>
     9e0:	a891                	j	a34 <memmove+0xb6>
  } else {
    dst += n;
     9e2:	fcc42783          	lw	a5,-52(s0)
     9e6:	fe843703          	ld	a4,-24(s0)
     9ea:	97ba                	add	a5,a5,a4
     9ec:	fef43423          	sd	a5,-24(s0)
    src += n;
     9f0:	fcc42783          	lw	a5,-52(s0)
     9f4:	fe043703          	ld	a4,-32(s0)
     9f8:	97ba                	add	a5,a5,a4
     9fa:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     9fe:	a01d                	j	a24 <memmove+0xa6>
      *--dst = *--src;
     a00:	fe043783          	ld	a5,-32(s0)
     a04:	17fd                	addi	a5,a5,-1
     a06:	fef43023          	sd	a5,-32(s0)
     a0a:	fe843783          	ld	a5,-24(s0)
     a0e:	17fd                	addi	a5,a5,-1
     a10:	fef43423          	sd	a5,-24(s0)
     a14:	fe043783          	ld	a5,-32(s0)
     a18:	0007c703          	lbu	a4,0(a5)
     a1c:	fe843783          	ld	a5,-24(s0)
     a20:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     a24:	fcc42783          	lw	a5,-52(s0)
     a28:	fff7871b          	addiw	a4,a5,-1
     a2c:	fce42623          	sw	a4,-52(s0)
     a30:	fcf048e3          	bgtz	a5,a00 <memmove+0x82>
  }
  return vdst;
     a34:	fd843783          	ld	a5,-40(s0)
}
     a38:	853e                	mv	a0,a5
     a3a:	7462                	ld	s0,56(sp)
     a3c:	6121                	addi	sp,sp,64
     a3e:	8082                	ret

0000000000000a40 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     a40:	7139                	addi	sp,sp,-64
     a42:	fc22                	sd	s0,56(sp)
     a44:	0080                	addi	s0,sp,64
     a46:	fca43c23          	sd	a0,-40(s0)
     a4a:	fcb43823          	sd	a1,-48(s0)
     a4e:	87b2                	mv	a5,a2
     a50:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     a54:	fd843783          	ld	a5,-40(s0)
     a58:	fef43423          	sd	a5,-24(s0)
     a5c:	fd043783          	ld	a5,-48(s0)
     a60:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     a64:	a0a1                	j	aac <memcmp+0x6c>
    if (*p1 != *p2) {
     a66:	fe843783          	ld	a5,-24(s0)
     a6a:	0007c703          	lbu	a4,0(a5)
     a6e:	fe043783          	ld	a5,-32(s0)
     a72:	0007c783          	lbu	a5,0(a5)
     a76:	02f70163          	beq	a4,a5,a98 <memcmp+0x58>
      return *p1 - *p2;
     a7a:	fe843783          	ld	a5,-24(s0)
     a7e:	0007c783          	lbu	a5,0(a5)
     a82:	0007871b          	sext.w	a4,a5
     a86:	fe043783          	ld	a5,-32(s0)
     a8a:	0007c783          	lbu	a5,0(a5)
     a8e:	2781                	sext.w	a5,a5
     a90:	40f707bb          	subw	a5,a4,a5
     a94:	2781                	sext.w	a5,a5
     a96:	a01d                	j	abc <memcmp+0x7c>
    }
    p1++;
     a98:	fe843783          	ld	a5,-24(s0)
     a9c:	0785                	addi	a5,a5,1
     a9e:	fef43423          	sd	a5,-24(s0)
    p2++;
     aa2:	fe043783          	ld	a5,-32(s0)
     aa6:	0785                	addi	a5,a5,1
     aa8:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     aac:	fcc42783          	lw	a5,-52(s0)
     ab0:	fff7871b          	addiw	a4,a5,-1
     ab4:	fce42623          	sw	a4,-52(s0)
     ab8:	f7dd                	bnez	a5,a66 <memcmp+0x26>
  }
  return 0;
     aba:	4781                	li	a5,0
}
     abc:	853e                	mv	a0,a5
     abe:	7462                	ld	s0,56(sp)
     ac0:	6121                	addi	sp,sp,64
     ac2:	8082                	ret

0000000000000ac4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     ac4:	7179                	addi	sp,sp,-48
     ac6:	f406                	sd	ra,40(sp)
     ac8:	f022                	sd	s0,32(sp)
     aca:	1800                	addi	s0,sp,48
     acc:	fea43423          	sd	a0,-24(s0)
     ad0:	feb43023          	sd	a1,-32(s0)
     ad4:	87b2                	mv	a5,a2
     ad6:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     ada:	fdc42783          	lw	a5,-36(s0)
     ade:	863e                	mv	a2,a5
     ae0:	fe043583          	ld	a1,-32(s0)
     ae4:	fe843503          	ld	a0,-24(s0)
     ae8:	00000097          	auipc	ra,0x0
     aec:	e96080e7          	jalr	-362(ra) # 97e <memmove>
     af0:	87aa                	mv	a5,a0
}
     af2:	853e                	mv	a0,a5
     af4:	70a2                	ld	ra,40(sp)
     af6:	7402                	ld	s0,32(sp)
     af8:	6145                	addi	sp,sp,48
     afa:	8082                	ret

0000000000000afc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     afc:	4885                	li	a7,1
 ecall
     afe:	00000073          	ecall
 ret
     b02:	8082                	ret

0000000000000b04 <exit>:
.global exit
exit:
 li a7, SYS_exit
     b04:	4889                	li	a7,2
 ecall
     b06:	00000073          	ecall
 ret
     b0a:	8082                	ret

0000000000000b0c <wait>:
.global wait
wait:
 li a7, SYS_wait
     b0c:	488d                	li	a7,3
 ecall
     b0e:	00000073          	ecall
 ret
     b12:	8082                	ret

0000000000000b14 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     b14:	4891                	li	a7,4
 ecall
     b16:	00000073          	ecall
 ret
     b1a:	8082                	ret

0000000000000b1c <read>:
.global read
read:
 li a7, SYS_read
     b1c:	4895                	li	a7,5
 ecall
     b1e:	00000073          	ecall
 ret
     b22:	8082                	ret

0000000000000b24 <write>:
.global write
write:
 li a7, SYS_write
     b24:	48c1                	li	a7,16
 ecall
     b26:	00000073          	ecall
 ret
     b2a:	8082                	ret

0000000000000b2c <close>:
.global close
close:
 li a7, SYS_close
     b2c:	48d5                	li	a7,21
 ecall
     b2e:	00000073          	ecall
 ret
     b32:	8082                	ret

0000000000000b34 <kill>:
.global kill
kill:
 li a7, SYS_kill
     b34:	4899                	li	a7,6
 ecall
     b36:	00000073          	ecall
 ret
     b3a:	8082                	ret

0000000000000b3c <exec>:
.global exec
exec:
 li a7, SYS_exec
     b3c:	489d                	li	a7,7
 ecall
     b3e:	00000073          	ecall
 ret
     b42:	8082                	ret

0000000000000b44 <open>:
.global open
open:
 li a7, SYS_open
     b44:	48bd                	li	a7,15
 ecall
     b46:	00000073          	ecall
 ret
     b4a:	8082                	ret

0000000000000b4c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     b4c:	48c5                	li	a7,17
 ecall
     b4e:	00000073          	ecall
 ret
     b52:	8082                	ret

0000000000000b54 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     b54:	48c9                	li	a7,18
 ecall
     b56:	00000073          	ecall
 ret
     b5a:	8082                	ret

0000000000000b5c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     b5c:	48a1                	li	a7,8
 ecall
     b5e:	00000073          	ecall
 ret
     b62:	8082                	ret

0000000000000b64 <link>:
.global link
link:
 li a7, SYS_link
     b64:	48cd                	li	a7,19
 ecall
     b66:	00000073          	ecall
 ret
     b6a:	8082                	ret

0000000000000b6c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     b6c:	48d1                	li	a7,20
 ecall
     b6e:	00000073          	ecall
 ret
     b72:	8082                	ret

0000000000000b74 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     b74:	48a5                	li	a7,9
 ecall
     b76:	00000073          	ecall
 ret
     b7a:	8082                	ret

0000000000000b7c <dup>:
.global dup
dup:
 li a7, SYS_dup
     b7c:	48a9                	li	a7,10
 ecall
     b7e:	00000073          	ecall
 ret
     b82:	8082                	ret

0000000000000b84 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     b84:	48ad                	li	a7,11
 ecall
     b86:	00000073          	ecall
 ret
     b8a:	8082                	ret

0000000000000b8c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     b8c:	48b1                	li	a7,12
 ecall
     b8e:	00000073          	ecall
 ret
     b92:	8082                	ret

0000000000000b94 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     b94:	48b5                	li	a7,13
 ecall
     b96:	00000073          	ecall
 ret
     b9a:	8082                	ret

0000000000000b9c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     b9c:	48b9                	li	a7,14
 ecall
     b9e:	00000073          	ecall
 ret
     ba2:	8082                	ret

0000000000000ba4 <clone>:
.global clone
clone:
 li a7, SYS_clone
     ba4:	48d9                	li	a7,22
 ecall
     ba6:	00000073          	ecall
 ret
     baa:	8082                	ret

0000000000000bac <join>:
.global join
join:
 li a7, SYS_join
     bac:	48dd                	li	a7,23
 ecall
     bae:	00000073          	ecall
 ret
     bb2:	8082                	ret

0000000000000bb4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     bb4:	1101                	addi	sp,sp,-32
     bb6:	ec06                	sd	ra,24(sp)
     bb8:	e822                	sd	s0,16(sp)
     bba:	1000                	addi	s0,sp,32
     bbc:	87aa                	mv	a5,a0
     bbe:	872e                	mv	a4,a1
     bc0:	fef42623          	sw	a5,-20(s0)
     bc4:	87ba                	mv	a5,a4
     bc6:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     bca:	feb40713          	addi	a4,s0,-21
     bce:	fec42783          	lw	a5,-20(s0)
     bd2:	4605                	li	a2,1
     bd4:	85ba                	mv	a1,a4
     bd6:	853e                	mv	a0,a5
     bd8:	00000097          	auipc	ra,0x0
     bdc:	f4c080e7          	jalr	-180(ra) # b24 <write>
}
     be0:	0001                	nop
     be2:	60e2                	ld	ra,24(sp)
     be4:	6442                	ld	s0,16(sp)
     be6:	6105                	addi	sp,sp,32
     be8:	8082                	ret

0000000000000bea <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     bea:	7139                	addi	sp,sp,-64
     bec:	fc06                	sd	ra,56(sp)
     bee:	f822                	sd	s0,48(sp)
     bf0:	0080                	addi	s0,sp,64
     bf2:	87aa                	mv	a5,a0
     bf4:	8736                	mv	a4,a3
     bf6:	fcf42623          	sw	a5,-52(s0)
     bfa:	87ae                	mv	a5,a1
     bfc:	fcf42423          	sw	a5,-56(s0)
     c00:	87b2                	mv	a5,a2
     c02:	fcf42223          	sw	a5,-60(s0)
     c06:	87ba                	mv	a5,a4
     c08:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     c0c:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     c10:	fc042783          	lw	a5,-64(s0)
     c14:	2781                	sext.w	a5,a5
     c16:	c38d                	beqz	a5,c38 <printint+0x4e>
     c18:	fc842783          	lw	a5,-56(s0)
     c1c:	2781                	sext.w	a5,a5
     c1e:	0007dd63          	bgez	a5,c38 <printint+0x4e>
    neg = 1;
     c22:	4785                	li	a5,1
     c24:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     c28:	fc842783          	lw	a5,-56(s0)
     c2c:	40f007bb          	negw	a5,a5
     c30:	2781                	sext.w	a5,a5
     c32:	fef42223          	sw	a5,-28(s0)
     c36:	a029                	j	c40 <printint+0x56>
  } else {
    x = xx;
     c38:	fc842783          	lw	a5,-56(s0)
     c3c:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     c40:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     c44:	fc442783          	lw	a5,-60(s0)
     c48:	fe442703          	lw	a4,-28(s0)
     c4c:	02f777bb          	remuw	a5,a4,a5
     c50:	0007861b          	sext.w	a2,a5
     c54:	fec42783          	lw	a5,-20(s0)
     c58:	0017871b          	addiw	a4,a5,1
     c5c:	fee42623          	sw	a4,-20(s0)
     c60:	00001697          	auipc	a3,0x1
     c64:	b1068693          	addi	a3,a3,-1264 # 1770 <digits>
     c68:	02061713          	slli	a4,a2,0x20
     c6c:	9301                	srli	a4,a4,0x20
     c6e:	9736                	add	a4,a4,a3
     c70:	00074703          	lbu	a4,0(a4)
     c74:	17c1                	addi	a5,a5,-16
     c76:	97a2                	add	a5,a5,s0
     c78:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     c7c:	fc442783          	lw	a5,-60(s0)
     c80:	fe442703          	lw	a4,-28(s0)
     c84:	02f757bb          	divuw	a5,a4,a5
     c88:	fef42223          	sw	a5,-28(s0)
     c8c:	fe442783          	lw	a5,-28(s0)
     c90:	2781                	sext.w	a5,a5
     c92:	fbcd                	bnez	a5,c44 <printint+0x5a>
  if(neg)
     c94:	fe842783          	lw	a5,-24(s0)
     c98:	2781                	sext.w	a5,a5
     c9a:	cf85                	beqz	a5,cd2 <printint+0xe8>
    buf[i++] = '-';
     c9c:	fec42783          	lw	a5,-20(s0)
     ca0:	0017871b          	addiw	a4,a5,1
     ca4:	fee42623          	sw	a4,-20(s0)
     ca8:	17c1                	addi	a5,a5,-16
     caa:	97a2                	add	a5,a5,s0
     cac:	02d00713          	li	a4,45
     cb0:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     cb4:	a839                	j	cd2 <printint+0xe8>
    putc(fd, buf[i]);
     cb6:	fec42783          	lw	a5,-20(s0)
     cba:	17c1                	addi	a5,a5,-16
     cbc:	97a2                	add	a5,a5,s0
     cbe:	fe07c703          	lbu	a4,-32(a5)
     cc2:	fcc42783          	lw	a5,-52(s0)
     cc6:	85ba                	mv	a1,a4
     cc8:	853e                	mv	a0,a5
     cca:	00000097          	auipc	ra,0x0
     cce:	eea080e7          	jalr	-278(ra) # bb4 <putc>
  while(--i >= 0)
     cd2:	fec42783          	lw	a5,-20(s0)
     cd6:	37fd                	addiw	a5,a5,-1
     cd8:	fef42623          	sw	a5,-20(s0)
     cdc:	fec42783          	lw	a5,-20(s0)
     ce0:	2781                	sext.w	a5,a5
     ce2:	fc07dae3          	bgez	a5,cb6 <printint+0xcc>
}
     ce6:	0001                	nop
     ce8:	0001                	nop
     cea:	70e2                	ld	ra,56(sp)
     cec:	7442                	ld	s0,48(sp)
     cee:	6121                	addi	sp,sp,64
     cf0:	8082                	ret

0000000000000cf2 <printptr>:

static void
printptr(int fd, uint64 x) {
     cf2:	7179                	addi	sp,sp,-48
     cf4:	f406                	sd	ra,40(sp)
     cf6:	f022                	sd	s0,32(sp)
     cf8:	1800                	addi	s0,sp,48
     cfa:	87aa                	mv	a5,a0
     cfc:	fcb43823          	sd	a1,-48(s0)
     d00:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     d04:	fdc42783          	lw	a5,-36(s0)
     d08:	03000593          	li	a1,48
     d0c:	853e                	mv	a0,a5
     d0e:	00000097          	auipc	ra,0x0
     d12:	ea6080e7          	jalr	-346(ra) # bb4 <putc>
  putc(fd, 'x');
     d16:	fdc42783          	lw	a5,-36(s0)
     d1a:	07800593          	li	a1,120
     d1e:	853e                	mv	a0,a5
     d20:	00000097          	auipc	ra,0x0
     d24:	e94080e7          	jalr	-364(ra) # bb4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     d28:	fe042623          	sw	zero,-20(s0)
     d2c:	a82d                	j	d66 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     d2e:	fd043783          	ld	a5,-48(s0)
     d32:	93f1                	srli	a5,a5,0x3c
     d34:	00001717          	auipc	a4,0x1
     d38:	a3c70713          	addi	a4,a4,-1476 # 1770 <digits>
     d3c:	97ba                	add	a5,a5,a4
     d3e:	0007c703          	lbu	a4,0(a5)
     d42:	fdc42783          	lw	a5,-36(s0)
     d46:	85ba                	mv	a1,a4
     d48:	853e                	mv	a0,a5
     d4a:	00000097          	auipc	ra,0x0
     d4e:	e6a080e7          	jalr	-406(ra) # bb4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     d52:	fec42783          	lw	a5,-20(s0)
     d56:	2785                	addiw	a5,a5,1
     d58:	fef42623          	sw	a5,-20(s0)
     d5c:	fd043783          	ld	a5,-48(s0)
     d60:	0792                	slli	a5,a5,0x4
     d62:	fcf43823          	sd	a5,-48(s0)
     d66:	fec42783          	lw	a5,-20(s0)
     d6a:	873e                	mv	a4,a5
     d6c:	47bd                	li	a5,15
     d6e:	fce7f0e3          	bgeu	a5,a4,d2e <printptr+0x3c>
}
     d72:	0001                	nop
     d74:	0001                	nop
     d76:	70a2                	ld	ra,40(sp)
     d78:	7402                	ld	s0,32(sp)
     d7a:	6145                	addi	sp,sp,48
     d7c:	8082                	ret

0000000000000d7e <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     d7e:	715d                	addi	sp,sp,-80
     d80:	e486                	sd	ra,72(sp)
     d82:	e0a2                	sd	s0,64(sp)
     d84:	0880                	addi	s0,sp,80
     d86:	87aa                	mv	a5,a0
     d88:	fcb43023          	sd	a1,-64(s0)
     d8c:	fac43c23          	sd	a2,-72(s0)
     d90:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     d94:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     d98:	fe042223          	sw	zero,-28(s0)
     d9c:	a42d                	j	fc6 <vprintf+0x248>
    c = fmt[i] & 0xff;
     d9e:	fe442783          	lw	a5,-28(s0)
     da2:	fc043703          	ld	a4,-64(s0)
     da6:	97ba                	add	a5,a5,a4
     da8:	0007c783          	lbu	a5,0(a5)
     dac:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     db0:	fe042783          	lw	a5,-32(s0)
     db4:	2781                	sext.w	a5,a5
     db6:	eb9d                	bnez	a5,dec <vprintf+0x6e>
      if(c == '%'){
     db8:	fdc42783          	lw	a5,-36(s0)
     dbc:	0007871b          	sext.w	a4,a5
     dc0:	02500793          	li	a5,37
     dc4:	00f71763          	bne	a4,a5,dd2 <vprintf+0x54>
        state = '%';
     dc8:	02500793          	li	a5,37
     dcc:	fef42023          	sw	a5,-32(s0)
     dd0:	a2f5                	j	fbc <vprintf+0x23e>
      } else {
        putc(fd, c);
     dd2:	fdc42783          	lw	a5,-36(s0)
     dd6:	0ff7f713          	zext.b	a4,a5
     dda:	fcc42783          	lw	a5,-52(s0)
     dde:	85ba                	mv	a1,a4
     de0:	853e                	mv	a0,a5
     de2:	00000097          	auipc	ra,0x0
     de6:	dd2080e7          	jalr	-558(ra) # bb4 <putc>
     dea:	aac9                	j	fbc <vprintf+0x23e>
      }
    } else if(state == '%'){
     dec:	fe042783          	lw	a5,-32(s0)
     df0:	0007871b          	sext.w	a4,a5
     df4:	02500793          	li	a5,37
     df8:	1cf71263          	bne	a4,a5,fbc <vprintf+0x23e>
      if(c == 'd'){
     dfc:	fdc42783          	lw	a5,-36(s0)
     e00:	0007871b          	sext.w	a4,a5
     e04:	06400793          	li	a5,100
     e08:	02f71463          	bne	a4,a5,e30 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     e0c:	fb843783          	ld	a5,-72(s0)
     e10:	00878713          	addi	a4,a5,8
     e14:	fae43c23          	sd	a4,-72(s0)
     e18:	4398                	lw	a4,0(a5)
     e1a:	fcc42783          	lw	a5,-52(s0)
     e1e:	4685                	li	a3,1
     e20:	4629                	li	a2,10
     e22:	85ba                	mv	a1,a4
     e24:	853e                	mv	a0,a5
     e26:	00000097          	auipc	ra,0x0
     e2a:	dc4080e7          	jalr	-572(ra) # bea <printint>
     e2e:	a269                	j	fb8 <vprintf+0x23a>
      } else if(c == 'l') {
     e30:	fdc42783          	lw	a5,-36(s0)
     e34:	0007871b          	sext.w	a4,a5
     e38:	06c00793          	li	a5,108
     e3c:	02f71663          	bne	a4,a5,e68 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     e40:	fb843783          	ld	a5,-72(s0)
     e44:	00878713          	addi	a4,a5,8
     e48:	fae43c23          	sd	a4,-72(s0)
     e4c:	639c                	ld	a5,0(a5)
     e4e:	0007871b          	sext.w	a4,a5
     e52:	fcc42783          	lw	a5,-52(s0)
     e56:	4681                	li	a3,0
     e58:	4629                	li	a2,10
     e5a:	85ba                	mv	a1,a4
     e5c:	853e                	mv	a0,a5
     e5e:	00000097          	auipc	ra,0x0
     e62:	d8c080e7          	jalr	-628(ra) # bea <printint>
     e66:	aa89                	j	fb8 <vprintf+0x23a>
      } else if(c == 'x') {
     e68:	fdc42783          	lw	a5,-36(s0)
     e6c:	0007871b          	sext.w	a4,a5
     e70:	07800793          	li	a5,120
     e74:	02f71463          	bne	a4,a5,e9c <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     e78:	fb843783          	ld	a5,-72(s0)
     e7c:	00878713          	addi	a4,a5,8
     e80:	fae43c23          	sd	a4,-72(s0)
     e84:	4398                	lw	a4,0(a5)
     e86:	fcc42783          	lw	a5,-52(s0)
     e8a:	4681                	li	a3,0
     e8c:	4641                	li	a2,16
     e8e:	85ba                	mv	a1,a4
     e90:	853e                	mv	a0,a5
     e92:	00000097          	auipc	ra,0x0
     e96:	d58080e7          	jalr	-680(ra) # bea <printint>
     e9a:	aa39                	j	fb8 <vprintf+0x23a>
      } else if(c == 'p') {
     e9c:	fdc42783          	lw	a5,-36(s0)
     ea0:	0007871b          	sext.w	a4,a5
     ea4:	07000793          	li	a5,112
     ea8:	02f71263          	bne	a4,a5,ecc <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     eac:	fb843783          	ld	a5,-72(s0)
     eb0:	00878713          	addi	a4,a5,8
     eb4:	fae43c23          	sd	a4,-72(s0)
     eb8:	6398                	ld	a4,0(a5)
     eba:	fcc42783          	lw	a5,-52(s0)
     ebe:	85ba                	mv	a1,a4
     ec0:	853e                	mv	a0,a5
     ec2:	00000097          	auipc	ra,0x0
     ec6:	e30080e7          	jalr	-464(ra) # cf2 <printptr>
     eca:	a0fd                	j	fb8 <vprintf+0x23a>
      } else if(c == 's'){
     ecc:	fdc42783          	lw	a5,-36(s0)
     ed0:	0007871b          	sext.w	a4,a5
     ed4:	07300793          	li	a5,115
     ed8:	04f71c63          	bne	a4,a5,f30 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     edc:	fb843783          	ld	a5,-72(s0)
     ee0:	00878713          	addi	a4,a5,8
     ee4:	fae43c23          	sd	a4,-72(s0)
     ee8:	639c                	ld	a5,0(a5)
     eea:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     eee:	fe843783          	ld	a5,-24(s0)
     ef2:	eb8d                	bnez	a5,f24 <vprintf+0x1a6>
          s = "(null)";
     ef4:	00001797          	auipc	a5,0x1
     ef8:	82478793          	addi	a5,a5,-2012 # 1718 <lock_init+0x2b2>
     efc:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     f00:	a015                	j	f24 <vprintf+0x1a6>
          putc(fd, *s);
     f02:	fe843783          	ld	a5,-24(s0)
     f06:	0007c703          	lbu	a4,0(a5)
     f0a:	fcc42783          	lw	a5,-52(s0)
     f0e:	85ba                	mv	a1,a4
     f10:	853e                	mv	a0,a5
     f12:	00000097          	auipc	ra,0x0
     f16:	ca2080e7          	jalr	-862(ra) # bb4 <putc>
          s++;
     f1a:	fe843783          	ld	a5,-24(s0)
     f1e:	0785                	addi	a5,a5,1
     f20:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     f24:	fe843783          	ld	a5,-24(s0)
     f28:	0007c783          	lbu	a5,0(a5)
     f2c:	fbf9                	bnez	a5,f02 <vprintf+0x184>
     f2e:	a069                	j	fb8 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     f30:	fdc42783          	lw	a5,-36(s0)
     f34:	0007871b          	sext.w	a4,a5
     f38:	06300793          	li	a5,99
     f3c:	02f71463          	bne	a4,a5,f64 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     f40:	fb843783          	ld	a5,-72(s0)
     f44:	00878713          	addi	a4,a5,8
     f48:	fae43c23          	sd	a4,-72(s0)
     f4c:	439c                	lw	a5,0(a5)
     f4e:	0ff7f713          	zext.b	a4,a5
     f52:	fcc42783          	lw	a5,-52(s0)
     f56:	85ba                	mv	a1,a4
     f58:	853e                	mv	a0,a5
     f5a:	00000097          	auipc	ra,0x0
     f5e:	c5a080e7          	jalr	-934(ra) # bb4 <putc>
     f62:	a899                	j	fb8 <vprintf+0x23a>
      } else if(c == '%'){
     f64:	fdc42783          	lw	a5,-36(s0)
     f68:	0007871b          	sext.w	a4,a5
     f6c:	02500793          	li	a5,37
     f70:	00f71f63          	bne	a4,a5,f8e <vprintf+0x210>
        putc(fd, c);
     f74:	fdc42783          	lw	a5,-36(s0)
     f78:	0ff7f713          	zext.b	a4,a5
     f7c:	fcc42783          	lw	a5,-52(s0)
     f80:	85ba                	mv	a1,a4
     f82:	853e                	mv	a0,a5
     f84:	00000097          	auipc	ra,0x0
     f88:	c30080e7          	jalr	-976(ra) # bb4 <putc>
     f8c:	a035                	j	fb8 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     f8e:	fcc42783          	lw	a5,-52(s0)
     f92:	02500593          	li	a1,37
     f96:	853e                	mv	a0,a5
     f98:	00000097          	auipc	ra,0x0
     f9c:	c1c080e7          	jalr	-996(ra) # bb4 <putc>
        putc(fd, c);
     fa0:	fdc42783          	lw	a5,-36(s0)
     fa4:	0ff7f713          	zext.b	a4,a5
     fa8:	fcc42783          	lw	a5,-52(s0)
     fac:	85ba                	mv	a1,a4
     fae:	853e                	mv	a0,a5
     fb0:	00000097          	auipc	ra,0x0
     fb4:	c04080e7          	jalr	-1020(ra) # bb4 <putc>
      }
      state = 0;
     fb8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     fbc:	fe442783          	lw	a5,-28(s0)
     fc0:	2785                	addiw	a5,a5,1
     fc2:	fef42223          	sw	a5,-28(s0)
     fc6:	fe442783          	lw	a5,-28(s0)
     fca:	fc043703          	ld	a4,-64(s0)
     fce:	97ba                	add	a5,a5,a4
     fd0:	0007c783          	lbu	a5,0(a5)
     fd4:	dc0795e3          	bnez	a5,d9e <vprintf+0x20>
    }
  }
}
     fd8:	0001                	nop
     fda:	0001                	nop
     fdc:	60a6                	ld	ra,72(sp)
     fde:	6406                	ld	s0,64(sp)
     fe0:	6161                	addi	sp,sp,80
     fe2:	8082                	ret

0000000000000fe4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     fe4:	7159                	addi	sp,sp,-112
     fe6:	fc06                	sd	ra,56(sp)
     fe8:	f822                	sd	s0,48(sp)
     fea:	0080                	addi	s0,sp,64
     fec:	fcb43823          	sd	a1,-48(s0)
     ff0:	e010                	sd	a2,0(s0)
     ff2:	e414                	sd	a3,8(s0)
     ff4:	e818                	sd	a4,16(s0)
     ff6:	ec1c                	sd	a5,24(s0)
     ff8:	03043023          	sd	a6,32(s0)
     ffc:	03143423          	sd	a7,40(s0)
    1000:	87aa                	mv	a5,a0
    1002:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    1006:	03040793          	addi	a5,s0,48
    100a:	fcf43423          	sd	a5,-56(s0)
    100e:	fc843783          	ld	a5,-56(s0)
    1012:	fd078793          	addi	a5,a5,-48
    1016:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    101a:	fe843703          	ld	a4,-24(s0)
    101e:	fdc42783          	lw	a5,-36(s0)
    1022:	863a                	mv	a2,a4
    1024:	fd043583          	ld	a1,-48(s0)
    1028:	853e                	mv	a0,a5
    102a:	00000097          	auipc	ra,0x0
    102e:	d54080e7          	jalr	-684(ra) # d7e <vprintf>
}
    1032:	0001                	nop
    1034:	70e2                	ld	ra,56(sp)
    1036:	7442                	ld	s0,48(sp)
    1038:	6165                	addi	sp,sp,112
    103a:	8082                	ret

000000000000103c <printf>:

void
printf(const char *fmt, ...)
{
    103c:	7159                	addi	sp,sp,-112
    103e:	f406                	sd	ra,40(sp)
    1040:	f022                	sd	s0,32(sp)
    1042:	1800                	addi	s0,sp,48
    1044:	fca43c23          	sd	a0,-40(s0)
    1048:	e40c                	sd	a1,8(s0)
    104a:	e810                	sd	a2,16(s0)
    104c:	ec14                	sd	a3,24(s0)
    104e:	f018                	sd	a4,32(s0)
    1050:	f41c                	sd	a5,40(s0)
    1052:	03043823          	sd	a6,48(s0)
    1056:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    105a:	04040793          	addi	a5,s0,64
    105e:	fcf43823          	sd	a5,-48(s0)
    1062:	fd043783          	ld	a5,-48(s0)
    1066:	fc878793          	addi	a5,a5,-56
    106a:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    106e:	fe843783          	ld	a5,-24(s0)
    1072:	863e                	mv	a2,a5
    1074:	fd843583          	ld	a1,-40(s0)
    1078:	4505                	li	a0,1
    107a:	00000097          	auipc	ra,0x0
    107e:	d04080e7          	jalr	-764(ra) # d7e <vprintf>
}
    1082:	0001                	nop
    1084:	70a2                	ld	ra,40(sp)
    1086:	7402                	ld	s0,32(sp)
    1088:	6165                	addi	sp,sp,112
    108a:	8082                	ret

000000000000108c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    108c:	7179                	addi	sp,sp,-48
    108e:	f422                	sd	s0,40(sp)
    1090:	1800                	addi	s0,sp,48
    1092:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1096:	fd843783          	ld	a5,-40(s0)
    109a:	17c1                	addi	a5,a5,-16
    109c:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10a0:	00000797          	auipc	a5,0x0
    10a4:	70878793          	addi	a5,a5,1800 # 17a8 <freep>
    10a8:	639c                	ld	a5,0(a5)
    10aa:	fef43423          	sd	a5,-24(s0)
    10ae:	a815                	j	10e2 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10b0:	fe843783          	ld	a5,-24(s0)
    10b4:	639c                	ld	a5,0(a5)
    10b6:	fe843703          	ld	a4,-24(s0)
    10ba:	00f76f63          	bltu	a4,a5,10d8 <free+0x4c>
    10be:	fe043703          	ld	a4,-32(s0)
    10c2:	fe843783          	ld	a5,-24(s0)
    10c6:	02e7eb63          	bltu	a5,a4,10fc <free+0x70>
    10ca:	fe843783          	ld	a5,-24(s0)
    10ce:	639c                	ld	a5,0(a5)
    10d0:	fe043703          	ld	a4,-32(s0)
    10d4:	02f76463          	bltu	a4,a5,10fc <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10d8:	fe843783          	ld	a5,-24(s0)
    10dc:	639c                	ld	a5,0(a5)
    10de:	fef43423          	sd	a5,-24(s0)
    10e2:	fe043703          	ld	a4,-32(s0)
    10e6:	fe843783          	ld	a5,-24(s0)
    10ea:	fce7f3e3          	bgeu	a5,a4,10b0 <free+0x24>
    10ee:	fe843783          	ld	a5,-24(s0)
    10f2:	639c                	ld	a5,0(a5)
    10f4:	fe043703          	ld	a4,-32(s0)
    10f8:	faf77ce3          	bgeu	a4,a5,10b0 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    10fc:	fe043783          	ld	a5,-32(s0)
    1100:	479c                	lw	a5,8(a5)
    1102:	1782                	slli	a5,a5,0x20
    1104:	9381                	srli	a5,a5,0x20
    1106:	0792                	slli	a5,a5,0x4
    1108:	fe043703          	ld	a4,-32(s0)
    110c:	973e                	add	a4,a4,a5
    110e:	fe843783          	ld	a5,-24(s0)
    1112:	639c                	ld	a5,0(a5)
    1114:	02f71763          	bne	a4,a5,1142 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    1118:	fe043783          	ld	a5,-32(s0)
    111c:	4798                	lw	a4,8(a5)
    111e:	fe843783          	ld	a5,-24(s0)
    1122:	639c                	ld	a5,0(a5)
    1124:	479c                	lw	a5,8(a5)
    1126:	9fb9                	addw	a5,a5,a4
    1128:	0007871b          	sext.w	a4,a5
    112c:	fe043783          	ld	a5,-32(s0)
    1130:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    1132:	fe843783          	ld	a5,-24(s0)
    1136:	639c                	ld	a5,0(a5)
    1138:	6398                	ld	a4,0(a5)
    113a:	fe043783          	ld	a5,-32(s0)
    113e:	e398                	sd	a4,0(a5)
    1140:	a039                	j	114e <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    1142:	fe843783          	ld	a5,-24(s0)
    1146:	6398                	ld	a4,0(a5)
    1148:	fe043783          	ld	a5,-32(s0)
    114c:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    114e:	fe843783          	ld	a5,-24(s0)
    1152:	479c                	lw	a5,8(a5)
    1154:	1782                	slli	a5,a5,0x20
    1156:	9381                	srli	a5,a5,0x20
    1158:	0792                	slli	a5,a5,0x4
    115a:	fe843703          	ld	a4,-24(s0)
    115e:	97ba                	add	a5,a5,a4
    1160:	fe043703          	ld	a4,-32(s0)
    1164:	02f71563          	bne	a4,a5,118e <free+0x102>
    p->s.size += bp->s.size;
    1168:	fe843783          	ld	a5,-24(s0)
    116c:	4798                	lw	a4,8(a5)
    116e:	fe043783          	ld	a5,-32(s0)
    1172:	479c                	lw	a5,8(a5)
    1174:	9fb9                	addw	a5,a5,a4
    1176:	0007871b          	sext.w	a4,a5
    117a:	fe843783          	ld	a5,-24(s0)
    117e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1180:	fe043783          	ld	a5,-32(s0)
    1184:	6398                	ld	a4,0(a5)
    1186:	fe843783          	ld	a5,-24(s0)
    118a:	e398                	sd	a4,0(a5)
    118c:	a031                	j	1198 <free+0x10c>
  } else
    p->s.ptr = bp;
    118e:	fe843783          	ld	a5,-24(s0)
    1192:	fe043703          	ld	a4,-32(s0)
    1196:	e398                	sd	a4,0(a5)
  freep = p;
    1198:	00000797          	auipc	a5,0x0
    119c:	61078793          	addi	a5,a5,1552 # 17a8 <freep>
    11a0:	fe843703          	ld	a4,-24(s0)
    11a4:	e398                	sd	a4,0(a5)
}
    11a6:	0001                	nop
    11a8:	7422                	ld	s0,40(sp)
    11aa:	6145                	addi	sp,sp,48
    11ac:	8082                	ret

00000000000011ae <morecore>:

static Header*
morecore(uint nu)
{
    11ae:	7179                	addi	sp,sp,-48
    11b0:	f406                	sd	ra,40(sp)
    11b2:	f022                	sd	s0,32(sp)
    11b4:	1800                	addi	s0,sp,48
    11b6:	87aa                	mv	a5,a0
    11b8:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    11bc:	fdc42783          	lw	a5,-36(s0)
    11c0:	0007871b          	sext.w	a4,a5
    11c4:	6785                	lui	a5,0x1
    11c6:	00f77563          	bgeu	a4,a5,11d0 <morecore+0x22>
    nu = 4096;
    11ca:	6785                	lui	a5,0x1
    11cc:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    11d0:	fdc42783          	lw	a5,-36(s0)
    11d4:	0047979b          	slliw	a5,a5,0x4
    11d8:	2781                	sext.w	a5,a5
    11da:	2781                	sext.w	a5,a5
    11dc:	853e                	mv	a0,a5
    11de:	00000097          	auipc	ra,0x0
    11e2:	9ae080e7          	jalr	-1618(ra) # b8c <sbrk>
    11e6:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    11ea:	fe843703          	ld	a4,-24(s0)
    11ee:	57fd                	li	a5,-1
    11f0:	00f71463          	bne	a4,a5,11f8 <morecore+0x4a>
    return 0;
    11f4:	4781                	li	a5,0
    11f6:	a03d                	j	1224 <morecore+0x76>
  hp = (Header*)p;
    11f8:	fe843783          	ld	a5,-24(s0)
    11fc:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    1200:	fe043783          	ld	a5,-32(s0)
    1204:	fdc42703          	lw	a4,-36(s0)
    1208:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    120a:	fe043783          	ld	a5,-32(s0)
    120e:	07c1                	addi	a5,a5,16
    1210:	853e                	mv	a0,a5
    1212:	00000097          	auipc	ra,0x0
    1216:	e7a080e7          	jalr	-390(ra) # 108c <free>
  return freep;
    121a:	00000797          	auipc	a5,0x0
    121e:	58e78793          	addi	a5,a5,1422 # 17a8 <freep>
    1222:	639c                	ld	a5,0(a5)
}
    1224:	853e                	mv	a0,a5
    1226:	70a2                	ld	ra,40(sp)
    1228:	7402                	ld	s0,32(sp)
    122a:	6145                	addi	sp,sp,48
    122c:	8082                	ret

000000000000122e <malloc>:

void*
malloc(uint nbytes)
{
    122e:	7139                	addi	sp,sp,-64
    1230:	fc06                	sd	ra,56(sp)
    1232:	f822                	sd	s0,48(sp)
    1234:	0080                	addi	s0,sp,64
    1236:	87aa                	mv	a5,a0
    1238:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    123c:	fcc46783          	lwu	a5,-52(s0)
    1240:	07bd                	addi	a5,a5,15
    1242:	8391                	srli	a5,a5,0x4
    1244:	2781                	sext.w	a5,a5
    1246:	2785                	addiw	a5,a5,1
    1248:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    124c:	00000797          	auipc	a5,0x0
    1250:	55c78793          	addi	a5,a5,1372 # 17a8 <freep>
    1254:	639c                	ld	a5,0(a5)
    1256:	fef43023          	sd	a5,-32(s0)
    125a:	fe043783          	ld	a5,-32(s0)
    125e:	ef95                	bnez	a5,129a <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1260:	00000797          	auipc	a5,0x0
    1264:	53878793          	addi	a5,a5,1336 # 1798 <base>
    1268:	fef43023          	sd	a5,-32(s0)
    126c:	00000797          	auipc	a5,0x0
    1270:	53c78793          	addi	a5,a5,1340 # 17a8 <freep>
    1274:	fe043703          	ld	a4,-32(s0)
    1278:	e398                	sd	a4,0(a5)
    127a:	00000797          	auipc	a5,0x0
    127e:	52e78793          	addi	a5,a5,1326 # 17a8 <freep>
    1282:	6398                	ld	a4,0(a5)
    1284:	00000797          	auipc	a5,0x0
    1288:	51478793          	addi	a5,a5,1300 # 1798 <base>
    128c:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    128e:	00000797          	auipc	a5,0x0
    1292:	50a78793          	addi	a5,a5,1290 # 1798 <base>
    1296:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    129a:	fe043783          	ld	a5,-32(s0)
    129e:	639c                	ld	a5,0(a5)
    12a0:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    12a4:	fe843783          	ld	a5,-24(s0)
    12a8:	4798                	lw	a4,8(a5)
    12aa:	fdc42783          	lw	a5,-36(s0)
    12ae:	2781                	sext.w	a5,a5
    12b0:	06f76763          	bltu	a4,a5,131e <malloc+0xf0>
      if(p->s.size == nunits)
    12b4:	fe843783          	ld	a5,-24(s0)
    12b8:	4798                	lw	a4,8(a5)
    12ba:	fdc42783          	lw	a5,-36(s0)
    12be:	2781                	sext.w	a5,a5
    12c0:	00e79963          	bne	a5,a4,12d2 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    12c4:	fe843783          	ld	a5,-24(s0)
    12c8:	6398                	ld	a4,0(a5)
    12ca:	fe043783          	ld	a5,-32(s0)
    12ce:	e398                	sd	a4,0(a5)
    12d0:	a825                	j	1308 <malloc+0xda>
      else {
        p->s.size -= nunits;
    12d2:	fe843783          	ld	a5,-24(s0)
    12d6:	479c                	lw	a5,8(a5)
    12d8:	fdc42703          	lw	a4,-36(s0)
    12dc:	9f99                	subw	a5,a5,a4
    12de:	0007871b          	sext.w	a4,a5
    12e2:	fe843783          	ld	a5,-24(s0)
    12e6:	c798                	sw	a4,8(a5)
        p += p->s.size;
    12e8:	fe843783          	ld	a5,-24(s0)
    12ec:	479c                	lw	a5,8(a5)
    12ee:	1782                	slli	a5,a5,0x20
    12f0:	9381                	srli	a5,a5,0x20
    12f2:	0792                	slli	a5,a5,0x4
    12f4:	fe843703          	ld	a4,-24(s0)
    12f8:	97ba                	add	a5,a5,a4
    12fa:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    12fe:	fe843783          	ld	a5,-24(s0)
    1302:	fdc42703          	lw	a4,-36(s0)
    1306:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1308:	00000797          	auipc	a5,0x0
    130c:	4a078793          	addi	a5,a5,1184 # 17a8 <freep>
    1310:	fe043703          	ld	a4,-32(s0)
    1314:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1316:	fe843783          	ld	a5,-24(s0)
    131a:	07c1                	addi	a5,a5,16
    131c:	a091                	j	1360 <malloc+0x132>
    }
    if(p == freep)
    131e:	00000797          	auipc	a5,0x0
    1322:	48a78793          	addi	a5,a5,1162 # 17a8 <freep>
    1326:	639c                	ld	a5,0(a5)
    1328:	fe843703          	ld	a4,-24(s0)
    132c:	02f71063          	bne	a4,a5,134c <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    1330:	fdc42783          	lw	a5,-36(s0)
    1334:	853e                	mv	a0,a5
    1336:	00000097          	auipc	ra,0x0
    133a:	e78080e7          	jalr	-392(ra) # 11ae <morecore>
    133e:	fea43423          	sd	a0,-24(s0)
    1342:	fe843783          	ld	a5,-24(s0)
    1346:	e399                	bnez	a5,134c <malloc+0x11e>
        return 0;
    1348:	4781                	li	a5,0
    134a:	a819                	j	1360 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    134c:	fe843783          	ld	a5,-24(s0)
    1350:	fef43023          	sd	a5,-32(s0)
    1354:	fe843783          	ld	a5,-24(s0)
    1358:	639c                	ld	a5,0(a5)
    135a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    135e:	b799                	j	12a4 <malloc+0x76>
  }
}
    1360:	853e                	mv	a0,a5
    1362:	70e2                	ld	ra,56(sp)
    1364:	7442                	ld	s0,48(sp)
    1366:	6121                	addi	sp,sp,64
    1368:	8082                	ret

000000000000136a <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
    136a:	7179                	addi	sp,sp,-48
    136c:	f406                	sd	ra,40(sp)
    136e:	f022                	sd	s0,32(sp)
    1370:	1800                	addi	s0,sp,48
    1372:	fca43c23          	sd	a0,-40(s0)
    1376:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
    137a:	6505                	lui	a0,0x1
    137c:	00000097          	auipc	ra,0x0
    1380:	eb2080e7          	jalr	-334(ra) # 122e <malloc>
    1384:	fea43423          	sd	a0,-24(s0)
    1388:	fe843783          	ld	a5,-24(s0)
    138c:	e38d                	bnez	a5,13ae <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
    138e:	00000517          	auipc	a0,0x0
    1392:	39250513          	addi	a0,a0,914 # 1720 <lock_init+0x2ba>
    1396:	00000097          	auipc	ra,0x0
    139a:	ca6080e7          	jalr	-858(ra) # 103c <printf>
        free(stack);
    139e:	fe843503          	ld	a0,-24(s0)
    13a2:	00000097          	auipc	ra,0x0
    13a6:	cea080e7          	jalr	-790(ra) # 108c <free>
        return -1;
    13aa:	57fd                	li	a5,-1
    13ac:	a099                	j	13f2 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
    13ae:	fe843783          	ld	a5,-24(s0)
    13b2:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
    13b6:	fe043703          	ld	a4,-32(s0)
    13ba:	6785                	lui	a5,0x1
    13bc:	17fd                	addi	a5,a5,-1
    13be:	8ff9                	and	a5,a5,a4
    13c0:	cf91                	beqz	a5,13dc <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
    13c2:	fe043703          	ld	a4,-32(s0)
    13c6:	6785                	lui	a5,0x1
    13c8:	17fd                	addi	a5,a5,-1
    13ca:	8ff9                	and	a5,a5,a4
    13cc:	6705                	lui	a4,0x1
    13ce:	40f707b3          	sub	a5,a4,a5
    13d2:	fe843703          	ld	a4,-24(s0)
    13d6:	97ba                	add	a5,a5,a4
    13d8:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
    13dc:	fe843603          	ld	a2,-24(s0)
    13e0:	fd043583          	ld	a1,-48(s0)
    13e4:	fd843503          	ld	a0,-40(s0)
    13e8:	fffff097          	auipc	ra,0xfffff
    13ec:	7bc080e7          	jalr	1980(ra) # ba4 <clone>
    13f0:	87aa                	mv	a5,a0
}
    13f2:	853e                	mv	a0,a5
    13f4:	70a2                	ld	ra,40(sp)
    13f6:	7402                	ld	s0,32(sp)
    13f8:	6145                	addi	sp,sp,48
    13fa:	8082                	ret

00000000000013fc <thread_join>:


int thread_join()
{
    13fc:	1101                	addi	sp,sp,-32
    13fe:	ec06                	sd	ra,24(sp)
    1400:	e822                	sd	s0,16(sp)
    1402:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
    1404:	fe040793          	addi	a5,s0,-32
    1408:	853e                	mv	a0,a5
    140a:	fffff097          	auipc	ra,0xfffff
    140e:	7a2080e7          	jalr	1954(ra) # bac <join>
    1412:	87aa                	mv	a5,a0
    1414:	fef42623          	sw	a5,-20(s0)
    1418:	fec42783          	lw	a5,-20(s0)
    141c:	0007871b          	sext.w	a4,a5
    1420:	57fd                	li	a5,-1
    1422:	00f70963          	beq	a4,a5,1434 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
    1426:	fe043783          	ld	a5,-32(s0)
    142a:	853e                	mv	a0,a5
    142c:	00000097          	auipc	ra,0x0
    1430:	c60080e7          	jalr	-928(ra) # 108c <free>
    } 

    return child_tid;
    1434:	fec42783          	lw	a5,-20(s0)
}
    1438:	853e                	mv	a0,a5
    143a:	60e2                	ld	ra,24(sp)
    143c:	6442                	ld	s0,16(sp)
    143e:	6105                	addi	sp,sp,32
    1440:	8082                	ret

0000000000001442 <lock_acquire>:


void lock_acquire (lock_t *)
{
    1442:	1101                	addi	sp,sp,-32
    1444:	ec22                	sd	s0,24(sp)
    1446:	1000                	addi	s0,sp,32
    1448:	fea43423          	sd	a0,-24(s0)

}
    144c:	0001                	nop
    144e:	6462                	ld	s0,24(sp)
    1450:	6105                	addi	sp,sp,32
    1452:	8082                	ret

0000000000001454 <lock_release>:

void lock_release (lock_t *)
{
    1454:	1101                	addi	sp,sp,-32
    1456:	ec22                	sd	s0,24(sp)
    1458:	1000                	addi	s0,sp,32
    145a:	fea43423          	sd	a0,-24(s0)
    
}
    145e:	0001                	nop
    1460:	6462                	ld	s0,24(sp)
    1462:	6105                	addi	sp,sp,32
    1464:	8082                	ret

0000000000001466 <lock_init>:

void lock_init (lock_t *)
{
    1466:	1101                	addi	sp,sp,-32
    1468:	ec22                	sd	s0,24(sp)
    146a:	1000                	addi	s0,sp,32
    146c:	fea43423          	sd	a0,-24(s0)
    
}
    1470:	0001                	nop
    1472:	6462                	ld	s0,24(sp)
    1474:	6105                	addi	sp,sp,32
    1476:	8082                	ret
