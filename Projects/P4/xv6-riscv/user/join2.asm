
user/_join2:     file format elf64-littleriscv


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
      16:	9e4080e7          	jalr	-1564(ra) # 9f6 <getpid>
      1a:	87aa                	mv	a5,a0
      1c:	873e                	mv	a4,a5
      1e:	00001797          	auipc	a5,0x1
      22:	4ba78793          	addi	a5,a5,1210 # 14d8 <ppid>
      26:	c398                	sw	a4,0(a5)
    //alocatadas dos paginas y alineadas a página
   void *stack = malloc(PGSIZE*2);
      28:	6509                	lui	a0,0x2
      2a:	00001097          	auipc	ra,0x1
      2e:	076080e7          	jalr	118(ra) # 10a0 <malloc>
      32:	fea43423          	sd	a0,-24(s0)
   assert(stack != NULL);
      36:	fe843783          	ld	a5,-24(s0)
      3a:	e3ad                	bnez	a5,9c <main+0x9c>
      3c:	4675                	li	a2,29
      3e:	00001597          	auipc	a1,0x1
      42:	2b258593          	addi	a1,a1,690 # 12f0 <lock_init+0x18>
      46:	00001517          	auipc	a0,0x1
      4a:	2ba50513          	addi	a0,a0,698 # 1300 <lock_init+0x28>
      4e:	00001097          	auipc	ra,0x1
      52:	e60080e7          	jalr	-416(ra) # eae <printf>
      56:	00001597          	auipc	a1,0x1
      5a:	2b258593          	addi	a1,a1,690 # 1308 <lock_init+0x30>
      5e:	00001517          	auipc	a0,0x1
      62:	2ba50513          	addi	a0,a0,698 # 1318 <lock_init+0x40>
      66:	00001097          	auipc	ra,0x1
      6a:	e48080e7          	jalr	-440(ra) # eae <printf>
      6e:	00001517          	auipc	a0,0x1
      72:	2c250513          	addi	a0,a0,706 # 1330 <lock_init+0x58>
      76:	00001097          	auipc	ra,0x1
      7a:	e38080e7          	jalr	-456(ra) # eae <printf>
      7e:	00001797          	auipc	a5,0x1
      82:	45a78793          	addi	a5,a5,1114 # 14d8 <ppid>
      86:	439c                	lw	a5,0(a5)
      88:	853e                	mv	a0,a5
      8a:	00001097          	auipc	ra,0x1
      8e:	91c080e7          	jalr	-1764(ra) # 9a6 <kill>
      92:	4501                	li	a0,0
      94:	00001097          	auipc	ra,0x1
      98:	8e2080e7          	jalr	-1822(ra) # 976 <exit>
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

   printf ("Valor de stack: %d\n", stack); 
      c2:	fe843583          	ld	a1,-24(s0)
      c6:	00001517          	auipc	a0,0x1
      ca:	27a50513          	addi	a0,a0,634 # 1340 <lock_init+0x68>
      ce:	00001097          	auipc	ra,0x1
      d2:	de0080e7          	jalr	-544(ra) # eae <printf>

  

   //el argumento a pasar es 42
   int arg = 42;
      d6:	02a00793          	li	a5,42
      da:	fcf42a23          	sw	a5,-44(s0)
   int clone_pid = clone(worker, &arg, stack);
      de:	fd440793          	addi	a5,s0,-44
      e2:	fe843603          	ld	a2,-24(s0)
      e6:	85be                	mv	a1,a5
      e8:	00000517          	auipc	a0,0x0
      ec:	2dc50513          	addi	a0,a0,732 # 3c4 <worker>
      f0:	00001097          	auipc	ra,0x1
      f4:	926080e7          	jalr	-1754(ra) # a16 <clone>
      f8:	87aa                	mv	a5,a0
      fa:	fef42223          	sw	a5,-28(s0)
   assert(clone_pid > 0);
      fe:	fe442783          	lw	a5,-28(s0)
     102:	2781                	sext.w	a5,a5
     104:	06f04363          	bgtz	a5,16a <main+0x16a>
     108:	02800613          	li	a2,40
     10c:	00001597          	auipc	a1,0x1
     110:	1e458593          	addi	a1,a1,484 # 12f0 <lock_init+0x18>
     114:	00001517          	auipc	a0,0x1
     118:	1ec50513          	addi	a0,a0,492 # 1300 <lock_init+0x28>
     11c:	00001097          	auipc	ra,0x1
     120:	d92080e7          	jalr	-622(ra) # eae <printf>
     124:	00001597          	auipc	a1,0x1
     128:	23458593          	addi	a1,a1,564 # 1358 <lock_init+0x80>
     12c:	00001517          	auipc	a0,0x1
     130:	1ec50513          	addi	a0,a0,492 # 1318 <lock_init+0x40>
     134:	00001097          	auipc	ra,0x1
     138:	d7a080e7          	jalr	-646(ra) # eae <printf>
     13c:	00001517          	auipc	a0,0x1
     140:	1f450513          	addi	a0,a0,500 # 1330 <lock_init+0x58>
     144:	00001097          	auipc	ra,0x1
     148:	d6a080e7          	jalr	-662(ra) # eae <printf>
     14c:	00001797          	auipc	a5,0x1
     150:	38c78793          	addi	a5,a5,908 # 14d8 <ppid>
     154:	439c                	lw	a5,0(a5)
     156:	853e                	mv	a0,a5
     158:	00001097          	auipc	ra,0x1
     15c:	84e080e7          	jalr	-1970(ra) # 9a6 <kill>
     160:	4501                	li	a0,0
     162:	00001097          	auipc	ra,0x1
     166:	814080e7          	jalr	-2028(ra) # 976 <exit>
    dirección no es alineada a word.

   
   */

   sbrk(PGSIZE); 
     16a:	6505                	lui	a0,0x1
     16c:	00001097          	auipc	ra,0x1
     170:	892080e7          	jalr	-1902(ra) # 9fe <sbrk>
   printf ("Asignación join_stack: %d\n", (uint64)sbrk(0) - 8);
     174:	4501                	li	a0,0
     176:	00001097          	auipc	ra,0x1
     17a:	888080e7          	jalr	-1912(ra) # 9fe <sbrk>
     17e:	87aa                	mv	a5,a0
     180:	17e1                	addi	a5,a5,-8
     182:	85be                	mv	a1,a5
     184:	00001517          	auipc	a0,0x1
     188:	1e450513          	addi	a0,a0,484 # 1368 <lock_init+0x90>
     18c:	00001097          	auipc	ra,0x1
     190:	d22080e7          	jalr	-734(ra) # eae <printf>
   void **join_stack = (void**) ((uint64)sbrk(0) - 8);
     194:	4501                	li	a0,0
     196:	00001097          	auipc	ra,0x1
     19a:	868080e7          	jalr	-1944(ra) # 9fe <sbrk>
     19e:	87aa                	mv	a5,a0
     1a0:	17e1                	addi	a5,a5,-8
     1a2:	fcf43c23          	sd	a5,-40(s0)
      
   
   assert(join((void**)((uint64)join_stack +2)) == -1); // +2
     1a6:	fd843783          	ld	a5,-40(s0)
     1aa:	0789                	addi	a5,a5,2
     1ac:	853e                	mv	a0,a5
     1ae:	00001097          	auipc	ra,0x1
     1b2:	870080e7          	jalr	-1936(ra) # a1e <join>
     1b6:	87aa                	mv	a5,a0
     1b8:	873e                	mv	a4,a5
     1ba:	57fd                	li	a5,-1
     1bc:	06f70363          	beq	a4,a5,222 <main+0x222>
     1c0:	05200613          	li	a2,82
     1c4:	00001597          	auipc	a1,0x1
     1c8:	12c58593          	addi	a1,a1,300 # 12f0 <lock_init+0x18>
     1cc:	00001517          	auipc	a0,0x1
     1d0:	13450513          	addi	a0,a0,308 # 1300 <lock_init+0x28>
     1d4:	00001097          	auipc	ra,0x1
     1d8:	cda080e7          	jalr	-806(ra) # eae <printf>
     1dc:	00001597          	auipc	a1,0x1
     1e0:	1ac58593          	addi	a1,a1,428 # 1388 <lock_init+0xb0>
     1e4:	00001517          	auipc	a0,0x1
     1e8:	13450513          	addi	a0,a0,308 # 1318 <lock_init+0x40>
     1ec:	00001097          	auipc	ra,0x1
     1f0:	cc2080e7          	jalr	-830(ra) # eae <printf>
     1f4:	00001517          	auipc	a0,0x1
     1f8:	13c50513          	addi	a0,a0,316 # 1330 <lock_init+0x58>
     1fc:	00001097          	auipc	ra,0x1
     200:	cb2080e7          	jalr	-846(ra) # eae <printf>
     204:	00001797          	auipc	a5,0x1
     208:	2d478793          	addi	a5,a5,724 # 14d8 <ppid>
     20c:	439c                	lw	a5,0(a5)
     20e:	853e                	mv	a0,a5
     210:	00000097          	auipc	ra,0x0
     214:	796080e7          	jalr	1942(ra) # 9a6 <kill>
     218:	4501                	li	a0,0
     21a:	00000097          	auipc	ra,0x0
     21e:	75c080e7          	jalr	1884(ra) # 976 <exit>
   printf ("Primer join pasado.\n");
     222:	00001517          	auipc	a0,0x1
     226:	19650513          	addi	a0,a0,406 # 13b8 <lock_init+0xe0>
     22a:	00001097          	auipc	ra,0x1
     22e:	c84080e7          	jalr	-892(ra) # eae <printf>

   assert(join(join_stack) == clone_pid); //devuelve -1
     232:	fd843503          	ld	a0,-40(s0)
     236:	00000097          	auipc	ra,0x0
     23a:	7e8080e7          	jalr	2024(ra) # a1e <join>
     23e:	87aa                	mv	a5,a0
     240:	873e                	mv	a4,a5
     242:	fe442783          	lw	a5,-28(s0)
     246:	2781                	sext.w	a5,a5
     248:	06e78363          	beq	a5,a4,2ae <main+0x2ae>
     24c:	05500613          	li	a2,85
     250:	00001597          	auipc	a1,0x1
     254:	0a058593          	addi	a1,a1,160 # 12f0 <lock_init+0x18>
     258:	00001517          	auipc	a0,0x1
     25c:	0a850513          	addi	a0,a0,168 # 1300 <lock_init+0x28>
     260:	00001097          	auipc	ra,0x1
     264:	c4e080e7          	jalr	-946(ra) # eae <printf>
     268:	00001597          	auipc	a1,0x1
     26c:	16858593          	addi	a1,a1,360 # 13d0 <lock_init+0xf8>
     270:	00001517          	auipc	a0,0x1
     274:	0a850513          	addi	a0,a0,168 # 1318 <lock_init+0x40>
     278:	00001097          	auipc	ra,0x1
     27c:	c36080e7          	jalr	-970(ra) # eae <printf>
     280:	00001517          	auipc	a0,0x1
     284:	0b050513          	addi	a0,a0,176 # 1330 <lock_init+0x58>
     288:	00001097          	auipc	ra,0x1
     28c:	c26080e7          	jalr	-986(ra) # eae <printf>
     290:	00001797          	auipc	a5,0x1
     294:	24878793          	addi	a5,a5,584 # 14d8 <ppid>
     298:	439c                	lw	a5,0(a5)
     29a:	853e                	mv	a0,a5
     29c:	00000097          	auipc	ra,0x0
     2a0:	70a080e7          	jalr	1802(ra) # 9a6 <kill>
     2a4:	4501                	li	a0,0
     2a6:	00000097          	auipc	ra,0x0
     2aa:	6d0080e7          	jalr	1744(ra) # 976 <exit>

   printf ("Join stack aqui vale: %d\n", *join_stack);
     2ae:	fd843783          	ld	a5,-40(s0)
     2b2:	639c                	ld	a5,0(a5)
     2b4:	85be                	mv	a1,a5
     2b6:	00001517          	auipc	a0,0x1
     2ba:	13a50513          	addi	a0,a0,314 # 13f0 <lock_init+0x118>
     2be:	00001097          	auipc	ra,0x1
     2c2:	bf0080e7          	jalr	-1040(ra) # eae <printf>

   assert(stack == *join_stack);
     2c6:	fd843783          	ld	a5,-40(s0)
     2ca:	639c                	ld	a5,0(a5)
     2cc:	fe843703          	ld	a4,-24(s0)
     2d0:	06f70363          	beq	a4,a5,336 <main+0x336>
     2d4:	05900613          	li	a2,89
     2d8:	00001597          	auipc	a1,0x1
     2dc:	01858593          	addi	a1,a1,24 # 12f0 <lock_init+0x18>
     2e0:	00001517          	auipc	a0,0x1
     2e4:	02050513          	addi	a0,a0,32 # 1300 <lock_init+0x28>
     2e8:	00001097          	auipc	ra,0x1
     2ec:	bc6080e7          	jalr	-1082(ra) # eae <printf>
     2f0:	00001597          	auipc	a1,0x1
     2f4:	12058593          	addi	a1,a1,288 # 1410 <lock_init+0x138>
     2f8:	00001517          	auipc	a0,0x1
     2fc:	02050513          	addi	a0,a0,32 # 1318 <lock_init+0x40>
     300:	00001097          	auipc	ra,0x1
     304:	bae080e7          	jalr	-1106(ra) # eae <printf>
     308:	00001517          	auipc	a0,0x1
     30c:	02850513          	addi	a0,a0,40 # 1330 <lock_init+0x58>
     310:	00001097          	auipc	ra,0x1
     314:	b9e080e7          	jalr	-1122(ra) # eae <printf>
     318:	00001797          	auipc	a5,0x1
     31c:	1c078793          	addi	a5,a5,448 # 14d8 <ppid>
     320:	439c                	lw	a5,0(a5)
     322:	853e                	mv	a0,a5
     324:	00000097          	auipc	ra,0x0
     328:	682080e7          	jalr	1666(ra) # 9a6 <kill>
     32c:	4501                	li	a0,0
     32e:	00000097          	auipc	ra,0x0
     332:	648080e7          	jalr	1608(ra) # 976 <exit>
   assert(global == 2);
     336:	00001797          	auipc	a5,0x1
     33a:	19e78793          	addi	a5,a5,414 # 14d4 <global>
     33e:	439c                	lw	a5,0(a5)
     340:	873e                	mv	a4,a5
     342:	4789                	li	a5,2
     344:	06f70363          	beq	a4,a5,3aa <main+0x3aa>
     348:	05a00613          	li	a2,90
     34c:	00001597          	auipc	a1,0x1
     350:	fa458593          	addi	a1,a1,-92 # 12f0 <lock_init+0x18>
     354:	00001517          	auipc	a0,0x1
     358:	fac50513          	addi	a0,a0,-84 # 1300 <lock_init+0x28>
     35c:	00001097          	auipc	ra,0x1
     360:	b52080e7          	jalr	-1198(ra) # eae <printf>
     364:	00001597          	auipc	a1,0x1
     368:	0c458593          	addi	a1,a1,196 # 1428 <lock_init+0x150>
     36c:	00001517          	auipc	a0,0x1
     370:	fac50513          	addi	a0,a0,-84 # 1318 <lock_init+0x40>
     374:	00001097          	auipc	ra,0x1
     378:	b3a080e7          	jalr	-1222(ra) # eae <printf>
     37c:	00001517          	auipc	a0,0x1
     380:	fb450513          	addi	a0,a0,-76 # 1330 <lock_init+0x58>
     384:	00001097          	auipc	ra,0x1
     388:	b2a080e7          	jalr	-1238(ra) # eae <printf>
     38c:	00001797          	auipc	a5,0x1
     390:	14c78793          	addi	a5,a5,332 # 14d8 <ppid>
     394:	439c                	lw	a5,0(a5)
     396:	853e                	mv	a0,a5
     398:	00000097          	auipc	ra,0x0
     39c:	60e080e7          	jalr	1550(ra) # 9a6 <kill>
     3a0:	4501                	li	a0,0
     3a2:	00000097          	auipc	ra,0x0
     3a6:	5d4080e7          	jalr	1492(ra) # 976 <exit>

   printf("TEST PASSED\n");
     3aa:	00001517          	auipc	a0,0x1
     3ae:	08e50513          	addi	a0,a0,142 # 1438 <lock_init+0x160>
     3b2:	00001097          	auipc	ra,0x1
     3b6:	afc080e7          	jalr	-1284(ra) # eae <printf>
   exit(0);
     3ba:	4501                	li	a0,0
     3bc:	00000097          	auipc	ra,0x0
     3c0:	5ba080e7          	jalr	1466(ra) # 976 <exit>

