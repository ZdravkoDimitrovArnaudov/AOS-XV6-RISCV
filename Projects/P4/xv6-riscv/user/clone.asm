
user/_clone:     file format elf64-littleriscv


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
   ppid = getpid();//recoge pid del proceso
      12:	00000097          	auipc	ra,0x0
      16:	712080e7          	jalr	1810(ra) # 724 <getpid>
      1a:	87aa                	mv	a5,a0
      1c:	873e                	mv	a4,a5
      1e:	00001797          	auipc	a5,0x1
      22:	10278793          	addi	a5,a5,258 # 1120 <ppid>
      26:	c398                	sw	a4,0(a5)
   void *stack = malloc(PGSIZE*2);//reserva dos páginas para el malloc
      28:	6509                	lui	a0,0x2
      2a:	00001097          	auipc	ra,0x1
      2e:	da4080e7          	jalr	-604(ra) # dce <malloc>
      32:	fea43423          	sd	a0,-24(s0)
   assert(stack != NULL); //comprueba que se haya podido crear bien memoria dinámica
      36:	fe843783          	ld	a5,-24(s0)
      3a:	e3ad                	bnez	a5,9c <main+0x9c>
      3c:	4671                	li	a2,28
      3e:	00001597          	auipc	a1,0x1
      42:	ff258593          	addi	a1,a1,-14 # 1030 <lock_init+0x1c>
      46:	00001517          	auipc	a0,0x1
      4a:	ffa50513          	addi	a0,a0,-6 # 1040 <lock_init+0x2c>
      4e:	00001097          	auipc	ra,0x1
      52:	b8e080e7          	jalr	-1138(ra) # bdc <printf>
      56:	00001597          	auipc	a1,0x1
      5a:	ff258593          	addi	a1,a1,-14 # 1048 <lock_init+0x34>
      5e:	00001517          	auipc	a0,0x1
      62:	ffa50513          	addi	a0,a0,-6 # 1058 <lock_init+0x44>
      66:	00001097          	auipc	ra,0x1
      6a:	b76080e7          	jalr	-1162(ra) # bdc <printf>
      6e:	00001517          	auipc	a0,0x1
      72:	00250513          	addi	a0,a0,2 # 1070 <lock_init+0x5c>
      76:	00001097          	auipc	ra,0x1
      7a:	b66080e7          	jalr	-1178(ra) # bdc <printf>
      7e:	00001797          	auipc	a5,0x1
      82:	0a278793          	addi	a5,a5,162 # 1120 <ppid>
      86:	439c                	lw	a5,0(a5)
      88:	853e                	mv	a0,a5
      8a:	00000097          	auipc	ra,0x0
      8e:	64a080e7          	jalr	1610(ra) # 6d4 <kill>
      92:	4501                	li	a0,0
      94:	00000097          	auipc	ra,0x0
      98:	610080e7          	jalr	1552(ra) # 6a4 <exit>
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
      cc:	0b250513          	addi	a0,a0,178 # 17a <worker>
      d0:	00000097          	auipc	ra,0x0
      d4:	674080e7          	jalr	1652(ra) # 744 <clone>
      d8:	87aa                	mv	a5,a0
      da:	fef42223          	sw	a5,-28(s0)
   assert(clone_pid > 0); //comprueba que no haya fallado el clone
      de:	fe442783          	lw	a5,-28(s0)
      e2:	2781                	sext.w	a5,a5
      e4:	06f04363          	bgtz	a5,14a <main+0x14a>
      e8:	02100613          	li	a2,33
      ec:	00001597          	auipc	a1,0x1
      f0:	f4458593          	addi	a1,a1,-188 # 1030 <lock_init+0x1c>
      f4:	00001517          	auipc	a0,0x1
      f8:	f4c50513          	addi	a0,a0,-180 # 1040 <lock_init+0x2c>
      fc:	00001097          	auipc	ra,0x1
     100:	ae0080e7          	jalr	-1312(ra) # bdc <printf>
     104:	00001597          	auipc	a1,0x1
     108:	f7c58593          	addi	a1,a1,-132 # 1080 <lock_init+0x6c>
     10c:	00001517          	auipc	a0,0x1
     110:	f4c50513          	addi	a0,a0,-180 # 1058 <lock_init+0x44>
     114:	00001097          	auipc	ra,0x1
     118:	ac8080e7          	jalr	-1336(ra) # bdc <printf>
     11c:	00001517          	auipc	a0,0x1
     120:	f5450513          	addi	a0,a0,-172 # 1070 <lock_init+0x5c>
     124:	00001097          	auipc	ra,0x1
     128:	ab8080e7          	jalr	-1352(ra) # bdc <printf>
     12c:	00001797          	auipc	a5,0x1
     130:	ff478793          	addi	a5,a5,-12 # 1120 <ppid>
     134:	439c                	lw	a5,0(a5)
     136:	853e                	mv	a0,a5
     138:	00000097          	auipc	ra,0x0
     13c:	59c080e7          	jalr	1436(ra) # 6d4 <kill>
     140:	4501                	li	a0,0
     142:	00000097          	auipc	ra,0x0
     146:	562080e7          	jalr	1378(ra) # 6a4 <exit>
   while(global != 5); //comprueba si el thread ha modificado correctamente la variable global a 5 y no es otro valor distinto.
     14a:	0001                	nop
     14c:	00001797          	auipc	a5,0x1
     150:	fd078793          	addi	a5,a5,-48 # 111c <global>
     154:	439c                	lw	a5,0(a5)
     156:	2781                	sext.w	a5,a5
     158:	873e                	mv	a4,a5
     15a:	4795                	li	a5,5
     15c:	fef718e3          	bne	a4,a5,14c <main+0x14c>
   printf("TEST PASSED\n");
     160:	00001517          	auipc	a0,0x1
     164:	f3050513          	addi	a0,a0,-208 # 1090 <lock_init+0x7c>
     168:	00001097          	auipc	ra,0x1
     16c:	a74080e7          	jalr	-1420(ra) # bdc <printf>
   exit(0);
     170:	4501                	li	a0,0
     172:	00000097          	auipc	ra,0x0
     176:	532080e7          	jalr	1330(ra) # 6a4 <exit>

000000000000017a <worker>:
}

void
worker(void *arg_ptr) {
     17a:	1101                	addi	sp,sp,-32
     17c:	ec06                	sd	ra,24(sp)
     17e:	e822                	sd	s0,16(sp)
     180:	1000                	addi	s0,sp,32
     182:	fea43423          	sd	a0,-24(s0)
   assert(global == 1);
     186:	00001797          	auipc	a5,0x1
     18a:	f9678793          	addi	a5,a5,-106 # 111c <global>
     18e:	439c                	lw	a5,0(a5)
     190:	2781                	sext.w	a5,a5
     192:	873e                	mv	a4,a5
     194:	4785                	li	a5,1
     196:	06f70363          	beq	a4,a5,1fc <worker+0x82>
     19a:	02900613          	li	a2,41
     19e:	00001597          	auipc	a1,0x1
     1a2:	e9258593          	addi	a1,a1,-366 # 1030 <lock_init+0x1c>
     1a6:	00001517          	auipc	a0,0x1
     1aa:	e9a50513          	addi	a0,a0,-358 # 1040 <lock_init+0x2c>
     1ae:	00001097          	auipc	ra,0x1
     1b2:	a2e080e7          	jalr	-1490(ra) # bdc <printf>
     1b6:	00001597          	auipc	a1,0x1
     1ba:	eea58593          	addi	a1,a1,-278 # 10a0 <lock_init+0x8c>
     1be:	00001517          	auipc	a0,0x1
     1c2:	e9a50513          	addi	a0,a0,-358 # 1058 <lock_init+0x44>
     1c6:	00001097          	auipc	ra,0x1
     1ca:	a16080e7          	jalr	-1514(ra) # bdc <printf>
     1ce:	00001517          	auipc	a0,0x1
     1d2:	ea250513          	addi	a0,a0,-350 # 1070 <lock_init+0x5c>
     1d6:	00001097          	auipc	ra,0x1
     1da:	a06080e7          	jalr	-1530(ra) # bdc <printf>
     1de:	00001797          	auipc	a5,0x1
     1e2:	f4278793          	addi	a5,a5,-190 # 1120 <ppid>
     1e6:	439c                	lw	a5,0(a5)
     1e8:	853e                	mv	a0,a5
     1ea:	00000097          	auipc	ra,0x0
     1ee:	4ea080e7          	jalr	1258(ra) # 6d4 <kill>
     1f2:	4501                	li	a0,0
     1f4:	00000097          	auipc	ra,0x0
     1f8:	4b0080e7          	jalr	1200(ra) # 6a4 <exit>
   global = 5;
     1fc:	00001797          	auipc	a5,0x1
     200:	f2078793          	addi	a5,a5,-224 # 111c <global>
     204:	4715                	li	a4,5
     206:	c398                	sw	a4,0(a5)
   exit(0);
     208:	4501                	li	a0,0
     20a:	00000097          	auipc	ra,0x0
     20e:	49a080e7          	jalr	1178(ra) # 6a4 <exit>

0000000000000212 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     212:	7179                	addi	sp,sp,-48
     214:	f422                	sd	s0,40(sp)
     216:	1800                	addi	s0,sp,48
     218:	fca43c23          	sd	a0,-40(s0)
     21c:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     220:	fd843783          	ld	a5,-40(s0)
     224:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     228:	0001                	nop
     22a:	fd043703          	ld	a4,-48(s0)
     22e:	00170793          	addi	a5,a4,1 # 1001 <lock_release+0x9>
     232:	fcf43823          	sd	a5,-48(s0)
     236:	fd843783          	ld	a5,-40(s0)
     23a:	00178693          	addi	a3,a5,1
     23e:	fcd43c23          	sd	a3,-40(s0)
     242:	00074703          	lbu	a4,0(a4)
     246:	00e78023          	sb	a4,0(a5)
     24a:	0007c783          	lbu	a5,0(a5)
     24e:	fff1                	bnez	a5,22a <strcpy+0x18>
    ;
  return os;
     250:	fe843783          	ld	a5,-24(s0)
}
     254:	853e                	mv	a0,a5
     256:	7422                	ld	s0,40(sp)
     258:	6145                	addi	sp,sp,48
     25a:	8082                	ret

