
user/_thread:     file format elf64-littleriscv


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
      16:	f9e080e7          	jalr	-98(ra) # fb0 <malloc>
      1a:	fea43423          	sd	a0,-24(s0)
      1e:	fe843783          	ld	a5,-24(s0)
      22:	e38d                	bnez	a5,44 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
      24:	00001517          	auipc	a0,0x1
      28:	0cc50513          	addi	a0,a0,204 # 10f0 <malloc+0x140>
      2c:	00001097          	auipc	ra,0x1
      30:	d92080e7          	jalr	-622(ra) # dbe <printf>
        free(stack);
      34:	fe843503          	ld	a0,-24(s0)
      38:	00001097          	auipc	ra,0x1
      3c:	dd6080e7          	jalr	-554(ra) # e0e <free>
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
      82:	8a8080e7          	jalr	-1880(ra) # 926 <clone>
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
      a4:	88e080e7          	jalr	-1906(ra) # 92e <join>
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
      c6:	d4c080e7          	jalr	-692(ra) # e0e <free>
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

000000000000010e <main>:

void worker(void *arg_ptr);

int
main(int argc, char *argv[])
{
     10e:	7179                	addi	sp,sp,-48
     110:	f406                	sd	ra,40(sp)
     112:	f022                	sd	s0,32(sp)
     114:	1800                	addi	s0,sp,48
     116:	87aa                	mv	a5,a0
     118:	fcb43823          	sd	a1,-48(s0)
     11c:	fcf42e23          	sw	a5,-36(s0)
   ppid = getpid();
     120:	00000097          	auipc	ra,0x0
     124:	7e6080e7          	jalr	2022(ra) # 906 <getpid>
     128:	87aa                	mv	a5,a0
     12a:	873e                	mv	a4,a5
     12c:	00001797          	auipc	a5,0x1
     130:	0dc78793          	addi	a5,a5,220 # 1208 <ppid>
     134:	c398                	sw	a4,0(a5)

   int arg = 35;
     136:	02300793          	li	a5,35
     13a:	fef42223          	sw	a5,-28(s0)
   int thread_pid = thread_create(worker, &arg);
     13e:	fe440793          	addi	a5,s0,-28
     142:	85be                	mv	a1,a5
     144:	00000517          	auipc	a0,0x0
     148:	19050513          	addi	a0,a0,400 # 2d4 <worker>
     14c:	00000097          	auipc	ra,0x0
     150:	eb4080e7          	jalr	-332(ra) # 0 <thread_create>
     154:	87aa                	mv	a5,a0
     156:	fef42623          	sw	a5,-20(s0)
   assert(thread_pid > 0);
     15a:	fec42783          	lw	a5,-20(s0)
     15e:	2781                	sext.w	a5,a5
     160:	06f04263          	bgtz	a5,1c4 <main+0xb6>
     164:	467d                	li	a2,31
     166:	00001597          	auipc	a1,0x1
     16a:	fda58593          	addi	a1,a1,-38 # 1140 <malloc+0x190>
     16e:	00001517          	auipc	a0,0x1
     172:	fe250513          	addi	a0,a0,-30 # 1150 <malloc+0x1a0>
     176:	00001097          	auipc	ra,0x1
     17a:	c48080e7          	jalr	-952(ra) # dbe <printf>
     17e:	00001597          	auipc	a1,0x1
     182:	fda58593          	addi	a1,a1,-38 # 1158 <malloc+0x1a8>
     186:	00001517          	auipc	a0,0x1
     18a:	fe250513          	addi	a0,a0,-30 # 1168 <malloc+0x1b8>
     18e:	00001097          	auipc	ra,0x1
     192:	c30080e7          	jalr	-976(ra) # dbe <printf>
     196:	00001517          	auipc	a0,0x1
     19a:	fea50513          	addi	a0,a0,-22 # 1180 <malloc+0x1d0>
     19e:	00001097          	auipc	ra,0x1
     1a2:	c20080e7          	jalr	-992(ra) # dbe <printf>
     1a6:	00001797          	auipc	a5,0x1
     1aa:	06278793          	addi	a5,a5,98 # 1208 <ppid>
     1ae:	439c                	lw	a5,0(a5)
     1b0:	853e                	mv	a0,a5
     1b2:	00000097          	auipc	ra,0x0
     1b6:	704080e7          	jalr	1796(ra) # 8b6 <kill>
     1ba:	4501                	li	a0,0
     1bc:	00000097          	auipc	ra,0x0
     1c0:	6ca080e7          	jalr	1738(ra) # 886 <exit>

   int join_pid = thread_join();
     1c4:	00000097          	auipc	ra,0x0
     1c8:	ece080e7          	jalr	-306(ra) # 92 <thread_join>
     1cc:	87aa                	mv	a5,a0
     1ce:	fef42423          	sw	a5,-24(s0)
   assert(join_pid == thread_pid);
     1d2:	fe842783          	lw	a5,-24(s0)
     1d6:	873e                	mv	a4,a5
     1d8:	fec42783          	lw	a5,-20(s0)
     1dc:	2701                	sext.w	a4,a4
     1de:	2781                	sext.w	a5,a5
     1e0:	06f70363          	beq	a4,a5,246 <main+0x138>
     1e4:	02200613          	li	a2,34
     1e8:	00001597          	auipc	a1,0x1
     1ec:	f5858593          	addi	a1,a1,-168 # 1140 <malloc+0x190>
     1f0:	00001517          	auipc	a0,0x1
     1f4:	f6050513          	addi	a0,a0,-160 # 1150 <malloc+0x1a0>
     1f8:	00001097          	auipc	ra,0x1
     1fc:	bc6080e7          	jalr	-1082(ra) # dbe <printf>
     200:	00001597          	auipc	a1,0x1
     204:	f9058593          	addi	a1,a1,-112 # 1190 <malloc+0x1e0>
     208:	00001517          	auipc	a0,0x1
     20c:	f6050513          	addi	a0,a0,-160 # 1168 <malloc+0x1b8>
     210:	00001097          	auipc	ra,0x1
     214:	bae080e7          	jalr	-1106(ra) # dbe <printf>
     218:	00001517          	auipc	a0,0x1
     21c:	f6850513          	addi	a0,a0,-152 # 1180 <malloc+0x1d0>
     220:	00001097          	auipc	ra,0x1
     224:	b9e080e7          	jalr	-1122(ra) # dbe <printf>
     228:	00001797          	auipc	a5,0x1
     22c:	fe078793          	addi	a5,a5,-32 # 1208 <ppid>
     230:	439c                	lw	a5,0(a5)
     232:	853e                	mv	a0,a5
     234:	00000097          	auipc	ra,0x0
     238:	682080e7          	jalr	1666(ra) # 8b6 <kill>
     23c:	4501                	li	a0,0
     23e:	00000097          	auipc	ra,0x0
     242:	648080e7          	jalr	1608(ra) # 886 <exit>
   assert(global == 2);
     246:	00001797          	auipc	a5,0x1
     24a:	fbe78793          	addi	a5,a5,-66 # 1204 <global>
     24e:	439c                	lw	a5,0(a5)
     250:	873e                	mv	a4,a5
     252:	4789                	li	a5,2
     254:	06f70363          	beq	a4,a5,2ba <main+0x1ac>
     258:	02300613          	li	a2,35
     25c:	00001597          	auipc	a1,0x1
     260:	ee458593          	addi	a1,a1,-284 # 1140 <malloc+0x190>
     264:	00001517          	auipc	a0,0x1
     268:	eec50513          	addi	a0,a0,-276 # 1150 <malloc+0x1a0>
     26c:	00001097          	auipc	ra,0x1
     270:	b52080e7          	jalr	-1198(ra) # dbe <printf>
     274:	00001597          	auipc	a1,0x1
     278:	f3458593          	addi	a1,a1,-204 # 11a8 <malloc+0x1f8>
     27c:	00001517          	auipc	a0,0x1
     280:	eec50513          	addi	a0,a0,-276 # 1168 <malloc+0x1b8>
     284:	00001097          	auipc	ra,0x1
     288:	b3a080e7          	jalr	-1222(ra) # dbe <printf>
     28c:	00001517          	auipc	a0,0x1
     290:	ef450513          	addi	a0,a0,-268 # 1180 <malloc+0x1d0>
     294:	00001097          	auipc	ra,0x1
     298:	b2a080e7          	jalr	-1238(ra) # dbe <printf>
     29c:	00001797          	auipc	a5,0x1
     2a0:	f6c78793          	addi	a5,a5,-148 # 1208 <ppid>
     2a4:	439c                	lw	a5,0(a5)
     2a6:	853e                	mv	a0,a5
     2a8:	00000097          	auipc	ra,0x0
     2ac:	60e080e7          	jalr	1550(ra) # 8b6 <kill>
     2b0:	4501                	li	a0,0
     2b2:	00000097          	auipc	ra,0x0
     2b6:	5d4080e7          	jalr	1492(ra) # 886 <exit>

   printf("TEST PASSED\n");
     2ba:	00001517          	auipc	a0,0x1
     2be:	efe50513          	addi	a0,a0,-258 # 11b8 <malloc+0x208>
     2c2:	00001097          	auipc	ra,0x1
     2c6:	afc080e7          	jalr	-1284(ra) # dbe <printf>
   exit(0);
     2ca:	4501                	li	a0,0
     2cc:	00000097          	auipc	ra,0x0
     2d0:	5ba080e7          	jalr	1466(ra) # 886 <exit>

00000000000002d4 <worker>:
}

