
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
      16:	430080e7          	jalr	1072(ra) # 442 <strlen>
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
      68:	3de080e7          	jalr	990(ra) # 442 <strlen>
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
      86:	3c0080e7          	jalr	960(ra) # 442 <strlen>
      8a:	87aa                	mv	a5,a0
      8c:	2781                	sext.w	a5,a5
      8e:	2781                	sext.w	a5,a5
      90:	863e                	mv	a2,a5
      92:	fd843583          	ld	a1,-40(s0)
      96:	00001517          	auipc	a0,0x1
      9a:	1fa50513          	addi	a0,a0,506 # 1290 <buf.0>
      9e:	00000097          	auipc	ra,0x0
      a2:	600080e7          	jalr	1536(ra) # 69e <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
      a6:	fd843503          	ld	a0,-40(s0)
      aa:	00000097          	auipc	ra,0x0
      ae:	398080e7          	jalr	920(ra) # 442 <strlen>
      b2:	87aa                	mv	a5,a0
      b4:	2781                	sext.w	a5,a5
      b6:	02079713          	slli	a4,a5,0x20
      ba:	9301                	srli	a4,a4,0x20
      bc:	00001797          	auipc	a5,0x1
      c0:	1d478793          	addi	a5,a5,468 # 1290 <buf.0>
      c4:	00f704b3          	add	s1,a4,a5
      c8:	fd843503          	ld	a0,-40(s0)
      cc:	00000097          	auipc	ra,0x0
      d0:	376080e7          	jalr	886(ra) # 442 <strlen>
      d4:	87aa                	mv	a5,a0
      d6:	2781                	sext.w	a5,a5
      d8:	4739                	li	a4,14
      da:	40f707bb          	subw	a5,a4,a5
      de:	2781                	sext.w	a5,a5
      e0:	863e                	mv	a2,a5
      e2:	02000593          	li	a1,32
      e6:	8526                	mv	a0,s1
      e8:	00000097          	auipc	ra,0x0
      ec:	390080e7          	jalr	912(ra) # 478 <memset>
  return buf;
      f0:	00001797          	auipc	a5,0x1
      f4:	1a078793          	addi	a5,a5,416 # 1290 <buf.0>
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
     120:	748080e7          	jalr	1864(ra) # 864 <open>
     124:	87aa                	mv	a5,a0
     126:	fef42623          	sw	a5,-20(s0)
     12a:	fec42783          	lw	a5,-20(s0)
     12e:	2781                	sext.w	a5,a5
     130:	0007de63          	bgez	a5,14c <ls+0x48>
    fprintf(2, "ls: cannot open %s\n", path);
     134:	da843603          	ld	a2,-600(s0)
     138:	00001597          	auipc	a1,0x1
     13c:	07858593          	addi	a1,a1,120 # 11b0 <lock_init+0x1c>
     140:	4509                	li	a0,2
     142:	00001097          	auipc	ra,0x1
     146:	bc2080e7          	jalr	-1086(ra) # d04 <fprintf>
    return;
     14a:	aa6d                	j	304 <ls+0x200>
  }

  if(fstat(fd, &st) < 0){
     14c:	db840713          	addi	a4,s0,-584
     150:	fec42783          	lw	a5,-20(s0)
     154:	85ba                	mv	a1,a4
     156:	853e                	mv	a0,a5
     158:	00000097          	auipc	ra,0x0
     15c:	724080e7          	jalr	1828(ra) # 87c <fstat>
     160:	87aa                	mv	a5,a0
     162:	0207d563          	bgez	a5,18c <ls+0x88>
    fprintf(2, "ls: cannot stat %s\n", path);
     166:	da843603          	ld	a2,-600(s0)
     16a:	00001597          	auipc	a1,0x1
     16e:	05e58593          	addi	a1,a1,94 # 11c8 <lock_init+0x34>
     172:	4509                	li	a0,2
     174:	00001097          	auipc	ra,0x1
     178:	b90080e7          	jalr	-1136(ra) # d04 <fprintf>
    close(fd);
     17c:	fec42783          	lw	a5,-20(s0)
     180:	853e                	mv	a0,a5
     182:	00000097          	auipc	ra,0x0
     186:	6ca080e7          	jalr	1738(ra) # 84c <close>
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
     1c4:	02050513          	addi	a0,a0,32 # 11e0 <lock_init+0x4c>
     1c8:	00001097          	auipc	ra,0x1
     1cc:	b94080e7          	jalr	-1132(ra) # d5c <printf>
    break;
     1d0:	a21d                	j	2f6 <ls+0x1f2>

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     1d2:	da843503          	ld	a0,-600(s0)
     1d6:	00000097          	auipc	ra,0x0
     1da:	26c080e7          	jalr	620(ra) # 442 <strlen>
     1de:	87aa                	mv	a5,a0
     1e0:	2781                	sext.w	a5,a5
     1e2:	27c1                	addiw	a5,a5,16
     1e4:	2781                	sext.w	a5,a5
     1e6:	873e                	mv	a4,a5
     1e8:	20000793          	li	a5,512
     1ec:	00e7fb63          	bgeu	a5,a4,202 <ls+0xfe>
      printf("ls: path too long\n");
     1f0:	00001517          	auipc	a0,0x1
     1f4:	00050513          	mv	a0,a0
     1f8:	00001097          	auipc	ra,0x1
     1fc:	b64080e7          	jalr	-1180(ra) # d5c <printf>
      break;
     200:	a8dd                	j	2f6 <ls+0x1f2>
    }
    strcpy(buf, path);
     202:	de040793          	addi	a5,s0,-544
     206:	da843583          	ld	a1,-600(s0)
     20a:	853e                	mv	a0,a5
     20c:	00000097          	auipc	ra,0x0
     210:	186080e7          	jalr	390(ra) # 392 <strcpy>
    p = buf+strlen(buf);
     214:	de040793          	addi	a5,s0,-544
     218:	853e                	mv	a0,a5
     21a:	00000097          	auipc	ra,0x0
     21e:	228080e7          	jalr	552(ra) # 442 <strlen>
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
     264:	43e080e7          	jalr	1086(ra) # 69e <memmove>
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
     282:	346080e7          	jalr	838(ra) # 5c4 <stat>
     286:	87aa                	mv	a5,a0
     288:	0007de63          	bgez	a5,2a4 <ls+0x1a0>
        printf("ls: cannot stat %s\n", buf);
     28c:	de040793          	addi	a5,s0,-544
     290:	85be                	mv	a1,a5
     292:	00001517          	auipc	a0,0x1
     296:	f3650513          	addi	a0,a0,-202 # 11c8 <lock_init+0x34>
     29a:	00001097          	auipc	ra,0x1
     29e:	ac2080e7          	jalr	-1342(ra) # d5c <printf>
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
     2c8:	f4450513          	addi	a0,a0,-188 # 1208 <lock_init+0x74>
     2cc:	00001097          	auipc	ra,0x1
     2d0:	a90080e7          	jalr	-1392(ra) # d5c <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     2d4:	dd040713          	addi	a4,s0,-560
     2d8:	fec42783          	lw	a5,-20(s0)
     2dc:	4641                	li	a2,16
     2de:	85ba                	mv	a1,a4
     2e0:	853e                	mv	a0,a5
     2e2:	00000097          	auipc	ra,0x0
     2e6:	55a080e7          	jalr	1370(ra) # 83c <read>
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
     300:	550080e7          	jalr	1360(ra) # 84c <close>
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
     336:	ee650513          	addi	a0,a0,-282 # 1218 <lock_init+0x84>
     33a:	00000097          	auipc	ra,0x0
     33e:	dca080e7          	jalr	-566(ra) # 104 <ls>
    exit(0);
     342:	4501                	li	a0,0
     344:	00000097          	auipc	ra,0x0
     348:	4e0080e7          	jalr	1248(ra) # 824 <exit>
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
     376:	fec42783          	lw	a5,-20(s0)
     37a:	873e                	mv	a4,a5
     37c:	fdc42783          	lw	a5,-36(s0)
     380:	2701                	sext.w	a4,a4
     382:	2781                	sext.w	a5,a5
     384:	fcf748e3          	blt	a4,a5,354 <main+0x42>
  exit(0);
     388:	4501                	li	a0,0
     38a:	00000097          	auipc	ra,0x0
     38e:	49a080e7          	jalr	1178(ra) # 824 <exit>

0000000000000392 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     392:	7179                	addi	sp,sp,-48
     394:	f422                	sd	s0,40(sp)
     396:	1800                	addi	s0,sp,48
     398:	fca43c23          	sd	a0,-40(s0)
     39c:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     3a0:	fd843783          	ld	a5,-40(s0)
     3a4:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     3a8:	0001                	nop
     3aa:	fd043703          	ld	a4,-48(s0)
     3ae:	00170793          	addi	a5,a4,1
     3b2:	fcf43823          	sd	a5,-48(s0)
     3b6:	fd843783          	ld	a5,-40(s0)
     3ba:	00178693          	addi	a3,a5,1
     3be:	fcd43c23          	sd	a3,-40(s0)
     3c2:	00074703          	lbu	a4,0(a4)
     3c6:	00e78023          	sb	a4,0(a5)
     3ca:	0007c783          	lbu	a5,0(a5)
     3ce:	fff1                	bnez	a5,3aa <strcpy+0x18>
    ;
  return os;
     3d0:	fe843783          	ld	a5,-24(s0)
}
     3d4:	853e                	mv	a0,a5
     3d6:	7422                	ld	s0,40(sp)
     3d8:	6145                	addi	sp,sp,48
     3da:	8082                	ret

