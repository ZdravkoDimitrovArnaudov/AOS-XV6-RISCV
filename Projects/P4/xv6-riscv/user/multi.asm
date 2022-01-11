
user/_multi:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
       0:	7179                	addi	sp,sp,-48
       2:	f406                	sd	ra,40(sp)
       4:	f022                	sd	s0,32(sp)
       6:	1800                	addi	s0,sp,48
       8:	fca43c23          	sd	a0,-40(s0)
       c:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
      10:	6505                	lui	a0,0x1
      12:	00001097          	auipc	ra,0x1
      16:	226080e7          	jalr	550(ra) # 1238 <malloc>
      1a:	fea43423          	sd	a0,-24(s0)
      1e:	fe843783          	ld	a5,-24(s0)
      22:	e38d                	bnez	a5,44 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
      24:	00001517          	auipc	a0,0x1
      28:	35450513          	addi	a0,a0,852 # 1378 <malloc+0x140>
      2c:	00001097          	auipc	ra,0x1
      30:	01a080e7          	jalr	26(ra) # 1046 <printf>
        free(stack);
      34:	fe843503          	ld	a0,-24(s0)
      38:	00001097          	auipc	ra,0x1
      3c:	05e080e7          	jalr	94(ra) # 1096 <free>
        return -1;
      40:	57fd                	li	a5,-1
      42:	a099                	j	88 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
      44:	fe843783          	ld	a5,-24(s0)
      48:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
      4c:	fe043703          	ld	a4,-32(s0)
      50:	6785                	lui	a5,0x1
      52:	17fd                	addi	a5,a5,-1
      54:	8ff9                	and	a5,a5,a4
      56:	cf91                	beqz	a5,72 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
      58:	fe043703          	ld	a4,-32(s0)
      5c:	6785                	lui	a5,0x1
      5e:	17fd                	addi	a5,a5,-1
      60:	8ff9                	and	a5,a5,a4
      62:	6705                	lui	a4,0x1
      64:	40f707b3          	sub	a5,a4,a5
      68:	fe843703          	ld	a4,-24(s0)
      6c:	97ba                	add	a5,a5,a4
      6e:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
      72:	fe843603          	ld	a2,-24(s0)
      76:	fd043583          	ld	a1,-48(s0)
      7a:	fd843503          	ld	a0,-40(s0)
      7e:	00001097          	auipc	ra,0x1
      82:	b30080e7          	jalr	-1232(ra) # bae <clone>
      86:	87aa                	mv	a5,a0
}
      88:	853e                	mv	a0,a5
      8a:	70a2                	ld	ra,40(sp)
      8c:	7402                	ld	s0,32(sp)
      8e:	6145                	addi	sp,sp,48
      90:	8082                	ret

0000000000000092 <thread_join>:


int thread_join()
{
      92:	1101                	addi	sp,sp,-32
      94:	ec06                	sd	ra,24(sp)
      96:	e822                	sd	s0,16(sp)
      98:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
      9a:	fe040793          	addi	a5,s0,-32
      9e:	853e                	mv	a0,a5
      a0:	00001097          	auipc	ra,0x1
      a4:	b16080e7          	jalr	-1258(ra) # bb6 <join>
      a8:	87aa                	mv	a5,a0
      aa:	fef42623          	sw	a5,-20(s0)
      ae:	fec42783          	lw	a5,-20(s0)
      b2:	0007871b          	sext.w	a4,a5
      b6:	57fd                	li	a5,-1
      b8:	00f70963          	beq	a4,a5,ca <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
      bc:	fe043783          	ld	a5,-32(s0)
      c0:	853e                	mv	a0,a5
      c2:	00001097          	auipc	ra,0x1
      c6:	fd4080e7          	jalr	-44(ra) # 1096 <free>
    } 

    return child_tid;
      ca:	fec42783          	lw	a5,-20(s0)
}
      ce:	853e                	mv	a0,a5
      d0:	60e2                	ld	ra,24(sp)
      d2:	6442                	ld	s0,16(sp)
      d4:	6105                	addi	sp,sp,32
      d6:	8082                	ret

00000000000000d8 <lock_acquire>:


void lock_acquire (lock_t *)
{
      d8:	1101                	addi	sp,sp,-32
      da:	ec22                	sd	s0,24(sp)
      dc:	1000                	addi	s0,sp,32
      de:	fea43423          	sd	a0,-24(s0)

}
      e2:	0001                	nop
      e4:	6462                	ld	s0,24(sp)
      e6:	6105                	addi	sp,sp,32
      e8:	8082                	ret

00000000000000ea <lock_release>:

void lock_release (lock_t *)
{
      ea:	1101                	addi	sp,sp,-32
      ec:	ec22                	sd	s0,24(sp)
      ee:	1000                	addi	s0,sp,32
      f0:	fea43423          	sd	a0,-24(s0)
    
}
      f4:	0001                	nop
      f6:	6462                	ld	s0,24(sp)
      f8:	6105                	addi	sp,sp,32
      fa:	8082                	ret

00000000000000fc <lock_init>:

void lock_init (lock_t *)
{
      fc:	1101                	addi	sp,sp,-32
      fe:	ec22                	sd	s0,24(sp)
     100:	1000                	addi	s0,sp,32
     102:	fea43423          	sd	a0,-24(s0)
    
}
     106:	0001                	nop
     108:	6462                	ld	s0,24(sp)
     10a:	6105                	addi	sp,sp,32
     10c:	8082                	ret

000000000000010e <fib>:
   exit(0); \
}

void worker(void *arg_ptr);

unsigned int fib(unsigned int n) {
     10e:	7179                	addi	sp,sp,-48
     110:	f406                	sd	ra,40(sp)
     112:	f022                	sd	s0,32(sp)
     114:	ec26                	sd	s1,24(sp)
     116:	1800                	addi	s0,sp,48
     118:	87aa                	mv	a5,a0
     11a:	fcf42e23          	sw	a5,-36(s0)
   if (n == 0) {
     11e:	fdc42783          	lw	a5,-36(s0)
     122:	2781                	sext.w	a5,a5
     124:	e399                	bnez	a5,12a <fib+0x1c>
      return 0;
     126:	4781                	li	a5,0
     128:	a099                	j	16e <fib+0x60>
   } else if (n == 1) {
     12a:	fdc42783          	lw	a5,-36(s0)
     12e:	0007871b          	sext.w	a4,a5
     132:	4785                	li	a5,1
     134:	00f71463          	bne	a4,a5,13c <fib+0x2e>
      return 1;
     138:	4785                	li	a5,1
     13a:	a815                	j	16e <fib+0x60>
   } else {
      return fib(n - 1) + fib(n - 2);
     13c:	fdc42783          	lw	a5,-36(s0)
     140:	37fd                	addiw	a5,a5,-1
     142:	2781                	sext.w	a5,a5
     144:	853e                	mv	a0,a5
     146:	00000097          	auipc	ra,0x0
     14a:	fc8080e7          	jalr	-56(ra) # 10e <fib>
     14e:	87aa                	mv	a5,a0
     150:	0007849b          	sext.w	s1,a5
     154:	fdc42783          	lw	a5,-36(s0)
     158:	37f9                	addiw	a5,a5,-2
     15a:	2781                	sext.w	a5,a5
     15c:	853e                	mv	a0,a5
     15e:	00000097          	auipc	ra,0x0
     162:	fb0080e7          	jalr	-80(ra) # 10e <fib>
     166:	87aa                	mv	a5,a0
     168:	2781                	sext.w	a5,a5
     16a:	9fa5                	addw	a5,a5,s1
     16c:	2781                	sext.w	a5,a5
   }
}
     16e:	853e                	mv	a0,a5
     170:	70a2                	ld	ra,40(sp)
     172:	7402                	ld	s0,32(sp)
     174:	64e2                	ld	s1,24(sp)
     176:	6145                	addi	sp,sp,48
     178:	8082                	ret

000000000000017a <main>:


int
main(int argc, char *argv[])
{
     17a:	7139                	addi	sp,sp,-64
     17c:	fc06                	sd	ra,56(sp)
     17e:	f822                	sd	s0,48(sp)
     180:	0080                	addi	s0,sp,64
     182:	87aa                	mv	a5,a0
     184:	fcb43023          	sd	a1,-64(s0)
     188:	fcf42623          	sw	a5,-52(s0)
   ppid = getpid();
     18c:	00001097          	auipc	ra,0x1
     190:	a02080e7          	jalr	-1534(ra) # b8e <getpid>
     194:	87aa                	mv	a5,a0
     196:	873e                	mv	a4,a5
     198:	00001797          	auipc	a5,0x1
     19c:	33c78793          	addi	a5,a5,828 # 14d4 <ppid>
     1a0:	c398                	sw	a4,0(a5)

   assert(fib(28) == 317811);
     1a2:	4571                	li	a0,28
     1a4:	00000097          	auipc	ra,0x0
     1a8:	f6a080e7          	jalr	-150(ra) # 10e <fib>
     1ac:	87aa                	mv	a5,a0
     1ae:	2781                	sext.w	a5,a5
     1b0:	873e                	mv	a4,a5
     1b2:	0004e7b7          	lui	a5,0x4e
     1b6:	97378793          	addi	a5,a5,-1677 # 4d973 <__global_pointer$+0x4bcbb>
     1ba:	06f70363          	beq	a4,a5,220 <main+0xa6>
     1be:	02e00613          	li	a2,46
     1c2:	00001597          	auipc	a1,0x1
     1c6:	20658593          	addi	a1,a1,518 # 13c8 <malloc+0x190>
     1ca:	00001517          	auipc	a0,0x1
     1ce:	20e50513          	addi	a0,a0,526 # 13d8 <malloc+0x1a0>
     1d2:	00001097          	auipc	ra,0x1
     1d6:	e74080e7          	jalr	-396(ra) # 1046 <printf>
     1da:	00001597          	auipc	a1,0x1
     1de:	20658593          	addi	a1,a1,518 # 13e0 <malloc+0x1a8>
     1e2:	00001517          	auipc	a0,0x1
     1e6:	21650513          	addi	a0,a0,534 # 13f8 <malloc+0x1c0>
     1ea:	00001097          	auipc	ra,0x1
     1ee:	e5c080e7          	jalr	-420(ra) # 1046 <printf>
     1f2:	00001517          	auipc	a0,0x1
     1f6:	21e50513          	addi	a0,a0,542 # 1410 <malloc+0x1d8>
     1fa:	00001097          	auipc	ra,0x1
     1fe:	e4c080e7          	jalr	-436(ra) # 1046 <printf>
     202:	00001797          	auipc	a5,0x1
     206:	2d278793          	addi	a5,a5,722 # 14d4 <ppid>
     20a:	439c                	lw	a5,0(a5)
     20c:	853e                	mv	a0,a5
     20e:	00001097          	auipc	ra,0x1
     212:	930080e7          	jalr	-1744(ra) # b3e <kill>
     216:	4501                	li	a0,0
     218:	00001097          	auipc	ra,0x1
     21c:	8f6080e7          	jalr	-1802(ra) # b0e <exit>

   int arg = 101;
     220:	06500793          	li	a5,101
     224:	fcf42a23          	sw	a5,-44(s0)
   void *arg_ptr = &arg;
     228:	fd440793          	addi	a5,s0,-44
     22c:	fef43023          	sd	a5,-32(s0)

   int i;
   for (i = 0; i < num_threads; i++) {
     230:	fe042623          	sw	zero,-20(s0)
     234:	a849                	j	2c6 <main+0x14c>
      int thread_pid = thread_create(worker, arg_ptr);
     236:	fe043583          	ld	a1,-32(s0)
     23a:	00000517          	auipc	a0,0x0
     23e:	15850513          	addi	a0,a0,344 # 392 <worker>
     242:	00000097          	auipc	ra,0x0
     246:	dbe080e7          	jalr	-578(ra) # 0 <thread_create>
     24a:	87aa                	mv	a5,a0
     24c:	fcf42c23          	sw	a5,-40(s0)
      assert(thread_pid > 0);
     250:	fd842783          	lw	a5,-40(s0)
     254:	2781                	sext.w	a5,a5
     256:	06f04363          	bgtz	a5,2bc <main+0x142>
     25a:	03600613          	li	a2,54
     25e:	00001597          	auipc	a1,0x1
     262:	16a58593          	addi	a1,a1,362 # 13c8 <malloc+0x190>
     266:	00001517          	auipc	a0,0x1
     26a:	17250513          	addi	a0,a0,370 # 13d8 <malloc+0x1a0>
     26e:	00001097          	auipc	ra,0x1
     272:	dd8080e7          	jalr	-552(ra) # 1046 <printf>
     276:	00001597          	auipc	a1,0x1
     27a:	1aa58593          	addi	a1,a1,426 # 1420 <malloc+0x1e8>
     27e:	00001517          	auipc	a0,0x1
     282:	17a50513          	addi	a0,a0,378 # 13f8 <malloc+0x1c0>
     286:	00001097          	auipc	ra,0x1
     28a:	dc0080e7          	jalr	-576(ra) # 1046 <printf>
     28e:	00001517          	auipc	a0,0x1
     292:	18250513          	addi	a0,a0,386 # 1410 <malloc+0x1d8>
     296:	00001097          	auipc	ra,0x1
     29a:	db0080e7          	jalr	-592(ra) # 1046 <printf>
     29e:	00001797          	auipc	a5,0x1
     2a2:	23678793          	addi	a5,a5,566 # 14d4 <ppid>
     2a6:	439c                	lw	a5,0(a5)
     2a8:	853e                	mv	a0,a5
     2aa:	00001097          	auipc	ra,0x1
     2ae:	894080e7          	jalr	-1900(ra) # b3e <kill>
     2b2:	4501                	li	a0,0
     2b4:	00001097          	auipc	ra,0x1
     2b8:	85a080e7          	jalr	-1958(ra) # b0e <exit>
   for (i = 0; i < num_threads; i++) {
     2bc:	fec42783          	lw	a5,-20(s0)
     2c0:	2785                	addiw	a5,a5,1
     2c2:	fef42623          	sw	a5,-20(s0)
     2c6:	00001797          	auipc	a5,0x1
     2ca:	20a78793          	addi	a5,a5,522 # 14d0 <num_threads>
     2ce:	4398                	lw	a4,0(a5)
     2d0:	fec42783          	lw	a5,-20(s0)
     2d4:	2781                	sext.w	a5,a5
     2d6:	f6e7c0e3          	blt	a5,a4,236 <main+0xbc>
   }

   for (i = 0; i < num_threads; i++) {
     2da:	fe042623          	sw	zero,-20(s0)
     2de:	a059                	j	364 <main+0x1ea>
      int join_pid = thread_join();
     2e0:	00000097          	auipc	ra,0x0
     2e4:	db2080e7          	jalr	-590(ra) # 92 <thread_join>
     2e8:	87aa                	mv	a5,a0
     2ea:	fcf42e23          	sw	a5,-36(s0)
      assert(join_pid > 0);
     2ee:	fdc42783          	lw	a5,-36(s0)
     2f2:	2781                	sext.w	a5,a5
     2f4:	06f04363          	bgtz	a5,35a <main+0x1e0>
     2f8:	03b00613          	li	a2,59
     2fc:	00001597          	auipc	a1,0x1
     300:	0cc58593          	addi	a1,a1,204 # 13c8 <malloc+0x190>
     304:	00001517          	auipc	a0,0x1
     308:	0d450513          	addi	a0,a0,212 # 13d8 <malloc+0x1a0>
     30c:	00001097          	auipc	ra,0x1
     310:	d3a080e7          	jalr	-710(ra) # 1046 <printf>
     314:	00001597          	auipc	a1,0x1
     318:	11c58593          	addi	a1,a1,284 # 1430 <malloc+0x1f8>
     31c:	00001517          	auipc	a0,0x1
     320:	0dc50513          	addi	a0,a0,220 # 13f8 <malloc+0x1c0>
     324:	00001097          	auipc	ra,0x1
     328:	d22080e7          	jalr	-734(ra) # 1046 <printf>
     32c:	00001517          	auipc	a0,0x1
     330:	0e450513          	addi	a0,a0,228 # 1410 <malloc+0x1d8>
     334:	00001097          	auipc	ra,0x1
     338:	d12080e7          	jalr	-750(ra) # 1046 <printf>
     33c:	00001797          	auipc	a5,0x1
     340:	19878793          	addi	a5,a5,408 # 14d4 <ppid>
     344:	439c                	lw	a5,0(a5)
     346:	853e                	mv	a0,a5
     348:	00000097          	auipc	ra,0x0
     34c:	7f6080e7          	jalr	2038(ra) # b3e <kill>
     350:	4501                	li	a0,0
     352:	00000097          	auipc	ra,0x0
     356:	7bc080e7          	jalr	1980(ra) # b0e <exit>
   for (i = 0; i < num_threads; i++) {
     35a:	fec42783          	lw	a5,-20(s0)
     35e:	2785                	addiw	a5,a5,1
     360:	fef42623          	sw	a5,-20(s0)
     364:	00001797          	auipc	a5,0x1
     368:	16c78793          	addi	a5,a5,364 # 14d0 <num_threads>
     36c:	4398                	lw	a4,0(a5)
     36e:	fec42783          	lw	a5,-20(s0)
     372:	2781                	sext.w	a5,a5
     374:	f6e7c6e3          	blt	a5,a4,2e0 <main+0x166>
   }

   printf("TEST PASSED\n");
     378:	00001517          	auipc	a0,0x1
     37c:	0c850513          	addi	a0,a0,200 # 1440 <malloc+0x208>
     380:	00001097          	auipc	ra,0x1
     384:	cc6080e7          	jalr	-826(ra) # 1046 <printf>
   exit(0);
     388:	4501                	li	a0,0
     38a:	00000097          	auipc	ra,0x0
     38e:	784080e7          	jalr	1924(ra) # b0e <exit>

0000000000000392 <worker>:
}

void
worker(void *arg_ptr) {
     392:	7179                	addi	sp,sp,-48
     394:	f406                	sd	ra,40(sp)
     396:	f022                	sd	s0,32(sp)
     398:	1800                	addi	s0,sp,48
     39a:	fca43c23          	sd	a0,-40(s0)
   int arg = *(int*)arg_ptr;
     39e:	fd843783          	ld	a5,-40(s0)
     3a2:	439c                	lw	a5,0(a5)
     3a4:	fef42623          	sw	a5,-20(s0)
   assert(arg == 101);
     3a8:	fec42783          	lw	a5,-20(s0)
     3ac:	0007871b          	sext.w	a4,a5
     3b0:	06500793          	li	a5,101
     3b4:	06f70363          	beq	a4,a5,41a <worker+0x88>
     3b8:	04500613          	li	a2,69
     3bc:	00001597          	auipc	a1,0x1
     3c0:	00c58593          	addi	a1,a1,12 # 13c8 <malloc+0x190>
     3c4:	00001517          	auipc	a0,0x1
     3c8:	01450513          	addi	a0,a0,20 # 13d8 <malloc+0x1a0>
     3cc:	00001097          	auipc	ra,0x1
     3d0:	c7a080e7          	jalr	-902(ra) # 1046 <printf>
     3d4:	00001597          	auipc	a1,0x1
     3d8:	07c58593          	addi	a1,a1,124 # 1450 <malloc+0x218>
     3dc:	00001517          	auipc	a0,0x1
     3e0:	01c50513          	addi	a0,a0,28 # 13f8 <malloc+0x1c0>
     3e4:	00001097          	auipc	ra,0x1
     3e8:	c62080e7          	jalr	-926(ra) # 1046 <printf>
     3ec:	00001517          	auipc	a0,0x1
     3f0:	02450513          	addi	a0,a0,36 # 1410 <malloc+0x1d8>
     3f4:	00001097          	auipc	ra,0x1
     3f8:	c52080e7          	jalr	-942(ra) # 1046 <printf>
     3fc:	00001797          	auipc	a5,0x1
     400:	0d878793          	addi	a5,a5,216 # 14d4 <ppid>
     404:	439c                	lw	a5,0(a5)
     406:	853e                	mv	a0,a5
     408:	00000097          	auipc	ra,0x0
     40c:	736080e7          	jalr	1846(ra) # b3e <kill>
     410:	4501                	li	a0,0
     412:	00000097          	auipc	ra,0x0
     416:	6fc080e7          	jalr	1788(ra) # b0e <exit>
   assert(global == 1);
     41a:	00001797          	auipc	a5,0x1
     41e:	0b278793          	addi	a5,a5,178 # 14cc <global>
     422:	439c                	lw	a5,0(a5)
     424:	873e                	mv	a4,a5
     426:	4785                	li	a5,1
     428:	06f70363          	beq	a4,a5,48e <worker+0xfc>
     42c:	04600613          	li	a2,70
     430:	00001597          	auipc	a1,0x1
     434:	f9858593          	addi	a1,a1,-104 # 13c8 <malloc+0x190>
     438:	00001517          	auipc	a0,0x1
     43c:	fa050513          	addi	a0,a0,-96 # 13d8 <malloc+0x1a0>
     440:	00001097          	auipc	ra,0x1
     444:	c06080e7          	jalr	-1018(ra) # 1046 <printf>
     448:	00001597          	auipc	a1,0x1
     44c:	01858593          	addi	a1,a1,24 # 1460 <malloc+0x228>
     450:	00001517          	auipc	a0,0x1
     454:	fa850513          	addi	a0,a0,-88 # 13f8 <malloc+0x1c0>
     458:	00001097          	auipc	ra,0x1
     45c:	bee080e7          	jalr	-1042(ra) # 1046 <printf>
     460:	00001517          	auipc	a0,0x1
     464:	fb050513          	addi	a0,a0,-80 # 1410 <malloc+0x1d8>
     468:	00001097          	auipc	ra,0x1
     46c:	bde080e7          	jalr	-1058(ra) # 1046 <printf>
     470:	00001797          	auipc	a5,0x1
     474:	06478793          	addi	a5,a5,100 # 14d4 <ppid>
     478:	439c                	lw	a5,0(a5)
     47a:	853e                	mv	a0,a5
     47c:	00000097          	auipc	ra,0x0
     480:	6c2080e7          	jalr	1730(ra) # b3e <kill>
     484:	4501                	li	a0,0
     486:	00000097          	auipc	ra,0x0
     48a:	688080e7          	jalr	1672(ra) # b0e <exit>
   assert(fib(2) == 1);
     48e:	4509                	li	a0,2
     490:	00000097          	auipc	ra,0x0
     494:	c7e080e7          	jalr	-898(ra) # 10e <fib>
     498:	87aa                	mv	a5,a0
     49a:	2781                	sext.w	a5,a5
     49c:	873e                	mv	a4,a5
     49e:	4785                	li	a5,1
     4a0:	06f70363          	beq	a4,a5,506 <worker+0x174>
     4a4:	04700613          	li	a2,71
     4a8:	00001597          	auipc	a1,0x1
     4ac:	f2058593          	addi	a1,a1,-224 # 13c8 <malloc+0x190>
     4b0:	00001517          	auipc	a0,0x1
     4b4:	f2850513          	addi	a0,a0,-216 # 13d8 <malloc+0x1a0>
     4b8:	00001097          	auipc	ra,0x1
     4bc:	b8e080e7          	jalr	-1138(ra) # 1046 <printf>
     4c0:	00001597          	auipc	a1,0x1
     4c4:	fb058593          	addi	a1,a1,-80 # 1470 <malloc+0x238>
     4c8:	00001517          	auipc	a0,0x1
     4cc:	f3050513          	addi	a0,a0,-208 # 13f8 <malloc+0x1c0>
     4d0:	00001097          	auipc	ra,0x1
     4d4:	b76080e7          	jalr	-1162(ra) # 1046 <printf>
     4d8:	00001517          	auipc	a0,0x1
     4dc:	f3850513          	addi	a0,a0,-200 # 1410 <malloc+0x1d8>
     4e0:	00001097          	auipc	ra,0x1
     4e4:	b66080e7          	jalr	-1178(ra) # 1046 <printf>
     4e8:	00001797          	auipc	a5,0x1
     4ec:	fec78793          	addi	a5,a5,-20 # 14d4 <ppid>
     4f0:	439c                	lw	a5,0(a5)
     4f2:	853e                	mv	a0,a5
     4f4:	00000097          	auipc	ra,0x0
     4f8:	64a080e7          	jalr	1610(ra) # b3e <kill>
     4fc:	4501                	li	a0,0
     4fe:	00000097          	auipc	ra,0x0
     502:	610080e7          	jalr	1552(ra) # b0e <exit>
   assert(fib(3) == 2);
     506:	450d                	li	a0,3
     508:	00000097          	auipc	ra,0x0
     50c:	c06080e7          	jalr	-1018(ra) # 10e <fib>
     510:	87aa                	mv	a5,a0
     512:	2781                	sext.w	a5,a5
     514:	873e                	mv	a4,a5
     516:	4789                	li	a5,2
     518:	06f70363          	beq	a4,a5,57e <worker+0x1ec>
     51c:	04800613          	li	a2,72
     520:	00001597          	auipc	a1,0x1
     524:	ea858593          	addi	a1,a1,-344 # 13c8 <malloc+0x190>
     528:	00001517          	auipc	a0,0x1
     52c:	eb050513          	addi	a0,a0,-336 # 13d8 <malloc+0x1a0>
     530:	00001097          	auipc	ra,0x1
     534:	b16080e7          	jalr	-1258(ra) # 1046 <printf>
     538:	00001597          	auipc	a1,0x1
     53c:	f4858593          	addi	a1,a1,-184 # 1480 <malloc+0x248>
     540:	00001517          	auipc	a0,0x1
     544:	eb850513          	addi	a0,a0,-328 # 13f8 <malloc+0x1c0>
     548:	00001097          	auipc	ra,0x1
     54c:	afe080e7          	jalr	-1282(ra) # 1046 <printf>
     550:	00001517          	auipc	a0,0x1
     554:	ec050513          	addi	a0,a0,-320 # 1410 <malloc+0x1d8>
     558:	00001097          	auipc	ra,0x1
     55c:	aee080e7          	jalr	-1298(ra) # 1046 <printf>
     560:	00001797          	auipc	a5,0x1
     564:	f7478793          	addi	a5,a5,-140 # 14d4 <ppid>
     568:	439c                	lw	a5,0(a5)
     56a:	853e                	mv	a0,a5
     56c:	00000097          	auipc	ra,0x0
     570:	5d2080e7          	jalr	1490(ra) # b3e <kill>
     574:	4501                	li	a0,0
     576:	00000097          	auipc	ra,0x0
     57a:	598080e7          	jalr	1432(ra) # b0e <exit>
   assert(fib(9) == 34);
     57e:	4525                	li	a0,9
     580:	00000097          	auipc	ra,0x0
     584:	b8e080e7          	jalr	-1138(ra) # 10e <fib>
     588:	87aa                	mv	a5,a0
     58a:	2781                	sext.w	a5,a5
     58c:	873e                	mv	a4,a5
     58e:	02200793          	li	a5,34
     592:	06f70363          	beq	a4,a5,5f8 <worker+0x266>
     596:	04900613          	li	a2,73
     59a:	00001597          	auipc	a1,0x1
     59e:	e2e58593          	addi	a1,a1,-466 # 13c8 <malloc+0x190>
     5a2:	00001517          	auipc	a0,0x1
     5a6:	e3650513          	addi	a0,a0,-458 # 13d8 <malloc+0x1a0>
     5aa:	00001097          	auipc	ra,0x1
     5ae:	a9c080e7          	jalr	-1380(ra) # 1046 <printf>
     5b2:	00001597          	auipc	a1,0x1
     5b6:	ede58593          	addi	a1,a1,-290 # 1490 <malloc+0x258>
     5ba:	00001517          	auipc	a0,0x1
     5be:	e3e50513          	addi	a0,a0,-450 # 13f8 <malloc+0x1c0>
     5c2:	00001097          	auipc	ra,0x1
     5c6:	a84080e7          	jalr	-1404(ra) # 1046 <printf>
     5ca:	00001517          	auipc	a0,0x1
     5ce:	e4650513          	addi	a0,a0,-442 # 1410 <malloc+0x1d8>
     5d2:	00001097          	auipc	ra,0x1
     5d6:	a74080e7          	jalr	-1420(ra) # 1046 <printf>
     5da:	00001797          	auipc	a5,0x1
     5de:	efa78793          	addi	a5,a5,-262 # 14d4 <ppid>
     5e2:	439c                	lw	a5,0(a5)
     5e4:	853e                	mv	a0,a5
     5e6:	00000097          	auipc	ra,0x0
     5ea:	558080e7          	jalr	1368(ra) # b3e <kill>
     5ee:	4501                	li	a0,0
     5f0:	00000097          	auipc	ra,0x0
     5f4:	51e080e7          	jalr	1310(ra) # b0e <exit>
   assert(fib(15) == 610);
     5f8:	453d                	li	a0,15
     5fa:	00000097          	auipc	ra,0x0
     5fe:	b14080e7          	jalr	-1260(ra) # 10e <fib>
     602:	87aa                	mv	a5,a0
     604:	2781                	sext.w	a5,a5
     606:	873e                	mv	a4,a5
     608:	26200793          	li	a5,610
     60c:	06f70363          	beq	a4,a5,672 <worker+0x2e0>
     610:	04a00613          	li	a2,74
     614:	00001597          	auipc	a1,0x1
     618:	db458593          	addi	a1,a1,-588 # 13c8 <malloc+0x190>
     61c:	00001517          	auipc	a0,0x1
     620:	dbc50513          	addi	a0,a0,-580 # 13d8 <malloc+0x1a0>
     624:	00001097          	auipc	ra,0x1
     628:	a22080e7          	jalr	-1502(ra) # 1046 <printf>
     62c:	00001597          	auipc	a1,0x1
     630:	e7458593          	addi	a1,a1,-396 # 14a0 <malloc+0x268>
     634:	00001517          	auipc	a0,0x1
     638:	dc450513          	addi	a0,a0,-572 # 13f8 <malloc+0x1c0>
     63c:	00001097          	auipc	ra,0x1
     640:	a0a080e7          	jalr	-1526(ra) # 1046 <printf>
     644:	00001517          	auipc	a0,0x1
     648:	dcc50513          	addi	a0,a0,-564 # 1410 <malloc+0x1d8>
     64c:	00001097          	auipc	ra,0x1
     650:	9fa080e7          	jalr	-1542(ra) # 1046 <printf>
     654:	00001797          	auipc	a5,0x1
     658:	e8078793          	addi	a5,a5,-384 # 14d4 <ppid>
     65c:	439c                	lw	a5,0(a5)
     65e:	853e                	mv	a0,a5
     660:	00000097          	auipc	ra,0x0
     664:	4de080e7          	jalr	1246(ra) # b3e <kill>
     668:	4501                	li	a0,0
     66a:	00000097          	auipc	ra,0x0
     66e:	4a4080e7          	jalr	1188(ra) # b0e <exit>
   exit(0);
     672:	4501                	li	a0,0
     674:	00000097          	auipc	ra,0x0
     678:	49a080e7          	jalr	1178(ra) # b0e <exit>

000000000000067c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     67c:	7179                	addi	sp,sp,-48
     67e:	f422                	sd	s0,40(sp)
     680:	1800                	addi	s0,sp,48
     682:	fca43c23          	sd	a0,-40(s0)
     686:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     68a:	fd843783          	ld	a5,-40(s0)
     68e:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     692:	0001                	nop
     694:	fd043703          	ld	a4,-48(s0)
     698:	00170793          	addi	a5,a4,1 # 1001 <fprintf+0x13>
     69c:	fcf43823          	sd	a5,-48(s0)
     6a0:	fd843783          	ld	a5,-40(s0)
     6a4:	00178693          	addi	a3,a5,1
     6a8:	fcd43c23          	sd	a3,-40(s0)
     6ac:	00074703          	lbu	a4,0(a4)
     6b0:	00e78023          	sb	a4,0(a5)
     6b4:	0007c783          	lbu	a5,0(a5)
     6b8:	fff1                	bnez	a5,694 <strcpy+0x18>
    ;
  return os;
     6ba:	fe843783          	ld	a5,-24(s0)
}
     6be:	853e                	mv	a0,a5
     6c0:	7422                	ld	s0,40(sp)
     6c2:	6145                	addi	sp,sp,48
     6c4:	8082                	ret

00000000000006c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     6c6:	1101                	addi	sp,sp,-32
     6c8:	ec22                	sd	s0,24(sp)
     6ca:	1000                	addi	s0,sp,32
     6cc:	fea43423          	sd	a0,-24(s0)
     6d0:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     6d4:	a819                	j	6ea <strcmp+0x24>
    p++, q++;
     6d6:	fe843783          	ld	a5,-24(s0)
     6da:	0785                	addi	a5,a5,1
     6dc:	fef43423          	sd	a5,-24(s0)
     6e0:	fe043783          	ld	a5,-32(s0)
     6e4:	0785                	addi	a5,a5,1
     6e6:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     6ea:	fe843783          	ld	a5,-24(s0)
     6ee:	0007c783          	lbu	a5,0(a5)
     6f2:	cb99                	beqz	a5,708 <strcmp+0x42>
     6f4:	fe843783          	ld	a5,-24(s0)
     6f8:	0007c703          	lbu	a4,0(a5)
     6fc:	fe043783          	ld	a5,-32(s0)
     700:	0007c783          	lbu	a5,0(a5)
     704:	fcf709e3          	beq	a4,a5,6d6 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     708:	fe843783          	ld	a5,-24(s0)
     70c:	0007c783          	lbu	a5,0(a5)
     710:	0007871b          	sext.w	a4,a5
     714:	fe043783          	ld	a5,-32(s0)
     718:	0007c783          	lbu	a5,0(a5)
     71c:	2781                	sext.w	a5,a5
     71e:	40f707bb          	subw	a5,a4,a5
     722:	2781                	sext.w	a5,a5
}
     724:	853e                	mv	a0,a5
     726:	6462                	ld	s0,24(sp)
     728:	6105                	addi	sp,sp,32
     72a:	8082                	ret

000000000000072c <strlen>:

uint
strlen(const char *s)
{
     72c:	7179                	addi	sp,sp,-48
     72e:	f422                	sd	s0,40(sp)
     730:	1800                	addi	s0,sp,48
     732:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     736:	fe042623          	sw	zero,-20(s0)
     73a:	a031                	j	746 <strlen+0x1a>
     73c:	fec42783          	lw	a5,-20(s0)
     740:	2785                	addiw	a5,a5,1
     742:	fef42623          	sw	a5,-20(s0)
     746:	fec42783          	lw	a5,-20(s0)
     74a:	fd843703          	ld	a4,-40(s0)
     74e:	97ba                	add	a5,a5,a4
     750:	0007c783          	lbu	a5,0(a5)
     754:	f7e5                	bnez	a5,73c <strlen+0x10>
    ;
  return n;
     756:	fec42783          	lw	a5,-20(s0)
}
     75a:	853e                	mv	a0,a5
     75c:	7422                	ld	s0,40(sp)
     75e:	6145                	addi	sp,sp,48
     760:	8082                	ret

0000000000000762 <memset>:

void*
memset(void *dst, int c, uint n)
{
     762:	7179                	addi	sp,sp,-48
     764:	f422                	sd	s0,40(sp)
     766:	1800                	addi	s0,sp,48
     768:	fca43c23          	sd	a0,-40(s0)
     76c:	87ae                	mv	a5,a1
     76e:	8732                	mv	a4,a2
     770:	fcf42a23          	sw	a5,-44(s0)
     774:	87ba                	mv	a5,a4
     776:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     77a:	fd843783          	ld	a5,-40(s0)
     77e:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     782:	fe042623          	sw	zero,-20(s0)
     786:	a00d                	j	7a8 <memset+0x46>
    cdst[i] = c;
     788:	fec42783          	lw	a5,-20(s0)
     78c:	fe043703          	ld	a4,-32(s0)
     790:	97ba                	add	a5,a5,a4
     792:	fd442703          	lw	a4,-44(s0)
     796:	0ff77713          	zext.b	a4,a4
     79a:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     79e:	fec42783          	lw	a5,-20(s0)
     7a2:	2785                	addiw	a5,a5,1
     7a4:	fef42623          	sw	a5,-20(s0)
     7a8:	fec42703          	lw	a4,-20(s0)
     7ac:	fd042783          	lw	a5,-48(s0)
     7b0:	2781                	sext.w	a5,a5
     7b2:	fcf76be3          	bltu	a4,a5,788 <memset+0x26>
  }
  return dst;
     7b6:	fd843783          	ld	a5,-40(s0)
}
     7ba:	853e                	mv	a0,a5
     7bc:	7422                	ld	s0,40(sp)
     7be:	6145                	addi	sp,sp,48
     7c0:	8082                	ret

