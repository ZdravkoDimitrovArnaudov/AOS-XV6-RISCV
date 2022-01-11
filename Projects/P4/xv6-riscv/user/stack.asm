
user/_stack:     file format elf64-littleriscv


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
      16:	7d0080e7          	jalr	2000(ra) # 7e2 <getpid>
      1a:	87aa                	mv	a5,a0
      1c:	873e                	mv	a4,a5
      1e:	00001797          	auipc	a5,0x1
      22:	25a78793          	addi	a5,a5,602 # 1278 <ppid>
      26:	c398                	sw	a4,0(a5)
   void *stack = malloc(PGSIZE*2);
      28:	6509                	lui	a0,0x2
      2a:	00001097          	auipc	ra,0x1
      2e:	e62080e7          	jalr	-414(ra) # e8c <malloc>
      32:	fea43423          	sd	a0,-24(s0)
   assert(stack != NULL);
      36:	fe843783          	ld	a5,-24(s0)
      3a:	e3ad                	bnez	a5,9c <main+0x9c>
      3c:	4671                	li	a2,28
      3e:	00001597          	auipc	a1,0x1
      42:	09a58593          	addi	a1,a1,154 # 10d8 <lock_init+0x14>
      46:	00001517          	auipc	a0,0x1
      4a:	0a250513          	addi	a0,a0,162 # 10e8 <lock_init+0x24>
      4e:	00001097          	auipc	ra,0x1
      52:	c4c080e7          	jalr	-948(ra) # c9a <printf>
      56:	00001597          	auipc	a1,0x1
      5a:	09a58593          	addi	a1,a1,154 # 10f0 <lock_init+0x2c>
      5e:	00001517          	auipc	a0,0x1
      62:	0a250513          	addi	a0,a0,162 # 1100 <lock_init+0x3c>
      66:	00001097          	auipc	ra,0x1
      6a:	c34080e7          	jalr	-972(ra) # c9a <printf>
      6e:	00001517          	auipc	a0,0x1
      72:	0aa50513          	addi	a0,a0,170 # 1118 <lock_init+0x54>
      76:	00001097          	auipc	ra,0x1
      7a:	c24080e7          	jalr	-988(ra) # c9a <printf>
      7e:	00001797          	auipc	a5,0x1
      82:	1fa78793          	addi	a5,a5,506 # 1278 <ppid>
      86:	439c                	lw	a5,0(a5)
      88:	853e                	mv	a0,a5
      8a:	00000097          	auipc	ra,0x0
      8e:	708080e7          	jalr	1800(ra) # 792 <kill>
      92:	4501                	li	a0,0
      94:	00000097          	auipc	ra,0x0
      98:	6ce080e7          	jalr	1742(ra) # 762 <exit>
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

   printf ("El stack esta en: %d\n", stack);
      c2:	fe843583          	ld	a1,-24(s0)
      c6:	00001517          	auipc	a0,0x1
      ca:	06250513          	addi	a0,a0,98 # 1128 <lock_init+0x64>
      ce:	00001097          	auipc	ra,0x1
      d2:	bcc080e7          	jalr	-1076(ra) # c9a <printf>

   int clone_pid = clone(worker, stack, stack);
      d6:	fe843603          	ld	a2,-24(s0)
      da:	fe843583          	ld	a1,-24(s0)
      de:	00000517          	auipc	a0,0x0
      e2:	0b250513          	addi	a0,a0,178 # 190 <worker>
      e6:	00000097          	auipc	ra,0x0
      ea:	71c080e7          	jalr	1820(ra) # 802 <clone>
      ee:	87aa                	mv	a5,a0
      f0:	fef42223          	sw	a5,-28(s0)
   assert(clone_pid > 0);
      f4:	fe442783          	lw	a5,-28(s0)
      f8:	2781                	sext.w	a5,a5
      fa:	06f04363          	bgtz	a5,160 <main+0x160>
      fe:	02300613          	li	a2,35
     102:	00001597          	auipc	a1,0x1
     106:	fd658593          	addi	a1,a1,-42 # 10d8 <lock_init+0x14>
     10a:	00001517          	auipc	a0,0x1
     10e:	fde50513          	addi	a0,a0,-34 # 10e8 <lock_init+0x24>
     112:	00001097          	auipc	ra,0x1
     116:	b88080e7          	jalr	-1144(ra) # c9a <printf>
     11a:	00001597          	auipc	a1,0x1
     11e:	02658593          	addi	a1,a1,38 # 1140 <lock_init+0x7c>
     122:	00001517          	auipc	a0,0x1
     126:	fde50513          	addi	a0,a0,-34 # 1100 <lock_init+0x3c>
     12a:	00001097          	auipc	ra,0x1
     12e:	b70080e7          	jalr	-1168(ra) # c9a <printf>
     132:	00001517          	auipc	a0,0x1
     136:	fe650513          	addi	a0,a0,-26 # 1118 <lock_init+0x54>
     13a:	00001097          	auipc	ra,0x1
     13e:	b60080e7          	jalr	-1184(ra) # c9a <printf>
     142:	00001797          	auipc	a5,0x1
     146:	13678793          	addi	a5,a5,310 # 1278 <ppid>
     14a:	439c                	lw	a5,0(a5)
     14c:	853e                	mv	a0,a5
     14e:	00000097          	auipc	ra,0x0
     152:	644080e7          	jalr	1604(ra) # 792 <kill>
     156:	4501                	li	a0,0
     158:	00000097          	auipc	ra,0x0
     15c:	60a080e7          	jalr	1546(ra) # 762 <exit>
   while(global != 5);
     160:	0001                	nop
     162:	00001797          	auipc	a5,0x1
     166:	11278793          	addi	a5,a5,274 # 1274 <global>
     16a:	439c                	lw	a5,0(a5)
     16c:	2781                	sext.w	a5,a5
     16e:	873e                	mv	a4,a5
     170:	4795                	li	a5,5
     172:	fef718e3          	bne	a4,a5,162 <main+0x162>
   printf("TEST PASSED\n");
     176:	00001517          	auipc	a0,0x1
     17a:	fda50513          	addi	a0,a0,-38 # 1150 <lock_init+0x8c>
     17e:	00001097          	auipc	ra,0x1
     182:	b1c080e7          	jalr	-1252(ra) # c9a <printf>
   exit(0);
     186:	4501                	li	a0,0
     188:	00000097          	auipc	ra,0x0
     18c:	5da080e7          	jalr	1498(ra) # 762 <exit>

0000000000000190 <worker>:
}

