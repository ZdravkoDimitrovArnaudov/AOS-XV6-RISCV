
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	0080                	addi	s0,sp,64
       8:	fca43423          	sd	a0,-56(s0)
       c:	87ae                	mv	a5,a1
       e:	fcf42223          	sw	a5,-60(s0)
  int n, m;
  char *p, *q;

  m = 0;
      12:	fe042623          	sw	zero,-20(s0)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
      16:	a0c5                	j	f6 <grep+0xf6>
    m += n;
      18:	fec42783          	lw	a5,-20(s0)
      1c:	873e                	mv	a4,a5
      1e:	fdc42783          	lw	a5,-36(s0)
      22:	9fb9                	addw	a5,a5,a4
      24:	fef42623          	sw	a5,-20(s0)
    buf[m] = '\0';
      28:	00001717          	auipc	a4,0x1
      2c:	2b870713          	addi	a4,a4,696 # 12e0 <buf>
      30:	fec42783          	lw	a5,-20(s0)
      34:	97ba                	add	a5,a5,a4
      36:	00078023          	sb	zero,0(a5)
    p = buf;
      3a:	00001797          	auipc	a5,0x1
      3e:	2a678793          	addi	a5,a5,678 # 12e0 <buf>
      42:	fef43023          	sd	a5,-32(s0)
    while((q = strchr(p, '\n')) != 0){
      46:	a891                	j	9a <grep+0x9a>
      *q = 0;
      48:	fd043783          	ld	a5,-48(s0)
      4c:	00078023          	sb	zero,0(a5)
      if(match(pattern, p)){
      50:	fe043583          	ld	a1,-32(s0)
      54:	fc843503          	ld	a0,-56(s0)
      58:	00000097          	auipc	ra,0x0
      5c:	1fc080e7          	jalr	508(ra) # 254 <match>
      60:	87aa                	mv	a5,a0
      62:	c79d                	beqz	a5,90 <grep+0x90>
        *q = '\n';
      64:	fd043783          	ld	a5,-48(s0)
      68:	4729                	li	a4,10
      6a:	00e78023          	sb	a4,0(a5)
        write(1, p, q+1 - p);
      6e:	fd043783          	ld	a5,-48(s0)
      72:	00178713          	addi	a4,a5,1
      76:	fe043783          	ld	a5,-32(s0)
      7a:	40f707b3          	sub	a5,a4,a5
      7e:	2781                	sext.w	a5,a5
      80:	863e                	mv	a2,a5
      82:	fe043583          	ld	a1,-32(s0)
      86:	4505                	li	a0,1
      88:	00001097          	auipc	ra,0x1
      8c:	846080e7          	jalr	-1978(ra) # 8ce <write>
      }
      p = q+1;
      90:	fd043783          	ld	a5,-48(s0)
      94:	0785                	addi	a5,a5,1
      96:	fef43023          	sd	a5,-32(s0)
    while((q = strchr(p, '\n')) != 0){
      9a:	45a9                	li	a1,10
      9c:	fe043503          	ld	a0,-32(s0)
      a0:	00000097          	auipc	ra,0x0
      a4:	4c2080e7          	jalr	1218(ra) # 562 <strchr>
      a8:	fca43823          	sd	a0,-48(s0)
      ac:	fd043783          	ld	a5,-48(s0)
      b0:	ffc1                	bnez	a5,48 <grep+0x48>
    }
    if(m > 0){
      b2:	fec42783          	lw	a5,-20(s0)
      b6:	2781                	sext.w	a5,a5
      b8:	02f05f63          	blez	a5,f6 <grep+0xf6>
      m -= p - buf;
      bc:	fec42703          	lw	a4,-20(s0)
      c0:	fe043683          	ld	a3,-32(s0)
      c4:	00001797          	auipc	a5,0x1
      c8:	21c78793          	addi	a5,a5,540 # 12e0 <buf>
      cc:	40f687b3          	sub	a5,a3,a5
      d0:	2781                	sext.w	a5,a5
      d2:	40f707bb          	subw	a5,a4,a5
      d6:	2781                	sext.w	a5,a5
      d8:	fef42623          	sw	a5,-20(s0)
      memmove(buf, p, m);
      dc:	fec42783          	lw	a5,-20(s0)
      e0:	863e                	mv	a2,a5
      e2:	fe043583          	ld	a1,-32(s0)
      e6:	00001517          	auipc	a0,0x1
      ea:	1fa50513          	addi	a0,a0,506 # 12e0 <buf>
      ee:	00000097          	auipc	ra,0x0
      f2:	63a080e7          	jalr	1594(ra) # 728 <memmove>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
      f6:	fec42703          	lw	a4,-20(s0)
      fa:	00001797          	auipc	a5,0x1
      fe:	1e678793          	addi	a5,a5,486 # 12e0 <buf>
     102:	00f706b3          	add	a3,a4,a5
     106:	fec42783          	lw	a5,-20(s0)
     10a:	3ff00713          	li	a4,1023
     10e:	40f707bb          	subw	a5,a4,a5
     112:	2781                	sext.w	a5,a5
     114:	0007871b          	sext.w	a4,a5
     118:	fc442783          	lw	a5,-60(s0)
     11c:	863a                	mv	a2,a4
     11e:	85b6                	mv	a1,a3
     120:	853e                	mv	a0,a5
     122:	00000097          	auipc	ra,0x0
     126:	7a4080e7          	jalr	1956(ra) # 8c6 <read>
     12a:	87aa                	mv	a5,a0
     12c:	fcf42e23          	sw	a5,-36(s0)
     130:	fdc42783          	lw	a5,-36(s0)
     134:	2781                	sext.w	a5,a5
     136:	eef041e3          	bgtz	a5,18 <grep+0x18>
    }
  }
}
     13a:	0001                	nop
     13c:	0001                	nop
     13e:	70e2                	ld	ra,56(sp)
     140:	7442                	ld	s0,48(sp)
     142:	6121                	addi	sp,sp,64
     144:	8082                	ret

0000000000000146 <main>:

int
main(int argc, char *argv[])
{
     146:	7139                	addi	sp,sp,-64
     148:	fc06                	sd	ra,56(sp)
     14a:	f822                	sd	s0,48(sp)
     14c:	0080                	addi	s0,sp,64
     14e:	87aa                	mv	a5,a0
     150:	fcb43023          	sd	a1,-64(s0)
     154:	fcf42623          	sw	a5,-52(s0)
  int fd, i;
  char *pattern;

  if(argc <= 1){
     158:	fcc42783          	lw	a5,-52(s0)
     15c:	0007871b          	sext.w	a4,a5
     160:	4785                	li	a5,1
     162:	02e7c063          	blt	a5,a4,182 <main+0x3c>
    fprintf(2, "usage: grep pattern [file ...]\n");
     166:	00001597          	auipc	a1,0x1
     16a:	0d258593          	addi	a1,a1,210 # 1238 <lock_init+0x1a>
     16e:	4509                	li	a0,2
     170:	00001097          	auipc	ra,0x1
     174:	c1e080e7          	jalr	-994(ra) # d8e <fprintf>
    exit(1);
     178:	4505                	li	a0,1
     17a:	00000097          	auipc	ra,0x0
     17e:	734080e7          	jalr	1844(ra) # 8ae <exit>
  }
  pattern = argv[1];
     182:	fc043783          	ld	a5,-64(s0)
     186:	679c                	ld	a5,8(a5)
     188:	fef43023          	sd	a5,-32(s0)

  if(argc <= 2){
     18c:	fcc42783          	lw	a5,-52(s0)
     190:	0007871b          	sext.w	a4,a5
     194:	4789                	li	a5,2
     196:	00e7ce63          	blt	a5,a4,1b2 <main+0x6c>
    grep(pattern, 0);
     19a:	4581                	li	a1,0
     19c:	fe043503          	ld	a0,-32(s0)
     1a0:	00000097          	auipc	ra,0x0
     1a4:	e60080e7          	jalr	-416(ra) # 0 <grep>
    exit(0);
     1a8:	4501                	li	a0,0
     1aa:	00000097          	auipc	ra,0x0
     1ae:	704080e7          	jalr	1796(ra) # 8ae <exit>
  }

  for(i = 2; i < argc; i++){
     1b2:	4789                	li	a5,2
     1b4:	fef42623          	sw	a5,-20(s0)
     1b8:	a041                	j	238 <main+0xf2>
    if((fd = open(argv[i], 0)) < 0){
     1ba:	fec42783          	lw	a5,-20(s0)
     1be:	078e                	slli	a5,a5,0x3
     1c0:	fc043703          	ld	a4,-64(s0)
     1c4:	97ba                	add	a5,a5,a4
     1c6:	639c                	ld	a5,0(a5)
     1c8:	4581                	li	a1,0
     1ca:	853e                	mv	a0,a5
     1cc:	00000097          	auipc	ra,0x0
     1d0:	722080e7          	jalr	1826(ra) # 8ee <open>
     1d4:	87aa                	mv	a5,a0
     1d6:	fcf42e23          	sw	a5,-36(s0)
     1da:	fdc42783          	lw	a5,-36(s0)
     1de:	2781                	sext.w	a5,a5
     1e0:	0207d763          	bgez	a5,20e <main+0xc8>
      printf("grep: cannot open %s\n", argv[i]);
     1e4:	fec42783          	lw	a5,-20(s0)
     1e8:	078e                	slli	a5,a5,0x3
     1ea:	fc043703          	ld	a4,-64(s0)
     1ee:	97ba                	add	a5,a5,a4
     1f0:	639c                	ld	a5,0(a5)
     1f2:	85be                	mv	a1,a5
     1f4:	00001517          	auipc	a0,0x1
     1f8:	06450513          	addi	a0,a0,100 # 1258 <lock_init+0x3a>
     1fc:	00001097          	auipc	ra,0x1
     200:	bea080e7          	jalr	-1046(ra) # de6 <printf>
      exit(1);
     204:	4505                	li	a0,1
     206:	00000097          	auipc	ra,0x0
     20a:	6a8080e7          	jalr	1704(ra) # 8ae <exit>
    }
    grep(pattern, fd);
     20e:	fdc42783          	lw	a5,-36(s0)
     212:	85be                	mv	a1,a5
     214:	fe043503          	ld	a0,-32(s0)
     218:	00000097          	auipc	ra,0x0
     21c:	de8080e7          	jalr	-536(ra) # 0 <grep>
    close(fd);
     220:	fdc42783          	lw	a5,-36(s0)
     224:	853e                	mv	a0,a5
     226:	00000097          	auipc	ra,0x0
     22a:	6b0080e7          	jalr	1712(ra) # 8d6 <close>
  for(i = 2; i < argc; i++){
     22e:	fec42783          	lw	a5,-20(s0)
     232:	2785                	addiw	a5,a5,1
     234:	fef42623          	sw	a5,-20(s0)
     238:	fec42783          	lw	a5,-20(s0)
     23c:	873e                	mv	a4,a5
     23e:	fcc42783          	lw	a5,-52(s0)
     242:	2701                	sext.w	a4,a4
     244:	2781                	sext.w	a5,a5
     246:	f6f74ae3          	blt	a4,a5,1ba <main+0x74>
  }
  exit(0);
     24a:	4501                	li	a0,0
     24c:	00000097          	auipc	ra,0x0
     250:	662080e7          	jalr	1634(ra) # 8ae <exit>

0000000000000254 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
     254:	1101                	addi	sp,sp,-32
     256:	ec06                	sd	ra,24(sp)
     258:	e822                	sd	s0,16(sp)
     25a:	1000                	addi	s0,sp,32
     25c:	fea43423          	sd	a0,-24(s0)
     260:	feb43023          	sd	a1,-32(s0)
  if(re[0] == '^')
     264:	fe843783          	ld	a5,-24(s0)
     268:	0007c783          	lbu	a5,0(a5)
     26c:	873e                	mv	a4,a5
     26e:	05e00793          	li	a5,94
     272:	00f71e63          	bne	a4,a5,28e <match+0x3a>
    return matchhere(re+1, text);
     276:	fe843783          	ld	a5,-24(s0)
     27a:	0785                	addi	a5,a5,1
     27c:	fe043583          	ld	a1,-32(s0)
     280:	853e                	mv	a0,a5
     282:	00000097          	auipc	ra,0x0
     286:	042080e7          	jalr	66(ra) # 2c4 <matchhere>
     28a:	87aa                	mv	a5,a0
     28c:	a03d                	j	2ba <match+0x66>
  do{  // must look at empty string
    if(matchhere(re, text))
     28e:	fe043583          	ld	a1,-32(s0)
     292:	fe843503          	ld	a0,-24(s0)
     296:	00000097          	auipc	ra,0x0
     29a:	02e080e7          	jalr	46(ra) # 2c4 <matchhere>
     29e:	87aa                	mv	a5,a0
     2a0:	c399                	beqz	a5,2a6 <match+0x52>
      return 1;
     2a2:	4785                	li	a5,1
     2a4:	a819                	j	2ba <match+0x66>
  }while(*text++ != '\0');
     2a6:	fe043783          	ld	a5,-32(s0)
     2aa:	00178713          	addi	a4,a5,1
     2ae:	fee43023          	sd	a4,-32(s0)
     2b2:	0007c783          	lbu	a5,0(a5)
     2b6:	ffe1                	bnez	a5,28e <match+0x3a>
  return 0;
     2b8:	4781                	li	a5,0
}
     2ba:	853e                	mv	a0,a5
     2bc:	60e2                	ld	ra,24(sp)
     2be:	6442                	ld	s0,16(sp)
     2c0:	6105                	addi	sp,sp,32
     2c2:	8082                	ret

00000000000002c4 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
     2c4:	1101                	addi	sp,sp,-32
     2c6:	ec06                	sd	ra,24(sp)
     2c8:	e822                	sd	s0,16(sp)
     2ca:	1000                	addi	s0,sp,32
     2cc:	fea43423          	sd	a0,-24(s0)
     2d0:	feb43023          	sd	a1,-32(s0)
  if(re[0] == '\0')
     2d4:	fe843783          	ld	a5,-24(s0)
     2d8:	0007c783          	lbu	a5,0(a5)
     2dc:	e399                	bnez	a5,2e2 <matchhere+0x1e>
    return 1;
     2de:	4785                	li	a5,1
     2e0:	a0c1                	j	3a0 <matchhere+0xdc>
  if(re[1] == '*')
     2e2:	fe843783          	ld	a5,-24(s0)
     2e6:	0785                	addi	a5,a5,1
     2e8:	0007c783          	lbu	a5,0(a5)
     2ec:	873e                	mv	a4,a5
     2ee:	02a00793          	li	a5,42
     2f2:	02f71563          	bne	a4,a5,31c <matchhere+0x58>
    return matchstar(re[0], re+2, text);
     2f6:	fe843783          	ld	a5,-24(s0)
     2fa:	0007c783          	lbu	a5,0(a5)
     2fe:	0007871b          	sext.w	a4,a5
     302:	fe843783          	ld	a5,-24(s0)
     306:	0789                	addi	a5,a5,2
     308:	fe043603          	ld	a2,-32(s0)
     30c:	85be                	mv	a1,a5
     30e:	853a                	mv	a0,a4
     310:	00000097          	auipc	ra,0x0
     314:	09a080e7          	jalr	154(ra) # 3aa <matchstar>
     318:	87aa                	mv	a5,a0
     31a:	a059                	j	3a0 <matchhere+0xdc>
  if(re[0] == '$' && re[1] == '\0')
     31c:	fe843783          	ld	a5,-24(s0)
     320:	0007c783          	lbu	a5,0(a5)
     324:	873e                	mv	a4,a5
     326:	02400793          	li	a5,36
     32a:	02f71363          	bne	a4,a5,350 <matchhere+0x8c>
     32e:	fe843783          	ld	a5,-24(s0)
     332:	0785                	addi	a5,a5,1
     334:	0007c783          	lbu	a5,0(a5)
     338:	ef81                	bnez	a5,350 <matchhere+0x8c>
    return *text == '\0';
     33a:	fe043783          	ld	a5,-32(s0)
     33e:	0007c783          	lbu	a5,0(a5)
     342:	2781                	sext.w	a5,a5
     344:	0017b793          	seqz	a5,a5
     348:	0ff7f793          	zext.b	a5,a5
     34c:	2781                	sext.w	a5,a5
     34e:	a889                	j	3a0 <matchhere+0xdc>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
     350:	fe043783          	ld	a5,-32(s0)
     354:	0007c783          	lbu	a5,0(a5)
     358:	c3b9                	beqz	a5,39e <matchhere+0xda>
     35a:	fe843783          	ld	a5,-24(s0)
     35e:	0007c783          	lbu	a5,0(a5)
     362:	873e                	mv	a4,a5
     364:	02e00793          	li	a5,46
     368:	00f70c63          	beq	a4,a5,380 <matchhere+0xbc>
     36c:	fe843783          	ld	a5,-24(s0)
     370:	0007c703          	lbu	a4,0(a5)
     374:	fe043783          	ld	a5,-32(s0)
     378:	0007c783          	lbu	a5,0(a5)
     37c:	02f71163          	bne	a4,a5,39e <matchhere+0xda>
    return matchhere(re+1, text+1);
     380:	fe843783          	ld	a5,-24(s0)
     384:	00178713          	addi	a4,a5,1
     388:	fe043783          	ld	a5,-32(s0)
     38c:	0785                	addi	a5,a5,1
     38e:	85be                	mv	a1,a5
     390:	853a                	mv	a0,a4
     392:	00000097          	auipc	ra,0x0
     396:	f32080e7          	jalr	-206(ra) # 2c4 <matchhere>
     39a:	87aa                	mv	a5,a0
     39c:	a011                	j	3a0 <matchhere+0xdc>
  return 0;
     39e:	4781                	li	a5,0
}
     3a0:	853e                	mv	a0,a5
     3a2:	60e2                	ld	ra,24(sp)
     3a4:	6442                	ld	s0,16(sp)
     3a6:	6105                	addi	sp,sp,32
     3a8:	8082                	ret

00000000000003aa <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
     3aa:	7179                	addi	sp,sp,-48
     3ac:	f406                	sd	ra,40(sp)
     3ae:	f022                	sd	s0,32(sp)
     3b0:	1800                	addi	s0,sp,48
     3b2:	87aa                	mv	a5,a0
     3b4:	feb43023          	sd	a1,-32(s0)
     3b8:	fcc43c23          	sd	a2,-40(s0)
     3bc:	fef42623          	sw	a5,-20(s0)
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
     3c0:	fd843583          	ld	a1,-40(s0)
     3c4:	fe043503          	ld	a0,-32(s0)
     3c8:	00000097          	auipc	ra,0x0
     3cc:	efc080e7          	jalr	-260(ra) # 2c4 <matchhere>
     3d0:	87aa                	mv	a5,a0
     3d2:	c399                	beqz	a5,3d8 <matchstar+0x2e>
      return 1;
     3d4:	4785                	li	a5,1
     3d6:	a835                	j	412 <matchstar+0x68>
  }while(*text!='\0' && (*text++==c || c=='.'));
     3d8:	fd843783          	ld	a5,-40(s0)
     3dc:	0007c783          	lbu	a5,0(a5)
     3e0:	cb85                	beqz	a5,410 <matchstar+0x66>
     3e2:	fd843783          	ld	a5,-40(s0)
     3e6:	00178713          	addi	a4,a5,1
     3ea:	fce43c23          	sd	a4,-40(s0)
     3ee:	0007c783          	lbu	a5,0(a5)
     3f2:	0007871b          	sext.w	a4,a5
     3f6:	fec42783          	lw	a5,-20(s0)
     3fa:	2781                	sext.w	a5,a5
     3fc:	fce782e3          	beq	a5,a4,3c0 <matchstar+0x16>
     400:	fec42783          	lw	a5,-20(s0)
     404:	0007871b          	sext.w	a4,a5
     408:	02e00793          	li	a5,46
     40c:	faf70ae3          	beq	a4,a5,3c0 <matchstar+0x16>
  return 0;
     410:	4781                	li	a5,0
}
     412:	853e                	mv	a0,a5
     414:	70a2                	ld	ra,40(sp)
     416:	7402                	ld	s0,32(sp)
     418:	6145                	addi	sp,sp,48
     41a:	8082                	ret

000000000000041c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     41c:	7179                	addi	sp,sp,-48
     41e:	f422                	sd	s0,40(sp)
     420:	1800                	addi	s0,sp,48
     422:	fca43c23          	sd	a0,-40(s0)
     426:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     42a:	fd843783          	ld	a5,-40(s0)
     42e:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     432:	0001                	nop
     434:	fd043703          	ld	a4,-48(s0)
     438:	00170793          	addi	a5,a4,1
     43c:	fcf43823          	sd	a5,-48(s0)
     440:	fd843783          	ld	a5,-40(s0)
     444:	00178693          	addi	a3,a5,1
     448:	fcd43c23          	sd	a3,-40(s0)
     44c:	00074703          	lbu	a4,0(a4)
     450:	00e78023          	sb	a4,0(a5)
     454:	0007c783          	lbu	a5,0(a5)
     458:	fff1                	bnez	a5,434 <strcpy+0x18>
    ;
  return os;
     45a:	fe843783          	ld	a5,-24(s0)
}
     45e:	853e                	mv	a0,a5
     460:	7422                	ld	s0,40(sp)
     462:	6145                	addi	sp,sp,48
     464:	8082                	ret

