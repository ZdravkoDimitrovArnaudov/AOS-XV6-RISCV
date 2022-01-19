
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	715d                	addi	sp,sp,-80
       2:	e486                	sd	ra,72(sp)
       4:	e0a2                	sd	s0,64(sp)
       6:	0880                	addi	s0,sp,80
       8:	faa43c23          	sd	a0,-72(s0)
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       c:	fb843783          	ld	a5,-72(s0)
      10:	e791                	bnez	a5,1c <runcmd+0x1c>
    exit(1);
      12:	4505                	li	a0,1
      14:	00001097          	auipc	ra,0x1
      18:	3da080e7          	jalr	986(ra) # 13ee <exit>

  switch(cmd->type){
      1c:	fb843783          	ld	a5,-72(s0)
      20:	439c                	lw	a5,0(a5)
      22:	86be                	mv	a3,a5
      24:	4715                	li	a4,5
      26:	02d76263          	bltu	a4,a3,4a <runcmd+0x4a>
      2a:	00279713          	slli	a4,a5,0x2
      2e:	00002797          	auipc	a5,0x2
      32:	d7a78793          	addi	a5,a5,-646 # 1da8 <lock_init+0x4a>
      36:	97ba                	add	a5,a5,a4
      38:	439c                	lw	a5,0(a5)
      3a:	0007871b          	sext.w	a4,a5
      3e:	00002797          	auipc	a5,0x2
      42:	d6a78793          	addi	a5,a5,-662 # 1da8 <lock_init+0x4a>
      46:	97ba                	add	a5,a5,a4
      48:	8782                	jr	a5
  default:
    panic("runcmd");
      4a:	00002517          	auipc	a0,0x2
      4e:	d2e50513          	addi	a0,a0,-722 # 1d78 <lock_init+0x1a>
      52:	00000097          	auipc	ra,0x0
      56:	3d8080e7          	jalr	984(ra) # 42a <panic>

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      5a:	fb843783          	ld	a5,-72(s0)
      5e:	fcf43423          	sd	a5,-56(s0)
    if(ecmd->argv[0] == 0)
      62:	fc843783          	ld	a5,-56(s0)
      66:	679c                	ld	a5,8(a5)
      68:	e791                	bnez	a5,74 <runcmd+0x74>
      exit(1);
      6a:	4505                	li	a0,1
      6c:	00001097          	auipc	ra,0x1
      70:	382080e7          	jalr	898(ra) # 13ee <exit>
    exec(ecmd->argv[0], ecmd->argv);
      74:	fc843783          	ld	a5,-56(s0)
      78:	6798                	ld	a4,8(a5)
      7a:	fc843783          	ld	a5,-56(s0)
      7e:	07a1                	addi	a5,a5,8
      80:	85be                	mv	a1,a5
      82:	853a                	mv	a0,a4
      84:	00001097          	auipc	ra,0x1
      88:	3a2080e7          	jalr	930(ra) # 1426 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
      8c:	fc843783          	ld	a5,-56(s0)
      90:	679c                	ld	a5,8(a5)
      92:	863e                	mv	a2,a5
      94:	00002597          	auipc	a1,0x2
      98:	cec58593          	addi	a1,a1,-788 # 1d80 <lock_init+0x22>
      9c:	4509                	li	a0,2
      9e:	00002097          	auipc	ra,0x2
      a2:	830080e7          	jalr	-2000(ra) # 18ce <fprintf>
    break;
      a6:	aac9                	j	278 <runcmd+0x278>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      a8:	fb843783          	ld	a5,-72(s0)
      ac:	fcf43823          	sd	a5,-48(s0)
    close(rcmd->fd);
      b0:	fd043783          	ld	a5,-48(s0)
      b4:	53dc                	lw	a5,36(a5)
      b6:	853e                	mv	a0,a5
      b8:	00001097          	auipc	ra,0x1
      bc:	35e080e7          	jalr	862(ra) # 1416 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      c0:	fd043783          	ld	a5,-48(s0)
      c4:	6b98                	ld	a4,16(a5)
      c6:	fd043783          	ld	a5,-48(s0)
      ca:	539c                	lw	a5,32(a5)
      cc:	85be                	mv	a1,a5
      ce:	853a                	mv	a0,a4
      d0:	00001097          	auipc	ra,0x1
      d4:	35e080e7          	jalr	862(ra) # 142e <open>
      d8:	87aa                	mv	a5,a0
      da:	0207d463          	bgez	a5,102 <runcmd+0x102>
      fprintf(2, "open %s failed\n", rcmd->file);
      de:	fd043783          	ld	a5,-48(s0)
      e2:	6b9c                	ld	a5,16(a5)
      e4:	863e                	mv	a2,a5
      e6:	00002597          	auipc	a1,0x2
      ea:	caa58593          	addi	a1,a1,-854 # 1d90 <lock_init+0x32>
      ee:	4509                	li	a0,2
      f0:	00001097          	auipc	ra,0x1
      f4:	7de080e7          	jalr	2014(ra) # 18ce <fprintf>
      exit(1);
      f8:	4505                	li	a0,1
      fa:	00001097          	auipc	ra,0x1
      fe:	2f4080e7          	jalr	756(ra) # 13ee <exit>
    }
    runcmd(rcmd->cmd);
     102:	fd043783          	ld	a5,-48(s0)
     106:	679c                	ld	a5,8(a5)
     108:	853e                	mv	a0,a5
     10a:	00000097          	auipc	ra,0x0
     10e:	ef6080e7          	jalr	-266(ra) # 0 <runcmd>
    break;
     112:	a29d                	j	278 <runcmd+0x278>

  case LIST:
    lcmd = (struct listcmd*)cmd;
     114:	fb843783          	ld	a5,-72(s0)
     118:	fef43023          	sd	a5,-32(s0)
    if(fork1() == 0)
     11c:	00000097          	auipc	ra,0x0
     120:	33a080e7          	jalr	826(ra) # 456 <fork1>
     124:	87aa                	mv	a5,a0
     126:	eb89                	bnez	a5,138 <runcmd+0x138>
      runcmd(lcmd->left);
     128:	fe043783          	ld	a5,-32(s0)
     12c:	679c                	ld	a5,8(a5)
     12e:	853e                	mv	a0,a5
     130:	00000097          	auipc	ra,0x0
     134:	ed0080e7          	jalr	-304(ra) # 0 <runcmd>
    wait(0);
     138:	4501                	li	a0,0
     13a:	00001097          	auipc	ra,0x1
     13e:	2bc080e7          	jalr	700(ra) # 13f6 <wait>
    runcmd(lcmd->right);
     142:	fe043783          	ld	a5,-32(s0)
     146:	6b9c                	ld	a5,16(a5)
     148:	853e                	mv	a0,a5
     14a:	00000097          	auipc	ra,0x0
     14e:	eb6080e7          	jalr	-330(ra) # 0 <runcmd>
    break;
     152:	a21d                	j	278 <runcmd+0x278>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     154:	fb843783          	ld	a5,-72(s0)
     158:	fcf43c23          	sd	a5,-40(s0)
    if(pipe(p) < 0)
     15c:	fc040793          	addi	a5,s0,-64
     160:	853e                	mv	a0,a5
     162:	00001097          	auipc	ra,0x1
     166:	29c080e7          	jalr	668(ra) # 13fe <pipe>
     16a:	87aa                	mv	a5,a0
     16c:	0007da63          	bgez	a5,180 <runcmd+0x180>
      panic("pipe");
     170:	00002517          	auipc	a0,0x2
     174:	c3050513          	addi	a0,a0,-976 # 1da0 <lock_init+0x42>
     178:	00000097          	auipc	ra,0x0
     17c:	2b2080e7          	jalr	690(ra) # 42a <panic>
    if(fork1() == 0){
     180:	00000097          	auipc	ra,0x0
     184:	2d6080e7          	jalr	726(ra) # 456 <fork1>
     188:	87aa                	mv	a5,a0
     18a:	e3b9                	bnez	a5,1d0 <runcmd+0x1d0>
      close(1);
     18c:	4505                	li	a0,1
     18e:	00001097          	auipc	ra,0x1
     192:	288080e7          	jalr	648(ra) # 1416 <close>
      dup(p[1]);
     196:	fc442783          	lw	a5,-60(s0)
     19a:	853e                	mv	a0,a5
     19c:	00001097          	auipc	ra,0x1
     1a0:	2ca080e7          	jalr	714(ra) # 1466 <dup>
      close(p[0]);
     1a4:	fc042783          	lw	a5,-64(s0)
     1a8:	853e                	mv	a0,a5
     1aa:	00001097          	auipc	ra,0x1
     1ae:	26c080e7          	jalr	620(ra) # 1416 <close>
      close(p[1]);
     1b2:	fc442783          	lw	a5,-60(s0)
     1b6:	853e                	mv	a0,a5
     1b8:	00001097          	auipc	ra,0x1
     1bc:	25e080e7          	jalr	606(ra) # 1416 <close>
      runcmd(pcmd->left);
     1c0:	fd843783          	ld	a5,-40(s0)
     1c4:	679c                	ld	a5,8(a5)
     1c6:	853e                	mv	a0,a5
     1c8:	00000097          	auipc	ra,0x0
     1cc:	e38080e7          	jalr	-456(ra) # 0 <runcmd>
    }
    if(fork1() == 0){
     1d0:	00000097          	auipc	ra,0x0
     1d4:	286080e7          	jalr	646(ra) # 456 <fork1>
     1d8:	87aa                	mv	a5,a0
     1da:	e3b9                	bnez	a5,220 <runcmd+0x220>
      close(0);
     1dc:	4501                	li	a0,0
     1de:	00001097          	auipc	ra,0x1
     1e2:	238080e7          	jalr	568(ra) # 1416 <close>
      dup(p[0]);
     1e6:	fc042783          	lw	a5,-64(s0)
     1ea:	853e                	mv	a0,a5
     1ec:	00001097          	auipc	ra,0x1
     1f0:	27a080e7          	jalr	634(ra) # 1466 <dup>
      close(p[0]);
     1f4:	fc042783          	lw	a5,-64(s0)
     1f8:	853e                	mv	a0,a5
     1fa:	00001097          	auipc	ra,0x1
     1fe:	21c080e7          	jalr	540(ra) # 1416 <close>
      close(p[1]);
     202:	fc442783          	lw	a5,-60(s0)
     206:	853e                	mv	a0,a5
     208:	00001097          	auipc	ra,0x1
     20c:	20e080e7          	jalr	526(ra) # 1416 <close>
      runcmd(pcmd->right);
     210:	fd843783          	ld	a5,-40(s0)
     214:	6b9c                	ld	a5,16(a5)
     216:	853e                	mv	a0,a5
     218:	00000097          	auipc	ra,0x0
     21c:	de8080e7          	jalr	-536(ra) # 0 <runcmd>
    }
    close(p[0]);
     220:	fc042783          	lw	a5,-64(s0)
     224:	853e                	mv	a0,a5
     226:	00001097          	auipc	ra,0x1
     22a:	1f0080e7          	jalr	496(ra) # 1416 <close>
    close(p[1]);
     22e:	fc442783          	lw	a5,-60(s0)
     232:	853e                	mv	a0,a5
     234:	00001097          	auipc	ra,0x1
     238:	1e2080e7          	jalr	482(ra) # 1416 <close>
    wait(0);
     23c:	4501                	li	a0,0
     23e:	00001097          	auipc	ra,0x1
     242:	1b8080e7          	jalr	440(ra) # 13f6 <wait>
    wait(0);
     246:	4501                	li	a0,0
     248:	00001097          	auipc	ra,0x1
     24c:	1ae080e7          	jalr	430(ra) # 13f6 <wait>
    break;
     250:	a025                	j	278 <runcmd+0x278>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     252:	fb843783          	ld	a5,-72(s0)
     256:	fef43423          	sd	a5,-24(s0)
    if(fork1() == 0)
     25a:	00000097          	auipc	ra,0x0
     25e:	1fc080e7          	jalr	508(ra) # 456 <fork1>
     262:	87aa                	mv	a5,a0
     264:	eb89                	bnez	a5,276 <runcmd+0x276>
      runcmd(bcmd->cmd);
     266:	fe843783          	ld	a5,-24(s0)
     26a:	679c                	ld	a5,8(a5)
     26c:	853e                	mv	a0,a5
     26e:	00000097          	auipc	ra,0x0
     272:	d92080e7          	jalr	-622(ra) # 0 <runcmd>
    break;
     276:	0001                	nop
  }
  exit(0);
     278:	4501                	li	a0,0
     27a:	00001097          	auipc	ra,0x1
     27e:	174080e7          	jalr	372(ra) # 13ee <exit>

0000000000000282 <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     282:	1101                	addi	sp,sp,-32
     284:	ec06                	sd	ra,24(sp)
     286:	e822                	sd	s0,16(sp)
     288:	1000                	addi	s0,sp,32
     28a:	fea43423          	sd	a0,-24(s0)
     28e:	87ae                	mv	a5,a1
     290:	fef42223          	sw	a5,-28(s0)
  fprintf(2, "$ ");
     294:	00002597          	auipc	a1,0x2
     298:	b2c58593          	addi	a1,a1,-1236 # 1dc0 <lock_init+0x62>
     29c:	4509                	li	a0,2
     29e:	00001097          	auipc	ra,0x1
     2a2:	630080e7          	jalr	1584(ra) # 18ce <fprintf>
  memset(buf, 0, nbuf);
     2a6:	fe442783          	lw	a5,-28(s0)
     2aa:	863e                	mv	a2,a5
     2ac:	4581                	li	a1,0
     2ae:	fe843503          	ld	a0,-24(s0)
     2b2:	00001097          	auipc	ra,0x1
     2b6:	d90080e7          	jalr	-624(ra) # 1042 <memset>
  gets(buf, nbuf);
     2ba:	fe442783          	lw	a5,-28(s0)
     2be:	85be                	mv	a1,a5
     2c0:	fe843503          	ld	a0,-24(s0)
     2c4:	00001097          	auipc	ra,0x1
     2c8:	e28080e7          	jalr	-472(ra) # 10ec <gets>
  if(buf[0] == 0) // EOF
     2cc:	fe843783          	ld	a5,-24(s0)
     2d0:	0007c783          	lbu	a5,0(a5)
     2d4:	e399                	bnez	a5,2da <getcmd+0x58>
    return -1;
     2d6:	57fd                	li	a5,-1
     2d8:	a011                	j	2dc <getcmd+0x5a>
  return 0;
     2da:	4781                	li	a5,0
}
     2dc:	853e                	mv	a0,a5
     2de:	60e2                	ld	ra,24(sp)
     2e0:	6442                	ld	s0,16(sp)
     2e2:	6105                	addi	sp,sp,32
     2e4:	8082                	ret

00000000000002e6 <main>:

int
main(void)
{
     2e6:	1101                	addi	sp,sp,-32
     2e8:	ec06                	sd	ra,24(sp)
     2ea:	e822                	sd	s0,16(sp)
     2ec:	1000                	addi	s0,sp,32
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
     2ee:	a005                	j	30e <main+0x28>
    if(fd >= 3){
     2f0:	fec42783          	lw	a5,-20(s0)
     2f4:	0007871b          	sext.w	a4,a5
     2f8:	4789                	li	a5,2
     2fa:	00e7da63          	bge	a5,a4,30e <main+0x28>
      close(fd);
     2fe:	fec42783          	lw	a5,-20(s0)
     302:	853e                	mv	a0,a5
     304:	00001097          	auipc	ra,0x1
     308:	112080e7          	jalr	274(ra) # 1416 <close>
      break;
     30c:	a015                	j	330 <main+0x4a>
  while((fd = open("console", O_RDWR)) >= 0){
     30e:	4589                	li	a1,2
     310:	00002517          	auipc	a0,0x2
     314:	ab850513          	addi	a0,a0,-1352 # 1dc8 <lock_init+0x6a>
     318:	00001097          	auipc	ra,0x1
     31c:	116080e7          	jalr	278(ra) # 142e <open>
     320:	87aa                	mv	a5,a0
     322:	fef42623          	sw	a5,-20(s0)
     326:	fec42783          	lw	a5,-20(s0)
     32a:	2781                	sext.w	a5,a5
     32c:	fc07d2e3          	bgez	a5,2f0 <main+0xa>
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     330:	a8d9                	j	406 <main+0x120>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     332:	00002797          	auipc	a5,0x2
     336:	c0678793          	addi	a5,a5,-1018 # 1f38 <buf.0>
     33a:	0007c783          	lbu	a5,0(a5)
     33e:	873e                	mv	a4,a5
     340:	06300793          	li	a5,99
     344:	08f71863          	bne	a4,a5,3d4 <main+0xee>
     348:	00002797          	auipc	a5,0x2
     34c:	bf078793          	addi	a5,a5,-1040 # 1f38 <buf.0>
     350:	0017c783          	lbu	a5,1(a5)
     354:	873e                	mv	a4,a5
     356:	06400793          	li	a5,100
     35a:	06f71d63          	bne	a4,a5,3d4 <main+0xee>
     35e:	00002797          	auipc	a5,0x2
     362:	bda78793          	addi	a5,a5,-1062 # 1f38 <buf.0>
     366:	0027c783          	lbu	a5,2(a5)
     36a:	873e                	mv	a4,a5
     36c:	02000793          	li	a5,32
     370:	06f71263          	bne	a4,a5,3d4 <main+0xee>
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     374:	00002517          	auipc	a0,0x2
     378:	bc450513          	addi	a0,a0,-1084 # 1f38 <buf.0>
     37c:	00001097          	auipc	ra,0x1
     380:	c90080e7          	jalr	-880(ra) # 100c <strlen>
     384:	87aa                	mv	a5,a0
     386:	2781                	sext.w	a5,a5
     388:	37fd                	addiw	a5,a5,-1
     38a:	2781                	sext.w	a5,a5
     38c:	00002717          	auipc	a4,0x2
     390:	bac70713          	addi	a4,a4,-1108 # 1f38 <buf.0>
     394:	1782                	slli	a5,a5,0x20
     396:	9381                	srli	a5,a5,0x20
     398:	97ba                	add	a5,a5,a4
     39a:	00078023          	sb	zero,0(a5)
      if(chdir(buf+3) < 0)
     39e:	00002797          	auipc	a5,0x2
     3a2:	b9d78793          	addi	a5,a5,-1123 # 1f3b <buf.0+0x3>
     3a6:	853e                	mv	a0,a5
     3a8:	00001097          	auipc	ra,0x1
     3ac:	0b6080e7          	jalr	182(ra) # 145e <chdir>
     3b0:	87aa                	mv	a5,a0
     3b2:	0407da63          	bgez	a5,406 <main+0x120>
        fprintf(2, "cannot cd %s\n", buf+3);
     3b6:	00002797          	auipc	a5,0x2
     3ba:	b8578793          	addi	a5,a5,-1147 # 1f3b <buf.0+0x3>
     3be:	863e                	mv	a2,a5
     3c0:	00002597          	auipc	a1,0x2
     3c4:	a1058593          	addi	a1,a1,-1520 # 1dd0 <lock_init+0x72>
     3c8:	4509                	li	a0,2
     3ca:	00001097          	auipc	ra,0x1
     3ce:	504080e7          	jalr	1284(ra) # 18ce <fprintf>
      continue;
     3d2:	a815                	j	406 <main+0x120>
    }
    if(fork1() == 0)
     3d4:	00000097          	auipc	ra,0x0
     3d8:	082080e7          	jalr	130(ra) # 456 <fork1>
     3dc:	87aa                	mv	a5,a0
     3de:	ef99                	bnez	a5,3fc <main+0x116>
      runcmd(parsecmd(buf));
     3e0:	00002517          	auipc	a0,0x2
     3e4:	b5850513          	addi	a0,a0,-1192 # 1f38 <buf.0>
     3e8:	00000097          	auipc	ra,0x0
     3ec:	4e2080e7          	jalr	1250(ra) # 8ca <parsecmd>
     3f0:	87aa                	mv	a5,a0
     3f2:	853e                	mv	a0,a5
     3f4:	00000097          	auipc	ra,0x0
     3f8:	c0c080e7          	jalr	-1012(ra) # 0 <runcmd>
    wait(0);
     3fc:	4501                	li	a0,0
     3fe:	00001097          	auipc	ra,0x1
     402:	ff8080e7          	jalr	-8(ra) # 13f6 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     406:	06400593          	li	a1,100
     40a:	00002517          	auipc	a0,0x2
     40e:	b2e50513          	addi	a0,a0,-1234 # 1f38 <buf.0>
     412:	00000097          	auipc	ra,0x0
     416:	e70080e7          	jalr	-400(ra) # 282 <getcmd>
     41a:	87aa                	mv	a5,a0
     41c:	f007dbe3          	bgez	a5,332 <main+0x4c>
  }
  exit(0);
     420:	4501                	li	a0,0
     422:	00001097          	auipc	ra,0x1
     426:	fcc080e7          	jalr	-52(ra) # 13ee <exit>

000000000000042a <panic>:
}

