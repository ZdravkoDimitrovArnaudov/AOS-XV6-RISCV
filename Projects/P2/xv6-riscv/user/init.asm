
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   8:	4589                	li	a1,2
   a:	00001517          	auipc	a0,0x1
   e:	e1e50513          	addi	a0,a0,-482 # e28 <malloc+0x14a>
  12:	00000097          	auipc	ra,0x0
  16:	5dc080e7          	jalr	1500(ra) # 5ee <open>
  1a:	87aa                	mv	a5,a0
  1c:	0207d563          	bgez	a5,46 <main+0x46>
    mknod("console", CONSOLE, 0);
  20:	4601                	li	a2,0
  22:	4585                	li	a1,1
  24:	00001517          	auipc	a0,0x1
  28:	e0450513          	addi	a0,a0,-508 # e28 <malloc+0x14a>
  2c:	00000097          	auipc	ra,0x0
  30:	5ca080e7          	jalr	1482(ra) # 5f6 <mknod>
    open("console", O_RDWR);
  34:	4589                	li	a1,2
  36:	00001517          	auipc	a0,0x1
  3a:	df250513          	addi	a0,a0,-526 # e28 <malloc+0x14a>
  3e:	00000097          	auipc	ra,0x0
  42:	5b0080e7          	jalr	1456(ra) # 5ee <open>
  }
  dup(0);  // stdout
  46:	4501                	li	a0,0
  48:	00000097          	auipc	ra,0x0
  4c:	5de080e7          	jalr	1502(ra) # 626 <dup>
  dup(0);  // stderr
  50:	4501                	li	a0,0
  52:	00000097          	auipc	ra,0x0
  56:	5d4080e7          	jalr	1492(ra) # 626 <dup>

  for(;;){
    printf("init: starting sh\n");
  5a:	00001517          	auipc	a0,0x1
  5e:	dd650513          	addi	a0,a0,-554 # e30 <malloc+0x152>
  62:	00001097          	auipc	ra,0x1
  66:	a8a080e7          	jalr	-1398(ra) # aec <printf>
    pid = fork();
  6a:	00000097          	auipc	ra,0x0
  6e:	53c080e7          	jalr	1340(ra) # 5a6 <fork>
  72:	87aa                	mv	a5,a0
  74:	fef42623          	sw	a5,-20(s0)
    if(pid < 0){
  78:	fec42783          	lw	a5,-20(s0)
  7c:	2781                	sext.w	a5,a5
  7e:	0007df63          	bgez	a5,9c <main+0x9c>
      printf("init: fork failed\n");
  82:	00001517          	auipc	a0,0x1
  86:	dc650513          	addi	a0,a0,-570 # e48 <malloc+0x16a>
  8a:	00001097          	auipc	ra,0x1
  8e:	a62080e7          	jalr	-1438(ra) # aec <printf>
      exit(1);
  92:	4505                	li	a0,1
  94:	00000097          	auipc	ra,0x0
  98:	51a080e7          	jalr	1306(ra) # 5ae <exit>
    }
    if(pid == 0){
  9c:	fec42783          	lw	a5,-20(s0)
  a0:	2781                	sext.w	a5,a5
  a2:	eb95                	bnez	a5,d6 <main+0xd6>
      exec("sh", argv);
  a4:	00001597          	auipc	a1,0x1
  a8:	dfc58593          	addi	a1,a1,-516 # ea0 <argv>
  ac:	00001517          	auipc	a0,0x1
  b0:	d7450513          	addi	a0,a0,-652 # e20 <malloc+0x142>
  b4:	00000097          	auipc	ra,0x0
  b8:	532080e7          	jalr	1330(ra) # 5e6 <exec>
      printf("init: exec sh failed\n");
  bc:	00001517          	auipc	a0,0x1
  c0:	da450513          	addi	a0,a0,-604 # e60 <malloc+0x182>
  c4:	00001097          	auipc	ra,0x1
  c8:	a28080e7          	jalr	-1496(ra) # aec <printf>
      exit(1);
  cc:	4505                	li	a0,1
  ce:	00000097          	auipc	ra,0x0
  d2:	4e0080e7          	jalr	1248(ra) # 5ae <exit>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  d6:	4501                	li	a0,0
  d8:	00000097          	auipc	ra,0x0
  dc:	4de080e7          	jalr	1246(ra) # 5b6 <wait>
  e0:	87aa                	mv	a5,a0
  e2:	fef42423          	sw	a5,-24(s0)
      if(wpid == pid){
  e6:	fe842703          	lw	a4,-24(s0)
  ea:	fec42783          	lw	a5,-20(s0)
  ee:	2701                	sext.w	a4,a4
  f0:	2781                	sext.w	a5,a5
  f2:	02f70463          	beq	a4,a5,11a <main+0x11a>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  f6:	fe842783          	lw	a5,-24(s0)
  fa:	2781                	sext.w	a5,a5
  fc:	fc07dde3          	bgez	a5,d6 <main+0xd6>
        printf("init: wait returned an error\n");
 100:	00001517          	auipc	a0,0x1
 104:	d7850513          	addi	a0,a0,-648 # e78 <malloc+0x19a>
 108:	00001097          	auipc	ra,0x1
 10c:	9e4080e7          	jalr	-1564(ra) # aec <printf>
        exit(1);
 110:	4505                	li	a0,1
 112:	00000097          	auipc	ra,0x0
 116:	49c080e7          	jalr	1180(ra) # 5ae <exit>
        break;
 11a:	0001                	nop
    printf("init: starting sh\n");
 11c:	bf3d                	j	5a <main+0x5a>

000000000000011e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 11e:	7179                	addi	sp,sp,-48
 120:	f422                	sd	s0,40(sp)
 122:	1800                	addi	s0,sp,48
 124:	fca43c23          	sd	a0,-40(s0)
 128:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 12c:	fd843783          	ld	a5,-40(s0)
 130:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 134:	0001                	nop
 136:	fd043703          	ld	a4,-48(s0)
 13a:	00170793          	addi	a5,a4,1
 13e:	fcf43823          	sd	a5,-48(s0)
 142:	fd843783          	ld	a5,-40(s0)
 146:	00178693          	addi	a3,a5,1
 14a:	fcd43c23          	sd	a3,-40(s0)
 14e:	00074703          	lbu	a4,0(a4)
 152:	00e78023          	sb	a4,0(a5)
 156:	0007c783          	lbu	a5,0(a5)
 15a:	fff1                	bnez	a5,136 <strcpy+0x18>
    ;
  return os;
 15c:	fe843783          	ld	a5,-24(s0)
}
 160:	853e                	mv	a0,a5
 162:	7422                	ld	s0,40(sp)
 164:	6145                	addi	sp,sp,48
 166:	8082                	ret

0000000000000168 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 168:	1101                	addi	sp,sp,-32
 16a:	ec22                	sd	s0,24(sp)
 16c:	1000                	addi	s0,sp,32
 16e:	fea43423          	sd	a0,-24(s0)
 172:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 176:	a819                	j	18c <strcmp+0x24>
    p++, q++;
 178:	fe843783          	ld	a5,-24(s0)
 17c:	0785                	addi	a5,a5,1
 17e:	fef43423          	sd	a5,-24(s0)
 182:	fe043783          	ld	a5,-32(s0)
 186:	0785                	addi	a5,a5,1
 188:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 18c:	fe843783          	ld	a5,-24(s0)
 190:	0007c783          	lbu	a5,0(a5)
 194:	cb99                	beqz	a5,1aa <strcmp+0x42>
 196:	fe843783          	ld	a5,-24(s0)
 19a:	0007c703          	lbu	a4,0(a5)
 19e:	fe043783          	ld	a5,-32(s0)
 1a2:	0007c783          	lbu	a5,0(a5)
 1a6:	fcf709e3          	beq	a4,a5,178 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 1aa:	fe843783          	ld	a5,-24(s0)
 1ae:	0007c783          	lbu	a5,0(a5)
 1b2:	0007871b          	sext.w	a4,a5
 1b6:	fe043783          	ld	a5,-32(s0)
 1ba:	0007c783          	lbu	a5,0(a5)
 1be:	2781                	sext.w	a5,a5
 1c0:	40f707bb          	subw	a5,a4,a5
 1c4:	2781                	sext.w	a5,a5
}
 1c6:	853e                	mv	a0,a5
 1c8:	6462                	ld	s0,24(sp)
 1ca:	6105                	addi	sp,sp,32
 1cc:	8082                	ret

00000000000001ce <strlen>:

uint
strlen(const char *s)
{
 1ce:	7179                	addi	sp,sp,-48
 1d0:	f422                	sd	s0,40(sp)
 1d2:	1800                	addi	s0,sp,48
 1d4:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 1d8:	fe042623          	sw	zero,-20(s0)
 1dc:	a031                	j	1e8 <strlen+0x1a>
 1de:	fec42783          	lw	a5,-20(s0)
 1e2:	2785                	addiw	a5,a5,1
 1e4:	fef42623          	sw	a5,-20(s0)
 1e8:	fec42783          	lw	a5,-20(s0)
 1ec:	fd843703          	ld	a4,-40(s0)
 1f0:	97ba                	add	a5,a5,a4
 1f2:	0007c783          	lbu	a5,0(a5)
 1f6:	f7e5                	bnez	a5,1de <strlen+0x10>
    ;
  return n;
 1f8:	fec42783          	lw	a5,-20(s0)
}
 1fc:	853e                	mv	a0,a5
 1fe:	7422                	ld	s0,40(sp)
 200:	6145                	addi	sp,sp,48
 202:	8082                	ret

0000000000000204 <memset>:

void*
memset(void *dst, int c, uint n)
{
 204:	7179                	addi	sp,sp,-48
 206:	f422                	sd	s0,40(sp)
 208:	1800                	addi	s0,sp,48
 20a:	fca43c23          	sd	a0,-40(s0)
 20e:	87ae                	mv	a5,a1
 210:	8732                	mv	a4,a2
 212:	fcf42a23          	sw	a5,-44(s0)
 216:	87ba                	mv	a5,a4
 218:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 21c:	fd843783          	ld	a5,-40(s0)
 220:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 224:	fe042623          	sw	zero,-20(s0)
 228:	a00d                	j	24a <memset+0x46>
    cdst[i] = c;
 22a:	fec42783          	lw	a5,-20(s0)
 22e:	fe043703          	ld	a4,-32(s0)
 232:	97ba                	add	a5,a5,a4
 234:	fd442703          	lw	a4,-44(s0)
 238:	0ff77713          	andi	a4,a4,255
 23c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 240:	fec42783          	lw	a5,-20(s0)
 244:	2785                	addiw	a5,a5,1
 246:	fef42623          	sw	a5,-20(s0)
 24a:	fec42703          	lw	a4,-20(s0)
 24e:	fd042783          	lw	a5,-48(s0)
 252:	2781                	sext.w	a5,a5
 254:	fcf76be3          	bltu	a4,a5,22a <memset+0x26>
  }
  return dst;
 258:	fd843783          	ld	a5,-40(s0)
}
 25c:	853e                	mv	a0,a5
 25e:	7422                	ld	s0,40(sp)
 260:	6145                	addi	sp,sp,48
 262:	8082                	ret

