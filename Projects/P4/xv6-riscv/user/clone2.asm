
user/_clone2:     file format elf64-littleriscv


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
      16:	7ea080e7          	jalr	2026(ra) # 7fc <getpid>
      1a:	87aa                	mv	a5,a0
      1c:	873e                	mv	a4,a5
      1e:	00001797          	auipc	a5,0x1
      22:	25e78793          	addi	a5,a5,606 # 127c <ppid>
      26:	c398                	sw	a4,0(a5)
   void *stack = malloc(PGSIZE*2);
      28:	6509                	lui	a0,0x2
      2a:	00001097          	auipc	ra,0x1
      2e:	e7c080e7          	jalr	-388(ra) # ea6 <malloc>
      32:	fea43423          	sd	a0,-24(s0)
   assert(stack != NULL);
      36:	fe843783          	ld	a5,-24(s0)
      3a:	e3ad                	bnez	a5,9c <main+0x9c>
      3c:	4675                	li	a2,29
      3e:	00001597          	auipc	a1,0x1
      42:	0b258593          	addi	a1,a1,178 # 10f0 <lock_init+0x12>
      46:	00001517          	auipc	a0,0x1
      4a:	0ba50513          	addi	a0,a0,186 # 1100 <lock_init+0x22>
      4e:	00001097          	auipc	ra,0x1
      52:	c66080e7          	jalr	-922(ra) # cb4 <printf>
      56:	00001597          	auipc	a1,0x1
      5a:	0b258593          	addi	a1,a1,178 # 1108 <lock_init+0x2a>
      5e:	00001517          	auipc	a0,0x1
      62:	0ba50513          	addi	a0,a0,186 # 1118 <lock_init+0x3a>
      66:	00001097          	auipc	ra,0x1
      6a:	c4e080e7          	jalr	-946(ra) # cb4 <printf>
      6e:	00001517          	auipc	a0,0x1
      72:	0c250513          	addi	a0,a0,194 # 1130 <lock_init+0x52>
      76:	00001097          	auipc	ra,0x1
      7a:	c3e080e7          	jalr	-962(ra) # cb4 <printf>
      7e:	00001797          	auipc	a5,0x1
      82:	1fe78793          	addi	a5,a5,510 # 127c <ppid>
      86:	439c                	lw	a5,0(a5)
      88:	853e                	mv	a0,a5
      8a:	00000097          	auipc	ra,0x0
      8e:	722080e7          	jalr	1826(ra) # 7ac <kill>
      92:	4501                	li	a0,0
      94:	00000097          	auipc	ra,0x0
      98:	6e8080e7          	jalr	1768(ra) # 77c <exit>
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

   int clone_pid = clone(worker, (void*)&arg, stack);
      c2:	fe843603          	ld	a2,-24(s0)
      c6:	00001597          	auipc	a1,0x1
      ca:	1ae58593          	addi	a1,a1,430 # 1274 <arg>
      ce:	00000517          	auipc	a0,0x0
      d2:	12a50513          	addi	a0,a0,298 # 1f8 <worker>
      d6:	00000097          	auipc	ra,0x0
      da:	746080e7          	jalr	1862(ra) # 81c <clone>
      de:	87aa                	mv	a5,a0
      e0:	fef42223          	sw	a5,-28(s0)
   assert(clone_pid > 0);
      e4:	fe442783          	lw	a5,-28(s0)
      e8:	2781                	sext.w	a5,a5
      ea:	06f04363          	bgtz	a5,150 <main+0x150>
      ee:	02200613          	li	a2,34
      f2:	00001597          	auipc	a1,0x1
      f6:	ffe58593          	addi	a1,a1,-2 # 10f0 <lock_init+0x12>
      fa:	00001517          	auipc	a0,0x1
      fe:	00650513          	addi	a0,a0,6 # 1100 <lock_init+0x22>
     102:	00001097          	auipc	ra,0x1
     106:	bb2080e7          	jalr	-1102(ra) # cb4 <printf>
     10a:	00001597          	auipc	a1,0x1
     10e:	03658593          	addi	a1,a1,54 # 1140 <lock_init+0x62>
     112:	00001517          	auipc	a0,0x1
     116:	00650513          	addi	a0,a0,6 # 1118 <lock_init+0x3a>
     11a:	00001097          	auipc	ra,0x1
     11e:	b9a080e7          	jalr	-1126(ra) # cb4 <printf>
     122:	00001517          	auipc	a0,0x1
     126:	00e50513          	addi	a0,a0,14 # 1130 <lock_init+0x52>
     12a:	00001097          	auipc	ra,0x1
     12e:	b8a080e7          	jalr	-1142(ra) # cb4 <printf>
     132:	00001797          	auipc	a5,0x1
     136:	14a78793          	addi	a5,a5,330 # 127c <ppid>
     13a:	439c                	lw	a5,0(a5)
     13c:	853e                	mv	a0,a5
     13e:	00000097          	auipc	ra,0x0
     142:	66e080e7          	jalr	1646(ra) # 7ac <kill>
     146:	4501                	li	a0,0
     148:	00000097          	auipc	ra,0x0
     14c:	634080e7          	jalr	1588(ra) # 77c <exit>
   while(global != 55);
     150:	0001                	nop
     152:	00001797          	auipc	a5,0x1
     156:	12678793          	addi	a5,a5,294 # 1278 <global>
     15a:	439c                	lw	a5,0(a5)
     15c:	2781                	sext.w	a5,a5
     15e:	873e                	mv	a4,a5
     160:	03700793          	li	a5,55
     164:	fef717e3          	bne	a4,a5,152 <main+0x152>
   assert(arg == 1);
     168:	00001797          	auipc	a5,0x1
     16c:	10c78793          	addi	a5,a5,268 # 1274 <arg>
     170:	439c                	lw	a5,0(a5)
     172:	2781                	sext.w	a5,a5
     174:	873e                	mv	a4,a5
     176:	4785                	li	a5,1
     178:	06f70363          	beq	a4,a5,1de <main+0x1de>
     17c:	02400613          	li	a2,36
     180:	00001597          	auipc	a1,0x1
     184:	f7058593          	addi	a1,a1,-144 # 10f0 <lock_init+0x12>
     188:	00001517          	auipc	a0,0x1
     18c:	f7850513          	addi	a0,a0,-136 # 1100 <lock_init+0x22>
     190:	00001097          	auipc	ra,0x1
     194:	b24080e7          	jalr	-1244(ra) # cb4 <printf>
     198:	00001597          	auipc	a1,0x1
     19c:	fb858593          	addi	a1,a1,-72 # 1150 <lock_init+0x72>
     1a0:	00001517          	auipc	a0,0x1
     1a4:	f7850513          	addi	a0,a0,-136 # 1118 <lock_init+0x3a>
     1a8:	00001097          	auipc	ra,0x1
     1ac:	b0c080e7          	jalr	-1268(ra) # cb4 <printf>
     1b0:	00001517          	auipc	a0,0x1
     1b4:	f8050513          	addi	a0,a0,-128 # 1130 <lock_init+0x52>
     1b8:	00001097          	auipc	ra,0x1
     1bc:	afc080e7          	jalr	-1284(ra) # cb4 <printf>
     1c0:	00001797          	auipc	a5,0x1
     1c4:	0bc78793          	addi	a5,a5,188 # 127c <ppid>
     1c8:	439c                	lw	a5,0(a5)
     1ca:	853e                	mv	a0,a5
     1cc:	00000097          	auipc	ra,0x0
     1d0:	5e0080e7          	jalr	1504(ra) # 7ac <kill>
     1d4:	4501                	li	a0,0
     1d6:	00000097          	auipc	ra,0x0
     1da:	5a6080e7          	jalr	1446(ra) # 77c <exit>
   printf("TEST PASSED\n");
     1de:	00001517          	auipc	a0,0x1
     1e2:	f8250513          	addi	a0,a0,-126 # 1160 <lock_init+0x82>
     1e6:	00001097          	auipc	ra,0x1
     1ea:	ace080e7          	jalr	-1330(ra) # cb4 <printf>
   exit(0);
     1ee:	4501                	li	a0,0
     1f0:	00000097          	auipc	ra,0x0
     1f4:	58c080e7          	jalr	1420(ra) # 77c <exit>

00000000000001f8 <worker>:
}

