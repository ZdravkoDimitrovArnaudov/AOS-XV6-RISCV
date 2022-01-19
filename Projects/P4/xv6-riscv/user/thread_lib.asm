
user/_thread_lib:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <thread_create>:
typedef uint cont_t;

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
  16:	d70080e7          	jalr	-656(ra) # d82 <malloc>
  1a:	fea43423          	sd	a0,-24(s0)
  1e:	fe843783          	ld	a5,-24(s0)
  22:	e38d                	bnez	a5,44 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
  24:	00001517          	auipc	a0,0x1
  28:	e9c50513          	addi	a0,a0,-356 # ec0 <malloc+0x13e>
  2c:	00001097          	auipc	ra,0x1
  30:	b64080e7          	jalr	-1180(ra) # b90 <printf>
        free(stack);
  34:	fe843503          	ld	a0,-24(s0)
  38:	00001097          	auipc	ra,0x1
  3c:	ba8080e7          	jalr	-1112(ra) # be0 <free>
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
  82:	67a080e7          	jalr	1658(ra) # 6f8 <clone>
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
  a4:	660080e7          	jalr	1632(ra) # 700 <join>
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
  c6:	b1e080e7          	jalr	-1250(ra) # be0 <free>
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


void lock_acquire (lock_t *lock){
  d8:	1101                	addi	sp,sp,-32
  da:	ec22                	sd	s0,24(sp)
  dc:	1000                	addi	s0,sp,32
  de:	fea43423          	sd	a0,-24(s0)
    while( __sync_lock_test_and_set(lock, 1)!=0){
  e2:	0001                	nop
  e4:	fe843783          	ld	a5,-24(s0)
  e8:	4705                	li	a4,1
  ea:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
  ee:	0007079b          	sext.w	a5,a4
  f2:	fbed                	bnez	a5,e4 <lock_acquire+0xc>

    ;
    }
     __sync_synchronize();
  f4:	0ff0000f          	fence
        

}
  f8:	0001                	nop
  fa:	6462                	ld	s0,24(sp)
  fc:	6105                	addi	sp,sp,32
  fe:	8082                	ret

0000000000000100 <lock_release>:

void lock_release (lock_t *lock){
 100:	1101                	addi	sp,sp,-32
 102:	ec22                	sd	s0,24(sp)
 104:	1000                	addi	s0,sp,32
 106:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
 10a:	0ff0000f          	fence
    __sync_lock_release(lock);
 10e:	fe843783          	ld	a5,-24(s0)
 112:	0f50000f          	fence	iorw,ow
 116:	0807a02f          	amoswap.w	zero,zero,(a5)
   
}
 11a:	0001                	nop
 11c:	6462                	ld	s0,24(sp)
 11e:	6105                	addi	sp,sp,32
 120:	8082                	ret

0000000000000122 <lock_init>:

void lock_init (lock_t *lock){
 122:	1101                	addi	sp,sp,-32
 124:	ec22                	sd	s0,24(sp)
 126:	1000                	addi	s0,sp,32
 128:	fea43423          	sd	a0,-24(s0)
    lock = 0;
 12c:	fe043423          	sd	zero,-24(s0)
    
}
 130:	0001                	nop
 132:	6462                	ld	s0,24(sp)
 134:	6105                	addi	sp,sp,32
 136:	8082                	ret

0000000000000138 <cv_wait>:


void cv_wait (cont_t *cv, lock_t *lock){
 138:	1101                	addi	sp,sp,-32
 13a:	ec06                	sd	ra,24(sp)
 13c:	e822                	sd	s0,16(sp)
 13e:	1000                	addi	s0,sp,32
 140:	fea43423          	sd	a0,-24(s0)
 144:	feb43023          	sd	a1,-32(s0)
    while( __sync_lock_test_and_set(cv, 0)!=1){
 148:	a015                	j	16c <cv_wait+0x34>
        lock_release(lock);
 14a:	fe043503          	ld	a0,-32(s0)
 14e:	00000097          	auipc	ra,0x0
 152:	fb2080e7          	jalr	-78(ra) # 100 <lock_release>
        sleep(1);
 156:	4505                	li	a0,1
 158:	00000097          	auipc	ra,0x0
 15c:	590080e7          	jalr	1424(ra) # 6e8 <sleep>
        lock_acquire(lock);
 160:	fe043503          	ld	a0,-32(s0)
 164:	00000097          	auipc	ra,0x0
 168:	f74080e7          	jalr	-140(ra) # d8 <lock_acquire>
    while( __sync_lock_test_and_set(cv, 0)!=1){
 16c:	fe843783          	ld	a5,-24(s0)
 170:	4701                	li	a4,0
 172:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
 176:	0007079b          	sext.w	a5,a4
 17a:	873e                	mv	a4,a5
 17c:	4785                	li	a5,1
 17e:	fcf716e3          	bne	a4,a5,14a <cv_wait+0x12>
    }

     __sync_synchronize();
 182:	0ff0000f          	fence

}
 186:	0001                	nop
 188:	60e2                	ld	ra,24(sp)
 18a:	6442                	ld	s0,16(sp)
 18c:	6105                	addi	sp,sp,32
 18e:	8082                	ret

0000000000000190 <cv_signal>:


void cv_signal (cont_t *cv){
 190:	1101                	addi	sp,sp,-32
 192:	ec22                	sd	s0,24(sp)
 194:	1000                	addi	s0,sp,32
 196:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
 19a:	0ff0000f          	fence
     __sync_lock_test_and_set(cv, 1);
 19e:	fe843783          	ld	a5,-24(s0)
 1a2:	4705                	li	a4,1
 1a4:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)

}
 1a8:	0001                	nop
 1aa:	6462                	ld	s0,24(sp)
 1ac:	6105                	addi	sp,sp,32
 1ae:	8082                	ret

00000000000001b0 <cv_init>:


void cv_init (cont_t *cv){
 1b0:	1101                	addi	sp,sp,-32
 1b2:	ec22                	sd	s0,24(sp)
 1b4:	1000                	addi	s0,sp,32
 1b6:	fea43423          	sd	a0,-24(s0)
    cv = 0;
 1ba:	fe043423          	sd	zero,-24(s0)
 1be:	0001                	nop
 1c0:	6462                	ld	s0,24(sp)
 1c2:	6105                	addi	sp,sp,32
 1c4:	8082                	ret

00000000000001c6 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1c6:	7179                	addi	sp,sp,-48
 1c8:	f422                	sd	s0,40(sp)
 1ca:	1800                	addi	s0,sp,48
 1cc:	fca43c23          	sd	a0,-40(s0)
 1d0:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 1d4:	fd843783          	ld	a5,-40(s0)
 1d8:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 1dc:	0001                	nop
 1de:	fd043703          	ld	a4,-48(s0)
 1e2:	00170793          	addi	a5,a4,1 # 1001 <__BSS_END__+0xb9>
 1e6:	fcf43823          	sd	a5,-48(s0)
 1ea:	fd843783          	ld	a5,-40(s0)
 1ee:	00178693          	addi	a3,a5,1 # 1001 <__BSS_END__+0xb9>
 1f2:	fcd43c23          	sd	a3,-40(s0)
 1f6:	00074703          	lbu	a4,0(a4)
 1fa:	00e78023          	sb	a4,0(a5)
 1fe:	0007c783          	lbu	a5,0(a5)
 202:	fff1                	bnez	a5,1de <strcpy+0x18>
    ;
  return os;
 204:	fe843783          	ld	a5,-24(s0)
}
 208:	853e                	mv	a0,a5
 20a:	7422                	ld	s0,40(sp)
 20c:	6145                	addi	sp,sp,48
 20e:	8082                	ret

