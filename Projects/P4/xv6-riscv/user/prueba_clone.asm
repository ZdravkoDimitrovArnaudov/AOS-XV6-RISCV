
user/_prueba_clone:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
 */
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
  16:	614080e7          	jalr	1556(ra) # 626 <getpid>
  1a:	87aa                	mv	a5,a0
  1c:	873e                	mv	a4,a5
  1e:	00001797          	auipc	a5,0x1
  22:	0e278793          	addi	a5,a5,226 # 1100 <ppid>
  26:	c398                	sw	a4,0(a5)
   printf ("PID padre: %d\n", ppid);
  28:	00001797          	auipc	a5,0x1
  2c:	0d878793          	addi	a5,a5,216 # 1100 <ppid>
  30:	439c                	lw	a5,0(a5)
  32:	85be                	mv	a1,a5
  34:	00001517          	auipc	a0,0x1
  38:	fa450513          	addi	a0,a0,-92 # fd8 <cv_init+0x1c>
  3c:	00001097          	auipc	ra,0x1
  40:	aa2080e7          	jalr	-1374(ra) # ade <printf>



   void *stack = malloc(PGSIZE*2);
  44:	6509                	lui	a0,0x2
  46:	00001097          	auipc	ra,0x1
  4a:	c8a080e7          	jalr	-886(ra) # cd0 <malloc>
  4e:	fea43423          	sd	a0,-24(s0)
   if((uint64)stack % PGSIZE){
  52:	fe843703          	ld	a4,-24(s0)
  56:	6785                	lui	a5,0x1
  58:	17fd                	addi	a5,a5,-1
  5a:	8ff9                	and	a5,a5,a4
  5c:	cf91                	beqz	a5,78 <main+0x78>
     stack = stack + (4096 - (uint64)stack % PGSIZE);
  5e:	fe843703          	ld	a4,-24(s0)
  62:	6785                	lui	a5,0x1
  64:	17fd                	addi	a5,a5,-1
  66:	8ff9                	and	a5,a5,a4
  68:	6705                	lui	a4,0x1
  6a:	40f707b3          	sub	a5,a4,a5
  6e:	fe843703          	ld	a4,-24(s0)
  72:	97ba                	add	a5,a5,a4
  74:	fef43423          	sd	a5,-24(s0)
   }
   printf ("Stack alocatado y listo para usarse\n");
  78:	00001517          	auipc	a0,0x1
  7c:	f7050513          	addi	a0,a0,-144 # fe8 <cv_init+0x2c>
  80:	00001097          	auipc	ra,0x1
  84:	a5e080e7          	jalr	-1442(ra) # ade <printf>

   int clone_pid = clone(worker, (void*)6 , stack); // (void*)6, stack
  88:	fe843603          	ld	a2,-24(s0)
  8c:	4599                	li	a1,6
  8e:	00000517          	auipc	a0,0x0
  92:	05450513          	addi	a0,a0,84 # e2 <worker>
  96:	00000097          	auipc	ra,0x0
  9a:	5b0080e7          	jalr	1456(ra) # 646 <clone>
  9e:	87aa                	mv	a5,a0
  a0:	fef42223          	sw	a5,-28(s0)
   //wait(0);
   printf ("Resultado clone: %d\n", clone_pid);
  a4:	fe442783          	lw	a5,-28(s0)
  a8:	85be                	mv	a1,a5
  aa:	00001517          	auipc	a0,0x1
  ae:	f6650513          	addi	a0,a0,-154 # 1010 <cv_init+0x54>
  b2:	00001097          	auipc	ra,0x1
  b6:	a2c080e7          	jalr	-1492(ra) # ade <printf>

   printf ("El valor de la variable global ha pasado a valer: %d\n", global);
  ba:	00001797          	auipc	a5,0x1
  be:	04278793          	addi	a5,a5,66 # 10fc <global>
  c2:	439c                	lw	a5,0(a5)
  c4:	2781                	sext.w	a5,a5
  c6:	85be                	mv	a1,a5
  c8:	00001517          	auipc	a0,0x1
  cc:	f6050513          	addi	a0,a0,-160 # 1028 <cv_init+0x6c>
  d0:	00001097          	auipc	ra,0x1
  d4:	a0e080e7          	jalr	-1522(ra) # ade <printf>
   exit(0);
  d8:	4501                	li	a0,0
  da:	00000097          	auipc	ra,0x0
  de:	4cc080e7          	jalr	1228(ra) # 5a6 <exit>

00000000000000e2 <worker>:
}

void
worker(void *arg_ptr) {
  e2:	1101                	addi	sp,sp,-32
  e4:	ec06                	sd	ra,24(sp)
  e6:	e822                	sd	s0,16(sp)
  e8:	1000                	addi	s0,sp,32
  ea:	fea43423          	sd	a0,-24(s0)
   //assert(global == 1);
   global = 5;
  ee:	00001797          	auipc	a5,0x1
  f2:	00e78793          	addi	a5,a5,14 # 10fc <global>
  f6:	4715                	li	a4,5
  f8:	c398                	sw	a4,0(a5)
   printf ("El thread ha entrado en la función worker\n");
  fa:	00001517          	auipc	a0,0x1
  fe:	f6650513          	addi	a0,a0,-154 # 1060 <cv_init+0xa4>
 102:	00001097          	auipc	ra,0x1
 106:	9dc080e7          	jalr	-1572(ra) # ade <printf>
   exit(0);
 10a:	4501                	li	a0,0
 10c:	00000097          	auipc	ra,0x0
 110:	49a080e7          	jalr	1178(ra) # 5a6 <exit>

0000000000000114 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 114:	7179                	addi	sp,sp,-48
 116:	f422                	sd	s0,40(sp)
 118:	1800                	addi	s0,sp,48
 11a:	fca43c23          	sd	a0,-40(s0)
 11e:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 122:	fd843783          	ld	a5,-40(s0)
 126:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 12a:	0001                	nop
 12c:	fd043703          	ld	a4,-48(s0)
 130:	00170793          	addi	a5,a4,1 # 1001 <cv_init+0x45>
 134:	fcf43823          	sd	a5,-48(s0)
 138:	fd843783          	ld	a5,-40(s0)
 13c:	00178693          	addi	a3,a5,1
 140:	fcd43c23          	sd	a3,-40(s0)
 144:	00074703          	lbu	a4,0(a4)
 148:	00e78023          	sb	a4,0(a5)
 14c:	0007c783          	lbu	a5,0(a5)
 150:	fff1                	bnez	a5,12c <strcpy+0x18>
    ;
  return os;
 152:	fe843783          	ld	a5,-24(s0)
}
 156:	853e                	mv	a0,a5
 158:	7422                	ld	s0,40(sp)
 15a:	6145                	addi	sp,sp,48
 15c:	8082                	ret

000000000000015e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 15e:	1101                	addi	sp,sp,-32
 160:	ec22                	sd	s0,24(sp)
 162:	1000                	addi	s0,sp,32
 164:	fea43423          	sd	a0,-24(s0)
 168:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 16c:	a819                	j	182 <strcmp+0x24>
    p++, q++;
 16e:	fe843783          	ld	a5,-24(s0)
 172:	0785                	addi	a5,a5,1
 174:	fef43423          	sd	a5,-24(s0)
 178:	fe043783          	ld	a5,-32(s0)
 17c:	0785                	addi	a5,a5,1
 17e:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 182:	fe843783          	ld	a5,-24(s0)
 186:	0007c783          	lbu	a5,0(a5)
 18a:	cb99                	beqz	a5,1a0 <strcmp+0x42>
 18c:	fe843783          	ld	a5,-24(s0)
 190:	0007c703          	lbu	a4,0(a5)
 194:	fe043783          	ld	a5,-32(s0)
 198:	0007c783          	lbu	a5,0(a5)
 19c:	fcf709e3          	beq	a4,a5,16e <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 1a0:	fe843783          	ld	a5,-24(s0)
 1a4:	0007c783          	lbu	a5,0(a5)
 1a8:	0007871b          	sext.w	a4,a5
 1ac:	fe043783          	ld	a5,-32(s0)
 1b0:	0007c783          	lbu	a5,0(a5)
 1b4:	2781                	sext.w	a5,a5
 1b6:	40f707bb          	subw	a5,a4,a5
 1ba:	2781                	sext.w	a5,a5
}
 1bc:	853e                	mv	a0,a5
 1be:	6462                	ld	s0,24(sp)
 1c0:	6105                	addi	sp,sp,32
 1c2:	8082                	ret

00000000000001c4 <strlen>:

uint
strlen(const char *s)
{
 1c4:	7179                	addi	sp,sp,-48
 1c6:	f422                	sd	s0,40(sp)
 1c8:	1800                	addi	s0,sp,48
 1ca:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 1ce:	fe042623          	sw	zero,-20(s0)
 1d2:	a031                	j	1de <strlen+0x1a>
 1d4:	fec42783          	lw	a5,-20(s0)
 1d8:	2785                	addiw	a5,a5,1
 1da:	fef42623          	sw	a5,-20(s0)
 1de:	fec42783          	lw	a5,-20(s0)
 1e2:	fd843703          	ld	a4,-40(s0)
 1e6:	97ba                	add	a5,a5,a4
 1e8:	0007c783          	lbu	a5,0(a5)
 1ec:	f7e5                	bnez	a5,1d4 <strlen+0x10>
    ;
  return n;
 1ee:	fec42783          	lw	a5,-20(s0)
}
 1f2:	853e                	mv	a0,a5
 1f4:	7422                	ld	s0,40(sp)
 1f6:	6145                	addi	sp,sp,48
 1f8:	8082                	ret