void
worker(void *arg_ptr) {
     2d4:	7179                	addi	sp,sp,-48
     2d6:	f406                	sd	ra,40(sp)
     2d8:	f022                	sd	s0,32(sp)
     2da:	1800                	addi	s0,sp,48
     2dc:	fca43c23          	sd	a0,-40(s0)
   int arg = *(int*)arg_ptr;
     2e0:	fd843783          	ld	a5,-40(s0)
     2e4:	439c                	lw	a5,0(a5)
     2e6:	fef42623          	sw	a5,-20(s0)
   assert(arg == 35);
     2ea:	fec42783          	lw	a5,-20(s0)
     2ee:	0007871b          	sext.w	a4,a5
     2f2:	02300793          	li	a5,35
     2f6:	06f70363          	beq	a4,a5,35c <worker+0x88>
     2fa:	02c00613          	li	a2,44
     2fe:	00001597          	auipc	a1,0x1
     302:	e4258593          	addi	a1,a1,-446 # 1140 <malloc+0x190>
     306:	00001517          	auipc	a0,0x1
     30a:	e4a50513          	addi	a0,a0,-438 # 1150 <malloc+0x1a0>
     30e:	00001097          	auipc	ra,0x1
     312:	ab0080e7          	jalr	-1360(ra) # dbe <printf>
     316:	00001597          	auipc	a1,0x1
     31a:	eb258593          	addi	a1,a1,-334 # 11c8 <malloc+0x218>
     31e:	00001517          	auipc	a0,0x1
     322:	e4a50513          	addi	a0,a0,-438 # 1168 <malloc+0x1b8>
     326:	00001097          	auipc	ra,0x1
     32a:	a98080e7          	jalr	-1384(ra) # dbe <printf>
     32e:	00001517          	auipc	a0,0x1
     332:	e5250513          	addi	a0,a0,-430 # 1180 <malloc+0x1d0>
     336:	00001097          	auipc	ra,0x1
     33a:	a88080e7          	jalr	-1400(ra) # dbe <printf>
     33e:	00001797          	auipc	a5,0x1
     342:	eca78793          	addi	a5,a5,-310 # 1208 <ppid>
     346:	439c                	lw	a5,0(a5)
     348:	853e                	mv	a0,a5
     34a:	00000097          	auipc	ra,0x0
     34e:	56c080e7          	jalr	1388(ra) # 8b6 <kill>
     352:	4501                	li	a0,0
     354:	00000097          	auipc	ra,0x0
     358:	532080e7          	jalr	1330(ra) # 886 <exit>
   assert(global == 1);
     35c:	00001797          	auipc	a5,0x1
     360:	ea878793          	addi	a5,a5,-344 # 1204 <global>
     364:	439c                	lw	a5,0(a5)
     366:	873e                	mv	a4,a5
     368:	4785                	li	a5,1
     36a:	06f70363          	beq	a4,a5,3d0 <worker+0xfc>
     36e:	02d00613          	li	a2,45
     372:	00001597          	auipc	a1,0x1
     376:	dce58593          	addi	a1,a1,-562 # 1140 <malloc+0x190>
     37a:	00001517          	auipc	a0,0x1
     37e:	dd650513          	addi	a0,a0,-554 # 1150 <malloc+0x1a0>
     382:	00001097          	auipc	ra,0x1
     386:	a3c080e7          	jalr	-1476(ra) # dbe <printf>
     38a:	00001597          	auipc	a1,0x1
     38e:	e4e58593          	addi	a1,a1,-434 # 11d8 <malloc+0x228>
     392:	00001517          	auipc	a0,0x1
     396:	dd650513          	addi	a0,a0,-554 # 1168 <malloc+0x1b8>
     39a:	00001097          	auipc	ra,0x1
     39e:	a24080e7          	jalr	-1500(ra) # dbe <printf>
     3a2:	00001517          	auipc	a0,0x1
     3a6:	dde50513          	addi	a0,a0,-546 # 1180 <malloc+0x1d0>
     3aa:	00001097          	auipc	ra,0x1
     3ae:	a14080e7          	jalr	-1516(ra) # dbe <printf>
     3b2:	00001797          	auipc	a5,0x1
     3b6:	e5678793          	addi	a5,a5,-426 # 1208 <ppid>
     3ba:	439c                	lw	a5,0(a5)
     3bc:	853e                	mv	a0,a5
     3be:	00000097          	auipc	ra,0x0
     3c2:	4f8080e7          	jalr	1272(ra) # 8b6 <kill>
     3c6:	4501                	li	a0,0
     3c8:	00000097          	auipc	ra,0x0
     3cc:	4be080e7          	jalr	1214(ra) # 886 <exit>
   global++;
     3d0:	00001797          	auipc	a5,0x1
     3d4:	e3478793          	addi	a5,a5,-460 # 1204 <global>
     3d8:	439c                	lw	a5,0(a5)
     3da:	2785                	addiw	a5,a5,1
     3dc:	0007871b          	sext.w	a4,a5
     3e0:	00001797          	auipc	a5,0x1
     3e4:	e2478793          	addi	a5,a5,-476 # 1204 <global>
     3e8:	c398                	sw	a4,0(a5)
   exit(0);
     3ea:	4501                	li	a0,0
     3ec:	00000097          	auipc	ra,0x0
     3f0:	49a080e7          	jalr	1178(ra) # 886 <exit>

00000000000003f4 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     3f4:	7179                	addi	sp,sp,-48
     3f6:	f422                	sd	s0,40(sp)
     3f8:	1800                	addi	s0,sp,48
     3fa:	fca43c23          	sd	a0,-40(s0)
     3fe:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     402:	fd843783          	ld	a5,-40(s0)
     406:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     40a:	0001                	nop
     40c:	fd043703          	ld	a4,-48(s0)
     410:	00170793          	addi	a5,a4,1 # 1001 <malloc+0x51>
     414:	fcf43823          	sd	a5,-48(s0)
     418:	fd843783          	ld	a5,-40(s0)
     41c:	00178693          	addi	a3,a5,1
     420:	fcd43c23          	sd	a3,-40(s0)
     424:	00074703          	lbu	a4,0(a4)
     428:	00e78023          	sb	a4,0(a5)
     42c:	0007c783          	lbu	a5,0(a5)
     430:	fff1                	bnez	a5,40c <strcpy+0x18>
    ;
  return os;
     432:	fe843783          	ld	a5,-24(s0)
}
     436:	853e                	mv	a0,a5
     438:	7422                	ld	s0,40(sp)
     43a:	6145                	addi	sp,sp,48
     43c:	8082                	ret

000000000000043e <strcmp>:

int
strcmp(const char *p, const char *q)
{
     43e:	1101                	addi	sp,sp,-32
     440:	ec22                	sd	s0,24(sp)
     442:	1000                	addi	s0,sp,32
     444:	fea43423          	sd	a0,-24(s0)
     448:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     44c:	a819                	j	462 <strcmp+0x24>
    p++, q++;
     44e:	fe843783          	ld	a5,-24(s0)
     452:	0785                	addi	a5,a5,1
     454:	fef43423          	sd	a5,-24(s0)
     458:	fe043783          	ld	a5,-32(s0)
     45c:	0785                	addi	a5,a5,1
     45e:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     462:	fe843783          	ld	a5,-24(s0)
     466:	0007c783          	lbu	a5,0(a5)
     46a:	cb99                	beqz	a5,480 <strcmp+0x42>
     46c:	fe843783          	ld	a5,-24(s0)
     470:	0007c703          	lbu	a4,0(a5)
     474:	fe043783          	ld	a5,-32(s0)
     478:	0007c783          	lbu	a5,0(a5)
     47c:	fcf709e3          	beq	a4,a5,44e <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     480:	fe843783          	ld	a5,-24(s0)
     484:	0007c783          	lbu	a5,0(a5)
     488:	0007871b          	sext.w	a4,a5
     48c:	fe043783          	ld	a5,-32(s0)
     490:	0007c783          	lbu	a5,0(a5)
     494:	2781                	sext.w	a5,a5
     496:	40f707bb          	subw	a5,a4,a5
     49a:	2781                	sext.w	a5,a5
}
     49c:	853e                	mv	a0,a5
     49e:	6462                	ld	s0,24(sp)
     4a0:	6105                	addi	sp,sp,32
     4a2:	8082                	ret

00000000000004a4 <strlen>:

uint
strlen(const char *s)
{
     4a4:	7179                	addi	sp,sp,-48
     4a6:	f422                	sd	s0,40(sp)
     4a8:	1800                	addi	s0,sp,48
     4aa:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     4ae:	fe042623          	sw	zero,-20(s0)
     4b2:	a031                	j	4be <strlen+0x1a>
     4b4:	fec42783          	lw	a5,-20(s0)
     4b8:	2785                	addiw	a5,a5,1
     4ba:	fef42623          	sw	a5,-20(s0)
     4be:	fec42783          	lw	a5,-20(s0)
     4c2:	fd843703          	ld	a4,-40(s0)
     4c6:	97ba                	add	a5,a5,a4
     4c8:	0007c783          	lbu	a5,0(a5)
     4cc:	f7e5                	bnez	a5,4b4 <strlen+0x10>
    ;
  return n;
     4ce:	fec42783          	lw	a5,-20(s0)
}
     4d2:	853e                	mv	a0,a5
     4d4:	7422                	ld	s0,40(sp)
     4d6:	6145                	addi	sp,sp,48
     4d8:	8082                	ret