00000000000003dc <strcmp>:

int
strcmp(const char *p, const char *q)
{
     3dc:	1101                	addi	sp,sp,-32
     3de:	ec22                	sd	s0,24(sp)
     3e0:	1000                	addi	s0,sp,32
     3e2:	fea43423          	sd	a0,-24(s0)
     3e6:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     3ea:	a819                	j	400 <strcmp+0x24>
    p++, q++;
     3ec:	fe843783          	ld	a5,-24(s0)
     3f0:	0785                	addi	a5,a5,1
     3f2:	fef43423          	sd	a5,-24(s0)
     3f6:	fe043783          	ld	a5,-32(s0)
     3fa:	0785                	addi	a5,a5,1
     3fc:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     400:	fe843783          	ld	a5,-24(s0)
     404:	0007c783          	lbu	a5,0(a5)
     408:	cb99                	beqz	a5,41e <strcmp+0x42>
     40a:	fe843783          	ld	a5,-24(s0)
     40e:	0007c703          	lbu	a4,0(a5)
     412:	fe043783          	ld	a5,-32(s0)
     416:	0007c783          	lbu	a5,0(a5)
     41a:	fcf709e3          	beq	a4,a5,3ec <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     41e:	fe843783          	ld	a5,-24(s0)
     422:	0007c783          	lbu	a5,0(a5)
     426:	0007871b          	sext.w	a4,a5
     42a:	fe043783          	ld	a5,-32(s0)
     42e:	0007c783          	lbu	a5,0(a5)
     432:	2781                	sext.w	a5,a5
     434:	40f707bb          	subw	a5,a4,a5
     438:	2781                	sext.w	a5,a5
}
     43a:	853e                	mv	a0,a5
     43c:	6462                	ld	s0,24(sp)
     43e:	6105                	addi	sp,sp,32
     440:	8082                	ret

0000000000000442 <strlen>:

uint
strlen(const char *s)
{
     442:	7179                	addi	sp,sp,-48
     444:	f422                	sd	s0,40(sp)
     446:	1800                	addi	s0,sp,48
     448:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     44c:	fe042623          	sw	zero,-20(s0)
     450:	a031                	j	45c <strlen+0x1a>
     452:	fec42783          	lw	a5,-20(s0)
     456:	2785                	addiw	a5,a5,1
     458:	fef42623          	sw	a5,-20(s0)
     45c:	fec42783          	lw	a5,-20(s0)
     460:	fd843703          	ld	a4,-40(s0)
     464:	97ba                	add	a5,a5,a4
     466:	0007c783          	lbu	a5,0(a5)
     46a:	f7e5                	bnez	a5,452 <strlen+0x10>
    ;
  return n;
     46c:	fec42783          	lw	a5,-20(s0)
}
     470:	853e                	mv	a0,a5
     472:	7422                	ld	s0,40(sp)
     474:	6145                	addi	sp,sp,48
     476:	8082                	ret

0000000000000478 <memset>:

void*
memset(void *dst, int c, uint n)
{
     478:	7179                	addi	sp,sp,-48
     47a:	f422                	sd	s0,40(sp)
     47c:	1800                	addi	s0,sp,48
     47e:	fca43c23          	sd	a0,-40(s0)
     482:	87ae                	mv	a5,a1
     484:	8732                	mv	a4,a2
     486:	fcf42a23          	sw	a5,-44(s0)
     48a:	87ba                	mv	a5,a4
     48c:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     490:	fd843783          	ld	a5,-40(s0)
     494:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     498:	fe042623          	sw	zero,-20(s0)
     49c:	a00d                	j	4be <memset+0x46>
    cdst[i] = c;
     49e:	fec42783          	lw	a5,-20(s0)
     4a2:	fe043703          	ld	a4,-32(s0)
     4a6:	97ba                	add	a5,a5,a4
     4a8:	fd442703          	lw	a4,-44(s0)
     4ac:	0ff77713          	zext.b	a4,a4
     4b0:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     4b4:	fec42783          	lw	a5,-20(s0)
     4b8:	2785                	addiw	a5,a5,1
     4ba:	fef42623          	sw	a5,-20(s0)
     4be:	fec42703          	lw	a4,-20(s0)
     4c2:	fd042783          	lw	a5,-48(s0)
     4c6:	2781                	sext.w	a5,a5
     4c8:	fcf76be3          	bltu	a4,a5,49e <memset+0x26>
  }
  return dst;
     4cc:	fd843783          	ld	a5,-40(s0)
}
     4d0:	853e                	mv	a0,a5
     4d2:	7422                	ld	s0,40(sp)
     4d4:	6145                	addi	sp,sp,48
     4d6:	8082                	ret

00000000000004d8 <strchr>:

char*
strchr(const char *s, char c)
{
     4d8:	1101                	addi	sp,sp,-32
     4da:	ec22                	sd	s0,24(sp)
     4dc:	1000                	addi	s0,sp,32
     4de:	fea43423          	sd	a0,-24(s0)
     4e2:	87ae                	mv	a5,a1
     4e4:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     4e8:	a01d                	j	50e <strchr+0x36>
    if(*s == c)
     4ea:	fe843783          	ld	a5,-24(s0)
     4ee:	0007c703          	lbu	a4,0(a5)
     4f2:	fe744783          	lbu	a5,-25(s0)
     4f6:	0ff7f793          	zext.b	a5,a5
     4fa:	00e79563          	bne	a5,a4,504 <strchr+0x2c>
      return (char*)s;
     4fe:	fe843783          	ld	a5,-24(s0)
     502:	a821                	j	51a <strchr+0x42>
  for(; *s; s++)
     504:	fe843783          	ld	a5,-24(s0)
     508:	0785                	addi	a5,a5,1
     50a:	fef43423          	sd	a5,-24(s0)
     50e:	fe843783          	ld	a5,-24(s0)
     512:	0007c783          	lbu	a5,0(a5)
     516:	fbf1                	bnez	a5,4ea <strchr+0x12>
  return 0;
     518:	4781                	li	a5,0
}
     51a:	853e                	mv	a0,a5
     51c:	6462                	ld	s0,24(sp)
     51e:	6105                	addi	sp,sp,32
     520:	8082                	ret

0000000000000522 <gets>:

char*
gets(char *buf, int max)
{
     522:	7179                	addi	sp,sp,-48
     524:	f406                	sd	ra,40(sp)
     526:	f022                	sd	s0,32(sp)
     528:	1800                	addi	s0,sp,48
     52a:	fca43c23          	sd	a0,-40(s0)
     52e:	87ae                	mv	a5,a1
     530:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     534:	fe042623          	sw	zero,-20(s0)
     538:	a8a1                	j	590 <gets+0x6e>
    cc = read(0, &c, 1);
     53a:	fe740793          	addi	a5,s0,-25
     53e:	4605                	li	a2,1
     540:	85be                	mv	a1,a5
     542:	4501                	li	a0,0
     544:	00000097          	auipc	ra,0x0
     548:	2f8080e7          	jalr	760(ra) # 83c <read>
     54c:	87aa                	mv	a5,a0
     54e:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     552:	fe842783          	lw	a5,-24(s0)
     556:	2781                	sext.w	a5,a5
     558:	04f05763          	blez	a5,5a6 <gets+0x84>
      break;
    buf[i++] = c;
     55c:	fec42783          	lw	a5,-20(s0)
     560:	0017871b          	addiw	a4,a5,1
     564:	fee42623          	sw	a4,-20(s0)
     568:	873e                	mv	a4,a5
     56a:	fd843783          	ld	a5,-40(s0)
     56e:	97ba                	add	a5,a5,a4
     570:	fe744703          	lbu	a4,-25(s0)
     574:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     578:	fe744783          	lbu	a5,-25(s0)
     57c:	873e                	mv	a4,a5
     57e:	47a9                	li	a5,10
     580:	02f70463          	beq	a4,a5,5a8 <gets+0x86>
     584:	fe744783          	lbu	a5,-25(s0)
     588:	873e                	mv	a4,a5
     58a:	47b5                	li	a5,13
     58c:	00f70e63          	beq	a4,a5,5a8 <gets+0x86>
  for(i=0; i+1 < max; ){
     590:	fec42783          	lw	a5,-20(s0)
     594:	2785                	addiw	a5,a5,1
     596:	0007871b          	sext.w	a4,a5
     59a:	fd442783          	lw	a5,-44(s0)
     59e:	2781                	sext.w	a5,a5
     5a0:	f8f74de3          	blt	a4,a5,53a <gets+0x18>
     5a4:	a011                	j	5a8 <gets+0x86>
      break;
     5a6:	0001                	nop
      break;
  }
  buf[i] = '\0';
     5a8:	fec42783          	lw	a5,-20(s0)
     5ac:	fd843703          	ld	a4,-40(s0)
     5b0:	97ba                	add	a5,a5,a4
     5b2:	00078023          	sb	zero,0(a5)
  return buf;
     5b6:	fd843783          	ld	a5,-40(s0)
}
     5ba:	853e                	mv	a0,a5
     5bc:	70a2                	ld	ra,40(sp)
     5be:	7402                	ld	s0,32(sp)
     5c0:	6145                	addi	sp,sp,48
     5c2:	8082                	ret