00000000000001fa <memset>:

void*
memset(void *dst, int c, uint n)
{
 1fa:	7179                	addi	sp,sp,-48
 1fc:	f422                	sd	s0,40(sp)
 1fe:	1800                	addi	s0,sp,48
 200:	fca43c23          	sd	a0,-40(s0)
 204:	87ae                	mv	a5,a1
 206:	8732                	mv	a4,a2
 208:	fcf42a23          	sw	a5,-44(s0)
 20c:	87ba                	mv	a5,a4
 20e:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 212:	fd843783          	ld	a5,-40(s0)
 216:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 21a:	fe042623          	sw	zero,-20(s0)
 21e:	a00d                	j	240 <memset+0x46>
    cdst[i] = c;
 220:	fec42783          	lw	a5,-20(s0)
 224:	fe043703          	ld	a4,-32(s0)
 228:	97ba                	add	a5,a5,a4
 22a:	fd442703          	lw	a4,-44(s0)
 22e:	0ff77713          	zext.b	a4,a4
 232:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 236:	fec42783          	lw	a5,-20(s0)
 23a:	2785                	addiw	a5,a5,1
 23c:	fef42623          	sw	a5,-20(s0)
 240:	fec42703          	lw	a4,-20(s0)
 244:	fd042783          	lw	a5,-48(s0)
 248:	2781                	sext.w	a5,a5
 24a:	fcf76be3          	bltu	a4,a5,220 <memset+0x26>
  }
  return dst;
 24e:	fd843783          	ld	a5,-40(s0)
}
 252:	853e                	mv	a0,a5
 254:	7422                	ld	s0,40(sp)
 256:	6145                	addi	sp,sp,48
 258:	8082                	ret

000000000000025a <strchr>:

char*
strchr(const char *s, char c)
{
 25a:	1101                	addi	sp,sp,-32
 25c:	ec22                	sd	s0,24(sp)
 25e:	1000                	addi	s0,sp,32
 260:	fea43423          	sd	a0,-24(s0)
 264:	87ae                	mv	a5,a1
 266:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 26a:	a01d                	j	290 <strchr+0x36>
    if(*s == c)
 26c:	fe843783          	ld	a5,-24(s0)
 270:	0007c703          	lbu	a4,0(a5)
 274:	fe744783          	lbu	a5,-25(s0)
 278:	0ff7f793          	zext.b	a5,a5
 27c:	00e79563          	bne	a5,a4,286 <strchr+0x2c>
      return (char*)s;
 280:	fe843783          	ld	a5,-24(s0)
 284:	a821                	j	29c <strchr+0x42>
  for(; *s; s++)
 286:	fe843783          	ld	a5,-24(s0)
 28a:	0785                	addi	a5,a5,1
 28c:	fef43423          	sd	a5,-24(s0)
 290:	fe843783          	ld	a5,-24(s0)
 294:	0007c783          	lbu	a5,0(a5)
 298:	fbf1                	bnez	a5,26c <strchr+0x12>
  return 0;
 29a:	4781                	li	a5,0
}
 29c:	853e                	mv	a0,a5
 29e:	6462                	ld	s0,24(sp)
 2a0:	6105                	addi	sp,sp,32
 2a2:	8082                	ret

00000000000002a4 <gets>:

char*
gets(char *buf, int max)
{
 2a4:	7179                	addi	sp,sp,-48
 2a6:	f406                	sd	ra,40(sp)
 2a8:	f022                	sd	s0,32(sp)
 2aa:	1800                	addi	s0,sp,48
 2ac:	fca43c23          	sd	a0,-40(s0)
 2b0:	87ae                	mv	a5,a1
 2b2:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b6:	fe042623          	sw	zero,-20(s0)
 2ba:	a8a1                	j	312 <gets+0x6e>
    cc = read(0, &c, 1);
 2bc:	fe740793          	addi	a5,s0,-25
 2c0:	4605                	li	a2,1
 2c2:	85be                	mv	a1,a5
 2c4:	4501                	li	a0,0
 2c6:	00000097          	auipc	ra,0x0
 2ca:	2f8080e7          	jalr	760(ra) # 5be <read>
 2ce:	87aa                	mv	a5,a0
 2d0:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 2d4:	fe842783          	lw	a5,-24(s0)
 2d8:	2781                	sext.w	a5,a5
 2da:	04f05763          	blez	a5,328 <gets+0x84>
      break;
    buf[i++] = c;
 2de:	fec42783          	lw	a5,-20(s0)
 2e2:	0017871b          	addiw	a4,a5,1
 2e6:	fee42623          	sw	a4,-20(s0)
 2ea:	873e                	mv	a4,a5
 2ec:	fd843783          	ld	a5,-40(s0)
 2f0:	97ba                	add	a5,a5,a4
 2f2:	fe744703          	lbu	a4,-25(s0)
 2f6:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 2fa:	fe744783          	lbu	a5,-25(s0)
 2fe:	873e                	mv	a4,a5
 300:	47a9                	li	a5,10
 302:	02f70463          	beq	a4,a5,32a <gets+0x86>
 306:	fe744783          	lbu	a5,-25(s0)
 30a:	873e                	mv	a4,a5
 30c:	47b5                	li	a5,13
 30e:	00f70e63          	beq	a4,a5,32a <gets+0x86>
  for(i=0; i+1 < max; ){
 312:	fec42783          	lw	a5,-20(s0)
 316:	2785                	addiw	a5,a5,1
 318:	0007871b          	sext.w	a4,a5
 31c:	fd442783          	lw	a5,-44(s0)
 320:	2781                	sext.w	a5,a5
 322:	f8f74de3          	blt	a4,a5,2bc <gets+0x18>
 326:	a011                	j	32a <gets+0x86>
      break;
 328:	0001                	nop
      break;
  }
  buf[i] = '\0';
 32a:	fec42783          	lw	a5,-20(s0)
 32e:	fd843703          	ld	a4,-40(s0)
 332:	97ba                	add	a5,a5,a4
 334:	00078023          	sb	zero,0(a5)
  return buf;
 338:	fd843783          	ld	a5,-40(s0)
}
 33c:	853e                	mv	a0,a5
 33e:	70a2                	ld	ra,40(sp)
 340:	7402                	ld	s0,32(sp)
 342:	6145                	addi	sp,sp,48
 344:	8082                	ret

0000000000000346 <stat>:

int
stat(const char *n, struct stat *st)
{
 346:	7179                	addi	sp,sp,-48
 348:	f406                	sd	ra,40(sp)
 34a:	f022                	sd	s0,32(sp)
 34c:	1800                	addi	s0,sp,48
 34e:	fca43c23          	sd	a0,-40(s0)
 352:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 356:	4581                	li	a1,0
 358:	fd843503          	ld	a0,-40(s0)
 35c:	00000097          	auipc	ra,0x0
 360:	28a080e7          	jalr	650(ra) # 5e6 <open>
 364:	87aa                	mv	a5,a0
 366:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 36a:	fec42783          	lw	a5,-20(s0)
 36e:	2781                	sext.w	a5,a5
 370:	0007d463          	bgez	a5,378 <stat+0x32>
    return -1;
 374:	57fd                	li	a5,-1
 376:	a035                	j	3a2 <stat+0x5c>
  r = fstat(fd, st);
 378:	fec42783          	lw	a5,-20(s0)
 37c:	fd043583          	ld	a1,-48(s0)
 380:	853e                	mv	a0,a5
 382:	00000097          	auipc	ra,0x0
 386:	27c080e7          	jalr	636(ra) # 5fe <fstat>
 38a:	87aa                	mv	a5,a0
 38c:	fef42423          	sw	a5,-24(s0)
  close(fd);
 390:	fec42783          	lw	a5,-20(s0)
 394:	853e                	mv	a0,a5
 396:	00000097          	auipc	ra,0x0
 39a:	238080e7          	jalr	568(ra) # 5ce <close>
  return r;
 39e:	fe842783          	lw	a5,-24(s0)
}
 3a2:	853e                	mv	a0,a5
 3a4:	70a2                	ld	ra,40(sp)
 3a6:	7402                	ld	s0,32(sp)
 3a8:	6145                	addi	sp,sp,48
 3aa:	8082                	ret

00000000000003ac <atoi>:

int
atoi(const char *s)
{
 3ac:	7179                	addi	sp,sp,-48
 3ae:	f422                	sd	s0,40(sp)
 3b0:	1800                	addi	s0,sp,48
 3b2:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 3b6:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 3ba:	a81d                	j	3f0 <atoi+0x44>
    n = n*10 + *s++ - '0';
 3bc:	fec42783          	lw	a5,-20(s0)
 3c0:	873e                	mv	a4,a5
 3c2:	87ba                	mv	a5,a4
 3c4:	0027979b          	slliw	a5,a5,0x2
 3c8:	9fb9                	addw	a5,a5,a4
 3ca:	0017979b          	slliw	a5,a5,0x1
 3ce:	0007871b          	sext.w	a4,a5
 3d2:	fd843783          	ld	a5,-40(s0)
 3d6:	00178693          	addi	a3,a5,1
 3da:	fcd43c23          	sd	a3,-40(s0)
 3de:	0007c783          	lbu	a5,0(a5)
 3e2:	2781                	sext.w	a5,a5
 3e4:	9fb9                	addw	a5,a5,a4
 3e6:	2781                	sext.w	a5,a5
 3e8:	fd07879b          	addiw	a5,a5,-48
 3ec:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 3f0:	fd843783          	ld	a5,-40(s0)
 3f4:	0007c783          	lbu	a5,0(a5)
 3f8:	873e                	mv	a4,a5
 3fa:	02f00793          	li	a5,47
 3fe:	00e7fb63          	bgeu	a5,a4,414 <atoi+0x68>
 402:	fd843783          	ld	a5,-40(s0)
 406:	0007c783          	lbu	a5,0(a5)
 40a:	873e                	mv	a4,a5
 40c:	03900793          	li	a5,57
 410:	fae7f6e3          	bgeu	a5,a4,3bc <atoi+0x10>
  return n;
 414:	fec42783          	lw	a5,-20(s0)
}
 418:	853e                	mv	a0,a5
 41a:	7422                	ld	s0,40(sp)
 41c:	6145                	addi	sp,sp,48
 41e:	8082                	ret

0000000000000420 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 420:	7139                	addi	sp,sp,-64
 422:	fc22                	sd	s0,56(sp)
 424:	0080                	addi	s0,sp,64
 426:	fca43c23          	sd	a0,-40(s0)
 42a:	fcb43823          	sd	a1,-48(s0)
 42e:	87b2                	mv	a5,a2
 430:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 434:	fd843783          	ld	a5,-40(s0)
 438:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 43c:	fd043783          	ld	a5,-48(s0)
 440:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 444:	fe043703          	ld	a4,-32(s0)
 448:	fe843783          	ld	a5,-24(s0)
 44c:	02e7fc63          	bgeu	a5,a4,484 <memmove+0x64>
    while(n-- > 0)
 450:	a00d                	j	472 <memmove+0x52>
      *dst++ = *src++;
 452:	fe043703          	ld	a4,-32(s0)
 456:	00170793          	addi	a5,a4,1
 45a:	fef43023          	sd	a5,-32(s0)
 45e:	fe843783          	ld	a5,-24(s0)
 462:	00178693          	addi	a3,a5,1
 466:	fed43423          	sd	a3,-24(s0)
 46a:	00074703          	lbu	a4,0(a4)
 46e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 472:	fcc42783          	lw	a5,-52(s0)
 476:	fff7871b          	addiw	a4,a5,-1
 47a:	fce42623          	sw	a4,-52(s0)
 47e:	fcf04ae3          	bgtz	a5,452 <memmove+0x32>
 482:	a891                	j	4d6 <memmove+0xb6>
  } else {
    dst += n;
 484:	fcc42783          	lw	a5,-52(s0)
 488:	fe843703          	ld	a4,-24(s0)
 48c:	97ba                	add	a5,a5,a4
 48e:	fef43423          	sd	a5,-24(s0)
    src += n;
 492:	fcc42783          	lw	a5,-52(s0)
 496:	fe043703          	ld	a4,-32(s0)
 49a:	97ba                	add	a5,a5,a4
 49c:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 4a0:	a01d                	j	4c6 <memmove+0xa6>
      *--dst = *--src;
 4a2:	fe043783          	ld	a5,-32(s0)
 4a6:	17fd                	addi	a5,a5,-1
 4a8:	fef43023          	sd	a5,-32(s0)
 4ac:	fe843783          	ld	a5,-24(s0)
 4b0:	17fd                	addi	a5,a5,-1
 4b2:	fef43423          	sd	a5,-24(s0)
 4b6:	fe043783          	ld	a5,-32(s0)
 4ba:	0007c703          	lbu	a4,0(a5)
 4be:	fe843783          	ld	a5,-24(s0)
 4c2:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4c6:	fcc42783          	lw	a5,-52(s0)
 4ca:	fff7871b          	addiw	a4,a5,-1
 4ce:	fce42623          	sw	a4,-52(s0)
 4d2:	fcf048e3          	bgtz	a5,4a2 <memmove+0x82>
  }
  return vdst;
 4d6:	fd843783          	ld	a5,-40(s0)
}
 4da:	853e                	mv	a0,a5
 4dc:	7462                	ld	s0,56(sp)
 4de:	6121                	addi	sp,sp,64
 4e0:	8082                	ret

00000000000004e2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4e2:	7139                	addi	sp,sp,-64
 4e4:	fc22                	sd	s0,56(sp)
 4e6:	0080                	addi	s0,sp,64
 4e8:	fca43c23          	sd	a0,-40(s0)
 4ec:	fcb43823          	sd	a1,-48(s0)
 4f0:	87b2                	mv	a5,a2
 4f2:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 4f6:	fd843783          	ld	a5,-40(s0)
 4fa:	fef43423          	sd	a5,-24(s0)
 4fe:	fd043783          	ld	a5,-48(s0)
 502:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 506:	a0a1                	j	54e <memcmp+0x6c>
    if (*p1 != *p2) {
 508:	fe843783          	ld	a5,-24(s0)
 50c:	0007c703          	lbu	a4,0(a5)
 510:	fe043783          	ld	a5,-32(s0)
 514:	0007c783          	lbu	a5,0(a5)
 518:	02f70163          	beq	a4,a5,53a <memcmp+0x58>
      return *p1 - *p2;
 51c:	fe843783          	ld	a5,-24(s0)
 520:	0007c783          	lbu	a5,0(a5)
 524:	0007871b          	sext.w	a4,a5
 528:	fe043783          	ld	a5,-32(s0)
 52c:	0007c783          	lbu	a5,0(a5)
 530:	2781                	sext.w	a5,a5
 532:	40f707bb          	subw	a5,a4,a5
 536:	2781                	sext.w	a5,a5
 538:	a01d                	j	55e <memcmp+0x7c>
    }
    p1++;
 53a:	fe843783          	ld	a5,-24(s0)
 53e:	0785                	addi	a5,a5,1
 540:	fef43423          	sd	a5,-24(s0)
    p2++;
 544:	fe043783          	ld	a5,-32(s0)
 548:	0785                	addi	a5,a5,1
 54a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 54e:	fcc42783          	lw	a5,-52(s0)
 552:	fff7871b          	addiw	a4,a5,-1
 556:	fce42623          	sw	a4,-52(s0)
 55a:	f7dd                	bnez	a5,508 <memcmp+0x26>
  }
  return 0;
 55c:	4781                	li	a5,0
}
 55e:	853e                	mv	a0,a5
 560:	7462                	ld	s0,56(sp)
 562:	6121                	addi	sp,sp,64
 564:	8082                	ret

0000000000000566 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 566:	7179                	addi	sp,sp,-48
 568:	f406                	sd	ra,40(sp)
 56a:	f022                	sd	s0,32(sp)
 56c:	1800                	addi	s0,sp,48
 56e:	fea43423          	sd	a0,-24(s0)
 572:	feb43023          	sd	a1,-32(s0)
 576:	87b2                	mv	a5,a2
 578:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 57c:	fdc42783          	lw	a5,-36(s0)
 580:	863e                	mv	a2,a5
 582:	fe043583          	ld	a1,-32(s0)
 586:	fe843503          	ld	a0,-24(s0)
 58a:	00000097          	auipc	ra,0x0
 58e:	e96080e7          	jalr	-362(ra) # 420 <memmove>
 592:	87aa                	mv	a5,a0
}
 594:	853e                	mv	a0,a5
 596:	70a2                	ld	ra,40(sp)
 598:	7402                	ld	s0,32(sp)
 59a:	6145                	addi	sp,sp,48
 59c:	8082                	ret

