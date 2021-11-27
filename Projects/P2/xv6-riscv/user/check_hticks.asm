
user/_check_hticks:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <spin>:
#define check(exp, msg) if(exp) {} else {\
   printf("%s:%d check (" #exp ") failed: %s\n", __FILE__, __LINE__, msg);\
   exit(-1);}

int spin()
{
       0:	1101                	addi	sp,sp,-32
       2:	ec22                	sd	s0,24(sp)
       4:	1000                	addi	s0,sp,32
	int i = 0, j = 0, k = 0;
       6:	fe042623          	sw	zero,-20(s0)
       a:	fe042423          	sw	zero,-24(s0)
       e:	fe042223          	sw	zero,-28(s0)
	for(i = 0; i < 50; ++i)
      12:	fe042623          	sw	zero,-20(s0)
      16:	a83d                	j	54 <spin+0x54>
	{
		for(j = 0; j < 10000000; ++j)
      18:	fe042423          	sw	zero,-24(s0)
      1c:	a829                	j	36 <spin+0x36>
		{
			k = j % 10;
      1e:	fe842703          	lw	a4,-24(s0)
      22:	47a9                	li	a5,10
      24:	02f767bb          	remw	a5,a4,a5
      28:	fef42223          	sw	a5,-28(s0)
		for(j = 0; j < 10000000; ++j)
      2c:	fe842783          	lw	a5,-24(s0)
      30:	2785                	addiw	a5,a5,1
      32:	fef42423          	sw	a5,-24(s0)
      36:	fe842783          	lw	a5,-24(s0)
      3a:	0007871b          	sext.w	a4,a5
      3e:	009897b7          	lui	a5,0x989
      42:	67f78793          	addi	a5,a5,1663 # 98967f <__global_pointer$+0x987baf>
      46:	fce7dce3          	bge	a5,a4,1e <spin+0x1e>
	for(i = 0; i < 50; ++i)
      4a:	fec42783          	lw	a5,-20(s0)
      4e:	2785                	addiw	a5,a5,1
      50:	fef42623          	sw	a5,-20(s0)
      54:	fec42783          	lw	a5,-20(s0)
      58:	0007871b          	sext.w	a4,a5
      5c:	03100793          	li	a5,49
      60:	fae7dce3          	bge	a5,a4,18 <spin+0x18>
		}
	}
	i=k;
      64:	fe442783          	lw	a5,-28(s0)
      68:	fef42623          	sw	a5,-20(s0)
   return k;
      6c:	fe442783          	lw	a5,-28(s0)
}
      70:	853e                	mv	a0,a5
      72:	6462                	ld	s0,24(sp)
      74:	6105                	addi	sp,sp,32
      76:	8082                	ret

0000000000000078 <print>:

void print(struct pstat *st)
{
      78:	7179                	addi	sp,sp,-48
      7a:	f406                	sd	ra,40(sp)
      7c:	f022                	sd	s0,32(sp)
      7e:	1800                	addi	s0,sp,48
      80:	fca43c23          	sd	a0,-40(s0)
   int i;
   for(i = 0; i < NPROC; i++) {
      84:	fe042623          	sw	zero,-20(s0)
      88:	a095                	j	ec <print+0x74>
      if (st->inuse[i]) {
      8a:	fd843703          	ld	a4,-40(s0)
      8e:	fec42783          	lw	a5,-20(s0)
      92:	078e                	slli	a5,a5,0x3
      94:	97ba                	add	a5,a5,a4
      96:	639c                	ld	a5,0(a5)
      98:	c7a9                	beqz	a5,e2 <print+0x6a>
         printf("pid: %d hticks: %d lticks: %d\n", st->pid[i], st->hticks[i], st->lticks[i]);
      9a:	fd843703          	ld	a4,-40(s0)
      9e:	fec42783          	lw	a5,-20(s0)
      a2:	04078793          	addi	a5,a5,64
      a6:	078e                	slli	a5,a5,0x3
      a8:	97ba                	add	a5,a5,a4
      aa:	638c                	ld	a1,0(a5)
      ac:	fd843703          	ld	a4,-40(s0)
      b0:	fec42783          	lw	a5,-20(s0)
      b4:	08078793          	addi	a5,a5,128
      b8:	078e                	slli	a5,a5,0x3
      ba:	97ba                	add	a5,a5,a4
      bc:	6390                	ld	a2,0(a5)
      be:	fd843703          	ld	a4,-40(s0)
      c2:	fec42783          	lw	a5,-20(s0)
      c6:	0c078793          	addi	a5,a5,192
      ca:	078e                	slli	a5,a5,0x3
      cc:	97ba                	add	a5,a5,a4
      ce:	639c                	ld	a5,0(a5)
      d0:	86be                	mv	a3,a5
      d2:	00001517          	auipc	a0,0x1
      d6:	fbe50513          	addi	a0,a0,-66 # 1090 <malloc+0x13e>
      da:	00001097          	auipc	ra,0x1
      de:	c86080e7          	jalr	-890(ra) # d60 <printf>
   for(i = 0; i < NPROC; i++) {
      e2:	fec42783          	lw	a5,-20(s0)
      e6:	2785                	addiw	a5,a5,1
      e8:	fef42623          	sw	a5,-20(s0)
      ec:	fec42783          	lw	a5,-20(s0)
      f0:	0007871b          	sext.w	a4,a5
      f4:	03f00793          	li	a5,63
      f8:	f8e7d9e3          	bge	a5,a4,8a <print+0x12>
      }
   }

}
      fc:	0001                	nop
      fe:	0001                	nop
     100:	70a2                	ld	ra,40(sp)
     102:	7402                	ld	s0,32(sp)
     104:	6145                	addi	sp,sp,48
     106:	8082                	ret

0000000000000108 <main>:

int
main(int argc, char *argv[])
{
     108:	715d                	addi	sp,sp,-80
     10a:	e486                	sd	ra,72(sp)
     10c:	e0a2                	sd	s0,64(sp)
     10e:	0880                	addi	s0,sp,80
     110:	87aa                	mv	a5,a0
     112:	fab43823          	sd	a1,-80(s0)
     116:	faf42e23          	sw	a5,-68(s0)
   struct pstat *st_before; 
   struct pstat *st_after;
   st_before = malloc (sizeof(struct pstat));
     11a:	6785                	lui	a5,0x1
     11c:	80078513          	addi	a0,a5,-2048 # 800 <memcpy+0x1e>
     120:	00001097          	auipc	ra,0x1
     124:	e32080e7          	jalr	-462(ra) # f52 <malloc>
     128:	fca43c23          	sd	a0,-40(s0)
   st_after = malloc (sizeof(struct pstat));
     12c:	6785                	lui	a5,0x1
     12e:	80078513          	addi	a0,a5,-2048 # 800 <memcpy+0x1e>
     132:	00001097          	auipc	ra,0x1
     136:	e20080e7          	jalr	-480(ra) # f52 <malloc>
     13a:	fca43823          	sd	a0,-48(s0)
   int highpriority = 0;
     13e:	fe042623          	sw	zero,-20(s0)
   int processwithlowticks = 0;
     142:	fe042423          	sw	zero,-24(s0)
   int i;
   int *aux = malloc(1*sizeof(int));
     146:	4511                	li	a0,4
     148:	00001097          	auipc	ra,0x1
     14c:	e0a080e7          	jalr	-502(ra) # f52 <malloc>
     150:	fca43423          	sd	a0,-56(s0)
   check(setpri(2) == 0, "setpri");
     154:	4509                	li	a0,2
     156:	00000097          	auipc	ra,0x0
     15a:	774080e7          	jalr	1908(ra) # 8ca <setpri>
     15e:	87aa                	mv	a5,a0
     160:	cb85                	beqz	a5,190 <main+0x88>
     162:	00001697          	auipc	a3,0x1
     166:	f4e68693          	addi	a3,a3,-178 # 10b0 <malloc+0x15e>
     16a:	02d00613          	li	a2,45
     16e:	00001597          	auipc	a1,0x1
     172:	f4a58593          	addi	a1,a1,-182 # 10b8 <malloc+0x166>
     176:	00001517          	auipc	a0,0x1
     17a:	f5a50513          	addi	a0,a0,-166 # 10d0 <malloc+0x17e>
     17e:	00001097          	auipc	ra,0x1
     182:	be2080e7          	jalr	-1054(ra) # d60 <printf>
     186:	557d                	li	a0,-1
     188:	00000097          	auipc	ra,0x0
     18c:	69a080e7          	jalr	1690(ra) # 822 <exit>
   
   check(getpinfo(st_before) == 0, "getpinfo");
     190:	fd843503          	ld	a0,-40(s0)
     194:	00000097          	auipc	ra,0x0
     198:	72e080e7          	jalr	1838(ra) # 8c2 <getpinfo>
     19c:	87aa                	mv	a5,a0
     19e:	cb85                	beqz	a5,1ce <main+0xc6>
     1a0:	00001697          	auipc	a3,0x1
     1a4:	f6068693          	addi	a3,a3,-160 # 1100 <malloc+0x1ae>
     1a8:	02f00613          	li	a2,47
     1ac:	00001597          	auipc	a1,0x1
     1b0:	f0c58593          	addi	a1,a1,-244 # 10b8 <malloc+0x166>
     1b4:	00001517          	auipc	a0,0x1
     1b8:	f5c50513          	addi	a0,a0,-164 # 1110 <malloc+0x1be>
     1bc:	00001097          	auipc	ra,0x1
     1c0:	ba4080e7          	jalr	-1116(ra) # d60 <printf>
     1c4:	557d                	li	a0,-1
     1c6:	00000097          	auipc	ra,0x0
     1ca:	65c080e7          	jalr	1628(ra) # 822 <exit>
   printf("\n **** PInfo Before**** \n");
     1ce:	00001517          	auipc	a0,0x1
     1d2:	f7a50513          	addi	a0,a0,-134 # 1148 <malloc+0x1f6>
     1d6:	00001097          	auipc	ra,0x1
     1da:	b8a080e7          	jalr	-1142(ra) # d60 <printf>
   print(st_before);
     1de:	fd843503          	ld	a0,-40(s0)
     1e2:	00000097          	auipc	ra,0x0
     1e6:	e96080e7          	jalr	-362(ra) # 78 <print>

   aux[0] += spin();
     1ea:	00000097          	auipc	ra,0x0
     1ee:	e16080e7          	jalr	-490(ra) # 0 <spin>
     1f2:	87aa                	mv	a5,a0
     1f4:	873e                	mv	a4,a5
     1f6:	fc843783          	ld	a5,-56(s0)
     1fa:	439c                	lw	a5,0(a5)
     1fc:	9fb9                	addw	a5,a5,a4
     1fe:	0007871b          	sext.w	a4,a5
     202:	fc843783          	ld	a5,-56(s0)
     206:	c398                	sw	a4,0(a5)

   check(getpinfo(st_after) == 0, "getpinfo");
     208:	fd043503          	ld	a0,-48(s0)
     20c:	00000097          	auipc	ra,0x0
     210:	6b6080e7          	jalr	1718(ra) # 8c2 <getpinfo>
     214:	87aa                	mv	a5,a0
     216:	cb85                	beqz	a5,246 <main+0x13e>
     218:	00001697          	auipc	a3,0x1
     21c:	ee868693          	addi	a3,a3,-280 # 1100 <malloc+0x1ae>
     220:	03500613          	li	a2,53
     224:	00001597          	auipc	a1,0x1
     228:	e9458593          	addi	a1,a1,-364 # 10b8 <malloc+0x166>
     22c:	00001517          	auipc	a0,0x1
     230:	f3c50513          	addi	a0,a0,-196 # 1168 <malloc+0x216>
     234:	00001097          	auipc	ra,0x1
     238:	b2c080e7          	jalr	-1236(ra) # d60 <printf>
     23c:	557d                	li	a0,-1
     23e:	00000097          	auipc	ra,0x0
     242:	5e4080e7          	jalr	1508(ra) # 822 <exit>
   printf("\n **** PInfo After**** \n");
     246:	00001517          	auipc	a0,0x1
     24a:	f5a50513          	addi	a0,a0,-166 # 11a0 <malloc+0x24e>
     24e:	00001097          	auipc	ra,0x1
     252:	b12080e7          	jalr	-1262(ra) # d60 <printf>
   print(st_after);
     256:	fd043503          	ld	a0,-48(s0)
     25a:	00000097          	auipc	ra,0x0
     25e:	e1e080e7          	jalr	-482(ra) # 78 <print>
   
   for(i = 0; i < NPROC; i++) {
     262:	fe042223          	sw	zero,-28(s0)
     266:	a841                	j	2f6 <main+0x1ee>
      if (st_before->inuse[i] && st_after->inuse[i]) {
     268:	fd843703          	ld	a4,-40(s0)
     26c:	fe442783          	lw	a5,-28(s0)
     270:	078e                	slli	a5,a5,0x3
     272:	97ba                	add	a5,a5,a4
     274:	639c                	ld	a5,0(a5)
     276:	cbbd                	beqz	a5,2ec <main+0x1e4>
     278:	fd043703          	ld	a4,-48(s0)
     27c:	fe442783          	lw	a5,-28(s0)
     280:	078e                	slli	a5,a5,0x3
     282:	97ba                	add	a5,a5,a4
     284:	639c                	ld	a5,0(a5)
     286:	c3bd                	beqz	a5,2ec <main+0x1e4>
	 if(st_before->lticks[i] != st_after->lticks[i])
     288:	fd843703          	ld	a4,-40(s0)
     28c:	fe442783          	lw	a5,-28(s0)
     290:	0c078793          	addi	a5,a5,192
     294:	078e                	slli	a5,a5,0x3
     296:	97ba                	add	a5,a5,a4
     298:	6398                	ld	a4,0(a5)
     29a:	fd043683          	ld	a3,-48(s0)
     29e:	fe442783          	lw	a5,-28(s0)
     2a2:	0c078793          	addi	a5,a5,192
     2a6:	078e                	slli	a5,a5,0x3
     2a8:	97b6                	add	a5,a5,a3
     2aa:	639c                	ld	a5,0(a5)
     2ac:	00f70763          	beq	a4,a5,2ba <main+0x1b2>
	 {
		processwithlowticks++;
     2b0:	fe842783          	lw	a5,-24(s0)
     2b4:	2785                	addiw	a5,a5,1
     2b6:	fef42423          	sw	a5,-24(s0)
	 } 
	 if(st_after->hticks[i] - st_before->hticks[i] > 0)
     2ba:	fd043703          	ld	a4,-48(s0)
     2be:	fe442783          	lw	a5,-28(s0)
     2c2:	08078793          	addi	a5,a5,128
     2c6:	078e                	slli	a5,a5,0x3
     2c8:	97ba                	add	a5,a5,a4
     2ca:	6398                	ld	a4,0(a5)
     2cc:	fd843683          	ld	a3,-40(s0)
     2d0:	fe442783          	lw	a5,-28(s0)
     2d4:	08078793          	addi	a5,a5,128
     2d8:	078e                	slli	a5,a5,0x3
     2da:	97b6                	add	a5,a5,a3
     2dc:	639c                	ld	a5,0(a5)
     2de:	00f70763          	beq	a4,a5,2ec <main+0x1e4>
		highpriority++;
     2e2:	fec42783          	lw	a5,-20(s0)
     2e6:	2785                	addiw	a5,a5,1
     2e8:	fef42623          	sw	a5,-20(s0)
   for(i = 0; i < NPROC; i++) {
     2ec:	fe442783          	lw	a5,-28(s0)
     2f0:	2785                	addiw	a5,a5,1
     2f2:	fef42223          	sw	a5,-28(s0)
     2f6:	fe442783          	lw	a5,-28(s0)
     2fa:	0007871b          	sext.w	a4,a5
     2fe:	03f00793          	li	a5,63
     302:	f6e7d3e3          	bge	a5,a4,268 <main+0x160>
      }
   }
   check(processwithlowticks == 0, "low ticks shouldn't have been increased for any of the processes");
     306:	fe842783          	lw	a5,-24(s0)
     30a:	2781                	sext.w	a5,a5
     30c:	cb85                	beqz	a5,33c <main+0x234>
     30e:	00001697          	auipc	a3,0x1
     312:	eb268693          	addi	a3,a3,-334 # 11c0 <malloc+0x26e>
     316:	04300613          	li	a2,67
     31a:	00001597          	auipc	a1,0x1
     31e:	d9e58593          	addi	a1,a1,-610 # 10b8 <malloc+0x166>
     322:	00001517          	auipc	a0,0x1
     326:	ee650513          	addi	a0,a0,-282 # 1208 <malloc+0x2b6>
     32a:	00001097          	auipc	ra,0x1
     32e:	a36080e7          	jalr	-1482(ra) # d60 <printf>
     332:	557d                	li	a0,-1
     334:	00000097          	auipc	ra,0x0
     338:	4ee080e7          	jalr	1262(ra) # 822 <exit>
   check(highpriority == 1, "getpinfo should return 1 process with hticks greater than 0");
     33c:	fec42783          	lw	a5,-20(s0)
     340:	0007871b          	sext.w	a4,a5
     344:	4785                	li	a5,1
     346:	02f70963          	beq	a4,a5,378 <main+0x270>
     34a:	00001697          	auipc	a3,0x1
     34e:	ef668693          	addi	a3,a3,-266 # 1240 <malloc+0x2ee>
     352:	04400613          	li	a2,68
     356:	00001597          	auipc	a1,0x1
     35a:	d6258593          	addi	a1,a1,-670 # 10b8 <malloc+0x166>
     35e:	00001517          	auipc	a0,0x1
     362:	f2250513          	addi	a0,a0,-222 # 1280 <malloc+0x32e>
     366:	00001097          	auipc	ra,0x1
     36a:	9fa080e7          	jalr	-1542(ra) # d60 <printf>
     36e:	557d                	li	a0,-1
     370:	00000097          	auipc	ra,0x0
     374:	4b2080e7          	jalr	1202(ra) # 822 <exit>
   printf("Should print 1 then 2");
     378:	00001517          	auipc	a0,0x1
     37c:	f3850513          	addi	a0,a0,-200 # 12b0 <malloc+0x35e>
     380:	00001097          	auipc	ra,0x1
     384:	9e0080e7          	jalr	-1568(ra) # d60 <printf>
   exit(0);
     388:	4501                	li	a0,0
     38a:	00000097          	auipc	ra,0x0
     38e:	498080e7          	jalr	1176(ra) # 822 <exit>

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
     4ac:	0ff77713          	andi	a4,a4,255
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
     4f6:	0ff7f793          	andi	a5,a5,255
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
     548:	2f6080e7          	jalr	758(ra) # 83a <read>
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
     5de:	288080e7          	jalr	648(ra) # 862 <open>
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
     604:	27a080e7          	jalr	634(ra) # 87a <fstat>
     608:	87aa                	mv	a5,a0
     60a:	fef42423          	sw	a5,-24(s0)
  close(fd);
     60e:	fec42783          	lw	a5,-20(s0)
     612:	853e                	mv	a0,a5
     614:	00000097          	auipc	ra,0x0
     618:	236080e7          	jalr	566(ra) # 84a <close>
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
     638:	a815                	j	66c <atoi+0x42>
    n = n*10 + *s++ - '0';
     63a:	fec42703          	lw	a4,-20(s0)
     63e:	87ba                	mv	a5,a4
     640:	0027979b          	slliw	a5,a5,0x2
     644:	9fb9                	addw	a5,a5,a4
     646:	0017979b          	slliw	a5,a5,0x1
     64a:	0007871b          	sext.w	a4,a5
     64e:	fd843783          	ld	a5,-40(s0)
     652:	00178693          	addi	a3,a5,1
     656:	fcd43c23          	sd	a3,-40(s0)
     65a:	0007c783          	lbu	a5,0(a5)
     65e:	2781                	sext.w	a5,a5
     660:	9fb9                	addw	a5,a5,a4
     662:	2781                	sext.w	a5,a5
     664:	fd07879b          	addiw	a5,a5,-48
     668:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     66c:	fd843783          	ld	a5,-40(s0)
     670:	0007c783          	lbu	a5,0(a5)
     674:	873e                	mv	a4,a5
     676:	02f00793          	li	a5,47
     67a:	00e7fb63          	bgeu	a5,a4,690 <atoi+0x66>
     67e:	fd843783          	ld	a5,-40(s0)
     682:	0007c783          	lbu	a5,0(a5)
     686:	873e                	mv	a4,a5
     688:	03900793          	li	a5,57
     68c:	fae7f7e3          	bgeu	a5,a4,63a <atoi+0x10>
  return n;
     690:	fec42783          	lw	a5,-20(s0)
}
     694:	853e                	mv	a0,a5
     696:	7422                	ld	s0,40(sp)
     698:	6145                	addi	sp,sp,48
     69a:	8082                	ret

000000000000069c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     69c:	7139                	addi	sp,sp,-64
     69e:	fc22                	sd	s0,56(sp)
     6a0:	0080                	addi	s0,sp,64
     6a2:	fca43c23          	sd	a0,-40(s0)
     6a6:	fcb43823          	sd	a1,-48(s0)
     6aa:	87b2                	mv	a5,a2
     6ac:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     6b0:	fd843783          	ld	a5,-40(s0)
     6b4:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     6b8:	fd043783          	ld	a5,-48(s0)
     6bc:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     6c0:	fe043703          	ld	a4,-32(s0)
     6c4:	fe843783          	ld	a5,-24(s0)
     6c8:	02e7fc63          	bgeu	a5,a4,700 <memmove+0x64>
    while(n-- > 0)
     6cc:	a00d                	j	6ee <memmove+0x52>
      *dst++ = *src++;
     6ce:	fe043703          	ld	a4,-32(s0)
     6d2:	00170793          	addi	a5,a4,1
     6d6:	fef43023          	sd	a5,-32(s0)
     6da:	fe843783          	ld	a5,-24(s0)
     6de:	00178693          	addi	a3,a5,1
     6e2:	fed43423          	sd	a3,-24(s0)
     6e6:	00074703          	lbu	a4,0(a4)
     6ea:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     6ee:	fcc42783          	lw	a5,-52(s0)
     6f2:	fff7871b          	addiw	a4,a5,-1
     6f6:	fce42623          	sw	a4,-52(s0)
     6fa:	fcf04ae3          	bgtz	a5,6ce <memmove+0x32>
     6fe:	a891                	j	752 <memmove+0xb6>
  } else {
    dst += n;
     700:	fcc42783          	lw	a5,-52(s0)
     704:	fe843703          	ld	a4,-24(s0)
     708:	97ba                	add	a5,a5,a4
     70a:	fef43423          	sd	a5,-24(s0)
    src += n;
     70e:	fcc42783          	lw	a5,-52(s0)
     712:	fe043703          	ld	a4,-32(s0)
     716:	97ba                	add	a5,a5,a4
     718:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     71c:	a01d                	j	742 <memmove+0xa6>
      *--dst = *--src;
     71e:	fe043783          	ld	a5,-32(s0)
     722:	17fd                	addi	a5,a5,-1
     724:	fef43023          	sd	a5,-32(s0)
     728:	fe843783          	ld	a5,-24(s0)
     72c:	17fd                	addi	a5,a5,-1
     72e:	fef43423          	sd	a5,-24(s0)
     732:	fe043783          	ld	a5,-32(s0)
     736:	0007c703          	lbu	a4,0(a5)
     73a:	fe843783          	ld	a5,-24(s0)
     73e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     742:	fcc42783          	lw	a5,-52(s0)
     746:	fff7871b          	addiw	a4,a5,-1
     74a:	fce42623          	sw	a4,-52(s0)
     74e:	fcf048e3          	bgtz	a5,71e <memmove+0x82>
  }
  return vdst;
     752:	fd843783          	ld	a5,-40(s0)
}
     756:	853e                	mv	a0,a5
     758:	7462                	ld	s0,56(sp)
     75a:	6121                	addi	sp,sp,64
     75c:	8082                	ret