void
worker(void *arg_ptr) {
     190:	1101                	addi	sp,sp,-32
     192:	ec06                	sd	ra,24(sp)
     194:	e822                	sd	s0,16(sp)
     196:	1000                	addi	s0,sp,32
     198:	fea43423          	sd	a0,-24(s0)
   printf("Direccion arg: %d\n",(uint64)&arg_ptr);
     19c:	fe840793          	addi	a5,s0,-24
     1a0:	85be                	mv	a1,a5
     1a2:	00001517          	auipc	a0,0x1
     1a6:	fbe50513          	addi	a0,a0,-66 # 1160 <lock_init+0x9c>
     1aa:	00001097          	auipc	ra,0x1
     1ae:	af0080e7          	jalr	-1296(ra) # c9a <printf>
   printf ("Donde arg deberia estar: %d\n", ((uint64)arg_ptr + PGSIZE)); //
     1b2:	fe843783          	ld	a5,-24(s0)
     1b6:	873e                	mv	a4,a5
     1b8:	6785                	lui	a5,0x1
     1ba:	97ba                	add	a5,a5,a4
     1bc:	85be                	mv	a1,a5
     1be:	00001517          	auipc	a0,0x1
     1c2:	fba50513          	addi	a0,a0,-70 # 1178 <lock_init+0xb4>
     1c6:	00001097          	auipc	ra,0x1
     1ca:	ad4080e7          	jalr	-1324(ra) # c9a <printf>
   printf ("TOP_USTACK-56: %x \n", *(stack_top - 56));
   printf ("TOP_USTACK-60: %x \n", *(stack_top - 60));
   printf ("TOP_USTACK-64: %x \n", *(stack_top - 64));
   printf ("TOP_USTACK-68: %x \n", *(stack_top - 68));*/

   assert((uint64)&arg_ptr == ((uint64)arg_ptr + PGSIZE - 32)); // -8
     1ce:	fe840713          	addi	a4,s0,-24
     1d2:	fe843783          	ld	a5,-24(s0)
     1d6:	86be                	mv	a3,a5
     1d8:	6785                	lui	a5,0x1
     1da:	1781                	addi	a5,a5,-32
     1dc:	97b6                	add	a5,a5,a3
     1de:	06f70363          	beq	a4,a5,244 <worker+0xb4>
     1e2:	04800613          	li	a2,72
     1e6:	00001597          	auipc	a1,0x1
     1ea:	ef258593          	addi	a1,a1,-270 # 10d8 <lock_init+0x14>
     1ee:	00001517          	auipc	a0,0x1
     1f2:	efa50513          	addi	a0,a0,-262 # 10e8 <lock_init+0x24>
     1f6:	00001097          	auipc	ra,0x1
     1fa:	aa4080e7          	jalr	-1372(ra) # c9a <printf>
     1fe:	00001597          	auipc	a1,0x1
     202:	f9a58593          	addi	a1,a1,-102 # 1198 <lock_init+0xd4>
     206:	00001517          	auipc	a0,0x1
     20a:	efa50513          	addi	a0,a0,-262 # 1100 <lock_init+0x3c>
     20e:	00001097          	auipc	ra,0x1
     212:	a8c080e7          	jalr	-1396(ra) # c9a <printf>
     216:	00001517          	auipc	a0,0x1
     21a:	f0250513          	addi	a0,a0,-254 # 1118 <lock_init+0x54>
     21e:	00001097          	auipc	ra,0x1
     222:	a7c080e7          	jalr	-1412(ra) # c9a <printf>
     226:	00001797          	auipc	a5,0x1
     22a:	05278793          	addi	a5,a5,82 # 1278 <ppid>
     22e:	439c                	lw	a5,0(a5)
     230:	853e                	mv	a0,a5
     232:	00000097          	auipc	ra,0x0
     236:	560080e7          	jalr	1376(ra) # 792 <kill>
     23a:	4501                	li	a0,0
     23c:	00000097          	auipc	ra,0x0
     240:	526080e7          	jalr	1318(ra) # 762 <exit>
   assert(*((uint64*) (arg_ptr + PGSIZE - 8)) == 0xffffffff);
     244:	fe843703          	ld	a4,-24(s0)
     248:	6785                	lui	a5,0x1
     24a:	17e1                	addi	a5,a5,-8
     24c:	97ba                	add	a5,a5,a4
     24e:	6398                	ld	a4,0(a5)
     250:	57fd                	li	a5,-1
     252:	9381                	srli	a5,a5,0x20
     254:	06f70363          	beq	a4,a5,2ba <worker+0x12a>
     258:	04900613          	li	a2,73
     25c:	00001597          	auipc	a1,0x1
     260:	e7c58593          	addi	a1,a1,-388 # 10d8 <lock_init+0x14>
     264:	00001517          	auipc	a0,0x1
     268:	e8450513          	addi	a0,a0,-380 # 10e8 <lock_init+0x24>
     26c:	00001097          	auipc	ra,0x1
     270:	a2e080e7          	jalr	-1490(ra) # c9a <printf>
     274:	00001597          	auipc	a1,0x1
     278:	f5c58593          	addi	a1,a1,-164 # 11d0 <lock_init+0x10c>
     27c:	00001517          	auipc	a0,0x1
     280:	e8450513          	addi	a0,a0,-380 # 1100 <lock_init+0x3c>
     284:	00001097          	auipc	ra,0x1
     288:	a16080e7          	jalr	-1514(ra) # c9a <printf>
     28c:	00001517          	auipc	a0,0x1
     290:	e8c50513          	addi	a0,a0,-372 # 1118 <lock_init+0x54>
     294:	00001097          	auipc	ra,0x1
     298:	a06080e7          	jalr	-1530(ra) # c9a <printf>
     29c:	00001797          	auipc	a5,0x1
     2a0:	fdc78793          	addi	a5,a5,-36 # 1278 <ppid>
     2a4:	439c                	lw	a5,0(a5)
     2a6:	853e                	mv	a0,a5
     2a8:	00000097          	auipc	ra,0x0
     2ac:	4ea080e7          	jalr	1258(ra) # 792 <kill>
     2b0:	4501                	li	a0,0
     2b2:	00000097          	auipc	ra,0x0
     2b6:	4b0080e7          	jalr	1200(ra) # 762 <exit>
   global = 5;
     2ba:	00001797          	auipc	a5,0x1
     2be:	fba78793          	addi	a5,a5,-70 # 1274 <global>
     2c2:	4715                	li	a4,5
     2c4:	c398                	sw	a4,0(a5)
   exit(0);
     2c6:	4501                	li	a0,0
     2c8:	00000097          	auipc	ra,0x0
     2cc:	49a080e7          	jalr	1178(ra) # 762 <exit>

00000000000002d0 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     2d0:	7179                	addi	sp,sp,-48
     2d2:	f422                	sd	s0,40(sp)
     2d4:	1800                	addi	s0,sp,48
     2d6:	fca43c23          	sd	a0,-40(s0)
     2da:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     2de:	fd843783          	ld	a5,-40(s0)
     2e2:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     2e6:	0001                	nop
     2e8:	fd043703          	ld	a4,-48(s0)
     2ec:	00170793          	addi	a5,a4,1 # 1001 <thread_create+0x39>
     2f0:	fcf43823          	sd	a5,-48(s0)
     2f4:	fd843783          	ld	a5,-40(s0)
     2f8:	00178693          	addi	a3,a5,1
     2fc:	fcd43c23          	sd	a3,-40(s0)
     300:	00074703          	lbu	a4,0(a4)
     304:	00e78023          	sb	a4,0(a5)
     308:	0007c783          	lbu	a5,0(a5)
     30c:	fff1                	bnez	a5,2e8 <strcpy+0x18>
    ;
  return os;
     30e:	fe843783          	ld	a5,-24(s0)
}
     312:	853e                	mv	a0,a5
     314:	7422                	ld	s0,40(sp)
     316:	6145                	addi	sp,sp,48
     318:	8082                	ret

000000000000031a <strcmp>:

int
strcmp(const char *p, const char *q)
{
     31a:	1101                	addi	sp,sp,-32
     31c:	ec22                	sd	s0,24(sp)
     31e:	1000                	addi	s0,sp,32
     320:	fea43423          	sd	a0,-24(s0)
     324:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     328:	a819                	j	33e <strcmp+0x24>
    p++, q++;
     32a:	fe843783          	ld	a5,-24(s0)
     32e:	0785                	addi	a5,a5,1
     330:	fef43423          	sd	a5,-24(s0)
     334:	fe043783          	ld	a5,-32(s0)
     338:	0785                	addi	a5,a5,1
     33a:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     33e:	fe843783          	ld	a5,-24(s0)
     342:	0007c783          	lbu	a5,0(a5)
     346:	cb99                	beqz	a5,35c <strcmp+0x42>
     348:	fe843783          	ld	a5,-24(s0)
     34c:	0007c703          	lbu	a4,0(a5)
     350:	fe043783          	ld	a5,-32(s0)
     354:	0007c783          	lbu	a5,0(a5)
     358:	fcf709e3          	beq	a4,a5,32a <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     35c:	fe843783          	ld	a5,-24(s0)
     360:	0007c783          	lbu	a5,0(a5)
     364:	0007871b          	sext.w	a4,a5
     368:	fe043783          	ld	a5,-32(s0)
     36c:	0007c783          	lbu	a5,0(a5)
     370:	2781                	sext.w	a5,a5
     372:	40f707bb          	subw	a5,a4,a5
     376:	2781                	sext.w	a5,a5
}
     378:	853e                	mv	a0,a5
     37a:	6462                	ld	s0,24(sp)
     37c:	6105                	addi	sp,sp,32
     37e:	8082                	ret

0000000000000380 <strlen>:

uint
strlen(const char *s)
{
     380:	7179                	addi	sp,sp,-48
     382:	f422                	sd	s0,40(sp)
     384:	1800                	addi	s0,sp,48
     386:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     38a:	fe042623          	sw	zero,-20(s0)
     38e:	a031                	j	39a <strlen+0x1a>
     390:	fec42783          	lw	a5,-20(s0)
     394:	2785                	addiw	a5,a5,1
     396:	fef42623          	sw	a5,-20(s0)
     39a:	fec42783          	lw	a5,-20(s0)
     39e:	fd843703          	ld	a4,-40(s0)
     3a2:	97ba                	add	a5,a5,a4
     3a4:	0007c783          	lbu	a5,0(a5)
     3a8:	f7e5                	bnez	a5,390 <strlen+0x10>
    ;
  return n;
     3aa:	fec42783          	lw	a5,-20(s0)
}
     3ae:	853e                	mv	a0,a5
     3b0:	7422                	ld	s0,40(sp)
     3b2:	6145                	addi	sp,sp,48
     3b4:	8082                	ret

00000000000003b6 <memset>:

void*
memset(void *dst, int c, uint n)
{
     3b6:	7179                	addi	sp,sp,-48
     3b8:	f422                	sd	s0,40(sp)
     3ba:	1800                	addi	s0,sp,48
     3bc:	fca43c23          	sd	a0,-40(s0)
     3c0:	87ae                	mv	a5,a1
     3c2:	8732                	mv	a4,a2
     3c4:	fcf42a23          	sw	a5,-44(s0)
     3c8:	87ba                	mv	a5,a4
     3ca:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     3ce:	fd843783          	ld	a5,-40(s0)
     3d2:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     3d6:	fe042623          	sw	zero,-20(s0)
     3da:	a00d                	j	3fc <memset+0x46>
    cdst[i] = c;
     3dc:	fec42783          	lw	a5,-20(s0)
     3e0:	fe043703          	ld	a4,-32(s0)
     3e4:	97ba                	add	a5,a5,a4
     3e6:	fd442703          	lw	a4,-44(s0)
     3ea:	0ff77713          	zext.b	a4,a4
     3ee:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     3f2:	fec42783          	lw	a5,-20(s0)
     3f6:	2785                	addiw	a5,a5,1
     3f8:	fef42623          	sw	a5,-20(s0)
     3fc:	fec42703          	lw	a4,-20(s0)
     400:	fd042783          	lw	a5,-48(s0)
     404:	2781                	sext.w	a5,a5
     406:	fcf76be3          	bltu	a4,a5,3dc <memset+0x26>
  }
  return dst;
     40a:	fd843783          	ld	a5,-40(s0)
}
     40e:	853e                	mv	a0,a5
     410:	7422                	ld	s0,40(sp)
     412:	6145                	addi	sp,sp,48
     414:	8082                	ret

0000000000000416 <strchr>:

char*
strchr(const char *s, char c)
{
     416:	1101                	addi	sp,sp,-32
     418:	ec22                	sd	s0,24(sp)
     41a:	1000                	addi	s0,sp,32
     41c:	fea43423          	sd	a0,-24(s0)
     420:	87ae                	mv	a5,a1
     422:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     426:	a01d                	j	44c <strchr+0x36>
    if(*s == c)
     428:	fe843783          	ld	a5,-24(s0)
     42c:	0007c703          	lbu	a4,0(a5)
     430:	fe744783          	lbu	a5,-25(s0)
     434:	0ff7f793          	zext.b	a5,a5
     438:	00e79563          	bne	a5,a4,442 <strchr+0x2c>
      return (char*)s;
     43c:	fe843783          	ld	a5,-24(s0)
     440:	a821                	j	458 <strchr+0x42>
  for(; *s; s++)
     442:	fe843783          	ld	a5,-24(s0)
     446:	0785                	addi	a5,a5,1
     448:	fef43423          	sd	a5,-24(s0)
     44c:	fe843783          	ld	a5,-24(s0)
     450:	0007c783          	lbu	a5,0(a5)
     454:	fbf1                	bnez	a5,428 <strchr+0x12>
  return 0;
     456:	4781                	li	a5,0
}
     458:	853e                	mv	a0,a5
     45a:	6462                	ld	s0,24(sp)
     45c:	6105                	addi	sp,sp,32
     45e:	8082                	ret