000000000000059e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 59e:	4885                	li	a7,1
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5a6:	4889                	li	a7,2
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <wait>:
.global wait
wait:
 li a7, SYS_wait
 5ae:	488d                	li	a7,3
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5b6:	4891                	li	a7,4
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <read>:
.global read
read:
 li a7, SYS_read
 5be:	4895                	li	a7,5
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <write>:
.global write
write:
 li a7, SYS_write
 5c6:	48c1                	li	a7,16
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <close>:
.global close
close:
 li a7, SYS_close
 5ce:	48d5                	li	a7,21
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5d6:	4899                	li	a7,6
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <exec>:
.global exec
exec:
 li a7, SYS_exec
 5de:	489d                	li	a7,7
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <open>:
.global open
open:
 li a7, SYS_open
 5e6:	48bd                	li	a7,15
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5ee:	48c5                	li	a7,17
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5f6:	48c9                	li	a7,18
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5fe:	48a1                	li	a7,8
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <link>:
.global link
link:
 li a7, SYS_link
 606:	48cd                	li	a7,19
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 60e:	48d1                	li	a7,20
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 616:	48a5                	li	a7,9
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <dup>:
.global dup
dup:
 li a7, SYS_dup
 61e:	48a9                	li	a7,10
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 626:	48ad                	li	a7,11
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 62e:	48b1                	li	a7,12
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 636:	48b5                	li	a7,13
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 63e:	48b9                	li	a7,14
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <clone>:
.global clone
clone:
 li a7, SYS_clone
 646:	48d9                	li	a7,22
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <join>:
.global join
join:
 li a7, SYS_join
 64e:	48dd                	li	a7,23
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 656:	1101                	addi	sp,sp,-32
 658:	ec06                	sd	ra,24(sp)
 65a:	e822                	sd	s0,16(sp)
 65c:	1000                	addi	s0,sp,32
 65e:	87aa                	mv	a5,a0
 660:	872e                	mv	a4,a1
 662:	fef42623          	sw	a5,-20(s0)
 666:	87ba                	mv	a5,a4
 668:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 66c:	feb40713          	addi	a4,s0,-21
 670:	fec42783          	lw	a5,-20(s0)
 674:	4605                	li	a2,1
 676:	85ba                	mv	a1,a4
 678:	853e                	mv	a0,a5
 67a:	00000097          	auipc	ra,0x0
 67e:	f4c080e7          	jalr	-180(ra) # 5c6 <write>
}
 682:	0001                	nop
 684:	60e2                	ld	ra,24(sp)
 686:	6442                	ld	s0,16(sp)
 688:	6105                	addi	sp,sp,32
 68a:	8082                	ret

000000000000068c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 68c:	7139                	addi	sp,sp,-64
 68e:	fc06                	sd	ra,56(sp)
 690:	f822                	sd	s0,48(sp)
 692:	0080                	addi	s0,sp,64
 694:	87aa                	mv	a5,a0
 696:	8736                	mv	a4,a3
 698:	fcf42623          	sw	a5,-52(s0)
 69c:	87ae                	mv	a5,a1
 69e:	fcf42423          	sw	a5,-56(s0)
 6a2:	87b2                	mv	a5,a2
 6a4:	fcf42223          	sw	a5,-60(s0)
 6a8:	87ba                	mv	a5,a4
 6aa:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6ae:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 6b2:	fc042783          	lw	a5,-64(s0)
 6b6:	2781                	sext.w	a5,a5
 6b8:	c38d                	beqz	a5,6da <printint+0x4e>
 6ba:	fc842783          	lw	a5,-56(s0)
 6be:	2781                	sext.w	a5,a5
 6c0:	0007dd63          	bgez	a5,6da <printint+0x4e>
    neg = 1;
 6c4:	4785                	li	a5,1
 6c6:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 6ca:	fc842783          	lw	a5,-56(s0)
 6ce:	40f007bb          	negw	a5,a5
 6d2:	2781                	sext.w	a5,a5
 6d4:	fef42223          	sw	a5,-28(s0)
 6d8:	a029                	j	6e2 <printint+0x56>
  } else {
    x = xx;
 6da:	fc842783          	lw	a5,-56(s0)
 6de:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 6e2:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 6e6:	fc442783          	lw	a5,-60(s0)
 6ea:	fe442703          	lw	a4,-28(s0)
 6ee:	02f777bb          	remuw	a5,a4,a5
 6f2:	0007861b          	sext.w	a2,a5
 6f6:	fec42783          	lw	a5,-20(s0)
 6fa:	0017871b          	addiw	a4,a5,1
 6fe:	fee42623          	sw	a4,-20(s0)
 702:	00001697          	auipc	a3,0x1
 706:	9e668693          	addi	a3,a3,-1562 # 10e8 <digits>
 70a:	02061713          	slli	a4,a2,0x20
 70e:	9301                	srli	a4,a4,0x20
 710:	9736                	add	a4,a4,a3
 712:	00074703          	lbu	a4,0(a4)
 716:	17c1                	addi	a5,a5,-16
 718:	97a2                	add	a5,a5,s0
 71a:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 71e:	fc442783          	lw	a5,-60(s0)
 722:	fe442703          	lw	a4,-28(s0)
 726:	02f757bb          	divuw	a5,a4,a5
 72a:	fef42223          	sw	a5,-28(s0)
 72e:	fe442783          	lw	a5,-28(s0)
 732:	2781                	sext.w	a5,a5
 734:	fbcd                	bnez	a5,6e6 <printint+0x5a>
  if(neg)
 736:	fe842783          	lw	a5,-24(s0)
 73a:	2781                	sext.w	a5,a5
 73c:	cf85                	beqz	a5,774 <printint+0xe8>
    buf[i++] = '-';
 73e:	fec42783          	lw	a5,-20(s0)
 742:	0017871b          	addiw	a4,a5,1
 746:	fee42623          	sw	a4,-20(s0)
 74a:	17c1                	addi	a5,a5,-16
 74c:	97a2                	add	a5,a5,s0
 74e:	02d00713          	li	a4,45
 752:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 756:	a839                	j	774 <printint+0xe8>
    putc(fd, buf[i]);
 758:	fec42783          	lw	a5,-20(s0)
 75c:	17c1                	addi	a5,a5,-16
 75e:	97a2                	add	a5,a5,s0
 760:	fe07c703          	lbu	a4,-32(a5)
 764:	fcc42783          	lw	a5,-52(s0)
 768:	85ba                	mv	a1,a4
 76a:	853e                	mv	a0,a5
 76c:	00000097          	auipc	ra,0x0
 770:	eea080e7          	jalr	-278(ra) # 656 <putc>
  while(--i >= 0)
 774:	fec42783          	lw	a5,-20(s0)
 778:	37fd                	addiw	a5,a5,-1
 77a:	fef42623          	sw	a5,-20(s0)
 77e:	fec42783          	lw	a5,-20(s0)
 782:	2781                	sext.w	a5,a5
 784:	fc07dae3          	bgez	a5,758 <printint+0xcc>
}
 788:	0001                	nop
 78a:	0001                	nop
 78c:	70e2                	ld	ra,56(sp)
 78e:	7442                	ld	s0,48(sp)
 790:	6121                	addi	sp,sp,64
 792:	8082                	ret

0000000000000794 <printptr>:

static void
printptr(int fd, uint64 x) {
 794:	7179                	addi	sp,sp,-48
 796:	f406                	sd	ra,40(sp)
 798:	f022                	sd	s0,32(sp)
 79a:	1800                	addi	s0,sp,48
 79c:	87aa                	mv	a5,a0
 79e:	fcb43823          	sd	a1,-48(s0)
 7a2:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 7a6:	fdc42783          	lw	a5,-36(s0)
 7aa:	03000593          	li	a1,48
 7ae:	853e                	mv	a0,a5
 7b0:	00000097          	auipc	ra,0x0
 7b4:	ea6080e7          	jalr	-346(ra) # 656 <putc>
  putc(fd, 'x');
 7b8:	fdc42783          	lw	a5,-36(s0)
 7bc:	07800593          	li	a1,120
 7c0:	853e                	mv	a0,a5
 7c2:	00000097          	auipc	ra,0x0
 7c6:	e94080e7          	jalr	-364(ra) # 656 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ca:	fe042623          	sw	zero,-20(s0)
 7ce:	a82d                	j	808 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7d0:	fd043783          	ld	a5,-48(s0)
 7d4:	93f1                	srli	a5,a5,0x3c
 7d6:	00001717          	auipc	a4,0x1
 7da:	91270713          	addi	a4,a4,-1774 # 10e8 <digits>
 7de:	97ba                	add	a5,a5,a4
 7e0:	0007c703          	lbu	a4,0(a5)
 7e4:	fdc42783          	lw	a5,-36(s0)
 7e8:	85ba                	mv	a1,a4
 7ea:	853e                	mv	a0,a5
 7ec:	00000097          	auipc	ra,0x0
 7f0:	e6a080e7          	jalr	-406(ra) # 656 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7f4:	fec42783          	lw	a5,-20(s0)
 7f8:	2785                	addiw	a5,a5,1
 7fa:	fef42623          	sw	a5,-20(s0)
 7fe:	fd043783          	ld	a5,-48(s0)
 802:	0792                	slli	a5,a5,0x4
 804:	fcf43823          	sd	a5,-48(s0)
 808:	fec42783          	lw	a5,-20(s0)
 80c:	873e                	mv	a4,a5
 80e:	47bd                	li	a5,15
 810:	fce7f0e3          	bgeu	a5,a4,7d0 <printptr+0x3c>
}
 814:	0001                	nop
 816:	0001                	nop
 818:	70a2                	ld	ra,40(sp)
 81a:	7402                	ld	s0,32(sp)
 81c:	6145                	addi	sp,sp,48
 81e:	8082                	ret

