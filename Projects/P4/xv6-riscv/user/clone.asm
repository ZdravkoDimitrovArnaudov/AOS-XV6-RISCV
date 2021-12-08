
user/_clone:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <worker>:
   printf("TEST PASSED\n");
   exit(0);
}

void
worker(void *arg_ptr) {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
   assert(global == 1);
   8:	00001717          	auipc	a4,0x1
   c:	9ec72703          	lw	a4,-1556(a4) # 9f4 <global>
  10:	4785                	li	a5,1
  12:	06f70163          	beq	a4,a5,74 <worker+0x74>
  16:	02900613          	li	a2,41
  1a:	00001597          	auipc	a1,0x1
  1e:	93e58593          	addi	a1,a1,-1730 # 958 <malloc+0xe8>
  22:	00001517          	auipc	a0,0x1
  26:	94650513          	addi	a0,a0,-1722 # 968 <malloc+0xf8>
  2a:	00000097          	auipc	ra,0x0
  2e:	788080e7          	jalr	1928(ra) # 7b2 <printf>
  32:	00001597          	auipc	a1,0x1
  36:	93e58593          	addi	a1,a1,-1730 # 970 <malloc+0x100>
  3a:	00001517          	auipc	a0,0x1
  3e:	94650513          	addi	a0,a0,-1722 # 980 <malloc+0x110>
  42:	00000097          	auipc	ra,0x0
  46:	770080e7          	jalr	1904(ra) # 7b2 <printf>
  4a:	00001517          	auipc	a0,0x1
  4e:	94e50513          	addi	a0,a0,-1714 # 998 <malloc+0x128>
  52:	00000097          	auipc	ra,0x0
  56:	760080e7          	jalr	1888(ra) # 7b2 <printf>
  5a:	00001517          	auipc	a0,0x1
  5e:	99e52503          	lw	a0,-1634(a0) # 9f8 <ppid>
  62:	00000097          	auipc	ra,0x0
  66:	3f8080e7          	jalr	1016(ra) # 45a <kill>
  6a:	4501                	li	a0,0
  6c:	00000097          	auipc	ra,0x0
  70:	3be080e7          	jalr	958(ra) # 42a <exit>
   global = 5;
  74:	4795                	li	a5,5
  76:	00001717          	auipc	a4,0x1
  7a:	96f72f23          	sw	a5,-1666(a4) # 9f4 <global>
   exit(0);
  7e:	4501                	li	a0,0
  80:	00000097          	auipc	ra,0x0
  84:	3aa080e7          	jalr	938(ra) # 42a <exit>

0000000000000088 <main>:
{
  88:	1141                	addi	sp,sp,-16
  8a:	e406                	sd	ra,8(sp)
  8c:	e022                	sd	s0,0(sp)
  8e:	0800                	addi	s0,sp,16
   ppid = getpid();//recoge pid del proceso
  90:	00000097          	auipc	ra,0x0
  94:	41a080e7          	jalr	1050(ra) # 4aa <getpid>
  98:	00001797          	auipc	a5,0x1
  9c:	96a7a023          	sw	a0,-1696(a5) # 9f8 <ppid>
   void *stack = malloc(PGSIZE*2);//reserva dos páginas para el malloc
  a0:	6509                	lui	a0,0x2
  a2:	00000097          	auipc	ra,0x0
  a6:	7ce080e7          	jalr	1998(ra) # 870 <malloc>
   assert(stack != NULL); //comprueba que se haya podido crear bien memoria dinámica
  aa:	cd21                	beqz	a0,102 <main+0x7a>
  ac:	862a                	mv	a2,a0
   if((uint64)stack % PGSIZE) //si la pagina no está alineada
  ae:	03451793          	slli	a5,a0,0x34
  b2:	0347d713          	srli	a4,a5,0x34
  b6:	c789                	beqz	a5,c0 <main+0x38>
     stack = stack + (4096 - (uint64)stack % PGSIZE); //alinea el stack a página
  b8:	6785                	lui	a5,0x1
  ba:	8f99                	sub	a5,a5,a4
  bc:	00f50633          	add	a2,a0,a5
   int clone_pid = clone(worker, 0, stack); //crea un thread para operar una funcion worker con argumento 0 y dispone stack de 2 páginas
  c0:	4581                	li	a1,0
  c2:	00000517          	auipc	a0,0x0
  c6:	f3e50513          	addi	a0,a0,-194 # 0 <worker>
  ca:	00000097          	auipc	ra,0x0
  ce:	400080e7          	jalr	1024(ra) # 4ca <clone>
   while(global != 5); //comprueba si el thread ha modificado correctamente la variable global a 5 y no es otro valor distinto.
  d2:	00001697          	auipc	a3,0x1
  d6:	92268693          	addi	a3,a3,-1758 # 9f4 <global>
  da:	4715                	li	a4,5
   assert(clone_pid > 0); //comprueba que no haya fallado el clone
  dc:	08a05163          	blez	a0,15e <main+0xd6>
   while(global != 5); //comprueba si el thread ha modificado correctamente la variable global a 5 y no es otro valor distinto.
  e0:	429c                	lw	a5,0(a3)
  e2:	2781                	sext.w	a5,a5
  e4:	fee79ee3          	bne	a5,a4,e0 <main+0x58>
   printf("TEST PASSED\n");
  e8:	00001517          	auipc	a0,0x1
  ec:	8e050513          	addi	a0,a0,-1824 # 9c8 <malloc+0x158>
  f0:	00000097          	auipc	ra,0x0
  f4:	6c2080e7          	jalr	1730(ra) # 7b2 <printf>
   exit(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	330080e7          	jalr	816(ra) # 42a <exit>
   assert(stack != NULL); //comprueba que se haya podido crear bien memoria dinámica
 102:	4671                	li	a2,28
 104:	00001597          	auipc	a1,0x1
 108:	85458593          	addi	a1,a1,-1964 # 958 <malloc+0xe8>
 10c:	00001517          	auipc	a0,0x1
 110:	85c50513          	addi	a0,a0,-1956 # 968 <malloc+0xf8>
 114:	00000097          	auipc	ra,0x0
 118:	69e080e7          	jalr	1694(ra) # 7b2 <printf>
 11c:	00001597          	auipc	a1,0x1
 120:	88c58593          	addi	a1,a1,-1908 # 9a8 <malloc+0x138>
 124:	00001517          	auipc	a0,0x1
 128:	85c50513          	addi	a0,a0,-1956 # 980 <malloc+0x110>
 12c:	00000097          	auipc	ra,0x0
 130:	686080e7          	jalr	1670(ra) # 7b2 <printf>
 134:	00001517          	auipc	a0,0x1
 138:	86450513          	addi	a0,a0,-1948 # 998 <malloc+0x128>
 13c:	00000097          	auipc	ra,0x0
 140:	676080e7          	jalr	1654(ra) # 7b2 <printf>
 144:	00001517          	auipc	a0,0x1
 148:	8b452503          	lw	a0,-1868(a0) # 9f8 <ppid>
 14c:	00000097          	auipc	ra,0x0
 150:	30e080e7          	jalr	782(ra) # 45a <kill>
 154:	4501                	li	a0,0
 156:	00000097          	auipc	ra,0x0
 15a:	2d4080e7          	jalr	724(ra) # 42a <exit>
   assert(clone_pid > 0); //comprueba que no haya fallado el clone
 15e:	02100613          	li	a2,33
 162:	00000597          	auipc	a1,0x0
 166:	7f658593          	addi	a1,a1,2038 # 958 <malloc+0xe8>
 16a:	00000517          	auipc	a0,0x0
 16e:	7fe50513          	addi	a0,a0,2046 # 968 <malloc+0xf8>
 172:	00000097          	auipc	ra,0x0
 176:	640080e7          	jalr	1600(ra) # 7b2 <printf>
 17a:	00001597          	auipc	a1,0x1
 17e:	83e58593          	addi	a1,a1,-1986 # 9b8 <malloc+0x148>
 182:	00000517          	auipc	a0,0x0
 186:	7fe50513          	addi	a0,a0,2046 # 980 <malloc+0x110>
 18a:	00000097          	auipc	ra,0x0
 18e:	628080e7          	jalr	1576(ra) # 7b2 <printf>
 192:	00001517          	auipc	a0,0x1
 196:	80650513          	addi	a0,a0,-2042 # 998 <malloc+0x128>
 19a:	00000097          	auipc	ra,0x0
 19e:	618080e7          	jalr	1560(ra) # 7b2 <printf>
 1a2:	00001517          	auipc	a0,0x1
 1a6:	85652503          	lw	a0,-1962(a0) # 9f8 <ppid>
 1aa:	00000097          	auipc	ra,0x0
 1ae:	2b0080e7          	jalr	688(ra) # 45a <kill>
 1b2:	4501                	li	a0,0
 1b4:	00000097          	auipc	ra,0x0
 1b8:	276080e7          	jalr	630(ra) # 42a <exit>

00000000000001bc <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1bc:	1141                	addi	sp,sp,-16
 1be:	e422                	sd	s0,8(sp)
 1c0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1c2:	87aa                	mv	a5,a0
 1c4:	0585                	addi	a1,a1,1
 1c6:	0785                	addi	a5,a5,1
 1c8:	fff5c703          	lbu	a4,-1(a1)
 1cc:	fee78fa3          	sb	a4,-1(a5) # fff <__BSS_END__+0x5e7>
 1d0:	fb75                	bnez	a4,1c4 <strcpy+0x8>
    ;
  return os;
}
 1d2:	6422                	ld	s0,8(sp)
 1d4:	0141                	addi	sp,sp,16
 1d6:	8082                	ret

00000000000001d8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d8:	1141                	addi	sp,sp,-16
 1da:	e422                	sd	s0,8(sp)
 1dc:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1de:	00054783          	lbu	a5,0(a0)
 1e2:	cb91                	beqz	a5,1f6 <strcmp+0x1e>
 1e4:	0005c703          	lbu	a4,0(a1)
 1e8:	00f71763          	bne	a4,a5,1f6 <strcmp+0x1e>
    p++, q++;
 1ec:	0505                	addi	a0,a0,1
 1ee:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1f0:	00054783          	lbu	a5,0(a0)
 1f4:	fbe5                	bnez	a5,1e4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1f6:	0005c503          	lbu	a0,0(a1)
}
 1fa:	40a7853b          	subw	a0,a5,a0
 1fe:	6422                	ld	s0,8(sp)
 200:	0141                	addi	sp,sp,16
 202:	8082                	ret

0000000000000204 <strlen>:

uint
strlen(const char *s)
{
 204:	1141                	addi	sp,sp,-16
 206:	e422                	sd	s0,8(sp)
 208:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 20a:	00054783          	lbu	a5,0(a0)
 20e:	cf91                	beqz	a5,22a <strlen+0x26>
 210:	0505                	addi	a0,a0,1
 212:	87aa                	mv	a5,a0
 214:	4685                	li	a3,1
 216:	9e89                	subw	a3,a3,a0
 218:	00f6853b          	addw	a0,a3,a5
 21c:	0785                	addi	a5,a5,1
 21e:	fff7c703          	lbu	a4,-1(a5)
 222:	fb7d                	bnez	a4,218 <strlen+0x14>
    ;
  return n;
}
 224:	6422                	ld	s0,8(sp)
 226:	0141                	addi	sp,sp,16
 228:	8082                	ret
  for(n = 0; s[n]; n++)
 22a:	4501                	li	a0,0
 22c:	bfe5                	j	224 <strlen+0x20>

000000000000022e <memset>:

void*
memset(void *dst, int c, uint n)
{
 22e:	1141                	addi	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 234:	ca19                	beqz	a2,24a <memset+0x1c>
 236:	87aa                	mv	a5,a0
 238:	1602                	slli	a2,a2,0x20
 23a:	9201                	srli	a2,a2,0x20
 23c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 240:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 244:	0785                	addi	a5,a5,1
 246:	fee79de3          	bne	a5,a4,240 <memset+0x12>
  }
  return dst;
}
 24a:	6422                	ld	s0,8(sp)
 24c:	0141                	addi	sp,sp,16
 24e:	8082                	ret