void
panic(char *s)
{
     42a:	1101                	addi	sp,sp,-32
     42c:	ec06                	sd	ra,24(sp)
     42e:	e822                	sd	s0,16(sp)
     430:	1000                	addi	s0,sp,32
     432:	fea43423          	sd	a0,-24(s0)
  fprintf(2, "%s\n", s);
     436:	fe843603          	ld	a2,-24(s0)
     43a:	00002597          	auipc	a1,0x2
     43e:	9a658593          	addi	a1,a1,-1626 # 1de0 <lock_init+0x82>
     442:	4509                	li	a0,2
     444:	00001097          	auipc	ra,0x1
     448:	48a080e7          	jalr	1162(ra) # 18ce <fprintf>
  exit(1);
     44c:	4505                	li	a0,1
     44e:	00001097          	auipc	ra,0x1
     452:	fa0080e7          	jalr	-96(ra) # 13ee <exit>

0000000000000456 <fork1>:
}

int
fork1(void)
{
     456:	1101                	addi	sp,sp,-32
     458:	ec06                	sd	ra,24(sp)
     45a:	e822                	sd	s0,16(sp)
     45c:	1000                	addi	s0,sp,32
  int pid;

  pid = fork();
     45e:	00001097          	auipc	ra,0x1
     462:	f88080e7          	jalr	-120(ra) # 13e6 <fork>
     466:	87aa                	mv	a5,a0
     468:	fef42623          	sw	a5,-20(s0)
  if(pid == -1)
     46c:	fec42783          	lw	a5,-20(s0)
     470:	0007871b          	sext.w	a4,a5
     474:	57fd                	li	a5,-1
     476:	00f71a63          	bne	a4,a5,48a <fork1+0x34>
    panic("fork");
     47a:	00002517          	auipc	a0,0x2
     47e:	96e50513          	addi	a0,a0,-1682 # 1de8 <lock_init+0x8a>
     482:	00000097          	auipc	ra,0x0
     486:	fa8080e7          	jalr	-88(ra) # 42a <panic>
  return pid;
     48a:	fec42783          	lw	a5,-20(s0)
}
     48e:	853e                	mv	a0,a5
     490:	60e2                	ld	ra,24(sp)
     492:	6442                	ld	s0,16(sp)
     494:	6105                	addi	sp,sp,32
     496:	8082                	ret

0000000000000498 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     498:	1101                	addi	sp,sp,-32
     49a:	ec06                	sd	ra,24(sp)
     49c:	e822                	sd	s0,16(sp)
     49e:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4a0:	0a800513          	li	a0,168
     4a4:	00001097          	auipc	ra,0x1
     4a8:	674080e7          	jalr	1652(ra) # 1b18 <malloc>
     4ac:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     4b0:	0a800613          	li	a2,168
     4b4:	4581                	li	a1,0
     4b6:	fe843503          	ld	a0,-24(s0)
     4ba:	00001097          	auipc	ra,0x1
     4be:	b88080e7          	jalr	-1144(ra) # 1042 <memset>
  cmd->type = EXEC;
     4c2:	fe843783          	ld	a5,-24(s0)
     4c6:	4705                	li	a4,1
     4c8:	c398                	sw	a4,0(a5)
  return (struct cmd*)cmd;
     4ca:	fe843783          	ld	a5,-24(s0)
}
     4ce:	853e                	mv	a0,a5
     4d0:	60e2                	ld	ra,24(sp)
     4d2:	6442                	ld	s0,16(sp)
     4d4:	6105                	addi	sp,sp,32
     4d6:	8082                	ret

00000000000004d8 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     4d8:	7139                	addi	sp,sp,-64
     4da:	fc06                	sd	ra,56(sp)
     4dc:	f822                	sd	s0,48(sp)
     4de:	0080                	addi	s0,sp,64
     4e0:	fca43c23          	sd	a0,-40(s0)
     4e4:	fcb43823          	sd	a1,-48(s0)
     4e8:	fcc43423          	sd	a2,-56(s0)
     4ec:	87b6                	mv	a5,a3
     4ee:	fcf42223          	sw	a5,-60(s0)
     4f2:	87ba                	mv	a5,a4
     4f4:	fcf42023          	sw	a5,-64(s0)
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4f8:	02800513          	li	a0,40
     4fc:	00001097          	auipc	ra,0x1
     500:	61c080e7          	jalr	1564(ra) # 1b18 <malloc>
     504:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     508:	02800613          	li	a2,40
     50c:	4581                	li	a1,0
     50e:	fe843503          	ld	a0,-24(s0)
     512:	00001097          	auipc	ra,0x1
     516:	b30080e7          	jalr	-1232(ra) # 1042 <memset>
  cmd->type = REDIR;
     51a:	fe843783          	ld	a5,-24(s0)
     51e:	4709                	li	a4,2
     520:	c398                	sw	a4,0(a5)
  cmd->cmd = subcmd;
     522:	fe843783          	ld	a5,-24(s0)
     526:	fd843703          	ld	a4,-40(s0)
     52a:	e798                	sd	a4,8(a5)
  cmd->file = file;
     52c:	fe843783          	ld	a5,-24(s0)
     530:	fd043703          	ld	a4,-48(s0)
     534:	eb98                	sd	a4,16(a5)
  cmd->efile = efile;
     536:	fe843783          	ld	a5,-24(s0)
     53a:	fc843703          	ld	a4,-56(s0)
     53e:	ef98                	sd	a4,24(a5)
  cmd->mode = mode;
     540:	fe843783          	ld	a5,-24(s0)
     544:	fc442703          	lw	a4,-60(s0)
     548:	d398                	sw	a4,32(a5)
  cmd->fd = fd;
     54a:	fe843783          	ld	a5,-24(s0)
     54e:	fc042703          	lw	a4,-64(s0)
     552:	d3d8                	sw	a4,36(a5)
  return (struct cmd*)cmd;
     554:	fe843783          	ld	a5,-24(s0)
}
     558:	853e                	mv	a0,a5
     55a:	70e2                	ld	ra,56(sp)
     55c:	7442                	ld	s0,48(sp)
     55e:	6121                	addi	sp,sp,64
     560:	8082                	ret

0000000000000562 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     562:	7179                	addi	sp,sp,-48
     564:	f406                	sd	ra,40(sp)
     566:	f022                	sd	s0,32(sp)
     568:	1800                	addi	s0,sp,48
     56a:	fca43c23          	sd	a0,-40(s0)
     56e:	fcb43823          	sd	a1,-48(s0)
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     572:	4561                	li	a0,24
     574:	00001097          	auipc	ra,0x1
     578:	5a4080e7          	jalr	1444(ra) # 1b18 <malloc>
     57c:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     580:	4661                	li	a2,24
     582:	4581                	li	a1,0
     584:	fe843503          	ld	a0,-24(s0)
     588:	00001097          	auipc	ra,0x1
     58c:	aba080e7          	jalr	-1350(ra) # 1042 <memset>
  cmd->type = PIPE;
     590:	fe843783          	ld	a5,-24(s0)
     594:	470d                	li	a4,3
     596:	c398                	sw	a4,0(a5)
  cmd->left = left;
     598:	fe843783          	ld	a5,-24(s0)
     59c:	fd843703          	ld	a4,-40(s0)
     5a0:	e798                	sd	a4,8(a5)
  cmd->right = right;
     5a2:	fe843783          	ld	a5,-24(s0)
     5a6:	fd043703          	ld	a4,-48(s0)
     5aa:	eb98                	sd	a4,16(a5)
  return (struct cmd*)cmd;
     5ac:	fe843783          	ld	a5,-24(s0)
}
     5b0:	853e                	mv	a0,a5
     5b2:	70a2                	ld	ra,40(sp)
     5b4:	7402                	ld	s0,32(sp)
     5b6:	6145                	addi	sp,sp,48
     5b8:	8082                	ret

00000000000005ba <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     5ba:	7179                	addi	sp,sp,-48
     5bc:	f406                	sd	ra,40(sp)
     5be:	f022                	sd	s0,32(sp)
     5c0:	1800                	addi	s0,sp,48
     5c2:	fca43c23          	sd	a0,-40(s0)
     5c6:	fcb43823          	sd	a1,-48(s0)
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     5ca:	4561                	li	a0,24
     5cc:	00001097          	auipc	ra,0x1
     5d0:	54c080e7          	jalr	1356(ra) # 1b18 <malloc>
     5d4:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     5d8:	4661                	li	a2,24
     5da:	4581                	li	a1,0
     5dc:	fe843503          	ld	a0,-24(s0)
     5e0:	00001097          	auipc	ra,0x1
     5e4:	a62080e7          	jalr	-1438(ra) # 1042 <memset>
  cmd->type = LIST;
     5e8:	fe843783          	ld	a5,-24(s0)
     5ec:	4711                	li	a4,4
     5ee:	c398                	sw	a4,0(a5)
  cmd->left = left;
     5f0:	fe843783          	ld	a5,-24(s0)
     5f4:	fd843703          	ld	a4,-40(s0)
     5f8:	e798                	sd	a4,8(a5)
  cmd->right = right;
     5fa:	fe843783          	ld	a5,-24(s0)
     5fe:	fd043703          	ld	a4,-48(s0)
     602:	eb98                	sd	a4,16(a5)
  return (struct cmd*)cmd;
     604:	fe843783          	ld	a5,-24(s0)
}
     608:	853e                	mv	a0,a5
     60a:	70a2                	ld	ra,40(sp)
     60c:	7402                	ld	s0,32(sp)
     60e:	6145                	addi	sp,sp,48
     610:	8082                	ret

0000000000000612 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     612:	7179                	addi	sp,sp,-48
     614:	f406                	sd	ra,40(sp)
     616:	f022                	sd	s0,32(sp)
     618:	1800                	addi	s0,sp,48
     61a:	fca43c23          	sd	a0,-40(s0)
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     61e:	4541                	li	a0,16
     620:	00001097          	auipc	ra,0x1
     624:	4f8080e7          	jalr	1272(ra) # 1b18 <malloc>
     628:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     62c:	4641                	li	a2,16
     62e:	4581                	li	a1,0
     630:	fe843503          	ld	a0,-24(s0)
     634:	00001097          	auipc	ra,0x1
     638:	a0e080e7          	jalr	-1522(ra) # 1042 <memset>
  cmd->type = BACK;
     63c:	fe843783          	ld	a5,-24(s0)
     640:	4715                	li	a4,5
     642:	c398                	sw	a4,0(a5)
  cmd->cmd = subcmd;
     644:	fe843783          	ld	a5,-24(s0)
     648:	fd843703          	ld	a4,-40(s0)
     64c:	e798                	sd	a4,8(a5)
  return (struct cmd*)cmd;
     64e:	fe843783          	ld	a5,-24(s0)
}
     652:	853e                	mv	a0,a5
     654:	70a2                	ld	ra,40(sp)
     656:	7402                	ld	s0,32(sp)
     658:	6145                	addi	sp,sp,48
     65a:	8082                	ret