0000000000000210 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 210:	1101                	addi	sp,sp,-32
 212:	ec22                	sd	s0,24(sp)
 214:	1000                	addi	s0,sp,32
 216:	fea43423          	sd	a0,-24(s0)
 21a:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 21e:	a819                	j	234 <strcmp+0x24>
    p++, q++;
 220:	fe843783          	ld	a5,-24(s0)
 224:	0785                	addi	a5,a5,1
 226:	fef43423          	sd	a5,-24(s0)
 22a:	fe043783          	ld	a5,-32(s0)
 22e:	0785                	addi	a5,a5,1
 230:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 234:	fe843783          	ld	a5,-24(s0)
 238:	0007c783          	lbu	a5,0(a5)
 23c:	cb99                	beqz	a5,252 <strcmp+0x42>
 23e:	fe843783          	ld	a5,-24(s0)
 242:	0007c703          	lbu	a4,0(a5)
 246:	fe043783          	ld	a5,-32(s0)
 24a:	0007c783          	lbu	a5,0(a5)
 24e:	fcf709e3          	beq	a4,a5,220 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 252:	fe843783          	ld	a5,-24(s0)
 256:	0007c783          	lbu	a5,0(a5)
 25a:	0007871b          	sext.w	a4,a5
 25e:	fe043783          	ld	a5,-32(s0)
 262:	0007c783          	lbu	a5,0(a5)
 266:	2781                	sext.w	a5,a5
 268:	40f707bb          	subw	a5,a4,a5
 26c:	2781                	sext.w	a5,a5
}
 26e:	853e                	mv	a0,a5
 270:	6462                	ld	s0,24(sp)
 272:	6105                	addi	sp,sp,32
 274:	8082                	ret

0000000000000276 <strlen>:

uint
strlen(const char *s)
{
 276:	7179                	addi	sp,sp,-48
 278:	f422                	sd	s0,40(sp)
 27a:	1800                	addi	s0,sp,48
 27c:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 280:	fe042623          	sw	zero,-20(s0)
 284:	a031                	j	290 <strlen+0x1a>
 286:	fec42783          	lw	a5,-20(s0)
 28a:	2785                	addiw	a5,a5,1
 28c:	fef42623          	sw	a5,-20(s0)
 290:	fec42783          	lw	a5,-20(s0)
 294:	fd843703          	ld	a4,-40(s0)
 298:	97ba                	add	a5,a5,a4
 29a:	0007c783          	lbu	a5,0(a5)
 29e:	f7e5                	bnez	a5,286 <strlen+0x10>
    ;
  return n;
 2a0:	fec42783          	lw	a5,-20(s0)
}
 2a4:	853e                	mv	a0,a5
 2a6:	7422                	ld	s0,40(sp)
 2a8:	6145                	addi	sp,sp,48
 2aa:	8082                	ret

00000000000002ac <memset>:

void*
memset(void *dst, int c, uint n)
{
 2ac:	7179                	addi	sp,sp,-48
 2ae:	f422                	sd	s0,40(sp)
 2b0:	1800                	addi	s0,sp,48
 2b2:	fca43c23          	sd	a0,-40(s0)
 2b6:	87ae                	mv	a5,a1
 2b8:	8732                	mv	a4,a2
 2ba:	fcf42a23          	sw	a5,-44(s0)
 2be:	87ba                	mv	a5,a4
 2c0:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 2c4:	fd843783          	ld	a5,-40(s0)
 2c8:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 2cc:	fe042623          	sw	zero,-20(s0)
 2d0:	a00d                	j	2f2 <memset+0x46>
    cdst[i] = c;
 2d2:	fec42783          	lw	a5,-20(s0)
 2d6:	fe043703          	ld	a4,-32(s0)
 2da:	97ba                	add	a5,a5,a4
 2dc:	fd442703          	lw	a4,-44(s0)
 2e0:	0ff77713          	zext.b	a4,a4
 2e4:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 2e8:	fec42783          	lw	a5,-20(s0)
 2ec:	2785                	addiw	a5,a5,1
 2ee:	fef42623          	sw	a5,-20(s0)
 2f2:	fec42703          	lw	a4,-20(s0)
 2f6:	fd042783          	lw	a5,-48(s0)
 2fa:	2781                	sext.w	a5,a5
 2fc:	fcf76be3          	bltu	a4,a5,2d2 <memset+0x26>
  }
  return dst;
 300:	fd843783          	ld	a5,-40(s0)
}
 304:	853e                	mv	a0,a5
 306:	7422                	ld	s0,40(sp)
 308:	6145                	addi	sp,sp,48
 30a:	8082                	ret

000000000000030c <strchr>:

char*
strchr(const char *s, char c)
{
 30c:	1101                	addi	sp,sp,-32
 30e:	ec22                	sd	s0,24(sp)
 310:	1000                	addi	s0,sp,32
 312:	fea43423          	sd	a0,-24(s0)
 316:	87ae                	mv	a5,a1
 318:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 31c:	a01d                	j	342 <strchr+0x36>
    if(*s == c)
 31e:	fe843783          	ld	a5,-24(s0)
 322:	0007c703          	lbu	a4,0(a5)
 326:	fe744783          	lbu	a5,-25(s0)
 32a:	0ff7f793          	zext.b	a5,a5
 32e:	00e79563          	bne	a5,a4,338 <strchr+0x2c>
      return (char*)s;
 332:	fe843783          	ld	a5,-24(s0)
 336:	a821                	j	34e <strchr+0x42>
  for(; *s; s++)
 338:	fe843783          	ld	a5,-24(s0)
 33c:	0785                	addi	a5,a5,1
 33e:	fef43423          	sd	a5,-24(s0)
 342:	fe843783          	ld	a5,-24(s0)
 346:	0007c783          	lbu	a5,0(a5)
 34a:	fbf1                	bnez	a5,31e <strchr+0x12>
  return 0;
 34c:	4781                	li	a5,0
}
 34e:	853e                	mv	a0,a5
 350:	6462                	ld	s0,24(sp)
 352:	6105                	addi	sp,sp,32
 354:	8082                	ret

0000000000000356 <gets>:

char*
gets(char *buf, int max)
{
 356:	7179                	addi	sp,sp,-48
 358:	f406                	sd	ra,40(sp)
 35a:	f022                	sd	s0,32(sp)
 35c:	1800                	addi	s0,sp,48
 35e:	fca43c23          	sd	a0,-40(s0)
 362:	87ae                	mv	a5,a1
 364:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 368:	fe042623          	sw	zero,-20(s0)
 36c:	a8a1                	j	3c4 <gets+0x6e>
    cc = read(0, &c, 1);
 36e:	fe740793          	addi	a5,s0,-25
 372:	4605                	li	a2,1
 374:	85be                	mv	a1,a5
 376:	4501                	li	a0,0
 378:	00000097          	auipc	ra,0x0
 37c:	2f8080e7          	jalr	760(ra) # 670 <read>
 380:	87aa                	mv	a5,a0
 382:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 386:	fe842783          	lw	a5,-24(s0)
 38a:	2781                	sext.w	a5,a5
 38c:	04f05763          	blez	a5,3da <gets+0x84>
      break;
    buf[i++] = c;
 390:	fec42783          	lw	a5,-20(s0)
 394:	0017871b          	addiw	a4,a5,1
 398:	fee42623          	sw	a4,-20(s0)
 39c:	873e                	mv	a4,a5
 39e:	fd843783          	ld	a5,-40(s0)
 3a2:	97ba                	add	a5,a5,a4
 3a4:	fe744703          	lbu	a4,-25(s0)
 3a8:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 3ac:	fe744783          	lbu	a5,-25(s0)
 3b0:	873e                	mv	a4,a5
 3b2:	47a9                	li	a5,10
 3b4:	02f70463          	beq	a4,a5,3dc <gets+0x86>
 3b8:	fe744783          	lbu	a5,-25(s0)
 3bc:	873e                	mv	a4,a5
 3be:	47b5                	li	a5,13
 3c0:	00f70e63          	beq	a4,a5,3dc <gets+0x86>
  for(i=0; i+1 < max; ){
 3c4:	fec42783          	lw	a5,-20(s0)
 3c8:	2785                	addiw	a5,a5,1
 3ca:	0007871b          	sext.w	a4,a5
 3ce:	fd442783          	lw	a5,-44(s0)
 3d2:	2781                	sext.w	a5,a5
 3d4:	f8f74de3          	blt	a4,a5,36e <gets+0x18>
 3d8:	a011                	j	3dc <gets+0x86>
      break;
 3da:	0001                	nop
      break;
  }
  buf[i] = '\0';
 3dc:	fec42783          	lw	a5,-20(s0)
 3e0:	fd843703          	ld	a4,-40(s0)
 3e4:	97ba                	add	a5,a5,a4
 3e6:	00078023          	sb	zero,0(a5)
  return buf;
 3ea:	fd843783          	ld	a5,-40(s0)
}
 3ee:	853e                	mv	a0,a5
 3f0:	70a2                	ld	ra,40(sp)
 3f2:	7402                	ld	s0,32(sp)
 3f4:	6145                	addi	sp,sp,48
 3f6:	8082                	ret