00000000000007c2 <strchr>:

char*
strchr(const char *s, char c)
{
     7c2:	1101                	addi	sp,sp,-32
     7c4:	ec22                	sd	s0,24(sp)
     7c6:	1000                	addi	s0,sp,32
     7c8:	fea43423          	sd	a0,-24(s0)
     7cc:	87ae                	mv	a5,a1
     7ce:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     7d2:	a01d                	j	7f8 <strchr+0x36>
    if(*s == c)
     7d4:	fe843783          	ld	a5,-24(s0)
     7d8:	0007c703          	lbu	a4,0(a5)
     7dc:	fe744783          	lbu	a5,-25(s0)
     7e0:	0ff7f793          	zext.b	a5,a5
     7e4:	00e79563          	bne	a5,a4,7ee <strchr+0x2c>
      return (char*)s;
     7e8:	fe843783          	ld	a5,-24(s0)
     7ec:	a821                	j	804 <strchr+0x42>
  for(; *s; s++)
     7ee:	fe843783          	ld	a5,-24(s0)
     7f2:	0785                	addi	a5,a5,1
     7f4:	fef43423          	sd	a5,-24(s0)
     7f8:	fe843783          	ld	a5,-24(s0)
     7fc:	0007c783          	lbu	a5,0(a5)
     800:	fbf1                	bnez	a5,7d4 <strchr+0x12>
  return 0;
     802:	4781                	li	a5,0
}
     804:	853e                	mv	a0,a5
     806:	6462                	ld	s0,24(sp)
     808:	6105                	addi	sp,sp,32
     80a:	8082                	ret