0000000000000460 <gets>:

char*
gets(char *buf, int max)
{
     460:	7179                	addi	sp,sp,-48
     462:	f406                	sd	ra,40(sp)
     464:	f022                	sd	s0,32(sp)
     466:	1800                	addi	s0,sp,48
     468:	fca43c23          	sd	a0,-40(s0)
     46c:	87ae                	mv	a5,a1
     46e:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     472:	fe042623          	sw	zero,-20(s0)
     476:	a8a1                	j	4ce <gets+0x6e>
    cc = read(0, &c, 1);
     478:	fe740793          	addi	a5,s0,-25
     47c:	4605                	li	a2,1
     47e:	85be                	mv	a1,a5
     480:	4501                	li	a0,0
     482:	00000097          	auipc	ra,0x0
     486:	2f8080e7          	jalr	760(ra) # 77a <read>
     48a:	87aa                	mv	a5,a0
     48c:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     490:	fe842783          	lw	a5,-24(s0)
     494:	2781                	sext.w	a5,a5
     496:	04f05763          	blez	a5,4e4 <gets+0x84>
      break;
    buf[i++] = c;
     49a:	fec42783          	lw	a5,-20(s0)
     49e:	0017871b          	addiw	a4,a5,1
     4a2:	fee42623          	sw	a4,-20(s0)
     4a6:	873e                	mv	a4,a5
     4a8:	fd843783          	ld	a5,-40(s0)
     4ac:	97ba                	add	a5,a5,a4
     4ae:	fe744703          	lbu	a4,-25(s0)
     4b2:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     4b6:	fe744783          	lbu	a5,-25(s0)
     4ba:	873e                	mv	a4,a5
     4bc:	47a9                	li	a5,10
     4be:	02f70463          	beq	a4,a5,4e6 <gets+0x86>
     4c2:	fe744783          	lbu	a5,-25(s0)
     4c6:	873e                	mv	a4,a5
     4c8:	47b5                	li	a5,13
     4ca:	00f70e63          	beq	a4,a5,4e6 <gets+0x86>
  for(i=0; i+1 < max; ){
     4ce:	fec42783          	lw	a5,-20(s0)
     4d2:	2785                	addiw	a5,a5,1
     4d4:	0007871b          	sext.w	a4,a5
     4d8:	fd442783          	lw	a5,-44(s0)
     4dc:	2781                	sext.w	a5,a5
     4de:	f8f74de3          	blt	a4,a5,478 <gets+0x18>
     4e2:	a011                	j	4e6 <gets+0x86>
      break;
     4e4:	0001                	nop
      break;
  }
  buf[i] = '\0';
     4e6:	fec42783          	lw	a5,-20(s0)
     4ea:	fd843703          	ld	a4,-40(s0)
     4ee:	97ba                	add	a5,a5,a4
     4f0:	00078023          	sb	zero,0(a5)
  return buf;
     4f4:	fd843783          	ld	a5,-40(s0)
}
     4f8:	853e                	mv	a0,a5
     4fa:	70a2                	ld	ra,40(sp)
     4fc:	7402                	ld	s0,32(sp)
     4fe:	6145                	addi	sp,sp,48
     500:	8082                	ret

0000000000000502 <stat>:

int
stat(const char *n, struct stat *st)
{
     502:	7179                	addi	sp,sp,-48
     504:	f406                	sd	ra,40(sp)
     506:	f022                	sd	s0,32(sp)
     508:	1800                	addi	s0,sp,48
     50a:	fca43c23          	sd	a0,-40(s0)
     50e:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     512:	4581                	li	a1,0
     514:	fd843503          	ld	a0,-40(s0)
     518:	00000097          	auipc	ra,0x0
     51c:	28a080e7          	jalr	650(ra) # 7a2 <open>
     520:	87aa                	mv	a5,a0
     522:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     526:	fec42783          	lw	a5,-20(s0)
     52a:	2781                	sext.w	a5,a5
     52c:	0007d463          	bgez	a5,534 <stat+0x32>
    return -1;
     530:	57fd                	li	a5,-1
     532:	a035                	j	55e <stat+0x5c>
  r = fstat(fd, st);
     534:	fec42783          	lw	a5,-20(s0)
     538:	fd043583          	ld	a1,-48(s0)
     53c:	853e                	mv	a0,a5
     53e:	00000097          	auipc	ra,0x0
     542:	27c080e7          	jalr	636(ra) # 7ba <fstat>
     546:	87aa                	mv	a5,a0
     548:	fef42423          	sw	a5,-24(s0)
  close(fd);
     54c:	fec42783          	lw	a5,-20(s0)
     550:	853e                	mv	a0,a5
     552:	00000097          	auipc	ra,0x0
     556:	238080e7          	jalr	568(ra) # 78a <close>
  return r;
     55a:	fe842783          	lw	a5,-24(s0)
}
     55e:	853e                	mv	a0,a5
     560:	70a2                	ld	ra,40(sp)
     562:	7402                	ld	s0,32(sp)
     564:	6145                	addi	sp,sp,48
     566:	8082                	ret

0000000000000568 <atoi>:

int
atoi(const char *s)
{
     568:	7179                	addi	sp,sp,-48
     56a:	f422                	sd	s0,40(sp)
     56c:	1800                	addi	s0,sp,48
     56e:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     572:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     576:	a81d                	j	5ac <atoi+0x44>
    n = n*10 + *s++ - '0';
     578:	fec42783          	lw	a5,-20(s0)
     57c:	873e                	mv	a4,a5
     57e:	87ba                	mv	a5,a4
     580:	0027979b          	slliw	a5,a5,0x2
     584:	9fb9                	addw	a5,a5,a4
     586:	0017979b          	slliw	a5,a5,0x1
     58a:	0007871b          	sext.w	a4,a5
     58e:	fd843783          	ld	a5,-40(s0)
     592:	00178693          	addi	a3,a5,1
     596:	fcd43c23          	sd	a3,-40(s0)
     59a:	0007c783          	lbu	a5,0(a5)
     59e:	2781                	sext.w	a5,a5
     5a0:	9fb9                	addw	a5,a5,a4
     5a2:	2781                	sext.w	a5,a5
     5a4:	fd07879b          	addiw	a5,a5,-48
     5a8:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     5ac:	fd843783          	ld	a5,-40(s0)
     5b0:	0007c783          	lbu	a5,0(a5)
     5b4:	873e                	mv	a4,a5
     5b6:	02f00793          	li	a5,47
     5ba:	00e7fb63          	bgeu	a5,a4,5d0 <atoi+0x68>
     5be:	fd843783          	ld	a5,-40(s0)
     5c2:	0007c783          	lbu	a5,0(a5)
     5c6:	873e                	mv	a4,a5
     5c8:	03900793          	li	a5,57
     5cc:	fae7f6e3          	bgeu	a5,a4,578 <atoi+0x10>
  return n;
     5d0:	fec42783          	lw	a5,-20(s0)
}
     5d4:	853e                	mv	a0,a5
     5d6:	7422                	ld	s0,40(sp)
     5d8:	6145                	addi	sp,sp,48
     5da:	8082                	ret

00000000000005dc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     5dc:	7139                	addi	sp,sp,-64
     5de:	fc22                	sd	s0,56(sp)
     5e0:	0080                	addi	s0,sp,64
     5e2:	fca43c23          	sd	a0,-40(s0)
     5e6:	fcb43823          	sd	a1,-48(s0)
     5ea:	87b2                	mv	a5,a2
     5ec:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     5f0:	fd843783          	ld	a5,-40(s0)
     5f4:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     5f8:	fd043783          	ld	a5,-48(s0)
     5fc:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     600:	fe043703          	ld	a4,-32(s0)
     604:	fe843783          	ld	a5,-24(s0)
     608:	02e7fc63          	bgeu	a5,a4,640 <memmove+0x64>
    while(n-- > 0)
     60c:	a00d                	j	62e <memmove+0x52>
      *dst++ = *src++;
     60e:	fe043703          	ld	a4,-32(s0)
     612:	00170793          	addi	a5,a4,1
     616:	fef43023          	sd	a5,-32(s0)
     61a:	fe843783          	ld	a5,-24(s0)
     61e:	00178693          	addi	a3,a5,1
     622:	fed43423          	sd	a3,-24(s0)
     626:	00074703          	lbu	a4,0(a4)
     62a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     62e:	fcc42783          	lw	a5,-52(s0)
     632:	fff7871b          	addiw	a4,a5,-1
     636:	fce42623          	sw	a4,-52(s0)
     63a:	fcf04ae3          	bgtz	a5,60e <memmove+0x32>
     63e:	a891                	j	692 <memmove+0xb6>
  } else {
    dst += n;
     640:	fcc42783          	lw	a5,-52(s0)
     644:	fe843703          	ld	a4,-24(s0)
     648:	97ba                	add	a5,a5,a4
     64a:	fef43423          	sd	a5,-24(s0)
    src += n;
     64e:	fcc42783          	lw	a5,-52(s0)
     652:	fe043703          	ld	a4,-32(s0)
     656:	97ba                	add	a5,a5,a4
     658:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     65c:	a01d                	j	682 <memmove+0xa6>
      *--dst = *--src;
     65e:	fe043783          	ld	a5,-32(s0)
     662:	17fd                	addi	a5,a5,-1
     664:	fef43023          	sd	a5,-32(s0)
     668:	fe843783          	ld	a5,-24(s0)
     66c:	17fd                	addi	a5,a5,-1
     66e:	fef43423          	sd	a5,-24(s0)
     672:	fe043783          	ld	a5,-32(s0)
     676:	0007c703          	lbu	a4,0(a5)
     67a:	fe843783          	ld	a5,-24(s0)
     67e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     682:	fcc42783          	lw	a5,-52(s0)
     686:	fff7871b          	addiw	a4,a5,-1
     68a:	fce42623          	sw	a4,-52(s0)
     68e:	fcf048e3          	bgtz	a5,65e <memmove+0x82>
  }
  return vdst;
     692:	fd843783          	ld	a5,-40(s0)
}
     696:	853e                	mv	a0,a5
     698:	7462                	ld	s0,56(sp)
     69a:	6121                	addi	sp,sp,64
     69c:	8082                	ret

