
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	f426                	sd	s1,40(sp)
       8:	0080                	addi	s0,sp,64
       a:	fca43423          	sd	a0,-56(s0)
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
       e:	fc843503          	ld	a0,-56(s0)
      12:	00000097          	auipc	ra,0x0
      16:	42e080e7          	jalr	1070(ra) # 440 <strlen>
      1a:	87aa                	mv	a5,a0
      1c:	2781                	sext.w	a5,a5
      1e:	1782                	slli	a5,a5,0x20
      20:	9381                	srli	a5,a5,0x20
      22:	fc843703          	ld	a4,-56(s0)
      26:	97ba                	add	a5,a5,a4
      28:	fcf43c23          	sd	a5,-40(s0)
      2c:	a031                	j	38 <fmtname+0x38>
      2e:	fd843783          	ld	a5,-40(s0)
      32:	17fd                	addi	a5,a5,-1
      34:	fcf43c23          	sd	a5,-40(s0)
      38:	fd843703          	ld	a4,-40(s0)
      3c:	fc843783          	ld	a5,-56(s0)
      40:	00f76b63          	bltu	a4,a5,56 <fmtname+0x56>
      44:	fd843783          	ld	a5,-40(s0)
      48:	0007c783          	lbu	a5,0(a5)
      4c:	873e                	mv	a4,a5
      4e:	02f00793          	li	a5,47
      52:	fcf71ee3          	bne	a4,a5,2e <fmtname+0x2e>
    ;
  p++;
      56:	fd843783          	ld	a5,-40(s0)
      5a:	0785                	addi	a5,a5,1
      5c:	fcf43c23          	sd	a5,-40(s0)

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
      60:	fd843503          	ld	a0,-40(s0)
      64:	00000097          	auipc	ra,0x0
      68:	3dc080e7          	jalr	988(ra) # 440 <strlen>
      6c:	87aa                	mv	a5,a0
      6e:	2781                	sext.w	a5,a5
      70:	873e                	mv	a4,a5
      72:	47b5                	li	a5,13
      74:	00e7f563          	bgeu	a5,a4,7e <fmtname+0x7e>
    return p;
      78:	fd843783          	ld	a5,-40(s0)
      7c:	a8b5                	j	f8 <fmtname+0xf8>
  memmove(buf, p, strlen(p));
      7e:	fd843503          	ld	a0,-40(s0)
      82:	00000097          	auipc	ra,0x0
      86:	3be080e7          	jalr	958(ra) # 440 <strlen>
      8a:	87aa                	mv	a5,a0
      8c:	2781                	sext.w	a5,a5
      8e:	2781                	sext.w	a5,a5
      90:	863e                	mv	a2,a5
      92:	fd843583          	ld	a1,-40(s0)
      96:	00001517          	auipc	a0,0x1
      9a:	08a50513          	addi	a0,a0,138 # 1120 <buf.0>
      9e:	00000097          	auipc	ra,0x0
      a2:	5fc080e7          	jalr	1532(ra) # 69a <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
      a6:	fd843503          	ld	a0,-40(s0)
      aa:	00000097          	auipc	ra,0x0
      ae:	396080e7          	jalr	918(ra) # 440 <strlen>
      b2:	87aa                	mv	a5,a0
      b4:	2781                	sext.w	a5,a5
      b6:	02079713          	slli	a4,a5,0x20
      ba:	9301                	srli	a4,a4,0x20
      bc:	00001797          	auipc	a5,0x1
      c0:	06478793          	addi	a5,a5,100 # 1120 <buf.0>
      c4:	00f704b3          	add	s1,a4,a5
      c8:	fd843503          	ld	a0,-40(s0)
      cc:	00000097          	auipc	ra,0x0
      d0:	374080e7          	jalr	884(ra) # 440 <strlen>
      d4:	87aa                	mv	a5,a0
      d6:	2781                	sext.w	a5,a5
      d8:	4739                	li	a4,14
      da:	40f707bb          	subw	a5,a4,a5
      de:	2781                	sext.w	a5,a5
      e0:	863e                	mv	a2,a5
      e2:	02000593          	li	a1,32
      e6:	8526                	mv	a0,s1
      e8:	00000097          	auipc	ra,0x0
      ec:	38e080e7          	jalr	910(ra) # 476 <memset>
  return buf;
      f0:	00001797          	auipc	a5,0x1
      f4:	03078793          	addi	a5,a5,48 # 1120 <buf.0>
}
      f8:	853e                	mv	a0,a5
      fa:	70e2                	ld	ra,56(sp)
      fc:	7442                	ld	s0,48(sp)
      fe:	74a2                	ld	s1,40(sp)
     100:	6121                	addi	sp,sp,64
     102:	8082                	ret

0000000000000104 <ls>:

void
ls(char *path)
{
     104:	da010113          	addi	sp,sp,-608
     108:	24113c23          	sd	ra,600(sp)
     10c:	24813823          	sd	s0,592(sp)
     110:	1480                	addi	s0,sp,608
     112:	daa43423          	sd	a0,-600(s0)
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
     116:	4581                	li	a1,0
     118:	da843503          	ld	a0,-600(s0)
     11c:	00000097          	auipc	ra,0x0
     120:	744080e7          	jalr	1860(ra) # 860 <open>
     124:	87aa                	mv	a5,a0
     126:	fef42623          	sw	a5,-20(s0)
     12a:	fec42783          	lw	a5,-20(s0)
     12e:	2781                	sext.w	a5,a5
     130:	0007de63          	bgez	a5,14c <ls+0x48>
    fprintf(2, "ls: cannot open %s\n", path);
     134:	da843603          	ld	a2,-600(s0)
     138:	00001597          	auipc	a1,0x1
     13c:	f5858593          	addi	a1,a1,-168 # 1090 <malloc+0x140>
     140:	4509                	li	a0,2
     142:	00001097          	auipc	ra,0x1
     146:	bc4080e7          	jalr	-1084(ra) # d06 <fprintf>
    return;
     14a:	aa6d                	j	304 <ls+0x200>
  }

  if(fstat(fd, &st) < 0){
     14c:	db840713          	addi	a4,s0,-584
     150:	fec42783          	lw	a5,-20(s0)
     154:	85ba                	mv	a1,a4
     156:	853e                	mv	a0,a5
     158:	00000097          	auipc	ra,0x0
     15c:	720080e7          	jalr	1824(ra) # 878 <fstat>
     160:	87aa                	mv	a5,a0
     162:	0207d563          	bgez	a5,18c <ls+0x88>
    fprintf(2, "ls: cannot stat %s\n", path);
     166:	da843603          	ld	a2,-600(s0)
     16a:	00001597          	auipc	a1,0x1
     16e:	f3e58593          	addi	a1,a1,-194 # 10a8 <malloc+0x158>
     172:	4509                	li	a0,2
     174:	00001097          	auipc	ra,0x1
     178:	b92080e7          	jalr	-1134(ra) # d06 <fprintf>
    close(fd);
     17c:	fec42783          	lw	a5,-20(s0)
     180:	853e                	mv	a0,a5
     182:	00000097          	auipc	ra,0x0
     186:	6c6080e7          	jalr	1734(ra) # 848 <close>
    return;
     18a:	aaad                	j	304 <ls+0x200>
  }

  switch(st.type){
     18c:	dc041783          	lh	a5,-576(s0)
     190:	0007871b          	sext.w	a4,a5
     194:	86ba                	mv	a3,a4
     196:	4785                	li	a5,1
     198:	02f68d63          	beq	a3,a5,1d2 <ls+0xce>
     19c:	4789                	li	a5,2
     19e:	14f71c63          	bne	a4,a5,2f6 <ls+0x1f2>
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
     1a2:	da843503          	ld	a0,-600(s0)
     1a6:	00000097          	auipc	ra,0x0
     1aa:	e5a080e7          	jalr	-422(ra) # 0 <fmtname>
     1ae:	85aa                	mv	a1,a0
     1b0:	dc041783          	lh	a5,-576(s0)
     1b4:	2781                	sext.w	a5,a5
     1b6:	dbc42683          	lw	a3,-580(s0)
     1ba:	dc843703          	ld	a4,-568(s0)
     1be:	863e                	mv	a2,a5
     1c0:	00001517          	auipc	a0,0x1
     1c4:	f0050513          	addi	a0,a0,-256 # 10c0 <malloc+0x170>
     1c8:	00001097          	auipc	ra,0x1
     1cc:	b96080e7          	jalr	-1130(ra) # d5e <printf>
    break;
     1d0:	a21d                	j	2f6 <ls+0x1f2>

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     1d2:	da843503          	ld	a0,-600(s0)
     1d6:	00000097          	auipc	ra,0x0
     1da:	26a080e7          	jalr	618(ra) # 440 <strlen>
     1de:	87aa                	mv	a5,a0
     1e0:	2781                	sext.w	a5,a5
     1e2:	27c1                	addiw	a5,a5,16
     1e4:	2781                	sext.w	a5,a5
     1e6:	873e                	mv	a4,a5
     1e8:	20000793          	li	a5,512
     1ec:	00e7fb63          	bgeu	a5,a4,202 <ls+0xfe>
      printf("ls: path too long\n");
     1f0:	00001517          	auipc	a0,0x1
     1f4:	ee050513          	addi	a0,a0,-288 # 10d0 <malloc+0x180>
     1f8:	00001097          	auipc	ra,0x1
     1fc:	b66080e7          	jalr	-1178(ra) # d5e <printf>
      break;
     200:	a8dd                	j	2f6 <ls+0x1f2>
    }
    strcpy(buf, path);
     202:	de040793          	addi	a5,s0,-544
     206:	da843583          	ld	a1,-600(s0)
     20a:	853e                	mv	a0,a5
     20c:	00000097          	auipc	ra,0x0
     210:	184080e7          	jalr	388(ra) # 390 <strcpy>
    p = buf+strlen(buf);
     214:	de040793          	addi	a5,s0,-544
     218:	853e                	mv	a0,a5
     21a:	00000097          	auipc	ra,0x0
     21e:	226080e7          	jalr	550(ra) # 440 <strlen>
     222:	87aa                	mv	a5,a0
     224:	2781                	sext.w	a5,a5
     226:	1782                	slli	a5,a5,0x20
     228:	9381                	srli	a5,a5,0x20
     22a:	de040713          	addi	a4,s0,-544
     22e:	97ba                	add	a5,a5,a4
     230:	fef43023          	sd	a5,-32(s0)
    *p++ = '/';
     234:	fe043783          	ld	a5,-32(s0)
     238:	00178713          	addi	a4,a5,1
     23c:	fee43023          	sd	a4,-32(s0)
     240:	02f00713          	li	a4,47
     244:	00e78023          	sb	a4,0(a5)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     248:	a071                	j	2d4 <ls+0x1d0>
      if(de.inum == 0)
     24a:	dd045783          	lhu	a5,-560(s0)
     24e:	e391                	bnez	a5,252 <ls+0x14e>
        continue;
     250:	a051                	j	2d4 <ls+0x1d0>
      memmove(p, de.name, DIRSIZ);
     252:	dd040793          	addi	a5,s0,-560
     256:	0789                	addi	a5,a5,2
     258:	4639                	li	a2,14
     25a:	85be                	mv	a1,a5
     25c:	fe043503          	ld	a0,-32(s0)
     260:	00000097          	auipc	ra,0x0
     264:	43a080e7          	jalr	1082(ra) # 69a <memmove>
      p[DIRSIZ] = 0;
     268:	fe043783          	ld	a5,-32(s0)
     26c:	07b9                	addi	a5,a5,14
     26e:	00078023          	sb	zero,0(a5)
      if(stat(buf, &st) < 0){
     272:	db840713          	addi	a4,s0,-584
     276:	de040793          	addi	a5,s0,-544
     27a:	85ba                	mv	a1,a4
     27c:	853e                	mv	a0,a5
     27e:	00000097          	auipc	ra,0x0
     282:	344080e7          	jalr	836(ra) # 5c2 <stat>
     286:	87aa                	mv	a5,a0
     288:	0007de63          	bgez	a5,2a4 <ls+0x1a0>
        printf("ls: cannot stat %s\n", buf);
     28c:	de040793          	addi	a5,s0,-544
     290:	85be                	mv	a1,a5
     292:	00001517          	auipc	a0,0x1
     296:	e1650513          	addi	a0,a0,-490 # 10a8 <malloc+0x158>
     29a:	00001097          	auipc	ra,0x1
     29e:	ac4080e7          	jalr	-1340(ra) # d5e <printf>
        continue;
     2a2:	a80d                	j	2d4 <ls+0x1d0>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
     2a4:	de040793          	addi	a5,s0,-544
     2a8:	853e                	mv	a0,a5
     2aa:	00000097          	auipc	ra,0x0
     2ae:	d56080e7          	jalr	-682(ra) # 0 <fmtname>
     2b2:	85aa                	mv	a1,a0
     2b4:	dc041783          	lh	a5,-576(s0)
     2b8:	2781                	sext.w	a5,a5
     2ba:	dbc42683          	lw	a3,-580(s0)
     2be:	dc843703          	ld	a4,-568(s0)
     2c2:	863e                	mv	a2,a5
     2c4:	00001517          	auipc	a0,0x1
     2c8:	e2450513          	addi	a0,a0,-476 # 10e8 <malloc+0x198>
     2cc:	00001097          	auipc	ra,0x1
     2d0:	a92080e7          	jalr	-1390(ra) # d5e <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     2d4:	dd040713          	addi	a4,s0,-560
     2d8:	fec42783          	lw	a5,-20(s0)
     2dc:	4641                	li	a2,16
     2de:	85ba                	mv	a1,a4
     2e0:	853e                	mv	a0,a5
     2e2:	00000097          	auipc	ra,0x0
     2e6:	556080e7          	jalr	1366(ra) # 838 <read>
     2ea:	87aa                	mv	a5,a0
     2ec:	873e                	mv	a4,a5
     2ee:	47c1                	li	a5,16
     2f0:	f4f70de3          	beq	a4,a5,24a <ls+0x146>
    }
    break;
     2f4:	0001                	nop
  }
  close(fd);
     2f6:	fec42783          	lw	a5,-20(s0)
     2fa:	853e                	mv	a0,a5
     2fc:	00000097          	auipc	ra,0x0
     300:	54c080e7          	jalr	1356(ra) # 848 <close>
}
     304:	25813083          	ld	ra,600(sp)
     308:	25013403          	ld	s0,592(sp)
     30c:	26010113          	addi	sp,sp,608
     310:	8082                	ret

