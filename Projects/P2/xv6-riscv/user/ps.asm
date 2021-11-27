
user/_ps:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user.h"
#include "../kernel/pstat.h"


int main (void)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
   8:	81010113          	addi	sp,sp,-2032
    struct pstat ps ;
    if (getpinfo(&ps) < 0){
   c:	77fd                	lui	a5,0xfffff
   e:	7f878793          	addi	a5,a5,2040 # fffffffffffff7f8 <__global_pointer$+0xffffffffffffe1b0>
  12:	ff040713          	addi	a4,s0,-16
  16:	97ba                	add	a5,a5,a4
  18:	853e                	mv	a0,a5
  1a:	00000097          	auipc	ra,0x0
  1e:	5f6080e7          	jalr	1526(ra) # 610 <getpinfo>
  22:	87aa                	mv	a5,a0
  24:	0007df63          	bgez	a5,42 <main+0x42>
        printf ("ERROR. La llamada ha devuelto codigo -1\n");
  28:	00001517          	auipc	a0,0x1
  2c:	db850513          	addi	a0,a0,-584 # de0 <malloc+0x140>
  30:	00001097          	auipc	ra,0x1
  34:	a7e080e7          	jalr	-1410(ra) # aae <printf>
        exit(1);
  38:	4505                	li	a0,1
  3a:	00000097          	auipc	ra,0x0
  3e:	536080e7          	jalr	1334(ra) # 570 <exit>
    }

    for (int i = 0; i < NPROC; i++){
  42:	fe042623          	sw	zero,-20(s0)
  46:	a041                	j	c6 <main+0xc6>
        if (ps.inuse[i]==1){
  48:	77fd                	lui	a5,0xfffff
  4a:	ff040713          	addi	a4,s0,-16
  4e:	973e                	add	a4,a4,a5
  50:	fec42783          	lw	a5,-20(s0)
  54:	078e                	slli	a5,a5,0x3
  56:	97ba                	add	a5,a5,a4
  58:	7f87b703          	ld	a4,2040(a5) # fffffffffffff7f8 <__global_pointer$+0xffffffffffffe1b0>
  5c:	4785                	li	a5,1
  5e:	04f71f63          	bne	a4,a5,bc <main+0xbc>
            printf ("PID:   %d; LTICKS:     %d; HTICKS:     %d\n", ps.pid[i], ps.lticks[i], ps.hticks[i]);   
  62:	77fd                	lui	a5,0xfffff
  64:	ff040713          	addi	a4,s0,-16
  68:	973e                	add	a4,a4,a5
  6a:	fec42783          	lw	a5,-20(s0)
  6e:	04078793          	addi	a5,a5,64 # fffffffffffff040 <__global_pointer$+0xffffffffffffd9f8>
  72:	078e                	slli	a5,a5,0x3
  74:	97ba                	add	a5,a5,a4
  76:	7f87b583          	ld	a1,2040(a5)
  7a:	77fd                	lui	a5,0xfffff
  7c:	ff040713          	addi	a4,s0,-16
  80:	973e                	add	a4,a4,a5
  82:	fec42783          	lw	a5,-20(s0)
  86:	0c078793          	addi	a5,a5,192 # fffffffffffff0c0 <__global_pointer$+0xffffffffffffda78>
  8a:	078e                	slli	a5,a5,0x3
  8c:	97ba                	add	a5,a5,a4
  8e:	7f87b603          	ld	a2,2040(a5)
  92:	77fd                	lui	a5,0xfffff
  94:	ff040713          	addi	a4,s0,-16
  98:	973e                	add	a4,a4,a5
  9a:	fec42783          	lw	a5,-20(s0)
  9e:	08078793          	addi	a5,a5,128 # fffffffffffff080 <__global_pointer$+0xffffffffffffda38>
  a2:	078e                	slli	a5,a5,0x3
  a4:	97ba                	add	a5,a5,a4
  a6:	7f87b783          	ld	a5,2040(a5)
  aa:	86be                	mv	a3,a5
  ac:	00001517          	auipc	a0,0x1
  b0:	d6450513          	addi	a0,a0,-668 # e10 <malloc+0x170>
  b4:	00001097          	auipc	ra,0x1
  b8:	9fa080e7          	jalr	-1542(ra) # aae <printf>
    for (int i = 0; i < NPROC; i++){
  bc:	fec42783          	lw	a5,-20(s0)
  c0:	2785                	addiw	a5,a5,1
  c2:	fef42623          	sw	a5,-20(s0)
  c6:	fec42783          	lw	a5,-20(s0)
  ca:	0007871b          	sext.w	a4,a5
  ce:	03f00793          	li	a5,63
  d2:	f6e7dbe3          	bge	a5,a4,48 <main+0x48>
        }
    }

    exit(0);
  d6:	4501                	li	a0,0
  d8:	00000097          	auipc	ra,0x0
  dc:	498080e7          	jalr	1176(ra) # 570 <exit>

00000000000000e0 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  e0:	7179                	addi	sp,sp,-48
  e2:	f422                	sd	s0,40(sp)
  e4:	1800                	addi	s0,sp,48
  e6:	fca43c23          	sd	a0,-40(s0)
  ea:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  ee:	fd843783          	ld	a5,-40(s0)
  f2:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  f6:	0001                	nop
  f8:	fd043703          	ld	a4,-48(s0)
  fc:	00170793          	addi	a5,a4,1
 100:	fcf43823          	sd	a5,-48(s0)
 104:	fd843783          	ld	a5,-40(s0)
 108:	00178693          	addi	a3,a5,1
 10c:	fcd43c23          	sd	a3,-40(s0)
 110:	00074703          	lbu	a4,0(a4)
 114:	00e78023          	sb	a4,0(a5)
 118:	0007c783          	lbu	a5,0(a5)
 11c:	fff1                	bnez	a5,f8 <strcpy+0x18>
    ;
  return os;
 11e:	fe843783          	ld	a5,-24(s0)
}
 122:	853e                	mv	a0,a5
 124:	7422                	ld	s0,40(sp)
 126:	6145                	addi	sp,sp,48
 128:	8082                	ret

000000000000012a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 12a:	1101                	addi	sp,sp,-32
 12c:	ec22                	sd	s0,24(sp)
 12e:	1000                	addi	s0,sp,32
 130:	fea43423          	sd	a0,-24(s0)
 134:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 138:	a819                	j	14e <strcmp+0x24>
    p++, q++;
 13a:	fe843783          	ld	a5,-24(s0)
 13e:	0785                	addi	a5,a5,1
 140:	fef43423          	sd	a5,-24(s0)
 144:	fe043783          	ld	a5,-32(s0)
 148:	0785                	addi	a5,a5,1
 14a:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 14e:	fe843783          	ld	a5,-24(s0)
 152:	0007c783          	lbu	a5,0(a5)
 156:	cb99                	beqz	a5,16c <strcmp+0x42>
 158:	fe843783          	ld	a5,-24(s0)
 15c:	0007c703          	lbu	a4,0(a5)
 160:	fe043783          	ld	a5,-32(s0)
 164:	0007c783          	lbu	a5,0(a5)
 168:	fcf709e3          	beq	a4,a5,13a <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 16c:	fe843783          	ld	a5,-24(s0)
 170:	0007c783          	lbu	a5,0(a5)
 174:	0007871b          	sext.w	a4,a5
 178:	fe043783          	ld	a5,-32(s0)
 17c:	0007c783          	lbu	a5,0(a5)
 180:	2781                	sext.w	a5,a5
 182:	40f707bb          	subw	a5,a4,a5
 186:	2781                	sext.w	a5,a5
}
 188:	853e                	mv	a0,a5
 18a:	6462                	ld	s0,24(sp)
 18c:	6105                	addi	sp,sp,32
 18e:	8082                	ret

0000000000000190 <strlen>:

uint
strlen(const char *s)
{
 190:	7179                	addi	sp,sp,-48
 192:	f422                	sd	s0,40(sp)
 194:	1800                	addi	s0,sp,48
 196:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 19a:	fe042623          	sw	zero,-20(s0)
 19e:	a031                	j	1aa <strlen+0x1a>
 1a0:	fec42783          	lw	a5,-20(s0)
 1a4:	2785                	addiw	a5,a5,1
 1a6:	fef42623          	sw	a5,-20(s0)
 1aa:	fec42783          	lw	a5,-20(s0)
 1ae:	fd843703          	ld	a4,-40(s0)
 1b2:	97ba                	add	a5,a5,a4
 1b4:	0007c783          	lbu	a5,0(a5)
 1b8:	f7e5                	bnez	a5,1a0 <strlen+0x10>
    ;
  return n;
 1ba:	fec42783          	lw	a5,-20(s0)
}
 1be:	853e                	mv	a0,a5
 1c0:	7422                	ld	s0,40(sp)
 1c2:	6145                	addi	sp,sp,48
 1c4:	8082                	ret

00000000000001c6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c6:	7179                	addi	sp,sp,-48
 1c8:	f422                	sd	s0,40(sp)
 1ca:	1800                	addi	s0,sp,48
 1cc:	fca43c23          	sd	a0,-40(s0)
 1d0:	87ae                	mv	a5,a1
 1d2:	8732                	mv	a4,a2
 1d4:	fcf42a23          	sw	a5,-44(s0)
 1d8:	87ba                	mv	a5,a4
 1da:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1de:	fd843783          	ld	a5,-40(s0)
 1e2:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1e6:	fe042623          	sw	zero,-20(s0)
 1ea:	a00d                	j	20c <memset+0x46>
    cdst[i] = c;
 1ec:	fec42783          	lw	a5,-20(s0)
 1f0:	fe043703          	ld	a4,-32(s0)
 1f4:	97ba                	add	a5,a5,a4
 1f6:	fd442703          	lw	a4,-44(s0)
 1fa:	0ff77713          	andi	a4,a4,255
 1fe:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 202:	fec42783          	lw	a5,-20(s0)
 206:	2785                	addiw	a5,a5,1
 208:	fef42623          	sw	a5,-20(s0)
 20c:	fec42703          	lw	a4,-20(s0)
 210:	fd042783          	lw	a5,-48(s0)
 214:	2781                	sext.w	a5,a5
 216:	fcf76be3          	bltu	a4,a5,1ec <memset+0x26>
  }
  return dst;
 21a:	fd843783          	ld	a5,-40(s0)
}
 21e:	853e                	mv	a0,a5
 220:	7422                	ld	s0,40(sp)
 222:	6145                	addi	sp,sp,48
 224:	8082                	ret

0000000000000226 <strchr>:

char*
strchr(const char *s, char c)
{
 226:	1101                	addi	sp,sp,-32
 228:	ec22                	sd	s0,24(sp)
 22a:	1000                	addi	s0,sp,32
 22c:	fea43423          	sd	a0,-24(s0)
 230:	87ae                	mv	a5,a1
 232:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 236:	a01d                	j	25c <strchr+0x36>
    if(*s == c)
 238:	fe843783          	ld	a5,-24(s0)
 23c:	0007c703          	lbu	a4,0(a5)
 240:	fe744783          	lbu	a5,-25(s0)
 244:	0ff7f793          	andi	a5,a5,255
 248:	00e79563          	bne	a5,a4,252 <strchr+0x2c>
      return (char*)s;
 24c:	fe843783          	ld	a5,-24(s0)
 250:	a821                	j	268 <strchr+0x42>
  for(; *s; s++)
 252:	fe843783          	ld	a5,-24(s0)
 256:	0785                	addi	a5,a5,1
 258:	fef43423          	sd	a5,-24(s0)
 25c:	fe843783          	ld	a5,-24(s0)
 260:	0007c783          	lbu	a5,0(a5)
 264:	fbf1                	bnez	a5,238 <strchr+0x12>
  return 0;
 266:	4781                	li	a5,0
}
 268:	853e                	mv	a0,a5
 26a:	6462                	ld	s0,24(sp)
 26c:	6105                	addi	sp,sp,32
 26e:	8082                	ret

0000000000000270 <gets>:

char*
gets(char *buf, int max)
{
 270:	7179                	addi	sp,sp,-48
 272:	f406                	sd	ra,40(sp)
 274:	f022                	sd	s0,32(sp)
 276:	1800                	addi	s0,sp,48
 278:	fca43c23          	sd	a0,-40(s0)
 27c:	87ae                	mv	a5,a1
 27e:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 282:	fe042623          	sw	zero,-20(s0)
 286:	a8a1                	j	2de <gets+0x6e>
    cc = read(0, &c, 1);
 288:	fe740793          	addi	a5,s0,-25
 28c:	4605                	li	a2,1
 28e:	85be                	mv	a1,a5
 290:	4501                	li	a0,0
 292:	00000097          	auipc	ra,0x0
 296:	2f6080e7          	jalr	758(ra) # 588 <read>
 29a:	87aa                	mv	a5,a0
 29c:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 2a0:	fe842783          	lw	a5,-24(s0)
 2a4:	2781                	sext.w	a5,a5
 2a6:	04f05763          	blez	a5,2f4 <gets+0x84>
      break;
    buf[i++] = c;
 2aa:	fec42783          	lw	a5,-20(s0)
 2ae:	0017871b          	addiw	a4,a5,1
 2b2:	fee42623          	sw	a4,-20(s0)
 2b6:	873e                	mv	a4,a5
 2b8:	fd843783          	ld	a5,-40(s0)
 2bc:	97ba                	add	a5,a5,a4
 2be:	fe744703          	lbu	a4,-25(s0)
 2c2:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 2c6:	fe744783          	lbu	a5,-25(s0)
 2ca:	873e                	mv	a4,a5
 2cc:	47a9                	li	a5,10
 2ce:	02f70463          	beq	a4,a5,2f6 <gets+0x86>
 2d2:	fe744783          	lbu	a5,-25(s0)
 2d6:	873e                	mv	a4,a5
 2d8:	47b5                	li	a5,13
 2da:	00f70e63          	beq	a4,a5,2f6 <gets+0x86>
  for(i=0; i+1 < max; ){
 2de:	fec42783          	lw	a5,-20(s0)
 2e2:	2785                	addiw	a5,a5,1
 2e4:	0007871b          	sext.w	a4,a5
 2e8:	fd442783          	lw	a5,-44(s0)
 2ec:	2781                	sext.w	a5,a5
 2ee:	f8f74de3          	blt	a4,a5,288 <gets+0x18>
 2f2:	a011                	j	2f6 <gets+0x86>
      break;
 2f4:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2f6:	fec42783          	lw	a5,-20(s0)
 2fa:	fd843703          	ld	a4,-40(s0)
 2fe:	97ba                	add	a5,a5,a4
 300:	00078023          	sb	zero,0(a5)
  return buf;
 304:	fd843783          	ld	a5,-40(s0)
}
 308:	853e                	mv	a0,a5
 30a:	70a2                	ld	ra,40(sp)
 30c:	7402                	ld	s0,32(sp)
 30e:	6145                	addi	sp,sp,48
 310:	8082                	ret

0000000000000312 <stat>:

int
stat(const char *n, struct stat *st)
{
 312:	7179                	addi	sp,sp,-48
 314:	f406                	sd	ra,40(sp)
 316:	f022                	sd	s0,32(sp)
 318:	1800                	addi	s0,sp,48
 31a:	fca43c23          	sd	a0,-40(s0)
 31e:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 322:	4581                	li	a1,0
 324:	fd843503          	ld	a0,-40(s0)
 328:	00000097          	auipc	ra,0x0
 32c:	288080e7          	jalr	648(ra) # 5b0 <open>
 330:	87aa                	mv	a5,a0
 332:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 336:	fec42783          	lw	a5,-20(s0)
 33a:	2781                	sext.w	a5,a5
 33c:	0007d463          	bgez	a5,344 <stat+0x32>
    return -1;
 340:	57fd                	li	a5,-1
 342:	a035                	j	36e <stat+0x5c>
  r = fstat(fd, st);
 344:	fec42783          	lw	a5,-20(s0)
 348:	fd043583          	ld	a1,-48(s0)
 34c:	853e                	mv	a0,a5
 34e:	00000097          	auipc	ra,0x0
 352:	27a080e7          	jalr	634(ra) # 5c8 <fstat>
 356:	87aa                	mv	a5,a0
 358:	fef42423          	sw	a5,-24(s0)
  close(fd);
 35c:	fec42783          	lw	a5,-20(s0)
 360:	853e                	mv	a0,a5
 362:	00000097          	auipc	ra,0x0
 366:	236080e7          	jalr	566(ra) # 598 <close>
  return r;
 36a:	fe842783          	lw	a5,-24(s0)
}
 36e:	853e                	mv	a0,a5
 370:	70a2                	ld	ra,40(sp)
 372:	7402                	ld	s0,32(sp)
 374:	6145                	addi	sp,sp,48
 376:	8082                	ret

0000000000000378 <atoi>:

int
atoi(const char *s)
{
 378:	7179                	addi	sp,sp,-48
 37a:	f422                	sd	s0,40(sp)
 37c:	1800                	addi	s0,sp,48
 37e:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 382:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 386:	a815                	j	3ba <atoi+0x42>
    n = n*10 + *s++ - '0';
 388:	fec42703          	lw	a4,-20(s0)
 38c:	87ba                	mv	a5,a4
 38e:	0027979b          	slliw	a5,a5,0x2
 392:	9fb9                	addw	a5,a5,a4
 394:	0017979b          	slliw	a5,a5,0x1
 398:	0007871b          	sext.w	a4,a5
 39c:	fd843783          	ld	a5,-40(s0)
 3a0:	00178693          	addi	a3,a5,1
 3a4:	fcd43c23          	sd	a3,-40(s0)
 3a8:	0007c783          	lbu	a5,0(a5)
 3ac:	2781                	sext.w	a5,a5
 3ae:	9fb9                	addw	a5,a5,a4
 3b0:	2781                	sext.w	a5,a5
 3b2:	fd07879b          	addiw	a5,a5,-48
 3b6:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 3ba:	fd843783          	ld	a5,-40(s0)
 3be:	0007c783          	lbu	a5,0(a5)
 3c2:	873e                	mv	a4,a5
 3c4:	02f00793          	li	a5,47
 3c8:	00e7fb63          	bgeu	a5,a4,3de <atoi+0x66>
 3cc:	fd843783          	ld	a5,-40(s0)
 3d0:	0007c783          	lbu	a5,0(a5)
 3d4:	873e                	mv	a4,a5
 3d6:	03900793          	li	a5,57
 3da:	fae7f7e3          	bgeu	a5,a4,388 <atoi+0x10>
  return n;
 3de:	fec42783          	lw	a5,-20(s0)
}
 3e2:	853e                	mv	a0,a5
 3e4:	7422                	ld	s0,40(sp)
 3e6:	6145                	addi	sp,sp,48
 3e8:	8082                	ret

00000000000003ea <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3ea:	7139                	addi	sp,sp,-64
 3ec:	fc22                	sd	s0,56(sp)
 3ee:	0080                	addi	s0,sp,64
 3f0:	fca43c23          	sd	a0,-40(s0)
 3f4:	fcb43823          	sd	a1,-48(s0)
 3f8:	87b2                	mv	a5,a2
 3fa:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3fe:	fd843783          	ld	a5,-40(s0)
 402:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 406:	fd043783          	ld	a5,-48(s0)
 40a:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 40e:	fe043703          	ld	a4,-32(s0)
 412:	fe843783          	ld	a5,-24(s0)
 416:	02e7fc63          	bgeu	a5,a4,44e <memmove+0x64>
    while(n-- > 0)
 41a:	a00d                	j	43c <memmove+0x52>
      *dst++ = *src++;
 41c:	fe043703          	ld	a4,-32(s0)
 420:	00170793          	addi	a5,a4,1
 424:	fef43023          	sd	a5,-32(s0)
 428:	fe843783          	ld	a5,-24(s0)
 42c:	00178693          	addi	a3,a5,1
 430:	fed43423          	sd	a3,-24(s0)
 434:	00074703          	lbu	a4,0(a4)
 438:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 43c:	fcc42783          	lw	a5,-52(s0)
 440:	fff7871b          	addiw	a4,a5,-1
 444:	fce42623          	sw	a4,-52(s0)
 448:	fcf04ae3          	bgtz	a5,41c <memmove+0x32>
 44c:	a891                	j	4a0 <memmove+0xb6>
  } else {
    dst += n;
 44e:	fcc42783          	lw	a5,-52(s0)
 452:	fe843703          	ld	a4,-24(s0)
 456:	97ba                	add	a5,a5,a4
 458:	fef43423          	sd	a5,-24(s0)
    src += n;
 45c:	fcc42783          	lw	a5,-52(s0)
 460:	fe043703          	ld	a4,-32(s0)
 464:	97ba                	add	a5,a5,a4
 466:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 46a:	a01d                	j	490 <memmove+0xa6>
      *--dst = *--src;
 46c:	fe043783          	ld	a5,-32(s0)
 470:	17fd                	addi	a5,a5,-1
 472:	fef43023          	sd	a5,-32(s0)
 476:	fe843783          	ld	a5,-24(s0)
 47a:	17fd                	addi	a5,a5,-1
 47c:	fef43423          	sd	a5,-24(s0)
 480:	fe043783          	ld	a5,-32(s0)
 484:	0007c703          	lbu	a4,0(a5)
 488:	fe843783          	ld	a5,-24(s0)
 48c:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 490:	fcc42783          	lw	a5,-52(s0)
 494:	fff7871b          	addiw	a4,a5,-1
 498:	fce42623          	sw	a4,-52(s0)
 49c:	fcf048e3          	bgtz	a5,46c <memmove+0x82>
  }
  return vdst;
 4a0:	fd843783          	ld	a5,-40(s0)
}
 4a4:	853e                	mv	a0,a5
 4a6:	7462                	ld	s0,56(sp)
 4a8:	6121                	addi	sp,sp,64
 4aa:	8082                	ret

00000000000004ac <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4ac:	7139                	addi	sp,sp,-64
 4ae:	fc22                	sd	s0,56(sp)
 4b0:	0080                	addi	s0,sp,64
 4b2:	fca43c23          	sd	a0,-40(s0)
 4b6:	fcb43823          	sd	a1,-48(s0)
 4ba:	87b2                	mv	a5,a2
 4bc:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 4c0:	fd843783          	ld	a5,-40(s0)
 4c4:	fef43423          	sd	a5,-24(s0)
 4c8:	fd043783          	ld	a5,-48(s0)
 4cc:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4d0:	a0a1                	j	518 <memcmp+0x6c>
    if (*p1 != *p2) {
 4d2:	fe843783          	ld	a5,-24(s0)
 4d6:	0007c703          	lbu	a4,0(a5)
 4da:	fe043783          	ld	a5,-32(s0)
 4de:	0007c783          	lbu	a5,0(a5)
 4e2:	02f70163          	beq	a4,a5,504 <memcmp+0x58>
      return *p1 - *p2;
 4e6:	fe843783          	ld	a5,-24(s0)
 4ea:	0007c783          	lbu	a5,0(a5)
 4ee:	0007871b          	sext.w	a4,a5
 4f2:	fe043783          	ld	a5,-32(s0)
 4f6:	0007c783          	lbu	a5,0(a5)
 4fa:	2781                	sext.w	a5,a5
 4fc:	40f707bb          	subw	a5,a4,a5
 500:	2781                	sext.w	a5,a5
 502:	a01d                	j	528 <memcmp+0x7c>
    }
    p1++;
 504:	fe843783          	ld	a5,-24(s0)
 508:	0785                	addi	a5,a5,1
 50a:	fef43423          	sd	a5,-24(s0)
    p2++;
 50e:	fe043783          	ld	a5,-32(s0)
 512:	0785                	addi	a5,a5,1
 514:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 518:	fcc42783          	lw	a5,-52(s0)
 51c:	fff7871b          	addiw	a4,a5,-1
 520:	fce42623          	sw	a4,-52(s0)
 524:	f7dd                	bnez	a5,4d2 <memcmp+0x26>
  }
  return 0;
 526:	4781                	li	a5,0
}
 528:	853e                	mv	a0,a5
 52a:	7462                	ld	s0,56(sp)
 52c:	6121                	addi	sp,sp,64
 52e:	8082                	ret