00000000000003f8 <stat>:

int
stat(const char *n, struct stat *st)
{
 3f8:	7179                	addi	sp,sp,-48
 3fa:	f406                	sd	ra,40(sp)
 3fc:	f022                	sd	s0,32(sp)
 3fe:	1800                	addi	s0,sp,48
 400:	fca43c23          	sd	a0,-40(s0)
 404:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 408:	4581                	li	a1,0
 40a:	fd843503          	ld	a0,-40(s0)
 40e:	00000097          	auipc	ra,0x0
 412:	28a080e7          	jalr	650(ra) # 698 <open>
 416:	87aa                	mv	a5,a0
 418:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 41c:	fec42783          	lw	a5,-20(s0)
 420:	2781                	sext.w	a5,a5
 422:	0007d463          	bgez	a5,42a <stat+0x32>
    return -1;
 426:	57fd                	li	a5,-1
 428:	a035                	j	454 <stat+0x5c>
  r = fstat(fd, st);
 42a:	fec42783          	lw	a5,-20(s0)
 42e:	fd043583          	ld	a1,-48(s0)
 432:	853e                	mv	a0,a5
 434:	00000097          	auipc	ra,0x0
 438:	27c080e7          	jalr	636(ra) # 6b0 <fstat>
 43c:	87aa                	mv	a5,a0
 43e:	fef42423          	sw	a5,-24(s0)
  close(fd);
 442:	fec42783          	lw	a5,-20(s0)
 446:	853e                	mv	a0,a5
 448:	00000097          	auipc	ra,0x0
 44c:	238080e7          	jalr	568(ra) # 680 <close>
  return r;
 450:	fe842783          	lw	a5,-24(s0)
}
 454:	853e                	mv	a0,a5
 456:	70a2                	ld	ra,40(sp)
 458:	7402                	ld	s0,32(sp)
 45a:	6145                	addi	sp,sp,48
 45c:	8082                	ret

000000000000045e <atoi>:

int
atoi(const char *s)
{
 45e:	7179                	addi	sp,sp,-48
 460:	f422                	sd	s0,40(sp)
 462:	1800                	addi	s0,sp,48
 464:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 468:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 46c:	a81d                	j	4a2 <atoi+0x44>
    n = n*10 + *s++ - '0';
 46e:	fec42783          	lw	a5,-20(s0)
 472:	873e                	mv	a4,a5
 474:	87ba                	mv	a5,a4
 476:	0027979b          	slliw	a5,a5,0x2
 47a:	9fb9                	addw	a5,a5,a4
 47c:	0017979b          	slliw	a5,a5,0x1
 480:	0007871b          	sext.w	a4,a5
 484:	fd843783          	ld	a5,-40(s0)
 488:	00178693          	addi	a3,a5,1
 48c:	fcd43c23          	sd	a3,-40(s0)
 490:	0007c783          	lbu	a5,0(a5)
 494:	2781                	sext.w	a5,a5
 496:	9fb9                	addw	a5,a5,a4
 498:	2781                	sext.w	a5,a5
 49a:	fd07879b          	addiw	a5,a5,-48
 49e:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 4a2:	fd843783          	ld	a5,-40(s0)
 4a6:	0007c783          	lbu	a5,0(a5)
 4aa:	873e                	mv	a4,a5
 4ac:	02f00793          	li	a5,47
 4b0:	00e7fb63          	bgeu	a5,a4,4c6 <atoi+0x68>
 4b4:	fd843783          	ld	a5,-40(s0)
 4b8:	0007c783          	lbu	a5,0(a5)
 4bc:	873e                	mv	a4,a5
 4be:	03900793          	li	a5,57
 4c2:	fae7f6e3          	bgeu	a5,a4,46e <atoi+0x10>
  return n;
 4c6:	fec42783          	lw	a5,-20(s0)
}
 4ca:	853e                	mv	a0,a5
 4cc:	7422                	ld	s0,40(sp)
 4ce:	6145                	addi	sp,sp,48
 4d0:	8082                	ret

00000000000004d2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4d2:	7139                	addi	sp,sp,-64
 4d4:	fc22                	sd	s0,56(sp)
 4d6:	0080                	addi	s0,sp,64
 4d8:	fca43c23          	sd	a0,-40(s0)
 4dc:	fcb43823          	sd	a1,-48(s0)
 4e0:	87b2                	mv	a5,a2
 4e2:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 4e6:	fd843783          	ld	a5,-40(s0)
 4ea:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 4ee:	fd043783          	ld	a5,-48(s0)
 4f2:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 4f6:	fe043703          	ld	a4,-32(s0)
 4fa:	fe843783          	ld	a5,-24(s0)
 4fe:	02e7fc63          	bgeu	a5,a4,536 <memmove+0x64>
    while(n-- > 0)
 502:	a00d                	j	524 <memmove+0x52>
      *dst++ = *src++;
 504:	fe043703          	ld	a4,-32(s0)
 508:	00170793          	addi	a5,a4,1
 50c:	fef43023          	sd	a5,-32(s0)
 510:	fe843783          	ld	a5,-24(s0)
 514:	00178693          	addi	a3,a5,1
 518:	fed43423          	sd	a3,-24(s0)
 51c:	00074703          	lbu	a4,0(a4)
 520:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 524:	fcc42783          	lw	a5,-52(s0)
 528:	fff7871b          	addiw	a4,a5,-1
 52c:	fce42623          	sw	a4,-52(s0)
 530:	fcf04ae3          	bgtz	a5,504 <memmove+0x32>
 534:	a891                	j	588 <memmove+0xb6>
  } else {
    dst += n;
 536:	fcc42783          	lw	a5,-52(s0)
 53a:	fe843703          	ld	a4,-24(s0)
 53e:	97ba                	add	a5,a5,a4
 540:	fef43423          	sd	a5,-24(s0)
    src += n;
 544:	fcc42783          	lw	a5,-52(s0)
 548:	fe043703          	ld	a4,-32(s0)
 54c:	97ba                	add	a5,a5,a4
 54e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 552:	a01d                	j	578 <memmove+0xa6>
      *--dst = *--src;
 554:	fe043783          	ld	a5,-32(s0)
 558:	17fd                	addi	a5,a5,-1
 55a:	fef43023          	sd	a5,-32(s0)
 55e:	fe843783          	ld	a5,-24(s0)
 562:	17fd                	addi	a5,a5,-1
 564:	fef43423          	sd	a5,-24(s0)
 568:	fe043783          	ld	a5,-32(s0)
 56c:	0007c703          	lbu	a4,0(a5)
 570:	fe843783          	ld	a5,-24(s0)
 574:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 578:	fcc42783          	lw	a5,-52(s0)
 57c:	fff7871b          	addiw	a4,a5,-1
 580:	fce42623          	sw	a4,-52(s0)
 584:	fcf048e3          	bgtz	a5,554 <memmove+0x82>
  }
  return vdst;
 588:	fd843783          	ld	a5,-40(s0)
}
 58c:	853e                	mv	a0,a5
 58e:	7462                	ld	s0,56(sp)
 590:	6121                	addi	sp,sp,64
 592:	8082                	ret