000000000000065c <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     65c:	7139                	addi	sp,sp,-64
     65e:	fc06                	sd	ra,56(sp)
     660:	f822                	sd	s0,48(sp)
     662:	0080                	addi	s0,sp,64
     664:	fca43c23          	sd	a0,-40(s0)
     668:	fcb43823          	sd	a1,-48(s0)
     66c:	fcc43423          	sd	a2,-56(s0)
     670:	fcd43023          	sd	a3,-64(s0)
  char *s;
  int ret;

  s = *ps;
     674:	fd843783          	ld	a5,-40(s0)
     678:	639c                	ld	a5,0(a5)
     67a:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     67e:	a031                	j	68a <gettoken+0x2e>
    s++;
     680:	fe843783          	ld	a5,-24(s0)
     684:	0785                	addi	a5,a5,1
     686:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     68a:	fe843703          	ld	a4,-24(s0)
     68e:	fd043783          	ld	a5,-48(s0)
     692:	02f77163          	bgeu	a4,a5,6b4 <gettoken+0x58>
     696:	fe843783          	ld	a5,-24(s0)
     69a:	0007c783          	lbu	a5,0(a5)
     69e:	85be                	mv	a1,a5
     6a0:	00002517          	auipc	a0,0x2
     6a4:	88850513          	addi	a0,a0,-1912 # 1f28 <whitespace>
     6a8:	00001097          	auipc	ra,0x1
     6ac:	9fa080e7          	jalr	-1542(ra) # 10a2 <strchr>
     6b0:	87aa                	mv	a5,a0
     6b2:	f7f9                	bnez	a5,680 <gettoken+0x24>
  if(q)
     6b4:	fc843783          	ld	a5,-56(s0)
     6b8:	c791                	beqz	a5,6c4 <gettoken+0x68>
    *q = s;
     6ba:	fc843783          	ld	a5,-56(s0)
     6be:	fe843703          	ld	a4,-24(s0)
     6c2:	e398                	sd	a4,0(a5)
  ret = *s;
     6c4:	fe843783          	ld	a5,-24(s0)
     6c8:	0007c783          	lbu	a5,0(a5)
     6cc:	fef42223          	sw	a5,-28(s0)
  switch(*s){
     6d0:	fe843783          	ld	a5,-24(s0)
     6d4:	0007c783          	lbu	a5,0(a5)
     6d8:	2781                	sext.w	a5,a5
     6da:	86be                	mv	a3,a5
     6dc:	07c00713          	li	a4,124
     6e0:	04e68b63          	beq	a3,a4,736 <gettoken+0xda>
     6e4:	86be                	mv	a3,a5
     6e6:	07c00713          	li	a4,124
     6ea:	08d74463          	blt	a4,a3,772 <gettoken+0x116>
     6ee:	86be                	mv	a3,a5
     6f0:	03e00713          	li	a4,62
     6f4:	04e68763          	beq	a3,a4,742 <gettoken+0xe6>
     6f8:	86be                	mv	a3,a5
     6fa:	03e00713          	li	a4,62
     6fe:	06d74a63          	blt	a4,a3,772 <gettoken+0x116>
     702:	86be                	mv	a3,a5
     704:	03c00713          	li	a4,60
     708:	06d74563          	blt	a4,a3,772 <gettoken+0x116>
     70c:	86be                	mv	a3,a5
     70e:	03b00713          	li	a4,59
     712:	02e6d263          	bge	a3,a4,736 <gettoken+0xda>
     716:	86be                	mv	a3,a5
     718:	02900713          	li	a4,41
     71c:	04d74b63          	blt	a4,a3,772 <gettoken+0x116>
     720:	86be                	mv	a3,a5
     722:	02800713          	li	a4,40
     726:	00e6d863          	bge	a3,a4,736 <gettoken+0xda>
     72a:	c3dd                	beqz	a5,7d0 <gettoken+0x174>
     72c:	873e                	mv	a4,a5
     72e:	02600793          	li	a5,38
     732:	04f71063          	bne	a4,a5,772 <gettoken+0x116>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     736:	fe843783          	ld	a5,-24(s0)
     73a:	0785                	addi	a5,a5,1
     73c:	fef43423          	sd	a5,-24(s0)
    break;
     740:	a869                	j	7da <gettoken+0x17e>
  case '>':
    s++;
     742:	fe843783          	ld	a5,-24(s0)
     746:	0785                	addi	a5,a5,1
     748:	fef43423          	sd	a5,-24(s0)
    if(*s == '>'){
     74c:	fe843783          	ld	a5,-24(s0)
     750:	0007c783          	lbu	a5,0(a5)
     754:	873e                	mv	a4,a5
     756:	03e00793          	li	a5,62
     75a:	06f71d63          	bne	a4,a5,7d4 <gettoken+0x178>
      ret = '+';
     75e:	02b00793          	li	a5,43
     762:	fef42223          	sw	a5,-28(s0)
      s++;
     766:	fe843783          	ld	a5,-24(s0)
     76a:	0785                	addi	a5,a5,1
     76c:	fef43423          	sd	a5,-24(s0)
    }
    break;
     770:	a095                	j	7d4 <gettoken+0x178>
  default:
    ret = 'a';
     772:	06100793          	li	a5,97
     776:	fef42223          	sw	a5,-28(s0)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     77a:	a031                	j	786 <gettoken+0x12a>
      s++;
     77c:	fe843783          	ld	a5,-24(s0)
     780:	0785                	addi	a5,a5,1
     782:	fef43423          	sd	a5,-24(s0)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     786:	fe843703          	ld	a4,-24(s0)
     78a:	fd043783          	ld	a5,-48(s0)
     78e:	04f77563          	bgeu	a4,a5,7d8 <gettoken+0x17c>
     792:	fe843783          	ld	a5,-24(s0)
     796:	0007c783          	lbu	a5,0(a5)
     79a:	85be                	mv	a1,a5
     79c:	00001517          	auipc	a0,0x1
     7a0:	78c50513          	addi	a0,a0,1932 # 1f28 <whitespace>
     7a4:	00001097          	auipc	ra,0x1
     7a8:	8fe080e7          	jalr	-1794(ra) # 10a2 <strchr>
     7ac:	87aa                	mv	a5,a0
     7ae:	e78d                	bnez	a5,7d8 <gettoken+0x17c>
     7b0:	fe843783          	ld	a5,-24(s0)
     7b4:	0007c783          	lbu	a5,0(a5)
     7b8:	85be                	mv	a1,a5
     7ba:	00001517          	auipc	a0,0x1
     7be:	77650513          	addi	a0,a0,1910 # 1f30 <symbols>
     7c2:	00001097          	auipc	ra,0x1
     7c6:	8e0080e7          	jalr	-1824(ra) # 10a2 <strchr>
     7ca:	87aa                	mv	a5,a0
     7cc:	dbc5                	beqz	a5,77c <gettoken+0x120>
    break;
     7ce:	a029                	j	7d8 <gettoken+0x17c>
    break;
     7d0:	0001                	nop
     7d2:	a021                	j	7da <gettoken+0x17e>
    break;
     7d4:	0001                	nop
     7d6:	a011                	j	7da <gettoken+0x17e>
    break;
     7d8:	0001                	nop
  }
  if(eq)
     7da:	fc043783          	ld	a5,-64(s0)
     7de:	cf81                	beqz	a5,7f6 <gettoken+0x19a>
    *eq = s;
     7e0:	fc043783          	ld	a5,-64(s0)
     7e4:	fe843703          	ld	a4,-24(s0)
     7e8:	e398                	sd	a4,0(a5)

  while(s < es && strchr(whitespace, *s))
     7ea:	a031                	j	7f6 <gettoken+0x19a>
    s++;
     7ec:	fe843783          	ld	a5,-24(s0)
     7f0:	0785                	addi	a5,a5,1
     7f2:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     7f6:	fe843703          	ld	a4,-24(s0)
     7fa:	fd043783          	ld	a5,-48(s0)
     7fe:	02f77163          	bgeu	a4,a5,820 <gettoken+0x1c4>
     802:	fe843783          	ld	a5,-24(s0)
     806:	0007c783          	lbu	a5,0(a5)
     80a:	85be                	mv	a1,a5
     80c:	00001517          	auipc	a0,0x1
     810:	71c50513          	addi	a0,a0,1820 # 1f28 <whitespace>
     814:	00001097          	auipc	ra,0x1
     818:	88e080e7          	jalr	-1906(ra) # 10a2 <strchr>
     81c:	87aa                	mv	a5,a0
     81e:	f7f9                	bnez	a5,7ec <gettoken+0x190>
  *ps = s;
     820:	fd843783          	ld	a5,-40(s0)
     824:	fe843703          	ld	a4,-24(s0)
     828:	e398                	sd	a4,0(a5)
  return ret;
     82a:	fe442783          	lw	a5,-28(s0)
}
     82e:	853e                	mv	a0,a5
     830:	70e2                	ld	ra,56(sp)
     832:	7442                	ld	s0,48(sp)
     834:	6121                	addi	sp,sp,64
     836:	8082                	ret

0000000000000838 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     838:	7139                	addi	sp,sp,-64
     83a:	fc06                	sd	ra,56(sp)
     83c:	f822                	sd	s0,48(sp)
     83e:	0080                	addi	s0,sp,64
     840:	fca43c23          	sd	a0,-40(s0)
     844:	fcb43823          	sd	a1,-48(s0)
     848:	fcc43423          	sd	a2,-56(s0)
  char *s;

  s = *ps;
     84c:	fd843783          	ld	a5,-40(s0)
     850:	639c                	ld	a5,0(a5)
     852:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     856:	a031                	j	862 <peek+0x2a>
    s++;
     858:	fe843783          	ld	a5,-24(s0)
     85c:	0785                	addi	a5,a5,1
     85e:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     862:	fe843703          	ld	a4,-24(s0)
     866:	fd043783          	ld	a5,-48(s0)
     86a:	02f77163          	bgeu	a4,a5,88c <peek+0x54>
     86e:	fe843783          	ld	a5,-24(s0)
     872:	0007c783          	lbu	a5,0(a5)
     876:	85be                	mv	a1,a5
     878:	00001517          	auipc	a0,0x1
     87c:	6b050513          	addi	a0,a0,1712 # 1f28 <whitespace>
     880:	00001097          	auipc	ra,0x1
     884:	822080e7          	jalr	-2014(ra) # 10a2 <strchr>
     888:	87aa                	mv	a5,a0
     88a:	f7f9                	bnez	a5,858 <peek+0x20>
  *ps = s;
     88c:	fd843783          	ld	a5,-40(s0)
     890:	fe843703          	ld	a4,-24(s0)
     894:	e398                	sd	a4,0(a5)
  return *s && strchr(toks, *s);
     896:	fe843783          	ld	a5,-24(s0)
     89a:	0007c783          	lbu	a5,0(a5)
     89e:	c385                	beqz	a5,8be <peek+0x86>
     8a0:	fe843783          	ld	a5,-24(s0)
     8a4:	0007c783          	lbu	a5,0(a5)
     8a8:	85be                	mv	a1,a5
     8aa:	fc843503          	ld	a0,-56(s0)
     8ae:	00000097          	auipc	ra,0x0
     8b2:	7f4080e7          	jalr	2036(ra) # 10a2 <strchr>
     8b6:	87aa                	mv	a5,a0
     8b8:	c399                	beqz	a5,8be <peek+0x86>
     8ba:	4785                	li	a5,1
     8bc:	a011                	j	8c0 <peek+0x88>
     8be:	4781                	li	a5,0
}
     8c0:	853e                	mv	a0,a5
     8c2:	70e2                	ld	ra,56(sp)
     8c4:	7442                	ld	s0,48(sp)
     8c6:	6121                	addi	sp,sp,64
     8c8:	8082                	ret

00000000000008ca <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     8ca:	7139                	addi	sp,sp,-64
     8cc:	fc06                	sd	ra,56(sp)
     8ce:	f822                	sd	s0,48(sp)
     8d0:	f426                	sd	s1,40(sp)
     8d2:	0080                	addi	s0,sp,64
     8d4:	fca43423          	sd	a0,-56(s0)
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     8d8:	fc843483          	ld	s1,-56(s0)
     8dc:	fc843783          	ld	a5,-56(s0)
     8e0:	853e                	mv	a0,a5
     8e2:	00000097          	auipc	ra,0x0
     8e6:	72a080e7          	jalr	1834(ra) # 100c <strlen>
     8ea:	87aa                	mv	a5,a0
     8ec:	2781                	sext.w	a5,a5
     8ee:	1782                	slli	a5,a5,0x20
     8f0:	9381                	srli	a5,a5,0x20
     8f2:	97a6                	add	a5,a5,s1
     8f4:	fcf43c23          	sd	a5,-40(s0)
  cmd = parseline(&s, es);
     8f8:	fc840793          	addi	a5,s0,-56
     8fc:	fd843583          	ld	a1,-40(s0)
     900:	853e                	mv	a0,a5
     902:	00000097          	auipc	ra,0x0
     906:	076080e7          	jalr	118(ra) # 978 <parseline>
     90a:	fca43823          	sd	a0,-48(s0)
  peek(&s, es, "");
     90e:	fc840793          	addi	a5,s0,-56
     912:	00001617          	auipc	a2,0x1
     916:	4de60613          	addi	a2,a2,1246 # 1df0 <lock_init+0x92>
     91a:	fd843583          	ld	a1,-40(s0)
     91e:	853e                	mv	a0,a5
     920:	00000097          	auipc	ra,0x0
     924:	f18080e7          	jalr	-232(ra) # 838 <peek>
  if(s != es){
     928:	fc843783          	ld	a5,-56(s0)
     92c:	fd843703          	ld	a4,-40(s0)
     930:	02f70663          	beq	a4,a5,95c <parsecmd+0x92>
    fprintf(2, "leftovers: %s\n", s);
     934:	fc843783          	ld	a5,-56(s0)
     938:	863e                	mv	a2,a5
     93a:	00001597          	auipc	a1,0x1
     93e:	4be58593          	addi	a1,a1,1214 # 1df8 <lock_init+0x9a>
     942:	4509                	li	a0,2
     944:	00001097          	auipc	ra,0x1
     948:	f8a080e7          	jalr	-118(ra) # 18ce <fprintf>
    panic("syntax");
     94c:	00001517          	auipc	a0,0x1
     950:	4bc50513          	addi	a0,a0,1212 # 1e08 <lock_init+0xaa>
     954:	00000097          	auipc	ra,0x0
     958:	ad6080e7          	jalr	-1322(ra) # 42a <panic>
  }
  nulterminate(cmd);
     95c:	fd043503          	ld	a0,-48(s0)
     960:	00000097          	auipc	ra,0x0
     964:	4da080e7          	jalr	1242(ra) # e3a <nulterminate>
  return cmd;
     968:	fd043783          	ld	a5,-48(s0)
}
     96c:	853e                	mv	a0,a5
     96e:	70e2                	ld	ra,56(sp)
     970:	7442                	ld	s0,48(sp)
     972:	74a2                	ld	s1,40(sp)
     974:	6121                	addi	sp,sp,64
     976:	8082                	ret

0000000000000978 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     978:	7179                	addi	sp,sp,-48
     97a:	f406                	sd	ra,40(sp)
     97c:	f022                	sd	s0,32(sp)
     97e:	1800                	addi	s0,sp,48
     980:	fca43c23          	sd	a0,-40(s0)
     984:	fcb43823          	sd	a1,-48(s0)
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     988:	fd043583          	ld	a1,-48(s0)
     98c:	fd843503          	ld	a0,-40(s0)
     990:	00000097          	auipc	ra,0x0
     994:	0b0080e7          	jalr	176(ra) # a40 <parsepipe>
     998:	fea43423          	sd	a0,-24(s0)
  while(peek(ps, es, "&")){
     99c:	a01d                	j	9c2 <parseline+0x4a>
    gettoken(ps, es, 0, 0);
     99e:	4681                	li	a3,0
     9a0:	4601                	li	a2,0
     9a2:	fd043583          	ld	a1,-48(s0)
     9a6:	fd843503          	ld	a0,-40(s0)
     9aa:	00000097          	auipc	ra,0x0
     9ae:	cb2080e7          	jalr	-846(ra) # 65c <gettoken>
    cmd = backcmd(cmd);
     9b2:	fe843503          	ld	a0,-24(s0)
     9b6:	00000097          	auipc	ra,0x0
     9ba:	c5c080e7          	jalr	-932(ra) # 612 <backcmd>
     9be:	fea43423          	sd	a0,-24(s0)
  while(peek(ps, es, "&")){
     9c2:	00001617          	auipc	a2,0x1
     9c6:	44e60613          	addi	a2,a2,1102 # 1e10 <lock_init+0xb2>
     9ca:	fd043583          	ld	a1,-48(s0)
     9ce:	fd843503          	ld	a0,-40(s0)
     9d2:	00000097          	auipc	ra,0x0
     9d6:	e66080e7          	jalr	-410(ra) # 838 <peek>
     9da:	87aa                	mv	a5,a0
     9dc:	f3e9                	bnez	a5,99e <parseline+0x26>
  }
  if(peek(ps, es, ";")){
     9de:	00001617          	auipc	a2,0x1
     9e2:	43a60613          	addi	a2,a2,1082 # 1e18 <lock_init+0xba>
     9e6:	fd043583          	ld	a1,-48(s0)
     9ea:	fd843503          	ld	a0,-40(s0)
     9ee:	00000097          	auipc	ra,0x0
     9f2:	e4a080e7          	jalr	-438(ra) # 838 <peek>
     9f6:	87aa                	mv	a5,a0
     9f8:	cf8d                	beqz	a5,a32 <parseline+0xba>
    gettoken(ps, es, 0, 0);
     9fa:	4681                	li	a3,0
     9fc:	4601                	li	a2,0
     9fe:	fd043583          	ld	a1,-48(s0)
     a02:	fd843503          	ld	a0,-40(s0)
     a06:	00000097          	auipc	ra,0x0
     a0a:	c56080e7          	jalr	-938(ra) # 65c <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     a0e:	fd043583          	ld	a1,-48(s0)
     a12:	fd843503          	ld	a0,-40(s0)
     a16:	00000097          	auipc	ra,0x0
     a1a:	f62080e7          	jalr	-158(ra) # 978 <parseline>
     a1e:	87aa                	mv	a5,a0
     a20:	85be                	mv	a1,a5
     a22:	fe843503          	ld	a0,-24(s0)
     a26:	00000097          	auipc	ra,0x0
     a2a:	b94080e7          	jalr	-1132(ra) # 5ba <listcmd>
     a2e:	fea43423          	sd	a0,-24(s0)
  }
  return cmd;
     a32:	fe843783          	ld	a5,-24(s0)
}
     a36:	853e                	mv	a0,a5
     a38:	70a2                	ld	ra,40(sp)
     a3a:	7402                	ld	s0,32(sp)
     a3c:	6145                	addi	sp,sp,48
     a3e:	8082                	ret

0000000000000a40 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     a40:	7179                	addi	sp,sp,-48
     a42:	f406                	sd	ra,40(sp)
     a44:	f022                	sd	s0,32(sp)
     a46:	1800                	addi	s0,sp,48
     a48:	fca43c23          	sd	a0,-40(s0)
     a4c:	fcb43823          	sd	a1,-48(s0)
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     a50:	fd043583          	ld	a1,-48(s0)
     a54:	fd843503          	ld	a0,-40(s0)
     a58:	00000097          	auipc	ra,0x0
     a5c:	270080e7          	jalr	624(ra) # cc8 <parseexec>
     a60:	fea43423          	sd	a0,-24(s0)
  if(peek(ps, es, "|")){
     a64:	00001617          	auipc	a2,0x1
     a68:	3bc60613          	addi	a2,a2,956 # 1e20 <lock_init+0xc2>
     a6c:	fd043583          	ld	a1,-48(s0)
     a70:	fd843503          	ld	a0,-40(s0)
     a74:	00000097          	auipc	ra,0x0
     a78:	dc4080e7          	jalr	-572(ra) # 838 <peek>
     a7c:	87aa                	mv	a5,a0
     a7e:	cf8d                	beqz	a5,ab8 <parsepipe+0x78>
    gettoken(ps, es, 0, 0);
     a80:	4681                	li	a3,0
     a82:	4601                	li	a2,0
     a84:	fd043583          	ld	a1,-48(s0)
     a88:	fd843503          	ld	a0,-40(s0)
     a8c:	00000097          	auipc	ra,0x0
     a90:	bd0080e7          	jalr	-1072(ra) # 65c <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     a94:	fd043583          	ld	a1,-48(s0)
     a98:	fd843503          	ld	a0,-40(s0)
     a9c:	00000097          	auipc	ra,0x0
     aa0:	fa4080e7          	jalr	-92(ra) # a40 <parsepipe>
     aa4:	87aa                	mv	a5,a0
     aa6:	85be                	mv	a1,a5
     aa8:	fe843503          	ld	a0,-24(s0)
     aac:	00000097          	auipc	ra,0x0
     ab0:	ab6080e7          	jalr	-1354(ra) # 562 <pipecmd>
     ab4:	fea43423          	sd	a0,-24(s0)
  }
  return cmd;
     ab8:	fe843783          	ld	a5,-24(s0)
}
     abc:	853e                	mv	a0,a5
     abe:	70a2                	ld	ra,40(sp)
     ac0:	7402                	ld	s0,32(sp)
     ac2:	6145                	addi	sp,sp,48
     ac4:	8082                	ret