000000000000025c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     25c:	1101                	addi	sp,sp,-32
     25e:	ec22                	sd	s0,24(sp)
     260:	1000                	addi	s0,sp,32
     262:	fea43423          	sd	a0,-24(s0)
     266:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     26a:	a819                	j	280 <strcmp+0x24>
    p++, q++;
     26c:	fe843783          	ld	a5,-24(s0)
     270:	0785                	addi	a5,a5,1
     272:	fef43423          	sd	a5,-24(s0)
     276:	fe043783          	ld	a5,-32(s0)
     27a:	0785                	addi	a5,a5,1
     27c:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     280:	fe843783          	ld	a5,-24(s0)
     284:	0007c783          	lbu	a5,0(a5)
     288:	cb99                	beqz	a5,29e <strcmp+0x42>
     28a:	fe843783          	ld	a5,-24(s0)
     28e:	0007c703          	lbu	a4,0(a5)
     292:	fe043783          	ld	a5,-32(s0)
     296:	0007c783          	lbu	a5,0(a5)
     29a:	fcf709e3          	beq	a4,a5,26c <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     29e:	fe843783          	ld	a5,-24(s0)
     2a2:	0007c783          	lbu	a5,0(a5)
     2a6:	0007871b          	sext.w	a4,a5
     2aa:	fe043783          	ld	a5,-32(s0)
     2ae:	0007c783          	lbu	a5,0(a5)
     2b2:	2781                	sext.w	a5,a5
     2b4:	40f707bb          	subw	a5,a4,a5
     2b8:	2781                	sext.w	a5,a5
}
     2ba:	853e                	mv	a0,a5
     2bc:	6462                	ld	s0,24(sp)
     2be:	6105                	addi	sp,sp,32
     2c0:	8082                	ret

00000000000002c2 <strlen>:

uint
strlen(const char *s)
{
     2c2:	7179                	addi	sp,sp,-48
     2c4:	f422                	sd	s0,40(sp)
     2c6:	1800                	addi	s0,sp,48
     2c8:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     2cc:	fe042623          	sw	zero,-20(s0)
     2d0:	a031                	j	2dc <strlen+0x1a>
     2d2:	fec42783          	lw	a5,-20(s0)
     2d6:	2785                	addiw	a5,a5,1
     2d8:	fef42623          	sw	a5,-20(s0)
     2dc:	fec42783          	lw	a5,-20(s0)
     2e0:	fd843703          	ld	a4,-40(s0)
     2e4:	97ba                	add	a5,a5,a4
     2e6:	0007c783          	lbu	a5,0(a5)
     2ea:	f7e5                	bnez	a5,2d2 <strlen+0x10>
    ;
  return n;
     2ec:	fec42783          	lw	a5,-20(s0)
}
     2f0:	853e                	mv	a0,a5
     2f2:	7422                	ld	s0,40(sp)
     2f4:	6145                	addi	sp,sp,48
     2f6:	8082                	ret

00000000000002f8 <memset>:

void*
memset(void *dst, int c, uint n)
{
     2f8:	7179                	addi	sp,sp,-48
     2fa:	f422                	sd	s0,40(sp)
     2fc:	1800                	addi	s0,sp,48
     2fe:	fca43c23          	sd	a0,-40(s0)
     302:	87ae                	mv	a5,a1
     304:	8732                	mv	a4,a2
     306:	fcf42a23          	sw	a5,-44(s0)
     30a:	87ba                	mv	a5,a4
     30c:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     310:	fd843783          	ld	a5,-40(s0)
     314:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     318:	fe042623          	sw	zero,-20(s0)
     31c:	a00d                	j	33e <memset+0x46>
    cdst[i] = c;
     31e:	fec42783          	lw	a5,-20(s0)
     322:	fe043703          	ld	a4,-32(s0)
     326:	97ba                	add	a5,a5,a4
     328:	fd442703          	lw	a4,-44(s0)
     32c:	0ff77713          	zext.b	a4,a4
     330:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     334:	fec42783          	lw	a5,-20(s0)
     338:	2785                	addiw	a5,a5,1
     33a:	fef42623          	sw	a5,-20(s0)
     33e:	fec42703          	lw	a4,-20(s0)
     342:	fd042783          	lw	a5,-48(s0)
     346:	2781                	sext.w	a5,a5
     348:	fcf76be3          	bltu	a4,a5,31e <memset+0x26>
  }
  return dst;
     34c:	fd843783          	ld	a5,-40(s0)
}
     350:	853e                	mv	a0,a5
     352:	7422                	ld	s0,40(sp)
     354:	6145                	addi	sp,sp,48
     356:	8082                	ret

0000000000000358 <strchr>:

char*
strchr(const char *s, char c)
{
     358:	1101                	addi	sp,sp,-32
     35a:	ec22                	sd	s0,24(sp)
     35c:	1000                	addi	s0,sp,32
     35e:	fea43423          	sd	a0,-24(s0)
     362:	87ae                	mv	a5,a1
     364:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     368:	a01d                	j	38e <strchr+0x36>
    if(*s == c)
     36a:	fe843783          	ld	a5,-24(s0)
     36e:	0007c703          	lbu	a4,0(a5)
     372:	fe744783          	lbu	a5,-25(s0)
     376:	0ff7f793          	zext.b	a5,a5
     37a:	00e79563          	bne	a5,a4,384 <strchr+0x2c>
      return (char*)s;
     37e:	fe843783          	ld	a5,-24(s0)
     382:	a821                	j	39a <strchr+0x42>
  for(; *s; s++)
     384:	fe843783          	ld	a5,-24(s0)
     388:	0785                	addi	a5,a5,1
     38a:	fef43423          	sd	a5,-24(s0)
     38e:	fe843783          	ld	a5,-24(s0)
     392:	0007c783          	lbu	a5,0(a5)
     396:	fbf1                	bnez	a5,36a <strchr+0x12>
  return 0;
     398:	4781                	li	a5,0
}
     39a:	853e                	mv	a0,a5
     39c:	6462                	ld	s0,24(sp)
     39e:	6105                	addi	sp,sp,32
     3a0:	8082                	ret

00000000000003a2 <gets>:

char*
gets(char *buf, int max)
{
     3a2:	7179                	addi	sp,sp,-48
     3a4:	f406                	sd	ra,40(sp)
     3a6:	f022                	sd	s0,32(sp)
     3a8:	1800                	addi	s0,sp,48
     3aa:	fca43c23          	sd	a0,-40(s0)
     3ae:	87ae                	mv	a5,a1
     3b0:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     3b4:	fe042623          	sw	zero,-20(s0)
     3b8:	a8a1                	j	410 <gets+0x6e>
    cc = read(0, &c, 1);
     3ba:	fe740793          	addi	a5,s0,-25
     3be:	4605                	li	a2,1
     3c0:	85be                	mv	a1,a5
     3c2:	4501                	li	a0,0
     3c4:	00000097          	auipc	ra,0x0
     3c8:	2f8080e7          	jalr	760(ra) # 6bc <read>
     3cc:	87aa                	mv	a5,a0
     3ce:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     3d2:	fe842783          	lw	a5,-24(s0)
     3d6:	2781                	sext.w	a5,a5
     3d8:	04f05763          	blez	a5,426 <gets+0x84>
      break;
    buf[i++] = c;
     3dc:	fec42783          	lw	a5,-20(s0)
     3e0:	0017871b          	addiw	a4,a5,1
     3e4:	fee42623          	sw	a4,-20(s0)
     3e8:	873e                	mv	a4,a5
     3ea:	fd843783          	ld	a5,-40(s0)
     3ee:	97ba                	add	a5,a5,a4
     3f0:	fe744703          	lbu	a4,-25(s0)
     3f4:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     3f8:	fe744783          	lbu	a5,-25(s0)
     3fc:	873e                	mv	a4,a5
     3fe:	47a9                	li	a5,10
     400:	02f70463          	beq	a4,a5,428 <gets+0x86>
     404:	fe744783          	lbu	a5,-25(s0)
     408:	873e                	mv	a4,a5
     40a:	47b5                	li	a5,13
     40c:	00f70e63          	beq	a4,a5,428 <gets+0x86>
  for(i=0; i+1 < max; ){
     410:	fec42783          	lw	a5,-20(s0)
     414:	2785                	addiw	a5,a5,1
     416:	0007871b          	sext.w	a4,a5
     41a:	fd442783          	lw	a5,-44(s0)
     41e:	2781                	sext.w	a5,a5
     420:	f8f74de3          	blt	a4,a5,3ba <gets+0x18>
     424:	a011                	j	428 <gets+0x86>
      break;
     426:	0001                	nop
      break;
  }
  buf[i] = '\0';
     428:	fec42783          	lw	a5,-20(s0)
     42c:	fd843703          	ld	a4,-40(s0)
     430:	97ba                	add	a5,a5,a4
     432:	00078023          	sb	zero,0(a5)
  return buf;
     436:	fd843783          	ld	a5,-40(s0)
}
     43a:	853e                	mv	a0,a5
     43c:	70a2                	ld	ra,40(sp)
     43e:	7402                	ld	s0,32(sp)
     440:	6145                	addi	sp,sp,48
     442:	8082                	ret