0000000000000594 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 594:	7139                	addi	sp,sp,-64
 596:	fc22                	sd	s0,56(sp)
 598:	0080                	addi	s0,sp,64
 59a:	fca43c23          	sd	a0,-40(s0)
 59e:	fcb43823          	sd	a1,-48(s0)
 5a2:	87b2                	mv	a5,a2
 5a4:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 5a8:	fd843783          	ld	a5,-40(s0)
 5ac:	fef43423          	sd	a5,-24(s0)
 5b0:	fd043783          	ld	a5,-48(s0)
 5b4:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 5b8:	a0a1                	j	600 <memcmp+0x6c>
    if (*p1 != *p2) {
 5ba:	fe843783          	ld	a5,-24(s0)
 5be:	0007c703          	lbu	a4,0(a5)
 5c2:	fe043783          	ld	a5,-32(s0)
 5c6:	0007c783          	lbu	a5,0(a5)
 5ca:	02f70163          	beq	a4,a5,5ec <memcmp+0x58>
      return *p1 - *p2;
 5ce:	fe843783          	ld	a5,-24(s0)
 5d2:	0007c783          	lbu	a5,0(a5)
 5d6:	0007871b          	sext.w	a4,a5
 5da:	fe043783          	ld	a5,-32(s0)
 5de:	0007c783          	lbu	a5,0(a5)
 5e2:	2781                	sext.w	a5,a5
 5e4:	40f707bb          	subw	a5,a4,a5
 5e8:	2781                	sext.w	a5,a5
 5ea:	a01d                	j	610 <memcmp+0x7c>
    }
    p1++;
 5ec:	fe843783          	ld	a5,-24(s0)
 5f0:	0785                	addi	a5,a5,1
 5f2:	fef43423          	sd	a5,-24(s0)
    p2++;
 5f6:	fe043783          	ld	a5,-32(s0)
 5fa:	0785                	addi	a5,a5,1
 5fc:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 600:	fcc42783          	lw	a5,-52(s0)
 604:	fff7871b          	addiw	a4,a5,-1
 608:	fce42623          	sw	a4,-52(s0)
 60c:	f7dd                	bnez	a5,5ba <memcmp+0x26>
  }
  return 0;
 60e:	4781                	li	a5,0
}
 610:	853e                	mv	a0,a5
 612:	7462                	ld	s0,56(sp)
 614:	6121                	addi	sp,sp,64
 616:	8082                	ret

0000000000000618 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 618:	7179                	addi	sp,sp,-48
 61a:	f406                	sd	ra,40(sp)
 61c:	f022                	sd	s0,32(sp)
 61e:	1800                	addi	s0,sp,48
 620:	fea43423          	sd	a0,-24(s0)
 624:	feb43023          	sd	a1,-32(s0)
 628:	87b2                	mv	a5,a2
 62a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 62e:	fdc42783          	lw	a5,-36(s0)
 632:	863e                	mv	a2,a5
 634:	fe043583          	ld	a1,-32(s0)
 638:	fe843503          	ld	a0,-24(s0)
 63c:	00000097          	auipc	ra,0x0
 640:	e96080e7          	jalr	-362(ra) # 4d2 <memmove>
 644:	87aa                	mv	a5,a0
}
 646:	853e                	mv	a0,a5
 648:	70a2                	ld	ra,40(sp)
 64a:	7402                	ld	s0,32(sp)
 64c:	6145                	addi	sp,sp,48
 64e:	8082                	ret

0000000000000650 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 650:	4885                	li	a7,1
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <exit>:
.global exit
exit:
 li a7, SYS_exit
 658:	4889                	li	a7,2
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <wait>:
.global wait
wait:
 li a7, SYS_wait
 660:	488d                	li	a7,3
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 668:	4891                	li	a7,4
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <read>:
.global read
read:
 li a7, SYS_read
 670:	4895                	li	a7,5
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <write>:
.global write
write:
 li a7, SYS_write
 678:	48c1                	li	a7,16
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <close>:
.global close
close:
 li a7, SYS_close
 680:	48d5                	li	a7,21
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <kill>:
.global kill
kill:
 li a7, SYS_kill
 688:	4899                	li	a7,6
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <exec>:
.global exec
exec:
 li a7, SYS_exec
 690:	489d                	li	a7,7
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <open>:
.global open
open:
 li a7, SYS_open
 698:	48bd                	li	a7,15
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6a0:	48c5                	li	a7,17
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6a8:	48c9                	li	a7,18
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6b0:	48a1                	li	a7,8
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <link>:
.global link
link:
 li a7, SYS_link
 6b8:	48cd                	li	a7,19
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6c0:	48d1                	li	a7,20
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6c8:	48a5                	li	a7,9
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6d0:	48a9                	li	a7,10
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6d8:	48ad                	li	a7,11
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6e0:	48b1                	li	a7,12
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6e8:	48b5                	li	a7,13
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6f0:	48b9                	li	a7,14
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <clone>:
.global clone
clone:
 li a7, SYS_clone
 6f8:	48d9                	li	a7,22
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <join>:
.global join
join:
 li a7, SYS_join
 700:	48dd                	li	a7,23
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 708:	1101                	addi	sp,sp,-32
 70a:	ec06                	sd	ra,24(sp)
 70c:	e822                	sd	s0,16(sp)
 70e:	1000                	addi	s0,sp,32
 710:	87aa                	mv	a5,a0
 712:	872e                	mv	a4,a1
 714:	fef42623          	sw	a5,-20(s0)
 718:	87ba                	mv	a5,a4
 71a:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 71e:	feb40713          	addi	a4,s0,-21
 722:	fec42783          	lw	a5,-20(s0)
 726:	4605                	li	a2,1
 728:	85ba                	mv	a1,a4
 72a:	853e                	mv	a0,a5
 72c:	00000097          	auipc	ra,0x0
 730:	f4c080e7          	jalr	-180(ra) # 678 <write>
}
 734:	0001                	nop
 736:	60e2                	ld	ra,24(sp)
 738:	6442                	ld	s0,16(sp)
 73a:	6105                	addi	sp,sp,32
 73c:	8082                	ret

000000000000073e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 73e:	7139                	addi	sp,sp,-64
 740:	fc06                	sd	ra,56(sp)
 742:	f822                	sd	s0,48(sp)
 744:	0080                	addi	s0,sp,64
 746:	87aa                	mv	a5,a0
 748:	8736                	mv	a4,a3
 74a:	fcf42623          	sw	a5,-52(s0)
 74e:	87ae                	mv	a5,a1
 750:	fcf42423          	sw	a5,-56(s0)
 754:	87b2                	mv	a5,a2
 756:	fcf42223          	sw	a5,-60(s0)
 75a:	87ba                	mv	a5,a4
 75c:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 760:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 764:	fc042783          	lw	a5,-64(s0)
 768:	2781                	sext.w	a5,a5
 76a:	c38d                	beqz	a5,78c <printint+0x4e>
 76c:	fc842783          	lw	a5,-56(s0)
 770:	2781                	sext.w	a5,a5
 772:	0007dd63          	bgez	a5,78c <printint+0x4e>
    neg = 1;
 776:	4785                	li	a5,1
 778:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 77c:	fc842783          	lw	a5,-56(s0)
 780:	40f007bb          	negw	a5,a5
 784:	2781                	sext.w	a5,a5
 786:	fef42223          	sw	a5,-28(s0)
 78a:	a029                	j	794 <printint+0x56>
  } else {
    x = xx;
 78c:	fc842783          	lw	a5,-56(s0)
 790:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 794:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 798:	fc442783          	lw	a5,-60(s0)
 79c:	fe442703          	lw	a4,-28(s0)
 7a0:	02f777bb          	remuw	a5,a4,a5
 7a4:	0007861b          	sext.w	a2,a5
 7a8:	fec42783          	lw	a5,-20(s0)
 7ac:	0017871b          	addiw	a4,a5,1
 7b0:	fee42623          	sw	a4,-20(s0)
 7b4:	00000697          	auipc	a3,0x0
 7b8:	76468693          	addi	a3,a3,1892 # f18 <digits>
 7bc:	02061713          	slli	a4,a2,0x20
 7c0:	9301                	srli	a4,a4,0x20
 7c2:	9736                	add	a4,a4,a3
 7c4:	00074703          	lbu	a4,0(a4)
 7c8:	17c1                	addi	a5,a5,-16
 7ca:	97a2                	add	a5,a5,s0
 7cc:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 7d0:	fc442783          	lw	a5,-60(s0)
 7d4:	fe442703          	lw	a4,-28(s0)
 7d8:	02f757bb          	divuw	a5,a4,a5
 7dc:	fef42223          	sw	a5,-28(s0)
 7e0:	fe442783          	lw	a5,-28(s0)
 7e4:	2781                	sext.w	a5,a5
 7e6:	fbcd                	bnez	a5,798 <printint+0x5a>
  if(neg)
 7e8:	fe842783          	lw	a5,-24(s0)
 7ec:	2781                	sext.w	a5,a5
 7ee:	cf85                	beqz	a5,826 <printint+0xe8>
    buf[i++] = '-';
 7f0:	fec42783          	lw	a5,-20(s0)
 7f4:	0017871b          	addiw	a4,a5,1
 7f8:	fee42623          	sw	a4,-20(s0)
 7fc:	17c1                	addi	a5,a5,-16
 7fe:	97a2                	add	a5,a5,s0
 800:	02d00713          	li	a4,45
 804:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 808:	a839                	j	826 <printint+0xe8>
    putc(fd, buf[i]);
 80a:	fec42783          	lw	a5,-20(s0)
 80e:	17c1                	addi	a5,a5,-16
 810:	97a2                	add	a5,a5,s0
 812:	fe07c703          	lbu	a4,-32(a5)
 816:	fcc42783          	lw	a5,-52(s0)
 81a:	85ba                	mv	a1,a4
 81c:	853e                	mv	a0,a5
 81e:	00000097          	auipc	ra,0x0
 822:	eea080e7          	jalr	-278(ra) # 708 <putc>
  while(--i >= 0)
 826:	fec42783          	lw	a5,-20(s0)
 82a:	37fd                	addiw	a5,a5,-1
 82c:	fef42623          	sw	a5,-20(s0)
 830:	fec42783          	lw	a5,-20(s0)
 834:	2781                	sext.w	a5,a5
 836:	fc07dae3          	bgez	a5,80a <printint+0xcc>
}
 83a:	0001                	nop
 83c:	0001                	nop
 83e:	70e2                	ld	ra,56(sp)
 840:	7442                	ld	s0,48(sp)
 842:	6121                	addi	sp,sp,64
 844:	8082                	ret