0000000000000530 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 530:	7179                	addi	sp,sp,-48
 532:	f406                	sd	ra,40(sp)
 534:	f022                	sd	s0,32(sp)
 536:	1800                	addi	s0,sp,48
 538:	fea43423          	sd	a0,-24(s0)
 53c:	feb43023          	sd	a1,-32(s0)
 540:	87b2                	mv	a5,a2
 542:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 546:	fdc42783          	lw	a5,-36(s0)
 54a:	863e                	mv	a2,a5
 54c:	fe043583          	ld	a1,-32(s0)
 550:	fe843503          	ld	a0,-24(s0)
 554:	00000097          	auipc	ra,0x0
 558:	e96080e7          	jalr	-362(ra) # 3ea <memmove>
 55c:	87aa                	mv	a5,a0
}
 55e:	853e                	mv	a0,a5
 560:	70a2                	ld	ra,40(sp)
 562:	7402                	ld	s0,32(sp)
 564:	6145                	addi	sp,sp,48
 566:	8082                	ret

0000000000000568 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 568:	4885                	li	a7,1
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <exit>:
.global exit
exit:
 li a7, SYS_exit
 570:	4889                	li	a7,2
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <wait>:
.global wait
wait:
 li a7, SYS_wait
 578:	488d                	li	a7,3
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 580:	4891                	li	a7,4
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <read>:
.global read
read:
 li a7, SYS_read
 588:	4895                	li	a7,5
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <write>:
.global write
write:
 li a7, SYS_write
 590:	48c1                	li	a7,16
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <close>:
.global close
close:
 li a7, SYS_close
 598:	48d5                	li	a7,21
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5a0:	4899                	li	a7,6
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5a8:	489d                	li	a7,7
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <open>:
.global open
open:
 li a7, SYS_open
 5b0:	48bd                	li	a7,15
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5b8:	48c5                	li	a7,17
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5c0:	48c9                	li	a7,18
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5c8:	48a1                	li	a7,8
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <link>:
.global link
link:
 li a7, SYS_link
 5d0:	48cd                	li	a7,19
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5d8:	48d1                	li	a7,20
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5e0:	48a5                	li	a7,9
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5e8:	48a9                	li	a7,10
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5f0:	48ad                	li	a7,11
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5f8:	48b1                	li	a7,12
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 600:	48b5                	li	a7,13
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 608:	48b9                	li	a7,14
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 610:	48d9                	li	a7,22
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <setpri>:
.global setpri
setpri:
 li a7, SYS_setpri
 618:	48dd                	li	a7,23
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 620:	1101                	addi	sp,sp,-32
 622:	ec06                	sd	ra,24(sp)
 624:	e822                	sd	s0,16(sp)
 626:	1000                	addi	s0,sp,32
 628:	87aa                	mv	a5,a0
 62a:	872e                	mv	a4,a1
 62c:	fef42623          	sw	a5,-20(s0)
 630:	87ba                	mv	a5,a4
 632:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 636:	feb40713          	addi	a4,s0,-21
 63a:	fec42783          	lw	a5,-20(s0)
 63e:	4605                	li	a2,1
 640:	85ba                	mv	a1,a4
 642:	853e                	mv	a0,a5
 644:	00000097          	auipc	ra,0x0
 648:	f4c080e7          	jalr	-180(ra) # 590 <write>
}
 64c:	0001                	nop
 64e:	60e2                	ld	ra,24(sp)
 650:	6442                	ld	s0,16(sp)
 652:	6105                	addi	sp,sp,32
 654:	8082                	ret

0000000000000656 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 656:	7139                	addi	sp,sp,-64
 658:	fc06                	sd	ra,56(sp)
 65a:	f822                	sd	s0,48(sp)
 65c:	0080                	addi	s0,sp,64
 65e:	87aa                	mv	a5,a0
 660:	8736                	mv	a4,a3
 662:	fcf42623          	sw	a5,-52(s0)
 666:	87ae                	mv	a5,a1
 668:	fcf42423          	sw	a5,-56(s0)
 66c:	87b2                	mv	a5,a2
 66e:	fcf42223          	sw	a5,-60(s0)
 672:	87ba                	mv	a5,a4
 674:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 678:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 67c:	fc042783          	lw	a5,-64(s0)
 680:	2781                	sext.w	a5,a5
 682:	c38d                	beqz	a5,6a4 <printint+0x4e>
 684:	fc842783          	lw	a5,-56(s0)
 688:	2781                	sext.w	a5,a5
 68a:	0007dd63          	bgez	a5,6a4 <printint+0x4e>
    neg = 1;
 68e:	4785                	li	a5,1
 690:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 694:	fc842783          	lw	a5,-56(s0)
 698:	40f007bb          	negw	a5,a5
 69c:	2781                	sext.w	a5,a5
 69e:	fef42223          	sw	a5,-28(s0)
 6a2:	a029                	j	6ac <printint+0x56>
  } else {
    x = xx;
 6a4:	fc842783          	lw	a5,-56(s0)
 6a8:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 6ac:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 6b0:	fc442783          	lw	a5,-60(s0)
 6b4:	fe442703          	lw	a4,-28(s0)
 6b8:	02f777bb          	remuw	a5,a4,a5
 6bc:	0007861b          	sext.w	a2,a5
 6c0:	fec42783          	lw	a5,-20(s0)
 6c4:	0017871b          	addiw	a4,a5,1
 6c8:	fee42623          	sw	a4,-20(s0)
 6cc:	00000697          	auipc	a3,0x0
 6d0:	77c68693          	addi	a3,a3,1916 # e48 <digits>
 6d4:	02061713          	slli	a4,a2,0x20
 6d8:	9301                	srli	a4,a4,0x20
 6da:	9736                	add	a4,a4,a3
 6dc:	00074703          	lbu	a4,0(a4)
 6e0:	ff040693          	addi	a3,s0,-16
 6e4:	97b6                	add	a5,a5,a3
 6e6:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 6ea:	fc442783          	lw	a5,-60(s0)
 6ee:	fe442703          	lw	a4,-28(s0)
 6f2:	02f757bb          	divuw	a5,a4,a5
 6f6:	fef42223          	sw	a5,-28(s0)
 6fa:	fe442783          	lw	a5,-28(s0)
 6fe:	2781                	sext.w	a5,a5
 700:	fbc5                	bnez	a5,6b0 <printint+0x5a>
  if(neg)
 702:	fe842783          	lw	a5,-24(s0)
 706:	2781                	sext.w	a5,a5
 708:	cf95                	beqz	a5,744 <printint+0xee>
    buf[i++] = '-';
 70a:	fec42783          	lw	a5,-20(s0)
 70e:	0017871b          	addiw	a4,a5,1
 712:	fee42623          	sw	a4,-20(s0)
 716:	ff040713          	addi	a4,s0,-16
 71a:	97ba                	add	a5,a5,a4
 71c:	02d00713          	li	a4,45
 720:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 724:	a005                	j	744 <printint+0xee>
    putc(fd, buf[i]);
 726:	fec42783          	lw	a5,-20(s0)
 72a:	ff040713          	addi	a4,s0,-16
 72e:	97ba                	add	a5,a5,a4
 730:	fe07c703          	lbu	a4,-32(a5)
 734:	fcc42783          	lw	a5,-52(s0)
 738:	85ba                	mv	a1,a4
 73a:	853e                	mv	a0,a5
 73c:	00000097          	auipc	ra,0x0
 740:	ee4080e7          	jalr	-284(ra) # 620 <putc>
  while(--i >= 0)
 744:	fec42783          	lw	a5,-20(s0)
 748:	37fd                	addiw	a5,a5,-1
 74a:	fef42623          	sw	a5,-20(s0)
 74e:	fec42783          	lw	a5,-20(s0)
 752:	2781                	sext.w	a5,a5
 754:	fc07d9e3          	bgez	a5,726 <printint+0xd0>
}
 758:	0001                	nop
 75a:	0001                	nop
 75c:	70e2                	ld	ra,56(sp)
 75e:	7442                	ld	s0,48(sp)
 760:	6121                	addi	sp,sp,64
 762:	8082                	ret

