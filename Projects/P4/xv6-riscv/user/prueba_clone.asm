
user/_prueba_clone:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <worker>:
   printf ("El valor de la variable global ha pasado a valer: %d\n", global);
   exit(0);
}

void
worker(void *arg_ptr) {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
   //assert(global == 1);
   global = 5;
   8:	4795                	li	a5,5
   a:	00001717          	auipc	a4,0x1
   e:	96f72923          	sw	a5,-1678(a4) # 97c <global>
   printf ("El thread ha entrado a ejecutar en la función worker\n");
  12:	00001517          	auipc	a0,0x1
  16:	87650513          	addi	a0,a0,-1930 # 888 <malloc+0xe4>
  1a:	00000097          	auipc	ra,0x0
  1e:	6cc080e7          	jalr	1740(ra) # 6e6 <printf>
   exit(0);
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	33a080e7          	jalr	826(ra) # 35e <exit>

000000000000002c <main>:
{
  2c:	1101                	addi	sp,sp,-32
  2e:	ec06                	sd	ra,24(sp)
  30:	e822                	sd	s0,16(sp)
  32:	1000                	addi	s0,sp,32
   ppid = getpid();
  34:	00000097          	auipc	ra,0x0
  38:	3aa080e7          	jalr	938(ra) # 3de <getpid>
  3c:	85aa                	mv	a1,a0
  3e:	00001797          	auipc	a5,0x1
  42:	94a7a123          	sw	a0,-1726(a5) # 980 <ppid>
   printf ("PID padre: %d\n", ppid);
  46:	00001517          	auipc	a0,0x1
  4a:	87a50513          	addi	a0,a0,-1926 # 8c0 <malloc+0x11c>
  4e:	00000097          	auipc	ra,0x0
  52:	698080e7          	jalr	1688(ra) # 6e6 <printf>
   void *stack = malloc(PGSIZE*2);
  56:	6509                	lui	a0,0x2
  58:	00000097          	auipc	ra,0x0
  5c:	74c080e7          	jalr	1868(ra) # 7a4 <malloc>
   if((uint64)stack % PGSIZE){
  60:	03451793          	slli	a5,a0,0x34
  64:	e781                	bnez	a5,6c <main+0x40>
   void *stack = malloc(PGSIZE*2);
  66:	fea43423          	sd	a0,-24(s0)
  6a:	a801                	j	7a <main+0x4e>
  6c:	0347d713          	srli	a4,a5,0x34
     stack = stack + (4096 - (uint64)stack % PGSIZE);
  70:	6785                	lui	a5,0x1
  72:	8f99                	sub	a5,a5,a4
  74:	953e                	add	a0,a0,a5
  76:	fea43423          	sd	a0,-24(s0)
   printf ("Stack alocatado y listo para usarse\n");
  7a:	00001517          	auipc	a0,0x1
  7e:	85650513          	addi	a0,a0,-1962 # 8d0 <malloc+0x12c>
  82:	00000097          	auipc	ra,0x0
  86:	664080e7          	jalr	1636(ra) # 6e6 <printf>
   int clone_pid = clone(worker, 0, stack);
  8a:	fe843603          	ld	a2,-24(s0)
  8e:	4581                	li	a1,0
  90:	00000517          	auipc	a0,0x0
  94:	f7050513          	addi	a0,a0,-144 # 0 <worker>
  98:	00000097          	auipc	ra,0x0
  9c:	366080e7          	jalr	870(ra) # 3fe <clone>
  a0:	85aa                	mv	a1,a0
   printf ("Resultado clone: %d\n", clone_pid);
  a2:	00001517          	auipc	a0,0x1
  a6:	85650513          	addi	a0,a0,-1962 # 8f8 <malloc+0x154>
  aa:	00000097          	auipc	ra,0x0
  ae:	63c080e7          	jalr	1596(ra) # 6e6 <printf>
   printf ("El test ha pasado.");
  b2:	00001517          	auipc	a0,0x1
  b6:	85e50513          	addi	a0,a0,-1954 # 910 <malloc+0x16c>
  ba:	00000097          	auipc	ra,0x0
  be:	62c080e7          	jalr	1580(ra) # 6e6 <printf>
   join(&stack); //esperamos a que el proceso finalice
  c2:	fe840513          	addi	a0,s0,-24
  c6:	00000097          	auipc	ra,0x0
  ca:	340080e7          	jalr	832(ra) # 406 <join>
   printf ("El valor de la variable global ha pasado a valer: %d\n", global);
  ce:	00001597          	auipc	a1,0x1
  d2:	8ae5a583          	lw	a1,-1874(a1) # 97c <global>
  d6:	00001517          	auipc	a0,0x1
  da:	85250513          	addi	a0,a0,-1966 # 928 <malloc+0x184>
  de:	00000097          	auipc	ra,0x0
  e2:	608080e7          	jalr	1544(ra) # 6e6 <printf>
   exit(0);
  e6:	4501                	li	a0,0
  e8:	00000097          	auipc	ra,0x0
  ec:	276080e7          	jalr	630(ra) # 35e <exit>

00000000000000f0 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  f0:	1141                	addi	sp,sp,-16
  f2:	e422                	sd	s0,8(sp)
  f4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f6:	87aa                	mv	a5,a0
  f8:	0585                	addi	a1,a1,1
  fa:	0785                	addi	a5,a5,1
  fc:	fff5c703          	lbu	a4,-1(a1)
 100:	fee78fa3          	sb	a4,-1(a5) # fff <__BSS_END__+0x65f>
 104:	fb75                	bnez	a4,f8 <strcpy+0x8>
    ;
  return os;
}
 106:	6422                	ld	s0,8(sp)
 108:	0141                	addi	sp,sp,16
 10a:	8082                	ret

000000000000010c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 112:	00054783          	lbu	a5,0(a0)
 116:	cb91                	beqz	a5,12a <strcmp+0x1e>
 118:	0005c703          	lbu	a4,0(a1)
 11c:	00f71763          	bne	a4,a5,12a <strcmp+0x1e>
    p++, q++;
 120:	0505                	addi	a0,a0,1
 122:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 124:	00054783          	lbu	a5,0(a0)
 128:	fbe5                	bnez	a5,118 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 12a:	0005c503          	lbu	a0,0(a1)
}
 12e:	40a7853b          	subw	a0,a5,a0
 132:	6422                	ld	s0,8(sp)
 134:	0141                	addi	sp,sp,16
 136:	8082                	ret

0000000000000138 <strlen>:

uint
strlen(const char *s)
{
 138:	1141                	addi	sp,sp,-16
 13a:	e422                	sd	s0,8(sp)
 13c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 13e:	00054783          	lbu	a5,0(a0)
 142:	cf91                	beqz	a5,15e <strlen+0x26>
 144:	0505                	addi	a0,a0,1
 146:	87aa                	mv	a5,a0
 148:	4685                	li	a3,1
 14a:	9e89                	subw	a3,a3,a0
 14c:	00f6853b          	addw	a0,a3,a5
 150:	0785                	addi	a5,a5,1
 152:	fff7c703          	lbu	a4,-1(a5)
 156:	fb7d                	bnez	a4,14c <strlen+0x14>
    ;
  return n;
}
 158:	6422                	ld	s0,8(sp)
 15a:	0141                	addi	sp,sp,16
 15c:	8082                	ret
  for(n = 0; s[n]; n++)
 15e:	4501                	li	a0,0
 160:	bfe5                	j	158 <strlen+0x20>

0000000000000162 <memset>:

void*
memset(void *dst, int c, uint n)
{
 162:	1141                	addi	sp,sp,-16
 164:	e422                	sd	s0,8(sp)
 166:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 168:	ca19                	beqz	a2,17e <memset+0x1c>
 16a:	87aa                	mv	a5,a0
 16c:	1602                	slli	a2,a2,0x20
 16e:	9201                	srli	a2,a2,0x20
 170:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 174:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 178:	0785                	addi	a5,a5,1
 17a:	fee79de3          	bne	a5,a4,174 <memset+0x12>
  }
  return dst;
}
 17e:	6422                	ld	s0,8(sp)
 180:	0141                	addi	sp,sp,16
 182:	8082                	ret