0000000000000ac6 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     ac6:	715d                	addi	sp,sp,-80
     ac8:	e486                	sd	ra,72(sp)
     aca:	e0a2                	sd	s0,64(sp)
     acc:	0880                	addi	s0,sp,80
     ace:	fca43423          	sd	a0,-56(s0)
     ad2:	fcb43023          	sd	a1,-64(s0)
     ad6:	fac43c23          	sd	a2,-72(s0)
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     ada:	a8e5                	j	bd2 <parseredirs+0x10c>
    tok = gettoken(ps, es, 0, 0);
     adc:	4681                	li	a3,0
     ade:	4601                	li	a2,0
     ae0:	fb843583          	ld	a1,-72(s0)
     ae4:	fc043503          	ld	a0,-64(s0)
     ae8:	00000097          	auipc	ra,0x0
     aec:	b74080e7          	jalr	-1164(ra) # 65c <gettoken>
     af0:	87aa                	mv	a5,a0
     af2:	fef42623          	sw	a5,-20(s0)
    if(gettoken(ps, es, &q, &eq) != 'a')
     af6:	fd840713          	addi	a4,s0,-40
     afa:	fe040793          	addi	a5,s0,-32
     afe:	86ba                	mv	a3,a4
     b00:	863e                	mv	a2,a5
     b02:	fb843583          	ld	a1,-72(s0)
     b06:	fc043503          	ld	a0,-64(s0)
     b0a:	00000097          	auipc	ra,0x0
     b0e:	b52080e7          	jalr	-1198(ra) # 65c <gettoken>
     b12:	87aa                	mv	a5,a0
     b14:	873e                	mv	a4,a5
     b16:	06100793          	li	a5,97
     b1a:	00f70a63          	beq	a4,a5,b2e <parseredirs+0x68>
      panic("missing file for redirection");
     b1e:	00001517          	auipc	a0,0x1
     b22:	30a50513          	addi	a0,a0,778 # 1e28 <lock_init+0xca>
     b26:	00000097          	auipc	ra,0x0
     b2a:	904080e7          	jalr	-1788(ra) # 42a <panic>
    switch(tok){
     b2e:	fec42783          	lw	a5,-20(s0)
     b32:	0007871b          	sext.w	a4,a5
     b36:	03e00793          	li	a5,62
     b3a:	04f70a63          	beq	a4,a5,b8e <parseredirs+0xc8>
     b3e:	fec42783          	lw	a5,-20(s0)
     b42:	0007871b          	sext.w	a4,a5
     b46:	03e00793          	li	a5,62
     b4a:	08e7c463          	blt	a5,a4,bd2 <parseredirs+0x10c>
     b4e:	fec42783          	lw	a5,-20(s0)
     b52:	0007871b          	sext.w	a4,a5
     b56:	02b00793          	li	a5,43
     b5a:	04f70b63          	beq	a4,a5,bb0 <parseredirs+0xea>
     b5e:	fec42783          	lw	a5,-20(s0)
     b62:	0007871b          	sext.w	a4,a5
     b66:	03c00793          	li	a5,60
     b6a:	06f71463          	bne	a4,a5,bd2 <parseredirs+0x10c>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     b6e:	fe043783          	ld	a5,-32(s0)
     b72:	fd843603          	ld	a2,-40(s0)
     b76:	4701                	li	a4,0
     b78:	4681                	li	a3,0
     b7a:	85be                	mv	a1,a5
     b7c:	fc843503          	ld	a0,-56(s0)
     b80:	00000097          	auipc	ra,0x0
     b84:	958080e7          	jalr	-1704(ra) # 4d8 <redircmd>
     b88:	fca43423          	sd	a0,-56(s0)
      break;
     b8c:	a099                	j	bd2 <parseredirs+0x10c>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     b8e:	fe043783          	ld	a5,-32(s0)
     b92:	fd843603          	ld	a2,-40(s0)
     b96:	4705                	li	a4,1
     b98:	60100693          	li	a3,1537
     b9c:	85be                	mv	a1,a5
     b9e:	fc843503          	ld	a0,-56(s0)
     ba2:	00000097          	auipc	ra,0x0
     ba6:	936080e7          	jalr	-1738(ra) # 4d8 <redircmd>
     baa:	fca43423          	sd	a0,-56(s0)
      break;
     bae:	a015                	j	bd2 <parseredirs+0x10c>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     bb0:	fe043783          	ld	a5,-32(s0)
     bb4:	fd843603          	ld	a2,-40(s0)
     bb8:	4705                	li	a4,1
     bba:	20100693          	li	a3,513
     bbe:	85be                	mv	a1,a5
     bc0:	fc843503          	ld	a0,-56(s0)
     bc4:	00000097          	auipc	ra,0x0
     bc8:	914080e7          	jalr	-1772(ra) # 4d8 <redircmd>
     bcc:	fca43423          	sd	a0,-56(s0)
      break;
     bd0:	0001                	nop
  while(peek(ps, es, "<>")){
     bd2:	00001617          	auipc	a2,0x1
     bd6:	27660613          	addi	a2,a2,630 # 1e48 <lock_init+0xea>
     bda:	fb843583          	ld	a1,-72(s0)
     bde:	fc043503          	ld	a0,-64(s0)
     be2:	00000097          	auipc	ra,0x0
     be6:	c56080e7          	jalr	-938(ra) # 838 <peek>
     bea:	87aa                	mv	a5,a0
     bec:	ee0798e3          	bnez	a5,adc <parseredirs+0x16>
    }
  }
  return cmd;
     bf0:	fc843783          	ld	a5,-56(s0)
}
     bf4:	853e                	mv	a0,a5
     bf6:	60a6                	ld	ra,72(sp)
     bf8:	6406                	ld	s0,64(sp)
     bfa:	6161                	addi	sp,sp,80
     bfc:	8082                	ret

0000000000000bfe <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     bfe:	7179                	addi	sp,sp,-48
     c00:	f406                	sd	ra,40(sp)
     c02:	f022                	sd	s0,32(sp)
     c04:	1800                	addi	s0,sp,48
     c06:	fca43c23          	sd	a0,-40(s0)
     c0a:	fcb43823          	sd	a1,-48(s0)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     c0e:	00001617          	auipc	a2,0x1
     c12:	24260613          	addi	a2,a2,578 # 1e50 <lock_init+0xf2>
     c16:	fd043583          	ld	a1,-48(s0)
     c1a:	fd843503          	ld	a0,-40(s0)
     c1e:	00000097          	auipc	ra,0x0
     c22:	c1a080e7          	jalr	-998(ra) # 838 <peek>
     c26:	87aa                	mv	a5,a0
     c28:	eb89                	bnez	a5,c3a <parseblock+0x3c>
    panic("parseblock");
     c2a:	00001517          	auipc	a0,0x1
     c2e:	22e50513          	addi	a0,a0,558 # 1e58 <lock_init+0xfa>
     c32:	fffff097          	auipc	ra,0xfffff
     c36:	7f8080e7          	jalr	2040(ra) # 42a <panic>
  gettoken(ps, es, 0, 0);
     c3a:	4681                	li	a3,0
     c3c:	4601                	li	a2,0
     c3e:	fd043583          	ld	a1,-48(s0)
     c42:	fd843503          	ld	a0,-40(s0)
     c46:	00000097          	auipc	ra,0x0
     c4a:	a16080e7          	jalr	-1514(ra) # 65c <gettoken>
  cmd = parseline(ps, es);
     c4e:	fd043583          	ld	a1,-48(s0)
     c52:	fd843503          	ld	a0,-40(s0)
     c56:	00000097          	auipc	ra,0x0
     c5a:	d22080e7          	jalr	-734(ra) # 978 <parseline>
     c5e:	fea43423          	sd	a0,-24(s0)
  if(!peek(ps, es, ")"))
     c62:	00001617          	auipc	a2,0x1
     c66:	20660613          	addi	a2,a2,518 # 1e68 <lock_init+0x10a>
     c6a:	fd043583          	ld	a1,-48(s0)
     c6e:	fd843503          	ld	a0,-40(s0)
     c72:	00000097          	auipc	ra,0x0
     c76:	bc6080e7          	jalr	-1082(ra) # 838 <peek>
     c7a:	87aa                	mv	a5,a0
     c7c:	eb89                	bnez	a5,c8e <parseblock+0x90>
    panic("syntax - missing )");
     c7e:	00001517          	auipc	a0,0x1
     c82:	1f250513          	addi	a0,a0,498 # 1e70 <lock_init+0x112>
     c86:	fffff097          	auipc	ra,0xfffff
     c8a:	7a4080e7          	jalr	1956(ra) # 42a <panic>
  gettoken(ps, es, 0, 0);
     c8e:	4681                	li	a3,0
     c90:	4601                	li	a2,0
     c92:	fd043583          	ld	a1,-48(s0)
     c96:	fd843503          	ld	a0,-40(s0)
     c9a:	00000097          	auipc	ra,0x0
     c9e:	9c2080e7          	jalr	-1598(ra) # 65c <gettoken>
  cmd = parseredirs(cmd, ps, es);
     ca2:	fd043603          	ld	a2,-48(s0)
     ca6:	fd843583          	ld	a1,-40(s0)
     caa:	fe843503          	ld	a0,-24(s0)
     cae:	00000097          	auipc	ra,0x0
     cb2:	e18080e7          	jalr	-488(ra) # ac6 <parseredirs>
     cb6:	fea43423          	sd	a0,-24(s0)
  return cmd;
     cba:	fe843783          	ld	a5,-24(s0)
}
     cbe:	853e                	mv	a0,a5
     cc0:	70a2                	ld	ra,40(sp)
     cc2:	7402                	ld	s0,32(sp)
     cc4:	6145                	addi	sp,sp,48
     cc6:	8082                	ret

0000000000000cc8 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     cc8:	715d                	addi	sp,sp,-80
     cca:	e486                	sd	ra,72(sp)
     ccc:	e0a2                	sd	s0,64(sp)
     cce:	0880                	addi	s0,sp,80
     cd0:	faa43c23          	sd	a0,-72(s0)
     cd4:	fab43823          	sd	a1,-80(s0)
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     cd8:	00001617          	auipc	a2,0x1
     cdc:	17860613          	addi	a2,a2,376 # 1e50 <lock_init+0xf2>
     ce0:	fb043583          	ld	a1,-80(s0)
     ce4:	fb843503          	ld	a0,-72(s0)
     ce8:	00000097          	auipc	ra,0x0
     cec:	b50080e7          	jalr	-1200(ra) # 838 <peek>
     cf0:	87aa                	mv	a5,a0
     cf2:	cb99                	beqz	a5,d08 <parseexec+0x40>
    return parseblock(ps, es);
     cf4:	fb043583          	ld	a1,-80(s0)
     cf8:	fb843503          	ld	a0,-72(s0)
     cfc:	00000097          	auipc	ra,0x0
     d00:	f02080e7          	jalr	-254(ra) # bfe <parseblock>
     d04:	87aa                	mv	a5,a0
     d06:	a22d                	j	e30 <parseexec+0x168>

  ret = execcmd();
     d08:	fffff097          	auipc	ra,0xfffff
     d0c:	790080e7          	jalr	1936(ra) # 498 <execcmd>
     d10:	fea43023          	sd	a0,-32(s0)
  cmd = (struct execcmd*)ret;
     d14:	fe043783          	ld	a5,-32(s0)
     d18:	fcf43c23          	sd	a5,-40(s0)

  argc = 0;
     d1c:	fe042623          	sw	zero,-20(s0)
  ret = parseredirs(ret, ps, es);
     d20:	fb043603          	ld	a2,-80(s0)
     d24:	fb843583          	ld	a1,-72(s0)
     d28:	fe043503          	ld	a0,-32(s0)
     d2c:	00000097          	auipc	ra,0x0
     d30:	d9a080e7          	jalr	-614(ra) # ac6 <parseredirs>
     d34:	fea43023          	sd	a0,-32(s0)
  while(!peek(ps, es, "|)&;")){
     d38:	a84d                	j	dea <parseexec+0x122>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     d3a:	fc040713          	addi	a4,s0,-64
     d3e:	fc840793          	addi	a5,s0,-56
     d42:	86ba                	mv	a3,a4
     d44:	863e                	mv	a2,a5
     d46:	fb043583          	ld	a1,-80(s0)
     d4a:	fb843503          	ld	a0,-72(s0)
     d4e:	00000097          	auipc	ra,0x0
     d52:	90e080e7          	jalr	-1778(ra) # 65c <gettoken>
     d56:	87aa                	mv	a5,a0
     d58:	fcf42a23          	sw	a5,-44(s0)
     d5c:	fd442783          	lw	a5,-44(s0)
     d60:	2781                	sext.w	a5,a5
     d62:	c3dd                	beqz	a5,e08 <parseexec+0x140>
      break;
    if(tok != 'a')
     d64:	fd442783          	lw	a5,-44(s0)
     d68:	0007871b          	sext.w	a4,a5
     d6c:	06100793          	li	a5,97
     d70:	00f70a63          	beq	a4,a5,d84 <parseexec+0xbc>
      panic("syntax");
     d74:	00001517          	auipc	a0,0x1
     d78:	09450513          	addi	a0,a0,148 # 1e08 <lock_init+0xaa>
     d7c:	fffff097          	auipc	ra,0xfffff
     d80:	6ae080e7          	jalr	1710(ra) # 42a <panic>
    cmd->argv[argc] = q;
     d84:	fc843703          	ld	a4,-56(s0)
     d88:	fd843683          	ld	a3,-40(s0)
     d8c:	fec42783          	lw	a5,-20(s0)
     d90:	078e                	slli	a5,a5,0x3
     d92:	97b6                	add	a5,a5,a3
     d94:	e798                	sd	a4,8(a5)
    cmd->eargv[argc] = eq;
     d96:	fc043703          	ld	a4,-64(s0)
     d9a:	fd843683          	ld	a3,-40(s0)
     d9e:	fec42783          	lw	a5,-20(s0)
     da2:	07a9                	addi	a5,a5,10
     da4:	078e                	slli	a5,a5,0x3
     da6:	97b6                	add	a5,a5,a3
     da8:	e798                	sd	a4,8(a5)
    argc++;
     daa:	fec42783          	lw	a5,-20(s0)
     dae:	2785                	addiw	a5,a5,1
     db0:	fef42623          	sw	a5,-20(s0)
    if(argc >= MAXARGS)
     db4:	fec42783          	lw	a5,-20(s0)
     db8:	0007871b          	sext.w	a4,a5
     dbc:	47a5                	li	a5,9
     dbe:	00e7da63          	bge	a5,a4,dd2 <parseexec+0x10a>
      panic("too many args");
     dc2:	00001517          	auipc	a0,0x1
     dc6:	0c650513          	addi	a0,a0,198 # 1e88 <lock_init+0x12a>
     dca:	fffff097          	auipc	ra,0xfffff
     dce:	660080e7          	jalr	1632(ra) # 42a <panic>
    ret = parseredirs(ret, ps, es);
     dd2:	fb043603          	ld	a2,-80(s0)
     dd6:	fb843583          	ld	a1,-72(s0)
     dda:	fe043503          	ld	a0,-32(s0)
     dde:	00000097          	auipc	ra,0x0
     de2:	ce8080e7          	jalr	-792(ra) # ac6 <parseredirs>
     de6:	fea43023          	sd	a0,-32(s0)
  while(!peek(ps, es, "|)&;")){
     dea:	00001617          	auipc	a2,0x1
     dee:	0ae60613          	addi	a2,a2,174 # 1e98 <lock_init+0x13a>
     df2:	fb043583          	ld	a1,-80(s0)
     df6:	fb843503          	ld	a0,-72(s0)
     dfa:	00000097          	auipc	ra,0x0
     dfe:	a3e080e7          	jalr	-1474(ra) # 838 <peek>
     e02:	87aa                	mv	a5,a0
     e04:	db9d                	beqz	a5,d3a <parseexec+0x72>
     e06:	a011                	j	e0a <parseexec+0x142>
      break;
     e08:	0001                	nop
  }
  cmd->argv[argc] = 0;
     e0a:	fd843703          	ld	a4,-40(s0)
     e0e:	fec42783          	lw	a5,-20(s0)
     e12:	078e                	slli	a5,a5,0x3
     e14:	97ba                	add	a5,a5,a4
     e16:	0007b423          	sd	zero,8(a5)
  cmd->eargv[argc] = 0;
     e1a:	fd843703          	ld	a4,-40(s0)
     e1e:	fec42783          	lw	a5,-20(s0)
     e22:	07a9                	addi	a5,a5,10
     e24:	078e                	slli	a5,a5,0x3
     e26:	97ba                	add	a5,a5,a4
     e28:	0007b423          	sd	zero,8(a5)
  return ret;
     e2c:	fe043783          	ld	a5,-32(s0)
}
     e30:	853e                	mv	a0,a5
     e32:	60a6                	ld	ra,72(sp)
     e34:	6406                	ld	s0,64(sp)
     e36:	6161                	addi	sp,sp,80
     e38:	8082                	ret