00000000000005c4 <stat>:

int
stat(const char *n, struct stat *st)
{
     5c4:	7179                	addi	sp,sp,-48
     5c6:	f406                	sd	ra,40(sp)
     5c8:	f022                	sd	s0,32(sp)
     5ca:	1800                	addi	s0,sp,48
     5cc:	fca43c23          	sd	a0,-40(s0)
     5d0:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     5d4:	4581                	li	a1,0
     5d6:	fd843503          	ld	a0,-40(s0)
     5da:	00000097          	auipc	ra,0x0
     5de:	28a080e7          	jalr	650(ra) # 864 <open>
     5e2:	87aa                	mv	a5,a0
     5e4:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     5e8:	fec42783          	lw	a5,-20(s0)
     5ec:	2781                	sext.w	a5,a5
     5ee:	0007d463          	bgez	a5,5f6 <stat+0x32>
    return -1;
     5f2:	57fd                	li	a5,-1
     5f4:	a035                	j	620 <stat+0x5c>
  r = fstat(fd, st);
     5f6:	fec42783          	lw	a5,-20(s0)
     5fa:	fd043583          	ld	a1,-48(s0)
     5fe:	853e                	mv	a0,a5
     600:	00000097          	auipc	ra,0x0
     604:	27c080e7          	jalr	636(ra) # 87c <fstat>
     608:	87aa                	mv	a5,a0
     60a:	fef42423          	sw	a5,-24(s0)
  close(fd);
     60e:	fec42783          	lw	a5,-20(s0)
     612:	853e                	mv	a0,a5
     614:	00000097          	auipc	ra,0x0
     618:	238080e7          	jalr	568(ra) # 84c <close>
  return r;
     61c:	fe842783          	lw	a5,-24(s0)
}
     620:	853e                	mv	a0,a5
     622:	70a2                	ld	ra,40(sp)
     624:	7402                	ld	s0,32(sp)
     626:	6145                	addi	sp,sp,48
     628:	8082                	ret

000000000000062a <atoi>:

int
atoi(const char *s)
{
     62a:	7179                	addi	sp,sp,-48
     62c:	f422                	sd	s0,40(sp)
     62e:	1800                	addi	s0,sp,48
     630:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     634:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     638:	a81d                	j	66e <atoi+0x44>
    n = n*10 + *s++ - '0';
     63a:	fec42783          	lw	a5,-20(s0)
     63e:	873e                	mv	a4,a5
     640:	87ba                	mv	a5,a4
     642:	0027979b          	slliw	a5,a5,0x2
     646:	9fb9                	addw	a5,a5,a4
     648:	0017979b          	slliw	a5,a5,0x1
     64c:	0007871b          	sext.w	a4,a5
     650:	fd843783          	ld	a5,-40(s0)
     654:	00178693          	addi	a3,a5,1
     658:	fcd43c23          	sd	a3,-40(s0)
     65c:	0007c783          	lbu	a5,0(a5)
     660:	2781                	sext.w	a5,a5
     662:	9fb9                	addw	a5,a5,a4
     664:	2781                	sext.w	a5,a5
     666:	fd07879b          	addiw	a5,a5,-48
     66a:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     66e:	fd843783          	ld	a5,-40(s0)
     672:	0007c783          	lbu	a5,0(a5)
     676:	873e                	mv	a4,a5
     678:	02f00793          	li	a5,47
     67c:	00e7fb63          	bgeu	a5,a4,692 <atoi+0x68>
     680:	fd843783          	ld	a5,-40(s0)
     684:	0007c783          	lbu	a5,0(a5)
     688:	873e                	mv	a4,a5
     68a:	03900793          	li	a5,57
     68e:	fae7f6e3          	bgeu	a5,a4,63a <atoi+0x10>
  return n;
     692:	fec42783          	lw	a5,-20(s0)
}
     696:	853e                	mv	a0,a5
     698:	7422                	ld	s0,40(sp)
     69a:	6145                	addi	sp,sp,48
     69c:	8082                	ret

000000000000069e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     69e:	7139                	addi	sp,sp,-64
     6a0:	fc22                	sd	s0,56(sp)
     6a2:	0080                	addi	s0,sp,64
     6a4:	fca43c23          	sd	a0,-40(s0)
     6a8:	fcb43823          	sd	a1,-48(s0)
     6ac:	87b2                	mv	a5,a2
     6ae:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     6b2:	fd843783          	ld	a5,-40(s0)
     6b6:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     6ba:	fd043783          	ld	a5,-48(s0)
     6be:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     6c2:	fe043703          	ld	a4,-32(s0)
     6c6:	fe843783          	ld	a5,-24(s0)
     6ca:	02e7fc63          	bgeu	a5,a4,702 <memmove+0x64>
    while(n-- > 0)
     6ce:	a00d                	j	6f0 <memmove+0x52>
      *dst++ = *src++;
     6d0:	fe043703          	ld	a4,-32(s0)
     6d4:	00170793          	addi	a5,a4,1
     6d8:	fef43023          	sd	a5,-32(s0)
     6dc:	fe843783          	ld	a5,-24(s0)
     6e0:	00178693          	addi	a3,a5,1
     6e4:	fed43423          	sd	a3,-24(s0)
     6e8:	00074703          	lbu	a4,0(a4)
     6ec:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     6f0:	fcc42783          	lw	a5,-52(s0)
     6f4:	fff7871b          	addiw	a4,a5,-1
     6f8:	fce42623          	sw	a4,-52(s0)
     6fc:	fcf04ae3          	bgtz	a5,6d0 <memmove+0x32>
     700:	a891                	j	754 <memmove+0xb6>
  } else {
    dst += n;
     702:	fcc42783          	lw	a5,-52(s0)
     706:	fe843703          	ld	a4,-24(s0)
     70a:	97ba                	add	a5,a5,a4
     70c:	fef43423          	sd	a5,-24(s0)
    src += n;
     710:	fcc42783          	lw	a5,-52(s0)
     714:	fe043703          	ld	a4,-32(s0)
     718:	97ba                	add	a5,a5,a4
     71a:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     71e:	a01d                	j	744 <memmove+0xa6>
      *--dst = *--src;
     720:	fe043783          	ld	a5,-32(s0)
     724:	17fd                	addi	a5,a5,-1
     726:	fef43023          	sd	a5,-32(s0)
     72a:	fe843783          	ld	a5,-24(s0)
     72e:	17fd                	addi	a5,a5,-1
     730:	fef43423          	sd	a5,-24(s0)
     734:	fe043783          	ld	a5,-32(s0)
     738:	0007c703          	lbu	a4,0(a5)
     73c:	fe843783          	ld	a5,-24(s0)
     740:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     744:	fcc42783          	lw	a5,-52(s0)
     748:	fff7871b          	addiw	a4,a5,-1
     74c:	fce42623          	sw	a4,-52(s0)
     750:	fcf048e3          	bgtz	a5,720 <memmove+0x82>
  }
  return vdst;
     754:	fd843783          	ld	a5,-40(s0)
}
     758:	853e                	mv	a0,a5
     75a:	7462                	ld	s0,56(sp)
     75c:	6121                	addi	sp,sp,64
     75e:	8082                	ret

0000000000000760 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     760:	7139                	addi	sp,sp,-64
     762:	fc22                	sd	s0,56(sp)
     764:	0080                	addi	s0,sp,64
     766:	fca43c23          	sd	a0,-40(s0)
     76a:	fcb43823          	sd	a1,-48(s0)
     76e:	87b2                	mv	a5,a2
     770:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     774:	fd843783          	ld	a5,-40(s0)
     778:	fef43423          	sd	a5,-24(s0)
     77c:	fd043783          	ld	a5,-48(s0)
     780:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     784:	a0a1                	j	7cc <memcmp+0x6c>
    if (*p1 != *p2) {
     786:	fe843783          	ld	a5,-24(s0)
     78a:	0007c703          	lbu	a4,0(a5)
     78e:	fe043783          	ld	a5,-32(s0)
     792:	0007c783          	lbu	a5,0(a5)
     796:	02f70163          	beq	a4,a5,7b8 <memcmp+0x58>
      return *p1 - *p2;
     79a:	fe843783          	ld	a5,-24(s0)
     79e:	0007c783          	lbu	a5,0(a5)
     7a2:	0007871b          	sext.w	a4,a5
     7a6:	fe043783          	ld	a5,-32(s0)
     7aa:	0007c783          	lbu	a5,0(a5)
     7ae:	2781                	sext.w	a5,a5
     7b0:	40f707bb          	subw	a5,a4,a5
     7b4:	2781                	sext.w	a5,a5
     7b6:	a01d                	j	7dc <memcmp+0x7c>
    }
    p1++;
     7b8:	fe843783          	ld	a5,-24(s0)
     7bc:	0785                	addi	a5,a5,1
     7be:	fef43423          	sd	a5,-24(s0)
    p2++;
     7c2:	fe043783          	ld	a5,-32(s0)
     7c6:	0785                	addi	a5,a5,1
     7c8:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     7cc:	fcc42783          	lw	a5,-52(s0)
     7d0:	fff7871b          	addiw	a4,a5,-1
     7d4:	fce42623          	sw	a4,-52(s0)
     7d8:	f7dd                	bnez	a5,786 <memcmp+0x26>
  }
  return 0;
     7da:	4781                	li	a5,0
}
     7dc:	853e                	mv	a0,a5
     7de:	7462                	ld	s0,56(sp)
     7e0:	6121                	addi	sp,sp,64
     7e2:	8082                	ret