0000000000000184 <strchr>:

char*
strchr(const char *s, char c)
{
 184:	1141                	addi	sp,sp,-16
 186:	e422                	sd	s0,8(sp)
 188:	0800                	addi	s0,sp,16
  for(; *s; s++)
 18a:	00054783          	lbu	a5,0(a0)
 18e:	cb99                	beqz	a5,1a4 <strchr+0x20>
    if(*s == c)
 190:	00f58763          	beq	a1,a5,19e <strchr+0x1a>
  for(; *s; s++)
 194:	0505                	addi	a0,a0,1
 196:	00054783          	lbu	a5,0(a0)
 19a:	fbfd                	bnez	a5,190 <strchr+0xc>
      return (char*)s;
  return 0;
 19c:	4501                	li	a0,0
}
 19e:	6422                	ld	s0,8(sp)
 1a0:	0141                	addi	sp,sp,16
 1a2:	8082                	ret
  return 0;
 1a4:	4501                	li	a0,0
 1a6:	bfe5                	j	19e <strchr+0x1a>

00000000000001a8 <gets>:

char*
gets(char *buf, int max)
{
 1a8:	711d                	addi	sp,sp,-96
 1aa:	ec86                	sd	ra,88(sp)
 1ac:	e8a2                	sd	s0,80(sp)
 1ae:	e4a6                	sd	s1,72(sp)
 1b0:	e0ca                	sd	s2,64(sp)
 1b2:	fc4e                	sd	s3,56(sp)
 1b4:	f852                	sd	s4,48(sp)
 1b6:	f456                	sd	s5,40(sp)
 1b8:	f05a                	sd	s6,32(sp)
 1ba:	ec5e                	sd	s7,24(sp)
 1bc:	1080                	addi	s0,sp,96
 1be:	8baa                	mv	s7,a0
 1c0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c2:	892a                	mv	s2,a0
 1c4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1c6:	4aa9                	li	s5,10
 1c8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ca:	89a6                	mv	s3,s1
 1cc:	2485                	addiw	s1,s1,1
 1ce:	0344d863          	bge	s1,s4,1fe <gets+0x56>
    cc = read(0, &c, 1);
 1d2:	4605                	li	a2,1
 1d4:	faf40593          	addi	a1,s0,-81
 1d8:	4501                	li	a0,0
 1da:	00000097          	auipc	ra,0x0
 1de:	19c080e7          	jalr	412(ra) # 376 <read>
    if(cc < 1)
 1e2:	00a05e63          	blez	a0,1fe <gets+0x56>
    buf[i++] = c;
 1e6:	faf44783          	lbu	a5,-81(s0)
 1ea:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ee:	01578763          	beq	a5,s5,1fc <gets+0x54>
 1f2:	0905                	addi	s2,s2,1
 1f4:	fd679be3          	bne	a5,s6,1ca <gets+0x22>
  for(i=0; i+1 < max; ){
 1f8:	89a6                	mv	s3,s1
 1fa:	a011                	j	1fe <gets+0x56>
 1fc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1fe:	99de                	add	s3,s3,s7
 200:	00098023          	sb	zero,0(s3)
  return buf;
}
 204:	855e                	mv	a0,s7
 206:	60e6                	ld	ra,88(sp)
 208:	6446                	ld	s0,80(sp)
 20a:	64a6                	ld	s1,72(sp)
 20c:	6906                	ld	s2,64(sp)
 20e:	79e2                	ld	s3,56(sp)
 210:	7a42                	ld	s4,48(sp)
 212:	7aa2                	ld	s5,40(sp)
 214:	7b02                	ld	s6,32(sp)
 216:	6be2                	ld	s7,24(sp)
 218:	6125                	addi	sp,sp,96
 21a:	8082                	ret

000000000000021c <stat>:

int
stat(const char *n, struct stat *st)
{
 21c:	1101                	addi	sp,sp,-32
 21e:	ec06                	sd	ra,24(sp)
 220:	e822                	sd	s0,16(sp)
 222:	e426                	sd	s1,8(sp)
 224:	e04a                	sd	s2,0(sp)
 226:	1000                	addi	s0,sp,32
 228:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 22a:	4581                	li	a1,0
 22c:	00000097          	auipc	ra,0x0
 230:	172080e7          	jalr	370(ra) # 39e <open>
  if(fd < 0)
 234:	02054563          	bltz	a0,25e <stat+0x42>
 238:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 23a:	85ca                	mv	a1,s2
 23c:	00000097          	auipc	ra,0x0
 240:	17a080e7          	jalr	378(ra) # 3b6 <fstat>
 244:	892a                	mv	s2,a0
  close(fd);
 246:	8526                	mv	a0,s1
 248:	00000097          	auipc	ra,0x0
 24c:	13e080e7          	jalr	318(ra) # 386 <close>
  return r;
}
 250:	854a                	mv	a0,s2
 252:	60e2                	ld	ra,24(sp)
 254:	6442                	ld	s0,16(sp)
 256:	64a2                	ld	s1,8(sp)
 258:	6902                	ld	s2,0(sp)
 25a:	6105                	addi	sp,sp,32
 25c:	8082                	ret
    return -1;
 25e:	597d                	li	s2,-1
 260:	bfc5                	j	250 <stat+0x34>

0000000000000262 <atoi>:

int
atoi(const char *s)
{
 262:	1141                	addi	sp,sp,-16
 264:	e422                	sd	s0,8(sp)
 266:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 268:	00054603          	lbu	a2,0(a0)
 26c:	fd06079b          	addiw	a5,a2,-48
 270:	0ff7f793          	andi	a5,a5,255
 274:	4725                	li	a4,9
 276:	02f76963          	bltu	a4,a5,2a8 <atoi+0x46>
 27a:	86aa                	mv	a3,a0
  n = 0;
 27c:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 27e:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 280:	0685                	addi	a3,a3,1
 282:	0025179b          	slliw	a5,a0,0x2
 286:	9fa9                	addw	a5,a5,a0
 288:	0017979b          	slliw	a5,a5,0x1
 28c:	9fb1                	addw	a5,a5,a2
 28e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 292:	0006c603          	lbu	a2,0(a3)
 296:	fd06071b          	addiw	a4,a2,-48
 29a:	0ff77713          	andi	a4,a4,255
 29e:	fee5f1e3          	bgeu	a1,a4,280 <atoi+0x1e>
  return n;
}
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret
  n = 0;
 2a8:	4501                	li	a0,0
 2aa:	bfe5                	j	2a2 <atoi+0x40>

00000000000002ac <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2ac:	1141                	addi	sp,sp,-16
 2ae:	e422                	sd	s0,8(sp)
 2b0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2b2:	02b57463          	bgeu	a0,a1,2da <memmove+0x2e>
    while(n-- > 0)
 2b6:	00c05f63          	blez	a2,2d4 <memmove+0x28>
 2ba:	1602                	slli	a2,a2,0x20
 2bc:	9201                	srli	a2,a2,0x20
 2be:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2c2:	872a                	mv	a4,a0
      *dst++ = *src++;
 2c4:	0585                	addi	a1,a1,1
 2c6:	0705                	addi	a4,a4,1
 2c8:	fff5c683          	lbu	a3,-1(a1)
 2cc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2d0:	fee79ae3          	bne	a5,a4,2c4 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2d4:	6422                	ld	s0,8(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret
    dst += n;
 2da:	00c50733          	add	a4,a0,a2
    src += n;
 2de:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2e0:	fec05ae3          	blez	a2,2d4 <memmove+0x28>
 2e4:	fff6079b          	addiw	a5,a2,-1
 2e8:	1782                	slli	a5,a5,0x20
 2ea:	9381                	srli	a5,a5,0x20
 2ec:	fff7c793          	not	a5,a5
 2f0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2f2:	15fd                	addi	a1,a1,-1
 2f4:	177d                	addi	a4,a4,-1
 2f6:	0005c683          	lbu	a3,0(a1)
 2fa:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2fe:	fee79ae3          	bne	a5,a4,2f2 <memmove+0x46>
 302:	bfc9                	j	2d4 <memmove+0x28>

0000000000000304 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 304:	1141                	addi	sp,sp,-16
 306:	e422                	sd	s0,8(sp)
 308:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 30a:	ca05                	beqz	a2,33a <memcmp+0x36>
 30c:	fff6069b          	addiw	a3,a2,-1
 310:	1682                	slli	a3,a3,0x20
 312:	9281                	srli	a3,a3,0x20
 314:	0685                	addi	a3,a3,1
 316:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 318:	00054783          	lbu	a5,0(a0)
 31c:	0005c703          	lbu	a4,0(a1)
 320:	00e79863          	bne	a5,a4,330 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 324:	0505                	addi	a0,a0,1
    p2++;
 326:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 328:	fed518e3          	bne	a0,a3,318 <memcmp+0x14>
  }
  return 0;
 32c:	4501                	li	a0,0
 32e:	a019                	j	334 <memcmp+0x30>
      return *p1 - *p2;
 330:	40e7853b          	subw	a0,a5,a4
}
 334:	6422                	ld	s0,8(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret
  return 0;
 33a:	4501                	li	a0,0
 33c:	bfe5                	j	334 <memcmp+0x30>

000000000000033e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 33e:	1141                	addi	sp,sp,-16
 340:	e406                	sd	ra,8(sp)
 342:	e022                	sd	s0,0(sp)
 344:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 346:	00000097          	auipc	ra,0x0
 34a:	f66080e7          	jalr	-154(ra) # 2ac <memmove>
}
 34e:	60a2                	ld	ra,8(sp)
 350:	6402                	ld	s0,0(sp)
 352:	0141                	addi	sp,sp,16
 354:	8082                	ret