0000000000000e3a <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     e3a:	715d                	addi	sp,sp,-80
     e3c:	e486                	sd	ra,72(sp)
     e3e:	e0a2                	sd	s0,64(sp)
     e40:	0880                	addi	s0,sp,80
     e42:	faa43c23          	sd	a0,-72(s0)
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     e46:	fb843783          	ld	a5,-72(s0)
     e4a:	e399                	bnez	a5,e50 <nulterminate+0x16>
    return 0;
     e4c:	4781                	li	a5,0
     e4e:	a211                	j	f52 <nulterminate+0x118>

  switch(cmd->type){
     e50:	fb843783          	ld	a5,-72(s0)
     e54:	439c                	lw	a5,0(a5)
     e56:	86be                	mv	a3,a5
     e58:	4715                	li	a4,5
     e5a:	0ed76a63          	bltu	a4,a3,f4e <nulterminate+0x114>
     e5e:	00279713          	slli	a4,a5,0x2
     e62:	00001797          	auipc	a5,0x1
     e66:	03e78793          	addi	a5,a5,62 # 1ea0 <lock_init+0x142>
     e6a:	97ba                	add	a5,a5,a4
     e6c:	439c                	lw	a5,0(a5)
     e6e:	0007871b          	sext.w	a4,a5
     e72:	00001797          	auipc	a5,0x1
     e76:	02e78793          	addi	a5,a5,46 # 1ea0 <lock_init+0x142>
     e7a:	97ba                	add	a5,a5,a4
     e7c:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     e7e:	fb843783          	ld	a5,-72(s0)
     e82:	fcf43023          	sd	a5,-64(s0)
    for(i=0; ecmd->argv[i]; i++)
     e86:	fe042623          	sw	zero,-20(s0)
     e8a:	a005                	j	eaa <nulterminate+0x70>
      *ecmd->eargv[i] = 0;
     e8c:	fc043703          	ld	a4,-64(s0)
     e90:	fec42783          	lw	a5,-20(s0)
     e94:	07a9                	addi	a5,a5,10
     e96:	078e                	slli	a5,a5,0x3
     e98:	97ba                	add	a5,a5,a4
     e9a:	679c                	ld	a5,8(a5)
     e9c:	00078023          	sb	zero,0(a5)
    for(i=0; ecmd->argv[i]; i++)
     ea0:	fec42783          	lw	a5,-20(s0)
     ea4:	2785                	addiw	a5,a5,1
     ea6:	fef42623          	sw	a5,-20(s0)
     eaa:	fc043703          	ld	a4,-64(s0)
     eae:	fec42783          	lw	a5,-20(s0)
     eb2:	078e                	slli	a5,a5,0x3
     eb4:	97ba                	add	a5,a5,a4
     eb6:	679c                	ld	a5,8(a5)
     eb8:	fbf1                	bnez	a5,e8c <nulterminate+0x52>
    break;
     eba:	a851                	j	f4e <nulterminate+0x114>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     ebc:	fb843783          	ld	a5,-72(s0)
     ec0:	fcf43423          	sd	a5,-56(s0)
    nulterminate(rcmd->cmd);
     ec4:	fc843783          	ld	a5,-56(s0)
     ec8:	679c                	ld	a5,8(a5)
     eca:	853e                	mv	a0,a5
     ecc:	00000097          	auipc	ra,0x0
     ed0:	f6e080e7          	jalr	-146(ra) # e3a <nulterminate>
    *rcmd->efile = 0;
     ed4:	fc843783          	ld	a5,-56(s0)
     ed8:	6f9c                	ld	a5,24(a5)
     eda:	00078023          	sb	zero,0(a5)
    break;
     ede:	a885                	j	f4e <nulterminate+0x114>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     ee0:	fb843783          	ld	a5,-72(s0)
     ee4:	fcf43823          	sd	a5,-48(s0)
    nulterminate(pcmd->left);
     ee8:	fd043783          	ld	a5,-48(s0)
     eec:	679c                	ld	a5,8(a5)
     eee:	853e                	mv	a0,a5
     ef0:	00000097          	auipc	ra,0x0
     ef4:	f4a080e7          	jalr	-182(ra) # e3a <nulterminate>
    nulterminate(pcmd->right);
     ef8:	fd043783          	ld	a5,-48(s0)
     efc:	6b9c                	ld	a5,16(a5)
     efe:	853e                	mv	a0,a5
     f00:	00000097          	auipc	ra,0x0
     f04:	f3a080e7          	jalr	-198(ra) # e3a <nulterminate>
    break;
     f08:	a099                	j	f4e <nulterminate+0x114>

  case LIST:
    lcmd = (struct listcmd*)cmd;
     f0a:	fb843783          	ld	a5,-72(s0)
     f0e:	fcf43c23          	sd	a5,-40(s0)
    nulterminate(lcmd->left);
     f12:	fd843783          	ld	a5,-40(s0)
     f16:	679c                	ld	a5,8(a5)
     f18:	853e                	mv	a0,a5
     f1a:	00000097          	auipc	ra,0x0
     f1e:	f20080e7          	jalr	-224(ra) # e3a <nulterminate>
    nulterminate(lcmd->right);
     f22:	fd843783          	ld	a5,-40(s0)
     f26:	6b9c                	ld	a5,16(a5)
     f28:	853e                	mv	a0,a5
     f2a:	00000097          	auipc	ra,0x0
     f2e:	f10080e7          	jalr	-240(ra) # e3a <nulterminate>
    break;
     f32:	a831                	j	f4e <nulterminate+0x114>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     f34:	fb843783          	ld	a5,-72(s0)
     f38:	fef43023          	sd	a5,-32(s0)
    nulterminate(bcmd->cmd);
     f3c:	fe043783          	ld	a5,-32(s0)
     f40:	679c                	ld	a5,8(a5)
     f42:	853e                	mv	a0,a5
     f44:	00000097          	auipc	ra,0x0
     f48:	ef6080e7          	jalr	-266(ra) # e3a <nulterminate>
    break;
     f4c:	0001                	nop
  }
  return cmd;
     f4e:	fb843783          	ld	a5,-72(s0)
}
     f52:	853e                	mv	a0,a5
     f54:	60a6                	ld	ra,72(sp)
     f56:	6406                	ld	s0,64(sp)
     f58:	6161                	addi	sp,sp,80
     f5a:	8082                	ret

0000000000000f5c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     f5c:	7179                	addi	sp,sp,-48
     f5e:	f422                	sd	s0,40(sp)
     f60:	1800                	addi	s0,sp,48
     f62:	fca43c23          	sd	a0,-40(s0)
     f66:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     f6a:	fd843783          	ld	a5,-40(s0)
     f6e:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     f72:	0001                	nop
     f74:	fd043703          	ld	a4,-48(s0)
     f78:	00170793          	addi	a5,a4,1
     f7c:	fcf43823          	sd	a5,-48(s0)
     f80:	fd843783          	ld	a5,-40(s0)
     f84:	00178693          	addi	a3,a5,1
     f88:	fcd43c23          	sd	a3,-40(s0)
     f8c:	00074703          	lbu	a4,0(a4)
     f90:	00e78023          	sb	a4,0(a5)
     f94:	0007c783          	lbu	a5,0(a5)
     f98:	fff1                	bnez	a5,f74 <strcpy+0x18>
    ;
  return os;
     f9a:	fe843783          	ld	a5,-24(s0)
}
     f9e:	853e                	mv	a0,a5
     fa0:	7422                	ld	s0,40(sp)
     fa2:	6145                	addi	sp,sp,48
     fa4:	8082                	ret

0000000000000fa6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     fa6:	1101                	addi	sp,sp,-32
     fa8:	ec22                	sd	s0,24(sp)
     faa:	1000                	addi	s0,sp,32
     fac:	fea43423          	sd	a0,-24(s0)
     fb0:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     fb4:	a819                	j	fca <strcmp+0x24>
    p++, q++;
     fb6:	fe843783          	ld	a5,-24(s0)
     fba:	0785                	addi	a5,a5,1
     fbc:	fef43423          	sd	a5,-24(s0)
     fc0:	fe043783          	ld	a5,-32(s0)
     fc4:	0785                	addi	a5,a5,1
     fc6:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     fca:	fe843783          	ld	a5,-24(s0)
     fce:	0007c783          	lbu	a5,0(a5)
     fd2:	cb99                	beqz	a5,fe8 <strcmp+0x42>
     fd4:	fe843783          	ld	a5,-24(s0)
     fd8:	0007c703          	lbu	a4,0(a5)
     fdc:	fe043783          	ld	a5,-32(s0)
     fe0:	0007c783          	lbu	a5,0(a5)
     fe4:	fcf709e3          	beq	a4,a5,fb6 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     fe8:	fe843783          	ld	a5,-24(s0)
     fec:	0007c783          	lbu	a5,0(a5)
     ff0:	0007871b          	sext.w	a4,a5
     ff4:	fe043783          	ld	a5,-32(s0)
     ff8:	0007c783          	lbu	a5,0(a5)
     ffc:	2781                	sext.w	a5,a5
     ffe:	40f707bb          	subw	a5,a4,a5
    1002:	2781                	sext.w	a5,a5
}
    1004:	853e                	mv	a0,a5
    1006:	6462                	ld	s0,24(sp)
    1008:	6105                	addi	sp,sp,32
    100a:	8082                	ret

000000000000100c <strlen>:

uint
strlen(const char *s)
{
    100c:	7179                	addi	sp,sp,-48
    100e:	f422                	sd	s0,40(sp)
    1010:	1800                	addi	s0,sp,48
    1012:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    1016:	fe042623          	sw	zero,-20(s0)
    101a:	a031                	j	1026 <strlen+0x1a>
    101c:	fec42783          	lw	a5,-20(s0)
    1020:	2785                	addiw	a5,a5,1
    1022:	fef42623          	sw	a5,-20(s0)
    1026:	fec42783          	lw	a5,-20(s0)
    102a:	fd843703          	ld	a4,-40(s0)
    102e:	97ba                	add	a5,a5,a4
    1030:	0007c783          	lbu	a5,0(a5)
    1034:	f7e5                	bnez	a5,101c <strlen+0x10>
    ;
  return n;
    1036:	fec42783          	lw	a5,-20(s0)
}
    103a:	853e                	mv	a0,a5
    103c:	7422                	ld	s0,40(sp)
    103e:	6145                	addi	sp,sp,48
    1040:	8082                	ret

0000000000001042 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1042:	7179                	addi	sp,sp,-48
    1044:	f422                	sd	s0,40(sp)
    1046:	1800                	addi	s0,sp,48
    1048:	fca43c23          	sd	a0,-40(s0)
    104c:	87ae                	mv	a5,a1
    104e:	8732                	mv	a4,a2
    1050:	fcf42a23          	sw	a5,-44(s0)
    1054:	87ba                	mv	a5,a4
    1056:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    105a:	fd843783          	ld	a5,-40(s0)
    105e:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    1062:	fe042623          	sw	zero,-20(s0)
    1066:	a00d                	j	1088 <memset+0x46>
    cdst[i] = c;
    1068:	fec42783          	lw	a5,-20(s0)
    106c:	fe043703          	ld	a4,-32(s0)
    1070:	97ba                	add	a5,a5,a4
    1072:	fd442703          	lw	a4,-44(s0)
    1076:	0ff77713          	zext.b	a4,a4
    107a:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    107e:	fec42783          	lw	a5,-20(s0)
    1082:	2785                	addiw	a5,a5,1
    1084:	fef42623          	sw	a5,-20(s0)
    1088:	fec42703          	lw	a4,-20(s0)
    108c:	fd042783          	lw	a5,-48(s0)
    1090:	2781                	sext.w	a5,a5
    1092:	fcf76be3          	bltu	a4,a5,1068 <memset+0x26>
  }
  return dst;
    1096:	fd843783          	ld	a5,-40(s0)
}
    109a:	853e                	mv	a0,a5
    109c:	7422                	ld	s0,40(sp)
    109e:	6145                	addi	sp,sp,48
    10a0:	8082                	ret

00000000000010a2 <strchr>:

char*
strchr(const char *s, char c)
{
    10a2:	1101                	addi	sp,sp,-32
    10a4:	ec22                	sd	s0,24(sp)
    10a6:	1000                	addi	s0,sp,32
    10a8:	fea43423          	sd	a0,-24(s0)
    10ac:	87ae                	mv	a5,a1
    10ae:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
    10b2:	a01d                	j	10d8 <strchr+0x36>
    if(*s == c)
    10b4:	fe843783          	ld	a5,-24(s0)
    10b8:	0007c703          	lbu	a4,0(a5)
    10bc:	fe744783          	lbu	a5,-25(s0)
    10c0:	0ff7f793          	zext.b	a5,a5
    10c4:	00e79563          	bne	a5,a4,10ce <strchr+0x2c>
      return (char*)s;
    10c8:	fe843783          	ld	a5,-24(s0)
    10cc:	a821                	j	10e4 <strchr+0x42>
  for(; *s; s++)
    10ce:	fe843783          	ld	a5,-24(s0)
    10d2:	0785                	addi	a5,a5,1
    10d4:	fef43423          	sd	a5,-24(s0)
    10d8:	fe843783          	ld	a5,-24(s0)
    10dc:	0007c783          	lbu	a5,0(a5)
    10e0:	fbf1                	bnez	a5,10b4 <strchr+0x12>
  return 0;
    10e2:	4781                	li	a5,0
}
    10e4:	853e                	mv	a0,a5
    10e6:	6462                	ld	s0,24(sp)
    10e8:	6105                	addi	sp,sp,32
    10ea:	8082                	ret

00000000000010ec <gets>:

char*
gets(char *buf, int max)
{
    10ec:	7179                	addi	sp,sp,-48
    10ee:	f406                	sd	ra,40(sp)
    10f0:	f022                	sd	s0,32(sp)
    10f2:	1800                	addi	s0,sp,48
    10f4:	fca43c23          	sd	a0,-40(s0)
    10f8:	87ae                	mv	a5,a1
    10fa:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    10fe:	fe042623          	sw	zero,-20(s0)
    1102:	a8a1                	j	115a <gets+0x6e>
    cc = read(0, &c, 1);
    1104:	fe740793          	addi	a5,s0,-25
    1108:	4605                	li	a2,1
    110a:	85be                	mv	a1,a5
    110c:	4501                	li	a0,0
    110e:	00000097          	auipc	ra,0x0
    1112:	2f8080e7          	jalr	760(ra) # 1406 <read>
    1116:	87aa                	mv	a5,a0
    1118:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
    111c:	fe842783          	lw	a5,-24(s0)
    1120:	2781                	sext.w	a5,a5
    1122:	04f05763          	blez	a5,1170 <gets+0x84>
      break;
    buf[i++] = c;
    1126:	fec42783          	lw	a5,-20(s0)
    112a:	0017871b          	addiw	a4,a5,1
    112e:	fee42623          	sw	a4,-20(s0)
    1132:	873e                	mv	a4,a5
    1134:	fd843783          	ld	a5,-40(s0)
    1138:	97ba                	add	a5,a5,a4
    113a:	fe744703          	lbu	a4,-25(s0)
    113e:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
    1142:	fe744783          	lbu	a5,-25(s0)
    1146:	873e                	mv	a4,a5
    1148:	47a9                	li	a5,10
    114a:	02f70463          	beq	a4,a5,1172 <gets+0x86>
    114e:	fe744783          	lbu	a5,-25(s0)
    1152:	873e                	mv	a4,a5
    1154:	47b5                	li	a5,13
    1156:	00f70e63          	beq	a4,a5,1172 <gets+0x86>
  for(i=0; i+1 < max; ){
    115a:	fec42783          	lw	a5,-20(s0)
    115e:	2785                	addiw	a5,a5,1
    1160:	0007871b          	sext.w	a4,a5
    1164:	fd442783          	lw	a5,-44(s0)
    1168:	2781                	sext.w	a5,a5
    116a:	f8f74de3          	blt	a4,a5,1104 <gets+0x18>
    116e:	a011                	j	1172 <gets+0x86>
      break;
    1170:	0001                	nop
      break;
  }
  buf[i] = '\0';
    1172:	fec42783          	lw	a5,-20(s0)
    1176:	fd843703          	ld	a4,-40(s0)
    117a:	97ba                	add	a5,a5,a4
    117c:	00078023          	sb	zero,0(a5)
  return buf;
    1180:	fd843783          	ld	a5,-40(s0)
}
    1184:	853e                	mv	a0,a5
    1186:	70a2                	ld	ra,40(sp)
    1188:	7402                	ld	s0,32(sp)
    118a:	6145                	addi	sp,sp,48
    118c:	8082                	ret

000000000000118e <stat>:

int
stat(const char *n, struct stat *st)
{
    118e:	7179                	addi	sp,sp,-48
    1190:	f406                	sd	ra,40(sp)
    1192:	f022                	sd	s0,32(sp)
    1194:	1800                	addi	s0,sp,48
    1196:	fca43c23          	sd	a0,-40(s0)
    119a:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    119e:	4581                	li	a1,0
    11a0:	fd843503          	ld	a0,-40(s0)
    11a4:	00000097          	auipc	ra,0x0
    11a8:	28a080e7          	jalr	650(ra) # 142e <open>
    11ac:	87aa                	mv	a5,a0
    11ae:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
    11b2:	fec42783          	lw	a5,-20(s0)
    11b6:	2781                	sext.w	a5,a5
    11b8:	0007d463          	bgez	a5,11c0 <stat+0x32>
    return -1;
    11bc:	57fd                	li	a5,-1
    11be:	a035                	j	11ea <stat+0x5c>
  r = fstat(fd, st);
    11c0:	fec42783          	lw	a5,-20(s0)
    11c4:	fd043583          	ld	a1,-48(s0)
    11c8:	853e                	mv	a0,a5
    11ca:	00000097          	auipc	ra,0x0
    11ce:	27c080e7          	jalr	636(ra) # 1446 <fstat>
    11d2:	87aa                	mv	a5,a0
    11d4:	fef42423          	sw	a5,-24(s0)
  close(fd);
    11d8:	fec42783          	lw	a5,-20(s0)
    11dc:	853e                	mv	a0,a5
    11de:	00000097          	auipc	ra,0x0
    11e2:	238080e7          	jalr	568(ra) # 1416 <close>
  return r;
    11e6:	fe842783          	lw	a5,-24(s0)
}
    11ea:	853e                	mv	a0,a5
    11ec:	70a2                	ld	ra,40(sp)
    11ee:	7402                	ld	s0,32(sp)
    11f0:	6145                	addi	sp,sp,48
    11f2:	8082                	ret

00000000000011f4 <atoi>:

int
atoi(const char *s)
{
    11f4:	7179                	addi	sp,sp,-48
    11f6:	f422                	sd	s0,40(sp)
    11f8:	1800                	addi	s0,sp,48
    11fa:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
    11fe:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
    1202:	a81d                	j	1238 <atoi+0x44>
    n = n*10 + *s++ - '0';
    1204:	fec42783          	lw	a5,-20(s0)
    1208:	873e                	mv	a4,a5
    120a:	87ba                	mv	a5,a4
    120c:	0027979b          	slliw	a5,a5,0x2
    1210:	9fb9                	addw	a5,a5,a4
    1212:	0017979b          	slliw	a5,a5,0x1
    1216:	0007871b          	sext.w	a4,a5
    121a:	fd843783          	ld	a5,-40(s0)
    121e:	00178693          	addi	a3,a5,1
    1222:	fcd43c23          	sd	a3,-40(s0)
    1226:	0007c783          	lbu	a5,0(a5)
    122a:	2781                	sext.w	a5,a5
    122c:	9fb9                	addw	a5,a5,a4
    122e:	2781                	sext.w	a5,a5
    1230:	fd07879b          	addiw	a5,a5,-48
    1234:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
    1238:	fd843783          	ld	a5,-40(s0)
    123c:	0007c783          	lbu	a5,0(a5)
    1240:	873e                	mv	a4,a5
    1242:	02f00793          	li	a5,47
    1246:	00e7fb63          	bgeu	a5,a4,125c <atoi+0x68>
    124a:	fd843783          	ld	a5,-40(s0)
    124e:	0007c783          	lbu	a5,0(a5)
    1252:	873e                	mv	a4,a5
    1254:	03900793          	li	a5,57
    1258:	fae7f6e3          	bgeu	a5,a4,1204 <atoi+0x10>
  return n;
    125c:	fec42783          	lw	a5,-20(s0)
}
    1260:	853e                	mv	a0,a5
    1262:	7422                	ld	s0,40(sp)
    1264:	6145                	addi	sp,sp,48
    1266:	8082                	ret

