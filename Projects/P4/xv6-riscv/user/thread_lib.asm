
user/_thread_lib:     file format elf64-littleriscv


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
  16:	cb8080e7          	jalr	-840(ra) # cca <malloc>
  1a:	fea43423          	sd	a0,-24(s0)
  1e:	fe843783          	ld	a5,-24(s0)
  22:	e38d                	bnez	a5,44 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
  24:	00001517          	auipc	a0,0x1
  28:	de450513          	addi	a0,a0,-540 # e08 <malloc+0x13e>
  2c:	00001097          	auipc	ra,0x1
  30:	aac080e7          	jalr	-1364(ra) # ad8 <printf>
        free(stack);
  34:	fe843503          	ld	a0,-24(s0)
  38:	00001097          	auipc	ra,0x1
  3c:	af0080e7          	jalr	-1296(ra) # b28 <free>
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
  7e:	00000097          	auipc	ra,0x0
  82:	5c2080e7          	jalr	1474(ra) # 640 <clone>
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
  a0:	00000097          	auipc	ra,0x0
  a4:	5a8080e7          	jalr	1448(ra) # 648 <join>
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
  c6:	a66080e7          	jalr	-1434(ra) # b28 <free>
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

000000000000010e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 10e:	7179                	addi	sp,sp,-48
 110:	f422                	sd	s0,40(sp)
 112:	1800                	addi	s0,sp,48
 114:	fca43c23          	sd	a0,-40(s0)
 118:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 11c:	fd843783          	ld	a5,-40(s0)
 120:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 124:	0001                	nop
 126:	fd043703          	ld	a4,-48(s0)
 12a:	00170793          	addi	a5,a4,1 # 1001 <__BSS_END__+0x171>
 12e:	fcf43823          	sd	a5,-48(s0)
 132:	fd843783          	ld	a5,-40(s0)
 136:	00178693          	addi	a3,a5,1 # 1001 <__BSS_END__+0x171>
 13a:	fcd43c23          	sd	a3,-40(s0)
 13e:	00074703          	lbu	a4,0(a4)
 142:	00e78023          	sb	a4,0(a5)
 146:	0007c783          	lbu	a5,0(a5)
 14a:	fff1                	bnez	a5,126 <strcpy+0x18>
    ;
  return os;
 14c:	fe843783          	ld	a5,-24(s0)
}
 150:	853e                	mv	a0,a5
 152:	7422                	ld	s0,40(sp)
 154:	6145                	addi	sp,sp,48
 156:	8082                	ret

0000000000000158 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 158:	1101                	addi	sp,sp,-32
 15a:	ec22                	sd	s0,24(sp)
 15c:	1000                	addi	s0,sp,32
 15e:	fea43423          	sd	a0,-24(s0)
 162:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 166:	a819                	j	17c <strcmp+0x24>
    p++, q++;
 168:	fe843783          	ld	a5,-24(s0)
 16c:	0785                	addi	a5,a5,1
 16e:	fef43423          	sd	a5,-24(s0)
 172:	fe043783          	ld	a5,-32(s0)
 176:	0785                	addi	a5,a5,1
 178:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 17c:	fe843783          	ld	a5,-24(s0)
 180:	0007c783          	lbu	a5,0(a5)
 184:	cb99                	beqz	a5,19a <strcmp+0x42>
 186:	fe843783          	ld	a5,-24(s0)
 18a:	0007c703          	lbu	a4,0(a5)
 18e:	fe043783          	ld	a5,-32(s0)
 192:	0007c783          	lbu	a5,0(a5)
 196:	fcf709e3          	beq	a4,a5,168 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 19a:	fe843783          	ld	a5,-24(s0)
 19e:	0007c783          	lbu	a5,0(a5)
 1a2:	0007871b          	sext.w	a4,a5
 1a6:	fe043783          	ld	a5,-32(s0)
 1aa:	0007c783          	lbu	a5,0(a5)
 1ae:	2781                	sext.w	a5,a5
 1b0:	40f707bb          	subw	a5,a4,a5
 1b4:	2781                	sext.w	a5,a5
}
 1b6:	853e                	mv	a0,a5
 1b8:	6462                	ld	s0,24(sp)
 1ba:	6105                	addi	sp,sp,32
 1bc:	8082                	ret

00000000000001be <strlen>:

uint
strlen(const char *s)
{
 1be:	7179                	addi	sp,sp,-48
 1c0:	f422                	sd	s0,40(sp)
 1c2:	1800                	addi	s0,sp,48
 1c4:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 1c8:	fe042623          	sw	zero,-20(s0)
 1cc:	a031                	j	1d8 <strlen+0x1a>
 1ce:	fec42783          	lw	a5,-20(s0)
 1d2:	2785                	addiw	a5,a5,1
 1d4:	fef42623          	sw	a5,-20(s0)
 1d8:	fec42783          	lw	a5,-20(s0)
 1dc:	fd843703          	ld	a4,-40(s0)
 1e0:	97ba                	add	a5,a5,a4
 1e2:	0007c783          	lbu	a5,0(a5)
 1e6:	f7e5                	bnez	a5,1ce <strlen+0x10>
    ;
  return n;
 1e8:	fec42783          	lw	a5,-20(s0)
}
 1ec:	853e                	mv	a0,a5
 1ee:	7422                	ld	s0,40(sp)
 1f0:	6145                	addi	sp,sp,48
 1f2:	8082                	ret

00000000000001f4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f4:	7179                	addi	sp,sp,-48
 1f6:	f422                	sd	s0,40(sp)
 1f8:	1800                	addi	s0,sp,48
 1fa:	fca43c23          	sd	a0,-40(s0)
 1fe:	87ae                	mv	a5,a1
 200:	8732                	mv	a4,a2
 202:	fcf42a23          	sw	a5,-44(s0)
 206:	87ba                	mv	a5,a4
 208:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 20c:	fd843783          	ld	a5,-40(s0)
 210:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 214:	fe042623          	sw	zero,-20(s0)
 218:	a00d                	j	23a <memset+0x46>
    cdst[i] = c;
 21a:	fec42783          	lw	a5,-20(s0)
 21e:	fe043703          	ld	a4,-32(s0)
 222:	97ba                	add	a5,a5,a4
 224:	fd442703          	lw	a4,-44(s0)
 228:	0ff77713          	zext.b	a4,a4
 22c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 230:	fec42783          	lw	a5,-20(s0)
 234:	2785                	addiw	a5,a5,1
 236:	fef42623          	sw	a5,-20(s0)
 23a:	fec42703          	lw	a4,-20(s0)
 23e:	fd042783          	lw	a5,-48(s0)
 242:	2781                	sext.w	a5,a5
 244:	fcf76be3          	bltu	a4,a5,21a <memset+0x26>
  }
  return dst;
 248:	fd843783          	ld	a5,-40(s0)
}
 24c:	853e                	mv	a0,a5
 24e:	7422                	ld	s0,40(sp)
 250:	6145                	addi	sp,sp,48
 252:	8082                	ret

0000000000000254 <strchr>:

char*
strchr(const char *s, char c)
{
 254:	1101                	addi	sp,sp,-32
 256:	ec22                	sd	s0,24(sp)
 258:	1000                	addi	s0,sp,32
 25a:	fea43423          	sd	a0,-24(s0)
 25e:	87ae                	mv	a5,a1
 260:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 264:	a01d                	j	28a <strchr+0x36>
    if(*s == c)
 266:	fe843783          	ld	a5,-24(s0)
 26a:	0007c703          	lbu	a4,0(a5)
 26e:	fe744783          	lbu	a5,-25(s0)
 272:	0ff7f793          	zext.b	a5,a5
 276:	00e79563          	bne	a5,a4,280 <strchr+0x2c>
      return (char*)s;
 27a:	fe843783          	ld	a5,-24(s0)
 27e:	a821                	j	296 <strchr+0x42>
  for(; *s; s++)
 280:	fe843783          	ld	a5,-24(s0)
 284:	0785                	addi	a5,a5,1
 286:	fef43423          	sd	a5,-24(s0)
 28a:	fe843783          	ld	a5,-24(s0)
 28e:	0007c783          	lbu	a5,0(a5)
 292:	fbf1                	bnez	a5,266 <strchr+0x12>
  return 0;
 294:	4781                	li	a5,0
}
 296:	853e                	mv	a0,a5
 298:	6462                	ld	s0,24(sp)
 29a:	6105                	addi	sp,sp,32
 29c:	8082                	ret

000000000000029e <gets>:

char*
gets(char *buf, int max)
{
 29e:	7179                	addi	sp,sp,-48
 2a0:	f406                	sd	ra,40(sp)
 2a2:	f022                	sd	s0,32(sp)
 2a4:	1800                	addi	s0,sp,48
 2a6:	fca43c23          	sd	a0,-40(s0)
 2aa:	87ae                	mv	a5,a1
 2ac:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b0:	fe042623          	sw	zero,-20(s0)
 2b4:	a8a1                	j	30c <gets+0x6e>
    cc = read(0, &c, 1);
 2b6:	fe740793          	addi	a5,s0,-25
 2ba:	4605                	li	a2,1
 2bc:	85be                	mv	a1,a5
 2be:	4501                	li	a0,0
 2c0:	00000097          	auipc	ra,0x0
 2c4:	2f8080e7          	jalr	760(ra) # 5b8 <read>
 2c8:	87aa                	mv	a5,a0
 2ca:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 2ce:	fe842783          	lw	a5,-24(s0)
 2d2:	2781                	sext.w	a5,a5
 2d4:	04f05763          	blez	a5,322 <gets+0x84>
      break;
    buf[i++] = c;
 2d8:	fec42783          	lw	a5,-20(s0)
 2dc:	0017871b          	addiw	a4,a5,1
 2e0:	fee42623          	sw	a4,-20(s0)
 2e4:	873e                	mv	a4,a5
 2e6:	fd843783          	ld	a5,-40(s0)
 2ea:	97ba                	add	a5,a5,a4
 2ec:	fe744703          	lbu	a4,-25(s0)
 2f0:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 2f4:	fe744783          	lbu	a5,-25(s0)
 2f8:	873e                	mv	a4,a5
 2fa:	47a9                	li	a5,10
 2fc:	02f70463          	beq	a4,a5,324 <gets+0x86>
 300:	fe744783          	lbu	a5,-25(s0)
 304:	873e                	mv	a4,a5
 306:	47b5                	li	a5,13
 308:	00f70e63          	beq	a4,a5,324 <gets+0x86>
  for(i=0; i+1 < max; ){
 30c:	fec42783          	lw	a5,-20(s0)
 310:	2785                	addiw	a5,a5,1
 312:	0007871b          	sext.w	a4,a5
 316:	fd442783          	lw	a5,-44(s0)
 31a:	2781                	sext.w	a5,a5
 31c:	f8f74de3          	blt	a4,a5,2b6 <gets+0x18>
 320:	a011                	j	324 <gets+0x86>
      break;
 322:	0001                	nop
      break;
  }
  buf[i] = '\0';
 324:	fec42783          	lw	a5,-20(s0)
 328:	fd843703          	ld	a4,-40(s0)
 32c:	97ba                	add	a5,a5,a4
 32e:	00078023          	sb	zero,0(a5)
  return buf;
 332:	fd843783          	ld	a5,-40(s0)
}
 336:	853e                	mv	a0,a5
 338:	70a2                	ld	ra,40(sp)
 33a:	7402                	ld	s0,32(sp)
 33c:	6145                	addi	sp,sp,48
 33e:	8082                	ret

0000000000000340 <stat>:

int
stat(const char *n, struct stat *st)
{
 340:	7179                	addi	sp,sp,-48
 342:	f406                	sd	ra,40(sp)
 344:	f022                	sd	s0,32(sp)
 346:	1800                	addi	s0,sp,48
 348:	fca43c23          	sd	a0,-40(s0)
 34c:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 350:	4581                	li	a1,0
 352:	fd843503          	ld	a0,-40(s0)
 356:	00000097          	auipc	ra,0x0
 35a:	28a080e7          	jalr	650(ra) # 5e0 <open>
 35e:	87aa                	mv	a5,a0
 360:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 364:	fec42783          	lw	a5,-20(s0)
 368:	2781                	sext.w	a5,a5
 36a:	0007d463          	bgez	a5,372 <stat+0x32>
    return -1;
 36e:	57fd                	li	a5,-1
 370:	a035                	j	39c <stat+0x5c>
  r = fstat(fd, st);
 372:	fec42783          	lw	a5,-20(s0)
 376:	fd043583          	ld	a1,-48(s0)
 37a:	853e                	mv	a0,a5
 37c:	00000097          	auipc	ra,0x0
 380:	27c080e7          	jalr	636(ra) # 5f8 <fstat>
 384:	87aa                	mv	a5,a0
 386:	fef42423          	sw	a5,-24(s0)
  close(fd);
 38a:	fec42783          	lw	a5,-20(s0)
 38e:	853e                	mv	a0,a5
 390:	00000097          	auipc	ra,0x0
 394:	238080e7          	jalr	568(ra) # 5c8 <close>
  return r;
 398:	fe842783          	lw	a5,-24(s0)
}
 39c:	853e                	mv	a0,a5
 39e:	70a2                	ld	ra,40(sp)
 3a0:	7402                	ld	s0,32(sp)
 3a2:	6145                	addi	sp,sp,48
 3a4:	8082                	ret

00000000000003a6 <atoi>:

int
atoi(const char *s)
{
 3a6:	7179                	addi	sp,sp,-48
 3a8:	f422                	sd	s0,40(sp)
 3aa:	1800                	addi	s0,sp,48
 3ac:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 3b0:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 3b4:	a81d                	j	3ea <atoi+0x44>
    n = n*10 + *s++ - '0';
 3b6:	fec42783          	lw	a5,-20(s0)
 3ba:	873e                	mv	a4,a5
 3bc:	87ba                	mv	a5,a4
 3be:	0027979b          	slliw	a5,a5,0x2
 3c2:	9fb9                	addw	a5,a5,a4
 3c4:	0017979b          	slliw	a5,a5,0x1
 3c8:	0007871b          	sext.w	a4,a5
 3cc:	fd843783          	ld	a5,-40(s0)
 3d0:	00178693          	addi	a3,a5,1
 3d4:	fcd43c23          	sd	a3,-40(s0)
 3d8:	0007c783          	lbu	a5,0(a5)
 3dc:	2781                	sext.w	a5,a5
 3de:	9fb9                	addw	a5,a5,a4
 3e0:	2781                	sext.w	a5,a5
 3e2:	fd07879b          	addiw	a5,a5,-48
 3e6:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 3ea:	fd843783          	ld	a5,-40(s0)
 3ee:	0007c783          	lbu	a5,0(a5)
 3f2:	873e                	mv	a4,a5
 3f4:	02f00793          	li	a5,47
 3f8:	00e7fb63          	bgeu	a5,a4,40e <atoi+0x68>
 3fc:	fd843783          	ld	a5,-40(s0)
 400:	0007c783          	lbu	a5,0(a5)
 404:	873e                	mv	a4,a5
 406:	03900793          	li	a5,57
 40a:	fae7f6e3          	bgeu	a5,a4,3b6 <atoi+0x10>
  return n;
 40e:	fec42783          	lw	a5,-20(s0)
}
 412:	853e                	mv	a0,a5
 414:	7422                	ld	s0,40(sp)
 416:	6145                	addi	sp,sp,48
 418:	8082                	ret