0000000000000356 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 356:	4885                	li	a7,1
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <exit>:
.global exit
exit:
 li a7, SYS_exit
 35e:	4889                	li	a7,2
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <wait>:
.global wait
wait:
 li a7, SYS_wait
 366:	488d                	li	a7,3
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 36e:	4891                	li	a7,4
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <read>:
.global read
read:
 li a7, SYS_read
 376:	4895                	li	a7,5
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <write>:
.global write
write:
 li a7, SYS_write
 37e:	48c1                	li	a7,16
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <close>:
.global close
close:
 li a7, SYS_close
 386:	48d5                	li	a7,21
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <kill>:
.global kill
kill:
 li a7, SYS_kill
 38e:	4899                	li	a7,6
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <exec>:
.global exec
exec:
 li a7, SYS_exec
 396:	489d                	li	a7,7
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <open>:
.global open
open:
 li a7, SYS_open
 39e:	48bd                	li	a7,15
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3a6:	48c5                	li	a7,17
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3ae:	48c9                	li	a7,18
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3b6:	48a1                	li	a7,8
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <link>:
.global link
link:
 li a7, SYS_link
 3be:	48cd                	li	a7,19
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3c6:	48d1                	li	a7,20
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3ce:	48a5                	li	a7,9
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3d6:	48a9                	li	a7,10
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3de:	48ad                	li	a7,11
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3e6:	48b1                	li	a7,12
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3ee:	48b5                	li	a7,13
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3f6:	48b9                	li	a7,14
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <clone>:
.global clone
clone:
 li a7, SYS_clone
 3fe:	48d9                	li	a7,22
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <join>:
.global join
join:
 li a7, SYS_join
 406:	48dd                	li	a7,23
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 40e:	1101                	addi	sp,sp,-32
 410:	ec06                	sd	ra,24(sp)
 412:	e822                	sd	s0,16(sp)
 414:	1000                	addi	s0,sp,32
 416:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 41a:	4605                	li	a2,1
 41c:	fef40593          	addi	a1,s0,-17
 420:	00000097          	auipc	ra,0x0
 424:	f5e080e7          	jalr	-162(ra) # 37e <write>
}
 428:	60e2                	ld	ra,24(sp)
 42a:	6442                	ld	s0,16(sp)
 42c:	6105                	addi	sp,sp,32
 42e:	8082                	ret