0000000000001268 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1268:	7139                	addi	sp,sp,-64
    126a:	fc22                	sd	s0,56(sp)
    126c:	0080                	addi	s0,sp,64
    126e:	fca43c23          	sd	a0,-40(s0)
    1272:	fcb43823          	sd	a1,-48(s0)
    1276:	87b2                	mv	a5,a2
    1278:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
    127c:	fd843783          	ld	a5,-40(s0)
    1280:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
    1284:	fd043783          	ld	a5,-48(s0)
    1288:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
    128c:	fe043703          	ld	a4,-32(s0)
    1290:	fe843783          	ld	a5,-24(s0)
    1294:	02e7fc63          	bgeu	a5,a4,12cc <memmove+0x64>
    while(n-- > 0)
    1298:	a00d                	j	12ba <memmove+0x52>
      *dst++ = *src++;
    129a:	fe043703          	ld	a4,-32(s0)
    129e:	00170793          	addi	a5,a4,1
    12a2:	fef43023          	sd	a5,-32(s0)
    12a6:	fe843783          	ld	a5,-24(s0)
    12aa:	00178693          	addi	a3,a5,1
    12ae:	fed43423          	sd	a3,-24(s0)
    12b2:	00074703          	lbu	a4,0(a4)
    12b6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    12ba:	fcc42783          	lw	a5,-52(s0)
    12be:	fff7871b          	addiw	a4,a5,-1
    12c2:	fce42623          	sw	a4,-52(s0)
    12c6:	fcf04ae3          	bgtz	a5,129a <memmove+0x32>
    12ca:	a891                	j	131e <memmove+0xb6>
  } else {
    dst += n;
    12cc:	fcc42783          	lw	a5,-52(s0)
    12d0:	fe843703          	ld	a4,-24(s0)
    12d4:	97ba                	add	a5,a5,a4
    12d6:	fef43423          	sd	a5,-24(s0)
    src += n;
    12da:	fcc42783          	lw	a5,-52(s0)
    12de:	fe043703          	ld	a4,-32(s0)
    12e2:	97ba                	add	a5,a5,a4
    12e4:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    12e8:	a01d                	j	130e <memmove+0xa6>
      *--dst = *--src;
    12ea:	fe043783          	ld	a5,-32(s0)
    12ee:	17fd                	addi	a5,a5,-1
    12f0:	fef43023          	sd	a5,-32(s0)
    12f4:	fe843783          	ld	a5,-24(s0)
    12f8:	17fd                	addi	a5,a5,-1
    12fa:	fef43423          	sd	a5,-24(s0)
    12fe:	fe043783          	ld	a5,-32(s0)
    1302:	0007c703          	lbu	a4,0(a5)
    1306:	fe843783          	ld	a5,-24(s0)
    130a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    130e:	fcc42783          	lw	a5,-52(s0)
    1312:	fff7871b          	addiw	a4,a5,-1
    1316:	fce42623          	sw	a4,-52(s0)
    131a:	fcf048e3          	bgtz	a5,12ea <memmove+0x82>
  }
  return vdst;
    131e:	fd843783          	ld	a5,-40(s0)
}
    1322:	853e                	mv	a0,a5
    1324:	7462                	ld	s0,56(sp)
    1326:	6121                	addi	sp,sp,64
    1328:	8082                	ret

000000000000132a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    132a:	7139                	addi	sp,sp,-64
    132c:	fc22                	sd	s0,56(sp)
    132e:	0080                	addi	s0,sp,64
    1330:	fca43c23          	sd	a0,-40(s0)
    1334:	fcb43823          	sd	a1,-48(s0)
    1338:	87b2                	mv	a5,a2
    133a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
    133e:	fd843783          	ld	a5,-40(s0)
    1342:	fef43423          	sd	a5,-24(s0)
    1346:	fd043783          	ld	a5,-48(s0)
    134a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    134e:	a0a1                	j	1396 <memcmp+0x6c>
    if (*p1 != *p2) {
    1350:	fe843783          	ld	a5,-24(s0)
    1354:	0007c703          	lbu	a4,0(a5)
    1358:	fe043783          	ld	a5,-32(s0)
    135c:	0007c783          	lbu	a5,0(a5)
    1360:	02f70163          	beq	a4,a5,1382 <memcmp+0x58>
      return *p1 - *p2;
    1364:	fe843783          	ld	a5,-24(s0)
    1368:	0007c783          	lbu	a5,0(a5)
    136c:	0007871b          	sext.w	a4,a5
    1370:	fe043783          	ld	a5,-32(s0)
    1374:	0007c783          	lbu	a5,0(a5)
    1378:	2781                	sext.w	a5,a5
    137a:	40f707bb          	subw	a5,a4,a5
    137e:	2781                	sext.w	a5,a5
    1380:	a01d                	j	13a6 <memcmp+0x7c>
    }
    p1++;
    1382:	fe843783          	ld	a5,-24(s0)
    1386:	0785                	addi	a5,a5,1
    1388:	fef43423          	sd	a5,-24(s0)
    p2++;
    138c:	fe043783          	ld	a5,-32(s0)
    1390:	0785                	addi	a5,a5,1
    1392:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    1396:	fcc42783          	lw	a5,-52(s0)
    139a:	fff7871b          	addiw	a4,a5,-1
    139e:	fce42623          	sw	a4,-52(s0)
    13a2:	f7dd                	bnez	a5,1350 <memcmp+0x26>
  }
  return 0;
    13a4:	4781                	li	a5,0
}
    13a6:	853e                	mv	a0,a5
    13a8:	7462                	ld	s0,56(sp)
    13aa:	6121                	addi	sp,sp,64
    13ac:	8082                	ret

00000000000013ae <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    13ae:	7179                	addi	sp,sp,-48
    13b0:	f406                	sd	ra,40(sp)
    13b2:	f022                	sd	s0,32(sp)
    13b4:	1800                	addi	s0,sp,48
    13b6:	fea43423          	sd	a0,-24(s0)
    13ba:	feb43023          	sd	a1,-32(s0)
    13be:	87b2                	mv	a5,a2
    13c0:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    13c4:	fdc42783          	lw	a5,-36(s0)
    13c8:	863e                	mv	a2,a5
    13ca:	fe043583          	ld	a1,-32(s0)
    13ce:	fe843503          	ld	a0,-24(s0)
    13d2:	00000097          	auipc	ra,0x0
    13d6:	e96080e7          	jalr	-362(ra) # 1268 <memmove>
    13da:	87aa                	mv	a5,a0
}
    13dc:	853e                	mv	a0,a5
    13de:	70a2                	ld	ra,40(sp)
    13e0:	7402                	ld	s0,32(sp)
    13e2:	6145                	addi	sp,sp,48
    13e4:	8082                	ret

00000000000013e6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    13e6:	4885                	li	a7,1
 ecall
    13e8:	00000073          	ecall
 ret
    13ec:	8082                	ret

00000000000013ee <exit>:
.global exit
exit:
 li a7, SYS_exit
    13ee:	4889                	li	a7,2
 ecall
    13f0:	00000073          	ecall
 ret
    13f4:	8082                	ret

00000000000013f6 <wait>:
.global wait
wait:
 li a7, SYS_wait
    13f6:	488d                	li	a7,3
 ecall
    13f8:	00000073          	ecall
 ret
    13fc:	8082                	ret

00000000000013fe <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    13fe:	4891                	li	a7,4
 ecall
    1400:	00000073          	ecall
 ret
    1404:	8082                	ret

0000000000001406 <read>:
.global read
read:
 li a7, SYS_read
    1406:	4895                	li	a7,5
 ecall
    1408:	00000073          	ecall
 ret
    140c:	8082                	ret

000000000000140e <write>:
.global write
write:
 li a7, SYS_write
    140e:	48c1                	li	a7,16
 ecall
    1410:	00000073          	ecall
 ret
    1414:	8082                	ret

0000000000001416 <close>:
.global close
close:
 li a7, SYS_close
    1416:	48d5                	li	a7,21
 ecall
    1418:	00000073          	ecall
 ret
    141c:	8082                	ret

000000000000141e <kill>:
.global kill
kill:
 li a7, SYS_kill
    141e:	4899                	li	a7,6
 ecall
    1420:	00000073          	ecall
 ret
    1424:	8082                	ret

0000000000001426 <exec>:
.global exec
exec:
 li a7, SYS_exec
    1426:	489d                	li	a7,7
 ecall
    1428:	00000073          	ecall
 ret
    142c:	8082                	ret

000000000000142e <open>:
.global open
open:
 li a7, SYS_open
    142e:	48bd                	li	a7,15
 ecall
    1430:	00000073          	ecall
 ret
    1434:	8082                	ret

0000000000001436 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    1436:	48c5                	li	a7,17
 ecall
    1438:	00000073          	ecall
 ret
    143c:	8082                	ret

000000000000143e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    143e:	48c9                	li	a7,18
 ecall
    1440:	00000073          	ecall
 ret
    1444:	8082                	ret

0000000000001446 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    1446:	48a1                	li	a7,8
 ecall
    1448:	00000073          	ecall
 ret
    144c:	8082                	ret

000000000000144e <link>:
.global link
link:
 li a7, SYS_link
    144e:	48cd                	li	a7,19
 ecall
    1450:	00000073          	ecall
 ret
    1454:	8082                	ret

0000000000001456 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1456:	48d1                	li	a7,20
 ecall
    1458:	00000073          	ecall
 ret
    145c:	8082                	ret

000000000000145e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    145e:	48a5                	li	a7,9
 ecall
    1460:	00000073          	ecall
 ret
    1464:	8082                	ret

0000000000001466 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1466:	48a9                	li	a7,10
 ecall
    1468:	00000073          	ecall
 ret
    146c:	8082                	ret

000000000000146e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    146e:	48ad                	li	a7,11
 ecall
    1470:	00000073          	ecall
 ret
    1474:	8082                	ret

0000000000001476 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1476:	48b1                	li	a7,12
 ecall
    1478:	00000073          	ecall
 ret
    147c:	8082                	ret

000000000000147e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    147e:	48b5                	li	a7,13
 ecall
    1480:	00000073          	ecall
 ret
    1484:	8082                	ret

0000000000001486 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1486:	48b9                	li	a7,14
 ecall
    1488:	00000073          	ecall
 ret
    148c:	8082                	ret

000000000000148e <clone>:
.global clone
clone:
 li a7, SYS_clone
    148e:	48d9                	li	a7,22
 ecall
    1490:	00000073          	ecall
 ret
    1494:	8082                	ret

0000000000001496 <join>:
.global join
join:
 li a7, SYS_join
    1496:	48dd                	li	a7,23
 ecall
    1498:	00000073          	ecall
 ret
    149c:	8082                	ret

000000000000149e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    149e:	1101                	addi	sp,sp,-32
    14a0:	ec06                	sd	ra,24(sp)
    14a2:	e822                	sd	s0,16(sp)
    14a4:	1000                	addi	s0,sp,32
    14a6:	87aa                	mv	a5,a0
    14a8:	872e                	mv	a4,a1
    14aa:	fef42623          	sw	a5,-20(s0)
    14ae:	87ba                	mv	a5,a4
    14b0:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
    14b4:	feb40713          	addi	a4,s0,-21
    14b8:	fec42783          	lw	a5,-20(s0)
    14bc:	4605                	li	a2,1
    14be:	85ba                	mv	a1,a4
    14c0:	853e                	mv	a0,a5
    14c2:	00000097          	auipc	ra,0x0
    14c6:	f4c080e7          	jalr	-180(ra) # 140e <write>
}
    14ca:	0001                	nop
    14cc:	60e2                	ld	ra,24(sp)
    14ce:	6442                	ld	s0,16(sp)
    14d0:	6105                	addi	sp,sp,32
    14d2:	8082                	ret

00000000000014d4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    14d4:	7139                	addi	sp,sp,-64
    14d6:	fc06                	sd	ra,56(sp)
    14d8:	f822                	sd	s0,48(sp)
    14da:	0080                	addi	s0,sp,64
    14dc:	87aa                	mv	a5,a0
    14de:	8736                	mv	a4,a3
    14e0:	fcf42623          	sw	a5,-52(s0)
    14e4:	87ae                	mv	a5,a1
    14e6:	fcf42423          	sw	a5,-56(s0)
    14ea:	87b2                	mv	a5,a2
    14ec:	fcf42223          	sw	a5,-60(s0)
    14f0:	87ba                	mv	a5,a4
    14f2:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    14f6:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
    14fa:	fc042783          	lw	a5,-64(s0)
    14fe:	2781                	sext.w	a5,a5
    1500:	c38d                	beqz	a5,1522 <printint+0x4e>
    1502:	fc842783          	lw	a5,-56(s0)
    1506:	2781                	sext.w	a5,a5
    1508:	0007dd63          	bgez	a5,1522 <printint+0x4e>
    neg = 1;
    150c:	4785                	li	a5,1
    150e:	fef42423          	sw	a5,-24(s0)
    x = -xx;
    1512:	fc842783          	lw	a5,-56(s0)
    1516:	40f007bb          	negw	a5,a5
    151a:	2781                	sext.w	a5,a5
    151c:	fef42223          	sw	a5,-28(s0)
    1520:	a029                	j	152a <printint+0x56>
  } else {
    x = xx;
    1522:	fc842783          	lw	a5,-56(s0)
    1526:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
    152a:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
    152e:	fc442783          	lw	a5,-60(s0)
    1532:	fe442703          	lw	a4,-28(s0)
    1536:	02f777bb          	remuw	a5,a4,a5
    153a:	0007861b          	sext.w	a2,a5
    153e:	fec42783          	lw	a5,-20(s0)
    1542:	0017871b          	addiw	a4,a5,1
    1546:	fee42623          	sw	a4,-20(s0)
    154a:	00001697          	auipc	a3,0x1
    154e:	9c668693          	addi	a3,a3,-1594 # 1f10 <digits>
    1552:	02061713          	slli	a4,a2,0x20
    1556:	9301                	srli	a4,a4,0x20
    1558:	9736                	add	a4,a4,a3
    155a:	00074703          	lbu	a4,0(a4)
    155e:	17c1                	addi	a5,a5,-16
    1560:	97a2                	add	a5,a5,s0
    1562:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
    1566:	fc442783          	lw	a5,-60(s0)
    156a:	fe442703          	lw	a4,-28(s0)
    156e:	02f757bb          	divuw	a5,a4,a5
    1572:	fef42223          	sw	a5,-28(s0)
    1576:	fe442783          	lw	a5,-28(s0)
    157a:	2781                	sext.w	a5,a5
    157c:	fbcd                	bnez	a5,152e <printint+0x5a>
  if(neg)
    157e:	fe842783          	lw	a5,-24(s0)
    1582:	2781                	sext.w	a5,a5
    1584:	cf85                	beqz	a5,15bc <printint+0xe8>
    buf[i++] = '-';
    1586:	fec42783          	lw	a5,-20(s0)
    158a:	0017871b          	addiw	a4,a5,1
    158e:	fee42623          	sw	a4,-20(s0)
    1592:	17c1                	addi	a5,a5,-16
    1594:	97a2                	add	a5,a5,s0
    1596:	02d00713          	li	a4,45
    159a:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
    159e:	a839                	j	15bc <printint+0xe8>
    putc(fd, buf[i]);
    15a0:	fec42783          	lw	a5,-20(s0)
    15a4:	17c1                	addi	a5,a5,-16
    15a6:	97a2                	add	a5,a5,s0
    15a8:	fe07c703          	lbu	a4,-32(a5)
    15ac:	fcc42783          	lw	a5,-52(s0)
    15b0:	85ba                	mv	a1,a4
    15b2:	853e                	mv	a0,a5
    15b4:	00000097          	auipc	ra,0x0
    15b8:	eea080e7          	jalr	-278(ra) # 149e <putc>
  while(--i >= 0)
    15bc:	fec42783          	lw	a5,-20(s0)
    15c0:	37fd                	addiw	a5,a5,-1
    15c2:	fef42623          	sw	a5,-20(s0)
    15c6:	fec42783          	lw	a5,-20(s0)
    15ca:	2781                	sext.w	a5,a5
    15cc:	fc07dae3          	bgez	a5,15a0 <printint+0xcc>
}
    15d0:	0001                	nop
    15d2:	0001                	nop
    15d4:	70e2                	ld	ra,56(sp)
    15d6:	7442                	ld	s0,48(sp)
    15d8:	6121                	addi	sp,sp,64
    15da:	8082                	ret

00000000000015dc <printptr>:

static void
printptr(int fd, uint64 x) {
    15dc:	7179                	addi	sp,sp,-48
    15de:	f406                	sd	ra,40(sp)
    15e0:	f022                	sd	s0,32(sp)
    15e2:	1800                	addi	s0,sp,48
    15e4:	87aa                	mv	a5,a0
    15e6:	fcb43823          	sd	a1,-48(s0)
    15ea:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    15ee:	fdc42783          	lw	a5,-36(s0)
    15f2:	03000593          	li	a1,48
    15f6:	853e                	mv	a0,a5
    15f8:	00000097          	auipc	ra,0x0
    15fc:	ea6080e7          	jalr	-346(ra) # 149e <putc>
  putc(fd, 'x');
    1600:	fdc42783          	lw	a5,-36(s0)
    1604:	07800593          	li	a1,120
    1608:	853e                	mv	a0,a5
    160a:	00000097          	auipc	ra,0x0
    160e:	e94080e7          	jalr	-364(ra) # 149e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1612:	fe042623          	sw	zero,-20(s0)
    1616:	a82d                	j	1650 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1618:	fd043783          	ld	a5,-48(s0)
    161c:	93f1                	srli	a5,a5,0x3c
    161e:	00001717          	auipc	a4,0x1
    1622:	8f270713          	addi	a4,a4,-1806 # 1f10 <digits>
    1626:	97ba                	add	a5,a5,a4
    1628:	0007c703          	lbu	a4,0(a5)
    162c:	fdc42783          	lw	a5,-36(s0)
    1630:	85ba                	mv	a1,a4
    1632:	853e                	mv	a0,a5
    1634:	00000097          	auipc	ra,0x0
    1638:	e6a080e7          	jalr	-406(ra) # 149e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    163c:	fec42783          	lw	a5,-20(s0)
    1640:	2785                	addiw	a5,a5,1
    1642:	fef42623          	sw	a5,-20(s0)
    1646:	fd043783          	ld	a5,-48(s0)
    164a:	0792                	slli	a5,a5,0x4
    164c:	fcf43823          	sd	a5,-48(s0)
    1650:	fec42783          	lw	a5,-20(s0)
    1654:	873e                	mv	a4,a5
    1656:	47bd                	li	a5,15
    1658:	fce7f0e3          	bgeu	a5,a4,1618 <printptr+0x3c>
}
    165c:	0001                	nop
    165e:	0001                	nop
    1660:	70a2                	ld	ra,40(sp)
    1662:	7402                	ld	s0,32(sp)
    1664:	6145                	addi	sp,sp,48
    1666:	8082                	ret