00000000000007e4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     7e4:	7179                	addi	sp,sp,-48
     7e6:	f406                	sd	ra,40(sp)
     7e8:	f022                	sd	s0,32(sp)
     7ea:	1800                	addi	s0,sp,48
     7ec:	fea43423          	sd	a0,-24(s0)
     7f0:	feb43023          	sd	a1,-32(s0)
     7f4:	87b2                	mv	a5,a2
     7f6:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     7fa:	fdc42783          	lw	a5,-36(s0)
     7fe:	863e                	mv	a2,a5
     800:	fe043583          	ld	a1,-32(s0)
     804:	fe843503          	ld	a0,-24(s0)
     808:	00000097          	auipc	ra,0x0
     80c:	e96080e7          	jalr	-362(ra) # 69e <memmove>
     810:	87aa                	mv	a5,a0
}
     812:	853e                	mv	a0,a5
     814:	70a2                	ld	ra,40(sp)
     816:	7402                	ld	s0,32(sp)
     818:	6145                	addi	sp,sp,48
     81a:	8082                	ret

000000000000081c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     81c:	4885                	li	a7,1
 ecall
     81e:	00000073          	ecall
 ret
     822:	8082                	ret

0000000000000824 <exit>:
.global exit
exit:
 li a7, SYS_exit
     824:	4889                	li	a7,2
 ecall
     826:	00000073          	ecall
 ret
     82a:	8082                	ret

000000000000082c <wait>:
.global wait
wait:
 li a7, SYS_wait
     82c:	488d                	li	a7,3
 ecall
     82e:	00000073          	ecall
 ret
     832:	8082                	ret

0000000000000834 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     834:	4891                	li	a7,4
 ecall
     836:	00000073          	ecall
 ret
     83a:	8082                	ret

000000000000083c <read>:
.global read
read:
 li a7, SYS_read
     83c:	4895                	li	a7,5
 ecall
     83e:	00000073          	ecall
 ret
     842:	8082                	ret

0000000000000844 <write>:
.global write
write:
 li a7, SYS_write
     844:	48c1                	li	a7,16
 ecall
     846:	00000073          	ecall
 ret
     84a:	8082                	ret

000000000000084c <close>:
.global close
close:
 li a7, SYS_close
     84c:	48d5                	li	a7,21
 ecall
     84e:	00000073          	ecall
 ret
     852:	8082                	ret

0000000000000854 <kill>:
.global kill
kill:
 li a7, SYS_kill
     854:	4899                	li	a7,6
 ecall
     856:	00000073          	ecall
 ret
     85a:	8082                	ret

000000000000085c <exec>:
.global exec
exec:
 li a7, SYS_exec
     85c:	489d                	li	a7,7
 ecall
     85e:	00000073          	ecall
 ret
     862:	8082                	ret

0000000000000864 <open>:
.global open
open:
 li a7, SYS_open
     864:	48bd                	li	a7,15
 ecall
     866:	00000073          	ecall
 ret
     86a:	8082                	ret

000000000000086c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     86c:	48c5                	li	a7,17
 ecall
     86e:	00000073          	ecall
 ret
     872:	8082                	ret

0000000000000874 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     874:	48c9                	li	a7,18
 ecall
     876:	00000073          	ecall
 ret
     87a:	8082                	ret

000000000000087c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     87c:	48a1                	li	a7,8
 ecall
     87e:	00000073          	ecall
 ret
     882:	8082                	ret

0000000000000884 <link>:
.global link
link:
 li a7, SYS_link
     884:	48cd                	li	a7,19
 ecall
     886:	00000073          	ecall
 ret
     88a:	8082                	ret

000000000000088c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     88c:	48d1                	li	a7,20
 ecall
     88e:	00000073          	ecall
 ret
     892:	8082                	ret

0000000000000894 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     894:	48a5                	li	a7,9
 ecall
     896:	00000073          	ecall
 ret
     89a:	8082                	ret

000000000000089c <dup>:
.global dup
dup:
 li a7, SYS_dup
     89c:	48a9                	li	a7,10
 ecall
     89e:	00000073          	ecall
 ret
     8a2:	8082                	ret

00000000000008a4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     8a4:	48ad                	li	a7,11
 ecall
     8a6:	00000073          	ecall
 ret
     8aa:	8082                	ret

00000000000008ac <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     8ac:	48b1                	li	a7,12
 ecall
     8ae:	00000073          	ecall
 ret
     8b2:	8082                	ret

00000000000008b4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     8b4:	48b5                	li	a7,13
 ecall
     8b6:	00000073          	ecall
 ret
     8ba:	8082                	ret

00000000000008bc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     8bc:	48b9                	li	a7,14
 ecall
     8be:	00000073          	ecall
 ret
     8c2:	8082                	ret

00000000000008c4 <clone>:
.global clone
clone:
 li a7, SYS_clone
     8c4:	48d9                	li	a7,22
 ecall
     8c6:	00000073          	ecall
 ret
     8ca:	8082                	ret

00000000000008cc <join>:
.global join
join:
 li a7, SYS_join
     8cc:	48dd                	li	a7,23
 ecall
     8ce:	00000073          	ecall
 ret
     8d2:	8082                	ret

00000000000008d4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     8d4:	1101                	addi	sp,sp,-32
     8d6:	ec06                	sd	ra,24(sp)
     8d8:	e822                	sd	s0,16(sp)
     8da:	1000                	addi	s0,sp,32
     8dc:	87aa                	mv	a5,a0
     8de:	872e                	mv	a4,a1
     8e0:	fef42623          	sw	a5,-20(s0)
     8e4:	87ba                	mv	a5,a4
     8e6:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     8ea:	feb40713          	addi	a4,s0,-21
     8ee:	fec42783          	lw	a5,-20(s0)
     8f2:	4605                	li	a2,1
     8f4:	85ba                	mv	a1,a4
     8f6:	853e                	mv	a0,a5
     8f8:	00000097          	auipc	ra,0x0
     8fc:	f4c080e7          	jalr	-180(ra) # 844 <write>
}
     900:	0001                	nop
     902:	60e2                	ld	ra,24(sp)
     904:	6442                	ld	s0,16(sp)
     906:	6105                	addi	sp,sp,32
     908:	8082                	ret

000000000000090a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     90a:	7139                	addi	sp,sp,-64
     90c:	fc06                	sd	ra,56(sp)
     90e:	f822                	sd	s0,48(sp)
     910:	0080                	addi	s0,sp,64
     912:	87aa                	mv	a5,a0
     914:	8736                	mv	a4,a3
     916:	fcf42623          	sw	a5,-52(s0)
     91a:	87ae                	mv	a5,a1
     91c:	fcf42423          	sw	a5,-56(s0)
     920:	87b2                	mv	a5,a2
     922:	fcf42223          	sw	a5,-60(s0)
     926:	87ba                	mv	a5,a4
     928:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     92c:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     930:	fc042783          	lw	a5,-64(s0)
     934:	2781                	sext.w	a5,a5
     936:	c38d                	beqz	a5,958 <printint+0x4e>
     938:	fc842783          	lw	a5,-56(s0)
     93c:	2781                	sext.w	a5,a5
     93e:	0007dd63          	bgez	a5,958 <printint+0x4e>
    neg = 1;
     942:	4785                	li	a5,1
     944:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     948:	fc842783          	lw	a5,-56(s0)
     94c:	40f007bb          	negw	a5,a5
     950:	2781                	sext.w	a5,a5
     952:	fef42223          	sw	a5,-28(s0)
     956:	a029                	j	960 <printint+0x56>
  } else {
    x = xx;
     958:	fc842783          	lw	a5,-56(s0)
     95c:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     960:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     964:	fc442783          	lw	a5,-60(s0)
     968:	fe442703          	lw	a4,-28(s0)
     96c:	02f777bb          	remuw	a5,a4,a5
     970:	0007861b          	sext.w	a2,a5
     974:	fec42783          	lw	a5,-20(s0)
     978:	0017871b          	addiw	a4,a5,1
     97c:	fee42623          	sw	a4,-20(s0)
     980:	00001697          	auipc	a3,0x1
     984:	8f868693          	addi	a3,a3,-1800 # 1278 <digits>
     988:	02061713          	slli	a4,a2,0x20
     98c:	9301                	srli	a4,a4,0x20
     98e:	9736                	add	a4,a4,a3
     990:	00074703          	lbu	a4,0(a4)
     994:	17c1                	addi	a5,a5,-16
     996:	97a2                	add	a5,a5,s0
     998:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     99c:	fc442783          	lw	a5,-60(s0)
     9a0:	fe442703          	lw	a4,-28(s0)
     9a4:	02f757bb          	divuw	a5,a4,a5
     9a8:	fef42223          	sw	a5,-28(s0)
     9ac:	fe442783          	lw	a5,-28(s0)
     9b0:	2781                	sext.w	a5,a5
     9b2:	fbcd                	bnez	a5,964 <printint+0x5a>
  if(neg)
     9b4:	fe842783          	lw	a5,-24(s0)
     9b8:	2781                	sext.w	a5,a5
     9ba:	cf85                	beqz	a5,9f2 <printint+0xe8>
    buf[i++] = '-';
     9bc:	fec42783          	lw	a5,-20(s0)
     9c0:	0017871b          	addiw	a4,a5,1
     9c4:	fee42623          	sw	a4,-20(s0)
     9c8:	17c1                	addi	a5,a5,-16
     9ca:	97a2                	add	a5,a5,s0
     9cc:	02d00713          	li	a4,45
     9d0:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     9d4:	a839                	j	9f2 <printint+0xe8>
    putc(fd, buf[i]);
     9d6:	fec42783          	lw	a5,-20(s0)
     9da:	17c1                	addi	a5,a5,-16
     9dc:	97a2                	add	a5,a5,s0
     9de:	fe07c703          	lbu	a4,-32(a5)
     9e2:	fcc42783          	lw	a5,-52(s0)
     9e6:	85ba                	mv	a1,a4
     9e8:	853e                	mv	a0,a5
     9ea:	00000097          	auipc	ra,0x0
     9ee:	eea080e7          	jalr	-278(ra) # 8d4 <putc>
  while(--i >= 0)
     9f2:	fec42783          	lw	a5,-20(s0)
     9f6:	37fd                	addiw	a5,a5,-1
     9f8:	fef42623          	sw	a5,-20(s0)
     9fc:	fec42783          	lw	a5,-20(s0)
     a00:	2781                	sext.w	a5,a5
     a02:	fc07dae3          	bgez	a5,9d6 <printint+0xcc>
}
     a06:	0001                	nop
     a08:	0001                	nop
     a0a:	70e2                	ld	ra,56(sp)
     a0c:	7442                	ld	s0,48(sp)
     a0e:	6121                	addi	sp,sp,64
     a10:	8082                	ret