00000000000004da <memset>:

void*
memset(void *dst, int c, uint n)
{
     4da:	7179                	addi	sp,sp,-48
     4dc:	f422                	sd	s0,40(sp)
     4de:	1800                	addi	s0,sp,48
     4e0:	fca43c23          	sd	a0,-40(s0)
     4e4:	87ae                	mv	a5,a1
     4e6:	8732                	mv	a4,a2
     4e8:	fcf42a23          	sw	a5,-44(s0)
     4ec:	87ba                	mv	a5,a4
     4ee:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     4f2:	fd843783          	ld	a5,-40(s0)
     4f6:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     4fa:	fe042623          	sw	zero,-20(s0)
     4fe:	a00d                	j	520 <memset+0x46>
    cdst[i] = c;
     500:	fec42783          	lw	a5,-20(s0)
     504:	fe043703          	ld	a4,-32(s0)
     508:	97ba                	add	a5,a5,a4
     50a:	fd442703          	lw	a4,-44(s0)
     50e:	0ff77713          	zext.b	a4,a4
     512:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     516:	fec42783          	lw	a5,-20(s0)
     51a:	2785                	addiw	a5,a5,1
     51c:	fef42623          	sw	a5,-20(s0)
     520:	fec42703          	lw	a4,-20(s0)
     524:	fd042783          	lw	a5,-48(s0)
     528:	2781                	sext.w	a5,a5
     52a:	fcf76be3          	bltu	a4,a5,500 <memset+0x26>
  }
  return dst;
     52e:	fd843783          	ld	a5,-40(s0)
}
     532:	853e                	mv	a0,a5
     534:	7422                	ld	s0,40(sp)
     536:	6145                	addi	sp,sp,48
     538:	8082                	ret

000000000000053a <strchr>:

char*
strchr(const char *s, char c)
{
     53a:	1101                	addi	sp,sp,-32
     53c:	ec22                	sd	s0,24(sp)
     53e:	1000                	addi	s0,sp,32
     540:	fea43423          	sd	a0,-24(s0)
     544:	87ae                	mv	a5,a1
     546:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     54a:	a01d                	j	570 <strchr+0x36>
    if(*s == c)
     54c:	fe843783          	ld	a5,-24(s0)
     550:	0007c703          	lbu	a4,0(a5)
     554:	fe744783          	lbu	a5,-25(s0)
     558:	0ff7f793          	zext.b	a5,a5
     55c:	00e79563          	bne	a5,a4,566 <strchr+0x2c>
      return (char*)s;
     560:	fe843783          	ld	a5,-24(s0)
     564:	a821                	j	57c <strchr+0x42>
  for(; *s; s++)
     566:	fe843783          	ld	a5,-24(s0)
     56a:	0785                	addi	a5,a5,1
     56c:	fef43423          	sd	a5,-24(s0)
     570:	fe843783          	ld	a5,-24(s0)
     574:	0007c783          	lbu	a5,0(a5)
     578:	fbf1                	bnez	a5,54c <strchr+0x12>
  return 0;
     57a:	4781                	li	a5,0
}
     57c:	853e                	mv	a0,a5
     57e:	6462                	ld	s0,24(sp)
     580:	6105                	addi	sp,sp,32
     582:	8082                	ret

0000000000000584 <gets>:

char*
gets(char *buf, int max)
{
     584:	7179                	addi	sp,sp,-48
     586:	f406                	sd	ra,40(sp)
     588:	f022                	sd	s0,32(sp)
     58a:	1800                	addi	s0,sp,48
     58c:	fca43c23          	sd	a0,-40(s0)
     590:	87ae                	mv	a5,a1
     592:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     596:	fe042623          	sw	zero,-20(s0)
     59a:	a8a1                	j	5f2 <gets+0x6e>
    cc = read(0, &c, 1);
     59c:	fe740793          	addi	a5,s0,-25
     5a0:	4605                	li	a2,1
     5a2:	85be                	mv	a1,a5
     5a4:	4501                	li	a0,0
     5a6:	00000097          	auipc	ra,0x0
     5aa:	2f8080e7          	jalr	760(ra) # 89e <read>
     5ae:	87aa                	mv	a5,a0
     5b0:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     5b4:	fe842783          	lw	a5,-24(s0)
     5b8:	2781                	sext.w	a5,a5
     5ba:	04f05763          	blez	a5,608 <gets+0x84>
      break;
    buf[i++] = c;
     5be:	fec42783          	lw	a5,-20(s0)
     5c2:	0017871b          	addiw	a4,a5,1
     5c6:	fee42623          	sw	a4,-20(s0)
     5ca:	873e                	mv	a4,a5
     5cc:	fd843783          	ld	a5,-40(s0)
     5d0:	97ba                	add	a5,a5,a4
     5d2:	fe744703          	lbu	a4,-25(s0)
     5d6:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     5da:	fe744783          	lbu	a5,-25(s0)
     5de:	873e                	mv	a4,a5
     5e0:	47a9                	li	a5,10
     5e2:	02f70463          	beq	a4,a5,60a <gets+0x86>
     5e6:	fe744783          	lbu	a5,-25(s0)
     5ea:	873e                	mv	a4,a5
     5ec:	47b5                	li	a5,13
     5ee:	00f70e63          	beq	a4,a5,60a <gets+0x86>
  for(i=0; i+1 < max; ){
     5f2:	fec42783          	lw	a5,-20(s0)
     5f6:	2785                	addiw	a5,a5,1
     5f8:	0007871b          	sext.w	a4,a5
     5fc:	fd442783          	lw	a5,-44(s0)
     600:	2781                	sext.w	a5,a5
     602:	f8f74de3          	blt	a4,a5,59c <gets+0x18>
     606:	a011                	j	60a <gets+0x86>
      break;
     608:	0001                	nop
      break;
  }
  buf[i] = '\0';
     60a:	fec42783          	lw	a5,-20(s0)
     60e:	fd843703          	ld	a4,-40(s0)
     612:	97ba                	add	a5,a5,a4
     614:	00078023          	sb	zero,0(a5)
  return buf;
     618:	fd843783          	ld	a5,-40(s0)
}
     61c:	853e                	mv	a0,a5
     61e:	70a2                	ld	ra,40(sp)
     620:	7402                	ld	s0,32(sp)
     622:	6145                	addi	sp,sp,48
     624:	8082                	ret

0000000000000626 <stat>:

int
stat(const char *n, struct stat *st)
{
     626:	7179                	addi	sp,sp,-48
     628:	f406                	sd	ra,40(sp)
     62a:	f022                	sd	s0,32(sp)
     62c:	1800                	addi	s0,sp,48
     62e:	fca43c23          	sd	a0,-40(s0)
     632:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     636:	4581                	li	a1,0
     638:	fd843503          	ld	a0,-40(s0)
     63c:	00000097          	auipc	ra,0x0
     640:	28a080e7          	jalr	650(ra) # 8c6 <open>
     644:	87aa                	mv	a5,a0
     646:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     64a:	fec42783          	lw	a5,-20(s0)
     64e:	2781                	sext.w	a5,a5
     650:	0007d463          	bgez	a5,658 <stat+0x32>
    return -1;
     654:	57fd                	li	a5,-1
     656:	a035                	j	682 <stat+0x5c>
  r = fstat(fd, st);
     658:	fec42783          	lw	a5,-20(s0)
     65c:	fd043583          	ld	a1,-48(s0)
     660:	853e                	mv	a0,a5
     662:	00000097          	auipc	ra,0x0
     666:	27c080e7          	jalr	636(ra) # 8de <fstat>
     66a:	87aa                	mv	a5,a0
     66c:	fef42423          	sw	a5,-24(s0)
  close(fd);
     670:	fec42783          	lw	a5,-20(s0)
     674:	853e                	mv	a0,a5
     676:	00000097          	auipc	ra,0x0
     67a:	238080e7          	jalr	568(ra) # 8ae <close>
  return r;
     67e:	fe842783          	lw	a5,-24(s0)
}
     682:	853e                	mv	a0,a5
     684:	70a2                	ld	ra,40(sp)
     686:	7402                	ld	s0,32(sp)
     688:	6145                	addi	sp,sp,48
     68a:	8082                	ret

000000000000068c <atoi>:

int
atoi(const char *s)
{
     68c:	7179                	addi	sp,sp,-48
     68e:	f422                	sd	s0,40(sp)
     690:	1800                	addi	s0,sp,48
     692:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     696:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     69a:	a81d                	j	6d0 <atoi+0x44>
    n = n*10 + *s++ - '0';
     69c:	fec42783          	lw	a5,-20(s0)
     6a0:	873e                	mv	a4,a5
     6a2:	87ba                	mv	a5,a4
     6a4:	0027979b          	slliw	a5,a5,0x2
     6a8:	9fb9                	addw	a5,a5,a4
     6aa:	0017979b          	slliw	a5,a5,0x1
     6ae:	0007871b          	sext.w	a4,a5
     6b2:	fd843783          	ld	a5,-40(s0)
     6b6:	00178693          	addi	a3,a5,1
     6ba:	fcd43c23          	sd	a3,-40(s0)
     6be:	0007c783          	lbu	a5,0(a5)
     6c2:	2781                	sext.w	a5,a5
     6c4:	9fb9                	addw	a5,a5,a4
     6c6:	2781                	sext.w	a5,a5
     6c8:	fd07879b          	addiw	a5,a5,-48
     6cc:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     6d0:	fd843783          	ld	a5,-40(s0)
     6d4:	0007c783          	lbu	a5,0(a5)
     6d8:	873e                	mv	a4,a5
     6da:	02f00793          	li	a5,47
     6de:	00e7fb63          	bgeu	a5,a4,6f4 <atoi+0x68>
     6e2:	fd843783          	ld	a5,-40(s0)
     6e6:	0007c783          	lbu	a5,0(a5)
     6ea:	873e                	mv	a4,a5
     6ec:	03900793          	li	a5,57
     6f0:	fae7f6e3          	bgeu	a5,a4,69c <atoi+0x10>
  return n;
     6f4:	fec42783          	lw	a5,-20(s0)
}
     6f8:	853e                	mv	a0,a5
     6fa:	7422                	ld	s0,40(sp)
     6fc:	6145                	addi	sp,sp,48
     6fe:	8082                	ret