0000000000000466 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     466:	1101                	addi	sp,sp,-32
     468:	ec22                	sd	s0,24(sp)
     46a:	1000                	addi	s0,sp,32
     46c:	fea43423          	sd	a0,-24(s0)
     470:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     474:	a819                	j	48a <strcmp+0x24>
    p++, q++;
     476:	fe843783          	ld	a5,-24(s0)
     47a:	0785                	addi	a5,a5,1
     47c:	fef43423          	sd	a5,-24(s0)
     480:	fe043783          	ld	a5,-32(s0)
     484:	0785                	addi	a5,a5,1
     486:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     48a:	fe843783          	ld	a5,-24(s0)
     48e:	0007c783          	lbu	a5,0(a5)
     492:	cb99                	beqz	a5,4a8 <strcmp+0x42>
     494:	fe843783          	ld	a5,-24(s0)
     498:	0007c703          	lbu	a4,0(a5)
     49c:	fe043783          	ld	a5,-32(s0)
     4a0:	0007c783          	lbu	a5,0(a5)
     4a4:	fcf709e3          	beq	a4,a5,476 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     4a8:	fe843783          	ld	a5,-24(s0)
     4ac:	0007c783          	lbu	a5,0(a5)
     4b0:	0007871b          	sext.w	a4,a5
     4b4:	fe043783          	ld	a5,-32(s0)
     4b8:	0007c783          	lbu	a5,0(a5)
     4bc:	2781                	sext.w	a5,a5
     4be:	40f707bb          	subw	a5,a4,a5
     4c2:	2781                	sext.w	a5,a5
}
     4c4:	853e                	mv	a0,a5
     4c6:	6462                	ld	s0,24(sp)
     4c8:	6105                	addi	sp,sp,32
     4ca:	8082                	ret

00000000000004cc <strlen>:

uint
strlen(const char *s)
{
     4cc:	7179                	addi	sp,sp,-48
     4ce:	f422                	sd	s0,40(sp)
     4d0:	1800                	addi	s0,sp,48
     4d2:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     4d6:	fe042623          	sw	zero,-20(s0)
     4da:	a031                	j	4e6 <strlen+0x1a>
     4dc:	fec42783          	lw	a5,-20(s0)
     4e0:	2785                	addiw	a5,a5,1
     4e2:	fef42623          	sw	a5,-20(s0)
     4e6:	fec42783          	lw	a5,-20(s0)
     4ea:	fd843703          	ld	a4,-40(s0)
     4ee:	97ba                	add	a5,a5,a4
     4f0:	0007c783          	lbu	a5,0(a5)
     4f4:	f7e5                	bnez	a5,4dc <strlen+0x10>
    ;
  return n;
     4f6:	fec42783          	lw	a5,-20(s0)
}
     4fa:	853e                	mv	a0,a5
     4fc:	7422                	ld	s0,40(sp)
     4fe:	6145                	addi	sp,sp,48
     500:	8082                	ret

0000000000000502 <memset>:

void*
memset(void *dst, int c, uint n)
{
     502:	7179                	addi	sp,sp,-48
     504:	f422                	sd	s0,40(sp)
     506:	1800                	addi	s0,sp,48
     508:	fca43c23          	sd	a0,-40(s0)
     50c:	87ae                	mv	a5,a1
     50e:	8732                	mv	a4,a2
     510:	fcf42a23          	sw	a5,-44(s0)
     514:	87ba                	mv	a5,a4
     516:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     51a:	fd843783          	ld	a5,-40(s0)
     51e:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     522:	fe042623          	sw	zero,-20(s0)
     526:	a00d                	j	548 <memset+0x46>
    cdst[i] = c;
     528:	fec42783          	lw	a5,-20(s0)
     52c:	fe043703          	ld	a4,-32(s0)
     530:	97ba                	add	a5,a5,a4
     532:	fd442703          	lw	a4,-44(s0)
     536:	0ff77713          	zext.b	a4,a4
     53a:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     53e:	fec42783          	lw	a5,-20(s0)
     542:	2785                	addiw	a5,a5,1
     544:	fef42623          	sw	a5,-20(s0)
     548:	fec42703          	lw	a4,-20(s0)
     54c:	fd042783          	lw	a5,-48(s0)
     550:	2781                	sext.w	a5,a5
     552:	fcf76be3          	bltu	a4,a5,528 <memset+0x26>
  }
  return dst;
     556:	fd843783          	ld	a5,-40(s0)
}
     55a:	853e                	mv	a0,a5
     55c:	7422                	ld	s0,40(sp)
     55e:	6145                	addi	sp,sp,48
     560:	8082                	ret

0000000000000562 <strchr>:

char*
strchr(const char *s, char c)
{
     562:	1101                	addi	sp,sp,-32
     564:	ec22                	sd	s0,24(sp)
     566:	1000                	addi	s0,sp,32
     568:	fea43423          	sd	a0,-24(s0)
     56c:	87ae                	mv	a5,a1
     56e:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     572:	a01d                	j	598 <strchr+0x36>
    if(*s == c)
     574:	fe843783          	ld	a5,-24(s0)
     578:	0007c703          	lbu	a4,0(a5)
     57c:	fe744783          	lbu	a5,-25(s0)
     580:	0ff7f793          	zext.b	a5,a5
     584:	00e79563          	bne	a5,a4,58e <strchr+0x2c>
      return (char*)s;
     588:	fe843783          	ld	a5,-24(s0)
     58c:	a821                	j	5a4 <strchr+0x42>
  for(; *s; s++)
     58e:	fe843783          	ld	a5,-24(s0)
     592:	0785                	addi	a5,a5,1
     594:	fef43423          	sd	a5,-24(s0)
     598:	fe843783          	ld	a5,-24(s0)
     59c:	0007c783          	lbu	a5,0(a5)
     5a0:	fbf1                	bnez	a5,574 <strchr+0x12>
  return 0;
     5a2:	4781                	li	a5,0
}
     5a4:	853e                	mv	a0,a5
     5a6:	6462                	ld	s0,24(sp)
     5a8:	6105                	addi	sp,sp,32
     5aa:	8082                	ret

00000000000005ac <gets>:

char*
gets(char *buf, int max)
{
     5ac:	7179                	addi	sp,sp,-48
     5ae:	f406                	sd	ra,40(sp)
     5b0:	f022                	sd	s0,32(sp)
     5b2:	1800                	addi	s0,sp,48
     5b4:	fca43c23          	sd	a0,-40(s0)
     5b8:	87ae                	mv	a5,a1
     5ba:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     5be:	fe042623          	sw	zero,-20(s0)
     5c2:	a8a1                	j	61a <gets+0x6e>
    cc = read(0, &c, 1);
     5c4:	fe740793          	addi	a5,s0,-25
     5c8:	4605                	li	a2,1
     5ca:	85be                	mv	a1,a5
     5cc:	4501                	li	a0,0
     5ce:	00000097          	auipc	ra,0x0
     5d2:	2f8080e7          	jalr	760(ra) # 8c6 <read>
     5d6:	87aa                	mv	a5,a0
     5d8:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     5dc:	fe842783          	lw	a5,-24(s0)
     5e0:	2781                	sext.w	a5,a5
     5e2:	04f05763          	blez	a5,630 <gets+0x84>
      break;
    buf[i++] = c;
     5e6:	fec42783          	lw	a5,-20(s0)
     5ea:	0017871b          	addiw	a4,a5,1
     5ee:	fee42623          	sw	a4,-20(s0)
     5f2:	873e                	mv	a4,a5
     5f4:	fd843783          	ld	a5,-40(s0)
     5f8:	97ba                	add	a5,a5,a4
     5fa:	fe744703          	lbu	a4,-25(s0)
     5fe:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     602:	fe744783          	lbu	a5,-25(s0)
     606:	873e                	mv	a4,a5
     608:	47a9                	li	a5,10
     60a:	02f70463          	beq	a4,a5,632 <gets+0x86>
     60e:	fe744783          	lbu	a5,-25(s0)
     612:	873e                	mv	a4,a5
     614:	47b5                	li	a5,13
     616:	00f70e63          	beq	a4,a5,632 <gets+0x86>
  for(i=0; i+1 < max; ){
     61a:	fec42783          	lw	a5,-20(s0)
     61e:	2785                	addiw	a5,a5,1
     620:	0007871b          	sext.w	a4,a5
     624:	fd442783          	lw	a5,-44(s0)
     628:	2781                	sext.w	a5,a5
     62a:	f8f74de3          	blt	a4,a5,5c4 <gets+0x18>
     62e:	a011                	j	632 <gets+0x86>
      break;
     630:	0001                	nop
      break;
  }
  buf[i] = '\0';
     632:	fec42783          	lw	a5,-20(s0)
     636:	fd843703          	ld	a4,-40(s0)
     63a:	97ba                	add	a5,a5,a4
     63c:	00078023          	sb	zero,0(a5)
  return buf;
     640:	fd843783          	ld	a5,-40(s0)
}
     644:	853e                	mv	a0,a5
     646:	70a2                	ld	ra,40(sp)
     648:	7402                	ld	s0,32(sp)
     64a:	6145                	addi	sp,sp,48
     64c:	8082                	ret

000000000000064e <stat>:

int
stat(const char *n, struct stat *st)
{
     64e:	7179                	addi	sp,sp,-48
     650:	f406                	sd	ra,40(sp)
     652:	f022                	sd	s0,32(sp)
     654:	1800                	addi	s0,sp,48
     656:	fca43c23          	sd	a0,-40(s0)
     65a:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     65e:	4581                	li	a1,0
     660:	fd843503          	ld	a0,-40(s0)
     664:	00000097          	auipc	ra,0x0
     668:	28a080e7          	jalr	650(ra) # 8ee <open>
     66c:	87aa                	mv	a5,a0
     66e:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     672:	fec42783          	lw	a5,-20(s0)
     676:	2781                	sext.w	a5,a5
     678:	0007d463          	bgez	a5,680 <stat+0x32>
    return -1;
     67c:	57fd                	li	a5,-1
     67e:	a035                	j	6aa <stat+0x5c>
  r = fstat(fd, st);
     680:	fec42783          	lw	a5,-20(s0)
     684:	fd043583          	ld	a1,-48(s0)
     688:	853e                	mv	a0,a5
     68a:	00000097          	auipc	ra,0x0
     68e:	27c080e7          	jalr	636(ra) # 906 <fstat>
     692:	87aa                	mv	a5,a0
     694:	fef42423          	sw	a5,-24(s0)
  close(fd);
     698:	fec42783          	lw	a5,-20(s0)
     69c:	853e                	mv	a0,a5
     69e:	00000097          	auipc	ra,0x0
     6a2:	238080e7          	jalr	568(ra) # 8d6 <close>
  return r;
     6a6:	fe842783          	lw	a5,-24(s0)
}
     6aa:	853e                	mv	a0,a5
     6ac:	70a2                	ld	ra,40(sp)
     6ae:	7402                	ld	s0,32(sp)
     6b0:	6145                	addi	sp,sp,48
     6b2:	8082                	ret