00000000000003c4 <worker>:
}

void
worker(void *arg_ptr) {
     3c4:	7179                	addi	sp,sp,-48
     3c6:	f406                	sd	ra,40(sp)
     3c8:	f022                	sd	s0,32(sp)
     3ca:	1800                	addi	s0,sp,48
     3cc:	fca43c23          	sd	a0,-40(s0)
   int arg = *(int*)arg_ptr;
     3d0:	fd843783          	ld	a5,-40(s0)
     3d4:	439c                	lw	a5,0(a5)
     3d6:	fef42623          	sw	a5,-20(s0)
   //printf ("WORKER: arg = %d\n", arg); //debe haber recogido el argumento correctamente y valer 42
   assert(arg == 42);
     3da:	fec42783          	lw	a5,-20(s0)
     3de:	0007871b          	sext.w	a4,a5
     3e2:	02a00793          	li	a5,42
     3e6:	06f70363          	beq	a4,a5,44c <worker+0x88>
     3ea:	06400613          	li	a2,100
     3ee:	00001597          	auipc	a1,0x1
     3f2:	f0258593          	addi	a1,a1,-254 # 12f0 <lock_init+0x18>
     3f6:	00001517          	auipc	a0,0x1
     3fa:	f0a50513          	addi	a0,a0,-246 # 1300 <lock_init+0x28>
     3fe:	00001097          	auipc	ra,0x1
     402:	ab0080e7          	jalr	-1360(ra) # eae <printf>
     406:	00001597          	auipc	a1,0x1
     40a:	04258593          	addi	a1,a1,66 # 1448 <lock_init+0x170>
     40e:	00001517          	auipc	a0,0x1
     412:	f0a50513          	addi	a0,a0,-246 # 1318 <lock_init+0x40>
     416:	00001097          	auipc	ra,0x1
     41a:	a98080e7          	jalr	-1384(ra) # eae <printf>
     41e:	00001517          	auipc	a0,0x1
     422:	f1250513          	addi	a0,a0,-238 # 1330 <lock_init+0x58>
     426:	00001097          	auipc	ra,0x1
     42a:	a88080e7          	jalr	-1400(ra) # eae <printf>
     42e:	00001797          	auipc	a5,0x1
     432:	0aa78793          	addi	a5,a5,170 # 14d8 <ppid>
     436:	439c                	lw	a5,0(a5)
     438:	853e                	mv	a0,a5
     43a:	00000097          	auipc	ra,0x0
     43e:	56c080e7          	jalr	1388(ra) # 9a6 <kill>
     442:	4501                	li	a0,0
     444:	00000097          	auipc	ra,0x0
     448:	532080e7          	jalr	1330(ra) # 976 <exit>
   assert(global == 1);
     44c:	00001797          	auipc	a5,0x1
     450:	08878793          	addi	a5,a5,136 # 14d4 <global>
     454:	439c                	lw	a5,0(a5)
     456:	873e                	mv	a4,a5
     458:	4785                	li	a5,1
     45a:	06f70363          	beq	a4,a5,4c0 <worker+0xfc>
     45e:	06500613          	li	a2,101
     462:	00001597          	auipc	a1,0x1
     466:	e8e58593          	addi	a1,a1,-370 # 12f0 <lock_init+0x18>
     46a:	00001517          	auipc	a0,0x1
     46e:	e9650513          	addi	a0,a0,-362 # 1300 <lock_init+0x28>
     472:	00001097          	auipc	ra,0x1
     476:	a3c080e7          	jalr	-1476(ra) # eae <printf>
     47a:	00001597          	auipc	a1,0x1
     47e:	fde58593          	addi	a1,a1,-34 # 1458 <lock_init+0x180>
     482:	00001517          	auipc	a0,0x1
     486:	e9650513          	addi	a0,a0,-362 # 1318 <lock_init+0x40>
     48a:	00001097          	auipc	ra,0x1
     48e:	a24080e7          	jalr	-1500(ra) # eae <printf>
     492:	00001517          	auipc	a0,0x1
     496:	e9e50513          	addi	a0,a0,-354 # 1330 <lock_init+0x58>
     49a:	00001097          	auipc	ra,0x1
     49e:	a14080e7          	jalr	-1516(ra) # eae <printf>
     4a2:	00001797          	auipc	a5,0x1
     4a6:	03678793          	addi	a5,a5,54 # 14d8 <ppid>
     4aa:	439c                	lw	a5,0(a5)
     4ac:	853e                	mv	a0,a5
     4ae:	00000097          	auipc	ra,0x0
     4b2:	4f8080e7          	jalr	1272(ra) # 9a6 <kill>
     4b6:	4501                	li	a0,0
     4b8:	00000097          	auipc	ra,0x0
     4bc:	4be080e7          	jalr	1214(ra) # 976 <exit>
   global++;
     4c0:	00001797          	auipc	a5,0x1
     4c4:	01478793          	addi	a5,a5,20 # 14d4 <global>
     4c8:	439c                	lw	a5,0(a5)
     4ca:	2785                	addiw	a5,a5,1
     4cc:	0007871b          	sext.w	a4,a5
     4d0:	00001797          	auipc	a5,0x1
     4d4:	00478793          	addi	a5,a5,4 # 14d4 <global>
     4d8:	c398                	sw	a4,0(a5)
   exit(0);
     4da:	4501                	li	a0,0
     4dc:	00000097          	auipc	ra,0x0
     4e0:	49a080e7          	jalr	1178(ra) # 976 <exit>

00000000000004e4 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     4e4:	7179                	addi	sp,sp,-48
     4e6:	f422                	sd	s0,40(sp)
     4e8:	1800                	addi	s0,sp,48
     4ea:	fca43c23          	sd	a0,-40(s0)
     4ee:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     4f2:	fd843783          	ld	a5,-40(s0)
     4f6:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     4fa:	0001                	nop
     4fc:	fd043703          	ld	a4,-48(s0)
     500:	00170793          	addi	a5,a4,1 # 1001 <free+0x103>
     504:	fcf43823          	sd	a5,-48(s0)
     508:	fd843783          	ld	a5,-40(s0)
     50c:	00178693          	addi	a3,a5,1
     510:	fcd43c23          	sd	a3,-40(s0)
     514:	00074703          	lbu	a4,0(a4)
     518:	00e78023          	sb	a4,0(a5)
     51c:	0007c783          	lbu	a5,0(a5)
     520:	fff1                	bnez	a5,4fc <strcpy+0x18>
    ;
  return os;
     522:	fe843783          	ld	a5,-24(s0)
}
     526:	853e                	mv	a0,a5
     528:	7422                	ld	s0,40(sp)
     52a:	6145                	addi	sp,sp,48
     52c:	8082                	ret