0000000000000700 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     700:	7139                	addi	sp,sp,-64
     702:	fc22                	sd	s0,56(sp)
     704:	0080                	addi	s0,sp,64
     706:	fca43c23          	sd	a0,-40(s0)
     70a:	fcb43823          	sd	a1,-48(s0)
     70e:	87b2                	mv	a5,a2
     710:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     714:	fd843783          	ld	a5,-40(s0)
     718:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     71c:	fd043783          	ld	a5,-48(s0)
     720:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     724:	fe043703          	ld	a4,-32(s0)
     728:	fe843783          	ld	a5,-24(s0)
     72c:	02e7fc63          	bgeu	a5,a4,764 <memmove+0x64>
    while(n-- > 0)
     730:	a00d                	j	752 <memmove+0x52>
      *dst++ = *src++;
     732:	fe043703          	ld	a4,-32(s0)
     736:	00170793          	addi	a5,a4,1
     73a:	fef43023          	sd	a5,-32(s0)
     73e:	fe843783          	ld	a5,-24(s0)
     742:	00178693          	addi	a3,a5,1
     746:	fed43423          	sd	a3,-24(s0)
     74a:	00074703          	lbu	a4,0(a4)
     74e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     752:	fcc42783          	lw	a5,-52(s0)
     756:	fff7871b          	addiw	a4,a5,-1
     75a:	fce42623          	sw	a4,-52(s0)
     75e:	fcf04ae3          	bgtz	a5,732 <memmove+0x32>
     762:	a891                	j	7b6 <memmove+0xb6>
  } else {
    dst += n;
     764:	fcc42783          	lw	a5,-52(s0)
     768:	fe843703          	ld	a4,-24(s0)
     76c:	97ba                	add	a5,a5,a4
     76e:	fef43423          	sd	a5,-24(s0)
    src += n;
     772:	fcc42783          	lw	a5,-52(s0)
     776:	fe043703          	ld	a4,-32(s0)
     77a:	97ba                	add	a5,a5,a4
     77c:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     780:	a01d                	j	7a6 <memmove+0xa6>
      *--dst = *--src;
     782:	fe043783          	ld	a5,-32(s0)
     786:	17fd                	addi	a5,a5,-1
     788:	fef43023          	sd	a5,-32(s0)
     78c:	fe843783          	ld	a5,-24(s0)
     790:	17fd                	addi	a5,a5,-1
     792:	fef43423          	sd	a5,-24(s0)
     796:	fe043783          	ld	a5,-32(s0)
     79a:	0007c703          	lbu	a4,0(a5)
     79e:	fe843783          	ld	a5,-24(s0)
     7a2:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     7a6:	fcc42783          	lw	a5,-52(s0)
     7aa:	fff7871b          	addiw	a4,a5,-1
     7ae:	fce42623          	sw	a4,-52(s0)
     7b2:	fcf048e3          	bgtz	a5,782 <memmove+0x82>
  }
  return vdst;
     7b6:	fd843783          	ld	a5,-40(s0)
}
     7ba:	853e                	mv	a0,a5
     7bc:	7462                	ld	s0,56(sp)
     7be:	6121                	addi	sp,sp,64
     7c0:	8082                	ret

00000000000007c2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     7c2:	7139                	addi	sp,sp,-64
     7c4:	fc22                	sd	s0,56(sp)
     7c6:	0080                	addi	s0,sp,64
     7c8:	fca43c23          	sd	a0,-40(s0)
     7cc:	fcb43823          	sd	a1,-48(s0)
     7d0:	87b2                	mv	a5,a2
     7d2:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     7d6:	fd843783          	ld	a5,-40(s0)
     7da:	fef43423          	sd	a5,-24(s0)
     7de:	fd043783          	ld	a5,-48(s0)
     7e2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     7e6:	a0a1                	j	82e <memcmp+0x6c>
    if (*p1 != *p2) {
     7e8:	fe843783          	ld	a5,-24(s0)
     7ec:	0007c703          	lbu	a4,0(a5)
     7f0:	fe043783          	ld	a5,-32(s0)
     7f4:	0007c783          	lbu	a5,0(a5)
     7f8:	02f70163          	beq	a4,a5,81a <memcmp+0x58>
      return *p1 - *p2;
     7fc:	fe843783          	ld	a5,-24(s0)
     800:	0007c783          	lbu	a5,0(a5)
     804:	0007871b          	sext.w	a4,a5
     808:	fe043783          	ld	a5,-32(s0)
     80c:	0007c783          	lbu	a5,0(a5)
     810:	2781                	sext.w	a5,a5
     812:	40f707bb          	subw	a5,a4,a5
     816:	2781                	sext.w	a5,a5
     818:	a01d                	j	83e <memcmp+0x7c>
    }
    p1++;
     81a:	fe843783          	ld	a5,-24(s0)
     81e:	0785                	addi	a5,a5,1
     820:	fef43423          	sd	a5,-24(s0)
    p2++;
     824:	fe043783          	ld	a5,-32(s0)
     828:	0785                	addi	a5,a5,1
     82a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     82e:	fcc42783          	lw	a5,-52(s0)
     832:	fff7871b          	addiw	a4,a5,-1
     836:	fce42623          	sw	a4,-52(s0)
     83a:	f7dd                	bnez	a5,7e8 <memcmp+0x26>
  }
  return 0;
     83c:	4781                	li	a5,0
}
     83e:	853e                	mv	a0,a5
     840:	7462                	ld	s0,56(sp)
     842:	6121                	addi	sp,sp,64
     844:	8082                	ret

0000000000000846 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     846:	7179                	addi	sp,sp,-48
     848:	f406                	sd	ra,40(sp)
     84a:	f022                	sd	s0,32(sp)
     84c:	1800                	addi	s0,sp,48
     84e:	fea43423          	sd	a0,-24(s0)
     852:	feb43023          	sd	a1,-32(s0)
     856:	87b2                	mv	a5,a2
     858:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     85c:	fdc42783          	lw	a5,-36(s0)
     860:	863e                	mv	a2,a5
     862:	fe043583          	ld	a1,-32(s0)
     866:	fe843503          	ld	a0,-24(s0)
     86a:	00000097          	auipc	ra,0x0
     86e:	e96080e7          	jalr	-362(ra) # 700 <memmove>
     872:	87aa                	mv	a5,a0
}
     874:	853e                	mv	a0,a5
     876:	70a2                	ld	ra,40(sp)
     878:	7402                	ld	s0,32(sp)
     87a:	6145                	addi	sp,sp,48
     87c:	8082                	ret

000000000000087e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     87e:	4885                	li	a7,1
 ecall
     880:	00000073          	ecall
 ret
     884:	8082                	ret

0000000000000886 <exit>:
.global exit
exit:
 li a7, SYS_exit
     886:	4889                	li	a7,2
 ecall
     888:	00000073          	ecall
 ret
     88c:	8082                	ret

000000000000088e <wait>:
.global wait
wait:
 li a7, SYS_wait
     88e:	488d                	li	a7,3
 ecall
     890:	00000073          	ecall
 ret
     894:	8082                	ret

0000000000000896 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     896:	4891                	li	a7,4
 ecall
     898:	00000073          	ecall
 ret
     89c:	8082                	ret

000000000000089e <read>:
.global read
read:
 li a7, SYS_read
     89e:	4895                	li	a7,5
 ecall
     8a0:	00000073          	ecall
 ret
     8a4:	8082                	ret

00000000000008a6 <write>:
.global write
write:
 li a7, SYS_write
     8a6:	48c1                	li	a7,16
 ecall
     8a8:	00000073          	ecall
 ret
     8ac:	8082                	ret

00000000000008ae <close>:
.global close
close:
 li a7, SYS_close
     8ae:	48d5                	li	a7,21
 ecall
     8b0:	00000073          	ecall
 ret
     8b4:	8082                	ret

00000000000008b6 <kill>:
.global kill
kill:
 li a7, SYS_kill
     8b6:	4899                	li	a7,6
 ecall
     8b8:	00000073          	ecall
 ret
     8bc:	8082                	ret

00000000000008be <exec>:
.global exec
exec:
 li a7, SYS_exec
     8be:	489d                	li	a7,7
 ecall
     8c0:	00000073          	ecall
 ret
     8c4:	8082                	ret

00000000000008c6 <open>:
.global open
open:
 li a7, SYS_open
     8c6:	48bd                	li	a7,15
 ecall
     8c8:	00000073          	ecall
 ret
     8cc:	8082                	ret

00000000000008ce <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     8ce:	48c5                	li	a7,17
 ecall
     8d0:	00000073          	ecall
 ret
     8d4:	8082                	ret