00000000000006b4 <atoi>:

int
atoi(const char *s)
{
     6b4:	7179                	addi	sp,sp,-48
     6b6:	f422                	sd	s0,40(sp)
     6b8:	1800                	addi	s0,sp,48
     6ba:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     6be:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     6c2:	a81d                	j	6f8 <atoi+0x44>
    n = n*10 + *s++ - '0';
     6c4:	fec42783          	lw	a5,-20(s0)
     6c8:	873e                	mv	a4,a5
     6ca:	87ba                	mv	a5,a4
     6cc:	0027979b          	slliw	a5,a5,0x2
     6d0:	9fb9                	addw	a5,a5,a4
     6d2:	0017979b          	slliw	a5,a5,0x1
     6d6:	0007871b          	sext.w	a4,a5
     6da:	fd843783          	ld	a5,-40(s0)
     6de:	00178693          	addi	a3,a5,1
     6e2:	fcd43c23          	sd	a3,-40(s0)
     6e6:	0007c783          	lbu	a5,0(a5)
     6ea:	2781                	sext.w	a5,a5
     6ec:	9fb9                	addw	a5,a5,a4
     6ee:	2781                	sext.w	a5,a5
     6f0:	fd07879b          	addiw	a5,a5,-48
     6f4:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     6f8:	fd843783          	ld	a5,-40(s0)
     6fc:	0007c783          	lbu	a5,0(a5)
     700:	873e                	mv	a4,a5
     702:	02f00793          	li	a5,47
     706:	00e7fb63          	bgeu	a5,a4,71c <atoi+0x68>
     70a:	fd843783          	ld	a5,-40(s0)
     70e:	0007c783          	lbu	a5,0(a5)
     712:	873e                	mv	a4,a5
     714:	03900793          	li	a5,57
     718:	fae7f6e3          	bgeu	a5,a4,6c4 <atoi+0x10>
  return n;
     71c:	fec42783          	lw	a5,-20(s0)
}
     720:	853e                	mv	a0,a5
     722:	7422                	ld	s0,40(sp)
     724:	6145                	addi	sp,sp,48
     726:	8082                	ret

0000000000000728 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     728:	7139                	addi	sp,sp,-64
     72a:	fc22                	sd	s0,56(sp)
     72c:	0080                	addi	s0,sp,64
     72e:	fca43c23          	sd	a0,-40(s0)
     732:	fcb43823          	sd	a1,-48(s0)
     736:	87b2                	mv	a5,a2
     738:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     73c:	fd843783          	ld	a5,-40(s0)
     740:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     744:	fd043783          	ld	a5,-48(s0)
     748:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     74c:	fe043703          	ld	a4,-32(s0)
     750:	fe843783          	ld	a5,-24(s0)
     754:	02e7fc63          	bgeu	a5,a4,78c <memmove+0x64>
    while(n-- > 0)
     758:	a00d                	j	77a <memmove+0x52>
      *dst++ = *src++;
     75a:	fe043703          	ld	a4,-32(s0)
     75e:	00170793          	addi	a5,a4,1
     762:	fef43023          	sd	a5,-32(s0)
     766:	fe843783          	ld	a5,-24(s0)
     76a:	00178693          	addi	a3,a5,1
     76e:	fed43423          	sd	a3,-24(s0)
     772:	00074703          	lbu	a4,0(a4)
     776:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     77a:	fcc42783          	lw	a5,-52(s0)
     77e:	fff7871b          	addiw	a4,a5,-1
     782:	fce42623          	sw	a4,-52(s0)
     786:	fcf04ae3          	bgtz	a5,75a <memmove+0x32>
     78a:	a891                	j	7de <memmove+0xb6>
  } else {
    dst += n;
     78c:	fcc42783          	lw	a5,-52(s0)
     790:	fe843703          	ld	a4,-24(s0)
     794:	97ba                	add	a5,a5,a4
     796:	fef43423          	sd	a5,-24(s0)
    src += n;
     79a:	fcc42783          	lw	a5,-52(s0)
     79e:	fe043703          	ld	a4,-32(s0)
     7a2:	97ba                	add	a5,a5,a4
     7a4:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     7a8:	a01d                	j	7ce <memmove+0xa6>
      *--dst = *--src;
     7aa:	fe043783          	ld	a5,-32(s0)
     7ae:	17fd                	addi	a5,a5,-1
     7b0:	fef43023          	sd	a5,-32(s0)
     7b4:	fe843783          	ld	a5,-24(s0)
     7b8:	17fd                	addi	a5,a5,-1
     7ba:	fef43423          	sd	a5,-24(s0)
     7be:	fe043783          	ld	a5,-32(s0)
     7c2:	0007c703          	lbu	a4,0(a5)
     7c6:	fe843783          	ld	a5,-24(s0)
     7ca:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     7ce:	fcc42783          	lw	a5,-52(s0)
     7d2:	fff7871b          	addiw	a4,a5,-1
     7d6:	fce42623          	sw	a4,-52(s0)
     7da:	fcf048e3          	bgtz	a5,7aa <memmove+0x82>
  }
  return vdst;
     7de:	fd843783          	ld	a5,-40(s0)
}
     7e2:	853e                	mv	a0,a5
     7e4:	7462                	ld	s0,56(sp)
     7e6:	6121                	addi	sp,sp,64
     7e8:	8082                	ret

00000000000007ea <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     7ea:	7139                	addi	sp,sp,-64
     7ec:	fc22                	sd	s0,56(sp)
     7ee:	0080                	addi	s0,sp,64
     7f0:	fca43c23          	sd	a0,-40(s0)
     7f4:	fcb43823          	sd	a1,-48(s0)
     7f8:	87b2                	mv	a5,a2
     7fa:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     7fe:	fd843783          	ld	a5,-40(s0)
     802:	fef43423          	sd	a5,-24(s0)
     806:	fd043783          	ld	a5,-48(s0)
     80a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     80e:	a0a1                	j	856 <memcmp+0x6c>
    if (*p1 != *p2) {
     810:	fe843783          	ld	a5,-24(s0)
     814:	0007c703          	lbu	a4,0(a5)
     818:	fe043783          	ld	a5,-32(s0)
     81c:	0007c783          	lbu	a5,0(a5)
     820:	02f70163          	beq	a4,a5,842 <memcmp+0x58>
      return *p1 - *p2;
     824:	fe843783          	ld	a5,-24(s0)
     828:	0007c783          	lbu	a5,0(a5)
     82c:	0007871b          	sext.w	a4,a5
     830:	fe043783          	ld	a5,-32(s0)
     834:	0007c783          	lbu	a5,0(a5)
     838:	2781                	sext.w	a5,a5
     83a:	40f707bb          	subw	a5,a4,a5
     83e:	2781                	sext.w	a5,a5
     840:	a01d                	j	866 <memcmp+0x7c>
    }
    p1++;
     842:	fe843783          	ld	a5,-24(s0)
     846:	0785                	addi	a5,a5,1
     848:	fef43423          	sd	a5,-24(s0)
    p2++;
     84c:	fe043783          	ld	a5,-32(s0)
     850:	0785                	addi	a5,a5,1
     852:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     856:	fcc42783          	lw	a5,-52(s0)
     85a:	fff7871b          	addiw	a4,a5,-1
     85e:	fce42623          	sw	a4,-52(s0)
     862:	f7dd                	bnez	a5,810 <memcmp+0x26>
  }
  return 0;
     864:	4781                	li	a5,0
}
     866:	853e                	mv	a0,a5
     868:	7462                	ld	s0,56(sp)
     86a:	6121                	addi	sp,sp,64
     86c:	8082                	ret

000000000000086e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     86e:	7179                	addi	sp,sp,-48
     870:	f406                	sd	ra,40(sp)
     872:	f022                	sd	s0,32(sp)
     874:	1800                	addi	s0,sp,48
     876:	fea43423          	sd	a0,-24(s0)
     87a:	feb43023          	sd	a1,-32(s0)
     87e:	87b2                	mv	a5,a2
     880:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     884:	fdc42783          	lw	a5,-36(s0)
     888:	863e                	mv	a2,a5
     88a:	fe043583          	ld	a1,-32(s0)
     88e:	fe843503          	ld	a0,-24(s0)
     892:	00000097          	auipc	ra,0x0
     896:	e96080e7          	jalr	-362(ra) # 728 <memmove>
     89a:	87aa                	mv	a5,a0
}
     89c:	853e                	mv	a0,a5
     89e:	70a2                	ld	ra,40(sp)
     8a0:	7402                	ld	s0,32(sp)
     8a2:	6145                	addi	sp,sp,48
     8a4:	8082                	ret

00000000000008a6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     8a6:	4885                	li	a7,1
 ecall
     8a8:	00000073          	ecall
 ret
     8ac:	8082                	ret

00000000000008ae <exit>:
.global exit
exit:
 li a7, SYS_exit
     8ae:	4889                	li	a7,2
 ecall
     8b0:	00000073          	ecall
 ret
     8b4:	8082                	ret

00000000000008b6 <wait>:
.global wait
wait:
 li a7, SYS_wait
     8b6:	488d                	li	a7,3
 ecall
     8b8:	00000073          	ecall
 ret
     8bc:	8082                	ret

00000000000008be <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     8be:	4891                	li	a7,4
 ecall
     8c0:	00000073          	ecall
 ret
     8c4:	8082                	ret

00000000000008c6 <read>:
.global read
read:
 li a7, SYS_read
     8c6:	4895                	li	a7,5
 ecall
     8c8:	00000073          	ecall
 ret
     8cc:	8082                	ret

00000000000008ce <write>:
.global write
write:
 li a7, SYS_write
     8ce:	48c1                	li	a7,16
 ecall
     8d0:	00000073          	ecall
 ret
     8d4:	8082                	ret

00000000000008d6 <close>:
.global close
close:
 li a7, SYS_close
     8d6:	48d5                	li	a7,21
 ecall
     8d8:	00000073          	ecall
 ret
     8dc:	8082                	ret

00000000000008de <kill>:
.global kill
kill:
 li a7, SYS_kill
     8de:	4899                	li	a7,6
 ecall
     8e0:	00000073          	ecall
 ret
     8e4:	8082                	ret

00000000000008e6 <exec>:
.global exec
exec:
 li a7, SYS_exec
     8e6:	489d                	li	a7,7
 ecall
     8e8:	00000073          	ecall
 ret
     8ec:	8082                	ret

00000000000008ee <open>:
.global open
open:
 li a7, SYS_open
     8ee:	48bd                	li	a7,15
 ecall
     8f0:	00000073          	ecall
 ret
     8f4:	8082                	ret

00000000000008f6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     8f6:	48c5                	li	a7,17
 ecall
     8f8:	00000073          	ecall
 ret
     8fc:	8082                	ret