000000000000080c <gets>:

char*
gets(char *buf, int max)
{
     80c:	7179                	addi	sp,sp,-48
     80e:	f406                	sd	ra,40(sp)
     810:	f022                	sd	s0,32(sp)
     812:	1800                	addi	s0,sp,48
     814:	fca43c23          	sd	a0,-40(s0)
     818:	87ae                	mv	a5,a1
     81a:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     81e:	fe042623          	sw	zero,-20(s0)
     822:	a8a1                	j	87a <gets+0x6e>
    cc = read(0, &c, 1);
     824:	fe740793          	addi	a5,s0,-25
     828:	4605                	li	a2,1
     82a:	85be                	mv	a1,a5
     82c:	4501                	li	a0,0
     82e:	00000097          	auipc	ra,0x0
     832:	2f8080e7          	jalr	760(ra) # b26 <read>
     836:	87aa                	mv	a5,a0
     838:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     83c:	fe842783          	lw	a5,-24(s0)
     840:	2781                	sext.w	a5,a5
     842:	04f05763          	blez	a5,890 <gets+0x84>
      break;
    buf[i++] = c;
     846:	fec42783          	lw	a5,-20(s0)
     84a:	0017871b          	addiw	a4,a5,1
     84e:	fee42623          	sw	a4,-20(s0)
     852:	873e                	mv	a4,a5
     854:	fd843783          	ld	a5,-40(s0)
     858:	97ba                	add	a5,a5,a4
     85a:	fe744703          	lbu	a4,-25(s0)
     85e:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     862:	fe744783          	lbu	a5,-25(s0)
     866:	873e                	mv	a4,a5
     868:	47a9                	li	a5,10
     86a:	02f70463          	beq	a4,a5,892 <gets+0x86>
     86e:	fe744783          	lbu	a5,-25(s0)
     872:	873e                	mv	a4,a5
     874:	47b5                	li	a5,13
     876:	00f70e63          	beq	a4,a5,892 <gets+0x86>
  for(i=0; i+1 < max; ){
     87a:	fec42783          	lw	a5,-20(s0)
     87e:	2785                	addiw	a5,a5,1
     880:	0007871b          	sext.w	a4,a5
     884:	fd442783          	lw	a5,-44(s0)
     888:	2781                	sext.w	a5,a5
     88a:	f8f74de3          	blt	a4,a5,824 <gets+0x18>
     88e:	a011                	j	892 <gets+0x86>
      break;
     890:	0001                	nop
      break;
  }
  buf[i] = '\0';
     892:	fec42783          	lw	a5,-20(s0)
     896:	fd843703          	ld	a4,-40(s0)
     89a:	97ba                	add	a5,a5,a4
     89c:	00078023          	sb	zero,0(a5)
  return buf;
     8a0:	fd843783          	ld	a5,-40(s0)
}
     8a4:	853e                	mv	a0,a5
     8a6:	70a2                	ld	ra,40(sp)
     8a8:	7402                	ld	s0,32(sp)
     8aa:	6145                	addi	sp,sp,48
     8ac:	8082                	ret

00000000000008ae <stat>:

int
stat(const char *n, struct stat *st)
{
     8ae:	7179                	addi	sp,sp,-48
     8b0:	f406                	sd	ra,40(sp)
     8b2:	f022                	sd	s0,32(sp)
     8b4:	1800                	addi	s0,sp,48
     8b6:	fca43c23          	sd	a0,-40(s0)
     8ba:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     8be:	4581                	li	a1,0
     8c0:	fd843503          	ld	a0,-40(s0)
     8c4:	00000097          	auipc	ra,0x0
     8c8:	28a080e7          	jalr	650(ra) # b4e <open>
     8cc:	87aa                	mv	a5,a0
     8ce:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     8d2:	fec42783          	lw	a5,-20(s0)
     8d6:	2781                	sext.w	a5,a5
     8d8:	0007d463          	bgez	a5,8e0 <stat+0x32>
    return -1;
     8dc:	57fd                	li	a5,-1
     8de:	a035                	j	90a <stat+0x5c>
  r = fstat(fd, st);
     8e0:	fec42783          	lw	a5,-20(s0)
     8e4:	fd043583          	ld	a1,-48(s0)
     8e8:	853e                	mv	a0,a5
     8ea:	00000097          	auipc	ra,0x0
     8ee:	27c080e7          	jalr	636(ra) # b66 <fstat>
     8f2:	87aa                	mv	a5,a0
     8f4:	fef42423          	sw	a5,-24(s0)
  close(fd);
     8f8:	fec42783          	lw	a5,-20(s0)
     8fc:	853e                	mv	a0,a5
     8fe:	00000097          	auipc	ra,0x0
     902:	238080e7          	jalr	568(ra) # b36 <close>
  return r;
     906:	fe842783          	lw	a5,-24(s0)
}
     90a:	853e                	mv	a0,a5
     90c:	70a2                	ld	ra,40(sp)
     90e:	7402                	ld	s0,32(sp)
     910:	6145                	addi	sp,sp,48
     912:	8082                	ret

0000000000000914 <atoi>:

int
atoi(const char *s)
{
     914:	7179                	addi	sp,sp,-48
     916:	f422                	sd	s0,40(sp)
     918:	1800                	addi	s0,sp,48
     91a:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     91e:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     922:	a81d                	j	958 <atoi+0x44>
    n = n*10 + *s++ - '0';
     924:	fec42783          	lw	a5,-20(s0)
     928:	873e                	mv	a4,a5
     92a:	87ba                	mv	a5,a4
     92c:	0027979b          	slliw	a5,a5,0x2
     930:	9fb9                	addw	a5,a5,a4
     932:	0017979b          	slliw	a5,a5,0x1
     936:	0007871b          	sext.w	a4,a5
     93a:	fd843783          	ld	a5,-40(s0)
     93e:	00178693          	addi	a3,a5,1
     942:	fcd43c23          	sd	a3,-40(s0)
     946:	0007c783          	lbu	a5,0(a5)
     94a:	2781                	sext.w	a5,a5
     94c:	9fb9                	addw	a5,a5,a4
     94e:	2781                	sext.w	a5,a5
     950:	fd07879b          	addiw	a5,a5,-48
     954:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     958:	fd843783          	ld	a5,-40(s0)
     95c:	0007c783          	lbu	a5,0(a5)
     960:	873e                	mv	a4,a5
     962:	02f00793          	li	a5,47
     966:	00e7fb63          	bgeu	a5,a4,97c <atoi+0x68>
     96a:	fd843783          	ld	a5,-40(s0)
     96e:	0007c783          	lbu	a5,0(a5)
     972:	873e                	mv	a4,a5
     974:	03900793          	li	a5,57
     978:	fae7f6e3          	bgeu	a5,a4,924 <atoi+0x10>
  return n;
     97c:	fec42783          	lw	a5,-20(s0)
}
     980:	853e                	mv	a0,a5
     982:	7422                	ld	s0,40(sp)
     984:	6145                	addi	sp,sp,48
     986:	8082                	ret