000000000000075e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     75e:	7139                	addi	sp,sp,-64
     760:	fc22                	sd	s0,56(sp)
     762:	0080                	addi	s0,sp,64
     764:	fca43c23          	sd	a0,-40(s0)
     768:	fcb43823          	sd	a1,-48(s0)
     76c:	87b2                	mv	a5,a2
     76e:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     772:	fd843783          	ld	a5,-40(s0)
     776:	fef43423          	sd	a5,-24(s0)
     77a:	fd043783          	ld	a5,-48(s0)
     77e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     782:	a0a1                	j	7ca <memcmp+0x6c>
    if (*p1 != *p2) {
     784:	fe843783          	ld	a5,-24(s0)
     788:	0007c703          	lbu	a4,0(a5)
     78c:	fe043783          	ld	a5,-32(s0)
     790:	0007c783          	lbu	a5,0(a5)
     794:	02f70163          	beq	a4,a5,7b6 <memcmp+0x58>
      return *p1 - *p2;
     798:	fe843783          	ld	a5,-24(s0)
     79c:	0007c783          	lbu	a5,0(a5)
     7a0:	0007871b          	sext.w	a4,a5
     7a4:	fe043783          	ld	a5,-32(s0)
     7a8:	0007c783          	lbu	a5,0(a5)
     7ac:	2781                	sext.w	a5,a5
     7ae:	40f707bb          	subw	a5,a4,a5
     7b2:	2781                	sext.w	a5,a5
     7b4:	a01d                	j	7da <memcmp+0x7c>
    }
    p1++;
     7b6:	fe843783          	ld	a5,-24(s0)
     7ba:	0785                	addi	a5,a5,1
     7bc:	fef43423          	sd	a5,-24(s0)
    p2++;
     7c0:	fe043783          	ld	a5,-32(s0)
     7c4:	0785                	addi	a5,a5,1
     7c6:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     7ca:	fcc42783          	lw	a5,-52(s0)
     7ce:	fff7871b          	addiw	a4,a5,-1
     7d2:	fce42623          	sw	a4,-52(s0)
     7d6:	f7dd                	bnez	a5,784 <memcmp+0x26>
  }
  return 0;
     7d8:	4781                	li	a5,0
}
     7da:	853e                	mv	a0,a5
     7dc:	7462                	ld	s0,56(sp)
     7de:	6121                	addi	sp,sp,64
     7e0:	8082                	ret