0000000000000444 <stat>:

int
stat(const char *n, struct stat *st)
{
     444:	7179                	addi	sp,sp,-48
     446:	f406                	sd	ra,40(sp)
     448:	f022                	sd	s0,32(sp)
     44a:	1800                	addi	s0,sp,48
     44c:	fca43c23          	sd	a0,-40(s0)
     450:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     454:	4581                	li	a1,0
     456:	fd843503          	ld	a0,-40(s0)
     45a:	00000097          	auipc	ra,0x0
     45e:	28a080e7          	jalr	650(ra) # 6e4 <open>
     462:	87aa                	mv	a5,a0
     464:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     468:	fec42783          	lw	a5,-20(s0)
     46c:	2781                	sext.w	a5,a5
     46e:	0007d463          	bgez	a5,476 <stat+0x32>
    return -1;
     472:	57fd                	li	a5,-1
     474:	a035                	j	4a0 <stat+0x5c>
  r = fstat(fd, st);
     476:	fec42783          	lw	a5,-20(s0)
     47a:	fd043583          	ld	a1,-48(s0)
     47e:	853e                	mv	a0,a5
     480:	00000097          	auipc	ra,0x0
     484:	27c080e7          	jalr	636(ra) # 6fc <fstat>
     488:	87aa                	mv	a5,a0
     48a:	fef42423          	sw	a5,-24(s0)
  close(fd);
     48e:	fec42783          	lw	a5,-20(s0)
     492:	853e                	mv	a0,a5
     494:	00000097          	auipc	ra,0x0
     498:	238080e7          	jalr	568(ra) # 6cc <close>
  return r;
     49c:	fe842783          	lw	a5,-24(s0)
}
     4a0:	853e                	mv	a0,a5
     4a2:	70a2                	ld	ra,40(sp)
     4a4:	7402                	ld	s0,32(sp)
     4a6:	6145                	addi	sp,sp,48
     4a8:	8082                	ret

00000000000004aa <atoi>:

int
atoi(const char *s)
{
     4aa:	7179                	addi	sp,sp,-48
     4ac:	f422                	sd	s0,40(sp)
     4ae:	1800                	addi	s0,sp,48
     4b0:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     4b4:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     4b8:	a81d                	j	4ee <atoi+0x44>
    n = n*10 + *s++ - '0';
     4ba:	fec42783          	lw	a5,-20(s0)
     4be:	873e                	mv	a4,a5
     4c0:	87ba                	mv	a5,a4
     4c2:	0027979b          	slliw	a5,a5,0x2
     4c6:	9fb9                	addw	a5,a5,a4
     4c8:	0017979b          	slliw	a5,a5,0x1
     4cc:	0007871b          	sext.w	a4,a5
     4d0:	fd843783          	ld	a5,-40(s0)
     4d4:	00178693          	addi	a3,a5,1
     4d8:	fcd43c23          	sd	a3,-40(s0)
     4dc:	0007c783          	lbu	a5,0(a5)
     4e0:	2781                	sext.w	a5,a5
     4e2:	9fb9                	addw	a5,a5,a4
     4e4:	2781                	sext.w	a5,a5
     4e6:	fd07879b          	addiw	a5,a5,-48
     4ea:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     4ee:	fd843783          	ld	a5,-40(s0)
     4f2:	0007c783          	lbu	a5,0(a5)
     4f6:	873e                	mv	a4,a5
     4f8:	02f00793          	li	a5,47
     4fc:	00e7fb63          	bgeu	a5,a4,512 <atoi+0x68>
     500:	fd843783          	ld	a5,-40(s0)
     504:	0007c783          	lbu	a5,0(a5)
     508:	873e                	mv	a4,a5
     50a:	03900793          	li	a5,57
     50e:	fae7f6e3          	bgeu	a5,a4,4ba <atoi+0x10>
  return n;
     512:	fec42783          	lw	a5,-20(s0)
}
     516:	853e                	mv	a0,a5
     518:	7422                	ld	s0,40(sp)
     51a:	6145                	addi	sp,sp,48
     51c:	8082                	ret

000000000000051e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     51e:	7139                	addi	sp,sp,-64
     520:	fc22                	sd	s0,56(sp)
     522:	0080                	addi	s0,sp,64
     524:	fca43c23          	sd	a0,-40(s0)
     528:	fcb43823          	sd	a1,-48(s0)
     52c:	87b2                	mv	a5,a2
     52e:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     532:	fd843783          	ld	a5,-40(s0)
     536:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     53a:	fd043783          	ld	a5,-48(s0)
     53e:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     542:	fe043703          	ld	a4,-32(s0)
     546:	fe843783          	ld	a5,-24(s0)
     54a:	02e7fc63          	bgeu	a5,a4,582 <memmove+0x64>
    while(n-- > 0)
     54e:	a00d                	j	570 <memmove+0x52>
      *dst++ = *src++;
     550:	fe043703          	ld	a4,-32(s0)
     554:	00170793          	addi	a5,a4,1
     558:	fef43023          	sd	a5,-32(s0)
     55c:	fe843783          	ld	a5,-24(s0)
     560:	00178693          	addi	a3,a5,1
     564:	fed43423          	sd	a3,-24(s0)
     568:	00074703          	lbu	a4,0(a4)
     56c:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     570:	fcc42783          	lw	a5,-52(s0)
     574:	fff7871b          	addiw	a4,a5,-1
     578:	fce42623          	sw	a4,-52(s0)
     57c:	fcf04ae3          	bgtz	a5,550 <memmove+0x32>
     580:	a891                	j	5d4 <memmove+0xb6>
  } else {
    dst += n;
     582:	fcc42783          	lw	a5,-52(s0)
     586:	fe843703          	ld	a4,-24(s0)
     58a:	97ba                	add	a5,a5,a4
     58c:	fef43423          	sd	a5,-24(s0)
    src += n;
     590:	fcc42783          	lw	a5,-52(s0)
     594:	fe043703          	ld	a4,-32(s0)
     598:	97ba                	add	a5,a5,a4
     59a:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     59e:	a01d                	j	5c4 <memmove+0xa6>
      *--dst = *--src;
     5a0:	fe043783          	ld	a5,-32(s0)
     5a4:	17fd                	addi	a5,a5,-1
     5a6:	fef43023          	sd	a5,-32(s0)
     5aa:	fe843783          	ld	a5,-24(s0)
     5ae:	17fd                	addi	a5,a5,-1
     5b0:	fef43423          	sd	a5,-24(s0)
     5b4:	fe043783          	ld	a5,-32(s0)
     5b8:	0007c703          	lbu	a4,0(a5)
     5bc:	fe843783          	ld	a5,-24(s0)
     5c0:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     5c4:	fcc42783          	lw	a5,-52(s0)
     5c8:	fff7871b          	addiw	a4,a5,-1
     5cc:	fce42623          	sw	a4,-52(s0)
     5d0:	fcf048e3          	bgtz	a5,5a0 <memmove+0x82>
  }
  return vdst;
     5d4:	fd843783          	ld	a5,-40(s0)
}
     5d8:	853e                	mv	a0,a5
     5da:	7462                	ld	s0,56(sp)
     5dc:	6121                	addi	sp,sp,64
     5de:	8082                	ret

00000000000005e0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     5e0:	7139                	addi	sp,sp,-64
     5e2:	fc22                	sd	s0,56(sp)
     5e4:	0080                	addi	s0,sp,64
     5e6:	fca43c23          	sd	a0,-40(s0)
     5ea:	fcb43823          	sd	a1,-48(s0)
     5ee:	87b2                	mv	a5,a2
     5f0:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     5f4:	fd843783          	ld	a5,-40(s0)
     5f8:	fef43423          	sd	a5,-24(s0)
     5fc:	fd043783          	ld	a5,-48(s0)
     600:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     604:	a0a1                	j	64c <memcmp+0x6c>
    if (*p1 != *p2) {
     606:	fe843783          	ld	a5,-24(s0)
     60a:	0007c703          	lbu	a4,0(a5)
     60e:	fe043783          	ld	a5,-32(s0)
     612:	0007c783          	lbu	a5,0(a5)
     616:	02f70163          	beq	a4,a5,638 <memcmp+0x58>
      return *p1 - *p2;
     61a:	fe843783          	ld	a5,-24(s0)
     61e:	0007c783          	lbu	a5,0(a5)
     622:	0007871b          	sext.w	a4,a5
     626:	fe043783          	ld	a5,-32(s0)
     62a:	0007c783          	lbu	a5,0(a5)
     62e:	2781                	sext.w	a5,a5
     630:	40f707bb          	subw	a5,a4,a5
     634:	2781                	sext.w	a5,a5
     636:	a01d                	j	65c <memcmp+0x7c>
    }
    p1++;
     638:	fe843783          	ld	a5,-24(s0)
     63c:	0785                	addi	a5,a5,1
     63e:	fef43423          	sd	a5,-24(s0)
    p2++;
     642:	fe043783          	ld	a5,-32(s0)
     646:	0785                	addi	a5,a5,1
     648:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     64c:	fcc42783          	lw	a5,-52(s0)
     650:	fff7871b          	addiw	a4,a5,-1
     654:	fce42623          	sw	a4,-52(s0)
     658:	f7dd                	bnez	a5,606 <memcmp+0x26>
  }
  return 0;
     65a:	4781                	li	a5,0
}
     65c:	853e                	mv	a0,a5
     65e:	7462                	ld	s0,56(sp)
     660:	6121                	addi	sp,sp,64
     662:	8082                	ret