0000000000000988 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     988:	7139                	addi	sp,sp,-64
     98a:	fc22                	sd	s0,56(sp)
     98c:	0080                	addi	s0,sp,64
     98e:	fca43c23          	sd	a0,-40(s0)
     992:	fcb43823          	sd	a1,-48(s0)
     996:	87b2                	mv	a5,a2
     998:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     99c:	fd843783          	ld	a5,-40(s0)
     9a0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     9a4:	fd043783          	ld	a5,-48(s0)
     9a8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     9ac:	fe043703          	ld	a4,-32(s0)
     9b0:	fe843783          	ld	a5,-24(s0)
     9b4:	02e7fc63          	bgeu	a5,a4,9ec <memmove+0x64>
    while(n-- > 0)
     9b8:	a00d                	j	9da <memmove+0x52>
      *dst++ = *src++;
     9ba:	fe043703          	ld	a4,-32(s0)
     9be:	00170793          	addi	a5,a4,1
     9c2:	fef43023          	sd	a5,-32(s0)
     9c6:	fe843783          	ld	a5,-24(s0)
     9ca:	00178693          	addi	a3,a5,1
     9ce:	fed43423          	sd	a3,-24(s0)
     9d2:	00074703          	lbu	a4,0(a4)
     9d6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     9da:	fcc42783          	lw	a5,-52(s0)
     9de:	fff7871b          	addiw	a4,a5,-1
     9e2:	fce42623          	sw	a4,-52(s0)
     9e6:	fcf04ae3          	bgtz	a5,9ba <memmove+0x32>
     9ea:	a891                	j	a3e <memmove+0xb6>
  } else {
    dst += n;
     9ec:	fcc42783          	lw	a5,-52(s0)
     9f0:	fe843703          	ld	a4,-24(s0)
     9f4:	97ba                	add	a5,a5,a4
     9f6:	fef43423          	sd	a5,-24(s0)
    src += n;
     9fa:	fcc42783          	lw	a5,-52(s0)
     9fe:	fe043703          	ld	a4,-32(s0)
     a02:	97ba                	add	a5,a5,a4
     a04:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     a08:	a01d                	j	a2e <memmove+0xa6>
      *--dst = *--src;
     a0a:	fe043783          	ld	a5,-32(s0)
     a0e:	17fd                	addi	a5,a5,-1
     a10:	fef43023          	sd	a5,-32(s0)
     a14:	fe843783          	ld	a5,-24(s0)
     a18:	17fd                	addi	a5,a5,-1
     a1a:	fef43423          	sd	a5,-24(s0)
     a1e:	fe043783          	ld	a5,-32(s0)
     a22:	0007c703          	lbu	a4,0(a5)
     a26:	fe843783          	ld	a5,-24(s0)
     a2a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     a2e:	fcc42783          	lw	a5,-52(s0)
     a32:	fff7871b          	addiw	a4,a5,-1
     a36:	fce42623          	sw	a4,-52(s0)
     a3a:	fcf048e3          	bgtz	a5,a0a <memmove+0x82>
  }
  return vdst;
     a3e:	fd843783          	ld	a5,-40(s0)
}
     a42:	853e                	mv	a0,a5
     a44:	7462                	ld	s0,56(sp)
     a46:	6121                	addi	sp,sp,64
     a48:	8082                	ret

0000000000000a4a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     a4a:	7139                	addi	sp,sp,-64
     a4c:	fc22                	sd	s0,56(sp)
     a4e:	0080                	addi	s0,sp,64
     a50:	fca43c23          	sd	a0,-40(s0)
     a54:	fcb43823          	sd	a1,-48(s0)
     a58:	87b2                	mv	a5,a2
     a5a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     a5e:	fd843783          	ld	a5,-40(s0)
     a62:	fef43423          	sd	a5,-24(s0)
     a66:	fd043783          	ld	a5,-48(s0)
     a6a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     a6e:	a0a1                	j	ab6 <memcmp+0x6c>
    if (*p1 != *p2) {
     a70:	fe843783          	ld	a5,-24(s0)
     a74:	0007c703          	lbu	a4,0(a5)
     a78:	fe043783          	ld	a5,-32(s0)
     a7c:	0007c783          	lbu	a5,0(a5)
     a80:	02f70163          	beq	a4,a5,aa2 <memcmp+0x58>
      return *p1 - *p2;
     a84:	fe843783          	ld	a5,-24(s0)
     a88:	0007c783          	lbu	a5,0(a5)
     a8c:	0007871b          	sext.w	a4,a5
     a90:	fe043783          	ld	a5,-32(s0)
     a94:	0007c783          	lbu	a5,0(a5)
     a98:	2781                	sext.w	a5,a5
     a9a:	40f707bb          	subw	a5,a4,a5
     a9e:	2781                	sext.w	a5,a5
     aa0:	a01d                	j	ac6 <memcmp+0x7c>
    }
    p1++;
     aa2:	fe843783          	ld	a5,-24(s0)
     aa6:	0785                	addi	a5,a5,1
     aa8:	fef43423          	sd	a5,-24(s0)
    p2++;
     aac:	fe043783          	ld	a5,-32(s0)
     ab0:	0785                	addi	a5,a5,1
     ab2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     ab6:	fcc42783          	lw	a5,-52(s0)
     aba:	fff7871b          	addiw	a4,a5,-1
     abe:	fce42623          	sw	a4,-52(s0)
     ac2:	f7dd                	bnez	a5,a70 <memcmp+0x26>
  }
  return 0;
     ac4:	4781                	li	a5,0
}
     ac6:	853e                	mv	a0,a5
     ac8:	7462                	ld	s0,56(sp)
     aca:	6121                	addi	sp,sp,64
     acc:	8082                	ret

0000000000000ace <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     ace:	7179                	addi	sp,sp,-48
     ad0:	f406                	sd	ra,40(sp)
     ad2:	f022                	sd	s0,32(sp)
     ad4:	1800                	addi	s0,sp,48
     ad6:	fea43423          	sd	a0,-24(s0)
     ada:	feb43023          	sd	a1,-32(s0)
     ade:	87b2                	mv	a5,a2
     ae0:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     ae4:	fdc42783          	lw	a5,-36(s0)
     ae8:	863e                	mv	a2,a5
     aea:	fe043583          	ld	a1,-32(s0)
     aee:	fe843503          	ld	a0,-24(s0)
     af2:	00000097          	auipc	ra,0x0
     af6:	e96080e7          	jalr	-362(ra) # 988 <memmove>
     afa:	87aa                	mv	a5,a0
}
     afc:	853e                	mv	a0,a5
     afe:	70a2                	ld	ra,40(sp)
     b00:	7402                	ld	s0,32(sp)
     b02:	6145                	addi	sp,sp,48
     b04:	8082                	ret

0000000000000b06 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     b06:	4885                	li	a7,1
 ecall
     b08:	00000073          	ecall
 ret
     b0c:	8082                	ret

0000000000000b0e <exit>:
.global exit
exit:
 li a7, SYS_exit
     b0e:	4889                	li	a7,2
 ecall
     b10:	00000073          	ecall
 ret
     b14:	8082                	ret

0000000000000b16 <wait>:
.global wait
wait:
 li a7, SYS_wait
     b16:	488d                	li	a7,3
 ecall
     b18:	00000073          	ecall
 ret
     b1c:	8082                	ret

0000000000000b1e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     b1e:	4891                	li	a7,4
 ecall
     b20:	00000073          	ecall
 ret
     b24:	8082                	ret

0000000000000b26 <read>:
.global read
read:
 li a7, SYS_read
     b26:	4895                	li	a7,5
 ecall
     b28:	00000073          	ecall
 ret
     b2c:	8082                	ret

0000000000000b2e <write>:
.global write
write:
 li a7, SYS_write
     b2e:	48c1                	li	a7,16
 ecall
     b30:	00000073          	ecall
 ret
     b34:	8082                	ret

0000000000000b36 <close>:
.global close
close:
 li a7, SYS_close
     b36:	48d5                	li	a7,21
 ecall
     b38:	00000073          	ecall
 ret
     b3c:	8082                	ret

0000000000000b3e <kill>:
.global kill
kill:
 li a7, SYS_kill
     b3e:	4899                	li	a7,6
 ecall
     b40:	00000073          	ecall
 ret
     b44:	8082                	ret

0000000000000b46 <exec>:
.global exec
exec:
 li a7, SYS_exec
     b46:	489d                	li	a7,7
 ecall
     b48:	00000073          	ecall
 ret
     b4c:	8082                	ret

0000000000000b4e <open>:
.global open
open:
 li a7, SYS_open
     b4e:	48bd                	li	a7,15
 ecall
     b50:	00000073          	ecall
 ret
     b54:	8082                	ret

0000000000000b56 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     b56:	48c5                	li	a7,17
 ecall
     b58:	00000073          	ecall
 ret
     b5c:	8082                	ret

0000000000000b5e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     b5e:	48c9                	li	a7,18
 ecall
     b60:	00000073          	ecall
 ret
     b64:	8082                	ret

0000000000000b66 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     b66:	48a1                	li	a7,8
 ecall
     b68:	00000073          	ecall
 ret
     b6c:	8082                	ret

0000000000000b6e <link>:
.global link
link:
 li a7, SYS_link
     b6e:	48cd                	li	a7,19
 ecall
     b70:	00000073          	ecall
 ret
     b74:	8082                	ret

0000000000000b76 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     b76:	48d1                	li	a7,20
 ecall
     b78:	00000073          	ecall
 ret
     b7c:	8082                	ret

0000000000000b7e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     b7e:	48a5                	li	a7,9
 ecall
     b80:	00000073          	ecall
 ret
     b84:	8082                	ret

0000000000000b86 <dup>:
.global dup
dup:
 li a7, SYS_dup
     b86:	48a9                	li	a7,10
 ecall
     b88:	00000073          	ecall
 ret
     b8c:	8082                	ret

0000000000000b8e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     b8e:	48ad                	li	a7,11
 ecall
     b90:	00000073          	ecall
 ret
     b94:	8082                	ret

0000000000000b96 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     b96:	48b1                	li	a7,12
 ecall
     b98:	00000073          	ecall
 ret
     b9c:	8082                	ret

0000000000000b9e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     b9e:	48b5                	li	a7,13
 ecall
     ba0:	00000073          	ecall
 ret
     ba4:	8082                	ret

0000000000000ba6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     ba6:	48b9                	li	a7,14
 ecall
     ba8:	00000073          	ecall
 ret
     bac:	8082                	ret

0000000000000bae <clone>:
.global clone
clone:
 li a7, SYS_clone
     bae:	48d9                	li	a7,22
 ecall
     bb0:	00000073          	ecall
 ret
     bb4:	8082                	ret

0000000000000bb6 <join>:
.global join
join:
 li a7, SYS_join
     bb6:	48dd                	li	a7,23
 ecall
     bb8:	00000073          	ecall
 ret
     bbc:	8082                	ret

0000000000000bbe <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     bbe:	1101                	addi	sp,sp,-32
     bc0:	ec06                	sd	ra,24(sp)
     bc2:	e822                	sd	s0,16(sp)
     bc4:	1000                	addi	s0,sp,32
     bc6:	87aa                	mv	a5,a0
     bc8:	872e                	mv	a4,a1
     bca:	fef42623          	sw	a5,-20(s0)
     bce:	87ba                	mv	a5,a4
     bd0:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     bd4:	feb40713          	addi	a4,s0,-21
     bd8:	fec42783          	lw	a5,-20(s0)
     bdc:	4605                	li	a2,1
     bde:	85ba                	mv	a1,a4
     be0:	853e                	mv	a0,a5
     be2:	00000097          	auipc	ra,0x0
     be6:	f4c080e7          	jalr	-180(ra) # b2e <write>
}
     bea:	0001                	nop
     bec:	60e2                	ld	ra,24(sp)
     bee:	6442                	ld	s0,16(sp)
     bf0:	6105                	addi	sp,sp,32
     bf2:	8082                	ret