00000000000007e2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     7e2:	7179                	addi	sp,sp,-48
     7e4:	f406                	sd	ra,40(sp)
     7e6:	f022                	sd	s0,32(sp)
     7e8:	1800                	addi	s0,sp,48
     7ea:	fea43423          	sd	a0,-24(s0)
     7ee:	feb43023          	sd	a1,-32(s0)
     7f2:	87b2                	mv	a5,a2
     7f4:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     7f8:	fdc42783          	lw	a5,-36(s0)
     7fc:	863e                	mv	a2,a5
     7fe:	fe043583          	ld	a1,-32(s0)
     802:	fe843503          	ld	a0,-24(s0)
     806:	00000097          	auipc	ra,0x0
     80a:	e96080e7          	jalr	-362(ra) # 69c <memmove>
     80e:	87aa                	mv	a5,a0
}
     810:	853e                	mv	a0,a5
     812:	70a2                	ld	ra,40(sp)
     814:	7402                	ld	s0,32(sp)
     816:	6145                	addi	sp,sp,48
     818:	8082                	ret

000000000000081a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     81a:	4885                	li	a7,1
 ecall
     81c:	00000073          	ecall
 ret
     820:	8082                	ret

0000000000000822 <exit>:
.global exit
exit:
 li a7, SYS_exit
     822:	4889                	li	a7,2
 ecall
     824:	00000073          	ecall
 ret
     828:	8082                	ret

000000000000082a <wait>:
.global wait
wait:
 li a7, SYS_wait
     82a:	488d                	li	a7,3
 ecall
     82c:	00000073          	ecall
 ret
     830:	8082                	ret

0000000000000832 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     832:	4891                	li	a7,4
 ecall
     834:	00000073          	ecall
 ret
     838:	8082                	ret

000000000000083a <read>:
.global read
read:
 li a7, SYS_read
     83a:	4895                	li	a7,5
 ecall
     83c:	00000073          	ecall
 ret
     840:	8082                	ret

0000000000000842 <write>:
.global write
write:
 li a7, SYS_write
     842:	48c1                	li	a7,16
 ecall
     844:	00000073          	ecall
 ret
     848:	8082                	ret

000000000000084a <close>:
.global close
close:
 li a7, SYS_close
     84a:	48d5                	li	a7,21
 ecall
     84c:	00000073          	ecall
 ret
     850:	8082                	ret

0000000000000852 <kill>:
.global kill
kill:
 li a7, SYS_kill
     852:	4899                	li	a7,6
 ecall
     854:	00000073          	ecall
 ret
     858:	8082                	ret

000000000000085a <exec>:
.global exec
exec:
 li a7, SYS_exec
     85a:	489d                	li	a7,7
 ecall
     85c:	00000073          	ecall
 ret
     860:	8082                	ret

0000000000000862 <open>:
.global open
open:
 li a7, SYS_open
     862:	48bd                	li	a7,15
 ecall
     864:	00000073          	ecall
 ret
     868:	8082                	ret

000000000000086a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     86a:	48c5                	li	a7,17
 ecall
     86c:	00000073          	ecall
 ret
     870:	8082                	ret

0000000000000872 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     872:	48c9                	li	a7,18
 ecall
     874:	00000073          	ecall
 ret
     878:	8082                	ret

000000000000087a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     87a:	48a1                	li	a7,8
 ecall
     87c:	00000073          	ecall
 ret
     880:	8082                	ret

0000000000000882 <link>:
.global link
link:
 li a7, SYS_link
     882:	48cd                	li	a7,19
 ecall
     884:	00000073          	ecall
 ret
     888:	8082                	ret

000000000000088a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     88a:	48d1                	li	a7,20
 ecall
     88c:	00000073          	ecall
 ret
     890:	8082                	ret

0000000000000892 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     892:	48a5                	li	a7,9
 ecall
     894:	00000073          	ecall
 ret
     898:	8082                	ret

000000000000089a <dup>:
.global dup
dup:
 li a7, SYS_dup
     89a:	48a9                	li	a7,10
 ecall
     89c:	00000073          	ecall
 ret
     8a0:	8082                	ret

00000000000008a2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     8a2:	48ad                	li	a7,11
 ecall
     8a4:	00000073          	ecall
 ret
     8a8:	8082                	ret

00000000000008aa <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     8aa:	48b1                	li	a7,12
 ecall
     8ac:	00000073          	ecall
 ret
     8b0:	8082                	ret

00000000000008b2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     8b2:	48b5                	li	a7,13
 ecall
     8b4:	00000073          	ecall
 ret
     8b8:	8082                	ret

00000000000008ba <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     8ba:	48b9                	li	a7,14
 ecall
     8bc:	00000073          	ecall
 ret
     8c0:	8082                	ret

00000000000008c2 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
     8c2:	48d9                	li	a7,22
 ecall
     8c4:	00000073          	ecall
 ret
     8c8:	8082                	ret

00000000000008ca <setpri>:
.global setpri
setpri:
 li a7, SYS_setpri
     8ca:	48dd                	li	a7,23
 ecall
     8cc:	00000073          	ecall
 ret
     8d0:	8082                	ret

00000000000008d2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     8d2:	1101                	addi	sp,sp,-32
     8d4:	ec06                	sd	ra,24(sp)
     8d6:	e822                	sd	s0,16(sp)
     8d8:	1000                	addi	s0,sp,32
     8da:	87aa                	mv	a5,a0
     8dc:	872e                	mv	a4,a1
     8de:	fef42623          	sw	a5,-20(s0)
     8e2:	87ba                	mv	a5,a4
     8e4:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     8e8:	feb40713          	addi	a4,s0,-21
     8ec:	fec42783          	lw	a5,-20(s0)
     8f0:	4605                	li	a2,1
     8f2:	85ba                	mv	a1,a4
     8f4:	853e                	mv	a0,a5
     8f6:	00000097          	auipc	ra,0x0
     8fa:	f4c080e7          	jalr	-180(ra) # 842 <write>
}
     8fe:	0001                	nop
     900:	60e2                	ld	ra,24(sp)
     902:	6442                	ld	s0,16(sp)
     904:	6105                	addi	sp,sp,32
     906:	8082                	ret