0000000000001668 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1668:	715d                	addi	sp,sp,-80
    166a:	e486                	sd	ra,72(sp)
    166c:	e0a2                	sd	s0,64(sp)
    166e:	0880                	addi	s0,sp,80
    1670:	87aa                	mv	a5,a0
    1672:	fcb43023          	sd	a1,-64(s0)
    1676:	fac43c23          	sd	a2,-72(s0)
    167a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
    167e:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    1682:	fe042223          	sw	zero,-28(s0)
    1686:	a42d                	j	18b0 <vprintf+0x248>
    c = fmt[i] & 0xff;
    1688:	fe442783          	lw	a5,-28(s0)
    168c:	fc043703          	ld	a4,-64(s0)
    1690:	97ba                	add	a5,a5,a4
    1692:	0007c783          	lbu	a5,0(a5)
    1696:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
    169a:	fe042783          	lw	a5,-32(s0)
    169e:	2781                	sext.w	a5,a5
    16a0:	eb9d                	bnez	a5,16d6 <vprintf+0x6e>
      if(c == '%'){
    16a2:	fdc42783          	lw	a5,-36(s0)
    16a6:	0007871b          	sext.w	a4,a5
    16aa:	02500793          	li	a5,37
    16ae:	00f71763          	bne	a4,a5,16bc <vprintf+0x54>
        state = '%';
    16b2:	02500793          	li	a5,37
    16b6:	fef42023          	sw	a5,-32(s0)
    16ba:	a2f5                	j	18a6 <vprintf+0x23e>
      } else {
        putc(fd, c);
    16bc:	fdc42783          	lw	a5,-36(s0)
    16c0:	0ff7f713          	zext.b	a4,a5
    16c4:	fcc42783          	lw	a5,-52(s0)
    16c8:	85ba                	mv	a1,a4
    16ca:	853e                	mv	a0,a5
    16cc:	00000097          	auipc	ra,0x0
    16d0:	dd2080e7          	jalr	-558(ra) # 149e <putc>
    16d4:	aac9                	j	18a6 <vprintf+0x23e>
      }
    } else if(state == '%'){
    16d6:	fe042783          	lw	a5,-32(s0)
    16da:	0007871b          	sext.w	a4,a5
    16de:	02500793          	li	a5,37
    16e2:	1cf71263          	bne	a4,a5,18a6 <vprintf+0x23e>
      if(c == 'd'){
    16e6:	fdc42783          	lw	a5,-36(s0)
    16ea:	0007871b          	sext.w	a4,a5
    16ee:	06400793          	li	a5,100
    16f2:	02f71463          	bne	a4,a5,171a <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
    16f6:	fb843783          	ld	a5,-72(s0)
    16fa:	00878713          	addi	a4,a5,8
    16fe:	fae43c23          	sd	a4,-72(s0)
    1702:	4398                	lw	a4,0(a5)
    1704:	fcc42783          	lw	a5,-52(s0)
    1708:	4685                	li	a3,1
    170a:	4629                	li	a2,10
    170c:	85ba                	mv	a1,a4
    170e:	853e                	mv	a0,a5
    1710:	00000097          	auipc	ra,0x0
    1714:	dc4080e7          	jalr	-572(ra) # 14d4 <printint>
    1718:	a269                	j	18a2 <vprintf+0x23a>
      } else if(c == 'l') {
    171a:	fdc42783          	lw	a5,-36(s0)
    171e:	0007871b          	sext.w	a4,a5
    1722:	06c00793          	li	a5,108
    1726:	02f71663          	bne	a4,a5,1752 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
    172a:	fb843783          	ld	a5,-72(s0)
    172e:	00878713          	addi	a4,a5,8
    1732:	fae43c23          	sd	a4,-72(s0)
    1736:	639c                	ld	a5,0(a5)
    1738:	0007871b          	sext.w	a4,a5
    173c:	fcc42783          	lw	a5,-52(s0)
    1740:	4681                	li	a3,0
    1742:	4629                	li	a2,10
    1744:	85ba                	mv	a1,a4
    1746:	853e                	mv	a0,a5
    1748:	00000097          	auipc	ra,0x0
    174c:	d8c080e7          	jalr	-628(ra) # 14d4 <printint>
    1750:	aa89                	j	18a2 <vprintf+0x23a>
      } else if(c == 'x') {
    1752:	fdc42783          	lw	a5,-36(s0)
    1756:	0007871b          	sext.w	a4,a5
    175a:	07800793          	li	a5,120
    175e:	02f71463          	bne	a4,a5,1786 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
    1762:	fb843783          	ld	a5,-72(s0)
    1766:	00878713          	addi	a4,a5,8
    176a:	fae43c23          	sd	a4,-72(s0)
    176e:	4398                	lw	a4,0(a5)
    1770:	fcc42783          	lw	a5,-52(s0)
    1774:	4681                	li	a3,0
    1776:	4641                	li	a2,16
    1778:	85ba                	mv	a1,a4
    177a:	853e                	mv	a0,a5
    177c:	00000097          	auipc	ra,0x0
    1780:	d58080e7          	jalr	-680(ra) # 14d4 <printint>
    1784:	aa39                	j	18a2 <vprintf+0x23a>
      } else if(c == 'p') {
    1786:	fdc42783          	lw	a5,-36(s0)
    178a:	0007871b          	sext.w	a4,a5
    178e:	07000793          	li	a5,112
    1792:	02f71263          	bne	a4,a5,17b6 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
    1796:	fb843783          	ld	a5,-72(s0)
    179a:	00878713          	addi	a4,a5,8
    179e:	fae43c23          	sd	a4,-72(s0)
    17a2:	6398                	ld	a4,0(a5)
    17a4:	fcc42783          	lw	a5,-52(s0)
    17a8:	85ba                	mv	a1,a4
    17aa:	853e                	mv	a0,a5
    17ac:	00000097          	auipc	ra,0x0
    17b0:	e30080e7          	jalr	-464(ra) # 15dc <printptr>
    17b4:	a0fd                	j	18a2 <vprintf+0x23a>
      } else if(c == 's'){
    17b6:	fdc42783          	lw	a5,-36(s0)
    17ba:	0007871b          	sext.w	a4,a5
    17be:	07300793          	li	a5,115
    17c2:	04f71c63          	bne	a4,a5,181a <vprintf+0x1b2>
        s = va_arg(ap, char*);
    17c6:	fb843783          	ld	a5,-72(s0)
    17ca:	00878713          	addi	a4,a5,8
    17ce:	fae43c23          	sd	a4,-72(s0)
    17d2:	639c                	ld	a5,0(a5)
    17d4:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
    17d8:	fe843783          	ld	a5,-24(s0)
    17dc:	eb8d                	bnez	a5,180e <vprintf+0x1a6>
          s = "(null)";
    17de:	00000797          	auipc	a5,0x0
    17e2:	6da78793          	addi	a5,a5,1754 # 1eb8 <lock_init+0x15a>
    17e6:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    17ea:	a015                	j	180e <vprintf+0x1a6>
          putc(fd, *s);
    17ec:	fe843783          	ld	a5,-24(s0)
    17f0:	0007c703          	lbu	a4,0(a5)
    17f4:	fcc42783          	lw	a5,-52(s0)
    17f8:	85ba                	mv	a1,a4
    17fa:	853e                	mv	a0,a5
    17fc:	00000097          	auipc	ra,0x0
    1800:	ca2080e7          	jalr	-862(ra) # 149e <putc>
          s++;
    1804:	fe843783          	ld	a5,-24(s0)
    1808:	0785                	addi	a5,a5,1
    180a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    180e:	fe843783          	ld	a5,-24(s0)
    1812:	0007c783          	lbu	a5,0(a5)
    1816:	fbf9                	bnez	a5,17ec <vprintf+0x184>
    1818:	a069                	j	18a2 <vprintf+0x23a>
        }
      } else if(c == 'c'){
    181a:	fdc42783          	lw	a5,-36(s0)
    181e:	0007871b          	sext.w	a4,a5
    1822:	06300793          	li	a5,99
    1826:	02f71463          	bne	a4,a5,184e <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
    182a:	fb843783          	ld	a5,-72(s0)
    182e:	00878713          	addi	a4,a5,8
    1832:	fae43c23          	sd	a4,-72(s0)
    1836:	439c                	lw	a5,0(a5)
    1838:	0ff7f713          	zext.b	a4,a5
    183c:	fcc42783          	lw	a5,-52(s0)
    1840:	85ba                	mv	a1,a4
    1842:	853e                	mv	a0,a5
    1844:	00000097          	auipc	ra,0x0
    1848:	c5a080e7          	jalr	-934(ra) # 149e <putc>
    184c:	a899                	j	18a2 <vprintf+0x23a>
      } else if(c == '%'){
    184e:	fdc42783          	lw	a5,-36(s0)
    1852:	0007871b          	sext.w	a4,a5
    1856:	02500793          	li	a5,37
    185a:	00f71f63          	bne	a4,a5,1878 <vprintf+0x210>
        putc(fd, c);
    185e:	fdc42783          	lw	a5,-36(s0)
    1862:	0ff7f713          	zext.b	a4,a5
    1866:	fcc42783          	lw	a5,-52(s0)
    186a:	85ba                	mv	a1,a4
    186c:	853e                	mv	a0,a5
    186e:	00000097          	auipc	ra,0x0
    1872:	c30080e7          	jalr	-976(ra) # 149e <putc>
    1876:	a035                	j	18a2 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1878:	fcc42783          	lw	a5,-52(s0)
    187c:	02500593          	li	a1,37
    1880:	853e                	mv	a0,a5
    1882:	00000097          	auipc	ra,0x0
    1886:	c1c080e7          	jalr	-996(ra) # 149e <putc>
        putc(fd, c);
    188a:	fdc42783          	lw	a5,-36(s0)
    188e:	0ff7f713          	zext.b	a4,a5
    1892:	fcc42783          	lw	a5,-52(s0)
    1896:	85ba                	mv	a1,a4
    1898:	853e                	mv	a0,a5
    189a:	00000097          	auipc	ra,0x0
    189e:	c04080e7          	jalr	-1020(ra) # 149e <putc>
      }
      state = 0;
    18a2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    18a6:	fe442783          	lw	a5,-28(s0)
    18aa:	2785                	addiw	a5,a5,1
    18ac:	fef42223          	sw	a5,-28(s0)
    18b0:	fe442783          	lw	a5,-28(s0)
    18b4:	fc043703          	ld	a4,-64(s0)
    18b8:	97ba                	add	a5,a5,a4
    18ba:	0007c783          	lbu	a5,0(a5)
    18be:	dc0795e3          	bnez	a5,1688 <vprintf+0x20>
    }
  }
}
    18c2:	0001                	nop
    18c4:	0001                	nop
    18c6:	60a6                	ld	ra,72(sp)
    18c8:	6406                	ld	s0,64(sp)
    18ca:	6161                	addi	sp,sp,80
    18cc:	8082                	ret

00000000000018ce <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    18ce:	7159                	addi	sp,sp,-112
    18d0:	fc06                	sd	ra,56(sp)
    18d2:	f822                	sd	s0,48(sp)
    18d4:	0080                	addi	s0,sp,64
    18d6:	fcb43823          	sd	a1,-48(s0)
    18da:	e010                	sd	a2,0(s0)
    18dc:	e414                	sd	a3,8(s0)
    18de:	e818                	sd	a4,16(s0)
    18e0:	ec1c                	sd	a5,24(s0)
    18e2:	03043023          	sd	a6,32(s0)
    18e6:	03143423          	sd	a7,40(s0)
    18ea:	87aa                	mv	a5,a0
    18ec:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    18f0:	03040793          	addi	a5,s0,48
    18f4:	fcf43423          	sd	a5,-56(s0)
    18f8:	fc843783          	ld	a5,-56(s0)
    18fc:	fd078793          	addi	a5,a5,-48
    1900:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    1904:	fe843703          	ld	a4,-24(s0)
    1908:	fdc42783          	lw	a5,-36(s0)
    190c:	863a                	mv	a2,a4
    190e:	fd043583          	ld	a1,-48(s0)
    1912:	853e                	mv	a0,a5
    1914:	00000097          	auipc	ra,0x0
    1918:	d54080e7          	jalr	-684(ra) # 1668 <vprintf>
}
    191c:	0001                	nop
    191e:	70e2                	ld	ra,56(sp)
    1920:	7442                	ld	s0,48(sp)
    1922:	6165                	addi	sp,sp,112
    1924:	8082                	ret

0000000000001926 <printf>:

void
printf(const char *fmt, ...)
{
    1926:	7159                	addi	sp,sp,-112
    1928:	f406                	sd	ra,40(sp)
    192a:	f022                	sd	s0,32(sp)
    192c:	1800                	addi	s0,sp,48
    192e:	fca43c23          	sd	a0,-40(s0)
    1932:	e40c                	sd	a1,8(s0)
    1934:	e810                	sd	a2,16(s0)
    1936:	ec14                	sd	a3,24(s0)
    1938:	f018                	sd	a4,32(s0)
    193a:	f41c                	sd	a5,40(s0)
    193c:	03043823          	sd	a6,48(s0)
    1940:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1944:	04040793          	addi	a5,s0,64
    1948:	fcf43823          	sd	a5,-48(s0)
    194c:	fd043783          	ld	a5,-48(s0)
    1950:	fc878793          	addi	a5,a5,-56
    1954:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    1958:	fe843783          	ld	a5,-24(s0)
    195c:	863e                	mv	a2,a5
    195e:	fd843583          	ld	a1,-40(s0)
    1962:	4505                	li	a0,1
    1964:	00000097          	auipc	ra,0x0
    1968:	d04080e7          	jalr	-764(ra) # 1668 <vprintf>
}
    196c:	0001                	nop
    196e:	70a2                	ld	ra,40(sp)
    1970:	7402                	ld	s0,32(sp)
    1972:	6165                	addi	sp,sp,112
    1974:	8082                	ret

0000000000001976 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1976:	7179                	addi	sp,sp,-48
    1978:	f422                	sd	s0,40(sp)
    197a:	1800                	addi	s0,sp,48
    197c:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1980:	fd843783          	ld	a5,-40(s0)
    1984:	17c1                	addi	a5,a5,-16
    1986:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    198a:	00000797          	auipc	a5,0x0
    198e:	62678793          	addi	a5,a5,1574 # 1fb0 <freep>
    1992:	639c                	ld	a5,0(a5)
    1994:	fef43423          	sd	a5,-24(s0)
    1998:	a815                	j	19cc <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    199a:	fe843783          	ld	a5,-24(s0)
    199e:	639c                	ld	a5,0(a5)
    19a0:	fe843703          	ld	a4,-24(s0)
    19a4:	00f76f63          	bltu	a4,a5,19c2 <free+0x4c>
    19a8:	fe043703          	ld	a4,-32(s0)
    19ac:	fe843783          	ld	a5,-24(s0)
    19b0:	02e7eb63          	bltu	a5,a4,19e6 <free+0x70>
    19b4:	fe843783          	ld	a5,-24(s0)
    19b8:	639c                	ld	a5,0(a5)
    19ba:	fe043703          	ld	a4,-32(s0)
    19be:	02f76463          	bltu	a4,a5,19e6 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    19c2:	fe843783          	ld	a5,-24(s0)
    19c6:	639c                	ld	a5,0(a5)
    19c8:	fef43423          	sd	a5,-24(s0)
    19cc:	fe043703          	ld	a4,-32(s0)
    19d0:	fe843783          	ld	a5,-24(s0)
    19d4:	fce7f3e3          	bgeu	a5,a4,199a <free+0x24>
    19d8:	fe843783          	ld	a5,-24(s0)
    19dc:	639c                	ld	a5,0(a5)
    19de:	fe043703          	ld	a4,-32(s0)
    19e2:	faf77ce3          	bgeu	a4,a5,199a <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    19e6:	fe043783          	ld	a5,-32(s0)
    19ea:	479c                	lw	a5,8(a5)
    19ec:	1782                	slli	a5,a5,0x20
    19ee:	9381                	srli	a5,a5,0x20
    19f0:	0792                	slli	a5,a5,0x4
    19f2:	fe043703          	ld	a4,-32(s0)
    19f6:	973e                	add	a4,a4,a5
    19f8:	fe843783          	ld	a5,-24(s0)
    19fc:	639c                	ld	a5,0(a5)
    19fe:	02f71763          	bne	a4,a5,1a2c <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    1a02:	fe043783          	ld	a5,-32(s0)
    1a06:	4798                	lw	a4,8(a5)
    1a08:	fe843783          	ld	a5,-24(s0)
    1a0c:	639c                	ld	a5,0(a5)
    1a0e:	479c                	lw	a5,8(a5)
    1a10:	9fb9                	addw	a5,a5,a4
    1a12:	0007871b          	sext.w	a4,a5
    1a16:	fe043783          	ld	a5,-32(s0)
    1a1a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    1a1c:	fe843783          	ld	a5,-24(s0)
    1a20:	639c                	ld	a5,0(a5)
    1a22:	6398                	ld	a4,0(a5)
    1a24:	fe043783          	ld	a5,-32(s0)
    1a28:	e398                	sd	a4,0(a5)
    1a2a:	a039                	j	1a38 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    1a2c:	fe843783          	ld	a5,-24(s0)
    1a30:	6398                	ld	a4,0(a5)
    1a32:	fe043783          	ld	a5,-32(s0)
    1a36:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    1a38:	fe843783          	ld	a5,-24(s0)
    1a3c:	479c                	lw	a5,8(a5)
    1a3e:	1782                	slli	a5,a5,0x20
    1a40:	9381                	srli	a5,a5,0x20
    1a42:	0792                	slli	a5,a5,0x4
    1a44:	fe843703          	ld	a4,-24(s0)
    1a48:	97ba                	add	a5,a5,a4
    1a4a:	fe043703          	ld	a4,-32(s0)
    1a4e:	02f71563          	bne	a4,a5,1a78 <free+0x102>
    p->s.size += bp->s.size;
    1a52:	fe843783          	ld	a5,-24(s0)
    1a56:	4798                	lw	a4,8(a5)
    1a58:	fe043783          	ld	a5,-32(s0)
    1a5c:	479c                	lw	a5,8(a5)
    1a5e:	9fb9                	addw	a5,a5,a4
    1a60:	0007871b          	sext.w	a4,a5
    1a64:	fe843783          	ld	a5,-24(s0)
    1a68:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1a6a:	fe043783          	ld	a5,-32(s0)
    1a6e:	6398                	ld	a4,0(a5)
    1a70:	fe843783          	ld	a5,-24(s0)
    1a74:	e398                	sd	a4,0(a5)
    1a76:	a031                	j	1a82 <free+0x10c>
  } else
    p->s.ptr = bp;
    1a78:	fe843783          	ld	a5,-24(s0)
    1a7c:	fe043703          	ld	a4,-32(s0)
    1a80:	e398                	sd	a4,0(a5)
  freep = p;
    1a82:	00000797          	auipc	a5,0x0
    1a86:	52e78793          	addi	a5,a5,1326 # 1fb0 <freep>
    1a8a:	fe843703          	ld	a4,-24(s0)
    1a8e:	e398                	sd	a4,0(a5)
}
    1a90:	0001                	nop
    1a92:	7422                	ld	s0,40(sp)
    1a94:	6145                	addi	sp,sp,48
    1a96:	8082                	ret