0000000000000664 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     664:	7179                	addi	sp,sp,-48
     666:	f406                	sd	ra,40(sp)
     668:	f022                	sd	s0,32(sp)
     66a:	1800                	addi	s0,sp,48
     66c:	fea43423          	sd	a0,-24(s0)
     670:	feb43023          	sd	a1,-32(s0)
     674:	87b2                	mv	a5,a2
     676:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     67a:	fdc42783          	lw	a5,-36(s0)
     67e:	863e                	mv	a2,a5
     680:	fe043583          	ld	a1,-32(s0)
     684:	fe843503          	ld	a0,-24(s0)
     688:	00000097          	auipc	ra,0x0
     68c:	e96080e7          	jalr	-362(ra) # 51e <memmove>
     690:	87aa                	mv	a5,a0
}
     692:	853e                	mv	a0,a5
     694:	70a2                	ld	ra,40(sp)
     696:	7402                	ld	s0,32(sp)
     698:	6145                	addi	sp,sp,48
     69a:	8082                	ret

000000000000069c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     69c:	4885                	li	a7,1
 ecall
     69e:	00000073          	ecall
 ret
     6a2:	8082                	ret

00000000000006a4 <exit>:
.global exit
exit:
 li a7, SYS_exit
     6a4:	4889                	li	a7,2
 ecall
     6a6:	00000073          	ecall
 ret
     6aa:	8082                	ret

00000000000006ac <wait>:
.global wait
wait:
 li a7, SYS_wait
     6ac:	488d                	li	a7,3
 ecall
     6ae:	00000073          	ecall
 ret
     6b2:	8082                	ret

00000000000006b4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     6b4:	4891                	li	a7,4
 ecall
     6b6:	00000073          	ecall
 ret
     6ba:	8082                	ret

00000000000006bc <read>:
.global read
read:
 li a7, SYS_read
     6bc:	4895                	li	a7,5
 ecall
     6be:	00000073          	ecall
 ret
     6c2:	8082                	ret

00000000000006c4 <write>:
.global write
write:
 li a7, SYS_write
     6c4:	48c1                	li	a7,16
 ecall
     6c6:	00000073          	ecall
 ret
     6ca:	8082                	ret

00000000000006cc <close>:
.global close
close:
 li a7, SYS_close
     6cc:	48d5                	li	a7,21
 ecall
     6ce:	00000073          	ecall
 ret
     6d2:	8082                	ret

00000000000006d4 <kill>:
.global kill
kill:
 li a7, SYS_kill
     6d4:	4899                	li	a7,6
 ecall
     6d6:	00000073          	ecall
 ret
     6da:	8082                	ret

00000000000006dc <exec>:
.global exec
exec:
 li a7, SYS_exec
     6dc:	489d                	li	a7,7
 ecall
     6de:	00000073          	ecall
 ret
     6e2:	8082                	ret

00000000000006e4 <open>:
.global open
open:
 li a7, SYS_open
     6e4:	48bd                	li	a7,15
 ecall
     6e6:	00000073          	ecall
 ret
     6ea:	8082                	ret

00000000000006ec <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     6ec:	48c5                	li	a7,17
 ecall
     6ee:	00000073          	ecall
 ret
     6f2:	8082                	ret

00000000000006f4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     6f4:	48c9                	li	a7,18
 ecall
     6f6:	00000073          	ecall
 ret
     6fa:	8082                	ret

00000000000006fc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     6fc:	48a1                	li	a7,8
 ecall
     6fe:	00000073          	ecall
 ret
     702:	8082                	ret

0000000000000704 <link>:
.global link
link:
 li a7, SYS_link
     704:	48cd                	li	a7,19
 ecall
     706:	00000073          	ecall
 ret
     70a:	8082                	ret

000000000000070c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     70c:	48d1                	li	a7,20
 ecall
     70e:	00000073          	ecall
 ret
     712:	8082                	ret

0000000000000714 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     714:	48a5                	li	a7,9
 ecall
     716:	00000073          	ecall
 ret
     71a:	8082                	ret

000000000000071c <dup>:
.global dup
dup:
 li a7, SYS_dup
     71c:	48a9                	li	a7,10
 ecall
     71e:	00000073          	ecall
 ret
     722:	8082                	ret

0000000000000724 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     724:	48ad                	li	a7,11
 ecall
     726:	00000073          	ecall
 ret
     72a:	8082                	ret

000000000000072c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     72c:	48b1                	li	a7,12
 ecall
     72e:	00000073          	ecall
 ret
     732:	8082                	ret

0000000000000734 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     734:	48b5                	li	a7,13
 ecall
     736:	00000073          	ecall
 ret
     73a:	8082                	ret

000000000000073c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     73c:	48b9                	li	a7,14
 ecall
     73e:	00000073          	ecall
 ret
     742:	8082                	ret

0000000000000744 <clone>:
.global clone
clone:
 li a7, SYS_clone
     744:	48d9                	li	a7,22
 ecall
     746:	00000073          	ecall
 ret
     74a:	8082                	ret

000000000000074c <join>:
.global join
join:
 li a7, SYS_join
     74c:	48dd                	li	a7,23
 ecall
     74e:	00000073          	ecall
 ret
     752:	8082                	ret

0000000000000754 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     754:	1101                	addi	sp,sp,-32
     756:	ec06                	sd	ra,24(sp)
     758:	e822                	sd	s0,16(sp)
     75a:	1000                	addi	s0,sp,32
     75c:	87aa                	mv	a5,a0
     75e:	872e                	mv	a4,a1
     760:	fef42623          	sw	a5,-20(s0)
     764:	87ba                	mv	a5,a4
     766:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     76a:	feb40713          	addi	a4,s0,-21
     76e:	fec42783          	lw	a5,-20(s0)
     772:	4605                	li	a2,1
     774:	85ba                	mv	a1,a4
     776:	853e                	mv	a0,a5
     778:	00000097          	auipc	ra,0x0
     77c:	f4c080e7          	jalr	-180(ra) # 6c4 <write>
}
     780:	0001                	nop
     782:	60e2                	ld	ra,24(sp)
     784:	6442                	ld	s0,16(sp)
     786:	6105                	addi	sp,sp,32
     788:	8082                	ret

000000000000078a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     78a:	7139                	addi	sp,sp,-64
     78c:	fc06                	sd	ra,56(sp)
     78e:	f822                	sd	s0,48(sp)
     790:	0080                	addi	s0,sp,64
     792:	87aa                	mv	a5,a0
     794:	8736                	mv	a4,a3
     796:	fcf42623          	sw	a5,-52(s0)
     79a:	87ae                	mv	a5,a1
     79c:	fcf42423          	sw	a5,-56(s0)
     7a0:	87b2                	mv	a5,a2
     7a2:	fcf42223          	sw	a5,-60(s0)
     7a6:	87ba                	mv	a5,a4
     7a8:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     7ac:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     7b0:	fc042783          	lw	a5,-64(s0)
     7b4:	2781                	sext.w	a5,a5
     7b6:	c38d                	beqz	a5,7d8 <printint+0x4e>
     7b8:	fc842783          	lw	a5,-56(s0)
     7bc:	2781                	sext.w	a5,a5
     7be:	0007dd63          	bgez	a5,7d8 <printint+0x4e>
    neg = 1;
     7c2:	4785                	li	a5,1
     7c4:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     7c8:	fc842783          	lw	a5,-56(s0)
     7cc:	40f007bb          	negw	a5,a5
     7d0:	2781                	sext.w	a5,a5
     7d2:	fef42223          	sw	a5,-28(s0)
     7d6:	a029                	j	7e0 <printint+0x56>
  } else {
    x = xx;
     7d8:	fc842783          	lw	a5,-56(s0)
     7dc:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     7e0:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     7e4:	fc442783          	lw	a5,-60(s0)
     7e8:	fe442703          	lw	a4,-28(s0)
     7ec:	02f777bb          	remuw	a5,a4,a5
     7f0:	0007861b          	sext.w	a2,a5
     7f4:	fec42783          	lw	a5,-20(s0)
     7f8:	0017871b          	addiw	a4,a5,1
     7fc:	fee42623          	sw	a4,-20(s0)
     800:	00001697          	auipc	a3,0x1
     804:	90868693          	addi	a3,a3,-1784 # 1108 <digits>
     808:	02061713          	slli	a4,a2,0x20
     80c:	9301                	srli	a4,a4,0x20
     80e:	9736                	add	a4,a4,a3
     810:	00074703          	lbu	a4,0(a4)
     814:	17c1                	addi	a5,a5,-16
     816:	97a2                	add	a5,a5,s0
     818:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     81c:	fc442783          	lw	a5,-60(s0)
     820:	fe442703          	lw	a4,-28(s0)
     824:	02f757bb          	divuw	a5,a4,a5
     828:	fef42223          	sw	a5,-28(s0)
     82c:	fe442783          	lw	a5,-28(s0)
     830:	2781                	sext.w	a5,a5
     832:	fbcd                	bnez	a5,7e4 <printint+0x5a>
  if(neg)
     834:	fe842783          	lw	a5,-24(s0)
     838:	2781                	sext.w	a5,a5
     83a:	cf85                	beqz	a5,872 <printint+0xe8>
    buf[i++] = '-';
     83c:	fec42783          	lw	a5,-20(s0)
     840:	0017871b          	addiw	a4,a5,1
     844:	fee42623          	sw	a4,-20(s0)
     848:	17c1                	addi	a5,a5,-16
     84a:	97a2                	add	a5,a5,s0
     84c:	02d00713          	li	a4,45
     850:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     854:	a839                	j	872 <printint+0xe8>
    putc(fd, buf[i]);
     856:	fec42783          	lw	a5,-20(s0)
     85a:	17c1                	addi	a5,a5,-16
     85c:	97a2                	add	a5,a5,s0
     85e:	fe07c703          	lbu	a4,-32(a5)
     862:	fcc42783          	lw	a5,-52(s0)
     866:	85ba                	mv	a1,a4
     868:	853e                	mv	a0,a5
     86a:	00000097          	auipc	ra,0x0
     86e:	eea080e7          	jalr	-278(ra) # 754 <putc>
  while(--i >= 0)
     872:	fec42783          	lw	a5,-20(s0)
     876:	37fd                	addiw	a5,a5,-1
     878:	fef42623          	sw	a5,-20(s0)
     87c:	fec42783          	lw	a5,-20(s0)
     880:	2781                	sext.w	a5,a5
     882:	fc07dae3          	bgez	a5,856 <printint+0xcc>
}
     886:	0001                	nop
     888:	0001                	nop
     88a:	70e2                	ld	ra,56(sp)
     88c:	7442                	ld	s0,48(sp)
     88e:	6121                	addi	sp,sp,64
     890:	8082                	ret