0000000000000908 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     908:	7139                	addi	sp,sp,-64
     90a:	fc06                	sd	ra,56(sp)
     90c:	f822                	sd	s0,48(sp)
     90e:	0080                	addi	s0,sp,64
     910:	87aa                	mv	a5,a0
     912:	8736                	mv	a4,a3
     914:	fcf42623          	sw	a5,-52(s0)
     918:	87ae                	mv	a5,a1
     91a:	fcf42423          	sw	a5,-56(s0)
     91e:	87b2                	mv	a5,a2
     920:	fcf42223          	sw	a5,-60(s0)
     924:	87ba                	mv	a5,a4
     926:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     92a:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     92e:	fc042783          	lw	a5,-64(s0)
     932:	2781                	sext.w	a5,a5
     934:	c38d                	beqz	a5,956 <printint+0x4e>
     936:	fc842783          	lw	a5,-56(s0)
     93a:	2781                	sext.w	a5,a5
     93c:	0007dd63          	bgez	a5,956 <printint+0x4e>
    neg = 1;
     940:	4785                	li	a5,1
     942:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     946:	fc842783          	lw	a5,-56(s0)
     94a:	40f007bb          	negw	a5,a5
     94e:	2781                	sext.w	a5,a5
     950:	fef42223          	sw	a5,-28(s0)
     954:	a029                	j	95e <printint+0x56>
  } else {
    x = xx;
     956:	fc842783          	lw	a5,-56(s0)
     95a:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     95e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     962:	fc442783          	lw	a5,-60(s0)
     966:	fe442703          	lw	a4,-28(s0)
     96a:	02f777bb          	remuw	a5,a4,a5
     96e:	0007861b          	sext.w	a2,a5
     972:	fec42783          	lw	a5,-20(s0)
     976:	0017871b          	addiw	a4,a5,1
     97a:	fee42623          	sw	a4,-20(s0)
     97e:	00001697          	auipc	a3,0x1
     982:	95268693          	addi	a3,a3,-1710 # 12d0 <digits>
     986:	02061713          	slli	a4,a2,0x20
     98a:	9301                	srli	a4,a4,0x20
     98c:	9736                	add	a4,a4,a3
     98e:	00074703          	lbu	a4,0(a4)
     992:	ff040693          	addi	a3,s0,-16
     996:	97b6                	add	a5,a5,a3
     998:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     99c:	fc442783          	lw	a5,-60(s0)
     9a0:	fe442703          	lw	a4,-28(s0)
     9a4:	02f757bb          	divuw	a5,a4,a5
     9a8:	fef42223          	sw	a5,-28(s0)
     9ac:	fe442783          	lw	a5,-28(s0)
     9b0:	2781                	sext.w	a5,a5
     9b2:	fbc5                	bnez	a5,962 <printint+0x5a>
  if(neg)
     9b4:	fe842783          	lw	a5,-24(s0)
     9b8:	2781                	sext.w	a5,a5
     9ba:	cf95                	beqz	a5,9f6 <printint+0xee>
    buf[i++] = '-';
     9bc:	fec42783          	lw	a5,-20(s0)
     9c0:	0017871b          	addiw	a4,a5,1
     9c4:	fee42623          	sw	a4,-20(s0)
     9c8:	ff040713          	addi	a4,s0,-16
     9cc:	97ba                	add	a5,a5,a4
     9ce:	02d00713          	li	a4,45
     9d2:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     9d6:	a005                	j	9f6 <printint+0xee>
    putc(fd, buf[i]);
     9d8:	fec42783          	lw	a5,-20(s0)
     9dc:	ff040713          	addi	a4,s0,-16
     9e0:	97ba                	add	a5,a5,a4
     9e2:	fe07c703          	lbu	a4,-32(a5)
     9e6:	fcc42783          	lw	a5,-52(s0)
     9ea:	85ba                	mv	a1,a4
     9ec:	853e                	mv	a0,a5
     9ee:	00000097          	auipc	ra,0x0
     9f2:	ee4080e7          	jalr	-284(ra) # 8d2 <putc>
  while(--i >= 0)
     9f6:	fec42783          	lw	a5,-20(s0)
     9fa:	37fd                	addiw	a5,a5,-1
     9fc:	fef42623          	sw	a5,-20(s0)
     a00:	fec42783          	lw	a5,-20(s0)
     a04:	2781                	sext.w	a5,a5
     a06:	fc07d9e3          	bgez	a5,9d8 <printint+0xd0>
}
     a0a:	0001                	nop
     a0c:	0001                	nop
     a0e:	70e2                	ld	ra,56(sp)
     a10:	7442                	ld	s0,48(sp)
     a12:	6121                	addi	sp,sp,64
     a14:	8082                	ret

0000000000000a16 <printptr>:

static void
printptr(int fd, uint64 x) {
     a16:	7179                	addi	sp,sp,-48
     a18:	f406                	sd	ra,40(sp)
     a1a:	f022                	sd	s0,32(sp)
     a1c:	1800                	addi	s0,sp,48
     a1e:	87aa                	mv	a5,a0
     a20:	fcb43823          	sd	a1,-48(s0)
     a24:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     a28:	fdc42783          	lw	a5,-36(s0)
     a2c:	03000593          	li	a1,48
     a30:	853e                	mv	a0,a5
     a32:	00000097          	auipc	ra,0x0
     a36:	ea0080e7          	jalr	-352(ra) # 8d2 <putc>
  putc(fd, 'x');
     a3a:	fdc42783          	lw	a5,-36(s0)
     a3e:	07800593          	li	a1,120
     a42:	853e                	mv	a0,a5
     a44:	00000097          	auipc	ra,0x0
     a48:	e8e080e7          	jalr	-370(ra) # 8d2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a4c:	fe042623          	sw	zero,-20(s0)
     a50:	a82d                	j	a8a <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     a52:	fd043783          	ld	a5,-48(s0)
     a56:	93f1                	srli	a5,a5,0x3c
     a58:	00001717          	auipc	a4,0x1
     a5c:	87870713          	addi	a4,a4,-1928 # 12d0 <digits>
     a60:	97ba                	add	a5,a5,a4
     a62:	0007c703          	lbu	a4,0(a5)
     a66:	fdc42783          	lw	a5,-36(s0)
     a6a:	85ba                	mv	a1,a4
     a6c:	853e                	mv	a0,a5
     a6e:	00000097          	auipc	ra,0x0
     a72:	e64080e7          	jalr	-412(ra) # 8d2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a76:	fec42783          	lw	a5,-20(s0)
     a7a:	2785                	addiw	a5,a5,1
     a7c:	fef42623          	sw	a5,-20(s0)
     a80:	fd043783          	ld	a5,-48(s0)
     a84:	0792                	slli	a5,a5,0x4
     a86:	fcf43823          	sd	a5,-48(s0)
     a8a:	fec42783          	lw	a5,-20(s0)
     a8e:	873e                	mv	a4,a5
     a90:	47bd                	li	a5,15
     a92:	fce7f0e3          	bgeu	a5,a4,a52 <printptr+0x3c>
}
     a96:	0001                	nop
     a98:	0001                	nop
     a9a:	70a2                	ld	ra,40(sp)
     a9c:	7402                	ld	s0,32(sp)
     a9e:	6145                	addi	sp,sp,48
     aa0:	8082                	ret

