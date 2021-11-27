
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <r_sp>:
  return (x & SSTATUS_SIE) != 0;
}

static inline uint64
r_sp()
{
       0:	1101                	addi	sp,sp,-32
       2:	ec22                	sd	s0,24(sp)
       4:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
       6:	878a                	mv	a5,sp
       8:	fef43423          	sd	a5,-24(s0)
  return x;
       c:	fe843783          	ld	a5,-24(s0)
}
      10:	853e                	mv	a0,a5
      12:	6462                	ld	s0,24(sp)
      14:	6105                	addi	sp,sp,32
      16:	8082                	ret

0000000000000018 <copyin>:

// what if you pass ridiculous pointers to system calls
// that read user memory with copyin?
void
copyin(char *s)
{
      18:	715d                	addi	sp,sp,-80
      1a:	e486                	sd	ra,72(sp)
      1c:	e0a2                	sd	s0,64(sp)
      1e:	0880                	addi	s0,sp,80
      20:	faa43c23          	sd	a0,-72(s0)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
      24:	4785                	li	a5,1
      26:	07fe                	slli	a5,a5,0x1f
      28:	fcf43423          	sd	a5,-56(s0)
      2c:	57fd                	li	a5,-1
      2e:	fcf43823          	sd	a5,-48(s0)

  for(int ai = 0; ai < 2; ai++){
      32:	fe042623          	sw	zero,-20(s0)
      36:	a245                	j	1d6 <copyin+0x1be>
    uint64 addr = addrs[ai];
      38:	fec42783          	lw	a5,-20(s0)
      3c:	078e                	slli	a5,a5,0x3
      3e:	ff040713          	addi	a4,s0,-16
      42:	97ba                	add	a5,a5,a4
      44:	fd87b783          	ld	a5,-40(a5)
      48:	fef43023          	sd	a5,-32(s0)
    
    int fd = open("copyin1", O_CREATE|O_WRONLY);
      4c:	20100593          	li	a1,513
      50:	00008517          	auipc	a0,0x8
      54:	ec850513          	addi	a0,a0,-312 # 7f18 <malloc+0x4a0>
      58:	00007097          	auipc	ra,0x7
      5c:	330080e7          	jalr	816(ra) # 7388 <open>
      60:	87aa                	mv	a5,a0
      62:	fcf42e23          	sw	a5,-36(s0)
    if(fd < 0){
      66:	fdc42783          	lw	a5,-36(s0)
      6a:	2781                	sext.w	a5,a5
      6c:	0007df63          	bgez	a5,8a <copyin+0x72>
      printf("open(copyin1) failed\n");
      70:	00008517          	auipc	a0,0x8
      74:	eb050513          	addi	a0,a0,-336 # 7f20 <malloc+0x4a8>
      78:	00008097          	auipc	ra,0x8
      7c:	80e080e7          	jalr	-2034(ra) # 7886 <printf>
      exit(1);
      80:	4505                	li	a0,1
      82:	00007097          	auipc	ra,0x7
      86:	2c6080e7          	jalr	710(ra) # 7348 <exit>
    }
    int n = write(fd, (void*)addr, 8192);
      8a:	fe043703          	ld	a4,-32(s0)
      8e:	fdc42783          	lw	a5,-36(s0)
      92:	6609                	lui	a2,0x2
      94:	85ba                	mv	a1,a4
      96:	853e                	mv	a0,a5
      98:	00007097          	auipc	ra,0x7
      9c:	2d0080e7          	jalr	720(ra) # 7368 <write>
      a0:	87aa                	mv	a5,a0
      a2:	fcf42c23          	sw	a5,-40(s0)
    if(n >= 0){
      a6:	fd842783          	lw	a5,-40(s0)
      aa:	2781                	sext.w	a5,a5
      ac:	0207c463          	bltz	a5,d4 <copyin+0xbc>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
      b0:	fd842783          	lw	a5,-40(s0)
      b4:	863e                	mv	a2,a5
      b6:	fe043583          	ld	a1,-32(s0)
      ba:	00008517          	auipc	a0,0x8
      be:	e7e50513          	addi	a0,a0,-386 # 7f38 <malloc+0x4c0>
      c2:	00007097          	auipc	ra,0x7
      c6:	7c4080e7          	jalr	1988(ra) # 7886 <printf>
      exit(1);
      ca:	4505                	li	a0,1
      cc:	00007097          	auipc	ra,0x7
      d0:	27c080e7          	jalr	636(ra) # 7348 <exit>
    }
    close(fd);
      d4:	fdc42783          	lw	a5,-36(s0)
      d8:	853e                	mv	a0,a5
      da:	00007097          	auipc	ra,0x7
      de:	296080e7          	jalr	662(ra) # 7370 <close>
    unlink("copyin1");
      e2:	00008517          	auipc	a0,0x8
      e6:	e3650513          	addi	a0,a0,-458 # 7f18 <malloc+0x4a0>
      ea:	00007097          	auipc	ra,0x7
      ee:	2ae080e7          	jalr	686(ra) # 7398 <unlink>
    
    n = write(1, (char*)addr, 8192);
      f2:	fe043783          	ld	a5,-32(s0)
      f6:	6609                	lui	a2,0x2
      f8:	85be                	mv	a1,a5
      fa:	4505                	li	a0,1
      fc:	00007097          	auipc	ra,0x7
     100:	26c080e7          	jalr	620(ra) # 7368 <write>
     104:	87aa                	mv	a5,a0
     106:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     10a:	fd842783          	lw	a5,-40(s0)
     10e:	2781                	sext.w	a5,a5
     110:	02f05463          	blez	a5,138 <copyin+0x120>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     114:	fd842783          	lw	a5,-40(s0)
     118:	863e                	mv	a2,a5
     11a:	fe043583          	ld	a1,-32(s0)
     11e:	00008517          	auipc	a0,0x8
     122:	e4a50513          	addi	a0,a0,-438 # 7f68 <malloc+0x4f0>
     126:	00007097          	auipc	ra,0x7
     12a:	760080e7          	jalr	1888(ra) # 7886 <printf>
      exit(1);
     12e:	4505                	li	a0,1
     130:	00007097          	auipc	ra,0x7
     134:	218080e7          	jalr	536(ra) # 7348 <exit>
    }
    
    int fds[2];
    if(pipe(fds) < 0){
     138:	fc040793          	addi	a5,s0,-64
     13c:	853e                	mv	a0,a5
     13e:	00007097          	auipc	ra,0x7
     142:	21a080e7          	jalr	538(ra) # 7358 <pipe>
     146:	87aa                	mv	a5,a0
     148:	0007df63          	bgez	a5,166 <copyin+0x14e>
      printf("pipe() failed\n");
     14c:	00008517          	auipc	a0,0x8
     150:	e4c50513          	addi	a0,a0,-436 # 7f98 <malloc+0x520>
     154:	00007097          	auipc	ra,0x7
     158:	732080e7          	jalr	1842(ra) # 7886 <printf>
      exit(1);
     15c:	4505                	li	a0,1
     15e:	00007097          	auipc	ra,0x7
     162:	1ea080e7          	jalr	490(ra) # 7348 <exit>
    }
    n = write(fds[1], (char*)addr, 8192);
     166:	fc442783          	lw	a5,-60(s0)
     16a:	fe043703          	ld	a4,-32(s0)
     16e:	6609                	lui	a2,0x2
     170:	85ba                	mv	a1,a4
     172:	853e                	mv	a0,a5
     174:	00007097          	auipc	ra,0x7
     178:	1f4080e7          	jalr	500(ra) # 7368 <write>
     17c:	87aa                	mv	a5,a0
     17e:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     182:	fd842783          	lw	a5,-40(s0)
     186:	2781                	sext.w	a5,a5
     188:	02f05463          	blez	a5,1b0 <copyin+0x198>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     18c:	fd842783          	lw	a5,-40(s0)
     190:	863e                	mv	a2,a5
     192:	fe043583          	ld	a1,-32(s0)
     196:	00008517          	auipc	a0,0x8
     19a:	e1250513          	addi	a0,a0,-494 # 7fa8 <malloc+0x530>
     19e:	00007097          	auipc	ra,0x7
     1a2:	6e8080e7          	jalr	1768(ra) # 7886 <printf>
      exit(1);
     1a6:	4505                	li	a0,1
     1a8:	00007097          	auipc	ra,0x7
     1ac:	1a0080e7          	jalr	416(ra) # 7348 <exit>
    }
    close(fds[0]);
     1b0:	fc042783          	lw	a5,-64(s0)
     1b4:	853e                	mv	a0,a5
     1b6:	00007097          	auipc	ra,0x7
     1ba:	1ba080e7          	jalr	442(ra) # 7370 <close>
    close(fds[1]);
     1be:	fc442783          	lw	a5,-60(s0)
     1c2:	853e                	mv	a0,a5
     1c4:	00007097          	auipc	ra,0x7
     1c8:	1ac080e7          	jalr	428(ra) # 7370 <close>
  for(int ai = 0; ai < 2; ai++){
     1cc:	fec42783          	lw	a5,-20(s0)
     1d0:	2785                	addiw	a5,a5,1
     1d2:	fef42623          	sw	a5,-20(s0)
     1d6:	fec42783          	lw	a5,-20(s0)
     1da:	0007871b          	sext.w	a4,a5
     1de:	4785                	li	a5,1
     1e0:	e4e7dce3          	bge	a5,a4,38 <copyin+0x20>
  }
}
     1e4:	0001                	nop
     1e6:	0001                	nop
     1e8:	60a6                	ld	ra,72(sp)
     1ea:	6406                	ld	s0,64(sp)
     1ec:	6161                	addi	sp,sp,80
     1ee:	8082                	ret

00000000000001f0 <copyout>:

// what if you pass ridiculous pointers to system calls
// that write user memory with copyout?
void
copyout(char *s)
{
     1f0:	715d                	addi	sp,sp,-80
     1f2:	e486                	sd	ra,72(sp)
     1f4:	e0a2                	sd	s0,64(sp)
     1f6:	0880                	addi	s0,sp,80
     1f8:	faa43c23          	sd	a0,-72(s0)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     1fc:	4785                	li	a5,1
     1fe:	07fe                	slli	a5,a5,0x1f
     200:	fcf43423          	sd	a5,-56(s0)
     204:	57fd                	li	a5,-1
     206:	fcf43823          	sd	a5,-48(s0)

  for(int ai = 0; ai < 2; ai++){
     20a:	fe042623          	sw	zero,-20(s0)
     20e:	a279                	j	39c <copyout+0x1ac>
    uint64 addr = addrs[ai];
     210:	fec42783          	lw	a5,-20(s0)
     214:	078e                	slli	a5,a5,0x3
     216:	ff040713          	addi	a4,s0,-16
     21a:	97ba                	add	a5,a5,a4
     21c:	fd87b783          	ld	a5,-40(a5)
     220:	fef43023          	sd	a5,-32(s0)

    int fd = open("README", 0);
     224:	4581                	li	a1,0
     226:	00008517          	auipc	a0,0x8
     22a:	db250513          	addi	a0,a0,-590 # 7fd8 <malloc+0x560>
     22e:	00007097          	auipc	ra,0x7
     232:	15a080e7          	jalr	346(ra) # 7388 <open>
     236:	87aa                	mv	a5,a0
     238:	fcf42e23          	sw	a5,-36(s0)
    if(fd < 0){
     23c:	fdc42783          	lw	a5,-36(s0)
     240:	2781                	sext.w	a5,a5
     242:	0007df63          	bgez	a5,260 <copyout+0x70>
      printf("open(README) failed\n");
     246:	00008517          	auipc	a0,0x8
     24a:	d9a50513          	addi	a0,a0,-614 # 7fe0 <malloc+0x568>
     24e:	00007097          	auipc	ra,0x7
     252:	638080e7          	jalr	1592(ra) # 7886 <printf>
      exit(1);
     256:	4505                	li	a0,1
     258:	00007097          	auipc	ra,0x7
     25c:	0f0080e7          	jalr	240(ra) # 7348 <exit>
    }
    int n = read(fd, (void*)addr, 8192);
     260:	fe043703          	ld	a4,-32(s0)
     264:	fdc42783          	lw	a5,-36(s0)
     268:	6609                	lui	a2,0x2
     26a:	85ba                	mv	a1,a4
     26c:	853e                	mv	a0,a5
     26e:	00007097          	auipc	ra,0x7
     272:	0f2080e7          	jalr	242(ra) # 7360 <read>
     276:	87aa                	mv	a5,a0
     278:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     27c:	fd842783          	lw	a5,-40(s0)
     280:	2781                	sext.w	a5,a5
     282:	02f05463          	blez	a5,2aa <copyout+0xba>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     286:	fd842783          	lw	a5,-40(s0)
     28a:	863e                	mv	a2,a5
     28c:	fe043583          	ld	a1,-32(s0)
     290:	00008517          	auipc	a0,0x8
     294:	d6850513          	addi	a0,a0,-664 # 7ff8 <malloc+0x580>
     298:	00007097          	auipc	ra,0x7
     29c:	5ee080e7          	jalr	1518(ra) # 7886 <printf>
      exit(1);
     2a0:	4505                	li	a0,1
     2a2:	00007097          	auipc	ra,0x7
     2a6:	0a6080e7          	jalr	166(ra) # 7348 <exit>
    }
    close(fd);
     2aa:	fdc42783          	lw	a5,-36(s0)
     2ae:	853e                	mv	a0,a5
     2b0:	00007097          	auipc	ra,0x7
     2b4:	0c0080e7          	jalr	192(ra) # 7370 <close>

    int fds[2];
    if(pipe(fds) < 0){
     2b8:	fc040793          	addi	a5,s0,-64
     2bc:	853e                	mv	a0,a5
     2be:	00007097          	auipc	ra,0x7
     2c2:	09a080e7          	jalr	154(ra) # 7358 <pipe>
     2c6:	87aa                	mv	a5,a0
     2c8:	0007df63          	bgez	a5,2e6 <copyout+0xf6>
      printf("pipe() failed\n");
     2cc:	00008517          	auipc	a0,0x8
     2d0:	ccc50513          	addi	a0,a0,-820 # 7f98 <malloc+0x520>
     2d4:	00007097          	auipc	ra,0x7
     2d8:	5b2080e7          	jalr	1458(ra) # 7886 <printf>
      exit(1);
     2dc:	4505                	li	a0,1
     2de:	00007097          	auipc	ra,0x7
     2e2:	06a080e7          	jalr	106(ra) # 7348 <exit>
    }
    n = write(fds[1], "x", 1);
     2e6:	fc442783          	lw	a5,-60(s0)
     2ea:	4605                	li	a2,1
     2ec:	00008597          	auipc	a1,0x8
     2f0:	d3c58593          	addi	a1,a1,-708 # 8028 <malloc+0x5b0>
     2f4:	853e                	mv	a0,a5
     2f6:	00007097          	auipc	ra,0x7
     2fa:	072080e7          	jalr	114(ra) # 7368 <write>
     2fe:	87aa                	mv	a5,a0
     300:	fcf42c23          	sw	a5,-40(s0)
    if(n != 1){
     304:	fd842783          	lw	a5,-40(s0)
     308:	0007871b          	sext.w	a4,a5
     30c:	4785                	li	a5,1
     30e:	00f70f63          	beq	a4,a5,32c <copyout+0x13c>
      printf("pipe write failed\n");
     312:	00008517          	auipc	a0,0x8
     316:	d1e50513          	addi	a0,a0,-738 # 8030 <malloc+0x5b8>
     31a:	00007097          	auipc	ra,0x7
     31e:	56c080e7          	jalr	1388(ra) # 7886 <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00007097          	auipc	ra,0x7
     328:	024080e7          	jalr	36(ra) # 7348 <exit>
    }
    n = read(fds[0], (void*)addr, 8192);
     32c:	fc042783          	lw	a5,-64(s0)
     330:	fe043703          	ld	a4,-32(s0)
     334:	6609                	lui	a2,0x2
     336:	85ba                	mv	a1,a4
     338:	853e                	mv	a0,a5
     33a:	00007097          	auipc	ra,0x7
     33e:	026080e7          	jalr	38(ra) # 7360 <read>
     342:	87aa                	mv	a5,a0
     344:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     348:	fd842783          	lw	a5,-40(s0)
     34c:	2781                	sext.w	a5,a5
     34e:	02f05463          	blez	a5,376 <copyout+0x186>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     352:	fd842783          	lw	a5,-40(s0)
     356:	863e                	mv	a2,a5
     358:	fe043583          	ld	a1,-32(s0)
     35c:	00008517          	auipc	a0,0x8
     360:	cec50513          	addi	a0,a0,-788 # 8048 <malloc+0x5d0>
     364:	00007097          	auipc	ra,0x7
     368:	522080e7          	jalr	1314(ra) # 7886 <printf>
      exit(1);
     36c:	4505                	li	a0,1
     36e:	00007097          	auipc	ra,0x7
     372:	fda080e7          	jalr	-38(ra) # 7348 <exit>
    }
    close(fds[0]);
     376:	fc042783          	lw	a5,-64(s0)
     37a:	853e                	mv	a0,a5
     37c:	00007097          	auipc	ra,0x7
     380:	ff4080e7          	jalr	-12(ra) # 7370 <close>
    close(fds[1]);
     384:	fc442783          	lw	a5,-60(s0)
     388:	853e                	mv	a0,a5
     38a:	00007097          	auipc	ra,0x7
     38e:	fe6080e7          	jalr	-26(ra) # 7370 <close>
  for(int ai = 0; ai < 2; ai++){
     392:	fec42783          	lw	a5,-20(s0)
     396:	2785                	addiw	a5,a5,1
     398:	fef42623          	sw	a5,-20(s0)
     39c:	fec42783          	lw	a5,-20(s0)
     3a0:	0007871b          	sext.w	a4,a5
     3a4:	4785                	li	a5,1
     3a6:	e6e7d5e3          	bge	a5,a4,210 <copyout+0x20>
  }
}
     3aa:	0001                	nop
     3ac:	0001                	nop
     3ae:	60a6                	ld	ra,72(sp)
     3b0:	6406                	ld	s0,64(sp)
     3b2:	6161                	addi	sp,sp,80
     3b4:	8082                	ret

00000000000003b6 <copyinstr1>:

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
     3b6:	715d                	addi	sp,sp,-80
     3b8:	e486                	sd	ra,72(sp)
     3ba:	e0a2                	sd	s0,64(sp)
     3bc:	0880                	addi	s0,sp,80
     3be:	faa43c23          	sd	a0,-72(s0)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     3c2:	4785                	li	a5,1
     3c4:	07fe                	slli	a5,a5,0x1f
     3c6:	fcf43423          	sd	a5,-56(s0)
     3ca:	57fd                	li	a5,-1
     3cc:	fcf43823          	sd	a5,-48(s0)

  for(int ai = 0; ai < 2; ai++){
     3d0:	fe042623          	sw	zero,-20(s0)
     3d4:	a09d                	j	43a <copyinstr1+0x84>
    uint64 addr = addrs[ai];
     3d6:	fec42783          	lw	a5,-20(s0)
     3da:	078e                	slli	a5,a5,0x3
     3dc:	ff040713          	addi	a4,s0,-16
     3e0:	97ba                	add	a5,a5,a4
     3e2:	fd87b783          	ld	a5,-40(a5)
     3e6:	fef43023          	sd	a5,-32(s0)

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
     3ea:	fe043783          	ld	a5,-32(s0)
     3ee:	20100593          	li	a1,513
     3f2:	853e                	mv	a0,a5
     3f4:	00007097          	auipc	ra,0x7
     3f8:	f94080e7          	jalr	-108(ra) # 7388 <open>
     3fc:	87aa                	mv	a5,a0
     3fe:	fcf42e23          	sw	a5,-36(s0)
    if(fd >= 0){
     402:	fdc42783          	lw	a5,-36(s0)
     406:	2781                	sext.w	a5,a5
     408:	0207c463          	bltz	a5,430 <copyinstr1+0x7a>
      printf("open(%p) returned %d, not -1\n", addr, fd);
     40c:	fdc42783          	lw	a5,-36(s0)
     410:	863e                	mv	a2,a5
     412:	fe043583          	ld	a1,-32(s0)
     416:	00008517          	auipc	a0,0x8
     41a:	c6250513          	addi	a0,a0,-926 # 8078 <malloc+0x600>
     41e:	00007097          	auipc	ra,0x7
     422:	468080e7          	jalr	1128(ra) # 7886 <printf>
      exit(1);
     426:	4505                	li	a0,1
     428:	00007097          	auipc	ra,0x7
     42c:	f20080e7          	jalr	-224(ra) # 7348 <exit>
  for(int ai = 0; ai < 2; ai++){
     430:	fec42783          	lw	a5,-20(s0)
     434:	2785                	addiw	a5,a5,1
     436:	fef42623          	sw	a5,-20(s0)
     43a:	fec42783          	lw	a5,-20(s0)
     43e:	0007871b          	sext.w	a4,a5
     442:	4785                	li	a5,1
     444:	f8e7d9e3          	bge	a5,a4,3d6 <copyinstr1+0x20>
    }
  }
}
     448:	0001                	nop
     44a:	0001                	nop
     44c:	60a6                	ld	ra,72(sp)
     44e:	6406                	ld	s0,64(sp)
     450:	6161                	addi	sp,sp,80
     452:	8082                	ret

0000000000000454 <copyinstr2>:
// what if a string system call argument is exactly the size
// of the kernel buffer it is copied into, so that the null
// would fall just beyond the end of the kernel buffer?
void
copyinstr2(char *s)
{
     454:	7151                	addi	sp,sp,-240
     456:	f586                	sd	ra,232(sp)
     458:	f1a2                	sd	s0,224(sp)
     45a:	1980                	addi	s0,sp,240
     45c:	f0a43c23          	sd	a0,-232(s0)
  char b[MAXPATH+1];

  for(int i = 0; i < MAXPATH; i++)
     460:	fe042623          	sw	zero,-20(s0)
     464:	a839                	j	482 <copyinstr2+0x2e>
    b[i] = 'x';
     466:	fec42783          	lw	a5,-20(s0)
     46a:	ff040713          	addi	a4,s0,-16
     46e:	97ba                	add	a5,a5,a4
     470:	07800713          	li	a4,120
     474:	f6e78423          	sb	a4,-152(a5)
  for(int i = 0; i < MAXPATH; i++)
     478:	fec42783          	lw	a5,-20(s0)
     47c:	2785                	addiw	a5,a5,1
     47e:	fef42623          	sw	a5,-20(s0)
     482:	fec42783          	lw	a5,-20(s0)
     486:	0007871b          	sext.w	a4,a5
     48a:	07f00793          	li	a5,127
     48e:	fce7dce3          	bge	a5,a4,466 <copyinstr2+0x12>
  b[MAXPATH] = '\0';
     492:	fc040c23          	sb	zero,-40(s0)
  
  int ret = unlink(b);
     496:	f5840793          	addi	a5,s0,-168
     49a:	853e                	mv	a0,a5
     49c:	00007097          	auipc	ra,0x7
     4a0:	efc080e7          	jalr	-260(ra) # 7398 <unlink>
     4a4:	87aa                	mv	a5,a0
     4a6:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     4aa:	fe442783          	lw	a5,-28(s0)
     4ae:	0007871b          	sext.w	a4,a5
     4b2:	57fd                	li	a5,-1
     4b4:	02f70563          	beq	a4,a5,4de <copyinstr2+0x8a>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
     4b8:	fe442703          	lw	a4,-28(s0)
     4bc:	f5840793          	addi	a5,s0,-168
     4c0:	863a                	mv	a2,a4
     4c2:	85be                	mv	a1,a5
     4c4:	00008517          	auipc	a0,0x8
     4c8:	bd450513          	addi	a0,a0,-1068 # 8098 <malloc+0x620>
     4cc:	00007097          	auipc	ra,0x7
     4d0:	3ba080e7          	jalr	954(ra) # 7886 <printf>
    exit(1);
     4d4:	4505                	li	a0,1
     4d6:	00007097          	auipc	ra,0x7
     4da:	e72080e7          	jalr	-398(ra) # 7348 <exit>
  }

  int fd = open(b, O_CREATE | O_WRONLY);
     4de:	f5840793          	addi	a5,s0,-168
     4e2:	20100593          	li	a1,513
     4e6:	853e                	mv	a0,a5
     4e8:	00007097          	auipc	ra,0x7
     4ec:	ea0080e7          	jalr	-352(ra) # 7388 <open>
     4f0:	87aa                	mv	a5,a0
     4f2:	fef42023          	sw	a5,-32(s0)
  if(fd != -1){
     4f6:	fe042783          	lw	a5,-32(s0)
     4fa:	0007871b          	sext.w	a4,a5
     4fe:	57fd                	li	a5,-1
     500:	02f70563          	beq	a4,a5,52a <copyinstr2+0xd6>
    printf("open(%s) returned %d, not -1\n", b, fd);
     504:	fe042703          	lw	a4,-32(s0)
     508:	f5840793          	addi	a5,s0,-168
     50c:	863a                	mv	a2,a4
     50e:	85be                	mv	a1,a5
     510:	00008517          	auipc	a0,0x8
     514:	ba850513          	addi	a0,a0,-1112 # 80b8 <malloc+0x640>
     518:	00007097          	auipc	ra,0x7
     51c:	36e080e7          	jalr	878(ra) # 7886 <printf>
    exit(1);
     520:	4505                	li	a0,1
     522:	00007097          	auipc	ra,0x7
     526:	e26080e7          	jalr	-474(ra) # 7348 <exit>
  }

  ret = link(b, b);
     52a:	f5840713          	addi	a4,s0,-168
     52e:	f5840793          	addi	a5,s0,-168
     532:	85ba                	mv	a1,a4
     534:	853e                	mv	a0,a5
     536:	00007097          	auipc	ra,0x7
     53a:	e72080e7          	jalr	-398(ra) # 73a8 <link>
     53e:	87aa                	mv	a5,a0
     540:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     544:	fe442783          	lw	a5,-28(s0)
     548:	0007871b          	sext.w	a4,a5
     54c:	57fd                	li	a5,-1
     54e:	02f70763          	beq	a4,a5,57c <copyinstr2+0x128>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
     552:	fe442683          	lw	a3,-28(s0)
     556:	f5840713          	addi	a4,s0,-168
     55a:	f5840793          	addi	a5,s0,-168
     55e:	863a                	mv	a2,a4
     560:	85be                	mv	a1,a5
     562:	00008517          	auipc	a0,0x8
     566:	b7650513          	addi	a0,a0,-1162 # 80d8 <malloc+0x660>
     56a:	00007097          	auipc	ra,0x7
     56e:	31c080e7          	jalr	796(ra) # 7886 <printf>
    exit(1);
     572:	4505                	li	a0,1
     574:	00007097          	auipc	ra,0x7
     578:	dd4080e7          	jalr	-556(ra) # 7348 <exit>
  }

  char *args[] = { "xx", 0 };
     57c:	00008797          	auipc	a5,0x8
     580:	b8478793          	addi	a5,a5,-1148 # 8100 <malloc+0x688>
     584:	f4f43423          	sd	a5,-184(s0)
     588:	f4043823          	sd	zero,-176(s0)
  ret = exec(b, args);
     58c:	f4840713          	addi	a4,s0,-184
     590:	f5840793          	addi	a5,s0,-168
     594:	85ba                	mv	a1,a4
     596:	853e                	mv	a0,a5
     598:	00007097          	auipc	ra,0x7
     59c:	de8080e7          	jalr	-536(ra) # 7380 <exec>
     5a0:	87aa                	mv	a5,a0
     5a2:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     5a6:	fe442783          	lw	a5,-28(s0)
     5aa:	0007871b          	sext.w	a4,a5
     5ae:	57fd                	li	a5,-1
     5b0:	02f70563          	beq	a4,a5,5da <copyinstr2+0x186>
    printf("exec(%s) returned %d, not -1\n", b, fd);
     5b4:	fe042703          	lw	a4,-32(s0)
     5b8:	f5840793          	addi	a5,s0,-168
     5bc:	863a                	mv	a2,a4
     5be:	85be                	mv	a1,a5
     5c0:	00008517          	auipc	a0,0x8
     5c4:	b4850513          	addi	a0,a0,-1208 # 8108 <malloc+0x690>
     5c8:	00007097          	auipc	ra,0x7
     5cc:	2be080e7          	jalr	702(ra) # 7886 <printf>
    exit(1);
     5d0:	4505                	li	a0,1
     5d2:	00007097          	auipc	ra,0x7
     5d6:	d76080e7          	jalr	-650(ra) # 7348 <exit>
  }

  int pid = fork();
     5da:	00007097          	auipc	ra,0x7
     5de:	d66080e7          	jalr	-666(ra) # 7340 <fork>
     5e2:	87aa                	mv	a5,a0
     5e4:	fcf42e23          	sw	a5,-36(s0)
  if(pid < 0){
     5e8:	fdc42783          	lw	a5,-36(s0)
     5ec:	2781                	sext.w	a5,a5
     5ee:	0007df63          	bgez	a5,60c <copyinstr2+0x1b8>
    printf("fork failed\n");
     5f2:	00008517          	auipc	a0,0x8
     5f6:	b3650513          	addi	a0,a0,-1226 # 8128 <malloc+0x6b0>
     5fa:	00007097          	auipc	ra,0x7
     5fe:	28c080e7          	jalr	652(ra) # 7886 <printf>
    exit(1);
     602:	4505                	li	a0,1
     604:	00007097          	auipc	ra,0x7
     608:	d44080e7          	jalr	-700(ra) # 7348 <exit>
  }
  if(pid == 0){
     60c:	fdc42783          	lw	a5,-36(s0)
     610:	2781                	sext.w	a5,a5
     612:	efd5                	bnez	a5,6ce <copyinstr2+0x27a>
    static char big[PGSIZE+1];
    for(int i = 0; i < PGSIZE; i++)
     614:	fe042423          	sw	zero,-24(s0)
     618:	a00d                	j	63a <copyinstr2+0x1e6>
      big[i] = 'x';
     61a:	0000f717          	auipc	a4,0xf
     61e:	50670713          	addi	a4,a4,1286 # fb20 <big.0>
     622:	fe842783          	lw	a5,-24(s0)
     626:	97ba                	add	a5,a5,a4
     628:	07800713          	li	a4,120
     62c:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
     630:	fe842783          	lw	a5,-24(s0)
     634:	2785                	addiw	a5,a5,1
     636:	fef42423          	sw	a5,-24(s0)
     63a:	fe842783          	lw	a5,-24(s0)
     63e:	0007871b          	sext.w	a4,a5
     642:	6785                	lui	a5,0x1
     644:	fcf74be3          	blt	a4,a5,61a <copyinstr2+0x1c6>
    big[PGSIZE] = '\0';
     648:	0000f717          	auipc	a4,0xf
     64c:	4d870713          	addi	a4,a4,1240 # fb20 <big.0>
     650:	6785                	lui	a5,0x1
     652:	97ba                	add	a5,a5,a4
     654:	00078023          	sb	zero,0(a5) # 1000 <truncate3+0x1aa>
    char *args2[] = { big, big, big, 0 };
     658:	00008797          	auipc	a5,0x8
     65c:	b4078793          	addi	a5,a5,-1216 # 8198 <malloc+0x720>
     660:	6390                	ld	a2,0(a5)
     662:	6794                	ld	a3,8(a5)
     664:	6b98                	ld	a4,16(a5)
     666:	6f9c                	ld	a5,24(a5)
     668:	f2c43023          	sd	a2,-224(s0)
     66c:	f2d43423          	sd	a3,-216(s0)
     670:	f2e43823          	sd	a4,-208(s0)
     674:	f2f43c23          	sd	a5,-200(s0)
    ret = exec("echo", args2);
     678:	f2040793          	addi	a5,s0,-224
     67c:	85be                	mv	a1,a5
     67e:	00008517          	auipc	a0,0x8
     682:	aba50513          	addi	a0,a0,-1350 # 8138 <malloc+0x6c0>
     686:	00007097          	auipc	ra,0x7
     68a:	cfa080e7          	jalr	-774(ra) # 7380 <exec>
     68e:	87aa                	mv	a5,a0
     690:	fef42223          	sw	a5,-28(s0)
    if(ret != -1){
     694:	fe442783          	lw	a5,-28(s0)
     698:	0007871b          	sext.w	a4,a5
     69c:	57fd                	li	a5,-1
     69e:	02f70263          	beq	a4,a5,6c2 <copyinstr2+0x26e>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
     6a2:	fe042783          	lw	a5,-32(s0)
     6a6:	85be                	mv	a1,a5
     6a8:	00008517          	auipc	a0,0x8
     6ac:	a9850513          	addi	a0,a0,-1384 # 8140 <malloc+0x6c8>
     6b0:	00007097          	auipc	ra,0x7
     6b4:	1d6080e7          	jalr	470(ra) # 7886 <printf>
      exit(1);
     6b8:	4505                	li	a0,1
     6ba:	00007097          	auipc	ra,0x7
     6be:	c8e080e7          	jalr	-882(ra) # 7348 <exit>
    }
    exit(747); // OK
     6c2:	2eb00513          	li	a0,747
     6c6:	00007097          	auipc	ra,0x7
     6ca:	c82080e7          	jalr	-894(ra) # 7348 <exit>
  }

  int st = 0;
     6ce:	f4042223          	sw	zero,-188(s0)
  wait(&st);
     6d2:	f4440793          	addi	a5,s0,-188
     6d6:	853e                	mv	a0,a5
     6d8:	00007097          	auipc	ra,0x7
     6dc:	c78080e7          	jalr	-904(ra) # 7350 <wait>
  if(st != 747){
     6e0:	f4442783          	lw	a5,-188(s0)
     6e4:	873e                	mv	a4,a5
     6e6:	2eb00793          	li	a5,747
     6ea:	00f70f63          	beq	a4,a5,708 <copyinstr2+0x2b4>
    printf("exec(echo, BIG) succeeded, should have failed\n");
     6ee:	00008517          	auipc	a0,0x8
     6f2:	a7a50513          	addi	a0,a0,-1414 # 8168 <malloc+0x6f0>
     6f6:	00007097          	auipc	ra,0x7
     6fa:	190080e7          	jalr	400(ra) # 7886 <printf>
    exit(1);
     6fe:	4505                	li	a0,1
     700:	00007097          	auipc	ra,0x7
     704:	c48080e7          	jalr	-952(ra) # 7348 <exit>
  }
}
     708:	0001                	nop
     70a:	70ae                	ld	ra,232(sp)
     70c:	740e                	ld	s0,224(sp)
     70e:	616d                	addi	sp,sp,240
     710:	8082                	ret

0000000000000712 <copyinstr3>:

// what if a string argument crosses over the end of last user page?
void
copyinstr3(char *s)
{
     712:	715d                	addi	sp,sp,-80
     714:	e486                	sd	ra,72(sp)
     716:	e0a2                	sd	s0,64(sp)
     718:	0880                	addi	s0,sp,80
     71a:	faa43c23          	sd	a0,-72(s0)
  sbrk(8192);
     71e:	6509                	lui	a0,0x2
     720:	00007097          	auipc	ra,0x7
     724:	cb0080e7          	jalr	-848(ra) # 73d0 <sbrk>
  uint64 top = (uint64) sbrk(0);
     728:	4501                	li	a0,0
     72a:	00007097          	auipc	ra,0x7
     72e:	ca6080e7          	jalr	-858(ra) # 73d0 <sbrk>
     732:	87aa                	mv	a5,a0
     734:	fef43423          	sd	a5,-24(s0)
  if((top % PGSIZE) != 0){
     738:	fe843703          	ld	a4,-24(s0)
     73c:	6785                	lui	a5,0x1
     73e:	17fd                	addi	a5,a5,-1
     740:	8ff9                	and	a5,a5,a4
     742:	c39d                	beqz	a5,768 <copyinstr3+0x56>
    sbrk(PGSIZE - (top % PGSIZE));
     744:	fe843783          	ld	a5,-24(s0)
     748:	2781                	sext.w	a5,a5
     74a:	873e                	mv	a4,a5
     74c:	6785                	lui	a5,0x1
     74e:	17fd                	addi	a5,a5,-1
     750:	8ff9                	and	a5,a5,a4
     752:	2781                	sext.w	a5,a5
     754:	6705                	lui	a4,0x1
     756:	40f707bb          	subw	a5,a4,a5
     75a:	2781                	sext.w	a5,a5
     75c:	2781                	sext.w	a5,a5
     75e:	853e                	mv	a0,a5
     760:	00007097          	auipc	ra,0x7
     764:	c70080e7          	jalr	-912(ra) # 73d0 <sbrk>
  }
  top = (uint64) sbrk(0);
     768:	4501                	li	a0,0
     76a:	00007097          	auipc	ra,0x7
     76e:	c66080e7          	jalr	-922(ra) # 73d0 <sbrk>
     772:	87aa                	mv	a5,a0
     774:	fef43423          	sd	a5,-24(s0)
  if(top % PGSIZE){
     778:	fe843703          	ld	a4,-24(s0)
     77c:	6785                	lui	a5,0x1
     77e:	17fd                	addi	a5,a5,-1
     780:	8ff9                	and	a5,a5,a4
     782:	cf91                	beqz	a5,79e <copyinstr3+0x8c>
    printf("oops\n");
     784:	00008517          	auipc	a0,0x8
     788:	a3450513          	addi	a0,a0,-1484 # 81b8 <malloc+0x740>
     78c:	00007097          	auipc	ra,0x7
     790:	0fa080e7          	jalr	250(ra) # 7886 <printf>
    exit(1);
     794:	4505                	li	a0,1
     796:	00007097          	auipc	ra,0x7
     79a:	bb2080e7          	jalr	-1102(ra) # 7348 <exit>
  }

  char *b = (char *) (top - 1);
     79e:	fe843783          	ld	a5,-24(s0)
     7a2:	17fd                	addi	a5,a5,-1
     7a4:	fef43023          	sd	a5,-32(s0)
  *b = 'x';
     7a8:	fe043783          	ld	a5,-32(s0)
     7ac:	07800713          	li	a4,120
     7b0:	00e78023          	sb	a4,0(a5) # 1000 <truncate3+0x1aa>

  int ret = unlink(b);
     7b4:	fe043503          	ld	a0,-32(s0)
     7b8:	00007097          	auipc	ra,0x7
     7bc:	be0080e7          	jalr	-1056(ra) # 7398 <unlink>
     7c0:	87aa                	mv	a5,a0
     7c2:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     7c6:	fdc42783          	lw	a5,-36(s0)
     7ca:	0007871b          	sext.w	a4,a5
     7ce:	57fd                	li	a5,-1
     7d0:	02f70463          	beq	a4,a5,7f8 <copyinstr3+0xe6>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
     7d4:	fdc42783          	lw	a5,-36(s0)
     7d8:	863e                	mv	a2,a5
     7da:	fe043583          	ld	a1,-32(s0)
     7de:	00008517          	auipc	a0,0x8
     7e2:	8ba50513          	addi	a0,a0,-1862 # 8098 <malloc+0x620>
     7e6:	00007097          	auipc	ra,0x7
     7ea:	0a0080e7          	jalr	160(ra) # 7886 <printf>
    exit(1);
     7ee:	4505                	li	a0,1
     7f0:	00007097          	auipc	ra,0x7
     7f4:	b58080e7          	jalr	-1192(ra) # 7348 <exit>
  }

  int fd = open(b, O_CREATE | O_WRONLY);
     7f8:	20100593          	li	a1,513
     7fc:	fe043503          	ld	a0,-32(s0)
     800:	00007097          	auipc	ra,0x7
     804:	b88080e7          	jalr	-1144(ra) # 7388 <open>
     808:	87aa                	mv	a5,a0
     80a:	fcf42c23          	sw	a5,-40(s0)
  if(fd != -1){
     80e:	fd842783          	lw	a5,-40(s0)
     812:	0007871b          	sext.w	a4,a5
     816:	57fd                	li	a5,-1
     818:	02f70463          	beq	a4,a5,840 <copyinstr3+0x12e>
    printf("open(%s) returned %d, not -1\n", b, fd);
     81c:	fd842783          	lw	a5,-40(s0)
     820:	863e                	mv	a2,a5
     822:	fe043583          	ld	a1,-32(s0)
     826:	00008517          	auipc	a0,0x8
     82a:	89250513          	addi	a0,a0,-1902 # 80b8 <malloc+0x640>
     82e:	00007097          	auipc	ra,0x7
     832:	058080e7          	jalr	88(ra) # 7886 <printf>
    exit(1);
     836:	4505                	li	a0,1
     838:	00007097          	auipc	ra,0x7
     83c:	b10080e7          	jalr	-1264(ra) # 7348 <exit>
  }

  ret = link(b, b);
     840:	fe043583          	ld	a1,-32(s0)
     844:	fe043503          	ld	a0,-32(s0)
     848:	00007097          	auipc	ra,0x7
     84c:	b60080e7          	jalr	-1184(ra) # 73a8 <link>
     850:	87aa                	mv	a5,a0
     852:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     856:	fdc42783          	lw	a5,-36(s0)
     85a:	0007871b          	sext.w	a4,a5
     85e:	57fd                	li	a5,-1
     860:	02f70663          	beq	a4,a5,88c <copyinstr3+0x17a>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
     864:	fdc42783          	lw	a5,-36(s0)
     868:	86be                	mv	a3,a5
     86a:	fe043603          	ld	a2,-32(s0)
     86e:	fe043583          	ld	a1,-32(s0)
     872:	00008517          	auipc	a0,0x8
     876:	86650513          	addi	a0,a0,-1946 # 80d8 <malloc+0x660>
     87a:	00007097          	auipc	ra,0x7
     87e:	00c080e7          	jalr	12(ra) # 7886 <printf>
    exit(1);
     882:	4505                	li	a0,1
     884:	00007097          	auipc	ra,0x7
     888:	ac4080e7          	jalr	-1340(ra) # 7348 <exit>
  }

  char *args[] = { "xx", 0 };
     88c:	00008797          	auipc	a5,0x8
     890:	87478793          	addi	a5,a5,-1932 # 8100 <malloc+0x688>
     894:	fcf43423          	sd	a5,-56(s0)
     898:	fc043823          	sd	zero,-48(s0)
  ret = exec(b, args);
     89c:	fc840793          	addi	a5,s0,-56
     8a0:	85be                	mv	a1,a5
     8a2:	fe043503          	ld	a0,-32(s0)
     8a6:	00007097          	auipc	ra,0x7
     8aa:	ada080e7          	jalr	-1318(ra) # 7380 <exec>
     8ae:	87aa                	mv	a5,a0
     8b0:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     8b4:	fdc42783          	lw	a5,-36(s0)
     8b8:	0007871b          	sext.w	a4,a5
     8bc:	57fd                	li	a5,-1
     8be:	02f70463          	beq	a4,a5,8e6 <copyinstr3+0x1d4>
    printf("exec(%s) returned %d, not -1\n", b, fd);
     8c2:	fd842783          	lw	a5,-40(s0)
     8c6:	863e                	mv	a2,a5
     8c8:	fe043583          	ld	a1,-32(s0)
     8cc:	00008517          	auipc	a0,0x8
     8d0:	83c50513          	addi	a0,a0,-1988 # 8108 <malloc+0x690>
     8d4:	00007097          	auipc	ra,0x7
     8d8:	fb2080e7          	jalr	-78(ra) # 7886 <printf>
    exit(1);
     8dc:	4505                	li	a0,1
     8de:	00007097          	auipc	ra,0x7
     8e2:	a6a080e7          	jalr	-1430(ra) # 7348 <exit>
  }
}
     8e6:	0001                	nop
     8e8:	60a6                	ld	ra,72(sp)
     8ea:	6406                	ld	s0,64(sp)
     8ec:	6161                	addi	sp,sp,80
     8ee:	8082                	ret

00000000000008f0 <rwsbrk>:

// See if the kernel refuses to read/write user memory that the
// application doesn't have anymore, because it returned it.
void
rwsbrk()
{
     8f0:	1101                	addi	sp,sp,-32
     8f2:	ec06                	sd	ra,24(sp)
     8f4:	e822                	sd	s0,16(sp)
     8f6:	1000                	addi	s0,sp,32
  int fd, n;
  
  uint64 a = (uint64) sbrk(8192);
     8f8:	6509                	lui	a0,0x2
     8fa:	00007097          	auipc	ra,0x7
     8fe:	ad6080e7          	jalr	-1322(ra) # 73d0 <sbrk>
     902:	87aa                	mv	a5,a0
     904:	fef43423          	sd	a5,-24(s0)

  if(a == 0xffffffffffffffffLL) {
     908:	fe843703          	ld	a4,-24(s0)
     90c:	57fd                	li	a5,-1
     90e:	00f71f63          	bne	a4,a5,92c <rwsbrk+0x3c>
    printf("sbrk(rwsbrk) failed\n");
     912:	00008517          	auipc	a0,0x8
     916:	8ae50513          	addi	a0,a0,-1874 # 81c0 <malloc+0x748>
     91a:	00007097          	auipc	ra,0x7
     91e:	f6c080e7          	jalr	-148(ra) # 7886 <printf>
    exit(1);
     922:	4505                	li	a0,1
     924:	00007097          	auipc	ra,0x7
     928:	a24080e7          	jalr	-1500(ra) # 7348 <exit>
  }
  
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
     92c:	7579                	lui	a0,0xffffe
     92e:	00007097          	auipc	ra,0x7
     932:	aa2080e7          	jalr	-1374(ra) # 73d0 <sbrk>
     936:	872a                	mv	a4,a0
     938:	57fd                	li	a5,-1
     93a:	00f71f63          	bne	a4,a5,958 <rwsbrk+0x68>
    printf("sbrk(rwsbrk) shrink failed\n");
     93e:	00008517          	auipc	a0,0x8
     942:	89a50513          	addi	a0,a0,-1894 # 81d8 <malloc+0x760>
     946:	00007097          	auipc	ra,0x7
     94a:	f40080e7          	jalr	-192(ra) # 7886 <printf>
    exit(1);
     94e:	4505                	li	a0,1
     950:	00007097          	auipc	ra,0x7
     954:	9f8080e7          	jalr	-1544(ra) # 7348 <exit>
  }

  fd = open("rwsbrk", O_CREATE|O_WRONLY);
     958:	20100593          	li	a1,513
     95c:	00007517          	auipc	a0,0x7
     960:	2e450513          	addi	a0,a0,740 # 7c40 <malloc+0x1c8>
     964:	00007097          	auipc	ra,0x7
     968:	a24080e7          	jalr	-1500(ra) # 7388 <open>
     96c:	87aa                	mv	a5,a0
     96e:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
     972:	fe442783          	lw	a5,-28(s0)
     976:	2781                	sext.w	a5,a5
     978:	0007df63          	bgez	a5,996 <rwsbrk+0xa6>
    printf("open(rwsbrk) failed\n");
     97c:	00008517          	auipc	a0,0x8
     980:	87c50513          	addi	a0,a0,-1924 # 81f8 <malloc+0x780>
     984:	00007097          	auipc	ra,0x7
     988:	f02080e7          	jalr	-254(ra) # 7886 <printf>
    exit(1);
     98c:	4505                	li	a0,1
     98e:	00007097          	auipc	ra,0x7
     992:	9ba080e7          	jalr	-1606(ra) # 7348 <exit>
  }
  n = write(fd, (void*)(a+4096), 1024);
     996:	fe843703          	ld	a4,-24(s0)
     99a:	6785                	lui	a5,0x1
     99c:	97ba                	add	a5,a5,a4
     99e:	873e                	mv	a4,a5
     9a0:	fe442783          	lw	a5,-28(s0)
     9a4:	40000613          	li	a2,1024
     9a8:	85ba                	mv	a1,a4
     9aa:	853e                	mv	a0,a5
     9ac:	00007097          	auipc	ra,0x7
     9b0:	9bc080e7          	jalr	-1604(ra) # 7368 <write>
     9b4:	87aa                	mv	a5,a0
     9b6:	fef42023          	sw	a5,-32(s0)
  if(n >= 0){
     9ba:	fe042783          	lw	a5,-32(s0)
     9be:	2781                	sext.w	a5,a5
     9c0:	0207c763          	bltz	a5,9ee <rwsbrk+0xfe>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
     9c4:	fe843703          	ld	a4,-24(s0)
     9c8:	6785                	lui	a5,0x1
     9ca:	97ba                	add	a5,a5,a4
     9cc:	fe042703          	lw	a4,-32(s0)
     9d0:	863a                	mv	a2,a4
     9d2:	85be                	mv	a1,a5
     9d4:	00008517          	auipc	a0,0x8
     9d8:	83c50513          	addi	a0,a0,-1988 # 8210 <malloc+0x798>
     9dc:	00007097          	auipc	ra,0x7
     9e0:	eaa080e7          	jalr	-342(ra) # 7886 <printf>
    exit(1);
     9e4:	4505                	li	a0,1
     9e6:	00007097          	auipc	ra,0x7
     9ea:	962080e7          	jalr	-1694(ra) # 7348 <exit>
  }
  close(fd);
     9ee:	fe442783          	lw	a5,-28(s0)
     9f2:	853e                	mv	a0,a5
     9f4:	00007097          	auipc	ra,0x7
     9f8:	97c080e7          	jalr	-1668(ra) # 7370 <close>
  unlink("rwsbrk");
     9fc:	00007517          	auipc	a0,0x7
     a00:	24450513          	addi	a0,a0,580 # 7c40 <malloc+0x1c8>
     a04:	00007097          	auipc	ra,0x7
     a08:	994080e7          	jalr	-1644(ra) # 7398 <unlink>

  fd = open("README", O_RDONLY);
     a0c:	4581                	li	a1,0
     a0e:	00007517          	auipc	a0,0x7
     a12:	5ca50513          	addi	a0,a0,1482 # 7fd8 <malloc+0x560>
     a16:	00007097          	auipc	ra,0x7
     a1a:	972080e7          	jalr	-1678(ra) # 7388 <open>
     a1e:	87aa                	mv	a5,a0
     a20:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
     a24:	fe442783          	lw	a5,-28(s0)
     a28:	2781                	sext.w	a5,a5
     a2a:	0007df63          	bgez	a5,a48 <rwsbrk+0x158>
    printf("open(rwsbrk) failed\n");
     a2e:	00007517          	auipc	a0,0x7
     a32:	7ca50513          	addi	a0,a0,1994 # 81f8 <malloc+0x780>
     a36:	00007097          	auipc	ra,0x7
     a3a:	e50080e7          	jalr	-432(ra) # 7886 <printf>
    exit(1);
     a3e:	4505                	li	a0,1
     a40:	00007097          	auipc	ra,0x7
     a44:	908080e7          	jalr	-1784(ra) # 7348 <exit>
  }
  n = read(fd, (void*)(a+4096), 10);
     a48:	fe843703          	ld	a4,-24(s0)
     a4c:	6785                	lui	a5,0x1
     a4e:	97ba                	add	a5,a5,a4
     a50:	873e                	mv	a4,a5
     a52:	fe442783          	lw	a5,-28(s0)
     a56:	4629                	li	a2,10
     a58:	85ba                	mv	a1,a4
     a5a:	853e                	mv	a0,a5
     a5c:	00007097          	auipc	ra,0x7
     a60:	904080e7          	jalr	-1788(ra) # 7360 <read>
     a64:	87aa                	mv	a5,a0
     a66:	fef42023          	sw	a5,-32(s0)
  if(n >= 0){
     a6a:	fe042783          	lw	a5,-32(s0)
     a6e:	2781                	sext.w	a5,a5
     a70:	0207c763          	bltz	a5,a9e <rwsbrk+0x1ae>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
     a74:	fe843703          	ld	a4,-24(s0)
     a78:	6785                	lui	a5,0x1
     a7a:	97ba                	add	a5,a5,a4
     a7c:	fe042703          	lw	a4,-32(s0)
     a80:	863a                	mv	a2,a4
     a82:	85be                	mv	a1,a5
     a84:	00007517          	auipc	a0,0x7
     a88:	7bc50513          	addi	a0,a0,1980 # 8240 <malloc+0x7c8>
     a8c:	00007097          	auipc	ra,0x7
     a90:	dfa080e7          	jalr	-518(ra) # 7886 <printf>
    exit(1);
     a94:	4505                	li	a0,1
     a96:	00007097          	auipc	ra,0x7
     a9a:	8b2080e7          	jalr	-1870(ra) # 7348 <exit>
  }
  close(fd);
     a9e:	fe442783          	lw	a5,-28(s0)
     aa2:	853e                	mv	a0,a5
     aa4:	00007097          	auipc	ra,0x7
     aa8:	8cc080e7          	jalr	-1844(ra) # 7370 <close>
  
  exit(0);
     aac:	4501                	li	a0,0
     aae:	00007097          	auipc	ra,0x7
     ab2:	89a080e7          	jalr	-1894(ra) # 7348 <exit>

0000000000000ab6 <truncate1>:
}

// test O_TRUNC.
void
truncate1(char *s)
{
     ab6:	715d                	addi	sp,sp,-80
     ab8:	e486                	sd	ra,72(sp)
     aba:	e0a2                	sd	s0,64(sp)
     abc:	0880                	addi	s0,sp,80
     abe:	faa43c23          	sd	a0,-72(s0)
  char buf[32];
  
  unlink("truncfile");
     ac2:	00007517          	auipc	a0,0x7
     ac6:	7a650513          	addi	a0,a0,1958 # 8268 <malloc+0x7f0>
     aca:	00007097          	auipc	ra,0x7
     ace:	8ce080e7          	jalr	-1842(ra) # 7398 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     ad2:	60100593          	li	a1,1537
     ad6:	00007517          	auipc	a0,0x7
     ada:	79250513          	addi	a0,a0,1938 # 8268 <malloc+0x7f0>
     ade:	00007097          	auipc	ra,0x7
     ae2:	8aa080e7          	jalr	-1878(ra) # 7388 <open>
     ae6:	87aa                	mv	a5,a0
     ae8:	fef42623          	sw	a5,-20(s0)
  write(fd1, "abcd", 4);
     aec:	fec42783          	lw	a5,-20(s0)
     af0:	4611                	li	a2,4
     af2:	00007597          	auipc	a1,0x7
     af6:	78658593          	addi	a1,a1,1926 # 8278 <malloc+0x800>
     afa:	853e                	mv	a0,a5
     afc:	00007097          	auipc	ra,0x7
     b00:	86c080e7          	jalr	-1940(ra) # 7368 <write>
  close(fd1);
     b04:	fec42783          	lw	a5,-20(s0)
     b08:	853e                	mv	a0,a5
     b0a:	00007097          	auipc	ra,0x7
     b0e:	866080e7          	jalr	-1946(ra) # 7370 <close>

  int fd2 = open("truncfile", O_RDONLY);
     b12:	4581                	li	a1,0
     b14:	00007517          	auipc	a0,0x7
     b18:	75450513          	addi	a0,a0,1876 # 8268 <malloc+0x7f0>
     b1c:	00007097          	auipc	ra,0x7
     b20:	86c080e7          	jalr	-1940(ra) # 7388 <open>
     b24:	87aa                	mv	a5,a0
     b26:	fef42423          	sw	a5,-24(s0)
  int n = read(fd2, buf, sizeof(buf));
     b2a:	fc040713          	addi	a4,s0,-64
     b2e:	fe842783          	lw	a5,-24(s0)
     b32:	02000613          	li	a2,32
     b36:	85ba                	mv	a1,a4
     b38:	853e                	mv	a0,a5
     b3a:	00007097          	auipc	ra,0x7
     b3e:	826080e7          	jalr	-2010(ra) # 7360 <read>
     b42:	87aa                	mv	a5,a0
     b44:	fef42223          	sw	a5,-28(s0)
  if(n != 4){
     b48:	fe442783          	lw	a5,-28(s0)
     b4c:	0007871b          	sext.w	a4,a5
     b50:	4791                	li	a5,4
     b52:	02f70463          	beq	a4,a5,b7a <truncate1+0xc4>
    printf("%s: read %d bytes, wanted 4\n", s, n);
     b56:	fe442783          	lw	a5,-28(s0)
     b5a:	863e                	mv	a2,a5
     b5c:	fb843583          	ld	a1,-72(s0)
     b60:	00007517          	auipc	a0,0x7
     b64:	72050513          	addi	a0,a0,1824 # 8280 <malloc+0x808>
     b68:	00007097          	auipc	ra,0x7
     b6c:	d1e080e7          	jalr	-738(ra) # 7886 <printf>
    exit(1);
     b70:	4505                	li	a0,1
     b72:	00006097          	auipc	ra,0x6
     b76:	7d6080e7          	jalr	2006(ra) # 7348 <exit>
  }

  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     b7a:	40100593          	li	a1,1025
     b7e:	00007517          	auipc	a0,0x7
     b82:	6ea50513          	addi	a0,a0,1770 # 8268 <malloc+0x7f0>
     b86:	00007097          	auipc	ra,0x7
     b8a:	802080e7          	jalr	-2046(ra) # 7388 <open>
     b8e:	87aa                	mv	a5,a0
     b90:	fef42623          	sw	a5,-20(s0)

  int fd3 = open("truncfile", O_RDONLY);
     b94:	4581                	li	a1,0
     b96:	00007517          	auipc	a0,0x7
     b9a:	6d250513          	addi	a0,a0,1746 # 8268 <malloc+0x7f0>
     b9e:	00006097          	auipc	ra,0x6
     ba2:	7ea080e7          	jalr	2026(ra) # 7388 <open>
     ba6:	87aa                	mv	a5,a0
     ba8:	fef42023          	sw	a5,-32(s0)
  n = read(fd3, buf, sizeof(buf));
     bac:	fc040713          	addi	a4,s0,-64
     bb0:	fe042783          	lw	a5,-32(s0)
     bb4:	02000613          	li	a2,32
     bb8:	85ba                	mv	a1,a4
     bba:	853e                	mv	a0,a5
     bbc:	00006097          	auipc	ra,0x6
     bc0:	7a4080e7          	jalr	1956(ra) # 7360 <read>
     bc4:	87aa                	mv	a5,a0
     bc6:	fef42223          	sw	a5,-28(s0)
  if(n != 0){
     bca:	fe442783          	lw	a5,-28(s0)
     bce:	2781                	sext.w	a5,a5
     bd0:	cf95                	beqz	a5,c0c <truncate1+0x156>
    printf("aaa fd3=%d\n", fd3);
     bd2:	fe042783          	lw	a5,-32(s0)
     bd6:	85be                	mv	a1,a5
     bd8:	00007517          	auipc	a0,0x7
     bdc:	6c850513          	addi	a0,a0,1736 # 82a0 <malloc+0x828>
     be0:	00007097          	auipc	ra,0x7
     be4:	ca6080e7          	jalr	-858(ra) # 7886 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     be8:	fe442783          	lw	a5,-28(s0)
     bec:	863e                	mv	a2,a5
     bee:	fb843583          	ld	a1,-72(s0)
     bf2:	00007517          	auipc	a0,0x7
     bf6:	6be50513          	addi	a0,a0,1726 # 82b0 <malloc+0x838>
     bfa:	00007097          	auipc	ra,0x7
     bfe:	c8c080e7          	jalr	-884(ra) # 7886 <printf>
    exit(1);
     c02:	4505                	li	a0,1
     c04:	00006097          	auipc	ra,0x6
     c08:	744080e7          	jalr	1860(ra) # 7348 <exit>
  }

  n = read(fd2, buf, sizeof(buf));
     c0c:	fc040713          	addi	a4,s0,-64
     c10:	fe842783          	lw	a5,-24(s0)
     c14:	02000613          	li	a2,32
     c18:	85ba                	mv	a1,a4
     c1a:	853e                	mv	a0,a5
     c1c:	00006097          	auipc	ra,0x6
     c20:	744080e7          	jalr	1860(ra) # 7360 <read>
     c24:	87aa                	mv	a5,a0
     c26:	fef42223          	sw	a5,-28(s0)
  if(n != 0){
     c2a:	fe442783          	lw	a5,-28(s0)
     c2e:	2781                	sext.w	a5,a5
     c30:	cf95                	beqz	a5,c6c <truncate1+0x1b6>
    printf("bbb fd2=%d\n", fd2);
     c32:	fe842783          	lw	a5,-24(s0)
     c36:	85be                	mv	a1,a5
     c38:	00007517          	auipc	a0,0x7
     c3c:	69850513          	addi	a0,a0,1688 # 82d0 <malloc+0x858>
     c40:	00007097          	auipc	ra,0x7
     c44:	c46080e7          	jalr	-954(ra) # 7886 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     c48:	fe442783          	lw	a5,-28(s0)
     c4c:	863e                	mv	a2,a5
     c4e:	fb843583          	ld	a1,-72(s0)
     c52:	00007517          	auipc	a0,0x7
     c56:	65e50513          	addi	a0,a0,1630 # 82b0 <malloc+0x838>
     c5a:	00007097          	auipc	ra,0x7
     c5e:	c2c080e7          	jalr	-980(ra) # 7886 <printf>
    exit(1);
     c62:	4505                	li	a0,1
     c64:	00006097          	auipc	ra,0x6
     c68:	6e4080e7          	jalr	1764(ra) # 7348 <exit>
  }
  
  write(fd1, "abcdef", 6);
     c6c:	fec42783          	lw	a5,-20(s0)
     c70:	4619                	li	a2,6
     c72:	00007597          	auipc	a1,0x7
     c76:	66e58593          	addi	a1,a1,1646 # 82e0 <malloc+0x868>
     c7a:	853e                	mv	a0,a5
     c7c:	00006097          	auipc	ra,0x6
     c80:	6ec080e7          	jalr	1772(ra) # 7368 <write>

  n = read(fd3, buf, sizeof(buf));
     c84:	fc040713          	addi	a4,s0,-64
     c88:	fe042783          	lw	a5,-32(s0)
     c8c:	02000613          	li	a2,32
     c90:	85ba                	mv	a1,a4
     c92:	853e                	mv	a0,a5
     c94:	00006097          	auipc	ra,0x6
     c98:	6cc080e7          	jalr	1740(ra) # 7360 <read>
     c9c:	87aa                	mv	a5,a0
     c9e:	fef42223          	sw	a5,-28(s0)
  if(n != 6){
     ca2:	fe442783          	lw	a5,-28(s0)
     ca6:	0007871b          	sext.w	a4,a5
     caa:	4799                	li	a5,6
     cac:	02f70463          	beq	a4,a5,cd4 <truncate1+0x21e>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     cb0:	fe442783          	lw	a5,-28(s0)
     cb4:	863e                	mv	a2,a5
     cb6:	fb843583          	ld	a1,-72(s0)
     cba:	00007517          	auipc	a0,0x7
     cbe:	62e50513          	addi	a0,a0,1582 # 82e8 <malloc+0x870>
     cc2:	00007097          	auipc	ra,0x7
     cc6:	bc4080e7          	jalr	-1084(ra) # 7886 <printf>
    exit(1);
     cca:	4505                	li	a0,1
     ccc:	00006097          	auipc	ra,0x6
     cd0:	67c080e7          	jalr	1660(ra) # 7348 <exit>
  }

  n = read(fd2, buf, sizeof(buf));
     cd4:	fc040713          	addi	a4,s0,-64
     cd8:	fe842783          	lw	a5,-24(s0)
     cdc:	02000613          	li	a2,32
     ce0:	85ba                	mv	a1,a4
     ce2:	853e                	mv	a0,a5
     ce4:	00006097          	auipc	ra,0x6
     ce8:	67c080e7          	jalr	1660(ra) # 7360 <read>
     cec:	87aa                	mv	a5,a0
     cee:	fef42223          	sw	a5,-28(s0)
  if(n != 2){
     cf2:	fe442783          	lw	a5,-28(s0)
     cf6:	0007871b          	sext.w	a4,a5
     cfa:	4789                	li	a5,2
     cfc:	02f70463          	beq	a4,a5,d24 <truncate1+0x26e>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     d00:	fe442783          	lw	a5,-28(s0)
     d04:	863e                	mv	a2,a5
     d06:	fb843583          	ld	a1,-72(s0)
     d0a:	00007517          	auipc	a0,0x7
     d0e:	5fe50513          	addi	a0,a0,1534 # 8308 <malloc+0x890>
     d12:	00007097          	auipc	ra,0x7
     d16:	b74080e7          	jalr	-1164(ra) # 7886 <printf>
    exit(1);
     d1a:	4505                	li	a0,1
     d1c:	00006097          	auipc	ra,0x6
     d20:	62c080e7          	jalr	1580(ra) # 7348 <exit>
  }

  unlink("truncfile");
     d24:	00007517          	auipc	a0,0x7
     d28:	54450513          	addi	a0,a0,1348 # 8268 <malloc+0x7f0>
     d2c:	00006097          	auipc	ra,0x6
     d30:	66c080e7          	jalr	1644(ra) # 7398 <unlink>

  close(fd1);
     d34:	fec42783          	lw	a5,-20(s0)
     d38:	853e                	mv	a0,a5
     d3a:	00006097          	auipc	ra,0x6
     d3e:	636080e7          	jalr	1590(ra) # 7370 <close>
  close(fd2);
     d42:	fe842783          	lw	a5,-24(s0)
     d46:	853e                	mv	a0,a5
     d48:	00006097          	auipc	ra,0x6
     d4c:	628080e7          	jalr	1576(ra) # 7370 <close>
  close(fd3);
     d50:	fe042783          	lw	a5,-32(s0)
     d54:	853e                	mv	a0,a5
     d56:	00006097          	auipc	ra,0x6
     d5a:	61a080e7          	jalr	1562(ra) # 7370 <close>
}
     d5e:	0001                	nop
     d60:	60a6                	ld	ra,72(sp)
     d62:	6406                	ld	s0,64(sp)
     d64:	6161                	addi	sp,sp,80
     d66:	8082                	ret

0000000000000d68 <truncate2>:
// this causes a write at an offset beyond the end of the file.
// such writes fail on xv6 (unlike POSIX) but at least
// they don't crash.
void
truncate2(char *s)
{
     d68:	7179                	addi	sp,sp,-48
     d6a:	f406                	sd	ra,40(sp)
     d6c:	f022                	sd	s0,32(sp)
     d6e:	1800                	addi	s0,sp,48
     d70:	fca43c23          	sd	a0,-40(s0)
  unlink("truncfile");
     d74:	00007517          	auipc	a0,0x7
     d78:	4f450513          	addi	a0,a0,1268 # 8268 <malloc+0x7f0>
     d7c:	00006097          	auipc	ra,0x6
     d80:	61c080e7          	jalr	1564(ra) # 7398 <unlink>

  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     d84:	60100593          	li	a1,1537
     d88:	00007517          	auipc	a0,0x7
     d8c:	4e050513          	addi	a0,a0,1248 # 8268 <malloc+0x7f0>
     d90:	00006097          	auipc	ra,0x6
     d94:	5f8080e7          	jalr	1528(ra) # 7388 <open>
     d98:	87aa                	mv	a5,a0
     d9a:	fef42623          	sw	a5,-20(s0)
  write(fd1, "abcd", 4);
     d9e:	fec42783          	lw	a5,-20(s0)
     da2:	4611                	li	a2,4
     da4:	00007597          	auipc	a1,0x7
     da8:	4d458593          	addi	a1,a1,1236 # 8278 <malloc+0x800>
     dac:	853e                	mv	a0,a5
     dae:	00006097          	auipc	ra,0x6
     db2:	5ba080e7          	jalr	1466(ra) # 7368 <write>

  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     db6:	40100593          	li	a1,1025
     dba:	00007517          	auipc	a0,0x7
     dbe:	4ae50513          	addi	a0,a0,1198 # 8268 <malloc+0x7f0>
     dc2:	00006097          	auipc	ra,0x6
     dc6:	5c6080e7          	jalr	1478(ra) # 7388 <open>
     dca:	87aa                	mv	a5,a0
     dcc:	fef42423          	sw	a5,-24(s0)

  int n = write(fd1, "x", 1);
     dd0:	fec42783          	lw	a5,-20(s0)
     dd4:	4605                	li	a2,1
     dd6:	00007597          	auipc	a1,0x7
     dda:	25258593          	addi	a1,a1,594 # 8028 <malloc+0x5b0>
     dde:	853e                	mv	a0,a5
     de0:	00006097          	auipc	ra,0x6
     de4:	588080e7          	jalr	1416(ra) # 7368 <write>
     de8:	87aa                	mv	a5,a0
     dea:	fef42223          	sw	a5,-28(s0)
  if(n != -1){
     dee:	fe442783          	lw	a5,-28(s0)
     df2:	0007871b          	sext.w	a4,a5
     df6:	57fd                	li	a5,-1
     df8:	02f70463          	beq	a4,a5,e20 <truncate2+0xb8>
    printf("%s: write returned %d, expected -1\n", s, n);
     dfc:	fe442783          	lw	a5,-28(s0)
     e00:	863e                	mv	a2,a5
     e02:	fd843583          	ld	a1,-40(s0)
     e06:	00007517          	auipc	a0,0x7
     e0a:	52250513          	addi	a0,a0,1314 # 8328 <malloc+0x8b0>
     e0e:	00007097          	auipc	ra,0x7
     e12:	a78080e7          	jalr	-1416(ra) # 7886 <printf>
    exit(1);
     e16:	4505                	li	a0,1
     e18:	00006097          	auipc	ra,0x6
     e1c:	530080e7          	jalr	1328(ra) # 7348 <exit>
  }

  unlink("truncfile");
     e20:	00007517          	auipc	a0,0x7
     e24:	44850513          	addi	a0,a0,1096 # 8268 <malloc+0x7f0>
     e28:	00006097          	auipc	ra,0x6
     e2c:	570080e7          	jalr	1392(ra) # 7398 <unlink>
  close(fd1);
     e30:	fec42783          	lw	a5,-20(s0)
     e34:	853e                	mv	a0,a5
     e36:	00006097          	auipc	ra,0x6
     e3a:	53a080e7          	jalr	1338(ra) # 7370 <close>
  close(fd2);
     e3e:	fe842783          	lw	a5,-24(s0)
     e42:	853e                	mv	a0,a5
     e44:	00006097          	auipc	ra,0x6
     e48:	52c080e7          	jalr	1324(ra) # 7370 <close>
}
     e4c:	0001                	nop
     e4e:	70a2                	ld	ra,40(sp)
     e50:	7402                	ld	s0,32(sp)
     e52:	6145                	addi	sp,sp,48
     e54:	8082                	ret

0000000000000e56 <truncate3>:

void
truncate3(char *s)
{
     e56:	711d                	addi	sp,sp,-96
     e58:	ec86                	sd	ra,88(sp)
     e5a:	e8a2                	sd	s0,80(sp)
     e5c:	1080                	addi	s0,sp,96
     e5e:	faa43423          	sd	a0,-88(s0)
  int pid, xstatus;

  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
     e62:	60100593          	li	a1,1537
     e66:	00007517          	auipc	a0,0x7
     e6a:	40250513          	addi	a0,a0,1026 # 8268 <malloc+0x7f0>
     e6e:	00006097          	auipc	ra,0x6
     e72:	51a080e7          	jalr	1306(ra) # 7388 <open>
     e76:	87aa                	mv	a5,a0
     e78:	853e                	mv	a0,a5
     e7a:	00006097          	auipc	ra,0x6
     e7e:	4f6080e7          	jalr	1270(ra) # 7370 <close>
  
  pid = fork();
     e82:	00006097          	auipc	ra,0x6
     e86:	4be080e7          	jalr	1214(ra) # 7340 <fork>
     e8a:	87aa                	mv	a5,a0
     e8c:	fef42223          	sw	a5,-28(s0)
  if(pid < 0){
     e90:	fe442783          	lw	a5,-28(s0)
     e94:	2781                	sext.w	a5,a5
     e96:	0207d163          	bgez	a5,eb8 <truncate3+0x62>
    printf("%s: fork failed\n", s);
     e9a:	fa843583          	ld	a1,-88(s0)
     e9e:	00007517          	auipc	a0,0x7
     ea2:	4b250513          	addi	a0,a0,1202 # 8350 <malloc+0x8d8>
     ea6:	00007097          	auipc	ra,0x7
     eaa:	9e0080e7          	jalr	-1568(ra) # 7886 <printf>
    exit(1);
     eae:	4505                	li	a0,1
     eb0:	00006097          	auipc	ra,0x6
     eb4:	498080e7          	jalr	1176(ra) # 7348 <exit>
  }

  if(pid == 0){
     eb8:	fe442783          	lw	a5,-28(s0)
     ebc:	2781                	sext.w	a5,a5
     ebe:	10079563          	bnez	a5,fc8 <truncate3+0x172>
    for(int i = 0; i < 100; i++){
     ec2:	fe042623          	sw	zero,-20(s0)
     ec6:	a0e5                	j	fae <truncate3+0x158>
      char buf[32];
      int fd = open("truncfile", O_WRONLY);
     ec8:	4585                	li	a1,1
     eca:	00007517          	auipc	a0,0x7
     ece:	39e50513          	addi	a0,a0,926 # 8268 <malloc+0x7f0>
     ed2:	00006097          	auipc	ra,0x6
     ed6:	4b6080e7          	jalr	1206(ra) # 7388 <open>
     eda:	87aa                	mv	a5,a0
     edc:	fcf42c23          	sw	a5,-40(s0)
      if(fd < 0){
     ee0:	fd842783          	lw	a5,-40(s0)
     ee4:	2781                	sext.w	a5,a5
     ee6:	0207d163          	bgez	a5,f08 <truncate3+0xb2>
        printf("%s: open failed\n", s);
     eea:	fa843583          	ld	a1,-88(s0)
     eee:	00007517          	auipc	a0,0x7
     ef2:	47a50513          	addi	a0,a0,1146 # 8368 <malloc+0x8f0>
     ef6:	00007097          	auipc	ra,0x7
     efa:	990080e7          	jalr	-1648(ra) # 7886 <printf>
        exit(1);
     efe:	4505                	li	a0,1
     f00:	00006097          	auipc	ra,0x6
     f04:	448080e7          	jalr	1096(ra) # 7348 <exit>
      }
      int n = write(fd, "1234567890", 10);
     f08:	fd842783          	lw	a5,-40(s0)
     f0c:	4629                	li	a2,10
     f0e:	00007597          	auipc	a1,0x7
     f12:	47258593          	addi	a1,a1,1138 # 8380 <malloc+0x908>
     f16:	853e                	mv	a0,a5
     f18:	00006097          	auipc	ra,0x6
     f1c:	450080e7          	jalr	1104(ra) # 7368 <write>
     f20:	87aa                	mv	a5,a0
     f22:	fcf42a23          	sw	a5,-44(s0)
      if(n != 10){
     f26:	fd442783          	lw	a5,-44(s0)
     f2a:	0007871b          	sext.w	a4,a5
     f2e:	47a9                	li	a5,10
     f30:	02f70463          	beq	a4,a5,f58 <truncate3+0x102>
        printf("%s: write got %d, expected 10\n", s, n);
     f34:	fd442783          	lw	a5,-44(s0)
     f38:	863e                	mv	a2,a5
     f3a:	fa843583          	ld	a1,-88(s0)
     f3e:	00007517          	auipc	a0,0x7
     f42:	45250513          	addi	a0,a0,1106 # 8390 <malloc+0x918>
     f46:	00007097          	auipc	ra,0x7
     f4a:	940080e7          	jalr	-1728(ra) # 7886 <printf>
        exit(1);
     f4e:	4505                	li	a0,1
     f50:	00006097          	auipc	ra,0x6
     f54:	3f8080e7          	jalr	1016(ra) # 7348 <exit>
      }
      close(fd);
     f58:	fd842783          	lw	a5,-40(s0)
     f5c:	853e                	mv	a0,a5
     f5e:	00006097          	auipc	ra,0x6
     f62:	412080e7          	jalr	1042(ra) # 7370 <close>
      fd = open("truncfile", O_RDONLY);
     f66:	4581                	li	a1,0
     f68:	00007517          	auipc	a0,0x7
     f6c:	30050513          	addi	a0,a0,768 # 8268 <malloc+0x7f0>
     f70:	00006097          	auipc	ra,0x6
     f74:	418080e7          	jalr	1048(ra) # 7388 <open>
     f78:	87aa                	mv	a5,a0
     f7a:	fcf42c23          	sw	a5,-40(s0)
      read(fd, buf, sizeof(buf));
     f7e:	fb040713          	addi	a4,s0,-80
     f82:	fd842783          	lw	a5,-40(s0)
     f86:	02000613          	li	a2,32
     f8a:	85ba                	mv	a1,a4
     f8c:	853e                	mv	a0,a5
     f8e:	00006097          	auipc	ra,0x6
     f92:	3d2080e7          	jalr	978(ra) # 7360 <read>
      close(fd);
     f96:	fd842783          	lw	a5,-40(s0)
     f9a:	853e                	mv	a0,a5
     f9c:	00006097          	auipc	ra,0x6
     fa0:	3d4080e7          	jalr	980(ra) # 7370 <close>
    for(int i = 0; i < 100; i++){
     fa4:	fec42783          	lw	a5,-20(s0)
     fa8:	2785                	addiw	a5,a5,1
     faa:	fef42623          	sw	a5,-20(s0)
     fae:	fec42783          	lw	a5,-20(s0)
     fb2:	0007871b          	sext.w	a4,a5
     fb6:	06300793          	li	a5,99
     fba:	f0e7d7e3          	bge	a5,a4,ec8 <truncate3+0x72>
    }
    exit(0);
     fbe:	4501                	li	a0,0
     fc0:	00006097          	auipc	ra,0x6
     fc4:	388080e7          	jalr	904(ra) # 7348 <exit>
  }

  for(int i = 0; i < 150; i++){
     fc8:	fe042423          	sw	zero,-24(s0)
     fcc:	a075                	j	1078 <truncate3+0x222>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     fce:	60100593          	li	a1,1537
     fd2:	00007517          	auipc	a0,0x7
     fd6:	29650513          	addi	a0,a0,662 # 8268 <malloc+0x7f0>
     fda:	00006097          	auipc	ra,0x6
     fde:	3ae080e7          	jalr	942(ra) # 7388 <open>
     fe2:	87aa                	mv	a5,a0
     fe4:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
     fe8:	fe042783          	lw	a5,-32(s0)
     fec:	2781                	sext.w	a5,a5
     fee:	0207d163          	bgez	a5,1010 <truncate3+0x1ba>
      printf("%s: open failed\n", s);
     ff2:	fa843583          	ld	a1,-88(s0)
     ff6:	00007517          	auipc	a0,0x7
     ffa:	37250513          	addi	a0,a0,882 # 8368 <malloc+0x8f0>
     ffe:	00007097          	auipc	ra,0x7
    1002:	888080e7          	jalr	-1912(ra) # 7886 <printf>
      exit(1);
    1006:	4505                	li	a0,1
    1008:	00006097          	auipc	ra,0x6
    100c:	340080e7          	jalr	832(ra) # 7348 <exit>
    }
    int n = write(fd, "xxx", 3);
    1010:	fe042783          	lw	a5,-32(s0)
    1014:	460d                	li	a2,3
    1016:	00007597          	auipc	a1,0x7
    101a:	39a58593          	addi	a1,a1,922 # 83b0 <malloc+0x938>
    101e:	853e                	mv	a0,a5
    1020:	00006097          	auipc	ra,0x6
    1024:	348080e7          	jalr	840(ra) # 7368 <write>
    1028:	87aa                	mv	a5,a0
    102a:	fcf42e23          	sw	a5,-36(s0)
    if(n != 3){
    102e:	fdc42783          	lw	a5,-36(s0)
    1032:	0007871b          	sext.w	a4,a5
    1036:	478d                	li	a5,3
    1038:	02f70463          	beq	a4,a5,1060 <truncate3+0x20a>
      printf("%s: write got %d, expected 3\n", s, n);
    103c:	fdc42783          	lw	a5,-36(s0)
    1040:	863e                	mv	a2,a5
    1042:	fa843583          	ld	a1,-88(s0)
    1046:	00007517          	auipc	a0,0x7
    104a:	37250513          	addi	a0,a0,882 # 83b8 <malloc+0x940>
    104e:	00007097          	auipc	ra,0x7
    1052:	838080e7          	jalr	-1992(ra) # 7886 <printf>
      exit(1);
    1056:	4505                	li	a0,1
    1058:	00006097          	auipc	ra,0x6
    105c:	2f0080e7          	jalr	752(ra) # 7348 <exit>
    }
    close(fd);
    1060:	fe042783          	lw	a5,-32(s0)
    1064:	853e                	mv	a0,a5
    1066:	00006097          	auipc	ra,0x6
    106a:	30a080e7          	jalr	778(ra) # 7370 <close>
  for(int i = 0; i < 150; i++){
    106e:	fe842783          	lw	a5,-24(s0)
    1072:	2785                	addiw	a5,a5,1
    1074:	fef42423          	sw	a5,-24(s0)
    1078:	fe842783          	lw	a5,-24(s0)
    107c:	0007871b          	sext.w	a4,a5
    1080:	09500793          	li	a5,149
    1084:	f4e7d5e3          	bge	a5,a4,fce <truncate3+0x178>
  }

  wait(&xstatus);
    1088:	fd040793          	addi	a5,s0,-48
    108c:	853e                	mv	a0,a5
    108e:	00006097          	auipc	ra,0x6
    1092:	2c2080e7          	jalr	706(ra) # 7350 <wait>
  unlink("truncfile");
    1096:	00007517          	auipc	a0,0x7
    109a:	1d250513          	addi	a0,a0,466 # 8268 <malloc+0x7f0>
    109e:	00006097          	auipc	ra,0x6
    10a2:	2fa080e7          	jalr	762(ra) # 7398 <unlink>
  exit(xstatus);
    10a6:	fd042783          	lw	a5,-48(s0)
    10aa:	853e                	mv	a0,a5
    10ac:	00006097          	auipc	ra,0x6
    10b0:	29c080e7          	jalr	668(ra) # 7348 <exit>

00000000000010b4 <iputtest>:
  

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(char *s)
{
    10b4:	1101                	addi	sp,sp,-32
    10b6:	ec06                	sd	ra,24(sp)
    10b8:	e822                	sd	s0,16(sp)
    10ba:	1000                	addi	s0,sp,32
    10bc:	fea43423          	sd	a0,-24(s0)
  if(mkdir("iputdir") < 0){
    10c0:	00007517          	auipc	a0,0x7
    10c4:	31850513          	addi	a0,a0,792 # 83d8 <malloc+0x960>
    10c8:	00006097          	auipc	ra,0x6
    10cc:	2e8080e7          	jalr	744(ra) # 73b0 <mkdir>
    10d0:	87aa                	mv	a5,a0
    10d2:	0207d163          	bgez	a5,10f4 <iputtest+0x40>
    printf("%s: mkdir failed\n", s);
    10d6:	fe843583          	ld	a1,-24(s0)
    10da:	00007517          	auipc	a0,0x7
    10de:	30650513          	addi	a0,a0,774 # 83e0 <malloc+0x968>
    10e2:	00006097          	auipc	ra,0x6
    10e6:	7a4080e7          	jalr	1956(ra) # 7886 <printf>
    exit(1);
    10ea:	4505                	li	a0,1
    10ec:	00006097          	auipc	ra,0x6
    10f0:	25c080e7          	jalr	604(ra) # 7348 <exit>
  }
  if(chdir("iputdir") < 0){
    10f4:	00007517          	auipc	a0,0x7
    10f8:	2e450513          	addi	a0,a0,740 # 83d8 <malloc+0x960>
    10fc:	00006097          	auipc	ra,0x6
    1100:	2bc080e7          	jalr	700(ra) # 73b8 <chdir>
    1104:	87aa                	mv	a5,a0
    1106:	0207d163          	bgez	a5,1128 <iputtest+0x74>
    printf("%s: chdir iputdir failed\n", s);
    110a:	fe843583          	ld	a1,-24(s0)
    110e:	00007517          	auipc	a0,0x7
    1112:	2ea50513          	addi	a0,a0,746 # 83f8 <malloc+0x980>
    1116:	00006097          	auipc	ra,0x6
    111a:	770080e7          	jalr	1904(ra) # 7886 <printf>
    exit(1);
    111e:	4505                	li	a0,1
    1120:	00006097          	auipc	ra,0x6
    1124:	228080e7          	jalr	552(ra) # 7348 <exit>
  }
  if(unlink("../iputdir") < 0){
    1128:	00007517          	auipc	a0,0x7
    112c:	2f050513          	addi	a0,a0,752 # 8418 <malloc+0x9a0>
    1130:	00006097          	auipc	ra,0x6
    1134:	268080e7          	jalr	616(ra) # 7398 <unlink>
    1138:	87aa                	mv	a5,a0
    113a:	0207d163          	bgez	a5,115c <iputtest+0xa8>
    printf("%s: unlink ../iputdir failed\n", s);
    113e:	fe843583          	ld	a1,-24(s0)
    1142:	00007517          	auipc	a0,0x7
    1146:	2e650513          	addi	a0,a0,742 # 8428 <malloc+0x9b0>
    114a:	00006097          	auipc	ra,0x6
    114e:	73c080e7          	jalr	1852(ra) # 7886 <printf>
    exit(1);
    1152:	4505                	li	a0,1
    1154:	00006097          	auipc	ra,0x6
    1158:	1f4080e7          	jalr	500(ra) # 7348 <exit>
  }
  if(chdir("/") < 0){
    115c:	00007517          	auipc	a0,0x7
    1160:	2ec50513          	addi	a0,a0,748 # 8448 <malloc+0x9d0>
    1164:	00006097          	auipc	ra,0x6
    1168:	254080e7          	jalr	596(ra) # 73b8 <chdir>
    116c:	87aa                	mv	a5,a0
    116e:	0207d163          	bgez	a5,1190 <iputtest+0xdc>
    printf("%s: chdir / failed\n", s);
    1172:	fe843583          	ld	a1,-24(s0)
    1176:	00007517          	auipc	a0,0x7
    117a:	2da50513          	addi	a0,a0,730 # 8450 <malloc+0x9d8>
    117e:	00006097          	auipc	ra,0x6
    1182:	708080e7          	jalr	1800(ra) # 7886 <printf>
    exit(1);
    1186:	4505                	li	a0,1
    1188:	00006097          	auipc	ra,0x6
    118c:	1c0080e7          	jalr	448(ra) # 7348 <exit>
  }
}
    1190:	0001                	nop
    1192:	60e2                	ld	ra,24(sp)
    1194:	6442                	ld	s0,16(sp)
    1196:	6105                	addi	sp,sp,32
    1198:	8082                	ret

000000000000119a <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(char *s)
{
    119a:	7179                	addi	sp,sp,-48
    119c:	f406                	sd	ra,40(sp)
    119e:	f022                	sd	s0,32(sp)
    11a0:	1800                	addi	s0,sp,48
    11a2:	fca43c23          	sd	a0,-40(s0)
  int pid, xstatus;

  pid = fork();
    11a6:	00006097          	auipc	ra,0x6
    11aa:	19a080e7          	jalr	410(ra) # 7340 <fork>
    11ae:	87aa                	mv	a5,a0
    11b0:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    11b4:	fec42783          	lw	a5,-20(s0)
    11b8:	2781                	sext.w	a5,a5
    11ba:	0207d163          	bgez	a5,11dc <exitiputtest+0x42>
    printf("%s: fork failed\n", s);
    11be:	fd843583          	ld	a1,-40(s0)
    11c2:	00007517          	auipc	a0,0x7
    11c6:	18e50513          	addi	a0,a0,398 # 8350 <malloc+0x8d8>
    11ca:	00006097          	auipc	ra,0x6
    11ce:	6bc080e7          	jalr	1724(ra) # 7886 <printf>
    exit(1);
    11d2:	4505                	li	a0,1
    11d4:	00006097          	auipc	ra,0x6
    11d8:	174080e7          	jalr	372(ra) # 7348 <exit>
  }
  if(pid == 0){
    11dc:	fec42783          	lw	a5,-20(s0)
    11e0:	2781                	sext.w	a5,a5
    11e2:	e7c5                	bnez	a5,128a <exitiputtest+0xf0>
    if(mkdir("iputdir") < 0){
    11e4:	00007517          	auipc	a0,0x7
    11e8:	1f450513          	addi	a0,a0,500 # 83d8 <malloc+0x960>
    11ec:	00006097          	auipc	ra,0x6
    11f0:	1c4080e7          	jalr	452(ra) # 73b0 <mkdir>
    11f4:	87aa                	mv	a5,a0
    11f6:	0207d163          	bgez	a5,1218 <exitiputtest+0x7e>
      printf("%s: mkdir failed\n", s);
    11fa:	fd843583          	ld	a1,-40(s0)
    11fe:	00007517          	auipc	a0,0x7
    1202:	1e250513          	addi	a0,a0,482 # 83e0 <malloc+0x968>
    1206:	00006097          	auipc	ra,0x6
    120a:	680080e7          	jalr	1664(ra) # 7886 <printf>
      exit(1);
    120e:	4505                	li	a0,1
    1210:	00006097          	auipc	ra,0x6
    1214:	138080e7          	jalr	312(ra) # 7348 <exit>
    }
    if(chdir("iputdir") < 0){
    1218:	00007517          	auipc	a0,0x7
    121c:	1c050513          	addi	a0,a0,448 # 83d8 <malloc+0x960>
    1220:	00006097          	auipc	ra,0x6
    1224:	198080e7          	jalr	408(ra) # 73b8 <chdir>
    1228:	87aa                	mv	a5,a0
    122a:	0207d163          	bgez	a5,124c <exitiputtest+0xb2>
      printf("%s: child chdir failed\n", s);
    122e:	fd843583          	ld	a1,-40(s0)
    1232:	00007517          	auipc	a0,0x7
    1236:	23650513          	addi	a0,a0,566 # 8468 <malloc+0x9f0>
    123a:	00006097          	auipc	ra,0x6
    123e:	64c080e7          	jalr	1612(ra) # 7886 <printf>
      exit(1);
    1242:	4505                	li	a0,1
    1244:	00006097          	auipc	ra,0x6
    1248:	104080e7          	jalr	260(ra) # 7348 <exit>
    }
    if(unlink("../iputdir") < 0){
    124c:	00007517          	auipc	a0,0x7
    1250:	1cc50513          	addi	a0,a0,460 # 8418 <malloc+0x9a0>
    1254:	00006097          	auipc	ra,0x6
    1258:	144080e7          	jalr	324(ra) # 7398 <unlink>
    125c:	87aa                	mv	a5,a0
    125e:	0207d163          	bgez	a5,1280 <exitiputtest+0xe6>
      printf("%s: unlink ../iputdir failed\n", s);
    1262:	fd843583          	ld	a1,-40(s0)
    1266:	00007517          	auipc	a0,0x7
    126a:	1c250513          	addi	a0,a0,450 # 8428 <malloc+0x9b0>
    126e:	00006097          	auipc	ra,0x6
    1272:	618080e7          	jalr	1560(ra) # 7886 <printf>
      exit(1);
    1276:	4505                	li	a0,1
    1278:	00006097          	auipc	ra,0x6
    127c:	0d0080e7          	jalr	208(ra) # 7348 <exit>
    }
    exit(0);
    1280:	4501                	li	a0,0
    1282:	00006097          	auipc	ra,0x6
    1286:	0c6080e7          	jalr	198(ra) # 7348 <exit>
  }
  wait(&xstatus);
    128a:	fe840793          	addi	a5,s0,-24
    128e:	853e                	mv	a0,a5
    1290:	00006097          	auipc	ra,0x6
    1294:	0c0080e7          	jalr	192(ra) # 7350 <wait>
  exit(xstatus);
    1298:	fe842783          	lw	a5,-24(s0)
    129c:	853e                	mv	a0,a5
    129e:	00006097          	auipc	ra,0x6
    12a2:	0aa080e7          	jalr	170(ra) # 7348 <exit>

00000000000012a6 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(char *s)
{
    12a6:	7179                	addi	sp,sp,-48
    12a8:	f406                	sd	ra,40(sp)
    12aa:	f022                	sd	s0,32(sp)
    12ac:	1800                	addi	s0,sp,48
    12ae:	fca43c23          	sd	a0,-40(s0)
  int pid, xstatus;

  if(mkdir("oidir") < 0){
    12b2:	00007517          	auipc	a0,0x7
    12b6:	1ce50513          	addi	a0,a0,462 # 8480 <malloc+0xa08>
    12ba:	00006097          	auipc	ra,0x6
    12be:	0f6080e7          	jalr	246(ra) # 73b0 <mkdir>
    12c2:	87aa                	mv	a5,a0
    12c4:	0207d163          	bgez	a5,12e6 <openiputtest+0x40>
    printf("%s: mkdir oidir failed\n", s);
    12c8:	fd843583          	ld	a1,-40(s0)
    12cc:	00007517          	auipc	a0,0x7
    12d0:	1bc50513          	addi	a0,a0,444 # 8488 <malloc+0xa10>
    12d4:	00006097          	auipc	ra,0x6
    12d8:	5b2080e7          	jalr	1458(ra) # 7886 <printf>
    exit(1);
    12dc:	4505                	li	a0,1
    12de:	00006097          	auipc	ra,0x6
    12e2:	06a080e7          	jalr	106(ra) # 7348 <exit>
  }
  pid = fork();
    12e6:	00006097          	auipc	ra,0x6
    12ea:	05a080e7          	jalr	90(ra) # 7340 <fork>
    12ee:	87aa                	mv	a5,a0
    12f0:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    12f4:	fec42783          	lw	a5,-20(s0)
    12f8:	2781                	sext.w	a5,a5
    12fa:	0207d163          	bgez	a5,131c <openiputtest+0x76>
    printf("%s: fork failed\n", s);
    12fe:	fd843583          	ld	a1,-40(s0)
    1302:	00007517          	auipc	a0,0x7
    1306:	04e50513          	addi	a0,a0,78 # 8350 <malloc+0x8d8>
    130a:	00006097          	auipc	ra,0x6
    130e:	57c080e7          	jalr	1404(ra) # 7886 <printf>
    exit(1);
    1312:	4505                	li	a0,1
    1314:	00006097          	auipc	ra,0x6
    1318:	034080e7          	jalr	52(ra) # 7348 <exit>
  }
  if(pid == 0){
    131c:	fec42783          	lw	a5,-20(s0)
    1320:	2781                	sext.w	a5,a5
    1322:	e7b1                	bnez	a5,136e <openiputtest+0xc8>
    int fd = open("oidir", O_RDWR);
    1324:	4589                	li	a1,2
    1326:	00007517          	auipc	a0,0x7
    132a:	15a50513          	addi	a0,a0,346 # 8480 <malloc+0xa08>
    132e:	00006097          	auipc	ra,0x6
    1332:	05a080e7          	jalr	90(ra) # 7388 <open>
    1336:	87aa                	mv	a5,a0
    1338:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0){
    133c:	fe842783          	lw	a5,-24(s0)
    1340:	2781                	sext.w	a5,a5
    1342:	0207c163          	bltz	a5,1364 <openiputtest+0xbe>
      printf("%s: open directory for write succeeded\n", s);
    1346:	fd843583          	ld	a1,-40(s0)
    134a:	00007517          	auipc	a0,0x7
    134e:	15650513          	addi	a0,a0,342 # 84a0 <malloc+0xa28>
    1352:	00006097          	auipc	ra,0x6
    1356:	534080e7          	jalr	1332(ra) # 7886 <printf>
      exit(1);
    135a:	4505                	li	a0,1
    135c:	00006097          	auipc	ra,0x6
    1360:	fec080e7          	jalr	-20(ra) # 7348 <exit>
    }
    exit(0);
    1364:	4501                	li	a0,0
    1366:	00006097          	auipc	ra,0x6
    136a:	fe2080e7          	jalr	-30(ra) # 7348 <exit>
  }
  sleep(1);
    136e:	4505                	li	a0,1
    1370:	00006097          	auipc	ra,0x6
    1374:	068080e7          	jalr	104(ra) # 73d8 <sleep>
  if(unlink("oidir") != 0){
    1378:	00007517          	auipc	a0,0x7
    137c:	10850513          	addi	a0,a0,264 # 8480 <malloc+0xa08>
    1380:	00006097          	auipc	ra,0x6
    1384:	018080e7          	jalr	24(ra) # 7398 <unlink>
    1388:	87aa                	mv	a5,a0
    138a:	c385                	beqz	a5,13aa <openiputtest+0x104>
    printf("%s: unlink failed\n", s);
    138c:	fd843583          	ld	a1,-40(s0)
    1390:	00007517          	auipc	a0,0x7
    1394:	13850513          	addi	a0,a0,312 # 84c8 <malloc+0xa50>
    1398:	00006097          	auipc	ra,0x6
    139c:	4ee080e7          	jalr	1262(ra) # 7886 <printf>
    exit(1);
    13a0:	4505                	li	a0,1
    13a2:	00006097          	auipc	ra,0x6
    13a6:	fa6080e7          	jalr	-90(ra) # 7348 <exit>
  }
  wait(&xstatus);
    13aa:	fe440793          	addi	a5,s0,-28
    13ae:	853e                	mv	a0,a5
    13b0:	00006097          	auipc	ra,0x6
    13b4:	fa0080e7          	jalr	-96(ra) # 7350 <wait>
  exit(xstatus);
    13b8:	fe442783          	lw	a5,-28(s0)
    13bc:	853e                	mv	a0,a5
    13be:	00006097          	auipc	ra,0x6
    13c2:	f8a080e7          	jalr	-118(ra) # 7348 <exit>

00000000000013c6 <opentest>:

// simple file system tests

void
opentest(char *s)
{
    13c6:	7179                	addi	sp,sp,-48
    13c8:	f406                	sd	ra,40(sp)
    13ca:	f022                	sd	s0,32(sp)
    13cc:	1800                	addi	s0,sp,48
    13ce:	fca43c23          	sd	a0,-40(s0)
  int fd;

  fd = open("echo", 0);
    13d2:	4581                	li	a1,0
    13d4:	00007517          	auipc	a0,0x7
    13d8:	d6450513          	addi	a0,a0,-668 # 8138 <malloc+0x6c0>
    13dc:	00006097          	auipc	ra,0x6
    13e0:	fac080e7          	jalr	-84(ra) # 7388 <open>
    13e4:	87aa                	mv	a5,a0
    13e6:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    13ea:	fec42783          	lw	a5,-20(s0)
    13ee:	2781                	sext.w	a5,a5
    13f0:	0207d163          	bgez	a5,1412 <opentest+0x4c>
    printf("%s: open echo failed!\n", s);
    13f4:	fd843583          	ld	a1,-40(s0)
    13f8:	00007517          	auipc	a0,0x7
    13fc:	0e850513          	addi	a0,a0,232 # 84e0 <malloc+0xa68>
    1400:	00006097          	auipc	ra,0x6
    1404:	486080e7          	jalr	1158(ra) # 7886 <printf>
    exit(1);
    1408:	4505                	li	a0,1
    140a:	00006097          	auipc	ra,0x6
    140e:	f3e080e7          	jalr	-194(ra) # 7348 <exit>
  }
  close(fd);
    1412:	fec42783          	lw	a5,-20(s0)
    1416:	853e                	mv	a0,a5
    1418:	00006097          	auipc	ra,0x6
    141c:	f58080e7          	jalr	-168(ra) # 7370 <close>
  fd = open("doesnotexist", 0);
    1420:	4581                	li	a1,0
    1422:	00007517          	auipc	a0,0x7
    1426:	0d650513          	addi	a0,a0,214 # 84f8 <malloc+0xa80>
    142a:	00006097          	auipc	ra,0x6
    142e:	f5e080e7          	jalr	-162(ra) # 7388 <open>
    1432:	87aa                	mv	a5,a0
    1434:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    1438:	fec42783          	lw	a5,-20(s0)
    143c:	2781                	sext.w	a5,a5
    143e:	0207c163          	bltz	a5,1460 <opentest+0x9a>
    printf("%s: open doesnotexist succeeded!\n", s);
    1442:	fd843583          	ld	a1,-40(s0)
    1446:	00007517          	auipc	a0,0x7
    144a:	0c250513          	addi	a0,a0,194 # 8508 <malloc+0xa90>
    144e:	00006097          	auipc	ra,0x6
    1452:	438080e7          	jalr	1080(ra) # 7886 <printf>
    exit(1);
    1456:	4505                	li	a0,1
    1458:	00006097          	auipc	ra,0x6
    145c:	ef0080e7          	jalr	-272(ra) # 7348 <exit>
  }
}
    1460:	0001                	nop
    1462:	70a2                	ld	ra,40(sp)
    1464:	7402                	ld	s0,32(sp)
    1466:	6145                	addi	sp,sp,48
    1468:	8082                	ret

000000000000146a <writetest>:

void
writetest(char *s)
{
    146a:	7179                	addi	sp,sp,-48
    146c:	f406                	sd	ra,40(sp)
    146e:	f022                	sd	s0,32(sp)
    1470:	1800                	addi	s0,sp,48
    1472:	fca43c23          	sd	a0,-40(s0)
  int fd;
  int i;
  enum { N=100, SZ=10 };
  
  fd = open("small", O_CREATE|O_RDWR);
    1476:	20200593          	li	a1,514
    147a:	00007517          	auipc	a0,0x7
    147e:	0b650513          	addi	a0,a0,182 # 8530 <malloc+0xab8>
    1482:	00006097          	auipc	ra,0x6
    1486:	f06080e7          	jalr	-250(ra) # 7388 <open>
    148a:	87aa                	mv	a5,a0
    148c:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    1490:	fe842783          	lw	a5,-24(s0)
    1494:	2781                	sext.w	a5,a5
    1496:	0207d163          	bgez	a5,14b8 <writetest+0x4e>
    printf("%s: error: creat small failed!\n", s);
    149a:	fd843583          	ld	a1,-40(s0)
    149e:	00007517          	auipc	a0,0x7
    14a2:	09a50513          	addi	a0,a0,154 # 8538 <malloc+0xac0>
    14a6:	00006097          	auipc	ra,0x6
    14aa:	3e0080e7          	jalr	992(ra) # 7886 <printf>
    exit(1);
    14ae:	4505                	li	a0,1
    14b0:	00006097          	auipc	ra,0x6
    14b4:	e98080e7          	jalr	-360(ra) # 7348 <exit>
  }
  for(i = 0; i < N; i++){
    14b8:	fe042623          	sw	zero,-20(s0)
    14bc:	a861                	j	1554 <writetest+0xea>
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
    14be:	fe842783          	lw	a5,-24(s0)
    14c2:	4629                	li	a2,10
    14c4:	00007597          	auipc	a1,0x7
    14c8:	09458593          	addi	a1,a1,148 # 8558 <malloc+0xae0>
    14cc:	853e                	mv	a0,a5
    14ce:	00006097          	auipc	ra,0x6
    14d2:	e9a080e7          	jalr	-358(ra) # 7368 <write>
    14d6:	87aa                	mv	a5,a0
    14d8:	873e                	mv	a4,a5
    14da:	47a9                	li	a5,10
    14dc:	02f70463          	beq	a4,a5,1504 <writetest+0x9a>
      printf("%s: error: write aa %d new file failed\n", s, i);
    14e0:	fec42783          	lw	a5,-20(s0)
    14e4:	863e                	mv	a2,a5
    14e6:	fd843583          	ld	a1,-40(s0)
    14ea:	00007517          	auipc	a0,0x7
    14ee:	07e50513          	addi	a0,a0,126 # 8568 <malloc+0xaf0>
    14f2:	00006097          	auipc	ra,0x6
    14f6:	394080e7          	jalr	916(ra) # 7886 <printf>
      exit(1);
    14fa:	4505                	li	a0,1
    14fc:	00006097          	auipc	ra,0x6
    1500:	e4c080e7          	jalr	-436(ra) # 7348 <exit>
    }
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
    1504:	fe842783          	lw	a5,-24(s0)
    1508:	4629                	li	a2,10
    150a:	00007597          	auipc	a1,0x7
    150e:	08658593          	addi	a1,a1,134 # 8590 <malloc+0xb18>
    1512:	853e                	mv	a0,a5
    1514:	00006097          	auipc	ra,0x6
    1518:	e54080e7          	jalr	-428(ra) # 7368 <write>
    151c:	87aa                	mv	a5,a0
    151e:	873e                	mv	a4,a5
    1520:	47a9                	li	a5,10
    1522:	02f70463          	beq	a4,a5,154a <writetest+0xe0>
      printf("%s: error: write bb %d new file failed\n", s, i);
    1526:	fec42783          	lw	a5,-20(s0)
    152a:	863e                	mv	a2,a5
    152c:	fd843583          	ld	a1,-40(s0)
    1530:	00007517          	auipc	a0,0x7
    1534:	07050513          	addi	a0,a0,112 # 85a0 <malloc+0xb28>
    1538:	00006097          	auipc	ra,0x6
    153c:	34e080e7          	jalr	846(ra) # 7886 <printf>
      exit(1);
    1540:	4505                	li	a0,1
    1542:	00006097          	auipc	ra,0x6
    1546:	e06080e7          	jalr	-506(ra) # 7348 <exit>
  for(i = 0; i < N; i++){
    154a:	fec42783          	lw	a5,-20(s0)
    154e:	2785                	addiw	a5,a5,1
    1550:	fef42623          	sw	a5,-20(s0)
    1554:	fec42783          	lw	a5,-20(s0)
    1558:	0007871b          	sext.w	a4,a5
    155c:	06300793          	li	a5,99
    1560:	f4e7dfe3          	bge	a5,a4,14be <writetest+0x54>
    }
  }
  close(fd);
    1564:	fe842783          	lw	a5,-24(s0)
    1568:	853e                	mv	a0,a5
    156a:	00006097          	auipc	ra,0x6
    156e:	e06080e7          	jalr	-506(ra) # 7370 <close>
  fd = open("small", O_RDONLY);
    1572:	4581                	li	a1,0
    1574:	00007517          	auipc	a0,0x7
    1578:	fbc50513          	addi	a0,a0,-68 # 8530 <malloc+0xab8>
    157c:	00006097          	auipc	ra,0x6
    1580:	e0c080e7          	jalr	-500(ra) # 7388 <open>
    1584:	87aa                	mv	a5,a0
    1586:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    158a:	fe842783          	lw	a5,-24(s0)
    158e:	2781                	sext.w	a5,a5
    1590:	0207d163          	bgez	a5,15b2 <writetest+0x148>
    printf("%s: error: open small failed!\n", s);
    1594:	fd843583          	ld	a1,-40(s0)
    1598:	00007517          	auipc	a0,0x7
    159c:	03050513          	addi	a0,a0,48 # 85c8 <malloc+0xb50>
    15a0:	00006097          	auipc	ra,0x6
    15a4:	2e6080e7          	jalr	742(ra) # 7886 <printf>
    exit(1);
    15a8:	4505                	li	a0,1
    15aa:	00006097          	auipc	ra,0x6
    15ae:	d9e080e7          	jalr	-610(ra) # 7348 <exit>
  }
  i = read(fd, buf, N*SZ*2);
    15b2:	fe842783          	lw	a5,-24(s0)
    15b6:	7d000613          	li	a2,2000
    15ba:	00009597          	auipc	a1,0x9
    15be:	e5658593          	addi	a1,a1,-426 # a410 <buf>
    15c2:	853e                	mv	a0,a5
    15c4:	00006097          	auipc	ra,0x6
    15c8:	d9c080e7          	jalr	-612(ra) # 7360 <read>
    15cc:	87aa                	mv	a5,a0
    15ce:	fef42623          	sw	a5,-20(s0)
  if(i != N*SZ*2){
    15d2:	fec42783          	lw	a5,-20(s0)
    15d6:	0007871b          	sext.w	a4,a5
    15da:	7d000793          	li	a5,2000
    15de:	02f70163          	beq	a4,a5,1600 <writetest+0x196>
    printf("%s: read failed\n", s);
    15e2:	fd843583          	ld	a1,-40(s0)
    15e6:	00007517          	auipc	a0,0x7
    15ea:	00250513          	addi	a0,a0,2 # 85e8 <malloc+0xb70>
    15ee:	00006097          	auipc	ra,0x6
    15f2:	298080e7          	jalr	664(ra) # 7886 <printf>
    exit(1);
    15f6:	4505                	li	a0,1
    15f8:	00006097          	auipc	ra,0x6
    15fc:	d50080e7          	jalr	-688(ra) # 7348 <exit>
  }
  close(fd);
    1600:	fe842783          	lw	a5,-24(s0)
    1604:	853e                	mv	a0,a5
    1606:	00006097          	auipc	ra,0x6
    160a:	d6a080e7          	jalr	-662(ra) # 7370 <close>

  if(unlink("small") < 0){
    160e:	00007517          	auipc	a0,0x7
    1612:	f2250513          	addi	a0,a0,-222 # 8530 <malloc+0xab8>
    1616:	00006097          	auipc	ra,0x6
    161a:	d82080e7          	jalr	-638(ra) # 7398 <unlink>
    161e:	87aa                	mv	a5,a0
    1620:	0207d163          	bgez	a5,1642 <writetest+0x1d8>
    printf("%s: unlink small failed\n", s);
    1624:	fd843583          	ld	a1,-40(s0)
    1628:	00007517          	auipc	a0,0x7
    162c:	fd850513          	addi	a0,a0,-40 # 8600 <malloc+0xb88>
    1630:	00006097          	auipc	ra,0x6
    1634:	256080e7          	jalr	598(ra) # 7886 <printf>
    exit(1);
    1638:	4505                	li	a0,1
    163a:	00006097          	auipc	ra,0x6
    163e:	d0e080e7          	jalr	-754(ra) # 7348 <exit>
  }
}
    1642:	0001                	nop
    1644:	70a2                	ld	ra,40(sp)
    1646:	7402                	ld	s0,32(sp)
    1648:	6145                	addi	sp,sp,48
    164a:	8082                	ret

000000000000164c <writebig>:

void
writebig(char *s)
{
    164c:	7179                	addi	sp,sp,-48
    164e:	f406                	sd	ra,40(sp)
    1650:	f022                	sd	s0,32(sp)
    1652:	1800                	addi	s0,sp,48
    1654:	fca43c23          	sd	a0,-40(s0)
  int i, fd, n;

  fd = open("big", O_CREATE|O_RDWR);
    1658:	20200593          	li	a1,514
    165c:	00007517          	auipc	a0,0x7
    1660:	fc450513          	addi	a0,a0,-60 # 8620 <malloc+0xba8>
    1664:	00006097          	auipc	ra,0x6
    1668:	d24080e7          	jalr	-732(ra) # 7388 <open>
    166c:	87aa                	mv	a5,a0
    166e:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    1672:	fe442783          	lw	a5,-28(s0)
    1676:	2781                	sext.w	a5,a5
    1678:	0207d163          	bgez	a5,169a <writebig+0x4e>
    printf("%s: error: creat big failed!\n", s);
    167c:	fd843583          	ld	a1,-40(s0)
    1680:	00007517          	auipc	a0,0x7
    1684:	fa850513          	addi	a0,a0,-88 # 8628 <malloc+0xbb0>
    1688:	00006097          	auipc	ra,0x6
    168c:	1fe080e7          	jalr	510(ra) # 7886 <printf>
    exit(1);
    1690:	4505                	li	a0,1
    1692:	00006097          	auipc	ra,0x6
    1696:	cb6080e7          	jalr	-842(ra) # 7348 <exit>
  }

  for(i = 0; i < MAXFILE; i++){
    169a:	fe042623          	sw	zero,-20(s0)
    169e:	a095                	j	1702 <writebig+0xb6>
    ((int*)buf)[0] = i;
    16a0:	00009797          	auipc	a5,0x9
    16a4:	d7078793          	addi	a5,a5,-656 # a410 <buf>
    16a8:	fec42703          	lw	a4,-20(s0)
    16ac:	c398                	sw	a4,0(a5)
    if(write(fd, buf, BSIZE) != BSIZE){
    16ae:	fe442783          	lw	a5,-28(s0)
    16b2:	40000613          	li	a2,1024
    16b6:	00009597          	auipc	a1,0x9
    16ba:	d5a58593          	addi	a1,a1,-678 # a410 <buf>
    16be:	853e                	mv	a0,a5
    16c0:	00006097          	auipc	ra,0x6
    16c4:	ca8080e7          	jalr	-856(ra) # 7368 <write>
    16c8:	87aa                	mv	a5,a0
    16ca:	873e                	mv	a4,a5
    16cc:	40000793          	li	a5,1024
    16d0:	02f70463          	beq	a4,a5,16f8 <writebig+0xac>
      printf("%s: error: write big file failed\n", s, i);
    16d4:	fec42783          	lw	a5,-20(s0)
    16d8:	863e                	mv	a2,a5
    16da:	fd843583          	ld	a1,-40(s0)
    16de:	00007517          	auipc	a0,0x7
    16e2:	f6a50513          	addi	a0,a0,-150 # 8648 <malloc+0xbd0>
    16e6:	00006097          	auipc	ra,0x6
    16ea:	1a0080e7          	jalr	416(ra) # 7886 <printf>
      exit(1);
    16ee:	4505                	li	a0,1
    16f0:	00006097          	auipc	ra,0x6
    16f4:	c58080e7          	jalr	-936(ra) # 7348 <exit>
  for(i = 0; i < MAXFILE; i++){
    16f8:	fec42783          	lw	a5,-20(s0)
    16fc:	2785                	addiw	a5,a5,1
    16fe:	fef42623          	sw	a5,-20(s0)
    1702:	fec42783          	lw	a5,-20(s0)
    1706:	873e                	mv	a4,a5
    1708:	10b00793          	li	a5,267
    170c:	f8e7fae3          	bgeu	a5,a4,16a0 <writebig+0x54>
    }
  }

  close(fd);
    1710:	fe442783          	lw	a5,-28(s0)
    1714:	853e                	mv	a0,a5
    1716:	00006097          	auipc	ra,0x6
    171a:	c5a080e7          	jalr	-934(ra) # 7370 <close>

  fd = open("big", O_RDONLY);
    171e:	4581                	li	a1,0
    1720:	00007517          	auipc	a0,0x7
    1724:	f0050513          	addi	a0,a0,-256 # 8620 <malloc+0xba8>
    1728:	00006097          	auipc	ra,0x6
    172c:	c60080e7          	jalr	-928(ra) # 7388 <open>
    1730:	87aa                	mv	a5,a0
    1732:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    1736:	fe442783          	lw	a5,-28(s0)
    173a:	2781                	sext.w	a5,a5
    173c:	0207d163          	bgez	a5,175e <writebig+0x112>
    printf("%s: error: open big failed!\n", s);
    1740:	fd843583          	ld	a1,-40(s0)
    1744:	00007517          	auipc	a0,0x7
    1748:	f2c50513          	addi	a0,a0,-212 # 8670 <malloc+0xbf8>
    174c:	00006097          	auipc	ra,0x6
    1750:	13a080e7          	jalr	314(ra) # 7886 <printf>
    exit(1);
    1754:	4505                	li	a0,1
    1756:	00006097          	auipc	ra,0x6
    175a:	bf2080e7          	jalr	-1038(ra) # 7348 <exit>
  }

  n = 0;
    175e:	fe042423          	sw	zero,-24(s0)
  for(;;){
    i = read(fd, buf, BSIZE);
    1762:	fe442783          	lw	a5,-28(s0)
    1766:	40000613          	li	a2,1024
    176a:	00009597          	auipc	a1,0x9
    176e:	ca658593          	addi	a1,a1,-858 # a410 <buf>
    1772:	853e                	mv	a0,a5
    1774:	00006097          	auipc	ra,0x6
    1778:	bec080e7          	jalr	-1044(ra) # 7360 <read>
    177c:	87aa                	mv	a5,a0
    177e:	fef42623          	sw	a5,-20(s0)
    if(i == 0){
    1782:	fec42783          	lw	a5,-20(s0)
    1786:	2781                	sext.w	a5,a5
    1788:	eb9d                	bnez	a5,17be <writebig+0x172>
      if(n == MAXFILE - 1){
    178a:	fe842783          	lw	a5,-24(s0)
    178e:	0007871b          	sext.w	a4,a5
    1792:	10b00793          	li	a5,267
    1796:	0af71663          	bne	a4,a5,1842 <writebig+0x1f6>
        printf("%s: read only %d blocks from big", s, n);
    179a:	fe842783          	lw	a5,-24(s0)
    179e:	863e                	mv	a2,a5
    17a0:	fd843583          	ld	a1,-40(s0)
    17a4:	00007517          	auipc	a0,0x7
    17a8:	eec50513          	addi	a0,a0,-276 # 8690 <malloc+0xc18>
    17ac:	00006097          	auipc	ra,0x6
    17b0:	0da080e7          	jalr	218(ra) # 7886 <printf>
        exit(1);
    17b4:	4505                	li	a0,1
    17b6:	00006097          	auipc	ra,0x6
    17ba:	b92080e7          	jalr	-1134(ra) # 7348 <exit>
      }
      break;
    } else if(i != BSIZE){
    17be:	fec42783          	lw	a5,-20(s0)
    17c2:	0007871b          	sext.w	a4,a5
    17c6:	40000793          	li	a5,1024
    17ca:	02f70463          	beq	a4,a5,17f2 <writebig+0x1a6>
      printf("%s: read failed %d\n", s, i);
    17ce:	fec42783          	lw	a5,-20(s0)
    17d2:	863e                	mv	a2,a5
    17d4:	fd843583          	ld	a1,-40(s0)
    17d8:	00007517          	auipc	a0,0x7
    17dc:	ee050513          	addi	a0,a0,-288 # 86b8 <malloc+0xc40>
    17e0:	00006097          	auipc	ra,0x6
    17e4:	0a6080e7          	jalr	166(ra) # 7886 <printf>
      exit(1);
    17e8:	4505                	li	a0,1
    17ea:	00006097          	auipc	ra,0x6
    17ee:	b5e080e7          	jalr	-1186(ra) # 7348 <exit>
    }
    if(((int*)buf)[0] != n){
    17f2:	00009797          	auipc	a5,0x9
    17f6:	c1e78793          	addi	a5,a5,-994 # a410 <buf>
    17fa:	4398                	lw	a4,0(a5)
    17fc:	fe842783          	lw	a5,-24(s0)
    1800:	2781                	sext.w	a5,a5
    1802:	02e78a63          	beq	a5,a4,1836 <writebig+0x1ea>
      printf("%s: read content of block %d is %d\n", s,
             n, ((int*)buf)[0]);
    1806:	00009797          	auipc	a5,0x9
    180a:	c0a78793          	addi	a5,a5,-1014 # a410 <buf>
      printf("%s: read content of block %d is %d\n", s,
    180e:	4398                	lw	a4,0(a5)
    1810:	fe842783          	lw	a5,-24(s0)
    1814:	86ba                	mv	a3,a4
    1816:	863e                	mv	a2,a5
    1818:	fd843583          	ld	a1,-40(s0)
    181c:	00007517          	auipc	a0,0x7
    1820:	eb450513          	addi	a0,a0,-332 # 86d0 <malloc+0xc58>
    1824:	00006097          	auipc	ra,0x6
    1828:	062080e7          	jalr	98(ra) # 7886 <printf>
      exit(1);
    182c:	4505                	li	a0,1
    182e:	00006097          	auipc	ra,0x6
    1832:	b1a080e7          	jalr	-1254(ra) # 7348 <exit>
    }
    n++;
    1836:	fe842783          	lw	a5,-24(s0)
    183a:	2785                	addiw	a5,a5,1
    183c:	fef42423          	sw	a5,-24(s0)
    i = read(fd, buf, BSIZE);
    1840:	b70d                	j	1762 <writebig+0x116>
      break;
    1842:	0001                	nop
  }
  close(fd);
    1844:	fe442783          	lw	a5,-28(s0)
    1848:	853e                	mv	a0,a5
    184a:	00006097          	auipc	ra,0x6
    184e:	b26080e7          	jalr	-1242(ra) # 7370 <close>
  if(unlink("big") < 0){
    1852:	00007517          	auipc	a0,0x7
    1856:	dce50513          	addi	a0,a0,-562 # 8620 <malloc+0xba8>
    185a:	00006097          	auipc	ra,0x6
    185e:	b3e080e7          	jalr	-1218(ra) # 7398 <unlink>
    1862:	87aa                	mv	a5,a0
    1864:	0207d163          	bgez	a5,1886 <writebig+0x23a>
    printf("%s: unlink big failed\n", s);
    1868:	fd843583          	ld	a1,-40(s0)
    186c:	00007517          	auipc	a0,0x7
    1870:	e8c50513          	addi	a0,a0,-372 # 86f8 <malloc+0xc80>
    1874:	00006097          	auipc	ra,0x6
    1878:	012080e7          	jalr	18(ra) # 7886 <printf>
    exit(1);
    187c:	4505                	li	a0,1
    187e:	00006097          	auipc	ra,0x6
    1882:	aca080e7          	jalr	-1334(ra) # 7348 <exit>
  }
}
    1886:	0001                	nop
    1888:	70a2                	ld	ra,40(sp)
    188a:	7402                	ld	s0,32(sp)
    188c:	6145                	addi	sp,sp,48
    188e:	8082                	ret

0000000000001890 <createtest>:

// many creates, followed by unlink test
void
createtest(char *s)
{
    1890:	7179                	addi	sp,sp,-48
    1892:	f406                	sd	ra,40(sp)
    1894:	f022                	sd	s0,32(sp)
    1896:	1800                	addi	s0,sp,48
    1898:	fca43c23          	sd	a0,-40(s0)
  int i, fd;
  enum { N=52 };

  char name[3];
  name[0] = 'a';
    189c:	06100793          	li	a5,97
    18a0:	fef40023          	sb	a5,-32(s0)
  name[2] = '\0';
    18a4:	fe040123          	sb	zero,-30(s0)
  for(i = 0; i < N; i++){
    18a8:	fe042623          	sw	zero,-20(s0)
    18ac:	a099                	j	18f2 <createtest+0x62>
    name[1] = '0' + i;
    18ae:	fec42783          	lw	a5,-20(s0)
    18b2:	0ff7f793          	andi	a5,a5,255
    18b6:	0307879b          	addiw	a5,a5,48
    18ba:	0ff7f793          	andi	a5,a5,255
    18be:	fef400a3          	sb	a5,-31(s0)
    fd = open(name, O_CREATE|O_RDWR);
    18c2:	fe040793          	addi	a5,s0,-32
    18c6:	20200593          	li	a1,514
    18ca:	853e                	mv	a0,a5
    18cc:	00006097          	auipc	ra,0x6
    18d0:	abc080e7          	jalr	-1348(ra) # 7388 <open>
    18d4:	87aa                	mv	a5,a0
    18d6:	fef42423          	sw	a5,-24(s0)
    close(fd);
    18da:	fe842783          	lw	a5,-24(s0)
    18de:	853e                	mv	a0,a5
    18e0:	00006097          	auipc	ra,0x6
    18e4:	a90080e7          	jalr	-1392(ra) # 7370 <close>
  for(i = 0; i < N; i++){
    18e8:	fec42783          	lw	a5,-20(s0)
    18ec:	2785                	addiw	a5,a5,1
    18ee:	fef42623          	sw	a5,-20(s0)
    18f2:	fec42783          	lw	a5,-20(s0)
    18f6:	0007871b          	sext.w	a4,a5
    18fa:	03300793          	li	a5,51
    18fe:	fae7d8e3          	bge	a5,a4,18ae <createtest+0x1e>
  }
  name[0] = 'a';
    1902:	06100793          	li	a5,97
    1906:	fef40023          	sb	a5,-32(s0)
  name[2] = '\0';
    190a:	fe040123          	sb	zero,-30(s0)
  for(i = 0; i < N; i++){
    190e:	fe042623          	sw	zero,-20(s0)
    1912:	a03d                	j	1940 <createtest+0xb0>
    name[1] = '0' + i;
    1914:	fec42783          	lw	a5,-20(s0)
    1918:	0ff7f793          	andi	a5,a5,255
    191c:	0307879b          	addiw	a5,a5,48
    1920:	0ff7f793          	andi	a5,a5,255
    1924:	fef400a3          	sb	a5,-31(s0)
    unlink(name);
    1928:	fe040793          	addi	a5,s0,-32
    192c:	853e                	mv	a0,a5
    192e:	00006097          	auipc	ra,0x6
    1932:	a6a080e7          	jalr	-1430(ra) # 7398 <unlink>
  for(i = 0; i < N; i++){
    1936:	fec42783          	lw	a5,-20(s0)
    193a:	2785                	addiw	a5,a5,1
    193c:	fef42623          	sw	a5,-20(s0)
    1940:	fec42783          	lw	a5,-20(s0)
    1944:	0007871b          	sext.w	a4,a5
    1948:	03300793          	li	a5,51
    194c:	fce7d4e3          	bge	a5,a4,1914 <createtest+0x84>
  }
}
    1950:	0001                	nop
    1952:	0001                	nop
    1954:	70a2                	ld	ra,40(sp)
    1956:	7402                	ld	s0,32(sp)
    1958:	6145                	addi	sp,sp,48
    195a:	8082                	ret

000000000000195c <dirtest>:

void dirtest(char *s)
{
    195c:	1101                	addi	sp,sp,-32
    195e:	ec06                	sd	ra,24(sp)
    1960:	e822                	sd	s0,16(sp)
    1962:	1000                	addi	s0,sp,32
    1964:	fea43423          	sd	a0,-24(s0)
  if(mkdir("dir0") < 0){
    1968:	00007517          	auipc	a0,0x7
    196c:	da850513          	addi	a0,a0,-600 # 8710 <malloc+0xc98>
    1970:	00006097          	auipc	ra,0x6
    1974:	a40080e7          	jalr	-1472(ra) # 73b0 <mkdir>
    1978:	87aa                	mv	a5,a0
    197a:	0207d163          	bgez	a5,199c <dirtest+0x40>
    printf("%s: mkdir failed\n", s);
    197e:	fe843583          	ld	a1,-24(s0)
    1982:	00007517          	auipc	a0,0x7
    1986:	a5e50513          	addi	a0,a0,-1442 # 83e0 <malloc+0x968>
    198a:	00006097          	auipc	ra,0x6
    198e:	efc080e7          	jalr	-260(ra) # 7886 <printf>
    exit(1);
    1992:	4505                	li	a0,1
    1994:	00006097          	auipc	ra,0x6
    1998:	9b4080e7          	jalr	-1612(ra) # 7348 <exit>
  }

  if(chdir("dir0") < 0){
    199c:	00007517          	auipc	a0,0x7
    19a0:	d7450513          	addi	a0,a0,-652 # 8710 <malloc+0xc98>
    19a4:	00006097          	auipc	ra,0x6
    19a8:	a14080e7          	jalr	-1516(ra) # 73b8 <chdir>
    19ac:	87aa                	mv	a5,a0
    19ae:	0207d163          	bgez	a5,19d0 <dirtest+0x74>
    printf("%s: chdir dir0 failed\n", s);
    19b2:	fe843583          	ld	a1,-24(s0)
    19b6:	00007517          	auipc	a0,0x7
    19ba:	d6250513          	addi	a0,a0,-670 # 8718 <malloc+0xca0>
    19be:	00006097          	auipc	ra,0x6
    19c2:	ec8080e7          	jalr	-312(ra) # 7886 <printf>
    exit(1);
    19c6:	4505                	li	a0,1
    19c8:	00006097          	auipc	ra,0x6
    19cc:	980080e7          	jalr	-1664(ra) # 7348 <exit>
  }

  if(chdir("..") < 0){
    19d0:	00007517          	auipc	a0,0x7
    19d4:	d6050513          	addi	a0,a0,-672 # 8730 <malloc+0xcb8>
    19d8:	00006097          	auipc	ra,0x6
    19dc:	9e0080e7          	jalr	-1568(ra) # 73b8 <chdir>
    19e0:	87aa                	mv	a5,a0
    19e2:	0207d163          	bgez	a5,1a04 <dirtest+0xa8>
    printf("%s: chdir .. failed\n", s);
    19e6:	fe843583          	ld	a1,-24(s0)
    19ea:	00007517          	auipc	a0,0x7
    19ee:	d4e50513          	addi	a0,a0,-690 # 8738 <malloc+0xcc0>
    19f2:	00006097          	auipc	ra,0x6
    19f6:	e94080e7          	jalr	-364(ra) # 7886 <printf>
    exit(1);
    19fa:	4505                	li	a0,1
    19fc:	00006097          	auipc	ra,0x6
    1a00:	94c080e7          	jalr	-1716(ra) # 7348 <exit>
  }

  if(unlink("dir0") < 0){
    1a04:	00007517          	auipc	a0,0x7
    1a08:	d0c50513          	addi	a0,a0,-756 # 8710 <malloc+0xc98>
    1a0c:	00006097          	auipc	ra,0x6
    1a10:	98c080e7          	jalr	-1652(ra) # 7398 <unlink>
    1a14:	87aa                	mv	a5,a0
    1a16:	0207d163          	bgez	a5,1a38 <dirtest+0xdc>
    printf("%s: unlink dir0 failed\n", s);
    1a1a:	fe843583          	ld	a1,-24(s0)
    1a1e:	00007517          	auipc	a0,0x7
    1a22:	d3250513          	addi	a0,a0,-718 # 8750 <malloc+0xcd8>
    1a26:	00006097          	auipc	ra,0x6
    1a2a:	e60080e7          	jalr	-416(ra) # 7886 <printf>
    exit(1);
    1a2e:	4505                	li	a0,1
    1a30:	00006097          	auipc	ra,0x6
    1a34:	918080e7          	jalr	-1768(ra) # 7348 <exit>
  }
}
    1a38:	0001                	nop
    1a3a:	60e2                	ld	ra,24(sp)
    1a3c:	6442                	ld	s0,16(sp)
    1a3e:	6105                	addi	sp,sp,32
    1a40:	8082                	ret

0000000000001a42 <exectest>:

void
exectest(char *s)
{
    1a42:	715d                	addi	sp,sp,-80
    1a44:	e486                	sd	ra,72(sp)
    1a46:	e0a2                	sd	s0,64(sp)
    1a48:	0880                	addi	s0,sp,80
    1a4a:	faa43c23          	sd	a0,-72(s0)
  int fd, xstatus, pid;
  char *echoargv[] = { "echo", "OK", 0 };
    1a4e:	00006797          	auipc	a5,0x6
    1a52:	6ea78793          	addi	a5,a5,1770 # 8138 <malloc+0x6c0>
    1a56:	fcf43423          	sd	a5,-56(s0)
    1a5a:	00007797          	auipc	a5,0x7
    1a5e:	d0e78793          	addi	a5,a5,-754 # 8768 <malloc+0xcf0>
    1a62:	fcf43823          	sd	a5,-48(s0)
    1a66:	fc043c23          	sd	zero,-40(s0)
  char buf[3];

  unlink("echo-ok");
    1a6a:	00007517          	auipc	a0,0x7
    1a6e:	d0650513          	addi	a0,a0,-762 # 8770 <malloc+0xcf8>
    1a72:	00006097          	auipc	ra,0x6
    1a76:	926080e7          	jalr	-1754(ra) # 7398 <unlink>
  pid = fork();
    1a7a:	00006097          	auipc	ra,0x6
    1a7e:	8c6080e7          	jalr	-1850(ra) # 7340 <fork>
    1a82:	87aa                	mv	a5,a0
    1a84:	fef42623          	sw	a5,-20(s0)
  if(pid < 0) {
    1a88:	fec42783          	lw	a5,-20(s0)
    1a8c:	2781                	sext.w	a5,a5
    1a8e:	0207d163          	bgez	a5,1ab0 <exectest+0x6e>
     printf("%s: fork failed\n", s);
    1a92:	fb843583          	ld	a1,-72(s0)
    1a96:	00007517          	auipc	a0,0x7
    1a9a:	8ba50513          	addi	a0,a0,-1862 # 8350 <malloc+0x8d8>
    1a9e:	00006097          	auipc	ra,0x6
    1aa2:	de8080e7          	jalr	-536(ra) # 7886 <printf>
     exit(1);
    1aa6:	4505                	li	a0,1
    1aa8:	00006097          	auipc	ra,0x6
    1aac:	8a0080e7          	jalr	-1888(ra) # 7348 <exit>
  }
  if(pid == 0) {
    1ab0:	fec42783          	lw	a5,-20(s0)
    1ab4:	2781                	sext.w	a5,a5
    1ab6:	ebd5                	bnez	a5,1b6a <exectest+0x128>
    close(1);
    1ab8:	4505                	li	a0,1
    1aba:	00006097          	auipc	ra,0x6
    1abe:	8b6080e7          	jalr	-1866(ra) # 7370 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1ac2:	20100593          	li	a1,513
    1ac6:	00007517          	auipc	a0,0x7
    1aca:	caa50513          	addi	a0,a0,-854 # 8770 <malloc+0xcf8>
    1ace:	00006097          	auipc	ra,0x6
    1ad2:	8ba080e7          	jalr	-1862(ra) # 7388 <open>
    1ad6:	87aa                	mv	a5,a0
    1ad8:	fef42423          	sw	a5,-24(s0)
    if(fd < 0) {
    1adc:	fe842783          	lw	a5,-24(s0)
    1ae0:	2781                	sext.w	a5,a5
    1ae2:	0207d163          	bgez	a5,1b04 <exectest+0xc2>
      printf("%s: create failed\n", s);
    1ae6:	fb843583          	ld	a1,-72(s0)
    1aea:	00007517          	auipc	a0,0x7
    1aee:	c8e50513          	addi	a0,a0,-882 # 8778 <malloc+0xd00>
    1af2:	00006097          	auipc	ra,0x6
    1af6:	d94080e7          	jalr	-620(ra) # 7886 <printf>
      exit(1);
    1afa:	4505                	li	a0,1
    1afc:	00006097          	auipc	ra,0x6
    1b00:	84c080e7          	jalr	-1972(ra) # 7348 <exit>
    }
    if(fd != 1) {
    1b04:	fe842783          	lw	a5,-24(s0)
    1b08:	0007871b          	sext.w	a4,a5
    1b0c:	4785                	li	a5,1
    1b0e:	02f70163          	beq	a4,a5,1b30 <exectest+0xee>
      printf("%s: wrong fd\n", s);
    1b12:	fb843583          	ld	a1,-72(s0)
    1b16:	00007517          	auipc	a0,0x7
    1b1a:	c7a50513          	addi	a0,a0,-902 # 8790 <malloc+0xd18>
    1b1e:	00006097          	auipc	ra,0x6
    1b22:	d68080e7          	jalr	-664(ra) # 7886 <printf>
      exit(1);
    1b26:	4505                	li	a0,1
    1b28:	00006097          	auipc	ra,0x6
    1b2c:	820080e7          	jalr	-2016(ra) # 7348 <exit>
    }
    if(exec("echo", echoargv) < 0){
    1b30:	fc840793          	addi	a5,s0,-56
    1b34:	85be                	mv	a1,a5
    1b36:	00006517          	auipc	a0,0x6
    1b3a:	60250513          	addi	a0,a0,1538 # 8138 <malloc+0x6c0>
    1b3e:	00006097          	auipc	ra,0x6
    1b42:	842080e7          	jalr	-1982(ra) # 7380 <exec>
    1b46:	87aa                	mv	a5,a0
    1b48:	0207d163          	bgez	a5,1b6a <exectest+0x128>
      printf("%s: exec echo failed\n", s);
    1b4c:	fb843583          	ld	a1,-72(s0)
    1b50:	00007517          	auipc	a0,0x7
    1b54:	c5050513          	addi	a0,a0,-944 # 87a0 <malloc+0xd28>
    1b58:	00006097          	auipc	ra,0x6
    1b5c:	d2e080e7          	jalr	-722(ra) # 7886 <printf>
      exit(1);
    1b60:	4505                	li	a0,1
    1b62:	00005097          	auipc	ra,0x5
    1b66:	7e6080e7          	jalr	2022(ra) # 7348 <exit>
    }
    // won't get to here
  }
  if (wait(&xstatus) != pid) {
    1b6a:	fe440793          	addi	a5,s0,-28
    1b6e:	853e                	mv	a0,a5
    1b70:	00005097          	auipc	ra,0x5
    1b74:	7e0080e7          	jalr	2016(ra) # 7350 <wait>
    1b78:	87aa                	mv	a5,a0
    1b7a:	873e                	mv	a4,a5
    1b7c:	fec42783          	lw	a5,-20(s0)
    1b80:	2781                	sext.w	a5,a5
    1b82:	00e78c63          	beq	a5,a4,1b9a <exectest+0x158>
    printf("%s: wait failed!\n", s);
    1b86:	fb843583          	ld	a1,-72(s0)
    1b8a:	00007517          	auipc	a0,0x7
    1b8e:	c2e50513          	addi	a0,a0,-978 # 87b8 <malloc+0xd40>
    1b92:	00006097          	auipc	ra,0x6
    1b96:	cf4080e7          	jalr	-780(ra) # 7886 <printf>
  }
  if(xstatus != 0)
    1b9a:	fe442783          	lw	a5,-28(s0)
    1b9e:	cb81                	beqz	a5,1bae <exectest+0x16c>
    exit(xstatus);
    1ba0:	fe442783          	lw	a5,-28(s0)
    1ba4:	853e                	mv	a0,a5
    1ba6:	00005097          	auipc	ra,0x5
    1baa:	7a2080e7          	jalr	1954(ra) # 7348 <exit>

  fd = open("echo-ok", O_RDONLY);
    1bae:	4581                	li	a1,0
    1bb0:	00007517          	auipc	a0,0x7
    1bb4:	bc050513          	addi	a0,a0,-1088 # 8770 <malloc+0xcf8>
    1bb8:	00005097          	auipc	ra,0x5
    1bbc:	7d0080e7          	jalr	2000(ra) # 7388 <open>
    1bc0:	87aa                	mv	a5,a0
    1bc2:	fef42423          	sw	a5,-24(s0)
  if(fd < 0) {
    1bc6:	fe842783          	lw	a5,-24(s0)
    1bca:	2781                	sext.w	a5,a5
    1bcc:	0207d163          	bgez	a5,1bee <exectest+0x1ac>
    printf("%s: open failed\n", s);
    1bd0:	fb843583          	ld	a1,-72(s0)
    1bd4:	00006517          	auipc	a0,0x6
    1bd8:	79450513          	addi	a0,a0,1940 # 8368 <malloc+0x8f0>
    1bdc:	00006097          	auipc	ra,0x6
    1be0:	caa080e7          	jalr	-854(ra) # 7886 <printf>
    exit(1);
    1be4:	4505                	li	a0,1
    1be6:	00005097          	auipc	ra,0x5
    1bea:	762080e7          	jalr	1890(ra) # 7348 <exit>
  }
  if (read(fd, buf, 2) != 2) {
    1bee:	fc040713          	addi	a4,s0,-64
    1bf2:	fe842783          	lw	a5,-24(s0)
    1bf6:	4609                	li	a2,2
    1bf8:	85ba                	mv	a1,a4
    1bfa:	853e                	mv	a0,a5
    1bfc:	00005097          	auipc	ra,0x5
    1c00:	764080e7          	jalr	1892(ra) # 7360 <read>
    1c04:	87aa                	mv	a5,a0
    1c06:	873e                	mv	a4,a5
    1c08:	4789                	li	a5,2
    1c0a:	02f70163          	beq	a4,a5,1c2c <exectest+0x1ea>
    printf("%s: read failed\n", s);
    1c0e:	fb843583          	ld	a1,-72(s0)
    1c12:	00007517          	auipc	a0,0x7
    1c16:	9d650513          	addi	a0,a0,-1578 # 85e8 <malloc+0xb70>
    1c1a:	00006097          	auipc	ra,0x6
    1c1e:	c6c080e7          	jalr	-916(ra) # 7886 <printf>
    exit(1);
    1c22:	4505                	li	a0,1
    1c24:	00005097          	auipc	ra,0x5
    1c28:	724080e7          	jalr	1828(ra) # 7348 <exit>
  }
  unlink("echo-ok");
    1c2c:	00007517          	auipc	a0,0x7
    1c30:	b4450513          	addi	a0,a0,-1212 # 8770 <malloc+0xcf8>
    1c34:	00005097          	auipc	ra,0x5
    1c38:	764080e7          	jalr	1892(ra) # 7398 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    1c3c:	fc044783          	lbu	a5,-64(s0)
    1c40:	873e                	mv	a4,a5
    1c42:	04f00793          	li	a5,79
    1c46:	00f71e63          	bne	a4,a5,1c62 <exectest+0x220>
    1c4a:	fc144783          	lbu	a5,-63(s0)
    1c4e:	873e                	mv	a4,a5
    1c50:	04b00793          	li	a5,75
    1c54:	00f71763          	bne	a4,a5,1c62 <exectest+0x220>
    exit(0);
    1c58:	4501                	li	a0,0
    1c5a:	00005097          	auipc	ra,0x5
    1c5e:	6ee080e7          	jalr	1774(ra) # 7348 <exit>
  else {
    printf("%s: wrong output\n", s);
    1c62:	fb843583          	ld	a1,-72(s0)
    1c66:	00007517          	auipc	a0,0x7
    1c6a:	b6a50513          	addi	a0,a0,-1174 # 87d0 <malloc+0xd58>
    1c6e:	00006097          	auipc	ra,0x6
    1c72:	c18080e7          	jalr	-1000(ra) # 7886 <printf>
    exit(1);
    1c76:	4505                	li	a0,1
    1c78:	00005097          	auipc	ra,0x5
    1c7c:	6d0080e7          	jalr	1744(ra) # 7348 <exit>

0000000000001c80 <pipe1>:

// simple fork and pipe read/write

void
pipe1(char *s)
{
    1c80:	715d                	addi	sp,sp,-80
    1c82:	e486                	sd	ra,72(sp)
    1c84:	e0a2                	sd	s0,64(sp)
    1c86:	0880                	addi	s0,sp,80
    1c88:	faa43c23          	sd	a0,-72(s0)
  int fds[2], pid, xstatus;
  int seq, i, n, cc, total;
  enum { N=5, SZ=1033 };
  
  if(pipe(fds) != 0){
    1c8c:	fd040793          	addi	a5,s0,-48
    1c90:	853e                	mv	a0,a5
    1c92:	00005097          	auipc	ra,0x5
    1c96:	6c6080e7          	jalr	1734(ra) # 7358 <pipe>
    1c9a:	87aa                	mv	a5,a0
    1c9c:	c385                	beqz	a5,1cbc <pipe1+0x3c>
    printf("%s: pipe() failed\n", s);
    1c9e:	fb843583          	ld	a1,-72(s0)
    1ca2:	00007517          	auipc	a0,0x7
    1ca6:	b4650513          	addi	a0,a0,-1210 # 87e8 <malloc+0xd70>
    1caa:	00006097          	auipc	ra,0x6
    1cae:	bdc080e7          	jalr	-1060(ra) # 7886 <printf>
    exit(1);
    1cb2:	4505                	li	a0,1
    1cb4:	00005097          	auipc	ra,0x5
    1cb8:	694080e7          	jalr	1684(ra) # 7348 <exit>
  }
  pid = fork();
    1cbc:	00005097          	auipc	ra,0x5
    1cc0:	684080e7          	jalr	1668(ra) # 7340 <fork>
    1cc4:	87aa                	mv	a5,a0
    1cc6:	fcf42c23          	sw	a5,-40(s0)
  seq = 0;
    1cca:	fe042623          	sw	zero,-20(s0)
  if(pid == 0){
    1cce:	fd842783          	lw	a5,-40(s0)
    1cd2:	2781                	sext.w	a5,a5
    1cd4:	efdd                	bnez	a5,1d92 <pipe1+0x112>
    close(fds[0]);
    1cd6:	fd042783          	lw	a5,-48(s0)
    1cda:	853e                	mv	a0,a5
    1cdc:	00005097          	auipc	ra,0x5
    1ce0:	694080e7          	jalr	1684(ra) # 7370 <close>
    for(n = 0; n < N; n++){
    1ce4:	fe042223          	sw	zero,-28(s0)
    1ce8:	a849                	j	1d7a <pipe1+0xfa>
      for(i = 0; i < SZ; i++)
    1cea:	fe042423          	sw	zero,-24(s0)
    1cee:	a03d                	j	1d1c <pipe1+0x9c>
        buf[i] = seq++;
    1cf0:	fec42783          	lw	a5,-20(s0)
    1cf4:	0017871b          	addiw	a4,a5,1
    1cf8:	fee42623          	sw	a4,-20(s0)
    1cfc:	0ff7f713          	andi	a4,a5,255
    1d00:	00008697          	auipc	a3,0x8
    1d04:	71068693          	addi	a3,a3,1808 # a410 <buf>
    1d08:	fe842783          	lw	a5,-24(s0)
    1d0c:	97b6                	add	a5,a5,a3
    1d0e:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1d12:	fe842783          	lw	a5,-24(s0)
    1d16:	2785                	addiw	a5,a5,1
    1d18:	fef42423          	sw	a5,-24(s0)
    1d1c:	fe842783          	lw	a5,-24(s0)
    1d20:	0007871b          	sext.w	a4,a5
    1d24:	40800793          	li	a5,1032
    1d28:	fce7d4e3          	bge	a5,a4,1cf0 <pipe1+0x70>
      if(write(fds[1], buf, SZ) != SZ){
    1d2c:	fd442783          	lw	a5,-44(s0)
    1d30:	40900613          	li	a2,1033
    1d34:	00008597          	auipc	a1,0x8
    1d38:	6dc58593          	addi	a1,a1,1756 # a410 <buf>
    1d3c:	853e                	mv	a0,a5
    1d3e:	00005097          	auipc	ra,0x5
    1d42:	62a080e7          	jalr	1578(ra) # 7368 <write>
    1d46:	87aa                	mv	a5,a0
    1d48:	873e                	mv	a4,a5
    1d4a:	40900793          	li	a5,1033
    1d4e:	02f70163          	beq	a4,a5,1d70 <pipe1+0xf0>
        printf("%s: pipe1 oops 1\n", s);
    1d52:	fb843583          	ld	a1,-72(s0)
    1d56:	00007517          	auipc	a0,0x7
    1d5a:	aaa50513          	addi	a0,a0,-1366 # 8800 <malloc+0xd88>
    1d5e:	00006097          	auipc	ra,0x6
    1d62:	b28080e7          	jalr	-1240(ra) # 7886 <printf>
        exit(1);
    1d66:	4505                	li	a0,1
    1d68:	00005097          	auipc	ra,0x5
    1d6c:	5e0080e7          	jalr	1504(ra) # 7348 <exit>
    for(n = 0; n < N; n++){
    1d70:	fe442783          	lw	a5,-28(s0)
    1d74:	2785                	addiw	a5,a5,1
    1d76:	fef42223          	sw	a5,-28(s0)
    1d7a:	fe442783          	lw	a5,-28(s0)
    1d7e:	0007871b          	sext.w	a4,a5
    1d82:	4791                	li	a5,4
    1d84:	f6e7d3e3          	bge	a5,a4,1cea <pipe1+0x6a>
      }
    }
    exit(0);
    1d88:	4501                	li	a0,0
    1d8a:	00005097          	auipc	ra,0x5
    1d8e:	5be080e7          	jalr	1470(ra) # 7348 <exit>
  } else if(pid > 0){
    1d92:	fd842783          	lw	a5,-40(s0)
    1d96:	2781                	sext.w	a5,a5
    1d98:	12f05b63          	blez	a5,1ece <pipe1+0x24e>
    close(fds[1]);
    1d9c:	fd442783          	lw	a5,-44(s0)
    1da0:	853e                	mv	a0,a5
    1da2:	00005097          	auipc	ra,0x5
    1da6:	5ce080e7          	jalr	1486(ra) # 7370 <close>
    total = 0;
    1daa:	fc042e23          	sw	zero,-36(s0)
    cc = 1;
    1dae:	4785                	li	a5,1
    1db0:	fef42023          	sw	a5,-32(s0)
    while((n = read(fds[0], buf, cc)) > 0){
    1db4:	a849                	j	1e46 <pipe1+0x1c6>
      for(i = 0; i < n; i++){
    1db6:	fe042423          	sw	zero,-24(s0)
    1dba:	a881                	j	1e0a <pipe1+0x18a>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1dbc:	00008717          	auipc	a4,0x8
    1dc0:	65470713          	addi	a4,a4,1620 # a410 <buf>
    1dc4:	fe842783          	lw	a5,-24(s0)
    1dc8:	97ba                	add	a5,a5,a4
    1dca:	0007c783          	lbu	a5,0(a5)
    1dce:	0007869b          	sext.w	a3,a5
    1dd2:	fec42783          	lw	a5,-20(s0)
    1dd6:	0017871b          	addiw	a4,a5,1
    1dda:	fee42623          	sw	a4,-20(s0)
    1dde:	0ff7f793          	andi	a5,a5,255
    1de2:	2781                	sext.w	a5,a5
    1de4:	8736                	mv	a4,a3
    1de6:	00f70d63          	beq	a4,a5,1e00 <pipe1+0x180>
          printf("%s: pipe1 oops 2\n", s);
    1dea:	fb843583          	ld	a1,-72(s0)
    1dee:	00007517          	auipc	a0,0x7
    1df2:	a2a50513          	addi	a0,a0,-1494 # 8818 <malloc+0xda0>
    1df6:	00006097          	auipc	ra,0x6
    1dfa:	a90080e7          	jalr	-1392(ra) # 7886 <printf>
          return;
    1dfe:	a0fd                	j	1eec <pipe1+0x26c>
      for(i = 0; i < n; i++){
    1e00:	fe842783          	lw	a5,-24(s0)
    1e04:	2785                	addiw	a5,a5,1
    1e06:	fef42423          	sw	a5,-24(s0)
    1e0a:	fe842703          	lw	a4,-24(s0)
    1e0e:	fe442783          	lw	a5,-28(s0)
    1e12:	2701                	sext.w	a4,a4
    1e14:	2781                	sext.w	a5,a5
    1e16:	faf743e3          	blt	a4,a5,1dbc <pipe1+0x13c>
        }
      }
      total += n;
    1e1a:	fdc42703          	lw	a4,-36(s0)
    1e1e:	fe442783          	lw	a5,-28(s0)
    1e22:	9fb9                	addw	a5,a5,a4
    1e24:	fcf42e23          	sw	a5,-36(s0)
      cc = cc * 2;
    1e28:	fe042783          	lw	a5,-32(s0)
    1e2c:	0017979b          	slliw	a5,a5,0x1
    1e30:	fef42023          	sw	a5,-32(s0)
      if(cc > sizeof(buf))
    1e34:	fe042783          	lw	a5,-32(s0)
    1e38:	873e                	mv	a4,a5
    1e3a:	678d                	lui	a5,0x3
    1e3c:	00e7f563          	bgeu	a5,a4,1e46 <pipe1+0x1c6>
        cc = sizeof(buf);
    1e40:	678d                	lui	a5,0x3
    1e42:	fef42023          	sw	a5,-32(s0)
    while((n = read(fds[0], buf, cc)) > 0){
    1e46:	fd042783          	lw	a5,-48(s0)
    1e4a:	fe042703          	lw	a4,-32(s0)
    1e4e:	863a                	mv	a2,a4
    1e50:	00008597          	auipc	a1,0x8
    1e54:	5c058593          	addi	a1,a1,1472 # a410 <buf>
    1e58:	853e                	mv	a0,a5
    1e5a:	00005097          	auipc	ra,0x5
    1e5e:	506080e7          	jalr	1286(ra) # 7360 <read>
    1e62:	87aa                	mv	a5,a0
    1e64:	fef42223          	sw	a5,-28(s0)
    1e68:	fe442783          	lw	a5,-28(s0)
    1e6c:	2781                	sext.w	a5,a5
    1e6e:	f4f044e3          	bgtz	a5,1db6 <pipe1+0x136>
    }
    if(total != N * SZ){
    1e72:	fdc42783          	lw	a5,-36(s0)
    1e76:	0007871b          	sext.w	a4,a5
    1e7a:	6785                	lui	a5,0x1
    1e7c:	42d78793          	addi	a5,a5,1069 # 142d <opentest+0x67>
    1e80:	02f70263          	beq	a4,a5,1ea4 <pipe1+0x224>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1e84:	fdc42783          	lw	a5,-36(s0)
    1e88:	85be                	mv	a1,a5
    1e8a:	00007517          	auipc	a0,0x7
    1e8e:	9a650513          	addi	a0,a0,-1626 # 8830 <malloc+0xdb8>
    1e92:	00006097          	auipc	ra,0x6
    1e96:	9f4080e7          	jalr	-1548(ra) # 7886 <printf>
      exit(1);
    1e9a:	4505                	li	a0,1
    1e9c:	00005097          	auipc	ra,0x5
    1ea0:	4ac080e7          	jalr	1196(ra) # 7348 <exit>
    }
    close(fds[0]);
    1ea4:	fd042783          	lw	a5,-48(s0)
    1ea8:	853e                	mv	a0,a5
    1eaa:	00005097          	auipc	ra,0x5
    1eae:	4c6080e7          	jalr	1222(ra) # 7370 <close>
    wait(&xstatus);
    1eb2:	fcc40793          	addi	a5,s0,-52
    1eb6:	853e                	mv	a0,a5
    1eb8:	00005097          	auipc	ra,0x5
    1ebc:	498080e7          	jalr	1176(ra) # 7350 <wait>
    exit(xstatus);
    1ec0:	fcc42783          	lw	a5,-52(s0)
    1ec4:	853e                	mv	a0,a5
    1ec6:	00005097          	auipc	ra,0x5
    1eca:	482080e7          	jalr	1154(ra) # 7348 <exit>
  } else {
    printf("%s: fork() failed\n", s);
    1ece:	fb843583          	ld	a1,-72(s0)
    1ed2:	00007517          	auipc	a0,0x7
    1ed6:	97e50513          	addi	a0,a0,-1666 # 8850 <malloc+0xdd8>
    1eda:	00006097          	auipc	ra,0x6
    1ede:	9ac080e7          	jalr	-1620(ra) # 7886 <printf>
    exit(1);
    1ee2:	4505                	li	a0,1
    1ee4:	00005097          	auipc	ra,0x5
    1ee8:	464080e7          	jalr	1124(ra) # 7348 <exit>
  }
}
    1eec:	60a6                	ld	ra,72(sp)
    1eee:	6406                	ld	s0,64(sp)
    1ef0:	6161                	addi	sp,sp,80
    1ef2:	8082                	ret

0000000000001ef4 <killstatus>:


// test if child is killed (status = -1)
void
killstatus(char *s)
{
    1ef4:	7179                	addi	sp,sp,-48
    1ef6:	f406                	sd	ra,40(sp)
    1ef8:	f022                	sd	s0,32(sp)
    1efa:	1800                	addi	s0,sp,48
    1efc:	fca43c23          	sd	a0,-40(s0)
  int xst;
  
  for(int i = 0; i < 100; i++){
    1f00:	fe042623          	sw	zero,-20(s0)
    1f04:	a055                	j	1fa8 <killstatus+0xb4>
    int pid1 = fork();
    1f06:	00005097          	auipc	ra,0x5
    1f0a:	43a080e7          	jalr	1082(ra) # 7340 <fork>
    1f0e:	87aa                	mv	a5,a0
    1f10:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    1f14:	fe842783          	lw	a5,-24(s0)
    1f18:	2781                	sext.w	a5,a5
    1f1a:	0207d163          	bgez	a5,1f3c <killstatus+0x48>
      printf("%s: fork failed\n", s);
    1f1e:	fd843583          	ld	a1,-40(s0)
    1f22:	00006517          	auipc	a0,0x6
    1f26:	42e50513          	addi	a0,a0,1070 # 8350 <malloc+0x8d8>
    1f2a:	00006097          	auipc	ra,0x6
    1f2e:	95c080e7          	jalr	-1700(ra) # 7886 <printf>
      exit(1);
    1f32:	4505                	li	a0,1
    1f34:	00005097          	auipc	ra,0x5
    1f38:	414080e7          	jalr	1044(ra) # 7348 <exit>
    }
    if(pid1 == 0){
    1f3c:	fe842783          	lw	a5,-24(s0)
    1f40:	2781                	sext.w	a5,a5
    1f42:	e791                	bnez	a5,1f4e <killstatus+0x5a>
      while(1) {
        getpid();
    1f44:	00005097          	auipc	ra,0x5
    1f48:	484080e7          	jalr	1156(ra) # 73c8 <getpid>
    1f4c:	bfe5                	j	1f44 <killstatus+0x50>
      }
      exit(0);
    }
    sleep(1);
    1f4e:	4505                	li	a0,1
    1f50:	00005097          	auipc	ra,0x5
    1f54:	488080e7          	jalr	1160(ra) # 73d8 <sleep>
    kill(pid1);
    1f58:	fe842783          	lw	a5,-24(s0)
    1f5c:	853e                	mv	a0,a5
    1f5e:	00005097          	auipc	ra,0x5
    1f62:	41a080e7          	jalr	1050(ra) # 7378 <kill>
    wait(&xst);
    1f66:	fe440793          	addi	a5,s0,-28
    1f6a:	853e                	mv	a0,a5
    1f6c:	00005097          	auipc	ra,0x5
    1f70:	3e4080e7          	jalr	996(ra) # 7350 <wait>
    if(xst != -1) {
    1f74:	fe442783          	lw	a5,-28(s0)
    1f78:	873e                	mv	a4,a5
    1f7a:	57fd                	li	a5,-1
    1f7c:	02f70163          	beq	a4,a5,1f9e <killstatus+0xaa>
       printf("%s: status should be -1\n", s);
    1f80:	fd843583          	ld	a1,-40(s0)
    1f84:	00007517          	auipc	a0,0x7
    1f88:	8e450513          	addi	a0,a0,-1820 # 8868 <malloc+0xdf0>
    1f8c:	00006097          	auipc	ra,0x6
    1f90:	8fa080e7          	jalr	-1798(ra) # 7886 <printf>
       exit(1);
    1f94:	4505                	li	a0,1
    1f96:	00005097          	auipc	ra,0x5
    1f9a:	3b2080e7          	jalr	946(ra) # 7348 <exit>
  for(int i = 0; i < 100; i++){
    1f9e:	fec42783          	lw	a5,-20(s0)
    1fa2:	2785                	addiw	a5,a5,1
    1fa4:	fef42623          	sw	a5,-20(s0)
    1fa8:	fec42783          	lw	a5,-20(s0)
    1fac:	0007871b          	sext.w	a4,a5
    1fb0:	06300793          	li	a5,99
    1fb4:	f4e7d9e3          	bge	a5,a4,1f06 <killstatus+0x12>
    }
  }
  exit(0);
    1fb8:	4501                	li	a0,0
    1fba:	00005097          	auipc	ra,0x5
    1fbe:	38e080e7          	jalr	910(ra) # 7348 <exit>

0000000000001fc2 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(char *s)
{
    1fc2:	7139                	addi	sp,sp,-64
    1fc4:	fc06                	sd	ra,56(sp)
    1fc6:	f822                	sd	s0,48(sp)
    1fc8:	0080                	addi	s0,sp,64
    1fca:	fca43423          	sd	a0,-56(s0)
  int pid1, pid2, pid3;
  int pfds[2];

  pid1 = fork();
    1fce:	00005097          	auipc	ra,0x5
    1fd2:	372080e7          	jalr	882(ra) # 7340 <fork>
    1fd6:	87aa                	mv	a5,a0
    1fd8:	fef42623          	sw	a5,-20(s0)
  if(pid1 < 0) {
    1fdc:	fec42783          	lw	a5,-20(s0)
    1fe0:	2781                	sext.w	a5,a5
    1fe2:	0207d163          	bgez	a5,2004 <preempt+0x42>
    printf("%s: fork failed", s);
    1fe6:	fc843583          	ld	a1,-56(s0)
    1fea:	00007517          	auipc	a0,0x7
    1fee:	89e50513          	addi	a0,a0,-1890 # 8888 <malloc+0xe10>
    1ff2:	00006097          	auipc	ra,0x6
    1ff6:	894080e7          	jalr	-1900(ra) # 7886 <printf>
    exit(1);
    1ffa:	4505                	li	a0,1
    1ffc:	00005097          	auipc	ra,0x5
    2000:	34c080e7          	jalr	844(ra) # 7348 <exit>
  }
  if(pid1 == 0)
    2004:	fec42783          	lw	a5,-20(s0)
    2008:	2781                	sext.w	a5,a5
    200a:	e391                	bnez	a5,200e <preempt+0x4c>
    for(;;)
    200c:	a001                	j	200c <preempt+0x4a>
      ;

  pid2 = fork();
    200e:	00005097          	auipc	ra,0x5
    2012:	332080e7          	jalr	818(ra) # 7340 <fork>
    2016:	87aa                	mv	a5,a0
    2018:	fef42423          	sw	a5,-24(s0)
  if(pid2 < 0) {
    201c:	fe842783          	lw	a5,-24(s0)
    2020:	2781                	sext.w	a5,a5
    2022:	0207d163          	bgez	a5,2044 <preempt+0x82>
    printf("%s: fork failed\n", s);
    2026:	fc843583          	ld	a1,-56(s0)
    202a:	00006517          	auipc	a0,0x6
    202e:	32650513          	addi	a0,a0,806 # 8350 <malloc+0x8d8>
    2032:	00006097          	auipc	ra,0x6
    2036:	854080e7          	jalr	-1964(ra) # 7886 <printf>
    exit(1);
    203a:	4505                	li	a0,1
    203c:	00005097          	auipc	ra,0x5
    2040:	30c080e7          	jalr	780(ra) # 7348 <exit>
  }
  if(pid2 == 0)
    2044:	fe842783          	lw	a5,-24(s0)
    2048:	2781                	sext.w	a5,a5
    204a:	e391                	bnez	a5,204e <preempt+0x8c>
    for(;;)
    204c:	a001                	j	204c <preempt+0x8a>
      ;

  pipe(pfds);
    204e:	fd840793          	addi	a5,s0,-40
    2052:	853e                	mv	a0,a5
    2054:	00005097          	auipc	ra,0x5
    2058:	304080e7          	jalr	772(ra) # 7358 <pipe>
  pid3 = fork();
    205c:	00005097          	auipc	ra,0x5
    2060:	2e4080e7          	jalr	740(ra) # 7340 <fork>
    2064:	87aa                	mv	a5,a0
    2066:	fef42223          	sw	a5,-28(s0)
  if(pid3 < 0) {
    206a:	fe442783          	lw	a5,-28(s0)
    206e:	2781                	sext.w	a5,a5
    2070:	0207d163          	bgez	a5,2092 <preempt+0xd0>
     printf("%s: fork failed\n", s);
    2074:	fc843583          	ld	a1,-56(s0)
    2078:	00006517          	auipc	a0,0x6
    207c:	2d850513          	addi	a0,a0,728 # 8350 <malloc+0x8d8>
    2080:	00006097          	auipc	ra,0x6
    2084:	806080e7          	jalr	-2042(ra) # 7886 <printf>
     exit(1);
    2088:	4505                	li	a0,1
    208a:	00005097          	auipc	ra,0x5
    208e:	2be080e7          	jalr	702(ra) # 7348 <exit>
  }
  if(pid3 == 0){
    2092:	fe442783          	lw	a5,-28(s0)
    2096:	2781                	sext.w	a5,a5
    2098:	ebb9                	bnez	a5,20ee <preempt+0x12c>
    close(pfds[0]);
    209a:	fd842783          	lw	a5,-40(s0)
    209e:	853e                	mv	a0,a5
    20a0:	00005097          	auipc	ra,0x5
    20a4:	2d0080e7          	jalr	720(ra) # 7370 <close>
    if(write(pfds[1], "x", 1) != 1)
    20a8:	fdc42783          	lw	a5,-36(s0)
    20ac:	4605                	li	a2,1
    20ae:	00006597          	auipc	a1,0x6
    20b2:	f7a58593          	addi	a1,a1,-134 # 8028 <malloc+0x5b0>
    20b6:	853e                	mv	a0,a5
    20b8:	00005097          	auipc	ra,0x5
    20bc:	2b0080e7          	jalr	688(ra) # 7368 <write>
    20c0:	87aa                	mv	a5,a0
    20c2:	873e                	mv	a4,a5
    20c4:	4785                	li	a5,1
    20c6:	00f70c63          	beq	a4,a5,20de <preempt+0x11c>
      printf("%s: preempt write error", s);
    20ca:	fc843583          	ld	a1,-56(s0)
    20ce:	00006517          	auipc	a0,0x6
    20d2:	7ca50513          	addi	a0,a0,1994 # 8898 <malloc+0xe20>
    20d6:	00005097          	auipc	ra,0x5
    20da:	7b0080e7          	jalr	1968(ra) # 7886 <printf>
    close(pfds[1]);
    20de:	fdc42783          	lw	a5,-36(s0)
    20e2:	853e                	mv	a0,a5
    20e4:	00005097          	auipc	ra,0x5
    20e8:	28c080e7          	jalr	652(ra) # 7370 <close>
    for(;;)
    20ec:	a001                	j	20ec <preempt+0x12a>
      ;
  }

  close(pfds[1]);
    20ee:	fdc42783          	lw	a5,-36(s0)
    20f2:	853e                	mv	a0,a5
    20f4:	00005097          	auipc	ra,0x5
    20f8:	27c080e7          	jalr	636(ra) # 7370 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    20fc:	fd842783          	lw	a5,-40(s0)
    2100:	660d                	lui	a2,0x3
    2102:	00008597          	auipc	a1,0x8
    2106:	30e58593          	addi	a1,a1,782 # a410 <buf>
    210a:	853e                	mv	a0,a5
    210c:	00005097          	auipc	ra,0x5
    2110:	254080e7          	jalr	596(ra) # 7360 <read>
    2114:	87aa                	mv	a5,a0
    2116:	873e                	mv	a4,a5
    2118:	4785                	li	a5,1
    211a:	00f70d63          	beq	a4,a5,2134 <preempt+0x172>
    printf("%s: preempt read error", s);
    211e:	fc843583          	ld	a1,-56(s0)
    2122:	00006517          	auipc	a0,0x6
    2126:	78e50513          	addi	a0,a0,1934 # 88b0 <malloc+0xe38>
    212a:	00005097          	auipc	ra,0x5
    212e:	75c080e7          	jalr	1884(ra) # 7886 <printf>
    2132:	a8a5                	j	21aa <preempt+0x1e8>
    return;
  }
  close(pfds[0]);
    2134:	fd842783          	lw	a5,-40(s0)
    2138:	853e                	mv	a0,a5
    213a:	00005097          	auipc	ra,0x5
    213e:	236080e7          	jalr	566(ra) # 7370 <close>
  printf("kill... ");
    2142:	00006517          	auipc	a0,0x6
    2146:	78650513          	addi	a0,a0,1926 # 88c8 <malloc+0xe50>
    214a:	00005097          	auipc	ra,0x5
    214e:	73c080e7          	jalr	1852(ra) # 7886 <printf>
  kill(pid1);
    2152:	fec42783          	lw	a5,-20(s0)
    2156:	853e                	mv	a0,a5
    2158:	00005097          	auipc	ra,0x5
    215c:	220080e7          	jalr	544(ra) # 7378 <kill>
  kill(pid2);
    2160:	fe842783          	lw	a5,-24(s0)
    2164:	853e                	mv	a0,a5
    2166:	00005097          	auipc	ra,0x5
    216a:	212080e7          	jalr	530(ra) # 7378 <kill>
  kill(pid3);
    216e:	fe442783          	lw	a5,-28(s0)
    2172:	853e                	mv	a0,a5
    2174:	00005097          	auipc	ra,0x5
    2178:	204080e7          	jalr	516(ra) # 7378 <kill>
  printf("wait... ");
    217c:	00006517          	auipc	a0,0x6
    2180:	75c50513          	addi	a0,a0,1884 # 88d8 <malloc+0xe60>
    2184:	00005097          	auipc	ra,0x5
    2188:	702080e7          	jalr	1794(ra) # 7886 <printf>
  wait(0);
    218c:	4501                	li	a0,0
    218e:	00005097          	auipc	ra,0x5
    2192:	1c2080e7          	jalr	450(ra) # 7350 <wait>
  wait(0);
    2196:	4501                	li	a0,0
    2198:	00005097          	auipc	ra,0x5
    219c:	1b8080e7          	jalr	440(ra) # 7350 <wait>
  wait(0);
    21a0:	4501                	li	a0,0
    21a2:	00005097          	auipc	ra,0x5
    21a6:	1ae080e7          	jalr	430(ra) # 7350 <wait>
}
    21aa:	70e2                	ld	ra,56(sp)
    21ac:	7442                	ld	s0,48(sp)
    21ae:	6121                	addi	sp,sp,64
    21b0:	8082                	ret

00000000000021b2 <exitwait>:

// try to find any races between exit and wait
void
exitwait(char *s)
{
    21b2:	7179                	addi	sp,sp,-48
    21b4:	f406                	sd	ra,40(sp)
    21b6:	f022                	sd	s0,32(sp)
    21b8:	1800                	addi	s0,sp,48
    21ba:	fca43c23          	sd	a0,-40(s0)
  int i, pid;

  for(i = 0; i < 100; i++){
    21be:	fe042623          	sw	zero,-20(s0)
    21c2:	a87d                	j	2280 <exitwait+0xce>
    pid = fork();
    21c4:	00005097          	auipc	ra,0x5
    21c8:	17c080e7          	jalr	380(ra) # 7340 <fork>
    21cc:	87aa                	mv	a5,a0
    21ce:	fef42423          	sw	a5,-24(s0)
    if(pid < 0){
    21d2:	fe842783          	lw	a5,-24(s0)
    21d6:	2781                	sext.w	a5,a5
    21d8:	0207d163          	bgez	a5,21fa <exitwait+0x48>
      printf("%s: fork failed\n", s);
    21dc:	fd843583          	ld	a1,-40(s0)
    21e0:	00006517          	auipc	a0,0x6
    21e4:	17050513          	addi	a0,a0,368 # 8350 <malloc+0x8d8>
    21e8:	00005097          	auipc	ra,0x5
    21ec:	69e080e7          	jalr	1694(ra) # 7886 <printf>
      exit(1);
    21f0:	4505                	li	a0,1
    21f2:	00005097          	auipc	ra,0x5
    21f6:	156080e7          	jalr	342(ra) # 7348 <exit>
    }
    if(pid){
    21fa:	fe842783          	lw	a5,-24(s0)
    21fe:	2781                	sext.w	a5,a5
    2200:	c7a5                	beqz	a5,2268 <exitwait+0xb6>
      int xstate;
      if(wait(&xstate) != pid){
    2202:	fe440793          	addi	a5,s0,-28
    2206:	853e                	mv	a0,a5
    2208:	00005097          	auipc	ra,0x5
    220c:	148080e7          	jalr	328(ra) # 7350 <wait>
    2210:	87aa                	mv	a5,a0
    2212:	873e                	mv	a4,a5
    2214:	fe842783          	lw	a5,-24(s0)
    2218:	2781                	sext.w	a5,a5
    221a:	02e78163          	beq	a5,a4,223c <exitwait+0x8a>
        printf("%s: wait wrong pid\n", s);
    221e:	fd843583          	ld	a1,-40(s0)
    2222:	00006517          	auipc	a0,0x6
    2226:	6c650513          	addi	a0,a0,1734 # 88e8 <malloc+0xe70>
    222a:	00005097          	auipc	ra,0x5
    222e:	65c080e7          	jalr	1628(ra) # 7886 <printf>
        exit(1);
    2232:	4505                	li	a0,1
    2234:	00005097          	auipc	ra,0x5
    2238:	114080e7          	jalr	276(ra) # 7348 <exit>
      }
      if(i != xstate) {
    223c:	fe442703          	lw	a4,-28(s0)
    2240:	fec42783          	lw	a5,-20(s0)
    2244:	2781                	sext.w	a5,a5
    2246:	02e78863          	beq	a5,a4,2276 <exitwait+0xc4>
        printf("%s: wait wrong exit status\n", s);
    224a:	fd843583          	ld	a1,-40(s0)
    224e:	00006517          	auipc	a0,0x6
    2252:	6b250513          	addi	a0,a0,1714 # 8900 <malloc+0xe88>
    2256:	00005097          	auipc	ra,0x5
    225a:	630080e7          	jalr	1584(ra) # 7886 <printf>
        exit(1);
    225e:	4505                	li	a0,1
    2260:	00005097          	auipc	ra,0x5
    2264:	0e8080e7          	jalr	232(ra) # 7348 <exit>
      }
    } else {
      exit(i);
    2268:	fec42783          	lw	a5,-20(s0)
    226c:	853e                	mv	a0,a5
    226e:	00005097          	auipc	ra,0x5
    2272:	0da080e7          	jalr	218(ra) # 7348 <exit>
  for(i = 0; i < 100; i++){
    2276:	fec42783          	lw	a5,-20(s0)
    227a:	2785                	addiw	a5,a5,1
    227c:	fef42623          	sw	a5,-20(s0)
    2280:	fec42783          	lw	a5,-20(s0)
    2284:	0007871b          	sext.w	a4,a5
    2288:	06300793          	li	a5,99
    228c:	f2e7dce3          	bge	a5,a4,21c4 <exitwait+0x12>
    }
  }
}
    2290:	0001                	nop
    2292:	0001                	nop
    2294:	70a2                	ld	ra,40(sp)
    2296:	7402                	ld	s0,32(sp)
    2298:	6145                	addi	sp,sp,48
    229a:	8082                	ret

000000000000229c <reparent>:
// try to find races in the reparenting
// code that handles a parent exiting
// when it still has live children.
void
reparent(char *s)
{
    229c:	7179                	addi	sp,sp,-48
    229e:	f406                	sd	ra,40(sp)
    22a0:	f022                	sd	s0,32(sp)
    22a2:	1800                	addi	s0,sp,48
    22a4:	fca43c23          	sd	a0,-40(s0)
  int master_pid = getpid();
    22a8:	00005097          	auipc	ra,0x5
    22ac:	120080e7          	jalr	288(ra) # 73c8 <getpid>
    22b0:	87aa                	mv	a5,a0
    22b2:	fef42423          	sw	a5,-24(s0)
  for(int i = 0; i < 200; i++){
    22b6:	fe042623          	sw	zero,-20(s0)
    22ba:	a86d                	j	2374 <reparent+0xd8>
    int pid = fork();
    22bc:	00005097          	auipc	ra,0x5
    22c0:	084080e7          	jalr	132(ra) # 7340 <fork>
    22c4:	87aa                	mv	a5,a0
    22c6:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    22ca:	fe442783          	lw	a5,-28(s0)
    22ce:	2781                	sext.w	a5,a5
    22d0:	0207d163          	bgez	a5,22f2 <reparent+0x56>
      printf("%s: fork failed\n", s);
    22d4:	fd843583          	ld	a1,-40(s0)
    22d8:	00006517          	auipc	a0,0x6
    22dc:	07850513          	addi	a0,a0,120 # 8350 <malloc+0x8d8>
    22e0:	00005097          	auipc	ra,0x5
    22e4:	5a6080e7          	jalr	1446(ra) # 7886 <printf>
      exit(1);
    22e8:	4505                	li	a0,1
    22ea:	00005097          	auipc	ra,0x5
    22ee:	05e080e7          	jalr	94(ra) # 7348 <exit>
    }
    if(pid){
    22f2:	fe442783          	lw	a5,-28(s0)
    22f6:	2781                	sext.w	a5,a5
    22f8:	cf85                	beqz	a5,2330 <reparent+0x94>
      if(wait(0) != pid){
    22fa:	4501                	li	a0,0
    22fc:	00005097          	auipc	ra,0x5
    2300:	054080e7          	jalr	84(ra) # 7350 <wait>
    2304:	87aa                	mv	a5,a0
    2306:	873e                	mv	a4,a5
    2308:	fe442783          	lw	a5,-28(s0)
    230c:	2781                	sext.w	a5,a5
    230e:	04e78e63          	beq	a5,a4,236a <reparent+0xce>
        printf("%s: wait wrong pid\n", s);
    2312:	fd843583          	ld	a1,-40(s0)
    2316:	00006517          	auipc	a0,0x6
    231a:	5d250513          	addi	a0,a0,1490 # 88e8 <malloc+0xe70>
    231e:	00005097          	auipc	ra,0x5
    2322:	568080e7          	jalr	1384(ra) # 7886 <printf>
        exit(1);
    2326:	4505                	li	a0,1
    2328:	00005097          	auipc	ra,0x5
    232c:	020080e7          	jalr	32(ra) # 7348 <exit>
      }
    } else {
      int pid2 = fork();
    2330:	00005097          	auipc	ra,0x5
    2334:	010080e7          	jalr	16(ra) # 7340 <fork>
    2338:	87aa                	mv	a5,a0
    233a:	fef42023          	sw	a5,-32(s0)
      if(pid2 < 0){
    233e:	fe042783          	lw	a5,-32(s0)
    2342:	2781                	sext.w	a5,a5
    2344:	0007de63          	bgez	a5,2360 <reparent+0xc4>
        kill(master_pid);
    2348:	fe842783          	lw	a5,-24(s0)
    234c:	853e                	mv	a0,a5
    234e:	00005097          	auipc	ra,0x5
    2352:	02a080e7          	jalr	42(ra) # 7378 <kill>
        exit(1);
    2356:	4505                	li	a0,1
    2358:	00005097          	auipc	ra,0x5
    235c:	ff0080e7          	jalr	-16(ra) # 7348 <exit>
      }
      exit(0);
    2360:	4501                	li	a0,0
    2362:	00005097          	auipc	ra,0x5
    2366:	fe6080e7          	jalr	-26(ra) # 7348 <exit>
  for(int i = 0; i < 200; i++){
    236a:	fec42783          	lw	a5,-20(s0)
    236e:	2785                	addiw	a5,a5,1
    2370:	fef42623          	sw	a5,-20(s0)
    2374:	fec42783          	lw	a5,-20(s0)
    2378:	0007871b          	sext.w	a4,a5
    237c:	0c700793          	li	a5,199
    2380:	f2e7dee3          	bge	a5,a4,22bc <reparent+0x20>
    }
  }
  exit(0);
    2384:	4501                	li	a0,0
    2386:	00005097          	auipc	ra,0x5
    238a:	fc2080e7          	jalr	-62(ra) # 7348 <exit>

000000000000238e <twochildren>:
}

// what if two children exit() at the same time?
void
twochildren(char *s)
{
    238e:	7179                	addi	sp,sp,-48
    2390:	f406                	sd	ra,40(sp)
    2392:	f022                	sd	s0,32(sp)
    2394:	1800                	addi	s0,sp,48
    2396:	fca43c23          	sd	a0,-40(s0)
  for(int i = 0; i < 1000; i++){
    239a:	fe042623          	sw	zero,-20(s0)
    239e:	a845                	j	244e <twochildren+0xc0>
    int pid1 = fork();
    23a0:	00005097          	auipc	ra,0x5
    23a4:	fa0080e7          	jalr	-96(ra) # 7340 <fork>
    23a8:	87aa                	mv	a5,a0
    23aa:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    23ae:	fe842783          	lw	a5,-24(s0)
    23b2:	2781                	sext.w	a5,a5
    23b4:	0207d163          	bgez	a5,23d6 <twochildren+0x48>
      printf("%s: fork failed\n", s);
    23b8:	fd843583          	ld	a1,-40(s0)
    23bc:	00006517          	auipc	a0,0x6
    23c0:	f9450513          	addi	a0,a0,-108 # 8350 <malloc+0x8d8>
    23c4:	00005097          	auipc	ra,0x5
    23c8:	4c2080e7          	jalr	1218(ra) # 7886 <printf>
      exit(1);
    23cc:	4505                	li	a0,1
    23ce:	00005097          	auipc	ra,0x5
    23d2:	f7a080e7          	jalr	-134(ra) # 7348 <exit>
    }
    if(pid1 == 0){
    23d6:	fe842783          	lw	a5,-24(s0)
    23da:	2781                	sext.w	a5,a5
    23dc:	e791                	bnez	a5,23e8 <twochildren+0x5a>
      exit(0);
    23de:	4501                	li	a0,0
    23e0:	00005097          	auipc	ra,0x5
    23e4:	f68080e7          	jalr	-152(ra) # 7348 <exit>
    } else {
      int pid2 = fork();
    23e8:	00005097          	auipc	ra,0x5
    23ec:	f58080e7          	jalr	-168(ra) # 7340 <fork>
    23f0:	87aa                	mv	a5,a0
    23f2:	fef42223          	sw	a5,-28(s0)
      if(pid2 < 0){
    23f6:	fe442783          	lw	a5,-28(s0)
    23fa:	2781                	sext.w	a5,a5
    23fc:	0207d163          	bgez	a5,241e <twochildren+0x90>
        printf("%s: fork failed\n", s);
    2400:	fd843583          	ld	a1,-40(s0)
    2404:	00006517          	auipc	a0,0x6
    2408:	f4c50513          	addi	a0,a0,-180 # 8350 <malloc+0x8d8>
    240c:	00005097          	auipc	ra,0x5
    2410:	47a080e7          	jalr	1146(ra) # 7886 <printf>
        exit(1);
    2414:	4505                	li	a0,1
    2416:	00005097          	auipc	ra,0x5
    241a:	f32080e7          	jalr	-206(ra) # 7348 <exit>
      }
      if(pid2 == 0){
    241e:	fe442783          	lw	a5,-28(s0)
    2422:	2781                	sext.w	a5,a5
    2424:	e791                	bnez	a5,2430 <twochildren+0xa2>
        exit(0);
    2426:	4501                	li	a0,0
    2428:	00005097          	auipc	ra,0x5
    242c:	f20080e7          	jalr	-224(ra) # 7348 <exit>
      } else {
        wait(0);
    2430:	4501                	li	a0,0
    2432:	00005097          	auipc	ra,0x5
    2436:	f1e080e7          	jalr	-226(ra) # 7350 <wait>
        wait(0);
    243a:	4501                	li	a0,0
    243c:	00005097          	auipc	ra,0x5
    2440:	f14080e7          	jalr	-236(ra) # 7350 <wait>
  for(int i = 0; i < 1000; i++){
    2444:	fec42783          	lw	a5,-20(s0)
    2448:	2785                	addiw	a5,a5,1
    244a:	fef42623          	sw	a5,-20(s0)
    244e:	fec42783          	lw	a5,-20(s0)
    2452:	0007871b          	sext.w	a4,a5
    2456:	3e700793          	li	a5,999
    245a:	f4e7d3e3          	bge	a5,a4,23a0 <twochildren+0x12>
      }
    }
  }
}
    245e:	0001                	nop
    2460:	0001                	nop
    2462:	70a2                	ld	ra,40(sp)
    2464:	7402                	ld	s0,32(sp)
    2466:	6145                	addi	sp,sp,48
    2468:	8082                	ret

000000000000246a <forkfork>:

// concurrent forks to try to expose locking bugs.
void
forkfork(char *s)
{
    246a:	7139                	addi	sp,sp,-64
    246c:	fc06                	sd	ra,56(sp)
    246e:	f822                	sd	s0,48(sp)
    2470:	0080                	addi	s0,sp,64
    2472:	fca43423          	sd	a0,-56(s0)
  enum { N=2 };
  
  for(int i = 0; i < N; i++){
    2476:	fe042623          	sw	zero,-20(s0)
    247a:	a84d                	j	252c <forkfork+0xc2>
    int pid = fork();
    247c:	00005097          	auipc	ra,0x5
    2480:	ec4080e7          	jalr	-316(ra) # 7340 <fork>
    2484:	87aa                	mv	a5,a0
    2486:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    248a:	fe042783          	lw	a5,-32(s0)
    248e:	2781                	sext.w	a5,a5
    2490:	0207d163          	bgez	a5,24b2 <forkfork+0x48>
      printf("%s: fork failed", s);
    2494:	fc843583          	ld	a1,-56(s0)
    2498:	00006517          	auipc	a0,0x6
    249c:	3f050513          	addi	a0,a0,1008 # 8888 <malloc+0xe10>
    24a0:	00005097          	auipc	ra,0x5
    24a4:	3e6080e7          	jalr	998(ra) # 7886 <printf>
      exit(1);
    24a8:	4505                	li	a0,1
    24aa:	00005097          	auipc	ra,0x5
    24ae:	e9e080e7          	jalr	-354(ra) # 7348 <exit>
    }
    if(pid == 0){
    24b2:	fe042783          	lw	a5,-32(s0)
    24b6:	2781                	sext.w	a5,a5
    24b8:	e7ad                	bnez	a5,2522 <forkfork+0xb8>
      for(int j = 0; j < 200; j++){
    24ba:	fe042423          	sw	zero,-24(s0)
    24be:	a0a9                	j	2508 <forkfork+0x9e>
        int pid1 = fork();
    24c0:	00005097          	auipc	ra,0x5
    24c4:	e80080e7          	jalr	-384(ra) # 7340 <fork>
    24c8:	87aa                	mv	a5,a0
    24ca:	fcf42e23          	sw	a5,-36(s0)
        if(pid1 < 0){
    24ce:	fdc42783          	lw	a5,-36(s0)
    24d2:	2781                	sext.w	a5,a5
    24d4:	0007d763          	bgez	a5,24e2 <forkfork+0x78>
          exit(1);
    24d8:	4505                	li	a0,1
    24da:	00005097          	auipc	ra,0x5
    24de:	e6e080e7          	jalr	-402(ra) # 7348 <exit>
        }
        if(pid1 == 0){
    24e2:	fdc42783          	lw	a5,-36(s0)
    24e6:	2781                	sext.w	a5,a5
    24e8:	e791                	bnez	a5,24f4 <forkfork+0x8a>
          exit(0);
    24ea:	4501                	li	a0,0
    24ec:	00005097          	auipc	ra,0x5
    24f0:	e5c080e7          	jalr	-420(ra) # 7348 <exit>
        }
        wait(0);
    24f4:	4501                	li	a0,0
    24f6:	00005097          	auipc	ra,0x5
    24fa:	e5a080e7          	jalr	-422(ra) # 7350 <wait>
      for(int j = 0; j < 200; j++){
    24fe:	fe842783          	lw	a5,-24(s0)
    2502:	2785                	addiw	a5,a5,1
    2504:	fef42423          	sw	a5,-24(s0)
    2508:	fe842783          	lw	a5,-24(s0)
    250c:	0007871b          	sext.w	a4,a5
    2510:	0c700793          	li	a5,199
    2514:	fae7d6e3          	bge	a5,a4,24c0 <forkfork+0x56>
      }
      exit(0);
    2518:	4501                	li	a0,0
    251a:	00005097          	auipc	ra,0x5
    251e:	e2e080e7          	jalr	-466(ra) # 7348 <exit>
  for(int i = 0; i < N; i++){
    2522:	fec42783          	lw	a5,-20(s0)
    2526:	2785                	addiw	a5,a5,1
    2528:	fef42623          	sw	a5,-20(s0)
    252c:	fec42783          	lw	a5,-20(s0)
    2530:	0007871b          	sext.w	a4,a5
    2534:	4785                	li	a5,1
    2536:	f4e7d3e3          	bge	a5,a4,247c <forkfork+0x12>
    }
  }

  int xstatus;
  for(int i = 0; i < N; i++){
    253a:	fe042223          	sw	zero,-28(s0)
    253e:	a83d                	j	257c <forkfork+0x112>
    wait(&xstatus);
    2540:	fd840793          	addi	a5,s0,-40
    2544:	853e                	mv	a0,a5
    2546:	00005097          	auipc	ra,0x5
    254a:	e0a080e7          	jalr	-502(ra) # 7350 <wait>
    if(xstatus != 0) {
    254e:	fd842783          	lw	a5,-40(s0)
    2552:	c385                	beqz	a5,2572 <forkfork+0x108>
      printf("%s: fork in child failed", s);
    2554:	fc843583          	ld	a1,-56(s0)
    2558:	00006517          	auipc	a0,0x6
    255c:	3c850513          	addi	a0,a0,968 # 8920 <malloc+0xea8>
    2560:	00005097          	auipc	ra,0x5
    2564:	326080e7          	jalr	806(ra) # 7886 <printf>
      exit(1);
    2568:	4505                	li	a0,1
    256a:	00005097          	auipc	ra,0x5
    256e:	dde080e7          	jalr	-546(ra) # 7348 <exit>
  for(int i = 0; i < N; i++){
    2572:	fe442783          	lw	a5,-28(s0)
    2576:	2785                	addiw	a5,a5,1
    2578:	fef42223          	sw	a5,-28(s0)
    257c:	fe442783          	lw	a5,-28(s0)
    2580:	0007871b          	sext.w	a4,a5
    2584:	4785                	li	a5,1
    2586:	fae7dde3          	bge	a5,a4,2540 <forkfork+0xd6>
    }
  }
}
    258a:	0001                	nop
    258c:	0001                	nop
    258e:	70e2                	ld	ra,56(sp)
    2590:	7442                	ld	s0,48(sp)
    2592:	6121                	addi	sp,sp,64
    2594:	8082                	ret

0000000000002596 <forkforkfork>:

void
forkforkfork(char *s)
{
    2596:	7179                	addi	sp,sp,-48
    2598:	f406                	sd	ra,40(sp)
    259a:	f022                	sd	s0,32(sp)
    259c:	1800                	addi	s0,sp,48
    259e:	fca43c23          	sd	a0,-40(s0)
  unlink("stopforking");
    25a2:	00006517          	auipc	a0,0x6
    25a6:	39e50513          	addi	a0,a0,926 # 8940 <malloc+0xec8>
    25aa:	00005097          	auipc	ra,0x5
    25ae:	dee080e7          	jalr	-530(ra) # 7398 <unlink>

  int pid = fork();
    25b2:	00005097          	auipc	ra,0x5
    25b6:	d8e080e7          	jalr	-626(ra) # 7340 <fork>
    25ba:	87aa                	mv	a5,a0
    25bc:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    25c0:	fec42783          	lw	a5,-20(s0)
    25c4:	2781                	sext.w	a5,a5
    25c6:	0207d163          	bgez	a5,25e8 <forkforkfork+0x52>
    printf("%s: fork failed", s);
    25ca:	fd843583          	ld	a1,-40(s0)
    25ce:	00006517          	auipc	a0,0x6
    25d2:	2ba50513          	addi	a0,a0,698 # 8888 <malloc+0xe10>
    25d6:	00005097          	auipc	ra,0x5
    25da:	2b0080e7          	jalr	688(ra) # 7886 <printf>
    exit(1);
    25de:	4505                	li	a0,1
    25e0:	00005097          	auipc	ra,0x5
    25e4:	d68080e7          	jalr	-664(ra) # 7348 <exit>
  }
  if(pid == 0){
    25e8:	fec42783          	lw	a5,-20(s0)
    25ec:	2781                	sext.w	a5,a5
    25ee:	efb9                	bnez	a5,264c <forkforkfork+0xb6>
    while(1){
      int fd = open("stopforking", 0);
    25f0:	4581                	li	a1,0
    25f2:	00006517          	auipc	a0,0x6
    25f6:	34e50513          	addi	a0,a0,846 # 8940 <malloc+0xec8>
    25fa:	00005097          	auipc	ra,0x5
    25fe:	d8e080e7          	jalr	-626(ra) # 7388 <open>
    2602:	87aa                	mv	a5,a0
    2604:	fef42423          	sw	a5,-24(s0)
      if(fd >= 0){
    2608:	fe842783          	lw	a5,-24(s0)
    260c:	2781                	sext.w	a5,a5
    260e:	0007c763          	bltz	a5,261c <forkforkfork+0x86>
        exit(0);
    2612:	4501                	li	a0,0
    2614:	00005097          	auipc	ra,0x5
    2618:	d34080e7          	jalr	-716(ra) # 7348 <exit>
      }
      if(fork() < 0){
    261c:	00005097          	auipc	ra,0x5
    2620:	d24080e7          	jalr	-732(ra) # 7340 <fork>
    2624:	87aa                	mv	a5,a0
    2626:	fc07d5e3          	bgez	a5,25f0 <forkforkfork+0x5a>
        close(open("stopforking", O_CREATE|O_RDWR));
    262a:	20200593          	li	a1,514
    262e:	00006517          	auipc	a0,0x6
    2632:	31250513          	addi	a0,a0,786 # 8940 <malloc+0xec8>
    2636:	00005097          	auipc	ra,0x5
    263a:	d52080e7          	jalr	-686(ra) # 7388 <open>
    263e:	87aa                	mv	a5,a0
    2640:	853e                	mv	a0,a5
    2642:	00005097          	auipc	ra,0x5
    2646:	d2e080e7          	jalr	-722(ra) # 7370 <close>
    while(1){
    264a:	b75d                	j	25f0 <forkforkfork+0x5a>
    }

    exit(0);
  }

  sleep(20); // two seconds
    264c:	4551                	li	a0,20
    264e:	00005097          	auipc	ra,0x5
    2652:	d8a080e7          	jalr	-630(ra) # 73d8 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    2656:	20200593          	li	a1,514
    265a:	00006517          	auipc	a0,0x6
    265e:	2e650513          	addi	a0,a0,742 # 8940 <malloc+0xec8>
    2662:	00005097          	auipc	ra,0x5
    2666:	d26080e7          	jalr	-730(ra) # 7388 <open>
    266a:	87aa                	mv	a5,a0
    266c:	853e                	mv	a0,a5
    266e:	00005097          	auipc	ra,0x5
    2672:	d02080e7          	jalr	-766(ra) # 7370 <close>
  wait(0);
    2676:	4501                	li	a0,0
    2678:	00005097          	auipc	ra,0x5
    267c:	cd8080e7          	jalr	-808(ra) # 7350 <wait>
  sleep(10); // one second
    2680:	4529                	li	a0,10
    2682:	00005097          	auipc	ra,0x5
    2686:	d56080e7          	jalr	-682(ra) # 73d8 <sleep>
}
    268a:	0001                	nop
    268c:	70a2                	ld	ra,40(sp)
    268e:	7402                	ld	s0,32(sp)
    2690:	6145                	addi	sp,sp,48
    2692:	8082                	ret

0000000000002694 <reparent2>:
// deadlocks against init's wait()? also used to trigger a "panic:
// release" due to exit() releasing a different p->parent->lock than
// it acquired.
void
reparent2(char *s)
{
    2694:	7179                	addi	sp,sp,-48
    2696:	f406                	sd	ra,40(sp)
    2698:	f022                	sd	s0,32(sp)
    269a:	1800                	addi	s0,sp,48
    269c:	fca43c23          	sd	a0,-40(s0)
  for(int i = 0; i < 800; i++){
    26a0:	fe042623          	sw	zero,-20(s0)
    26a4:	a0ad                	j	270e <reparent2+0x7a>
    int pid1 = fork();
    26a6:	00005097          	auipc	ra,0x5
    26aa:	c9a080e7          	jalr	-870(ra) # 7340 <fork>
    26ae:	87aa                	mv	a5,a0
    26b0:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    26b4:	fe842783          	lw	a5,-24(s0)
    26b8:	2781                	sext.w	a5,a5
    26ba:	0007df63          	bgez	a5,26d8 <reparent2+0x44>
      printf("fork failed\n");
    26be:	00006517          	auipc	a0,0x6
    26c2:	a6a50513          	addi	a0,a0,-1430 # 8128 <malloc+0x6b0>
    26c6:	00005097          	auipc	ra,0x5
    26ca:	1c0080e7          	jalr	448(ra) # 7886 <printf>
      exit(1);
    26ce:	4505                	li	a0,1
    26d0:	00005097          	auipc	ra,0x5
    26d4:	c78080e7          	jalr	-904(ra) # 7348 <exit>
    }
    if(pid1 == 0){
    26d8:	fe842783          	lw	a5,-24(s0)
    26dc:	2781                	sext.w	a5,a5
    26de:	ef91                	bnez	a5,26fa <reparent2+0x66>
      fork();
    26e0:	00005097          	auipc	ra,0x5
    26e4:	c60080e7          	jalr	-928(ra) # 7340 <fork>
      fork();
    26e8:	00005097          	auipc	ra,0x5
    26ec:	c58080e7          	jalr	-936(ra) # 7340 <fork>
      exit(0);
    26f0:	4501                	li	a0,0
    26f2:	00005097          	auipc	ra,0x5
    26f6:	c56080e7          	jalr	-938(ra) # 7348 <exit>
    }
    wait(0);
    26fa:	4501                	li	a0,0
    26fc:	00005097          	auipc	ra,0x5
    2700:	c54080e7          	jalr	-940(ra) # 7350 <wait>
  for(int i = 0; i < 800; i++){
    2704:	fec42783          	lw	a5,-20(s0)
    2708:	2785                	addiw	a5,a5,1
    270a:	fef42623          	sw	a5,-20(s0)
    270e:	fec42783          	lw	a5,-20(s0)
    2712:	0007871b          	sext.w	a4,a5
    2716:	31f00793          	li	a5,799
    271a:	f8e7d6e3          	bge	a5,a4,26a6 <reparent2+0x12>
  }

  exit(0);
    271e:	4501                	li	a0,0
    2720:	00005097          	auipc	ra,0x5
    2724:	c28080e7          	jalr	-984(ra) # 7348 <exit>

0000000000002728 <mem>:
}

// allocate all mem, free it, and allocate again
void
mem(char *s)
{
    2728:	7139                	addi	sp,sp,-64
    272a:	fc06                	sd	ra,56(sp)
    272c:	f822                	sd	s0,48(sp)
    272e:	0080                	addi	s0,sp,64
    2730:	fca43423          	sd	a0,-56(s0)
  void *m1, *m2;
  int pid;

  if((pid = fork()) == 0){
    2734:	00005097          	auipc	ra,0x5
    2738:	c0c080e7          	jalr	-1012(ra) # 7340 <fork>
    273c:	87aa                	mv	a5,a0
    273e:	fef42223          	sw	a5,-28(s0)
    2742:	fe442783          	lw	a5,-28(s0)
    2746:	2781                	sext.w	a5,a5
    2748:	e3c5                	bnez	a5,27e8 <mem+0xc0>
    m1 = 0;
    274a:	fe043423          	sd	zero,-24(s0)
    while((m2 = malloc(10001)) != 0){
    274e:	a811                	j	2762 <mem+0x3a>
      *(char**)m2 = m1;
    2750:	fd843783          	ld	a5,-40(s0)
    2754:	fe843703          	ld	a4,-24(s0)
    2758:	e398                	sd	a4,0(a5)
      m1 = m2;
    275a:	fd843783          	ld	a5,-40(s0)
    275e:	fef43423          	sd	a5,-24(s0)
    while((m2 = malloc(10001)) != 0){
    2762:	6789                	lui	a5,0x2
    2764:	71178513          	addi	a0,a5,1809 # 2711 <reparent2+0x7d>
    2768:	00005097          	auipc	ra,0x5
    276c:	310080e7          	jalr	784(ra) # 7a78 <malloc>
    2770:	fca43c23          	sd	a0,-40(s0)
    2774:	fd843783          	ld	a5,-40(s0)
    2778:	ffe1                	bnez	a5,2750 <mem+0x28>
    }
    while(m1){
    277a:	a005                	j	279a <mem+0x72>
      m2 = *(char**)m1;
    277c:	fe843783          	ld	a5,-24(s0)
    2780:	639c                	ld	a5,0(a5)
    2782:	fcf43c23          	sd	a5,-40(s0)
      free(m1);
    2786:	fe843503          	ld	a0,-24(s0)
    278a:	00005097          	auipc	ra,0x5
    278e:	14c080e7          	jalr	332(ra) # 78d6 <free>
      m1 = m2;
    2792:	fd843783          	ld	a5,-40(s0)
    2796:	fef43423          	sd	a5,-24(s0)
    while(m1){
    279a:	fe843783          	ld	a5,-24(s0)
    279e:	fff9                	bnez	a5,277c <mem+0x54>
    }
    m1 = malloc(1024*20);
    27a0:	6515                	lui	a0,0x5
    27a2:	00005097          	auipc	ra,0x5
    27a6:	2d6080e7          	jalr	726(ra) # 7a78 <malloc>
    27aa:	fea43423          	sd	a0,-24(s0)
    if(m1 == 0){
    27ae:	fe843783          	ld	a5,-24(s0)
    27b2:	e385                	bnez	a5,27d2 <mem+0xaa>
      printf("couldn't allocate mem?!!\n", s);
    27b4:	fc843583          	ld	a1,-56(s0)
    27b8:	00006517          	auipc	a0,0x6
    27bc:	19850513          	addi	a0,a0,408 # 8950 <malloc+0xed8>
    27c0:	00005097          	auipc	ra,0x5
    27c4:	0c6080e7          	jalr	198(ra) # 7886 <printf>
      exit(1);
    27c8:	4505                	li	a0,1
    27ca:	00005097          	auipc	ra,0x5
    27ce:	b7e080e7          	jalr	-1154(ra) # 7348 <exit>
    }
    free(m1);
    27d2:	fe843503          	ld	a0,-24(s0)
    27d6:	00005097          	auipc	ra,0x5
    27da:	100080e7          	jalr	256(ra) # 78d6 <free>
    exit(0);
    27de:	4501                	li	a0,0
    27e0:	00005097          	auipc	ra,0x5
    27e4:	b68080e7          	jalr	-1176(ra) # 7348 <exit>
  } else {
    int xstatus;
    wait(&xstatus);
    27e8:	fd440793          	addi	a5,s0,-44
    27ec:	853e                	mv	a0,a5
    27ee:	00005097          	auipc	ra,0x5
    27f2:	b62080e7          	jalr	-1182(ra) # 7350 <wait>
    if(xstatus == -1){
    27f6:	fd442783          	lw	a5,-44(s0)
    27fa:	873e                	mv	a4,a5
    27fc:	57fd                	li	a5,-1
    27fe:	00f71763          	bne	a4,a5,280c <mem+0xe4>
      // probably page fault, so might be lazy lab,
      // so OK.
      exit(0);
    2802:	4501                	li	a0,0
    2804:	00005097          	auipc	ra,0x5
    2808:	b44080e7          	jalr	-1212(ra) # 7348 <exit>
    }
    exit(xstatus);
    280c:	fd442783          	lw	a5,-44(s0)
    2810:	853e                	mv	a0,a5
    2812:	00005097          	auipc	ra,0x5
    2816:	b36080e7          	jalr	-1226(ra) # 7348 <exit>

000000000000281a <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(char *s)
{
    281a:	715d                	addi	sp,sp,-80
    281c:	e486                	sd	ra,72(sp)
    281e:	e0a2                	sd	s0,64(sp)
    2820:	0880                	addi	s0,sp,80
    2822:	faa43c23          	sd	a0,-72(s0)
  int fd, pid, i, n, nc, np;
  enum { N = 1000, SZ=10};
  char buf[SZ];

  unlink("sharedfd");
    2826:	00005517          	auipc	a0,0x5
    282a:	53a50513          	addi	a0,a0,1338 # 7d60 <malloc+0x2e8>
    282e:	00005097          	auipc	ra,0x5
    2832:	b6a080e7          	jalr	-1174(ra) # 7398 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    2836:	20200593          	li	a1,514
    283a:	00005517          	auipc	a0,0x5
    283e:	52650513          	addi	a0,a0,1318 # 7d60 <malloc+0x2e8>
    2842:	00005097          	auipc	ra,0x5
    2846:	b46080e7          	jalr	-1210(ra) # 7388 <open>
    284a:	87aa                	mv	a5,a0
    284c:	fef42023          	sw	a5,-32(s0)
  if(fd < 0){
    2850:	fe042783          	lw	a5,-32(s0)
    2854:	2781                	sext.w	a5,a5
    2856:	0207d163          	bgez	a5,2878 <sharedfd+0x5e>
    printf("%s: cannot open sharedfd for writing", s);
    285a:	fb843583          	ld	a1,-72(s0)
    285e:	00006517          	auipc	a0,0x6
    2862:	11250513          	addi	a0,a0,274 # 8970 <malloc+0xef8>
    2866:	00005097          	auipc	ra,0x5
    286a:	020080e7          	jalr	32(ra) # 7886 <printf>
    exit(1);
    286e:	4505                	li	a0,1
    2870:	00005097          	auipc	ra,0x5
    2874:	ad8080e7          	jalr	-1320(ra) # 7348 <exit>
  }
  pid = fork();
    2878:	00005097          	auipc	ra,0x5
    287c:	ac8080e7          	jalr	-1336(ra) # 7340 <fork>
    2880:	87aa                	mv	a5,a0
    2882:	fcf42e23          	sw	a5,-36(s0)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    2886:	fdc42783          	lw	a5,-36(s0)
    288a:	2781                	sext.w	a5,a5
    288c:	e781                	bnez	a5,2894 <sharedfd+0x7a>
    288e:	06300793          	li	a5,99
    2892:	a019                	j	2898 <sharedfd+0x7e>
    2894:	07000793          	li	a5,112
    2898:	fc840713          	addi	a4,s0,-56
    289c:	4629                	li	a2,10
    289e:	85be                	mv	a1,a5
    28a0:	853a                	mv	a0,a4
    28a2:	00004097          	auipc	ra,0x4
    28a6:	6fc080e7          	jalr	1788(ra) # 6f9e <memset>
  for(i = 0; i < N; i++){
    28aa:	fe042623          	sw	zero,-20(s0)
    28ae:	a0a9                	j	28f8 <sharedfd+0xde>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    28b0:	fc840713          	addi	a4,s0,-56
    28b4:	fe042783          	lw	a5,-32(s0)
    28b8:	4629                	li	a2,10
    28ba:	85ba                	mv	a1,a4
    28bc:	853e                	mv	a0,a5
    28be:	00005097          	auipc	ra,0x5
    28c2:	aaa080e7          	jalr	-1366(ra) # 7368 <write>
    28c6:	87aa                	mv	a5,a0
    28c8:	873e                	mv	a4,a5
    28ca:	47a9                	li	a5,10
    28cc:	02f70163          	beq	a4,a5,28ee <sharedfd+0xd4>
      printf("%s: write sharedfd failed\n", s);
    28d0:	fb843583          	ld	a1,-72(s0)
    28d4:	00006517          	auipc	a0,0x6
    28d8:	0c450513          	addi	a0,a0,196 # 8998 <malloc+0xf20>
    28dc:	00005097          	auipc	ra,0x5
    28e0:	faa080e7          	jalr	-86(ra) # 7886 <printf>
      exit(1);
    28e4:	4505                	li	a0,1
    28e6:	00005097          	auipc	ra,0x5
    28ea:	a62080e7          	jalr	-1438(ra) # 7348 <exit>
  for(i = 0; i < N; i++){
    28ee:	fec42783          	lw	a5,-20(s0)
    28f2:	2785                	addiw	a5,a5,1
    28f4:	fef42623          	sw	a5,-20(s0)
    28f8:	fec42783          	lw	a5,-20(s0)
    28fc:	0007871b          	sext.w	a4,a5
    2900:	3e700793          	li	a5,999
    2904:	fae7d6e3          	bge	a5,a4,28b0 <sharedfd+0x96>
    }
  }
  if(pid == 0) {
    2908:	fdc42783          	lw	a5,-36(s0)
    290c:	2781                	sext.w	a5,a5
    290e:	e791                	bnez	a5,291a <sharedfd+0x100>
    exit(0);
    2910:	4501                	li	a0,0
    2912:	00005097          	auipc	ra,0x5
    2916:	a36080e7          	jalr	-1482(ra) # 7348 <exit>
  } else {
    int xstatus;
    wait(&xstatus);
    291a:	fc440793          	addi	a5,s0,-60
    291e:	853e                	mv	a0,a5
    2920:	00005097          	auipc	ra,0x5
    2924:	a30080e7          	jalr	-1488(ra) # 7350 <wait>
    if(xstatus != 0)
    2928:	fc442783          	lw	a5,-60(s0)
    292c:	cb81                	beqz	a5,293c <sharedfd+0x122>
      exit(xstatus);
    292e:	fc442783          	lw	a5,-60(s0)
    2932:	853e                	mv	a0,a5
    2934:	00005097          	auipc	ra,0x5
    2938:	a14080e7          	jalr	-1516(ra) # 7348 <exit>
  }
  
  close(fd);
    293c:	fe042783          	lw	a5,-32(s0)
    2940:	853e                	mv	a0,a5
    2942:	00005097          	auipc	ra,0x5
    2946:	a2e080e7          	jalr	-1490(ra) # 7370 <close>
  fd = open("sharedfd", 0);
    294a:	4581                	li	a1,0
    294c:	00005517          	auipc	a0,0x5
    2950:	41450513          	addi	a0,a0,1044 # 7d60 <malloc+0x2e8>
    2954:	00005097          	auipc	ra,0x5
    2958:	a34080e7          	jalr	-1484(ra) # 7388 <open>
    295c:	87aa                	mv	a5,a0
    295e:	fef42023          	sw	a5,-32(s0)
  if(fd < 0){
    2962:	fe042783          	lw	a5,-32(s0)
    2966:	2781                	sext.w	a5,a5
    2968:	0207d163          	bgez	a5,298a <sharedfd+0x170>
    printf("%s: cannot open sharedfd for reading\n", s);
    296c:	fb843583          	ld	a1,-72(s0)
    2970:	00006517          	auipc	a0,0x6
    2974:	04850513          	addi	a0,a0,72 # 89b8 <malloc+0xf40>
    2978:	00005097          	auipc	ra,0x5
    297c:	f0e080e7          	jalr	-242(ra) # 7886 <printf>
    exit(1);
    2980:	4505                	li	a0,1
    2982:	00005097          	auipc	ra,0x5
    2986:	9c6080e7          	jalr	-1594(ra) # 7348 <exit>
  }
  nc = np = 0;
    298a:	fe042223          	sw	zero,-28(s0)
    298e:	fe442783          	lw	a5,-28(s0)
    2992:	fef42423          	sw	a5,-24(s0)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    2996:	a08d                	j	29f8 <sharedfd+0x1de>
    for(i = 0; i < sizeof(buf); i++){
    2998:	fe042623          	sw	zero,-20(s0)
    299c:	a881                	j	29ec <sharedfd+0x1d2>
      if(buf[i] == 'c')
    299e:	fec42783          	lw	a5,-20(s0)
    29a2:	ff040713          	addi	a4,s0,-16
    29a6:	97ba                	add	a5,a5,a4
    29a8:	fd87c783          	lbu	a5,-40(a5)
    29ac:	873e                	mv	a4,a5
    29ae:	06300793          	li	a5,99
    29b2:	00f71763          	bne	a4,a5,29c0 <sharedfd+0x1a6>
        nc++;
    29b6:	fe842783          	lw	a5,-24(s0)
    29ba:	2785                	addiw	a5,a5,1
    29bc:	fef42423          	sw	a5,-24(s0)
      if(buf[i] == 'p')
    29c0:	fec42783          	lw	a5,-20(s0)
    29c4:	ff040713          	addi	a4,s0,-16
    29c8:	97ba                	add	a5,a5,a4
    29ca:	fd87c783          	lbu	a5,-40(a5)
    29ce:	873e                	mv	a4,a5
    29d0:	07000793          	li	a5,112
    29d4:	00f71763          	bne	a4,a5,29e2 <sharedfd+0x1c8>
        np++;
    29d8:	fe442783          	lw	a5,-28(s0)
    29dc:	2785                	addiw	a5,a5,1
    29de:	fef42223          	sw	a5,-28(s0)
    for(i = 0; i < sizeof(buf); i++){
    29e2:	fec42783          	lw	a5,-20(s0)
    29e6:	2785                	addiw	a5,a5,1
    29e8:	fef42623          	sw	a5,-20(s0)
    29ec:	fec42783          	lw	a5,-20(s0)
    29f0:	873e                	mv	a4,a5
    29f2:	47a5                	li	a5,9
    29f4:	fae7f5e3          	bgeu	a5,a4,299e <sharedfd+0x184>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    29f8:	fc840713          	addi	a4,s0,-56
    29fc:	fe042783          	lw	a5,-32(s0)
    2a00:	4629                	li	a2,10
    2a02:	85ba                	mv	a1,a4
    2a04:	853e                	mv	a0,a5
    2a06:	00005097          	auipc	ra,0x5
    2a0a:	95a080e7          	jalr	-1702(ra) # 7360 <read>
    2a0e:	87aa                	mv	a5,a0
    2a10:	fcf42c23          	sw	a5,-40(s0)
    2a14:	fd842783          	lw	a5,-40(s0)
    2a18:	2781                	sext.w	a5,a5
    2a1a:	f6f04fe3          	bgtz	a5,2998 <sharedfd+0x17e>
    }
  }
  close(fd);
    2a1e:	fe042783          	lw	a5,-32(s0)
    2a22:	853e                	mv	a0,a5
    2a24:	00005097          	auipc	ra,0x5
    2a28:	94c080e7          	jalr	-1716(ra) # 7370 <close>
  unlink("sharedfd");
    2a2c:	00005517          	auipc	a0,0x5
    2a30:	33450513          	addi	a0,a0,820 # 7d60 <malloc+0x2e8>
    2a34:	00005097          	auipc	ra,0x5
    2a38:	964080e7          	jalr	-1692(ra) # 7398 <unlink>
  if(nc == N*SZ && np == N*SZ){
    2a3c:	fe842783          	lw	a5,-24(s0)
    2a40:	0007871b          	sext.w	a4,a5
    2a44:	6789                	lui	a5,0x2
    2a46:	71078793          	addi	a5,a5,1808 # 2710 <reparent2+0x7c>
    2a4a:	02f71063          	bne	a4,a5,2a6a <sharedfd+0x250>
    2a4e:	fe442783          	lw	a5,-28(s0)
    2a52:	0007871b          	sext.w	a4,a5
    2a56:	6789                	lui	a5,0x2
    2a58:	71078793          	addi	a5,a5,1808 # 2710 <reparent2+0x7c>
    2a5c:	00f71763          	bne	a4,a5,2a6a <sharedfd+0x250>
    exit(0);
    2a60:	4501                	li	a0,0
    2a62:	00005097          	auipc	ra,0x5
    2a66:	8e6080e7          	jalr	-1818(ra) # 7348 <exit>
  } else {
    printf("%s: nc/np test fails\n", s);
    2a6a:	fb843583          	ld	a1,-72(s0)
    2a6e:	00006517          	auipc	a0,0x6
    2a72:	f7250513          	addi	a0,a0,-142 # 89e0 <malloc+0xf68>
    2a76:	00005097          	auipc	ra,0x5
    2a7a:	e10080e7          	jalr	-496(ra) # 7886 <printf>
    exit(1);
    2a7e:	4505                	li	a0,1
    2a80:	00005097          	auipc	ra,0x5
    2a84:	8c8080e7          	jalr	-1848(ra) # 7348 <exit>

0000000000002a88 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(char *s)
{
    2a88:	7159                	addi	sp,sp,-112
    2a8a:	f486                	sd	ra,104(sp)
    2a8c:	f0a2                	sd	s0,96(sp)
    2a8e:	1880                	addi	s0,sp,112
    2a90:	f8a43c23          	sd	a0,-104(s0)
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    2a94:	00006797          	auipc	a5,0x6
    2a98:	fb478793          	addi	a5,a5,-76 # 8a48 <malloc+0xfd0>
    2a9c:	6390                	ld	a2,0(a5)
    2a9e:	6794                	ld	a3,8(a5)
    2aa0:	6b98                	ld	a4,16(a5)
    2aa2:	6f9c                	ld	a5,24(a5)
    2aa4:	fac43423          	sd	a2,-88(s0)
    2aa8:	fad43823          	sd	a3,-80(s0)
    2aac:	fae43c23          	sd	a4,-72(s0)
    2ab0:	fcf43023          	sd	a5,-64(s0)
  char *fname;
  enum { N=12, NCHILD=4, SZ=500 };
  
  for(pi = 0; pi < NCHILD; pi++){
    2ab4:	fe042023          	sw	zero,-32(s0)
    2ab8:	a281                	j	2bf8 <fourfiles+0x170>
    fname = names[pi];
    2aba:	fe042783          	lw	a5,-32(s0)
    2abe:	078e                	slli	a5,a5,0x3
    2ac0:	ff040713          	addi	a4,s0,-16
    2ac4:	97ba                	add	a5,a5,a4
    2ac6:	fb87b783          	ld	a5,-72(a5)
    2aca:	fcf43c23          	sd	a5,-40(s0)
    unlink(fname);
    2ace:	fd843503          	ld	a0,-40(s0)
    2ad2:	00005097          	auipc	ra,0x5
    2ad6:	8c6080e7          	jalr	-1850(ra) # 7398 <unlink>

    pid = fork();
    2ada:	00005097          	auipc	ra,0x5
    2ade:	866080e7          	jalr	-1946(ra) # 7340 <fork>
    2ae2:	87aa                	mv	a5,a0
    2ae4:	fcf42623          	sw	a5,-52(s0)
    if(pid < 0){
    2ae8:	fcc42783          	lw	a5,-52(s0)
    2aec:	2781                	sext.w	a5,a5
    2aee:	0207d163          	bgez	a5,2b10 <fourfiles+0x88>
      printf("fork failed\n", s);
    2af2:	f9843583          	ld	a1,-104(s0)
    2af6:	00005517          	auipc	a0,0x5
    2afa:	63250513          	addi	a0,a0,1586 # 8128 <malloc+0x6b0>
    2afe:	00005097          	auipc	ra,0x5
    2b02:	d88080e7          	jalr	-632(ra) # 7886 <printf>
      exit(1);
    2b06:	4505                	li	a0,1
    2b08:	00005097          	auipc	ra,0x5
    2b0c:	840080e7          	jalr	-1984(ra) # 7348 <exit>
    }

    if(pid == 0){
    2b10:	fcc42783          	lw	a5,-52(s0)
    2b14:	2781                	sext.w	a5,a5
    2b16:	efe1                	bnez	a5,2bee <fourfiles+0x166>
      fd = open(fname, O_CREATE | O_RDWR);
    2b18:	20200593          	li	a1,514
    2b1c:	fd843503          	ld	a0,-40(s0)
    2b20:	00005097          	auipc	ra,0x5
    2b24:	868080e7          	jalr	-1944(ra) # 7388 <open>
    2b28:	87aa                	mv	a5,a0
    2b2a:	fcf42a23          	sw	a5,-44(s0)
      if(fd < 0){
    2b2e:	fd442783          	lw	a5,-44(s0)
    2b32:	2781                	sext.w	a5,a5
    2b34:	0207d163          	bgez	a5,2b56 <fourfiles+0xce>
        printf("create failed\n", s);
    2b38:	f9843583          	ld	a1,-104(s0)
    2b3c:	00006517          	auipc	a0,0x6
    2b40:	ebc50513          	addi	a0,a0,-324 # 89f8 <malloc+0xf80>
    2b44:	00005097          	auipc	ra,0x5
    2b48:	d42080e7          	jalr	-702(ra) # 7886 <printf>
        exit(1);
    2b4c:	4505                	li	a0,1
    2b4e:	00004097          	auipc	ra,0x4
    2b52:	7fa080e7          	jalr	2042(ra) # 7348 <exit>
      }

      memset(buf, '0'+pi, SZ);
    2b56:	fe042783          	lw	a5,-32(s0)
    2b5a:	0307879b          	addiw	a5,a5,48
    2b5e:	2781                	sext.w	a5,a5
    2b60:	1f400613          	li	a2,500
    2b64:	85be                	mv	a1,a5
    2b66:	00008517          	auipc	a0,0x8
    2b6a:	8aa50513          	addi	a0,a0,-1878 # a410 <buf>
    2b6e:	00004097          	auipc	ra,0x4
    2b72:	430080e7          	jalr	1072(ra) # 6f9e <memset>
      for(i = 0; i < N; i++){
    2b76:	fe042623          	sw	zero,-20(s0)
    2b7a:	a8b1                	j	2bd6 <fourfiles+0x14e>
        if((n = write(fd, buf, SZ)) != SZ){
    2b7c:	fd442783          	lw	a5,-44(s0)
    2b80:	1f400613          	li	a2,500
    2b84:	00008597          	auipc	a1,0x8
    2b88:	88c58593          	addi	a1,a1,-1908 # a410 <buf>
    2b8c:	853e                	mv	a0,a5
    2b8e:	00004097          	auipc	ra,0x4
    2b92:	7da080e7          	jalr	2010(ra) # 7368 <write>
    2b96:	87aa                	mv	a5,a0
    2b98:	fcf42823          	sw	a5,-48(s0)
    2b9c:	fd042783          	lw	a5,-48(s0)
    2ba0:	0007871b          	sext.w	a4,a5
    2ba4:	1f400793          	li	a5,500
    2ba8:	02f70263          	beq	a4,a5,2bcc <fourfiles+0x144>
          printf("write failed %d\n", n);
    2bac:	fd042783          	lw	a5,-48(s0)
    2bb0:	85be                	mv	a1,a5
    2bb2:	00006517          	auipc	a0,0x6
    2bb6:	e5650513          	addi	a0,a0,-426 # 8a08 <malloc+0xf90>
    2bba:	00005097          	auipc	ra,0x5
    2bbe:	ccc080e7          	jalr	-820(ra) # 7886 <printf>
          exit(1);
    2bc2:	4505                	li	a0,1
    2bc4:	00004097          	auipc	ra,0x4
    2bc8:	784080e7          	jalr	1924(ra) # 7348 <exit>
      for(i = 0; i < N; i++){
    2bcc:	fec42783          	lw	a5,-20(s0)
    2bd0:	2785                	addiw	a5,a5,1
    2bd2:	fef42623          	sw	a5,-20(s0)
    2bd6:	fec42783          	lw	a5,-20(s0)
    2bda:	0007871b          	sext.w	a4,a5
    2bde:	47ad                	li	a5,11
    2be0:	f8e7dee3          	bge	a5,a4,2b7c <fourfiles+0xf4>
        }
      }
      exit(0);
    2be4:	4501                	li	a0,0
    2be6:	00004097          	auipc	ra,0x4
    2bea:	762080e7          	jalr	1890(ra) # 7348 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2bee:	fe042783          	lw	a5,-32(s0)
    2bf2:	2785                	addiw	a5,a5,1
    2bf4:	fef42023          	sw	a5,-32(s0)
    2bf8:	fe042783          	lw	a5,-32(s0)
    2bfc:	0007871b          	sext.w	a4,a5
    2c00:	478d                	li	a5,3
    2c02:	eae7dce3          	bge	a5,a4,2aba <fourfiles+0x32>
    }
  }

  int xstatus;
  for(pi = 0; pi < NCHILD; pi++){
    2c06:	fe042023          	sw	zero,-32(s0)
    2c0a:	a03d                	j	2c38 <fourfiles+0x1b0>
    wait(&xstatus);
    2c0c:	fa440793          	addi	a5,s0,-92
    2c10:	853e                	mv	a0,a5
    2c12:	00004097          	auipc	ra,0x4
    2c16:	73e080e7          	jalr	1854(ra) # 7350 <wait>
    if(xstatus != 0)
    2c1a:	fa442783          	lw	a5,-92(s0)
    2c1e:	cb81                	beqz	a5,2c2e <fourfiles+0x1a6>
      exit(xstatus);
    2c20:	fa442783          	lw	a5,-92(s0)
    2c24:	853e                	mv	a0,a5
    2c26:	00004097          	auipc	ra,0x4
    2c2a:	722080e7          	jalr	1826(ra) # 7348 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2c2e:	fe042783          	lw	a5,-32(s0)
    2c32:	2785                	addiw	a5,a5,1
    2c34:	fef42023          	sw	a5,-32(s0)
    2c38:	fe042783          	lw	a5,-32(s0)
    2c3c:	0007871b          	sext.w	a4,a5
    2c40:	478d                	li	a5,3
    2c42:	fce7d5e3          	bge	a5,a4,2c0c <fourfiles+0x184>
  }

  for(i = 0; i < NCHILD; i++){
    2c46:	fe042623          	sw	zero,-20(s0)
    2c4a:	aa39                	j	2d68 <fourfiles+0x2e0>
    fname = names[i];
    2c4c:	fec42783          	lw	a5,-20(s0)
    2c50:	078e                	slli	a5,a5,0x3
    2c52:	ff040713          	addi	a4,s0,-16
    2c56:	97ba                	add	a5,a5,a4
    2c58:	fb87b783          	ld	a5,-72(a5)
    2c5c:	fcf43c23          	sd	a5,-40(s0)
    fd = open(fname, 0);
    2c60:	4581                	li	a1,0
    2c62:	fd843503          	ld	a0,-40(s0)
    2c66:	00004097          	auipc	ra,0x4
    2c6a:	722080e7          	jalr	1826(ra) # 7388 <open>
    2c6e:	87aa                	mv	a5,a0
    2c70:	fcf42a23          	sw	a5,-44(s0)
    total = 0;
    2c74:	fe042223          	sw	zero,-28(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2c78:	a88d                	j	2cea <fourfiles+0x262>
      for(j = 0; j < n; j++){
    2c7a:	fe042423          	sw	zero,-24(s0)
    2c7e:	a0b9                	j	2ccc <fourfiles+0x244>
        if(buf[j] != '0'+i){
    2c80:	00007717          	auipc	a4,0x7
    2c84:	79070713          	addi	a4,a4,1936 # a410 <buf>
    2c88:	fe842783          	lw	a5,-24(s0)
    2c8c:	97ba                	add	a5,a5,a4
    2c8e:	0007c783          	lbu	a5,0(a5)
    2c92:	0007871b          	sext.w	a4,a5
    2c96:	fec42783          	lw	a5,-20(s0)
    2c9a:	0307879b          	addiw	a5,a5,48
    2c9e:	2781                	sext.w	a5,a5
    2ca0:	02f70163          	beq	a4,a5,2cc2 <fourfiles+0x23a>
          printf("wrong char\n", s);
    2ca4:	f9843583          	ld	a1,-104(s0)
    2ca8:	00006517          	auipc	a0,0x6
    2cac:	d7850513          	addi	a0,a0,-648 # 8a20 <malloc+0xfa8>
    2cb0:	00005097          	auipc	ra,0x5
    2cb4:	bd6080e7          	jalr	-1066(ra) # 7886 <printf>
          exit(1);
    2cb8:	4505                	li	a0,1
    2cba:	00004097          	auipc	ra,0x4
    2cbe:	68e080e7          	jalr	1678(ra) # 7348 <exit>
      for(j = 0; j < n; j++){
    2cc2:	fe842783          	lw	a5,-24(s0)
    2cc6:	2785                	addiw	a5,a5,1
    2cc8:	fef42423          	sw	a5,-24(s0)
    2ccc:	fe842703          	lw	a4,-24(s0)
    2cd0:	fd042783          	lw	a5,-48(s0)
    2cd4:	2701                	sext.w	a4,a4
    2cd6:	2781                	sext.w	a5,a5
    2cd8:	faf744e3          	blt	a4,a5,2c80 <fourfiles+0x1f8>
        }
      }
      total += n;
    2cdc:	fe442703          	lw	a4,-28(s0)
    2ce0:	fd042783          	lw	a5,-48(s0)
    2ce4:	9fb9                	addw	a5,a5,a4
    2ce6:	fef42223          	sw	a5,-28(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2cea:	fd442783          	lw	a5,-44(s0)
    2cee:	660d                	lui	a2,0x3
    2cf0:	00007597          	auipc	a1,0x7
    2cf4:	72058593          	addi	a1,a1,1824 # a410 <buf>
    2cf8:	853e                	mv	a0,a5
    2cfa:	00004097          	auipc	ra,0x4
    2cfe:	666080e7          	jalr	1638(ra) # 7360 <read>
    2d02:	87aa                	mv	a5,a0
    2d04:	fcf42823          	sw	a5,-48(s0)
    2d08:	fd042783          	lw	a5,-48(s0)
    2d0c:	2781                	sext.w	a5,a5
    2d0e:	f6f046e3          	bgtz	a5,2c7a <fourfiles+0x1f2>
    }
    close(fd);
    2d12:	fd442783          	lw	a5,-44(s0)
    2d16:	853e                	mv	a0,a5
    2d18:	00004097          	auipc	ra,0x4
    2d1c:	658080e7          	jalr	1624(ra) # 7370 <close>
    if(total != N*SZ){
    2d20:	fe442783          	lw	a5,-28(s0)
    2d24:	0007871b          	sext.w	a4,a5
    2d28:	6785                	lui	a5,0x1
    2d2a:	77078793          	addi	a5,a5,1904 # 1770 <writebig+0x124>
    2d2e:	02f70263          	beq	a4,a5,2d52 <fourfiles+0x2ca>
      printf("wrong length %d\n", total);
    2d32:	fe442783          	lw	a5,-28(s0)
    2d36:	85be                	mv	a1,a5
    2d38:	00006517          	auipc	a0,0x6
    2d3c:	cf850513          	addi	a0,a0,-776 # 8a30 <malloc+0xfb8>
    2d40:	00005097          	auipc	ra,0x5
    2d44:	b46080e7          	jalr	-1210(ra) # 7886 <printf>
      exit(1);
    2d48:	4505                	li	a0,1
    2d4a:	00004097          	auipc	ra,0x4
    2d4e:	5fe080e7          	jalr	1534(ra) # 7348 <exit>
    }
    unlink(fname);
    2d52:	fd843503          	ld	a0,-40(s0)
    2d56:	00004097          	auipc	ra,0x4
    2d5a:	642080e7          	jalr	1602(ra) # 7398 <unlink>
  for(i = 0; i < NCHILD; i++){
    2d5e:	fec42783          	lw	a5,-20(s0)
    2d62:	2785                	addiw	a5,a5,1
    2d64:	fef42623          	sw	a5,-20(s0)
    2d68:	fec42783          	lw	a5,-20(s0)
    2d6c:	0007871b          	sext.w	a4,a5
    2d70:	478d                	li	a5,3
    2d72:	ece7dde3          	bge	a5,a4,2c4c <fourfiles+0x1c4>
  }
}
    2d76:	0001                	nop
    2d78:	0001                	nop
    2d7a:	70a6                	ld	ra,104(sp)
    2d7c:	7406                	ld	s0,96(sp)
    2d7e:	6165                	addi	sp,sp,112
    2d80:	8082                	ret

0000000000002d82 <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(char *s)
{
    2d82:	711d                	addi	sp,sp,-96
    2d84:	ec86                	sd	ra,88(sp)
    2d86:	e8a2                	sd	s0,80(sp)
    2d88:	1080                	addi	s0,sp,96
    2d8a:	faa43423          	sd	a0,-88(s0)
  enum { N = 20, NCHILD=4 };
  int pid, i, fd, pi;
  char name[32];

  for(pi = 0; pi < NCHILD; pi++){
    2d8e:	fe042423          	sw	zero,-24(s0)
    2d92:	aa91                	j	2ee6 <createdelete+0x164>
    pid = fork();
    2d94:	00004097          	auipc	ra,0x4
    2d98:	5ac080e7          	jalr	1452(ra) # 7340 <fork>
    2d9c:	87aa                	mv	a5,a0
    2d9e:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    2da2:	fe042783          	lw	a5,-32(s0)
    2da6:	2781                	sext.w	a5,a5
    2da8:	0207d163          	bgez	a5,2dca <createdelete+0x48>
      printf("fork failed\n", s);
    2dac:	fa843583          	ld	a1,-88(s0)
    2db0:	00005517          	auipc	a0,0x5
    2db4:	37850513          	addi	a0,a0,888 # 8128 <malloc+0x6b0>
    2db8:	00005097          	auipc	ra,0x5
    2dbc:	ace080e7          	jalr	-1330(ra) # 7886 <printf>
      exit(1);
    2dc0:	4505                	li	a0,1
    2dc2:	00004097          	auipc	ra,0x4
    2dc6:	586080e7          	jalr	1414(ra) # 7348 <exit>
    }

    if(pid == 0){
    2dca:	fe042783          	lw	a5,-32(s0)
    2dce:	2781                	sext.w	a5,a5
    2dd0:	10079663          	bnez	a5,2edc <createdelete+0x15a>
      name[0] = 'p' + pi;
    2dd4:	fe842783          	lw	a5,-24(s0)
    2dd8:	0ff7f793          	andi	a5,a5,255
    2ddc:	0707879b          	addiw	a5,a5,112
    2de0:	0ff7f793          	andi	a5,a5,255
    2de4:	fcf40023          	sb	a5,-64(s0)
      name[2] = '\0';
    2de8:	fc040123          	sb	zero,-62(s0)
      for(i = 0; i < N; i++){
    2dec:	fe042623          	sw	zero,-20(s0)
    2df0:	a8d1                	j	2ec4 <createdelete+0x142>
        name[1] = '0' + i;
    2df2:	fec42783          	lw	a5,-20(s0)
    2df6:	0ff7f793          	andi	a5,a5,255
    2dfa:	0307879b          	addiw	a5,a5,48
    2dfe:	0ff7f793          	andi	a5,a5,255
    2e02:	fcf400a3          	sb	a5,-63(s0)
        fd = open(name, O_CREATE | O_RDWR);
    2e06:	fc040793          	addi	a5,s0,-64
    2e0a:	20200593          	li	a1,514
    2e0e:	853e                	mv	a0,a5
    2e10:	00004097          	auipc	ra,0x4
    2e14:	578080e7          	jalr	1400(ra) # 7388 <open>
    2e18:	87aa                	mv	a5,a0
    2e1a:	fef42223          	sw	a5,-28(s0)
        if(fd < 0){
    2e1e:	fe442783          	lw	a5,-28(s0)
    2e22:	2781                	sext.w	a5,a5
    2e24:	0207d163          	bgez	a5,2e46 <createdelete+0xc4>
          printf("%s: create failed\n", s);
    2e28:	fa843583          	ld	a1,-88(s0)
    2e2c:	00006517          	auipc	a0,0x6
    2e30:	94c50513          	addi	a0,a0,-1716 # 8778 <malloc+0xd00>
    2e34:	00005097          	auipc	ra,0x5
    2e38:	a52080e7          	jalr	-1454(ra) # 7886 <printf>
          exit(1);
    2e3c:	4505                	li	a0,1
    2e3e:	00004097          	auipc	ra,0x4
    2e42:	50a080e7          	jalr	1290(ra) # 7348 <exit>
        }
        close(fd);
    2e46:	fe442783          	lw	a5,-28(s0)
    2e4a:	853e                	mv	a0,a5
    2e4c:	00004097          	auipc	ra,0x4
    2e50:	524080e7          	jalr	1316(ra) # 7370 <close>
        if(i > 0 && (i % 2 ) == 0){
    2e54:	fec42783          	lw	a5,-20(s0)
    2e58:	2781                	sext.w	a5,a5
    2e5a:	06f05063          	blez	a5,2eba <createdelete+0x138>
    2e5e:	fec42783          	lw	a5,-20(s0)
    2e62:	8b85                	andi	a5,a5,1
    2e64:	2781                	sext.w	a5,a5
    2e66:	ebb1                	bnez	a5,2eba <createdelete+0x138>
          name[1] = '0' + (i / 2);
    2e68:	fec42783          	lw	a5,-20(s0)
    2e6c:	01f7d71b          	srliw	a4,a5,0x1f
    2e70:	9fb9                	addw	a5,a5,a4
    2e72:	4017d79b          	sraiw	a5,a5,0x1
    2e76:	2781                	sext.w	a5,a5
    2e78:	0ff7f793          	andi	a5,a5,255
    2e7c:	0307879b          	addiw	a5,a5,48
    2e80:	0ff7f793          	andi	a5,a5,255
    2e84:	fcf400a3          	sb	a5,-63(s0)
          if(unlink(name) < 0){
    2e88:	fc040793          	addi	a5,s0,-64
    2e8c:	853e                	mv	a0,a5
    2e8e:	00004097          	auipc	ra,0x4
    2e92:	50a080e7          	jalr	1290(ra) # 7398 <unlink>
    2e96:	87aa                	mv	a5,a0
    2e98:	0207d163          	bgez	a5,2eba <createdelete+0x138>
            printf("%s: unlink failed\n", s);
    2e9c:	fa843583          	ld	a1,-88(s0)
    2ea0:	00005517          	auipc	a0,0x5
    2ea4:	62850513          	addi	a0,a0,1576 # 84c8 <malloc+0xa50>
    2ea8:	00005097          	auipc	ra,0x5
    2eac:	9de080e7          	jalr	-1570(ra) # 7886 <printf>
            exit(1);
    2eb0:	4505                	li	a0,1
    2eb2:	00004097          	auipc	ra,0x4
    2eb6:	496080e7          	jalr	1174(ra) # 7348 <exit>
      for(i = 0; i < N; i++){
    2eba:	fec42783          	lw	a5,-20(s0)
    2ebe:	2785                	addiw	a5,a5,1
    2ec0:	fef42623          	sw	a5,-20(s0)
    2ec4:	fec42783          	lw	a5,-20(s0)
    2ec8:	0007871b          	sext.w	a4,a5
    2ecc:	47cd                	li	a5,19
    2ece:	f2e7d2e3          	bge	a5,a4,2df2 <createdelete+0x70>
          }
        }
      }
      exit(0);
    2ed2:	4501                	li	a0,0
    2ed4:	00004097          	auipc	ra,0x4
    2ed8:	474080e7          	jalr	1140(ra) # 7348 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2edc:	fe842783          	lw	a5,-24(s0)
    2ee0:	2785                	addiw	a5,a5,1
    2ee2:	fef42423          	sw	a5,-24(s0)
    2ee6:	fe842783          	lw	a5,-24(s0)
    2eea:	0007871b          	sext.w	a4,a5
    2eee:	478d                	li	a5,3
    2ef0:	eae7d2e3          	bge	a5,a4,2d94 <createdelete+0x12>
    }
  }

  int xstatus;
  for(pi = 0; pi < NCHILD; pi++){
    2ef4:	fe042423          	sw	zero,-24(s0)
    2ef8:	a02d                	j	2f22 <createdelete+0x1a0>
    wait(&xstatus);
    2efa:	fbc40793          	addi	a5,s0,-68
    2efe:	853e                	mv	a0,a5
    2f00:	00004097          	auipc	ra,0x4
    2f04:	450080e7          	jalr	1104(ra) # 7350 <wait>
    if(xstatus != 0)
    2f08:	fbc42783          	lw	a5,-68(s0)
    2f0c:	c791                	beqz	a5,2f18 <createdelete+0x196>
      exit(1);
    2f0e:	4505                	li	a0,1
    2f10:	00004097          	auipc	ra,0x4
    2f14:	438080e7          	jalr	1080(ra) # 7348 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2f18:	fe842783          	lw	a5,-24(s0)
    2f1c:	2785                	addiw	a5,a5,1
    2f1e:	fef42423          	sw	a5,-24(s0)
    2f22:	fe842783          	lw	a5,-24(s0)
    2f26:	0007871b          	sext.w	a4,a5
    2f2a:	478d                	li	a5,3
    2f2c:	fce7d7e3          	bge	a5,a4,2efa <createdelete+0x178>
  }

  name[0] = name[1] = name[2] = 0;
    2f30:	fc040123          	sb	zero,-62(s0)
    2f34:	fc244783          	lbu	a5,-62(s0)
    2f38:	fcf400a3          	sb	a5,-63(s0)
    2f3c:	fc144783          	lbu	a5,-63(s0)
    2f40:	fcf40023          	sb	a5,-64(s0)
  for(i = 0; i < N; i++){
    2f44:	fe042623          	sw	zero,-20(s0)
    2f48:	a229                	j	3052 <createdelete+0x2d0>
    for(pi = 0; pi < NCHILD; pi++){
    2f4a:	fe042423          	sw	zero,-24(s0)
    2f4e:	a0f5                	j	303a <createdelete+0x2b8>
      name[0] = 'p' + pi;
    2f50:	fe842783          	lw	a5,-24(s0)
    2f54:	0ff7f793          	andi	a5,a5,255
    2f58:	0707879b          	addiw	a5,a5,112
    2f5c:	0ff7f793          	andi	a5,a5,255
    2f60:	fcf40023          	sb	a5,-64(s0)
      name[1] = '0' + i;
    2f64:	fec42783          	lw	a5,-20(s0)
    2f68:	0ff7f793          	andi	a5,a5,255
    2f6c:	0307879b          	addiw	a5,a5,48
    2f70:	0ff7f793          	andi	a5,a5,255
    2f74:	fcf400a3          	sb	a5,-63(s0)
      fd = open(name, 0);
    2f78:	fc040793          	addi	a5,s0,-64
    2f7c:	4581                	li	a1,0
    2f7e:	853e                	mv	a0,a5
    2f80:	00004097          	auipc	ra,0x4
    2f84:	408080e7          	jalr	1032(ra) # 7388 <open>
    2f88:	87aa                	mv	a5,a0
    2f8a:	fef42223          	sw	a5,-28(s0)
      if((i == 0 || i >= N/2) && fd < 0){
    2f8e:	fec42783          	lw	a5,-20(s0)
    2f92:	2781                	sext.w	a5,a5
    2f94:	cb81                	beqz	a5,2fa4 <createdelete+0x222>
    2f96:	fec42783          	lw	a5,-20(s0)
    2f9a:	0007871b          	sext.w	a4,a5
    2f9e:	47a5                	li	a5,9
    2fa0:	02e7d963          	bge	a5,a4,2fd2 <createdelete+0x250>
    2fa4:	fe442783          	lw	a5,-28(s0)
    2fa8:	2781                	sext.w	a5,a5
    2faa:	0207d463          	bgez	a5,2fd2 <createdelete+0x250>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    2fae:	fc040793          	addi	a5,s0,-64
    2fb2:	863e                	mv	a2,a5
    2fb4:	fa843583          	ld	a1,-88(s0)
    2fb8:	00006517          	auipc	a0,0x6
    2fbc:	ab050513          	addi	a0,a0,-1360 # 8a68 <malloc+0xff0>
    2fc0:	00005097          	auipc	ra,0x5
    2fc4:	8c6080e7          	jalr	-1850(ra) # 7886 <printf>
        exit(1);
    2fc8:	4505                	li	a0,1
    2fca:	00004097          	auipc	ra,0x4
    2fce:	37e080e7          	jalr	894(ra) # 7348 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    2fd2:	fec42783          	lw	a5,-20(s0)
    2fd6:	2781                	sext.w	a5,a5
    2fd8:	04f05063          	blez	a5,3018 <createdelete+0x296>
    2fdc:	fec42783          	lw	a5,-20(s0)
    2fe0:	0007871b          	sext.w	a4,a5
    2fe4:	47a5                	li	a5,9
    2fe6:	02e7c963          	blt	a5,a4,3018 <createdelete+0x296>
    2fea:	fe442783          	lw	a5,-28(s0)
    2fee:	2781                	sext.w	a5,a5
    2ff0:	0207c463          	bltz	a5,3018 <createdelete+0x296>
        printf("%s: oops createdelete %s did exist\n", s, name);
    2ff4:	fc040793          	addi	a5,s0,-64
    2ff8:	863e                	mv	a2,a5
    2ffa:	fa843583          	ld	a1,-88(s0)
    2ffe:	00006517          	auipc	a0,0x6
    3002:	a9250513          	addi	a0,a0,-1390 # 8a90 <malloc+0x1018>
    3006:	00005097          	auipc	ra,0x5
    300a:	880080e7          	jalr	-1920(ra) # 7886 <printf>
        exit(1);
    300e:	4505                	li	a0,1
    3010:	00004097          	auipc	ra,0x4
    3014:	338080e7          	jalr	824(ra) # 7348 <exit>
      }
      if(fd >= 0)
    3018:	fe442783          	lw	a5,-28(s0)
    301c:	2781                	sext.w	a5,a5
    301e:	0007c963          	bltz	a5,3030 <createdelete+0x2ae>
        close(fd);
    3022:	fe442783          	lw	a5,-28(s0)
    3026:	853e                	mv	a0,a5
    3028:	00004097          	auipc	ra,0x4
    302c:	348080e7          	jalr	840(ra) # 7370 <close>
    for(pi = 0; pi < NCHILD; pi++){
    3030:	fe842783          	lw	a5,-24(s0)
    3034:	2785                	addiw	a5,a5,1
    3036:	fef42423          	sw	a5,-24(s0)
    303a:	fe842783          	lw	a5,-24(s0)
    303e:	0007871b          	sext.w	a4,a5
    3042:	478d                	li	a5,3
    3044:	f0e7d6e3          	bge	a5,a4,2f50 <createdelete+0x1ce>
  for(i = 0; i < N; i++){
    3048:	fec42783          	lw	a5,-20(s0)
    304c:	2785                	addiw	a5,a5,1
    304e:	fef42623          	sw	a5,-20(s0)
    3052:	fec42783          	lw	a5,-20(s0)
    3056:	0007871b          	sext.w	a4,a5
    305a:	47cd                	li	a5,19
    305c:	eee7d7e3          	bge	a5,a4,2f4a <createdelete+0x1c8>
    }
  }

  for(i = 0; i < N; i++){
    3060:	fe042623          	sw	zero,-20(s0)
    3064:	a085                	j	30c4 <createdelete+0x342>
    for(pi = 0; pi < NCHILD; pi++){
    3066:	fe042423          	sw	zero,-24(s0)
    306a:	a089                	j	30ac <createdelete+0x32a>
      name[0] = 'p' + i;
    306c:	fec42783          	lw	a5,-20(s0)
    3070:	0ff7f793          	andi	a5,a5,255
    3074:	0707879b          	addiw	a5,a5,112
    3078:	0ff7f793          	andi	a5,a5,255
    307c:	fcf40023          	sb	a5,-64(s0)
      name[1] = '0' + i;
    3080:	fec42783          	lw	a5,-20(s0)
    3084:	0ff7f793          	andi	a5,a5,255
    3088:	0307879b          	addiw	a5,a5,48
    308c:	0ff7f793          	andi	a5,a5,255
    3090:	fcf400a3          	sb	a5,-63(s0)
      unlink(name);
    3094:	fc040793          	addi	a5,s0,-64
    3098:	853e                	mv	a0,a5
    309a:	00004097          	auipc	ra,0x4
    309e:	2fe080e7          	jalr	766(ra) # 7398 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    30a2:	fe842783          	lw	a5,-24(s0)
    30a6:	2785                	addiw	a5,a5,1
    30a8:	fef42423          	sw	a5,-24(s0)
    30ac:	fe842783          	lw	a5,-24(s0)
    30b0:	0007871b          	sext.w	a4,a5
    30b4:	478d                	li	a5,3
    30b6:	fae7dbe3          	bge	a5,a4,306c <createdelete+0x2ea>
  for(i = 0; i < N; i++){
    30ba:	fec42783          	lw	a5,-20(s0)
    30be:	2785                	addiw	a5,a5,1
    30c0:	fef42623          	sw	a5,-20(s0)
    30c4:	fec42783          	lw	a5,-20(s0)
    30c8:	0007871b          	sext.w	a4,a5
    30cc:	47cd                	li	a5,19
    30ce:	f8e7dce3          	bge	a5,a4,3066 <createdelete+0x2e4>
    }
  }
}
    30d2:	0001                	nop
    30d4:	0001                	nop
    30d6:	60e6                	ld	ra,88(sp)
    30d8:	6446                	ld	s0,80(sp)
    30da:	6125                	addi	sp,sp,96
    30dc:	8082                	ret

00000000000030de <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(char *s)
{
    30de:	7179                	addi	sp,sp,-48
    30e0:	f406                	sd	ra,40(sp)
    30e2:	f022                	sd	s0,32(sp)
    30e4:	1800                	addi	s0,sp,48
    30e6:	fca43c23          	sd	a0,-40(s0)
  enum { SZ = 5 };
  int fd, fd1;

  fd = open("unlinkread", O_CREATE | O_RDWR);
    30ea:	20200593          	li	a1,514
    30ee:	00005517          	auipc	a0,0x5
    30f2:	c3a50513          	addi	a0,a0,-966 # 7d28 <malloc+0x2b0>
    30f6:	00004097          	auipc	ra,0x4
    30fa:	292080e7          	jalr	658(ra) # 7388 <open>
    30fe:	87aa                	mv	a5,a0
    3100:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3104:	fec42783          	lw	a5,-20(s0)
    3108:	2781                	sext.w	a5,a5
    310a:	0207d163          	bgez	a5,312c <unlinkread+0x4e>
    printf("%s: create unlinkread failed\n", s);
    310e:	fd843583          	ld	a1,-40(s0)
    3112:	00006517          	auipc	a0,0x6
    3116:	9a650513          	addi	a0,a0,-1626 # 8ab8 <malloc+0x1040>
    311a:	00004097          	auipc	ra,0x4
    311e:	76c080e7          	jalr	1900(ra) # 7886 <printf>
    exit(1);
    3122:	4505                	li	a0,1
    3124:	00004097          	auipc	ra,0x4
    3128:	224080e7          	jalr	548(ra) # 7348 <exit>
  }
  write(fd, "hello", SZ);
    312c:	fec42783          	lw	a5,-20(s0)
    3130:	4615                	li	a2,5
    3132:	00006597          	auipc	a1,0x6
    3136:	9a658593          	addi	a1,a1,-1626 # 8ad8 <malloc+0x1060>
    313a:	853e                	mv	a0,a5
    313c:	00004097          	auipc	ra,0x4
    3140:	22c080e7          	jalr	556(ra) # 7368 <write>
  close(fd);
    3144:	fec42783          	lw	a5,-20(s0)
    3148:	853e                	mv	a0,a5
    314a:	00004097          	auipc	ra,0x4
    314e:	226080e7          	jalr	550(ra) # 7370 <close>

  fd = open("unlinkread", O_RDWR);
    3152:	4589                	li	a1,2
    3154:	00005517          	auipc	a0,0x5
    3158:	bd450513          	addi	a0,a0,-1068 # 7d28 <malloc+0x2b0>
    315c:	00004097          	auipc	ra,0x4
    3160:	22c080e7          	jalr	556(ra) # 7388 <open>
    3164:	87aa                	mv	a5,a0
    3166:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    316a:	fec42783          	lw	a5,-20(s0)
    316e:	2781                	sext.w	a5,a5
    3170:	0207d163          	bgez	a5,3192 <unlinkread+0xb4>
    printf("%s: open unlinkread failed\n", s);
    3174:	fd843583          	ld	a1,-40(s0)
    3178:	00006517          	auipc	a0,0x6
    317c:	96850513          	addi	a0,a0,-1688 # 8ae0 <malloc+0x1068>
    3180:	00004097          	auipc	ra,0x4
    3184:	706080e7          	jalr	1798(ra) # 7886 <printf>
    exit(1);
    3188:	4505                	li	a0,1
    318a:	00004097          	auipc	ra,0x4
    318e:	1be080e7          	jalr	446(ra) # 7348 <exit>
  }
  if(unlink("unlinkread") != 0){
    3192:	00005517          	auipc	a0,0x5
    3196:	b9650513          	addi	a0,a0,-1130 # 7d28 <malloc+0x2b0>
    319a:	00004097          	auipc	ra,0x4
    319e:	1fe080e7          	jalr	510(ra) # 7398 <unlink>
    31a2:	87aa                	mv	a5,a0
    31a4:	c385                	beqz	a5,31c4 <unlinkread+0xe6>
    printf("%s: unlink unlinkread failed\n", s);
    31a6:	fd843583          	ld	a1,-40(s0)
    31aa:	00006517          	auipc	a0,0x6
    31ae:	95650513          	addi	a0,a0,-1706 # 8b00 <malloc+0x1088>
    31b2:	00004097          	auipc	ra,0x4
    31b6:	6d4080e7          	jalr	1748(ra) # 7886 <printf>
    exit(1);
    31ba:	4505                	li	a0,1
    31bc:	00004097          	auipc	ra,0x4
    31c0:	18c080e7          	jalr	396(ra) # 7348 <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    31c4:	20200593          	li	a1,514
    31c8:	00005517          	auipc	a0,0x5
    31cc:	b6050513          	addi	a0,a0,-1184 # 7d28 <malloc+0x2b0>
    31d0:	00004097          	auipc	ra,0x4
    31d4:	1b8080e7          	jalr	440(ra) # 7388 <open>
    31d8:	87aa                	mv	a5,a0
    31da:	fef42423          	sw	a5,-24(s0)
  write(fd1, "yyy", 3);
    31de:	fe842783          	lw	a5,-24(s0)
    31e2:	460d                	li	a2,3
    31e4:	00006597          	auipc	a1,0x6
    31e8:	93c58593          	addi	a1,a1,-1732 # 8b20 <malloc+0x10a8>
    31ec:	853e                	mv	a0,a5
    31ee:	00004097          	auipc	ra,0x4
    31f2:	17a080e7          	jalr	378(ra) # 7368 <write>
  close(fd1);
    31f6:	fe842783          	lw	a5,-24(s0)
    31fa:	853e                	mv	a0,a5
    31fc:	00004097          	auipc	ra,0x4
    3200:	174080e7          	jalr	372(ra) # 7370 <close>

  if(read(fd, buf, sizeof(buf)) != SZ){
    3204:	fec42783          	lw	a5,-20(s0)
    3208:	660d                	lui	a2,0x3
    320a:	00007597          	auipc	a1,0x7
    320e:	20658593          	addi	a1,a1,518 # a410 <buf>
    3212:	853e                	mv	a0,a5
    3214:	00004097          	auipc	ra,0x4
    3218:	14c080e7          	jalr	332(ra) # 7360 <read>
    321c:	87aa                	mv	a5,a0
    321e:	873e                	mv	a4,a5
    3220:	4795                	li	a5,5
    3222:	02f70163          	beq	a4,a5,3244 <unlinkread+0x166>
    printf("%s: unlinkread read failed", s);
    3226:	fd843583          	ld	a1,-40(s0)
    322a:	00006517          	auipc	a0,0x6
    322e:	8fe50513          	addi	a0,a0,-1794 # 8b28 <malloc+0x10b0>
    3232:	00004097          	auipc	ra,0x4
    3236:	654080e7          	jalr	1620(ra) # 7886 <printf>
    exit(1);
    323a:	4505                	li	a0,1
    323c:	00004097          	auipc	ra,0x4
    3240:	10c080e7          	jalr	268(ra) # 7348 <exit>
  }
  if(buf[0] != 'h'){
    3244:	00007797          	auipc	a5,0x7
    3248:	1cc78793          	addi	a5,a5,460 # a410 <buf>
    324c:	0007c783          	lbu	a5,0(a5)
    3250:	873e                	mv	a4,a5
    3252:	06800793          	li	a5,104
    3256:	02f70163          	beq	a4,a5,3278 <unlinkread+0x19a>
    printf("%s: unlinkread wrong data\n", s);
    325a:	fd843583          	ld	a1,-40(s0)
    325e:	00006517          	auipc	a0,0x6
    3262:	8ea50513          	addi	a0,a0,-1814 # 8b48 <malloc+0x10d0>
    3266:	00004097          	auipc	ra,0x4
    326a:	620080e7          	jalr	1568(ra) # 7886 <printf>
    exit(1);
    326e:	4505                	li	a0,1
    3270:	00004097          	auipc	ra,0x4
    3274:	0d8080e7          	jalr	216(ra) # 7348 <exit>
  }
  if(write(fd, buf, 10) != 10){
    3278:	fec42783          	lw	a5,-20(s0)
    327c:	4629                	li	a2,10
    327e:	00007597          	auipc	a1,0x7
    3282:	19258593          	addi	a1,a1,402 # a410 <buf>
    3286:	853e                	mv	a0,a5
    3288:	00004097          	auipc	ra,0x4
    328c:	0e0080e7          	jalr	224(ra) # 7368 <write>
    3290:	87aa                	mv	a5,a0
    3292:	873e                	mv	a4,a5
    3294:	47a9                	li	a5,10
    3296:	02f70163          	beq	a4,a5,32b8 <unlinkread+0x1da>
    printf("%s: unlinkread write failed\n", s);
    329a:	fd843583          	ld	a1,-40(s0)
    329e:	00006517          	auipc	a0,0x6
    32a2:	8ca50513          	addi	a0,a0,-1846 # 8b68 <malloc+0x10f0>
    32a6:	00004097          	auipc	ra,0x4
    32aa:	5e0080e7          	jalr	1504(ra) # 7886 <printf>
    exit(1);
    32ae:	4505                	li	a0,1
    32b0:	00004097          	auipc	ra,0x4
    32b4:	098080e7          	jalr	152(ra) # 7348 <exit>
  }
  close(fd);
    32b8:	fec42783          	lw	a5,-20(s0)
    32bc:	853e                	mv	a0,a5
    32be:	00004097          	auipc	ra,0x4
    32c2:	0b2080e7          	jalr	178(ra) # 7370 <close>
  unlink("unlinkread");
    32c6:	00005517          	auipc	a0,0x5
    32ca:	a6250513          	addi	a0,a0,-1438 # 7d28 <malloc+0x2b0>
    32ce:	00004097          	auipc	ra,0x4
    32d2:	0ca080e7          	jalr	202(ra) # 7398 <unlink>
}
    32d6:	0001                	nop
    32d8:	70a2                	ld	ra,40(sp)
    32da:	7402                	ld	s0,32(sp)
    32dc:	6145                	addi	sp,sp,48
    32de:	8082                	ret

00000000000032e0 <linktest>:

void
linktest(char *s)
{
    32e0:	7179                	addi	sp,sp,-48
    32e2:	f406                	sd	ra,40(sp)
    32e4:	f022                	sd	s0,32(sp)
    32e6:	1800                	addi	s0,sp,48
    32e8:	fca43c23          	sd	a0,-40(s0)
  enum { SZ = 5 };
  int fd;

  unlink("lf1");
    32ec:	00006517          	auipc	a0,0x6
    32f0:	89c50513          	addi	a0,a0,-1892 # 8b88 <malloc+0x1110>
    32f4:	00004097          	auipc	ra,0x4
    32f8:	0a4080e7          	jalr	164(ra) # 7398 <unlink>
  unlink("lf2");
    32fc:	00006517          	auipc	a0,0x6
    3300:	89450513          	addi	a0,a0,-1900 # 8b90 <malloc+0x1118>
    3304:	00004097          	auipc	ra,0x4
    3308:	094080e7          	jalr	148(ra) # 7398 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    330c:	20200593          	li	a1,514
    3310:	00006517          	auipc	a0,0x6
    3314:	87850513          	addi	a0,a0,-1928 # 8b88 <malloc+0x1110>
    3318:	00004097          	auipc	ra,0x4
    331c:	070080e7          	jalr	112(ra) # 7388 <open>
    3320:	87aa                	mv	a5,a0
    3322:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3326:	fec42783          	lw	a5,-20(s0)
    332a:	2781                	sext.w	a5,a5
    332c:	0207d163          	bgez	a5,334e <linktest+0x6e>
    printf("%s: create lf1 failed\n", s);
    3330:	fd843583          	ld	a1,-40(s0)
    3334:	00006517          	auipc	a0,0x6
    3338:	86450513          	addi	a0,a0,-1948 # 8b98 <malloc+0x1120>
    333c:	00004097          	auipc	ra,0x4
    3340:	54a080e7          	jalr	1354(ra) # 7886 <printf>
    exit(1);
    3344:	4505                	li	a0,1
    3346:	00004097          	auipc	ra,0x4
    334a:	002080e7          	jalr	2(ra) # 7348 <exit>
  }
  if(write(fd, "hello", SZ) != SZ){
    334e:	fec42783          	lw	a5,-20(s0)
    3352:	4615                	li	a2,5
    3354:	00005597          	auipc	a1,0x5
    3358:	78458593          	addi	a1,a1,1924 # 8ad8 <malloc+0x1060>
    335c:	853e                	mv	a0,a5
    335e:	00004097          	auipc	ra,0x4
    3362:	00a080e7          	jalr	10(ra) # 7368 <write>
    3366:	87aa                	mv	a5,a0
    3368:	873e                	mv	a4,a5
    336a:	4795                	li	a5,5
    336c:	02f70163          	beq	a4,a5,338e <linktest+0xae>
    printf("%s: write lf1 failed\n", s);
    3370:	fd843583          	ld	a1,-40(s0)
    3374:	00006517          	auipc	a0,0x6
    3378:	83c50513          	addi	a0,a0,-1988 # 8bb0 <malloc+0x1138>
    337c:	00004097          	auipc	ra,0x4
    3380:	50a080e7          	jalr	1290(ra) # 7886 <printf>
    exit(1);
    3384:	4505                	li	a0,1
    3386:	00004097          	auipc	ra,0x4
    338a:	fc2080e7          	jalr	-62(ra) # 7348 <exit>
  }
  close(fd);
    338e:	fec42783          	lw	a5,-20(s0)
    3392:	853e                	mv	a0,a5
    3394:	00004097          	auipc	ra,0x4
    3398:	fdc080e7          	jalr	-36(ra) # 7370 <close>

  if(link("lf1", "lf2") < 0){
    339c:	00005597          	auipc	a1,0x5
    33a0:	7f458593          	addi	a1,a1,2036 # 8b90 <malloc+0x1118>
    33a4:	00005517          	auipc	a0,0x5
    33a8:	7e450513          	addi	a0,a0,2020 # 8b88 <malloc+0x1110>
    33ac:	00004097          	auipc	ra,0x4
    33b0:	ffc080e7          	jalr	-4(ra) # 73a8 <link>
    33b4:	87aa                	mv	a5,a0
    33b6:	0207d163          	bgez	a5,33d8 <linktest+0xf8>
    printf("%s: link lf1 lf2 failed\n", s);
    33ba:	fd843583          	ld	a1,-40(s0)
    33be:	00006517          	auipc	a0,0x6
    33c2:	80a50513          	addi	a0,a0,-2038 # 8bc8 <malloc+0x1150>
    33c6:	00004097          	auipc	ra,0x4
    33ca:	4c0080e7          	jalr	1216(ra) # 7886 <printf>
    exit(1);
    33ce:	4505                	li	a0,1
    33d0:	00004097          	auipc	ra,0x4
    33d4:	f78080e7          	jalr	-136(ra) # 7348 <exit>
  }
  unlink("lf1");
    33d8:	00005517          	auipc	a0,0x5
    33dc:	7b050513          	addi	a0,a0,1968 # 8b88 <malloc+0x1110>
    33e0:	00004097          	auipc	ra,0x4
    33e4:	fb8080e7          	jalr	-72(ra) # 7398 <unlink>

  if(open("lf1", 0) >= 0){
    33e8:	4581                	li	a1,0
    33ea:	00005517          	auipc	a0,0x5
    33ee:	79e50513          	addi	a0,a0,1950 # 8b88 <malloc+0x1110>
    33f2:	00004097          	auipc	ra,0x4
    33f6:	f96080e7          	jalr	-106(ra) # 7388 <open>
    33fa:	87aa                	mv	a5,a0
    33fc:	0207c163          	bltz	a5,341e <linktest+0x13e>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    3400:	fd843583          	ld	a1,-40(s0)
    3404:	00005517          	auipc	a0,0x5
    3408:	7e450513          	addi	a0,a0,2020 # 8be8 <malloc+0x1170>
    340c:	00004097          	auipc	ra,0x4
    3410:	47a080e7          	jalr	1146(ra) # 7886 <printf>
    exit(1);
    3414:	4505                	li	a0,1
    3416:	00004097          	auipc	ra,0x4
    341a:	f32080e7          	jalr	-206(ra) # 7348 <exit>
  }

  fd = open("lf2", 0);
    341e:	4581                	li	a1,0
    3420:	00005517          	auipc	a0,0x5
    3424:	77050513          	addi	a0,a0,1904 # 8b90 <malloc+0x1118>
    3428:	00004097          	auipc	ra,0x4
    342c:	f60080e7          	jalr	-160(ra) # 7388 <open>
    3430:	87aa                	mv	a5,a0
    3432:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3436:	fec42783          	lw	a5,-20(s0)
    343a:	2781                	sext.w	a5,a5
    343c:	0207d163          	bgez	a5,345e <linktest+0x17e>
    printf("%s: open lf2 failed\n", s);
    3440:	fd843583          	ld	a1,-40(s0)
    3444:	00005517          	auipc	a0,0x5
    3448:	7d450513          	addi	a0,a0,2004 # 8c18 <malloc+0x11a0>
    344c:	00004097          	auipc	ra,0x4
    3450:	43a080e7          	jalr	1082(ra) # 7886 <printf>
    exit(1);
    3454:	4505                	li	a0,1
    3456:	00004097          	auipc	ra,0x4
    345a:	ef2080e7          	jalr	-270(ra) # 7348 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != SZ){
    345e:	fec42783          	lw	a5,-20(s0)
    3462:	660d                	lui	a2,0x3
    3464:	00007597          	auipc	a1,0x7
    3468:	fac58593          	addi	a1,a1,-84 # a410 <buf>
    346c:	853e                	mv	a0,a5
    346e:	00004097          	auipc	ra,0x4
    3472:	ef2080e7          	jalr	-270(ra) # 7360 <read>
    3476:	87aa                	mv	a5,a0
    3478:	873e                	mv	a4,a5
    347a:	4795                	li	a5,5
    347c:	02f70163          	beq	a4,a5,349e <linktest+0x1be>
    printf("%s: read lf2 failed\n", s);
    3480:	fd843583          	ld	a1,-40(s0)
    3484:	00005517          	auipc	a0,0x5
    3488:	7ac50513          	addi	a0,a0,1964 # 8c30 <malloc+0x11b8>
    348c:	00004097          	auipc	ra,0x4
    3490:	3fa080e7          	jalr	1018(ra) # 7886 <printf>
    exit(1);
    3494:	4505                	li	a0,1
    3496:	00004097          	auipc	ra,0x4
    349a:	eb2080e7          	jalr	-334(ra) # 7348 <exit>
  }
  close(fd);
    349e:	fec42783          	lw	a5,-20(s0)
    34a2:	853e                	mv	a0,a5
    34a4:	00004097          	auipc	ra,0x4
    34a8:	ecc080e7          	jalr	-308(ra) # 7370 <close>

  if(link("lf2", "lf2") >= 0){
    34ac:	00005597          	auipc	a1,0x5
    34b0:	6e458593          	addi	a1,a1,1764 # 8b90 <malloc+0x1118>
    34b4:	00005517          	auipc	a0,0x5
    34b8:	6dc50513          	addi	a0,a0,1756 # 8b90 <malloc+0x1118>
    34bc:	00004097          	auipc	ra,0x4
    34c0:	eec080e7          	jalr	-276(ra) # 73a8 <link>
    34c4:	87aa                	mv	a5,a0
    34c6:	0207c163          	bltz	a5,34e8 <linktest+0x208>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    34ca:	fd843583          	ld	a1,-40(s0)
    34ce:	00005517          	auipc	a0,0x5
    34d2:	77a50513          	addi	a0,a0,1914 # 8c48 <malloc+0x11d0>
    34d6:	00004097          	auipc	ra,0x4
    34da:	3b0080e7          	jalr	944(ra) # 7886 <printf>
    exit(1);
    34de:	4505                	li	a0,1
    34e0:	00004097          	auipc	ra,0x4
    34e4:	e68080e7          	jalr	-408(ra) # 7348 <exit>
  }

  unlink("lf2");
    34e8:	00005517          	auipc	a0,0x5
    34ec:	6a850513          	addi	a0,a0,1704 # 8b90 <malloc+0x1118>
    34f0:	00004097          	auipc	ra,0x4
    34f4:	ea8080e7          	jalr	-344(ra) # 7398 <unlink>
  if(link("lf2", "lf1") >= 0){
    34f8:	00005597          	auipc	a1,0x5
    34fc:	69058593          	addi	a1,a1,1680 # 8b88 <malloc+0x1110>
    3500:	00005517          	auipc	a0,0x5
    3504:	69050513          	addi	a0,a0,1680 # 8b90 <malloc+0x1118>
    3508:	00004097          	auipc	ra,0x4
    350c:	ea0080e7          	jalr	-352(ra) # 73a8 <link>
    3510:	87aa                	mv	a5,a0
    3512:	0207c163          	bltz	a5,3534 <linktest+0x254>
    printf("%s: link non-existent succeeded! oops\n", s);
    3516:	fd843583          	ld	a1,-40(s0)
    351a:	00005517          	auipc	a0,0x5
    351e:	75650513          	addi	a0,a0,1878 # 8c70 <malloc+0x11f8>
    3522:	00004097          	auipc	ra,0x4
    3526:	364080e7          	jalr	868(ra) # 7886 <printf>
    exit(1);
    352a:	4505                	li	a0,1
    352c:	00004097          	auipc	ra,0x4
    3530:	e1c080e7          	jalr	-484(ra) # 7348 <exit>
  }

  if(link(".", "lf1") >= 0){
    3534:	00005597          	auipc	a1,0x5
    3538:	65458593          	addi	a1,a1,1620 # 8b88 <malloc+0x1110>
    353c:	00005517          	auipc	a0,0x5
    3540:	75c50513          	addi	a0,a0,1884 # 8c98 <malloc+0x1220>
    3544:	00004097          	auipc	ra,0x4
    3548:	e64080e7          	jalr	-412(ra) # 73a8 <link>
    354c:	87aa                	mv	a5,a0
    354e:	0207c163          	bltz	a5,3570 <linktest+0x290>
    printf("%s: link . lf1 succeeded! oops\n", s);
    3552:	fd843583          	ld	a1,-40(s0)
    3556:	00005517          	auipc	a0,0x5
    355a:	74a50513          	addi	a0,a0,1866 # 8ca0 <malloc+0x1228>
    355e:	00004097          	auipc	ra,0x4
    3562:	328080e7          	jalr	808(ra) # 7886 <printf>
    exit(1);
    3566:	4505                	li	a0,1
    3568:	00004097          	auipc	ra,0x4
    356c:	de0080e7          	jalr	-544(ra) # 7348 <exit>
  }
}
    3570:	0001                	nop
    3572:	70a2                	ld	ra,40(sp)
    3574:	7402                	ld	s0,32(sp)
    3576:	6145                	addi	sp,sp,48
    3578:	8082                	ret

000000000000357a <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(char *s)
{
    357a:	7119                	addi	sp,sp,-128
    357c:	fc86                	sd	ra,120(sp)
    357e:	f8a2                	sd	s0,112(sp)
    3580:	0100                	addi	s0,sp,128
    3582:	f8a43423          	sd	a0,-120(s0)
  struct {
    ushort inum;
    char name[DIRSIZ];
  } de;

  file[0] = 'C';
    3586:	04300793          	li	a5,67
    358a:	fcf40c23          	sb	a5,-40(s0)
  file[2] = '\0';
    358e:	fc040d23          	sb	zero,-38(s0)
  for(i = 0; i < N; i++){
    3592:	fe042623          	sw	zero,-20(s0)
    3596:	a215                	j	36ba <concreate+0x140>
    file[1] = '0' + i;
    3598:	fec42783          	lw	a5,-20(s0)
    359c:	0ff7f793          	andi	a5,a5,255
    35a0:	0307879b          	addiw	a5,a5,48
    35a4:	0ff7f793          	andi	a5,a5,255
    35a8:	fcf40ca3          	sb	a5,-39(s0)
    unlink(file);
    35ac:	fd840793          	addi	a5,s0,-40
    35b0:	853e                	mv	a0,a5
    35b2:	00004097          	auipc	ra,0x4
    35b6:	de6080e7          	jalr	-538(ra) # 7398 <unlink>
    pid = fork();
    35ba:	00004097          	auipc	ra,0x4
    35be:	d86080e7          	jalr	-634(ra) # 7340 <fork>
    35c2:	87aa                	mv	a5,a0
    35c4:	fef42023          	sw	a5,-32(s0)
    if(pid && (i % 3) == 1){
    35c8:	fe042783          	lw	a5,-32(s0)
    35cc:	2781                	sext.w	a5,a5
    35ce:	c79d                	beqz	a5,35fc <concreate+0x82>
    35d0:	fec42703          	lw	a4,-20(s0)
    35d4:	478d                	li	a5,3
    35d6:	02f767bb          	remw	a5,a4,a5
    35da:	2781                	sext.w	a5,a5
    35dc:	873e                	mv	a4,a5
    35de:	4785                	li	a5,1
    35e0:	00f71e63          	bne	a4,a5,35fc <concreate+0x82>
      link("C0", file);
    35e4:	fd840793          	addi	a5,s0,-40
    35e8:	85be                	mv	a1,a5
    35ea:	00005517          	auipc	a0,0x5
    35ee:	6d650513          	addi	a0,a0,1750 # 8cc0 <malloc+0x1248>
    35f2:	00004097          	auipc	ra,0x4
    35f6:	db6080e7          	jalr	-586(ra) # 73a8 <link>
    35fa:	a059                	j	3680 <concreate+0x106>
    } else if(pid == 0 && (i % 5) == 1){
    35fc:	fe042783          	lw	a5,-32(s0)
    3600:	2781                	sext.w	a5,a5
    3602:	e79d                	bnez	a5,3630 <concreate+0xb6>
    3604:	fec42703          	lw	a4,-20(s0)
    3608:	4795                	li	a5,5
    360a:	02f767bb          	remw	a5,a4,a5
    360e:	2781                	sext.w	a5,a5
    3610:	873e                	mv	a4,a5
    3612:	4785                	li	a5,1
    3614:	00f71e63          	bne	a4,a5,3630 <concreate+0xb6>
      link("C0", file);
    3618:	fd840793          	addi	a5,s0,-40
    361c:	85be                	mv	a1,a5
    361e:	00005517          	auipc	a0,0x5
    3622:	6a250513          	addi	a0,a0,1698 # 8cc0 <malloc+0x1248>
    3626:	00004097          	auipc	ra,0x4
    362a:	d82080e7          	jalr	-638(ra) # 73a8 <link>
    362e:	a889                	j	3680 <concreate+0x106>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    3630:	fd840793          	addi	a5,s0,-40
    3634:	20200593          	li	a1,514
    3638:	853e                	mv	a0,a5
    363a:	00004097          	auipc	ra,0x4
    363e:	d4e080e7          	jalr	-690(ra) # 7388 <open>
    3642:	87aa                	mv	a5,a0
    3644:	fef42223          	sw	a5,-28(s0)
      if(fd < 0){
    3648:	fe442783          	lw	a5,-28(s0)
    364c:	2781                	sext.w	a5,a5
    364e:	0207d263          	bgez	a5,3672 <concreate+0xf8>
        printf("concreate create %s failed\n", file);
    3652:	fd840793          	addi	a5,s0,-40
    3656:	85be                	mv	a1,a5
    3658:	00005517          	auipc	a0,0x5
    365c:	67050513          	addi	a0,a0,1648 # 8cc8 <malloc+0x1250>
    3660:	00004097          	auipc	ra,0x4
    3664:	226080e7          	jalr	550(ra) # 7886 <printf>
        exit(1);
    3668:	4505                	li	a0,1
    366a:	00004097          	auipc	ra,0x4
    366e:	cde080e7          	jalr	-802(ra) # 7348 <exit>
      }
      close(fd);
    3672:	fe442783          	lw	a5,-28(s0)
    3676:	853e                	mv	a0,a5
    3678:	00004097          	auipc	ra,0x4
    367c:	cf8080e7          	jalr	-776(ra) # 7370 <close>
    }
    if(pid == 0) {
    3680:	fe042783          	lw	a5,-32(s0)
    3684:	2781                	sext.w	a5,a5
    3686:	e791                	bnez	a5,3692 <concreate+0x118>
      exit(0);
    3688:	4501                	li	a0,0
    368a:	00004097          	auipc	ra,0x4
    368e:	cbe080e7          	jalr	-834(ra) # 7348 <exit>
    } else {
      int xstatus;
      wait(&xstatus);
    3692:	f9c40793          	addi	a5,s0,-100
    3696:	853e                	mv	a0,a5
    3698:	00004097          	auipc	ra,0x4
    369c:	cb8080e7          	jalr	-840(ra) # 7350 <wait>
      if(xstatus != 0)
    36a0:	f9c42783          	lw	a5,-100(s0)
    36a4:	c791                	beqz	a5,36b0 <concreate+0x136>
        exit(1);
    36a6:	4505                	li	a0,1
    36a8:	00004097          	auipc	ra,0x4
    36ac:	ca0080e7          	jalr	-864(ra) # 7348 <exit>
  for(i = 0; i < N; i++){
    36b0:	fec42783          	lw	a5,-20(s0)
    36b4:	2785                	addiw	a5,a5,1
    36b6:	fef42623          	sw	a5,-20(s0)
    36ba:	fec42783          	lw	a5,-20(s0)
    36be:	0007871b          	sext.w	a4,a5
    36c2:	02700793          	li	a5,39
    36c6:	ece7d9e3          	bge	a5,a4,3598 <concreate+0x1e>
    }
  }

  memset(fa, 0, sizeof(fa));
    36ca:	fb040793          	addi	a5,s0,-80
    36ce:	02800613          	li	a2,40
    36d2:	4581                	li	a1,0
    36d4:	853e                	mv	a0,a5
    36d6:	00004097          	auipc	ra,0x4
    36da:	8c8080e7          	jalr	-1848(ra) # 6f9e <memset>
  fd = open(".", 0);
    36de:	4581                	li	a1,0
    36e0:	00005517          	auipc	a0,0x5
    36e4:	5b850513          	addi	a0,a0,1464 # 8c98 <malloc+0x1220>
    36e8:	00004097          	auipc	ra,0x4
    36ec:	ca0080e7          	jalr	-864(ra) # 7388 <open>
    36f0:	87aa                	mv	a5,a0
    36f2:	fef42223          	sw	a5,-28(s0)
  n = 0;
    36f6:	fe042423          	sw	zero,-24(s0)
  while(read(fd, &de, sizeof(de)) > 0){
    36fa:	a86d                	j	37b4 <concreate+0x23a>
    if(de.inum == 0)
    36fc:	fa045783          	lhu	a5,-96(s0)
    3700:	e391                	bnez	a5,3704 <concreate+0x18a>
      continue;
    3702:	a84d                	j	37b4 <concreate+0x23a>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    3704:	fa244783          	lbu	a5,-94(s0)
    3708:	873e                	mv	a4,a5
    370a:	04300793          	li	a5,67
    370e:	0af71363          	bne	a4,a5,37b4 <concreate+0x23a>
    3712:	fa444783          	lbu	a5,-92(s0)
    3716:	efd9                	bnez	a5,37b4 <concreate+0x23a>
      i = de.name[1] - '0';
    3718:	fa344783          	lbu	a5,-93(s0)
    371c:	2781                	sext.w	a5,a5
    371e:	fd07879b          	addiw	a5,a5,-48
    3722:	fef42623          	sw	a5,-20(s0)
      if(i < 0 || i >= sizeof(fa)){
    3726:	fec42783          	lw	a5,-20(s0)
    372a:	2781                	sext.w	a5,a5
    372c:	0007c963          	bltz	a5,373e <concreate+0x1c4>
    3730:	fec42783          	lw	a5,-20(s0)
    3734:	873e                	mv	a4,a5
    3736:	02700793          	li	a5,39
    373a:	02e7f563          	bgeu	a5,a4,3764 <concreate+0x1ea>
        printf("%s: concreate weird file %s\n", s, de.name);
    373e:	fa040793          	addi	a5,s0,-96
    3742:	0789                	addi	a5,a5,2
    3744:	863e                	mv	a2,a5
    3746:	f8843583          	ld	a1,-120(s0)
    374a:	00005517          	auipc	a0,0x5
    374e:	59e50513          	addi	a0,a0,1438 # 8ce8 <malloc+0x1270>
    3752:	00004097          	auipc	ra,0x4
    3756:	134080e7          	jalr	308(ra) # 7886 <printf>
        exit(1);
    375a:	4505                	li	a0,1
    375c:	00004097          	auipc	ra,0x4
    3760:	bec080e7          	jalr	-1044(ra) # 7348 <exit>
      }
      if(fa[i]){
    3764:	fec42783          	lw	a5,-20(s0)
    3768:	ff040713          	addi	a4,s0,-16
    376c:	97ba                	add	a5,a5,a4
    376e:	fc07c783          	lbu	a5,-64(a5)
    3772:	c785                	beqz	a5,379a <concreate+0x220>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    3774:	fa040793          	addi	a5,s0,-96
    3778:	0789                	addi	a5,a5,2
    377a:	863e                	mv	a2,a5
    377c:	f8843583          	ld	a1,-120(s0)
    3780:	00005517          	auipc	a0,0x5
    3784:	58850513          	addi	a0,a0,1416 # 8d08 <malloc+0x1290>
    3788:	00004097          	auipc	ra,0x4
    378c:	0fe080e7          	jalr	254(ra) # 7886 <printf>
        exit(1);
    3790:	4505                	li	a0,1
    3792:	00004097          	auipc	ra,0x4
    3796:	bb6080e7          	jalr	-1098(ra) # 7348 <exit>
      }
      fa[i] = 1;
    379a:	fec42783          	lw	a5,-20(s0)
    379e:	ff040713          	addi	a4,s0,-16
    37a2:	97ba                	add	a5,a5,a4
    37a4:	4705                	li	a4,1
    37a6:	fce78023          	sb	a4,-64(a5)
      n++;
    37aa:	fe842783          	lw	a5,-24(s0)
    37ae:	2785                	addiw	a5,a5,1
    37b0:	fef42423          	sw	a5,-24(s0)
  while(read(fd, &de, sizeof(de)) > 0){
    37b4:	fa040713          	addi	a4,s0,-96
    37b8:	fe442783          	lw	a5,-28(s0)
    37bc:	4641                	li	a2,16
    37be:	85ba                	mv	a1,a4
    37c0:	853e                	mv	a0,a5
    37c2:	00004097          	auipc	ra,0x4
    37c6:	b9e080e7          	jalr	-1122(ra) # 7360 <read>
    37ca:	87aa                	mv	a5,a0
    37cc:	f2f048e3          	bgtz	a5,36fc <concreate+0x182>
    }
  }
  close(fd);
    37d0:	fe442783          	lw	a5,-28(s0)
    37d4:	853e                	mv	a0,a5
    37d6:	00004097          	auipc	ra,0x4
    37da:	b9a080e7          	jalr	-1126(ra) # 7370 <close>

  if(n != N){
    37de:	fe842783          	lw	a5,-24(s0)
    37e2:	0007871b          	sext.w	a4,a5
    37e6:	02800793          	li	a5,40
    37ea:	02f70163          	beq	a4,a5,380c <concreate+0x292>
    printf("%s: concreate not enough files in directory listing\n", s);
    37ee:	f8843583          	ld	a1,-120(s0)
    37f2:	00005517          	auipc	a0,0x5
    37f6:	53e50513          	addi	a0,a0,1342 # 8d30 <malloc+0x12b8>
    37fa:	00004097          	auipc	ra,0x4
    37fe:	08c080e7          	jalr	140(ra) # 7886 <printf>
    exit(1);
    3802:	4505                	li	a0,1
    3804:	00004097          	auipc	ra,0x4
    3808:	b44080e7          	jalr	-1212(ra) # 7348 <exit>
  }

  for(i = 0; i < N; i++){
    380c:	fe042623          	sw	zero,-20(s0)
    3810:	a24d                	j	39b2 <concreate+0x438>
    file[1] = '0' + i;
    3812:	fec42783          	lw	a5,-20(s0)
    3816:	0ff7f793          	andi	a5,a5,255
    381a:	0307879b          	addiw	a5,a5,48
    381e:	0ff7f793          	andi	a5,a5,255
    3822:	fcf40ca3          	sb	a5,-39(s0)
    pid = fork();
    3826:	00004097          	auipc	ra,0x4
    382a:	b1a080e7          	jalr	-1254(ra) # 7340 <fork>
    382e:	87aa                	mv	a5,a0
    3830:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    3834:	fe042783          	lw	a5,-32(s0)
    3838:	2781                	sext.w	a5,a5
    383a:	0207d163          	bgez	a5,385c <concreate+0x2e2>
      printf("%s: fork failed\n", s);
    383e:	f8843583          	ld	a1,-120(s0)
    3842:	00005517          	auipc	a0,0x5
    3846:	b0e50513          	addi	a0,a0,-1266 # 8350 <malloc+0x8d8>
    384a:	00004097          	auipc	ra,0x4
    384e:	03c080e7          	jalr	60(ra) # 7886 <printf>
      exit(1);
    3852:	4505                	li	a0,1
    3854:	00004097          	auipc	ra,0x4
    3858:	af4080e7          	jalr	-1292(ra) # 7348 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    385c:	fec42703          	lw	a4,-20(s0)
    3860:	478d                	li	a5,3
    3862:	02f767bb          	remw	a5,a4,a5
    3866:	2781                	sext.w	a5,a5
    3868:	e789                	bnez	a5,3872 <concreate+0x2f8>
    386a:	fe042783          	lw	a5,-32(s0)
    386e:	2781                	sext.w	a5,a5
    3870:	cf99                	beqz	a5,388e <concreate+0x314>
       ((i % 3) == 1 && pid != 0)){
    3872:	fec42703          	lw	a4,-20(s0)
    3876:	478d                	li	a5,3
    3878:	02f767bb          	remw	a5,a4,a5
    387c:	2781                	sext.w	a5,a5
    if(((i % 3) == 0 && pid == 0) ||
    387e:	873e                	mv	a4,a5
    3880:	4785                	li	a5,1
    3882:	0af71b63          	bne	a4,a5,3938 <concreate+0x3be>
       ((i % 3) == 1 && pid != 0)){
    3886:	fe042783          	lw	a5,-32(s0)
    388a:	2781                	sext.w	a5,a5
    388c:	c7d5                	beqz	a5,3938 <concreate+0x3be>
      close(open(file, 0));
    388e:	fd840793          	addi	a5,s0,-40
    3892:	4581                	li	a1,0
    3894:	853e                	mv	a0,a5
    3896:	00004097          	auipc	ra,0x4
    389a:	af2080e7          	jalr	-1294(ra) # 7388 <open>
    389e:	87aa                	mv	a5,a0
    38a0:	853e                	mv	a0,a5
    38a2:	00004097          	auipc	ra,0x4
    38a6:	ace080e7          	jalr	-1330(ra) # 7370 <close>
      close(open(file, 0));
    38aa:	fd840793          	addi	a5,s0,-40
    38ae:	4581                	li	a1,0
    38b0:	853e                	mv	a0,a5
    38b2:	00004097          	auipc	ra,0x4
    38b6:	ad6080e7          	jalr	-1322(ra) # 7388 <open>
    38ba:	87aa                	mv	a5,a0
    38bc:	853e                	mv	a0,a5
    38be:	00004097          	auipc	ra,0x4
    38c2:	ab2080e7          	jalr	-1358(ra) # 7370 <close>
      close(open(file, 0));
    38c6:	fd840793          	addi	a5,s0,-40
    38ca:	4581                	li	a1,0
    38cc:	853e                	mv	a0,a5
    38ce:	00004097          	auipc	ra,0x4
    38d2:	aba080e7          	jalr	-1350(ra) # 7388 <open>
    38d6:	87aa                	mv	a5,a0
    38d8:	853e                	mv	a0,a5
    38da:	00004097          	auipc	ra,0x4
    38de:	a96080e7          	jalr	-1386(ra) # 7370 <close>
      close(open(file, 0));
    38e2:	fd840793          	addi	a5,s0,-40
    38e6:	4581                	li	a1,0
    38e8:	853e                	mv	a0,a5
    38ea:	00004097          	auipc	ra,0x4
    38ee:	a9e080e7          	jalr	-1378(ra) # 7388 <open>
    38f2:	87aa                	mv	a5,a0
    38f4:	853e                	mv	a0,a5
    38f6:	00004097          	auipc	ra,0x4
    38fa:	a7a080e7          	jalr	-1414(ra) # 7370 <close>
      close(open(file, 0));
    38fe:	fd840793          	addi	a5,s0,-40
    3902:	4581                	li	a1,0
    3904:	853e                	mv	a0,a5
    3906:	00004097          	auipc	ra,0x4
    390a:	a82080e7          	jalr	-1406(ra) # 7388 <open>
    390e:	87aa                	mv	a5,a0
    3910:	853e                	mv	a0,a5
    3912:	00004097          	auipc	ra,0x4
    3916:	a5e080e7          	jalr	-1442(ra) # 7370 <close>
      close(open(file, 0));
    391a:	fd840793          	addi	a5,s0,-40
    391e:	4581                	li	a1,0
    3920:	853e                	mv	a0,a5
    3922:	00004097          	auipc	ra,0x4
    3926:	a66080e7          	jalr	-1434(ra) # 7388 <open>
    392a:	87aa                	mv	a5,a0
    392c:	853e                	mv	a0,a5
    392e:	00004097          	auipc	ra,0x4
    3932:	a42080e7          	jalr	-1470(ra) # 7370 <close>
    3936:	a899                	j	398c <concreate+0x412>
    } else {
      unlink(file);
    3938:	fd840793          	addi	a5,s0,-40
    393c:	853e                	mv	a0,a5
    393e:	00004097          	auipc	ra,0x4
    3942:	a5a080e7          	jalr	-1446(ra) # 7398 <unlink>
      unlink(file);
    3946:	fd840793          	addi	a5,s0,-40
    394a:	853e                	mv	a0,a5
    394c:	00004097          	auipc	ra,0x4
    3950:	a4c080e7          	jalr	-1460(ra) # 7398 <unlink>
      unlink(file);
    3954:	fd840793          	addi	a5,s0,-40
    3958:	853e                	mv	a0,a5
    395a:	00004097          	auipc	ra,0x4
    395e:	a3e080e7          	jalr	-1474(ra) # 7398 <unlink>
      unlink(file);
    3962:	fd840793          	addi	a5,s0,-40
    3966:	853e                	mv	a0,a5
    3968:	00004097          	auipc	ra,0x4
    396c:	a30080e7          	jalr	-1488(ra) # 7398 <unlink>
      unlink(file);
    3970:	fd840793          	addi	a5,s0,-40
    3974:	853e                	mv	a0,a5
    3976:	00004097          	auipc	ra,0x4
    397a:	a22080e7          	jalr	-1502(ra) # 7398 <unlink>
      unlink(file);
    397e:	fd840793          	addi	a5,s0,-40
    3982:	853e                	mv	a0,a5
    3984:	00004097          	auipc	ra,0x4
    3988:	a14080e7          	jalr	-1516(ra) # 7398 <unlink>
    }
    if(pid == 0)
    398c:	fe042783          	lw	a5,-32(s0)
    3990:	2781                	sext.w	a5,a5
    3992:	e791                	bnez	a5,399e <concreate+0x424>
      exit(0);
    3994:	4501                	li	a0,0
    3996:	00004097          	auipc	ra,0x4
    399a:	9b2080e7          	jalr	-1614(ra) # 7348 <exit>
    else
      wait(0);
    399e:	4501                	li	a0,0
    39a0:	00004097          	auipc	ra,0x4
    39a4:	9b0080e7          	jalr	-1616(ra) # 7350 <wait>
  for(i = 0; i < N; i++){
    39a8:	fec42783          	lw	a5,-20(s0)
    39ac:	2785                	addiw	a5,a5,1
    39ae:	fef42623          	sw	a5,-20(s0)
    39b2:	fec42783          	lw	a5,-20(s0)
    39b6:	0007871b          	sext.w	a4,a5
    39ba:	02700793          	li	a5,39
    39be:	e4e7dae3          	bge	a5,a4,3812 <concreate+0x298>
  }
}
    39c2:	0001                	nop
    39c4:	0001                	nop
    39c6:	70e6                	ld	ra,120(sp)
    39c8:	7446                	ld	s0,112(sp)
    39ca:	6109                	addi	sp,sp,128
    39cc:	8082                	ret

00000000000039ce <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink(char *s)
{
    39ce:	7179                	addi	sp,sp,-48
    39d0:	f406                	sd	ra,40(sp)
    39d2:	f022                	sd	s0,32(sp)
    39d4:	1800                	addi	s0,sp,48
    39d6:	fca43c23          	sd	a0,-40(s0)
  int pid, i;

  unlink("x");
    39da:	00004517          	auipc	a0,0x4
    39de:	64e50513          	addi	a0,a0,1614 # 8028 <malloc+0x5b0>
    39e2:	00004097          	auipc	ra,0x4
    39e6:	9b6080e7          	jalr	-1610(ra) # 7398 <unlink>
  pid = fork();
    39ea:	00004097          	auipc	ra,0x4
    39ee:	956080e7          	jalr	-1706(ra) # 7340 <fork>
    39f2:	87aa                	mv	a5,a0
    39f4:	fef42223          	sw	a5,-28(s0)
  if(pid < 0){
    39f8:	fe442783          	lw	a5,-28(s0)
    39fc:	2781                	sext.w	a5,a5
    39fe:	0207d163          	bgez	a5,3a20 <linkunlink+0x52>
    printf("%s: fork failed\n", s);
    3a02:	fd843583          	ld	a1,-40(s0)
    3a06:	00005517          	auipc	a0,0x5
    3a0a:	94a50513          	addi	a0,a0,-1718 # 8350 <malloc+0x8d8>
    3a0e:	00004097          	auipc	ra,0x4
    3a12:	e78080e7          	jalr	-392(ra) # 7886 <printf>
    exit(1);
    3a16:	4505                	li	a0,1
    3a18:	00004097          	auipc	ra,0x4
    3a1c:	930080e7          	jalr	-1744(ra) # 7348 <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    3a20:	fe442783          	lw	a5,-28(s0)
    3a24:	2781                	sext.w	a5,a5
    3a26:	c399                	beqz	a5,3a2c <linkunlink+0x5e>
    3a28:	4785                	li	a5,1
    3a2a:	a019                	j	3a30 <linkunlink+0x62>
    3a2c:	06100793          	li	a5,97
    3a30:	fef42423          	sw	a5,-24(s0)
  for(i = 0; i < 100; i++){
    3a34:	fe042623          	sw	zero,-20(s0)
    3a38:	a869                	j	3ad2 <linkunlink+0x104>
    x = x * 1103515245 + 12345;
    3a3a:	fe842703          	lw	a4,-24(s0)
    3a3e:	41c657b7          	lui	a5,0x41c65
    3a42:	e6d7879b          	addiw	a5,a5,-403
    3a46:	02f707bb          	mulw	a5,a4,a5
    3a4a:	0007871b          	sext.w	a4,a5
    3a4e:	678d                	lui	a5,0x3
    3a50:	0397879b          	addiw	a5,a5,57
    3a54:	9fb9                	addw	a5,a5,a4
    3a56:	fef42423          	sw	a5,-24(s0)
    if((x % 3) == 0){
    3a5a:	fe842703          	lw	a4,-24(s0)
    3a5e:	478d                	li	a5,3
    3a60:	02f777bb          	remuw	a5,a4,a5
    3a64:	2781                	sext.w	a5,a5
    3a66:	e395                	bnez	a5,3a8a <linkunlink+0xbc>
      close(open("x", O_RDWR | O_CREATE));
    3a68:	20200593          	li	a1,514
    3a6c:	00004517          	auipc	a0,0x4
    3a70:	5bc50513          	addi	a0,a0,1468 # 8028 <malloc+0x5b0>
    3a74:	00004097          	auipc	ra,0x4
    3a78:	914080e7          	jalr	-1772(ra) # 7388 <open>
    3a7c:	87aa                	mv	a5,a0
    3a7e:	853e                	mv	a0,a5
    3a80:	00004097          	auipc	ra,0x4
    3a84:	8f0080e7          	jalr	-1808(ra) # 7370 <close>
    3a88:	a081                	j	3ac8 <linkunlink+0xfa>
    } else if((x % 3) == 1){
    3a8a:	fe842703          	lw	a4,-24(s0)
    3a8e:	478d                	li	a5,3
    3a90:	02f777bb          	remuw	a5,a4,a5
    3a94:	2781                	sext.w	a5,a5
    3a96:	873e                	mv	a4,a5
    3a98:	4785                	li	a5,1
    3a9a:	00f71f63          	bne	a4,a5,3ab8 <linkunlink+0xea>
      link("cat", "x");
    3a9e:	00004597          	auipc	a1,0x4
    3aa2:	58a58593          	addi	a1,a1,1418 # 8028 <malloc+0x5b0>
    3aa6:	00005517          	auipc	a0,0x5
    3aaa:	2c250513          	addi	a0,a0,706 # 8d68 <malloc+0x12f0>
    3aae:	00004097          	auipc	ra,0x4
    3ab2:	8fa080e7          	jalr	-1798(ra) # 73a8 <link>
    3ab6:	a809                	j	3ac8 <linkunlink+0xfa>
    } else {
      unlink("x");
    3ab8:	00004517          	auipc	a0,0x4
    3abc:	57050513          	addi	a0,a0,1392 # 8028 <malloc+0x5b0>
    3ac0:	00004097          	auipc	ra,0x4
    3ac4:	8d8080e7          	jalr	-1832(ra) # 7398 <unlink>
  for(i = 0; i < 100; i++){
    3ac8:	fec42783          	lw	a5,-20(s0)
    3acc:	2785                	addiw	a5,a5,1
    3ace:	fef42623          	sw	a5,-20(s0)
    3ad2:	fec42783          	lw	a5,-20(s0)
    3ad6:	0007871b          	sext.w	a4,a5
    3ada:	06300793          	li	a5,99
    3ade:	f4e7dee3          	bge	a5,a4,3a3a <linkunlink+0x6c>
    }
  }

  if(pid)
    3ae2:	fe442783          	lw	a5,-28(s0)
    3ae6:	2781                	sext.w	a5,a5
    3ae8:	c799                	beqz	a5,3af6 <linkunlink+0x128>
    wait(0);
    3aea:	4501                	li	a0,0
    3aec:	00004097          	auipc	ra,0x4
    3af0:	864080e7          	jalr	-1948(ra) # 7350 <wait>
  else
    exit(0);
}
    3af4:	a031                	j	3b00 <linkunlink+0x132>
    exit(0);
    3af6:	4501                	li	a0,0
    3af8:	00004097          	auipc	ra,0x4
    3afc:	850080e7          	jalr	-1968(ra) # 7348 <exit>
}
    3b00:	70a2                	ld	ra,40(sp)
    3b02:	7402                	ld	s0,32(sp)
    3b04:	6145                	addi	sp,sp,48
    3b06:	8082                	ret

0000000000003b08 <bigdir>:

// directory that uses indirect blocks
void
bigdir(char *s)
{
    3b08:	7139                	addi	sp,sp,-64
    3b0a:	fc06                	sd	ra,56(sp)
    3b0c:	f822                	sd	s0,48(sp)
    3b0e:	0080                	addi	s0,sp,64
    3b10:	fca43423          	sd	a0,-56(s0)
  enum { N = 500 };
  int i, fd;
  char name[10];

  unlink("bd");
    3b14:	00005517          	auipc	a0,0x5
    3b18:	25c50513          	addi	a0,a0,604 # 8d70 <malloc+0x12f8>
    3b1c:	00004097          	auipc	ra,0x4
    3b20:	87c080e7          	jalr	-1924(ra) # 7398 <unlink>

  fd = open("bd", O_CREATE);
    3b24:	20000593          	li	a1,512
    3b28:	00005517          	auipc	a0,0x5
    3b2c:	24850513          	addi	a0,a0,584 # 8d70 <malloc+0x12f8>
    3b30:	00004097          	auipc	ra,0x4
    3b34:	858080e7          	jalr	-1960(ra) # 7388 <open>
    3b38:	87aa                	mv	a5,a0
    3b3a:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    3b3e:	fe842783          	lw	a5,-24(s0)
    3b42:	2781                	sext.w	a5,a5
    3b44:	0207d163          	bgez	a5,3b66 <bigdir+0x5e>
    printf("%s: bigdir create failed\n", s);
    3b48:	fc843583          	ld	a1,-56(s0)
    3b4c:	00005517          	auipc	a0,0x5
    3b50:	22c50513          	addi	a0,a0,556 # 8d78 <malloc+0x1300>
    3b54:	00004097          	auipc	ra,0x4
    3b58:	d32080e7          	jalr	-718(ra) # 7886 <printf>
    exit(1);
    3b5c:	4505                	li	a0,1
    3b5e:	00003097          	auipc	ra,0x3
    3b62:	7ea080e7          	jalr	2026(ra) # 7348 <exit>
  }
  close(fd);
    3b66:	fe842783          	lw	a5,-24(s0)
    3b6a:	853e                	mv	a0,a5
    3b6c:	00004097          	auipc	ra,0x4
    3b70:	804080e7          	jalr	-2044(ra) # 7370 <close>

  for(i = 0; i < N; i++){
    3b74:	fe042623          	sw	zero,-20(s0)
    3b78:	a04d                	j	3c1a <bigdir+0x112>
    name[0] = 'x';
    3b7a:	07800793          	li	a5,120
    3b7e:	fcf40c23          	sb	a5,-40(s0)
    name[1] = '0' + (i / 64);
    3b82:	fec42783          	lw	a5,-20(s0)
    3b86:	41f7d71b          	sraiw	a4,a5,0x1f
    3b8a:	01a7571b          	srliw	a4,a4,0x1a
    3b8e:	9fb9                	addw	a5,a5,a4
    3b90:	4067d79b          	sraiw	a5,a5,0x6
    3b94:	2781                	sext.w	a5,a5
    3b96:	0ff7f793          	andi	a5,a5,255
    3b9a:	0307879b          	addiw	a5,a5,48
    3b9e:	0ff7f793          	andi	a5,a5,255
    3ba2:	fcf40ca3          	sb	a5,-39(s0)
    name[2] = '0' + (i % 64);
    3ba6:	fec42703          	lw	a4,-20(s0)
    3baa:	41f7579b          	sraiw	a5,a4,0x1f
    3bae:	01a7d79b          	srliw	a5,a5,0x1a
    3bb2:	9f3d                	addw	a4,a4,a5
    3bb4:	03f77713          	andi	a4,a4,63
    3bb8:	40f707bb          	subw	a5,a4,a5
    3bbc:	2781                	sext.w	a5,a5
    3bbe:	0ff7f793          	andi	a5,a5,255
    3bc2:	0307879b          	addiw	a5,a5,48
    3bc6:	0ff7f793          	andi	a5,a5,255
    3bca:	fcf40d23          	sb	a5,-38(s0)
    name[3] = '\0';
    3bce:	fc040da3          	sb	zero,-37(s0)
    if(link("bd", name) != 0){
    3bd2:	fd840793          	addi	a5,s0,-40
    3bd6:	85be                	mv	a1,a5
    3bd8:	00005517          	auipc	a0,0x5
    3bdc:	19850513          	addi	a0,a0,408 # 8d70 <malloc+0x12f8>
    3be0:	00003097          	auipc	ra,0x3
    3be4:	7c8080e7          	jalr	1992(ra) # 73a8 <link>
    3be8:	87aa                	mv	a5,a0
    3bea:	c39d                	beqz	a5,3c10 <bigdir+0x108>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    3bec:	fd840793          	addi	a5,s0,-40
    3bf0:	863e                	mv	a2,a5
    3bf2:	fc843583          	ld	a1,-56(s0)
    3bf6:	00005517          	auipc	a0,0x5
    3bfa:	1a250513          	addi	a0,a0,418 # 8d98 <malloc+0x1320>
    3bfe:	00004097          	auipc	ra,0x4
    3c02:	c88080e7          	jalr	-888(ra) # 7886 <printf>
      exit(1);
    3c06:	4505                	li	a0,1
    3c08:	00003097          	auipc	ra,0x3
    3c0c:	740080e7          	jalr	1856(ra) # 7348 <exit>
  for(i = 0; i < N; i++){
    3c10:	fec42783          	lw	a5,-20(s0)
    3c14:	2785                	addiw	a5,a5,1
    3c16:	fef42623          	sw	a5,-20(s0)
    3c1a:	fec42783          	lw	a5,-20(s0)
    3c1e:	0007871b          	sext.w	a4,a5
    3c22:	1f300793          	li	a5,499
    3c26:	f4e7dae3          	bge	a5,a4,3b7a <bigdir+0x72>
    }
  }

  unlink("bd");
    3c2a:	00005517          	auipc	a0,0x5
    3c2e:	14650513          	addi	a0,a0,326 # 8d70 <malloc+0x12f8>
    3c32:	00003097          	auipc	ra,0x3
    3c36:	766080e7          	jalr	1894(ra) # 7398 <unlink>
  for(i = 0; i < N; i++){
    3c3a:	fe042623          	sw	zero,-20(s0)
    3c3e:	a851                	j	3cd2 <bigdir+0x1ca>
    name[0] = 'x';
    3c40:	07800793          	li	a5,120
    3c44:	fcf40c23          	sb	a5,-40(s0)
    name[1] = '0' + (i / 64);
    3c48:	fec42783          	lw	a5,-20(s0)
    3c4c:	41f7d71b          	sraiw	a4,a5,0x1f
    3c50:	01a7571b          	srliw	a4,a4,0x1a
    3c54:	9fb9                	addw	a5,a5,a4
    3c56:	4067d79b          	sraiw	a5,a5,0x6
    3c5a:	2781                	sext.w	a5,a5
    3c5c:	0ff7f793          	andi	a5,a5,255
    3c60:	0307879b          	addiw	a5,a5,48
    3c64:	0ff7f793          	andi	a5,a5,255
    3c68:	fcf40ca3          	sb	a5,-39(s0)
    name[2] = '0' + (i % 64);
    3c6c:	fec42703          	lw	a4,-20(s0)
    3c70:	41f7579b          	sraiw	a5,a4,0x1f
    3c74:	01a7d79b          	srliw	a5,a5,0x1a
    3c78:	9f3d                	addw	a4,a4,a5
    3c7a:	03f77713          	andi	a4,a4,63
    3c7e:	40f707bb          	subw	a5,a4,a5
    3c82:	2781                	sext.w	a5,a5
    3c84:	0ff7f793          	andi	a5,a5,255
    3c88:	0307879b          	addiw	a5,a5,48
    3c8c:	0ff7f793          	andi	a5,a5,255
    3c90:	fcf40d23          	sb	a5,-38(s0)
    name[3] = '\0';
    3c94:	fc040da3          	sb	zero,-37(s0)
    if(unlink(name) != 0){
    3c98:	fd840793          	addi	a5,s0,-40
    3c9c:	853e                	mv	a0,a5
    3c9e:	00003097          	auipc	ra,0x3
    3ca2:	6fa080e7          	jalr	1786(ra) # 7398 <unlink>
    3ca6:	87aa                	mv	a5,a0
    3ca8:	c385                	beqz	a5,3cc8 <bigdir+0x1c0>
      printf("%s: bigdir unlink failed", s);
    3caa:	fc843583          	ld	a1,-56(s0)
    3cae:	00005517          	auipc	a0,0x5
    3cb2:	10a50513          	addi	a0,a0,266 # 8db8 <malloc+0x1340>
    3cb6:	00004097          	auipc	ra,0x4
    3cba:	bd0080e7          	jalr	-1072(ra) # 7886 <printf>
      exit(1);
    3cbe:	4505                	li	a0,1
    3cc0:	00003097          	auipc	ra,0x3
    3cc4:	688080e7          	jalr	1672(ra) # 7348 <exit>
  for(i = 0; i < N; i++){
    3cc8:	fec42783          	lw	a5,-20(s0)
    3ccc:	2785                	addiw	a5,a5,1
    3cce:	fef42623          	sw	a5,-20(s0)
    3cd2:	fec42783          	lw	a5,-20(s0)
    3cd6:	0007871b          	sext.w	a4,a5
    3cda:	1f300793          	li	a5,499
    3cde:	f6e7d1e3          	bge	a5,a4,3c40 <bigdir+0x138>
    }
  }
}
    3ce2:	0001                	nop
    3ce4:	0001                	nop
    3ce6:	70e2                	ld	ra,56(sp)
    3ce8:	7442                	ld	s0,48(sp)
    3cea:	6121                	addi	sp,sp,64
    3cec:	8082                	ret

0000000000003cee <subdir>:

void
subdir(char *s)
{
    3cee:	7179                	addi	sp,sp,-48
    3cf0:	f406                	sd	ra,40(sp)
    3cf2:	f022                	sd	s0,32(sp)
    3cf4:	1800                	addi	s0,sp,48
    3cf6:	fca43c23          	sd	a0,-40(s0)
  int fd, cc;

  unlink("ff");
    3cfa:	00005517          	auipc	a0,0x5
    3cfe:	0de50513          	addi	a0,a0,222 # 8dd8 <malloc+0x1360>
    3d02:	00003097          	auipc	ra,0x3
    3d06:	696080e7          	jalr	1686(ra) # 7398 <unlink>
  if(mkdir("dd") != 0){
    3d0a:	00005517          	auipc	a0,0x5
    3d0e:	0d650513          	addi	a0,a0,214 # 8de0 <malloc+0x1368>
    3d12:	00003097          	auipc	ra,0x3
    3d16:	69e080e7          	jalr	1694(ra) # 73b0 <mkdir>
    3d1a:	87aa                	mv	a5,a0
    3d1c:	c385                	beqz	a5,3d3c <subdir+0x4e>
    printf("%s: mkdir dd failed\n", s);
    3d1e:	fd843583          	ld	a1,-40(s0)
    3d22:	00005517          	auipc	a0,0x5
    3d26:	0c650513          	addi	a0,a0,198 # 8de8 <malloc+0x1370>
    3d2a:	00004097          	auipc	ra,0x4
    3d2e:	b5c080e7          	jalr	-1188(ra) # 7886 <printf>
    exit(1);
    3d32:	4505                	li	a0,1
    3d34:	00003097          	auipc	ra,0x3
    3d38:	614080e7          	jalr	1556(ra) # 7348 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    3d3c:	20200593          	li	a1,514
    3d40:	00005517          	auipc	a0,0x5
    3d44:	0c050513          	addi	a0,a0,192 # 8e00 <malloc+0x1388>
    3d48:	00003097          	auipc	ra,0x3
    3d4c:	640080e7          	jalr	1600(ra) # 7388 <open>
    3d50:	87aa                	mv	a5,a0
    3d52:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3d56:	fec42783          	lw	a5,-20(s0)
    3d5a:	2781                	sext.w	a5,a5
    3d5c:	0207d163          	bgez	a5,3d7e <subdir+0x90>
    printf("%s: create dd/ff failed\n", s);
    3d60:	fd843583          	ld	a1,-40(s0)
    3d64:	00005517          	auipc	a0,0x5
    3d68:	0a450513          	addi	a0,a0,164 # 8e08 <malloc+0x1390>
    3d6c:	00004097          	auipc	ra,0x4
    3d70:	b1a080e7          	jalr	-1254(ra) # 7886 <printf>
    exit(1);
    3d74:	4505                	li	a0,1
    3d76:	00003097          	auipc	ra,0x3
    3d7a:	5d2080e7          	jalr	1490(ra) # 7348 <exit>
  }
  write(fd, "ff", 2);
    3d7e:	fec42783          	lw	a5,-20(s0)
    3d82:	4609                	li	a2,2
    3d84:	00005597          	auipc	a1,0x5
    3d88:	05458593          	addi	a1,a1,84 # 8dd8 <malloc+0x1360>
    3d8c:	853e                	mv	a0,a5
    3d8e:	00003097          	auipc	ra,0x3
    3d92:	5da080e7          	jalr	1498(ra) # 7368 <write>
  close(fd);
    3d96:	fec42783          	lw	a5,-20(s0)
    3d9a:	853e                	mv	a0,a5
    3d9c:	00003097          	auipc	ra,0x3
    3da0:	5d4080e7          	jalr	1492(ra) # 7370 <close>

  if(unlink("dd") >= 0){
    3da4:	00005517          	auipc	a0,0x5
    3da8:	03c50513          	addi	a0,a0,60 # 8de0 <malloc+0x1368>
    3dac:	00003097          	auipc	ra,0x3
    3db0:	5ec080e7          	jalr	1516(ra) # 7398 <unlink>
    3db4:	87aa                	mv	a5,a0
    3db6:	0207c163          	bltz	a5,3dd8 <subdir+0xea>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3dba:	fd843583          	ld	a1,-40(s0)
    3dbe:	00005517          	auipc	a0,0x5
    3dc2:	06a50513          	addi	a0,a0,106 # 8e28 <malloc+0x13b0>
    3dc6:	00004097          	auipc	ra,0x4
    3dca:	ac0080e7          	jalr	-1344(ra) # 7886 <printf>
    exit(1);
    3dce:	4505                	li	a0,1
    3dd0:	00003097          	auipc	ra,0x3
    3dd4:	578080e7          	jalr	1400(ra) # 7348 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    3dd8:	00005517          	auipc	a0,0x5
    3ddc:	08050513          	addi	a0,a0,128 # 8e58 <malloc+0x13e0>
    3de0:	00003097          	auipc	ra,0x3
    3de4:	5d0080e7          	jalr	1488(ra) # 73b0 <mkdir>
    3de8:	87aa                	mv	a5,a0
    3dea:	c385                	beqz	a5,3e0a <subdir+0x11c>
    printf("subdir mkdir dd/dd failed\n", s);
    3dec:	fd843583          	ld	a1,-40(s0)
    3df0:	00005517          	auipc	a0,0x5
    3df4:	07050513          	addi	a0,a0,112 # 8e60 <malloc+0x13e8>
    3df8:	00004097          	auipc	ra,0x4
    3dfc:	a8e080e7          	jalr	-1394(ra) # 7886 <printf>
    exit(1);
    3e00:	4505                	li	a0,1
    3e02:	00003097          	auipc	ra,0x3
    3e06:	546080e7          	jalr	1350(ra) # 7348 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3e0a:	20200593          	li	a1,514
    3e0e:	00005517          	auipc	a0,0x5
    3e12:	07250513          	addi	a0,a0,114 # 8e80 <malloc+0x1408>
    3e16:	00003097          	auipc	ra,0x3
    3e1a:	572080e7          	jalr	1394(ra) # 7388 <open>
    3e1e:	87aa                	mv	a5,a0
    3e20:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3e24:	fec42783          	lw	a5,-20(s0)
    3e28:	2781                	sext.w	a5,a5
    3e2a:	0207d163          	bgez	a5,3e4c <subdir+0x15e>
    printf("%s: create dd/dd/ff failed\n", s);
    3e2e:	fd843583          	ld	a1,-40(s0)
    3e32:	00005517          	auipc	a0,0x5
    3e36:	05e50513          	addi	a0,a0,94 # 8e90 <malloc+0x1418>
    3e3a:	00004097          	auipc	ra,0x4
    3e3e:	a4c080e7          	jalr	-1460(ra) # 7886 <printf>
    exit(1);
    3e42:	4505                	li	a0,1
    3e44:	00003097          	auipc	ra,0x3
    3e48:	504080e7          	jalr	1284(ra) # 7348 <exit>
  }
  write(fd, "FF", 2);
    3e4c:	fec42783          	lw	a5,-20(s0)
    3e50:	4609                	li	a2,2
    3e52:	00005597          	auipc	a1,0x5
    3e56:	05e58593          	addi	a1,a1,94 # 8eb0 <malloc+0x1438>
    3e5a:	853e                	mv	a0,a5
    3e5c:	00003097          	auipc	ra,0x3
    3e60:	50c080e7          	jalr	1292(ra) # 7368 <write>
  close(fd);
    3e64:	fec42783          	lw	a5,-20(s0)
    3e68:	853e                	mv	a0,a5
    3e6a:	00003097          	auipc	ra,0x3
    3e6e:	506080e7          	jalr	1286(ra) # 7370 <close>

  fd = open("dd/dd/../ff", 0);
    3e72:	4581                	li	a1,0
    3e74:	00005517          	auipc	a0,0x5
    3e78:	04450513          	addi	a0,a0,68 # 8eb8 <malloc+0x1440>
    3e7c:	00003097          	auipc	ra,0x3
    3e80:	50c080e7          	jalr	1292(ra) # 7388 <open>
    3e84:	87aa                	mv	a5,a0
    3e86:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3e8a:	fec42783          	lw	a5,-20(s0)
    3e8e:	2781                	sext.w	a5,a5
    3e90:	0207d163          	bgez	a5,3eb2 <subdir+0x1c4>
    printf("%s: open dd/dd/../ff failed\n", s);
    3e94:	fd843583          	ld	a1,-40(s0)
    3e98:	00005517          	auipc	a0,0x5
    3e9c:	03050513          	addi	a0,a0,48 # 8ec8 <malloc+0x1450>
    3ea0:	00004097          	auipc	ra,0x4
    3ea4:	9e6080e7          	jalr	-1562(ra) # 7886 <printf>
    exit(1);
    3ea8:	4505                	li	a0,1
    3eaa:	00003097          	auipc	ra,0x3
    3eae:	49e080e7          	jalr	1182(ra) # 7348 <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    3eb2:	fec42783          	lw	a5,-20(s0)
    3eb6:	660d                	lui	a2,0x3
    3eb8:	00006597          	auipc	a1,0x6
    3ebc:	55858593          	addi	a1,a1,1368 # a410 <buf>
    3ec0:	853e                	mv	a0,a5
    3ec2:	00003097          	auipc	ra,0x3
    3ec6:	49e080e7          	jalr	1182(ra) # 7360 <read>
    3eca:	87aa                	mv	a5,a0
    3ecc:	fef42423          	sw	a5,-24(s0)
  if(cc != 2 || buf[0] != 'f'){
    3ed0:	fe842783          	lw	a5,-24(s0)
    3ed4:	0007871b          	sext.w	a4,a5
    3ed8:	4789                	li	a5,2
    3eda:	00f71d63          	bne	a4,a5,3ef4 <subdir+0x206>
    3ede:	00006797          	auipc	a5,0x6
    3ee2:	53278793          	addi	a5,a5,1330 # a410 <buf>
    3ee6:	0007c783          	lbu	a5,0(a5)
    3eea:	873e                	mv	a4,a5
    3eec:	06600793          	li	a5,102
    3ef0:	02f70163          	beq	a4,a5,3f12 <subdir+0x224>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3ef4:	fd843583          	ld	a1,-40(s0)
    3ef8:	00005517          	auipc	a0,0x5
    3efc:	ff050513          	addi	a0,a0,-16 # 8ee8 <malloc+0x1470>
    3f00:	00004097          	auipc	ra,0x4
    3f04:	986080e7          	jalr	-1658(ra) # 7886 <printf>
    exit(1);
    3f08:	4505                	li	a0,1
    3f0a:	00003097          	auipc	ra,0x3
    3f0e:	43e080e7          	jalr	1086(ra) # 7348 <exit>
  }
  close(fd);
    3f12:	fec42783          	lw	a5,-20(s0)
    3f16:	853e                	mv	a0,a5
    3f18:	00003097          	auipc	ra,0x3
    3f1c:	458080e7          	jalr	1112(ra) # 7370 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    3f20:	00005597          	auipc	a1,0x5
    3f24:	fe858593          	addi	a1,a1,-24 # 8f08 <malloc+0x1490>
    3f28:	00005517          	auipc	a0,0x5
    3f2c:	f5850513          	addi	a0,a0,-168 # 8e80 <malloc+0x1408>
    3f30:	00003097          	auipc	ra,0x3
    3f34:	478080e7          	jalr	1144(ra) # 73a8 <link>
    3f38:	87aa                	mv	a5,a0
    3f3a:	c385                	beqz	a5,3f5a <subdir+0x26c>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3f3c:	fd843583          	ld	a1,-40(s0)
    3f40:	00005517          	auipc	a0,0x5
    3f44:	fd850513          	addi	a0,a0,-40 # 8f18 <malloc+0x14a0>
    3f48:	00004097          	auipc	ra,0x4
    3f4c:	93e080e7          	jalr	-1730(ra) # 7886 <printf>
    exit(1);
    3f50:	4505                	li	a0,1
    3f52:	00003097          	auipc	ra,0x3
    3f56:	3f6080e7          	jalr	1014(ra) # 7348 <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    3f5a:	00005517          	auipc	a0,0x5
    3f5e:	f2650513          	addi	a0,a0,-218 # 8e80 <malloc+0x1408>
    3f62:	00003097          	auipc	ra,0x3
    3f66:	436080e7          	jalr	1078(ra) # 7398 <unlink>
    3f6a:	87aa                	mv	a5,a0
    3f6c:	c385                	beqz	a5,3f8c <subdir+0x29e>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3f6e:	fd843583          	ld	a1,-40(s0)
    3f72:	00005517          	auipc	a0,0x5
    3f76:	fce50513          	addi	a0,a0,-50 # 8f40 <malloc+0x14c8>
    3f7a:	00004097          	auipc	ra,0x4
    3f7e:	90c080e7          	jalr	-1780(ra) # 7886 <printf>
    exit(1);
    3f82:	4505                	li	a0,1
    3f84:	00003097          	auipc	ra,0x3
    3f88:	3c4080e7          	jalr	964(ra) # 7348 <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3f8c:	4581                	li	a1,0
    3f8e:	00005517          	auipc	a0,0x5
    3f92:	ef250513          	addi	a0,a0,-270 # 8e80 <malloc+0x1408>
    3f96:	00003097          	auipc	ra,0x3
    3f9a:	3f2080e7          	jalr	1010(ra) # 7388 <open>
    3f9e:	87aa                	mv	a5,a0
    3fa0:	0207c163          	bltz	a5,3fc2 <subdir+0x2d4>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3fa4:	fd843583          	ld	a1,-40(s0)
    3fa8:	00005517          	auipc	a0,0x5
    3fac:	fb850513          	addi	a0,a0,-72 # 8f60 <malloc+0x14e8>
    3fb0:	00004097          	auipc	ra,0x4
    3fb4:	8d6080e7          	jalr	-1834(ra) # 7886 <printf>
    exit(1);
    3fb8:	4505                	li	a0,1
    3fba:	00003097          	auipc	ra,0x3
    3fbe:	38e080e7          	jalr	910(ra) # 7348 <exit>
  }

  if(chdir("dd") != 0){
    3fc2:	00005517          	auipc	a0,0x5
    3fc6:	e1e50513          	addi	a0,a0,-482 # 8de0 <malloc+0x1368>
    3fca:	00003097          	auipc	ra,0x3
    3fce:	3ee080e7          	jalr	1006(ra) # 73b8 <chdir>
    3fd2:	87aa                	mv	a5,a0
    3fd4:	c385                	beqz	a5,3ff4 <subdir+0x306>
    printf("%s: chdir dd failed\n", s);
    3fd6:	fd843583          	ld	a1,-40(s0)
    3fda:	00005517          	auipc	a0,0x5
    3fde:	fae50513          	addi	a0,a0,-82 # 8f88 <malloc+0x1510>
    3fe2:	00004097          	auipc	ra,0x4
    3fe6:	8a4080e7          	jalr	-1884(ra) # 7886 <printf>
    exit(1);
    3fea:	4505                	li	a0,1
    3fec:	00003097          	auipc	ra,0x3
    3ff0:	35c080e7          	jalr	860(ra) # 7348 <exit>
  }
  if(chdir("dd/../../dd") != 0){
    3ff4:	00005517          	auipc	a0,0x5
    3ff8:	fac50513          	addi	a0,a0,-84 # 8fa0 <malloc+0x1528>
    3ffc:	00003097          	auipc	ra,0x3
    4000:	3bc080e7          	jalr	956(ra) # 73b8 <chdir>
    4004:	87aa                	mv	a5,a0
    4006:	c385                	beqz	a5,4026 <subdir+0x338>
    printf("%s: chdir dd/../../dd failed\n", s);
    4008:	fd843583          	ld	a1,-40(s0)
    400c:	00005517          	auipc	a0,0x5
    4010:	fa450513          	addi	a0,a0,-92 # 8fb0 <malloc+0x1538>
    4014:	00004097          	auipc	ra,0x4
    4018:	872080e7          	jalr	-1934(ra) # 7886 <printf>
    exit(1);
    401c:	4505                	li	a0,1
    401e:	00003097          	auipc	ra,0x3
    4022:	32a080e7          	jalr	810(ra) # 7348 <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    4026:	00005517          	auipc	a0,0x5
    402a:	faa50513          	addi	a0,a0,-86 # 8fd0 <malloc+0x1558>
    402e:	00003097          	auipc	ra,0x3
    4032:	38a080e7          	jalr	906(ra) # 73b8 <chdir>
    4036:	87aa                	mv	a5,a0
    4038:	c385                	beqz	a5,4058 <subdir+0x36a>
    printf("chdir dd/../../dd failed\n", s);
    403a:	fd843583          	ld	a1,-40(s0)
    403e:	00005517          	auipc	a0,0x5
    4042:	fa250513          	addi	a0,a0,-94 # 8fe0 <malloc+0x1568>
    4046:	00004097          	auipc	ra,0x4
    404a:	840080e7          	jalr	-1984(ra) # 7886 <printf>
    exit(1);
    404e:	4505                	li	a0,1
    4050:	00003097          	auipc	ra,0x3
    4054:	2f8080e7          	jalr	760(ra) # 7348 <exit>
  }
  if(chdir("./..") != 0){
    4058:	00005517          	auipc	a0,0x5
    405c:	fa850513          	addi	a0,a0,-88 # 9000 <malloc+0x1588>
    4060:	00003097          	auipc	ra,0x3
    4064:	358080e7          	jalr	856(ra) # 73b8 <chdir>
    4068:	87aa                	mv	a5,a0
    406a:	c385                	beqz	a5,408a <subdir+0x39c>
    printf("%s: chdir ./.. failed\n", s);
    406c:	fd843583          	ld	a1,-40(s0)
    4070:	00005517          	auipc	a0,0x5
    4074:	f9850513          	addi	a0,a0,-104 # 9008 <malloc+0x1590>
    4078:	00004097          	auipc	ra,0x4
    407c:	80e080e7          	jalr	-2034(ra) # 7886 <printf>
    exit(1);
    4080:	4505                	li	a0,1
    4082:	00003097          	auipc	ra,0x3
    4086:	2c6080e7          	jalr	710(ra) # 7348 <exit>
  }

  fd = open("dd/dd/ffff", 0);
    408a:	4581                	li	a1,0
    408c:	00005517          	auipc	a0,0x5
    4090:	e7c50513          	addi	a0,a0,-388 # 8f08 <malloc+0x1490>
    4094:	00003097          	auipc	ra,0x3
    4098:	2f4080e7          	jalr	756(ra) # 7388 <open>
    409c:	87aa                	mv	a5,a0
    409e:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    40a2:	fec42783          	lw	a5,-20(s0)
    40a6:	2781                	sext.w	a5,a5
    40a8:	0207d163          	bgez	a5,40ca <subdir+0x3dc>
    printf("%s: open dd/dd/ffff failed\n", s);
    40ac:	fd843583          	ld	a1,-40(s0)
    40b0:	00005517          	auipc	a0,0x5
    40b4:	f7050513          	addi	a0,a0,-144 # 9020 <malloc+0x15a8>
    40b8:	00003097          	auipc	ra,0x3
    40bc:	7ce080e7          	jalr	1998(ra) # 7886 <printf>
    exit(1);
    40c0:	4505                	li	a0,1
    40c2:	00003097          	auipc	ra,0x3
    40c6:	286080e7          	jalr	646(ra) # 7348 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    40ca:	fec42783          	lw	a5,-20(s0)
    40ce:	660d                	lui	a2,0x3
    40d0:	00006597          	auipc	a1,0x6
    40d4:	34058593          	addi	a1,a1,832 # a410 <buf>
    40d8:	853e                	mv	a0,a5
    40da:	00003097          	auipc	ra,0x3
    40de:	286080e7          	jalr	646(ra) # 7360 <read>
    40e2:	87aa                	mv	a5,a0
    40e4:	873e                	mv	a4,a5
    40e6:	4789                	li	a5,2
    40e8:	02f70163          	beq	a4,a5,410a <subdir+0x41c>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    40ec:	fd843583          	ld	a1,-40(s0)
    40f0:	00005517          	auipc	a0,0x5
    40f4:	f5050513          	addi	a0,a0,-176 # 9040 <malloc+0x15c8>
    40f8:	00003097          	auipc	ra,0x3
    40fc:	78e080e7          	jalr	1934(ra) # 7886 <printf>
    exit(1);
    4100:	4505                	li	a0,1
    4102:	00003097          	auipc	ra,0x3
    4106:	246080e7          	jalr	582(ra) # 7348 <exit>
  }
  close(fd);
    410a:	fec42783          	lw	a5,-20(s0)
    410e:	853e                	mv	a0,a5
    4110:	00003097          	auipc	ra,0x3
    4114:	260080e7          	jalr	608(ra) # 7370 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    4118:	4581                	li	a1,0
    411a:	00005517          	auipc	a0,0x5
    411e:	d6650513          	addi	a0,a0,-666 # 8e80 <malloc+0x1408>
    4122:	00003097          	auipc	ra,0x3
    4126:	266080e7          	jalr	614(ra) # 7388 <open>
    412a:	87aa                	mv	a5,a0
    412c:	0207c163          	bltz	a5,414e <subdir+0x460>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    4130:	fd843583          	ld	a1,-40(s0)
    4134:	00005517          	auipc	a0,0x5
    4138:	f2c50513          	addi	a0,a0,-212 # 9060 <malloc+0x15e8>
    413c:	00003097          	auipc	ra,0x3
    4140:	74a080e7          	jalr	1866(ra) # 7886 <printf>
    exit(1);
    4144:	4505                	li	a0,1
    4146:	00003097          	auipc	ra,0x3
    414a:	202080e7          	jalr	514(ra) # 7348 <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    414e:	20200593          	li	a1,514
    4152:	00005517          	auipc	a0,0x5
    4156:	f3e50513          	addi	a0,a0,-194 # 9090 <malloc+0x1618>
    415a:	00003097          	auipc	ra,0x3
    415e:	22e080e7          	jalr	558(ra) # 7388 <open>
    4162:	87aa                	mv	a5,a0
    4164:	0207c163          	bltz	a5,4186 <subdir+0x498>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    4168:	fd843583          	ld	a1,-40(s0)
    416c:	00005517          	auipc	a0,0x5
    4170:	f3450513          	addi	a0,a0,-204 # 90a0 <malloc+0x1628>
    4174:	00003097          	auipc	ra,0x3
    4178:	712080e7          	jalr	1810(ra) # 7886 <printf>
    exit(1);
    417c:	4505                	li	a0,1
    417e:	00003097          	auipc	ra,0x3
    4182:	1ca080e7          	jalr	458(ra) # 7348 <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    4186:	20200593          	li	a1,514
    418a:	00005517          	auipc	a0,0x5
    418e:	f3650513          	addi	a0,a0,-202 # 90c0 <malloc+0x1648>
    4192:	00003097          	auipc	ra,0x3
    4196:	1f6080e7          	jalr	502(ra) # 7388 <open>
    419a:	87aa                	mv	a5,a0
    419c:	0207c163          	bltz	a5,41be <subdir+0x4d0>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    41a0:	fd843583          	ld	a1,-40(s0)
    41a4:	00005517          	auipc	a0,0x5
    41a8:	f2c50513          	addi	a0,a0,-212 # 90d0 <malloc+0x1658>
    41ac:	00003097          	auipc	ra,0x3
    41b0:	6da080e7          	jalr	1754(ra) # 7886 <printf>
    exit(1);
    41b4:	4505                	li	a0,1
    41b6:	00003097          	auipc	ra,0x3
    41ba:	192080e7          	jalr	402(ra) # 7348 <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    41be:	20000593          	li	a1,512
    41c2:	00005517          	auipc	a0,0x5
    41c6:	c1e50513          	addi	a0,a0,-994 # 8de0 <malloc+0x1368>
    41ca:	00003097          	auipc	ra,0x3
    41ce:	1be080e7          	jalr	446(ra) # 7388 <open>
    41d2:	87aa                	mv	a5,a0
    41d4:	0207c163          	bltz	a5,41f6 <subdir+0x508>
    printf("%s: create dd succeeded!\n", s);
    41d8:	fd843583          	ld	a1,-40(s0)
    41dc:	00005517          	auipc	a0,0x5
    41e0:	f1450513          	addi	a0,a0,-236 # 90f0 <malloc+0x1678>
    41e4:	00003097          	auipc	ra,0x3
    41e8:	6a2080e7          	jalr	1698(ra) # 7886 <printf>
    exit(1);
    41ec:	4505                	li	a0,1
    41ee:	00003097          	auipc	ra,0x3
    41f2:	15a080e7          	jalr	346(ra) # 7348 <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    41f6:	4589                	li	a1,2
    41f8:	00005517          	auipc	a0,0x5
    41fc:	be850513          	addi	a0,a0,-1048 # 8de0 <malloc+0x1368>
    4200:	00003097          	auipc	ra,0x3
    4204:	188080e7          	jalr	392(ra) # 7388 <open>
    4208:	87aa                	mv	a5,a0
    420a:	0207c163          	bltz	a5,422c <subdir+0x53e>
    printf("%s: open dd rdwr succeeded!\n", s);
    420e:	fd843583          	ld	a1,-40(s0)
    4212:	00005517          	auipc	a0,0x5
    4216:	efe50513          	addi	a0,a0,-258 # 9110 <malloc+0x1698>
    421a:	00003097          	auipc	ra,0x3
    421e:	66c080e7          	jalr	1644(ra) # 7886 <printf>
    exit(1);
    4222:	4505                	li	a0,1
    4224:	00003097          	auipc	ra,0x3
    4228:	124080e7          	jalr	292(ra) # 7348 <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    422c:	4585                	li	a1,1
    422e:	00005517          	auipc	a0,0x5
    4232:	bb250513          	addi	a0,a0,-1102 # 8de0 <malloc+0x1368>
    4236:	00003097          	auipc	ra,0x3
    423a:	152080e7          	jalr	338(ra) # 7388 <open>
    423e:	87aa                	mv	a5,a0
    4240:	0207c163          	bltz	a5,4262 <subdir+0x574>
    printf("%s: open dd wronly succeeded!\n", s);
    4244:	fd843583          	ld	a1,-40(s0)
    4248:	00005517          	auipc	a0,0x5
    424c:	ee850513          	addi	a0,a0,-280 # 9130 <malloc+0x16b8>
    4250:	00003097          	auipc	ra,0x3
    4254:	636080e7          	jalr	1590(ra) # 7886 <printf>
    exit(1);
    4258:	4505                	li	a0,1
    425a:	00003097          	auipc	ra,0x3
    425e:	0ee080e7          	jalr	238(ra) # 7348 <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    4262:	00005597          	auipc	a1,0x5
    4266:	eee58593          	addi	a1,a1,-274 # 9150 <malloc+0x16d8>
    426a:	00005517          	auipc	a0,0x5
    426e:	e2650513          	addi	a0,a0,-474 # 9090 <malloc+0x1618>
    4272:	00003097          	auipc	ra,0x3
    4276:	136080e7          	jalr	310(ra) # 73a8 <link>
    427a:	87aa                	mv	a5,a0
    427c:	e385                	bnez	a5,429c <subdir+0x5ae>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    427e:	fd843583          	ld	a1,-40(s0)
    4282:	00005517          	auipc	a0,0x5
    4286:	ede50513          	addi	a0,a0,-290 # 9160 <malloc+0x16e8>
    428a:	00003097          	auipc	ra,0x3
    428e:	5fc080e7          	jalr	1532(ra) # 7886 <printf>
    exit(1);
    4292:	4505                	li	a0,1
    4294:	00003097          	auipc	ra,0x3
    4298:	0b4080e7          	jalr	180(ra) # 7348 <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    429c:	00005597          	auipc	a1,0x5
    42a0:	eb458593          	addi	a1,a1,-332 # 9150 <malloc+0x16d8>
    42a4:	00005517          	auipc	a0,0x5
    42a8:	e1c50513          	addi	a0,a0,-484 # 90c0 <malloc+0x1648>
    42ac:	00003097          	auipc	ra,0x3
    42b0:	0fc080e7          	jalr	252(ra) # 73a8 <link>
    42b4:	87aa                	mv	a5,a0
    42b6:	e385                	bnez	a5,42d6 <subdir+0x5e8>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    42b8:	fd843583          	ld	a1,-40(s0)
    42bc:	00005517          	auipc	a0,0x5
    42c0:	ecc50513          	addi	a0,a0,-308 # 9188 <malloc+0x1710>
    42c4:	00003097          	auipc	ra,0x3
    42c8:	5c2080e7          	jalr	1474(ra) # 7886 <printf>
    exit(1);
    42cc:	4505                	li	a0,1
    42ce:	00003097          	auipc	ra,0x3
    42d2:	07a080e7          	jalr	122(ra) # 7348 <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    42d6:	00005597          	auipc	a1,0x5
    42da:	c3258593          	addi	a1,a1,-974 # 8f08 <malloc+0x1490>
    42de:	00005517          	auipc	a0,0x5
    42e2:	b2250513          	addi	a0,a0,-1246 # 8e00 <malloc+0x1388>
    42e6:	00003097          	auipc	ra,0x3
    42ea:	0c2080e7          	jalr	194(ra) # 73a8 <link>
    42ee:	87aa                	mv	a5,a0
    42f0:	e385                	bnez	a5,4310 <subdir+0x622>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    42f2:	fd843583          	ld	a1,-40(s0)
    42f6:	00005517          	auipc	a0,0x5
    42fa:	eba50513          	addi	a0,a0,-326 # 91b0 <malloc+0x1738>
    42fe:	00003097          	auipc	ra,0x3
    4302:	588080e7          	jalr	1416(ra) # 7886 <printf>
    exit(1);
    4306:	4505                	li	a0,1
    4308:	00003097          	auipc	ra,0x3
    430c:	040080e7          	jalr	64(ra) # 7348 <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    4310:	00005517          	auipc	a0,0x5
    4314:	d8050513          	addi	a0,a0,-640 # 9090 <malloc+0x1618>
    4318:	00003097          	auipc	ra,0x3
    431c:	098080e7          	jalr	152(ra) # 73b0 <mkdir>
    4320:	87aa                	mv	a5,a0
    4322:	e385                	bnez	a5,4342 <subdir+0x654>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    4324:	fd843583          	ld	a1,-40(s0)
    4328:	00005517          	auipc	a0,0x5
    432c:	eb050513          	addi	a0,a0,-336 # 91d8 <malloc+0x1760>
    4330:	00003097          	auipc	ra,0x3
    4334:	556080e7          	jalr	1366(ra) # 7886 <printf>
    exit(1);
    4338:	4505                	li	a0,1
    433a:	00003097          	auipc	ra,0x3
    433e:	00e080e7          	jalr	14(ra) # 7348 <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    4342:	00005517          	auipc	a0,0x5
    4346:	d7e50513          	addi	a0,a0,-642 # 90c0 <malloc+0x1648>
    434a:	00003097          	auipc	ra,0x3
    434e:	066080e7          	jalr	102(ra) # 73b0 <mkdir>
    4352:	87aa                	mv	a5,a0
    4354:	e385                	bnez	a5,4374 <subdir+0x686>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    4356:	fd843583          	ld	a1,-40(s0)
    435a:	00005517          	auipc	a0,0x5
    435e:	e9e50513          	addi	a0,a0,-354 # 91f8 <malloc+0x1780>
    4362:	00003097          	auipc	ra,0x3
    4366:	524080e7          	jalr	1316(ra) # 7886 <printf>
    exit(1);
    436a:	4505                	li	a0,1
    436c:	00003097          	auipc	ra,0x3
    4370:	fdc080e7          	jalr	-36(ra) # 7348 <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    4374:	00005517          	auipc	a0,0x5
    4378:	b9450513          	addi	a0,a0,-1132 # 8f08 <malloc+0x1490>
    437c:	00003097          	auipc	ra,0x3
    4380:	034080e7          	jalr	52(ra) # 73b0 <mkdir>
    4384:	87aa                	mv	a5,a0
    4386:	e385                	bnez	a5,43a6 <subdir+0x6b8>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    4388:	fd843583          	ld	a1,-40(s0)
    438c:	00005517          	auipc	a0,0x5
    4390:	e8c50513          	addi	a0,a0,-372 # 9218 <malloc+0x17a0>
    4394:	00003097          	auipc	ra,0x3
    4398:	4f2080e7          	jalr	1266(ra) # 7886 <printf>
    exit(1);
    439c:	4505                	li	a0,1
    439e:	00003097          	auipc	ra,0x3
    43a2:	faa080e7          	jalr	-86(ra) # 7348 <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    43a6:	00005517          	auipc	a0,0x5
    43aa:	d1a50513          	addi	a0,a0,-742 # 90c0 <malloc+0x1648>
    43ae:	00003097          	auipc	ra,0x3
    43b2:	fea080e7          	jalr	-22(ra) # 7398 <unlink>
    43b6:	87aa                	mv	a5,a0
    43b8:	e385                	bnez	a5,43d8 <subdir+0x6ea>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    43ba:	fd843583          	ld	a1,-40(s0)
    43be:	00005517          	auipc	a0,0x5
    43c2:	e8250513          	addi	a0,a0,-382 # 9240 <malloc+0x17c8>
    43c6:	00003097          	auipc	ra,0x3
    43ca:	4c0080e7          	jalr	1216(ra) # 7886 <printf>
    exit(1);
    43ce:	4505                	li	a0,1
    43d0:	00003097          	auipc	ra,0x3
    43d4:	f78080e7          	jalr	-136(ra) # 7348 <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    43d8:	00005517          	auipc	a0,0x5
    43dc:	cb850513          	addi	a0,a0,-840 # 9090 <malloc+0x1618>
    43e0:	00003097          	auipc	ra,0x3
    43e4:	fb8080e7          	jalr	-72(ra) # 7398 <unlink>
    43e8:	87aa                	mv	a5,a0
    43ea:	e385                	bnez	a5,440a <subdir+0x71c>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    43ec:	fd843583          	ld	a1,-40(s0)
    43f0:	00005517          	auipc	a0,0x5
    43f4:	e7050513          	addi	a0,a0,-400 # 9260 <malloc+0x17e8>
    43f8:	00003097          	auipc	ra,0x3
    43fc:	48e080e7          	jalr	1166(ra) # 7886 <printf>
    exit(1);
    4400:	4505                	li	a0,1
    4402:	00003097          	auipc	ra,0x3
    4406:	f46080e7          	jalr	-186(ra) # 7348 <exit>
  }
  if(chdir("dd/ff") == 0){
    440a:	00005517          	auipc	a0,0x5
    440e:	9f650513          	addi	a0,a0,-1546 # 8e00 <malloc+0x1388>
    4412:	00003097          	auipc	ra,0x3
    4416:	fa6080e7          	jalr	-90(ra) # 73b8 <chdir>
    441a:	87aa                	mv	a5,a0
    441c:	e385                	bnez	a5,443c <subdir+0x74e>
    printf("%s: chdir dd/ff succeeded!\n", s);
    441e:	fd843583          	ld	a1,-40(s0)
    4422:	00005517          	auipc	a0,0x5
    4426:	e5e50513          	addi	a0,a0,-418 # 9280 <malloc+0x1808>
    442a:	00003097          	auipc	ra,0x3
    442e:	45c080e7          	jalr	1116(ra) # 7886 <printf>
    exit(1);
    4432:	4505                	li	a0,1
    4434:	00003097          	auipc	ra,0x3
    4438:	f14080e7          	jalr	-236(ra) # 7348 <exit>
  }
  if(chdir("dd/xx") == 0){
    443c:	00005517          	auipc	a0,0x5
    4440:	e6450513          	addi	a0,a0,-412 # 92a0 <malloc+0x1828>
    4444:	00003097          	auipc	ra,0x3
    4448:	f74080e7          	jalr	-140(ra) # 73b8 <chdir>
    444c:	87aa                	mv	a5,a0
    444e:	e385                	bnez	a5,446e <subdir+0x780>
    printf("%s: chdir dd/xx succeeded!\n", s);
    4450:	fd843583          	ld	a1,-40(s0)
    4454:	00005517          	auipc	a0,0x5
    4458:	e5450513          	addi	a0,a0,-428 # 92a8 <malloc+0x1830>
    445c:	00003097          	auipc	ra,0x3
    4460:	42a080e7          	jalr	1066(ra) # 7886 <printf>
    exit(1);
    4464:	4505                	li	a0,1
    4466:	00003097          	auipc	ra,0x3
    446a:	ee2080e7          	jalr	-286(ra) # 7348 <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    446e:	00005517          	auipc	a0,0x5
    4472:	a9a50513          	addi	a0,a0,-1382 # 8f08 <malloc+0x1490>
    4476:	00003097          	auipc	ra,0x3
    447a:	f22080e7          	jalr	-222(ra) # 7398 <unlink>
    447e:	87aa                	mv	a5,a0
    4480:	c385                	beqz	a5,44a0 <subdir+0x7b2>
    printf("%s: unlink dd/dd/ff failed\n", s);
    4482:	fd843583          	ld	a1,-40(s0)
    4486:	00005517          	auipc	a0,0x5
    448a:	aba50513          	addi	a0,a0,-1350 # 8f40 <malloc+0x14c8>
    448e:	00003097          	auipc	ra,0x3
    4492:	3f8080e7          	jalr	1016(ra) # 7886 <printf>
    exit(1);
    4496:	4505                	li	a0,1
    4498:	00003097          	auipc	ra,0x3
    449c:	eb0080e7          	jalr	-336(ra) # 7348 <exit>
  }
  if(unlink("dd/ff") != 0){
    44a0:	00005517          	auipc	a0,0x5
    44a4:	96050513          	addi	a0,a0,-1696 # 8e00 <malloc+0x1388>
    44a8:	00003097          	auipc	ra,0x3
    44ac:	ef0080e7          	jalr	-272(ra) # 7398 <unlink>
    44b0:	87aa                	mv	a5,a0
    44b2:	c385                	beqz	a5,44d2 <subdir+0x7e4>
    printf("%s: unlink dd/ff failed\n", s);
    44b4:	fd843583          	ld	a1,-40(s0)
    44b8:	00005517          	auipc	a0,0x5
    44bc:	e1050513          	addi	a0,a0,-496 # 92c8 <malloc+0x1850>
    44c0:	00003097          	auipc	ra,0x3
    44c4:	3c6080e7          	jalr	966(ra) # 7886 <printf>
    exit(1);
    44c8:	4505                	li	a0,1
    44ca:	00003097          	auipc	ra,0x3
    44ce:	e7e080e7          	jalr	-386(ra) # 7348 <exit>
  }
  if(unlink("dd") == 0){
    44d2:	00005517          	auipc	a0,0x5
    44d6:	90e50513          	addi	a0,a0,-1778 # 8de0 <malloc+0x1368>
    44da:	00003097          	auipc	ra,0x3
    44de:	ebe080e7          	jalr	-322(ra) # 7398 <unlink>
    44e2:	87aa                	mv	a5,a0
    44e4:	e385                	bnez	a5,4504 <subdir+0x816>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    44e6:	fd843583          	ld	a1,-40(s0)
    44ea:	00005517          	auipc	a0,0x5
    44ee:	dfe50513          	addi	a0,a0,-514 # 92e8 <malloc+0x1870>
    44f2:	00003097          	auipc	ra,0x3
    44f6:	394080e7          	jalr	916(ra) # 7886 <printf>
    exit(1);
    44fa:	4505                	li	a0,1
    44fc:	00003097          	auipc	ra,0x3
    4500:	e4c080e7          	jalr	-436(ra) # 7348 <exit>
  }
  if(unlink("dd/dd") < 0){
    4504:	00005517          	auipc	a0,0x5
    4508:	e0c50513          	addi	a0,a0,-500 # 9310 <malloc+0x1898>
    450c:	00003097          	auipc	ra,0x3
    4510:	e8c080e7          	jalr	-372(ra) # 7398 <unlink>
    4514:	87aa                	mv	a5,a0
    4516:	0207d163          	bgez	a5,4538 <subdir+0x84a>
    printf("%s: unlink dd/dd failed\n", s);
    451a:	fd843583          	ld	a1,-40(s0)
    451e:	00005517          	auipc	a0,0x5
    4522:	dfa50513          	addi	a0,a0,-518 # 9318 <malloc+0x18a0>
    4526:	00003097          	auipc	ra,0x3
    452a:	360080e7          	jalr	864(ra) # 7886 <printf>
    exit(1);
    452e:	4505                	li	a0,1
    4530:	00003097          	auipc	ra,0x3
    4534:	e18080e7          	jalr	-488(ra) # 7348 <exit>
  }
  if(unlink("dd") < 0){
    4538:	00005517          	auipc	a0,0x5
    453c:	8a850513          	addi	a0,a0,-1880 # 8de0 <malloc+0x1368>
    4540:	00003097          	auipc	ra,0x3
    4544:	e58080e7          	jalr	-424(ra) # 7398 <unlink>
    4548:	87aa                	mv	a5,a0
    454a:	0207d163          	bgez	a5,456c <subdir+0x87e>
    printf("%s: unlink dd failed\n", s);
    454e:	fd843583          	ld	a1,-40(s0)
    4552:	00005517          	auipc	a0,0x5
    4556:	de650513          	addi	a0,a0,-538 # 9338 <malloc+0x18c0>
    455a:	00003097          	auipc	ra,0x3
    455e:	32c080e7          	jalr	812(ra) # 7886 <printf>
    exit(1);
    4562:	4505                	li	a0,1
    4564:	00003097          	auipc	ra,0x3
    4568:	de4080e7          	jalr	-540(ra) # 7348 <exit>
  }
}
    456c:	0001                	nop
    456e:	70a2                	ld	ra,40(sp)
    4570:	7402                	ld	s0,32(sp)
    4572:	6145                	addi	sp,sp,48
    4574:	8082                	ret

0000000000004576 <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(char *s)
{
    4576:	7179                	addi	sp,sp,-48
    4578:	f406                	sd	ra,40(sp)
    457a:	f022                	sd	s0,32(sp)
    457c:	1800                	addi	s0,sp,48
    457e:	fca43c23          	sd	a0,-40(s0)
  int fd, sz;

  unlink("bigwrite");
    4582:	00004517          	auipc	a0,0x4
    4586:	81650513          	addi	a0,a0,-2026 # 7d98 <malloc+0x320>
    458a:	00003097          	auipc	ra,0x3
    458e:	e0e080e7          	jalr	-498(ra) # 7398 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    4592:	1f300793          	li	a5,499
    4596:	fef42623          	sw	a5,-20(s0)
    459a:	a0e5                	j	4682 <bigwrite+0x10c>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    459c:	20200593          	li	a1,514
    45a0:	00003517          	auipc	a0,0x3
    45a4:	7f850513          	addi	a0,a0,2040 # 7d98 <malloc+0x320>
    45a8:	00003097          	auipc	ra,0x3
    45ac:	de0080e7          	jalr	-544(ra) # 7388 <open>
    45b0:	87aa                	mv	a5,a0
    45b2:	fef42223          	sw	a5,-28(s0)
    if(fd < 0){
    45b6:	fe442783          	lw	a5,-28(s0)
    45ba:	2781                	sext.w	a5,a5
    45bc:	0207d163          	bgez	a5,45de <bigwrite+0x68>
      printf("%s: cannot create bigwrite\n", s);
    45c0:	fd843583          	ld	a1,-40(s0)
    45c4:	00005517          	auipc	a0,0x5
    45c8:	d8c50513          	addi	a0,a0,-628 # 9350 <malloc+0x18d8>
    45cc:	00003097          	auipc	ra,0x3
    45d0:	2ba080e7          	jalr	698(ra) # 7886 <printf>
      exit(1);
    45d4:	4505                	li	a0,1
    45d6:	00003097          	auipc	ra,0x3
    45da:	d72080e7          	jalr	-654(ra) # 7348 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    45de:	fe042423          	sw	zero,-24(s0)
    45e2:	a0a5                	j	464a <bigwrite+0xd4>
      int cc = write(fd, buf, sz);
    45e4:	fec42703          	lw	a4,-20(s0)
    45e8:	fe442783          	lw	a5,-28(s0)
    45ec:	863a                	mv	a2,a4
    45ee:	00006597          	auipc	a1,0x6
    45f2:	e2258593          	addi	a1,a1,-478 # a410 <buf>
    45f6:	853e                	mv	a0,a5
    45f8:	00003097          	auipc	ra,0x3
    45fc:	d70080e7          	jalr	-656(ra) # 7368 <write>
    4600:	87aa                	mv	a5,a0
    4602:	fef42023          	sw	a5,-32(s0)
      if(cc != sz){
    4606:	fe042703          	lw	a4,-32(s0)
    460a:	fec42783          	lw	a5,-20(s0)
    460e:	2701                	sext.w	a4,a4
    4610:	2781                	sext.w	a5,a5
    4612:	02f70763          	beq	a4,a5,4640 <bigwrite+0xca>
        printf("%s: write(%d) ret %d\n", s, sz, cc);
    4616:	fe042703          	lw	a4,-32(s0)
    461a:	fec42783          	lw	a5,-20(s0)
    461e:	86ba                	mv	a3,a4
    4620:	863e                	mv	a2,a5
    4622:	fd843583          	ld	a1,-40(s0)
    4626:	00005517          	auipc	a0,0x5
    462a:	d4a50513          	addi	a0,a0,-694 # 9370 <malloc+0x18f8>
    462e:	00003097          	auipc	ra,0x3
    4632:	258080e7          	jalr	600(ra) # 7886 <printf>
        exit(1);
    4636:	4505                	li	a0,1
    4638:	00003097          	auipc	ra,0x3
    463c:	d10080e7          	jalr	-752(ra) # 7348 <exit>
    for(i = 0; i < 2; i++){
    4640:	fe842783          	lw	a5,-24(s0)
    4644:	2785                	addiw	a5,a5,1
    4646:	fef42423          	sw	a5,-24(s0)
    464a:	fe842783          	lw	a5,-24(s0)
    464e:	0007871b          	sext.w	a4,a5
    4652:	4785                	li	a5,1
    4654:	f8e7d8e3          	bge	a5,a4,45e4 <bigwrite+0x6e>
      }
    }
    close(fd);
    4658:	fe442783          	lw	a5,-28(s0)
    465c:	853e                	mv	a0,a5
    465e:	00003097          	auipc	ra,0x3
    4662:	d12080e7          	jalr	-750(ra) # 7370 <close>
    unlink("bigwrite");
    4666:	00003517          	auipc	a0,0x3
    466a:	73250513          	addi	a0,a0,1842 # 7d98 <malloc+0x320>
    466e:	00003097          	auipc	ra,0x3
    4672:	d2a080e7          	jalr	-726(ra) # 7398 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    4676:	fec42783          	lw	a5,-20(s0)
    467a:	1d77879b          	addiw	a5,a5,471
    467e:	fef42623          	sw	a5,-20(s0)
    4682:	fec42783          	lw	a5,-20(s0)
    4686:	0007871b          	sext.w	a4,a5
    468a:	678d                	lui	a5,0x3
    468c:	f0f748e3          	blt	a4,a5,459c <bigwrite+0x26>
  }
}
    4690:	0001                	nop
    4692:	0001                	nop
    4694:	70a2                	ld	ra,40(sp)
    4696:	7402                	ld	s0,32(sp)
    4698:	6145                	addi	sp,sp,48
    469a:	8082                	ret

000000000000469c <manywrites>:

// concurrent writes to try to provoke deadlock in the virtio disk
// driver.
void
manywrites(char *s)
{
    469c:	711d                	addi	sp,sp,-96
    469e:	ec86                	sd	ra,88(sp)
    46a0:	e8a2                	sd	s0,80(sp)
    46a2:	1080                	addi	s0,sp,96
    46a4:	faa43423          	sd	a0,-88(s0)
  int nchildren = 4;
    46a8:	4791                	li	a5,4
    46aa:	fcf42e23          	sw	a5,-36(s0)
  int howmany = 30; // increase to look for deadlock
    46ae:	47f9                	li	a5,30
    46b0:	fcf42c23          	sw	a5,-40(s0)
  
  for(int ci = 0; ci < nchildren; ci++){
    46b4:	fe042623          	sw	zero,-20(s0)
    46b8:	aa49                	j	484a <manywrites+0x1ae>
    int pid = fork();
    46ba:	00003097          	auipc	ra,0x3
    46be:	c86080e7          	jalr	-890(ra) # 7340 <fork>
    46c2:	87aa                	mv	a5,a0
    46c4:	fcf42a23          	sw	a5,-44(s0)
    if(pid < 0){
    46c8:	fd442783          	lw	a5,-44(s0)
    46cc:	2781                	sext.w	a5,a5
    46ce:	0007df63          	bgez	a5,46ec <manywrites+0x50>
      printf("fork failed\n");
    46d2:	00004517          	auipc	a0,0x4
    46d6:	a5650513          	addi	a0,a0,-1450 # 8128 <malloc+0x6b0>
    46da:	00003097          	auipc	ra,0x3
    46de:	1ac080e7          	jalr	428(ra) # 7886 <printf>
      exit(1);
    46e2:	4505                	li	a0,1
    46e4:	00003097          	auipc	ra,0x3
    46e8:	c64080e7          	jalr	-924(ra) # 7348 <exit>
    }

    if(pid == 0){
    46ec:	fd442783          	lw	a5,-44(s0)
    46f0:	2781                	sext.w	a5,a5
    46f2:	14079763          	bnez	a5,4840 <manywrites+0x1a4>
      char name[3];
      name[0] = 'b';
    46f6:	06200793          	li	a5,98
    46fa:	fcf40023          	sb	a5,-64(s0)
      name[1] = 'a' + ci;
    46fe:	fec42783          	lw	a5,-20(s0)
    4702:	0ff7f793          	andi	a5,a5,255
    4706:	0617879b          	addiw	a5,a5,97
    470a:	0ff7f793          	andi	a5,a5,255
    470e:	fcf400a3          	sb	a5,-63(s0)
      name[2] = '\0';
    4712:	fc040123          	sb	zero,-62(s0)
      unlink(name);
    4716:	fc040793          	addi	a5,s0,-64
    471a:	853e                	mv	a0,a5
    471c:	00003097          	auipc	ra,0x3
    4720:	c7c080e7          	jalr	-900(ra) # 7398 <unlink>
      
      for(int iters = 0; iters < howmany; iters++){
    4724:	fe042423          	sw	zero,-24(s0)
    4728:	a8c5                	j	4818 <manywrites+0x17c>
        for(int i = 0; i < ci+1; i++){
    472a:	fe042223          	sw	zero,-28(s0)
    472e:	a0c9                	j	47f0 <manywrites+0x154>
          int fd = open(name, O_CREATE | O_RDWR);
    4730:	fc040793          	addi	a5,s0,-64
    4734:	20200593          	li	a1,514
    4738:	853e                	mv	a0,a5
    473a:	00003097          	auipc	ra,0x3
    473e:	c4e080e7          	jalr	-946(ra) # 7388 <open>
    4742:	87aa                	mv	a5,a0
    4744:	fcf42823          	sw	a5,-48(s0)
          if(fd < 0){
    4748:	fd042783          	lw	a5,-48(s0)
    474c:	2781                	sext.w	a5,a5
    474e:	0207d463          	bgez	a5,4776 <manywrites+0xda>
            printf("%s: cannot create %s\n", s, name);
    4752:	fc040793          	addi	a5,s0,-64
    4756:	863e                	mv	a2,a5
    4758:	fa843583          	ld	a1,-88(s0)
    475c:	00005517          	auipc	a0,0x5
    4760:	c2c50513          	addi	a0,a0,-980 # 9388 <malloc+0x1910>
    4764:	00003097          	auipc	ra,0x3
    4768:	122080e7          	jalr	290(ra) # 7886 <printf>
            exit(1);
    476c:	4505                	li	a0,1
    476e:	00003097          	auipc	ra,0x3
    4772:	bda080e7          	jalr	-1062(ra) # 7348 <exit>
          }
          int sz = sizeof(buf);
    4776:	678d                	lui	a5,0x3
    4778:	fcf42623          	sw	a5,-52(s0)
          int cc = write(fd, buf, sz);
    477c:	fcc42703          	lw	a4,-52(s0)
    4780:	fd042783          	lw	a5,-48(s0)
    4784:	863a                	mv	a2,a4
    4786:	00006597          	auipc	a1,0x6
    478a:	c8a58593          	addi	a1,a1,-886 # a410 <buf>
    478e:	853e                	mv	a0,a5
    4790:	00003097          	auipc	ra,0x3
    4794:	bd8080e7          	jalr	-1064(ra) # 7368 <write>
    4798:	87aa                	mv	a5,a0
    479a:	fcf42423          	sw	a5,-56(s0)
          if(cc != sz){
    479e:	fc842703          	lw	a4,-56(s0)
    47a2:	fcc42783          	lw	a5,-52(s0)
    47a6:	2701                	sext.w	a4,a4
    47a8:	2781                	sext.w	a5,a5
    47aa:	02f70763          	beq	a4,a5,47d8 <manywrites+0x13c>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    47ae:	fc842703          	lw	a4,-56(s0)
    47b2:	fcc42783          	lw	a5,-52(s0)
    47b6:	86ba                	mv	a3,a4
    47b8:	863e                	mv	a2,a5
    47ba:	fa843583          	ld	a1,-88(s0)
    47be:	00005517          	auipc	a0,0x5
    47c2:	bb250513          	addi	a0,a0,-1102 # 9370 <malloc+0x18f8>
    47c6:	00003097          	auipc	ra,0x3
    47ca:	0c0080e7          	jalr	192(ra) # 7886 <printf>
            exit(1);
    47ce:	4505                	li	a0,1
    47d0:	00003097          	auipc	ra,0x3
    47d4:	b78080e7          	jalr	-1160(ra) # 7348 <exit>
          }
          close(fd);
    47d8:	fd042783          	lw	a5,-48(s0)
    47dc:	853e                	mv	a0,a5
    47de:	00003097          	auipc	ra,0x3
    47e2:	b92080e7          	jalr	-1134(ra) # 7370 <close>
        for(int i = 0; i < ci+1; i++){
    47e6:	fe442783          	lw	a5,-28(s0)
    47ea:	2785                	addiw	a5,a5,1
    47ec:	fef42223          	sw	a5,-28(s0)
    47f0:	fec42703          	lw	a4,-20(s0)
    47f4:	fe442783          	lw	a5,-28(s0)
    47f8:	2701                	sext.w	a4,a4
    47fa:	2781                	sext.w	a5,a5
    47fc:	f2f75ae3          	bge	a4,a5,4730 <manywrites+0x94>
        }
        unlink(name);
    4800:	fc040793          	addi	a5,s0,-64
    4804:	853e                	mv	a0,a5
    4806:	00003097          	auipc	ra,0x3
    480a:	b92080e7          	jalr	-1134(ra) # 7398 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    480e:	fe842783          	lw	a5,-24(s0)
    4812:	2785                	addiw	a5,a5,1
    4814:	fef42423          	sw	a5,-24(s0)
    4818:	fe842703          	lw	a4,-24(s0)
    481c:	fd842783          	lw	a5,-40(s0)
    4820:	2701                	sext.w	a4,a4
    4822:	2781                	sext.w	a5,a5
    4824:	f0f743e3          	blt	a4,a5,472a <manywrites+0x8e>
      }

      unlink(name);
    4828:	fc040793          	addi	a5,s0,-64
    482c:	853e                	mv	a0,a5
    482e:	00003097          	auipc	ra,0x3
    4832:	b6a080e7          	jalr	-1174(ra) # 7398 <unlink>
      exit(0);
    4836:	4501                	li	a0,0
    4838:	00003097          	auipc	ra,0x3
    483c:	b10080e7          	jalr	-1264(ra) # 7348 <exit>
  for(int ci = 0; ci < nchildren; ci++){
    4840:	fec42783          	lw	a5,-20(s0)
    4844:	2785                	addiw	a5,a5,1
    4846:	fef42623          	sw	a5,-20(s0)
    484a:	fec42703          	lw	a4,-20(s0)
    484e:	fdc42783          	lw	a5,-36(s0)
    4852:	2701                	sext.w	a4,a4
    4854:	2781                	sext.w	a5,a5
    4856:	e6f742e3          	blt	a4,a5,46ba <manywrites+0x1e>
    }
  }

  for(int ci = 0; ci < nchildren; ci++){
    485a:	fe042023          	sw	zero,-32(s0)
    485e:	a80d                	j	4890 <manywrites+0x1f4>
    int st = 0;
    4860:	fa042e23          	sw	zero,-68(s0)
    wait(&st);
    4864:	fbc40793          	addi	a5,s0,-68
    4868:	853e                	mv	a0,a5
    486a:	00003097          	auipc	ra,0x3
    486e:	ae6080e7          	jalr	-1306(ra) # 7350 <wait>
    if(st != 0)
    4872:	fbc42783          	lw	a5,-68(s0)
    4876:	cb81                	beqz	a5,4886 <manywrites+0x1ea>
      exit(st);
    4878:	fbc42783          	lw	a5,-68(s0)
    487c:	853e                	mv	a0,a5
    487e:	00003097          	auipc	ra,0x3
    4882:	aca080e7          	jalr	-1334(ra) # 7348 <exit>
  for(int ci = 0; ci < nchildren; ci++){
    4886:	fe042783          	lw	a5,-32(s0)
    488a:	2785                	addiw	a5,a5,1
    488c:	fef42023          	sw	a5,-32(s0)
    4890:	fe042703          	lw	a4,-32(s0)
    4894:	fdc42783          	lw	a5,-36(s0)
    4898:	2701                	sext.w	a4,a4
    489a:	2781                	sext.w	a5,a5
    489c:	fcf742e3          	blt	a4,a5,4860 <manywrites+0x1c4>
  }
  exit(0);
    48a0:	4501                	li	a0,0
    48a2:	00003097          	auipc	ra,0x3
    48a6:	aa6080e7          	jalr	-1370(ra) # 7348 <exit>

00000000000048aa <bigfile>:
}

void
bigfile(char *s)
{
    48aa:	7179                	addi	sp,sp,-48
    48ac:	f406                	sd	ra,40(sp)
    48ae:	f022                	sd	s0,32(sp)
    48b0:	1800                	addi	s0,sp,48
    48b2:	fca43c23          	sd	a0,-40(s0)
  enum { N = 20, SZ=600 };
  int fd, i, total, cc;

  unlink("bigfile.dat");
    48b6:	00005517          	auipc	a0,0x5
    48ba:	aea50513          	addi	a0,a0,-1302 # 93a0 <malloc+0x1928>
    48be:	00003097          	auipc	ra,0x3
    48c2:	ada080e7          	jalr	-1318(ra) # 7398 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    48c6:	20200593          	li	a1,514
    48ca:	00005517          	auipc	a0,0x5
    48ce:	ad650513          	addi	a0,a0,-1322 # 93a0 <malloc+0x1928>
    48d2:	00003097          	auipc	ra,0x3
    48d6:	ab6080e7          	jalr	-1354(ra) # 7388 <open>
    48da:	87aa                	mv	a5,a0
    48dc:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    48e0:	fe442783          	lw	a5,-28(s0)
    48e4:	2781                	sext.w	a5,a5
    48e6:	0207d163          	bgez	a5,4908 <bigfile+0x5e>
    printf("%s: cannot create bigfile", s);
    48ea:	fd843583          	ld	a1,-40(s0)
    48ee:	00005517          	auipc	a0,0x5
    48f2:	ac250513          	addi	a0,a0,-1342 # 93b0 <malloc+0x1938>
    48f6:	00003097          	auipc	ra,0x3
    48fa:	f90080e7          	jalr	-112(ra) # 7886 <printf>
    exit(1);
    48fe:	4505                	li	a0,1
    4900:	00003097          	auipc	ra,0x3
    4904:	a48080e7          	jalr	-1464(ra) # 7348 <exit>
  }
  for(i = 0; i < N; i++){
    4908:	fe042623          	sw	zero,-20(s0)
    490c:	a0ad                	j	4976 <bigfile+0xcc>
    memset(buf, i, SZ);
    490e:	fec42783          	lw	a5,-20(s0)
    4912:	25800613          	li	a2,600
    4916:	85be                	mv	a1,a5
    4918:	00006517          	auipc	a0,0x6
    491c:	af850513          	addi	a0,a0,-1288 # a410 <buf>
    4920:	00002097          	auipc	ra,0x2
    4924:	67e080e7          	jalr	1662(ra) # 6f9e <memset>
    if(write(fd, buf, SZ) != SZ){
    4928:	fe442783          	lw	a5,-28(s0)
    492c:	25800613          	li	a2,600
    4930:	00006597          	auipc	a1,0x6
    4934:	ae058593          	addi	a1,a1,-1312 # a410 <buf>
    4938:	853e                	mv	a0,a5
    493a:	00003097          	auipc	ra,0x3
    493e:	a2e080e7          	jalr	-1490(ra) # 7368 <write>
    4942:	87aa                	mv	a5,a0
    4944:	873e                	mv	a4,a5
    4946:	25800793          	li	a5,600
    494a:	02f70163          	beq	a4,a5,496c <bigfile+0xc2>
      printf("%s: write bigfile failed\n", s);
    494e:	fd843583          	ld	a1,-40(s0)
    4952:	00005517          	auipc	a0,0x5
    4956:	a7e50513          	addi	a0,a0,-1410 # 93d0 <malloc+0x1958>
    495a:	00003097          	auipc	ra,0x3
    495e:	f2c080e7          	jalr	-212(ra) # 7886 <printf>
      exit(1);
    4962:	4505                	li	a0,1
    4964:	00003097          	auipc	ra,0x3
    4968:	9e4080e7          	jalr	-1564(ra) # 7348 <exit>
  for(i = 0; i < N; i++){
    496c:	fec42783          	lw	a5,-20(s0)
    4970:	2785                	addiw	a5,a5,1
    4972:	fef42623          	sw	a5,-20(s0)
    4976:	fec42783          	lw	a5,-20(s0)
    497a:	0007871b          	sext.w	a4,a5
    497e:	47cd                	li	a5,19
    4980:	f8e7d7e3          	bge	a5,a4,490e <bigfile+0x64>
    }
  }
  close(fd);
    4984:	fe442783          	lw	a5,-28(s0)
    4988:	853e                	mv	a0,a5
    498a:	00003097          	auipc	ra,0x3
    498e:	9e6080e7          	jalr	-1562(ra) # 7370 <close>

  fd = open("bigfile.dat", 0);
    4992:	4581                	li	a1,0
    4994:	00005517          	auipc	a0,0x5
    4998:	a0c50513          	addi	a0,a0,-1524 # 93a0 <malloc+0x1928>
    499c:	00003097          	auipc	ra,0x3
    49a0:	9ec080e7          	jalr	-1556(ra) # 7388 <open>
    49a4:	87aa                	mv	a5,a0
    49a6:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    49aa:	fe442783          	lw	a5,-28(s0)
    49ae:	2781                	sext.w	a5,a5
    49b0:	0207d163          	bgez	a5,49d2 <bigfile+0x128>
    printf("%s: cannot open bigfile\n", s);
    49b4:	fd843583          	ld	a1,-40(s0)
    49b8:	00005517          	auipc	a0,0x5
    49bc:	a3850513          	addi	a0,a0,-1480 # 93f0 <malloc+0x1978>
    49c0:	00003097          	auipc	ra,0x3
    49c4:	ec6080e7          	jalr	-314(ra) # 7886 <printf>
    exit(1);
    49c8:	4505                	li	a0,1
    49ca:	00003097          	auipc	ra,0x3
    49ce:	97e080e7          	jalr	-1666(ra) # 7348 <exit>
  }
  total = 0;
    49d2:	fe042423          	sw	zero,-24(s0)
  for(i = 0; ; i++){
    49d6:	fe042623          	sw	zero,-20(s0)
    cc = read(fd, buf, SZ/2);
    49da:	fe442783          	lw	a5,-28(s0)
    49de:	12c00613          	li	a2,300
    49e2:	00006597          	auipc	a1,0x6
    49e6:	a2e58593          	addi	a1,a1,-1490 # a410 <buf>
    49ea:	853e                	mv	a0,a5
    49ec:	00003097          	auipc	ra,0x3
    49f0:	974080e7          	jalr	-1676(ra) # 7360 <read>
    49f4:	87aa                	mv	a5,a0
    49f6:	fef42023          	sw	a5,-32(s0)
    if(cc < 0){
    49fa:	fe042783          	lw	a5,-32(s0)
    49fe:	2781                	sext.w	a5,a5
    4a00:	0207d163          	bgez	a5,4a22 <bigfile+0x178>
      printf("%s: read bigfile failed\n", s);
    4a04:	fd843583          	ld	a1,-40(s0)
    4a08:	00005517          	auipc	a0,0x5
    4a0c:	a0850513          	addi	a0,a0,-1528 # 9410 <malloc+0x1998>
    4a10:	00003097          	auipc	ra,0x3
    4a14:	e76080e7          	jalr	-394(ra) # 7886 <printf>
      exit(1);
    4a18:	4505                	li	a0,1
    4a1a:	00003097          	auipc	ra,0x3
    4a1e:	92e080e7          	jalr	-1746(ra) # 7348 <exit>
    }
    if(cc == 0)
    4a22:	fe042783          	lw	a5,-32(s0)
    4a26:	2781                	sext.w	a5,a5
    4a28:	cbd5                	beqz	a5,4adc <bigfile+0x232>
      break;
    if(cc != SZ/2){
    4a2a:	fe042783          	lw	a5,-32(s0)
    4a2e:	0007871b          	sext.w	a4,a5
    4a32:	12c00793          	li	a5,300
    4a36:	02f70163          	beq	a4,a5,4a58 <bigfile+0x1ae>
      printf("%s: short read bigfile\n", s);
    4a3a:	fd843583          	ld	a1,-40(s0)
    4a3e:	00005517          	auipc	a0,0x5
    4a42:	9f250513          	addi	a0,a0,-1550 # 9430 <malloc+0x19b8>
    4a46:	00003097          	auipc	ra,0x3
    4a4a:	e40080e7          	jalr	-448(ra) # 7886 <printf>
      exit(1);
    4a4e:	4505                	li	a0,1
    4a50:	00003097          	auipc	ra,0x3
    4a54:	8f8080e7          	jalr	-1800(ra) # 7348 <exit>
    }
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4a58:	00006797          	auipc	a5,0x6
    4a5c:	9b878793          	addi	a5,a5,-1608 # a410 <buf>
    4a60:	0007c783          	lbu	a5,0(a5)
    4a64:	0007869b          	sext.w	a3,a5
    4a68:	fec42783          	lw	a5,-20(s0)
    4a6c:	01f7d71b          	srliw	a4,a5,0x1f
    4a70:	9fb9                	addw	a5,a5,a4
    4a72:	4017d79b          	sraiw	a5,a5,0x1
    4a76:	2781                	sext.w	a5,a5
    4a78:	8736                	mv	a4,a3
    4a7a:	02f71563          	bne	a4,a5,4aa4 <bigfile+0x1fa>
    4a7e:	00006797          	auipc	a5,0x6
    4a82:	99278793          	addi	a5,a5,-1646 # a410 <buf>
    4a86:	12b7c783          	lbu	a5,299(a5)
    4a8a:	0007869b          	sext.w	a3,a5
    4a8e:	fec42783          	lw	a5,-20(s0)
    4a92:	01f7d71b          	srliw	a4,a5,0x1f
    4a96:	9fb9                	addw	a5,a5,a4
    4a98:	4017d79b          	sraiw	a5,a5,0x1
    4a9c:	2781                	sext.w	a5,a5
    4a9e:	8736                	mv	a4,a3
    4aa0:	02f70163          	beq	a4,a5,4ac2 <bigfile+0x218>
      printf("%s: read bigfile wrong data\n", s);
    4aa4:	fd843583          	ld	a1,-40(s0)
    4aa8:	00005517          	auipc	a0,0x5
    4aac:	9a050513          	addi	a0,a0,-1632 # 9448 <malloc+0x19d0>
    4ab0:	00003097          	auipc	ra,0x3
    4ab4:	dd6080e7          	jalr	-554(ra) # 7886 <printf>
      exit(1);
    4ab8:	4505                	li	a0,1
    4aba:	00003097          	auipc	ra,0x3
    4abe:	88e080e7          	jalr	-1906(ra) # 7348 <exit>
    }
    total += cc;
    4ac2:	fe842703          	lw	a4,-24(s0)
    4ac6:	fe042783          	lw	a5,-32(s0)
    4aca:	9fb9                	addw	a5,a5,a4
    4acc:	fef42423          	sw	a5,-24(s0)
  for(i = 0; ; i++){
    4ad0:	fec42783          	lw	a5,-20(s0)
    4ad4:	2785                	addiw	a5,a5,1
    4ad6:	fef42623          	sw	a5,-20(s0)
    cc = read(fd, buf, SZ/2);
    4ada:	b701                	j	49da <bigfile+0x130>
      break;
    4adc:	0001                	nop
  }
  close(fd);
    4ade:	fe442783          	lw	a5,-28(s0)
    4ae2:	853e                	mv	a0,a5
    4ae4:	00003097          	auipc	ra,0x3
    4ae8:	88c080e7          	jalr	-1908(ra) # 7370 <close>
  if(total != N*SZ){
    4aec:	fe842783          	lw	a5,-24(s0)
    4af0:	0007871b          	sext.w	a4,a5
    4af4:	678d                	lui	a5,0x3
    4af6:	ee078793          	addi	a5,a5,-288 # 2ee0 <createdelete+0x15e>
    4afa:	02f70163          	beq	a4,a5,4b1c <bigfile+0x272>
    printf("%s: read bigfile wrong total\n", s);
    4afe:	fd843583          	ld	a1,-40(s0)
    4b02:	00005517          	auipc	a0,0x5
    4b06:	96650513          	addi	a0,a0,-1690 # 9468 <malloc+0x19f0>
    4b0a:	00003097          	auipc	ra,0x3
    4b0e:	d7c080e7          	jalr	-644(ra) # 7886 <printf>
    exit(1);
    4b12:	4505                	li	a0,1
    4b14:	00003097          	auipc	ra,0x3
    4b18:	834080e7          	jalr	-1996(ra) # 7348 <exit>
  }
  unlink("bigfile.dat");
    4b1c:	00005517          	auipc	a0,0x5
    4b20:	88450513          	addi	a0,a0,-1916 # 93a0 <malloc+0x1928>
    4b24:	00003097          	auipc	ra,0x3
    4b28:	874080e7          	jalr	-1932(ra) # 7398 <unlink>
}
    4b2c:	0001                	nop
    4b2e:	70a2                	ld	ra,40(sp)
    4b30:	7402                	ld	s0,32(sp)
    4b32:	6145                	addi	sp,sp,48
    4b34:	8082                	ret

0000000000004b36 <fourteen>:

void
fourteen(char *s)
{
    4b36:	7179                	addi	sp,sp,-48
    4b38:	f406                	sd	ra,40(sp)
    4b3a:	f022                	sd	s0,32(sp)
    4b3c:	1800                	addi	s0,sp,48
    4b3e:	fca43c23          	sd	a0,-40(s0)
  int fd;

  // DIRSIZ is 14.

  if(mkdir("12345678901234") != 0){
    4b42:	00005517          	auipc	a0,0x5
    4b46:	94650513          	addi	a0,a0,-1722 # 9488 <malloc+0x1a10>
    4b4a:	00003097          	auipc	ra,0x3
    4b4e:	866080e7          	jalr	-1946(ra) # 73b0 <mkdir>
    4b52:	87aa                	mv	a5,a0
    4b54:	c385                	beqz	a5,4b74 <fourteen+0x3e>
    printf("%s: mkdir 12345678901234 failed\n", s);
    4b56:	fd843583          	ld	a1,-40(s0)
    4b5a:	00005517          	auipc	a0,0x5
    4b5e:	93e50513          	addi	a0,a0,-1730 # 9498 <malloc+0x1a20>
    4b62:	00003097          	auipc	ra,0x3
    4b66:	d24080e7          	jalr	-732(ra) # 7886 <printf>
    exit(1);
    4b6a:	4505                	li	a0,1
    4b6c:	00002097          	auipc	ra,0x2
    4b70:	7dc080e7          	jalr	2012(ra) # 7348 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    4b74:	00005517          	auipc	a0,0x5
    4b78:	94c50513          	addi	a0,a0,-1716 # 94c0 <malloc+0x1a48>
    4b7c:	00003097          	auipc	ra,0x3
    4b80:	834080e7          	jalr	-1996(ra) # 73b0 <mkdir>
    4b84:	87aa                	mv	a5,a0
    4b86:	c385                	beqz	a5,4ba6 <fourteen+0x70>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    4b88:	fd843583          	ld	a1,-40(s0)
    4b8c:	00005517          	auipc	a0,0x5
    4b90:	95450513          	addi	a0,a0,-1708 # 94e0 <malloc+0x1a68>
    4b94:	00003097          	auipc	ra,0x3
    4b98:	cf2080e7          	jalr	-782(ra) # 7886 <printf>
    exit(1);
    4b9c:	4505                	li	a0,1
    4b9e:	00002097          	auipc	ra,0x2
    4ba2:	7aa080e7          	jalr	1962(ra) # 7348 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    4ba6:	20000593          	li	a1,512
    4baa:	00005517          	auipc	a0,0x5
    4bae:	96e50513          	addi	a0,a0,-1682 # 9518 <malloc+0x1aa0>
    4bb2:	00002097          	auipc	ra,0x2
    4bb6:	7d6080e7          	jalr	2006(ra) # 7388 <open>
    4bba:	87aa                	mv	a5,a0
    4bbc:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    4bc0:	fec42783          	lw	a5,-20(s0)
    4bc4:	2781                	sext.w	a5,a5
    4bc6:	0207d163          	bgez	a5,4be8 <fourteen+0xb2>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    4bca:	fd843583          	ld	a1,-40(s0)
    4bce:	00005517          	auipc	a0,0x5
    4bd2:	97a50513          	addi	a0,a0,-1670 # 9548 <malloc+0x1ad0>
    4bd6:	00003097          	auipc	ra,0x3
    4bda:	cb0080e7          	jalr	-848(ra) # 7886 <printf>
    exit(1);
    4bde:	4505                	li	a0,1
    4be0:	00002097          	auipc	ra,0x2
    4be4:	768080e7          	jalr	1896(ra) # 7348 <exit>
  }
  close(fd);
    4be8:	fec42783          	lw	a5,-20(s0)
    4bec:	853e                	mv	a0,a5
    4bee:	00002097          	auipc	ra,0x2
    4bf2:	782080e7          	jalr	1922(ra) # 7370 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    4bf6:	4581                	li	a1,0
    4bf8:	00005517          	auipc	a0,0x5
    4bfc:	99850513          	addi	a0,a0,-1640 # 9590 <malloc+0x1b18>
    4c00:	00002097          	auipc	ra,0x2
    4c04:	788080e7          	jalr	1928(ra) # 7388 <open>
    4c08:	87aa                	mv	a5,a0
    4c0a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    4c0e:	fec42783          	lw	a5,-20(s0)
    4c12:	2781                	sext.w	a5,a5
    4c14:	0207d163          	bgez	a5,4c36 <fourteen+0x100>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    4c18:	fd843583          	ld	a1,-40(s0)
    4c1c:	00005517          	auipc	a0,0x5
    4c20:	9a450513          	addi	a0,a0,-1628 # 95c0 <malloc+0x1b48>
    4c24:	00003097          	auipc	ra,0x3
    4c28:	c62080e7          	jalr	-926(ra) # 7886 <printf>
    exit(1);
    4c2c:	4505                	li	a0,1
    4c2e:	00002097          	auipc	ra,0x2
    4c32:	71a080e7          	jalr	1818(ra) # 7348 <exit>
  }
  close(fd);
    4c36:	fec42783          	lw	a5,-20(s0)
    4c3a:	853e                	mv	a0,a5
    4c3c:	00002097          	auipc	ra,0x2
    4c40:	734080e7          	jalr	1844(ra) # 7370 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    4c44:	00005517          	auipc	a0,0x5
    4c48:	9bc50513          	addi	a0,a0,-1604 # 9600 <malloc+0x1b88>
    4c4c:	00002097          	auipc	ra,0x2
    4c50:	764080e7          	jalr	1892(ra) # 73b0 <mkdir>
    4c54:	87aa                	mv	a5,a0
    4c56:	e385                	bnez	a5,4c76 <fourteen+0x140>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    4c58:	fd843583          	ld	a1,-40(s0)
    4c5c:	00005517          	auipc	a0,0x5
    4c60:	9c450513          	addi	a0,a0,-1596 # 9620 <malloc+0x1ba8>
    4c64:	00003097          	auipc	ra,0x3
    4c68:	c22080e7          	jalr	-990(ra) # 7886 <printf>
    exit(1);
    4c6c:	4505                	li	a0,1
    4c6e:	00002097          	auipc	ra,0x2
    4c72:	6da080e7          	jalr	1754(ra) # 7348 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    4c76:	00005517          	auipc	a0,0x5
    4c7a:	9e250513          	addi	a0,a0,-1566 # 9658 <malloc+0x1be0>
    4c7e:	00002097          	auipc	ra,0x2
    4c82:	732080e7          	jalr	1842(ra) # 73b0 <mkdir>
    4c86:	87aa                	mv	a5,a0
    4c88:	e385                	bnez	a5,4ca8 <fourteen+0x172>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    4c8a:	fd843583          	ld	a1,-40(s0)
    4c8e:	00005517          	auipc	a0,0x5
    4c92:	9ea50513          	addi	a0,a0,-1558 # 9678 <malloc+0x1c00>
    4c96:	00003097          	auipc	ra,0x3
    4c9a:	bf0080e7          	jalr	-1040(ra) # 7886 <printf>
    exit(1);
    4c9e:	4505                	li	a0,1
    4ca0:	00002097          	auipc	ra,0x2
    4ca4:	6a8080e7          	jalr	1704(ra) # 7348 <exit>
  }

  // clean up
  unlink("123456789012345/12345678901234");
    4ca8:	00005517          	auipc	a0,0x5
    4cac:	9b050513          	addi	a0,a0,-1616 # 9658 <malloc+0x1be0>
    4cb0:	00002097          	auipc	ra,0x2
    4cb4:	6e8080e7          	jalr	1768(ra) # 7398 <unlink>
  unlink("12345678901234/12345678901234");
    4cb8:	00005517          	auipc	a0,0x5
    4cbc:	94850513          	addi	a0,a0,-1720 # 9600 <malloc+0x1b88>
    4cc0:	00002097          	auipc	ra,0x2
    4cc4:	6d8080e7          	jalr	1752(ra) # 7398 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    4cc8:	00005517          	auipc	a0,0x5
    4ccc:	8c850513          	addi	a0,a0,-1848 # 9590 <malloc+0x1b18>
    4cd0:	00002097          	auipc	ra,0x2
    4cd4:	6c8080e7          	jalr	1736(ra) # 7398 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    4cd8:	00005517          	auipc	a0,0x5
    4cdc:	84050513          	addi	a0,a0,-1984 # 9518 <malloc+0x1aa0>
    4ce0:	00002097          	auipc	ra,0x2
    4ce4:	6b8080e7          	jalr	1720(ra) # 7398 <unlink>
  unlink("12345678901234/123456789012345");
    4ce8:	00004517          	auipc	a0,0x4
    4cec:	7d850513          	addi	a0,a0,2008 # 94c0 <malloc+0x1a48>
    4cf0:	00002097          	auipc	ra,0x2
    4cf4:	6a8080e7          	jalr	1704(ra) # 7398 <unlink>
  unlink("12345678901234");
    4cf8:	00004517          	auipc	a0,0x4
    4cfc:	79050513          	addi	a0,a0,1936 # 9488 <malloc+0x1a10>
    4d00:	00002097          	auipc	ra,0x2
    4d04:	698080e7          	jalr	1688(ra) # 7398 <unlink>
}
    4d08:	0001                	nop
    4d0a:	70a2                	ld	ra,40(sp)
    4d0c:	7402                	ld	s0,32(sp)
    4d0e:	6145                	addi	sp,sp,48
    4d10:	8082                	ret

0000000000004d12 <rmdot>:

void
rmdot(char *s)
{
    4d12:	1101                	addi	sp,sp,-32
    4d14:	ec06                	sd	ra,24(sp)
    4d16:	e822                	sd	s0,16(sp)
    4d18:	1000                	addi	s0,sp,32
    4d1a:	fea43423          	sd	a0,-24(s0)
  if(mkdir("dots") != 0){
    4d1e:	00005517          	auipc	a0,0x5
    4d22:	99250513          	addi	a0,a0,-1646 # 96b0 <malloc+0x1c38>
    4d26:	00002097          	auipc	ra,0x2
    4d2a:	68a080e7          	jalr	1674(ra) # 73b0 <mkdir>
    4d2e:	87aa                	mv	a5,a0
    4d30:	c385                	beqz	a5,4d50 <rmdot+0x3e>
    printf("%s: mkdir dots failed\n", s);
    4d32:	fe843583          	ld	a1,-24(s0)
    4d36:	00005517          	auipc	a0,0x5
    4d3a:	98250513          	addi	a0,a0,-1662 # 96b8 <malloc+0x1c40>
    4d3e:	00003097          	auipc	ra,0x3
    4d42:	b48080e7          	jalr	-1208(ra) # 7886 <printf>
    exit(1);
    4d46:	4505                	li	a0,1
    4d48:	00002097          	auipc	ra,0x2
    4d4c:	600080e7          	jalr	1536(ra) # 7348 <exit>
  }
  if(chdir("dots") != 0){
    4d50:	00005517          	auipc	a0,0x5
    4d54:	96050513          	addi	a0,a0,-1696 # 96b0 <malloc+0x1c38>
    4d58:	00002097          	auipc	ra,0x2
    4d5c:	660080e7          	jalr	1632(ra) # 73b8 <chdir>
    4d60:	87aa                	mv	a5,a0
    4d62:	c385                	beqz	a5,4d82 <rmdot+0x70>
    printf("%s: chdir dots failed\n", s);
    4d64:	fe843583          	ld	a1,-24(s0)
    4d68:	00005517          	auipc	a0,0x5
    4d6c:	96850513          	addi	a0,a0,-1688 # 96d0 <malloc+0x1c58>
    4d70:	00003097          	auipc	ra,0x3
    4d74:	b16080e7          	jalr	-1258(ra) # 7886 <printf>
    exit(1);
    4d78:	4505                	li	a0,1
    4d7a:	00002097          	auipc	ra,0x2
    4d7e:	5ce080e7          	jalr	1486(ra) # 7348 <exit>
  }
  if(unlink(".") == 0){
    4d82:	00004517          	auipc	a0,0x4
    4d86:	f1650513          	addi	a0,a0,-234 # 8c98 <malloc+0x1220>
    4d8a:	00002097          	auipc	ra,0x2
    4d8e:	60e080e7          	jalr	1550(ra) # 7398 <unlink>
    4d92:	87aa                	mv	a5,a0
    4d94:	e385                	bnez	a5,4db4 <rmdot+0xa2>
    printf("%s: rm . worked!\n", s);
    4d96:	fe843583          	ld	a1,-24(s0)
    4d9a:	00005517          	auipc	a0,0x5
    4d9e:	94e50513          	addi	a0,a0,-1714 # 96e8 <malloc+0x1c70>
    4da2:	00003097          	auipc	ra,0x3
    4da6:	ae4080e7          	jalr	-1308(ra) # 7886 <printf>
    exit(1);
    4daa:	4505                	li	a0,1
    4dac:	00002097          	auipc	ra,0x2
    4db0:	59c080e7          	jalr	1436(ra) # 7348 <exit>
  }
  if(unlink("..") == 0){
    4db4:	00004517          	auipc	a0,0x4
    4db8:	97c50513          	addi	a0,a0,-1668 # 8730 <malloc+0xcb8>
    4dbc:	00002097          	auipc	ra,0x2
    4dc0:	5dc080e7          	jalr	1500(ra) # 7398 <unlink>
    4dc4:	87aa                	mv	a5,a0
    4dc6:	e385                	bnez	a5,4de6 <rmdot+0xd4>
    printf("%s: rm .. worked!\n", s);
    4dc8:	fe843583          	ld	a1,-24(s0)
    4dcc:	00005517          	auipc	a0,0x5
    4dd0:	93450513          	addi	a0,a0,-1740 # 9700 <malloc+0x1c88>
    4dd4:	00003097          	auipc	ra,0x3
    4dd8:	ab2080e7          	jalr	-1358(ra) # 7886 <printf>
    exit(1);
    4ddc:	4505                	li	a0,1
    4dde:	00002097          	auipc	ra,0x2
    4de2:	56a080e7          	jalr	1386(ra) # 7348 <exit>
  }
  if(chdir("/") != 0){
    4de6:	00003517          	auipc	a0,0x3
    4dea:	66250513          	addi	a0,a0,1634 # 8448 <malloc+0x9d0>
    4dee:	00002097          	auipc	ra,0x2
    4df2:	5ca080e7          	jalr	1482(ra) # 73b8 <chdir>
    4df6:	87aa                	mv	a5,a0
    4df8:	c385                	beqz	a5,4e18 <rmdot+0x106>
    printf("%s: chdir / failed\n", s);
    4dfa:	fe843583          	ld	a1,-24(s0)
    4dfe:	00003517          	auipc	a0,0x3
    4e02:	65250513          	addi	a0,a0,1618 # 8450 <malloc+0x9d8>
    4e06:	00003097          	auipc	ra,0x3
    4e0a:	a80080e7          	jalr	-1408(ra) # 7886 <printf>
    exit(1);
    4e0e:	4505                	li	a0,1
    4e10:	00002097          	auipc	ra,0x2
    4e14:	538080e7          	jalr	1336(ra) # 7348 <exit>
  }
  if(unlink("dots/.") == 0){
    4e18:	00005517          	auipc	a0,0x5
    4e1c:	90050513          	addi	a0,a0,-1792 # 9718 <malloc+0x1ca0>
    4e20:	00002097          	auipc	ra,0x2
    4e24:	578080e7          	jalr	1400(ra) # 7398 <unlink>
    4e28:	87aa                	mv	a5,a0
    4e2a:	e385                	bnez	a5,4e4a <rmdot+0x138>
    printf("%s: unlink dots/. worked!\n", s);
    4e2c:	fe843583          	ld	a1,-24(s0)
    4e30:	00005517          	auipc	a0,0x5
    4e34:	8f050513          	addi	a0,a0,-1808 # 9720 <malloc+0x1ca8>
    4e38:	00003097          	auipc	ra,0x3
    4e3c:	a4e080e7          	jalr	-1458(ra) # 7886 <printf>
    exit(1);
    4e40:	4505                	li	a0,1
    4e42:	00002097          	auipc	ra,0x2
    4e46:	506080e7          	jalr	1286(ra) # 7348 <exit>
  }
  if(unlink("dots/..") == 0){
    4e4a:	00005517          	auipc	a0,0x5
    4e4e:	8f650513          	addi	a0,a0,-1802 # 9740 <malloc+0x1cc8>
    4e52:	00002097          	auipc	ra,0x2
    4e56:	546080e7          	jalr	1350(ra) # 7398 <unlink>
    4e5a:	87aa                	mv	a5,a0
    4e5c:	e385                	bnez	a5,4e7c <rmdot+0x16a>
    printf("%s: unlink dots/.. worked!\n", s);
    4e5e:	fe843583          	ld	a1,-24(s0)
    4e62:	00005517          	auipc	a0,0x5
    4e66:	8e650513          	addi	a0,a0,-1818 # 9748 <malloc+0x1cd0>
    4e6a:	00003097          	auipc	ra,0x3
    4e6e:	a1c080e7          	jalr	-1508(ra) # 7886 <printf>
    exit(1);
    4e72:	4505                	li	a0,1
    4e74:	00002097          	auipc	ra,0x2
    4e78:	4d4080e7          	jalr	1236(ra) # 7348 <exit>
  }
  if(unlink("dots") != 0){
    4e7c:	00005517          	auipc	a0,0x5
    4e80:	83450513          	addi	a0,a0,-1996 # 96b0 <malloc+0x1c38>
    4e84:	00002097          	auipc	ra,0x2
    4e88:	514080e7          	jalr	1300(ra) # 7398 <unlink>
    4e8c:	87aa                	mv	a5,a0
    4e8e:	c385                	beqz	a5,4eae <rmdot+0x19c>
    printf("%s: unlink dots failed!\n", s);
    4e90:	fe843583          	ld	a1,-24(s0)
    4e94:	00005517          	auipc	a0,0x5
    4e98:	8d450513          	addi	a0,a0,-1836 # 9768 <malloc+0x1cf0>
    4e9c:	00003097          	auipc	ra,0x3
    4ea0:	9ea080e7          	jalr	-1558(ra) # 7886 <printf>
    exit(1);
    4ea4:	4505                	li	a0,1
    4ea6:	00002097          	auipc	ra,0x2
    4eaa:	4a2080e7          	jalr	1186(ra) # 7348 <exit>
  }
}
    4eae:	0001                	nop
    4eb0:	60e2                	ld	ra,24(sp)
    4eb2:	6442                	ld	s0,16(sp)
    4eb4:	6105                	addi	sp,sp,32
    4eb6:	8082                	ret

0000000000004eb8 <dirfile>:

void
dirfile(char *s)
{
    4eb8:	7179                	addi	sp,sp,-48
    4eba:	f406                	sd	ra,40(sp)
    4ebc:	f022                	sd	s0,32(sp)
    4ebe:	1800                	addi	s0,sp,48
    4ec0:	fca43c23          	sd	a0,-40(s0)
  int fd;

  fd = open("dirfile", O_CREATE);
    4ec4:	20000593          	li	a1,512
    4ec8:	00003517          	auipc	a0,0x3
    4ecc:	02850513          	addi	a0,a0,40 # 7ef0 <malloc+0x478>
    4ed0:	00002097          	auipc	ra,0x2
    4ed4:	4b8080e7          	jalr	1208(ra) # 7388 <open>
    4ed8:	87aa                	mv	a5,a0
    4eda:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    4ede:	fec42783          	lw	a5,-20(s0)
    4ee2:	2781                	sext.w	a5,a5
    4ee4:	0207d163          	bgez	a5,4f06 <dirfile+0x4e>
    printf("%s: create dirfile failed\n", s);
    4ee8:	fd843583          	ld	a1,-40(s0)
    4eec:	00005517          	auipc	a0,0x5
    4ef0:	89c50513          	addi	a0,a0,-1892 # 9788 <malloc+0x1d10>
    4ef4:	00003097          	auipc	ra,0x3
    4ef8:	992080e7          	jalr	-1646(ra) # 7886 <printf>
    exit(1);
    4efc:	4505                	li	a0,1
    4efe:	00002097          	auipc	ra,0x2
    4f02:	44a080e7          	jalr	1098(ra) # 7348 <exit>
  }
  close(fd);
    4f06:	fec42783          	lw	a5,-20(s0)
    4f0a:	853e                	mv	a0,a5
    4f0c:	00002097          	auipc	ra,0x2
    4f10:	464080e7          	jalr	1124(ra) # 7370 <close>
  if(chdir("dirfile") == 0){
    4f14:	00003517          	auipc	a0,0x3
    4f18:	fdc50513          	addi	a0,a0,-36 # 7ef0 <malloc+0x478>
    4f1c:	00002097          	auipc	ra,0x2
    4f20:	49c080e7          	jalr	1180(ra) # 73b8 <chdir>
    4f24:	87aa                	mv	a5,a0
    4f26:	e385                	bnez	a5,4f46 <dirfile+0x8e>
    printf("%s: chdir dirfile succeeded!\n", s);
    4f28:	fd843583          	ld	a1,-40(s0)
    4f2c:	00005517          	auipc	a0,0x5
    4f30:	87c50513          	addi	a0,a0,-1924 # 97a8 <malloc+0x1d30>
    4f34:	00003097          	auipc	ra,0x3
    4f38:	952080e7          	jalr	-1710(ra) # 7886 <printf>
    exit(1);
    4f3c:	4505                	li	a0,1
    4f3e:	00002097          	auipc	ra,0x2
    4f42:	40a080e7          	jalr	1034(ra) # 7348 <exit>
  }
  fd = open("dirfile/xx", 0);
    4f46:	4581                	li	a1,0
    4f48:	00005517          	auipc	a0,0x5
    4f4c:	88050513          	addi	a0,a0,-1920 # 97c8 <malloc+0x1d50>
    4f50:	00002097          	auipc	ra,0x2
    4f54:	438080e7          	jalr	1080(ra) # 7388 <open>
    4f58:	87aa                	mv	a5,a0
    4f5a:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    4f5e:	fec42783          	lw	a5,-20(s0)
    4f62:	2781                	sext.w	a5,a5
    4f64:	0207c163          	bltz	a5,4f86 <dirfile+0xce>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4f68:	fd843583          	ld	a1,-40(s0)
    4f6c:	00005517          	auipc	a0,0x5
    4f70:	86c50513          	addi	a0,a0,-1940 # 97d8 <malloc+0x1d60>
    4f74:	00003097          	auipc	ra,0x3
    4f78:	912080e7          	jalr	-1774(ra) # 7886 <printf>
    exit(1);
    4f7c:	4505                	li	a0,1
    4f7e:	00002097          	auipc	ra,0x2
    4f82:	3ca080e7          	jalr	970(ra) # 7348 <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    4f86:	20000593          	li	a1,512
    4f8a:	00005517          	auipc	a0,0x5
    4f8e:	83e50513          	addi	a0,a0,-1986 # 97c8 <malloc+0x1d50>
    4f92:	00002097          	auipc	ra,0x2
    4f96:	3f6080e7          	jalr	1014(ra) # 7388 <open>
    4f9a:	87aa                	mv	a5,a0
    4f9c:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    4fa0:	fec42783          	lw	a5,-20(s0)
    4fa4:	2781                	sext.w	a5,a5
    4fa6:	0207c163          	bltz	a5,4fc8 <dirfile+0x110>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4faa:	fd843583          	ld	a1,-40(s0)
    4fae:	00005517          	auipc	a0,0x5
    4fb2:	82a50513          	addi	a0,a0,-2006 # 97d8 <malloc+0x1d60>
    4fb6:	00003097          	auipc	ra,0x3
    4fba:	8d0080e7          	jalr	-1840(ra) # 7886 <printf>
    exit(1);
    4fbe:	4505                	li	a0,1
    4fc0:	00002097          	auipc	ra,0x2
    4fc4:	388080e7          	jalr	904(ra) # 7348 <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    4fc8:	00005517          	auipc	a0,0x5
    4fcc:	80050513          	addi	a0,a0,-2048 # 97c8 <malloc+0x1d50>
    4fd0:	00002097          	auipc	ra,0x2
    4fd4:	3e0080e7          	jalr	992(ra) # 73b0 <mkdir>
    4fd8:	87aa                	mv	a5,a0
    4fda:	e385                	bnez	a5,4ffa <dirfile+0x142>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    4fdc:	fd843583          	ld	a1,-40(s0)
    4fe0:	00005517          	auipc	a0,0x5
    4fe4:	82050513          	addi	a0,a0,-2016 # 9800 <malloc+0x1d88>
    4fe8:	00003097          	auipc	ra,0x3
    4fec:	89e080e7          	jalr	-1890(ra) # 7886 <printf>
    exit(1);
    4ff0:	4505                	li	a0,1
    4ff2:	00002097          	auipc	ra,0x2
    4ff6:	356080e7          	jalr	854(ra) # 7348 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    4ffa:	00004517          	auipc	a0,0x4
    4ffe:	7ce50513          	addi	a0,a0,1998 # 97c8 <malloc+0x1d50>
    5002:	00002097          	auipc	ra,0x2
    5006:	396080e7          	jalr	918(ra) # 7398 <unlink>
    500a:	87aa                	mv	a5,a0
    500c:	e385                	bnez	a5,502c <dirfile+0x174>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    500e:	fd843583          	ld	a1,-40(s0)
    5012:	00005517          	auipc	a0,0x5
    5016:	81650513          	addi	a0,a0,-2026 # 9828 <malloc+0x1db0>
    501a:	00003097          	auipc	ra,0x3
    501e:	86c080e7          	jalr	-1940(ra) # 7886 <printf>
    exit(1);
    5022:	4505                	li	a0,1
    5024:	00002097          	auipc	ra,0x2
    5028:	324080e7          	jalr	804(ra) # 7348 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    502c:	00004597          	auipc	a1,0x4
    5030:	79c58593          	addi	a1,a1,1948 # 97c8 <malloc+0x1d50>
    5034:	00003517          	auipc	a0,0x3
    5038:	fa450513          	addi	a0,a0,-92 # 7fd8 <malloc+0x560>
    503c:	00002097          	auipc	ra,0x2
    5040:	36c080e7          	jalr	876(ra) # 73a8 <link>
    5044:	87aa                	mv	a5,a0
    5046:	e385                	bnez	a5,5066 <dirfile+0x1ae>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    5048:	fd843583          	ld	a1,-40(s0)
    504c:	00005517          	auipc	a0,0x5
    5050:	80450513          	addi	a0,a0,-2044 # 9850 <malloc+0x1dd8>
    5054:	00003097          	auipc	ra,0x3
    5058:	832080e7          	jalr	-1998(ra) # 7886 <printf>
    exit(1);
    505c:	4505                	li	a0,1
    505e:	00002097          	auipc	ra,0x2
    5062:	2ea080e7          	jalr	746(ra) # 7348 <exit>
  }
  if(unlink("dirfile") != 0){
    5066:	00003517          	auipc	a0,0x3
    506a:	e8a50513          	addi	a0,a0,-374 # 7ef0 <malloc+0x478>
    506e:	00002097          	auipc	ra,0x2
    5072:	32a080e7          	jalr	810(ra) # 7398 <unlink>
    5076:	87aa                	mv	a5,a0
    5078:	c385                	beqz	a5,5098 <dirfile+0x1e0>
    printf("%s: unlink dirfile failed!\n", s);
    507a:	fd843583          	ld	a1,-40(s0)
    507e:	00004517          	auipc	a0,0x4
    5082:	7fa50513          	addi	a0,a0,2042 # 9878 <malloc+0x1e00>
    5086:	00003097          	auipc	ra,0x3
    508a:	800080e7          	jalr	-2048(ra) # 7886 <printf>
    exit(1);
    508e:	4505                	li	a0,1
    5090:	00002097          	auipc	ra,0x2
    5094:	2b8080e7          	jalr	696(ra) # 7348 <exit>
  }

  fd = open(".", O_RDWR);
    5098:	4589                	li	a1,2
    509a:	00004517          	auipc	a0,0x4
    509e:	bfe50513          	addi	a0,a0,-1026 # 8c98 <malloc+0x1220>
    50a2:	00002097          	auipc	ra,0x2
    50a6:	2e6080e7          	jalr	742(ra) # 7388 <open>
    50aa:	87aa                	mv	a5,a0
    50ac:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    50b0:	fec42783          	lw	a5,-20(s0)
    50b4:	2781                	sext.w	a5,a5
    50b6:	0207c163          	bltz	a5,50d8 <dirfile+0x220>
    printf("%s: open . for writing succeeded!\n", s);
    50ba:	fd843583          	ld	a1,-40(s0)
    50be:	00004517          	auipc	a0,0x4
    50c2:	7da50513          	addi	a0,a0,2010 # 9898 <malloc+0x1e20>
    50c6:	00002097          	auipc	ra,0x2
    50ca:	7c0080e7          	jalr	1984(ra) # 7886 <printf>
    exit(1);
    50ce:	4505                	li	a0,1
    50d0:	00002097          	auipc	ra,0x2
    50d4:	278080e7          	jalr	632(ra) # 7348 <exit>
  }
  fd = open(".", 0);
    50d8:	4581                	li	a1,0
    50da:	00004517          	auipc	a0,0x4
    50de:	bbe50513          	addi	a0,a0,-1090 # 8c98 <malloc+0x1220>
    50e2:	00002097          	auipc	ra,0x2
    50e6:	2a6080e7          	jalr	678(ra) # 7388 <open>
    50ea:	87aa                	mv	a5,a0
    50ec:	fef42623          	sw	a5,-20(s0)
  if(write(fd, "x", 1) > 0){
    50f0:	fec42783          	lw	a5,-20(s0)
    50f4:	4605                	li	a2,1
    50f6:	00003597          	auipc	a1,0x3
    50fa:	f3258593          	addi	a1,a1,-206 # 8028 <malloc+0x5b0>
    50fe:	853e                	mv	a0,a5
    5100:	00002097          	auipc	ra,0x2
    5104:	268080e7          	jalr	616(ra) # 7368 <write>
    5108:	87aa                	mv	a5,a0
    510a:	02f05163          	blez	a5,512c <dirfile+0x274>
    printf("%s: write . succeeded!\n", s);
    510e:	fd843583          	ld	a1,-40(s0)
    5112:	00004517          	auipc	a0,0x4
    5116:	7ae50513          	addi	a0,a0,1966 # 98c0 <malloc+0x1e48>
    511a:	00002097          	auipc	ra,0x2
    511e:	76c080e7          	jalr	1900(ra) # 7886 <printf>
    exit(1);
    5122:	4505                	li	a0,1
    5124:	00002097          	auipc	ra,0x2
    5128:	224080e7          	jalr	548(ra) # 7348 <exit>
  }
  close(fd);
    512c:	fec42783          	lw	a5,-20(s0)
    5130:	853e                	mv	a0,a5
    5132:	00002097          	auipc	ra,0x2
    5136:	23e080e7          	jalr	574(ra) # 7370 <close>
}
    513a:	0001                	nop
    513c:	70a2                	ld	ra,40(sp)
    513e:	7402                	ld	s0,32(sp)
    5140:	6145                	addi	sp,sp,48
    5142:	8082                	ret

0000000000005144 <iref>:

// test that iput() is called at the end of _namei().
// also tests empty file names.
void
iref(char *s)
{
    5144:	7179                	addi	sp,sp,-48
    5146:	f406                	sd	ra,40(sp)
    5148:	f022                	sd	s0,32(sp)
    514a:	1800                	addi	s0,sp,48
    514c:	fca43c23          	sd	a0,-40(s0)
  int i, fd;

  for(i = 0; i < NINODE + 1; i++){
    5150:	fe042623          	sw	zero,-20(s0)
    5154:	a231                	j	5260 <iref+0x11c>
    if(mkdir("irefd") != 0){
    5156:	00004517          	auipc	a0,0x4
    515a:	78250513          	addi	a0,a0,1922 # 98d8 <malloc+0x1e60>
    515e:	00002097          	auipc	ra,0x2
    5162:	252080e7          	jalr	594(ra) # 73b0 <mkdir>
    5166:	87aa                	mv	a5,a0
    5168:	c385                	beqz	a5,5188 <iref+0x44>
      printf("%s: mkdir irefd failed\n", s);
    516a:	fd843583          	ld	a1,-40(s0)
    516e:	00004517          	auipc	a0,0x4
    5172:	77250513          	addi	a0,a0,1906 # 98e0 <malloc+0x1e68>
    5176:	00002097          	auipc	ra,0x2
    517a:	710080e7          	jalr	1808(ra) # 7886 <printf>
      exit(1);
    517e:	4505                	li	a0,1
    5180:	00002097          	auipc	ra,0x2
    5184:	1c8080e7          	jalr	456(ra) # 7348 <exit>
    }
    if(chdir("irefd") != 0){
    5188:	00004517          	auipc	a0,0x4
    518c:	75050513          	addi	a0,a0,1872 # 98d8 <malloc+0x1e60>
    5190:	00002097          	auipc	ra,0x2
    5194:	228080e7          	jalr	552(ra) # 73b8 <chdir>
    5198:	87aa                	mv	a5,a0
    519a:	c385                	beqz	a5,51ba <iref+0x76>
      printf("%s: chdir irefd failed\n", s);
    519c:	fd843583          	ld	a1,-40(s0)
    51a0:	00004517          	auipc	a0,0x4
    51a4:	75850513          	addi	a0,a0,1880 # 98f8 <malloc+0x1e80>
    51a8:	00002097          	auipc	ra,0x2
    51ac:	6de080e7          	jalr	1758(ra) # 7886 <printf>
      exit(1);
    51b0:	4505                	li	a0,1
    51b2:	00002097          	auipc	ra,0x2
    51b6:	196080e7          	jalr	406(ra) # 7348 <exit>
    }

    mkdir("");
    51ba:	00004517          	auipc	a0,0x4
    51be:	75650513          	addi	a0,a0,1878 # 9910 <malloc+0x1e98>
    51c2:	00002097          	auipc	ra,0x2
    51c6:	1ee080e7          	jalr	494(ra) # 73b0 <mkdir>
    link("README", "");
    51ca:	00004597          	auipc	a1,0x4
    51ce:	74658593          	addi	a1,a1,1862 # 9910 <malloc+0x1e98>
    51d2:	00003517          	auipc	a0,0x3
    51d6:	e0650513          	addi	a0,a0,-506 # 7fd8 <malloc+0x560>
    51da:	00002097          	auipc	ra,0x2
    51de:	1ce080e7          	jalr	462(ra) # 73a8 <link>
    fd = open("", O_CREATE);
    51e2:	20000593          	li	a1,512
    51e6:	00004517          	auipc	a0,0x4
    51ea:	72a50513          	addi	a0,a0,1834 # 9910 <malloc+0x1e98>
    51ee:	00002097          	auipc	ra,0x2
    51f2:	19a080e7          	jalr	410(ra) # 7388 <open>
    51f6:	87aa                	mv	a5,a0
    51f8:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0)
    51fc:	fe842783          	lw	a5,-24(s0)
    5200:	2781                	sext.w	a5,a5
    5202:	0007c963          	bltz	a5,5214 <iref+0xd0>
      close(fd);
    5206:	fe842783          	lw	a5,-24(s0)
    520a:	853e                	mv	a0,a5
    520c:	00002097          	auipc	ra,0x2
    5210:	164080e7          	jalr	356(ra) # 7370 <close>
    fd = open("xx", O_CREATE);
    5214:	20000593          	li	a1,512
    5218:	00003517          	auipc	a0,0x3
    521c:	ee850513          	addi	a0,a0,-280 # 8100 <malloc+0x688>
    5220:	00002097          	auipc	ra,0x2
    5224:	168080e7          	jalr	360(ra) # 7388 <open>
    5228:	87aa                	mv	a5,a0
    522a:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0)
    522e:	fe842783          	lw	a5,-24(s0)
    5232:	2781                	sext.w	a5,a5
    5234:	0007c963          	bltz	a5,5246 <iref+0x102>
      close(fd);
    5238:	fe842783          	lw	a5,-24(s0)
    523c:	853e                	mv	a0,a5
    523e:	00002097          	auipc	ra,0x2
    5242:	132080e7          	jalr	306(ra) # 7370 <close>
    unlink("xx");
    5246:	00003517          	auipc	a0,0x3
    524a:	eba50513          	addi	a0,a0,-326 # 8100 <malloc+0x688>
    524e:	00002097          	auipc	ra,0x2
    5252:	14a080e7          	jalr	330(ra) # 7398 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    5256:	fec42783          	lw	a5,-20(s0)
    525a:	2785                	addiw	a5,a5,1
    525c:	fef42623          	sw	a5,-20(s0)
    5260:	fec42783          	lw	a5,-20(s0)
    5264:	0007871b          	sext.w	a4,a5
    5268:	03200793          	li	a5,50
    526c:	eee7d5e3          	bge	a5,a4,5156 <iref+0x12>
  }

  // clean up
  for(i = 0; i < NINODE + 1; i++){
    5270:	fe042623          	sw	zero,-20(s0)
    5274:	a035                	j	52a0 <iref+0x15c>
    chdir("..");
    5276:	00003517          	auipc	a0,0x3
    527a:	4ba50513          	addi	a0,a0,1210 # 8730 <malloc+0xcb8>
    527e:	00002097          	auipc	ra,0x2
    5282:	13a080e7          	jalr	314(ra) # 73b8 <chdir>
    unlink("irefd");
    5286:	00004517          	auipc	a0,0x4
    528a:	65250513          	addi	a0,a0,1618 # 98d8 <malloc+0x1e60>
    528e:	00002097          	auipc	ra,0x2
    5292:	10a080e7          	jalr	266(ra) # 7398 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    5296:	fec42783          	lw	a5,-20(s0)
    529a:	2785                	addiw	a5,a5,1
    529c:	fef42623          	sw	a5,-20(s0)
    52a0:	fec42783          	lw	a5,-20(s0)
    52a4:	0007871b          	sext.w	a4,a5
    52a8:	03200793          	li	a5,50
    52ac:	fce7d5e3          	bge	a5,a4,5276 <iref+0x132>
  }

  chdir("/");
    52b0:	00003517          	auipc	a0,0x3
    52b4:	19850513          	addi	a0,a0,408 # 8448 <malloc+0x9d0>
    52b8:	00002097          	auipc	ra,0x2
    52bc:	100080e7          	jalr	256(ra) # 73b8 <chdir>
}
    52c0:	0001                	nop
    52c2:	70a2                	ld	ra,40(sp)
    52c4:	7402                	ld	s0,32(sp)
    52c6:	6145                	addi	sp,sp,48
    52c8:	8082                	ret

00000000000052ca <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(char *s)
{
    52ca:	7179                	addi	sp,sp,-48
    52cc:	f406                	sd	ra,40(sp)
    52ce:	f022                	sd	s0,32(sp)
    52d0:	1800                	addi	s0,sp,48
    52d2:	fca43c23          	sd	a0,-40(s0)
  enum{ N = 1000 };
  int n, pid;

  for(n=0; n<N; n++){
    52d6:	fe042623          	sw	zero,-20(s0)
    52da:	a81d                	j	5310 <forktest+0x46>
    pid = fork();
    52dc:	00002097          	auipc	ra,0x2
    52e0:	064080e7          	jalr	100(ra) # 7340 <fork>
    52e4:	87aa                	mv	a5,a0
    52e6:	fef42423          	sw	a5,-24(s0)
    if(pid < 0)
    52ea:	fe842783          	lw	a5,-24(s0)
    52ee:	2781                	sext.w	a5,a5
    52f0:	0207c963          	bltz	a5,5322 <forktest+0x58>
      break;
    if(pid == 0)
    52f4:	fe842783          	lw	a5,-24(s0)
    52f8:	2781                	sext.w	a5,a5
    52fa:	e791                	bnez	a5,5306 <forktest+0x3c>
      exit(0);
    52fc:	4501                	li	a0,0
    52fe:	00002097          	auipc	ra,0x2
    5302:	04a080e7          	jalr	74(ra) # 7348 <exit>
  for(n=0; n<N; n++){
    5306:	fec42783          	lw	a5,-20(s0)
    530a:	2785                	addiw	a5,a5,1
    530c:	fef42623          	sw	a5,-20(s0)
    5310:	fec42783          	lw	a5,-20(s0)
    5314:	0007871b          	sext.w	a4,a5
    5318:	3e700793          	li	a5,999
    531c:	fce7d0e3          	bge	a5,a4,52dc <forktest+0x12>
    5320:	a011                	j	5324 <forktest+0x5a>
      break;
    5322:	0001                	nop
  }

  if (n == 0) {
    5324:	fec42783          	lw	a5,-20(s0)
    5328:	2781                	sext.w	a5,a5
    532a:	e385                	bnez	a5,534a <forktest+0x80>
    printf("%s: no fork at all!\n", s);
    532c:	fd843583          	ld	a1,-40(s0)
    5330:	00004517          	auipc	a0,0x4
    5334:	5e850513          	addi	a0,a0,1512 # 9918 <malloc+0x1ea0>
    5338:	00002097          	auipc	ra,0x2
    533c:	54e080e7          	jalr	1358(ra) # 7886 <printf>
    exit(1);
    5340:	4505                	li	a0,1
    5342:	00002097          	auipc	ra,0x2
    5346:	006080e7          	jalr	6(ra) # 7348 <exit>
  }

  if(n == N){
    534a:	fec42783          	lw	a5,-20(s0)
    534e:	0007871b          	sext.w	a4,a5
    5352:	3e800793          	li	a5,1000
    5356:	04f71d63          	bne	a4,a5,53b0 <forktest+0xe6>
    printf("%s: fork claimed to work 1000 times!\n", s);
    535a:	fd843583          	ld	a1,-40(s0)
    535e:	00004517          	auipc	a0,0x4
    5362:	5d250513          	addi	a0,a0,1490 # 9930 <malloc+0x1eb8>
    5366:	00002097          	auipc	ra,0x2
    536a:	520080e7          	jalr	1312(ra) # 7886 <printf>
    exit(1);
    536e:	4505                	li	a0,1
    5370:	00002097          	auipc	ra,0x2
    5374:	fd8080e7          	jalr	-40(ra) # 7348 <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
    5378:	4501                	li	a0,0
    537a:	00002097          	auipc	ra,0x2
    537e:	fd6080e7          	jalr	-42(ra) # 7350 <wait>
    5382:	87aa                	mv	a5,a0
    5384:	0207d163          	bgez	a5,53a6 <forktest+0xdc>
      printf("%s: wait stopped early\n", s);
    5388:	fd843583          	ld	a1,-40(s0)
    538c:	00004517          	auipc	a0,0x4
    5390:	5cc50513          	addi	a0,a0,1484 # 9958 <malloc+0x1ee0>
    5394:	00002097          	auipc	ra,0x2
    5398:	4f2080e7          	jalr	1266(ra) # 7886 <printf>
      exit(1);
    539c:	4505                	li	a0,1
    539e:	00002097          	auipc	ra,0x2
    53a2:	faa080e7          	jalr	-86(ra) # 7348 <exit>
  for(; n > 0; n--){
    53a6:	fec42783          	lw	a5,-20(s0)
    53aa:	37fd                	addiw	a5,a5,-1
    53ac:	fef42623          	sw	a5,-20(s0)
    53b0:	fec42783          	lw	a5,-20(s0)
    53b4:	2781                	sext.w	a5,a5
    53b6:	fcf041e3          	bgtz	a5,5378 <forktest+0xae>
    }
  }

  if(wait(0) != -1){
    53ba:	4501                	li	a0,0
    53bc:	00002097          	auipc	ra,0x2
    53c0:	f94080e7          	jalr	-108(ra) # 7350 <wait>
    53c4:	87aa                	mv	a5,a0
    53c6:	873e                	mv	a4,a5
    53c8:	57fd                	li	a5,-1
    53ca:	02f70163          	beq	a4,a5,53ec <forktest+0x122>
    printf("%s: wait got too many\n", s);
    53ce:	fd843583          	ld	a1,-40(s0)
    53d2:	00004517          	auipc	a0,0x4
    53d6:	59e50513          	addi	a0,a0,1438 # 9970 <malloc+0x1ef8>
    53da:	00002097          	auipc	ra,0x2
    53de:	4ac080e7          	jalr	1196(ra) # 7886 <printf>
    exit(1);
    53e2:	4505                	li	a0,1
    53e4:	00002097          	auipc	ra,0x2
    53e8:	f64080e7          	jalr	-156(ra) # 7348 <exit>
  }
}
    53ec:	0001                	nop
    53ee:	70a2                	ld	ra,40(sp)
    53f0:	7402                	ld	s0,32(sp)
    53f2:	6145                	addi	sp,sp,48
    53f4:	8082                	ret

00000000000053f6 <sbrkbasic>:

void
sbrkbasic(char *s)
{
    53f6:	715d                	addi	sp,sp,-80
    53f8:	e486                	sd	ra,72(sp)
    53fa:	e0a2                	sd	s0,64(sp)
    53fc:	0880                	addi	s0,sp,80
    53fe:	faa43c23          	sd	a0,-72(s0)
  enum { TOOMUCH=1024*1024*1024};
  int i, pid, xstatus;
  char *c, *a, *b;

  // does sbrk() return the expected failure value?
  pid = fork();
    5402:	00002097          	auipc	ra,0x2
    5406:	f3e080e7          	jalr	-194(ra) # 7340 <fork>
    540a:	87aa                	mv	a5,a0
    540c:	fcf42a23          	sw	a5,-44(s0)
  if(pid < 0){
    5410:	fd442783          	lw	a5,-44(s0)
    5414:	2781                	sext.w	a5,a5
    5416:	0007df63          	bgez	a5,5434 <sbrkbasic+0x3e>
    printf("fork failed in sbrkbasic\n");
    541a:	00004517          	auipc	a0,0x4
    541e:	56e50513          	addi	a0,a0,1390 # 9988 <malloc+0x1f10>
    5422:	00002097          	auipc	ra,0x2
    5426:	464080e7          	jalr	1124(ra) # 7886 <printf>
    exit(1);
    542a:	4505                	li	a0,1
    542c:	00002097          	auipc	ra,0x2
    5430:	f1c080e7          	jalr	-228(ra) # 7348 <exit>
  }
  if(pid == 0){
    5434:	fd442783          	lw	a5,-44(s0)
    5438:	2781                	sext.w	a5,a5
    543a:	e3b5                	bnez	a5,549e <sbrkbasic+0xa8>
    a = sbrk(TOOMUCH);
    543c:	40000537          	lui	a0,0x40000
    5440:	00002097          	auipc	ra,0x2
    5444:	f90080e7          	jalr	-112(ra) # 73d0 <sbrk>
    5448:	fea43023          	sd	a0,-32(s0)
    if(a == (char*)0xffffffffffffffffL){
    544c:	fe043703          	ld	a4,-32(s0)
    5450:	57fd                	li	a5,-1
    5452:	00f71763          	bne	a4,a5,5460 <sbrkbasic+0x6a>
      // it's OK if this fails.
      exit(0);
    5456:	4501                	li	a0,0
    5458:	00002097          	auipc	ra,0x2
    545c:	ef0080e7          	jalr	-272(ra) # 7348 <exit>
    }
    
    for(b = a; b < a+TOOMUCH; b += 4096){
    5460:	fe043783          	ld	a5,-32(s0)
    5464:	fcf43c23          	sd	a5,-40(s0)
    5468:	a829                	j	5482 <sbrkbasic+0x8c>
      *b = 99;
    546a:	fd843783          	ld	a5,-40(s0)
    546e:	06300713          	li	a4,99
    5472:	00e78023          	sb	a4,0(a5)
    for(b = a; b < a+TOOMUCH; b += 4096){
    5476:	fd843703          	ld	a4,-40(s0)
    547a:	6785                	lui	a5,0x1
    547c:	97ba                	add	a5,a5,a4
    547e:	fcf43c23          	sd	a5,-40(s0)
    5482:	fe043703          	ld	a4,-32(s0)
    5486:	400007b7          	lui	a5,0x40000
    548a:	97ba                	add	a5,a5,a4
    548c:	fd843703          	ld	a4,-40(s0)
    5490:	fcf76de3          	bltu	a4,a5,546a <sbrkbasic+0x74>
    }
    
    // we should not get here! either sbrk(TOOMUCH)
    // should have failed, or (with lazy allocation)
    // a pagefault should have killed this process.
    exit(1);
    5494:	4505                	li	a0,1
    5496:	00002097          	auipc	ra,0x2
    549a:	eb2080e7          	jalr	-334(ra) # 7348 <exit>
  }

  wait(&xstatus);
    549e:	fc440793          	addi	a5,s0,-60
    54a2:	853e                	mv	a0,a5
    54a4:	00002097          	auipc	ra,0x2
    54a8:	eac080e7          	jalr	-340(ra) # 7350 <wait>
  if(xstatus == 1){
    54ac:	fc442783          	lw	a5,-60(s0)
    54b0:	873e                	mv	a4,a5
    54b2:	4785                	li	a5,1
    54b4:	02f71163          	bne	a4,a5,54d6 <sbrkbasic+0xe0>
    printf("%s: too much memory allocated!\n", s);
    54b8:	fb843583          	ld	a1,-72(s0)
    54bc:	00004517          	auipc	a0,0x4
    54c0:	4ec50513          	addi	a0,a0,1260 # 99a8 <malloc+0x1f30>
    54c4:	00002097          	auipc	ra,0x2
    54c8:	3c2080e7          	jalr	962(ra) # 7886 <printf>
    exit(1);
    54cc:	4505                	li	a0,1
    54ce:	00002097          	auipc	ra,0x2
    54d2:	e7a080e7          	jalr	-390(ra) # 7348 <exit>
  }

  // can one sbrk() less than a page?
  a = sbrk(0);
    54d6:	4501                	li	a0,0
    54d8:	00002097          	auipc	ra,0x2
    54dc:	ef8080e7          	jalr	-264(ra) # 73d0 <sbrk>
    54e0:	fea43023          	sd	a0,-32(s0)
  for(i = 0; i < 5000; i++){
    54e4:	fe042623          	sw	zero,-20(s0)
    54e8:	a09d                	j	554e <sbrkbasic+0x158>
    b = sbrk(1);
    54ea:	4505                	li	a0,1
    54ec:	00002097          	auipc	ra,0x2
    54f0:	ee4080e7          	jalr	-284(ra) # 73d0 <sbrk>
    54f4:	fca43c23          	sd	a0,-40(s0)
    if(b != a){
    54f8:	fd843703          	ld	a4,-40(s0)
    54fc:	fe043783          	ld	a5,-32(s0)
    5500:	02f70863          	beq	a4,a5,5530 <sbrkbasic+0x13a>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    5504:	fec42783          	lw	a5,-20(s0)
    5508:	fd843703          	ld	a4,-40(s0)
    550c:	fe043683          	ld	a3,-32(s0)
    5510:	863e                	mv	a2,a5
    5512:	fb843583          	ld	a1,-72(s0)
    5516:	00004517          	auipc	a0,0x4
    551a:	4b250513          	addi	a0,a0,1202 # 99c8 <malloc+0x1f50>
    551e:	00002097          	auipc	ra,0x2
    5522:	368080e7          	jalr	872(ra) # 7886 <printf>
      exit(1);
    5526:	4505                	li	a0,1
    5528:	00002097          	auipc	ra,0x2
    552c:	e20080e7          	jalr	-480(ra) # 7348 <exit>
    }
    *b = 1;
    5530:	fd843783          	ld	a5,-40(s0)
    5534:	4705                	li	a4,1
    5536:	00e78023          	sb	a4,0(a5) # 40000000 <__BSS_END__+0x3ffef3c0>
    a = b + 1;
    553a:	fd843783          	ld	a5,-40(s0)
    553e:	0785                	addi	a5,a5,1
    5540:	fef43023          	sd	a5,-32(s0)
  for(i = 0; i < 5000; i++){
    5544:	fec42783          	lw	a5,-20(s0)
    5548:	2785                	addiw	a5,a5,1
    554a:	fef42623          	sw	a5,-20(s0)
    554e:	fec42783          	lw	a5,-20(s0)
    5552:	0007871b          	sext.w	a4,a5
    5556:	6785                	lui	a5,0x1
    5558:	38778793          	addi	a5,a5,903 # 1387 <openiputtest+0xe1>
    555c:	f8e7d7e3          	bge	a5,a4,54ea <sbrkbasic+0xf4>
  }
  pid = fork();
    5560:	00002097          	auipc	ra,0x2
    5564:	de0080e7          	jalr	-544(ra) # 7340 <fork>
    5568:	87aa                	mv	a5,a0
    556a:	fcf42a23          	sw	a5,-44(s0)
  if(pid < 0){
    556e:	fd442783          	lw	a5,-44(s0)
    5572:	2781                	sext.w	a5,a5
    5574:	0207d163          	bgez	a5,5596 <sbrkbasic+0x1a0>
    printf("%s: sbrk test fork failed\n", s);
    5578:	fb843583          	ld	a1,-72(s0)
    557c:	00004517          	auipc	a0,0x4
    5580:	46c50513          	addi	a0,a0,1132 # 99e8 <malloc+0x1f70>
    5584:	00002097          	auipc	ra,0x2
    5588:	302080e7          	jalr	770(ra) # 7886 <printf>
    exit(1);
    558c:	4505                	li	a0,1
    558e:	00002097          	auipc	ra,0x2
    5592:	dba080e7          	jalr	-582(ra) # 7348 <exit>
  }
  c = sbrk(1);
    5596:	4505                	li	a0,1
    5598:	00002097          	auipc	ra,0x2
    559c:	e38080e7          	jalr	-456(ra) # 73d0 <sbrk>
    55a0:	fca43423          	sd	a0,-56(s0)
  c = sbrk(1);
    55a4:	4505                	li	a0,1
    55a6:	00002097          	auipc	ra,0x2
    55aa:	e2a080e7          	jalr	-470(ra) # 73d0 <sbrk>
    55ae:	fca43423          	sd	a0,-56(s0)
  if(c != a + 1){
    55b2:	fe043783          	ld	a5,-32(s0)
    55b6:	0785                	addi	a5,a5,1
    55b8:	fc843703          	ld	a4,-56(s0)
    55bc:	02f70163          	beq	a4,a5,55de <sbrkbasic+0x1e8>
    printf("%s: sbrk test failed post-fork\n", s);
    55c0:	fb843583          	ld	a1,-72(s0)
    55c4:	00004517          	auipc	a0,0x4
    55c8:	44450513          	addi	a0,a0,1092 # 9a08 <malloc+0x1f90>
    55cc:	00002097          	auipc	ra,0x2
    55d0:	2ba080e7          	jalr	698(ra) # 7886 <printf>
    exit(1);
    55d4:	4505                	li	a0,1
    55d6:	00002097          	auipc	ra,0x2
    55da:	d72080e7          	jalr	-654(ra) # 7348 <exit>
  }
  if(pid == 0)
    55de:	fd442783          	lw	a5,-44(s0)
    55e2:	2781                	sext.w	a5,a5
    55e4:	e791                	bnez	a5,55f0 <sbrkbasic+0x1fa>
    exit(0);
    55e6:	4501                	li	a0,0
    55e8:	00002097          	auipc	ra,0x2
    55ec:	d60080e7          	jalr	-672(ra) # 7348 <exit>
  wait(&xstatus);
    55f0:	fc440793          	addi	a5,s0,-60
    55f4:	853e                	mv	a0,a5
    55f6:	00002097          	auipc	ra,0x2
    55fa:	d5a080e7          	jalr	-678(ra) # 7350 <wait>
  exit(xstatus);
    55fe:	fc442783          	lw	a5,-60(s0)
    5602:	853e                	mv	a0,a5
    5604:	00002097          	auipc	ra,0x2
    5608:	d44080e7          	jalr	-700(ra) # 7348 <exit>

000000000000560c <sbrkmuch>:
}

void
sbrkmuch(char *s)
{
    560c:	711d                	addi	sp,sp,-96
    560e:	ec86                	sd	ra,88(sp)
    5610:	e8a2                	sd	s0,80(sp)
    5612:	1080                	addi	s0,sp,96
    5614:	faa43423          	sd	a0,-88(s0)
  enum { BIG=100*1024*1024 };
  char *c, *oldbrk, *a, *lastaddr, *p;
  uint64 amt;

  oldbrk = sbrk(0);
    5618:	4501                	li	a0,0
    561a:	00002097          	auipc	ra,0x2
    561e:	db6080e7          	jalr	-586(ra) # 73d0 <sbrk>
    5622:	fea43023          	sd	a0,-32(s0)

  // can one grow address space to something big?
  a = sbrk(0);
    5626:	4501                	li	a0,0
    5628:	00002097          	auipc	ra,0x2
    562c:	da8080e7          	jalr	-600(ra) # 73d0 <sbrk>
    5630:	fca43c23          	sd	a0,-40(s0)
  amt = BIG - (uint64)a;
    5634:	fd843783          	ld	a5,-40(s0)
    5638:	06400737          	lui	a4,0x6400
    563c:	40f707b3          	sub	a5,a4,a5
    5640:	fcf43823          	sd	a5,-48(s0)
  p = sbrk(amt);
    5644:	fd043783          	ld	a5,-48(s0)
    5648:	2781                	sext.w	a5,a5
    564a:	853e                	mv	a0,a5
    564c:	00002097          	auipc	ra,0x2
    5650:	d84080e7          	jalr	-636(ra) # 73d0 <sbrk>
    5654:	fca43423          	sd	a0,-56(s0)
  if (p != a) {
    5658:	fc843703          	ld	a4,-56(s0)
    565c:	fd843783          	ld	a5,-40(s0)
    5660:	02f70163          	beq	a4,a5,5682 <sbrkmuch+0x76>
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    5664:	fa843583          	ld	a1,-88(s0)
    5668:	00004517          	auipc	a0,0x4
    566c:	3c050513          	addi	a0,a0,960 # 9a28 <malloc+0x1fb0>
    5670:	00002097          	auipc	ra,0x2
    5674:	216080e7          	jalr	534(ra) # 7886 <printf>
    exit(1);
    5678:	4505                	li	a0,1
    567a:	00002097          	auipc	ra,0x2
    567e:	cce080e7          	jalr	-818(ra) # 7348 <exit>
  }

  // touch each page to make sure it exists.
  char *eee = sbrk(0);
    5682:	4501                	li	a0,0
    5684:	00002097          	auipc	ra,0x2
    5688:	d4c080e7          	jalr	-692(ra) # 73d0 <sbrk>
    568c:	fca43023          	sd	a0,-64(s0)
  for(char *pp = a; pp < eee; pp += 4096)
    5690:	fd843783          	ld	a5,-40(s0)
    5694:	fef43423          	sd	a5,-24(s0)
    5698:	a821                	j	56b0 <sbrkmuch+0xa4>
    *pp = 1;
    569a:	fe843783          	ld	a5,-24(s0)
    569e:	4705                	li	a4,1
    56a0:	00e78023          	sb	a4,0(a5)
  for(char *pp = a; pp < eee; pp += 4096)
    56a4:	fe843703          	ld	a4,-24(s0)
    56a8:	6785                	lui	a5,0x1
    56aa:	97ba                	add	a5,a5,a4
    56ac:	fef43423          	sd	a5,-24(s0)
    56b0:	fe843703          	ld	a4,-24(s0)
    56b4:	fc043783          	ld	a5,-64(s0)
    56b8:	fef761e3          	bltu	a4,a5,569a <sbrkmuch+0x8e>

  lastaddr = (char*) (BIG-1);
    56bc:	064007b7          	lui	a5,0x6400
    56c0:	17fd                	addi	a5,a5,-1
    56c2:	faf43c23          	sd	a5,-72(s0)
  *lastaddr = 99;
    56c6:	fb843783          	ld	a5,-72(s0)
    56ca:	06300713          	li	a4,99
    56ce:	00e78023          	sb	a4,0(a5) # 6400000 <__BSS_END__+0x63ef3c0>

  // can one de-allocate?
  a = sbrk(0);
    56d2:	4501                	li	a0,0
    56d4:	00002097          	auipc	ra,0x2
    56d8:	cfc080e7          	jalr	-772(ra) # 73d0 <sbrk>
    56dc:	fca43c23          	sd	a0,-40(s0)
  c = sbrk(-PGSIZE);
    56e0:	757d                	lui	a0,0xfffff
    56e2:	00002097          	auipc	ra,0x2
    56e6:	cee080e7          	jalr	-786(ra) # 73d0 <sbrk>
    56ea:	faa43823          	sd	a0,-80(s0)
  if(c == (char*)0xffffffffffffffffL){
    56ee:	fb043703          	ld	a4,-80(s0)
    56f2:	57fd                	li	a5,-1
    56f4:	02f71163          	bne	a4,a5,5716 <sbrkmuch+0x10a>
    printf("%s: sbrk could not deallocate\n", s);
    56f8:	fa843583          	ld	a1,-88(s0)
    56fc:	00004517          	auipc	a0,0x4
    5700:	37450513          	addi	a0,a0,884 # 9a70 <malloc+0x1ff8>
    5704:	00002097          	auipc	ra,0x2
    5708:	182080e7          	jalr	386(ra) # 7886 <printf>
    exit(1);
    570c:	4505                	li	a0,1
    570e:	00002097          	auipc	ra,0x2
    5712:	c3a080e7          	jalr	-966(ra) # 7348 <exit>
  }
  c = sbrk(0);
    5716:	4501                	li	a0,0
    5718:	00002097          	auipc	ra,0x2
    571c:	cb8080e7          	jalr	-840(ra) # 73d0 <sbrk>
    5720:	faa43823          	sd	a0,-80(s0)
  if(c != a - PGSIZE){
    5724:	fd843703          	ld	a4,-40(s0)
    5728:	77fd                	lui	a5,0xfffff
    572a:	97ba                	add	a5,a5,a4
    572c:	fb043703          	ld	a4,-80(s0)
    5730:	02f70563          	beq	a4,a5,575a <sbrkmuch+0x14e>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    5734:	fb043683          	ld	a3,-80(s0)
    5738:	fd843603          	ld	a2,-40(s0)
    573c:	fa843583          	ld	a1,-88(s0)
    5740:	00004517          	auipc	a0,0x4
    5744:	35050513          	addi	a0,a0,848 # 9a90 <malloc+0x2018>
    5748:	00002097          	auipc	ra,0x2
    574c:	13e080e7          	jalr	318(ra) # 7886 <printf>
    exit(1);
    5750:	4505                	li	a0,1
    5752:	00002097          	auipc	ra,0x2
    5756:	bf6080e7          	jalr	-1034(ra) # 7348 <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    575a:	4501                	li	a0,0
    575c:	00002097          	auipc	ra,0x2
    5760:	c74080e7          	jalr	-908(ra) # 73d0 <sbrk>
    5764:	fca43c23          	sd	a0,-40(s0)
  c = sbrk(PGSIZE);
    5768:	6505                	lui	a0,0x1
    576a:	00002097          	auipc	ra,0x2
    576e:	c66080e7          	jalr	-922(ra) # 73d0 <sbrk>
    5772:	faa43823          	sd	a0,-80(s0)
  if(c != a || sbrk(0) != a + PGSIZE){
    5776:	fb043703          	ld	a4,-80(s0)
    577a:	fd843783          	ld	a5,-40(s0)
    577e:	00f71e63          	bne	a4,a5,579a <sbrkmuch+0x18e>
    5782:	4501                	li	a0,0
    5784:	00002097          	auipc	ra,0x2
    5788:	c4c080e7          	jalr	-948(ra) # 73d0 <sbrk>
    578c:	86aa                	mv	a3,a0
    578e:	fd843703          	ld	a4,-40(s0)
    5792:	6785                	lui	a5,0x1
    5794:	97ba                	add	a5,a5,a4
    5796:	02f68563          	beq	a3,a5,57c0 <sbrkmuch+0x1b4>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    579a:	fb043683          	ld	a3,-80(s0)
    579e:	fd843603          	ld	a2,-40(s0)
    57a2:	fa843583          	ld	a1,-88(s0)
    57a6:	00004517          	auipc	a0,0x4
    57aa:	32a50513          	addi	a0,a0,810 # 9ad0 <malloc+0x2058>
    57ae:	00002097          	auipc	ra,0x2
    57b2:	0d8080e7          	jalr	216(ra) # 7886 <printf>
    exit(1);
    57b6:	4505                	li	a0,1
    57b8:	00002097          	auipc	ra,0x2
    57bc:	b90080e7          	jalr	-1136(ra) # 7348 <exit>
  }
  if(*lastaddr == 99){
    57c0:	fb843783          	ld	a5,-72(s0)
    57c4:	0007c783          	lbu	a5,0(a5) # 1000 <truncate3+0x1aa>
    57c8:	873e                	mv	a4,a5
    57ca:	06300793          	li	a5,99
    57ce:	02f71163          	bne	a4,a5,57f0 <sbrkmuch+0x1e4>
    // should be zero
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    57d2:	fa843583          	ld	a1,-88(s0)
    57d6:	00004517          	auipc	a0,0x4
    57da:	32a50513          	addi	a0,a0,810 # 9b00 <malloc+0x2088>
    57de:	00002097          	auipc	ra,0x2
    57e2:	0a8080e7          	jalr	168(ra) # 7886 <printf>
    exit(1);
    57e6:	4505                	li	a0,1
    57e8:	00002097          	auipc	ra,0x2
    57ec:	b60080e7          	jalr	-1184(ra) # 7348 <exit>
  }

  a = sbrk(0);
    57f0:	4501                	li	a0,0
    57f2:	00002097          	auipc	ra,0x2
    57f6:	bde080e7          	jalr	-1058(ra) # 73d0 <sbrk>
    57fa:	fca43c23          	sd	a0,-40(s0)
  c = sbrk(-(sbrk(0) - oldbrk));
    57fe:	4501                	li	a0,0
    5800:	00002097          	auipc	ra,0x2
    5804:	bd0080e7          	jalr	-1072(ra) # 73d0 <sbrk>
    5808:	872a                	mv	a4,a0
    580a:	fe043783          	ld	a5,-32(s0)
    580e:	8f99                	sub	a5,a5,a4
    5810:	2781                	sext.w	a5,a5
    5812:	853e                	mv	a0,a5
    5814:	00002097          	auipc	ra,0x2
    5818:	bbc080e7          	jalr	-1092(ra) # 73d0 <sbrk>
    581c:	faa43823          	sd	a0,-80(s0)
  if(c != a){
    5820:	fb043703          	ld	a4,-80(s0)
    5824:	fd843783          	ld	a5,-40(s0)
    5828:	02f70563          	beq	a4,a5,5852 <sbrkmuch+0x246>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    582c:	fb043683          	ld	a3,-80(s0)
    5830:	fd843603          	ld	a2,-40(s0)
    5834:	fa843583          	ld	a1,-88(s0)
    5838:	00004517          	auipc	a0,0x4
    583c:	30050513          	addi	a0,a0,768 # 9b38 <malloc+0x20c0>
    5840:	00002097          	auipc	ra,0x2
    5844:	046080e7          	jalr	70(ra) # 7886 <printf>
    exit(1);
    5848:	4505                	li	a0,1
    584a:	00002097          	auipc	ra,0x2
    584e:	afe080e7          	jalr	-1282(ra) # 7348 <exit>
  }
}
    5852:	0001                	nop
    5854:	60e6                	ld	ra,88(sp)
    5856:	6446                	ld	s0,80(sp)
    5858:	6125                	addi	sp,sp,96
    585a:	8082                	ret

000000000000585c <kernmem>:

// can we read the kernel's memory?
void
kernmem(char *s)
{
    585c:	7179                	addi	sp,sp,-48
    585e:	f406                	sd	ra,40(sp)
    5860:	f022                	sd	s0,32(sp)
    5862:	1800                	addi	s0,sp,48
    5864:	fca43c23          	sd	a0,-40(s0)
  char *a;
  int pid;

  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    5868:	4785                	li	a5,1
    586a:	07fe                	slli	a5,a5,0x1f
    586c:	fef43423          	sd	a5,-24(s0)
    5870:	a04d                	j	5912 <kernmem+0xb6>
    pid = fork();
    5872:	00002097          	auipc	ra,0x2
    5876:	ace080e7          	jalr	-1330(ra) # 7340 <fork>
    587a:	87aa                	mv	a5,a0
    587c:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    5880:	fe442783          	lw	a5,-28(s0)
    5884:	2781                	sext.w	a5,a5
    5886:	0207d163          	bgez	a5,58a8 <kernmem+0x4c>
      printf("%s: fork failed\n", s);
    588a:	fd843583          	ld	a1,-40(s0)
    588e:	00003517          	auipc	a0,0x3
    5892:	ac250513          	addi	a0,a0,-1342 # 8350 <malloc+0x8d8>
    5896:	00002097          	auipc	ra,0x2
    589a:	ff0080e7          	jalr	-16(ra) # 7886 <printf>
      exit(1);
    589e:	4505                	li	a0,1
    58a0:	00002097          	auipc	ra,0x2
    58a4:	aa8080e7          	jalr	-1368(ra) # 7348 <exit>
    }
    if(pid == 0){
    58a8:	fe442783          	lw	a5,-28(s0)
    58ac:	2781                	sext.w	a5,a5
    58ae:	eb85                	bnez	a5,58de <kernmem+0x82>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    58b0:	fe843783          	ld	a5,-24(s0)
    58b4:	0007c783          	lbu	a5,0(a5)
    58b8:	2781                	sext.w	a5,a5
    58ba:	86be                	mv	a3,a5
    58bc:	fe843603          	ld	a2,-24(s0)
    58c0:	fd843583          	ld	a1,-40(s0)
    58c4:	00004517          	auipc	a0,0x4
    58c8:	29c50513          	addi	a0,a0,668 # 9b60 <malloc+0x20e8>
    58cc:	00002097          	auipc	ra,0x2
    58d0:	fba080e7          	jalr	-70(ra) # 7886 <printf>
      exit(1);
    58d4:	4505                	li	a0,1
    58d6:	00002097          	auipc	ra,0x2
    58da:	a72080e7          	jalr	-1422(ra) # 7348 <exit>
    }
    int xstatus;
    wait(&xstatus);
    58de:	fe040793          	addi	a5,s0,-32
    58e2:	853e                	mv	a0,a5
    58e4:	00002097          	auipc	ra,0x2
    58e8:	a6c080e7          	jalr	-1428(ra) # 7350 <wait>
    if(xstatus != -1)  // did kernel kill child?
    58ec:	fe042783          	lw	a5,-32(s0)
    58f0:	873e                	mv	a4,a5
    58f2:	57fd                	li	a5,-1
    58f4:	00f70763          	beq	a4,a5,5902 <kernmem+0xa6>
      exit(1);
    58f8:	4505                	li	a0,1
    58fa:	00002097          	auipc	ra,0x2
    58fe:	a4e080e7          	jalr	-1458(ra) # 7348 <exit>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    5902:	fe843703          	ld	a4,-24(s0)
    5906:	67b1                	lui	a5,0xc
    5908:	35078793          	addi	a5,a5,848 # c350 <__global_pointer$+0x1747>
    590c:	97ba                	add	a5,a5,a4
    590e:	fef43423          	sd	a5,-24(s0)
    5912:	fe843703          	ld	a4,-24(s0)
    5916:	1003d7b7          	lui	a5,0x1003d
    591a:	078e                	slli	a5,a5,0x3
    591c:	47f78793          	addi	a5,a5,1151 # 1003d47f <__BSS_END__+0x1002c83f>
    5920:	f4e7f9e3          	bgeu	a5,a4,5872 <kernmem+0x16>
  }
}
    5924:	0001                	nop
    5926:	0001                	nop
    5928:	70a2                	ld	ra,40(sp)
    592a:	7402                	ld	s0,32(sp)
    592c:	6145                	addi	sp,sp,48
    592e:	8082                	ret

0000000000005930 <MAXVAplus>:

// user code should not be able to write to addresses above MAXVA.
void
MAXVAplus(char *s)
{
    5930:	7139                	addi	sp,sp,-64
    5932:	fc06                	sd	ra,56(sp)
    5934:	f822                	sd	s0,48(sp)
    5936:	0080                	addi	s0,sp,64
    5938:	fca43423          	sd	a0,-56(s0)
  volatile uint64 a = MAXVA;
    593c:	4785                	li	a5,1
    593e:	179a                	slli	a5,a5,0x26
    5940:	fef43023          	sd	a5,-32(s0)
  for( ; a != 0; a <<= 1){
    5944:	a045                	j	59e4 <MAXVAplus+0xb4>
    int pid;
    pid = fork();
    5946:	00002097          	auipc	ra,0x2
    594a:	9fa080e7          	jalr	-1542(ra) # 7340 <fork>
    594e:	87aa                	mv	a5,a0
    5950:	fef42623          	sw	a5,-20(s0)
    if(pid < 0){
    5954:	fec42783          	lw	a5,-20(s0)
    5958:	2781                	sext.w	a5,a5
    595a:	0207d163          	bgez	a5,597c <MAXVAplus+0x4c>
      printf("%s: fork failed\n", s);
    595e:	fc843583          	ld	a1,-56(s0)
    5962:	00003517          	auipc	a0,0x3
    5966:	9ee50513          	addi	a0,a0,-1554 # 8350 <malloc+0x8d8>
    596a:	00002097          	auipc	ra,0x2
    596e:	f1c080e7          	jalr	-228(ra) # 7886 <printf>
      exit(1);
    5972:	4505                	li	a0,1
    5974:	00002097          	auipc	ra,0x2
    5978:	9d4080e7          	jalr	-1580(ra) # 7348 <exit>
    }
    if(pid == 0){
    597c:	fec42783          	lw	a5,-20(s0)
    5980:	2781                	sext.w	a5,a5
    5982:	eb95                	bnez	a5,59b6 <MAXVAplus+0x86>
      *(char*)a = 99;
    5984:	fe043783          	ld	a5,-32(s0)
    5988:	873e                	mv	a4,a5
    598a:	06300793          	li	a5,99
    598e:	00f70023          	sb	a5,0(a4) # 6400000 <__BSS_END__+0x63ef3c0>
      printf("%s: oops wrote %x\n", s, a);
    5992:	fe043783          	ld	a5,-32(s0)
    5996:	863e                	mv	a2,a5
    5998:	fc843583          	ld	a1,-56(s0)
    599c:	00004517          	auipc	a0,0x4
    59a0:	1e450513          	addi	a0,a0,484 # 9b80 <malloc+0x2108>
    59a4:	00002097          	auipc	ra,0x2
    59a8:	ee2080e7          	jalr	-286(ra) # 7886 <printf>
      exit(1);
    59ac:	4505                	li	a0,1
    59ae:	00002097          	auipc	ra,0x2
    59b2:	99a080e7          	jalr	-1638(ra) # 7348 <exit>
    }
    int xstatus;
    wait(&xstatus);
    59b6:	fdc40793          	addi	a5,s0,-36
    59ba:	853e                	mv	a0,a5
    59bc:	00002097          	auipc	ra,0x2
    59c0:	994080e7          	jalr	-1644(ra) # 7350 <wait>
    if(xstatus != -1)  // did kernel kill child?
    59c4:	fdc42783          	lw	a5,-36(s0)
    59c8:	873e                	mv	a4,a5
    59ca:	57fd                	li	a5,-1
    59cc:	00f70763          	beq	a4,a5,59da <MAXVAplus+0xaa>
      exit(1);
    59d0:	4505                	li	a0,1
    59d2:	00002097          	auipc	ra,0x2
    59d6:	976080e7          	jalr	-1674(ra) # 7348 <exit>
  for( ; a != 0; a <<= 1){
    59da:	fe043783          	ld	a5,-32(s0)
    59de:	0786                	slli	a5,a5,0x1
    59e0:	fef43023          	sd	a5,-32(s0)
    59e4:	fe043783          	ld	a5,-32(s0)
    59e8:	ffb9                	bnez	a5,5946 <MAXVAplus+0x16>
  }
}
    59ea:	0001                	nop
    59ec:	0001                	nop
    59ee:	70e2                	ld	ra,56(sp)
    59f0:	7442                	ld	s0,48(sp)
    59f2:	6121                	addi	sp,sp,64
    59f4:	8082                	ret

00000000000059f6 <sbrkfail>:

// if we run the system out of memory, does it clean up the last
// failed allocation?
void
sbrkfail(char *s)
{
    59f6:	7119                	addi	sp,sp,-128
    59f8:	fc86                	sd	ra,120(sp)
    59fa:	f8a2                	sd	s0,112(sp)
    59fc:	0100                	addi	s0,sp,128
    59fe:	f8a43423          	sd	a0,-120(s0)
  char scratch;
  char *c, *a;
  int pids[10];
  int pid;
 
  if(pipe(fds) != 0){
    5a02:	fc040793          	addi	a5,s0,-64
    5a06:	853e                	mv	a0,a5
    5a08:	00002097          	auipc	ra,0x2
    5a0c:	950080e7          	jalr	-1712(ra) # 7358 <pipe>
    5a10:	87aa                	mv	a5,a0
    5a12:	c385                	beqz	a5,5a32 <sbrkfail+0x3c>
    printf("%s: pipe() failed\n", s);
    5a14:	f8843583          	ld	a1,-120(s0)
    5a18:	00003517          	auipc	a0,0x3
    5a1c:	dd050513          	addi	a0,a0,-560 # 87e8 <malloc+0xd70>
    5a20:	00002097          	auipc	ra,0x2
    5a24:	e66080e7          	jalr	-410(ra) # 7886 <printf>
    exit(1);
    5a28:	4505                	li	a0,1
    5a2a:	00002097          	auipc	ra,0x2
    5a2e:	91e080e7          	jalr	-1762(ra) # 7348 <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    5a32:	fe042623          	sw	zero,-20(s0)
    5a36:	a84d                	j	5ae8 <sbrkfail+0xf2>
    if((pids[i] = fork()) == 0){
    5a38:	00002097          	auipc	ra,0x2
    5a3c:	908080e7          	jalr	-1784(ra) # 7340 <fork>
    5a40:	87aa                	mv	a5,a0
    5a42:	873e                	mv	a4,a5
    5a44:	fec42783          	lw	a5,-20(s0)
    5a48:	078a                	slli	a5,a5,0x2
    5a4a:	ff040693          	addi	a3,s0,-16
    5a4e:	97b6                	add	a5,a5,a3
    5a50:	fae7a023          	sw	a4,-96(a5)
    5a54:	fec42783          	lw	a5,-20(s0)
    5a58:	078a                	slli	a5,a5,0x2
    5a5a:	ff040713          	addi	a4,s0,-16
    5a5e:	97ba                	add	a5,a5,a4
    5a60:	fa07a783          	lw	a5,-96(a5)
    5a64:	e7b1                	bnez	a5,5ab0 <sbrkfail+0xba>
      // allocate a lot of memory
      sbrk(BIG - (uint64)sbrk(0));
    5a66:	4501                	li	a0,0
    5a68:	00002097          	auipc	ra,0x2
    5a6c:	968080e7          	jalr	-1688(ra) # 73d0 <sbrk>
    5a70:	87aa                	mv	a5,a0
    5a72:	2781                	sext.w	a5,a5
    5a74:	06400737          	lui	a4,0x6400
    5a78:	40f707bb          	subw	a5,a4,a5
    5a7c:	2781                	sext.w	a5,a5
    5a7e:	2781                	sext.w	a5,a5
    5a80:	853e                	mv	a0,a5
    5a82:	00002097          	auipc	ra,0x2
    5a86:	94e080e7          	jalr	-1714(ra) # 73d0 <sbrk>
      write(fds[1], "x", 1);
    5a8a:	fc442783          	lw	a5,-60(s0)
    5a8e:	4605                	li	a2,1
    5a90:	00002597          	auipc	a1,0x2
    5a94:	59858593          	addi	a1,a1,1432 # 8028 <malloc+0x5b0>
    5a98:	853e                	mv	a0,a5
    5a9a:	00002097          	auipc	ra,0x2
    5a9e:	8ce080e7          	jalr	-1842(ra) # 7368 <write>
      // sit around until killed
      for(;;) sleep(1000);
    5aa2:	3e800513          	li	a0,1000
    5aa6:	00002097          	auipc	ra,0x2
    5aaa:	932080e7          	jalr	-1742(ra) # 73d8 <sleep>
    5aae:	bfd5                	j	5aa2 <sbrkfail+0xac>
    }
    if(pids[i] != -1)
    5ab0:	fec42783          	lw	a5,-20(s0)
    5ab4:	078a                	slli	a5,a5,0x2
    5ab6:	ff040713          	addi	a4,s0,-16
    5aba:	97ba                	add	a5,a5,a4
    5abc:	fa07a783          	lw	a5,-96(a5)
    5ac0:	873e                	mv	a4,a5
    5ac2:	57fd                	li	a5,-1
    5ac4:	00f70d63          	beq	a4,a5,5ade <sbrkfail+0xe8>
      read(fds[0], &scratch, 1);
    5ac8:	fc042783          	lw	a5,-64(s0)
    5acc:	fbf40713          	addi	a4,s0,-65
    5ad0:	4605                	li	a2,1
    5ad2:	85ba                	mv	a1,a4
    5ad4:	853e                	mv	a0,a5
    5ad6:	00002097          	auipc	ra,0x2
    5ada:	88a080e7          	jalr	-1910(ra) # 7360 <read>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    5ade:	fec42783          	lw	a5,-20(s0)
    5ae2:	2785                	addiw	a5,a5,1
    5ae4:	fef42623          	sw	a5,-20(s0)
    5ae8:	fec42783          	lw	a5,-20(s0)
    5aec:	873e                	mv	a4,a5
    5aee:	47a5                	li	a5,9
    5af0:	f4e7f4e3          	bgeu	a5,a4,5a38 <sbrkfail+0x42>
  }

  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(PGSIZE);
    5af4:	6505                	lui	a0,0x1
    5af6:	00002097          	auipc	ra,0x2
    5afa:	8da080e7          	jalr	-1830(ra) # 73d0 <sbrk>
    5afe:	fea43023          	sd	a0,-32(s0)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    5b02:	fe042623          	sw	zero,-20(s0)
    5b06:	a0b1                	j	5b52 <sbrkfail+0x15c>
    if(pids[i] == -1)
    5b08:	fec42783          	lw	a5,-20(s0)
    5b0c:	078a                	slli	a5,a5,0x2
    5b0e:	ff040713          	addi	a4,s0,-16
    5b12:	97ba                	add	a5,a5,a4
    5b14:	fa07a783          	lw	a5,-96(a5)
    5b18:	873e                	mv	a4,a5
    5b1a:	57fd                	li	a5,-1
    5b1c:	02f70563          	beq	a4,a5,5b46 <sbrkfail+0x150>
      continue;
    kill(pids[i]);
    5b20:	fec42783          	lw	a5,-20(s0)
    5b24:	078a                	slli	a5,a5,0x2
    5b26:	ff040713          	addi	a4,s0,-16
    5b2a:	97ba                	add	a5,a5,a4
    5b2c:	fa07a783          	lw	a5,-96(a5)
    5b30:	853e                	mv	a0,a5
    5b32:	00002097          	auipc	ra,0x2
    5b36:	846080e7          	jalr	-1978(ra) # 7378 <kill>
    wait(0);
    5b3a:	4501                	li	a0,0
    5b3c:	00002097          	auipc	ra,0x2
    5b40:	814080e7          	jalr	-2028(ra) # 7350 <wait>
    5b44:	a011                	j	5b48 <sbrkfail+0x152>
      continue;
    5b46:	0001                	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    5b48:	fec42783          	lw	a5,-20(s0)
    5b4c:	2785                	addiw	a5,a5,1
    5b4e:	fef42623          	sw	a5,-20(s0)
    5b52:	fec42783          	lw	a5,-20(s0)
    5b56:	873e                	mv	a4,a5
    5b58:	47a5                	li	a5,9
    5b5a:	fae7f7e3          	bgeu	a5,a4,5b08 <sbrkfail+0x112>
  }
  if(c == (char*)0xffffffffffffffffL){
    5b5e:	fe043703          	ld	a4,-32(s0)
    5b62:	57fd                	li	a5,-1
    5b64:	02f71163          	bne	a4,a5,5b86 <sbrkfail+0x190>
    printf("%s: failed sbrk leaked memory\n", s);
    5b68:	f8843583          	ld	a1,-120(s0)
    5b6c:	00004517          	auipc	a0,0x4
    5b70:	02c50513          	addi	a0,a0,44 # 9b98 <malloc+0x2120>
    5b74:	00002097          	auipc	ra,0x2
    5b78:	d12080e7          	jalr	-750(ra) # 7886 <printf>
    exit(1);
    5b7c:	4505                	li	a0,1
    5b7e:	00001097          	auipc	ra,0x1
    5b82:	7ca080e7          	jalr	1994(ra) # 7348 <exit>
  }

  // test running fork with the above allocated page 
  pid = fork();
    5b86:	00001097          	auipc	ra,0x1
    5b8a:	7ba080e7          	jalr	1978(ra) # 7340 <fork>
    5b8e:	87aa                	mv	a5,a0
    5b90:	fcf42e23          	sw	a5,-36(s0)
  if(pid < 0){
    5b94:	fdc42783          	lw	a5,-36(s0)
    5b98:	2781                	sext.w	a5,a5
    5b9a:	0207d163          	bgez	a5,5bbc <sbrkfail+0x1c6>
    printf("%s: fork failed\n", s);
    5b9e:	f8843583          	ld	a1,-120(s0)
    5ba2:	00002517          	auipc	a0,0x2
    5ba6:	7ae50513          	addi	a0,a0,1966 # 8350 <malloc+0x8d8>
    5baa:	00002097          	auipc	ra,0x2
    5bae:	cdc080e7          	jalr	-804(ra) # 7886 <printf>
    exit(1);
    5bb2:	4505                	li	a0,1
    5bb4:	00001097          	auipc	ra,0x1
    5bb8:	794080e7          	jalr	1940(ra) # 7348 <exit>
  }
  if(pid == 0){
    5bbc:	fdc42783          	lw	a5,-36(s0)
    5bc0:	2781                	sext.w	a5,a5
    5bc2:	e3c1                	bnez	a5,5c42 <sbrkfail+0x24c>
    // allocate a lot of memory.
    // this should produce a page fault,
    // and thus not complete.
    a = sbrk(0);
    5bc4:	4501                	li	a0,0
    5bc6:	00002097          	auipc	ra,0x2
    5bca:	80a080e7          	jalr	-2038(ra) # 73d0 <sbrk>
    5bce:	fca43823          	sd	a0,-48(s0)
    sbrk(10*BIG);
    5bd2:	3e800537          	lui	a0,0x3e800
    5bd6:	00001097          	auipc	ra,0x1
    5bda:	7fa080e7          	jalr	2042(ra) # 73d0 <sbrk>
    int n = 0;
    5bde:	fe042423          	sw	zero,-24(s0)
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    5be2:	fe042623          	sw	zero,-20(s0)
    5be6:	a025                	j	5c0e <sbrkfail+0x218>
      n += *(a+i);
    5be8:	fec42783          	lw	a5,-20(s0)
    5bec:	fd043703          	ld	a4,-48(s0)
    5bf0:	97ba                	add	a5,a5,a4
    5bf2:	0007c783          	lbu	a5,0(a5)
    5bf6:	2781                	sext.w	a5,a5
    5bf8:	fe842703          	lw	a4,-24(s0)
    5bfc:	9fb9                	addw	a5,a5,a4
    5bfe:	fef42423          	sw	a5,-24(s0)
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    5c02:	fec42703          	lw	a4,-20(s0)
    5c06:	6785                	lui	a5,0x1
    5c08:	9fb9                	addw	a5,a5,a4
    5c0a:	fef42623          	sw	a5,-20(s0)
    5c0e:	fec42783          	lw	a5,-20(s0)
    5c12:	0007871b          	sext.w	a4,a5
    5c16:	3e8007b7          	lui	a5,0x3e800
    5c1a:	fcf747e3          	blt	a4,a5,5be8 <sbrkfail+0x1f2>
    }
    // print n so the compiler doesn't optimize away
    // the for loop.
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    5c1e:	fe842783          	lw	a5,-24(s0)
    5c22:	863e                	mv	a2,a5
    5c24:	f8843583          	ld	a1,-120(s0)
    5c28:	00004517          	auipc	a0,0x4
    5c2c:	f9050513          	addi	a0,a0,-112 # 9bb8 <malloc+0x2140>
    5c30:	00002097          	auipc	ra,0x2
    5c34:	c56080e7          	jalr	-938(ra) # 7886 <printf>
    exit(1);
    5c38:	4505                	li	a0,1
    5c3a:	00001097          	auipc	ra,0x1
    5c3e:	70e080e7          	jalr	1806(ra) # 7348 <exit>
  }
  wait(&xstatus);
    5c42:	fcc40793          	addi	a5,s0,-52
    5c46:	853e                	mv	a0,a5
    5c48:	00001097          	auipc	ra,0x1
    5c4c:	708080e7          	jalr	1800(ra) # 7350 <wait>
  if(xstatus != -1 && xstatus != 2)
    5c50:	fcc42783          	lw	a5,-52(s0)
    5c54:	873e                	mv	a4,a5
    5c56:	57fd                	li	a5,-1
    5c58:	00f70d63          	beq	a4,a5,5c72 <sbrkfail+0x27c>
    5c5c:	fcc42783          	lw	a5,-52(s0)
    5c60:	873e                	mv	a4,a5
    5c62:	4789                	li	a5,2
    5c64:	00f70763          	beq	a4,a5,5c72 <sbrkfail+0x27c>
    exit(1);
    5c68:	4505                	li	a0,1
    5c6a:	00001097          	auipc	ra,0x1
    5c6e:	6de080e7          	jalr	1758(ra) # 7348 <exit>
}
    5c72:	0001                	nop
    5c74:	70e6                	ld	ra,120(sp)
    5c76:	7446                	ld	s0,112(sp)
    5c78:	6109                	addi	sp,sp,128
    5c7a:	8082                	ret

0000000000005c7c <sbrkarg>:

  
// test reads/writes from/to allocated memory
void
sbrkarg(char *s)
{
    5c7c:	7179                	addi	sp,sp,-48
    5c7e:	f406                	sd	ra,40(sp)
    5c80:	f022                	sd	s0,32(sp)
    5c82:	1800                	addi	s0,sp,48
    5c84:	fca43c23          	sd	a0,-40(s0)
  char *a;
  int fd, n;

  a = sbrk(PGSIZE);
    5c88:	6505                	lui	a0,0x1
    5c8a:	00001097          	auipc	ra,0x1
    5c8e:	746080e7          	jalr	1862(ra) # 73d0 <sbrk>
    5c92:	fea43423          	sd	a0,-24(s0)
  fd = open("sbrk", O_CREATE|O_WRONLY);
    5c96:	20100593          	li	a1,513
    5c9a:	00004517          	auipc	a0,0x4
    5c9e:	f4e50513          	addi	a0,a0,-178 # 9be8 <malloc+0x2170>
    5ca2:	00001097          	auipc	ra,0x1
    5ca6:	6e6080e7          	jalr	1766(ra) # 7388 <open>
    5caa:	87aa                	mv	a5,a0
    5cac:	fef42223          	sw	a5,-28(s0)
  unlink("sbrk");
    5cb0:	00004517          	auipc	a0,0x4
    5cb4:	f3850513          	addi	a0,a0,-200 # 9be8 <malloc+0x2170>
    5cb8:	00001097          	auipc	ra,0x1
    5cbc:	6e0080e7          	jalr	1760(ra) # 7398 <unlink>
  if(fd < 0)  {
    5cc0:	fe442783          	lw	a5,-28(s0)
    5cc4:	2781                	sext.w	a5,a5
    5cc6:	0207d163          	bgez	a5,5ce8 <sbrkarg+0x6c>
    printf("%s: open sbrk failed\n", s);
    5cca:	fd843583          	ld	a1,-40(s0)
    5cce:	00004517          	auipc	a0,0x4
    5cd2:	f2250513          	addi	a0,a0,-222 # 9bf0 <malloc+0x2178>
    5cd6:	00002097          	auipc	ra,0x2
    5cda:	bb0080e7          	jalr	-1104(ra) # 7886 <printf>
    exit(1);
    5cde:	4505                	li	a0,1
    5ce0:	00001097          	auipc	ra,0x1
    5ce4:	668080e7          	jalr	1640(ra) # 7348 <exit>
  }
  if ((n = write(fd, a, PGSIZE)) < 0) {
    5ce8:	fe442783          	lw	a5,-28(s0)
    5cec:	6605                	lui	a2,0x1
    5cee:	fe843583          	ld	a1,-24(s0)
    5cf2:	853e                	mv	a0,a5
    5cf4:	00001097          	auipc	ra,0x1
    5cf8:	674080e7          	jalr	1652(ra) # 7368 <write>
    5cfc:	87aa                	mv	a5,a0
    5cfe:	fef42023          	sw	a5,-32(s0)
    5d02:	fe042783          	lw	a5,-32(s0)
    5d06:	2781                	sext.w	a5,a5
    5d08:	0207d163          	bgez	a5,5d2a <sbrkarg+0xae>
    printf("%s: write sbrk failed\n", s);
    5d0c:	fd843583          	ld	a1,-40(s0)
    5d10:	00004517          	auipc	a0,0x4
    5d14:	ef850513          	addi	a0,a0,-264 # 9c08 <malloc+0x2190>
    5d18:	00002097          	auipc	ra,0x2
    5d1c:	b6e080e7          	jalr	-1170(ra) # 7886 <printf>
    exit(1);
    5d20:	4505                	li	a0,1
    5d22:	00001097          	auipc	ra,0x1
    5d26:	626080e7          	jalr	1574(ra) # 7348 <exit>
  }
  close(fd);
    5d2a:	fe442783          	lw	a5,-28(s0)
    5d2e:	853e                	mv	a0,a5
    5d30:	00001097          	auipc	ra,0x1
    5d34:	640080e7          	jalr	1600(ra) # 7370 <close>

  // test writes to allocated memory
  a = sbrk(PGSIZE);
    5d38:	6505                	lui	a0,0x1
    5d3a:	00001097          	auipc	ra,0x1
    5d3e:	696080e7          	jalr	1686(ra) # 73d0 <sbrk>
    5d42:	fea43423          	sd	a0,-24(s0)
  if(pipe((int *) a) != 0){
    5d46:	fe843503          	ld	a0,-24(s0)
    5d4a:	00001097          	auipc	ra,0x1
    5d4e:	60e080e7          	jalr	1550(ra) # 7358 <pipe>
    5d52:	87aa                	mv	a5,a0
    5d54:	c385                	beqz	a5,5d74 <sbrkarg+0xf8>
    printf("%s: pipe() failed\n", s);
    5d56:	fd843583          	ld	a1,-40(s0)
    5d5a:	00003517          	auipc	a0,0x3
    5d5e:	a8e50513          	addi	a0,a0,-1394 # 87e8 <malloc+0xd70>
    5d62:	00002097          	auipc	ra,0x2
    5d66:	b24080e7          	jalr	-1244(ra) # 7886 <printf>
    exit(1);
    5d6a:	4505                	li	a0,1
    5d6c:	00001097          	auipc	ra,0x1
    5d70:	5dc080e7          	jalr	1500(ra) # 7348 <exit>
  } 
}
    5d74:	0001                	nop
    5d76:	70a2                	ld	ra,40(sp)
    5d78:	7402                	ld	s0,32(sp)
    5d7a:	6145                	addi	sp,sp,48
    5d7c:	8082                	ret

0000000000005d7e <validatetest>:

void
validatetest(char *s)
{
    5d7e:	7179                	addi	sp,sp,-48
    5d80:	f406                	sd	ra,40(sp)
    5d82:	f022                	sd	s0,32(sp)
    5d84:	1800                	addi	s0,sp,48
    5d86:	fca43c23          	sd	a0,-40(s0)
  int hi;
  uint64 p;

  hi = 1100*1024;
    5d8a:	001137b7          	lui	a5,0x113
    5d8e:	fef42223          	sw	a5,-28(s0)
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    5d92:	fe043423          	sd	zero,-24(s0)
    5d96:	a0b1                	j	5de2 <validatetest+0x64>
    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    5d98:	fe843783          	ld	a5,-24(s0)
    5d9c:	85be                	mv	a1,a5
    5d9e:	00004517          	auipc	a0,0x4
    5da2:	e8250513          	addi	a0,a0,-382 # 9c20 <malloc+0x21a8>
    5da6:	00001097          	auipc	ra,0x1
    5daa:	602080e7          	jalr	1538(ra) # 73a8 <link>
    5dae:	87aa                	mv	a5,a0
    5db0:	873e                	mv	a4,a5
    5db2:	57fd                	li	a5,-1
    5db4:	02f70163          	beq	a4,a5,5dd6 <validatetest+0x58>
      printf("%s: link should not succeed\n", s);
    5db8:	fd843583          	ld	a1,-40(s0)
    5dbc:	00004517          	auipc	a0,0x4
    5dc0:	e7450513          	addi	a0,a0,-396 # 9c30 <malloc+0x21b8>
    5dc4:	00002097          	auipc	ra,0x2
    5dc8:	ac2080e7          	jalr	-1342(ra) # 7886 <printf>
      exit(1);
    5dcc:	4505                	li	a0,1
    5dce:	00001097          	auipc	ra,0x1
    5dd2:	57a080e7          	jalr	1402(ra) # 7348 <exit>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    5dd6:	fe843703          	ld	a4,-24(s0)
    5dda:	6785                	lui	a5,0x1
    5ddc:	97ba                	add	a5,a5,a4
    5dde:	fef43423          	sd	a5,-24(s0)
    5de2:	fe442783          	lw	a5,-28(s0)
    5de6:	1782                	slli	a5,a5,0x20
    5de8:	9381                	srli	a5,a5,0x20
    5dea:	fe843703          	ld	a4,-24(s0)
    5dee:	fae7f5e3          	bgeu	a5,a4,5d98 <validatetest+0x1a>
    }
  }
}
    5df2:	0001                	nop
    5df4:	0001                	nop
    5df6:	70a2                	ld	ra,40(sp)
    5df8:	7402                	ld	s0,32(sp)
    5dfa:	6145                	addi	sp,sp,48
    5dfc:	8082                	ret

0000000000005dfe <bsstest>:

// does uninitialized data start out zero?
char uninit[10000];
void
bsstest(char *s)
{
    5dfe:	7179                	addi	sp,sp,-48
    5e00:	f406                	sd	ra,40(sp)
    5e02:	f022                	sd	s0,32(sp)
    5e04:	1800                	addi	s0,sp,48
    5e06:	fca43c23          	sd	a0,-40(s0)
  int i;

  for(i = 0; i < sizeof(uninit); i++){
    5e0a:	fe042623          	sw	zero,-20(s0)
    5e0e:	a83d                	j	5e4c <bsstest+0x4e>
    if(uninit[i] != '\0'){
    5e10:	00007717          	auipc	a4,0x7
    5e14:	60070713          	addi	a4,a4,1536 # d410 <uninit>
    5e18:	fec42783          	lw	a5,-20(s0)
    5e1c:	97ba                	add	a5,a5,a4
    5e1e:	0007c783          	lbu	a5,0(a5) # 1000 <truncate3+0x1aa>
    5e22:	c385                	beqz	a5,5e42 <bsstest+0x44>
      printf("%s: bss test failed\n", s);
    5e24:	fd843583          	ld	a1,-40(s0)
    5e28:	00004517          	auipc	a0,0x4
    5e2c:	e2850513          	addi	a0,a0,-472 # 9c50 <malloc+0x21d8>
    5e30:	00002097          	auipc	ra,0x2
    5e34:	a56080e7          	jalr	-1450(ra) # 7886 <printf>
      exit(1);
    5e38:	4505                	li	a0,1
    5e3a:	00001097          	auipc	ra,0x1
    5e3e:	50e080e7          	jalr	1294(ra) # 7348 <exit>
  for(i = 0; i < sizeof(uninit); i++){
    5e42:	fec42783          	lw	a5,-20(s0)
    5e46:	2785                	addiw	a5,a5,1
    5e48:	fef42623          	sw	a5,-20(s0)
    5e4c:	fec42783          	lw	a5,-20(s0)
    5e50:	873e                	mv	a4,a5
    5e52:	6789                	lui	a5,0x2
    5e54:	70f78793          	addi	a5,a5,1807 # 270f <reparent2+0x7b>
    5e58:	fae7fce3          	bgeu	a5,a4,5e10 <bsstest+0x12>
    }
  }
}
    5e5c:	0001                	nop
    5e5e:	0001                	nop
    5e60:	70a2                	ld	ra,40(sp)
    5e62:	7402                	ld	s0,32(sp)
    5e64:	6145                	addi	sp,sp,48
    5e66:	8082                	ret

0000000000005e68 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(char *s)
{
    5e68:	7179                	addi	sp,sp,-48
    5e6a:	f406                	sd	ra,40(sp)
    5e6c:	f022                	sd	s0,32(sp)
    5e6e:	1800                	addi	s0,sp,48
    5e70:	fca43c23          	sd	a0,-40(s0)
  int pid, fd, xstatus;

  unlink("bigarg-ok");
    5e74:	00004517          	auipc	a0,0x4
    5e78:	df450513          	addi	a0,a0,-524 # 9c68 <malloc+0x21f0>
    5e7c:	00001097          	auipc	ra,0x1
    5e80:	51c080e7          	jalr	1308(ra) # 7398 <unlink>
  pid = fork();
    5e84:	00001097          	auipc	ra,0x1
    5e88:	4bc080e7          	jalr	1212(ra) # 7340 <fork>
    5e8c:	87aa                	mv	a5,a0
    5e8e:	fef42423          	sw	a5,-24(s0)
  if(pid == 0){
    5e92:	fe842783          	lw	a5,-24(s0)
    5e96:	2781                	sext.w	a5,a5
    5e98:	ebc1                	bnez	a5,5f28 <bigargtest+0xc0>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    5e9a:	fe042623          	sw	zero,-20(s0)
    5e9e:	a01d                	j	5ec4 <bigargtest+0x5c>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    5ea0:	0000b717          	auipc	a4,0xb
    5ea4:	c8870713          	addi	a4,a4,-888 # 10b28 <args.1>
    5ea8:	fec42783          	lw	a5,-20(s0)
    5eac:	078e                	slli	a5,a5,0x3
    5eae:	97ba                	add	a5,a5,a4
    5eb0:	00004717          	auipc	a4,0x4
    5eb4:	dc870713          	addi	a4,a4,-568 # 9c78 <malloc+0x2200>
    5eb8:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    5eba:	fec42783          	lw	a5,-20(s0)
    5ebe:	2785                	addiw	a5,a5,1
    5ec0:	fef42623          	sw	a5,-20(s0)
    5ec4:	fec42783          	lw	a5,-20(s0)
    5ec8:	0007871b          	sext.w	a4,a5
    5ecc:	47f9                	li	a5,30
    5ece:	fce7d9e3          	bge	a5,a4,5ea0 <bigargtest+0x38>
    args[MAXARG-1] = 0;
    5ed2:	0000b797          	auipc	a5,0xb
    5ed6:	c5678793          	addi	a5,a5,-938 # 10b28 <args.1>
    5eda:	0e07bc23          	sd	zero,248(a5)
    exec("echo", args);
    5ede:	0000b597          	auipc	a1,0xb
    5ee2:	c4a58593          	addi	a1,a1,-950 # 10b28 <args.1>
    5ee6:	00002517          	auipc	a0,0x2
    5eea:	25250513          	addi	a0,a0,594 # 8138 <malloc+0x6c0>
    5eee:	00001097          	auipc	ra,0x1
    5ef2:	492080e7          	jalr	1170(ra) # 7380 <exec>
    fd = open("bigarg-ok", O_CREATE);
    5ef6:	20000593          	li	a1,512
    5efa:	00004517          	auipc	a0,0x4
    5efe:	d6e50513          	addi	a0,a0,-658 # 9c68 <malloc+0x21f0>
    5f02:	00001097          	auipc	ra,0x1
    5f06:	486080e7          	jalr	1158(ra) # 7388 <open>
    5f0a:	87aa                	mv	a5,a0
    5f0c:	fef42223          	sw	a5,-28(s0)
    close(fd);
    5f10:	fe442783          	lw	a5,-28(s0)
    5f14:	853e                	mv	a0,a5
    5f16:	00001097          	auipc	ra,0x1
    5f1a:	45a080e7          	jalr	1114(ra) # 7370 <close>
    exit(0);
    5f1e:	4501                	li	a0,0
    5f20:	00001097          	auipc	ra,0x1
    5f24:	428080e7          	jalr	1064(ra) # 7348 <exit>
  } else if(pid < 0){
    5f28:	fe842783          	lw	a5,-24(s0)
    5f2c:	2781                	sext.w	a5,a5
    5f2e:	0207d163          	bgez	a5,5f50 <bigargtest+0xe8>
    printf("%s: bigargtest: fork failed\n", s);
    5f32:	fd843583          	ld	a1,-40(s0)
    5f36:	00004517          	auipc	a0,0x4
    5f3a:	e2250513          	addi	a0,a0,-478 # 9d58 <malloc+0x22e0>
    5f3e:	00002097          	auipc	ra,0x2
    5f42:	948080e7          	jalr	-1720(ra) # 7886 <printf>
    exit(1);
    5f46:	4505                	li	a0,1
    5f48:	00001097          	auipc	ra,0x1
    5f4c:	400080e7          	jalr	1024(ra) # 7348 <exit>
  }
  
  wait(&xstatus);
    5f50:	fe040793          	addi	a5,s0,-32
    5f54:	853e                	mv	a0,a5
    5f56:	00001097          	auipc	ra,0x1
    5f5a:	3fa080e7          	jalr	1018(ra) # 7350 <wait>
  if(xstatus != 0)
    5f5e:	fe042783          	lw	a5,-32(s0)
    5f62:	cb81                	beqz	a5,5f72 <bigargtest+0x10a>
    exit(xstatus);
    5f64:	fe042783          	lw	a5,-32(s0)
    5f68:	853e                	mv	a0,a5
    5f6a:	00001097          	auipc	ra,0x1
    5f6e:	3de080e7          	jalr	990(ra) # 7348 <exit>
  fd = open("bigarg-ok", 0);
    5f72:	4581                	li	a1,0
    5f74:	00004517          	auipc	a0,0x4
    5f78:	cf450513          	addi	a0,a0,-780 # 9c68 <malloc+0x21f0>
    5f7c:	00001097          	auipc	ra,0x1
    5f80:	40c080e7          	jalr	1036(ra) # 7388 <open>
    5f84:	87aa                	mv	a5,a0
    5f86:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    5f8a:	fe442783          	lw	a5,-28(s0)
    5f8e:	2781                	sext.w	a5,a5
    5f90:	0207d163          	bgez	a5,5fb2 <bigargtest+0x14a>
    printf("%s: bigarg test failed!\n", s);
    5f94:	fd843583          	ld	a1,-40(s0)
    5f98:	00004517          	auipc	a0,0x4
    5f9c:	de050513          	addi	a0,a0,-544 # 9d78 <malloc+0x2300>
    5fa0:	00002097          	auipc	ra,0x2
    5fa4:	8e6080e7          	jalr	-1818(ra) # 7886 <printf>
    exit(1);
    5fa8:	4505                	li	a0,1
    5faa:	00001097          	auipc	ra,0x1
    5fae:	39e080e7          	jalr	926(ra) # 7348 <exit>
  }
  close(fd);
    5fb2:	fe442783          	lw	a5,-28(s0)
    5fb6:	853e                	mv	a0,a5
    5fb8:	00001097          	auipc	ra,0x1
    5fbc:	3b8080e7          	jalr	952(ra) # 7370 <close>
}
    5fc0:	0001                	nop
    5fc2:	70a2                	ld	ra,40(sp)
    5fc4:	7402                	ld	s0,32(sp)
    5fc6:	6145                	addi	sp,sp,48
    5fc8:	8082                	ret

0000000000005fca <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    5fca:	7159                	addi	sp,sp,-112
    5fcc:	f486                	sd	ra,104(sp)
    5fce:	f0a2                	sd	s0,96(sp)
    5fd0:	1880                	addi	s0,sp,112
  int nfiles;
  int fsblocks = 0;
    5fd2:	fe042423          	sw	zero,-24(s0)

  printf("fsfull test\n");
    5fd6:	00004517          	auipc	a0,0x4
    5fda:	dc250513          	addi	a0,a0,-574 # 9d98 <malloc+0x2320>
    5fde:	00002097          	auipc	ra,0x2
    5fe2:	8a8080e7          	jalr	-1880(ra) # 7886 <printf>

  for(nfiles = 0; ; nfiles++){
    5fe6:	fe042623          	sw	zero,-20(s0)
    char name[64];
    name[0] = 'f';
    5fea:	06600793          	li	a5,102
    5fee:	f8f40c23          	sb	a5,-104(s0)
    name[1] = '0' + nfiles / 1000;
    5ff2:	fec42703          	lw	a4,-20(s0)
    5ff6:	3e800793          	li	a5,1000
    5ffa:	02f747bb          	divw	a5,a4,a5
    5ffe:	2781                	sext.w	a5,a5
    6000:	0ff7f793          	andi	a5,a5,255
    6004:	0307879b          	addiw	a5,a5,48
    6008:	0ff7f793          	andi	a5,a5,255
    600c:	f8f40ca3          	sb	a5,-103(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    6010:	fec42703          	lw	a4,-20(s0)
    6014:	3e800793          	li	a5,1000
    6018:	02f767bb          	remw	a5,a4,a5
    601c:	2781                	sext.w	a5,a5
    601e:	873e                	mv	a4,a5
    6020:	06400793          	li	a5,100
    6024:	02f747bb          	divw	a5,a4,a5
    6028:	2781                	sext.w	a5,a5
    602a:	0ff7f793          	andi	a5,a5,255
    602e:	0307879b          	addiw	a5,a5,48
    6032:	0ff7f793          	andi	a5,a5,255
    6036:	f8f40d23          	sb	a5,-102(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    603a:	fec42703          	lw	a4,-20(s0)
    603e:	06400793          	li	a5,100
    6042:	02f767bb          	remw	a5,a4,a5
    6046:	2781                	sext.w	a5,a5
    6048:	873e                	mv	a4,a5
    604a:	47a9                	li	a5,10
    604c:	02f747bb          	divw	a5,a4,a5
    6050:	2781                	sext.w	a5,a5
    6052:	0ff7f793          	andi	a5,a5,255
    6056:	0307879b          	addiw	a5,a5,48
    605a:	0ff7f793          	andi	a5,a5,255
    605e:	f8f40da3          	sb	a5,-101(s0)
    name[4] = '0' + (nfiles % 10);
    6062:	fec42703          	lw	a4,-20(s0)
    6066:	47a9                	li	a5,10
    6068:	02f767bb          	remw	a5,a4,a5
    606c:	2781                	sext.w	a5,a5
    606e:	0ff7f793          	andi	a5,a5,255
    6072:	0307879b          	addiw	a5,a5,48
    6076:	0ff7f793          	andi	a5,a5,255
    607a:	f8f40e23          	sb	a5,-100(s0)
    name[5] = '\0';
    607e:	f8040ea3          	sb	zero,-99(s0)
    printf("writing %s\n", name);
    6082:	f9840793          	addi	a5,s0,-104
    6086:	85be                	mv	a1,a5
    6088:	00004517          	auipc	a0,0x4
    608c:	d2050513          	addi	a0,a0,-736 # 9da8 <malloc+0x2330>
    6090:	00001097          	auipc	ra,0x1
    6094:	7f6080e7          	jalr	2038(ra) # 7886 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    6098:	f9840793          	addi	a5,s0,-104
    609c:	20200593          	li	a1,514
    60a0:	853e                	mv	a0,a5
    60a2:	00001097          	auipc	ra,0x1
    60a6:	2e6080e7          	jalr	742(ra) # 7388 <open>
    60aa:	87aa                	mv	a5,a0
    60ac:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    60b0:	fe042783          	lw	a5,-32(s0)
    60b4:	2781                	sext.w	a5,a5
    60b6:	0007de63          	bgez	a5,60d2 <fsfull+0x108>
      printf("open %s failed\n", name);
    60ba:	f9840793          	addi	a5,s0,-104
    60be:	85be                	mv	a1,a5
    60c0:	00004517          	auipc	a0,0x4
    60c4:	cf850513          	addi	a0,a0,-776 # 9db8 <malloc+0x2340>
    60c8:	00001097          	auipc	ra,0x1
    60cc:	7be080e7          	jalr	1982(ra) # 7886 <printf>
      break;
    60d0:	a071                	j	615c <fsfull+0x192>
    }
    int total = 0;
    60d2:	fe042223          	sw	zero,-28(s0)
    while(1){
      int cc = write(fd, buf, BSIZE);
    60d6:	fe042783          	lw	a5,-32(s0)
    60da:	40000613          	li	a2,1024
    60de:	00004597          	auipc	a1,0x4
    60e2:	33258593          	addi	a1,a1,818 # a410 <buf>
    60e6:	853e                	mv	a0,a5
    60e8:	00001097          	auipc	ra,0x1
    60ec:	280080e7          	jalr	640(ra) # 7368 <write>
    60f0:	87aa                	mv	a5,a0
    60f2:	fcf42e23          	sw	a5,-36(s0)
      if(cc < BSIZE)
    60f6:	fdc42783          	lw	a5,-36(s0)
    60fa:	0007871b          	sext.w	a4,a5
    60fe:	3ff00793          	li	a5,1023
    6102:	00e7df63          	bge	a5,a4,6120 <fsfull+0x156>
        break;
      total += cc;
    6106:	fe442703          	lw	a4,-28(s0)
    610a:	fdc42783          	lw	a5,-36(s0)
    610e:	9fb9                	addw	a5,a5,a4
    6110:	fef42223          	sw	a5,-28(s0)
      fsblocks++;
    6114:	fe842783          	lw	a5,-24(s0)
    6118:	2785                	addiw	a5,a5,1
    611a:	fef42423          	sw	a5,-24(s0)
    while(1){
    611e:	bf65                	j	60d6 <fsfull+0x10c>
        break;
    6120:	0001                	nop
    }
    printf("wrote %d bytes\n", total);
    6122:	fe442783          	lw	a5,-28(s0)
    6126:	85be                	mv	a1,a5
    6128:	00004517          	auipc	a0,0x4
    612c:	ca050513          	addi	a0,a0,-864 # 9dc8 <malloc+0x2350>
    6130:	00001097          	auipc	ra,0x1
    6134:	756080e7          	jalr	1878(ra) # 7886 <printf>
    close(fd);
    6138:	fe042783          	lw	a5,-32(s0)
    613c:	853e                	mv	a0,a5
    613e:	00001097          	auipc	ra,0x1
    6142:	232080e7          	jalr	562(ra) # 7370 <close>
    if(total == 0)
    6146:	fe442783          	lw	a5,-28(s0)
    614a:	2781                	sext.w	a5,a5
    614c:	c799                	beqz	a5,615a <fsfull+0x190>
  for(nfiles = 0; ; nfiles++){
    614e:	fec42783          	lw	a5,-20(s0)
    6152:	2785                	addiw	a5,a5,1
    6154:	fef42623          	sw	a5,-20(s0)
    6158:	bd49                	j	5fea <fsfull+0x20>
      break;
    615a:	0001                	nop
  }

  while(nfiles >= 0){
    615c:	a84d                	j	620e <fsfull+0x244>
    char name[64];
    name[0] = 'f';
    615e:	06600793          	li	a5,102
    6162:	f8f40c23          	sb	a5,-104(s0)
    name[1] = '0' + nfiles / 1000;
    6166:	fec42703          	lw	a4,-20(s0)
    616a:	3e800793          	li	a5,1000
    616e:	02f747bb          	divw	a5,a4,a5
    6172:	2781                	sext.w	a5,a5
    6174:	0ff7f793          	andi	a5,a5,255
    6178:	0307879b          	addiw	a5,a5,48
    617c:	0ff7f793          	andi	a5,a5,255
    6180:	f8f40ca3          	sb	a5,-103(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    6184:	fec42703          	lw	a4,-20(s0)
    6188:	3e800793          	li	a5,1000
    618c:	02f767bb          	remw	a5,a4,a5
    6190:	2781                	sext.w	a5,a5
    6192:	873e                	mv	a4,a5
    6194:	06400793          	li	a5,100
    6198:	02f747bb          	divw	a5,a4,a5
    619c:	2781                	sext.w	a5,a5
    619e:	0ff7f793          	andi	a5,a5,255
    61a2:	0307879b          	addiw	a5,a5,48
    61a6:	0ff7f793          	andi	a5,a5,255
    61aa:	f8f40d23          	sb	a5,-102(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    61ae:	fec42703          	lw	a4,-20(s0)
    61b2:	06400793          	li	a5,100
    61b6:	02f767bb          	remw	a5,a4,a5
    61ba:	2781                	sext.w	a5,a5
    61bc:	873e                	mv	a4,a5
    61be:	47a9                	li	a5,10
    61c0:	02f747bb          	divw	a5,a4,a5
    61c4:	2781                	sext.w	a5,a5
    61c6:	0ff7f793          	andi	a5,a5,255
    61ca:	0307879b          	addiw	a5,a5,48
    61ce:	0ff7f793          	andi	a5,a5,255
    61d2:	f8f40da3          	sb	a5,-101(s0)
    name[4] = '0' + (nfiles % 10);
    61d6:	fec42703          	lw	a4,-20(s0)
    61da:	47a9                	li	a5,10
    61dc:	02f767bb          	remw	a5,a4,a5
    61e0:	2781                	sext.w	a5,a5
    61e2:	0ff7f793          	andi	a5,a5,255
    61e6:	0307879b          	addiw	a5,a5,48
    61ea:	0ff7f793          	andi	a5,a5,255
    61ee:	f8f40e23          	sb	a5,-100(s0)
    name[5] = '\0';
    61f2:	f8040ea3          	sb	zero,-99(s0)
    unlink(name);
    61f6:	f9840793          	addi	a5,s0,-104
    61fa:	853e                	mv	a0,a5
    61fc:	00001097          	auipc	ra,0x1
    6200:	19c080e7          	jalr	412(ra) # 7398 <unlink>
    nfiles--;
    6204:	fec42783          	lw	a5,-20(s0)
    6208:	37fd                	addiw	a5,a5,-1
    620a:	fef42623          	sw	a5,-20(s0)
  while(nfiles >= 0){
    620e:	fec42783          	lw	a5,-20(s0)
    6212:	2781                	sext.w	a5,a5
    6214:	f407d5e3          	bgez	a5,615e <fsfull+0x194>
  }

  printf("fsfull test finished\n");
    6218:	00004517          	auipc	a0,0x4
    621c:	bc050513          	addi	a0,a0,-1088 # 9dd8 <malloc+0x2360>
    6220:	00001097          	auipc	ra,0x1
    6224:	666080e7          	jalr	1638(ra) # 7886 <printf>
}
    6228:	0001                	nop
    622a:	70a6                	ld	ra,104(sp)
    622c:	7406                	ld	s0,96(sp)
    622e:	6165                	addi	sp,sp,112
    6230:	8082                	ret

0000000000006232 <argptest>:

void argptest(char *s)
{
    6232:	7179                	addi	sp,sp,-48
    6234:	f406                	sd	ra,40(sp)
    6236:	f022                	sd	s0,32(sp)
    6238:	1800                	addi	s0,sp,48
    623a:	fca43c23          	sd	a0,-40(s0)
  int fd;
  fd = open("init", O_RDONLY);
    623e:	4581                	li	a1,0
    6240:	00004517          	auipc	a0,0x4
    6244:	bb050513          	addi	a0,a0,-1104 # 9df0 <malloc+0x2378>
    6248:	00001097          	auipc	ra,0x1
    624c:	140080e7          	jalr	320(ra) # 7388 <open>
    6250:	87aa                	mv	a5,a0
    6252:	fef42623          	sw	a5,-20(s0)
  if (fd < 0) {
    6256:	fec42783          	lw	a5,-20(s0)
    625a:	2781                	sext.w	a5,a5
    625c:	0207d163          	bgez	a5,627e <argptest+0x4c>
    printf("%s: open failed\n", s);
    6260:	fd843583          	ld	a1,-40(s0)
    6264:	00002517          	auipc	a0,0x2
    6268:	10450513          	addi	a0,a0,260 # 8368 <malloc+0x8f0>
    626c:	00001097          	auipc	ra,0x1
    6270:	61a080e7          	jalr	1562(ra) # 7886 <printf>
    exit(1);
    6274:	4505                	li	a0,1
    6276:	00001097          	auipc	ra,0x1
    627a:	0d2080e7          	jalr	210(ra) # 7348 <exit>
  }
  read(fd, sbrk(0) - 1, -1);
    627e:	4501                	li	a0,0
    6280:	00001097          	auipc	ra,0x1
    6284:	150080e7          	jalr	336(ra) # 73d0 <sbrk>
    6288:	87aa                	mv	a5,a0
    628a:	fff78713          	addi	a4,a5,-1
    628e:	fec42783          	lw	a5,-20(s0)
    6292:	567d                	li	a2,-1
    6294:	85ba                	mv	a1,a4
    6296:	853e                	mv	a0,a5
    6298:	00001097          	auipc	ra,0x1
    629c:	0c8080e7          	jalr	200(ra) # 7360 <read>
  close(fd);
    62a0:	fec42783          	lw	a5,-20(s0)
    62a4:	853e                	mv	a0,a5
    62a6:	00001097          	auipc	ra,0x1
    62aa:	0ca080e7          	jalr	202(ra) # 7370 <close>
}
    62ae:	0001                	nop
    62b0:	70a2                	ld	ra,40(sp)
    62b2:	7402                	ld	s0,32(sp)
    62b4:	6145                	addi	sp,sp,48
    62b6:	8082                	ret

00000000000062b8 <stacktest>:

// check that there's an invalid page beneath
// the user stack, to catch stack overflow.
void
stacktest(char *s)
{
    62b8:	7139                	addi	sp,sp,-64
    62ba:	fc06                	sd	ra,56(sp)
    62bc:	f822                	sd	s0,48(sp)
    62be:	0080                	addi	s0,sp,64
    62c0:	fca43423          	sd	a0,-56(s0)
  int pid;
  int xstatus;
  
  pid = fork();
    62c4:	00001097          	auipc	ra,0x1
    62c8:	07c080e7          	jalr	124(ra) # 7340 <fork>
    62cc:	87aa                	mv	a5,a0
    62ce:	fef42623          	sw	a5,-20(s0)
  if(pid == 0) {
    62d2:	fec42783          	lw	a5,-20(s0)
    62d6:	2781                	sext.w	a5,a5
    62d8:	e3b9                	bnez	a5,631e <stacktest+0x66>
    char *sp = (char *) r_sp();
    62da:	ffffa097          	auipc	ra,0xffffa
    62de:	d26080e7          	jalr	-730(ra) # 0 <r_sp>
    62e2:	87aa                	mv	a5,a0
    62e4:	fef43023          	sd	a5,-32(s0)
    sp -= PGSIZE;
    62e8:	fe043703          	ld	a4,-32(s0)
    62ec:	77fd                	lui	a5,0xfffff
    62ee:	97ba                	add	a5,a5,a4
    62f0:	fef43023          	sd	a5,-32(s0)
    // the *sp should cause a trap.
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    62f4:	fe043783          	ld	a5,-32(s0)
    62f8:	0007c783          	lbu	a5,0(a5) # fffffffffffff000 <__BSS_END__+0xfffffffffffee3c0>
    62fc:	2781                	sext.w	a5,a5
    62fe:	863e                	mv	a2,a5
    6300:	fc843583          	ld	a1,-56(s0)
    6304:	00004517          	auipc	a0,0x4
    6308:	af450513          	addi	a0,a0,-1292 # 9df8 <malloc+0x2380>
    630c:	00001097          	auipc	ra,0x1
    6310:	57a080e7          	jalr	1402(ra) # 7886 <printf>
    exit(1);
    6314:	4505                	li	a0,1
    6316:	00001097          	auipc	ra,0x1
    631a:	032080e7          	jalr	50(ra) # 7348 <exit>
  } else if(pid < 0){
    631e:	fec42783          	lw	a5,-20(s0)
    6322:	2781                	sext.w	a5,a5
    6324:	0207d163          	bgez	a5,6346 <stacktest+0x8e>
    printf("%s: fork failed\n", s);
    6328:	fc843583          	ld	a1,-56(s0)
    632c:	00002517          	auipc	a0,0x2
    6330:	02450513          	addi	a0,a0,36 # 8350 <malloc+0x8d8>
    6334:	00001097          	auipc	ra,0x1
    6338:	552080e7          	jalr	1362(ra) # 7886 <printf>
    exit(1);
    633c:	4505                	li	a0,1
    633e:	00001097          	auipc	ra,0x1
    6342:	00a080e7          	jalr	10(ra) # 7348 <exit>
  }
  wait(&xstatus);
    6346:	fdc40793          	addi	a5,s0,-36
    634a:	853e                	mv	a0,a5
    634c:	00001097          	auipc	ra,0x1
    6350:	004080e7          	jalr	4(ra) # 7350 <wait>
  if(xstatus == -1)  // kernel killed child?
    6354:	fdc42783          	lw	a5,-36(s0)
    6358:	873e                	mv	a4,a5
    635a:	57fd                	li	a5,-1
    635c:	00f71763          	bne	a4,a5,636a <stacktest+0xb2>
    exit(0);
    6360:	4501                	li	a0,0
    6362:	00001097          	auipc	ra,0x1
    6366:	fe6080e7          	jalr	-26(ra) # 7348 <exit>
  else
    exit(xstatus);
    636a:	fdc42783          	lw	a5,-36(s0)
    636e:	853e                	mv	a0,a5
    6370:	00001097          	auipc	ra,0x1
    6374:	fd8080e7          	jalr	-40(ra) # 7348 <exit>

0000000000006378 <pgbug>:
// regression test. copyin(), copyout(), and copyinstr() used to cast
// the virtual page address to uint, which (with certain wild system
// call arguments) resulted in a kernel page faults.
void
pgbug(char *s)
{
    6378:	7179                	addi	sp,sp,-48
    637a:	f406                	sd	ra,40(sp)
    637c:	f022                	sd	s0,32(sp)
    637e:	1800                	addi	s0,sp,48
    6380:	fca43c23          	sd	a0,-40(s0)
  char *argv[1];
  argv[0] = 0;
    6384:	fe043423          	sd	zero,-24(s0)
  exec((char*)0xeaeb0b5b00002f5e, argv);
    6388:	fe840713          	addi	a4,s0,-24
    638c:	00004797          	auipc	a5,0x4
    6390:	05c78793          	addi	a5,a5,92 # a3e8 <malloc+0x2970>
    6394:	639c                	ld	a5,0(a5)
    6396:	85ba                	mv	a1,a4
    6398:	853e                	mv	a0,a5
    639a:	00001097          	auipc	ra,0x1
    639e:	fe6080e7          	jalr	-26(ra) # 7380 <exec>

  pipe((int*)0xeaeb0b5b00002f5e);
    63a2:	00004797          	auipc	a5,0x4
    63a6:	04678793          	addi	a5,a5,70 # a3e8 <malloc+0x2970>
    63aa:	639c                	ld	a5,0(a5)
    63ac:	853e                	mv	a0,a5
    63ae:	00001097          	auipc	ra,0x1
    63b2:	faa080e7          	jalr	-86(ra) # 7358 <pipe>

  exit(0);
    63b6:	4501                	li	a0,0
    63b8:	00001097          	auipc	ra,0x1
    63bc:	f90080e7          	jalr	-112(ra) # 7348 <exit>

00000000000063c0 <sbrkbugs>:
// regression test. does the kernel panic if a process sbrk()s its
// size to be less than a page, or zero, or reduces the break by an
// amount too small to cause a page to be freed?
void
sbrkbugs(char *s)
{
    63c0:	7179                	addi	sp,sp,-48
    63c2:	f406                	sd	ra,40(sp)
    63c4:	f022                	sd	s0,32(sp)
    63c6:	1800                	addi	s0,sp,48
    63c8:	fca43c23          	sd	a0,-40(s0)
  int pid = fork();
    63cc:	00001097          	auipc	ra,0x1
    63d0:	f74080e7          	jalr	-140(ra) # 7340 <fork>
    63d4:	87aa                	mv	a5,a0
    63d6:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    63da:	fec42783          	lw	a5,-20(s0)
    63de:	2781                	sext.w	a5,a5
    63e0:	0007df63          	bgez	a5,63fe <sbrkbugs+0x3e>
    printf("fork failed\n");
    63e4:	00002517          	auipc	a0,0x2
    63e8:	d4450513          	addi	a0,a0,-700 # 8128 <malloc+0x6b0>
    63ec:	00001097          	auipc	ra,0x1
    63f0:	49a080e7          	jalr	1178(ra) # 7886 <printf>
    exit(1);
    63f4:	4505                	li	a0,1
    63f6:	00001097          	auipc	ra,0x1
    63fa:	f52080e7          	jalr	-174(ra) # 7348 <exit>
  }
  if(pid == 0){
    63fe:	fec42783          	lw	a5,-20(s0)
    6402:	2781                	sext.w	a5,a5
    6404:	eb85                	bnez	a5,6434 <sbrkbugs+0x74>
    int sz = (uint64) sbrk(0);
    6406:	4501                	li	a0,0
    6408:	00001097          	auipc	ra,0x1
    640c:	fc8080e7          	jalr	-56(ra) # 73d0 <sbrk>
    6410:	87aa                	mv	a5,a0
    6412:	fef42223          	sw	a5,-28(s0)
    // free all user memory; there used to be a bug that
    // would not adjust p->sz correctly in this case,
    // causing exit() to panic.
    sbrk(-sz);
    6416:	fe442783          	lw	a5,-28(s0)
    641a:	40f007bb          	negw	a5,a5
    641e:	2781                	sext.w	a5,a5
    6420:	853e                	mv	a0,a5
    6422:	00001097          	auipc	ra,0x1
    6426:	fae080e7          	jalr	-82(ra) # 73d0 <sbrk>
    // user page fault here.
    exit(0);
    642a:	4501                	li	a0,0
    642c:	00001097          	auipc	ra,0x1
    6430:	f1c080e7          	jalr	-228(ra) # 7348 <exit>
  }
  wait(0);
    6434:	4501                	li	a0,0
    6436:	00001097          	auipc	ra,0x1
    643a:	f1a080e7          	jalr	-230(ra) # 7350 <wait>

  pid = fork();
    643e:	00001097          	auipc	ra,0x1
    6442:	f02080e7          	jalr	-254(ra) # 7340 <fork>
    6446:	87aa                	mv	a5,a0
    6448:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    644c:	fec42783          	lw	a5,-20(s0)
    6450:	2781                	sext.w	a5,a5
    6452:	0007df63          	bgez	a5,6470 <sbrkbugs+0xb0>
    printf("fork failed\n");
    6456:	00002517          	auipc	a0,0x2
    645a:	cd250513          	addi	a0,a0,-814 # 8128 <malloc+0x6b0>
    645e:	00001097          	auipc	ra,0x1
    6462:	428080e7          	jalr	1064(ra) # 7886 <printf>
    exit(1);
    6466:	4505                	li	a0,1
    6468:	00001097          	auipc	ra,0x1
    646c:	ee0080e7          	jalr	-288(ra) # 7348 <exit>
  }
  if(pid == 0){
    6470:	fec42783          	lw	a5,-20(s0)
    6474:	2781                	sext.w	a5,a5
    6476:	eb9d                	bnez	a5,64ac <sbrkbugs+0xec>
    int sz = (uint64) sbrk(0);
    6478:	4501                	li	a0,0
    647a:	00001097          	auipc	ra,0x1
    647e:	f56080e7          	jalr	-170(ra) # 73d0 <sbrk>
    6482:	87aa                	mv	a5,a0
    6484:	fef42423          	sw	a5,-24(s0)
    // set the break to somewhere in the very first
    // page; there used to be a bug that would incorrectly
    // free the first page.
    sbrk(-(sz - 3500));
    6488:	6785                	lui	a5,0x1
    648a:	dac7871b          	addiw	a4,a5,-596
    648e:	fe842783          	lw	a5,-24(s0)
    6492:	40f707bb          	subw	a5,a4,a5
    6496:	2781                	sext.w	a5,a5
    6498:	853e                	mv	a0,a5
    649a:	00001097          	auipc	ra,0x1
    649e:	f36080e7          	jalr	-202(ra) # 73d0 <sbrk>
    exit(0);
    64a2:	4501                	li	a0,0
    64a4:	00001097          	auipc	ra,0x1
    64a8:	ea4080e7          	jalr	-348(ra) # 7348 <exit>
  }
  wait(0);
    64ac:	4501                	li	a0,0
    64ae:	00001097          	auipc	ra,0x1
    64b2:	ea2080e7          	jalr	-350(ra) # 7350 <wait>

  pid = fork();
    64b6:	00001097          	auipc	ra,0x1
    64ba:	e8a080e7          	jalr	-374(ra) # 7340 <fork>
    64be:	87aa                	mv	a5,a0
    64c0:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    64c4:	fec42783          	lw	a5,-20(s0)
    64c8:	2781                	sext.w	a5,a5
    64ca:	0007df63          	bgez	a5,64e8 <sbrkbugs+0x128>
    printf("fork failed\n");
    64ce:	00002517          	auipc	a0,0x2
    64d2:	c5a50513          	addi	a0,a0,-934 # 8128 <malloc+0x6b0>
    64d6:	00001097          	auipc	ra,0x1
    64da:	3b0080e7          	jalr	944(ra) # 7886 <printf>
    exit(1);
    64de:	4505                	li	a0,1
    64e0:	00001097          	auipc	ra,0x1
    64e4:	e68080e7          	jalr	-408(ra) # 7348 <exit>
  }
  if(pid == 0){
    64e8:	fec42783          	lw	a5,-20(s0)
    64ec:	2781                	sext.w	a5,a5
    64ee:	ef95                	bnez	a5,652a <sbrkbugs+0x16a>
    // set the break in the middle of a page.
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    64f0:	4501                	li	a0,0
    64f2:	00001097          	auipc	ra,0x1
    64f6:	ede080e7          	jalr	-290(ra) # 73d0 <sbrk>
    64fa:	87aa                	mv	a5,a0
    64fc:	2781                	sext.w	a5,a5
    64fe:	672d                	lui	a4,0xb
    6500:	8007071b          	addiw	a4,a4,-2048
    6504:	40f707bb          	subw	a5,a4,a5
    6508:	2781                	sext.w	a5,a5
    650a:	2781                	sext.w	a5,a5
    650c:	853e                	mv	a0,a5
    650e:	00001097          	auipc	ra,0x1
    6512:	ec2080e7          	jalr	-318(ra) # 73d0 <sbrk>

    // reduce the break a bit, but not enough to
    // cause a page to be freed. this used to cause
    // a panic.
    sbrk(-10);
    6516:	5559                	li	a0,-10
    6518:	00001097          	auipc	ra,0x1
    651c:	eb8080e7          	jalr	-328(ra) # 73d0 <sbrk>

    exit(0);
    6520:	4501                	li	a0,0
    6522:	00001097          	auipc	ra,0x1
    6526:	e26080e7          	jalr	-474(ra) # 7348 <exit>
  }
  wait(0);
    652a:	4501                	li	a0,0
    652c:	00001097          	auipc	ra,0x1
    6530:	e24080e7          	jalr	-476(ra) # 7350 <wait>

  exit(0);
    6534:	4501                	li	a0,0
    6536:	00001097          	auipc	ra,0x1
    653a:	e12080e7          	jalr	-494(ra) # 7348 <exit>

000000000000653e <sbrklast>:
// if process size was somewhat more than a page boundary, and then
// shrunk to be somewhat less than that page boundary, can the kernel
// still copyin() from addresses in the last page?
void
sbrklast(char *s)
{
    653e:	7139                	addi	sp,sp,-64
    6540:	fc06                	sd	ra,56(sp)
    6542:	f822                	sd	s0,48(sp)
    6544:	0080                	addi	s0,sp,64
    6546:	fca43423          	sd	a0,-56(s0)
  uint64 top = (uint64) sbrk(0);
    654a:	4501                	li	a0,0
    654c:	00001097          	auipc	ra,0x1
    6550:	e84080e7          	jalr	-380(ra) # 73d0 <sbrk>
    6554:	87aa                	mv	a5,a0
    6556:	fef43423          	sd	a5,-24(s0)
  if((top % 4096) != 0)
    655a:	fe843703          	ld	a4,-24(s0)
    655e:	6785                	lui	a5,0x1
    6560:	17fd                	addi	a5,a5,-1
    6562:	8ff9                	and	a5,a5,a4
    6564:	c39d                	beqz	a5,658a <sbrklast+0x4c>
    sbrk(4096 - (top % 4096));
    6566:	fe843783          	ld	a5,-24(s0)
    656a:	2781                	sext.w	a5,a5
    656c:	873e                	mv	a4,a5
    656e:	6785                	lui	a5,0x1
    6570:	17fd                	addi	a5,a5,-1
    6572:	8ff9                	and	a5,a5,a4
    6574:	2781                	sext.w	a5,a5
    6576:	6705                	lui	a4,0x1
    6578:	40f707bb          	subw	a5,a4,a5
    657c:	2781                	sext.w	a5,a5
    657e:	2781                	sext.w	a5,a5
    6580:	853e                	mv	a0,a5
    6582:	00001097          	auipc	ra,0x1
    6586:	e4e080e7          	jalr	-434(ra) # 73d0 <sbrk>
  sbrk(4096);
    658a:	6505                	lui	a0,0x1
    658c:	00001097          	auipc	ra,0x1
    6590:	e44080e7          	jalr	-444(ra) # 73d0 <sbrk>
  sbrk(10);
    6594:	4529                	li	a0,10
    6596:	00001097          	auipc	ra,0x1
    659a:	e3a080e7          	jalr	-454(ra) # 73d0 <sbrk>
  sbrk(-20);
    659e:	5531                	li	a0,-20
    65a0:	00001097          	auipc	ra,0x1
    65a4:	e30080e7          	jalr	-464(ra) # 73d0 <sbrk>
  top = (uint64) sbrk(0);
    65a8:	4501                	li	a0,0
    65aa:	00001097          	auipc	ra,0x1
    65ae:	e26080e7          	jalr	-474(ra) # 73d0 <sbrk>
    65b2:	87aa                	mv	a5,a0
    65b4:	fef43423          	sd	a5,-24(s0)
  char *p = (char *) (top - 64);
    65b8:	fe843783          	ld	a5,-24(s0)
    65bc:	fc078793          	addi	a5,a5,-64 # fc0 <truncate3+0x16a>
    65c0:	fef43023          	sd	a5,-32(s0)
  p[0] = 'x';
    65c4:	fe043783          	ld	a5,-32(s0)
    65c8:	07800713          	li	a4,120
    65cc:	00e78023          	sb	a4,0(a5)
  p[1] = '\0';
    65d0:	fe043783          	ld	a5,-32(s0)
    65d4:	0785                	addi	a5,a5,1
    65d6:	00078023          	sb	zero,0(a5)
  int fd = open(p, O_RDWR|O_CREATE);
    65da:	20200593          	li	a1,514
    65de:	fe043503          	ld	a0,-32(s0)
    65e2:	00001097          	auipc	ra,0x1
    65e6:	da6080e7          	jalr	-602(ra) # 7388 <open>
    65ea:	87aa                	mv	a5,a0
    65ec:	fcf42e23          	sw	a5,-36(s0)
  write(fd, p, 1);
    65f0:	fdc42783          	lw	a5,-36(s0)
    65f4:	4605                	li	a2,1
    65f6:	fe043583          	ld	a1,-32(s0)
    65fa:	853e                	mv	a0,a5
    65fc:	00001097          	auipc	ra,0x1
    6600:	d6c080e7          	jalr	-660(ra) # 7368 <write>
  close(fd);
    6604:	fdc42783          	lw	a5,-36(s0)
    6608:	853e                	mv	a0,a5
    660a:	00001097          	auipc	ra,0x1
    660e:	d66080e7          	jalr	-666(ra) # 7370 <close>
  fd = open(p, O_RDWR);
    6612:	4589                	li	a1,2
    6614:	fe043503          	ld	a0,-32(s0)
    6618:	00001097          	auipc	ra,0x1
    661c:	d70080e7          	jalr	-656(ra) # 7388 <open>
    6620:	87aa                	mv	a5,a0
    6622:	fcf42e23          	sw	a5,-36(s0)
  p[0] = '\0';
    6626:	fe043783          	ld	a5,-32(s0)
    662a:	00078023          	sb	zero,0(a5)
  read(fd, p, 1);
    662e:	fdc42783          	lw	a5,-36(s0)
    6632:	4605                	li	a2,1
    6634:	fe043583          	ld	a1,-32(s0)
    6638:	853e                	mv	a0,a5
    663a:	00001097          	auipc	ra,0x1
    663e:	d26080e7          	jalr	-730(ra) # 7360 <read>
  if(p[0] != 'x')
    6642:	fe043783          	ld	a5,-32(s0)
    6646:	0007c783          	lbu	a5,0(a5)
    664a:	873e                	mv	a4,a5
    664c:	07800793          	li	a5,120
    6650:	00f70763          	beq	a4,a5,665e <sbrklast+0x120>
    exit(1);
    6654:	4505                	li	a0,1
    6656:	00001097          	auipc	ra,0x1
    665a:	cf2080e7          	jalr	-782(ra) # 7348 <exit>
}
    665e:	0001                	nop
    6660:	70e2                	ld	ra,56(sp)
    6662:	7442                	ld	s0,48(sp)
    6664:	6121                	addi	sp,sp,64
    6666:	8082                	ret

0000000000006668 <sbrk8000>:

// does sbrk handle signed int32 wrap-around with
// negative arguments?
void
sbrk8000(char *s)
{
    6668:	7179                	addi	sp,sp,-48
    666a:	f406                	sd	ra,40(sp)
    666c:	f022                	sd	s0,32(sp)
    666e:	1800                	addi	s0,sp,48
    6670:	fca43c23          	sd	a0,-40(s0)
  sbrk(0x80000004);
    6674:	800007b7          	lui	a5,0x80000
    6678:	00478513          	addi	a0,a5,4 # ffffffff80000004 <__BSS_END__+0xffffffff7ffef3c4>
    667c:	00001097          	auipc	ra,0x1
    6680:	d54080e7          	jalr	-684(ra) # 73d0 <sbrk>
  volatile char *top = sbrk(0);
    6684:	4501                	li	a0,0
    6686:	00001097          	auipc	ra,0x1
    668a:	d4a080e7          	jalr	-694(ra) # 73d0 <sbrk>
    668e:	fea43423          	sd	a0,-24(s0)
  *(top-1) = *(top-1) + 1;
    6692:	fe843783          	ld	a5,-24(s0)
    6696:	17fd                	addi	a5,a5,-1
    6698:	0007c783          	lbu	a5,0(a5)
    669c:	0ff7f713          	andi	a4,a5,255
    66a0:	fe843783          	ld	a5,-24(s0)
    66a4:	17fd                	addi	a5,a5,-1
    66a6:	2705                	addiw	a4,a4,1
    66a8:	0ff77713          	andi	a4,a4,255
    66ac:	00e78023          	sb	a4,0(a5)
}
    66b0:	0001                	nop
    66b2:	70a2                	ld	ra,40(sp)
    66b4:	7402                	ld	s0,32(sp)
    66b6:	6145                	addi	sp,sp,48
    66b8:	8082                	ret

00000000000066ba <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
    66ba:	7179                	addi	sp,sp,-48
    66bc:	f406                	sd	ra,40(sp)
    66be:	f022                	sd	s0,32(sp)
    66c0:	1800                	addi	s0,sp,48
    66c2:	fca43c23          	sd	a0,-40(s0)
  int assumed_free = 600;
    66c6:	25800793          	li	a5,600
    66ca:	fef42423          	sw	a5,-24(s0)
  
  unlink("junk");
    66ce:	00003517          	auipc	a0,0x3
    66d2:	75250513          	addi	a0,a0,1874 # 9e20 <malloc+0x23a8>
    66d6:	00001097          	auipc	ra,0x1
    66da:	cc2080e7          	jalr	-830(ra) # 7398 <unlink>
  for(int i = 0; i < assumed_free; i++){
    66de:	fe042623          	sw	zero,-20(s0)
    66e2:	a8bd                	j	6760 <badwrite+0xa6>
    int fd = open("junk", O_CREATE|O_WRONLY);
    66e4:	20100593          	li	a1,513
    66e8:	00003517          	auipc	a0,0x3
    66ec:	73850513          	addi	a0,a0,1848 # 9e20 <malloc+0x23a8>
    66f0:	00001097          	auipc	ra,0x1
    66f4:	c98080e7          	jalr	-872(ra) # 7388 <open>
    66f8:	87aa                	mv	a5,a0
    66fa:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    66fe:	fe042783          	lw	a5,-32(s0)
    6702:	2781                	sext.w	a5,a5
    6704:	0007df63          	bgez	a5,6722 <badwrite+0x68>
      printf("open junk failed\n");
    6708:	00003517          	auipc	a0,0x3
    670c:	72050513          	addi	a0,a0,1824 # 9e28 <malloc+0x23b0>
    6710:	00001097          	auipc	ra,0x1
    6714:	176080e7          	jalr	374(ra) # 7886 <printf>
      exit(1);
    6718:	4505                	li	a0,1
    671a:	00001097          	auipc	ra,0x1
    671e:	c2e080e7          	jalr	-978(ra) # 7348 <exit>
    }
    write(fd, (char*)0xffffffffffL, 1);
    6722:	fe042703          	lw	a4,-32(s0)
    6726:	4605                	li	a2,1
    6728:	57fd                	li	a5,-1
    672a:	0187d593          	srli	a1,a5,0x18
    672e:	853a                	mv	a0,a4
    6730:	00001097          	auipc	ra,0x1
    6734:	c38080e7          	jalr	-968(ra) # 7368 <write>
    close(fd);
    6738:	fe042783          	lw	a5,-32(s0)
    673c:	853e                	mv	a0,a5
    673e:	00001097          	auipc	ra,0x1
    6742:	c32080e7          	jalr	-974(ra) # 7370 <close>
    unlink("junk");
    6746:	00003517          	auipc	a0,0x3
    674a:	6da50513          	addi	a0,a0,1754 # 9e20 <malloc+0x23a8>
    674e:	00001097          	auipc	ra,0x1
    6752:	c4a080e7          	jalr	-950(ra) # 7398 <unlink>
  for(int i = 0; i < assumed_free; i++){
    6756:	fec42783          	lw	a5,-20(s0)
    675a:	2785                	addiw	a5,a5,1
    675c:	fef42623          	sw	a5,-20(s0)
    6760:	fec42703          	lw	a4,-20(s0)
    6764:	fe842783          	lw	a5,-24(s0)
    6768:	2701                	sext.w	a4,a4
    676a:	2781                	sext.w	a5,a5
    676c:	f6f74ce3          	blt	a4,a5,66e4 <badwrite+0x2a>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
    6770:	20100593          	li	a1,513
    6774:	00003517          	auipc	a0,0x3
    6778:	6ac50513          	addi	a0,a0,1708 # 9e20 <malloc+0x23a8>
    677c:	00001097          	auipc	ra,0x1
    6780:	c0c080e7          	jalr	-1012(ra) # 7388 <open>
    6784:	87aa                	mv	a5,a0
    6786:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    678a:	fe442783          	lw	a5,-28(s0)
    678e:	2781                	sext.w	a5,a5
    6790:	0007df63          	bgez	a5,67ae <badwrite+0xf4>
    printf("open junk failed\n");
    6794:	00003517          	auipc	a0,0x3
    6798:	69450513          	addi	a0,a0,1684 # 9e28 <malloc+0x23b0>
    679c:	00001097          	auipc	ra,0x1
    67a0:	0ea080e7          	jalr	234(ra) # 7886 <printf>
    exit(1);
    67a4:	4505                	li	a0,1
    67a6:	00001097          	auipc	ra,0x1
    67aa:	ba2080e7          	jalr	-1118(ra) # 7348 <exit>
  }
  if(write(fd, "x", 1) != 1){
    67ae:	fe442783          	lw	a5,-28(s0)
    67b2:	4605                	li	a2,1
    67b4:	00002597          	auipc	a1,0x2
    67b8:	87458593          	addi	a1,a1,-1932 # 8028 <malloc+0x5b0>
    67bc:	853e                	mv	a0,a5
    67be:	00001097          	auipc	ra,0x1
    67c2:	baa080e7          	jalr	-1110(ra) # 7368 <write>
    67c6:	87aa                	mv	a5,a0
    67c8:	873e                	mv	a4,a5
    67ca:	4785                	li	a5,1
    67cc:	00f70f63          	beq	a4,a5,67ea <badwrite+0x130>
    printf("write failed\n");
    67d0:	00003517          	auipc	a0,0x3
    67d4:	67050513          	addi	a0,a0,1648 # 9e40 <malloc+0x23c8>
    67d8:	00001097          	auipc	ra,0x1
    67dc:	0ae080e7          	jalr	174(ra) # 7886 <printf>
    exit(1);
    67e0:	4505                	li	a0,1
    67e2:	00001097          	auipc	ra,0x1
    67e6:	b66080e7          	jalr	-1178(ra) # 7348 <exit>
  }
  close(fd);
    67ea:	fe442783          	lw	a5,-28(s0)
    67ee:	853e                	mv	a0,a5
    67f0:	00001097          	auipc	ra,0x1
    67f4:	b80080e7          	jalr	-1152(ra) # 7370 <close>
  unlink("junk");
    67f8:	00003517          	auipc	a0,0x3
    67fc:	62850513          	addi	a0,a0,1576 # 9e20 <malloc+0x23a8>
    6800:	00001097          	auipc	ra,0x1
    6804:	b98080e7          	jalr	-1128(ra) # 7398 <unlink>

  exit(0);
    6808:	4501                	li	a0,0
    680a:	00001097          	auipc	ra,0x1
    680e:	b3e080e7          	jalr	-1218(ra) # 7348 <exit>

0000000000006812 <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    6812:	7139                	addi	sp,sp,-64
    6814:	fc06                	sd	ra,56(sp)
    6816:	f822                	sd	s0,48(sp)
    6818:	0080                	addi	s0,sp,64
    681a:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 50000; i++){
    681e:	fe042623          	sw	zero,-20(s0)
    6822:	a03d                	j	6850 <badarg+0x3e>
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    6824:	57fd                	li	a5,-1
    6826:	9381                	srli	a5,a5,0x20
    6828:	fcf43c23          	sd	a5,-40(s0)
    argv[1] = 0;
    682c:	fe043023          	sd	zero,-32(s0)
    exec("echo", argv);
    6830:	fd840793          	addi	a5,s0,-40
    6834:	85be                	mv	a1,a5
    6836:	00002517          	auipc	a0,0x2
    683a:	90250513          	addi	a0,a0,-1790 # 8138 <malloc+0x6c0>
    683e:	00001097          	auipc	ra,0x1
    6842:	b42080e7          	jalr	-1214(ra) # 7380 <exec>
  for(int i = 0; i < 50000; i++){
    6846:	fec42783          	lw	a5,-20(s0)
    684a:	2785                	addiw	a5,a5,1
    684c:	fef42623          	sw	a5,-20(s0)
    6850:	fec42783          	lw	a5,-20(s0)
    6854:	0007871b          	sext.w	a4,a5
    6858:	67b1                	lui	a5,0xc
    685a:	34f78793          	addi	a5,a5,847 # c34f <__global_pointer$+0x1746>
    685e:	fce7d3e3          	bge	a5,a4,6824 <badarg+0x12>
  }
  
  exit(0);
    6862:	4501                	li	a0,0
    6864:	00001097          	auipc	ra,0x1
    6868:	ae4080e7          	jalr	-1308(ra) # 7348 <exit>

000000000000686c <execout>:
// test the exec() code that cleans up if it runs out
// of memory. it's really a test that such a condition
// doesn't cause a panic.
void
execout(char *s)
{
    686c:	715d                	addi	sp,sp,-80
    686e:	e486                	sd	ra,72(sp)
    6870:	e0a2                	sd	s0,64(sp)
    6872:	0880                	addi	s0,sp,80
    6874:	faa43c23          	sd	a0,-72(s0)
  for(int avail = 0; avail < 15; avail++){
    6878:	fe042623          	sw	zero,-20(s0)
    687c:	a8c5                	j	696c <execout+0x100>
    int pid = fork();
    687e:	00001097          	auipc	ra,0x1
    6882:	ac2080e7          	jalr	-1342(ra) # 7340 <fork>
    6886:	87aa                	mv	a5,a0
    6888:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    688c:	fe442783          	lw	a5,-28(s0)
    6890:	2781                	sext.w	a5,a5
    6892:	0007df63          	bgez	a5,68b0 <execout+0x44>
      printf("fork failed\n");
    6896:	00002517          	auipc	a0,0x2
    689a:	89250513          	addi	a0,a0,-1902 # 8128 <malloc+0x6b0>
    689e:	00001097          	auipc	ra,0x1
    68a2:	fe8080e7          	jalr	-24(ra) # 7886 <printf>
      exit(1);
    68a6:	4505                	li	a0,1
    68a8:	00001097          	auipc	ra,0x1
    68ac:	aa0080e7          	jalr	-1376(ra) # 7348 <exit>
    } else if(pid == 0){
    68b0:	fe442783          	lw	a5,-28(s0)
    68b4:	2781                	sext.w	a5,a5
    68b6:	e3cd                	bnez	a5,6958 <execout+0xec>
      // allocate all of memory.
      while(1){
        uint64 a = (uint64) sbrk(4096);
    68b8:	6505                	lui	a0,0x1
    68ba:	00001097          	auipc	ra,0x1
    68be:	b16080e7          	jalr	-1258(ra) # 73d0 <sbrk>
    68c2:	87aa                	mv	a5,a0
    68c4:	fcf43c23          	sd	a5,-40(s0)
        if(a == 0xffffffffffffffffLL)
    68c8:	fd843703          	ld	a4,-40(s0)
    68cc:	57fd                	li	a5,-1
    68ce:	00f70c63          	beq	a4,a5,68e6 <execout+0x7a>
          break;
        *(char*)(a + 4096 - 1) = 1;
    68d2:	fd843703          	ld	a4,-40(s0)
    68d6:	6785                	lui	a5,0x1
    68d8:	17fd                	addi	a5,a5,-1
    68da:	97ba                	add	a5,a5,a4
    68dc:	873e                	mv	a4,a5
    68de:	4785                	li	a5,1
    68e0:	00f70023          	sb	a5,0(a4) # 1000 <truncate3+0x1aa>
      while(1){
    68e4:	bfd1                	j	68b8 <execout+0x4c>
          break;
    68e6:	0001                	nop
      }

      // free a few pages, in order to let exec() make some
      // progress.
      for(int i = 0; i < avail; i++)
    68e8:	fe042423          	sw	zero,-24(s0)
    68ec:	a819                	j	6902 <execout+0x96>
        sbrk(-4096);
    68ee:	757d                	lui	a0,0xfffff
    68f0:	00001097          	auipc	ra,0x1
    68f4:	ae0080e7          	jalr	-1312(ra) # 73d0 <sbrk>
      for(int i = 0; i < avail; i++)
    68f8:	fe842783          	lw	a5,-24(s0)
    68fc:	2785                	addiw	a5,a5,1
    68fe:	fef42423          	sw	a5,-24(s0)
    6902:	fe842703          	lw	a4,-24(s0)
    6906:	fec42783          	lw	a5,-20(s0)
    690a:	2701                	sext.w	a4,a4
    690c:	2781                	sext.w	a5,a5
    690e:	fef740e3          	blt	a4,a5,68ee <execout+0x82>
      
      close(1);
    6912:	4505                	li	a0,1
    6914:	00001097          	auipc	ra,0x1
    6918:	a5c080e7          	jalr	-1444(ra) # 7370 <close>
      char *args[] = { "echo", "x", 0 };
    691c:	00002797          	auipc	a5,0x2
    6920:	81c78793          	addi	a5,a5,-2020 # 8138 <malloc+0x6c0>
    6924:	fcf43023          	sd	a5,-64(s0)
    6928:	00001797          	auipc	a5,0x1
    692c:	70078793          	addi	a5,a5,1792 # 8028 <malloc+0x5b0>
    6930:	fcf43423          	sd	a5,-56(s0)
    6934:	fc043823          	sd	zero,-48(s0)
      exec("echo", args);
    6938:	fc040793          	addi	a5,s0,-64
    693c:	85be                	mv	a1,a5
    693e:	00001517          	auipc	a0,0x1
    6942:	7fa50513          	addi	a0,a0,2042 # 8138 <malloc+0x6c0>
    6946:	00001097          	auipc	ra,0x1
    694a:	a3a080e7          	jalr	-1478(ra) # 7380 <exec>
      exit(0);
    694e:	4501                	li	a0,0
    6950:	00001097          	auipc	ra,0x1
    6954:	9f8080e7          	jalr	-1544(ra) # 7348 <exit>
    } else {
      wait((int*)0);
    6958:	4501                	li	a0,0
    695a:	00001097          	auipc	ra,0x1
    695e:	9f6080e7          	jalr	-1546(ra) # 7350 <wait>
  for(int avail = 0; avail < 15; avail++){
    6962:	fec42783          	lw	a5,-20(s0)
    6966:	2785                	addiw	a5,a5,1
    6968:	fef42623          	sw	a5,-20(s0)
    696c:	fec42783          	lw	a5,-20(s0)
    6970:	0007871b          	sext.w	a4,a5
    6974:	47b9                	li	a5,14
    6976:	f0e7d4e3          	bge	a5,a4,687e <execout+0x12>
    }
  }

  exit(0);
    697a:	4501                	li	a0,0
    697c:	00001097          	auipc	ra,0x1
    6980:	9cc080e7          	jalr	-1588(ra) # 7348 <exit>

0000000000006984 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    6984:	7139                	addi	sp,sp,-64
    6986:	fc06                	sd	ra,56(sp)
    6988:	f822                	sd	s0,48(sp)
    698a:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    698c:	fd040793          	addi	a5,s0,-48
    6990:	853e                	mv	a0,a5
    6992:	00001097          	auipc	ra,0x1
    6996:	9c6080e7          	jalr	-1594(ra) # 7358 <pipe>
    699a:	87aa                	mv	a5,a0
    699c:	0007df63          	bgez	a5,69ba <countfree+0x36>
    printf("pipe() failed in countfree()\n");
    69a0:	00003517          	auipc	a0,0x3
    69a4:	4b050513          	addi	a0,a0,1200 # 9e50 <malloc+0x23d8>
    69a8:	00001097          	auipc	ra,0x1
    69ac:	ede080e7          	jalr	-290(ra) # 7886 <printf>
    exit(1);
    69b0:	4505                	li	a0,1
    69b2:	00001097          	auipc	ra,0x1
    69b6:	996080e7          	jalr	-1642(ra) # 7348 <exit>
  }
  
  int pid = fork();
    69ba:	00001097          	auipc	ra,0x1
    69be:	986080e7          	jalr	-1658(ra) # 7340 <fork>
    69c2:	87aa                	mv	a5,a0
    69c4:	fef42423          	sw	a5,-24(s0)

  if(pid < 0){
    69c8:	fe842783          	lw	a5,-24(s0)
    69cc:	2781                	sext.w	a5,a5
    69ce:	0007df63          	bgez	a5,69ec <countfree+0x68>
    printf("fork failed in countfree()\n");
    69d2:	00003517          	auipc	a0,0x3
    69d6:	49e50513          	addi	a0,a0,1182 # 9e70 <malloc+0x23f8>
    69da:	00001097          	auipc	ra,0x1
    69de:	eac080e7          	jalr	-340(ra) # 7886 <printf>
    exit(1);
    69e2:	4505                	li	a0,1
    69e4:	00001097          	auipc	ra,0x1
    69e8:	964080e7          	jalr	-1692(ra) # 7348 <exit>
  }

  if(pid == 0){
    69ec:	fe842783          	lw	a5,-24(s0)
    69f0:	2781                	sext.w	a5,a5
    69f2:	e3d1                	bnez	a5,6a76 <countfree+0xf2>
    close(fds[0]);
    69f4:	fd042783          	lw	a5,-48(s0)
    69f8:	853e                	mv	a0,a5
    69fa:	00001097          	auipc	ra,0x1
    69fe:	976080e7          	jalr	-1674(ra) # 7370 <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
    6a02:	6505                	lui	a0,0x1
    6a04:	00001097          	auipc	ra,0x1
    6a08:	9cc080e7          	jalr	-1588(ra) # 73d0 <sbrk>
    6a0c:	87aa                	mv	a5,a0
    6a0e:	fcf43c23          	sd	a5,-40(s0)
      if(a == 0xffffffffffffffff){
    6a12:	fd843703          	ld	a4,-40(s0)
    6a16:	57fd                	li	a5,-1
    6a18:	04f70963          	beq	a4,a5,6a6a <countfree+0xe6>
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    6a1c:	fd843703          	ld	a4,-40(s0)
    6a20:	6785                	lui	a5,0x1
    6a22:	17fd                	addi	a5,a5,-1
    6a24:	97ba                	add	a5,a5,a4
    6a26:	873e                	mv	a4,a5
    6a28:	4785                	li	a5,1
    6a2a:	00f70023          	sb	a5,0(a4)

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    6a2e:	fd442783          	lw	a5,-44(s0)
    6a32:	4605                	li	a2,1
    6a34:	00001597          	auipc	a1,0x1
    6a38:	5f458593          	addi	a1,a1,1524 # 8028 <malloc+0x5b0>
    6a3c:	853e                	mv	a0,a5
    6a3e:	00001097          	auipc	ra,0x1
    6a42:	92a080e7          	jalr	-1750(ra) # 7368 <write>
    6a46:	87aa                	mv	a5,a0
    6a48:	873e                	mv	a4,a5
    6a4a:	4785                	li	a5,1
    6a4c:	faf70be3          	beq	a4,a5,6a02 <countfree+0x7e>
        printf("write() failed in countfree()\n");
    6a50:	00003517          	auipc	a0,0x3
    6a54:	44050513          	addi	a0,a0,1088 # 9e90 <malloc+0x2418>
    6a58:	00001097          	auipc	ra,0x1
    6a5c:	e2e080e7          	jalr	-466(ra) # 7886 <printf>
        exit(1);
    6a60:	4505                	li	a0,1
    6a62:	00001097          	auipc	ra,0x1
    6a66:	8e6080e7          	jalr	-1818(ra) # 7348 <exit>
        break;
    6a6a:	0001                	nop
      }
    }

    exit(0);
    6a6c:	4501                	li	a0,0
    6a6e:	00001097          	auipc	ra,0x1
    6a72:	8da080e7          	jalr	-1830(ra) # 7348 <exit>
  }

  close(fds[1]);
    6a76:	fd442783          	lw	a5,-44(s0)
    6a7a:	853e                	mv	a0,a5
    6a7c:	00001097          	auipc	ra,0x1
    6a80:	8f4080e7          	jalr	-1804(ra) # 7370 <close>

  int n = 0;
    6a84:	fe042623          	sw	zero,-20(s0)
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    6a88:	fd042783          	lw	a5,-48(s0)
    6a8c:	fcf40713          	addi	a4,s0,-49
    6a90:	4605                	li	a2,1
    6a92:	85ba                	mv	a1,a4
    6a94:	853e                	mv	a0,a5
    6a96:	00001097          	auipc	ra,0x1
    6a9a:	8ca080e7          	jalr	-1846(ra) # 7360 <read>
    6a9e:	87aa                	mv	a5,a0
    6aa0:	fef42223          	sw	a5,-28(s0)
    if(cc < 0){
    6aa4:	fe442783          	lw	a5,-28(s0)
    6aa8:	2781                	sext.w	a5,a5
    6aaa:	0007df63          	bgez	a5,6ac8 <countfree+0x144>
      printf("read() failed in countfree()\n");
    6aae:	00003517          	auipc	a0,0x3
    6ab2:	40250513          	addi	a0,a0,1026 # 9eb0 <malloc+0x2438>
    6ab6:	00001097          	auipc	ra,0x1
    6aba:	dd0080e7          	jalr	-560(ra) # 7886 <printf>
      exit(1);
    6abe:	4505                	li	a0,1
    6ac0:	00001097          	auipc	ra,0x1
    6ac4:	888080e7          	jalr	-1912(ra) # 7348 <exit>
    }
    if(cc == 0)
    6ac8:	fe442783          	lw	a5,-28(s0)
    6acc:	2781                	sext.w	a5,a5
    6ace:	e385                	bnez	a5,6aee <countfree+0x16a>
      break;
    n += 1;
  }

  close(fds[0]);
    6ad0:	fd042783          	lw	a5,-48(s0)
    6ad4:	853e                	mv	a0,a5
    6ad6:	00001097          	auipc	ra,0x1
    6ada:	89a080e7          	jalr	-1894(ra) # 7370 <close>
  wait((int*)0);
    6ade:	4501                	li	a0,0
    6ae0:	00001097          	auipc	ra,0x1
    6ae4:	870080e7          	jalr	-1936(ra) # 7350 <wait>
  
  return n;
    6ae8:	fec42783          	lw	a5,-20(s0)
    6aec:	a039                	j	6afa <countfree+0x176>
    n += 1;
    6aee:	fec42783          	lw	a5,-20(s0)
    6af2:	2785                	addiw	a5,a5,1
    6af4:	fef42623          	sw	a5,-20(s0)
  while(1){
    6af8:	bf41                	j	6a88 <countfree+0x104>
}
    6afa:	853e                	mv	a0,a5
    6afc:	70e2                	ld	ra,56(sp)
    6afe:	7442                	ld	s0,48(sp)
    6b00:	6121                	addi	sp,sp,64
    6b02:	8082                	ret

0000000000006b04 <run>:

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    6b04:	7179                	addi	sp,sp,-48
    6b06:	f406                	sd	ra,40(sp)
    6b08:	f022                	sd	s0,32(sp)
    6b0a:	1800                	addi	s0,sp,48
    6b0c:	fca43c23          	sd	a0,-40(s0)
    6b10:	fcb43823          	sd	a1,-48(s0)
  int pid;
  int xstatus;

  printf("test %s: ", s);
    6b14:	fd043583          	ld	a1,-48(s0)
    6b18:	00003517          	auipc	a0,0x3
    6b1c:	3b850513          	addi	a0,a0,952 # 9ed0 <malloc+0x2458>
    6b20:	00001097          	auipc	ra,0x1
    6b24:	d66080e7          	jalr	-666(ra) # 7886 <printf>
  if((pid = fork()) < 0) {
    6b28:	00001097          	auipc	ra,0x1
    6b2c:	818080e7          	jalr	-2024(ra) # 7340 <fork>
    6b30:	87aa                	mv	a5,a0
    6b32:	fef42623          	sw	a5,-20(s0)
    6b36:	fec42783          	lw	a5,-20(s0)
    6b3a:	2781                	sext.w	a5,a5
    6b3c:	0007df63          	bgez	a5,6b5a <run+0x56>
    printf("runtest: fork error\n");
    6b40:	00003517          	auipc	a0,0x3
    6b44:	3a050513          	addi	a0,a0,928 # 9ee0 <malloc+0x2468>
    6b48:	00001097          	auipc	ra,0x1
    6b4c:	d3e080e7          	jalr	-706(ra) # 7886 <printf>
    exit(1);
    6b50:	4505                	li	a0,1
    6b52:	00000097          	auipc	ra,0x0
    6b56:	7f6080e7          	jalr	2038(ra) # 7348 <exit>
  }
  if(pid == 0) {
    6b5a:	fec42783          	lw	a5,-20(s0)
    6b5e:	2781                	sext.w	a5,a5
    6b60:	eb99                	bnez	a5,6b76 <run+0x72>
    f(s);
    6b62:	fd843783          	ld	a5,-40(s0)
    6b66:	fd043503          	ld	a0,-48(s0)
    6b6a:	9782                	jalr	a5
    exit(0);
    6b6c:	4501                	li	a0,0
    6b6e:	00000097          	auipc	ra,0x0
    6b72:	7da080e7          	jalr	2010(ra) # 7348 <exit>
  } else {
    wait(&xstatus);
    6b76:	fe840793          	addi	a5,s0,-24
    6b7a:	853e                	mv	a0,a5
    6b7c:	00000097          	auipc	ra,0x0
    6b80:	7d4080e7          	jalr	2004(ra) # 7350 <wait>
    if(xstatus != 0) 
    6b84:	fe842783          	lw	a5,-24(s0)
    6b88:	cb91                	beqz	a5,6b9c <run+0x98>
      printf("FAILED\n");
    6b8a:	00003517          	auipc	a0,0x3
    6b8e:	36e50513          	addi	a0,a0,878 # 9ef8 <malloc+0x2480>
    6b92:	00001097          	auipc	ra,0x1
    6b96:	cf4080e7          	jalr	-780(ra) # 7886 <printf>
    6b9a:	a809                	j	6bac <run+0xa8>
    else
      printf("OK\n");
    6b9c:	00003517          	auipc	a0,0x3
    6ba0:	36450513          	addi	a0,a0,868 # 9f00 <malloc+0x2488>
    6ba4:	00001097          	auipc	ra,0x1
    6ba8:	ce2080e7          	jalr	-798(ra) # 7886 <printf>
    return xstatus == 0;
    6bac:	fe842783          	lw	a5,-24(s0)
    6bb0:	0017b793          	seqz	a5,a5
    6bb4:	0ff7f793          	andi	a5,a5,255
    6bb8:	2781                	sext.w	a5,a5
  }
}
    6bba:	853e                	mv	a0,a5
    6bbc:	70a2                	ld	ra,40(sp)
    6bbe:	7402                	ld	s0,32(sp)
    6bc0:	6145                	addi	sp,sp,48
    6bc2:	8082                	ret

0000000000006bc4 <main>:

int
main(int argc, char *argv[])
{
    6bc4:	bb010113          	addi	sp,sp,-1104
    6bc8:	44113423          	sd	ra,1096(sp)
    6bcc:	44813023          	sd	s0,1088(sp)
    6bd0:	45010413          	addi	s0,sp,1104
    6bd4:	87aa                	mv	a5,a0
    6bd6:	bab43823          	sd	a1,-1104(s0)
    6bda:	baf42e23          	sw	a5,-1092(s0)
  int continuous = 0;
    6bde:	fe042623          	sw	zero,-20(s0)
  char *justone = 0;
    6be2:	fe043023          	sd	zero,-32(s0)

  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    6be6:	bbc42783          	lw	a5,-1092(s0)
    6bea:	0007871b          	sext.w	a4,a5
    6bee:	4789                	li	a5,2
    6bf0:	02f71563          	bne	a4,a5,6c1a <main+0x56>
    6bf4:	bb043783          	ld	a5,-1104(s0)
    6bf8:	07a1                	addi	a5,a5,8
    6bfa:	639c                	ld	a5,0(a5)
    6bfc:	00003597          	auipc	a1,0x3
    6c00:	30c58593          	addi	a1,a1,780 # 9f08 <malloc+0x2490>
    6c04:	853e                	mv	a0,a5
    6c06:	00000097          	auipc	ra,0x0
    6c0a:	2fc080e7          	jalr	764(ra) # 6f02 <strcmp>
    6c0e:	87aa                	mv	a5,a0
    6c10:	e789                	bnez	a5,6c1a <main+0x56>
    continuous = 1;
    6c12:	4785                	li	a5,1
    6c14:	fef42623          	sw	a5,-20(s0)
    6c18:	a079                	j	6ca6 <main+0xe2>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    6c1a:	bbc42783          	lw	a5,-1092(s0)
    6c1e:	0007871b          	sext.w	a4,a5
    6c22:	4789                	li	a5,2
    6c24:	02f71563          	bne	a4,a5,6c4e <main+0x8a>
    6c28:	bb043783          	ld	a5,-1104(s0)
    6c2c:	07a1                	addi	a5,a5,8
    6c2e:	639c                	ld	a5,0(a5)
    6c30:	00003597          	auipc	a1,0x3
    6c34:	2e058593          	addi	a1,a1,736 # 9f10 <malloc+0x2498>
    6c38:	853e                	mv	a0,a5
    6c3a:	00000097          	auipc	ra,0x0
    6c3e:	2c8080e7          	jalr	712(ra) # 6f02 <strcmp>
    6c42:	87aa                	mv	a5,a0
    6c44:	e789                	bnez	a5,6c4e <main+0x8a>
    continuous = 2;
    6c46:	4789                	li	a5,2
    6c48:	fef42623          	sw	a5,-20(s0)
    6c4c:	a8a9                	j	6ca6 <main+0xe2>
  } else if(argc == 2 && argv[1][0] != '-'){
    6c4e:	bbc42783          	lw	a5,-1092(s0)
    6c52:	0007871b          	sext.w	a4,a5
    6c56:	4789                	li	a5,2
    6c58:	02f71363          	bne	a4,a5,6c7e <main+0xba>
    6c5c:	bb043783          	ld	a5,-1104(s0)
    6c60:	07a1                	addi	a5,a5,8
    6c62:	639c                	ld	a5,0(a5)
    6c64:	0007c783          	lbu	a5,0(a5) # 1000 <truncate3+0x1aa>
    6c68:	873e                	mv	a4,a5
    6c6a:	02d00793          	li	a5,45
    6c6e:	00f70863          	beq	a4,a5,6c7e <main+0xba>
    justone = argv[1];
    6c72:	bb043783          	ld	a5,-1104(s0)
    6c76:	679c                	ld	a5,8(a5)
    6c78:	fef43023          	sd	a5,-32(s0)
    6c7c:	a02d                	j	6ca6 <main+0xe2>
  } else if(argc > 1){
    6c7e:	bbc42783          	lw	a5,-1092(s0)
    6c82:	0007871b          	sext.w	a4,a5
    6c86:	4785                	li	a5,1
    6c88:	00e7df63          	bge	a5,a4,6ca6 <main+0xe2>
    printf("Usage: usertests [-c] [testname]\n");
    6c8c:	00003517          	auipc	a0,0x3
    6c90:	28c50513          	addi	a0,a0,652 # 9f18 <malloc+0x24a0>
    6c94:	00001097          	auipc	ra,0x1
    6c98:	bf2080e7          	jalr	-1038(ra) # 7886 <printf>
    exit(1);
    6c9c:	4505                	li	a0,1
    6c9e:	00000097          	auipc	ra,0x0
    6ca2:	6aa080e7          	jalr	1706(ra) # 7348 <exit>
  }
  
  struct test {
    void (*f)(char *);
    char *s;
  } tests[] = {
    6ca6:	00003717          	auipc	a4,0x3
    6caa:	35270713          	addi	a4,a4,850 # 9ff8 <malloc+0x2580>
    6cae:	bc040793          	addi	a5,s0,-1088
    6cb2:	86ba                	mv	a3,a4
    6cb4:	3f000713          	li	a4,1008
    6cb8:	863a                	mv	a2,a4
    6cba:	85b6                	mv	a1,a3
    6cbc:	853e                	mv	a0,a5
    6cbe:	00000097          	auipc	ra,0x0
    6cc2:	64a080e7          	jalr	1610(ra) # 7308 <memcpy>
    {forktest, "forktest"},
    {bigdir, "bigdir"}, // slow
    { 0, 0},
  };

  if(continuous){
    6cc6:	fec42783          	lw	a5,-20(s0)
    6cca:	2781                	sext.w	a5,a5
    6ccc:	c7ed                	beqz	a5,6db6 <main+0x1f2>
    printf("continuous usertests starting\n");
    6cce:	00003517          	auipc	a0,0x3
    6cd2:	27250513          	addi	a0,a0,626 # 9f40 <malloc+0x24c8>
    6cd6:	00001097          	auipc	ra,0x1
    6cda:	bb0080e7          	jalr	-1104(ra) # 7886 <printf>
    while(1){
      int fail = 0;
    6cde:	fc042e23          	sw	zero,-36(s0)
      int free0 = countfree();
    6ce2:	00000097          	auipc	ra,0x0
    6ce6:	ca2080e7          	jalr	-862(ra) # 6984 <countfree>
    6cea:	87aa                	mv	a5,a0
    6cec:	faf42a23          	sw	a5,-76(s0)
      for (struct test *t = tests; t->s != 0; t++) {
    6cf0:	bc040793          	addi	a5,s0,-1088
    6cf4:	fcf43823          	sd	a5,-48(s0)
    6cf8:	a805                	j	6d28 <main+0x164>
        if(!run(t->f, t->s)){
    6cfa:	fd043783          	ld	a5,-48(s0)
    6cfe:	6398                	ld	a4,0(a5)
    6d00:	fd043783          	ld	a5,-48(s0)
    6d04:	679c                	ld	a5,8(a5)
    6d06:	85be                	mv	a1,a5
    6d08:	853a                	mv	a0,a4
    6d0a:	00000097          	auipc	ra,0x0
    6d0e:	dfa080e7          	jalr	-518(ra) # 6b04 <run>
    6d12:	87aa                	mv	a5,a0
    6d14:	e789                	bnez	a5,6d1e <main+0x15a>
          fail = 1;
    6d16:	4785                	li	a5,1
    6d18:	fcf42e23          	sw	a5,-36(s0)
          break;
    6d1c:	a811                	j	6d30 <main+0x16c>
      for (struct test *t = tests; t->s != 0; t++) {
    6d1e:	fd043783          	ld	a5,-48(s0)
    6d22:	07c1                	addi	a5,a5,16
    6d24:	fcf43823          	sd	a5,-48(s0)
    6d28:	fd043783          	ld	a5,-48(s0)
    6d2c:	679c                	ld	a5,8(a5)
    6d2e:	f7f1                	bnez	a5,6cfa <main+0x136>
        }
      }
      if(fail){
    6d30:	fdc42783          	lw	a5,-36(s0)
    6d34:	2781                	sext.w	a5,a5
    6d36:	c78d                	beqz	a5,6d60 <main+0x19c>
        printf("SOME TESTS FAILED\n");
    6d38:	00003517          	auipc	a0,0x3
    6d3c:	22850513          	addi	a0,a0,552 # 9f60 <malloc+0x24e8>
    6d40:	00001097          	auipc	ra,0x1
    6d44:	b46080e7          	jalr	-1210(ra) # 7886 <printf>
        if(continuous != 2)
    6d48:	fec42783          	lw	a5,-20(s0)
    6d4c:	0007871b          	sext.w	a4,a5
    6d50:	4789                	li	a5,2
    6d52:	00f70763          	beq	a4,a5,6d60 <main+0x19c>
          exit(1);
    6d56:	4505                	li	a0,1
    6d58:	00000097          	auipc	ra,0x0
    6d5c:	5f0080e7          	jalr	1520(ra) # 7348 <exit>
      }
      int free1 = countfree();
    6d60:	00000097          	auipc	ra,0x0
    6d64:	c24080e7          	jalr	-988(ra) # 6984 <countfree>
    6d68:	87aa                	mv	a5,a0
    6d6a:	faf42823          	sw	a5,-80(s0)
      if(free1 < free0){
    6d6e:	fb042703          	lw	a4,-80(s0)
    6d72:	fb442783          	lw	a5,-76(s0)
    6d76:	2701                	sext.w	a4,a4
    6d78:	2781                	sext.w	a5,a5
    6d7a:	f6f752e3          	bge	a4,a5,6cde <main+0x11a>
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    6d7e:	fb442703          	lw	a4,-76(s0)
    6d82:	fb042783          	lw	a5,-80(s0)
    6d86:	40f707bb          	subw	a5,a4,a5
    6d8a:	2781                	sext.w	a5,a5
    6d8c:	85be                	mv	a1,a5
    6d8e:	00003517          	auipc	a0,0x3
    6d92:	1ea50513          	addi	a0,a0,490 # 9f78 <malloc+0x2500>
    6d96:	00001097          	auipc	ra,0x1
    6d9a:	af0080e7          	jalr	-1296(ra) # 7886 <printf>
        if(continuous != 2)
    6d9e:	fec42783          	lw	a5,-20(s0)
    6da2:	0007871b          	sext.w	a4,a5
    6da6:	4789                	li	a5,2
    6da8:	f2f70be3          	beq	a4,a5,6cde <main+0x11a>
          exit(1);
    6dac:	4505                	li	a0,1
    6dae:	00000097          	auipc	ra,0x0
    6db2:	59a080e7          	jalr	1434(ra) # 7348 <exit>
      }
    }
  }

  printf("usertests starting\n");
    6db6:	00003517          	auipc	a0,0x3
    6dba:	1e250513          	addi	a0,a0,482 # 9f98 <malloc+0x2520>
    6dbe:	00001097          	auipc	ra,0x1
    6dc2:	ac8080e7          	jalr	-1336(ra) # 7886 <printf>
  int free0 = countfree();
    6dc6:	00000097          	auipc	ra,0x0
    6dca:	bbe080e7          	jalr	-1090(ra) # 6984 <countfree>
    6dce:	87aa                	mv	a5,a0
    6dd0:	faf42e23          	sw	a5,-68(s0)
  int free1 = 0;
    6dd4:	fa042c23          	sw	zero,-72(s0)
  int fail = 0;
    6dd8:	fc042623          	sw	zero,-52(s0)
  for (struct test *t = tests; t->s != 0; t++) {
    6ddc:	bc040793          	addi	a5,s0,-1088
    6de0:	fcf43023          	sd	a5,-64(s0)
    6de4:	a0b1                	j	6e30 <main+0x26c>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    6de6:	fe043783          	ld	a5,-32(s0)
    6dea:	cf89                	beqz	a5,6e04 <main+0x240>
    6dec:	fc043783          	ld	a5,-64(s0)
    6df0:	679c                	ld	a5,8(a5)
    6df2:	fe043583          	ld	a1,-32(s0)
    6df6:	853e                	mv	a0,a5
    6df8:	00000097          	auipc	ra,0x0
    6dfc:	10a080e7          	jalr	266(ra) # 6f02 <strcmp>
    6e00:	87aa                	mv	a5,a0
    6e02:	e395                	bnez	a5,6e26 <main+0x262>
      if(!run(t->f, t->s))
    6e04:	fc043783          	ld	a5,-64(s0)
    6e08:	6398                	ld	a4,0(a5)
    6e0a:	fc043783          	ld	a5,-64(s0)
    6e0e:	679c                	ld	a5,8(a5)
    6e10:	85be                	mv	a1,a5
    6e12:	853a                	mv	a0,a4
    6e14:	00000097          	auipc	ra,0x0
    6e18:	cf0080e7          	jalr	-784(ra) # 6b04 <run>
    6e1c:	87aa                	mv	a5,a0
    6e1e:	e781                	bnez	a5,6e26 <main+0x262>
        fail = 1;
    6e20:	4785                	li	a5,1
    6e22:	fcf42623          	sw	a5,-52(s0)
  for (struct test *t = tests; t->s != 0; t++) {
    6e26:	fc043783          	ld	a5,-64(s0)
    6e2a:	07c1                	addi	a5,a5,16
    6e2c:	fcf43023          	sd	a5,-64(s0)
    6e30:	fc043783          	ld	a5,-64(s0)
    6e34:	679c                	ld	a5,8(a5)
    6e36:	fbc5                	bnez	a5,6de6 <main+0x222>
    }
  }

  if(fail){
    6e38:	fcc42783          	lw	a5,-52(s0)
    6e3c:	2781                	sext.w	a5,a5
    6e3e:	cf91                	beqz	a5,6e5a <main+0x296>
    printf("SOME TESTS FAILED\n");
    6e40:	00003517          	auipc	a0,0x3
    6e44:	12050513          	addi	a0,a0,288 # 9f60 <malloc+0x24e8>
    6e48:	00001097          	auipc	ra,0x1
    6e4c:	a3e080e7          	jalr	-1474(ra) # 7886 <printf>
    exit(1);
    6e50:	4505                	li	a0,1
    6e52:	00000097          	auipc	ra,0x0
    6e56:	4f6080e7          	jalr	1270(ra) # 7348 <exit>
  } else if((free1 = countfree()) < free0){
    6e5a:	00000097          	auipc	ra,0x0
    6e5e:	b2a080e7          	jalr	-1238(ra) # 6984 <countfree>
    6e62:	87aa                	mv	a5,a0
    6e64:	faf42c23          	sw	a5,-72(s0)
    6e68:	fb842703          	lw	a4,-72(s0)
    6e6c:	fbc42783          	lw	a5,-68(s0)
    6e70:	2701                	sext.w	a4,a4
    6e72:	2781                	sext.w	a5,a5
    6e74:	02f75563          	bge	a4,a5,6e9e <main+0x2da>
    printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    6e78:	fbc42703          	lw	a4,-68(s0)
    6e7c:	fb842783          	lw	a5,-72(s0)
    6e80:	863a                	mv	a2,a4
    6e82:	85be                	mv	a1,a5
    6e84:	00003517          	auipc	a0,0x3
    6e88:	12c50513          	addi	a0,a0,300 # 9fb0 <malloc+0x2538>
    6e8c:	00001097          	auipc	ra,0x1
    6e90:	9fa080e7          	jalr	-1542(ra) # 7886 <printf>
    exit(1);
    6e94:	4505                	li	a0,1
    6e96:	00000097          	auipc	ra,0x0
    6e9a:	4b2080e7          	jalr	1202(ra) # 7348 <exit>
  } else {
    printf("ALL TESTS PASSED\n");
    6e9e:	00003517          	auipc	a0,0x3
    6ea2:	14250513          	addi	a0,a0,322 # 9fe0 <malloc+0x2568>
    6ea6:	00001097          	auipc	ra,0x1
    6eaa:	9e0080e7          	jalr	-1568(ra) # 7886 <printf>
    exit(0);
    6eae:	4501                	li	a0,0
    6eb0:	00000097          	auipc	ra,0x0
    6eb4:	498080e7          	jalr	1176(ra) # 7348 <exit>

0000000000006eb8 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
    6eb8:	7179                	addi	sp,sp,-48
    6eba:	f422                	sd	s0,40(sp)
    6ebc:	1800                	addi	s0,sp,48
    6ebe:	fca43c23          	sd	a0,-40(s0)
    6ec2:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
    6ec6:	fd843783          	ld	a5,-40(s0)
    6eca:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
    6ece:	0001                	nop
    6ed0:	fd043703          	ld	a4,-48(s0)
    6ed4:	00170793          	addi	a5,a4,1
    6ed8:	fcf43823          	sd	a5,-48(s0)
    6edc:	fd843783          	ld	a5,-40(s0)
    6ee0:	00178693          	addi	a3,a5,1
    6ee4:	fcd43c23          	sd	a3,-40(s0)
    6ee8:	00074703          	lbu	a4,0(a4)
    6eec:	00e78023          	sb	a4,0(a5)
    6ef0:	0007c783          	lbu	a5,0(a5)
    6ef4:	fff1                	bnez	a5,6ed0 <strcpy+0x18>
    ;
  return os;
    6ef6:	fe843783          	ld	a5,-24(s0)
}
    6efa:	853e                	mv	a0,a5
    6efc:	7422                	ld	s0,40(sp)
    6efe:	6145                	addi	sp,sp,48
    6f00:	8082                	ret

0000000000006f02 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    6f02:	1101                	addi	sp,sp,-32
    6f04:	ec22                	sd	s0,24(sp)
    6f06:	1000                	addi	s0,sp,32
    6f08:	fea43423          	sd	a0,-24(s0)
    6f0c:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
    6f10:	a819                	j	6f26 <strcmp+0x24>
    p++, q++;
    6f12:	fe843783          	ld	a5,-24(s0)
    6f16:	0785                	addi	a5,a5,1
    6f18:	fef43423          	sd	a5,-24(s0)
    6f1c:	fe043783          	ld	a5,-32(s0)
    6f20:	0785                	addi	a5,a5,1
    6f22:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
    6f26:	fe843783          	ld	a5,-24(s0)
    6f2a:	0007c783          	lbu	a5,0(a5)
    6f2e:	cb99                	beqz	a5,6f44 <strcmp+0x42>
    6f30:	fe843783          	ld	a5,-24(s0)
    6f34:	0007c703          	lbu	a4,0(a5)
    6f38:	fe043783          	ld	a5,-32(s0)
    6f3c:	0007c783          	lbu	a5,0(a5)
    6f40:	fcf709e3          	beq	a4,a5,6f12 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
    6f44:	fe843783          	ld	a5,-24(s0)
    6f48:	0007c783          	lbu	a5,0(a5)
    6f4c:	0007871b          	sext.w	a4,a5
    6f50:	fe043783          	ld	a5,-32(s0)
    6f54:	0007c783          	lbu	a5,0(a5)
    6f58:	2781                	sext.w	a5,a5
    6f5a:	40f707bb          	subw	a5,a4,a5
    6f5e:	2781                	sext.w	a5,a5
}
    6f60:	853e                	mv	a0,a5
    6f62:	6462                	ld	s0,24(sp)
    6f64:	6105                	addi	sp,sp,32
    6f66:	8082                	ret

0000000000006f68 <strlen>:

uint
strlen(const char *s)
{
    6f68:	7179                	addi	sp,sp,-48
    6f6a:	f422                	sd	s0,40(sp)
    6f6c:	1800                	addi	s0,sp,48
    6f6e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    6f72:	fe042623          	sw	zero,-20(s0)
    6f76:	a031                	j	6f82 <strlen+0x1a>
    6f78:	fec42783          	lw	a5,-20(s0)
    6f7c:	2785                	addiw	a5,a5,1
    6f7e:	fef42623          	sw	a5,-20(s0)
    6f82:	fec42783          	lw	a5,-20(s0)
    6f86:	fd843703          	ld	a4,-40(s0)
    6f8a:	97ba                	add	a5,a5,a4
    6f8c:	0007c783          	lbu	a5,0(a5)
    6f90:	f7e5                	bnez	a5,6f78 <strlen+0x10>
    ;
  return n;
    6f92:	fec42783          	lw	a5,-20(s0)
}
    6f96:	853e                	mv	a0,a5
    6f98:	7422                	ld	s0,40(sp)
    6f9a:	6145                	addi	sp,sp,48
    6f9c:	8082                	ret

0000000000006f9e <memset>:

void*
memset(void *dst, int c, uint n)
{
    6f9e:	7179                	addi	sp,sp,-48
    6fa0:	f422                	sd	s0,40(sp)
    6fa2:	1800                	addi	s0,sp,48
    6fa4:	fca43c23          	sd	a0,-40(s0)
    6fa8:	87ae                	mv	a5,a1
    6faa:	8732                	mv	a4,a2
    6fac:	fcf42a23          	sw	a5,-44(s0)
    6fb0:	87ba                	mv	a5,a4
    6fb2:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    6fb6:	fd843783          	ld	a5,-40(s0)
    6fba:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    6fbe:	fe042623          	sw	zero,-20(s0)
    6fc2:	a00d                	j	6fe4 <memset+0x46>
    cdst[i] = c;
    6fc4:	fec42783          	lw	a5,-20(s0)
    6fc8:	fe043703          	ld	a4,-32(s0)
    6fcc:	97ba                	add	a5,a5,a4
    6fce:	fd442703          	lw	a4,-44(s0)
    6fd2:	0ff77713          	andi	a4,a4,255
    6fd6:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    6fda:	fec42783          	lw	a5,-20(s0)
    6fde:	2785                	addiw	a5,a5,1
    6fe0:	fef42623          	sw	a5,-20(s0)
    6fe4:	fec42703          	lw	a4,-20(s0)
    6fe8:	fd042783          	lw	a5,-48(s0)
    6fec:	2781                	sext.w	a5,a5
    6fee:	fcf76be3          	bltu	a4,a5,6fc4 <memset+0x26>
  }
  return dst;
    6ff2:	fd843783          	ld	a5,-40(s0)
}
    6ff6:	853e                	mv	a0,a5
    6ff8:	7422                	ld	s0,40(sp)
    6ffa:	6145                	addi	sp,sp,48
    6ffc:	8082                	ret

0000000000006ffe <strchr>:

char*
strchr(const char *s, char c)
{
    6ffe:	1101                	addi	sp,sp,-32
    7000:	ec22                	sd	s0,24(sp)
    7002:	1000                	addi	s0,sp,32
    7004:	fea43423          	sd	a0,-24(s0)
    7008:	87ae                	mv	a5,a1
    700a:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
    700e:	a01d                	j	7034 <strchr+0x36>
    if(*s == c)
    7010:	fe843783          	ld	a5,-24(s0)
    7014:	0007c703          	lbu	a4,0(a5)
    7018:	fe744783          	lbu	a5,-25(s0)
    701c:	0ff7f793          	andi	a5,a5,255
    7020:	00e79563          	bne	a5,a4,702a <strchr+0x2c>
      return (char*)s;
    7024:	fe843783          	ld	a5,-24(s0)
    7028:	a821                	j	7040 <strchr+0x42>
  for(; *s; s++)
    702a:	fe843783          	ld	a5,-24(s0)
    702e:	0785                	addi	a5,a5,1
    7030:	fef43423          	sd	a5,-24(s0)
    7034:	fe843783          	ld	a5,-24(s0)
    7038:	0007c783          	lbu	a5,0(a5)
    703c:	fbf1                	bnez	a5,7010 <strchr+0x12>
  return 0;
    703e:	4781                	li	a5,0
}
    7040:	853e                	mv	a0,a5
    7042:	6462                	ld	s0,24(sp)
    7044:	6105                	addi	sp,sp,32
    7046:	8082                	ret

0000000000007048 <gets>:

char*
gets(char *buf, int max)
{
    7048:	7179                	addi	sp,sp,-48
    704a:	f406                	sd	ra,40(sp)
    704c:	f022                	sd	s0,32(sp)
    704e:	1800                	addi	s0,sp,48
    7050:	fca43c23          	sd	a0,-40(s0)
    7054:	87ae                	mv	a5,a1
    7056:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    705a:	fe042623          	sw	zero,-20(s0)
    705e:	a8a1                	j	70b6 <gets+0x6e>
    cc = read(0, &c, 1);
    7060:	fe740793          	addi	a5,s0,-25
    7064:	4605                	li	a2,1
    7066:	85be                	mv	a1,a5
    7068:	4501                	li	a0,0
    706a:	00000097          	auipc	ra,0x0
    706e:	2f6080e7          	jalr	758(ra) # 7360 <read>
    7072:	87aa                	mv	a5,a0
    7074:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
    7078:	fe842783          	lw	a5,-24(s0)
    707c:	2781                	sext.w	a5,a5
    707e:	04f05763          	blez	a5,70cc <gets+0x84>
      break;
    buf[i++] = c;
    7082:	fec42783          	lw	a5,-20(s0)
    7086:	0017871b          	addiw	a4,a5,1
    708a:	fee42623          	sw	a4,-20(s0)
    708e:	873e                	mv	a4,a5
    7090:	fd843783          	ld	a5,-40(s0)
    7094:	97ba                	add	a5,a5,a4
    7096:	fe744703          	lbu	a4,-25(s0)
    709a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
    709e:	fe744783          	lbu	a5,-25(s0)
    70a2:	873e                	mv	a4,a5
    70a4:	47a9                	li	a5,10
    70a6:	02f70463          	beq	a4,a5,70ce <gets+0x86>
    70aa:	fe744783          	lbu	a5,-25(s0)
    70ae:	873e                	mv	a4,a5
    70b0:	47b5                	li	a5,13
    70b2:	00f70e63          	beq	a4,a5,70ce <gets+0x86>
  for(i=0; i+1 < max; ){
    70b6:	fec42783          	lw	a5,-20(s0)
    70ba:	2785                	addiw	a5,a5,1
    70bc:	0007871b          	sext.w	a4,a5
    70c0:	fd442783          	lw	a5,-44(s0)
    70c4:	2781                	sext.w	a5,a5
    70c6:	f8f74de3          	blt	a4,a5,7060 <gets+0x18>
    70ca:	a011                	j	70ce <gets+0x86>
      break;
    70cc:	0001                	nop
      break;
  }
  buf[i] = '\0';
    70ce:	fec42783          	lw	a5,-20(s0)
    70d2:	fd843703          	ld	a4,-40(s0)
    70d6:	97ba                	add	a5,a5,a4
    70d8:	00078023          	sb	zero,0(a5)
  return buf;
    70dc:	fd843783          	ld	a5,-40(s0)
}
    70e0:	853e                	mv	a0,a5
    70e2:	70a2                	ld	ra,40(sp)
    70e4:	7402                	ld	s0,32(sp)
    70e6:	6145                	addi	sp,sp,48
    70e8:	8082                	ret

00000000000070ea <stat>:

int
stat(const char *n, struct stat *st)
{
    70ea:	7179                	addi	sp,sp,-48
    70ec:	f406                	sd	ra,40(sp)
    70ee:	f022                	sd	s0,32(sp)
    70f0:	1800                	addi	s0,sp,48
    70f2:	fca43c23          	sd	a0,-40(s0)
    70f6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    70fa:	4581                	li	a1,0
    70fc:	fd843503          	ld	a0,-40(s0)
    7100:	00000097          	auipc	ra,0x0
    7104:	288080e7          	jalr	648(ra) # 7388 <open>
    7108:	87aa                	mv	a5,a0
    710a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
    710e:	fec42783          	lw	a5,-20(s0)
    7112:	2781                	sext.w	a5,a5
    7114:	0007d463          	bgez	a5,711c <stat+0x32>
    return -1;
    7118:	57fd                	li	a5,-1
    711a:	a035                	j	7146 <stat+0x5c>
  r = fstat(fd, st);
    711c:	fec42783          	lw	a5,-20(s0)
    7120:	fd043583          	ld	a1,-48(s0)
    7124:	853e                	mv	a0,a5
    7126:	00000097          	auipc	ra,0x0
    712a:	27a080e7          	jalr	634(ra) # 73a0 <fstat>
    712e:	87aa                	mv	a5,a0
    7130:	fef42423          	sw	a5,-24(s0)
  close(fd);
    7134:	fec42783          	lw	a5,-20(s0)
    7138:	853e                	mv	a0,a5
    713a:	00000097          	auipc	ra,0x0
    713e:	236080e7          	jalr	566(ra) # 7370 <close>
  return r;
    7142:	fe842783          	lw	a5,-24(s0)
}
    7146:	853e                	mv	a0,a5
    7148:	70a2                	ld	ra,40(sp)
    714a:	7402                	ld	s0,32(sp)
    714c:	6145                	addi	sp,sp,48
    714e:	8082                	ret

0000000000007150 <atoi>:

int
atoi(const char *s)
{
    7150:	7179                	addi	sp,sp,-48
    7152:	f422                	sd	s0,40(sp)
    7154:	1800                	addi	s0,sp,48
    7156:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
    715a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
    715e:	a815                	j	7192 <atoi+0x42>
    n = n*10 + *s++ - '0';
    7160:	fec42703          	lw	a4,-20(s0)
    7164:	87ba                	mv	a5,a4
    7166:	0027979b          	slliw	a5,a5,0x2
    716a:	9fb9                	addw	a5,a5,a4
    716c:	0017979b          	slliw	a5,a5,0x1
    7170:	0007871b          	sext.w	a4,a5
    7174:	fd843783          	ld	a5,-40(s0)
    7178:	00178693          	addi	a3,a5,1
    717c:	fcd43c23          	sd	a3,-40(s0)
    7180:	0007c783          	lbu	a5,0(a5)
    7184:	2781                	sext.w	a5,a5
    7186:	9fb9                	addw	a5,a5,a4
    7188:	2781                	sext.w	a5,a5
    718a:	fd07879b          	addiw	a5,a5,-48
    718e:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
    7192:	fd843783          	ld	a5,-40(s0)
    7196:	0007c783          	lbu	a5,0(a5)
    719a:	873e                	mv	a4,a5
    719c:	02f00793          	li	a5,47
    71a0:	00e7fb63          	bgeu	a5,a4,71b6 <atoi+0x66>
    71a4:	fd843783          	ld	a5,-40(s0)
    71a8:	0007c783          	lbu	a5,0(a5)
    71ac:	873e                	mv	a4,a5
    71ae:	03900793          	li	a5,57
    71b2:	fae7f7e3          	bgeu	a5,a4,7160 <atoi+0x10>
  return n;
    71b6:	fec42783          	lw	a5,-20(s0)
}
    71ba:	853e                	mv	a0,a5
    71bc:	7422                	ld	s0,40(sp)
    71be:	6145                	addi	sp,sp,48
    71c0:	8082                	ret

00000000000071c2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    71c2:	7139                	addi	sp,sp,-64
    71c4:	fc22                	sd	s0,56(sp)
    71c6:	0080                	addi	s0,sp,64
    71c8:	fca43c23          	sd	a0,-40(s0)
    71cc:	fcb43823          	sd	a1,-48(s0)
    71d0:	87b2                	mv	a5,a2
    71d2:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
    71d6:	fd843783          	ld	a5,-40(s0)
    71da:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
    71de:	fd043783          	ld	a5,-48(s0)
    71e2:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
    71e6:	fe043703          	ld	a4,-32(s0)
    71ea:	fe843783          	ld	a5,-24(s0)
    71ee:	02e7fc63          	bgeu	a5,a4,7226 <memmove+0x64>
    while(n-- > 0)
    71f2:	a00d                	j	7214 <memmove+0x52>
      *dst++ = *src++;
    71f4:	fe043703          	ld	a4,-32(s0)
    71f8:	00170793          	addi	a5,a4,1
    71fc:	fef43023          	sd	a5,-32(s0)
    7200:	fe843783          	ld	a5,-24(s0)
    7204:	00178693          	addi	a3,a5,1
    7208:	fed43423          	sd	a3,-24(s0)
    720c:	00074703          	lbu	a4,0(a4)
    7210:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    7214:	fcc42783          	lw	a5,-52(s0)
    7218:	fff7871b          	addiw	a4,a5,-1
    721c:	fce42623          	sw	a4,-52(s0)
    7220:	fcf04ae3          	bgtz	a5,71f4 <memmove+0x32>
    7224:	a891                	j	7278 <memmove+0xb6>
  } else {
    dst += n;
    7226:	fcc42783          	lw	a5,-52(s0)
    722a:	fe843703          	ld	a4,-24(s0)
    722e:	97ba                	add	a5,a5,a4
    7230:	fef43423          	sd	a5,-24(s0)
    src += n;
    7234:	fcc42783          	lw	a5,-52(s0)
    7238:	fe043703          	ld	a4,-32(s0)
    723c:	97ba                	add	a5,a5,a4
    723e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    7242:	a01d                	j	7268 <memmove+0xa6>
      *--dst = *--src;
    7244:	fe043783          	ld	a5,-32(s0)
    7248:	17fd                	addi	a5,a5,-1
    724a:	fef43023          	sd	a5,-32(s0)
    724e:	fe843783          	ld	a5,-24(s0)
    7252:	17fd                	addi	a5,a5,-1
    7254:	fef43423          	sd	a5,-24(s0)
    7258:	fe043783          	ld	a5,-32(s0)
    725c:	0007c703          	lbu	a4,0(a5)
    7260:	fe843783          	ld	a5,-24(s0)
    7264:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    7268:	fcc42783          	lw	a5,-52(s0)
    726c:	fff7871b          	addiw	a4,a5,-1
    7270:	fce42623          	sw	a4,-52(s0)
    7274:	fcf048e3          	bgtz	a5,7244 <memmove+0x82>
  }
  return vdst;
    7278:	fd843783          	ld	a5,-40(s0)
}
    727c:	853e                	mv	a0,a5
    727e:	7462                	ld	s0,56(sp)
    7280:	6121                	addi	sp,sp,64
    7282:	8082                	ret

0000000000007284 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    7284:	7139                	addi	sp,sp,-64
    7286:	fc22                	sd	s0,56(sp)
    7288:	0080                	addi	s0,sp,64
    728a:	fca43c23          	sd	a0,-40(s0)
    728e:	fcb43823          	sd	a1,-48(s0)
    7292:	87b2                	mv	a5,a2
    7294:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
    7298:	fd843783          	ld	a5,-40(s0)
    729c:	fef43423          	sd	a5,-24(s0)
    72a0:	fd043783          	ld	a5,-48(s0)
    72a4:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    72a8:	a0a1                	j	72f0 <memcmp+0x6c>
    if (*p1 != *p2) {
    72aa:	fe843783          	ld	a5,-24(s0)
    72ae:	0007c703          	lbu	a4,0(a5)
    72b2:	fe043783          	ld	a5,-32(s0)
    72b6:	0007c783          	lbu	a5,0(a5)
    72ba:	02f70163          	beq	a4,a5,72dc <memcmp+0x58>
      return *p1 - *p2;
    72be:	fe843783          	ld	a5,-24(s0)
    72c2:	0007c783          	lbu	a5,0(a5)
    72c6:	0007871b          	sext.w	a4,a5
    72ca:	fe043783          	ld	a5,-32(s0)
    72ce:	0007c783          	lbu	a5,0(a5)
    72d2:	2781                	sext.w	a5,a5
    72d4:	40f707bb          	subw	a5,a4,a5
    72d8:	2781                	sext.w	a5,a5
    72da:	a01d                	j	7300 <memcmp+0x7c>
    }
    p1++;
    72dc:	fe843783          	ld	a5,-24(s0)
    72e0:	0785                	addi	a5,a5,1
    72e2:	fef43423          	sd	a5,-24(s0)
    p2++;
    72e6:	fe043783          	ld	a5,-32(s0)
    72ea:	0785                	addi	a5,a5,1
    72ec:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    72f0:	fcc42783          	lw	a5,-52(s0)
    72f4:	fff7871b          	addiw	a4,a5,-1
    72f8:	fce42623          	sw	a4,-52(s0)
    72fc:	f7dd                	bnez	a5,72aa <memcmp+0x26>
  }
  return 0;
    72fe:	4781                	li	a5,0
}
    7300:	853e                	mv	a0,a5
    7302:	7462                	ld	s0,56(sp)
    7304:	6121                	addi	sp,sp,64
    7306:	8082                	ret

0000000000007308 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    7308:	7179                	addi	sp,sp,-48
    730a:	f406                	sd	ra,40(sp)
    730c:	f022                	sd	s0,32(sp)
    730e:	1800                	addi	s0,sp,48
    7310:	fea43423          	sd	a0,-24(s0)
    7314:	feb43023          	sd	a1,-32(s0)
    7318:	87b2                	mv	a5,a2
    731a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    731e:	fdc42783          	lw	a5,-36(s0)
    7322:	863e                	mv	a2,a5
    7324:	fe043583          	ld	a1,-32(s0)
    7328:	fe843503          	ld	a0,-24(s0)
    732c:	00000097          	auipc	ra,0x0
    7330:	e96080e7          	jalr	-362(ra) # 71c2 <memmove>
    7334:	87aa                	mv	a5,a0
}
    7336:	853e                	mv	a0,a5
    7338:	70a2                	ld	ra,40(sp)
    733a:	7402                	ld	s0,32(sp)
    733c:	6145                	addi	sp,sp,48
    733e:	8082                	ret

0000000000007340 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    7340:	4885                	li	a7,1
 ecall
    7342:	00000073          	ecall
 ret
    7346:	8082                	ret

0000000000007348 <exit>:
.global exit
exit:
 li a7, SYS_exit
    7348:	4889                	li	a7,2
 ecall
    734a:	00000073          	ecall
 ret
    734e:	8082                	ret

0000000000007350 <wait>:
.global wait
wait:
 li a7, SYS_wait
    7350:	488d                	li	a7,3
 ecall
    7352:	00000073          	ecall
 ret
    7356:	8082                	ret

0000000000007358 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    7358:	4891                	li	a7,4
 ecall
    735a:	00000073          	ecall
 ret
    735e:	8082                	ret

0000000000007360 <read>:
.global read
read:
 li a7, SYS_read
    7360:	4895                	li	a7,5
 ecall
    7362:	00000073          	ecall
 ret
    7366:	8082                	ret

0000000000007368 <write>:
.global write
write:
 li a7, SYS_write
    7368:	48c1                	li	a7,16
 ecall
    736a:	00000073          	ecall
 ret
    736e:	8082                	ret

0000000000007370 <close>:
.global close
close:
 li a7, SYS_close
    7370:	48d5                	li	a7,21
 ecall
    7372:	00000073          	ecall
 ret
    7376:	8082                	ret

0000000000007378 <kill>:
.global kill
kill:
 li a7, SYS_kill
    7378:	4899                	li	a7,6
 ecall
    737a:	00000073          	ecall
 ret
    737e:	8082                	ret

0000000000007380 <exec>:
.global exec
exec:
 li a7, SYS_exec
    7380:	489d                	li	a7,7
 ecall
    7382:	00000073          	ecall
 ret
    7386:	8082                	ret

0000000000007388 <open>:
.global open
open:
 li a7, SYS_open
    7388:	48bd                	li	a7,15
 ecall
    738a:	00000073          	ecall
 ret
    738e:	8082                	ret

0000000000007390 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    7390:	48c5                	li	a7,17
 ecall
    7392:	00000073          	ecall
 ret
    7396:	8082                	ret

0000000000007398 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    7398:	48c9                	li	a7,18
 ecall
    739a:	00000073          	ecall
 ret
    739e:	8082                	ret

00000000000073a0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    73a0:	48a1                	li	a7,8
 ecall
    73a2:	00000073          	ecall
 ret
    73a6:	8082                	ret

00000000000073a8 <link>:
.global link
link:
 li a7, SYS_link
    73a8:	48cd                	li	a7,19
 ecall
    73aa:	00000073          	ecall
 ret
    73ae:	8082                	ret

00000000000073b0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    73b0:	48d1                	li	a7,20
 ecall
    73b2:	00000073          	ecall
 ret
    73b6:	8082                	ret

00000000000073b8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    73b8:	48a5                	li	a7,9
 ecall
    73ba:	00000073          	ecall
 ret
    73be:	8082                	ret

00000000000073c0 <dup>:
.global dup
dup:
 li a7, SYS_dup
    73c0:	48a9                	li	a7,10
 ecall
    73c2:	00000073          	ecall
 ret
    73c6:	8082                	ret

00000000000073c8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    73c8:	48ad                	li	a7,11
 ecall
    73ca:	00000073          	ecall
 ret
    73ce:	8082                	ret

00000000000073d0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    73d0:	48b1                	li	a7,12
 ecall
    73d2:	00000073          	ecall
 ret
    73d6:	8082                	ret

00000000000073d8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    73d8:	48b5                	li	a7,13
 ecall
    73da:	00000073          	ecall
 ret
    73de:	8082                	ret

00000000000073e0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    73e0:	48b9                	li	a7,14
 ecall
    73e2:	00000073          	ecall
 ret
    73e6:	8082                	ret

00000000000073e8 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
    73e8:	48d9                	li	a7,22
 ecall
    73ea:	00000073          	ecall
 ret
    73ee:	8082                	ret

00000000000073f0 <setpri>:
.global setpri
setpri:
 li a7, SYS_setpri
    73f0:	48dd                	li	a7,23
 ecall
    73f2:	00000073          	ecall
 ret
    73f6:	8082                	ret

00000000000073f8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    73f8:	1101                	addi	sp,sp,-32
    73fa:	ec06                	sd	ra,24(sp)
    73fc:	e822                	sd	s0,16(sp)
    73fe:	1000                	addi	s0,sp,32
    7400:	87aa                	mv	a5,a0
    7402:	872e                	mv	a4,a1
    7404:	fef42623          	sw	a5,-20(s0)
    7408:	87ba                	mv	a5,a4
    740a:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
    740e:	feb40713          	addi	a4,s0,-21
    7412:	fec42783          	lw	a5,-20(s0)
    7416:	4605                	li	a2,1
    7418:	85ba                	mv	a1,a4
    741a:	853e                	mv	a0,a5
    741c:	00000097          	auipc	ra,0x0
    7420:	f4c080e7          	jalr	-180(ra) # 7368 <write>
}
    7424:	0001                	nop
    7426:	60e2                	ld	ra,24(sp)
    7428:	6442                	ld	s0,16(sp)
    742a:	6105                	addi	sp,sp,32
    742c:	8082                	ret

000000000000742e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    742e:	7139                	addi	sp,sp,-64
    7430:	fc06                	sd	ra,56(sp)
    7432:	f822                	sd	s0,48(sp)
    7434:	0080                	addi	s0,sp,64
    7436:	87aa                	mv	a5,a0
    7438:	8736                	mv	a4,a3
    743a:	fcf42623          	sw	a5,-52(s0)
    743e:	87ae                	mv	a5,a1
    7440:	fcf42423          	sw	a5,-56(s0)
    7444:	87b2                	mv	a5,a2
    7446:	fcf42223          	sw	a5,-60(s0)
    744a:	87ba                	mv	a5,a4
    744c:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    7450:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
    7454:	fc042783          	lw	a5,-64(s0)
    7458:	2781                	sext.w	a5,a5
    745a:	c38d                	beqz	a5,747c <printint+0x4e>
    745c:	fc842783          	lw	a5,-56(s0)
    7460:	2781                	sext.w	a5,a5
    7462:	0007dd63          	bgez	a5,747c <printint+0x4e>
    neg = 1;
    7466:	4785                	li	a5,1
    7468:	fef42423          	sw	a5,-24(s0)
    x = -xx;
    746c:	fc842783          	lw	a5,-56(s0)
    7470:	40f007bb          	negw	a5,a5
    7474:	2781                	sext.w	a5,a5
    7476:	fef42223          	sw	a5,-28(s0)
    747a:	a029                	j	7484 <printint+0x56>
  } else {
    x = xx;
    747c:	fc842783          	lw	a5,-56(s0)
    7480:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
    7484:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
    7488:	fc442783          	lw	a5,-60(s0)
    748c:	fe442703          	lw	a4,-28(s0)
    7490:	02f777bb          	remuw	a5,a4,a5
    7494:	0007861b          	sext.w	a2,a5
    7498:	fec42783          	lw	a5,-20(s0)
    749c:	0017871b          	addiw	a4,a5,1
    74a0:	fee42623          	sw	a4,-20(s0)
    74a4:	00003697          	auipc	a3,0x3
    74a8:	f5468693          	addi	a3,a3,-172 # a3f8 <digits>
    74ac:	02061713          	slli	a4,a2,0x20
    74b0:	9301                	srli	a4,a4,0x20
    74b2:	9736                	add	a4,a4,a3
    74b4:	00074703          	lbu	a4,0(a4)
    74b8:	ff040693          	addi	a3,s0,-16
    74bc:	97b6                	add	a5,a5,a3
    74be:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
    74c2:	fc442783          	lw	a5,-60(s0)
    74c6:	fe442703          	lw	a4,-28(s0)
    74ca:	02f757bb          	divuw	a5,a4,a5
    74ce:	fef42223          	sw	a5,-28(s0)
    74d2:	fe442783          	lw	a5,-28(s0)
    74d6:	2781                	sext.w	a5,a5
    74d8:	fbc5                	bnez	a5,7488 <printint+0x5a>
  if(neg)
    74da:	fe842783          	lw	a5,-24(s0)
    74de:	2781                	sext.w	a5,a5
    74e0:	cf95                	beqz	a5,751c <printint+0xee>
    buf[i++] = '-';
    74e2:	fec42783          	lw	a5,-20(s0)
    74e6:	0017871b          	addiw	a4,a5,1
    74ea:	fee42623          	sw	a4,-20(s0)
    74ee:	ff040713          	addi	a4,s0,-16
    74f2:	97ba                	add	a5,a5,a4
    74f4:	02d00713          	li	a4,45
    74f8:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
    74fc:	a005                	j	751c <printint+0xee>
    putc(fd, buf[i]);
    74fe:	fec42783          	lw	a5,-20(s0)
    7502:	ff040713          	addi	a4,s0,-16
    7506:	97ba                	add	a5,a5,a4
    7508:	fe07c703          	lbu	a4,-32(a5)
    750c:	fcc42783          	lw	a5,-52(s0)
    7510:	85ba                	mv	a1,a4
    7512:	853e                	mv	a0,a5
    7514:	00000097          	auipc	ra,0x0
    7518:	ee4080e7          	jalr	-284(ra) # 73f8 <putc>
  while(--i >= 0)
    751c:	fec42783          	lw	a5,-20(s0)
    7520:	37fd                	addiw	a5,a5,-1
    7522:	fef42623          	sw	a5,-20(s0)
    7526:	fec42783          	lw	a5,-20(s0)
    752a:	2781                	sext.w	a5,a5
    752c:	fc07d9e3          	bgez	a5,74fe <printint+0xd0>
}
    7530:	0001                	nop
    7532:	0001                	nop
    7534:	70e2                	ld	ra,56(sp)
    7536:	7442                	ld	s0,48(sp)
    7538:	6121                	addi	sp,sp,64
    753a:	8082                	ret

000000000000753c <printptr>:

static void
printptr(int fd, uint64 x) {
    753c:	7179                	addi	sp,sp,-48
    753e:	f406                	sd	ra,40(sp)
    7540:	f022                	sd	s0,32(sp)
    7542:	1800                	addi	s0,sp,48
    7544:	87aa                	mv	a5,a0
    7546:	fcb43823          	sd	a1,-48(s0)
    754a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    754e:	fdc42783          	lw	a5,-36(s0)
    7552:	03000593          	li	a1,48
    7556:	853e                	mv	a0,a5
    7558:	00000097          	auipc	ra,0x0
    755c:	ea0080e7          	jalr	-352(ra) # 73f8 <putc>
  putc(fd, 'x');
    7560:	fdc42783          	lw	a5,-36(s0)
    7564:	07800593          	li	a1,120
    7568:	853e                	mv	a0,a5
    756a:	00000097          	auipc	ra,0x0
    756e:	e8e080e7          	jalr	-370(ra) # 73f8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    7572:	fe042623          	sw	zero,-20(s0)
    7576:	a82d                	j	75b0 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    7578:	fd043783          	ld	a5,-48(s0)
    757c:	93f1                	srli	a5,a5,0x3c
    757e:	00003717          	auipc	a4,0x3
    7582:	e7a70713          	addi	a4,a4,-390 # a3f8 <digits>
    7586:	97ba                	add	a5,a5,a4
    7588:	0007c703          	lbu	a4,0(a5)
    758c:	fdc42783          	lw	a5,-36(s0)
    7590:	85ba                	mv	a1,a4
    7592:	853e                	mv	a0,a5
    7594:	00000097          	auipc	ra,0x0
    7598:	e64080e7          	jalr	-412(ra) # 73f8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    759c:	fec42783          	lw	a5,-20(s0)
    75a0:	2785                	addiw	a5,a5,1
    75a2:	fef42623          	sw	a5,-20(s0)
    75a6:	fd043783          	ld	a5,-48(s0)
    75aa:	0792                	slli	a5,a5,0x4
    75ac:	fcf43823          	sd	a5,-48(s0)
    75b0:	fec42783          	lw	a5,-20(s0)
    75b4:	873e                	mv	a4,a5
    75b6:	47bd                	li	a5,15
    75b8:	fce7f0e3          	bgeu	a5,a4,7578 <printptr+0x3c>
}
    75bc:	0001                	nop
    75be:	0001                	nop
    75c0:	70a2                	ld	ra,40(sp)
    75c2:	7402                	ld	s0,32(sp)
    75c4:	6145                	addi	sp,sp,48
    75c6:	8082                	ret

00000000000075c8 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    75c8:	715d                	addi	sp,sp,-80
    75ca:	e486                	sd	ra,72(sp)
    75cc:	e0a2                	sd	s0,64(sp)
    75ce:	0880                	addi	s0,sp,80
    75d0:	87aa                	mv	a5,a0
    75d2:	fcb43023          	sd	a1,-64(s0)
    75d6:	fac43c23          	sd	a2,-72(s0)
    75da:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
    75de:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    75e2:	fe042223          	sw	zero,-28(s0)
    75e6:	a42d                	j	7810 <vprintf+0x248>
    c = fmt[i] & 0xff;
    75e8:	fe442783          	lw	a5,-28(s0)
    75ec:	fc043703          	ld	a4,-64(s0)
    75f0:	97ba                	add	a5,a5,a4
    75f2:	0007c783          	lbu	a5,0(a5)
    75f6:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
    75fa:	fe042783          	lw	a5,-32(s0)
    75fe:	2781                	sext.w	a5,a5
    7600:	eb9d                	bnez	a5,7636 <vprintf+0x6e>
      if(c == '%'){
    7602:	fdc42783          	lw	a5,-36(s0)
    7606:	0007871b          	sext.w	a4,a5
    760a:	02500793          	li	a5,37
    760e:	00f71763          	bne	a4,a5,761c <vprintf+0x54>
        state = '%';
    7612:	02500793          	li	a5,37
    7616:	fef42023          	sw	a5,-32(s0)
    761a:	a2f5                	j	7806 <vprintf+0x23e>
      } else {
        putc(fd, c);
    761c:	fdc42783          	lw	a5,-36(s0)
    7620:	0ff7f713          	andi	a4,a5,255
    7624:	fcc42783          	lw	a5,-52(s0)
    7628:	85ba                	mv	a1,a4
    762a:	853e                	mv	a0,a5
    762c:	00000097          	auipc	ra,0x0
    7630:	dcc080e7          	jalr	-564(ra) # 73f8 <putc>
    7634:	aac9                	j	7806 <vprintf+0x23e>
      }
    } else if(state == '%'){
    7636:	fe042783          	lw	a5,-32(s0)
    763a:	0007871b          	sext.w	a4,a5
    763e:	02500793          	li	a5,37
    7642:	1cf71263          	bne	a4,a5,7806 <vprintf+0x23e>
      if(c == 'd'){
    7646:	fdc42783          	lw	a5,-36(s0)
    764a:	0007871b          	sext.w	a4,a5
    764e:	06400793          	li	a5,100
    7652:	02f71463          	bne	a4,a5,767a <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
    7656:	fb843783          	ld	a5,-72(s0)
    765a:	00878713          	addi	a4,a5,8
    765e:	fae43c23          	sd	a4,-72(s0)
    7662:	4398                	lw	a4,0(a5)
    7664:	fcc42783          	lw	a5,-52(s0)
    7668:	4685                	li	a3,1
    766a:	4629                	li	a2,10
    766c:	85ba                	mv	a1,a4
    766e:	853e                	mv	a0,a5
    7670:	00000097          	auipc	ra,0x0
    7674:	dbe080e7          	jalr	-578(ra) # 742e <printint>
    7678:	a269                	j	7802 <vprintf+0x23a>
      } else if(c == 'l') {
    767a:	fdc42783          	lw	a5,-36(s0)
    767e:	0007871b          	sext.w	a4,a5
    7682:	06c00793          	li	a5,108
    7686:	02f71663          	bne	a4,a5,76b2 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
    768a:	fb843783          	ld	a5,-72(s0)
    768e:	00878713          	addi	a4,a5,8
    7692:	fae43c23          	sd	a4,-72(s0)
    7696:	639c                	ld	a5,0(a5)
    7698:	0007871b          	sext.w	a4,a5
    769c:	fcc42783          	lw	a5,-52(s0)
    76a0:	4681                	li	a3,0
    76a2:	4629                	li	a2,10
    76a4:	85ba                	mv	a1,a4
    76a6:	853e                	mv	a0,a5
    76a8:	00000097          	auipc	ra,0x0
    76ac:	d86080e7          	jalr	-634(ra) # 742e <printint>
    76b0:	aa89                	j	7802 <vprintf+0x23a>
      } else if(c == 'x') {
    76b2:	fdc42783          	lw	a5,-36(s0)
    76b6:	0007871b          	sext.w	a4,a5
    76ba:	07800793          	li	a5,120
    76be:	02f71463          	bne	a4,a5,76e6 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
    76c2:	fb843783          	ld	a5,-72(s0)
    76c6:	00878713          	addi	a4,a5,8
    76ca:	fae43c23          	sd	a4,-72(s0)
    76ce:	4398                	lw	a4,0(a5)
    76d0:	fcc42783          	lw	a5,-52(s0)
    76d4:	4681                	li	a3,0
    76d6:	4641                	li	a2,16
    76d8:	85ba                	mv	a1,a4
    76da:	853e                	mv	a0,a5
    76dc:	00000097          	auipc	ra,0x0
    76e0:	d52080e7          	jalr	-686(ra) # 742e <printint>
    76e4:	aa39                	j	7802 <vprintf+0x23a>
      } else if(c == 'p') {
    76e6:	fdc42783          	lw	a5,-36(s0)
    76ea:	0007871b          	sext.w	a4,a5
    76ee:	07000793          	li	a5,112
    76f2:	02f71263          	bne	a4,a5,7716 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
    76f6:	fb843783          	ld	a5,-72(s0)
    76fa:	00878713          	addi	a4,a5,8
    76fe:	fae43c23          	sd	a4,-72(s0)
    7702:	6398                	ld	a4,0(a5)
    7704:	fcc42783          	lw	a5,-52(s0)
    7708:	85ba                	mv	a1,a4
    770a:	853e                	mv	a0,a5
    770c:	00000097          	auipc	ra,0x0
    7710:	e30080e7          	jalr	-464(ra) # 753c <printptr>
    7714:	a0fd                	j	7802 <vprintf+0x23a>
      } else if(c == 's'){
    7716:	fdc42783          	lw	a5,-36(s0)
    771a:	0007871b          	sext.w	a4,a5
    771e:	07300793          	li	a5,115
    7722:	04f71c63          	bne	a4,a5,777a <vprintf+0x1b2>
        s = va_arg(ap, char*);
    7726:	fb843783          	ld	a5,-72(s0)
    772a:	00878713          	addi	a4,a5,8
    772e:	fae43c23          	sd	a4,-72(s0)
    7732:	639c                	ld	a5,0(a5)
    7734:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
    7738:	fe843783          	ld	a5,-24(s0)
    773c:	eb8d                	bnez	a5,776e <vprintf+0x1a6>
          s = "(null)";
    773e:	00003797          	auipc	a5,0x3
    7742:	cb278793          	addi	a5,a5,-846 # a3f0 <malloc+0x2978>
    7746:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    774a:	a015                	j	776e <vprintf+0x1a6>
          putc(fd, *s);
    774c:	fe843783          	ld	a5,-24(s0)
    7750:	0007c703          	lbu	a4,0(a5)
    7754:	fcc42783          	lw	a5,-52(s0)
    7758:	85ba                	mv	a1,a4
    775a:	853e                	mv	a0,a5
    775c:	00000097          	auipc	ra,0x0
    7760:	c9c080e7          	jalr	-868(ra) # 73f8 <putc>
          s++;
    7764:	fe843783          	ld	a5,-24(s0)
    7768:	0785                	addi	a5,a5,1
    776a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    776e:	fe843783          	ld	a5,-24(s0)
    7772:	0007c783          	lbu	a5,0(a5)
    7776:	fbf9                	bnez	a5,774c <vprintf+0x184>
    7778:	a069                	j	7802 <vprintf+0x23a>
        }
      } else if(c == 'c'){
    777a:	fdc42783          	lw	a5,-36(s0)
    777e:	0007871b          	sext.w	a4,a5
    7782:	06300793          	li	a5,99
    7786:	02f71463          	bne	a4,a5,77ae <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
    778a:	fb843783          	ld	a5,-72(s0)
    778e:	00878713          	addi	a4,a5,8
    7792:	fae43c23          	sd	a4,-72(s0)
    7796:	439c                	lw	a5,0(a5)
    7798:	0ff7f713          	andi	a4,a5,255
    779c:	fcc42783          	lw	a5,-52(s0)
    77a0:	85ba                	mv	a1,a4
    77a2:	853e                	mv	a0,a5
    77a4:	00000097          	auipc	ra,0x0
    77a8:	c54080e7          	jalr	-940(ra) # 73f8 <putc>
    77ac:	a899                	j	7802 <vprintf+0x23a>
      } else if(c == '%'){
    77ae:	fdc42783          	lw	a5,-36(s0)
    77b2:	0007871b          	sext.w	a4,a5
    77b6:	02500793          	li	a5,37
    77ba:	00f71f63          	bne	a4,a5,77d8 <vprintf+0x210>
        putc(fd, c);
    77be:	fdc42783          	lw	a5,-36(s0)
    77c2:	0ff7f713          	andi	a4,a5,255
    77c6:	fcc42783          	lw	a5,-52(s0)
    77ca:	85ba                	mv	a1,a4
    77cc:	853e                	mv	a0,a5
    77ce:	00000097          	auipc	ra,0x0
    77d2:	c2a080e7          	jalr	-982(ra) # 73f8 <putc>
    77d6:	a035                	j	7802 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    77d8:	fcc42783          	lw	a5,-52(s0)
    77dc:	02500593          	li	a1,37
    77e0:	853e                	mv	a0,a5
    77e2:	00000097          	auipc	ra,0x0
    77e6:	c16080e7          	jalr	-1002(ra) # 73f8 <putc>
        putc(fd, c);
    77ea:	fdc42783          	lw	a5,-36(s0)
    77ee:	0ff7f713          	andi	a4,a5,255
    77f2:	fcc42783          	lw	a5,-52(s0)
    77f6:	85ba                	mv	a1,a4
    77f8:	853e                	mv	a0,a5
    77fa:	00000097          	auipc	ra,0x0
    77fe:	bfe080e7          	jalr	-1026(ra) # 73f8 <putc>
      }
      state = 0;
    7802:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    7806:	fe442783          	lw	a5,-28(s0)
    780a:	2785                	addiw	a5,a5,1
    780c:	fef42223          	sw	a5,-28(s0)
    7810:	fe442783          	lw	a5,-28(s0)
    7814:	fc043703          	ld	a4,-64(s0)
    7818:	97ba                	add	a5,a5,a4
    781a:	0007c783          	lbu	a5,0(a5)
    781e:	dc0795e3          	bnez	a5,75e8 <vprintf+0x20>
    }
  }
}
    7822:	0001                	nop
    7824:	0001                	nop
    7826:	60a6                	ld	ra,72(sp)
    7828:	6406                	ld	s0,64(sp)
    782a:	6161                	addi	sp,sp,80
    782c:	8082                	ret

000000000000782e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    782e:	7159                	addi	sp,sp,-112
    7830:	fc06                	sd	ra,56(sp)
    7832:	f822                	sd	s0,48(sp)
    7834:	0080                	addi	s0,sp,64
    7836:	fcb43823          	sd	a1,-48(s0)
    783a:	e010                	sd	a2,0(s0)
    783c:	e414                	sd	a3,8(s0)
    783e:	e818                	sd	a4,16(s0)
    7840:	ec1c                	sd	a5,24(s0)
    7842:	03043023          	sd	a6,32(s0)
    7846:	03143423          	sd	a7,40(s0)
    784a:	87aa                	mv	a5,a0
    784c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    7850:	03040793          	addi	a5,s0,48
    7854:	fcf43423          	sd	a5,-56(s0)
    7858:	fc843783          	ld	a5,-56(s0)
    785c:	fd078793          	addi	a5,a5,-48
    7860:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    7864:	fe843703          	ld	a4,-24(s0)
    7868:	fdc42783          	lw	a5,-36(s0)
    786c:	863a                	mv	a2,a4
    786e:	fd043583          	ld	a1,-48(s0)
    7872:	853e                	mv	a0,a5
    7874:	00000097          	auipc	ra,0x0
    7878:	d54080e7          	jalr	-684(ra) # 75c8 <vprintf>
}
    787c:	0001                	nop
    787e:	70e2                	ld	ra,56(sp)
    7880:	7442                	ld	s0,48(sp)
    7882:	6165                	addi	sp,sp,112
    7884:	8082                	ret

0000000000007886 <printf>:

void
printf(const char *fmt, ...)
{
    7886:	7159                	addi	sp,sp,-112
    7888:	f406                	sd	ra,40(sp)
    788a:	f022                	sd	s0,32(sp)
    788c:	1800                	addi	s0,sp,48
    788e:	fca43c23          	sd	a0,-40(s0)
    7892:	e40c                	sd	a1,8(s0)
    7894:	e810                	sd	a2,16(s0)
    7896:	ec14                	sd	a3,24(s0)
    7898:	f018                	sd	a4,32(s0)
    789a:	f41c                	sd	a5,40(s0)
    789c:	03043823          	sd	a6,48(s0)
    78a0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    78a4:	04040793          	addi	a5,s0,64
    78a8:	fcf43823          	sd	a5,-48(s0)
    78ac:	fd043783          	ld	a5,-48(s0)
    78b0:	fc878793          	addi	a5,a5,-56
    78b4:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    78b8:	fe843783          	ld	a5,-24(s0)
    78bc:	863e                	mv	a2,a5
    78be:	fd843583          	ld	a1,-40(s0)
    78c2:	4505                	li	a0,1
    78c4:	00000097          	auipc	ra,0x0
    78c8:	d04080e7          	jalr	-764(ra) # 75c8 <vprintf>
}
    78cc:	0001                	nop
    78ce:	70a2                	ld	ra,40(sp)
    78d0:	7402                	ld	s0,32(sp)
    78d2:	6165                	addi	sp,sp,112
    78d4:	8082                	ret

00000000000078d6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    78d6:	7179                	addi	sp,sp,-48
    78d8:	f422                	sd	s0,40(sp)
    78da:	1800                	addi	s0,sp,48
    78dc:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    78e0:	fd843783          	ld	a5,-40(s0)
    78e4:	17c1                	addi	a5,a5,-16
    78e6:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    78ea:	00009797          	auipc	a5,0x9
    78ee:	34e78793          	addi	a5,a5,846 # 10c38 <freep>
    78f2:	639c                	ld	a5,0(a5)
    78f4:	fef43423          	sd	a5,-24(s0)
    78f8:	a815                	j	792c <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    78fa:	fe843783          	ld	a5,-24(s0)
    78fe:	639c                	ld	a5,0(a5)
    7900:	fe843703          	ld	a4,-24(s0)
    7904:	00f76f63          	bltu	a4,a5,7922 <free+0x4c>
    7908:	fe043703          	ld	a4,-32(s0)
    790c:	fe843783          	ld	a5,-24(s0)
    7910:	02e7eb63          	bltu	a5,a4,7946 <free+0x70>
    7914:	fe843783          	ld	a5,-24(s0)
    7918:	639c                	ld	a5,0(a5)
    791a:	fe043703          	ld	a4,-32(s0)
    791e:	02f76463          	bltu	a4,a5,7946 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    7922:	fe843783          	ld	a5,-24(s0)
    7926:	639c                	ld	a5,0(a5)
    7928:	fef43423          	sd	a5,-24(s0)
    792c:	fe043703          	ld	a4,-32(s0)
    7930:	fe843783          	ld	a5,-24(s0)
    7934:	fce7f3e3          	bgeu	a5,a4,78fa <free+0x24>
    7938:	fe843783          	ld	a5,-24(s0)
    793c:	639c                	ld	a5,0(a5)
    793e:	fe043703          	ld	a4,-32(s0)
    7942:	faf77ce3          	bgeu	a4,a5,78fa <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    7946:	fe043783          	ld	a5,-32(s0)
    794a:	479c                	lw	a5,8(a5)
    794c:	1782                	slli	a5,a5,0x20
    794e:	9381                	srli	a5,a5,0x20
    7950:	0792                	slli	a5,a5,0x4
    7952:	fe043703          	ld	a4,-32(s0)
    7956:	973e                	add	a4,a4,a5
    7958:	fe843783          	ld	a5,-24(s0)
    795c:	639c                	ld	a5,0(a5)
    795e:	02f71763          	bne	a4,a5,798c <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    7962:	fe043783          	ld	a5,-32(s0)
    7966:	4798                	lw	a4,8(a5)
    7968:	fe843783          	ld	a5,-24(s0)
    796c:	639c                	ld	a5,0(a5)
    796e:	479c                	lw	a5,8(a5)
    7970:	9fb9                	addw	a5,a5,a4
    7972:	0007871b          	sext.w	a4,a5
    7976:	fe043783          	ld	a5,-32(s0)
    797a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    797c:	fe843783          	ld	a5,-24(s0)
    7980:	639c                	ld	a5,0(a5)
    7982:	6398                	ld	a4,0(a5)
    7984:	fe043783          	ld	a5,-32(s0)
    7988:	e398                	sd	a4,0(a5)
    798a:	a039                	j	7998 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    798c:	fe843783          	ld	a5,-24(s0)
    7990:	6398                	ld	a4,0(a5)
    7992:	fe043783          	ld	a5,-32(s0)
    7996:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    7998:	fe843783          	ld	a5,-24(s0)
    799c:	479c                	lw	a5,8(a5)
    799e:	1782                	slli	a5,a5,0x20
    79a0:	9381                	srli	a5,a5,0x20
    79a2:	0792                	slli	a5,a5,0x4
    79a4:	fe843703          	ld	a4,-24(s0)
    79a8:	97ba                	add	a5,a5,a4
    79aa:	fe043703          	ld	a4,-32(s0)
    79ae:	02f71563          	bne	a4,a5,79d8 <free+0x102>
    p->s.size += bp->s.size;
    79b2:	fe843783          	ld	a5,-24(s0)
    79b6:	4798                	lw	a4,8(a5)
    79b8:	fe043783          	ld	a5,-32(s0)
    79bc:	479c                	lw	a5,8(a5)
    79be:	9fb9                	addw	a5,a5,a4
    79c0:	0007871b          	sext.w	a4,a5
    79c4:	fe843783          	ld	a5,-24(s0)
    79c8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    79ca:	fe043783          	ld	a5,-32(s0)
    79ce:	6398                	ld	a4,0(a5)
    79d0:	fe843783          	ld	a5,-24(s0)
    79d4:	e398                	sd	a4,0(a5)
    79d6:	a031                	j	79e2 <free+0x10c>
  } else
    p->s.ptr = bp;
    79d8:	fe843783          	ld	a5,-24(s0)
    79dc:	fe043703          	ld	a4,-32(s0)
    79e0:	e398                	sd	a4,0(a5)
  freep = p;
    79e2:	00009797          	auipc	a5,0x9
    79e6:	25678793          	addi	a5,a5,598 # 10c38 <freep>
    79ea:	fe843703          	ld	a4,-24(s0)
    79ee:	e398                	sd	a4,0(a5)
}
    79f0:	0001                	nop
    79f2:	7422                	ld	s0,40(sp)
    79f4:	6145                	addi	sp,sp,48
    79f6:	8082                	ret

00000000000079f8 <morecore>:

static Header*
morecore(uint nu)
{
    79f8:	7179                	addi	sp,sp,-48
    79fa:	f406                	sd	ra,40(sp)
    79fc:	f022                	sd	s0,32(sp)
    79fe:	1800                	addi	s0,sp,48
    7a00:	87aa                	mv	a5,a0
    7a02:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    7a06:	fdc42783          	lw	a5,-36(s0)
    7a0a:	0007871b          	sext.w	a4,a5
    7a0e:	6785                	lui	a5,0x1
    7a10:	00f77563          	bgeu	a4,a5,7a1a <morecore+0x22>
    nu = 4096;
    7a14:	6785                	lui	a5,0x1
    7a16:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    7a1a:	fdc42783          	lw	a5,-36(s0)
    7a1e:	0047979b          	slliw	a5,a5,0x4
    7a22:	2781                	sext.w	a5,a5
    7a24:	2781                	sext.w	a5,a5
    7a26:	853e                	mv	a0,a5
    7a28:	00000097          	auipc	ra,0x0
    7a2c:	9a8080e7          	jalr	-1624(ra) # 73d0 <sbrk>
    7a30:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    7a34:	fe843703          	ld	a4,-24(s0)
    7a38:	57fd                	li	a5,-1
    7a3a:	00f71463          	bne	a4,a5,7a42 <morecore+0x4a>
    return 0;
    7a3e:	4781                	li	a5,0
    7a40:	a03d                	j	7a6e <morecore+0x76>
  hp = (Header*)p;
    7a42:	fe843783          	ld	a5,-24(s0)
    7a46:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    7a4a:	fe043783          	ld	a5,-32(s0)
    7a4e:	fdc42703          	lw	a4,-36(s0)
    7a52:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    7a54:	fe043783          	ld	a5,-32(s0)
    7a58:	07c1                	addi	a5,a5,16
    7a5a:	853e                	mv	a0,a5
    7a5c:	00000097          	auipc	ra,0x0
    7a60:	e7a080e7          	jalr	-390(ra) # 78d6 <free>
  return freep;
    7a64:	00009797          	auipc	a5,0x9
    7a68:	1d478793          	addi	a5,a5,468 # 10c38 <freep>
    7a6c:	639c                	ld	a5,0(a5)
}
    7a6e:	853e                	mv	a0,a5
    7a70:	70a2                	ld	ra,40(sp)
    7a72:	7402                	ld	s0,32(sp)
    7a74:	6145                	addi	sp,sp,48
    7a76:	8082                	ret

0000000000007a78 <malloc>:

void*
malloc(uint nbytes)
{
    7a78:	7139                	addi	sp,sp,-64
    7a7a:	fc06                	sd	ra,56(sp)
    7a7c:	f822                	sd	s0,48(sp)
    7a7e:	0080                	addi	s0,sp,64
    7a80:	87aa                	mv	a5,a0
    7a82:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    7a86:	fcc46783          	lwu	a5,-52(s0)
    7a8a:	07bd                	addi	a5,a5,15
    7a8c:	8391                	srli	a5,a5,0x4
    7a8e:	2781                	sext.w	a5,a5
    7a90:	2785                	addiw	a5,a5,1
    7a92:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    7a96:	00009797          	auipc	a5,0x9
    7a9a:	1a278793          	addi	a5,a5,418 # 10c38 <freep>
    7a9e:	639c                	ld	a5,0(a5)
    7aa0:	fef43023          	sd	a5,-32(s0)
    7aa4:	fe043783          	ld	a5,-32(s0)
    7aa8:	ef95                	bnez	a5,7ae4 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    7aaa:	00009797          	auipc	a5,0x9
    7aae:	17e78793          	addi	a5,a5,382 # 10c28 <base>
    7ab2:	fef43023          	sd	a5,-32(s0)
    7ab6:	00009797          	auipc	a5,0x9
    7aba:	18278793          	addi	a5,a5,386 # 10c38 <freep>
    7abe:	fe043703          	ld	a4,-32(s0)
    7ac2:	e398                	sd	a4,0(a5)
    7ac4:	00009797          	auipc	a5,0x9
    7ac8:	17478793          	addi	a5,a5,372 # 10c38 <freep>
    7acc:	6398                	ld	a4,0(a5)
    7ace:	00009797          	auipc	a5,0x9
    7ad2:	15a78793          	addi	a5,a5,346 # 10c28 <base>
    7ad6:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    7ad8:	00009797          	auipc	a5,0x9
    7adc:	15078793          	addi	a5,a5,336 # 10c28 <base>
    7ae0:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    7ae4:	fe043783          	ld	a5,-32(s0)
    7ae8:	639c                	ld	a5,0(a5)
    7aea:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    7aee:	fe843783          	ld	a5,-24(s0)
    7af2:	4798                	lw	a4,8(a5)
    7af4:	fdc42783          	lw	a5,-36(s0)
    7af8:	2781                	sext.w	a5,a5
    7afa:	06f76863          	bltu	a4,a5,7b6a <malloc+0xf2>
      if(p->s.size == nunits)
    7afe:	fe843783          	ld	a5,-24(s0)
    7b02:	4798                	lw	a4,8(a5)
    7b04:	fdc42783          	lw	a5,-36(s0)
    7b08:	2781                	sext.w	a5,a5
    7b0a:	00e79963          	bne	a5,a4,7b1c <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    7b0e:	fe843783          	ld	a5,-24(s0)
    7b12:	6398                	ld	a4,0(a5)
    7b14:	fe043783          	ld	a5,-32(s0)
    7b18:	e398                	sd	a4,0(a5)
    7b1a:	a82d                	j	7b54 <malloc+0xdc>
      else {
        p->s.size -= nunits;
    7b1c:	fe843783          	ld	a5,-24(s0)
    7b20:	4798                	lw	a4,8(a5)
    7b22:	fdc42783          	lw	a5,-36(s0)
    7b26:	40f707bb          	subw	a5,a4,a5
    7b2a:	0007871b          	sext.w	a4,a5
    7b2e:	fe843783          	ld	a5,-24(s0)
    7b32:	c798                	sw	a4,8(a5)
        p += p->s.size;
    7b34:	fe843783          	ld	a5,-24(s0)
    7b38:	479c                	lw	a5,8(a5)
    7b3a:	1782                	slli	a5,a5,0x20
    7b3c:	9381                	srli	a5,a5,0x20
    7b3e:	0792                	slli	a5,a5,0x4
    7b40:	fe843703          	ld	a4,-24(s0)
    7b44:	97ba                	add	a5,a5,a4
    7b46:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    7b4a:	fe843783          	ld	a5,-24(s0)
    7b4e:	fdc42703          	lw	a4,-36(s0)
    7b52:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    7b54:	00009797          	auipc	a5,0x9
    7b58:	0e478793          	addi	a5,a5,228 # 10c38 <freep>
    7b5c:	fe043703          	ld	a4,-32(s0)
    7b60:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    7b62:	fe843783          	ld	a5,-24(s0)
    7b66:	07c1                	addi	a5,a5,16
    7b68:	a091                	j	7bac <malloc+0x134>
    }
    if(p == freep)
    7b6a:	00009797          	auipc	a5,0x9
    7b6e:	0ce78793          	addi	a5,a5,206 # 10c38 <freep>
    7b72:	639c                	ld	a5,0(a5)
    7b74:	fe843703          	ld	a4,-24(s0)
    7b78:	02f71063          	bne	a4,a5,7b98 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
    7b7c:	fdc42783          	lw	a5,-36(s0)
    7b80:	853e                	mv	a0,a5
    7b82:	00000097          	auipc	ra,0x0
    7b86:	e76080e7          	jalr	-394(ra) # 79f8 <morecore>
    7b8a:	fea43423          	sd	a0,-24(s0)
    7b8e:	fe843783          	ld	a5,-24(s0)
    7b92:	e399                	bnez	a5,7b98 <malloc+0x120>
        return 0;
    7b94:	4781                	li	a5,0
    7b96:	a819                	j	7bac <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    7b98:	fe843783          	ld	a5,-24(s0)
    7b9c:	fef43023          	sd	a5,-32(s0)
    7ba0:	fe843783          	ld	a5,-24(s0)
    7ba4:	639c                	ld	a5,0(a5)
    7ba6:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    7baa:	b791                	j	7aee <malloc+0x76>
  }
}
    7bac:	853e                	mv	a0,a5
    7bae:	70e2                	ld	ra,56(sp)
    7bb0:	7442                	ld	s0,48(sp)
    7bb2:	6121                	addi	sp,sp,64
    7bb4:	8082                	ret