0000000000000892 <printptr>:

static void
printptr(int fd, uint64 x) {
     892:	7179                	addi	sp,sp,-48
     894:	f406                	sd	ra,40(sp)
     896:	f022                	sd	s0,32(sp)
     898:	1800                	addi	s0,sp,48
     89a:	87aa                	mv	a5,a0
     89c:	fcb43823          	sd	a1,-48(s0)
     8a0:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     8a4:	fdc42783          	lw	a5,-36(s0)
     8a8:	03000593          	li	a1,48
     8ac:	853e                	mv	a0,a5
     8ae:	00000097          	auipc	ra,0x0
     8b2:	ea6080e7          	jalr	-346(ra) # 754 <putc>
  putc(fd, 'x');
     8b6:	fdc42783          	lw	a5,-36(s0)
     8ba:	07800593          	li	a1,120
     8be:	853e                	mv	a0,a5
     8c0:	00000097          	auipc	ra,0x0
     8c4:	e94080e7          	jalr	-364(ra) # 754 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     8c8:	fe042623          	sw	zero,-20(s0)
     8cc:	a82d                	j	906 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     8ce:	fd043783          	ld	a5,-48(s0)
     8d2:	93f1                	srli	a5,a5,0x3c
     8d4:	00001717          	auipc	a4,0x1
     8d8:	83470713          	addi	a4,a4,-1996 # 1108 <digits>
     8dc:	97ba                	add	a5,a5,a4
     8de:	0007c703          	lbu	a4,0(a5)
     8e2:	fdc42783          	lw	a5,-36(s0)
     8e6:	85ba                	mv	a1,a4
     8e8:	853e                	mv	a0,a5
     8ea:	00000097          	auipc	ra,0x0
     8ee:	e6a080e7          	jalr	-406(ra) # 754 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     8f2:	fec42783          	lw	a5,-20(s0)
     8f6:	2785                	addiw	a5,a5,1
     8f8:	fef42623          	sw	a5,-20(s0)
     8fc:	fd043783          	ld	a5,-48(s0)
     900:	0792                	slli	a5,a5,0x4
     902:	fcf43823          	sd	a5,-48(s0)
     906:	fec42783          	lw	a5,-20(s0)
     90a:	873e                	mv	a4,a5
     90c:	47bd                	li	a5,15
     90e:	fce7f0e3          	bgeu	a5,a4,8ce <printptr+0x3c>
}
     912:	0001                	nop
     914:	0001                	nop
     916:	70a2                	ld	ra,40(sp)
     918:	7402                	ld	s0,32(sp)
     91a:	6145                	addi	sp,sp,48
     91c:	8082                	ret