0000000000000aa2 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     aa2:	715d                	addi	sp,sp,-80
     aa4:	e486                	sd	ra,72(sp)
     aa6:	e0a2                	sd	s0,64(sp)
     aa8:	0880                	addi	s0,sp,80
     aaa:	87aa                	mv	a5,a0
     aac:	fcb43023          	sd	a1,-64(s0)
     ab0:	fac43c23          	sd	a2,-72(s0)
     ab4:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     ab8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     abc:	fe042223          	sw	zero,-28(s0)
     ac0:	a42d                	j	cea <vprintf+0x248>
    c = fmt[i] & 0xff;
     ac2:	fe442783          	lw	a5,-28(s0)
     ac6:	fc043703          	ld	a4,-64(s0)
     aca:	97ba                	add	a5,a5,a4
     acc:	0007c783          	lbu	a5,0(a5)
     ad0:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     ad4:	fe042783          	lw	a5,-32(s0)
     ad8:	2781                	sext.w	a5,a5
     ada:	eb9d                	bnez	a5,b10 <vprintf+0x6e>
      if(c == '%'){
     adc:	fdc42783          	lw	a5,-36(s0)
     ae0:	0007871b          	sext.w	a4,a5
     ae4:	02500793          	li	a5,37
     ae8:	00f71763          	bne	a4,a5,af6 <vprintf+0x54>
        state = '%';
     aec:	02500793          	li	a5,37
     af0:	fef42023          	sw	a5,-32(s0)
     af4:	a2f5                	j	ce0 <vprintf+0x23e>
      } else {
        putc(fd, c);
     af6:	fdc42783          	lw	a5,-36(s0)
     afa:	0ff7f713          	andi	a4,a5,255
     afe:	fcc42783          	lw	a5,-52(s0)
     b02:	85ba                	mv	a1,a4
     b04:	853e                	mv	a0,a5
     b06:	00000097          	auipc	ra,0x0
     b0a:	dcc080e7          	jalr	-564(ra) # 8d2 <putc>
     b0e:	aac9                	j	ce0 <vprintf+0x23e>
      }
    } else if(state == '%'){
     b10:	fe042783          	lw	a5,-32(s0)
     b14:	0007871b          	sext.w	a4,a5
     b18:	02500793          	li	a5,37
     b1c:	1cf71263          	bne	a4,a5,ce0 <vprintf+0x23e>
      if(c == 'd'){
     b20:	fdc42783          	lw	a5,-36(s0)
     b24:	0007871b          	sext.w	a4,a5
     b28:	06400793          	li	a5,100
     b2c:	02f71463          	bne	a4,a5,b54 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     b30:	fb843783          	ld	a5,-72(s0)
     b34:	00878713          	addi	a4,a5,8
     b38:	fae43c23          	sd	a4,-72(s0)
     b3c:	4398                	lw	a4,0(a5)
     b3e:	fcc42783          	lw	a5,-52(s0)
     b42:	4685                	li	a3,1
     b44:	4629                	li	a2,10
     b46:	85ba                	mv	a1,a4
     b48:	853e                	mv	a0,a5
     b4a:	00000097          	auipc	ra,0x0
     b4e:	dbe080e7          	jalr	-578(ra) # 908 <printint>
     b52:	a269                	j	cdc <vprintf+0x23a>
      } else if(c == 'l') {
     b54:	fdc42783          	lw	a5,-36(s0)
     b58:	0007871b          	sext.w	a4,a5
     b5c:	06c00793          	li	a5,108
     b60:	02f71663          	bne	a4,a5,b8c <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     b64:	fb843783          	ld	a5,-72(s0)
     b68:	00878713          	addi	a4,a5,8
     b6c:	fae43c23          	sd	a4,-72(s0)
     b70:	639c                	ld	a5,0(a5)
     b72:	0007871b          	sext.w	a4,a5
     b76:	fcc42783          	lw	a5,-52(s0)
     b7a:	4681                	li	a3,0
     b7c:	4629                	li	a2,10
     b7e:	85ba                	mv	a1,a4
     b80:	853e                	mv	a0,a5
     b82:	00000097          	auipc	ra,0x0
     b86:	d86080e7          	jalr	-634(ra) # 908 <printint>
     b8a:	aa89                	j	cdc <vprintf+0x23a>
      } else if(c == 'x') {
     b8c:	fdc42783          	lw	a5,-36(s0)
     b90:	0007871b          	sext.w	a4,a5
     b94:	07800793          	li	a5,120
     b98:	02f71463          	bne	a4,a5,bc0 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     b9c:	fb843783          	ld	a5,-72(s0)
     ba0:	00878713          	addi	a4,a5,8
     ba4:	fae43c23          	sd	a4,-72(s0)
     ba8:	4398                	lw	a4,0(a5)
     baa:	fcc42783          	lw	a5,-52(s0)
     bae:	4681                	li	a3,0
     bb0:	4641                	li	a2,16
     bb2:	85ba                	mv	a1,a4
     bb4:	853e                	mv	a0,a5
     bb6:	00000097          	auipc	ra,0x0
     bba:	d52080e7          	jalr	-686(ra) # 908 <printint>
     bbe:	aa39                	j	cdc <vprintf+0x23a>
      } else if(c == 'p') {
     bc0:	fdc42783          	lw	a5,-36(s0)
     bc4:	0007871b          	sext.w	a4,a5
     bc8:	07000793          	li	a5,112
     bcc:	02f71263          	bne	a4,a5,bf0 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     bd0:	fb843783          	ld	a5,-72(s0)
     bd4:	00878713          	addi	a4,a5,8
     bd8:	fae43c23          	sd	a4,-72(s0)
     bdc:	6398                	ld	a4,0(a5)
     bde:	fcc42783          	lw	a5,-52(s0)
     be2:	85ba                	mv	a1,a4
     be4:	853e                	mv	a0,a5
     be6:	00000097          	auipc	ra,0x0
     bea:	e30080e7          	jalr	-464(ra) # a16 <printptr>
     bee:	a0fd                	j	cdc <vprintf+0x23a>
      } else if(c == 's'){
     bf0:	fdc42783          	lw	a5,-36(s0)
     bf4:	0007871b          	sext.w	a4,a5
     bf8:	07300793          	li	a5,115
     bfc:	04f71c63          	bne	a4,a5,c54 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     c00:	fb843783          	ld	a5,-72(s0)
     c04:	00878713          	addi	a4,a5,8
     c08:	fae43c23          	sd	a4,-72(s0)
     c0c:	639c                	ld	a5,0(a5)
     c0e:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     c12:	fe843783          	ld	a5,-24(s0)
     c16:	eb8d                	bnez	a5,c48 <vprintf+0x1a6>
          s = "(null)";
     c18:	00000797          	auipc	a5,0x0
     c1c:	6b078793          	addi	a5,a5,1712 # 12c8 <malloc+0x376>
     c20:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     c24:	a015                	j	c48 <vprintf+0x1a6>
          putc(fd, *s);
     c26:	fe843783          	ld	a5,-24(s0)
     c2a:	0007c703          	lbu	a4,0(a5)
     c2e:	fcc42783          	lw	a5,-52(s0)
     c32:	85ba                	mv	a1,a4
     c34:	853e                	mv	a0,a5
     c36:	00000097          	auipc	ra,0x0
     c3a:	c9c080e7          	jalr	-868(ra) # 8d2 <putc>
          s++;
     c3e:	fe843783          	ld	a5,-24(s0)
     c42:	0785                	addi	a5,a5,1
     c44:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     c48:	fe843783          	ld	a5,-24(s0)
     c4c:	0007c783          	lbu	a5,0(a5)
     c50:	fbf9                	bnez	a5,c26 <vprintf+0x184>
     c52:	a069                	j	cdc <vprintf+0x23a>
        }
      } else if(c == 'c'){
     c54:	fdc42783          	lw	a5,-36(s0)
     c58:	0007871b          	sext.w	a4,a5
     c5c:	06300793          	li	a5,99
     c60:	02f71463          	bne	a4,a5,c88 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     c64:	fb843783          	ld	a5,-72(s0)
     c68:	00878713          	addi	a4,a5,8
     c6c:	fae43c23          	sd	a4,-72(s0)
     c70:	439c                	lw	a5,0(a5)
     c72:	0ff7f713          	andi	a4,a5,255
     c76:	fcc42783          	lw	a5,-52(s0)
     c7a:	85ba                	mv	a1,a4
     c7c:	853e                	mv	a0,a5
     c7e:	00000097          	auipc	ra,0x0
     c82:	c54080e7          	jalr	-940(ra) # 8d2 <putc>
     c86:	a899                	j	cdc <vprintf+0x23a>
      } else if(c == '%'){
     c88:	fdc42783          	lw	a5,-36(s0)
     c8c:	0007871b          	sext.w	a4,a5
     c90:	02500793          	li	a5,37
     c94:	00f71f63          	bne	a4,a5,cb2 <vprintf+0x210>
        putc(fd, c);
     c98:	fdc42783          	lw	a5,-36(s0)
     c9c:	0ff7f713          	andi	a4,a5,255
     ca0:	fcc42783          	lw	a5,-52(s0)
     ca4:	85ba                	mv	a1,a4
     ca6:	853e                	mv	a0,a5
     ca8:	00000097          	auipc	ra,0x0
     cac:	c2a080e7          	jalr	-982(ra) # 8d2 <putc>
     cb0:	a035                	j	cdc <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     cb2:	fcc42783          	lw	a5,-52(s0)
     cb6:	02500593          	li	a1,37
     cba:	853e                	mv	a0,a5
     cbc:	00000097          	auipc	ra,0x0
     cc0:	c16080e7          	jalr	-1002(ra) # 8d2 <putc>
        putc(fd, c);
     cc4:	fdc42783          	lw	a5,-36(s0)
     cc8:	0ff7f713          	andi	a4,a5,255
     ccc:	fcc42783          	lw	a5,-52(s0)
     cd0:	85ba                	mv	a1,a4
     cd2:	853e                	mv	a0,a5
     cd4:	00000097          	auipc	ra,0x0
     cd8:	bfe080e7          	jalr	-1026(ra) # 8d2 <putc>
      }
      state = 0;
     cdc:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     ce0:	fe442783          	lw	a5,-28(s0)
     ce4:	2785                	addiw	a5,a5,1
     ce6:	fef42223          	sw	a5,-28(s0)
     cea:	fe442783          	lw	a5,-28(s0)
     cee:	fc043703          	ld	a4,-64(s0)
     cf2:	97ba                	add	a5,a5,a4
     cf4:	0007c783          	lbu	a5,0(a5)
     cf8:	dc0795e3          	bnez	a5,ac2 <vprintf+0x20>
    }
  }
}
     cfc:	0001                	nop
     cfe:	0001                	nop
     d00:	60a6                	ld	ra,72(sp)
     d02:	6406                	ld	s0,64(sp)
     d04:	6161                	addi	sp,sp,80
     d06:	8082                	ret