0000000000000264 <strchr>:

char*
strchr(const char *s, char c)
{
 264:	1101                	addi	sp,sp,-32
 266:	ec22                	sd	s0,24(sp)
 268:	1000                	addi	s0,sp,32
 26a:	fea43423          	sd	a0,-24(s0)
 26e:	87ae                	mv	a5,a1
 270:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 274:	a01d                	j	29a <strchr+0x36>
    if(*s == c)
 276:	fe843783          	ld	a5,-24(s0)
 27a:	0007c703          	lbu	a4,0(a5)
 27e:	fe744783          	lbu	a5,-25(s0)
 282:	0ff7f793          	andi	a5,a5,255
 286:	00e79563          	bne	a5,a4,290 <strchr+0x2c>
      return (char*)s;
 28a:	fe843783          	ld	a5,-24(s0)
 28e:	a821                	j	2a6 <strchr+0x42>
  for(; *s; s++)
 290:	fe843783          	ld	a5,-24(s0)
 294:	0785                	addi	a5,a5,1
 296:	fef43423          	sd	a5,-24(s0)
 29a:	fe843783          	ld	a5,-24(s0)
 29e:	0007c783          	lbu	a5,0(a5)
 2a2:	fbf1                	bnez	a5,276 <strchr+0x12>
  return 0;
 2a4:	4781                	li	a5,0
}
 2a6:	853e                	mv	a0,a5
 2a8:	6462                	ld	s0,24(sp)
 2aa:	6105                	addi	sp,sp,32
 2ac:	8082                	ret

00000000000002ae <gets>:

char*
gets(char *buf, int max)
{
 2ae:	7179                	addi	sp,sp,-48
 2b0:	f406                	sd	ra,40(sp)
 2b2:	f022                	sd	s0,32(sp)
 2b4:	1800                	addi	s0,sp,48
 2b6:	fca43c23          	sd	a0,-40(s0)
 2ba:	87ae                	mv	a5,a1
 2bc:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2c0:	fe042623          	sw	zero,-20(s0)
 2c4:	a8a1                	j	31c <gets+0x6e>
    cc = read(0, &c, 1);
 2c6:	fe740793          	addi	a5,s0,-25
 2ca:	4605                	li	a2,1
 2cc:	85be                	mv	a1,a5
 2ce:	4501                	li	a0,0
 2d0:	00000097          	auipc	ra,0x0
 2d4:	2f6080e7          	jalr	758(ra) # 5c6 <read>
 2d8:	87aa                	mv	a5,a0
 2da:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 2de:	fe842783          	lw	a5,-24(s0)
 2e2:	2781                	sext.w	a5,a5
 2e4:	04f05763          	blez	a5,332 <gets+0x84>
      break;
    buf[i++] = c;
 2e8:	fec42783          	lw	a5,-20(s0)
 2ec:	0017871b          	addiw	a4,a5,1
 2f0:	fee42623          	sw	a4,-20(s0)
 2f4:	873e                	mv	a4,a5
 2f6:	fd843783          	ld	a5,-40(s0)
 2fa:	97ba                	add	a5,a5,a4
 2fc:	fe744703          	lbu	a4,-25(s0)
 300:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 304:	fe744783          	lbu	a5,-25(s0)
 308:	873e                	mv	a4,a5
 30a:	47a9                	li	a5,10
 30c:	02f70463          	beq	a4,a5,334 <gets+0x86>
 310:	fe744783          	lbu	a5,-25(s0)
 314:	873e                	mv	a4,a5
 316:	47b5                	li	a5,13
 318:	00f70e63          	beq	a4,a5,334 <gets+0x86>
  for(i=0; i+1 < max; ){
 31c:	fec42783          	lw	a5,-20(s0)
 320:	2785                	addiw	a5,a5,1
 322:	0007871b          	sext.w	a4,a5
 326:	fd442783          	lw	a5,-44(s0)
 32a:	2781                	sext.w	a5,a5
 32c:	f8f74de3          	blt	a4,a5,2c6 <gets+0x18>
 330:	a011                	j	334 <gets+0x86>
      break;
 332:	0001                	nop
      break;
  }
  buf[i] = '\0';
 334:	fec42783          	lw	a5,-20(s0)
 338:	fd843703          	ld	a4,-40(s0)
 33c:	97ba                	add	a5,a5,a4
 33e:	00078023          	sb	zero,0(a5)
  return buf;
 342:	fd843783          	ld	a5,-40(s0)
}
 346:	853e                	mv	a0,a5
 348:	70a2                	ld	ra,40(sp)
 34a:	7402                	ld	s0,32(sp)
 34c:	6145                	addi	sp,sp,48
 34e:	8082                	ret