000000000000069e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     69e:	7139                	addi	sp,sp,-64
     6a0:	fc22                	sd	s0,56(sp)
     6a2:	0080                	addi	s0,sp,64
     6a4:	fca43c23          	sd	a0,-40(s0)
     6a8:	fcb43823          	sd	a1,-48(s0)
     6ac:	87b2                	mv	a5,a2
     6ae:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     6b2:	fd843783          	ld	a5,-40(s0)
     6b6:	fef43423          	sd	a5,-24(s0)
     6ba:	fd043783          	ld	a5,-48(s0)
     6be:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     6c2:	a0a1                	j	70a <memcmp+0x6c>
    if (*p1 != *p2) {
     6c4:	fe843783          	ld	a5,-24(s0)
     6c8:	0007c703          	lbu	a4,0(a5)
     6cc:	fe043783          	ld	a5,-32(s0)
     6d0:	0007c783          	lbu	a5,0(a5)
     6d4:	02f70163          	beq	a4,a5,6f6 <memcmp+0x58>
      return *p1 - *p2;
     6d8:	fe843783          	ld	a5,-24(s0)
     6dc:	0007c783          	lbu	a5,0(a5)
     6e0:	0007871b          	sext.w	a4,a5
     6e4:	fe043783          	ld	a5,-32(s0)
     6e8:	0007c783          	lbu	a5,0(a5)
     6ec:	2781                	sext.w	a5,a5
     6ee:	40f707bb          	subw	a5,a4,a5
     6f2:	2781                	sext.w	a5,a5
     6f4:	a01d                	j	71a <memcmp+0x7c>
    }
    p1++;
     6f6:	fe843783          	ld	a5,-24(s0)
     6fa:	0785                	addi	a5,a5,1
     6fc:	fef43423          	sd	a5,-24(s0)
    p2++;
     700:	fe043783          	ld	a5,-32(s0)
     704:	0785                	addi	a5,a5,1
     706:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     70a:	fcc42783          	lw	a5,-52(s0)
     70e:	fff7871b          	addiw	a4,a5,-1
     712:	fce42623          	sw	a4,-52(s0)
     716:	f7dd                	bnez	a5,6c4 <memcmp+0x26>
  }
  return 0;
     718:	4781                	li	a5,0
}
     71a:	853e                	mv	a0,a5
     71c:	7462                	ld	s0,56(sp)
     71e:	6121                	addi	sp,sp,64
     720:	8082                	ret

0000000000000722 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     722:	7179                	addi	sp,sp,-48
     724:	f406                	sd	ra,40(sp)
     726:	f022                	sd	s0,32(sp)
     728:	1800                	addi	s0,sp,48
     72a:	fea43423          	sd	a0,-24(s0)
     72e:	feb43023          	sd	a1,-32(s0)
     732:	87b2                	mv	a5,a2
     734:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     738:	fdc42783          	lw	a5,-36(s0)
     73c:	863e                	mv	a2,a5
     73e:	fe043583          	ld	a1,-32(s0)
     742:	fe843503          	ld	a0,-24(s0)
     746:	00000097          	auipc	ra,0x0
     74a:	e96080e7          	jalr	-362(ra) # 5dc <memmove>
     74e:	87aa                	mv	a5,a0
}
     750:	853e                	mv	a0,a5
     752:	70a2                	ld	ra,40(sp)
     754:	7402                	ld	s0,32(sp)
     756:	6145                	addi	sp,sp,48
     758:	8082                	ret

000000000000075a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     75a:	4885                	li	a7,1
 ecall
     75c:	00000073          	ecall
 ret
     760:	8082                	ret

0000000000000762 <exit>:
.global exit
exit:
 li a7, SYS_exit
     762:	4889                	li	a7,2
 ecall
     764:	00000073          	ecall
 ret
     768:	8082                	ret

000000000000076a <wait>:
.global wait
wait:
 li a7, SYS_wait
     76a:	488d                	li	a7,3
 ecall
     76c:	00000073          	ecall
 ret
     770:	8082                	ret

0000000000000772 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     772:	4891                	li	a7,4
 ecall
     774:	00000073          	ecall
 ret
     778:	8082                	ret

000000000000077a <read>:
.global read
read:
 li a7, SYS_read
     77a:	4895                	li	a7,5
 ecall
     77c:	00000073          	ecall
 ret
     780:	8082                	ret

0000000000000782 <write>:
.global write
write:
 li a7, SYS_write
     782:	48c1                	li	a7,16
 ecall
     784:	00000073          	ecall
 ret
     788:	8082                	ret

000000000000078a <close>:
.global close
close:
 li a7, SYS_close
     78a:	48d5                	li	a7,21
 ecall
     78c:	00000073          	ecall
 ret
     790:	8082                	ret

0000000000000792 <kill>:
.global kill
kill:
 li a7, SYS_kill
     792:	4899                	li	a7,6
 ecall
     794:	00000073          	ecall
 ret
     798:	8082                	ret

000000000000079a <exec>:
.global exec
exec:
 li a7, SYS_exec
     79a:	489d                	li	a7,7
 ecall
     79c:	00000073          	ecall
 ret
     7a0:	8082                	ret

00000000000007a2 <open>:
.global open
open:
 li a7, SYS_open
     7a2:	48bd                	li	a7,15
 ecall
     7a4:	00000073          	ecall
 ret
     7a8:	8082                	ret

00000000000007aa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     7aa:	48c5                	li	a7,17
 ecall
     7ac:	00000073          	ecall
 ret
     7b0:	8082                	ret

00000000000007b2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     7b2:	48c9                	li	a7,18
 ecall
     7b4:	00000073          	ecall
 ret
     7b8:	8082                	ret

00000000000007ba <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     7ba:	48a1                	li	a7,8
 ecall
     7bc:	00000073          	ecall
 ret
     7c0:	8082                	ret

00000000000007c2 <link>:
.global link
link:
 li a7, SYS_link
     7c2:	48cd                	li	a7,19
 ecall
     7c4:	00000073          	ecall
 ret
     7c8:	8082                	ret

00000000000007ca <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     7ca:	48d1                	li	a7,20
 ecall
     7cc:	00000073          	ecall
 ret
     7d0:	8082                	ret

00000000000007d2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     7d2:	48a5                	li	a7,9
 ecall
     7d4:	00000073          	ecall
 ret
     7d8:	8082                	ret

00000000000007da <dup>:
.global dup
dup:
 li a7, SYS_dup
     7da:	48a9                	li	a7,10
 ecall
     7dc:	00000073          	ecall
 ret
     7e0:	8082                	ret

00000000000007e2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     7e2:	48ad                	li	a7,11
 ecall
     7e4:	00000073          	ecall
 ret
     7e8:	8082                	ret

00000000000007ea <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     7ea:	48b1                	li	a7,12
 ecall
     7ec:	00000073          	ecall
 ret
     7f0:	8082                	ret

00000000000007f2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     7f2:	48b5                	li	a7,13
 ecall
     7f4:	00000073          	ecall
 ret
     7f8:	8082                	ret

00000000000007fa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     7fa:	48b9                	li	a7,14
 ecall
     7fc:	00000073          	ecall
 ret
     800:	8082                	ret

0000000000000802 <clone>:
.global clone
clone:
 li a7, SYS_clone
     802:	48d9                	li	a7,22
 ecall
     804:	00000073          	ecall
 ret
     808:	8082                	ret

000000000000080a <join>:
.global join
join:
 li a7, SYS_join
     80a:	48dd                	li	a7,23
 ecall
     80c:	00000073          	ecall
 ret
     810:	8082                	ret

0000000000000812 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     812:	1101                	addi	sp,sp,-32
     814:	ec06                	sd	ra,24(sp)
     816:	e822                	sd	s0,16(sp)
     818:	1000                	addi	s0,sp,32
     81a:	87aa                	mv	a5,a0
     81c:	872e                	mv	a4,a1
     81e:	fef42623          	sw	a5,-20(s0)
     822:	87ba                	mv	a5,a4
     824:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     828:	feb40713          	addi	a4,s0,-21
     82c:	fec42783          	lw	a5,-20(s0)
     830:	4605                	li	a2,1
     832:	85ba                	mv	a1,a4
     834:	853e                	mv	a0,a5
     836:	00000097          	auipc	ra,0x0
     83a:	f4c080e7          	jalr	-180(ra) # 782 <write>
}
     83e:	0001                	nop
     840:	60e2                	ld	ra,24(sp)
     842:	6442                	ld	s0,16(sp)
     844:	6105                	addi	sp,sp,32
     846:	8082                	ret