0000000000000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	1141                	addi	sp,sp,-16
 252:	e422                	sd	s0,8(sp)
 254:	0800                	addi	s0,sp,16
  for(; *s; s++)
 256:	00054783          	lbu	a5,0(a0)
 25a:	cb99                	beqz	a5,270 <strchr+0x20>
    if(*s == c)
 25c:	00f58763          	beq	a1,a5,26a <strchr+0x1a>
  for(; *s; s++)
 260:	0505                	addi	a0,a0,1
 262:	00054783          	lbu	a5,0(a0)
 266:	fbfd                	bnez	a5,25c <strchr+0xc>
      return (char*)s;
  return 0;
 268:	4501                	li	a0,0
}
 26a:	6422                	ld	s0,8(sp)
 26c:	0141                	addi	sp,sp,16
 26e:	8082                	ret
  return 0;
 270:	4501                	li	a0,0
 272:	bfe5                	j	26a <strchr+0x1a>

0000000000000274 <gets>:

char*
gets(char *buf, int max)
{
 274:	711d                	addi	sp,sp,-96
 276:	ec86                	sd	ra,88(sp)
 278:	e8a2                	sd	s0,80(sp)
 27a:	e4a6                	sd	s1,72(sp)
 27c:	e0ca                	sd	s2,64(sp)
 27e:	fc4e                	sd	s3,56(sp)
 280:	f852                	sd	s4,48(sp)
 282:	f456                	sd	s5,40(sp)
 284:	f05a                	sd	s6,32(sp)
 286:	ec5e                	sd	s7,24(sp)
 288:	1080                	addi	s0,sp,96
 28a:	8baa                	mv	s7,a0
 28c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 28e:	892a                	mv	s2,a0
 290:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 292:	4aa9                	li	s5,10
 294:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 296:	89a6                	mv	s3,s1
 298:	2485                	addiw	s1,s1,1
 29a:	0344d863          	bge	s1,s4,2ca <gets+0x56>
    cc = read(0, &c, 1);
 29e:	4605                	li	a2,1
 2a0:	faf40593          	addi	a1,s0,-81
 2a4:	4501                	li	a0,0
 2a6:	00000097          	auipc	ra,0x0
 2aa:	19c080e7          	jalr	412(ra) # 442 <read>
    if(cc < 1)
 2ae:	00a05e63          	blez	a0,2ca <gets+0x56>
    buf[i++] = c;
 2b2:	faf44783          	lbu	a5,-81(s0)
 2b6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2ba:	01578763          	beq	a5,s5,2c8 <gets+0x54>
 2be:	0905                	addi	s2,s2,1
 2c0:	fd679be3          	bne	a5,s6,296 <gets+0x22>
  for(i=0; i+1 < max; ){
 2c4:	89a6                	mv	s3,s1
 2c6:	a011                	j	2ca <gets+0x56>
 2c8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2ca:	99de                	add	s3,s3,s7
 2cc:	00098023          	sb	zero,0(s3)
  return buf;
}
 2d0:	855e                	mv	a0,s7
 2d2:	60e6                	ld	ra,88(sp)
 2d4:	6446                	ld	s0,80(sp)
 2d6:	64a6                	ld	s1,72(sp)
 2d8:	6906                	ld	s2,64(sp)
 2da:	79e2                	ld	s3,56(sp)
 2dc:	7a42                	ld	s4,48(sp)
 2de:	7aa2                	ld	s5,40(sp)
 2e0:	7b02                	ld	s6,32(sp)
 2e2:	6be2                	ld	s7,24(sp)
 2e4:	6125                	addi	sp,sp,96
 2e6:	8082                	ret

00000000000002e8 <stat>:

int
stat(const char *n, struct stat *st)
{
 2e8:	1101                	addi	sp,sp,-32
 2ea:	ec06                	sd	ra,24(sp)
 2ec:	e822                	sd	s0,16(sp)
 2ee:	e426                	sd	s1,8(sp)
 2f0:	e04a                	sd	s2,0(sp)
 2f2:	1000                	addi	s0,sp,32
 2f4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f6:	4581                	li	a1,0
 2f8:	00000097          	auipc	ra,0x0
 2fc:	172080e7          	jalr	370(ra) # 46a <open>
  if(fd < 0)
 300:	02054563          	bltz	a0,32a <stat+0x42>
 304:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 306:	85ca                	mv	a1,s2
 308:	00000097          	auipc	ra,0x0
 30c:	17a080e7          	jalr	378(ra) # 482 <fstat>
 310:	892a                	mv	s2,a0
  close(fd);
 312:	8526                	mv	a0,s1
 314:	00000097          	auipc	ra,0x0
 318:	13e080e7          	jalr	318(ra) # 452 <close>
  return r;
}
 31c:	854a                	mv	a0,s2
 31e:	60e2                	ld	ra,24(sp)
 320:	6442                	ld	s0,16(sp)
 322:	64a2                	ld	s1,8(sp)
 324:	6902                	ld	s2,0(sp)
 326:	6105                	addi	sp,sp,32
 328:	8082                	ret
    return -1;
 32a:	597d                	li	s2,-1
 32c:	bfc5                	j	31c <stat+0x34>

000000000000032e <atoi>:

int
atoi(const char *s)
{
 32e:	1141                	addi	sp,sp,-16
 330:	e422                	sd	s0,8(sp)
 332:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 334:	00054603          	lbu	a2,0(a0)
 338:	fd06079b          	addiw	a5,a2,-48
 33c:	0ff7f793          	andi	a5,a5,255
 340:	4725                	li	a4,9
 342:	02f76963          	bltu	a4,a5,374 <atoi+0x46>
 346:	86aa                	mv	a3,a0
  n = 0;
 348:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 34a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 34c:	0685                	addi	a3,a3,1
 34e:	0025179b          	slliw	a5,a0,0x2
 352:	9fa9                	addw	a5,a5,a0
 354:	0017979b          	slliw	a5,a5,0x1
 358:	9fb1                	addw	a5,a5,a2
 35a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 35e:	0006c603          	lbu	a2,0(a3)
 362:	fd06071b          	addiw	a4,a2,-48
 366:	0ff77713          	andi	a4,a4,255
 36a:	fee5f1e3          	bgeu	a1,a4,34c <atoi+0x1e>
  return n;
}
 36e:	6422                	ld	s0,8(sp)
 370:	0141                	addi	sp,sp,16
 372:	8082                	ret
  n = 0;
 374:	4501                	li	a0,0
 376:	bfe5                	j	36e <atoi+0x40>

0000000000000378 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 378:	1141                	addi	sp,sp,-16
 37a:	e422                	sd	s0,8(sp)
 37c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 37e:	02b57463          	bgeu	a0,a1,3a6 <memmove+0x2e>
    while(n-- > 0)
 382:	00c05f63          	blez	a2,3a0 <memmove+0x28>
 386:	1602                	slli	a2,a2,0x20
 388:	9201                	srli	a2,a2,0x20
 38a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 38e:	872a                	mv	a4,a0
      *dst++ = *src++;
 390:	0585                	addi	a1,a1,1
 392:	0705                	addi	a4,a4,1
 394:	fff5c683          	lbu	a3,-1(a1)
 398:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 39c:	fee79ae3          	bne	a5,a4,390 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3a0:	6422                	ld	s0,8(sp)
 3a2:	0141                	addi	sp,sp,16
 3a4:	8082                	ret
    dst += n;
 3a6:	00c50733          	add	a4,a0,a2
    src += n;
 3aa:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3ac:	fec05ae3          	blez	a2,3a0 <memmove+0x28>
 3b0:	fff6079b          	addiw	a5,a2,-1
 3b4:	1782                	slli	a5,a5,0x20
 3b6:	9381                	srli	a5,a5,0x20
 3b8:	fff7c793          	not	a5,a5
 3bc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3be:	15fd                	addi	a1,a1,-1
 3c0:	177d                	addi	a4,a4,-1
 3c2:	0005c683          	lbu	a3,0(a1)
 3c6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3ca:	fee79ae3          	bne	a5,a4,3be <memmove+0x46>
 3ce:	bfc9                	j	3a0 <memmove+0x28>

00000000000003d0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3d0:	1141                	addi	sp,sp,-16
 3d2:	e422                	sd	s0,8(sp)
 3d4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3d6:	ca05                	beqz	a2,406 <memcmp+0x36>
 3d8:	fff6069b          	addiw	a3,a2,-1
 3dc:	1682                	slli	a3,a3,0x20
 3de:	9281                	srli	a3,a3,0x20
 3e0:	0685                	addi	a3,a3,1
 3e2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3e4:	00054783          	lbu	a5,0(a0)
 3e8:	0005c703          	lbu	a4,0(a1)
 3ec:	00e79863          	bne	a5,a4,3fc <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3f0:	0505                	addi	a0,a0,1
    p2++;
 3f2:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3f4:	fed518e3          	bne	a0,a3,3e4 <memcmp+0x14>
  }
  return 0;
 3f8:	4501                	li	a0,0
 3fa:	a019                	j	400 <memcmp+0x30>
      return *p1 - *p2;
 3fc:	40e7853b          	subw	a0,a5,a4
}
 400:	6422                	ld	s0,8(sp)
 402:	0141                	addi	sp,sp,16
 404:	8082                	ret
  return 0;
 406:	4501                	li	a0,0
 408:	bfe5                	j	400 <memcmp+0x30>