0000000000000846 <printptr>:

static void
printptr(int fd, uint64 x) {
 846:	7179                	addi	sp,sp,-48
 848:	f406                	sd	ra,40(sp)
 84a:	f022                	sd	s0,32(sp)
 84c:	1800                	addi	s0,sp,48
 84e:	87aa                	mv	a5,a0
 850:	fcb43823          	sd	a1,-48(s0)
 854:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 858:	fdc42783          	lw	a5,-36(s0)
 85c:	03000593          	li	a1,48
 860:	853e                	mv	a0,a5
 862:	00000097          	auipc	ra,0x0
 866:	ea6080e7          	jalr	-346(ra) # 708 <putc>
  putc(fd, 'x');
 86a:	fdc42783          	lw	a5,-36(s0)
 86e:	07800593          	li	a1,120
 872:	853e                	mv	a0,a5
 874:	00000097          	auipc	ra,0x0
 878:	e94080e7          	jalr	-364(ra) # 708 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 87c:	fe042623          	sw	zero,-20(s0)
 880:	a82d                	j	8ba <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 882:	fd043783          	ld	a5,-48(s0)
 886:	93f1                	srli	a5,a5,0x3c
 888:	00000717          	auipc	a4,0x0
 88c:	69070713          	addi	a4,a4,1680 # f18 <digits>
 890:	97ba                	add	a5,a5,a4
 892:	0007c703          	lbu	a4,0(a5)
 896:	fdc42783          	lw	a5,-36(s0)
 89a:	85ba                	mv	a1,a4
 89c:	853e                	mv	a0,a5
 89e:	00000097          	auipc	ra,0x0
 8a2:	e6a080e7          	jalr	-406(ra) # 708 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8a6:	fec42783          	lw	a5,-20(s0)
 8aa:	2785                	addiw	a5,a5,1
 8ac:	fef42623          	sw	a5,-20(s0)
 8b0:	fd043783          	ld	a5,-48(s0)
 8b4:	0792                	slli	a5,a5,0x4
 8b6:	fcf43823          	sd	a5,-48(s0)
 8ba:	fec42783          	lw	a5,-20(s0)
 8be:	873e                	mv	a4,a5
 8c0:	47bd                	li	a5,15
 8c2:	fce7f0e3          	bgeu	a5,a4,882 <printptr+0x3c>
}
 8c6:	0001                	nop
 8c8:	0001                	nop
 8ca:	70a2                	ld	ra,40(sp)
 8cc:	7402                	ld	s0,32(sp)
 8ce:	6145                	addi	sp,sp,48
 8d0:	8082                	ret