0000000000000312 <main>:

int
main(int argc, char *argv[])
{
     312:	7179                	addi	sp,sp,-48
     314:	f406                	sd	ra,40(sp)
     316:	f022                	sd	s0,32(sp)
     318:	1800                	addi	s0,sp,48
     31a:	87aa                	mv	a5,a0
     31c:	fcb43823          	sd	a1,-48(s0)
     320:	fcf42e23          	sw	a5,-36(s0)
  int i;

  if(argc < 2){
     324:	fdc42783          	lw	a5,-36(s0)
     328:	0007871b          	sext.w	a4,a5
     32c:	4785                	li	a5,1
     32e:	00e7cf63          	blt	a5,a4,34c <main+0x3a>
    ls(".");
     332:	00001517          	auipc	a0,0x1
     336:	dc650513          	addi	a0,a0,-570 # 10f8 <malloc+0x1a8>
     33a:	00000097          	auipc	ra,0x0
     33e:	dca080e7          	jalr	-566(ra) # 104 <ls>
    exit(0);
     342:	4501                	li	a0,0
     344:	00000097          	auipc	ra,0x0
     348:	4dc080e7          	jalr	1244(ra) # 820 <exit>
  }
  for(i=1; i<argc; i++)
     34c:	4785                	li	a5,1
     34e:	fef42623          	sw	a5,-20(s0)
     352:	a015                	j	376 <main+0x64>
    ls(argv[i]);
     354:	fec42783          	lw	a5,-20(s0)
     358:	078e                	slli	a5,a5,0x3
     35a:	fd043703          	ld	a4,-48(s0)
     35e:	97ba                	add	a5,a5,a4
     360:	639c                	ld	a5,0(a5)
     362:	853e                	mv	a0,a5
     364:	00000097          	auipc	ra,0x0
     368:	da0080e7          	jalr	-608(ra) # 104 <ls>
  for(i=1; i<argc; i++)
     36c:	fec42783          	lw	a5,-20(s0)
     370:	2785                	addiw	a5,a5,1
     372:	fef42623          	sw	a5,-20(s0)
     376:	fec42703          	lw	a4,-20(s0)
     37a:	fdc42783          	lw	a5,-36(s0)
     37e:	2701                	sext.w	a4,a4
     380:	2781                	sext.w	a5,a5
     382:	fcf749e3          	blt	a4,a5,354 <main+0x42>
  exit(0);
     386:	4501                	li	a0,0
     388:	00000097          	auipc	ra,0x0
     38c:	498080e7          	jalr	1176(ra) # 820 <exit>

0000000000000390 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     390:	7179                	addi	sp,sp,-48
     392:	f422                	sd	s0,40(sp)
     394:	1800                	addi	s0,sp,48
     396:	fca43c23          	sd	a0,-40(s0)
     39a:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     39e:	fd843783          	ld	a5,-40(s0)
     3a2:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     3a6:	0001                	nop
     3a8:	fd043703          	ld	a4,-48(s0)
     3ac:	00170793          	addi	a5,a4,1
     3b0:	fcf43823          	sd	a5,-48(s0)
     3b4:	fd843783          	ld	a5,-40(s0)
     3b8:	00178693          	addi	a3,a5,1
     3bc:	fcd43c23          	sd	a3,-40(s0)
     3c0:	00074703          	lbu	a4,0(a4)
     3c4:	00e78023          	sb	a4,0(a5)
     3c8:	0007c783          	lbu	a5,0(a5)
     3cc:	fff1                	bnez	a5,3a8 <strcpy+0x18>
    ;
  return os;
     3ce:	fe843783          	ld	a5,-24(s0)
}
     3d2:	853e                	mv	a0,a5
     3d4:	7422                	ld	s0,40(sp)
     3d6:	6145                	addi	sp,sp,48
     3d8:	8082                	ret

00000000000003da <strcmp>:

int
strcmp(const char *p, const char *q)
{
     3da:	1101                	addi	sp,sp,-32
     3dc:	ec22                	sd	s0,24(sp)
     3de:	1000                	addi	s0,sp,32
     3e0:	fea43423          	sd	a0,-24(s0)
     3e4:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     3e8:	a819                	j	3fe <strcmp+0x24>
    p++, q++;
     3ea:	fe843783          	ld	a5,-24(s0)
     3ee:	0785                	addi	a5,a5,1
     3f0:	fef43423          	sd	a5,-24(s0)
     3f4:	fe043783          	ld	a5,-32(s0)
     3f8:	0785                	addi	a5,a5,1
     3fa:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     3fe:	fe843783          	ld	a5,-24(s0)
     402:	0007c783          	lbu	a5,0(a5)
     406:	cb99                	beqz	a5,41c <strcmp+0x42>
     408:	fe843783          	ld	a5,-24(s0)
     40c:	0007c703          	lbu	a4,0(a5)
     410:	fe043783          	ld	a5,-32(s0)
     414:	0007c783          	lbu	a5,0(a5)
     418:	fcf709e3          	beq	a4,a5,3ea <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     41c:	fe843783          	ld	a5,-24(s0)
     420:	0007c783          	lbu	a5,0(a5)
     424:	0007871b          	sext.w	a4,a5
     428:	fe043783          	ld	a5,-32(s0)
     42c:	0007c783          	lbu	a5,0(a5)
     430:	2781                	sext.w	a5,a5
     432:	40f707bb          	subw	a5,a4,a5
     436:	2781                	sext.w	a5,a5
}
     438:	853e                	mv	a0,a5
     43a:	6462                	ld	s0,24(sp)
     43c:	6105                	addi	sp,sp,32
     43e:	8082                	ret

