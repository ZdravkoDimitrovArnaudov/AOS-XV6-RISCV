
user/_sbrktest:     file format elf64-littleriscv


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
   ppid = getpid();//recoge pid del proceso
      12:	00000097          	auipc	ra,0x0
      16:	7aa080e7          	jalr	1962(ra) # 7bc <getpid>
      1a:	87aa                	mv	a5,a0
      1c:	873e                	mv	a4,a5
      1e:	00001797          	auipc	a5,0x1
      22:	1b278793          	addi	a5,a5,434 # 11d0 <ppid>
      26:	c398                	sw	a4,0(a5)
   void *stack = malloc(PGSIZE*2);//reserva dos páginas para el malloc
      28:	6509                	lui	a0,0x2
      2a:	00001097          	auipc	ra,0x1
      2e:	e3c080e7          	jalr	-452(ra) # e66 <malloc>
      32:	fea43423          	sd	a0,-24(s0)
   assert(stack != NULL); //comprueba que se haya podido crear bien memoria dinámica
      36:	fe843783          	ld	a5,-24(s0)
      3a:	e3ad                	bnez	a5,9c <main+0x9c>
      3c:	4671                	li	a2,28
      3e:	00001597          	auipc	a1,0x1
      42:	07258593          	addi	a1,a1,114 # 10b0 <lock_init+0x12>
      46:	00001517          	auipc	a0,0x1
      4a:	07a50513          	addi	a0,a0,122 # 10c0 <lock_init+0x22>
      4e:	00001097          	auipc	ra,0x1
      52:	c26080e7          	jalr	-986(ra) # c74 <printf>
      56:	00001597          	auipc	a1,0x1
      5a:	07258593          	addi	a1,a1,114 # 10c8 <lock_init+0x2a>
      5e:	00001517          	auipc	a0,0x1
      62:	07a50513          	addi	a0,a0,122 # 10d8 <lock_init+0x3a>
      66:	00001097          	auipc	ra,0x1
      6a:	c0e080e7          	jalr	-1010(ra) # c74 <printf>
      6e:	00001517          	auipc	a0,0x1
      72:	08250513          	addi	a0,a0,130 # 10f0 <lock_init+0x52>
      76:	00001097          	auipc	ra,0x1
      7a:	bfe080e7          	jalr	-1026(ra) # c74 <printf>
      7e:	00001797          	auipc	a5,0x1
      82:	15278793          	addi	a5,a5,338 # 11d0 <ppid>
      86:	439c                	lw	a5,0(a5)
      88:	853e                	mv	a0,a5
      8a:	00000097          	auipc	ra,0x0
      8e:	6e2080e7          	jalr	1762(ra) # 76c <kill>
      92:	4501                	li	a0,0
      94:	00000097          	auipc	ra,0x0
      98:	6a8080e7          	jalr	1704(ra) # 73c <exit>
   if((uint64)stack % PGSIZE) //si la pagina no está alineada
      9c:	fe843703          	ld	a4,-24(s0)
      a0:	6785                	lui	a5,0x1
      a2:	17fd                	addi	a5,a5,-1
      a4:	8ff9                	and	a5,a5,a4
      a6:	cf91                	beqz	a5,c2 <main+0xc2>
     stack = stack + (4096 - (uint64)stack % PGSIZE); //alinea el stack a página
      a8:	fe843703          	ld	a4,-24(s0)
      ac:	6785                	lui	a5,0x1
      ae:	17fd                	addi	a5,a5,-1
      b0:	8ff9                	and	a5,a5,a4
      b2:	6705                	lui	a4,0x1
      b4:	40f707b3          	sub	a5,a4,a5
      b8:	fe843703          	ld	a4,-24(s0)
      bc:	97ba                	add	a5,a5,a4
      be:	fef43423          	sd	a5,-24(s0)

   int clone_pid = clone(worker, 0, stack); //crea un thread para operar una funcion worker con argumento 0 y dispone stack de 2 páginas
      c2:	fe843603          	ld	a2,-24(s0)
      c6:	4581                	li	a1,0
      c8:	00000517          	auipc	a0,0x0
      cc:	14050513          	addi	a0,a0,320 # 208 <worker>
      d0:	00000097          	auipc	ra,0x0
      d4:	70c080e7          	jalr	1804(ra) # 7dc <clone>
      d8:	87aa                	mv	a5,a0
      da:	fef42223          	sw	a5,-28(s0)
   assert(clone_pid > 0); //comprueba que no haya fallado el clone
      de:	fe442783          	lw	a5,-28(s0)
      e2:	2781                	sext.w	a5,a5
      e4:	06f04363          	bgtz	a5,14a <main+0x14a>
      e8:	02100613          	li	a2,33
      ec:	00001597          	auipc	a1,0x1
      f0:	fc458593          	addi	a1,a1,-60 # 10b0 <lock_init+0x12>
      f4:	00001517          	auipc	a0,0x1
      f8:	fcc50513          	addi	a0,a0,-52 # 10c0 <lock_init+0x22>
      fc:	00001097          	auipc	ra,0x1
     100:	b78080e7          	jalr	-1160(ra) # c74 <printf>
     104:	00001597          	auipc	a1,0x1
     108:	ffc58593          	addi	a1,a1,-4 # 1100 <lock_init+0x62>
     10c:	00001517          	auipc	a0,0x1
     110:	fcc50513          	addi	a0,a0,-52 # 10d8 <lock_init+0x3a>
     114:	00001097          	auipc	ra,0x1
     118:	b60080e7          	jalr	-1184(ra) # c74 <printf>
     11c:	00001517          	auipc	a0,0x1
     120:	fd450513          	addi	a0,a0,-44 # 10f0 <lock_init+0x52>
     124:	00001097          	auipc	ra,0x1
     128:	b50080e7          	jalr	-1200(ra) # c74 <printf>
     12c:	00001797          	auipc	a5,0x1
     130:	0a478793          	addi	a5,a5,164 # 11d0 <ppid>
     134:	439c                	lw	a5,0(a5)
     136:	853e                	mv	a0,a5
     138:	00000097          	auipc	ra,0x0
     13c:	634080e7          	jalr	1588(ra) # 76c <kill>
     140:	4501                	li	a0,0
     142:	00000097          	auipc	ra,0x0
     146:	5fa080e7          	jalr	1530(ra) # 73c <exit>

   
   void **join_stack = (void**) ((uint64)sbrk(0) - 8);
     14a:	4501                	li	a0,0
     14c:	00000097          	auipc	ra,0x0
     150:	678080e7          	jalr	1656(ra) # 7c4 <sbrk>
     154:	87aa                	mv	a5,a0
     156:	17e1                	addi	a5,a5,-8
     158:	fcf43c23          	sd	a5,-40(s0)
   while(global != 5); //comprueba si el thread ha modificado correctamente la variable global a 5 y no es otro valor distinto.
     15c:	0001                	nop
     15e:	00001797          	auipc	a5,0x1
     162:	06e78793          	addi	a5,a5,110 # 11cc <global>
     166:	439c                	lw	a5,0(a5)
     168:	2781                	sext.w	a5,a5
     16a:	873e                	mv	a4,a5
     16c:	4795                	li	a5,5
     16e:	fef718e3          	bne	a4,a5,15e <main+0x15e>
   assert(join((void**)((uint64)join_stack + 2)) == -1);
     172:	fd843783          	ld	a5,-40(s0)
     176:	0789                	addi	a5,a5,2
     178:	853e                	mv	a0,a5
     17a:	00000097          	auipc	ra,0x0
     17e:	66a080e7          	jalr	1642(ra) # 7e4 <join>
     182:	87aa                	mv	a5,a0
     184:	873e                	mv	a4,a5
     186:	57fd                	li	a5,-1
     188:	06f70363          	beq	a4,a5,1ee <main+0x1ee>
     18c:	02600613          	li	a2,38
     190:	00001597          	auipc	a1,0x1
     194:	f2058593          	addi	a1,a1,-224 # 10b0 <lock_init+0x12>
     198:	00001517          	auipc	a0,0x1
     19c:	f2850513          	addi	a0,a0,-216 # 10c0 <lock_init+0x22>
     1a0:	00001097          	auipc	ra,0x1
     1a4:	ad4080e7          	jalr	-1324(ra) # c74 <printf>
     1a8:	00001597          	auipc	a1,0x1
     1ac:	f6858593          	addi	a1,a1,-152 # 1110 <lock_init+0x72>
     1b0:	00001517          	auipc	a0,0x1
     1b4:	f2850513          	addi	a0,a0,-216 # 10d8 <lock_init+0x3a>
     1b8:	00001097          	auipc	ra,0x1
     1bc:	abc080e7          	jalr	-1348(ra) # c74 <printf>
     1c0:	00001517          	auipc	a0,0x1
     1c4:	f3050513          	addi	a0,a0,-208 # 10f0 <lock_init+0x52>
     1c8:	00001097          	auipc	ra,0x1
     1cc:	aac080e7          	jalr	-1364(ra) # c74 <printf>
     1d0:	00001797          	auipc	a5,0x1
     1d4:	00078793          	mv	a5,a5
     1d8:	439c                	lw	a5,0(a5)
     1da:	853e                	mv	a0,a5
     1dc:	00000097          	auipc	ra,0x0
     1e0:	590080e7          	jalr	1424(ra) # 76c <kill>
     1e4:	4501                	li	a0,0
     1e6:	00000097          	auipc	ra,0x0
     1ea:	556080e7          	jalr	1366(ra) # 73c <exit>
  
   printf("TEST PASSED\n");
     1ee:	00001517          	auipc	a0,0x1
     1f2:	f5250513          	addi	a0,a0,-174 # 1140 <lock_init+0xa2>
     1f6:	00001097          	auipc	ra,0x1
     1fa:	a7e080e7          	jalr	-1410(ra) # c74 <printf>
   exit(0);
     1fe:	4501                	li	a0,0
     200:	00000097          	auipc	ra,0x0
     204:	53c080e7          	jalr	1340(ra) # 73c <exit>