0000000000000350 <stat>:

int
stat(const char *n, struct stat *st)
{
 350:	7179                	addi	sp,sp,-48
 352:	f406                	sd	ra,40(sp)
 354:	f022                	sd	s0,32(sp)
 356:	1800                	addi	s0,sp,48
 358:	fca43c23          	sd	a0,-40(s0)
 35c:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 360:	4581                	li	a1,0
 362:	fd843503          	ld	a0,-40(s0)
 366:	00000097          	auipc	ra,0x0
 36a:	288080e7          	jalr	648(ra) # 5ee <open>
 36e:	87aa                	mv	a5,a0
 370:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 374:	fec42783          	lw	a5,-20(s0)
 378:	2781                	sext.w	a5,a5
 37a:	0007d463          	bgez	a5,382 <stat+0x32>
    return -1;
 37e:	57fd                	li	a5,-1
 380:	a035                	j	3ac <stat+0x5c>
  r = fstat(fd, st);
 382:	fec42783          	lw	a5,-20(s0)
 386:	fd043583          	ld	a1,-48(s0)
 38a:	853e                	mv	a0,a5
 38c:	00000097          	auipc	ra,0x0
 390:	27a080e7          	jalr	634(ra) # 606 <fstat>
 394:	87aa                	mv	a5,a0
 396:	fef42423          	sw	a5,-24(s0)
  close(fd);
 39a:	fec42783          	lw	a5,-20(s0)
 39e:	853e                	mv	a0,a5
 3a0:	00000097          	auipc	ra,0x0
 3a4:	236080e7          	jalr	566(ra) # 5d6 <close>
  return r;
 3a8:	fe842783          	lw	a5,-24(s0)
}
 3ac:	853e                	mv	a0,a5
 3ae:	70a2                	ld	ra,40(sp)
 3b0:	7402                	ld	s0,32(sp)
 3b2:	6145                	addi	sp,sp,48
 3b4:	8082                	ret

00000000000003b6 <atoi>:

int
atoi(const char *s)
{
 3b6:	7179                	addi	sp,sp,-48
 3b8:	f422                	sd	s0,40(sp)
 3ba:	1800                	addi	s0,sp,48
 3bc:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 3c0:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 3c4:	a815                	j	3f8 <atoi+0x42>
    n = n*10 + *s++ - '0';
 3c6:	fec42703          	lw	a4,-20(s0)
 3ca:	87ba                	mv	a5,a4
 3cc:	0027979b          	slliw	a5,a5,0x2
 3d0:	9fb9                	addw	a5,a5,a4
 3d2:	0017979b          	slliw	a5,a5,0x1
 3d6:	0007871b          	sext.w	a4,a5
 3da:	fd843783          	ld	a5,-40(s0)
 3de:	00178693          	addi	a3,a5,1
 3e2:	fcd43c23          	sd	a3,-40(s0)
 3e6:	0007c783          	lbu	a5,0(a5)
 3ea:	2781                	sext.w	a5,a5
 3ec:	9fb9                	addw	a5,a5,a4
 3ee:	2781                	sext.w	a5,a5
 3f0:	fd07879b          	addiw	a5,a5,-48
 3f4:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 3f8:	fd843783          	ld	a5,-40(s0)
 3fc:	0007c783          	lbu	a5,0(a5)
 400:	873e                	mv	a4,a5
 402:	02f00793          	li	a5,47
 406:	00e7fb63          	bgeu	a5,a4,41c <atoi+0x66>
 40a:	fd843783          	ld	a5,-40(s0)
 40e:	0007c783          	lbu	a5,0(a5)
 412:	873e                	mv	a4,a5
 414:	03900793          	li	a5,57
 418:	fae7f7e3          	bgeu	a5,a4,3c6 <atoi+0x10>
  return n;
 41c:	fec42783          	lw	a5,-20(s0)
}
 420:	853e                	mv	a0,a5
 422:	7422                	ld	s0,40(sp)
 424:	6145                	addi	sp,sp,48
 426:	8082                	ret

0000000000000428 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 428:	7139                	addi	sp,sp,-64
 42a:	fc22                	sd	s0,56(sp)
 42c:	0080                	addi	s0,sp,64
 42e:	fca43c23          	sd	a0,-40(s0)
 432:	fcb43823          	sd	a1,-48(s0)
 436:	87b2                	mv	a5,a2
 438:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 43c:	fd843783          	ld	a5,-40(s0)
 440:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 444:	fd043783          	ld	a5,-48(s0)
 448:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 44c:	fe043703          	ld	a4,-32(s0)
 450:	fe843783          	ld	a5,-24(s0)
 454:	02e7fc63          	bgeu	a5,a4,48c <memmove+0x64>
    while(n-- > 0)
 458:	a00d                	j	47a <memmove+0x52>
      *dst++ = *src++;
 45a:	fe043703          	ld	a4,-32(s0)
 45e:	00170793          	addi	a5,a4,1
 462:	fef43023          	sd	a5,-32(s0)
 466:	fe843783          	ld	a5,-24(s0)
 46a:	00178693          	addi	a3,a5,1
 46e:	fed43423          	sd	a3,-24(s0)
 472:	00074703          	lbu	a4,0(a4)
 476:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 47a:	fcc42783          	lw	a5,-52(s0)
 47e:	fff7871b          	addiw	a4,a5,-1
 482:	fce42623          	sw	a4,-52(s0)
 486:	fcf04ae3          	bgtz	a5,45a <memmove+0x32>
 48a:	a891                	j	4de <memmove+0xb6>
  } else {
    dst += n;
 48c:	fcc42783          	lw	a5,-52(s0)
 490:	fe843703          	ld	a4,-24(s0)
 494:	97ba                	add	a5,a5,a4
 496:	fef43423          	sd	a5,-24(s0)
    src += n;
 49a:	fcc42783          	lw	a5,-52(s0)
 49e:	fe043703          	ld	a4,-32(s0)
 4a2:	97ba                	add	a5,a5,a4
 4a4:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 4a8:	a01d                	j	4ce <memmove+0xa6>
      *--dst = *--src;
 4aa:	fe043783          	ld	a5,-32(s0)
 4ae:	17fd                	addi	a5,a5,-1
 4b0:	fef43023          	sd	a5,-32(s0)
 4b4:	fe843783          	ld	a5,-24(s0)
 4b8:	17fd                	addi	a5,a5,-1
 4ba:	fef43423          	sd	a5,-24(s0)
 4be:	fe043783          	ld	a5,-32(s0)
 4c2:	0007c703          	lbu	a4,0(a5)
 4c6:	fe843783          	ld	a5,-24(s0)
 4ca:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4ce:	fcc42783          	lw	a5,-52(s0)
 4d2:	fff7871b          	addiw	a4,a5,-1
 4d6:	fce42623          	sw	a4,-52(s0)
 4da:	fcf048e3          	bgtz	a5,4aa <memmove+0x82>
  }
  return vdst;
 4de:	fd843783          	ld	a5,-40(s0)
}
 4e2:	853e                	mv	a0,a5
 4e4:	7462                	ld	s0,56(sp)
 4e6:	6121                	addi	sp,sp,64
 4e8:	8082                	ret