void
worker(void *arg_ptr) {
     1f8:	7179                	addi	sp,sp,-48
     1fa:	f406                	sd	ra,40(sp)
     1fc:	f022                	sd	s0,32(sp)
     1fe:	1800                	addi	s0,sp,48
     200:	fca43c23          	sd	a0,-40(s0)

   printf ("WORKER: Entra función worker.\n");
     204:	00001517          	auipc	a0,0x1
     208:	f6c50513          	addi	a0,a0,-148 # 1170 <lock_init+0x92>
     20c:	00001097          	auipc	ra,0x1
     210:	aa8080e7          	jalr	-1368(ra) # cb4 <printf>
   printf ("WORKER: El valor del argumento del stack es: %d\n", *(int*)arg_ptr);
     214:	fd843783          	ld	a5,-40(s0)
     218:	439c                	lw	a5,0(a5)
     21a:	85be                	mv	a1,a5
     21c:	00001517          	auipc	a0,0x1
     220:	f7450513          	addi	a0,a0,-140 # 1190 <lock_init+0xb2>
     224:	00001097          	auipc	ra,0x1
     228:	a90080e7          	jalr	-1392(ra) # cb4 <printf>
   int tmp = *(int*)arg_ptr;
     22c:	fd843783          	ld	a5,-40(s0)
     230:	439c                	lw	a5,0(a5)
     232:	fef42623          	sw	a5,-20(s0)
   *(int*)arg_ptr = 1;
     236:	fd843783          	ld	a5,-40(s0)
     23a:	4705                	li	a4,1
     23c:	c398                	sw	a4,0(a5)
   assert(global == 1);
     23e:	00001797          	auipc	a5,0x1
     242:	03a78793          	addi	a5,a5,58 # 1278 <global>
     246:	439c                	lw	a5,0(a5)
     248:	2781                	sext.w	a5,a5
     24a:	873e                	mv	a4,a5
     24c:	4785                	li	a5,1
     24e:	06f70363          	beq	a4,a5,2b4 <worker+0xbc>
     252:	03000613          	li	a2,48
     256:	00001597          	auipc	a1,0x1
     25a:	e9a58593          	addi	a1,a1,-358 # 10f0 <lock_init+0x12>
     25e:	00001517          	auipc	a0,0x1
     262:	ea250513          	addi	a0,a0,-350 # 1100 <lock_init+0x22>
     266:	00001097          	auipc	ra,0x1
     26a:	a4e080e7          	jalr	-1458(ra) # cb4 <printf>
     26e:	00001597          	auipc	a1,0x1
     272:	f5a58593          	addi	a1,a1,-166 # 11c8 <lock_init+0xea>
     276:	00001517          	auipc	a0,0x1
     27a:	ea250513          	addi	a0,a0,-350 # 1118 <lock_init+0x3a>
     27e:	00001097          	auipc	ra,0x1
     282:	a36080e7          	jalr	-1482(ra) # cb4 <printf>
     286:	00001517          	auipc	a0,0x1
     28a:	eaa50513          	addi	a0,a0,-342 # 1130 <lock_init+0x52>
     28e:	00001097          	auipc	ra,0x1
     292:	a26080e7          	jalr	-1498(ra) # cb4 <printf>
     296:	00001797          	auipc	a5,0x1
     29a:	fe678793          	addi	a5,a5,-26 # 127c <ppid>
     29e:	439c                	lw	a5,0(a5)
     2a0:	853e                	mv	a0,a5
     2a2:	00000097          	auipc	ra,0x0
     2a6:	50a080e7          	jalr	1290(ra) # 7ac <kill>
     2aa:	4501                	li	a0,0
     2ac:	00000097          	auipc	ra,0x0
     2b0:	4d0080e7          	jalr	1232(ra) # 77c <exit>
   global = tmp;
     2b4:	00001797          	auipc	a5,0x1
     2b8:	fc478793          	addi	a5,a5,-60 # 1278 <global>
     2bc:	fec42703          	lw	a4,-20(s0)
     2c0:	c398                	sw	a4,0(a5)
   printf ("WORKER: La variable global ahora vale: %d\n", global);
     2c2:	00001797          	auipc	a5,0x1
     2c6:	fb678793          	addi	a5,a5,-74 # 1278 <global>
     2ca:	439c                	lw	a5,0(a5)
     2cc:	2781                	sext.w	a5,a5
     2ce:	85be                	mv	a1,a5
     2d0:	00001517          	auipc	a0,0x1
     2d4:	f0850513          	addi	a0,a0,-248 # 11d8 <lock_init+0xfa>
     2d8:	00001097          	auipc	ra,0x1
     2dc:	9dc080e7          	jalr	-1572(ra) # cb4 <printf>
   exit(0);
     2e0:	4501                	li	a0,0
     2e2:	00000097          	auipc	ra,0x0
     2e6:	49a080e7          	jalr	1178(ra) # 77c <exit>

00000000000002ea <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     2ea:	7179                	addi	sp,sp,-48
     2ec:	f422                	sd	s0,40(sp)
     2ee:	1800                	addi	s0,sp,48
     2f0:	fca43c23          	sd	a0,-40(s0)
     2f4:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     2f8:	fd843783          	ld	a5,-40(s0)
     2fc:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     300:	0001                	nop
     302:	fd043703          	ld	a4,-48(s0)
     306:	00170793          	addi	a5,a4,1 # 1001 <thread_create+0x1f>
     30a:	fcf43823          	sd	a5,-48(s0)
     30e:	fd843783          	ld	a5,-40(s0)
     312:	00178693          	addi	a3,a5,1
     316:	fcd43c23          	sd	a3,-40(s0)
     31a:	00074703          	lbu	a4,0(a4)
     31e:	00e78023          	sb	a4,0(a5)
     322:	0007c783          	lbu	a5,0(a5)
     326:	fff1                	bnez	a5,302 <strcpy+0x18>
    ;
  return os;
     328:	fe843783          	ld	a5,-24(s0)
}
     32c:	853e                	mv	a0,a5
     32e:	7422                	ld	s0,40(sp)
     330:	6145                	addi	sp,sp,48
     332:	8082                	ret

0000000000000334 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     334:	1101                	addi	sp,sp,-32
     336:	ec22                	sd	s0,24(sp)
     338:	1000                	addi	s0,sp,32
     33a:	fea43423          	sd	a0,-24(s0)
     33e:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     342:	a819                	j	358 <strcmp+0x24>
    p++, q++;
     344:	fe843783          	ld	a5,-24(s0)
     348:	0785                	addi	a5,a5,1
     34a:	fef43423          	sd	a5,-24(s0)
     34e:	fe043783          	ld	a5,-32(s0)
     352:	0785                	addi	a5,a5,1
     354:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     358:	fe843783          	ld	a5,-24(s0)
     35c:	0007c783          	lbu	a5,0(a5)
     360:	cb99                	beqz	a5,376 <strcmp+0x42>
     362:	fe843783          	ld	a5,-24(s0)
     366:	0007c703          	lbu	a4,0(a5)
     36a:	fe043783          	ld	a5,-32(s0)
     36e:	0007c783          	lbu	a5,0(a5)
     372:	fcf709e3          	beq	a4,a5,344 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     376:	fe843783          	ld	a5,-24(s0)
     37a:	0007c783          	lbu	a5,0(a5)
     37e:	0007871b          	sext.w	a4,a5
     382:	fe043783          	ld	a5,-32(s0)
     386:	0007c783          	lbu	a5,0(a5)
     38a:	2781                	sext.w	a5,a5
     38c:	40f707bb          	subw	a5,a4,a5
     390:	2781                	sext.w	a5,a5
}
     392:	853e                	mv	a0,a5
     394:	6462                	ld	s0,24(sp)
     396:	6105                	addi	sp,sp,32
     398:	8082                	ret

000000000000039a <strlen>:

uint
strlen(const char *s)
{
     39a:	7179                	addi	sp,sp,-48
     39c:	f422                	sd	s0,40(sp)
     39e:	1800                	addi	s0,sp,48
     3a0:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     3a4:	fe042623          	sw	zero,-20(s0)
     3a8:	a031                	j	3b4 <strlen+0x1a>
     3aa:	fec42783          	lw	a5,-20(s0)
     3ae:	2785                	addiw	a5,a5,1
     3b0:	fef42623          	sw	a5,-20(s0)
     3b4:	fec42783          	lw	a5,-20(s0)
     3b8:	fd843703          	ld	a4,-40(s0)
     3bc:	97ba                	add	a5,a5,a4
     3be:	0007c783          	lbu	a5,0(a5)
     3c2:	f7e5                	bnez	a5,3aa <strlen+0x10>
    ;
  return n;
     3c4:	fec42783          	lw	a5,-20(s0)
}
     3c8:	853e                	mv	a0,a5
     3ca:	7422                	ld	s0,40(sp)
     3cc:	6145                	addi	sp,sp,48
     3ce:	8082                	ret

00000000000003d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     3d0:	7179                	addi	sp,sp,-48
     3d2:	f422                	sd	s0,40(sp)
     3d4:	1800                	addi	s0,sp,48
     3d6:	fca43c23          	sd	a0,-40(s0)
     3da:	87ae                	mv	a5,a1
     3dc:	8732                	mv	a4,a2
     3de:	fcf42a23          	sw	a5,-44(s0)
     3e2:	87ba                	mv	a5,a4
     3e4:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     3e8:	fd843783          	ld	a5,-40(s0)
     3ec:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     3f0:	fe042623          	sw	zero,-20(s0)
     3f4:	a00d                	j	416 <memset+0x46>
    cdst[i] = c;
     3f6:	fec42783          	lw	a5,-20(s0)
     3fa:	fe043703          	ld	a4,-32(s0)
     3fe:	97ba                	add	a5,a5,a4
     400:	fd442703          	lw	a4,-44(s0)
     404:	0ff77713          	zext.b	a4,a4
     408:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     40c:	fec42783          	lw	a5,-20(s0)
     410:	2785                	addiw	a5,a5,1
     412:	fef42623          	sw	a5,-20(s0)
     416:	fec42703          	lw	a4,-20(s0)
     41a:	fd042783          	lw	a5,-48(s0)
     41e:	2781                	sext.w	a5,a5
     420:	fcf76be3          	bltu	a4,a5,3f6 <memset+0x26>
  }
  return dst;
     424:	fd843783          	ld	a5,-40(s0)
}
     428:	853e                	mv	a0,a5
     42a:	7422                	ld	s0,40(sp)
     42c:	6145                	addi	sp,sp,48
     42e:	8082                	ret

0000000000000430 <strchr>:

char*
strchr(const char *s, char c)
{
     430:	1101                	addi	sp,sp,-32
     432:	ec22                	sd	s0,24(sp)
     434:	1000                	addi	s0,sp,32
     436:	fea43423          	sd	a0,-24(s0)
     43a:	87ae                	mv	a5,a1
     43c:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     440:	a01d                	j	466 <strchr+0x36>
    if(*s == c)
     442:	fe843783          	ld	a5,-24(s0)
     446:	0007c703          	lbu	a4,0(a5)
     44a:	fe744783          	lbu	a5,-25(s0)
     44e:	0ff7f793          	zext.b	a5,a5
     452:	00e79563          	bne	a5,a4,45c <strchr+0x2c>
      return (char*)s;
     456:	fe843783          	ld	a5,-24(s0)
     45a:	a821                	j	472 <strchr+0x42>
  for(; *s; s++)
     45c:	fe843783          	ld	a5,-24(s0)
     460:	0785                	addi	a5,a5,1
     462:	fef43423          	sd	a5,-24(s0)
     466:	fe843783          	ld	a5,-24(s0)
     46a:	0007c783          	lbu	a5,0(a5)
     46e:	fbf1                	bnez	a5,442 <strchr+0x12>
  return 0;
     470:	4781                	li	a5,0
}
     472:	853e                	mv	a0,a5
     474:	6462                	ld	s0,24(sp)
     476:	6105                	addi	sp,sp,32
     478:	8082                	ret