0000000000000440 <strlen>:

uint
strlen(const char *s)
{
     440:	7179                	addi	sp,sp,-48
     442:	f422                	sd	s0,40(sp)
     444:	1800                	addi	s0,sp,48
     446:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     44a:	fe042623          	sw	zero,-20(s0)
     44e:	a031                	j	45a <strlen+0x1a>
     450:	fec42783          	lw	a5,-20(s0)
     454:	2785                	addiw	a5,a5,1
     456:	fef42623          	sw	a5,-20(s0)
     45a:	fec42783          	lw	a5,-20(s0)
     45e:	fd843703          	ld	a4,-40(s0)
     462:	97ba                	add	a5,a5,a4
     464:	0007c783          	lbu	a5,0(a5)
     468:	f7e5                	bnez	a5,450 <strlen+0x10>
    ;
  return n;
     46a:	fec42783          	lw	a5,-20(s0)
}
     46e:	853e                	mv	a0,a5
     470:	7422                	ld	s0,40(sp)
     472:	6145                	addi	sp,sp,48
     474:	8082                	ret

0000000000000476 <memset>:

void*
memset(void *dst, int c, uint n)
{
     476:	7179                	addi	sp,sp,-48
     478:	f422                	sd	s0,40(sp)
     47a:	1800                	addi	s0,sp,48
     47c:	fca43c23          	sd	a0,-40(s0)
     480:	87ae                	mv	a5,a1
     482:	8732                	mv	a4,a2
     484:	fcf42a23          	sw	a5,-44(s0)
     488:	87ba                	mv	a5,a4
     48a:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     48e:	fd843783          	ld	a5,-40(s0)
     492:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     496:	fe042623          	sw	zero,-20(s0)
     49a:	a00d                	j	4bc <memset+0x46>
    cdst[i] = c;
     49c:	fec42783          	lw	a5,-20(s0)
     4a0:	fe043703          	ld	a4,-32(s0)
     4a4:	97ba                	add	a5,a5,a4
     4a6:	fd442703          	lw	a4,-44(s0)
     4aa:	0ff77713          	andi	a4,a4,255
     4ae:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     4b2:	fec42783          	lw	a5,-20(s0)
     4b6:	2785                	addiw	a5,a5,1
     4b8:	fef42623          	sw	a5,-20(s0)
     4bc:	fec42703          	lw	a4,-20(s0)
     4c0:	fd042783          	lw	a5,-48(s0)
     4c4:	2781                	sext.w	a5,a5
     4c6:	fcf76be3          	bltu	a4,a5,49c <memset+0x26>
  }
  return dst;
     4ca:	fd843783          	ld	a5,-40(s0)
}
     4ce:	853e                	mv	a0,a5
     4d0:	7422                	ld	s0,40(sp)
     4d2:	6145                	addi	sp,sp,48
     4d4:	8082                	ret

00000000000004d6 <strchr>:

char*
strchr(const char *s, char c)
{
     4d6:	1101                	addi	sp,sp,-32
     4d8:	ec22                	sd	s0,24(sp)
     4da:	1000                	addi	s0,sp,32
     4dc:	fea43423          	sd	a0,-24(s0)
     4e0:	87ae                	mv	a5,a1
     4e2:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     4e6:	a01d                	j	50c <strchr+0x36>
    if(*s == c)
     4e8:	fe843783          	ld	a5,-24(s0)
     4ec:	0007c703          	lbu	a4,0(a5)
     4f0:	fe744783          	lbu	a5,-25(s0)
     4f4:	0ff7f793          	andi	a5,a5,255
     4f8:	00e79563          	bne	a5,a4,502 <strchr+0x2c>
      return (char*)s;
     4fc:	fe843783          	ld	a5,-24(s0)
     500:	a821                	j	518 <strchr+0x42>
  for(; *s; s++)
     502:	fe843783          	ld	a5,-24(s0)
     506:	0785                	addi	a5,a5,1
     508:	fef43423          	sd	a5,-24(s0)
     50c:	fe843783          	ld	a5,-24(s0)
     510:	0007c783          	lbu	a5,0(a5)
     514:	fbf1                	bnez	a5,4e8 <strchr+0x12>
  return 0;
     516:	4781                	li	a5,0
}
     518:	853e                	mv	a0,a5
     51a:	6462                	ld	s0,24(sp)
     51c:	6105                	addi	sp,sp,32
     51e:	8082                	ret

0000000000000520 <gets>:

char*
gets(char *buf, int max)
{
     520:	7179                	addi	sp,sp,-48
     522:	f406                	sd	ra,40(sp)
     524:	f022                	sd	s0,32(sp)
     526:	1800                	addi	s0,sp,48
     528:	fca43c23          	sd	a0,-40(s0)
     52c:	87ae                	mv	a5,a1
     52e:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     532:	fe042623          	sw	zero,-20(s0)
     536:	a8a1                	j	58e <gets+0x6e>
    cc = read(0, &c, 1);
     538:	fe740793          	addi	a5,s0,-25
     53c:	4605                	li	a2,1
     53e:	85be                	mv	a1,a5
     540:	4501                	li	a0,0
     542:	00000097          	auipc	ra,0x0
     546:	2f6080e7          	jalr	758(ra) # 838 <read>
     54a:	87aa                	mv	a5,a0
     54c:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     550:	fe842783          	lw	a5,-24(s0)
     554:	2781                	sext.w	a5,a5
     556:	04f05763          	blez	a5,5a4 <gets+0x84>
      break;
    buf[i++] = c;
     55a:	fec42783          	lw	a5,-20(s0)
     55e:	0017871b          	addiw	a4,a5,1
     562:	fee42623          	sw	a4,-20(s0)
     566:	873e                	mv	a4,a5
     568:	fd843783          	ld	a5,-40(s0)
     56c:	97ba                	add	a5,a5,a4
     56e:	fe744703          	lbu	a4,-25(s0)
     572:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     576:	fe744783          	lbu	a5,-25(s0)
     57a:	873e                	mv	a4,a5
     57c:	47a9                	li	a5,10
     57e:	02f70463          	beq	a4,a5,5a6 <gets+0x86>
     582:	fe744783          	lbu	a5,-25(s0)
     586:	873e                	mv	a4,a5
     588:	47b5                	li	a5,13
     58a:	00f70e63          	beq	a4,a5,5a6 <gets+0x86>
  for(i=0; i+1 < max; ){
     58e:	fec42783          	lw	a5,-20(s0)
     592:	2785                	addiw	a5,a5,1
     594:	0007871b          	sext.w	a4,a5
     598:	fd442783          	lw	a5,-44(s0)
     59c:	2781                	sext.w	a5,a5
     59e:	f8f74de3          	blt	a4,a5,538 <gets+0x18>
     5a2:	a011                	j	5a6 <gets+0x86>
      break;
     5a4:	0001                	nop
      break;
  }
  buf[i] = '\0';
     5a6:	fec42783          	lw	a5,-20(s0)
     5aa:	fd843703          	ld	a4,-40(s0)
     5ae:	97ba                	add	a5,a5,a4
     5b0:	00078023          	sb	zero,0(a5)
  return buf;
     5b4:	fd843783          	ld	a5,-40(s0)
}
     5b8:	853e                	mv	a0,a5
     5ba:	70a2                	ld	ra,40(sp)
     5bc:	7402                	ld	s0,32(sp)
     5be:	6145                	addi	sp,sp,48
     5c0:	8082                	ret

00000000000005c2 <stat>:

int
stat(const char *n, struct stat *st)
{
     5c2:	7179                	addi	sp,sp,-48
     5c4:	f406                	sd	ra,40(sp)
     5c6:	f022                	sd	s0,32(sp)
     5c8:	1800                	addi	s0,sp,48
     5ca:	fca43c23          	sd	a0,-40(s0)
     5ce:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     5d2:	4581                	li	a1,0
     5d4:	fd843503          	ld	a0,-40(s0)
     5d8:	00000097          	auipc	ra,0x0
     5dc:	288080e7          	jalr	648(ra) # 860 <open>
     5e0:	87aa                	mv	a5,a0
     5e2:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     5e6:	fec42783          	lw	a5,-20(s0)
     5ea:	2781                	sext.w	a5,a5
     5ec:	0007d463          	bgez	a5,5f4 <stat+0x32>
    return -1;
     5f0:	57fd                	li	a5,-1
     5f2:	a035                	j	61e <stat+0x5c>
  r = fstat(fd, st);
     5f4:	fec42783          	lw	a5,-20(s0)
     5f8:	fd043583          	ld	a1,-48(s0)
     5fc:	853e                	mv	a0,a5
     5fe:	00000097          	auipc	ra,0x0
     602:	27a080e7          	jalr	634(ra) # 878 <fstat>
     606:	87aa                	mv	a5,a0
     608:	fef42423          	sw	a5,-24(s0)
  close(fd);
     60c:	fec42783          	lw	a5,-20(s0)
     610:	853e                	mv	a0,a5
     612:	00000097          	auipc	ra,0x0
     616:	236080e7          	jalr	566(ra) # 848 <close>
  return r;
     61a:	fe842783          	lw	a5,-24(s0)
}
     61e:	853e                	mv	a0,a5
     620:	70a2                	ld	ra,40(sp)
     622:	7402                	ld	s0,32(sp)
     624:	6145                	addi	sp,sp,48
     626:	8082                	ret