0000000000000a12 <printptr>:

static void
printptr(int fd, uint64 x) {
     a12:	7179                	addi	sp,sp,-48
     a14:	f406                	sd	ra,40(sp)
     a16:	f022                	sd	s0,32(sp)
     a18:	1800                	addi	s0,sp,48
     a1a:	87aa                	mv	a5,a0
     a1c:	fcb43823          	sd	a1,-48(s0)
     a20:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     a24:	fdc42783          	lw	a5,-36(s0)
     a28:	03000593          	li	a1,48
     a2c:	853e                	mv	a0,a5
     a2e:	00000097          	auipc	ra,0x0
     a32:	ea6080e7          	jalr	-346(ra) # 8d4 <putc>
  putc(fd, 'x');
     a36:	fdc42783          	lw	a5,-36(s0)
     a3a:	07800593          	li	a1,120
     a3e:	853e                	mv	a0,a5
     a40:	00000097          	auipc	ra,0x0
     a44:	e94080e7          	jalr	-364(ra) # 8d4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a48:	fe042623          	sw	zero,-20(s0)
     a4c:	a82d                	j	a86 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     a4e:	fd043783          	ld	a5,-48(s0)
     a52:	93f1                	srli	a5,a5,0x3c
     a54:	00001717          	auipc	a4,0x1
     a58:	82470713          	addi	a4,a4,-2012 # 1278 <digits>
     a5c:	97ba                	add	a5,a5,a4
     a5e:	0007c703          	lbu	a4,0(a5)
     a62:	fdc42783          	lw	a5,-36(s0)
     a66:	85ba                	mv	a1,a4
     a68:	853e                	mv	a0,a5
     a6a:	00000097          	auipc	ra,0x0
     a6e:	e6a080e7          	jalr	-406(ra) # 8d4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a72:	fec42783          	lw	a5,-20(s0)
     a76:	2785                	addiw	a5,a5,1
     a78:	fef42623          	sw	a5,-20(s0)
     a7c:	fd043783          	ld	a5,-48(s0)
     a80:	0792                	slli	a5,a5,0x4
     a82:	fcf43823          	sd	a5,-48(s0)
     a86:	fec42783          	lw	a5,-20(s0)
     a8a:	873e                	mv	a4,a5
     a8c:	47bd                	li	a5,15
     a8e:	fce7f0e3          	bgeu	a5,a4,a4e <printptr+0x3c>
}
     a92:	0001                	nop
     a94:	0001                	nop
     a96:	70a2                	ld	ra,40(sp)
     a98:	7402                	ld	s0,32(sp)
     a9a:	6145                	addi	sp,sp,48
     a9c:	8082                	ret