0000000000000820 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 820:	715d                	addi	sp,sp,-80
 822:	e486                	sd	ra,72(sp)
 824:	e0a2                	sd	s0,64(sp)
 826:	0880                	addi	s0,sp,80
 828:	87aa                	mv	a5,a0
 82a:	fcb43023          	sd	a1,-64(s0)
 82e:	fac43c23          	sd	a2,-72(s0)
 832:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 836:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 83a:	fe042223          	sw	zero,-28(s0)
 83e:	a42d                	j	a68 <vprintf+0x248>
    c = fmt[i] & 0xff;
 840:	fe442783          	lw	a5,-28(s0)
 844:	fc043703          	ld	a4,-64(s0)
 848:	97ba                	add	a5,a5,a4
 84a:	0007c783          	lbu	a5,0(a5)
 84e:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 852:	fe042783          	lw	a5,-32(s0)
 856:	2781                	sext.w	a5,a5
 858:	eb9d                	bnez	a5,88e <vprintf+0x6e>
      if(c == '%'){
 85a:	fdc42783          	lw	a5,-36(s0)
 85e:	0007871b          	sext.w	a4,a5
 862:	02500793          	li	a5,37
 866:	00f71763          	bne	a4,a5,874 <vprintf+0x54>
        state = '%';
 86a:	02500793          	li	a5,37
 86e:	fef42023          	sw	a5,-32(s0)
 872:	a2f5                	j	a5e <vprintf+0x23e>
      } else {
        putc(fd, c);
 874:	fdc42783          	lw	a5,-36(s0)
 878:	0ff7f713          	zext.b	a4,a5
 87c:	fcc42783          	lw	a5,-52(s0)
 880:	85ba                	mv	a1,a4
 882:	853e                	mv	a0,a5
 884:	00000097          	auipc	ra,0x0
 888:	dd2080e7          	jalr	-558(ra) # 656 <putc>
 88c:	aac9                	j	a5e <vprintf+0x23e>
      }
    } else if(state == '%'){
 88e:	fe042783          	lw	a5,-32(s0)
 892:	0007871b          	sext.w	a4,a5
 896:	02500793          	li	a5,37
 89a:	1cf71263          	bne	a4,a5,a5e <vprintf+0x23e>
      if(c == 'd'){
 89e:	fdc42783          	lw	a5,-36(s0)
 8a2:	0007871b          	sext.w	a4,a5
 8a6:	06400793          	li	a5,100
 8aa:	02f71463          	bne	a4,a5,8d2 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 8ae:	fb843783          	ld	a5,-72(s0)
 8b2:	00878713          	addi	a4,a5,8
 8b6:	fae43c23          	sd	a4,-72(s0)
 8ba:	4398                	lw	a4,0(a5)
 8bc:	fcc42783          	lw	a5,-52(s0)
 8c0:	4685                	li	a3,1
 8c2:	4629                	li	a2,10
 8c4:	85ba                	mv	a1,a4
 8c6:	853e                	mv	a0,a5
 8c8:	00000097          	auipc	ra,0x0
 8cc:	dc4080e7          	jalr	-572(ra) # 68c <printint>
 8d0:	a269                	j	a5a <vprintf+0x23a>
      } else if(c == 'l') {
 8d2:	fdc42783          	lw	a5,-36(s0)
 8d6:	0007871b          	sext.w	a4,a5
 8da:	06c00793          	li	a5,108
 8de:	02f71663          	bne	a4,a5,90a <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8e2:	fb843783          	ld	a5,-72(s0)
 8e6:	00878713          	addi	a4,a5,8
 8ea:	fae43c23          	sd	a4,-72(s0)
 8ee:	639c                	ld	a5,0(a5)
 8f0:	0007871b          	sext.w	a4,a5
 8f4:	fcc42783          	lw	a5,-52(s0)
 8f8:	4681                	li	a3,0
 8fa:	4629                	li	a2,10
 8fc:	85ba                	mv	a1,a4
 8fe:	853e                	mv	a0,a5
 900:	00000097          	auipc	ra,0x0
 904:	d8c080e7          	jalr	-628(ra) # 68c <printint>
 908:	aa89                	j	a5a <vprintf+0x23a>
      } else if(c == 'x') {
 90a:	fdc42783          	lw	a5,-36(s0)
 90e:	0007871b          	sext.w	a4,a5
 912:	07800793          	li	a5,120
 916:	02f71463          	bne	a4,a5,93e <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 91a:	fb843783          	ld	a5,-72(s0)
 91e:	00878713          	addi	a4,a5,8
 922:	fae43c23          	sd	a4,-72(s0)
 926:	4398                	lw	a4,0(a5)
 928:	fcc42783          	lw	a5,-52(s0)
 92c:	4681                	li	a3,0
 92e:	4641                	li	a2,16
 930:	85ba                	mv	a1,a4
 932:	853e                	mv	a0,a5
 934:	00000097          	auipc	ra,0x0
 938:	d58080e7          	jalr	-680(ra) # 68c <printint>
 93c:	aa39                	j	a5a <vprintf+0x23a>
      } else if(c == 'p') {
 93e:	fdc42783          	lw	a5,-36(s0)
 942:	0007871b          	sext.w	a4,a5
 946:	07000793          	li	a5,112
 94a:	02f71263          	bne	a4,a5,96e <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 94e:	fb843783          	ld	a5,-72(s0)
 952:	00878713          	addi	a4,a5,8
 956:	fae43c23          	sd	a4,-72(s0)
 95a:	6398                	ld	a4,0(a5)
 95c:	fcc42783          	lw	a5,-52(s0)
 960:	85ba                	mv	a1,a4
 962:	853e                	mv	a0,a5
 964:	00000097          	auipc	ra,0x0
 968:	e30080e7          	jalr	-464(ra) # 794 <printptr>
 96c:	a0fd                	j	a5a <vprintf+0x23a>
      } else if(c == 's'){
 96e:	fdc42783          	lw	a5,-36(s0)
 972:	0007871b          	sext.w	a4,a5
 976:	07300793          	li	a5,115
 97a:	04f71c63          	bne	a4,a5,9d2 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 97e:	fb843783          	ld	a5,-72(s0)
 982:	00878713          	addi	a4,a5,8
 986:	fae43c23          	sd	a4,-72(s0)
 98a:	639c                	ld	a5,0(a5)
 98c:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 990:	fe843783          	ld	a5,-24(s0)
 994:	eb8d                	bnez	a5,9c6 <vprintf+0x1a6>
          s = "(null)";
 996:	00000797          	auipc	a5,0x0
 99a:	6fa78793          	addi	a5,a5,1786 # 1090 <cv_init+0xd4>
 99e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 9a2:	a015                	j	9c6 <vprintf+0x1a6>
          putc(fd, *s);
 9a4:	fe843783          	ld	a5,-24(s0)
 9a8:	0007c703          	lbu	a4,0(a5)
 9ac:	fcc42783          	lw	a5,-52(s0)
 9b0:	85ba                	mv	a1,a4
 9b2:	853e                	mv	a0,a5
 9b4:	00000097          	auipc	ra,0x0
 9b8:	ca2080e7          	jalr	-862(ra) # 656 <putc>
          s++;
 9bc:	fe843783          	ld	a5,-24(s0)
 9c0:	0785                	addi	a5,a5,1
 9c2:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 9c6:	fe843783          	ld	a5,-24(s0)
 9ca:	0007c783          	lbu	a5,0(a5)
 9ce:	fbf9                	bnez	a5,9a4 <vprintf+0x184>
 9d0:	a069                	j	a5a <vprintf+0x23a>
        }
      } else if(c == 'c'){
 9d2:	fdc42783          	lw	a5,-36(s0)
 9d6:	0007871b          	sext.w	a4,a5
 9da:	06300793          	li	a5,99
 9de:	02f71463          	bne	a4,a5,a06 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 9e2:	fb843783          	ld	a5,-72(s0)
 9e6:	00878713          	addi	a4,a5,8
 9ea:	fae43c23          	sd	a4,-72(s0)
 9ee:	439c                	lw	a5,0(a5)
 9f0:	0ff7f713          	zext.b	a4,a5
 9f4:	fcc42783          	lw	a5,-52(s0)
 9f8:	85ba                	mv	a1,a4
 9fa:	853e                	mv	a0,a5
 9fc:	00000097          	auipc	ra,0x0
 a00:	c5a080e7          	jalr	-934(ra) # 656 <putc>
 a04:	a899                	j	a5a <vprintf+0x23a>
      } else if(c == '%'){
 a06:	fdc42783          	lw	a5,-36(s0)
 a0a:	0007871b          	sext.w	a4,a5
 a0e:	02500793          	li	a5,37
 a12:	00f71f63          	bne	a4,a5,a30 <vprintf+0x210>
        putc(fd, c);
 a16:	fdc42783          	lw	a5,-36(s0)
 a1a:	0ff7f713          	zext.b	a4,a5
 a1e:	fcc42783          	lw	a5,-52(s0)
 a22:	85ba                	mv	a1,a4
 a24:	853e                	mv	a0,a5
 a26:	00000097          	auipc	ra,0x0
 a2a:	c30080e7          	jalr	-976(ra) # 656 <putc>
 a2e:	a035                	j	a5a <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a30:	fcc42783          	lw	a5,-52(s0)
 a34:	02500593          	li	a1,37
 a38:	853e                	mv	a0,a5
 a3a:	00000097          	auipc	ra,0x0
 a3e:	c1c080e7          	jalr	-996(ra) # 656 <putc>
        putc(fd, c);
 a42:	fdc42783          	lw	a5,-36(s0)
 a46:	0ff7f713          	zext.b	a4,a5
 a4a:	fcc42783          	lw	a5,-52(s0)
 a4e:	85ba                	mv	a1,a4
 a50:	853e                	mv	a0,a5
 a52:	00000097          	auipc	ra,0x0
 a56:	c04080e7          	jalr	-1020(ra) # 656 <putc>
      }
      state = 0;
 a5a:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 a5e:	fe442783          	lw	a5,-28(s0)
 a62:	2785                	addiw	a5,a5,1
 a64:	fef42223          	sw	a5,-28(s0)
 a68:	fe442783          	lw	a5,-28(s0)
 a6c:	fc043703          	ld	a4,-64(s0)
 a70:	97ba                	add	a5,a5,a4
 a72:	0007c783          	lbu	a5,0(a5)
 a76:	dc0795e3          	bnez	a5,840 <vprintf+0x20>
    }
  }
}
 a7a:	0001                	nop
 a7c:	0001                	nop
 a7e:	60a6                	ld	ra,72(sp)
 a80:	6406                	ld	s0,64(sp)
 a82:	6161                	addi	sp,sp,80
 a84:	8082                	ret