00000000000004ea <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4ea:	7139                	addi	sp,sp,-64
 4ec:	fc22                	sd	s0,56(sp)
 4ee:	0080                	addi	s0,sp,64
 4f0:	fca43c23          	sd	a0,-40(s0)
 4f4:	fcb43823          	sd	a1,-48(s0)
 4f8:	87b2                	mv	a5,a2
 4fa:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 4fe:	fd843783          	ld	a5,-40(s0)
 502:	fef43423          	sd	a5,-24(s0)
 506:	fd043783          	ld	a5,-48(s0)
 50a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 50e:	a0a1                	j	556 <memcmp+0x6c>
    if (*p1 != *p2) {
 510:	fe843783          	ld	a5,-24(s0)
 514:	0007c703          	lbu	a4,0(a5)
 518:	fe043783          	ld	a5,-32(s0)
 51c:	0007c783          	lbu	a5,0(a5)
 520:	02f70163          	beq	a4,a5,542 <memcmp+0x58>
      return *p1 - *p2;
 524:	fe843783          	ld	a5,-24(s0)
 528:	0007c783          	lbu	a5,0(a5)
 52c:	0007871b          	sext.w	a4,a5
 530:	fe043783          	ld	a5,-32(s0)
 534:	0007c783          	lbu	a5,0(a5)
 538:	2781                	sext.w	a5,a5
 53a:	40f707bb          	subw	a5,a4,a5
 53e:	2781                	sext.w	a5,a5
 540:	a01d                	j	566 <memcmp+0x7c>
    }
    p1++;
 542:	fe843783          	ld	a5,-24(s0)
 546:	0785                	addi	a5,a5,1
 548:	fef43423          	sd	a5,-24(s0)
    p2++;
 54c:	fe043783          	ld	a5,-32(s0)
 550:	0785                	addi	a5,a5,1
 552:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 556:	fcc42783          	lw	a5,-52(s0)
 55a:	fff7871b          	addiw	a4,a5,-1
 55e:	fce42623          	sw	a4,-52(s0)
 562:	f7dd                	bnez	a5,510 <memcmp+0x26>
  }
  return 0;
 564:	4781                	li	a5,0
}
 566:	853e                	mv	a0,a5
 568:	7462                	ld	s0,56(sp)
 56a:	6121                	addi	sp,sp,64
 56c:	8082                	ret

000000000000056e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 56e:	7179                	addi	sp,sp,-48
 570:	f406                	sd	ra,40(sp)
 572:	f022                	sd	s0,32(sp)
 574:	1800                	addi	s0,sp,48
 576:	fea43423          	sd	a0,-24(s0)
 57a:	feb43023          	sd	a1,-32(s0)
 57e:	87b2                	mv	a5,a2
 580:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 584:	fdc42783          	lw	a5,-36(s0)
 588:	863e                	mv	a2,a5
 58a:	fe043583          	ld	a1,-32(s0)
 58e:	fe843503          	ld	a0,-24(s0)
 592:	00000097          	auipc	ra,0x0
 596:	e96080e7          	jalr	-362(ra) # 428 <memmove>
 59a:	87aa                	mv	a5,a0
}
 59c:	853e                	mv	a0,a5
 59e:	70a2                	ld	ra,40(sp)
 5a0:	7402                	ld	s0,32(sp)
 5a2:	6145                	addi	sp,sp,48
 5a4:	8082                	ret

00000000000005a6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5a6:	4885                	li	a7,1
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <exit>:
.global exit
exit:
 li a7, SYS_exit
 5ae:	4889                	li	a7,2
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5b6:	488d                	li	a7,3
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5be:	4891                	li	a7,4
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <read>:
.global read
read:
 li a7, SYS_read
 5c6:	4895                	li	a7,5
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <write>:
.global write
write:
 li a7, SYS_write
 5ce:	48c1                	li	a7,16
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <close>:
.global close
close:
 li a7, SYS_close
 5d6:	48d5                	li	a7,21
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <kill>:
.global kill
kill:
 li a7, SYS_kill
 5de:	4899                	li	a7,6
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5e6:	489d                	li	a7,7
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <open>:
.global open
open:
 li a7, SYS_open
 5ee:	48bd                	li	a7,15
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5f6:	48c5                	li	a7,17
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5fe:	48c9                	li	a7,18
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 606:	48a1                	li	a7,8
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <link>:
.global link
link:
 li a7, SYS_link
 60e:	48cd                	li	a7,19
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 616:	48d1                	li	a7,20
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 61e:	48a5                	li	a7,9
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <dup>:
.global dup
dup:
 li a7, SYS_dup
 626:	48a9                	li	a7,10
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 62e:	48ad                	li	a7,11
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 636:	48b1                	li	a7,12
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 63e:	48b5                	li	a7,13
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 646:	48b9                	li	a7,14
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 64e:	48d9                	li	a7,22
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <setpri>:
.global setpri
setpri:
 li a7, SYS_setpri
 656:	48dd                	li	a7,23
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 65e:	1101                	addi	sp,sp,-32
 660:	ec06                	sd	ra,24(sp)
 662:	e822                	sd	s0,16(sp)
 664:	1000                	addi	s0,sp,32
 666:	87aa                	mv	a5,a0
 668:	872e                	mv	a4,a1
 66a:	fef42623          	sw	a5,-20(s0)
 66e:	87ba                	mv	a5,a4
 670:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 674:	feb40713          	addi	a4,s0,-21
 678:	fec42783          	lw	a5,-20(s0)
 67c:	4605                	li	a2,1
 67e:	85ba                	mv	a1,a4
 680:	853e                	mv	a0,a5
 682:	00000097          	auipc	ra,0x0
 686:	f4c080e7          	jalr	-180(ra) # 5ce <write>
}
 68a:	0001                	nop
 68c:	60e2                	ld	ra,24(sp)
 68e:	6442                	ld	s0,16(sp)
 690:	6105                	addi	sp,sp,32
 692:	8082                	ret

0000000000000694 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 694:	7139                	addi	sp,sp,-64
 696:	fc06                	sd	ra,56(sp)
 698:	f822                	sd	s0,48(sp)
 69a:	0080                	addi	s0,sp,64
 69c:	87aa                	mv	a5,a0
 69e:	8736                	mv	a4,a3
 6a0:	fcf42623          	sw	a5,-52(s0)
 6a4:	87ae                	mv	a5,a1
 6a6:	fcf42423          	sw	a5,-56(s0)
 6aa:	87b2                	mv	a5,a2
 6ac:	fcf42223          	sw	a5,-60(s0)
 6b0:	87ba                	mv	a5,a4
 6b2:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6b6:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 6ba:	fc042783          	lw	a5,-64(s0)
 6be:	2781                	sext.w	a5,a5
 6c0:	c38d                	beqz	a5,6e2 <printint+0x4e>
 6c2:	fc842783          	lw	a5,-56(s0)
 6c6:	2781                	sext.w	a5,a5
 6c8:	0007dd63          	bgez	a5,6e2 <printint+0x4e>
    neg = 1;
 6cc:	4785                	li	a5,1
 6ce:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 6d2:	fc842783          	lw	a5,-56(s0)
 6d6:	40f007bb          	negw	a5,a5
 6da:	2781                	sext.w	a5,a5
 6dc:	fef42223          	sw	a5,-28(s0)
 6e0:	a029                	j	6ea <printint+0x56>
  } else {
    x = xx;
 6e2:	fc842783          	lw	a5,-56(s0)
 6e6:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 6ea:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 6ee:	fc442783          	lw	a5,-60(s0)
 6f2:	fe442703          	lw	a4,-28(s0)
 6f6:	02f777bb          	remuw	a5,a4,a5
 6fa:	0007861b          	sext.w	a2,a5
 6fe:	fec42783          	lw	a5,-20(s0)
 702:	0017871b          	addiw	a4,a5,1
 706:	fee42623          	sw	a4,-20(s0)
 70a:	00000697          	auipc	a3,0x0
 70e:	7a668693          	addi	a3,a3,1958 # eb0 <digits>
 712:	02061713          	slli	a4,a2,0x20
 716:	9301                	srli	a4,a4,0x20
 718:	9736                	add	a4,a4,a3
 71a:	00074703          	lbu	a4,0(a4)
 71e:	ff040693          	addi	a3,s0,-16
 722:	97b6                	add	a5,a5,a3
 724:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 728:	fc442783          	lw	a5,-60(s0)
 72c:	fe442703          	lw	a4,-28(s0)
 730:	02f757bb          	divuw	a5,a4,a5
 734:	fef42223          	sw	a5,-28(s0)
 738:	fe442783          	lw	a5,-28(s0)
 73c:	2781                	sext.w	a5,a5
 73e:	fbc5                	bnez	a5,6ee <printint+0x5a>
  if(neg)
 740:	fe842783          	lw	a5,-24(s0)
 744:	2781                	sext.w	a5,a5
 746:	cf95                	beqz	a5,782 <printint+0xee>
    buf[i++] = '-';
 748:	fec42783          	lw	a5,-20(s0)
 74c:	0017871b          	addiw	a4,a5,1
 750:	fee42623          	sw	a4,-20(s0)
 754:	ff040713          	addi	a4,s0,-16
 758:	97ba                	add	a5,a5,a4
 75a:	02d00713          	li	a4,45
 75e:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 762:	a005                	j	782 <printint+0xee>
    putc(fd, buf[i]);
 764:	fec42783          	lw	a5,-20(s0)
 768:	ff040713          	addi	a4,s0,-16
 76c:	97ba                	add	a5,a5,a4
 76e:	fe07c703          	lbu	a4,-32(a5)
 772:	fcc42783          	lw	a5,-52(s0)
 776:	85ba                	mv	a1,a4
 778:	853e                	mv	a0,a5
 77a:	00000097          	auipc	ra,0x0
 77e:	ee4080e7          	jalr	-284(ra) # 65e <putc>
  while(--i >= 0)
 782:	fec42783          	lw	a5,-20(s0)
 786:	37fd                	addiw	a5,a5,-1
 788:	fef42623          	sw	a5,-20(s0)
 78c:	fec42783          	lw	a5,-20(s0)
 790:	2781                	sext.w	a5,a5
 792:	fc07d9e3          	bgez	a5,764 <printint+0xd0>
}
 796:	0001                	nop
 798:	0001                	nop
 79a:	70e2                	ld	ra,56(sp)
 79c:	7442                	ld	s0,48(sp)
 79e:	6121                	addi	sp,sp,64
 7a0:	8082                	ret