0000000000000208 <worker>:
}

void
worker(void *arg_ptr) {
     208:	1101                	addi	sp,sp,-32
     20a:	ec06                	sd	ra,24(sp)
     20c:	e822                	sd	s0,16(sp)
     20e:	1000                	addi	s0,sp,32
     210:	fea43423          	sd	a0,-24(s0)
   assert(global == 1);
     214:	00001797          	auipc	a5,0x1
     218:	fb878793          	addi	a5,a5,-72 # 11cc <global>
     21c:	439c                	lw	a5,0(a5)
     21e:	2781                	sext.w	a5,a5
     220:	873e                	mv	a4,a5
     222:	4785                	li	a5,1
     224:	06f70363          	beq	a4,a5,28a <worker+0x82>
     228:	02e00613          	li	a2,46
     22c:	00001597          	auipc	a1,0x1
     230:	e8458593          	addi	a1,a1,-380 # 10b0 <lock_init+0x12>
     234:	00001517          	auipc	a0,0x1
     238:	e8c50513          	addi	a0,a0,-372 # 10c0 <lock_init+0x22>
     23c:	00001097          	auipc	ra,0x1
     240:	a38080e7          	jalr	-1480(ra) # c74 <printf>
     244:	00001597          	auipc	a1,0x1
     248:	f0c58593          	addi	a1,a1,-244 # 1150 <lock_init+0xb2>
     24c:	00001517          	auipc	a0,0x1
     250:	e8c50513          	addi	a0,a0,-372 # 10d8 <lock_init+0x3a>
     254:	00001097          	auipc	ra,0x1
     258:	a20080e7          	jalr	-1504(ra) # c74 <printf>
     25c:	00001517          	auipc	a0,0x1
     260:	e9450513          	addi	a0,a0,-364 # 10f0 <lock_init+0x52>
     264:	00001097          	auipc	ra,0x1
     268:	a10080e7          	jalr	-1520(ra) # c74 <printf>
     26c:	00001797          	auipc	a5,0x1
     270:	f6478793          	addi	a5,a5,-156 # 11d0 <ppid>
     274:	439c                	lw	a5,0(a5)
     276:	853e                	mv	a0,a5
     278:	00000097          	auipc	ra,0x0
     27c:	4f4080e7          	jalr	1268(ra) # 76c <kill>
     280:	4501                	li	a0,0
     282:	00000097          	auipc	ra,0x0
     286:	4ba080e7          	jalr	1210(ra) # 73c <exit>
   sbrk(PGSIZE);
     28a:	6505                	lui	a0,0x1
     28c:	00000097          	auipc	ra,0x0
     290:	538080e7          	jalr	1336(ra) # 7c4 <sbrk>
   global = 5;
     294:	00001797          	auipc	a5,0x1
     298:	f3878793          	addi	a5,a5,-200 # 11cc <global>
     29c:	4715                	li	a4,5
     29e:	c398                	sw	a4,0(a5)
   exit(0);
     2a0:	4501                	li	a0,0
     2a2:	00000097          	auipc	ra,0x0
     2a6:	49a080e7          	jalr	1178(ra) # 73c <exit>

00000000000002aa <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     2aa:	7179                	addi	sp,sp,-48
     2ac:	f422                	sd	s0,40(sp)
     2ae:	1800                	addi	s0,sp,48
     2b0:	fca43c23          	sd	a0,-40(s0)
     2b4:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     2b8:	fd843783          	ld	a5,-40(s0)
     2bc:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     2c0:	0001                	nop
     2c2:	fd043703          	ld	a4,-48(s0)
     2c6:	00170793          	addi	a5,a4,1 # 1001 <thread_create+0x5f>
     2ca:	fcf43823          	sd	a5,-48(s0)
     2ce:	fd843783          	ld	a5,-40(s0)
     2d2:	00178693          	addi	a3,a5,1
     2d6:	fcd43c23          	sd	a3,-40(s0)
     2da:	00074703          	lbu	a4,0(a4)
     2de:	00e78023          	sb	a4,0(a5)
     2e2:	0007c783          	lbu	a5,0(a5)
     2e6:	fff1                	bnez	a5,2c2 <strcpy+0x18>
    ;
  return os;
     2e8:	fe843783          	ld	a5,-24(s0)
}
     2ec:	853e                	mv	a0,a5
     2ee:	7422                	ld	s0,40(sp)
     2f0:	6145                	addi	sp,sp,48
     2f2:	8082                	ret

00000000000002f4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     2f4:	1101                	addi	sp,sp,-32
     2f6:	ec22                	sd	s0,24(sp)
     2f8:	1000                	addi	s0,sp,32
     2fa:	fea43423          	sd	a0,-24(s0)
     2fe:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     302:	a819                	j	318 <strcmp+0x24>
    p++, q++;
     304:	fe843783          	ld	a5,-24(s0)
     308:	0785                	addi	a5,a5,1
     30a:	fef43423          	sd	a5,-24(s0)
     30e:	fe043783          	ld	a5,-32(s0)
     312:	0785                	addi	a5,a5,1
     314:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     318:	fe843783          	ld	a5,-24(s0)
     31c:	0007c783          	lbu	a5,0(a5)
     320:	cb99                	beqz	a5,336 <strcmp+0x42>
     322:	fe843783          	ld	a5,-24(s0)
     326:	0007c703          	lbu	a4,0(a5)
     32a:	fe043783          	ld	a5,-32(s0)
     32e:	0007c783          	lbu	a5,0(a5)
     332:	fcf709e3          	beq	a4,a5,304 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     336:	fe843783          	ld	a5,-24(s0)
     33a:	0007c783          	lbu	a5,0(a5)
     33e:	0007871b          	sext.w	a4,a5
     342:	fe043783          	ld	a5,-32(s0)
     346:	0007c783          	lbu	a5,0(a5)
     34a:	2781                	sext.w	a5,a5
     34c:	40f707bb          	subw	a5,a4,a5
     350:	2781                	sext.w	a5,a5
}
     352:	853e                	mv	a0,a5
     354:	6462                	ld	s0,24(sp)
     356:	6105                	addi	sp,sp,32
     358:	8082                	ret

000000000000035a <strlen>:

uint
strlen(const char *s)
{
     35a:	7179                	addi	sp,sp,-48
     35c:	f422                	sd	s0,40(sp)
     35e:	1800                	addi	s0,sp,48
     360:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     364:	fe042623          	sw	zero,-20(s0)
     368:	a031                	j	374 <strlen+0x1a>
     36a:	fec42783          	lw	a5,-20(s0)
     36e:	2785                	addiw	a5,a5,1
     370:	fef42623          	sw	a5,-20(s0)
     374:	fec42783          	lw	a5,-20(s0)
     378:	fd843703          	ld	a4,-40(s0)
     37c:	97ba                	add	a5,a5,a4
     37e:	0007c783          	lbu	a5,0(a5)
     382:	f7e5                	bnez	a5,36a <strlen+0x10>
    ;
  return n;
     384:	fec42783          	lw	a5,-20(s0)
}
     388:	853e                	mv	a0,a5
     38a:	7422                	ld	s0,40(sp)
     38c:	6145                	addi	sp,sp,48
     38e:	8082                	ret

0000000000000390 <memset>:

void*
memset(void *dst, int c, uint n)
{
     390:	7179                	addi	sp,sp,-48
     392:	f422                	sd	s0,40(sp)
     394:	1800                	addi	s0,sp,48
     396:	fca43c23          	sd	a0,-40(s0)
     39a:	87ae                	mv	a5,a1
     39c:	8732                	mv	a4,a2
     39e:	fcf42a23          	sw	a5,-44(s0)
     3a2:	87ba                	mv	a5,a4
     3a4:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     3a8:	fd843783          	ld	a5,-40(s0)
     3ac:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     3b0:	fe042623          	sw	zero,-20(s0)
     3b4:	a00d                	j	3d6 <memset+0x46>
    cdst[i] = c;
     3b6:	fec42783          	lw	a5,-20(s0)
     3ba:	fe043703          	ld	a4,-32(s0)
     3be:	97ba                	add	a5,a5,a4
     3c0:	fd442703          	lw	a4,-44(s0)
     3c4:	0ff77713          	zext.b	a4,a4
     3c8:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     3cc:	fec42783          	lw	a5,-20(s0)
     3d0:	2785                	addiw	a5,a5,1
     3d2:	fef42623          	sw	a5,-20(s0)
     3d6:	fec42703          	lw	a4,-20(s0)
     3da:	fd042783          	lw	a5,-48(s0)
     3de:	2781                	sext.w	a5,a5
     3e0:	fcf76be3          	bltu	a4,a5,3b6 <memset+0x26>
  }
  return dst;
     3e4:	fd843783          	ld	a5,-40(s0)
}
     3e8:	853e                	mv	a0,a5
     3ea:	7422                	ld	s0,40(sp)
     3ec:	6145                	addi	sp,sp,48
     3ee:	8082                	ret

00000000000003f0 <strchr>:

char*
strchr(const char *s, char c)
{
     3f0:	1101                	addi	sp,sp,-32
     3f2:	ec22                	sd	s0,24(sp)
     3f4:	1000                	addi	s0,sp,32
     3f6:	fea43423          	sd	a0,-24(s0)
     3fa:	87ae                	mv	a5,a1
     3fc:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     400:	a01d                	j	426 <strchr+0x36>
    if(*s == c)
     402:	fe843783          	ld	a5,-24(s0)
     406:	0007c703          	lbu	a4,0(a5)
     40a:	fe744783          	lbu	a5,-25(s0)
     40e:	0ff7f793          	zext.b	a5,a5
     412:	00e79563          	bne	a5,a4,41c <strchr+0x2c>
      return (char*)s;
     416:	fe843783          	ld	a5,-24(s0)
     41a:	a821                	j	432 <strchr+0x42>
  for(; *s; s++)
     41c:	fe843783          	ld	a5,-24(s0)
     420:	0785                	addi	a5,a5,1
     422:	fef43423          	sd	a5,-24(s0)
     426:	fe843783          	ld	a5,-24(s0)
     42a:	0007c783          	lbu	a5,0(a5)
     42e:	fbf1                	bnez	a5,402 <strchr+0x12>
  return 0;
     430:	4781                	li	a5,0
}
     432:	853e                	mv	a0,a5
     434:	6462                	ld	s0,24(sp)
     436:	6105                	addi	sp,sp,32
     438:	8082                	ret