000000000000040a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 40a:	1141                	addi	sp,sp,-16
 40c:	e406                	sd	ra,8(sp)
 40e:	e022                	sd	s0,0(sp)
 410:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 412:	00000097          	auipc	ra,0x0
 416:	f66080e7          	jalr	-154(ra) # 378 <memmove>
}
 41a:	60a2                	ld	ra,8(sp)
 41c:	6402                	ld	s0,0(sp)
 41e:	0141                	addi	sp,sp,16
 420:	8082                	ret

0000000000000422 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 422:	4885                	li	a7,1
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <exit>:
.global exit
exit:
 li a7, SYS_exit
 42a:	4889                	li	a7,2
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <wait>:
.global wait
wait:
 li a7, SYS_wait
 432:	488d                	li	a7,3
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 43a:	4891                	li	a7,4
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <read>:
.global read
read:
 li a7, SYS_read
 442:	4895                	li	a7,5
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <write>:
.global write
write:
 li a7, SYS_write
 44a:	48c1                	li	a7,16
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <close>:
.global close
close:
 li a7, SYS_close
 452:	48d5                	li	a7,21
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <kill>:
.global kill
kill:
 li a7, SYS_kill
 45a:	4899                	li	a7,6
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <exec>:
.global exec
exec:
 li a7, SYS_exec
 462:	489d                	li	a7,7
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <open>:
.global open
open:
 li a7, SYS_open
 46a:	48bd                	li	a7,15
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 472:	48c5                	li	a7,17
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 47a:	48c9                	li	a7,18
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 482:	48a1                	li	a7,8
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <link>:
.global link
link:
 li a7, SYS_link
 48a:	48cd                	li	a7,19
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 492:	48d1                	li	a7,20
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 49a:	48a5                	li	a7,9
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4a2:	48a9                	li	a7,10
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4aa:	48ad                	li	a7,11
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4b2:	48b1                	li	a7,12
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4ba:	48b5                	li	a7,13
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4c2:	48b9                	li	a7,14
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <clone>:
.global clone
clone:
 li a7, SYS_clone
 4ca:	48d9                	li	a7,22
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <join>:
.global join
join:
 li a7, SYS_join
 4d2:	48dd                	li	a7,23
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4da:	1101                	addi	sp,sp,-32
 4dc:	ec06                	sd	ra,24(sp)
 4de:	e822                	sd	s0,16(sp)
 4e0:	1000                	addi	s0,sp,32
 4e2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4e6:	4605                	li	a2,1
 4e8:	fef40593          	addi	a1,s0,-17
 4ec:	00000097          	auipc	ra,0x0
 4f0:	f5e080e7          	jalr	-162(ra) # 44a <write>
}
 4f4:	60e2                	ld	ra,24(sp)
 4f6:	6442                	ld	s0,16(sp)
 4f8:	6105                	addi	sp,sp,32
 4fa:	8082                	ret