000000000000041a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 41a:	7139                	addi	sp,sp,-64
 41c:	fc22                	sd	s0,56(sp)
 41e:	0080                	addi	s0,sp,64
 420:	fca43c23          	sd	a0,-40(s0)
 424:	fcb43823          	sd	a1,-48(s0)
 428:	87b2                	mv	a5,a2
 42a:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 42e:	fd843783          	ld	a5,-40(s0)
 432:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 436:	fd043783          	ld	a5,-48(s0)
 43a:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 43e:	fe043703          	ld	a4,-32(s0)
 442:	fe843783          	ld	a5,-24(s0)
 446:	02e7fc63          	bgeu	a5,a4,47e <memmove+0x64>
    while(n-- > 0)
 44a:	a00d                	j	46c <memmove+0x52>
      *dst++ = *src++;
 44c:	fe043703          	ld	a4,-32(s0)
 450:	00170793          	addi	a5,a4,1
 454:	fef43023          	sd	a5,-32(s0)
 458:	fe843783          	ld	a5,-24(s0)
 45c:	00178693          	addi	a3,a5,1
 460:	fed43423          	sd	a3,-24(s0)
 464:	00074703          	lbu	a4,0(a4)
 468:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 46c:	fcc42783          	lw	a5,-52(s0)
 470:	fff7871b          	addiw	a4,a5,-1
 474:	fce42623          	sw	a4,-52(s0)
 478:	fcf04ae3          	bgtz	a5,44c <memmove+0x32>
 47c:	a891                	j	4d0 <memmove+0xb6>
  } else {
    dst += n;
 47e:	fcc42783          	lw	a5,-52(s0)
 482:	fe843703          	ld	a4,-24(s0)
 486:	97ba                	add	a5,a5,a4
 488:	fef43423          	sd	a5,-24(s0)
    src += n;
 48c:	fcc42783          	lw	a5,-52(s0)
 490:	fe043703          	ld	a4,-32(s0)
 494:	97ba                	add	a5,a5,a4
 496:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 49a:	a01d                	j	4c0 <memmove+0xa6>
      *--dst = *--src;
 49c:	fe043783          	ld	a5,-32(s0)
 4a0:	17fd                	addi	a5,a5,-1
 4a2:	fef43023          	sd	a5,-32(s0)
 4a6:	fe843783          	ld	a5,-24(s0)
 4aa:	17fd                	addi	a5,a5,-1
 4ac:	fef43423          	sd	a5,-24(s0)
 4b0:	fe043783          	ld	a5,-32(s0)
 4b4:	0007c703          	lbu	a4,0(a5)
 4b8:	fe843783          	ld	a5,-24(s0)
 4bc:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4c0:	fcc42783          	lw	a5,-52(s0)
 4c4:	fff7871b          	addiw	a4,a5,-1
 4c8:	fce42623          	sw	a4,-52(s0)
 4cc:	fcf048e3          	bgtz	a5,49c <memmove+0x82>
  }
  return vdst;
 4d0:	fd843783          	ld	a5,-40(s0)
}
 4d4:	853e                	mv	a0,a5
 4d6:	7462                	ld	s0,56(sp)
 4d8:	6121                	addi	sp,sp,64
 4da:	8082                	ret

00000000000004dc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4dc:	7139                	addi	sp,sp,-64
 4de:	fc22                	sd	s0,56(sp)
 4e0:	0080                	addi	s0,sp,64
 4e2:	fca43c23          	sd	a0,-40(s0)
 4e6:	fcb43823          	sd	a1,-48(s0)
 4ea:	87b2                	mv	a5,a2
 4ec:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 4f0:	fd843783          	ld	a5,-40(s0)
 4f4:	fef43423          	sd	a5,-24(s0)
 4f8:	fd043783          	ld	a5,-48(s0)
 4fc:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 500:	a0a1                	j	548 <memcmp+0x6c>
    if (*p1 != *p2) {
 502:	fe843783          	ld	a5,-24(s0)
 506:	0007c703          	lbu	a4,0(a5)
 50a:	fe043783          	ld	a5,-32(s0)
 50e:	0007c783          	lbu	a5,0(a5)
 512:	02f70163          	beq	a4,a5,534 <memcmp+0x58>
      return *p1 - *p2;
 516:	fe843783          	ld	a5,-24(s0)
 51a:	0007c783          	lbu	a5,0(a5)
 51e:	0007871b          	sext.w	a4,a5
 522:	fe043783          	ld	a5,-32(s0)
 526:	0007c783          	lbu	a5,0(a5)
 52a:	2781                	sext.w	a5,a5
 52c:	40f707bb          	subw	a5,a4,a5
 530:	2781                	sext.w	a5,a5
 532:	a01d                	j	558 <memcmp+0x7c>
    }
    p1++;
 534:	fe843783          	ld	a5,-24(s0)
 538:	0785                	addi	a5,a5,1
 53a:	fef43423          	sd	a5,-24(s0)
    p2++;
 53e:	fe043783          	ld	a5,-32(s0)
 542:	0785                	addi	a5,a5,1
 544:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 548:	fcc42783          	lw	a5,-52(s0)
 54c:	fff7871b          	addiw	a4,a5,-1
 550:	fce42623          	sw	a4,-52(s0)
 554:	f7dd                	bnez	a5,502 <memcmp+0x26>
  }
  return 0;
 556:	4781                	li	a5,0
}
 558:	853e                	mv	a0,a5
 55a:	7462                	ld	s0,56(sp)
 55c:	6121                	addi	sp,sp,64
 55e:	8082                	ret

0000000000000560 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 560:	7179                	addi	sp,sp,-48
 562:	f406                	sd	ra,40(sp)
 564:	f022                	sd	s0,32(sp)
 566:	1800                	addi	s0,sp,48
 568:	fea43423          	sd	a0,-24(s0)
 56c:	feb43023          	sd	a1,-32(s0)
 570:	87b2                	mv	a5,a2
 572:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 576:	fdc42783          	lw	a5,-36(s0)
 57a:	863e                	mv	a2,a5
 57c:	fe043583          	ld	a1,-32(s0)
 580:	fe843503          	ld	a0,-24(s0)
 584:	00000097          	auipc	ra,0x0
 588:	e96080e7          	jalr	-362(ra) # 41a <memmove>
 58c:	87aa                	mv	a5,a0
}
 58e:	853e                	mv	a0,a5
 590:	70a2                	ld	ra,40(sp)
 592:	7402                	ld	s0,32(sp)
 594:	6145                	addi	sp,sp,48
 596:	8082                	ret