000000000000047a <gets>:

char*
gets(char *buf, int max)
{
     47a:	7179                	addi	sp,sp,-48
     47c:	f406                	sd	ra,40(sp)
     47e:	f022                	sd	s0,32(sp)
     480:	1800                	addi	s0,sp,48
     482:	fca43c23          	sd	a0,-40(s0)
     486:	87ae                	mv	a5,a1
     488:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     48c:	fe042623          	sw	zero,-20(s0)
     490:	a8a1                	j	4e8 <gets+0x6e>
    cc = read(0, &c, 1);
     492:	fe740793          	addi	a5,s0,-25
     496:	4605                	li	a2,1
     498:	85be                	mv	a1,a5
     49a:	4501                	li	a0,0
     49c:	00000097          	auipc	ra,0x0
     4a0:	2f8080e7          	jalr	760(ra) # 794 <read>
     4a4:	87aa                	mv	a5,a0
     4a6:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     4aa:	fe842783          	lw	a5,-24(s0)
     4ae:	2781                	sext.w	a5,a5
     4b0:	04f05763          	blez	a5,4fe <gets+0x84>
      break;
    buf[i++] = c;
     4b4:	fec42783          	lw	a5,-20(s0)
     4b8:	0017871b          	addiw	a4,a5,1
     4bc:	fee42623          	sw	a4,-20(s0)
     4c0:	873e                	mv	a4,a5
     4c2:	fd843783          	ld	a5,-40(s0)
     4c6:	97ba                	add	a5,a5,a4
     4c8:	fe744703          	lbu	a4,-25(s0)
     4cc:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     4d0:	fe744783          	lbu	a5,-25(s0)
     4d4:	873e                	mv	a4,a5
     4d6:	47a9                	li	a5,10
     4d8:	02f70463          	beq	a4,a5,500 <gets+0x86>
     4dc:	fe744783          	lbu	a5,-25(s0)
     4e0:	873e                	mv	a4,a5
     4e2:	47b5                	li	a5,13
     4e4:	00f70e63          	beq	a4,a5,500 <gets+0x86>
  for(i=0; i+1 < max; ){
     4e8:	fec42783          	lw	a5,-20(s0)
     4ec:	2785                	addiw	a5,a5,1
     4ee:	0007871b          	sext.w	a4,a5
     4f2:	fd442783          	lw	a5,-44(s0)
     4f6:	2781                	sext.w	a5,a5
     4f8:	f8f74de3          	blt	a4,a5,492 <gets+0x18>
     4fc:	a011                	j	500 <gets+0x86>
      break;
     4fe:	0001                	nop
      break;
  }
  buf[i] = '\0';
     500:	fec42783          	lw	a5,-20(s0)
     504:	fd843703          	ld	a4,-40(s0)
     508:	97ba                	add	a5,a5,a4
     50a:	00078023          	sb	zero,0(a5)
  return buf;
     50e:	fd843783          	ld	a5,-40(s0)
}
     512:	853e                	mv	a0,a5
     514:	70a2                	ld	ra,40(sp)
     516:	7402                	ld	s0,32(sp)
     518:	6145                	addi	sp,sp,48
     51a:	8082                	ret

000000000000051c <stat>:

int
stat(const char *n, struct stat *st)
{
     51c:	7179                	addi	sp,sp,-48
     51e:	f406                	sd	ra,40(sp)
     520:	f022                	sd	s0,32(sp)
     522:	1800                	addi	s0,sp,48
     524:	fca43c23          	sd	a0,-40(s0)
     528:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     52c:	4581                	li	a1,0
     52e:	fd843503          	ld	a0,-40(s0)
     532:	00000097          	auipc	ra,0x0
     536:	28a080e7          	jalr	650(ra) # 7bc <open>
     53a:	87aa                	mv	a5,a0
     53c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     540:	fec42783          	lw	a5,-20(s0)
     544:	2781                	sext.w	a5,a5
     546:	0007d463          	bgez	a5,54e <stat+0x32>
    return -1;
     54a:	57fd                	li	a5,-1
     54c:	a035                	j	578 <stat+0x5c>
  r = fstat(fd, st);
     54e:	fec42783          	lw	a5,-20(s0)
     552:	fd043583          	ld	a1,-48(s0)
     556:	853e                	mv	a0,a5
     558:	00000097          	auipc	ra,0x0
     55c:	27c080e7          	jalr	636(ra) # 7d4 <fstat>
     560:	87aa                	mv	a5,a0
     562:	fef42423          	sw	a5,-24(s0)
  close(fd);
     566:	fec42783          	lw	a5,-20(s0)
     56a:	853e                	mv	a0,a5
     56c:	00000097          	auipc	ra,0x0
     570:	238080e7          	jalr	568(ra) # 7a4 <close>
  return r;
     574:	fe842783          	lw	a5,-24(s0)
}
     578:	853e                	mv	a0,a5
     57a:	70a2                	ld	ra,40(sp)
     57c:	7402                	ld	s0,32(sp)
     57e:	6145                	addi	sp,sp,48
     580:	8082                	ret

0000000000000582 <atoi>:

int
atoi(const char *s)
{
     582:	7179                	addi	sp,sp,-48
     584:	f422                	sd	s0,40(sp)
     586:	1800                	addi	s0,sp,48
     588:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     58c:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     590:	a81d                	j	5c6 <atoi+0x44>
    n = n*10 + *s++ - '0';
     592:	fec42783          	lw	a5,-20(s0)
     596:	873e                	mv	a4,a5
     598:	87ba                	mv	a5,a4
     59a:	0027979b          	slliw	a5,a5,0x2
     59e:	9fb9                	addw	a5,a5,a4
     5a0:	0017979b          	slliw	a5,a5,0x1
     5a4:	0007871b          	sext.w	a4,a5
     5a8:	fd843783          	ld	a5,-40(s0)
     5ac:	00178693          	addi	a3,a5,1
     5b0:	fcd43c23          	sd	a3,-40(s0)
     5b4:	0007c783          	lbu	a5,0(a5)
     5b8:	2781                	sext.w	a5,a5
     5ba:	9fb9                	addw	a5,a5,a4
     5bc:	2781                	sext.w	a5,a5
     5be:	fd07879b          	addiw	a5,a5,-48
     5c2:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     5c6:	fd843783          	ld	a5,-40(s0)
     5ca:	0007c783          	lbu	a5,0(a5)
     5ce:	873e                	mv	a4,a5
     5d0:	02f00793          	li	a5,47
     5d4:	00e7fb63          	bgeu	a5,a4,5ea <atoi+0x68>
     5d8:	fd843783          	ld	a5,-40(s0)
     5dc:	0007c783          	lbu	a5,0(a5)
     5e0:	873e                	mv	a4,a5
     5e2:	03900793          	li	a5,57
     5e6:	fae7f6e3          	bgeu	a5,a4,592 <atoi+0x10>
  return n;
     5ea:	fec42783          	lw	a5,-20(s0)
}
     5ee:	853e                	mv	a0,a5
     5f0:	7422                	ld	s0,40(sp)
     5f2:	6145                	addi	sp,sp,48
     5f4:	8082                	ret

00000000000005f6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     5f6:	7139                	addi	sp,sp,-64
     5f8:	fc22                	sd	s0,56(sp)
     5fa:	0080                	addi	s0,sp,64
     5fc:	fca43c23          	sd	a0,-40(s0)
     600:	fcb43823          	sd	a1,-48(s0)
     604:	87b2                	mv	a5,a2
     606:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     60a:	fd843783          	ld	a5,-40(s0)
     60e:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     612:	fd043783          	ld	a5,-48(s0)
     616:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     61a:	fe043703          	ld	a4,-32(s0)
     61e:	fe843783          	ld	a5,-24(s0)
     622:	02e7fc63          	bgeu	a5,a4,65a <memmove+0x64>
    while(n-- > 0)
     626:	a00d                	j	648 <memmove+0x52>
      *dst++ = *src++;
     628:	fe043703          	ld	a4,-32(s0)
     62c:	00170793          	addi	a5,a4,1
     630:	fef43023          	sd	a5,-32(s0)
     634:	fe843783          	ld	a5,-24(s0)
     638:	00178693          	addi	a3,a5,1
     63c:	fed43423          	sd	a3,-24(s0)
     640:	00074703          	lbu	a4,0(a4)
     644:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     648:	fcc42783          	lw	a5,-52(s0)
     64c:	fff7871b          	addiw	a4,a5,-1
     650:	fce42623          	sw	a4,-52(s0)
     654:	fcf04ae3          	bgtz	a5,628 <memmove+0x32>
     658:	a891                	j	6ac <memmove+0xb6>
  } else {
    dst += n;
     65a:	fcc42783          	lw	a5,-52(s0)
     65e:	fe843703          	ld	a4,-24(s0)
     662:	97ba                	add	a5,a5,a4
     664:	fef43423          	sd	a5,-24(s0)
    src += n;
     668:	fcc42783          	lw	a5,-52(s0)
     66c:	fe043703          	ld	a4,-32(s0)
     670:	97ba                	add	a5,a5,a4
     672:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     676:	a01d                	j	69c <memmove+0xa6>
      *--dst = *--src;
     678:	fe043783          	ld	a5,-32(s0)
     67c:	17fd                	addi	a5,a5,-1
     67e:	fef43023          	sd	a5,-32(s0)
     682:	fe843783          	ld	a5,-24(s0)
     686:	17fd                	addi	a5,a5,-1
     688:	fef43423          	sd	a5,-24(s0)
     68c:	fe043783          	ld	a5,-32(s0)
     690:	0007c703          	lbu	a4,0(a5)
     694:	fe843783          	ld	a5,-24(s0)
     698:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     69c:	fcc42783          	lw	a5,-52(s0)
     6a0:	fff7871b          	addiw	a4,a5,-1
     6a4:	fce42623          	sw	a4,-52(s0)
     6a8:	fcf048e3          	bgtz	a5,678 <memmove+0x82>
  }
  return vdst;
     6ac:	fd843783          	ld	a5,-40(s0)
}
     6b0:	853e                	mv	a0,a5
     6b2:	7462                	ld	s0,56(sp)
     6b4:	6121                	addi	sp,sp,64
     6b6:	8082                	ret