00000000000007a2 <printptr>:

static void
printptr(int fd, uint64 x) {
 7a2:	7179                	addi	sp,sp,-48
 7a4:	f406                	sd	ra,40(sp)
 7a6:	f022                	sd	s0,32(sp)
 7a8:	1800                	addi	s0,sp,48
 7aa:	87aa                	mv	a5,a0
 7ac:	fcb43823          	sd	a1,-48(s0)
 7b0:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 7b4:	fdc42783          	lw	a5,-36(s0)
 7b8:	03000593          	li	a1,48
 7bc:	853e                	mv	a0,a5
 7be:	00000097          	auipc	ra,0x0
 7c2:	ea0080e7          	jalr	-352(ra) # 65e <putc>
  putc(fd, 'x');
 7c6:	fdc42783          	lw	a5,-36(s0)
 7ca:	07800593          	li	a1,120
 7ce:	853e                	mv	a0,a5
 7d0:	00000097          	auipc	ra,0x0
 7d4:	e8e080e7          	jalr	-370(ra) # 65e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7d8:	fe042623          	sw	zero,-20(s0)
 7dc:	a82d                	j	816 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7de:	fd043783          	ld	a5,-48(s0)
 7e2:	93f1                	srli	a5,a5,0x3c
 7e4:	00000717          	auipc	a4,0x0
 7e8:	6cc70713          	addi	a4,a4,1740 # eb0 <digits>
 7ec:	97ba                	add	a5,a5,a4
 7ee:	0007c703          	lbu	a4,0(a5)
 7f2:	fdc42783          	lw	a5,-36(s0)
 7f6:	85ba                	mv	a1,a4
 7f8:	853e                	mv	a0,a5
 7fa:	00000097          	auipc	ra,0x0
 7fe:	e64080e7          	jalr	-412(ra) # 65e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 802:	fec42783          	lw	a5,-20(s0)
 806:	2785                	addiw	a5,a5,1
 808:	fef42623          	sw	a5,-20(s0)
 80c:	fd043783          	ld	a5,-48(s0)
 810:	0792                	slli	a5,a5,0x4
 812:	fcf43823          	sd	a5,-48(s0)
 816:	fec42783          	lw	a5,-20(s0)
 81a:	873e                	mv	a4,a5
 81c:	47bd                	li	a5,15
 81e:	fce7f0e3          	bgeu	a5,a4,7de <printptr+0x3c>
}
 822:	0001                	nop
 824:	0001                	nop
 826:	70a2                	ld	ra,40(sp)
 828:	7402                	ld	s0,32(sp)
 82a:	6145                	addi	sp,sp,48
 82c:	8082                	ret