0000000000000a9e <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     a9e:	715d                	addi	sp,sp,-80
     aa0:	e486                	sd	ra,72(sp)
     aa2:	e0a2                	sd	s0,64(sp)
     aa4:	0880                	addi	s0,sp,80
     aa6:	87aa                	mv	a5,a0
     aa8:	fcb43023          	sd	a1,-64(s0)
     aac:	fac43c23          	sd	a2,-72(s0)
     ab0:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     ab4:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     ab8:	fe042223          	sw	zero,-28(s0)
     abc:	a42d                	j	ce6 <vprintf+0x248>
    c = fmt[i] & 0xff;
     abe:	fe442783          	lw	a5,-28(s0)
     ac2:	fc043703          	ld	a4,-64(s0)
     ac6:	97ba                	add	a5,a5,a4
     ac8:	0007c783          	lbu	a5,0(a5)
     acc:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     ad0:	fe042783          	lw	a5,-32(s0)
     ad4:	2781                	sext.w	a5,a5
     ad6:	eb9d                	bnez	a5,b0c <vprintf+0x6e>
      if(c == '%'){
     ad8:	fdc42783          	lw	a5,-36(s0)
     adc:	0007871b          	sext.w	a4,a5
     ae0:	02500793          	li	a5,37
     ae4:	00f71763          	bne	a4,a5,af2 <vprintf+0x54>
        state = '%';
     ae8:	02500793          	li	a5,37
     aec:	fef42023          	sw	a5,-32(s0)
     af0:	a2f5                	j	cdc <vprintf+0x23e>
      } else {
        putc(fd, c);
     af2:	fdc42783          	lw	a5,-36(s0)
     af6:	0ff7f713          	zext.b	a4,a5
     afa:	fcc42783          	lw	a5,-52(s0)
     afe:	85ba                	mv	a1,a4
     b00:	853e                	mv	a0,a5
     b02:	00000097          	auipc	ra,0x0
     b06:	dd2080e7          	jalr	-558(ra) # 8d4 <putc>
     b0a:	aac9                	j	cdc <vprintf+0x23e>
      }
    } else if(state == '%'){
     b0c:	fe042783          	lw	a5,-32(s0)
     b10:	0007871b          	sext.w	a4,a5
     b14:	02500793          	li	a5,37
     b18:	1cf71263          	bne	a4,a5,cdc <vprintf+0x23e>
      if(c == 'd'){
     b1c:	fdc42783          	lw	a5,-36(s0)
     b20:	0007871b          	sext.w	a4,a5
     b24:	06400793          	li	a5,100
     b28:	02f71463          	bne	a4,a5,b50 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     b2c:	fb843783          	ld	a5,-72(s0)
     b30:	00878713          	addi	a4,a5,8
     b34:	fae43c23          	sd	a4,-72(s0)
     b38:	4398                	lw	a4,0(a5)
     b3a:	fcc42783          	lw	a5,-52(s0)
     b3e:	4685                	li	a3,1
     b40:	4629                	li	a2,10
     b42:	85ba                	mv	a1,a4
     b44:	853e                	mv	a0,a5
     b46:	00000097          	auipc	ra,0x0
     b4a:	dc4080e7          	jalr	-572(ra) # 90a <printint>
     b4e:	a269                	j	cd8 <vprintf+0x23a>
      } else if(c == 'l') {
     b50:	fdc42783          	lw	a5,-36(s0)
     b54:	0007871b          	sext.w	a4,a5
     b58:	06c00793          	li	a5,108
     b5c:	02f71663          	bne	a4,a5,b88 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     b60:	fb843783          	ld	a5,-72(s0)
     b64:	00878713          	addi	a4,a5,8
     b68:	fae43c23          	sd	a4,-72(s0)
     b6c:	639c                	ld	a5,0(a5)
     b6e:	0007871b          	sext.w	a4,a5
     b72:	fcc42783          	lw	a5,-52(s0)
     b76:	4681                	li	a3,0
     b78:	4629                	li	a2,10
     b7a:	85ba                	mv	a1,a4
     b7c:	853e                	mv	a0,a5
     b7e:	00000097          	auipc	ra,0x0
     b82:	d8c080e7          	jalr	-628(ra) # 90a <printint>
     b86:	aa89                	j	cd8 <vprintf+0x23a>
      } else if(c == 'x') {
     b88:	fdc42783          	lw	a5,-36(s0)
     b8c:	0007871b          	sext.w	a4,a5
     b90:	07800793          	li	a5,120
     b94:	02f71463          	bne	a4,a5,bbc <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     b98:	fb843783          	ld	a5,-72(s0)
     b9c:	00878713          	addi	a4,a5,8
     ba0:	fae43c23          	sd	a4,-72(s0)
     ba4:	4398                	lw	a4,0(a5)
     ba6:	fcc42783          	lw	a5,-52(s0)
     baa:	4681                	li	a3,0
     bac:	4641                	li	a2,16
     bae:	85ba                	mv	a1,a4
     bb0:	853e                	mv	a0,a5
     bb2:	00000097          	auipc	ra,0x0
     bb6:	d58080e7          	jalr	-680(ra) # 90a <printint>
     bba:	aa39                	j	cd8 <vprintf+0x23a>
      } else if(c == 'p') {
     bbc:	fdc42783          	lw	a5,-36(s0)
     bc0:	0007871b          	sext.w	a4,a5
     bc4:	07000793          	li	a5,112
     bc8:	02f71263          	bne	a4,a5,bec <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     bcc:	fb843783          	ld	a5,-72(s0)
     bd0:	00878713          	addi	a4,a5,8
     bd4:	fae43c23          	sd	a4,-72(s0)
     bd8:	6398                	ld	a4,0(a5)
     bda:	fcc42783          	lw	a5,-52(s0)
     bde:	85ba                	mv	a1,a4
     be0:	853e                	mv	a0,a5
     be2:	00000097          	auipc	ra,0x0
     be6:	e30080e7          	jalr	-464(ra) # a12 <printptr>
     bea:	a0fd                	j	cd8 <vprintf+0x23a>
      } else if(c == 's'){
     bec:	fdc42783          	lw	a5,-36(s0)
     bf0:	0007871b          	sext.w	a4,a5
     bf4:	07300793          	li	a5,115
     bf8:	04f71c63          	bne	a4,a5,c50 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     bfc:	fb843783          	ld	a5,-72(s0)
     c00:	00878713          	addi	a4,a5,8
     c04:	fae43c23          	sd	a4,-72(s0)
     c08:	639c                	ld	a5,0(a5)
     c0a:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     c0e:	fe843783          	ld	a5,-24(s0)
     c12:	eb8d                	bnez	a5,c44 <vprintf+0x1a6>
          s = "(null)";
     c14:	00000797          	auipc	a5,0x0
     c18:	60c78793          	addi	a5,a5,1548 # 1220 <lock_init+0x8c>
     c1c:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     c20:	a015                	j	c44 <vprintf+0x1a6>
          putc(fd, *s);
     c22:	fe843783          	ld	a5,-24(s0)
     c26:	0007c703          	lbu	a4,0(a5)
     c2a:	fcc42783          	lw	a5,-52(s0)
     c2e:	85ba                	mv	a1,a4
     c30:	853e                	mv	a0,a5
     c32:	00000097          	auipc	ra,0x0
     c36:	ca2080e7          	jalr	-862(ra) # 8d4 <putc>
          s++;
     c3a:	fe843783          	ld	a5,-24(s0)
     c3e:	0785                	addi	a5,a5,1
     c40:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     c44:	fe843783          	ld	a5,-24(s0)
     c48:	0007c783          	lbu	a5,0(a5)
     c4c:	fbf9                	bnez	a5,c22 <vprintf+0x184>
     c4e:	a069                	j	cd8 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     c50:	fdc42783          	lw	a5,-36(s0)
     c54:	0007871b          	sext.w	a4,a5
     c58:	06300793          	li	a5,99
     c5c:	02f71463          	bne	a4,a5,c84 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     c60:	fb843783          	ld	a5,-72(s0)
     c64:	00878713          	addi	a4,a5,8
     c68:	fae43c23          	sd	a4,-72(s0)
     c6c:	439c                	lw	a5,0(a5)
     c6e:	0ff7f713          	zext.b	a4,a5
     c72:	fcc42783          	lw	a5,-52(s0)
     c76:	85ba                	mv	a1,a4
     c78:	853e                	mv	a0,a5
     c7a:	00000097          	auipc	ra,0x0
     c7e:	c5a080e7          	jalr	-934(ra) # 8d4 <putc>
     c82:	a899                	j	cd8 <vprintf+0x23a>
      } else if(c == '%'){
     c84:	fdc42783          	lw	a5,-36(s0)
     c88:	0007871b          	sext.w	a4,a5
     c8c:	02500793          	li	a5,37
     c90:	00f71f63          	bne	a4,a5,cae <vprintf+0x210>
        putc(fd, c);
     c94:	fdc42783          	lw	a5,-36(s0)
     c98:	0ff7f713          	zext.b	a4,a5
     c9c:	fcc42783          	lw	a5,-52(s0)
     ca0:	85ba                	mv	a1,a4
     ca2:	853e                	mv	a0,a5
     ca4:	00000097          	auipc	ra,0x0
     ca8:	c30080e7          	jalr	-976(ra) # 8d4 <putc>
     cac:	a035                	j	cd8 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     cae:	fcc42783          	lw	a5,-52(s0)
     cb2:	02500593          	li	a1,37
     cb6:	853e                	mv	a0,a5
     cb8:	00000097          	auipc	ra,0x0
     cbc:	c1c080e7          	jalr	-996(ra) # 8d4 <putc>
        putc(fd, c);
     cc0:	fdc42783          	lw	a5,-36(s0)
     cc4:	0ff7f713          	zext.b	a4,a5
     cc8:	fcc42783          	lw	a5,-52(s0)
     ccc:	85ba                	mv	a1,a4
     cce:	853e                	mv	a0,a5
     cd0:	00000097          	auipc	ra,0x0
     cd4:	c04080e7          	jalr	-1020(ra) # 8d4 <putc>
      }
      state = 0;
     cd8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     cdc:	fe442783          	lw	a5,-28(s0)
     ce0:	2785                	addiw	a5,a5,1
     ce2:	fef42223          	sw	a5,-28(s0)
     ce6:	fe442783          	lw	a5,-28(s0)
     cea:	fc043703          	ld	a4,-64(s0)
     cee:	97ba                	add	a5,a5,a4
     cf0:	0007c783          	lbu	a5,0(a5)
     cf4:	dc0795e3          	bnez	a5,abe <vprintf+0x20>
    }
  }
}
     cf8:	0001                	nop
     cfa:	0001                	nop
     cfc:	60a6                	ld	ra,72(sp)
     cfe:	6406                	ld	s0,64(sp)
     d00:	6161                	addi	sp,sp,80
     d02:	8082                	ret

0000000000000d04 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d04:	7159                	addi	sp,sp,-112
     d06:	fc06                	sd	ra,56(sp)
     d08:	f822                	sd	s0,48(sp)
     d0a:	0080                	addi	s0,sp,64
     d0c:	fcb43823          	sd	a1,-48(s0)
     d10:	e010                	sd	a2,0(s0)
     d12:	e414                	sd	a3,8(s0)
     d14:	e818                	sd	a4,16(s0)
     d16:	ec1c                	sd	a5,24(s0)
     d18:	03043023          	sd	a6,32(s0)
     d1c:	03143423          	sd	a7,40(s0)
     d20:	87aa                	mv	a5,a0
     d22:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d26:	03040793          	addi	a5,s0,48
     d2a:	fcf43423          	sd	a5,-56(s0)
     d2e:	fc843783          	ld	a5,-56(s0)
     d32:	fd078793          	addi	a5,a5,-48
     d36:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     d3a:	fe843703          	ld	a4,-24(s0)
     d3e:	fdc42783          	lw	a5,-36(s0)
     d42:	863a                	mv	a2,a4
     d44:	fd043583          	ld	a1,-48(s0)
     d48:	853e                	mv	a0,a5
     d4a:	00000097          	auipc	ra,0x0
     d4e:	d54080e7          	jalr	-684(ra) # a9e <vprintf>
}
     d52:	0001                	nop
     d54:	70e2                	ld	ra,56(sp)
     d56:	7442                	ld	s0,48(sp)
     d58:	6165                	addi	sp,sp,112
     d5a:	8082                	ret

0000000000000d5c <printf>:

void
printf(const char *fmt, ...)
{
     d5c:	7159                	addi	sp,sp,-112
     d5e:	f406                	sd	ra,40(sp)
     d60:	f022                	sd	s0,32(sp)
     d62:	1800                	addi	s0,sp,48
     d64:	fca43c23          	sd	a0,-40(s0)
     d68:	e40c                	sd	a1,8(s0)
     d6a:	e810                	sd	a2,16(s0)
     d6c:	ec14                	sd	a3,24(s0)
     d6e:	f018                	sd	a4,32(s0)
     d70:	f41c                	sd	a5,40(s0)
     d72:	03043823          	sd	a6,48(s0)
     d76:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     d7a:	04040793          	addi	a5,s0,64
     d7e:	fcf43823          	sd	a5,-48(s0)
     d82:	fd043783          	ld	a5,-48(s0)
     d86:	fc878793          	addi	a5,a5,-56
     d8a:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     d8e:	fe843783          	ld	a5,-24(s0)
     d92:	863e                	mv	a2,a5
     d94:	fd843583          	ld	a1,-40(s0)
     d98:	4505                	li	a0,1
     d9a:	00000097          	auipc	ra,0x0
     d9e:	d04080e7          	jalr	-764(ra) # a9e <vprintf>
}
     da2:	0001                	nop
     da4:	70a2                	ld	ra,40(sp)
     da6:	7402                	ld	s0,32(sp)
     da8:	6165                	addi	sp,sp,112
     daa:	8082                	ret