0000000000000628 <atoi>:

int
atoi(const char *s)
{
     628:	7179                	addi	sp,sp,-48
     62a:	f422                	sd	s0,40(sp)
     62c:	1800                	addi	s0,sp,48
     62e:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     632:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     636:	a815                	j	66a <atoi+0x42>
    n = n*10 + *s++ - '0';
     638:	fec42703          	lw	a4,-20(s0)
     63c:	87ba                	mv	a5,a4
     63e:	0027979b          	slliw	a5,a5,0x2
     642:	9fb9                	addw	a5,a5,a4
     644:	0017979b          	slliw	a5,a5,0x1
     648:	0007871b          	sext.w	a4,a5
     64c:	fd843783          	ld	a5,-40(s0)
     650:	00178693          	addi	a3,a5,1
     654:	fcd43c23          	sd	a3,-40(s0)
     658:	0007c783          	lbu	a5,0(a5)
     65c:	2781                	sext.w	a5,a5
     65e:	9fb9                	addw	a5,a5,a4
     660:	2781                	sext.w	a5,a5
     662:	fd07879b          	addiw	a5,a5,-48
     666:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     66a:	fd843783          	ld	a5,-40(s0)
     66e:	0007c783          	lbu	a5,0(a5)
     672:	873e                	mv	a4,a5
     674:	02f00793          	li	a5,47
     678:	00e7fb63          	bgeu	a5,a4,68e <atoi+0x66>
     67c:	fd843783          	ld	a5,-40(s0)
     680:	0007c783          	lbu	a5,0(a5)
     684:	873e                	mv	a4,a5
     686:	03900793          	li	a5,57
     68a:	fae7f7e3          	bgeu	a5,a4,638 <atoi+0x10>
  return n;
     68e:	fec42783          	lw	a5,-20(s0)
}
     692:	853e                	mv	a0,a5
     694:	7422                	ld	s0,40(sp)
     696:	6145                	addi	sp,sp,48
     698:	8082                	ret

000000000000069a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     69a:	7139                	addi	sp,sp,-64
     69c:	fc22                	sd	s0,56(sp)
     69e:	0080                	addi	s0,sp,64
     6a0:	fca43c23          	sd	a0,-40(s0)
     6a4:	fcb43823          	sd	a1,-48(s0)
     6a8:	87b2                	mv	a5,a2
     6aa:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     6ae:	fd843783          	ld	a5,-40(s0)
     6b2:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     6b6:	fd043783          	ld	a5,-48(s0)
     6ba:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     6be:	fe043703          	ld	a4,-32(s0)
     6c2:	fe843783          	ld	a5,-24(s0)
     6c6:	02e7fc63          	bgeu	a5,a4,6fe <memmove+0x64>
    while(n-- > 0)
     6ca:	a00d                	j	6ec <memmove+0x52>
      *dst++ = *src++;
     6cc:	fe043703          	ld	a4,-32(s0)
     6d0:	00170793          	addi	a5,a4,1
     6d4:	fef43023          	sd	a5,-32(s0)
     6d8:	fe843783          	ld	a5,-24(s0)
     6dc:	00178693          	addi	a3,a5,1
     6e0:	fed43423          	sd	a3,-24(s0)
     6e4:	00074703          	lbu	a4,0(a4)
     6e8:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     6ec:	fcc42783          	lw	a5,-52(s0)
     6f0:	fff7871b          	addiw	a4,a5,-1
     6f4:	fce42623          	sw	a4,-52(s0)
     6f8:	fcf04ae3          	bgtz	a5,6cc <memmove+0x32>
     6fc:	a891                	j	750 <memmove+0xb6>
  } else {
    dst += n;
     6fe:	fcc42783          	lw	a5,-52(s0)
     702:	fe843703          	ld	a4,-24(s0)
     706:	97ba                	add	a5,a5,a4
     708:	fef43423          	sd	a5,-24(s0)
    src += n;
     70c:	fcc42783          	lw	a5,-52(s0)
     710:	fe043703          	ld	a4,-32(s0)
     714:	97ba                	add	a5,a5,a4
     716:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     71a:	a01d                	j	740 <memmove+0xa6>
      *--dst = *--src;
     71c:	fe043783          	ld	a5,-32(s0)
     720:	17fd                	addi	a5,a5,-1
     722:	fef43023          	sd	a5,-32(s0)
     726:	fe843783          	ld	a5,-24(s0)
     72a:	17fd                	addi	a5,a5,-1
     72c:	fef43423          	sd	a5,-24(s0)
     730:	fe043783          	ld	a5,-32(s0)
     734:	0007c703          	lbu	a4,0(a5)
     738:	fe843783          	ld	a5,-24(s0)
     73c:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     740:	fcc42783          	lw	a5,-52(s0)
     744:	fff7871b          	addiw	a4,a5,-1
     748:	fce42623          	sw	a4,-52(s0)
     74c:	fcf048e3          	bgtz	a5,71c <memmove+0x82>
  }
  return vdst;
     750:	fd843783          	ld	a5,-40(s0)
}
     754:	853e                	mv	a0,a5
     756:	7462                	ld	s0,56(sp)
     758:	6121                	addi	sp,sp,64
     75a:	8082                	ret

000000000000075c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     75c:	7139                	addi	sp,sp,-64
     75e:	fc22                	sd	s0,56(sp)
     760:	0080                	addi	s0,sp,64
     762:	fca43c23          	sd	a0,-40(s0)
     766:	fcb43823          	sd	a1,-48(s0)
     76a:	87b2                	mv	a5,a2
     76c:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     770:	fd843783          	ld	a5,-40(s0)
     774:	fef43423          	sd	a5,-24(s0)
     778:	fd043783          	ld	a5,-48(s0)
     77c:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     780:	a0a1                	j	7c8 <memcmp+0x6c>
    if (*p1 != *p2) {
     782:	fe843783          	ld	a5,-24(s0)
     786:	0007c703          	lbu	a4,0(a5)
     78a:	fe043783          	ld	a5,-32(s0)
     78e:	0007c783          	lbu	a5,0(a5)
     792:	02f70163          	beq	a4,a5,7b4 <memcmp+0x58>
      return *p1 - *p2;
     796:	fe843783          	ld	a5,-24(s0)
     79a:	0007c783          	lbu	a5,0(a5)
     79e:	0007871b          	sext.w	a4,a5
     7a2:	fe043783          	ld	a5,-32(s0)
     7a6:	0007c783          	lbu	a5,0(a5)
     7aa:	2781                	sext.w	a5,a5
     7ac:	40f707bb          	subw	a5,a4,a5
     7b0:	2781                	sext.w	a5,a5
     7b2:	a01d                	j	7d8 <memcmp+0x7c>
    }
    p1++;
     7b4:	fe843783          	ld	a5,-24(s0)
     7b8:	0785                	addi	a5,a5,1
     7ba:	fef43423          	sd	a5,-24(s0)
    p2++;
     7be:	fe043783          	ld	a5,-32(s0)
     7c2:	0785                	addi	a5,a5,1
     7c4:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     7c8:	fcc42783          	lw	a5,-52(s0)
     7cc:	fff7871b          	addiw	a4,a5,-1
     7d0:	fce42623          	sw	a4,-52(s0)
     7d4:	f7dd                	bnez	a5,782 <memcmp+0x26>
  }
  return 0;
     7d6:	4781                	li	a5,0
}
     7d8:	853e                	mv	a0,a5
     7da:	7462                	ld	s0,56(sp)
     7dc:	6121                	addi	sp,sp,64
     7de:	8082                	ret

00000000000007e0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     7e0:	7179                	addi	sp,sp,-48
     7e2:	f406                	sd	ra,40(sp)
     7e4:	f022                	sd	s0,32(sp)
     7e6:	1800                	addi	s0,sp,48
     7e8:	fea43423          	sd	a0,-24(s0)
     7ec:	feb43023          	sd	a1,-32(s0)
     7f0:	87b2                	mv	a5,a2
     7f2:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     7f6:	fdc42783          	lw	a5,-36(s0)
     7fa:	863e                	mv	a2,a5
     7fc:	fe043583          	ld	a1,-32(s0)
     800:	fe843503          	ld	a0,-24(s0)
     804:	00000097          	auipc	ra,0x0
     808:	e96080e7          	jalr	-362(ra) # 69a <memmove>
     80c:	87aa                	mv	a5,a0
}
     80e:	853e                	mv	a0,a5
     810:	70a2                	ld	ra,40(sp)
     812:	7402                	ld	s0,32(sp)
     814:	6145                	addi	sp,sp,48
     816:	8082                	ret

0000000000000818 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     818:	4885                	li	a7,1
 ecall
     81a:	00000073          	ecall
 ret
     81e:	8082                	ret

0000000000000820 <exit>:
.global exit
exit:
 li a7, SYS_exit
     820:	4889                	li	a7,2
 ecall
     822:	00000073          	ecall
 ret
     826:	8082                	ret

0000000000000828 <wait>:
.global wait
wait:
 li a7, SYS_wait
     828:	488d                	li	a7,3
 ecall
     82a:	00000073          	ecall
 ret
     82e:	8082                	ret

0000000000000830 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     830:	4891                	li	a7,4
 ecall
     832:	00000073          	ecall
 ret
     836:	8082                	ret

0000000000000838 <read>:
.global read
read:
 li a7, SYS_read
     838:	4895                	li	a7,5
 ecall
     83a:	00000073          	ecall
 ret
     83e:	8082                	ret