000000000000043a <gets>:

char*
gets(char *buf, int max)
{
     43a:	7179                	addi	sp,sp,-48
     43c:	f406                	sd	ra,40(sp)
     43e:	f022                	sd	s0,32(sp)
     440:	1800                	addi	s0,sp,48
     442:	fca43c23          	sd	a0,-40(s0)
     446:	87ae                	mv	a5,a1
     448:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     44c:	fe042623          	sw	zero,-20(s0)
     450:	a8a1                	j	4a8 <gets+0x6e>
    cc = read(0, &c, 1);
     452:	fe740793          	addi	a5,s0,-25
     456:	4605                	li	a2,1
     458:	85be                	mv	a1,a5
     45a:	4501                	li	a0,0
     45c:	00000097          	auipc	ra,0x0
     460:	2f8080e7          	jalr	760(ra) # 754 <read>
     464:	87aa                	mv	a5,a0
     466:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     46a:	fe842783          	lw	a5,-24(s0)
     46e:	2781                	sext.w	a5,a5
     470:	04f05763          	blez	a5,4be <gets+0x84>
      break;
    buf[i++] = c;
     474:	fec42783          	lw	a5,-20(s0)
     478:	0017871b          	addiw	a4,a5,1
     47c:	fee42623          	sw	a4,-20(s0)
     480:	873e                	mv	a4,a5
     482:	fd843783          	ld	a5,-40(s0)
     486:	97ba                	add	a5,a5,a4
     488:	fe744703          	lbu	a4,-25(s0)
     48c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     490:	fe744783          	lbu	a5,-25(s0)
     494:	873e                	mv	a4,a5
     496:	47a9                	li	a5,10
     498:	02f70463          	beq	a4,a5,4c0 <gets+0x86>
     49c:	fe744783          	lbu	a5,-25(s0)
     4a0:	873e                	mv	a4,a5
     4a2:	47b5                	li	a5,13
     4a4:	00f70e63          	beq	a4,a5,4c0 <gets+0x86>
  for(i=0; i+1 < max; ){
     4a8:	fec42783          	lw	a5,-20(s0)
     4ac:	2785                	addiw	a5,a5,1
     4ae:	0007871b          	sext.w	a4,a5
     4b2:	fd442783          	lw	a5,-44(s0)
     4b6:	2781                	sext.w	a5,a5
     4b8:	f8f74de3          	blt	a4,a5,452 <gets+0x18>
     4bc:	a011                	j	4c0 <gets+0x86>
      break;
     4be:	0001                	nop
      break;
  }
  buf[i] = '\0';
     4c0:	fec42783          	lw	a5,-20(s0)
     4c4:	fd843703          	ld	a4,-40(s0)
     4c8:	97ba                	add	a5,a5,a4
     4ca:	00078023          	sb	zero,0(a5)
  return buf;
     4ce:	fd843783          	ld	a5,-40(s0)
}
     4d2:	853e                	mv	a0,a5
     4d4:	70a2                	ld	ra,40(sp)
     4d6:	7402                	ld	s0,32(sp)
     4d8:	6145                	addi	sp,sp,48
     4da:	8082                	ret

00000000000004dc <stat>:

int
stat(const char *n, struct stat *st)
{
     4dc:	7179                	addi	sp,sp,-48
     4de:	f406                	sd	ra,40(sp)
     4e0:	f022                	sd	s0,32(sp)
     4e2:	1800                	addi	s0,sp,48
     4e4:	fca43c23          	sd	a0,-40(s0)
     4e8:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     4ec:	4581                	li	a1,0
     4ee:	fd843503          	ld	a0,-40(s0)
     4f2:	00000097          	auipc	ra,0x0
     4f6:	28a080e7          	jalr	650(ra) # 77c <open>
     4fa:	87aa                	mv	a5,a0
     4fc:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     500:	fec42783          	lw	a5,-20(s0)
     504:	2781                	sext.w	a5,a5
     506:	0007d463          	bgez	a5,50e <stat+0x32>
    return -1;
     50a:	57fd                	li	a5,-1
     50c:	a035                	j	538 <stat+0x5c>
  r = fstat(fd, st);
     50e:	fec42783          	lw	a5,-20(s0)
     512:	fd043583          	ld	a1,-48(s0)
     516:	853e                	mv	a0,a5
     518:	00000097          	auipc	ra,0x0
     51c:	27c080e7          	jalr	636(ra) # 794 <fstat>
     520:	87aa                	mv	a5,a0
     522:	fef42423          	sw	a5,-24(s0)
  close(fd);
     526:	fec42783          	lw	a5,-20(s0)
     52a:	853e                	mv	a0,a5
     52c:	00000097          	auipc	ra,0x0
     530:	238080e7          	jalr	568(ra) # 764 <close>
  return r;
     534:	fe842783          	lw	a5,-24(s0)
}
     538:	853e                	mv	a0,a5
     53a:	70a2                	ld	ra,40(sp)
     53c:	7402                	ld	s0,32(sp)
     53e:	6145                	addi	sp,sp,48
     540:	8082                	ret

0000000000000542 <atoi>:

int
atoi(const char *s)
{
     542:	7179                	addi	sp,sp,-48
     544:	f422                	sd	s0,40(sp)
     546:	1800                	addi	s0,sp,48
     548:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     54c:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     550:	a81d                	j	586 <atoi+0x44>
    n = n*10 + *s++ - '0';
     552:	fec42783          	lw	a5,-20(s0)
     556:	873e                	mv	a4,a5
     558:	87ba                	mv	a5,a4
     55a:	0027979b          	slliw	a5,a5,0x2
     55e:	9fb9                	addw	a5,a5,a4
     560:	0017979b          	slliw	a5,a5,0x1
     564:	0007871b          	sext.w	a4,a5
     568:	fd843783          	ld	a5,-40(s0)
     56c:	00178693          	addi	a3,a5,1
     570:	fcd43c23          	sd	a3,-40(s0)
     574:	0007c783          	lbu	a5,0(a5)
     578:	2781                	sext.w	a5,a5
     57a:	9fb9                	addw	a5,a5,a4
     57c:	2781                	sext.w	a5,a5
     57e:	fd07879b          	addiw	a5,a5,-48
     582:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     586:	fd843783          	ld	a5,-40(s0)
     58a:	0007c783          	lbu	a5,0(a5)
     58e:	873e                	mv	a4,a5
     590:	02f00793          	li	a5,47
     594:	00e7fb63          	bgeu	a5,a4,5aa <atoi+0x68>
     598:	fd843783          	ld	a5,-40(s0)
     59c:	0007c783          	lbu	a5,0(a5)
     5a0:	873e                	mv	a4,a5
     5a2:	03900793          	li	a5,57
     5a6:	fae7f6e3          	bgeu	a5,a4,552 <atoi+0x10>
  return n;
     5aa:	fec42783          	lw	a5,-20(s0)
}
     5ae:	853e                	mv	a0,a5
     5b0:	7422                	ld	s0,40(sp)
     5b2:	6145                	addi	sp,sp,48
     5b4:	8082                	ret

00000000000005b6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     5b6:	7139                	addi	sp,sp,-64
     5b8:	fc22                	sd	s0,56(sp)
     5ba:	0080                	addi	s0,sp,64
     5bc:	fca43c23          	sd	a0,-40(s0)
     5c0:	fcb43823          	sd	a1,-48(s0)
     5c4:	87b2                	mv	a5,a2
     5c6:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     5ca:	fd843783          	ld	a5,-40(s0)
     5ce:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     5d2:	fd043783          	ld	a5,-48(s0)
     5d6:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     5da:	fe043703          	ld	a4,-32(s0)
     5de:	fe843783          	ld	a5,-24(s0)
     5e2:	02e7fc63          	bgeu	a5,a4,61a <memmove+0x64>
    while(n-- > 0)
     5e6:	a00d                	j	608 <memmove+0x52>
      *dst++ = *src++;
     5e8:	fe043703          	ld	a4,-32(s0)
     5ec:	00170793          	addi	a5,a4,1
     5f0:	fef43023          	sd	a5,-32(s0)
     5f4:	fe843783          	ld	a5,-24(s0)
     5f8:	00178693          	addi	a3,a5,1
     5fc:	fed43423          	sd	a3,-24(s0)
     600:	00074703          	lbu	a4,0(a4)
     604:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     608:	fcc42783          	lw	a5,-52(s0)
     60c:	fff7871b          	addiw	a4,a5,-1
     610:	fce42623          	sw	a4,-52(s0)
     614:	fcf04ae3          	bgtz	a5,5e8 <memmove+0x32>
     618:	a891                	j	66c <memmove+0xb6>
  } else {
    dst += n;
     61a:	fcc42783          	lw	a5,-52(s0)
     61e:	fe843703          	ld	a4,-24(s0)
     622:	97ba                	add	a5,a5,a4
     624:	fef43423          	sd	a5,-24(s0)
    src += n;
     628:	fcc42783          	lw	a5,-52(s0)
     62c:	fe043703          	ld	a4,-32(s0)
     630:	97ba                	add	a5,a5,a4
     632:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     636:	a01d                	j	65c <memmove+0xa6>
      *--dst = *--src;
     638:	fe043783          	ld	a5,-32(s0)
     63c:	17fd                	addi	a5,a5,-1
     63e:	fef43023          	sd	a5,-32(s0)
     642:	fe843783          	ld	a5,-24(s0)
     646:	17fd                	addi	a5,a5,-1
     648:	fef43423          	sd	a5,-24(s0)
     64c:	fe043783          	ld	a5,-32(s0)
     650:	0007c703          	lbu	a4,0(a5)
     654:	fe843783          	ld	a5,-24(s0)
     658:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     65c:	fcc42783          	lw	a5,-52(s0)
     660:	fff7871b          	addiw	a4,a5,-1
     664:	fce42623          	sw	a4,-52(s0)
     668:	fcf048e3          	bgtz	a5,638 <memmove+0x82>
  }
  return vdst;
     66c:	fd843783          	ld	a5,-40(s0)
}
     670:	853e                	mv	a0,a5
     672:	7462                	ld	s0,56(sp)
     674:	6121                	addi	sp,sp,64
     676:	8082                	ret