00000000000006b8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     6b8:	7139                	addi	sp,sp,-64
     6ba:	fc22                	sd	s0,56(sp)
     6bc:	0080                	addi	s0,sp,64
     6be:	fca43c23          	sd	a0,-40(s0)
     6c2:	fcb43823          	sd	a1,-48(s0)
     6c6:	87b2                	mv	a5,a2
     6c8:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     6cc:	fd843783          	ld	a5,-40(s0)
     6d0:	fef43423          	sd	a5,-24(s0)
     6d4:	fd043783          	ld	a5,-48(s0)
     6d8:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     6dc:	a0a1                	j	724 <memcmp+0x6c>
    if (*p1 != *p2) {
     6de:	fe843783          	ld	a5,-24(s0)
     6e2:	0007c703          	lbu	a4,0(a5)
     6e6:	fe043783          	ld	a5,-32(s0)
     6ea:	0007c783          	lbu	a5,0(a5)
     6ee:	02f70163          	beq	a4,a5,710 <memcmp+0x58>
      return *p1 - *p2;
     6f2:	fe843783          	ld	a5,-24(s0)
     6f6:	0007c783          	lbu	a5,0(a5)
     6fa:	0007871b          	sext.w	a4,a5
     6fe:	fe043783          	ld	a5,-32(s0)
     702:	0007c783          	lbu	a5,0(a5)
     706:	2781                	sext.w	a5,a5
     708:	40f707bb          	subw	a5,a4,a5
     70c:	2781                	sext.w	a5,a5
     70e:	a01d                	j	734 <memcmp+0x7c>
    }
    p1++;
     710:	fe843783          	ld	a5,-24(s0)
     714:	0785                	addi	a5,a5,1
     716:	fef43423          	sd	a5,-24(s0)
    p2++;
     71a:	fe043783          	ld	a5,-32(s0)
     71e:	0785                	addi	a5,a5,1
     720:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     724:	fcc42783          	lw	a5,-52(s0)
     728:	fff7871b          	addiw	a4,a5,-1
     72c:	fce42623          	sw	a4,-52(s0)
     730:	f7dd                	bnez	a5,6de <memcmp+0x26>
  }
  return 0;
     732:	4781                	li	a5,0
}
     734:	853e                	mv	a0,a5
     736:	7462                	ld	s0,56(sp)
     738:	6121                	addi	sp,sp,64
     73a:	8082                	ret

000000000000073c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     73c:	7179                	addi	sp,sp,-48
     73e:	f406                	sd	ra,40(sp)
     740:	f022                	sd	s0,32(sp)
     742:	1800                	addi	s0,sp,48
     744:	fea43423          	sd	a0,-24(s0)
     748:	feb43023          	sd	a1,-32(s0)
     74c:	87b2                	mv	a5,a2
     74e:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     752:	fdc42783          	lw	a5,-36(s0)
     756:	863e                	mv	a2,a5
     758:	fe043583          	ld	a1,-32(s0)
     75c:	fe843503          	ld	a0,-24(s0)
     760:	00000097          	auipc	ra,0x0
     764:	e96080e7          	jalr	-362(ra) # 5f6 <memmove>
     768:	87aa                	mv	a5,a0
}
     76a:	853e                	mv	a0,a5
     76c:	70a2                	ld	ra,40(sp)
     76e:	7402                	ld	s0,32(sp)
     770:	6145                	addi	sp,sp,48
     772:	8082                	ret

0000000000000774 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     774:	4885                	li	a7,1
 ecall
     776:	00000073          	ecall
 ret
     77a:	8082                	ret

000000000000077c <exit>:
.global exit
exit:
 li a7, SYS_exit
     77c:	4889                	li	a7,2
 ecall
     77e:	00000073          	ecall
 ret
     782:	8082                	ret

0000000000000784 <wait>:
.global wait
wait:
 li a7, SYS_wait
     784:	488d                	li	a7,3
 ecall
     786:	00000073          	ecall
 ret
     78a:	8082                	ret

000000000000078c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     78c:	4891                	li	a7,4
 ecall
     78e:	00000073          	ecall
 ret
     792:	8082                	ret

0000000000000794 <read>:
.global read
read:
 li a7, SYS_read
     794:	4895                	li	a7,5
 ecall
     796:	00000073          	ecall
 ret
     79a:	8082                	ret

000000000000079c <write>:
.global write
write:
 li a7, SYS_write
     79c:	48c1                	li	a7,16
 ecall
     79e:	00000073          	ecall
 ret
     7a2:	8082                	ret

00000000000007a4 <close>:
.global close
close:
 li a7, SYS_close
     7a4:	48d5                	li	a7,21
 ecall
     7a6:	00000073          	ecall
 ret
     7aa:	8082                	ret

00000000000007ac <kill>:
.global kill
kill:
 li a7, SYS_kill
     7ac:	4899                	li	a7,6
 ecall
     7ae:	00000073          	ecall
 ret
     7b2:	8082                	ret

00000000000007b4 <exec>:
.global exec
exec:
 li a7, SYS_exec
     7b4:	489d                	li	a7,7
 ecall
     7b6:	00000073          	ecall
 ret
     7ba:	8082                	ret

00000000000007bc <open>:
.global open
open:
 li a7, SYS_open
     7bc:	48bd                	li	a7,15
 ecall
     7be:	00000073          	ecall
 ret
     7c2:	8082                	ret

00000000000007c4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     7c4:	48c5                	li	a7,17
 ecall
     7c6:	00000073          	ecall
 ret
     7ca:	8082                	ret

00000000000007cc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     7cc:	48c9                	li	a7,18
 ecall
     7ce:	00000073          	ecall
 ret
     7d2:	8082                	ret

00000000000007d4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     7d4:	48a1                	li	a7,8
 ecall
     7d6:	00000073          	ecall
 ret
     7da:	8082                	ret

00000000000007dc <link>:
.global link
link:
 li a7, SYS_link
     7dc:	48cd                	li	a7,19
 ecall
     7de:	00000073          	ecall
 ret
     7e2:	8082                	ret

00000000000007e4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     7e4:	48d1                	li	a7,20
 ecall
     7e6:	00000073          	ecall
 ret
     7ea:	8082                	ret

00000000000007ec <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     7ec:	48a5                	li	a7,9
 ecall
     7ee:	00000073          	ecall
 ret
     7f2:	8082                	ret

00000000000007f4 <dup>:
.global dup
dup:
 li a7, SYS_dup
     7f4:	48a9                	li	a7,10
 ecall
     7f6:	00000073          	ecall
 ret
     7fa:	8082                	ret

00000000000007fc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     7fc:	48ad                	li	a7,11
 ecall
     7fe:	00000073          	ecall
 ret
     802:	8082                	ret

0000000000000804 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     804:	48b1                	li	a7,12
 ecall
     806:	00000073          	ecall
 ret
     80a:	8082                	ret

000000000000080c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     80c:	48b5                	li	a7,13
 ecall
     80e:	00000073          	ecall
 ret
     812:	8082                	ret

0000000000000814 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     814:	48b9                	li	a7,14
 ecall
     816:	00000073          	ecall
 ret
     81a:	8082                	ret

000000000000081c <clone>:
.global clone
clone:
 li a7, SYS_clone
     81c:	48d9                	li	a7,22
 ecall
     81e:	00000073          	ecall
 ret
     822:	8082                	ret

0000000000000824 <join>:
.global join
join:
 li a7, SYS_join
     824:	48dd                	li	a7,23
 ecall
     826:	00000073          	ecall
 ret
     82a:	8082                	ret

000000000000082c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     82c:	1101                	addi	sp,sp,-32
     82e:	ec06                	sd	ra,24(sp)
     830:	e822                	sd	s0,16(sp)
     832:	1000                	addi	s0,sp,32
     834:	87aa                	mv	a5,a0
     836:	872e                	mv	a4,a1
     838:	fef42623          	sw	a5,-20(s0)
     83c:	87ba                	mv	a5,a4
     83e:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     842:	feb40713          	addi	a4,s0,-21
     846:	fec42783          	lw	a5,-20(s0)
     84a:	4605                	li	a2,1
     84c:	85ba                	mv	a1,a4
     84e:	853e                	mv	a0,a5
     850:	00000097          	auipc	ra,0x0
     854:	f4c080e7          	jalr	-180(ra) # 79c <write>
}
     858:	0001                	nop
     85a:	60e2                	ld	ra,24(sp)
     85c:	6442                	ld	s0,16(sp)
     85e:	6105                	addi	sp,sp,32
     860:	8082                	ret