000000000000052e <strcmp>:

int
strcmp(const char *p, const char *q)
{
     52e:	1101                	addi	sp,sp,-32
     530:	ec22                	sd	s0,24(sp)
     532:	1000                	addi	s0,sp,32
     534:	fea43423          	sd	a0,-24(s0)
     538:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     53c:	a819                	j	552 <strcmp+0x24>
    p++, q++;
     53e:	fe843783          	ld	a5,-24(s0)
     542:	0785                	addi	a5,a5,1
     544:	fef43423          	sd	a5,-24(s0)
     548:	fe043783          	ld	a5,-32(s0)
     54c:	0785                	addi	a5,a5,1
     54e:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     552:	fe843783          	ld	a5,-24(s0)
     556:	0007c783          	lbu	a5,0(a5)
     55a:	cb99                	beqz	a5,570 <strcmp+0x42>
     55c:	fe843783          	ld	a5,-24(s0)
     560:	0007c703          	lbu	a4,0(a5)
     564:	fe043783          	ld	a5,-32(s0)
     568:	0007c783          	lbu	a5,0(a5)
     56c:	fcf709e3          	beq	a4,a5,53e <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     570:	fe843783          	ld	a5,-24(s0)
     574:	0007c783          	lbu	a5,0(a5)
     578:	0007871b          	sext.w	a4,a5
     57c:	fe043783          	ld	a5,-32(s0)
     580:	0007c783          	lbu	a5,0(a5)
     584:	2781                	sext.w	a5,a5
     586:	40f707bb          	subw	a5,a4,a5
     58a:	2781                	sext.w	a5,a5
}
     58c:	853e                	mv	a0,a5
     58e:	6462                	ld	s0,24(sp)
     590:	6105                	addi	sp,sp,32
     592:	8082                	ret

0000000000000594 <strlen>:

uint
strlen(const char *s)
{
     594:	7179                	addi	sp,sp,-48
     596:	f422                	sd	s0,40(sp)
     598:	1800                	addi	s0,sp,48
     59a:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     59e:	fe042623          	sw	zero,-20(s0)
     5a2:	a031                	j	5ae <strlen+0x1a>
     5a4:	fec42783          	lw	a5,-20(s0)
     5a8:	2785                	addiw	a5,a5,1
     5aa:	fef42623          	sw	a5,-20(s0)
     5ae:	fec42783          	lw	a5,-20(s0)
     5b2:	fd843703          	ld	a4,-40(s0)
     5b6:	97ba                	add	a5,a5,a4
     5b8:	0007c783          	lbu	a5,0(a5)
     5bc:	f7e5                	bnez	a5,5a4 <strlen+0x10>
    ;
  return n;
     5be:	fec42783          	lw	a5,-20(s0)
}
     5c2:	853e                	mv	a0,a5
     5c4:	7422                	ld	s0,40(sp)
     5c6:	6145                	addi	sp,sp,48
     5c8:	8082                	ret

00000000000005ca <memset>:

void*
memset(void *dst, int c, uint n)
{
     5ca:	7179                	addi	sp,sp,-48
     5cc:	f422                	sd	s0,40(sp)
     5ce:	1800                	addi	s0,sp,48
     5d0:	fca43c23          	sd	a0,-40(s0)
     5d4:	87ae                	mv	a5,a1
     5d6:	8732                	mv	a4,a2
     5d8:	fcf42a23          	sw	a5,-44(s0)
     5dc:	87ba                	mv	a5,a4
     5de:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     5e2:	fd843783          	ld	a5,-40(s0)
     5e6:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     5ea:	fe042623          	sw	zero,-20(s0)
     5ee:	a00d                	j	610 <memset+0x46>
    cdst[i] = c;
     5f0:	fec42783          	lw	a5,-20(s0)
     5f4:	fe043703          	ld	a4,-32(s0)
     5f8:	97ba                	add	a5,a5,a4
     5fa:	fd442703          	lw	a4,-44(s0)
     5fe:	0ff77713          	zext.b	a4,a4
     602:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     606:	fec42783          	lw	a5,-20(s0)
     60a:	2785                	addiw	a5,a5,1
     60c:	fef42623          	sw	a5,-20(s0)
     610:	fec42703          	lw	a4,-20(s0)
     614:	fd042783          	lw	a5,-48(s0)
     618:	2781                	sext.w	a5,a5
     61a:	fcf76be3          	bltu	a4,a5,5f0 <memset+0x26>
  }
  return dst;
     61e:	fd843783          	ld	a5,-40(s0)
}
     622:	853e                	mv	a0,a5
     624:	7422                	ld	s0,40(sp)
     626:	6145                	addi	sp,sp,48
     628:	8082                	ret

000000000000062a <strchr>:

char*
strchr(const char *s, char c)
{
     62a:	1101                	addi	sp,sp,-32
     62c:	ec22                	sd	s0,24(sp)
     62e:	1000                	addi	s0,sp,32
     630:	fea43423          	sd	a0,-24(s0)
     634:	87ae                	mv	a5,a1
     636:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     63a:	a01d                	j	660 <strchr+0x36>
    if(*s == c)
     63c:	fe843783          	ld	a5,-24(s0)
     640:	0007c703          	lbu	a4,0(a5)
     644:	fe744783          	lbu	a5,-25(s0)
     648:	0ff7f793          	zext.b	a5,a5
     64c:	00e79563          	bne	a5,a4,656 <strchr+0x2c>
      return (char*)s;
     650:	fe843783          	ld	a5,-24(s0)
     654:	a821                	j	66c <strchr+0x42>
  for(; *s; s++)
     656:	fe843783          	ld	a5,-24(s0)
     65a:	0785                	addi	a5,a5,1
     65c:	fef43423          	sd	a5,-24(s0)
     660:	fe843783          	ld	a5,-24(s0)
     664:	0007c783          	lbu	a5,0(a5)
     668:	fbf1                	bnez	a5,63c <strchr+0x12>
  return 0;
     66a:	4781                	li	a5,0
}
     66c:	853e                	mv	a0,a5
     66e:	6462                	ld	s0,24(sp)
     670:	6105                	addi	sp,sp,32
     672:	8082                	ret

0000000000000674 <gets>:

char*
gets(char *buf, int max)
{
     674:	7179                	addi	sp,sp,-48
     676:	f406                	sd	ra,40(sp)
     678:	f022                	sd	s0,32(sp)
     67a:	1800                	addi	s0,sp,48
     67c:	fca43c23          	sd	a0,-40(s0)
     680:	87ae                	mv	a5,a1
     682:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     686:	fe042623          	sw	zero,-20(s0)
     68a:	a8a1                	j	6e2 <gets+0x6e>
    cc = read(0, &c, 1);
     68c:	fe740793          	addi	a5,s0,-25
     690:	4605                	li	a2,1
     692:	85be                	mv	a1,a5
     694:	4501                	li	a0,0
     696:	00000097          	auipc	ra,0x0
     69a:	2f8080e7          	jalr	760(ra) # 98e <read>
     69e:	87aa                	mv	a5,a0
     6a0:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     6a4:	fe842783          	lw	a5,-24(s0)
     6a8:	2781                	sext.w	a5,a5
     6aa:	04f05763          	blez	a5,6f8 <gets+0x84>
      break;
    buf[i++] = c;
     6ae:	fec42783          	lw	a5,-20(s0)
     6b2:	0017871b          	addiw	a4,a5,1
     6b6:	fee42623          	sw	a4,-20(s0)
     6ba:	873e                	mv	a4,a5
     6bc:	fd843783          	ld	a5,-40(s0)
     6c0:	97ba                	add	a5,a5,a4
     6c2:	fe744703          	lbu	a4,-25(s0)
     6c6:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     6ca:	fe744783          	lbu	a5,-25(s0)
     6ce:	873e                	mv	a4,a5
     6d0:	47a9                	li	a5,10
     6d2:	02f70463          	beq	a4,a5,6fa <gets+0x86>
     6d6:	fe744783          	lbu	a5,-25(s0)
     6da:	873e                	mv	a4,a5
     6dc:	47b5                	li	a5,13
     6de:	00f70e63          	beq	a4,a5,6fa <gets+0x86>
  for(i=0; i+1 < max; ){
     6e2:	fec42783          	lw	a5,-20(s0)
     6e6:	2785                	addiw	a5,a5,1
     6e8:	0007871b          	sext.w	a4,a5
     6ec:	fd442783          	lw	a5,-44(s0)
     6f0:	2781                	sext.w	a5,a5
     6f2:	f8f74de3          	blt	a4,a5,68c <gets+0x18>
     6f6:	a011                	j	6fa <gets+0x86>
      break;
     6f8:	0001                	nop
      break;
  }
  buf[i] = '\0';
     6fa:	fec42783          	lw	a5,-20(s0)
     6fe:	fd843703          	ld	a4,-40(s0)
     702:	97ba                	add	a5,a5,a4
     704:	00078023          	sb	zero,0(a5)
  return buf;
     708:	fd843783          	ld	a5,-40(s0)
}
     70c:	853e                	mv	a0,a5
     70e:	70a2                	ld	ra,40(sp)
     710:	7402                	ld	s0,32(sp)
     712:	6145                	addi	sp,sp,48
     714:	8082                	ret

0000000000000716 <stat>:

int
stat(const char *n, struct stat *st)
{
     716:	7179                	addi	sp,sp,-48
     718:	f406                	sd	ra,40(sp)
     71a:	f022                	sd	s0,32(sp)
     71c:	1800                	addi	s0,sp,48
     71e:	fca43c23          	sd	a0,-40(s0)
     722:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     726:	4581                	li	a1,0
     728:	fd843503          	ld	a0,-40(s0)
     72c:	00000097          	auipc	ra,0x0
     730:	28a080e7          	jalr	650(ra) # 9b6 <open>
     734:	87aa                	mv	a5,a0
     736:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     73a:	fec42783          	lw	a5,-20(s0)
     73e:	2781                	sext.w	a5,a5
     740:	0007d463          	bgez	a5,748 <stat+0x32>
    return -1;
     744:	57fd                	li	a5,-1
     746:	a035                	j	772 <stat+0x5c>
  r = fstat(fd, st);
     748:	fec42783          	lw	a5,-20(s0)
     74c:	fd043583          	ld	a1,-48(s0)
     750:	853e                	mv	a0,a5
     752:	00000097          	auipc	ra,0x0
     756:	27c080e7          	jalr	636(ra) # 9ce <fstat>
     75a:	87aa                	mv	a5,a0
     75c:	fef42423          	sw	a5,-24(s0)
  close(fd);
     760:	fec42783          	lw	a5,-20(s0)
     764:	853e                	mv	a0,a5
     766:	00000097          	auipc	ra,0x0
     76a:	238080e7          	jalr	568(ra) # 99e <close>
  return r;
     76e:	fe842783          	lw	a5,-24(s0)
}
     772:	853e                	mv	a0,a5
     774:	70a2                	ld	ra,40(sp)
     776:	7402                	ld	s0,32(sp)
     778:	6145                	addi	sp,sp,48
     77a:	8082                	ret

000000000000077c <atoi>:

int
atoi(const char *s)
{
     77c:	7179                	addi	sp,sp,-48
     77e:	f422                	sd	s0,40(sp)
     780:	1800                	addi	s0,sp,48
     782:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     786:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     78a:	a81d                	j	7c0 <atoi+0x44>
    n = n*10 + *s++ - '0';
     78c:	fec42783          	lw	a5,-20(s0)
     790:	873e                	mv	a4,a5
     792:	87ba                	mv	a5,a4
     794:	0027979b          	slliw	a5,a5,0x2
     798:	9fb9                	addw	a5,a5,a4
     79a:	0017979b          	slliw	a5,a5,0x1
     79e:	0007871b          	sext.w	a4,a5
     7a2:	fd843783          	ld	a5,-40(s0)
     7a6:	00178693          	addi	a3,a5,1
     7aa:	fcd43c23          	sd	a3,-40(s0)
     7ae:	0007c783          	lbu	a5,0(a5)
     7b2:	2781                	sext.w	a5,a5
     7b4:	9fb9                	addw	a5,a5,a4
     7b6:	2781                	sext.w	a5,a5
     7b8:	fd07879b          	addiw	a5,a5,-48
     7bc:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     7c0:	fd843783          	ld	a5,-40(s0)
     7c4:	0007c783          	lbu	a5,0(a5)
     7c8:	873e                	mv	a4,a5
     7ca:	02f00793          	li	a5,47
     7ce:	00e7fb63          	bgeu	a5,a4,7e4 <atoi+0x68>
     7d2:	fd843783          	ld	a5,-40(s0)
     7d6:	0007c783          	lbu	a5,0(a5)
     7da:	873e                	mv	a4,a5
     7dc:	03900793          	li	a5,57
     7e0:	fae7f6e3          	bgeu	a5,a4,78c <atoi+0x10>
  return n;
     7e4:	fec42783          	lw	a5,-20(s0)
}
     7e8:	853e                	mv	a0,a5
     7ea:	7422                	ld	s0,40(sp)
     7ec:	6145                	addi	sp,sp,48
     7ee:	8082                	ret

00000000000007f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     7f0:	7139                	addi	sp,sp,-64
     7f2:	fc22                	sd	s0,56(sp)
     7f4:	0080                	addi	s0,sp,64
     7f6:	fca43c23          	sd	a0,-40(s0)
     7fa:	fcb43823          	sd	a1,-48(s0)
     7fe:	87b2                	mv	a5,a2
     800:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     804:	fd843783          	ld	a5,-40(s0)
     808:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     80c:	fd043783          	ld	a5,-48(s0)
     810:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     814:	fe043703          	ld	a4,-32(s0)
     818:	fe843783          	ld	a5,-24(s0)
     81c:	02e7fc63          	bgeu	a5,a4,854 <memmove+0x64>
    while(n-- > 0)
     820:	a00d                	j	842 <memmove+0x52>
      *dst++ = *src++;
     822:	fe043703          	ld	a4,-32(s0)
     826:	00170793          	addi	a5,a4,1
     82a:	fef43023          	sd	a5,-32(s0)
     82e:	fe843783          	ld	a5,-24(s0)
     832:	00178693          	addi	a3,a5,1
     836:	fed43423          	sd	a3,-24(s0)
     83a:	00074703          	lbu	a4,0(a4)
     83e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     842:	fcc42783          	lw	a5,-52(s0)
     846:	fff7871b          	addiw	a4,a5,-1
     84a:	fce42623          	sw	a4,-52(s0)
     84e:	fcf04ae3          	bgtz	a5,822 <memmove+0x32>
     852:	a891                	j	8a6 <memmove+0xb6>
  } else {
    dst += n;
     854:	fcc42783          	lw	a5,-52(s0)
     858:	fe843703          	ld	a4,-24(s0)
     85c:	97ba                	add	a5,a5,a4
     85e:	fef43423          	sd	a5,-24(s0)
    src += n;
     862:	fcc42783          	lw	a5,-52(s0)
     866:	fe043703          	ld	a4,-32(s0)
     86a:	97ba                	add	a5,a5,a4
     86c:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     870:	a01d                	j	896 <memmove+0xa6>
      *--dst = *--src;
     872:	fe043783          	ld	a5,-32(s0)
     876:	17fd                	addi	a5,a5,-1
     878:	fef43023          	sd	a5,-32(s0)
     87c:	fe843783          	ld	a5,-24(s0)
     880:	17fd                	addi	a5,a5,-1
     882:	fef43423          	sd	a5,-24(s0)
     886:	fe043783          	ld	a5,-32(s0)
     88a:	0007c703          	lbu	a4,0(a5)
     88e:	fe843783          	ld	a5,-24(s0)
     892:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     896:	fcc42783          	lw	a5,-52(s0)
     89a:	fff7871b          	addiw	a4,a5,-1
     89e:	fce42623          	sw	a4,-52(s0)
     8a2:	fcf048e3          	bgtz	a5,872 <memmove+0x82>
  }
  return vdst;
     8a6:	fd843783          	ld	a5,-40(s0)
}
     8aa:	853e                	mv	a0,a5
     8ac:	7462                	ld	s0,56(sp)
     8ae:	6121                	addi	sp,sp,64
     8b0:	8082                	ret

00000000000008b2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     8b2:	7139                	addi	sp,sp,-64
     8b4:	fc22                	sd	s0,56(sp)
     8b6:	0080                	addi	s0,sp,64
     8b8:	fca43c23          	sd	a0,-40(s0)
     8bc:	fcb43823          	sd	a1,-48(s0)
     8c0:	87b2                	mv	a5,a2
     8c2:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     8c6:	fd843783          	ld	a5,-40(s0)
     8ca:	fef43423          	sd	a5,-24(s0)
     8ce:	fd043783          	ld	a5,-48(s0)
     8d2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     8d6:	a0a1                	j	91e <memcmp+0x6c>
    if (*p1 != *p2) {
     8d8:	fe843783          	ld	a5,-24(s0)
     8dc:	0007c703          	lbu	a4,0(a5)
     8e0:	fe043783          	ld	a5,-32(s0)
     8e4:	0007c783          	lbu	a5,0(a5)
     8e8:	02f70163          	beq	a4,a5,90a <memcmp+0x58>
      return *p1 - *p2;
     8ec:	fe843783          	ld	a5,-24(s0)
     8f0:	0007c783          	lbu	a5,0(a5)
     8f4:	0007871b          	sext.w	a4,a5
     8f8:	fe043783          	ld	a5,-32(s0)
     8fc:	0007c783          	lbu	a5,0(a5)
     900:	2781                	sext.w	a5,a5
     902:	40f707bb          	subw	a5,a4,a5
     906:	2781                	sext.w	a5,a5
     908:	a01d                	j	92e <memcmp+0x7c>
    }
    p1++;
     90a:	fe843783          	ld	a5,-24(s0)
     90e:	0785                	addi	a5,a5,1
     910:	fef43423          	sd	a5,-24(s0)
    p2++;
     914:	fe043783          	ld	a5,-32(s0)
     918:	0785                	addi	a5,a5,1
     91a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     91e:	fcc42783          	lw	a5,-52(s0)
     922:	fff7871b          	addiw	a4,a5,-1
     926:	fce42623          	sw	a4,-52(s0)
     92a:	f7dd                	bnez	a5,8d8 <memcmp+0x26>
  }
  return 0;
     92c:	4781                	li	a5,0
}
     92e:	853e                	mv	a0,a5
     930:	7462                	ld	s0,56(sp)
     932:	6121                	addi	sp,sp,64
     934:	8082                	ret

0000000000000936 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     936:	7179                	addi	sp,sp,-48
     938:	f406                	sd	ra,40(sp)
     93a:	f022                	sd	s0,32(sp)
     93c:	1800                	addi	s0,sp,48
     93e:	fea43423          	sd	a0,-24(s0)
     942:	feb43023          	sd	a1,-32(s0)
     946:	87b2                	mv	a5,a2
     948:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     94c:	fdc42783          	lw	a5,-36(s0)
     950:	863e                	mv	a2,a5
     952:	fe043583          	ld	a1,-32(s0)
     956:	fe843503          	ld	a0,-24(s0)
     95a:	00000097          	auipc	ra,0x0
     95e:	e96080e7          	jalr	-362(ra) # 7f0 <memmove>
     962:	87aa                	mv	a5,a0
}
     964:	853e                	mv	a0,a5
     966:	70a2                	ld	ra,40(sp)
     968:	7402                	ld	s0,32(sp)
     96a:	6145                	addi	sp,sp,48
     96c:	8082                	ret

000000000000096e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     96e:	4885                	li	a7,1
 ecall
     970:	00000073          	ecall
 ret
     974:	8082                	ret

0000000000000976 <exit>:
.global exit
exit:
 li a7, SYS_exit
     976:	4889                	li	a7,2
 ecall
     978:	00000073          	ecall
 ret
     97c:	8082                	ret

000000000000097e <wait>:
.global wait
wait:
 li a7, SYS_wait
     97e:	488d                	li	a7,3
 ecall
     980:	00000073          	ecall
 ret
     984:	8082                	ret

0000000000000986 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     986:	4891                	li	a7,4
 ecall
     988:	00000073          	ecall
 ret
     98c:	8082                	ret

000000000000098e <read>:
.global read
read:
 li a7, SYS_read
     98e:	4895                	li	a7,5
 ecall
     990:	00000073          	ecall
 ret
     994:	8082                	ret

0000000000000996 <write>:
.global write
write:
 li a7, SYS_write
     996:	48c1                	li	a7,16
 ecall
     998:	00000073          	ecall
 ret
     99c:	8082                	ret

000000000000099e <close>:
.global close
close:
 li a7, SYS_close
     99e:	48d5                	li	a7,21
 ecall
     9a0:	00000073          	ecall
 ret
     9a4:	8082                	ret