0000000000000bf4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     bf4:	7139                	addi	sp,sp,-64
     bf6:	fc06                	sd	ra,56(sp)
     bf8:	f822                	sd	s0,48(sp)
     bfa:	0080                	addi	s0,sp,64
     bfc:	87aa                	mv	a5,a0
     bfe:	8736                	mv	a4,a3
     c00:	fcf42623          	sw	a5,-52(s0)
     c04:	87ae                	mv	a5,a1
     c06:	fcf42423          	sw	a5,-56(s0)
     c0a:	87b2                	mv	a5,a2
     c0c:	fcf42223          	sw	a5,-60(s0)
     c10:	87ba                	mv	a5,a4
     c12:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     c16:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     c1a:	fc042783          	lw	a5,-64(s0)
     c1e:	2781                	sext.w	a5,a5
     c20:	c38d                	beqz	a5,c42 <printint+0x4e>
     c22:	fc842783          	lw	a5,-56(s0)
     c26:	2781                	sext.w	a5,a5
     c28:	0007dd63          	bgez	a5,c42 <printint+0x4e>
    neg = 1;
     c2c:	4785                	li	a5,1
     c2e:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     c32:	fc842783          	lw	a5,-56(s0)
     c36:	40f007bb          	negw	a5,a5
     c3a:	2781                	sext.w	a5,a5
     c3c:	fef42223          	sw	a5,-28(s0)
     c40:	a029                	j	c4a <printint+0x56>
  } else {
    x = xx;
     c42:	fc842783          	lw	a5,-56(s0)
     c46:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     c4a:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     c4e:	fc442783          	lw	a5,-60(s0)
     c52:	fe442703          	lw	a4,-28(s0)
     c56:	02f777bb          	remuw	a5,a4,a5
     c5a:	0007861b          	sext.w	a2,a5
     c5e:	fec42783          	lw	a5,-20(s0)
     c62:	0017871b          	addiw	a4,a5,1
     c66:	fee42623          	sw	a4,-20(s0)
     c6a:	00001697          	auipc	a3,0x1
     c6e:	84e68693          	addi	a3,a3,-1970 # 14b8 <digits>
     c72:	02061713          	slli	a4,a2,0x20
     c76:	9301                	srli	a4,a4,0x20
     c78:	9736                	add	a4,a4,a3
     c7a:	00074703          	lbu	a4,0(a4)
     c7e:	17c1                	addi	a5,a5,-16
     c80:	97a2                	add	a5,a5,s0
     c82:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     c86:	fc442783          	lw	a5,-60(s0)
     c8a:	fe442703          	lw	a4,-28(s0)
     c8e:	02f757bb          	divuw	a5,a4,a5
     c92:	fef42223          	sw	a5,-28(s0)
     c96:	fe442783          	lw	a5,-28(s0)
     c9a:	2781                	sext.w	a5,a5
     c9c:	fbcd                	bnez	a5,c4e <printint+0x5a>
  if(neg)
     c9e:	fe842783          	lw	a5,-24(s0)
     ca2:	2781                	sext.w	a5,a5
     ca4:	cf85                	beqz	a5,cdc <printint+0xe8>
    buf[i++] = '-';
     ca6:	fec42783          	lw	a5,-20(s0)
     caa:	0017871b          	addiw	a4,a5,1
     cae:	fee42623          	sw	a4,-20(s0)
     cb2:	17c1                	addi	a5,a5,-16
     cb4:	97a2                	add	a5,a5,s0
     cb6:	02d00713          	li	a4,45
     cba:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     cbe:	a839                	j	cdc <printint+0xe8>
    putc(fd, buf[i]);
     cc0:	fec42783          	lw	a5,-20(s0)
     cc4:	17c1                	addi	a5,a5,-16
     cc6:	97a2                	add	a5,a5,s0
     cc8:	fe07c703          	lbu	a4,-32(a5)
     ccc:	fcc42783          	lw	a5,-52(s0)
     cd0:	85ba                	mv	a1,a4
     cd2:	853e                	mv	a0,a5
     cd4:	00000097          	auipc	ra,0x0
     cd8:	eea080e7          	jalr	-278(ra) # bbe <putc>
  while(--i >= 0)
     cdc:	fec42783          	lw	a5,-20(s0)
     ce0:	37fd                	addiw	a5,a5,-1
     ce2:	fef42623          	sw	a5,-20(s0)
     ce6:	fec42783          	lw	a5,-20(s0)
     cea:	2781                	sext.w	a5,a5
     cec:	fc07dae3          	bgez	a5,cc0 <printint+0xcc>
}
     cf0:	0001                	nop
     cf2:	0001                	nop
     cf4:	70e2                	ld	ra,56(sp)
     cf6:	7442                	ld	s0,48(sp)
     cf8:	6121                	addi	sp,sp,64
     cfa:	8082                	ret

0000000000000cfc <printptr>:

static void
printptr(int fd, uint64 x) {
     cfc:	7179                	addi	sp,sp,-48
     cfe:	f406                	sd	ra,40(sp)
     d00:	f022                	sd	s0,32(sp)
     d02:	1800                	addi	s0,sp,48
     d04:	87aa                	mv	a5,a0
     d06:	fcb43823          	sd	a1,-48(s0)
     d0a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     d0e:	fdc42783          	lw	a5,-36(s0)
     d12:	03000593          	li	a1,48
     d16:	853e                	mv	a0,a5
     d18:	00000097          	auipc	ra,0x0
     d1c:	ea6080e7          	jalr	-346(ra) # bbe <putc>
  putc(fd, 'x');
     d20:	fdc42783          	lw	a5,-36(s0)
     d24:	07800593          	li	a1,120
     d28:	853e                	mv	a0,a5
     d2a:	00000097          	auipc	ra,0x0
     d2e:	e94080e7          	jalr	-364(ra) # bbe <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     d32:	fe042623          	sw	zero,-20(s0)
     d36:	a82d                	j	d70 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     d38:	fd043783          	ld	a5,-48(s0)
     d3c:	93f1                	srli	a5,a5,0x3c
     d3e:	00000717          	auipc	a4,0x0
     d42:	77a70713          	addi	a4,a4,1914 # 14b8 <digits>
     d46:	97ba                	add	a5,a5,a4
     d48:	0007c703          	lbu	a4,0(a5)
     d4c:	fdc42783          	lw	a5,-36(s0)
     d50:	85ba                	mv	a1,a4
     d52:	853e                	mv	a0,a5
     d54:	00000097          	auipc	ra,0x0
     d58:	e6a080e7          	jalr	-406(ra) # bbe <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     d5c:	fec42783          	lw	a5,-20(s0)
     d60:	2785                	addiw	a5,a5,1
     d62:	fef42623          	sw	a5,-20(s0)
     d66:	fd043783          	ld	a5,-48(s0)
     d6a:	0792                	slli	a5,a5,0x4
     d6c:	fcf43823          	sd	a5,-48(s0)
     d70:	fec42783          	lw	a5,-20(s0)
     d74:	873e                	mv	a4,a5
     d76:	47bd                	li	a5,15
     d78:	fce7f0e3          	bgeu	a5,a4,d38 <printptr+0x3c>
}
     d7c:	0001                	nop
     d7e:	0001                	nop
     d80:	70a2                	ld	ra,40(sp)
     d82:	7402                	ld	s0,32(sp)
     d84:	6145                	addi	sp,sp,48
     d86:	8082                	ret