0000000000000430 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 430:	7139                	addi	sp,sp,-64
 432:	fc06                	sd	ra,56(sp)
 434:	f822                	sd	s0,48(sp)
 436:	f426                	sd	s1,40(sp)
 438:	f04a                	sd	s2,32(sp)
 43a:	ec4e                	sd	s3,24(sp)
 43c:	0080                	addi	s0,sp,64
 43e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 440:	c299                	beqz	a3,446 <printint+0x16>
 442:	0805c863          	bltz	a1,4d2 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 446:	2581                	sext.w	a1,a1
  neg = 0;
 448:	4881                	li	a7,0
 44a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 44e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 450:	2601                	sext.w	a2,a2
 452:	00000517          	auipc	a0,0x0
 456:	51650513          	addi	a0,a0,1302 # 968 <digits>
 45a:	883a                	mv	a6,a4
 45c:	2705                	addiw	a4,a4,1
 45e:	02c5f7bb          	remuw	a5,a1,a2
 462:	1782                	slli	a5,a5,0x20
 464:	9381                	srli	a5,a5,0x20
 466:	97aa                	add	a5,a5,a0
 468:	0007c783          	lbu	a5,0(a5)
 46c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 470:	0005879b          	sext.w	a5,a1
 474:	02c5d5bb          	divuw	a1,a1,a2
 478:	0685                	addi	a3,a3,1
 47a:	fec7f0e3          	bgeu	a5,a2,45a <printint+0x2a>
  if(neg)
 47e:	00088b63          	beqz	a7,494 <printint+0x64>
    buf[i++] = '-';
 482:	fd040793          	addi	a5,s0,-48
 486:	973e                	add	a4,a4,a5
 488:	02d00793          	li	a5,45
 48c:	fef70823          	sb	a5,-16(a4)
 490:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 494:	02e05863          	blez	a4,4c4 <printint+0x94>
 498:	fc040793          	addi	a5,s0,-64
 49c:	00e78933          	add	s2,a5,a4
 4a0:	fff78993          	addi	s3,a5,-1
 4a4:	99ba                	add	s3,s3,a4
 4a6:	377d                	addiw	a4,a4,-1
 4a8:	1702                	slli	a4,a4,0x20
 4aa:	9301                	srli	a4,a4,0x20
 4ac:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4b0:	fff94583          	lbu	a1,-1(s2)
 4b4:	8526                	mv	a0,s1
 4b6:	00000097          	auipc	ra,0x0
 4ba:	f58080e7          	jalr	-168(ra) # 40e <putc>
  while(--i >= 0)
 4be:	197d                	addi	s2,s2,-1
 4c0:	ff3918e3          	bne	s2,s3,4b0 <printint+0x80>
}
 4c4:	70e2                	ld	ra,56(sp)
 4c6:	7442                	ld	s0,48(sp)
 4c8:	74a2                	ld	s1,40(sp)
 4ca:	7902                	ld	s2,32(sp)
 4cc:	69e2                	ld	s3,24(sp)
 4ce:	6121                	addi	sp,sp,64
 4d0:	8082                	ret
    x = -xx;
 4d2:	40b005bb          	negw	a1,a1
    neg = 1;
 4d6:	4885                	li	a7,1
    x = -xx;
 4d8:	bf8d                	j	44a <printint+0x1a>