00000000000009a6 <kill>:
.global kill
kill:
 li a7, SYS_kill
     9a6:	4899                	li	a7,6
 ecall
     9a8:	00000073          	ecall
 ret
     9ac:	8082                	ret

00000000000009ae <exec>:
.global exec
exec:
 li a7, SYS_exec
     9ae:	489d                	li	a7,7
 ecall
     9b0:	00000073          	ecall
 ret
     9b4:	8082                	ret

00000000000009b6 <open>:
.global open
open:
 li a7, SYS_open
     9b6:	48bd                	li	a7,15
 ecall
     9b8:	00000073          	ecall
 ret
     9bc:	8082                	ret

00000000000009be <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     9be:	48c5                	li	a7,17
 ecall
     9c0:	00000073          	ecall
 ret
     9c4:	8082                	ret

00000000000009c6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     9c6:	48c9                	li	a7,18
 ecall
     9c8:	00000073          	ecall
 ret
     9cc:	8082                	ret

00000000000009ce <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     9ce:	48a1                	li	a7,8
 ecall
     9d0:	00000073          	ecall
 ret
     9d4:	8082                	ret

00000000000009d6 <link>:
.global link
link:
 li a7, SYS_link
     9d6:	48cd                	li	a7,19
 ecall
     9d8:	00000073          	ecall
 ret
     9dc:	8082                	ret

00000000000009de <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     9de:	48d1                	li	a7,20
 ecall
     9e0:	00000073          	ecall
 ret
     9e4:	8082                	ret

00000000000009e6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     9e6:	48a5                	li	a7,9
 ecall
     9e8:	00000073          	ecall
 ret
     9ec:	8082                	ret

00000000000009ee <dup>:
.global dup
dup:
 li a7, SYS_dup
     9ee:	48a9                	li	a7,10
 ecall
     9f0:	00000073          	ecall
 ret
     9f4:	8082                	ret

00000000000009f6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     9f6:	48ad                	li	a7,11
 ecall
     9f8:	00000073          	ecall
 ret
     9fc:	8082                	ret

00000000000009fe <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     9fe:	48b1                	li	a7,12
 ecall
     a00:	00000073          	ecall
 ret
     a04:	8082                	ret

0000000000000a06 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     a06:	48b5                	li	a7,13
 ecall
     a08:	00000073          	ecall
 ret
     a0c:	8082                	ret

0000000000000a0e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     a0e:	48b9                	li	a7,14
 ecall
     a10:	00000073          	ecall
 ret
     a14:	8082                	ret

0000000000000a16 <clone>:
.global clone
clone:
 li a7, SYS_clone
     a16:	48d9                	li	a7,22
 ecall
     a18:	00000073          	ecall
 ret
     a1c:	8082                	ret

0000000000000a1e <join>:
.global join
join:
 li a7, SYS_join
     a1e:	48dd                	li	a7,23
 ecall
     a20:	00000073          	ecall
 ret
     a24:	8082                	ret

0000000000000a26 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     a26:	1101                	addi	sp,sp,-32
     a28:	ec06                	sd	ra,24(sp)
     a2a:	e822                	sd	s0,16(sp)
     a2c:	1000                	addi	s0,sp,32
     a2e:	87aa                	mv	a5,a0
     a30:	872e                	mv	a4,a1
     a32:	fef42623          	sw	a5,-20(s0)
     a36:	87ba                	mv	a5,a4
     a38:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     a3c:	feb40713          	addi	a4,s0,-21
     a40:	fec42783          	lw	a5,-20(s0)
     a44:	4605                	li	a2,1
     a46:	85ba                	mv	a1,a4
     a48:	853e                	mv	a0,a5
     a4a:	00000097          	auipc	ra,0x0
     a4e:	f4c080e7          	jalr	-180(ra) # 996 <write>
}
     a52:	0001                	nop
     a54:	60e2                	ld	ra,24(sp)
     a56:	6442                	ld	s0,16(sp)
     a58:	6105                	addi	sp,sp,32
     a5a:	8082                	ret

0000000000000a5c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     a5c:	7139                	addi	sp,sp,-64
     a5e:	fc06                	sd	ra,56(sp)
     a60:	f822                	sd	s0,48(sp)
     a62:	0080                	addi	s0,sp,64
     a64:	87aa                	mv	a5,a0
     a66:	8736                	mv	a4,a3
     a68:	fcf42623          	sw	a5,-52(s0)
     a6c:	87ae                	mv	a5,a1
     a6e:	fcf42423          	sw	a5,-56(s0)
     a72:	87b2                	mv	a5,a2
     a74:	fcf42223          	sw	a5,-60(s0)
     a78:	87ba                	mv	a5,a4
     a7a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     a7e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     a82:	fc042783          	lw	a5,-64(s0)
     a86:	2781                	sext.w	a5,a5
     a88:	c38d                	beqz	a5,aaa <printint+0x4e>
     a8a:	fc842783          	lw	a5,-56(s0)
     a8e:	2781                	sext.w	a5,a5
     a90:	0007dd63          	bgez	a5,aaa <printint+0x4e>
    neg = 1;
     a94:	4785                	li	a5,1
     a96:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     a9a:	fc842783          	lw	a5,-56(s0)
     a9e:	40f007bb          	negw	a5,a5
     aa2:	2781                	sext.w	a5,a5
     aa4:	fef42223          	sw	a5,-28(s0)
     aa8:	a029                	j	ab2 <printint+0x56>
  } else {
    x = xx;
     aaa:	fc842783          	lw	a5,-56(s0)
     aae:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     ab2:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     ab6:	fc442783          	lw	a5,-60(s0)
     aba:	fe442703          	lw	a4,-28(s0)
     abe:	02f777bb          	remuw	a5,a4,a5
     ac2:	0007861b          	sext.w	a2,a5
     ac6:	fec42783          	lw	a5,-20(s0)
     aca:	0017871b          	addiw	a4,a5,1
     ace:	fee42623          	sw	a4,-20(s0)
     ad2:	00001697          	auipc	a3,0x1
     ad6:	9ee68693          	addi	a3,a3,-1554 # 14c0 <digits>
     ada:	02061713          	slli	a4,a2,0x20
     ade:	9301                	srli	a4,a4,0x20
     ae0:	9736                	add	a4,a4,a3
     ae2:	00074703          	lbu	a4,0(a4)
     ae6:	17c1                	addi	a5,a5,-16
     ae8:	97a2                	add	a5,a5,s0
     aea:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     aee:	fc442783          	lw	a5,-60(s0)
     af2:	fe442703          	lw	a4,-28(s0)
     af6:	02f757bb          	divuw	a5,a4,a5
     afa:	fef42223          	sw	a5,-28(s0)
     afe:	fe442783          	lw	a5,-28(s0)
     b02:	2781                	sext.w	a5,a5
     b04:	fbcd                	bnez	a5,ab6 <printint+0x5a>
  if(neg)
     b06:	fe842783          	lw	a5,-24(s0)
     b0a:	2781                	sext.w	a5,a5
     b0c:	cf85                	beqz	a5,b44 <printint+0xe8>
    buf[i++] = '-';
     b0e:	fec42783          	lw	a5,-20(s0)
     b12:	0017871b          	addiw	a4,a5,1
     b16:	fee42623          	sw	a4,-20(s0)
     b1a:	17c1                	addi	a5,a5,-16
     b1c:	97a2                	add	a5,a5,s0
     b1e:	02d00713          	li	a4,45
     b22:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     b26:	a839                	j	b44 <printint+0xe8>
    putc(fd, buf[i]);
     b28:	fec42783          	lw	a5,-20(s0)
     b2c:	17c1                	addi	a5,a5,-16
     b2e:	97a2                	add	a5,a5,s0
     b30:	fe07c703          	lbu	a4,-32(a5)
     b34:	fcc42783          	lw	a5,-52(s0)
     b38:	85ba                	mv	a1,a4
     b3a:	853e                	mv	a0,a5
     b3c:	00000097          	auipc	ra,0x0
     b40:	eea080e7          	jalr	-278(ra) # a26 <putc>
  while(--i >= 0)
     b44:	fec42783          	lw	a5,-20(s0)
     b48:	37fd                	addiw	a5,a5,-1
     b4a:	fef42623          	sw	a5,-20(s0)
     b4e:	fec42783          	lw	a5,-20(s0)
     b52:	2781                	sext.w	a5,a5
     b54:	fc07dae3          	bgez	a5,b28 <printint+0xcc>
}
     b58:	0001                	nop
     b5a:	0001                	nop
     b5c:	70e2                	ld	ra,56(sp)
     b5e:	7442                	ld	s0,48(sp)
     b60:	6121                	addi	sp,sp,64
     b62:	8082                	ret

0000000000000b64 <printptr>:

static void
printptr(int fd, uint64 x) {
     b64:	7179                	addi	sp,sp,-48
     b66:	f406                	sd	ra,40(sp)
     b68:	f022                	sd	s0,32(sp)
     b6a:	1800                	addi	s0,sp,48
     b6c:	87aa                	mv	a5,a0
     b6e:	fcb43823          	sd	a1,-48(s0)
     b72:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     b76:	fdc42783          	lw	a5,-36(s0)
     b7a:	03000593          	li	a1,48
     b7e:	853e                	mv	a0,a5
     b80:	00000097          	auipc	ra,0x0
     b84:	ea6080e7          	jalr	-346(ra) # a26 <putc>
  putc(fd, 'x');
     b88:	fdc42783          	lw	a5,-36(s0)
     b8c:	07800593          	li	a1,120
     b90:	853e                	mv	a0,a5
     b92:	00000097          	auipc	ra,0x0
     b96:	e94080e7          	jalr	-364(ra) # a26 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     b9a:	fe042623          	sw	zero,-20(s0)
     b9e:	a82d                	j	bd8 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     ba0:	fd043783          	ld	a5,-48(s0)
     ba4:	93f1                	srli	a5,a5,0x3c
     ba6:	00001717          	auipc	a4,0x1
     baa:	91a70713          	addi	a4,a4,-1766 # 14c0 <digits>
     bae:	97ba                	add	a5,a5,a4
     bb0:	0007c703          	lbu	a4,0(a5)
     bb4:	fdc42783          	lw	a5,-36(s0)
     bb8:	85ba                	mv	a1,a4
     bba:	853e                	mv	a0,a5
     bbc:	00000097          	auipc	ra,0x0
     bc0:	e6a080e7          	jalr	-406(ra) # a26 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     bc4:	fec42783          	lw	a5,-20(s0)
     bc8:	2785                	addiw	a5,a5,1
     bca:	fef42623          	sw	a5,-20(s0)
     bce:	fd043783          	ld	a5,-48(s0)
     bd2:	0792                	slli	a5,a5,0x4
     bd4:	fcf43823          	sd	a5,-48(s0)
     bd8:	fec42783          	lw	a5,-20(s0)
     bdc:	873e                	mv	a4,a5
     bde:	47bd                	li	a5,15
     be0:	fce7f0e3          	bgeu	a5,a4,ba0 <printptr+0x3c>
}
     be4:	0001                	nop
     be6:	0001                	nop
     be8:	70a2                	ld	ra,40(sp)
     bea:	7402                	ld	s0,32(sp)
     bec:	6145                	addi	sp,sp,48
     bee:	8082                	ret