0000000000000840 <write>:
.global write
write:
 li a7, SYS_write
     840:	48c1                	li	a7,16
 ecall
     842:	00000073          	ecall
 ret
     846:	8082                	ret

0000000000000848 <close>:
.global close
close:
 li a7, SYS_close
     848:	48d5                	li	a7,21
 ecall
     84a:	00000073          	ecall
 ret
     84e:	8082                	ret

0000000000000850 <kill>:
.global kill
kill:
 li a7, SYS_kill
     850:	4899                	li	a7,6
 ecall
     852:	00000073          	ecall
 ret
     856:	8082                	ret

0000000000000858 <exec>:
.global exec
exec:
 li a7, SYS_exec
     858:	489d                	li	a7,7
 ecall
     85a:	00000073          	ecall
 ret
     85e:	8082                	ret

0000000000000860 <open>:
.global open
open:
 li a7, SYS_open
     860:	48bd                	li	a7,15
 ecall
     862:	00000073          	ecall
 ret
     866:	8082                	ret

0000000000000868 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     868:	48c5                	li	a7,17
 ecall
     86a:	00000073          	ecall
 ret
     86e:	8082                	ret

0000000000000870 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     870:	48c9                	li	a7,18
 ecall
     872:	00000073          	ecall
 ret
     876:	8082                	ret

0000000000000878 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     878:	48a1                	li	a7,8
 ecall
     87a:	00000073          	ecall
 ret
     87e:	8082                	ret

0000000000000880 <link>:
.global link
link:
 li a7, SYS_link
     880:	48cd                	li	a7,19
 ecall
     882:	00000073          	ecall
 ret
     886:	8082                	ret

0000000000000888 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     888:	48d1                	li	a7,20
 ecall
     88a:	00000073          	ecall
 ret
     88e:	8082                	ret

0000000000000890 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     890:	48a5                	li	a7,9
 ecall
     892:	00000073          	ecall
 ret
     896:	8082                	ret

0000000000000898 <dup>:
.global dup
dup:
 li a7, SYS_dup
     898:	48a9                	li	a7,10
 ecall
     89a:	00000073          	ecall
 ret
     89e:	8082                	ret

00000000000008a0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     8a0:	48ad                	li	a7,11
 ecall
     8a2:	00000073          	ecall
 ret
     8a6:	8082                	ret

00000000000008a8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     8a8:	48b1                	li	a7,12
 ecall
     8aa:	00000073          	ecall
 ret
     8ae:	8082                	ret

00000000000008b0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     8b0:	48b5                	li	a7,13
 ecall
     8b2:	00000073          	ecall
 ret
     8b6:	8082                	ret

00000000000008b8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     8b8:	48b9                	li	a7,14
 ecall
     8ba:	00000073          	ecall
 ret
     8be:	8082                	ret

00000000000008c0 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
     8c0:	48d9                	li	a7,22
 ecall
     8c2:	00000073          	ecall
 ret
     8c6:	8082                	ret

00000000000008c8 <setpri>:
.global setpri
setpri:
 li a7, SYS_setpri
     8c8:	48dd                	li	a7,23
 ecall
     8ca:	00000073          	ecall
 ret
     8ce:	8082                	ret

00000000000008d0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     8d0:	1101                	addi	sp,sp,-32
     8d2:	ec06                	sd	ra,24(sp)
     8d4:	e822                	sd	s0,16(sp)
     8d6:	1000                	addi	s0,sp,32
     8d8:	87aa                	mv	a5,a0
     8da:	872e                	mv	a4,a1
     8dc:	fef42623          	sw	a5,-20(s0)
     8e0:	87ba                	mv	a5,a4
     8e2:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     8e6:	feb40713          	addi	a4,s0,-21
     8ea:	fec42783          	lw	a5,-20(s0)
     8ee:	4605                	li	a2,1
     8f0:	85ba                	mv	a1,a4
     8f2:	853e                	mv	a0,a5
     8f4:	00000097          	auipc	ra,0x0
     8f8:	f4c080e7          	jalr	-180(ra) # 840 <write>
}
     8fc:	0001                	nop
     8fe:	60e2                	ld	ra,24(sp)
     900:	6442                	ld	s0,16(sp)
     902:	6105                	addi	sp,sp,32
     904:	8082                	ret

0000000000000906 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     906:	7139                	addi	sp,sp,-64
     908:	fc06                	sd	ra,56(sp)
     90a:	f822                	sd	s0,48(sp)
     90c:	0080                	addi	s0,sp,64
     90e:	87aa                	mv	a5,a0
     910:	8736                	mv	a4,a3
     912:	fcf42623          	sw	a5,-52(s0)
     916:	87ae                	mv	a5,a1
     918:	fcf42423          	sw	a5,-56(s0)
     91c:	87b2                	mv	a5,a2
     91e:	fcf42223          	sw	a5,-60(s0)
     922:	87ba                	mv	a5,a4
     924:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     928:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     92c:	fc042783          	lw	a5,-64(s0)
     930:	2781                	sext.w	a5,a5
     932:	c38d                	beqz	a5,954 <printint+0x4e>
     934:	fc842783          	lw	a5,-56(s0)
     938:	2781                	sext.w	a5,a5
     93a:	0007dd63          	bgez	a5,954 <printint+0x4e>
    neg = 1;
     93e:	4785                	li	a5,1
     940:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     944:	fc842783          	lw	a5,-56(s0)
     948:	40f007bb          	negw	a5,a5
     94c:	2781                	sext.w	a5,a5
     94e:	fef42223          	sw	a5,-28(s0)
     952:	a029                	j	95c <printint+0x56>
  } else {
    x = xx;
     954:	fc842783          	lw	a5,-56(s0)
     958:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     95c:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     960:	fc442783          	lw	a5,-60(s0)
     964:	fe442703          	lw	a4,-28(s0)
     968:	02f777bb          	remuw	a5,a4,a5
     96c:	0007861b          	sext.w	a2,a5
     970:	fec42783          	lw	a5,-20(s0)
     974:	0017871b          	addiw	a4,a5,1
     978:	fee42623          	sw	a4,-20(s0)
     97c:	00000697          	auipc	a3,0x0
     980:	78c68693          	addi	a3,a3,1932 # 1108 <digits>
     984:	02061713          	slli	a4,a2,0x20
     988:	9301                	srli	a4,a4,0x20
     98a:	9736                	add	a4,a4,a3
     98c:	00074703          	lbu	a4,0(a4)
     990:	ff040693          	addi	a3,s0,-16
     994:	97b6                	add	a5,a5,a3
     996:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     99a:	fc442783          	lw	a5,-60(s0)
     99e:	fe442703          	lw	a4,-28(s0)
     9a2:	02f757bb          	divuw	a5,a4,a5
     9a6:	fef42223          	sw	a5,-28(s0)
     9aa:	fe442783          	lw	a5,-28(s0)
     9ae:	2781                	sext.w	a5,a5
     9b0:	fbc5                	bnez	a5,960 <printint+0x5a>
  if(neg)
     9b2:	fe842783          	lw	a5,-24(s0)
     9b6:	2781                	sext.w	a5,a5
     9b8:	cf95                	beqz	a5,9f4 <printint+0xee>
    buf[i++] = '-';
     9ba:	fec42783          	lw	a5,-20(s0)
     9be:	0017871b          	addiw	a4,a5,1
     9c2:	fee42623          	sw	a4,-20(s0)
     9c6:	ff040713          	addi	a4,s0,-16
     9ca:	97ba                	add	a5,a5,a4
     9cc:	02d00713          	li	a4,45
     9d0:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     9d4:	a005                	j	9f4 <printint+0xee>
    putc(fd, buf[i]);
     9d6:	fec42783          	lw	a5,-20(s0)
     9da:	ff040713          	addi	a4,s0,-16
     9de:	97ba                	add	a5,a5,a4
     9e0:	fe07c703          	lbu	a4,-32(a5)
     9e4:	fcc42783          	lw	a5,-52(s0)
     9e8:	85ba                	mv	a1,a4
     9ea:	853e                	mv	a0,a5
     9ec:	00000097          	auipc	ra,0x0
     9f0:	ee4080e7          	jalr	-284(ra) # 8d0 <putc>
  while(--i >= 0)
     9f4:	fec42783          	lw	a5,-20(s0)
     9f8:	37fd                	addiw	a5,a5,-1
     9fa:	fef42623          	sw	a5,-20(s0)
     9fe:	fec42783          	lw	a5,-20(s0)
     a02:	2781                	sext.w	a5,a5
     a04:	fc07d9e3          	bgez	a5,9d6 <printint+0xd0>
}
     a08:	0001                	nop
     a0a:	0001                	nop
     a0c:	70e2                	ld	ra,56(sp)
     a0e:	7442                	ld	s0,48(sp)
     a10:	6121                	addi	sp,sp,64
     a12:	8082                	ret

0000000000000a14 <printptr>:

static void
printptr(int fd, uint64 x) {
     a14:	7179                	addi	sp,sp,-48
     a16:	f406                	sd	ra,40(sp)
     a18:	f022                	sd	s0,32(sp)
     a1a:	1800                	addi	s0,sp,48
     a1c:	87aa                	mv	a5,a0
     a1e:	fcb43823          	sd	a1,-48(s0)
     a22:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     a26:	fdc42783          	lw	a5,-36(s0)
     a2a:	03000593          	li	a1,48
     a2e:	853e                	mv	a0,a5
     a30:	00000097          	auipc	ra,0x0
     a34:	ea0080e7          	jalr	-352(ra) # 8d0 <putc>
  putc(fd, 'x');
     a38:	fdc42783          	lw	a5,-36(s0)
     a3c:	07800593          	li	a1,120
     a40:	853e                	mv	a0,a5
     a42:	00000097          	auipc	ra,0x0
     a46:	e8e080e7          	jalr	-370(ra) # 8d0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a4a:	fe042623          	sw	zero,-20(s0)
     a4e:	a82d                	j	a88 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     a50:	fd043783          	ld	a5,-48(s0)
     a54:	93f1                	srli	a5,a5,0x3c
     a56:	00000717          	auipc	a4,0x0
     a5a:	6b270713          	addi	a4,a4,1714 # 1108 <digits>
     a5e:	97ba                	add	a5,a5,a4
     a60:	0007c703          	lbu	a4,0(a5)
     a64:	fdc42783          	lw	a5,-36(s0)
     a68:	85ba                	mv	a1,a4
     a6a:	853e                	mv	a0,a5
     a6c:	00000097          	auipc	ra,0x0
     a70:	e64080e7          	jalr	-412(ra) # 8d0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a74:	fec42783          	lw	a5,-20(s0)
     a78:	2785                	addiw	a5,a5,1
     a7a:	fef42623          	sw	a5,-20(s0)
     a7e:	fd043783          	ld	a5,-48(s0)
     a82:	0792                	slli	a5,a5,0x4
     a84:	fcf43823          	sd	a5,-48(s0)
     a88:	fec42783          	lw	a5,-20(s0)
     a8c:	873e                	mv	a4,a5
     a8e:	47bd                	li	a5,15
     a90:	fce7f0e3          	bgeu	a5,a4,a50 <printptr+0x3c>
}
     a94:	0001                	nop
     a96:	0001                	nop
     a98:	70a2                	ld	ra,40(sp)
     a9a:	7402                	ld	s0,32(sp)
     a9c:	6145                	addi	sp,sp,48
     a9e:	8082                	ret

0000000000000aa0 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     aa0:	715d                	addi	sp,sp,-80
     aa2:	e486                	sd	ra,72(sp)
     aa4:	e0a2                	sd	s0,64(sp)
     aa6:	0880                	addi	s0,sp,80
     aa8:	87aa                	mv	a5,a0
     aaa:	fcb43023          	sd	a1,-64(s0)
     aae:	fac43c23          	sd	a2,-72(s0)
     ab2:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     ab6:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     aba:	fe042223          	sw	zero,-28(s0)
     abe:	a42d                	j	ce8 <vprintf+0x248>
    c = fmt[i] & 0xff;
     ac0:	fe442783          	lw	a5,-28(s0)
     ac4:	fc043703          	ld	a4,-64(s0)
     ac8:	97ba                	add	a5,a5,a4
     aca:	0007c783          	lbu	a5,0(a5)
     ace:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     ad2:	fe042783          	lw	a5,-32(s0)
     ad6:	2781                	sext.w	a5,a5
     ad8:	eb9d                	bnez	a5,b0e <vprintf+0x6e>
      if(c == '%'){
     ada:	fdc42783          	lw	a5,-36(s0)
     ade:	0007871b          	sext.w	a4,a5
     ae2:	02500793          	li	a5,37
     ae6:	00f71763          	bne	a4,a5,af4 <vprintf+0x54>
        state = '%';
     aea:	02500793          	li	a5,37
     aee:	fef42023          	sw	a5,-32(s0)
     af2:	a2f5                	j	cde <vprintf+0x23e>
      } else {
        putc(fd, c);
     af4:	fdc42783          	lw	a5,-36(s0)
     af8:	0ff7f713          	andi	a4,a5,255
     afc:	fcc42783          	lw	a5,-52(s0)
     b00:	85ba                	mv	a1,a4
     b02:	853e                	mv	a0,a5
     b04:	00000097          	auipc	ra,0x0
     b08:	dcc080e7          	jalr	-564(ra) # 8d0 <putc>
     b0c:	aac9                	j	cde <vprintf+0x23e>
      }
    } else if(state == '%'){
     b0e:	fe042783          	lw	a5,-32(s0)
     b12:	0007871b          	sext.w	a4,a5
     b16:	02500793          	li	a5,37
     b1a:	1cf71263          	bne	a4,a5,cde <vprintf+0x23e>
      if(c == 'd'){
     b1e:	fdc42783          	lw	a5,-36(s0)
     b22:	0007871b          	sext.w	a4,a5
     b26:	06400793          	li	a5,100
     b2a:	02f71463          	bne	a4,a5,b52 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     b2e:	fb843783          	ld	a5,-72(s0)
     b32:	00878713          	addi	a4,a5,8
     b36:	fae43c23          	sd	a4,-72(s0)
     b3a:	4398                	lw	a4,0(a5)
     b3c:	fcc42783          	lw	a5,-52(s0)
     b40:	4685                	li	a3,1
     b42:	4629                	li	a2,10
     b44:	85ba                	mv	a1,a4
     b46:	853e                	mv	a0,a5
     b48:	00000097          	auipc	ra,0x0
     b4c:	dbe080e7          	jalr	-578(ra) # 906 <printint>
     b50:	a269                	j	cda <vprintf+0x23a>
      } else if(c == 'l') {
     b52:	fdc42783          	lw	a5,-36(s0)
     b56:	0007871b          	sext.w	a4,a5
     b5a:	06c00793          	li	a5,108
     b5e:	02f71663          	bne	a4,a5,b8a <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     b62:	fb843783          	ld	a5,-72(s0)
     b66:	00878713          	addi	a4,a5,8
     b6a:	fae43c23          	sd	a4,-72(s0)
     b6e:	639c                	ld	a5,0(a5)
     b70:	0007871b          	sext.w	a4,a5
     b74:	fcc42783          	lw	a5,-52(s0)
     b78:	4681                	li	a3,0
     b7a:	4629                	li	a2,10
     b7c:	85ba                	mv	a1,a4
     b7e:	853e                	mv	a0,a5
     b80:	00000097          	auipc	ra,0x0
     b84:	d86080e7          	jalr	-634(ra) # 906 <printint>
     b88:	aa89                	j	cda <vprintf+0x23a>
      } else if(c == 'x') {
     b8a:	fdc42783          	lw	a5,-36(s0)
     b8e:	0007871b          	sext.w	a4,a5
     b92:	07800793          	li	a5,120
     b96:	02f71463          	bne	a4,a5,bbe <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     b9a:	fb843783          	ld	a5,-72(s0)
     b9e:	00878713          	addi	a4,a5,8
     ba2:	fae43c23          	sd	a4,-72(s0)
     ba6:	4398                	lw	a4,0(a5)
     ba8:	fcc42783          	lw	a5,-52(s0)
     bac:	4681                	li	a3,0
     bae:	4641                	li	a2,16
     bb0:	85ba                	mv	a1,a4
     bb2:	853e                	mv	a0,a5
     bb4:	00000097          	auipc	ra,0x0
     bb8:	d52080e7          	jalr	-686(ra) # 906 <printint>
     bbc:	aa39                	j	cda <vprintf+0x23a>
      } else if(c == 'p') {
     bbe:	fdc42783          	lw	a5,-36(s0)
     bc2:	0007871b          	sext.w	a4,a5
     bc6:	07000793          	li	a5,112
     bca:	02f71263          	bne	a4,a5,bee <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     bce:	fb843783          	ld	a5,-72(s0)
     bd2:	00878713          	addi	a4,a5,8
     bd6:	fae43c23          	sd	a4,-72(s0)
     bda:	6398                	ld	a4,0(a5)
     bdc:	fcc42783          	lw	a5,-52(s0)
     be0:	85ba                	mv	a1,a4
     be2:	853e                	mv	a0,a5
     be4:	00000097          	auipc	ra,0x0
     be8:	e30080e7          	jalr	-464(ra) # a14 <printptr>
     bec:	a0fd                	j	cda <vprintf+0x23a>
      } else if(c == 's'){
     bee:	fdc42783          	lw	a5,-36(s0)
     bf2:	0007871b          	sext.w	a4,a5
     bf6:	07300793          	li	a5,115
     bfa:	04f71c63          	bne	a4,a5,c52 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     bfe:	fb843783          	ld	a5,-72(s0)
     c02:	00878713          	addi	a4,a5,8
     c06:	fae43c23          	sd	a4,-72(s0)
     c0a:	639c                	ld	a5,0(a5)
     c0c:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     c10:	fe843783          	ld	a5,-24(s0)
     c14:	eb8d                	bnez	a5,c46 <vprintf+0x1a6>
          s = "(null)";
     c16:	00000797          	auipc	a5,0x0
     c1a:	4ea78793          	addi	a5,a5,1258 # 1100 <malloc+0x1b0>
     c1e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     c22:	a015                	j	c46 <vprintf+0x1a6>
          putc(fd, *s);
     c24:	fe843783          	ld	a5,-24(s0)
     c28:	0007c703          	lbu	a4,0(a5)
     c2c:	fcc42783          	lw	a5,-52(s0)
     c30:	85ba                	mv	a1,a4
     c32:	853e                	mv	a0,a5
     c34:	00000097          	auipc	ra,0x0
     c38:	c9c080e7          	jalr	-868(ra) # 8d0 <putc>
          s++;
     c3c:	fe843783          	ld	a5,-24(s0)
     c40:	0785                	addi	a5,a5,1
     c42:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     c46:	fe843783          	ld	a5,-24(s0)
     c4a:	0007c783          	lbu	a5,0(a5)
     c4e:	fbf9                	bnez	a5,c24 <vprintf+0x184>
     c50:	a069                	j	cda <vprintf+0x23a>
        }
      } else if(c == 'c'){
     c52:	fdc42783          	lw	a5,-36(s0)
     c56:	0007871b          	sext.w	a4,a5
     c5a:	06300793          	li	a5,99
     c5e:	02f71463          	bne	a4,a5,c86 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     c62:	fb843783          	ld	a5,-72(s0)
     c66:	00878713          	addi	a4,a5,8
     c6a:	fae43c23          	sd	a4,-72(s0)
     c6e:	439c                	lw	a5,0(a5)
     c70:	0ff7f713          	andi	a4,a5,255
     c74:	fcc42783          	lw	a5,-52(s0)
     c78:	85ba                	mv	a1,a4
     c7a:	853e                	mv	a0,a5
     c7c:	00000097          	auipc	ra,0x0
     c80:	c54080e7          	jalr	-940(ra) # 8d0 <putc>
     c84:	a899                	j	cda <vprintf+0x23a>
      } else if(c == '%'){
     c86:	fdc42783          	lw	a5,-36(s0)
     c8a:	0007871b          	sext.w	a4,a5
     c8e:	02500793          	li	a5,37
     c92:	00f71f63          	bne	a4,a5,cb0 <vprintf+0x210>
        putc(fd, c);
     c96:	fdc42783          	lw	a5,-36(s0)
     c9a:	0ff7f713          	andi	a4,a5,255
     c9e:	fcc42783          	lw	a5,-52(s0)
     ca2:	85ba                	mv	a1,a4
     ca4:	853e                	mv	a0,a5
     ca6:	00000097          	auipc	ra,0x0
     caa:	c2a080e7          	jalr	-982(ra) # 8d0 <putc>
     cae:	a035                	j	cda <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     cb0:	fcc42783          	lw	a5,-52(s0)
     cb4:	02500593          	li	a1,37
     cb8:	853e                	mv	a0,a5
     cba:	00000097          	auipc	ra,0x0
     cbe:	c16080e7          	jalr	-1002(ra) # 8d0 <putc>
        putc(fd, c);
     cc2:	fdc42783          	lw	a5,-36(s0)
     cc6:	0ff7f713          	andi	a4,a5,255
     cca:	fcc42783          	lw	a5,-52(s0)
     cce:	85ba                	mv	a1,a4
     cd0:	853e                	mv	a0,a5
     cd2:	00000097          	auipc	ra,0x0
     cd6:	bfe080e7          	jalr	-1026(ra) # 8d0 <putc>
      }
      state = 0;
     cda:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     cde:	fe442783          	lw	a5,-28(s0)
     ce2:	2785                	addiw	a5,a5,1
     ce4:	fef42223          	sw	a5,-28(s0)
     ce8:	fe442783          	lw	a5,-28(s0)
     cec:	fc043703          	ld	a4,-64(s0)
     cf0:	97ba                	add	a5,a5,a4
     cf2:	0007c783          	lbu	a5,0(a5)
     cf6:	dc0795e3          	bnez	a5,ac0 <vprintf+0x20>
    }
  }
}
     cfa:	0001                	nop
     cfc:	0001                	nop
     cfe:	60a6                	ld	ra,72(sp)
     d00:	6406                	ld	s0,64(sp)
     d02:	6161                	addi	sp,sp,80
     d04:	8082                	ret