0000000000000a86 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a86:	7159                	addi	sp,sp,-112
 a88:	fc06                	sd	ra,56(sp)
 a8a:	f822                	sd	s0,48(sp)
 a8c:	0080                	addi	s0,sp,64
 a8e:	fcb43823          	sd	a1,-48(s0)
 a92:	e010                	sd	a2,0(s0)
 a94:	e414                	sd	a3,8(s0)
 a96:	e818                	sd	a4,16(s0)
 a98:	ec1c                	sd	a5,24(s0)
 a9a:	03043023          	sd	a6,32(s0)
 a9e:	03143423          	sd	a7,40(s0)
 aa2:	87aa                	mv	a5,a0
 aa4:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 aa8:	03040793          	addi	a5,s0,48
 aac:	fcf43423          	sd	a5,-56(s0)
 ab0:	fc843783          	ld	a5,-56(s0)
 ab4:	fd078793          	addi	a5,a5,-48
 ab8:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 abc:	fe843703          	ld	a4,-24(s0)
 ac0:	fdc42783          	lw	a5,-36(s0)
 ac4:	863a                	mv	a2,a4
 ac6:	fd043583          	ld	a1,-48(s0)
 aca:	853e                	mv	a0,a5
 acc:	00000097          	auipc	ra,0x0
 ad0:	d54080e7          	jalr	-684(ra) # 820 <vprintf>
}
 ad4:	0001                	nop
 ad6:	70e2                	ld	ra,56(sp)
 ad8:	7442                	ld	s0,48(sp)
 ada:	6165                	addi	sp,sp,112
 adc:	8082                	ret

0000000000000ade <printf>:

void
printf(const char *fmt, ...)
{
 ade:	7159                	addi	sp,sp,-112
 ae0:	f406                	sd	ra,40(sp)
 ae2:	f022                	sd	s0,32(sp)
 ae4:	1800                	addi	s0,sp,48
 ae6:	fca43c23          	sd	a0,-40(s0)
 aea:	e40c                	sd	a1,8(s0)
 aec:	e810                	sd	a2,16(s0)
 aee:	ec14                	sd	a3,24(s0)
 af0:	f018                	sd	a4,32(s0)
 af2:	f41c                	sd	a5,40(s0)
 af4:	03043823          	sd	a6,48(s0)
 af8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 afc:	04040793          	addi	a5,s0,64
 b00:	fcf43823          	sd	a5,-48(s0)
 b04:	fd043783          	ld	a5,-48(s0)
 b08:	fc878793          	addi	a5,a5,-56
 b0c:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 b10:	fe843783          	ld	a5,-24(s0)
 b14:	863e                	mv	a2,a5
 b16:	fd843583          	ld	a1,-40(s0)
 b1a:	4505                	li	a0,1
 b1c:	00000097          	auipc	ra,0x0
 b20:	d04080e7          	jalr	-764(ra) # 820 <vprintf>
}
 b24:	0001                	nop
 b26:	70a2                	ld	ra,40(sp)
 b28:	7402                	ld	s0,32(sp)
 b2a:	6165                	addi	sp,sp,112
 b2c:	8082                	ret

0000000000000b2e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b2e:	7179                	addi	sp,sp,-48
 b30:	f422                	sd	s0,40(sp)
 b32:	1800                	addi	s0,sp,48
 b34:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b38:	fd843783          	ld	a5,-40(s0)
 b3c:	17c1                	addi	a5,a5,-16
 b3e:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b42:	00000797          	auipc	a5,0x0
 b46:	5d678793          	addi	a5,a5,1494 # 1118 <freep>
 b4a:	639c                	ld	a5,0(a5)
 b4c:	fef43423          	sd	a5,-24(s0)
 b50:	a815                	j	b84 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b52:	fe843783          	ld	a5,-24(s0)
 b56:	639c                	ld	a5,0(a5)
 b58:	fe843703          	ld	a4,-24(s0)
 b5c:	00f76f63          	bltu	a4,a5,b7a <free+0x4c>
 b60:	fe043703          	ld	a4,-32(s0)
 b64:	fe843783          	ld	a5,-24(s0)
 b68:	02e7eb63          	bltu	a5,a4,b9e <free+0x70>
 b6c:	fe843783          	ld	a5,-24(s0)
 b70:	639c                	ld	a5,0(a5)
 b72:	fe043703          	ld	a4,-32(s0)
 b76:	02f76463          	bltu	a4,a5,b9e <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b7a:	fe843783          	ld	a5,-24(s0)
 b7e:	639c                	ld	a5,0(a5)
 b80:	fef43423          	sd	a5,-24(s0)
 b84:	fe043703          	ld	a4,-32(s0)
 b88:	fe843783          	ld	a5,-24(s0)
 b8c:	fce7f3e3          	bgeu	a5,a4,b52 <free+0x24>
 b90:	fe843783          	ld	a5,-24(s0)
 b94:	639c                	ld	a5,0(a5)
 b96:	fe043703          	ld	a4,-32(s0)
 b9a:	faf77ce3          	bgeu	a4,a5,b52 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b9e:	fe043783          	ld	a5,-32(s0)
 ba2:	479c                	lw	a5,8(a5)
 ba4:	1782                	slli	a5,a5,0x20
 ba6:	9381                	srli	a5,a5,0x20
 ba8:	0792                	slli	a5,a5,0x4
 baa:	fe043703          	ld	a4,-32(s0)
 bae:	973e                	add	a4,a4,a5
 bb0:	fe843783          	ld	a5,-24(s0)
 bb4:	639c                	ld	a5,0(a5)
 bb6:	02f71763          	bne	a4,a5,be4 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 bba:	fe043783          	ld	a5,-32(s0)
 bbe:	4798                	lw	a4,8(a5)
 bc0:	fe843783          	ld	a5,-24(s0)
 bc4:	639c                	ld	a5,0(a5)
 bc6:	479c                	lw	a5,8(a5)
 bc8:	9fb9                	addw	a5,a5,a4
 bca:	0007871b          	sext.w	a4,a5
 bce:	fe043783          	ld	a5,-32(s0)
 bd2:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 bd4:	fe843783          	ld	a5,-24(s0)
 bd8:	639c                	ld	a5,0(a5)
 bda:	6398                	ld	a4,0(a5)
 bdc:	fe043783          	ld	a5,-32(s0)
 be0:	e398                	sd	a4,0(a5)
 be2:	a039                	j	bf0 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 be4:	fe843783          	ld	a5,-24(s0)
 be8:	6398                	ld	a4,0(a5)
 bea:	fe043783          	ld	a5,-32(s0)
 bee:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 bf0:	fe843783          	ld	a5,-24(s0)
 bf4:	479c                	lw	a5,8(a5)
 bf6:	1782                	slli	a5,a5,0x20
 bf8:	9381                	srli	a5,a5,0x20
 bfa:	0792                	slli	a5,a5,0x4
 bfc:	fe843703          	ld	a4,-24(s0)
 c00:	97ba                	add	a5,a5,a4
 c02:	fe043703          	ld	a4,-32(s0)
 c06:	02f71563          	bne	a4,a5,c30 <free+0x102>
    p->s.size += bp->s.size;
 c0a:	fe843783          	ld	a5,-24(s0)
 c0e:	4798                	lw	a4,8(a5)
 c10:	fe043783          	ld	a5,-32(s0)
 c14:	479c                	lw	a5,8(a5)
 c16:	9fb9                	addw	a5,a5,a4
 c18:	0007871b          	sext.w	a4,a5
 c1c:	fe843783          	ld	a5,-24(s0)
 c20:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c22:	fe043783          	ld	a5,-32(s0)
 c26:	6398                	ld	a4,0(a5)
 c28:	fe843783          	ld	a5,-24(s0)
 c2c:	e398                	sd	a4,0(a5)
 c2e:	a031                	j	c3a <free+0x10c>
  } else
    p->s.ptr = bp;
 c30:	fe843783          	ld	a5,-24(s0)
 c34:	fe043703          	ld	a4,-32(s0)
 c38:	e398                	sd	a4,0(a5)
  freep = p;
 c3a:	00000797          	auipc	a5,0x0
 c3e:	4de78793          	addi	a5,a5,1246 # 1118 <freep>
 c42:	fe843703          	ld	a4,-24(s0)
 c46:	e398                	sd	a4,0(a5)
}
 c48:	0001                	nop
 c4a:	7422                	ld	s0,40(sp)
 c4c:	6145                	addi	sp,sp,48
 c4e:	8082                	ret