0000000000000764 <printptr>:

static void
printptr(int fd, uint64 x) {
 764:	7179                	addi	sp,sp,-48
 766:	f406                	sd	ra,40(sp)
 768:	f022                	sd	s0,32(sp)
 76a:	1800                	addi	s0,sp,48
 76c:	87aa                	mv	a5,a0
 76e:	fcb43823          	sd	a1,-48(s0)
 772:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 776:	fdc42783          	lw	a5,-36(s0)
 77a:	03000593          	li	a1,48
 77e:	853e                	mv	a0,a5
 780:	00000097          	auipc	ra,0x0
 784:	ea0080e7          	jalr	-352(ra) # 620 <putc>
  putc(fd, 'x');
 788:	fdc42783          	lw	a5,-36(s0)
 78c:	07800593          	li	a1,120
 790:	853e                	mv	a0,a5
 792:	00000097          	auipc	ra,0x0
 796:	e8e080e7          	jalr	-370(ra) # 620 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 79a:	fe042623          	sw	zero,-20(s0)
 79e:	a82d                	j	7d8 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7a0:	fd043783          	ld	a5,-48(s0)
 7a4:	93f1                	srli	a5,a5,0x3c
 7a6:	00000717          	auipc	a4,0x0
 7aa:	6a270713          	addi	a4,a4,1698 # e48 <digits>
 7ae:	97ba                	add	a5,a5,a4
 7b0:	0007c703          	lbu	a4,0(a5)
 7b4:	fdc42783          	lw	a5,-36(s0)
 7b8:	85ba                	mv	a1,a4
 7ba:	853e                	mv	a0,a5
 7bc:	00000097          	auipc	ra,0x0
 7c0:	e64080e7          	jalr	-412(ra) # 620 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7c4:	fec42783          	lw	a5,-20(s0)
 7c8:	2785                	addiw	a5,a5,1
 7ca:	fef42623          	sw	a5,-20(s0)
 7ce:	fd043783          	ld	a5,-48(s0)
 7d2:	0792                	slli	a5,a5,0x4
 7d4:	fcf43823          	sd	a5,-48(s0)
 7d8:	fec42783          	lw	a5,-20(s0)
 7dc:	873e                	mv	a4,a5
 7de:	47bd                	li	a5,15
 7e0:	fce7f0e3          	bgeu	a5,a4,7a0 <printptr+0x3c>
}
 7e4:	0001                	nop
 7e6:	0001                	nop
 7e8:	70a2                	ld	ra,40(sp)
 7ea:	7402                	ld	s0,32(sp)
 7ec:	6145                	addi	sp,sp,48
 7ee:	8082                	ret