0000000000000d06 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d06:	7159                	addi	sp,sp,-112
     d08:	fc06                	sd	ra,56(sp)
     d0a:	f822                	sd	s0,48(sp)
     d0c:	0080                	addi	s0,sp,64
     d0e:	fcb43823          	sd	a1,-48(s0)
     d12:	e010                	sd	a2,0(s0)
     d14:	e414                	sd	a3,8(s0)
     d16:	e818                	sd	a4,16(s0)
     d18:	ec1c                	sd	a5,24(s0)
     d1a:	03043023          	sd	a6,32(s0)
     d1e:	03143423          	sd	a7,40(s0)
     d22:	87aa                	mv	a5,a0
     d24:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d28:	03040793          	addi	a5,s0,48
     d2c:	fcf43423          	sd	a5,-56(s0)
     d30:	fc843783          	ld	a5,-56(s0)
     d34:	fd078793          	addi	a5,a5,-48
     d38:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     d3c:	fe843703          	ld	a4,-24(s0)
     d40:	fdc42783          	lw	a5,-36(s0)
     d44:	863a                	mv	a2,a4
     d46:	fd043583          	ld	a1,-48(s0)
     d4a:	853e                	mv	a0,a5
     d4c:	00000097          	auipc	ra,0x0
     d50:	d54080e7          	jalr	-684(ra) # aa0 <vprintf>
}
     d54:	0001                	nop
     d56:	70e2                	ld	ra,56(sp)
     d58:	7442                	ld	s0,48(sp)
     d5a:	6165                	addi	sp,sp,112
     d5c:	8082                	ret

0000000000000d5e <printf>:

void
printf(const char *fmt, ...)
{
     d5e:	7159                	addi	sp,sp,-112
     d60:	f406                	sd	ra,40(sp)
     d62:	f022                	sd	s0,32(sp)
     d64:	1800                	addi	s0,sp,48
     d66:	fca43c23          	sd	a0,-40(s0)
     d6a:	e40c                	sd	a1,8(s0)
     d6c:	e810                	sd	a2,16(s0)
     d6e:	ec14                	sd	a3,24(s0)
     d70:	f018                	sd	a4,32(s0)
     d72:	f41c                	sd	a5,40(s0)
     d74:	03043823          	sd	a6,48(s0)
     d78:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     d7c:	04040793          	addi	a5,s0,64
     d80:	fcf43823          	sd	a5,-48(s0)
     d84:	fd043783          	ld	a5,-48(s0)
     d88:	fc878793          	addi	a5,a5,-56
     d8c:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     d90:	fe843783          	ld	a5,-24(s0)
     d94:	863e                	mv	a2,a5
     d96:	fd843583          	ld	a1,-40(s0)
     d9a:	4505                	li	a0,1
     d9c:	00000097          	auipc	ra,0x0
     da0:	d04080e7          	jalr	-764(ra) # aa0 <vprintf>
}
     da4:	0001                	nop
     da6:	70a2                	ld	ra,40(sp)
     da8:	7402                	ld	s0,32(sp)
     daa:	6165                	addi	sp,sp,112
     dac:	8082                	ret

0000000000000dae <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     dae:	7179                	addi	sp,sp,-48
     db0:	f422                	sd	s0,40(sp)
     db2:	1800                	addi	s0,sp,48
     db4:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     db8:	fd843783          	ld	a5,-40(s0)
     dbc:	17c1                	addi	a5,a5,-16
     dbe:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     dc2:	00000797          	auipc	a5,0x0
     dc6:	37e78793          	addi	a5,a5,894 # 1140 <freep>
     dca:	639c                	ld	a5,0(a5)
     dcc:	fef43423          	sd	a5,-24(s0)
     dd0:	a815                	j	e04 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     dd2:	fe843783          	ld	a5,-24(s0)
     dd6:	639c                	ld	a5,0(a5)
     dd8:	fe843703          	ld	a4,-24(s0)
     ddc:	00f76f63          	bltu	a4,a5,dfa <free+0x4c>
     de0:	fe043703          	ld	a4,-32(s0)
     de4:	fe843783          	ld	a5,-24(s0)
     de8:	02e7eb63          	bltu	a5,a4,e1e <free+0x70>
     dec:	fe843783          	ld	a5,-24(s0)
     df0:	639c                	ld	a5,0(a5)
     df2:	fe043703          	ld	a4,-32(s0)
     df6:	02f76463          	bltu	a4,a5,e1e <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     dfa:	fe843783          	ld	a5,-24(s0)
     dfe:	639c                	ld	a5,0(a5)
     e00:	fef43423          	sd	a5,-24(s0)
     e04:	fe043703          	ld	a4,-32(s0)
     e08:	fe843783          	ld	a5,-24(s0)
     e0c:	fce7f3e3          	bgeu	a5,a4,dd2 <free+0x24>
     e10:	fe843783          	ld	a5,-24(s0)
     e14:	639c                	ld	a5,0(a5)
     e16:	fe043703          	ld	a4,-32(s0)
     e1a:	faf77ce3          	bgeu	a4,a5,dd2 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     e1e:	fe043783          	ld	a5,-32(s0)
     e22:	479c                	lw	a5,8(a5)
     e24:	1782                	slli	a5,a5,0x20
     e26:	9381                	srli	a5,a5,0x20
     e28:	0792                	slli	a5,a5,0x4
     e2a:	fe043703          	ld	a4,-32(s0)
     e2e:	973e                	add	a4,a4,a5
     e30:	fe843783          	ld	a5,-24(s0)
     e34:	639c                	ld	a5,0(a5)
     e36:	02f71763          	bne	a4,a5,e64 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     e3a:	fe043783          	ld	a5,-32(s0)
     e3e:	4798                	lw	a4,8(a5)
     e40:	fe843783          	ld	a5,-24(s0)
     e44:	639c                	ld	a5,0(a5)
     e46:	479c                	lw	a5,8(a5)
     e48:	9fb9                	addw	a5,a5,a4
     e4a:	0007871b          	sext.w	a4,a5
     e4e:	fe043783          	ld	a5,-32(s0)
     e52:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     e54:	fe843783          	ld	a5,-24(s0)
     e58:	639c                	ld	a5,0(a5)
     e5a:	6398                	ld	a4,0(a5)
     e5c:	fe043783          	ld	a5,-32(s0)
     e60:	e398                	sd	a4,0(a5)
     e62:	a039                	j	e70 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     e64:	fe843783          	ld	a5,-24(s0)
     e68:	6398                	ld	a4,0(a5)
     e6a:	fe043783          	ld	a5,-32(s0)
     e6e:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     e70:	fe843783          	ld	a5,-24(s0)
     e74:	479c                	lw	a5,8(a5)
     e76:	1782                	slli	a5,a5,0x20
     e78:	9381                	srli	a5,a5,0x20
     e7a:	0792                	slli	a5,a5,0x4
     e7c:	fe843703          	ld	a4,-24(s0)
     e80:	97ba                	add	a5,a5,a4
     e82:	fe043703          	ld	a4,-32(s0)
     e86:	02f71563          	bne	a4,a5,eb0 <free+0x102>
    p->s.size += bp->s.size;
     e8a:	fe843783          	ld	a5,-24(s0)
     e8e:	4798                	lw	a4,8(a5)
     e90:	fe043783          	ld	a5,-32(s0)
     e94:	479c                	lw	a5,8(a5)
     e96:	9fb9                	addw	a5,a5,a4
     e98:	0007871b          	sext.w	a4,a5
     e9c:	fe843783          	ld	a5,-24(s0)
     ea0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     ea2:	fe043783          	ld	a5,-32(s0)
     ea6:	6398                	ld	a4,0(a5)
     ea8:	fe843783          	ld	a5,-24(s0)
     eac:	e398                	sd	a4,0(a5)
     eae:	a031                	j	eba <free+0x10c>
  } else
    p->s.ptr = bp;
     eb0:	fe843783          	ld	a5,-24(s0)
     eb4:	fe043703          	ld	a4,-32(s0)
     eb8:	e398                	sd	a4,0(a5)
  freep = p;
     eba:	00000797          	auipc	a5,0x0
     ebe:	28678793          	addi	a5,a5,646 # 1140 <freep>
     ec2:	fe843703          	ld	a4,-24(s0)
     ec6:	e398                	sd	a4,0(a5)
}
     ec8:	0001                	nop
     eca:	7422                	ld	s0,40(sp)
     ecc:	6145                	addi	sp,sp,48
     ece:	8082                	ret