0000000000000678 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     678:	7139                	addi	sp,sp,-64
     67a:	fc22                	sd	s0,56(sp)
     67c:	0080                	addi	s0,sp,64
     67e:	fca43c23          	sd	a0,-40(s0)
     682:	fcb43823          	sd	a1,-48(s0)
     686:	87b2                	mv	a5,a2
     688:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     68c:	fd843783          	ld	a5,-40(s0)
     690:	fef43423          	sd	a5,-24(s0)
     694:	fd043783          	ld	a5,-48(s0)
     698:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     69c:	a0a1                	j	6e4 <memcmp+0x6c>
    if (*p1 != *p2) {
     69e:	fe843783          	ld	a5,-24(s0)
     6a2:	0007c703          	lbu	a4,0(a5)
     6a6:	fe043783          	ld	a5,-32(s0)
     6aa:	0007c783          	lbu	a5,0(a5)
     6ae:	02f70163          	beq	a4,a5,6d0 <memcmp+0x58>
      return *p1 - *p2;
     6b2:	fe843783          	ld	a5,-24(s0)
     6b6:	0007c783          	lbu	a5,0(a5)
     6ba:	0007871b          	sext.w	a4,a5
     6be:	fe043783          	ld	a5,-32(s0)
     6c2:	0007c783          	lbu	a5,0(a5)
     6c6:	2781                	sext.w	a5,a5
     6c8:	40f707bb          	subw	a5,a4,a5
     6cc:	2781                	sext.w	a5,a5
     6ce:	a01d                	j	6f4 <memcmp+0x7c>
    }
    p1++;
     6d0:	fe843783          	ld	a5,-24(s0)
     6d4:	0785                	addi	a5,a5,1
     6d6:	fef43423          	sd	a5,-24(s0)
    p2++;
     6da:	fe043783          	ld	a5,-32(s0)
     6de:	0785                	addi	a5,a5,1
     6e0:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     6e4:	fcc42783          	lw	a5,-52(s0)
     6e8:	fff7871b          	addiw	a4,a5,-1
     6ec:	fce42623          	sw	a4,-52(s0)
     6f0:	f7dd                	bnez	a5,69e <memcmp+0x26>
  }
  return 0;
     6f2:	4781                	li	a5,0
}
     6f4:	853e                	mv	a0,a5
     6f6:	7462                	ld	s0,56(sp)
     6f8:	6121                	addi	sp,sp,64
     6fa:	8082                	ret

00000000000006fc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     6fc:	7179                	addi	sp,sp,-48
     6fe:	f406                	sd	ra,40(sp)
     700:	f022                	sd	s0,32(sp)
     702:	1800                	addi	s0,sp,48
     704:	fea43423          	sd	a0,-24(s0)
     708:	feb43023          	sd	a1,-32(s0)
     70c:	87b2                	mv	a5,a2
     70e:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     712:	fdc42783          	lw	a5,-36(s0)
     716:	863e                	mv	a2,a5
     718:	fe043583          	ld	a1,-32(s0)
     71c:	fe843503          	ld	a0,-24(s0)
     720:	00000097          	auipc	ra,0x0
     724:	e96080e7          	jalr	-362(ra) # 5b6 <memmove>
     728:	87aa                	mv	a5,a0
}
     72a:	853e                	mv	a0,a5
     72c:	70a2                	ld	ra,40(sp)
     72e:	7402                	ld	s0,32(sp)
     730:	6145                	addi	sp,sp,48
     732:	8082                	ret

0000000000000734 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     734:	4885                	li	a7,1
 ecall
     736:	00000073          	ecall
 ret
     73a:	8082                	ret

000000000000073c <exit>:
.global exit
exit:
 li a7, SYS_exit
     73c:	4889                	li	a7,2
 ecall
     73e:	00000073          	ecall
 ret
     742:	8082                	ret

0000000000000744 <wait>:
.global wait
wait:
 li a7, SYS_wait
     744:	488d                	li	a7,3
 ecall
     746:	00000073          	ecall
 ret
     74a:	8082                	ret

000000000000074c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     74c:	4891                	li	a7,4
 ecall
     74e:	00000073          	ecall
 ret
     752:	8082                	ret

0000000000000754 <read>:
.global read
read:
 li a7, SYS_read
     754:	4895                	li	a7,5
 ecall
     756:	00000073          	ecall
 ret
     75a:	8082                	ret

000000000000075c <write>:
.global write
write:
 li a7, SYS_write
     75c:	48c1                	li	a7,16
 ecall
     75e:	00000073          	ecall
 ret
     762:	8082                	ret

0000000000000764 <close>:
.global close
close:
 li a7, SYS_close
     764:	48d5                	li	a7,21
 ecall
     766:	00000073          	ecall
 ret
     76a:	8082                	ret

000000000000076c <kill>:
.global kill
kill:
 li a7, SYS_kill
     76c:	4899                	li	a7,6
 ecall
     76e:	00000073          	ecall
 ret
     772:	8082                	ret

0000000000000774 <exec>:
.global exec
exec:
 li a7, SYS_exec
     774:	489d                	li	a7,7
 ecall
     776:	00000073          	ecall
 ret
     77a:	8082                	ret

000000000000077c <open>:
.global open
open:
 li a7, SYS_open
     77c:	48bd                	li	a7,15
 ecall
     77e:	00000073          	ecall
 ret
     782:	8082                	ret

0000000000000784 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     784:	48c5                	li	a7,17
 ecall
     786:	00000073          	ecall
 ret
     78a:	8082                	ret

000000000000078c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     78c:	48c9                	li	a7,18
 ecall
     78e:	00000073          	ecall
 ret
     792:	8082                	ret

0000000000000794 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     794:	48a1                	li	a7,8
 ecall
     796:	00000073          	ecall
 ret
     79a:	8082                	ret

000000000000079c <link>:
.global link
link:
 li a7, SYS_link
     79c:	48cd                	li	a7,19
 ecall
     79e:	00000073          	ecall
 ret
     7a2:	8082                	ret

00000000000007a4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     7a4:	48d1                	li	a7,20
 ecall
     7a6:	00000073          	ecall
 ret
     7aa:	8082                	ret

00000000000007ac <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     7ac:	48a5                	li	a7,9
 ecall
     7ae:	00000073          	ecall
 ret
     7b2:	8082                	ret

00000000000007b4 <dup>:
.global dup
dup:
 li a7, SYS_dup
     7b4:	48a9                	li	a7,10
 ecall
     7b6:	00000073          	ecall
 ret
     7ba:	8082                	ret

00000000000007bc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     7bc:	48ad                	li	a7,11
 ecall
     7be:	00000073          	ecall
 ret
     7c2:	8082                	ret

00000000000007c4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     7c4:	48b1                	li	a7,12
 ecall
     7c6:	00000073          	ecall
 ret
     7ca:	8082                	ret

00000000000007cc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     7cc:	48b5                	li	a7,13
 ecall
     7ce:	00000073          	ecall
 ret
     7d2:	8082                	ret

00000000000007d4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     7d4:	48b9                	li	a7,14
 ecall
     7d6:	00000073          	ecall
 ret
     7da:	8082                	ret

00000000000007dc <clone>:
.global clone
clone:
 li a7, SYS_clone
     7dc:	48d9                	li	a7,22
 ecall
     7de:	00000073          	ecall
 ret
     7e2:	8082                	ret

00000000000007e4 <join>:
.global join
join:
 li a7, SYS_join
     7e4:	48dd                	li	a7,23
 ecall
     7e6:	00000073          	ecall
 ret
     7ea:	8082                	ret

00000000000007ec <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     7ec:	1101                	addi	sp,sp,-32
     7ee:	ec06                	sd	ra,24(sp)
     7f0:	e822                	sd	s0,16(sp)
     7f2:	1000                	addi	s0,sp,32
     7f4:	87aa                	mv	a5,a0
     7f6:	872e                	mv	a4,a1
     7f8:	fef42623          	sw	a5,-20(s0)
     7fc:	87ba                	mv	a5,a4
     7fe:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     802:	feb40713          	addi	a4,s0,-21
     806:	fec42783          	lw	a5,-20(s0)
     80a:	4605                	li	a2,1
     80c:	85ba                	mv	a1,a4
     80e:	853e                	mv	a0,a5
     810:	00000097          	auipc	ra,0x0
     814:	f4c080e7          	jalr	-180(ra) # 75c <write>
}
     818:	0001                	nop
     81a:	60e2                	ld	ra,24(sp)
     81c:	6442                	ld	s0,16(sp)
     81e:	6105                	addi	sp,sp,32
     820:	8082                	ret