0000000000000dac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     dac:	7179                	addi	sp,sp,-48
     dae:	f422                	sd	s0,40(sp)
     db0:	1800                	addi	s0,sp,48
     db2:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     db6:	fd843783          	ld	a5,-40(s0)
     dba:	17c1                	addi	a5,a5,-16
     dbc:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     dc0:	00000797          	auipc	a5,0x0
     dc4:	4f078793          	addi	a5,a5,1264 # 12b0 <freep>
     dc8:	639c                	ld	a5,0(a5)
     dca:	fef43423          	sd	a5,-24(s0)
     dce:	a815                	j	e02 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     dd0:	fe843783          	ld	a5,-24(s0)
     dd4:	639c                	ld	a5,0(a5)
     dd6:	fe843703          	ld	a4,-24(s0)
     dda:	00f76f63          	bltu	a4,a5,df8 <free+0x4c>
     dde:	fe043703          	ld	a4,-32(s0)
     de2:	fe843783          	ld	a5,-24(s0)
     de6:	02e7eb63          	bltu	a5,a4,e1c <free+0x70>
     dea:	fe843783          	ld	a5,-24(s0)
     dee:	639c                	ld	a5,0(a5)
     df0:	fe043703          	ld	a4,-32(s0)
     df4:	02f76463          	bltu	a4,a5,e1c <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     df8:	fe843783          	ld	a5,-24(s0)
     dfc:	639c                	ld	a5,0(a5)
     dfe:	fef43423          	sd	a5,-24(s0)
     e02:	fe043703          	ld	a4,-32(s0)
     e06:	fe843783          	ld	a5,-24(s0)
     e0a:	fce7f3e3          	bgeu	a5,a4,dd0 <free+0x24>
     e0e:	fe843783          	ld	a5,-24(s0)
     e12:	639c                	ld	a5,0(a5)
     e14:	fe043703          	ld	a4,-32(s0)
     e18:	faf77ce3          	bgeu	a4,a5,dd0 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     e1c:	fe043783          	ld	a5,-32(s0)
     e20:	479c                	lw	a5,8(a5)
     e22:	1782                	slli	a5,a5,0x20
     e24:	9381                	srli	a5,a5,0x20
     e26:	0792                	slli	a5,a5,0x4
     e28:	fe043703          	ld	a4,-32(s0)
     e2c:	973e                	add	a4,a4,a5
     e2e:	fe843783          	ld	a5,-24(s0)
     e32:	639c                	ld	a5,0(a5)
     e34:	02f71763          	bne	a4,a5,e62 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     e38:	fe043783          	ld	a5,-32(s0)
     e3c:	4798                	lw	a4,8(a5)
     e3e:	fe843783          	ld	a5,-24(s0)
     e42:	639c                	ld	a5,0(a5)
     e44:	479c                	lw	a5,8(a5)
     e46:	9fb9                	addw	a5,a5,a4
     e48:	0007871b          	sext.w	a4,a5
     e4c:	fe043783          	ld	a5,-32(s0)
     e50:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     e52:	fe843783          	ld	a5,-24(s0)
     e56:	639c                	ld	a5,0(a5)
     e58:	6398                	ld	a4,0(a5)
     e5a:	fe043783          	ld	a5,-32(s0)
     e5e:	e398                	sd	a4,0(a5)
     e60:	a039                	j	e6e <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     e62:	fe843783          	ld	a5,-24(s0)
     e66:	6398                	ld	a4,0(a5)
     e68:	fe043783          	ld	a5,-32(s0)
     e6c:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     e6e:	fe843783          	ld	a5,-24(s0)
     e72:	479c                	lw	a5,8(a5)
     e74:	1782                	slli	a5,a5,0x20
     e76:	9381                	srli	a5,a5,0x20
     e78:	0792                	slli	a5,a5,0x4
     e7a:	fe843703          	ld	a4,-24(s0)
     e7e:	97ba                	add	a5,a5,a4
     e80:	fe043703          	ld	a4,-32(s0)
     e84:	02f71563          	bne	a4,a5,eae <free+0x102>
    p->s.size += bp->s.size;
     e88:	fe843783          	ld	a5,-24(s0)
     e8c:	4798                	lw	a4,8(a5)
     e8e:	fe043783          	ld	a5,-32(s0)
     e92:	479c                	lw	a5,8(a5)
     e94:	9fb9                	addw	a5,a5,a4
     e96:	0007871b          	sext.w	a4,a5
     e9a:	fe843783          	ld	a5,-24(s0)
     e9e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     ea0:	fe043783          	ld	a5,-32(s0)
     ea4:	6398                	ld	a4,0(a5)
     ea6:	fe843783          	ld	a5,-24(s0)
     eaa:	e398                	sd	a4,0(a5)
     eac:	a031                	j	eb8 <free+0x10c>
  } else
    p->s.ptr = bp;
     eae:	fe843783          	ld	a5,-24(s0)
     eb2:	fe043703          	ld	a4,-32(s0)
     eb6:	e398                	sd	a4,0(a5)
  freep = p;
     eb8:	00000797          	auipc	a5,0x0
     ebc:	3f878793          	addi	a5,a5,1016 # 12b0 <freep>
     ec0:	fe843703          	ld	a4,-24(s0)
     ec4:	e398                	sd	a4,0(a5)
}
     ec6:	0001                	nop
     ec8:	7422                	ld	s0,40(sp)
     eca:	6145                	addi	sp,sp,48
     ecc:	8082                	ret

0000000000000ece <morecore>:

static Header*
morecore(uint nu)
{
     ece:	7179                	addi	sp,sp,-48
     ed0:	f406                	sd	ra,40(sp)
     ed2:	f022                	sd	s0,32(sp)
     ed4:	1800                	addi	s0,sp,48
     ed6:	87aa                	mv	a5,a0
     ed8:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     edc:	fdc42783          	lw	a5,-36(s0)
     ee0:	0007871b          	sext.w	a4,a5
     ee4:	6785                	lui	a5,0x1
     ee6:	00f77563          	bgeu	a4,a5,ef0 <morecore+0x22>
    nu = 4096;
     eea:	6785                	lui	a5,0x1
     eec:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     ef0:	fdc42783          	lw	a5,-36(s0)
     ef4:	0047979b          	slliw	a5,a5,0x4
     ef8:	2781                	sext.w	a5,a5
     efa:	2781                	sext.w	a5,a5
     efc:	853e                	mv	a0,a5
     efe:	00000097          	auipc	ra,0x0
     f02:	9ae080e7          	jalr	-1618(ra) # 8ac <sbrk>
     f06:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     f0a:	fe843703          	ld	a4,-24(s0)
     f0e:	57fd                	li	a5,-1
     f10:	00f71463          	bne	a4,a5,f18 <morecore+0x4a>
    return 0;
     f14:	4781                	li	a5,0
     f16:	a03d                	j	f44 <morecore+0x76>
  hp = (Header*)p;
     f18:	fe843783          	ld	a5,-24(s0)
     f1c:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     f20:	fe043783          	ld	a5,-32(s0)
     f24:	fdc42703          	lw	a4,-36(s0)
     f28:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f2a:	fe043783          	ld	a5,-32(s0)
     f2e:	07c1                	addi	a5,a5,16
     f30:	853e                	mv	a0,a5
     f32:	00000097          	auipc	ra,0x0
     f36:	e7a080e7          	jalr	-390(ra) # dac <free>
  return freep;
     f3a:	00000797          	auipc	a5,0x0
     f3e:	37678793          	addi	a5,a5,886 # 12b0 <freep>
     f42:	639c                	ld	a5,0(a5)
}
     f44:	853e                	mv	a0,a5
     f46:	70a2                	ld	ra,40(sp)
     f48:	7402                	ld	s0,32(sp)
     f4a:	6145                	addi	sp,sp,48
     f4c:	8082                	ret

0000000000000f4e <malloc>:

void*
malloc(uint nbytes)
{
     f4e:	7139                	addi	sp,sp,-64
     f50:	fc06                	sd	ra,56(sp)
     f52:	f822                	sd	s0,48(sp)
     f54:	0080                	addi	s0,sp,64
     f56:	87aa                	mv	a5,a0
     f58:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f5c:	fcc46783          	lwu	a5,-52(s0)
     f60:	07bd                	addi	a5,a5,15
     f62:	8391                	srli	a5,a5,0x4
     f64:	2781                	sext.w	a5,a5
     f66:	2785                	addiw	a5,a5,1
     f68:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     f6c:	00000797          	auipc	a5,0x0
     f70:	34478793          	addi	a5,a5,836 # 12b0 <freep>
     f74:	639c                	ld	a5,0(a5)
     f76:	fef43023          	sd	a5,-32(s0)
     f7a:	fe043783          	ld	a5,-32(s0)
     f7e:	ef95                	bnez	a5,fba <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     f80:	00000797          	auipc	a5,0x0
     f84:	32078793          	addi	a5,a5,800 # 12a0 <base>
     f88:	fef43023          	sd	a5,-32(s0)
     f8c:	00000797          	auipc	a5,0x0
     f90:	32478793          	addi	a5,a5,804 # 12b0 <freep>
     f94:	fe043703          	ld	a4,-32(s0)
     f98:	e398                	sd	a4,0(a5)
     f9a:	00000797          	auipc	a5,0x0
     f9e:	31678793          	addi	a5,a5,790 # 12b0 <freep>
     fa2:	6398                	ld	a4,0(a5)
     fa4:	00000797          	auipc	a5,0x0
     fa8:	2fc78793          	addi	a5,a5,764 # 12a0 <base>
     fac:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     fae:	00000797          	auipc	a5,0x0
     fb2:	2f278793          	addi	a5,a5,754 # 12a0 <base>
     fb6:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fba:	fe043783          	ld	a5,-32(s0)
     fbe:	639c                	ld	a5,0(a5)
     fc0:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     fc4:	fe843783          	ld	a5,-24(s0)
     fc8:	4798                	lw	a4,8(a5)
     fca:	fdc42783          	lw	a5,-36(s0)
     fce:	2781                	sext.w	a5,a5
     fd0:	06f76763          	bltu	a4,a5,103e <malloc+0xf0>
      if(p->s.size == nunits)
     fd4:	fe843783          	ld	a5,-24(s0)
     fd8:	4798                	lw	a4,8(a5)
     fda:	fdc42783          	lw	a5,-36(s0)
     fde:	2781                	sext.w	a5,a5
     fe0:	00e79963          	bne	a5,a4,ff2 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     fe4:	fe843783          	ld	a5,-24(s0)
     fe8:	6398                	ld	a4,0(a5)
     fea:	fe043783          	ld	a5,-32(s0)
     fee:	e398                	sd	a4,0(a5)
     ff0:	a825                	j	1028 <malloc+0xda>
      else {
        p->s.size -= nunits;
     ff2:	fe843783          	ld	a5,-24(s0)
     ff6:	479c                	lw	a5,8(a5)
     ff8:	fdc42703          	lw	a4,-36(s0)
     ffc:	9f99                	subw	a5,a5,a4
     ffe:	0007871b          	sext.w	a4,a5
    1002:	fe843783          	ld	a5,-24(s0)
    1006:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1008:	fe843783          	ld	a5,-24(s0)
    100c:	479c                	lw	a5,8(a5)
    100e:	1782                	slli	a5,a5,0x20
    1010:	9381                	srli	a5,a5,0x20
    1012:	0792                	slli	a5,a5,0x4
    1014:	fe843703          	ld	a4,-24(s0)
    1018:	97ba                	add	a5,a5,a4
    101a:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    101e:	fe843783          	ld	a5,-24(s0)
    1022:	fdc42703          	lw	a4,-36(s0)
    1026:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1028:	00000797          	auipc	a5,0x0
    102c:	28878793          	addi	a5,a5,648 # 12b0 <freep>
    1030:	fe043703          	ld	a4,-32(s0)
    1034:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1036:	fe843783          	ld	a5,-24(s0)
    103a:	07c1                	addi	a5,a5,16
    103c:	a091                	j	1080 <malloc+0x132>
    }
    if(p == freep)
    103e:	00000797          	auipc	a5,0x0
    1042:	27278793          	addi	a5,a5,626 # 12b0 <freep>
    1046:	639c                	ld	a5,0(a5)
    1048:	fe843703          	ld	a4,-24(s0)
    104c:	02f71063          	bne	a4,a5,106c <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    1050:	fdc42783          	lw	a5,-36(s0)
    1054:	853e                	mv	a0,a5
    1056:	00000097          	auipc	ra,0x0
    105a:	e78080e7          	jalr	-392(ra) # ece <morecore>
    105e:	fea43423          	sd	a0,-24(s0)
    1062:	fe843783          	ld	a5,-24(s0)
    1066:	e399                	bnez	a5,106c <malloc+0x11e>
        return 0;
    1068:	4781                	li	a5,0
    106a:	a819                	j	1080 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    106c:	fe843783          	ld	a5,-24(s0)
    1070:	fef43023          	sd	a5,-32(s0)
    1074:	fe843783          	ld	a5,-24(s0)
    1078:	639c                	ld	a5,0(a5)
    107a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    107e:	b799                	j	fc4 <malloc+0x76>
  }
}
    1080:	853e                	mv	a0,a5
    1082:	70e2                	ld	ra,56(sp)
    1084:	7442                	ld	s0,48(sp)
    1086:	6121                	addi	sp,sp,64
    1088:	8082                	ret

000000000000108a <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
    108a:	7179                	addi	sp,sp,-48
    108c:	f406                	sd	ra,40(sp)
    108e:	f022                	sd	s0,32(sp)
    1090:	1800                	addi	s0,sp,48
    1092:	fca43c23          	sd	a0,-40(s0)
    1096:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
    109a:	6505                	lui	a0,0x1
    109c:	00000097          	auipc	ra,0x0
    10a0:	eb2080e7          	jalr	-334(ra) # f4e <malloc>
    10a4:	fea43423          	sd	a0,-24(s0)
    10a8:	fe843783          	ld	a5,-24(s0)
    10ac:	e38d                	bnez	a5,10ce <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
    10ae:	00000517          	auipc	a0,0x0
    10b2:	17a50513          	addi	a0,a0,378 # 1228 <lock_init+0x94>
    10b6:	00000097          	auipc	ra,0x0
    10ba:	ca6080e7          	jalr	-858(ra) # d5c <printf>
        free(stack);
    10be:	fe843503          	ld	a0,-24(s0)
    10c2:	00000097          	auipc	ra,0x0
    10c6:	cea080e7          	jalr	-790(ra) # dac <free>
        return -1;
    10ca:	57fd                	li	a5,-1
    10cc:	a099                	j	1112 <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
    10ce:	fe843783          	ld	a5,-24(s0)
    10d2:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
    10d6:	fe043703          	ld	a4,-32(s0)
    10da:	6785                	lui	a5,0x1
    10dc:	17fd                	addi	a5,a5,-1
    10de:	8ff9                	and	a5,a5,a4
    10e0:	cf91                	beqz	a5,10fc <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
    10e2:	fe043703          	ld	a4,-32(s0)
    10e6:	6785                	lui	a5,0x1
    10e8:	17fd                	addi	a5,a5,-1
    10ea:	8ff9                	and	a5,a5,a4
    10ec:	6705                	lui	a4,0x1
    10ee:	40f707b3          	sub	a5,a4,a5
    10f2:	fe843703          	ld	a4,-24(s0)
    10f6:	97ba                	add	a5,a5,a4
    10f8:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
    10fc:	fe843603          	ld	a2,-24(s0)
    1100:	fd043583          	ld	a1,-48(s0)
    1104:	fd843503          	ld	a0,-40(s0)
    1108:	fffff097          	auipc	ra,0xfffff
    110c:	7bc080e7          	jalr	1980(ra) # 8c4 <clone>
    1110:	87aa                	mv	a5,a0
}
    1112:	853e                	mv	a0,a5
    1114:	70a2                	ld	ra,40(sp)
    1116:	7402                	ld	s0,32(sp)
    1118:	6145                	addi	sp,sp,48
    111a:	8082                	ret

000000000000111c <thread_join>:


int thread_join()
{
    111c:	1101                	addi	sp,sp,-32
    111e:	ec06                	sd	ra,24(sp)
    1120:	e822                	sd	s0,16(sp)
    1122:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
    1124:	fe040793          	addi	a5,s0,-32
    1128:	853e                	mv	a0,a5
    112a:	fffff097          	auipc	ra,0xfffff
    112e:	7a2080e7          	jalr	1954(ra) # 8cc <join>
    1132:	87aa                	mv	a5,a0
    1134:	fef42623          	sw	a5,-20(s0)
    1138:	fec42783          	lw	a5,-20(s0)
    113c:	0007871b          	sext.w	a4,a5
    1140:	57fd                	li	a5,-1
    1142:	00f70963          	beq	a4,a5,1154 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
    1146:	fe043783          	ld	a5,-32(s0)
    114a:	853e                	mv	a0,a5
    114c:	00000097          	auipc	ra,0x0
    1150:	c60080e7          	jalr	-928(ra) # dac <free>
    } 

    return child_tid;
    1154:	fec42783          	lw	a5,-20(s0)
}
    1158:	853e                	mv	a0,a5
    115a:	60e2                	ld	ra,24(sp)
    115c:	6442                	ld	s0,16(sp)
    115e:	6105                	addi	sp,sp,32
    1160:	8082                	ret

0000000000001162 <lock_acquire>:


void lock_acquire (lock_t *lock)
{
    1162:	1101                	addi	sp,sp,-32
    1164:	ec22                	sd	s0,24(sp)
    1166:	1000                	addi	s0,sp,32
    1168:	fea43423          	sd	a0,-24(s0)
        lock = 0;
    116c:	fe043423          	sd	zero,-24(s0)

}
    1170:	0001                	nop
    1172:	6462                	ld	s0,24(sp)
    1174:	6105                	addi	sp,sp,32
    1176:	8082                	ret

0000000000001178 <lock_release>:

void lock_release (lock_t *lock)
{
    1178:	1101                	addi	sp,sp,-32
    117a:	ec22                	sd	s0,24(sp)
    117c:	1000                	addi	s0,sp,32
    117e:	fea43423          	sd	a0,-24(s0)
        __sync_lock_test_and_set(lock, 1);
    1182:	fe843783          	ld	a5,-24(s0)
    1186:	4705                	li	a4,1
    1188:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    
}
    118c:	0001                	nop
    118e:	6462                	ld	s0,24(sp)
    1190:	6105                	addi	sp,sp,32
    1192:	8082                	ret

0000000000001194 <lock_init>:

void lock_init (lock_t *lock)
{
    1194:	1101                	addi	sp,sp,-32
    1196:	ec22                	sd	s0,24(sp)
    1198:	1000                	addi	s0,sp,32
    119a:	fea43423          	sd	a0,-24(s0)
    lock = 0;
    119e:	fe043423          	sd	zero,-24(s0)
    
}
    11a2:	0001                	nop
    11a4:	6462                	ld	s0,24(sp)
    11a6:	6105                	addi	sp,sp,32
    11a8:	8082                	ret