0000000000000598 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 598:	4885                	li	a7,1
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5a0:	4889                	li	a7,2
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5a8:	488d                	li	a7,3
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5b0:	4891                	li	a7,4
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <read>:
.global read
read:
 li a7, SYS_read
 5b8:	4895                	li	a7,5
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <write>:
.global write
write:
 li a7, SYS_write
 5c0:	48c1                	li	a7,16
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <close>:
.global close
close:
 li a7, SYS_close
 5c8:	48d5                	li	a7,21
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5d0:	4899                	li	a7,6
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5d8:	489d                	li	a7,7
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <open>:
.global open
open:
 li a7, SYS_open
 5e0:	48bd                	li	a7,15
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5e8:	48c5                	li	a7,17
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5f0:	48c9                	li	a7,18
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5f8:	48a1                	li	a7,8
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <link>:
.global link
link:
 li a7, SYS_link
 600:	48cd                	li	a7,19
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 608:	48d1                	li	a7,20
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 610:	48a5                	li	a7,9
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <dup>:
.global dup
dup:
 li a7, SYS_dup
 618:	48a9                	li	a7,10
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 620:	48ad                	li	a7,11
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 628:	48b1                	li	a7,12
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 630:	48b5                	li	a7,13
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 638:	48b9                	li	a7,14
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <clone>:
.global clone
clone:
 li a7, SYS_clone
 640:	48d9                	li	a7,22
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <join>:
.global join
join:
 li a7, SYS_join
 648:	48dd                	li	a7,23
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 650:	1101                	addi	sp,sp,-32
 652:	ec06                	sd	ra,24(sp)
 654:	e822                	sd	s0,16(sp)
 656:	1000                	addi	s0,sp,32
 658:	87aa                	mv	a5,a0
 65a:	872e                	mv	a4,a1
 65c:	fef42623          	sw	a5,-20(s0)
 660:	87ba                	mv	a5,a4
 662:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 666:	feb40713          	addi	a4,s0,-21
 66a:	fec42783          	lw	a5,-20(s0)
 66e:	4605                	li	a2,1
 670:	85ba                	mv	a1,a4
 672:	853e                	mv	a0,a5
 674:	00000097          	auipc	ra,0x0
 678:	f4c080e7          	jalr	-180(ra) # 5c0 <write>
}
 67c:	0001                	nop
 67e:	60e2                	ld	ra,24(sp)
 680:	6442                	ld	s0,16(sp)
 682:	6105                	addi	sp,sp,32
 684:	8082                	ret

0000000000000686 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 686:	7139                	addi	sp,sp,-64
 688:	fc06                	sd	ra,56(sp)
 68a:	f822                	sd	s0,48(sp)
 68c:	0080                	addi	s0,sp,64
 68e:	87aa                	mv	a5,a0
 690:	8736                	mv	a4,a3
 692:	fcf42623          	sw	a5,-52(s0)
 696:	87ae                	mv	a5,a1
 698:	fcf42423          	sw	a5,-56(s0)
 69c:	87b2                	mv	a5,a2
 69e:	fcf42223          	sw	a5,-60(s0)
 6a2:	87ba                	mv	a5,a4
 6a4:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6a8:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 6ac:	fc042783          	lw	a5,-64(s0)
 6b0:	2781                	sext.w	a5,a5
 6b2:	c38d                	beqz	a5,6d4 <printint+0x4e>
 6b4:	fc842783          	lw	a5,-56(s0)
 6b8:	2781                	sext.w	a5,a5
 6ba:	0007dd63          	bgez	a5,6d4 <printint+0x4e>
    neg = 1;
 6be:	4785                	li	a5,1
 6c0:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 6c4:	fc842783          	lw	a5,-56(s0)
 6c8:	40f007bb          	negw	a5,a5
 6cc:	2781                	sext.w	a5,a5
 6ce:	fef42223          	sw	a5,-28(s0)
 6d2:	a029                	j	6dc <printint+0x56>
  } else {
    x = xx;
 6d4:	fc842783          	lw	a5,-56(s0)
 6d8:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 6dc:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 6e0:	fc442783          	lw	a5,-60(s0)
 6e4:	fe442703          	lw	a4,-28(s0)
 6e8:	02f777bb          	remuw	a5,a4,a5
 6ec:	0007861b          	sext.w	a2,a5
 6f0:	fec42783          	lw	a5,-20(s0)
 6f4:	0017871b          	addiw	a4,a5,1
 6f8:	fee42623          	sw	a4,-20(s0)
 6fc:	00000697          	auipc	a3,0x0
 700:	76468693          	addi	a3,a3,1892 # e60 <digits>
 704:	02061713          	slli	a4,a2,0x20
 708:	9301                	srli	a4,a4,0x20
 70a:	9736                	add	a4,a4,a3
 70c:	00074703          	lbu	a4,0(a4)
 710:	17c1                	addi	a5,a5,-16
 712:	97a2                	add	a5,a5,s0
 714:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 718:	fc442783          	lw	a5,-60(s0)
 71c:	fe442703          	lw	a4,-28(s0)
 720:	02f757bb          	divuw	a5,a4,a5
 724:	fef42223          	sw	a5,-28(s0)
 728:	fe442783          	lw	a5,-28(s0)
 72c:	2781                	sext.w	a5,a5
 72e:	fbcd                	bnez	a5,6e0 <printint+0x5a>
  if(neg)
 730:	fe842783          	lw	a5,-24(s0)
 734:	2781                	sext.w	a5,a5
 736:	cf85                	beqz	a5,76e <printint+0xe8>
    buf[i++] = '-';
 738:	fec42783          	lw	a5,-20(s0)
 73c:	0017871b          	addiw	a4,a5,1
 740:	fee42623          	sw	a4,-20(s0)
 744:	17c1                	addi	a5,a5,-16
 746:	97a2                	add	a5,a5,s0
 748:	02d00713          	li	a4,45
 74c:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 750:	a839                	j	76e <printint+0xe8>
    putc(fd, buf[i]);
 752:	fec42783          	lw	a5,-20(s0)
 756:	17c1                	addi	a5,a5,-16
 758:	97a2                	add	a5,a5,s0
 75a:	fe07c703          	lbu	a4,-32(a5)
 75e:	fcc42783          	lw	a5,-52(s0)
 762:	85ba                	mv	a1,a4
 764:	853e                	mv	a0,a5
 766:	00000097          	auipc	ra,0x0
 76a:	eea080e7          	jalr	-278(ra) # 650 <putc>
  while(--i >= 0)
 76e:	fec42783          	lw	a5,-20(s0)
 772:	37fd                	addiw	a5,a5,-1
 774:	fef42623          	sw	a5,-20(s0)
 778:	fec42783          	lw	a5,-20(s0)
 77c:	2781                	sext.w	a5,a5
 77e:	fc07dae3          	bgez	a5,752 <printint+0xcc>
}
 782:	0001                	nop
 784:	0001                	nop
 786:	70e2                	ld	ra,56(sp)
 788:	7442                	ld	s0,48(sp)
 78a:	6121                	addi	sp,sp,64
 78c:	8082                	ret

000000000000078e <printptr>:

static void
printptr(int fd, uint64 x) {
 78e:	7179                	addi	sp,sp,-48
 790:	f406                	sd	ra,40(sp)
 792:	f022                	sd	s0,32(sp)
 794:	1800                	addi	s0,sp,48
 796:	87aa                	mv	a5,a0
 798:	fcb43823          	sd	a1,-48(s0)
 79c:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 7a0:	fdc42783          	lw	a5,-36(s0)
 7a4:	03000593          	li	a1,48
 7a8:	853e                	mv	a0,a5
 7aa:	00000097          	auipc	ra,0x0
 7ae:	ea6080e7          	jalr	-346(ra) # 650 <putc>
  putc(fd, 'x');
 7b2:	fdc42783          	lw	a5,-36(s0)
 7b6:	07800593          	li	a1,120
 7ba:	853e                	mv	a0,a5
 7bc:	00000097          	auipc	ra,0x0
 7c0:	e94080e7          	jalr	-364(ra) # 650 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7c4:	fe042623          	sw	zero,-20(s0)
 7c8:	a82d                	j	802 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7ca:	fd043783          	ld	a5,-48(s0)
 7ce:	93f1                	srli	a5,a5,0x3c
 7d0:	00000717          	auipc	a4,0x0
 7d4:	69070713          	addi	a4,a4,1680 # e60 <digits>
 7d8:	97ba                	add	a5,a5,a4
 7da:	0007c703          	lbu	a4,0(a5)
 7de:	fdc42783          	lw	a5,-36(s0)
 7e2:	85ba                	mv	a1,a4
 7e4:	853e                	mv	a0,a5
 7e6:	00000097          	auipc	ra,0x0
 7ea:	e6a080e7          	jalr	-406(ra) # 650 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ee:	fec42783          	lw	a5,-20(s0)
 7f2:	2785                	addiw	a5,a5,1
 7f4:	fef42623          	sw	a5,-20(s0)
 7f8:	fd043783          	ld	a5,-48(s0)
 7fc:	0792                	slli	a5,a5,0x4
 7fe:	fcf43823          	sd	a5,-48(s0)
 802:	fec42783          	lw	a5,-20(s0)
 806:	873e                	mv	a4,a5
 808:	47bd                	li	a5,15
 80a:	fce7f0e3          	bgeu	a5,a4,7ca <printptr+0x3c>
}
 80e:	0001                	nop
 810:	0001                	nop
 812:	70a2                	ld	ra,40(sp)
 814:	7402                	ld	s0,32(sp)
 816:	6145                	addi	sp,sp,48
 818:	8082                	ret