00000000000004fc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4fc:	7139                	addi	sp,sp,-64
 4fe:	fc06                	sd	ra,56(sp)
 500:	f822                	sd	s0,48(sp)
 502:	f426                	sd	s1,40(sp)
 504:	f04a                	sd	s2,32(sp)
 506:	ec4e                	sd	s3,24(sp)
 508:	0080                	addi	s0,sp,64
 50a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 50c:	c299                	beqz	a3,512 <printint+0x16>
 50e:	0805c863          	bltz	a1,59e <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 512:	2581                	sext.w	a1,a1
  neg = 0;
 514:	4881                	li	a7,0
 516:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 51a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 51c:	2601                	sext.w	a2,a2
 51e:	00000517          	auipc	a0,0x0
 522:	4c250513          	addi	a0,a0,1218 # 9e0 <digits>
 526:	883a                	mv	a6,a4
 528:	2705                	addiw	a4,a4,1
 52a:	02c5f7bb          	remuw	a5,a1,a2
 52e:	1782                	slli	a5,a5,0x20
 530:	9381                	srli	a5,a5,0x20
 532:	97aa                	add	a5,a5,a0
 534:	0007c783          	lbu	a5,0(a5)
 538:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 53c:	0005879b          	sext.w	a5,a1
 540:	02c5d5bb          	divuw	a1,a1,a2
 544:	0685                	addi	a3,a3,1
 546:	fec7f0e3          	bgeu	a5,a2,526 <printint+0x2a>
  if(neg)
 54a:	00088b63          	beqz	a7,560 <printint+0x64>
    buf[i++] = '-';
 54e:	fd040793          	addi	a5,s0,-48
 552:	973e                	add	a4,a4,a5
 554:	02d00793          	li	a5,45
 558:	fef70823          	sb	a5,-16(a4)
 55c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 560:	02e05863          	blez	a4,590 <printint+0x94>
 564:	fc040793          	addi	a5,s0,-64
 568:	00e78933          	add	s2,a5,a4
 56c:	fff78993          	addi	s3,a5,-1
 570:	99ba                	add	s3,s3,a4
 572:	377d                	addiw	a4,a4,-1
 574:	1702                	slli	a4,a4,0x20
 576:	9301                	srli	a4,a4,0x20
 578:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 57c:	fff94583          	lbu	a1,-1(s2)
 580:	8526                	mv	a0,s1
 582:	00000097          	auipc	ra,0x0
 586:	f58080e7          	jalr	-168(ra) # 4da <putc>
  while(--i >= 0)
 58a:	197d                	addi	s2,s2,-1
 58c:	ff3918e3          	bne	s2,s3,57c <printint+0x80>
}
 590:	70e2                	ld	ra,56(sp)
 592:	7442                	ld	s0,48(sp)
 594:	74a2                	ld	s1,40(sp)
 596:	7902                	ld	s2,32(sp)
 598:	69e2                	ld	s3,24(sp)
 59a:	6121                	addi	sp,sp,64
 59c:	8082                	ret
    x = -xx;
 59e:	40b005bb          	negw	a1,a1
    neg = 1;
 5a2:	4885                	li	a7,1
    x = -xx;
 5a4:	bf8d                	j	516 <printint+0x1a>