0000000000000862 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     862:	7139                	addi	sp,sp,-64
     864:	fc06                	sd	ra,56(sp)
     866:	f822                	sd	s0,48(sp)
     868:	0080                	addi	s0,sp,64
     86a:	87aa                	mv	a5,a0
     86c:	8736                	mv	a4,a3
     86e:	fcf42623          	sw	a5,-52(s0)
     872:	87ae                	mv	a5,a1
     874:	fcf42423          	sw	a5,-56(s0)
     878:	87b2                	mv	a5,a2
     87a:	fcf42223          	sw	a5,-60(s0)
     87e:	87ba                	mv	a5,a4
     880:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     884:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     888:	fc042783          	lw	a5,-64(s0)
     88c:	2781                	sext.w	a5,a5
     88e:	c38d                	beqz	a5,8b0 <printint+0x4e>
     890:	fc842783          	lw	a5,-56(s0)
     894:	2781                	sext.w	a5,a5
     896:	0007dd63          	bgez	a5,8b0 <printint+0x4e>
    neg = 1;
     89a:	4785                	li	a5,1
     89c:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     8a0:	fc842783          	lw	a5,-56(s0)
     8a4:	40f007bb          	negw	a5,a5
     8a8:	2781                	sext.w	a5,a5
     8aa:	fef42223          	sw	a5,-28(s0)
     8ae:	a029                	j	8b8 <printint+0x56>
  } else {
    x = xx;
     8b0:	fc842783          	lw	a5,-56(s0)
     8b4:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     8b8:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     8bc:	fc442783          	lw	a5,-60(s0)
     8c0:	fe442703          	lw	a4,-28(s0)
     8c4:	02f777bb          	remuw	a5,a4,a5
     8c8:	0007861b          	sext.w	a2,a5
     8cc:	fec42783          	lw	a5,-20(s0)
     8d0:	0017871b          	addiw	a4,a5,1
     8d4:	fee42623          	sw	a4,-20(s0)
     8d8:	00001697          	auipc	a3,0x1
     8dc:	98868693          	addi	a3,a3,-1656 # 1260 <digits>
     8e0:	02061713          	slli	a4,a2,0x20
     8e4:	9301                	srli	a4,a4,0x20
     8e6:	9736                	add	a4,a4,a3
     8e8:	00074703          	lbu	a4,0(a4)
     8ec:	17c1                	addi	a5,a5,-16
     8ee:	97a2                	add	a5,a5,s0
     8f0:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     8f4:	fc442783          	lw	a5,-60(s0)
     8f8:	fe442703          	lw	a4,-28(s0)
     8fc:	02f757bb          	divuw	a5,a4,a5
     900:	fef42223          	sw	a5,-28(s0)
     904:	fe442783          	lw	a5,-28(s0)
     908:	2781                	sext.w	a5,a5
     90a:	fbcd                	bnez	a5,8bc <printint+0x5a>
  if(neg)
     90c:	fe842783          	lw	a5,-24(s0)
     910:	2781                	sext.w	a5,a5
     912:	cf85                	beqz	a5,94a <printint+0xe8>
    buf[i++] = '-';
     914:	fec42783          	lw	a5,-20(s0)
     918:	0017871b          	addiw	a4,a5,1
     91c:	fee42623          	sw	a4,-20(s0)
     920:	17c1                	addi	a5,a5,-16
     922:	97a2                	add	a5,a5,s0
     924:	02d00713          	li	a4,45
     928:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     92c:	a839                	j	94a <printint+0xe8>
    putc(fd, buf[i]);
     92e:	fec42783          	lw	a5,-20(s0)
     932:	17c1                	addi	a5,a5,-16
     934:	97a2                	add	a5,a5,s0
     936:	fe07c703          	lbu	a4,-32(a5)
     93a:	fcc42783          	lw	a5,-52(s0)
     93e:	85ba                	mv	a1,a4
     940:	853e                	mv	a0,a5
     942:	00000097          	auipc	ra,0x0
     946:	eea080e7          	jalr	-278(ra) # 82c <putc>
  while(--i >= 0)
     94a:	fec42783          	lw	a5,-20(s0)
     94e:	37fd                	addiw	a5,a5,-1
     950:	fef42623          	sw	a5,-20(s0)
     954:	fec42783          	lw	a5,-20(s0)
     958:	2781                	sext.w	a5,a5
     95a:	fc07dae3          	bgez	a5,92e <printint+0xcc>
}
     95e:	0001                	nop
     960:	0001                	nop
     962:	70e2                	ld	ra,56(sp)
     964:	7442                	ld	s0,48(sp)
     966:	6121                	addi	sp,sp,64
     968:	8082                	ret

000000000000096a <printptr>:

static void
printptr(int fd, uint64 x) {
     96a:	7179                	addi	sp,sp,-48
     96c:	f406                	sd	ra,40(sp)
     96e:	f022                	sd	s0,32(sp)
     970:	1800                	addi	s0,sp,48
     972:	87aa                	mv	a5,a0
     974:	fcb43823          	sd	a1,-48(s0)
     978:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     97c:	fdc42783          	lw	a5,-36(s0)
     980:	03000593          	li	a1,48
     984:	853e                	mv	a0,a5
     986:	00000097          	auipc	ra,0x0
     98a:	ea6080e7          	jalr	-346(ra) # 82c <putc>
  putc(fd, 'x');
     98e:	fdc42783          	lw	a5,-36(s0)
     992:	07800593          	li	a1,120
     996:	853e                	mv	a0,a5
     998:	00000097          	auipc	ra,0x0
     99c:	e94080e7          	jalr	-364(ra) # 82c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     9a0:	fe042623          	sw	zero,-20(s0)
     9a4:	a82d                	j	9de <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     9a6:	fd043783          	ld	a5,-48(s0)
     9aa:	93f1                	srli	a5,a5,0x3c
     9ac:	00001717          	auipc	a4,0x1
     9b0:	8b470713          	addi	a4,a4,-1868 # 1260 <digits>
     9b4:	97ba                	add	a5,a5,a4
     9b6:	0007c703          	lbu	a4,0(a5)
     9ba:	fdc42783          	lw	a5,-36(s0)
     9be:	85ba                	mv	a1,a4
     9c0:	853e                	mv	a0,a5
     9c2:	00000097          	auipc	ra,0x0
     9c6:	e6a080e7          	jalr	-406(ra) # 82c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     9ca:	fec42783          	lw	a5,-20(s0)
     9ce:	2785                	addiw	a5,a5,1
     9d0:	fef42623          	sw	a5,-20(s0)
     9d4:	fd043783          	ld	a5,-48(s0)
     9d8:	0792                	slli	a5,a5,0x4
     9da:	fcf43823          	sd	a5,-48(s0)
     9de:	fec42783          	lw	a5,-20(s0)
     9e2:	873e                	mv	a4,a5
     9e4:	47bd                	li	a5,15
     9e6:	fce7f0e3          	bgeu	a5,a4,9a6 <printptr+0x3c>
}
     9ea:	0001                	nop
     9ec:	0001                	nop
     9ee:	70a2                	ld	ra,40(sp)
     9f0:	7402                	ld	s0,32(sp)
     9f2:	6145                	addi	sp,sp,48
     9f4:	8082                	ret