0000000000001a98 <morecore>:

static Header*
morecore(uint nu)
{
    1a98:	7179                	addi	sp,sp,-48
    1a9a:	f406                	sd	ra,40(sp)
    1a9c:	f022                	sd	s0,32(sp)
    1a9e:	1800                	addi	s0,sp,48
    1aa0:	87aa                	mv	a5,a0
    1aa2:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    1aa6:	fdc42783          	lw	a5,-36(s0)
    1aaa:	0007871b          	sext.w	a4,a5
    1aae:	6785                	lui	a5,0x1
    1ab0:	00f77563          	bgeu	a4,a5,1aba <morecore+0x22>
    nu = 4096;
    1ab4:	6785                	lui	a5,0x1
    1ab6:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    1aba:	fdc42783          	lw	a5,-36(s0)
    1abe:	0047979b          	slliw	a5,a5,0x4
    1ac2:	2781                	sext.w	a5,a5
    1ac4:	2781                	sext.w	a5,a5
    1ac6:	853e                	mv	a0,a5
    1ac8:	00000097          	auipc	ra,0x0
    1acc:	9ae080e7          	jalr	-1618(ra) # 1476 <sbrk>
    1ad0:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    1ad4:	fe843703          	ld	a4,-24(s0)
    1ad8:	57fd                	li	a5,-1
    1ada:	00f71463          	bne	a4,a5,1ae2 <morecore+0x4a>
    return 0;
    1ade:	4781                	li	a5,0
    1ae0:	a03d                	j	1b0e <morecore+0x76>
  hp = (Header*)p;
    1ae2:	fe843783          	ld	a5,-24(s0)
    1ae6:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    1aea:	fe043783          	ld	a5,-32(s0)
    1aee:	fdc42703          	lw	a4,-36(s0)
    1af2:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    1af4:	fe043783          	ld	a5,-32(s0)
    1af8:	07c1                	addi	a5,a5,16
    1afa:	853e                	mv	a0,a5
    1afc:	00000097          	auipc	ra,0x0
    1b00:	e7a080e7          	jalr	-390(ra) # 1976 <free>
  return freep;
    1b04:	00000797          	auipc	a5,0x0
    1b08:	4ac78793          	addi	a5,a5,1196 # 1fb0 <freep>
    1b0c:	639c                	ld	a5,0(a5)
}
    1b0e:	853e                	mv	a0,a5
    1b10:	70a2                	ld	ra,40(sp)
    1b12:	7402                	ld	s0,32(sp)
    1b14:	6145                	addi	sp,sp,48
    1b16:	8082                	ret

0000000000001b18 <malloc>:

void*
malloc(uint nbytes)
{
    1b18:	7139                	addi	sp,sp,-64
    1b1a:	fc06                	sd	ra,56(sp)
    1b1c:	f822                	sd	s0,48(sp)
    1b1e:	0080                	addi	s0,sp,64
    1b20:	87aa                	mv	a5,a0
    1b22:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1b26:	fcc46783          	lwu	a5,-52(s0)
    1b2a:	07bd                	addi	a5,a5,15
    1b2c:	8391                	srli	a5,a5,0x4
    1b2e:	2781                	sext.w	a5,a5
    1b30:	2785                	addiw	a5,a5,1
    1b32:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1b36:	00000797          	auipc	a5,0x0
    1b3a:	47a78793          	addi	a5,a5,1146 # 1fb0 <freep>
    1b3e:	639c                	ld	a5,0(a5)
    1b40:	fef43023          	sd	a5,-32(s0)
    1b44:	fe043783          	ld	a5,-32(s0)
    1b48:	ef95                	bnez	a5,1b84 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1b4a:	00000797          	auipc	a5,0x0
    1b4e:	45678793          	addi	a5,a5,1110 # 1fa0 <base>
    1b52:	fef43023          	sd	a5,-32(s0)
    1b56:	00000797          	auipc	a5,0x0
    1b5a:	45a78793          	addi	a5,a5,1114 # 1fb0 <freep>
    1b5e:	fe043703          	ld	a4,-32(s0)
    1b62:	e398                	sd	a4,0(a5)
    1b64:	00000797          	auipc	a5,0x0
    1b68:	44c78793          	addi	a5,a5,1100 # 1fb0 <freep>
    1b6c:	6398                	ld	a4,0(a5)
    1b6e:	00000797          	auipc	a5,0x0
    1b72:	43278793          	addi	a5,a5,1074 # 1fa0 <base>
    1b76:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1b78:	00000797          	auipc	a5,0x0
    1b7c:	42878793          	addi	a5,a5,1064 # 1fa0 <base>
    1b80:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1b84:	fe043783          	ld	a5,-32(s0)
    1b88:	639c                	ld	a5,0(a5)
    1b8a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1b8e:	fe843783          	ld	a5,-24(s0)
    1b92:	4798                	lw	a4,8(a5)
    1b94:	fdc42783          	lw	a5,-36(s0)
    1b98:	2781                	sext.w	a5,a5
    1b9a:	06f76763          	bltu	a4,a5,1c08 <malloc+0xf0>
      if(p->s.size == nunits)
    1b9e:	fe843783          	ld	a5,-24(s0)
    1ba2:	4798                	lw	a4,8(a5)
    1ba4:	fdc42783          	lw	a5,-36(s0)
    1ba8:	2781                	sext.w	a5,a5
    1baa:	00e79963          	bne	a5,a4,1bbc <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1bae:	fe843783          	ld	a5,-24(s0)
    1bb2:	6398                	ld	a4,0(a5)
    1bb4:	fe043783          	ld	a5,-32(s0)
    1bb8:	e398                	sd	a4,0(a5)
    1bba:	a825                	j	1bf2 <malloc+0xda>
      else {
        p->s.size -= nunits;
    1bbc:	fe843783          	ld	a5,-24(s0)
    1bc0:	479c                	lw	a5,8(a5)
    1bc2:	fdc42703          	lw	a4,-36(s0)
    1bc6:	9f99                	subw	a5,a5,a4
    1bc8:	0007871b          	sext.w	a4,a5
    1bcc:	fe843783          	ld	a5,-24(s0)
    1bd0:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1bd2:	fe843783          	ld	a5,-24(s0)
    1bd6:	479c                	lw	a5,8(a5)
    1bd8:	1782                	slli	a5,a5,0x20
    1bda:	9381                	srli	a5,a5,0x20
    1bdc:	0792                	slli	a5,a5,0x4
    1bde:	fe843703          	ld	a4,-24(s0)
    1be2:	97ba                	add	a5,a5,a4
    1be4:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1be8:	fe843783          	ld	a5,-24(s0)
    1bec:	fdc42703          	lw	a4,-36(s0)
    1bf0:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1bf2:	00000797          	auipc	a5,0x0
    1bf6:	3be78793          	addi	a5,a5,958 # 1fb0 <freep>
    1bfa:	fe043703          	ld	a4,-32(s0)
    1bfe:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1c00:	fe843783          	ld	a5,-24(s0)
    1c04:	07c1                	addi	a5,a5,16
    1c06:	a091                	j	1c4a <malloc+0x132>
    }
    if(p == freep)
    1c08:	00000797          	auipc	a5,0x0
    1c0c:	3a878793          	addi	a5,a5,936 # 1fb0 <freep>
    1c10:	639c                	ld	a5,0(a5)
    1c12:	fe843703          	ld	a4,-24(s0)
    1c16:	02f71063          	bne	a4,a5,1c36 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    1c1a:	fdc42783          	lw	a5,-36(s0)
    1c1e:	853e                	mv	a0,a5
    1c20:	00000097          	auipc	ra,0x0
    1c24:	e78080e7          	jalr	-392(ra) # 1a98 <morecore>
    1c28:	fea43423          	sd	a0,-24(s0)
    1c2c:	fe843783          	ld	a5,-24(s0)
    1c30:	e399                	bnez	a5,1c36 <malloc+0x11e>
        return 0;
    1c32:	4781                	li	a5,0
    1c34:	a819                	j	1c4a <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c36:	fe843783          	ld	a5,-24(s0)
    1c3a:	fef43023          	sd	a5,-32(s0)
    1c3e:	fe843783          	ld	a5,-24(s0)
    1c42:	639c                	ld	a5,0(a5)
    1c44:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1c48:	b799                	j	1b8e <malloc+0x76>
  }
}
    1c4a:	853e                	mv	a0,a5
    1c4c:	70e2                	ld	ra,56(sp)
    1c4e:	7442                	ld	s0,48(sp)
    1c50:	6121                	addi	sp,sp,64
    1c52:	8082                	ret

0000000000001c54 <thread_create>:
typedef uint lock_t;

extern int clone(void(*fcn)(void*), void *arg, void*stack);
extern int join (void *stack);

int thread_create(void (*start_routine)(void*),  void *arg){
    1c54:	7179                	addi	sp,sp,-48
    1c56:	f406                	sd	ra,40(sp)
    1c58:	f022                	sd	s0,32(sp)
    1c5a:	1800                	addi	s0,sp,48
    1c5c:	fca43c23          	sd	a0,-40(s0)
    1c60:	fcb43823          	sd	a1,-48(s0)
    
    uint64 va;

    //creamos el stack del thread con tamaño de pagina 1
    void *stack;
    if (!(stack = malloc (PAGE_SIZE))){
    1c64:	6505                	lui	a0,0x1
    1c66:	00000097          	auipc	ra,0x0
    1c6a:	eb2080e7          	jalr	-334(ra) # 1b18 <malloc>
    1c6e:	fea43423          	sd	a0,-24(s0)
    1c72:	fe843783          	ld	a5,-24(s0)
    1c76:	e38d                	bnez	a5,1c98 <thread_create+0x44>
        printf ("Error: No se ha podido allocatar el stack en el heap del proceso padre.\n");
    1c78:	00000517          	auipc	a0,0x0
    1c7c:	24850513          	addi	a0,a0,584 # 1ec0 <lock_init+0x162>
    1c80:	00000097          	auipc	ra,0x0
    1c84:	ca6080e7          	jalr	-858(ra) # 1926 <printf>
        free(stack);
    1c88:	fe843503          	ld	a0,-24(s0)
    1c8c:	00000097          	auipc	ra,0x0
    1c90:	cea080e7          	jalr	-790(ra) # 1976 <free>
        return -1;
    1c94:	57fd                	li	a5,-1
    1c96:	a099                	j	1cdc <thread_create+0x88>
    }

    //comprobamos si la dirección está alineada a página. En caso contrario hacerlo.
    va = (uint64) stack;
    1c98:	fe843783          	ld	a5,-24(s0)
    1c9c:	fef43023          	sd	a5,-32(s0)
    if ((va % PAGE_SIZE) != 0){
    1ca0:	fe043703          	ld	a4,-32(s0)
    1ca4:	6785                	lui	a5,0x1
    1ca6:	17fd                	addi	a5,a5,-1
    1ca8:	8ff9                	and	a5,a5,a4
    1caa:	cf91                	beqz	a5,1cc6 <thread_create+0x72>
        stack = stack + (PAGE_SIZE - (va % PAGE_SIZE));
    1cac:	fe043703          	ld	a4,-32(s0)
    1cb0:	6785                	lui	a5,0x1
    1cb2:	17fd                	addi	a5,a5,-1
    1cb4:	8ff9                	and	a5,a5,a4
    1cb6:	6705                	lui	a4,0x1
    1cb8:	40f707b3          	sub	a5,a4,a5
    1cbc:	fe843703          	ld	a4,-24(s0)
    1cc0:	97ba                	add	a5,a5,a4
    1cc2:	fef43423          	sd	a5,-24(s0)
    }
    
    return clone (start_routine, arg, stack);
    1cc6:	fe843603          	ld	a2,-24(s0)
    1cca:	fd043583          	ld	a1,-48(s0)
    1cce:	fd843503          	ld	a0,-40(s0)
    1cd2:	fffff097          	auipc	ra,0xfffff
    1cd6:	7bc080e7          	jalr	1980(ra) # 148e <clone>
    1cda:	87aa                	mv	a5,a0
}
    1cdc:	853e                	mv	a0,a5
    1cde:	70a2                	ld	ra,40(sp)
    1ce0:	7402                	ld	s0,32(sp)
    1ce2:	6145                	addi	sp,sp,48
    1ce4:	8082                	ret

0000000000001ce6 <thread_join>:


int thread_join()
{
    1ce6:	1101                	addi	sp,sp,-32
    1ce8:	ec06                	sd	ra,24(sp)
    1cea:	e822                	sd	s0,16(sp)
    1cec:	1000                	addi	s0,sp,32
    void *stack;
    int child_tid;
    if ((child_tid = join(&stack)) != -1){
    1cee:	fe040793          	addi	a5,s0,-32
    1cf2:	853e                	mv	a0,a5
    1cf4:	fffff097          	auipc	ra,0xfffff
    1cf8:	7a2080e7          	jalr	1954(ra) # 1496 <join>
    1cfc:	87aa                	mv	a5,a0
    1cfe:	fef42623          	sw	a5,-20(s0)
    1d02:	fec42783          	lw	a5,-20(s0)
    1d06:	0007871b          	sext.w	a4,a5
    1d0a:	57fd                	li	a5,-1
    1d0c:	00f70963          	beq	a4,a5,1d1e <thread_join+0x38>
        free(stack); //hacemos que *stack apunte al user stack del thread y lo liberamos.
    1d10:	fe043783          	ld	a5,-32(s0)
    1d14:	853e                	mv	a0,a5
    1d16:	00000097          	auipc	ra,0x0
    1d1a:	c60080e7          	jalr	-928(ra) # 1976 <free>
    } 

    return child_tid;
    1d1e:	fec42783          	lw	a5,-20(s0)
}
    1d22:	853e                	mv	a0,a5
    1d24:	60e2                	ld	ra,24(sp)
    1d26:	6442                	ld	s0,16(sp)
    1d28:	6105                	addi	sp,sp,32
    1d2a:	8082                	ret

0000000000001d2c <lock_acquire>:


void lock_acquire (lock_t *lock)
{
    1d2c:	1101                	addi	sp,sp,-32
    1d2e:	ec22                	sd	s0,24(sp)
    1d30:	1000                	addi	s0,sp,32
    1d32:	fea43423          	sd	a0,-24(s0)
        lock = 0;
    1d36:	fe043423          	sd	zero,-24(s0)

}
    1d3a:	0001                	nop
    1d3c:	6462                	ld	s0,24(sp)
    1d3e:	6105                	addi	sp,sp,32
    1d40:	8082                	ret

0000000000001d42 <lock_release>:

void lock_release (lock_t *lock)
{
    1d42:	1101                	addi	sp,sp,-32
    1d44:	ec22                	sd	s0,24(sp)
    1d46:	1000                	addi	s0,sp,32
    1d48:	fea43423          	sd	a0,-24(s0)
        __sync_lock_test_and_set(lock, 1);
    1d4c:	fe843783          	ld	a5,-24(s0)
    1d50:	4705                	li	a4,1
    1d52:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    
}
    1d56:	0001                	nop
    1d58:	6462                	ld	s0,24(sp)
    1d5a:	6105                	addi	sp,sp,32
    1d5c:	8082                	ret

0000000000001d5e <lock_init>:

void lock_init (lock_t *lock)
{
    1d5e:	1101                	addi	sp,sp,-32
    1d60:	ec22                	sd	s0,24(sp)
    1d62:	1000                	addi	s0,sp,32
    1d64:	fea43423          	sd	a0,-24(s0)
    lock = 0;
    1d68:	fe043423          	sd	zero,-24(s0)
    
}
    1d6c:	0001                	nop
    1d6e:	6462                	ld	s0,24(sp)
    1d70:	6105                	addi	sp,sp,32
    1d72:	8082                	ret