000000000000091e <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     91e:	715d                	addi	sp,sp,-80
     920:	e486                	sd	ra,72(sp)
     922:	e0a2                	sd	s0,64(sp)
     924:	0880                	addi	s0,sp,80
     926:	87aa                	mv	a5,a0
     928:	fcb43023          	sd	a1,-64(s0)
     92c:	fac43c23          	sd	a2,-72(s0)
     930:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     934:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     938:	fe042223          	sw	zero,-28(s0)
     93c:	a42d                	j	b66 <vprintf+0x248>
    c = fmt[i] & 0xff;
     93e:	fe442783          	lw	a5,-28(s0)
     942:	fc043703          	ld	a4,-64(s0)
     946:	97ba                	add	a5,a5,a4
     948:	0007c783          	lbu	a5,0(a5)
     94c:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     950:	fe042783          	lw	a5,-32(s0)
     954:	2781                	sext.w	a5,a5
     956:	eb9d                	bnez	a5,98c <vprintf+0x6e>
      if(c == '%'){
     958:	fdc42783          	lw	a5,-36(s0)
     95c:	0007871b          	sext.w	a4,a5
     960:	02500793          	li	a5,37
     964:	00f71763          	bne	a4,a5,972 <vprintf+0x54>
        state = '%';
     968:	02500793          	li	a5,37
     96c:	fef42023          	sw	a5,-32(s0)
     970:	a2f5                	j	b5c <vprintf+0x23e>
      } else {
        putc(fd, c);
     972:	fdc42783          	lw	a5,-36(s0)
     976:	0ff7f713          	zext.b	a4,a5
     97a:	fcc42783          	lw	a5,-52(s0)
     97e:	85ba                	mv	a1,a4
     980:	853e                	mv	a0,a5
     982:	00000097          	auipc	ra,0x0
     986:	dd2080e7          	jalr	-558(ra) # 754 <putc>
     98a:	aac9                	j	b5c <vprintf+0x23e>
      }
    } else if(state == '%'){
     98c:	fe042783          	lw	a5,-32(s0)
     990:	0007871b          	sext.w	a4,a5
     994:	02500793          	li	a5,37
     998:	1cf71263          	bne	a4,a5,b5c <vprintf+0x23e>
      if(c == 'd'){
     99c:	fdc42783          	lw	a5,-36(s0)
     9a0:	0007871b          	sext.w	a4,a5
     9a4:	06400793          	li	a5,100
     9a8:	02f71463          	bne	a4,a5,9d0 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     9ac:	fb843783          	ld	a5,-72(s0)
     9b0:	00878713          	addi	a4,a5,8
     9b4:	fae43c23          	sd	a4,-72(s0)
     9b8:	4398                	lw	a4,0(a5)
     9ba:	fcc42783          	lw	a5,-52(s0)
     9be:	4685                	li	a3,1
     9c0:	4629                	li	a2,10
     9c2:	85ba                	mv	a1,a4
     9c4:	853e                	mv	a0,a5
     9c6:	00000097          	auipc	ra,0x0
     9ca:	dc4080e7          	jalr	-572(ra) # 78a <printint>
     9ce:	a269                	j	b58 <vprintf+0x23a>
      } else if(c == 'l') {
     9d0:	fdc42783          	lw	a5,-36(s0)
     9d4:	0007871b          	sext.w	a4,a5
     9d8:	06c00793          	li	a5,108
     9dc:	02f71663          	bne	a4,a5,a08 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     9e0:	fb843783          	ld	a5,-72(s0)
     9e4:	00878713          	addi	a4,a5,8
     9e8:	fae43c23          	sd	a4,-72(s0)
     9ec:	639c                	ld	a5,0(a5)
     9ee:	0007871b          	sext.w	a4,a5
     9f2:	fcc42783          	lw	a5,-52(s0)
     9f6:	4681                	li	a3,0
     9f8:	4629                	li	a2,10
     9fa:	85ba                	mv	a1,a4
     9fc:	853e                	mv	a0,a5
     9fe:	00000097          	auipc	ra,0x0
     a02:	d8c080e7          	jalr	-628(ra) # 78a <printint>
     a06:	aa89                	j	b58 <vprintf+0x23a>
      } else if(c == 'x') {
     a08:	fdc42783          	lw	a5,-36(s0)
     a0c:	0007871b          	sext.w	a4,a5
     a10:	07800793          	li	a5,120
     a14:	02f71463          	bne	a4,a5,a3c <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     a18:	fb843783          	ld	a5,-72(s0)
     a1c:	00878713          	addi	a4,a5,8
     a20:	fae43c23          	sd	a4,-72(s0)
     a24:	4398                	lw	a4,0(a5)
     a26:	fcc42783          	lw	a5,-52(s0)
     a2a:	4681                	li	a3,0
     a2c:	4641                	li	a2,16
     a2e:	85ba                	mv	a1,a4
     a30:	853e                	mv	a0,a5
     a32:	00000097          	auipc	ra,0x0
     a36:	d58080e7          	jalr	-680(ra) # 78a <printint>
     a3a:	aa39                	j	b58 <vprintf+0x23a>
      } else if(c == 'p') {
     a3c:	fdc42783          	lw	a5,-36(s0)
     a40:	0007871b          	sext.w	a4,a5
     a44:	07000793          	li	a5,112
     a48:	02f71263          	bne	a4,a5,a6c <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     a4c:	fb843783          	ld	a5,-72(s0)
     a50:	00878713          	addi	a4,a5,8
     a54:	fae43c23          	sd	a4,-72(s0)
     a58:	6398                	ld	a4,0(a5)
     a5a:	fcc42783          	lw	a5,-52(s0)
     a5e:	85ba                	mv	a1,a4
     a60:	853e                	mv	a0,a5
     a62:	00000097          	auipc	ra,0x0
     a66:	e30080e7          	jalr	-464(ra) # 892 <printptr>
     a6a:	a0fd                	j	b58 <vprintf+0x23a>
      } else if(c == 's'){
     a6c:	fdc42783          	lw	a5,-36(s0)
     a70:	0007871b          	sext.w	a4,a5
     a74:	07300793          	li	a5,115
     a78:	04f71c63          	bne	a4,a5,ad0 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     a7c:	fb843783          	ld	a5,-72(s0)
     a80:	00878713          	addi	a4,a5,8
     a84:	fae43c23          	sd	a4,-72(s0)
     a88:	639c                	ld	a5,0(a5)
     a8a:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     a8e:	fe843783          	ld	a5,-24(s0)
     a92:	eb8d                	bnez	a5,ac4 <vprintf+0x1a6>
          s = "(null)";
     a94:	00000797          	auipc	a5,0x0
     a98:	61c78793          	addi	a5,a5,1564 # 10b0 <lock_init+0x9c>
     a9c:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     aa0:	a015                	j	ac4 <vprintf+0x1a6>
          putc(fd, *s);
     aa2:	fe843783          	ld	a5,-24(s0)
     aa6:	0007c703          	lbu	a4,0(a5)
     aaa:	fcc42783          	lw	a5,-52(s0)
     aae:	85ba                	mv	a1,a4
     ab0:	853e                	mv	a0,a5
     ab2:	00000097          	auipc	ra,0x0
     ab6:	ca2080e7          	jalr	-862(ra) # 754 <putc>
          s++;
     aba:	fe843783          	ld	a5,-24(s0)
     abe:	0785                	addi	a5,a5,1
     ac0:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     ac4:	fe843783          	ld	a5,-24(s0)
     ac8:	0007c783          	lbu	a5,0(a5)
     acc:	fbf9                	bnez	a5,aa2 <vprintf+0x184>
     ace:	a069                	j	b58 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     ad0:	fdc42783          	lw	a5,-36(s0)
     ad4:	0007871b          	sext.w	a4,a5
     ad8:	06300793          	li	a5,99
     adc:	02f71463          	bne	a4,a5,b04 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     ae0:	fb843783          	ld	a5,-72(s0)
     ae4:	00878713          	addi	a4,a5,8
     ae8:	fae43c23          	sd	a4,-72(s0)
     aec:	439c                	lw	a5,0(a5)
     aee:	0ff7f713          	zext.b	a4,a5
     af2:	fcc42783          	lw	a5,-52(s0)
     af6:	85ba                	mv	a1,a4
     af8:	853e                	mv	a0,a5
     afa:	00000097          	auipc	ra,0x0
     afe:	c5a080e7          	jalr	-934(ra) # 754 <putc>
     b02:	a899                	j	b58 <vprintf+0x23a>
      } else if(c == '%'){
     b04:	fdc42783          	lw	a5,-36(s0)
     b08:	0007871b          	sext.w	a4,a5
     b0c:	02500793          	li	a5,37
     b10:	00f71f63          	bne	a4,a5,b2e <vprintf+0x210>
        putc(fd, c);
     b14:	fdc42783          	lw	a5,-36(s0)
     b18:	0ff7f713          	zext.b	a4,a5
     b1c:	fcc42783          	lw	a5,-52(s0)
     b20:	85ba                	mv	a1,a4
     b22:	853e                	mv	a0,a5
     b24:	00000097          	auipc	ra,0x0
     b28:	c30080e7          	jalr	-976(ra) # 754 <putc>
     b2c:	a035                	j	b58 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     b2e:	fcc42783          	lw	a5,-52(s0)
     b32:	02500593          	li	a1,37
     b36:	853e                	mv	a0,a5
     b38:	00000097          	auipc	ra,0x0
     b3c:	c1c080e7          	jalr	-996(ra) # 754 <putc>
        putc(fd, c);
     b40:	fdc42783          	lw	a5,-36(s0)
     b44:	0ff7f713          	zext.b	a4,a5
     b48:	fcc42783          	lw	a5,-52(s0)
     b4c:	85ba                	mv	a1,a4
     b4e:	853e                	mv	a0,a5
     b50:	00000097          	auipc	ra,0x0
     b54:	c04080e7          	jalr	-1020(ra) # 754 <putc>
      }
      state = 0;
     b58:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     b5c:	fe442783          	lw	a5,-28(s0)
     b60:	2785                	addiw	a5,a5,1
     b62:	fef42223          	sw	a5,-28(s0)
     b66:	fe442783          	lw	a5,-28(s0)
     b6a:	fc043703          	ld	a4,-64(s0)
     b6e:	97ba                	add	a5,a5,a4
     b70:	0007c783          	lbu	a5,0(a5)
     b74:	dc0795e3          	bnez	a5,93e <vprintf+0x20>
    }
  }
}
     b78:	0001                	nop
     b7a:	0001                	nop
     b7c:	60a6                	ld	ra,72(sp)
     b7e:	6406                	ld	s0,64(sp)
     b80:	6161                	addi	sp,sp,80
     b82:	8082                	ret

0000000000000b84 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     b84:	7159                	addi	sp,sp,-112
     b86:	fc06                	sd	ra,56(sp)
     b88:	f822                	sd	s0,48(sp)
     b8a:	0080                	addi	s0,sp,64
     b8c:	fcb43823          	sd	a1,-48(s0)
     b90:	e010                	sd	a2,0(s0)
     b92:	e414                	sd	a3,8(s0)
     b94:	e818                	sd	a4,16(s0)
     b96:	ec1c                	sd	a5,24(s0)
     b98:	03043023          	sd	a6,32(s0)
     b9c:	03143423          	sd	a7,40(s0)
     ba0:	87aa                	mv	a5,a0
     ba2:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     ba6:	03040793          	addi	a5,s0,48
     baa:	fcf43423          	sd	a5,-56(s0)
     bae:	fc843783          	ld	a5,-56(s0)
     bb2:	fd078793          	addi	a5,a5,-48
     bb6:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     bba:	fe843703          	ld	a4,-24(s0)
     bbe:	fdc42783          	lw	a5,-36(s0)
     bc2:	863a                	mv	a2,a4
     bc4:	fd043583          	ld	a1,-48(s0)
     bc8:	853e                	mv	a0,a5
     bca:	00000097          	auipc	ra,0x0
     bce:	d54080e7          	jalr	-684(ra) # 91e <vprintf>
}
     bd2:	0001                	nop
     bd4:	70e2                	ld	ra,56(sp)
     bd6:	7442                	ld	s0,48(sp)
     bd8:	6165                	addi	sp,sp,112
     bda:	8082                	ret

0000000000000bdc <printf>:

void
printf(const char *fmt, ...)
{
     bdc:	7159                	addi	sp,sp,-112
     bde:	f406                	sd	ra,40(sp)
     be0:	f022                	sd	s0,32(sp)
     be2:	1800                	addi	s0,sp,48
     be4:	fca43c23          	sd	a0,-40(s0)
     be8:	e40c                	sd	a1,8(s0)
     bea:	e810                	sd	a2,16(s0)
     bec:	ec14                	sd	a3,24(s0)
     bee:	f018                	sd	a4,32(s0)
     bf0:	f41c                	sd	a5,40(s0)
     bf2:	03043823          	sd	a6,48(s0)
     bf6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     bfa:	04040793          	addi	a5,s0,64
     bfe:	fcf43823          	sd	a5,-48(s0)
     c02:	fd043783          	ld	a5,-48(s0)
     c06:	fc878793          	addi	a5,a5,-56
     c0a:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     c0e:	fe843783          	ld	a5,-24(s0)
     c12:	863e                	mv	a2,a5
     c14:	fd843583          	ld	a1,-40(s0)
     c18:	4505                	li	a0,1
     c1a:	00000097          	auipc	ra,0x0
     c1e:	d04080e7          	jalr	-764(ra) # 91e <vprintf>
}
     c22:	0001                	nop
     c24:	70a2                	ld	ra,40(sp)
     c26:	7402                	ld	s0,32(sp)
     c28:	6165                	addi	sp,sp,112
     c2a:	8082                	ret