00000000000004da <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4da:	7119                	addi	sp,sp,-128
 4dc:	fc86                	sd	ra,120(sp)
 4de:	f8a2                	sd	s0,112(sp)
 4e0:	f4a6                	sd	s1,104(sp)
 4e2:	f0ca                	sd	s2,96(sp)
 4e4:	ecce                	sd	s3,88(sp)
 4e6:	e8d2                	sd	s4,80(sp)
 4e8:	e4d6                	sd	s5,72(sp)
 4ea:	e0da                	sd	s6,64(sp)
 4ec:	fc5e                	sd	s7,56(sp)
 4ee:	f862                	sd	s8,48(sp)
 4f0:	f466                	sd	s9,40(sp)
 4f2:	f06a                	sd	s10,32(sp)
 4f4:	ec6e                	sd	s11,24(sp)
 4f6:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4f8:	0005c903          	lbu	s2,0(a1)
 4fc:	18090f63          	beqz	s2,69a <vprintf+0x1c0>
 500:	8aaa                	mv	s5,a0
 502:	8b32                	mv	s6,a2
 504:	00158493          	addi	s1,a1,1
  state = 0;
 508:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 50a:	02500a13          	li	s4,37
      if(c == 'd'){
 50e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 512:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 516:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 51a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 51e:	00000b97          	auipc	s7,0x0
 522:	44ab8b93          	addi	s7,s7,1098 # 968 <digits>
 526:	a839                	j	544 <vprintf+0x6a>
        putc(fd, c);
 528:	85ca                	mv	a1,s2
 52a:	8556                	mv	a0,s5
 52c:	00000097          	auipc	ra,0x0
 530:	ee2080e7          	jalr	-286(ra) # 40e <putc>
 534:	a019                	j	53a <vprintf+0x60>
    } else if(state == '%'){
 536:	01498f63          	beq	s3,s4,554 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 53a:	0485                	addi	s1,s1,1
 53c:	fff4c903          	lbu	s2,-1(s1)
 540:	14090d63          	beqz	s2,69a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 544:	0009079b          	sext.w	a5,s2
    if(state == 0){
 548:	fe0997e3          	bnez	s3,536 <vprintf+0x5c>
      if(c == '%'){
 54c:	fd479ee3          	bne	a5,s4,528 <vprintf+0x4e>
        state = '%';
 550:	89be                	mv	s3,a5
 552:	b7e5                	j	53a <vprintf+0x60>
      if(c == 'd'){
 554:	05878063          	beq	a5,s8,594 <vprintf+0xba>
      } else if(c == 'l') {
 558:	05978c63          	beq	a5,s9,5b0 <vprintf+0xd6>
      } else if(c == 'x') {
 55c:	07a78863          	beq	a5,s10,5cc <vprintf+0xf2>
      } else if(c == 'p') {
 560:	09b78463          	beq	a5,s11,5e8 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 564:	07300713          	li	a4,115
 568:	0ce78663          	beq	a5,a4,634 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 56c:	06300713          	li	a4,99
 570:	0ee78e63          	beq	a5,a4,66c <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 574:	11478863          	beq	a5,s4,684 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 578:	85d2                	mv	a1,s4
 57a:	8556                	mv	a0,s5
 57c:	00000097          	auipc	ra,0x0
 580:	e92080e7          	jalr	-366(ra) # 40e <putc>
        putc(fd, c);
 584:	85ca                	mv	a1,s2
 586:	8556                	mv	a0,s5
 588:	00000097          	auipc	ra,0x0
 58c:	e86080e7          	jalr	-378(ra) # 40e <putc>
      }
      state = 0;
 590:	4981                	li	s3,0
 592:	b765                	j	53a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 594:	008b0913          	addi	s2,s6,8
 598:	4685                	li	a3,1
 59a:	4629                	li	a2,10
 59c:	000b2583          	lw	a1,0(s6)
 5a0:	8556                	mv	a0,s5
 5a2:	00000097          	auipc	ra,0x0
 5a6:	e8e080e7          	jalr	-370(ra) # 430 <printint>
 5aa:	8b4a                	mv	s6,s2
      state = 0;
 5ac:	4981                	li	s3,0
 5ae:	b771                	j	53a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5b0:	008b0913          	addi	s2,s6,8
 5b4:	4681                	li	a3,0
 5b6:	4629                	li	a2,10
 5b8:	000b2583          	lw	a1,0(s6)
 5bc:	8556                	mv	a0,s5
 5be:	00000097          	auipc	ra,0x0
 5c2:	e72080e7          	jalr	-398(ra) # 430 <printint>
 5c6:	8b4a                	mv	s6,s2
      state = 0;
 5c8:	4981                	li	s3,0
 5ca:	bf85                	j	53a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5cc:	008b0913          	addi	s2,s6,8
 5d0:	4681                	li	a3,0
 5d2:	4641                	li	a2,16
 5d4:	000b2583          	lw	a1,0(s6)
 5d8:	8556                	mv	a0,s5
 5da:	00000097          	auipc	ra,0x0
 5de:	e56080e7          	jalr	-426(ra) # 430 <printint>
 5e2:	8b4a                	mv	s6,s2
      state = 0;
 5e4:	4981                	li	s3,0
 5e6:	bf91                	j	53a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5e8:	008b0793          	addi	a5,s6,8
 5ec:	f8f43423          	sd	a5,-120(s0)
 5f0:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5f4:	03000593          	li	a1,48
 5f8:	8556                	mv	a0,s5
 5fa:	00000097          	auipc	ra,0x0
 5fe:	e14080e7          	jalr	-492(ra) # 40e <putc>
  putc(fd, 'x');
 602:	85ea                	mv	a1,s10
 604:	8556                	mv	a0,s5
 606:	00000097          	auipc	ra,0x0
 60a:	e08080e7          	jalr	-504(ra) # 40e <putc>
 60e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 610:	03c9d793          	srli	a5,s3,0x3c
 614:	97de                	add	a5,a5,s7
 616:	0007c583          	lbu	a1,0(a5)
 61a:	8556                	mv	a0,s5
 61c:	00000097          	auipc	ra,0x0
 620:	df2080e7          	jalr	-526(ra) # 40e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 624:	0992                	slli	s3,s3,0x4
 626:	397d                	addiw	s2,s2,-1
 628:	fe0914e3          	bnez	s2,610 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 62c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 630:	4981                	li	s3,0
 632:	b721                	j	53a <vprintf+0x60>
        s = va_arg(ap, char*);
 634:	008b0993          	addi	s3,s6,8
 638:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 63c:	02090163          	beqz	s2,65e <vprintf+0x184>
        while(*s != 0){
 640:	00094583          	lbu	a1,0(s2)
 644:	c9a1                	beqz	a1,694 <vprintf+0x1ba>
          putc(fd, *s);
 646:	8556                	mv	a0,s5
 648:	00000097          	auipc	ra,0x0
 64c:	dc6080e7          	jalr	-570(ra) # 40e <putc>
          s++;
 650:	0905                	addi	s2,s2,1
        while(*s != 0){
 652:	00094583          	lbu	a1,0(s2)
 656:	f9e5                	bnez	a1,646 <vprintf+0x16c>
        s = va_arg(ap, char*);
 658:	8b4e                	mv	s6,s3
      state = 0;
 65a:	4981                	li	s3,0
 65c:	bdf9                	j	53a <vprintf+0x60>
          s = "(null)";
 65e:	00000917          	auipc	s2,0x0
 662:	30290913          	addi	s2,s2,770 # 960 <malloc+0x1bc>
        while(*s != 0){
 666:	02800593          	li	a1,40
 66a:	bff1                	j	646 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 66c:	008b0913          	addi	s2,s6,8
 670:	000b4583          	lbu	a1,0(s6)
 674:	8556                	mv	a0,s5
 676:	00000097          	auipc	ra,0x0
 67a:	d98080e7          	jalr	-616(ra) # 40e <putc>
 67e:	8b4a                	mv	s6,s2
      state = 0;
 680:	4981                	li	s3,0
 682:	bd65                	j	53a <vprintf+0x60>
        putc(fd, c);
 684:	85d2                	mv	a1,s4
 686:	8556                	mv	a0,s5
 688:	00000097          	auipc	ra,0x0
 68c:	d86080e7          	jalr	-634(ra) # 40e <putc>
      state = 0;
 690:	4981                	li	s3,0
 692:	b565                	j	53a <vprintf+0x60>
        s = va_arg(ap, char*);
 694:	8b4e                	mv	s6,s3
      state = 0;
 696:	4981                	li	s3,0
 698:	b54d                	j	53a <vprintf+0x60>
    }
  }
}
 69a:	70e6                	ld	ra,120(sp)
 69c:	7446                	ld	s0,112(sp)
 69e:	74a6                	ld	s1,104(sp)
 6a0:	7906                	ld	s2,96(sp)
 6a2:	69e6                	ld	s3,88(sp)
 6a4:	6a46                	ld	s4,80(sp)
 6a6:	6aa6                	ld	s5,72(sp)
 6a8:	6b06                	ld	s6,64(sp)
 6aa:	7be2                	ld	s7,56(sp)
 6ac:	7c42                	ld	s8,48(sp)
 6ae:	7ca2                	ld	s9,40(sp)
 6b0:	7d02                	ld	s10,32(sp)
 6b2:	6de2                	ld	s11,24(sp)
 6b4:	6109                	addi	sp,sp,128
 6b6:	8082                	ret

00000000000006b8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6b8:	715d                	addi	sp,sp,-80
 6ba:	ec06                	sd	ra,24(sp)
 6bc:	e822                	sd	s0,16(sp)
 6be:	1000                	addi	s0,sp,32
 6c0:	e010                	sd	a2,0(s0)
 6c2:	e414                	sd	a3,8(s0)
 6c4:	e818                	sd	a4,16(s0)
 6c6:	ec1c                	sd	a5,24(s0)
 6c8:	03043023          	sd	a6,32(s0)
 6cc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6d0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6d4:	8622                	mv	a2,s0
 6d6:	00000097          	auipc	ra,0x0
 6da:	e04080e7          	jalr	-508(ra) # 4da <vprintf>
}
 6de:	60e2                	ld	ra,24(sp)
 6e0:	6442                	ld	s0,16(sp)
 6e2:	6161                	addi	sp,sp,80
 6e4:	8082                	ret

00000000000006e6 <printf>:

void
printf(const char *fmt, ...)
{
 6e6:	711d                	addi	sp,sp,-96
 6e8:	ec06                	sd	ra,24(sp)
 6ea:	e822                	sd	s0,16(sp)
 6ec:	1000                	addi	s0,sp,32
 6ee:	e40c                	sd	a1,8(s0)
 6f0:	e810                	sd	a2,16(s0)
 6f2:	ec14                	sd	a3,24(s0)
 6f4:	f018                	sd	a4,32(s0)
 6f6:	f41c                	sd	a5,40(s0)
 6f8:	03043823          	sd	a6,48(s0)
 6fc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 700:	00840613          	addi	a2,s0,8
 704:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 708:	85aa                	mv	a1,a0
 70a:	4505                	li	a0,1
 70c:	00000097          	auipc	ra,0x0
 710:	dce080e7          	jalr	-562(ra) # 4da <vprintf>
}
 714:	60e2                	ld	ra,24(sp)
 716:	6442                	ld	s0,16(sp)
 718:	6125                	addi	sp,sp,96
 71a:	8082                	ret

000000000000071c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 71c:	1141                	addi	sp,sp,-16
 71e:	e422                	sd	s0,8(sp)
 720:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 722:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 726:	00000797          	auipc	a5,0x0
 72a:	2627b783          	ld	a5,610(a5) # 988 <freep>
 72e:	a805                	j	75e <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 730:	4618                	lw	a4,8(a2)
 732:	9db9                	addw	a1,a1,a4
 734:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 738:	6398                	ld	a4,0(a5)
 73a:	6318                	ld	a4,0(a4)
 73c:	fee53823          	sd	a4,-16(a0)
 740:	a091                	j	784 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 742:	ff852703          	lw	a4,-8(a0)
 746:	9e39                	addw	a2,a2,a4
 748:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 74a:	ff053703          	ld	a4,-16(a0)
 74e:	e398                	sd	a4,0(a5)
 750:	a099                	j	796 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 752:	6398                	ld	a4,0(a5)
 754:	00e7e463          	bltu	a5,a4,75c <free+0x40>
 758:	00e6ea63          	bltu	a3,a4,76c <free+0x50>
{
 75c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 75e:	fed7fae3          	bgeu	a5,a3,752 <free+0x36>
 762:	6398                	ld	a4,0(a5)
 764:	00e6e463          	bltu	a3,a4,76c <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 768:	fee7eae3          	bltu	a5,a4,75c <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 76c:	ff852583          	lw	a1,-8(a0)
 770:	6390                	ld	a2,0(a5)
 772:	02059713          	slli	a4,a1,0x20
 776:	9301                	srli	a4,a4,0x20
 778:	0712                	slli	a4,a4,0x4
 77a:	9736                	add	a4,a4,a3
 77c:	fae60ae3          	beq	a2,a4,730 <free+0x14>
    bp->s.ptr = p->s.ptr;
 780:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 784:	4790                	lw	a2,8(a5)
 786:	02061713          	slli	a4,a2,0x20
 78a:	9301                	srli	a4,a4,0x20
 78c:	0712                	slli	a4,a4,0x4
 78e:	973e                	add	a4,a4,a5
 790:	fae689e3          	beq	a3,a4,742 <free+0x26>
  } else
    p->s.ptr = bp;
 794:	e394                	sd	a3,0(a5)
  freep = p;
 796:	00000717          	auipc	a4,0x0
 79a:	1ef73923          	sd	a5,498(a4) # 988 <freep>
}
 79e:	6422                	ld	s0,8(sp)
 7a0:	0141                	addi	sp,sp,16
 7a2:	8082                	ret

00000000000007a4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7a4:	7139                	addi	sp,sp,-64
 7a6:	fc06                	sd	ra,56(sp)
 7a8:	f822                	sd	s0,48(sp)
 7aa:	f426                	sd	s1,40(sp)
 7ac:	f04a                	sd	s2,32(sp)
 7ae:	ec4e                	sd	s3,24(sp)
 7b0:	e852                	sd	s4,16(sp)
 7b2:	e456                	sd	s5,8(sp)
 7b4:	e05a                	sd	s6,0(sp)
 7b6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b8:	02051493          	slli	s1,a0,0x20
 7bc:	9081                	srli	s1,s1,0x20
 7be:	04bd                	addi	s1,s1,15
 7c0:	8091                	srli	s1,s1,0x4
 7c2:	0014899b          	addiw	s3,s1,1
 7c6:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7c8:	00000517          	auipc	a0,0x0
 7cc:	1c053503          	ld	a0,448(a0) # 988 <freep>
 7d0:	c515                	beqz	a0,7fc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7d4:	4798                	lw	a4,8(a5)
 7d6:	02977f63          	bgeu	a4,s1,814 <malloc+0x70>
 7da:	8a4e                	mv	s4,s3
 7dc:	0009871b          	sext.w	a4,s3
 7e0:	6685                	lui	a3,0x1
 7e2:	00d77363          	bgeu	a4,a3,7e8 <malloc+0x44>
 7e6:	6a05                	lui	s4,0x1
 7e8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7ec:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7f0:	00000917          	auipc	s2,0x0
 7f4:	19890913          	addi	s2,s2,408 # 988 <freep>
  if(p == (char*)-1)
 7f8:	5afd                	li	s5,-1
 7fa:	a88d                	j	86c <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 7fc:	00000797          	auipc	a5,0x0
 800:	19478793          	addi	a5,a5,404 # 990 <base>
 804:	00000717          	auipc	a4,0x0
 808:	18f73223          	sd	a5,388(a4) # 988 <freep>
 80c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 80e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 812:	b7e1                	j	7da <malloc+0x36>
      if(p->s.size == nunits)
 814:	02e48b63          	beq	s1,a4,84a <malloc+0xa6>
        p->s.size -= nunits;
 818:	4137073b          	subw	a4,a4,s3
 81c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 81e:	1702                	slli	a4,a4,0x20
 820:	9301                	srli	a4,a4,0x20
 822:	0712                	slli	a4,a4,0x4
 824:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 826:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 82a:	00000717          	auipc	a4,0x0
 82e:	14a73f23          	sd	a0,350(a4) # 988 <freep>
      return (void*)(p + 1);
 832:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 836:	70e2                	ld	ra,56(sp)
 838:	7442                	ld	s0,48(sp)
 83a:	74a2                	ld	s1,40(sp)
 83c:	7902                	ld	s2,32(sp)
 83e:	69e2                	ld	s3,24(sp)
 840:	6a42                	ld	s4,16(sp)
 842:	6aa2                	ld	s5,8(sp)
 844:	6b02                	ld	s6,0(sp)
 846:	6121                	addi	sp,sp,64
 848:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 84a:	6398                	ld	a4,0(a5)
 84c:	e118                	sd	a4,0(a0)
 84e:	bff1                	j	82a <malloc+0x86>
  hp->s.size = nu;
 850:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 854:	0541                	addi	a0,a0,16
 856:	00000097          	auipc	ra,0x0
 85a:	ec6080e7          	jalr	-314(ra) # 71c <free>
  return freep;
 85e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 862:	d971                	beqz	a0,836 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 864:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 866:	4798                	lw	a4,8(a5)
 868:	fa9776e3          	bgeu	a4,s1,814 <malloc+0x70>
    if(p == freep)
 86c:	00093703          	ld	a4,0(s2)
 870:	853e                	mv	a0,a5
 872:	fef719e3          	bne	a4,a5,864 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 876:	8552                	mv	a0,s4
 878:	00000097          	auipc	ra,0x0
 87c:	b6e080e7          	jalr	-1170(ra) # 3e6 <sbrk>
  if(p == (char*)-1)
 880:	fd5518e3          	bne	a0,s5,850 <malloc+0xac>
        return 0;
 884:	4501                	li	a0,0
 886:	bf45                	j	836 <malloc+0x92>