00000000000009f6 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     9f6:	715d                	addi	sp,sp,-80
     9f8:	e486                	sd	ra,72(sp)
     9fa:	e0a2                	sd	s0,64(sp)
     9fc:	0880                	addi	s0,sp,80
     9fe:	87aa                	mv	a5,a0
     a00:	fcb43023          	sd	a1,-64(s0)
     a04:	fac43c23          	sd	a2,-72(s0)
     a08:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     a0c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     a10:	fe042223          	sw	zero,-28(s0)
     a14:	a42d                	j	c3e <vprintf+0x248>
    c = fmt[i] & 0xff;
     a16:	fe442783          	lw	a5,-28(s0)
     a1a:	fc043703          	ld	a4,-64(s0)
     a1e:	97ba                	add	a5,a5,a4
     a20:	0007c783          	lbu	a5,0(a5)
     a24:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     a28:	fe042783          	lw	a5,-32(s0)
     a2c:	2781                	sext.w	a5,a5
     a2e:	eb9d                	bnez	a5,a64 <vprintf+0x6e>
      if(c == '%'){
     a30:	fdc42783          	lw	a5,-36(s0)
     a34:	0007871b          	sext.w	a4,a5
     a38:	02500793          	li	a5,37
     a3c:	00f71763          	bne	a4,a5,a4a <vprintf+0x54>
        state = '%';
     a40:	02500793          	li	a5,37
     a44:	fef42023          	sw	a5,-32(s0)
     a48:	a2f5                	j	c34 <vprintf+0x23e>
      } else {
        putc(fd, c);
     a4a:	fdc42783          	lw	a5,-36(s0)
     a4e:	0ff7f713          	zext.b	a4,a5
     a52:	fcc42783          	lw	a5,-52(s0)
     a56:	85ba                	mv	a1,a4
     a58:	853e                	mv	a0,a5
     a5a:	00000097          	auipc	ra,0x0
     a5e:	dd2080e7          	jalr	-558(ra) # 82c <putc>
     a62:	aac9                	j	c34 <vprintf+0x23e>
      }
    } else if(state == '%'){
     a64:	fe042783          	lw	a5,-32(s0)
     a68:	0007871b          	sext.w	a4,a5
     a6c:	02500793          	li	a5,37
     a70:	1cf71263          	bne	a4,a5,c34 <vprintf+0x23e>
      if(c == 'd'){
     a74:	fdc42783          	lw	a5,-36(s0)
     a78:	0007871b          	sext.w	a4,a5
     a7c:	06400793          	li	a5,100
     a80:	02f71463          	bne	a4,a5,aa8 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     a84:	fb843783          	ld	a5,-72(s0)
     a88:	00878713          	addi	a4,a5,8
     a8c:	fae43c23          	sd	a4,-72(s0)
     a90:	4398                	lw	a4,0(a5)
     a92:	fcc42783          	lw	a5,-52(s0)
     a96:	4685                	li	a3,1
     a98:	4629                	li	a2,10
     a9a:	85ba                	mv	a1,a4
     a9c:	853e                	mv	a0,a5
     a9e:	00000097          	auipc	ra,0x0
     aa2:	dc4080e7          	jalr	-572(ra) # 862 <printint>
     aa6:	a269                	j	c30 <vprintf+0x23a>
      } else if(c == 'l') {
     aa8:	fdc42783          	lw	a5,-36(s0)
     aac:	0007871b          	sext.w	a4,a5
     ab0:	06c00793          	li	a5,108
     ab4:	02f71663          	bne	a4,a5,ae0 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     ab8:	fb843783          	ld	a5,-72(s0)
     abc:	00878713          	addi	a4,a5,8
     ac0:	fae43c23          	sd	a4,-72(s0)
     ac4:	639c                	ld	a5,0(a5)
     ac6:	0007871b          	sext.w	a4,a5
     aca:	fcc42783          	lw	a5,-52(s0)
     ace:	4681                	li	a3,0
     ad0:	4629                	li	a2,10
     ad2:	85ba                	mv	a1,a4
     ad4:	853e                	mv	a0,a5
     ad6:	00000097          	auipc	ra,0x0
     ada:	d8c080e7          	jalr	-628(ra) # 862 <printint>
     ade:	aa89                	j	c30 <vprintf+0x23a>
      } else if(c == 'x') {
     ae0:	fdc42783          	lw	a5,-36(s0)
     ae4:	0007871b          	sext.w	a4,a5
     ae8:	07800793          	li	a5,120
     aec:	02f71463          	bne	a4,a5,b14 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     af0:	fb843783          	ld	a5,-72(s0)
     af4:	00878713          	addi	a4,a5,8
     af8:	fae43c23          	sd	a4,-72(s0)
     afc:	4398                	lw	a4,0(a5)
     afe:	fcc42783          	lw	a5,-52(s0)
     b02:	4681                	li	a3,0
     b04:	4641                	li	a2,16
     b06:	85ba                	mv	a1,a4
     b08:	853e                	mv	a0,a5
     b0a:	00000097          	auipc	ra,0x0
     b0e:	d58080e7          	jalr	-680(ra) # 862 <printint>
     b12:	aa39                	j	c30 <vprintf+0x23a>
      } else if(c == 'p') {
     b14:	fdc42783          	lw	a5,-36(s0)
     b18:	0007871b          	sext.w	a4,a5
     b1c:	07000793          	li	a5,112
     b20:	02f71263          	bne	a4,a5,b44 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     b24:	fb843783          	ld	a5,-72(s0)
     b28:	00878713          	addi	a4,a5,8
     b2c:	fae43c23          	sd	a4,-72(s0)
     b30:	6398                	ld	a4,0(a5)
     b32:	fcc42783          	lw	a5,-52(s0)
     b36:	85ba                	mv	a1,a4
     b38:	853e                	mv	a0,a5
     b3a:	00000097          	auipc	ra,0x0
     b3e:	e30080e7          	jalr	-464(ra) # 96a <printptr>
     b42:	a0fd                	j	c30 <vprintf+0x23a>
      } else if(c == 's'){
     b44:	fdc42783          	lw	a5,-36(s0)
     b48:	0007871b          	sext.w	a4,a5
     b4c:	07300793          	li	a5,115
     b50:	04f71c63          	bne	a4,a5,ba8 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     b54:	fb843783          	ld	a5,-72(s0)
     b58:	00878713          	addi	a4,a5,8
     b5c:	fae43c23          	sd	a4,-72(s0)
     b60:	639c                	ld	a5,0(a5)
     b62:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     b66:	fe843783          	ld	a5,-24(s0)
     b6a:	eb8d                	bnez	a5,b9c <vprintf+0x1a6>
          s = "(null)";
     b6c:	00000797          	auipc	a5,0x0
     b70:	69c78793          	addi	a5,a5,1692 # 1208 <lock_init+0x12a>
     b74:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     b78:	a015                	j	b9c <vprintf+0x1a6>
          putc(fd, *s);
     b7a:	fe843783          	ld	a5,-24(s0)
     b7e:	0007c703          	lbu	a4,0(a5)
     b82:	fcc42783          	lw	a5,-52(s0)
     b86:	85ba                	mv	a1,a4
     b88:	853e                	mv	a0,a5
     b8a:	00000097          	auipc	ra,0x0
     b8e:	ca2080e7          	jalr	-862(ra) # 82c <putc>
          s++;
     b92:	fe843783          	ld	a5,-24(s0)
     b96:	0785                	addi	a5,a5,1
     b98:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     b9c:	fe843783          	ld	a5,-24(s0)
     ba0:	0007c783          	lbu	a5,0(a5)
     ba4:	fbf9                	bnez	a5,b7a <vprintf+0x184>
     ba6:	a069                	j	c30 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     ba8:	fdc42783          	lw	a5,-36(s0)
     bac:	0007871b          	sext.w	a4,a5
     bb0:	06300793          	li	a5,99
     bb4:	02f71463          	bne	a4,a5,bdc <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     bb8:	fb843783          	ld	a5,-72(s0)
     bbc:	00878713          	addi	a4,a5,8
     bc0:	fae43c23          	sd	a4,-72(s0)
     bc4:	439c                	lw	a5,0(a5)
     bc6:	0ff7f713          	zext.b	a4,a5
     bca:	fcc42783          	lw	a5,-52(s0)
     bce:	85ba                	mv	a1,a4
     bd0:	853e                	mv	a0,a5
     bd2:	00000097          	auipc	ra,0x0
     bd6:	c5a080e7          	jalr	-934(ra) # 82c <putc>
     bda:	a899                	j	c30 <vprintf+0x23a>
      } else if(c == '%'){
     bdc:	fdc42783          	lw	a5,-36(s0)
     be0:	0007871b          	sext.w	a4,a5
     be4:	02500793          	li	a5,37
     be8:	00f71f63          	bne	a4,a5,c06 <vprintf+0x210>
        putc(fd, c);
     bec:	fdc42783          	lw	a5,-36(s0)
     bf0:	0ff7f713          	zext.b	a4,a5
     bf4:	fcc42783          	lw	a5,-52(s0)
     bf8:	85ba                	mv	a1,a4
     bfa:	853e                	mv	a0,a5
     bfc:	00000097          	auipc	ra,0x0
     c00:	c30080e7          	jalr	-976(ra) # 82c <putc>
     c04:	a035                	j	c30 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     c06:	fcc42783          	lw	a5,-52(s0)
     c0a:	02500593          	li	a1,37
     c0e:	853e                	mv	a0,a5
     c10:	00000097          	auipc	ra,0x0
     c14:	c1c080e7          	jalr	-996(ra) # 82c <putc>
        putc(fd, c);
     c18:	fdc42783          	lw	a5,-36(s0)
     c1c:	0ff7f713          	zext.b	a4,a5
     c20:	fcc42783          	lw	a5,-52(s0)
     c24:	85ba                	mv	a1,a4
     c26:	853e                	mv	a0,a5
     c28:	00000097          	auipc	ra,0x0
     c2c:	c04080e7          	jalr	-1020(ra) # 82c <putc>
      }
      state = 0;
     c30:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     c34:	fe442783          	lw	a5,-28(s0)
     c38:	2785                	addiw	a5,a5,1
     c3a:	fef42223          	sw	a5,-28(s0)
     c3e:	fe442783          	lw	a5,-28(s0)
     c42:	fc043703          	ld	a4,-64(s0)
     c46:	97ba                	add	a5,a5,a4
     c48:	0007c783          	lbu	a5,0(a5)
     c4c:	dc0795e3          	bnez	a5,a16 <vprintf+0x20>
    }
  }
}
     c50:	0001                	nop
     c52:	0001                	nop
     c54:	60a6                	ld	ra,72(sp)
     c56:	6406                	ld	s0,64(sp)
     c58:	6161                	addi	sp,sp,80
     c5a:	8082                	ret

0000000000000c5c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     c5c:	7159                	addi	sp,sp,-112
     c5e:	fc06                	sd	ra,56(sp)
     c60:	f822                	sd	s0,48(sp)
     c62:	0080                	addi	s0,sp,64
     c64:	fcb43823          	sd	a1,-48(s0)
     c68:	e010                	sd	a2,0(s0)
     c6a:	e414                	sd	a3,8(s0)
     c6c:	e818                	sd	a4,16(s0)
     c6e:	ec1c                	sd	a5,24(s0)
     c70:	03043023          	sd	a6,32(s0)
     c74:	03143423          	sd	a7,40(s0)
     c78:	87aa                	mv	a5,a0
     c7a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     c7e:	03040793          	addi	a5,s0,48
     c82:	fcf43423          	sd	a5,-56(s0)
     c86:	fc843783          	ld	a5,-56(s0)
     c8a:	fd078793          	addi	a5,a5,-48
     c8e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     c92:	fe843703          	ld	a4,-24(s0)
     c96:	fdc42783          	lw	a5,-36(s0)
     c9a:	863a                	mv	a2,a4
     c9c:	fd043583          	ld	a1,-48(s0)
     ca0:	853e                	mv	a0,a5
     ca2:	00000097          	auipc	ra,0x0
     ca6:	d54080e7          	jalr	-684(ra) # 9f6 <vprintf>
}
     caa:	0001                	nop
     cac:	70e2                	ld	ra,56(sp)
     cae:	7442                	ld	s0,48(sp)
     cb0:	6165                	addi	sp,sp,112
     cb2:	8082                	ret

0000000000000cb4 <printf>:

void
printf(const char *fmt, ...)
{
     cb4:	7159                	addi	sp,sp,-112
     cb6:	f406                	sd	ra,40(sp)
     cb8:	f022                	sd	s0,32(sp)
     cba:	1800                	addi	s0,sp,48
     cbc:	fca43c23          	sd	a0,-40(s0)
     cc0:	e40c                	sd	a1,8(s0)
     cc2:	e810                	sd	a2,16(s0)
     cc4:	ec14                	sd	a3,24(s0)
     cc6:	f018                	sd	a4,32(s0)
     cc8:	f41c                	sd	a5,40(s0)
     cca:	03043823          	sd	a6,48(s0)
     cce:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     cd2:	04040793          	addi	a5,s0,64
     cd6:	fcf43823          	sd	a5,-48(s0)
     cda:	fd043783          	ld	a5,-48(s0)
     cde:	fc878793          	addi	a5,a5,-56
     ce2:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     ce6:	fe843783          	ld	a5,-24(s0)
     cea:	863e                	mv	a2,a5
     cec:	fd843583          	ld	a1,-40(s0)
     cf0:	4505                	li	a0,1
     cf2:	00000097          	auipc	ra,0x0
     cf6:	d04080e7          	jalr	-764(ra) # 9f6 <vprintf>
}
     cfa:	0001                	nop
     cfc:	70a2                	ld	ra,40(sp)
     cfe:	7402                	ld	s0,32(sp)
     d00:	6165                	addi	sp,sp,112
     d02:	8082                	ret