00000000000008fe <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     8fe:	48c9                	li	a7,18
 ecall
     900:	00000073          	ecall
 ret
     904:	8082                	ret

0000000000000906 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     906:	48a1                	li	a7,8
 ecall
     908:	00000073          	ecall
 ret
     90c:	8082                	ret

000000000000090e <link>:
.global link
link:
 li a7, SYS_link
     90e:	48cd                	li	a7,19
 ecall
     910:	00000073          	ecall
 ret
     914:	8082                	ret

0000000000000916 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     916:	48d1                	li	a7,20
 ecall
     918:	00000073          	ecall
 ret
     91c:	8082                	ret

000000000000091e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     91e:	48a5                	li	a7,9
 ecall
     920:	00000073          	ecall
 ret
     924:	8082                	ret

0000000000000926 <dup>:
.global dup
dup:
 li a7, SYS_dup
     926:	48a9                	li	a7,10
 ecall
     928:	00000073          	ecall
 ret
     92c:	8082                	ret

000000000000092e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     92e:	48ad                	li	a7,11
 ecall
     930:	00000073          	ecall
 ret
     934:	8082                	ret

0000000000000936 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     936:	48b1                	li	a7,12
 ecall
     938:	00000073          	ecall
 ret
     93c:	8082                	ret

000000000000093e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     93e:	48b5                	li	a7,13
 ecall
     940:	00000073          	ecall
 ret
     944:	8082                	ret

0000000000000946 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     946:	48b9                	li	a7,14
 ecall
     948:	00000073          	ecall
 ret
     94c:	8082                	ret

000000000000094e <clone>:
.global clone
clone:
 li a7, SYS_clone
     94e:	48d9                	li	a7,22
 ecall
     950:	00000073          	ecall
 ret
     954:	8082                	ret

0000000000000956 <join>:
.global join
join:
 li a7, SYS_join
     956:	48dd                	li	a7,23
 ecall
     958:	00000073          	ecall
 ret
     95c:	8082                	ret

000000000000095e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     95e:	1101                	addi	sp,sp,-32
     960:	ec06                	sd	ra,24(sp)
     962:	e822                	sd	s0,16(sp)
     964:	1000                	addi	s0,sp,32
     966:	87aa                	mv	a5,a0
     968:	872e                	mv	a4,a1
     96a:	fef42623          	sw	a5,-20(s0)
     96e:	87ba                	mv	a5,a4
     970:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     974:	feb40713          	addi	a4,s0,-21
     978:	fec42783          	lw	a5,-20(s0)
     97c:	4605                	li	a2,1
     97e:	85ba                	mv	a1,a4
     980:	853e                	mv	a0,a5
     982:	00000097          	auipc	ra,0x0
     986:	f4c080e7          	jalr	-180(ra) # 8ce <write>
}
     98a:	0001                	nop
     98c:	60e2                	ld	ra,24(sp)
     98e:	6442                	ld	s0,16(sp)
     990:	6105                	addi	sp,sp,32
     992:	8082                	ret

0000000000000994 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     994:	7139                	addi	sp,sp,-64
     996:	fc06                	sd	ra,56(sp)
     998:	f822                	sd	s0,48(sp)
     99a:	0080                	addi	s0,sp,64
     99c:	87aa                	mv	a5,a0
     99e:	8736                	mv	a4,a3
     9a0:	fcf42623          	sw	a5,-52(s0)
     9a4:	87ae                	mv	a5,a1
     9a6:	fcf42423          	sw	a5,-56(s0)
     9aa:	87b2                	mv	a5,a2
     9ac:	fcf42223          	sw	a5,-60(s0)
     9b0:	87ba                	mv	a5,a4
     9b2:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     9b6:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     9ba:	fc042783          	lw	a5,-64(s0)
     9be:	2781                	sext.w	a5,a5
     9c0:	c38d                	beqz	a5,9e2 <printint+0x4e>
     9c2:	fc842783          	lw	a5,-56(s0)
     9c6:	2781                	sext.w	a5,a5
     9c8:	0007dd63          	bgez	a5,9e2 <printint+0x4e>
    neg = 1;
     9cc:	4785                	li	a5,1
     9ce:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     9d2:	fc842783          	lw	a5,-56(s0)
     9d6:	40f007bb          	negw	a5,a5
     9da:	2781                	sext.w	a5,a5
     9dc:	fef42223          	sw	a5,-28(s0)
     9e0:	a029                	j	9ea <printint+0x56>
  } else {
    x = xx;
     9e2:	fc842783          	lw	a5,-56(s0)
     9e6:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     9ea:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     9ee:	fc442783          	lw	a5,-60(s0)
     9f2:	fe442703          	lw	a4,-28(s0)
     9f6:	02f777bb          	remuw	a5,a4,a5
     9fa:	0007861b          	sext.w	a2,a5
     9fe:	fec42783          	lw	a5,-20(s0)
     a02:	0017871b          	addiw	a4,a5,1
     a06:	fee42623          	sw	a4,-20(s0)
     a0a:	00001697          	auipc	a3,0x1
     a0e:	8be68693          	addi	a3,a3,-1858 # 12c8 <digits>
     a12:	02061713          	slli	a4,a2,0x20
     a16:	9301                	srli	a4,a4,0x20
     a18:	9736                	add	a4,a4,a3
     a1a:	00074703          	lbu	a4,0(a4)
     a1e:	17c1                	addi	a5,a5,-16
     a20:	97a2                	add	a5,a5,s0
     a22:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     a26:	fc442783          	lw	a5,-60(s0)
     a2a:	fe442703          	lw	a4,-28(s0)
     a2e:	02f757bb          	divuw	a5,a4,a5
     a32:	fef42223          	sw	a5,-28(s0)
     a36:	fe442783          	lw	a5,-28(s0)
     a3a:	2781                	sext.w	a5,a5
     a3c:	fbcd                	bnez	a5,9ee <printint+0x5a>
  if(neg)
     a3e:	fe842783          	lw	a5,-24(s0)
     a42:	2781                	sext.w	a5,a5
     a44:	cf85                	beqz	a5,a7c <printint+0xe8>
    buf[i++] = '-';
     a46:	fec42783          	lw	a5,-20(s0)
     a4a:	0017871b          	addiw	a4,a5,1
     a4e:	fee42623          	sw	a4,-20(s0)
     a52:	17c1                	addi	a5,a5,-16
     a54:	97a2                	add	a5,a5,s0
     a56:	02d00713          	li	a4,45
     a5a:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     a5e:	a839                	j	a7c <printint+0xe8>
    putc(fd, buf[i]);
     a60:	fec42783          	lw	a5,-20(s0)
     a64:	17c1                	addi	a5,a5,-16
     a66:	97a2                	add	a5,a5,s0
     a68:	fe07c703          	lbu	a4,-32(a5)
     a6c:	fcc42783          	lw	a5,-52(s0)
     a70:	85ba                	mv	a1,a4
     a72:	853e                	mv	a0,a5
     a74:	00000097          	auipc	ra,0x0
     a78:	eea080e7          	jalr	-278(ra) # 95e <putc>
  while(--i >= 0)
     a7c:	fec42783          	lw	a5,-20(s0)
     a80:	37fd                	addiw	a5,a5,-1
     a82:	fef42623          	sw	a5,-20(s0)
     a86:	fec42783          	lw	a5,-20(s0)
     a8a:	2781                	sext.w	a5,a5
     a8c:	fc07dae3          	bgez	a5,a60 <printint+0xcc>
}
     a90:	0001                	nop
     a92:	0001                	nop
     a94:	70e2                	ld	ra,56(sp)
     a96:	7442                	ld	s0,48(sp)
     a98:	6121                	addi	sp,sp,64
     a9a:	8082                	ret

0000000000000a9c <printptr>:

static void
printptr(int fd, uint64 x) {
     a9c:	7179                	addi	sp,sp,-48
     a9e:	f406                	sd	ra,40(sp)
     aa0:	f022                	sd	s0,32(sp)
     aa2:	1800                	addi	s0,sp,48
     aa4:	87aa                	mv	a5,a0
     aa6:	fcb43823          	sd	a1,-48(s0)
     aaa:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     aae:	fdc42783          	lw	a5,-36(s0)
     ab2:	03000593          	li	a1,48
     ab6:	853e                	mv	a0,a5
     ab8:	00000097          	auipc	ra,0x0
     abc:	ea6080e7          	jalr	-346(ra) # 95e <putc>
  putc(fd, 'x');
     ac0:	fdc42783          	lw	a5,-36(s0)
     ac4:	07800593          	li	a1,120
     ac8:	853e                	mv	a0,a5
     aca:	00000097          	auipc	ra,0x0
     ace:	e94080e7          	jalr	-364(ra) # 95e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     ad2:	fe042623          	sw	zero,-20(s0)
     ad6:	a82d                	j	b10 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     ad8:	fd043783          	ld	a5,-48(s0)
     adc:	93f1                	srli	a5,a5,0x3c
     ade:	00000717          	auipc	a4,0x0
     ae2:	7ea70713          	addi	a4,a4,2026 # 12c8 <digits>
     ae6:	97ba                	add	a5,a5,a4
     ae8:	0007c703          	lbu	a4,0(a5)
     aec:	fdc42783          	lw	a5,-36(s0)
     af0:	85ba                	mv	a1,a4
     af2:	853e                	mv	a0,a5
     af4:	00000097          	auipc	ra,0x0
     af8:	e6a080e7          	jalr	-406(ra) # 95e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     afc:	fec42783          	lw	a5,-20(s0)
     b00:	2785                	addiw	a5,a5,1
     b02:	fef42623          	sw	a5,-20(s0)
     b06:	fd043783          	ld	a5,-48(s0)
     b0a:	0792                	slli	a5,a5,0x4
     b0c:	fcf43823          	sd	a5,-48(s0)
     b10:	fec42783          	lw	a5,-20(s0)
     b14:	873e                	mv	a4,a5
     b16:	47bd                	li	a5,15
     b18:	fce7f0e3          	bgeu	a5,a4,ad8 <printptr+0x3c>
}
     b1c:	0001                	nop
     b1e:	0001                	nop
     b20:	70a2                	ld	ra,40(sp)
     b22:	7402                	ld	s0,32(sp)
     b24:	6145                	addi	sp,sp,48
     b26:	8082                	ret