00000000000008d6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     8d6:	48c9                	li	a7,18
 ecall
     8d8:	00000073          	ecall
 ret
     8dc:	8082                	ret

00000000000008de <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     8de:	48a1                	li	a7,8
 ecall
     8e0:	00000073          	ecall
 ret
     8e4:	8082                	ret

00000000000008e6 <link>:
.global link
link:
 li a7, SYS_link
     8e6:	48cd                	li	a7,19
 ecall
     8e8:	00000073          	ecall
 ret
     8ec:	8082                	ret

00000000000008ee <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     8ee:	48d1                	li	a7,20
 ecall
     8f0:	00000073          	ecall
 ret
     8f4:	8082                	ret

00000000000008f6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     8f6:	48a5                	li	a7,9
 ecall
     8f8:	00000073          	ecall
 ret
     8fc:	8082                	ret

00000000000008fe <dup>:
.global dup
dup:
 li a7, SYS_dup
     8fe:	48a9                	li	a7,10
 ecall
     900:	00000073          	ecall
 ret
     904:	8082                	ret

0000000000000906 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     906:	48ad                	li	a7,11
 ecall
     908:	00000073          	ecall
 ret
     90c:	8082                	ret

000000000000090e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     90e:	48b1                	li	a7,12
 ecall
     910:	00000073          	ecall
 ret
     914:	8082                	ret

0000000000000916 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     916:	48b5                	li	a7,13
 ecall
     918:	00000073          	ecall
 ret
     91c:	8082                	ret

000000000000091e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     91e:	48b9                	li	a7,14
 ecall
     920:	00000073          	ecall
 ret
     924:	8082                	ret

0000000000000926 <clone>:
.global clone
clone:
 li a7, SYS_clone
     926:	48d9                	li	a7,22
 ecall
     928:	00000073          	ecall
 ret
     92c:	8082                	ret

000000000000092e <join>:
.global join
join:
 li a7, SYS_join
     92e:	48dd                	li	a7,23
 ecall
     930:	00000073          	ecall
 ret
     934:	8082                	ret

0000000000000936 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     936:	1101                	addi	sp,sp,-32
     938:	ec06                	sd	ra,24(sp)
     93a:	e822                	sd	s0,16(sp)
     93c:	1000                	addi	s0,sp,32
     93e:	87aa                	mv	a5,a0
     940:	872e                	mv	a4,a1
     942:	fef42623          	sw	a5,-20(s0)
     946:	87ba                	mv	a5,a4
     948:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     94c:	feb40713          	addi	a4,s0,-21
     950:	fec42783          	lw	a5,-20(s0)
     954:	4605                	li	a2,1
     956:	85ba                	mv	a1,a4
     958:	853e                	mv	a0,a5
     95a:	00000097          	auipc	ra,0x0
     95e:	f4c080e7          	jalr	-180(ra) # 8a6 <write>
}
     962:	0001                	nop
     964:	60e2                	ld	ra,24(sp)
     966:	6442                	ld	s0,16(sp)
     968:	6105                	addi	sp,sp,32
     96a:	8082                	ret

000000000000096c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     96c:	7139                	addi	sp,sp,-64
     96e:	fc06                	sd	ra,56(sp)
     970:	f822                	sd	s0,48(sp)
     972:	0080                	addi	s0,sp,64
     974:	87aa                	mv	a5,a0
     976:	8736                	mv	a4,a3
     978:	fcf42623          	sw	a5,-52(s0)
     97c:	87ae                	mv	a5,a1
     97e:	fcf42423          	sw	a5,-56(s0)
     982:	87b2                	mv	a5,a2
     984:	fcf42223          	sw	a5,-60(s0)
     988:	87ba                	mv	a5,a4
     98a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     98e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     992:	fc042783          	lw	a5,-64(s0)
     996:	2781                	sext.w	a5,a5
     998:	c38d                	beqz	a5,9ba <printint+0x4e>
     99a:	fc842783          	lw	a5,-56(s0)
     99e:	2781                	sext.w	a5,a5
     9a0:	0007dd63          	bgez	a5,9ba <printint+0x4e>
    neg = 1;
     9a4:	4785                	li	a5,1
     9a6:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     9aa:	fc842783          	lw	a5,-56(s0)
     9ae:	40f007bb          	negw	a5,a5
     9b2:	2781                	sext.w	a5,a5
     9b4:	fef42223          	sw	a5,-28(s0)
     9b8:	a029                	j	9c2 <printint+0x56>
  } else {
    x = xx;
     9ba:	fc842783          	lw	a5,-56(s0)
     9be:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     9c2:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     9c6:	fc442783          	lw	a5,-60(s0)
     9ca:	fe442703          	lw	a4,-28(s0)
     9ce:	02f777bb          	remuw	a5,a4,a5
     9d2:	0007861b          	sext.w	a2,a5
     9d6:	fec42783          	lw	a5,-20(s0)
     9da:	0017871b          	addiw	a4,a5,1
     9de:	fee42623          	sw	a4,-20(s0)
     9e2:	00001697          	auipc	a3,0x1
     9e6:	80e68693          	addi	a3,a3,-2034 # 11f0 <digits>
     9ea:	02061713          	slli	a4,a2,0x20
     9ee:	9301                	srli	a4,a4,0x20
     9f0:	9736                	add	a4,a4,a3
     9f2:	00074703          	lbu	a4,0(a4)
     9f6:	17c1                	addi	a5,a5,-16
     9f8:	97a2                	add	a5,a5,s0
     9fa:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     9fe:	fc442783          	lw	a5,-60(s0)
     a02:	fe442703          	lw	a4,-28(s0)
     a06:	02f757bb          	divuw	a5,a4,a5
     a0a:	fef42223          	sw	a5,-28(s0)
     a0e:	fe442783          	lw	a5,-28(s0)
     a12:	2781                	sext.w	a5,a5
     a14:	fbcd                	bnez	a5,9c6 <printint+0x5a>
  if(neg)
     a16:	fe842783          	lw	a5,-24(s0)
     a1a:	2781                	sext.w	a5,a5
     a1c:	cf85                	beqz	a5,a54 <printint+0xe8>
    buf[i++] = '-';
     a1e:	fec42783          	lw	a5,-20(s0)
     a22:	0017871b          	addiw	a4,a5,1
     a26:	fee42623          	sw	a4,-20(s0)
     a2a:	17c1                	addi	a5,a5,-16
     a2c:	97a2                	add	a5,a5,s0
     a2e:	02d00713          	li	a4,45
     a32:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     a36:	a839                	j	a54 <printint+0xe8>
    putc(fd, buf[i]);
     a38:	fec42783          	lw	a5,-20(s0)
     a3c:	17c1                	addi	a5,a5,-16
     a3e:	97a2                	add	a5,a5,s0
     a40:	fe07c703          	lbu	a4,-32(a5)
     a44:	fcc42783          	lw	a5,-52(s0)
     a48:	85ba                	mv	a1,a4
     a4a:	853e                	mv	a0,a5
     a4c:	00000097          	auipc	ra,0x0
     a50:	eea080e7          	jalr	-278(ra) # 936 <putc>
  while(--i >= 0)
     a54:	fec42783          	lw	a5,-20(s0)
     a58:	37fd                	addiw	a5,a5,-1
     a5a:	fef42623          	sw	a5,-20(s0)
     a5e:	fec42783          	lw	a5,-20(s0)
     a62:	2781                	sext.w	a5,a5
     a64:	fc07dae3          	bgez	a5,a38 <printint+0xcc>
}
     a68:	0001                	nop
     a6a:	0001                	nop
     a6c:	70e2                	ld	ra,56(sp)
     a6e:	7442                	ld	s0,48(sp)
     a70:	6121                	addi	sp,sp,64
     a72:	8082                	ret

0000000000000a74 <printptr>:

static void
printptr(int fd, uint64 x) {
     a74:	7179                	addi	sp,sp,-48
     a76:	f406                	sd	ra,40(sp)
     a78:	f022                	sd	s0,32(sp)
     a7a:	1800                	addi	s0,sp,48
     a7c:	87aa                	mv	a5,a0
     a7e:	fcb43823          	sd	a1,-48(s0)
     a82:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     a86:	fdc42783          	lw	a5,-36(s0)
     a8a:	03000593          	li	a1,48
     a8e:	853e                	mv	a0,a5
     a90:	00000097          	auipc	ra,0x0
     a94:	ea6080e7          	jalr	-346(ra) # 936 <putc>
  putc(fd, 'x');
     a98:	fdc42783          	lw	a5,-36(s0)
     a9c:	07800593          	li	a1,120
     aa0:	853e                	mv	a0,a5
     aa2:	00000097          	auipc	ra,0x0
     aa6:	e94080e7          	jalr	-364(ra) # 936 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     aaa:	fe042623          	sw	zero,-20(s0)
     aae:	a82d                	j	ae8 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     ab0:	fd043783          	ld	a5,-48(s0)
     ab4:	93f1                	srli	a5,a5,0x3c
     ab6:	00000717          	auipc	a4,0x0
     aba:	73a70713          	addi	a4,a4,1850 # 11f0 <digits>
     abe:	97ba                	add	a5,a5,a4
     ac0:	0007c703          	lbu	a4,0(a5)
     ac4:	fdc42783          	lw	a5,-36(s0)
     ac8:	85ba                	mv	a1,a4
     aca:	853e                	mv	a0,a5
     acc:	00000097          	auipc	ra,0x0
     ad0:	e6a080e7          	jalr	-406(ra) # 936 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     ad4:	fec42783          	lw	a5,-20(s0)
     ad8:	2785                	addiw	a5,a5,1
     ada:	fef42623          	sw	a5,-20(s0)
     ade:	fd043783          	ld	a5,-48(s0)
     ae2:	0792                	slli	a5,a5,0x4
     ae4:	fcf43823          	sd	a5,-48(s0)
     ae8:	fec42783          	lw	a5,-20(s0)
     aec:	873e                	mv	a4,a5
     aee:	47bd                	li	a5,15
     af0:	fce7f0e3          	bgeu	a5,a4,ab0 <printptr+0x3c>
}
     af4:	0001                	nop
     af6:	0001                	nop
     af8:	70a2                	ld	ra,40(sp)
     afa:	7402                	ld	s0,32(sp)
     afc:	6145                	addi	sp,sp,48
     afe:	8082                	ret