000000000000081a <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 81a:	715d                	addi	sp,sp,-80
 81c:	e486                	sd	ra,72(sp)
 81e:	e0a2                	sd	s0,64(sp)
 820:	0880                	addi	s0,sp,80
 822:	87aa                	mv	a5,a0
 824:	fcb43023          	sd	a1,-64(s0)
 828:	fac43c23          	sd	a2,-72(s0)
 82c:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 830:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 834:	fe042223          	sw	zero,-28(s0)
 838:	a42d                	j	a62 <vprintf+0x248>
    c = fmt[i] & 0xff;
 83a:	fe442783          	lw	a5,-28(s0)
 83e:	fc043703          	ld	a4,-64(s0)
 842:	97ba                	add	a5,a5,a4
 844:	0007c783          	lbu	a5,0(a5)
 848:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 84c:	fe042783          	lw	a5,-32(s0)
 850:	2781                	sext.w	a5,a5
 852:	eb9d                	bnez	a5,888 <vprintf+0x6e>
      if(c == '%'){
 854:	fdc42783          	lw	a5,-36(s0)
 858:	0007871b          	sext.w	a4,a5
 85c:	02500793          	li	a5,37
 860:	00f71763          	bne	a4,a5,86e <vprintf+0x54>
        state = '%';
 864:	02500793          	li	a5,37
 868:	fef42023          	sw	a5,-32(s0)
 86c:	a2f5                	j	a58 <vprintf+0x23e>
      } else {
        putc(fd, c);
 86e:	fdc42783          	lw	a5,-36(s0)
 872:	0ff7f713          	zext.b	a4,a5
 876:	fcc42783          	lw	a5,-52(s0)
 87a:	85ba                	mv	a1,a4
 87c:	853e                	mv	a0,a5
 87e:	00000097          	auipc	ra,0x0
 882:	dd2080e7          	jalr	-558(ra) # 650 <putc>
 886:	aac9                	j	a58 <vprintf+0x23e>
      }
    } else if(state == '%'){
 888:	fe042783          	lw	a5,-32(s0)
 88c:	0007871b          	sext.w	a4,a5
 890:	02500793          	li	a5,37
 894:	1cf71263          	bne	a4,a5,a58 <vprintf+0x23e>
      if(c == 'd'){
 898:	fdc42783          	lw	a5,-36(s0)
 89c:	0007871b          	sext.w	a4,a5
 8a0:	06400793          	li	a5,100
 8a4:	02f71463          	bne	a4,a5,8cc <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 8a8:	fb843783          	ld	a5,-72(s0)
 8ac:	00878713          	addi	a4,a5,8
 8b0:	fae43c23          	sd	a4,-72(s0)
 8b4:	4398                	lw	a4,0(a5)
 8b6:	fcc42783          	lw	a5,-52(s0)
 8ba:	4685                	li	a3,1
 8bc:	4629                	li	a2,10
 8be:	85ba                	mv	a1,a4
 8c0:	853e                	mv	a0,a5
 8c2:	00000097          	auipc	ra,0x0
 8c6:	dc4080e7          	jalr	-572(ra) # 686 <printint>
 8ca:	a269                	j	a54 <vprintf+0x23a>
      } else if(c == 'l') {
 8cc:	fdc42783          	lw	a5,-36(s0)
 8d0:	0007871b          	sext.w	a4,a5
 8d4:	06c00793          	li	a5,108
 8d8:	02f71663          	bne	a4,a5,904 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8dc:	fb843783          	ld	a5,-72(s0)
 8e0:	00878713          	addi	a4,a5,8
 8e4:	fae43c23          	sd	a4,-72(s0)
 8e8:	639c                	ld	a5,0(a5)
 8ea:	0007871b          	sext.w	a4,a5
 8ee:	fcc42783          	lw	a5,-52(s0)
 8f2:	4681                	li	a3,0
 8f4:	4629                	li	a2,10
 8f6:	85ba                	mv	a1,a4
 8f8:	853e                	mv	a0,a5
 8fa:	00000097          	auipc	ra,0x0
 8fe:	d8c080e7          	jalr	-628(ra) # 686 <printint>
 902:	aa89                	j	a54 <vprintf+0x23a>
      } else if(c == 'x') {
 904:	fdc42783          	lw	a5,-36(s0)
 908:	0007871b          	sext.w	a4,a5
 90c:	07800793          	li	a5,120
 910:	02f71463          	bne	a4,a5,938 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 914:	fb843783          	ld	a5,-72(s0)
 918:	00878713          	addi	a4,a5,8
 91c:	fae43c23          	sd	a4,-72(s0)
 920:	4398                	lw	a4,0(a5)
 922:	fcc42783          	lw	a5,-52(s0)
 926:	4681                	li	a3,0
 928:	4641                	li	a2,16
 92a:	85ba                	mv	a1,a4
 92c:	853e                	mv	a0,a5
 92e:	00000097          	auipc	ra,0x0
 932:	d58080e7          	jalr	-680(ra) # 686 <printint>
 936:	aa39                	j	a54 <vprintf+0x23a>
      } else if(c == 'p') {
 938:	fdc42783          	lw	a5,-36(s0)
 93c:	0007871b          	sext.w	a4,a5
 940:	07000793          	li	a5,112
 944:	02f71263          	bne	a4,a5,968 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 948:	fb843783          	ld	a5,-72(s0)
 94c:	00878713          	addi	a4,a5,8
 950:	fae43c23          	sd	a4,-72(s0)
 954:	6398                	ld	a4,0(a5)
 956:	fcc42783          	lw	a5,-52(s0)
 95a:	85ba                	mv	a1,a4
 95c:	853e                	mv	a0,a5
 95e:	00000097          	auipc	ra,0x0
 962:	e30080e7          	jalr	-464(ra) # 78e <printptr>
 966:	a0fd                	j	a54 <vprintf+0x23a>
      } else if(c == 's'){
 968:	fdc42783          	lw	a5,-36(s0)
 96c:	0007871b          	sext.w	a4,a5
 970:	07300793          	li	a5,115
 974:	04f71c63          	bne	a4,a5,9cc <vprintf+0x1b2>
        s = va_arg(ap, char*);
 978:	fb843783          	ld	a5,-72(s0)
 97c:	00878713          	addi	a4,a5,8
 980:	fae43c23          	sd	a4,-72(s0)
 984:	639c                	ld	a5,0(a5)
 986:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 98a:	fe843783          	ld	a5,-24(s0)
 98e:	eb8d                	bnez	a5,9c0 <vprintf+0x1a6>
          s = "(null)";
 990:	00000797          	auipc	a5,0x0
 994:	4c878793          	addi	a5,a5,1224 # e58 <malloc+0x18e>
 998:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 99c:	a015                	j	9c0 <vprintf+0x1a6>
          putc(fd, *s);
 99e:	fe843783          	ld	a5,-24(s0)
 9a2:	0007c703          	lbu	a4,0(a5)
 9a6:	fcc42783          	lw	a5,-52(s0)
 9aa:	85ba                	mv	a1,a4
 9ac:	853e                	mv	a0,a5
 9ae:	00000097          	auipc	ra,0x0
 9b2:	ca2080e7          	jalr	-862(ra) # 650 <putc>
          s++;
 9b6:	fe843783          	ld	a5,-24(s0)
 9ba:	0785                	addi	a5,a5,1
 9bc:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 9c0:	fe843783          	ld	a5,-24(s0)
 9c4:	0007c783          	lbu	a5,0(a5)
 9c8:	fbf9                	bnez	a5,99e <vprintf+0x184>
 9ca:	a069                	j	a54 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 9cc:	fdc42783          	lw	a5,-36(s0)
 9d0:	0007871b          	sext.w	a4,a5
 9d4:	06300793          	li	a5,99
 9d8:	02f71463          	bne	a4,a5,a00 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 9dc:	fb843783          	ld	a5,-72(s0)
 9e0:	00878713          	addi	a4,a5,8
 9e4:	fae43c23          	sd	a4,-72(s0)
 9e8:	439c                	lw	a5,0(a5)
 9ea:	0ff7f713          	zext.b	a4,a5
 9ee:	fcc42783          	lw	a5,-52(s0)
 9f2:	85ba                	mv	a1,a4
 9f4:	853e                	mv	a0,a5
 9f6:	00000097          	auipc	ra,0x0
 9fa:	c5a080e7          	jalr	-934(ra) # 650 <putc>
 9fe:	a899                	j	a54 <vprintf+0x23a>
      } else if(c == '%'){
 a00:	fdc42783          	lw	a5,-36(s0)
 a04:	0007871b          	sext.w	a4,a5
 a08:	02500793          	li	a5,37
 a0c:	00f71f63          	bne	a4,a5,a2a <vprintf+0x210>
        putc(fd, c);
 a10:	fdc42783          	lw	a5,-36(s0)
 a14:	0ff7f713          	zext.b	a4,a5
 a18:	fcc42783          	lw	a5,-52(s0)
 a1c:	85ba                	mv	a1,a4
 a1e:	853e                	mv	a0,a5
 a20:	00000097          	auipc	ra,0x0
 a24:	c30080e7          	jalr	-976(ra) # 650 <putc>
 a28:	a035                	j	a54 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a2a:	fcc42783          	lw	a5,-52(s0)
 a2e:	02500593          	li	a1,37
 a32:	853e                	mv	a0,a5
 a34:	00000097          	auipc	ra,0x0
 a38:	c1c080e7          	jalr	-996(ra) # 650 <putc>
        putc(fd, c);
 a3c:	fdc42783          	lw	a5,-36(s0)
 a40:	0ff7f713          	zext.b	a4,a5
 a44:	fcc42783          	lw	a5,-52(s0)
 a48:	85ba                	mv	a1,a4
 a4a:	853e                	mv	a0,a5
 a4c:	00000097          	auipc	ra,0x0
 a50:	c04080e7          	jalr	-1020(ra) # 650 <putc>
      }
      state = 0;
 a54:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 a58:	fe442783          	lw	a5,-28(s0)
 a5c:	2785                	addiw	a5,a5,1
 a5e:	fef42223          	sw	a5,-28(s0)
 a62:	fe442783          	lw	a5,-28(s0)
 a66:	fc043703          	ld	a4,-64(s0)
 a6a:	97ba                	add	a5,a5,a4
 a6c:	0007c783          	lbu	a5,0(a5)
 a70:	dc0795e3          	bnez	a5,83a <vprintf+0x20>
    }
  }
}
 a74:	0001                	nop
 a76:	0001                	nop
 a78:	60a6                	ld	ra,72(sp)
 a7a:	6406                	ld	s0,64(sp)
 a7c:	6161                	addi	sp,sp,80
 a7e:	8082                	ret

0000000000000a80 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a80:	7159                	addi	sp,sp,-112
 a82:	fc06                	sd	ra,56(sp)
 a84:	f822                	sd	s0,48(sp)
 a86:	0080                	addi	s0,sp,64
 a88:	fcb43823          	sd	a1,-48(s0)
 a8c:	e010                	sd	a2,0(s0)
 a8e:	e414                	sd	a3,8(s0)
 a90:	e818                	sd	a4,16(s0)
 a92:	ec1c                	sd	a5,24(s0)
 a94:	03043023          	sd	a6,32(s0)
 a98:	03143423          	sd	a7,40(s0)
 a9c:	87aa                	mv	a5,a0
 a9e:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 aa2:	03040793          	addi	a5,s0,48
 aa6:	fcf43423          	sd	a5,-56(s0)
 aaa:	fc843783          	ld	a5,-56(s0)
 aae:	fd078793          	addi	a5,a5,-48
 ab2:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 ab6:	fe843703          	ld	a4,-24(s0)
 aba:	fdc42783          	lw	a5,-36(s0)
 abe:	863a                	mv	a2,a4
 ac0:	fd043583          	ld	a1,-48(s0)
 ac4:	853e                	mv	a0,a5
 ac6:	00000097          	auipc	ra,0x0
 aca:	d54080e7          	jalr	-684(ra) # 81a <vprintf>
}
 ace:	0001                	nop
 ad0:	70e2                	ld	ra,56(sp)
 ad2:	7442                	ld	s0,48(sp)
 ad4:	6165                	addi	sp,sp,112
 ad6:	8082                	ret

0000000000000ad8 <printf>:

void
printf(const char *fmt, ...)
{
 ad8:	7159                	addi	sp,sp,-112
 ada:	f406                	sd	ra,40(sp)
 adc:	f022                	sd	s0,32(sp)
 ade:	1800                	addi	s0,sp,48
 ae0:	fca43c23          	sd	a0,-40(s0)
 ae4:	e40c                	sd	a1,8(s0)
 ae6:	e810                	sd	a2,16(s0)
 ae8:	ec14                	sd	a3,24(s0)
 aea:	f018                	sd	a4,32(s0)
 aec:	f41c                	sd	a5,40(s0)
 aee:	03043823          	sd	a6,48(s0)
 af2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 af6:	04040793          	addi	a5,s0,64
 afa:	fcf43823          	sd	a5,-48(s0)
 afe:	fd043783          	ld	a5,-48(s0)
 b02:	fc878793          	addi	a5,a5,-56
 b06:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 b0a:	fe843783          	ld	a5,-24(s0)
 b0e:	863e                	mv	a2,a5
 b10:	fd843583          	ld	a1,-40(s0)
 b14:	4505                	li	a0,1
 b16:	00000097          	auipc	ra,0x0
 b1a:	d04080e7          	jalr	-764(ra) # 81a <vprintf>
}
 b1e:	0001                	nop
 b20:	70a2                	ld	ra,40(sp)
 b22:	7402                	ld	s0,32(sp)
 b24:	6165                	addi	sp,sp,112
 b26:	8082                	ret

0000000000000b28 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b28:	7179                	addi	sp,sp,-48
 b2a:	f422                	sd	s0,40(sp)
 b2c:	1800                	addi	s0,sp,48
 b2e:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b32:	fd843783          	ld	a5,-40(s0)
 b36:	17c1                	addi	a5,a5,-16
 b38:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b3c:	00000797          	auipc	a5,0x0
 b40:	34c78793          	addi	a5,a5,844 # e88 <freep>
 b44:	639c                	ld	a5,0(a5)
 b46:	fef43423          	sd	a5,-24(s0)
 b4a:	a815                	j	b7e <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b4c:	fe843783          	ld	a5,-24(s0)
 b50:	639c                	ld	a5,0(a5)
 b52:	fe843703          	ld	a4,-24(s0)
 b56:	00f76f63          	bltu	a4,a5,b74 <free+0x4c>
 b5a:	fe043703          	ld	a4,-32(s0)
 b5e:	fe843783          	ld	a5,-24(s0)
 b62:	02e7eb63          	bltu	a5,a4,b98 <free+0x70>
 b66:	fe843783          	ld	a5,-24(s0)
 b6a:	639c                	ld	a5,0(a5)
 b6c:	fe043703          	ld	a4,-32(s0)
 b70:	02f76463          	bltu	a4,a5,b98 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b74:	fe843783          	ld	a5,-24(s0)
 b78:	639c                	ld	a5,0(a5)
 b7a:	fef43423          	sd	a5,-24(s0)
 b7e:	fe043703          	ld	a4,-32(s0)
 b82:	fe843783          	ld	a5,-24(s0)
 b86:	fce7f3e3          	bgeu	a5,a4,b4c <free+0x24>
 b8a:	fe843783          	ld	a5,-24(s0)
 b8e:	639c                	ld	a5,0(a5)
 b90:	fe043703          	ld	a4,-32(s0)
 b94:	faf77ce3          	bgeu	a4,a5,b4c <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b98:	fe043783          	ld	a5,-32(s0)
 b9c:	479c                	lw	a5,8(a5)
 b9e:	1782                	slli	a5,a5,0x20
 ba0:	9381                	srli	a5,a5,0x20
 ba2:	0792                	slli	a5,a5,0x4
 ba4:	fe043703          	ld	a4,-32(s0)
 ba8:	973e                	add	a4,a4,a5
 baa:	fe843783          	ld	a5,-24(s0)
 bae:	639c                	ld	a5,0(a5)
 bb0:	02f71763          	bne	a4,a5,bde <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 bb4:	fe043783          	ld	a5,-32(s0)
 bb8:	4798                	lw	a4,8(a5)
 bba:	fe843783          	ld	a5,-24(s0)
 bbe:	639c                	ld	a5,0(a5)
 bc0:	479c                	lw	a5,8(a5)
 bc2:	9fb9                	addw	a5,a5,a4
 bc4:	0007871b          	sext.w	a4,a5
 bc8:	fe043783          	ld	a5,-32(s0)
 bcc:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 bce:	fe843783          	ld	a5,-24(s0)
 bd2:	639c                	ld	a5,0(a5)
 bd4:	6398                	ld	a4,0(a5)
 bd6:	fe043783          	ld	a5,-32(s0)
 bda:	e398                	sd	a4,0(a5)
 bdc:	a039                	j	bea <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 bde:	fe843783          	ld	a5,-24(s0)
 be2:	6398                	ld	a4,0(a5)
 be4:	fe043783          	ld	a5,-32(s0)
 be8:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 bea:	fe843783          	ld	a5,-24(s0)
 bee:	479c                	lw	a5,8(a5)
 bf0:	1782                	slli	a5,a5,0x20
 bf2:	9381                	srli	a5,a5,0x20
 bf4:	0792                	slli	a5,a5,0x4
 bf6:	fe843703          	ld	a4,-24(s0)
 bfa:	97ba                	add	a5,a5,a4
 bfc:	fe043703          	ld	a4,-32(s0)
 c00:	02f71563          	bne	a4,a5,c2a <free+0x102>
    p->s.size += bp->s.size;
 c04:	fe843783          	ld	a5,-24(s0)
 c08:	4798                	lw	a4,8(a5)
 c0a:	fe043783          	ld	a5,-32(s0)
 c0e:	479c                	lw	a5,8(a5)
 c10:	9fb9                	addw	a5,a5,a4
 c12:	0007871b          	sext.w	a4,a5
 c16:	fe843783          	ld	a5,-24(s0)
 c1a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c1c:	fe043783          	ld	a5,-32(s0)
 c20:	6398                	ld	a4,0(a5)
 c22:	fe843783          	ld	a5,-24(s0)
 c26:	e398                	sd	a4,0(a5)
 c28:	a031                	j	c34 <free+0x10c>
  } else
    p->s.ptr = bp;
 c2a:	fe843783          	ld	a5,-24(s0)
 c2e:	fe043703          	ld	a4,-32(s0)
 c32:	e398                	sd	a4,0(a5)
  freep = p;
 c34:	00000797          	auipc	a5,0x0
 c38:	25478793          	addi	a5,a5,596 # e88 <freep>
 c3c:	fe843703          	ld	a4,-24(s0)
 c40:	e398                	sd	a4,0(a5)
}
 c42:	0001                	nop
 c44:	7422                	ld	s0,40(sp)
 c46:	6145                	addi	sp,sp,48
 c48:	8082                	ret

0000000000000c4a <morecore>:

static Header*
morecore(uint nu)
{
 c4a:	7179                	addi	sp,sp,-48
 c4c:	f406                	sd	ra,40(sp)
 c4e:	f022                	sd	s0,32(sp)
 c50:	1800                	addi	s0,sp,48
 c52:	87aa                	mv	a5,a0
 c54:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 c58:	fdc42783          	lw	a5,-36(s0)
 c5c:	0007871b          	sext.w	a4,a5
 c60:	6785                	lui	a5,0x1
 c62:	00f77563          	bgeu	a4,a5,c6c <morecore+0x22>
    nu = 4096;
 c66:	6785                	lui	a5,0x1
 c68:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c6c:	fdc42783          	lw	a5,-36(s0)
 c70:	0047979b          	slliw	a5,a5,0x4
 c74:	2781                	sext.w	a5,a5
 c76:	2781                	sext.w	a5,a5
 c78:	853e                	mv	a0,a5
 c7a:	00000097          	auipc	ra,0x0
 c7e:	9ae080e7          	jalr	-1618(ra) # 628 <sbrk>
 c82:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c86:	fe843703          	ld	a4,-24(s0)
 c8a:	57fd                	li	a5,-1
 c8c:	00f71463          	bne	a4,a5,c94 <morecore+0x4a>
    return 0;
 c90:	4781                	li	a5,0
 c92:	a03d                	j	cc0 <morecore+0x76>
  hp = (Header*)p;
 c94:	fe843783          	ld	a5,-24(s0)
 c98:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c9c:	fe043783          	ld	a5,-32(s0)
 ca0:	fdc42703          	lw	a4,-36(s0)
 ca4:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 ca6:	fe043783          	ld	a5,-32(s0)
 caa:	07c1                	addi	a5,a5,16
 cac:	853e                	mv	a0,a5
 cae:	00000097          	auipc	ra,0x0
 cb2:	e7a080e7          	jalr	-390(ra) # b28 <free>
  return freep;
 cb6:	00000797          	auipc	a5,0x0
 cba:	1d278793          	addi	a5,a5,466 # e88 <freep>
 cbe:	639c                	ld	a5,0(a5)
}
 cc0:	853e                	mv	a0,a5
 cc2:	70a2                	ld	ra,40(sp)
 cc4:	7402                	ld	s0,32(sp)
 cc6:	6145                	addi	sp,sp,48
 cc8:	8082                	ret

0000000000000cca <malloc>:

void*
malloc(uint nbytes)
{
 cca:	7139                	addi	sp,sp,-64
 ccc:	fc06                	sd	ra,56(sp)
 cce:	f822                	sd	s0,48(sp)
 cd0:	0080                	addi	s0,sp,64
 cd2:	87aa                	mv	a5,a0
 cd4:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 cd8:	fcc46783          	lwu	a5,-52(s0)
 cdc:	07bd                	addi	a5,a5,15
 cde:	8391                	srli	a5,a5,0x4
 ce0:	2781                	sext.w	a5,a5
 ce2:	2785                	addiw	a5,a5,1
 ce4:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 ce8:	00000797          	auipc	a5,0x0
 cec:	1a078793          	addi	a5,a5,416 # e88 <freep>
 cf0:	639c                	ld	a5,0(a5)
 cf2:	fef43023          	sd	a5,-32(s0)
 cf6:	fe043783          	ld	a5,-32(s0)
 cfa:	ef95                	bnez	a5,d36 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 cfc:	00000797          	auipc	a5,0x0
 d00:	17c78793          	addi	a5,a5,380 # e78 <base>
 d04:	fef43023          	sd	a5,-32(s0)
 d08:	00000797          	auipc	a5,0x0
 d0c:	18078793          	addi	a5,a5,384 # e88 <freep>
 d10:	fe043703          	ld	a4,-32(s0)
 d14:	e398                	sd	a4,0(a5)
 d16:	00000797          	auipc	a5,0x0
 d1a:	17278793          	addi	a5,a5,370 # e88 <freep>
 d1e:	6398                	ld	a4,0(a5)
 d20:	00000797          	auipc	a5,0x0
 d24:	15878793          	addi	a5,a5,344 # e78 <base>
 d28:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 d2a:	00000797          	auipc	a5,0x0
 d2e:	14e78793          	addi	a5,a5,334 # e78 <base>
 d32:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d36:	fe043783          	ld	a5,-32(s0)
 d3a:	639c                	ld	a5,0(a5)
 d3c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d40:	fe843783          	ld	a5,-24(s0)
 d44:	4798                	lw	a4,8(a5)
 d46:	fdc42783          	lw	a5,-36(s0)
 d4a:	2781                	sext.w	a5,a5
 d4c:	06f76763          	bltu	a4,a5,dba <malloc+0xf0>
      if(p->s.size == nunits)
 d50:	fe843783          	ld	a5,-24(s0)
 d54:	4798                	lw	a4,8(a5)
 d56:	fdc42783          	lw	a5,-36(s0)
 d5a:	2781                	sext.w	a5,a5
 d5c:	00e79963          	bne	a5,a4,d6e <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d60:	fe843783          	ld	a5,-24(s0)
 d64:	6398                	ld	a4,0(a5)
 d66:	fe043783          	ld	a5,-32(s0)
 d6a:	e398                	sd	a4,0(a5)
 d6c:	a825                	j	da4 <malloc+0xda>
      else {
        p->s.size -= nunits;
 d6e:	fe843783          	ld	a5,-24(s0)
 d72:	479c                	lw	a5,8(a5)
 d74:	fdc42703          	lw	a4,-36(s0)
 d78:	9f99                	subw	a5,a5,a4
 d7a:	0007871b          	sext.w	a4,a5
 d7e:	fe843783          	ld	a5,-24(s0)
 d82:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d84:	fe843783          	ld	a5,-24(s0)
 d88:	479c                	lw	a5,8(a5)
 d8a:	1782                	slli	a5,a5,0x20
 d8c:	9381                	srli	a5,a5,0x20
 d8e:	0792                	slli	a5,a5,0x4
 d90:	fe843703          	ld	a4,-24(s0)
 d94:	97ba                	add	a5,a5,a4
 d96:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d9a:	fe843783          	ld	a5,-24(s0)
 d9e:	fdc42703          	lw	a4,-36(s0)
 da2:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 da4:	00000797          	auipc	a5,0x0
 da8:	0e478793          	addi	a5,a5,228 # e88 <freep>
 dac:	fe043703          	ld	a4,-32(s0)
 db0:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 db2:	fe843783          	ld	a5,-24(s0)
 db6:	07c1                	addi	a5,a5,16
 db8:	a091                	j	dfc <malloc+0x132>
    }
    if(p == freep)
 dba:	00000797          	auipc	a5,0x0
 dbe:	0ce78793          	addi	a5,a5,206 # e88 <freep>
 dc2:	639c                	ld	a5,0(a5)
 dc4:	fe843703          	ld	a4,-24(s0)
 dc8:	02f71063          	bne	a4,a5,de8 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 dcc:	fdc42783          	lw	a5,-36(s0)
 dd0:	853e                	mv	a0,a5
 dd2:	00000097          	auipc	ra,0x0
 dd6:	e78080e7          	jalr	-392(ra) # c4a <morecore>
 dda:	fea43423          	sd	a0,-24(s0)
 dde:	fe843783          	ld	a5,-24(s0)
 de2:	e399                	bnez	a5,de8 <malloc+0x11e>
        return 0;
 de4:	4781                	li	a5,0
 de6:	a819                	j	dfc <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 de8:	fe843783          	ld	a5,-24(s0)
 dec:	fef43023          	sd	a5,-32(s0)
 df0:	fe843783          	ld	a5,-24(s0)
 df4:	639c                	ld	a5,0(a5)
 df6:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 dfa:	b799                	j	d40 <malloc+0x76>
  }
}
 dfc:	853e                	mv	a0,a5
 dfe:	70e2                	ld	ra,56(sp)
 e00:	7442                	ld	s0,48(sp)
 e02:	6121                	addi	sp,sp,64
 e04:	8082                	ret