00000000000008d2 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8d2:	715d                	addi	sp,sp,-80
 8d4:	e486                	sd	ra,72(sp)
 8d6:	e0a2                	sd	s0,64(sp)
 8d8:	0880                	addi	s0,sp,80
 8da:	87aa                	mv	a5,a0
 8dc:	fcb43023          	sd	a1,-64(s0)
 8e0:	fac43c23          	sd	a2,-72(s0)
 8e4:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 8e8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 8ec:	fe042223          	sw	zero,-28(s0)
 8f0:	a42d                	j	b1a <vprintf+0x248>
    c = fmt[i] & 0xff;
 8f2:	fe442783          	lw	a5,-28(s0)
 8f6:	fc043703          	ld	a4,-64(s0)
 8fa:	97ba                	add	a5,a5,a4
 8fc:	0007c783          	lbu	a5,0(a5)
 900:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 904:	fe042783          	lw	a5,-32(s0)
 908:	2781                	sext.w	a5,a5
 90a:	eb9d                	bnez	a5,940 <vprintf+0x6e>
      if(c == '%'){
 90c:	fdc42783          	lw	a5,-36(s0)
 910:	0007871b          	sext.w	a4,a5
 914:	02500793          	li	a5,37
 918:	00f71763          	bne	a4,a5,926 <vprintf+0x54>
        state = '%';
 91c:	02500793          	li	a5,37
 920:	fef42023          	sw	a5,-32(s0)
 924:	a2f5                	j	b10 <vprintf+0x23e>
      } else {
        putc(fd, c);
 926:	fdc42783          	lw	a5,-36(s0)
 92a:	0ff7f713          	zext.b	a4,a5
 92e:	fcc42783          	lw	a5,-52(s0)
 932:	85ba                	mv	a1,a4
 934:	853e                	mv	a0,a5
 936:	00000097          	auipc	ra,0x0
 93a:	dd2080e7          	jalr	-558(ra) # 708 <putc>
 93e:	aac9                	j	b10 <vprintf+0x23e>
      }
    } else if(state == '%'){
 940:	fe042783          	lw	a5,-32(s0)
 944:	0007871b          	sext.w	a4,a5
 948:	02500793          	li	a5,37
 94c:	1cf71263          	bne	a4,a5,b10 <vprintf+0x23e>
      if(c == 'd'){
 950:	fdc42783          	lw	a5,-36(s0)
 954:	0007871b          	sext.w	a4,a5
 958:	06400793          	li	a5,100
 95c:	02f71463          	bne	a4,a5,984 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 960:	fb843783          	ld	a5,-72(s0)
 964:	00878713          	addi	a4,a5,8
 968:	fae43c23          	sd	a4,-72(s0)
 96c:	4398                	lw	a4,0(a5)
 96e:	fcc42783          	lw	a5,-52(s0)
 972:	4685                	li	a3,1
 974:	4629                	li	a2,10
 976:	85ba                	mv	a1,a4
 978:	853e                	mv	a0,a5
 97a:	00000097          	auipc	ra,0x0
 97e:	dc4080e7          	jalr	-572(ra) # 73e <printint>
 982:	a269                	j	b0c <vprintf+0x23a>
      } else if(c == 'l') {
 984:	fdc42783          	lw	a5,-36(s0)
 988:	0007871b          	sext.w	a4,a5
 98c:	06c00793          	li	a5,108
 990:	02f71663          	bne	a4,a5,9bc <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 994:	fb843783          	ld	a5,-72(s0)
 998:	00878713          	addi	a4,a5,8
 99c:	fae43c23          	sd	a4,-72(s0)
 9a0:	639c                	ld	a5,0(a5)
 9a2:	0007871b          	sext.w	a4,a5
 9a6:	fcc42783          	lw	a5,-52(s0)
 9aa:	4681                	li	a3,0
 9ac:	4629                	li	a2,10
 9ae:	85ba                	mv	a1,a4
 9b0:	853e                	mv	a0,a5
 9b2:	00000097          	auipc	ra,0x0
 9b6:	d8c080e7          	jalr	-628(ra) # 73e <printint>
 9ba:	aa89                	j	b0c <vprintf+0x23a>
      } else if(c == 'x') {
 9bc:	fdc42783          	lw	a5,-36(s0)
 9c0:	0007871b          	sext.w	a4,a5
 9c4:	07800793          	li	a5,120
 9c8:	02f71463          	bne	a4,a5,9f0 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 9cc:	fb843783          	ld	a5,-72(s0)
 9d0:	00878713          	addi	a4,a5,8
 9d4:	fae43c23          	sd	a4,-72(s0)
 9d8:	4398                	lw	a4,0(a5)
 9da:	fcc42783          	lw	a5,-52(s0)
 9de:	4681                	li	a3,0
 9e0:	4641                	li	a2,16
 9e2:	85ba                	mv	a1,a4
 9e4:	853e                	mv	a0,a5
 9e6:	00000097          	auipc	ra,0x0
 9ea:	d58080e7          	jalr	-680(ra) # 73e <printint>
 9ee:	aa39                	j	b0c <vprintf+0x23a>
      } else if(c == 'p') {
 9f0:	fdc42783          	lw	a5,-36(s0)
 9f4:	0007871b          	sext.w	a4,a5
 9f8:	07000793          	li	a5,112
 9fc:	02f71263          	bne	a4,a5,a20 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 a00:	fb843783          	ld	a5,-72(s0)
 a04:	00878713          	addi	a4,a5,8
 a08:	fae43c23          	sd	a4,-72(s0)
 a0c:	6398                	ld	a4,0(a5)
 a0e:	fcc42783          	lw	a5,-52(s0)
 a12:	85ba                	mv	a1,a4
 a14:	853e                	mv	a0,a5
 a16:	00000097          	auipc	ra,0x0
 a1a:	e30080e7          	jalr	-464(ra) # 846 <printptr>
 a1e:	a0fd                	j	b0c <vprintf+0x23a>
      } else if(c == 's'){
 a20:	fdc42783          	lw	a5,-36(s0)
 a24:	0007871b          	sext.w	a4,a5
 a28:	07300793          	li	a5,115
 a2c:	04f71c63          	bne	a4,a5,a84 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 a30:	fb843783          	ld	a5,-72(s0)
 a34:	00878713          	addi	a4,a5,8
 a38:	fae43c23          	sd	a4,-72(s0)
 a3c:	639c                	ld	a5,0(a5)
 a3e:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 a42:	fe843783          	ld	a5,-24(s0)
 a46:	eb8d                	bnez	a5,a78 <vprintf+0x1a6>
          s = "(null)";
 a48:	00000797          	auipc	a5,0x0
 a4c:	4c878793          	addi	a5,a5,1224 # f10 <malloc+0x18e>
 a50:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 a54:	a015                	j	a78 <vprintf+0x1a6>
          putc(fd, *s);
 a56:	fe843783          	ld	a5,-24(s0)
 a5a:	0007c703          	lbu	a4,0(a5)
 a5e:	fcc42783          	lw	a5,-52(s0)
 a62:	85ba                	mv	a1,a4
 a64:	853e                	mv	a0,a5
 a66:	00000097          	auipc	ra,0x0
 a6a:	ca2080e7          	jalr	-862(ra) # 708 <putc>
          s++;
 a6e:	fe843783          	ld	a5,-24(s0)
 a72:	0785                	addi	a5,a5,1
 a74:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 a78:	fe843783          	ld	a5,-24(s0)
 a7c:	0007c783          	lbu	a5,0(a5)
 a80:	fbf9                	bnez	a5,a56 <vprintf+0x184>
 a82:	a069                	j	b0c <vprintf+0x23a>
        }
      } else if(c == 'c'){
 a84:	fdc42783          	lw	a5,-36(s0)
 a88:	0007871b          	sext.w	a4,a5
 a8c:	06300793          	li	a5,99
 a90:	02f71463          	bne	a4,a5,ab8 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 a94:	fb843783          	ld	a5,-72(s0)
 a98:	00878713          	addi	a4,a5,8
 a9c:	fae43c23          	sd	a4,-72(s0)
 aa0:	439c                	lw	a5,0(a5)
 aa2:	0ff7f713          	zext.b	a4,a5
 aa6:	fcc42783          	lw	a5,-52(s0)
 aaa:	85ba                	mv	a1,a4
 aac:	853e                	mv	a0,a5
 aae:	00000097          	auipc	ra,0x0
 ab2:	c5a080e7          	jalr	-934(ra) # 708 <putc>
 ab6:	a899                	j	b0c <vprintf+0x23a>
      } else if(c == '%'){
 ab8:	fdc42783          	lw	a5,-36(s0)
 abc:	0007871b          	sext.w	a4,a5
 ac0:	02500793          	li	a5,37
 ac4:	00f71f63          	bne	a4,a5,ae2 <vprintf+0x210>
        putc(fd, c);
 ac8:	fdc42783          	lw	a5,-36(s0)
 acc:	0ff7f713          	zext.b	a4,a5
 ad0:	fcc42783          	lw	a5,-52(s0)
 ad4:	85ba                	mv	a1,a4
 ad6:	853e                	mv	a0,a5
 ad8:	00000097          	auipc	ra,0x0
 adc:	c30080e7          	jalr	-976(ra) # 708 <putc>
 ae0:	a035                	j	b0c <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 ae2:	fcc42783          	lw	a5,-52(s0)
 ae6:	02500593          	li	a1,37
 aea:	853e                	mv	a0,a5
 aec:	00000097          	auipc	ra,0x0
 af0:	c1c080e7          	jalr	-996(ra) # 708 <putc>
        putc(fd, c);
 af4:	fdc42783          	lw	a5,-36(s0)
 af8:	0ff7f713          	zext.b	a4,a5
 afc:	fcc42783          	lw	a5,-52(s0)
 b00:	85ba                	mv	a1,a4
 b02:	853e                	mv	a0,a5
 b04:	00000097          	auipc	ra,0x0
 b08:	c04080e7          	jalr	-1020(ra) # 708 <putc>
      }
      state = 0;
 b0c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 b10:	fe442783          	lw	a5,-28(s0)
 b14:	2785                	addiw	a5,a5,1
 b16:	fef42223          	sw	a5,-28(s0)
 b1a:	fe442783          	lw	a5,-28(s0)
 b1e:	fc043703          	ld	a4,-64(s0)
 b22:	97ba                	add	a5,a5,a4
 b24:	0007c783          	lbu	a5,0(a5)
 b28:	dc0795e3          	bnez	a5,8f2 <vprintf+0x20>
    }
  }
}
 b2c:	0001                	nop
 b2e:	0001                	nop
 b30:	60a6                	ld	ra,72(sp)
 b32:	6406                	ld	s0,64(sp)
 b34:	6161                	addi	sp,sp,80
 b36:	8082                	ret