00000000000007f0 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7f0:	715d                	addi	sp,sp,-80
 7f2:	e486                	sd	ra,72(sp)
 7f4:	e0a2                	sd	s0,64(sp)
 7f6:	0880                	addi	s0,sp,80
 7f8:	87aa                	mv	a5,a0
 7fa:	fcb43023          	sd	a1,-64(s0)
 7fe:	fac43c23          	sd	a2,-72(s0)
 802:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 806:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 80a:	fe042223          	sw	zero,-28(s0)
 80e:	a42d                	j	a38 <vprintf+0x248>
    c = fmt[i] & 0xff;
 810:	fe442783          	lw	a5,-28(s0)
 814:	fc043703          	ld	a4,-64(s0)
 818:	97ba                	add	a5,a5,a4
 81a:	0007c783          	lbu	a5,0(a5)
 81e:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 822:	fe042783          	lw	a5,-32(s0)
 826:	2781                	sext.w	a5,a5
 828:	eb9d                	bnez	a5,85e <vprintf+0x6e>
      if(c == '%'){
 82a:	fdc42783          	lw	a5,-36(s0)
 82e:	0007871b          	sext.w	a4,a5
 832:	02500793          	li	a5,37
 836:	00f71763          	bne	a4,a5,844 <vprintf+0x54>
        state = '%';
 83a:	02500793          	li	a5,37
 83e:	fef42023          	sw	a5,-32(s0)
 842:	a2f5                	j	a2e <vprintf+0x23e>
      } else {
        putc(fd, c);
 844:	fdc42783          	lw	a5,-36(s0)
 848:	0ff7f713          	andi	a4,a5,255
 84c:	fcc42783          	lw	a5,-52(s0)
 850:	85ba                	mv	a1,a4
 852:	853e                	mv	a0,a5
 854:	00000097          	auipc	ra,0x0
 858:	dcc080e7          	jalr	-564(ra) # 620 <putc>
 85c:	aac9                	j	a2e <vprintf+0x23e>
      }
    } else if(state == '%'){
 85e:	fe042783          	lw	a5,-32(s0)
 862:	0007871b          	sext.w	a4,a5
 866:	02500793          	li	a5,37
 86a:	1cf71263          	bne	a4,a5,a2e <vprintf+0x23e>
      if(c == 'd'){
 86e:	fdc42783          	lw	a5,-36(s0)
 872:	0007871b          	sext.w	a4,a5
 876:	06400793          	li	a5,100
 87a:	02f71463          	bne	a4,a5,8a2 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 87e:	fb843783          	ld	a5,-72(s0)
 882:	00878713          	addi	a4,a5,8
 886:	fae43c23          	sd	a4,-72(s0)
 88a:	4398                	lw	a4,0(a5)
 88c:	fcc42783          	lw	a5,-52(s0)
 890:	4685                	li	a3,1
 892:	4629                	li	a2,10
 894:	85ba                	mv	a1,a4
 896:	853e                	mv	a0,a5
 898:	00000097          	auipc	ra,0x0
 89c:	dbe080e7          	jalr	-578(ra) # 656 <printint>
 8a0:	a269                	j	a2a <vprintf+0x23a>
      } else if(c == 'l') {
 8a2:	fdc42783          	lw	a5,-36(s0)
 8a6:	0007871b          	sext.w	a4,a5
 8aa:	06c00793          	li	a5,108
 8ae:	02f71663          	bne	a4,a5,8da <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8b2:	fb843783          	ld	a5,-72(s0)
 8b6:	00878713          	addi	a4,a5,8
 8ba:	fae43c23          	sd	a4,-72(s0)
 8be:	639c                	ld	a5,0(a5)
 8c0:	0007871b          	sext.w	a4,a5
 8c4:	fcc42783          	lw	a5,-52(s0)
 8c8:	4681                	li	a3,0
 8ca:	4629                	li	a2,10
 8cc:	85ba                	mv	a1,a4
 8ce:	853e                	mv	a0,a5
 8d0:	00000097          	auipc	ra,0x0
 8d4:	d86080e7          	jalr	-634(ra) # 656 <printint>
 8d8:	aa89                	j	a2a <vprintf+0x23a>
      } else if(c == 'x') {
 8da:	fdc42783          	lw	a5,-36(s0)
 8de:	0007871b          	sext.w	a4,a5
 8e2:	07800793          	li	a5,120
 8e6:	02f71463          	bne	a4,a5,90e <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 8ea:	fb843783          	ld	a5,-72(s0)
 8ee:	00878713          	addi	a4,a5,8
 8f2:	fae43c23          	sd	a4,-72(s0)
 8f6:	4398                	lw	a4,0(a5)
 8f8:	fcc42783          	lw	a5,-52(s0)
 8fc:	4681                	li	a3,0
 8fe:	4641                	li	a2,16
 900:	85ba                	mv	a1,a4
 902:	853e                	mv	a0,a5
 904:	00000097          	auipc	ra,0x0
 908:	d52080e7          	jalr	-686(ra) # 656 <printint>
 90c:	aa39                	j	a2a <vprintf+0x23a>
      } else if(c == 'p') {
 90e:	fdc42783          	lw	a5,-36(s0)
 912:	0007871b          	sext.w	a4,a5
 916:	07000793          	li	a5,112
 91a:	02f71263          	bne	a4,a5,93e <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 91e:	fb843783          	ld	a5,-72(s0)
 922:	00878713          	addi	a4,a5,8
 926:	fae43c23          	sd	a4,-72(s0)
 92a:	6398                	ld	a4,0(a5)
 92c:	fcc42783          	lw	a5,-52(s0)
 930:	85ba                	mv	a1,a4
 932:	853e                	mv	a0,a5
 934:	00000097          	auipc	ra,0x0
 938:	e30080e7          	jalr	-464(ra) # 764 <printptr>
 93c:	a0fd                	j	a2a <vprintf+0x23a>
      } else if(c == 's'){
 93e:	fdc42783          	lw	a5,-36(s0)
 942:	0007871b          	sext.w	a4,a5
 946:	07300793          	li	a5,115
 94a:	04f71c63          	bne	a4,a5,9a2 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 94e:	fb843783          	ld	a5,-72(s0)
 952:	00878713          	addi	a4,a5,8
 956:	fae43c23          	sd	a4,-72(s0)
 95a:	639c                	ld	a5,0(a5)
 95c:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 960:	fe843783          	ld	a5,-24(s0)
 964:	eb8d                	bnez	a5,996 <vprintf+0x1a6>
          s = "(null)";
 966:	00000797          	auipc	a5,0x0
 96a:	4da78793          	addi	a5,a5,1242 # e40 <malloc+0x1a0>
 96e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 972:	a015                	j	996 <vprintf+0x1a6>
          putc(fd, *s);
 974:	fe843783          	ld	a5,-24(s0)
 978:	0007c703          	lbu	a4,0(a5)
 97c:	fcc42783          	lw	a5,-52(s0)
 980:	85ba                	mv	a1,a4
 982:	853e                	mv	a0,a5
 984:	00000097          	auipc	ra,0x0
 988:	c9c080e7          	jalr	-868(ra) # 620 <putc>
          s++;
 98c:	fe843783          	ld	a5,-24(s0)
 990:	0785                	addi	a5,a5,1
 992:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 996:	fe843783          	ld	a5,-24(s0)
 99a:	0007c783          	lbu	a5,0(a5)
 99e:	fbf9                	bnez	a5,974 <vprintf+0x184>
 9a0:	a069                	j	a2a <vprintf+0x23a>
        }
      } else if(c == 'c'){
 9a2:	fdc42783          	lw	a5,-36(s0)
 9a6:	0007871b          	sext.w	a4,a5
 9aa:	06300793          	li	a5,99
 9ae:	02f71463          	bne	a4,a5,9d6 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 9b2:	fb843783          	ld	a5,-72(s0)
 9b6:	00878713          	addi	a4,a5,8
 9ba:	fae43c23          	sd	a4,-72(s0)
 9be:	439c                	lw	a5,0(a5)
 9c0:	0ff7f713          	andi	a4,a5,255
 9c4:	fcc42783          	lw	a5,-52(s0)
 9c8:	85ba                	mv	a1,a4
 9ca:	853e                	mv	a0,a5
 9cc:	00000097          	auipc	ra,0x0
 9d0:	c54080e7          	jalr	-940(ra) # 620 <putc>
 9d4:	a899                	j	a2a <vprintf+0x23a>
      } else if(c == '%'){
 9d6:	fdc42783          	lw	a5,-36(s0)
 9da:	0007871b          	sext.w	a4,a5
 9de:	02500793          	li	a5,37
 9e2:	00f71f63          	bne	a4,a5,a00 <vprintf+0x210>
        putc(fd, c);
 9e6:	fdc42783          	lw	a5,-36(s0)
 9ea:	0ff7f713          	andi	a4,a5,255
 9ee:	fcc42783          	lw	a5,-52(s0)
 9f2:	85ba                	mv	a1,a4
 9f4:	853e                	mv	a0,a5
 9f6:	00000097          	auipc	ra,0x0
 9fa:	c2a080e7          	jalr	-982(ra) # 620 <putc>
 9fe:	a035                	j	a2a <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a00:	fcc42783          	lw	a5,-52(s0)
 a04:	02500593          	li	a1,37
 a08:	853e                	mv	a0,a5
 a0a:	00000097          	auipc	ra,0x0
 a0e:	c16080e7          	jalr	-1002(ra) # 620 <putc>
        putc(fd, c);
 a12:	fdc42783          	lw	a5,-36(s0)
 a16:	0ff7f713          	andi	a4,a5,255
 a1a:	fcc42783          	lw	a5,-52(s0)
 a1e:	85ba                	mv	a1,a4
 a20:	853e                	mv	a0,a5
 a22:	00000097          	auipc	ra,0x0
 a26:	bfe080e7          	jalr	-1026(ra) # 620 <putc>
      }
      state = 0;
 a2a:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 a2e:	fe442783          	lw	a5,-28(s0)
 a32:	2785                	addiw	a5,a5,1
 a34:	fef42223          	sw	a5,-28(s0)
 a38:	fe442783          	lw	a5,-28(s0)
 a3c:	fc043703          	ld	a4,-64(s0)
 a40:	97ba                	add	a5,a5,a4
 a42:	0007c783          	lbu	a5,0(a5)
 a46:	dc0795e3          	bnez	a5,810 <vprintf+0x20>
    }
  }
}
 a4a:	0001                	nop
 a4c:	0001                	nop
 a4e:	60a6                	ld	ra,72(sp)
 a50:	6406                	ld	s0,64(sp)
 a52:	6161                	addi	sp,sp,80
 a54:	8082                	ret

0000000000000a56 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a56:	7159                	addi	sp,sp,-112
 a58:	fc06                	sd	ra,56(sp)
 a5a:	f822                	sd	s0,48(sp)
 a5c:	0080                	addi	s0,sp,64
 a5e:	fcb43823          	sd	a1,-48(s0)
 a62:	e010                	sd	a2,0(s0)
 a64:	e414                	sd	a3,8(s0)
 a66:	e818                	sd	a4,16(s0)
 a68:	ec1c                	sd	a5,24(s0)
 a6a:	03043023          	sd	a6,32(s0)
 a6e:	03143423          	sd	a7,40(s0)
 a72:	87aa                	mv	a5,a0
 a74:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a78:	03040793          	addi	a5,s0,48
 a7c:	fcf43423          	sd	a5,-56(s0)
 a80:	fc843783          	ld	a5,-56(s0)
 a84:	fd078793          	addi	a5,a5,-48
 a88:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a8c:	fe843703          	ld	a4,-24(s0)
 a90:	fdc42783          	lw	a5,-36(s0)
 a94:	863a                	mv	a2,a4
 a96:	fd043583          	ld	a1,-48(s0)
 a9a:	853e                	mv	a0,a5
 a9c:	00000097          	auipc	ra,0x0
 aa0:	d54080e7          	jalr	-684(ra) # 7f0 <vprintf>
}
 aa4:	0001                	nop
 aa6:	70e2                	ld	ra,56(sp)
 aa8:	7442                	ld	s0,48(sp)
 aaa:	6165                	addi	sp,sp,112
 aac:	8082                	ret