0000000000000b00 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     b00:	715d                	addi	sp,sp,-80
     b02:	e486                	sd	ra,72(sp)
     b04:	e0a2                	sd	s0,64(sp)
     b06:	0880                	addi	s0,sp,80
     b08:	87aa                	mv	a5,a0
     b0a:	fcb43023          	sd	a1,-64(s0)
     b0e:	fac43c23          	sd	a2,-72(s0)
     b12:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     b16:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     b1a:	fe042223          	sw	zero,-28(s0)
     b1e:	a42d                	j	d48 <vprintf+0x248>
    c = fmt[i] & 0xff;
     b20:	fe442783          	lw	a5,-28(s0)
     b24:	fc043703          	ld	a4,-64(s0)
     b28:	97ba                	add	a5,a5,a4
     b2a:	0007c783          	lbu	a5,0(a5)
     b2e:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     b32:	fe042783          	lw	a5,-32(s0)
     b36:	2781                	sext.w	a5,a5
     b38:	eb9d                	bnez	a5,b6e <vprintf+0x6e>
      if(c == '%'){
     b3a:	fdc42783          	lw	a5,-36(s0)
     b3e:	0007871b          	sext.w	a4,a5
     b42:	02500793          	li	a5,37
     b46:	00f71763          	bne	a4,a5,b54 <vprintf+0x54>
        state = '%';
     b4a:	02500793          	li	a5,37
     b4e:	fef42023          	sw	a5,-32(s0)
     b52:	a2f5                	j	d3e <vprintf+0x23e>
      } else {
        putc(fd, c);
     b54:	fdc42783          	lw	a5,-36(s0)
     b58:	0ff7f713          	zext.b	a4,a5
     b5c:	fcc42783          	lw	a5,-52(s0)
     b60:	85ba                	mv	a1,a4
     b62:	853e                	mv	a0,a5
     b64:	00000097          	auipc	ra,0x0
     b68:	dd2080e7          	jalr	-558(ra) # 936 <putc>
     b6c:	aac9                	j	d3e <vprintf+0x23e>
      }
    } else if(state == '%'){
     b6e:	fe042783          	lw	a5,-32(s0)
     b72:	0007871b          	sext.w	a4,a5
     b76:	02500793          	li	a5,37
     b7a:	1cf71263          	bne	a4,a5,d3e <vprintf+0x23e>
      if(c == 'd'){
     b7e:	fdc42783          	lw	a5,-36(s0)
     b82:	0007871b          	sext.w	a4,a5
     b86:	06400793          	li	a5,100
     b8a:	02f71463          	bne	a4,a5,bb2 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     b8e:	fb843783          	ld	a5,-72(s0)
     b92:	00878713          	addi	a4,a5,8
     b96:	fae43c23          	sd	a4,-72(s0)
     b9a:	4398                	lw	a4,0(a5)
     b9c:	fcc42783          	lw	a5,-52(s0)
     ba0:	4685                	li	a3,1
     ba2:	4629                	li	a2,10
     ba4:	85ba                	mv	a1,a4
     ba6:	853e                	mv	a0,a5
     ba8:	00000097          	auipc	ra,0x0
     bac:	dc4080e7          	jalr	-572(ra) # 96c <printint>
     bb0:	a269                	j	d3a <vprintf+0x23a>
      } else if(c == 'l') {
     bb2:	fdc42783          	lw	a5,-36(s0)
     bb6:	0007871b          	sext.w	a4,a5
     bba:	06c00793          	li	a5,108
     bbe:	02f71663          	bne	a4,a5,bea <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     bc2:	fb843783          	ld	a5,-72(s0)
     bc6:	00878713          	addi	a4,a5,8
     bca:	fae43c23          	sd	a4,-72(s0)
     bce:	639c                	ld	a5,0(a5)
     bd0:	0007871b          	sext.w	a4,a5
     bd4:	fcc42783          	lw	a5,-52(s0)
     bd8:	4681                	li	a3,0
     bda:	4629                	li	a2,10
     bdc:	85ba                	mv	a1,a4
     bde:	853e                	mv	a0,a5
     be0:	00000097          	auipc	ra,0x0
     be4:	d8c080e7          	jalr	-628(ra) # 96c <printint>
     be8:	aa89                	j	d3a <vprintf+0x23a>
      } else if(c == 'x') {
     bea:	fdc42783          	lw	a5,-36(s0)
     bee:	0007871b          	sext.w	a4,a5
     bf2:	07800793          	li	a5,120
     bf6:	02f71463          	bne	a4,a5,c1e <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     bfa:	fb843783          	ld	a5,-72(s0)
     bfe:	00878713          	addi	a4,a5,8
     c02:	fae43c23          	sd	a4,-72(s0)
     c06:	4398                	lw	a4,0(a5)
     c08:	fcc42783          	lw	a5,-52(s0)
     c0c:	4681                	li	a3,0
     c0e:	4641                	li	a2,16
     c10:	85ba                	mv	a1,a4
     c12:	853e                	mv	a0,a5
     c14:	00000097          	auipc	ra,0x0
     c18:	d58080e7          	jalr	-680(ra) # 96c <printint>
     c1c:	aa39                	j	d3a <vprintf+0x23a>
      } else if(c == 'p') {
     c1e:	fdc42783          	lw	a5,-36(s0)
     c22:	0007871b          	sext.w	a4,a5
     c26:	07000793          	li	a5,112
     c2a:	02f71263          	bne	a4,a5,c4e <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     c2e:	fb843783          	ld	a5,-72(s0)
     c32:	00878713          	addi	a4,a5,8
     c36:	fae43c23          	sd	a4,-72(s0)
     c3a:	6398                	ld	a4,0(a5)
     c3c:	fcc42783          	lw	a5,-52(s0)
     c40:	85ba                	mv	a1,a4
     c42:	853e                	mv	a0,a5
     c44:	00000097          	auipc	ra,0x0
     c48:	e30080e7          	jalr	-464(ra) # a74 <printptr>
     c4c:	a0fd                	j	d3a <vprintf+0x23a>
      } else if(c == 's'){
     c4e:	fdc42783          	lw	a5,-36(s0)
     c52:	0007871b          	sext.w	a4,a5
     c56:	07300793          	li	a5,115
     c5a:	04f71c63          	bne	a4,a5,cb2 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     c5e:	fb843783          	ld	a5,-72(s0)
     c62:	00878713          	addi	a4,a5,8
     c66:	fae43c23          	sd	a4,-72(s0)
     c6a:	639c                	ld	a5,0(a5)
     c6c:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     c70:	fe843783          	ld	a5,-24(s0)
     c74:	eb8d                	bnez	a5,ca6 <vprintf+0x1a6>
          s = "(null)";
     c76:	00000797          	auipc	a5,0x0
     c7a:	57278793          	addi	a5,a5,1394 # 11e8 <malloc+0x238>
     c7e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     c82:	a015                	j	ca6 <vprintf+0x1a6>
          putc(fd, *s);
     c84:	fe843783          	ld	a5,-24(s0)
     c88:	0007c703          	lbu	a4,0(a5)
     c8c:	fcc42783          	lw	a5,-52(s0)
     c90:	85ba                	mv	a1,a4
     c92:	853e                	mv	a0,a5
     c94:	00000097          	auipc	ra,0x0
     c98:	ca2080e7          	jalr	-862(ra) # 936 <putc>
          s++;
     c9c:	fe843783          	ld	a5,-24(s0)
     ca0:	0785                	addi	a5,a5,1
     ca2:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     ca6:	fe843783          	ld	a5,-24(s0)
     caa:	0007c783          	lbu	a5,0(a5)
     cae:	fbf9                	bnez	a5,c84 <vprintf+0x184>
     cb0:	a069                	j	d3a <vprintf+0x23a>
        }
      } else if(c == 'c'){
     cb2:	fdc42783          	lw	a5,-36(s0)
     cb6:	0007871b          	sext.w	a4,a5
     cba:	06300793          	li	a5,99
     cbe:	02f71463          	bne	a4,a5,ce6 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     cc2:	fb843783          	ld	a5,-72(s0)
     cc6:	00878713          	addi	a4,a5,8
     cca:	fae43c23          	sd	a4,-72(s0)
     cce:	439c                	lw	a5,0(a5)
     cd0:	0ff7f713          	zext.b	a4,a5
     cd4:	fcc42783          	lw	a5,-52(s0)
     cd8:	85ba                	mv	a1,a4
     cda:	853e                	mv	a0,a5
     cdc:	00000097          	auipc	ra,0x0
     ce0:	c5a080e7          	jalr	-934(ra) # 936 <putc>
     ce4:	a899                	j	d3a <vprintf+0x23a>
      } else if(c == '%'){
     ce6:	fdc42783          	lw	a5,-36(s0)
     cea:	0007871b          	sext.w	a4,a5
     cee:	02500793          	li	a5,37
     cf2:	00f71f63          	bne	a4,a5,d10 <vprintf+0x210>
        putc(fd, c);
     cf6:	fdc42783          	lw	a5,-36(s0)
     cfa:	0ff7f713          	zext.b	a4,a5
     cfe:	fcc42783          	lw	a5,-52(s0)
     d02:	85ba                	mv	a1,a4
     d04:	853e                	mv	a0,a5
     d06:	00000097          	auipc	ra,0x0
     d0a:	c30080e7          	jalr	-976(ra) # 936 <putc>
     d0e:	a035                	j	d3a <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     d10:	fcc42783          	lw	a5,-52(s0)
     d14:	02500593          	li	a1,37
     d18:	853e                	mv	a0,a5
     d1a:	00000097          	auipc	ra,0x0
     d1e:	c1c080e7          	jalr	-996(ra) # 936 <putc>
        putc(fd, c);
     d22:	fdc42783          	lw	a5,-36(s0)
     d26:	0ff7f713          	zext.b	a4,a5
     d2a:	fcc42783          	lw	a5,-52(s0)
     d2e:	85ba                	mv	a1,a4
     d30:	853e                	mv	a0,a5
     d32:	00000097          	auipc	ra,0x0
     d36:	c04080e7          	jalr	-1020(ra) # 936 <putc>
      }
      state = 0;
     d3a:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     d3e:	fe442783          	lw	a5,-28(s0)
     d42:	2785                	addiw	a5,a5,1
     d44:	fef42223          	sw	a5,-28(s0)
     d48:	fe442783          	lw	a5,-28(s0)
     d4c:	fc043703          	ld	a4,-64(s0)
     d50:	97ba                	add	a5,a5,a4
     d52:	0007c783          	lbu	a5,0(a5)
     d56:	dc0795e3          	bnez	a5,b20 <vprintf+0x20>
    }
  }
}
     d5a:	0001                	nop
     d5c:	0001                	nop
     d5e:	60a6                	ld	ra,72(sp)
     d60:	6406                	ld	s0,64(sp)
     d62:	6161                	addi	sp,sp,80
     d64:	8082                	ret