00000000000005a6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5a6:	7119                	addi	sp,sp,-128
 5a8:	fc86                	sd	ra,120(sp)
 5aa:	f8a2                	sd	s0,112(sp)
 5ac:	f4a6                	sd	s1,104(sp)
 5ae:	f0ca                	sd	s2,96(sp)
 5b0:	ecce                	sd	s3,88(sp)
 5b2:	e8d2                	sd	s4,80(sp)
 5b4:	e4d6                	sd	s5,72(sp)
 5b6:	e0da                	sd	s6,64(sp)
 5b8:	fc5e                	sd	s7,56(sp)
 5ba:	f862                	sd	s8,48(sp)
 5bc:	f466                	sd	s9,40(sp)
 5be:	f06a                	sd	s10,32(sp)
 5c0:	ec6e                	sd	s11,24(sp)
 5c2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5c4:	0005c903          	lbu	s2,0(a1)
 5c8:	18090f63          	beqz	s2,766 <vprintf+0x1c0>
 5cc:	8aaa                	mv	s5,a0
 5ce:	8b32                	mv	s6,a2
 5d0:	00158493          	addi	s1,a1,1
  state = 0;
 5d4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5d6:	02500a13          	li	s4,37
      if(c == 'd'){
 5da:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5de:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5e2:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5e6:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ea:	00000b97          	auipc	s7,0x0
 5ee:	3f6b8b93          	addi	s7,s7,1014 # 9e0 <digits>
 5f2:	a839                	j	610 <vprintf+0x6a>
        putc(fd, c);
 5f4:	85ca                	mv	a1,s2
 5f6:	8556                	mv	a0,s5
 5f8:	00000097          	auipc	ra,0x0
 5fc:	ee2080e7          	jalr	-286(ra) # 4da <putc>
 600:	a019                	j	606 <vprintf+0x60>
    } else if(state == '%'){
 602:	01498f63          	beq	s3,s4,620 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 606:	0485                	addi	s1,s1,1
 608:	fff4c903          	lbu	s2,-1(s1)
 60c:	14090d63          	beqz	s2,766 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 610:	0009079b          	sext.w	a5,s2
    if(state == 0){
 614:	fe0997e3          	bnez	s3,602 <vprintf+0x5c>
      if(c == '%'){
 618:	fd479ee3          	bne	a5,s4,5f4 <vprintf+0x4e>
        state = '%';
 61c:	89be                	mv	s3,a5
 61e:	b7e5                	j	606 <vprintf+0x60>
      if(c == 'd'){
 620:	05878063          	beq	a5,s8,660 <vprintf+0xba>
      } else if(c == 'l') {
 624:	05978c63          	beq	a5,s9,67c <vprintf+0xd6>
      } else if(c == 'x') {
 628:	07a78863          	beq	a5,s10,698 <vprintf+0xf2>
      } else if(c == 'p') {
 62c:	09b78463          	beq	a5,s11,6b4 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 630:	07300713          	li	a4,115
 634:	0ce78663          	beq	a5,a4,700 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 638:	06300713          	li	a4,99
 63c:	0ee78e63          	beq	a5,a4,738 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 640:	11478863          	beq	a5,s4,750 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 644:	85d2                	mv	a1,s4
 646:	8556                	mv	a0,s5
 648:	00000097          	auipc	ra,0x0
 64c:	e92080e7          	jalr	-366(ra) # 4da <putc>
        putc(fd, c);
 650:	85ca                	mv	a1,s2
 652:	8556                	mv	a0,s5
 654:	00000097          	auipc	ra,0x0
 658:	e86080e7          	jalr	-378(ra) # 4da <putc>
      }
      state = 0;
 65c:	4981                	li	s3,0
 65e:	b765                	j	606 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 660:	008b0913          	addi	s2,s6,8
 664:	4685                	li	a3,1
 666:	4629                	li	a2,10
 668:	000b2583          	lw	a1,0(s6)
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	e8e080e7          	jalr	-370(ra) # 4fc <printint>
 676:	8b4a                	mv	s6,s2
      state = 0;
 678:	4981                	li	s3,0
 67a:	b771                	j	606 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 67c:	008b0913          	addi	s2,s6,8
 680:	4681                	li	a3,0
 682:	4629                	li	a2,10
 684:	000b2583          	lw	a1,0(s6)
 688:	8556                	mv	a0,s5
 68a:	00000097          	auipc	ra,0x0
 68e:	e72080e7          	jalr	-398(ra) # 4fc <printint>
 692:	8b4a                	mv	s6,s2
      state = 0;
 694:	4981                	li	s3,0
 696:	bf85                	j	606 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 698:	008b0913          	addi	s2,s6,8
 69c:	4681                	li	a3,0
 69e:	4641                	li	a2,16
 6a0:	000b2583          	lw	a1,0(s6)
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	e56080e7          	jalr	-426(ra) # 4fc <printint>
 6ae:	8b4a                	mv	s6,s2
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	bf91                	j	606 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6b4:	008b0793          	addi	a5,s6,8
 6b8:	f8f43423          	sd	a5,-120(s0)
 6bc:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6c0:	03000593          	li	a1,48
 6c4:	8556                	mv	a0,s5
 6c6:	00000097          	auipc	ra,0x0
 6ca:	e14080e7          	jalr	-492(ra) # 4da <putc>
  putc(fd, 'x');
 6ce:	85ea                	mv	a1,s10
 6d0:	8556                	mv	a0,s5
 6d2:	00000097          	auipc	ra,0x0
 6d6:	e08080e7          	jalr	-504(ra) # 4da <putc>
 6da:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6dc:	03c9d793          	srli	a5,s3,0x3c
 6e0:	97de                	add	a5,a5,s7
 6e2:	0007c583          	lbu	a1,0(a5)
 6e6:	8556                	mv	a0,s5
 6e8:	00000097          	auipc	ra,0x0
 6ec:	df2080e7          	jalr	-526(ra) # 4da <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6f0:	0992                	slli	s3,s3,0x4
 6f2:	397d                	addiw	s2,s2,-1
 6f4:	fe0914e3          	bnez	s2,6dc <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6f8:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6fc:	4981                	li	s3,0
 6fe:	b721                	j	606 <vprintf+0x60>
        s = va_arg(ap, char*);
 700:	008b0993          	addi	s3,s6,8
 704:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 708:	02090163          	beqz	s2,72a <vprintf+0x184>
        while(*s != 0){
 70c:	00094583          	lbu	a1,0(s2)
 710:	c9a1                	beqz	a1,760 <vprintf+0x1ba>
          putc(fd, *s);
 712:	8556                	mv	a0,s5
 714:	00000097          	auipc	ra,0x0
 718:	dc6080e7          	jalr	-570(ra) # 4da <putc>
          s++;
 71c:	0905                	addi	s2,s2,1
        while(*s != 0){
 71e:	00094583          	lbu	a1,0(s2)
 722:	f9e5                	bnez	a1,712 <vprintf+0x16c>
        s = va_arg(ap, char*);
 724:	8b4e                	mv	s6,s3
      state = 0;
 726:	4981                	li	s3,0
 728:	bdf9                	j	606 <vprintf+0x60>
          s = "(null)";
 72a:	00000917          	auipc	s2,0x0
 72e:	2ae90913          	addi	s2,s2,686 # 9d8 <malloc+0x168>
        while(*s != 0){
 732:	02800593          	li	a1,40
 736:	bff1                	j	712 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 738:	008b0913          	addi	s2,s6,8
 73c:	000b4583          	lbu	a1,0(s6)
 740:	8556                	mv	a0,s5
 742:	00000097          	auipc	ra,0x0
 746:	d98080e7          	jalr	-616(ra) # 4da <putc>
 74a:	8b4a                	mv	s6,s2
      state = 0;
 74c:	4981                	li	s3,0
 74e:	bd65                	j	606 <vprintf+0x60>
        putc(fd, c);
 750:	85d2                	mv	a1,s4
 752:	8556                	mv	a0,s5
 754:	00000097          	auipc	ra,0x0
 758:	d86080e7          	jalr	-634(ra) # 4da <putc>
      state = 0;
 75c:	4981                	li	s3,0
 75e:	b565                	j	606 <vprintf+0x60>
        s = va_arg(ap, char*);
 760:	8b4e                	mv	s6,s3
      state = 0;
 762:	4981                	li	s3,0
 764:	b54d                	j	606 <vprintf+0x60>
    }
  }
}
 766:	70e6                	ld	ra,120(sp)
 768:	7446                	ld	s0,112(sp)
 76a:	74a6                	ld	s1,104(sp)
 76c:	7906                	ld	s2,96(sp)
 76e:	69e6                	ld	s3,88(sp)
 770:	6a46                	ld	s4,80(sp)
 772:	6aa6                	ld	s5,72(sp)
 774:	6b06                	ld	s6,64(sp)
 776:	7be2                	ld	s7,56(sp)
 778:	7c42                	ld	s8,48(sp)
 77a:	7ca2                	ld	s9,40(sp)
 77c:	7d02                	ld	s10,32(sp)
 77e:	6de2                	ld	s11,24(sp)
 780:	6109                	addi	sp,sp,128
 782:	8082                	ret

0000000000000784 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 784:	715d                	addi	sp,sp,-80
 786:	ec06                	sd	ra,24(sp)
 788:	e822                	sd	s0,16(sp)
 78a:	1000                	addi	s0,sp,32
 78c:	e010                	sd	a2,0(s0)
 78e:	e414                	sd	a3,8(s0)
 790:	e818                	sd	a4,16(s0)
 792:	ec1c                	sd	a5,24(s0)
 794:	03043023          	sd	a6,32(s0)
 798:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 79c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7a0:	8622                	mv	a2,s0
 7a2:	00000097          	auipc	ra,0x0
 7a6:	e04080e7          	jalr	-508(ra) # 5a6 <vprintf>
}
 7aa:	60e2                	ld	ra,24(sp)
 7ac:	6442                	ld	s0,16(sp)
 7ae:	6161                	addi	sp,sp,80
 7b0:	8082                	ret

00000000000007b2 <printf>:

void
printf(const char *fmt, ...)
{
 7b2:	711d                	addi	sp,sp,-96
 7b4:	ec06                	sd	ra,24(sp)
 7b6:	e822                	sd	s0,16(sp)
 7b8:	1000                	addi	s0,sp,32
 7ba:	e40c                	sd	a1,8(s0)
 7bc:	e810                	sd	a2,16(s0)
 7be:	ec14                	sd	a3,24(s0)
 7c0:	f018                	sd	a4,32(s0)
 7c2:	f41c                	sd	a5,40(s0)
 7c4:	03043823          	sd	a6,48(s0)
 7c8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7cc:	00840613          	addi	a2,s0,8
 7d0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7d4:	85aa                	mv	a1,a0
 7d6:	4505                	li	a0,1
 7d8:	00000097          	auipc	ra,0x0
 7dc:	dce080e7          	jalr	-562(ra) # 5a6 <vprintf>
}
 7e0:	60e2                	ld	ra,24(sp)
 7e2:	6442                	ld	s0,16(sp)
 7e4:	6125                	addi	sp,sp,96
 7e6:	8082                	ret

00000000000007e8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7e8:	1141                	addi	sp,sp,-16
 7ea:	e422                	sd	s0,8(sp)
 7ec:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ee:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f2:	00000797          	auipc	a5,0x0
 7f6:	20e7b783          	ld	a5,526(a5) # a00 <freep>
 7fa:	a805                	j	82a <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7fc:	4618                	lw	a4,8(a2)
 7fe:	9db9                	addw	a1,a1,a4
 800:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 804:	6398                	ld	a4,0(a5)
 806:	6318                	ld	a4,0(a4)
 808:	fee53823          	sd	a4,-16(a0)
 80c:	a091                	j	850 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 80e:	ff852703          	lw	a4,-8(a0)
 812:	9e39                	addw	a2,a2,a4
 814:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 816:	ff053703          	ld	a4,-16(a0)
 81a:	e398                	sd	a4,0(a5)
 81c:	a099                	j	862 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 81e:	6398                	ld	a4,0(a5)
 820:	00e7e463          	bltu	a5,a4,828 <free+0x40>
 824:	00e6ea63          	bltu	a3,a4,838 <free+0x50>
{
 828:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 82a:	fed7fae3          	bgeu	a5,a3,81e <free+0x36>
 82e:	6398                	ld	a4,0(a5)
 830:	00e6e463          	bltu	a3,a4,838 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 834:	fee7eae3          	bltu	a5,a4,828 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 838:	ff852583          	lw	a1,-8(a0)
 83c:	6390                	ld	a2,0(a5)
 83e:	02059713          	slli	a4,a1,0x20
 842:	9301                	srli	a4,a4,0x20
 844:	0712                	slli	a4,a4,0x4
 846:	9736                	add	a4,a4,a3
 848:	fae60ae3          	beq	a2,a4,7fc <free+0x14>
    bp->s.ptr = p->s.ptr;
 84c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 850:	4790                	lw	a2,8(a5)
 852:	02061713          	slli	a4,a2,0x20
 856:	9301                	srli	a4,a4,0x20
 858:	0712                	slli	a4,a4,0x4
 85a:	973e                	add	a4,a4,a5
 85c:	fae689e3          	beq	a3,a4,80e <free+0x26>
  } else
    p->s.ptr = bp;
 860:	e394                	sd	a3,0(a5)
  freep = p;
 862:	00000717          	auipc	a4,0x0
 866:	18f73f23          	sd	a5,414(a4) # a00 <freep>
}
 86a:	6422                	ld	s0,8(sp)
 86c:	0141                	addi	sp,sp,16
 86e:	8082                	ret

0000000000000870 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 870:	7139                	addi	sp,sp,-64
 872:	fc06                	sd	ra,56(sp)
 874:	f822                	sd	s0,48(sp)
 876:	f426                	sd	s1,40(sp)
 878:	f04a                	sd	s2,32(sp)
 87a:	ec4e                	sd	s3,24(sp)
 87c:	e852                	sd	s4,16(sp)
 87e:	e456                	sd	s5,8(sp)
 880:	e05a                	sd	s6,0(sp)
 882:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 884:	02051493          	slli	s1,a0,0x20
 888:	9081                	srli	s1,s1,0x20
 88a:	04bd                	addi	s1,s1,15
 88c:	8091                	srli	s1,s1,0x4
 88e:	0014899b          	addiw	s3,s1,1
 892:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 894:	00000517          	auipc	a0,0x0
 898:	16c53503          	ld	a0,364(a0) # a00 <freep>
 89c:	c515                	beqz	a0,8c8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 89e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8a0:	4798                	lw	a4,8(a5)
 8a2:	02977f63          	bgeu	a4,s1,8e0 <malloc+0x70>
 8a6:	8a4e                	mv	s4,s3
 8a8:	0009871b          	sext.w	a4,s3
 8ac:	6685                	lui	a3,0x1
 8ae:	00d77363          	bgeu	a4,a3,8b4 <malloc+0x44>
 8b2:	6a05                	lui	s4,0x1
 8b4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8b8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8bc:	00000917          	auipc	s2,0x0
 8c0:	14490913          	addi	s2,s2,324 # a00 <freep>
  if(p == (char*)-1)
 8c4:	5afd                	li	s5,-1
 8c6:	a88d                	j	938 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 8c8:	00000797          	auipc	a5,0x0
 8cc:	14078793          	addi	a5,a5,320 # a08 <base>
 8d0:	00000717          	auipc	a4,0x0
 8d4:	12f73823          	sd	a5,304(a4) # a00 <freep>
 8d8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8da:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8de:	b7e1                	j	8a6 <malloc+0x36>
      if(p->s.size == nunits)
 8e0:	02e48b63          	beq	s1,a4,916 <malloc+0xa6>
        p->s.size -= nunits;
 8e4:	4137073b          	subw	a4,a4,s3
 8e8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8ea:	1702                	slli	a4,a4,0x20
 8ec:	9301                	srli	a4,a4,0x20
 8ee:	0712                	slli	a4,a4,0x4
 8f0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8f2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8f6:	00000717          	auipc	a4,0x0
 8fa:	10a73523          	sd	a0,266(a4) # a00 <freep>
      return (void*)(p + 1);
 8fe:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 902:	70e2                	ld	ra,56(sp)
 904:	7442                	ld	s0,48(sp)
 906:	74a2                	ld	s1,40(sp)
 908:	7902                	ld	s2,32(sp)
 90a:	69e2                	ld	s3,24(sp)
 90c:	6a42                	ld	s4,16(sp)
 90e:	6aa2                	ld	s5,8(sp)
 910:	6b02                	ld	s6,0(sp)
 912:	6121                	addi	sp,sp,64
 914:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 916:	6398                	ld	a4,0(a5)
 918:	e118                	sd	a4,0(a0)
 91a:	bff1                	j	8f6 <malloc+0x86>
  hp->s.size = nu;
 91c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 920:	0541                	addi	a0,a0,16
 922:	00000097          	auipc	ra,0x0
 926:	ec6080e7          	jalr	-314(ra) # 7e8 <free>
  return freep;
 92a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 92e:	d971                	beqz	a0,902 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 930:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 932:	4798                	lw	a4,8(a5)
 934:	fa9776e3          	bgeu	a4,s1,8e0 <malloc+0x70>
    if(p == freep)
 938:	00093703          	ld	a4,0(s2)
 93c:	853e                	mv	a0,a5
 93e:	fef719e3          	bne	a4,a5,930 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 942:	8552                	mv	a0,s4
 944:	00000097          	auipc	ra,0x0
 948:	b6e080e7          	jalr	-1170(ra) # 4b2 <sbrk>
  if(p == (char*)-1)
 94c:	fd5518e3          	bne	a0,s5,91c <malloc+0xac>
        return 0;
 950:	4501                	li	a0,0
 952:	bf45                	j	902 <malloc+0x92>