0000000000000c50 <morecore>:

static Header*
morecore(uint nu)
{
 c50:	7179                	addi	sp,sp,-48
 c52:	f406                	sd	ra,40(sp)
 c54:	f022                	sd	s0,32(sp)
 c56:	1800                	addi	s0,sp,48
 c58:	87aa                	mv	a5,a0
 c5a:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 c5e:	fdc42783          	lw	a5,-36(s0)
 c62:	0007871b          	sext.w	a4,a5
 c66:	6785                	lui	a5,0x1
 c68:	00f77563          	bgeu	a4,a5,c72 <morecore+0x22>
    nu = 4096;
 c6c:	6785                	lui	a5,0x1
 c6e:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c72:	fdc42783          	lw	a5,-36(s0)
 c76:	0047979b          	slliw	a5,a5,0x4
 c7a:	2781                	sext.w	a5,a5
 c7c:	2781                	sext.w	a5,a5
 c7e:	853e                	mv	a0,a5
 c80:	00000097          	auipc	ra,0x0
 c84:	9ae080e7          	jalr	-1618(ra) # 62e <sbrk>
 c88:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c8c:	fe843703          	ld	a4,-24(s0)
 c90:	57fd                	li	a5,-1
 c92:	00f71463          	bne	a4,a5,c9a <morecore+0x4a>
    return 0;
 c96:	4781                	li	a5,0
 c98:	a03d                	j	cc6 <morecore+0x76>
  hp = (Header*)p;
 c9a:	fe843783          	ld	a5,-24(s0)
 c9e:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 ca2:	fe043783          	ld	a5,-32(s0)
 ca6:	fdc42703          	lw	a4,-36(s0)
 caa:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 cac:	fe043783          	ld	a5,-32(s0)
 cb0:	07c1                	addi	a5,a5,16
 cb2:	853e                	mv	a0,a5
 cb4:	00000097          	auipc	ra,0x0
 cb8:	e7a080e7          	jalr	-390(ra) # b2e <free>
  return freep;
 cbc:	00000797          	auipc	a5,0x0
 cc0:	45c78793          	addi	a5,a5,1116 # 1118 <freep>
 cc4:	639c                	ld	a5,0(a5)
}
 cc6:	853e                	mv	a0,a5
 cc8:	70a2                	ld	ra,40(sp)
 cca:	7402                	ld	s0,32(sp)
 ccc:	6145                	addi	sp,sp,48
 cce:	8082                	ret

0000000000000cd0 <malloc>:

void*
malloc(uint nbytes)
{
 cd0:	7139                	addi	sp,sp,-64
 cd2:	fc06                	sd	ra,56(sp)
 cd4:	f822                	sd	s0,48(sp)
 cd6:	0080                	addi	s0,sp,64
 cd8:	87aa                	mv	a5,a0
 cda:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 cde:	fcc46783          	lwu	a5,-52(s0)
 ce2:	07bd                	addi	a5,a5,15
 ce4:	8391                	srli	a5,a5,0x4
 ce6:	2781                	sext.w	a5,a5
 ce8:	2785                	addiw	a5,a5,1
 cea:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 cee:	00000797          	auipc	a5,0x0
 cf2:	42a78793          	addi	a5,a5,1066 # 1118 <freep>
 cf6:	639c                	ld	a5,0(a5)
 cf8:	fef43023          	sd	a5,-32(s0)
 cfc:	fe043783          	ld	a5,-32(s0)
 d00:	ef95                	bnez	a5,d3c <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 d02:	00000797          	auipc	a5,0x0
 d06:	40678793          	addi	a5,a5,1030 # 1108 <base>
 d0a:	fef43023          	sd	a5,-32(s0)
 d0e:	00000797          	auipc	a5,0x0
 d12:	40a78793          	addi	a5,a5,1034 # 1118 <freep>
 d16:	fe043703          	ld	a4,-32(s0)
 d1a:	e398                	sd	a4,0(a5)
 d1c:	00000797          	auipc	a5,0x0
 d20:	3fc78793          	addi	a5,a5,1020 # 1118 <freep>
 d24:	6398                	ld	a4,0(a5)
 d26:	00000797          	auipc	a5,0x0
 d2a:	3e278793          	addi	a5,a5,994 # 1108 <base>
 d2e:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 d30:	00000797          	auipc	a5,0x0
 d34:	3d878793          	addi	a5,a5,984 # 1108 <base>
 d38:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d3c:	fe043783          	ld	a5,-32(s0)
 d40:	639c                	ld	a5,0(a5)
 d42:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d46:	fe843783          	ld	a5,-24(s0)
 d4a:	4798                	lw	a4,8(a5)
 d4c:	fdc42783          	lw	a5,-36(s0)
 d50:	2781                	sext.w	a5,a5
 d52:	06f76763          	bltu	a4,a5,dc0 <malloc+0xf0>
      if(p->s.size == nunits)
 d56:	fe843783          	ld	a5,-24(s0)
 d5a:	4798                	lw	a4,8(a5)
 d5c:	fdc42783          	lw	a5,-36(s0)
 d60:	2781                	sext.w	a5,a5
 d62:	00e79963          	bne	a5,a4,d74 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d66:	fe843783          	ld	a5,-24(s0)
 d6a:	6398                	ld	a4,0(a5)
 d6c:	fe043783          	ld	a5,-32(s0)
 d70:	e398                	sd	a4,0(a5)
 d72:	a825                	j	daa <malloc+0xda>
      else {
        p->s.size -= nunits;
 d74:	fe843783          	ld	a5,-24(s0)
 d78:	479c                	lw	a5,8(a5)
 d7a:	fdc42703          	lw	a4,-36(s0)
 d7e:	9f99                	subw	a5,a5,a4
 d80:	0007871b          	sext.w	a4,a5
 d84:	fe843783          	ld	a5,-24(s0)
 d88:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d8a:	fe843783          	ld	a5,-24(s0)
 d8e:	479c                	lw	a5,8(a5)
 d90:	1782                	slli	a5,a5,0x20
 d92:	9381                	srli	a5,a5,0x20
 d94:	0792                	slli	a5,a5,0x4
 d96:	fe843703          	ld	a4,-24(s0)
 d9a:	97ba                	add	a5,a5,a4
 d9c:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 da0:	fe843783          	ld	a5,-24(s0)
 da4:	fdc42703          	lw	a4,-36(s0)
 da8:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 daa:	00000797          	auipc	a5,0x0
 dae:	36e78793          	addi	a5,a5,878 # 1118 <freep>
 db2:	fe043703          	ld	a4,-32(s0)
 db6:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 db8:	fe843783          	ld	a5,-24(s0)
 dbc:	07c1                	addi	a5,a5,16
 dbe:	a091                	j	e02 <malloc+0x132>
    }
    if(p == freep)
 dc0:	00000797          	auipc	a5,0x0
 dc4:	35878793          	addi	a5,a5,856 # 1118 <freep>
 dc8:	639c                	ld	a5,0(a5)
 dca:	fe843703          	ld	a4,-24(s0)
 dce:	02f71063          	bne	a4,a5,dee <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 dd2:	fdc42783          	lw	a5,-36(s0)
 dd6:	853e                	mv	a0,a5
 dd8:	00000097          	auipc	ra,0x0
 ddc:	e78080e7          	jalr	-392(ra) # c50 <morecore>
 de0:	fea43423          	sd	a0,-24(s0)
 de4:	fe843783          	ld	a5,-24(s0)
 de8:	e399                	bnez	a5,dee <malloc+0x11e>
        return 0;
 dea:	4781                	li	a5,0
 dec:	a819                	j	e02 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dee:	fe843783          	ld	a5,-24(s0)
 df2:	fef43023          	sd	a5,-32(s0)
 df6:	fe843783          	ld	a5,-24(s0)
 dfa:	639c                	ld	a5,0(a5)
 dfc:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 e00:	b799                	j	d46 <malloc+0x76>
  }
}
 e02:	853e                	mv	a0,a5
 e04:	70e2                	ld	ra,56(sp)
 e06:	7442                	ld	s0,48(sp)
 e08:	6121                	addi	sp,sp,64
 e0a:	8082                	ret