0000000000000d04 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     d04:	7179                	addi	sp,sp,-48
     d06:	f422                	sd	s0,40(sp)
     d08:	1800                	addi	s0,sp,48
     d0a:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     d0e:	fd843783          	ld	a5,-40(s0)
     d12:	17c1                	addi	a5,a5,-16
     d14:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d18:	00000797          	auipc	a5,0x0
     d1c:	57878793          	addi	a5,a5,1400 # 1290 <freep>
     d20:	639c                	ld	a5,0(a5)
     d22:	fef43423          	sd	a5,-24(s0)
     d26:	a815                	j	d5a <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     d28:	fe843783          	ld	a5,-24(s0)
     d2c:	639c                	ld	a5,0(a5)
     d2e:	fe843703          	ld	a4,-24(s0)
     d32:	00f76f63          	bltu	a4,a5,d50 <free+0x4c>
     d36:	fe043703          	ld	a4,-32(s0)
     d3a:	fe843783          	ld	a5,-24(s0)
     d3e:	02e7eb63          	bltu	a5,a4,d74 <free+0x70>
     d42:	fe843783          	ld	a5,-24(s0)
     d46:	639c                	ld	a5,0(a5)
     d48:	fe043703          	ld	a4,-32(s0)
     d4c:	02f76463          	bltu	a4,a5,d74 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d50:	fe843783          	ld	a5,-24(s0)
     d54:	639c                	ld	a5,0(a5)
     d56:	fef43423          	sd	a5,-24(s0)
     d5a:	fe043703          	ld	a4,-32(s0)
     d5e:	fe843783          	ld	a5,-24(s0)
     d62:	fce7f3e3          	bgeu	a5,a4,d28 <free+0x24>
     d66:	fe843783          	ld	a5,-24(s0)
     d6a:	639c                	ld	a5,0(a5)
     d6c:	fe043703          	ld	a4,-32(s0)
     d70:	faf77ce3          	bgeu	a4,a5,d28 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     d74:	fe043783          	ld	a5,-32(s0)
     d78:	479c                	lw	a5,8(a5)
     d7a:	1782                	slli	a5,a5,0x20
     d7c:	9381                	srli	a5,a5,0x20
     d7e:	0792                	slli	a5,a5,0x4
     d80:	fe043703          	ld	a4,-32(s0)
     d84:	973e                	add	a4,a4,a5
     d86:	fe843783          	ld	a5,-24(s0)
     d8a:	639c                	ld	a5,0(a5)
     d8c:	02f71763          	bne	a4,a5,dba <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     d90:	fe043783          	ld	a5,-32(s0)
     d94:	4798                	lw	a4,8(a5)
     d96:	fe843783          	ld	a5,-24(s0)
     d9a:	639c                	ld	a5,0(a5)
     d9c:	479c                	lw	a5,8(a5)
     d9e:	9fb9                	addw	a5,a5,a4
     da0:	0007871b          	sext.w	a4,a5
     da4:	fe043783          	ld	a5,-32(s0)
     da8:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     daa:	fe843783          	ld	a5,-24(s0)
     dae:	639c                	ld	a5,0(a5)
     db0:	6398                	ld	a4,0(a5)
     db2:	fe043783          	ld	a5,-32(s0)
     db6:	e398                	sd	a4,0(a5)
     db8:	a039                	j	dc6 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     dba:	fe843783          	ld	a5,-24(s0)
     dbe:	6398                	ld	a4,0(a5)
     dc0:	fe043783          	ld	a5,-32(s0)
     dc4:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     dc6:	fe843783          	ld	a5,-24(s0)
     dca:	479c                	lw	a5,8(a5)
     dcc:	1782                	slli	a5,a5,0x20
     dce:	9381                	srli	a5,a5,0x20
     dd0:	0792                	slli	a5,a5,0x4
     dd2:	fe843703          	ld	a4,-24(s0)
     dd6:	97ba                	add	a5,a5,a4
     dd8:	fe043703          	ld	a4,-32(s0)
     ddc:	02f71563          	bne	a4,a5,e06 <free+0x102>
    p->s.size += bp->s.size;
     de0:	fe843783          	ld	a5,-24(s0)
     de4:	4798                	lw	a4,8(a5)
     de6:	fe043783          	ld	a5,-32(s0)
     dea:	479c                	lw	a5,8(a5)
     dec:	9fb9                	addw	a5,a5,a4
     dee:	0007871b          	sext.w	a4,a5
     df2:	fe843783          	ld	a5,-24(s0)
     df6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     df8:	fe043783          	ld	a5,-32(s0)
     dfc:	6398                	ld	a4,0(a5)
     dfe:	fe843783          	ld	a5,-24(s0)
     e02:	e398                	sd	a4,0(a5)
     e04:	a031                	j	e10 <free+0x10c>
  } else
    p->s.ptr = bp;
     e06:	fe843783          	ld	a5,-24(s0)
     e0a:	fe043703          	ld	a4,-32(s0)
     e0e:	e398                	sd	a4,0(a5)
  freep = p;
     e10:	00000797          	auipc	a5,0x0
     e14:	48078793          	addi	a5,a5,1152 # 1290 <freep>
     e18:	fe843703          	ld	a4,-24(s0)
     e1c:	e398                	sd	a4,0(a5)
}
     e1e:	0001                	nop
     e20:	7422                	ld	s0,40(sp)
     e22:	6145                	addi	sp,sp,48
     e24:	8082                	ret

0000000000000e26 <morecore>:

static Header*
morecore(uint nu)
{
     e26:	7179                	addi	sp,sp,-48
     e28:	f406                	sd	ra,40(sp)
     e2a:	f022                	sd	s0,32(sp)
     e2c:	1800                	addi	s0,sp,48
     e2e:	87aa                	mv	a5,a0
     e30:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     e34:	fdc42783          	lw	a5,-36(s0)
     e38:	0007871b          	sext.w	a4,a5
     e3c:	6785                	lui	a5,0x1
     e3e:	00f77563          	bgeu	a4,a5,e48 <morecore+0x22>
    nu = 4096;
     e42:	6785                	lui	a5,0x1
     e44:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     e48:	fdc42783          	lw	a5,-36(s0)
     e4c:	0047979b          	slliw	a5,a5,0x4
     e50:	2781                	sext.w	a5,a5
     e52:	2781                	sext.w	a5,a5
     e54:	853e                	mv	a0,a5
     e56:	00000097          	auipc	ra,0x0
     e5a:	9ae080e7          	jalr	-1618(ra) # 804 <sbrk>
     e5e:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     e62:	fe843703          	ld	a4,-24(s0)
     e66:	57fd                	li	a5,-1
     e68:	00f71463          	bne	a4,a5,e70 <morecore+0x4a>
    return 0;
     e6c:	4781                	li	a5,0
     e6e:	a03d                	j	e9c <morecore+0x76>
  hp = (Header*)p;
     e70:	fe843783          	ld	a5,-24(s0)
     e74:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     e78:	fe043783          	ld	a5,-32(s0)
     e7c:	fdc42703          	lw	a4,-36(s0)
     e80:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     e82:	fe043783          	ld	a5,-32(s0)
     e86:	07c1                	addi	a5,a5,16
     e88:	853e                	mv	a0,a5
     e8a:	00000097          	auipc	ra,0x0
     e8e:	e7a080e7          	jalr	-390(ra) # d04 <free>
  return freep;
     e92:	00000797          	auipc	a5,0x0
     e96:	3fe78793          	addi	a5,a5,1022 # 1290 <freep>
     e9a:	639c                	ld	a5,0(a5)
}
     e9c:	853e                	mv	a0,a5
     e9e:	70a2                	ld	ra,40(sp)
     ea0:	7402                	ld	s0,32(sp)
     ea2:	6145                	addi	sp,sp,48
     ea4:	8082                	ret

0000000000000ea6 <malloc>:

void*
malloc(uint nbytes)
{
     ea6:	7139                	addi	sp,sp,-64
     ea8:	fc06                	sd	ra,56(sp)
     eaa:	f822                	sd	s0,48(sp)
     eac:	0080                	addi	s0,sp,64
     eae:	87aa                	mv	a5,a0
     eb0:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     eb4:	fcc46783          	lwu	a5,-52(s0)
     eb8:	07bd                	addi	a5,a5,15
     eba:	8391                	srli	a5,a5,0x4
     ebc:	2781                	sext.w	a5,a5
     ebe:	2785                	addiw	a5,a5,1
     ec0:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     ec4:	00000797          	auipc	a5,0x0
     ec8:	3cc78793          	addi	a5,a5,972 # 1290 <freep>
     ecc:	639c                	ld	a5,0(a5)
     ece:	fef43023          	sd	a5,-32(s0)
     ed2:	fe043783          	ld	a5,-32(s0)
     ed6:	ef95                	bnez	a5,f12 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     ed8:	00000797          	auipc	a5,0x0
     edc:	3a878793          	addi	a5,a5,936 # 1280 <base>
     ee0:	fef43023          	sd	a5,-32(s0)
     ee4:	00000797          	auipc	a5,0x0
     ee8:	3ac78793          	addi	a5,a5,940 # 1290 <freep>
     eec:	fe043703          	ld	a4,-32(s0)
     ef0:	e398                	sd	a4,0(a5)
     ef2:	00000797          	auipc	a5,0x0
     ef6:	39e78793          	addi	a5,a5,926 # 1290 <freep>
     efa:	6398                	ld	a4,0(a5)
     efc:	00000797          	auipc	a5,0x0
     f00:	38478793          	addi	a5,a5,900 # 1280 <base>
     f04:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     f06:	00000797          	auipc	a5,0x0
     f0a:	37a78793          	addi	a5,a5,890 # 1280 <base>
     f0e:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f12:	fe043783          	ld	a5,-32(s0)
     f16:	639c                	ld	a5,0(a5)
     f18:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     f1c:	fe843783          	ld	a5,-24(s0)
     f20:	4798                	lw	a4,8(a5)
     f22:	fdc42783          	lw	a5,-36(s0)
     f26:	2781                	sext.w	a5,a5
     f28:	06f76763          	bltu	a4,a5,f96 <malloc+0xf0>
      if(p->s.size == nunits)
     f2c:	fe843783          	ld	a5,-24(s0)
     f30:	4798                	lw	a4,8(a5)
     f32:	fdc42783          	lw	a5,-36(s0)
     f36:	2781                	sext.w	a5,a5
     f38:	00e79963          	bne	a5,a4,f4a <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     f3c:	fe843783          	ld	a5,-24(s0)
     f40:	6398                	ld	a4,0(a5)
     f42:	fe043783          	ld	a5,-32(s0)
     f46:	e398                	sd	a4,0(a5)
     f48:	a825                	j	f80 <malloc+0xda>
      else {
        p->s.size -= nunits;
     f4a:	fe843783          	ld	a5,-24(s0)
     f4e:	479c                	lw	a5,8(a5)
     f50:	fdc42703          	lw	a4,-36(s0)
     f54:	9f99                	subw	a5,a5,a4
     f56:	0007871b          	sext.w	a4,a5
     f5a:	fe843783          	ld	a5,-24(s0)
     f5e:	c798                	sw	a4,8(a5)
        p += p->s.size;
     f60:	fe843783          	ld	a5,-24(s0)
     f64:	479c                	lw	a5,8(a5)
     f66:	1782                	slli	a5,a5,0x20
     f68:	9381                	srli	a5,a5,0x20
     f6a:	0792                	slli	a5,a5,0x4
     f6c:	fe843703          	ld	a4,-24(s0)
     f70:	97ba                	add	a5,a5,a4
     f72:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     f76:	fe843783          	ld	a5,-24(s0)
     f7a:	fdc42703          	lw	a4,-36(s0)
     f7e:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     f80:	00000797          	auipc	a5,0x0
     f84:	31078793          	addi	a5,a5,784 # 1290 <freep>
     f88:	fe043703          	ld	a4,-32(s0)
     f8c:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     f8e:	fe843783          	ld	a5,-24(s0)
     f92:	07c1                	addi	a5,a5,16
     f94:	a091                	j	fd8 <malloc+0x132>
    }
    if(p == freep)
     f96:	00000797          	auipc	a5,0x0
     f9a:	2fa78793          	addi	a5,a5,762 # 1290 <freep>
     f9e:	639c                	ld	a5,0(a5)
     fa0:	fe843703          	ld	a4,-24(s0)
     fa4:	02f71063          	bne	a4,a5,fc4 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
     fa8:	fdc42783          	lw	a5,-36(s0)
     fac:	853e                	mv	a0,a5
     fae:	00000097          	auipc	ra,0x0
     fb2:	e78080e7          	jalr	-392(ra) # e26 <morecore>
     fb6:	fea43423          	sd	a0,-24(s0)
     fba:	fe843783          	ld	a5,-24(s0)
     fbe:	e399                	bnez	a5,fc4 <malloc+0x11e>
        return 0;
     fc0:	4781                	li	a5,0
     fc2:	a819                	j	fd8 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fc4:	fe843783          	ld	a5,-24(s0)
     fc8:	fef43023          	sd	a5,-32(s0)
     fcc:	fe843783          	ld	a5,-24(s0)
     fd0:	639c                	ld	a5,0(a5)
     fd2:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     fd6:	b799                	j	f1c <malloc+0x76>
  }
}
     fd8:	853e                	mv	a0,a5
     fda:	70e2                	ld	ra,56(sp)
     fdc:	7442                	ld	s0,48(sp)
     fde:	6121                	addi	sp,sp,64
     fe0:	8082                	ret

0000000000000fe2 <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
     fe2:	7179                	addi	sp,sp,-48
     fe4:	f406                	sd	ra,40(sp)
     fe6:	f022                	sd	s0,32(sp)
     fe8:	1800                	addi	s0,sp,48
     fea:	fca43c23          	sd	a0,-40(s0)
     fee:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
     ff2:	6505                	lui	a0,0x1
     ff4:	00000097          	auipc	ra,0x0
     ff8:	eb2080e7          	jalr	-334(ra) # ea6 <malloc>
     ffc:	fea43423          	sd	a0,-24(s0)
    1000:	fe843783          	ld	a5,-24(s0)
    1004:	e38d                	bnez	a5,1026 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
    1006:	00000517          	auipc	a0,0x0
    100a:	20a50513          	addi	a0,a0,522 # 1210 <lock_init+0x132>
    100e:	00000097          	auipc	ra,0x0
    1012:	ca6080e7          	jalr	-858(ra) # cb4 <printf>
        free(stack);
    1016:	fe843503          	ld	a0,-24(s0)
    101a:	00000097          	auipc	ra,0x0
    101e:	cea080e7          	jalr	-790(ra) # d04 <free>
        return -1;
    1022:	57fd                	li	a5,-1
    1024:	a099                	j	106a <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
    1026:	fe843783          	ld	a5,-24(s0)
    102a:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
    102e:	fe043703          	ld	a4,-32(s0)
    1032:	6785                	lui	a5,0x1
    1034:	17fd                	addi	a5,a5,-1
    1036:	8ff9                	and	a5,a5,a4
    1038:	cf91                	beqz	a5,1054 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
    103a:	fe043703          	ld	a4,-32(s0)
    103e:	6785                	lui	a5,0x1
    1040:	17fd                	addi	a5,a5,-1
    1042:	8ff9                	and	a5,a5,a4
    1044:	6705                	lui	a4,0x1
    1046:	40f707b3          	sub	a5,a4,a5
    104a:	fe843703          	ld	a4,-24(s0)
    104e:	97ba                	add	a5,a5,a4
    1050:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
    1054:	fe843603          	ld	a2,-24(s0)
    1058:	fd043583          	ld	a1,-48(s0)
    105c:	fd843503          	ld	a0,-40(s0)
    1060:	fffff097          	auipc	ra,0xfffff
    1064:	7bc080e7          	jalr	1980(ra) # 81c <clone>
    1068:	87aa                	mv	a5,a0
}
    106a:	853e                	mv	a0,a5
    106c:	70a2                	ld	ra,40(sp)
    106e:	7402                	ld	s0,32(sp)
    1070:	6145                	addi	sp,sp,48
    1072:	8082                	ret

0000000000001074 <thread_join>:


int thread_join()
{
    1074:	1101                	addi	sp,sp,-32
    1076:	ec06                	sd	ra,24(sp)
    1078:	e822                	sd	s0,16(sp)
    107a:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
    107c:	fe040793          	addi	a5,s0,-32
    1080:	853e                	mv	a0,a5
    1082:	fffff097          	auipc	ra,0xfffff
    1086:	7a2080e7          	jalr	1954(ra) # 824 <join>
    108a:	87aa                	mv	a5,a0
    108c:	fef42623          	sw	a5,-20(s0)
    1090:	fec42783          	lw	a5,-20(s0)
    1094:	0007871b          	sext.w	a4,a5
    1098:	57fd                	li	a5,-1
    109a:	00f70963          	beq	a4,a5,10ac <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
    109e:	fe043783          	ld	a5,-32(s0)
    10a2:	853e                	mv	a0,a5
    10a4:	00000097          	auipc	ra,0x0
    10a8:	c60080e7          	jalr	-928(ra) # d04 <free>
    } 

    return child_tid;
    10ac:	fec42783          	lw	a5,-20(s0)
}
    10b0:	853e                	mv	a0,a5
    10b2:	60e2                	ld	ra,24(sp)
    10b4:	6442                	ld	s0,16(sp)
    10b6:	6105                	addi	sp,sp,32
    10b8:	8082                	ret

00000000000010ba <lock_acquire>:


void lock_acquire (lock_t *)
{
    10ba:	1101                	addi	sp,sp,-32
    10bc:	ec22                	sd	s0,24(sp)
    10be:	1000                	addi	s0,sp,32
    10c0:	fea43423          	sd	a0,-24(s0)

}
    10c4:	0001                	nop
    10c6:	6462                	ld	s0,24(sp)
    10c8:	6105                	addi	sp,sp,32
    10ca:	8082                	ret

00000000000010cc <lock_release>:

void lock_release (lock_t *)
{
    10cc:	1101                	addi	sp,sp,-32
    10ce:	ec22                	sd	s0,24(sp)
    10d0:	1000                	addi	s0,sp,32
    10d2:	fea43423          	sd	a0,-24(s0)
    
}
    10d6:	0001                	nop
    10d8:	6462                	ld	s0,24(sp)
    10da:	6105                	addi	sp,sp,32
    10dc:	8082                	ret

00000000000010de <lock_init>:

void lock_init (lock_t *)
{
    10de:	1101                	addi	sp,sp,-32
    10e0:	ec22                	sd	s0,24(sp)
    10e2:	1000                	addi	s0,sp,32
    10e4:	fea43423          	sd	a0,-24(s0)
    
}
    10e8:	0001                	nop
    10ea:	6462                	ld	s0,24(sp)
    10ec:	6105                	addi	sp,sp,32
    10ee:	8082                	ret