0000000000000aae <printf>:

void
printf(const char *fmt, ...)
{
 aae:	7159                	addi	sp,sp,-112
 ab0:	f406                	sd	ra,40(sp)
 ab2:	f022                	sd	s0,32(sp)
 ab4:	1800                	addi	s0,sp,48
 ab6:	fca43c23          	sd	a0,-40(s0)
 aba:	e40c                	sd	a1,8(s0)
 abc:	e810                	sd	a2,16(s0)
 abe:	ec14                	sd	a3,24(s0)
 ac0:	f018                	sd	a4,32(s0)
 ac2:	f41c                	sd	a5,40(s0)
 ac4:	03043823          	sd	a6,48(s0)
 ac8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 acc:	04040793          	addi	a5,s0,64
 ad0:	fcf43823          	sd	a5,-48(s0)
 ad4:	fd043783          	ld	a5,-48(s0)
 ad8:	fc878793          	addi	a5,a5,-56
 adc:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 ae0:	fe843783          	ld	a5,-24(s0)
 ae4:	863e                	mv	a2,a5
 ae6:	fd843583          	ld	a1,-40(s0)
 aea:	4505                	li	a0,1
 aec:	00000097          	auipc	ra,0x0
 af0:	d04080e7          	jalr	-764(ra) # 7f0 <vprintf>
}
 af4:	0001                	nop
 af6:	70a2                	ld	ra,40(sp)
 af8:	7402                	ld	s0,32(sp)
 afa:	6165                	addi	sp,sp,112
 afc:	8082                	ret

0000000000000afe <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 afe:	7179                	addi	sp,sp,-48
 b00:	f422                	sd	s0,40(sp)
 b02:	1800                	addi	s0,sp,48
 b04:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b08:	fd843783          	ld	a5,-40(s0)
 b0c:	17c1                	addi	a5,a5,-16
 b0e:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b12:	00000797          	auipc	a5,0x0
 b16:	35e78793          	addi	a5,a5,862 # e70 <freep>
 b1a:	639c                	ld	a5,0(a5)
 b1c:	fef43423          	sd	a5,-24(s0)
 b20:	a815                	j	b54 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b22:	fe843783          	ld	a5,-24(s0)
 b26:	639c                	ld	a5,0(a5)
 b28:	fe843703          	ld	a4,-24(s0)
 b2c:	00f76f63          	bltu	a4,a5,b4a <free+0x4c>
 b30:	fe043703          	ld	a4,-32(s0)
 b34:	fe843783          	ld	a5,-24(s0)
 b38:	02e7eb63          	bltu	a5,a4,b6e <free+0x70>
 b3c:	fe843783          	ld	a5,-24(s0)
 b40:	639c                	ld	a5,0(a5)
 b42:	fe043703          	ld	a4,-32(s0)
 b46:	02f76463          	bltu	a4,a5,b6e <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b4a:	fe843783          	ld	a5,-24(s0)
 b4e:	639c                	ld	a5,0(a5)
 b50:	fef43423          	sd	a5,-24(s0)
 b54:	fe043703          	ld	a4,-32(s0)
 b58:	fe843783          	ld	a5,-24(s0)
 b5c:	fce7f3e3          	bgeu	a5,a4,b22 <free+0x24>
 b60:	fe843783          	ld	a5,-24(s0)
 b64:	639c                	ld	a5,0(a5)
 b66:	fe043703          	ld	a4,-32(s0)
 b6a:	faf77ce3          	bgeu	a4,a5,b22 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b6e:	fe043783          	ld	a5,-32(s0)
 b72:	479c                	lw	a5,8(a5)
 b74:	1782                	slli	a5,a5,0x20
 b76:	9381                	srli	a5,a5,0x20
 b78:	0792                	slli	a5,a5,0x4
 b7a:	fe043703          	ld	a4,-32(s0)
 b7e:	973e                	add	a4,a4,a5
 b80:	fe843783          	ld	a5,-24(s0)
 b84:	639c                	ld	a5,0(a5)
 b86:	02f71763          	bne	a4,a5,bb4 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b8a:	fe043783          	ld	a5,-32(s0)
 b8e:	4798                	lw	a4,8(a5)
 b90:	fe843783          	ld	a5,-24(s0)
 b94:	639c                	ld	a5,0(a5)
 b96:	479c                	lw	a5,8(a5)
 b98:	9fb9                	addw	a5,a5,a4
 b9a:	0007871b          	sext.w	a4,a5
 b9e:	fe043783          	ld	a5,-32(s0)
 ba2:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 ba4:	fe843783          	ld	a5,-24(s0)
 ba8:	639c                	ld	a5,0(a5)
 baa:	6398                	ld	a4,0(a5)
 bac:	fe043783          	ld	a5,-32(s0)
 bb0:	e398                	sd	a4,0(a5)
 bb2:	a039                	j	bc0 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 bb4:	fe843783          	ld	a5,-24(s0)
 bb8:	6398                	ld	a4,0(a5)
 bba:	fe043783          	ld	a5,-32(s0)
 bbe:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 bc0:	fe843783          	ld	a5,-24(s0)
 bc4:	479c                	lw	a5,8(a5)
 bc6:	1782                	slli	a5,a5,0x20
 bc8:	9381                	srli	a5,a5,0x20
 bca:	0792                	slli	a5,a5,0x4
 bcc:	fe843703          	ld	a4,-24(s0)
 bd0:	97ba                	add	a5,a5,a4
 bd2:	fe043703          	ld	a4,-32(s0)
 bd6:	02f71563          	bne	a4,a5,c00 <free+0x102>
    p->s.size += bp->s.size;
 bda:	fe843783          	ld	a5,-24(s0)
 bde:	4798                	lw	a4,8(a5)
 be0:	fe043783          	ld	a5,-32(s0)
 be4:	479c                	lw	a5,8(a5)
 be6:	9fb9                	addw	a5,a5,a4
 be8:	0007871b          	sext.w	a4,a5
 bec:	fe843783          	ld	a5,-24(s0)
 bf0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bf2:	fe043783          	ld	a5,-32(s0)
 bf6:	6398                	ld	a4,0(a5)
 bf8:	fe843783          	ld	a5,-24(s0)
 bfc:	e398                	sd	a4,0(a5)
 bfe:	a031                	j	c0a <free+0x10c>
  } else
    p->s.ptr = bp;
 c00:	fe843783          	ld	a5,-24(s0)
 c04:	fe043703          	ld	a4,-32(s0)
 c08:	e398                	sd	a4,0(a5)
  freep = p;
 c0a:	00000797          	auipc	a5,0x0
 c0e:	26678793          	addi	a5,a5,614 # e70 <freep>
 c12:	fe843703          	ld	a4,-24(s0)
 c16:	e398                	sd	a4,0(a5)
}
 c18:	0001                	nop
 c1a:	7422                	ld	s0,40(sp)
 c1c:	6145                	addi	sp,sp,48
 c1e:	8082                	ret

0000000000000c20 <morecore>:

static Header*
morecore(uint nu)
{
 c20:	7179                	addi	sp,sp,-48
 c22:	f406                	sd	ra,40(sp)
 c24:	f022                	sd	s0,32(sp)
 c26:	1800                	addi	s0,sp,48
 c28:	87aa                	mv	a5,a0
 c2a:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 c2e:	fdc42783          	lw	a5,-36(s0)
 c32:	0007871b          	sext.w	a4,a5
 c36:	6785                	lui	a5,0x1
 c38:	00f77563          	bgeu	a4,a5,c42 <morecore+0x22>
    nu = 4096;
 c3c:	6785                	lui	a5,0x1
 c3e:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c42:	fdc42783          	lw	a5,-36(s0)
 c46:	0047979b          	slliw	a5,a5,0x4
 c4a:	2781                	sext.w	a5,a5
 c4c:	2781                	sext.w	a5,a5
 c4e:	853e                	mv	a0,a5
 c50:	00000097          	auipc	ra,0x0
 c54:	9a8080e7          	jalr	-1624(ra) # 5f8 <sbrk>
 c58:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c5c:	fe843703          	ld	a4,-24(s0)
 c60:	57fd                	li	a5,-1
 c62:	00f71463          	bne	a4,a5,c6a <morecore+0x4a>
    return 0;
 c66:	4781                	li	a5,0
 c68:	a03d                	j	c96 <morecore+0x76>
  hp = (Header*)p;
 c6a:	fe843783          	ld	a5,-24(s0)
 c6e:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c72:	fe043783          	ld	a5,-32(s0)
 c76:	fdc42703          	lw	a4,-36(s0)
 c7a:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c7c:	fe043783          	ld	a5,-32(s0)
 c80:	07c1                	addi	a5,a5,16
 c82:	853e                	mv	a0,a5
 c84:	00000097          	auipc	ra,0x0
 c88:	e7a080e7          	jalr	-390(ra) # afe <free>
  return freep;
 c8c:	00000797          	auipc	a5,0x0
 c90:	1e478793          	addi	a5,a5,484 # e70 <freep>
 c94:	639c                	ld	a5,0(a5)
}
 c96:	853e                	mv	a0,a5
 c98:	70a2                	ld	ra,40(sp)
 c9a:	7402                	ld	s0,32(sp)
 c9c:	6145                	addi	sp,sp,48
 c9e:	8082                	ret

0000000000000ca0 <malloc>:

void*
malloc(uint nbytes)
{
 ca0:	7139                	addi	sp,sp,-64
 ca2:	fc06                	sd	ra,56(sp)
 ca4:	f822                	sd	s0,48(sp)
 ca6:	0080                	addi	s0,sp,64
 ca8:	87aa                	mv	a5,a0
 caa:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 cae:	fcc46783          	lwu	a5,-52(s0)
 cb2:	07bd                	addi	a5,a5,15
 cb4:	8391                	srli	a5,a5,0x4
 cb6:	2781                	sext.w	a5,a5
 cb8:	2785                	addiw	a5,a5,1
 cba:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 cbe:	00000797          	auipc	a5,0x0
 cc2:	1b278793          	addi	a5,a5,434 # e70 <freep>
 cc6:	639c                	ld	a5,0(a5)
 cc8:	fef43023          	sd	a5,-32(s0)
 ccc:	fe043783          	ld	a5,-32(s0)
 cd0:	ef95                	bnez	a5,d0c <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 cd2:	00000797          	auipc	a5,0x0
 cd6:	18e78793          	addi	a5,a5,398 # e60 <base>
 cda:	fef43023          	sd	a5,-32(s0)
 cde:	00000797          	auipc	a5,0x0
 ce2:	19278793          	addi	a5,a5,402 # e70 <freep>
 ce6:	fe043703          	ld	a4,-32(s0)
 cea:	e398                	sd	a4,0(a5)
 cec:	00000797          	auipc	a5,0x0
 cf0:	18478793          	addi	a5,a5,388 # e70 <freep>
 cf4:	6398                	ld	a4,0(a5)
 cf6:	00000797          	auipc	a5,0x0
 cfa:	16a78793          	addi	a5,a5,362 # e60 <base>
 cfe:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 d00:	00000797          	auipc	a5,0x0
 d04:	16078793          	addi	a5,a5,352 # e60 <base>
 d08:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d0c:	fe043783          	ld	a5,-32(s0)
 d10:	639c                	ld	a5,0(a5)
 d12:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d16:	fe843783          	ld	a5,-24(s0)
 d1a:	4798                	lw	a4,8(a5)
 d1c:	fdc42783          	lw	a5,-36(s0)
 d20:	2781                	sext.w	a5,a5
 d22:	06f76863          	bltu	a4,a5,d92 <malloc+0xf2>
      if(p->s.size == nunits)
 d26:	fe843783          	ld	a5,-24(s0)
 d2a:	4798                	lw	a4,8(a5)
 d2c:	fdc42783          	lw	a5,-36(s0)
 d30:	2781                	sext.w	a5,a5
 d32:	00e79963          	bne	a5,a4,d44 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d36:	fe843783          	ld	a5,-24(s0)
 d3a:	6398                	ld	a4,0(a5)
 d3c:	fe043783          	ld	a5,-32(s0)
 d40:	e398                	sd	a4,0(a5)
 d42:	a82d                	j	d7c <malloc+0xdc>
      else {
        p->s.size -= nunits;
 d44:	fe843783          	ld	a5,-24(s0)
 d48:	4798                	lw	a4,8(a5)
 d4a:	fdc42783          	lw	a5,-36(s0)
 d4e:	40f707bb          	subw	a5,a4,a5
 d52:	0007871b          	sext.w	a4,a5
 d56:	fe843783          	ld	a5,-24(s0)
 d5a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d5c:	fe843783          	ld	a5,-24(s0)
 d60:	479c                	lw	a5,8(a5)
 d62:	1782                	slli	a5,a5,0x20
 d64:	9381                	srli	a5,a5,0x20
 d66:	0792                	slli	a5,a5,0x4
 d68:	fe843703          	ld	a4,-24(s0)
 d6c:	97ba                	add	a5,a5,a4
 d6e:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d72:	fe843783          	ld	a5,-24(s0)
 d76:	fdc42703          	lw	a4,-36(s0)
 d7a:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d7c:	00000797          	auipc	a5,0x0
 d80:	0f478793          	addi	a5,a5,244 # e70 <freep>
 d84:	fe043703          	ld	a4,-32(s0)
 d88:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d8a:	fe843783          	ld	a5,-24(s0)
 d8e:	07c1                	addi	a5,a5,16
 d90:	a091                	j	dd4 <malloc+0x134>
    }
    if(p == freep)
 d92:	00000797          	auipc	a5,0x0
 d96:	0de78793          	addi	a5,a5,222 # e70 <freep>
 d9a:	639c                	ld	a5,0(a5)
 d9c:	fe843703          	ld	a4,-24(s0)
 da0:	02f71063          	bne	a4,a5,dc0 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 da4:	fdc42783          	lw	a5,-36(s0)
 da8:	853e                	mv	a0,a5
 daa:	00000097          	auipc	ra,0x0
 dae:	e76080e7          	jalr	-394(ra) # c20 <morecore>
 db2:	fea43423          	sd	a0,-24(s0)
 db6:	fe843783          	ld	a5,-24(s0)
 dba:	e399                	bnez	a5,dc0 <malloc+0x120>
        return 0;
 dbc:	4781                	li	a5,0
 dbe:	a819                	j	dd4 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dc0:	fe843783          	ld	a5,-24(s0)
 dc4:	fef43023          	sd	a5,-32(s0)
 dc8:	fe843783          	ld	a5,-24(s0)
 dcc:	639c                	ld	a5,0(a5)
 dce:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 dd2:	b791                	j	d16 <malloc+0x76>
  }
}
 dd4:	853e                	mv	a0,a5
 dd6:	70e2                	ld	ra,56(sp)
 dd8:	7442                	ld	s0,48(sp)
 dda:	6121                	addi	sp,sp,64
 ddc:	8082                	ret