0000000000000822 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     822:	7139                	addi	sp,sp,-64
     824:	fc06                	sd	ra,56(sp)
     826:	f822                	sd	s0,48(sp)
     828:	0080                	addi	s0,sp,64
     82a:	87aa                	mv	a5,a0
     82c:	8736                	mv	a4,a3
     82e:	fcf42623          	sw	a5,-52(s0)
     832:	87ae                	mv	a5,a1
     834:	fcf42423          	sw	a5,-56(s0)
     838:	87b2                	mv	a5,a2
     83a:	fcf42223          	sw	a5,-60(s0)
     83e:	87ba                	mv	a5,a4
     840:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     844:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     848:	fc042783          	lw	a5,-64(s0)
     84c:	2781                	sext.w	a5,a5
     84e:	c38d                	beqz	a5,870 <printint+0x4e>
     850:	fc842783          	lw	a5,-56(s0)
     854:	2781                	sext.w	a5,a5
     856:	0007dd63          	bgez	a5,870 <printint+0x4e>
    neg = 1;
     85a:	4785                	li	a5,1
     85c:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     860:	fc842783          	lw	a5,-56(s0)
     864:	40f007bb          	negw	a5,a5
     868:	2781                	sext.w	a5,a5
     86a:	fef42223          	sw	a5,-28(s0)
     86e:	a029                	j	878 <printint+0x56>
  } else {
    x = xx;
     870:	fc842783          	lw	a5,-56(s0)
     874:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     878:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     87c:	fc442783          	lw	a5,-60(s0)
     880:	fe442703          	lw	a4,-28(s0)
     884:	02f777bb          	remuw	a5,a4,a5
     888:	0007861b          	sext.w	a2,a5
     88c:	fec42783          	lw	a5,-20(s0)
     890:	0017871b          	addiw	a4,a5,1
     894:	fee42623          	sw	a4,-20(s0)
     898:	00001697          	auipc	a3,0x1
     89c:	92068693          	addi	a3,a3,-1760 # 11b8 <digits>
     8a0:	02061713          	slli	a4,a2,0x20
     8a4:	9301                	srli	a4,a4,0x20
     8a6:	9736                	add	a4,a4,a3
     8a8:	00074703          	lbu	a4,0(a4)
     8ac:	17c1                	addi	a5,a5,-16
     8ae:	97a2                	add	a5,a5,s0
     8b0:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     8b4:	fc442783          	lw	a5,-60(s0)
     8b8:	fe442703          	lw	a4,-28(s0)
     8bc:	02f757bb          	divuw	a5,a4,a5
     8c0:	fef42223          	sw	a5,-28(s0)
     8c4:	fe442783          	lw	a5,-28(s0)
     8c8:	2781                	sext.w	a5,a5
     8ca:	fbcd                	bnez	a5,87c <printint+0x5a>
  if(neg)
     8cc:	fe842783          	lw	a5,-24(s0)
     8d0:	2781                	sext.w	a5,a5
     8d2:	cf85                	beqz	a5,90a <printint+0xe8>
    buf[i++] = '-';
     8d4:	fec42783          	lw	a5,-20(s0)
     8d8:	0017871b          	addiw	a4,a5,1
     8dc:	fee42623          	sw	a4,-20(s0)
     8e0:	17c1                	addi	a5,a5,-16
     8e2:	97a2                	add	a5,a5,s0
     8e4:	02d00713          	li	a4,45
     8e8:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     8ec:	a839                	j	90a <printint+0xe8>
    putc(fd, buf[i]);
     8ee:	fec42783          	lw	a5,-20(s0)
     8f2:	17c1                	addi	a5,a5,-16
     8f4:	97a2                	add	a5,a5,s0
     8f6:	fe07c703          	lbu	a4,-32(a5)
     8fa:	fcc42783          	lw	a5,-52(s0)
     8fe:	85ba                	mv	a1,a4
     900:	853e                	mv	a0,a5
     902:	00000097          	auipc	ra,0x0
     906:	eea080e7          	jalr	-278(ra) # 7ec <putc>
  while(--i >= 0)
     90a:	fec42783          	lw	a5,-20(s0)
     90e:	37fd                	addiw	a5,a5,-1
     910:	fef42623          	sw	a5,-20(s0)
     914:	fec42783          	lw	a5,-20(s0)
     918:	2781                	sext.w	a5,a5
     91a:	fc07dae3          	bgez	a5,8ee <printint+0xcc>
}
     91e:	0001                	nop
     920:	0001                	nop
     922:	70e2                	ld	ra,56(sp)
     924:	7442                	ld	s0,48(sp)
     926:	6121                	addi	sp,sp,64
     928:	8082                	ret

000000000000092a <printptr>:

static void
printptr(int fd, uint64 x) {
     92a:	7179                	addi	sp,sp,-48
     92c:	f406                	sd	ra,40(sp)
     92e:	f022                	sd	s0,32(sp)
     930:	1800                	addi	s0,sp,48
     932:	87aa                	mv	a5,a0
     934:	fcb43823          	sd	a1,-48(s0)
     938:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     93c:	fdc42783          	lw	a5,-36(s0)
     940:	03000593          	li	a1,48
     944:	853e                	mv	a0,a5
     946:	00000097          	auipc	ra,0x0
     94a:	ea6080e7          	jalr	-346(ra) # 7ec <putc>
  putc(fd, 'x');
     94e:	fdc42783          	lw	a5,-36(s0)
     952:	07800593          	li	a1,120
     956:	853e                	mv	a0,a5
     958:	00000097          	auipc	ra,0x0
     95c:	e94080e7          	jalr	-364(ra) # 7ec <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     960:	fe042623          	sw	zero,-20(s0)
     964:	a82d                	j	99e <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     966:	fd043783          	ld	a5,-48(s0)
     96a:	93f1                	srli	a5,a5,0x3c
     96c:	00001717          	auipc	a4,0x1
     970:	84c70713          	addi	a4,a4,-1972 # 11b8 <digits>
     974:	97ba                	add	a5,a5,a4
     976:	0007c703          	lbu	a4,0(a5)
     97a:	fdc42783          	lw	a5,-36(s0)
     97e:	85ba                	mv	a1,a4
     980:	853e                	mv	a0,a5
     982:	00000097          	auipc	ra,0x0
     986:	e6a080e7          	jalr	-406(ra) # 7ec <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     98a:	fec42783          	lw	a5,-20(s0)
     98e:	2785                	addiw	a5,a5,1
     990:	fef42623          	sw	a5,-20(s0)
     994:	fd043783          	ld	a5,-48(s0)
     998:	0792                	slli	a5,a5,0x4
     99a:	fcf43823          	sd	a5,-48(s0)
     99e:	fec42783          	lw	a5,-20(s0)
     9a2:	873e                	mv	a4,a5
     9a4:	47bd                	li	a5,15
     9a6:	fce7f0e3          	bgeu	a5,a4,966 <printptr+0x3c>
}
     9aa:	0001                	nop
     9ac:	0001                	nop
     9ae:	70a2                	ld	ra,40(sp)
     9b0:	7402                	ld	s0,32(sp)
     9b2:	6145                	addi	sp,sp,48
     9b4:	8082                	ret