0000000000000d88 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     d88:	715d                	addi	sp,sp,-80
     d8a:	e486                	sd	ra,72(sp)
     d8c:	e0a2                	sd	s0,64(sp)
     d8e:	0880                	addi	s0,sp,80
     d90:	87aa                	mv	a5,a0
     d92:	fcb43023          	sd	a1,-64(s0)
     d96:	fac43c23          	sd	a2,-72(s0)
     d9a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     d9e:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     da2:	fe042223          	sw	zero,-28(s0)
     da6:	a42d                	j	fd0 <vprintf+0x248>
    c = fmt[i] & 0xff;
     da8:	fe442783          	lw	a5,-28(s0)
     dac:	fc043703          	ld	a4,-64(s0)
     db0:	97ba                	add	a5,a5,a4
     db2:	0007c783          	lbu	a5,0(a5)
     db6:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     dba:	fe042783          	lw	a5,-32(s0)
     dbe:	2781                	sext.w	a5,a5
     dc0:	eb9d                	bnez	a5,df6 <vprintf+0x6e>
      if(c == '%'){
     dc2:	fdc42783          	lw	a5,-36(s0)
     dc6:	0007871b          	sext.w	a4,a5
     dca:	02500793          	li	a5,37
     dce:	00f71763          	bne	a4,a5,ddc <vprintf+0x54>
        state = '%';
     dd2:	02500793          	li	a5,37
     dd6:	fef42023          	sw	a5,-32(s0)
     dda:	a2f5                	j	fc6 <vprintf+0x23e>
      } else {
        putc(fd, c);
     ddc:	fdc42783          	lw	a5,-36(s0)
     de0:	0ff7f713          	zext.b	a4,a5
     de4:	fcc42783          	lw	a5,-52(s0)
     de8:	85ba                	mv	a1,a4
     dea:	853e                	mv	a0,a5
     dec:	00000097          	auipc	ra,0x0
     df0:	dd2080e7          	jalr	-558(ra) # bbe <putc>
     df4:	aac9                	j	fc6 <vprintf+0x23e>
      }
    } else if(state == '%'){
     df6:	fe042783          	lw	a5,-32(s0)
     dfa:	0007871b          	sext.w	a4,a5
     dfe:	02500793          	li	a5,37
     e02:	1cf71263          	bne	a4,a5,fc6 <vprintf+0x23e>
      if(c == 'd'){
     e06:	fdc42783          	lw	a5,-36(s0)
     e0a:	0007871b          	sext.w	a4,a5
     e0e:	06400793          	li	a5,100
     e12:	02f71463          	bne	a4,a5,e3a <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     e16:	fb843783          	ld	a5,-72(s0)
     e1a:	00878713          	addi	a4,a5,8
     e1e:	fae43c23          	sd	a4,-72(s0)
     e22:	4398                	lw	a4,0(a5)
     e24:	fcc42783          	lw	a5,-52(s0)
     e28:	4685                	li	a3,1
     e2a:	4629                	li	a2,10
     e2c:	85ba                	mv	a1,a4
     e2e:	853e                	mv	a0,a5
     e30:	00000097          	auipc	ra,0x0
     e34:	dc4080e7          	jalr	-572(ra) # bf4 <printint>
     e38:	a269                	j	fc2 <vprintf+0x23a>
      } else if(c == 'l') {
     e3a:	fdc42783          	lw	a5,-36(s0)
     e3e:	0007871b          	sext.w	a4,a5
     e42:	06c00793          	li	a5,108
     e46:	02f71663          	bne	a4,a5,e72 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     e4a:	fb843783          	ld	a5,-72(s0)
     e4e:	00878713          	addi	a4,a5,8
     e52:	fae43c23          	sd	a4,-72(s0)
     e56:	639c                	ld	a5,0(a5)
     e58:	0007871b          	sext.w	a4,a5
     e5c:	fcc42783          	lw	a5,-52(s0)
     e60:	4681                	li	a3,0
     e62:	4629                	li	a2,10
     e64:	85ba                	mv	a1,a4
     e66:	853e                	mv	a0,a5
     e68:	00000097          	auipc	ra,0x0
     e6c:	d8c080e7          	jalr	-628(ra) # bf4 <printint>
     e70:	aa89                	j	fc2 <vprintf+0x23a>
      } else if(c == 'x') {
     e72:	fdc42783          	lw	a5,-36(s0)
     e76:	0007871b          	sext.w	a4,a5
     e7a:	07800793          	li	a5,120
     e7e:	02f71463          	bne	a4,a5,ea6 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     e82:	fb843783          	ld	a5,-72(s0)
     e86:	00878713          	addi	a4,a5,8
     e8a:	fae43c23          	sd	a4,-72(s0)
     e8e:	4398                	lw	a4,0(a5)
     e90:	fcc42783          	lw	a5,-52(s0)
     e94:	4681                	li	a3,0
     e96:	4641                	li	a2,16
     e98:	85ba                	mv	a1,a4
     e9a:	853e                	mv	a0,a5
     e9c:	00000097          	auipc	ra,0x0
     ea0:	d58080e7          	jalr	-680(ra) # bf4 <printint>
     ea4:	aa39                	j	fc2 <vprintf+0x23a>
      } else if(c == 'p') {
     ea6:	fdc42783          	lw	a5,-36(s0)
     eaa:	0007871b          	sext.w	a4,a5
     eae:	07000793          	li	a5,112
     eb2:	02f71263          	bne	a4,a5,ed6 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     eb6:	fb843783          	ld	a5,-72(s0)
     eba:	00878713          	addi	a4,a5,8
     ebe:	fae43c23          	sd	a4,-72(s0)
     ec2:	6398                	ld	a4,0(a5)
     ec4:	fcc42783          	lw	a5,-52(s0)
     ec8:	85ba                	mv	a1,a4
     eca:	853e                	mv	a0,a5
     ecc:	00000097          	auipc	ra,0x0
     ed0:	e30080e7          	jalr	-464(ra) # cfc <printptr>
     ed4:	a0fd                	j	fc2 <vprintf+0x23a>
      } else if(c == 's'){
     ed6:	fdc42783          	lw	a5,-36(s0)
     eda:	0007871b          	sext.w	a4,a5
     ede:	07300793          	li	a5,115
     ee2:	04f71c63          	bne	a4,a5,f3a <vprintf+0x1b2>
        s = va_arg(ap, char*);
     ee6:	fb843783          	ld	a5,-72(s0)
     eea:	00878713          	addi	a4,a5,8
     eee:	fae43c23          	sd	a4,-72(s0)
     ef2:	639c                	ld	a5,0(a5)
     ef4:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     ef8:	fe843783          	ld	a5,-24(s0)
     efc:	eb8d                	bnez	a5,f2e <vprintf+0x1a6>
          s = "(null)";
     efe:	00000797          	auipc	a5,0x0
     f02:	5b278793          	addi	a5,a5,1458 # 14b0 <malloc+0x278>
     f06:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     f0a:	a015                	j	f2e <vprintf+0x1a6>
          putc(fd, *s);
     f0c:	fe843783          	ld	a5,-24(s0)
     f10:	0007c703          	lbu	a4,0(a5)
     f14:	fcc42783          	lw	a5,-52(s0)
     f18:	85ba                	mv	a1,a4
     f1a:	853e                	mv	a0,a5
     f1c:	00000097          	auipc	ra,0x0
     f20:	ca2080e7          	jalr	-862(ra) # bbe <putc>
          s++;
     f24:	fe843783          	ld	a5,-24(s0)
     f28:	0785                	addi	a5,a5,1
     f2a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     f2e:	fe843783          	ld	a5,-24(s0)
     f32:	0007c783          	lbu	a5,0(a5)
     f36:	fbf9                	bnez	a5,f0c <vprintf+0x184>
     f38:	a069                	j	fc2 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     f3a:	fdc42783          	lw	a5,-36(s0)
     f3e:	0007871b          	sext.w	a4,a5
     f42:	06300793          	li	a5,99
     f46:	02f71463          	bne	a4,a5,f6e <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     f4a:	fb843783          	ld	a5,-72(s0)
     f4e:	00878713          	addi	a4,a5,8
     f52:	fae43c23          	sd	a4,-72(s0)
     f56:	439c                	lw	a5,0(a5)
     f58:	0ff7f713          	zext.b	a4,a5
     f5c:	fcc42783          	lw	a5,-52(s0)
     f60:	85ba                	mv	a1,a4
     f62:	853e                	mv	a0,a5
     f64:	00000097          	auipc	ra,0x0
     f68:	c5a080e7          	jalr	-934(ra) # bbe <putc>
     f6c:	a899                	j	fc2 <vprintf+0x23a>
      } else if(c == '%'){
     f6e:	fdc42783          	lw	a5,-36(s0)
     f72:	0007871b          	sext.w	a4,a5
     f76:	02500793          	li	a5,37
     f7a:	00f71f63          	bne	a4,a5,f98 <vprintf+0x210>
        putc(fd, c);
     f7e:	fdc42783          	lw	a5,-36(s0)
     f82:	0ff7f713          	zext.b	a4,a5
     f86:	fcc42783          	lw	a5,-52(s0)
     f8a:	85ba                	mv	a1,a4
     f8c:	853e                	mv	a0,a5
     f8e:	00000097          	auipc	ra,0x0
     f92:	c30080e7          	jalr	-976(ra) # bbe <putc>
     f96:	a035                	j	fc2 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     f98:	fcc42783          	lw	a5,-52(s0)
     f9c:	02500593          	li	a1,37
     fa0:	853e                	mv	a0,a5
     fa2:	00000097          	auipc	ra,0x0
     fa6:	c1c080e7          	jalr	-996(ra) # bbe <putc>
        putc(fd, c);
     faa:	fdc42783          	lw	a5,-36(s0)
     fae:	0ff7f713          	zext.b	a4,a5
     fb2:	fcc42783          	lw	a5,-52(s0)
     fb6:	85ba                	mv	a1,a4
     fb8:	853e                	mv	a0,a5
     fba:	00000097          	auipc	ra,0x0
     fbe:	c04080e7          	jalr	-1020(ra) # bbe <putc>
      }
      state = 0;
     fc2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     fc6:	fe442783          	lw	a5,-28(s0)
     fca:	2785                	addiw	a5,a5,1
     fcc:	fef42223          	sw	a5,-28(s0)
     fd0:	fe442783          	lw	a5,-28(s0)
     fd4:	fc043703          	ld	a4,-64(s0)
     fd8:	97ba                	add	a5,a5,a4
     fda:	0007c783          	lbu	a5,0(a5)
     fde:	dc0795e3          	bnez	a5,da8 <vprintf+0x20>
    }
  }
}
     fe2:	0001                	nop
     fe4:	0001                	nop
     fe6:	60a6                	ld	ra,72(sp)
     fe8:	6406                	ld	s0,64(sp)
     fea:	6161                	addi	sp,sp,80
     fec:	8082                	ret

0000000000000fee <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     fee:	7159                	addi	sp,sp,-112
     ff0:	fc06                	sd	ra,56(sp)
     ff2:	f822                	sd	s0,48(sp)
     ff4:	0080                	addi	s0,sp,64
     ff6:	fcb43823          	sd	a1,-48(s0)
     ffa:	e010                	sd	a2,0(s0)
     ffc:	e414                	sd	a3,8(s0)
     ffe:	e818                	sd	a4,16(s0)
    1000:	ec1c                	sd	a5,24(s0)
    1002:	03043023          	sd	a6,32(s0)
    1006:	03143423          	sd	a7,40(s0)
    100a:	87aa                	mv	a5,a0
    100c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    1010:	03040793          	addi	a5,s0,48
    1014:	fcf43423          	sd	a5,-56(s0)
    1018:	fc843783          	ld	a5,-56(s0)
    101c:	fd078793          	addi	a5,a5,-48
    1020:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    1024:	fe843703          	ld	a4,-24(s0)
    1028:	fdc42783          	lw	a5,-36(s0)
    102c:	863a                	mv	a2,a4
    102e:	fd043583          	ld	a1,-48(s0)
    1032:	853e                	mv	a0,a5
    1034:	00000097          	auipc	ra,0x0
    1038:	d54080e7          	jalr	-684(ra) # d88 <vprintf>
}
    103c:	0001                	nop
    103e:	70e2                	ld	ra,56(sp)
    1040:	7442                	ld	s0,48(sp)
    1042:	6165                	addi	sp,sp,112
    1044:	8082                	ret

0000000000001046 <printf>:

void
printf(const char *fmt, ...)
{
    1046:	7159                	addi	sp,sp,-112
    1048:	f406                	sd	ra,40(sp)
    104a:	f022                	sd	s0,32(sp)
    104c:	1800                	addi	s0,sp,48
    104e:	fca43c23          	sd	a0,-40(s0)
    1052:	e40c                	sd	a1,8(s0)
    1054:	e810                	sd	a2,16(s0)
    1056:	ec14                	sd	a3,24(s0)
    1058:	f018                	sd	a4,32(s0)
    105a:	f41c                	sd	a5,40(s0)
    105c:	03043823          	sd	a6,48(s0)
    1060:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1064:	04040793          	addi	a5,s0,64
    1068:	fcf43823          	sd	a5,-48(s0)
    106c:	fd043783          	ld	a5,-48(s0)
    1070:	fc878793          	addi	a5,a5,-56
    1074:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    1078:	fe843783          	ld	a5,-24(s0)
    107c:	863e                	mv	a2,a5
    107e:	fd843583          	ld	a1,-40(s0)
    1082:	4505                	li	a0,1
    1084:	00000097          	auipc	ra,0x0
    1088:	d04080e7          	jalr	-764(ra) # d88 <vprintf>
}
    108c:	0001                	nop
    108e:	70a2                	ld	ra,40(sp)
    1090:	7402                	ld	s0,32(sp)
    1092:	6165                	addi	sp,sp,112
    1094:	8082                	ret