0000000000000848 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     848:	7139                	addi	sp,sp,-64
     84a:	fc06                	sd	ra,56(sp)
     84c:	f822                	sd	s0,48(sp)
     84e:	0080                	addi	s0,sp,64
     850:	87aa                	mv	a5,a0
     852:	8736                	mv	a4,a3
     854:	fcf42623          	sw	a5,-52(s0)
     858:	87ae                	mv	a5,a1
     85a:	fcf42423          	sw	a5,-56(s0)
     85e:	87b2                	mv	a5,a2
     860:	fcf42223          	sw	a5,-60(s0)
     864:	87ba                	mv	a5,a4
     866:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     86a:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     86e:	fc042783          	lw	a5,-64(s0)
     872:	2781                	sext.w	a5,a5
     874:	c38d                	beqz	a5,896 <printint+0x4e>
     876:	fc842783          	lw	a5,-56(s0)
     87a:	2781                	sext.w	a5,a5
     87c:	0007dd63          	bgez	a5,896 <printint+0x4e>
    neg = 1;
     880:	4785                	li	a5,1
     882:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     886:	fc842783          	lw	a5,-56(s0)
     88a:	40f007bb          	negw	a5,a5
     88e:	2781                	sext.w	a5,a5
     890:	fef42223          	sw	a5,-28(s0)
     894:	a029                	j	89e <printint+0x56>
  } else {
    x = xx;
     896:	fc842783          	lw	a5,-56(s0)
     89a:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     89e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     8a2:	fc442783          	lw	a5,-60(s0)
     8a6:	fe442703          	lw	a4,-28(s0)
     8aa:	02f777bb          	remuw	a5,a4,a5
     8ae:	0007861b          	sext.w	a2,a5
     8b2:	fec42783          	lw	a5,-20(s0)
     8b6:	0017871b          	addiw	a4,a5,1
     8ba:	fee42623          	sw	a4,-20(s0)
     8be:	00001697          	auipc	a3,0x1
     8c2:	9a268693          	addi	a3,a3,-1630 # 1260 <digits>
     8c6:	02061713          	slli	a4,a2,0x20
     8ca:	9301                	srli	a4,a4,0x20
     8cc:	9736                	add	a4,a4,a3
     8ce:	00074703          	lbu	a4,0(a4)
     8d2:	17c1                	addi	a5,a5,-16
     8d4:	97a2                	add	a5,a5,s0
     8d6:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     8da:	fc442783          	lw	a5,-60(s0)
     8de:	fe442703          	lw	a4,-28(s0)
     8e2:	02f757bb          	divuw	a5,a4,a5
     8e6:	fef42223          	sw	a5,-28(s0)
     8ea:	fe442783          	lw	a5,-28(s0)
     8ee:	2781                	sext.w	a5,a5
     8f0:	fbcd                	bnez	a5,8a2 <printint+0x5a>
  if(neg)
     8f2:	fe842783          	lw	a5,-24(s0)
     8f6:	2781                	sext.w	a5,a5
     8f8:	cf85                	beqz	a5,930 <printint+0xe8>
    buf[i++] = '-';
     8fa:	fec42783          	lw	a5,-20(s0)
     8fe:	0017871b          	addiw	a4,a5,1
     902:	fee42623          	sw	a4,-20(s0)
     906:	17c1                	addi	a5,a5,-16
     908:	97a2                	add	a5,a5,s0
     90a:	02d00713          	li	a4,45
     90e:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     912:	a839                	j	930 <printint+0xe8>
    putc(fd, buf[i]);
     914:	fec42783          	lw	a5,-20(s0)
     918:	17c1                	addi	a5,a5,-16
     91a:	97a2                	add	a5,a5,s0
     91c:	fe07c703          	lbu	a4,-32(a5)
     920:	fcc42783          	lw	a5,-52(s0)
     924:	85ba                	mv	a1,a4
     926:	853e                	mv	a0,a5
     928:	00000097          	auipc	ra,0x0
     92c:	eea080e7          	jalr	-278(ra) # 812 <putc>
  while(--i >= 0)
     930:	fec42783          	lw	a5,-20(s0)
     934:	37fd                	addiw	a5,a5,-1
     936:	fef42623          	sw	a5,-20(s0)
     93a:	fec42783          	lw	a5,-20(s0)
     93e:	2781                	sext.w	a5,a5
     940:	fc07dae3          	bgez	a5,914 <printint+0xcc>
}
     944:	0001                	nop
     946:	0001                	nop
     948:	70e2                	ld	ra,56(sp)
     94a:	7442                	ld	s0,48(sp)
     94c:	6121                	addi	sp,sp,64
     94e:	8082                	ret

0000000000000950 <printptr>:

static void
printptr(int fd, uint64 x) {
     950:	7179                	addi	sp,sp,-48
     952:	f406                	sd	ra,40(sp)
     954:	f022                	sd	s0,32(sp)
     956:	1800                	addi	s0,sp,48
     958:	87aa                	mv	a5,a0
     95a:	fcb43823          	sd	a1,-48(s0)
     95e:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     962:	fdc42783          	lw	a5,-36(s0)
     966:	03000593          	li	a1,48
     96a:	853e                	mv	a0,a5
     96c:	00000097          	auipc	ra,0x0
     970:	ea6080e7          	jalr	-346(ra) # 812 <putc>
  putc(fd, 'x');
     974:	fdc42783          	lw	a5,-36(s0)
     978:	07800593          	li	a1,120
     97c:	853e                	mv	a0,a5
     97e:	00000097          	auipc	ra,0x0
     982:	e94080e7          	jalr	-364(ra) # 812 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     986:	fe042623          	sw	zero,-20(s0)
     98a:	a82d                	j	9c4 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     98c:	fd043783          	ld	a5,-48(s0)
     990:	93f1                	srli	a5,a5,0x3c
     992:	00001717          	auipc	a4,0x1
     996:	8ce70713          	addi	a4,a4,-1842 # 1260 <digits>
     99a:	97ba                	add	a5,a5,a4
     99c:	0007c703          	lbu	a4,0(a5)
     9a0:	fdc42783          	lw	a5,-36(s0)
     9a4:	85ba                	mv	a1,a4
     9a6:	853e                	mv	a0,a5
     9a8:	00000097          	auipc	ra,0x0
     9ac:	e6a080e7          	jalr	-406(ra) # 812 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     9b0:	fec42783          	lw	a5,-20(s0)
     9b4:	2785                	addiw	a5,a5,1
     9b6:	fef42623          	sw	a5,-20(s0)
     9ba:	fd043783          	ld	a5,-48(s0)
     9be:	0792                	slli	a5,a5,0x4
     9c0:	fcf43823          	sd	a5,-48(s0)
     9c4:	fec42783          	lw	a5,-20(s0)
     9c8:	873e                	mv	a4,a5
     9ca:	47bd                	li	a5,15
     9cc:	fce7f0e3          	bgeu	a5,a4,98c <printptr+0x3c>
}
     9d0:	0001                	nop
     9d2:	0001                	nop
     9d4:	70a2                	ld	ra,40(sp)
     9d6:	7402                	ld	s0,32(sp)
     9d8:	6145                	addi	sp,sp,48
     9da:	8082                	ret