0000000000000d66 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d66:	7159                	addi	sp,sp,-112
     d68:	fc06                	sd	ra,56(sp)
     d6a:	f822                	sd	s0,48(sp)
     d6c:	0080                	addi	s0,sp,64
     d6e:	fcb43823          	sd	a1,-48(s0)
     d72:	e010                	sd	a2,0(s0)
     d74:	e414                	sd	a3,8(s0)
     d76:	e818                	sd	a4,16(s0)
     d78:	ec1c                	sd	a5,24(s0)
     d7a:	03043023          	sd	a6,32(s0)
     d7e:	03143423          	sd	a7,40(s0)
     d82:	87aa                	mv	a5,a0
     d84:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d88:	03040793          	addi	a5,s0,48
     d8c:	fcf43423          	sd	a5,-56(s0)
     d90:	fc843783          	ld	a5,-56(s0)
     d94:	fd078793          	addi	a5,a5,-48
     d98:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     d9c:	fe843703          	ld	a4,-24(s0)
     da0:	fdc42783          	lw	a5,-36(s0)
     da4:	863a                	mv	a2,a4
     da6:	fd043583          	ld	a1,-48(s0)
     daa:	853e                	mv	a0,a5
     dac:	00000097          	auipc	ra,0x0
     db0:	d54080e7          	jalr	-684(ra) # b00 <vprintf>
}
     db4:	0001                	nop
     db6:	70e2                	ld	ra,56(sp)
     db8:	7442                	ld	s0,48(sp)
     dba:	6165                	addi	sp,sp,112
     dbc:	8082                	ret

0000000000000dbe <printf>:

void
printf(const char *fmt, ...)
{
     dbe:	7159                	addi	sp,sp,-112
     dc0:	f406                	sd	ra,40(sp)
     dc2:	f022                	sd	s0,32(sp)
     dc4:	1800                	addi	s0,sp,48
     dc6:	fca43c23          	sd	a0,-40(s0)
     dca:	e40c                	sd	a1,8(s0)
     dcc:	e810                	sd	a2,16(s0)
     dce:	ec14                	sd	a3,24(s0)
     dd0:	f018                	sd	a4,32(s0)
     dd2:	f41c                	sd	a5,40(s0)
     dd4:	03043823          	sd	a6,48(s0)
     dd8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     ddc:	04040793          	addi	a5,s0,64
     de0:	fcf43823          	sd	a5,-48(s0)
     de4:	fd043783          	ld	a5,-48(s0)
     de8:	fc878793          	addi	a5,a5,-56
     dec:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     df0:	fe843783          	ld	a5,-24(s0)
     df4:	863e                	mv	a2,a5
     df6:	fd843583          	ld	a1,-40(s0)
     dfa:	4505                	li	a0,1
     dfc:	00000097          	auipc	ra,0x0
     e00:	d04080e7          	jalr	-764(ra) # b00 <vprintf>
}
     e04:	0001                	nop
     e06:	70a2                	ld	ra,40(sp)
     e08:	7402                	ld	s0,32(sp)
     e0a:	6165                	addi	sp,sp,112
     e0c:	8082                	ret

0000000000000e0e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e0e:	7179                	addi	sp,sp,-48
     e10:	f422                	sd	s0,40(sp)
     e12:	1800                	addi	s0,sp,48
     e14:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e18:	fd843783          	ld	a5,-40(s0)
     e1c:	17c1                	addi	a5,a5,-16
     e1e:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e22:	00000797          	auipc	a5,0x0
     e26:	3fe78793          	addi	a5,a5,1022 # 1220 <freep>
     e2a:	639c                	ld	a5,0(a5)
     e2c:	fef43423          	sd	a5,-24(s0)
     e30:	a815                	j	e64 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e32:	fe843783          	ld	a5,-24(s0)
     e36:	639c                	ld	a5,0(a5)
     e38:	fe843703          	ld	a4,-24(s0)
     e3c:	00f76f63          	bltu	a4,a5,e5a <free+0x4c>
     e40:	fe043703          	ld	a4,-32(s0)
     e44:	fe843783          	ld	a5,-24(s0)
     e48:	02e7eb63          	bltu	a5,a4,e7e <free+0x70>
     e4c:	fe843783          	ld	a5,-24(s0)
     e50:	639c                	ld	a5,0(a5)
     e52:	fe043703          	ld	a4,-32(s0)
     e56:	02f76463          	bltu	a4,a5,e7e <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e5a:	fe843783          	ld	a5,-24(s0)
     e5e:	639c                	ld	a5,0(a5)
     e60:	fef43423          	sd	a5,-24(s0)
     e64:	fe043703          	ld	a4,-32(s0)
     e68:	fe843783          	ld	a5,-24(s0)
     e6c:	fce7f3e3          	bgeu	a5,a4,e32 <free+0x24>
     e70:	fe843783          	ld	a5,-24(s0)
     e74:	639c                	ld	a5,0(a5)
     e76:	fe043703          	ld	a4,-32(s0)
     e7a:	faf77ce3          	bgeu	a4,a5,e32 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     e7e:	fe043783          	ld	a5,-32(s0)
     e82:	479c                	lw	a5,8(a5)
     e84:	1782                	slli	a5,a5,0x20
     e86:	9381                	srli	a5,a5,0x20
     e88:	0792                	slli	a5,a5,0x4
     e8a:	fe043703          	ld	a4,-32(s0)
     e8e:	973e                	add	a4,a4,a5
     e90:	fe843783          	ld	a5,-24(s0)
     e94:	639c                	ld	a5,0(a5)
     e96:	02f71763          	bne	a4,a5,ec4 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     e9a:	fe043783          	ld	a5,-32(s0)
     e9e:	4798                	lw	a4,8(a5)
     ea0:	fe843783          	ld	a5,-24(s0)
     ea4:	639c                	ld	a5,0(a5)
     ea6:	479c                	lw	a5,8(a5)
     ea8:	9fb9                	addw	a5,a5,a4
     eaa:	0007871b          	sext.w	a4,a5
     eae:	fe043783          	ld	a5,-32(s0)
     eb2:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     eb4:	fe843783          	ld	a5,-24(s0)
     eb8:	639c                	ld	a5,0(a5)
     eba:	6398                	ld	a4,0(a5)
     ebc:	fe043783          	ld	a5,-32(s0)
     ec0:	e398                	sd	a4,0(a5)
     ec2:	a039                	j	ed0 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     ec4:	fe843783          	ld	a5,-24(s0)
     ec8:	6398                	ld	a4,0(a5)
     eca:	fe043783          	ld	a5,-32(s0)
     ece:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     ed0:	fe843783          	ld	a5,-24(s0)
     ed4:	479c                	lw	a5,8(a5)
     ed6:	1782                	slli	a5,a5,0x20
     ed8:	9381                	srli	a5,a5,0x20
     eda:	0792                	slli	a5,a5,0x4
     edc:	fe843703          	ld	a4,-24(s0)
     ee0:	97ba                	add	a5,a5,a4
     ee2:	fe043703          	ld	a4,-32(s0)
     ee6:	02f71563          	bne	a4,a5,f10 <free+0x102>
    p->s.size += bp->s.size;
     eea:	fe843783          	ld	a5,-24(s0)
     eee:	4798                	lw	a4,8(a5)
     ef0:	fe043783          	ld	a5,-32(s0)
     ef4:	479c                	lw	a5,8(a5)
     ef6:	9fb9                	addw	a5,a5,a4
     ef8:	0007871b          	sext.w	a4,a5
     efc:	fe843783          	ld	a5,-24(s0)
     f00:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     f02:	fe043783          	ld	a5,-32(s0)
     f06:	6398                	ld	a4,0(a5)
     f08:	fe843783          	ld	a5,-24(s0)
     f0c:	e398                	sd	a4,0(a5)
     f0e:	a031                	j	f1a <free+0x10c>
  } else
    p->s.ptr = bp;
     f10:	fe843783          	ld	a5,-24(s0)
     f14:	fe043703          	ld	a4,-32(s0)
     f18:	e398                	sd	a4,0(a5)
  freep = p;
     f1a:	00000797          	auipc	a5,0x0
     f1e:	30678793          	addi	a5,a5,774 # 1220 <freep>
     f22:	fe843703          	ld	a4,-24(s0)
     f26:	e398                	sd	a4,0(a5)
}
     f28:	0001                	nop
     f2a:	7422                	ld	s0,40(sp)
     f2c:	6145                	addi	sp,sp,48
     f2e:	8082                	ret