0000000000000ed0 <morecore>:

static Header*
morecore(uint nu)
{
     ed0:	7179                	addi	sp,sp,-48
     ed2:	f406                	sd	ra,40(sp)
     ed4:	f022                	sd	s0,32(sp)
     ed6:	1800                	addi	s0,sp,48
     ed8:	87aa                	mv	a5,a0
     eda:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     ede:	fdc42783          	lw	a5,-36(s0)
     ee2:	0007871b          	sext.w	a4,a5
     ee6:	6785                	lui	a5,0x1
     ee8:	00f77563          	bgeu	a4,a5,ef2 <morecore+0x22>
    nu = 4096;
     eec:	6785                	lui	a5,0x1
     eee:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     ef2:	fdc42783          	lw	a5,-36(s0)
     ef6:	0047979b          	slliw	a5,a5,0x4
     efa:	2781                	sext.w	a5,a5
     efc:	2781                	sext.w	a5,a5
     efe:	853e                	mv	a0,a5
     f00:	00000097          	auipc	ra,0x0
     f04:	9a8080e7          	jalr	-1624(ra) # 8a8 <sbrk>
     f08:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     f0c:	fe843703          	ld	a4,-24(s0)
     f10:	57fd                	li	a5,-1
     f12:	00f71463          	bne	a4,a5,f1a <morecore+0x4a>
    return 0;
     f16:	4781                	li	a5,0
     f18:	a03d                	j	f46 <morecore+0x76>
  hp = (Header*)p;
     f1a:	fe843783          	ld	a5,-24(s0)
     f1e:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     f22:	fe043783          	ld	a5,-32(s0)
     f26:	fdc42703          	lw	a4,-36(s0)
     f2a:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f2c:	fe043783          	ld	a5,-32(s0)
     f30:	07c1                	addi	a5,a5,16
     f32:	853e                	mv	a0,a5
     f34:	00000097          	auipc	ra,0x0
     f38:	e7a080e7          	jalr	-390(ra) # dae <free>
  return freep;
     f3c:	00000797          	auipc	a5,0x0
     f40:	20478793          	addi	a5,a5,516 # 1140 <freep>
     f44:	639c                	ld	a5,0(a5)
}
     f46:	853e                	mv	a0,a5
     f48:	70a2                	ld	ra,40(sp)
     f4a:	7402                	ld	s0,32(sp)
     f4c:	6145                	addi	sp,sp,48
     f4e:	8082                	ret

0000000000000f50 <malloc>:

void*
malloc(uint nbytes)
{
     f50:	7139                	addi	sp,sp,-64
     f52:	fc06                	sd	ra,56(sp)
     f54:	f822                	sd	s0,48(sp)
     f56:	0080                	addi	s0,sp,64
     f58:	87aa                	mv	a5,a0
     f5a:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f5e:	fcc46783          	lwu	a5,-52(s0)
     f62:	07bd                	addi	a5,a5,15
     f64:	8391                	srli	a5,a5,0x4
     f66:	2781                	sext.w	a5,a5
     f68:	2785                	addiw	a5,a5,1
     f6a:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     f6e:	00000797          	auipc	a5,0x0
     f72:	1d278793          	addi	a5,a5,466 # 1140 <freep>
     f76:	639c                	ld	a5,0(a5)
     f78:	fef43023          	sd	a5,-32(s0)
     f7c:	fe043783          	ld	a5,-32(s0)
     f80:	ef95                	bnez	a5,fbc <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     f82:	00000797          	auipc	a5,0x0
     f86:	1ae78793          	addi	a5,a5,430 # 1130 <base>
     f8a:	fef43023          	sd	a5,-32(s0)
     f8e:	00000797          	auipc	a5,0x0
     f92:	1b278793          	addi	a5,a5,434 # 1140 <freep>
     f96:	fe043703          	ld	a4,-32(s0)
     f9a:	e398                	sd	a4,0(a5)
     f9c:	00000797          	auipc	a5,0x0
     fa0:	1a478793          	addi	a5,a5,420 # 1140 <freep>
     fa4:	6398                	ld	a4,0(a5)
     fa6:	00000797          	auipc	a5,0x0
     faa:	18a78793          	addi	a5,a5,394 # 1130 <base>
     fae:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     fb0:	00000797          	auipc	a5,0x0
     fb4:	18078793          	addi	a5,a5,384 # 1130 <base>
     fb8:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fbc:	fe043783          	ld	a5,-32(s0)
     fc0:	639c                	ld	a5,0(a5)
     fc2:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     fc6:	fe843783          	ld	a5,-24(s0)
     fca:	4798                	lw	a4,8(a5)
     fcc:	fdc42783          	lw	a5,-36(s0)
     fd0:	2781                	sext.w	a5,a5
     fd2:	06f76863          	bltu	a4,a5,1042 <malloc+0xf2>
      if(p->s.size == nunits)
     fd6:	fe843783          	ld	a5,-24(s0)
     fda:	4798                	lw	a4,8(a5)
     fdc:	fdc42783          	lw	a5,-36(s0)
     fe0:	2781                	sext.w	a5,a5
     fe2:	00e79963          	bne	a5,a4,ff4 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     fe6:	fe843783          	ld	a5,-24(s0)
     fea:	6398                	ld	a4,0(a5)
     fec:	fe043783          	ld	a5,-32(s0)
     ff0:	e398                	sd	a4,0(a5)
     ff2:	a82d                	j	102c <malloc+0xdc>
      else {
        p->s.size -= nunits;
     ff4:	fe843783          	ld	a5,-24(s0)
     ff8:	4798                	lw	a4,8(a5)
     ffa:	fdc42783          	lw	a5,-36(s0)
     ffe:	40f707bb          	subw	a5,a4,a5
    1002:	0007871b          	sext.w	a4,a5
    1006:	fe843783          	ld	a5,-24(s0)
    100a:	c798                	sw	a4,8(a5)
        p += p->s.size;
    100c:	fe843783          	ld	a5,-24(s0)
    1010:	479c                	lw	a5,8(a5)
    1012:	1782                	slli	a5,a5,0x20
    1014:	9381                	srli	a5,a5,0x20
    1016:	0792                	slli	a5,a5,0x4
    1018:	fe843703          	ld	a4,-24(s0)
    101c:	97ba                	add	a5,a5,a4
    101e:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1022:	fe843783          	ld	a5,-24(s0)
    1026:	fdc42703          	lw	a4,-36(s0)
    102a:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    102c:	00000797          	auipc	a5,0x0
    1030:	11478793          	addi	a5,a5,276 # 1140 <freep>
    1034:	fe043703          	ld	a4,-32(s0)
    1038:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    103a:	fe843783          	ld	a5,-24(s0)
    103e:	07c1                	addi	a5,a5,16
    1040:	a091                	j	1084 <malloc+0x134>
    }
    if(p == freep)
    1042:	00000797          	auipc	a5,0x0
    1046:	0fe78793          	addi	a5,a5,254 # 1140 <freep>
    104a:	639c                	ld	a5,0(a5)
    104c:	fe843703          	ld	a4,-24(s0)
    1050:	02f71063          	bne	a4,a5,1070 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
    1054:	fdc42783          	lw	a5,-36(s0)
    1058:	853e                	mv	a0,a5
    105a:	00000097          	auipc	ra,0x0
    105e:	e76080e7          	jalr	-394(ra) # ed0 <morecore>
    1062:	fea43423          	sd	a0,-24(s0)
    1066:	fe843783          	ld	a5,-24(s0)
    106a:	e399                	bnez	a5,1070 <malloc+0x120>
        return 0;
    106c:	4781                	li	a5,0
    106e:	a819                	j	1084 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1070:	fe843783          	ld	a5,-24(s0)
    1074:	fef43023          	sd	a5,-32(s0)
    1078:	fe843783          	ld	a5,-24(s0)
    107c:	639c                	ld	a5,0(a5)
    107e:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1082:	b791                	j	fc6 <malloc+0x76>
  }
}
    1084:	853e                	mv	a0,a5
    1086:	70e2                	ld	ra,56(sp)
    1088:	7442                	ld	s0,48(sp)
    108a:	6121                	addi	sp,sp,64
    108c:	8082                	ret