0000000000000bf0 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     bf0:	715d                	addi	sp,sp,-80
     bf2:	e486                	sd	ra,72(sp)
     bf4:	e0a2                	sd	s0,64(sp)
     bf6:	0880                	addi	s0,sp,80
     bf8:	87aa                	mv	a5,a0
     bfa:	fcb43023          	sd	a1,-64(s0)
     bfe:	fac43c23          	sd	a2,-72(s0)
     c02:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     c06:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     c0a:	fe042223          	sw	zero,-28(s0)
     c0e:	a42d                	j	e38 <vprintf+0x248>
    c = fmt[i] & 0xff;
     c10:	fe442783          	lw	a5,-28(s0)
     c14:	fc043703          	ld	a4,-64(s0)
     c18:	97ba                	add	a5,a5,a4
     c1a:	0007c783          	lbu	a5,0(a5)
     c1e:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     c22:	fe042783          	lw	a5,-32(s0)
     c26:	2781                	sext.w	a5,a5
     c28:	eb9d                	bnez	a5,c5e <vprintf+0x6e>
      if(c == '%'){
     c2a:	fdc42783          	lw	a5,-36(s0)
     c2e:	0007871b          	sext.w	a4,a5
     c32:	02500793          	li	a5,37
     c36:	00f71763          	bne	a4,a5,c44 <vprintf+0x54>
        state = '%';
     c3a:	02500793          	li	a5,37
     c3e:	fef42023          	sw	a5,-32(s0)
     c42:	a2f5                	j	e2e <vprintf+0x23e>
      } else {
        putc(fd, c);
     c44:	fdc42783          	lw	a5,-36(s0)
     c48:	0ff7f713          	zext.b	a4,a5
     c4c:	fcc42783          	lw	a5,-52(s0)
     c50:	85ba                	mv	a1,a4
     c52:	853e                	mv	a0,a5
     c54:	00000097          	auipc	ra,0x0
     c58:	dd2080e7          	jalr	-558(ra) # a26 <putc>
     c5c:	aac9                	j	e2e <vprintf+0x23e>
      }
    } else if(state == '%'){
     c5e:	fe042783          	lw	a5,-32(s0)
     c62:	0007871b          	sext.w	a4,a5
     c66:	02500793          	li	a5,37
     c6a:	1cf71263          	bne	a4,a5,e2e <vprintf+0x23e>
      if(c == 'd'){
     c6e:	fdc42783          	lw	a5,-36(s0)
     c72:	0007871b          	sext.w	a4,a5
     c76:	06400793          	li	a5,100
     c7a:	02f71463          	bne	a4,a5,ca2 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     c7e:	fb843783          	ld	a5,-72(s0)
     c82:	00878713          	addi	a4,a5,8
     c86:	fae43c23          	sd	a4,-72(s0)
     c8a:	4398                	lw	a4,0(a5)
     c8c:	fcc42783          	lw	a5,-52(s0)
     c90:	4685                	li	a3,1
     c92:	4629                	li	a2,10
     c94:	85ba                	mv	a1,a4
     c96:	853e                	mv	a0,a5
     c98:	00000097          	auipc	ra,0x0
     c9c:	dc4080e7          	jalr	-572(ra) # a5c <printint>
     ca0:	a269                	j	e2a <vprintf+0x23a>
      } else if(c == 'l') {
     ca2:	fdc42783          	lw	a5,-36(s0)
     ca6:	0007871b          	sext.w	a4,a5
     caa:	06c00793          	li	a5,108
     cae:	02f71663          	bne	a4,a5,cda <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     cb2:	fb843783          	ld	a5,-72(s0)
     cb6:	00878713          	addi	a4,a5,8
     cba:	fae43c23          	sd	a4,-72(s0)
     cbe:	639c                	ld	a5,0(a5)
     cc0:	0007871b          	sext.w	a4,a5
     cc4:	fcc42783          	lw	a5,-52(s0)
     cc8:	4681                	li	a3,0
     cca:	4629                	li	a2,10
     ccc:	85ba                	mv	a1,a4
     cce:	853e                	mv	a0,a5
     cd0:	00000097          	auipc	ra,0x0
     cd4:	d8c080e7          	jalr	-628(ra) # a5c <printint>
     cd8:	aa89                	j	e2a <vprintf+0x23a>
      } else if(c == 'x') {
     cda:	fdc42783          	lw	a5,-36(s0)
     cde:	0007871b          	sext.w	a4,a5
     ce2:	07800793          	li	a5,120
     ce6:	02f71463          	bne	a4,a5,d0e <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     cea:	fb843783          	ld	a5,-72(s0)
     cee:	00878713          	addi	a4,a5,8
     cf2:	fae43c23          	sd	a4,-72(s0)
     cf6:	4398                	lw	a4,0(a5)
     cf8:	fcc42783          	lw	a5,-52(s0)
     cfc:	4681                	li	a3,0
     cfe:	4641                	li	a2,16
     d00:	85ba                	mv	a1,a4
     d02:	853e                	mv	a0,a5
     d04:	00000097          	auipc	ra,0x0
     d08:	d58080e7          	jalr	-680(ra) # a5c <printint>
     d0c:	aa39                	j	e2a <vprintf+0x23a>
      } else if(c == 'p') {
     d0e:	fdc42783          	lw	a5,-36(s0)
     d12:	0007871b          	sext.w	a4,a5
     d16:	07000793          	li	a5,112
     d1a:	02f71263          	bne	a4,a5,d3e <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     d1e:	fb843783          	ld	a5,-72(s0)
     d22:	00878713          	addi	a4,a5,8
     d26:	fae43c23          	sd	a4,-72(s0)
     d2a:	6398                	ld	a4,0(a5)
     d2c:	fcc42783          	lw	a5,-52(s0)
     d30:	85ba                	mv	a1,a4
     d32:	853e                	mv	a0,a5
     d34:	00000097          	auipc	ra,0x0
     d38:	e30080e7          	jalr	-464(ra) # b64 <printptr>
     d3c:	a0fd                	j	e2a <vprintf+0x23a>
      } else if(c == 's'){
     d3e:	fdc42783          	lw	a5,-36(s0)
     d42:	0007871b          	sext.w	a4,a5
     d46:	07300793          	li	a5,115
     d4a:	04f71c63          	bne	a4,a5,da2 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     d4e:	fb843783          	ld	a5,-72(s0)
     d52:	00878713          	addi	a4,a5,8
     d56:	fae43c23          	sd	a4,-72(s0)
     d5a:	639c                	ld	a5,0(a5)
     d5c:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     d60:	fe843783          	ld	a5,-24(s0)
     d64:	eb8d                	bnez	a5,d96 <vprintf+0x1a6>
          s = "(null)";
     d66:	00000797          	auipc	a5,0x0
     d6a:	70278793          	addi	a5,a5,1794 # 1468 <lock_init+0x190>
     d6e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     d72:	a015                	j	d96 <vprintf+0x1a6>
          putc(fd, *s);
     d74:	fe843783          	ld	a5,-24(s0)
     d78:	0007c703          	lbu	a4,0(a5)
     d7c:	fcc42783          	lw	a5,-52(s0)
     d80:	85ba                	mv	a1,a4
     d82:	853e                	mv	a0,a5
     d84:	00000097          	auipc	ra,0x0
     d88:	ca2080e7          	jalr	-862(ra) # a26 <putc>
          s++;
     d8c:	fe843783          	ld	a5,-24(s0)
     d90:	0785                	addi	a5,a5,1
     d92:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     d96:	fe843783          	ld	a5,-24(s0)
     d9a:	0007c783          	lbu	a5,0(a5)
     d9e:	fbf9                	bnez	a5,d74 <vprintf+0x184>
     da0:	a069                	j	e2a <vprintf+0x23a>
        }
      } else if(c == 'c'){
     da2:	fdc42783          	lw	a5,-36(s0)
     da6:	0007871b          	sext.w	a4,a5
     daa:	06300793          	li	a5,99
     dae:	02f71463          	bne	a4,a5,dd6 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     db2:	fb843783          	ld	a5,-72(s0)
     db6:	00878713          	addi	a4,a5,8
     dba:	fae43c23          	sd	a4,-72(s0)
     dbe:	439c                	lw	a5,0(a5)
     dc0:	0ff7f713          	zext.b	a4,a5
     dc4:	fcc42783          	lw	a5,-52(s0)
     dc8:	85ba                	mv	a1,a4
     dca:	853e                	mv	a0,a5
     dcc:	00000097          	auipc	ra,0x0
     dd0:	c5a080e7          	jalr	-934(ra) # a26 <putc>
     dd4:	a899                	j	e2a <vprintf+0x23a>
      } else if(c == '%'){
     dd6:	fdc42783          	lw	a5,-36(s0)
     dda:	0007871b          	sext.w	a4,a5
     dde:	02500793          	li	a5,37
     de2:	00f71f63          	bne	a4,a5,e00 <vprintf+0x210>
        putc(fd, c);
     de6:	fdc42783          	lw	a5,-36(s0)
     dea:	0ff7f713          	zext.b	a4,a5
     dee:	fcc42783          	lw	a5,-52(s0)
     df2:	85ba                	mv	a1,a4
     df4:	853e                	mv	a0,a5
     df6:	00000097          	auipc	ra,0x0
     dfa:	c30080e7          	jalr	-976(ra) # a26 <putc>
     dfe:	a035                	j	e2a <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     e00:	fcc42783          	lw	a5,-52(s0)
     e04:	02500593          	li	a1,37
     e08:	853e                	mv	a0,a5
     e0a:	00000097          	auipc	ra,0x0
     e0e:	c1c080e7          	jalr	-996(ra) # a26 <putc>
        putc(fd, c);
     e12:	fdc42783          	lw	a5,-36(s0)
     e16:	0ff7f713          	zext.b	a4,a5
     e1a:	fcc42783          	lw	a5,-52(s0)
     e1e:	85ba                	mv	a1,a4
     e20:	853e                	mv	a0,a5
     e22:	00000097          	auipc	ra,0x0
     e26:	c04080e7          	jalr	-1020(ra) # a26 <putc>
      }
      state = 0;
     e2a:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     e2e:	fe442783          	lw	a5,-28(s0)
     e32:	2785                	addiw	a5,a5,1
     e34:	fef42223          	sw	a5,-28(s0)
     e38:	fe442783          	lw	a5,-28(s0)
     e3c:	fc043703          	ld	a4,-64(s0)
     e40:	97ba                	add	a5,a5,a4
     e42:	0007c783          	lbu	a5,0(a5)
     e46:	dc0795e3          	bnez	a5,c10 <vprintf+0x20>
    }
  }
}
     e4a:	0001                	nop
     e4c:	0001                	nop
     e4e:	60a6                	ld	ra,72(sp)
     e50:	6406                	ld	s0,64(sp)
     e52:	6161                	addi	sp,sp,80
     e54:	8082                	ret