000000000000082e <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 82e:	715d                	addi	sp,sp,-80
 830:	e486                	sd	ra,72(sp)
 832:	e0a2                	sd	s0,64(sp)
 834:	0880                	addi	s0,sp,80
 836:	87aa                	mv	a5,a0
 838:	fcb43023          	sd	a1,-64(s0)
 83c:	fac43c23          	sd	a2,-72(s0)
 840:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 844:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 848:	fe042223          	sw	zero,-28(s0)
 84c:	a42d                	j	a76 <vprintf+0x248>
    c = fmt[i] & 0xff;
 84e:	fe442783          	lw	a5,-28(s0)
 852:	fc043703          	ld	a4,-64(s0)
 856:	97ba                	add	a5,a5,a4
 858:	0007c783          	lbu	a5,0(a5)
 85c:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 860:	fe042783          	lw	a5,-32(s0)
 864:	2781                	sext.w	a5,a5
 866:	eb9d                	bnez	a5,89c <vprintf+0x6e>
      if(c == '%'){
 868:	fdc42783          	lw	a5,-36(s0)
 86c:	0007871b          	sext.w	a4,a5
 870:	02500793          	li	a5,37
 874:	00f71763          	bne	a4,a5,882 <vprintf+0x54>
        state = '%';
 878:	02500793          	li	a5,37
 87c:	fef42023          	sw	a5,-32(s0)
 880:	a2f5                	j	a6c <vprintf+0x23e>
      } else {
        putc(fd, c);
 882:	fdc42783          	lw	a5,-36(s0)
 886:	0ff7f713          	andi	a4,a5,255
 88a:	fcc42783          	lw	a5,-52(s0)
 88e:	85ba                	mv	a1,a4
 890:	853e                	mv	a0,a5
 892:	00000097          	auipc	ra,0x0
 896:	dcc080e7          	jalr	-564(ra) # 65e <putc>
 89a:	aac9                	j	a6c <vprintf+0x23e>
      }
    } else if(state == '%'){
 89c:	fe042783          	lw	a5,-32(s0)
 8a0:	0007871b          	sext.w	a4,a5
 8a4:	02500793          	li	a5,37
 8a8:	1cf71263          	bne	a4,a5,a6c <vprintf+0x23e>
      if(c == 'd'){
 8ac:	fdc42783          	lw	a5,-36(s0)
 8b0:	0007871b          	sext.w	a4,a5
 8b4:	06400793          	li	a5,100
 8b8:	02f71463          	bne	a4,a5,8e0 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 8bc:	fb843783          	ld	a5,-72(s0)
 8c0:	00878713          	addi	a4,a5,8
 8c4:	fae43c23          	sd	a4,-72(s0)
 8c8:	4398                	lw	a4,0(a5)
 8ca:	fcc42783          	lw	a5,-52(s0)
 8ce:	4685                	li	a3,1
 8d0:	4629                	li	a2,10
 8d2:	85ba                	mv	a1,a4
 8d4:	853e                	mv	a0,a5
 8d6:	00000097          	auipc	ra,0x0
 8da:	dbe080e7          	jalr	-578(ra) # 694 <printint>
 8de:	a269                	j	a68 <vprintf+0x23a>
      } else if(c == 'l') {
 8e0:	fdc42783          	lw	a5,-36(s0)
 8e4:	0007871b          	sext.w	a4,a5
 8e8:	06c00793          	li	a5,108
 8ec:	02f71663          	bne	a4,a5,918 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8f0:	fb843783          	ld	a5,-72(s0)
 8f4:	00878713          	addi	a4,a5,8
 8f8:	fae43c23          	sd	a4,-72(s0)
 8fc:	639c                	ld	a5,0(a5)
 8fe:	0007871b          	sext.w	a4,a5
 902:	fcc42783          	lw	a5,-52(s0)
 906:	4681                	li	a3,0
 908:	4629                	li	a2,10
 90a:	85ba                	mv	a1,a4
 90c:	853e                	mv	a0,a5
 90e:	00000097          	auipc	ra,0x0
 912:	d86080e7          	jalr	-634(ra) # 694 <printint>
 916:	aa89                	j	a68 <vprintf+0x23a>
      } else if(c == 'x') {
 918:	fdc42783          	lw	a5,-36(s0)
 91c:	0007871b          	sext.w	a4,a5
 920:	07800793          	li	a5,120
 924:	02f71463          	bne	a4,a5,94c <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 928:	fb843783          	ld	a5,-72(s0)
 92c:	00878713          	addi	a4,a5,8
 930:	fae43c23          	sd	a4,-72(s0)
 934:	4398                	lw	a4,0(a5)
 936:	fcc42783          	lw	a5,-52(s0)
 93a:	4681                	li	a3,0
 93c:	4641                	li	a2,16
 93e:	85ba                	mv	a1,a4
 940:	853e                	mv	a0,a5
 942:	00000097          	auipc	ra,0x0
 946:	d52080e7          	jalr	-686(ra) # 694 <printint>
 94a:	aa39                	j	a68 <vprintf+0x23a>
      } else if(c == 'p') {
 94c:	fdc42783          	lw	a5,-36(s0)
 950:	0007871b          	sext.w	a4,a5
 954:	07000793          	li	a5,112
 958:	02f71263          	bne	a4,a5,97c <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 95c:	fb843783          	ld	a5,-72(s0)
 960:	00878713          	addi	a4,a5,8
 964:	fae43c23          	sd	a4,-72(s0)
 968:	6398                	ld	a4,0(a5)
 96a:	fcc42783          	lw	a5,-52(s0)
 96e:	85ba                	mv	a1,a4
 970:	853e                	mv	a0,a5
 972:	00000097          	auipc	ra,0x0
 976:	e30080e7          	jalr	-464(ra) # 7a2 <printptr>
 97a:	a0fd                	j	a68 <vprintf+0x23a>
      } else if(c == 's'){
 97c:	fdc42783          	lw	a5,-36(s0)
 980:	0007871b          	sext.w	a4,a5
 984:	07300793          	li	a5,115
 988:	04f71c63          	bne	a4,a5,9e0 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 98c:	fb843783          	ld	a5,-72(s0)
 990:	00878713          	addi	a4,a5,8
 994:	fae43c23          	sd	a4,-72(s0)
 998:	639c                	ld	a5,0(a5)
 99a:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 99e:	fe843783          	ld	a5,-24(s0)
 9a2:	eb8d                	bnez	a5,9d4 <vprintf+0x1a6>
          s = "(null)";
 9a4:	00000797          	auipc	a5,0x0
 9a8:	4f478793          	addi	a5,a5,1268 # e98 <malloc+0x1ba>
 9ac:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 9b0:	a015                	j	9d4 <vprintf+0x1a6>
          putc(fd, *s);
 9b2:	fe843783          	ld	a5,-24(s0)
 9b6:	0007c703          	lbu	a4,0(a5)
 9ba:	fcc42783          	lw	a5,-52(s0)
 9be:	85ba                	mv	a1,a4
 9c0:	853e                	mv	a0,a5
 9c2:	00000097          	auipc	ra,0x0
 9c6:	c9c080e7          	jalr	-868(ra) # 65e <putc>
          s++;
 9ca:	fe843783          	ld	a5,-24(s0)
 9ce:	0785                	addi	a5,a5,1
 9d0:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 9d4:	fe843783          	ld	a5,-24(s0)
 9d8:	0007c783          	lbu	a5,0(a5)
 9dc:	fbf9                	bnez	a5,9b2 <vprintf+0x184>
 9de:	a069                	j	a68 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 9e0:	fdc42783          	lw	a5,-36(s0)
 9e4:	0007871b          	sext.w	a4,a5
 9e8:	06300793          	li	a5,99
 9ec:	02f71463          	bne	a4,a5,a14 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 9f0:	fb843783          	ld	a5,-72(s0)
 9f4:	00878713          	addi	a4,a5,8
 9f8:	fae43c23          	sd	a4,-72(s0)
 9fc:	439c                	lw	a5,0(a5)
 9fe:	0ff7f713          	andi	a4,a5,255
 a02:	fcc42783          	lw	a5,-52(s0)
 a06:	85ba                	mv	a1,a4
 a08:	853e                	mv	a0,a5
 a0a:	00000097          	auipc	ra,0x0
 a0e:	c54080e7          	jalr	-940(ra) # 65e <putc>
 a12:	a899                	j	a68 <vprintf+0x23a>
      } else if(c == '%'){
 a14:	fdc42783          	lw	a5,-36(s0)
 a18:	0007871b          	sext.w	a4,a5
 a1c:	02500793          	li	a5,37
 a20:	00f71f63          	bne	a4,a5,a3e <vprintf+0x210>
        putc(fd, c);
 a24:	fdc42783          	lw	a5,-36(s0)
 a28:	0ff7f713          	andi	a4,a5,255
 a2c:	fcc42783          	lw	a5,-52(s0)
 a30:	85ba                	mv	a1,a4
 a32:	853e                	mv	a0,a5
 a34:	00000097          	auipc	ra,0x0
 a38:	c2a080e7          	jalr	-982(ra) # 65e <putc>
 a3c:	a035                	j	a68 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a3e:	fcc42783          	lw	a5,-52(s0)
 a42:	02500593          	li	a1,37
 a46:	853e                	mv	a0,a5
 a48:	00000097          	auipc	ra,0x0
 a4c:	c16080e7          	jalr	-1002(ra) # 65e <putc>
        putc(fd, c);
 a50:	fdc42783          	lw	a5,-36(s0)
 a54:	0ff7f713          	andi	a4,a5,255
 a58:	fcc42783          	lw	a5,-52(s0)
 a5c:	85ba                	mv	a1,a4
 a5e:	853e                	mv	a0,a5
 a60:	00000097          	auipc	ra,0x0
 a64:	bfe080e7          	jalr	-1026(ra) # 65e <putc>
      }
      state = 0;
 a68:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 a6c:	fe442783          	lw	a5,-28(s0)
 a70:	2785                	addiw	a5,a5,1
 a72:	fef42223          	sw	a5,-28(s0)
 a76:	fe442783          	lw	a5,-28(s0)
 a7a:	fc043703          	ld	a4,-64(s0)
 a7e:	97ba                	add	a5,a5,a4
 a80:	0007c783          	lbu	a5,0(a5)
 a84:	dc0795e3          	bnez	a5,84e <vprintf+0x20>
    }
  }
}
 a88:	0001                	nop
 a8a:	0001                	nop
 a8c:	60a6                	ld	ra,72(sp)
 a8e:	6406                	ld	s0,64(sp)
 a90:	6161                	addi	sp,sp,80
 a92:	8082                	ret