0000000000000d08 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d08:	7159                	addi	sp,sp,-112
     d0a:	fc06                	sd	ra,56(sp)
     d0c:	f822                	sd	s0,48(sp)
     d0e:	0080                	addi	s0,sp,64
     d10:	fcb43823          	sd	a1,-48(s0)
     d14:	e010                	sd	a2,0(s0)
     d16:	e414                	sd	a3,8(s0)
     d18:	e818                	sd	a4,16(s0)
     d1a:	ec1c                	sd	a5,24(s0)
     d1c:	03043023          	sd	a6,32(s0)
     d20:	03143423          	sd	a7,40(s0)
     d24:	87aa                	mv	a5,a0
     d26:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d2a:	03040793          	addi	a5,s0,48
     d2e:	fcf43423          	sd	a5,-56(s0)
     d32:	fc843783          	ld	a5,-56(s0)
     d36:	fd078793          	addi	a5,a5,-48
     d3a:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     d3e:	fe843703          	ld	a4,-24(s0)
     d42:	fdc42783          	lw	a5,-36(s0)
     d46:	863a                	mv	a2,a4
     d48:	fd043583          	ld	a1,-48(s0)
     d4c:	853e                	mv	a0,a5
     d4e:	00000097          	auipc	ra,0x0
     d52:	d54080e7          	jalr	-684(ra) # aa2 <vprintf>
}
     d56:	0001                	nop
     d58:	70e2                	ld	ra,56(sp)
     d5a:	7442                	ld	s0,48(sp)
     d5c:	6165                	addi	sp,sp,112
     d5e:	8082                	ret

0000000000000d60 <printf>:

void
printf(const char *fmt, ...)
{
     d60:	7159                	addi	sp,sp,-112
     d62:	f406                	sd	ra,40(sp)
     d64:	f022                	sd	s0,32(sp)
     d66:	1800                	addi	s0,sp,48
     d68:	fca43c23          	sd	a0,-40(s0)
     d6c:	e40c                	sd	a1,8(s0)
     d6e:	e810                	sd	a2,16(s0)
     d70:	ec14                	sd	a3,24(s0)
     d72:	f018                	sd	a4,32(s0)
     d74:	f41c                	sd	a5,40(s0)
     d76:	03043823          	sd	a6,48(s0)
     d7a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     d7e:	04040793          	addi	a5,s0,64
     d82:	fcf43823          	sd	a5,-48(s0)
     d86:	fd043783          	ld	a5,-48(s0)
     d8a:	fc878793          	addi	a5,a5,-56
     d8e:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     d92:	fe843783          	ld	a5,-24(s0)
     d96:	863e                	mv	a2,a5
     d98:	fd843583          	ld	a1,-40(s0)
     d9c:	4505                	li	a0,1
     d9e:	00000097          	auipc	ra,0x0
     da2:	d04080e7          	jalr	-764(ra) # aa2 <vprintf>
}
     da6:	0001                	nop
     da8:	70a2                	ld	ra,40(sp)
     daa:	7402                	ld	s0,32(sp)
     dac:	6165                	addi	sp,sp,112
     dae:	8082                	ret

0000000000000db0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     db0:	7179                	addi	sp,sp,-48
     db2:	f422                	sd	s0,40(sp)
     db4:	1800                	addi	s0,sp,48
     db6:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     dba:	fd843783          	ld	a5,-40(s0)
     dbe:	17c1                	addi	a5,a5,-16
     dc0:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     dc4:	00000797          	auipc	a5,0x0
     dc8:	53478793          	addi	a5,a5,1332 # 12f8 <freep>
     dcc:	639c                	ld	a5,0(a5)
     dce:	fef43423          	sd	a5,-24(s0)
     dd2:	a815                	j	e06 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     dd4:	fe843783          	ld	a5,-24(s0)
     dd8:	639c                	ld	a5,0(a5)
     dda:	fe843703          	ld	a4,-24(s0)
     dde:	00f76f63          	bltu	a4,a5,dfc <free+0x4c>
     de2:	fe043703          	ld	a4,-32(s0)
     de6:	fe843783          	ld	a5,-24(s0)
     dea:	02e7eb63          	bltu	a5,a4,e20 <free+0x70>
     dee:	fe843783          	ld	a5,-24(s0)
     df2:	639c                	ld	a5,0(a5)
     df4:	fe043703          	ld	a4,-32(s0)
     df8:	02f76463          	bltu	a4,a5,e20 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     dfc:	fe843783          	ld	a5,-24(s0)
     e00:	639c                	ld	a5,0(a5)
     e02:	fef43423          	sd	a5,-24(s0)
     e06:	fe043703          	ld	a4,-32(s0)
     e0a:	fe843783          	ld	a5,-24(s0)
     e0e:	fce7f3e3          	bgeu	a5,a4,dd4 <free+0x24>
     e12:	fe843783          	ld	a5,-24(s0)
     e16:	639c                	ld	a5,0(a5)
     e18:	fe043703          	ld	a4,-32(s0)
     e1c:	faf77ce3          	bgeu	a4,a5,dd4 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     e20:	fe043783          	ld	a5,-32(s0)
     e24:	479c                	lw	a5,8(a5)
     e26:	1782                	slli	a5,a5,0x20
     e28:	9381                	srli	a5,a5,0x20
     e2a:	0792                	slli	a5,a5,0x4
     e2c:	fe043703          	ld	a4,-32(s0)
     e30:	973e                	add	a4,a4,a5
     e32:	fe843783          	ld	a5,-24(s0)
     e36:	639c                	ld	a5,0(a5)
     e38:	02f71763          	bne	a4,a5,e66 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     e3c:	fe043783          	ld	a5,-32(s0)
     e40:	4798                	lw	a4,8(a5)
     e42:	fe843783          	ld	a5,-24(s0)
     e46:	639c                	ld	a5,0(a5)
     e48:	479c                	lw	a5,8(a5)
     e4a:	9fb9                	addw	a5,a5,a4
     e4c:	0007871b          	sext.w	a4,a5
     e50:	fe043783          	ld	a5,-32(s0)
     e54:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     e56:	fe843783          	ld	a5,-24(s0)
     e5a:	639c                	ld	a5,0(a5)
     e5c:	6398                	ld	a4,0(a5)
     e5e:	fe043783          	ld	a5,-32(s0)
     e62:	e398                	sd	a4,0(a5)
     e64:	a039                	j	e72 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     e66:	fe843783          	ld	a5,-24(s0)
     e6a:	6398                	ld	a4,0(a5)
     e6c:	fe043783          	ld	a5,-32(s0)
     e70:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     e72:	fe843783          	ld	a5,-24(s0)
     e76:	479c                	lw	a5,8(a5)
     e78:	1782                	slli	a5,a5,0x20
     e7a:	9381                	srli	a5,a5,0x20
     e7c:	0792                	slli	a5,a5,0x4
     e7e:	fe843703          	ld	a4,-24(s0)
     e82:	97ba                	add	a5,a5,a4
     e84:	fe043703          	ld	a4,-32(s0)
     e88:	02f71563          	bne	a4,a5,eb2 <free+0x102>
    p->s.size += bp->s.size;
     e8c:	fe843783          	ld	a5,-24(s0)
     e90:	4798                	lw	a4,8(a5)
     e92:	fe043783          	ld	a5,-32(s0)
     e96:	479c                	lw	a5,8(a5)
     e98:	9fb9                	addw	a5,a5,a4
     e9a:	0007871b          	sext.w	a4,a5
     e9e:	fe843783          	ld	a5,-24(s0)
     ea2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     ea4:	fe043783          	ld	a5,-32(s0)
     ea8:	6398                	ld	a4,0(a5)
     eaa:	fe843783          	ld	a5,-24(s0)
     eae:	e398                	sd	a4,0(a5)
     eb0:	a031                	j	ebc <free+0x10c>
  } else
    p->s.ptr = bp;
     eb2:	fe843783          	ld	a5,-24(s0)
     eb6:	fe043703          	ld	a4,-32(s0)
     eba:	e398                	sd	a4,0(a5)
  freep = p;
     ebc:	00000797          	auipc	a5,0x0
     ec0:	43c78793          	addi	a5,a5,1084 # 12f8 <freep>
     ec4:	fe843703          	ld	a4,-24(s0)
     ec8:	e398                	sd	a4,0(a5)
}
     eca:	0001                	nop
     ecc:	7422                	ld	s0,40(sp)
     ece:	6145                	addi	sp,sp,48
     ed0:	8082                	ret