0000000000000b28 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     b28:	715d                	addi	sp,sp,-80
     b2a:	e486                	sd	ra,72(sp)
     b2c:	e0a2                	sd	s0,64(sp)
     b2e:	0880                	addi	s0,sp,80
     b30:	87aa                	mv	a5,a0
     b32:	fcb43023          	sd	a1,-64(s0)
     b36:	fac43c23          	sd	a2,-72(s0)
     b3a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     b3e:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     b42:	fe042223          	sw	zero,-28(s0)
     b46:	a42d                	j	d70 <vprintf+0x248>
    c = fmt[i] & 0xff;
     b48:	fe442783          	lw	a5,-28(s0)
     b4c:	fc043703          	ld	a4,-64(s0)
     b50:	97ba                	add	a5,a5,a4
     b52:	0007c783          	lbu	a5,0(a5)
     b56:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     b5a:	fe042783          	lw	a5,-32(s0)
     b5e:	2781                	sext.w	a5,a5
     b60:	eb9d                	bnez	a5,b96 <vprintf+0x6e>
      if(c == '%'){
     b62:	fdc42783          	lw	a5,-36(s0)
     b66:	0007871b          	sext.w	a4,a5
     b6a:	02500793          	li	a5,37
     b6e:	00f71763          	bne	a4,a5,b7c <vprintf+0x54>
        state = '%';
     b72:	02500793          	li	a5,37
     b76:	fef42023          	sw	a5,-32(s0)
     b7a:	a2f5                	j	d66 <vprintf+0x23e>
      } else {
        putc(fd, c);
     b7c:	fdc42783          	lw	a5,-36(s0)
     b80:	0ff7f713          	zext.b	a4,a5
     b84:	fcc42783          	lw	a5,-52(s0)
     b88:	85ba                	mv	a1,a4
     b8a:	853e                	mv	a0,a5
     b8c:	00000097          	auipc	ra,0x0
     b90:	dd2080e7          	jalr	-558(ra) # 95e <putc>
     b94:	aac9                	j	d66 <vprintf+0x23e>
      }
    } else if(state == '%'){
     b96:	fe042783          	lw	a5,-32(s0)
     b9a:	0007871b          	sext.w	a4,a5
     b9e:	02500793          	li	a5,37
     ba2:	1cf71263          	bne	a4,a5,d66 <vprintf+0x23e>
      if(c == 'd'){
     ba6:	fdc42783          	lw	a5,-36(s0)
     baa:	0007871b          	sext.w	a4,a5
     bae:	06400793          	li	a5,100
     bb2:	02f71463          	bne	a4,a5,bda <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     bb6:	fb843783          	ld	a5,-72(s0)
     bba:	00878713          	addi	a4,a5,8
     bbe:	fae43c23          	sd	a4,-72(s0)
     bc2:	4398                	lw	a4,0(a5)
     bc4:	fcc42783          	lw	a5,-52(s0)
     bc8:	4685                	li	a3,1
     bca:	4629                	li	a2,10
     bcc:	85ba                	mv	a1,a4
     bce:	853e                	mv	a0,a5
     bd0:	00000097          	auipc	ra,0x0
     bd4:	dc4080e7          	jalr	-572(ra) # 994 <printint>
     bd8:	a269                	j	d62 <vprintf+0x23a>
      } else if(c == 'l') {
     bda:	fdc42783          	lw	a5,-36(s0)
     bde:	0007871b          	sext.w	a4,a5
     be2:	06c00793          	li	a5,108
     be6:	02f71663          	bne	a4,a5,c12 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     bea:	fb843783          	ld	a5,-72(s0)
     bee:	00878713          	addi	a4,a5,8
     bf2:	fae43c23          	sd	a4,-72(s0)
     bf6:	639c                	ld	a5,0(a5)
     bf8:	0007871b          	sext.w	a4,a5
     bfc:	fcc42783          	lw	a5,-52(s0)
     c00:	4681                	li	a3,0
     c02:	4629                	li	a2,10
     c04:	85ba                	mv	a1,a4
     c06:	853e                	mv	a0,a5
     c08:	00000097          	auipc	ra,0x0
     c0c:	d8c080e7          	jalr	-628(ra) # 994 <printint>
     c10:	aa89                	j	d62 <vprintf+0x23a>
      } else if(c == 'x') {
     c12:	fdc42783          	lw	a5,-36(s0)
     c16:	0007871b          	sext.w	a4,a5
     c1a:	07800793          	li	a5,120
     c1e:	02f71463          	bne	a4,a5,c46 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     c22:	fb843783          	ld	a5,-72(s0)
     c26:	00878713          	addi	a4,a5,8
     c2a:	fae43c23          	sd	a4,-72(s0)
     c2e:	4398                	lw	a4,0(a5)
     c30:	fcc42783          	lw	a5,-52(s0)
     c34:	4681                	li	a3,0
     c36:	4641                	li	a2,16
     c38:	85ba                	mv	a1,a4
     c3a:	853e                	mv	a0,a5
     c3c:	00000097          	auipc	ra,0x0
     c40:	d58080e7          	jalr	-680(ra) # 994 <printint>
     c44:	aa39                	j	d62 <vprintf+0x23a>
      } else if(c == 'p') {
     c46:	fdc42783          	lw	a5,-36(s0)
     c4a:	0007871b          	sext.w	a4,a5
     c4e:	07000793          	li	a5,112
     c52:	02f71263          	bne	a4,a5,c76 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     c56:	fb843783          	ld	a5,-72(s0)
     c5a:	00878713          	addi	a4,a5,8
     c5e:	fae43c23          	sd	a4,-72(s0)
     c62:	6398                	ld	a4,0(a5)
     c64:	fcc42783          	lw	a5,-52(s0)
     c68:	85ba                	mv	a1,a4
     c6a:	853e                	mv	a0,a5
     c6c:	00000097          	auipc	ra,0x0
     c70:	e30080e7          	jalr	-464(ra) # a9c <printptr>
     c74:	a0fd                	j	d62 <vprintf+0x23a>
      } else if(c == 's'){
     c76:	fdc42783          	lw	a5,-36(s0)
     c7a:	0007871b          	sext.w	a4,a5
     c7e:	07300793          	li	a5,115
     c82:	04f71c63          	bne	a4,a5,cda <vprintf+0x1b2>
        s = va_arg(ap, char*);
     c86:	fb843783          	ld	a5,-72(s0)
     c8a:	00878713          	addi	a4,a5,8
     c8e:	fae43c23          	sd	a4,-72(s0)
     c92:	639c                	ld	a5,0(a5)
     c94:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     c98:	fe843783          	ld	a5,-24(s0)
     c9c:	eb8d                	bnez	a5,cce <vprintf+0x1a6>
          s = "(null)";
     c9e:	00000797          	auipc	a5,0x0
     ca2:	5d278793          	addi	a5,a5,1490 # 1270 <lock_init+0x52>
     ca6:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     caa:	a015                	j	cce <vprintf+0x1a6>
          putc(fd, *s);
     cac:	fe843783          	ld	a5,-24(s0)
     cb0:	0007c703          	lbu	a4,0(a5)
     cb4:	fcc42783          	lw	a5,-52(s0)
     cb8:	85ba                	mv	a1,a4
     cba:	853e                	mv	a0,a5
     cbc:	00000097          	auipc	ra,0x0
     cc0:	ca2080e7          	jalr	-862(ra) # 95e <putc>
          s++;
     cc4:	fe843783          	ld	a5,-24(s0)
     cc8:	0785                	addi	a5,a5,1
     cca:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     cce:	fe843783          	ld	a5,-24(s0)
     cd2:	0007c783          	lbu	a5,0(a5)
     cd6:	fbf9                	bnez	a5,cac <vprintf+0x184>
     cd8:	a069                	j	d62 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     cda:	fdc42783          	lw	a5,-36(s0)
     cde:	0007871b          	sext.w	a4,a5
     ce2:	06300793          	li	a5,99
     ce6:	02f71463          	bne	a4,a5,d0e <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     cea:	fb843783          	ld	a5,-72(s0)
     cee:	00878713          	addi	a4,a5,8
     cf2:	fae43c23          	sd	a4,-72(s0)
     cf6:	439c                	lw	a5,0(a5)
     cf8:	0ff7f713          	zext.b	a4,a5
     cfc:	fcc42783          	lw	a5,-52(s0)
     d00:	85ba                	mv	a1,a4
     d02:	853e                	mv	a0,a5
     d04:	00000097          	auipc	ra,0x0
     d08:	c5a080e7          	jalr	-934(ra) # 95e <putc>
     d0c:	a899                	j	d62 <vprintf+0x23a>
      } else if(c == '%'){
     d0e:	fdc42783          	lw	a5,-36(s0)
     d12:	0007871b          	sext.w	a4,a5
     d16:	02500793          	li	a5,37
     d1a:	00f71f63          	bne	a4,a5,d38 <vprintf+0x210>
        putc(fd, c);
     d1e:	fdc42783          	lw	a5,-36(s0)
     d22:	0ff7f713          	zext.b	a4,a5
     d26:	fcc42783          	lw	a5,-52(s0)
     d2a:	85ba                	mv	a1,a4
     d2c:	853e                	mv	a0,a5
     d2e:	00000097          	auipc	ra,0x0
     d32:	c30080e7          	jalr	-976(ra) # 95e <putc>
     d36:	a035                	j	d62 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     d38:	fcc42783          	lw	a5,-52(s0)
     d3c:	02500593          	li	a1,37
     d40:	853e                	mv	a0,a5
     d42:	00000097          	auipc	ra,0x0
     d46:	c1c080e7          	jalr	-996(ra) # 95e <putc>
        putc(fd, c);
     d4a:	fdc42783          	lw	a5,-36(s0)
     d4e:	0ff7f713          	zext.b	a4,a5
     d52:	fcc42783          	lw	a5,-52(s0)
     d56:	85ba                	mv	a1,a4
     d58:	853e                	mv	a0,a5
     d5a:	00000097          	auipc	ra,0x0
     d5e:	c04080e7          	jalr	-1020(ra) # 95e <putc>
      }
      state = 0;
     d62:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     d66:	fe442783          	lw	a5,-28(s0)
     d6a:	2785                	addiw	a5,a5,1
     d6c:	fef42223          	sw	a5,-28(s0)
     d70:	fe442783          	lw	a5,-28(s0)
     d74:	fc043703          	ld	a4,-64(s0)
     d78:	97ba                	add	a5,a5,a4
     d7a:	0007c783          	lbu	a5,0(a5)
     d7e:	dc0795e3          	bnez	a5,b48 <vprintf+0x20>
    }
  }
}
     d82:	0001                	nop
     d84:	0001                	nop
     d86:	60a6                	ld	ra,72(sp)
     d88:	6406                	ld	s0,64(sp)
     d8a:	6161                	addi	sp,sp,80
     d8c:	8082                	ret