0000000000000c2c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     c2c:	7179                	addi	sp,sp,-48
     c2e:	f422                	sd	s0,40(sp)
     c30:	1800                	addi	s0,sp,48
     c32:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     c36:	fd843783          	ld	a5,-40(s0)
     c3a:	17c1                	addi	a5,a5,-16
     c3c:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     c40:	00000797          	auipc	a5,0x0
     c44:	4f878793          	addi	a5,a5,1272 # 1138 <freep>
     c48:	639c                	ld	a5,0(a5)
     c4a:	fef43423          	sd	a5,-24(s0)
     c4e:	a815                	j	c82 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     c50:	fe843783          	ld	a5,-24(s0)
     c54:	639c                	ld	a5,0(a5)
     c56:	fe843703          	ld	a4,-24(s0)
     c5a:	00f76f63          	bltu	a4,a5,c78 <free+0x4c>
     c5e:	fe043703          	ld	a4,-32(s0)
     c62:	fe843783          	ld	a5,-24(s0)
     c66:	02e7eb63          	bltu	a5,a4,c9c <free+0x70>
     c6a:	fe843783          	ld	a5,-24(s0)
     c6e:	639c                	ld	a5,0(a5)
     c70:	fe043703          	ld	a4,-32(s0)
     c74:	02f76463          	bltu	a4,a5,c9c <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     c78:	fe843783          	ld	a5,-24(s0)
     c7c:	639c                	ld	a5,0(a5)
     c7e:	fef43423          	sd	a5,-24(s0)
     c82:	fe043703          	ld	a4,-32(s0)
     c86:	fe843783          	ld	a5,-24(s0)
     c8a:	fce7f3e3          	bgeu	a5,a4,c50 <free+0x24>
     c8e:	fe843783          	ld	a5,-24(s0)
     c92:	639c                	ld	a5,0(a5)
     c94:	fe043703          	ld	a4,-32(s0)
     c98:	faf77ce3          	bgeu	a4,a5,c50 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     c9c:	fe043783          	ld	a5,-32(s0)
     ca0:	479c                	lw	a5,8(a5)
     ca2:	1782                	slli	a5,a5,0x20
     ca4:	9381                	srli	a5,a5,0x20
     ca6:	0792                	slli	a5,a5,0x4
     ca8:	fe043703          	ld	a4,-32(s0)
     cac:	973e                	add	a4,a4,a5
     cae:	fe843783          	ld	a5,-24(s0)
     cb2:	639c                	ld	a5,0(a5)
     cb4:	02f71763          	bne	a4,a5,ce2 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     cb8:	fe043783          	ld	a5,-32(s0)
     cbc:	4798                	lw	a4,8(a5)
     cbe:	fe843783          	ld	a5,-24(s0)
     cc2:	639c                	ld	a5,0(a5)
     cc4:	479c                	lw	a5,8(a5)
     cc6:	9fb9                	addw	a5,a5,a4
     cc8:	0007871b          	sext.w	a4,a5
     ccc:	fe043783          	ld	a5,-32(s0)
     cd0:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     cd2:	fe843783          	ld	a5,-24(s0)
     cd6:	639c                	ld	a5,0(a5)
     cd8:	6398                	ld	a4,0(a5)
     cda:	fe043783          	ld	a5,-32(s0)
     cde:	e398                	sd	a4,0(a5)
     ce0:	a039                	j	cee <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     ce2:	fe843783          	ld	a5,-24(s0)
     ce6:	6398                	ld	a4,0(a5)
     ce8:	fe043783          	ld	a5,-32(s0)
     cec:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     cee:	fe843783          	ld	a5,-24(s0)
     cf2:	479c                	lw	a5,8(a5)
     cf4:	1782                	slli	a5,a5,0x20
     cf6:	9381                	srli	a5,a5,0x20
     cf8:	0792                	slli	a5,a5,0x4
     cfa:	fe843703          	ld	a4,-24(s0)
     cfe:	97ba                	add	a5,a5,a4
     d00:	fe043703          	ld	a4,-32(s0)
     d04:	02f71563          	bne	a4,a5,d2e <free+0x102>
    p->s.size += bp->s.size;
     d08:	fe843783          	ld	a5,-24(s0)
     d0c:	4798                	lw	a4,8(a5)
     d0e:	fe043783          	ld	a5,-32(s0)
     d12:	479c                	lw	a5,8(a5)
     d14:	9fb9                	addw	a5,a5,a4
     d16:	0007871b          	sext.w	a4,a5
     d1a:	fe843783          	ld	a5,-24(s0)
     d1e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     d20:	fe043783          	ld	a5,-32(s0)
     d24:	6398                	ld	a4,0(a5)
     d26:	fe843783          	ld	a5,-24(s0)
     d2a:	e398                	sd	a4,0(a5)
     d2c:	a031                	j	d38 <free+0x10c>
  } else
    p->s.ptr = bp;
     d2e:	fe843783          	ld	a5,-24(s0)
     d32:	fe043703          	ld	a4,-32(s0)
     d36:	e398                	sd	a4,0(a5)
  freep = p;
     d38:	00000797          	auipc	a5,0x0
     d3c:	40078793          	addi	a5,a5,1024 # 1138 <freep>
     d40:	fe843703          	ld	a4,-24(s0)
     d44:	e398                	sd	a4,0(a5)
}
     d46:	0001                	nop
     d48:	7422                	ld	s0,40(sp)
     d4a:	6145                	addi	sp,sp,48
     d4c:	8082                	ret

0000000000000d4e <morecore>:

static Header*
morecore(uint nu)
{
     d4e:	7179                	addi	sp,sp,-48
     d50:	f406                	sd	ra,40(sp)
     d52:	f022                	sd	s0,32(sp)
     d54:	1800                	addi	s0,sp,48
     d56:	87aa                	mv	a5,a0
     d58:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     d5c:	fdc42783          	lw	a5,-36(s0)
     d60:	0007871b          	sext.w	a4,a5
     d64:	6785                	lui	a5,0x1
     d66:	00f77563          	bgeu	a4,a5,d70 <morecore+0x22>
    nu = 4096;
     d6a:	6785                	lui	a5,0x1
     d6c:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     d70:	fdc42783          	lw	a5,-36(s0)
     d74:	0047979b          	slliw	a5,a5,0x4
     d78:	2781                	sext.w	a5,a5
     d7a:	2781                	sext.w	a5,a5
     d7c:	853e                	mv	a0,a5
     d7e:	00000097          	auipc	ra,0x0
     d82:	9ae080e7          	jalr	-1618(ra) # 72c <sbrk>
     d86:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     d8a:	fe843703          	ld	a4,-24(s0)
     d8e:	57fd                	li	a5,-1
     d90:	00f71463          	bne	a4,a5,d98 <morecore+0x4a>
    return 0;
     d94:	4781                	li	a5,0
     d96:	a03d                	j	dc4 <morecore+0x76>
  hp = (Header*)p;
     d98:	fe843783          	ld	a5,-24(s0)
     d9c:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     da0:	fe043783          	ld	a5,-32(s0)
     da4:	fdc42703          	lw	a4,-36(s0)
     da8:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     daa:	fe043783          	ld	a5,-32(s0)
     dae:	07c1                	addi	a5,a5,16
     db0:	853e                	mv	a0,a5
     db2:	00000097          	auipc	ra,0x0
     db6:	e7a080e7          	jalr	-390(ra) # c2c <free>
  return freep;
     dba:	00000797          	auipc	a5,0x0
     dbe:	37e78793          	addi	a5,a5,894 # 1138 <freep>
     dc2:	639c                	ld	a5,0(a5)
}
     dc4:	853e                	mv	a0,a5
     dc6:	70a2                	ld	ra,40(sp)
     dc8:	7402                	ld	s0,32(sp)
     dca:	6145                	addi	sp,sp,48
     dcc:	8082                	ret

0000000000000dce <malloc>:

void*
malloc(uint nbytes)
{
     dce:	7139                	addi	sp,sp,-64
     dd0:	fc06                	sd	ra,56(sp)
     dd2:	f822                	sd	s0,48(sp)
     dd4:	0080                	addi	s0,sp,64
     dd6:	87aa                	mv	a5,a0
     dd8:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     ddc:	fcc46783          	lwu	a5,-52(s0)
     de0:	07bd                	addi	a5,a5,15
     de2:	8391                	srli	a5,a5,0x4
     de4:	2781                	sext.w	a5,a5
     de6:	2785                	addiw	a5,a5,1
     de8:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     dec:	00000797          	auipc	a5,0x0
     df0:	34c78793          	addi	a5,a5,844 # 1138 <freep>
     df4:	639c                	ld	a5,0(a5)
     df6:	fef43023          	sd	a5,-32(s0)
     dfa:	fe043783          	ld	a5,-32(s0)
     dfe:	ef95                	bnez	a5,e3a <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     e00:	00000797          	auipc	a5,0x0
     e04:	32878793          	addi	a5,a5,808 # 1128 <base>
     e08:	fef43023          	sd	a5,-32(s0)
     e0c:	00000797          	auipc	a5,0x0
     e10:	32c78793          	addi	a5,a5,812 # 1138 <freep>
     e14:	fe043703          	ld	a4,-32(s0)
     e18:	e398                	sd	a4,0(a5)
     e1a:	00000797          	auipc	a5,0x0
     e1e:	31e78793          	addi	a5,a5,798 # 1138 <freep>
     e22:	6398                	ld	a4,0(a5)
     e24:	00000797          	auipc	a5,0x0
     e28:	30478793          	addi	a5,a5,772 # 1128 <base>
     e2c:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     e2e:	00000797          	auipc	a5,0x0
     e32:	2fa78793          	addi	a5,a5,762 # 1128 <base>
     e36:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e3a:	fe043783          	ld	a5,-32(s0)
     e3e:	639c                	ld	a5,0(a5)
     e40:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     e44:	fe843783          	ld	a5,-24(s0)
     e48:	4798                	lw	a4,8(a5)
     e4a:	fdc42783          	lw	a5,-36(s0)
     e4e:	2781                	sext.w	a5,a5
     e50:	06f76763          	bltu	a4,a5,ebe <malloc+0xf0>
      if(p->s.size == nunits)
     e54:	fe843783          	ld	a5,-24(s0)
     e58:	4798                	lw	a4,8(a5)
     e5a:	fdc42783          	lw	a5,-36(s0)
     e5e:	2781                	sext.w	a5,a5
     e60:	00e79963          	bne	a5,a4,e72 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     e64:	fe843783          	ld	a5,-24(s0)
     e68:	6398                	ld	a4,0(a5)
     e6a:	fe043783          	ld	a5,-32(s0)
     e6e:	e398                	sd	a4,0(a5)
     e70:	a825                	j	ea8 <malloc+0xda>
      else {
        p->s.size -= nunits;
     e72:	fe843783          	ld	a5,-24(s0)
     e76:	479c                	lw	a5,8(a5)
     e78:	fdc42703          	lw	a4,-36(s0)
     e7c:	9f99                	subw	a5,a5,a4
     e7e:	0007871b          	sext.w	a4,a5
     e82:	fe843783          	ld	a5,-24(s0)
     e86:	c798                	sw	a4,8(a5)
        p += p->s.size;
     e88:	fe843783          	ld	a5,-24(s0)
     e8c:	479c                	lw	a5,8(a5)
     e8e:	1782                	slli	a5,a5,0x20
     e90:	9381                	srli	a5,a5,0x20
     e92:	0792                	slli	a5,a5,0x4
     e94:	fe843703          	ld	a4,-24(s0)
     e98:	97ba                	add	a5,a5,a4
     e9a:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     e9e:	fe843783          	ld	a5,-24(s0)
     ea2:	fdc42703          	lw	a4,-36(s0)
     ea6:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     ea8:	00000797          	auipc	a5,0x0
     eac:	29078793          	addi	a5,a5,656 # 1138 <freep>
     eb0:	fe043703          	ld	a4,-32(s0)
     eb4:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     eb6:	fe843783          	ld	a5,-24(s0)
     eba:	07c1                	addi	a5,a5,16
     ebc:	a091                	j	f00 <malloc+0x132>
    }
    if(p == freep)
     ebe:	00000797          	auipc	a5,0x0
     ec2:	27a78793          	addi	a5,a5,634 # 1138 <freep>
     ec6:	639c                	ld	a5,0(a5)
     ec8:	fe843703          	ld	a4,-24(s0)
     ecc:	02f71063          	bne	a4,a5,eec <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
     ed0:	fdc42783          	lw	a5,-36(s0)
     ed4:	853e                	mv	a0,a5
     ed6:	00000097          	auipc	ra,0x0
     eda:	e78080e7          	jalr	-392(ra) # d4e <morecore>
     ede:	fea43423          	sd	a0,-24(s0)
     ee2:	fe843783          	ld	a5,-24(s0)
     ee6:	e399                	bnez	a5,eec <malloc+0x11e>
        return 0;
     ee8:	4781                	li	a5,0
     eea:	a819                	j	f00 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     eec:	fe843783          	ld	a5,-24(s0)
     ef0:	fef43023          	sd	a5,-32(s0)
     ef4:	fe843783          	ld	a5,-24(s0)
     ef8:	639c                	ld	a5,0(a5)
     efa:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     efe:	b799                	j	e44 <malloc+0x76>
  }
}
     f00:	853e                	mv	a0,a5
     f02:	70e2                	ld	ra,56(sp)
     f04:	7442                	ld	s0,48(sp)
     f06:	6121                	addi	sp,sp,64
     f08:	8082                	ret

0000000000000f0a <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
     f0a:	7179                	addi	sp,sp,-48
     f0c:	f406                	sd	ra,40(sp)
     f0e:	f022                	sd	s0,32(sp)
     f10:	1800                	addi	s0,sp,48
     f12:	fca43c23          	sd	a0,-40(s0)
     f16:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
     f1a:	6505                	lui	a0,0x1
     f1c:	00000097          	auipc	ra,0x0
     f20:	eb2080e7          	jalr	-334(ra) # dce <malloc>
     f24:	fea43423          	sd	a0,-24(s0)
     f28:	fe843783          	ld	a5,-24(s0)
     f2c:	e38d                	bnez	a5,f4e <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
     f2e:	00000517          	auipc	a0,0x0
     f32:	18a50513          	addi	a0,a0,394 # 10b8 <lock_init+0xa4>
     f36:	00000097          	auipc	ra,0x0
     f3a:	ca6080e7          	jalr	-858(ra) # bdc <printf>
        free(stack);
     f3e:	fe843503          	ld	a0,-24(s0)
     f42:	00000097          	auipc	ra,0x0
     f46:	cea080e7          	jalr	-790(ra) # c2c <free>
        return -1;
     f4a:	57fd                	li	a5,-1
     f4c:	a099                	j	f92 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
     f4e:	fe843783          	ld	a5,-24(s0)
     f52:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
     f56:	fe043703          	ld	a4,-32(s0)
     f5a:	6785                	lui	a5,0x1
     f5c:	17fd                	addi	a5,a5,-1
     f5e:	8ff9                	and	a5,a5,a4
     f60:	cf91                	beqz	a5,f7c <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
     f62:	fe043703          	ld	a4,-32(s0)
     f66:	6785                	lui	a5,0x1
     f68:	17fd                	addi	a5,a5,-1
     f6a:	8ff9                	and	a5,a5,a4
     f6c:	6705                	lui	a4,0x1
     f6e:	40f707b3          	sub	a5,a4,a5
     f72:	fe843703          	ld	a4,-24(s0)
     f76:	97ba                	add	a5,a5,a4
     f78:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
     f7c:	fe843603          	ld	a2,-24(s0)
     f80:	fd043583          	ld	a1,-48(s0)
     f84:	fd843503          	ld	a0,-40(s0)
     f88:	fffff097          	auipc	ra,0xfffff
     f8c:	7bc080e7          	jalr	1980(ra) # 744 <clone>
     f90:	87aa                	mv	a5,a0
}
     f92:	853e                	mv	a0,a5
     f94:	70a2                	ld	ra,40(sp)
     f96:	7402                	ld	s0,32(sp)
     f98:	6145                	addi	sp,sp,48
     f9a:	8082                	ret

0000000000000f9c <thread_join>:


int thread_join()
{
     f9c:	1101                	addi	sp,sp,-32
     f9e:	ec06                	sd	ra,24(sp)
     fa0:	e822                	sd	s0,16(sp)
     fa2:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
     fa4:	fe040793          	addi	a5,s0,-32
     fa8:	853e                	mv	a0,a5
     faa:	fffff097          	auipc	ra,0xfffff
     fae:	7a2080e7          	jalr	1954(ra) # 74c <join>
     fb2:	87aa                	mv	a5,a0
     fb4:	fef42623          	sw	a5,-20(s0)
     fb8:	fec42783          	lw	a5,-20(s0)
     fbc:	0007871b          	sext.w	a4,a5
     fc0:	57fd                	li	a5,-1
     fc2:	00f70963          	beq	a4,a5,fd4 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
     fc6:	fe043783          	ld	a5,-32(s0)
     fca:	853e                	mv	a0,a5
     fcc:	00000097          	auipc	ra,0x0
     fd0:	c60080e7          	jalr	-928(ra) # c2c <free>
    } 

    return child_tid;
     fd4:	fec42783          	lw	a5,-20(s0)
}
     fd8:	853e                	mv	a0,a5
     fda:	60e2                	ld	ra,24(sp)
     fdc:	6442                	ld	s0,16(sp)
     fde:	6105                	addi	sp,sp,32
     fe0:	8082                	ret

0000000000000fe2 <lock_acquire>:


void lock_acquire (lock_t *lock)
{
     fe2:	1101                	addi	sp,sp,-32
     fe4:	ec22                	sd	s0,24(sp)
     fe6:	1000                	addi	s0,sp,32
     fe8:	fea43423          	sd	a0,-24(s0)
        lock = 0;
     fec:	fe043423          	sd	zero,-24(s0)

}
     ff0:	0001                	nop
     ff2:	6462                	ld	s0,24(sp)
     ff4:	6105                	addi	sp,sp,32
     ff6:	8082                	ret

0000000000000ff8 <lock_release>:

void lock_release (lock_t *lock)
{
     ff8:	1101                	addi	sp,sp,-32
     ffa:	ec22                	sd	s0,24(sp)
     ffc:	1000                	addi	s0,sp,32
     ffe:	fea43423          	sd	a0,-24(s0)
        __sync_lock_test_and_set(lock, 1);
    1002:	fe843783          	ld	a5,-24(s0)
    1006:	4705                	li	a4,1
    1008:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    
}
    100c:	0001                	nop
    100e:	6462                	ld	s0,24(sp)
    1010:	6105                	addi	sp,sp,32
    1012:	8082                	ret

0000000000001014 <lock_init>:

void lock_init (lock_t *lock)
{
    1014:	1101                	addi	sp,sp,-32
    1016:	ec22                	sd	s0,24(sp)
    1018:	1000                	addi	s0,sp,32
    101a:	fea43423          	sd	a0,-24(s0)
    lock = 0;
    101e:	fe043423          	sd	zero,-24(s0)
    
}
    1022:	0001                	nop
    1024:	6462                	ld	s0,24(sp)
    1026:	6105                	addi	sp,sp,32
    1028:	8082                	ret