0000000000000a94 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a94:	7159                	addi	sp,sp,-112
 a96:	fc06                	sd	ra,56(sp)
 a98:	f822                	sd	s0,48(sp)
 a9a:	0080                	addi	s0,sp,64
 a9c:	fcb43823          	sd	a1,-48(s0)
 aa0:	e010                	sd	a2,0(s0)
 aa2:	e414                	sd	a3,8(s0)
 aa4:	e818                	sd	a4,16(s0)
 aa6:	ec1c                	sd	a5,24(s0)
 aa8:	03043023          	sd	a6,32(s0)
 aac:	03143423          	sd	a7,40(s0)
 ab0:	87aa                	mv	a5,a0
 ab2:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 ab6:	03040793          	addi	a5,s0,48
 aba:	fcf43423          	sd	a5,-56(s0)
 abe:	fc843783          	ld	a5,-56(s0)
 ac2:	fd078793          	addi	a5,a5,-48
 ac6:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 aca:	fe843703          	ld	a4,-24(s0)
 ace:	fdc42783          	lw	a5,-36(s0)
 ad2:	863a                	mv	a2,a4
 ad4:	fd043583          	ld	a1,-48(s0)
 ad8:	853e                	mv	a0,a5
 ada:	00000097          	auipc	ra,0x0
 ade:	d54080e7          	jalr	-684(ra) # 82e <vprintf>
}
 ae2:	0001                	nop
 ae4:	70e2                	ld	ra,56(sp)
 ae6:	7442                	ld	s0,48(sp)
 ae8:	6165                	addi	sp,sp,112
 aea:	8082                	ret

0000000000000aec <printf>:

void
printf(const char *fmt, ...)
{
 aec:	7159                	addi	sp,sp,-112
 aee:	f406                	sd	ra,40(sp)
 af0:	f022                	sd	s0,32(sp)
 af2:	1800                	addi	s0,sp,48
 af4:	fca43c23          	sd	a0,-40(s0)
 af8:	e40c                	sd	a1,8(s0)
 afa:	e810                	sd	a2,16(s0)
 afc:	ec14                	sd	a3,24(s0)
 afe:	f018                	sd	a4,32(s0)
 b00:	f41c                	sd	a5,40(s0)
 b02:	03043823          	sd	a6,48(s0)
 b06:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b0a:	04040793          	addi	a5,s0,64
 b0e:	fcf43823          	sd	a5,-48(s0)
 b12:	fd043783          	ld	a5,-48(s0)
 b16:	fc878793          	addi	a5,a5,-56
 b1a:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 b1e:	fe843783          	ld	a5,-24(s0)
 b22:	863e                	mv	a2,a5
 b24:	fd843583          	ld	a1,-40(s0)
 b28:	4505                	li	a0,1
 b2a:	00000097          	auipc	ra,0x0
 b2e:	d04080e7          	jalr	-764(ra) # 82e <vprintf>
}
 b32:	0001                	nop
 b34:	70a2                	ld	ra,40(sp)
 b36:	7402                	ld	s0,32(sp)
 b38:	6165                	addi	sp,sp,112
 b3a:	8082                	ret

0000000000000b3c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b3c:	7179                	addi	sp,sp,-48
 b3e:	f422                	sd	s0,40(sp)
 b40:	1800                	addi	s0,sp,48
 b42:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b46:	fd843783          	ld	a5,-40(s0)
 b4a:	17c1                	addi	a5,a5,-16
 b4c:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b50:	00000797          	auipc	a5,0x0
 b54:	38878793          	addi	a5,a5,904 # ed8 <freep>
 b58:	639c                	ld	a5,0(a5)
 b5a:	fef43423          	sd	a5,-24(s0)
 b5e:	a815                	j	b92 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b60:	fe843783          	ld	a5,-24(s0)
 b64:	639c                	ld	a5,0(a5)
 b66:	fe843703          	ld	a4,-24(s0)
 b6a:	00f76f63          	bltu	a4,a5,b88 <free+0x4c>
 b6e:	fe043703          	ld	a4,-32(s0)
 b72:	fe843783          	ld	a5,-24(s0)
 b76:	02e7eb63          	bltu	a5,a4,bac <free+0x70>
 b7a:	fe843783          	ld	a5,-24(s0)
 b7e:	639c                	ld	a5,0(a5)
 b80:	fe043703          	ld	a4,-32(s0)
 b84:	02f76463          	bltu	a4,a5,bac <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b88:	fe843783          	ld	a5,-24(s0)
 b8c:	639c                	ld	a5,0(a5)
 b8e:	fef43423          	sd	a5,-24(s0)
 b92:	fe043703          	ld	a4,-32(s0)
 b96:	fe843783          	ld	a5,-24(s0)
 b9a:	fce7f3e3          	bgeu	a5,a4,b60 <free+0x24>
 b9e:	fe843783          	ld	a5,-24(s0)
 ba2:	639c                	ld	a5,0(a5)
 ba4:	fe043703          	ld	a4,-32(s0)
 ba8:	faf77ce3          	bgeu	a4,a5,b60 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 bac:	fe043783          	ld	a5,-32(s0)
 bb0:	479c                	lw	a5,8(a5)
 bb2:	1782                	slli	a5,a5,0x20
 bb4:	9381                	srli	a5,a5,0x20
 bb6:	0792                	slli	a5,a5,0x4
 bb8:	fe043703          	ld	a4,-32(s0)
 bbc:	973e                	add	a4,a4,a5
 bbe:	fe843783          	ld	a5,-24(s0)
 bc2:	639c                	ld	a5,0(a5)
 bc4:	02f71763          	bne	a4,a5,bf2 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 bc8:	fe043783          	ld	a5,-32(s0)
 bcc:	4798                	lw	a4,8(a5)
 bce:	fe843783          	ld	a5,-24(s0)
 bd2:	639c                	ld	a5,0(a5)
 bd4:	479c                	lw	a5,8(a5)
 bd6:	9fb9                	addw	a5,a5,a4
 bd8:	0007871b          	sext.w	a4,a5
 bdc:	fe043783          	ld	a5,-32(s0)
 be0:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 be2:	fe843783          	ld	a5,-24(s0)
 be6:	639c                	ld	a5,0(a5)
 be8:	6398                	ld	a4,0(a5)
 bea:	fe043783          	ld	a5,-32(s0)
 bee:	e398                	sd	a4,0(a5)
 bf0:	a039                	j	bfe <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 bf2:	fe843783          	ld	a5,-24(s0)
 bf6:	6398                	ld	a4,0(a5)
 bf8:	fe043783          	ld	a5,-32(s0)
 bfc:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 bfe:	fe843783          	ld	a5,-24(s0)
 c02:	479c                	lw	a5,8(a5)
 c04:	1782                	slli	a5,a5,0x20
 c06:	9381                	srli	a5,a5,0x20
 c08:	0792                	slli	a5,a5,0x4
 c0a:	fe843703          	ld	a4,-24(s0)
 c0e:	97ba                	add	a5,a5,a4
 c10:	fe043703          	ld	a4,-32(s0)
 c14:	02f71563          	bne	a4,a5,c3e <free+0x102>
    p->s.size += bp->s.size;
 c18:	fe843783          	ld	a5,-24(s0)
 c1c:	4798                	lw	a4,8(a5)
 c1e:	fe043783          	ld	a5,-32(s0)
 c22:	479c                	lw	a5,8(a5)
 c24:	9fb9                	addw	a5,a5,a4
 c26:	0007871b          	sext.w	a4,a5
 c2a:	fe843783          	ld	a5,-24(s0)
 c2e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c30:	fe043783          	ld	a5,-32(s0)
 c34:	6398                	ld	a4,0(a5)
 c36:	fe843783          	ld	a5,-24(s0)
 c3a:	e398                	sd	a4,0(a5)
 c3c:	a031                	j	c48 <free+0x10c>
  } else
    p->s.ptr = bp;
 c3e:	fe843783          	ld	a5,-24(s0)
 c42:	fe043703          	ld	a4,-32(s0)
 c46:	e398                	sd	a4,0(a5)
  freep = p;
 c48:	00000797          	auipc	a5,0x0
 c4c:	29078793          	addi	a5,a5,656 # ed8 <freep>
 c50:	fe843703          	ld	a4,-24(s0)
 c54:	e398                	sd	a4,0(a5)
}
 c56:	0001                	nop
 c58:	7422                	ld	s0,40(sp)
 c5a:	6145                	addi	sp,sp,48
 c5c:	8082                	ret

0000000000000c5e <morecore>:

static Header*
morecore(uint nu)
{
 c5e:	7179                	addi	sp,sp,-48
 c60:	f406                	sd	ra,40(sp)
 c62:	f022                	sd	s0,32(sp)
 c64:	1800                	addi	s0,sp,48
 c66:	87aa                	mv	a5,a0
 c68:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 c6c:	fdc42783          	lw	a5,-36(s0)
 c70:	0007871b          	sext.w	a4,a5
 c74:	6785                	lui	a5,0x1
 c76:	00f77563          	bgeu	a4,a5,c80 <morecore+0x22>
    nu = 4096;
 c7a:	6785                	lui	a5,0x1
 c7c:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c80:	fdc42783          	lw	a5,-36(s0)
 c84:	0047979b          	slliw	a5,a5,0x4
 c88:	2781                	sext.w	a5,a5
 c8a:	2781                	sext.w	a5,a5
 c8c:	853e                	mv	a0,a5
 c8e:	00000097          	auipc	ra,0x0
 c92:	9a8080e7          	jalr	-1624(ra) # 636 <sbrk>
 c96:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c9a:	fe843703          	ld	a4,-24(s0)
 c9e:	57fd                	li	a5,-1
 ca0:	00f71463          	bne	a4,a5,ca8 <morecore+0x4a>
    return 0;
 ca4:	4781                	li	a5,0
 ca6:	a03d                	j	cd4 <morecore+0x76>
  hp = (Header*)p;
 ca8:	fe843783          	ld	a5,-24(s0)
 cac:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 cb0:	fe043783          	ld	a5,-32(s0)
 cb4:	fdc42703          	lw	a4,-36(s0)
 cb8:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 cba:	fe043783          	ld	a5,-32(s0)
 cbe:	07c1                	addi	a5,a5,16
 cc0:	853e                	mv	a0,a5
 cc2:	00000097          	auipc	ra,0x0
 cc6:	e7a080e7          	jalr	-390(ra) # b3c <free>
  return freep;
 cca:	00000797          	auipc	a5,0x0
 cce:	20e78793          	addi	a5,a5,526 # ed8 <freep>
 cd2:	639c                	ld	a5,0(a5)
}
 cd4:	853e                	mv	a0,a5
 cd6:	70a2                	ld	ra,40(sp)
 cd8:	7402                	ld	s0,32(sp)
 cda:	6145                	addi	sp,sp,48
 cdc:	8082                	ret

0000000000000cde <malloc>:

void*
malloc(uint nbytes)
{
 cde:	7139                	addi	sp,sp,-64
 ce0:	fc06                	sd	ra,56(sp)
 ce2:	f822                	sd	s0,48(sp)
 ce4:	0080                	addi	s0,sp,64
 ce6:	87aa                	mv	a5,a0
 ce8:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 cec:	fcc46783          	lwu	a5,-52(s0)
 cf0:	07bd                	addi	a5,a5,15
 cf2:	8391                	srli	a5,a5,0x4
 cf4:	2781                	sext.w	a5,a5
 cf6:	2785                	addiw	a5,a5,1
 cf8:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 cfc:	00000797          	auipc	a5,0x0
 d00:	1dc78793          	addi	a5,a5,476 # ed8 <freep>
 d04:	639c                	ld	a5,0(a5)
 d06:	fef43023          	sd	a5,-32(s0)
 d0a:	fe043783          	ld	a5,-32(s0)
 d0e:	ef95                	bnez	a5,d4a <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 d10:	00000797          	auipc	a5,0x0
 d14:	1b878793          	addi	a5,a5,440 # ec8 <base>
 d18:	fef43023          	sd	a5,-32(s0)
 d1c:	00000797          	auipc	a5,0x0
 d20:	1bc78793          	addi	a5,a5,444 # ed8 <freep>
 d24:	fe043703          	ld	a4,-32(s0)
 d28:	e398                	sd	a4,0(a5)
 d2a:	00000797          	auipc	a5,0x0
 d2e:	1ae78793          	addi	a5,a5,430 # ed8 <freep>
 d32:	6398                	ld	a4,0(a5)
 d34:	00000797          	auipc	a5,0x0
 d38:	19478793          	addi	a5,a5,404 # ec8 <base>
 d3c:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 d3e:	00000797          	auipc	a5,0x0
 d42:	18a78793          	addi	a5,a5,394 # ec8 <base>
 d46:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d4a:	fe043783          	ld	a5,-32(s0)
 d4e:	639c                	ld	a5,0(a5)
 d50:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d54:	fe843783          	ld	a5,-24(s0)
 d58:	4798                	lw	a4,8(a5)
 d5a:	fdc42783          	lw	a5,-36(s0)
 d5e:	2781                	sext.w	a5,a5
 d60:	06f76863          	bltu	a4,a5,dd0 <malloc+0xf2>
      if(p->s.size == nunits)
 d64:	fe843783          	ld	a5,-24(s0)
 d68:	4798                	lw	a4,8(a5)
 d6a:	fdc42783          	lw	a5,-36(s0)
 d6e:	2781                	sext.w	a5,a5
 d70:	00e79963          	bne	a5,a4,d82 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d74:	fe843783          	ld	a5,-24(s0)
 d78:	6398                	ld	a4,0(a5)
 d7a:	fe043783          	ld	a5,-32(s0)
 d7e:	e398                	sd	a4,0(a5)
 d80:	a82d                	j	dba <malloc+0xdc>
      else {
        p->s.size -= nunits;
 d82:	fe843783          	ld	a5,-24(s0)
 d86:	4798                	lw	a4,8(a5)
 d88:	fdc42783          	lw	a5,-36(s0)
 d8c:	40f707bb          	subw	a5,a4,a5
 d90:	0007871b          	sext.w	a4,a5
 d94:	fe843783          	ld	a5,-24(s0)
 d98:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d9a:	fe843783          	ld	a5,-24(s0)
 d9e:	479c                	lw	a5,8(a5)
 da0:	1782                	slli	a5,a5,0x20
 da2:	9381                	srli	a5,a5,0x20
 da4:	0792                	slli	a5,a5,0x4
 da6:	fe843703          	ld	a4,-24(s0)
 daa:	97ba                	add	a5,a5,a4
 dac:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 db0:	fe843783          	ld	a5,-24(s0)
 db4:	fdc42703          	lw	a4,-36(s0)
 db8:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 dba:	00000797          	auipc	a5,0x0
 dbe:	11e78793          	addi	a5,a5,286 # ed8 <freep>
 dc2:	fe043703          	ld	a4,-32(s0)
 dc6:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 dc8:	fe843783          	ld	a5,-24(s0)
 dcc:	07c1                	addi	a5,a5,16
 dce:	a091                	j	e12 <malloc+0x134>
    }
    if(p == freep)
 dd0:	00000797          	auipc	a5,0x0
 dd4:	10878793          	addi	a5,a5,264 # ed8 <freep>
 dd8:	639c                	ld	a5,0(a5)
 dda:	fe843703          	ld	a4,-24(s0)
 dde:	02f71063          	bne	a4,a5,dfe <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 de2:	fdc42783          	lw	a5,-36(s0)
 de6:	853e                	mv	a0,a5
 de8:	00000097          	auipc	ra,0x0
 dec:	e76080e7          	jalr	-394(ra) # c5e <morecore>
 df0:	fea43423          	sd	a0,-24(s0)
 df4:	fe843783          	ld	a5,-24(s0)
 df8:	e399                	bnez	a5,dfe <malloc+0x120>
        return 0;
 dfa:	4781                	li	a5,0
 dfc:	a819                	j	e12 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dfe:	fe843783          	ld	a5,-24(s0)
 e02:	fef43023          	sd	a5,-32(s0)
 e06:	fe843783          	ld	a5,-24(s0)
 e0a:	639c                	ld	a5,0(a5)
 e0c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 e10:	b791                	j	d54 <malloc+0x76>
  }
}
 e12:	853e                	mv	a0,a5
 e14:	70e2                	ld	ra,56(sp)
 e16:	7442                	ld	s0,48(sp)
 e18:	6121                	addi	sp,sp,64
 e1a:	8082                	ret