0000000000000d8e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d8e:	7159                	addi	sp,sp,-112
     d90:	fc06                	sd	ra,56(sp)
     d92:	f822                	sd	s0,48(sp)
     d94:	0080                	addi	s0,sp,64
     d96:	fcb43823          	sd	a1,-48(s0)
     d9a:	e010                	sd	a2,0(s0)
     d9c:	e414                	sd	a3,8(s0)
     d9e:	e818                	sd	a4,16(s0)
     da0:	ec1c                	sd	a5,24(s0)
     da2:	03043023          	sd	a6,32(s0)
     da6:	03143423          	sd	a7,40(s0)
     daa:	87aa                	mv	a5,a0
     dac:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     db0:	03040793          	addi	a5,s0,48
     db4:	fcf43423          	sd	a5,-56(s0)
     db8:	fc843783          	ld	a5,-56(s0)
     dbc:	fd078793          	addi	a5,a5,-48
     dc0:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     dc4:	fe843703          	ld	a4,-24(s0)
     dc8:	fdc42783          	lw	a5,-36(s0)
     dcc:	863a                	mv	a2,a4
     dce:	fd043583          	ld	a1,-48(s0)
     dd2:	853e                	mv	a0,a5
     dd4:	00000097          	auipc	ra,0x0
     dd8:	d54080e7          	jalr	-684(ra) # b28 <vprintf>
}
     ddc:	0001                	nop
     dde:	70e2                	ld	ra,56(sp)
     de0:	7442                	ld	s0,48(sp)
     de2:	6165                	addi	sp,sp,112
     de4:	8082                	ret

0000000000000de6 <printf>:

void
printf(const char *fmt, ...)
{
     de6:	7159                	addi	sp,sp,-112
     de8:	f406                	sd	ra,40(sp)
     dea:	f022                	sd	s0,32(sp)
     dec:	1800                	addi	s0,sp,48
     dee:	fca43c23          	sd	a0,-40(s0)
     df2:	e40c                	sd	a1,8(s0)
     df4:	e810                	sd	a2,16(s0)
     df6:	ec14                	sd	a3,24(s0)
     df8:	f018                	sd	a4,32(s0)
     dfa:	f41c                	sd	a5,40(s0)
     dfc:	03043823          	sd	a6,48(s0)
     e00:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     e04:	04040793          	addi	a5,s0,64
     e08:	fcf43823          	sd	a5,-48(s0)
     e0c:	fd043783          	ld	a5,-48(s0)
     e10:	fc878793          	addi	a5,a5,-56
     e14:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     e18:	fe843783          	ld	a5,-24(s0)
     e1c:	863e                	mv	a2,a5
     e1e:	fd843583          	ld	a1,-40(s0)
     e22:	4505                	li	a0,1
     e24:	00000097          	auipc	ra,0x0
     e28:	d04080e7          	jalr	-764(ra) # b28 <vprintf>
}
     e2c:	0001                	nop
     e2e:	70a2                	ld	ra,40(sp)
     e30:	7402                	ld	s0,32(sp)
     e32:	6165                	addi	sp,sp,112
     e34:	8082                	ret

0000000000000e36 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e36:	7179                	addi	sp,sp,-48
     e38:	f422                	sd	s0,40(sp)
     e3a:	1800                	addi	s0,sp,48
     e3c:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e40:	fd843783          	ld	a5,-40(s0)
     e44:	17c1                	addi	a5,a5,-16
     e46:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e4a:	00001797          	auipc	a5,0x1
     e4e:	8a678793          	addi	a5,a5,-1882 # 16f0 <freep>
     e52:	639c                	ld	a5,0(a5)
     e54:	fef43423          	sd	a5,-24(s0)
     e58:	a815                	j	e8c <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e5a:	fe843783          	ld	a5,-24(s0)
     e5e:	639c                	ld	a5,0(a5)
     e60:	fe843703          	ld	a4,-24(s0)
     e64:	00f76f63          	bltu	a4,a5,e82 <free+0x4c>
     e68:	fe043703          	ld	a4,-32(s0)
     e6c:	fe843783          	ld	a5,-24(s0)
     e70:	02e7eb63          	bltu	a5,a4,ea6 <free+0x70>
     e74:	fe843783          	ld	a5,-24(s0)
     e78:	639c                	ld	a5,0(a5)
     e7a:	fe043703          	ld	a4,-32(s0)
     e7e:	02f76463          	bltu	a4,a5,ea6 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e82:	fe843783          	ld	a5,-24(s0)
     e86:	639c                	ld	a5,0(a5)
     e88:	fef43423          	sd	a5,-24(s0)
     e8c:	fe043703          	ld	a4,-32(s0)
     e90:	fe843783          	ld	a5,-24(s0)
     e94:	fce7f3e3          	bgeu	a5,a4,e5a <free+0x24>
     e98:	fe843783          	ld	a5,-24(s0)
     e9c:	639c                	ld	a5,0(a5)
     e9e:	fe043703          	ld	a4,-32(s0)
     ea2:	faf77ce3          	bgeu	a4,a5,e5a <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     ea6:	fe043783          	ld	a5,-32(s0)
     eaa:	479c                	lw	a5,8(a5)
     eac:	1782                	slli	a5,a5,0x20
     eae:	9381                	srli	a5,a5,0x20
     eb0:	0792                	slli	a5,a5,0x4
     eb2:	fe043703          	ld	a4,-32(s0)
     eb6:	973e                	add	a4,a4,a5
     eb8:	fe843783          	ld	a5,-24(s0)
     ebc:	639c                	ld	a5,0(a5)
     ebe:	02f71763          	bne	a4,a5,eec <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     ec2:	fe043783          	ld	a5,-32(s0)
     ec6:	4798                	lw	a4,8(a5)
     ec8:	fe843783          	ld	a5,-24(s0)
     ecc:	639c                	ld	a5,0(a5)
     ece:	479c                	lw	a5,8(a5)
     ed0:	9fb9                	addw	a5,a5,a4
     ed2:	0007871b          	sext.w	a4,a5
     ed6:	fe043783          	ld	a5,-32(s0)
     eda:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     edc:	fe843783          	ld	a5,-24(s0)
     ee0:	639c                	ld	a5,0(a5)
     ee2:	6398                	ld	a4,0(a5)
     ee4:	fe043783          	ld	a5,-32(s0)
     ee8:	e398                	sd	a4,0(a5)
     eea:	a039                	j	ef8 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     eec:	fe843783          	ld	a5,-24(s0)
     ef0:	6398                	ld	a4,0(a5)
     ef2:	fe043783          	ld	a5,-32(s0)
     ef6:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     ef8:	fe843783          	ld	a5,-24(s0)
     efc:	479c                	lw	a5,8(a5)
     efe:	1782                	slli	a5,a5,0x20
     f00:	9381                	srli	a5,a5,0x20
     f02:	0792                	slli	a5,a5,0x4
     f04:	fe843703          	ld	a4,-24(s0)
     f08:	97ba                	add	a5,a5,a4
     f0a:	fe043703          	ld	a4,-32(s0)
     f0e:	02f71563          	bne	a4,a5,f38 <free+0x102>
    p->s.size += bp->s.size;
     f12:	fe843783          	ld	a5,-24(s0)
     f16:	4798                	lw	a4,8(a5)
     f18:	fe043783          	ld	a5,-32(s0)
     f1c:	479c                	lw	a5,8(a5)
     f1e:	9fb9                	addw	a5,a5,a4
     f20:	0007871b          	sext.w	a4,a5
     f24:	fe843783          	ld	a5,-24(s0)
     f28:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     f2a:	fe043783          	ld	a5,-32(s0)
     f2e:	6398                	ld	a4,0(a5)
     f30:	fe843783          	ld	a5,-24(s0)
     f34:	e398                	sd	a4,0(a5)
     f36:	a031                	j	f42 <free+0x10c>
  } else
    p->s.ptr = bp;
     f38:	fe843783          	ld	a5,-24(s0)
     f3c:	fe043703          	ld	a4,-32(s0)
     f40:	e398                	sd	a4,0(a5)
  freep = p;
     f42:	00000797          	auipc	a5,0x0
     f46:	7ae78793          	addi	a5,a5,1966 # 16f0 <freep>
     f4a:	fe843703          	ld	a4,-24(s0)
     f4e:	e398                	sd	a4,0(a5)
}
     f50:	0001                	nop
     f52:	7422                	ld	s0,40(sp)
     f54:	6145                	addi	sp,sp,48
     f56:	8082                	ret

0000000000000f58 <morecore>:

static Header*
morecore(uint nu)
{
     f58:	7179                	addi	sp,sp,-48
     f5a:	f406                	sd	ra,40(sp)
     f5c:	f022                	sd	s0,32(sp)
     f5e:	1800                	addi	s0,sp,48
     f60:	87aa                	mv	a5,a0
     f62:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     f66:	fdc42783          	lw	a5,-36(s0)
     f6a:	0007871b          	sext.w	a4,a5
     f6e:	6785                	lui	a5,0x1
     f70:	00f77563          	bgeu	a4,a5,f7a <morecore+0x22>
    nu = 4096;
     f74:	6785                	lui	a5,0x1
     f76:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     f7a:	fdc42783          	lw	a5,-36(s0)
     f7e:	0047979b          	slliw	a5,a5,0x4
     f82:	2781                	sext.w	a5,a5
     f84:	2781                	sext.w	a5,a5
     f86:	853e                	mv	a0,a5
     f88:	00000097          	auipc	ra,0x0
     f8c:	9ae080e7          	jalr	-1618(ra) # 936 <sbrk>
     f90:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     f94:	fe843703          	ld	a4,-24(s0)
     f98:	57fd                	li	a5,-1
     f9a:	00f71463          	bne	a4,a5,fa2 <morecore+0x4a>
    return 0;
     f9e:	4781                	li	a5,0
     fa0:	a03d                	j	fce <morecore+0x76>
  hp = (Header*)p;
     fa2:	fe843783          	ld	a5,-24(s0)
     fa6:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     faa:	fe043783          	ld	a5,-32(s0)
     fae:	fdc42703          	lw	a4,-36(s0)
     fb2:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     fb4:	fe043783          	ld	a5,-32(s0)
     fb8:	07c1                	addi	a5,a5,16
     fba:	853e                	mv	a0,a5
     fbc:	00000097          	auipc	ra,0x0
     fc0:	e7a080e7          	jalr	-390(ra) # e36 <free>
  return freep;
     fc4:	00000797          	auipc	a5,0x0
     fc8:	72c78793          	addi	a5,a5,1836 # 16f0 <freep>
     fcc:	639c                	ld	a5,0(a5)
}
     fce:	853e                	mv	a0,a5
     fd0:	70a2                	ld	ra,40(sp)
     fd2:	7402                	ld	s0,32(sp)
     fd4:	6145                	addi	sp,sp,48
     fd6:	8082                	ret

0000000000000fd8 <malloc>:

void*
malloc(uint nbytes)
{
     fd8:	7139                	addi	sp,sp,-64
     fda:	fc06                	sd	ra,56(sp)
     fdc:	f822                	sd	s0,48(sp)
     fde:	0080                	addi	s0,sp,64
     fe0:	87aa                	mv	a5,a0
     fe2:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fe6:	fcc46783          	lwu	a5,-52(s0)
     fea:	07bd                	addi	a5,a5,15
     fec:	8391                	srli	a5,a5,0x4
     fee:	2781                	sext.w	a5,a5
     ff0:	2785                	addiw	a5,a5,1
     ff2:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     ff6:	00000797          	auipc	a5,0x0
     ffa:	6fa78793          	addi	a5,a5,1786 # 16f0 <freep>
     ffe:	639c                	ld	a5,0(a5)
    1000:	fef43023          	sd	a5,-32(s0)
    1004:	fe043783          	ld	a5,-32(s0)
    1008:	ef95                	bnez	a5,1044 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    100a:	00000797          	auipc	a5,0x0
    100e:	6d678793          	addi	a5,a5,1750 # 16e0 <base>
    1012:	fef43023          	sd	a5,-32(s0)
    1016:	00000797          	auipc	a5,0x0
    101a:	6da78793          	addi	a5,a5,1754 # 16f0 <freep>
    101e:	fe043703          	ld	a4,-32(s0)
    1022:	e398                	sd	a4,0(a5)
    1024:	00000797          	auipc	a5,0x0
    1028:	6cc78793          	addi	a5,a5,1740 # 16f0 <freep>
    102c:	6398                	ld	a4,0(a5)
    102e:	00000797          	auipc	a5,0x0
    1032:	6b278793          	addi	a5,a5,1714 # 16e0 <base>
    1036:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1038:	00000797          	auipc	a5,0x0
    103c:	6a878793          	addi	a5,a5,1704 # 16e0 <base>
    1040:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1044:	fe043783          	ld	a5,-32(s0)
    1048:	639c                	ld	a5,0(a5)
    104a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    104e:	fe843783          	ld	a5,-24(s0)
    1052:	4798                	lw	a4,8(a5)
    1054:	fdc42783          	lw	a5,-36(s0)
    1058:	2781                	sext.w	a5,a5
    105a:	06f76763          	bltu	a4,a5,10c8 <malloc+0xf0>
      if(p->s.size == nunits)
    105e:	fe843783          	ld	a5,-24(s0)
    1062:	4798                	lw	a4,8(a5)
    1064:	fdc42783          	lw	a5,-36(s0)
    1068:	2781                	sext.w	a5,a5
    106a:	00e79963          	bne	a5,a4,107c <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    106e:	fe843783          	ld	a5,-24(s0)
    1072:	6398                	ld	a4,0(a5)
    1074:	fe043783          	ld	a5,-32(s0)
    1078:	e398                	sd	a4,0(a5)
    107a:	a825                	j	10b2 <malloc+0xda>
      else {
        p->s.size -= nunits;
    107c:	fe843783          	ld	a5,-24(s0)
    1080:	479c                	lw	a5,8(a5)
    1082:	fdc42703          	lw	a4,-36(s0)
    1086:	9f99                	subw	a5,a5,a4
    1088:	0007871b          	sext.w	a4,a5
    108c:	fe843783          	ld	a5,-24(s0)
    1090:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1092:	fe843783          	ld	a5,-24(s0)
    1096:	479c                	lw	a5,8(a5)
    1098:	1782                	slli	a5,a5,0x20
    109a:	9381                	srli	a5,a5,0x20
    109c:	0792                	slli	a5,a5,0x4
    109e:	fe843703          	ld	a4,-24(s0)
    10a2:	97ba                	add	a5,a5,a4
    10a4:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    10a8:	fe843783          	ld	a5,-24(s0)
    10ac:	fdc42703          	lw	a4,-36(s0)
    10b0:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    10b2:	00000797          	auipc	a5,0x0
    10b6:	63e78793          	addi	a5,a5,1598 # 16f0 <freep>
    10ba:	fe043703          	ld	a4,-32(s0)
    10be:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    10c0:	fe843783          	ld	a5,-24(s0)
    10c4:	07c1                	addi	a5,a5,16
    10c6:	a091                	j	110a <malloc+0x132>
    }
    if(p == freep)
    10c8:	00000797          	auipc	a5,0x0
    10cc:	62878793          	addi	a5,a5,1576 # 16f0 <freep>
    10d0:	639c                	ld	a5,0(a5)
    10d2:	fe843703          	ld	a4,-24(s0)
    10d6:	02f71063          	bne	a4,a5,10f6 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    10da:	fdc42783          	lw	a5,-36(s0)
    10de:	853e                	mv	a0,a5
    10e0:	00000097          	auipc	ra,0x0
    10e4:	e78080e7          	jalr	-392(ra) # f58 <morecore>
    10e8:	fea43423          	sd	a0,-24(s0)
    10ec:	fe843783          	ld	a5,-24(s0)
    10f0:	e399                	bnez	a5,10f6 <malloc+0x11e>
        return 0;
    10f2:	4781                	li	a5,0
    10f4:	a819                	j	110a <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10f6:	fe843783          	ld	a5,-24(s0)
    10fa:	fef43023          	sd	a5,-32(s0)
    10fe:	fe843783          	ld	a5,-24(s0)
    1102:	639c                	ld	a5,0(a5)
    1104:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1108:	b799                	j	104e <malloc+0x76>
  }
}
    110a:	853e                	mv	a0,a5
    110c:	70e2                	ld	ra,56(sp)
    110e:	7442                	ld	s0,48(sp)
    1110:	6121                	addi	sp,sp,64
    1112:	8082                	ret

0000000000001114 <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
    1114:	7179                	addi	sp,sp,-48
    1116:	f406                	sd	ra,40(sp)
    1118:	f022                	sd	s0,32(sp)
    111a:	1800                	addi	s0,sp,48
    111c:	fca43c23          	sd	a0,-40(s0)
    1120:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
    1124:	6505                	lui	a0,0x1
    1126:	00000097          	auipc	ra,0x0
    112a:	eb2080e7          	jalr	-334(ra) # fd8 <malloc>
    112e:	fea43423          	sd	a0,-24(s0)
    1132:	fe843783          	ld	a5,-24(s0)
    1136:	e38d                	bnez	a5,1158 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
    1138:	00000517          	auipc	a0,0x0
    113c:	14050513          	addi	a0,a0,320 # 1278 <lock_init+0x5a>
    1140:	00000097          	auipc	ra,0x0
    1144:	ca6080e7          	jalr	-858(ra) # de6 <printf>
        free(stack);
    1148:	fe843503          	ld	a0,-24(s0)
    114c:	00000097          	auipc	ra,0x0
    1150:	cea080e7          	jalr	-790(ra) # e36 <free>
        return -1;
    1154:	57fd                	li	a5,-1
    1156:	a099                	j	119c <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
    1158:	fe843783          	ld	a5,-24(s0)
    115c:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
    1160:	fe043703          	ld	a4,-32(s0)
    1164:	6785                	lui	a5,0x1
    1166:	17fd                	addi	a5,a5,-1
    1168:	8ff9                	and	a5,a5,a4
    116a:	cf91                	beqz	a5,1186 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
    116c:	fe043703          	ld	a4,-32(s0)
    1170:	6785                	lui	a5,0x1
    1172:	17fd                	addi	a5,a5,-1
    1174:	8ff9                	and	a5,a5,a4
    1176:	6705                	lui	a4,0x1
    1178:	40f707b3          	sub	a5,a4,a5
    117c:	fe843703          	ld	a4,-24(s0)
    1180:	97ba                	add	a5,a5,a4
    1182:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
    1186:	fe843603          	ld	a2,-24(s0)
    118a:	fd043583          	ld	a1,-48(s0)
    118e:	fd843503          	ld	a0,-40(s0)
    1192:	fffff097          	auipc	ra,0xfffff
    1196:	7bc080e7          	jalr	1980(ra) # 94e <clone>
    119a:	87aa                	mv	a5,a0
}
    119c:	853e                	mv	a0,a5
    119e:	70a2                	ld	ra,40(sp)
    11a0:	7402                	ld	s0,32(sp)
    11a2:	6145                	addi	sp,sp,48
    11a4:	8082                	ret

00000000000011a6 <thread_join>:


int thread_join()
{
    11a6:	1101                	addi	sp,sp,-32
    11a8:	ec06                	sd	ra,24(sp)
    11aa:	e822                	sd	s0,16(sp)
    11ac:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
    11ae:	fe040793          	addi	a5,s0,-32
    11b2:	853e                	mv	a0,a5
    11b4:	fffff097          	auipc	ra,0xfffff
    11b8:	7a2080e7          	jalr	1954(ra) # 956 <join>
    11bc:	87aa                	mv	a5,a0
    11be:	fef42623          	sw	a5,-20(s0)
    11c2:	fec42783          	lw	a5,-20(s0)
    11c6:	0007871b          	sext.w	a4,a5
    11ca:	57fd                	li	a5,-1
    11cc:	00f70963          	beq	a4,a5,11de <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
    11d0:	fe043783          	ld	a5,-32(s0)
    11d4:	853e                	mv	a0,a5
    11d6:	00000097          	auipc	ra,0x0
    11da:	c60080e7          	jalr	-928(ra) # e36 <free>
    } 

    return child_tid;
    11de:	fec42783          	lw	a5,-20(s0)
}
    11e2:	853e                	mv	a0,a5
    11e4:	60e2                	ld	ra,24(sp)
    11e6:	6442                	ld	s0,16(sp)
    11e8:	6105                	addi	sp,sp,32
    11ea:	8082                	ret

00000000000011ec <lock_acquire>:


void lock_acquire (lock_t *lock)
{
    11ec:	1101                	addi	sp,sp,-32
    11ee:	ec22                	sd	s0,24(sp)
    11f0:	1000                	addi	s0,sp,32
    11f2:	fea43423          	sd	a0,-24(s0)
        lock = 0;
    11f6:	fe043423          	sd	zero,-24(s0)

}
    11fa:	0001                	nop
    11fc:	6462                	ld	s0,24(sp)
    11fe:	6105                	addi	sp,sp,32
    1200:	8082                	ret

0000000000001202 <lock_release>:

void lock_release (lock_t *lock)
{
    1202:	1101                	addi	sp,sp,-32
    1204:	ec22                	sd	s0,24(sp)
    1206:	1000                	addi	s0,sp,32
    1208:	fea43423          	sd	a0,-24(s0)
        __sync_lock_test_and_set(lock, 1);
    120c:	fe843783          	ld	a5,-24(s0)
    1210:	4705                	li	a4,1
    1212:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    
}
    1216:	0001                	nop
    1218:	6462                	ld	s0,24(sp)
    121a:	6105                	addi	sp,sp,32
    121c:	8082                	ret

000000000000121e <lock_init>:

void lock_init (lock_t *lock)
{
    121e:	1101                	addi	sp,sp,-32
    1220:	ec22                	sd	s0,24(sp)
    1222:	1000                	addi	s0,sp,32
    1224:	fea43423          	sd	a0,-24(s0)
    lock = 0;
    1228:	fe043423          	sd	zero,-24(s0)
    
}
    122c:	0001                	nop
    122e:	6462                	ld	s0,24(sp)
    1230:	6105                	addi	sp,sp,32
    1232:	8082                	ret