0000000000000ed2 <morecore>:

static Header*
morecore(uint nu)
{
     ed2:	7179                	addi	sp,sp,-48
     ed4:	f406                	sd	ra,40(sp)
     ed6:	f022                	sd	s0,32(sp)
     ed8:	1800                	addi	s0,sp,48
     eda:	87aa                	mv	a5,a0
     edc:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     ee0:	fdc42783          	lw	a5,-36(s0)
     ee4:	0007871b          	sext.w	a4,a5
     ee8:	6785                	lui	a5,0x1
     eea:	00f77563          	bgeu	a4,a5,ef4 <morecore+0x22>
    nu = 4096;
     eee:	6785                	lui	a5,0x1
     ef0:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     ef4:	fdc42783          	lw	a5,-36(s0)
     ef8:	0047979b          	slliw	a5,a5,0x4
     efc:	2781                	sext.w	a5,a5
     efe:	2781                	sext.w	a5,a5
     f00:	853e                	mv	a0,a5
     f02:	00000097          	auipc	ra,0x0
     f06:	9a8080e7          	jalr	-1624(ra) # 8aa <sbrk>
     f0a:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     f0e:	fe843703          	ld	a4,-24(s0)
     f12:	57fd                	li	a5,-1
     f14:	00f71463          	bne	a4,a5,f1c <morecore+0x4a>
    return 0;
     f18:	4781                	li	a5,0
     f1a:	a03d                	j	f48 <morecore+0x76>
  hp = (Header*)p;
     f1c:	fe843783          	ld	a5,-24(s0)
     f20:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     f24:	fe043783          	ld	a5,-32(s0)
     f28:	fdc42703          	lw	a4,-36(s0)
     f2c:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f2e:	fe043783          	ld	a5,-32(s0)
     f32:	07c1                	addi	a5,a5,16
     f34:	853e                	mv	a0,a5
     f36:	00000097          	auipc	ra,0x0
     f3a:	e7a080e7          	jalr	-390(ra) # db0 <free>
  return freep;
     f3e:	00000797          	auipc	a5,0x0
     f42:	3ba78793          	addi	a5,a5,954 # 12f8 <freep>
     f46:	639c                	ld	a5,0(a5)
}
     f48:	853e                	mv	a0,a5
     f4a:	70a2                	ld	ra,40(sp)
     f4c:	7402                	ld	s0,32(sp)
     f4e:	6145                	addi	sp,sp,48
     f50:	8082                	ret

0000000000000f52 <malloc>:

void*
malloc(uint nbytes)
{
     f52:	7139                	addi	sp,sp,-64
     f54:	fc06                	sd	ra,56(sp)
     f56:	f822                	sd	s0,48(sp)
     f58:	0080                	addi	s0,sp,64
     f5a:	87aa                	mv	a5,a0
     f5c:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f60:	fcc46783          	lwu	a5,-52(s0)
     f64:	07bd                	addi	a5,a5,15
     f66:	8391                	srli	a5,a5,0x4
     f68:	2781                	sext.w	a5,a5
     f6a:	2785                	addiw	a5,a5,1
     f6c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     f70:	00000797          	auipc	a5,0x0
     f74:	38878793          	addi	a5,a5,904 # 12f8 <freep>
     f78:	639c                	ld	a5,0(a5)
     f7a:	fef43023          	sd	a5,-32(s0)
     f7e:	fe043783          	ld	a5,-32(s0)
     f82:	ef95                	bnez	a5,fbe <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     f84:	00000797          	auipc	a5,0x0
     f88:	36478793          	addi	a5,a5,868 # 12e8 <base>
     f8c:	fef43023          	sd	a5,-32(s0)
     f90:	00000797          	auipc	a5,0x0
     f94:	36878793          	addi	a5,a5,872 # 12f8 <freep>
     f98:	fe043703          	ld	a4,-32(s0)
     f9c:	e398                	sd	a4,0(a5)
     f9e:	00000797          	auipc	a5,0x0
     fa2:	35a78793          	addi	a5,a5,858 # 12f8 <freep>
     fa6:	6398                	ld	a4,0(a5)
     fa8:	00000797          	auipc	a5,0x0
     fac:	34078793          	addi	a5,a5,832 # 12e8 <base>
     fb0:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     fb2:	00000797          	auipc	a5,0x0
     fb6:	33678793          	addi	a5,a5,822 # 12e8 <base>
     fba:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fbe:	fe043783          	ld	a5,-32(s0)
     fc2:	639c                	ld	a5,0(a5)
     fc4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     fc8:	fe843783          	ld	a5,-24(s0)
     fcc:	4798                	lw	a4,8(a5)
     fce:	fdc42783          	lw	a5,-36(s0)
     fd2:	2781                	sext.w	a5,a5
     fd4:	06f76863          	bltu	a4,a5,1044 <malloc+0xf2>
      if(p->s.size == nunits)
     fd8:	fe843783          	ld	a5,-24(s0)
     fdc:	4798                	lw	a4,8(a5)
     fde:	fdc42783          	lw	a5,-36(s0)
     fe2:	2781                	sext.w	a5,a5
     fe4:	00e79963          	bne	a5,a4,ff6 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     fe8:	fe843783          	ld	a5,-24(s0)
     fec:	6398                	ld	a4,0(a5)
     fee:	fe043783          	ld	a5,-32(s0)
     ff2:	e398                	sd	a4,0(a5)
     ff4:	a82d                	j	102e <malloc+0xdc>
      else {
        p->s.size -= nunits;
     ff6:	fe843783          	ld	a5,-24(s0)
     ffa:	4798                	lw	a4,8(a5)
     ffc:	fdc42783          	lw	a5,-36(s0)
    1000:	40f707bb          	subw	a5,a4,a5
    1004:	0007871b          	sext.w	a4,a5
    1008:	fe843783          	ld	a5,-24(s0)
    100c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    100e:	fe843783          	ld	a5,-24(s0)
    1012:	479c                	lw	a5,8(a5)
    1014:	1782                	slli	a5,a5,0x20
    1016:	9381                	srli	a5,a5,0x20
    1018:	0792                	slli	a5,a5,0x4
    101a:	fe843703          	ld	a4,-24(s0)
    101e:	97ba                	add	a5,a5,a4
    1020:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1024:	fe843783          	ld	a5,-24(s0)
    1028:	fdc42703          	lw	a4,-36(s0)
    102c:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    102e:	00000797          	auipc	a5,0x0
    1032:	2ca78793          	addi	a5,a5,714 # 12f8 <freep>
    1036:	fe043703          	ld	a4,-32(s0)
    103a:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    103c:	fe843783          	ld	a5,-24(s0)
    1040:	07c1                	addi	a5,a5,16
    1042:	a091                	j	1086 <malloc+0x134>
    }
    if(p == freep)
    1044:	00000797          	auipc	a5,0x0
    1048:	2b478793          	addi	a5,a5,692 # 12f8 <freep>
    104c:	639c                	ld	a5,0(a5)
    104e:	fe843703          	ld	a4,-24(s0)
    1052:	02f71063          	bne	a4,a5,1072 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
    1056:	fdc42783          	lw	a5,-36(s0)
    105a:	853e                	mv	a0,a5
    105c:	00000097          	auipc	ra,0x0
    1060:	e76080e7          	jalr	-394(ra) # ed2 <morecore>
    1064:	fea43423          	sd	a0,-24(s0)
    1068:	fe843783          	ld	a5,-24(s0)
    106c:	e399                	bnez	a5,1072 <malloc+0x120>
        return 0;
    106e:	4781                	li	a5,0
    1070:	a819                	j	1086 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1072:	fe843783          	ld	a5,-24(s0)
    1076:	fef43023          	sd	a5,-32(s0)
    107a:	fe843783          	ld	a5,-24(s0)
    107e:	639c                	ld	a5,0(a5)
    1080:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1084:	b791                	j	fc8 <malloc+0x76>
  }
}
    1086:	853e                	mv	a0,a5
    1088:	70e2                	ld	ra,56(sp)
    108a:	7442                	ld	s0,48(sp)
    108c:	6121                	addi	sp,sp,64
    108e:	8082                	ret