0000000000000e0c <thread_create>:
typedef uint cont_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
 e0c:	7179                	addi	sp,sp,-48
 e0e:	f406                	sd	ra,40(sp)
 e10:	f022                	sd	s0,32(sp)
 e12:	1800                	addi	s0,sp,48
 e14:	fca43c23          	sd	a0,-40(s0)
 e18:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
 e1c:	6505                	lui	a0,0x1
 e1e:	00000097          	auipc	ra,0x0
 e22:	eb2080e7          	jalr	-334(ra) # cd0 <malloc>
 e26:	fea43423          	sd	a0,-24(s0)
 e2a:	fe843783          	ld	a5,-24(s0)
 e2e:	e38d                	bnez	a5,e50 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
 e30:	00000517          	auipc	a0,0x0
 e34:	26850513          	addi	a0,a0,616 # 1098 <cv_init+0xdc>
 e38:	00000097          	auipc	ra,0x0
 e3c:	ca6080e7          	jalr	-858(ra) # ade <printf>
        free(stack);
 e40:	fe843503          	ld	a0,-24(s0)
 e44:	00000097          	auipc	ra,0x0
 e48:	cea080e7          	jalr	-790(ra) # b2e <free>
        return -1;
 e4c:	57fd                	li	a5,-1
 e4e:	a099                	j	e94 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
 e50:	fe843783          	ld	a5,-24(s0)
 e54:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
 e58:	fe043703          	ld	a4,-32(s0)
 e5c:	6785                	lui	a5,0x1
 e5e:	17fd                	addi	a5,a5,-1
 e60:	8ff9                	and	a5,a5,a4
 e62:	cf91                	beqz	a5,e7e <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
 e64:	fe043703          	ld	a4,-32(s0)
 e68:	6785                	lui	a5,0x1
 e6a:	17fd                	addi	a5,a5,-1
 e6c:	8ff9                	and	a5,a5,a4
 e6e:	6705                	lui	a4,0x1
 e70:	40f707b3          	sub	a5,a4,a5
 e74:	fe843703          	ld	a4,-24(s0)
 e78:	97ba                	add	a5,a5,a4
 e7a:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
 e7e:	fe843603          	ld	a2,-24(s0)
 e82:	fd043583          	ld	a1,-48(s0)
 e86:	fd843503          	ld	a0,-40(s0)
 e8a:	fffff097          	auipc	ra,0xfffff
 e8e:	7bc080e7          	jalr	1980(ra) # 646 <clone>
 e92:	87aa                	mv	a5,a0
}
 e94:	853e                	mv	a0,a5
 e96:	70a2                	ld	ra,40(sp)
 e98:	7402                	ld	s0,32(sp)
 e9a:	6145                	addi	sp,sp,48
 e9c:	8082                	ret

0000000000000e9e <thread_join>:


int thread_join()
{
 e9e:	1101                	addi	sp,sp,-32
 ea0:	ec06                	sd	ra,24(sp)
 ea2:	e822                	sd	s0,16(sp)
 ea4:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
 ea6:	fe040793          	addi	a5,s0,-32
 eaa:	853e                	mv	a0,a5
 eac:	fffff097          	auipc	ra,0xfffff
 eb0:	7a2080e7          	jalr	1954(ra) # 64e <join>
 eb4:	87aa                	mv	a5,a0
 eb6:	fef42623          	sw	a5,-20(s0)
 eba:	fec42783          	lw	a5,-20(s0)
 ebe:	0007871b          	sext.w	a4,a5
 ec2:	57fd                	li	a5,-1
 ec4:	00f70963          	beq	a4,a5,ed6 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
 ec8:	fe043783          	ld	a5,-32(s0)
 ecc:	853e                	mv	a0,a5
 ece:	00000097          	auipc	ra,0x0
 ed2:	c60080e7          	jalr	-928(ra) # b2e <free>
    } 

    return child_tid;
 ed6:	fec42783          	lw	a5,-20(s0)
}
 eda:	853e                	mv	a0,a5
 edc:	60e2                	ld	ra,24(sp)
 ede:	6442                	ld	s0,16(sp)
 ee0:	6105                	addi	sp,sp,32
 ee2:	8082                	ret

0000000000000ee4 <lock_acquire>:


void lock_acquire (lock_t *lock){
 ee4:	1101                	addi	sp,sp,-32
 ee6:	ec22                	sd	s0,24(sp)
 ee8:	1000                	addi	s0,sp,32
 eea:	fea43423          	sd	a0,-24(s0)
    while( __sync_lock_test_and_set(lock, 1)!=0){
 eee:	0001                	nop
 ef0:	fe843783          	ld	a5,-24(s0)
 ef4:	4705                	li	a4,1
 ef6:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
 efa:	0007079b          	sext.w	a5,a4
 efe:	fbed                	bnez	a5,ef0 <lock_acquire+0xc>

    ;
    }
     __sync_synchronize();
 f00:	0ff0000f          	fence
        

}
 f04:	0001                	nop
 f06:	6462                	ld	s0,24(sp)
 f08:	6105                	addi	sp,sp,32
 f0a:	8082                	ret

0000000000000f0c <lock_release>:

void lock_release (lock_t *lock){
 f0c:	1101                	addi	sp,sp,-32
 f0e:	ec22                	sd	s0,24(sp)
 f10:	1000                	addi	s0,sp,32
 f12:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
 f16:	0ff0000f          	fence
    __sync_lock_release(lock);
 f1a:	fe843783          	ld	a5,-24(s0)
 f1e:	0f50000f          	fence	iorw,ow
 f22:	0807a02f          	amoswap.w	zero,zero,(a5)
   
}
 f26:	0001                	nop
 f28:	6462                	ld	s0,24(sp)
 f2a:	6105                	addi	sp,sp,32
 f2c:	8082                	ret

0000000000000f2e <lock_init>:

void lock_init (lock_t *lock){
 f2e:	1101                	addi	sp,sp,-32
 f30:	ec22                	sd	s0,24(sp)
 f32:	1000                	addi	s0,sp,32
 f34:	fea43423          	sd	a0,-24(s0)
    lock = 0;
 f38:	fe043423          	sd	zero,-24(s0)
    
}
 f3c:	0001                	nop
 f3e:	6462                	ld	s0,24(sp)
 f40:	6105                	addi	sp,sp,32
 f42:	8082                	ret

0000000000000f44 <cv_wait>:


void cv_wait (cont_t *cv, lock_t *lock){
 f44:	1101                	addi	sp,sp,-32
 f46:	ec06                	sd	ra,24(sp)
 f48:	e822                	sd	s0,16(sp)
 f4a:	1000                	addi	s0,sp,32
 f4c:	fea43423          	sd	a0,-24(s0)
 f50:	feb43023          	sd	a1,-32(s0)
    while( __sync_lock_test_and_set(cv, 0)!=1){
 f54:	a015                	j	f78 <cv_wait+0x34>
        lock_release(lock);
 f56:	fe043503          	ld	a0,-32(s0)
 f5a:	00000097          	auipc	ra,0x0
 f5e:	fb2080e7          	jalr	-78(ra) # f0c <lock_release>
        sleep(1);
 f62:	4505                	li	a0,1
 f64:	fffff097          	auipc	ra,0xfffff
 f68:	6d2080e7          	jalr	1746(ra) # 636 <sleep>
        lock_acquire(lock);
 f6c:	fe043503          	ld	a0,-32(s0)
 f70:	00000097          	auipc	ra,0x0
 f74:	f74080e7          	jalr	-140(ra) # ee4 <lock_acquire>
    while( __sync_lock_test_and_set(cv, 0)!=1){
 f78:	fe843783          	ld	a5,-24(s0)
 f7c:	4701                	li	a4,0
 f7e:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
 f82:	0007079b          	sext.w	a5,a4
 f86:	873e                	mv	a4,a5
 f88:	4785                	li	a5,1
 f8a:	fcf716e3          	bne	a4,a5,f56 <cv_wait+0x12>
    }

     __sync_synchronize();
 f8e:	0ff0000f          	fence

}
 f92:	0001                	nop
 f94:	60e2                	ld	ra,24(sp)
 f96:	6442                	ld	s0,16(sp)
 f98:	6105                	addi	sp,sp,32
 f9a:	8082                	ret

0000000000000f9c <cv_signal>:


void cv_signal (cont_t *cv){
 f9c:	1101                	addi	sp,sp,-32
 f9e:	ec22                	sd	s0,24(sp)
 fa0:	1000                	addi	s0,sp,32
 fa2:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
 fa6:	0ff0000f          	fence
     __sync_lock_test_and_set(cv, 1);
 faa:	fe843783          	ld	a5,-24(s0)
 fae:	4705                	li	a4,1
 fb0:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)

}
 fb4:	0001                	nop
 fb6:	6462                	ld	s0,24(sp)
 fb8:	6105                	addi	sp,sp,32
 fba:	8082                	ret

0000000000000fbc <cv_init>:


void cv_init (cont_t *cv){
 fbc:	1101                	addi	sp,sp,-32
 fbe:	ec22                	sd	s0,24(sp)
 fc0:	1000                	addi	s0,sp,32
 fc2:	fea43423          	sd	a0,-24(s0)
    cv = 0;
 fc6:	fe043423          	sd	zero,-24(s0)
 fca:	0001                	nop
 fcc:	6462                	ld	s0,24(sp)
 fce:	6105                	addi	sp,sp,32
 fd0:	8082                	ret