00000000000009b6 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     9b6:	715d                	addi	sp,sp,-80
     9b8:	e486                	sd	ra,72(sp)
     9ba:	e0a2                	sd	s0,64(sp)
     9bc:	0880                	addi	s0,sp,80
     9be:	87aa                	mv	a5,a0
     9c0:	fcb43023          	sd	a1,-64(s0)
     9c4:	fac43c23          	sd	a2,-72(s0)
     9c8:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     9cc:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     9d0:	fe042223          	sw	zero,-28(s0)
     9d4:	a42d                	j	bfe <vprintf+0x248>
    c = fmt[i] & 0xff;
     9d6:	fe442783          	lw	a5,-28(s0)
     9da:	fc043703          	ld	a4,-64(s0)
     9de:	97ba                	add	a5,a5,a4
     9e0:	0007c783          	lbu	a5,0(a5)
     9e4:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     9e8:	fe042783          	lw	a5,-32(s0)
     9ec:	2781                	sext.w	a5,a5
     9ee:	eb9d                	bnez	a5,a24 <vprintf+0x6e>
      if(c == '%'){
     9f0:	fdc42783          	lw	a5,-36(s0)
     9f4:	0007871b          	sext.w	a4,a5
     9f8:	02500793          	li	a5,37
     9fc:	00f71763          	bne	a4,a5,a0a <vprintf+0x54>
        state = '%';
     a00:	02500793          	li	a5,37
     a04:	fef42023          	sw	a5,-32(s0)
     a08:	a2f5                	j	bf4 <vprintf+0x23e>
      } else {
        putc(fd, c);
     a0a:	fdc42783          	lw	a5,-36(s0)
     a0e:	0ff7f713          	zext.b	a4,a5
     a12:	fcc42783          	lw	a5,-52(s0)
     a16:	85ba                	mv	a1,a4
     a18:	853e                	mv	a0,a5
     a1a:	00000097          	auipc	ra,0x0
     a1e:	dd2080e7          	jalr	-558(ra) # 7ec <putc>
     a22:	aac9                	j	bf4 <vprintf+0x23e>
      }
    } else if(state == '%'){
     a24:	fe042783          	lw	a5,-32(s0)
     a28:	0007871b          	sext.w	a4,a5
     a2c:	02500793          	li	a5,37
     a30:	1cf71263          	bne	a4,a5,bf4 <vprintf+0x23e>
      if(c == 'd'){
     a34:	fdc42783          	lw	a5,-36(s0)
     a38:	0007871b          	sext.w	a4,a5
     a3c:	06400793          	li	a5,100
     a40:	02f71463          	bne	a4,a5,a68 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     a44:	fb843783          	ld	a5,-72(s0)
     a48:	00878713          	addi	a4,a5,8
     a4c:	fae43c23          	sd	a4,-72(s0)
     a50:	4398                	lw	a4,0(a5)
     a52:	fcc42783          	lw	a5,-52(s0)
     a56:	4685                	li	a3,1
     a58:	4629                	li	a2,10
     a5a:	85ba                	mv	a1,a4
     a5c:	853e                	mv	a0,a5
     a5e:	00000097          	auipc	ra,0x0
     a62:	dc4080e7          	jalr	-572(ra) # 822 <printint>
     a66:	a269                	j	bf0 <vprintf+0x23a>
      } else if(c == 'l') {
     a68:	fdc42783          	lw	a5,-36(s0)
     a6c:	0007871b          	sext.w	a4,a5
     a70:	06c00793          	li	a5,108
     a74:	02f71663          	bne	a4,a5,aa0 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     a78:	fb843783          	ld	a5,-72(s0)
     a7c:	00878713          	addi	a4,a5,8
     a80:	fae43c23          	sd	a4,-72(s0)
     a84:	639c                	ld	a5,0(a5)
     a86:	0007871b          	sext.w	a4,a5
     a8a:	fcc42783          	lw	a5,-52(s0)
     a8e:	4681                	li	a3,0
     a90:	4629                	li	a2,10
     a92:	85ba                	mv	a1,a4
     a94:	853e                	mv	a0,a5
     a96:	00000097          	auipc	ra,0x0
     a9a:	d8c080e7          	jalr	-628(ra) # 822 <printint>
     a9e:	aa89                	j	bf0 <vprintf+0x23a>
      } else if(c == 'x') {
     aa0:	fdc42783          	lw	a5,-36(s0)
     aa4:	0007871b          	sext.w	a4,a5
     aa8:	07800793          	li	a5,120
     aac:	02f71463          	bne	a4,a5,ad4 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     ab0:	fb843783          	ld	a5,-72(s0)
     ab4:	00878713          	addi	a4,a5,8
     ab8:	fae43c23          	sd	a4,-72(s0)
     abc:	4398                	lw	a4,0(a5)
     abe:	fcc42783          	lw	a5,-52(s0)
     ac2:	4681                	li	a3,0
     ac4:	4641                	li	a2,16
     ac6:	85ba                	mv	a1,a4
     ac8:	853e                	mv	a0,a5
     aca:	00000097          	auipc	ra,0x0
     ace:	d58080e7          	jalr	-680(ra) # 822 <printint>
     ad2:	aa39                	j	bf0 <vprintf+0x23a>
      } else if(c == 'p') {
     ad4:	fdc42783          	lw	a5,-36(s0)
     ad8:	0007871b          	sext.w	a4,a5
     adc:	07000793          	li	a5,112
     ae0:	02f71263          	bne	a4,a5,b04 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     ae4:	fb843783          	ld	a5,-72(s0)
     ae8:	00878713          	addi	a4,a5,8
     aec:	fae43c23          	sd	a4,-72(s0)
     af0:	6398                	ld	a4,0(a5)
     af2:	fcc42783          	lw	a5,-52(s0)
     af6:	85ba                	mv	a1,a4
     af8:	853e                	mv	a0,a5
     afa:	00000097          	auipc	ra,0x0
     afe:	e30080e7          	jalr	-464(ra) # 92a <printptr>
     b02:	a0fd                	j	bf0 <vprintf+0x23a>
      } else if(c == 's'){
     b04:	fdc42783          	lw	a5,-36(s0)
     b08:	0007871b          	sext.w	a4,a5
     b0c:	07300793          	li	a5,115
     b10:	04f71c63          	bne	a4,a5,b68 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     b14:	fb843783          	ld	a5,-72(s0)
     b18:	00878713          	addi	a4,a5,8
     b1c:	fae43c23          	sd	a4,-72(s0)
     b20:	639c                	ld	a5,0(a5)
     b22:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     b26:	fe843783          	ld	a5,-24(s0)
     b2a:	eb8d                	bnez	a5,b5c <vprintf+0x1a6>
          s = "(null)";
     b2c:	00000797          	auipc	a5,0x0
     b30:	63478793          	addi	a5,a5,1588 # 1160 <lock_init+0xc2>
     b34:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     b38:	a015                	j	b5c <vprintf+0x1a6>
          putc(fd, *s);
     b3a:	fe843783          	ld	a5,-24(s0)
     b3e:	0007c703          	lbu	a4,0(a5)
     b42:	fcc42783          	lw	a5,-52(s0)
     b46:	85ba                	mv	a1,a4
     b48:	853e                	mv	a0,a5
     b4a:	00000097          	auipc	ra,0x0
     b4e:	ca2080e7          	jalr	-862(ra) # 7ec <putc>
          s++;
     b52:	fe843783          	ld	a5,-24(s0)
     b56:	0785                	addi	a5,a5,1
     b58:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     b5c:	fe843783          	ld	a5,-24(s0)
     b60:	0007c783          	lbu	a5,0(a5)
     b64:	fbf9                	bnez	a5,b3a <vprintf+0x184>
     b66:	a069                	j	bf0 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     b68:	fdc42783          	lw	a5,-36(s0)
     b6c:	0007871b          	sext.w	a4,a5
     b70:	06300793          	li	a5,99
     b74:	02f71463          	bne	a4,a5,b9c <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     b78:	fb843783          	ld	a5,-72(s0)
     b7c:	00878713          	addi	a4,a5,8
     b80:	fae43c23          	sd	a4,-72(s0)
     b84:	439c                	lw	a5,0(a5)
     b86:	0ff7f713          	zext.b	a4,a5
     b8a:	fcc42783          	lw	a5,-52(s0)
     b8e:	85ba                	mv	a1,a4
     b90:	853e                	mv	a0,a5
     b92:	00000097          	auipc	ra,0x0
     b96:	c5a080e7          	jalr	-934(ra) # 7ec <putc>
     b9a:	a899                	j	bf0 <vprintf+0x23a>
      } else if(c == '%'){
     b9c:	fdc42783          	lw	a5,-36(s0)
     ba0:	0007871b          	sext.w	a4,a5
     ba4:	02500793          	li	a5,37
     ba8:	00f71f63          	bne	a4,a5,bc6 <vprintf+0x210>
        putc(fd, c);
     bac:	fdc42783          	lw	a5,-36(s0)
     bb0:	0ff7f713          	zext.b	a4,a5
     bb4:	fcc42783          	lw	a5,-52(s0)
     bb8:	85ba                	mv	a1,a4
     bba:	853e                	mv	a0,a5
     bbc:	00000097          	auipc	ra,0x0
     bc0:	c30080e7          	jalr	-976(ra) # 7ec <putc>
     bc4:	a035                	j	bf0 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     bc6:	fcc42783          	lw	a5,-52(s0)
     bca:	02500593          	li	a1,37
     bce:	853e                	mv	a0,a5
     bd0:	00000097          	auipc	ra,0x0
     bd4:	c1c080e7          	jalr	-996(ra) # 7ec <putc>
        putc(fd, c);
     bd8:	fdc42783          	lw	a5,-36(s0)
     bdc:	0ff7f713          	zext.b	a4,a5
     be0:	fcc42783          	lw	a5,-52(s0)
     be4:	85ba                	mv	a1,a4
     be6:	853e                	mv	a0,a5
     be8:	00000097          	auipc	ra,0x0
     bec:	c04080e7          	jalr	-1020(ra) # 7ec <putc>
      }
      state = 0;
     bf0:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     bf4:	fe442783          	lw	a5,-28(s0)
     bf8:	2785                	addiw	a5,a5,1
     bfa:	fef42223          	sw	a5,-28(s0)
     bfe:	fe442783          	lw	a5,-28(s0)
     c02:	fc043703          	ld	a4,-64(s0)
     c06:	97ba                	add	a5,a5,a4
     c08:	0007c783          	lbu	a5,0(a5)
     c0c:	dc0795e3          	bnez	a5,9d6 <vprintf+0x20>
    }
  }
}
     c10:	0001                	nop
     c12:	0001                	nop
     c14:	60a6                	ld	ra,72(sp)
     c16:	6406                	ld	s0,64(sp)
     c18:	6161                	addi	sp,sp,80
     c1a:	8082                	ret

0000000000000c1c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     c1c:	7159                	addi	sp,sp,-112
     c1e:	fc06                	sd	ra,56(sp)
     c20:	f822                	sd	s0,48(sp)
     c22:	0080                	addi	s0,sp,64
     c24:	fcb43823          	sd	a1,-48(s0)
     c28:	e010                	sd	a2,0(s0)
     c2a:	e414                	sd	a3,8(s0)
     c2c:	e818                	sd	a4,16(s0)
     c2e:	ec1c                	sd	a5,24(s0)
     c30:	03043023          	sd	a6,32(s0)
     c34:	03143423          	sd	a7,40(s0)
     c38:	87aa                	mv	a5,a0
     c3a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     c3e:	03040793          	addi	a5,s0,48
     c42:	fcf43423          	sd	a5,-56(s0)
     c46:	fc843783          	ld	a5,-56(s0)
     c4a:	fd078793          	addi	a5,a5,-48
     c4e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     c52:	fe843703          	ld	a4,-24(s0)
     c56:	fdc42783          	lw	a5,-36(s0)
     c5a:	863a                	mv	a2,a4
     c5c:	fd043583          	ld	a1,-48(s0)
     c60:	853e                	mv	a0,a5
     c62:	00000097          	auipc	ra,0x0
     c66:	d54080e7          	jalr	-684(ra) # 9b6 <vprintf>
}
     c6a:	0001                	nop
     c6c:	70e2                	ld	ra,56(sp)
     c6e:	7442                	ld	s0,48(sp)
     c70:	6165                	addi	sp,sp,112
     c72:	8082                	ret

0000000000000c74 <printf>:

void
printf(const char *fmt, ...)
{
     c74:	7159                	addi	sp,sp,-112
     c76:	f406                	sd	ra,40(sp)
     c78:	f022                	sd	s0,32(sp)
     c7a:	1800                	addi	s0,sp,48
     c7c:	fca43c23          	sd	a0,-40(s0)
     c80:	e40c                	sd	a1,8(s0)
     c82:	e810                	sd	a2,16(s0)
     c84:	ec14                	sd	a3,24(s0)
     c86:	f018                	sd	a4,32(s0)
     c88:	f41c                	sd	a5,40(s0)
     c8a:	03043823          	sd	a6,48(s0)
     c8e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     c92:	04040793          	addi	a5,s0,64
     c96:	fcf43823          	sd	a5,-48(s0)
     c9a:	fd043783          	ld	a5,-48(s0)
     c9e:	fc878793          	addi	a5,a5,-56
     ca2:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     ca6:	fe843783          	ld	a5,-24(s0)
     caa:	863e                	mv	a2,a5
     cac:	fd843583          	ld	a1,-40(s0)
     cb0:	4505                	li	a0,1
     cb2:	00000097          	auipc	ra,0x0
     cb6:	d04080e7          	jalr	-764(ra) # 9b6 <vprintf>
}
     cba:	0001                	nop
     cbc:	70a2                	ld	ra,40(sp)
     cbe:	7402                	ld	s0,32(sp)
     cc0:	6165                	addi	sp,sp,112
     cc2:	8082                	ret

0000000000000cc4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     cc4:	7179                	addi	sp,sp,-48
     cc6:	f422                	sd	s0,40(sp)
     cc8:	1800                	addi	s0,sp,48
     cca:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     cce:	fd843783          	ld	a5,-40(s0)
     cd2:	17c1                	addi	a5,a5,-16
     cd4:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     cd8:	00000797          	auipc	a5,0x0
     cdc:	51078793          	addi	a5,a5,1296 # 11e8 <freep>
     ce0:	639c                	ld	a5,0(a5)
     ce2:	fef43423          	sd	a5,-24(s0)
     ce6:	a815                	j	d1a <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ce8:	fe843783          	ld	a5,-24(s0)
     cec:	639c                	ld	a5,0(a5)
     cee:	fe843703          	ld	a4,-24(s0)
     cf2:	00f76f63          	bltu	a4,a5,d10 <free+0x4c>
     cf6:	fe043703          	ld	a4,-32(s0)
     cfa:	fe843783          	ld	a5,-24(s0)
     cfe:	02e7eb63          	bltu	a5,a4,d34 <free+0x70>
     d02:	fe843783          	ld	a5,-24(s0)
     d06:	639c                	ld	a5,0(a5)
     d08:	fe043703          	ld	a4,-32(s0)
     d0c:	02f76463          	bltu	a4,a5,d34 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d10:	fe843783          	ld	a5,-24(s0)
     d14:	639c                	ld	a5,0(a5)
     d16:	fef43423          	sd	a5,-24(s0)
     d1a:	fe043703          	ld	a4,-32(s0)
     d1e:	fe843783          	ld	a5,-24(s0)
     d22:	fce7f3e3          	bgeu	a5,a4,ce8 <free+0x24>
     d26:	fe843783          	ld	a5,-24(s0)
     d2a:	639c                	ld	a5,0(a5)
     d2c:	fe043703          	ld	a4,-32(s0)
     d30:	faf77ce3          	bgeu	a4,a5,ce8 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     d34:	fe043783          	ld	a5,-32(s0)
     d38:	479c                	lw	a5,8(a5)
     d3a:	1782                	slli	a5,a5,0x20
     d3c:	9381                	srli	a5,a5,0x20
     d3e:	0792                	slli	a5,a5,0x4
     d40:	fe043703          	ld	a4,-32(s0)
     d44:	973e                	add	a4,a4,a5
     d46:	fe843783          	ld	a5,-24(s0)
     d4a:	639c                	ld	a5,0(a5)
     d4c:	02f71763          	bne	a4,a5,d7a <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     d50:	fe043783          	ld	a5,-32(s0)
     d54:	4798                	lw	a4,8(a5)
     d56:	fe843783          	ld	a5,-24(s0)
     d5a:	639c                	ld	a5,0(a5)
     d5c:	479c                	lw	a5,8(a5)
     d5e:	9fb9                	addw	a5,a5,a4
     d60:	0007871b          	sext.w	a4,a5
     d64:	fe043783          	ld	a5,-32(s0)
     d68:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     d6a:	fe843783          	ld	a5,-24(s0)
     d6e:	639c                	ld	a5,0(a5)
     d70:	6398                	ld	a4,0(a5)
     d72:	fe043783          	ld	a5,-32(s0)
     d76:	e398                	sd	a4,0(a5)
     d78:	a039                	j	d86 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     d7a:	fe843783          	ld	a5,-24(s0)
     d7e:	6398                	ld	a4,0(a5)
     d80:	fe043783          	ld	a5,-32(s0)
     d84:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     d86:	fe843783          	ld	a5,-24(s0)
     d8a:	479c                	lw	a5,8(a5)
     d8c:	1782                	slli	a5,a5,0x20
     d8e:	9381                	srli	a5,a5,0x20
     d90:	0792                	slli	a5,a5,0x4
     d92:	fe843703          	ld	a4,-24(s0)
     d96:	97ba                	add	a5,a5,a4
     d98:	fe043703          	ld	a4,-32(s0)
     d9c:	02f71563          	bne	a4,a5,dc6 <free+0x102>
    p->s.size += bp->s.size;
     da0:	fe843783          	ld	a5,-24(s0)
     da4:	4798                	lw	a4,8(a5)
     da6:	fe043783          	ld	a5,-32(s0)
     daa:	479c                	lw	a5,8(a5)
     dac:	9fb9                	addw	a5,a5,a4
     dae:	0007871b          	sext.w	a4,a5
     db2:	fe843783          	ld	a5,-24(s0)
     db6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     db8:	fe043783          	ld	a5,-32(s0)
     dbc:	6398                	ld	a4,0(a5)
     dbe:	fe843783          	ld	a5,-24(s0)
     dc2:	e398                	sd	a4,0(a5)
     dc4:	a031                	j	dd0 <free+0x10c>
  } else
    p->s.ptr = bp;
     dc6:	fe843783          	ld	a5,-24(s0)
     dca:	fe043703          	ld	a4,-32(s0)
     dce:	e398                	sd	a4,0(a5)
  freep = p;
     dd0:	00000797          	auipc	a5,0x0
     dd4:	41878793          	addi	a5,a5,1048 # 11e8 <freep>
     dd8:	fe843703          	ld	a4,-24(s0)
     ddc:	e398                	sd	a4,0(a5)
}
     dde:	0001                	nop
     de0:	7422                	ld	s0,40(sp)
     de2:	6145                	addi	sp,sp,48
     de4:	8082                	ret

0000000000000de6 <morecore>:

static Header*
morecore(uint nu)
{
     de6:	7179                	addi	sp,sp,-48
     de8:	f406                	sd	ra,40(sp)
     dea:	f022                	sd	s0,32(sp)
     dec:	1800                	addi	s0,sp,48
     dee:	87aa                	mv	a5,a0
     df0:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     df4:	fdc42783          	lw	a5,-36(s0)
     df8:	0007871b          	sext.w	a4,a5
     dfc:	6785                	lui	a5,0x1
     dfe:	00f77563          	bgeu	a4,a5,e08 <morecore+0x22>
    nu = 4096;
     e02:	6785                	lui	a5,0x1
     e04:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     e08:	fdc42783          	lw	a5,-36(s0)
     e0c:	0047979b          	slliw	a5,a5,0x4
     e10:	2781                	sext.w	a5,a5
     e12:	2781                	sext.w	a5,a5
     e14:	853e                	mv	a0,a5
     e16:	00000097          	auipc	ra,0x0
     e1a:	9ae080e7          	jalr	-1618(ra) # 7c4 <sbrk>
     e1e:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     e22:	fe843703          	ld	a4,-24(s0)
     e26:	57fd                	li	a5,-1
     e28:	00f71463          	bne	a4,a5,e30 <morecore+0x4a>
    return 0;
     e2c:	4781                	li	a5,0
     e2e:	a03d                	j	e5c <morecore+0x76>
  hp = (Header*)p;
     e30:	fe843783          	ld	a5,-24(s0)
     e34:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     e38:	fe043783          	ld	a5,-32(s0)
     e3c:	fdc42703          	lw	a4,-36(s0)
     e40:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     e42:	fe043783          	ld	a5,-32(s0)
     e46:	07c1                	addi	a5,a5,16
     e48:	853e                	mv	a0,a5
     e4a:	00000097          	auipc	ra,0x0
     e4e:	e7a080e7          	jalr	-390(ra) # cc4 <free>
  return freep;
     e52:	00000797          	auipc	a5,0x0
     e56:	39678793          	addi	a5,a5,918 # 11e8 <freep>
     e5a:	639c                	ld	a5,0(a5)
}
     e5c:	853e                	mv	a0,a5
     e5e:	70a2                	ld	ra,40(sp)
     e60:	7402                	ld	s0,32(sp)
     e62:	6145                	addi	sp,sp,48
     e64:	8082                	ret

0000000000000e66 <malloc>:

void*
malloc(uint nbytes)
{
     e66:	7139                	addi	sp,sp,-64
     e68:	fc06                	sd	ra,56(sp)
     e6a:	f822                	sd	s0,48(sp)
     e6c:	0080                	addi	s0,sp,64
     e6e:	87aa                	mv	a5,a0
     e70:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     e74:	fcc46783          	lwu	a5,-52(s0)
     e78:	07bd                	addi	a5,a5,15
     e7a:	8391                	srli	a5,a5,0x4
     e7c:	2781                	sext.w	a5,a5
     e7e:	2785                	addiw	a5,a5,1
     e80:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     e84:	00000797          	auipc	a5,0x0
     e88:	36478793          	addi	a5,a5,868 # 11e8 <freep>
     e8c:	639c                	ld	a5,0(a5)
     e8e:	fef43023          	sd	a5,-32(s0)
     e92:	fe043783          	ld	a5,-32(s0)
     e96:	ef95                	bnez	a5,ed2 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     e98:	00000797          	auipc	a5,0x0
     e9c:	34078793          	addi	a5,a5,832 # 11d8 <base>
     ea0:	fef43023          	sd	a5,-32(s0)
     ea4:	00000797          	auipc	a5,0x0
     ea8:	34478793          	addi	a5,a5,836 # 11e8 <freep>
     eac:	fe043703          	ld	a4,-32(s0)
     eb0:	e398                	sd	a4,0(a5)
     eb2:	00000797          	auipc	a5,0x0
     eb6:	33678793          	addi	a5,a5,822 # 11e8 <freep>
     eba:	6398                	ld	a4,0(a5)
     ebc:	00000797          	auipc	a5,0x0
     ec0:	31c78793          	addi	a5,a5,796 # 11d8 <base>
     ec4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     ec6:	00000797          	auipc	a5,0x0
     eca:	31278793          	addi	a5,a5,786 # 11d8 <base>
     ece:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     ed2:	fe043783          	ld	a5,-32(s0)
     ed6:	639c                	ld	a5,0(a5)
     ed8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     edc:	fe843783          	ld	a5,-24(s0)
     ee0:	4798                	lw	a4,8(a5)
     ee2:	fdc42783          	lw	a5,-36(s0)
     ee6:	2781                	sext.w	a5,a5
     ee8:	06f76763          	bltu	a4,a5,f56 <malloc+0xf0>
      if(p->s.size == nunits)
     eec:	fe843783          	ld	a5,-24(s0)
     ef0:	4798                	lw	a4,8(a5)
     ef2:	fdc42783          	lw	a5,-36(s0)
     ef6:	2781                	sext.w	a5,a5
     ef8:	00e79963          	bne	a5,a4,f0a <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     efc:	fe843783          	ld	a5,-24(s0)
     f00:	6398                	ld	a4,0(a5)
     f02:	fe043783          	ld	a5,-32(s0)
     f06:	e398                	sd	a4,0(a5)
     f08:	a825                	j	f40 <malloc+0xda>
      else {
        p->s.size -= nunits;
     f0a:	fe843783          	ld	a5,-24(s0)
     f0e:	479c                	lw	a5,8(a5)
     f10:	fdc42703          	lw	a4,-36(s0)
     f14:	9f99                	subw	a5,a5,a4
     f16:	0007871b          	sext.w	a4,a5
     f1a:	fe843783          	ld	a5,-24(s0)
     f1e:	c798                	sw	a4,8(a5)
        p += p->s.size;
     f20:	fe843783          	ld	a5,-24(s0)
     f24:	479c                	lw	a5,8(a5)
     f26:	1782                	slli	a5,a5,0x20
     f28:	9381                	srli	a5,a5,0x20
     f2a:	0792                	slli	a5,a5,0x4
     f2c:	fe843703          	ld	a4,-24(s0)
     f30:	97ba                	add	a5,a5,a4
     f32:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     f36:	fe843783          	ld	a5,-24(s0)
     f3a:	fdc42703          	lw	a4,-36(s0)
     f3e:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     f40:	00000797          	auipc	a5,0x0
     f44:	2a878793          	addi	a5,a5,680 # 11e8 <freep>
     f48:	fe043703          	ld	a4,-32(s0)
     f4c:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     f4e:	fe843783          	ld	a5,-24(s0)
     f52:	07c1                	addi	a5,a5,16
     f54:	a091                	j	f98 <malloc+0x132>
    }
    if(p == freep)
     f56:	00000797          	auipc	a5,0x0
     f5a:	29278793          	addi	a5,a5,658 # 11e8 <freep>
     f5e:	639c                	ld	a5,0(a5)
     f60:	fe843703          	ld	a4,-24(s0)
     f64:	02f71063          	bne	a4,a5,f84 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
     f68:	fdc42783          	lw	a5,-36(s0)
     f6c:	853e                	mv	a0,a5
     f6e:	00000097          	auipc	ra,0x0
     f72:	e78080e7          	jalr	-392(ra) # de6 <morecore>
     f76:	fea43423          	sd	a0,-24(s0)
     f7a:	fe843783          	ld	a5,-24(s0)
     f7e:	e399                	bnez	a5,f84 <malloc+0x11e>
        return 0;
     f80:	4781                	li	a5,0
     f82:	a819                	j	f98 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f84:	fe843783          	ld	a5,-24(s0)
     f88:	fef43023          	sd	a5,-32(s0)
     f8c:	fe843783          	ld	a5,-24(s0)
     f90:	639c                	ld	a5,0(a5)
     f92:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     f96:	b799                	j	edc <malloc+0x76>
  }
}
     f98:	853e                	mv	a0,a5
     f9a:	70e2                	ld	ra,56(sp)
     f9c:	7442                	ld	s0,48(sp)
     f9e:	6121                	addi	sp,sp,64
     fa0:	8082                	ret

0000000000000fa2 <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
     fa2:	7179                	addi	sp,sp,-48
     fa4:	f406                	sd	ra,40(sp)
     fa6:	f022                	sd	s0,32(sp)
     fa8:	1800                	addi	s0,sp,48
     faa:	fca43c23          	sd	a0,-40(s0)
     fae:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
     fb2:	6505                	lui	a0,0x1
     fb4:	00000097          	auipc	ra,0x0
     fb8:	eb2080e7          	jalr	-334(ra) # e66 <malloc>
     fbc:	fea43423          	sd	a0,-24(s0)
     fc0:	fe843783          	ld	a5,-24(s0)
     fc4:	e38d                	bnez	a5,fe6 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
     fc6:	00000517          	auipc	a0,0x0
     fca:	1a250513          	addi	a0,a0,418 # 1168 <lock_init+0xca>
     fce:	00000097          	auipc	ra,0x0
     fd2:	ca6080e7          	jalr	-858(ra) # c74 <printf>
        free(stack);
     fd6:	fe843503          	ld	a0,-24(s0)
     fda:	00000097          	auipc	ra,0x0
     fde:	cea080e7          	jalr	-790(ra) # cc4 <free>
        return -1;
     fe2:	57fd                	li	a5,-1
     fe4:	a099                	j	102a <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
     fe6:	fe843783          	ld	a5,-24(s0)
     fea:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
     fee:	fe043703          	ld	a4,-32(s0)
     ff2:	6785                	lui	a5,0x1
     ff4:	17fd                	addi	a5,a5,-1
     ff6:	8ff9                	and	a5,a5,a4
     ff8:	cf91                	beqz	a5,1014 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
     ffa:	fe043703          	ld	a4,-32(s0)
     ffe:	6785                	lui	a5,0x1
    1000:	17fd                	addi	a5,a5,-1
    1002:	8ff9                	and	a5,a5,a4
    1004:	6705                	lui	a4,0x1
    1006:	40f707b3          	sub	a5,a4,a5
    100a:	fe843703          	ld	a4,-24(s0)
    100e:	97ba                	add	a5,a5,a4
    1010:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
    1014:	fe843603          	ld	a2,-24(s0)
    1018:	fd043583          	ld	a1,-48(s0)
    101c:	fd843503          	ld	a0,-40(s0)
    1020:	fffff097          	auipc	ra,0xfffff
    1024:	7bc080e7          	jalr	1980(ra) # 7dc <clone>
    1028:	87aa                	mv	a5,a0
}
    102a:	853e                	mv	a0,a5
    102c:	70a2                	ld	ra,40(sp)
    102e:	7402                	ld	s0,32(sp)
    1030:	6145                	addi	sp,sp,48
    1032:	8082                	ret

0000000000001034 <thread_join>:


int thread_join()
{
    1034:	1101                	addi	sp,sp,-32
    1036:	ec06                	sd	ra,24(sp)
    1038:	e822                	sd	s0,16(sp)
    103a:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
    103c:	fe040793          	addi	a5,s0,-32
    1040:	853e                	mv	a0,a5
    1042:	fffff097          	auipc	ra,0xfffff
    1046:	7a2080e7          	jalr	1954(ra) # 7e4 <join>
    104a:	87aa                	mv	a5,a0
    104c:	fef42623          	sw	a5,-20(s0)
    1050:	fec42783          	lw	a5,-20(s0)
    1054:	0007871b          	sext.w	a4,a5
    1058:	57fd                	li	a5,-1
    105a:	00f70963          	beq	a4,a5,106c <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
    105e:	fe043783          	ld	a5,-32(s0)
    1062:	853e                	mv	a0,a5
    1064:	00000097          	auipc	ra,0x0
    1068:	c60080e7          	jalr	-928(ra) # cc4 <free>
    } 

    return child_tid;
    106c:	fec42783          	lw	a5,-20(s0)
}
    1070:	853e                	mv	a0,a5
    1072:	60e2                	ld	ra,24(sp)
    1074:	6442                	ld	s0,16(sp)
    1076:	6105                	addi	sp,sp,32
    1078:	8082                	ret

000000000000107a <lock_acquire>:


void lock_acquire (lock_t *)
{
    107a:	1101                	addi	sp,sp,-32
    107c:	ec22                	sd	s0,24(sp)
    107e:	1000                	addi	s0,sp,32
    1080:	fea43423          	sd	a0,-24(s0)

}
    1084:	0001                	nop
    1086:	6462                	ld	s0,24(sp)
    1088:	6105                	addi	sp,sp,32
    108a:	8082                	ret

000000000000108c <lock_release>:

void lock_release (lock_t *)
{
    108c:	1101                	addi	sp,sp,-32
    108e:	ec22                	sd	s0,24(sp)
    1090:	1000                	addi	s0,sp,32
    1092:	fea43423          	sd	a0,-24(s0)
    
}
    1096:	0001                	nop
    1098:	6462                	ld	s0,24(sp)
    109a:	6105                	addi	sp,sp,32
    109c:	8082                	ret

000000000000109e <lock_init>:

void lock_init (lock_t *)
{
    109e:	1101                	addi	sp,sp,-32
    10a0:	ec22                	sd	s0,24(sp)
    10a2:	1000                	addi	s0,sp,32
    10a4:	fea43423          	sd	a0,-24(s0)
    
}
    10a8:	0001                	nop
    10aa:	6462                	ld	s0,24(sp)
    10ac:	6105                	addi	sp,sp,32
    10ae:	8082                	ret