0000000000000b38 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b38:	7159                	addi	sp,sp,-112
 b3a:	fc06                	sd	ra,56(sp)
 b3c:	f822                	sd	s0,48(sp)
 b3e:	0080                	addi	s0,sp,64
 b40:	fcb43823          	sd	a1,-48(s0)
 b44:	e010                	sd	a2,0(s0)
 b46:	e414                	sd	a3,8(s0)
 b48:	e818                	sd	a4,16(s0)
 b4a:	ec1c                	sd	a5,24(s0)
 b4c:	03043023          	sd	a6,32(s0)
 b50:	03143423          	sd	a7,40(s0)
 b54:	87aa                	mv	a5,a0
 b56:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 b5a:	03040793          	addi	a5,s0,48
 b5e:	fcf43423          	sd	a5,-56(s0)
 b62:	fc843783          	ld	a5,-56(s0)
 b66:	fd078793          	addi	a5,a5,-48
 b6a:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 b6e:	fe843703          	ld	a4,-24(s0)
 b72:	fdc42783          	lw	a5,-36(s0)
 b76:	863a                	mv	a2,a4
 b78:	fd043583          	ld	a1,-48(s0)
 b7c:	853e                	mv	a0,a5
 b7e:	00000097          	auipc	ra,0x0
 b82:	d54080e7          	jalr	-684(ra) # 8d2 <vprintf>
}
 b86:	0001                	nop
 b88:	70e2                	ld	ra,56(sp)
 b8a:	7442                	ld	s0,48(sp)
 b8c:	6165                	addi	sp,sp,112
 b8e:	8082                	ret

0000000000000b90 <printf>:

void
printf(const char *fmt, ...)
{
 b90:	7159                	addi	sp,sp,-112
 b92:	f406                	sd	ra,40(sp)
 b94:	f022                	sd	s0,32(sp)
 b96:	1800                	addi	s0,sp,48
 b98:	fca43c23          	sd	a0,-40(s0)
 b9c:	e40c                	sd	a1,8(s0)
 b9e:	e810                	sd	a2,16(s0)
 ba0:	ec14                	sd	a3,24(s0)
 ba2:	f018                	sd	a4,32(s0)
 ba4:	f41c                	sd	a5,40(s0)
 ba6:	03043823          	sd	a6,48(s0)
 baa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 bae:	04040793          	addi	a5,s0,64
 bb2:	fcf43823          	sd	a5,-48(s0)
 bb6:	fd043783          	ld	a5,-48(s0)
 bba:	fc878793          	addi	a5,a5,-56
 bbe:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 bc2:	fe843783          	ld	a5,-24(s0)
 bc6:	863e                	mv	a2,a5
 bc8:	fd843583          	ld	a1,-40(s0)
 bcc:	4505                	li	a0,1
 bce:	00000097          	auipc	ra,0x0
 bd2:	d04080e7          	jalr	-764(ra) # 8d2 <vprintf>
}
 bd6:	0001                	nop
 bd8:	70a2                	ld	ra,40(sp)
 bda:	7402                	ld	s0,32(sp)
 bdc:	6165                	addi	sp,sp,112
 bde:	8082                	ret

0000000000000be0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 be0:	7179                	addi	sp,sp,-48
 be2:	f422                	sd	s0,40(sp)
 be4:	1800                	addi	s0,sp,48
 be6:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bea:	fd843783          	ld	a5,-40(s0)
 bee:	17c1                	addi	a5,a5,-16
 bf0:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bf4:	00000797          	auipc	a5,0x0
 bf8:	34c78793          	addi	a5,a5,844 # f40 <freep>
 bfc:	639c                	ld	a5,0(a5)
 bfe:	fef43423          	sd	a5,-24(s0)
 c02:	a815                	j	c36 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c04:	fe843783          	ld	a5,-24(s0)
 c08:	639c                	ld	a5,0(a5)
 c0a:	fe843703          	ld	a4,-24(s0)
 c0e:	00f76f63          	bltu	a4,a5,c2c <free+0x4c>
 c12:	fe043703          	ld	a4,-32(s0)
 c16:	fe843783          	ld	a5,-24(s0)
 c1a:	02e7eb63          	bltu	a5,a4,c50 <free+0x70>
 c1e:	fe843783          	ld	a5,-24(s0)
 c22:	639c                	ld	a5,0(a5)
 c24:	fe043703          	ld	a4,-32(s0)
 c28:	02f76463          	bltu	a4,a5,c50 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c2c:	fe843783          	ld	a5,-24(s0)
 c30:	639c                	ld	a5,0(a5)
 c32:	fef43423          	sd	a5,-24(s0)
 c36:	fe043703          	ld	a4,-32(s0)
 c3a:	fe843783          	ld	a5,-24(s0)
 c3e:	fce7f3e3          	bgeu	a5,a4,c04 <free+0x24>
 c42:	fe843783          	ld	a5,-24(s0)
 c46:	639c                	ld	a5,0(a5)
 c48:	fe043703          	ld	a4,-32(s0)
 c4c:	faf77ce3          	bgeu	a4,a5,c04 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c50:	fe043783          	ld	a5,-32(s0)
 c54:	479c                	lw	a5,8(a5)
 c56:	1782                	slli	a5,a5,0x20
 c58:	9381                	srli	a5,a5,0x20
 c5a:	0792                	slli	a5,a5,0x4
 c5c:	fe043703          	ld	a4,-32(s0)
 c60:	973e                	add	a4,a4,a5
 c62:	fe843783          	ld	a5,-24(s0)
 c66:	639c                	ld	a5,0(a5)
 c68:	02f71763          	bne	a4,a5,c96 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 c6c:	fe043783          	ld	a5,-32(s0)
 c70:	4798                	lw	a4,8(a5)
 c72:	fe843783          	ld	a5,-24(s0)
 c76:	639c                	ld	a5,0(a5)
 c78:	479c                	lw	a5,8(a5)
 c7a:	9fb9                	addw	a5,a5,a4
 c7c:	0007871b          	sext.w	a4,a5
 c80:	fe043783          	ld	a5,-32(s0)
 c84:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 c86:	fe843783          	ld	a5,-24(s0)
 c8a:	639c                	ld	a5,0(a5)
 c8c:	6398                	ld	a4,0(a5)
 c8e:	fe043783          	ld	a5,-32(s0)
 c92:	e398                	sd	a4,0(a5)
 c94:	a039                	j	ca2 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 c96:	fe843783          	ld	a5,-24(s0)
 c9a:	6398                	ld	a4,0(a5)
 c9c:	fe043783          	ld	a5,-32(s0)
 ca0:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 ca2:	fe843783          	ld	a5,-24(s0)
 ca6:	479c                	lw	a5,8(a5)
 ca8:	1782                	slli	a5,a5,0x20
 caa:	9381                	srli	a5,a5,0x20
 cac:	0792                	slli	a5,a5,0x4
 cae:	fe843703          	ld	a4,-24(s0)
 cb2:	97ba                	add	a5,a5,a4
 cb4:	fe043703          	ld	a4,-32(s0)
 cb8:	02f71563          	bne	a4,a5,ce2 <free+0x102>
    p->s.size += bp->s.size;
 cbc:	fe843783          	ld	a5,-24(s0)
 cc0:	4798                	lw	a4,8(a5)
 cc2:	fe043783          	ld	a5,-32(s0)
 cc6:	479c                	lw	a5,8(a5)
 cc8:	9fb9                	addw	a5,a5,a4
 cca:	0007871b          	sext.w	a4,a5
 cce:	fe843783          	ld	a5,-24(s0)
 cd2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 cd4:	fe043783          	ld	a5,-32(s0)
 cd8:	6398                	ld	a4,0(a5)
 cda:	fe843783          	ld	a5,-24(s0)
 cde:	e398                	sd	a4,0(a5)
 ce0:	a031                	j	cec <free+0x10c>
  } else
    p->s.ptr = bp;
 ce2:	fe843783          	ld	a5,-24(s0)
 ce6:	fe043703          	ld	a4,-32(s0)
 cea:	e398                	sd	a4,0(a5)
  freep = p;
 cec:	00000797          	auipc	a5,0x0
 cf0:	25478793          	addi	a5,a5,596 # f40 <freep>
 cf4:	fe843703          	ld	a4,-24(s0)
 cf8:	e398                	sd	a4,0(a5)
}
 cfa:	0001                	nop
 cfc:	7422                	ld	s0,40(sp)
 cfe:	6145                	addi	sp,sp,48
 d00:	8082                	ret

0000000000000d02 <morecore>:

static Header*
morecore(uint nu)
{
 d02:	7179                	addi	sp,sp,-48
 d04:	f406                	sd	ra,40(sp)
 d06:	f022                	sd	s0,32(sp)
 d08:	1800                	addi	s0,sp,48
 d0a:	87aa                	mv	a5,a0
 d0c:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 d10:	fdc42783          	lw	a5,-36(s0)
 d14:	0007871b          	sext.w	a4,a5
 d18:	6785                	lui	a5,0x1
 d1a:	00f77563          	bgeu	a4,a5,d24 <morecore+0x22>
    nu = 4096;
 d1e:	6785                	lui	a5,0x1
 d20:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 d24:	fdc42783          	lw	a5,-36(s0)
 d28:	0047979b          	slliw	a5,a5,0x4
 d2c:	2781                	sext.w	a5,a5
 d2e:	2781                	sext.w	a5,a5
 d30:	853e                	mv	a0,a5
 d32:	00000097          	auipc	ra,0x0
 d36:	9ae080e7          	jalr	-1618(ra) # 6e0 <sbrk>
 d3a:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 d3e:	fe843703          	ld	a4,-24(s0)
 d42:	57fd                	li	a5,-1
 d44:	00f71463          	bne	a4,a5,d4c <morecore+0x4a>
    return 0;
 d48:	4781                	li	a5,0
 d4a:	a03d                	j	d78 <morecore+0x76>
  hp = (Header*)p;
 d4c:	fe843783          	ld	a5,-24(s0)
 d50:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 d54:	fe043783          	ld	a5,-32(s0)
 d58:	fdc42703          	lw	a4,-36(s0)
 d5c:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 d5e:	fe043783          	ld	a5,-32(s0)
 d62:	07c1                	addi	a5,a5,16
 d64:	853e                	mv	a0,a5
 d66:	00000097          	auipc	ra,0x0
 d6a:	e7a080e7          	jalr	-390(ra) # be0 <free>
  return freep;
 d6e:	00000797          	auipc	a5,0x0
 d72:	1d278793          	addi	a5,a5,466 # f40 <freep>
 d76:	639c                	ld	a5,0(a5)
}
 d78:	853e                	mv	a0,a5
 d7a:	70a2                	ld	ra,40(sp)
 d7c:	7402                	ld	s0,32(sp)
 d7e:	6145                	addi	sp,sp,48
 d80:	8082                	ret

0000000000000d82 <malloc>:

void*
malloc(uint nbytes)
{
 d82:	7139                	addi	sp,sp,-64
 d84:	fc06                	sd	ra,56(sp)
 d86:	f822                	sd	s0,48(sp)
 d88:	0080                	addi	s0,sp,64
 d8a:	87aa                	mv	a5,a0
 d8c:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d90:	fcc46783          	lwu	a5,-52(s0)
 d94:	07bd                	addi	a5,a5,15
 d96:	8391                	srli	a5,a5,0x4
 d98:	2781                	sext.w	a5,a5
 d9a:	2785                	addiw	a5,a5,1
 d9c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 da0:	00000797          	auipc	a5,0x0
 da4:	1a078793          	addi	a5,a5,416 # f40 <freep>
 da8:	639c                	ld	a5,0(a5)
 daa:	fef43023          	sd	a5,-32(s0)
 dae:	fe043783          	ld	a5,-32(s0)
 db2:	ef95                	bnez	a5,dee <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 db4:	00000797          	auipc	a5,0x0
 db8:	17c78793          	addi	a5,a5,380 # f30 <base>
 dbc:	fef43023          	sd	a5,-32(s0)
 dc0:	00000797          	auipc	a5,0x0
 dc4:	18078793          	addi	a5,a5,384 # f40 <freep>
 dc8:	fe043703          	ld	a4,-32(s0)
 dcc:	e398                	sd	a4,0(a5)
 dce:	00000797          	auipc	a5,0x0
 dd2:	17278793          	addi	a5,a5,370 # f40 <freep>
 dd6:	6398                	ld	a4,0(a5)
 dd8:	00000797          	auipc	a5,0x0
 ddc:	15878793          	addi	a5,a5,344 # f30 <base>
 de0:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 de2:	00000797          	auipc	a5,0x0
 de6:	14e78793          	addi	a5,a5,334 # f30 <base>
 dea:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dee:	fe043783          	ld	a5,-32(s0)
 df2:	639c                	ld	a5,0(a5)
 df4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 df8:	fe843783          	ld	a5,-24(s0)
 dfc:	4798                	lw	a4,8(a5)
 dfe:	fdc42783          	lw	a5,-36(s0)
 e02:	2781                	sext.w	a5,a5
 e04:	06f76763          	bltu	a4,a5,e72 <malloc+0xf0>
      if(p->s.size == nunits)
 e08:	fe843783          	ld	a5,-24(s0)
 e0c:	4798                	lw	a4,8(a5)
 e0e:	fdc42783          	lw	a5,-36(s0)
 e12:	2781                	sext.w	a5,a5
 e14:	00e79963          	bne	a5,a4,e26 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 e18:	fe843783          	ld	a5,-24(s0)
 e1c:	6398                	ld	a4,0(a5)
 e1e:	fe043783          	ld	a5,-32(s0)
 e22:	e398                	sd	a4,0(a5)
 e24:	a825                	j	e5c <malloc+0xda>
      else {
        p->s.size -= nunits;
 e26:	fe843783          	ld	a5,-24(s0)
 e2a:	479c                	lw	a5,8(a5)
 e2c:	fdc42703          	lw	a4,-36(s0)
 e30:	9f99                	subw	a5,a5,a4
 e32:	0007871b          	sext.w	a4,a5
 e36:	fe843783          	ld	a5,-24(s0)
 e3a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 e3c:	fe843783          	ld	a5,-24(s0)
 e40:	479c                	lw	a5,8(a5)
 e42:	1782                	slli	a5,a5,0x20
 e44:	9381                	srli	a5,a5,0x20
 e46:	0792                	slli	a5,a5,0x4
 e48:	fe843703          	ld	a4,-24(s0)
 e4c:	97ba                	add	a5,a5,a4
 e4e:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 e52:	fe843783          	ld	a5,-24(s0)
 e56:	fdc42703          	lw	a4,-36(s0)
 e5a:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 e5c:	00000797          	auipc	a5,0x0
 e60:	0e478793          	addi	a5,a5,228 # f40 <freep>
 e64:	fe043703          	ld	a4,-32(s0)
 e68:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 e6a:	fe843783          	ld	a5,-24(s0)
 e6e:	07c1                	addi	a5,a5,16
 e70:	a091                	j	eb4 <malloc+0x132>
    }
    if(p == freep)
 e72:	00000797          	auipc	a5,0x0
 e76:	0ce78793          	addi	a5,a5,206 # f40 <freep>
 e7a:	639c                	ld	a5,0(a5)
 e7c:	fe843703          	ld	a4,-24(s0)
 e80:	02f71063          	bne	a4,a5,ea0 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 e84:	fdc42783          	lw	a5,-36(s0)
 e88:	853e                	mv	a0,a5
 e8a:	00000097          	auipc	ra,0x0
 e8e:	e78080e7          	jalr	-392(ra) # d02 <morecore>
 e92:	fea43423          	sd	a0,-24(s0)
 e96:	fe843783          	ld	a5,-24(s0)
 e9a:	e399                	bnez	a5,ea0 <malloc+0x11e>
        return 0;
 e9c:	4781                	li	a5,0
 e9e:	a819                	j	eb4 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ea0:	fe843783          	ld	a5,-24(s0)
 ea4:	fef43023          	sd	a5,-32(s0)
 ea8:	fe843783          	ld	a5,-24(s0)
 eac:	639c                	ld	a5,0(a5)
 eae:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 eb2:	b799                	j	df8 <malloc+0x76>
  }
}
 eb4:	853e                	mv	a0,a5
 eb6:	70e2                	ld	ra,56(sp)
 eb8:	7442                	ld	s0,48(sp)
 eba:	6121                	addi	sp,sp,64
 ebc:	8082                	ret