0000000000001096 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1096:	7179                	addi	sp,sp,-48
    1098:	f422                	sd	s0,40(sp)
    109a:	1800                	addi	s0,sp,48
    109c:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    10a0:	fd843783          	ld	a5,-40(s0)
    10a4:	17c1                	addi	a5,a5,-16
    10a6:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10aa:	00000797          	auipc	a5,0x0
    10ae:	43e78793          	addi	a5,a5,1086 # 14e8 <freep>
    10b2:	639c                	ld	a5,0(a5)
    10b4:	fef43423          	sd	a5,-24(s0)
    10b8:	a815                	j	10ec <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10ba:	fe843783          	ld	a5,-24(s0)
    10be:	639c                	ld	a5,0(a5)
    10c0:	fe843703          	ld	a4,-24(s0)
    10c4:	00f76f63          	bltu	a4,a5,10e2 <free+0x4c>
    10c8:	fe043703          	ld	a4,-32(s0)
    10cc:	fe843783          	ld	a5,-24(s0)
    10d0:	02e7eb63          	bltu	a5,a4,1106 <free+0x70>
    10d4:	fe843783          	ld	a5,-24(s0)
    10d8:	639c                	ld	a5,0(a5)
    10da:	fe043703          	ld	a4,-32(s0)
    10de:	02f76463          	bltu	a4,a5,1106 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10e2:	fe843783          	ld	a5,-24(s0)
    10e6:	639c                	ld	a5,0(a5)
    10e8:	fef43423          	sd	a5,-24(s0)
    10ec:	fe043703          	ld	a4,-32(s0)
    10f0:	fe843783          	ld	a5,-24(s0)
    10f4:	fce7f3e3          	bgeu	a5,a4,10ba <free+0x24>
    10f8:	fe843783          	ld	a5,-24(s0)
    10fc:	639c                	ld	a5,0(a5)
    10fe:	fe043703          	ld	a4,-32(s0)
    1102:	faf77ce3          	bgeu	a4,a5,10ba <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1106:	fe043783          	ld	a5,-32(s0)
    110a:	479c                	lw	a5,8(a5)
    110c:	1782                	slli	a5,a5,0x20
    110e:	9381                	srli	a5,a5,0x20
    1110:	0792                	slli	a5,a5,0x4
    1112:	fe043703          	ld	a4,-32(s0)
    1116:	973e                	add	a4,a4,a5
    1118:	fe843783          	ld	a5,-24(s0)
    111c:	639c                	ld	a5,0(a5)
    111e:	02f71763          	bne	a4,a5,114c <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    1122:	fe043783          	ld	a5,-32(s0)
    1126:	4798                	lw	a4,8(a5)
    1128:	fe843783          	ld	a5,-24(s0)
    112c:	639c                	ld	a5,0(a5)
    112e:	479c                	lw	a5,8(a5)
    1130:	9fb9                	addw	a5,a5,a4
    1132:	0007871b          	sext.w	a4,a5
    1136:	fe043783          	ld	a5,-32(s0)
    113a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    113c:	fe843783          	ld	a5,-24(s0)
    1140:	639c                	ld	a5,0(a5)
    1142:	6398                	ld	a4,0(a5)
    1144:	fe043783          	ld	a5,-32(s0)
    1148:	e398                	sd	a4,0(a5)
    114a:	a039                	j	1158 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    114c:	fe843783          	ld	a5,-24(s0)
    1150:	6398                	ld	a4,0(a5)
    1152:	fe043783          	ld	a5,-32(s0)
    1156:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    1158:	fe843783          	ld	a5,-24(s0)
    115c:	479c                	lw	a5,8(a5)
    115e:	1782                	slli	a5,a5,0x20
    1160:	9381                	srli	a5,a5,0x20
    1162:	0792                	slli	a5,a5,0x4
    1164:	fe843703          	ld	a4,-24(s0)
    1168:	97ba                	add	a5,a5,a4
    116a:	fe043703          	ld	a4,-32(s0)
    116e:	02f71563          	bne	a4,a5,1198 <free+0x102>
    p->s.size += bp->s.size;
    1172:	fe843783          	ld	a5,-24(s0)
    1176:	4798                	lw	a4,8(a5)
    1178:	fe043783          	ld	a5,-32(s0)
    117c:	479c                	lw	a5,8(a5)
    117e:	9fb9                	addw	a5,a5,a4
    1180:	0007871b          	sext.w	a4,a5
    1184:	fe843783          	ld	a5,-24(s0)
    1188:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    118a:	fe043783          	ld	a5,-32(s0)
    118e:	6398                	ld	a4,0(a5)
    1190:	fe843783          	ld	a5,-24(s0)
    1194:	e398                	sd	a4,0(a5)
    1196:	a031                	j	11a2 <free+0x10c>
  } else
    p->s.ptr = bp;
    1198:	fe843783          	ld	a5,-24(s0)
    119c:	fe043703          	ld	a4,-32(s0)
    11a0:	e398                	sd	a4,0(a5)
  freep = p;
    11a2:	00000797          	auipc	a5,0x0
    11a6:	34678793          	addi	a5,a5,838 # 14e8 <freep>
    11aa:	fe843703          	ld	a4,-24(s0)
    11ae:	e398                	sd	a4,0(a5)
}
    11b0:	0001                	nop
    11b2:	7422                	ld	s0,40(sp)
    11b4:	6145                	addi	sp,sp,48
    11b6:	8082                	ret

00000000000011b8 <morecore>:

static Header*
morecore(uint nu)
{
    11b8:	7179                	addi	sp,sp,-48
    11ba:	f406                	sd	ra,40(sp)
    11bc:	f022                	sd	s0,32(sp)
    11be:	1800                	addi	s0,sp,48
    11c0:	87aa                	mv	a5,a0
    11c2:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    11c6:	fdc42783          	lw	a5,-36(s0)
    11ca:	0007871b          	sext.w	a4,a5
    11ce:	6785                	lui	a5,0x1
    11d0:	00f77563          	bgeu	a4,a5,11da <morecore+0x22>
    nu = 4096;
    11d4:	6785                	lui	a5,0x1
    11d6:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    11da:	fdc42783          	lw	a5,-36(s0)
    11de:	0047979b          	slliw	a5,a5,0x4
    11e2:	2781                	sext.w	a5,a5
    11e4:	2781                	sext.w	a5,a5
    11e6:	853e                	mv	a0,a5
    11e8:	00000097          	auipc	ra,0x0
    11ec:	9ae080e7          	jalr	-1618(ra) # b96 <sbrk>
    11f0:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    11f4:	fe843703          	ld	a4,-24(s0)
    11f8:	57fd                	li	a5,-1
    11fa:	00f71463          	bne	a4,a5,1202 <morecore+0x4a>
    return 0;
    11fe:	4781                	li	a5,0
    1200:	a03d                	j	122e <morecore+0x76>
  hp = (Header*)p;
    1202:	fe843783          	ld	a5,-24(s0)
    1206:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    120a:	fe043783          	ld	a5,-32(s0)
    120e:	fdc42703          	lw	a4,-36(s0)
    1212:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    1214:	fe043783          	ld	a5,-32(s0)
    1218:	07c1                	addi	a5,a5,16
    121a:	853e                	mv	a0,a5
    121c:	00000097          	auipc	ra,0x0
    1220:	e7a080e7          	jalr	-390(ra) # 1096 <free>
  return freep;
    1224:	00000797          	auipc	a5,0x0
    1228:	2c478793          	addi	a5,a5,708 # 14e8 <freep>
    122c:	639c                	ld	a5,0(a5)
}
    122e:	853e                	mv	a0,a5
    1230:	70a2                	ld	ra,40(sp)
    1232:	7402                	ld	s0,32(sp)
    1234:	6145                	addi	sp,sp,48
    1236:	8082                	ret

0000000000001238 <malloc>:

void*
malloc(uint nbytes)
{
    1238:	7139                	addi	sp,sp,-64
    123a:	fc06                	sd	ra,56(sp)
    123c:	f822                	sd	s0,48(sp)
    123e:	0080                	addi	s0,sp,64
    1240:	87aa                	mv	a5,a0
    1242:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1246:	fcc46783          	lwu	a5,-52(s0)
    124a:	07bd                	addi	a5,a5,15
    124c:	8391                	srli	a5,a5,0x4
    124e:	2781                	sext.w	a5,a5
    1250:	2785                	addiw	a5,a5,1
    1252:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1256:	00000797          	auipc	a5,0x0
    125a:	29278793          	addi	a5,a5,658 # 14e8 <freep>
    125e:	639c                	ld	a5,0(a5)
    1260:	fef43023          	sd	a5,-32(s0)
    1264:	fe043783          	ld	a5,-32(s0)
    1268:	ef95                	bnez	a5,12a4 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    126a:	00000797          	auipc	a5,0x0
    126e:	26e78793          	addi	a5,a5,622 # 14d8 <base>
    1272:	fef43023          	sd	a5,-32(s0)
    1276:	00000797          	auipc	a5,0x0
    127a:	27278793          	addi	a5,a5,626 # 14e8 <freep>
    127e:	fe043703          	ld	a4,-32(s0)
    1282:	e398                	sd	a4,0(a5)
    1284:	00000797          	auipc	a5,0x0
    1288:	26478793          	addi	a5,a5,612 # 14e8 <freep>
    128c:	6398                	ld	a4,0(a5)
    128e:	00000797          	auipc	a5,0x0
    1292:	24a78793          	addi	a5,a5,586 # 14d8 <base>
    1296:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1298:	00000797          	auipc	a5,0x0
    129c:	24078793          	addi	a5,a5,576 # 14d8 <base>
    12a0:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12a4:	fe043783          	ld	a5,-32(s0)
    12a8:	639c                	ld	a5,0(a5)
    12aa:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    12ae:	fe843783          	ld	a5,-24(s0)
    12b2:	4798                	lw	a4,8(a5)
    12b4:	fdc42783          	lw	a5,-36(s0)
    12b8:	2781                	sext.w	a5,a5
    12ba:	06f76763          	bltu	a4,a5,1328 <malloc+0xf0>
      if(p->s.size == nunits)
    12be:	fe843783          	ld	a5,-24(s0)
    12c2:	4798                	lw	a4,8(a5)
    12c4:	fdc42783          	lw	a5,-36(s0)
    12c8:	2781                	sext.w	a5,a5
    12ca:	00e79963          	bne	a5,a4,12dc <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    12ce:	fe843783          	ld	a5,-24(s0)
    12d2:	6398                	ld	a4,0(a5)
    12d4:	fe043783          	ld	a5,-32(s0)
    12d8:	e398                	sd	a4,0(a5)
    12da:	a825                	j	1312 <malloc+0xda>
      else {
        p->s.size -= nunits;
    12dc:	fe843783          	ld	a5,-24(s0)
    12e0:	479c                	lw	a5,8(a5)
    12e2:	fdc42703          	lw	a4,-36(s0)
    12e6:	9f99                	subw	a5,a5,a4
    12e8:	0007871b          	sext.w	a4,a5
    12ec:	fe843783          	ld	a5,-24(s0)
    12f0:	c798                	sw	a4,8(a5)
        p += p->s.size;
    12f2:	fe843783          	ld	a5,-24(s0)
    12f6:	479c                	lw	a5,8(a5)
    12f8:	1782                	slli	a5,a5,0x20
    12fa:	9381                	srli	a5,a5,0x20
    12fc:	0792                	slli	a5,a5,0x4
    12fe:	fe843703          	ld	a4,-24(s0)
    1302:	97ba                	add	a5,a5,a4
    1304:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1308:	fe843783          	ld	a5,-24(s0)
    130c:	fdc42703          	lw	a4,-36(s0)
    1310:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1312:	00000797          	auipc	a5,0x0
    1316:	1d678793          	addi	a5,a5,470 # 14e8 <freep>
    131a:	fe043703          	ld	a4,-32(s0)
    131e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1320:	fe843783          	ld	a5,-24(s0)
    1324:	07c1                	addi	a5,a5,16
    1326:	a091                	j	136a <malloc+0x132>
    }
    if(p == freep)
    1328:	00000797          	auipc	a5,0x0
    132c:	1c078793          	addi	a5,a5,448 # 14e8 <freep>
    1330:	639c                	ld	a5,0(a5)
    1332:	fe843703          	ld	a4,-24(s0)
    1336:	02f71063          	bne	a4,a5,1356 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    133a:	fdc42783          	lw	a5,-36(s0)
    133e:	853e                	mv	a0,a5
    1340:	00000097          	auipc	ra,0x0
    1344:	e78080e7          	jalr	-392(ra) # 11b8 <morecore>
    1348:	fea43423          	sd	a0,-24(s0)
    134c:	fe843783          	ld	a5,-24(s0)
    1350:	e399                	bnez	a5,1356 <malloc+0x11e>
        return 0;
    1352:	4781                	li	a5,0
    1354:	a819                	j	136a <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1356:	fe843783          	ld	a5,-24(s0)
    135a:	fef43023          	sd	a5,-32(s0)
    135e:	fe843783          	ld	a5,-24(s0)
    1362:	639c                	ld	a5,0(a5)
    1364:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1368:	b799                	j	12ae <malloc+0x76>
  }
}
    136a:	853e                	mv	a0,a5
    136c:	70e2                	ld	ra,56(sp)
    136e:	7442                	ld	s0,48(sp)
    1370:	6121                	addi	sp,sp,64
    1372:	8082                	ret
