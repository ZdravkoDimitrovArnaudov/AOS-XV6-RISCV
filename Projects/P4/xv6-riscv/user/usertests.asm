
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
      36:	aa79                	j	1d4 <copyin+0x1bc>
    uint64 addr = addrs[ai];
      38:	fec42783          	lw	a5,-20(s0)
      3c:	078e                	slli	a5,a5,0x3
      3e:	17c1                	addi	a5,a5,-16
      40:	97a2                	add	a5,a5,s0
      42:	fd87b783          	ld	a5,-40(a5)
      46:	fef43023          	sd	a5,-32(s0)
    
    int fd = open("copyin1", O_CREATE|O_WRONLY);
      4a:	20100593          	li	a1,513
      4e:	00008517          	auipc	a0,0x8
      52:	d5250513          	addi	a0,a0,-686 # 7da0 <cv_init+0x1a>
      56:	00007097          	auipc	ra,0x7
      5a:	35a080e7          	jalr	858(ra) # 73b0 <open>
      5e:	87aa                	mv	a5,a0
      60:	fcf42e23          	sw	a5,-36(s0)
    if(fd < 0){
      64:	fdc42783          	lw	a5,-36(s0)
      68:	2781                	sext.w	a5,a5
      6a:	0007df63          	bgez	a5,88 <copyin+0x70>
      printf("open(copyin1) failed\n");
      6e:	00008517          	auipc	a0,0x8
      72:	d3a50513          	addi	a0,a0,-710 # 7da8 <cv_init+0x22>
      76:	00008097          	auipc	ra,0x8
      7a:	832080e7          	jalr	-1998(ra) # 78a8 <printf>
      exit(1);
      7e:	4505                	li	a0,1
      80:	00007097          	auipc	ra,0x7
      84:	2f0080e7          	jalr	752(ra) # 7370 <exit>
    }
    int n = write(fd, (void*)addr, 8192);
      88:	fe043703          	ld	a4,-32(s0)
      8c:	fdc42783          	lw	a5,-36(s0)
      90:	6609                	lui	a2,0x2
      92:	85ba                	mv	a1,a4
      94:	853e                	mv	a0,a5
      96:	00007097          	auipc	ra,0x7
      9a:	2fa080e7          	jalr	762(ra) # 7390 <write>
      9e:	87aa                	mv	a5,a0
      a0:	fcf42c23          	sw	a5,-40(s0)
    if(n >= 0){
      a4:	fd842783          	lw	a5,-40(s0)
      a8:	2781                	sext.w	a5,a5
      aa:	0207c463          	bltz	a5,d2 <copyin+0xba>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
      ae:	fd842783          	lw	a5,-40(s0)
      b2:	863e                	mv	a2,a5
      b4:	fe043583          	ld	a1,-32(s0)
      b8:	00008517          	auipc	a0,0x8
      bc:	d0850513          	addi	a0,a0,-760 # 7dc0 <cv_init+0x3a>
      c0:	00007097          	auipc	ra,0x7
      c4:	7e8080e7          	jalr	2024(ra) # 78a8 <printf>
      exit(1);
      c8:	4505                	li	a0,1
      ca:	00007097          	auipc	ra,0x7
      ce:	2a6080e7          	jalr	678(ra) # 7370 <exit>
    }
    close(fd);
      d2:	fdc42783          	lw	a5,-36(s0)
      d6:	853e                	mv	a0,a5
      d8:	00007097          	auipc	ra,0x7
      dc:	2c0080e7          	jalr	704(ra) # 7398 <close>
    unlink("copyin1");
      e0:	00008517          	auipc	a0,0x8
      e4:	cc050513          	addi	a0,a0,-832 # 7da0 <cv_init+0x1a>
      e8:	00007097          	auipc	ra,0x7
      ec:	2d8080e7          	jalr	728(ra) # 73c0 <unlink>
    
    n = write(1, (char*)addr, 8192);
      f0:	fe043783          	ld	a5,-32(s0)
      f4:	6609                	lui	a2,0x2
      f6:	85be                	mv	a1,a5
      f8:	4505                	li	a0,1
      fa:	00007097          	auipc	ra,0x7
      fe:	296080e7          	jalr	662(ra) # 7390 <write>
     102:	87aa                	mv	a5,a0
     104:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     108:	fd842783          	lw	a5,-40(s0)
     10c:	2781                	sext.w	a5,a5
     10e:	02f05463          	blez	a5,136 <copyin+0x11e>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     112:	fd842783          	lw	a5,-40(s0)
     116:	863e                	mv	a2,a5
     118:	fe043583          	ld	a1,-32(s0)
     11c:	00008517          	auipc	a0,0x8
     120:	cd450513          	addi	a0,a0,-812 # 7df0 <cv_init+0x6a>
     124:	00007097          	auipc	ra,0x7
     128:	784080e7          	jalr	1924(ra) # 78a8 <printf>
      exit(1);
     12c:	4505                	li	a0,1
     12e:	00007097          	auipc	ra,0x7
     132:	242080e7          	jalr	578(ra) # 7370 <exit>
    }
    
    int fds[2];
    if(pipe(fds) < 0){
     136:	fc040793          	addi	a5,s0,-64
     13a:	853e                	mv	a0,a5
     13c:	00007097          	auipc	ra,0x7
     140:	244080e7          	jalr	580(ra) # 7380 <pipe>
     144:	87aa                	mv	a5,a0
     146:	0007df63          	bgez	a5,164 <copyin+0x14c>
      printf("pipe() failed\n");
     14a:	00008517          	auipc	a0,0x8
     14e:	cd650513          	addi	a0,a0,-810 # 7e20 <cv_init+0x9a>
     152:	00007097          	auipc	ra,0x7
     156:	756080e7          	jalr	1878(ra) # 78a8 <printf>
      exit(1);
     15a:	4505                	li	a0,1
     15c:	00007097          	auipc	ra,0x7
     160:	214080e7          	jalr	532(ra) # 7370 <exit>
    }
    n = write(fds[1], (char*)addr, 8192);
     164:	fc442783          	lw	a5,-60(s0)
     168:	fe043703          	ld	a4,-32(s0)
     16c:	6609                	lui	a2,0x2
     16e:	85ba                	mv	a1,a4
     170:	853e                	mv	a0,a5
     172:	00007097          	auipc	ra,0x7
     176:	21e080e7          	jalr	542(ra) # 7390 <write>
     17a:	87aa                	mv	a5,a0
     17c:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     180:	fd842783          	lw	a5,-40(s0)
     184:	2781                	sext.w	a5,a5
     186:	02f05463          	blez	a5,1ae <copyin+0x196>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     18a:	fd842783          	lw	a5,-40(s0)
     18e:	863e                	mv	a2,a5
     190:	fe043583          	ld	a1,-32(s0)
     194:	00008517          	auipc	a0,0x8
     198:	c9c50513          	addi	a0,a0,-868 # 7e30 <cv_init+0xaa>
     19c:	00007097          	auipc	ra,0x7
     1a0:	70c080e7          	jalr	1804(ra) # 78a8 <printf>
      exit(1);
     1a4:	4505                	li	a0,1
     1a6:	00007097          	auipc	ra,0x7
     1aa:	1ca080e7          	jalr	458(ra) # 7370 <exit>
    }
    close(fds[0]);
     1ae:	fc042783          	lw	a5,-64(s0)
     1b2:	853e                	mv	a0,a5
     1b4:	00007097          	auipc	ra,0x7
     1b8:	1e4080e7          	jalr	484(ra) # 7398 <close>
    close(fds[1]);
     1bc:	fc442783          	lw	a5,-60(s0)
     1c0:	853e                	mv	a0,a5
     1c2:	00007097          	auipc	ra,0x7
     1c6:	1d6080e7          	jalr	470(ra) # 7398 <close>
  for(int ai = 0; ai < 2; ai++){
     1ca:	fec42783          	lw	a5,-20(s0)
     1ce:	2785                	addiw	a5,a5,1
     1d0:	fef42623          	sw	a5,-20(s0)
     1d4:	fec42783          	lw	a5,-20(s0)
     1d8:	0007871b          	sext.w	a4,a5
     1dc:	4785                	li	a5,1
     1de:	e4e7dde3          	bge	a5,a4,38 <copyin+0x20>
  }
}
     1e2:	0001                	nop
     1e4:	0001                	nop
     1e6:	60a6                	ld	ra,72(sp)
     1e8:	6406                	ld	s0,64(sp)
     1ea:	6161                	addi	sp,sp,80
     1ec:	8082                	ret

00000000000001ee <copyout>:

// what if you pass ridiculous pointers to system calls
// that write user memory with copyout?
void
copyout(char *s)
{
     1ee:	715d                	addi	sp,sp,-80
     1f0:	e486                	sd	ra,72(sp)
     1f2:	e0a2                	sd	s0,64(sp)
     1f4:	0880                	addi	s0,sp,80
     1f6:	faa43c23          	sd	a0,-72(s0)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     1fa:	4785                	li	a5,1
     1fc:	07fe                	slli	a5,a5,0x1f
     1fe:	fcf43423          	sd	a5,-56(s0)
     202:	57fd                	li	a5,-1
     204:	fcf43823          	sd	a5,-48(s0)

  for(int ai = 0; ai < 2; ai++){
     208:	fe042623          	sw	zero,-20(s0)
     20c:	a271                	j	398 <copyout+0x1aa>
    uint64 addr = addrs[ai];
     20e:	fec42783          	lw	a5,-20(s0)
     212:	078e                	slli	a5,a5,0x3
     214:	17c1                	addi	a5,a5,-16
     216:	97a2                	add	a5,a5,s0
     218:	fd87b783          	ld	a5,-40(a5)
     21c:	fef43023          	sd	a5,-32(s0)

    int fd = open("README", 0);
     220:	4581                	li	a1,0
     222:	00008517          	auipc	a0,0x8
     226:	c3e50513          	addi	a0,a0,-962 # 7e60 <cv_init+0xda>
     22a:	00007097          	auipc	ra,0x7
     22e:	186080e7          	jalr	390(ra) # 73b0 <open>
     232:	87aa                	mv	a5,a0
     234:	fcf42e23          	sw	a5,-36(s0)
    if(fd < 0){
     238:	fdc42783          	lw	a5,-36(s0)
     23c:	2781                	sext.w	a5,a5
     23e:	0007df63          	bgez	a5,25c <copyout+0x6e>
      printf("open(README) failed\n");
     242:	00008517          	auipc	a0,0x8
     246:	c2650513          	addi	a0,a0,-986 # 7e68 <cv_init+0xe2>
     24a:	00007097          	auipc	ra,0x7
     24e:	65e080e7          	jalr	1630(ra) # 78a8 <printf>
      exit(1);
     252:	4505                	li	a0,1
     254:	00007097          	auipc	ra,0x7
     258:	11c080e7          	jalr	284(ra) # 7370 <exit>
    }
    int n = read(fd, (void*)addr, 8192);
     25c:	fe043703          	ld	a4,-32(s0)
     260:	fdc42783          	lw	a5,-36(s0)
     264:	6609                	lui	a2,0x2
     266:	85ba                	mv	a1,a4
     268:	853e                	mv	a0,a5
     26a:	00007097          	auipc	ra,0x7
     26e:	11e080e7          	jalr	286(ra) # 7388 <read>
     272:	87aa                	mv	a5,a0
     274:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     278:	fd842783          	lw	a5,-40(s0)
     27c:	2781                	sext.w	a5,a5
     27e:	02f05463          	blez	a5,2a6 <copyout+0xb8>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     282:	fd842783          	lw	a5,-40(s0)
     286:	863e                	mv	a2,a5
     288:	fe043583          	ld	a1,-32(s0)
     28c:	00008517          	auipc	a0,0x8
     290:	bf450513          	addi	a0,a0,-1036 # 7e80 <cv_init+0xfa>
     294:	00007097          	auipc	ra,0x7
     298:	614080e7          	jalr	1556(ra) # 78a8 <printf>
      exit(1);
     29c:	4505                	li	a0,1
     29e:	00007097          	auipc	ra,0x7
     2a2:	0d2080e7          	jalr	210(ra) # 7370 <exit>
    }
    close(fd);
     2a6:	fdc42783          	lw	a5,-36(s0)
     2aa:	853e                	mv	a0,a5
     2ac:	00007097          	auipc	ra,0x7
     2b0:	0ec080e7          	jalr	236(ra) # 7398 <close>

    int fds[2];
    if(pipe(fds) < 0){
     2b4:	fc040793          	addi	a5,s0,-64
     2b8:	853e                	mv	a0,a5
     2ba:	00007097          	auipc	ra,0x7
     2be:	0c6080e7          	jalr	198(ra) # 7380 <pipe>
     2c2:	87aa                	mv	a5,a0
     2c4:	0007df63          	bgez	a5,2e2 <copyout+0xf4>
      printf("pipe() failed\n");
     2c8:	00008517          	auipc	a0,0x8
     2cc:	b5850513          	addi	a0,a0,-1192 # 7e20 <cv_init+0x9a>
     2d0:	00007097          	auipc	ra,0x7
     2d4:	5d8080e7          	jalr	1496(ra) # 78a8 <printf>
      exit(1);
     2d8:	4505                	li	a0,1
     2da:	00007097          	auipc	ra,0x7
     2de:	096080e7          	jalr	150(ra) # 7370 <exit>
    }
    n = write(fds[1], "x", 1);
     2e2:	fc442783          	lw	a5,-60(s0)
     2e6:	4605                	li	a2,1
     2e8:	00008597          	auipc	a1,0x8
     2ec:	bc858593          	addi	a1,a1,-1080 # 7eb0 <cv_init+0x12a>
     2f0:	853e                	mv	a0,a5
     2f2:	00007097          	auipc	ra,0x7
     2f6:	09e080e7          	jalr	158(ra) # 7390 <write>
     2fa:	87aa                	mv	a5,a0
     2fc:	fcf42c23          	sw	a5,-40(s0)
    if(n != 1){
     300:	fd842783          	lw	a5,-40(s0)
     304:	0007871b          	sext.w	a4,a5
     308:	4785                	li	a5,1
     30a:	00f70f63          	beq	a4,a5,328 <copyout+0x13a>
      printf("pipe write failed\n");
     30e:	00008517          	auipc	a0,0x8
     312:	baa50513          	addi	a0,a0,-1110 # 7eb8 <cv_init+0x132>
     316:	00007097          	auipc	ra,0x7
     31a:	592080e7          	jalr	1426(ra) # 78a8 <printf>
      exit(1);
     31e:	4505                	li	a0,1
     320:	00007097          	auipc	ra,0x7
     324:	050080e7          	jalr	80(ra) # 7370 <exit>
    }
    n = read(fds[0], (void*)addr, 8192);
     328:	fc042783          	lw	a5,-64(s0)
     32c:	fe043703          	ld	a4,-32(s0)
     330:	6609                	lui	a2,0x2
     332:	85ba                	mv	a1,a4
     334:	853e                	mv	a0,a5
     336:	00007097          	auipc	ra,0x7
     33a:	052080e7          	jalr	82(ra) # 7388 <read>
     33e:	87aa                	mv	a5,a0
     340:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     344:	fd842783          	lw	a5,-40(s0)
     348:	2781                	sext.w	a5,a5
     34a:	02f05463          	blez	a5,372 <copyout+0x184>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     34e:	fd842783          	lw	a5,-40(s0)
     352:	863e                	mv	a2,a5
     354:	fe043583          	ld	a1,-32(s0)
     358:	00008517          	auipc	a0,0x8
     35c:	b7850513          	addi	a0,a0,-1160 # 7ed0 <cv_init+0x14a>
     360:	00007097          	auipc	ra,0x7
     364:	548080e7          	jalr	1352(ra) # 78a8 <printf>
      exit(1);
     368:	4505                	li	a0,1
     36a:	00007097          	auipc	ra,0x7
     36e:	006080e7          	jalr	6(ra) # 7370 <exit>
    }
    close(fds[0]);
     372:	fc042783          	lw	a5,-64(s0)
     376:	853e                	mv	a0,a5
     378:	00007097          	auipc	ra,0x7
     37c:	020080e7          	jalr	32(ra) # 7398 <close>
    close(fds[1]);
     380:	fc442783          	lw	a5,-60(s0)
     384:	853e                	mv	a0,a5
     386:	00007097          	auipc	ra,0x7
     38a:	012080e7          	jalr	18(ra) # 7398 <close>
  for(int ai = 0; ai < 2; ai++){
     38e:	fec42783          	lw	a5,-20(s0)
     392:	2785                	addiw	a5,a5,1
     394:	fef42623          	sw	a5,-20(s0)
     398:	fec42783          	lw	a5,-20(s0)
     39c:	0007871b          	sext.w	a4,a5
     3a0:	4785                	li	a5,1
     3a2:	e6e7d6e3          	bge	a5,a4,20e <copyout+0x20>
  }
}
     3a6:	0001                	nop
     3a8:	0001                	nop
     3aa:	60a6                	ld	ra,72(sp)
     3ac:	6406                	ld	s0,64(sp)
     3ae:	6161                	addi	sp,sp,80
     3b0:	8082                	ret

00000000000003b2 <copyinstr1>:

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
     3b2:	715d                	addi	sp,sp,-80
     3b4:	e486                	sd	ra,72(sp)
     3b6:	e0a2                	sd	s0,64(sp)
     3b8:	0880                	addi	s0,sp,80
     3ba:	faa43c23          	sd	a0,-72(s0)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     3be:	4785                	li	a5,1
     3c0:	07fe                	slli	a5,a5,0x1f
     3c2:	fcf43423          	sd	a5,-56(s0)
     3c6:	57fd                	li	a5,-1
     3c8:	fcf43823          	sd	a5,-48(s0)

  for(int ai = 0; ai < 2; ai++){
     3cc:	fe042623          	sw	zero,-20(s0)
     3d0:	a095                	j	434 <copyinstr1+0x82>
    uint64 addr = addrs[ai];
     3d2:	fec42783          	lw	a5,-20(s0)
     3d6:	078e                	slli	a5,a5,0x3
     3d8:	17c1                	addi	a5,a5,-16
     3da:	97a2                	add	a5,a5,s0
     3dc:	fd87b783          	ld	a5,-40(a5)
     3e0:	fef43023          	sd	a5,-32(s0)

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
     3e4:	fe043783          	ld	a5,-32(s0)
     3e8:	20100593          	li	a1,513
     3ec:	853e                	mv	a0,a5
     3ee:	00007097          	auipc	ra,0x7
     3f2:	fc2080e7          	jalr	-62(ra) # 73b0 <open>
     3f6:	87aa                	mv	a5,a0
     3f8:	fcf42e23          	sw	a5,-36(s0)
    if(fd >= 0){
     3fc:	fdc42783          	lw	a5,-36(s0)
     400:	2781                	sext.w	a5,a5
     402:	0207c463          	bltz	a5,42a <copyinstr1+0x78>
      printf("open(%p) returned %d, not -1\n", addr, fd);
     406:	fdc42783          	lw	a5,-36(s0)
     40a:	863e                	mv	a2,a5
     40c:	fe043583          	ld	a1,-32(s0)
     410:	00008517          	auipc	a0,0x8
     414:	af050513          	addi	a0,a0,-1296 # 7f00 <cv_init+0x17a>
     418:	00007097          	auipc	ra,0x7
     41c:	490080e7          	jalr	1168(ra) # 78a8 <printf>
      exit(1);
     420:	4505                	li	a0,1
     422:	00007097          	auipc	ra,0x7
     426:	f4e080e7          	jalr	-178(ra) # 7370 <exit>
  for(int ai = 0; ai < 2; ai++){
     42a:	fec42783          	lw	a5,-20(s0)
     42e:	2785                	addiw	a5,a5,1
     430:	fef42623          	sw	a5,-20(s0)
     434:	fec42783          	lw	a5,-20(s0)
     438:	0007871b          	sext.w	a4,a5
     43c:	4785                	li	a5,1
     43e:	f8e7dae3          	bge	a5,a4,3d2 <copyinstr1+0x20>
    }
  }
}
     442:	0001                	nop
     444:	0001                	nop
     446:	60a6                	ld	ra,72(sp)
     448:	6406                	ld	s0,64(sp)
     44a:	6161                	addi	sp,sp,80
     44c:	8082                	ret

000000000000044e <copyinstr2>:
// what if a string system call argument is exactly the size
// of the kernel buffer it is copied into, so that the null
// would fall just beyond the end of the kernel buffer?
void
copyinstr2(char *s)
{
     44e:	7151                	addi	sp,sp,-240
     450:	f586                	sd	ra,232(sp)
     452:	f1a2                	sd	s0,224(sp)
     454:	1980                	addi	s0,sp,240
     456:	f0a43c23          	sd	a0,-232(s0)
  char b[MAXPATH+1];

  for(int i = 0; i < MAXPATH; i++)
     45a:	fe042623          	sw	zero,-20(s0)
     45e:	a831                	j	47a <copyinstr2+0x2c>
    b[i] = 'x';
     460:	fec42783          	lw	a5,-20(s0)
     464:	17c1                	addi	a5,a5,-16
     466:	97a2                	add	a5,a5,s0
     468:	07800713          	li	a4,120
     46c:	f6e78423          	sb	a4,-152(a5)
  for(int i = 0; i < MAXPATH; i++)
     470:	fec42783          	lw	a5,-20(s0)
     474:	2785                	addiw	a5,a5,1
     476:	fef42623          	sw	a5,-20(s0)
     47a:	fec42783          	lw	a5,-20(s0)
     47e:	0007871b          	sext.w	a4,a5
     482:	07f00793          	li	a5,127
     486:	fce7dde3          	bge	a5,a4,460 <copyinstr2+0x12>
  b[MAXPATH] = '\0';
     48a:	fc040c23          	sb	zero,-40(s0)
  
  int ret = unlink(b);
     48e:	f5840793          	addi	a5,s0,-168
     492:	853e                	mv	a0,a5
     494:	00007097          	auipc	ra,0x7
     498:	f2c080e7          	jalr	-212(ra) # 73c0 <unlink>
     49c:	87aa                	mv	a5,a0
     49e:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     4a2:	fe442783          	lw	a5,-28(s0)
     4a6:	0007871b          	sext.w	a4,a5
     4aa:	57fd                	li	a5,-1
     4ac:	02f70563          	beq	a4,a5,4d6 <copyinstr2+0x88>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
     4b0:	fe442703          	lw	a4,-28(s0)
     4b4:	f5840793          	addi	a5,s0,-168
     4b8:	863a                	mv	a2,a4
     4ba:	85be                	mv	a1,a5
     4bc:	00008517          	auipc	a0,0x8
     4c0:	a6450513          	addi	a0,a0,-1436 # 7f20 <cv_init+0x19a>
     4c4:	00007097          	auipc	ra,0x7
     4c8:	3e4080e7          	jalr	996(ra) # 78a8 <printf>
    exit(1);
     4cc:	4505                	li	a0,1
     4ce:	00007097          	auipc	ra,0x7
     4d2:	ea2080e7          	jalr	-350(ra) # 7370 <exit>
  }

  int fd = open(b, O_CREATE | O_WRONLY);
     4d6:	f5840793          	addi	a5,s0,-168
     4da:	20100593          	li	a1,513
     4de:	853e                	mv	a0,a5
     4e0:	00007097          	auipc	ra,0x7
     4e4:	ed0080e7          	jalr	-304(ra) # 73b0 <open>
     4e8:	87aa                	mv	a5,a0
     4ea:	fef42023          	sw	a5,-32(s0)
  if(fd != -1){
     4ee:	fe042783          	lw	a5,-32(s0)
     4f2:	0007871b          	sext.w	a4,a5
     4f6:	57fd                	li	a5,-1
     4f8:	02f70563          	beq	a4,a5,522 <copyinstr2+0xd4>
    printf("open(%s) returned %d, not -1\n", b, fd);
     4fc:	fe042703          	lw	a4,-32(s0)
     500:	f5840793          	addi	a5,s0,-168
     504:	863a                	mv	a2,a4
     506:	85be                	mv	a1,a5
     508:	00008517          	auipc	a0,0x8
     50c:	a3850513          	addi	a0,a0,-1480 # 7f40 <cv_init+0x1ba>
     510:	00007097          	auipc	ra,0x7
     514:	398080e7          	jalr	920(ra) # 78a8 <printf>
    exit(1);
     518:	4505                	li	a0,1
     51a:	00007097          	auipc	ra,0x7
     51e:	e56080e7          	jalr	-426(ra) # 7370 <exit>
  }

  ret = link(b, b);
     522:	f5840713          	addi	a4,s0,-168
     526:	f5840793          	addi	a5,s0,-168
     52a:	85ba                	mv	a1,a4
     52c:	853e                	mv	a0,a5
     52e:	00007097          	auipc	ra,0x7
     532:	ea2080e7          	jalr	-350(ra) # 73d0 <link>
     536:	87aa                	mv	a5,a0
     538:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     53c:	fe442783          	lw	a5,-28(s0)
     540:	0007871b          	sext.w	a4,a5
     544:	57fd                	li	a5,-1
     546:	02f70763          	beq	a4,a5,574 <copyinstr2+0x126>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
     54a:	fe442683          	lw	a3,-28(s0)
     54e:	f5840713          	addi	a4,s0,-168
     552:	f5840793          	addi	a5,s0,-168
     556:	863a                	mv	a2,a4
     558:	85be                	mv	a1,a5
     55a:	00008517          	auipc	a0,0x8
     55e:	a0650513          	addi	a0,a0,-1530 # 7f60 <cv_init+0x1da>
     562:	00007097          	auipc	ra,0x7
     566:	346080e7          	jalr	838(ra) # 78a8 <printf>
    exit(1);
     56a:	4505                	li	a0,1
     56c:	00007097          	auipc	ra,0x7
     570:	e04080e7          	jalr	-508(ra) # 7370 <exit>
  }

  char *args[] = { "xx", 0 };
     574:	00008797          	auipc	a5,0x8
     578:	a1478793          	addi	a5,a5,-1516 # 7f88 <cv_init+0x202>
     57c:	f4f43423          	sd	a5,-184(s0)
     580:	f4043823          	sd	zero,-176(s0)
  ret = exec(b, args);
     584:	f4840713          	addi	a4,s0,-184
     588:	f5840793          	addi	a5,s0,-168
     58c:	85ba                	mv	a1,a4
     58e:	853e                	mv	a0,a5
     590:	00007097          	auipc	ra,0x7
     594:	e18080e7          	jalr	-488(ra) # 73a8 <exec>
     598:	87aa                	mv	a5,a0
     59a:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     59e:	fe442783          	lw	a5,-28(s0)
     5a2:	0007871b          	sext.w	a4,a5
     5a6:	57fd                	li	a5,-1
     5a8:	02f70563          	beq	a4,a5,5d2 <copyinstr2+0x184>
    printf("exec(%s) returned %d, not -1\n", b, fd);
     5ac:	fe042703          	lw	a4,-32(s0)
     5b0:	f5840793          	addi	a5,s0,-168
     5b4:	863a                	mv	a2,a4
     5b6:	85be                	mv	a1,a5
     5b8:	00008517          	auipc	a0,0x8
     5bc:	9d850513          	addi	a0,a0,-1576 # 7f90 <cv_init+0x20a>
     5c0:	00007097          	auipc	ra,0x7
     5c4:	2e8080e7          	jalr	744(ra) # 78a8 <printf>
    exit(1);
     5c8:	4505                	li	a0,1
     5ca:	00007097          	auipc	ra,0x7
     5ce:	da6080e7          	jalr	-602(ra) # 7370 <exit>
  }

  int pid = fork();
     5d2:	00007097          	auipc	ra,0x7
     5d6:	d96080e7          	jalr	-618(ra) # 7368 <fork>
     5da:	87aa                	mv	a5,a0
     5dc:	fcf42e23          	sw	a5,-36(s0)
  if(pid < 0){
     5e0:	fdc42783          	lw	a5,-36(s0)
     5e4:	2781                	sext.w	a5,a5
     5e6:	0007df63          	bgez	a5,604 <copyinstr2+0x1b6>
    printf("fork failed\n");
     5ea:	00008517          	auipc	a0,0x8
     5ee:	9c650513          	addi	a0,a0,-1594 # 7fb0 <cv_init+0x22a>
     5f2:	00007097          	auipc	ra,0x7
     5f6:	2b6080e7          	jalr	694(ra) # 78a8 <printf>
    exit(1);
     5fa:	4505                	li	a0,1
     5fc:	00007097          	auipc	ra,0x7
     600:	d74080e7          	jalr	-652(ra) # 7370 <exit>
  }
  if(pid == 0){
     604:	fdc42783          	lw	a5,-36(s0)
     608:	2781                	sext.w	a5,a5
     60a:	efd5                	bnez	a5,6c6 <copyinstr2+0x278>
    static char big[PGSIZE+1];
    for(int i = 0; i < PGSIZE; i++)
     60c:	fe042423          	sw	zero,-24(s0)
     610:	a00d                	j	632 <copyinstr2+0x1e4>
      big[i] = 'x';
     612:	0000f717          	auipc	a4,0xf
     616:	74670713          	addi	a4,a4,1862 # fd58 <big.0>
     61a:	fe842783          	lw	a5,-24(s0)
     61e:	97ba                	add	a5,a5,a4
     620:	07800713          	li	a4,120
     624:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
     628:	fe842783          	lw	a5,-24(s0)
     62c:	2785                	addiw	a5,a5,1
     62e:	fef42423          	sw	a5,-24(s0)
     632:	fe842783          	lw	a5,-24(s0)
     636:	0007871b          	sext.w	a4,a5
     63a:	6785                	lui	a5,0x1
     63c:	fcf74be3          	blt	a4,a5,612 <copyinstr2+0x1c4>
    big[PGSIZE] = '\0';
     640:	0000f717          	auipc	a4,0xf
     644:	71870713          	addi	a4,a4,1816 # fd58 <big.0>
     648:	6785                	lui	a5,0x1
     64a:	97ba                	add	a5,a5,a4
     64c:	00078023          	sb	zero,0(a5) # 1000 <truncate3+0x1b2>
    char *args2[] = { big, big, big, 0 };
     650:	00008797          	auipc	a5,0x8
     654:	9d078793          	addi	a5,a5,-1584 # 8020 <cv_init+0x29a>
     658:	6390                	ld	a2,0(a5)
     65a:	6794                	ld	a3,8(a5)
     65c:	6b98                	ld	a4,16(a5)
     65e:	6f9c                	ld	a5,24(a5)
     660:	f2c43023          	sd	a2,-224(s0)
     664:	f2d43423          	sd	a3,-216(s0)
     668:	f2e43823          	sd	a4,-208(s0)
     66c:	f2f43c23          	sd	a5,-200(s0)
    ret = exec("echo", args2);
     670:	f2040793          	addi	a5,s0,-224
     674:	85be                	mv	a1,a5
     676:	00008517          	auipc	a0,0x8
     67a:	94a50513          	addi	a0,a0,-1718 # 7fc0 <cv_init+0x23a>
     67e:	00007097          	auipc	ra,0x7
     682:	d2a080e7          	jalr	-726(ra) # 73a8 <exec>
     686:	87aa                	mv	a5,a0
     688:	fef42223          	sw	a5,-28(s0)
    if(ret != -1){
     68c:	fe442783          	lw	a5,-28(s0)
     690:	0007871b          	sext.w	a4,a5
     694:	57fd                	li	a5,-1
     696:	02f70263          	beq	a4,a5,6ba <copyinstr2+0x26c>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
     69a:	fe042783          	lw	a5,-32(s0)
     69e:	85be                	mv	a1,a5
     6a0:	00008517          	auipc	a0,0x8
     6a4:	92850513          	addi	a0,a0,-1752 # 7fc8 <cv_init+0x242>
     6a8:	00007097          	auipc	ra,0x7
     6ac:	200080e7          	jalr	512(ra) # 78a8 <printf>
      exit(1);
     6b0:	4505                	li	a0,1
     6b2:	00007097          	auipc	ra,0x7
     6b6:	cbe080e7          	jalr	-834(ra) # 7370 <exit>
    }
    exit(747); // OK
     6ba:	2eb00513          	li	a0,747
     6be:	00007097          	auipc	ra,0x7
     6c2:	cb2080e7          	jalr	-846(ra) # 7370 <exit>
  }

  int st = 0;
     6c6:	f4042223          	sw	zero,-188(s0)
  wait(&st);
     6ca:	f4440793          	addi	a5,s0,-188
     6ce:	853e                	mv	a0,a5
     6d0:	00007097          	auipc	ra,0x7
     6d4:	ca8080e7          	jalr	-856(ra) # 7378 <wait>
  if(st != 747){
     6d8:	f4442783          	lw	a5,-188(s0)
     6dc:	873e                	mv	a4,a5
     6de:	2eb00793          	li	a5,747
     6e2:	00f70f63          	beq	a4,a5,700 <copyinstr2+0x2b2>
    printf("exec(echo, BIG) succeeded, should have failed\n");
     6e6:	00008517          	auipc	a0,0x8
     6ea:	90a50513          	addi	a0,a0,-1782 # 7ff0 <cv_init+0x26a>
     6ee:	00007097          	auipc	ra,0x7
     6f2:	1ba080e7          	jalr	442(ra) # 78a8 <printf>
    exit(1);
     6f6:	4505                	li	a0,1
     6f8:	00007097          	auipc	ra,0x7
     6fc:	c78080e7          	jalr	-904(ra) # 7370 <exit>
  }
}
     700:	0001                	nop
     702:	70ae                	ld	ra,232(sp)
     704:	740e                	ld	s0,224(sp)
     706:	616d                	addi	sp,sp,240
     708:	8082                	ret

000000000000070a <copyinstr3>:

// what if a string argument crosses over the end of last user page?
void
copyinstr3(char *s)
{
     70a:	715d                	addi	sp,sp,-80
     70c:	e486                	sd	ra,72(sp)
     70e:	e0a2                	sd	s0,64(sp)
     710:	0880                	addi	s0,sp,80
     712:	faa43c23          	sd	a0,-72(s0)
  sbrk(8192);
     716:	6509                	lui	a0,0x2
     718:	00007097          	auipc	ra,0x7
     71c:	ce0080e7          	jalr	-800(ra) # 73f8 <sbrk>
  uint64 top = (uint64) sbrk(0);
     720:	4501                	li	a0,0
     722:	00007097          	auipc	ra,0x7
     726:	cd6080e7          	jalr	-810(ra) # 73f8 <sbrk>
     72a:	87aa                	mv	a5,a0
     72c:	fef43423          	sd	a5,-24(s0)
  if((top % PGSIZE) != 0){
     730:	fe843703          	ld	a4,-24(s0)
     734:	6785                	lui	a5,0x1
     736:	17fd                	addi	a5,a5,-1
     738:	8ff9                	and	a5,a5,a4
     73a:	c39d                	beqz	a5,760 <copyinstr3+0x56>
    sbrk(PGSIZE - (top % PGSIZE));
     73c:	fe843783          	ld	a5,-24(s0)
     740:	2781                	sext.w	a5,a5
     742:	873e                	mv	a4,a5
     744:	6785                	lui	a5,0x1
     746:	17fd                	addi	a5,a5,-1
     748:	8ff9                	and	a5,a5,a4
     74a:	2781                	sext.w	a5,a5
     74c:	6705                	lui	a4,0x1
     74e:	40f707bb          	subw	a5,a4,a5
     752:	2781                	sext.w	a5,a5
     754:	2781                	sext.w	a5,a5
     756:	853e                	mv	a0,a5
     758:	00007097          	auipc	ra,0x7
     75c:	ca0080e7          	jalr	-864(ra) # 73f8 <sbrk>
  }
  top = (uint64) sbrk(0);
     760:	4501                	li	a0,0
     762:	00007097          	auipc	ra,0x7
     766:	c96080e7          	jalr	-874(ra) # 73f8 <sbrk>
     76a:	87aa                	mv	a5,a0
     76c:	fef43423          	sd	a5,-24(s0)
  if(top % PGSIZE){
     770:	fe843703          	ld	a4,-24(s0)
     774:	6785                	lui	a5,0x1
     776:	17fd                	addi	a5,a5,-1
     778:	8ff9                	and	a5,a5,a4
     77a:	cf91                	beqz	a5,796 <copyinstr3+0x8c>
    printf("oops\n");
     77c:	00008517          	auipc	a0,0x8
     780:	8c450513          	addi	a0,a0,-1852 # 8040 <cv_init+0x2ba>
     784:	00007097          	auipc	ra,0x7
     788:	124080e7          	jalr	292(ra) # 78a8 <printf>
    exit(1);
     78c:	4505                	li	a0,1
     78e:	00007097          	auipc	ra,0x7
     792:	be2080e7          	jalr	-1054(ra) # 7370 <exit>
  }

  char *b = (char *) (top - 1);
     796:	fe843783          	ld	a5,-24(s0)
     79a:	17fd                	addi	a5,a5,-1
     79c:	fef43023          	sd	a5,-32(s0)
  *b = 'x';
     7a0:	fe043783          	ld	a5,-32(s0)
     7a4:	07800713          	li	a4,120
     7a8:	00e78023          	sb	a4,0(a5) # 1000 <truncate3+0x1b2>

  int ret = unlink(b);
     7ac:	fe043503          	ld	a0,-32(s0)
     7b0:	00007097          	auipc	ra,0x7
     7b4:	c10080e7          	jalr	-1008(ra) # 73c0 <unlink>
     7b8:	87aa                	mv	a5,a0
     7ba:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     7be:	fdc42783          	lw	a5,-36(s0)
     7c2:	0007871b          	sext.w	a4,a5
     7c6:	57fd                	li	a5,-1
     7c8:	02f70463          	beq	a4,a5,7f0 <copyinstr3+0xe6>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
     7cc:	fdc42783          	lw	a5,-36(s0)
     7d0:	863e                	mv	a2,a5
     7d2:	fe043583          	ld	a1,-32(s0)
     7d6:	00007517          	auipc	a0,0x7
     7da:	74a50513          	addi	a0,a0,1866 # 7f20 <cv_init+0x19a>
     7de:	00007097          	auipc	ra,0x7
     7e2:	0ca080e7          	jalr	202(ra) # 78a8 <printf>
    exit(1);
     7e6:	4505                	li	a0,1
     7e8:	00007097          	auipc	ra,0x7
     7ec:	b88080e7          	jalr	-1144(ra) # 7370 <exit>
  }

  int fd = open(b, O_CREATE | O_WRONLY);
     7f0:	20100593          	li	a1,513
     7f4:	fe043503          	ld	a0,-32(s0)
     7f8:	00007097          	auipc	ra,0x7
     7fc:	bb8080e7          	jalr	-1096(ra) # 73b0 <open>
     800:	87aa                	mv	a5,a0
     802:	fcf42c23          	sw	a5,-40(s0)
  if(fd != -1){
     806:	fd842783          	lw	a5,-40(s0)
     80a:	0007871b          	sext.w	a4,a5
     80e:	57fd                	li	a5,-1
     810:	02f70463          	beq	a4,a5,838 <copyinstr3+0x12e>
    printf("open(%s) returned %d, not -1\n", b, fd);
     814:	fd842783          	lw	a5,-40(s0)
     818:	863e                	mv	a2,a5
     81a:	fe043583          	ld	a1,-32(s0)
     81e:	00007517          	auipc	a0,0x7
     822:	72250513          	addi	a0,a0,1826 # 7f40 <cv_init+0x1ba>
     826:	00007097          	auipc	ra,0x7
     82a:	082080e7          	jalr	130(ra) # 78a8 <printf>
    exit(1);
     82e:	4505                	li	a0,1
     830:	00007097          	auipc	ra,0x7
     834:	b40080e7          	jalr	-1216(ra) # 7370 <exit>
  }

  ret = link(b, b);
     838:	fe043583          	ld	a1,-32(s0)
     83c:	fe043503          	ld	a0,-32(s0)
     840:	00007097          	auipc	ra,0x7
     844:	b90080e7          	jalr	-1136(ra) # 73d0 <link>
     848:	87aa                	mv	a5,a0
     84a:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     84e:	fdc42783          	lw	a5,-36(s0)
     852:	0007871b          	sext.w	a4,a5
     856:	57fd                	li	a5,-1
     858:	02f70663          	beq	a4,a5,884 <copyinstr3+0x17a>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
     85c:	fdc42783          	lw	a5,-36(s0)
     860:	86be                	mv	a3,a5
     862:	fe043603          	ld	a2,-32(s0)
     866:	fe043583          	ld	a1,-32(s0)
     86a:	00007517          	auipc	a0,0x7
     86e:	6f650513          	addi	a0,a0,1782 # 7f60 <cv_init+0x1da>
     872:	00007097          	auipc	ra,0x7
     876:	036080e7          	jalr	54(ra) # 78a8 <printf>
    exit(1);
     87a:	4505                	li	a0,1
     87c:	00007097          	auipc	ra,0x7
     880:	af4080e7          	jalr	-1292(ra) # 7370 <exit>
  }

  char *args[] = { "xx", 0 };
     884:	00007797          	auipc	a5,0x7
     888:	70478793          	addi	a5,a5,1796 # 7f88 <cv_init+0x202>
     88c:	fcf43423          	sd	a5,-56(s0)
     890:	fc043823          	sd	zero,-48(s0)
  ret = exec(b, args);
     894:	fc840793          	addi	a5,s0,-56
     898:	85be                	mv	a1,a5
     89a:	fe043503          	ld	a0,-32(s0)
     89e:	00007097          	auipc	ra,0x7
     8a2:	b0a080e7          	jalr	-1270(ra) # 73a8 <exec>
     8a6:	87aa                	mv	a5,a0
     8a8:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     8ac:	fdc42783          	lw	a5,-36(s0)
     8b0:	0007871b          	sext.w	a4,a5
     8b4:	57fd                	li	a5,-1
     8b6:	02f70463          	beq	a4,a5,8de <copyinstr3+0x1d4>
    printf("exec(%s) returned %d, not -1\n", b, fd);
     8ba:	fd842783          	lw	a5,-40(s0)
     8be:	863e                	mv	a2,a5
     8c0:	fe043583          	ld	a1,-32(s0)
     8c4:	00007517          	auipc	a0,0x7
     8c8:	6cc50513          	addi	a0,a0,1740 # 7f90 <cv_init+0x20a>
     8cc:	00007097          	auipc	ra,0x7
     8d0:	fdc080e7          	jalr	-36(ra) # 78a8 <printf>
    exit(1);
     8d4:	4505                	li	a0,1
     8d6:	00007097          	auipc	ra,0x7
     8da:	a9a080e7          	jalr	-1382(ra) # 7370 <exit>
  }
}
     8de:	0001                	nop
     8e0:	60a6                	ld	ra,72(sp)
     8e2:	6406                	ld	s0,64(sp)
     8e4:	6161                	addi	sp,sp,80
     8e6:	8082                	ret

00000000000008e8 <rwsbrk>:

// See if the kernel refuses to read/write user memory that the
// application doesn't have anymore, because it returned it.
void
rwsbrk()
{
     8e8:	1101                	addi	sp,sp,-32
     8ea:	ec06                	sd	ra,24(sp)
     8ec:	e822                	sd	s0,16(sp)
     8ee:	1000                	addi	s0,sp,32
  int fd, n;
  
  uint64 a = (uint64) sbrk(8192);
     8f0:	6509                	lui	a0,0x2
     8f2:	00007097          	auipc	ra,0x7
     8f6:	b06080e7          	jalr	-1274(ra) # 73f8 <sbrk>
     8fa:	87aa                	mv	a5,a0
     8fc:	fef43423          	sd	a5,-24(s0)

  if(a == 0xffffffffffffffffLL) {
     900:	fe843703          	ld	a4,-24(s0)
     904:	57fd                	li	a5,-1
     906:	00f71f63          	bne	a4,a5,924 <rwsbrk+0x3c>
    printf("sbrk(rwsbrk) failed\n");
     90a:	00007517          	auipc	a0,0x7
     90e:	73e50513          	addi	a0,a0,1854 # 8048 <cv_init+0x2c2>
     912:	00007097          	auipc	ra,0x7
     916:	f96080e7          	jalr	-106(ra) # 78a8 <printf>
    exit(1);
     91a:	4505                	li	a0,1
     91c:	00007097          	auipc	ra,0x7
     920:	a54080e7          	jalr	-1452(ra) # 7370 <exit>
  }
  
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
     924:	7579                	lui	a0,0xffffe
     926:	00007097          	auipc	ra,0x7
     92a:	ad2080e7          	jalr	-1326(ra) # 73f8 <sbrk>
     92e:	872a                	mv	a4,a0
     930:	57fd                	li	a5,-1
     932:	00f71f63          	bne	a4,a5,950 <rwsbrk+0x68>
    printf("sbrk(rwsbrk) shrink failed\n");
     936:	00007517          	auipc	a0,0x7
     93a:	72a50513          	addi	a0,a0,1834 # 8060 <cv_init+0x2da>
     93e:	00007097          	auipc	ra,0x7
     942:	f6a080e7          	jalr	-150(ra) # 78a8 <printf>
    exit(1);
     946:	4505                	li	a0,1
     948:	00007097          	auipc	ra,0x7
     94c:	a28080e7          	jalr	-1496(ra) # 7370 <exit>
  }

  fd = open("rwsbrk", O_CREATE|O_WRONLY);
     950:	20100593          	li	a1,513
     954:	00007517          	auipc	a0,0x7
     958:	72c50513          	addi	a0,a0,1836 # 8080 <cv_init+0x2fa>
     95c:	00007097          	auipc	ra,0x7
     960:	a54080e7          	jalr	-1452(ra) # 73b0 <open>
     964:	87aa                	mv	a5,a0
     966:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
     96a:	fe442783          	lw	a5,-28(s0)
     96e:	2781                	sext.w	a5,a5
     970:	0007df63          	bgez	a5,98e <rwsbrk+0xa6>
    printf("open(rwsbrk) failed\n");
     974:	00007517          	auipc	a0,0x7
     978:	71450513          	addi	a0,a0,1812 # 8088 <cv_init+0x302>
     97c:	00007097          	auipc	ra,0x7
     980:	f2c080e7          	jalr	-212(ra) # 78a8 <printf>
    exit(1);
     984:	4505                	li	a0,1
     986:	00007097          	auipc	ra,0x7
     98a:	9ea080e7          	jalr	-1558(ra) # 7370 <exit>
  }
  n = write(fd, (void*)(a+4096), 1024);
     98e:	fe843703          	ld	a4,-24(s0)
     992:	6785                	lui	a5,0x1
     994:	97ba                	add	a5,a5,a4
     996:	873e                	mv	a4,a5
     998:	fe442783          	lw	a5,-28(s0)
     99c:	40000613          	li	a2,1024
     9a0:	85ba                	mv	a1,a4
     9a2:	853e                	mv	a0,a5
     9a4:	00007097          	auipc	ra,0x7
     9a8:	9ec080e7          	jalr	-1556(ra) # 7390 <write>
     9ac:	87aa                	mv	a5,a0
     9ae:	fef42023          	sw	a5,-32(s0)
  if(n >= 0){
     9b2:	fe042783          	lw	a5,-32(s0)
     9b6:	2781                	sext.w	a5,a5
     9b8:	0207c763          	bltz	a5,9e6 <rwsbrk+0xfe>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
     9bc:	fe843703          	ld	a4,-24(s0)
     9c0:	6785                	lui	a5,0x1
     9c2:	97ba                	add	a5,a5,a4
     9c4:	fe042703          	lw	a4,-32(s0)
     9c8:	863a                	mv	a2,a4
     9ca:	85be                	mv	a1,a5
     9cc:	00007517          	auipc	a0,0x7
     9d0:	6d450513          	addi	a0,a0,1748 # 80a0 <cv_init+0x31a>
     9d4:	00007097          	auipc	ra,0x7
     9d8:	ed4080e7          	jalr	-300(ra) # 78a8 <printf>
    exit(1);
     9dc:	4505                	li	a0,1
     9de:	00007097          	auipc	ra,0x7
     9e2:	992080e7          	jalr	-1646(ra) # 7370 <exit>
  }
  close(fd);
     9e6:	fe442783          	lw	a5,-28(s0)
     9ea:	853e                	mv	a0,a5
     9ec:	00007097          	auipc	ra,0x7
     9f0:	9ac080e7          	jalr	-1620(ra) # 7398 <close>
  unlink("rwsbrk");
     9f4:	00007517          	auipc	a0,0x7
     9f8:	68c50513          	addi	a0,a0,1676 # 8080 <cv_init+0x2fa>
     9fc:	00007097          	auipc	ra,0x7
     a00:	9c4080e7          	jalr	-1596(ra) # 73c0 <unlink>

  fd = open("README", O_RDONLY);
     a04:	4581                	li	a1,0
     a06:	00007517          	auipc	a0,0x7
     a0a:	45a50513          	addi	a0,a0,1114 # 7e60 <cv_init+0xda>
     a0e:	00007097          	auipc	ra,0x7
     a12:	9a2080e7          	jalr	-1630(ra) # 73b0 <open>
     a16:	87aa                	mv	a5,a0
     a18:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
     a1c:	fe442783          	lw	a5,-28(s0)
     a20:	2781                	sext.w	a5,a5
     a22:	0007df63          	bgez	a5,a40 <rwsbrk+0x158>
    printf("open(rwsbrk) failed\n");
     a26:	00007517          	auipc	a0,0x7
     a2a:	66250513          	addi	a0,a0,1634 # 8088 <cv_init+0x302>
     a2e:	00007097          	auipc	ra,0x7
     a32:	e7a080e7          	jalr	-390(ra) # 78a8 <printf>
    exit(1);
     a36:	4505                	li	a0,1
     a38:	00007097          	auipc	ra,0x7
     a3c:	938080e7          	jalr	-1736(ra) # 7370 <exit>
  }
  n = read(fd, (void*)(a+4096), 10);
     a40:	fe843703          	ld	a4,-24(s0)
     a44:	6785                	lui	a5,0x1
     a46:	97ba                	add	a5,a5,a4
     a48:	873e                	mv	a4,a5
     a4a:	fe442783          	lw	a5,-28(s0)
     a4e:	4629                	li	a2,10
     a50:	85ba                	mv	a1,a4
     a52:	853e                	mv	a0,a5
     a54:	00007097          	auipc	ra,0x7
     a58:	934080e7          	jalr	-1740(ra) # 7388 <read>
     a5c:	87aa                	mv	a5,a0
     a5e:	fef42023          	sw	a5,-32(s0)
  if(n >= 0){
     a62:	fe042783          	lw	a5,-32(s0)
     a66:	2781                	sext.w	a5,a5
     a68:	0207c763          	bltz	a5,a96 <rwsbrk+0x1ae>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
     a6c:	fe843703          	ld	a4,-24(s0)
     a70:	6785                	lui	a5,0x1
     a72:	97ba                	add	a5,a5,a4
     a74:	fe042703          	lw	a4,-32(s0)
     a78:	863a                	mv	a2,a4
     a7a:	85be                	mv	a1,a5
     a7c:	00007517          	auipc	a0,0x7
     a80:	65450513          	addi	a0,a0,1620 # 80d0 <cv_init+0x34a>
     a84:	00007097          	auipc	ra,0x7
     a88:	e24080e7          	jalr	-476(ra) # 78a8 <printf>
    exit(1);
     a8c:	4505                	li	a0,1
     a8e:	00007097          	auipc	ra,0x7
     a92:	8e2080e7          	jalr	-1822(ra) # 7370 <exit>
  }
  close(fd);
     a96:	fe442783          	lw	a5,-28(s0)
     a9a:	853e                	mv	a0,a5
     a9c:	00007097          	auipc	ra,0x7
     aa0:	8fc080e7          	jalr	-1796(ra) # 7398 <close>
  
  exit(0);
     aa4:	4501                	li	a0,0
     aa6:	00007097          	auipc	ra,0x7
     aaa:	8ca080e7          	jalr	-1846(ra) # 7370 <exit>

0000000000000aae <truncate1>:
}

// test O_TRUNC.
void
truncate1(char *s)
{
     aae:	715d                	addi	sp,sp,-80
     ab0:	e486                	sd	ra,72(sp)
     ab2:	e0a2                	sd	s0,64(sp)
     ab4:	0880                	addi	s0,sp,80
     ab6:	faa43c23          	sd	a0,-72(s0)
  char buf[32];
  
  unlink("truncfile");
     aba:	00007517          	auipc	a0,0x7
     abe:	63e50513          	addi	a0,a0,1598 # 80f8 <cv_init+0x372>
     ac2:	00007097          	auipc	ra,0x7
     ac6:	8fe080e7          	jalr	-1794(ra) # 73c0 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     aca:	60100593          	li	a1,1537
     ace:	00007517          	auipc	a0,0x7
     ad2:	62a50513          	addi	a0,a0,1578 # 80f8 <cv_init+0x372>
     ad6:	00007097          	auipc	ra,0x7
     ada:	8da080e7          	jalr	-1830(ra) # 73b0 <open>
     ade:	87aa                	mv	a5,a0
     ae0:	fef42623          	sw	a5,-20(s0)
  write(fd1, "abcd", 4);
     ae4:	fec42783          	lw	a5,-20(s0)
     ae8:	4611                	li	a2,4
     aea:	00007597          	auipc	a1,0x7
     aee:	61e58593          	addi	a1,a1,1566 # 8108 <cv_init+0x382>
     af2:	853e                	mv	a0,a5
     af4:	00007097          	auipc	ra,0x7
     af8:	89c080e7          	jalr	-1892(ra) # 7390 <write>
  close(fd1);
     afc:	fec42783          	lw	a5,-20(s0)
     b00:	853e                	mv	a0,a5
     b02:	00007097          	auipc	ra,0x7
     b06:	896080e7          	jalr	-1898(ra) # 7398 <close>

  int fd2 = open("truncfile", O_RDONLY);
     b0a:	4581                	li	a1,0
     b0c:	00007517          	auipc	a0,0x7
     b10:	5ec50513          	addi	a0,a0,1516 # 80f8 <cv_init+0x372>
     b14:	00007097          	auipc	ra,0x7
     b18:	89c080e7          	jalr	-1892(ra) # 73b0 <open>
     b1c:	87aa                	mv	a5,a0
     b1e:	fef42423          	sw	a5,-24(s0)
  int n = read(fd2, buf, sizeof(buf));
     b22:	fc040713          	addi	a4,s0,-64
     b26:	fe842783          	lw	a5,-24(s0)
     b2a:	02000613          	li	a2,32
     b2e:	85ba                	mv	a1,a4
     b30:	853e                	mv	a0,a5
     b32:	00007097          	auipc	ra,0x7
     b36:	856080e7          	jalr	-1962(ra) # 7388 <read>
     b3a:	87aa                	mv	a5,a0
     b3c:	fef42223          	sw	a5,-28(s0)
  if(n != 4){
     b40:	fe442783          	lw	a5,-28(s0)
     b44:	0007871b          	sext.w	a4,a5
     b48:	4791                	li	a5,4
     b4a:	02f70463          	beq	a4,a5,b72 <truncate1+0xc4>
    printf("%s: read %d bytes, wanted 4\n", s, n);
     b4e:	fe442783          	lw	a5,-28(s0)
     b52:	863e                	mv	a2,a5
     b54:	fb843583          	ld	a1,-72(s0)
     b58:	00007517          	auipc	a0,0x7
     b5c:	5b850513          	addi	a0,a0,1464 # 8110 <cv_init+0x38a>
     b60:	00007097          	auipc	ra,0x7
     b64:	d48080e7          	jalr	-696(ra) # 78a8 <printf>
    exit(1);
     b68:	4505                	li	a0,1
     b6a:	00007097          	auipc	ra,0x7
     b6e:	806080e7          	jalr	-2042(ra) # 7370 <exit>
  }

  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     b72:	40100593          	li	a1,1025
     b76:	00007517          	auipc	a0,0x7
     b7a:	58250513          	addi	a0,a0,1410 # 80f8 <cv_init+0x372>
     b7e:	00007097          	auipc	ra,0x7
     b82:	832080e7          	jalr	-1998(ra) # 73b0 <open>
     b86:	87aa                	mv	a5,a0
     b88:	fef42623          	sw	a5,-20(s0)

  int fd3 = open("truncfile", O_RDONLY);
     b8c:	4581                	li	a1,0
     b8e:	00007517          	auipc	a0,0x7
     b92:	56a50513          	addi	a0,a0,1386 # 80f8 <cv_init+0x372>
     b96:	00007097          	auipc	ra,0x7
     b9a:	81a080e7          	jalr	-2022(ra) # 73b0 <open>
     b9e:	87aa                	mv	a5,a0
     ba0:	fef42023          	sw	a5,-32(s0)
  n = read(fd3, buf, sizeof(buf));
     ba4:	fc040713          	addi	a4,s0,-64
     ba8:	fe042783          	lw	a5,-32(s0)
     bac:	02000613          	li	a2,32
     bb0:	85ba                	mv	a1,a4
     bb2:	853e                	mv	a0,a5
     bb4:	00006097          	auipc	ra,0x6
     bb8:	7d4080e7          	jalr	2004(ra) # 7388 <read>
     bbc:	87aa                	mv	a5,a0
     bbe:	fef42223          	sw	a5,-28(s0)
  if(n != 0){
     bc2:	fe442783          	lw	a5,-28(s0)
     bc6:	2781                	sext.w	a5,a5
     bc8:	cf95                	beqz	a5,c04 <truncate1+0x156>
    printf("aaa fd3=%d\n", fd3);
     bca:	fe042783          	lw	a5,-32(s0)
     bce:	85be                	mv	a1,a5
     bd0:	00007517          	auipc	a0,0x7
     bd4:	56050513          	addi	a0,a0,1376 # 8130 <cv_init+0x3aa>
     bd8:	00007097          	auipc	ra,0x7
     bdc:	cd0080e7          	jalr	-816(ra) # 78a8 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     be0:	fe442783          	lw	a5,-28(s0)
     be4:	863e                	mv	a2,a5
     be6:	fb843583          	ld	a1,-72(s0)
     bea:	00007517          	auipc	a0,0x7
     bee:	55650513          	addi	a0,a0,1366 # 8140 <cv_init+0x3ba>
     bf2:	00007097          	auipc	ra,0x7
     bf6:	cb6080e7          	jalr	-842(ra) # 78a8 <printf>
    exit(1);
     bfa:	4505                	li	a0,1
     bfc:	00006097          	auipc	ra,0x6
     c00:	774080e7          	jalr	1908(ra) # 7370 <exit>
  }

  n = read(fd2, buf, sizeof(buf));
     c04:	fc040713          	addi	a4,s0,-64
     c08:	fe842783          	lw	a5,-24(s0)
     c0c:	02000613          	li	a2,32
     c10:	85ba                	mv	a1,a4
     c12:	853e                	mv	a0,a5
     c14:	00006097          	auipc	ra,0x6
     c18:	774080e7          	jalr	1908(ra) # 7388 <read>
     c1c:	87aa                	mv	a5,a0
     c1e:	fef42223          	sw	a5,-28(s0)
  if(n != 0){
     c22:	fe442783          	lw	a5,-28(s0)
     c26:	2781                	sext.w	a5,a5
     c28:	cf95                	beqz	a5,c64 <truncate1+0x1b6>
    printf("bbb fd2=%d\n", fd2);
     c2a:	fe842783          	lw	a5,-24(s0)
     c2e:	85be                	mv	a1,a5
     c30:	00007517          	auipc	a0,0x7
     c34:	53050513          	addi	a0,a0,1328 # 8160 <cv_init+0x3da>
     c38:	00007097          	auipc	ra,0x7
     c3c:	c70080e7          	jalr	-912(ra) # 78a8 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     c40:	fe442783          	lw	a5,-28(s0)
     c44:	863e                	mv	a2,a5
     c46:	fb843583          	ld	a1,-72(s0)
     c4a:	00007517          	auipc	a0,0x7
     c4e:	4f650513          	addi	a0,a0,1270 # 8140 <cv_init+0x3ba>
     c52:	00007097          	auipc	ra,0x7
     c56:	c56080e7          	jalr	-938(ra) # 78a8 <printf>
    exit(1);
     c5a:	4505                	li	a0,1
     c5c:	00006097          	auipc	ra,0x6
     c60:	714080e7          	jalr	1812(ra) # 7370 <exit>
  }
  
  write(fd1, "abcdef", 6);
     c64:	fec42783          	lw	a5,-20(s0)
     c68:	4619                	li	a2,6
     c6a:	00007597          	auipc	a1,0x7
     c6e:	50658593          	addi	a1,a1,1286 # 8170 <cv_init+0x3ea>
     c72:	853e                	mv	a0,a5
     c74:	00006097          	auipc	ra,0x6
     c78:	71c080e7          	jalr	1820(ra) # 7390 <write>

  n = read(fd3, buf, sizeof(buf));
     c7c:	fc040713          	addi	a4,s0,-64
     c80:	fe042783          	lw	a5,-32(s0)
     c84:	02000613          	li	a2,32
     c88:	85ba                	mv	a1,a4
     c8a:	853e                	mv	a0,a5
     c8c:	00006097          	auipc	ra,0x6
     c90:	6fc080e7          	jalr	1788(ra) # 7388 <read>
     c94:	87aa                	mv	a5,a0
     c96:	fef42223          	sw	a5,-28(s0)
  if(n != 6){
     c9a:	fe442783          	lw	a5,-28(s0)
     c9e:	0007871b          	sext.w	a4,a5
     ca2:	4799                	li	a5,6
     ca4:	02f70463          	beq	a4,a5,ccc <truncate1+0x21e>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     ca8:	fe442783          	lw	a5,-28(s0)
     cac:	863e                	mv	a2,a5
     cae:	fb843583          	ld	a1,-72(s0)
     cb2:	00007517          	auipc	a0,0x7
     cb6:	4c650513          	addi	a0,a0,1222 # 8178 <cv_init+0x3f2>
     cba:	00007097          	auipc	ra,0x7
     cbe:	bee080e7          	jalr	-1042(ra) # 78a8 <printf>
    exit(1);
     cc2:	4505                	li	a0,1
     cc4:	00006097          	auipc	ra,0x6
     cc8:	6ac080e7          	jalr	1708(ra) # 7370 <exit>
  }

  n = read(fd2, buf, sizeof(buf));
     ccc:	fc040713          	addi	a4,s0,-64
     cd0:	fe842783          	lw	a5,-24(s0)
     cd4:	02000613          	li	a2,32
     cd8:	85ba                	mv	a1,a4
     cda:	853e                	mv	a0,a5
     cdc:	00006097          	auipc	ra,0x6
     ce0:	6ac080e7          	jalr	1708(ra) # 7388 <read>
     ce4:	87aa                	mv	a5,a0
     ce6:	fef42223          	sw	a5,-28(s0)
  if(n != 2){
     cea:	fe442783          	lw	a5,-28(s0)
     cee:	0007871b          	sext.w	a4,a5
     cf2:	4789                	li	a5,2
     cf4:	02f70463          	beq	a4,a5,d1c <truncate1+0x26e>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     cf8:	fe442783          	lw	a5,-28(s0)
     cfc:	863e                	mv	a2,a5
     cfe:	fb843583          	ld	a1,-72(s0)
     d02:	00007517          	auipc	a0,0x7
     d06:	49650513          	addi	a0,a0,1174 # 8198 <cv_init+0x412>
     d0a:	00007097          	auipc	ra,0x7
     d0e:	b9e080e7          	jalr	-1122(ra) # 78a8 <printf>
    exit(1);
     d12:	4505                	li	a0,1
     d14:	00006097          	auipc	ra,0x6
     d18:	65c080e7          	jalr	1628(ra) # 7370 <exit>
  }

  unlink("truncfile");
     d1c:	00007517          	auipc	a0,0x7
     d20:	3dc50513          	addi	a0,a0,988 # 80f8 <cv_init+0x372>
     d24:	00006097          	auipc	ra,0x6
     d28:	69c080e7          	jalr	1692(ra) # 73c0 <unlink>

  close(fd1);
     d2c:	fec42783          	lw	a5,-20(s0)
     d30:	853e                	mv	a0,a5
     d32:	00006097          	auipc	ra,0x6
     d36:	666080e7          	jalr	1638(ra) # 7398 <close>
  close(fd2);
     d3a:	fe842783          	lw	a5,-24(s0)
     d3e:	853e                	mv	a0,a5
     d40:	00006097          	auipc	ra,0x6
     d44:	658080e7          	jalr	1624(ra) # 7398 <close>
  close(fd3);
     d48:	fe042783          	lw	a5,-32(s0)
     d4c:	853e                	mv	a0,a5
     d4e:	00006097          	auipc	ra,0x6
     d52:	64a080e7          	jalr	1610(ra) # 7398 <close>
}
     d56:	0001                	nop
     d58:	60a6                	ld	ra,72(sp)
     d5a:	6406                	ld	s0,64(sp)
     d5c:	6161                	addi	sp,sp,80
     d5e:	8082                	ret

0000000000000d60 <truncate2>:
// this causes a write at an offset beyond the end of the file.
// such writes fail on xv6 (unlike POSIX) but at least
// they don't crash.
void
truncate2(char *s)
{
     d60:	7179                	addi	sp,sp,-48
     d62:	f406                	sd	ra,40(sp)
     d64:	f022                	sd	s0,32(sp)
     d66:	1800                	addi	s0,sp,48
     d68:	fca43c23          	sd	a0,-40(s0)
  unlink("truncfile");
     d6c:	00007517          	auipc	a0,0x7
     d70:	38c50513          	addi	a0,a0,908 # 80f8 <cv_init+0x372>
     d74:	00006097          	auipc	ra,0x6
     d78:	64c080e7          	jalr	1612(ra) # 73c0 <unlink>

  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     d7c:	60100593          	li	a1,1537
     d80:	00007517          	auipc	a0,0x7
     d84:	37850513          	addi	a0,a0,888 # 80f8 <cv_init+0x372>
     d88:	00006097          	auipc	ra,0x6
     d8c:	628080e7          	jalr	1576(ra) # 73b0 <open>
     d90:	87aa                	mv	a5,a0
     d92:	fef42623          	sw	a5,-20(s0)
  write(fd1, "abcd", 4);
     d96:	fec42783          	lw	a5,-20(s0)
     d9a:	4611                	li	a2,4
     d9c:	00007597          	auipc	a1,0x7
     da0:	36c58593          	addi	a1,a1,876 # 8108 <cv_init+0x382>
     da4:	853e                	mv	a0,a5
     da6:	00006097          	auipc	ra,0x6
     daa:	5ea080e7          	jalr	1514(ra) # 7390 <write>

  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     dae:	40100593          	li	a1,1025
     db2:	00007517          	auipc	a0,0x7
     db6:	34650513          	addi	a0,a0,838 # 80f8 <cv_init+0x372>
     dba:	00006097          	auipc	ra,0x6
     dbe:	5f6080e7          	jalr	1526(ra) # 73b0 <open>
     dc2:	87aa                	mv	a5,a0
     dc4:	fef42423          	sw	a5,-24(s0)

  int n = write(fd1, "x", 1);
     dc8:	fec42783          	lw	a5,-20(s0)
     dcc:	4605                	li	a2,1
     dce:	00007597          	auipc	a1,0x7
     dd2:	0e258593          	addi	a1,a1,226 # 7eb0 <cv_init+0x12a>
     dd6:	853e                	mv	a0,a5
     dd8:	00006097          	auipc	ra,0x6
     ddc:	5b8080e7          	jalr	1464(ra) # 7390 <write>
     de0:	87aa                	mv	a5,a0
     de2:	fef42223          	sw	a5,-28(s0)
  if(n != -1){
     de6:	fe442783          	lw	a5,-28(s0)
     dea:	0007871b          	sext.w	a4,a5
     dee:	57fd                	li	a5,-1
     df0:	02f70463          	beq	a4,a5,e18 <truncate2+0xb8>
    printf("%s: write returned %d, expected -1\n", s, n);
     df4:	fe442783          	lw	a5,-28(s0)
     df8:	863e                	mv	a2,a5
     dfa:	fd843583          	ld	a1,-40(s0)
     dfe:	00007517          	auipc	a0,0x7
     e02:	3ba50513          	addi	a0,a0,954 # 81b8 <cv_init+0x432>
     e06:	00007097          	auipc	ra,0x7
     e0a:	aa2080e7          	jalr	-1374(ra) # 78a8 <printf>
    exit(1);
     e0e:	4505                	li	a0,1
     e10:	00006097          	auipc	ra,0x6
     e14:	560080e7          	jalr	1376(ra) # 7370 <exit>
  }

  unlink("truncfile");
     e18:	00007517          	auipc	a0,0x7
     e1c:	2e050513          	addi	a0,a0,736 # 80f8 <cv_init+0x372>
     e20:	00006097          	auipc	ra,0x6
     e24:	5a0080e7          	jalr	1440(ra) # 73c0 <unlink>
  close(fd1);
     e28:	fec42783          	lw	a5,-20(s0)
     e2c:	853e                	mv	a0,a5
     e2e:	00006097          	auipc	ra,0x6
     e32:	56a080e7          	jalr	1386(ra) # 7398 <close>
  close(fd2);
     e36:	fe842783          	lw	a5,-24(s0)
     e3a:	853e                	mv	a0,a5
     e3c:	00006097          	auipc	ra,0x6
     e40:	55c080e7          	jalr	1372(ra) # 7398 <close>
}
     e44:	0001                	nop
     e46:	70a2                	ld	ra,40(sp)
     e48:	7402                	ld	s0,32(sp)
     e4a:	6145                	addi	sp,sp,48
     e4c:	8082                	ret

0000000000000e4e <truncate3>:

void
truncate3(char *s)
{
     e4e:	711d                	addi	sp,sp,-96
     e50:	ec86                	sd	ra,88(sp)
     e52:	e8a2                	sd	s0,80(sp)
     e54:	1080                	addi	s0,sp,96
     e56:	faa43423          	sd	a0,-88(s0)
  int pid, xstatus;

  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
     e5a:	60100593          	li	a1,1537
     e5e:	00007517          	auipc	a0,0x7
     e62:	29a50513          	addi	a0,a0,666 # 80f8 <cv_init+0x372>
     e66:	00006097          	auipc	ra,0x6
     e6a:	54a080e7          	jalr	1354(ra) # 73b0 <open>
     e6e:	87aa                	mv	a5,a0
     e70:	853e                	mv	a0,a5
     e72:	00006097          	auipc	ra,0x6
     e76:	526080e7          	jalr	1318(ra) # 7398 <close>
  
  pid = fork();
     e7a:	00006097          	auipc	ra,0x6
     e7e:	4ee080e7          	jalr	1262(ra) # 7368 <fork>
     e82:	87aa                	mv	a5,a0
     e84:	fef42223          	sw	a5,-28(s0)
  if(pid < 0){
     e88:	fe442783          	lw	a5,-28(s0)
     e8c:	2781                	sext.w	a5,a5
     e8e:	0207d163          	bgez	a5,eb0 <truncate3+0x62>
    printf("%s: fork failed\n", s);
     e92:	fa843583          	ld	a1,-88(s0)
     e96:	00007517          	auipc	a0,0x7
     e9a:	34a50513          	addi	a0,a0,842 # 81e0 <cv_init+0x45a>
     e9e:	00007097          	auipc	ra,0x7
     ea2:	a0a080e7          	jalr	-1526(ra) # 78a8 <printf>
    exit(1);
     ea6:	4505                	li	a0,1
     ea8:	00006097          	auipc	ra,0x6
     eac:	4c8080e7          	jalr	1224(ra) # 7370 <exit>
  }

  if(pid == 0){
     eb0:	fe442783          	lw	a5,-28(s0)
     eb4:	2781                	sext.w	a5,a5
     eb6:	10079563          	bnez	a5,fc0 <truncate3+0x172>
    for(int i = 0; i < 100; i++){
     eba:	fe042623          	sw	zero,-20(s0)
     ebe:	a0e5                	j	fa6 <truncate3+0x158>
      char buf[32];
      int fd = open("truncfile", O_WRONLY);
     ec0:	4585                	li	a1,1
     ec2:	00007517          	auipc	a0,0x7
     ec6:	23650513          	addi	a0,a0,566 # 80f8 <cv_init+0x372>
     eca:	00006097          	auipc	ra,0x6
     ece:	4e6080e7          	jalr	1254(ra) # 73b0 <open>
     ed2:	87aa                	mv	a5,a0
     ed4:	fcf42c23          	sw	a5,-40(s0)
      if(fd < 0){
     ed8:	fd842783          	lw	a5,-40(s0)
     edc:	2781                	sext.w	a5,a5
     ede:	0207d163          	bgez	a5,f00 <truncate3+0xb2>
        printf("%s: open failed\n", s);
     ee2:	fa843583          	ld	a1,-88(s0)
     ee6:	00007517          	auipc	a0,0x7
     eea:	31250513          	addi	a0,a0,786 # 81f8 <cv_init+0x472>
     eee:	00007097          	auipc	ra,0x7
     ef2:	9ba080e7          	jalr	-1606(ra) # 78a8 <printf>
        exit(1);
     ef6:	4505                	li	a0,1
     ef8:	00006097          	auipc	ra,0x6
     efc:	478080e7          	jalr	1144(ra) # 7370 <exit>
      }
      int n = write(fd, "1234567890", 10);
     f00:	fd842783          	lw	a5,-40(s0)
     f04:	4629                	li	a2,10
     f06:	00007597          	auipc	a1,0x7
     f0a:	30a58593          	addi	a1,a1,778 # 8210 <cv_init+0x48a>
     f0e:	853e                	mv	a0,a5
     f10:	00006097          	auipc	ra,0x6
     f14:	480080e7          	jalr	1152(ra) # 7390 <write>
     f18:	87aa                	mv	a5,a0
     f1a:	fcf42a23          	sw	a5,-44(s0)
      if(n != 10){
     f1e:	fd442783          	lw	a5,-44(s0)
     f22:	0007871b          	sext.w	a4,a5
     f26:	47a9                	li	a5,10
     f28:	02f70463          	beq	a4,a5,f50 <truncate3+0x102>
        printf("%s: write got %d, expected 10\n", s, n);
     f2c:	fd442783          	lw	a5,-44(s0)
     f30:	863e                	mv	a2,a5
     f32:	fa843583          	ld	a1,-88(s0)
     f36:	00007517          	auipc	a0,0x7
     f3a:	2ea50513          	addi	a0,a0,746 # 8220 <cv_init+0x49a>
     f3e:	00007097          	auipc	ra,0x7
     f42:	96a080e7          	jalr	-1686(ra) # 78a8 <printf>
        exit(1);
     f46:	4505                	li	a0,1
     f48:	00006097          	auipc	ra,0x6
     f4c:	428080e7          	jalr	1064(ra) # 7370 <exit>
      }
      close(fd);
     f50:	fd842783          	lw	a5,-40(s0)
     f54:	853e                	mv	a0,a5
     f56:	00006097          	auipc	ra,0x6
     f5a:	442080e7          	jalr	1090(ra) # 7398 <close>
      fd = open("truncfile", O_RDONLY);
     f5e:	4581                	li	a1,0
     f60:	00007517          	auipc	a0,0x7
     f64:	19850513          	addi	a0,a0,408 # 80f8 <cv_init+0x372>
     f68:	00006097          	auipc	ra,0x6
     f6c:	448080e7          	jalr	1096(ra) # 73b0 <open>
     f70:	87aa                	mv	a5,a0
     f72:	fcf42c23          	sw	a5,-40(s0)
      read(fd, buf, sizeof(buf));
     f76:	fb040713          	addi	a4,s0,-80
     f7a:	fd842783          	lw	a5,-40(s0)
     f7e:	02000613          	li	a2,32
     f82:	85ba                	mv	a1,a4
     f84:	853e                	mv	a0,a5
     f86:	00006097          	auipc	ra,0x6
     f8a:	402080e7          	jalr	1026(ra) # 7388 <read>
      close(fd);
     f8e:	fd842783          	lw	a5,-40(s0)
     f92:	853e                	mv	a0,a5
     f94:	00006097          	auipc	ra,0x6
     f98:	404080e7          	jalr	1028(ra) # 7398 <close>
    for(int i = 0; i < 100; i++){
     f9c:	fec42783          	lw	a5,-20(s0)
     fa0:	2785                	addiw	a5,a5,1
     fa2:	fef42623          	sw	a5,-20(s0)
     fa6:	fec42783          	lw	a5,-20(s0)
     faa:	0007871b          	sext.w	a4,a5
     fae:	06300793          	li	a5,99
     fb2:	f0e7d7e3          	bge	a5,a4,ec0 <truncate3+0x72>
    }
    exit(0);
     fb6:	4501                	li	a0,0
     fb8:	00006097          	auipc	ra,0x6
     fbc:	3b8080e7          	jalr	952(ra) # 7370 <exit>
  }

  for(int i = 0; i < 150; i++){
     fc0:	fe042423          	sw	zero,-24(s0)
     fc4:	a075                	j	1070 <truncate3+0x222>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     fc6:	60100593          	li	a1,1537
     fca:	00007517          	auipc	a0,0x7
     fce:	12e50513          	addi	a0,a0,302 # 80f8 <cv_init+0x372>
     fd2:	00006097          	auipc	ra,0x6
     fd6:	3de080e7          	jalr	990(ra) # 73b0 <open>
     fda:	87aa                	mv	a5,a0
     fdc:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
     fe0:	fe042783          	lw	a5,-32(s0)
     fe4:	2781                	sext.w	a5,a5
     fe6:	0207d163          	bgez	a5,1008 <truncate3+0x1ba>
      printf("%s: open failed\n", s);
     fea:	fa843583          	ld	a1,-88(s0)
     fee:	00007517          	auipc	a0,0x7
     ff2:	20a50513          	addi	a0,a0,522 # 81f8 <cv_init+0x472>
     ff6:	00007097          	auipc	ra,0x7
     ffa:	8b2080e7          	jalr	-1870(ra) # 78a8 <printf>
      exit(1);
     ffe:	4505                	li	a0,1
    1000:	00006097          	auipc	ra,0x6
    1004:	370080e7          	jalr	880(ra) # 7370 <exit>
    }
    int n = write(fd, "xxx", 3);
    1008:	fe042783          	lw	a5,-32(s0)
    100c:	460d                	li	a2,3
    100e:	00007597          	auipc	a1,0x7
    1012:	23258593          	addi	a1,a1,562 # 8240 <cv_init+0x4ba>
    1016:	853e                	mv	a0,a5
    1018:	00006097          	auipc	ra,0x6
    101c:	378080e7          	jalr	888(ra) # 7390 <write>
    1020:	87aa                	mv	a5,a0
    1022:	fcf42e23          	sw	a5,-36(s0)
    if(n != 3){
    1026:	fdc42783          	lw	a5,-36(s0)
    102a:	0007871b          	sext.w	a4,a5
    102e:	478d                	li	a5,3
    1030:	02f70463          	beq	a4,a5,1058 <truncate3+0x20a>
      printf("%s: write got %d, expected 3\n", s, n);
    1034:	fdc42783          	lw	a5,-36(s0)
    1038:	863e                	mv	a2,a5
    103a:	fa843583          	ld	a1,-88(s0)
    103e:	00007517          	auipc	a0,0x7
    1042:	20a50513          	addi	a0,a0,522 # 8248 <cv_init+0x4c2>
    1046:	00007097          	auipc	ra,0x7
    104a:	862080e7          	jalr	-1950(ra) # 78a8 <printf>
      exit(1);
    104e:	4505                	li	a0,1
    1050:	00006097          	auipc	ra,0x6
    1054:	320080e7          	jalr	800(ra) # 7370 <exit>
    }
    close(fd);
    1058:	fe042783          	lw	a5,-32(s0)
    105c:	853e                	mv	a0,a5
    105e:	00006097          	auipc	ra,0x6
    1062:	33a080e7          	jalr	826(ra) # 7398 <close>
  for(int i = 0; i < 150; i++){
    1066:	fe842783          	lw	a5,-24(s0)
    106a:	2785                	addiw	a5,a5,1
    106c:	fef42423          	sw	a5,-24(s0)
    1070:	fe842783          	lw	a5,-24(s0)
    1074:	0007871b          	sext.w	a4,a5
    1078:	09500793          	li	a5,149
    107c:	f4e7d5e3          	bge	a5,a4,fc6 <truncate3+0x178>
  }

  wait(&xstatus);
    1080:	fd040793          	addi	a5,s0,-48
    1084:	853e                	mv	a0,a5
    1086:	00006097          	auipc	ra,0x6
    108a:	2f2080e7          	jalr	754(ra) # 7378 <wait>
  unlink("truncfile");
    108e:	00007517          	auipc	a0,0x7
    1092:	06a50513          	addi	a0,a0,106 # 80f8 <cv_init+0x372>
    1096:	00006097          	auipc	ra,0x6
    109a:	32a080e7          	jalr	810(ra) # 73c0 <unlink>
  exit(xstatus);
    109e:	fd042783          	lw	a5,-48(s0)
    10a2:	853e                	mv	a0,a5
    10a4:	00006097          	auipc	ra,0x6
    10a8:	2cc080e7          	jalr	716(ra) # 7370 <exit>

00000000000010ac <iputtest>:
  

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(char *s)
{
    10ac:	1101                	addi	sp,sp,-32
    10ae:	ec06                	sd	ra,24(sp)
    10b0:	e822                	sd	s0,16(sp)
    10b2:	1000                	addi	s0,sp,32
    10b4:	fea43423          	sd	a0,-24(s0)
  if(mkdir("iputdir") < 0){
    10b8:	00007517          	auipc	a0,0x7
    10bc:	1b050513          	addi	a0,a0,432 # 8268 <cv_init+0x4e2>
    10c0:	00006097          	auipc	ra,0x6
    10c4:	318080e7          	jalr	792(ra) # 73d8 <mkdir>
    10c8:	87aa                	mv	a5,a0
    10ca:	0207d163          	bgez	a5,10ec <iputtest+0x40>
    printf("%s: mkdir failed\n", s);
    10ce:	fe843583          	ld	a1,-24(s0)
    10d2:	00007517          	auipc	a0,0x7
    10d6:	19e50513          	addi	a0,a0,414 # 8270 <cv_init+0x4ea>
    10da:	00006097          	auipc	ra,0x6
    10de:	7ce080e7          	jalr	1998(ra) # 78a8 <printf>
    exit(1);
    10e2:	4505                	li	a0,1
    10e4:	00006097          	auipc	ra,0x6
    10e8:	28c080e7          	jalr	652(ra) # 7370 <exit>
  }
  if(chdir("iputdir") < 0){
    10ec:	00007517          	auipc	a0,0x7
    10f0:	17c50513          	addi	a0,a0,380 # 8268 <cv_init+0x4e2>
    10f4:	00006097          	auipc	ra,0x6
    10f8:	2ec080e7          	jalr	748(ra) # 73e0 <chdir>
    10fc:	87aa                	mv	a5,a0
    10fe:	0207d163          	bgez	a5,1120 <iputtest+0x74>
    printf("%s: chdir iputdir failed\n", s);
    1102:	fe843583          	ld	a1,-24(s0)
    1106:	00007517          	auipc	a0,0x7
    110a:	18250513          	addi	a0,a0,386 # 8288 <cv_init+0x502>
    110e:	00006097          	auipc	ra,0x6
    1112:	79a080e7          	jalr	1946(ra) # 78a8 <printf>
    exit(1);
    1116:	4505                	li	a0,1
    1118:	00006097          	auipc	ra,0x6
    111c:	258080e7          	jalr	600(ra) # 7370 <exit>
  }
  if(unlink("../iputdir") < 0){
    1120:	00007517          	auipc	a0,0x7
    1124:	18850513          	addi	a0,a0,392 # 82a8 <cv_init+0x522>
    1128:	00006097          	auipc	ra,0x6
    112c:	298080e7          	jalr	664(ra) # 73c0 <unlink>
    1130:	87aa                	mv	a5,a0
    1132:	0207d163          	bgez	a5,1154 <iputtest+0xa8>
    printf("%s: unlink ../iputdir failed\n", s);
    1136:	fe843583          	ld	a1,-24(s0)
    113a:	00007517          	auipc	a0,0x7
    113e:	17e50513          	addi	a0,a0,382 # 82b8 <cv_init+0x532>
    1142:	00006097          	auipc	ra,0x6
    1146:	766080e7          	jalr	1894(ra) # 78a8 <printf>
    exit(1);
    114a:	4505                	li	a0,1
    114c:	00006097          	auipc	ra,0x6
    1150:	224080e7          	jalr	548(ra) # 7370 <exit>
  }
  if(chdir("/") < 0){
    1154:	00007517          	auipc	a0,0x7
    1158:	18450513          	addi	a0,a0,388 # 82d8 <cv_init+0x552>
    115c:	00006097          	auipc	ra,0x6
    1160:	284080e7          	jalr	644(ra) # 73e0 <chdir>
    1164:	87aa                	mv	a5,a0
    1166:	0207d163          	bgez	a5,1188 <iputtest+0xdc>
    printf("%s: chdir / failed\n", s);
    116a:	fe843583          	ld	a1,-24(s0)
    116e:	00007517          	auipc	a0,0x7
    1172:	17250513          	addi	a0,a0,370 # 82e0 <cv_init+0x55a>
    1176:	00006097          	auipc	ra,0x6
    117a:	732080e7          	jalr	1842(ra) # 78a8 <printf>
    exit(1);
    117e:	4505                	li	a0,1
    1180:	00006097          	auipc	ra,0x6
    1184:	1f0080e7          	jalr	496(ra) # 7370 <exit>
  }
}
    1188:	0001                	nop
    118a:	60e2                	ld	ra,24(sp)
    118c:	6442                	ld	s0,16(sp)
    118e:	6105                	addi	sp,sp,32
    1190:	8082                	ret

0000000000001192 <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(char *s)
{
    1192:	7179                	addi	sp,sp,-48
    1194:	f406                	sd	ra,40(sp)
    1196:	f022                	sd	s0,32(sp)
    1198:	1800                	addi	s0,sp,48
    119a:	fca43c23          	sd	a0,-40(s0)
  int pid, xstatus;

  pid = fork();
    119e:	00006097          	auipc	ra,0x6
    11a2:	1ca080e7          	jalr	458(ra) # 7368 <fork>
    11a6:	87aa                	mv	a5,a0
    11a8:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    11ac:	fec42783          	lw	a5,-20(s0)
    11b0:	2781                	sext.w	a5,a5
    11b2:	0207d163          	bgez	a5,11d4 <exitiputtest+0x42>
    printf("%s: fork failed\n", s);
    11b6:	fd843583          	ld	a1,-40(s0)
    11ba:	00007517          	auipc	a0,0x7
    11be:	02650513          	addi	a0,a0,38 # 81e0 <cv_init+0x45a>
    11c2:	00006097          	auipc	ra,0x6
    11c6:	6e6080e7          	jalr	1766(ra) # 78a8 <printf>
    exit(1);
    11ca:	4505                	li	a0,1
    11cc:	00006097          	auipc	ra,0x6
    11d0:	1a4080e7          	jalr	420(ra) # 7370 <exit>
  }
  if(pid == 0){
    11d4:	fec42783          	lw	a5,-20(s0)
    11d8:	2781                	sext.w	a5,a5
    11da:	e7c5                	bnez	a5,1282 <exitiputtest+0xf0>
    if(mkdir("iputdir") < 0){
    11dc:	00007517          	auipc	a0,0x7
    11e0:	08c50513          	addi	a0,a0,140 # 8268 <cv_init+0x4e2>
    11e4:	00006097          	auipc	ra,0x6
    11e8:	1f4080e7          	jalr	500(ra) # 73d8 <mkdir>
    11ec:	87aa                	mv	a5,a0
    11ee:	0207d163          	bgez	a5,1210 <exitiputtest+0x7e>
      printf("%s: mkdir failed\n", s);
    11f2:	fd843583          	ld	a1,-40(s0)
    11f6:	00007517          	auipc	a0,0x7
    11fa:	07a50513          	addi	a0,a0,122 # 8270 <cv_init+0x4ea>
    11fe:	00006097          	auipc	ra,0x6
    1202:	6aa080e7          	jalr	1706(ra) # 78a8 <printf>
      exit(1);
    1206:	4505                	li	a0,1
    1208:	00006097          	auipc	ra,0x6
    120c:	168080e7          	jalr	360(ra) # 7370 <exit>
    }
    if(chdir("iputdir") < 0){
    1210:	00007517          	auipc	a0,0x7
    1214:	05850513          	addi	a0,a0,88 # 8268 <cv_init+0x4e2>
    1218:	00006097          	auipc	ra,0x6
    121c:	1c8080e7          	jalr	456(ra) # 73e0 <chdir>
    1220:	87aa                	mv	a5,a0
    1222:	0207d163          	bgez	a5,1244 <exitiputtest+0xb2>
      printf("%s: child chdir failed\n", s);
    1226:	fd843583          	ld	a1,-40(s0)
    122a:	00007517          	auipc	a0,0x7
    122e:	0ce50513          	addi	a0,a0,206 # 82f8 <cv_init+0x572>
    1232:	00006097          	auipc	ra,0x6
    1236:	676080e7          	jalr	1654(ra) # 78a8 <printf>
      exit(1);
    123a:	4505                	li	a0,1
    123c:	00006097          	auipc	ra,0x6
    1240:	134080e7          	jalr	308(ra) # 7370 <exit>
    }
    if(unlink("../iputdir") < 0){
    1244:	00007517          	auipc	a0,0x7
    1248:	06450513          	addi	a0,a0,100 # 82a8 <cv_init+0x522>
    124c:	00006097          	auipc	ra,0x6
    1250:	174080e7          	jalr	372(ra) # 73c0 <unlink>
    1254:	87aa                	mv	a5,a0
    1256:	0207d163          	bgez	a5,1278 <exitiputtest+0xe6>
      printf("%s: unlink ../iputdir failed\n", s);
    125a:	fd843583          	ld	a1,-40(s0)
    125e:	00007517          	auipc	a0,0x7
    1262:	05a50513          	addi	a0,a0,90 # 82b8 <cv_init+0x532>
    1266:	00006097          	auipc	ra,0x6
    126a:	642080e7          	jalr	1602(ra) # 78a8 <printf>
      exit(1);
    126e:	4505                	li	a0,1
    1270:	00006097          	auipc	ra,0x6
    1274:	100080e7          	jalr	256(ra) # 7370 <exit>
    }
    exit(0);
    1278:	4501                	li	a0,0
    127a:	00006097          	auipc	ra,0x6
    127e:	0f6080e7          	jalr	246(ra) # 7370 <exit>
  }
  wait(&xstatus);
    1282:	fe840793          	addi	a5,s0,-24
    1286:	853e                	mv	a0,a5
    1288:	00006097          	auipc	ra,0x6
    128c:	0f0080e7          	jalr	240(ra) # 7378 <wait>
  exit(xstatus);
    1290:	fe842783          	lw	a5,-24(s0)
    1294:	853e                	mv	a0,a5
    1296:	00006097          	auipc	ra,0x6
    129a:	0da080e7          	jalr	218(ra) # 7370 <exit>

000000000000129e <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(char *s)
{
    129e:	7179                	addi	sp,sp,-48
    12a0:	f406                	sd	ra,40(sp)
    12a2:	f022                	sd	s0,32(sp)
    12a4:	1800                	addi	s0,sp,48
    12a6:	fca43c23          	sd	a0,-40(s0)
  int pid, xstatus;

  if(mkdir("oidir") < 0){
    12aa:	00007517          	auipc	a0,0x7
    12ae:	06650513          	addi	a0,a0,102 # 8310 <cv_init+0x58a>
    12b2:	00006097          	auipc	ra,0x6
    12b6:	126080e7          	jalr	294(ra) # 73d8 <mkdir>
    12ba:	87aa                	mv	a5,a0
    12bc:	0207d163          	bgez	a5,12de <openiputtest+0x40>
    printf("%s: mkdir oidir failed\n", s);
    12c0:	fd843583          	ld	a1,-40(s0)
    12c4:	00007517          	auipc	a0,0x7
    12c8:	05450513          	addi	a0,a0,84 # 8318 <cv_init+0x592>
    12cc:	00006097          	auipc	ra,0x6
    12d0:	5dc080e7          	jalr	1500(ra) # 78a8 <printf>
    exit(1);
    12d4:	4505                	li	a0,1
    12d6:	00006097          	auipc	ra,0x6
    12da:	09a080e7          	jalr	154(ra) # 7370 <exit>
  }
  pid = fork();
    12de:	00006097          	auipc	ra,0x6
    12e2:	08a080e7          	jalr	138(ra) # 7368 <fork>
    12e6:	87aa                	mv	a5,a0
    12e8:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    12ec:	fec42783          	lw	a5,-20(s0)
    12f0:	2781                	sext.w	a5,a5
    12f2:	0207d163          	bgez	a5,1314 <openiputtest+0x76>
    printf("%s: fork failed\n", s);
    12f6:	fd843583          	ld	a1,-40(s0)
    12fa:	00007517          	auipc	a0,0x7
    12fe:	ee650513          	addi	a0,a0,-282 # 81e0 <cv_init+0x45a>
    1302:	00006097          	auipc	ra,0x6
    1306:	5a6080e7          	jalr	1446(ra) # 78a8 <printf>
    exit(1);
    130a:	4505                	li	a0,1
    130c:	00006097          	auipc	ra,0x6
    1310:	064080e7          	jalr	100(ra) # 7370 <exit>
  }
  if(pid == 0){
    1314:	fec42783          	lw	a5,-20(s0)
    1318:	2781                	sext.w	a5,a5
    131a:	e7b1                	bnez	a5,1366 <openiputtest+0xc8>
    int fd = open("oidir", O_RDWR);
    131c:	4589                	li	a1,2
    131e:	00007517          	auipc	a0,0x7
    1322:	ff250513          	addi	a0,a0,-14 # 8310 <cv_init+0x58a>
    1326:	00006097          	auipc	ra,0x6
    132a:	08a080e7          	jalr	138(ra) # 73b0 <open>
    132e:	87aa                	mv	a5,a0
    1330:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0){
    1334:	fe842783          	lw	a5,-24(s0)
    1338:	2781                	sext.w	a5,a5
    133a:	0207c163          	bltz	a5,135c <openiputtest+0xbe>
      printf("%s: open directory for write succeeded\n", s);
    133e:	fd843583          	ld	a1,-40(s0)
    1342:	00007517          	auipc	a0,0x7
    1346:	fee50513          	addi	a0,a0,-18 # 8330 <cv_init+0x5aa>
    134a:	00006097          	auipc	ra,0x6
    134e:	55e080e7          	jalr	1374(ra) # 78a8 <printf>
      exit(1);
    1352:	4505                	li	a0,1
    1354:	00006097          	auipc	ra,0x6
    1358:	01c080e7          	jalr	28(ra) # 7370 <exit>
    }
    exit(0);
    135c:	4501                	li	a0,0
    135e:	00006097          	auipc	ra,0x6
    1362:	012080e7          	jalr	18(ra) # 7370 <exit>
  }
  sleep(1);
    1366:	4505                	li	a0,1
    1368:	00006097          	auipc	ra,0x6
    136c:	098080e7          	jalr	152(ra) # 7400 <sleep>
  if(unlink("oidir") != 0){
    1370:	00007517          	auipc	a0,0x7
    1374:	fa050513          	addi	a0,a0,-96 # 8310 <cv_init+0x58a>
    1378:	00006097          	auipc	ra,0x6
    137c:	048080e7          	jalr	72(ra) # 73c0 <unlink>
    1380:	87aa                	mv	a5,a0
    1382:	c385                	beqz	a5,13a2 <openiputtest+0x104>
    printf("%s: unlink failed\n", s);
    1384:	fd843583          	ld	a1,-40(s0)
    1388:	00007517          	auipc	a0,0x7
    138c:	fd050513          	addi	a0,a0,-48 # 8358 <cv_init+0x5d2>
    1390:	00006097          	auipc	ra,0x6
    1394:	518080e7          	jalr	1304(ra) # 78a8 <printf>
    exit(1);
    1398:	4505                	li	a0,1
    139a:	00006097          	auipc	ra,0x6
    139e:	fd6080e7          	jalr	-42(ra) # 7370 <exit>
  }
  wait(&xstatus);
    13a2:	fe440793          	addi	a5,s0,-28
    13a6:	853e                	mv	a0,a5
    13a8:	00006097          	auipc	ra,0x6
    13ac:	fd0080e7          	jalr	-48(ra) # 7378 <wait>
  exit(xstatus);
    13b0:	fe442783          	lw	a5,-28(s0)
    13b4:	853e                	mv	a0,a5
    13b6:	00006097          	auipc	ra,0x6
    13ba:	fba080e7          	jalr	-70(ra) # 7370 <exit>

00000000000013be <opentest>:

// simple file system tests

void
opentest(char *s)
{
    13be:	7179                	addi	sp,sp,-48
    13c0:	f406                	sd	ra,40(sp)
    13c2:	f022                	sd	s0,32(sp)
    13c4:	1800                	addi	s0,sp,48
    13c6:	fca43c23          	sd	a0,-40(s0)
  int fd;

  fd = open("echo", 0);
    13ca:	4581                	li	a1,0
    13cc:	00007517          	auipc	a0,0x7
    13d0:	bf450513          	addi	a0,a0,-1036 # 7fc0 <cv_init+0x23a>
    13d4:	00006097          	auipc	ra,0x6
    13d8:	fdc080e7          	jalr	-36(ra) # 73b0 <open>
    13dc:	87aa                	mv	a5,a0
    13de:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    13e2:	fec42783          	lw	a5,-20(s0)
    13e6:	2781                	sext.w	a5,a5
    13e8:	0207d163          	bgez	a5,140a <opentest+0x4c>
    printf("%s: open echo failed!\n", s);
    13ec:	fd843583          	ld	a1,-40(s0)
    13f0:	00007517          	auipc	a0,0x7
    13f4:	f8050513          	addi	a0,a0,-128 # 8370 <cv_init+0x5ea>
    13f8:	00006097          	auipc	ra,0x6
    13fc:	4b0080e7          	jalr	1200(ra) # 78a8 <printf>
    exit(1);
    1400:	4505                	li	a0,1
    1402:	00006097          	auipc	ra,0x6
    1406:	f6e080e7          	jalr	-146(ra) # 7370 <exit>
  }
  close(fd);
    140a:	fec42783          	lw	a5,-20(s0)
    140e:	853e                	mv	a0,a5
    1410:	00006097          	auipc	ra,0x6
    1414:	f88080e7          	jalr	-120(ra) # 7398 <close>
  fd = open("doesnotexist", 0);
    1418:	4581                	li	a1,0
    141a:	00007517          	auipc	a0,0x7
    141e:	f6e50513          	addi	a0,a0,-146 # 8388 <cv_init+0x602>
    1422:	00006097          	auipc	ra,0x6
    1426:	f8e080e7          	jalr	-114(ra) # 73b0 <open>
    142a:	87aa                	mv	a5,a0
    142c:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    1430:	fec42783          	lw	a5,-20(s0)
    1434:	2781                	sext.w	a5,a5
    1436:	0207c163          	bltz	a5,1458 <opentest+0x9a>
    printf("%s: open doesnotexist succeeded!\n", s);
    143a:	fd843583          	ld	a1,-40(s0)
    143e:	00007517          	auipc	a0,0x7
    1442:	f5a50513          	addi	a0,a0,-166 # 8398 <cv_init+0x612>
    1446:	00006097          	auipc	ra,0x6
    144a:	462080e7          	jalr	1122(ra) # 78a8 <printf>
    exit(1);
    144e:	4505                	li	a0,1
    1450:	00006097          	auipc	ra,0x6
    1454:	f20080e7          	jalr	-224(ra) # 7370 <exit>
  }
}
    1458:	0001                	nop
    145a:	70a2                	ld	ra,40(sp)
    145c:	7402                	ld	s0,32(sp)
    145e:	6145                	addi	sp,sp,48
    1460:	8082                	ret

0000000000001462 <writetest>:

void
writetest(char *s)
{
    1462:	7179                	addi	sp,sp,-48
    1464:	f406                	sd	ra,40(sp)
    1466:	f022                	sd	s0,32(sp)
    1468:	1800                	addi	s0,sp,48
    146a:	fca43c23          	sd	a0,-40(s0)
  int fd;
  int i;
  enum { N=100, SZ=10 };
  
  fd = open("small", O_CREATE|O_RDWR);
    146e:	20200593          	li	a1,514
    1472:	00007517          	auipc	a0,0x7
    1476:	f4e50513          	addi	a0,a0,-178 # 83c0 <cv_init+0x63a>
    147a:	00006097          	auipc	ra,0x6
    147e:	f36080e7          	jalr	-202(ra) # 73b0 <open>
    1482:	87aa                	mv	a5,a0
    1484:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    1488:	fe842783          	lw	a5,-24(s0)
    148c:	2781                	sext.w	a5,a5
    148e:	0207d163          	bgez	a5,14b0 <writetest+0x4e>
    printf("%s: error: creat small failed!\n", s);
    1492:	fd843583          	ld	a1,-40(s0)
    1496:	00007517          	auipc	a0,0x7
    149a:	f3250513          	addi	a0,a0,-206 # 83c8 <cv_init+0x642>
    149e:	00006097          	auipc	ra,0x6
    14a2:	40a080e7          	jalr	1034(ra) # 78a8 <printf>
    exit(1);
    14a6:	4505                	li	a0,1
    14a8:	00006097          	auipc	ra,0x6
    14ac:	ec8080e7          	jalr	-312(ra) # 7370 <exit>
  }
  for(i = 0; i < N; i++){
    14b0:	fe042623          	sw	zero,-20(s0)
    14b4:	a861                	j	154c <writetest+0xea>
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
    14b6:	fe842783          	lw	a5,-24(s0)
    14ba:	4629                	li	a2,10
    14bc:	00007597          	auipc	a1,0x7
    14c0:	f2c58593          	addi	a1,a1,-212 # 83e8 <cv_init+0x662>
    14c4:	853e                	mv	a0,a5
    14c6:	00006097          	auipc	ra,0x6
    14ca:	eca080e7          	jalr	-310(ra) # 7390 <write>
    14ce:	87aa                	mv	a5,a0
    14d0:	873e                	mv	a4,a5
    14d2:	47a9                	li	a5,10
    14d4:	02f70463          	beq	a4,a5,14fc <writetest+0x9a>
      printf("%s: error: write aa %d new file failed\n", s, i);
    14d8:	fec42783          	lw	a5,-20(s0)
    14dc:	863e                	mv	a2,a5
    14de:	fd843583          	ld	a1,-40(s0)
    14e2:	00007517          	auipc	a0,0x7
    14e6:	f1650513          	addi	a0,a0,-234 # 83f8 <cv_init+0x672>
    14ea:	00006097          	auipc	ra,0x6
    14ee:	3be080e7          	jalr	958(ra) # 78a8 <printf>
      exit(1);
    14f2:	4505                	li	a0,1
    14f4:	00006097          	auipc	ra,0x6
    14f8:	e7c080e7          	jalr	-388(ra) # 7370 <exit>
    }
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
    14fc:	fe842783          	lw	a5,-24(s0)
    1500:	4629                	li	a2,10
    1502:	00007597          	auipc	a1,0x7
    1506:	f1e58593          	addi	a1,a1,-226 # 8420 <cv_init+0x69a>
    150a:	853e                	mv	a0,a5
    150c:	00006097          	auipc	ra,0x6
    1510:	e84080e7          	jalr	-380(ra) # 7390 <write>
    1514:	87aa                	mv	a5,a0
    1516:	873e                	mv	a4,a5
    1518:	47a9                	li	a5,10
    151a:	02f70463          	beq	a4,a5,1542 <writetest+0xe0>
      printf("%s: error: write bb %d new file failed\n", s, i);
    151e:	fec42783          	lw	a5,-20(s0)
    1522:	863e                	mv	a2,a5
    1524:	fd843583          	ld	a1,-40(s0)
    1528:	00007517          	auipc	a0,0x7
    152c:	f0850513          	addi	a0,a0,-248 # 8430 <cv_init+0x6aa>
    1530:	00006097          	auipc	ra,0x6
    1534:	378080e7          	jalr	888(ra) # 78a8 <printf>
      exit(1);
    1538:	4505                	li	a0,1
    153a:	00006097          	auipc	ra,0x6
    153e:	e36080e7          	jalr	-458(ra) # 7370 <exit>
  for(i = 0; i < N; i++){
    1542:	fec42783          	lw	a5,-20(s0)
    1546:	2785                	addiw	a5,a5,1
    1548:	fef42623          	sw	a5,-20(s0)
    154c:	fec42783          	lw	a5,-20(s0)
    1550:	0007871b          	sext.w	a4,a5
    1554:	06300793          	li	a5,99
    1558:	f4e7dfe3          	bge	a5,a4,14b6 <writetest+0x54>
    }
  }
  close(fd);
    155c:	fe842783          	lw	a5,-24(s0)
    1560:	853e                	mv	a0,a5
    1562:	00006097          	auipc	ra,0x6
    1566:	e36080e7          	jalr	-458(ra) # 7398 <close>
  fd = open("small", O_RDONLY);
    156a:	4581                	li	a1,0
    156c:	00007517          	auipc	a0,0x7
    1570:	e5450513          	addi	a0,a0,-428 # 83c0 <cv_init+0x63a>
    1574:	00006097          	auipc	ra,0x6
    1578:	e3c080e7          	jalr	-452(ra) # 73b0 <open>
    157c:	87aa                	mv	a5,a0
    157e:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    1582:	fe842783          	lw	a5,-24(s0)
    1586:	2781                	sext.w	a5,a5
    1588:	0207d163          	bgez	a5,15aa <writetest+0x148>
    printf("%s: error: open small failed!\n", s);
    158c:	fd843583          	ld	a1,-40(s0)
    1590:	00007517          	auipc	a0,0x7
    1594:	ec850513          	addi	a0,a0,-312 # 8458 <cv_init+0x6d2>
    1598:	00006097          	auipc	ra,0x6
    159c:	310080e7          	jalr	784(ra) # 78a8 <printf>
    exit(1);
    15a0:	4505                	li	a0,1
    15a2:	00006097          	auipc	ra,0x6
    15a6:	dce080e7          	jalr	-562(ra) # 7370 <exit>
  }
  i = read(fd, buf, N*SZ*2);
    15aa:	fe842783          	lw	a5,-24(s0)
    15ae:	7d000613          	li	a2,2000
    15b2:	00009597          	auipc	a1,0x9
    15b6:	09658593          	addi	a1,a1,150 # a648 <buf>
    15ba:	853e                	mv	a0,a5
    15bc:	00006097          	auipc	ra,0x6
    15c0:	dcc080e7          	jalr	-564(ra) # 7388 <read>
    15c4:	87aa                	mv	a5,a0
    15c6:	fef42623          	sw	a5,-20(s0)
  if(i != N*SZ*2){
    15ca:	fec42783          	lw	a5,-20(s0)
    15ce:	0007871b          	sext.w	a4,a5
    15d2:	7d000793          	li	a5,2000
    15d6:	02f70163          	beq	a4,a5,15f8 <writetest+0x196>
    printf("%s: read failed\n", s);
    15da:	fd843583          	ld	a1,-40(s0)
    15de:	00007517          	auipc	a0,0x7
    15e2:	e9a50513          	addi	a0,a0,-358 # 8478 <cv_init+0x6f2>
    15e6:	00006097          	auipc	ra,0x6
    15ea:	2c2080e7          	jalr	706(ra) # 78a8 <printf>
    exit(1);
    15ee:	4505                	li	a0,1
    15f0:	00006097          	auipc	ra,0x6
    15f4:	d80080e7          	jalr	-640(ra) # 7370 <exit>
  }
  close(fd);
    15f8:	fe842783          	lw	a5,-24(s0)
    15fc:	853e                	mv	a0,a5
    15fe:	00006097          	auipc	ra,0x6
    1602:	d9a080e7          	jalr	-614(ra) # 7398 <close>

  if(unlink("small") < 0){
    1606:	00007517          	auipc	a0,0x7
    160a:	dba50513          	addi	a0,a0,-582 # 83c0 <cv_init+0x63a>
    160e:	00006097          	auipc	ra,0x6
    1612:	db2080e7          	jalr	-590(ra) # 73c0 <unlink>
    1616:	87aa                	mv	a5,a0
    1618:	0207d163          	bgez	a5,163a <writetest+0x1d8>
    printf("%s: unlink small failed\n", s);
    161c:	fd843583          	ld	a1,-40(s0)
    1620:	00007517          	auipc	a0,0x7
    1624:	e7050513          	addi	a0,a0,-400 # 8490 <cv_init+0x70a>
    1628:	00006097          	auipc	ra,0x6
    162c:	280080e7          	jalr	640(ra) # 78a8 <printf>
    exit(1);
    1630:	4505                	li	a0,1
    1632:	00006097          	auipc	ra,0x6
    1636:	d3e080e7          	jalr	-706(ra) # 7370 <exit>
  }
}
    163a:	0001                	nop
    163c:	70a2                	ld	ra,40(sp)
    163e:	7402                	ld	s0,32(sp)
    1640:	6145                	addi	sp,sp,48
    1642:	8082                	ret

0000000000001644 <writebig>:

void
writebig(char *s)
{
    1644:	7179                	addi	sp,sp,-48
    1646:	f406                	sd	ra,40(sp)
    1648:	f022                	sd	s0,32(sp)
    164a:	1800                	addi	s0,sp,48
    164c:	fca43c23          	sd	a0,-40(s0)
  int i, fd, n;

  fd = open("big", O_CREATE|O_RDWR);
    1650:	20200593          	li	a1,514
    1654:	00007517          	auipc	a0,0x7
    1658:	e5c50513          	addi	a0,a0,-420 # 84b0 <cv_init+0x72a>
    165c:	00006097          	auipc	ra,0x6
    1660:	d54080e7          	jalr	-684(ra) # 73b0 <open>
    1664:	87aa                	mv	a5,a0
    1666:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    166a:	fe442783          	lw	a5,-28(s0)
    166e:	2781                	sext.w	a5,a5
    1670:	0207d163          	bgez	a5,1692 <writebig+0x4e>
    printf("%s: error: creat big failed!\n", s);
    1674:	fd843583          	ld	a1,-40(s0)
    1678:	00007517          	auipc	a0,0x7
    167c:	e4050513          	addi	a0,a0,-448 # 84b8 <cv_init+0x732>
    1680:	00006097          	auipc	ra,0x6
    1684:	228080e7          	jalr	552(ra) # 78a8 <printf>
    exit(1);
    1688:	4505                	li	a0,1
    168a:	00006097          	auipc	ra,0x6
    168e:	ce6080e7          	jalr	-794(ra) # 7370 <exit>
  }

  for(i = 0; i < MAXFILE; i++){
    1692:	fe042623          	sw	zero,-20(s0)
    1696:	a095                	j	16fa <writebig+0xb6>
    ((int*)buf)[0] = i;
    1698:	00009797          	auipc	a5,0x9
    169c:	fb078793          	addi	a5,a5,-80 # a648 <buf>
    16a0:	fec42703          	lw	a4,-20(s0)
    16a4:	c398                	sw	a4,0(a5)
    if(write(fd, buf, BSIZE) != BSIZE){
    16a6:	fe442783          	lw	a5,-28(s0)
    16aa:	40000613          	li	a2,1024
    16ae:	00009597          	auipc	a1,0x9
    16b2:	f9a58593          	addi	a1,a1,-102 # a648 <buf>
    16b6:	853e                	mv	a0,a5
    16b8:	00006097          	auipc	ra,0x6
    16bc:	cd8080e7          	jalr	-808(ra) # 7390 <write>
    16c0:	87aa                	mv	a5,a0
    16c2:	873e                	mv	a4,a5
    16c4:	40000793          	li	a5,1024
    16c8:	02f70463          	beq	a4,a5,16f0 <writebig+0xac>
      printf("%s: error: write big file failed\n", s, i);
    16cc:	fec42783          	lw	a5,-20(s0)
    16d0:	863e                	mv	a2,a5
    16d2:	fd843583          	ld	a1,-40(s0)
    16d6:	00007517          	auipc	a0,0x7
    16da:	e0250513          	addi	a0,a0,-510 # 84d8 <cv_init+0x752>
    16de:	00006097          	auipc	ra,0x6
    16e2:	1ca080e7          	jalr	458(ra) # 78a8 <printf>
      exit(1);
    16e6:	4505                	li	a0,1
    16e8:	00006097          	auipc	ra,0x6
    16ec:	c88080e7          	jalr	-888(ra) # 7370 <exit>
  for(i = 0; i < MAXFILE; i++){
    16f0:	fec42783          	lw	a5,-20(s0)
    16f4:	2785                	addiw	a5,a5,1
    16f6:	fef42623          	sw	a5,-20(s0)
    16fa:	fec42783          	lw	a5,-20(s0)
    16fe:	873e                	mv	a4,a5
    1700:	10b00793          	li	a5,267
    1704:	f8e7fae3          	bgeu	a5,a4,1698 <writebig+0x54>
    }
  }

  close(fd);
    1708:	fe442783          	lw	a5,-28(s0)
    170c:	853e                	mv	a0,a5
    170e:	00006097          	auipc	ra,0x6
    1712:	c8a080e7          	jalr	-886(ra) # 7398 <close>

  fd = open("big", O_RDONLY);
    1716:	4581                	li	a1,0
    1718:	00007517          	auipc	a0,0x7
    171c:	d9850513          	addi	a0,a0,-616 # 84b0 <cv_init+0x72a>
    1720:	00006097          	auipc	ra,0x6
    1724:	c90080e7          	jalr	-880(ra) # 73b0 <open>
    1728:	87aa                	mv	a5,a0
    172a:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    172e:	fe442783          	lw	a5,-28(s0)
    1732:	2781                	sext.w	a5,a5
    1734:	0207d163          	bgez	a5,1756 <writebig+0x112>
    printf("%s: error: open big failed!\n", s);
    1738:	fd843583          	ld	a1,-40(s0)
    173c:	00007517          	auipc	a0,0x7
    1740:	dc450513          	addi	a0,a0,-572 # 8500 <cv_init+0x77a>
    1744:	00006097          	auipc	ra,0x6
    1748:	164080e7          	jalr	356(ra) # 78a8 <printf>
    exit(1);
    174c:	4505                	li	a0,1
    174e:	00006097          	auipc	ra,0x6
    1752:	c22080e7          	jalr	-990(ra) # 7370 <exit>
  }

  n = 0;
    1756:	fe042423          	sw	zero,-24(s0)
  for(;;){
    i = read(fd, buf, BSIZE);
    175a:	fe442783          	lw	a5,-28(s0)
    175e:	40000613          	li	a2,1024
    1762:	00009597          	auipc	a1,0x9
    1766:	ee658593          	addi	a1,a1,-282 # a648 <buf>
    176a:	853e                	mv	a0,a5
    176c:	00006097          	auipc	ra,0x6
    1770:	c1c080e7          	jalr	-996(ra) # 7388 <read>
    1774:	87aa                	mv	a5,a0
    1776:	fef42623          	sw	a5,-20(s0)
    if(i == 0){
    177a:	fec42783          	lw	a5,-20(s0)
    177e:	2781                	sext.w	a5,a5
    1780:	eb9d                	bnez	a5,17b6 <writebig+0x172>
      if(n == MAXFILE - 1){
    1782:	fe842783          	lw	a5,-24(s0)
    1786:	0007871b          	sext.w	a4,a5
    178a:	10b00793          	li	a5,267
    178e:	0af71663          	bne	a4,a5,183a <writebig+0x1f6>
        printf("%s: read only %d blocks from big", s, n);
    1792:	fe842783          	lw	a5,-24(s0)
    1796:	863e                	mv	a2,a5
    1798:	fd843583          	ld	a1,-40(s0)
    179c:	00007517          	auipc	a0,0x7
    17a0:	d8450513          	addi	a0,a0,-636 # 8520 <cv_init+0x79a>
    17a4:	00006097          	auipc	ra,0x6
    17a8:	104080e7          	jalr	260(ra) # 78a8 <printf>
        exit(1);
    17ac:	4505                	li	a0,1
    17ae:	00006097          	auipc	ra,0x6
    17b2:	bc2080e7          	jalr	-1086(ra) # 7370 <exit>
      }
      break;
    } else if(i != BSIZE){
    17b6:	fec42783          	lw	a5,-20(s0)
    17ba:	0007871b          	sext.w	a4,a5
    17be:	40000793          	li	a5,1024
    17c2:	02f70463          	beq	a4,a5,17ea <writebig+0x1a6>
      printf("%s: read failed %d\n", s, i);
    17c6:	fec42783          	lw	a5,-20(s0)
    17ca:	863e                	mv	a2,a5
    17cc:	fd843583          	ld	a1,-40(s0)
    17d0:	00007517          	auipc	a0,0x7
    17d4:	d7850513          	addi	a0,a0,-648 # 8548 <cv_init+0x7c2>
    17d8:	00006097          	auipc	ra,0x6
    17dc:	0d0080e7          	jalr	208(ra) # 78a8 <printf>
      exit(1);
    17e0:	4505                	li	a0,1
    17e2:	00006097          	auipc	ra,0x6
    17e6:	b8e080e7          	jalr	-1138(ra) # 7370 <exit>
    }
    if(((int*)buf)[0] != n){
    17ea:	00009797          	auipc	a5,0x9
    17ee:	e5e78793          	addi	a5,a5,-418 # a648 <buf>
    17f2:	4398                	lw	a4,0(a5)
    17f4:	fe842783          	lw	a5,-24(s0)
    17f8:	2781                	sext.w	a5,a5
    17fa:	02e78a63          	beq	a5,a4,182e <writebig+0x1ea>
      printf("%s: read content of block %d is %d\n", s,
             n, ((int*)buf)[0]);
    17fe:	00009797          	auipc	a5,0x9
    1802:	e4a78793          	addi	a5,a5,-438 # a648 <buf>
      printf("%s: read content of block %d is %d\n", s,
    1806:	4398                	lw	a4,0(a5)
    1808:	fe842783          	lw	a5,-24(s0)
    180c:	86ba                	mv	a3,a4
    180e:	863e                	mv	a2,a5
    1810:	fd843583          	ld	a1,-40(s0)
    1814:	00007517          	auipc	a0,0x7
    1818:	d4c50513          	addi	a0,a0,-692 # 8560 <cv_init+0x7da>
    181c:	00006097          	auipc	ra,0x6
    1820:	08c080e7          	jalr	140(ra) # 78a8 <printf>
      exit(1);
    1824:	4505                	li	a0,1
    1826:	00006097          	auipc	ra,0x6
    182a:	b4a080e7          	jalr	-1206(ra) # 7370 <exit>
    }
    n++;
    182e:	fe842783          	lw	a5,-24(s0)
    1832:	2785                	addiw	a5,a5,1
    1834:	fef42423          	sw	a5,-24(s0)
    i = read(fd, buf, BSIZE);
    1838:	b70d                	j	175a <writebig+0x116>
      break;
    183a:	0001                	nop
  }
  close(fd);
    183c:	fe442783          	lw	a5,-28(s0)
    1840:	853e                	mv	a0,a5
    1842:	00006097          	auipc	ra,0x6
    1846:	b56080e7          	jalr	-1194(ra) # 7398 <close>
  if(unlink("big") < 0){
    184a:	00007517          	auipc	a0,0x7
    184e:	c6650513          	addi	a0,a0,-922 # 84b0 <cv_init+0x72a>
    1852:	00006097          	auipc	ra,0x6
    1856:	b6e080e7          	jalr	-1170(ra) # 73c0 <unlink>
    185a:	87aa                	mv	a5,a0
    185c:	0207d163          	bgez	a5,187e <writebig+0x23a>
    printf("%s: unlink big failed\n", s);
    1860:	fd843583          	ld	a1,-40(s0)
    1864:	00007517          	auipc	a0,0x7
    1868:	d2450513          	addi	a0,a0,-732 # 8588 <cv_init+0x802>
    186c:	00006097          	auipc	ra,0x6
    1870:	03c080e7          	jalr	60(ra) # 78a8 <printf>
    exit(1);
    1874:	4505                	li	a0,1
    1876:	00006097          	auipc	ra,0x6
    187a:	afa080e7          	jalr	-1286(ra) # 7370 <exit>
  }
}
    187e:	0001                	nop
    1880:	70a2                	ld	ra,40(sp)
    1882:	7402                	ld	s0,32(sp)
    1884:	6145                	addi	sp,sp,48
    1886:	8082                	ret

0000000000001888 <createtest>:

// many creates, followed by unlink test
void
createtest(char *s)
{
    1888:	7179                	addi	sp,sp,-48
    188a:	f406                	sd	ra,40(sp)
    188c:	f022                	sd	s0,32(sp)
    188e:	1800                	addi	s0,sp,48
    1890:	fca43c23          	sd	a0,-40(s0)
  int i, fd;
  enum { N=52 };

  char name[3];
  name[0] = 'a';
    1894:	06100793          	li	a5,97
    1898:	fef40023          	sb	a5,-32(s0)
  name[2] = '\0';
    189c:	fe040123          	sb	zero,-30(s0)
  for(i = 0; i < N; i++){
    18a0:	fe042623          	sw	zero,-20(s0)
    18a4:	a099                	j	18ea <createtest+0x62>
    name[1] = '0' + i;
    18a6:	fec42783          	lw	a5,-20(s0)
    18aa:	0ff7f793          	zext.b	a5,a5
    18ae:	0307879b          	addiw	a5,a5,48
    18b2:	0ff7f793          	zext.b	a5,a5
    18b6:	fef400a3          	sb	a5,-31(s0)
    fd = open(name, O_CREATE|O_RDWR);
    18ba:	fe040793          	addi	a5,s0,-32
    18be:	20200593          	li	a1,514
    18c2:	853e                	mv	a0,a5
    18c4:	00006097          	auipc	ra,0x6
    18c8:	aec080e7          	jalr	-1300(ra) # 73b0 <open>
    18cc:	87aa                	mv	a5,a0
    18ce:	fef42423          	sw	a5,-24(s0)
    close(fd);
    18d2:	fe842783          	lw	a5,-24(s0)
    18d6:	853e                	mv	a0,a5
    18d8:	00006097          	auipc	ra,0x6
    18dc:	ac0080e7          	jalr	-1344(ra) # 7398 <close>
  for(i = 0; i < N; i++){
    18e0:	fec42783          	lw	a5,-20(s0)
    18e4:	2785                	addiw	a5,a5,1
    18e6:	fef42623          	sw	a5,-20(s0)
    18ea:	fec42783          	lw	a5,-20(s0)
    18ee:	0007871b          	sext.w	a4,a5
    18f2:	03300793          	li	a5,51
    18f6:	fae7d8e3          	bge	a5,a4,18a6 <createtest+0x1e>
  }
  name[0] = 'a';
    18fa:	06100793          	li	a5,97
    18fe:	fef40023          	sb	a5,-32(s0)
  name[2] = '\0';
    1902:	fe040123          	sb	zero,-30(s0)
  for(i = 0; i < N; i++){
    1906:	fe042623          	sw	zero,-20(s0)
    190a:	a03d                	j	1938 <createtest+0xb0>
    name[1] = '0' + i;
    190c:	fec42783          	lw	a5,-20(s0)
    1910:	0ff7f793          	zext.b	a5,a5
    1914:	0307879b          	addiw	a5,a5,48
    1918:	0ff7f793          	zext.b	a5,a5
    191c:	fef400a3          	sb	a5,-31(s0)
    unlink(name);
    1920:	fe040793          	addi	a5,s0,-32
    1924:	853e                	mv	a0,a5
    1926:	00006097          	auipc	ra,0x6
    192a:	a9a080e7          	jalr	-1382(ra) # 73c0 <unlink>
  for(i = 0; i < N; i++){
    192e:	fec42783          	lw	a5,-20(s0)
    1932:	2785                	addiw	a5,a5,1
    1934:	fef42623          	sw	a5,-20(s0)
    1938:	fec42783          	lw	a5,-20(s0)
    193c:	0007871b          	sext.w	a4,a5
    1940:	03300793          	li	a5,51
    1944:	fce7d4e3          	bge	a5,a4,190c <createtest+0x84>
  }
}
    1948:	0001                	nop
    194a:	0001                	nop
    194c:	70a2                	ld	ra,40(sp)
    194e:	7402                	ld	s0,32(sp)
    1950:	6145                	addi	sp,sp,48
    1952:	8082                	ret

0000000000001954 <dirtest>:

void dirtest(char *s)
{
    1954:	1101                	addi	sp,sp,-32
    1956:	ec06                	sd	ra,24(sp)
    1958:	e822                	sd	s0,16(sp)
    195a:	1000                	addi	s0,sp,32
    195c:	fea43423          	sd	a0,-24(s0)
  if(mkdir("dir0") < 0){
    1960:	00007517          	auipc	a0,0x7
    1964:	c4050513          	addi	a0,a0,-960 # 85a0 <cv_init+0x81a>
    1968:	00006097          	auipc	ra,0x6
    196c:	a70080e7          	jalr	-1424(ra) # 73d8 <mkdir>
    1970:	87aa                	mv	a5,a0
    1972:	0207d163          	bgez	a5,1994 <dirtest+0x40>
    printf("%s: mkdir failed\n", s);
    1976:	fe843583          	ld	a1,-24(s0)
    197a:	00007517          	auipc	a0,0x7
    197e:	8f650513          	addi	a0,a0,-1802 # 8270 <cv_init+0x4ea>
    1982:	00006097          	auipc	ra,0x6
    1986:	f26080e7          	jalr	-218(ra) # 78a8 <printf>
    exit(1);
    198a:	4505                	li	a0,1
    198c:	00006097          	auipc	ra,0x6
    1990:	9e4080e7          	jalr	-1564(ra) # 7370 <exit>
  }

  if(chdir("dir0") < 0){
    1994:	00007517          	auipc	a0,0x7
    1998:	c0c50513          	addi	a0,a0,-1012 # 85a0 <cv_init+0x81a>
    199c:	00006097          	auipc	ra,0x6
    19a0:	a44080e7          	jalr	-1468(ra) # 73e0 <chdir>
    19a4:	87aa                	mv	a5,a0
    19a6:	0207d163          	bgez	a5,19c8 <dirtest+0x74>
    printf("%s: chdir dir0 failed\n", s);
    19aa:	fe843583          	ld	a1,-24(s0)
    19ae:	00007517          	auipc	a0,0x7
    19b2:	bfa50513          	addi	a0,a0,-1030 # 85a8 <cv_init+0x822>
    19b6:	00006097          	auipc	ra,0x6
    19ba:	ef2080e7          	jalr	-270(ra) # 78a8 <printf>
    exit(1);
    19be:	4505                	li	a0,1
    19c0:	00006097          	auipc	ra,0x6
    19c4:	9b0080e7          	jalr	-1616(ra) # 7370 <exit>
  }

  if(chdir("..") < 0){
    19c8:	00007517          	auipc	a0,0x7
    19cc:	bf850513          	addi	a0,a0,-1032 # 85c0 <cv_init+0x83a>
    19d0:	00006097          	auipc	ra,0x6
    19d4:	a10080e7          	jalr	-1520(ra) # 73e0 <chdir>
    19d8:	87aa                	mv	a5,a0
    19da:	0207d163          	bgez	a5,19fc <dirtest+0xa8>
    printf("%s: chdir .. failed\n", s);
    19de:	fe843583          	ld	a1,-24(s0)
    19e2:	00007517          	auipc	a0,0x7
    19e6:	be650513          	addi	a0,a0,-1050 # 85c8 <cv_init+0x842>
    19ea:	00006097          	auipc	ra,0x6
    19ee:	ebe080e7          	jalr	-322(ra) # 78a8 <printf>
    exit(1);
    19f2:	4505                	li	a0,1
    19f4:	00006097          	auipc	ra,0x6
    19f8:	97c080e7          	jalr	-1668(ra) # 7370 <exit>
  }

  if(unlink("dir0") < 0){
    19fc:	00007517          	auipc	a0,0x7
    1a00:	ba450513          	addi	a0,a0,-1116 # 85a0 <cv_init+0x81a>
    1a04:	00006097          	auipc	ra,0x6
    1a08:	9bc080e7          	jalr	-1604(ra) # 73c0 <unlink>
    1a0c:	87aa                	mv	a5,a0
    1a0e:	0207d163          	bgez	a5,1a30 <dirtest+0xdc>
    printf("%s: unlink dir0 failed\n", s);
    1a12:	fe843583          	ld	a1,-24(s0)
    1a16:	00007517          	auipc	a0,0x7
    1a1a:	bca50513          	addi	a0,a0,-1078 # 85e0 <cv_init+0x85a>
    1a1e:	00006097          	auipc	ra,0x6
    1a22:	e8a080e7          	jalr	-374(ra) # 78a8 <printf>
    exit(1);
    1a26:	4505                	li	a0,1
    1a28:	00006097          	auipc	ra,0x6
    1a2c:	948080e7          	jalr	-1720(ra) # 7370 <exit>
  }
}
    1a30:	0001                	nop
    1a32:	60e2                	ld	ra,24(sp)
    1a34:	6442                	ld	s0,16(sp)
    1a36:	6105                	addi	sp,sp,32
    1a38:	8082                	ret

0000000000001a3a <exectest>:

void
exectest(char *s)
{
    1a3a:	715d                	addi	sp,sp,-80
    1a3c:	e486                	sd	ra,72(sp)
    1a3e:	e0a2                	sd	s0,64(sp)
    1a40:	0880                	addi	s0,sp,80
    1a42:	faa43c23          	sd	a0,-72(s0)
  int fd, xstatus, pid;
  char *echoargv[] = { "echo", "OK", 0 };
    1a46:	00006797          	auipc	a5,0x6
    1a4a:	57a78793          	addi	a5,a5,1402 # 7fc0 <cv_init+0x23a>
    1a4e:	fcf43423          	sd	a5,-56(s0)
    1a52:	00007797          	auipc	a5,0x7
    1a56:	ba678793          	addi	a5,a5,-1114 # 85f8 <cv_init+0x872>
    1a5a:	fcf43823          	sd	a5,-48(s0)
    1a5e:	fc043c23          	sd	zero,-40(s0)
  char buf[3];

  unlink("echo-ok");
    1a62:	00007517          	auipc	a0,0x7
    1a66:	b9e50513          	addi	a0,a0,-1122 # 8600 <cv_init+0x87a>
    1a6a:	00006097          	auipc	ra,0x6
    1a6e:	956080e7          	jalr	-1706(ra) # 73c0 <unlink>
  pid = fork();
    1a72:	00006097          	auipc	ra,0x6
    1a76:	8f6080e7          	jalr	-1802(ra) # 7368 <fork>
    1a7a:	87aa                	mv	a5,a0
    1a7c:	fef42623          	sw	a5,-20(s0)
  if(pid < 0) {
    1a80:	fec42783          	lw	a5,-20(s0)
    1a84:	2781                	sext.w	a5,a5
    1a86:	0207d163          	bgez	a5,1aa8 <exectest+0x6e>
     printf("%s: fork failed\n", s);
    1a8a:	fb843583          	ld	a1,-72(s0)
    1a8e:	00006517          	auipc	a0,0x6
    1a92:	75250513          	addi	a0,a0,1874 # 81e0 <cv_init+0x45a>
    1a96:	00006097          	auipc	ra,0x6
    1a9a:	e12080e7          	jalr	-494(ra) # 78a8 <printf>
     exit(1);
    1a9e:	4505                	li	a0,1
    1aa0:	00006097          	auipc	ra,0x6
    1aa4:	8d0080e7          	jalr	-1840(ra) # 7370 <exit>
  }
  if(pid == 0) {
    1aa8:	fec42783          	lw	a5,-20(s0)
    1aac:	2781                	sext.w	a5,a5
    1aae:	ebd5                	bnez	a5,1b62 <exectest+0x128>
    close(1);
    1ab0:	4505                	li	a0,1
    1ab2:	00006097          	auipc	ra,0x6
    1ab6:	8e6080e7          	jalr	-1818(ra) # 7398 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1aba:	20100593          	li	a1,513
    1abe:	00007517          	auipc	a0,0x7
    1ac2:	b4250513          	addi	a0,a0,-1214 # 8600 <cv_init+0x87a>
    1ac6:	00006097          	auipc	ra,0x6
    1aca:	8ea080e7          	jalr	-1814(ra) # 73b0 <open>
    1ace:	87aa                	mv	a5,a0
    1ad0:	fef42423          	sw	a5,-24(s0)
    if(fd < 0) {
    1ad4:	fe842783          	lw	a5,-24(s0)
    1ad8:	2781                	sext.w	a5,a5
    1ada:	0207d163          	bgez	a5,1afc <exectest+0xc2>
      printf("%s: create failed\n", s);
    1ade:	fb843583          	ld	a1,-72(s0)
    1ae2:	00007517          	auipc	a0,0x7
    1ae6:	b2650513          	addi	a0,a0,-1242 # 8608 <cv_init+0x882>
    1aea:	00006097          	auipc	ra,0x6
    1aee:	dbe080e7          	jalr	-578(ra) # 78a8 <printf>
      exit(1);
    1af2:	4505                	li	a0,1
    1af4:	00006097          	auipc	ra,0x6
    1af8:	87c080e7          	jalr	-1924(ra) # 7370 <exit>
    }
    if(fd != 1) {
    1afc:	fe842783          	lw	a5,-24(s0)
    1b00:	0007871b          	sext.w	a4,a5
    1b04:	4785                	li	a5,1
    1b06:	02f70163          	beq	a4,a5,1b28 <exectest+0xee>
      printf("%s: wrong fd\n", s);
    1b0a:	fb843583          	ld	a1,-72(s0)
    1b0e:	00007517          	auipc	a0,0x7
    1b12:	b1250513          	addi	a0,a0,-1262 # 8620 <cv_init+0x89a>
    1b16:	00006097          	auipc	ra,0x6
    1b1a:	d92080e7          	jalr	-622(ra) # 78a8 <printf>
      exit(1);
    1b1e:	4505                	li	a0,1
    1b20:	00006097          	auipc	ra,0x6
    1b24:	850080e7          	jalr	-1968(ra) # 7370 <exit>
    }
    if(exec("echo", echoargv) < 0){
    1b28:	fc840793          	addi	a5,s0,-56
    1b2c:	85be                	mv	a1,a5
    1b2e:	00006517          	auipc	a0,0x6
    1b32:	49250513          	addi	a0,a0,1170 # 7fc0 <cv_init+0x23a>
    1b36:	00006097          	auipc	ra,0x6
    1b3a:	872080e7          	jalr	-1934(ra) # 73a8 <exec>
    1b3e:	87aa                	mv	a5,a0
    1b40:	0207d163          	bgez	a5,1b62 <exectest+0x128>
      printf("%s: exec echo failed\n", s);
    1b44:	fb843583          	ld	a1,-72(s0)
    1b48:	00007517          	auipc	a0,0x7
    1b4c:	ae850513          	addi	a0,a0,-1304 # 8630 <cv_init+0x8aa>
    1b50:	00006097          	auipc	ra,0x6
    1b54:	d58080e7          	jalr	-680(ra) # 78a8 <printf>
      exit(1);
    1b58:	4505                	li	a0,1
    1b5a:	00006097          	auipc	ra,0x6
    1b5e:	816080e7          	jalr	-2026(ra) # 7370 <exit>
    }
    // won't get to here
  }
  if (wait(&xstatus) != pid) {
    1b62:	fe440793          	addi	a5,s0,-28
    1b66:	853e                	mv	a0,a5
    1b68:	00006097          	auipc	ra,0x6
    1b6c:	810080e7          	jalr	-2032(ra) # 7378 <wait>
    1b70:	87aa                	mv	a5,a0
    1b72:	873e                	mv	a4,a5
    1b74:	fec42783          	lw	a5,-20(s0)
    1b78:	2781                	sext.w	a5,a5
    1b7a:	00e78c63          	beq	a5,a4,1b92 <exectest+0x158>
    printf("%s: wait failed!\n", s);
    1b7e:	fb843583          	ld	a1,-72(s0)
    1b82:	00007517          	auipc	a0,0x7
    1b86:	ac650513          	addi	a0,a0,-1338 # 8648 <cv_init+0x8c2>
    1b8a:	00006097          	auipc	ra,0x6
    1b8e:	d1e080e7          	jalr	-738(ra) # 78a8 <printf>
  }
  if(xstatus != 0)
    1b92:	fe442783          	lw	a5,-28(s0)
    1b96:	cb81                	beqz	a5,1ba6 <exectest+0x16c>
    exit(xstatus);
    1b98:	fe442783          	lw	a5,-28(s0)
    1b9c:	853e                	mv	a0,a5
    1b9e:	00005097          	auipc	ra,0x5
    1ba2:	7d2080e7          	jalr	2002(ra) # 7370 <exit>

  fd = open("echo-ok", O_RDONLY);
    1ba6:	4581                	li	a1,0
    1ba8:	00007517          	auipc	a0,0x7
    1bac:	a5850513          	addi	a0,a0,-1448 # 8600 <cv_init+0x87a>
    1bb0:	00006097          	auipc	ra,0x6
    1bb4:	800080e7          	jalr	-2048(ra) # 73b0 <open>
    1bb8:	87aa                	mv	a5,a0
    1bba:	fef42423          	sw	a5,-24(s0)
  if(fd < 0) {
    1bbe:	fe842783          	lw	a5,-24(s0)
    1bc2:	2781                	sext.w	a5,a5
    1bc4:	0207d163          	bgez	a5,1be6 <exectest+0x1ac>
    printf("%s: open failed\n", s);
    1bc8:	fb843583          	ld	a1,-72(s0)
    1bcc:	00006517          	auipc	a0,0x6
    1bd0:	62c50513          	addi	a0,a0,1580 # 81f8 <cv_init+0x472>
    1bd4:	00006097          	auipc	ra,0x6
    1bd8:	cd4080e7          	jalr	-812(ra) # 78a8 <printf>
    exit(1);
    1bdc:	4505                	li	a0,1
    1bde:	00005097          	auipc	ra,0x5
    1be2:	792080e7          	jalr	1938(ra) # 7370 <exit>
  }
  if (read(fd, buf, 2) != 2) {
    1be6:	fc040713          	addi	a4,s0,-64
    1bea:	fe842783          	lw	a5,-24(s0)
    1bee:	4609                	li	a2,2
    1bf0:	85ba                	mv	a1,a4
    1bf2:	853e                	mv	a0,a5
    1bf4:	00005097          	auipc	ra,0x5
    1bf8:	794080e7          	jalr	1940(ra) # 7388 <read>
    1bfc:	87aa                	mv	a5,a0
    1bfe:	873e                	mv	a4,a5
    1c00:	4789                	li	a5,2
    1c02:	02f70163          	beq	a4,a5,1c24 <exectest+0x1ea>
    printf("%s: read failed\n", s);
    1c06:	fb843583          	ld	a1,-72(s0)
    1c0a:	00007517          	auipc	a0,0x7
    1c0e:	86e50513          	addi	a0,a0,-1938 # 8478 <cv_init+0x6f2>
    1c12:	00006097          	auipc	ra,0x6
    1c16:	c96080e7          	jalr	-874(ra) # 78a8 <printf>
    exit(1);
    1c1a:	4505                	li	a0,1
    1c1c:	00005097          	auipc	ra,0x5
    1c20:	754080e7          	jalr	1876(ra) # 7370 <exit>
  }
  unlink("echo-ok");
    1c24:	00007517          	auipc	a0,0x7
    1c28:	9dc50513          	addi	a0,a0,-1572 # 8600 <cv_init+0x87a>
    1c2c:	00005097          	auipc	ra,0x5
    1c30:	794080e7          	jalr	1940(ra) # 73c0 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    1c34:	fc044783          	lbu	a5,-64(s0)
    1c38:	873e                	mv	a4,a5
    1c3a:	04f00793          	li	a5,79
    1c3e:	00f71e63          	bne	a4,a5,1c5a <exectest+0x220>
    1c42:	fc144783          	lbu	a5,-63(s0)
    1c46:	873e                	mv	a4,a5
    1c48:	04b00793          	li	a5,75
    1c4c:	00f71763          	bne	a4,a5,1c5a <exectest+0x220>
    exit(0);
    1c50:	4501                	li	a0,0
    1c52:	00005097          	auipc	ra,0x5
    1c56:	71e080e7          	jalr	1822(ra) # 7370 <exit>
  else {
    printf("%s: wrong output\n", s);
    1c5a:	fb843583          	ld	a1,-72(s0)
    1c5e:	00007517          	auipc	a0,0x7
    1c62:	a0250513          	addi	a0,a0,-1534 # 8660 <cv_init+0x8da>
    1c66:	00006097          	auipc	ra,0x6
    1c6a:	c42080e7          	jalr	-958(ra) # 78a8 <printf>
    exit(1);
    1c6e:	4505                	li	a0,1
    1c70:	00005097          	auipc	ra,0x5
    1c74:	700080e7          	jalr	1792(ra) # 7370 <exit>

0000000000001c78 <pipe1>:

// simple fork and pipe read/write

void
pipe1(char *s)
{
    1c78:	715d                	addi	sp,sp,-80
    1c7a:	e486                	sd	ra,72(sp)
    1c7c:	e0a2                	sd	s0,64(sp)
    1c7e:	0880                	addi	s0,sp,80
    1c80:	faa43c23          	sd	a0,-72(s0)
  int fds[2], pid, xstatus;
  int seq, i, n, cc, total;
  enum { N=5, SZ=1033 };
  
  if(pipe(fds) != 0){
    1c84:	fd040793          	addi	a5,s0,-48
    1c88:	853e                	mv	a0,a5
    1c8a:	00005097          	auipc	ra,0x5
    1c8e:	6f6080e7          	jalr	1782(ra) # 7380 <pipe>
    1c92:	87aa                	mv	a5,a0
    1c94:	c385                	beqz	a5,1cb4 <pipe1+0x3c>
    printf("%s: pipe() failed\n", s);
    1c96:	fb843583          	ld	a1,-72(s0)
    1c9a:	00007517          	auipc	a0,0x7
    1c9e:	9de50513          	addi	a0,a0,-1570 # 8678 <cv_init+0x8f2>
    1ca2:	00006097          	auipc	ra,0x6
    1ca6:	c06080e7          	jalr	-1018(ra) # 78a8 <printf>
    exit(1);
    1caa:	4505                	li	a0,1
    1cac:	00005097          	auipc	ra,0x5
    1cb0:	6c4080e7          	jalr	1732(ra) # 7370 <exit>
  }
  pid = fork();
    1cb4:	00005097          	auipc	ra,0x5
    1cb8:	6b4080e7          	jalr	1716(ra) # 7368 <fork>
    1cbc:	87aa                	mv	a5,a0
    1cbe:	fcf42c23          	sw	a5,-40(s0)
  seq = 0;
    1cc2:	fe042623          	sw	zero,-20(s0)
  if(pid == 0){
    1cc6:	fd842783          	lw	a5,-40(s0)
    1cca:	2781                	sext.w	a5,a5
    1ccc:	efdd                	bnez	a5,1d8a <pipe1+0x112>
    close(fds[0]);
    1cce:	fd042783          	lw	a5,-48(s0)
    1cd2:	853e                	mv	a0,a5
    1cd4:	00005097          	auipc	ra,0x5
    1cd8:	6c4080e7          	jalr	1732(ra) # 7398 <close>
    for(n = 0; n < N; n++){
    1cdc:	fe042223          	sw	zero,-28(s0)
    1ce0:	a849                	j	1d72 <pipe1+0xfa>
      for(i = 0; i < SZ; i++)
    1ce2:	fe042423          	sw	zero,-24(s0)
    1ce6:	a03d                	j	1d14 <pipe1+0x9c>
        buf[i] = seq++;
    1ce8:	fec42783          	lw	a5,-20(s0)
    1cec:	0017871b          	addiw	a4,a5,1
    1cf0:	fee42623          	sw	a4,-20(s0)
    1cf4:	0ff7f713          	zext.b	a4,a5
    1cf8:	00009697          	auipc	a3,0x9
    1cfc:	95068693          	addi	a3,a3,-1712 # a648 <buf>
    1d00:	fe842783          	lw	a5,-24(s0)
    1d04:	97b6                	add	a5,a5,a3
    1d06:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1d0a:	fe842783          	lw	a5,-24(s0)
    1d0e:	2785                	addiw	a5,a5,1
    1d10:	fef42423          	sw	a5,-24(s0)
    1d14:	fe842783          	lw	a5,-24(s0)
    1d18:	0007871b          	sext.w	a4,a5
    1d1c:	40800793          	li	a5,1032
    1d20:	fce7d4e3          	bge	a5,a4,1ce8 <pipe1+0x70>
      if(write(fds[1], buf, SZ) != SZ){
    1d24:	fd442783          	lw	a5,-44(s0)
    1d28:	40900613          	li	a2,1033
    1d2c:	00009597          	auipc	a1,0x9
    1d30:	91c58593          	addi	a1,a1,-1764 # a648 <buf>
    1d34:	853e                	mv	a0,a5
    1d36:	00005097          	auipc	ra,0x5
    1d3a:	65a080e7          	jalr	1626(ra) # 7390 <write>
    1d3e:	87aa                	mv	a5,a0
    1d40:	873e                	mv	a4,a5
    1d42:	40900793          	li	a5,1033
    1d46:	02f70163          	beq	a4,a5,1d68 <pipe1+0xf0>
        printf("%s: pipe1 oops 1\n", s);
    1d4a:	fb843583          	ld	a1,-72(s0)
    1d4e:	00007517          	auipc	a0,0x7
    1d52:	94250513          	addi	a0,a0,-1726 # 8690 <cv_init+0x90a>
    1d56:	00006097          	auipc	ra,0x6
    1d5a:	b52080e7          	jalr	-1198(ra) # 78a8 <printf>
        exit(1);
    1d5e:	4505                	li	a0,1
    1d60:	00005097          	auipc	ra,0x5
    1d64:	610080e7          	jalr	1552(ra) # 7370 <exit>
    for(n = 0; n < N; n++){
    1d68:	fe442783          	lw	a5,-28(s0)
    1d6c:	2785                	addiw	a5,a5,1
    1d6e:	fef42223          	sw	a5,-28(s0)
    1d72:	fe442783          	lw	a5,-28(s0)
    1d76:	0007871b          	sext.w	a4,a5
    1d7a:	4791                	li	a5,4
    1d7c:	f6e7d3e3          	bge	a5,a4,1ce2 <pipe1+0x6a>
      }
    }
    exit(0);
    1d80:	4501                	li	a0,0
    1d82:	00005097          	auipc	ra,0x5
    1d86:	5ee080e7          	jalr	1518(ra) # 7370 <exit>
  } else if(pid > 0){
    1d8a:	fd842783          	lw	a5,-40(s0)
    1d8e:	2781                	sext.w	a5,a5
    1d90:	12f05d63          	blez	a5,1eca <pipe1+0x252>
    close(fds[1]);
    1d94:	fd442783          	lw	a5,-44(s0)
    1d98:	853e                	mv	a0,a5
    1d9a:	00005097          	auipc	ra,0x5
    1d9e:	5fe080e7          	jalr	1534(ra) # 7398 <close>
    total = 0;
    1da2:	fc042e23          	sw	zero,-36(s0)
    cc = 1;
    1da6:	4785                	li	a5,1
    1da8:	fef42023          	sw	a5,-32(s0)
    while((n = read(fds[0], buf, cc)) > 0){
    1dac:	a859                	j	1e42 <pipe1+0x1ca>
      for(i = 0; i < n; i++){
    1dae:	fe042423          	sw	zero,-24(s0)
    1db2:	a881                	j	1e02 <pipe1+0x18a>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1db4:	00009717          	auipc	a4,0x9
    1db8:	89470713          	addi	a4,a4,-1900 # a648 <buf>
    1dbc:	fe842783          	lw	a5,-24(s0)
    1dc0:	97ba                	add	a5,a5,a4
    1dc2:	0007c783          	lbu	a5,0(a5)
    1dc6:	0007869b          	sext.w	a3,a5
    1dca:	fec42783          	lw	a5,-20(s0)
    1dce:	0017871b          	addiw	a4,a5,1
    1dd2:	fee42623          	sw	a4,-20(s0)
    1dd6:	0ff7f793          	zext.b	a5,a5
    1dda:	2781                	sext.w	a5,a5
    1ddc:	8736                	mv	a4,a3
    1dde:	00f70d63          	beq	a4,a5,1df8 <pipe1+0x180>
          printf("%s: pipe1 oops 2\n", s);
    1de2:	fb843583          	ld	a1,-72(s0)
    1de6:	00007517          	auipc	a0,0x7
    1dea:	8c250513          	addi	a0,a0,-1854 # 86a8 <cv_init+0x922>
    1dee:	00006097          	auipc	ra,0x6
    1df2:	aba080e7          	jalr	-1350(ra) # 78a8 <printf>
          return;
    1df6:	a8cd                	j	1ee8 <pipe1+0x270>
      for(i = 0; i < n; i++){
    1df8:	fe842783          	lw	a5,-24(s0)
    1dfc:	2785                	addiw	a5,a5,1
    1dfe:	fef42423          	sw	a5,-24(s0)
    1e02:	fe842783          	lw	a5,-24(s0)
    1e06:	873e                	mv	a4,a5
    1e08:	fe442783          	lw	a5,-28(s0)
    1e0c:	2701                	sext.w	a4,a4
    1e0e:	2781                	sext.w	a5,a5
    1e10:	faf742e3          	blt	a4,a5,1db4 <pipe1+0x13c>
        }
      }
      total += n;
    1e14:	fdc42783          	lw	a5,-36(s0)
    1e18:	873e                	mv	a4,a5
    1e1a:	fe442783          	lw	a5,-28(s0)
    1e1e:	9fb9                	addw	a5,a5,a4
    1e20:	fcf42e23          	sw	a5,-36(s0)
      cc = cc * 2;
    1e24:	fe042783          	lw	a5,-32(s0)
    1e28:	0017979b          	slliw	a5,a5,0x1
    1e2c:	fef42023          	sw	a5,-32(s0)
      if(cc > sizeof(buf))
    1e30:	fe042783          	lw	a5,-32(s0)
    1e34:	873e                	mv	a4,a5
    1e36:	678d                	lui	a5,0x3
    1e38:	00e7f563          	bgeu	a5,a4,1e42 <pipe1+0x1ca>
        cc = sizeof(buf);
    1e3c:	678d                	lui	a5,0x3
    1e3e:	fef42023          	sw	a5,-32(s0)
    while((n = read(fds[0], buf, cc)) > 0){
    1e42:	fd042783          	lw	a5,-48(s0)
    1e46:	fe042703          	lw	a4,-32(s0)
    1e4a:	863a                	mv	a2,a4
    1e4c:	00008597          	auipc	a1,0x8
    1e50:	7fc58593          	addi	a1,a1,2044 # a648 <buf>
    1e54:	853e                	mv	a0,a5
    1e56:	00005097          	auipc	ra,0x5
    1e5a:	532080e7          	jalr	1330(ra) # 7388 <read>
    1e5e:	87aa                	mv	a5,a0
    1e60:	fef42223          	sw	a5,-28(s0)
    1e64:	fe442783          	lw	a5,-28(s0)
    1e68:	2781                	sext.w	a5,a5
    1e6a:	f4f042e3          	bgtz	a5,1dae <pipe1+0x136>
    }
    if(total != N * SZ){
    1e6e:	fdc42783          	lw	a5,-36(s0)
    1e72:	0007871b          	sext.w	a4,a5
    1e76:	6785                	lui	a5,0x1
    1e78:	42d78793          	addi	a5,a5,1069 # 142d <opentest+0x6f>
    1e7c:	02f70263          	beq	a4,a5,1ea0 <pipe1+0x228>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1e80:	fdc42783          	lw	a5,-36(s0)
    1e84:	85be                	mv	a1,a5
    1e86:	00007517          	auipc	a0,0x7
    1e8a:	83a50513          	addi	a0,a0,-1990 # 86c0 <cv_init+0x93a>
    1e8e:	00006097          	auipc	ra,0x6
    1e92:	a1a080e7          	jalr	-1510(ra) # 78a8 <printf>
      exit(1);
    1e96:	4505                	li	a0,1
    1e98:	00005097          	auipc	ra,0x5
    1e9c:	4d8080e7          	jalr	1240(ra) # 7370 <exit>
    }
    close(fds[0]);
    1ea0:	fd042783          	lw	a5,-48(s0)
    1ea4:	853e                	mv	a0,a5
    1ea6:	00005097          	auipc	ra,0x5
    1eaa:	4f2080e7          	jalr	1266(ra) # 7398 <close>
    wait(&xstatus);
    1eae:	fcc40793          	addi	a5,s0,-52
    1eb2:	853e                	mv	a0,a5
    1eb4:	00005097          	auipc	ra,0x5
    1eb8:	4c4080e7          	jalr	1220(ra) # 7378 <wait>
    exit(xstatus);
    1ebc:	fcc42783          	lw	a5,-52(s0)
    1ec0:	853e                	mv	a0,a5
    1ec2:	00005097          	auipc	ra,0x5
    1ec6:	4ae080e7          	jalr	1198(ra) # 7370 <exit>
  } else {
    printf("%s: fork() failed\n", s);
    1eca:	fb843583          	ld	a1,-72(s0)
    1ece:	00007517          	auipc	a0,0x7
    1ed2:	81250513          	addi	a0,a0,-2030 # 86e0 <cv_init+0x95a>
    1ed6:	00006097          	auipc	ra,0x6
    1eda:	9d2080e7          	jalr	-1582(ra) # 78a8 <printf>
    exit(1);
    1ede:	4505                	li	a0,1
    1ee0:	00005097          	auipc	ra,0x5
    1ee4:	490080e7          	jalr	1168(ra) # 7370 <exit>
  }
}
    1ee8:	60a6                	ld	ra,72(sp)
    1eea:	6406                	ld	s0,64(sp)
    1eec:	6161                	addi	sp,sp,80
    1eee:	8082                	ret

0000000000001ef0 <killstatus>:


// test if child is killed (status = -1)
void
killstatus(char *s)
{
    1ef0:	7179                	addi	sp,sp,-48
    1ef2:	f406                	sd	ra,40(sp)
    1ef4:	f022                	sd	s0,32(sp)
    1ef6:	1800                	addi	s0,sp,48
    1ef8:	fca43c23          	sd	a0,-40(s0)
  int xst;
  
  for(int i = 0; i < 100; i++){
    1efc:	fe042623          	sw	zero,-20(s0)
    1f00:	a055                	j	1fa4 <killstatus+0xb4>
    int pid1 = fork();
    1f02:	00005097          	auipc	ra,0x5
    1f06:	466080e7          	jalr	1126(ra) # 7368 <fork>
    1f0a:	87aa                	mv	a5,a0
    1f0c:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    1f10:	fe842783          	lw	a5,-24(s0)
    1f14:	2781                	sext.w	a5,a5
    1f16:	0207d163          	bgez	a5,1f38 <killstatus+0x48>
      printf("%s: fork failed\n", s);
    1f1a:	fd843583          	ld	a1,-40(s0)
    1f1e:	00006517          	auipc	a0,0x6
    1f22:	2c250513          	addi	a0,a0,706 # 81e0 <cv_init+0x45a>
    1f26:	00006097          	auipc	ra,0x6
    1f2a:	982080e7          	jalr	-1662(ra) # 78a8 <printf>
      exit(1);
    1f2e:	4505                	li	a0,1
    1f30:	00005097          	auipc	ra,0x5
    1f34:	440080e7          	jalr	1088(ra) # 7370 <exit>
    }
    if(pid1 == 0){
    1f38:	fe842783          	lw	a5,-24(s0)
    1f3c:	2781                	sext.w	a5,a5
    1f3e:	e791                	bnez	a5,1f4a <killstatus+0x5a>
      while(1) {
        getpid();
    1f40:	00005097          	auipc	ra,0x5
    1f44:	4b0080e7          	jalr	1200(ra) # 73f0 <getpid>
    1f48:	bfe5                	j	1f40 <killstatus+0x50>
      }
      exit(0);
    }
    sleep(1);
    1f4a:	4505                	li	a0,1
    1f4c:	00005097          	auipc	ra,0x5
    1f50:	4b4080e7          	jalr	1204(ra) # 7400 <sleep>
    kill(pid1);
    1f54:	fe842783          	lw	a5,-24(s0)
    1f58:	853e                	mv	a0,a5
    1f5a:	00005097          	auipc	ra,0x5
    1f5e:	446080e7          	jalr	1094(ra) # 73a0 <kill>
    wait(&xst);
    1f62:	fe440793          	addi	a5,s0,-28
    1f66:	853e                	mv	a0,a5
    1f68:	00005097          	auipc	ra,0x5
    1f6c:	410080e7          	jalr	1040(ra) # 7378 <wait>
    if(xst != -1) {
    1f70:	fe442783          	lw	a5,-28(s0)
    1f74:	873e                	mv	a4,a5
    1f76:	57fd                	li	a5,-1
    1f78:	02f70163          	beq	a4,a5,1f9a <killstatus+0xaa>
       printf("%s: status should be -1\n", s);
    1f7c:	fd843583          	ld	a1,-40(s0)
    1f80:	00006517          	auipc	a0,0x6
    1f84:	77850513          	addi	a0,a0,1912 # 86f8 <cv_init+0x972>
    1f88:	00006097          	auipc	ra,0x6
    1f8c:	920080e7          	jalr	-1760(ra) # 78a8 <printf>
       exit(1);
    1f90:	4505                	li	a0,1
    1f92:	00005097          	auipc	ra,0x5
    1f96:	3de080e7          	jalr	990(ra) # 7370 <exit>
  for(int i = 0; i < 100; i++){
    1f9a:	fec42783          	lw	a5,-20(s0)
    1f9e:	2785                	addiw	a5,a5,1
    1fa0:	fef42623          	sw	a5,-20(s0)
    1fa4:	fec42783          	lw	a5,-20(s0)
    1fa8:	0007871b          	sext.w	a4,a5
    1fac:	06300793          	li	a5,99
    1fb0:	f4e7d9e3          	bge	a5,a4,1f02 <killstatus+0x12>
    }
  }
  exit(0);
    1fb4:	4501                	li	a0,0
    1fb6:	00005097          	auipc	ra,0x5
    1fba:	3ba080e7          	jalr	954(ra) # 7370 <exit>

0000000000001fbe <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(char *s)
{
    1fbe:	7139                	addi	sp,sp,-64
    1fc0:	fc06                	sd	ra,56(sp)
    1fc2:	f822                	sd	s0,48(sp)
    1fc4:	0080                	addi	s0,sp,64
    1fc6:	fca43423          	sd	a0,-56(s0)
  int pid1, pid2, pid3;
  int pfds[2];

  pid1 = fork();
    1fca:	00005097          	auipc	ra,0x5
    1fce:	39e080e7          	jalr	926(ra) # 7368 <fork>
    1fd2:	87aa                	mv	a5,a0
    1fd4:	fef42623          	sw	a5,-20(s0)
  if(pid1 < 0) {
    1fd8:	fec42783          	lw	a5,-20(s0)
    1fdc:	2781                	sext.w	a5,a5
    1fde:	0207d163          	bgez	a5,2000 <preempt+0x42>
    printf("%s: fork failed", s);
    1fe2:	fc843583          	ld	a1,-56(s0)
    1fe6:	00006517          	auipc	a0,0x6
    1fea:	73250513          	addi	a0,a0,1842 # 8718 <cv_init+0x992>
    1fee:	00006097          	auipc	ra,0x6
    1ff2:	8ba080e7          	jalr	-1862(ra) # 78a8 <printf>
    exit(1);
    1ff6:	4505                	li	a0,1
    1ff8:	00005097          	auipc	ra,0x5
    1ffc:	378080e7          	jalr	888(ra) # 7370 <exit>
  }
  if(pid1 == 0)
    2000:	fec42783          	lw	a5,-20(s0)
    2004:	2781                	sext.w	a5,a5
    2006:	e391                	bnez	a5,200a <preempt+0x4c>
    for(;;)
    2008:	a001                	j	2008 <preempt+0x4a>
      ;

  pid2 = fork();
    200a:	00005097          	auipc	ra,0x5
    200e:	35e080e7          	jalr	862(ra) # 7368 <fork>
    2012:	87aa                	mv	a5,a0
    2014:	fef42423          	sw	a5,-24(s0)
  if(pid2 < 0) {
    2018:	fe842783          	lw	a5,-24(s0)
    201c:	2781                	sext.w	a5,a5
    201e:	0207d163          	bgez	a5,2040 <preempt+0x82>
    printf("%s: fork failed\n", s);
    2022:	fc843583          	ld	a1,-56(s0)
    2026:	00006517          	auipc	a0,0x6
    202a:	1ba50513          	addi	a0,a0,442 # 81e0 <cv_init+0x45a>
    202e:	00006097          	auipc	ra,0x6
    2032:	87a080e7          	jalr	-1926(ra) # 78a8 <printf>
    exit(1);
    2036:	4505                	li	a0,1
    2038:	00005097          	auipc	ra,0x5
    203c:	338080e7          	jalr	824(ra) # 7370 <exit>
  }
  if(pid2 == 0)
    2040:	fe842783          	lw	a5,-24(s0)
    2044:	2781                	sext.w	a5,a5
    2046:	e391                	bnez	a5,204a <preempt+0x8c>
    for(;;)
    2048:	a001                	j	2048 <preempt+0x8a>
      ;

  pipe(pfds);
    204a:	fd840793          	addi	a5,s0,-40
    204e:	853e                	mv	a0,a5
    2050:	00005097          	auipc	ra,0x5
    2054:	330080e7          	jalr	816(ra) # 7380 <pipe>
  pid3 = fork();
    2058:	00005097          	auipc	ra,0x5
    205c:	310080e7          	jalr	784(ra) # 7368 <fork>
    2060:	87aa                	mv	a5,a0
    2062:	fef42223          	sw	a5,-28(s0)
  if(pid3 < 0) {
    2066:	fe442783          	lw	a5,-28(s0)
    206a:	2781                	sext.w	a5,a5
    206c:	0207d163          	bgez	a5,208e <preempt+0xd0>
     printf("%s: fork failed\n", s);
    2070:	fc843583          	ld	a1,-56(s0)
    2074:	00006517          	auipc	a0,0x6
    2078:	16c50513          	addi	a0,a0,364 # 81e0 <cv_init+0x45a>
    207c:	00006097          	auipc	ra,0x6
    2080:	82c080e7          	jalr	-2004(ra) # 78a8 <printf>
     exit(1);
    2084:	4505                	li	a0,1
    2086:	00005097          	auipc	ra,0x5
    208a:	2ea080e7          	jalr	746(ra) # 7370 <exit>
  }
  if(pid3 == 0){
    208e:	fe442783          	lw	a5,-28(s0)
    2092:	2781                	sext.w	a5,a5
    2094:	ebb9                	bnez	a5,20ea <preempt+0x12c>
    close(pfds[0]);
    2096:	fd842783          	lw	a5,-40(s0)
    209a:	853e                	mv	a0,a5
    209c:	00005097          	auipc	ra,0x5
    20a0:	2fc080e7          	jalr	764(ra) # 7398 <close>
    if(write(pfds[1], "x", 1) != 1)
    20a4:	fdc42783          	lw	a5,-36(s0)
    20a8:	4605                	li	a2,1
    20aa:	00006597          	auipc	a1,0x6
    20ae:	e0658593          	addi	a1,a1,-506 # 7eb0 <cv_init+0x12a>
    20b2:	853e                	mv	a0,a5
    20b4:	00005097          	auipc	ra,0x5
    20b8:	2dc080e7          	jalr	732(ra) # 7390 <write>
    20bc:	87aa                	mv	a5,a0
    20be:	873e                	mv	a4,a5
    20c0:	4785                	li	a5,1
    20c2:	00f70c63          	beq	a4,a5,20da <preempt+0x11c>
      printf("%s: preempt write error", s);
    20c6:	fc843583          	ld	a1,-56(s0)
    20ca:	00006517          	auipc	a0,0x6
    20ce:	65e50513          	addi	a0,a0,1630 # 8728 <cv_init+0x9a2>
    20d2:	00005097          	auipc	ra,0x5
    20d6:	7d6080e7          	jalr	2006(ra) # 78a8 <printf>
    close(pfds[1]);
    20da:	fdc42783          	lw	a5,-36(s0)
    20de:	853e                	mv	a0,a5
    20e0:	00005097          	auipc	ra,0x5
    20e4:	2b8080e7          	jalr	696(ra) # 7398 <close>
    for(;;)
    20e8:	a001                	j	20e8 <preempt+0x12a>
      ;
  }

  close(pfds[1]);
    20ea:	fdc42783          	lw	a5,-36(s0)
    20ee:	853e                	mv	a0,a5
    20f0:	00005097          	auipc	ra,0x5
    20f4:	2a8080e7          	jalr	680(ra) # 7398 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    20f8:	fd842783          	lw	a5,-40(s0)
    20fc:	660d                	lui	a2,0x3
    20fe:	00008597          	auipc	a1,0x8
    2102:	54a58593          	addi	a1,a1,1354 # a648 <buf>
    2106:	853e                	mv	a0,a5
    2108:	00005097          	auipc	ra,0x5
    210c:	280080e7          	jalr	640(ra) # 7388 <read>
    2110:	87aa                	mv	a5,a0
    2112:	873e                	mv	a4,a5
    2114:	4785                	li	a5,1
    2116:	00f70d63          	beq	a4,a5,2130 <preempt+0x172>
    printf("%s: preempt read error", s);
    211a:	fc843583          	ld	a1,-56(s0)
    211e:	00006517          	auipc	a0,0x6
    2122:	62250513          	addi	a0,a0,1570 # 8740 <cv_init+0x9ba>
    2126:	00005097          	auipc	ra,0x5
    212a:	782080e7          	jalr	1922(ra) # 78a8 <printf>
    212e:	a8a5                	j	21a6 <preempt+0x1e8>
    return;
  }
  close(pfds[0]);
    2130:	fd842783          	lw	a5,-40(s0)
    2134:	853e                	mv	a0,a5
    2136:	00005097          	auipc	ra,0x5
    213a:	262080e7          	jalr	610(ra) # 7398 <close>
  printf("kill... ");
    213e:	00006517          	auipc	a0,0x6
    2142:	61a50513          	addi	a0,a0,1562 # 8758 <cv_init+0x9d2>
    2146:	00005097          	auipc	ra,0x5
    214a:	762080e7          	jalr	1890(ra) # 78a8 <printf>
  kill(pid1);
    214e:	fec42783          	lw	a5,-20(s0)
    2152:	853e                	mv	a0,a5
    2154:	00005097          	auipc	ra,0x5
    2158:	24c080e7          	jalr	588(ra) # 73a0 <kill>
  kill(pid2);
    215c:	fe842783          	lw	a5,-24(s0)
    2160:	853e                	mv	a0,a5
    2162:	00005097          	auipc	ra,0x5
    2166:	23e080e7          	jalr	574(ra) # 73a0 <kill>
  kill(pid3);
    216a:	fe442783          	lw	a5,-28(s0)
    216e:	853e                	mv	a0,a5
    2170:	00005097          	auipc	ra,0x5
    2174:	230080e7          	jalr	560(ra) # 73a0 <kill>
  printf("wait... ");
    2178:	00006517          	auipc	a0,0x6
    217c:	5f050513          	addi	a0,a0,1520 # 8768 <cv_init+0x9e2>
    2180:	00005097          	auipc	ra,0x5
    2184:	728080e7          	jalr	1832(ra) # 78a8 <printf>
  wait(0);
    2188:	4501                	li	a0,0
    218a:	00005097          	auipc	ra,0x5
    218e:	1ee080e7          	jalr	494(ra) # 7378 <wait>
  wait(0);
    2192:	4501                	li	a0,0
    2194:	00005097          	auipc	ra,0x5
    2198:	1e4080e7          	jalr	484(ra) # 7378 <wait>
  wait(0);
    219c:	4501                	li	a0,0
    219e:	00005097          	auipc	ra,0x5
    21a2:	1da080e7          	jalr	474(ra) # 7378 <wait>
}
    21a6:	70e2                	ld	ra,56(sp)
    21a8:	7442                	ld	s0,48(sp)
    21aa:	6121                	addi	sp,sp,64
    21ac:	8082                	ret

00000000000021ae <exitwait>:

// try to find any races between exit and wait
void
exitwait(char *s)
{
    21ae:	7179                	addi	sp,sp,-48
    21b0:	f406                	sd	ra,40(sp)
    21b2:	f022                	sd	s0,32(sp)
    21b4:	1800                	addi	s0,sp,48
    21b6:	fca43c23          	sd	a0,-40(s0)
  int i, pid;

  for(i = 0; i < 100; i++){
    21ba:	fe042623          	sw	zero,-20(s0)
    21be:	a87d                	j	227c <exitwait+0xce>
    pid = fork();
    21c0:	00005097          	auipc	ra,0x5
    21c4:	1a8080e7          	jalr	424(ra) # 7368 <fork>
    21c8:	87aa                	mv	a5,a0
    21ca:	fef42423          	sw	a5,-24(s0)
    if(pid < 0){
    21ce:	fe842783          	lw	a5,-24(s0)
    21d2:	2781                	sext.w	a5,a5
    21d4:	0207d163          	bgez	a5,21f6 <exitwait+0x48>
      printf("%s: fork failed\n", s);
    21d8:	fd843583          	ld	a1,-40(s0)
    21dc:	00006517          	auipc	a0,0x6
    21e0:	00450513          	addi	a0,a0,4 # 81e0 <cv_init+0x45a>
    21e4:	00005097          	auipc	ra,0x5
    21e8:	6c4080e7          	jalr	1732(ra) # 78a8 <printf>
      exit(1);
    21ec:	4505                	li	a0,1
    21ee:	00005097          	auipc	ra,0x5
    21f2:	182080e7          	jalr	386(ra) # 7370 <exit>
    }
    if(pid){
    21f6:	fe842783          	lw	a5,-24(s0)
    21fa:	2781                	sext.w	a5,a5
    21fc:	c7a5                	beqz	a5,2264 <exitwait+0xb6>
      int xstate;
      if(wait(&xstate) != pid){
    21fe:	fe440793          	addi	a5,s0,-28
    2202:	853e                	mv	a0,a5
    2204:	00005097          	auipc	ra,0x5
    2208:	174080e7          	jalr	372(ra) # 7378 <wait>
    220c:	87aa                	mv	a5,a0
    220e:	873e                	mv	a4,a5
    2210:	fe842783          	lw	a5,-24(s0)
    2214:	2781                	sext.w	a5,a5
    2216:	02e78163          	beq	a5,a4,2238 <exitwait+0x8a>
        printf("%s: wait wrong pid\n", s);
    221a:	fd843583          	ld	a1,-40(s0)
    221e:	00006517          	auipc	a0,0x6
    2222:	55a50513          	addi	a0,a0,1370 # 8778 <cv_init+0x9f2>
    2226:	00005097          	auipc	ra,0x5
    222a:	682080e7          	jalr	1666(ra) # 78a8 <printf>
        exit(1);
    222e:	4505                	li	a0,1
    2230:	00005097          	auipc	ra,0x5
    2234:	140080e7          	jalr	320(ra) # 7370 <exit>
      }
      if(i != xstate) {
    2238:	fe442703          	lw	a4,-28(s0)
    223c:	fec42783          	lw	a5,-20(s0)
    2240:	2781                	sext.w	a5,a5
    2242:	02e78863          	beq	a5,a4,2272 <exitwait+0xc4>
        printf("%s: wait wrong exit status\n", s);
    2246:	fd843583          	ld	a1,-40(s0)
    224a:	00006517          	auipc	a0,0x6
    224e:	54650513          	addi	a0,a0,1350 # 8790 <cv_init+0xa0a>
    2252:	00005097          	auipc	ra,0x5
    2256:	656080e7          	jalr	1622(ra) # 78a8 <printf>
        exit(1);
    225a:	4505                	li	a0,1
    225c:	00005097          	auipc	ra,0x5
    2260:	114080e7          	jalr	276(ra) # 7370 <exit>
      }
    } else {
      exit(i);
    2264:	fec42783          	lw	a5,-20(s0)
    2268:	853e                	mv	a0,a5
    226a:	00005097          	auipc	ra,0x5
    226e:	106080e7          	jalr	262(ra) # 7370 <exit>
  for(i = 0; i < 100; i++){
    2272:	fec42783          	lw	a5,-20(s0)
    2276:	2785                	addiw	a5,a5,1
    2278:	fef42623          	sw	a5,-20(s0)
    227c:	fec42783          	lw	a5,-20(s0)
    2280:	0007871b          	sext.w	a4,a5
    2284:	06300793          	li	a5,99
    2288:	f2e7dce3          	bge	a5,a4,21c0 <exitwait+0x12>
    }
  }
}
    228c:	0001                	nop
    228e:	0001                	nop
    2290:	70a2                	ld	ra,40(sp)
    2292:	7402                	ld	s0,32(sp)
    2294:	6145                	addi	sp,sp,48
    2296:	8082                	ret

0000000000002298 <reparent>:
// try to find races in the reparenting
// code that handles a parent exiting
// when it still has live children.
void
reparent(char *s)
{
    2298:	7179                	addi	sp,sp,-48
    229a:	f406                	sd	ra,40(sp)
    229c:	f022                	sd	s0,32(sp)
    229e:	1800                	addi	s0,sp,48
    22a0:	fca43c23          	sd	a0,-40(s0)
  int master_pid = getpid();
    22a4:	00005097          	auipc	ra,0x5
    22a8:	14c080e7          	jalr	332(ra) # 73f0 <getpid>
    22ac:	87aa                	mv	a5,a0
    22ae:	fef42423          	sw	a5,-24(s0)
  for(int i = 0; i < 200; i++){
    22b2:	fe042623          	sw	zero,-20(s0)
    22b6:	a86d                	j	2370 <reparent+0xd8>
    int pid = fork();
    22b8:	00005097          	auipc	ra,0x5
    22bc:	0b0080e7          	jalr	176(ra) # 7368 <fork>
    22c0:	87aa                	mv	a5,a0
    22c2:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    22c6:	fe442783          	lw	a5,-28(s0)
    22ca:	2781                	sext.w	a5,a5
    22cc:	0207d163          	bgez	a5,22ee <reparent+0x56>
      printf("%s: fork failed\n", s);
    22d0:	fd843583          	ld	a1,-40(s0)
    22d4:	00006517          	auipc	a0,0x6
    22d8:	f0c50513          	addi	a0,a0,-244 # 81e0 <cv_init+0x45a>
    22dc:	00005097          	auipc	ra,0x5
    22e0:	5cc080e7          	jalr	1484(ra) # 78a8 <printf>
      exit(1);
    22e4:	4505                	li	a0,1
    22e6:	00005097          	auipc	ra,0x5
    22ea:	08a080e7          	jalr	138(ra) # 7370 <exit>
    }
    if(pid){
    22ee:	fe442783          	lw	a5,-28(s0)
    22f2:	2781                	sext.w	a5,a5
    22f4:	cf85                	beqz	a5,232c <reparent+0x94>
      if(wait(0) != pid){
    22f6:	4501                	li	a0,0
    22f8:	00005097          	auipc	ra,0x5
    22fc:	080080e7          	jalr	128(ra) # 7378 <wait>
    2300:	87aa                	mv	a5,a0
    2302:	873e                	mv	a4,a5
    2304:	fe442783          	lw	a5,-28(s0)
    2308:	2781                	sext.w	a5,a5
    230a:	04e78e63          	beq	a5,a4,2366 <reparent+0xce>
        printf("%s: wait wrong pid\n", s);
    230e:	fd843583          	ld	a1,-40(s0)
    2312:	00006517          	auipc	a0,0x6
    2316:	46650513          	addi	a0,a0,1126 # 8778 <cv_init+0x9f2>
    231a:	00005097          	auipc	ra,0x5
    231e:	58e080e7          	jalr	1422(ra) # 78a8 <printf>
        exit(1);
    2322:	4505                	li	a0,1
    2324:	00005097          	auipc	ra,0x5
    2328:	04c080e7          	jalr	76(ra) # 7370 <exit>
      }
    } else {
      int pid2 = fork();
    232c:	00005097          	auipc	ra,0x5
    2330:	03c080e7          	jalr	60(ra) # 7368 <fork>
    2334:	87aa                	mv	a5,a0
    2336:	fef42023          	sw	a5,-32(s0)
      if(pid2 < 0){
    233a:	fe042783          	lw	a5,-32(s0)
    233e:	2781                	sext.w	a5,a5
    2340:	0007de63          	bgez	a5,235c <reparent+0xc4>
        kill(master_pid);
    2344:	fe842783          	lw	a5,-24(s0)
    2348:	853e                	mv	a0,a5
    234a:	00005097          	auipc	ra,0x5
    234e:	056080e7          	jalr	86(ra) # 73a0 <kill>
        exit(1);
    2352:	4505                	li	a0,1
    2354:	00005097          	auipc	ra,0x5
    2358:	01c080e7          	jalr	28(ra) # 7370 <exit>
      }
      exit(0);
    235c:	4501                	li	a0,0
    235e:	00005097          	auipc	ra,0x5
    2362:	012080e7          	jalr	18(ra) # 7370 <exit>
  for(int i = 0; i < 200; i++){
    2366:	fec42783          	lw	a5,-20(s0)
    236a:	2785                	addiw	a5,a5,1
    236c:	fef42623          	sw	a5,-20(s0)
    2370:	fec42783          	lw	a5,-20(s0)
    2374:	0007871b          	sext.w	a4,a5
    2378:	0c700793          	li	a5,199
    237c:	f2e7dee3          	bge	a5,a4,22b8 <reparent+0x20>
    }
  }
  exit(0);
    2380:	4501                	li	a0,0
    2382:	00005097          	auipc	ra,0x5
    2386:	fee080e7          	jalr	-18(ra) # 7370 <exit>

000000000000238a <twochildren>:
}

// what if two children exit() at the same time?
void
twochildren(char *s)
{
    238a:	7179                	addi	sp,sp,-48
    238c:	f406                	sd	ra,40(sp)
    238e:	f022                	sd	s0,32(sp)
    2390:	1800                	addi	s0,sp,48
    2392:	fca43c23          	sd	a0,-40(s0)
  for(int i = 0; i < 1000; i++){
    2396:	fe042623          	sw	zero,-20(s0)
    239a:	a845                	j	244a <twochildren+0xc0>
    int pid1 = fork();
    239c:	00005097          	auipc	ra,0x5
    23a0:	fcc080e7          	jalr	-52(ra) # 7368 <fork>
    23a4:	87aa                	mv	a5,a0
    23a6:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    23aa:	fe842783          	lw	a5,-24(s0)
    23ae:	2781                	sext.w	a5,a5
    23b0:	0207d163          	bgez	a5,23d2 <twochildren+0x48>
      printf("%s: fork failed\n", s);
    23b4:	fd843583          	ld	a1,-40(s0)
    23b8:	00006517          	auipc	a0,0x6
    23bc:	e2850513          	addi	a0,a0,-472 # 81e0 <cv_init+0x45a>
    23c0:	00005097          	auipc	ra,0x5
    23c4:	4e8080e7          	jalr	1256(ra) # 78a8 <printf>
      exit(1);
    23c8:	4505                	li	a0,1
    23ca:	00005097          	auipc	ra,0x5
    23ce:	fa6080e7          	jalr	-90(ra) # 7370 <exit>
    }
    if(pid1 == 0){
    23d2:	fe842783          	lw	a5,-24(s0)
    23d6:	2781                	sext.w	a5,a5
    23d8:	e791                	bnez	a5,23e4 <twochildren+0x5a>
      exit(0);
    23da:	4501                	li	a0,0
    23dc:	00005097          	auipc	ra,0x5
    23e0:	f94080e7          	jalr	-108(ra) # 7370 <exit>
    } else {
      int pid2 = fork();
    23e4:	00005097          	auipc	ra,0x5
    23e8:	f84080e7          	jalr	-124(ra) # 7368 <fork>
    23ec:	87aa                	mv	a5,a0
    23ee:	fef42223          	sw	a5,-28(s0)
      if(pid2 < 0){
    23f2:	fe442783          	lw	a5,-28(s0)
    23f6:	2781                	sext.w	a5,a5
    23f8:	0207d163          	bgez	a5,241a <twochildren+0x90>
        printf("%s: fork failed\n", s);
    23fc:	fd843583          	ld	a1,-40(s0)
    2400:	00006517          	auipc	a0,0x6
    2404:	de050513          	addi	a0,a0,-544 # 81e0 <cv_init+0x45a>
    2408:	00005097          	auipc	ra,0x5
    240c:	4a0080e7          	jalr	1184(ra) # 78a8 <printf>
        exit(1);
    2410:	4505                	li	a0,1
    2412:	00005097          	auipc	ra,0x5
    2416:	f5e080e7          	jalr	-162(ra) # 7370 <exit>
      }
      if(pid2 == 0){
    241a:	fe442783          	lw	a5,-28(s0)
    241e:	2781                	sext.w	a5,a5
    2420:	e791                	bnez	a5,242c <twochildren+0xa2>
        exit(0);
    2422:	4501                	li	a0,0
    2424:	00005097          	auipc	ra,0x5
    2428:	f4c080e7          	jalr	-180(ra) # 7370 <exit>
      } else {
        wait(0);
    242c:	4501                	li	a0,0
    242e:	00005097          	auipc	ra,0x5
    2432:	f4a080e7          	jalr	-182(ra) # 7378 <wait>
        wait(0);
    2436:	4501                	li	a0,0
    2438:	00005097          	auipc	ra,0x5
    243c:	f40080e7          	jalr	-192(ra) # 7378 <wait>
  for(int i = 0; i < 1000; i++){
    2440:	fec42783          	lw	a5,-20(s0)
    2444:	2785                	addiw	a5,a5,1
    2446:	fef42623          	sw	a5,-20(s0)
    244a:	fec42783          	lw	a5,-20(s0)
    244e:	0007871b          	sext.w	a4,a5
    2452:	3e700793          	li	a5,999
    2456:	f4e7d3e3          	bge	a5,a4,239c <twochildren+0x12>
      }
    }
  }
}
    245a:	0001                	nop
    245c:	0001                	nop
    245e:	70a2                	ld	ra,40(sp)
    2460:	7402                	ld	s0,32(sp)
    2462:	6145                	addi	sp,sp,48
    2464:	8082                	ret

0000000000002466 <forkfork>:

// concurrent forks to try to expose locking bugs.
void
forkfork(char *s)
{
    2466:	7139                	addi	sp,sp,-64
    2468:	fc06                	sd	ra,56(sp)
    246a:	f822                	sd	s0,48(sp)
    246c:	0080                	addi	s0,sp,64
    246e:	fca43423          	sd	a0,-56(s0)
  enum { N=2 };
  
  for(int i = 0; i < N; i++){
    2472:	fe042623          	sw	zero,-20(s0)
    2476:	a84d                	j	2528 <forkfork+0xc2>
    int pid = fork();
    2478:	00005097          	auipc	ra,0x5
    247c:	ef0080e7          	jalr	-272(ra) # 7368 <fork>
    2480:	87aa                	mv	a5,a0
    2482:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    2486:	fe042783          	lw	a5,-32(s0)
    248a:	2781                	sext.w	a5,a5
    248c:	0207d163          	bgez	a5,24ae <forkfork+0x48>
      printf("%s: fork failed", s);
    2490:	fc843583          	ld	a1,-56(s0)
    2494:	00006517          	auipc	a0,0x6
    2498:	28450513          	addi	a0,a0,644 # 8718 <cv_init+0x992>
    249c:	00005097          	auipc	ra,0x5
    24a0:	40c080e7          	jalr	1036(ra) # 78a8 <printf>
      exit(1);
    24a4:	4505                	li	a0,1
    24a6:	00005097          	auipc	ra,0x5
    24aa:	eca080e7          	jalr	-310(ra) # 7370 <exit>
    }
    if(pid == 0){
    24ae:	fe042783          	lw	a5,-32(s0)
    24b2:	2781                	sext.w	a5,a5
    24b4:	e7ad                	bnez	a5,251e <forkfork+0xb8>
      for(int j = 0; j < 200; j++){
    24b6:	fe042423          	sw	zero,-24(s0)
    24ba:	a0a9                	j	2504 <forkfork+0x9e>
        int pid1 = fork();
    24bc:	00005097          	auipc	ra,0x5
    24c0:	eac080e7          	jalr	-340(ra) # 7368 <fork>
    24c4:	87aa                	mv	a5,a0
    24c6:	fcf42e23          	sw	a5,-36(s0)
        if(pid1 < 0){
    24ca:	fdc42783          	lw	a5,-36(s0)
    24ce:	2781                	sext.w	a5,a5
    24d0:	0007d763          	bgez	a5,24de <forkfork+0x78>
          exit(1);
    24d4:	4505                	li	a0,1
    24d6:	00005097          	auipc	ra,0x5
    24da:	e9a080e7          	jalr	-358(ra) # 7370 <exit>
        }
        if(pid1 == 0){
    24de:	fdc42783          	lw	a5,-36(s0)
    24e2:	2781                	sext.w	a5,a5
    24e4:	e791                	bnez	a5,24f0 <forkfork+0x8a>
          exit(0);
    24e6:	4501                	li	a0,0
    24e8:	00005097          	auipc	ra,0x5
    24ec:	e88080e7          	jalr	-376(ra) # 7370 <exit>
        }
        wait(0);
    24f0:	4501                	li	a0,0
    24f2:	00005097          	auipc	ra,0x5
    24f6:	e86080e7          	jalr	-378(ra) # 7378 <wait>
      for(int j = 0; j < 200; j++){
    24fa:	fe842783          	lw	a5,-24(s0)
    24fe:	2785                	addiw	a5,a5,1
    2500:	fef42423          	sw	a5,-24(s0)
    2504:	fe842783          	lw	a5,-24(s0)
    2508:	0007871b          	sext.w	a4,a5
    250c:	0c700793          	li	a5,199
    2510:	fae7d6e3          	bge	a5,a4,24bc <forkfork+0x56>
      }
      exit(0);
    2514:	4501                	li	a0,0
    2516:	00005097          	auipc	ra,0x5
    251a:	e5a080e7          	jalr	-422(ra) # 7370 <exit>
  for(int i = 0; i < N; i++){
    251e:	fec42783          	lw	a5,-20(s0)
    2522:	2785                	addiw	a5,a5,1
    2524:	fef42623          	sw	a5,-20(s0)
    2528:	fec42783          	lw	a5,-20(s0)
    252c:	0007871b          	sext.w	a4,a5
    2530:	4785                	li	a5,1
    2532:	f4e7d3e3          	bge	a5,a4,2478 <forkfork+0x12>
    }
  }

  int xstatus;
  for(int i = 0; i < N; i++){
    2536:	fe042223          	sw	zero,-28(s0)
    253a:	a83d                	j	2578 <forkfork+0x112>
    wait(&xstatus);
    253c:	fd840793          	addi	a5,s0,-40
    2540:	853e                	mv	a0,a5
    2542:	00005097          	auipc	ra,0x5
    2546:	e36080e7          	jalr	-458(ra) # 7378 <wait>
    if(xstatus != 0) {
    254a:	fd842783          	lw	a5,-40(s0)
    254e:	c385                	beqz	a5,256e <forkfork+0x108>
      printf("%s: fork in child failed", s);
    2550:	fc843583          	ld	a1,-56(s0)
    2554:	00006517          	auipc	a0,0x6
    2558:	25c50513          	addi	a0,a0,604 # 87b0 <cv_init+0xa2a>
    255c:	00005097          	auipc	ra,0x5
    2560:	34c080e7          	jalr	844(ra) # 78a8 <printf>
      exit(1);
    2564:	4505                	li	a0,1
    2566:	00005097          	auipc	ra,0x5
    256a:	e0a080e7          	jalr	-502(ra) # 7370 <exit>
  for(int i = 0; i < N; i++){
    256e:	fe442783          	lw	a5,-28(s0)
    2572:	2785                	addiw	a5,a5,1
    2574:	fef42223          	sw	a5,-28(s0)
    2578:	fe442783          	lw	a5,-28(s0)
    257c:	0007871b          	sext.w	a4,a5
    2580:	4785                	li	a5,1
    2582:	fae7dde3          	bge	a5,a4,253c <forkfork+0xd6>
    }
  }
}
    2586:	0001                	nop
    2588:	0001                	nop
    258a:	70e2                	ld	ra,56(sp)
    258c:	7442                	ld	s0,48(sp)
    258e:	6121                	addi	sp,sp,64
    2590:	8082                	ret

0000000000002592 <forkforkfork>:

void
forkforkfork(char *s)
{
    2592:	7179                	addi	sp,sp,-48
    2594:	f406                	sd	ra,40(sp)
    2596:	f022                	sd	s0,32(sp)
    2598:	1800                	addi	s0,sp,48
    259a:	fca43c23          	sd	a0,-40(s0)
  unlink("stopforking");
    259e:	00006517          	auipc	a0,0x6
    25a2:	23250513          	addi	a0,a0,562 # 87d0 <cv_init+0xa4a>
    25a6:	00005097          	auipc	ra,0x5
    25aa:	e1a080e7          	jalr	-486(ra) # 73c0 <unlink>

  int pid = fork();
    25ae:	00005097          	auipc	ra,0x5
    25b2:	dba080e7          	jalr	-582(ra) # 7368 <fork>
    25b6:	87aa                	mv	a5,a0
    25b8:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    25bc:	fec42783          	lw	a5,-20(s0)
    25c0:	2781                	sext.w	a5,a5
    25c2:	0207d163          	bgez	a5,25e4 <forkforkfork+0x52>
    printf("%s: fork failed", s);
    25c6:	fd843583          	ld	a1,-40(s0)
    25ca:	00006517          	auipc	a0,0x6
    25ce:	14e50513          	addi	a0,a0,334 # 8718 <cv_init+0x992>
    25d2:	00005097          	auipc	ra,0x5
    25d6:	2d6080e7          	jalr	726(ra) # 78a8 <printf>
    exit(1);
    25da:	4505                	li	a0,1
    25dc:	00005097          	auipc	ra,0x5
    25e0:	d94080e7          	jalr	-620(ra) # 7370 <exit>
  }
  if(pid == 0){
    25e4:	fec42783          	lw	a5,-20(s0)
    25e8:	2781                	sext.w	a5,a5
    25ea:	efb9                	bnez	a5,2648 <forkforkfork+0xb6>
    while(1){
      int fd = open("stopforking", 0);
    25ec:	4581                	li	a1,0
    25ee:	00006517          	auipc	a0,0x6
    25f2:	1e250513          	addi	a0,a0,482 # 87d0 <cv_init+0xa4a>
    25f6:	00005097          	auipc	ra,0x5
    25fa:	dba080e7          	jalr	-582(ra) # 73b0 <open>
    25fe:	87aa                	mv	a5,a0
    2600:	fef42423          	sw	a5,-24(s0)
      if(fd >= 0){
    2604:	fe842783          	lw	a5,-24(s0)
    2608:	2781                	sext.w	a5,a5
    260a:	0007c763          	bltz	a5,2618 <forkforkfork+0x86>
        exit(0);
    260e:	4501                	li	a0,0
    2610:	00005097          	auipc	ra,0x5
    2614:	d60080e7          	jalr	-672(ra) # 7370 <exit>
      }
      if(fork() < 0){
    2618:	00005097          	auipc	ra,0x5
    261c:	d50080e7          	jalr	-688(ra) # 7368 <fork>
    2620:	87aa                	mv	a5,a0
    2622:	fc07d5e3          	bgez	a5,25ec <forkforkfork+0x5a>
        close(open("stopforking", O_CREATE|O_RDWR));
    2626:	20200593          	li	a1,514
    262a:	00006517          	auipc	a0,0x6
    262e:	1a650513          	addi	a0,a0,422 # 87d0 <cv_init+0xa4a>
    2632:	00005097          	auipc	ra,0x5
    2636:	d7e080e7          	jalr	-642(ra) # 73b0 <open>
    263a:	87aa                	mv	a5,a0
    263c:	853e                	mv	a0,a5
    263e:	00005097          	auipc	ra,0x5
    2642:	d5a080e7          	jalr	-678(ra) # 7398 <close>
    while(1){
    2646:	b75d                	j	25ec <forkforkfork+0x5a>
    }

    exit(0);
  }

  sleep(20); // two seconds
    2648:	4551                	li	a0,20
    264a:	00005097          	auipc	ra,0x5
    264e:	db6080e7          	jalr	-586(ra) # 7400 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    2652:	20200593          	li	a1,514
    2656:	00006517          	auipc	a0,0x6
    265a:	17a50513          	addi	a0,a0,378 # 87d0 <cv_init+0xa4a>
    265e:	00005097          	auipc	ra,0x5
    2662:	d52080e7          	jalr	-686(ra) # 73b0 <open>
    2666:	87aa                	mv	a5,a0
    2668:	853e                	mv	a0,a5
    266a:	00005097          	auipc	ra,0x5
    266e:	d2e080e7          	jalr	-722(ra) # 7398 <close>
  wait(0);
    2672:	4501                	li	a0,0
    2674:	00005097          	auipc	ra,0x5
    2678:	d04080e7          	jalr	-764(ra) # 7378 <wait>
  sleep(10); // one second
    267c:	4529                	li	a0,10
    267e:	00005097          	auipc	ra,0x5
    2682:	d82080e7          	jalr	-638(ra) # 7400 <sleep>
}
    2686:	0001                	nop
    2688:	70a2                	ld	ra,40(sp)
    268a:	7402                	ld	s0,32(sp)
    268c:	6145                	addi	sp,sp,48
    268e:	8082                	ret

0000000000002690 <reparent2>:
// deadlocks against init's wait()? also used to trigger a "panic:
// release" due to exit() releasing a different p->parent->lock than
// it acquired.
void
reparent2(char *s)
{
    2690:	7179                	addi	sp,sp,-48
    2692:	f406                	sd	ra,40(sp)
    2694:	f022                	sd	s0,32(sp)
    2696:	1800                	addi	s0,sp,48
    2698:	fca43c23          	sd	a0,-40(s0)
  for(int i = 0; i < 800; i++){
    269c:	fe042623          	sw	zero,-20(s0)
    26a0:	a0ad                	j	270a <reparent2+0x7a>
    int pid1 = fork();
    26a2:	00005097          	auipc	ra,0x5
    26a6:	cc6080e7          	jalr	-826(ra) # 7368 <fork>
    26aa:	87aa                	mv	a5,a0
    26ac:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    26b0:	fe842783          	lw	a5,-24(s0)
    26b4:	2781                	sext.w	a5,a5
    26b6:	0007df63          	bgez	a5,26d4 <reparent2+0x44>
      printf("fork failed\n");
    26ba:	00006517          	auipc	a0,0x6
    26be:	8f650513          	addi	a0,a0,-1802 # 7fb0 <cv_init+0x22a>
    26c2:	00005097          	auipc	ra,0x5
    26c6:	1e6080e7          	jalr	486(ra) # 78a8 <printf>
      exit(1);
    26ca:	4505                	li	a0,1
    26cc:	00005097          	auipc	ra,0x5
    26d0:	ca4080e7          	jalr	-860(ra) # 7370 <exit>
    }
    if(pid1 == 0){
    26d4:	fe842783          	lw	a5,-24(s0)
    26d8:	2781                	sext.w	a5,a5
    26da:	ef91                	bnez	a5,26f6 <reparent2+0x66>
      fork();
    26dc:	00005097          	auipc	ra,0x5
    26e0:	c8c080e7          	jalr	-884(ra) # 7368 <fork>
      fork();
    26e4:	00005097          	auipc	ra,0x5
    26e8:	c84080e7          	jalr	-892(ra) # 7368 <fork>
      exit(0);
    26ec:	4501                	li	a0,0
    26ee:	00005097          	auipc	ra,0x5
    26f2:	c82080e7          	jalr	-894(ra) # 7370 <exit>
    }
    wait(0);
    26f6:	4501                	li	a0,0
    26f8:	00005097          	auipc	ra,0x5
    26fc:	c80080e7          	jalr	-896(ra) # 7378 <wait>
  for(int i = 0; i < 800; i++){
    2700:	fec42783          	lw	a5,-20(s0)
    2704:	2785                	addiw	a5,a5,1
    2706:	fef42623          	sw	a5,-20(s0)
    270a:	fec42783          	lw	a5,-20(s0)
    270e:	0007871b          	sext.w	a4,a5
    2712:	31f00793          	li	a5,799
    2716:	f8e7d6e3          	bge	a5,a4,26a2 <reparent2+0x12>
  }

  exit(0);
    271a:	4501                	li	a0,0
    271c:	00005097          	auipc	ra,0x5
    2720:	c54080e7          	jalr	-940(ra) # 7370 <exit>

0000000000002724 <mem>:
}

// allocate all mem, free it, and allocate again
void
mem(char *s)
{
    2724:	7139                	addi	sp,sp,-64
    2726:	fc06                	sd	ra,56(sp)
    2728:	f822                	sd	s0,48(sp)
    272a:	0080                	addi	s0,sp,64
    272c:	fca43423          	sd	a0,-56(s0)
  void *m1, *m2;
  int pid;

  if((pid = fork()) == 0){
    2730:	00005097          	auipc	ra,0x5
    2734:	c38080e7          	jalr	-968(ra) # 7368 <fork>
    2738:	87aa                	mv	a5,a0
    273a:	fef42223          	sw	a5,-28(s0)
    273e:	fe442783          	lw	a5,-28(s0)
    2742:	2781                	sext.w	a5,a5
    2744:	e3c5                	bnez	a5,27e4 <mem+0xc0>
    m1 = 0;
    2746:	fe043423          	sd	zero,-24(s0)
    while((m2 = malloc(10001)) != 0){
    274a:	a811                	j	275e <mem+0x3a>
      *(char**)m2 = m1;
    274c:	fd843783          	ld	a5,-40(s0)
    2750:	fe843703          	ld	a4,-24(s0)
    2754:	e398                	sd	a4,0(a5)
      m1 = m2;
    2756:	fd843783          	ld	a5,-40(s0)
    275a:	fef43423          	sd	a5,-24(s0)
    while((m2 = malloc(10001)) != 0){
    275e:	6789                	lui	a5,0x2
    2760:	71178513          	addi	a0,a5,1809 # 2711 <reparent2+0x81>
    2764:	00005097          	auipc	ra,0x5
    2768:	336080e7          	jalr	822(ra) # 7a9a <malloc>
    276c:	fca43c23          	sd	a0,-40(s0)
    2770:	fd843783          	ld	a5,-40(s0)
    2774:	ffe1                	bnez	a5,274c <mem+0x28>
    }
    while(m1){
    2776:	a005                	j	2796 <mem+0x72>
      m2 = *(char**)m1;
    2778:	fe843783          	ld	a5,-24(s0)
    277c:	639c                	ld	a5,0(a5)
    277e:	fcf43c23          	sd	a5,-40(s0)
      free(m1);
    2782:	fe843503          	ld	a0,-24(s0)
    2786:	00005097          	auipc	ra,0x5
    278a:	172080e7          	jalr	370(ra) # 78f8 <free>
      m1 = m2;
    278e:	fd843783          	ld	a5,-40(s0)
    2792:	fef43423          	sd	a5,-24(s0)
    while(m1){
    2796:	fe843783          	ld	a5,-24(s0)
    279a:	fff9                	bnez	a5,2778 <mem+0x54>
    }
    m1 = malloc(1024*20);
    279c:	6515                	lui	a0,0x5
    279e:	00005097          	auipc	ra,0x5
    27a2:	2fc080e7          	jalr	764(ra) # 7a9a <malloc>
    27a6:	fea43423          	sd	a0,-24(s0)
    if(m1 == 0){
    27aa:	fe843783          	ld	a5,-24(s0)
    27ae:	e385                	bnez	a5,27ce <mem+0xaa>
      printf("couldn't allocate mem?!!\n", s);
    27b0:	fc843583          	ld	a1,-56(s0)
    27b4:	00006517          	auipc	a0,0x6
    27b8:	02c50513          	addi	a0,a0,44 # 87e0 <cv_init+0xa5a>
    27bc:	00005097          	auipc	ra,0x5
    27c0:	0ec080e7          	jalr	236(ra) # 78a8 <printf>
      exit(1);
    27c4:	4505                	li	a0,1
    27c6:	00005097          	auipc	ra,0x5
    27ca:	baa080e7          	jalr	-1110(ra) # 7370 <exit>
    }
    free(m1);
    27ce:	fe843503          	ld	a0,-24(s0)
    27d2:	00005097          	auipc	ra,0x5
    27d6:	126080e7          	jalr	294(ra) # 78f8 <free>
    exit(0);
    27da:	4501                	li	a0,0
    27dc:	00005097          	auipc	ra,0x5
    27e0:	b94080e7          	jalr	-1132(ra) # 7370 <exit>
  } else {
    int xstatus;
    wait(&xstatus);
    27e4:	fd440793          	addi	a5,s0,-44
    27e8:	853e                	mv	a0,a5
    27ea:	00005097          	auipc	ra,0x5
    27ee:	b8e080e7          	jalr	-1138(ra) # 7378 <wait>
    if(xstatus == -1){
    27f2:	fd442783          	lw	a5,-44(s0)
    27f6:	873e                	mv	a4,a5
    27f8:	57fd                	li	a5,-1
    27fa:	00f71763          	bne	a4,a5,2808 <mem+0xe4>
      // probably page fault, so might be lazy lab,
      // so OK.
      exit(0);
    27fe:	4501                	li	a0,0
    2800:	00005097          	auipc	ra,0x5
    2804:	b70080e7          	jalr	-1168(ra) # 7370 <exit>
    }
    exit(xstatus);
    2808:	fd442783          	lw	a5,-44(s0)
    280c:	853e                	mv	a0,a5
    280e:	00005097          	auipc	ra,0x5
    2812:	b62080e7          	jalr	-1182(ra) # 7370 <exit>

0000000000002816 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(char *s)
{
    2816:	715d                	addi	sp,sp,-80
    2818:	e486                	sd	ra,72(sp)
    281a:	e0a2                	sd	s0,64(sp)
    281c:	0880                	addi	s0,sp,80
    281e:	faa43c23          	sd	a0,-72(s0)
  int fd, pid, i, n, nc, np;
  enum { N = 1000, SZ=10};
  char buf[SZ];

  unlink("sharedfd");
    2822:	00006517          	auipc	a0,0x6
    2826:	fde50513          	addi	a0,a0,-34 # 8800 <cv_init+0xa7a>
    282a:	00005097          	auipc	ra,0x5
    282e:	b96080e7          	jalr	-1130(ra) # 73c0 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    2832:	20200593          	li	a1,514
    2836:	00006517          	auipc	a0,0x6
    283a:	fca50513          	addi	a0,a0,-54 # 8800 <cv_init+0xa7a>
    283e:	00005097          	auipc	ra,0x5
    2842:	b72080e7          	jalr	-1166(ra) # 73b0 <open>
    2846:	87aa                	mv	a5,a0
    2848:	fef42023          	sw	a5,-32(s0)
  if(fd < 0){
    284c:	fe042783          	lw	a5,-32(s0)
    2850:	2781                	sext.w	a5,a5
    2852:	0207d163          	bgez	a5,2874 <sharedfd+0x5e>
    printf("%s: cannot open sharedfd for writing", s);
    2856:	fb843583          	ld	a1,-72(s0)
    285a:	00006517          	auipc	a0,0x6
    285e:	fb650513          	addi	a0,a0,-74 # 8810 <cv_init+0xa8a>
    2862:	00005097          	auipc	ra,0x5
    2866:	046080e7          	jalr	70(ra) # 78a8 <printf>
    exit(1);
    286a:	4505                	li	a0,1
    286c:	00005097          	auipc	ra,0x5
    2870:	b04080e7          	jalr	-1276(ra) # 7370 <exit>
  }
  pid = fork();
    2874:	00005097          	auipc	ra,0x5
    2878:	af4080e7          	jalr	-1292(ra) # 7368 <fork>
    287c:	87aa                	mv	a5,a0
    287e:	fcf42e23          	sw	a5,-36(s0)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    2882:	fdc42783          	lw	a5,-36(s0)
    2886:	2781                	sext.w	a5,a5
    2888:	e781                	bnez	a5,2890 <sharedfd+0x7a>
    288a:	06300793          	li	a5,99
    288e:	a019                	j	2894 <sharedfd+0x7e>
    2890:	07000793          	li	a5,112
    2894:	fc840713          	addi	a4,s0,-56
    2898:	4629                	li	a2,10
    289a:	85be                	mv	a1,a5
    289c:	853a                	mv	a0,a4
    289e:	00004097          	auipc	ra,0x4
    28a2:	726080e7          	jalr	1830(ra) # 6fc4 <memset>
  for(i = 0; i < N; i++){
    28a6:	fe042623          	sw	zero,-20(s0)
    28aa:	a0a9                	j	28f4 <sharedfd+0xde>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    28ac:	fc840713          	addi	a4,s0,-56
    28b0:	fe042783          	lw	a5,-32(s0)
    28b4:	4629                	li	a2,10
    28b6:	85ba                	mv	a1,a4
    28b8:	853e                	mv	a0,a5
    28ba:	00005097          	auipc	ra,0x5
    28be:	ad6080e7          	jalr	-1322(ra) # 7390 <write>
    28c2:	87aa                	mv	a5,a0
    28c4:	873e                	mv	a4,a5
    28c6:	47a9                	li	a5,10
    28c8:	02f70163          	beq	a4,a5,28ea <sharedfd+0xd4>
      printf("%s: write sharedfd failed\n", s);
    28cc:	fb843583          	ld	a1,-72(s0)
    28d0:	00006517          	auipc	a0,0x6
    28d4:	f6850513          	addi	a0,a0,-152 # 8838 <cv_init+0xab2>
    28d8:	00005097          	auipc	ra,0x5
    28dc:	fd0080e7          	jalr	-48(ra) # 78a8 <printf>
      exit(1);
    28e0:	4505                	li	a0,1
    28e2:	00005097          	auipc	ra,0x5
    28e6:	a8e080e7          	jalr	-1394(ra) # 7370 <exit>
  for(i = 0; i < N; i++){
    28ea:	fec42783          	lw	a5,-20(s0)
    28ee:	2785                	addiw	a5,a5,1
    28f0:	fef42623          	sw	a5,-20(s0)
    28f4:	fec42783          	lw	a5,-20(s0)
    28f8:	0007871b          	sext.w	a4,a5
    28fc:	3e700793          	li	a5,999
    2900:	fae7d6e3          	bge	a5,a4,28ac <sharedfd+0x96>
    }
  }
  if(pid == 0) {
    2904:	fdc42783          	lw	a5,-36(s0)
    2908:	2781                	sext.w	a5,a5
    290a:	e791                	bnez	a5,2916 <sharedfd+0x100>
    exit(0);
    290c:	4501                	li	a0,0
    290e:	00005097          	auipc	ra,0x5
    2912:	a62080e7          	jalr	-1438(ra) # 7370 <exit>
  } else {
    int xstatus;
    wait(&xstatus);
    2916:	fc440793          	addi	a5,s0,-60
    291a:	853e                	mv	a0,a5
    291c:	00005097          	auipc	ra,0x5
    2920:	a5c080e7          	jalr	-1444(ra) # 7378 <wait>
    if(xstatus != 0)
    2924:	fc442783          	lw	a5,-60(s0)
    2928:	cb81                	beqz	a5,2938 <sharedfd+0x122>
      exit(xstatus);
    292a:	fc442783          	lw	a5,-60(s0)
    292e:	853e                	mv	a0,a5
    2930:	00005097          	auipc	ra,0x5
    2934:	a40080e7          	jalr	-1472(ra) # 7370 <exit>
  }
  
  close(fd);
    2938:	fe042783          	lw	a5,-32(s0)
    293c:	853e                	mv	a0,a5
    293e:	00005097          	auipc	ra,0x5
    2942:	a5a080e7          	jalr	-1446(ra) # 7398 <close>
  fd = open("sharedfd", 0);
    2946:	4581                	li	a1,0
    2948:	00006517          	auipc	a0,0x6
    294c:	eb850513          	addi	a0,a0,-328 # 8800 <cv_init+0xa7a>
    2950:	00005097          	auipc	ra,0x5
    2954:	a60080e7          	jalr	-1440(ra) # 73b0 <open>
    2958:	87aa                	mv	a5,a0
    295a:	fef42023          	sw	a5,-32(s0)
  if(fd < 0){
    295e:	fe042783          	lw	a5,-32(s0)
    2962:	2781                	sext.w	a5,a5
    2964:	0207d163          	bgez	a5,2986 <sharedfd+0x170>
    printf("%s: cannot open sharedfd for reading\n", s);
    2968:	fb843583          	ld	a1,-72(s0)
    296c:	00006517          	auipc	a0,0x6
    2970:	eec50513          	addi	a0,a0,-276 # 8858 <cv_init+0xad2>
    2974:	00005097          	auipc	ra,0x5
    2978:	f34080e7          	jalr	-204(ra) # 78a8 <printf>
    exit(1);
    297c:	4505                	li	a0,1
    297e:	00005097          	auipc	ra,0x5
    2982:	9f2080e7          	jalr	-1550(ra) # 7370 <exit>
  }
  nc = np = 0;
    2986:	fe042223          	sw	zero,-28(s0)
    298a:	fe442783          	lw	a5,-28(s0)
    298e:	fef42423          	sw	a5,-24(s0)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    2992:	a8b9                	j	29f0 <sharedfd+0x1da>
    for(i = 0; i < sizeof(buf); i++){
    2994:	fe042623          	sw	zero,-20(s0)
    2998:	a0b1                	j	29e4 <sharedfd+0x1ce>
      if(buf[i] == 'c')
    299a:	fec42783          	lw	a5,-20(s0)
    299e:	17c1                	addi	a5,a5,-16
    29a0:	97a2                	add	a5,a5,s0
    29a2:	fd87c783          	lbu	a5,-40(a5)
    29a6:	873e                	mv	a4,a5
    29a8:	06300793          	li	a5,99
    29ac:	00f71763          	bne	a4,a5,29ba <sharedfd+0x1a4>
        nc++;
    29b0:	fe842783          	lw	a5,-24(s0)
    29b4:	2785                	addiw	a5,a5,1
    29b6:	fef42423          	sw	a5,-24(s0)
      if(buf[i] == 'p')
    29ba:	fec42783          	lw	a5,-20(s0)
    29be:	17c1                	addi	a5,a5,-16
    29c0:	97a2                	add	a5,a5,s0
    29c2:	fd87c783          	lbu	a5,-40(a5)
    29c6:	873e                	mv	a4,a5
    29c8:	07000793          	li	a5,112
    29cc:	00f71763          	bne	a4,a5,29da <sharedfd+0x1c4>
        np++;
    29d0:	fe442783          	lw	a5,-28(s0)
    29d4:	2785                	addiw	a5,a5,1
    29d6:	fef42223          	sw	a5,-28(s0)
    for(i = 0; i < sizeof(buf); i++){
    29da:	fec42783          	lw	a5,-20(s0)
    29de:	2785                	addiw	a5,a5,1
    29e0:	fef42623          	sw	a5,-20(s0)
    29e4:	fec42783          	lw	a5,-20(s0)
    29e8:	873e                	mv	a4,a5
    29ea:	47a5                	li	a5,9
    29ec:	fae7f7e3          	bgeu	a5,a4,299a <sharedfd+0x184>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    29f0:	fc840713          	addi	a4,s0,-56
    29f4:	fe042783          	lw	a5,-32(s0)
    29f8:	4629                	li	a2,10
    29fa:	85ba                	mv	a1,a4
    29fc:	853e                	mv	a0,a5
    29fe:	00005097          	auipc	ra,0x5
    2a02:	98a080e7          	jalr	-1654(ra) # 7388 <read>
    2a06:	87aa                	mv	a5,a0
    2a08:	fcf42c23          	sw	a5,-40(s0)
    2a0c:	fd842783          	lw	a5,-40(s0)
    2a10:	2781                	sext.w	a5,a5
    2a12:	f8f041e3          	bgtz	a5,2994 <sharedfd+0x17e>
    }
  }
  close(fd);
    2a16:	fe042783          	lw	a5,-32(s0)
    2a1a:	853e                	mv	a0,a5
    2a1c:	00005097          	auipc	ra,0x5
    2a20:	97c080e7          	jalr	-1668(ra) # 7398 <close>
  unlink("sharedfd");
    2a24:	00006517          	auipc	a0,0x6
    2a28:	ddc50513          	addi	a0,a0,-548 # 8800 <cv_init+0xa7a>
    2a2c:	00005097          	auipc	ra,0x5
    2a30:	994080e7          	jalr	-1644(ra) # 73c0 <unlink>
  if(nc == N*SZ && np == N*SZ){
    2a34:	fe842783          	lw	a5,-24(s0)
    2a38:	0007871b          	sext.w	a4,a5
    2a3c:	6789                	lui	a5,0x2
    2a3e:	71078793          	addi	a5,a5,1808 # 2710 <reparent2+0x80>
    2a42:	02f71063          	bne	a4,a5,2a62 <sharedfd+0x24c>
    2a46:	fe442783          	lw	a5,-28(s0)
    2a4a:	0007871b          	sext.w	a4,a5
    2a4e:	6789                	lui	a5,0x2
    2a50:	71078793          	addi	a5,a5,1808 # 2710 <reparent2+0x80>
    2a54:	00f71763          	bne	a4,a5,2a62 <sharedfd+0x24c>
    exit(0);
    2a58:	4501                	li	a0,0
    2a5a:	00005097          	auipc	ra,0x5
    2a5e:	916080e7          	jalr	-1770(ra) # 7370 <exit>
  } else {
    printf("%s: nc/np test fails\n", s);
    2a62:	fb843583          	ld	a1,-72(s0)
    2a66:	00006517          	auipc	a0,0x6
    2a6a:	e1a50513          	addi	a0,a0,-486 # 8880 <cv_init+0xafa>
    2a6e:	00005097          	auipc	ra,0x5
    2a72:	e3a080e7          	jalr	-454(ra) # 78a8 <printf>
    exit(1);
    2a76:	4505                	li	a0,1
    2a78:	00005097          	auipc	ra,0x5
    2a7c:	8f8080e7          	jalr	-1800(ra) # 7370 <exit>

0000000000002a80 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(char *s)
{
    2a80:	7159                	addi	sp,sp,-112
    2a82:	f486                	sd	ra,104(sp)
    2a84:	f0a2                	sd	s0,96(sp)
    2a86:	1880                	addi	s0,sp,112
    2a88:	f8a43c23          	sd	a0,-104(s0)
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    2a8c:	00006797          	auipc	a5,0x6
    2a90:	e7c78793          	addi	a5,a5,-388 # 8908 <cv_init+0xb82>
    2a94:	6390                	ld	a2,0(a5)
    2a96:	6794                	ld	a3,8(a5)
    2a98:	6b98                	ld	a4,16(a5)
    2a9a:	6f9c                	ld	a5,24(a5)
    2a9c:	fac43423          	sd	a2,-88(s0)
    2aa0:	fad43823          	sd	a3,-80(s0)
    2aa4:	fae43c23          	sd	a4,-72(s0)
    2aa8:	fcf43023          	sd	a5,-64(s0)
  char *fname;
  enum { N=12, NCHILD=4, SZ=500 };
  
  for(pi = 0; pi < NCHILD; pi++){
    2aac:	fe042023          	sw	zero,-32(s0)
    2ab0:	aa3d                	j	2bee <fourfiles+0x16e>
    fname = names[pi];
    2ab2:	fe042783          	lw	a5,-32(s0)
    2ab6:	078e                	slli	a5,a5,0x3
    2ab8:	17c1                	addi	a5,a5,-16
    2aba:	97a2                	add	a5,a5,s0
    2abc:	fb87b783          	ld	a5,-72(a5)
    2ac0:	fcf43c23          	sd	a5,-40(s0)
    unlink(fname);
    2ac4:	fd843503          	ld	a0,-40(s0)
    2ac8:	00005097          	auipc	ra,0x5
    2acc:	8f8080e7          	jalr	-1800(ra) # 73c0 <unlink>

    pid = fork();
    2ad0:	00005097          	auipc	ra,0x5
    2ad4:	898080e7          	jalr	-1896(ra) # 7368 <fork>
    2ad8:	87aa                	mv	a5,a0
    2ada:	fcf42623          	sw	a5,-52(s0)
    if(pid < 0){
    2ade:	fcc42783          	lw	a5,-52(s0)
    2ae2:	2781                	sext.w	a5,a5
    2ae4:	0207d163          	bgez	a5,2b06 <fourfiles+0x86>
      printf("fork failed\n", s);
    2ae8:	f9843583          	ld	a1,-104(s0)
    2aec:	00005517          	auipc	a0,0x5
    2af0:	4c450513          	addi	a0,a0,1220 # 7fb0 <cv_init+0x22a>
    2af4:	00005097          	auipc	ra,0x5
    2af8:	db4080e7          	jalr	-588(ra) # 78a8 <printf>
      exit(1);
    2afc:	4505                	li	a0,1
    2afe:	00005097          	auipc	ra,0x5
    2b02:	872080e7          	jalr	-1934(ra) # 7370 <exit>
    }

    if(pid == 0){
    2b06:	fcc42783          	lw	a5,-52(s0)
    2b0a:	2781                	sext.w	a5,a5
    2b0c:	efe1                	bnez	a5,2be4 <fourfiles+0x164>
      fd = open(fname, O_CREATE | O_RDWR);
    2b0e:	20200593          	li	a1,514
    2b12:	fd843503          	ld	a0,-40(s0)
    2b16:	00005097          	auipc	ra,0x5
    2b1a:	89a080e7          	jalr	-1894(ra) # 73b0 <open>
    2b1e:	87aa                	mv	a5,a0
    2b20:	fcf42a23          	sw	a5,-44(s0)
      if(fd < 0){
    2b24:	fd442783          	lw	a5,-44(s0)
    2b28:	2781                	sext.w	a5,a5
    2b2a:	0207d163          	bgez	a5,2b4c <fourfiles+0xcc>
        printf("create failed\n", s);
    2b2e:	f9843583          	ld	a1,-104(s0)
    2b32:	00006517          	auipc	a0,0x6
    2b36:	d6650513          	addi	a0,a0,-666 # 8898 <cv_init+0xb12>
    2b3a:	00005097          	auipc	ra,0x5
    2b3e:	d6e080e7          	jalr	-658(ra) # 78a8 <printf>
        exit(1);
    2b42:	4505                	li	a0,1
    2b44:	00005097          	auipc	ra,0x5
    2b48:	82c080e7          	jalr	-2004(ra) # 7370 <exit>
      }

      memset(buf, '0'+pi, SZ);
    2b4c:	fe042783          	lw	a5,-32(s0)
    2b50:	0307879b          	addiw	a5,a5,48
    2b54:	2781                	sext.w	a5,a5
    2b56:	1f400613          	li	a2,500
    2b5a:	85be                	mv	a1,a5
    2b5c:	00008517          	auipc	a0,0x8
    2b60:	aec50513          	addi	a0,a0,-1300 # a648 <buf>
    2b64:	00004097          	auipc	ra,0x4
    2b68:	460080e7          	jalr	1120(ra) # 6fc4 <memset>
      for(i = 0; i < N; i++){
    2b6c:	fe042623          	sw	zero,-20(s0)
    2b70:	a8b1                	j	2bcc <fourfiles+0x14c>
        if((n = write(fd, buf, SZ)) != SZ){
    2b72:	fd442783          	lw	a5,-44(s0)
    2b76:	1f400613          	li	a2,500
    2b7a:	00008597          	auipc	a1,0x8
    2b7e:	ace58593          	addi	a1,a1,-1330 # a648 <buf>
    2b82:	853e                	mv	a0,a5
    2b84:	00005097          	auipc	ra,0x5
    2b88:	80c080e7          	jalr	-2036(ra) # 7390 <write>
    2b8c:	87aa                	mv	a5,a0
    2b8e:	fcf42823          	sw	a5,-48(s0)
    2b92:	fd042783          	lw	a5,-48(s0)
    2b96:	0007871b          	sext.w	a4,a5
    2b9a:	1f400793          	li	a5,500
    2b9e:	02f70263          	beq	a4,a5,2bc2 <fourfiles+0x142>
          printf("write failed %d\n", n);
    2ba2:	fd042783          	lw	a5,-48(s0)
    2ba6:	85be                	mv	a1,a5
    2ba8:	00006517          	auipc	a0,0x6
    2bac:	d0050513          	addi	a0,a0,-768 # 88a8 <cv_init+0xb22>
    2bb0:	00005097          	auipc	ra,0x5
    2bb4:	cf8080e7          	jalr	-776(ra) # 78a8 <printf>
          exit(1);
    2bb8:	4505                	li	a0,1
    2bba:	00004097          	auipc	ra,0x4
    2bbe:	7b6080e7          	jalr	1974(ra) # 7370 <exit>
      for(i = 0; i < N; i++){
    2bc2:	fec42783          	lw	a5,-20(s0)
    2bc6:	2785                	addiw	a5,a5,1
    2bc8:	fef42623          	sw	a5,-20(s0)
    2bcc:	fec42783          	lw	a5,-20(s0)
    2bd0:	0007871b          	sext.w	a4,a5
    2bd4:	47ad                	li	a5,11
    2bd6:	f8e7dee3          	bge	a5,a4,2b72 <fourfiles+0xf2>
        }
      }
      exit(0);
    2bda:	4501                	li	a0,0
    2bdc:	00004097          	auipc	ra,0x4
    2be0:	794080e7          	jalr	1940(ra) # 7370 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2be4:	fe042783          	lw	a5,-32(s0)
    2be8:	2785                	addiw	a5,a5,1
    2bea:	fef42023          	sw	a5,-32(s0)
    2bee:	fe042783          	lw	a5,-32(s0)
    2bf2:	0007871b          	sext.w	a4,a5
    2bf6:	478d                	li	a5,3
    2bf8:	eae7dde3          	bge	a5,a4,2ab2 <fourfiles+0x32>
    }
  }

  int xstatus;
  for(pi = 0; pi < NCHILD; pi++){
    2bfc:	fe042023          	sw	zero,-32(s0)
    2c00:	a03d                	j	2c2e <fourfiles+0x1ae>
    wait(&xstatus);
    2c02:	fa440793          	addi	a5,s0,-92
    2c06:	853e                	mv	a0,a5
    2c08:	00004097          	auipc	ra,0x4
    2c0c:	770080e7          	jalr	1904(ra) # 7378 <wait>
    if(xstatus != 0)
    2c10:	fa442783          	lw	a5,-92(s0)
    2c14:	cb81                	beqz	a5,2c24 <fourfiles+0x1a4>
      exit(xstatus);
    2c16:	fa442783          	lw	a5,-92(s0)
    2c1a:	853e                	mv	a0,a5
    2c1c:	00004097          	auipc	ra,0x4
    2c20:	754080e7          	jalr	1876(ra) # 7370 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2c24:	fe042783          	lw	a5,-32(s0)
    2c28:	2785                	addiw	a5,a5,1
    2c2a:	fef42023          	sw	a5,-32(s0)
    2c2e:	fe042783          	lw	a5,-32(s0)
    2c32:	0007871b          	sext.w	a4,a5
    2c36:	478d                	li	a5,3
    2c38:	fce7d5e3          	bge	a5,a4,2c02 <fourfiles+0x182>
  }

  for(i = 0; i < NCHILD; i++){
    2c3c:	fe042623          	sw	zero,-20(s0)
    2c40:	a205                	j	2d60 <fourfiles+0x2e0>
    fname = names[i];
    2c42:	fec42783          	lw	a5,-20(s0)
    2c46:	078e                	slli	a5,a5,0x3
    2c48:	17c1                	addi	a5,a5,-16
    2c4a:	97a2                	add	a5,a5,s0
    2c4c:	fb87b783          	ld	a5,-72(a5)
    2c50:	fcf43c23          	sd	a5,-40(s0)
    fd = open(fname, 0);
    2c54:	4581                	li	a1,0
    2c56:	fd843503          	ld	a0,-40(s0)
    2c5a:	00004097          	auipc	ra,0x4
    2c5e:	756080e7          	jalr	1878(ra) # 73b0 <open>
    2c62:	87aa                	mv	a5,a0
    2c64:	fcf42a23          	sw	a5,-44(s0)
    total = 0;
    2c68:	fe042223          	sw	zero,-28(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2c6c:	a89d                	j	2ce2 <fourfiles+0x262>
      for(j = 0; j < n; j++){
    2c6e:	fe042423          	sw	zero,-24(s0)
    2c72:	a0b9                	j	2cc0 <fourfiles+0x240>
        if(buf[j] != '0'+i){
    2c74:	00008717          	auipc	a4,0x8
    2c78:	9d470713          	addi	a4,a4,-1580 # a648 <buf>
    2c7c:	fe842783          	lw	a5,-24(s0)
    2c80:	97ba                	add	a5,a5,a4
    2c82:	0007c783          	lbu	a5,0(a5)
    2c86:	0007871b          	sext.w	a4,a5
    2c8a:	fec42783          	lw	a5,-20(s0)
    2c8e:	0307879b          	addiw	a5,a5,48
    2c92:	2781                	sext.w	a5,a5
    2c94:	02f70163          	beq	a4,a5,2cb6 <fourfiles+0x236>
          printf("wrong char\n", s);
    2c98:	f9843583          	ld	a1,-104(s0)
    2c9c:	00006517          	auipc	a0,0x6
    2ca0:	c2450513          	addi	a0,a0,-988 # 88c0 <cv_init+0xb3a>
    2ca4:	00005097          	auipc	ra,0x5
    2ca8:	c04080e7          	jalr	-1020(ra) # 78a8 <printf>
          exit(1);
    2cac:	4505                	li	a0,1
    2cae:	00004097          	auipc	ra,0x4
    2cb2:	6c2080e7          	jalr	1730(ra) # 7370 <exit>
      for(j = 0; j < n; j++){
    2cb6:	fe842783          	lw	a5,-24(s0)
    2cba:	2785                	addiw	a5,a5,1
    2cbc:	fef42423          	sw	a5,-24(s0)
    2cc0:	fe842783          	lw	a5,-24(s0)
    2cc4:	873e                	mv	a4,a5
    2cc6:	fd042783          	lw	a5,-48(s0)
    2cca:	2701                	sext.w	a4,a4
    2ccc:	2781                	sext.w	a5,a5
    2cce:	faf743e3          	blt	a4,a5,2c74 <fourfiles+0x1f4>
        }
      }
      total += n;
    2cd2:	fe442783          	lw	a5,-28(s0)
    2cd6:	873e                	mv	a4,a5
    2cd8:	fd042783          	lw	a5,-48(s0)
    2cdc:	9fb9                	addw	a5,a5,a4
    2cde:	fef42223          	sw	a5,-28(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2ce2:	fd442783          	lw	a5,-44(s0)
    2ce6:	660d                	lui	a2,0x3
    2ce8:	00008597          	auipc	a1,0x8
    2cec:	96058593          	addi	a1,a1,-1696 # a648 <buf>
    2cf0:	853e                	mv	a0,a5
    2cf2:	00004097          	auipc	ra,0x4
    2cf6:	696080e7          	jalr	1686(ra) # 7388 <read>
    2cfa:	87aa                	mv	a5,a0
    2cfc:	fcf42823          	sw	a5,-48(s0)
    2d00:	fd042783          	lw	a5,-48(s0)
    2d04:	2781                	sext.w	a5,a5
    2d06:	f6f044e3          	bgtz	a5,2c6e <fourfiles+0x1ee>
    }
    close(fd);
    2d0a:	fd442783          	lw	a5,-44(s0)
    2d0e:	853e                	mv	a0,a5
    2d10:	00004097          	auipc	ra,0x4
    2d14:	688080e7          	jalr	1672(ra) # 7398 <close>
    if(total != N*SZ){
    2d18:	fe442783          	lw	a5,-28(s0)
    2d1c:	0007871b          	sext.w	a4,a5
    2d20:	6785                	lui	a5,0x1
    2d22:	77078793          	addi	a5,a5,1904 # 1770 <writebig+0x12c>
    2d26:	02f70263          	beq	a4,a5,2d4a <fourfiles+0x2ca>
      printf("wrong length %d\n", total);
    2d2a:	fe442783          	lw	a5,-28(s0)
    2d2e:	85be                	mv	a1,a5
    2d30:	00006517          	auipc	a0,0x6
    2d34:	ba050513          	addi	a0,a0,-1120 # 88d0 <cv_init+0xb4a>
    2d38:	00005097          	auipc	ra,0x5
    2d3c:	b70080e7          	jalr	-1168(ra) # 78a8 <printf>
      exit(1);
    2d40:	4505                	li	a0,1
    2d42:	00004097          	auipc	ra,0x4
    2d46:	62e080e7          	jalr	1582(ra) # 7370 <exit>
    }
    unlink(fname);
    2d4a:	fd843503          	ld	a0,-40(s0)
    2d4e:	00004097          	auipc	ra,0x4
    2d52:	672080e7          	jalr	1650(ra) # 73c0 <unlink>
  for(i = 0; i < NCHILD; i++){
    2d56:	fec42783          	lw	a5,-20(s0)
    2d5a:	2785                	addiw	a5,a5,1
    2d5c:	fef42623          	sw	a5,-20(s0)
    2d60:	fec42783          	lw	a5,-20(s0)
    2d64:	0007871b          	sext.w	a4,a5
    2d68:	478d                	li	a5,3
    2d6a:	ece7dce3          	bge	a5,a4,2c42 <fourfiles+0x1c2>
  }
}
    2d6e:	0001                	nop
    2d70:	0001                	nop
    2d72:	70a6                	ld	ra,104(sp)
    2d74:	7406                	ld	s0,96(sp)
    2d76:	6165                	addi	sp,sp,112
    2d78:	8082                	ret

0000000000002d7a <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(char *s)
{
    2d7a:	711d                	addi	sp,sp,-96
    2d7c:	ec86                	sd	ra,88(sp)
    2d7e:	e8a2                	sd	s0,80(sp)
    2d80:	1080                	addi	s0,sp,96
    2d82:	faa43423          	sd	a0,-88(s0)
  enum { N = 20, NCHILD=4 };
  int pid, i, fd, pi;
  char name[32];

  for(pi = 0; pi < NCHILD; pi++){
    2d86:	fe042423          	sw	zero,-24(s0)
    2d8a:	aa91                	j	2ede <createdelete+0x164>
    pid = fork();
    2d8c:	00004097          	auipc	ra,0x4
    2d90:	5dc080e7          	jalr	1500(ra) # 7368 <fork>
    2d94:	87aa                	mv	a5,a0
    2d96:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    2d9a:	fe042783          	lw	a5,-32(s0)
    2d9e:	2781                	sext.w	a5,a5
    2da0:	0207d163          	bgez	a5,2dc2 <createdelete+0x48>
      printf("fork failed\n", s);
    2da4:	fa843583          	ld	a1,-88(s0)
    2da8:	00005517          	auipc	a0,0x5
    2dac:	20850513          	addi	a0,a0,520 # 7fb0 <cv_init+0x22a>
    2db0:	00005097          	auipc	ra,0x5
    2db4:	af8080e7          	jalr	-1288(ra) # 78a8 <printf>
      exit(1);
    2db8:	4505                	li	a0,1
    2dba:	00004097          	auipc	ra,0x4
    2dbe:	5b6080e7          	jalr	1462(ra) # 7370 <exit>
    }

    if(pid == 0){
    2dc2:	fe042783          	lw	a5,-32(s0)
    2dc6:	2781                	sext.w	a5,a5
    2dc8:	10079663          	bnez	a5,2ed4 <createdelete+0x15a>
      name[0] = 'p' + pi;
    2dcc:	fe842783          	lw	a5,-24(s0)
    2dd0:	0ff7f793          	zext.b	a5,a5
    2dd4:	0707879b          	addiw	a5,a5,112
    2dd8:	0ff7f793          	zext.b	a5,a5
    2ddc:	fcf40023          	sb	a5,-64(s0)
      name[2] = '\0';
    2de0:	fc040123          	sb	zero,-62(s0)
      for(i = 0; i < N; i++){
    2de4:	fe042623          	sw	zero,-20(s0)
    2de8:	a8d1                	j	2ebc <createdelete+0x142>
        name[1] = '0' + i;
    2dea:	fec42783          	lw	a5,-20(s0)
    2dee:	0ff7f793          	zext.b	a5,a5
    2df2:	0307879b          	addiw	a5,a5,48
    2df6:	0ff7f793          	zext.b	a5,a5
    2dfa:	fcf400a3          	sb	a5,-63(s0)
        fd = open(name, O_CREATE | O_RDWR);
    2dfe:	fc040793          	addi	a5,s0,-64
    2e02:	20200593          	li	a1,514
    2e06:	853e                	mv	a0,a5
    2e08:	00004097          	auipc	ra,0x4
    2e0c:	5a8080e7          	jalr	1448(ra) # 73b0 <open>
    2e10:	87aa                	mv	a5,a0
    2e12:	fef42223          	sw	a5,-28(s0)
        if(fd < 0){
    2e16:	fe442783          	lw	a5,-28(s0)
    2e1a:	2781                	sext.w	a5,a5
    2e1c:	0207d163          	bgez	a5,2e3e <createdelete+0xc4>
          printf("%s: create failed\n", s);
    2e20:	fa843583          	ld	a1,-88(s0)
    2e24:	00005517          	auipc	a0,0x5
    2e28:	7e450513          	addi	a0,a0,2020 # 8608 <cv_init+0x882>
    2e2c:	00005097          	auipc	ra,0x5
    2e30:	a7c080e7          	jalr	-1412(ra) # 78a8 <printf>
          exit(1);
    2e34:	4505                	li	a0,1
    2e36:	00004097          	auipc	ra,0x4
    2e3a:	53a080e7          	jalr	1338(ra) # 7370 <exit>
        }
        close(fd);
    2e3e:	fe442783          	lw	a5,-28(s0)
    2e42:	853e                	mv	a0,a5
    2e44:	00004097          	auipc	ra,0x4
    2e48:	554080e7          	jalr	1364(ra) # 7398 <close>
        if(i > 0 && (i % 2 ) == 0){
    2e4c:	fec42783          	lw	a5,-20(s0)
    2e50:	2781                	sext.w	a5,a5
    2e52:	06f05063          	blez	a5,2eb2 <createdelete+0x138>
    2e56:	fec42783          	lw	a5,-20(s0)
    2e5a:	8b85                	andi	a5,a5,1
    2e5c:	2781                	sext.w	a5,a5
    2e5e:	ebb1                	bnez	a5,2eb2 <createdelete+0x138>
          name[1] = '0' + (i / 2);
    2e60:	fec42783          	lw	a5,-20(s0)
    2e64:	01f7d71b          	srliw	a4,a5,0x1f
    2e68:	9fb9                	addw	a5,a5,a4
    2e6a:	4017d79b          	sraiw	a5,a5,0x1
    2e6e:	2781                	sext.w	a5,a5
    2e70:	0ff7f793          	zext.b	a5,a5
    2e74:	0307879b          	addiw	a5,a5,48
    2e78:	0ff7f793          	zext.b	a5,a5
    2e7c:	fcf400a3          	sb	a5,-63(s0)
          if(unlink(name) < 0){
    2e80:	fc040793          	addi	a5,s0,-64
    2e84:	853e                	mv	a0,a5
    2e86:	00004097          	auipc	ra,0x4
    2e8a:	53a080e7          	jalr	1338(ra) # 73c0 <unlink>
    2e8e:	87aa                	mv	a5,a0
    2e90:	0207d163          	bgez	a5,2eb2 <createdelete+0x138>
            printf("%s: unlink failed\n", s);
    2e94:	fa843583          	ld	a1,-88(s0)
    2e98:	00005517          	auipc	a0,0x5
    2e9c:	4c050513          	addi	a0,a0,1216 # 8358 <cv_init+0x5d2>
    2ea0:	00005097          	auipc	ra,0x5
    2ea4:	a08080e7          	jalr	-1528(ra) # 78a8 <printf>
            exit(1);
    2ea8:	4505                	li	a0,1
    2eaa:	00004097          	auipc	ra,0x4
    2eae:	4c6080e7          	jalr	1222(ra) # 7370 <exit>
      for(i = 0; i < N; i++){
    2eb2:	fec42783          	lw	a5,-20(s0)
    2eb6:	2785                	addiw	a5,a5,1
    2eb8:	fef42623          	sw	a5,-20(s0)
    2ebc:	fec42783          	lw	a5,-20(s0)
    2ec0:	0007871b          	sext.w	a4,a5
    2ec4:	47cd                	li	a5,19
    2ec6:	f2e7d2e3          	bge	a5,a4,2dea <createdelete+0x70>
          }
        }
      }
      exit(0);
    2eca:	4501                	li	a0,0
    2ecc:	00004097          	auipc	ra,0x4
    2ed0:	4a4080e7          	jalr	1188(ra) # 7370 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2ed4:	fe842783          	lw	a5,-24(s0)
    2ed8:	2785                	addiw	a5,a5,1
    2eda:	fef42423          	sw	a5,-24(s0)
    2ede:	fe842783          	lw	a5,-24(s0)
    2ee2:	0007871b          	sext.w	a4,a5
    2ee6:	478d                	li	a5,3
    2ee8:	eae7d2e3          	bge	a5,a4,2d8c <createdelete+0x12>
    }
  }

  int xstatus;
  for(pi = 0; pi < NCHILD; pi++){
    2eec:	fe042423          	sw	zero,-24(s0)
    2ef0:	a02d                	j	2f1a <createdelete+0x1a0>
    wait(&xstatus);
    2ef2:	fbc40793          	addi	a5,s0,-68
    2ef6:	853e                	mv	a0,a5
    2ef8:	00004097          	auipc	ra,0x4
    2efc:	480080e7          	jalr	1152(ra) # 7378 <wait>
    if(xstatus != 0)
    2f00:	fbc42783          	lw	a5,-68(s0)
    2f04:	c791                	beqz	a5,2f10 <createdelete+0x196>
      exit(1);
    2f06:	4505                	li	a0,1
    2f08:	00004097          	auipc	ra,0x4
    2f0c:	468080e7          	jalr	1128(ra) # 7370 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2f10:	fe842783          	lw	a5,-24(s0)
    2f14:	2785                	addiw	a5,a5,1
    2f16:	fef42423          	sw	a5,-24(s0)
    2f1a:	fe842783          	lw	a5,-24(s0)
    2f1e:	0007871b          	sext.w	a4,a5
    2f22:	478d                	li	a5,3
    2f24:	fce7d7e3          	bge	a5,a4,2ef2 <createdelete+0x178>
  }

  name[0] = name[1] = name[2] = 0;
    2f28:	fc040123          	sb	zero,-62(s0)
    2f2c:	fc244783          	lbu	a5,-62(s0)
    2f30:	fcf400a3          	sb	a5,-63(s0)
    2f34:	fc144783          	lbu	a5,-63(s0)
    2f38:	fcf40023          	sb	a5,-64(s0)
  for(i = 0; i < N; i++){
    2f3c:	fe042623          	sw	zero,-20(s0)
    2f40:	a229                	j	304a <createdelete+0x2d0>
    for(pi = 0; pi < NCHILD; pi++){
    2f42:	fe042423          	sw	zero,-24(s0)
    2f46:	a0f5                	j	3032 <createdelete+0x2b8>
      name[0] = 'p' + pi;
    2f48:	fe842783          	lw	a5,-24(s0)
    2f4c:	0ff7f793          	zext.b	a5,a5
    2f50:	0707879b          	addiw	a5,a5,112
    2f54:	0ff7f793          	zext.b	a5,a5
    2f58:	fcf40023          	sb	a5,-64(s0)
      name[1] = '0' + i;
    2f5c:	fec42783          	lw	a5,-20(s0)
    2f60:	0ff7f793          	zext.b	a5,a5
    2f64:	0307879b          	addiw	a5,a5,48
    2f68:	0ff7f793          	zext.b	a5,a5
    2f6c:	fcf400a3          	sb	a5,-63(s0)
      fd = open(name, 0);
    2f70:	fc040793          	addi	a5,s0,-64
    2f74:	4581                	li	a1,0
    2f76:	853e                	mv	a0,a5
    2f78:	00004097          	auipc	ra,0x4
    2f7c:	438080e7          	jalr	1080(ra) # 73b0 <open>
    2f80:	87aa                	mv	a5,a0
    2f82:	fef42223          	sw	a5,-28(s0)
      if((i == 0 || i >= N/2) && fd < 0){
    2f86:	fec42783          	lw	a5,-20(s0)
    2f8a:	2781                	sext.w	a5,a5
    2f8c:	cb81                	beqz	a5,2f9c <createdelete+0x222>
    2f8e:	fec42783          	lw	a5,-20(s0)
    2f92:	0007871b          	sext.w	a4,a5
    2f96:	47a5                	li	a5,9
    2f98:	02e7d963          	bge	a5,a4,2fca <createdelete+0x250>
    2f9c:	fe442783          	lw	a5,-28(s0)
    2fa0:	2781                	sext.w	a5,a5
    2fa2:	0207d463          	bgez	a5,2fca <createdelete+0x250>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    2fa6:	fc040793          	addi	a5,s0,-64
    2faa:	863e                	mv	a2,a5
    2fac:	fa843583          	ld	a1,-88(s0)
    2fb0:	00006517          	auipc	a0,0x6
    2fb4:	97850513          	addi	a0,a0,-1672 # 8928 <cv_init+0xba2>
    2fb8:	00005097          	auipc	ra,0x5
    2fbc:	8f0080e7          	jalr	-1808(ra) # 78a8 <printf>
        exit(1);
    2fc0:	4505                	li	a0,1
    2fc2:	00004097          	auipc	ra,0x4
    2fc6:	3ae080e7          	jalr	942(ra) # 7370 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    2fca:	fec42783          	lw	a5,-20(s0)
    2fce:	2781                	sext.w	a5,a5
    2fd0:	04f05063          	blez	a5,3010 <createdelete+0x296>
    2fd4:	fec42783          	lw	a5,-20(s0)
    2fd8:	0007871b          	sext.w	a4,a5
    2fdc:	47a5                	li	a5,9
    2fde:	02e7c963          	blt	a5,a4,3010 <createdelete+0x296>
    2fe2:	fe442783          	lw	a5,-28(s0)
    2fe6:	2781                	sext.w	a5,a5
    2fe8:	0207c463          	bltz	a5,3010 <createdelete+0x296>
        printf("%s: oops createdelete %s did exist\n", s, name);
    2fec:	fc040793          	addi	a5,s0,-64
    2ff0:	863e                	mv	a2,a5
    2ff2:	fa843583          	ld	a1,-88(s0)
    2ff6:	00006517          	auipc	a0,0x6
    2ffa:	95a50513          	addi	a0,a0,-1702 # 8950 <cv_init+0xbca>
    2ffe:	00005097          	auipc	ra,0x5
    3002:	8aa080e7          	jalr	-1878(ra) # 78a8 <printf>
        exit(1);
    3006:	4505                	li	a0,1
    3008:	00004097          	auipc	ra,0x4
    300c:	368080e7          	jalr	872(ra) # 7370 <exit>
      }
      if(fd >= 0)
    3010:	fe442783          	lw	a5,-28(s0)
    3014:	2781                	sext.w	a5,a5
    3016:	0007c963          	bltz	a5,3028 <createdelete+0x2ae>
        close(fd);
    301a:	fe442783          	lw	a5,-28(s0)
    301e:	853e                	mv	a0,a5
    3020:	00004097          	auipc	ra,0x4
    3024:	378080e7          	jalr	888(ra) # 7398 <close>
    for(pi = 0; pi < NCHILD; pi++){
    3028:	fe842783          	lw	a5,-24(s0)
    302c:	2785                	addiw	a5,a5,1
    302e:	fef42423          	sw	a5,-24(s0)
    3032:	fe842783          	lw	a5,-24(s0)
    3036:	0007871b          	sext.w	a4,a5
    303a:	478d                	li	a5,3
    303c:	f0e7d6e3          	bge	a5,a4,2f48 <createdelete+0x1ce>
  for(i = 0; i < N; i++){
    3040:	fec42783          	lw	a5,-20(s0)
    3044:	2785                	addiw	a5,a5,1
    3046:	fef42623          	sw	a5,-20(s0)
    304a:	fec42783          	lw	a5,-20(s0)
    304e:	0007871b          	sext.w	a4,a5
    3052:	47cd                	li	a5,19
    3054:	eee7d7e3          	bge	a5,a4,2f42 <createdelete+0x1c8>
    }
  }

  for(i = 0; i < N; i++){
    3058:	fe042623          	sw	zero,-20(s0)
    305c:	a085                	j	30bc <createdelete+0x342>
    for(pi = 0; pi < NCHILD; pi++){
    305e:	fe042423          	sw	zero,-24(s0)
    3062:	a089                	j	30a4 <createdelete+0x32a>
      name[0] = 'p' + i;
    3064:	fec42783          	lw	a5,-20(s0)
    3068:	0ff7f793          	zext.b	a5,a5
    306c:	0707879b          	addiw	a5,a5,112
    3070:	0ff7f793          	zext.b	a5,a5
    3074:	fcf40023          	sb	a5,-64(s0)
      name[1] = '0' + i;
    3078:	fec42783          	lw	a5,-20(s0)
    307c:	0ff7f793          	zext.b	a5,a5
    3080:	0307879b          	addiw	a5,a5,48
    3084:	0ff7f793          	zext.b	a5,a5
    3088:	fcf400a3          	sb	a5,-63(s0)
      unlink(name);
    308c:	fc040793          	addi	a5,s0,-64
    3090:	853e                	mv	a0,a5
    3092:	00004097          	auipc	ra,0x4
    3096:	32e080e7          	jalr	814(ra) # 73c0 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    309a:	fe842783          	lw	a5,-24(s0)
    309e:	2785                	addiw	a5,a5,1
    30a0:	fef42423          	sw	a5,-24(s0)
    30a4:	fe842783          	lw	a5,-24(s0)
    30a8:	0007871b          	sext.w	a4,a5
    30ac:	478d                	li	a5,3
    30ae:	fae7dbe3          	bge	a5,a4,3064 <createdelete+0x2ea>
  for(i = 0; i < N; i++){
    30b2:	fec42783          	lw	a5,-20(s0)
    30b6:	2785                	addiw	a5,a5,1
    30b8:	fef42623          	sw	a5,-20(s0)
    30bc:	fec42783          	lw	a5,-20(s0)
    30c0:	0007871b          	sext.w	a4,a5
    30c4:	47cd                	li	a5,19
    30c6:	f8e7dce3          	bge	a5,a4,305e <createdelete+0x2e4>
    }
  }
}
    30ca:	0001                	nop
    30cc:	0001                	nop
    30ce:	60e6                	ld	ra,88(sp)
    30d0:	6446                	ld	s0,80(sp)
    30d2:	6125                	addi	sp,sp,96
    30d4:	8082                	ret

00000000000030d6 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(char *s)
{
    30d6:	7179                	addi	sp,sp,-48
    30d8:	f406                	sd	ra,40(sp)
    30da:	f022                	sd	s0,32(sp)
    30dc:	1800                	addi	s0,sp,48
    30de:	fca43c23          	sd	a0,-40(s0)
  enum { SZ = 5 };
  int fd, fd1;

  fd = open("unlinkread", O_CREATE | O_RDWR);
    30e2:	20200593          	li	a1,514
    30e6:	00006517          	auipc	a0,0x6
    30ea:	89250513          	addi	a0,a0,-1902 # 8978 <cv_init+0xbf2>
    30ee:	00004097          	auipc	ra,0x4
    30f2:	2c2080e7          	jalr	706(ra) # 73b0 <open>
    30f6:	87aa                	mv	a5,a0
    30f8:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    30fc:	fec42783          	lw	a5,-20(s0)
    3100:	2781                	sext.w	a5,a5
    3102:	0207d163          	bgez	a5,3124 <unlinkread+0x4e>
    printf("%s: create unlinkread failed\n", s);
    3106:	fd843583          	ld	a1,-40(s0)
    310a:	00006517          	auipc	a0,0x6
    310e:	87e50513          	addi	a0,a0,-1922 # 8988 <cv_init+0xc02>
    3112:	00004097          	auipc	ra,0x4
    3116:	796080e7          	jalr	1942(ra) # 78a8 <printf>
    exit(1);
    311a:	4505                	li	a0,1
    311c:	00004097          	auipc	ra,0x4
    3120:	254080e7          	jalr	596(ra) # 7370 <exit>
  }
  write(fd, "hello", SZ);
    3124:	fec42783          	lw	a5,-20(s0)
    3128:	4615                	li	a2,5
    312a:	00006597          	auipc	a1,0x6
    312e:	87e58593          	addi	a1,a1,-1922 # 89a8 <cv_init+0xc22>
    3132:	853e                	mv	a0,a5
    3134:	00004097          	auipc	ra,0x4
    3138:	25c080e7          	jalr	604(ra) # 7390 <write>
  close(fd);
    313c:	fec42783          	lw	a5,-20(s0)
    3140:	853e                	mv	a0,a5
    3142:	00004097          	auipc	ra,0x4
    3146:	256080e7          	jalr	598(ra) # 7398 <close>

  fd = open("unlinkread", O_RDWR);
    314a:	4589                	li	a1,2
    314c:	00006517          	auipc	a0,0x6
    3150:	82c50513          	addi	a0,a0,-2004 # 8978 <cv_init+0xbf2>
    3154:	00004097          	auipc	ra,0x4
    3158:	25c080e7          	jalr	604(ra) # 73b0 <open>
    315c:	87aa                	mv	a5,a0
    315e:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3162:	fec42783          	lw	a5,-20(s0)
    3166:	2781                	sext.w	a5,a5
    3168:	0207d163          	bgez	a5,318a <unlinkread+0xb4>
    printf("%s: open unlinkread failed\n", s);
    316c:	fd843583          	ld	a1,-40(s0)
    3170:	00006517          	auipc	a0,0x6
    3174:	84050513          	addi	a0,a0,-1984 # 89b0 <cv_init+0xc2a>
    3178:	00004097          	auipc	ra,0x4
    317c:	730080e7          	jalr	1840(ra) # 78a8 <printf>
    exit(1);
    3180:	4505                	li	a0,1
    3182:	00004097          	auipc	ra,0x4
    3186:	1ee080e7          	jalr	494(ra) # 7370 <exit>
  }
  if(unlink("unlinkread") != 0){
    318a:	00005517          	auipc	a0,0x5
    318e:	7ee50513          	addi	a0,a0,2030 # 8978 <cv_init+0xbf2>
    3192:	00004097          	auipc	ra,0x4
    3196:	22e080e7          	jalr	558(ra) # 73c0 <unlink>
    319a:	87aa                	mv	a5,a0
    319c:	c385                	beqz	a5,31bc <unlinkread+0xe6>
    printf("%s: unlink unlinkread failed\n", s);
    319e:	fd843583          	ld	a1,-40(s0)
    31a2:	00006517          	auipc	a0,0x6
    31a6:	82e50513          	addi	a0,a0,-2002 # 89d0 <cv_init+0xc4a>
    31aa:	00004097          	auipc	ra,0x4
    31ae:	6fe080e7          	jalr	1790(ra) # 78a8 <printf>
    exit(1);
    31b2:	4505                	li	a0,1
    31b4:	00004097          	auipc	ra,0x4
    31b8:	1bc080e7          	jalr	444(ra) # 7370 <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    31bc:	20200593          	li	a1,514
    31c0:	00005517          	auipc	a0,0x5
    31c4:	7b850513          	addi	a0,a0,1976 # 8978 <cv_init+0xbf2>
    31c8:	00004097          	auipc	ra,0x4
    31cc:	1e8080e7          	jalr	488(ra) # 73b0 <open>
    31d0:	87aa                	mv	a5,a0
    31d2:	fef42423          	sw	a5,-24(s0)
  write(fd1, "yyy", 3);
    31d6:	fe842783          	lw	a5,-24(s0)
    31da:	460d                	li	a2,3
    31dc:	00006597          	auipc	a1,0x6
    31e0:	81458593          	addi	a1,a1,-2028 # 89f0 <cv_init+0xc6a>
    31e4:	853e                	mv	a0,a5
    31e6:	00004097          	auipc	ra,0x4
    31ea:	1aa080e7          	jalr	426(ra) # 7390 <write>
  close(fd1);
    31ee:	fe842783          	lw	a5,-24(s0)
    31f2:	853e                	mv	a0,a5
    31f4:	00004097          	auipc	ra,0x4
    31f8:	1a4080e7          	jalr	420(ra) # 7398 <close>

  if(read(fd, buf, sizeof(buf)) != SZ){
    31fc:	fec42783          	lw	a5,-20(s0)
    3200:	660d                	lui	a2,0x3
    3202:	00007597          	auipc	a1,0x7
    3206:	44658593          	addi	a1,a1,1094 # a648 <buf>
    320a:	853e                	mv	a0,a5
    320c:	00004097          	auipc	ra,0x4
    3210:	17c080e7          	jalr	380(ra) # 7388 <read>
    3214:	87aa                	mv	a5,a0
    3216:	873e                	mv	a4,a5
    3218:	4795                	li	a5,5
    321a:	02f70163          	beq	a4,a5,323c <unlinkread+0x166>
    printf("%s: unlinkread read failed", s);
    321e:	fd843583          	ld	a1,-40(s0)
    3222:	00005517          	auipc	a0,0x5
    3226:	7d650513          	addi	a0,a0,2006 # 89f8 <cv_init+0xc72>
    322a:	00004097          	auipc	ra,0x4
    322e:	67e080e7          	jalr	1662(ra) # 78a8 <printf>
    exit(1);
    3232:	4505                	li	a0,1
    3234:	00004097          	auipc	ra,0x4
    3238:	13c080e7          	jalr	316(ra) # 7370 <exit>
  }
  if(buf[0] != 'h'){
    323c:	00007797          	auipc	a5,0x7
    3240:	40c78793          	addi	a5,a5,1036 # a648 <buf>
    3244:	0007c783          	lbu	a5,0(a5)
    3248:	873e                	mv	a4,a5
    324a:	06800793          	li	a5,104
    324e:	02f70163          	beq	a4,a5,3270 <unlinkread+0x19a>
    printf("%s: unlinkread wrong data\n", s);
    3252:	fd843583          	ld	a1,-40(s0)
    3256:	00005517          	auipc	a0,0x5
    325a:	7c250513          	addi	a0,a0,1986 # 8a18 <cv_init+0xc92>
    325e:	00004097          	auipc	ra,0x4
    3262:	64a080e7          	jalr	1610(ra) # 78a8 <printf>
    exit(1);
    3266:	4505                	li	a0,1
    3268:	00004097          	auipc	ra,0x4
    326c:	108080e7          	jalr	264(ra) # 7370 <exit>
  }
  if(write(fd, buf, 10) != 10){
    3270:	fec42783          	lw	a5,-20(s0)
    3274:	4629                	li	a2,10
    3276:	00007597          	auipc	a1,0x7
    327a:	3d258593          	addi	a1,a1,978 # a648 <buf>
    327e:	853e                	mv	a0,a5
    3280:	00004097          	auipc	ra,0x4
    3284:	110080e7          	jalr	272(ra) # 7390 <write>
    3288:	87aa                	mv	a5,a0
    328a:	873e                	mv	a4,a5
    328c:	47a9                	li	a5,10
    328e:	02f70163          	beq	a4,a5,32b0 <unlinkread+0x1da>
    printf("%s: unlinkread write failed\n", s);
    3292:	fd843583          	ld	a1,-40(s0)
    3296:	00005517          	auipc	a0,0x5
    329a:	7a250513          	addi	a0,a0,1954 # 8a38 <cv_init+0xcb2>
    329e:	00004097          	auipc	ra,0x4
    32a2:	60a080e7          	jalr	1546(ra) # 78a8 <printf>
    exit(1);
    32a6:	4505                	li	a0,1
    32a8:	00004097          	auipc	ra,0x4
    32ac:	0c8080e7          	jalr	200(ra) # 7370 <exit>
  }
  close(fd);
    32b0:	fec42783          	lw	a5,-20(s0)
    32b4:	853e                	mv	a0,a5
    32b6:	00004097          	auipc	ra,0x4
    32ba:	0e2080e7          	jalr	226(ra) # 7398 <close>
  unlink("unlinkread");
    32be:	00005517          	auipc	a0,0x5
    32c2:	6ba50513          	addi	a0,a0,1722 # 8978 <cv_init+0xbf2>
    32c6:	00004097          	auipc	ra,0x4
    32ca:	0fa080e7          	jalr	250(ra) # 73c0 <unlink>
}
    32ce:	0001                	nop
    32d0:	70a2                	ld	ra,40(sp)
    32d2:	7402                	ld	s0,32(sp)
    32d4:	6145                	addi	sp,sp,48
    32d6:	8082                	ret

00000000000032d8 <linktest>:

void
linktest(char *s)
{
    32d8:	7179                	addi	sp,sp,-48
    32da:	f406                	sd	ra,40(sp)
    32dc:	f022                	sd	s0,32(sp)
    32de:	1800                	addi	s0,sp,48
    32e0:	fca43c23          	sd	a0,-40(s0)
  enum { SZ = 5 };
  int fd;

  unlink("lf1");
    32e4:	00005517          	auipc	a0,0x5
    32e8:	77450513          	addi	a0,a0,1908 # 8a58 <cv_init+0xcd2>
    32ec:	00004097          	auipc	ra,0x4
    32f0:	0d4080e7          	jalr	212(ra) # 73c0 <unlink>
  unlink("lf2");
    32f4:	00005517          	auipc	a0,0x5
    32f8:	76c50513          	addi	a0,a0,1900 # 8a60 <cv_init+0xcda>
    32fc:	00004097          	auipc	ra,0x4
    3300:	0c4080e7          	jalr	196(ra) # 73c0 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    3304:	20200593          	li	a1,514
    3308:	00005517          	auipc	a0,0x5
    330c:	75050513          	addi	a0,a0,1872 # 8a58 <cv_init+0xcd2>
    3310:	00004097          	auipc	ra,0x4
    3314:	0a0080e7          	jalr	160(ra) # 73b0 <open>
    3318:	87aa                	mv	a5,a0
    331a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    331e:	fec42783          	lw	a5,-20(s0)
    3322:	2781                	sext.w	a5,a5
    3324:	0207d163          	bgez	a5,3346 <linktest+0x6e>
    printf("%s: create lf1 failed\n", s);
    3328:	fd843583          	ld	a1,-40(s0)
    332c:	00005517          	auipc	a0,0x5
    3330:	73c50513          	addi	a0,a0,1852 # 8a68 <cv_init+0xce2>
    3334:	00004097          	auipc	ra,0x4
    3338:	574080e7          	jalr	1396(ra) # 78a8 <printf>
    exit(1);
    333c:	4505                	li	a0,1
    333e:	00004097          	auipc	ra,0x4
    3342:	032080e7          	jalr	50(ra) # 7370 <exit>
  }
  if(write(fd, "hello", SZ) != SZ){
    3346:	fec42783          	lw	a5,-20(s0)
    334a:	4615                	li	a2,5
    334c:	00005597          	auipc	a1,0x5
    3350:	65c58593          	addi	a1,a1,1628 # 89a8 <cv_init+0xc22>
    3354:	853e                	mv	a0,a5
    3356:	00004097          	auipc	ra,0x4
    335a:	03a080e7          	jalr	58(ra) # 7390 <write>
    335e:	87aa                	mv	a5,a0
    3360:	873e                	mv	a4,a5
    3362:	4795                	li	a5,5
    3364:	02f70163          	beq	a4,a5,3386 <linktest+0xae>
    printf("%s: write lf1 failed\n", s);
    3368:	fd843583          	ld	a1,-40(s0)
    336c:	00005517          	auipc	a0,0x5
    3370:	71450513          	addi	a0,a0,1812 # 8a80 <cv_init+0xcfa>
    3374:	00004097          	auipc	ra,0x4
    3378:	534080e7          	jalr	1332(ra) # 78a8 <printf>
    exit(1);
    337c:	4505                	li	a0,1
    337e:	00004097          	auipc	ra,0x4
    3382:	ff2080e7          	jalr	-14(ra) # 7370 <exit>
  }
  close(fd);
    3386:	fec42783          	lw	a5,-20(s0)
    338a:	853e                	mv	a0,a5
    338c:	00004097          	auipc	ra,0x4
    3390:	00c080e7          	jalr	12(ra) # 7398 <close>

  if(link("lf1", "lf2") < 0){
    3394:	00005597          	auipc	a1,0x5
    3398:	6cc58593          	addi	a1,a1,1740 # 8a60 <cv_init+0xcda>
    339c:	00005517          	auipc	a0,0x5
    33a0:	6bc50513          	addi	a0,a0,1724 # 8a58 <cv_init+0xcd2>
    33a4:	00004097          	auipc	ra,0x4
    33a8:	02c080e7          	jalr	44(ra) # 73d0 <link>
    33ac:	87aa                	mv	a5,a0
    33ae:	0207d163          	bgez	a5,33d0 <linktest+0xf8>
    printf("%s: link lf1 lf2 failed\n", s);
    33b2:	fd843583          	ld	a1,-40(s0)
    33b6:	00005517          	auipc	a0,0x5
    33ba:	6e250513          	addi	a0,a0,1762 # 8a98 <cv_init+0xd12>
    33be:	00004097          	auipc	ra,0x4
    33c2:	4ea080e7          	jalr	1258(ra) # 78a8 <printf>
    exit(1);
    33c6:	4505                	li	a0,1
    33c8:	00004097          	auipc	ra,0x4
    33cc:	fa8080e7          	jalr	-88(ra) # 7370 <exit>
  }
  unlink("lf1");
    33d0:	00005517          	auipc	a0,0x5
    33d4:	68850513          	addi	a0,a0,1672 # 8a58 <cv_init+0xcd2>
    33d8:	00004097          	auipc	ra,0x4
    33dc:	fe8080e7          	jalr	-24(ra) # 73c0 <unlink>

  if(open("lf1", 0) >= 0){
    33e0:	4581                	li	a1,0
    33e2:	00005517          	auipc	a0,0x5
    33e6:	67650513          	addi	a0,a0,1654 # 8a58 <cv_init+0xcd2>
    33ea:	00004097          	auipc	ra,0x4
    33ee:	fc6080e7          	jalr	-58(ra) # 73b0 <open>
    33f2:	87aa                	mv	a5,a0
    33f4:	0207c163          	bltz	a5,3416 <linktest+0x13e>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    33f8:	fd843583          	ld	a1,-40(s0)
    33fc:	00005517          	auipc	a0,0x5
    3400:	6bc50513          	addi	a0,a0,1724 # 8ab8 <cv_init+0xd32>
    3404:	00004097          	auipc	ra,0x4
    3408:	4a4080e7          	jalr	1188(ra) # 78a8 <printf>
    exit(1);
    340c:	4505                	li	a0,1
    340e:	00004097          	auipc	ra,0x4
    3412:	f62080e7          	jalr	-158(ra) # 7370 <exit>
  }

  fd = open("lf2", 0);
    3416:	4581                	li	a1,0
    3418:	00005517          	auipc	a0,0x5
    341c:	64850513          	addi	a0,a0,1608 # 8a60 <cv_init+0xcda>
    3420:	00004097          	auipc	ra,0x4
    3424:	f90080e7          	jalr	-112(ra) # 73b0 <open>
    3428:	87aa                	mv	a5,a0
    342a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    342e:	fec42783          	lw	a5,-20(s0)
    3432:	2781                	sext.w	a5,a5
    3434:	0207d163          	bgez	a5,3456 <linktest+0x17e>
    printf("%s: open lf2 failed\n", s);
    3438:	fd843583          	ld	a1,-40(s0)
    343c:	00005517          	auipc	a0,0x5
    3440:	6ac50513          	addi	a0,a0,1708 # 8ae8 <cv_init+0xd62>
    3444:	00004097          	auipc	ra,0x4
    3448:	464080e7          	jalr	1124(ra) # 78a8 <printf>
    exit(1);
    344c:	4505                	li	a0,1
    344e:	00004097          	auipc	ra,0x4
    3452:	f22080e7          	jalr	-222(ra) # 7370 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != SZ){
    3456:	fec42783          	lw	a5,-20(s0)
    345a:	660d                	lui	a2,0x3
    345c:	00007597          	auipc	a1,0x7
    3460:	1ec58593          	addi	a1,a1,492 # a648 <buf>
    3464:	853e                	mv	a0,a5
    3466:	00004097          	auipc	ra,0x4
    346a:	f22080e7          	jalr	-222(ra) # 7388 <read>
    346e:	87aa                	mv	a5,a0
    3470:	873e                	mv	a4,a5
    3472:	4795                	li	a5,5
    3474:	02f70163          	beq	a4,a5,3496 <linktest+0x1be>
    printf("%s: read lf2 failed\n", s);
    3478:	fd843583          	ld	a1,-40(s0)
    347c:	00005517          	auipc	a0,0x5
    3480:	68450513          	addi	a0,a0,1668 # 8b00 <cv_init+0xd7a>
    3484:	00004097          	auipc	ra,0x4
    3488:	424080e7          	jalr	1060(ra) # 78a8 <printf>
    exit(1);
    348c:	4505                	li	a0,1
    348e:	00004097          	auipc	ra,0x4
    3492:	ee2080e7          	jalr	-286(ra) # 7370 <exit>
  }
  close(fd);
    3496:	fec42783          	lw	a5,-20(s0)
    349a:	853e                	mv	a0,a5
    349c:	00004097          	auipc	ra,0x4
    34a0:	efc080e7          	jalr	-260(ra) # 7398 <close>

  if(link("lf2", "lf2") >= 0){
    34a4:	00005597          	auipc	a1,0x5
    34a8:	5bc58593          	addi	a1,a1,1468 # 8a60 <cv_init+0xcda>
    34ac:	00005517          	auipc	a0,0x5
    34b0:	5b450513          	addi	a0,a0,1460 # 8a60 <cv_init+0xcda>
    34b4:	00004097          	auipc	ra,0x4
    34b8:	f1c080e7          	jalr	-228(ra) # 73d0 <link>
    34bc:	87aa                	mv	a5,a0
    34be:	0207c163          	bltz	a5,34e0 <linktest+0x208>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    34c2:	fd843583          	ld	a1,-40(s0)
    34c6:	00005517          	auipc	a0,0x5
    34ca:	65250513          	addi	a0,a0,1618 # 8b18 <cv_init+0xd92>
    34ce:	00004097          	auipc	ra,0x4
    34d2:	3da080e7          	jalr	986(ra) # 78a8 <printf>
    exit(1);
    34d6:	4505                	li	a0,1
    34d8:	00004097          	auipc	ra,0x4
    34dc:	e98080e7          	jalr	-360(ra) # 7370 <exit>
  }

  unlink("lf2");
    34e0:	00005517          	auipc	a0,0x5
    34e4:	58050513          	addi	a0,a0,1408 # 8a60 <cv_init+0xcda>
    34e8:	00004097          	auipc	ra,0x4
    34ec:	ed8080e7          	jalr	-296(ra) # 73c0 <unlink>
  if(link("lf2", "lf1") >= 0){
    34f0:	00005597          	auipc	a1,0x5
    34f4:	56858593          	addi	a1,a1,1384 # 8a58 <cv_init+0xcd2>
    34f8:	00005517          	auipc	a0,0x5
    34fc:	56850513          	addi	a0,a0,1384 # 8a60 <cv_init+0xcda>
    3500:	00004097          	auipc	ra,0x4
    3504:	ed0080e7          	jalr	-304(ra) # 73d0 <link>
    3508:	87aa                	mv	a5,a0
    350a:	0207c163          	bltz	a5,352c <linktest+0x254>
    printf("%s: link non-existent succeeded! oops\n", s);
    350e:	fd843583          	ld	a1,-40(s0)
    3512:	00005517          	auipc	a0,0x5
    3516:	62e50513          	addi	a0,a0,1582 # 8b40 <cv_init+0xdba>
    351a:	00004097          	auipc	ra,0x4
    351e:	38e080e7          	jalr	910(ra) # 78a8 <printf>
    exit(1);
    3522:	4505                	li	a0,1
    3524:	00004097          	auipc	ra,0x4
    3528:	e4c080e7          	jalr	-436(ra) # 7370 <exit>
  }

  if(link(".", "lf1") >= 0){
    352c:	00005597          	auipc	a1,0x5
    3530:	52c58593          	addi	a1,a1,1324 # 8a58 <cv_init+0xcd2>
    3534:	00005517          	auipc	a0,0x5
    3538:	63450513          	addi	a0,a0,1588 # 8b68 <cv_init+0xde2>
    353c:	00004097          	auipc	ra,0x4
    3540:	e94080e7          	jalr	-364(ra) # 73d0 <link>
    3544:	87aa                	mv	a5,a0
    3546:	0207c163          	bltz	a5,3568 <linktest+0x290>
    printf("%s: link . lf1 succeeded! oops\n", s);
    354a:	fd843583          	ld	a1,-40(s0)
    354e:	00005517          	auipc	a0,0x5
    3552:	62250513          	addi	a0,a0,1570 # 8b70 <cv_init+0xdea>
    3556:	00004097          	auipc	ra,0x4
    355a:	352080e7          	jalr	850(ra) # 78a8 <printf>
    exit(1);
    355e:	4505                	li	a0,1
    3560:	00004097          	auipc	ra,0x4
    3564:	e10080e7          	jalr	-496(ra) # 7370 <exit>
  }
}
    3568:	0001                	nop
    356a:	70a2                	ld	ra,40(sp)
    356c:	7402                	ld	s0,32(sp)
    356e:	6145                	addi	sp,sp,48
    3570:	8082                	ret

0000000000003572 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(char *s)
{
    3572:	7119                	addi	sp,sp,-128
    3574:	fc86                	sd	ra,120(sp)
    3576:	f8a2                	sd	s0,112(sp)
    3578:	0100                	addi	s0,sp,128
    357a:	f8a43423          	sd	a0,-120(s0)
  struct {
    ushort inum;
    char name[DIRSIZ];
  } de;

  file[0] = 'C';
    357e:	04300793          	li	a5,67
    3582:	fcf40c23          	sb	a5,-40(s0)
  file[2] = '\0';
    3586:	fc040d23          	sb	zero,-38(s0)
  for(i = 0; i < N; i++){
    358a:	fe042623          	sw	zero,-20(s0)
    358e:	a225                	j	36b6 <concreate+0x144>
    file[1] = '0' + i;
    3590:	fec42783          	lw	a5,-20(s0)
    3594:	0ff7f793          	zext.b	a5,a5
    3598:	0307879b          	addiw	a5,a5,48
    359c:	0ff7f793          	zext.b	a5,a5
    35a0:	fcf40ca3          	sb	a5,-39(s0)
    unlink(file);
    35a4:	fd840793          	addi	a5,s0,-40
    35a8:	853e                	mv	a0,a5
    35aa:	00004097          	auipc	ra,0x4
    35ae:	e16080e7          	jalr	-490(ra) # 73c0 <unlink>
    pid = fork();
    35b2:	00004097          	auipc	ra,0x4
    35b6:	db6080e7          	jalr	-586(ra) # 7368 <fork>
    35ba:	87aa                	mv	a5,a0
    35bc:	fef42023          	sw	a5,-32(s0)
    if(pid && (i % 3) == 1){
    35c0:	fe042783          	lw	a5,-32(s0)
    35c4:	2781                	sext.w	a5,a5
    35c6:	cb85                	beqz	a5,35f6 <concreate+0x84>
    35c8:	fec42783          	lw	a5,-20(s0)
    35cc:	873e                	mv	a4,a5
    35ce:	478d                	li	a5,3
    35d0:	02f767bb          	remw	a5,a4,a5
    35d4:	2781                	sext.w	a5,a5
    35d6:	873e                	mv	a4,a5
    35d8:	4785                	li	a5,1
    35da:	00f71e63          	bne	a4,a5,35f6 <concreate+0x84>
      link("C0", file);
    35de:	fd840793          	addi	a5,s0,-40
    35e2:	85be                	mv	a1,a5
    35e4:	00005517          	auipc	a0,0x5
    35e8:	5ac50513          	addi	a0,a0,1452 # 8b90 <cv_init+0xe0a>
    35ec:	00004097          	auipc	ra,0x4
    35f0:	de4080e7          	jalr	-540(ra) # 73d0 <link>
    35f4:	a061                	j	367c <concreate+0x10a>
    } else if(pid == 0 && (i % 5) == 1){
    35f6:	fe042783          	lw	a5,-32(s0)
    35fa:	2781                	sext.w	a5,a5
    35fc:	eb85                	bnez	a5,362c <concreate+0xba>
    35fe:	fec42783          	lw	a5,-20(s0)
    3602:	873e                	mv	a4,a5
    3604:	4795                	li	a5,5
    3606:	02f767bb          	remw	a5,a4,a5
    360a:	2781                	sext.w	a5,a5
    360c:	873e                	mv	a4,a5
    360e:	4785                	li	a5,1
    3610:	00f71e63          	bne	a4,a5,362c <concreate+0xba>
      link("C0", file);
    3614:	fd840793          	addi	a5,s0,-40
    3618:	85be                	mv	a1,a5
    361a:	00005517          	auipc	a0,0x5
    361e:	57650513          	addi	a0,a0,1398 # 8b90 <cv_init+0xe0a>
    3622:	00004097          	auipc	ra,0x4
    3626:	dae080e7          	jalr	-594(ra) # 73d0 <link>
    362a:	a889                	j	367c <concreate+0x10a>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    362c:	fd840793          	addi	a5,s0,-40
    3630:	20200593          	li	a1,514
    3634:	853e                	mv	a0,a5
    3636:	00004097          	auipc	ra,0x4
    363a:	d7a080e7          	jalr	-646(ra) # 73b0 <open>
    363e:	87aa                	mv	a5,a0
    3640:	fef42223          	sw	a5,-28(s0)
      if(fd < 0){
    3644:	fe442783          	lw	a5,-28(s0)
    3648:	2781                	sext.w	a5,a5
    364a:	0207d263          	bgez	a5,366e <concreate+0xfc>
        printf("concreate create %s failed\n", file);
    364e:	fd840793          	addi	a5,s0,-40
    3652:	85be                	mv	a1,a5
    3654:	00005517          	auipc	a0,0x5
    3658:	54450513          	addi	a0,a0,1348 # 8b98 <cv_init+0xe12>
    365c:	00004097          	auipc	ra,0x4
    3660:	24c080e7          	jalr	588(ra) # 78a8 <printf>
        exit(1);
    3664:	4505                	li	a0,1
    3666:	00004097          	auipc	ra,0x4
    366a:	d0a080e7          	jalr	-758(ra) # 7370 <exit>
      }
      close(fd);
    366e:	fe442783          	lw	a5,-28(s0)
    3672:	853e                	mv	a0,a5
    3674:	00004097          	auipc	ra,0x4
    3678:	d24080e7          	jalr	-732(ra) # 7398 <close>
    }
    if(pid == 0) {
    367c:	fe042783          	lw	a5,-32(s0)
    3680:	2781                	sext.w	a5,a5
    3682:	e791                	bnez	a5,368e <concreate+0x11c>
      exit(0);
    3684:	4501                	li	a0,0
    3686:	00004097          	auipc	ra,0x4
    368a:	cea080e7          	jalr	-790(ra) # 7370 <exit>
    } else {
      int xstatus;
      wait(&xstatus);
    368e:	f9c40793          	addi	a5,s0,-100
    3692:	853e                	mv	a0,a5
    3694:	00004097          	auipc	ra,0x4
    3698:	ce4080e7          	jalr	-796(ra) # 7378 <wait>
      if(xstatus != 0)
    369c:	f9c42783          	lw	a5,-100(s0)
    36a0:	c791                	beqz	a5,36ac <concreate+0x13a>
        exit(1);
    36a2:	4505                	li	a0,1
    36a4:	00004097          	auipc	ra,0x4
    36a8:	ccc080e7          	jalr	-820(ra) # 7370 <exit>
  for(i = 0; i < N; i++){
    36ac:	fec42783          	lw	a5,-20(s0)
    36b0:	2785                	addiw	a5,a5,1
    36b2:	fef42623          	sw	a5,-20(s0)
    36b6:	fec42783          	lw	a5,-20(s0)
    36ba:	0007871b          	sext.w	a4,a5
    36be:	02700793          	li	a5,39
    36c2:	ece7d7e3          	bge	a5,a4,3590 <concreate+0x1e>
    }
  }

  memset(fa, 0, sizeof(fa));
    36c6:	fb040793          	addi	a5,s0,-80
    36ca:	02800613          	li	a2,40
    36ce:	4581                	li	a1,0
    36d0:	853e                	mv	a0,a5
    36d2:	00004097          	auipc	ra,0x4
    36d6:	8f2080e7          	jalr	-1806(ra) # 6fc4 <memset>
  fd = open(".", 0);
    36da:	4581                	li	a1,0
    36dc:	00005517          	auipc	a0,0x5
    36e0:	48c50513          	addi	a0,a0,1164 # 8b68 <cv_init+0xde2>
    36e4:	00004097          	auipc	ra,0x4
    36e8:	ccc080e7          	jalr	-820(ra) # 73b0 <open>
    36ec:	87aa                	mv	a5,a0
    36ee:	fef42223          	sw	a5,-28(s0)
  n = 0;
    36f2:	fe042423          	sw	zero,-24(s0)
  while(read(fd, &de, sizeof(de)) > 0){
    36f6:	a85d                	j	37ac <concreate+0x23a>
    if(de.inum == 0)
    36f8:	fa045783          	lhu	a5,-96(s0)
    36fc:	e391                	bnez	a5,3700 <concreate+0x18e>
      continue;
    36fe:	a07d                	j	37ac <concreate+0x23a>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    3700:	fa244783          	lbu	a5,-94(s0)
    3704:	873e                	mv	a4,a5
    3706:	04300793          	li	a5,67
    370a:	0af71163          	bne	a4,a5,37ac <concreate+0x23a>
    370e:	fa444783          	lbu	a5,-92(s0)
    3712:	efc9                	bnez	a5,37ac <concreate+0x23a>
      i = de.name[1] - '0';
    3714:	fa344783          	lbu	a5,-93(s0)
    3718:	2781                	sext.w	a5,a5
    371a:	fd07879b          	addiw	a5,a5,-48
    371e:	fef42623          	sw	a5,-20(s0)
      if(i < 0 || i >= sizeof(fa)){
    3722:	fec42783          	lw	a5,-20(s0)
    3726:	2781                	sext.w	a5,a5
    3728:	0007c963          	bltz	a5,373a <concreate+0x1c8>
    372c:	fec42783          	lw	a5,-20(s0)
    3730:	873e                	mv	a4,a5
    3732:	02700793          	li	a5,39
    3736:	02e7f563          	bgeu	a5,a4,3760 <concreate+0x1ee>
        printf("%s: concreate weird file %s\n", s, de.name);
    373a:	fa040793          	addi	a5,s0,-96
    373e:	0789                	addi	a5,a5,2
    3740:	863e                	mv	a2,a5
    3742:	f8843583          	ld	a1,-120(s0)
    3746:	00005517          	auipc	a0,0x5
    374a:	47250513          	addi	a0,a0,1138 # 8bb8 <cv_init+0xe32>
    374e:	00004097          	auipc	ra,0x4
    3752:	15a080e7          	jalr	346(ra) # 78a8 <printf>
        exit(1);
    3756:	4505                	li	a0,1
    3758:	00004097          	auipc	ra,0x4
    375c:	c18080e7          	jalr	-1000(ra) # 7370 <exit>
      }
      if(fa[i]){
    3760:	fec42783          	lw	a5,-20(s0)
    3764:	17c1                	addi	a5,a5,-16
    3766:	97a2                	add	a5,a5,s0
    3768:	fc07c783          	lbu	a5,-64(a5)
    376c:	c785                	beqz	a5,3794 <concreate+0x222>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    376e:	fa040793          	addi	a5,s0,-96
    3772:	0789                	addi	a5,a5,2
    3774:	863e                	mv	a2,a5
    3776:	f8843583          	ld	a1,-120(s0)
    377a:	00005517          	auipc	a0,0x5
    377e:	45e50513          	addi	a0,a0,1118 # 8bd8 <cv_init+0xe52>
    3782:	00004097          	auipc	ra,0x4
    3786:	126080e7          	jalr	294(ra) # 78a8 <printf>
        exit(1);
    378a:	4505                	li	a0,1
    378c:	00004097          	auipc	ra,0x4
    3790:	be4080e7          	jalr	-1052(ra) # 7370 <exit>
      }
      fa[i] = 1;
    3794:	fec42783          	lw	a5,-20(s0)
    3798:	17c1                	addi	a5,a5,-16
    379a:	97a2                	add	a5,a5,s0
    379c:	4705                	li	a4,1
    379e:	fce78023          	sb	a4,-64(a5)
      n++;
    37a2:	fe842783          	lw	a5,-24(s0)
    37a6:	2785                	addiw	a5,a5,1
    37a8:	fef42423          	sw	a5,-24(s0)
  while(read(fd, &de, sizeof(de)) > 0){
    37ac:	fa040713          	addi	a4,s0,-96
    37b0:	fe442783          	lw	a5,-28(s0)
    37b4:	4641                	li	a2,16
    37b6:	85ba                	mv	a1,a4
    37b8:	853e                	mv	a0,a5
    37ba:	00004097          	auipc	ra,0x4
    37be:	bce080e7          	jalr	-1074(ra) # 7388 <read>
    37c2:	87aa                	mv	a5,a0
    37c4:	f2f04ae3          	bgtz	a5,36f8 <concreate+0x186>
    }
  }
  close(fd);
    37c8:	fe442783          	lw	a5,-28(s0)
    37cc:	853e                	mv	a0,a5
    37ce:	00004097          	auipc	ra,0x4
    37d2:	bca080e7          	jalr	-1078(ra) # 7398 <close>

  if(n != N){
    37d6:	fe842783          	lw	a5,-24(s0)
    37da:	0007871b          	sext.w	a4,a5
    37de:	02800793          	li	a5,40
    37e2:	02f70163          	beq	a4,a5,3804 <concreate+0x292>
    printf("%s: concreate not enough files in directory listing\n", s);
    37e6:	f8843583          	ld	a1,-120(s0)
    37ea:	00005517          	auipc	a0,0x5
    37ee:	41650513          	addi	a0,a0,1046 # 8c00 <cv_init+0xe7a>
    37f2:	00004097          	auipc	ra,0x4
    37f6:	0b6080e7          	jalr	182(ra) # 78a8 <printf>
    exit(1);
    37fa:	4505                	li	a0,1
    37fc:	00004097          	auipc	ra,0x4
    3800:	b74080e7          	jalr	-1164(ra) # 7370 <exit>
  }

  for(i = 0; i < N; i++){
    3804:	fe042623          	sw	zero,-20(s0)
    3808:	a25d                	j	39ae <concreate+0x43c>
    file[1] = '0' + i;
    380a:	fec42783          	lw	a5,-20(s0)
    380e:	0ff7f793          	zext.b	a5,a5
    3812:	0307879b          	addiw	a5,a5,48
    3816:	0ff7f793          	zext.b	a5,a5
    381a:	fcf40ca3          	sb	a5,-39(s0)
    pid = fork();
    381e:	00004097          	auipc	ra,0x4
    3822:	b4a080e7          	jalr	-1206(ra) # 7368 <fork>
    3826:	87aa                	mv	a5,a0
    3828:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    382c:	fe042783          	lw	a5,-32(s0)
    3830:	2781                	sext.w	a5,a5
    3832:	0207d163          	bgez	a5,3854 <concreate+0x2e2>
      printf("%s: fork failed\n", s);
    3836:	f8843583          	ld	a1,-120(s0)
    383a:	00005517          	auipc	a0,0x5
    383e:	9a650513          	addi	a0,a0,-1626 # 81e0 <cv_init+0x45a>
    3842:	00004097          	auipc	ra,0x4
    3846:	066080e7          	jalr	102(ra) # 78a8 <printf>
      exit(1);
    384a:	4505                	li	a0,1
    384c:	00004097          	auipc	ra,0x4
    3850:	b24080e7          	jalr	-1244(ra) # 7370 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    3854:	fec42783          	lw	a5,-20(s0)
    3858:	873e                	mv	a4,a5
    385a:	478d                	li	a5,3
    385c:	02f767bb          	remw	a5,a4,a5
    3860:	2781                	sext.w	a5,a5
    3862:	e789                	bnez	a5,386c <concreate+0x2fa>
    3864:	fe042783          	lw	a5,-32(s0)
    3868:	2781                	sext.w	a5,a5
    386a:	c385                	beqz	a5,388a <concreate+0x318>
       ((i % 3) == 1 && pid != 0)){
    386c:	fec42783          	lw	a5,-20(s0)
    3870:	873e                	mv	a4,a5
    3872:	478d                	li	a5,3
    3874:	02f767bb          	remw	a5,a4,a5
    3878:	2781                	sext.w	a5,a5
    if(((i % 3) == 0 && pid == 0) ||
    387a:	873e                	mv	a4,a5
    387c:	4785                	li	a5,1
    387e:	0af71b63          	bne	a4,a5,3934 <concreate+0x3c2>
       ((i % 3) == 1 && pid != 0)){
    3882:	fe042783          	lw	a5,-32(s0)
    3886:	2781                	sext.w	a5,a5
    3888:	c7d5                	beqz	a5,3934 <concreate+0x3c2>
      close(open(file, 0));
    388a:	fd840793          	addi	a5,s0,-40
    388e:	4581                	li	a1,0
    3890:	853e                	mv	a0,a5
    3892:	00004097          	auipc	ra,0x4
    3896:	b1e080e7          	jalr	-1250(ra) # 73b0 <open>
    389a:	87aa                	mv	a5,a0
    389c:	853e                	mv	a0,a5
    389e:	00004097          	auipc	ra,0x4
    38a2:	afa080e7          	jalr	-1286(ra) # 7398 <close>
      close(open(file, 0));
    38a6:	fd840793          	addi	a5,s0,-40
    38aa:	4581                	li	a1,0
    38ac:	853e                	mv	a0,a5
    38ae:	00004097          	auipc	ra,0x4
    38b2:	b02080e7          	jalr	-1278(ra) # 73b0 <open>
    38b6:	87aa                	mv	a5,a0
    38b8:	853e                	mv	a0,a5
    38ba:	00004097          	auipc	ra,0x4
    38be:	ade080e7          	jalr	-1314(ra) # 7398 <close>
      close(open(file, 0));
    38c2:	fd840793          	addi	a5,s0,-40
    38c6:	4581                	li	a1,0
    38c8:	853e                	mv	a0,a5
    38ca:	00004097          	auipc	ra,0x4
    38ce:	ae6080e7          	jalr	-1306(ra) # 73b0 <open>
    38d2:	87aa                	mv	a5,a0
    38d4:	853e                	mv	a0,a5
    38d6:	00004097          	auipc	ra,0x4
    38da:	ac2080e7          	jalr	-1342(ra) # 7398 <close>
      close(open(file, 0));
    38de:	fd840793          	addi	a5,s0,-40
    38e2:	4581                	li	a1,0
    38e4:	853e                	mv	a0,a5
    38e6:	00004097          	auipc	ra,0x4
    38ea:	aca080e7          	jalr	-1334(ra) # 73b0 <open>
    38ee:	87aa                	mv	a5,a0
    38f0:	853e                	mv	a0,a5
    38f2:	00004097          	auipc	ra,0x4
    38f6:	aa6080e7          	jalr	-1370(ra) # 7398 <close>
      close(open(file, 0));
    38fa:	fd840793          	addi	a5,s0,-40
    38fe:	4581                	li	a1,0
    3900:	853e                	mv	a0,a5
    3902:	00004097          	auipc	ra,0x4
    3906:	aae080e7          	jalr	-1362(ra) # 73b0 <open>
    390a:	87aa                	mv	a5,a0
    390c:	853e                	mv	a0,a5
    390e:	00004097          	auipc	ra,0x4
    3912:	a8a080e7          	jalr	-1398(ra) # 7398 <close>
      close(open(file, 0));
    3916:	fd840793          	addi	a5,s0,-40
    391a:	4581                	li	a1,0
    391c:	853e                	mv	a0,a5
    391e:	00004097          	auipc	ra,0x4
    3922:	a92080e7          	jalr	-1390(ra) # 73b0 <open>
    3926:	87aa                	mv	a5,a0
    3928:	853e                	mv	a0,a5
    392a:	00004097          	auipc	ra,0x4
    392e:	a6e080e7          	jalr	-1426(ra) # 7398 <close>
    3932:	a899                	j	3988 <concreate+0x416>
    } else {
      unlink(file);
    3934:	fd840793          	addi	a5,s0,-40
    3938:	853e                	mv	a0,a5
    393a:	00004097          	auipc	ra,0x4
    393e:	a86080e7          	jalr	-1402(ra) # 73c0 <unlink>
      unlink(file);
    3942:	fd840793          	addi	a5,s0,-40
    3946:	853e                	mv	a0,a5
    3948:	00004097          	auipc	ra,0x4
    394c:	a78080e7          	jalr	-1416(ra) # 73c0 <unlink>
      unlink(file);
    3950:	fd840793          	addi	a5,s0,-40
    3954:	853e                	mv	a0,a5
    3956:	00004097          	auipc	ra,0x4
    395a:	a6a080e7          	jalr	-1430(ra) # 73c0 <unlink>
      unlink(file);
    395e:	fd840793          	addi	a5,s0,-40
    3962:	853e                	mv	a0,a5
    3964:	00004097          	auipc	ra,0x4
    3968:	a5c080e7          	jalr	-1444(ra) # 73c0 <unlink>
      unlink(file);
    396c:	fd840793          	addi	a5,s0,-40
    3970:	853e                	mv	a0,a5
    3972:	00004097          	auipc	ra,0x4
    3976:	a4e080e7          	jalr	-1458(ra) # 73c0 <unlink>
      unlink(file);
    397a:	fd840793          	addi	a5,s0,-40
    397e:	853e                	mv	a0,a5
    3980:	00004097          	auipc	ra,0x4
    3984:	a40080e7          	jalr	-1472(ra) # 73c0 <unlink>
    }
    if(pid == 0)
    3988:	fe042783          	lw	a5,-32(s0)
    398c:	2781                	sext.w	a5,a5
    398e:	e791                	bnez	a5,399a <concreate+0x428>
      exit(0);
    3990:	4501                	li	a0,0
    3992:	00004097          	auipc	ra,0x4
    3996:	9de080e7          	jalr	-1570(ra) # 7370 <exit>
    else
      wait(0);
    399a:	4501                	li	a0,0
    399c:	00004097          	auipc	ra,0x4
    39a0:	9dc080e7          	jalr	-1572(ra) # 7378 <wait>
  for(i = 0; i < N; i++){
    39a4:	fec42783          	lw	a5,-20(s0)
    39a8:	2785                	addiw	a5,a5,1
    39aa:	fef42623          	sw	a5,-20(s0)
    39ae:	fec42783          	lw	a5,-20(s0)
    39b2:	0007871b          	sext.w	a4,a5
    39b6:	02700793          	li	a5,39
    39ba:	e4e7d8e3          	bge	a5,a4,380a <concreate+0x298>
  }
}
    39be:	0001                	nop
    39c0:	0001                	nop
    39c2:	70e6                	ld	ra,120(sp)
    39c4:	7446                	ld	s0,112(sp)
    39c6:	6109                	addi	sp,sp,128
    39c8:	8082                	ret

00000000000039ca <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink(char *s)
{
    39ca:	7179                	addi	sp,sp,-48
    39cc:	f406                	sd	ra,40(sp)
    39ce:	f022                	sd	s0,32(sp)
    39d0:	1800                	addi	s0,sp,48
    39d2:	fca43c23          	sd	a0,-40(s0)
  int pid, i;

  unlink("x");
    39d6:	00004517          	auipc	a0,0x4
    39da:	4da50513          	addi	a0,a0,1242 # 7eb0 <cv_init+0x12a>
    39de:	00004097          	auipc	ra,0x4
    39e2:	9e2080e7          	jalr	-1566(ra) # 73c0 <unlink>
  pid = fork();
    39e6:	00004097          	auipc	ra,0x4
    39ea:	982080e7          	jalr	-1662(ra) # 7368 <fork>
    39ee:	87aa                	mv	a5,a0
    39f0:	fef42223          	sw	a5,-28(s0)
  if(pid < 0){
    39f4:	fe442783          	lw	a5,-28(s0)
    39f8:	2781                	sext.w	a5,a5
    39fa:	0207d163          	bgez	a5,3a1c <linkunlink+0x52>
    printf("%s: fork failed\n", s);
    39fe:	fd843583          	ld	a1,-40(s0)
    3a02:	00004517          	auipc	a0,0x4
    3a06:	7de50513          	addi	a0,a0,2014 # 81e0 <cv_init+0x45a>
    3a0a:	00004097          	auipc	ra,0x4
    3a0e:	e9e080e7          	jalr	-354(ra) # 78a8 <printf>
    exit(1);
    3a12:	4505                	li	a0,1
    3a14:	00004097          	auipc	ra,0x4
    3a18:	95c080e7          	jalr	-1700(ra) # 7370 <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    3a1c:	fe442783          	lw	a5,-28(s0)
    3a20:	2781                	sext.w	a5,a5
    3a22:	c399                	beqz	a5,3a28 <linkunlink+0x5e>
    3a24:	4785                	li	a5,1
    3a26:	a019                	j	3a2c <linkunlink+0x62>
    3a28:	06100793          	li	a5,97
    3a2c:	fef42423          	sw	a5,-24(s0)
  for(i = 0; i < 100; i++){
    3a30:	fe042623          	sw	zero,-20(s0)
    3a34:	a045                	j	3ad4 <linkunlink+0x10a>
    x = x * 1103515245 + 12345;
    3a36:	fe842783          	lw	a5,-24(s0)
    3a3a:	873e                	mv	a4,a5
    3a3c:	41c657b7          	lui	a5,0x41c65
    3a40:	e6d7879b          	addiw	a5,a5,-403
    3a44:	02f707bb          	mulw	a5,a4,a5
    3a48:	0007871b          	sext.w	a4,a5
    3a4c:	678d                	lui	a5,0x3
    3a4e:	0397879b          	addiw	a5,a5,57
    3a52:	9fb9                	addw	a5,a5,a4
    3a54:	fef42423          	sw	a5,-24(s0)
    if((x % 3) == 0){
    3a58:	fe842783          	lw	a5,-24(s0)
    3a5c:	873e                	mv	a4,a5
    3a5e:	478d                	li	a5,3
    3a60:	02f777bb          	remuw	a5,a4,a5
    3a64:	2781                	sext.w	a5,a5
    3a66:	e395                	bnez	a5,3a8a <linkunlink+0xc0>
      close(open("x", O_RDWR | O_CREATE));
    3a68:	20200593          	li	a1,514
    3a6c:	00004517          	auipc	a0,0x4
    3a70:	44450513          	addi	a0,a0,1092 # 7eb0 <cv_init+0x12a>
    3a74:	00004097          	auipc	ra,0x4
    3a78:	93c080e7          	jalr	-1732(ra) # 73b0 <open>
    3a7c:	87aa                	mv	a5,a0
    3a7e:	853e                	mv	a0,a5
    3a80:	00004097          	auipc	ra,0x4
    3a84:	918080e7          	jalr	-1768(ra) # 7398 <close>
    3a88:	a089                	j	3aca <linkunlink+0x100>
    } else if((x % 3) == 1){
    3a8a:	fe842783          	lw	a5,-24(s0)
    3a8e:	873e                	mv	a4,a5
    3a90:	478d                	li	a5,3
    3a92:	02f777bb          	remuw	a5,a4,a5
    3a96:	2781                	sext.w	a5,a5
    3a98:	873e                	mv	a4,a5
    3a9a:	4785                	li	a5,1
    3a9c:	00f71f63          	bne	a4,a5,3aba <linkunlink+0xf0>
      link("cat", "x");
    3aa0:	00004597          	auipc	a1,0x4
    3aa4:	41058593          	addi	a1,a1,1040 # 7eb0 <cv_init+0x12a>
    3aa8:	00005517          	auipc	a0,0x5
    3aac:	19050513          	addi	a0,a0,400 # 8c38 <cv_init+0xeb2>
    3ab0:	00004097          	auipc	ra,0x4
    3ab4:	920080e7          	jalr	-1760(ra) # 73d0 <link>
    3ab8:	a809                	j	3aca <linkunlink+0x100>
    } else {
      unlink("x");
    3aba:	00004517          	auipc	a0,0x4
    3abe:	3f650513          	addi	a0,a0,1014 # 7eb0 <cv_init+0x12a>
    3ac2:	00004097          	auipc	ra,0x4
    3ac6:	8fe080e7          	jalr	-1794(ra) # 73c0 <unlink>
  for(i = 0; i < 100; i++){
    3aca:	fec42783          	lw	a5,-20(s0)
    3ace:	2785                	addiw	a5,a5,1
    3ad0:	fef42623          	sw	a5,-20(s0)
    3ad4:	fec42783          	lw	a5,-20(s0)
    3ad8:	0007871b          	sext.w	a4,a5
    3adc:	06300793          	li	a5,99
    3ae0:	f4e7dbe3          	bge	a5,a4,3a36 <linkunlink+0x6c>
    }
  }

  if(pid)
    3ae4:	fe442783          	lw	a5,-28(s0)
    3ae8:	2781                	sext.w	a5,a5
    3aea:	c799                	beqz	a5,3af8 <linkunlink+0x12e>
    wait(0);
    3aec:	4501                	li	a0,0
    3aee:	00004097          	auipc	ra,0x4
    3af2:	88a080e7          	jalr	-1910(ra) # 7378 <wait>
  else
    exit(0);
}
    3af6:	a031                	j	3b02 <linkunlink+0x138>
    exit(0);
    3af8:	4501                	li	a0,0
    3afa:	00004097          	auipc	ra,0x4
    3afe:	876080e7          	jalr	-1930(ra) # 7370 <exit>
}
    3b02:	70a2                	ld	ra,40(sp)
    3b04:	7402                	ld	s0,32(sp)
    3b06:	6145                	addi	sp,sp,48
    3b08:	8082                	ret

0000000000003b0a <bigdir>:

// directory that uses indirect blocks
void
bigdir(char *s)
{
    3b0a:	7139                	addi	sp,sp,-64
    3b0c:	fc06                	sd	ra,56(sp)
    3b0e:	f822                	sd	s0,48(sp)
    3b10:	0080                	addi	s0,sp,64
    3b12:	fca43423          	sd	a0,-56(s0)
  enum { N = 500 };
  int i, fd;
  char name[10];

  unlink("bd");
    3b16:	00005517          	auipc	a0,0x5
    3b1a:	12a50513          	addi	a0,a0,298 # 8c40 <cv_init+0xeba>
    3b1e:	00004097          	auipc	ra,0x4
    3b22:	8a2080e7          	jalr	-1886(ra) # 73c0 <unlink>

  fd = open("bd", O_CREATE);
    3b26:	20000593          	li	a1,512
    3b2a:	00005517          	auipc	a0,0x5
    3b2e:	11650513          	addi	a0,a0,278 # 8c40 <cv_init+0xeba>
    3b32:	00004097          	auipc	ra,0x4
    3b36:	87e080e7          	jalr	-1922(ra) # 73b0 <open>
    3b3a:	87aa                	mv	a5,a0
    3b3c:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    3b40:	fe842783          	lw	a5,-24(s0)
    3b44:	2781                	sext.w	a5,a5
    3b46:	0207d163          	bgez	a5,3b68 <bigdir+0x5e>
    printf("%s: bigdir create failed\n", s);
    3b4a:	fc843583          	ld	a1,-56(s0)
    3b4e:	00005517          	auipc	a0,0x5
    3b52:	0fa50513          	addi	a0,a0,250 # 8c48 <cv_init+0xec2>
    3b56:	00004097          	auipc	ra,0x4
    3b5a:	d52080e7          	jalr	-686(ra) # 78a8 <printf>
    exit(1);
    3b5e:	4505                	li	a0,1
    3b60:	00004097          	auipc	ra,0x4
    3b64:	810080e7          	jalr	-2032(ra) # 7370 <exit>
  }
  close(fd);
    3b68:	fe842783          	lw	a5,-24(s0)
    3b6c:	853e                	mv	a0,a5
    3b6e:	00004097          	auipc	ra,0x4
    3b72:	82a080e7          	jalr	-2006(ra) # 7398 <close>

  for(i = 0; i < N; i++){
    3b76:	fe042623          	sw	zero,-20(s0)
    3b7a:	a055                	j	3c1e <bigdir+0x114>
    name[0] = 'x';
    3b7c:	07800793          	li	a5,120
    3b80:	fcf40c23          	sb	a5,-40(s0)
    name[1] = '0' + (i / 64);
    3b84:	fec42783          	lw	a5,-20(s0)
    3b88:	41f7d71b          	sraiw	a4,a5,0x1f
    3b8c:	01a7571b          	srliw	a4,a4,0x1a
    3b90:	9fb9                	addw	a5,a5,a4
    3b92:	4067d79b          	sraiw	a5,a5,0x6
    3b96:	2781                	sext.w	a5,a5
    3b98:	0ff7f793          	zext.b	a5,a5
    3b9c:	0307879b          	addiw	a5,a5,48
    3ba0:	0ff7f793          	zext.b	a5,a5
    3ba4:	fcf40ca3          	sb	a5,-39(s0)
    name[2] = '0' + (i % 64);
    3ba8:	fec42783          	lw	a5,-20(s0)
    3bac:	873e                	mv	a4,a5
    3bae:	41f7579b          	sraiw	a5,a4,0x1f
    3bb2:	01a7d79b          	srliw	a5,a5,0x1a
    3bb6:	9f3d                	addw	a4,a4,a5
    3bb8:	03f77713          	andi	a4,a4,63
    3bbc:	40f707bb          	subw	a5,a4,a5
    3bc0:	2781                	sext.w	a5,a5
    3bc2:	0ff7f793          	zext.b	a5,a5
    3bc6:	0307879b          	addiw	a5,a5,48
    3bca:	0ff7f793          	zext.b	a5,a5
    3bce:	fcf40d23          	sb	a5,-38(s0)
    name[3] = '\0';
    3bd2:	fc040da3          	sb	zero,-37(s0)
    if(link("bd", name) != 0){
    3bd6:	fd840793          	addi	a5,s0,-40
    3bda:	85be                	mv	a1,a5
    3bdc:	00005517          	auipc	a0,0x5
    3be0:	06450513          	addi	a0,a0,100 # 8c40 <cv_init+0xeba>
    3be4:	00003097          	auipc	ra,0x3
    3be8:	7ec080e7          	jalr	2028(ra) # 73d0 <link>
    3bec:	87aa                	mv	a5,a0
    3bee:	c39d                	beqz	a5,3c14 <bigdir+0x10a>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    3bf0:	fd840793          	addi	a5,s0,-40
    3bf4:	863e                	mv	a2,a5
    3bf6:	fc843583          	ld	a1,-56(s0)
    3bfa:	00005517          	auipc	a0,0x5
    3bfe:	06e50513          	addi	a0,a0,110 # 8c68 <cv_init+0xee2>
    3c02:	00004097          	auipc	ra,0x4
    3c06:	ca6080e7          	jalr	-858(ra) # 78a8 <printf>
      exit(1);
    3c0a:	4505                	li	a0,1
    3c0c:	00003097          	auipc	ra,0x3
    3c10:	764080e7          	jalr	1892(ra) # 7370 <exit>
  for(i = 0; i < N; i++){
    3c14:	fec42783          	lw	a5,-20(s0)
    3c18:	2785                	addiw	a5,a5,1
    3c1a:	fef42623          	sw	a5,-20(s0)
    3c1e:	fec42783          	lw	a5,-20(s0)
    3c22:	0007871b          	sext.w	a4,a5
    3c26:	1f300793          	li	a5,499
    3c2a:	f4e7d9e3          	bge	a5,a4,3b7c <bigdir+0x72>
    }
  }

  unlink("bd");
    3c2e:	00005517          	auipc	a0,0x5
    3c32:	01250513          	addi	a0,a0,18 # 8c40 <cv_init+0xeba>
    3c36:	00003097          	auipc	ra,0x3
    3c3a:	78a080e7          	jalr	1930(ra) # 73c0 <unlink>
  for(i = 0; i < N; i++){
    3c3e:	fe042623          	sw	zero,-20(s0)
    3c42:	a859                	j	3cd8 <bigdir+0x1ce>
    name[0] = 'x';
    3c44:	07800793          	li	a5,120
    3c48:	fcf40c23          	sb	a5,-40(s0)
    name[1] = '0' + (i / 64);
    3c4c:	fec42783          	lw	a5,-20(s0)
    3c50:	41f7d71b          	sraiw	a4,a5,0x1f
    3c54:	01a7571b          	srliw	a4,a4,0x1a
    3c58:	9fb9                	addw	a5,a5,a4
    3c5a:	4067d79b          	sraiw	a5,a5,0x6
    3c5e:	2781                	sext.w	a5,a5
    3c60:	0ff7f793          	zext.b	a5,a5
    3c64:	0307879b          	addiw	a5,a5,48
    3c68:	0ff7f793          	zext.b	a5,a5
    3c6c:	fcf40ca3          	sb	a5,-39(s0)
    name[2] = '0' + (i % 64);
    3c70:	fec42783          	lw	a5,-20(s0)
    3c74:	873e                	mv	a4,a5
    3c76:	41f7579b          	sraiw	a5,a4,0x1f
    3c7a:	01a7d79b          	srliw	a5,a5,0x1a
    3c7e:	9f3d                	addw	a4,a4,a5
    3c80:	03f77713          	andi	a4,a4,63
    3c84:	40f707bb          	subw	a5,a4,a5
    3c88:	2781                	sext.w	a5,a5
    3c8a:	0ff7f793          	zext.b	a5,a5
    3c8e:	0307879b          	addiw	a5,a5,48
    3c92:	0ff7f793          	zext.b	a5,a5
    3c96:	fcf40d23          	sb	a5,-38(s0)
    name[3] = '\0';
    3c9a:	fc040da3          	sb	zero,-37(s0)
    if(unlink(name) != 0){
    3c9e:	fd840793          	addi	a5,s0,-40
    3ca2:	853e                	mv	a0,a5
    3ca4:	00003097          	auipc	ra,0x3
    3ca8:	71c080e7          	jalr	1820(ra) # 73c0 <unlink>
    3cac:	87aa                	mv	a5,a0
    3cae:	c385                	beqz	a5,3cce <bigdir+0x1c4>
      printf("%s: bigdir unlink failed", s);
    3cb0:	fc843583          	ld	a1,-56(s0)
    3cb4:	00005517          	auipc	a0,0x5
    3cb8:	fd450513          	addi	a0,a0,-44 # 8c88 <cv_init+0xf02>
    3cbc:	00004097          	auipc	ra,0x4
    3cc0:	bec080e7          	jalr	-1044(ra) # 78a8 <printf>
      exit(1);
    3cc4:	4505                	li	a0,1
    3cc6:	00003097          	auipc	ra,0x3
    3cca:	6aa080e7          	jalr	1706(ra) # 7370 <exit>
  for(i = 0; i < N; i++){
    3cce:	fec42783          	lw	a5,-20(s0)
    3cd2:	2785                	addiw	a5,a5,1
    3cd4:	fef42623          	sw	a5,-20(s0)
    3cd8:	fec42783          	lw	a5,-20(s0)
    3cdc:	0007871b          	sext.w	a4,a5
    3ce0:	1f300793          	li	a5,499
    3ce4:	f6e7d0e3          	bge	a5,a4,3c44 <bigdir+0x13a>
    }
  }
}
    3ce8:	0001                	nop
    3cea:	0001                	nop
    3cec:	70e2                	ld	ra,56(sp)
    3cee:	7442                	ld	s0,48(sp)
    3cf0:	6121                	addi	sp,sp,64
    3cf2:	8082                	ret

0000000000003cf4 <subdir>:

void
subdir(char *s)
{
    3cf4:	7179                	addi	sp,sp,-48
    3cf6:	f406                	sd	ra,40(sp)
    3cf8:	f022                	sd	s0,32(sp)
    3cfa:	1800                	addi	s0,sp,48
    3cfc:	fca43c23          	sd	a0,-40(s0)
  int fd, cc;

  unlink("ff");
    3d00:	00005517          	auipc	a0,0x5
    3d04:	fa850513          	addi	a0,a0,-88 # 8ca8 <cv_init+0xf22>
    3d08:	00003097          	auipc	ra,0x3
    3d0c:	6b8080e7          	jalr	1720(ra) # 73c0 <unlink>
  if(mkdir("dd") != 0){
    3d10:	00005517          	auipc	a0,0x5
    3d14:	fa050513          	addi	a0,a0,-96 # 8cb0 <cv_init+0xf2a>
    3d18:	00003097          	auipc	ra,0x3
    3d1c:	6c0080e7          	jalr	1728(ra) # 73d8 <mkdir>
    3d20:	87aa                	mv	a5,a0
    3d22:	c385                	beqz	a5,3d42 <subdir+0x4e>
    printf("%s: mkdir dd failed\n", s);
    3d24:	fd843583          	ld	a1,-40(s0)
    3d28:	00005517          	auipc	a0,0x5
    3d2c:	f9050513          	addi	a0,a0,-112 # 8cb8 <cv_init+0xf32>
    3d30:	00004097          	auipc	ra,0x4
    3d34:	b78080e7          	jalr	-1160(ra) # 78a8 <printf>
    exit(1);
    3d38:	4505                	li	a0,1
    3d3a:	00003097          	auipc	ra,0x3
    3d3e:	636080e7          	jalr	1590(ra) # 7370 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    3d42:	20200593          	li	a1,514
    3d46:	00005517          	auipc	a0,0x5
    3d4a:	f8a50513          	addi	a0,a0,-118 # 8cd0 <cv_init+0xf4a>
    3d4e:	00003097          	auipc	ra,0x3
    3d52:	662080e7          	jalr	1634(ra) # 73b0 <open>
    3d56:	87aa                	mv	a5,a0
    3d58:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3d5c:	fec42783          	lw	a5,-20(s0)
    3d60:	2781                	sext.w	a5,a5
    3d62:	0207d163          	bgez	a5,3d84 <subdir+0x90>
    printf("%s: create dd/ff failed\n", s);
    3d66:	fd843583          	ld	a1,-40(s0)
    3d6a:	00005517          	auipc	a0,0x5
    3d6e:	f6e50513          	addi	a0,a0,-146 # 8cd8 <cv_init+0xf52>
    3d72:	00004097          	auipc	ra,0x4
    3d76:	b36080e7          	jalr	-1226(ra) # 78a8 <printf>
    exit(1);
    3d7a:	4505                	li	a0,1
    3d7c:	00003097          	auipc	ra,0x3
    3d80:	5f4080e7          	jalr	1524(ra) # 7370 <exit>
  }
  write(fd, "ff", 2);
    3d84:	fec42783          	lw	a5,-20(s0)
    3d88:	4609                	li	a2,2
    3d8a:	00005597          	auipc	a1,0x5
    3d8e:	f1e58593          	addi	a1,a1,-226 # 8ca8 <cv_init+0xf22>
    3d92:	853e                	mv	a0,a5
    3d94:	00003097          	auipc	ra,0x3
    3d98:	5fc080e7          	jalr	1532(ra) # 7390 <write>
  close(fd);
    3d9c:	fec42783          	lw	a5,-20(s0)
    3da0:	853e                	mv	a0,a5
    3da2:	00003097          	auipc	ra,0x3
    3da6:	5f6080e7          	jalr	1526(ra) # 7398 <close>

  if(unlink("dd") >= 0){
    3daa:	00005517          	auipc	a0,0x5
    3dae:	f0650513          	addi	a0,a0,-250 # 8cb0 <cv_init+0xf2a>
    3db2:	00003097          	auipc	ra,0x3
    3db6:	60e080e7          	jalr	1550(ra) # 73c0 <unlink>
    3dba:	87aa                	mv	a5,a0
    3dbc:	0207c163          	bltz	a5,3dde <subdir+0xea>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3dc0:	fd843583          	ld	a1,-40(s0)
    3dc4:	00005517          	auipc	a0,0x5
    3dc8:	f3450513          	addi	a0,a0,-204 # 8cf8 <cv_init+0xf72>
    3dcc:	00004097          	auipc	ra,0x4
    3dd0:	adc080e7          	jalr	-1316(ra) # 78a8 <printf>
    exit(1);
    3dd4:	4505                	li	a0,1
    3dd6:	00003097          	auipc	ra,0x3
    3dda:	59a080e7          	jalr	1434(ra) # 7370 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    3dde:	00005517          	auipc	a0,0x5
    3de2:	f4a50513          	addi	a0,a0,-182 # 8d28 <cv_init+0xfa2>
    3de6:	00003097          	auipc	ra,0x3
    3dea:	5f2080e7          	jalr	1522(ra) # 73d8 <mkdir>
    3dee:	87aa                	mv	a5,a0
    3df0:	c385                	beqz	a5,3e10 <subdir+0x11c>
    printf("subdir mkdir dd/dd failed\n", s);
    3df2:	fd843583          	ld	a1,-40(s0)
    3df6:	00005517          	auipc	a0,0x5
    3dfa:	f3a50513          	addi	a0,a0,-198 # 8d30 <cv_init+0xfaa>
    3dfe:	00004097          	auipc	ra,0x4
    3e02:	aaa080e7          	jalr	-1366(ra) # 78a8 <printf>
    exit(1);
    3e06:	4505                	li	a0,1
    3e08:	00003097          	auipc	ra,0x3
    3e0c:	568080e7          	jalr	1384(ra) # 7370 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3e10:	20200593          	li	a1,514
    3e14:	00005517          	auipc	a0,0x5
    3e18:	f3c50513          	addi	a0,a0,-196 # 8d50 <cv_init+0xfca>
    3e1c:	00003097          	auipc	ra,0x3
    3e20:	594080e7          	jalr	1428(ra) # 73b0 <open>
    3e24:	87aa                	mv	a5,a0
    3e26:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3e2a:	fec42783          	lw	a5,-20(s0)
    3e2e:	2781                	sext.w	a5,a5
    3e30:	0207d163          	bgez	a5,3e52 <subdir+0x15e>
    printf("%s: create dd/dd/ff failed\n", s);
    3e34:	fd843583          	ld	a1,-40(s0)
    3e38:	00005517          	auipc	a0,0x5
    3e3c:	f2850513          	addi	a0,a0,-216 # 8d60 <cv_init+0xfda>
    3e40:	00004097          	auipc	ra,0x4
    3e44:	a68080e7          	jalr	-1432(ra) # 78a8 <printf>
    exit(1);
    3e48:	4505                	li	a0,1
    3e4a:	00003097          	auipc	ra,0x3
    3e4e:	526080e7          	jalr	1318(ra) # 7370 <exit>
  }
  write(fd, "FF", 2);
    3e52:	fec42783          	lw	a5,-20(s0)
    3e56:	4609                	li	a2,2
    3e58:	00005597          	auipc	a1,0x5
    3e5c:	f2858593          	addi	a1,a1,-216 # 8d80 <cv_init+0xffa>
    3e60:	853e                	mv	a0,a5
    3e62:	00003097          	auipc	ra,0x3
    3e66:	52e080e7          	jalr	1326(ra) # 7390 <write>
  close(fd);
    3e6a:	fec42783          	lw	a5,-20(s0)
    3e6e:	853e                	mv	a0,a5
    3e70:	00003097          	auipc	ra,0x3
    3e74:	528080e7          	jalr	1320(ra) # 7398 <close>

  fd = open("dd/dd/../ff", 0);
    3e78:	4581                	li	a1,0
    3e7a:	00005517          	auipc	a0,0x5
    3e7e:	f0e50513          	addi	a0,a0,-242 # 8d88 <cv_init+0x1002>
    3e82:	00003097          	auipc	ra,0x3
    3e86:	52e080e7          	jalr	1326(ra) # 73b0 <open>
    3e8a:	87aa                	mv	a5,a0
    3e8c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3e90:	fec42783          	lw	a5,-20(s0)
    3e94:	2781                	sext.w	a5,a5
    3e96:	0207d163          	bgez	a5,3eb8 <subdir+0x1c4>
    printf("%s: open dd/dd/../ff failed\n", s);
    3e9a:	fd843583          	ld	a1,-40(s0)
    3e9e:	00005517          	auipc	a0,0x5
    3ea2:	efa50513          	addi	a0,a0,-262 # 8d98 <cv_init+0x1012>
    3ea6:	00004097          	auipc	ra,0x4
    3eaa:	a02080e7          	jalr	-1534(ra) # 78a8 <printf>
    exit(1);
    3eae:	4505                	li	a0,1
    3eb0:	00003097          	auipc	ra,0x3
    3eb4:	4c0080e7          	jalr	1216(ra) # 7370 <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    3eb8:	fec42783          	lw	a5,-20(s0)
    3ebc:	660d                	lui	a2,0x3
    3ebe:	00006597          	auipc	a1,0x6
    3ec2:	78a58593          	addi	a1,a1,1930 # a648 <buf>
    3ec6:	853e                	mv	a0,a5
    3ec8:	00003097          	auipc	ra,0x3
    3ecc:	4c0080e7          	jalr	1216(ra) # 7388 <read>
    3ed0:	87aa                	mv	a5,a0
    3ed2:	fef42423          	sw	a5,-24(s0)
  if(cc != 2 || buf[0] != 'f'){
    3ed6:	fe842783          	lw	a5,-24(s0)
    3eda:	0007871b          	sext.w	a4,a5
    3ede:	4789                	li	a5,2
    3ee0:	00f71d63          	bne	a4,a5,3efa <subdir+0x206>
    3ee4:	00006797          	auipc	a5,0x6
    3ee8:	76478793          	addi	a5,a5,1892 # a648 <buf>
    3eec:	0007c783          	lbu	a5,0(a5)
    3ef0:	873e                	mv	a4,a5
    3ef2:	06600793          	li	a5,102
    3ef6:	02f70163          	beq	a4,a5,3f18 <subdir+0x224>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3efa:	fd843583          	ld	a1,-40(s0)
    3efe:	00005517          	auipc	a0,0x5
    3f02:	eba50513          	addi	a0,a0,-326 # 8db8 <cv_init+0x1032>
    3f06:	00004097          	auipc	ra,0x4
    3f0a:	9a2080e7          	jalr	-1630(ra) # 78a8 <printf>
    exit(1);
    3f0e:	4505                	li	a0,1
    3f10:	00003097          	auipc	ra,0x3
    3f14:	460080e7          	jalr	1120(ra) # 7370 <exit>
  }
  close(fd);
    3f18:	fec42783          	lw	a5,-20(s0)
    3f1c:	853e                	mv	a0,a5
    3f1e:	00003097          	auipc	ra,0x3
    3f22:	47a080e7          	jalr	1146(ra) # 7398 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    3f26:	00005597          	auipc	a1,0x5
    3f2a:	eb258593          	addi	a1,a1,-334 # 8dd8 <cv_init+0x1052>
    3f2e:	00005517          	auipc	a0,0x5
    3f32:	e2250513          	addi	a0,a0,-478 # 8d50 <cv_init+0xfca>
    3f36:	00003097          	auipc	ra,0x3
    3f3a:	49a080e7          	jalr	1178(ra) # 73d0 <link>
    3f3e:	87aa                	mv	a5,a0
    3f40:	c385                	beqz	a5,3f60 <subdir+0x26c>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3f42:	fd843583          	ld	a1,-40(s0)
    3f46:	00005517          	auipc	a0,0x5
    3f4a:	ea250513          	addi	a0,a0,-350 # 8de8 <cv_init+0x1062>
    3f4e:	00004097          	auipc	ra,0x4
    3f52:	95a080e7          	jalr	-1702(ra) # 78a8 <printf>
    exit(1);
    3f56:	4505                	li	a0,1
    3f58:	00003097          	auipc	ra,0x3
    3f5c:	418080e7          	jalr	1048(ra) # 7370 <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    3f60:	00005517          	auipc	a0,0x5
    3f64:	df050513          	addi	a0,a0,-528 # 8d50 <cv_init+0xfca>
    3f68:	00003097          	auipc	ra,0x3
    3f6c:	458080e7          	jalr	1112(ra) # 73c0 <unlink>
    3f70:	87aa                	mv	a5,a0
    3f72:	c385                	beqz	a5,3f92 <subdir+0x29e>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3f74:	fd843583          	ld	a1,-40(s0)
    3f78:	00005517          	auipc	a0,0x5
    3f7c:	e9850513          	addi	a0,a0,-360 # 8e10 <cv_init+0x108a>
    3f80:	00004097          	auipc	ra,0x4
    3f84:	928080e7          	jalr	-1752(ra) # 78a8 <printf>
    exit(1);
    3f88:	4505                	li	a0,1
    3f8a:	00003097          	auipc	ra,0x3
    3f8e:	3e6080e7          	jalr	998(ra) # 7370 <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3f92:	4581                	li	a1,0
    3f94:	00005517          	auipc	a0,0x5
    3f98:	dbc50513          	addi	a0,a0,-580 # 8d50 <cv_init+0xfca>
    3f9c:	00003097          	auipc	ra,0x3
    3fa0:	414080e7          	jalr	1044(ra) # 73b0 <open>
    3fa4:	87aa                	mv	a5,a0
    3fa6:	0207c163          	bltz	a5,3fc8 <subdir+0x2d4>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3faa:	fd843583          	ld	a1,-40(s0)
    3fae:	00005517          	auipc	a0,0x5
    3fb2:	e8250513          	addi	a0,a0,-382 # 8e30 <cv_init+0x10aa>
    3fb6:	00004097          	auipc	ra,0x4
    3fba:	8f2080e7          	jalr	-1806(ra) # 78a8 <printf>
    exit(1);
    3fbe:	4505                	li	a0,1
    3fc0:	00003097          	auipc	ra,0x3
    3fc4:	3b0080e7          	jalr	944(ra) # 7370 <exit>
  }

  if(chdir("dd") != 0){
    3fc8:	00005517          	auipc	a0,0x5
    3fcc:	ce850513          	addi	a0,a0,-792 # 8cb0 <cv_init+0xf2a>
    3fd0:	00003097          	auipc	ra,0x3
    3fd4:	410080e7          	jalr	1040(ra) # 73e0 <chdir>
    3fd8:	87aa                	mv	a5,a0
    3fda:	c385                	beqz	a5,3ffa <subdir+0x306>
    printf("%s: chdir dd failed\n", s);
    3fdc:	fd843583          	ld	a1,-40(s0)
    3fe0:	00005517          	auipc	a0,0x5
    3fe4:	e7850513          	addi	a0,a0,-392 # 8e58 <cv_init+0x10d2>
    3fe8:	00004097          	auipc	ra,0x4
    3fec:	8c0080e7          	jalr	-1856(ra) # 78a8 <printf>
    exit(1);
    3ff0:	4505                	li	a0,1
    3ff2:	00003097          	auipc	ra,0x3
    3ff6:	37e080e7          	jalr	894(ra) # 7370 <exit>
  }
  if(chdir("dd/../../dd") != 0){
    3ffa:	00005517          	auipc	a0,0x5
    3ffe:	e7650513          	addi	a0,a0,-394 # 8e70 <cv_init+0x10ea>
    4002:	00003097          	auipc	ra,0x3
    4006:	3de080e7          	jalr	990(ra) # 73e0 <chdir>
    400a:	87aa                	mv	a5,a0
    400c:	c385                	beqz	a5,402c <subdir+0x338>
    printf("%s: chdir dd/../../dd failed\n", s);
    400e:	fd843583          	ld	a1,-40(s0)
    4012:	00005517          	auipc	a0,0x5
    4016:	e6e50513          	addi	a0,a0,-402 # 8e80 <cv_init+0x10fa>
    401a:	00004097          	auipc	ra,0x4
    401e:	88e080e7          	jalr	-1906(ra) # 78a8 <printf>
    exit(1);
    4022:	4505                	li	a0,1
    4024:	00003097          	auipc	ra,0x3
    4028:	34c080e7          	jalr	844(ra) # 7370 <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    402c:	00005517          	auipc	a0,0x5
    4030:	e7450513          	addi	a0,a0,-396 # 8ea0 <cv_init+0x111a>
    4034:	00003097          	auipc	ra,0x3
    4038:	3ac080e7          	jalr	940(ra) # 73e0 <chdir>
    403c:	87aa                	mv	a5,a0
    403e:	c385                	beqz	a5,405e <subdir+0x36a>
    printf("chdir dd/../../dd failed\n", s);
    4040:	fd843583          	ld	a1,-40(s0)
    4044:	00005517          	auipc	a0,0x5
    4048:	e6c50513          	addi	a0,a0,-404 # 8eb0 <cv_init+0x112a>
    404c:	00004097          	auipc	ra,0x4
    4050:	85c080e7          	jalr	-1956(ra) # 78a8 <printf>
    exit(1);
    4054:	4505                	li	a0,1
    4056:	00003097          	auipc	ra,0x3
    405a:	31a080e7          	jalr	794(ra) # 7370 <exit>
  }
  if(chdir("./..") != 0){
    405e:	00005517          	auipc	a0,0x5
    4062:	e7250513          	addi	a0,a0,-398 # 8ed0 <cv_init+0x114a>
    4066:	00003097          	auipc	ra,0x3
    406a:	37a080e7          	jalr	890(ra) # 73e0 <chdir>
    406e:	87aa                	mv	a5,a0
    4070:	c385                	beqz	a5,4090 <subdir+0x39c>
    printf("%s: chdir ./.. failed\n", s);
    4072:	fd843583          	ld	a1,-40(s0)
    4076:	00005517          	auipc	a0,0x5
    407a:	e6250513          	addi	a0,a0,-414 # 8ed8 <cv_init+0x1152>
    407e:	00004097          	auipc	ra,0x4
    4082:	82a080e7          	jalr	-2006(ra) # 78a8 <printf>
    exit(1);
    4086:	4505                	li	a0,1
    4088:	00003097          	auipc	ra,0x3
    408c:	2e8080e7          	jalr	744(ra) # 7370 <exit>
  }

  fd = open("dd/dd/ffff", 0);
    4090:	4581                	li	a1,0
    4092:	00005517          	auipc	a0,0x5
    4096:	d4650513          	addi	a0,a0,-698 # 8dd8 <cv_init+0x1052>
    409a:	00003097          	auipc	ra,0x3
    409e:	316080e7          	jalr	790(ra) # 73b0 <open>
    40a2:	87aa                	mv	a5,a0
    40a4:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    40a8:	fec42783          	lw	a5,-20(s0)
    40ac:	2781                	sext.w	a5,a5
    40ae:	0207d163          	bgez	a5,40d0 <subdir+0x3dc>
    printf("%s: open dd/dd/ffff failed\n", s);
    40b2:	fd843583          	ld	a1,-40(s0)
    40b6:	00005517          	auipc	a0,0x5
    40ba:	e3a50513          	addi	a0,a0,-454 # 8ef0 <cv_init+0x116a>
    40be:	00003097          	auipc	ra,0x3
    40c2:	7ea080e7          	jalr	2026(ra) # 78a8 <printf>
    exit(1);
    40c6:	4505                	li	a0,1
    40c8:	00003097          	auipc	ra,0x3
    40cc:	2a8080e7          	jalr	680(ra) # 7370 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    40d0:	fec42783          	lw	a5,-20(s0)
    40d4:	660d                	lui	a2,0x3
    40d6:	00006597          	auipc	a1,0x6
    40da:	57258593          	addi	a1,a1,1394 # a648 <buf>
    40de:	853e                	mv	a0,a5
    40e0:	00003097          	auipc	ra,0x3
    40e4:	2a8080e7          	jalr	680(ra) # 7388 <read>
    40e8:	87aa                	mv	a5,a0
    40ea:	873e                	mv	a4,a5
    40ec:	4789                	li	a5,2
    40ee:	02f70163          	beq	a4,a5,4110 <subdir+0x41c>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    40f2:	fd843583          	ld	a1,-40(s0)
    40f6:	00005517          	auipc	a0,0x5
    40fa:	e1a50513          	addi	a0,a0,-486 # 8f10 <cv_init+0x118a>
    40fe:	00003097          	auipc	ra,0x3
    4102:	7aa080e7          	jalr	1962(ra) # 78a8 <printf>
    exit(1);
    4106:	4505                	li	a0,1
    4108:	00003097          	auipc	ra,0x3
    410c:	268080e7          	jalr	616(ra) # 7370 <exit>
  }
  close(fd);
    4110:	fec42783          	lw	a5,-20(s0)
    4114:	853e                	mv	a0,a5
    4116:	00003097          	auipc	ra,0x3
    411a:	282080e7          	jalr	642(ra) # 7398 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    411e:	4581                	li	a1,0
    4120:	00005517          	auipc	a0,0x5
    4124:	c3050513          	addi	a0,a0,-976 # 8d50 <cv_init+0xfca>
    4128:	00003097          	auipc	ra,0x3
    412c:	288080e7          	jalr	648(ra) # 73b0 <open>
    4130:	87aa                	mv	a5,a0
    4132:	0207c163          	bltz	a5,4154 <subdir+0x460>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    4136:	fd843583          	ld	a1,-40(s0)
    413a:	00005517          	auipc	a0,0x5
    413e:	df650513          	addi	a0,a0,-522 # 8f30 <cv_init+0x11aa>
    4142:	00003097          	auipc	ra,0x3
    4146:	766080e7          	jalr	1894(ra) # 78a8 <printf>
    exit(1);
    414a:	4505                	li	a0,1
    414c:	00003097          	auipc	ra,0x3
    4150:	224080e7          	jalr	548(ra) # 7370 <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    4154:	20200593          	li	a1,514
    4158:	00005517          	auipc	a0,0x5
    415c:	e0850513          	addi	a0,a0,-504 # 8f60 <cv_init+0x11da>
    4160:	00003097          	auipc	ra,0x3
    4164:	250080e7          	jalr	592(ra) # 73b0 <open>
    4168:	87aa                	mv	a5,a0
    416a:	0207c163          	bltz	a5,418c <subdir+0x498>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    416e:	fd843583          	ld	a1,-40(s0)
    4172:	00005517          	auipc	a0,0x5
    4176:	dfe50513          	addi	a0,a0,-514 # 8f70 <cv_init+0x11ea>
    417a:	00003097          	auipc	ra,0x3
    417e:	72e080e7          	jalr	1838(ra) # 78a8 <printf>
    exit(1);
    4182:	4505                	li	a0,1
    4184:	00003097          	auipc	ra,0x3
    4188:	1ec080e7          	jalr	492(ra) # 7370 <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    418c:	20200593          	li	a1,514
    4190:	00005517          	auipc	a0,0x5
    4194:	e0050513          	addi	a0,a0,-512 # 8f90 <cv_init+0x120a>
    4198:	00003097          	auipc	ra,0x3
    419c:	218080e7          	jalr	536(ra) # 73b0 <open>
    41a0:	87aa                	mv	a5,a0
    41a2:	0207c163          	bltz	a5,41c4 <subdir+0x4d0>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    41a6:	fd843583          	ld	a1,-40(s0)
    41aa:	00005517          	auipc	a0,0x5
    41ae:	df650513          	addi	a0,a0,-522 # 8fa0 <cv_init+0x121a>
    41b2:	00003097          	auipc	ra,0x3
    41b6:	6f6080e7          	jalr	1782(ra) # 78a8 <printf>
    exit(1);
    41ba:	4505                	li	a0,1
    41bc:	00003097          	auipc	ra,0x3
    41c0:	1b4080e7          	jalr	436(ra) # 7370 <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    41c4:	20000593          	li	a1,512
    41c8:	00005517          	auipc	a0,0x5
    41cc:	ae850513          	addi	a0,a0,-1304 # 8cb0 <cv_init+0xf2a>
    41d0:	00003097          	auipc	ra,0x3
    41d4:	1e0080e7          	jalr	480(ra) # 73b0 <open>
    41d8:	87aa                	mv	a5,a0
    41da:	0207c163          	bltz	a5,41fc <subdir+0x508>
    printf("%s: create dd succeeded!\n", s);
    41de:	fd843583          	ld	a1,-40(s0)
    41e2:	00005517          	auipc	a0,0x5
    41e6:	dde50513          	addi	a0,a0,-546 # 8fc0 <cv_init+0x123a>
    41ea:	00003097          	auipc	ra,0x3
    41ee:	6be080e7          	jalr	1726(ra) # 78a8 <printf>
    exit(1);
    41f2:	4505                	li	a0,1
    41f4:	00003097          	auipc	ra,0x3
    41f8:	17c080e7          	jalr	380(ra) # 7370 <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    41fc:	4589                	li	a1,2
    41fe:	00005517          	auipc	a0,0x5
    4202:	ab250513          	addi	a0,a0,-1358 # 8cb0 <cv_init+0xf2a>
    4206:	00003097          	auipc	ra,0x3
    420a:	1aa080e7          	jalr	426(ra) # 73b0 <open>
    420e:	87aa                	mv	a5,a0
    4210:	0207c163          	bltz	a5,4232 <subdir+0x53e>
    printf("%s: open dd rdwr succeeded!\n", s);
    4214:	fd843583          	ld	a1,-40(s0)
    4218:	00005517          	auipc	a0,0x5
    421c:	dc850513          	addi	a0,a0,-568 # 8fe0 <cv_init+0x125a>
    4220:	00003097          	auipc	ra,0x3
    4224:	688080e7          	jalr	1672(ra) # 78a8 <printf>
    exit(1);
    4228:	4505                	li	a0,1
    422a:	00003097          	auipc	ra,0x3
    422e:	146080e7          	jalr	326(ra) # 7370 <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    4232:	4585                	li	a1,1
    4234:	00005517          	auipc	a0,0x5
    4238:	a7c50513          	addi	a0,a0,-1412 # 8cb0 <cv_init+0xf2a>
    423c:	00003097          	auipc	ra,0x3
    4240:	174080e7          	jalr	372(ra) # 73b0 <open>
    4244:	87aa                	mv	a5,a0
    4246:	0207c163          	bltz	a5,4268 <subdir+0x574>
    printf("%s: open dd wronly succeeded!\n", s);
    424a:	fd843583          	ld	a1,-40(s0)
    424e:	00005517          	auipc	a0,0x5
    4252:	db250513          	addi	a0,a0,-590 # 9000 <cv_init+0x127a>
    4256:	00003097          	auipc	ra,0x3
    425a:	652080e7          	jalr	1618(ra) # 78a8 <printf>
    exit(1);
    425e:	4505                	li	a0,1
    4260:	00003097          	auipc	ra,0x3
    4264:	110080e7          	jalr	272(ra) # 7370 <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    4268:	00005597          	auipc	a1,0x5
    426c:	db858593          	addi	a1,a1,-584 # 9020 <cv_init+0x129a>
    4270:	00005517          	auipc	a0,0x5
    4274:	cf050513          	addi	a0,a0,-784 # 8f60 <cv_init+0x11da>
    4278:	00003097          	auipc	ra,0x3
    427c:	158080e7          	jalr	344(ra) # 73d0 <link>
    4280:	87aa                	mv	a5,a0
    4282:	e385                	bnez	a5,42a2 <subdir+0x5ae>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    4284:	fd843583          	ld	a1,-40(s0)
    4288:	00005517          	auipc	a0,0x5
    428c:	da850513          	addi	a0,a0,-600 # 9030 <cv_init+0x12aa>
    4290:	00003097          	auipc	ra,0x3
    4294:	618080e7          	jalr	1560(ra) # 78a8 <printf>
    exit(1);
    4298:	4505                	li	a0,1
    429a:	00003097          	auipc	ra,0x3
    429e:	0d6080e7          	jalr	214(ra) # 7370 <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    42a2:	00005597          	auipc	a1,0x5
    42a6:	d7e58593          	addi	a1,a1,-642 # 9020 <cv_init+0x129a>
    42aa:	00005517          	auipc	a0,0x5
    42ae:	ce650513          	addi	a0,a0,-794 # 8f90 <cv_init+0x120a>
    42b2:	00003097          	auipc	ra,0x3
    42b6:	11e080e7          	jalr	286(ra) # 73d0 <link>
    42ba:	87aa                	mv	a5,a0
    42bc:	e385                	bnez	a5,42dc <subdir+0x5e8>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    42be:	fd843583          	ld	a1,-40(s0)
    42c2:	00005517          	auipc	a0,0x5
    42c6:	d9650513          	addi	a0,a0,-618 # 9058 <cv_init+0x12d2>
    42ca:	00003097          	auipc	ra,0x3
    42ce:	5de080e7          	jalr	1502(ra) # 78a8 <printf>
    exit(1);
    42d2:	4505                	li	a0,1
    42d4:	00003097          	auipc	ra,0x3
    42d8:	09c080e7          	jalr	156(ra) # 7370 <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    42dc:	00005597          	auipc	a1,0x5
    42e0:	afc58593          	addi	a1,a1,-1284 # 8dd8 <cv_init+0x1052>
    42e4:	00005517          	auipc	a0,0x5
    42e8:	9ec50513          	addi	a0,a0,-1556 # 8cd0 <cv_init+0xf4a>
    42ec:	00003097          	auipc	ra,0x3
    42f0:	0e4080e7          	jalr	228(ra) # 73d0 <link>
    42f4:	87aa                	mv	a5,a0
    42f6:	e385                	bnez	a5,4316 <subdir+0x622>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    42f8:	fd843583          	ld	a1,-40(s0)
    42fc:	00005517          	auipc	a0,0x5
    4300:	d8450513          	addi	a0,a0,-636 # 9080 <cv_init+0x12fa>
    4304:	00003097          	auipc	ra,0x3
    4308:	5a4080e7          	jalr	1444(ra) # 78a8 <printf>
    exit(1);
    430c:	4505                	li	a0,1
    430e:	00003097          	auipc	ra,0x3
    4312:	062080e7          	jalr	98(ra) # 7370 <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    4316:	00005517          	auipc	a0,0x5
    431a:	c4a50513          	addi	a0,a0,-950 # 8f60 <cv_init+0x11da>
    431e:	00003097          	auipc	ra,0x3
    4322:	0ba080e7          	jalr	186(ra) # 73d8 <mkdir>
    4326:	87aa                	mv	a5,a0
    4328:	e385                	bnez	a5,4348 <subdir+0x654>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    432a:	fd843583          	ld	a1,-40(s0)
    432e:	00005517          	auipc	a0,0x5
    4332:	d7a50513          	addi	a0,a0,-646 # 90a8 <cv_init+0x1322>
    4336:	00003097          	auipc	ra,0x3
    433a:	572080e7          	jalr	1394(ra) # 78a8 <printf>
    exit(1);
    433e:	4505                	li	a0,1
    4340:	00003097          	auipc	ra,0x3
    4344:	030080e7          	jalr	48(ra) # 7370 <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    4348:	00005517          	auipc	a0,0x5
    434c:	c4850513          	addi	a0,a0,-952 # 8f90 <cv_init+0x120a>
    4350:	00003097          	auipc	ra,0x3
    4354:	088080e7          	jalr	136(ra) # 73d8 <mkdir>
    4358:	87aa                	mv	a5,a0
    435a:	e385                	bnez	a5,437a <subdir+0x686>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    435c:	fd843583          	ld	a1,-40(s0)
    4360:	00005517          	auipc	a0,0x5
    4364:	d6850513          	addi	a0,a0,-664 # 90c8 <cv_init+0x1342>
    4368:	00003097          	auipc	ra,0x3
    436c:	540080e7          	jalr	1344(ra) # 78a8 <printf>
    exit(1);
    4370:	4505                	li	a0,1
    4372:	00003097          	auipc	ra,0x3
    4376:	ffe080e7          	jalr	-2(ra) # 7370 <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    437a:	00005517          	auipc	a0,0x5
    437e:	a5e50513          	addi	a0,a0,-1442 # 8dd8 <cv_init+0x1052>
    4382:	00003097          	auipc	ra,0x3
    4386:	056080e7          	jalr	86(ra) # 73d8 <mkdir>
    438a:	87aa                	mv	a5,a0
    438c:	e385                	bnez	a5,43ac <subdir+0x6b8>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    438e:	fd843583          	ld	a1,-40(s0)
    4392:	00005517          	auipc	a0,0x5
    4396:	d5650513          	addi	a0,a0,-682 # 90e8 <cv_init+0x1362>
    439a:	00003097          	auipc	ra,0x3
    439e:	50e080e7          	jalr	1294(ra) # 78a8 <printf>
    exit(1);
    43a2:	4505                	li	a0,1
    43a4:	00003097          	auipc	ra,0x3
    43a8:	fcc080e7          	jalr	-52(ra) # 7370 <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    43ac:	00005517          	auipc	a0,0x5
    43b0:	be450513          	addi	a0,a0,-1052 # 8f90 <cv_init+0x120a>
    43b4:	00003097          	auipc	ra,0x3
    43b8:	00c080e7          	jalr	12(ra) # 73c0 <unlink>
    43bc:	87aa                	mv	a5,a0
    43be:	e385                	bnez	a5,43de <subdir+0x6ea>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    43c0:	fd843583          	ld	a1,-40(s0)
    43c4:	00005517          	auipc	a0,0x5
    43c8:	d4c50513          	addi	a0,a0,-692 # 9110 <cv_init+0x138a>
    43cc:	00003097          	auipc	ra,0x3
    43d0:	4dc080e7          	jalr	1244(ra) # 78a8 <printf>
    exit(1);
    43d4:	4505                	li	a0,1
    43d6:	00003097          	auipc	ra,0x3
    43da:	f9a080e7          	jalr	-102(ra) # 7370 <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    43de:	00005517          	auipc	a0,0x5
    43e2:	b8250513          	addi	a0,a0,-1150 # 8f60 <cv_init+0x11da>
    43e6:	00003097          	auipc	ra,0x3
    43ea:	fda080e7          	jalr	-38(ra) # 73c0 <unlink>
    43ee:	87aa                	mv	a5,a0
    43f0:	e385                	bnez	a5,4410 <subdir+0x71c>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    43f2:	fd843583          	ld	a1,-40(s0)
    43f6:	00005517          	auipc	a0,0x5
    43fa:	d3a50513          	addi	a0,a0,-710 # 9130 <cv_init+0x13aa>
    43fe:	00003097          	auipc	ra,0x3
    4402:	4aa080e7          	jalr	1194(ra) # 78a8 <printf>
    exit(1);
    4406:	4505                	li	a0,1
    4408:	00003097          	auipc	ra,0x3
    440c:	f68080e7          	jalr	-152(ra) # 7370 <exit>
  }
  if(chdir("dd/ff") == 0){
    4410:	00005517          	auipc	a0,0x5
    4414:	8c050513          	addi	a0,a0,-1856 # 8cd0 <cv_init+0xf4a>
    4418:	00003097          	auipc	ra,0x3
    441c:	fc8080e7          	jalr	-56(ra) # 73e0 <chdir>
    4420:	87aa                	mv	a5,a0
    4422:	e385                	bnez	a5,4442 <subdir+0x74e>
    printf("%s: chdir dd/ff succeeded!\n", s);
    4424:	fd843583          	ld	a1,-40(s0)
    4428:	00005517          	auipc	a0,0x5
    442c:	d2850513          	addi	a0,a0,-728 # 9150 <cv_init+0x13ca>
    4430:	00003097          	auipc	ra,0x3
    4434:	478080e7          	jalr	1144(ra) # 78a8 <printf>
    exit(1);
    4438:	4505                	li	a0,1
    443a:	00003097          	auipc	ra,0x3
    443e:	f36080e7          	jalr	-202(ra) # 7370 <exit>
  }
  if(chdir("dd/xx") == 0){
    4442:	00005517          	auipc	a0,0x5
    4446:	d2e50513          	addi	a0,a0,-722 # 9170 <cv_init+0x13ea>
    444a:	00003097          	auipc	ra,0x3
    444e:	f96080e7          	jalr	-106(ra) # 73e0 <chdir>
    4452:	87aa                	mv	a5,a0
    4454:	e385                	bnez	a5,4474 <subdir+0x780>
    printf("%s: chdir dd/xx succeeded!\n", s);
    4456:	fd843583          	ld	a1,-40(s0)
    445a:	00005517          	auipc	a0,0x5
    445e:	d1e50513          	addi	a0,a0,-738 # 9178 <cv_init+0x13f2>
    4462:	00003097          	auipc	ra,0x3
    4466:	446080e7          	jalr	1094(ra) # 78a8 <printf>
    exit(1);
    446a:	4505                	li	a0,1
    446c:	00003097          	auipc	ra,0x3
    4470:	f04080e7          	jalr	-252(ra) # 7370 <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    4474:	00005517          	auipc	a0,0x5
    4478:	96450513          	addi	a0,a0,-1692 # 8dd8 <cv_init+0x1052>
    447c:	00003097          	auipc	ra,0x3
    4480:	f44080e7          	jalr	-188(ra) # 73c0 <unlink>
    4484:	87aa                	mv	a5,a0
    4486:	c385                	beqz	a5,44a6 <subdir+0x7b2>
    printf("%s: unlink dd/dd/ff failed\n", s);
    4488:	fd843583          	ld	a1,-40(s0)
    448c:	00005517          	auipc	a0,0x5
    4490:	98450513          	addi	a0,a0,-1660 # 8e10 <cv_init+0x108a>
    4494:	00003097          	auipc	ra,0x3
    4498:	414080e7          	jalr	1044(ra) # 78a8 <printf>
    exit(1);
    449c:	4505                	li	a0,1
    449e:	00003097          	auipc	ra,0x3
    44a2:	ed2080e7          	jalr	-302(ra) # 7370 <exit>
  }
  if(unlink("dd/ff") != 0){
    44a6:	00005517          	auipc	a0,0x5
    44aa:	82a50513          	addi	a0,a0,-2006 # 8cd0 <cv_init+0xf4a>
    44ae:	00003097          	auipc	ra,0x3
    44b2:	f12080e7          	jalr	-238(ra) # 73c0 <unlink>
    44b6:	87aa                	mv	a5,a0
    44b8:	c385                	beqz	a5,44d8 <subdir+0x7e4>
    printf("%s: unlink dd/ff failed\n", s);
    44ba:	fd843583          	ld	a1,-40(s0)
    44be:	00005517          	auipc	a0,0x5
    44c2:	cda50513          	addi	a0,a0,-806 # 9198 <cv_init+0x1412>
    44c6:	00003097          	auipc	ra,0x3
    44ca:	3e2080e7          	jalr	994(ra) # 78a8 <printf>
    exit(1);
    44ce:	4505                	li	a0,1
    44d0:	00003097          	auipc	ra,0x3
    44d4:	ea0080e7          	jalr	-352(ra) # 7370 <exit>
  }
  if(unlink("dd") == 0){
    44d8:	00004517          	auipc	a0,0x4
    44dc:	7d850513          	addi	a0,a0,2008 # 8cb0 <cv_init+0xf2a>
    44e0:	00003097          	auipc	ra,0x3
    44e4:	ee0080e7          	jalr	-288(ra) # 73c0 <unlink>
    44e8:	87aa                	mv	a5,a0
    44ea:	e385                	bnez	a5,450a <subdir+0x816>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    44ec:	fd843583          	ld	a1,-40(s0)
    44f0:	00005517          	auipc	a0,0x5
    44f4:	cc850513          	addi	a0,a0,-824 # 91b8 <cv_init+0x1432>
    44f8:	00003097          	auipc	ra,0x3
    44fc:	3b0080e7          	jalr	944(ra) # 78a8 <printf>
    exit(1);
    4500:	4505                	li	a0,1
    4502:	00003097          	auipc	ra,0x3
    4506:	e6e080e7          	jalr	-402(ra) # 7370 <exit>
  }
  if(unlink("dd/dd") < 0){
    450a:	00005517          	auipc	a0,0x5
    450e:	cd650513          	addi	a0,a0,-810 # 91e0 <cv_init+0x145a>
    4512:	00003097          	auipc	ra,0x3
    4516:	eae080e7          	jalr	-338(ra) # 73c0 <unlink>
    451a:	87aa                	mv	a5,a0
    451c:	0207d163          	bgez	a5,453e <subdir+0x84a>
    printf("%s: unlink dd/dd failed\n", s);
    4520:	fd843583          	ld	a1,-40(s0)
    4524:	00005517          	auipc	a0,0x5
    4528:	cc450513          	addi	a0,a0,-828 # 91e8 <cv_init+0x1462>
    452c:	00003097          	auipc	ra,0x3
    4530:	37c080e7          	jalr	892(ra) # 78a8 <printf>
    exit(1);
    4534:	4505                	li	a0,1
    4536:	00003097          	auipc	ra,0x3
    453a:	e3a080e7          	jalr	-454(ra) # 7370 <exit>
  }
  if(unlink("dd") < 0){
    453e:	00004517          	auipc	a0,0x4
    4542:	77250513          	addi	a0,a0,1906 # 8cb0 <cv_init+0xf2a>
    4546:	00003097          	auipc	ra,0x3
    454a:	e7a080e7          	jalr	-390(ra) # 73c0 <unlink>
    454e:	87aa                	mv	a5,a0
    4550:	0207d163          	bgez	a5,4572 <subdir+0x87e>
    printf("%s: unlink dd failed\n", s);
    4554:	fd843583          	ld	a1,-40(s0)
    4558:	00005517          	auipc	a0,0x5
    455c:	cb050513          	addi	a0,a0,-848 # 9208 <cv_init+0x1482>
    4560:	00003097          	auipc	ra,0x3
    4564:	348080e7          	jalr	840(ra) # 78a8 <printf>
    exit(1);
    4568:	4505                	li	a0,1
    456a:	00003097          	auipc	ra,0x3
    456e:	e06080e7          	jalr	-506(ra) # 7370 <exit>
  }
}
    4572:	0001                	nop
    4574:	70a2                	ld	ra,40(sp)
    4576:	7402                	ld	s0,32(sp)
    4578:	6145                	addi	sp,sp,48
    457a:	8082                	ret

000000000000457c <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(char *s)
{
    457c:	7179                	addi	sp,sp,-48
    457e:	f406                	sd	ra,40(sp)
    4580:	f022                	sd	s0,32(sp)
    4582:	1800                	addi	s0,sp,48
    4584:	fca43c23          	sd	a0,-40(s0)
  int fd, sz;

  unlink("bigwrite");
    4588:	00005517          	auipc	a0,0x5
    458c:	c9850513          	addi	a0,a0,-872 # 9220 <cv_init+0x149a>
    4590:	00003097          	auipc	ra,0x3
    4594:	e30080e7          	jalr	-464(ra) # 73c0 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    4598:	1f300793          	li	a5,499
    459c:	fef42623          	sw	a5,-20(s0)
    45a0:	a0ed                	j	468a <bigwrite+0x10e>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    45a2:	20200593          	li	a1,514
    45a6:	00005517          	auipc	a0,0x5
    45aa:	c7a50513          	addi	a0,a0,-902 # 9220 <cv_init+0x149a>
    45ae:	00003097          	auipc	ra,0x3
    45b2:	e02080e7          	jalr	-510(ra) # 73b0 <open>
    45b6:	87aa                	mv	a5,a0
    45b8:	fef42223          	sw	a5,-28(s0)
    if(fd < 0){
    45bc:	fe442783          	lw	a5,-28(s0)
    45c0:	2781                	sext.w	a5,a5
    45c2:	0207d163          	bgez	a5,45e4 <bigwrite+0x68>
      printf("%s: cannot create bigwrite\n", s);
    45c6:	fd843583          	ld	a1,-40(s0)
    45ca:	00005517          	auipc	a0,0x5
    45ce:	c6650513          	addi	a0,a0,-922 # 9230 <cv_init+0x14aa>
    45d2:	00003097          	auipc	ra,0x3
    45d6:	2d6080e7          	jalr	726(ra) # 78a8 <printf>
      exit(1);
    45da:	4505                	li	a0,1
    45dc:	00003097          	auipc	ra,0x3
    45e0:	d94080e7          	jalr	-620(ra) # 7370 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    45e4:	fe042423          	sw	zero,-24(s0)
    45e8:	a0ad                	j	4652 <bigwrite+0xd6>
      int cc = write(fd, buf, sz);
    45ea:	fec42703          	lw	a4,-20(s0)
    45ee:	fe442783          	lw	a5,-28(s0)
    45f2:	863a                	mv	a2,a4
    45f4:	00006597          	auipc	a1,0x6
    45f8:	05458593          	addi	a1,a1,84 # a648 <buf>
    45fc:	853e                	mv	a0,a5
    45fe:	00003097          	auipc	ra,0x3
    4602:	d92080e7          	jalr	-622(ra) # 7390 <write>
    4606:	87aa                	mv	a5,a0
    4608:	fef42023          	sw	a5,-32(s0)
      if(cc != sz){
    460c:	fe042783          	lw	a5,-32(s0)
    4610:	873e                	mv	a4,a5
    4612:	fec42783          	lw	a5,-20(s0)
    4616:	2701                	sext.w	a4,a4
    4618:	2781                	sext.w	a5,a5
    461a:	02f70763          	beq	a4,a5,4648 <bigwrite+0xcc>
        printf("%s: write(%d) ret %d\n", s, sz, cc);
    461e:	fe042703          	lw	a4,-32(s0)
    4622:	fec42783          	lw	a5,-20(s0)
    4626:	86ba                	mv	a3,a4
    4628:	863e                	mv	a2,a5
    462a:	fd843583          	ld	a1,-40(s0)
    462e:	00005517          	auipc	a0,0x5
    4632:	c2250513          	addi	a0,a0,-990 # 9250 <cv_init+0x14ca>
    4636:	00003097          	auipc	ra,0x3
    463a:	272080e7          	jalr	626(ra) # 78a8 <printf>
        exit(1);
    463e:	4505                	li	a0,1
    4640:	00003097          	auipc	ra,0x3
    4644:	d30080e7          	jalr	-720(ra) # 7370 <exit>
    for(i = 0; i < 2; i++){
    4648:	fe842783          	lw	a5,-24(s0)
    464c:	2785                	addiw	a5,a5,1
    464e:	fef42423          	sw	a5,-24(s0)
    4652:	fe842783          	lw	a5,-24(s0)
    4656:	0007871b          	sext.w	a4,a5
    465a:	4785                	li	a5,1
    465c:	f8e7d7e3          	bge	a5,a4,45ea <bigwrite+0x6e>
      }
    }
    close(fd);
    4660:	fe442783          	lw	a5,-28(s0)
    4664:	853e                	mv	a0,a5
    4666:	00003097          	auipc	ra,0x3
    466a:	d32080e7          	jalr	-718(ra) # 7398 <close>
    unlink("bigwrite");
    466e:	00005517          	auipc	a0,0x5
    4672:	bb250513          	addi	a0,a0,-1102 # 9220 <cv_init+0x149a>
    4676:	00003097          	auipc	ra,0x3
    467a:	d4a080e7          	jalr	-694(ra) # 73c0 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    467e:	fec42783          	lw	a5,-20(s0)
    4682:	1d77879b          	addiw	a5,a5,471
    4686:	fef42623          	sw	a5,-20(s0)
    468a:	fec42783          	lw	a5,-20(s0)
    468e:	0007871b          	sext.w	a4,a5
    4692:	678d                	lui	a5,0x3
    4694:	f0f747e3          	blt	a4,a5,45a2 <bigwrite+0x26>
  }
}
    4698:	0001                	nop
    469a:	0001                	nop
    469c:	70a2                	ld	ra,40(sp)
    469e:	7402                	ld	s0,32(sp)
    46a0:	6145                	addi	sp,sp,48
    46a2:	8082                	ret

00000000000046a4 <manywrites>:

// concurrent writes to try to provoke deadlock in the virtio disk
// driver.
void
manywrites(char *s)
{
    46a4:	711d                	addi	sp,sp,-96
    46a6:	ec86                	sd	ra,88(sp)
    46a8:	e8a2                	sd	s0,80(sp)
    46aa:	1080                	addi	s0,sp,96
    46ac:	faa43423          	sd	a0,-88(s0)
  int nchildren = 4;
    46b0:	4791                	li	a5,4
    46b2:	fcf42e23          	sw	a5,-36(s0)
  int howmany = 30; // increase to look for deadlock
    46b6:	47f9                	li	a5,30
    46b8:	fcf42c23          	sw	a5,-40(s0)
  
  for(int ci = 0; ci < nchildren; ci++){
    46bc:	fe042623          	sw	zero,-20(s0)
    46c0:	aa61                	j	4858 <manywrites+0x1b4>
    int pid = fork();
    46c2:	00003097          	auipc	ra,0x3
    46c6:	ca6080e7          	jalr	-858(ra) # 7368 <fork>
    46ca:	87aa                	mv	a5,a0
    46cc:	fcf42a23          	sw	a5,-44(s0)
    if(pid < 0){
    46d0:	fd442783          	lw	a5,-44(s0)
    46d4:	2781                	sext.w	a5,a5
    46d6:	0007df63          	bgez	a5,46f4 <manywrites+0x50>
      printf("fork failed\n");
    46da:	00004517          	auipc	a0,0x4
    46de:	8d650513          	addi	a0,a0,-1834 # 7fb0 <cv_init+0x22a>
    46e2:	00003097          	auipc	ra,0x3
    46e6:	1c6080e7          	jalr	454(ra) # 78a8 <printf>
      exit(1);
    46ea:	4505                	li	a0,1
    46ec:	00003097          	auipc	ra,0x3
    46f0:	c84080e7          	jalr	-892(ra) # 7370 <exit>
    }

    if(pid == 0){
    46f4:	fd442783          	lw	a5,-44(s0)
    46f8:	2781                	sext.w	a5,a5
    46fa:	14079a63          	bnez	a5,484e <manywrites+0x1aa>
      char name[3];
      name[0] = 'b';
    46fe:	06200793          	li	a5,98
    4702:	fcf40023          	sb	a5,-64(s0)
      name[1] = 'a' + ci;
    4706:	fec42783          	lw	a5,-20(s0)
    470a:	0ff7f793          	zext.b	a5,a5
    470e:	0617879b          	addiw	a5,a5,97
    4712:	0ff7f793          	zext.b	a5,a5
    4716:	fcf400a3          	sb	a5,-63(s0)
      name[2] = '\0';
    471a:	fc040123          	sb	zero,-62(s0)
      unlink(name);
    471e:	fc040793          	addi	a5,s0,-64
    4722:	853e                	mv	a0,a5
    4724:	00003097          	auipc	ra,0x3
    4728:	c9c080e7          	jalr	-868(ra) # 73c0 <unlink>
      
      for(int iters = 0; iters < howmany; iters++){
    472c:	fe042423          	sw	zero,-24(s0)
    4730:	a8d5                	j	4824 <manywrites+0x180>
        for(int i = 0; i < ci+1; i++){
    4732:	fe042223          	sw	zero,-28(s0)
    4736:	a0d1                	j	47fa <manywrites+0x156>
          int fd = open(name, O_CREATE | O_RDWR);
    4738:	fc040793          	addi	a5,s0,-64
    473c:	20200593          	li	a1,514
    4740:	853e                	mv	a0,a5
    4742:	00003097          	auipc	ra,0x3
    4746:	c6e080e7          	jalr	-914(ra) # 73b0 <open>
    474a:	87aa                	mv	a5,a0
    474c:	fcf42823          	sw	a5,-48(s0)
          if(fd < 0){
    4750:	fd042783          	lw	a5,-48(s0)
    4754:	2781                	sext.w	a5,a5
    4756:	0207d463          	bgez	a5,477e <manywrites+0xda>
            printf("%s: cannot create %s\n", s, name);
    475a:	fc040793          	addi	a5,s0,-64
    475e:	863e                	mv	a2,a5
    4760:	fa843583          	ld	a1,-88(s0)
    4764:	00005517          	auipc	a0,0x5
    4768:	b0450513          	addi	a0,a0,-1276 # 9268 <cv_init+0x14e2>
    476c:	00003097          	auipc	ra,0x3
    4770:	13c080e7          	jalr	316(ra) # 78a8 <printf>
            exit(1);
    4774:	4505                	li	a0,1
    4776:	00003097          	auipc	ra,0x3
    477a:	bfa080e7          	jalr	-1030(ra) # 7370 <exit>
          }
          int sz = sizeof(buf);
    477e:	678d                	lui	a5,0x3
    4780:	fcf42623          	sw	a5,-52(s0)
          int cc = write(fd, buf, sz);
    4784:	fcc42703          	lw	a4,-52(s0)
    4788:	fd042783          	lw	a5,-48(s0)
    478c:	863a                	mv	a2,a4
    478e:	00006597          	auipc	a1,0x6
    4792:	eba58593          	addi	a1,a1,-326 # a648 <buf>
    4796:	853e                	mv	a0,a5
    4798:	00003097          	auipc	ra,0x3
    479c:	bf8080e7          	jalr	-1032(ra) # 7390 <write>
    47a0:	87aa                	mv	a5,a0
    47a2:	fcf42423          	sw	a5,-56(s0)
          if(cc != sz){
    47a6:	fc842783          	lw	a5,-56(s0)
    47aa:	873e                	mv	a4,a5
    47ac:	fcc42783          	lw	a5,-52(s0)
    47b0:	2701                	sext.w	a4,a4
    47b2:	2781                	sext.w	a5,a5
    47b4:	02f70763          	beq	a4,a5,47e2 <manywrites+0x13e>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    47b8:	fc842703          	lw	a4,-56(s0)
    47bc:	fcc42783          	lw	a5,-52(s0)
    47c0:	86ba                	mv	a3,a4
    47c2:	863e                	mv	a2,a5
    47c4:	fa843583          	ld	a1,-88(s0)
    47c8:	00005517          	auipc	a0,0x5
    47cc:	a8850513          	addi	a0,a0,-1400 # 9250 <cv_init+0x14ca>
    47d0:	00003097          	auipc	ra,0x3
    47d4:	0d8080e7          	jalr	216(ra) # 78a8 <printf>
            exit(1);
    47d8:	4505                	li	a0,1
    47da:	00003097          	auipc	ra,0x3
    47de:	b96080e7          	jalr	-1130(ra) # 7370 <exit>
          }
          close(fd);
    47e2:	fd042783          	lw	a5,-48(s0)
    47e6:	853e                	mv	a0,a5
    47e8:	00003097          	auipc	ra,0x3
    47ec:	bb0080e7          	jalr	-1104(ra) # 7398 <close>
        for(int i = 0; i < ci+1; i++){
    47f0:	fe442783          	lw	a5,-28(s0)
    47f4:	2785                	addiw	a5,a5,1
    47f6:	fef42223          	sw	a5,-28(s0)
    47fa:	fec42783          	lw	a5,-20(s0)
    47fe:	873e                	mv	a4,a5
    4800:	fe442783          	lw	a5,-28(s0)
    4804:	2701                	sext.w	a4,a4
    4806:	2781                	sext.w	a5,a5
    4808:	f2f758e3          	bge	a4,a5,4738 <manywrites+0x94>
        }
        unlink(name);
    480c:	fc040793          	addi	a5,s0,-64
    4810:	853e                	mv	a0,a5
    4812:	00003097          	auipc	ra,0x3
    4816:	bae080e7          	jalr	-1106(ra) # 73c0 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    481a:	fe842783          	lw	a5,-24(s0)
    481e:	2785                	addiw	a5,a5,1
    4820:	fef42423          	sw	a5,-24(s0)
    4824:	fe842783          	lw	a5,-24(s0)
    4828:	873e                	mv	a4,a5
    482a:	fd842783          	lw	a5,-40(s0)
    482e:	2701                	sext.w	a4,a4
    4830:	2781                	sext.w	a5,a5
    4832:	f0f740e3          	blt	a4,a5,4732 <manywrites+0x8e>
      }

      unlink(name);
    4836:	fc040793          	addi	a5,s0,-64
    483a:	853e                	mv	a0,a5
    483c:	00003097          	auipc	ra,0x3
    4840:	b84080e7          	jalr	-1148(ra) # 73c0 <unlink>
      exit(0);
    4844:	4501                	li	a0,0
    4846:	00003097          	auipc	ra,0x3
    484a:	b2a080e7          	jalr	-1238(ra) # 7370 <exit>
  for(int ci = 0; ci < nchildren; ci++){
    484e:	fec42783          	lw	a5,-20(s0)
    4852:	2785                	addiw	a5,a5,1
    4854:	fef42623          	sw	a5,-20(s0)
    4858:	fec42783          	lw	a5,-20(s0)
    485c:	873e                	mv	a4,a5
    485e:	fdc42783          	lw	a5,-36(s0)
    4862:	2701                	sext.w	a4,a4
    4864:	2781                	sext.w	a5,a5
    4866:	e4f74ee3          	blt	a4,a5,46c2 <manywrites+0x1e>
    }
  }

  for(int ci = 0; ci < nchildren; ci++){
    486a:	fe042023          	sw	zero,-32(s0)
    486e:	a80d                	j	48a0 <manywrites+0x1fc>
    int st = 0;
    4870:	fa042e23          	sw	zero,-68(s0)
    wait(&st);
    4874:	fbc40793          	addi	a5,s0,-68
    4878:	853e                	mv	a0,a5
    487a:	00003097          	auipc	ra,0x3
    487e:	afe080e7          	jalr	-1282(ra) # 7378 <wait>
    if(st != 0)
    4882:	fbc42783          	lw	a5,-68(s0)
    4886:	cb81                	beqz	a5,4896 <manywrites+0x1f2>
      exit(st);
    4888:	fbc42783          	lw	a5,-68(s0)
    488c:	853e                	mv	a0,a5
    488e:	00003097          	auipc	ra,0x3
    4892:	ae2080e7          	jalr	-1310(ra) # 7370 <exit>
  for(int ci = 0; ci < nchildren; ci++){
    4896:	fe042783          	lw	a5,-32(s0)
    489a:	2785                	addiw	a5,a5,1
    489c:	fef42023          	sw	a5,-32(s0)
    48a0:	fe042783          	lw	a5,-32(s0)
    48a4:	873e                	mv	a4,a5
    48a6:	fdc42783          	lw	a5,-36(s0)
    48aa:	2701                	sext.w	a4,a4
    48ac:	2781                	sext.w	a5,a5
    48ae:	fcf741e3          	blt	a4,a5,4870 <manywrites+0x1cc>
  }
  exit(0);
    48b2:	4501                	li	a0,0
    48b4:	00003097          	auipc	ra,0x3
    48b8:	abc080e7          	jalr	-1348(ra) # 7370 <exit>

00000000000048bc <bigfile>:
}

void
bigfile(char *s)
{
    48bc:	7179                	addi	sp,sp,-48
    48be:	f406                	sd	ra,40(sp)
    48c0:	f022                	sd	s0,32(sp)
    48c2:	1800                	addi	s0,sp,48
    48c4:	fca43c23          	sd	a0,-40(s0)
  enum { N = 20, SZ=600 };
  int fd, i, total, cc;

  unlink("bigfile.dat");
    48c8:	00005517          	auipc	a0,0x5
    48cc:	9b850513          	addi	a0,a0,-1608 # 9280 <cv_init+0x14fa>
    48d0:	00003097          	auipc	ra,0x3
    48d4:	af0080e7          	jalr	-1296(ra) # 73c0 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    48d8:	20200593          	li	a1,514
    48dc:	00005517          	auipc	a0,0x5
    48e0:	9a450513          	addi	a0,a0,-1628 # 9280 <cv_init+0x14fa>
    48e4:	00003097          	auipc	ra,0x3
    48e8:	acc080e7          	jalr	-1332(ra) # 73b0 <open>
    48ec:	87aa                	mv	a5,a0
    48ee:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    48f2:	fe442783          	lw	a5,-28(s0)
    48f6:	2781                	sext.w	a5,a5
    48f8:	0207d163          	bgez	a5,491a <bigfile+0x5e>
    printf("%s: cannot create bigfile", s);
    48fc:	fd843583          	ld	a1,-40(s0)
    4900:	00005517          	auipc	a0,0x5
    4904:	99050513          	addi	a0,a0,-1648 # 9290 <cv_init+0x150a>
    4908:	00003097          	auipc	ra,0x3
    490c:	fa0080e7          	jalr	-96(ra) # 78a8 <printf>
    exit(1);
    4910:	4505                	li	a0,1
    4912:	00003097          	auipc	ra,0x3
    4916:	a5e080e7          	jalr	-1442(ra) # 7370 <exit>
  }
  for(i = 0; i < N; i++){
    491a:	fe042623          	sw	zero,-20(s0)
    491e:	a0ad                	j	4988 <bigfile+0xcc>
    memset(buf, i, SZ);
    4920:	fec42783          	lw	a5,-20(s0)
    4924:	25800613          	li	a2,600
    4928:	85be                	mv	a1,a5
    492a:	00006517          	auipc	a0,0x6
    492e:	d1e50513          	addi	a0,a0,-738 # a648 <buf>
    4932:	00002097          	auipc	ra,0x2
    4936:	692080e7          	jalr	1682(ra) # 6fc4 <memset>
    if(write(fd, buf, SZ) != SZ){
    493a:	fe442783          	lw	a5,-28(s0)
    493e:	25800613          	li	a2,600
    4942:	00006597          	auipc	a1,0x6
    4946:	d0658593          	addi	a1,a1,-762 # a648 <buf>
    494a:	853e                	mv	a0,a5
    494c:	00003097          	auipc	ra,0x3
    4950:	a44080e7          	jalr	-1468(ra) # 7390 <write>
    4954:	87aa                	mv	a5,a0
    4956:	873e                	mv	a4,a5
    4958:	25800793          	li	a5,600
    495c:	02f70163          	beq	a4,a5,497e <bigfile+0xc2>
      printf("%s: write bigfile failed\n", s);
    4960:	fd843583          	ld	a1,-40(s0)
    4964:	00005517          	auipc	a0,0x5
    4968:	94c50513          	addi	a0,a0,-1716 # 92b0 <cv_init+0x152a>
    496c:	00003097          	auipc	ra,0x3
    4970:	f3c080e7          	jalr	-196(ra) # 78a8 <printf>
      exit(1);
    4974:	4505                	li	a0,1
    4976:	00003097          	auipc	ra,0x3
    497a:	9fa080e7          	jalr	-1542(ra) # 7370 <exit>
  for(i = 0; i < N; i++){
    497e:	fec42783          	lw	a5,-20(s0)
    4982:	2785                	addiw	a5,a5,1
    4984:	fef42623          	sw	a5,-20(s0)
    4988:	fec42783          	lw	a5,-20(s0)
    498c:	0007871b          	sext.w	a4,a5
    4990:	47cd                	li	a5,19
    4992:	f8e7d7e3          	bge	a5,a4,4920 <bigfile+0x64>
    }
  }
  close(fd);
    4996:	fe442783          	lw	a5,-28(s0)
    499a:	853e                	mv	a0,a5
    499c:	00003097          	auipc	ra,0x3
    49a0:	9fc080e7          	jalr	-1540(ra) # 7398 <close>

  fd = open("bigfile.dat", 0);
    49a4:	4581                	li	a1,0
    49a6:	00005517          	auipc	a0,0x5
    49aa:	8da50513          	addi	a0,a0,-1830 # 9280 <cv_init+0x14fa>
    49ae:	00003097          	auipc	ra,0x3
    49b2:	a02080e7          	jalr	-1534(ra) # 73b0 <open>
    49b6:	87aa                	mv	a5,a0
    49b8:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    49bc:	fe442783          	lw	a5,-28(s0)
    49c0:	2781                	sext.w	a5,a5
    49c2:	0207d163          	bgez	a5,49e4 <bigfile+0x128>
    printf("%s: cannot open bigfile\n", s);
    49c6:	fd843583          	ld	a1,-40(s0)
    49ca:	00005517          	auipc	a0,0x5
    49ce:	90650513          	addi	a0,a0,-1786 # 92d0 <cv_init+0x154a>
    49d2:	00003097          	auipc	ra,0x3
    49d6:	ed6080e7          	jalr	-298(ra) # 78a8 <printf>
    exit(1);
    49da:	4505                	li	a0,1
    49dc:	00003097          	auipc	ra,0x3
    49e0:	994080e7          	jalr	-1644(ra) # 7370 <exit>
  }
  total = 0;
    49e4:	fe042423          	sw	zero,-24(s0)
  for(i = 0; ; i++){
    49e8:	fe042623          	sw	zero,-20(s0)
    cc = read(fd, buf, SZ/2);
    49ec:	fe442783          	lw	a5,-28(s0)
    49f0:	12c00613          	li	a2,300
    49f4:	00006597          	auipc	a1,0x6
    49f8:	c5458593          	addi	a1,a1,-940 # a648 <buf>
    49fc:	853e                	mv	a0,a5
    49fe:	00003097          	auipc	ra,0x3
    4a02:	98a080e7          	jalr	-1654(ra) # 7388 <read>
    4a06:	87aa                	mv	a5,a0
    4a08:	fef42023          	sw	a5,-32(s0)
    if(cc < 0){
    4a0c:	fe042783          	lw	a5,-32(s0)
    4a10:	2781                	sext.w	a5,a5
    4a12:	0207d163          	bgez	a5,4a34 <bigfile+0x178>
      printf("%s: read bigfile failed\n", s);
    4a16:	fd843583          	ld	a1,-40(s0)
    4a1a:	00005517          	auipc	a0,0x5
    4a1e:	8d650513          	addi	a0,a0,-1834 # 92f0 <cv_init+0x156a>
    4a22:	00003097          	auipc	ra,0x3
    4a26:	e86080e7          	jalr	-378(ra) # 78a8 <printf>
      exit(1);
    4a2a:	4505                	li	a0,1
    4a2c:	00003097          	auipc	ra,0x3
    4a30:	944080e7          	jalr	-1724(ra) # 7370 <exit>
    }
    if(cc == 0)
    4a34:	fe042783          	lw	a5,-32(s0)
    4a38:	2781                	sext.w	a5,a5
    4a3a:	cbdd                	beqz	a5,4af0 <bigfile+0x234>
      break;
    if(cc != SZ/2){
    4a3c:	fe042783          	lw	a5,-32(s0)
    4a40:	0007871b          	sext.w	a4,a5
    4a44:	12c00793          	li	a5,300
    4a48:	02f70163          	beq	a4,a5,4a6a <bigfile+0x1ae>
      printf("%s: short read bigfile\n", s);
    4a4c:	fd843583          	ld	a1,-40(s0)
    4a50:	00005517          	auipc	a0,0x5
    4a54:	8c050513          	addi	a0,a0,-1856 # 9310 <cv_init+0x158a>
    4a58:	00003097          	auipc	ra,0x3
    4a5c:	e50080e7          	jalr	-432(ra) # 78a8 <printf>
      exit(1);
    4a60:	4505                	li	a0,1
    4a62:	00003097          	auipc	ra,0x3
    4a66:	90e080e7          	jalr	-1778(ra) # 7370 <exit>
    }
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4a6a:	00006797          	auipc	a5,0x6
    4a6e:	bde78793          	addi	a5,a5,-1058 # a648 <buf>
    4a72:	0007c783          	lbu	a5,0(a5)
    4a76:	0007869b          	sext.w	a3,a5
    4a7a:	fec42783          	lw	a5,-20(s0)
    4a7e:	01f7d71b          	srliw	a4,a5,0x1f
    4a82:	9fb9                	addw	a5,a5,a4
    4a84:	4017d79b          	sraiw	a5,a5,0x1
    4a88:	2781                	sext.w	a5,a5
    4a8a:	8736                	mv	a4,a3
    4a8c:	02f71563          	bne	a4,a5,4ab6 <bigfile+0x1fa>
    4a90:	00006797          	auipc	a5,0x6
    4a94:	bb878793          	addi	a5,a5,-1096 # a648 <buf>
    4a98:	12b7c783          	lbu	a5,299(a5)
    4a9c:	0007869b          	sext.w	a3,a5
    4aa0:	fec42783          	lw	a5,-20(s0)
    4aa4:	01f7d71b          	srliw	a4,a5,0x1f
    4aa8:	9fb9                	addw	a5,a5,a4
    4aaa:	4017d79b          	sraiw	a5,a5,0x1
    4aae:	2781                	sext.w	a5,a5
    4ab0:	8736                	mv	a4,a3
    4ab2:	02f70163          	beq	a4,a5,4ad4 <bigfile+0x218>
      printf("%s: read bigfile wrong data\n", s);
    4ab6:	fd843583          	ld	a1,-40(s0)
    4aba:	00005517          	auipc	a0,0x5
    4abe:	86e50513          	addi	a0,a0,-1938 # 9328 <cv_init+0x15a2>
    4ac2:	00003097          	auipc	ra,0x3
    4ac6:	de6080e7          	jalr	-538(ra) # 78a8 <printf>
      exit(1);
    4aca:	4505                	li	a0,1
    4acc:	00003097          	auipc	ra,0x3
    4ad0:	8a4080e7          	jalr	-1884(ra) # 7370 <exit>
    }
    total += cc;
    4ad4:	fe842783          	lw	a5,-24(s0)
    4ad8:	873e                	mv	a4,a5
    4ada:	fe042783          	lw	a5,-32(s0)
    4ade:	9fb9                	addw	a5,a5,a4
    4ae0:	fef42423          	sw	a5,-24(s0)
  for(i = 0; ; i++){
    4ae4:	fec42783          	lw	a5,-20(s0)
    4ae8:	2785                	addiw	a5,a5,1
    4aea:	fef42623          	sw	a5,-20(s0)
    cc = read(fd, buf, SZ/2);
    4aee:	bdfd                	j	49ec <bigfile+0x130>
      break;
    4af0:	0001                	nop
  }
  close(fd);
    4af2:	fe442783          	lw	a5,-28(s0)
    4af6:	853e                	mv	a0,a5
    4af8:	00003097          	auipc	ra,0x3
    4afc:	8a0080e7          	jalr	-1888(ra) # 7398 <close>
  if(total != N*SZ){
    4b00:	fe842783          	lw	a5,-24(s0)
    4b04:	0007871b          	sext.w	a4,a5
    4b08:	678d                	lui	a5,0x3
    4b0a:	ee078793          	addi	a5,a5,-288 # 2ee0 <createdelete+0x166>
    4b0e:	02f70163          	beq	a4,a5,4b30 <bigfile+0x274>
    printf("%s: read bigfile wrong total\n", s);
    4b12:	fd843583          	ld	a1,-40(s0)
    4b16:	00005517          	auipc	a0,0x5
    4b1a:	83250513          	addi	a0,a0,-1998 # 9348 <cv_init+0x15c2>
    4b1e:	00003097          	auipc	ra,0x3
    4b22:	d8a080e7          	jalr	-630(ra) # 78a8 <printf>
    exit(1);
    4b26:	4505                	li	a0,1
    4b28:	00003097          	auipc	ra,0x3
    4b2c:	848080e7          	jalr	-1976(ra) # 7370 <exit>
  }
  unlink("bigfile.dat");
    4b30:	00004517          	auipc	a0,0x4
    4b34:	75050513          	addi	a0,a0,1872 # 9280 <cv_init+0x14fa>
    4b38:	00003097          	auipc	ra,0x3
    4b3c:	888080e7          	jalr	-1912(ra) # 73c0 <unlink>
}
    4b40:	0001                	nop
    4b42:	70a2                	ld	ra,40(sp)
    4b44:	7402                	ld	s0,32(sp)
    4b46:	6145                	addi	sp,sp,48
    4b48:	8082                	ret

0000000000004b4a <fourteen>:

void
fourteen(char *s)
{
    4b4a:	7179                	addi	sp,sp,-48
    4b4c:	f406                	sd	ra,40(sp)
    4b4e:	f022                	sd	s0,32(sp)
    4b50:	1800                	addi	s0,sp,48
    4b52:	fca43c23          	sd	a0,-40(s0)
  int fd;

  // DIRSIZ is 14.

  if(mkdir("12345678901234") != 0){
    4b56:	00005517          	auipc	a0,0x5
    4b5a:	81250513          	addi	a0,a0,-2030 # 9368 <cv_init+0x15e2>
    4b5e:	00003097          	auipc	ra,0x3
    4b62:	87a080e7          	jalr	-1926(ra) # 73d8 <mkdir>
    4b66:	87aa                	mv	a5,a0
    4b68:	c385                	beqz	a5,4b88 <fourteen+0x3e>
    printf("%s: mkdir 12345678901234 failed\n", s);
    4b6a:	fd843583          	ld	a1,-40(s0)
    4b6e:	00005517          	auipc	a0,0x5
    4b72:	80a50513          	addi	a0,a0,-2038 # 9378 <cv_init+0x15f2>
    4b76:	00003097          	auipc	ra,0x3
    4b7a:	d32080e7          	jalr	-718(ra) # 78a8 <printf>
    exit(1);
    4b7e:	4505                	li	a0,1
    4b80:	00002097          	auipc	ra,0x2
    4b84:	7f0080e7          	jalr	2032(ra) # 7370 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    4b88:	00005517          	auipc	a0,0x5
    4b8c:	81850513          	addi	a0,a0,-2024 # 93a0 <cv_init+0x161a>
    4b90:	00003097          	auipc	ra,0x3
    4b94:	848080e7          	jalr	-1976(ra) # 73d8 <mkdir>
    4b98:	87aa                	mv	a5,a0
    4b9a:	c385                	beqz	a5,4bba <fourteen+0x70>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    4b9c:	fd843583          	ld	a1,-40(s0)
    4ba0:	00005517          	auipc	a0,0x5
    4ba4:	82050513          	addi	a0,a0,-2016 # 93c0 <cv_init+0x163a>
    4ba8:	00003097          	auipc	ra,0x3
    4bac:	d00080e7          	jalr	-768(ra) # 78a8 <printf>
    exit(1);
    4bb0:	4505                	li	a0,1
    4bb2:	00002097          	auipc	ra,0x2
    4bb6:	7be080e7          	jalr	1982(ra) # 7370 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    4bba:	20000593          	li	a1,512
    4bbe:	00005517          	auipc	a0,0x5
    4bc2:	83a50513          	addi	a0,a0,-1990 # 93f8 <cv_init+0x1672>
    4bc6:	00002097          	auipc	ra,0x2
    4bca:	7ea080e7          	jalr	2026(ra) # 73b0 <open>
    4bce:	87aa                	mv	a5,a0
    4bd0:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    4bd4:	fec42783          	lw	a5,-20(s0)
    4bd8:	2781                	sext.w	a5,a5
    4bda:	0207d163          	bgez	a5,4bfc <fourteen+0xb2>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    4bde:	fd843583          	ld	a1,-40(s0)
    4be2:	00005517          	auipc	a0,0x5
    4be6:	84650513          	addi	a0,a0,-1978 # 9428 <cv_init+0x16a2>
    4bea:	00003097          	auipc	ra,0x3
    4bee:	cbe080e7          	jalr	-834(ra) # 78a8 <printf>
    exit(1);
    4bf2:	4505                	li	a0,1
    4bf4:	00002097          	auipc	ra,0x2
    4bf8:	77c080e7          	jalr	1916(ra) # 7370 <exit>
  }
  close(fd);
    4bfc:	fec42783          	lw	a5,-20(s0)
    4c00:	853e                	mv	a0,a5
    4c02:	00002097          	auipc	ra,0x2
    4c06:	796080e7          	jalr	1942(ra) # 7398 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    4c0a:	4581                	li	a1,0
    4c0c:	00005517          	auipc	a0,0x5
    4c10:	86450513          	addi	a0,a0,-1948 # 9470 <cv_init+0x16ea>
    4c14:	00002097          	auipc	ra,0x2
    4c18:	79c080e7          	jalr	1948(ra) # 73b0 <open>
    4c1c:	87aa                	mv	a5,a0
    4c1e:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    4c22:	fec42783          	lw	a5,-20(s0)
    4c26:	2781                	sext.w	a5,a5
    4c28:	0207d163          	bgez	a5,4c4a <fourteen+0x100>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    4c2c:	fd843583          	ld	a1,-40(s0)
    4c30:	00005517          	auipc	a0,0x5
    4c34:	87050513          	addi	a0,a0,-1936 # 94a0 <cv_init+0x171a>
    4c38:	00003097          	auipc	ra,0x3
    4c3c:	c70080e7          	jalr	-912(ra) # 78a8 <printf>
    exit(1);
    4c40:	4505                	li	a0,1
    4c42:	00002097          	auipc	ra,0x2
    4c46:	72e080e7          	jalr	1838(ra) # 7370 <exit>
  }
  close(fd);
    4c4a:	fec42783          	lw	a5,-20(s0)
    4c4e:	853e                	mv	a0,a5
    4c50:	00002097          	auipc	ra,0x2
    4c54:	748080e7          	jalr	1864(ra) # 7398 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    4c58:	00005517          	auipc	a0,0x5
    4c5c:	88850513          	addi	a0,a0,-1912 # 94e0 <cv_init+0x175a>
    4c60:	00002097          	auipc	ra,0x2
    4c64:	778080e7          	jalr	1912(ra) # 73d8 <mkdir>
    4c68:	87aa                	mv	a5,a0
    4c6a:	e385                	bnez	a5,4c8a <fourteen+0x140>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    4c6c:	fd843583          	ld	a1,-40(s0)
    4c70:	00005517          	auipc	a0,0x5
    4c74:	89050513          	addi	a0,a0,-1904 # 9500 <cv_init+0x177a>
    4c78:	00003097          	auipc	ra,0x3
    4c7c:	c30080e7          	jalr	-976(ra) # 78a8 <printf>
    exit(1);
    4c80:	4505                	li	a0,1
    4c82:	00002097          	auipc	ra,0x2
    4c86:	6ee080e7          	jalr	1774(ra) # 7370 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    4c8a:	00005517          	auipc	a0,0x5
    4c8e:	8ae50513          	addi	a0,a0,-1874 # 9538 <cv_init+0x17b2>
    4c92:	00002097          	auipc	ra,0x2
    4c96:	746080e7          	jalr	1862(ra) # 73d8 <mkdir>
    4c9a:	87aa                	mv	a5,a0
    4c9c:	e385                	bnez	a5,4cbc <fourteen+0x172>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    4c9e:	fd843583          	ld	a1,-40(s0)
    4ca2:	00005517          	auipc	a0,0x5
    4ca6:	8b650513          	addi	a0,a0,-1866 # 9558 <cv_init+0x17d2>
    4caa:	00003097          	auipc	ra,0x3
    4cae:	bfe080e7          	jalr	-1026(ra) # 78a8 <printf>
    exit(1);
    4cb2:	4505                	li	a0,1
    4cb4:	00002097          	auipc	ra,0x2
    4cb8:	6bc080e7          	jalr	1724(ra) # 7370 <exit>
  }

  // clean up
  unlink("123456789012345/12345678901234");
    4cbc:	00005517          	auipc	a0,0x5
    4cc0:	87c50513          	addi	a0,a0,-1924 # 9538 <cv_init+0x17b2>
    4cc4:	00002097          	auipc	ra,0x2
    4cc8:	6fc080e7          	jalr	1788(ra) # 73c0 <unlink>
  unlink("12345678901234/12345678901234");
    4ccc:	00005517          	auipc	a0,0x5
    4cd0:	81450513          	addi	a0,a0,-2028 # 94e0 <cv_init+0x175a>
    4cd4:	00002097          	auipc	ra,0x2
    4cd8:	6ec080e7          	jalr	1772(ra) # 73c0 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    4cdc:	00004517          	auipc	a0,0x4
    4ce0:	79450513          	addi	a0,a0,1940 # 9470 <cv_init+0x16ea>
    4ce4:	00002097          	auipc	ra,0x2
    4ce8:	6dc080e7          	jalr	1756(ra) # 73c0 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    4cec:	00004517          	auipc	a0,0x4
    4cf0:	70c50513          	addi	a0,a0,1804 # 93f8 <cv_init+0x1672>
    4cf4:	00002097          	auipc	ra,0x2
    4cf8:	6cc080e7          	jalr	1740(ra) # 73c0 <unlink>
  unlink("12345678901234/123456789012345");
    4cfc:	00004517          	auipc	a0,0x4
    4d00:	6a450513          	addi	a0,a0,1700 # 93a0 <cv_init+0x161a>
    4d04:	00002097          	auipc	ra,0x2
    4d08:	6bc080e7          	jalr	1724(ra) # 73c0 <unlink>
  unlink("12345678901234");
    4d0c:	00004517          	auipc	a0,0x4
    4d10:	65c50513          	addi	a0,a0,1628 # 9368 <cv_init+0x15e2>
    4d14:	00002097          	auipc	ra,0x2
    4d18:	6ac080e7          	jalr	1708(ra) # 73c0 <unlink>
}
    4d1c:	0001                	nop
    4d1e:	70a2                	ld	ra,40(sp)
    4d20:	7402                	ld	s0,32(sp)
    4d22:	6145                	addi	sp,sp,48
    4d24:	8082                	ret

0000000000004d26 <rmdot>:

void
rmdot(char *s)
{
    4d26:	1101                	addi	sp,sp,-32
    4d28:	ec06                	sd	ra,24(sp)
    4d2a:	e822                	sd	s0,16(sp)
    4d2c:	1000                	addi	s0,sp,32
    4d2e:	fea43423          	sd	a0,-24(s0)
  if(mkdir("dots") != 0){
    4d32:	00005517          	auipc	a0,0x5
    4d36:	85e50513          	addi	a0,a0,-1954 # 9590 <cv_init+0x180a>
    4d3a:	00002097          	auipc	ra,0x2
    4d3e:	69e080e7          	jalr	1694(ra) # 73d8 <mkdir>
    4d42:	87aa                	mv	a5,a0
    4d44:	c385                	beqz	a5,4d64 <rmdot+0x3e>
    printf("%s: mkdir dots failed\n", s);
    4d46:	fe843583          	ld	a1,-24(s0)
    4d4a:	00005517          	auipc	a0,0x5
    4d4e:	84e50513          	addi	a0,a0,-1970 # 9598 <cv_init+0x1812>
    4d52:	00003097          	auipc	ra,0x3
    4d56:	b56080e7          	jalr	-1194(ra) # 78a8 <printf>
    exit(1);
    4d5a:	4505                	li	a0,1
    4d5c:	00002097          	auipc	ra,0x2
    4d60:	614080e7          	jalr	1556(ra) # 7370 <exit>
  }
  if(chdir("dots") != 0){
    4d64:	00005517          	auipc	a0,0x5
    4d68:	82c50513          	addi	a0,a0,-2004 # 9590 <cv_init+0x180a>
    4d6c:	00002097          	auipc	ra,0x2
    4d70:	674080e7          	jalr	1652(ra) # 73e0 <chdir>
    4d74:	87aa                	mv	a5,a0
    4d76:	c385                	beqz	a5,4d96 <rmdot+0x70>
    printf("%s: chdir dots failed\n", s);
    4d78:	fe843583          	ld	a1,-24(s0)
    4d7c:	00005517          	auipc	a0,0x5
    4d80:	83450513          	addi	a0,a0,-1996 # 95b0 <cv_init+0x182a>
    4d84:	00003097          	auipc	ra,0x3
    4d88:	b24080e7          	jalr	-1244(ra) # 78a8 <printf>
    exit(1);
    4d8c:	4505                	li	a0,1
    4d8e:	00002097          	auipc	ra,0x2
    4d92:	5e2080e7          	jalr	1506(ra) # 7370 <exit>
  }
  if(unlink(".") == 0){
    4d96:	00004517          	auipc	a0,0x4
    4d9a:	dd250513          	addi	a0,a0,-558 # 8b68 <cv_init+0xde2>
    4d9e:	00002097          	auipc	ra,0x2
    4da2:	622080e7          	jalr	1570(ra) # 73c0 <unlink>
    4da6:	87aa                	mv	a5,a0
    4da8:	e385                	bnez	a5,4dc8 <rmdot+0xa2>
    printf("%s: rm . worked!\n", s);
    4daa:	fe843583          	ld	a1,-24(s0)
    4dae:	00005517          	auipc	a0,0x5
    4db2:	81a50513          	addi	a0,a0,-2022 # 95c8 <cv_init+0x1842>
    4db6:	00003097          	auipc	ra,0x3
    4dba:	af2080e7          	jalr	-1294(ra) # 78a8 <printf>
    exit(1);
    4dbe:	4505                	li	a0,1
    4dc0:	00002097          	auipc	ra,0x2
    4dc4:	5b0080e7          	jalr	1456(ra) # 7370 <exit>
  }
  if(unlink("..") == 0){
    4dc8:	00003517          	auipc	a0,0x3
    4dcc:	7f850513          	addi	a0,a0,2040 # 85c0 <cv_init+0x83a>
    4dd0:	00002097          	auipc	ra,0x2
    4dd4:	5f0080e7          	jalr	1520(ra) # 73c0 <unlink>
    4dd8:	87aa                	mv	a5,a0
    4dda:	e385                	bnez	a5,4dfa <rmdot+0xd4>
    printf("%s: rm .. worked!\n", s);
    4ddc:	fe843583          	ld	a1,-24(s0)
    4de0:	00005517          	auipc	a0,0x5
    4de4:	80050513          	addi	a0,a0,-2048 # 95e0 <cv_init+0x185a>
    4de8:	00003097          	auipc	ra,0x3
    4dec:	ac0080e7          	jalr	-1344(ra) # 78a8 <printf>
    exit(1);
    4df0:	4505                	li	a0,1
    4df2:	00002097          	auipc	ra,0x2
    4df6:	57e080e7          	jalr	1406(ra) # 7370 <exit>
  }
  if(chdir("/") != 0){
    4dfa:	00003517          	auipc	a0,0x3
    4dfe:	4de50513          	addi	a0,a0,1246 # 82d8 <cv_init+0x552>
    4e02:	00002097          	auipc	ra,0x2
    4e06:	5de080e7          	jalr	1502(ra) # 73e0 <chdir>
    4e0a:	87aa                	mv	a5,a0
    4e0c:	c385                	beqz	a5,4e2c <rmdot+0x106>
    printf("%s: chdir / failed\n", s);
    4e0e:	fe843583          	ld	a1,-24(s0)
    4e12:	00003517          	auipc	a0,0x3
    4e16:	4ce50513          	addi	a0,a0,1230 # 82e0 <cv_init+0x55a>
    4e1a:	00003097          	auipc	ra,0x3
    4e1e:	a8e080e7          	jalr	-1394(ra) # 78a8 <printf>
    exit(1);
    4e22:	4505                	li	a0,1
    4e24:	00002097          	auipc	ra,0x2
    4e28:	54c080e7          	jalr	1356(ra) # 7370 <exit>
  }
  if(unlink("dots/.") == 0){
    4e2c:	00004517          	auipc	a0,0x4
    4e30:	7cc50513          	addi	a0,a0,1996 # 95f8 <cv_init+0x1872>
    4e34:	00002097          	auipc	ra,0x2
    4e38:	58c080e7          	jalr	1420(ra) # 73c0 <unlink>
    4e3c:	87aa                	mv	a5,a0
    4e3e:	e385                	bnez	a5,4e5e <rmdot+0x138>
    printf("%s: unlink dots/. worked!\n", s);
    4e40:	fe843583          	ld	a1,-24(s0)
    4e44:	00004517          	auipc	a0,0x4
    4e48:	7bc50513          	addi	a0,a0,1980 # 9600 <cv_init+0x187a>
    4e4c:	00003097          	auipc	ra,0x3
    4e50:	a5c080e7          	jalr	-1444(ra) # 78a8 <printf>
    exit(1);
    4e54:	4505                	li	a0,1
    4e56:	00002097          	auipc	ra,0x2
    4e5a:	51a080e7          	jalr	1306(ra) # 7370 <exit>
  }
  if(unlink("dots/..") == 0){
    4e5e:	00004517          	auipc	a0,0x4
    4e62:	7c250513          	addi	a0,a0,1986 # 9620 <cv_init+0x189a>
    4e66:	00002097          	auipc	ra,0x2
    4e6a:	55a080e7          	jalr	1370(ra) # 73c0 <unlink>
    4e6e:	87aa                	mv	a5,a0
    4e70:	e385                	bnez	a5,4e90 <rmdot+0x16a>
    printf("%s: unlink dots/.. worked!\n", s);
    4e72:	fe843583          	ld	a1,-24(s0)
    4e76:	00004517          	auipc	a0,0x4
    4e7a:	7b250513          	addi	a0,a0,1970 # 9628 <cv_init+0x18a2>
    4e7e:	00003097          	auipc	ra,0x3
    4e82:	a2a080e7          	jalr	-1494(ra) # 78a8 <printf>
    exit(1);
    4e86:	4505                	li	a0,1
    4e88:	00002097          	auipc	ra,0x2
    4e8c:	4e8080e7          	jalr	1256(ra) # 7370 <exit>
  }
  if(unlink("dots") != 0){
    4e90:	00004517          	auipc	a0,0x4
    4e94:	70050513          	addi	a0,a0,1792 # 9590 <cv_init+0x180a>
    4e98:	00002097          	auipc	ra,0x2
    4e9c:	528080e7          	jalr	1320(ra) # 73c0 <unlink>
    4ea0:	87aa                	mv	a5,a0
    4ea2:	c385                	beqz	a5,4ec2 <rmdot+0x19c>
    printf("%s: unlink dots failed!\n", s);
    4ea4:	fe843583          	ld	a1,-24(s0)
    4ea8:	00004517          	auipc	a0,0x4
    4eac:	7a050513          	addi	a0,a0,1952 # 9648 <cv_init+0x18c2>
    4eb0:	00003097          	auipc	ra,0x3
    4eb4:	9f8080e7          	jalr	-1544(ra) # 78a8 <printf>
    exit(1);
    4eb8:	4505                	li	a0,1
    4eba:	00002097          	auipc	ra,0x2
    4ebe:	4b6080e7          	jalr	1206(ra) # 7370 <exit>
  }
}
    4ec2:	0001                	nop
    4ec4:	60e2                	ld	ra,24(sp)
    4ec6:	6442                	ld	s0,16(sp)
    4ec8:	6105                	addi	sp,sp,32
    4eca:	8082                	ret

0000000000004ecc <dirfile>:

void
dirfile(char *s)
{
    4ecc:	7179                	addi	sp,sp,-48
    4ece:	f406                	sd	ra,40(sp)
    4ed0:	f022                	sd	s0,32(sp)
    4ed2:	1800                	addi	s0,sp,48
    4ed4:	fca43c23          	sd	a0,-40(s0)
  int fd;

  fd = open("dirfile", O_CREATE);
    4ed8:	20000593          	li	a1,512
    4edc:	00004517          	auipc	a0,0x4
    4ee0:	78c50513          	addi	a0,a0,1932 # 9668 <cv_init+0x18e2>
    4ee4:	00002097          	auipc	ra,0x2
    4ee8:	4cc080e7          	jalr	1228(ra) # 73b0 <open>
    4eec:	87aa                	mv	a5,a0
    4eee:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    4ef2:	fec42783          	lw	a5,-20(s0)
    4ef6:	2781                	sext.w	a5,a5
    4ef8:	0207d163          	bgez	a5,4f1a <dirfile+0x4e>
    printf("%s: create dirfile failed\n", s);
    4efc:	fd843583          	ld	a1,-40(s0)
    4f00:	00004517          	auipc	a0,0x4
    4f04:	77050513          	addi	a0,a0,1904 # 9670 <cv_init+0x18ea>
    4f08:	00003097          	auipc	ra,0x3
    4f0c:	9a0080e7          	jalr	-1632(ra) # 78a8 <printf>
    exit(1);
    4f10:	4505                	li	a0,1
    4f12:	00002097          	auipc	ra,0x2
    4f16:	45e080e7          	jalr	1118(ra) # 7370 <exit>
  }
  close(fd);
    4f1a:	fec42783          	lw	a5,-20(s0)
    4f1e:	853e                	mv	a0,a5
    4f20:	00002097          	auipc	ra,0x2
    4f24:	478080e7          	jalr	1144(ra) # 7398 <close>
  if(chdir("dirfile") == 0){
    4f28:	00004517          	auipc	a0,0x4
    4f2c:	74050513          	addi	a0,a0,1856 # 9668 <cv_init+0x18e2>
    4f30:	00002097          	auipc	ra,0x2
    4f34:	4b0080e7          	jalr	1200(ra) # 73e0 <chdir>
    4f38:	87aa                	mv	a5,a0
    4f3a:	e385                	bnez	a5,4f5a <dirfile+0x8e>
    printf("%s: chdir dirfile succeeded!\n", s);
    4f3c:	fd843583          	ld	a1,-40(s0)
    4f40:	00004517          	auipc	a0,0x4
    4f44:	75050513          	addi	a0,a0,1872 # 9690 <cv_init+0x190a>
    4f48:	00003097          	auipc	ra,0x3
    4f4c:	960080e7          	jalr	-1696(ra) # 78a8 <printf>
    exit(1);
    4f50:	4505                	li	a0,1
    4f52:	00002097          	auipc	ra,0x2
    4f56:	41e080e7          	jalr	1054(ra) # 7370 <exit>
  }
  fd = open("dirfile/xx", 0);
    4f5a:	4581                	li	a1,0
    4f5c:	00004517          	auipc	a0,0x4
    4f60:	75450513          	addi	a0,a0,1876 # 96b0 <cv_init+0x192a>
    4f64:	00002097          	auipc	ra,0x2
    4f68:	44c080e7          	jalr	1100(ra) # 73b0 <open>
    4f6c:	87aa                	mv	a5,a0
    4f6e:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    4f72:	fec42783          	lw	a5,-20(s0)
    4f76:	2781                	sext.w	a5,a5
    4f78:	0207c163          	bltz	a5,4f9a <dirfile+0xce>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4f7c:	fd843583          	ld	a1,-40(s0)
    4f80:	00004517          	auipc	a0,0x4
    4f84:	74050513          	addi	a0,a0,1856 # 96c0 <cv_init+0x193a>
    4f88:	00003097          	auipc	ra,0x3
    4f8c:	920080e7          	jalr	-1760(ra) # 78a8 <printf>
    exit(1);
    4f90:	4505                	li	a0,1
    4f92:	00002097          	auipc	ra,0x2
    4f96:	3de080e7          	jalr	990(ra) # 7370 <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    4f9a:	20000593          	li	a1,512
    4f9e:	00004517          	auipc	a0,0x4
    4fa2:	71250513          	addi	a0,a0,1810 # 96b0 <cv_init+0x192a>
    4fa6:	00002097          	auipc	ra,0x2
    4faa:	40a080e7          	jalr	1034(ra) # 73b0 <open>
    4fae:	87aa                	mv	a5,a0
    4fb0:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    4fb4:	fec42783          	lw	a5,-20(s0)
    4fb8:	2781                	sext.w	a5,a5
    4fba:	0207c163          	bltz	a5,4fdc <dirfile+0x110>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4fbe:	fd843583          	ld	a1,-40(s0)
    4fc2:	00004517          	auipc	a0,0x4
    4fc6:	6fe50513          	addi	a0,a0,1790 # 96c0 <cv_init+0x193a>
    4fca:	00003097          	auipc	ra,0x3
    4fce:	8de080e7          	jalr	-1826(ra) # 78a8 <printf>
    exit(1);
    4fd2:	4505                	li	a0,1
    4fd4:	00002097          	auipc	ra,0x2
    4fd8:	39c080e7          	jalr	924(ra) # 7370 <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    4fdc:	00004517          	auipc	a0,0x4
    4fe0:	6d450513          	addi	a0,a0,1748 # 96b0 <cv_init+0x192a>
    4fe4:	00002097          	auipc	ra,0x2
    4fe8:	3f4080e7          	jalr	1012(ra) # 73d8 <mkdir>
    4fec:	87aa                	mv	a5,a0
    4fee:	e385                	bnez	a5,500e <dirfile+0x142>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    4ff0:	fd843583          	ld	a1,-40(s0)
    4ff4:	00004517          	auipc	a0,0x4
    4ff8:	6f450513          	addi	a0,a0,1780 # 96e8 <cv_init+0x1962>
    4ffc:	00003097          	auipc	ra,0x3
    5000:	8ac080e7          	jalr	-1876(ra) # 78a8 <printf>
    exit(1);
    5004:	4505                	li	a0,1
    5006:	00002097          	auipc	ra,0x2
    500a:	36a080e7          	jalr	874(ra) # 7370 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    500e:	00004517          	auipc	a0,0x4
    5012:	6a250513          	addi	a0,a0,1698 # 96b0 <cv_init+0x192a>
    5016:	00002097          	auipc	ra,0x2
    501a:	3aa080e7          	jalr	938(ra) # 73c0 <unlink>
    501e:	87aa                	mv	a5,a0
    5020:	e385                	bnez	a5,5040 <dirfile+0x174>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    5022:	fd843583          	ld	a1,-40(s0)
    5026:	00004517          	auipc	a0,0x4
    502a:	6ea50513          	addi	a0,a0,1770 # 9710 <cv_init+0x198a>
    502e:	00003097          	auipc	ra,0x3
    5032:	87a080e7          	jalr	-1926(ra) # 78a8 <printf>
    exit(1);
    5036:	4505                	li	a0,1
    5038:	00002097          	auipc	ra,0x2
    503c:	338080e7          	jalr	824(ra) # 7370 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    5040:	00004597          	auipc	a1,0x4
    5044:	67058593          	addi	a1,a1,1648 # 96b0 <cv_init+0x192a>
    5048:	00003517          	auipc	a0,0x3
    504c:	e1850513          	addi	a0,a0,-488 # 7e60 <cv_init+0xda>
    5050:	00002097          	auipc	ra,0x2
    5054:	380080e7          	jalr	896(ra) # 73d0 <link>
    5058:	87aa                	mv	a5,a0
    505a:	e385                	bnez	a5,507a <dirfile+0x1ae>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    505c:	fd843583          	ld	a1,-40(s0)
    5060:	00004517          	auipc	a0,0x4
    5064:	6d850513          	addi	a0,a0,1752 # 9738 <cv_init+0x19b2>
    5068:	00003097          	auipc	ra,0x3
    506c:	840080e7          	jalr	-1984(ra) # 78a8 <printf>
    exit(1);
    5070:	4505                	li	a0,1
    5072:	00002097          	auipc	ra,0x2
    5076:	2fe080e7          	jalr	766(ra) # 7370 <exit>
  }
  if(unlink("dirfile") != 0){
    507a:	00004517          	auipc	a0,0x4
    507e:	5ee50513          	addi	a0,a0,1518 # 9668 <cv_init+0x18e2>
    5082:	00002097          	auipc	ra,0x2
    5086:	33e080e7          	jalr	830(ra) # 73c0 <unlink>
    508a:	87aa                	mv	a5,a0
    508c:	c385                	beqz	a5,50ac <dirfile+0x1e0>
    printf("%s: unlink dirfile failed!\n", s);
    508e:	fd843583          	ld	a1,-40(s0)
    5092:	00004517          	auipc	a0,0x4
    5096:	6ce50513          	addi	a0,a0,1742 # 9760 <cv_init+0x19da>
    509a:	00003097          	auipc	ra,0x3
    509e:	80e080e7          	jalr	-2034(ra) # 78a8 <printf>
    exit(1);
    50a2:	4505                	li	a0,1
    50a4:	00002097          	auipc	ra,0x2
    50a8:	2cc080e7          	jalr	716(ra) # 7370 <exit>
  }

  fd = open(".", O_RDWR);
    50ac:	4589                	li	a1,2
    50ae:	00004517          	auipc	a0,0x4
    50b2:	aba50513          	addi	a0,a0,-1350 # 8b68 <cv_init+0xde2>
    50b6:	00002097          	auipc	ra,0x2
    50ba:	2fa080e7          	jalr	762(ra) # 73b0 <open>
    50be:	87aa                	mv	a5,a0
    50c0:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    50c4:	fec42783          	lw	a5,-20(s0)
    50c8:	2781                	sext.w	a5,a5
    50ca:	0207c163          	bltz	a5,50ec <dirfile+0x220>
    printf("%s: open . for writing succeeded!\n", s);
    50ce:	fd843583          	ld	a1,-40(s0)
    50d2:	00004517          	auipc	a0,0x4
    50d6:	6ae50513          	addi	a0,a0,1710 # 9780 <cv_init+0x19fa>
    50da:	00002097          	auipc	ra,0x2
    50de:	7ce080e7          	jalr	1998(ra) # 78a8 <printf>
    exit(1);
    50e2:	4505                	li	a0,1
    50e4:	00002097          	auipc	ra,0x2
    50e8:	28c080e7          	jalr	652(ra) # 7370 <exit>
  }
  fd = open(".", 0);
    50ec:	4581                	li	a1,0
    50ee:	00004517          	auipc	a0,0x4
    50f2:	a7a50513          	addi	a0,a0,-1414 # 8b68 <cv_init+0xde2>
    50f6:	00002097          	auipc	ra,0x2
    50fa:	2ba080e7          	jalr	698(ra) # 73b0 <open>
    50fe:	87aa                	mv	a5,a0
    5100:	fef42623          	sw	a5,-20(s0)
  if(write(fd, "x", 1) > 0){
    5104:	fec42783          	lw	a5,-20(s0)
    5108:	4605                	li	a2,1
    510a:	00003597          	auipc	a1,0x3
    510e:	da658593          	addi	a1,a1,-602 # 7eb0 <cv_init+0x12a>
    5112:	853e                	mv	a0,a5
    5114:	00002097          	auipc	ra,0x2
    5118:	27c080e7          	jalr	636(ra) # 7390 <write>
    511c:	87aa                	mv	a5,a0
    511e:	02f05163          	blez	a5,5140 <dirfile+0x274>
    printf("%s: write . succeeded!\n", s);
    5122:	fd843583          	ld	a1,-40(s0)
    5126:	00004517          	auipc	a0,0x4
    512a:	68250513          	addi	a0,a0,1666 # 97a8 <cv_init+0x1a22>
    512e:	00002097          	auipc	ra,0x2
    5132:	77a080e7          	jalr	1914(ra) # 78a8 <printf>
    exit(1);
    5136:	4505                	li	a0,1
    5138:	00002097          	auipc	ra,0x2
    513c:	238080e7          	jalr	568(ra) # 7370 <exit>
  }
  close(fd);
    5140:	fec42783          	lw	a5,-20(s0)
    5144:	853e                	mv	a0,a5
    5146:	00002097          	auipc	ra,0x2
    514a:	252080e7          	jalr	594(ra) # 7398 <close>
}
    514e:	0001                	nop
    5150:	70a2                	ld	ra,40(sp)
    5152:	7402                	ld	s0,32(sp)
    5154:	6145                	addi	sp,sp,48
    5156:	8082                	ret

0000000000005158 <iref>:

// test that iput() is called at the end of _namei().
// also tests empty file names.
void
iref(char *s)
{
    5158:	7179                	addi	sp,sp,-48
    515a:	f406                	sd	ra,40(sp)
    515c:	f022                	sd	s0,32(sp)
    515e:	1800                	addi	s0,sp,48
    5160:	fca43c23          	sd	a0,-40(s0)
  int i, fd;

  for(i = 0; i < NINODE + 1; i++){
    5164:	fe042623          	sw	zero,-20(s0)
    5168:	a231                	j	5274 <iref+0x11c>
    if(mkdir("irefd") != 0){
    516a:	00004517          	auipc	a0,0x4
    516e:	65650513          	addi	a0,a0,1622 # 97c0 <cv_init+0x1a3a>
    5172:	00002097          	auipc	ra,0x2
    5176:	266080e7          	jalr	614(ra) # 73d8 <mkdir>
    517a:	87aa                	mv	a5,a0
    517c:	c385                	beqz	a5,519c <iref+0x44>
      printf("%s: mkdir irefd failed\n", s);
    517e:	fd843583          	ld	a1,-40(s0)
    5182:	00004517          	auipc	a0,0x4
    5186:	64650513          	addi	a0,a0,1606 # 97c8 <cv_init+0x1a42>
    518a:	00002097          	auipc	ra,0x2
    518e:	71e080e7          	jalr	1822(ra) # 78a8 <printf>
      exit(1);
    5192:	4505                	li	a0,1
    5194:	00002097          	auipc	ra,0x2
    5198:	1dc080e7          	jalr	476(ra) # 7370 <exit>
    }
    if(chdir("irefd") != 0){
    519c:	00004517          	auipc	a0,0x4
    51a0:	62450513          	addi	a0,a0,1572 # 97c0 <cv_init+0x1a3a>
    51a4:	00002097          	auipc	ra,0x2
    51a8:	23c080e7          	jalr	572(ra) # 73e0 <chdir>
    51ac:	87aa                	mv	a5,a0
    51ae:	c385                	beqz	a5,51ce <iref+0x76>
      printf("%s: chdir irefd failed\n", s);
    51b0:	fd843583          	ld	a1,-40(s0)
    51b4:	00004517          	auipc	a0,0x4
    51b8:	62c50513          	addi	a0,a0,1580 # 97e0 <cv_init+0x1a5a>
    51bc:	00002097          	auipc	ra,0x2
    51c0:	6ec080e7          	jalr	1772(ra) # 78a8 <printf>
      exit(1);
    51c4:	4505                	li	a0,1
    51c6:	00002097          	auipc	ra,0x2
    51ca:	1aa080e7          	jalr	426(ra) # 7370 <exit>
    }

    mkdir("");
    51ce:	00004517          	auipc	a0,0x4
    51d2:	62a50513          	addi	a0,a0,1578 # 97f8 <cv_init+0x1a72>
    51d6:	00002097          	auipc	ra,0x2
    51da:	202080e7          	jalr	514(ra) # 73d8 <mkdir>
    link("README", "");
    51de:	00004597          	auipc	a1,0x4
    51e2:	61a58593          	addi	a1,a1,1562 # 97f8 <cv_init+0x1a72>
    51e6:	00003517          	auipc	a0,0x3
    51ea:	c7a50513          	addi	a0,a0,-902 # 7e60 <cv_init+0xda>
    51ee:	00002097          	auipc	ra,0x2
    51f2:	1e2080e7          	jalr	482(ra) # 73d0 <link>
    fd = open("", O_CREATE);
    51f6:	20000593          	li	a1,512
    51fa:	00004517          	auipc	a0,0x4
    51fe:	5fe50513          	addi	a0,a0,1534 # 97f8 <cv_init+0x1a72>
    5202:	00002097          	auipc	ra,0x2
    5206:	1ae080e7          	jalr	430(ra) # 73b0 <open>
    520a:	87aa                	mv	a5,a0
    520c:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0)
    5210:	fe842783          	lw	a5,-24(s0)
    5214:	2781                	sext.w	a5,a5
    5216:	0007c963          	bltz	a5,5228 <iref+0xd0>
      close(fd);
    521a:	fe842783          	lw	a5,-24(s0)
    521e:	853e                	mv	a0,a5
    5220:	00002097          	auipc	ra,0x2
    5224:	178080e7          	jalr	376(ra) # 7398 <close>
    fd = open("xx", O_CREATE);
    5228:	20000593          	li	a1,512
    522c:	00003517          	auipc	a0,0x3
    5230:	d5c50513          	addi	a0,a0,-676 # 7f88 <cv_init+0x202>
    5234:	00002097          	auipc	ra,0x2
    5238:	17c080e7          	jalr	380(ra) # 73b0 <open>
    523c:	87aa                	mv	a5,a0
    523e:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0)
    5242:	fe842783          	lw	a5,-24(s0)
    5246:	2781                	sext.w	a5,a5
    5248:	0007c963          	bltz	a5,525a <iref+0x102>
      close(fd);
    524c:	fe842783          	lw	a5,-24(s0)
    5250:	853e                	mv	a0,a5
    5252:	00002097          	auipc	ra,0x2
    5256:	146080e7          	jalr	326(ra) # 7398 <close>
    unlink("xx");
    525a:	00003517          	auipc	a0,0x3
    525e:	d2e50513          	addi	a0,a0,-722 # 7f88 <cv_init+0x202>
    5262:	00002097          	auipc	ra,0x2
    5266:	15e080e7          	jalr	350(ra) # 73c0 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    526a:	fec42783          	lw	a5,-20(s0)
    526e:	2785                	addiw	a5,a5,1
    5270:	fef42623          	sw	a5,-20(s0)
    5274:	fec42783          	lw	a5,-20(s0)
    5278:	0007871b          	sext.w	a4,a5
    527c:	03200793          	li	a5,50
    5280:	eee7d5e3          	bge	a5,a4,516a <iref+0x12>
  }

  // clean up
  for(i = 0; i < NINODE + 1; i++){
    5284:	fe042623          	sw	zero,-20(s0)
    5288:	a035                	j	52b4 <iref+0x15c>
    chdir("..");
    528a:	00003517          	auipc	a0,0x3
    528e:	33650513          	addi	a0,a0,822 # 85c0 <cv_init+0x83a>
    5292:	00002097          	auipc	ra,0x2
    5296:	14e080e7          	jalr	334(ra) # 73e0 <chdir>
    unlink("irefd");
    529a:	00004517          	auipc	a0,0x4
    529e:	52650513          	addi	a0,a0,1318 # 97c0 <cv_init+0x1a3a>
    52a2:	00002097          	auipc	ra,0x2
    52a6:	11e080e7          	jalr	286(ra) # 73c0 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    52aa:	fec42783          	lw	a5,-20(s0)
    52ae:	2785                	addiw	a5,a5,1
    52b0:	fef42623          	sw	a5,-20(s0)
    52b4:	fec42783          	lw	a5,-20(s0)
    52b8:	0007871b          	sext.w	a4,a5
    52bc:	03200793          	li	a5,50
    52c0:	fce7d5e3          	bge	a5,a4,528a <iref+0x132>
  }

  chdir("/");
    52c4:	00003517          	auipc	a0,0x3
    52c8:	01450513          	addi	a0,a0,20 # 82d8 <cv_init+0x552>
    52cc:	00002097          	auipc	ra,0x2
    52d0:	114080e7          	jalr	276(ra) # 73e0 <chdir>
}
    52d4:	0001                	nop
    52d6:	70a2                	ld	ra,40(sp)
    52d8:	7402                	ld	s0,32(sp)
    52da:	6145                	addi	sp,sp,48
    52dc:	8082                	ret

00000000000052de <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(char *s)
{
    52de:	7179                	addi	sp,sp,-48
    52e0:	f406                	sd	ra,40(sp)
    52e2:	f022                	sd	s0,32(sp)
    52e4:	1800                	addi	s0,sp,48
    52e6:	fca43c23          	sd	a0,-40(s0)
  enum{ N = 1000 };
  int n, pid;

  for(n=0; n<N; n++){
    52ea:	fe042623          	sw	zero,-20(s0)
    52ee:	a81d                	j	5324 <forktest+0x46>
    pid = fork();
    52f0:	00002097          	auipc	ra,0x2
    52f4:	078080e7          	jalr	120(ra) # 7368 <fork>
    52f8:	87aa                	mv	a5,a0
    52fa:	fef42423          	sw	a5,-24(s0)
    if(pid < 0)
    52fe:	fe842783          	lw	a5,-24(s0)
    5302:	2781                	sext.w	a5,a5
    5304:	0207c963          	bltz	a5,5336 <forktest+0x58>
      break;
    if(pid == 0)
    5308:	fe842783          	lw	a5,-24(s0)
    530c:	2781                	sext.w	a5,a5
    530e:	e791                	bnez	a5,531a <forktest+0x3c>
      exit(0);
    5310:	4501                	li	a0,0
    5312:	00002097          	auipc	ra,0x2
    5316:	05e080e7          	jalr	94(ra) # 7370 <exit>
  for(n=0; n<N; n++){
    531a:	fec42783          	lw	a5,-20(s0)
    531e:	2785                	addiw	a5,a5,1
    5320:	fef42623          	sw	a5,-20(s0)
    5324:	fec42783          	lw	a5,-20(s0)
    5328:	0007871b          	sext.w	a4,a5
    532c:	3e700793          	li	a5,999
    5330:	fce7d0e3          	bge	a5,a4,52f0 <forktest+0x12>
    5334:	a011                	j	5338 <forktest+0x5a>
      break;
    5336:	0001                	nop
  }

  if (n == 0) {
    5338:	fec42783          	lw	a5,-20(s0)
    533c:	2781                	sext.w	a5,a5
    533e:	e385                	bnez	a5,535e <forktest+0x80>
    printf("%s: no fork at all!\n", s);
    5340:	fd843583          	ld	a1,-40(s0)
    5344:	00004517          	auipc	a0,0x4
    5348:	4bc50513          	addi	a0,a0,1212 # 9800 <cv_init+0x1a7a>
    534c:	00002097          	auipc	ra,0x2
    5350:	55c080e7          	jalr	1372(ra) # 78a8 <printf>
    exit(1);
    5354:	4505                	li	a0,1
    5356:	00002097          	auipc	ra,0x2
    535a:	01a080e7          	jalr	26(ra) # 7370 <exit>
  }

  if(n == N){
    535e:	fec42783          	lw	a5,-20(s0)
    5362:	0007871b          	sext.w	a4,a5
    5366:	3e800793          	li	a5,1000
    536a:	04f71d63          	bne	a4,a5,53c4 <forktest+0xe6>
    printf("%s: fork claimed to work 1000 times!\n", s);
    536e:	fd843583          	ld	a1,-40(s0)
    5372:	00004517          	auipc	a0,0x4
    5376:	4a650513          	addi	a0,a0,1190 # 9818 <cv_init+0x1a92>
    537a:	00002097          	auipc	ra,0x2
    537e:	52e080e7          	jalr	1326(ra) # 78a8 <printf>
    exit(1);
    5382:	4505                	li	a0,1
    5384:	00002097          	auipc	ra,0x2
    5388:	fec080e7          	jalr	-20(ra) # 7370 <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
    538c:	4501                	li	a0,0
    538e:	00002097          	auipc	ra,0x2
    5392:	fea080e7          	jalr	-22(ra) # 7378 <wait>
    5396:	87aa                	mv	a5,a0
    5398:	0207d163          	bgez	a5,53ba <forktest+0xdc>
      printf("%s: wait stopped early\n", s);
    539c:	fd843583          	ld	a1,-40(s0)
    53a0:	00004517          	auipc	a0,0x4
    53a4:	4a050513          	addi	a0,a0,1184 # 9840 <cv_init+0x1aba>
    53a8:	00002097          	auipc	ra,0x2
    53ac:	500080e7          	jalr	1280(ra) # 78a8 <printf>
      exit(1);
    53b0:	4505                	li	a0,1
    53b2:	00002097          	auipc	ra,0x2
    53b6:	fbe080e7          	jalr	-66(ra) # 7370 <exit>
  for(; n > 0; n--){
    53ba:	fec42783          	lw	a5,-20(s0)
    53be:	37fd                	addiw	a5,a5,-1
    53c0:	fef42623          	sw	a5,-20(s0)
    53c4:	fec42783          	lw	a5,-20(s0)
    53c8:	2781                	sext.w	a5,a5
    53ca:	fcf041e3          	bgtz	a5,538c <forktest+0xae>
    }
  }

  if(wait(0) != -1){
    53ce:	4501                	li	a0,0
    53d0:	00002097          	auipc	ra,0x2
    53d4:	fa8080e7          	jalr	-88(ra) # 7378 <wait>
    53d8:	87aa                	mv	a5,a0
    53da:	873e                	mv	a4,a5
    53dc:	57fd                	li	a5,-1
    53de:	02f70163          	beq	a4,a5,5400 <forktest+0x122>
    printf("%s: wait got too many\n", s);
    53e2:	fd843583          	ld	a1,-40(s0)
    53e6:	00004517          	auipc	a0,0x4
    53ea:	47250513          	addi	a0,a0,1138 # 9858 <cv_init+0x1ad2>
    53ee:	00002097          	auipc	ra,0x2
    53f2:	4ba080e7          	jalr	1210(ra) # 78a8 <printf>
    exit(1);
    53f6:	4505                	li	a0,1
    53f8:	00002097          	auipc	ra,0x2
    53fc:	f78080e7          	jalr	-136(ra) # 7370 <exit>
  }
}
    5400:	0001                	nop
    5402:	70a2                	ld	ra,40(sp)
    5404:	7402                	ld	s0,32(sp)
    5406:	6145                	addi	sp,sp,48
    5408:	8082                	ret

000000000000540a <sbrkbasic>:

void
sbrkbasic(char *s)
{
    540a:	715d                	addi	sp,sp,-80
    540c:	e486                	sd	ra,72(sp)
    540e:	e0a2                	sd	s0,64(sp)
    5410:	0880                	addi	s0,sp,80
    5412:	faa43c23          	sd	a0,-72(s0)
  enum { TOOMUCH=1024*1024*1024};
  int i, pid, xstatus;
  char *c, *a, *b;

  // does sbrk() return the expected failure value?
  pid = fork();
    5416:	00002097          	auipc	ra,0x2
    541a:	f52080e7          	jalr	-174(ra) # 7368 <fork>
    541e:	87aa                	mv	a5,a0
    5420:	fcf42a23          	sw	a5,-44(s0)
  if(pid < 0){
    5424:	fd442783          	lw	a5,-44(s0)
    5428:	2781                	sext.w	a5,a5
    542a:	0007df63          	bgez	a5,5448 <sbrkbasic+0x3e>
    printf("fork failed in sbrkbasic\n");
    542e:	00004517          	auipc	a0,0x4
    5432:	44250513          	addi	a0,a0,1090 # 9870 <cv_init+0x1aea>
    5436:	00002097          	auipc	ra,0x2
    543a:	472080e7          	jalr	1138(ra) # 78a8 <printf>
    exit(1);
    543e:	4505                	li	a0,1
    5440:	00002097          	auipc	ra,0x2
    5444:	f30080e7          	jalr	-208(ra) # 7370 <exit>
  }
  if(pid == 0){
    5448:	fd442783          	lw	a5,-44(s0)
    544c:	2781                	sext.w	a5,a5
    544e:	e3b5                	bnez	a5,54b2 <sbrkbasic+0xa8>
    a = sbrk(TOOMUCH);
    5450:	40000537          	lui	a0,0x40000
    5454:	00002097          	auipc	ra,0x2
    5458:	fa4080e7          	jalr	-92(ra) # 73f8 <sbrk>
    545c:	fea43023          	sd	a0,-32(s0)
    if(a == (char*)0xffffffffffffffffL){
    5460:	fe043703          	ld	a4,-32(s0)
    5464:	57fd                	li	a5,-1
    5466:	00f71763          	bne	a4,a5,5474 <sbrkbasic+0x6a>
      // it's OK if this fails.
      exit(0);
    546a:	4501                	li	a0,0
    546c:	00002097          	auipc	ra,0x2
    5470:	f04080e7          	jalr	-252(ra) # 7370 <exit>
    }
    
    for(b = a; b < a+TOOMUCH; b += 4096){
    5474:	fe043783          	ld	a5,-32(s0)
    5478:	fcf43c23          	sd	a5,-40(s0)
    547c:	a829                	j	5496 <sbrkbasic+0x8c>
      *b = 99;
    547e:	fd843783          	ld	a5,-40(s0)
    5482:	06300713          	li	a4,99
    5486:	00e78023          	sb	a4,0(a5)
    for(b = a; b < a+TOOMUCH; b += 4096){
    548a:	fd843703          	ld	a4,-40(s0)
    548e:	6785                	lui	a5,0x1
    5490:	97ba                	add	a5,a5,a4
    5492:	fcf43c23          	sd	a5,-40(s0)
    5496:	fe043703          	ld	a4,-32(s0)
    549a:	400007b7          	lui	a5,0x40000
    549e:	97ba                	add	a5,a5,a4
    54a0:	fd843703          	ld	a4,-40(s0)
    54a4:	fcf76de3          	bltu	a4,a5,547e <sbrkbasic+0x74>
    }
    
    // we should not get here! either sbrk(TOOMUCH)
    // should have failed, or (with lazy allocation)
    // a pagefault should have killed this process.
    exit(1);
    54a8:	4505                	li	a0,1
    54aa:	00002097          	auipc	ra,0x2
    54ae:	ec6080e7          	jalr	-314(ra) # 7370 <exit>
  }

  wait(&xstatus);
    54b2:	fc440793          	addi	a5,s0,-60
    54b6:	853e                	mv	a0,a5
    54b8:	00002097          	auipc	ra,0x2
    54bc:	ec0080e7          	jalr	-320(ra) # 7378 <wait>
  if(xstatus == 1){
    54c0:	fc442783          	lw	a5,-60(s0)
    54c4:	873e                	mv	a4,a5
    54c6:	4785                	li	a5,1
    54c8:	02f71163          	bne	a4,a5,54ea <sbrkbasic+0xe0>
    printf("%s: too much memory allocated!\n", s);
    54cc:	fb843583          	ld	a1,-72(s0)
    54d0:	00004517          	auipc	a0,0x4
    54d4:	3c050513          	addi	a0,a0,960 # 9890 <cv_init+0x1b0a>
    54d8:	00002097          	auipc	ra,0x2
    54dc:	3d0080e7          	jalr	976(ra) # 78a8 <printf>
    exit(1);
    54e0:	4505                	li	a0,1
    54e2:	00002097          	auipc	ra,0x2
    54e6:	e8e080e7          	jalr	-370(ra) # 7370 <exit>
  }

  // can one sbrk() less than a page?
  a = sbrk(0);
    54ea:	4501                	li	a0,0
    54ec:	00002097          	auipc	ra,0x2
    54f0:	f0c080e7          	jalr	-244(ra) # 73f8 <sbrk>
    54f4:	fea43023          	sd	a0,-32(s0)
  for(i = 0; i < 5000; i++){
    54f8:	fe042623          	sw	zero,-20(s0)
    54fc:	a09d                	j	5562 <sbrkbasic+0x158>
    b = sbrk(1);
    54fe:	4505                	li	a0,1
    5500:	00002097          	auipc	ra,0x2
    5504:	ef8080e7          	jalr	-264(ra) # 73f8 <sbrk>
    5508:	fca43c23          	sd	a0,-40(s0)
    if(b != a){
    550c:	fd843703          	ld	a4,-40(s0)
    5510:	fe043783          	ld	a5,-32(s0)
    5514:	02f70863          	beq	a4,a5,5544 <sbrkbasic+0x13a>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    5518:	fec42783          	lw	a5,-20(s0)
    551c:	fd843703          	ld	a4,-40(s0)
    5520:	fe043683          	ld	a3,-32(s0)
    5524:	863e                	mv	a2,a5
    5526:	fb843583          	ld	a1,-72(s0)
    552a:	00004517          	auipc	a0,0x4
    552e:	38650513          	addi	a0,a0,902 # 98b0 <cv_init+0x1b2a>
    5532:	00002097          	auipc	ra,0x2
    5536:	376080e7          	jalr	886(ra) # 78a8 <printf>
      exit(1);
    553a:	4505                	li	a0,1
    553c:	00002097          	auipc	ra,0x2
    5540:	e34080e7          	jalr	-460(ra) # 7370 <exit>
    }
    *b = 1;
    5544:	fd843783          	ld	a5,-40(s0)
    5548:	4705                	li	a4,1
    554a:	00e78023          	sb	a4,0(a5) # 40000000 <__BSS_END__+0x3ffef188>
    a = b + 1;
    554e:	fd843783          	ld	a5,-40(s0)
    5552:	0785                	addi	a5,a5,1
    5554:	fef43023          	sd	a5,-32(s0)
  for(i = 0; i < 5000; i++){
    5558:	fec42783          	lw	a5,-20(s0)
    555c:	2785                	addiw	a5,a5,1
    555e:	fef42623          	sw	a5,-20(s0)
    5562:	fec42783          	lw	a5,-20(s0)
    5566:	0007871b          	sext.w	a4,a5
    556a:	6785                	lui	a5,0x1
    556c:	38778793          	addi	a5,a5,903 # 1387 <openiputtest+0xe9>
    5570:	f8e7d7e3          	bge	a5,a4,54fe <sbrkbasic+0xf4>
  }
  pid = fork();
    5574:	00002097          	auipc	ra,0x2
    5578:	df4080e7          	jalr	-524(ra) # 7368 <fork>
    557c:	87aa                	mv	a5,a0
    557e:	fcf42a23          	sw	a5,-44(s0)
  if(pid < 0){
    5582:	fd442783          	lw	a5,-44(s0)
    5586:	2781                	sext.w	a5,a5
    5588:	0207d163          	bgez	a5,55aa <sbrkbasic+0x1a0>
    printf("%s: sbrk test fork failed\n", s);
    558c:	fb843583          	ld	a1,-72(s0)
    5590:	00004517          	auipc	a0,0x4
    5594:	34050513          	addi	a0,a0,832 # 98d0 <cv_init+0x1b4a>
    5598:	00002097          	auipc	ra,0x2
    559c:	310080e7          	jalr	784(ra) # 78a8 <printf>
    exit(1);
    55a0:	4505                	li	a0,1
    55a2:	00002097          	auipc	ra,0x2
    55a6:	dce080e7          	jalr	-562(ra) # 7370 <exit>
  }
  c = sbrk(1);
    55aa:	4505                	li	a0,1
    55ac:	00002097          	auipc	ra,0x2
    55b0:	e4c080e7          	jalr	-436(ra) # 73f8 <sbrk>
    55b4:	fca43423          	sd	a0,-56(s0)
  c = sbrk(1);
    55b8:	4505                	li	a0,1
    55ba:	00002097          	auipc	ra,0x2
    55be:	e3e080e7          	jalr	-450(ra) # 73f8 <sbrk>
    55c2:	fca43423          	sd	a0,-56(s0)
  if(c != a + 1){
    55c6:	fe043783          	ld	a5,-32(s0)
    55ca:	0785                	addi	a5,a5,1
    55cc:	fc843703          	ld	a4,-56(s0)
    55d0:	02f70163          	beq	a4,a5,55f2 <sbrkbasic+0x1e8>
    printf("%s: sbrk test failed post-fork\n", s);
    55d4:	fb843583          	ld	a1,-72(s0)
    55d8:	00004517          	auipc	a0,0x4
    55dc:	31850513          	addi	a0,a0,792 # 98f0 <cv_init+0x1b6a>
    55e0:	00002097          	auipc	ra,0x2
    55e4:	2c8080e7          	jalr	712(ra) # 78a8 <printf>
    exit(1);
    55e8:	4505                	li	a0,1
    55ea:	00002097          	auipc	ra,0x2
    55ee:	d86080e7          	jalr	-634(ra) # 7370 <exit>
  }
  if(pid == 0)
    55f2:	fd442783          	lw	a5,-44(s0)
    55f6:	2781                	sext.w	a5,a5
    55f8:	e791                	bnez	a5,5604 <sbrkbasic+0x1fa>
    exit(0);
    55fa:	4501                	li	a0,0
    55fc:	00002097          	auipc	ra,0x2
    5600:	d74080e7          	jalr	-652(ra) # 7370 <exit>
  wait(&xstatus);
    5604:	fc440793          	addi	a5,s0,-60
    5608:	853e                	mv	a0,a5
    560a:	00002097          	auipc	ra,0x2
    560e:	d6e080e7          	jalr	-658(ra) # 7378 <wait>
  exit(xstatus);
    5612:	fc442783          	lw	a5,-60(s0)
    5616:	853e                	mv	a0,a5
    5618:	00002097          	auipc	ra,0x2
    561c:	d58080e7          	jalr	-680(ra) # 7370 <exit>

0000000000005620 <sbrkmuch>:
}

void
sbrkmuch(char *s)
{
    5620:	711d                	addi	sp,sp,-96
    5622:	ec86                	sd	ra,88(sp)
    5624:	e8a2                	sd	s0,80(sp)
    5626:	1080                	addi	s0,sp,96
    5628:	faa43423          	sd	a0,-88(s0)
  enum { BIG=100*1024*1024 };
  char *c, *oldbrk, *a, *lastaddr, *p;
  uint64 amt;

  oldbrk = sbrk(0);
    562c:	4501                	li	a0,0
    562e:	00002097          	auipc	ra,0x2
    5632:	dca080e7          	jalr	-566(ra) # 73f8 <sbrk>
    5636:	fea43023          	sd	a0,-32(s0)

  // can one grow address space to something big?
  a = sbrk(0);
    563a:	4501                	li	a0,0
    563c:	00002097          	auipc	ra,0x2
    5640:	dbc080e7          	jalr	-580(ra) # 73f8 <sbrk>
    5644:	fca43c23          	sd	a0,-40(s0)
  amt = BIG - (uint64)a;
    5648:	fd843783          	ld	a5,-40(s0)
    564c:	06400737          	lui	a4,0x6400
    5650:	40f707b3          	sub	a5,a4,a5
    5654:	fcf43823          	sd	a5,-48(s0)
  p = sbrk(amt);
    5658:	fd043783          	ld	a5,-48(s0)
    565c:	2781                	sext.w	a5,a5
    565e:	853e                	mv	a0,a5
    5660:	00002097          	auipc	ra,0x2
    5664:	d98080e7          	jalr	-616(ra) # 73f8 <sbrk>
    5668:	fca43423          	sd	a0,-56(s0)
  if (p != a) {
    566c:	fc843703          	ld	a4,-56(s0)
    5670:	fd843783          	ld	a5,-40(s0)
    5674:	02f70163          	beq	a4,a5,5696 <sbrkmuch+0x76>
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    5678:	fa843583          	ld	a1,-88(s0)
    567c:	00004517          	auipc	a0,0x4
    5680:	29450513          	addi	a0,a0,660 # 9910 <cv_init+0x1b8a>
    5684:	00002097          	auipc	ra,0x2
    5688:	224080e7          	jalr	548(ra) # 78a8 <printf>
    exit(1);
    568c:	4505                	li	a0,1
    568e:	00002097          	auipc	ra,0x2
    5692:	ce2080e7          	jalr	-798(ra) # 7370 <exit>
  }

  // touch each page to make sure it exists.
  char *eee = sbrk(0);
    5696:	4501                	li	a0,0
    5698:	00002097          	auipc	ra,0x2
    569c:	d60080e7          	jalr	-672(ra) # 73f8 <sbrk>
    56a0:	fca43023          	sd	a0,-64(s0)
  for(char *pp = a; pp < eee; pp += 4096)
    56a4:	fd843783          	ld	a5,-40(s0)
    56a8:	fef43423          	sd	a5,-24(s0)
    56ac:	a821                	j	56c4 <sbrkmuch+0xa4>
    *pp = 1;
    56ae:	fe843783          	ld	a5,-24(s0)
    56b2:	4705                	li	a4,1
    56b4:	00e78023          	sb	a4,0(a5)
  for(char *pp = a; pp < eee; pp += 4096)
    56b8:	fe843703          	ld	a4,-24(s0)
    56bc:	6785                	lui	a5,0x1
    56be:	97ba                	add	a5,a5,a4
    56c0:	fef43423          	sd	a5,-24(s0)
    56c4:	fe843703          	ld	a4,-24(s0)
    56c8:	fc043783          	ld	a5,-64(s0)
    56cc:	fef761e3          	bltu	a4,a5,56ae <sbrkmuch+0x8e>

  lastaddr = (char*) (BIG-1);
    56d0:	064007b7          	lui	a5,0x6400
    56d4:	17fd                	addi	a5,a5,-1
    56d6:	faf43c23          	sd	a5,-72(s0)
  *lastaddr = 99;
    56da:	fb843783          	ld	a5,-72(s0)
    56de:	06300713          	li	a4,99
    56e2:	00e78023          	sb	a4,0(a5) # 6400000 <__BSS_END__+0x63ef188>

  // can one de-allocate?
  a = sbrk(0);
    56e6:	4501                	li	a0,0
    56e8:	00002097          	auipc	ra,0x2
    56ec:	d10080e7          	jalr	-752(ra) # 73f8 <sbrk>
    56f0:	fca43c23          	sd	a0,-40(s0)
  c = sbrk(-PGSIZE);
    56f4:	757d                	lui	a0,0xfffff
    56f6:	00002097          	auipc	ra,0x2
    56fa:	d02080e7          	jalr	-766(ra) # 73f8 <sbrk>
    56fe:	faa43823          	sd	a0,-80(s0)
  if(c == (char*)0xffffffffffffffffL){
    5702:	fb043703          	ld	a4,-80(s0)
    5706:	57fd                	li	a5,-1
    5708:	02f71163          	bne	a4,a5,572a <sbrkmuch+0x10a>
    printf("%s: sbrk could not deallocate\n", s);
    570c:	fa843583          	ld	a1,-88(s0)
    5710:	00004517          	auipc	a0,0x4
    5714:	24850513          	addi	a0,a0,584 # 9958 <cv_init+0x1bd2>
    5718:	00002097          	auipc	ra,0x2
    571c:	190080e7          	jalr	400(ra) # 78a8 <printf>
    exit(1);
    5720:	4505                	li	a0,1
    5722:	00002097          	auipc	ra,0x2
    5726:	c4e080e7          	jalr	-946(ra) # 7370 <exit>
  }
  c = sbrk(0);
    572a:	4501                	li	a0,0
    572c:	00002097          	auipc	ra,0x2
    5730:	ccc080e7          	jalr	-820(ra) # 73f8 <sbrk>
    5734:	faa43823          	sd	a0,-80(s0)
  if(c != a - PGSIZE){
    5738:	fd843703          	ld	a4,-40(s0)
    573c:	77fd                	lui	a5,0xfffff
    573e:	97ba                	add	a5,a5,a4
    5740:	fb043703          	ld	a4,-80(s0)
    5744:	02f70563          	beq	a4,a5,576e <sbrkmuch+0x14e>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    5748:	fb043683          	ld	a3,-80(s0)
    574c:	fd843603          	ld	a2,-40(s0)
    5750:	fa843583          	ld	a1,-88(s0)
    5754:	00004517          	auipc	a0,0x4
    5758:	22450513          	addi	a0,a0,548 # 9978 <cv_init+0x1bf2>
    575c:	00002097          	auipc	ra,0x2
    5760:	14c080e7          	jalr	332(ra) # 78a8 <printf>
    exit(1);
    5764:	4505                	li	a0,1
    5766:	00002097          	auipc	ra,0x2
    576a:	c0a080e7          	jalr	-1014(ra) # 7370 <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    576e:	4501                	li	a0,0
    5770:	00002097          	auipc	ra,0x2
    5774:	c88080e7          	jalr	-888(ra) # 73f8 <sbrk>
    5778:	fca43c23          	sd	a0,-40(s0)
  c = sbrk(PGSIZE);
    577c:	6505                	lui	a0,0x1
    577e:	00002097          	auipc	ra,0x2
    5782:	c7a080e7          	jalr	-902(ra) # 73f8 <sbrk>
    5786:	faa43823          	sd	a0,-80(s0)
  if(c != a || sbrk(0) != a + PGSIZE){
    578a:	fb043703          	ld	a4,-80(s0)
    578e:	fd843783          	ld	a5,-40(s0)
    5792:	00f71e63          	bne	a4,a5,57ae <sbrkmuch+0x18e>
    5796:	4501                	li	a0,0
    5798:	00002097          	auipc	ra,0x2
    579c:	c60080e7          	jalr	-928(ra) # 73f8 <sbrk>
    57a0:	86aa                	mv	a3,a0
    57a2:	fd843703          	ld	a4,-40(s0)
    57a6:	6785                	lui	a5,0x1
    57a8:	97ba                	add	a5,a5,a4
    57aa:	02f68563          	beq	a3,a5,57d4 <sbrkmuch+0x1b4>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    57ae:	fb043683          	ld	a3,-80(s0)
    57b2:	fd843603          	ld	a2,-40(s0)
    57b6:	fa843583          	ld	a1,-88(s0)
    57ba:	00004517          	auipc	a0,0x4
    57be:	1fe50513          	addi	a0,a0,510 # 99b8 <cv_init+0x1c32>
    57c2:	00002097          	auipc	ra,0x2
    57c6:	0e6080e7          	jalr	230(ra) # 78a8 <printf>
    exit(1);
    57ca:	4505                	li	a0,1
    57cc:	00002097          	auipc	ra,0x2
    57d0:	ba4080e7          	jalr	-1116(ra) # 7370 <exit>
  }
  if(*lastaddr == 99){
    57d4:	fb843783          	ld	a5,-72(s0)
    57d8:	0007c783          	lbu	a5,0(a5) # 1000 <truncate3+0x1b2>
    57dc:	873e                	mv	a4,a5
    57de:	06300793          	li	a5,99
    57e2:	02f71163          	bne	a4,a5,5804 <sbrkmuch+0x1e4>
    // should be zero
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    57e6:	fa843583          	ld	a1,-88(s0)
    57ea:	00004517          	auipc	a0,0x4
    57ee:	1fe50513          	addi	a0,a0,510 # 99e8 <cv_init+0x1c62>
    57f2:	00002097          	auipc	ra,0x2
    57f6:	0b6080e7          	jalr	182(ra) # 78a8 <printf>
    exit(1);
    57fa:	4505                	li	a0,1
    57fc:	00002097          	auipc	ra,0x2
    5800:	b74080e7          	jalr	-1164(ra) # 7370 <exit>
  }

  a = sbrk(0);
    5804:	4501                	li	a0,0
    5806:	00002097          	auipc	ra,0x2
    580a:	bf2080e7          	jalr	-1038(ra) # 73f8 <sbrk>
    580e:	fca43c23          	sd	a0,-40(s0)
  c = sbrk(-(sbrk(0) - oldbrk));
    5812:	4501                	li	a0,0
    5814:	00002097          	auipc	ra,0x2
    5818:	be4080e7          	jalr	-1052(ra) # 73f8 <sbrk>
    581c:	872a                	mv	a4,a0
    581e:	fe043783          	ld	a5,-32(s0)
    5822:	8f99                	sub	a5,a5,a4
    5824:	2781                	sext.w	a5,a5
    5826:	853e                	mv	a0,a5
    5828:	00002097          	auipc	ra,0x2
    582c:	bd0080e7          	jalr	-1072(ra) # 73f8 <sbrk>
    5830:	faa43823          	sd	a0,-80(s0)
  if(c != a){
    5834:	fb043703          	ld	a4,-80(s0)
    5838:	fd843783          	ld	a5,-40(s0)
    583c:	02f70563          	beq	a4,a5,5866 <sbrkmuch+0x246>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    5840:	fb043683          	ld	a3,-80(s0)
    5844:	fd843603          	ld	a2,-40(s0)
    5848:	fa843583          	ld	a1,-88(s0)
    584c:	00004517          	auipc	a0,0x4
    5850:	1d450513          	addi	a0,a0,468 # 9a20 <cv_init+0x1c9a>
    5854:	00002097          	auipc	ra,0x2
    5858:	054080e7          	jalr	84(ra) # 78a8 <printf>
    exit(1);
    585c:	4505                	li	a0,1
    585e:	00002097          	auipc	ra,0x2
    5862:	b12080e7          	jalr	-1262(ra) # 7370 <exit>
  }
}
    5866:	0001                	nop
    5868:	60e6                	ld	ra,88(sp)
    586a:	6446                	ld	s0,80(sp)
    586c:	6125                	addi	sp,sp,96
    586e:	8082                	ret

0000000000005870 <kernmem>:

// can we read the kernel's memory?
void
kernmem(char *s)
{
    5870:	7179                	addi	sp,sp,-48
    5872:	f406                	sd	ra,40(sp)
    5874:	f022                	sd	s0,32(sp)
    5876:	1800                	addi	s0,sp,48
    5878:	fca43c23          	sd	a0,-40(s0)
  char *a;
  int pid;

  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    587c:	4785                	li	a5,1
    587e:	07fe                	slli	a5,a5,0x1f
    5880:	fef43423          	sd	a5,-24(s0)
    5884:	a04d                	j	5926 <kernmem+0xb6>
    pid = fork();
    5886:	00002097          	auipc	ra,0x2
    588a:	ae2080e7          	jalr	-1310(ra) # 7368 <fork>
    588e:	87aa                	mv	a5,a0
    5890:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    5894:	fe442783          	lw	a5,-28(s0)
    5898:	2781                	sext.w	a5,a5
    589a:	0207d163          	bgez	a5,58bc <kernmem+0x4c>
      printf("%s: fork failed\n", s);
    589e:	fd843583          	ld	a1,-40(s0)
    58a2:	00003517          	auipc	a0,0x3
    58a6:	93e50513          	addi	a0,a0,-1730 # 81e0 <cv_init+0x45a>
    58aa:	00002097          	auipc	ra,0x2
    58ae:	ffe080e7          	jalr	-2(ra) # 78a8 <printf>
      exit(1);
    58b2:	4505                	li	a0,1
    58b4:	00002097          	auipc	ra,0x2
    58b8:	abc080e7          	jalr	-1348(ra) # 7370 <exit>
    }
    if(pid == 0){
    58bc:	fe442783          	lw	a5,-28(s0)
    58c0:	2781                	sext.w	a5,a5
    58c2:	eb85                	bnez	a5,58f2 <kernmem+0x82>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    58c4:	fe843783          	ld	a5,-24(s0)
    58c8:	0007c783          	lbu	a5,0(a5)
    58cc:	2781                	sext.w	a5,a5
    58ce:	86be                	mv	a3,a5
    58d0:	fe843603          	ld	a2,-24(s0)
    58d4:	fd843583          	ld	a1,-40(s0)
    58d8:	00004517          	auipc	a0,0x4
    58dc:	17050513          	addi	a0,a0,368 # 9a48 <cv_init+0x1cc2>
    58e0:	00002097          	auipc	ra,0x2
    58e4:	fc8080e7          	jalr	-56(ra) # 78a8 <printf>
      exit(1);
    58e8:	4505                	li	a0,1
    58ea:	00002097          	auipc	ra,0x2
    58ee:	a86080e7          	jalr	-1402(ra) # 7370 <exit>
    }
    int xstatus;
    wait(&xstatus);
    58f2:	fe040793          	addi	a5,s0,-32
    58f6:	853e                	mv	a0,a5
    58f8:	00002097          	auipc	ra,0x2
    58fc:	a80080e7          	jalr	-1408(ra) # 7378 <wait>
    if(xstatus != -1)  // did kernel kill child?
    5900:	fe042783          	lw	a5,-32(s0)
    5904:	873e                	mv	a4,a5
    5906:	57fd                	li	a5,-1
    5908:	00f70763          	beq	a4,a5,5916 <kernmem+0xa6>
      exit(1);
    590c:	4505                	li	a0,1
    590e:	00002097          	auipc	ra,0x2
    5912:	a62080e7          	jalr	-1438(ra) # 7370 <exit>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    5916:	fe843703          	ld	a4,-24(s0)
    591a:	67b1                	lui	a5,0xc
    591c:	35078793          	addi	a5,a5,848 # c350 <__global_pointer$+0x150f>
    5920:	97ba                	add	a5,a5,a4
    5922:	fef43423          	sd	a5,-24(s0)
    5926:	fe843703          	ld	a4,-24(s0)
    592a:	1003d7b7          	lui	a5,0x1003d
    592e:	078e                	slli	a5,a5,0x3
    5930:	47f78793          	addi	a5,a5,1151 # 1003d47f <__BSS_END__+0x1002c607>
    5934:	f4e7f9e3          	bgeu	a5,a4,5886 <kernmem+0x16>
  }
}
    5938:	0001                	nop
    593a:	0001                	nop
    593c:	70a2                	ld	ra,40(sp)
    593e:	7402                	ld	s0,32(sp)
    5940:	6145                	addi	sp,sp,48
    5942:	8082                	ret

0000000000005944 <MAXVAplus>:

// user code should not be able to write to addresses above MAXVA.
void
MAXVAplus(char *s)
{
    5944:	7139                	addi	sp,sp,-64
    5946:	fc06                	sd	ra,56(sp)
    5948:	f822                	sd	s0,48(sp)
    594a:	0080                	addi	s0,sp,64
    594c:	fca43423          	sd	a0,-56(s0)
  volatile uint64 a = MAXVA;
    5950:	4785                	li	a5,1
    5952:	179a                	slli	a5,a5,0x26
    5954:	fef43023          	sd	a5,-32(s0)
  for( ; a != 0; a <<= 1){
    5958:	a045                	j	59f8 <MAXVAplus+0xb4>
    int pid;
    pid = fork();
    595a:	00002097          	auipc	ra,0x2
    595e:	a0e080e7          	jalr	-1522(ra) # 7368 <fork>
    5962:	87aa                	mv	a5,a0
    5964:	fef42623          	sw	a5,-20(s0)
    if(pid < 0){
    5968:	fec42783          	lw	a5,-20(s0)
    596c:	2781                	sext.w	a5,a5
    596e:	0207d163          	bgez	a5,5990 <MAXVAplus+0x4c>
      printf("%s: fork failed\n", s);
    5972:	fc843583          	ld	a1,-56(s0)
    5976:	00003517          	auipc	a0,0x3
    597a:	86a50513          	addi	a0,a0,-1942 # 81e0 <cv_init+0x45a>
    597e:	00002097          	auipc	ra,0x2
    5982:	f2a080e7          	jalr	-214(ra) # 78a8 <printf>
      exit(1);
    5986:	4505                	li	a0,1
    5988:	00002097          	auipc	ra,0x2
    598c:	9e8080e7          	jalr	-1560(ra) # 7370 <exit>
    }
    if(pid == 0){
    5990:	fec42783          	lw	a5,-20(s0)
    5994:	2781                	sext.w	a5,a5
    5996:	eb95                	bnez	a5,59ca <MAXVAplus+0x86>
      *(char*)a = 99;
    5998:	fe043783          	ld	a5,-32(s0)
    599c:	873e                	mv	a4,a5
    599e:	06300793          	li	a5,99
    59a2:	00f70023          	sb	a5,0(a4) # 6400000 <__BSS_END__+0x63ef188>
      printf("%s: oops wrote %x\n", s, a);
    59a6:	fe043783          	ld	a5,-32(s0)
    59aa:	863e                	mv	a2,a5
    59ac:	fc843583          	ld	a1,-56(s0)
    59b0:	00004517          	auipc	a0,0x4
    59b4:	0b850513          	addi	a0,a0,184 # 9a68 <cv_init+0x1ce2>
    59b8:	00002097          	auipc	ra,0x2
    59bc:	ef0080e7          	jalr	-272(ra) # 78a8 <printf>
      exit(1);
    59c0:	4505                	li	a0,1
    59c2:	00002097          	auipc	ra,0x2
    59c6:	9ae080e7          	jalr	-1618(ra) # 7370 <exit>
    }
    int xstatus;
    wait(&xstatus);
    59ca:	fdc40793          	addi	a5,s0,-36
    59ce:	853e                	mv	a0,a5
    59d0:	00002097          	auipc	ra,0x2
    59d4:	9a8080e7          	jalr	-1624(ra) # 7378 <wait>
    if(xstatus != -1)  // did kernel kill child?
    59d8:	fdc42783          	lw	a5,-36(s0)
    59dc:	873e                	mv	a4,a5
    59de:	57fd                	li	a5,-1
    59e0:	00f70763          	beq	a4,a5,59ee <MAXVAplus+0xaa>
      exit(1);
    59e4:	4505                	li	a0,1
    59e6:	00002097          	auipc	ra,0x2
    59ea:	98a080e7          	jalr	-1654(ra) # 7370 <exit>
  for( ; a != 0; a <<= 1){
    59ee:	fe043783          	ld	a5,-32(s0)
    59f2:	0786                	slli	a5,a5,0x1
    59f4:	fef43023          	sd	a5,-32(s0)
    59f8:	fe043783          	ld	a5,-32(s0)
    59fc:	ffb9                	bnez	a5,595a <MAXVAplus+0x16>
  }
}
    59fe:	0001                	nop
    5a00:	0001                	nop
    5a02:	70e2                	ld	ra,56(sp)
    5a04:	7442                	ld	s0,48(sp)
    5a06:	6121                	addi	sp,sp,64
    5a08:	8082                	ret

0000000000005a0a <sbrkfail>:

// if we run the system out of memory, does it clean up the last
// failed allocation?
void
sbrkfail(char *s)
{
    5a0a:	7119                	addi	sp,sp,-128
    5a0c:	fc86                	sd	ra,120(sp)
    5a0e:	f8a2                	sd	s0,112(sp)
    5a10:	0100                	addi	s0,sp,128
    5a12:	f8a43423          	sd	a0,-120(s0)
  char scratch;
  char *c, *a;
  int pids[10];
  int pid;
 
  if(pipe(fds) != 0){
    5a16:	fc040793          	addi	a5,s0,-64
    5a1a:	853e                	mv	a0,a5
    5a1c:	00002097          	auipc	ra,0x2
    5a20:	964080e7          	jalr	-1692(ra) # 7380 <pipe>
    5a24:	87aa                	mv	a5,a0
    5a26:	c385                	beqz	a5,5a46 <sbrkfail+0x3c>
    printf("%s: pipe() failed\n", s);
    5a28:	f8843583          	ld	a1,-120(s0)
    5a2c:	00003517          	auipc	a0,0x3
    5a30:	c4c50513          	addi	a0,a0,-948 # 8678 <cv_init+0x8f2>
    5a34:	00002097          	auipc	ra,0x2
    5a38:	e74080e7          	jalr	-396(ra) # 78a8 <printf>
    exit(1);
    5a3c:	4505                	li	a0,1
    5a3e:	00002097          	auipc	ra,0x2
    5a42:	932080e7          	jalr	-1742(ra) # 7370 <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    5a46:	fe042623          	sw	zero,-20(s0)
    5a4a:	a075                	j	5af6 <sbrkfail+0xec>
    if((pids[i] = fork()) == 0){
    5a4c:	00002097          	auipc	ra,0x2
    5a50:	91c080e7          	jalr	-1764(ra) # 7368 <fork>
    5a54:	87aa                	mv	a5,a0
    5a56:	873e                	mv	a4,a5
    5a58:	fec42783          	lw	a5,-20(s0)
    5a5c:	078a                	slli	a5,a5,0x2
    5a5e:	17c1                	addi	a5,a5,-16
    5a60:	97a2                	add	a5,a5,s0
    5a62:	fae7a023          	sw	a4,-96(a5)
    5a66:	fec42783          	lw	a5,-20(s0)
    5a6a:	078a                	slli	a5,a5,0x2
    5a6c:	17c1                	addi	a5,a5,-16
    5a6e:	97a2                	add	a5,a5,s0
    5a70:	fa07a783          	lw	a5,-96(a5)
    5a74:	e7b1                	bnez	a5,5ac0 <sbrkfail+0xb6>
      // allocate a lot of memory
      sbrk(BIG - (uint64)sbrk(0));
    5a76:	4501                	li	a0,0
    5a78:	00002097          	auipc	ra,0x2
    5a7c:	980080e7          	jalr	-1664(ra) # 73f8 <sbrk>
    5a80:	87aa                	mv	a5,a0
    5a82:	2781                	sext.w	a5,a5
    5a84:	06400737          	lui	a4,0x6400
    5a88:	40f707bb          	subw	a5,a4,a5
    5a8c:	2781                	sext.w	a5,a5
    5a8e:	2781                	sext.w	a5,a5
    5a90:	853e                	mv	a0,a5
    5a92:	00002097          	auipc	ra,0x2
    5a96:	966080e7          	jalr	-1690(ra) # 73f8 <sbrk>
      write(fds[1], "x", 1);
    5a9a:	fc442783          	lw	a5,-60(s0)
    5a9e:	4605                	li	a2,1
    5aa0:	00002597          	auipc	a1,0x2
    5aa4:	41058593          	addi	a1,a1,1040 # 7eb0 <cv_init+0x12a>
    5aa8:	853e                	mv	a0,a5
    5aaa:	00002097          	auipc	ra,0x2
    5aae:	8e6080e7          	jalr	-1818(ra) # 7390 <write>
      // sit around until killed
      for(;;) sleep(1000);
    5ab2:	3e800513          	li	a0,1000
    5ab6:	00002097          	auipc	ra,0x2
    5aba:	94a080e7          	jalr	-1718(ra) # 7400 <sleep>
    5abe:	bfd5                	j	5ab2 <sbrkfail+0xa8>
    }
    if(pids[i] != -1)
    5ac0:	fec42783          	lw	a5,-20(s0)
    5ac4:	078a                	slli	a5,a5,0x2
    5ac6:	17c1                	addi	a5,a5,-16
    5ac8:	97a2                	add	a5,a5,s0
    5aca:	fa07a783          	lw	a5,-96(a5)
    5ace:	873e                	mv	a4,a5
    5ad0:	57fd                	li	a5,-1
    5ad2:	00f70d63          	beq	a4,a5,5aec <sbrkfail+0xe2>
      read(fds[0], &scratch, 1);
    5ad6:	fc042783          	lw	a5,-64(s0)
    5ada:	fbf40713          	addi	a4,s0,-65
    5ade:	4605                	li	a2,1
    5ae0:	85ba                	mv	a1,a4
    5ae2:	853e                	mv	a0,a5
    5ae4:	00002097          	auipc	ra,0x2
    5ae8:	8a4080e7          	jalr	-1884(ra) # 7388 <read>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    5aec:	fec42783          	lw	a5,-20(s0)
    5af0:	2785                	addiw	a5,a5,1
    5af2:	fef42623          	sw	a5,-20(s0)
    5af6:	fec42783          	lw	a5,-20(s0)
    5afa:	873e                	mv	a4,a5
    5afc:	47a5                	li	a5,9
    5afe:	f4e7f7e3          	bgeu	a5,a4,5a4c <sbrkfail+0x42>
  }

  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(PGSIZE);
    5b02:	6505                	lui	a0,0x1
    5b04:	00002097          	auipc	ra,0x2
    5b08:	8f4080e7          	jalr	-1804(ra) # 73f8 <sbrk>
    5b0c:	fea43023          	sd	a0,-32(s0)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    5b10:	fe042623          	sw	zero,-20(s0)
    5b14:	a0a1                	j	5b5c <sbrkfail+0x152>
    if(pids[i] == -1)
    5b16:	fec42783          	lw	a5,-20(s0)
    5b1a:	078a                	slli	a5,a5,0x2
    5b1c:	17c1                	addi	a5,a5,-16
    5b1e:	97a2                	add	a5,a5,s0
    5b20:	fa07a783          	lw	a5,-96(a5)
    5b24:	873e                	mv	a4,a5
    5b26:	57fd                	li	a5,-1
    5b28:	02f70463          	beq	a4,a5,5b50 <sbrkfail+0x146>
      continue;
    kill(pids[i]);
    5b2c:	fec42783          	lw	a5,-20(s0)
    5b30:	078a                	slli	a5,a5,0x2
    5b32:	17c1                	addi	a5,a5,-16
    5b34:	97a2                	add	a5,a5,s0
    5b36:	fa07a783          	lw	a5,-96(a5)
    5b3a:	853e                	mv	a0,a5
    5b3c:	00002097          	auipc	ra,0x2
    5b40:	864080e7          	jalr	-1948(ra) # 73a0 <kill>
    wait(0);
    5b44:	4501                	li	a0,0
    5b46:	00002097          	auipc	ra,0x2
    5b4a:	832080e7          	jalr	-1998(ra) # 7378 <wait>
    5b4e:	a011                	j	5b52 <sbrkfail+0x148>
      continue;
    5b50:	0001                	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    5b52:	fec42783          	lw	a5,-20(s0)
    5b56:	2785                	addiw	a5,a5,1
    5b58:	fef42623          	sw	a5,-20(s0)
    5b5c:	fec42783          	lw	a5,-20(s0)
    5b60:	873e                	mv	a4,a5
    5b62:	47a5                	li	a5,9
    5b64:	fae7f9e3          	bgeu	a5,a4,5b16 <sbrkfail+0x10c>
  }
  if(c == (char*)0xffffffffffffffffL){
    5b68:	fe043703          	ld	a4,-32(s0)
    5b6c:	57fd                	li	a5,-1
    5b6e:	02f71163          	bne	a4,a5,5b90 <sbrkfail+0x186>
    printf("%s: failed sbrk leaked memory\n", s);
    5b72:	f8843583          	ld	a1,-120(s0)
    5b76:	00004517          	auipc	a0,0x4
    5b7a:	f0a50513          	addi	a0,a0,-246 # 9a80 <cv_init+0x1cfa>
    5b7e:	00002097          	auipc	ra,0x2
    5b82:	d2a080e7          	jalr	-726(ra) # 78a8 <printf>
    exit(1);
    5b86:	4505                	li	a0,1
    5b88:	00001097          	auipc	ra,0x1
    5b8c:	7e8080e7          	jalr	2024(ra) # 7370 <exit>
  }

  // test running fork with the above allocated page 
  pid = fork();
    5b90:	00001097          	auipc	ra,0x1
    5b94:	7d8080e7          	jalr	2008(ra) # 7368 <fork>
    5b98:	87aa                	mv	a5,a0
    5b9a:	fcf42e23          	sw	a5,-36(s0)
  if(pid < 0){
    5b9e:	fdc42783          	lw	a5,-36(s0)
    5ba2:	2781                	sext.w	a5,a5
    5ba4:	0207d163          	bgez	a5,5bc6 <sbrkfail+0x1bc>
    printf("%s: fork failed\n", s);
    5ba8:	f8843583          	ld	a1,-120(s0)
    5bac:	00002517          	auipc	a0,0x2
    5bb0:	63450513          	addi	a0,a0,1588 # 81e0 <cv_init+0x45a>
    5bb4:	00002097          	auipc	ra,0x2
    5bb8:	cf4080e7          	jalr	-780(ra) # 78a8 <printf>
    exit(1);
    5bbc:	4505                	li	a0,1
    5bbe:	00001097          	auipc	ra,0x1
    5bc2:	7b2080e7          	jalr	1970(ra) # 7370 <exit>
  }
  if(pid == 0){
    5bc6:	fdc42783          	lw	a5,-36(s0)
    5bca:	2781                	sext.w	a5,a5
    5bcc:	e3c9                	bnez	a5,5c4e <sbrkfail+0x244>
    // allocate a lot of memory.
    // this should produce a page fault,
    // and thus not complete.
    a = sbrk(0);
    5bce:	4501                	li	a0,0
    5bd0:	00002097          	auipc	ra,0x2
    5bd4:	828080e7          	jalr	-2008(ra) # 73f8 <sbrk>
    5bd8:	fca43823          	sd	a0,-48(s0)
    sbrk(10*BIG);
    5bdc:	3e800537          	lui	a0,0x3e800
    5be0:	00002097          	auipc	ra,0x2
    5be4:	818080e7          	jalr	-2024(ra) # 73f8 <sbrk>
    int n = 0;
    5be8:	fe042423          	sw	zero,-24(s0)
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    5bec:	fe042623          	sw	zero,-20(s0)
    5bf0:	a02d                	j	5c1a <sbrkfail+0x210>
      n += *(a+i);
    5bf2:	fec42783          	lw	a5,-20(s0)
    5bf6:	fd043703          	ld	a4,-48(s0)
    5bfa:	97ba                	add	a5,a5,a4
    5bfc:	0007c783          	lbu	a5,0(a5)
    5c00:	2781                	sext.w	a5,a5
    5c02:	fe842703          	lw	a4,-24(s0)
    5c06:	9fb9                	addw	a5,a5,a4
    5c08:	fef42423          	sw	a5,-24(s0)
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    5c0c:	fec42783          	lw	a5,-20(s0)
    5c10:	873e                	mv	a4,a5
    5c12:	6785                	lui	a5,0x1
    5c14:	9fb9                	addw	a5,a5,a4
    5c16:	fef42623          	sw	a5,-20(s0)
    5c1a:	fec42783          	lw	a5,-20(s0)
    5c1e:	0007871b          	sext.w	a4,a5
    5c22:	3e8007b7          	lui	a5,0x3e800
    5c26:	fcf746e3          	blt	a4,a5,5bf2 <sbrkfail+0x1e8>
    }
    // print n so the compiler doesn't optimize away
    // the for loop.
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    5c2a:	fe842783          	lw	a5,-24(s0)
    5c2e:	863e                	mv	a2,a5
    5c30:	f8843583          	ld	a1,-120(s0)
    5c34:	00004517          	auipc	a0,0x4
    5c38:	e6c50513          	addi	a0,a0,-404 # 9aa0 <cv_init+0x1d1a>
    5c3c:	00002097          	auipc	ra,0x2
    5c40:	c6c080e7          	jalr	-916(ra) # 78a8 <printf>
    exit(1);
    5c44:	4505                	li	a0,1
    5c46:	00001097          	auipc	ra,0x1
    5c4a:	72a080e7          	jalr	1834(ra) # 7370 <exit>
  }
  wait(&xstatus);
    5c4e:	fcc40793          	addi	a5,s0,-52
    5c52:	853e                	mv	a0,a5
    5c54:	00001097          	auipc	ra,0x1
    5c58:	724080e7          	jalr	1828(ra) # 7378 <wait>
  if(xstatus != -1 && xstatus != 2)
    5c5c:	fcc42783          	lw	a5,-52(s0)
    5c60:	873e                	mv	a4,a5
    5c62:	57fd                	li	a5,-1
    5c64:	00f70d63          	beq	a4,a5,5c7e <sbrkfail+0x274>
    5c68:	fcc42783          	lw	a5,-52(s0)
    5c6c:	873e                	mv	a4,a5
    5c6e:	4789                	li	a5,2
    5c70:	00f70763          	beq	a4,a5,5c7e <sbrkfail+0x274>
    exit(1);
    5c74:	4505                	li	a0,1
    5c76:	00001097          	auipc	ra,0x1
    5c7a:	6fa080e7          	jalr	1786(ra) # 7370 <exit>
}
    5c7e:	0001                	nop
    5c80:	70e6                	ld	ra,120(sp)
    5c82:	7446                	ld	s0,112(sp)
    5c84:	6109                	addi	sp,sp,128
    5c86:	8082                	ret

0000000000005c88 <sbrkarg>:

  
// test reads/writes from/to allocated memory
void
sbrkarg(char *s)
{
    5c88:	7179                	addi	sp,sp,-48
    5c8a:	f406                	sd	ra,40(sp)
    5c8c:	f022                	sd	s0,32(sp)
    5c8e:	1800                	addi	s0,sp,48
    5c90:	fca43c23          	sd	a0,-40(s0)
  char *a;
  int fd, n;

  a = sbrk(PGSIZE);
    5c94:	6505                	lui	a0,0x1
    5c96:	00001097          	auipc	ra,0x1
    5c9a:	762080e7          	jalr	1890(ra) # 73f8 <sbrk>
    5c9e:	fea43423          	sd	a0,-24(s0)
  fd = open("sbrk", O_CREATE|O_WRONLY);
    5ca2:	20100593          	li	a1,513
    5ca6:	00004517          	auipc	a0,0x4
    5caa:	e2a50513          	addi	a0,a0,-470 # 9ad0 <cv_init+0x1d4a>
    5cae:	00001097          	auipc	ra,0x1
    5cb2:	702080e7          	jalr	1794(ra) # 73b0 <open>
    5cb6:	87aa                	mv	a5,a0
    5cb8:	fef42223          	sw	a5,-28(s0)
  unlink("sbrk");
    5cbc:	00004517          	auipc	a0,0x4
    5cc0:	e1450513          	addi	a0,a0,-492 # 9ad0 <cv_init+0x1d4a>
    5cc4:	00001097          	auipc	ra,0x1
    5cc8:	6fc080e7          	jalr	1788(ra) # 73c0 <unlink>
  if(fd < 0)  {
    5ccc:	fe442783          	lw	a5,-28(s0)
    5cd0:	2781                	sext.w	a5,a5
    5cd2:	0207d163          	bgez	a5,5cf4 <sbrkarg+0x6c>
    printf("%s: open sbrk failed\n", s);
    5cd6:	fd843583          	ld	a1,-40(s0)
    5cda:	00004517          	auipc	a0,0x4
    5cde:	dfe50513          	addi	a0,a0,-514 # 9ad8 <cv_init+0x1d52>
    5ce2:	00002097          	auipc	ra,0x2
    5ce6:	bc6080e7          	jalr	-1082(ra) # 78a8 <printf>
    exit(1);
    5cea:	4505                	li	a0,1
    5cec:	00001097          	auipc	ra,0x1
    5cf0:	684080e7          	jalr	1668(ra) # 7370 <exit>
  }
  if ((n = write(fd, a, PGSIZE)) < 0) {
    5cf4:	fe442783          	lw	a5,-28(s0)
    5cf8:	6605                	lui	a2,0x1
    5cfa:	fe843583          	ld	a1,-24(s0)
    5cfe:	853e                	mv	a0,a5
    5d00:	00001097          	auipc	ra,0x1
    5d04:	690080e7          	jalr	1680(ra) # 7390 <write>
    5d08:	87aa                	mv	a5,a0
    5d0a:	fef42023          	sw	a5,-32(s0)
    5d0e:	fe042783          	lw	a5,-32(s0)
    5d12:	2781                	sext.w	a5,a5
    5d14:	0207d163          	bgez	a5,5d36 <sbrkarg+0xae>
    printf("%s: write sbrk failed\n", s);
    5d18:	fd843583          	ld	a1,-40(s0)
    5d1c:	00004517          	auipc	a0,0x4
    5d20:	dd450513          	addi	a0,a0,-556 # 9af0 <cv_init+0x1d6a>
    5d24:	00002097          	auipc	ra,0x2
    5d28:	b84080e7          	jalr	-1148(ra) # 78a8 <printf>
    exit(1);
    5d2c:	4505                	li	a0,1
    5d2e:	00001097          	auipc	ra,0x1
    5d32:	642080e7          	jalr	1602(ra) # 7370 <exit>
  }
  close(fd);
    5d36:	fe442783          	lw	a5,-28(s0)
    5d3a:	853e                	mv	a0,a5
    5d3c:	00001097          	auipc	ra,0x1
    5d40:	65c080e7          	jalr	1628(ra) # 7398 <close>

  // test writes to allocated memory
  a = sbrk(PGSIZE);
    5d44:	6505                	lui	a0,0x1
    5d46:	00001097          	auipc	ra,0x1
    5d4a:	6b2080e7          	jalr	1714(ra) # 73f8 <sbrk>
    5d4e:	fea43423          	sd	a0,-24(s0)
  if(pipe((int *) a) != 0){
    5d52:	fe843503          	ld	a0,-24(s0)
    5d56:	00001097          	auipc	ra,0x1
    5d5a:	62a080e7          	jalr	1578(ra) # 7380 <pipe>
    5d5e:	87aa                	mv	a5,a0
    5d60:	c385                	beqz	a5,5d80 <sbrkarg+0xf8>
    printf("%s: pipe() failed\n", s);
    5d62:	fd843583          	ld	a1,-40(s0)
    5d66:	00003517          	auipc	a0,0x3
    5d6a:	91250513          	addi	a0,a0,-1774 # 8678 <cv_init+0x8f2>
    5d6e:	00002097          	auipc	ra,0x2
    5d72:	b3a080e7          	jalr	-1222(ra) # 78a8 <printf>
    exit(1);
    5d76:	4505                	li	a0,1
    5d78:	00001097          	auipc	ra,0x1
    5d7c:	5f8080e7          	jalr	1528(ra) # 7370 <exit>
  } 
}
    5d80:	0001                	nop
    5d82:	70a2                	ld	ra,40(sp)
    5d84:	7402                	ld	s0,32(sp)
    5d86:	6145                	addi	sp,sp,48
    5d88:	8082                	ret

0000000000005d8a <validatetest>:

void
validatetest(char *s)
{
    5d8a:	7179                	addi	sp,sp,-48
    5d8c:	f406                	sd	ra,40(sp)
    5d8e:	f022                	sd	s0,32(sp)
    5d90:	1800                	addi	s0,sp,48
    5d92:	fca43c23          	sd	a0,-40(s0)
  int hi;
  uint64 p;

  hi = 1100*1024;
    5d96:	001137b7          	lui	a5,0x113
    5d9a:	fef42223          	sw	a5,-28(s0)
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    5d9e:	fe043423          	sd	zero,-24(s0)
    5da2:	a0b1                	j	5dee <validatetest+0x64>
    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    5da4:	fe843783          	ld	a5,-24(s0)
    5da8:	85be                	mv	a1,a5
    5daa:	00004517          	auipc	a0,0x4
    5dae:	d5e50513          	addi	a0,a0,-674 # 9b08 <cv_init+0x1d82>
    5db2:	00001097          	auipc	ra,0x1
    5db6:	61e080e7          	jalr	1566(ra) # 73d0 <link>
    5dba:	87aa                	mv	a5,a0
    5dbc:	873e                	mv	a4,a5
    5dbe:	57fd                	li	a5,-1
    5dc0:	02f70163          	beq	a4,a5,5de2 <validatetest+0x58>
      printf("%s: link should not succeed\n", s);
    5dc4:	fd843583          	ld	a1,-40(s0)
    5dc8:	00004517          	auipc	a0,0x4
    5dcc:	d5050513          	addi	a0,a0,-688 # 9b18 <cv_init+0x1d92>
    5dd0:	00002097          	auipc	ra,0x2
    5dd4:	ad8080e7          	jalr	-1320(ra) # 78a8 <printf>
      exit(1);
    5dd8:	4505                	li	a0,1
    5dda:	00001097          	auipc	ra,0x1
    5dde:	596080e7          	jalr	1430(ra) # 7370 <exit>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    5de2:	fe843703          	ld	a4,-24(s0)
    5de6:	6785                	lui	a5,0x1
    5de8:	97ba                	add	a5,a5,a4
    5dea:	fef43423          	sd	a5,-24(s0)
    5dee:	fe442783          	lw	a5,-28(s0)
    5df2:	1782                	slli	a5,a5,0x20
    5df4:	9381                	srli	a5,a5,0x20
    5df6:	fe843703          	ld	a4,-24(s0)
    5dfa:	fae7f5e3          	bgeu	a5,a4,5da4 <validatetest+0x1a>
    }
  }
}
    5dfe:	0001                	nop
    5e00:	0001                	nop
    5e02:	70a2                	ld	ra,40(sp)
    5e04:	7402                	ld	s0,32(sp)
    5e06:	6145                	addi	sp,sp,48
    5e08:	8082                	ret

0000000000005e0a <bsstest>:

// does uninitialized data start out zero?
char uninit[10000];
void
bsstest(char *s)
{
    5e0a:	7179                	addi	sp,sp,-48
    5e0c:	f406                	sd	ra,40(sp)
    5e0e:	f022                	sd	s0,32(sp)
    5e10:	1800                	addi	s0,sp,48
    5e12:	fca43c23          	sd	a0,-40(s0)
  int i;

  for(i = 0; i < sizeof(uninit); i++){
    5e16:	fe042623          	sw	zero,-20(s0)
    5e1a:	a83d                	j	5e58 <bsstest+0x4e>
    if(uninit[i] != '\0'){
    5e1c:	00008717          	auipc	a4,0x8
    5e20:	82c70713          	addi	a4,a4,-2004 # d648 <uninit>
    5e24:	fec42783          	lw	a5,-20(s0)
    5e28:	97ba                	add	a5,a5,a4
    5e2a:	0007c783          	lbu	a5,0(a5) # 1000 <truncate3+0x1b2>
    5e2e:	c385                	beqz	a5,5e4e <bsstest+0x44>
      printf("%s: bss test failed\n", s);
    5e30:	fd843583          	ld	a1,-40(s0)
    5e34:	00004517          	auipc	a0,0x4
    5e38:	d0450513          	addi	a0,a0,-764 # 9b38 <cv_init+0x1db2>
    5e3c:	00002097          	auipc	ra,0x2
    5e40:	a6c080e7          	jalr	-1428(ra) # 78a8 <printf>
      exit(1);
    5e44:	4505                	li	a0,1
    5e46:	00001097          	auipc	ra,0x1
    5e4a:	52a080e7          	jalr	1322(ra) # 7370 <exit>
  for(i = 0; i < sizeof(uninit); i++){
    5e4e:	fec42783          	lw	a5,-20(s0)
    5e52:	2785                	addiw	a5,a5,1
    5e54:	fef42623          	sw	a5,-20(s0)
    5e58:	fec42783          	lw	a5,-20(s0)
    5e5c:	873e                	mv	a4,a5
    5e5e:	6789                	lui	a5,0x2
    5e60:	70f78793          	addi	a5,a5,1807 # 270f <reparent2+0x7f>
    5e64:	fae7fce3          	bgeu	a5,a4,5e1c <bsstest+0x12>
    }
  }
}
    5e68:	0001                	nop
    5e6a:	0001                	nop
    5e6c:	70a2                	ld	ra,40(sp)
    5e6e:	7402                	ld	s0,32(sp)
    5e70:	6145                	addi	sp,sp,48
    5e72:	8082                	ret

0000000000005e74 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(char *s)
{
    5e74:	7179                	addi	sp,sp,-48
    5e76:	f406                	sd	ra,40(sp)
    5e78:	f022                	sd	s0,32(sp)
    5e7a:	1800                	addi	s0,sp,48
    5e7c:	fca43c23          	sd	a0,-40(s0)
  int pid, fd, xstatus;

  unlink("bigarg-ok");
    5e80:	00004517          	auipc	a0,0x4
    5e84:	cd050513          	addi	a0,a0,-816 # 9b50 <cv_init+0x1dca>
    5e88:	00001097          	auipc	ra,0x1
    5e8c:	538080e7          	jalr	1336(ra) # 73c0 <unlink>
  pid = fork();
    5e90:	00001097          	auipc	ra,0x1
    5e94:	4d8080e7          	jalr	1240(ra) # 7368 <fork>
    5e98:	87aa                	mv	a5,a0
    5e9a:	fef42423          	sw	a5,-24(s0)
  if(pid == 0){
    5e9e:	fe842783          	lw	a5,-24(s0)
    5ea2:	2781                	sext.w	a5,a5
    5ea4:	ebc1                	bnez	a5,5f34 <bigargtest+0xc0>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    5ea6:	fe042623          	sw	zero,-20(s0)
    5eaa:	a01d                	j	5ed0 <bigargtest+0x5c>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    5eac:	0000b717          	auipc	a4,0xb
    5eb0:	eb470713          	addi	a4,a4,-332 # 10d60 <args.1>
    5eb4:	fec42783          	lw	a5,-20(s0)
    5eb8:	078e                	slli	a5,a5,0x3
    5eba:	97ba                	add	a5,a5,a4
    5ebc:	00004717          	auipc	a4,0x4
    5ec0:	ca470713          	addi	a4,a4,-860 # 9b60 <cv_init+0x1dda>
    5ec4:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    5ec6:	fec42783          	lw	a5,-20(s0)
    5eca:	2785                	addiw	a5,a5,1
    5ecc:	fef42623          	sw	a5,-20(s0)
    5ed0:	fec42783          	lw	a5,-20(s0)
    5ed4:	0007871b          	sext.w	a4,a5
    5ed8:	47f9                	li	a5,30
    5eda:	fce7d9e3          	bge	a5,a4,5eac <bigargtest+0x38>
    args[MAXARG-1] = 0;
    5ede:	0000b797          	auipc	a5,0xb
    5ee2:	e8278793          	addi	a5,a5,-382 # 10d60 <args.1>
    5ee6:	0e07bc23          	sd	zero,248(a5)
    exec("echo", args);
    5eea:	0000b597          	auipc	a1,0xb
    5eee:	e7658593          	addi	a1,a1,-394 # 10d60 <args.1>
    5ef2:	00002517          	auipc	a0,0x2
    5ef6:	0ce50513          	addi	a0,a0,206 # 7fc0 <cv_init+0x23a>
    5efa:	00001097          	auipc	ra,0x1
    5efe:	4ae080e7          	jalr	1198(ra) # 73a8 <exec>
    fd = open("bigarg-ok", O_CREATE);
    5f02:	20000593          	li	a1,512
    5f06:	00004517          	auipc	a0,0x4
    5f0a:	c4a50513          	addi	a0,a0,-950 # 9b50 <cv_init+0x1dca>
    5f0e:	00001097          	auipc	ra,0x1
    5f12:	4a2080e7          	jalr	1186(ra) # 73b0 <open>
    5f16:	87aa                	mv	a5,a0
    5f18:	fef42223          	sw	a5,-28(s0)
    close(fd);
    5f1c:	fe442783          	lw	a5,-28(s0)
    5f20:	853e                	mv	a0,a5
    5f22:	00001097          	auipc	ra,0x1
    5f26:	476080e7          	jalr	1142(ra) # 7398 <close>
    exit(0);
    5f2a:	4501                	li	a0,0
    5f2c:	00001097          	auipc	ra,0x1
    5f30:	444080e7          	jalr	1092(ra) # 7370 <exit>
  } else if(pid < 0){
    5f34:	fe842783          	lw	a5,-24(s0)
    5f38:	2781                	sext.w	a5,a5
    5f3a:	0207d163          	bgez	a5,5f5c <bigargtest+0xe8>
    printf("%s: bigargtest: fork failed\n", s);
    5f3e:	fd843583          	ld	a1,-40(s0)
    5f42:	00004517          	auipc	a0,0x4
    5f46:	cfe50513          	addi	a0,a0,-770 # 9c40 <cv_init+0x1eba>
    5f4a:	00002097          	auipc	ra,0x2
    5f4e:	95e080e7          	jalr	-1698(ra) # 78a8 <printf>
    exit(1);
    5f52:	4505                	li	a0,1
    5f54:	00001097          	auipc	ra,0x1
    5f58:	41c080e7          	jalr	1052(ra) # 7370 <exit>
  }
  
  wait(&xstatus);
    5f5c:	fe040793          	addi	a5,s0,-32
    5f60:	853e                	mv	a0,a5
    5f62:	00001097          	auipc	ra,0x1
    5f66:	416080e7          	jalr	1046(ra) # 7378 <wait>
  if(xstatus != 0)
    5f6a:	fe042783          	lw	a5,-32(s0)
    5f6e:	cb81                	beqz	a5,5f7e <bigargtest+0x10a>
    exit(xstatus);
    5f70:	fe042783          	lw	a5,-32(s0)
    5f74:	853e                	mv	a0,a5
    5f76:	00001097          	auipc	ra,0x1
    5f7a:	3fa080e7          	jalr	1018(ra) # 7370 <exit>
  fd = open("bigarg-ok", 0);
    5f7e:	4581                	li	a1,0
    5f80:	00004517          	auipc	a0,0x4
    5f84:	bd050513          	addi	a0,a0,-1072 # 9b50 <cv_init+0x1dca>
    5f88:	00001097          	auipc	ra,0x1
    5f8c:	428080e7          	jalr	1064(ra) # 73b0 <open>
    5f90:	87aa                	mv	a5,a0
    5f92:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    5f96:	fe442783          	lw	a5,-28(s0)
    5f9a:	2781                	sext.w	a5,a5
    5f9c:	0207d163          	bgez	a5,5fbe <bigargtest+0x14a>
    printf("%s: bigarg test failed!\n", s);
    5fa0:	fd843583          	ld	a1,-40(s0)
    5fa4:	00004517          	auipc	a0,0x4
    5fa8:	cbc50513          	addi	a0,a0,-836 # 9c60 <cv_init+0x1eda>
    5fac:	00002097          	auipc	ra,0x2
    5fb0:	8fc080e7          	jalr	-1796(ra) # 78a8 <printf>
    exit(1);
    5fb4:	4505                	li	a0,1
    5fb6:	00001097          	auipc	ra,0x1
    5fba:	3ba080e7          	jalr	954(ra) # 7370 <exit>
  }
  close(fd);
    5fbe:	fe442783          	lw	a5,-28(s0)
    5fc2:	853e                	mv	a0,a5
    5fc4:	00001097          	auipc	ra,0x1
    5fc8:	3d4080e7          	jalr	980(ra) # 7398 <close>
}
    5fcc:	0001                	nop
    5fce:	70a2                	ld	ra,40(sp)
    5fd0:	7402                	ld	s0,32(sp)
    5fd2:	6145                	addi	sp,sp,48
    5fd4:	8082                	ret

0000000000005fd6 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    5fd6:	7159                	addi	sp,sp,-112
    5fd8:	f486                	sd	ra,104(sp)
    5fda:	f0a2                	sd	s0,96(sp)
    5fdc:	1880                	addi	s0,sp,112
  int nfiles;
  int fsblocks = 0;
    5fde:	fe042423          	sw	zero,-24(s0)

  printf("fsfull test\n");
    5fe2:	00004517          	auipc	a0,0x4
    5fe6:	c9e50513          	addi	a0,a0,-866 # 9c80 <cv_init+0x1efa>
    5fea:	00002097          	auipc	ra,0x2
    5fee:	8be080e7          	jalr	-1858(ra) # 78a8 <printf>

  for(nfiles = 0; ; nfiles++){
    5ff2:	fe042623          	sw	zero,-20(s0)
    char name[64];
    name[0] = 'f';
    5ff6:	06600793          	li	a5,102
    5ffa:	f8f40c23          	sb	a5,-104(s0)
    name[1] = '0' + nfiles / 1000;
    5ffe:	fec42783          	lw	a5,-20(s0)
    6002:	873e                	mv	a4,a5
    6004:	3e800793          	li	a5,1000
    6008:	02f747bb          	divw	a5,a4,a5
    600c:	2781                	sext.w	a5,a5
    600e:	0ff7f793          	zext.b	a5,a5
    6012:	0307879b          	addiw	a5,a5,48
    6016:	0ff7f793          	zext.b	a5,a5
    601a:	f8f40ca3          	sb	a5,-103(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    601e:	fec42783          	lw	a5,-20(s0)
    6022:	873e                	mv	a4,a5
    6024:	3e800793          	li	a5,1000
    6028:	02f767bb          	remw	a5,a4,a5
    602c:	2781                	sext.w	a5,a5
    602e:	873e                	mv	a4,a5
    6030:	06400793          	li	a5,100
    6034:	02f747bb          	divw	a5,a4,a5
    6038:	2781                	sext.w	a5,a5
    603a:	0ff7f793          	zext.b	a5,a5
    603e:	0307879b          	addiw	a5,a5,48
    6042:	0ff7f793          	zext.b	a5,a5
    6046:	f8f40d23          	sb	a5,-102(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    604a:	fec42783          	lw	a5,-20(s0)
    604e:	873e                	mv	a4,a5
    6050:	06400793          	li	a5,100
    6054:	02f767bb          	remw	a5,a4,a5
    6058:	2781                	sext.w	a5,a5
    605a:	873e                	mv	a4,a5
    605c:	47a9                	li	a5,10
    605e:	02f747bb          	divw	a5,a4,a5
    6062:	2781                	sext.w	a5,a5
    6064:	0ff7f793          	zext.b	a5,a5
    6068:	0307879b          	addiw	a5,a5,48
    606c:	0ff7f793          	zext.b	a5,a5
    6070:	f8f40da3          	sb	a5,-101(s0)
    name[4] = '0' + (nfiles % 10);
    6074:	fec42783          	lw	a5,-20(s0)
    6078:	873e                	mv	a4,a5
    607a:	47a9                	li	a5,10
    607c:	02f767bb          	remw	a5,a4,a5
    6080:	2781                	sext.w	a5,a5
    6082:	0ff7f793          	zext.b	a5,a5
    6086:	0307879b          	addiw	a5,a5,48
    608a:	0ff7f793          	zext.b	a5,a5
    608e:	f8f40e23          	sb	a5,-100(s0)
    name[5] = '\0';
    6092:	f8040ea3          	sb	zero,-99(s0)
    printf("writing %s\n", name);
    6096:	f9840793          	addi	a5,s0,-104
    609a:	85be                	mv	a1,a5
    609c:	00004517          	auipc	a0,0x4
    60a0:	bf450513          	addi	a0,a0,-1036 # 9c90 <cv_init+0x1f0a>
    60a4:	00002097          	auipc	ra,0x2
    60a8:	804080e7          	jalr	-2044(ra) # 78a8 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    60ac:	f9840793          	addi	a5,s0,-104
    60b0:	20200593          	li	a1,514
    60b4:	853e                	mv	a0,a5
    60b6:	00001097          	auipc	ra,0x1
    60ba:	2fa080e7          	jalr	762(ra) # 73b0 <open>
    60be:	87aa                	mv	a5,a0
    60c0:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    60c4:	fe042783          	lw	a5,-32(s0)
    60c8:	2781                	sext.w	a5,a5
    60ca:	0007de63          	bgez	a5,60e6 <fsfull+0x110>
      printf("open %s failed\n", name);
    60ce:	f9840793          	addi	a5,s0,-104
    60d2:	85be                	mv	a1,a5
    60d4:	00004517          	auipc	a0,0x4
    60d8:	bcc50513          	addi	a0,a0,-1076 # 9ca0 <cv_init+0x1f1a>
    60dc:	00001097          	auipc	ra,0x1
    60e0:	7cc080e7          	jalr	1996(ra) # 78a8 <printf>
      break;
    60e4:	a079                	j	6172 <fsfull+0x19c>
    }
    int total = 0;
    60e6:	fe042223          	sw	zero,-28(s0)
    while(1){
      int cc = write(fd, buf, BSIZE);
    60ea:	fe042783          	lw	a5,-32(s0)
    60ee:	40000613          	li	a2,1024
    60f2:	00004597          	auipc	a1,0x4
    60f6:	55658593          	addi	a1,a1,1366 # a648 <buf>
    60fa:	853e                	mv	a0,a5
    60fc:	00001097          	auipc	ra,0x1
    6100:	294080e7          	jalr	660(ra) # 7390 <write>
    6104:	87aa                	mv	a5,a0
    6106:	fcf42e23          	sw	a5,-36(s0)
      if(cc < BSIZE)
    610a:	fdc42783          	lw	a5,-36(s0)
    610e:	0007871b          	sext.w	a4,a5
    6112:	3ff00793          	li	a5,1023
    6116:	02e7d063          	bge	a5,a4,6136 <fsfull+0x160>
        break;
      total += cc;
    611a:	fe442783          	lw	a5,-28(s0)
    611e:	873e                	mv	a4,a5
    6120:	fdc42783          	lw	a5,-36(s0)
    6124:	9fb9                	addw	a5,a5,a4
    6126:	fef42223          	sw	a5,-28(s0)
      fsblocks++;
    612a:	fe842783          	lw	a5,-24(s0)
    612e:	2785                	addiw	a5,a5,1
    6130:	fef42423          	sw	a5,-24(s0)
    while(1){
    6134:	bf5d                	j	60ea <fsfull+0x114>
        break;
    6136:	0001                	nop
    }
    printf("wrote %d bytes\n", total);
    6138:	fe442783          	lw	a5,-28(s0)
    613c:	85be                	mv	a1,a5
    613e:	00004517          	auipc	a0,0x4
    6142:	b7250513          	addi	a0,a0,-1166 # 9cb0 <cv_init+0x1f2a>
    6146:	00001097          	auipc	ra,0x1
    614a:	762080e7          	jalr	1890(ra) # 78a8 <printf>
    close(fd);
    614e:	fe042783          	lw	a5,-32(s0)
    6152:	853e                	mv	a0,a5
    6154:	00001097          	auipc	ra,0x1
    6158:	244080e7          	jalr	580(ra) # 7398 <close>
    if(total == 0)
    615c:	fe442783          	lw	a5,-28(s0)
    6160:	2781                	sext.w	a5,a5
    6162:	c799                	beqz	a5,6170 <fsfull+0x19a>
  for(nfiles = 0; ; nfiles++){
    6164:	fec42783          	lw	a5,-20(s0)
    6168:	2785                	addiw	a5,a5,1
    616a:	fef42623          	sw	a5,-20(s0)
    616e:	b561                	j	5ff6 <fsfull+0x20>
      break;
    6170:	0001                	nop
  }

  while(nfiles >= 0){
    6172:	a86d                	j	622c <fsfull+0x256>
    char name[64];
    name[0] = 'f';
    6174:	06600793          	li	a5,102
    6178:	f8f40c23          	sb	a5,-104(s0)
    name[1] = '0' + nfiles / 1000;
    617c:	fec42783          	lw	a5,-20(s0)
    6180:	873e                	mv	a4,a5
    6182:	3e800793          	li	a5,1000
    6186:	02f747bb          	divw	a5,a4,a5
    618a:	2781                	sext.w	a5,a5
    618c:	0ff7f793          	zext.b	a5,a5
    6190:	0307879b          	addiw	a5,a5,48
    6194:	0ff7f793          	zext.b	a5,a5
    6198:	f8f40ca3          	sb	a5,-103(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    619c:	fec42783          	lw	a5,-20(s0)
    61a0:	873e                	mv	a4,a5
    61a2:	3e800793          	li	a5,1000
    61a6:	02f767bb          	remw	a5,a4,a5
    61aa:	2781                	sext.w	a5,a5
    61ac:	873e                	mv	a4,a5
    61ae:	06400793          	li	a5,100
    61b2:	02f747bb          	divw	a5,a4,a5
    61b6:	2781                	sext.w	a5,a5
    61b8:	0ff7f793          	zext.b	a5,a5
    61bc:	0307879b          	addiw	a5,a5,48
    61c0:	0ff7f793          	zext.b	a5,a5
    61c4:	f8f40d23          	sb	a5,-102(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    61c8:	fec42783          	lw	a5,-20(s0)
    61cc:	873e                	mv	a4,a5
    61ce:	06400793          	li	a5,100
    61d2:	02f767bb          	remw	a5,a4,a5
    61d6:	2781                	sext.w	a5,a5
    61d8:	873e                	mv	a4,a5
    61da:	47a9                	li	a5,10
    61dc:	02f747bb          	divw	a5,a4,a5
    61e0:	2781                	sext.w	a5,a5
    61e2:	0ff7f793          	zext.b	a5,a5
    61e6:	0307879b          	addiw	a5,a5,48
    61ea:	0ff7f793          	zext.b	a5,a5
    61ee:	f8f40da3          	sb	a5,-101(s0)
    name[4] = '0' + (nfiles % 10);
    61f2:	fec42783          	lw	a5,-20(s0)
    61f6:	873e                	mv	a4,a5
    61f8:	47a9                	li	a5,10
    61fa:	02f767bb          	remw	a5,a4,a5
    61fe:	2781                	sext.w	a5,a5
    6200:	0ff7f793          	zext.b	a5,a5
    6204:	0307879b          	addiw	a5,a5,48
    6208:	0ff7f793          	zext.b	a5,a5
    620c:	f8f40e23          	sb	a5,-100(s0)
    name[5] = '\0';
    6210:	f8040ea3          	sb	zero,-99(s0)
    unlink(name);
    6214:	f9840793          	addi	a5,s0,-104
    6218:	853e                	mv	a0,a5
    621a:	00001097          	auipc	ra,0x1
    621e:	1a6080e7          	jalr	422(ra) # 73c0 <unlink>
    nfiles--;
    6222:	fec42783          	lw	a5,-20(s0)
    6226:	37fd                	addiw	a5,a5,-1
    6228:	fef42623          	sw	a5,-20(s0)
  while(nfiles >= 0){
    622c:	fec42783          	lw	a5,-20(s0)
    6230:	2781                	sext.w	a5,a5
    6232:	f407d1e3          	bgez	a5,6174 <fsfull+0x19e>
  }

  printf("fsfull test finished\n");
    6236:	00004517          	auipc	a0,0x4
    623a:	a8a50513          	addi	a0,a0,-1398 # 9cc0 <cv_init+0x1f3a>
    623e:	00001097          	auipc	ra,0x1
    6242:	66a080e7          	jalr	1642(ra) # 78a8 <printf>
}
    6246:	0001                	nop
    6248:	70a6                	ld	ra,104(sp)
    624a:	7406                	ld	s0,96(sp)
    624c:	6165                	addi	sp,sp,112
    624e:	8082                	ret

0000000000006250 <argptest>:

void argptest(char *s)
{
    6250:	7179                	addi	sp,sp,-48
    6252:	f406                	sd	ra,40(sp)
    6254:	f022                	sd	s0,32(sp)
    6256:	1800                	addi	s0,sp,48
    6258:	fca43c23          	sd	a0,-40(s0)
  int fd;
  fd = open("init", O_RDONLY);
    625c:	4581                	li	a1,0
    625e:	00004517          	auipc	a0,0x4
    6262:	a7a50513          	addi	a0,a0,-1414 # 9cd8 <cv_init+0x1f52>
    6266:	00001097          	auipc	ra,0x1
    626a:	14a080e7          	jalr	330(ra) # 73b0 <open>
    626e:	87aa                	mv	a5,a0
    6270:	fef42623          	sw	a5,-20(s0)
  if (fd < 0) {
    6274:	fec42783          	lw	a5,-20(s0)
    6278:	2781                	sext.w	a5,a5
    627a:	0207d163          	bgez	a5,629c <argptest+0x4c>
    printf("%s: open failed\n", s);
    627e:	fd843583          	ld	a1,-40(s0)
    6282:	00002517          	auipc	a0,0x2
    6286:	f7650513          	addi	a0,a0,-138 # 81f8 <cv_init+0x472>
    628a:	00001097          	auipc	ra,0x1
    628e:	61e080e7          	jalr	1566(ra) # 78a8 <printf>
    exit(1);
    6292:	4505                	li	a0,1
    6294:	00001097          	auipc	ra,0x1
    6298:	0dc080e7          	jalr	220(ra) # 7370 <exit>
  }
  read(fd, sbrk(0) - 1, -1);
    629c:	4501                	li	a0,0
    629e:	00001097          	auipc	ra,0x1
    62a2:	15a080e7          	jalr	346(ra) # 73f8 <sbrk>
    62a6:	87aa                	mv	a5,a0
    62a8:	fff78713          	addi	a4,a5,-1
    62ac:	fec42783          	lw	a5,-20(s0)
    62b0:	567d                	li	a2,-1
    62b2:	85ba                	mv	a1,a4
    62b4:	853e                	mv	a0,a5
    62b6:	00001097          	auipc	ra,0x1
    62ba:	0d2080e7          	jalr	210(ra) # 7388 <read>
  close(fd);
    62be:	fec42783          	lw	a5,-20(s0)
    62c2:	853e                	mv	a0,a5
    62c4:	00001097          	auipc	ra,0x1
    62c8:	0d4080e7          	jalr	212(ra) # 7398 <close>
}
    62cc:	0001                	nop
    62ce:	70a2                	ld	ra,40(sp)
    62d0:	7402                	ld	s0,32(sp)
    62d2:	6145                	addi	sp,sp,48
    62d4:	8082                	ret

00000000000062d6 <stacktest>:

// check that there's an invalid page beneath
// the user stack, to catch stack overflow.
void
stacktest(char *s)
{
    62d6:	7139                	addi	sp,sp,-64
    62d8:	fc06                	sd	ra,56(sp)
    62da:	f822                	sd	s0,48(sp)
    62dc:	0080                	addi	s0,sp,64
    62de:	fca43423          	sd	a0,-56(s0)
  int pid;
  int xstatus;
  
  pid = fork();
    62e2:	00001097          	auipc	ra,0x1
    62e6:	086080e7          	jalr	134(ra) # 7368 <fork>
    62ea:	87aa                	mv	a5,a0
    62ec:	fef42623          	sw	a5,-20(s0)
  if(pid == 0) {
    62f0:	fec42783          	lw	a5,-20(s0)
    62f4:	2781                	sext.w	a5,a5
    62f6:	e3b9                	bnez	a5,633c <stacktest+0x66>
    char *sp = (char *) r_sp();
    62f8:	ffffa097          	auipc	ra,0xffffa
    62fc:	d08080e7          	jalr	-760(ra) # 0 <r_sp>
    6300:	87aa                	mv	a5,a0
    6302:	fef43023          	sd	a5,-32(s0)
    sp -= PGSIZE;
    6306:	fe043703          	ld	a4,-32(s0)
    630a:	77fd                	lui	a5,0xfffff
    630c:	97ba                	add	a5,a5,a4
    630e:	fef43023          	sd	a5,-32(s0)
    // the *sp should cause a trap.
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    6312:	fe043783          	ld	a5,-32(s0)
    6316:	0007c783          	lbu	a5,0(a5) # fffffffffffff000 <__BSS_END__+0xfffffffffffee188>
    631a:	2781                	sext.w	a5,a5
    631c:	863e                	mv	a2,a5
    631e:	fc843583          	ld	a1,-56(s0)
    6322:	00004517          	auipc	a0,0x4
    6326:	9be50513          	addi	a0,a0,-1602 # 9ce0 <cv_init+0x1f5a>
    632a:	00001097          	auipc	ra,0x1
    632e:	57e080e7          	jalr	1406(ra) # 78a8 <printf>
    exit(1);
    6332:	4505                	li	a0,1
    6334:	00001097          	auipc	ra,0x1
    6338:	03c080e7          	jalr	60(ra) # 7370 <exit>
  } else if(pid < 0){
    633c:	fec42783          	lw	a5,-20(s0)
    6340:	2781                	sext.w	a5,a5
    6342:	0207d163          	bgez	a5,6364 <stacktest+0x8e>
    printf("%s: fork failed\n", s);
    6346:	fc843583          	ld	a1,-56(s0)
    634a:	00002517          	auipc	a0,0x2
    634e:	e9650513          	addi	a0,a0,-362 # 81e0 <cv_init+0x45a>
    6352:	00001097          	auipc	ra,0x1
    6356:	556080e7          	jalr	1366(ra) # 78a8 <printf>
    exit(1);
    635a:	4505                	li	a0,1
    635c:	00001097          	auipc	ra,0x1
    6360:	014080e7          	jalr	20(ra) # 7370 <exit>
  }
  wait(&xstatus);
    6364:	fdc40793          	addi	a5,s0,-36
    6368:	853e                	mv	a0,a5
    636a:	00001097          	auipc	ra,0x1
    636e:	00e080e7          	jalr	14(ra) # 7378 <wait>
  if(xstatus == -1)  // kernel killed child?
    6372:	fdc42783          	lw	a5,-36(s0)
    6376:	873e                	mv	a4,a5
    6378:	57fd                	li	a5,-1
    637a:	00f71763          	bne	a4,a5,6388 <stacktest+0xb2>
    exit(0);
    637e:	4501                	li	a0,0
    6380:	00001097          	auipc	ra,0x1
    6384:	ff0080e7          	jalr	-16(ra) # 7370 <exit>
  else
    exit(xstatus);
    6388:	fdc42783          	lw	a5,-36(s0)
    638c:	853e                	mv	a0,a5
    638e:	00001097          	auipc	ra,0x1
    6392:	fe2080e7          	jalr	-30(ra) # 7370 <exit>

0000000000006396 <pgbug>:
// regression test. copyin(), copyout(), and copyinstr() used to cast
// the virtual page address to uint, which (with certain wild system
// call arguments) resulted in a kernel page faults.
void
pgbug(char *s)
{
    6396:	7179                	addi	sp,sp,-48
    6398:	f406                	sd	ra,40(sp)
    639a:	f022                	sd	s0,32(sp)
    639c:	1800                	addi	s0,sp,48
    639e:	fca43c23          	sd	a0,-40(s0)
  char *argv[1];
  argv[0] = 0;
    63a2:	fe043423          	sd	zero,-24(s0)
  exec((char*)0xeaeb0b5b00002f5e, argv);
    63a6:	fe840713          	addi	a4,s0,-24
    63aa:	00004797          	auipc	a5,0x4
    63ae:	22678793          	addi	a5,a5,550 # a5d0 <cv_init+0x284a>
    63b2:	639c                	ld	a5,0(a5)
    63b4:	85ba                	mv	a1,a4
    63b6:	853e                	mv	a0,a5
    63b8:	00001097          	auipc	ra,0x1
    63bc:	ff0080e7          	jalr	-16(ra) # 73a8 <exec>

  pipe((int*)0xeaeb0b5b00002f5e);
    63c0:	00004797          	auipc	a5,0x4
    63c4:	21078793          	addi	a5,a5,528 # a5d0 <cv_init+0x284a>
    63c8:	639c                	ld	a5,0(a5)
    63ca:	853e                	mv	a0,a5
    63cc:	00001097          	auipc	ra,0x1
    63d0:	fb4080e7          	jalr	-76(ra) # 7380 <pipe>

  exit(0);
    63d4:	4501                	li	a0,0
    63d6:	00001097          	auipc	ra,0x1
    63da:	f9a080e7          	jalr	-102(ra) # 7370 <exit>

00000000000063de <sbrkbugs>:
// regression test. does the kernel panic if a process sbrk()s its
// size to be less than a page, or zero, or reduces the break by an
// amount too small to cause a page to be freed?
void
sbrkbugs(char *s)
{
    63de:	7179                	addi	sp,sp,-48
    63e0:	f406                	sd	ra,40(sp)
    63e2:	f022                	sd	s0,32(sp)
    63e4:	1800                	addi	s0,sp,48
    63e6:	fca43c23          	sd	a0,-40(s0)
  int pid = fork();
    63ea:	00001097          	auipc	ra,0x1
    63ee:	f7e080e7          	jalr	-130(ra) # 7368 <fork>
    63f2:	87aa                	mv	a5,a0
    63f4:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    63f8:	fec42783          	lw	a5,-20(s0)
    63fc:	2781                	sext.w	a5,a5
    63fe:	0007df63          	bgez	a5,641c <sbrkbugs+0x3e>
    printf("fork failed\n");
    6402:	00002517          	auipc	a0,0x2
    6406:	bae50513          	addi	a0,a0,-1106 # 7fb0 <cv_init+0x22a>
    640a:	00001097          	auipc	ra,0x1
    640e:	49e080e7          	jalr	1182(ra) # 78a8 <printf>
    exit(1);
    6412:	4505                	li	a0,1
    6414:	00001097          	auipc	ra,0x1
    6418:	f5c080e7          	jalr	-164(ra) # 7370 <exit>
  }
  if(pid == 0){
    641c:	fec42783          	lw	a5,-20(s0)
    6420:	2781                	sext.w	a5,a5
    6422:	eb85                	bnez	a5,6452 <sbrkbugs+0x74>
    int sz = (uint64) sbrk(0);
    6424:	4501                	li	a0,0
    6426:	00001097          	auipc	ra,0x1
    642a:	fd2080e7          	jalr	-46(ra) # 73f8 <sbrk>
    642e:	87aa                	mv	a5,a0
    6430:	fef42223          	sw	a5,-28(s0)
    // free all user memory; there used to be a bug that
    // would not adjust p->sz correctly in this case,
    // causing exit() to panic.
    sbrk(-sz);
    6434:	fe442783          	lw	a5,-28(s0)
    6438:	40f007bb          	negw	a5,a5
    643c:	2781                	sext.w	a5,a5
    643e:	853e                	mv	a0,a5
    6440:	00001097          	auipc	ra,0x1
    6444:	fb8080e7          	jalr	-72(ra) # 73f8 <sbrk>
    // user page fault here.
    exit(0);
    6448:	4501                	li	a0,0
    644a:	00001097          	auipc	ra,0x1
    644e:	f26080e7          	jalr	-218(ra) # 7370 <exit>
  }
  wait(0);
    6452:	4501                	li	a0,0
    6454:	00001097          	auipc	ra,0x1
    6458:	f24080e7          	jalr	-220(ra) # 7378 <wait>

  pid = fork();
    645c:	00001097          	auipc	ra,0x1
    6460:	f0c080e7          	jalr	-244(ra) # 7368 <fork>
    6464:	87aa                	mv	a5,a0
    6466:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    646a:	fec42783          	lw	a5,-20(s0)
    646e:	2781                	sext.w	a5,a5
    6470:	0007df63          	bgez	a5,648e <sbrkbugs+0xb0>
    printf("fork failed\n");
    6474:	00002517          	auipc	a0,0x2
    6478:	b3c50513          	addi	a0,a0,-1220 # 7fb0 <cv_init+0x22a>
    647c:	00001097          	auipc	ra,0x1
    6480:	42c080e7          	jalr	1068(ra) # 78a8 <printf>
    exit(1);
    6484:	4505                	li	a0,1
    6486:	00001097          	auipc	ra,0x1
    648a:	eea080e7          	jalr	-278(ra) # 7370 <exit>
  }
  if(pid == 0){
    648e:	fec42783          	lw	a5,-20(s0)
    6492:	2781                	sext.w	a5,a5
    6494:	eb95                	bnez	a5,64c8 <sbrkbugs+0xea>
    int sz = (uint64) sbrk(0);
    6496:	4501                	li	a0,0
    6498:	00001097          	auipc	ra,0x1
    649c:	f60080e7          	jalr	-160(ra) # 73f8 <sbrk>
    64a0:	87aa                	mv	a5,a0
    64a2:	fef42423          	sw	a5,-24(s0)
    // set the break to somewhere in the very first
    // page; there used to be a bug that would incorrectly
    // free the first page.
    sbrk(-(sz - 3500));
    64a6:	6785                	lui	a5,0x1
    64a8:	dac7879b          	addiw	a5,a5,-596
    64ac:	fe842703          	lw	a4,-24(s0)
    64b0:	9f99                	subw	a5,a5,a4
    64b2:	2781                	sext.w	a5,a5
    64b4:	853e                	mv	a0,a5
    64b6:	00001097          	auipc	ra,0x1
    64ba:	f42080e7          	jalr	-190(ra) # 73f8 <sbrk>
    exit(0);
    64be:	4501                	li	a0,0
    64c0:	00001097          	auipc	ra,0x1
    64c4:	eb0080e7          	jalr	-336(ra) # 7370 <exit>
  }
  wait(0);
    64c8:	4501                	li	a0,0
    64ca:	00001097          	auipc	ra,0x1
    64ce:	eae080e7          	jalr	-338(ra) # 7378 <wait>

  pid = fork();
    64d2:	00001097          	auipc	ra,0x1
    64d6:	e96080e7          	jalr	-362(ra) # 7368 <fork>
    64da:	87aa                	mv	a5,a0
    64dc:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    64e0:	fec42783          	lw	a5,-20(s0)
    64e4:	2781                	sext.w	a5,a5
    64e6:	0007df63          	bgez	a5,6504 <sbrkbugs+0x126>
    printf("fork failed\n");
    64ea:	00002517          	auipc	a0,0x2
    64ee:	ac650513          	addi	a0,a0,-1338 # 7fb0 <cv_init+0x22a>
    64f2:	00001097          	auipc	ra,0x1
    64f6:	3b6080e7          	jalr	950(ra) # 78a8 <printf>
    exit(1);
    64fa:	4505                	li	a0,1
    64fc:	00001097          	auipc	ra,0x1
    6500:	e74080e7          	jalr	-396(ra) # 7370 <exit>
  }
  if(pid == 0){
    6504:	fec42783          	lw	a5,-20(s0)
    6508:	2781                	sext.w	a5,a5
    650a:	ef95                	bnez	a5,6546 <sbrkbugs+0x168>
    // set the break in the middle of a page.
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    650c:	4501                	li	a0,0
    650e:	00001097          	auipc	ra,0x1
    6512:	eea080e7          	jalr	-278(ra) # 73f8 <sbrk>
    6516:	87aa                	mv	a5,a0
    6518:	2781                	sext.w	a5,a5
    651a:	672d                	lui	a4,0xb
    651c:	8007071b          	addiw	a4,a4,-2048
    6520:	40f707bb          	subw	a5,a4,a5
    6524:	2781                	sext.w	a5,a5
    6526:	2781                	sext.w	a5,a5
    6528:	853e                	mv	a0,a5
    652a:	00001097          	auipc	ra,0x1
    652e:	ece080e7          	jalr	-306(ra) # 73f8 <sbrk>

    // reduce the break a bit, but not enough to
    // cause a page to be freed. this used to cause
    // a panic.
    sbrk(-10);
    6532:	5559                	li	a0,-10
    6534:	00001097          	auipc	ra,0x1
    6538:	ec4080e7          	jalr	-316(ra) # 73f8 <sbrk>

    exit(0);
    653c:	4501                	li	a0,0
    653e:	00001097          	auipc	ra,0x1
    6542:	e32080e7          	jalr	-462(ra) # 7370 <exit>
  }
  wait(0);
    6546:	4501                	li	a0,0
    6548:	00001097          	auipc	ra,0x1
    654c:	e30080e7          	jalr	-464(ra) # 7378 <wait>

  exit(0);
    6550:	4501                	li	a0,0
    6552:	00001097          	auipc	ra,0x1
    6556:	e1e080e7          	jalr	-482(ra) # 7370 <exit>

000000000000655a <sbrklast>:
// if process size was somewhat more than a page boundary, and then
// shrunk to be somewhat less than that page boundary, can the kernel
// still copyin() from addresses in the last page?
void
sbrklast(char *s)
{
    655a:	7139                	addi	sp,sp,-64
    655c:	fc06                	sd	ra,56(sp)
    655e:	f822                	sd	s0,48(sp)
    6560:	0080                	addi	s0,sp,64
    6562:	fca43423          	sd	a0,-56(s0)
  uint64 top = (uint64) sbrk(0);
    6566:	4501                	li	a0,0
    6568:	00001097          	auipc	ra,0x1
    656c:	e90080e7          	jalr	-368(ra) # 73f8 <sbrk>
    6570:	87aa                	mv	a5,a0
    6572:	fef43423          	sd	a5,-24(s0)
  if((top % 4096) != 0)
    6576:	fe843703          	ld	a4,-24(s0)
    657a:	6785                	lui	a5,0x1
    657c:	17fd                	addi	a5,a5,-1
    657e:	8ff9                	and	a5,a5,a4
    6580:	c39d                	beqz	a5,65a6 <sbrklast+0x4c>
    sbrk(4096 - (top % 4096));
    6582:	fe843783          	ld	a5,-24(s0)
    6586:	2781                	sext.w	a5,a5
    6588:	873e                	mv	a4,a5
    658a:	6785                	lui	a5,0x1
    658c:	17fd                	addi	a5,a5,-1
    658e:	8ff9                	and	a5,a5,a4
    6590:	2781                	sext.w	a5,a5
    6592:	6705                	lui	a4,0x1
    6594:	40f707bb          	subw	a5,a4,a5
    6598:	2781                	sext.w	a5,a5
    659a:	2781                	sext.w	a5,a5
    659c:	853e                	mv	a0,a5
    659e:	00001097          	auipc	ra,0x1
    65a2:	e5a080e7          	jalr	-422(ra) # 73f8 <sbrk>
  sbrk(4096);
    65a6:	6505                	lui	a0,0x1
    65a8:	00001097          	auipc	ra,0x1
    65ac:	e50080e7          	jalr	-432(ra) # 73f8 <sbrk>
  sbrk(10);
    65b0:	4529                	li	a0,10
    65b2:	00001097          	auipc	ra,0x1
    65b6:	e46080e7          	jalr	-442(ra) # 73f8 <sbrk>
  sbrk(-20);
    65ba:	5531                	li	a0,-20
    65bc:	00001097          	auipc	ra,0x1
    65c0:	e3c080e7          	jalr	-452(ra) # 73f8 <sbrk>
  top = (uint64) sbrk(0);
    65c4:	4501                	li	a0,0
    65c6:	00001097          	auipc	ra,0x1
    65ca:	e32080e7          	jalr	-462(ra) # 73f8 <sbrk>
    65ce:	87aa                	mv	a5,a0
    65d0:	fef43423          	sd	a5,-24(s0)
  char *p = (char *) (top - 64);
    65d4:	fe843783          	ld	a5,-24(s0)
    65d8:	fc078793          	addi	a5,a5,-64 # fc0 <truncate3+0x172>
    65dc:	fef43023          	sd	a5,-32(s0)
  p[0] = 'x';
    65e0:	fe043783          	ld	a5,-32(s0)
    65e4:	07800713          	li	a4,120
    65e8:	00e78023          	sb	a4,0(a5)
  p[1] = '\0';
    65ec:	fe043783          	ld	a5,-32(s0)
    65f0:	0785                	addi	a5,a5,1
    65f2:	00078023          	sb	zero,0(a5)
  int fd = open(p, O_RDWR|O_CREATE);
    65f6:	20200593          	li	a1,514
    65fa:	fe043503          	ld	a0,-32(s0)
    65fe:	00001097          	auipc	ra,0x1
    6602:	db2080e7          	jalr	-590(ra) # 73b0 <open>
    6606:	87aa                	mv	a5,a0
    6608:	fcf42e23          	sw	a5,-36(s0)
  write(fd, p, 1);
    660c:	fdc42783          	lw	a5,-36(s0)
    6610:	4605                	li	a2,1
    6612:	fe043583          	ld	a1,-32(s0)
    6616:	853e                	mv	a0,a5
    6618:	00001097          	auipc	ra,0x1
    661c:	d78080e7          	jalr	-648(ra) # 7390 <write>
  close(fd);
    6620:	fdc42783          	lw	a5,-36(s0)
    6624:	853e                	mv	a0,a5
    6626:	00001097          	auipc	ra,0x1
    662a:	d72080e7          	jalr	-654(ra) # 7398 <close>
  fd = open(p, O_RDWR);
    662e:	4589                	li	a1,2
    6630:	fe043503          	ld	a0,-32(s0)
    6634:	00001097          	auipc	ra,0x1
    6638:	d7c080e7          	jalr	-644(ra) # 73b0 <open>
    663c:	87aa                	mv	a5,a0
    663e:	fcf42e23          	sw	a5,-36(s0)
  p[0] = '\0';
    6642:	fe043783          	ld	a5,-32(s0)
    6646:	00078023          	sb	zero,0(a5)
  read(fd, p, 1);
    664a:	fdc42783          	lw	a5,-36(s0)
    664e:	4605                	li	a2,1
    6650:	fe043583          	ld	a1,-32(s0)
    6654:	853e                	mv	a0,a5
    6656:	00001097          	auipc	ra,0x1
    665a:	d32080e7          	jalr	-718(ra) # 7388 <read>
  if(p[0] != 'x')
    665e:	fe043783          	ld	a5,-32(s0)
    6662:	0007c783          	lbu	a5,0(a5)
    6666:	873e                	mv	a4,a5
    6668:	07800793          	li	a5,120
    666c:	00f70763          	beq	a4,a5,667a <sbrklast+0x120>
    exit(1);
    6670:	4505                	li	a0,1
    6672:	00001097          	auipc	ra,0x1
    6676:	cfe080e7          	jalr	-770(ra) # 7370 <exit>
}
    667a:	0001                	nop
    667c:	70e2                	ld	ra,56(sp)
    667e:	7442                	ld	s0,48(sp)
    6680:	6121                	addi	sp,sp,64
    6682:	8082                	ret

0000000000006684 <sbrk8000>:

// does sbrk handle signed int32 wrap-around with
// negative arguments?
void
sbrk8000(char *s)
{
    6684:	7179                	addi	sp,sp,-48
    6686:	f406                	sd	ra,40(sp)
    6688:	f022                	sd	s0,32(sp)
    668a:	1800                	addi	s0,sp,48
    668c:	fca43c23          	sd	a0,-40(s0)
  sbrk(0x80000004);
    6690:	800007b7          	lui	a5,0x80000
    6694:	00478513          	addi	a0,a5,4 # ffffffff80000004 <__BSS_END__+0xffffffff7ffef18c>
    6698:	00001097          	auipc	ra,0x1
    669c:	d60080e7          	jalr	-672(ra) # 73f8 <sbrk>
  volatile char *top = sbrk(0);
    66a0:	4501                	li	a0,0
    66a2:	00001097          	auipc	ra,0x1
    66a6:	d56080e7          	jalr	-682(ra) # 73f8 <sbrk>
    66aa:	fea43423          	sd	a0,-24(s0)
  *(top-1) = *(top-1) + 1;
    66ae:	fe843783          	ld	a5,-24(s0)
    66b2:	17fd                	addi	a5,a5,-1
    66b4:	0007c783          	lbu	a5,0(a5)
    66b8:	0ff7f713          	zext.b	a4,a5
    66bc:	fe843783          	ld	a5,-24(s0)
    66c0:	17fd                	addi	a5,a5,-1
    66c2:	2705                	addiw	a4,a4,1
    66c4:	0ff77713          	zext.b	a4,a4
    66c8:	00e78023          	sb	a4,0(a5)
}
    66cc:	0001                	nop
    66ce:	70a2                	ld	ra,40(sp)
    66d0:	7402                	ld	s0,32(sp)
    66d2:	6145                	addi	sp,sp,48
    66d4:	8082                	ret

00000000000066d6 <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
    66d6:	7179                	addi	sp,sp,-48
    66d8:	f406                	sd	ra,40(sp)
    66da:	f022                	sd	s0,32(sp)
    66dc:	1800                	addi	s0,sp,48
    66de:	fca43c23          	sd	a0,-40(s0)
  int assumed_free = 600;
    66e2:	25800793          	li	a5,600
    66e6:	fef42423          	sw	a5,-24(s0)
  
  unlink("junk");
    66ea:	00003517          	auipc	a0,0x3
    66ee:	61e50513          	addi	a0,a0,1566 # 9d08 <cv_init+0x1f82>
    66f2:	00001097          	auipc	ra,0x1
    66f6:	cce080e7          	jalr	-818(ra) # 73c0 <unlink>
  for(int i = 0; i < assumed_free; i++){
    66fa:	fe042623          	sw	zero,-20(s0)
    66fe:	a8bd                	j	677c <badwrite+0xa6>
    int fd = open("junk", O_CREATE|O_WRONLY);
    6700:	20100593          	li	a1,513
    6704:	00003517          	auipc	a0,0x3
    6708:	60450513          	addi	a0,a0,1540 # 9d08 <cv_init+0x1f82>
    670c:	00001097          	auipc	ra,0x1
    6710:	ca4080e7          	jalr	-860(ra) # 73b0 <open>
    6714:	87aa                	mv	a5,a0
    6716:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    671a:	fe042783          	lw	a5,-32(s0)
    671e:	2781                	sext.w	a5,a5
    6720:	0007df63          	bgez	a5,673e <badwrite+0x68>
      printf("open junk failed\n");
    6724:	00003517          	auipc	a0,0x3
    6728:	5ec50513          	addi	a0,a0,1516 # 9d10 <cv_init+0x1f8a>
    672c:	00001097          	auipc	ra,0x1
    6730:	17c080e7          	jalr	380(ra) # 78a8 <printf>
      exit(1);
    6734:	4505                	li	a0,1
    6736:	00001097          	auipc	ra,0x1
    673a:	c3a080e7          	jalr	-966(ra) # 7370 <exit>
    }
    write(fd, (char*)0xffffffffffL, 1);
    673e:	fe042703          	lw	a4,-32(s0)
    6742:	4605                	li	a2,1
    6744:	57fd                	li	a5,-1
    6746:	0187d593          	srli	a1,a5,0x18
    674a:	853a                	mv	a0,a4
    674c:	00001097          	auipc	ra,0x1
    6750:	c44080e7          	jalr	-956(ra) # 7390 <write>
    close(fd);
    6754:	fe042783          	lw	a5,-32(s0)
    6758:	853e                	mv	a0,a5
    675a:	00001097          	auipc	ra,0x1
    675e:	c3e080e7          	jalr	-962(ra) # 7398 <close>
    unlink("junk");
    6762:	00003517          	auipc	a0,0x3
    6766:	5a650513          	addi	a0,a0,1446 # 9d08 <cv_init+0x1f82>
    676a:	00001097          	auipc	ra,0x1
    676e:	c56080e7          	jalr	-938(ra) # 73c0 <unlink>
  for(int i = 0; i < assumed_free; i++){
    6772:	fec42783          	lw	a5,-20(s0)
    6776:	2785                	addiw	a5,a5,1
    6778:	fef42623          	sw	a5,-20(s0)
    677c:	fec42783          	lw	a5,-20(s0)
    6780:	873e                	mv	a4,a5
    6782:	fe842783          	lw	a5,-24(s0)
    6786:	2701                	sext.w	a4,a4
    6788:	2781                	sext.w	a5,a5
    678a:	f6f74be3          	blt	a4,a5,6700 <badwrite+0x2a>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
    678e:	20100593          	li	a1,513
    6792:	00003517          	auipc	a0,0x3
    6796:	57650513          	addi	a0,a0,1398 # 9d08 <cv_init+0x1f82>
    679a:	00001097          	auipc	ra,0x1
    679e:	c16080e7          	jalr	-1002(ra) # 73b0 <open>
    67a2:	87aa                	mv	a5,a0
    67a4:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    67a8:	fe442783          	lw	a5,-28(s0)
    67ac:	2781                	sext.w	a5,a5
    67ae:	0007df63          	bgez	a5,67cc <badwrite+0xf6>
    printf("open junk failed\n");
    67b2:	00003517          	auipc	a0,0x3
    67b6:	55e50513          	addi	a0,a0,1374 # 9d10 <cv_init+0x1f8a>
    67ba:	00001097          	auipc	ra,0x1
    67be:	0ee080e7          	jalr	238(ra) # 78a8 <printf>
    exit(1);
    67c2:	4505                	li	a0,1
    67c4:	00001097          	auipc	ra,0x1
    67c8:	bac080e7          	jalr	-1108(ra) # 7370 <exit>
  }
  if(write(fd, "x", 1) != 1){
    67cc:	fe442783          	lw	a5,-28(s0)
    67d0:	4605                	li	a2,1
    67d2:	00001597          	auipc	a1,0x1
    67d6:	6de58593          	addi	a1,a1,1758 # 7eb0 <cv_init+0x12a>
    67da:	853e                	mv	a0,a5
    67dc:	00001097          	auipc	ra,0x1
    67e0:	bb4080e7          	jalr	-1100(ra) # 7390 <write>
    67e4:	87aa                	mv	a5,a0
    67e6:	873e                	mv	a4,a5
    67e8:	4785                	li	a5,1
    67ea:	00f70f63          	beq	a4,a5,6808 <badwrite+0x132>
    printf("write failed\n");
    67ee:	00003517          	auipc	a0,0x3
    67f2:	53a50513          	addi	a0,a0,1338 # 9d28 <cv_init+0x1fa2>
    67f6:	00001097          	auipc	ra,0x1
    67fa:	0b2080e7          	jalr	178(ra) # 78a8 <printf>
    exit(1);
    67fe:	4505                	li	a0,1
    6800:	00001097          	auipc	ra,0x1
    6804:	b70080e7          	jalr	-1168(ra) # 7370 <exit>
  }
  close(fd);
    6808:	fe442783          	lw	a5,-28(s0)
    680c:	853e                	mv	a0,a5
    680e:	00001097          	auipc	ra,0x1
    6812:	b8a080e7          	jalr	-1142(ra) # 7398 <close>
  unlink("junk");
    6816:	00003517          	auipc	a0,0x3
    681a:	4f250513          	addi	a0,a0,1266 # 9d08 <cv_init+0x1f82>
    681e:	00001097          	auipc	ra,0x1
    6822:	ba2080e7          	jalr	-1118(ra) # 73c0 <unlink>

  exit(0);
    6826:	4501                	li	a0,0
    6828:	00001097          	auipc	ra,0x1
    682c:	b48080e7          	jalr	-1208(ra) # 7370 <exit>

0000000000006830 <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    6830:	7139                	addi	sp,sp,-64
    6832:	fc06                	sd	ra,56(sp)
    6834:	f822                	sd	s0,48(sp)
    6836:	0080                	addi	s0,sp,64
    6838:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 50000; i++){
    683c:	fe042623          	sw	zero,-20(s0)
    6840:	a03d                	j	686e <badarg+0x3e>
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    6842:	57fd                	li	a5,-1
    6844:	9381                	srli	a5,a5,0x20
    6846:	fcf43c23          	sd	a5,-40(s0)
    argv[1] = 0;
    684a:	fe043023          	sd	zero,-32(s0)
    exec("echo", argv);
    684e:	fd840793          	addi	a5,s0,-40
    6852:	85be                	mv	a1,a5
    6854:	00001517          	auipc	a0,0x1
    6858:	76c50513          	addi	a0,a0,1900 # 7fc0 <cv_init+0x23a>
    685c:	00001097          	auipc	ra,0x1
    6860:	b4c080e7          	jalr	-1204(ra) # 73a8 <exec>
  for(int i = 0; i < 50000; i++){
    6864:	fec42783          	lw	a5,-20(s0)
    6868:	2785                	addiw	a5,a5,1
    686a:	fef42623          	sw	a5,-20(s0)
    686e:	fec42783          	lw	a5,-20(s0)
    6872:	0007871b          	sext.w	a4,a5
    6876:	67b1                	lui	a5,0xc
    6878:	34f78793          	addi	a5,a5,847 # c34f <__global_pointer$+0x150e>
    687c:	fce7d3e3          	bge	a5,a4,6842 <badarg+0x12>
  }
  
  exit(0);
    6880:	4501                	li	a0,0
    6882:	00001097          	auipc	ra,0x1
    6886:	aee080e7          	jalr	-1298(ra) # 7370 <exit>

000000000000688a <execout>:
// test the exec() code that cleans up if it runs out
// of memory. it's really a test that such a condition
// doesn't cause a panic.
void
execout(char *s)
{
    688a:	715d                	addi	sp,sp,-80
    688c:	e486                	sd	ra,72(sp)
    688e:	e0a2                	sd	s0,64(sp)
    6890:	0880                	addi	s0,sp,80
    6892:	faa43c23          	sd	a0,-72(s0)
  for(int avail = 0; avail < 15; avail++){
    6896:	fe042623          	sw	zero,-20(s0)
    689a:	a8cd                	j	698c <execout+0x102>
    int pid = fork();
    689c:	00001097          	auipc	ra,0x1
    68a0:	acc080e7          	jalr	-1332(ra) # 7368 <fork>
    68a4:	87aa                	mv	a5,a0
    68a6:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    68aa:	fe442783          	lw	a5,-28(s0)
    68ae:	2781                	sext.w	a5,a5
    68b0:	0007df63          	bgez	a5,68ce <execout+0x44>
      printf("fork failed\n");
    68b4:	00001517          	auipc	a0,0x1
    68b8:	6fc50513          	addi	a0,a0,1788 # 7fb0 <cv_init+0x22a>
    68bc:	00001097          	auipc	ra,0x1
    68c0:	fec080e7          	jalr	-20(ra) # 78a8 <printf>
      exit(1);
    68c4:	4505                	li	a0,1
    68c6:	00001097          	auipc	ra,0x1
    68ca:	aaa080e7          	jalr	-1366(ra) # 7370 <exit>
    } else if(pid == 0){
    68ce:	fe442783          	lw	a5,-28(s0)
    68d2:	2781                	sext.w	a5,a5
    68d4:	e3d5                	bnez	a5,6978 <execout+0xee>
      // allocate all of memory.
      while(1){
        uint64 a = (uint64) sbrk(4096);
    68d6:	6505                	lui	a0,0x1
    68d8:	00001097          	auipc	ra,0x1
    68dc:	b20080e7          	jalr	-1248(ra) # 73f8 <sbrk>
    68e0:	87aa                	mv	a5,a0
    68e2:	fcf43c23          	sd	a5,-40(s0)
        if(a == 0xffffffffffffffffLL)
    68e6:	fd843703          	ld	a4,-40(s0)
    68ea:	57fd                	li	a5,-1
    68ec:	00f70c63          	beq	a4,a5,6904 <execout+0x7a>
          break;
        *(char*)(a + 4096 - 1) = 1;
    68f0:	fd843703          	ld	a4,-40(s0)
    68f4:	6785                	lui	a5,0x1
    68f6:	17fd                	addi	a5,a5,-1
    68f8:	97ba                	add	a5,a5,a4
    68fa:	873e                	mv	a4,a5
    68fc:	4785                	li	a5,1
    68fe:	00f70023          	sb	a5,0(a4) # 1000 <truncate3+0x1b2>
      while(1){
    6902:	bfd1                	j	68d6 <execout+0x4c>
          break;
    6904:	0001                	nop
      }

      // free a few pages, in order to let exec() make some
      // progress.
      for(int i = 0; i < avail; i++)
    6906:	fe042423          	sw	zero,-24(s0)
    690a:	a819                	j	6920 <execout+0x96>
        sbrk(-4096);
    690c:	757d                	lui	a0,0xfffff
    690e:	00001097          	auipc	ra,0x1
    6912:	aea080e7          	jalr	-1302(ra) # 73f8 <sbrk>
      for(int i = 0; i < avail; i++)
    6916:	fe842783          	lw	a5,-24(s0)
    691a:	2785                	addiw	a5,a5,1
    691c:	fef42423          	sw	a5,-24(s0)
    6920:	fe842783          	lw	a5,-24(s0)
    6924:	873e                	mv	a4,a5
    6926:	fec42783          	lw	a5,-20(s0)
    692a:	2701                	sext.w	a4,a4
    692c:	2781                	sext.w	a5,a5
    692e:	fcf74fe3          	blt	a4,a5,690c <execout+0x82>
      
      close(1);
    6932:	4505                	li	a0,1
    6934:	00001097          	auipc	ra,0x1
    6938:	a64080e7          	jalr	-1436(ra) # 7398 <close>
      char *args[] = { "echo", "x", 0 };
    693c:	00001797          	auipc	a5,0x1
    6940:	68478793          	addi	a5,a5,1668 # 7fc0 <cv_init+0x23a>
    6944:	fcf43023          	sd	a5,-64(s0)
    6948:	00001797          	auipc	a5,0x1
    694c:	56878793          	addi	a5,a5,1384 # 7eb0 <cv_init+0x12a>
    6950:	fcf43423          	sd	a5,-56(s0)
    6954:	fc043823          	sd	zero,-48(s0)
      exec("echo", args);
    6958:	fc040793          	addi	a5,s0,-64
    695c:	85be                	mv	a1,a5
    695e:	00001517          	auipc	a0,0x1
    6962:	66250513          	addi	a0,a0,1634 # 7fc0 <cv_init+0x23a>
    6966:	00001097          	auipc	ra,0x1
    696a:	a42080e7          	jalr	-1470(ra) # 73a8 <exec>
      exit(0);
    696e:	4501                	li	a0,0
    6970:	00001097          	auipc	ra,0x1
    6974:	a00080e7          	jalr	-1536(ra) # 7370 <exit>
    } else {
      wait((int*)0);
    6978:	4501                	li	a0,0
    697a:	00001097          	auipc	ra,0x1
    697e:	9fe080e7          	jalr	-1538(ra) # 7378 <wait>
  for(int avail = 0; avail < 15; avail++){
    6982:	fec42783          	lw	a5,-20(s0)
    6986:	2785                	addiw	a5,a5,1
    6988:	fef42623          	sw	a5,-20(s0)
    698c:	fec42783          	lw	a5,-20(s0)
    6990:	0007871b          	sext.w	a4,a5
    6994:	47b9                	li	a5,14
    6996:	f0e7d3e3          	bge	a5,a4,689c <execout+0x12>
    }
  }

  exit(0);
    699a:	4501                	li	a0,0
    699c:	00001097          	auipc	ra,0x1
    69a0:	9d4080e7          	jalr	-1580(ra) # 7370 <exit>

00000000000069a4 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    69a4:	7139                	addi	sp,sp,-64
    69a6:	fc06                	sd	ra,56(sp)
    69a8:	f822                	sd	s0,48(sp)
    69aa:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    69ac:	fd040793          	addi	a5,s0,-48
    69b0:	853e                	mv	a0,a5
    69b2:	00001097          	auipc	ra,0x1
    69b6:	9ce080e7          	jalr	-1586(ra) # 7380 <pipe>
    69ba:	87aa                	mv	a5,a0
    69bc:	0007df63          	bgez	a5,69da <countfree+0x36>
    printf("pipe() failed in countfree()\n");
    69c0:	00003517          	auipc	a0,0x3
    69c4:	37850513          	addi	a0,a0,888 # 9d38 <cv_init+0x1fb2>
    69c8:	00001097          	auipc	ra,0x1
    69cc:	ee0080e7          	jalr	-288(ra) # 78a8 <printf>
    exit(1);
    69d0:	4505                	li	a0,1
    69d2:	00001097          	auipc	ra,0x1
    69d6:	99e080e7          	jalr	-1634(ra) # 7370 <exit>
  }
  
  int pid = fork();
    69da:	00001097          	auipc	ra,0x1
    69de:	98e080e7          	jalr	-1650(ra) # 7368 <fork>
    69e2:	87aa                	mv	a5,a0
    69e4:	fef42423          	sw	a5,-24(s0)

  if(pid < 0){
    69e8:	fe842783          	lw	a5,-24(s0)
    69ec:	2781                	sext.w	a5,a5
    69ee:	0007df63          	bgez	a5,6a0c <countfree+0x68>
    printf("fork failed in countfree()\n");
    69f2:	00003517          	auipc	a0,0x3
    69f6:	36650513          	addi	a0,a0,870 # 9d58 <cv_init+0x1fd2>
    69fa:	00001097          	auipc	ra,0x1
    69fe:	eae080e7          	jalr	-338(ra) # 78a8 <printf>
    exit(1);
    6a02:	4505                	li	a0,1
    6a04:	00001097          	auipc	ra,0x1
    6a08:	96c080e7          	jalr	-1684(ra) # 7370 <exit>
  }

  if(pid == 0){
    6a0c:	fe842783          	lw	a5,-24(s0)
    6a10:	2781                	sext.w	a5,a5
    6a12:	e3d1                	bnez	a5,6a96 <countfree+0xf2>
    close(fds[0]);
    6a14:	fd042783          	lw	a5,-48(s0)
    6a18:	853e                	mv	a0,a5
    6a1a:	00001097          	auipc	ra,0x1
    6a1e:	97e080e7          	jalr	-1666(ra) # 7398 <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
    6a22:	6505                	lui	a0,0x1
    6a24:	00001097          	auipc	ra,0x1
    6a28:	9d4080e7          	jalr	-1580(ra) # 73f8 <sbrk>
    6a2c:	87aa                	mv	a5,a0
    6a2e:	fcf43c23          	sd	a5,-40(s0)
      if(a == 0xffffffffffffffff){
    6a32:	fd843703          	ld	a4,-40(s0)
    6a36:	57fd                	li	a5,-1
    6a38:	04f70963          	beq	a4,a5,6a8a <countfree+0xe6>
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    6a3c:	fd843703          	ld	a4,-40(s0)
    6a40:	6785                	lui	a5,0x1
    6a42:	17fd                	addi	a5,a5,-1
    6a44:	97ba                	add	a5,a5,a4
    6a46:	873e                	mv	a4,a5
    6a48:	4785                	li	a5,1
    6a4a:	00f70023          	sb	a5,0(a4)

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    6a4e:	fd442783          	lw	a5,-44(s0)
    6a52:	4605                	li	a2,1
    6a54:	00001597          	auipc	a1,0x1
    6a58:	45c58593          	addi	a1,a1,1116 # 7eb0 <cv_init+0x12a>
    6a5c:	853e                	mv	a0,a5
    6a5e:	00001097          	auipc	ra,0x1
    6a62:	932080e7          	jalr	-1742(ra) # 7390 <write>
    6a66:	87aa                	mv	a5,a0
    6a68:	873e                	mv	a4,a5
    6a6a:	4785                	li	a5,1
    6a6c:	faf70be3          	beq	a4,a5,6a22 <countfree+0x7e>
        printf("write() failed in countfree()\n");
    6a70:	00003517          	auipc	a0,0x3
    6a74:	30850513          	addi	a0,a0,776 # 9d78 <cv_init+0x1ff2>
    6a78:	00001097          	auipc	ra,0x1
    6a7c:	e30080e7          	jalr	-464(ra) # 78a8 <printf>
        exit(1);
    6a80:	4505                	li	a0,1
    6a82:	00001097          	auipc	ra,0x1
    6a86:	8ee080e7          	jalr	-1810(ra) # 7370 <exit>
        break;
    6a8a:	0001                	nop
      }
    }

    exit(0);
    6a8c:	4501                	li	a0,0
    6a8e:	00001097          	auipc	ra,0x1
    6a92:	8e2080e7          	jalr	-1822(ra) # 7370 <exit>
  }

  close(fds[1]);
    6a96:	fd442783          	lw	a5,-44(s0)
    6a9a:	853e                	mv	a0,a5
    6a9c:	00001097          	auipc	ra,0x1
    6aa0:	8fc080e7          	jalr	-1796(ra) # 7398 <close>

  int n = 0;
    6aa4:	fe042623          	sw	zero,-20(s0)
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    6aa8:	fd042783          	lw	a5,-48(s0)
    6aac:	fcf40713          	addi	a4,s0,-49
    6ab0:	4605                	li	a2,1
    6ab2:	85ba                	mv	a1,a4
    6ab4:	853e                	mv	a0,a5
    6ab6:	00001097          	auipc	ra,0x1
    6aba:	8d2080e7          	jalr	-1838(ra) # 7388 <read>
    6abe:	87aa                	mv	a5,a0
    6ac0:	fef42223          	sw	a5,-28(s0)
    if(cc < 0){
    6ac4:	fe442783          	lw	a5,-28(s0)
    6ac8:	2781                	sext.w	a5,a5
    6aca:	0007df63          	bgez	a5,6ae8 <countfree+0x144>
      printf("read() failed in countfree()\n");
    6ace:	00003517          	auipc	a0,0x3
    6ad2:	2ca50513          	addi	a0,a0,714 # 9d98 <cv_init+0x2012>
    6ad6:	00001097          	auipc	ra,0x1
    6ada:	dd2080e7          	jalr	-558(ra) # 78a8 <printf>
      exit(1);
    6ade:	4505                	li	a0,1
    6ae0:	00001097          	auipc	ra,0x1
    6ae4:	890080e7          	jalr	-1904(ra) # 7370 <exit>
    }
    if(cc == 0)
    6ae8:	fe442783          	lw	a5,-28(s0)
    6aec:	2781                	sext.w	a5,a5
    6aee:	e385                	bnez	a5,6b0e <countfree+0x16a>
      break;
    n += 1;
  }

  close(fds[0]);
    6af0:	fd042783          	lw	a5,-48(s0)
    6af4:	853e                	mv	a0,a5
    6af6:	00001097          	auipc	ra,0x1
    6afa:	8a2080e7          	jalr	-1886(ra) # 7398 <close>
  wait((int*)0);
    6afe:	4501                	li	a0,0
    6b00:	00001097          	auipc	ra,0x1
    6b04:	878080e7          	jalr	-1928(ra) # 7378 <wait>
  
  return n;
    6b08:	fec42783          	lw	a5,-20(s0)
    6b0c:	a039                	j	6b1a <countfree+0x176>
    n += 1;
    6b0e:	fec42783          	lw	a5,-20(s0)
    6b12:	2785                	addiw	a5,a5,1
    6b14:	fef42623          	sw	a5,-20(s0)
  while(1){
    6b18:	bf41                	j	6aa8 <countfree+0x104>
}
    6b1a:	853e                	mv	a0,a5
    6b1c:	70e2                	ld	ra,56(sp)
    6b1e:	7442                	ld	s0,48(sp)
    6b20:	6121                	addi	sp,sp,64
    6b22:	8082                	ret

0000000000006b24 <run>:

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    6b24:	7179                	addi	sp,sp,-48
    6b26:	f406                	sd	ra,40(sp)
    6b28:	f022                	sd	s0,32(sp)
    6b2a:	1800                	addi	s0,sp,48
    6b2c:	fca43c23          	sd	a0,-40(s0)
    6b30:	fcb43823          	sd	a1,-48(s0)
  int pid;
  int xstatus;

  printf("test %s: ", s);
    6b34:	fd043583          	ld	a1,-48(s0)
    6b38:	00003517          	auipc	a0,0x3
    6b3c:	28050513          	addi	a0,a0,640 # 9db8 <cv_init+0x2032>
    6b40:	00001097          	auipc	ra,0x1
    6b44:	d68080e7          	jalr	-664(ra) # 78a8 <printf>
  if((pid = fork()) < 0) {
    6b48:	00001097          	auipc	ra,0x1
    6b4c:	820080e7          	jalr	-2016(ra) # 7368 <fork>
    6b50:	87aa                	mv	a5,a0
    6b52:	fef42623          	sw	a5,-20(s0)
    6b56:	fec42783          	lw	a5,-20(s0)
    6b5a:	2781                	sext.w	a5,a5
    6b5c:	0007df63          	bgez	a5,6b7a <run+0x56>
    printf("runtest: fork error\n");
    6b60:	00003517          	auipc	a0,0x3
    6b64:	26850513          	addi	a0,a0,616 # 9dc8 <cv_init+0x2042>
    6b68:	00001097          	auipc	ra,0x1
    6b6c:	d40080e7          	jalr	-704(ra) # 78a8 <printf>
    exit(1);
    6b70:	4505                	li	a0,1
    6b72:	00000097          	auipc	ra,0x0
    6b76:	7fe080e7          	jalr	2046(ra) # 7370 <exit>
  }
  if(pid == 0) {
    6b7a:	fec42783          	lw	a5,-20(s0)
    6b7e:	2781                	sext.w	a5,a5
    6b80:	eb99                	bnez	a5,6b96 <run+0x72>
    f(s);
    6b82:	fd843783          	ld	a5,-40(s0)
    6b86:	fd043503          	ld	a0,-48(s0)
    6b8a:	9782                	jalr	a5
    exit(0);
    6b8c:	4501                	li	a0,0
    6b8e:	00000097          	auipc	ra,0x0
    6b92:	7e2080e7          	jalr	2018(ra) # 7370 <exit>
  } else {
    wait(&xstatus);
    6b96:	fe840793          	addi	a5,s0,-24
    6b9a:	853e                	mv	a0,a5
    6b9c:	00000097          	auipc	ra,0x0
    6ba0:	7dc080e7          	jalr	2012(ra) # 7378 <wait>
    if(xstatus != 0) 
    6ba4:	fe842783          	lw	a5,-24(s0)
    6ba8:	cb91                	beqz	a5,6bbc <run+0x98>
      printf("FAILED\n");
    6baa:	00003517          	auipc	a0,0x3
    6bae:	23650513          	addi	a0,a0,566 # 9de0 <cv_init+0x205a>
    6bb2:	00001097          	auipc	ra,0x1
    6bb6:	cf6080e7          	jalr	-778(ra) # 78a8 <printf>
    6bba:	a809                	j	6bcc <run+0xa8>
    else
      printf("OK\n");
    6bbc:	00003517          	auipc	a0,0x3
    6bc0:	22c50513          	addi	a0,a0,556 # 9de8 <cv_init+0x2062>
    6bc4:	00001097          	auipc	ra,0x1
    6bc8:	ce4080e7          	jalr	-796(ra) # 78a8 <printf>
    return xstatus == 0;
    6bcc:	fe842783          	lw	a5,-24(s0)
    6bd0:	0017b793          	seqz	a5,a5
    6bd4:	0ff7f793          	zext.b	a5,a5
    6bd8:	2781                	sext.w	a5,a5
  }
}
    6bda:	853e                	mv	a0,a5
    6bdc:	70a2                	ld	ra,40(sp)
    6bde:	7402                	ld	s0,32(sp)
    6be0:	6145                	addi	sp,sp,48
    6be2:	8082                	ret

0000000000006be4 <main>:

int
main(int argc, char *argv[])
{
    6be4:	bb010113          	addi	sp,sp,-1104
    6be8:	44113423          	sd	ra,1096(sp)
    6bec:	44813023          	sd	s0,1088(sp)
    6bf0:	45010413          	addi	s0,sp,1104
    6bf4:	87aa                	mv	a5,a0
    6bf6:	bab43823          	sd	a1,-1104(s0)
    6bfa:	baf42e23          	sw	a5,-1092(s0)
  int continuous = 0;
    6bfe:	fe042623          	sw	zero,-20(s0)
  char *justone = 0;
    6c02:	fe043023          	sd	zero,-32(s0)

  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    6c06:	bbc42783          	lw	a5,-1092(s0)
    6c0a:	0007871b          	sext.w	a4,a5
    6c0e:	4789                	li	a5,2
    6c10:	02f71563          	bne	a4,a5,6c3a <main+0x56>
    6c14:	bb043783          	ld	a5,-1104(s0)
    6c18:	07a1                	addi	a5,a5,8
    6c1a:	639c                	ld	a5,0(a5)
    6c1c:	00003597          	auipc	a1,0x3
    6c20:	1d458593          	addi	a1,a1,468 # 9df0 <cv_init+0x206a>
    6c24:	853e                	mv	a0,a5
    6c26:	00000097          	auipc	ra,0x0
    6c2a:	302080e7          	jalr	770(ra) # 6f28 <strcmp>
    6c2e:	87aa                	mv	a5,a0
    6c30:	e789                	bnez	a5,6c3a <main+0x56>
    continuous = 1;
    6c32:	4785                	li	a5,1
    6c34:	fef42623          	sw	a5,-20(s0)
    6c38:	a079                	j	6cc6 <main+0xe2>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    6c3a:	bbc42783          	lw	a5,-1092(s0)
    6c3e:	0007871b          	sext.w	a4,a5
    6c42:	4789                	li	a5,2
    6c44:	02f71563          	bne	a4,a5,6c6e <main+0x8a>
    6c48:	bb043783          	ld	a5,-1104(s0)
    6c4c:	07a1                	addi	a5,a5,8
    6c4e:	639c                	ld	a5,0(a5)
    6c50:	00003597          	auipc	a1,0x3
    6c54:	1a858593          	addi	a1,a1,424 # 9df8 <cv_init+0x2072>
    6c58:	853e                	mv	a0,a5
    6c5a:	00000097          	auipc	ra,0x0
    6c5e:	2ce080e7          	jalr	718(ra) # 6f28 <strcmp>
    6c62:	87aa                	mv	a5,a0
    6c64:	e789                	bnez	a5,6c6e <main+0x8a>
    continuous = 2;
    6c66:	4789                	li	a5,2
    6c68:	fef42623          	sw	a5,-20(s0)
    6c6c:	a8a9                	j	6cc6 <main+0xe2>
  } else if(argc == 2 && argv[1][0] != '-'){
    6c6e:	bbc42783          	lw	a5,-1092(s0)
    6c72:	0007871b          	sext.w	a4,a5
    6c76:	4789                	li	a5,2
    6c78:	02f71363          	bne	a4,a5,6c9e <main+0xba>
    6c7c:	bb043783          	ld	a5,-1104(s0)
    6c80:	07a1                	addi	a5,a5,8
    6c82:	639c                	ld	a5,0(a5)
    6c84:	0007c783          	lbu	a5,0(a5) # 1000 <truncate3+0x1b2>
    6c88:	873e                	mv	a4,a5
    6c8a:	02d00793          	li	a5,45
    6c8e:	00f70863          	beq	a4,a5,6c9e <main+0xba>
    justone = argv[1];
    6c92:	bb043783          	ld	a5,-1104(s0)
    6c96:	679c                	ld	a5,8(a5)
    6c98:	fef43023          	sd	a5,-32(s0)
    6c9c:	a02d                	j	6cc6 <main+0xe2>
  } else if(argc > 1){
    6c9e:	bbc42783          	lw	a5,-1092(s0)
    6ca2:	0007871b          	sext.w	a4,a5
    6ca6:	4785                	li	a5,1
    6ca8:	00e7df63          	bge	a5,a4,6cc6 <main+0xe2>
    printf("Usage: usertests [-c] [testname]\n");
    6cac:	00003517          	auipc	a0,0x3
    6cb0:	15450513          	addi	a0,a0,340 # 9e00 <cv_init+0x207a>
    6cb4:	00001097          	auipc	ra,0x1
    6cb8:	bf4080e7          	jalr	-1036(ra) # 78a8 <printf>
    exit(1);
    6cbc:	4505                	li	a0,1
    6cbe:	00000097          	auipc	ra,0x0
    6cc2:	6b2080e7          	jalr	1714(ra) # 7370 <exit>
  }
  
  struct test {
    void (*f)(char *);
    char *s;
  } tests[] = {
    6cc6:	00003717          	auipc	a4,0x3
    6cca:	51a70713          	addi	a4,a4,1306 # a1e0 <cv_init+0x245a>
    6cce:	bc040793          	addi	a5,s0,-1088
    6cd2:	86ba                	mv	a3,a4
    6cd4:	3f000713          	li	a4,1008
    6cd8:	863a                	mv	a2,a4
    6cda:	85b6                	mv	a1,a3
    6cdc:	853e                	mv	a0,a5
    6cde:	00000097          	auipc	ra,0x0
    6ce2:	652080e7          	jalr	1618(ra) # 7330 <memcpy>
    {forktest, "forktest"},
    {bigdir, "bigdir"}, // slow
    { 0, 0},
  };

  if(continuous){
    6ce6:	fec42783          	lw	a5,-20(s0)
    6cea:	2781                	sext.w	a5,a5
    6cec:	c7fd                	beqz	a5,6dda <main+0x1f6>
    printf("continuous usertests starting\n");
    6cee:	00003517          	auipc	a0,0x3
    6cf2:	13a50513          	addi	a0,a0,314 # 9e28 <cv_init+0x20a2>
    6cf6:	00001097          	auipc	ra,0x1
    6cfa:	bb2080e7          	jalr	-1102(ra) # 78a8 <printf>
    while(1){
      int fail = 0;
    6cfe:	fc042e23          	sw	zero,-36(s0)
      int free0 = countfree();
    6d02:	00000097          	auipc	ra,0x0
    6d06:	ca2080e7          	jalr	-862(ra) # 69a4 <countfree>
    6d0a:	87aa                	mv	a5,a0
    6d0c:	faf42a23          	sw	a5,-76(s0)
      for (struct test *t = tests; t->s != 0; t++) {
    6d10:	bc040793          	addi	a5,s0,-1088
    6d14:	fcf43823          	sd	a5,-48(s0)
    6d18:	a805                	j	6d48 <main+0x164>
        if(!run(t->f, t->s)){
    6d1a:	fd043783          	ld	a5,-48(s0)
    6d1e:	6398                	ld	a4,0(a5)
    6d20:	fd043783          	ld	a5,-48(s0)
    6d24:	679c                	ld	a5,8(a5)
    6d26:	85be                	mv	a1,a5
    6d28:	853a                	mv	a0,a4
    6d2a:	00000097          	auipc	ra,0x0
    6d2e:	dfa080e7          	jalr	-518(ra) # 6b24 <run>
    6d32:	87aa                	mv	a5,a0
    6d34:	e789                	bnez	a5,6d3e <main+0x15a>
          fail = 1;
    6d36:	4785                	li	a5,1
    6d38:	fcf42e23          	sw	a5,-36(s0)
          break;
    6d3c:	a811                	j	6d50 <main+0x16c>
      for (struct test *t = tests; t->s != 0; t++) {
    6d3e:	fd043783          	ld	a5,-48(s0)
    6d42:	07c1                	addi	a5,a5,16
    6d44:	fcf43823          	sd	a5,-48(s0)
    6d48:	fd043783          	ld	a5,-48(s0)
    6d4c:	679c                	ld	a5,8(a5)
    6d4e:	f7f1                	bnez	a5,6d1a <main+0x136>
        }
      }
      if(fail){
    6d50:	fdc42783          	lw	a5,-36(s0)
    6d54:	2781                	sext.w	a5,a5
    6d56:	c78d                	beqz	a5,6d80 <main+0x19c>
        printf("SOME TESTS FAILED\n");
    6d58:	00003517          	auipc	a0,0x3
    6d5c:	0f050513          	addi	a0,a0,240 # 9e48 <cv_init+0x20c2>
    6d60:	00001097          	auipc	ra,0x1
    6d64:	b48080e7          	jalr	-1208(ra) # 78a8 <printf>
        if(continuous != 2)
    6d68:	fec42783          	lw	a5,-20(s0)
    6d6c:	0007871b          	sext.w	a4,a5
    6d70:	4789                	li	a5,2
    6d72:	00f70763          	beq	a4,a5,6d80 <main+0x19c>
          exit(1);
    6d76:	4505                	li	a0,1
    6d78:	00000097          	auipc	ra,0x0
    6d7c:	5f8080e7          	jalr	1528(ra) # 7370 <exit>
      }
      int free1 = countfree();
    6d80:	00000097          	auipc	ra,0x0
    6d84:	c24080e7          	jalr	-988(ra) # 69a4 <countfree>
    6d88:	87aa                	mv	a5,a0
    6d8a:	faf42823          	sw	a5,-80(s0)
      if(free1 < free0){
    6d8e:	fb042783          	lw	a5,-80(s0)
    6d92:	873e                	mv	a4,a5
    6d94:	fb442783          	lw	a5,-76(s0)
    6d98:	2701                	sext.w	a4,a4
    6d9a:	2781                	sext.w	a5,a5
    6d9c:	f6f751e3          	bge	a4,a5,6cfe <main+0x11a>
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    6da0:	fb442783          	lw	a5,-76(s0)
    6da4:	873e                	mv	a4,a5
    6da6:	fb042783          	lw	a5,-80(s0)
    6daa:	40f707bb          	subw	a5,a4,a5
    6dae:	2781                	sext.w	a5,a5
    6db0:	85be                	mv	a1,a5
    6db2:	00003517          	auipc	a0,0x3
    6db6:	0ae50513          	addi	a0,a0,174 # 9e60 <cv_init+0x20da>
    6dba:	00001097          	auipc	ra,0x1
    6dbe:	aee080e7          	jalr	-1298(ra) # 78a8 <printf>
        if(continuous != 2)
    6dc2:	fec42783          	lw	a5,-20(s0)
    6dc6:	0007871b          	sext.w	a4,a5
    6dca:	4789                	li	a5,2
    6dcc:	f2f709e3          	beq	a4,a5,6cfe <main+0x11a>
          exit(1);
    6dd0:	4505                	li	a0,1
    6dd2:	00000097          	auipc	ra,0x0
    6dd6:	59e080e7          	jalr	1438(ra) # 7370 <exit>
      }
    }
  }

  printf("usertests starting\n");
    6dda:	00003517          	auipc	a0,0x3
    6dde:	0a650513          	addi	a0,a0,166 # 9e80 <cv_init+0x20fa>
    6de2:	00001097          	auipc	ra,0x1
    6de6:	ac6080e7          	jalr	-1338(ra) # 78a8 <printf>
  int free0 = countfree();
    6dea:	00000097          	auipc	ra,0x0
    6dee:	bba080e7          	jalr	-1094(ra) # 69a4 <countfree>
    6df2:	87aa                	mv	a5,a0
    6df4:	faf42e23          	sw	a5,-68(s0)
  int free1 = 0;
    6df8:	fa042c23          	sw	zero,-72(s0)
  int fail = 0;
    6dfc:	fc042623          	sw	zero,-52(s0)
  for (struct test *t = tests; t->s != 0; t++) {
    6e00:	bc040793          	addi	a5,s0,-1088
    6e04:	fcf43023          	sd	a5,-64(s0)
    6e08:	a0b1                	j	6e54 <main+0x270>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    6e0a:	fe043783          	ld	a5,-32(s0)
    6e0e:	cf89                	beqz	a5,6e28 <main+0x244>
    6e10:	fc043783          	ld	a5,-64(s0)
    6e14:	679c                	ld	a5,8(a5)
    6e16:	fe043583          	ld	a1,-32(s0)
    6e1a:	853e                	mv	a0,a5
    6e1c:	00000097          	auipc	ra,0x0
    6e20:	10c080e7          	jalr	268(ra) # 6f28 <strcmp>
    6e24:	87aa                	mv	a5,a0
    6e26:	e395                	bnez	a5,6e4a <main+0x266>
      if(!run(t->f, t->s))
    6e28:	fc043783          	ld	a5,-64(s0)
    6e2c:	6398                	ld	a4,0(a5)
    6e2e:	fc043783          	ld	a5,-64(s0)
    6e32:	679c                	ld	a5,8(a5)
    6e34:	85be                	mv	a1,a5
    6e36:	853a                	mv	a0,a4
    6e38:	00000097          	auipc	ra,0x0
    6e3c:	cec080e7          	jalr	-788(ra) # 6b24 <run>
    6e40:	87aa                	mv	a5,a0
    6e42:	e781                	bnez	a5,6e4a <main+0x266>
        fail = 1;
    6e44:	4785                	li	a5,1
    6e46:	fcf42623          	sw	a5,-52(s0)
  for (struct test *t = tests; t->s != 0; t++) {
    6e4a:	fc043783          	ld	a5,-64(s0)
    6e4e:	07c1                	addi	a5,a5,16
    6e50:	fcf43023          	sd	a5,-64(s0)
    6e54:	fc043783          	ld	a5,-64(s0)
    6e58:	679c                	ld	a5,8(a5)
    6e5a:	fbc5                	bnez	a5,6e0a <main+0x226>
    }
  }

  if(fail){
    6e5c:	fcc42783          	lw	a5,-52(s0)
    6e60:	2781                	sext.w	a5,a5
    6e62:	cf91                	beqz	a5,6e7e <main+0x29a>
    printf("SOME TESTS FAILED\n");
    6e64:	00003517          	auipc	a0,0x3
    6e68:	fe450513          	addi	a0,a0,-28 # 9e48 <cv_init+0x20c2>
    6e6c:	00001097          	auipc	ra,0x1
    6e70:	a3c080e7          	jalr	-1476(ra) # 78a8 <printf>
    exit(1);
    6e74:	4505                	li	a0,1
    6e76:	00000097          	auipc	ra,0x0
    6e7a:	4fa080e7          	jalr	1274(ra) # 7370 <exit>
  } else if((free1 = countfree()) < free0){
    6e7e:	00000097          	auipc	ra,0x0
    6e82:	b26080e7          	jalr	-1242(ra) # 69a4 <countfree>
    6e86:	87aa                	mv	a5,a0
    6e88:	faf42c23          	sw	a5,-72(s0)
    6e8c:	fb842783          	lw	a5,-72(s0)
    6e90:	873e                	mv	a4,a5
    6e92:	fbc42783          	lw	a5,-68(s0)
    6e96:	2701                	sext.w	a4,a4
    6e98:	2781                	sext.w	a5,a5
    6e9a:	02f75563          	bge	a4,a5,6ec4 <main+0x2e0>
    printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    6e9e:	fbc42703          	lw	a4,-68(s0)
    6ea2:	fb842783          	lw	a5,-72(s0)
    6ea6:	863a                	mv	a2,a4
    6ea8:	85be                	mv	a1,a5
    6eaa:	00003517          	auipc	a0,0x3
    6eae:	fee50513          	addi	a0,a0,-18 # 9e98 <cv_init+0x2112>
    6eb2:	00001097          	auipc	ra,0x1
    6eb6:	9f6080e7          	jalr	-1546(ra) # 78a8 <printf>
    exit(1);
    6eba:	4505                	li	a0,1
    6ebc:	00000097          	auipc	ra,0x0
    6ec0:	4b4080e7          	jalr	1204(ra) # 7370 <exit>
  } else {
    printf("ALL TESTS PASSED\n");
    6ec4:	00003517          	auipc	a0,0x3
    6ec8:	00450513          	addi	a0,a0,4 # 9ec8 <cv_init+0x2142>
    6ecc:	00001097          	auipc	ra,0x1
    6ed0:	9dc080e7          	jalr	-1572(ra) # 78a8 <printf>
    exit(0);
    6ed4:	4501                	li	a0,0
    6ed6:	00000097          	auipc	ra,0x0
    6eda:	49a080e7          	jalr	1178(ra) # 7370 <exit>

0000000000006ede <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
    6ede:	7179                	addi	sp,sp,-48
    6ee0:	f422                	sd	s0,40(sp)
    6ee2:	1800                	addi	s0,sp,48
    6ee4:	fca43c23          	sd	a0,-40(s0)
    6ee8:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
    6eec:	fd843783          	ld	a5,-40(s0)
    6ef0:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
    6ef4:	0001                	nop
    6ef6:	fd043703          	ld	a4,-48(s0)
    6efa:	00170793          	addi	a5,a4,1
    6efe:	fcf43823          	sd	a5,-48(s0)
    6f02:	fd843783          	ld	a5,-40(s0)
    6f06:	00178693          	addi	a3,a5,1
    6f0a:	fcd43c23          	sd	a3,-40(s0)
    6f0e:	00074703          	lbu	a4,0(a4)
    6f12:	00e78023          	sb	a4,0(a5)
    6f16:	0007c783          	lbu	a5,0(a5)
    6f1a:	fff1                	bnez	a5,6ef6 <strcpy+0x18>
    ;
  return os;
    6f1c:	fe843783          	ld	a5,-24(s0)
}
    6f20:	853e                	mv	a0,a5
    6f22:	7422                	ld	s0,40(sp)
    6f24:	6145                	addi	sp,sp,48
    6f26:	8082                	ret

0000000000006f28 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    6f28:	1101                	addi	sp,sp,-32
    6f2a:	ec22                	sd	s0,24(sp)
    6f2c:	1000                	addi	s0,sp,32
    6f2e:	fea43423          	sd	a0,-24(s0)
    6f32:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
    6f36:	a819                	j	6f4c <strcmp+0x24>
    p++, q++;
    6f38:	fe843783          	ld	a5,-24(s0)
    6f3c:	0785                	addi	a5,a5,1
    6f3e:	fef43423          	sd	a5,-24(s0)
    6f42:	fe043783          	ld	a5,-32(s0)
    6f46:	0785                	addi	a5,a5,1
    6f48:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
    6f4c:	fe843783          	ld	a5,-24(s0)
    6f50:	0007c783          	lbu	a5,0(a5)
    6f54:	cb99                	beqz	a5,6f6a <strcmp+0x42>
    6f56:	fe843783          	ld	a5,-24(s0)
    6f5a:	0007c703          	lbu	a4,0(a5)
    6f5e:	fe043783          	ld	a5,-32(s0)
    6f62:	0007c783          	lbu	a5,0(a5)
    6f66:	fcf709e3          	beq	a4,a5,6f38 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
    6f6a:	fe843783          	ld	a5,-24(s0)
    6f6e:	0007c783          	lbu	a5,0(a5)
    6f72:	0007871b          	sext.w	a4,a5
    6f76:	fe043783          	ld	a5,-32(s0)
    6f7a:	0007c783          	lbu	a5,0(a5)
    6f7e:	2781                	sext.w	a5,a5
    6f80:	40f707bb          	subw	a5,a4,a5
    6f84:	2781                	sext.w	a5,a5
}
    6f86:	853e                	mv	a0,a5
    6f88:	6462                	ld	s0,24(sp)
    6f8a:	6105                	addi	sp,sp,32
    6f8c:	8082                	ret

0000000000006f8e <strlen>:

uint
strlen(const char *s)
{
    6f8e:	7179                	addi	sp,sp,-48
    6f90:	f422                	sd	s0,40(sp)
    6f92:	1800                	addi	s0,sp,48
    6f94:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    6f98:	fe042623          	sw	zero,-20(s0)
    6f9c:	a031                	j	6fa8 <strlen+0x1a>
    6f9e:	fec42783          	lw	a5,-20(s0)
    6fa2:	2785                	addiw	a5,a5,1
    6fa4:	fef42623          	sw	a5,-20(s0)
    6fa8:	fec42783          	lw	a5,-20(s0)
    6fac:	fd843703          	ld	a4,-40(s0)
    6fb0:	97ba                	add	a5,a5,a4
    6fb2:	0007c783          	lbu	a5,0(a5)
    6fb6:	f7e5                	bnez	a5,6f9e <strlen+0x10>
    ;
  return n;
    6fb8:	fec42783          	lw	a5,-20(s0)
}
    6fbc:	853e                	mv	a0,a5
    6fbe:	7422                	ld	s0,40(sp)
    6fc0:	6145                	addi	sp,sp,48
    6fc2:	8082                	ret

0000000000006fc4 <memset>:

void*
memset(void *dst, int c, uint n)
{
    6fc4:	7179                	addi	sp,sp,-48
    6fc6:	f422                	sd	s0,40(sp)
    6fc8:	1800                	addi	s0,sp,48
    6fca:	fca43c23          	sd	a0,-40(s0)
    6fce:	87ae                	mv	a5,a1
    6fd0:	8732                	mv	a4,a2
    6fd2:	fcf42a23          	sw	a5,-44(s0)
    6fd6:	87ba                	mv	a5,a4
    6fd8:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    6fdc:	fd843783          	ld	a5,-40(s0)
    6fe0:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    6fe4:	fe042623          	sw	zero,-20(s0)
    6fe8:	a00d                	j	700a <memset+0x46>
    cdst[i] = c;
    6fea:	fec42783          	lw	a5,-20(s0)
    6fee:	fe043703          	ld	a4,-32(s0)
    6ff2:	97ba                	add	a5,a5,a4
    6ff4:	fd442703          	lw	a4,-44(s0)
    6ff8:	0ff77713          	zext.b	a4,a4
    6ffc:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    7000:	fec42783          	lw	a5,-20(s0)
    7004:	2785                	addiw	a5,a5,1
    7006:	fef42623          	sw	a5,-20(s0)
    700a:	fec42703          	lw	a4,-20(s0)
    700e:	fd042783          	lw	a5,-48(s0)
    7012:	2781                	sext.w	a5,a5
    7014:	fcf76be3          	bltu	a4,a5,6fea <memset+0x26>
  }
  return dst;
    7018:	fd843783          	ld	a5,-40(s0)
}
    701c:	853e                	mv	a0,a5
    701e:	7422                	ld	s0,40(sp)
    7020:	6145                	addi	sp,sp,48
    7022:	8082                	ret

0000000000007024 <strchr>:

char*
strchr(const char *s, char c)
{
    7024:	1101                	addi	sp,sp,-32
    7026:	ec22                	sd	s0,24(sp)
    7028:	1000                	addi	s0,sp,32
    702a:	fea43423          	sd	a0,-24(s0)
    702e:	87ae                	mv	a5,a1
    7030:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
    7034:	a01d                	j	705a <strchr+0x36>
    if(*s == c)
    7036:	fe843783          	ld	a5,-24(s0)
    703a:	0007c703          	lbu	a4,0(a5)
    703e:	fe744783          	lbu	a5,-25(s0)
    7042:	0ff7f793          	zext.b	a5,a5
    7046:	00e79563          	bne	a5,a4,7050 <strchr+0x2c>
      return (char*)s;
    704a:	fe843783          	ld	a5,-24(s0)
    704e:	a821                	j	7066 <strchr+0x42>
  for(; *s; s++)
    7050:	fe843783          	ld	a5,-24(s0)
    7054:	0785                	addi	a5,a5,1
    7056:	fef43423          	sd	a5,-24(s0)
    705a:	fe843783          	ld	a5,-24(s0)
    705e:	0007c783          	lbu	a5,0(a5)
    7062:	fbf1                	bnez	a5,7036 <strchr+0x12>
  return 0;
    7064:	4781                	li	a5,0
}
    7066:	853e                	mv	a0,a5
    7068:	6462                	ld	s0,24(sp)
    706a:	6105                	addi	sp,sp,32
    706c:	8082                	ret

000000000000706e <gets>:

char*
gets(char *buf, int max)
{
    706e:	7179                	addi	sp,sp,-48
    7070:	f406                	sd	ra,40(sp)
    7072:	f022                	sd	s0,32(sp)
    7074:	1800                	addi	s0,sp,48
    7076:	fca43c23          	sd	a0,-40(s0)
    707a:	87ae                	mv	a5,a1
    707c:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    7080:	fe042623          	sw	zero,-20(s0)
    7084:	a8a1                	j	70dc <gets+0x6e>
    cc = read(0, &c, 1);
    7086:	fe740793          	addi	a5,s0,-25
    708a:	4605                	li	a2,1
    708c:	85be                	mv	a1,a5
    708e:	4501                	li	a0,0
    7090:	00000097          	auipc	ra,0x0
    7094:	2f8080e7          	jalr	760(ra) # 7388 <read>
    7098:	87aa                	mv	a5,a0
    709a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
    709e:	fe842783          	lw	a5,-24(s0)
    70a2:	2781                	sext.w	a5,a5
    70a4:	04f05763          	blez	a5,70f2 <gets+0x84>
      break;
    buf[i++] = c;
    70a8:	fec42783          	lw	a5,-20(s0)
    70ac:	0017871b          	addiw	a4,a5,1
    70b0:	fee42623          	sw	a4,-20(s0)
    70b4:	873e                	mv	a4,a5
    70b6:	fd843783          	ld	a5,-40(s0)
    70ba:	97ba                	add	a5,a5,a4
    70bc:	fe744703          	lbu	a4,-25(s0)
    70c0:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
    70c4:	fe744783          	lbu	a5,-25(s0)
    70c8:	873e                	mv	a4,a5
    70ca:	47a9                	li	a5,10
    70cc:	02f70463          	beq	a4,a5,70f4 <gets+0x86>
    70d0:	fe744783          	lbu	a5,-25(s0)
    70d4:	873e                	mv	a4,a5
    70d6:	47b5                	li	a5,13
    70d8:	00f70e63          	beq	a4,a5,70f4 <gets+0x86>
  for(i=0; i+1 < max; ){
    70dc:	fec42783          	lw	a5,-20(s0)
    70e0:	2785                	addiw	a5,a5,1
    70e2:	0007871b          	sext.w	a4,a5
    70e6:	fd442783          	lw	a5,-44(s0)
    70ea:	2781                	sext.w	a5,a5
    70ec:	f8f74de3          	blt	a4,a5,7086 <gets+0x18>
    70f0:	a011                	j	70f4 <gets+0x86>
      break;
    70f2:	0001                	nop
      break;
  }
  buf[i] = '\0';
    70f4:	fec42783          	lw	a5,-20(s0)
    70f8:	fd843703          	ld	a4,-40(s0)
    70fc:	97ba                	add	a5,a5,a4
    70fe:	00078023          	sb	zero,0(a5)
  return buf;
    7102:	fd843783          	ld	a5,-40(s0)
}
    7106:	853e                	mv	a0,a5
    7108:	70a2                	ld	ra,40(sp)
    710a:	7402                	ld	s0,32(sp)
    710c:	6145                	addi	sp,sp,48
    710e:	8082                	ret

0000000000007110 <stat>:

int
stat(const char *n, struct stat *st)
{
    7110:	7179                	addi	sp,sp,-48
    7112:	f406                	sd	ra,40(sp)
    7114:	f022                	sd	s0,32(sp)
    7116:	1800                	addi	s0,sp,48
    7118:	fca43c23          	sd	a0,-40(s0)
    711c:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    7120:	4581                	li	a1,0
    7122:	fd843503          	ld	a0,-40(s0)
    7126:	00000097          	auipc	ra,0x0
    712a:	28a080e7          	jalr	650(ra) # 73b0 <open>
    712e:	87aa                	mv	a5,a0
    7130:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
    7134:	fec42783          	lw	a5,-20(s0)
    7138:	2781                	sext.w	a5,a5
    713a:	0007d463          	bgez	a5,7142 <stat+0x32>
    return -1;
    713e:	57fd                	li	a5,-1
    7140:	a035                	j	716c <stat+0x5c>
  r = fstat(fd, st);
    7142:	fec42783          	lw	a5,-20(s0)
    7146:	fd043583          	ld	a1,-48(s0)
    714a:	853e                	mv	a0,a5
    714c:	00000097          	auipc	ra,0x0
    7150:	27c080e7          	jalr	636(ra) # 73c8 <fstat>
    7154:	87aa                	mv	a5,a0
    7156:	fef42423          	sw	a5,-24(s0)
  close(fd);
    715a:	fec42783          	lw	a5,-20(s0)
    715e:	853e                	mv	a0,a5
    7160:	00000097          	auipc	ra,0x0
    7164:	238080e7          	jalr	568(ra) # 7398 <close>
  return r;
    7168:	fe842783          	lw	a5,-24(s0)
}
    716c:	853e                	mv	a0,a5
    716e:	70a2                	ld	ra,40(sp)
    7170:	7402                	ld	s0,32(sp)
    7172:	6145                	addi	sp,sp,48
    7174:	8082                	ret

0000000000007176 <atoi>:

int
atoi(const char *s)
{
    7176:	7179                	addi	sp,sp,-48
    7178:	f422                	sd	s0,40(sp)
    717a:	1800                	addi	s0,sp,48
    717c:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
    7180:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
    7184:	a81d                	j	71ba <atoi+0x44>
    n = n*10 + *s++ - '0';
    7186:	fec42783          	lw	a5,-20(s0)
    718a:	873e                	mv	a4,a5
    718c:	87ba                	mv	a5,a4
    718e:	0027979b          	slliw	a5,a5,0x2
    7192:	9fb9                	addw	a5,a5,a4
    7194:	0017979b          	slliw	a5,a5,0x1
    7198:	0007871b          	sext.w	a4,a5
    719c:	fd843783          	ld	a5,-40(s0)
    71a0:	00178693          	addi	a3,a5,1
    71a4:	fcd43c23          	sd	a3,-40(s0)
    71a8:	0007c783          	lbu	a5,0(a5)
    71ac:	2781                	sext.w	a5,a5
    71ae:	9fb9                	addw	a5,a5,a4
    71b0:	2781                	sext.w	a5,a5
    71b2:	fd07879b          	addiw	a5,a5,-48
    71b6:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
    71ba:	fd843783          	ld	a5,-40(s0)
    71be:	0007c783          	lbu	a5,0(a5)
    71c2:	873e                	mv	a4,a5
    71c4:	02f00793          	li	a5,47
    71c8:	00e7fb63          	bgeu	a5,a4,71de <atoi+0x68>
    71cc:	fd843783          	ld	a5,-40(s0)
    71d0:	0007c783          	lbu	a5,0(a5)
    71d4:	873e                	mv	a4,a5
    71d6:	03900793          	li	a5,57
    71da:	fae7f6e3          	bgeu	a5,a4,7186 <atoi+0x10>
  return n;
    71de:	fec42783          	lw	a5,-20(s0)
}
    71e2:	853e                	mv	a0,a5
    71e4:	7422                	ld	s0,40(sp)
    71e6:	6145                	addi	sp,sp,48
    71e8:	8082                	ret

00000000000071ea <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    71ea:	7139                	addi	sp,sp,-64
    71ec:	fc22                	sd	s0,56(sp)
    71ee:	0080                	addi	s0,sp,64
    71f0:	fca43c23          	sd	a0,-40(s0)
    71f4:	fcb43823          	sd	a1,-48(s0)
    71f8:	87b2                	mv	a5,a2
    71fa:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
    71fe:	fd843783          	ld	a5,-40(s0)
    7202:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
    7206:	fd043783          	ld	a5,-48(s0)
    720a:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
    720e:	fe043703          	ld	a4,-32(s0)
    7212:	fe843783          	ld	a5,-24(s0)
    7216:	02e7fc63          	bgeu	a5,a4,724e <memmove+0x64>
    while(n-- > 0)
    721a:	a00d                	j	723c <memmove+0x52>
      *dst++ = *src++;
    721c:	fe043703          	ld	a4,-32(s0)
    7220:	00170793          	addi	a5,a4,1
    7224:	fef43023          	sd	a5,-32(s0)
    7228:	fe843783          	ld	a5,-24(s0)
    722c:	00178693          	addi	a3,a5,1
    7230:	fed43423          	sd	a3,-24(s0)
    7234:	00074703          	lbu	a4,0(a4)
    7238:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    723c:	fcc42783          	lw	a5,-52(s0)
    7240:	fff7871b          	addiw	a4,a5,-1
    7244:	fce42623          	sw	a4,-52(s0)
    7248:	fcf04ae3          	bgtz	a5,721c <memmove+0x32>
    724c:	a891                	j	72a0 <memmove+0xb6>
  } else {
    dst += n;
    724e:	fcc42783          	lw	a5,-52(s0)
    7252:	fe843703          	ld	a4,-24(s0)
    7256:	97ba                	add	a5,a5,a4
    7258:	fef43423          	sd	a5,-24(s0)
    src += n;
    725c:	fcc42783          	lw	a5,-52(s0)
    7260:	fe043703          	ld	a4,-32(s0)
    7264:	97ba                	add	a5,a5,a4
    7266:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    726a:	a01d                	j	7290 <memmove+0xa6>
      *--dst = *--src;
    726c:	fe043783          	ld	a5,-32(s0)
    7270:	17fd                	addi	a5,a5,-1
    7272:	fef43023          	sd	a5,-32(s0)
    7276:	fe843783          	ld	a5,-24(s0)
    727a:	17fd                	addi	a5,a5,-1
    727c:	fef43423          	sd	a5,-24(s0)
    7280:	fe043783          	ld	a5,-32(s0)
    7284:	0007c703          	lbu	a4,0(a5)
    7288:	fe843783          	ld	a5,-24(s0)
    728c:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    7290:	fcc42783          	lw	a5,-52(s0)
    7294:	fff7871b          	addiw	a4,a5,-1
    7298:	fce42623          	sw	a4,-52(s0)
    729c:	fcf048e3          	bgtz	a5,726c <memmove+0x82>
  }
  return vdst;
    72a0:	fd843783          	ld	a5,-40(s0)
}
    72a4:	853e                	mv	a0,a5
    72a6:	7462                	ld	s0,56(sp)
    72a8:	6121                	addi	sp,sp,64
    72aa:	8082                	ret

00000000000072ac <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    72ac:	7139                	addi	sp,sp,-64
    72ae:	fc22                	sd	s0,56(sp)
    72b0:	0080                	addi	s0,sp,64
    72b2:	fca43c23          	sd	a0,-40(s0)
    72b6:	fcb43823          	sd	a1,-48(s0)
    72ba:	87b2                	mv	a5,a2
    72bc:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
    72c0:	fd843783          	ld	a5,-40(s0)
    72c4:	fef43423          	sd	a5,-24(s0)
    72c8:	fd043783          	ld	a5,-48(s0)
    72cc:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    72d0:	a0a1                	j	7318 <memcmp+0x6c>
    if (*p1 != *p2) {
    72d2:	fe843783          	ld	a5,-24(s0)
    72d6:	0007c703          	lbu	a4,0(a5)
    72da:	fe043783          	ld	a5,-32(s0)
    72de:	0007c783          	lbu	a5,0(a5)
    72e2:	02f70163          	beq	a4,a5,7304 <memcmp+0x58>
      return *p1 - *p2;
    72e6:	fe843783          	ld	a5,-24(s0)
    72ea:	0007c783          	lbu	a5,0(a5)
    72ee:	0007871b          	sext.w	a4,a5
    72f2:	fe043783          	ld	a5,-32(s0)
    72f6:	0007c783          	lbu	a5,0(a5)
    72fa:	2781                	sext.w	a5,a5
    72fc:	40f707bb          	subw	a5,a4,a5
    7300:	2781                	sext.w	a5,a5
    7302:	a01d                	j	7328 <memcmp+0x7c>
    }
    p1++;
    7304:	fe843783          	ld	a5,-24(s0)
    7308:	0785                	addi	a5,a5,1
    730a:	fef43423          	sd	a5,-24(s0)
    p2++;
    730e:	fe043783          	ld	a5,-32(s0)
    7312:	0785                	addi	a5,a5,1
    7314:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    7318:	fcc42783          	lw	a5,-52(s0)
    731c:	fff7871b          	addiw	a4,a5,-1
    7320:	fce42623          	sw	a4,-52(s0)
    7324:	f7dd                	bnez	a5,72d2 <memcmp+0x26>
  }
  return 0;
    7326:	4781                	li	a5,0
}
    7328:	853e                	mv	a0,a5
    732a:	7462                	ld	s0,56(sp)
    732c:	6121                	addi	sp,sp,64
    732e:	8082                	ret

0000000000007330 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    7330:	7179                	addi	sp,sp,-48
    7332:	f406                	sd	ra,40(sp)
    7334:	f022                	sd	s0,32(sp)
    7336:	1800                	addi	s0,sp,48
    7338:	fea43423          	sd	a0,-24(s0)
    733c:	feb43023          	sd	a1,-32(s0)
    7340:	87b2                	mv	a5,a2
    7342:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    7346:	fdc42783          	lw	a5,-36(s0)
    734a:	863e                	mv	a2,a5
    734c:	fe043583          	ld	a1,-32(s0)
    7350:	fe843503          	ld	a0,-24(s0)
    7354:	00000097          	auipc	ra,0x0
    7358:	e96080e7          	jalr	-362(ra) # 71ea <memmove>
    735c:	87aa                	mv	a5,a0
}
    735e:	853e                	mv	a0,a5
    7360:	70a2                	ld	ra,40(sp)
    7362:	7402                	ld	s0,32(sp)
    7364:	6145                	addi	sp,sp,48
    7366:	8082                	ret

0000000000007368 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    7368:	4885                	li	a7,1
 ecall
    736a:	00000073          	ecall
 ret
    736e:	8082                	ret

0000000000007370 <exit>:
.global exit
exit:
 li a7, SYS_exit
    7370:	4889                	li	a7,2
 ecall
    7372:	00000073          	ecall
 ret
    7376:	8082                	ret

0000000000007378 <wait>:
.global wait
wait:
 li a7, SYS_wait
    7378:	488d                	li	a7,3
 ecall
    737a:	00000073          	ecall
 ret
    737e:	8082                	ret

0000000000007380 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    7380:	4891                	li	a7,4
 ecall
    7382:	00000073          	ecall
 ret
    7386:	8082                	ret

0000000000007388 <read>:
.global read
read:
 li a7, SYS_read
    7388:	4895                	li	a7,5
 ecall
    738a:	00000073          	ecall
 ret
    738e:	8082                	ret

0000000000007390 <write>:
.global write
write:
 li a7, SYS_write
    7390:	48c1                	li	a7,16
 ecall
    7392:	00000073          	ecall
 ret
    7396:	8082                	ret

0000000000007398 <close>:
.global close
close:
 li a7, SYS_close
    7398:	48d5                	li	a7,21
 ecall
    739a:	00000073          	ecall
 ret
    739e:	8082                	ret

00000000000073a0 <kill>:
.global kill
kill:
 li a7, SYS_kill
    73a0:	4899                	li	a7,6
 ecall
    73a2:	00000073          	ecall
 ret
    73a6:	8082                	ret

00000000000073a8 <exec>:
.global exec
exec:
 li a7, SYS_exec
    73a8:	489d                	li	a7,7
 ecall
    73aa:	00000073          	ecall
 ret
    73ae:	8082                	ret

00000000000073b0 <open>:
.global open
open:
 li a7, SYS_open
    73b0:	48bd                	li	a7,15
 ecall
    73b2:	00000073          	ecall
 ret
    73b6:	8082                	ret

00000000000073b8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    73b8:	48c5                	li	a7,17
 ecall
    73ba:	00000073          	ecall
 ret
    73be:	8082                	ret

00000000000073c0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    73c0:	48c9                	li	a7,18
 ecall
    73c2:	00000073          	ecall
 ret
    73c6:	8082                	ret

00000000000073c8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    73c8:	48a1                	li	a7,8
 ecall
    73ca:	00000073          	ecall
 ret
    73ce:	8082                	ret

00000000000073d0 <link>:
.global link
link:
 li a7, SYS_link
    73d0:	48cd                	li	a7,19
 ecall
    73d2:	00000073          	ecall
 ret
    73d6:	8082                	ret

00000000000073d8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    73d8:	48d1                	li	a7,20
 ecall
    73da:	00000073          	ecall
 ret
    73de:	8082                	ret

00000000000073e0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    73e0:	48a5                	li	a7,9
 ecall
    73e2:	00000073          	ecall
 ret
    73e6:	8082                	ret

00000000000073e8 <dup>:
.global dup
dup:
 li a7, SYS_dup
    73e8:	48a9                	li	a7,10
 ecall
    73ea:	00000073          	ecall
 ret
    73ee:	8082                	ret

00000000000073f0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    73f0:	48ad                	li	a7,11
 ecall
    73f2:	00000073          	ecall
 ret
    73f6:	8082                	ret

00000000000073f8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    73f8:	48b1                	li	a7,12
 ecall
    73fa:	00000073          	ecall
 ret
    73fe:	8082                	ret

0000000000007400 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    7400:	48b5                	li	a7,13
 ecall
    7402:	00000073          	ecall
 ret
    7406:	8082                	ret

0000000000007408 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    7408:	48b9                	li	a7,14
 ecall
    740a:	00000073          	ecall
 ret
    740e:	8082                	ret

0000000000007410 <clone>:
.global clone
clone:
 li a7, SYS_clone
    7410:	48d9                	li	a7,22
 ecall
    7412:	00000073          	ecall
 ret
    7416:	8082                	ret

0000000000007418 <join>:
.global join
join:
 li a7, SYS_join
    7418:	48dd                	li	a7,23
 ecall
    741a:	00000073          	ecall
 ret
    741e:	8082                	ret

0000000000007420 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    7420:	1101                	addi	sp,sp,-32
    7422:	ec06                	sd	ra,24(sp)
    7424:	e822                	sd	s0,16(sp)
    7426:	1000                	addi	s0,sp,32
    7428:	87aa                	mv	a5,a0
    742a:	872e                	mv	a4,a1
    742c:	fef42623          	sw	a5,-20(s0)
    7430:	87ba                	mv	a5,a4
    7432:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
    7436:	feb40713          	addi	a4,s0,-21
    743a:	fec42783          	lw	a5,-20(s0)
    743e:	4605                	li	a2,1
    7440:	85ba                	mv	a1,a4
    7442:	853e                	mv	a0,a5
    7444:	00000097          	auipc	ra,0x0
    7448:	f4c080e7          	jalr	-180(ra) # 7390 <write>
}
    744c:	0001                	nop
    744e:	60e2                	ld	ra,24(sp)
    7450:	6442                	ld	s0,16(sp)
    7452:	6105                	addi	sp,sp,32
    7454:	8082                	ret

0000000000007456 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    7456:	7139                	addi	sp,sp,-64
    7458:	fc06                	sd	ra,56(sp)
    745a:	f822                	sd	s0,48(sp)
    745c:	0080                	addi	s0,sp,64
    745e:	87aa                	mv	a5,a0
    7460:	8736                	mv	a4,a3
    7462:	fcf42623          	sw	a5,-52(s0)
    7466:	87ae                	mv	a5,a1
    7468:	fcf42423          	sw	a5,-56(s0)
    746c:	87b2                	mv	a5,a2
    746e:	fcf42223          	sw	a5,-60(s0)
    7472:	87ba                	mv	a5,a4
    7474:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    7478:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
    747c:	fc042783          	lw	a5,-64(s0)
    7480:	2781                	sext.w	a5,a5
    7482:	c38d                	beqz	a5,74a4 <printint+0x4e>
    7484:	fc842783          	lw	a5,-56(s0)
    7488:	2781                	sext.w	a5,a5
    748a:	0007dd63          	bgez	a5,74a4 <printint+0x4e>
    neg = 1;
    748e:	4785                	li	a5,1
    7490:	fef42423          	sw	a5,-24(s0)
    x = -xx;
    7494:	fc842783          	lw	a5,-56(s0)
    7498:	40f007bb          	negw	a5,a5
    749c:	2781                	sext.w	a5,a5
    749e:	fef42223          	sw	a5,-28(s0)
    74a2:	a029                	j	74ac <printint+0x56>
  } else {
    x = xx;
    74a4:	fc842783          	lw	a5,-56(s0)
    74a8:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
    74ac:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
    74b0:	fc442783          	lw	a5,-60(s0)
    74b4:	fe442703          	lw	a4,-28(s0)
    74b8:	02f777bb          	remuw	a5,a4,a5
    74bc:	0007861b          	sext.w	a2,a5
    74c0:	fec42783          	lw	a5,-20(s0)
    74c4:	0017871b          	addiw	a4,a5,1
    74c8:	fee42623          	sw	a4,-20(s0)
    74cc:	00003697          	auipc	a3,0x3
    74d0:	16468693          	addi	a3,a3,356 # a630 <digits>
    74d4:	02061713          	slli	a4,a2,0x20
    74d8:	9301                	srli	a4,a4,0x20
    74da:	9736                	add	a4,a4,a3
    74dc:	00074703          	lbu	a4,0(a4)
    74e0:	17c1                	addi	a5,a5,-16
    74e2:	97a2                	add	a5,a5,s0
    74e4:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
    74e8:	fc442783          	lw	a5,-60(s0)
    74ec:	fe442703          	lw	a4,-28(s0)
    74f0:	02f757bb          	divuw	a5,a4,a5
    74f4:	fef42223          	sw	a5,-28(s0)
    74f8:	fe442783          	lw	a5,-28(s0)
    74fc:	2781                	sext.w	a5,a5
    74fe:	fbcd                	bnez	a5,74b0 <printint+0x5a>
  if(neg)
    7500:	fe842783          	lw	a5,-24(s0)
    7504:	2781                	sext.w	a5,a5
    7506:	cf85                	beqz	a5,753e <printint+0xe8>
    buf[i++] = '-';
    7508:	fec42783          	lw	a5,-20(s0)
    750c:	0017871b          	addiw	a4,a5,1
    7510:	fee42623          	sw	a4,-20(s0)
    7514:	17c1                	addi	a5,a5,-16
    7516:	97a2                	add	a5,a5,s0
    7518:	02d00713          	li	a4,45
    751c:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
    7520:	a839                	j	753e <printint+0xe8>
    putc(fd, buf[i]);
    7522:	fec42783          	lw	a5,-20(s0)
    7526:	17c1                	addi	a5,a5,-16
    7528:	97a2                	add	a5,a5,s0
    752a:	fe07c703          	lbu	a4,-32(a5)
    752e:	fcc42783          	lw	a5,-52(s0)
    7532:	85ba                	mv	a1,a4
    7534:	853e                	mv	a0,a5
    7536:	00000097          	auipc	ra,0x0
    753a:	eea080e7          	jalr	-278(ra) # 7420 <putc>
  while(--i >= 0)
    753e:	fec42783          	lw	a5,-20(s0)
    7542:	37fd                	addiw	a5,a5,-1
    7544:	fef42623          	sw	a5,-20(s0)
    7548:	fec42783          	lw	a5,-20(s0)
    754c:	2781                	sext.w	a5,a5
    754e:	fc07dae3          	bgez	a5,7522 <printint+0xcc>
}
    7552:	0001                	nop
    7554:	0001                	nop
    7556:	70e2                	ld	ra,56(sp)
    7558:	7442                	ld	s0,48(sp)
    755a:	6121                	addi	sp,sp,64
    755c:	8082                	ret

000000000000755e <printptr>:

static void
printptr(int fd, uint64 x) {
    755e:	7179                	addi	sp,sp,-48
    7560:	f406                	sd	ra,40(sp)
    7562:	f022                	sd	s0,32(sp)
    7564:	1800                	addi	s0,sp,48
    7566:	87aa                	mv	a5,a0
    7568:	fcb43823          	sd	a1,-48(s0)
    756c:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    7570:	fdc42783          	lw	a5,-36(s0)
    7574:	03000593          	li	a1,48
    7578:	853e                	mv	a0,a5
    757a:	00000097          	auipc	ra,0x0
    757e:	ea6080e7          	jalr	-346(ra) # 7420 <putc>
  putc(fd, 'x');
    7582:	fdc42783          	lw	a5,-36(s0)
    7586:	07800593          	li	a1,120
    758a:	853e                	mv	a0,a5
    758c:	00000097          	auipc	ra,0x0
    7590:	e94080e7          	jalr	-364(ra) # 7420 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    7594:	fe042623          	sw	zero,-20(s0)
    7598:	a82d                	j	75d2 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    759a:	fd043783          	ld	a5,-48(s0)
    759e:	93f1                	srli	a5,a5,0x3c
    75a0:	00003717          	auipc	a4,0x3
    75a4:	09070713          	addi	a4,a4,144 # a630 <digits>
    75a8:	97ba                	add	a5,a5,a4
    75aa:	0007c703          	lbu	a4,0(a5)
    75ae:	fdc42783          	lw	a5,-36(s0)
    75b2:	85ba                	mv	a1,a4
    75b4:	853e                	mv	a0,a5
    75b6:	00000097          	auipc	ra,0x0
    75ba:	e6a080e7          	jalr	-406(ra) # 7420 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    75be:	fec42783          	lw	a5,-20(s0)
    75c2:	2785                	addiw	a5,a5,1
    75c4:	fef42623          	sw	a5,-20(s0)
    75c8:	fd043783          	ld	a5,-48(s0)
    75cc:	0792                	slli	a5,a5,0x4
    75ce:	fcf43823          	sd	a5,-48(s0)
    75d2:	fec42783          	lw	a5,-20(s0)
    75d6:	873e                	mv	a4,a5
    75d8:	47bd                	li	a5,15
    75da:	fce7f0e3          	bgeu	a5,a4,759a <printptr+0x3c>
}
    75de:	0001                	nop
    75e0:	0001                	nop
    75e2:	70a2                	ld	ra,40(sp)
    75e4:	7402                	ld	s0,32(sp)
    75e6:	6145                	addi	sp,sp,48
    75e8:	8082                	ret

00000000000075ea <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    75ea:	715d                	addi	sp,sp,-80
    75ec:	e486                	sd	ra,72(sp)
    75ee:	e0a2                	sd	s0,64(sp)
    75f0:	0880                	addi	s0,sp,80
    75f2:	87aa                	mv	a5,a0
    75f4:	fcb43023          	sd	a1,-64(s0)
    75f8:	fac43c23          	sd	a2,-72(s0)
    75fc:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
    7600:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    7604:	fe042223          	sw	zero,-28(s0)
    7608:	a42d                	j	7832 <vprintf+0x248>
    c = fmt[i] & 0xff;
    760a:	fe442783          	lw	a5,-28(s0)
    760e:	fc043703          	ld	a4,-64(s0)
    7612:	97ba                	add	a5,a5,a4
    7614:	0007c783          	lbu	a5,0(a5)
    7618:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
    761c:	fe042783          	lw	a5,-32(s0)
    7620:	2781                	sext.w	a5,a5
    7622:	eb9d                	bnez	a5,7658 <vprintf+0x6e>
      if(c == '%'){
    7624:	fdc42783          	lw	a5,-36(s0)
    7628:	0007871b          	sext.w	a4,a5
    762c:	02500793          	li	a5,37
    7630:	00f71763          	bne	a4,a5,763e <vprintf+0x54>
        state = '%';
    7634:	02500793          	li	a5,37
    7638:	fef42023          	sw	a5,-32(s0)
    763c:	a2f5                	j	7828 <vprintf+0x23e>
      } else {
        putc(fd, c);
    763e:	fdc42783          	lw	a5,-36(s0)
    7642:	0ff7f713          	zext.b	a4,a5
    7646:	fcc42783          	lw	a5,-52(s0)
    764a:	85ba                	mv	a1,a4
    764c:	853e                	mv	a0,a5
    764e:	00000097          	auipc	ra,0x0
    7652:	dd2080e7          	jalr	-558(ra) # 7420 <putc>
    7656:	aac9                	j	7828 <vprintf+0x23e>
      }
    } else if(state == '%'){
    7658:	fe042783          	lw	a5,-32(s0)
    765c:	0007871b          	sext.w	a4,a5
    7660:	02500793          	li	a5,37
    7664:	1cf71263          	bne	a4,a5,7828 <vprintf+0x23e>
      if(c == 'd'){
    7668:	fdc42783          	lw	a5,-36(s0)
    766c:	0007871b          	sext.w	a4,a5
    7670:	06400793          	li	a5,100
    7674:	02f71463          	bne	a4,a5,769c <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
    7678:	fb843783          	ld	a5,-72(s0)
    767c:	00878713          	addi	a4,a5,8
    7680:	fae43c23          	sd	a4,-72(s0)
    7684:	4398                	lw	a4,0(a5)
    7686:	fcc42783          	lw	a5,-52(s0)
    768a:	4685                	li	a3,1
    768c:	4629                	li	a2,10
    768e:	85ba                	mv	a1,a4
    7690:	853e                	mv	a0,a5
    7692:	00000097          	auipc	ra,0x0
    7696:	dc4080e7          	jalr	-572(ra) # 7456 <printint>
    769a:	a269                	j	7824 <vprintf+0x23a>
      } else if(c == 'l') {
    769c:	fdc42783          	lw	a5,-36(s0)
    76a0:	0007871b          	sext.w	a4,a5
    76a4:	06c00793          	li	a5,108
    76a8:	02f71663          	bne	a4,a5,76d4 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
    76ac:	fb843783          	ld	a5,-72(s0)
    76b0:	00878713          	addi	a4,a5,8
    76b4:	fae43c23          	sd	a4,-72(s0)
    76b8:	639c                	ld	a5,0(a5)
    76ba:	0007871b          	sext.w	a4,a5
    76be:	fcc42783          	lw	a5,-52(s0)
    76c2:	4681                	li	a3,0
    76c4:	4629                	li	a2,10
    76c6:	85ba                	mv	a1,a4
    76c8:	853e                	mv	a0,a5
    76ca:	00000097          	auipc	ra,0x0
    76ce:	d8c080e7          	jalr	-628(ra) # 7456 <printint>
    76d2:	aa89                	j	7824 <vprintf+0x23a>
      } else if(c == 'x') {
    76d4:	fdc42783          	lw	a5,-36(s0)
    76d8:	0007871b          	sext.w	a4,a5
    76dc:	07800793          	li	a5,120
    76e0:	02f71463          	bne	a4,a5,7708 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
    76e4:	fb843783          	ld	a5,-72(s0)
    76e8:	00878713          	addi	a4,a5,8
    76ec:	fae43c23          	sd	a4,-72(s0)
    76f0:	4398                	lw	a4,0(a5)
    76f2:	fcc42783          	lw	a5,-52(s0)
    76f6:	4681                	li	a3,0
    76f8:	4641                	li	a2,16
    76fa:	85ba                	mv	a1,a4
    76fc:	853e                	mv	a0,a5
    76fe:	00000097          	auipc	ra,0x0
    7702:	d58080e7          	jalr	-680(ra) # 7456 <printint>
    7706:	aa39                	j	7824 <vprintf+0x23a>
      } else if(c == 'p') {
    7708:	fdc42783          	lw	a5,-36(s0)
    770c:	0007871b          	sext.w	a4,a5
    7710:	07000793          	li	a5,112
    7714:	02f71263          	bne	a4,a5,7738 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
    7718:	fb843783          	ld	a5,-72(s0)
    771c:	00878713          	addi	a4,a5,8
    7720:	fae43c23          	sd	a4,-72(s0)
    7724:	6398                	ld	a4,0(a5)
    7726:	fcc42783          	lw	a5,-52(s0)
    772a:	85ba                	mv	a1,a4
    772c:	853e                	mv	a0,a5
    772e:	00000097          	auipc	ra,0x0
    7732:	e30080e7          	jalr	-464(ra) # 755e <printptr>
    7736:	a0fd                	j	7824 <vprintf+0x23a>
      } else if(c == 's'){
    7738:	fdc42783          	lw	a5,-36(s0)
    773c:	0007871b          	sext.w	a4,a5
    7740:	07300793          	li	a5,115
    7744:	04f71c63          	bne	a4,a5,779c <vprintf+0x1b2>
        s = va_arg(ap, char*);
    7748:	fb843783          	ld	a5,-72(s0)
    774c:	00878713          	addi	a4,a5,8
    7750:	fae43c23          	sd	a4,-72(s0)
    7754:	639c                	ld	a5,0(a5)
    7756:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
    775a:	fe843783          	ld	a5,-24(s0)
    775e:	eb8d                	bnez	a5,7790 <vprintf+0x1a6>
          s = "(null)";
    7760:	00003797          	auipc	a5,0x3
    7764:	e7878793          	addi	a5,a5,-392 # a5d8 <cv_init+0x2852>
    7768:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    776c:	a015                	j	7790 <vprintf+0x1a6>
          putc(fd, *s);
    776e:	fe843783          	ld	a5,-24(s0)
    7772:	0007c703          	lbu	a4,0(a5)
    7776:	fcc42783          	lw	a5,-52(s0)
    777a:	85ba                	mv	a1,a4
    777c:	853e                	mv	a0,a5
    777e:	00000097          	auipc	ra,0x0
    7782:	ca2080e7          	jalr	-862(ra) # 7420 <putc>
          s++;
    7786:	fe843783          	ld	a5,-24(s0)
    778a:	0785                	addi	a5,a5,1
    778c:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    7790:	fe843783          	ld	a5,-24(s0)
    7794:	0007c783          	lbu	a5,0(a5)
    7798:	fbf9                	bnez	a5,776e <vprintf+0x184>
    779a:	a069                	j	7824 <vprintf+0x23a>
        }
      } else if(c == 'c'){
    779c:	fdc42783          	lw	a5,-36(s0)
    77a0:	0007871b          	sext.w	a4,a5
    77a4:	06300793          	li	a5,99
    77a8:	02f71463          	bne	a4,a5,77d0 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
    77ac:	fb843783          	ld	a5,-72(s0)
    77b0:	00878713          	addi	a4,a5,8
    77b4:	fae43c23          	sd	a4,-72(s0)
    77b8:	439c                	lw	a5,0(a5)
    77ba:	0ff7f713          	zext.b	a4,a5
    77be:	fcc42783          	lw	a5,-52(s0)
    77c2:	85ba                	mv	a1,a4
    77c4:	853e                	mv	a0,a5
    77c6:	00000097          	auipc	ra,0x0
    77ca:	c5a080e7          	jalr	-934(ra) # 7420 <putc>
    77ce:	a899                	j	7824 <vprintf+0x23a>
      } else if(c == '%'){
    77d0:	fdc42783          	lw	a5,-36(s0)
    77d4:	0007871b          	sext.w	a4,a5
    77d8:	02500793          	li	a5,37
    77dc:	00f71f63          	bne	a4,a5,77fa <vprintf+0x210>
        putc(fd, c);
    77e0:	fdc42783          	lw	a5,-36(s0)
    77e4:	0ff7f713          	zext.b	a4,a5
    77e8:	fcc42783          	lw	a5,-52(s0)
    77ec:	85ba                	mv	a1,a4
    77ee:	853e                	mv	a0,a5
    77f0:	00000097          	auipc	ra,0x0
    77f4:	c30080e7          	jalr	-976(ra) # 7420 <putc>
    77f8:	a035                	j	7824 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    77fa:	fcc42783          	lw	a5,-52(s0)
    77fe:	02500593          	li	a1,37
    7802:	853e                	mv	a0,a5
    7804:	00000097          	auipc	ra,0x0
    7808:	c1c080e7          	jalr	-996(ra) # 7420 <putc>
        putc(fd, c);
    780c:	fdc42783          	lw	a5,-36(s0)
    7810:	0ff7f713          	zext.b	a4,a5
    7814:	fcc42783          	lw	a5,-52(s0)
    7818:	85ba                	mv	a1,a4
    781a:	853e                	mv	a0,a5
    781c:	00000097          	auipc	ra,0x0
    7820:	c04080e7          	jalr	-1020(ra) # 7420 <putc>
      }
      state = 0;
    7824:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    7828:	fe442783          	lw	a5,-28(s0)
    782c:	2785                	addiw	a5,a5,1
    782e:	fef42223          	sw	a5,-28(s0)
    7832:	fe442783          	lw	a5,-28(s0)
    7836:	fc043703          	ld	a4,-64(s0)
    783a:	97ba                	add	a5,a5,a4
    783c:	0007c783          	lbu	a5,0(a5)
    7840:	dc0795e3          	bnez	a5,760a <vprintf+0x20>
    }
  }
}
    7844:	0001                	nop
    7846:	0001                	nop
    7848:	60a6                	ld	ra,72(sp)
    784a:	6406                	ld	s0,64(sp)
    784c:	6161                	addi	sp,sp,80
    784e:	8082                	ret

0000000000007850 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    7850:	7159                	addi	sp,sp,-112
    7852:	fc06                	sd	ra,56(sp)
    7854:	f822                	sd	s0,48(sp)
    7856:	0080                	addi	s0,sp,64
    7858:	fcb43823          	sd	a1,-48(s0)
    785c:	e010                	sd	a2,0(s0)
    785e:	e414                	sd	a3,8(s0)
    7860:	e818                	sd	a4,16(s0)
    7862:	ec1c                	sd	a5,24(s0)
    7864:	03043023          	sd	a6,32(s0)
    7868:	03143423          	sd	a7,40(s0)
    786c:	87aa                	mv	a5,a0
    786e:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    7872:	03040793          	addi	a5,s0,48
    7876:	fcf43423          	sd	a5,-56(s0)
    787a:	fc843783          	ld	a5,-56(s0)
    787e:	fd078793          	addi	a5,a5,-48
    7882:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    7886:	fe843703          	ld	a4,-24(s0)
    788a:	fdc42783          	lw	a5,-36(s0)
    788e:	863a                	mv	a2,a4
    7890:	fd043583          	ld	a1,-48(s0)
    7894:	853e                	mv	a0,a5
    7896:	00000097          	auipc	ra,0x0
    789a:	d54080e7          	jalr	-684(ra) # 75ea <vprintf>
}
    789e:	0001                	nop
    78a0:	70e2                	ld	ra,56(sp)
    78a2:	7442                	ld	s0,48(sp)
    78a4:	6165                	addi	sp,sp,112
    78a6:	8082                	ret

00000000000078a8 <printf>:

void
printf(const char *fmt, ...)
{
    78a8:	7159                	addi	sp,sp,-112
    78aa:	f406                	sd	ra,40(sp)
    78ac:	f022                	sd	s0,32(sp)
    78ae:	1800                	addi	s0,sp,48
    78b0:	fca43c23          	sd	a0,-40(s0)
    78b4:	e40c                	sd	a1,8(s0)
    78b6:	e810                	sd	a2,16(s0)
    78b8:	ec14                	sd	a3,24(s0)
    78ba:	f018                	sd	a4,32(s0)
    78bc:	f41c                	sd	a5,40(s0)
    78be:	03043823          	sd	a6,48(s0)
    78c2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    78c6:	04040793          	addi	a5,s0,64
    78ca:	fcf43823          	sd	a5,-48(s0)
    78ce:	fd043783          	ld	a5,-48(s0)
    78d2:	fc878793          	addi	a5,a5,-56
    78d6:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    78da:	fe843783          	ld	a5,-24(s0)
    78de:	863e                	mv	a2,a5
    78e0:	fd843583          	ld	a1,-40(s0)
    78e4:	4505                	li	a0,1
    78e6:	00000097          	auipc	ra,0x0
    78ea:	d04080e7          	jalr	-764(ra) # 75ea <vprintf>
}
    78ee:	0001                	nop
    78f0:	70a2                	ld	ra,40(sp)
    78f2:	7402                	ld	s0,32(sp)
    78f4:	6165                	addi	sp,sp,112
    78f6:	8082                	ret

00000000000078f8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    78f8:	7179                	addi	sp,sp,-48
    78fa:	f422                	sd	s0,40(sp)
    78fc:	1800                	addi	s0,sp,48
    78fe:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    7902:	fd843783          	ld	a5,-40(s0)
    7906:	17c1                	addi	a5,a5,-16
    7908:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    790c:	00009797          	auipc	a5,0x9
    7910:	56478793          	addi	a5,a5,1380 # 10e70 <freep>
    7914:	639c                	ld	a5,0(a5)
    7916:	fef43423          	sd	a5,-24(s0)
    791a:	a815                	j	794e <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    791c:	fe843783          	ld	a5,-24(s0)
    7920:	639c                	ld	a5,0(a5)
    7922:	fe843703          	ld	a4,-24(s0)
    7926:	00f76f63          	bltu	a4,a5,7944 <free+0x4c>
    792a:	fe043703          	ld	a4,-32(s0)
    792e:	fe843783          	ld	a5,-24(s0)
    7932:	02e7eb63          	bltu	a5,a4,7968 <free+0x70>
    7936:	fe843783          	ld	a5,-24(s0)
    793a:	639c                	ld	a5,0(a5)
    793c:	fe043703          	ld	a4,-32(s0)
    7940:	02f76463          	bltu	a4,a5,7968 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    7944:	fe843783          	ld	a5,-24(s0)
    7948:	639c                	ld	a5,0(a5)
    794a:	fef43423          	sd	a5,-24(s0)
    794e:	fe043703          	ld	a4,-32(s0)
    7952:	fe843783          	ld	a5,-24(s0)
    7956:	fce7f3e3          	bgeu	a5,a4,791c <free+0x24>
    795a:	fe843783          	ld	a5,-24(s0)
    795e:	639c                	ld	a5,0(a5)
    7960:	fe043703          	ld	a4,-32(s0)
    7964:	faf77ce3          	bgeu	a4,a5,791c <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    7968:	fe043783          	ld	a5,-32(s0)
    796c:	479c                	lw	a5,8(a5)
    796e:	1782                	slli	a5,a5,0x20
    7970:	9381                	srli	a5,a5,0x20
    7972:	0792                	slli	a5,a5,0x4
    7974:	fe043703          	ld	a4,-32(s0)
    7978:	973e                	add	a4,a4,a5
    797a:	fe843783          	ld	a5,-24(s0)
    797e:	639c                	ld	a5,0(a5)
    7980:	02f71763          	bne	a4,a5,79ae <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    7984:	fe043783          	ld	a5,-32(s0)
    7988:	4798                	lw	a4,8(a5)
    798a:	fe843783          	ld	a5,-24(s0)
    798e:	639c                	ld	a5,0(a5)
    7990:	479c                	lw	a5,8(a5)
    7992:	9fb9                	addw	a5,a5,a4
    7994:	0007871b          	sext.w	a4,a5
    7998:	fe043783          	ld	a5,-32(s0)
    799c:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    799e:	fe843783          	ld	a5,-24(s0)
    79a2:	639c                	ld	a5,0(a5)
    79a4:	6398                	ld	a4,0(a5)
    79a6:	fe043783          	ld	a5,-32(s0)
    79aa:	e398                	sd	a4,0(a5)
    79ac:	a039                	j	79ba <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    79ae:	fe843783          	ld	a5,-24(s0)
    79b2:	6398                	ld	a4,0(a5)
    79b4:	fe043783          	ld	a5,-32(s0)
    79b8:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    79ba:	fe843783          	ld	a5,-24(s0)
    79be:	479c                	lw	a5,8(a5)
    79c0:	1782                	slli	a5,a5,0x20
    79c2:	9381                	srli	a5,a5,0x20
    79c4:	0792                	slli	a5,a5,0x4
    79c6:	fe843703          	ld	a4,-24(s0)
    79ca:	97ba                	add	a5,a5,a4
    79cc:	fe043703          	ld	a4,-32(s0)
    79d0:	02f71563          	bne	a4,a5,79fa <free+0x102>
    p->s.size += bp->s.size;
    79d4:	fe843783          	ld	a5,-24(s0)
    79d8:	4798                	lw	a4,8(a5)
    79da:	fe043783          	ld	a5,-32(s0)
    79de:	479c                	lw	a5,8(a5)
    79e0:	9fb9                	addw	a5,a5,a4
    79e2:	0007871b          	sext.w	a4,a5
    79e6:	fe843783          	ld	a5,-24(s0)
    79ea:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    79ec:	fe043783          	ld	a5,-32(s0)
    79f0:	6398                	ld	a4,0(a5)
    79f2:	fe843783          	ld	a5,-24(s0)
    79f6:	e398                	sd	a4,0(a5)
    79f8:	a031                	j	7a04 <free+0x10c>
  } else
    p->s.ptr = bp;
    79fa:	fe843783          	ld	a5,-24(s0)
    79fe:	fe043703          	ld	a4,-32(s0)
    7a02:	e398                	sd	a4,0(a5)
  freep = p;
    7a04:	00009797          	auipc	a5,0x9
    7a08:	46c78793          	addi	a5,a5,1132 # 10e70 <freep>
    7a0c:	fe843703          	ld	a4,-24(s0)
    7a10:	e398                	sd	a4,0(a5)
}
    7a12:	0001                	nop
    7a14:	7422                	ld	s0,40(sp)
    7a16:	6145                	addi	sp,sp,48
    7a18:	8082                	ret

0000000000007a1a <morecore>:

static Header*
morecore(uint nu)
{
    7a1a:	7179                	addi	sp,sp,-48
    7a1c:	f406                	sd	ra,40(sp)
    7a1e:	f022                	sd	s0,32(sp)
    7a20:	1800                	addi	s0,sp,48
    7a22:	87aa                	mv	a5,a0
    7a24:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    7a28:	fdc42783          	lw	a5,-36(s0)
    7a2c:	0007871b          	sext.w	a4,a5
    7a30:	6785                	lui	a5,0x1
    7a32:	00f77563          	bgeu	a4,a5,7a3c <morecore+0x22>
    nu = 4096;
    7a36:	6785                	lui	a5,0x1
    7a38:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    7a3c:	fdc42783          	lw	a5,-36(s0)
    7a40:	0047979b          	slliw	a5,a5,0x4
    7a44:	2781                	sext.w	a5,a5
    7a46:	2781                	sext.w	a5,a5
    7a48:	853e                	mv	a0,a5
    7a4a:	00000097          	auipc	ra,0x0
    7a4e:	9ae080e7          	jalr	-1618(ra) # 73f8 <sbrk>
    7a52:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    7a56:	fe843703          	ld	a4,-24(s0)
    7a5a:	57fd                	li	a5,-1
    7a5c:	00f71463          	bne	a4,a5,7a64 <morecore+0x4a>
    return 0;
    7a60:	4781                	li	a5,0
    7a62:	a03d                	j	7a90 <morecore+0x76>
  hp = (Header*)p;
    7a64:	fe843783          	ld	a5,-24(s0)
    7a68:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    7a6c:	fe043783          	ld	a5,-32(s0)
    7a70:	fdc42703          	lw	a4,-36(s0)
    7a74:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    7a76:	fe043783          	ld	a5,-32(s0)
    7a7a:	07c1                	addi	a5,a5,16
    7a7c:	853e                	mv	a0,a5
    7a7e:	00000097          	auipc	ra,0x0
    7a82:	e7a080e7          	jalr	-390(ra) # 78f8 <free>
  return freep;
    7a86:	00009797          	auipc	a5,0x9
    7a8a:	3ea78793          	addi	a5,a5,1002 # 10e70 <freep>
    7a8e:	639c                	ld	a5,0(a5)
}
    7a90:	853e                	mv	a0,a5
    7a92:	70a2                	ld	ra,40(sp)
    7a94:	7402                	ld	s0,32(sp)
    7a96:	6145                	addi	sp,sp,48
    7a98:	8082                	ret

0000000000007a9a <malloc>:

void*
malloc(uint nbytes)
{
    7a9a:	7139                	addi	sp,sp,-64
    7a9c:	fc06                	sd	ra,56(sp)
    7a9e:	f822                	sd	s0,48(sp)
    7aa0:	0080                	addi	s0,sp,64
    7aa2:	87aa                	mv	a5,a0
    7aa4:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    7aa8:	fcc46783          	lwu	a5,-52(s0)
    7aac:	07bd                	addi	a5,a5,15
    7aae:	8391                	srli	a5,a5,0x4
    7ab0:	2781                	sext.w	a5,a5
    7ab2:	2785                	addiw	a5,a5,1
    7ab4:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    7ab8:	00009797          	auipc	a5,0x9
    7abc:	3b878793          	addi	a5,a5,952 # 10e70 <freep>
    7ac0:	639c                	ld	a5,0(a5)
    7ac2:	fef43023          	sd	a5,-32(s0)
    7ac6:	fe043783          	ld	a5,-32(s0)
    7aca:	ef95                	bnez	a5,7b06 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    7acc:	00009797          	auipc	a5,0x9
    7ad0:	39478793          	addi	a5,a5,916 # 10e60 <base>
    7ad4:	fef43023          	sd	a5,-32(s0)
    7ad8:	00009797          	auipc	a5,0x9
    7adc:	39878793          	addi	a5,a5,920 # 10e70 <freep>
    7ae0:	fe043703          	ld	a4,-32(s0)
    7ae4:	e398                	sd	a4,0(a5)
    7ae6:	00009797          	auipc	a5,0x9
    7aea:	38a78793          	addi	a5,a5,906 # 10e70 <freep>
    7aee:	6398                	ld	a4,0(a5)
    7af0:	00009797          	auipc	a5,0x9
    7af4:	37078793          	addi	a5,a5,880 # 10e60 <base>
    7af8:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    7afa:	00009797          	auipc	a5,0x9
    7afe:	36678793          	addi	a5,a5,870 # 10e60 <base>
    7b02:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    7b06:	fe043783          	ld	a5,-32(s0)
    7b0a:	639c                	ld	a5,0(a5)
    7b0c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    7b10:	fe843783          	ld	a5,-24(s0)
    7b14:	4798                	lw	a4,8(a5)
    7b16:	fdc42783          	lw	a5,-36(s0)
    7b1a:	2781                	sext.w	a5,a5
    7b1c:	06f76763          	bltu	a4,a5,7b8a <malloc+0xf0>
      if(p->s.size == nunits)
    7b20:	fe843783          	ld	a5,-24(s0)
    7b24:	4798                	lw	a4,8(a5)
    7b26:	fdc42783          	lw	a5,-36(s0)
    7b2a:	2781                	sext.w	a5,a5
    7b2c:	00e79963          	bne	a5,a4,7b3e <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    7b30:	fe843783          	ld	a5,-24(s0)
    7b34:	6398                	ld	a4,0(a5)
    7b36:	fe043783          	ld	a5,-32(s0)
    7b3a:	e398                	sd	a4,0(a5)
    7b3c:	a825                	j	7b74 <malloc+0xda>
      else {
        p->s.size -= nunits;
    7b3e:	fe843783          	ld	a5,-24(s0)
    7b42:	479c                	lw	a5,8(a5)
    7b44:	fdc42703          	lw	a4,-36(s0)
    7b48:	9f99                	subw	a5,a5,a4
    7b4a:	0007871b          	sext.w	a4,a5
    7b4e:	fe843783          	ld	a5,-24(s0)
    7b52:	c798                	sw	a4,8(a5)
        p += p->s.size;
    7b54:	fe843783          	ld	a5,-24(s0)
    7b58:	479c                	lw	a5,8(a5)
    7b5a:	1782                	slli	a5,a5,0x20
    7b5c:	9381                	srli	a5,a5,0x20
    7b5e:	0792                	slli	a5,a5,0x4
    7b60:	fe843703          	ld	a4,-24(s0)
    7b64:	97ba                	add	a5,a5,a4
    7b66:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    7b6a:	fe843783          	ld	a5,-24(s0)
    7b6e:	fdc42703          	lw	a4,-36(s0)
    7b72:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    7b74:	00009797          	auipc	a5,0x9
    7b78:	2fc78793          	addi	a5,a5,764 # 10e70 <freep>
    7b7c:	fe043703          	ld	a4,-32(s0)
    7b80:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    7b82:	fe843783          	ld	a5,-24(s0)
    7b86:	07c1                	addi	a5,a5,16
    7b88:	a091                	j	7bcc <malloc+0x132>
    }
    if(p == freep)
    7b8a:	00009797          	auipc	a5,0x9
    7b8e:	2e678793          	addi	a5,a5,742 # 10e70 <freep>
    7b92:	639c                	ld	a5,0(a5)
    7b94:	fe843703          	ld	a4,-24(s0)
    7b98:	02f71063          	bne	a4,a5,7bb8 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    7b9c:	fdc42783          	lw	a5,-36(s0)
    7ba0:	853e                	mv	a0,a5
    7ba2:	00000097          	auipc	ra,0x0
    7ba6:	e78080e7          	jalr	-392(ra) # 7a1a <morecore>
    7baa:	fea43423          	sd	a0,-24(s0)
    7bae:	fe843783          	ld	a5,-24(s0)
    7bb2:	e399                	bnez	a5,7bb8 <malloc+0x11e>
        return 0;
    7bb4:	4781                	li	a5,0
    7bb6:	a819                	j	7bcc <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    7bb8:	fe843783          	ld	a5,-24(s0)
    7bbc:	fef43023          	sd	a5,-32(s0)
    7bc0:	fe843783          	ld	a5,-24(s0)
    7bc4:	639c                	ld	a5,0(a5)
    7bc6:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    7bca:	b799                	j	7b10 <malloc+0x76>
  }
}
    7bcc:	853e                	mv	a0,a5
    7bce:	70e2                	ld	ra,56(sp)
    7bd0:	7442                	ld	s0,48(sp)
    7bd2:	6121                	addi	sp,sp,64
    7bd4:	8082                	ret

0000000000007bd6 <thread_create>:
typedef uint cont_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
    7bd6:	7179                	addi	sp,sp,-48
    7bd8:	f406                	sd	ra,40(sp)
    7bda:	f022                	sd	s0,32(sp)
    7bdc:	1800                	addi	s0,sp,48
    7bde:	fca43c23          	sd	a0,-40(s0)
    7be2:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
    7be6:	6505                	lui	a0,0x1
    7be8:	00000097          	auipc	ra,0x0
    7bec:	eb2080e7          	jalr	-334(ra) # 7a9a <malloc>
    7bf0:	fea43423          	sd	a0,-24(s0)
    7bf4:	fe843783          	ld	a5,-24(s0)
    7bf8:	e38d                	bnez	a5,7c1a <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
    7bfa:	00003517          	auipc	a0,0x3
    7bfe:	9e650513          	addi	a0,a0,-1562 # a5e0 <cv_init+0x285a>
    7c02:	00000097          	auipc	ra,0x0
    7c06:	ca6080e7          	jalr	-858(ra) # 78a8 <printf>
        free(stack);
    7c0a:	fe843503          	ld	a0,-24(s0)
    7c0e:	00000097          	auipc	ra,0x0
    7c12:	cea080e7          	jalr	-790(ra) # 78f8 <free>
        return -1;
    7c16:	57fd                	li	a5,-1
    7c18:	a099                	j	7c5e <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
    7c1a:	fe843783          	ld	a5,-24(s0)
    7c1e:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
    7c22:	fe043703          	ld	a4,-32(s0)
    7c26:	6785                	lui	a5,0x1
    7c28:	17fd                	addi	a5,a5,-1
    7c2a:	8ff9                	and	a5,a5,a4
    7c2c:	cf91                	beqz	a5,7c48 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
    7c2e:	fe043703          	ld	a4,-32(s0)
    7c32:	6785                	lui	a5,0x1
    7c34:	17fd                	addi	a5,a5,-1
    7c36:	8ff9                	and	a5,a5,a4
    7c38:	6705                	lui	a4,0x1
    7c3a:	40f707b3          	sub	a5,a4,a5
    7c3e:	fe843703          	ld	a4,-24(s0)
    7c42:	97ba                	add	a5,a5,a4
    7c44:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
    7c48:	fe843603          	ld	a2,-24(s0)
    7c4c:	fd043583          	ld	a1,-48(s0)
    7c50:	fd843503          	ld	a0,-40(s0)
    7c54:	fffff097          	auipc	ra,0xfffff
    7c58:	7bc080e7          	jalr	1980(ra) # 7410 <clone>
    7c5c:	87aa                	mv	a5,a0
}
    7c5e:	853e                	mv	a0,a5
    7c60:	70a2                	ld	ra,40(sp)
    7c62:	7402                	ld	s0,32(sp)
    7c64:	6145                	addi	sp,sp,48
    7c66:	8082                	ret

0000000000007c68 <thread_join>:


int thread_join()
{
    7c68:	1101                	addi	sp,sp,-32
    7c6a:	ec06                	sd	ra,24(sp)
    7c6c:	e822                	sd	s0,16(sp)
    7c6e:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
    7c70:	fe040793          	addi	a5,s0,-32
    7c74:	853e                	mv	a0,a5
    7c76:	fffff097          	auipc	ra,0xfffff
    7c7a:	7a2080e7          	jalr	1954(ra) # 7418 <join>
    7c7e:	87aa                	mv	a5,a0
    7c80:	fef42623          	sw	a5,-20(s0)
    7c84:	fec42783          	lw	a5,-20(s0)
    7c88:	0007871b          	sext.w	a4,a5
    7c8c:	57fd                	li	a5,-1
    7c8e:	00f70963          	beq	a4,a5,7ca0 <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
    7c92:	fe043783          	ld	a5,-32(s0)
    7c96:	853e                	mv	a0,a5
    7c98:	00000097          	auipc	ra,0x0
    7c9c:	c60080e7          	jalr	-928(ra) # 78f8 <free>
    } 

    return child_tid;
    7ca0:	fec42783          	lw	a5,-20(s0)
}
    7ca4:	853e                	mv	a0,a5
    7ca6:	60e2                	ld	ra,24(sp)
    7ca8:	6442                	ld	s0,16(sp)
    7caa:	6105                	addi	sp,sp,32
    7cac:	8082                	ret

0000000000007cae <lock_acquire>:


void lock_acquire (lock_t *lock){
    7cae:	1101                	addi	sp,sp,-32
    7cb0:	ec22                	sd	s0,24(sp)
    7cb2:	1000                	addi	s0,sp,32
    7cb4:	fea43423          	sd	a0,-24(s0)
    while( __sync_lock_test_and_set(lock, 1)!=0){
    7cb8:	0001                	nop
    7cba:	fe843783          	ld	a5,-24(s0)
    7cbe:	4705                	li	a4,1
    7cc0:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    7cc4:	0007079b          	sext.w	a5,a4
    7cc8:	fbed                	bnez	a5,7cba <lock_acquire+0xc>

    ;
    }
     __sync_synchronize();
    7cca:	0ff0000f          	fence
        

}
    7cce:	0001                	nop
    7cd0:	6462                	ld	s0,24(sp)
    7cd2:	6105                	addi	sp,sp,32
    7cd4:	8082                	ret

0000000000007cd6 <lock_release>:

void lock_release (lock_t *lock){
    7cd6:	1101                	addi	sp,sp,-32
    7cd8:	ec22                	sd	s0,24(sp)
    7cda:	1000                	addi	s0,sp,32
    7cdc:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
    7ce0:	0ff0000f          	fence
    __sync_lock_release(lock);
    7ce4:	fe843783          	ld	a5,-24(s0)
    7ce8:	0f50000f          	fence	iorw,ow
    7cec:	0807a02f          	amoswap.w	zero,zero,(a5)
   
}
    7cf0:	0001                	nop
    7cf2:	6462                	ld	s0,24(sp)
    7cf4:	6105                	addi	sp,sp,32
    7cf6:	8082                	ret

0000000000007cf8 <lock_init>:

void lock_init (lock_t *lock){
    7cf8:	1101                	addi	sp,sp,-32
    7cfa:	ec22                	sd	s0,24(sp)
    7cfc:	1000                	addi	s0,sp,32
    7cfe:	fea43423          	sd	a0,-24(s0)
    lock = 0;
    7d02:	fe043423          	sd	zero,-24(s0)
    
}
    7d06:	0001                	nop
    7d08:	6462                	ld	s0,24(sp)
    7d0a:	6105                	addi	sp,sp,32
    7d0c:	8082                	ret

0000000000007d0e <cv_wait>:


void cv_wait (cont_t *cv, lock_t *lock){
    7d0e:	1101                	addi	sp,sp,-32
    7d10:	ec06                	sd	ra,24(sp)
    7d12:	e822                	sd	s0,16(sp)
    7d14:	1000                	addi	s0,sp,32
    7d16:	fea43423          	sd	a0,-24(s0)
    7d1a:	feb43023          	sd	a1,-32(s0)
    while( __sync_lock_test_and_set(cv, 0)!=1){
    7d1e:	a015                	j	7d42 <cv_wait+0x34>
        lock_release(lock);
    7d20:	fe043503          	ld	a0,-32(s0)
    7d24:	00000097          	auipc	ra,0x0
    7d28:	fb2080e7          	jalr	-78(ra) # 7cd6 <lock_release>
        sleep(1);
    7d2c:	4505                	li	a0,1
    7d2e:	fffff097          	auipc	ra,0xfffff
    7d32:	6d2080e7          	jalr	1746(ra) # 7400 <sleep>
        lock_acquire(lock);
    7d36:	fe043503          	ld	a0,-32(s0)
    7d3a:	00000097          	auipc	ra,0x0
    7d3e:	f74080e7          	jalr	-140(ra) # 7cae <lock_acquire>
    while( __sync_lock_test_and_set(cv, 0)!=1){
    7d42:	fe843783          	ld	a5,-24(s0)
    7d46:	4701                	li	a4,0
    7d48:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    7d4c:	0007079b          	sext.w	a5,a4
    7d50:	873e                	mv	a4,a5
    7d52:	4785                	li	a5,1
    7d54:	fcf716e3          	bne	a4,a5,7d20 <cv_wait+0x12>
    }

     __sync_synchronize();
    7d58:	0ff0000f          	fence

}
    7d5c:	0001                	nop
    7d5e:	60e2                	ld	ra,24(sp)
    7d60:	6442                	ld	s0,16(sp)
    7d62:	6105                	addi	sp,sp,32
    7d64:	8082                	ret

0000000000007d66 <cv_signal>:


void cv_signal (cont_t *cv){
    7d66:	1101                	addi	sp,sp,-32
    7d68:	ec22                	sd	s0,24(sp)
    7d6a:	1000                	addi	s0,sp,32
    7d6c:	fea43423          	sd	a0,-24(s0)
     __sync_synchronize();
    7d70:	0ff0000f          	fence
     __sync_lock_test_and_set(cv, 1);
    7d74:	fe843783          	ld	a5,-24(s0)
    7d78:	4705                	li	a4,1
    7d7a:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)

}
    7d7e:	0001                	nop
    7d80:	6462                	ld	s0,24(sp)
    7d82:	6105                	addi	sp,sp,32
    7d84:	8082                	ret

0000000000007d86 <cv_init>:


void cv_init (cont_t *cv){
    7d86:	1101                	addi	sp,sp,-32
    7d88:	ec22                	sd	s0,24(sp)
    7d8a:	1000                	addi	s0,sp,32
    7d8c:	fea43423          	sd	a0,-24(s0)
    cv = 0;
    7d90:	fe043423          	sd	zero,-24(s0)
    7d94:	0001                	nop
    7d96:	6462                	ld	s0,24(sp)
    7d98:	6105                	addi	sp,sp,32
    7d9a:	8082                	ret