00000000000009dc <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     9dc:	715d                	addi	sp,sp,-80
     9de:	e486                	sd	ra,72(sp)
     9e0:	e0a2                	sd	s0,64(sp)
     9e2:	0880                	addi	s0,sp,80
     9e4:	87aa                	mv	a5,a0
     9e6:	fcb43023          	sd	a1,-64(s0)
     9ea:	fac43c23          	sd	a2,-72(s0)
     9ee:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     9f2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     9f6:	fe042223          	sw	zero,-28(s0)
     9fa:	a42d                	j	c24 <vprintf+0x248>
    c = fmt[i] & 0xff;
     9fc:	fe442783          	lw	a5,-28(s0)
     a00:	fc043703          	ld	a4,-64(s0)
     a04:	97ba                	add	a5,a5,a4
     a06:	0007c783          	lbu	a5,0(a5)
     a0a:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     a0e:	fe042783          	lw	a5,-32(s0)
     a12:	2781                	sext.w	a5,a5
     a14:	eb9d                	bnez	a5,a4a <vprintf+0x6e>
      if(c == '%'){
     a16:	fdc42783          	lw	a5,-36(s0)
     a1a:	0007871b          	sext.w	a4,a5
     a1e:	02500793          	li	a5,37
     a22:	00f71763          	bne	a4,a5,a30 <vprintf+0x54>
        state = '%';
     a26:	02500793          	li	a5,37
     a2a:	fef42023          	sw	a5,-32(s0)
     a2e:	a2f5                	j	c1a <vprintf+0x23e>
      } else {
        putc(fd, c);
     a30:	fdc42783          	lw	a5,-36(s0)
     a34:	0ff7f713          	zext.b	a4,a5
     a38:	fcc42783          	lw	a5,-52(s0)
     a3c:	85ba                	mv	a1,a4
     a3e:	853e                	mv	a0,a5
     a40:	00000097          	auipc	ra,0x0
     a44:	dd2080e7          	jalr	-558(ra) # 812 <putc>
     a48:	aac9                	j	c1a <vprintf+0x23e>
      }
    } else if(state == '%'){
     a4a:	fe042783          	lw	a5,-32(s0)
     a4e:	0007871b          	sext.w	a4,a5
     a52:	02500793          	li	a5,37
     a56:	1cf71263          	bne	a4,a5,c1a <vprintf+0x23e>
      if(c == 'd'){
     a5a:	fdc42783          	lw	a5,-36(s0)
     a5e:	0007871b          	sext.w	a4,a5
     a62:	06400793          	li	a5,100
     a66:	02f71463          	bne	a4,a5,a8e <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     a6a:	fb843783          	ld	a5,-72(s0)
     a6e:	00878713          	addi	a4,a5,8
     a72:	fae43c23          	sd	a4,-72(s0)
     a76:	4398                	lw	a4,0(a5)
     a78:	fcc42783          	lw	a5,-52(s0)
     a7c:	4685                	li	a3,1
     a7e:	4629                	li	a2,10
     a80:	85ba                	mv	a1,a4
     a82:	853e                	mv	a0,a5
     a84:	00000097          	auipc	ra,0x0
     a88:	dc4080e7          	jalr	-572(ra) # 848 <printint>
     a8c:	a269                	j	c16 <vprintf+0x23a>
      } else if(c == 'l') {
     a8e:	fdc42783          	lw	a5,-36(s0)
     a92:	0007871b          	sext.w	a4,a5
     a96:	06c00793          	li	a5,108
     a9a:	02f71663          	bne	a4,a5,ac6 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     a9e:	fb843783          	ld	a5,-72(s0)
     aa2:	00878713          	addi	a4,a5,8
     aa6:	fae43c23          	sd	a4,-72(s0)
     aaa:	639c                	ld	a5,0(a5)
     aac:	0007871b          	sext.w	a4,a5
     ab0:	fcc42783          	lw	a5,-52(s0)
     ab4:	4681                	li	a3,0
     ab6:	4629                	li	a2,10
     ab8:	85ba                	mv	a1,a4
     aba:	853e                	mv	a0,a5
     abc:	00000097          	auipc	ra,0x0
     ac0:	d8c080e7          	jalr	-628(ra) # 848 <printint>
     ac4:	aa89                	j	c16 <vprintf+0x23a>
      } else if(c == 'x') {
     ac6:	fdc42783          	lw	a5,-36(s0)
     aca:	0007871b          	sext.w	a4,a5
     ace:	07800793          	li	a5,120
     ad2:	02f71463          	bne	a4,a5,afa <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     ad6:	fb843783          	ld	a5,-72(s0)
     ada:	00878713          	addi	a4,a5,8
     ade:	fae43c23          	sd	a4,-72(s0)
     ae2:	4398                	lw	a4,0(a5)
     ae4:	fcc42783          	lw	a5,-52(s0)
     ae8:	4681                	li	a3,0
     aea:	4641                	li	a2,16
     aec:	85ba                	mv	a1,a4
     aee:	853e                	mv	a0,a5
     af0:	00000097          	auipc	ra,0x0
     af4:	d58080e7          	jalr	-680(ra) # 848 <printint>
     af8:	aa39                	j	c16 <vprintf+0x23a>
      } else if(c == 'p') {
     afa:	fdc42783          	lw	a5,-36(s0)
     afe:	0007871b          	sext.w	a4,a5
     b02:	07000793          	li	a5,112
     b06:	02f71263          	bne	a4,a5,b2a <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     b0a:	fb843783          	ld	a5,-72(s0)
     b0e:	00878713          	addi	a4,a5,8
     b12:	fae43c23          	sd	a4,-72(s0)
     b16:	6398                	ld	a4,0(a5)
     b18:	fcc42783          	lw	a5,-52(s0)
     b1c:	85ba                	mv	a1,a4
     b1e:	853e                	mv	a0,a5
     b20:	00000097          	auipc	ra,0x0
     b24:	e30080e7          	jalr	-464(ra) # 950 <printptr>
     b28:	a0fd                	j	c16 <vprintf+0x23a>
      } else if(c == 's'){
     b2a:	fdc42783          	lw	a5,-36(s0)
     b2e:	0007871b          	sext.w	a4,a5
     b32:	07300793          	li	a5,115
     b36:	04f71c63          	bne	a4,a5,b8e <vprintf+0x1b2>
        s = va_arg(ap, char*);
     b3a:	fb843783          	ld	a5,-72(s0)
     b3e:	00878713          	addi	a4,a5,8
     b42:	fae43c23          	sd	a4,-72(s0)
     b46:	639c                	ld	a5,0(a5)
     b48:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     b4c:	fe843783          	ld	a5,-24(s0)
     b50:	eb8d                	bnez	a5,b82 <vprintf+0x1a6>
          s = "(null)";
     b52:	00000797          	auipc	a5,0x0
     b56:	6b678793          	addi	a5,a5,1718 # 1208 <lock_init+0x144>
     b5a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     b5e:	a015                	j	b82 <vprintf+0x1a6>
          putc(fd, *s);
     b60:	fe843783          	ld	a5,-24(s0)
     b64:	0007c703          	lbu	a4,0(a5)
     b68:	fcc42783          	lw	a5,-52(s0)
     b6c:	85ba                	mv	a1,a4
     b6e:	853e                	mv	a0,a5
     b70:	00000097          	auipc	ra,0x0
     b74:	ca2080e7          	jalr	-862(ra) # 812 <putc>
          s++;
     b78:	fe843783          	ld	a5,-24(s0)
     b7c:	0785                	addi	a5,a5,1
     b7e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     b82:	fe843783          	ld	a5,-24(s0)
     b86:	0007c783          	lbu	a5,0(a5)
     b8a:	fbf9                	bnez	a5,b60 <vprintf+0x184>
     b8c:	a069                	j	c16 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     b8e:	fdc42783          	lw	a5,-36(s0)
     b92:	0007871b          	sext.w	a4,a5
     b96:	06300793          	li	a5,99
     b9a:	02f71463          	bne	a4,a5,bc2 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     b9e:	fb843783          	ld	a5,-72(s0)
     ba2:	00878713          	addi	a4,a5,8
     ba6:	fae43c23          	sd	a4,-72(s0)
     baa:	439c                	lw	a5,0(a5)
     bac:	0ff7f713          	zext.b	a4,a5
     bb0:	fcc42783          	lw	a5,-52(s0)
     bb4:	85ba                	mv	a1,a4
     bb6:	853e                	mv	a0,a5
     bb8:	00000097          	auipc	ra,0x0
     bbc:	c5a080e7          	jalr	-934(ra) # 812 <putc>
     bc0:	a899                	j	c16 <vprintf+0x23a>
      } else if(c == '%'){
     bc2:	fdc42783          	lw	a5,-36(s0)
     bc6:	0007871b          	sext.w	a4,a5
     bca:	02500793          	li	a5,37
     bce:	00f71f63          	bne	a4,a5,bec <vprintf+0x210>
        putc(fd, c);
     bd2:	fdc42783          	lw	a5,-36(s0)
     bd6:	0ff7f713          	zext.b	a4,a5
     bda:	fcc42783          	lw	a5,-52(s0)
     bde:	85ba                	mv	a1,a4
     be0:	853e                	mv	a0,a5
     be2:	00000097          	auipc	ra,0x0
     be6:	c30080e7          	jalr	-976(ra) # 812 <putc>
     bea:	a035                	j	c16 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     bec:	fcc42783          	lw	a5,-52(s0)
     bf0:	02500593          	li	a1,37
     bf4:	853e                	mv	a0,a5
     bf6:	00000097          	auipc	ra,0x0
     bfa:	c1c080e7          	jalr	-996(ra) # 812 <putc>
        putc(fd, c);
     bfe:	fdc42783          	lw	a5,-36(s0)
     c02:	0ff7f713          	zext.b	a4,a5
     c06:	fcc42783          	lw	a5,-52(s0)
     c0a:	85ba                	mv	a1,a4
     c0c:	853e                	mv	a0,a5
     c0e:	00000097          	auipc	ra,0x0
     c12:	c04080e7          	jalr	-1020(ra) # 812 <putc>
      }
      state = 0;
     c16:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     c1a:	fe442783          	lw	a5,-28(s0)
     c1e:	2785                	addiw	a5,a5,1
     c20:	fef42223          	sw	a5,-28(s0)
     c24:	fe442783          	lw	a5,-28(s0)
     c28:	fc043703          	ld	a4,-64(s0)
     c2c:	97ba                	add	a5,a5,a4
     c2e:	0007c783          	lbu	a5,0(a5)
     c32:	dc0795e3          	bnez	a5,9fc <vprintf+0x20>
    }
  }
}
     c36:	0001                	nop
     c38:	0001                	nop
     c3a:	60a6                	ld	ra,72(sp)
     c3c:	6406                	ld	s0,64(sp)
     c3e:	6161                	addi	sp,sp,80
     c40:	8082                	ret

0000000000000c42 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     c42:	7159                	addi	sp,sp,-112
     c44:	fc06                	sd	ra,56(sp)
     c46:	f822                	sd	s0,48(sp)
     c48:	0080                	addi	s0,sp,64
     c4a:	fcb43823          	sd	a1,-48(s0)
     c4e:	e010                	sd	a2,0(s0)
     c50:	e414                	sd	a3,8(s0)
     c52:	e818                	sd	a4,16(s0)
     c54:	ec1c                	sd	a5,24(s0)
     c56:	03043023          	sd	a6,32(s0)
     c5a:	03143423          	sd	a7,40(s0)
     c5e:	87aa                	mv	a5,a0
     c60:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     c64:	03040793          	addi	a5,s0,48
     c68:	fcf43423          	sd	a5,-56(s0)
     c6c:	fc843783          	ld	a5,-56(s0)
     c70:	fd078793          	addi	a5,a5,-48
     c74:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     c78:	fe843703          	ld	a4,-24(s0)
     c7c:	fdc42783          	lw	a5,-36(s0)
     c80:	863a                	mv	a2,a4
     c82:	fd043583          	ld	a1,-48(s0)
     c86:	853e                	mv	a0,a5
     c88:	00000097          	auipc	ra,0x0
     c8c:	d54080e7          	jalr	-684(ra) # 9dc <vprintf>
}
     c90:	0001                	nop
     c92:	70e2                	ld	ra,56(sp)
     c94:	7442                	ld	s0,48(sp)
     c96:	6165                	addi	sp,sp,112
     c98:	8082                	ret

0000000000000c9a <printf>:

void
printf(const char *fmt, ...)
{
     c9a:	7159                	addi	sp,sp,-112
     c9c:	f406                	sd	ra,40(sp)
     c9e:	f022                	sd	s0,32(sp)
     ca0:	1800                	addi	s0,sp,48
     ca2:	fca43c23          	sd	a0,-40(s0)
     ca6:	e40c                	sd	a1,8(s0)
     ca8:	e810                	sd	a2,16(s0)
     caa:	ec14                	sd	a3,24(s0)
     cac:	f018                	sd	a4,32(s0)
     cae:	f41c                	sd	a5,40(s0)
     cb0:	03043823          	sd	a6,48(s0)
     cb4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     cb8:	04040793          	addi	a5,s0,64
     cbc:	fcf43823          	sd	a5,-48(s0)
     cc0:	fd043783          	ld	a5,-48(s0)
     cc4:	fc878793          	addi	a5,a5,-56
     cc8:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     ccc:	fe843783          	ld	a5,-24(s0)
     cd0:	863e                	mv	a2,a5
     cd2:	fd843583          	ld	a1,-40(s0)
     cd6:	4505                	li	a0,1
     cd8:	00000097          	auipc	ra,0x0
     cdc:	d04080e7          	jalr	-764(ra) # 9dc <vprintf>
}
     ce0:	0001                	nop
     ce2:	70a2                	ld	ra,40(sp)
     ce4:	7402                	ld	s0,32(sp)
     ce6:	6165                	addi	sp,sp,112
     ce8:	8082                	ret

0000000000000cea <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     cea:	7179                	addi	sp,sp,-48
     cec:	f422                	sd	s0,40(sp)
     cee:	1800                	addi	s0,sp,48
     cf0:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     cf4:	fd843783          	ld	a5,-40(s0)
     cf8:	17c1                	addi	a5,a5,-16
     cfa:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     cfe:	00000797          	auipc	a5,0x0
     d02:	59278793          	addi	a5,a5,1426 # 1290 <freep>
     d06:	639c                	ld	a5,0(a5)
     d08:	fef43423          	sd	a5,-24(s0)
     d0c:	a815                	j	d40 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     d0e:	fe843783          	ld	a5,-24(s0)
     d12:	639c                	ld	a5,0(a5)
     d14:	fe843703          	ld	a4,-24(s0)
     d18:	00f76f63          	bltu	a4,a5,d36 <free+0x4c>
     d1c:	fe043703          	ld	a4,-32(s0)
     d20:	fe843783          	ld	a5,-24(s0)
     d24:	02e7eb63          	bltu	a5,a4,d5a <free+0x70>
     d28:	fe843783          	ld	a5,-24(s0)
     d2c:	639c                	ld	a5,0(a5)
     d2e:	fe043703          	ld	a4,-32(s0)
     d32:	02f76463          	bltu	a4,a5,d5a <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d36:	fe843783          	ld	a5,-24(s0)
     d3a:	639c                	ld	a5,0(a5)
     d3c:	fef43423          	sd	a5,-24(s0)
     d40:	fe043703          	ld	a4,-32(s0)
     d44:	fe843783          	ld	a5,-24(s0)
     d48:	fce7f3e3          	bgeu	a5,a4,d0e <free+0x24>
     d4c:	fe843783          	ld	a5,-24(s0)
     d50:	639c                	ld	a5,0(a5)
     d52:	fe043703          	ld	a4,-32(s0)
     d56:	faf77ce3          	bgeu	a4,a5,d0e <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     d5a:	fe043783          	ld	a5,-32(s0)
     d5e:	479c                	lw	a5,8(a5)
     d60:	1782                	slli	a5,a5,0x20
     d62:	9381                	srli	a5,a5,0x20
     d64:	0792                	slli	a5,a5,0x4
     d66:	fe043703          	ld	a4,-32(s0)
     d6a:	973e                	add	a4,a4,a5
     d6c:	fe843783          	ld	a5,-24(s0)
     d70:	639c                	ld	a5,0(a5)
     d72:	02f71763          	bne	a4,a5,da0 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     d76:	fe043783          	ld	a5,-32(s0)
     d7a:	4798                	lw	a4,8(a5)
     d7c:	fe843783          	ld	a5,-24(s0)
     d80:	639c                	ld	a5,0(a5)
     d82:	479c                	lw	a5,8(a5)
     d84:	9fb9                	addw	a5,a5,a4
     d86:	0007871b          	sext.w	a4,a5
     d8a:	fe043783          	ld	a5,-32(s0)
     d8e:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     d90:	fe843783          	ld	a5,-24(s0)
     d94:	639c                	ld	a5,0(a5)
     d96:	6398                	ld	a4,0(a5)
     d98:	fe043783          	ld	a5,-32(s0)
     d9c:	e398                	sd	a4,0(a5)
     d9e:	a039                	j	dac <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     da0:	fe843783          	ld	a5,-24(s0)
     da4:	6398                	ld	a4,0(a5)
     da6:	fe043783          	ld	a5,-32(s0)
     daa:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     dac:	fe843783          	ld	a5,-24(s0)
     db0:	479c                	lw	a5,8(a5)
     db2:	1782                	slli	a5,a5,0x20
     db4:	9381                	srli	a5,a5,0x20
     db6:	0792                	slli	a5,a5,0x4
     db8:	fe843703          	ld	a4,-24(s0)
     dbc:	97ba                	add	a5,a5,a4
     dbe:	fe043703          	ld	a4,-32(s0)
     dc2:	02f71563          	bne	a4,a5,dec <free+0x102>
    p->s.size += bp->s.size;
     dc6:	fe843783          	ld	a5,-24(s0)
     dca:	4798                	lw	a4,8(a5)
     dcc:	fe043783          	ld	a5,-32(s0)
     dd0:	479c                	lw	a5,8(a5)
     dd2:	9fb9                	addw	a5,a5,a4
     dd4:	0007871b          	sext.w	a4,a5
     dd8:	fe843783          	ld	a5,-24(s0)
     ddc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     dde:	fe043783          	ld	a5,-32(s0)
     de2:	6398                	ld	a4,0(a5)
     de4:	fe843783          	ld	a5,-24(s0)
     de8:	e398                	sd	a4,0(a5)
     dea:	a031                	j	df6 <free+0x10c>
  } else
    p->s.ptr = bp;
     dec:	fe843783          	ld	a5,-24(s0)
     df0:	fe043703          	ld	a4,-32(s0)
     df4:	e398                	sd	a4,0(a5)
  freep = p;
     df6:	00000797          	auipc	a5,0x0
     dfa:	49a78793          	addi	a5,a5,1178 # 1290 <freep>
     dfe:	fe843703          	ld	a4,-24(s0)
     e02:	e398                	sd	a4,0(a5)
}
     e04:	0001                	nop
     e06:	7422                	ld	s0,40(sp)
     e08:	6145                	addi	sp,sp,48
     e0a:	8082                	ret

0000000000000e0c <morecore>:

static Header*
morecore(uint nu)
{
     e0c:	7179                	addi	sp,sp,-48
     e0e:	f406                	sd	ra,40(sp)
     e10:	f022                	sd	s0,32(sp)
     e12:	1800                	addi	s0,sp,48
     e14:	87aa                	mv	a5,a0
     e16:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     e1a:	fdc42783          	lw	a5,-36(s0)
     e1e:	0007871b          	sext.w	a4,a5
     e22:	6785                	lui	a5,0x1
     e24:	00f77563          	bgeu	a4,a5,e2e <morecore+0x22>
    nu = 4096;
     e28:	6785                	lui	a5,0x1
     e2a:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     e2e:	fdc42783          	lw	a5,-36(s0)
     e32:	0047979b          	slliw	a5,a5,0x4
     e36:	2781                	sext.w	a5,a5
     e38:	2781                	sext.w	a5,a5
     e3a:	853e                	mv	a0,a5
     e3c:	00000097          	auipc	ra,0x0
     e40:	9ae080e7          	jalr	-1618(ra) # 7ea <sbrk>
     e44:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     e48:	fe843703          	ld	a4,-24(s0)
     e4c:	57fd                	li	a5,-1
     e4e:	00f71463          	bne	a4,a5,e56 <morecore+0x4a>
    return 0;
     e52:	4781                	li	a5,0
     e54:	a03d                	j	e82 <morecore+0x76>
  hp = (Header*)p;
     e56:	fe843783          	ld	a5,-24(s0)
     e5a:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     e5e:	fe043783          	ld	a5,-32(s0)
     e62:	fdc42703          	lw	a4,-36(s0)
     e66:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     e68:	fe043783          	ld	a5,-32(s0)
     e6c:	07c1                	addi	a5,a5,16
     e6e:	853e                	mv	a0,a5
     e70:	00000097          	auipc	ra,0x0
     e74:	e7a080e7          	jalr	-390(ra) # cea <free>
  return freep;
     e78:	00000797          	auipc	a5,0x0
     e7c:	41878793          	addi	a5,a5,1048 # 1290 <freep>
     e80:	639c                	ld	a5,0(a5)
}
     e82:	853e                	mv	a0,a5
     e84:	70a2                	ld	ra,40(sp)
     e86:	7402                	ld	s0,32(sp)
     e88:	6145                	addi	sp,sp,48
     e8a:	8082                	ret

0000000000000e8c <malloc>:

void*
malloc(uint nbytes)
{
     e8c:	7139                	addi	sp,sp,-64
     e8e:	fc06                	sd	ra,56(sp)
     e90:	f822                	sd	s0,48(sp)
     e92:	0080                	addi	s0,sp,64
     e94:	87aa                	mv	a5,a0
     e96:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     e9a:	fcc46783          	lwu	a5,-52(s0)
     e9e:	07bd                	addi	a5,a5,15
     ea0:	8391                	srli	a5,a5,0x4
     ea2:	2781                	sext.w	a5,a5
     ea4:	2785                	addiw	a5,a5,1
     ea6:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     eaa:	00000797          	auipc	a5,0x0
     eae:	3e678793          	addi	a5,a5,998 # 1290 <freep>
     eb2:	639c                	ld	a5,0(a5)
     eb4:	fef43023          	sd	a5,-32(s0)
     eb8:	fe043783          	ld	a5,-32(s0)
     ebc:	ef95                	bnez	a5,ef8 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     ebe:	00000797          	auipc	a5,0x0
     ec2:	3c278793          	addi	a5,a5,962 # 1280 <base>
     ec6:	fef43023          	sd	a5,-32(s0)
     eca:	00000797          	auipc	a5,0x0
     ece:	3c678793          	addi	a5,a5,966 # 1290 <freep>
     ed2:	fe043703          	ld	a4,-32(s0)
     ed6:	e398                	sd	a4,0(a5)
     ed8:	00000797          	auipc	a5,0x0
     edc:	3b878793          	addi	a5,a5,952 # 1290 <freep>
     ee0:	6398                	ld	a4,0(a5)
     ee2:	00000797          	auipc	a5,0x0
     ee6:	39e78793          	addi	a5,a5,926 # 1280 <base>
     eea:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     eec:	00000797          	auipc	a5,0x0
     ef0:	39478793          	addi	a5,a5,916 # 1280 <base>
     ef4:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     ef8:	fe043783          	ld	a5,-32(s0)
     efc:	639c                	ld	a5,0(a5)
     efe:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     f02:	fe843783          	ld	a5,-24(s0)
     f06:	4798                	lw	a4,8(a5)
     f08:	fdc42783          	lw	a5,-36(s0)
     f0c:	2781                	sext.w	a5,a5
     f0e:	06f76763          	bltu	a4,a5,f7c <malloc+0xf0>
      if(p->s.size == nunits)
     f12:	fe843783          	ld	a5,-24(s0)
     f16:	4798                	lw	a4,8(a5)
     f18:	fdc42783          	lw	a5,-36(s0)
     f1c:	2781                	sext.w	a5,a5
     f1e:	00e79963          	bne	a5,a4,f30 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     f22:	fe843783          	ld	a5,-24(s0)
     f26:	6398                	ld	a4,0(a5)
     f28:	fe043783          	ld	a5,-32(s0)
     f2c:	e398                	sd	a4,0(a5)
     f2e:	a825                	j	f66 <malloc+0xda>
      else {
        p->s.size -= nunits;
     f30:	fe843783          	ld	a5,-24(s0)
     f34:	479c                	lw	a5,8(a5)
     f36:	fdc42703          	lw	a4,-36(s0)
     f3a:	9f99                	subw	a5,a5,a4
     f3c:	0007871b          	sext.w	a4,a5
     f40:	fe843783          	ld	a5,-24(s0)
     f44:	c798                	sw	a4,8(a5)
        p += p->s.size;
     f46:	fe843783          	ld	a5,-24(s0)
     f4a:	479c                	lw	a5,8(a5)
     f4c:	1782                	slli	a5,a5,0x20
     f4e:	9381                	srli	a5,a5,0x20
     f50:	0792                	slli	a5,a5,0x4
     f52:	fe843703          	ld	a4,-24(s0)
     f56:	97ba                	add	a5,a5,a4
     f58:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     f5c:	fe843783          	ld	a5,-24(s0)
     f60:	fdc42703          	lw	a4,-36(s0)
     f64:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     f66:	00000797          	auipc	a5,0x0
     f6a:	32a78793          	addi	a5,a5,810 # 1290 <freep>
     f6e:	fe043703          	ld	a4,-32(s0)
     f72:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     f74:	fe843783          	ld	a5,-24(s0)
     f78:	07c1                	addi	a5,a5,16
     f7a:	a091                	j	fbe <malloc+0x132>
    }
    if(p == freep)
     f7c:	00000797          	auipc	a5,0x0
     f80:	31478793          	addi	a5,a5,788 # 1290 <freep>
     f84:	639c                	ld	a5,0(a5)
     f86:	fe843703          	ld	a4,-24(s0)
     f8a:	02f71063          	bne	a4,a5,faa <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
     f8e:	fdc42783          	lw	a5,-36(s0)
     f92:	853e                	mv	a0,a5
     f94:	00000097          	auipc	ra,0x0
     f98:	e78080e7          	jalr	-392(ra) # e0c <morecore>
     f9c:	fea43423          	sd	a0,-24(s0)
     fa0:	fe843783          	ld	a5,-24(s0)
     fa4:	e399                	bnez	a5,faa <malloc+0x11e>
        return 0;
     fa6:	4781                	li	a5,0
     fa8:	a819                	j	fbe <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     faa:	fe843783          	ld	a5,-24(s0)
     fae:	fef43023          	sd	a5,-32(s0)
     fb2:	fe843783          	ld	a5,-24(s0)
     fb6:	639c                	ld	a5,0(a5)
     fb8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     fbc:	b799                	j	f02 <malloc+0x76>
  }
}
     fbe:	853e                	mv	a0,a5
     fc0:	70e2                	ld	ra,56(sp)
     fc2:	7442                	ld	s0,48(sp)
     fc4:	6121                	addi	sp,sp,64
     fc6:	8082                	ret

0000000000000fc8 <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
     fc8:	7179                	addi	sp,sp,-48
     fca:	f406                	sd	ra,40(sp)
     fcc:	f022                	sd	s0,32(sp)
     fce:	1800                	addi	s0,sp,48
     fd0:	fca43c23          	sd	a0,-40(s0)
     fd4:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
     fd8:	6505                	lui	a0,0x1
     fda:	00000097          	auipc	ra,0x0
     fde:	eb2080e7          	jalr	-334(ra) # e8c <malloc>
     fe2:	fea43423          	sd	a0,-24(s0)
     fe6:	fe843783          	ld	a5,-24(s0)
     fea:	e38d                	bnez	a5,100c <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
     fec:	00000517          	auipc	a0,0x0
     ff0:	22450513          	addi	a0,a0,548 # 1210 <lock_init+0x14c>
     ff4:	00000097          	auipc	ra,0x0
     ff8:	ca6080e7          	jalr	-858(ra) # c9a <printf>
        free(stack);
     ffc:	fe843503          	ld	a0,-24(s0)
    1000:	00000097          	auipc	ra,0x0
    1004:	cea080e7          	jalr	-790(ra) # cea <free>
        return -1;
    1008:	57fd                	li	a5,-1
    100a:	a099                	j	1050 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
    100c:	fe843783          	ld	a5,-24(s0)
    1010:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
    1014:	fe043703          	ld	a4,-32(s0)
    1018:	6785                	lui	a5,0x1
    101a:	17fd                	addi	a5,a5,-1
    101c:	8ff9                	and	a5,a5,a4
    101e:	cf91                	beqz	a5,103a <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
    1020:	fe043703          	ld	a4,-32(s0)
    1024:	6785                	lui	a5,0x1
    1026:	17fd                	addi	a5,a5,-1
    1028:	8ff9                	and	a5,a5,a4
    102a:	6705                	lui	a4,0x1
    102c:	40f707b3          	sub	a5,a4,a5
    1030:	fe843703          	ld	a4,-24(s0)
    1034:	97ba                	add	a5,a5,a4
    1036:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
    103a:	fe843603          	ld	a2,-24(s0)
    103e:	fd043583          	ld	a1,-48(s0)
    1042:	fd843503          	ld	a0,-40(s0)
    1046:	fffff097          	auipc	ra,0xfffff
    104a:	7bc080e7          	jalr	1980(ra) # 802 <clone>
    104e:	87aa                	mv	a5,a0
}
    1050:	853e                	mv	a0,a5
    1052:	70a2                	ld	ra,40(sp)
    1054:	7402                	ld	s0,32(sp)
    1056:	6145                	addi	sp,sp,48
    1058:	8082                	ret

000000000000105a <thread_join>:


int thread_join()
{
    105a:	1101                	addi	sp,sp,-32
    105c:	ec06                	sd	ra,24(sp)
    105e:	e822                	sd	s0,16(sp)
    1060:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
    1062:	fe040793          	addi	a5,s0,-32
    1066:	853e                	mv	a0,a5
    1068:	fffff097          	auipc	ra,0xfffff
    106c:	7a2080e7          	jalr	1954(ra) # 80a <join>
    1070:	87aa                	mv	a5,a0
    1072:	fef42623          	sw	a5,-20(s0)
    1076:	fec42783          	lw	a5,-20(s0)
    107a:	0007871b          	sext.w	a4,a5
    107e:	57fd                	li	a5,-1
    1080:	00f70963          	beq	a4,a5,1092 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
    1084:	fe043783          	ld	a5,-32(s0)
    1088:	853e                	mv	a0,a5
    108a:	00000097          	auipc	ra,0x0
    108e:	c60080e7          	jalr	-928(ra) # cea <free>
    } 

    return child_tid;
    1092:	fec42783          	lw	a5,-20(s0)
}
    1096:	853e                	mv	a0,a5
    1098:	60e2                	ld	ra,24(sp)
    109a:	6442                	ld	s0,16(sp)
    109c:	6105                	addi	sp,sp,32
    109e:	8082                	ret

00000000000010a0 <lock_acquire>:


void lock_acquire (lock_t *)
{
    10a0:	1101                	addi	sp,sp,-32
    10a2:	ec22                	sd	s0,24(sp)
    10a4:	1000                	addi	s0,sp,32
    10a6:	fea43423          	sd	a0,-24(s0)

}
    10aa:	0001                	nop
    10ac:	6462                	ld	s0,24(sp)
    10ae:	6105                	addi	sp,sp,32
    10b0:	8082                	ret

00000000000010b2 <lock_release>:

void lock_release (lock_t *)
{
    10b2:	1101                	addi	sp,sp,-32
    10b4:	ec22                	sd	s0,24(sp)
    10b6:	1000                	addi	s0,sp,32
    10b8:	fea43423          	sd	a0,-24(s0)
    
}
    10bc:	0001                	nop
    10be:	6462                	ld	s0,24(sp)
    10c0:	6105                	addi	sp,sp,32
    10c2:	8082                	ret

00000000000010c4 <lock_init>:

void lock_init (lock_t *)
{
    10c4:	1101                	addi	sp,sp,-32
    10c6:	ec22                	sd	s0,24(sp)
    10c8:	1000                	addi	s0,sp,32
    10ca:	fea43423          	sd	a0,-24(s0)
    
}
    10ce:	0001                	nop
    10d0:	6462                	ld	s0,24(sp)
    10d2:	6105                	addi	sp,sp,32
    10d4:	8082                	ret