0000000000000e56 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     e56:	7159                	addi	sp,sp,-112
     e58:	fc06                	sd	ra,56(sp)
     e5a:	f822                	sd	s0,48(sp)
     e5c:	0080                	addi	s0,sp,64
     e5e:	fcb43823          	sd	a1,-48(s0)
     e62:	e010                	sd	a2,0(s0)
     e64:	e414                	sd	a3,8(s0)
     e66:	e818                	sd	a4,16(s0)
     e68:	ec1c                	sd	a5,24(s0)
     e6a:	03043023          	sd	a6,32(s0)
     e6e:	03143423          	sd	a7,40(s0)
     e72:	87aa                	mv	a5,a0
     e74:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     e78:	03040793          	addi	a5,s0,48
     e7c:	fcf43423          	sd	a5,-56(s0)
     e80:	fc843783          	ld	a5,-56(s0)
     e84:	fd078793          	addi	a5,a5,-48
     e88:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     e8c:	fe843703          	ld	a4,-24(s0)
     e90:	fdc42783          	lw	a5,-36(s0)
     e94:	863a                	mv	a2,a4
     e96:	fd043583          	ld	a1,-48(s0)
     e9a:	853e                	mv	a0,a5
     e9c:	00000097          	auipc	ra,0x0
     ea0:	d54080e7          	jalr	-684(ra) # bf0 <vprintf>
}
     ea4:	0001                	nop
     ea6:	70e2                	ld	ra,56(sp)
     ea8:	7442                	ld	s0,48(sp)
     eaa:	6165                	addi	sp,sp,112
     eac:	8082                	ret

0000000000000eae <printf>:

void
printf(const char *fmt, ...)
{
     eae:	7159                	addi	sp,sp,-112
     eb0:	f406                	sd	ra,40(sp)
     eb2:	f022                	sd	s0,32(sp)
     eb4:	1800                	addi	s0,sp,48
     eb6:	fca43c23          	sd	a0,-40(s0)
     eba:	e40c                	sd	a1,8(s0)
     ebc:	e810                	sd	a2,16(s0)
     ebe:	ec14                	sd	a3,24(s0)
     ec0:	f018                	sd	a4,32(s0)
     ec2:	f41c                	sd	a5,40(s0)
     ec4:	03043823          	sd	a6,48(s0)
     ec8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     ecc:	04040793          	addi	a5,s0,64
     ed0:	fcf43823          	sd	a5,-48(s0)
     ed4:	fd043783          	ld	a5,-48(s0)
     ed8:	fc878793          	addi	a5,a5,-56
     edc:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     ee0:	fe843783          	ld	a5,-24(s0)
     ee4:	863e                	mv	a2,a5
     ee6:	fd843583          	ld	a1,-40(s0)
     eea:	4505                	li	a0,1
     eec:	00000097          	auipc	ra,0x0
     ef0:	d04080e7          	jalr	-764(ra) # bf0 <vprintf>
}
     ef4:	0001                	nop
     ef6:	70a2                	ld	ra,40(sp)
     ef8:	7402                	ld	s0,32(sp)
     efa:	6165                	addi	sp,sp,112
     efc:	8082                	ret

0000000000000efe <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     efe:	7179                	addi	sp,sp,-48
     f00:	f422                	sd	s0,40(sp)
     f02:	1800                	addi	s0,sp,48
     f04:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     f08:	fd843783          	ld	a5,-40(s0)
     f0c:	17c1                	addi	a5,a5,-16
     f0e:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f12:	00000797          	auipc	a5,0x0
     f16:	5de78793          	addi	a5,a5,1502 # 14f0 <freep>
     f1a:	639c                	ld	a5,0(a5)
     f1c:	fef43423          	sd	a5,-24(s0)
     f20:	a815                	j	f54 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f22:	fe843783          	ld	a5,-24(s0)
     f26:	639c                	ld	a5,0(a5)
     f28:	fe843703          	ld	a4,-24(s0)
     f2c:	00f76f63          	bltu	a4,a5,f4a <free+0x4c>
     f30:	fe043703          	ld	a4,-32(s0)
     f34:	fe843783          	ld	a5,-24(s0)
     f38:	02e7eb63          	bltu	a5,a4,f6e <free+0x70>
     f3c:	fe843783          	ld	a5,-24(s0)
     f40:	639c                	ld	a5,0(a5)
     f42:	fe043703          	ld	a4,-32(s0)
     f46:	02f76463          	bltu	a4,a5,f6e <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f4a:	fe843783          	ld	a5,-24(s0)
     f4e:	639c                	ld	a5,0(a5)
     f50:	fef43423          	sd	a5,-24(s0)
     f54:	fe043703          	ld	a4,-32(s0)
     f58:	fe843783          	ld	a5,-24(s0)
     f5c:	fce7f3e3          	bgeu	a5,a4,f22 <free+0x24>
     f60:	fe843783          	ld	a5,-24(s0)
     f64:	639c                	ld	a5,0(a5)
     f66:	fe043703          	ld	a4,-32(s0)
     f6a:	faf77ce3          	bgeu	a4,a5,f22 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     f6e:	fe043783          	ld	a5,-32(s0)
     f72:	479c                	lw	a5,8(a5)
     f74:	1782                	slli	a5,a5,0x20
     f76:	9381                	srli	a5,a5,0x20
     f78:	0792                	slli	a5,a5,0x4
     f7a:	fe043703          	ld	a4,-32(s0)
     f7e:	973e                	add	a4,a4,a5
     f80:	fe843783          	ld	a5,-24(s0)
     f84:	639c                	ld	a5,0(a5)
     f86:	02f71763          	bne	a4,a5,fb4 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     f8a:	fe043783          	ld	a5,-32(s0)
     f8e:	4798                	lw	a4,8(a5)
     f90:	fe843783          	ld	a5,-24(s0)
     f94:	639c                	ld	a5,0(a5)
     f96:	479c                	lw	a5,8(a5)
     f98:	9fb9                	addw	a5,a5,a4
     f9a:	0007871b          	sext.w	a4,a5
     f9e:	fe043783          	ld	a5,-32(s0)
     fa2:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     fa4:	fe843783          	ld	a5,-24(s0)
     fa8:	639c                	ld	a5,0(a5)
     faa:	6398                	ld	a4,0(a5)
     fac:	fe043783          	ld	a5,-32(s0)
     fb0:	e398                	sd	a4,0(a5)
     fb2:	a039                	j	fc0 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     fb4:	fe843783          	ld	a5,-24(s0)
     fb8:	6398                	ld	a4,0(a5)
     fba:	fe043783          	ld	a5,-32(s0)
     fbe:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     fc0:	fe843783          	ld	a5,-24(s0)
     fc4:	479c                	lw	a5,8(a5)
     fc6:	1782                	slli	a5,a5,0x20
     fc8:	9381                	srli	a5,a5,0x20
     fca:	0792                	slli	a5,a5,0x4
     fcc:	fe843703          	ld	a4,-24(s0)
     fd0:	97ba                	add	a5,a5,a4
     fd2:	fe043703          	ld	a4,-32(s0)
     fd6:	02f71563          	bne	a4,a5,1000 <free+0x102>
    p->s.size += bp->s.size;
     fda:	fe843783          	ld	a5,-24(s0)
     fde:	4798                	lw	a4,8(a5)
     fe0:	fe043783          	ld	a5,-32(s0)
     fe4:	479c                	lw	a5,8(a5)
     fe6:	9fb9                	addw	a5,a5,a4
     fe8:	0007871b          	sext.w	a4,a5
     fec:	fe843783          	ld	a5,-24(s0)
     ff0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     ff2:	fe043783          	ld	a5,-32(s0)
     ff6:	6398                	ld	a4,0(a5)
     ff8:	fe843783          	ld	a5,-24(s0)
     ffc:	e398                	sd	a4,0(a5)
     ffe:	a031                	j	100a <free+0x10c>
  } else
    p->s.ptr = bp;
    1000:	fe843783          	ld	a5,-24(s0)
    1004:	fe043703          	ld	a4,-32(s0)
    1008:	e398                	sd	a4,0(a5)
  freep = p;
    100a:	00000797          	auipc	a5,0x0
    100e:	4e678793          	addi	a5,a5,1254 # 14f0 <freep>
    1012:	fe843703          	ld	a4,-24(s0)
    1016:	e398                	sd	a4,0(a5)
}
    1018:	0001                	nop
    101a:	7422                	ld	s0,40(sp)
    101c:	6145                	addi	sp,sp,48
    101e:	8082                	ret

0000000000001020 <morecore>:

static Header*
morecore(uint nu)
{
    1020:	7179                	addi	sp,sp,-48
    1022:	f406                	sd	ra,40(sp)
    1024:	f022                	sd	s0,32(sp)
    1026:	1800                	addi	s0,sp,48
    1028:	87aa                	mv	a5,a0
    102a:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    102e:	fdc42783          	lw	a5,-36(s0)
    1032:	0007871b          	sext.w	a4,a5
    1036:	6785                	lui	a5,0x1
    1038:	00f77563          	bgeu	a4,a5,1042 <morecore+0x22>
    nu = 4096;
    103c:	6785                	lui	a5,0x1
    103e:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    1042:	fdc42783          	lw	a5,-36(s0)
    1046:	0047979b          	slliw	a5,a5,0x4
    104a:	2781                	sext.w	a5,a5
    104c:	2781                	sext.w	a5,a5
    104e:	853e                	mv	a0,a5
    1050:	00000097          	auipc	ra,0x0
    1054:	9ae080e7          	jalr	-1618(ra) # 9fe <sbrk>
    1058:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    105c:	fe843703          	ld	a4,-24(s0)
    1060:	57fd                	li	a5,-1
    1062:	00f71463          	bne	a4,a5,106a <morecore+0x4a>
    return 0;
    1066:	4781                	li	a5,0
    1068:	a03d                	j	1096 <morecore+0x76>
  hp = (Header*)p;
    106a:	fe843783          	ld	a5,-24(s0)
    106e:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    1072:	fe043783          	ld	a5,-32(s0)
    1076:	fdc42703          	lw	a4,-36(s0)
    107a:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    107c:	fe043783          	ld	a5,-32(s0)
    1080:	07c1                	addi	a5,a5,16
    1082:	853e                	mv	a0,a5
    1084:	00000097          	auipc	ra,0x0
    1088:	e7a080e7          	jalr	-390(ra) # efe <free>
  return freep;
    108c:	00000797          	auipc	a5,0x0
    1090:	46478793          	addi	a5,a5,1124 # 14f0 <freep>
    1094:	639c                	ld	a5,0(a5)
}
    1096:	853e                	mv	a0,a5
    1098:	70a2                	ld	ra,40(sp)
    109a:	7402                	ld	s0,32(sp)
    109c:	6145                	addi	sp,sp,48
    109e:	8082                	ret

00000000000010a0 <malloc>:

void*
malloc(uint nbytes)
{
    10a0:	7139                	addi	sp,sp,-64
    10a2:	fc06                	sd	ra,56(sp)
    10a4:	f822                	sd	s0,48(sp)
    10a6:	0080                	addi	s0,sp,64
    10a8:	87aa                	mv	a5,a0
    10aa:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10ae:	fcc46783          	lwu	a5,-52(s0)
    10b2:	07bd                	addi	a5,a5,15
    10b4:	8391                	srli	a5,a5,0x4
    10b6:	2781                	sext.w	a5,a5
    10b8:	2785                	addiw	a5,a5,1
    10ba:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    10be:	00000797          	auipc	a5,0x0
    10c2:	43278793          	addi	a5,a5,1074 # 14f0 <freep>
    10c6:	639c                	ld	a5,0(a5)
    10c8:	fef43023          	sd	a5,-32(s0)
    10cc:	fe043783          	ld	a5,-32(s0)
    10d0:	ef95                	bnez	a5,110c <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    10d2:	00000797          	auipc	a5,0x0
    10d6:	40e78793          	addi	a5,a5,1038 # 14e0 <base>
    10da:	fef43023          	sd	a5,-32(s0)
    10de:	00000797          	auipc	a5,0x0
    10e2:	41278793          	addi	a5,a5,1042 # 14f0 <freep>
    10e6:	fe043703          	ld	a4,-32(s0)
    10ea:	e398                	sd	a4,0(a5)
    10ec:	00000797          	auipc	a5,0x0
    10f0:	40478793          	addi	a5,a5,1028 # 14f0 <freep>
    10f4:	6398                	ld	a4,0(a5)
    10f6:	00000797          	auipc	a5,0x0
    10fa:	3ea78793          	addi	a5,a5,1002 # 14e0 <base>
    10fe:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1100:	00000797          	auipc	a5,0x0
    1104:	3e078793          	addi	a5,a5,992 # 14e0 <base>
    1108:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    110c:	fe043783          	ld	a5,-32(s0)
    1110:	639c                	ld	a5,0(a5)
    1112:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1116:	fe843783          	ld	a5,-24(s0)
    111a:	4798                	lw	a4,8(a5)
    111c:	fdc42783          	lw	a5,-36(s0)
    1120:	2781                	sext.w	a5,a5
    1122:	06f76763          	bltu	a4,a5,1190 <malloc+0xf0>
      if(p->s.size == nunits)
    1126:	fe843783          	ld	a5,-24(s0)
    112a:	4798                	lw	a4,8(a5)
    112c:	fdc42783          	lw	a5,-36(s0)
    1130:	2781                	sext.w	a5,a5
    1132:	00e79963          	bne	a5,a4,1144 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1136:	fe843783          	ld	a5,-24(s0)
    113a:	6398                	ld	a4,0(a5)
    113c:	fe043783          	ld	a5,-32(s0)
    1140:	e398                	sd	a4,0(a5)
    1142:	a825                	j	117a <malloc+0xda>
      else {
        p->s.size -= nunits;
    1144:	fe843783          	ld	a5,-24(s0)
    1148:	479c                	lw	a5,8(a5)
    114a:	fdc42703          	lw	a4,-36(s0)
    114e:	9f99                	subw	a5,a5,a4
    1150:	0007871b          	sext.w	a4,a5
    1154:	fe843783          	ld	a5,-24(s0)
    1158:	c798                	sw	a4,8(a5)
        p += p->s.size;
    115a:	fe843783          	ld	a5,-24(s0)
    115e:	479c                	lw	a5,8(a5)
    1160:	1782                	slli	a5,a5,0x20
    1162:	9381                	srli	a5,a5,0x20
    1164:	0792                	slli	a5,a5,0x4
    1166:	fe843703          	ld	a4,-24(s0)
    116a:	97ba                	add	a5,a5,a4
    116c:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1170:	fe843783          	ld	a5,-24(s0)
    1174:	fdc42703          	lw	a4,-36(s0)
    1178:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    117a:	00000797          	auipc	a5,0x0
    117e:	37678793          	addi	a5,a5,886 # 14f0 <freep>
    1182:	fe043703          	ld	a4,-32(s0)
    1186:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1188:	fe843783          	ld	a5,-24(s0)
    118c:	07c1                	addi	a5,a5,16
    118e:	a091                	j	11d2 <malloc+0x132>
    }
    if(p == freep)
    1190:	00000797          	auipc	a5,0x0
    1194:	36078793          	addi	a5,a5,864 # 14f0 <freep>
    1198:	639c                	ld	a5,0(a5)
    119a:	fe843703          	ld	a4,-24(s0)
    119e:	02f71063          	bne	a4,a5,11be <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    11a2:	fdc42783          	lw	a5,-36(s0)
    11a6:	853e                	mv	a0,a5
    11a8:	00000097          	auipc	ra,0x0
    11ac:	e78080e7          	jalr	-392(ra) # 1020 <morecore>
    11b0:	fea43423          	sd	a0,-24(s0)
    11b4:	fe843783          	ld	a5,-24(s0)
    11b8:	e399                	bnez	a5,11be <malloc+0x11e>
        return 0;
    11ba:	4781                	li	a5,0
    11bc:	a819                	j	11d2 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11be:	fe843783          	ld	a5,-24(s0)
    11c2:	fef43023          	sd	a5,-32(s0)
    11c6:	fe843783          	ld	a5,-24(s0)
    11ca:	639c                	ld	a5,0(a5)
    11cc:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    11d0:	b799                	j	1116 <malloc+0x76>
  }
}
    11d2:	853e                	mv	a0,a5
    11d4:	70e2                	ld	ra,56(sp)
    11d6:	7442                	ld	s0,48(sp)
    11d8:	6121                	addi	sp,sp,64
    11da:	8082                	ret

00000000000011dc <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
    11dc:	7179                	addi	sp,sp,-48
    11de:	f406                	sd	ra,40(sp)
    11e0:	f022                	sd	s0,32(sp)
    11e2:	1800                	addi	s0,sp,48
    11e4:	fca43c23          	sd	a0,-40(s0)
    11e8:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
    11ec:	6505                	lui	a0,0x1
    11ee:	00000097          	auipc	ra,0x0
    11f2:	eb2080e7          	jalr	-334(ra) # 10a0 <malloc>
    11f6:	fea43423          	sd	a0,-24(s0)
    11fa:	fe843783          	ld	a5,-24(s0)
    11fe:	e38d                	bnez	a5,1220 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
    1200:	00000517          	auipc	a0,0x0
    1204:	27050513          	addi	a0,a0,624 # 1470 <lock_init+0x198>
    1208:	00000097          	auipc	ra,0x0
    120c:	ca6080e7          	jalr	-858(ra) # eae <printf>
        free(stack);
    1210:	fe843503          	ld	a0,-24(s0)
    1214:	00000097          	auipc	ra,0x0
    1218:	cea080e7          	jalr	-790(ra) # efe <free>
        return -1;
    121c:	57fd                	li	a5,-1
    121e:	a099                	j	1264 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
    1220:	fe843783          	ld	a5,-24(s0)
    1224:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
    1228:	fe043703          	ld	a4,-32(s0)
    122c:	6785                	lui	a5,0x1
    122e:	17fd                	addi	a5,a5,-1
    1230:	8ff9                	and	a5,a5,a4
    1232:	cf91                	beqz	a5,124e <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
    1234:	fe043703          	ld	a4,-32(s0)
    1238:	6785                	lui	a5,0x1
    123a:	17fd                	addi	a5,a5,-1
    123c:	8ff9                	and	a5,a5,a4
    123e:	6705                	lui	a4,0x1
    1240:	40f707b3          	sub	a5,a4,a5
    1244:	fe843703          	ld	a4,-24(s0)
    1248:	97ba                	add	a5,a5,a4
    124a:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
    124e:	fe843603          	ld	a2,-24(s0)
    1252:	fd043583          	ld	a1,-48(s0)
    1256:	fd843503          	ld	a0,-40(s0)
    125a:	fffff097          	auipc	ra,0xfffff
    125e:	7bc080e7          	jalr	1980(ra) # a16 <clone>
    1262:	87aa                	mv	a5,a0
}
    1264:	853e                	mv	a0,a5
    1266:	70a2                	ld	ra,40(sp)
    1268:	7402                	ld	s0,32(sp)
    126a:	6145                	addi	sp,sp,48
    126c:	8082                	ret

000000000000126e <thread_join>:


int thread_join()
{
    126e:	1101                	addi	sp,sp,-32
    1270:	ec06                	sd	ra,24(sp)
    1272:	e822                	sd	s0,16(sp)
    1274:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
    1276:	fe040793          	addi	a5,s0,-32
    127a:	853e                	mv	a0,a5
    127c:	fffff097          	auipc	ra,0xfffff
    1280:	7a2080e7          	jalr	1954(ra) # a1e <join>
    1284:	87aa                	mv	a5,a0
    1286:	fef42623          	sw	a5,-20(s0)
    128a:	fec42783          	lw	a5,-20(s0)
    128e:	0007871b          	sext.w	a4,a5
    1292:	57fd                	li	a5,-1
    1294:	00f70963          	beq	a4,a5,12a6 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
    1298:	fe043783          	ld	a5,-32(s0)
    129c:	853e                	mv	a0,a5
    129e:	00000097          	auipc	ra,0x0
    12a2:	c60080e7          	jalr	-928(ra) # efe <free>
    } 

    return child_tid;
    12a6:	fec42783          	lw	a5,-20(s0)
}
    12aa:	853e                	mv	a0,a5
    12ac:	60e2                	ld	ra,24(sp)
    12ae:	6442                	ld	s0,16(sp)
    12b0:	6105                	addi	sp,sp,32
    12b2:	8082                	ret

00000000000012b4 <lock_acquire>:


void lock_acquire (lock_t *)
{
    12b4:	1101                	addi	sp,sp,-32
    12b6:	ec22                	sd	s0,24(sp)
    12b8:	1000                	addi	s0,sp,32
    12ba:	fea43423          	sd	a0,-24(s0)

}
    12be:	0001                	nop
    12c0:	6462                	ld	s0,24(sp)
    12c2:	6105                	addi	sp,sp,32
    12c4:	8082                	ret

00000000000012c6 <lock_release>:

void lock_release (lock_t *)
{
    12c6:	1101                	addi	sp,sp,-32
    12c8:	ec22                	sd	s0,24(sp)
    12ca:	1000                	addi	s0,sp,32
    12cc:	fea43423          	sd	a0,-24(s0)
    
}
    12d0:	0001                	nop
    12d2:	6462                	ld	s0,24(sp)
    12d4:	6105                	addi	sp,sp,32
    12d6:	8082                	ret

00000000000012d8 <lock_init>:

void lock_init (lock_t *)
{
    12d8:	1101                	addi	sp,sp,-32
    12da:	ec22                	sd	s0,24(sp)
    12dc:	1000                	addi	s0,sp,32
    12de:	fea43423          	sd	a0,-24(s0)
    
}
    12e2:	0001                	nop
    12e4:	6462                	ld	s0,24(sp)
    12e6:	6105                	addi	sp,sp,32
    12e8:	8082                	ret