0000000000000f30 <morecore>:

static Header*
morecore(uint nu)
{
     f30:	7179                	addi	sp,sp,-48
     f32:	f406                	sd	ra,40(sp)
     f34:	f022                	sd	s0,32(sp)
     f36:	1800                	addi	s0,sp,48
     f38:	87aa                	mv	a5,a0
     f3a:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     f3e:	fdc42783          	lw	a5,-36(s0)
     f42:	0007871b          	sext.w	a4,a5
     f46:	6785                	lui	a5,0x1
     f48:	00f77563          	bgeu	a4,a5,f52 <morecore+0x22>
    nu = 4096;
     f4c:	6785                	lui	a5,0x1
     f4e:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     f52:	fdc42783          	lw	a5,-36(s0)
     f56:	0047979b          	slliw	a5,a5,0x4
     f5a:	2781                	sext.w	a5,a5
     f5c:	2781                	sext.w	a5,a5
     f5e:	853e                	mv	a0,a5
     f60:	00000097          	auipc	ra,0x0
     f64:	9ae080e7          	jalr	-1618(ra) # 90e <sbrk>
     f68:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     f6c:	fe843703          	ld	a4,-24(s0)
     f70:	57fd                	li	a5,-1
     f72:	00f71463          	bne	a4,a5,f7a <morecore+0x4a>
    return 0;
     f76:	4781                	li	a5,0
     f78:	a03d                	j	fa6 <morecore+0x76>
  hp = (Header*)p;
     f7a:	fe843783          	ld	a5,-24(s0)
     f7e:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     f82:	fe043783          	ld	a5,-32(s0)
     f86:	fdc42703          	lw	a4,-36(s0)
     f8a:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f8c:	fe043783          	ld	a5,-32(s0)
     f90:	07c1                	addi	a5,a5,16
     f92:	853e                	mv	a0,a5
     f94:	00000097          	auipc	ra,0x0
     f98:	e7a080e7          	jalr	-390(ra) # e0e <free>
  return freep;
     f9c:	00000797          	auipc	a5,0x0
     fa0:	28478793          	addi	a5,a5,644 # 1220 <freep>
     fa4:	639c                	ld	a5,0(a5)
}
     fa6:	853e                	mv	a0,a5
     fa8:	70a2                	ld	ra,40(sp)
     faa:	7402                	ld	s0,32(sp)
     fac:	6145                	addi	sp,sp,48
     fae:	8082                	ret

0000000000000fb0 <malloc>:

void*
malloc(uint nbytes)
{
     fb0:	7139                	addi	sp,sp,-64
     fb2:	fc06                	sd	ra,56(sp)
     fb4:	f822                	sd	s0,48(sp)
     fb6:	0080                	addi	s0,sp,64
     fb8:	87aa                	mv	a5,a0
     fba:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fbe:	fcc46783          	lwu	a5,-52(s0)
     fc2:	07bd                	addi	a5,a5,15
     fc4:	8391                	srli	a5,a5,0x4
     fc6:	2781                	sext.w	a5,a5
     fc8:	2785                	addiw	a5,a5,1
     fca:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     fce:	00000797          	auipc	a5,0x0
     fd2:	25278793          	addi	a5,a5,594 # 1220 <freep>
     fd6:	639c                	ld	a5,0(a5)
     fd8:	fef43023          	sd	a5,-32(s0)
     fdc:	fe043783          	ld	a5,-32(s0)
     fe0:	ef95                	bnez	a5,101c <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     fe2:	00000797          	auipc	a5,0x0
     fe6:	22e78793          	addi	a5,a5,558 # 1210 <base>
     fea:	fef43023          	sd	a5,-32(s0)
     fee:	00000797          	auipc	a5,0x0
     ff2:	23278793          	addi	a5,a5,562 # 1220 <freep>
     ff6:	fe043703          	ld	a4,-32(s0)
     ffa:	e398                	sd	a4,0(a5)
     ffc:	00000797          	auipc	a5,0x0
    1000:	22478793          	addi	a5,a5,548 # 1220 <freep>
    1004:	6398                	ld	a4,0(a5)
    1006:	00000797          	auipc	a5,0x0
    100a:	20a78793          	addi	a5,a5,522 # 1210 <base>
    100e:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1010:	00000797          	auipc	a5,0x0
    1014:	20078793          	addi	a5,a5,512 # 1210 <base>
    1018:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    101c:	fe043783          	ld	a5,-32(s0)
    1020:	639c                	ld	a5,0(a5)
    1022:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1026:	fe843783          	ld	a5,-24(s0)
    102a:	4798                	lw	a4,8(a5)
    102c:	fdc42783          	lw	a5,-36(s0)
    1030:	2781                	sext.w	a5,a5
    1032:	06f76763          	bltu	a4,a5,10a0 <malloc+0xf0>
      if(p->s.size == nunits)
    1036:	fe843783          	ld	a5,-24(s0)
    103a:	4798                	lw	a4,8(a5)
    103c:	fdc42783          	lw	a5,-36(s0)
    1040:	2781                	sext.w	a5,a5
    1042:	00e79963          	bne	a5,a4,1054 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1046:	fe843783          	ld	a5,-24(s0)
    104a:	6398                	ld	a4,0(a5)
    104c:	fe043783          	ld	a5,-32(s0)
    1050:	e398                	sd	a4,0(a5)
    1052:	a825                	j	108a <malloc+0xda>
      else {
        p->s.size -= nunits;
    1054:	fe843783          	ld	a5,-24(s0)
    1058:	479c                	lw	a5,8(a5)
    105a:	fdc42703          	lw	a4,-36(s0)
    105e:	9f99                	subw	a5,a5,a4
    1060:	0007871b          	sext.w	a4,a5
    1064:	fe843783          	ld	a5,-24(s0)
    1068:	c798                	sw	a4,8(a5)
        p += p->s.size;
    106a:	fe843783          	ld	a5,-24(s0)
    106e:	479c                	lw	a5,8(a5)
    1070:	1782                	slli	a5,a5,0x20
    1072:	9381                	srli	a5,a5,0x20
    1074:	0792                	slli	a5,a5,0x4
    1076:	fe843703          	ld	a4,-24(s0)
    107a:	97ba                	add	a5,a5,a4
    107c:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1080:	fe843783          	ld	a5,-24(s0)
    1084:	fdc42703          	lw	a4,-36(s0)
    1088:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    108a:	00000797          	auipc	a5,0x0
    108e:	19678793          	addi	a5,a5,406 # 1220 <freep>
    1092:	fe043703          	ld	a4,-32(s0)
    1096:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1098:	fe843783          	ld	a5,-24(s0)
    109c:	07c1                	addi	a5,a5,16
    109e:	a091                	j	10e2 <malloc+0x132>
    }
    if(p == freep)
    10a0:	00000797          	auipc	a5,0x0
    10a4:	18078793          	addi	a5,a5,384 # 1220 <freep>
    10a8:	639c                	ld	a5,0(a5)
    10aa:	fe843703          	ld	a4,-24(s0)
    10ae:	02f71063          	bne	a4,a5,10ce <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    10b2:	fdc42783          	lw	a5,-36(s0)
    10b6:	853e                	mv	a0,a5
    10b8:	00000097          	auipc	ra,0x0
    10bc:	e78080e7          	jalr	-392(ra) # f30 <morecore>
    10c0:	fea43423          	sd	a0,-24(s0)
    10c4:	fe843783          	ld	a5,-24(s0)
    10c8:	e399                	bnez	a5,10ce <malloc+0x11e>
        return 0;
    10ca:	4781                	li	a5,0
    10cc:	a819                	j	10e2 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10ce:	fe843783          	ld	a5,-24(s0)
    10d2:	fef43023          	sd	a5,-32(s0)
    10d6:	fe843783          	ld	a5,-24(s0)
    10da:	639c                	ld	a5,0(a5)
    10dc:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    10e0:	b799                	j	1026 <malloc+0x76>
  }
}
    10e2:	853e                	mv	a0,a5
    10e4:	70e2                	ld	ra,56(sp)
    10e6:	7442                	ld	s0,48(sp)
    10e8:	6121                	addi	sp,sp,64
    10ea:	8082                	ret
