
kernel/kernel:     formato del fichero elf64-littleriscv


Desensamblado de la sección .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	18010113          	addi	sp,sp,384 # 80009180 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	076000ef          	jal	ra,8000008c <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e422                	sd	s0,8(sp)
    80000020:	0800                	addi	s0,sp,16
// which hart (core) is this?
static inline uint64
r_mhartid()
{
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000022:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80000026:	0007859b          	sext.w	a1,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    8000002a:	0037979b          	slliw	a5,a5,0x3
    8000002e:	02004737          	lui	a4,0x2004
    80000032:	97ba                	add	a5,a5,a4
    80000034:	0200c737          	lui	a4,0x200c
    80000038:	ff873703          	ld	a4,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000003c:	000f4637          	lui	a2,0xf4
    80000040:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80000044:	9732                	add	a4,a4,a2
    80000046:	e398                	sd	a4,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80000048:	00259693          	slli	a3,a1,0x2
    8000004c:	96ae                	add	a3,a3,a1
    8000004e:	068e                	slli	a3,a3,0x3
    80000050:	00009717          	auipc	a4,0x9
    80000054:	ff070713          	addi	a4,a4,-16 # 80009040 <timer_scratch>
    80000058:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    8000005a:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    8000005c:	f310                	sd	a2,32(a4)
}

static inline void 
w_mscratch(uint64 x)
{
  asm volatile("csrw mscratch, %0" : : "r" (x));
    8000005e:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80000062:	00006797          	auipc	a5,0x6
    80000066:	bae78793          	addi	a5,a5,-1106 # 80005c10 <timervec>
    8000006a:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000006e:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80000072:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80000076:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    8000007a:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    8000007e:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80000082:	30479073          	csrw	mie,a5
}
    80000086:	6422                	ld	s0,8(sp)
    80000088:	0141                	addi	sp,sp,16
    8000008a:	8082                	ret

000000008000008c <start>:
{
    8000008c:	1141                	addi	sp,sp,-16
    8000008e:	e406                	sd	ra,8(sp)
    80000090:	e022                	sd	s0,0(sp)
    80000092:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000094:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80000098:	7779                	lui	a4,0xffffe
    8000009a:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd87ff>
    8000009e:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800000a0:	6705                	lui	a4,0x1
    800000a2:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800000a6:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800000a8:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800000ac:	00001797          	auipc	a5,0x1
    800000b0:	dc678793          	addi	a5,a5,-570 # 80000e72 <main>
    800000b4:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800000b8:	4781                	li	a5,0
    800000ba:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000be:	67c1                	lui	a5,0x10
    800000c0:	17fd                	addi	a5,a5,-1
    800000c2:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    800000c6:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    800000ca:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800000ce:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    800000d2:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    800000d6:	57fd                	li	a5,-1
    800000d8:	83a9                	srli	a5,a5,0xa
    800000da:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    800000de:	47bd                	li	a5,15
    800000e0:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    800000e4:	00000097          	auipc	ra,0x0
    800000e8:	f38080e7          	jalr	-200(ra) # 8000001c <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800000ec:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800000f0:	2781                	sext.w	a5,a5
}

static inline void 
w_tp(uint64 x)
{
  asm volatile("mv tp, %0" : : "r" (x));
    800000f2:	823e                	mv	tp,a5
  asm volatile("mret");
    800000f4:	30200073          	mret
}
    800000f8:	60a2                	ld	ra,8(sp)
    800000fa:	6402                	ld	s0,0(sp)
    800000fc:	0141                	addi	sp,sp,16
    800000fe:	8082                	ret

0000000080000100 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80000100:	715d                	addi	sp,sp,-80
    80000102:	e486                	sd	ra,72(sp)
    80000104:	e0a2                	sd	s0,64(sp)
    80000106:	fc26                	sd	s1,56(sp)
    80000108:	f84a                	sd	s2,48(sp)
    8000010a:	f44e                	sd	s3,40(sp)
    8000010c:	f052                	sd	s4,32(sp)
    8000010e:	ec56                	sd	s5,24(sp)
    80000110:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80000112:	04c05763          	blez	a2,80000160 <consolewrite+0x60>
    80000116:	8a2a                	mv	s4,a0
    80000118:	84ae                	mv	s1,a1
    8000011a:	89b2                	mv	s3,a2
    8000011c:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    8000011e:	5afd                	li	s5,-1
    80000120:	4685                	li	a3,1
    80000122:	8626                	mv	a2,s1
    80000124:	85d2                	mv	a1,s4
    80000126:	fbf40513          	addi	a0,s0,-65
    8000012a:	00002097          	auipc	ra,0x2
    8000012e:	334080e7          	jalr	820(ra) # 8000245e <either_copyin>
    80000132:	01550d63          	beq	a0,s5,8000014c <consolewrite+0x4c>
      break;
    uartputc(c);
    80000136:	fbf44503          	lbu	a0,-65(s0)
    8000013a:	00000097          	auipc	ra,0x0
    8000013e:	77e080e7          	jalr	1918(ra) # 800008b8 <uartputc>
  for(i = 0; i < n; i++){
    80000142:	2905                	addiw	s2,s2,1
    80000144:	0485                	addi	s1,s1,1
    80000146:	fd299de3          	bne	s3,s2,80000120 <consolewrite+0x20>
    8000014a:	894e                	mv	s2,s3
  }

  return i;
}
    8000014c:	854a                	mv	a0,s2
    8000014e:	60a6                	ld	ra,72(sp)
    80000150:	6406                	ld	s0,64(sp)
    80000152:	74e2                	ld	s1,56(sp)
    80000154:	7942                	ld	s2,48(sp)
    80000156:	79a2                	ld	s3,40(sp)
    80000158:	7a02                	ld	s4,32(sp)
    8000015a:	6ae2                	ld	s5,24(sp)
    8000015c:	6161                	addi	sp,sp,80
    8000015e:	8082                	ret
  for(i = 0; i < n; i++){
    80000160:	4901                	li	s2,0
    80000162:	b7ed                	j	8000014c <consolewrite+0x4c>

0000000080000164 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80000164:	7159                	addi	sp,sp,-112
    80000166:	f486                	sd	ra,104(sp)
    80000168:	f0a2                	sd	s0,96(sp)
    8000016a:	eca6                	sd	s1,88(sp)
    8000016c:	e8ca                	sd	s2,80(sp)
    8000016e:	e4ce                	sd	s3,72(sp)
    80000170:	e0d2                	sd	s4,64(sp)
    80000172:	fc56                	sd	s5,56(sp)
    80000174:	f85a                	sd	s6,48(sp)
    80000176:	f45e                	sd	s7,40(sp)
    80000178:	f062                	sd	s8,32(sp)
    8000017a:	ec66                	sd	s9,24(sp)
    8000017c:	e86a                	sd	s10,16(sp)
    8000017e:	1880                	addi	s0,sp,112
    80000180:	8aaa                	mv	s5,a0
    80000182:	8a2e                	mv	s4,a1
    80000184:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80000186:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    8000018a:	00011517          	auipc	a0,0x11
    8000018e:	ff650513          	addi	a0,a0,-10 # 80011180 <cons>
    80000192:	00001097          	auipc	ra,0x1
    80000196:	a3e080e7          	jalr	-1474(ra) # 80000bd0 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    8000019a:	00011497          	auipc	s1,0x11
    8000019e:	fe648493          	addi	s1,s1,-26 # 80011180 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    800001a2:	00011917          	auipc	s2,0x11
    800001a6:	07690913          	addi	s2,s2,118 # 80011218 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    800001aa:	4b91                	li	s7,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    800001ac:	5c7d                	li	s8,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    800001ae:	4ca9                	li	s9,10
  while(n > 0){
    800001b0:	07305863          	blez	s3,80000220 <consoleread+0xbc>
    while(cons.r == cons.w){
    800001b4:	0984a783          	lw	a5,152(s1)
    800001b8:	09c4a703          	lw	a4,156(s1)
    800001bc:	02f71463          	bne	a4,a5,800001e4 <consoleread+0x80>
      if(myproc()->killed){
    800001c0:	00001097          	auipc	ra,0x1
    800001c4:	7d6080e7          	jalr	2006(ra) # 80001996 <myproc>
    800001c8:	551c                	lw	a5,40(a0)
    800001ca:	e7b5                	bnez	a5,80000236 <consoleread+0xd2>
      sleep(&cons.r, &cons.lock);
    800001cc:	85a6                	mv	a1,s1
    800001ce:	854a                	mv	a0,s2
    800001d0:	00002097          	auipc	ra,0x2
    800001d4:	e94080e7          	jalr	-364(ra) # 80002064 <sleep>
    while(cons.r == cons.w){
    800001d8:	0984a783          	lw	a5,152(s1)
    800001dc:	09c4a703          	lw	a4,156(s1)
    800001e0:	fef700e3          	beq	a4,a5,800001c0 <consoleread+0x5c>
    c = cons.buf[cons.r++ % INPUT_BUF];
    800001e4:	0017871b          	addiw	a4,a5,1
    800001e8:	08e4ac23          	sw	a4,152(s1)
    800001ec:	07f7f713          	andi	a4,a5,127
    800001f0:	9726                	add	a4,a4,s1
    800001f2:	01874703          	lbu	a4,24(a4)
    800001f6:	00070d1b          	sext.w	s10,a4
    if(c == C('D')){  // end-of-file
    800001fa:	077d0563          	beq	s10,s7,80000264 <consoleread+0x100>
    cbuf = c;
    800001fe:	f8e40fa3          	sb	a4,-97(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000202:	4685                	li	a3,1
    80000204:	f9f40613          	addi	a2,s0,-97
    80000208:	85d2                	mv	a1,s4
    8000020a:	8556                	mv	a0,s5
    8000020c:	00002097          	auipc	ra,0x2
    80000210:	1fc080e7          	jalr	508(ra) # 80002408 <either_copyout>
    80000214:	01850663          	beq	a0,s8,80000220 <consoleread+0xbc>
    dst++;
    80000218:	0a05                	addi	s4,s4,1
    --n;
    8000021a:	39fd                	addiw	s3,s3,-1
    if(c == '\n'){
    8000021c:	f99d1ae3          	bne	s10,s9,800001b0 <consoleread+0x4c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80000220:	00011517          	auipc	a0,0x11
    80000224:	f6050513          	addi	a0,a0,-160 # 80011180 <cons>
    80000228:	00001097          	auipc	ra,0x1
    8000022c:	a5c080e7          	jalr	-1444(ra) # 80000c84 <release>

  return target - n;
    80000230:	413b053b          	subw	a0,s6,s3
    80000234:	a811                	j	80000248 <consoleread+0xe4>
        release(&cons.lock);
    80000236:	00011517          	auipc	a0,0x11
    8000023a:	f4a50513          	addi	a0,a0,-182 # 80011180 <cons>
    8000023e:	00001097          	auipc	ra,0x1
    80000242:	a46080e7          	jalr	-1466(ra) # 80000c84 <release>
        return -1;
    80000246:	557d                	li	a0,-1
}
    80000248:	70a6                	ld	ra,104(sp)
    8000024a:	7406                	ld	s0,96(sp)
    8000024c:	64e6                	ld	s1,88(sp)
    8000024e:	6946                	ld	s2,80(sp)
    80000250:	69a6                	ld	s3,72(sp)
    80000252:	6a06                	ld	s4,64(sp)
    80000254:	7ae2                	ld	s5,56(sp)
    80000256:	7b42                	ld	s6,48(sp)
    80000258:	7ba2                	ld	s7,40(sp)
    8000025a:	7c02                	ld	s8,32(sp)
    8000025c:	6ce2                	ld	s9,24(sp)
    8000025e:	6d42                	ld	s10,16(sp)
    80000260:	6165                	addi	sp,sp,112
    80000262:	8082                	ret
      if(n < target){
    80000264:	0009871b          	sext.w	a4,s3
    80000268:	fb677ce3          	bgeu	a4,s6,80000220 <consoleread+0xbc>
        cons.r--;
    8000026c:	00011717          	auipc	a4,0x11
    80000270:	faf72623          	sw	a5,-84(a4) # 80011218 <cons+0x98>
    80000274:	b775                	j	80000220 <consoleread+0xbc>

0000000080000276 <consputc>:
{
    80000276:	1141                	addi	sp,sp,-16
    80000278:	e406                	sd	ra,8(sp)
    8000027a:	e022                	sd	s0,0(sp)
    8000027c:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    8000027e:	10000793          	li	a5,256
    80000282:	00f50a63          	beq	a0,a5,80000296 <consputc+0x20>
    uartputc_sync(c);
    80000286:	00000097          	auipc	ra,0x0
    8000028a:	560080e7          	jalr	1376(ra) # 800007e6 <uartputc_sync>
}
    8000028e:	60a2                	ld	ra,8(sp)
    80000290:	6402                	ld	s0,0(sp)
    80000292:	0141                	addi	sp,sp,16
    80000294:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80000296:	4521                	li	a0,8
    80000298:	00000097          	auipc	ra,0x0
    8000029c:	54e080e7          	jalr	1358(ra) # 800007e6 <uartputc_sync>
    800002a0:	02000513          	li	a0,32
    800002a4:	00000097          	auipc	ra,0x0
    800002a8:	542080e7          	jalr	1346(ra) # 800007e6 <uartputc_sync>
    800002ac:	4521                	li	a0,8
    800002ae:	00000097          	auipc	ra,0x0
    800002b2:	538080e7          	jalr	1336(ra) # 800007e6 <uartputc_sync>
    800002b6:	bfe1                	j	8000028e <consputc+0x18>

00000000800002b8 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800002b8:	1101                	addi	sp,sp,-32
    800002ba:	ec06                	sd	ra,24(sp)
    800002bc:	e822                	sd	s0,16(sp)
    800002be:	e426                	sd	s1,8(sp)
    800002c0:	e04a                	sd	s2,0(sp)
    800002c2:	1000                	addi	s0,sp,32
    800002c4:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800002c6:	00011517          	auipc	a0,0x11
    800002ca:	eba50513          	addi	a0,a0,-326 # 80011180 <cons>
    800002ce:	00001097          	auipc	ra,0x1
    800002d2:	902080e7          	jalr	-1790(ra) # 80000bd0 <acquire>

  switch(c){
    800002d6:	47d5                	li	a5,21
    800002d8:	0af48663          	beq	s1,a5,80000384 <consoleintr+0xcc>
    800002dc:	0297ca63          	blt	a5,s1,80000310 <consoleintr+0x58>
    800002e0:	47a1                	li	a5,8
    800002e2:	0ef48763          	beq	s1,a5,800003d0 <consoleintr+0x118>
    800002e6:	47c1                	li	a5,16
    800002e8:	10f49a63          	bne	s1,a5,800003fc <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    800002ec:	00002097          	auipc	ra,0x2
    800002f0:	1c8080e7          	jalr	456(ra) # 800024b4 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    800002f4:	00011517          	auipc	a0,0x11
    800002f8:	e8c50513          	addi	a0,a0,-372 # 80011180 <cons>
    800002fc:	00001097          	auipc	ra,0x1
    80000300:	988080e7          	jalr	-1656(ra) # 80000c84 <release>
}
    80000304:	60e2                	ld	ra,24(sp)
    80000306:	6442                	ld	s0,16(sp)
    80000308:	64a2                	ld	s1,8(sp)
    8000030a:	6902                	ld	s2,0(sp)
    8000030c:	6105                	addi	sp,sp,32
    8000030e:	8082                	ret
  switch(c){
    80000310:	07f00793          	li	a5,127
    80000314:	0af48e63          	beq	s1,a5,800003d0 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80000318:	00011717          	auipc	a4,0x11
    8000031c:	e6870713          	addi	a4,a4,-408 # 80011180 <cons>
    80000320:	0a072783          	lw	a5,160(a4)
    80000324:	09872703          	lw	a4,152(a4)
    80000328:	9f99                	subw	a5,a5,a4
    8000032a:	07f00713          	li	a4,127
    8000032e:	fcf763e3          	bltu	a4,a5,800002f4 <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80000332:	47b5                	li	a5,13
    80000334:	0cf48763          	beq	s1,a5,80000402 <consoleintr+0x14a>
      consputc(c);
    80000338:	8526                	mv	a0,s1
    8000033a:	00000097          	auipc	ra,0x0
    8000033e:	f3c080e7          	jalr	-196(ra) # 80000276 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80000342:	00011797          	auipc	a5,0x11
    80000346:	e3e78793          	addi	a5,a5,-450 # 80011180 <cons>
    8000034a:	0a07a703          	lw	a4,160(a5)
    8000034e:	0017069b          	addiw	a3,a4,1
    80000352:	0006861b          	sext.w	a2,a3
    80000356:	0ad7a023          	sw	a3,160(a5)
    8000035a:	07f77713          	andi	a4,a4,127
    8000035e:	97ba                	add	a5,a5,a4
    80000360:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    80000364:	47a9                	li	a5,10
    80000366:	0cf48563          	beq	s1,a5,80000430 <consoleintr+0x178>
    8000036a:	4791                	li	a5,4
    8000036c:	0cf48263          	beq	s1,a5,80000430 <consoleintr+0x178>
    80000370:	00011797          	auipc	a5,0x11
    80000374:	ea87a783          	lw	a5,-344(a5) # 80011218 <cons+0x98>
    80000378:	0807879b          	addiw	a5,a5,128
    8000037c:	f6f61ce3          	bne	a2,a5,800002f4 <consoleintr+0x3c>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80000380:	863e                	mv	a2,a5
    80000382:	a07d                	j	80000430 <consoleintr+0x178>
    while(cons.e != cons.w &&
    80000384:	00011717          	auipc	a4,0x11
    80000388:	dfc70713          	addi	a4,a4,-516 # 80011180 <cons>
    8000038c:	0a072783          	lw	a5,160(a4)
    80000390:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80000394:	00011497          	auipc	s1,0x11
    80000398:	dec48493          	addi	s1,s1,-532 # 80011180 <cons>
    while(cons.e != cons.w &&
    8000039c:	4929                	li	s2,10
    8000039e:	f4f70be3          	beq	a4,a5,800002f4 <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800003a2:	37fd                	addiw	a5,a5,-1
    800003a4:	07f7f713          	andi	a4,a5,127
    800003a8:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800003aa:	01874703          	lbu	a4,24(a4)
    800003ae:	f52703e3          	beq	a4,s2,800002f4 <consoleintr+0x3c>
      cons.e--;
    800003b2:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800003b6:	10000513          	li	a0,256
    800003ba:	00000097          	auipc	ra,0x0
    800003be:	ebc080e7          	jalr	-324(ra) # 80000276 <consputc>
    while(cons.e != cons.w &&
    800003c2:	0a04a783          	lw	a5,160(s1)
    800003c6:	09c4a703          	lw	a4,156(s1)
    800003ca:	fcf71ce3          	bne	a4,a5,800003a2 <consoleintr+0xea>
    800003ce:	b71d                	j	800002f4 <consoleintr+0x3c>
    if(cons.e != cons.w){
    800003d0:	00011717          	auipc	a4,0x11
    800003d4:	db070713          	addi	a4,a4,-592 # 80011180 <cons>
    800003d8:	0a072783          	lw	a5,160(a4)
    800003dc:	09c72703          	lw	a4,156(a4)
    800003e0:	f0f70ae3          	beq	a4,a5,800002f4 <consoleintr+0x3c>
      cons.e--;
    800003e4:	37fd                	addiw	a5,a5,-1
    800003e6:	00011717          	auipc	a4,0x11
    800003ea:	e2f72d23          	sw	a5,-454(a4) # 80011220 <cons+0xa0>
      consputc(BACKSPACE);
    800003ee:	10000513          	li	a0,256
    800003f2:	00000097          	auipc	ra,0x0
    800003f6:	e84080e7          	jalr	-380(ra) # 80000276 <consputc>
    800003fa:	bded                	j	800002f4 <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    800003fc:	ee048ce3          	beqz	s1,800002f4 <consoleintr+0x3c>
    80000400:	bf21                	j	80000318 <consoleintr+0x60>
      consputc(c);
    80000402:	4529                	li	a0,10
    80000404:	00000097          	auipc	ra,0x0
    80000408:	e72080e7          	jalr	-398(ra) # 80000276 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    8000040c:	00011797          	auipc	a5,0x11
    80000410:	d7478793          	addi	a5,a5,-652 # 80011180 <cons>
    80000414:	0a07a703          	lw	a4,160(a5)
    80000418:	0017069b          	addiw	a3,a4,1
    8000041c:	0006861b          	sext.w	a2,a3
    80000420:	0ad7a023          	sw	a3,160(a5)
    80000424:	07f77713          	andi	a4,a4,127
    80000428:	97ba                	add	a5,a5,a4
    8000042a:	4729                	li	a4,10
    8000042c:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80000430:	00011797          	auipc	a5,0x11
    80000434:	dec7a623          	sw	a2,-532(a5) # 8001121c <cons+0x9c>
        wakeup(&cons.r);
    80000438:	00011517          	auipc	a0,0x11
    8000043c:	de050513          	addi	a0,a0,-544 # 80011218 <cons+0x98>
    80000440:	00002097          	auipc	ra,0x2
    80000444:	db0080e7          	jalr	-592(ra) # 800021f0 <wakeup>
    80000448:	b575                	j	800002f4 <consoleintr+0x3c>

000000008000044a <consoleinit>:

void
consoleinit(void)
{
    8000044a:	1141                	addi	sp,sp,-16
    8000044c:	e406                	sd	ra,8(sp)
    8000044e:	e022                	sd	s0,0(sp)
    80000450:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80000452:	00008597          	auipc	a1,0x8
    80000456:	bbe58593          	addi	a1,a1,-1090 # 80008010 <etext+0x10>
    8000045a:	00011517          	auipc	a0,0x11
    8000045e:	d2650513          	addi	a0,a0,-730 # 80011180 <cons>
    80000462:	00000097          	auipc	ra,0x0
    80000466:	6de080e7          	jalr	1758(ra) # 80000b40 <initlock>

  uartinit();
    8000046a:	00000097          	auipc	ra,0x0
    8000046e:	32c080e7          	jalr	812(ra) # 80000796 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80000472:	00021797          	auipc	a5,0x21
    80000476:	2a678793          	addi	a5,a5,678 # 80021718 <devsw>
    8000047a:	00000717          	auipc	a4,0x0
    8000047e:	cea70713          	addi	a4,a4,-790 # 80000164 <consoleread>
    80000482:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80000484:	00000717          	auipc	a4,0x0
    80000488:	c7c70713          	addi	a4,a4,-900 # 80000100 <consolewrite>
    8000048c:	ef98                	sd	a4,24(a5)
}
    8000048e:	60a2                	ld	ra,8(sp)
    80000490:	6402                	ld	s0,0(sp)
    80000492:	0141                	addi	sp,sp,16
    80000494:	8082                	ret

0000000080000496 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80000496:	7179                	addi	sp,sp,-48
    80000498:	f406                	sd	ra,40(sp)
    8000049a:	f022                	sd	s0,32(sp)
    8000049c:	ec26                	sd	s1,24(sp)
    8000049e:	e84a                	sd	s2,16(sp)
    800004a0:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800004a2:	c219                	beqz	a2,800004a8 <printint+0x12>
    800004a4:	08054763          	bltz	a0,80000532 <printint+0x9c>
    x = -xx;
  else
    x = xx;
    800004a8:	2501                	sext.w	a0,a0
    800004aa:	4881                	li	a7,0
    800004ac:	fd040693          	addi	a3,s0,-48

  i = 0;
    800004b0:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800004b2:	2581                	sext.w	a1,a1
    800004b4:	00008617          	auipc	a2,0x8
    800004b8:	b8c60613          	addi	a2,a2,-1140 # 80008040 <digits>
    800004bc:	883a                	mv	a6,a4
    800004be:	2705                	addiw	a4,a4,1
    800004c0:	02b577bb          	remuw	a5,a0,a1
    800004c4:	1782                	slli	a5,a5,0x20
    800004c6:	9381                	srli	a5,a5,0x20
    800004c8:	97b2                	add	a5,a5,a2
    800004ca:	0007c783          	lbu	a5,0(a5)
    800004ce:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    800004d2:	0005079b          	sext.w	a5,a0
    800004d6:	02b5553b          	divuw	a0,a0,a1
    800004da:	0685                	addi	a3,a3,1
    800004dc:	feb7f0e3          	bgeu	a5,a1,800004bc <printint+0x26>

  if(sign)
    800004e0:	00088c63          	beqz	a7,800004f8 <printint+0x62>
    buf[i++] = '-';
    800004e4:	fe070793          	addi	a5,a4,-32
    800004e8:	00878733          	add	a4,a5,s0
    800004ec:	02d00793          	li	a5,45
    800004f0:	fef70823          	sb	a5,-16(a4)
    800004f4:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    800004f8:	02e05763          	blez	a4,80000526 <printint+0x90>
    800004fc:	fd040793          	addi	a5,s0,-48
    80000500:	00e784b3          	add	s1,a5,a4
    80000504:	fff78913          	addi	s2,a5,-1
    80000508:	993a                	add	s2,s2,a4
    8000050a:	377d                	addiw	a4,a4,-1
    8000050c:	1702                	slli	a4,a4,0x20
    8000050e:	9301                	srli	a4,a4,0x20
    80000510:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80000514:	fff4c503          	lbu	a0,-1(s1)
    80000518:	00000097          	auipc	ra,0x0
    8000051c:	d5e080e7          	jalr	-674(ra) # 80000276 <consputc>
  while(--i >= 0)
    80000520:	14fd                	addi	s1,s1,-1
    80000522:	ff2499e3          	bne	s1,s2,80000514 <printint+0x7e>
}
    80000526:	70a2                	ld	ra,40(sp)
    80000528:	7402                	ld	s0,32(sp)
    8000052a:	64e2                	ld	s1,24(sp)
    8000052c:	6942                	ld	s2,16(sp)
    8000052e:	6145                	addi	sp,sp,48
    80000530:	8082                	ret
    x = -xx;
    80000532:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80000536:	4885                	li	a7,1
    x = -xx;
    80000538:	bf95                	j	800004ac <printint+0x16>

000000008000053a <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    8000053a:	1101                	addi	sp,sp,-32
    8000053c:	ec06                	sd	ra,24(sp)
    8000053e:	e822                	sd	s0,16(sp)
    80000540:	e426                	sd	s1,8(sp)
    80000542:	1000                	addi	s0,sp,32
    80000544:	84aa                	mv	s1,a0
  pr.locking = 0;
    80000546:	00011797          	auipc	a5,0x11
    8000054a:	ce07ad23          	sw	zero,-774(a5) # 80011240 <pr+0x18>
  printf("panic: ");
    8000054e:	00008517          	auipc	a0,0x8
    80000552:	aca50513          	addi	a0,a0,-1334 # 80008018 <etext+0x18>
    80000556:	00000097          	auipc	ra,0x0
    8000055a:	02e080e7          	jalr	46(ra) # 80000584 <printf>
  printf(s);
    8000055e:	8526                	mv	a0,s1
    80000560:	00000097          	auipc	ra,0x0
    80000564:	024080e7          	jalr	36(ra) # 80000584 <printf>
  printf("\n");
    80000568:	00008517          	auipc	a0,0x8
    8000056c:	b6050513          	addi	a0,a0,-1184 # 800080c8 <digits+0x88>
    80000570:	00000097          	auipc	ra,0x0
    80000574:	014080e7          	jalr	20(ra) # 80000584 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80000578:	4785                	li	a5,1
    8000057a:	00009717          	auipc	a4,0x9
    8000057e:	a8f72323          	sw	a5,-1402(a4) # 80009000 <panicked>
  for(;;)
    80000582:	a001                	j	80000582 <panic+0x48>

0000000080000584 <printf>:
{
    80000584:	7131                	addi	sp,sp,-192
    80000586:	fc86                	sd	ra,120(sp)
    80000588:	f8a2                	sd	s0,112(sp)
    8000058a:	f4a6                	sd	s1,104(sp)
    8000058c:	f0ca                	sd	s2,96(sp)
    8000058e:	ecce                	sd	s3,88(sp)
    80000590:	e8d2                	sd	s4,80(sp)
    80000592:	e4d6                	sd	s5,72(sp)
    80000594:	e0da                	sd	s6,64(sp)
    80000596:	fc5e                	sd	s7,56(sp)
    80000598:	f862                	sd	s8,48(sp)
    8000059a:	f466                	sd	s9,40(sp)
    8000059c:	f06a                	sd	s10,32(sp)
    8000059e:	ec6e                	sd	s11,24(sp)
    800005a0:	0100                	addi	s0,sp,128
    800005a2:	8a2a                	mv	s4,a0
    800005a4:	e40c                	sd	a1,8(s0)
    800005a6:	e810                	sd	a2,16(s0)
    800005a8:	ec14                	sd	a3,24(s0)
    800005aa:	f018                	sd	a4,32(s0)
    800005ac:	f41c                	sd	a5,40(s0)
    800005ae:	03043823          	sd	a6,48(s0)
    800005b2:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800005b6:	00011d97          	auipc	s11,0x11
    800005ba:	c8adad83          	lw	s11,-886(s11) # 80011240 <pr+0x18>
  if(locking)
    800005be:	020d9b63          	bnez	s11,800005f4 <printf+0x70>
  if (fmt == 0)
    800005c2:	040a0263          	beqz	s4,80000606 <printf+0x82>
  va_start(ap, fmt);
    800005c6:	00840793          	addi	a5,s0,8
    800005ca:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800005ce:	000a4503          	lbu	a0,0(s4)
    800005d2:	14050f63          	beqz	a0,80000730 <printf+0x1ac>
    800005d6:	4981                	li	s3,0
    if(c != '%'){
    800005d8:	02500a93          	li	s5,37
    switch(c){
    800005dc:	07000b93          	li	s7,112
  consputc('x');
    800005e0:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800005e2:	00008b17          	auipc	s6,0x8
    800005e6:	a5eb0b13          	addi	s6,s6,-1442 # 80008040 <digits>
    switch(c){
    800005ea:	07300c93          	li	s9,115
    800005ee:	06400c13          	li	s8,100
    800005f2:	a82d                	j	8000062c <printf+0xa8>
    acquire(&pr.lock);
    800005f4:	00011517          	auipc	a0,0x11
    800005f8:	c3450513          	addi	a0,a0,-972 # 80011228 <pr>
    800005fc:	00000097          	auipc	ra,0x0
    80000600:	5d4080e7          	jalr	1492(ra) # 80000bd0 <acquire>
    80000604:	bf7d                	j	800005c2 <printf+0x3e>
    panic("null fmt");
    80000606:	00008517          	auipc	a0,0x8
    8000060a:	a2250513          	addi	a0,a0,-1502 # 80008028 <etext+0x28>
    8000060e:	00000097          	auipc	ra,0x0
    80000612:	f2c080e7          	jalr	-212(ra) # 8000053a <panic>
      consputc(c);
    80000616:	00000097          	auipc	ra,0x0
    8000061a:	c60080e7          	jalr	-928(ra) # 80000276 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    8000061e:	2985                	addiw	s3,s3,1
    80000620:	013a07b3          	add	a5,s4,s3
    80000624:	0007c503          	lbu	a0,0(a5)
    80000628:	10050463          	beqz	a0,80000730 <printf+0x1ac>
    if(c != '%'){
    8000062c:	ff5515e3          	bne	a0,s5,80000616 <printf+0x92>
    c = fmt[++i] & 0xff;
    80000630:	2985                	addiw	s3,s3,1
    80000632:	013a07b3          	add	a5,s4,s3
    80000636:	0007c783          	lbu	a5,0(a5)
    8000063a:	0007849b          	sext.w	s1,a5
    if(c == 0)
    8000063e:	cbed                	beqz	a5,80000730 <printf+0x1ac>
    switch(c){
    80000640:	05778a63          	beq	a5,s7,80000694 <printf+0x110>
    80000644:	02fbf663          	bgeu	s7,a5,80000670 <printf+0xec>
    80000648:	09978863          	beq	a5,s9,800006d8 <printf+0x154>
    8000064c:	07800713          	li	a4,120
    80000650:	0ce79563          	bne	a5,a4,8000071a <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    80000654:	f8843783          	ld	a5,-120(s0)
    80000658:	00878713          	addi	a4,a5,8
    8000065c:	f8e43423          	sd	a4,-120(s0)
    80000660:	4605                	li	a2,1
    80000662:	85ea                	mv	a1,s10
    80000664:	4388                	lw	a0,0(a5)
    80000666:	00000097          	auipc	ra,0x0
    8000066a:	e30080e7          	jalr	-464(ra) # 80000496 <printint>
      break;
    8000066e:	bf45                	j	8000061e <printf+0x9a>
    switch(c){
    80000670:	09578f63          	beq	a5,s5,8000070e <printf+0x18a>
    80000674:	0b879363          	bne	a5,s8,8000071a <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    80000678:	f8843783          	ld	a5,-120(s0)
    8000067c:	00878713          	addi	a4,a5,8
    80000680:	f8e43423          	sd	a4,-120(s0)
    80000684:	4605                	li	a2,1
    80000686:	45a9                	li	a1,10
    80000688:	4388                	lw	a0,0(a5)
    8000068a:	00000097          	auipc	ra,0x0
    8000068e:	e0c080e7          	jalr	-500(ra) # 80000496 <printint>
      break;
    80000692:	b771                	j	8000061e <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80000694:	f8843783          	ld	a5,-120(s0)
    80000698:	00878713          	addi	a4,a5,8
    8000069c:	f8e43423          	sd	a4,-120(s0)
    800006a0:	0007b903          	ld	s2,0(a5)
  consputc('0');
    800006a4:	03000513          	li	a0,48
    800006a8:	00000097          	auipc	ra,0x0
    800006ac:	bce080e7          	jalr	-1074(ra) # 80000276 <consputc>
  consputc('x');
    800006b0:	07800513          	li	a0,120
    800006b4:	00000097          	auipc	ra,0x0
    800006b8:	bc2080e7          	jalr	-1086(ra) # 80000276 <consputc>
    800006bc:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800006be:	03c95793          	srli	a5,s2,0x3c
    800006c2:	97da                	add	a5,a5,s6
    800006c4:	0007c503          	lbu	a0,0(a5)
    800006c8:	00000097          	auipc	ra,0x0
    800006cc:	bae080e7          	jalr	-1106(ra) # 80000276 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800006d0:	0912                	slli	s2,s2,0x4
    800006d2:	34fd                	addiw	s1,s1,-1
    800006d4:	f4ed                	bnez	s1,800006be <printf+0x13a>
    800006d6:	b7a1                	j	8000061e <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    800006d8:	f8843783          	ld	a5,-120(s0)
    800006dc:	00878713          	addi	a4,a5,8
    800006e0:	f8e43423          	sd	a4,-120(s0)
    800006e4:	6384                	ld	s1,0(a5)
    800006e6:	cc89                	beqz	s1,80000700 <printf+0x17c>
      for(; *s; s++)
    800006e8:	0004c503          	lbu	a0,0(s1)
    800006ec:	d90d                	beqz	a0,8000061e <printf+0x9a>
        consputc(*s);
    800006ee:	00000097          	auipc	ra,0x0
    800006f2:	b88080e7          	jalr	-1144(ra) # 80000276 <consputc>
      for(; *s; s++)
    800006f6:	0485                	addi	s1,s1,1
    800006f8:	0004c503          	lbu	a0,0(s1)
    800006fc:	f96d                	bnez	a0,800006ee <printf+0x16a>
    800006fe:	b705                	j	8000061e <printf+0x9a>
        s = "(null)";
    80000700:	00008497          	auipc	s1,0x8
    80000704:	92048493          	addi	s1,s1,-1760 # 80008020 <etext+0x20>
      for(; *s; s++)
    80000708:	02800513          	li	a0,40
    8000070c:	b7cd                	j	800006ee <printf+0x16a>
      consputc('%');
    8000070e:	8556                	mv	a0,s5
    80000710:	00000097          	auipc	ra,0x0
    80000714:	b66080e7          	jalr	-1178(ra) # 80000276 <consputc>
      break;
    80000718:	b719                	j	8000061e <printf+0x9a>
      consputc('%');
    8000071a:	8556                	mv	a0,s5
    8000071c:	00000097          	auipc	ra,0x0
    80000720:	b5a080e7          	jalr	-1190(ra) # 80000276 <consputc>
      consputc(c);
    80000724:	8526                	mv	a0,s1
    80000726:	00000097          	auipc	ra,0x0
    8000072a:	b50080e7          	jalr	-1200(ra) # 80000276 <consputc>
      break;
    8000072e:	bdc5                	j	8000061e <printf+0x9a>
  if(locking)
    80000730:	020d9163          	bnez	s11,80000752 <printf+0x1ce>
}
    80000734:	70e6                	ld	ra,120(sp)
    80000736:	7446                	ld	s0,112(sp)
    80000738:	74a6                	ld	s1,104(sp)
    8000073a:	7906                	ld	s2,96(sp)
    8000073c:	69e6                	ld	s3,88(sp)
    8000073e:	6a46                	ld	s4,80(sp)
    80000740:	6aa6                	ld	s5,72(sp)
    80000742:	6b06                	ld	s6,64(sp)
    80000744:	7be2                	ld	s7,56(sp)
    80000746:	7c42                	ld	s8,48(sp)
    80000748:	7ca2                	ld	s9,40(sp)
    8000074a:	7d02                	ld	s10,32(sp)
    8000074c:	6de2                	ld	s11,24(sp)
    8000074e:	6129                	addi	sp,sp,192
    80000750:	8082                	ret
    release(&pr.lock);
    80000752:	00011517          	auipc	a0,0x11
    80000756:	ad650513          	addi	a0,a0,-1322 # 80011228 <pr>
    8000075a:	00000097          	auipc	ra,0x0
    8000075e:	52a080e7          	jalr	1322(ra) # 80000c84 <release>
}
    80000762:	bfc9                	j	80000734 <printf+0x1b0>

0000000080000764 <printfinit>:
    ;
}

void
printfinit(void)
{
    80000764:	1101                	addi	sp,sp,-32
    80000766:	ec06                	sd	ra,24(sp)
    80000768:	e822                	sd	s0,16(sp)
    8000076a:	e426                	sd	s1,8(sp)
    8000076c:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    8000076e:	00011497          	auipc	s1,0x11
    80000772:	aba48493          	addi	s1,s1,-1350 # 80011228 <pr>
    80000776:	00008597          	auipc	a1,0x8
    8000077a:	8c258593          	addi	a1,a1,-1854 # 80008038 <etext+0x38>
    8000077e:	8526                	mv	a0,s1
    80000780:	00000097          	auipc	ra,0x0
    80000784:	3c0080e7          	jalr	960(ra) # 80000b40 <initlock>
  pr.locking = 1;
    80000788:	4785                	li	a5,1
    8000078a:	cc9c                	sw	a5,24(s1)
}
    8000078c:	60e2                	ld	ra,24(sp)
    8000078e:	6442                	ld	s0,16(sp)
    80000790:	64a2                	ld	s1,8(sp)
    80000792:	6105                	addi	sp,sp,32
    80000794:	8082                	ret

0000000080000796 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80000796:	1141                	addi	sp,sp,-16
    80000798:	e406                	sd	ra,8(sp)
    8000079a:	e022                	sd	s0,0(sp)
    8000079c:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    8000079e:	100007b7          	lui	a5,0x10000
    800007a2:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800007a6:	f8000713          	li	a4,-128
    800007aa:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800007ae:	470d                	li	a4,3
    800007b0:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800007b4:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800007b8:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800007bc:	469d                	li	a3,7
    800007be:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800007c2:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    800007c6:	00008597          	auipc	a1,0x8
    800007ca:	89258593          	addi	a1,a1,-1902 # 80008058 <digits+0x18>
    800007ce:	00011517          	auipc	a0,0x11
    800007d2:	a7a50513          	addi	a0,a0,-1414 # 80011248 <uart_tx_lock>
    800007d6:	00000097          	auipc	ra,0x0
    800007da:	36a080e7          	jalr	874(ra) # 80000b40 <initlock>
}
    800007de:	60a2                	ld	ra,8(sp)
    800007e0:	6402                	ld	s0,0(sp)
    800007e2:	0141                	addi	sp,sp,16
    800007e4:	8082                	ret

00000000800007e6 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800007e6:	1101                	addi	sp,sp,-32
    800007e8:	ec06                	sd	ra,24(sp)
    800007ea:	e822                	sd	s0,16(sp)
    800007ec:	e426                	sd	s1,8(sp)
    800007ee:	1000                	addi	s0,sp,32
    800007f0:	84aa                	mv	s1,a0
  push_off();
    800007f2:	00000097          	auipc	ra,0x0
    800007f6:	392080e7          	jalr	914(ra) # 80000b84 <push_off>

  if(panicked){
    800007fa:	00009797          	auipc	a5,0x9
    800007fe:	8067a783          	lw	a5,-2042(a5) # 80009000 <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000802:	10000737          	lui	a4,0x10000
  if(panicked){
    80000806:	c391                	beqz	a5,8000080a <uartputc_sync+0x24>
    for(;;)
    80000808:	a001                	j	80000808 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    8000080a:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000080e:	0207f793          	andi	a5,a5,32
    80000812:	dfe5                	beqz	a5,8000080a <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80000814:	0ff4f513          	zext.b	a0,s1
    80000818:	100007b7          	lui	a5,0x10000
    8000081c:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80000820:	00000097          	auipc	ra,0x0
    80000824:	404080e7          	jalr	1028(ra) # 80000c24 <pop_off>
}
    80000828:	60e2                	ld	ra,24(sp)
    8000082a:	6442                	ld	s0,16(sp)
    8000082c:	64a2                	ld	s1,8(sp)
    8000082e:	6105                	addi	sp,sp,32
    80000830:	8082                	ret

0000000080000832 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80000832:	00008797          	auipc	a5,0x8
    80000836:	7d67b783          	ld	a5,2006(a5) # 80009008 <uart_tx_r>
    8000083a:	00008717          	auipc	a4,0x8
    8000083e:	7d673703          	ld	a4,2006(a4) # 80009010 <uart_tx_w>
    80000842:	06f70a63          	beq	a4,a5,800008b6 <uartstart+0x84>
{
    80000846:	7139                	addi	sp,sp,-64
    80000848:	fc06                	sd	ra,56(sp)
    8000084a:	f822                	sd	s0,48(sp)
    8000084c:	f426                	sd	s1,40(sp)
    8000084e:	f04a                	sd	s2,32(sp)
    80000850:	ec4e                	sd	s3,24(sp)
    80000852:	e852                	sd	s4,16(sp)
    80000854:	e456                	sd	s5,8(sp)
    80000856:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000858:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000085c:	00011a17          	auipc	s4,0x11
    80000860:	9eca0a13          	addi	s4,s4,-1556 # 80011248 <uart_tx_lock>
    uart_tx_r += 1;
    80000864:	00008497          	auipc	s1,0x8
    80000868:	7a448493          	addi	s1,s1,1956 # 80009008 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    8000086c:	00008997          	auipc	s3,0x8
    80000870:	7a498993          	addi	s3,s3,1956 # 80009010 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000874:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    80000878:	02077713          	andi	a4,a4,32
    8000087c:	c705                	beqz	a4,800008a4 <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000087e:	01f7f713          	andi	a4,a5,31
    80000882:	9752                	add	a4,a4,s4
    80000884:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    80000888:	0785                	addi	a5,a5,1
    8000088a:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    8000088c:	8526                	mv	a0,s1
    8000088e:	00002097          	auipc	ra,0x2
    80000892:	962080e7          	jalr	-1694(ra) # 800021f0 <wakeup>
    
    WriteReg(THR, c);
    80000896:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    8000089a:	609c                	ld	a5,0(s1)
    8000089c:	0009b703          	ld	a4,0(s3)
    800008a0:	fcf71ae3          	bne	a4,a5,80000874 <uartstart+0x42>
  }
}
    800008a4:	70e2                	ld	ra,56(sp)
    800008a6:	7442                	ld	s0,48(sp)
    800008a8:	74a2                	ld	s1,40(sp)
    800008aa:	7902                	ld	s2,32(sp)
    800008ac:	69e2                	ld	s3,24(sp)
    800008ae:	6a42                	ld	s4,16(sp)
    800008b0:	6aa2                	ld	s5,8(sp)
    800008b2:	6121                	addi	sp,sp,64
    800008b4:	8082                	ret
    800008b6:	8082                	ret

00000000800008b8 <uartputc>:
{
    800008b8:	7179                	addi	sp,sp,-48
    800008ba:	f406                	sd	ra,40(sp)
    800008bc:	f022                	sd	s0,32(sp)
    800008be:	ec26                	sd	s1,24(sp)
    800008c0:	e84a                	sd	s2,16(sp)
    800008c2:	e44e                	sd	s3,8(sp)
    800008c4:	e052                	sd	s4,0(sp)
    800008c6:	1800                	addi	s0,sp,48
    800008c8:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    800008ca:	00011517          	auipc	a0,0x11
    800008ce:	97e50513          	addi	a0,a0,-1666 # 80011248 <uart_tx_lock>
    800008d2:	00000097          	auipc	ra,0x0
    800008d6:	2fe080e7          	jalr	766(ra) # 80000bd0 <acquire>
  if(panicked){
    800008da:	00008797          	auipc	a5,0x8
    800008de:	7267a783          	lw	a5,1830(a5) # 80009000 <panicked>
    800008e2:	c391                	beqz	a5,800008e6 <uartputc+0x2e>
    for(;;)
    800008e4:	a001                	j	800008e4 <uartputc+0x2c>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800008e6:	00008717          	auipc	a4,0x8
    800008ea:	72a73703          	ld	a4,1834(a4) # 80009010 <uart_tx_w>
    800008ee:	00008797          	auipc	a5,0x8
    800008f2:	71a7b783          	ld	a5,1818(a5) # 80009008 <uart_tx_r>
    800008f6:	02078793          	addi	a5,a5,32
    800008fa:	02e79b63          	bne	a5,a4,80000930 <uartputc+0x78>
      sleep(&uart_tx_r, &uart_tx_lock);
    800008fe:	00011997          	auipc	s3,0x11
    80000902:	94a98993          	addi	s3,s3,-1718 # 80011248 <uart_tx_lock>
    80000906:	00008497          	auipc	s1,0x8
    8000090a:	70248493          	addi	s1,s1,1794 # 80009008 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000090e:	00008917          	auipc	s2,0x8
    80000912:	70290913          	addi	s2,s2,1794 # 80009010 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    80000916:	85ce                	mv	a1,s3
    80000918:	8526                	mv	a0,s1
    8000091a:	00001097          	auipc	ra,0x1
    8000091e:	74a080e7          	jalr	1866(ra) # 80002064 <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000922:	00093703          	ld	a4,0(s2)
    80000926:	609c                	ld	a5,0(s1)
    80000928:	02078793          	addi	a5,a5,32
    8000092c:	fee785e3          	beq	a5,a4,80000916 <uartputc+0x5e>
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80000930:	00011497          	auipc	s1,0x11
    80000934:	91848493          	addi	s1,s1,-1768 # 80011248 <uart_tx_lock>
    80000938:	01f77793          	andi	a5,a4,31
    8000093c:	97a6                	add	a5,a5,s1
    8000093e:	01478c23          	sb	s4,24(a5)
      uart_tx_w += 1;
    80000942:	0705                	addi	a4,a4,1
    80000944:	00008797          	auipc	a5,0x8
    80000948:	6ce7b623          	sd	a4,1740(a5) # 80009010 <uart_tx_w>
      uartstart();
    8000094c:	00000097          	auipc	ra,0x0
    80000950:	ee6080e7          	jalr	-282(ra) # 80000832 <uartstart>
      release(&uart_tx_lock);
    80000954:	8526                	mv	a0,s1
    80000956:	00000097          	auipc	ra,0x0
    8000095a:	32e080e7          	jalr	814(ra) # 80000c84 <release>
}
    8000095e:	70a2                	ld	ra,40(sp)
    80000960:	7402                	ld	s0,32(sp)
    80000962:	64e2                	ld	s1,24(sp)
    80000964:	6942                	ld	s2,16(sp)
    80000966:	69a2                	ld	s3,8(sp)
    80000968:	6a02                	ld	s4,0(sp)
    8000096a:	6145                	addi	sp,sp,48
    8000096c:	8082                	ret

000000008000096e <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    8000096e:	1141                	addi	sp,sp,-16
    80000970:	e422                	sd	s0,8(sp)
    80000972:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000974:	100007b7          	lui	a5,0x10000
    80000978:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    8000097c:	8b85                	andi	a5,a5,1
    8000097e:	cb81                	beqz	a5,8000098e <uartgetc+0x20>
    // input data is ready.
    return ReadReg(RHR);
    80000980:	100007b7          	lui	a5,0x10000
    80000984:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    80000988:	6422                	ld	s0,8(sp)
    8000098a:	0141                	addi	sp,sp,16
    8000098c:	8082                	ret
    return -1;
    8000098e:	557d                	li	a0,-1
    80000990:	bfe5                	j	80000988 <uartgetc+0x1a>

0000000080000992 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    80000992:	1101                	addi	sp,sp,-32
    80000994:	ec06                	sd	ra,24(sp)
    80000996:	e822                	sd	s0,16(sp)
    80000998:	e426                	sd	s1,8(sp)
    8000099a:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    8000099c:	54fd                	li	s1,-1
    8000099e:	a029                	j	800009a8 <uartintr+0x16>
      break;
    consoleintr(c);
    800009a0:	00000097          	auipc	ra,0x0
    800009a4:	918080e7          	jalr	-1768(ra) # 800002b8 <consoleintr>
    int c = uartgetc();
    800009a8:	00000097          	auipc	ra,0x0
    800009ac:	fc6080e7          	jalr	-58(ra) # 8000096e <uartgetc>
    if(c == -1)
    800009b0:	fe9518e3          	bne	a0,s1,800009a0 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800009b4:	00011497          	auipc	s1,0x11
    800009b8:	89448493          	addi	s1,s1,-1900 # 80011248 <uart_tx_lock>
    800009bc:	8526                	mv	a0,s1
    800009be:	00000097          	auipc	ra,0x0
    800009c2:	212080e7          	jalr	530(ra) # 80000bd0 <acquire>
  uartstart();
    800009c6:	00000097          	auipc	ra,0x0
    800009ca:	e6c080e7          	jalr	-404(ra) # 80000832 <uartstart>
  release(&uart_tx_lock);
    800009ce:	8526                	mv	a0,s1
    800009d0:	00000097          	auipc	ra,0x0
    800009d4:	2b4080e7          	jalr	692(ra) # 80000c84 <release>
}
    800009d8:	60e2                	ld	ra,24(sp)
    800009da:	6442                	ld	s0,16(sp)
    800009dc:	64a2                	ld	s1,8(sp)
    800009de:	6105                	addi	sp,sp,32
    800009e0:	8082                	ret

00000000800009e2 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    800009e2:	1101                	addi	sp,sp,-32
    800009e4:	ec06                	sd	ra,24(sp)
    800009e6:	e822                	sd	s0,16(sp)
    800009e8:	e426                	sd	s1,8(sp)
    800009ea:	e04a                	sd	s2,0(sp)
    800009ec:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    800009ee:	03451793          	slli	a5,a0,0x34
    800009f2:	ebb9                	bnez	a5,80000a48 <kfree+0x66>
    800009f4:	84aa                	mv	s1,a0
    800009f6:	00025797          	auipc	a5,0x25
    800009fa:	60a78793          	addi	a5,a5,1546 # 80026000 <end>
    800009fe:	04f56563          	bltu	a0,a5,80000a48 <kfree+0x66>
    80000a02:	47c5                	li	a5,17
    80000a04:	07ee                	slli	a5,a5,0x1b
    80000a06:	04f57163          	bgeu	a0,a5,80000a48 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000a0a:	6605                	lui	a2,0x1
    80000a0c:	4585                	li	a1,1
    80000a0e:	00000097          	auipc	ra,0x0
    80000a12:	2be080e7          	jalr	702(ra) # 80000ccc <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000a16:	00011917          	auipc	s2,0x11
    80000a1a:	86a90913          	addi	s2,s2,-1942 # 80011280 <kmem>
    80000a1e:	854a                	mv	a0,s2
    80000a20:	00000097          	auipc	ra,0x0
    80000a24:	1b0080e7          	jalr	432(ra) # 80000bd0 <acquire>
  r->next = kmem.freelist;
    80000a28:	01893783          	ld	a5,24(s2)
    80000a2c:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000a2e:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000a32:	854a                	mv	a0,s2
    80000a34:	00000097          	auipc	ra,0x0
    80000a38:	250080e7          	jalr	592(ra) # 80000c84 <release>
}
    80000a3c:	60e2                	ld	ra,24(sp)
    80000a3e:	6442                	ld	s0,16(sp)
    80000a40:	64a2                	ld	s1,8(sp)
    80000a42:	6902                	ld	s2,0(sp)
    80000a44:	6105                	addi	sp,sp,32
    80000a46:	8082                	ret
    panic("kfree");
    80000a48:	00007517          	auipc	a0,0x7
    80000a4c:	61850513          	addi	a0,a0,1560 # 80008060 <digits+0x20>
    80000a50:	00000097          	auipc	ra,0x0
    80000a54:	aea080e7          	jalr	-1302(ra) # 8000053a <panic>

0000000080000a58 <freerange>:
{
    80000a58:	7179                	addi	sp,sp,-48
    80000a5a:	f406                	sd	ra,40(sp)
    80000a5c:	f022                	sd	s0,32(sp)
    80000a5e:	ec26                	sd	s1,24(sp)
    80000a60:	e84a                	sd	s2,16(sp)
    80000a62:	e44e                	sd	s3,8(sp)
    80000a64:	e052                	sd	s4,0(sp)
    80000a66:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    80000a68:	6785                	lui	a5,0x1
    80000a6a:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    80000a6e:	00e504b3          	add	s1,a0,a4
    80000a72:	777d                	lui	a4,0xfffff
    80000a74:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a76:	94be                	add	s1,s1,a5
    80000a78:	0095ee63          	bltu	a1,s1,80000a94 <freerange+0x3c>
    80000a7c:	892e                	mv	s2,a1
    kfree(p);
    80000a7e:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a80:	6985                	lui	s3,0x1
    kfree(p);
    80000a82:	01448533          	add	a0,s1,s4
    80000a86:	00000097          	auipc	ra,0x0
    80000a8a:	f5c080e7          	jalr	-164(ra) # 800009e2 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a8e:	94ce                	add	s1,s1,s3
    80000a90:	fe9979e3          	bgeu	s2,s1,80000a82 <freerange+0x2a>
}
    80000a94:	70a2                	ld	ra,40(sp)
    80000a96:	7402                	ld	s0,32(sp)
    80000a98:	64e2                	ld	s1,24(sp)
    80000a9a:	6942                	ld	s2,16(sp)
    80000a9c:	69a2                	ld	s3,8(sp)
    80000a9e:	6a02                	ld	s4,0(sp)
    80000aa0:	6145                	addi	sp,sp,48
    80000aa2:	8082                	ret

0000000080000aa4 <kinit>:
{
    80000aa4:	1141                	addi	sp,sp,-16
    80000aa6:	e406                	sd	ra,8(sp)
    80000aa8:	e022                	sd	s0,0(sp)
    80000aaa:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000aac:	00007597          	auipc	a1,0x7
    80000ab0:	5bc58593          	addi	a1,a1,1468 # 80008068 <digits+0x28>
    80000ab4:	00010517          	auipc	a0,0x10
    80000ab8:	7cc50513          	addi	a0,a0,1996 # 80011280 <kmem>
    80000abc:	00000097          	auipc	ra,0x0
    80000ac0:	084080e7          	jalr	132(ra) # 80000b40 <initlock>
  freerange(end, (void*)PHYSTOP);
    80000ac4:	45c5                	li	a1,17
    80000ac6:	05ee                	slli	a1,a1,0x1b
    80000ac8:	00025517          	auipc	a0,0x25
    80000acc:	53850513          	addi	a0,a0,1336 # 80026000 <end>
    80000ad0:	00000097          	auipc	ra,0x0
    80000ad4:	f88080e7          	jalr	-120(ra) # 80000a58 <freerange>
}
    80000ad8:	60a2                	ld	ra,8(sp)
    80000ada:	6402                	ld	s0,0(sp)
    80000adc:	0141                	addi	sp,sp,16
    80000ade:	8082                	ret

0000000080000ae0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000ae0:	1101                	addi	sp,sp,-32
    80000ae2:	ec06                	sd	ra,24(sp)
    80000ae4:	e822                	sd	s0,16(sp)
    80000ae6:	e426                	sd	s1,8(sp)
    80000ae8:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000aea:	00010497          	auipc	s1,0x10
    80000aee:	79648493          	addi	s1,s1,1942 # 80011280 <kmem>
    80000af2:	8526                	mv	a0,s1
    80000af4:	00000097          	auipc	ra,0x0
    80000af8:	0dc080e7          	jalr	220(ra) # 80000bd0 <acquire>
  r = kmem.freelist;
    80000afc:	6c84                	ld	s1,24(s1)
  if(r)
    80000afe:	c885                	beqz	s1,80000b2e <kalloc+0x4e>
    kmem.freelist = r->next;
    80000b00:	609c                	ld	a5,0(s1)
    80000b02:	00010517          	auipc	a0,0x10
    80000b06:	77e50513          	addi	a0,a0,1918 # 80011280 <kmem>
    80000b0a:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000b0c:	00000097          	auipc	ra,0x0
    80000b10:	178080e7          	jalr	376(ra) # 80000c84 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    80000b14:	6605                	lui	a2,0x1
    80000b16:	4595                	li	a1,5
    80000b18:	8526                	mv	a0,s1
    80000b1a:	00000097          	auipc	ra,0x0
    80000b1e:	1b2080e7          	jalr	434(ra) # 80000ccc <memset>
  return (void*)r;
}
    80000b22:	8526                	mv	a0,s1
    80000b24:	60e2                	ld	ra,24(sp)
    80000b26:	6442                	ld	s0,16(sp)
    80000b28:	64a2                	ld	s1,8(sp)
    80000b2a:	6105                	addi	sp,sp,32
    80000b2c:	8082                	ret
  release(&kmem.lock);
    80000b2e:	00010517          	auipc	a0,0x10
    80000b32:	75250513          	addi	a0,a0,1874 # 80011280 <kmem>
    80000b36:	00000097          	auipc	ra,0x0
    80000b3a:	14e080e7          	jalr	334(ra) # 80000c84 <release>
  if(r)
    80000b3e:	b7d5                	j	80000b22 <kalloc+0x42>

0000000080000b40 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80000b40:	1141                	addi	sp,sp,-16
    80000b42:	e422                	sd	s0,8(sp)
    80000b44:	0800                	addi	s0,sp,16
  lk->name = name;
    80000b46:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80000b48:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80000b4c:	00053823          	sd	zero,16(a0)
}
    80000b50:	6422                	ld	s0,8(sp)
    80000b52:	0141                	addi	sp,sp,16
    80000b54:	8082                	ret

0000000080000b56 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80000b56:	411c                	lw	a5,0(a0)
    80000b58:	e399                	bnez	a5,80000b5e <holding+0x8>
    80000b5a:	4501                	li	a0,0
  return r;
}
    80000b5c:	8082                	ret
{
    80000b5e:	1101                	addi	sp,sp,-32
    80000b60:	ec06                	sd	ra,24(sp)
    80000b62:	e822                	sd	s0,16(sp)
    80000b64:	e426                	sd	s1,8(sp)
    80000b66:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80000b68:	6904                	ld	s1,16(a0)
    80000b6a:	00001097          	auipc	ra,0x1
    80000b6e:	e10080e7          	jalr	-496(ra) # 8000197a <mycpu>
    80000b72:	40a48533          	sub	a0,s1,a0
    80000b76:	00153513          	seqz	a0,a0
}
    80000b7a:	60e2                	ld	ra,24(sp)
    80000b7c:	6442                	ld	s0,16(sp)
    80000b7e:	64a2                	ld	s1,8(sp)
    80000b80:	6105                	addi	sp,sp,32
    80000b82:	8082                	ret

0000000080000b84 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80000b84:	1101                	addi	sp,sp,-32
    80000b86:	ec06                	sd	ra,24(sp)
    80000b88:	e822                	sd	s0,16(sp)
    80000b8a:	e426                	sd	s1,8(sp)
    80000b8c:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000b8e:	100024f3          	csrr	s1,sstatus
    80000b92:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80000b96:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000b98:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80000b9c:	00001097          	auipc	ra,0x1
    80000ba0:	dde080e7          	jalr	-546(ra) # 8000197a <mycpu>
    80000ba4:	5d3c                	lw	a5,120(a0)
    80000ba6:	cf89                	beqz	a5,80000bc0 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80000ba8:	00001097          	auipc	ra,0x1
    80000bac:	dd2080e7          	jalr	-558(ra) # 8000197a <mycpu>
    80000bb0:	5d3c                	lw	a5,120(a0)
    80000bb2:	2785                	addiw	a5,a5,1
    80000bb4:	dd3c                	sw	a5,120(a0)
}
    80000bb6:	60e2                	ld	ra,24(sp)
    80000bb8:	6442                	ld	s0,16(sp)
    80000bba:	64a2                	ld	s1,8(sp)
    80000bbc:	6105                	addi	sp,sp,32
    80000bbe:	8082                	ret
    mycpu()->intena = old;
    80000bc0:	00001097          	auipc	ra,0x1
    80000bc4:	dba080e7          	jalr	-582(ra) # 8000197a <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80000bc8:	8085                	srli	s1,s1,0x1
    80000bca:	8885                	andi	s1,s1,1
    80000bcc:	dd64                	sw	s1,124(a0)
    80000bce:	bfe9                	j	80000ba8 <push_off+0x24>

0000000080000bd0 <acquire>:
{
    80000bd0:	1101                	addi	sp,sp,-32
    80000bd2:	ec06                	sd	ra,24(sp)
    80000bd4:	e822                	sd	s0,16(sp)
    80000bd6:	e426                	sd	s1,8(sp)
    80000bd8:	1000                	addi	s0,sp,32
    80000bda:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80000bdc:	00000097          	auipc	ra,0x0
    80000be0:	fa8080e7          	jalr	-88(ra) # 80000b84 <push_off>
  if(holding(lk))
    80000be4:	8526                	mv	a0,s1
    80000be6:	00000097          	auipc	ra,0x0
    80000bea:	f70080e7          	jalr	-144(ra) # 80000b56 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000bee:	4705                	li	a4,1
  if(holding(lk))
    80000bf0:	e115                	bnez	a0,80000c14 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000bf2:	87ba                	mv	a5,a4
    80000bf4:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000bf8:	2781                	sext.w	a5,a5
    80000bfa:	ffe5                	bnez	a5,80000bf2 <acquire+0x22>
  __sync_synchronize();
    80000bfc:	0ff0000f          	fence
  lk->cpu = mycpu();
    80000c00:	00001097          	auipc	ra,0x1
    80000c04:	d7a080e7          	jalr	-646(ra) # 8000197a <mycpu>
    80000c08:	e888                	sd	a0,16(s1)
}
    80000c0a:	60e2                	ld	ra,24(sp)
    80000c0c:	6442                	ld	s0,16(sp)
    80000c0e:	64a2                	ld	s1,8(sp)
    80000c10:	6105                	addi	sp,sp,32
    80000c12:	8082                	ret
    panic("acquire");
    80000c14:	00007517          	auipc	a0,0x7
    80000c18:	45c50513          	addi	a0,a0,1116 # 80008070 <digits+0x30>
    80000c1c:	00000097          	auipc	ra,0x0
    80000c20:	91e080e7          	jalr	-1762(ra) # 8000053a <panic>

0000000080000c24 <pop_off>:

void
pop_off(void)
{
    80000c24:	1141                	addi	sp,sp,-16
    80000c26:	e406                	sd	ra,8(sp)
    80000c28:	e022                	sd	s0,0(sp)
    80000c2a:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80000c2c:	00001097          	auipc	ra,0x1
    80000c30:	d4e080e7          	jalr	-690(ra) # 8000197a <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c34:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000c38:	8b89                	andi	a5,a5,2
  if(intr_get())
    80000c3a:	e78d                	bnez	a5,80000c64 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80000c3c:	5d3c                	lw	a5,120(a0)
    80000c3e:	02f05b63          	blez	a5,80000c74 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80000c42:	37fd                	addiw	a5,a5,-1
    80000c44:	0007871b          	sext.w	a4,a5
    80000c48:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80000c4a:	eb09                	bnez	a4,80000c5c <pop_off+0x38>
    80000c4c:	5d7c                	lw	a5,124(a0)
    80000c4e:	c799                	beqz	a5,80000c5c <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c50:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80000c54:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000c58:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80000c5c:	60a2                	ld	ra,8(sp)
    80000c5e:	6402                	ld	s0,0(sp)
    80000c60:	0141                	addi	sp,sp,16
    80000c62:	8082                	ret
    panic("pop_off - interruptible");
    80000c64:	00007517          	auipc	a0,0x7
    80000c68:	41450513          	addi	a0,a0,1044 # 80008078 <digits+0x38>
    80000c6c:	00000097          	auipc	ra,0x0
    80000c70:	8ce080e7          	jalr	-1842(ra) # 8000053a <panic>
    panic("pop_off");
    80000c74:	00007517          	auipc	a0,0x7
    80000c78:	41c50513          	addi	a0,a0,1052 # 80008090 <digits+0x50>
    80000c7c:	00000097          	auipc	ra,0x0
    80000c80:	8be080e7          	jalr	-1858(ra) # 8000053a <panic>

0000000080000c84 <release>:
{
    80000c84:	1101                	addi	sp,sp,-32
    80000c86:	ec06                	sd	ra,24(sp)
    80000c88:	e822                	sd	s0,16(sp)
    80000c8a:	e426                	sd	s1,8(sp)
    80000c8c:	1000                	addi	s0,sp,32
    80000c8e:	84aa                	mv	s1,a0
  if(!holding(lk))
    80000c90:	00000097          	auipc	ra,0x0
    80000c94:	ec6080e7          	jalr	-314(ra) # 80000b56 <holding>
    80000c98:	c115                	beqz	a0,80000cbc <release+0x38>
  lk->cpu = 0;
    80000c9a:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80000c9e:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80000ca2:	0f50000f          	fence	iorw,ow
    80000ca6:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80000caa:	00000097          	auipc	ra,0x0
    80000cae:	f7a080e7          	jalr	-134(ra) # 80000c24 <pop_off>
}
    80000cb2:	60e2                	ld	ra,24(sp)
    80000cb4:	6442                	ld	s0,16(sp)
    80000cb6:	64a2                	ld	s1,8(sp)
    80000cb8:	6105                	addi	sp,sp,32
    80000cba:	8082                	ret
    panic("release");
    80000cbc:	00007517          	auipc	a0,0x7
    80000cc0:	3dc50513          	addi	a0,a0,988 # 80008098 <digits+0x58>
    80000cc4:	00000097          	auipc	ra,0x0
    80000cc8:	876080e7          	jalr	-1930(ra) # 8000053a <panic>

0000000080000ccc <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000ccc:	1141                	addi	sp,sp,-16
    80000cce:	e422                	sd	s0,8(sp)
    80000cd0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000cd2:	ca19                	beqz	a2,80000ce8 <memset+0x1c>
    80000cd4:	87aa                	mv	a5,a0
    80000cd6:	1602                	slli	a2,a2,0x20
    80000cd8:	9201                	srli	a2,a2,0x20
    80000cda:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000cde:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000ce2:	0785                	addi	a5,a5,1
    80000ce4:	fee79de3          	bne	a5,a4,80000cde <memset+0x12>
  }
  return dst;
}
    80000ce8:	6422                	ld	s0,8(sp)
    80000cea:	0141                	addi	sp,sp,16
    80000cec:	8082                	ret

0000000080000cee <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000cee:	1141                	addi	sp,sp,-16
    80000cf0:	e422                	sd	s0,8(sp)
    80000cf2:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80000cf4:	ca05                	beqz	a2,80000d24 <memcmp+0x36>
    80000cf6:	fff6069b          	addiw	a3,a2,-1
    80000cfa:	1682                	slli	a3,a3,0x20
    80000cfc:	9281                	srli	a3,a3,0x20
    80000cfe:	0685                	addi	a3,a3,1
    80000d00:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    80000d02:	00054783          	lbu	a5,0(a0)
    80000d06:	0005c703          	lbu	a4,0(a1)
    80000d0a:	00e79863          	bne	a5,a4,80000d1a <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    80000d0e:	0505                	addi	a0,a0,1
    80000d10:	0585                	addi	a1,a1,1
  while(n-- > 0){
    80000d12:	fed518e3          	bne	a0,a3,80000d02 <memcmp+0x14>
  }

  return 0;
    80000d16:	4501                	li	a0,0
    80000d18:	a019                	j	80000d1e <memcmp+0x30>
      return *s1 - *s2;
    80000d1a:	40e7853b          	subw	a0,a5,a4
}
    80000d1e:	6422                	ld	s0,8(sp)
    80000d20:	0141                	addi	sp,sp,16
    80000d22:	8082                	ret
  return 0;
    80000d24:	4501                	li	a0,0
    80000d26:	bfe5                	j	80000d1e <memcmp+0x30>

0000000080000d28 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80000d28:	1141                	addi	sp,sp,-16
    80000d2a:	e422                	sd	s0,8(sp)
    80000d2c:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    80000d2e:	c205                	beqz	a2,80000d4e <memmove+0x26>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    80000d30:	02a5e263          	bltu	a1,a0,80000d54 <memmove+0x2c>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    80000d34:	1602                	slli	a2,a2,0x20
    80000d36:	9201                	srli	a2,a2,0x20
    80000d38:	00c587b3          	add	a5,a1,a2
{
    80000d3c:	872a                	mv	a4,a0
      *d++ = *s++;
    80000d3e:	0585                	addi	a1,a1,1
    80000d40:	0705                	addi	a4,a4,1
    80000d42:	fff5c683          	lbu	a3,-1(a1)
    80000d46:	fed70fa3          	sb	a3,-1(a4) # ffffffffffffefff <end+0xffffffff7ffd8fff>
    while(n-- > 0)
    80000d4a:	fef59ae3          	bne	a1,a5,80000d3e <memmove+0x16>

  return dst;
}
    80000d4e:	6422                	ld	s0,8(sp)
    80000d50:	0141                	addi	sp,sp,16
    80000d52:	8082                	ret
  if(s < d && s + n > d){
    80000d54:	02061693          	slli	a3,a2,0x20
    80000d58:	9281                	srli	a3,a3,0x20
    80000d5a:	00d58733          	add	a4,a1,a3
    80000d5e:	fce57be3          	bgeu	a0,a4,80000d34 <memmove+0xc>
    d += n;
    80000d62:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000d64:	fff6079b          	addiw	a5,a2,-1
    80000d68:	1782                	slli	a5,a5,0x20
    80000d6a:	9381                	srli	a5,a5,0x20
    80000d6c:	fff7c793          	not	a5,a5
    80000d70:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000d72:	177d                	addi	a4,a4,-1
    80000d74:	16fd                	addi	a3,a3,-1
    80000d76:	00074603          	lbu	a2,0(a4)
    80000d7a:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000d7e:	fee79ae3          	bne	a5,a4,80000d72 <memmove+0x4a>
    80000d82:	b7f1                	j	80000d4e <memmove+0x26>

0000000080000d84 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000d84:	1141                	addi	sp,sp,-16
    80000d86:	e406                	sd	ra,8(sp)
    80000d88:	e022                	sd	s0,0(sp)
    80000d8a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000d8c:	00000097          	auipc	ra,0x0
    80000d90:	f9c080e7          	jalr	-100(ra) # 80000d28 <memmove>
}
    80000d94:	60a2                	ld	ra,8(sp)
    80000d96:	6402                	ld	s0,0(sp)
    80000d98:	0141                	addi	sp,sp,16
    80000d9a:	8082                	ret

0000000080000d9c <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000d9c:	1141                	addi	sp,sp,-16
    80000d9e:	e422                	sd	s0,8(sp)
    80000da0:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000da2:	ce11                	beqz	a2,80000dbe <strncmp+0x22>
    80000da4:	00054783          	lbu	a5,0(a0)
    80000da8:	cf89                	beqz	a5,80000dc2 <strncmp+0x26>
    80000daa:	0005c703          	lbu	a4,0(a1)
    80000dae:	00f71a63          	bne	a4,a5,80000dc2 <strncmp+0x26>
    n--, p++, q++;
    80000db2:	367d                	addiw	a2,a2,-1
    80000db4:	0505                	addi	a0,a0,1
    80000db6:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000db8:	f675                	bnez	a2,80000da4 <strncmp+0x8>
  if(n == 0)
    return 0;
    80000dba:	4501                	li	a0,0
    80000dbc:	a809                	j	80000dce <strncmp+0x32>
    80000dbe:	4501                	li	a0,0
    80000dc0:	a039                	j	80000dce <strncmp+0x32>
  if(n == 0)
    80000dc2:	ca09                	beqz	a2,80000dd4 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000dc4:	00054503          	lbu	a0,0(a0)
    80000dc8:	0005c783          	lbu	a5,0(a1)
    80000dcc:	9d1d                	subw	a0,a0,a5
}
    80000dce:	6422                	ld	s0,8(sp)
    80000dd0:	0141                	addi	sp,sp,16
    80000dd2:	8082                	ret
    return 0;
    80000dd4:	4501                	li	a0,0
    80000dd6:	bfe5                	j	80000dce <strncmp+0x32>

0000000080000dd8 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000dd8:	1141                	addi	sp,sp,-16
    80000dda:	e422                	sd	s0,8(sp)
    80000ddc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000dde:	872a                	mv	a4,a0
    80000de0:	8832                	mv	a6,a2
    80000de2:	367d                	addiw	a2,a2,-1
    80000de4:	01005963          	blez	a6,80000df6 <strncpy+0x1e>
    80000de8:	0705                	addi	a4,a4,1
    80000dea:	0005c783          	lbu	a5,0(a1)
    80000dee:	fef70fa3          	sb	a5,-1(a4)
    80000df2:	0585                	addi	a1,a1,1
    80000df4:	f7f5                	bnez	a5,80000de0 <strncpy+0x8>
    ;
  while(n-- > 0)
    80000df6:	86ba                	mv	a3,a4
    80000df8:	00c05c63          	blez	a2,80000e10 <strncpy+0x38>
    *s++ = 0;
    80000dfc:	0685                	addi	a3,a3,1
    80000dfe:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    80000e02:	40d707bb          	subw	a5,a4,a3
    80000e06:	37fd                	addiw	a5,a5,-1
    80000e08:	010787bb          	addw	a5,a5,a6
    80000e0c:	fef048e3          	bgtz	a5,80000dfc <strncpy+0x24>
  return os;
}
    80000e10:	6422                	ld	s0,8(sp)
    80000e12:	0141                	addi	sp,sp,16
    80000e14:	8082                	ret

0000000080000e16 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80000e16:	1141                	addi	sp,sp,-16
    80000e18:	e422                	sd	s0,8(sp)
    80000e1a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000e1c:	02c05363          	blez	a2,80000e42 <safestrcpy+0x2c>
    80000e20:	fff6069b          	addiw	a3,a2,-1
    80000e24:	1682                	slli	a3,a3,0x20
    80000e26:	9281                	srli	a3,a3,0x20
    80000e28:	96ae                	add	a3,a3,a1
    80000e2a:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    80000e2c:	00d58963          	beq	a1,a3,80000e3e <safestrcpy+0x28>
    80000e30:	0585                	addi	a1,a1,1
    80000e32:	0785                	addi	a5,a5,1
    80000e34:	fff5c703          	lbu	a4,-1(a1)
    80000e38:	fee78fa3          	sb	a4,-1(a5)
    80000e3c:	fb65                	bnez	a4,80000e2c <safestrcpy+0x16>
    ;
  *s = 0;
    80000e3e:	00078023          	sb	zero,0(a5)
  return os;
}
    80000e42:	6422                	ld	s0,8(sp)
    80000e44:	0141                	addi	sp,sp,16
    80000e46:	8082                	ret

0000000080000e48 <strlen>:

int
strlen(const char *s)
{
    80000e48:	1141                	addi	sp,sp,-16
    80000e4a:	e422                	sd	s0,8(sp)
    80000e4c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000e4e:	00054783          	lbu	a5,0(a0)
    80000e52:	cf91                	beqz	a5,80000e6e <strlen+0x26>
    80000e54:	0505                	addi	a0,a0,1
    80000e56:	87aa                	mv	a5,a0
    80000e58:	4685                	li	a3,1
    80000e5a:	9e89                	subw	a3,a3,a0
    80000e5c:	00f6853b          	addw	a0,a3,a5
    80000e60:	0785                	addi	a5,a5,1
    80000e62:	fff7c703          	lbu	a4,-1(a5)
    80000e66:	fb7d                	bnez	a4,80000e5c <strlen+0x14>
    ;
  return n;
}
    80000e68:	6422                	ld	s0,8(sp)
    80000e6a:	0141                	addi	sp,sp,16
    80000e6c:	8082                	ret
  for(n = 0; s[n]; n++)
    80000e6e:	4501                	li	a0,0
    80000e70:	bfe5                	j	80000e68 <strlen+0x20>

0000000080000e72 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000e72:	1141                	addi	sp,sp,-16
    80000e74:	e406                	sd	ra,8(sp)
    80000e76:	e022                	sd	s0,0(sp)
    80000e78:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80000e7a:	00001097          	auipc	ra,0x1
    80000e7e:	af0080e7          	jalr	-1296(ra) # 8000196a <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000e82:	00008717          	auipc	a4,0x8
    80000e86:	19670713          	addi	a4,a4,406 # 80009018 <started>
  if(cpuid() == 0){
    80000e8a:	c139                	beqz	a0,80000ed0 <main+0x5e>
    while(started == 0)
    80000e8c:	431c                	lw	a5,0(a4)
    80000e8e:	2781                	sext.w	a5,a5
    80000e90:	dff5                	beqz	a5,80000e8c <main+0x1a>
      ;
    __sync_synchronize();
    80000e92:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000e96:	00001097          	auipc	ra,0x1
    80000e9a:	ad4080e7          	jalr	-1324(ra) # 8000196a <cpuid>
    80000e9e:	85aa                	mv	a1,a0
    80000ea0:	00007517          	auipc	a0,0x7
    80000ea4:	21850513          	addi	a0,a0,536 # 800080b8 <digits+0x78>
    80000ea8:	fffff097          	auipc	ra,0xfffff
    80000eac:	6dc080e7          	jalr	1756(ra) # 80000584 <printf>
    kvminithart();    // turn on paging
    80000eb0:	00000097          	auipc	ra,0x0
    80000eb4:	0d8080e7          	jalr	216(ra) # 80000f88 <kvminithart>
    trapinithart();   // install kernel trap vector
    80000eb8:	00001097          	auipc	ra,0x1
    80000ebc:	7ec080e7          	jalr	2028(ra) # 800026a4 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000ec0:	00005097          	auipc	ra,0x5
    80000ec4:	d90080e7          	jalr	-624(ra) # 80005c50 <plicinithart>
  }

  scheduler();        
    80000ec8:	00001097          	auipc	ra,0x1
    80000ecc:	fea080e7          	jalr	-22(ra) # 80001eb2 <scheduler>
    consoleinit();
    80000ed0:	fffff097          	auipc	ra,0xfffff
    80000ed4:	57a080e7          	jalr	1402(ra) # 8000044a <consoleinit>
    printfinit();
    80000ed8:	00000097          	auipc	ra,0x0
    80000edc:	88c080e7          	jalr	-1908(ra) # 80000764 <printfinit>
    printf("\n");
    80000ee0:	00007517          	auipc	a0,0x7
    80000ee4:	1e850513          	addi	a0,a0,488 # 800080c8 <digits+0x88>
    80000ee8:	fffff097          	auipc	ra,0xfffff
    80000eec:	69c080e7          	jalr	1692(ra) # 80000584 <printf>
    printf("xv6 kernel is booting\n");
    80000ef0:	00007517          	auipc	a0,0x7
    80000ef4:	1b050513          	addi	a0,a0,432 # 800080a0 <digits+0x60>
    80000ef8:	fffff097          	auipc	ra,0xfffff
    80000efc:	68c080e7          	jalr	1676(ra) # 80000584 <printf>
    printf("\n");
    80000f00:	00007517          	auipc	a0,0x7
    80000f04:	1c850513          	addi	a0,a0,456 # 800080c8 <digits+0x88>
    80000f08:	fffff097          	auipc	ra,0xfffff
    80000f0c:	67c080e7          	jalr	1660(ra) # 80000584 <printf>
    kinit();         // physical page allocator
    80000f10:	00000097          	auipc	ra,0x0
    80000f14:	b94080e7          	jalr	-1132(ra) # 80000aa4 <kinit>
    kvminit();       // create kernel page table
    80000f18:	00000097          	auipc	ra,0x0
    80000f1c:	322080e7          	jalr	802(ra) # 8000123a <kvminit>
    kvminithart();   // turn on paging
    80000f20:	00000097          	auipc	ra,0x0
    80000f24:	068080e7          	jalr	104(ra) # 80000f88 <kvminithart>
    procinit();      // process table
    80000f28:	00001097          	auipc	ra,0x1
    80000f2c:	992080e7          	jalr	-1646(ra) # 800018ba <procinit>
    trapinit();      // trap vectors
    80000f30:	00001097          	auipc	ra,0x1
    80000f34:	74c080e7          	jalr	1868(ra) # 8000267c <trapinit>
    trapinithart();  // install kernel trap vector
    80000f38:	00001097          	auipc	ra,0x1
    80000f3c:	76c080e7          	jalr	1900(ra) # 800026a4 <trapinithart>
    plicinit();      // set up interrupt controller
    80000f40:	00005097          	auipc	ra,0x5
    80000f44:	cfa080e7          	jalr	-774(ra) # 80005c3a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000f48:	00005097          	auipc	ra,0x5
    80000f4c:	d08080e7          	jalr	-760(ra) # 80005c50 <plicinithart>
    binit();         // buffer cache
    80000f50:	00002097          	auipc	ra,0x2
    80000f54:	ece080e7          	jalr	-306(ra) # 80002e1e <binit>
    iinit();         // inode table
    80000f58:	00002097          	auipc	ra,0x2
    80000f5c:	55c080e7          	jalr	1372(ra) # 800034b4 <iinit>
    fileinit();      // file table
    80000f60:	00003097          	auipc	ra,0x3
    80000f64:	50e080e7          	jalr	1294(ra) # 8000446e <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000f68:	00005097          	auipc	ra,0x5
    80000f6c:	e08080e7          	jalr	-504(ra) # 80005d70 <virtio_disk_init>
    userinit();      // first user process
    80000f70:	00001097          	auipc	ra,0x1
    80000f74:	d08080e7          	jalr	-760(ra) # 80001c78 <userinit>
    __sync_synchronize();
    80000f78:	0ff0000f          	fence
    started = 1;
    80000f7c:	4785                	li	a5,1
    80000f7e:	00008717          	auipc	a4,0x8
    80000f82:	08f72d23          	sw	a5,154(a4) # 80009018 <started>
    80000f86:	b789                	j	80000ec8 <main+0x56>

0000000080000f88 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80000f88:	1141                	addi	sp,sp,-16
    80000f8a:	e422                	sd	s0,8(sp)
    80000f8c:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80000f8e:	00008797          	auipc	a5,0x8
    80000f92:	0927b783          	ld	a5,146(a5) # 80009020 <kernel_pagetable>
    80000f96:	83b1                	srli	a5,a5,0xc
    80000f98:	577d                	li	a4,-1
    80000f9a:	177e                	slli	a4,a4,0x3f
    80000f9c:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80000f9e:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000fa2:	12000073          	sfence.vma
  sfence_vma();
}
    80000fa6:	6422                	ld	s0,8(sp)
    80000fa8:	0141                	addi	sp,sp,16
    80000faa:	8082                	ret

0000000080000fac <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000fac:	7139                	addi	sp,sp,-64
    80000fae:	fc06                	sd	ra,56(sp)
    80000fb0:	f822                	sd	s0,48(sp)
    80000fb2:	f426                	sd	s1,40(sp)
    80000fb4:	f04a                	sd	s2,32(sp)
    80000fb6:	ec4e                	sd	s3,24(sp)
    80000fb8:	e852                	sd	s4,16(sp)
    80000fba:	e456                	sd	s5,8(sp)
    80000fbc:	e05a                	sd	s6,0(sp)
    80000fbe:	0080                	addi	s0,sp,64
    80000fc0:	84aa                	mv	s1,a0
    80000fc2:	89ae                	mv	s3,a1
    80000fc4:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80000fc6:	57fd                	li	a5,-1
    80000fc8:	83e9                	srli	a5,a5,0x1a
    80000fca:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000fcc:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000fce:	04b7f263          	bgeu	a5,a1,80001012 <walk+0x66>
    panic("walk");
    80000fd2:	00007517          	auipc	a0,0x7
    80000fd6:	0fe50513          	addi	a0,a0,254 # 800080d0 <digits+0x90>
    80000fda:	fffff097          	auipc	ra,0xfffff
    80000fde:	560080e7          	jalr	1376(ra) # 8000053a <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000fe2:	060a8663          	beqz	s5,8000104e <walk+0xa2>
    80000fe6:	00000097          	auipc	ra,0x0
    80000fea:	afa080e7          	jalr	-1286(ra) # 80000ae0 <kalloc>
    80000fee:	84aa                	mv	s1,a0
    80000ff0:	c529                	beqz	a0,8000103a <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    80000ff2:	6605                	lui	a2,0x1
    80000ff4:	4581                	li	a1,0
    80000ff6:	00000097          	auipc	ra,0x0
    80000ffa:	cd6080e7          	jalr	-810(ra) # 80000ccc <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80000ffe:	00c4d793          	srli	a5,s1,0xc
    80001002:	07aa                	slli	a5,a5,0xa
    80001004:	0017e793          	ori	a5,a5,1
    80001008:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    8000100c:	3a5d                	addiw	s4,s4,-9
    8000100e:	036a0063          	beq	s4,s6,8000102e <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    80001012:	0149d933          	srl	s2,s3,s4
    80001016:	1ff97913          	andi	s2,s2,511
    8000101a:	090e                	slli	s2,s2,0x3
    8000101c:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    8000101e:	00093483          	ld	s1,0(s2)
    80001022:	0014f793          	andi	a5,s1,1
    80001026:	dfd5                	beqz	a5,80000fe2 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80001028:	80a9                	srli	s1,s1,0xa
    8000102a:	04b2                	slli	s1,s1,0xc
    8000102c:	b7c5                	j	8000100c <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    8000102e:	00c9d513          	srli	a0,s3,0xc
    80001032:	1ff57513          	andi	a0,a0,511
    80001036:	050e                	slli	a0,a0,0x3
    80001038:	9526                	add	a0,a0,s1
}
    8000103a:	70e2                	ld	ra,56(sp)
    8000103c:	7442                	ld	s0,48(sp)
    8000103e:	74a2                	ld	s1,40(sp)
    80001040:	7902                	ld	s2,32(sp)
    80001042:	69e2                	ld	s3,24(sp)
    80001044:	6a42                	ld	s4,16(sp)
    80001046:	6aa2                	ld	s5,8(sp)
    80001048:	6b02                	ld	s6,0(sp)
    8000104a:	6121                	addi	sp,sp,64
    8000104c:	8082                	ret
        return 0;
    8000104e:	4501                	li	a0,0
    80001050:	b7ed                	j	8000103a <walk+0x8e>

0000000080001052 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80001052:	57fd                	li	a5,-1
    80001054:	83e9                	srli	a5,a5,0x1a
    80001056:	00b7f463          	bgeu	a5,a1,8000105e <walkaddr+0xc>
    return 0;
    8000105a:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    8000105c:	8082                	ret
{
    8000105e:	1141                	addi	sp,sp,-16
    80001060:	e406                	sd	ra,8(sp)
    80001062:	e022                	sd	s0,0(sp)
    80001064:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80001066:	4601                	li	a2,0
    80001068:	00000097          	auipc	ra,0x0
    8000106c:	f44080e7          	jalr	-188(ra) # 80000fac <walk>
  if(pte == 0)
    80001070:	c105                	beqz	a0,80001090 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80001072:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80001074:	0117f693          	andi	a3,a5,17
    80001078:	4745                	li	a4,17
    return 0;
    8000107a:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    8000107c:	00e68663          	beq	a3,a4,80001088 <walkaddr+0x36>
}
    80001080:	60a2                	ld	ra,8(sp)
    80001082:	6402                	ld	s0,0(sp)
    80001084:	0141                	addi	sp,sp,16
    80001086:	8082                	ret
  pa = PTE2PA(*pte);
    80001088:	83a9                	srli	a5,a5,0xa
    8000108a:	00c79513          	slli	a0,a5,0xc
  return pa;
    8000108e:	bfcd                	j	80001080 <walkaddr+0x2e>
    return 0;
    80001090:	4501                	li	a0,0
    80001092:	b7fd                	j	80001080 <walkaddr+0x2e>

0000000080001094 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80001094:	715d                	addi	sp,sp,-80
    80001096:	e486                	sd	ra,72(sp)
    80001098:	e0a2                	sd	s0,64(sp)
    8000109a:	fc26                	sd	s1,56(sp)
    8000109c:	f84a                	sd	s2,48(sp)
    8000109e:	f44e                	sd	s3,40(sp)
    800010a0:	f052                	sd	s4,32(sp)
    800010a2:	ec56                	sd	s5,24(sp)
    800010a4:	e85a                	sd	s6,16(sp)
    800010a6:	e45e                	sd	s7,8(sp)
    800010a8:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    800010aa:	c639                	beqz	a2,800010f8 <mappages+0x64>
    800010ac:	8aaa                	mv	s5,a0
    800010ae:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    800010b0:	777d                	lui	a4,0xfffff
    800010b2:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    800010b6:	fff58993          	addi	s3,a1,-1
    800010ba:	99b2                	add	s3,s3,a2
    800010bc:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    800010c0:	893e                	mv	s2,a5
    800010c2:	40f68a33          	sub	s4,a3,a5
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800010c6:	6b85                	lui	s7,0x1
    800010c8:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    800010cc:	4605                	li	a2,1
    800010ce:	85ca                	mv	a1,s2
    800010d0:	8556                	mv	a0,s5
    800010d2:	00000097          	auipc	ra,0x0
    800010d6:	eda080e7          	jalr	-294(ra) # 80000fac <walk>
    800010da:	cd1d                	beqz	a0,80001118 <mappages+0x84>
    if(*pte & PTE_V)
    800010dc:	611c                	ld	a5,0(a0)
    800010de:	8b85                	andi	a5,a5,1
    800010e0:	e785                	bnez	a5,80001108 <mappages+0x74>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800010e2:	80b1                	srli	s1,s1,0xc
    800010e4:	04aa                	slli	s1,s1,0xa
    800010e6:	0164e4b3          	or	s1,s1,s6
    800010ea:	0014e493          	ori	s1,s1,1
    800010ee:	e104                	sd	s1,0(a0)
    if(a == last)
    800010f0:	05390063          	beq	s2,s3,80001130 <mappages+0x9c>
    a += PGSIZE;
    800010f4:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800010f6:	bfc9                	j	800010c8 <mappages+0x34>
    panic("mappages: size");
    800010f8:	00007517          	auipc	a0,0x7
    800010fc:	fe050513          	addi	a0,a0,-32 # 800080d8 <digits+0x98>
    80001100:	fffff097          	auipc	ra,0xfffff
    80001104:	43a080e7          	jalr	1082(ra) # 8000053a <panic>
      panic("mappages: remap");
    80001108:	00007517          	auipc	a0,0x7
    8000110c:	fe050513          	addi	a0,a0,-32 # 800080e8 <digits+0xa8>
    80001110:	fffff097          	auipc	ra,0xfffff
    80001114:	42a080e7          	jalr	1066(ra) # 8000053a <panic>
      return -1;
    80001118:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    8000111a:	60a6                	ld	ra,72(sp)
    8000111c:	6406                	ld	s0,64(sp)
    8000111e:	74e2                	ld	s1,56(sp)
    80001120:	7942                	ld	s2,48(sp)
    80001122:	79a2                	ld	s3,40(sp)
    80001124:	7a02                	ld	s4,32(sp)
    80001126:	6ae2                	ld	s5,24(sp)
    80001128:	6b42                	ld	s6,16(sp)
    8000112a:	6ba2                	ld	s7,8(sp)
    8000112c:	6161                	addi	sp,sp,80
    8000112e:	8082                	ret
  return 0;
    80001130:	4501                	li	a0,0
    80001132:	b7e5                	j	8000111a <mappages+0x86>

0000000080001134 <kvmmap>:
{
    80001134:	1141                	addi	sp,sp,-16
    80001136:	e406                	sd	ra,8(sp)
    80001138:	e022                	sd	s0,0(sp)
    8000113a:	0800                	addi	s0,sp,16
    8000113c:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    8000113e:	86b2                	mv	a3,a2
    80001140:	863e                	mv	a2,a5
    80001142:	00000097          	auipc	ra,0x0
    80001146:	f52080e7          	jalr	-174(ra) # 80001094 <mappages>
    8000114a:	e509                	bnez	a0,80001154 <kvmmap+0x20>
}
    8000114c:	60a2                	ld	ra,8(sp)
    8000114e:	6402                	ld	s0,0(sp)
    80001150:	0141                	addi	sp,sp,16
    80001152:	8082                	ret
    panic("kvmmap");
    80001154:	00007517          	auipc	a0,0x7
    80001158:	fa450513          	addi	a0,a0,-92 # 800080f8 <digits+0xb8>
    8000115c:	fffff097          	auipc	ra,0xfffff
    80001160:	3de080e7          	jalr	990(ra) # 8000053a <panic>

0000000080001164 <kvmmake>:
{
    80001164:	1101                	addi	sp,sp,-32
    80001166:	ec06                	sd	ra,24(sp)
    80001168:	e822                	sd	s0,16(sp)
    8000116a:	e426                	sd	s1,8(sp)
    8000116c:	e04a                	sd	s2,0(sp)
    8000116e:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80001170:	00000097          	auipc	ra,0x0
    80001174:	970080e7          	jalr	-1680(ra) # 80000ae0 <kalloc>
    80001178:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    8000117a:	6605                	lui	a2,0x1
    8000117c:	4581                	li	a1,0
    8000117e:	00000097          	auipc	ra,0x0
    80001182:	b4e080e7          	jalr	-1202(ra) # 80000ccc <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80001186:	4719                	li	a4,6
    80001188:	6685                	lui	a3,0x1
    8000118a:	10000637          	lui	a2,0x10000
    8000118e:	100005b7          	lui	a1,0x10000
    80001192:	8526                	mv	a0,s1
    80001194:	00000097          	auipc	ra,0x0
    80001198:	fa0080e7          	jalr	-96(ra) # 80001134 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000119c:	4719                	li	a4,6
    8000119e:	6685                	lui	a3,0x1
    800011a0:	10001637          	lui	a2,0x10001
    800011a4:	100015b7          	lui	a1,0x10001
    800011a8:	8526                	mv	a0,s1
    800011aa:	00000097          	auipc	ra,0x0
    800011ae:	f8a080e7          	jalr	-118(ra) # 80001134 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800011b2:	4719                	li	a4,6
    800011b4:	004006b7          	lui	a3,0x400
    800011b8:	0c000637          	lui	a2,0xc000
    800011bc:	0c0005b7          	lui	a1,0xc000
    800011c0:	8526                	mv	a0,s1
    800011c2:	00000097          	auipc	ra,0x0
    800011c6:	f72080e7          	jalr	-142(ra) # 80001134 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800011ca:	00007917          	auipc	s2,0x7
    800011ce:	e3690913          	addi	s2,s2,-458 # 80008000 <etext>
    800011d2:	4729                	li	a4,10
    800011d4:	80007697          	auipc	a3,0x80007
    800011d8:	e2c68693          	addi	a3,a3,-468 # 8000 <_entry-0x7fff8000>
    800011dc:	4605                	li	a2,1
    800011de:	067e                	slli	a2,a2,0x1f
    800011e0:	85b2                	mv	a1,a2
    800011e2:	8526                	mv	a0,s1
    800011e4:	00000097          	auipc	ra,0x0
    800011e8:	f50080e7          	jalr	-176(ra) # 80001134 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800011ec:	4719                	li	a4,6
    800011ee:	46c5                	li	a3,17
    800011f0:	06ee                	slli	a3,a3,0x1b
    800011f2:	412686b3          	sub	a3,a3,s2
    800011f6:	864a                	mv	a2,s2
    800011f8:	85ca                	mv	a1,s2
    800011fa:	8526                	mv	a0,s1
    800011fc:	00000097          	auipc	ra,0x0
    80001200:	f38080e7          	jalr	-200(ra) # 80001134 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80001204:	4729                	li	a4,10
    80001206:	6685                	lui	a3,0x1
    80001208:	00006617          	auipc	a2,0x6
    8000120c:	df860613          	addi	a2,a2,-520 # 80007000 <_trampoline>
    80001210:	040005b7          	lui	a1,0x4000
    80001214:	15fd                	addi	a1,a1,-1
    80001216:	05b2                	slli	a1,a1,0xc
    80001218:	8526                	mv	a0,s1
    8000121a:	00000097          	auipc	ra,0x0
    8000121e:	f1a080e7          	jalr	-230(ra) # 80001134 <kvmmap>
  proc_mapstacks(kpgtbl);
    80001222:	8526                	mv	a0,s1
    80001224:	00000097          	auipc	ra,0x0
    80001228:	600080e7          	jalr	1536(ra) # 80001824 <proc_mapstacks>
}
    8000122c:	8526                	mv	a0,s1
    8000122e:	60e2                	ld	ra,24(sp)
    80001230:	6442                	ld	s0,16(sp)
    80001232:	64a2                	ld	s1,8(sp)
    80001234:	6902                	ld	s2,0(sp)
    80001236:	6105                	addi	sp,sp,32
    80001238:	8082                	ret

000000008000123a <kvminit>:
{
    8000123a:	1141                	addi	sp,sp,-16
    8000123c:	e406                	sd	ra,8(sp)
    8000123e:	e022                	sd	s0,0(sp)
    80001240:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80001242:	00000097          	auipc	ra,0x0
    80001246:	f22080e7          	jalr	-222(ra) # 80001164 <kvmmake>
    8000124a:	00008797          	auipc	a5,0x8
    8000124e:	dca7bb23          	sd	a0,-554(a5) # 80009020 <kernel_pagetable>
}
    80001252:	60a2                	ld	ra,8(sp)
    80001254:	6402                	ld	s0,0(sp)
    80001256:	0141                	addi	sp,sp,16
    80001258:	8082                	ret

000000008000125a <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    8000125a:	715d                	addi	sp,sp,-80
    8000125c:	e486                	sd	ra,72(sp)
    8000125e:	e0a2                	sd	s0,64(sp)
    80001260:	fc26                	sd	s1,56(sp)
    80001262:	f84a                	sd	s2,48(sp)
    80001264:	f44e                	sd	s3,40(sp)
    80001266:	f052                	sd	s4,32(sp)
    80001268:	ec56                	sd	s5,24(sp)
    8000126a:	e85a                	sd	s6,16(sp)
    8000126c:	e45e                	sd	s7,8(sp)
    8000126e:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80001270:	03459793          	slli	a5,a1,0x34
    80001274:	e795                	bnez	a5,800012a0 <uvmunmap+0x46>
    80001276:	8a2a                	mv	s4,a0
    80001278:	892e                	mv	s2,a1
    8000127a:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000127c:	0632                	slli	a2,a2,0xc
    8000127e:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80001282:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001284:	6b05                	lui	s6,0x1
    80001286:	0735e263          	bltu	a1,s3,800012ea <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    8000128a:	60a6                	ld	ra,72(sp)
    8000128c:	6406                	ld	s0,64(sp)
    8000128e:	74e2                	ld	s1,56(sp)
    80001290:	7942                	ld	s2,48(sp)
    80001292:	79a2                	ld	s3,40(sp)
    80001294:	7a02                	ld	s4,32(sp)
    80001296:	6ae2                	ld	s5,24(sp)
    80001298:	6b42                	ld	s6,16(sp)
    8000129a:	6ba2                	ld	s7,8(sp)
    8000129c:	6161                	addi	sp,sp,80
    8000129e:	8082                	ret
    panic("uvmunmap: not aligned");
    800012a0:	00007517          	auipc	a0,0x7
    800012a4:	e6050513          	addi	a0,a0,-416 # 80008100 <digits+0xc0>
    800012a8:	fffff097          	auipc	ra,0xfffff
    800012ac:	292080e7          	jalr	658(ra) # 8000053a <panic>
      panic("uvmunmap: walk");
    800012b0:	00007517          	auipc	a0,0x7
    800012b4:	e6850513          	addi	a0,a0,-408 # 80008118 <digits+0xd8>
    800012b8:	fffff097          	auipc	ra,0xfffff
    800012bc:	282080e7          	jalr	642(ra) # 8000053a <panic>
      panic("uvmunmap: not mapped");
    800012c0:	00007517          	auipc	a0,0x7
    800012c4:	e6850513          	addi	a0,a0,-408 # 80008128 <digits+0xe8>
    800012c8:	fffff097          	auipc	ra,0xfffff
    800012cc:	272080e7          	jalr	626(ra) # 8000053a <panic>
      panic("uvmunmap: not a leaf");
    800012d0:	00007517          	auipc	a0,0x7
    800012d4:	e7050513          	addi	a0,a0,-400 # 80008140 <digits+0x100>
    800012d8:	fffff097          	auipc	ra,0xfffff
    800012dc:	262080e7          	jalr	610(ra) # 8000053a <panic>
    *pte = 0;
    800012e0:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800012e4:	995a                	add	s2,s2,s6
    800012e6:	fb3972e3          	bgeu	s2,s3,8000128a <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    800012ea:	4601                	li	a2,0
    800012ec:	85ca                	mv	a1,s2
    800012ee:	8552                	mv	a0,s4
    800012f0:	00000097          	auipc	ra,0x0
    800012f4:	cbc080e7          	jalr	-836(ra) # 80000fac <walk>
    800012f8:	84aa                	mv	s1,a0
    800012fa:	d95d                	beqz	a0,800012b0 <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    800012fc:	6108                	ld	a0,0(a0)
    800012fe:	00157793          	andi	a5,a0,1
    80001302:	dfdd                	beqz	a5,800012c0 <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    80001304:	3ff57793          	andi	a5,a0,1023
    80001308:	fd7784e3          	beq	a5,s7,800012d0 <uvmunmap+0x76>
    if(do_free){
    8000130c:	fc0a8ae3          	beqz	s5,800012e0 <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    80001310:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    80001312:	0532                	slli	a0,a0,0xc
    80001314:	fffff097          	auipc	ra,0xfffff
    80001318:	6ce080e7          	jalr	1742(ra) # 800009e2 <kfree>
    8000131c:	b7d1                	j	800012e0 <uvmunmap+0x86>

000000008000131e <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    8000131e:	1101                	addi	sp,sp,-32
    80001320:	ec06                	sd	ra,24(sp)
    80001322:	e822                	sd	s0,16(sp)
    80001324:	e426                	sd	s1,8(sp)
    80001326:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80001328:	fffff097          	auipc	ra,0xfffff
    8000132c:	7b8080e7          	jalr	1976(ra) # 80000ae0 <kalloc>
    80001330:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001332:	c519                	beqz	a0,80001340 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    80001334:	6605                	lui	a2,0x1
    80001336:	4581                	li	a1,0
    80001338:	00000097          	auipc	ra,0x0
    8000133c:	994080e7          	jalr	-1644(ra) # 80000ccc <memset>
  return pagetable;
}
    80001340:	8526                	mv	a0,s1
    80001342:	60e2                	ld	ra,24(sp)
    80001344:	6442                	ld	s0,16(sp)
    80001346:	64a2                	ld	s1,8(sp)
    80001348:	6105                	addi	sp,sp,32
    8000134a:	8082                	ret

000000008000134c <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    8000134c:	7179                	addi	sp,sp,-48
    8000134e:	f406                	sd	ra,40(sp)
    80001350:	f022                	sd	s0,32(sp)
    80001352:	ec26                	sd	s1,24(sp)
    80001354:	e84a                	sd	s2,16(sp)
    80001356:	e44e                	sd	s3,8(sp)
    80001358:	e052                	sd	s4,0(sp)
    8000135a:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    8000135c:	6785                	lui	a5,0x1
    8000135e:	04f67863          	bgeu	a2,a5,800013ae <uvminit+0x62>
    80001362:	8a2a                	mv	s4,a0
    80001364:	89ae                	mv	s3,a1
    80001366:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    80001368:	fffff097          	auipc	ra,0xfffff
    8000136c:	778080e7          	jalr	1912(ra) # 80000ae0 <kalloc>
    80001370:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80001372:	6605                	lui	a2,0x1
    80001374:	4581                	li	a1,0
    80001376:	00000097          	auipc	ra,0x0
    8000137a:	956080e7          	jalr	-1706(ra) # 80000ccc <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    8000137e:	4779                	li	a4,30
    80001380:	86ca                	mv	a3,s2
    80001382:	6605                	lui	a2,0x1
    80001384:	4581                	li	a1,0
    80001386:	8552                	mv	a0,s4
    80001388:	00000097          	auipc	ra,0x0
    8000138c:	d0c080e7          	jalr	-756(ra) # 80001094 <mappages>
  memmove(mem, src, sz);
    80001390:	8626                	mv	a2,s1
    80001392:	85ce                	mv	a1,s3
    80001394:	854a                	mv	a0,s2
    80001396:	00000097          	auipc	ra,0x0
    8000139a:	992080e7          	jalr	-1646(ra) # 80000d28 <memmove>
}
    8000139e:	70a2                	ld	ra,40(sp)
    800013a0:	7402                	ld	s0,32(sp)
    800013a2:	64e2                	ld	s1,24(sp)
    800013a4:	6942                	ld	s2,16(sp)
    800013a6:	69a2                	ld	s3,8(sp)
    800013a8:	6a02                	ld	s4,0(sp)
    800013aa:	6145                	addi	sp,sp,48
    800013ac:	8082                	ret
    panic("inituvm: more than a page");
    800013ae:	00007517          	auipc	a0,0x7
    800013b2:	daa50513          	addi	a0,a0,-598 # 80008158 <digits+0x118>
    800013b6:	fffff097          	auipc	ra,0xfffff
    800013ba:	184080e7          	jalr	388(ra) # 8000053a <panic>

00000000800013be <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    800013be:	1101                	addi	sp,sp,-32
    800013c0:	ec06                	sd	ra,24(sp)
    800013c2:	e822                	sd	s0,16(sp)
    800013c4:	e426                	sd	s1,8(sp)
    800013c6:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    800013c8:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800013ca:	00b67d63          	bgeu	a2,a1,800013e4 <uvmdealloc+0x26>
    800013ce:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800013d0:	6785                	lui	a5,0x1
    800013d2:	17fd                	addi	a5,a5,-1
    800013d4:	00f60733          	add	a4,a2,a5
    800013d8:	76fd                	lui	a3,0xfffff
    800013da:	8f75                	and	a4,a4,a3
    800013dc:	97ae                	add	a5,a5,a1
    800013de:	8ff5                	and	a5,a5,a3
    800013e0:	00f76863          	bltu	a4,a5,800013f0 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800013e4:	8526                	mv	a0,s1
    800013e6:	60e2                	ld	ra,24(sp)
    800013e8:	6442                	ld	s0,16(sp)
    800013ea:	64a2                	ld	s1,8(sp)
    800013ec:	6105                	addi	sp,sp,32
    800013ee:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800013f0:	8f99                	sub	a5,a5,a4
    800013f2:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800013f4:	4685                	li	a3,1
    800013f6:	0007861b          	sext.w	a2,a5
    800013fa:	85ba                	mv	a1,a4
    800013fc:	00000097          	auipc	ra,0x0
    80001400:	e5e080e7          	jalr	-418(ra) # 8000125a <uvmunmap>
    80001404:	b7c5                	j	800013e4 <uvmdealloc+0x26>

0000000080001406 <uvmalloc>:
  if(newsz < oldsz)
    80001406:	0ab66163          	bltu	a2,a1,800014a8 <uvmalloc+0xa2>
{
    8000140a:	7139                	addi	sp,sp,-64
    8000140c:	fc06                	sd	ra,56(sp)
    8000140e:	f822                	sd	s0,48(sp)
    80001410:	f426                	sd	s1,40(sp)
    80001412:	f04a                	sd	s2,32(sp)
    80001414:	ec4e                	sd	s3,24(sp)
    80001416:	e852                	sd	s4,16(sp)
    80001418:	e456                	sd	s5,8(sp)
    8000141a:	0080                	addi	s0,sp,64
    8000141c:	8aaa                	mv	s5,a0
    8000141e:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    80001420:	6785                	lui	a5,0x1
    80001422:	17fd                	addi	a5,a5,-1
    80001424:	95be                	add	a1,a1,a5
    80001426:	77fd                	lui	a5,0xfffff
    80001428:	00f5f9b3          	and	s3,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000142c:	08c9f063          	bgeu	s3,a2,800014ac <uvmalloc+0xa6>
    80001430:	894e                	mv	s2,s3
    mem = kalloc();
    80001432:	fffff097          	auipc	ra,0xfffff
    80001436:	6ae080e7          	jalr	1710(ra) # 80000ae0 <kalloc>
    8000143a:	84aa                	mv	s1,a0
    if(mem == 0){
    8000143c:	c51d                	beqz	a0,8000146a <uvmalloc+0x64>
    memset(mem, 0, PGSIZE);
    8000143e:	6605                	lui	a2,0x1
    80001440:	4581                	li	a1,0
    80001442:	00000097          	auipc	ra,0x0
    80001446:	88a080e7          	jalr	-1910(ra) # 80000ccc <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    8000144a:	4779                	li	a4,30
    8000144c:	86a6                	mv	a3,s1
    8000144e:	6605                	lui	a2,0x1
    80001450:	85ca                	mv	a1,s2
    80001452:	8556                	mv	a0,s5
    80001454:	00000097          	auipc	ra,0x0
    80001458:	c40080e7          	jalr	-960(ra) # 80001094 <mappages>
    8000145c:	e905                	bnez	a0,8000148c <uvmalloc+0x86>
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000145e:	6785                	lui	a5,0x1
    80001460:	993e                	add	s2,s2,a5
    80001462:	fd4968e3          	bltu	s2,s4,80001432 <uvmalloc+0x2c>
  return newsz;
    80001466:	8552                	mv	a0,s4
    80001468:	a809                	j	8000147a <uvmalloc+0x74>
      uvmdealloc(pagetable, a, oldsz);
    8000146a:	864e                	mv	a2,s3
    8000146c:	85ca                	mv	a1,s2
    8000146e:	8556                	mv	a0,s5
    80001470:	00000097          	auipc	ra,0x0
    80001474:	f4e080e7          	jalr	-178(ra) # 800013be <uvmdealloc>
      return 0;
    80001478:	4501                	li	a0,0
}
    8000147a:	70e2                	ld	ra,56(sp)
    8000147c:	7442                	ld	s0,48(sp)
    8000147e:	74a2                	ld	s1,40(sp)
    80001480:	7902                	ld	s2,32(sp)
    80001482:	69e2                	ld	s3,24(sp)
    80001484:	6a42                	ld	s4,16(sp)
    80001486:	6aa2                	ld	s5,8(sp)
    80001488:	6121                	addi	sp,sp,64
    8000148a:	8082                	ret
      kfree(mem);
    8000148c:	8526                	mv	a0,s1
    8000148e:	fffff097          	auipc	ra,0xfffff
    80001492:	554080e7          	jalr	1364(ra) # 800009e2 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80001496:	864e                	mv	a2,s3
    80001498:	85ca                	mv	a1,s2
    8000149a:	8556                	mv	a0,s5
    8000149c:	00000097          	auipc	ra,0x0
    800014a0:	f22080e7          	jalr	-222(ra) # 800013be <uvmdealloc>
      return 0;
    800014a4:	4501                	li	a0,0
    800014a6:	bfd1                	j	8000147a <uvmalloc+0x74>
    return oldsz;
    800014a8:	852e                	mv	a0,a1
}
    800014aa:	8082                	ret
  return newsz;
    800014ac:	8532                	mv	a0,a2
    800014ae:	b7f1                	j	8000147a <uvmalloc+0x74>

00000000800014b0 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800014b0:	7179                	addi	sp,sp,-48
    800014b2:	f406                	sd	ra,40(sp)
    800014b4:	f022                	sd	s0,32(sp)
    800014b6:	ec26                	sd	s1,24(sp)
    800014b8:	e84a                	sd	s2,16(sp)
    800014ba:	e44e                	sd	s3,8(sp)
    800014bc:	e052                	sd	s4,0(sp)
    800014be:	1800                	addi	s0,sp,48
    800014c0:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800014c2:	84aa                	mv	s1,a0
    800014c4:	6905                	lui	s2,0x1
    800014c6:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800014c8:	4985                	li	s3,1
    800014ca:	a829                	j	800014e4 <freewalk+0x34>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800014cc:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    800014ce:	00c79513          	slli	a0,a5,0xc
    800014d2:	00000097          	auipc	ra,0x0
    800014d6:	fde080e7          	jalr	-34(ra) # 800014b0 <freewalk>
      pagetable[i] = 0;
    800014da:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    800014de:	04a1                	addi	s1,s1,8
    800014e0:	03248163          	beq	s1,s2,80001502 <freewalk+0x52>
    pte_t pte = pagetable[i];
    800014e4:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800014e6:	00f7f713          	andi	a4,a5,15
    800014ea:	ff3701e3          	beq	a4,s3,800014cc <freewalk+0x1c>
    } else if(pte & PTE_V){
    800014ee:	8b85                	andi	a5,a5,1
    800014f0:	d7fd                	beqz	a5,800014de <freewalk+0x2e>
      panic("freewalk: leaf");
    800014f2:	00007517          	auipc	a0,0x7
    800014f6:	c8650513          	addi	a0,a0,-890 # 80008178 <digits+0x138>
    800014fa:	fffff097          	auipc	ra,0xfffff
    800014fe:	040080e7          	jalr	64(ra) # 8000053a <panic>
    }
  }
  kfree((void*)pagetable);
    80001502:	8552                	mv	a0,s4
    80001504:	fffff097          	auipc	ra,0xfffff
    80001508:	4de080e7          	jalr	1246(ra) # 800009e2 <kfree>
}
    8000150c:	70a2                	ld	ra,40(sp)
    8000150e:	7402                	ld	s0,32(sp)
    80001510:	64e2                	ld	s1,24(sp)
    80001512:	6942                	ld	s2,16(sp)
    80001514:	69a2                	ld	s3,8(sp)
    80001516:	6a02                	ld	s4,0(sp)
    80001518:	6145                	addi	sp,sp,48
    8000151a:	8082                	ret

000000008000151c <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    8000151c:	1101                	addi	sp,sp,-32
    8000151e:	ec06                	sd	ra,24(sp)
    80001520:	e822                	sd	s0,16(sp)
    80001522:	e426                	sd	s1,8(sp)
    80001524:	1000                	addi	s0,sp,32
    80001526:	84aa                	mv	s1,a0
  if(sz > 0)
    80001528:	e999                	bnez	a1,8000153e <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    8000152a:	8526                	mv	a0,s1
    8000152c:	00000097          	auipc	ra,0x0
    80001530:	f84080e7          	jalr	-124(ra) # 800014b0 <freewalk>
}
    80001534:	60e2                	ld	ra,24(sp)
    80001536:	6442                	ld	s0,16(sp)
    80001538:	64a2                	ld	s1,8(sp)
    8000153a:	6105                	addi	sp,sp,32
    8000153c:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    8000153e:	6785                	lui	a5,0x1
    80001540:	17fd                	addi	a5,a5,-1
    80001542:	95be                	add	a1,a1,a5
    80001544:	4685                	li	a3,1
    80001546:	00c5d613          	srli	a2,a1,0xc
    8000154a:	4581                	li	a1,0
    8000154c:	00000097          	auipc	ra,0x0
    80001550:	d0e080e7          	jalr	-754(ra) # 8000125a <uvmunmap>
    80001554:	bfd9                	j	8000152a <uvmfree+0xe>

0000000080001556 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80001556:	c679                	beqz	a2,80001624 <uvmcopy+0xce>
{
    80001558:	715d                	addi	sp,sp,-80
    8000155a:	e486                	sd	ra,72(sp)
    8000155c:	e0a2                	sd	s0,64(sp)
    8000155e:	fc26                	sd	s1,56(sp)
    80001560:	f84a                	sd	s2,48(sp)
    80001562:	f44e                	sd	s3,40(sp)
    80001564:	f052                	sd	s4,32(sp)
    80001566:	ec56                	sd	s5,24(sp)
    80001568:	e85a                	sd	s6,16(sp)
    8000156a:	e45e                	sd	s7,8(sp)
    8000156c:	0880                	addi	s0,sp,80
    8000156e:	8b2a                	mv	s6,a0
    80001570:	8aae                	mv	s5,a1
    80001572:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80001574:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80001576:	4601                	li	a2,0
    80001578:	85ce                	mv	a1,s3
    8000157a:	855a                	mv	a0,s6
    8000157c:	00000097          	auipc	ra,0x0
    80001580:	a30080e7          	jalr	-1488(ra) # 80000fac <walk>
    80001584:	c531                	beqz	a0,800015d0 <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80001586:	6118                	ld	a4,0(a0)
    80001588:	00177793          	andi	a5,a4,1
    8000158c:	cbb1                	beqz	a5,800015e0 <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    8000158e:	00a75593          	srli	a1,a4,0xa
    80001592:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80001596:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    8000159a:	fffff097          	auipc	ra,0xfffff
    8000159e:	546080e7          	jalr	1350(ra) # 80000ae0 <kalloc>
    800015a2:	892a                	mv	s2,a0
    800015a4:	c939                	beqz	a0,800015fa <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    800015a6:	6605                	lui	a2,0x1
    800015a8:	85de                	mv	a1,s7
    800015aa:	fffff097          	auipc	ra,0xfffff
    800015ae:	77e080e7          	jalr	1918(ra) # 80000d28 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    800015b2:	8726                	mv	a4,s1
    800015b4:	86ca                	mv	a3,s2
    800015b6:	6605                	lui	a2,0x1
    800015b8:	85ce                	mv	a1,s3
    800015ba:	8556                	mv	a0,s5
    800015bc:	00000097          	auipc	ra,0x0
    800015c0:	ad8080e7          	jalr	-1320(ra) # 80001094 <mappages>
    800015c4:	e515                	bnez	a0,800015f0 <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    800015c6:	6785                	lui	a5,0x1
    800015c8:	99be                	add	s3,s3,a5
    800015ca:	fb49e6e3          	bltu	s3,s4,80001576 <uvmcopy+0x20>
    800015ce:	a081                	j	8000160e <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    800015d0:	00007517          	auipc	a0,0x7
    800015d4:	bb850513          	addi	a0,a0,-1096 # 80008188 <digits+0x148>
    800015d8:	fffff097          	auipc	ra,0xfffff
    800015dc:	f62080e7          	jalr	-158(ra) # 8000053a <panic>
      panic("uvmcopy: page not present");
    800015e0:	00007517          	auipc	a0,0x7
    800015e4:	bc850513          	addi	a0,a0,-1080 # 800081a8 <digits+0x168>
    800015e8:	fffff097          	auipc	ra,0xfffff
    800015ec:	f52080e7          	jalr	-174(ra) # 8000053a <panic>
      kfree(mem);
    800015f0:	854a                	mv	a0,s2
    800015f2:	fffff097          	auipc	ra,0xfffff
    800015f6:	3f0080e7          	jalr	1008(ra) # 800009e2 <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    800015fa:	4685                	li	a3,1
    800015fc:	00c9d613          	srli	a2,s3,0xc
    80001600:	4581                	li	a1,0
    80001602:	8556                	mv	a0,s5
    80001604:	00000097          	auipc	ra,0x0
    80001608:	c56080e7          	jalr	-938(ra) # 8000125a <uvmunmap>
  return -1;
    8000160c:	557d                	li	a0,-1
}
    8000160e:	60a6                	ld	ra,72(sp)
    80001610:	6406                	ld	s0,64(sp)
    80001612:	74e2                	ld	s1,56(sp)
    80001614:	7942                	ld	s2,48(sp)
    80001616:	79a2                	ld	s3,40(sp)
    80001618:	7a02                	ld	s4,32(sp)
    8000161a:	6ae2                	ld	s5,24(sp)
    8000161c:	6b42                	ld	s6,16(sp)
    8000161e:	6ba2                	ld	s7,8(sp)
    80001620:	6161                	addi	sp,sp,80
    80001622:	8082                	ret
  return 0;
    80001624:	4501                	li	a0,0
}
    80001626:	8082                	ret

0000000080001628 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80001628:	1141                	addi	sp,sp,-16
    8000162a:	e406                	sd	ra,8(sp)
    8000162c:	e022                	sd	s0,0(sp)
    8000162e:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80001630:	4601                	li	a2,0
    80001632:	00000097          	auipc	ra,0x0
    80001636:	97a080e7          	jalr	-1670(ra) # 80000fac <walk>
  if(pte == 0)
    8000163a:	c901                	beqz	a0,8000164a <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    8000163c:	611c                	ld	a5,0(a0)
    8000163e:	9bbd                	andi	a5,a5,-17
    80001640:	e11c                	sd	a5,0(a0)
}
    80001642:	60a2                	ld	ra,8(sp)
    80001644:	6402                	ld	s0,0(sp)
    80001646:	0141                	addi	sp,sp,16
    80001648:	8082                	ret
    panic("uvmclear");
    8000164a:	00007517          	auipc	a0,0x7
    8000164e:	b7e50513          	addi	a0,a0,-1154 # 800081c8 <digits+0x188>
    80001652:	fffff097          	auipc	ra,0xfffff
    80001656:	ee8080e7          	jalr	-280(ra) # 8000053a <panic>

000000008000165a <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    8000165a:	c6bd                	beqz	a3,800016c8 <copyout+0x6e>
{
    8000165c:	715d                	addi	sp,sp,-80
    8000165e:	e486                	sd	ra,72(sp)
    80001660:	e0a2                	sd	s0,64(sp)
    80001662:	fc26                	sd	s1,56(sp)
    80001664:	f84a                	sd	s2,48(sp)
    80001666:	f44e                	sd	s3,40(sp)
    80001668:	f052                	sd	s4,32(sp)
    8000166a:	ec56                	sd	s5,24(sp)
    8000166c:	e85a                	sd	s6,16(sp)
    8000166e:	e45e                	sd	s7,8(sp)
    80001670:	e062                	sd	s8,0(sp)
    80001672:	0880                	addi	s0,sp,80
    80001674:	8b2a                	mv	s6,a0
    80001676:	8c2e                	mv	s8,a1
    80001678:	8a32                	mv	s4,a2
    8000167a:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    8000167c:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    8000167e:	6a85                	lui	s5,0x1
    80001680:	a015                	j	800016a4 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80001682:	9562                	add	a0,a0,s8
    80001684:	0004861b          	sext.w	a2,s1
    80001688:	85d2                	mv	a1,s4
    8000168a:	41250533          	sub	a0,a0,s2
    8000168e:	fffff097          	auipc	ra,0xfffff
    80001692:	69a080e7          	jalr	1690(ra) # 80000d28 <memmove>

    len -= n;
    80001696:	409989b3          	sub	s3,s3,s1
    src += n;
    8000169a:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    8000169c:	01590c33          	add	s8,s2,s5
  while(len > 0){
    800016a0:	02098263          	beqz	s3,800016c4 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    800016a4:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    800016a8:	85ca                	mv	a1,s2
    800016aa:	855a                	mv	a0,s6
    800016ac:	00000097          	auipc	ra,0x0
    800016b0:	9a6080e7          	jalr	-1626(ra) # 80001052 <walkaddr>
    if(pa0 == 0)
    800016b4:	cd01                	beqz	a0,800016cc <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    800016b6:	418904b3          	sub	s1,s2,s8
    800016ba:	94d6                	add	s1,s1,s5
    800016bc:	fc99f3e3          	bgeu	s3,s1,80001682 <copyout+0x28>
    800016c0:	84ce                	mv	s1,s3
    800016c2:	b7c1                	j	80001682 <copyout+0x28>
  }
  return 0;
    800016c4:	4501                	li	a0,0
    800016c6:	a021                	j	800016ce <copyout+0x74>
    800016c8:	4501                	li	a0,0
}
    800016ca:	8082                	ret
      return -1;
    800016cc:	557d                	li	a0,-1
}
    800016ce:	60a6                	ld	ra,72(sp)
    800016d0:	6406                	ld	s0,64(sp)
    800016d2:	74e2                	ld	s1,56(sp)
    800016d4:	7942                	ld	s2,48(sp)
    800016d6:	79a2                	ld	s3,40(sp)
    800016d8:	7a02                	ld	s4,32(sp)
    800016da:	6ae2                	ld	s5,24(sp)
    800016dc:	6b42                	ld	s6,16(sp)
    800016de:	6ba2                	ld	s7,8(sp)
    800016e0:	6c02                	ld	s8,0(sp)
    800016e2:	6161                	addi	sp,sp,80
    800016e4:	8082                	ret

00000000800016e6 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    800016e6:	caa5                	beqz	a3,80001756 <copyin+0x70>
{
    800016e8:	715d                	addi	sp,sp,-80
    800016ea:	e486                	sd	ra,72(sp)
    800016ec:	e0a2                	sd	s0,64(sp)
    800016ee:	fc26                	sd	s1,56(sp)
    800016f0:	f84a                	sd	s2,48(sp)
    800016f2:	f44e                	sd	s3,40(sp)
    800016f4:	f052                	sd	s4,32(sp)
    800016f6:	ec56                	sd	s5,24(sp)
    800016f8:	e85a                	sd	s6,16(sp)
    800016fa:	e45e                	sd	s7,8(sp)
    800016fc:	e062                	sd	s8,0(sp)
    800016fe:	0880                	addi	s0,sp,80
    80001700:	8b2a                	mv	s6,a0
    80001702:	8a2e                	mv	s4,a1
    80001704:	8c32                	mv	s8,a2
    80001706:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80001708:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    8000170a:	6a85                	lui	s5,0x1
    8000170c:	a01d                	j	80001732 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    8000170e:	018505b3          	add	a1,a0,s8
    80001712:	0004861b          	sext.w	a2,s1
    80001716:	412585b3          	sub	a1,a1,s2
    8000171a:	8552                	mv	a0,s4
    8000171c:	fffff097          	auipc	ra,0xfffff
    80001720:	60c080e7          	jalr	1548(ra) # 80000d28 <memmove>

    len -= n;
    80001724:	409989b3          	sub	s3,s3,s1
    dst += n;
    80001728:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    8000172a:	01590c33          	add	s8,s2,s5
  while(len > 0){
    8000172e:	02098263          	beqz	s3,80001752 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80001732:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80001736:	85ca                	mv	a1,s2
    80001738:	855a                	mv	a0,s6
    8000173a:	00000097          	auipc	ra,0x0
    8000173e:	918080e7          	jalr	-1768(ra) # 80001052 <walkaddr>
    if(pa0 == 0)
    80001742:	cd01                	beqz	a0,8000175a <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80001744:	418904b3          	sub	s1,s2,s8
    80001748:	94d6                	add	s1,s1,s5
    8000174a:	fc99f2e3          	bgeu	s3,s1,8000170e <copyin+0x28>
    8000174e:	84ce                	mv	s1,s3
    80001750:	bf7d                	j	8000170e <copyin+0x28>
  }
  return 0;
    80001752:	4501                	li	a0,0
    80001754:	a021                	j	8000175c <copyin+0x76>
    80001756:	4501                	li	a0,0
}
    80001758:	8082                	ret
      return -1;
    8000175a:	557d                	li	a0,-1
}
    8000175c:	60a6                	ld	ra,72(sp)
    8000175e:	6406                	ld	s0,64(sp)
    80001760:	74e2                	ld	s1,56(sp)
    80001762:	7942                	ld	s2,48(sp)
    80001764:	79a2                	ld	s3,40(sp)
    80001766:	7a02                	ld	s4,32(sp)
    80001768:	6ae2                	ld	s5,24(sp)
    8000176a:	6b42                	ld	s6,16(sp)
    8000176c:	6ba2                	ld	s7,8(sp)
    8000176e:	6c02                	ld	s8,0(sp)
    80001770:	6161                	addi	sp,sp,80
    80001772:	8082                	ret

0000000080001774 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80001774:	c2dd                	beqz	a3,8000181a <copyinstr+0xa6>
{
    80001776:	715d                	addi	sp,sp,-80
    80001778:	e486                	sd	ra,72(sp)
    8000177a:	e0a2                	sd	s0,64(sp)
    8000177c:	fc26                	sd	s1,56(sp)
    8000177e:	f84a                	sd	s2,48(sp)
    80001780:	f44e                	sd	s3,40(sp)
    80001782:	f052                	sd	s4,32(sp)
    80001784:	ec56                	sd	s5,24(sp)
    80001786:	e85a                	sd	s6,16(sp)
    80001788:	e45e                	sd	s7,8(sp)
    8000178a:	0880                	addi	s0,sp,80
    8000178c:	8a2a                	mv	s4,a0
    8000178e:	8b2e                	mv	s6,a1
    80001790:	8bb2                	mv	s7,a2
    80001792:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80001794:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80001796:	6985                	lui	s3,0x1
    80001798:	a02d                	j	800017c2 <copyinstr+0x4e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    8000179a:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    8000179e:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    800017a0:	37fd                	addiw	a5,a5,-1
    800017a2:	0007851b          	sext.w	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    800017a6:	60a6                	ld	ra,72(sp)
    800017a8:	6406                	ld	s0,64(sp)
    800017aa:	74e2                	ld	s1,56(sp)
    800017ac:	7942                	ld	s2,48(sp)
    800017ae:	79a2                	ld	s3,40(sp)
    800017b0:	7a02                	ld	s4,32(sp)
    800017b2:	6ae2                	ld	s5,24(sp)
    800017b4:	6b42                	ld	s6,16(sp)
    800017b6:	6ba2                	ld	s7,8(sp)
    800017b8:	6161                	addi	sp,sp,80
    800017ba:	8082                	ret
    srcva = va0 + PGSIZE;
    800017bc:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    800017c0:	c8a9                	beqz	s1,80001812 <copyinstr+0x9e>
    va0 = PGROUNDDOWN(srcva);
    800017c2:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    800017c6:	85ca                	mv	a1,s2
    800017c8:	8552                	mv	a0,s4
    800017ca:	00000097          	auipc	ra,0x0
    800017ce:	888080e7          	jalr	-1912(ra) # 80001052 <walkaddr>
    if(pa0 == 0)
    800017d2:	c131                	beqz	a0,80001816 <copyinstr+0xa2>
    n = PGSIZE - (srcva - va0);
    800017d4:	417906b3          	sub	a3,s2,s7
    800017d8:	96ce                	add	a3,a3,s3
    800017da:	00d4f363          	bgeu	s1,a3,800017e0 <copyinstr+0x6c>
    800017de:	86a6                	mv	a3,s1
    char *p = (char *) (pa0 + (srcva - va0));
    800017e0:	955e                	add	a0,a0,s7
    800017e2:	41250533          	sub	a0,a0,s2
    while(n > 0){
    800017e6:	daf9                	beqz	a3,800017bc <copyinstr+0x48>
    800017e8:	87da                	mv	a5,s6
      if(*p == '\0'){
    800017ea:	41650633          	sub	a2,a0,s6
    800017ee:	fff48593          	addi	a1,s1,-1
    800017f2:	95da                	add	a1,a1,s6
    while(n > 0){
    800017f4:	96da                	add	a3,a3,s6
      if(*p == '\0'){
    800017f6:	00f60733          	add	a4,a2,a5
    800017fa:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffd9000>
    800017fe:	df51                	beqz	a4,8000179a <copyinstr+0x26>
        *dst = *p;
    80001800:	00e78023          	sb	a4,0(a5)
      --max;
    80001804:	40f584b3          	sub	s1,a1,a5
      dst++;
    80001808:	0785                	addi	a5,a5,1
    while(n > 0){
    8000180a:	fed796e3          	bne	a5,a3,800017f6 <copyinstr+0x82>
      dst++;
    8000180e:	8b3e                	mv	s6,a5
    80001810:	b775                	j	800017bc <copyinstr+0x48>
    80001812:	4781                	li	a5,0
    80001814:	b771                	j	800017a0 <copyinstr+0x2c>
      return -1;
    80001816:	557d                	li	a0,-1
    80001818:	b779                	j	800017a6 <copyinstr+0x32>
  int got_null = 0;
    8000181a:	4781                	li	a5,0
  if(got_null){
    8000181c:	37fd                	addiw	a5,a5,-1
    8000181e:	0007851b          	sext.w	a0,a5
}
    80001822:	8082                	ret

0000000080001824 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80001824:	7139                	addi	sp,sp,-64
    80001826:	fc06                	sd	ra,56(sp)
    80001828:	f822                	sd	s0,48(sp)
    8000182a:	f426                	sd	s1,40(sp)
    8000182c:	f04a                	sd	s2,32(sp)
    8000182e:	ec4e                	sd	s3,24(sp)
    80001830:	e852                	sd	s4,16(sp)
    80001832:	e456                	sd	s5,8(sp)
    80001834:	e05a                	sd	s6,0(sp)
    80001836:	0080                	addi	s0,sp,64
    80001838:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    8000183a:	00010497          	auipc	s1,0x10
    8000183e:	e9648493          	addi	s1,s1,-362 # 800116d0 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80001842:	8b26                	mv	s6,s1
    80001844:	00006a97          	auipc	s5,0x6
    80001848:	7bca8a93          	addi	s5,s5,1980 # 80008000 <etext>
    8000184c:	04000937          	lui	s2,0x4000
    80001850:	197d                	addi	s2,s2,-1
    80001852:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80001854:	00016a17          	auipc	s4,0x16
    80001858:	c7ca0a13          	addi	s4,s4,-900 # 800174d0 <tickslock>
    char *pa = kalloc();
    8000185c:	fffff097          	auipc	ra,0xfffff
    80001860:	284080e7          	jalr	644(ra) # 80000ae0 <kalloc>
    80001864:	862a                	mv	a2,a0
    if(pa == 0)
    80001866:	c131                	beqz	a0,800018aa <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80001868:	416485b3          	sub	a1,s1,s6
    8000186c:	858d                	srai	a1,a1,0x3
    8000186e:	000ab783          	ld	a5,0(s5)
    80001872:	02f585b3          	mul	a1,a1,a5
    80001876:	2585                	addiw	a1,a1,1
    80001878:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    8000187c:	4719                	li	a4,6
    8000187e:	6685                	lui	a3,0x1
    80001880:	40b905b3          	sub	a1,s2,a1
    80001884:	854e                	mv	a0,s3
    80001886:	00000097          	auipc	ra,0x0
    8000188a:	8ae080e7          	jalr	-1874(ra) # 80001134 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000188e:	17848493          	addi	s1,s1,376
    80001892:	fd4495e3          	bne	s1,s4,8000185c <proc_mapstacks+0x38>
  }
}
    80001896:	70e2                	ld	ra,56(sp)
    80001898:	7442                	ld	s0,48(sp)
    8000189a:	74a2                	ld	s1,40(sp)
    8000189c:	7902                	ld	s2,32(sp)
    8000189e:	69e2                	ld	s3,24(sp)
    800018a0:	6a42                	ld	s4,16(sp)
    800018a2:	6aa2                	ld	s5,8(sp)
    800018a4:	6b02                	ld	s6,0(sp)
    800018a6:	6121                	addi	sp,sp,64
    800018a8:	8082                	ret
      panic("kalloc");
    800018aa:	00007517          	auipc	a0,0x7
    800018ae:	92e50513          	addi	a0,a0,-1746 # 800081d8 <digits+0x198>
    800018b2:	fffff097          	auipc	ra,0xfffff
    800018b6:	c88080e7          	jalr	-888(ra) # 8000053a <panic>

00000000800018ba <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    800018ba:	7139                	addi	sp,sp,-64
    800018bc:	fc06                	sd	ra,56(sp)
    800018be:	f822                	sd	s0,48(sp)
    800018c0:	f426                	sd	s1,40(sp)
    800018c2:	f04a                	sd	s2,32(sp)
    800018c4:	ec4e                	sd	s3,24(sp)
    800018c6:	e852                	sd	s4,16(sp)
    800018c8:	e456                	sd	s5,8(sp)
    800018ca:	e05a                	sd	s6,0(sp)
    800018cc:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    800018ce:	00007597          	auipc	a1,0x7
    800018d2:	91258593          	addi	a1,a1,-1774 # 800081e0 <digits+0x1a0>
    800018d6:	00010517          	auipc	a0,0x10
    800018da:	9ca50513          	addi	a0,a0,-1590 # 800112a0 <pid_lock>
    800018de:	fffff097          	auipc	ra,0xfffff
    800018e2:	262080e7          	jalr	610(ra) # 80000b40 <initlock>
  initlock(&wait_lock, "wait_lock");
    800018e6:	00007597          	auipc	a1,0x7
    800018ea:	90258593          	addi	a1,a1,-1790 # 800081e8 <digits+0x1a8>
    800018ee:	00010517          	auipc	a0,0x10
    800018f2:	9ca50513          	addi	a0,a0,-1590 # 800112b8 <wait_lock>
    800018f6:	fffff097          	auipc	ra,0xfffff
    800018fa:	24a080e7          	jalr	586(ra) # 80000b40 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    800018fe:	00010497          	auipc	s1,0x10
    80001902:	dd248493          	addi	s1,s1,-558 # 800116d0 <proc>
      initlock(&p->lock, "proc");
    80001906:	00007b17          	auipc	s6,0x7
    8000190a:	8f2b0b13          	addi	s6,s6,-1806 # 800081f8 <digits+0x1b8>
      p->kstack = KSTACK((int) (p - proc));
    8000190e:	8aa6                	mv	s5,s1
    80001910:	00006a17          	auipc	s4,0x6
    80001914:	6f0a0a13          	addi	s4,s4,1776 # 80008000 <etext>
    80001918:	04000937          	lui	s2,0x4000
    8000191c:	197d                	addi	s2,s2,-1
    8000191e:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80001920:	00016997          	auipc	s3,0x16
    80001924:	bb098993          	addi	s3,s3,-1104 # 800174d0 <tickslock>
      initlock(&p->lock, "proc");
    80001928:	85da                	mv	a1,s6
    8000192a:	8526                	mv	a0,s1
    8000192c:	fffff097          	auipc	ra,0xfffff
    80001930:	214080e7          	jalr	532(ra) # 80000b40 <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80001934:	415487b3          	sub	a5,s1,s5
    80001938:	878d                	srai	a5,a5,0x3
    8000193a:	000a3703          	ld	a4,0(s4)
    8000193e:	02e787b3          	mul	a5,a5,a4
    80001942:	2785                	addiw	a5,a5,1
    80001944:	00d7979b          	slliw	a5,a5,0xd
    80001948:	40f907b3          	sub	a5,s2,a5
    8000194c:	e8bc                	sd	a5,80(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    8000194e:	17848493          	addi	s1,s1,376
    80001952:	fd349be3          	bne	s1,s3,80001928 <procinit+0x6e>
  }
}
    80001956:	70e2                	ld	ra,56(sp)
    80001958:	7442                	ld	s0,48(sp)
    8000195a:	74a2                	ld	s1,40(sp)
    8000195c:	7902                	ld	s2,32(sp)
    8000195e:	69e2                	ld	s3,24(sp)
    80001960:	6a42                	ld	s4,16(sp)
    80001962:	6aa2                	ld	s5,8(sp)
    80001964:	6b02                	ld	s6,0(sp)
    80001966:	6121                	addi	sp,sp,64
    80001968:	8082                	ret

000000008000196a <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    8000196a:	1141                	addi	sp,sp,-16
    8000196c:	e422                	sd	s0,8(sp)
    8000196e:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80001970:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80001972:	2501                	sext.w	a0,a0
    80001974:	6422                	ld	s0,8(sp)
    80001976:	0141                	addi	sp,sp,16
    80001978:	8082                	ret

000000008000197a <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    8000197a:	1141                	addi	sp,sp,-16
    8000197c:	e422                	sd	s0,8(sp)
    8000197e:	0800                	addi	s0,sp,16
    80001980:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80001982:	2781                	sext.w	a5,a5
    80001984:	079e                	slli	a5,a5,0x7
  return c;
}
    80001986:	00010517          	auipc	a0,0x10
    8000198a:	94a50513          	addi	a0,a0,-1718 # 800112d0 <cpus>
    8000198e:	953e                	add	a0,a0,a5
    80001990:	6422                	ld	s0,8(sp)
    80001992:	0141                	addi	sp,sp,16
    80001994:	8082                	ret

0000000080001996 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80001996:	1101                	addi	sp,sp,-32
    80001998:	ec06                	sd	ra,24(sp)
    8000199a:	e822                	sd	s0,16(sp)
    8000199c:	e426                	sd	s1,8(sp)
    8000199e:	1000                	addi	s0,sp,32
  push_off();
    800019a0:	fffff097          	auipc	ra,0xfffff
    800019a4:	1e4080e7          	jalr	484(ra) # 80000b84 <push_off>
    800019a8:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    800019aa:	2781                	sext.w	a5,a5
    800019ac:	079e                	slli	a5,a5,0x7
    800019ae:	00010717          	auipc	a4,0x10
    800019b2:	8f270713          	addi	a4,a4,-1806 # 800112a0 <pid_lock>
    800019b6:	97ba                	add	a5,a5,a4
    800019b8:	7b84                	ld	s1,48(a5)
  pop_off();
    800019ba:	fffff097          	auipc	ra,0xfffff
    800019be:	26a080e7          	jalr	618(ra) # 80000c24 <pop_off>
  return p;
}
    800019c2:	8526                	mv	a0,s1
    800019c4:	60e2                	ld	ra,24(sp)
    800019c6:	6442                	ld	s0,16(sp)
    800019c8:	64a2                	ld	s1,8(sp)
    800019ca:	6105                	addi	sp,sp,32
    800019cc:	8082                	ret

00000000800019ce <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    800019ce:	1141                	addi	sp,sp,-16
    800019d0:	e406                	sd	ra,8(sp)
    800019d2:	e022                	sd	s0,0(sp)
    800019d4:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    800019d6:	00000097          	auipc	ra,0x0
    800019da:	fc0080e7          	jalr	-64(ra) # 80001996 <myproc>
    800019de:	fffff097          	auipc	ra,0xfffff
    800019e2:	2a6080e7          	jalr	678(ra) # 80000c84 <release>

  if (first) {
    800019e6:	00007797          	auipc	a5,0x7
    800019ea:	e3a7a783          	lw	a5,-454(a5) # 80008820 <first.1>
    800019ee:	eb89                	bnez	a5,80001a00 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    800019f0:	00001097          	auipc	ra,0x1
    800019f4:	ccc080e7          	jalr	-820(ra) # 800026bc <usertrapret>
}
    800019f8:	60a2                	ld	ra,8(sp)
    800019fa:	6402                	ld	s0,0(sp)
    800019fc:	0141                	addi	sp,sp,16
    800019fe:	8082                	ret
    first = 0;
    80001a00:	00007797          	auipc	a5,0x7
    80001a04:	e207a023          	sw	zero,-480(a5) # 80008820 <first.1>
    fsinit(ROOTDEV);
    80001a08:	4505                	li	a0,1
    80001a0a:	00002097          	auipc	ra,0x2
    80001a0e:	a2a080e7          	jalr	-1494(ra) # 80003434 <fsinit>
    80001a12:	bff9                	j	800019f0 <forkret+0x22>

0000000080001a14 <allocpid>:
allocpid() {
    80001a14:	1101                	addi	sp,sp,-32
    80001a16:	ec06                	sd	ra,24(sp)
    80001a18:	e822                	sd	s0,16(sp)
    80001a1a:	e426                	sd	s1,8(sp)
    80001a1c:	e04a                	sd	s2,0(sp)
    80001a1e:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80001a20:	00010917          	auipc	s2,0x10
    80001a24:	88090913          	addi	s2,s2,-1920 # 800112a0 <pid_lock>
    80001a28:	854a                	mv	a0,s2
    80001a2a:	fffff097          	auipc	ra,0xfffff
    80001a2e:	1a6080e7          	jalr	422(ra) # 80000bd0 <acquire>
  pid = nextpid;
    80001a32:	00007797          	auipc	a5,0x7
    80001a36:	df278793          	addi	a5,a5,-526 # 80008824 <nextpid>
    80001a3a:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80001a3c:	0014871b          	addiw	a4,s1,1
    80001a40:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80001a42:	854a                	mv	a0,s2
    80001a44:	fffff097          	auipc	ra,0xfffff
    80001a48:	240080e7          	jalr	576(ra) # 80000c84 <release>
}
    80001a4c:	8526                	mv	a0,s1
    80001a4e:	60e2                	ld	ra,24(sp)
    80001a50:	6442                	ld	s0,16(sp)
    80001a52:	64a2                	ld	s1,8(sp)
    80001a54:	6902                	ld	s2,0(sp)
    80001a56:	6105                	addi	sp,sp,32
    80001a58:	8082                	ret

0000000080001a5a <proc_pagetable>:
{
    80001a5a:	1101                	addi	sp,sp,-32
    80001a5c:	ec06                	sd	ra,24(sp)
    80001a5e:	e822                	sd	s0,16(sp)
    80001a60:	e426                	sd	s1,8(sp)
    80001a62:	e04a                	sd	s2,0(sp)
    80001a64:	1000                	addi	s0,sp,32
    80001a66:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001a68:	00000097          	auipc	ra,0x0
    80001a6c:	8b6080e7          	jalr	-1866(ra) # 8000131e <uvmcreate>
    80001a70:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001a72:	c121                	beqz	a0,80001ab2 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80001a74:	4729                	li	a4,10
    80001a76:	00005697          	auipc	a3,0x5
    80001a7a:	58a68693          	addi	a3,a3,1418 # 80007000 <_trampoline>
    80001a7e:	6605                	lui	a2,0x1
    80001a80:	040005b7          	lui	a1,0x4000
    80001a84:	15fd                	addi	a1,a1,-1
    80001a86:	05b2                	slli	a1,a1,0xc
    80001a88:	fffff097          	auipc	ra,0xfffff
    80001a8c:	60c080e7          	jalr	1548(ra) # 80001094 <mappages>
    80001a90:	02054863          	bltz	a0,80001ac0 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80001a94:	4719                	li	a4,6
    80001a96:	06893683          	ld	a3,104(s2)
    80001a9a:	6605                	lui	a2,0x1
    80001a9c:	020005b7          	lui	a1,0x2000
    80001aa0:	15fd                	addi	a1,a1,-1
    80001aa2:	05b6                	slli	a1,a1,0xd
    80001aa4:	8526                	mv	a0,s1
    80001aa6:	fffff097          	auipc	ra,0xfffff
    80001aaa:	5ee080e7          	jalr	1518(ra) # 80001094 <mappages>
    80001aae:	02054163          	bltz	a0,80001ad0 <proc_pagetable+0x76>
}
    80001ab2:	8526                	mv	a0,s1
    80001ab4:	60e2                	ld	ra,24(sp)
    80001ab6:	6442                	ld	s0,16(sp)
    80001ab8:	64a2                	ld	s1,8(sp)
    80001aba:	6902                	ld	s2,0(sp)
    80001abc:	6105                	addi	sp,sp,32
    80001abe:	8082                	ret
    uvmfree(pagetable, 0);
    80001ac0:	4581                	li	a1,0
    80001ac2:	8526                	mv	a0,s1
    80001ac4:	00000097          	auipc	ra,0x0
    80001ac8:	a58080e7          	jalr	-1448(ra) # 8000151c <uvmfree>
    return 0;
    80001acc:	4481                	li	s1,0
    80001ace:	b7d5                	j	80001ab2 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001ad0:	4681                	li	a3,0
    80001ad2:	4605                	li	a2,1
    80001ad4:	040005b7          	lui	a1,0x4000
    80001ad8:	15fd                	addi	a1,a1,-1
    80001ada:	05b2                	slli	a1,a1,0xc
    80001adc:	8526                	mv	a0,s1
    80001ade:	fffff097          	auipc	ra,0xfffff
    80001ae2:	77c080e7          	jalr	1916(ra) # 8000125a <uvmunmap>
    uvmfree(pagetable, 0);
    80001ae6:	4581                	li	a1,0
    80001ae8:	8526                	mv	a0,s1
    80001aea:	00000097          	auipc	ra,0x0
    80001aee:	a32080e7          	jalr	-1486(ra) # 8000151c <uvmfree>
    return 0;
    80001af2:	4481                	li	s1,0
    80001af4:	bf7d                	j	80001ab2 <proc_pagetable+0x58>

0000000080001af6 <proc_freepagetable>:
{
    80001af6:	1101                	addi	sp,sp,-32
    80001af8:	ec06                	sd	ra,24(sp)
    80001afa:	e822                	sd	s0,16(sp)
    80001afc:	e426                	sd	s1,8(sp)
    80001afe:	e04a                	sd	s2,0(sp)
    80001b00:	1000                	addi	s0,sp,32
    80001b02:	84aa                	mv	s1,a0
    80001b04:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001b06:	4681                	li	a3,0
    80001b08:	4605                	li	a2,1
    80001b0a:	040005b7          	lui	a1,0x4000
    80001b0e:	15fd                	addi	a1,a1,-1
    80001b10:	05b2                	slli	a1,a1,0xc
    80001b12:	fffff097          	auipc	ra,0xfffff
    80001b16:	748080e7          	jalr	1864(ra) # 8000125a <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001b1a:	4681                	li	a3,0
    80001b1c:	4605                	li	a2,1
    80001b1e:	020005b7          	lui	a1,0x2000
    80001b22:	15fd                	addi	a1,a1,-1
    80001b24:	05b6                	slli	a1,a1,0xd
    80001b26:	8526                	mv	a0,s1
    80001b28:	fffff097          	auipc	ra,0xfffff
    80001b2c:	732080e7          	jalr	1842(ra) # 8000125a <uvmunmap>
  uvmfree(pagetable, sz);
    80001b30:	85ca                	mv	a1,s2
    80001b32:	8526                	mv	a0,s1
    80001b34:	00000097          	auipc	ra,0x0
    80001b38:	9e8080e7          	jalr	-1560(ra) # 8000151c <uvmfree>
}
    80001b3c:	60e2                	ld	ra,24(sp)
    80001b3e:	6442                	ld	s0,16(sp)
    80001b40:	64a2                	ld	s1,8(sp)
    80001b42:	6902                	ld	s2,0(sp)
    80001b44:	6105                	addi	sp,sp,32
    80001b46:	8082                	ret

0000000080001b48 <freeproc>:
{
    80001b48:	1101                	addi	sp,sp,-32
    80001b4a:	ec06                	sd	ra,24(sp)
    80001b4c:	e822                	sd	s0,16(sp)
    80001b4e:	e426                	sd	s1,8(sp)
    80001b50:	1000                	addi	s0,sp,32
    80001b52:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001b54:	7528                	ld	a0,104(a0)
    80001b56:	c509                	beqz	a0,80001b60 <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001b58:	fffff097          	auipc	ra,0xfffff
    80001b5c:	e8a080e7          	jalr	-374(ra) # 800009e2 <kfree>
  p->trapframe = 0;
    80001b60:	0604b423          	sd	zero,104(s1)
  if(p->pagetable)
    80001b64:	70a8                	ld	a0,96(s1)
    80001b66:	c511                	beqz	a0,80001b72 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001b68:	6cac                	ld	a1,88(s1)
    80001b6a:	00000097          	auipc	ra,0x0
    80001b6e:	f8c080e7          	jalr	-116(ra) # 80001af6 <proc_freepagetable>
  p->pagetable = 0;
    80001b72:	0604b023          	sd	zero,96(s1)
  p->sz = 0;
    80001b76:	0404bc23          	sd	zero,88(s1)
  p->pid = 0;
    80001b7a:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001b7e:	0404b423          	sd	zero,72(s1)
  p->name[0] = 0;
    80001b82:	16048423          	sb	zero,360(s1)
  p->chan = 0;
    80001b86:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001b8a:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001b8e:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001b92:	0004ac23          	sw	zero,24(s1)
}
    80001b96:	60e2                	ld	ra,24(sp)
    80001b98:	6442                	ld	s0,16(sp)
    80001b9a:	64a2                	ld	s1,8(sp)
    80001b9c:	6105                	addi	sp,sp,32
    80001b9e:	8082                	ret

0000000080001ba0 <allocproc>:
{
    80001ba0:	1101                	addi	sp,sp,-32
    80001ba2:	ec06                	sd	ra,24(sp)
    80001ba4:	e822                	sd	s0,16(sp)
    80001ba6:	e426                	sd	s1,8(sp)
    80001ba8:	e04a                	sd	s2,0(sp)
    80001baa:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001bac:	00010497          	auipc	s1,0x10
    80001bb0:	b2448493          	addi	s1,s1,-1244 # 800116d0 <proc>
    80001bb4:	00016917          	auipc	s2,0x16
    80001bb8:	91c90913          	addi	s2,s2,-1764 # 800174d0 <tickslock>
    acquire(&p->lock);
    80001bbc:	8526                	mv	a0,s1
    80001bbe:	fffff097          	auipc	ra,0xfffff
    80001bc2:	012080e7          	jalr	18(ra) # 80000bd0 <acquire>
    if(p->state == UNUSED) {
    80001bc6:	4c9c                	lw	a5,24(s1)
    80001bc8:	cf81                	beqz	a5,80001be0 <allocproc+0x40>
      release(&p->lock);
    80001bca:	8526                	mv	a0,s1
    80001bcc:	fffff097          	auipc	ra,0xfffff
    80001bd0:	0b8080e7          	jalr	184(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001bd4:	17848493          	addi	s1,s1,376
    80001bd8:	ff2492e3          	bne	s1,s2,80001bbc <allocproc+0x1c>
  return 0;
    80001bdc:	4481                	li	s1,0
    80001bde:	a8b1                	j	80001c3a <allocproc+0x9a>
  p->pid = allocpid();
    80001be0:	00000097          	auipc	ra,0x0
    80001be4:	e34080e7          	jalr	-460(ra) # 80001a14 <allocpid>
    80001be8:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001bea:	4785                	li	a5,1
    80001bec:	cc9c                	sw	a5,24(s1)
  p->priority = LOW_PRIORITY;
    80001bee:	d8dc                	sw	a5,52(s1)
  p->hticks = 0;
    80001bf0:	0204bc23          	sd	zero,56(s1)
  p->lticks = 0;
    80001bf4:	0404b023          	sd	zero,64(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001bf8:	fffff097          	auipc	ra,0xfffff
    80001bfc:	ee8080e7          	jalr	-280(ra) # 80000ae0 <kalloc>
    80001c00:	892a                	mv	s2,a0
    80001c02:	f4a8                	sd	a0,104(s1)
    80001c04:	c131                	beqz	a0,80001c48 <allocproc+0xa8>
  p->pagetable = proc_pagetable(p);
    80001c06:	8526                	mv	a0,s1
    80001c08:	00000097          	auipc	ra,0x0
    80001c0c:	e52080e7          	jalr	-430(ra) # 80001a5a <proc_pagetable>
    80001c10:	892a                	mv	s2,a0
    80001c12:	f0a8                	sd	a0,96(s1)
  if(p->pagetable == 0){
    80001c14:	c531                	beqz	a0,80001c60 <allocproc+0xc0>
  memset(&p->context, 0, sizeof(p->context));
    80001c16:	07000613          	li	a2,112
    80001c1a:	4581                	li	a1,0
    80001c1c:	07048513          	addi	a0,s1,112
    80001c20:	fffff097          	auipc	ra,0xfffff
    80001c24:	0ac080e7          	jalr	172(ra) # 80000ccc <memset>
  p->context.ra = (uint64)forkret;
    80001c28:	00000797          	auipc	a5,0x0
    80001c2c:	da678793          	addi	a5,a5,-602 # 800019ce <forkret>
    80001c30:	f8bc                	sd	a5,112(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001c32:	68bc                	ld	a5,80(s1)
    80001c34:	6705                	lui	a4,0x1
    80001c36:	97ba                	add	a5,a5,a4
    80001c38:	fcbc                	sd	a5,120(s1)
}
    80001c3a:	8526                	mv	a0,s1
    80001c3c:	60e2                	ld	ra,24(sp)
    80001c3e:	6442                	ld	s0,16(sp)
    80001c40:	64a2                	ld	s1,8(sp)
    80001c42:	6902                	ld	s2,0(sp)
    80001c44:	6105                	addi	sp,sp,32
    80001c46:	8082                	ret
    freeproc(p);
    80001c48:	8526                	mv	a0,s1
    80001c4a:	00000097          	auipc	ra,0x0
    80001c4e:	efe080e7          	jalr	-258(ra) # 80001b48 <freeproc>
    release(&p->lock);
    80001c52:	8526                	mv	a0,s1
    80001c54:	fffff097          	auipc	ra,0xfffff
    80001c58:	030080e7          	jalr	48(ra) # 80000c84 <release>
    return 0;
    80001c5c:	84ca                	mv	s1,s2
    80001c5e:	bff1                	j	80001c3a <allocproc+0x9a>
    freeproc(p);
    80001c60:	8526                	mv	a0,s1
    80001c62:	00000097          	auipc	ra,0x0
    80001c66:	ee6080e7          	jalr	-282(ra) # 80001b48 <freeproc>
    release(&p->lock);
    80001c6a:	8526                	mv	a0,s1
    80001c6c:	fffff097          	auipc	ra,0xfffff
    80001c70:	018080e7          	jalr	24(ra) # 80000c84 <release>
    return 0;
    80001c74:	84ca                	mv	s1,s2
    80001c76:	b7d1                	j	80001c3a <allocproc+0x9a>

0000000080001c78 <userinit>:
{
    80001c78:	1101                	addi	sp,sp,-32
    80001c7a:	ec06                	sd	ra,24(sp)
    80001c7c:	e822                	sd	s0,16(sp)
    80001c7e:	e426                	sd	s1,8(sp)
    80001c80:	1000                	addi	s0,sp,32
  p = allocproc();
    80001c82:	00000097          	auipc	ra,0x0
    80001c86:	f1e080e7          	jalr	-226(ra) # 80001ba0 <allocproc>
    80001c8a:	84aa                	mv	s1,a0
  initproc = p;
    80001c8c:	00007797          	auipc	a5,0x7
    80001c90:	38a7be23          	sd	a0,924(a5) # 80009028 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80001c94:	03400613          	li	a2,52
    80001c98:	00007597          	auipc	a1,0x7
    80001c9c:	b9858593          	addi	a1,a1,-1128 # 80008830 <initcode>
    80001ca0:	7128                	ld	a0,96(a0)
    80001ca2:	fffff097          	auipc	ra,0xfffff
    80001ca6:	6aa080e7          	jalr	1706(ra) # 8000134c <uvminit>
  p->sz = PGSIZE;
    80001caa:	6785                	lui	a5,0x1
    80001cac:	ecbc                	sd	a5,88(s1)
  p->trapframe->epc = 0;      // user program counter
    80001cae:	74b8                	ld	a4,104(s1)
    80001cb0:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001cb4:	74b8                	ld	a4,104(s1)
    80001cb6:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001cb8:	4641                	li	a2,16
    80001cba:	00006597          	auipc	a1,0x6
    80001cbe:	54658593          	addi	a1,a1,1350 # 80008200 <digits+0x1c0>
    80001cc2:	16848513          	addi	a0,s1,360
    80001cc6:	fffff097          	auipc	ra,0xfffff
    80001cca:	150080e7          	jalr	336(ra) # 80000e16 <safestrcpy>
  p->cwd = namei("/");
    80001cce:	00006517          	auipc	a0,0x6
    80001cd2:	54250513          	addi	a0,a0,1346 # 80008210 <digits+0x1d0>
    80001cd6:	00002097          	auipc	ra,0x2
    80001cda:	194080e7          	jalr	404(ra) # 80003e6a <namei>
    80001cde:	16a4b023          	sd	a0,352(s1)
  p->state = RUNNABLE;
    80001ce2:	478d                	li	a5,3
    80001ce4:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001ce6:	8526                	mv	a0,s1
    80001ce8:	fffff097          	auipc	ra,0xfffff
    80001cec:	f9c080e7          	jalr	-100(ra) # 80000c84 <release>
}
    80001cf0:	60e2                	ld	ra,24(sp)
    80001cf2:	6442                	ld	s0,16(sp)
    80001cf4:	64a2                	ld	s1,8(sp)
    80001cf6:	6105                	addi	sp,sp,32
    80001cf8:	8082                	ret

0000000080001cfa <growproc>:
{
    80001cfa:	1101                	addi	sp,sp,-32
    80001cfc:	ec06                	sd	ra,24(sp)
    80001cfe:	e822                	sd	s0,16(sp)
    80001d00:	e426                	sd	s1,8(sp)
    80001d02:	e04a                	sd	s2,0(sp)
    80001d04:	1000                	addi	s0,sp,32
    80001d06:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001d08:	00000097          	auipc	ra,0x0
    80001d0c:	c8e080e7          	jalr	-882(ra) # 80001996 <myproc>
    80001d10:	892a                	mv	s2,a0
  sz = p->sz;
    80001d12:	6d2c                	ld	a1,88(a0)
    80001d14:	0005879b          	sext.w	a5,a1
  if(n > 0){
    80001d18:	00904f63          	bgtz	s1,80001d36 <growproc+0x3c>
  } else if(n < 0){
    80001d1c:	0204cd63          	bltz	s1,80001d56 <growproc+0x5c>
  p->sz = sz;
    80001d20:	1782                	slli	a5,a5,0x20
    80001d22:	9381                	srli	a5,a5,0x20
    80001d24:	04f93c23          	sd	a5,88(s2)
  return 0;
    80001d28:	4501                	li	a0,0
}
    80001d2a:	60e2                	ld	ra,24(sp)
    80001d2c:	6442                	ld	s0,16(sp)
    80001d2e:	64a2                	ld	s1,8(sp)
    80001d30:	6902                	ld	s2,0(sp)
    80001d32:	6105                	addi	sp,sp,32
    80001d34:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80001d36:	00f4863b          	addw	a2,s1,a5
    80001d3a:	1602                	slli	a2,a2,0x20
    80001d3c:	9201                	srli	a2,a2,0x20
    80001d3e:	1582                	slli	a1,a1,0x20
    80001d40:	9181                	srli	a1,a1,0x20
    80001d42:	7128                	ld	a0,96(a0)
    80001d44:	fffff097          	auipc	ra,0xfffff
    80001d48:	6c2080e7          	jalr	1730(ra) # 80001406 <uvmalloc>
    80001d4c:	0005079b          	sext.w	a5,a0
    80001d50:	fbe1                	bnez	a5,80001d20 <growproc+0x26>
      return -1;
    80001d52:	557d                	li	a0,-1
    80001d54:	bfd9                	j	80001d2a <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001d56:	00f4863b          	addw	a2,s1,a5
    80001d5a:	1602                	slli	a2,a2,0x20
    80001d5c:	9201                	srli	a2,a2,0x20
    80001d5e:	1582                	slli	a1,a1,0x20
    80001d60:	9181                	srli	a1,a1,0x20
    80001d62:	7128                	ld	a0,96(a0)
    80001d64:	fffff097          	auipc	ra,0xfffff
    80001d68:	65a080e7          	jalr	1626(ra) # 800013be <uvmdealloc>
    80001d6c:	0005079b          	sext.w	a5,a0
    80001d70:	bf45                	j	80001d20 <growproc+0x26>

0000000080001d72 <fork>:
{
    80001d72:	7139                	addi	sp,sp,-64
    80001d74:	fc06                	sd	ra,56(sp)
    80001d76:	f822                	sd	s0,48(sp)
    80001d78:	f426                	sd	s1,40(sp)
    80001d7a:	f04a                	sd	s2,32(sp)
    80001d7c:	ec4e                	sd	s3,24(sp)
    80001d7e:	e852                	sd	s4,16(sp)
    80001d80:	e456                	sd	s5,8(sp)
    80001d82:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001d84:	00000097          	auipc	ra,0x0
    80001d88:	c12080e7          	jalr	-1006(ra) # 80001996 <myproc>
    80001d8c:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001d8e:	00000097          	auipc	ra,0x0
    80001d92:	e12080e7          	jalr	-494(ra) # 80001ba0 <allocproc>
    80001d96:	10050c63          	beqz	a0,80001eae <fork+0x13c>
    80001d9a:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001d9c:	058ab603          	ld	a2,88(s5)
    80001da0:	712c                	ld	a1,96(a0)
    80001da2:	060ab503          	ld	a0,96(s5)
    80001da6:	fffff097          	auipc	ra,0xfffff
    80001daa:	7b0080e7          	jalr	1968(ra) # 80001556 <uvmcopy>
    80001dae:	04054863          	bltz	a0,80001dfe <fork+0x8c>
  np->sz = p->sz;
    80001db2:	058ab783          	ld	a5,88(s5)
    80001db6:	04fa3c23          	sd	a5,88(s4)
  *(np->trapframe) = *(p->trapframe);
    80001dba:	068ab683          	ld	a3,104(s5)
    80001dbe:	87b6                	mv	a5,a3
    80001dc0:	068a3703          	ld	a4,104(s4)
    80001dc4:	12068693          	addi	a3,a3,288
    80001dc8:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001dcc:	6788                	ld	a0,8(a5)
    80001dce:	6b8c                	ld	a1,16(a5)
    80001dd0:	6f90                	ld	a2,24(a5)
    80001dd2:	01073023          	sd	a6,0(a4)
    80001dd6:	e708                	sd	a0,8(a4)
    80001dd8:	eb0c                	sd	a1,16(a4)
    80001dda:	ef10                	sd	a2,24(a4)
    80001ddc:	02078793          	addi	a5,a5,32
    80001de0:	02070713          	addi	a4,a4,32
    80001de4:	fed792e3          	bne	a5,a3,80001dc8 <fork+0x56>
  np->trapframe->a0 = 0;
    80001de8:	068a3783          	ld	a5,104(s4)
    80001dec:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001df0:	0e0a8493          	addi	s1,s5,224
    80001df4:	0e0a0913          	addi	s2,s4,224
    80001df8:	160a8993          	addi	s3,s5,352
    80001dfc:	a00d                	j	80001e1e <fork+0xac>
    freeproc(np);
    80001dfe:	8552                	mv	a0,s4
    80001e00:	00000097          	auipc	ra,0x0
    80001e04:	d48080e7          	jalr	-696(ra) # 80001b48 <freeproc>
    release(&np->lock);
    80001e08:	8552                	mv	a0,s4
    80001e0a:	fffff097          	auipc	ra,0xfffff
    80001e0e:	e7a080e7          	jalr	-390(ra) # 80000c84 <release>
    return -1;
    80001e12:	597d                	li	s2,-1
    80001e14:	a059                	j	80001e9a <fork+0x128>
  for(i = 0; i < NOFILE; i++)
    80001e16:	04a1                	addi	s1,s1,8
    80001e18:	0921                	addi	s2,s2,8
    80001e1a:	01348b63          	beq	s1,s3,80001e30 <fork+0xbe>
    if(p->ofile[i])
    80001e1e:	6088                	ld	a0,0(s1)
    80001e20:	d97d                	beqz	a0,80001e16 <fork+0xa4>
      np->ofile[i] = filedup(p->ofile[i]);
    80001e22:	00002097          	auipc	ra,0x2
    80001e26:	6de080e7          	jalr	1758(ra) # 80004500 <filedup>
    80001e2a:	00a93023          	sd	a0,0(s2)
    80001e2e:	b7e5                	j	80001e16 <fork+0xa4>
  np->cwd = idup(p->cwd);
    80001e30:	160ab503          	ld	a0,352(s5)
    80001e34:	00002097          	auipc	ra,0x2
    80001e38:	83c080e7          	jalr	-1988(ra) # 80003670 <idup>
    80001e3c:	16aa3023          	sd	a0,352(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001e40:	4641                	li	a2,16
    80001e42:	168a8593          	addi	a1,s5,360
    80001e46:	168a0513          	addi	a0,s4,360
    80001e4a:	fffff097          	auipc	ra,0xfffff
    80001e4e:	fcc080e7          	jalr	-52(ra) # 80000e16 <safestrcpy>
  pid = np->pid;
    80001e52:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    80001e56:	8552                	mv	a0,s4
    80001e58:	fffff097          	auipc	ra,0xfffff
    80001e5c:	e2c080e7          	jalr	-468(ra) # 80000c84 <release>
  acquire(&wait_lock);
    80001e60:	0000f497          	auipc	s1,0xf
    80001e64:	45848493          	addi	s1,s1,1112 # 800112b8 <wait_lock>
    80001e68:	8526                	mv	a0,s1
    80001e6a:	fffff097          	auipc	ra,0xfffff
    80001e6e:	d66080e7          	jalr	-666(ra) # 80000bd0 <acquire>
  np->parent = p;
    80001e72:	055a3423          	sd	s5,72(s4)
  release(&wait_lock);
    80001e76:	8526                	mv	a0,s1
    80001e78:	fffff097          	auipc	ra,0xfffff
    80001e7c:	e0c080e7          	jalr	-500(ra) # 80000c84 <release>
  acquire(&np->lock);
    80001e80:	8552                	mv	a0,s4
    80001e82:	fffff097          	auipc	ra,0xfffff
    80001e86:	d4e080e7          	jalr	-690(ra) # 80000bd0 <acquire>
  np->state = RUNNABLE;
    80001e8a:	478d                	li	a5,3
    80001e8c:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001e90:	8552                	mv	a0,s4
    80001e92:	fffff097          	auipc	ra,0xfffff
    80001e96:	df2080e7          	jalr	-526(ra) # 80000c84 <release>
}
    80001e9a:	854a                	mv	a0,s2
    80001e9c:	70e2                	ld	ra,56(sp)
    80001e9e:	7442                	ld	s0,48(sp)
    80001ea0:	74a2                	ld	s1,40(sp)
    80001ea2:	7902                	ld	s2,32(sp)
    80001ea4:	69e2                	ld	s3,24(sp)
    80001ea6:	6a42                	ld	s4,16(sp)
    80001ea8:	6aa2                	ld	s5,8(sp)
    80001eaa:	6121                	addi	sp,sp,64
    80001eac:	8082                	ret
    return -1;
    80001eae:	597d                	li	s2,-1
    80001eb0:	b7ed                	j	80001e9a <fork+0x128>

0000000080001eb2 <scheduler>:
{
    80001eb2:	7139                	addi	sp,sp,-64
    80001eb4:	fc06                	sd	ra,56(sp)
    80001eb6:	f822                	sd	s0,48(sp)
    80001eb8:	f426                	sd	s1,40(sp)
    80001eba:	f04a                	sd	s2,32(sp)
    80001ebc:	ec4e                	sd	s3,24(sp)
    80001ebe:	e852                	sd	s4,16(sp)
    80001ec0:	e456                	sd	s5,8(sp)
    80001ec2:	e05a                	sd	s6,0(sp)
    80001ec4:	0080                	addi	s0,sp,64
    80001ec6:	8792                	mv	a5,tp
  int id = r_tp();
    80001ec8:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001eca:	00779a93          	slli	s5,a5,0x7
    80001ece:	0000f717          	auipc	a4,0xf
    80001ed2:	3d270713          	addi	a4,a4,978 # 800112a0 <pid_lock>
    80001ed6:	9756                	add	a4,a4,s5
    80001ed8:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001edc:	0000f717          	auipc	a4,0xf
    80001ee0:	3fc70713          	addi	a4,a4,1020 # 800112d8 <cpus+0x8>
    80001ee4:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    80001ee6:	498d                	li	s3,3
        p->state = RUNNING;
    80001ee8:	4b11                	li	s6,4
        c->proc = p;
    80001eea:	079e                	slli	a5,a5,0x7
    80001eec:	0000fa17          	auipc	s4,0xf
    80001ef0:	3b4a0a13          	addi	s4,s4,948 # 800112a0 <pid_lock>
    80001ef4:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001ef6:	00015917          	auipc	s2,0x15
    80001efa:	5da90913          	addi	s2,s2,1498 # 800174d0 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001efe:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001f02:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001f06:	10079073          	csrw	sstatus,a5
    80001f0a:	0000f497          	auipc	s1,0xf
    80001f0e:	7c648493          	addi	s1,s1,1990 # 800116d0 <proc>
    80001f12:	a811                	j	80001f26 <scheduler+0x74>
      release(&p->lock);
    80001f14:	8526                	mv	a0,s1
    80001f16:	fffff097          	auipc	ra,0xfffff
    80001f1a:	d6e080e7          	jalr	-658(ra) # 80000c84 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001f1e:	17848493          	addi	s1,s1,376
    80001f22:	fd248ee3          	beq	s1,s2,80001efe <scheduler+0x4c>
      acquire(&p->lock);
    80001f26:	8526                	mv	a0,s1
    80001f28:	fffff097          	auipc	ra,0xfffff
    80001f2c:	ca8080e7          	jalr	-856(ra) # 80000bd0 <acquire>
      if(p->state == RUNNABLE) {
    80001f30:	4c9c                	lw	a5,24(s1)
    80001f32:	ff3791e3          	bne	a5,s3,80001f14 <scheduler+0x62>
        p->state = RUNNING;
    80001f36:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    80001f3a:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    80001f3e:	07048593          	addi	a1,s1,112
    80001f42:	8556                	mv	a0,s5
    80001f44:	00000097          	auipc	ra,0x0
    80001f48:	6ce080e7          	jalr	1742(ra) # 80002612 <swtch>
        c->proc = 0;
    80001f4c:	020a3823          	sd	zero,48(s4)
    80001f50:	b7d1                	j	80001f14 <scheduler+0x62>

0000000080001f52 <sched>:
{
    80001f52:	7179                	addi	sp,sp,-48
    80001f54:	f406                	sd	ra,40(sp)
    80001f56:	f022                	sd	s0,32(sp)
    80001f58:	ec26                	sd	s1,24(sp)
    80001f5a:	e84a                	sd	s2,16(sp)
    80001f5c:	e44e                	sd	s3,8(sp)
    80001f5e:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001f60:	00000097          	auipc	ra,0x0
    80001f64:	a36080e7          	jalr	-1482(ra) # 80001996 <myproc>
    80001f68:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001f6a:	fffff097          	auipc	ra,0xfffff
    80001f6e:	bec080e7          	jalr	-1044(ra) # 80000b56 <holding>
    80001f72:	c93d                	beqz	a0,80001fe8 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001f74:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001f76:	2781                	sext.w	a5,a5
    80001f78:	079e                	slli	a5,a5,0x7
    80001f7a:	0000f717          	auipc	a4,0xf
    80001f7e:	32670713          	addi	a4,a4,806 # 800112a0 <pid_lock>
    80001f82:	97ba                	add	a5,a5,a4
    80001f84:	0a87a703          	lw	a4,168(a5)
    80001f88:	4785                	li	a5,1
    80001f8a:	06f71763          	bne	a4,a5,80001ff8 <sched+0xa6>
  if(p->state == RUNNING)
    80001f8e:	4c98                	lw	a4,24(s1)
    80001f90:	4791                	li	a5,4
    80001f92:	06f70b63          	beq	a4,a5,80002008 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f96:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001f9a:	8b89                	andi	a5,a5,2
  if(intr_get())
    80001f9c:	efb5                	bnez	a5,80002018 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001f9e:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001fa0:	0000f917          	auipc	s2,0xf
    80001fa4:	30090913          	addi	s2,s2,768 # 800112a0 <pid_lock>
    80001fa8:	2781                	sext.w	a5,a5
    80001faa:	079e                	slli	a5,a5,0x7
    80001fac:	97ca                	add	a5,a5,s2
    80001fae:	0ac7a983          	lw	s3,172(a5)
    80001fb2:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001fb4:	2781                	sext.w	a5,a5
    80001fb6:	079e                	slli	a5,a5,0x7
    80001fb8:	0000f597          	auipc	a1,0xf
    80001fbc:	32058593          	addi	a1,a1,800 # 800112d8 <cpus+0x8>
    80001fc0:	95be                	add	a1,a1,a5
    80001fc2:	07048513          	addi	a0,s1,112
    80001fc6:	00000097          	auipc	ra,0x0
    80001fca:	64c080e7          	jalr	1612(ra) # 80002612 <swtch>
    80001fce:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001fd0:	2781                	sext.w	a5,a5
    80001fd2:	079e                	slli	a5,a5,0x7
    80001fd4:	993e                	add	s2,s2,a5
    80001fd6:	0b392623          	sw	s3,172(s2)
}
    80001fda:	70a2                	ld	ra,40(sp)
    80001fdc:	7402                	ld	s0,32(sp)
    80001fde:	64e2                	ld	s1,24(sp)
    80001fe0:	6942                	ld	s2,16(sp)
    80001fe2:	69a2                	ld	s3,8(sp)
    80001fe4:	6145                	addi	sp,sp,48
    80001fe6:	8082                	ret
    panic("sched p->lock");
    80001fe8:	00006517          	auipc	a0,0x6
    80001fec:	23050513          	addi	a0,a0,560 # 80008218 <digits+0x1d8>
    80001ff0:	ffffe097          	auipc	ra,0xffffe
    80001ff4:	54a080e7          	jalr	1354(ra) # 8000053a <panic>
    panic("sched locks");
    80001ff8:	00006517          	auipc	a0,0x6
    80001ffc:	23050513          	addi	a0,a0,560 # 80008228 <digits+0x1e8>
    80002000:	ffffe097          	auipc	ra,0xffffe
    80002004:	53a080e7          	jalr	1338(ra) # 8000053a <panic>
    panic("sched running");
    80002008:	00006517          	auipc	a0,0x6
    8000200c:	23050513          	addi	a0,a0,560 # 80008238 <digits+0x1f8>
    80002010:	ffffe097          	auipc	ra,0xffffe
    80002014:	52a080e7          	jalr	1322(ra) # 8000053a <panic>
    panic("sched interruptible");
    80002018:	00006517          	auipc	a0,0x6
    8000201c:	23050513          	addi	a0,a0,560 # 80008248 <digits+0x208>
    80002020:	ffffe097          	auipc	ra,0xffffe
    80002024:	51a080e7          	jalr	1306(ra) # 8000053a <panic>

0000000080002028 <yield>:
{
    80002028:	1101                	addi	sp,sp,-32
    8000202a:	ec06                	sd	ra,24(sp)
    8000202c:	e822                	sd	s0,16(sp)
    8000202e:	e426                	sd	s1,8(sp)
    80002030:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80002032:	00000097          	auipc	ra,0x0
    80002036:	964080e7          	jalr	-1692(ra) # 80001996 <myproc>
    8000203a:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000203c:	fffff097          	auipc	ra,0xfffff
    80002040:	b94080e7          	jalr	-1132(ra) # 80000bd0 <acquire>
  p->state = RUNNABLE;
    80002044:	478d                	li	a5,3
    80002046:	cc9c                	sw	a5,24(s1)
  sched();
    80002048:	00000097          	auipc	ra,0x0
    8000204c:	f0a080e7          	jalr	-246(ra) # 80001f52 <sched>
  release(&p->lock);
    80002050:	8526                	mv	a0,s1
    80002052:	fffff097          	auipc	ra,0xfffff
    80002056:	c32080e7          	jalr	-974(ra) # 80000c84 <release>
}
    8000205a:	60e2                	ld	ra,24(sp)
    8000205c:	6442                	ld	s0,16(sp)
    8000205e:	64a2                	ld	s1,8(sp)
    80002060:	6105                	addi	sp,sp,32
    80002062:	8082                	ret

0000000080002064 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80002064:	7179                	addi	sp,sp,-48
    80002066:	f406                	sd	ra,40(sp)
    80002068:	f022                	sd	s0,32(sp)
    8000206a:	ec26                	sd	s1,24(sp)
    8000206c:	e84a                	sd	s2,16(sp)
    8000206e:	e44e                	sd	s3,8(sp)
    80002070:	1800                	addi	s0,sp,48
    80002072:	89aa                	mv	s3,a0
    80002074:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002076:	00000097          	auipc	ra,0x0
    8000207a:	920080e7          	jalr	-1760(ra) # 80001996 <myproc>
    8000207e:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80002080:	fffff097          	auipc	ra,0xfffff
    80002084:	b50080e7          	jalr	-1200(ra) # 80000bd0 <acquire>
  release(lk);
    80002088:	854a                	mv	a0,s2
    8000208a:	fffff097          	auipc	ra,0xfffff
    8000208e:	bfa080e7          	jalr	-1030(ra) # 80000c84 <release>

  // Go to sleep.
  p->chan = chan;
    80002092:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80002096:	4789                	li	a5,2
    80002098:	cc9c                	sw	a5,24(s1)

  sched();
    8000209a:	00000097          	auipc	ra,0x0
    8000209e:	eb8080e7          	jalr	-328(ra) # 80001f52 <sched>

  // Tidy up.
  p->chan = 0;
    800020a2:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    800020a6:	8526                	mv	a0,s1
    800020a8:	fffff097          	auipc	ra,0xfffff
    800020ac:	bdc080e7          	jalr	-1060(ra) # 80000c84 <release>
  acquire(lk);
    800020b0:	854a                	mv	a0,s2
    800020b2:	fffff097          	auipc	ra,0xfffff
    800020b6:	b1e080e7          	jalr	-1250(ra) # 80000bd0 <acquire>
}
    800020ba:	70a2                	ld	ra,40(sp)
    800020bc:	7402                	ld	s0,32(sp)
    800020be:	64e2                	ld	s1,24(sp)
    800020c0:	6942                	ld	s2,16(sp)
    800020c2:	69a2                	ld	s3,8(sp)
    800020c4:	6145                	addi	sp,sp,48
    800020c6:	8082                	ret

00000000800020c8 <wait>:
{
    800020c8:	715d                	addi	sp,sp,-80
    800020ca:	e486                	sd	ra,72(sp)
    800020cc:	e0a2                	sd	s0,64(sp)
    800020ce:	fc26                	sd	s1,56(sp)
    800020d0:	f84a                	sd	s2,48(sp)
    800020d2:	f44e                	sd	s3,40(sp)
    800020d4:	f052                	sd	s4,32(sp)
    800020d6:	ec56                	sd	s5,24(sp)
    800020d8:	e85a                	sd	s6,16(sp)
    800020da:	e45e                	sd	s7,8(sp)
    800020dc:	e062                	sd	s8,0(sp)
    800020de:	0880                	addi	s0,sp,80
    800020e0:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    800020e2:	00000097          	auipc	ra,0x0
    800020e6:	8b4080e7          	jalr	-1868(ra) # 80001996 <myproc>
    800020ea:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800020ec:	0000f517          	auipc	a0,0xf
    800020f0:	1cc50513          	addi	a0,a0,460 # 800112b8 <wait_lock>
    800020f4:	fffff097          	auipc	ra,0xfffff
    800020f8:	adc080e7          	jalr	-1316(ra) # 80000bd0 <acquire>
    havekids = 0;
    800020fc:	4b81                	li	s7,0
        if(np->state == ZOMBIE){
    800020fe:	4a15                	li	s4,5
        havekids = 1;
    80002100:	4a85                	li	s5,1
    for(np = proc; np < &proc[NPROC]; np++){
    80002102:	00015997          	auipc	s3,0x15
    80002106:	3ce98993          	addi	s3,s3,974 # 800174d0 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000210a:	0000fc17          	auipc	s8,0xf
    8000210e:	1aec0c13          	addi	s8,s8,430 # 800112b8 <wait_lock>
    havekids = 0;
    80002112:	875e                	mv	a4,s7
    for(np = proc; np < &proc[NPROC]; np++){
    80002114:	0000f497          	auipc	s1,0xf
    80002118:	5bc48493          	addi	s1,s1,1468 # 800116d0 <proc>
    8000211c:	a0bd                	j	8000218a <wait+0xc2>
          pid = np->pid;
    8000211e:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    80002122:	000b0e63          	beqz	s6,8000213e <wait+0x76>
    80002126:	4691                	li	a3,4
    80002128:	02c48613          	addi	a2,s1,44
    8000212c:	85da                	mv	a1,s6
    8000212e:	06093503          	ld	a0,96(s2)
    80002132:	fffff097          	auipc	ra,0xfffff
    80002136:	528080e7          	jalr	1320(ra) # 8000165a <copyout>
    8000213a:	02054563          	bltz	a0,80002164 <wait+0x9c>
          freeproc(np);
    8000213e:	8526                	mv	a0,s1
    80002140:	00000097          	auipc	ra,0x0
    80002144:	a08080e7          	jalr	-1528(ra) # 80001b48 <freeproc>
          release(&np->lock);
    80002148:	8526                	mv	a0,s1
    8000214a:	fffff097          	auipc	ra,0xfffff
    8000214e:	b3a080e7          	jalr	-1222(ra) # 80000c84 <release>
          release(&wait_lock);
    80002152:	0000f517          	auipc	a0,0xf
    80002156:	16650513          	addi	a0,a0,358 # 800112b8 <wait_lock>
    8000215a:	fffff097          	auipc	ra,0xfffff
    8000215e:	b2a080e7          	jalr	-1238(ra) # 80000c84 <release>
          return pid;
    80002162:	a09d                	j	800021c8 <wait+0x100>
            release(&np->lock);
    80002164:	8526                	mv	a0,s1
    80002166:	fffff097          	auipc	ra,0xfffff
    8000216a:	b1e080e7          	jalr	-1250(ra) # 80000c84 <release>
            release(&wait_lock);
    8000216e:	0000f517          	auipc	a0,0xf
    80002172:	14a50513          	addi	a0,a0,330 # 800112b8 <wait_lock>
    80002176:	fffff097          	auipc	ra,0xfffff
    8000217a:	b0e080e7          	jalr	-1266(ra) # 80000c84 <release>
            return -1;
    8000217e:	59fd                	li	s3,-1
    80002180:	a0a1                	j	800021c8 <wait+0x100>
    for(np = proc; np < &proc[NPROC]; np++){
    80002182:	17848493          	addi	s1,s1,376
    80002186:	03348463          	beq	s1,s3,800021ae <wait+0xe6>
      if(np->parent == p){
    8000218a:	64bc                	ld	a5,72(s1)
    8000218c:	ff279be3          	bne	a5,s2,80002182 <wait+0xba>
        acquire(&np->lock);
    80002190:	8526                	mv	a0,s1
    80002192:	fffff097          	auipc	ra,0xfffff
    80002196:	a3e080e7          	jalr	-1474(ra) # 80000bd0 <acquire>
        if(np->state == ZOMBIE){
    8000219a:	4c9c                	lw	a5,24(s1)
    8000219c:	f94781e3          	beq	a5,s4,8000211e <wait+0x56>
        release(&np->lock);
    800021a0:	8526                	mv	a0,s1
    800021a2:	fffff097          	auipc	ra,0xfffff
    800021a6:	ae2080e7          	jalr	-1310(ra) # 80000c84 <release>
        havekids = 1;
    800021aa:	8756                	mv	a4,s5
    800021ac:	bfd9                	j	80002182 <wait+0xba>
    if(!havekids || p->killed){
    800021ae:	c701                	beqz	a4,800021b6 <wait+0xee>
    800021b0:	02892783          	lw	a5,40(s2)
    800021b4:	c79d                	beqz	a5,800021e2 <wait+0x11a>
      release(&wait_lock);
    800021b6:	0000f517          	auipc	a0,0xf
    800021ba:	10250513          	addi	a0,a0,258 # 800112b8 <wait_lock>
    800021be:	fffff097          	auipc	ra,0xfffff
    800021c2:	ac6080e7          	jalr	-1338(ra) # 80000c84 <release>
      return -1;
    800021c6:	59fd                	li	s3,-1
}
    800021c8:	854e                	mv	a0,s3
    800021ca:	60a6                	ld	ra,72(sp)
    800021cc:	6406                	ld	s0,64(sp)
    800021ce:	74e2                	ld	s1,56(sp)
    800021d0:	7942                	ld	s2,48(sp)
    800021d2:	79a2                	ld	s3,40(sp)
    800021d4:	7a02                	ld	s4,32(sp)
    800021d6:	6ae2                	ld	s5,24(sp)
    800021d8:	6b42                	ld	s6,16(sp)
    800021da:	6ba2                	ld	s7,8(sp)
    800021dc:	6c02                	ld	s8,0(sp)
    800021de:	6161                	addi	sp,sp,80
    800021e0:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800021e2:	85e2                	mv	a1,s8
    800021e4:	854a                	mv	a0,s2
    800021e6:	00000097          	auipc	ra,0x0
    800021ea:	e7e080e7          	jalr	-386(ra) # 80002064 <sleep>
    havekids = 0;
    800021ee:	b715                	j	80002112 <wait+0x4a>

00000000800021f0 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800021f0:	7139                	addi	sp,sp,-64
    800021f2:	fc06                	sd	ra,56(sp)
    800021f4:	f822                	sd	s0,48(sp)
    800021f6:	f426                	sd	s1,40(sp)
    800021f8:	f04a                	sd	s2,32(sp)
    800021fa:	ec4e                	sd	s3,24(sp)
    800021fc:	e852                	sd	s4,16(sp)
    800021fe:	e456                	sd	s5,8(sp)
    80002200:	0080                	addi	s0,sp,64
    80002202:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80002204:	0000f497          	auipc	s1,0xf
    80002208:	4cc48493          	addi	s1,s1,1228 # 800116d0 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    8000220c:	4989                	li	s3,2
        p->state = RUNNABLE;
    8000220e:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    80002210:	00015917          	auipc	s2,0x15
    80002214:	2c090913          	addi	s2,s2,704 # 800174d0 <tickslock>
    80002218:	a811                	j	8000222c <wakeup+0x3c>
      }
      release(&p->lock);
    8000221a:	8526                	mv	a0,s1
    8000221c:	fffff097          	auipc	ra,0xfffff
    80002220:	a68080e7          	jalr	-1432(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002224:	17848493          	addi	s1,s1,376
    80002228:	03248663          	beq	s1,s2,80002254 <wakeup+0x64>
    if(p != myproc()){
    8000222c:	fffff097          	auipc	ra,0xfffff
    80002230:	76a080e7          	jalr	1898(ra) # 80001996 <myproc>
    80002234:	fea488e3          	beq	s1,a0,80002224 <wakeup+0x34>
      acquire(&p->lock);
    80002238:	8526                	mv	a0,s1
    8000223a:	fffff097          	auipc	ra,0xfffff
    8000223e:	996080e7          	jalr	-1642(ra) # 80000bd0 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80002242:	4c9c                	lw	a5,24(s1)
    80002244:	fd379be3          	bne	a5,s3,8000221a <wakeup+0x2a>
    80002248:	709c                	ld	a5,32(s1)
    8000224a:	fd4798e3          	bne	a5,s4,8000221a <wakeup+0x2a>
        p->state = RUNNABLE;
    8000224e:	0154ac23          	sw	s5,24(s1)
    80002252:	b7e1                	j	8000221a <wakeup+0x2a>
    }
  }
}
    80002254:	70e2                	ld	ra,56(sp)
    80002256:	7442                	ld	s0,48(sp)
    80002258:	74a2                	ld	s1,40(sp)
    8000225a:	7902                	ld	s2,32(sp)
    8000225c:	69e2                	ld	s3,24(sp)
    8000225e:	6a42                	ld	s4,16(sp)
    80002260:	6aa2                	ld	s5,8(sp)
    80002262:	6121                	addi	sp,sp,64
    80002264:	8082                	ret

0000000080002266 <reparent>:
{
    80002266:	7179                	addi	sp,sp,-48
    80002268:	f406                	sd	ra,40(sp)
    8000226a:	f022                	sd	s0,32(sp)
    8000226c:	ec26                	sd	s1,24(sp)
    8000226e:	e84a                	sd	s2,16(sp)
    80002270:	e44e                	sd	s3,8(sp)
    80002272:	e052                	sd	s4,0(sp)
    80002274:	1800                	addi	s0,sp,48
    80002276:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002278:	0000f497          	auipc	s1,0xf
    8000227c:	45848493          	addi	s1,s1,1112 # 800116d0 <proc>
      pp->parent = initproc;
    80002280:	00007a17          	auipc	s4,0x7
    80002284:	da8a0a13          	addi	s4,s4,-600 # 80009028 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002288:	00015997          	auipc	s3,0x15
    8000228c:	24898993          	addi	s3,s3,584 # 800174d0 <tickslock>
    80002290:	a029                	j	8000229a <reparent+0x34>
    80002292:	17848493          	addi	s1,s1,376
    80002296:	01348d63          	beq	s1,s3,800022b0 <reparent+0x4a>
    if(pp->parent == p){
    8000229a:	64bc                	ld	a5,72(s1)
    8000229c:	ff279be3          	bne	a5,s2,80002292 <reparent+0x2c>
      pp->parent = initproc;
    800022a0:	000a3503          	ld	a0,0(s4)
    800022a4:	e4a8                	sd	a0,72(s1)
      wakeup(initproc);
    800022a6:	00000097          	auipc	ra,0x0
    800022aa:	f4a080e7          	jalr	-182(ra) # 800021f0 <wakeup>
    800022ae:	b7d5                	j	80002292 <reparent+0x2c>
}
    800022b0:	70a2                	ld	ra,40(sp)
    800022b2:	7402                	ld	s0,32(sp)
    800022b4:	64e2                	ld	s1,24(sp)
    800022b6:	6942                	ld	s2,16(sp)
    800022b8:	69a2                	ld	s3,8(sp)
    800022ba:	6a02                	ld	s4,0(sp)
    800022bc:	6145                	addi	sp,sp,48
    800022be:	8082                	ret

00000000800022c0 <exit>:
{
    800022c0:	7179                	addi	sp,sp,-48
    800022c2:	f406                	sd	ra,40(sp)
    800022c4:	f022                	sd	s0,32(sp)
    800022c6:	ec26                	sd	s1,24(sp)
    800022c8:	e84a                	sd	s2,16(sp)
    800022ca:	e44e                	sd	s3,8(sp)
    800022cc:	e052                	sd	s4,0(sp)
    800022ce:	1800                	addi	s0,sp,48
    800022d0:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800022d2:	fffff097          	auipc	ra,0xfffff
    800022d6:	6c4080e7          	jalr	1732(ra) # 80001996 <myproc>
    800022da:	89aa                	mv	s3,a0
  if(p == initproc)
    800022dc:	00007797          	auipc	a5,0x7
    800022e0:	d4c7b783          	ld	a5,-692(a5) # 80009028 <initproc>
    800022e4:	0e050493          	addi	s1,a0,224
    800022e8:	16050913          	addi	s2,a0,352
    800022ec:	02a79363          	bne	a5,a0,80002312 <exit+0x52>
    panic("init exiting");
    800022f0:	00006517          	auipc	a0,0x6
    800022f4:	f7050513          	addi	a0,a0,-144 # 80008260 <digits+0x220>
    800022f8:	ffffe097          	auipc	ra,0xffffe
    800022fc:	242080e7          	jalr	578(ra) # 8000053a <panic>
      fileclose(f);
    80002300:	00002097          	auipc	ra,0x2
    80002304:	252080e7          	jalr	594(ra) # 80004552 <fileclose>
      p->ofile[fd] = 0;
    80002308:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    8000230c:	04a1                	addi	s1,s1,8
    8000230e:	01248563          	beq	s1,s2,80002318 <exit+0x58>
    if(p->ofile[fd]){
    80002312:	6088                	ld	a0,0(s1)
    80002314:	f575                	bnez	a0,80002300 <exit+0x40>
    80002316:	bfdd                	j	8000230c <exit+0x4c>
  begin_op();
    80002318:	00002097          	auipc	ra,0x2
    8000231c:	d72080e7          	jalr	-654(ra) # 8000408a <begin_op>
  iput(p->cwd);
    80002320:	1609b503          	ld	a0,352(s3)
    80002324:	00001097          	auipc	ra,0x1
    80002328:	544080e7          	jalr	1348(ra) # 80003868 <iput>
  end_op();
    8000232c:	00002097          	auipc	ra,0x2
    80002330:	ddc080e7          	jalr	-548(ra) # 80004108 <end_op>
  p->cwd = 0;
    80002334:	1609b023          	sd	zero,352(s3)
  acquire(&wait_lock);
    80002338:	0000f497          	auipc	s1,0xf
    8000233c:	f8048493          	addi	s1,s1,-128 # 800112b8 <wait_lock>
    80002340:	8526                	mv	a0,s1
    80002342:	fffff097          	auipc	ra,0xfffff
    80002346:	88e080e7          	jalr	-1906(ra) # 80000bd0 <acquire>
  reparent(p);
    8000234a:	854e                	mv	a0,s3
    8000234c:	00000097          	auipc	ra,0x0
    80002350:	f1a080e7          	jalr	-230(ra) # 80002266 <reparent>
  wakeup(p->parent);
    80002354:	0489b503          	ld	a0,72(s3)
    80002358:	00000097          	auipc	ra,0x0
    8000235c:	e98080e7          	jalr	-360(ra) # 800021f0 <wakeup>
  acquire(&p->lock);
    80002360:	854e                	mv	a0,s3
    80002362:	fffff097          	auipc	ra,0xfffff
    80002366:	86e080e7          	jalr	-1938(ra) # 80000bd0 <acquire>
  p->xstate = status;
    8000236a:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    8000236e:	4795                	li	a5,5
    80002370:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80002374:	8526                	mv	a0,s1
    80002376:	fffff097          	auipc	ra,0xfffff
    8000237a:	90e080e7          	jalr	-1778(ra) # 80000c84 <release>
  sched();
    8000237e:	00000097          	auipc	ra,0x0
    80002382:	bd4080e7          	jalr	-1068(ra) # 80001f52 <sched>
  panic("zombie exit");
    80002386:	00006517          	auipc	a0,0x6
    8000238a:	eea50513          	addi	a0,a0,-278 # 80008270 <digits+0x230>
    8000238e:	ffffe097          	auipc	ra,0xffffe
    80002392:	1ac080e7          	jalr	428(ra) # 8000053a <panic>

0000000080002396 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80002396:	7179                	addi	sp,sp,-48
    80002398:	f406                	sd	ra,40(sp)
    8000239a:	f022                	sd	s0,32(sp)
    8000239c:	ec26                	sd	s1,24(sp)
    8000239e:	e84a                	sd	s2,16(sp)
    800023a0:	e44e                	sd	s3,8(sp)
    800023a2:	1800                	addi	s0,sp,48
    800023a4:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800023a6:	0000f497          	auipc	s1,0xf
    800023aa:	32a48493          	addi	s1,s1,810 # 800116d0 <proc>
    800023ae:	00015997          	auipc	s3,0x15
    800023b2:	12298993          	addi	s3,s3,290 # 800174d0 <tickslock>
    acquire(&p->lock);
    800023b6:	8526                	mv	a0,s1
    800023b8:	fffff097          	auipc	ra,0xfffff
    800023bc:	818080e7          	jalr	-2024(ra) # 80000bd0 <acquire>
    if(p->pid == pid){
    800023c0:	589c                	lw	a5,48(s1)
    800023c2:	01278d63          	beq	a5,s2,800023dc <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800023c6:	8526                	mv	a0,s1
    800023c8:	fffff097          	auipc	ra,0xfffff
    800023cc:	8bc080e7          	jalr	-1860(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800023d0:	17848493          	addi	s1,s1,376
    800023d4:	ff3491e3          	bne	s1,s3,800023b6 <kill+0x20>
  }
  return -1;
    800023d8:	557d                	li	a0,-1
    800023da:	a829                	j	800023f4 <kill+0x5e>
      p->killed = 1;
    800023dc:	4785                	li	a5,1
    800023de:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    800023e0:	4c98                	lw	a4,24(s1)
    800023e2:	4789                	li	a5,2
    800023e4:	00f70f63          	beq	a4,a5,80002402 <kill+0x6c>
      release(&p->lock);
    800023e8:	8526                	mv	a0,s1
    800023ea:	fffff097          	auipc	ra,0xfffff
    800023ee:	89a080e7          	jalr	-1894(ra) # 80000c84 <release>
      return 0;
    800023f2:	4501                	li	a0,0
}
    800023f4:	70a2                	ld	ra,40(sp)
    800023f6:	7402                	ld	s0,32(sp)
    800023f8:	64e2                	ld	s1,24(sp)
    800023fa:	6942                	ld	s2,16(sp)
    800023fc:	69a2                	ld	s3,8(sp)
    800023fe:	6145                	addi	sp,sp,48
    80002400:	8082                	ret
        p->state = RUNNABLE;
    80002402:	478d                	li	a5,3
    80002404:	cc9c                	sw	a5,24(s1)
    80002406:	b7cd                	j	800023e8 <kill+0x52>

0000000080002408 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80002408:	7179                	addi	sp,sp,-48
    8000240a:	f406                	sd	ra,40(sp)
    8000240c:	f022                	sd	s0,32(sp)
    8000240e:	ec26                	sd	s1,24(sp)
    80002410:	e84a                	sd	s2,16(sp)
    80002412:	e44e                	sd	s3,8(sp)
    80002414:	e052                	sd	s4,0(sp)
    80002416:	1800                	addi	s0,sp,48
    80002418:	84aa                	mv	s1,a0
    8000241a:	892e                	mv	s2,a1
    8000241c:	89b2                	mv	s3,a2
    8000241e:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80002420:	fffff097          	auipc	ra,0xfffff
    80002424:	576080e7          	jalr	1398(ra) # 80001996 <myproc>
  if(user_dst){
    80002428:	c08d                	beqz	s1,8000244a <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    8000242a:	86d2                	mv	a3,s4
    8000242c:	864e                	mv	a2,s3
    8000242e:	85ca                	mv	a1,s2
    80002430:	7128                	ld	a0,96(a0)
    80002432:	fffff097          	auipc	ra,0xfffff
    80002436:	228080e7          	jalr	552(ra) # 8000165a <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    8000243a:	70a2                	ld	ra,40(sp)
    8000243c:	7402                	ld	s0,32(sp)
    8000243e:	64e2                	ld	s1,24(sp)
    80002440:	6942                	ld	s2,16(sp)
    80002442:	69a2                	ld	s3,8(sp)
    80002444:	6a02                	ld	s4,0(sp)
    80002446:	6145                	addi	sp,sp,48
    80002448:	8082                	ret
    memmove((char *)dst, src, len);
    8000244a:	000a061b          	sext.w	a2,s4
    8000244e:	85ce                	mv	a1,s3
    80002450:	854a                	mv	a0,s2
    80002452:	fffff097          	auipc	ra,0xfffff
    80002456:	8d6080e7          	jalr	-1834(ra) # 80000d28 <memmove>
    return 0;
    8000245a:	8526                	mv	a0,s1
    8000245c:	bff9                	j	8000243a <either_copyout+0x32>

000000008000245e <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    8000245e:	7179                	addi	sp,sp,-48
    80002460:	f406                	sd	ra,40(sp)
    80002462:	f022                	sd	s0,32(sp)
    80002464:	ec26                	sd	s1,24(sp)
    80002466:	e84a                	sd	s2,16(sp)
    80002468:	e44e                	sd	s3,8(sp)
    8000246a:	e052                	sd	s4,0(sp)
    8000246c:	1800                	addi	s0,sp,48
    8000246e:	892a                	mv	s2,a0
    80002470:	84ae                	mv	s1,a1
    80002472:	89b2                	mv	s3,a2
    80002474:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80002476:	fffff097          	auipc	ra,0xfffff
    8000247a:	520080e7          	jalr	1312(ra) # 80001996 <myproc>
  if(user_src){
    8000247e:	c08d                	beqz	s1,800024a0 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80002480:	86d2                	mv	a3,s4
    80002482:	864e                	mv	a2,s3
    80002484:	85ca                	mv	a1,s2
    80002486:	7128                	ld	a0,96(a0)
    80002488:	fffff097          	auipc	ra,0xfffff
    8000248c:	25e080e7          	jalr	606(ra) # 800016e6 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80002490:	70a2                	ld	ra,40(sp)
    80002492:	7402                	ld	s0,32(sp)
    80002494:	64e2                	ld	s1,24(sp)
    80002496:	6942                	ld	s2,16(sp)
    80002498:	69a2                	ld	s3,8(sp)
    8000249a:	6a02                	ld	s4,0(sp)
    8000249c:	6145                	addi	sp,sp,48
    8000249e:	8082                	ret
    memmove(dst, (char*)src, len);
    800024a0:	000a061b          	sext.w	a2,s4
    800024a4:	85ce                	mv	a1,s3
    800024a6:	854a                	mv	a0,s2
    800024a8:	fffff097          	auipc	ra,0xfffff
    800024ac:	880080e7          	jalr	-1920(ra) # 80000d28 <memmove>
    return 0;
    800024b0:	8526                	mv	a0,s1
    800024b2:	bff9                	j	80002490 <either_copyin+0x32>

00000000800024b4 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800024b4:	715d                	addi	sp,sp,-80
    800024b6:	e486                	sd	ra,72(sp)
    800024b8:	e0a2                	sd	s0,64(sp)
    800024ba:	fc26                	sd	s1,56(sp)
    800024bc:	f84a                	sd	s2,48(sp)
    800024be:	f44e                	sd	s3,40(sp)
    800024c0:	f052                	sd	s4,32(sp)
    800024c2:	ec56                	sd	s5,24(sp)
    800024c4:	e85a                	sd	s6,16(sp)
    800024c6:	e45e                	sd	s7,8(sp)
    800024c8:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    800024ca:	00006517          	auipc	a0,0x6
    800024ce:	bfe50513          	addi	a0,a0,-1026 # 800080c8 <digits+0x88>
    800024d2:	ffffe097          	auipc	ra,0xffffe
    800024d6:	0b2080e7          	jalr	178(ra) # 80000584 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800024da:	0000f497          	auipc	s1,0xf
    800024de:	35e48493          	addi	s1,s1,862 # 80011838 <proc+0x168>
    800024e2:	00015917          	auipc	s2,0x15
    800024e6:	15690913          	addi	s2,s2,342 # 80017638 <bcache+0x150>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800024ea:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    800024ec:	00006997          	auipc	s3,0x6
    800024f0:	d9498993          	addi	s3,s3,-620 # 80008280 <digits+0x240>
    printf("%d %s %s", p->pid, state, p->name);
    800024f4:	00006a97          	auipc	s5,0x6
    800024f8:	d94a8a93          	addi	s5,s5,-620 # 80008288 <digits+0x248>
    printf("\n");
    800024fc:	00006a17          	auipc	s4,0x6
    80002500:	bcca0a13          	addi	s4,s4,-1076 # 800080c8 <digits+0x88>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002504:	00006b97          	auipc	s7,0x6
    80002508:	dbcb8b93          	addi	s7,s7,-580 # 800082c0 <states.0>
    8000250c:	a00d                	j	8000252e <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    8000250e:	ec86a583          	lw	a1,-312(a3)
    80002512:	8556                	mv	a0,s5
    80002514:	ffffe097          	auipc	ra,0xffffe
    80002518:	070080e7          	jalr	112(ra) # 80000584 <printf>
    printf("\n");
    8000251c:	8552                	mv	a0,s4
    8000251e:	ffffe097          	auipc	ra,0xffffe
    80002522:	066080e7          	jalr	102(ra) # 80000584 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80002526:	17848493          	addi	s1,s1,376
    8000252a:	03248263          	beq	s1,s2,8000254e <procdump+0x9a>
    if(p->state == UNUSED)
    8000252e:	86a6                	mv	a3,s1
    80002530:	eb04a783          	lw	a5,-336(s1)
    80002534:	dbed                	beqz	a5,80002526 <procdump+0x72>
      state = "???";
    80002536:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002538:	fcfb6be3          	bltu	s6,a5,8000250e <procdump+0x5a>
    8000253c:	02079713          	slli	a4,a5,0x20
    80002540:	01d75793          	srli	a5,a4,0x1d
    80002544:	97de                	add	a5,a5,s7
    80002546:	6390                	ld	a2,0(a5)
    80002548:	f279                	bnez	a2,8000250e <procdump+0x5a>
      state = "???";
    8000254a:	864e                	mv	a2,s3
    8000254c:	b7c9                	j	8000250e <procdump+0x5a>
  }
}
    8000254e:	60a6                	ld	ra,72(sp)
    80002550:	6406                	ld	s0,64(sp)
    80002552:	74e2                	ld	s1,56(sp)
    80002554:	7942                	ld	s2,48(sp)
    80002556:	79a2                	ld	s3,40(sp)
    80002558:	7a02                	ld	s4,32(sp)
    8000255a:	6ae2                	ld	s5,24(sp)
    8000255c:	6b42                	ld	s6,16(sp)
    8000255e:	6ba2                	ld	s7,8(sp)
    80002560:	6161                	addi	sp,sp,80
    80002562:	8082                	ret

0000000080002564 <getpinfo>:


int 
getpinfo (uint64  addr){
    80002564:	715d                	addi	sp,sp,-80
    80002566:	e486                	sd	ra,72(sp)
    80002568:	e0a2                	sd	s0,64(sp)
    8000256a:	fc26                	sd	s1,56(sp)
    8000256c:	f84a                	sd	s2,48(sp)
    8000256e:	f44e                	sd	s3,40(sp)
    80002570:	f052                	sd	s4,32(sp)
    80002572:	ec56                	sd	s5,24(sp)
    80002574:	0880                	addi	s0,sp,80
    80002576:	81010113          	addi	sp,sp,-2032
    8000257a:	8aaa                	mv	s5,a0
  struct proc *p;
  struct pstat ps;
  uint64 counter = 0;


  for(p = proc; p < &proc[NPROC]; p++) {
    8000257c:	77fd                	lui	a5,0xfffff
    8000257e:	7c078793          	addi	a5,a5,1984 # fffffffffffff7c0 <end+0xffffffff7ffd97c0>
    80002582:	00f40933          	add	s2,s0,a5
    80002586:	0000f497          	auipc	s1,0xf
    8000258a:	14a48493          	addi	s1,s1,330 # 800116d0 <proc>
      acquire(&p->lock);
      if(p->state != UNUSED) {
        ps.inuse[counter] = 1;
    8000258e:	4a05                	li	s4,1
  for(p = proc; p < &proc[NPROC]; p++) {
    80002590:	00015997          	auipc	s3,0x15
    80002594:	f4098993          	addi	s3,s3,-192 # 800174d0 <tickslock>
    80002598:	a819                	j	800025ae <getpinfo+0x4a>
        ps.pid[counter] = p->pid;
        ps.hticks[counter] = p->hticks;
        ps.lticks[counter] = p->lticks; 
      }
      counter++;
      release(&p->lock);
    8000259a:	8526                	mv	a0,s1
    8000259c:	ffffe097          	auipc	ra,0xffffe
    800025a0:	6e8080e7          	jalr	1768(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800025a4:	17848493          	addi	s1,s1,376
    800025a8:	0921                	addi	s2,s2,8
    800025aa:	03348563          	beq	s1,s3,800025d4 <getpinfo+0x70>
      acquire(&p->lock);
    800025ae:	8526                	mv	a0,s1
    800025b0:	ffffe097          	auipc	ra,0xffffe
    800025b4:	620080e7          	jalr	1568(ra) # 80000bd0 <acquire>
      if(p->state != UNUSED) {
    800025b8:	4c9c                	lw	a5,24(s1)
    800025ba:	d3e5                	beqz	a5,8000259a <getpinfo+0x36>
        ps.inuse[counter] = 1;
    800025bc:	01493023          	sd	s4,0(s2)
        ps.pid[counter] = p->pid;
    800025c0:	589c                	lw	a5,48(s1)
    800025c2:	20f93023          	sd	a5,512(s2)
        ps.hticks[counter] = p->hticks;
    800025c6:	7c9c                	ld	a5,56(s1)
    800025c8:	40f93023          	sd	a5,1024(s2)
        ps.lticks[counter] = p->lticks; 
    800025cc:	60bc                	ld	a5,64(s1)
    800025ce:	60f93023          	sd	a5,1536(s2)
    800025d2:	b7e1                	j	8000259a <getpinfo+0x36>
    }

    p = myproc(); //calling process
    800025d4:	fffff097          	auipc	ra,0xfffff
    800025d8:	3c2080e7          	jalr	962(ra) # 80001996 <myproc>

    //la estuctura que hemos completado, se copiará desde la tabla de paginas del proceso a la estructura pstat que ha inicializado
    if (copyout (p->pagetable, addr, (char *)&ps, sizeof (ps)) < 0){
    800025dc:	6685                	lui	a3,0x1
    800025de:	80068693          	addi	a3,a3,-2048 # 800 <_entry-0x7ffff800>
    800025e2:	77fd                	lui	a5,0xfffff
    800025e4:	7c078793          	addi	a5,a5,1984 # fffffffffffff7c0 <end+0xffffffff7ffd97c0>
    800025e8:	00f40633          	add	a2,s0,a5
    800025ec:	85d6                	mv	a1,s5
    800025ee:	7128                	ld	a0,96(a0)
    800025f0:	fffff097          	auipc	ra,0xfffff
    800025f4:	06a080e7          	jalr	106(ra) # 8000165a <copyout>
      return -1;
    }

  return 0;
}
    800025f8:	41f5551b          	sraiw	a0,a0,0x1f
    800025fc:	7f010113          	addi	sp,sp,2032
    80002600:	60a6                	ld	ra,72(sp)
    80002602:	6406                	ld	s0,64(sp)
    80002604:	74e2                	ld	s1,56(sp)
    80002606:	7942                	ld	s2,48(sp)
    80002608:	79a2                	ld	s3,40(sp)
    8000260a:	7a02                	ld	s4,32(sp)
    8000260c:	6ae2                	ld	s5,24(sp)
    8000260e:	6161                	addi	sp,sp,80
    80002610:	8082                	ret

0000000080002612 <swtch>:
    80002612:	00153023          	sd	ra,0(a0)
    80002616:	00253423          	sd	sp,8(a0)
    8000261a:	e900                	sd	s0,16(a0)
    8000261c:	ed04                	sd	s1,24(a0)
    8000261e:	03253023          	sd	s2,32(a0)
    80002622:	03353423          	sd	s3,40(a0)
    80002626:	03453823          	sd	s4,48(a0)
    8000262a:	03553c23          	sd	s5,56(a0)
    8000262e:	05653023          	sd	s6,64(a0)
    80002632:	05753423          	sd	s7,72(a0)
    80002636:	05853823          	sd	s8,80(a0)
    8000263a:	05953c23          	sd	s9,88(a0)
    8000263e:	07a53023          	sd	s10,96(a0)
    80002642:	07b53423          	sd	s11,104(a0)
    80002646:	0005b083          	ld	ra,0(a1)
    8000264a:	0085b103          	ld	sp,8(a1)
    8000264e:	6980                	ld	s0,16(a1)
    80002650:	6d84                	ld	s1,24(a1)
    80002652:	0205b903          	ld	s2,32(a1)
    80002656:	0285b983          	ld	s3,40(a1)
    8000265a:	0305ba03          	ld	s4,48(a1)
    8000265e:	0385ba83          	ld	s5,56(a1)
    80002662:	0405bb03          	ld	s6,64(a1)
    80002666:	0485bb83          	ld	s7,72(a1)
    8000266a:	0505bc03          	ld	s8,80(a1)
    8000266e:	0585bc83          	ld	s9,88(a1)
    80002672:	0605bd03          	ld	s10,96(a1)
    80002676:	0685bd83          	ld	s11,104(a1)
    8000267a:	8082                	ret

000000008000267c <trapinit>:

extern int devintr();

void
trapinit(void)
{
    8000267c:	1141                	addi	sp,sp,-16
    8000267e:	e406                	sd	ra,8(sp)
    80002680:	e022                	sd	s0,0(sp)
    80002682:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80002684:	00006597          	auipc	a1,0x6
    80002688:	c6c58593          	addi	a1,a1,-916 # 800082f0 <states.0+0x30>
    8000268c:	00015517          	auipc	a0,0x15
    80002690:	e4450513          	addi	a0,a0,-444 # 800174d0 <tickslock>
    80002694:	ffffe097          	auipc	ra,0xffffe
    80002698:	4ac080e7          	jalr	1196(ra) # 80000b40 <initlock>
}
    8000269c:	60a2                	ld	ra,8(sp)
    8000269e:	6402                	ld	s0,0(sp)
    800026a0:	0141                	addi	sp,sp,16
    800026a2:	8082                	ret

00000000800026a4 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    800026a4:	1141                	addi	sp,sp,-16
    800026a6:	e422                	sd	s0,8(sp)
    800026a8:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    800026aa:	00003797          	auipc	a5,0x3
    800026ae:	4d678793          	addi	a5,a5,1238 # 80005b80 <kernelvec>
    800026b2:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    800026b6:	6422                	ld	s0,8(sp)
    800026b8:	0141                	addi	sp,sp,16
    800026ba:	8082                	ret

00000000800026bc <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    800026bc:	1141                	addi	sp,sp,-16
    800026be:	e406                	sd	ra,8(sp)
    800026c0:	e022                	sd	s0,0(sp)
    800026c2:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    800026c4:	fffff097          	auipc	ra,0xfffff
    800026c8:	2d2080e7          	jalr	722(ra) # 80001996 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800026cc:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800026d0:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800026d2:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    800026d6:	00005697          	auipc	a3,0x5
    800026da:	92a68693          	addi	a3,a3,-1750 # 80007000 <_trampoline>
    800026de:	00005717          	auipc	a4,0x5
    800026e2:	92270713          	addi	a4,a4,-1758 # 80007000 <_trampoline>
    800026e6:	8f15                	sub	a4,a4,a3
    800026e8:	040007b7          	lui	a5,0x4000
    800026ec:	17fd                	addi	a5,a5,-1
    800026ee:	07b2                	slli	a5,a5,0xc
    800026f0:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    800026f2:	10571073          	csrw	stvec,a4

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    800026f6:	7538                	ld	a4,104(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    800026f8:	18002673          	csrr	a2,satp
    800026fc:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    800026fe:	7530                	ld	a2,104(a0)
    80002700:	6938                	ld	a4,80(a0)
    80002702:	6585                	lui	a1,0x1
    80002704:	972e                	add	a4,a4,a1
    80002706:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80002708:	7538                	ld	a4,104(a0)
    8000270a:	00000617          	auipc	a2,0x0
    8000270e:	13860613          	addi	a2,a2,312 # 80002842 <usertrap>
    80002712:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80002714:	7538                	ld	a4,104(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80002716:	8612                	mv	a2,tp
    80002718:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000271a:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    8000271e:	eff77713          	andi	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80002722:	02076713          	ori	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002726:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    8000272a:	7538                	ld	a4,104(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    8000272c:	6f18                	ld	a4,24(a4)
    8000272e:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80002732:	712c                	ld	a1,96(a0)
    80002734:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80002736:	00005717          	auipc	a4,0x5
    8000273a:	95a70713          	addi	a4,a4,-1702 # 80007090 <userret>
    8000273e:	8f15                	sub	a4,a4,a3
    80002740:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80002742:	577d                	li	a4,-1
    80002744:	177e                	slli	a4,a4,0x3f
    80002746:	8dd9                	or	a1,a1,a4
    80002748:	02000537          	lui	a0,0x2000
    8000274c:	157d                	addi	a0,a0,-1
    8000274e:	0536                	slli	a0,a0,0xd
    80002750:	9782                	jalr	a5
}
    80002752:	60a2                	ld	ra,8(sp)
    80002754:	6402                	ld	s0,0(sp)
    80002756:	0141                	addi	sp,sp,16
    80002758:	8082                	ret

000000008000275a <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    8000275a:	1101                	addi	sp,sp,-32
    8000275c:	ec06                	sd	ra,24(sp)
    8000275e:	e822                	sd	s0,16(sp)
    80002760:	e426                	sd	s1,8(sp)
    80002762:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80002764:	00015497          	auipc	s1,0x15
    80002768:	d6c48493          	addi	s1,s1,-660 # 800174d0 <tickslock>
    8000276c:	8526                	mv	a0,s1
    8000276e:	ffffe097          	auipc	ra,0xffffe
    80002772:	462080e7          	jalr	1122(ra) # 80000bd0 <acquire>
  ticks++;
    80002776:	00007517          	auipc	a0,0x7
    8000277a:	8ba50513          	addi	a0,a0,-1862 # 80009030 <ticks>
    8000277e:	411c                	lw	a5,0(a0)
    80002780:	2785                	addiw	a5,a5,1
    80002782:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80002784:	00000097          	auipc	ra,0x0
    80002788:	a6c080e7          	jalr	-1428(ra) # 800021f0 <wakeup>
  release(&tickslock);
    8000278c:	8526                	mv	a0,s1
    8000278e:	ffffe097          	auipc	ra,0xffffe
    80002792:	4f6080e7          	jalr	1270(ra) # 80000c84 <release>
}
    80002796:	60e2                	ld	ra,24(sp)
    80002798:	6442                	ld	s0,16(sp)
    8000279a:	64a2                	ld	s1,8(sp)
    8000279c:	6105                	addi	sp,sp,32
    8000279e:	8082                	ret

00000000800027a0 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    800027a0:	1101                	addi	sp,sp,-32
    800027a2:	ec06                	sd	ra,24(sp)
    800027a4:	e822                	sd	s0,16(sp)
    800027a6:	e426                	sd	s1,8(sp)
    800027a8:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    800027aa:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    800027ae:	00074d63          	bltz	a4,800027c8 <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    800027b2:	57fd                	li	a5,-1
    800027b4:	17fe                	slli	a5,a5,0x3f
    800027b6:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    800027b8:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    800027ba:	06f70363          	beq	a4,a5,80002820 <devintr+0x80>
  }
}
    800027be:	60e2                	ld	ra,24(sp)
    800027c0:	6442                	ld	s0,16(sp)
    800027c2:	64a2                	ld	s1,8(sp)
    800027c4:	6105                	addi	sp,sp,32
    800027c6:	8082                	ret
     (scause & 0xff) == 9){
    800027c8:	0ff77793          	zext.b	a5,a4
  if((scause & 0x8000000000000000L) &&
    800027cc:	46a5                	li	a3,9
    800027ce:	fed792e3          	bne	a5,a3,800027b2 <devintr+0x12>
    int irq = plic_claim();
    800027d2:	00003097          	auipc	ra,0x3
    800027d6:	4b6080e7          	jalr	1206(ra) # 80005c88 <plic_claim>
    800027da:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    800027dc:	47a9                	li	a5,10
    800027de:	02f50763          	beq	a0,a5,8000280c <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    800027e2:	4785                	li	a5,1
    800027e4:	02f50963          	beq	a0,a5,80002816 <devintr+0x76>
    return 1;
    800027e8:	4505                	li	a0,1
    } else if(irq){
    800027ea:	d8f1                	beqz	s1,800027be <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    800027ec:	85a6                	mv	a1,s1
    800027ee:	00006517          	auipc	a0,0x6
    800027f2:	b0a50513          	addi	a0,a0,-1270 # 800082f8 <states.0+0x38>
    800027f6:	ffffe097          	auipc	ra,0xffffe
    800027fa:	d8e080e7          	jalr	-626(ra) # 80000584 <printf>
      plic_complete(irq);
    800027fe:	8526                	mv	a0,s1
    80002800:	00003097          	auipc	ra,0x3
    80002804:	4ac080e7          	jalr	1196(ra) # 80005cac <plic_complete>
    return 1;
    80002808:	4505                	li	a0,1
    8000280a:	bf55                	j	800027be <devintr+0x1e>
      uartintr();
    8000280c:	ffffe097          	auipc	ra,0xffffe
    80002810:	186080e7          	jalr	390(ra) # 80000992 <uartintr>
    80002814:	b7ed                	j	800027fe <devintr+0x5e>
      virtio_disk_intr();
    80002816:	00004097          	auipc	ra,0x4
    8000281a:	922080e7          	jalr	-1758(ra) # 80006138 <virtio_disk_intr>
    8000281e:	b7c5                	j	800027fe <devintr+0x5e>
    if(cpuid() == 0){
    80002820:	fffff097          	auipc	ra,0xfffff
    80002824:	14a080e7          	jalr	330(ra) # 8000196a <cpuid>
    80002828:	c901                	beqz	a0,80002838 <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    8000282a:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    8000282e:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80002830:	14479073          	csrw	sip,a5
    return 2;
    80002834:	4509                	li	a0,2
    80002836:	b761                	j	800027be <devintr+0x1e>
      clockintr();
    80002838:	00000097          	auipc	ra,0x0
    8000283c:	f22080e7          	jalr	-222(ra) # 8000275a <clockintr>
    80002840:	b7ed                	j	8000282a <devintr+0x8a>

0000000080002842 <usertrap>:
{
    80002842:	1101                	addi	sp,sp,-32
    80002844:	ec06                	sd	ra,24(sp)
    80002846:	e822                	sd	s0,16(sp)
    80002848:	e426                	sd	s1,8(sp)
    8000284a:	e04a                	sd	s2,0(sp)
    8000284c:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000284e:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80002852:	1007f793          	andi	a5,a5,256
    80002856:	e3ad                	bnez	a5,800028b8 <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002858:	00003797          	auipc	a5,0x3
    8000285c:	32878793          	addi	a5,a5,808 # 80005b80 <kernelvec>
    80002860:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80002864:	fffff097          	auipc	ra,0xfffff
    80002868:	132080e7          	jalr	306(ra) # 80001996 <myproc>
    8000286c:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    8000286e:	753c                	ld	a5,104(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002870:	14102773          	csrr	a4,sepc
    80002874:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002876:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    8000287a:	47a1                	li	a5,8
    8000287c:	04f71c63          	bne	a4,a5,800028d4 <usertrap+0x92>
    if(p->killed)
    80002880:	551c                	lw	a5,40(a0)
    80002882:	e3b9                	bnez	a5,800028c8 <usertrap+0x86>
    p->trapframe->epc += 4;
    80002884:	74b8                	ld	a4,104(s1)
    80002886:	6f1c                	ld	a5,24(a4)
    80002888:	0791                	addi	a5,a5,4
    8000288a:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000288c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002890:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002894:	10079073          	csrw	sstatus,a5
    syscall();
    80002898:	00000097          	auipc	ra,0x0
    8000289c:	2e0080e7          	jalr	736(ra) # 80002b78 <syscall>
  if(p->killed)
    800028a0:	549c                	lw	a5,40(s1)
    800028a2:	ebc1                	bnez	a5,80002932 <usertrap+0xf0>
  usertrapret();
    800028a4:	00000097          	auipc	ra,0x0
    800028a8:	e18080e7          	jalr	-488(ra) # 800026bc <usertrapret>
}
    800028ac:	60e2                	ld	ra,24(sp)
    800028ae:	6442                	ld	s0,16(sp)
    800028b0:	64a2                	ld	s1,8(sp)
    800028b2:	6902                	ld	s2,0(sp)
    800028b4:	6105                	addi	sp,sp,32
    800028b6:	8082                	ret
    panic("usertrap: not from user mode");
    800028b8:	00006517          	auipc	a0,0x6
    800028bc:	a6050513          	addi	a0,a0,-1440 # 80008318 <states.0+0x58>
    800028c0:	ffffe097          	auipc	ra,0xffffe
    800028c4:	c7a080e7          	jalr	-902(ra) # 8000053a <panic>
      exit(-1);
    800028c8:	557d                	li	a0,-1
    800028ca:	00000097          	auipc	ra,0x0
    800028ce:	9f6080e7          	jalr	-1546(ra) # 800022c0 <exit>
    800028d2:	bf4d                	j	80002884 <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    800028d4:	00000097          	auipc	ra,0x0
    800028d8:	ecc080e7          	jalr	-308(ra) # 800027a0 <devintr>
    800028dc:	892a                	mv	s2,a0
    800028de:	c501                	beqz	a0,800028e6 <usertrap+0xa4>
  if(p->killed)
    800028e0:	549c                	lw	a5,40(s1)
    800028e2:	c3a1                	beqz	a5,80002922 <usertrap+0xe0>
    800028e4:	a815                	j	80002918 <usertrap+0xd6>
  asm volatile("csrr %0, scause" : "=r" (x) );
    800028e6:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    800028ea:	5890                	lw	a2,48(s1)
    800028ec:	00006517          	auipc	a0,0x6
    800028f0:	a4c50513          	addi	a0,a0,-1460 # 80008338 <states.0+0x78>
    800028f4:	ffffe097          	auipc	ra,0xffffe
    800028f8:	c90080e7          	jalr	-880(ra) # 80000584 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800028fc:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002900:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002904:	00006517          	auipc	a0,0x6
    80002908:	a6450513          	addi	a0,a0,-1436 # 80008368 <states.0+0xa8>
    8000290c:	ffffe097          	auipc	ra,0xffffe
    80002910:	c78080e7          	jalr	-904(ra) # 80000584 <printf>
    p->killed = 1;
    80002914:	4785                	li	a5,1
    80002916:	d49c                	sw	a5,40(s1)
    exit(-1);
    80002918:	557d                	li	a0,-1
    8000291a:	00000097          	auipc	ra,0x0
    8000291e:	9a6080e7          	jalr	-1626(ra) # 800022c0 <exit>
  if(which_dev == 2)
    80002922:	4789                	li	a5,2
    80002924:	f8f910e3          	bne	s2,a5,800028a4 <usertrap+0x62>
    yield();
    80002928:	fffff097          	auipc	ra,0xfffff
    8000292c:	700080e7          	jalr	1792(ra) # 80002028 <yield>
    80002930:	bf95                	j	800028a4 <usertrap+0x62>
  int which_dev = 0;
    80002932:	4901                	li	s2,0
    80002934:	b7d5                	j	80002918 <usertrap+0xd6>

0000000080002936 <kerneltrap>:
{
    80002936:	7179                	addi	sp,sp,-48
    80002938:	f406                	sd	ra,40(sp)
    8000293a:	f022                	sd	s0,32(sp)
    8000293c:	ec26                	sd	s1,24(sp)
    8000293e:	e84a                	sd	s2,16(sp)
    80002940:	e44e                	sd	s3,8(sp)
    80002942:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002944:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002948:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000294c:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80002950:	1004f793          	andi	a5,s1,256
    80002954:	cb85                	beqz	a5,80002984 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002956:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000295a:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    8000295c:	ef85                	bnez	a5,80002994 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    8000295e:	00000097          	auipc	ra,0x0
    80002962:	e42080e7          	jalr	-446(ra) # 800027a0 <devintr>
    80002966:	cd1d                	beqz	a0,800029a4 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002968:	4789                	li	a5,2
    8000296a:	06f50a63          	beq	a0,a5,800029de <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    8000296e:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002972:	10049073          	csrw	sstatus,s1
}
    80002976:	70a2                	ld	ra,40(sp)
    80002978:	7402                	ld	s0,32(sp)
    8000297a:	64e2                	ld	s1,24(sp)
    8000297c:	6942                	ld	s2,16(sp)
    8000297e:	69a2                	ld	s3,8(sp)
    80002980:	6145                	addi	sp,sp,48
    80002982:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80002984:	00006517          	auipc	a0,0x6
    80002988:	a0450513          	addi	a0,a0,-1532 # 80008388 <states.0+0xc8>
    8000298c:	ffffe097          	auipc	ra,0xffffe
    80002990:	bae080e7          	jalr	-1106(ra) # 8000053a <panic>
    panic("kerneltrap: interrupts enabled");
    80002994:	00006517          	auipc	a0,0x6
    80002998:	a1c50513          	addi	a0,a0,-1508 # 800083b0 <states.0+0xf0>
    8000299c:	ffffe097          	auipc	ra,0xffffe
    800029a0:	b9e080e7          	jalr	-1122(ra) # 8000053a <panic>
    printf("scause %p\n", scause);
    800029a4:	85ce                	mv	a1,s3
    800029a6:	00006517          	auipc	a0,0x6
    800029aa:	a2a50513          	addi	a0,a0,-1494 # 800083d0 <states.0+0x110>
    800029ae:	ffffe097          	auipc	ra,0xffffe
    800029b2:	bd6080e7          	jalr	-1066(ra) # 80000584 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800029b6:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    800029ba:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    800029be:	00006517          	auipc	a0,0x6
    800029c2:	a2250513          	addi	a0,a0,-1502 # 800083e0 <states.0+0x120>
    800029c6:	ffffe097          	auipc	ra,0xffffe
    800029ca:	bbe080e7          	jalr	-1090(ra) # 80000584 <printf>
    panic("kerneltrap");
    800029ce:	00006517          	auipc	a0,0x6
    800029d2:	a2a50513          	addi	a0,a0,-1494 # 800083f8 <states.0+0x138>
    800029d6:	ffffe097          	auipc	ra,0xffffe
    800029da:	b64080e7          	jalr	-1180(ra) # 8000053a <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    800029de:	fffff097          	auipc	ra,0xfffff
    800029e2:	fb8080e7          	jalr	-72(ra) # 80001996 <myproc>
    800029e6:	d541                	beqz	a0,8000296e <kerneltrap+0x38>
    800029e8:	fffff097          	auipc	ra,0xfffff
    800029ec:	fae080e7          	jalr	-82(ra) # 80001996 <myproc>
    800029f0:	4d18                	lw	a4,24(a0)
    800029f2:	4791                	li	a5,4
    800029f4:	f6f71de3          	bne	a4,a5,8000296e <kerneltrap+0x38>
    yield();
    800029f8:	fffff097          	auipc	ra,0xfffff
    800029fc:	630080e7          	jalr	1584(ra) # 80002028 <yield>
    80002a00:	b7bd                	j	8000296e <kerneltrap+0x38>

0000000080002a02 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002a02:	1101                	addi	sp,sp,-32
    80002a04:	ec06                	sd	ra,24(sp)
    80002a06:	e822                	sd	s0,16(sp)
    80002a08:	e426                	sd	s1,8(sp)
    80002a0a:	1000                	addi	s0,sp,32
    80002a0c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80002a0e:	fffff097          	auipc	ra,0xfffff
    80002a12:	f88080e7          	jalr	-120(ra) # 80001996 <myproc>
  switch (n) {
    80002a16:	4795                	li	a5,5
    80002a18:	0497e163          	bltu	a5,s1,80002a5a <argraw+0x58>
    80002a1c:	048a                	slli	s1,s1,0x2
    80002a1e:	00006717          	auipc	a4,0x6
    80002a22:	a1270713          	addi	a4,a4,-1518 # 80008430 <states.0+0x170>
    80002a26:	94ba                	add	s1,s1,a4
    80002a28:	409c                	lw	a5,0(s1)
    80002a2a:	97ba                	add	a5,a5,a4
    80002a2c:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80002a2e:	753c                	ld	a5,104(a0)
    80002a30:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002a32:	60e2                	ld	ra,24(sp)
    80002a34:	6442                	ld	s0,16(sp)
    80002a36:	64a2                	ld	s1,8(sp)
    80002a38:	6105                	addi	sp,sp,32
    80002a3a:	8082                	ret
    return p->trapframe->a1;
    80002a3c:	753c                	ld	a5,104(a0)
    80002a3e:	7fa8                	ld	a0,120(a5)
    80002a40:	bfcd                	j	80002a32 <argraw+0x30>
    return p->trapframe->a2;
    80002a42:	753c                	ld	a5,104(a0)
    80002a44:	63c8                	ld	a0,128(a5)
    80002a46:	b7f5                	j	80002a32 <argraw+0x30>
    return p->trapframe->a3;
    80002a48:	753c                	ld	a5,104(a0)
    80002a4a:	67c8                	ld	a0,136(a5)
    80002a4c:	b7dd                	j	80002a32 <argraw+0x30>
    return p->trapframe->a4;
    80002a4e:	753c                	ld	a5,104(a0)
    80002a50:	6bc8                	ld	a0,144(a5)
    80002a52:	b7c5                	j	80002a32 <argraw+0x30>
    return p->trapframe->a5;
    80002a54:	753c                	ld	a5,104(a0)
    80002a56:	6fc8                	ld	a0,152(a5)
    80002a58:	bfe9                	j	80002a32 <argraw+0x30>
  panic("argraw");
    80002a5a:	00006517          	auipc	a0,0x6
    80002a5e:	9ae50513          	addi	a0,a0,-1618 # 80008408 <states.0+0x148>
    80002a62:	ffffe097          	auipc	ra,0xffffe
    80002a66:	ad8080e7          	jalr	-1320(ra) # 8000053a <panic>

0000000080002a6a <fetchaddr>:
{
    80002a6a:	1101                	addi	sp,sp,-32
    80002a6c:	ec06                	sd	ra,24(sp)
    80002a6e:	e822                	sd	s0,16(sp)
    80002a70:	e426                	sd	s1,8(sp)
    80002a72:	e04a                	sd	s2,0(sp)
    80002a74:	1000                	addi	s0,sp,32
    80002a76:	84aa                	mv	s1,a0
    80002a78:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002a7a:	fffff097          	auipc	ra,0xfffff
    80002a7e:	f1c080e7          	jalr	-228(ra) # 80001996 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80002a82:	6d3c                	ld	a5,88(a0)
    80002a84:	02f4f863          	bgeu	s1,a5,80002ab4 <fetchaddr+0x4a>
    80002a88:	00848713          	addi	a4,s1,8
    80002a8c:	02e7e663          	bltu	a5,a4,80002ab8 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002a90:	46a1                	li	a3,8
    80002a92:	8626                	mv	a2,s1
    80002a94:	85ca                	mv	a1,s2
    80002a96:	7128                	ld	a0,96(a0)
    80002a98:	fffff097          	auipc	ra,0xfffff
    80002a9c:	c4e080e7          	jalr	-946(ra) # 800016e6 <copyin>
    80002aa0:	00a03533          	snez	a0,a0
    80002aa4:	40a00533          	neg	a0,a0
}
    80002aa8:	60e2                	ld	ra,24(sp)
    80002aaa:	6442                	ld	s0,16(sp)
    80002aac:	64a2                	ld	s1,8(sp)
    80002aae:	6902                	ld	s2,0(sp)
    80002ab0:	6105                	addi	sp,sp,32
    80002ab2:	8082                	ret
    return -1;
    80002ab4:	557d                	li	a0,-1
    80002ab6:	bfcd                	j	80002aa8 <fetchaddr+0x3e>
    80002ab8:	557d                	li	a0,-1
    80002aba:	b7fd                	j	80002aa8 <fetchaddr+0x3e>

0000000080002abc <fetchstr>:
{
    80002abc:	7179                	addi	sp,sp,-48
    80002abe:	f406                	sd	ra,40(sp)
    80002ac0:	f022                	sd	s0,32(sp)
    80002ac2:	ec26                	sd	s1,24(sp)
    80002ac4:	e84a                	sd	s2,16(sp)
    80002ac6:	e44e                	sd	s3,8(sp)
    80002ac8:	1800                	addi	s0,sp,48
    80002aca:	892a                	mv	s2,a0
    80002acc:	84ae                	mv	s1,a1
    80002ace:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80002ad0:	fffff097          	auipc	ra,0xfffff
    80002ad4:	ec6080e7          	jalr	-314(ra) # 80001996 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    80002ad8:	86ce                	mv	a3,s3
    80002ada:	864a                	mv	a2,s2
    80002adc:	85a6                	mv	a1,s1
    80002ade:	7128                	ld	a0,96(a0)
    80002ae0:	fffff097          	auipc	ra,0xfffff
    80002ae4:	c94080e7          	jalr	-876(ra) # 80001774 <copyinstr>
  if(err < 0)
    80002ae8:	00054763          	bltz	a0,80002af6 <fetchstr+0x3a>
  return strlen(buf);
    80002aec:	8526                	mv	a0,s1
    80002aee:	ffffe097          	auipc	ra,0xffffe
    80002af2:	35a080e7          	jalr	858(ra) # 80000e48 <strlen>
}
    80002af6:	70a2                	ld	ra,40(sp)
    80002af8:	7402                	ld	s0,32(sp)
    80002afa:	64e2                	ld	s1,24(sp)
    80002afc:	6942                	ld	s2,16(sp)
    80002afe:	69a2                	ld	s3,8(sp)
    80002b00:	6145                	addi	sp,sp,48
    80002b02:	8082                	ret

0000000080002b04 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80002b04:	1101                	addi	sp,sp,-32
    80002b06:	ec06                	sd	ra,24(sp)
    80002b08:	e822                	sd	s0,16(sp)
    80002b0a:	e426                	sd	s1,8(sp)
    80002b0c:	1000                	addi	s0,sp,32
    80002b0e:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002b10:	00000097          	auipc	ra,0x0
    80002b14:	ef2080e7          	jalr	-270(ra) # 80002a02 <argraw>
    80002b18:	c088                	sw	a0,0(s1)
  return 0;
}
    80002b1a:	4501                	li	a0,0
    80002b1c:	60e2                	ld	ra,24(sp)
    80002b1e:	6442                	ld	s0,16(sp)
    80002b20:	64a2                	ld	s1,8(sp)
    80002b22:	6105                	addi	sp,sp,32
    80002b24:	8082                	ret

0000000080002b26 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80002b26:	1101                	addi	sp,sp,-32
    80002b28:	ec06                	sd	ra,24(sp)
    80002b2a:	e822                	sd	s0,16(sp)
    80002b2c:	e426                	sd	s1,8(sp)
    80002b2e:	1000                	addi	s0,sp,32
    80002b30:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002b32:	00000097          	auipc	ra,0x0
    80002b36:	ed0080e7          	jalr	-304(ra) # 80002a02 <argraw>
    80002b3a:	e088                	sd	a0,0(s1)
  return 0;
}
    80002b3c:	4501                	li	a0,0
    80002b3e:	60e2                	ld	ra,24(sp)
    80002b40:	6442                	ld	s0,16(sp)
    80002b42:	64a2                	ld	s1,8(sp)
    80002b44:	6105                	addi	sp,sp,32
    80002b46:	8082                	ret

0000000080002b48 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002b48:	1101                	addi	sp,sp,-32
    80002b4a:	ec06                	sd	ra,24(sp)
    80002b4c:	e822                	sd	s0,16(sp)
    80002b4e:	e426                	sd	s1,8(sp)
    80002b50:	e04a                	sd	s2,0(sp)
    80002b52:	1000                	addi	s0,sp,32
    80002b54:	84ae                	mv	s1,a1
    80002b56:	8932                	mv	s2,a2
  *ip = argraw(n);
    80002b58:	00000097          	auipc	ra,0x0
    80002b5c:	eaa080e7          	jalr	-342(ra) # 80002a02 <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80002b60:	864a                	mv	a2,s2
    80002b62:	85a6                	mv	a1,s1
    80002b64:	00000097          	auipc	ra,0x0
    80002b68:	f58080e7          	jalr	-168(ra) # 80002abc <fetchstr>
}
    80002b6c:	60e2                	ld	ra,24(sp)
    80002b6e:	6442                	ld	s0,16(sp)
    80002b70:	64a2                	ld	s1,8(sp)
    80002b72:	6902                	ld	s2,0(sp)
    80002b74:	6105                	addi	sp,sp,32
    80002b76:	8082                	ret

0000000080002b78 <syscall>:
[SYS_getpinfo] sys_getpinfo
};

void
syscall(void)
{
    80002b78:	1101                	addi	sp,sp,-32
    80002b7a:	ec06                	sd	ra,24(sp)
    80002b7c:	e822                	sd	s0,16(sp)
    80002b7e:	e426                	sd	s1,8(sp)
    80002b80:	e04a                	sd	s2,0(sp)
    80002b82:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002b84:	fffff097          	auipc	ra,0xfffff
    80002b88:	e12080e7          	jalr	-494(ra) # 80001996 <myproc>
    80002b8c:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80002b8e:	06853903          	ld	s2,104(a0)
    80002b92:	0a893783          	ld	a5,168(s2)
    80002b96:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002b9a:	37fd                	addiw	a5,a5,-1
    80002b9c:	4755                	li	a4,21
    80002b9e:	00f76f63          	bltu	a4,a5,80002bbc <syscall+0x44>
    80002ba2:	00369713          	slli	a4,a3,0x3
    80002ba6:	00006797          	auipc	a5,0x6
    80002baa:	8a278793          	addi	a5,a5,-1886 # 80008448 <syscalls>
    80002bae:	97ba                	add	a5,a5,a4
    80002bb0:	639c                	ld	a5,0(a5)
    80002bb2:	c789                	beqz	a5,80002bbc <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    80002bb4:	9782                	jalr	a5
    80002bb6:	06a93823          	sd	a0,112(s2)
    80002bba:	a839                	j	80002bd8 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002bbc:	16848613          	addi	a2,s1,360
    80002bc0:	588c                	lw	a1,48(s1)
    80002bc2:	00006517          	auipc	a0,0x6
    80002bc6:	84e50513          	addi	a0,a0,-1970 # 80008410 <states.0+0x150>
    80002bca:	ffffe097          	auipc	ra,0xffffe
    80002bce:	9ba080e7          	jalr	-1606(ra) # 80000584 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80002bd2:	74bc                	ld	a5,104(s1)
    80002bd4:	577d                	li	a4,-1
    80002bd6:	fbb8                	sd	a4,112(a5)
  }
}
    80002bd8:	60e2                	ld	ra,24(sp)
    80002bda:	6442                	ld	s0,16(sp)
    80002bdc:	64a2                	ld	s1,8(sp)
    80002bde:	6902                	ld	s2,0(sp)
    80002be0:	6105                	addi	sp,sp,32
    80002be2:	8082                	ret

0000000080002be4 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80002be4:	1101                	addi	sp,sp,-32
    80002be6:	ec06                	sd	ra,24(sp)
    80002be8:	e822                	sd	s0,16(sp)
    80002bea:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80002bec:	fec40593          	addi	a1,s0,-20
    80002bf0:	4501                	li	a0,0
    80002bf2:	00000097          	auipc	ra,0x0
    80002bf6:	f12080e7          	jalr	-238(ra) # 80002b04 <argint>
    return -1;
    80002bfa:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002bfc:	00054963          	bltz	a0,80002c0e <sys_exit+0x2a>
  exit(n);
    80002c00:	fec42503          	lw	a0,-20(s0)
    80002c04:	fffff097          	auipc	ra,0xfffff
    80002c08:	6bc080e7          	jalr	1724(ra) # 800022c0 <exit>
  return 0;  // not reached
    80002c0c:	4781                	li	a5,0
}
    80002c0e:	853e                	mv	a0,a5
    80002c10:	60e2                	ld	ra,24(sp)
    80002c12:	6442                	ld	s0,16(sp)
    80002c14:	6105                	addi	sp,sp,32
    80002c16:	8082                	ret

0000000080002c18 <sys_getpinfo>:


uint64
sys_getpinfo(void)
{
    80002c18:	1101                	addi	sp,sp,-32
    80002c1a:	ec06                	sd	ra,24(sp)
    80002c1c:	e822                	sd	s0,16(sp)
    80002c1e:	1000                	addi	s0,sp,32
  uint64 ps;

  //obtenemos puntero
  if (argaddr(0, &ps) < 0){
    80002c20:	fe840593          	addi	a1,s0,-24
    80002c24:	4501                	li	a0,0
    80002c26:	00000097          	auipc	ra,0x0
    80002c2a:	f00080e7          	jalr	-256(ra) # 80002b26 <argaddr>
    80002c2e:	00054f63          	bltz	a0,80002c4c <sys_getpinfo+0x34>
    return -1;
  }

  if (ps == (uint64)null){ //NULL
    80002c32:	fe843783          	ld	a5,-24(s0)
    return -1;
    80002c36:	557d                	li	a0,-1
  if (ps == (uint64)null){ //NULL
    80002c38:	c791                	beqz	a5,80002c44 <sys_getpinfo+0x2c>
  }

  return  getpinfo (ps);
    80002c3a:	853e                	mv	a0,a5
    80002c3c:	00000097          	auipc	ra,0x0
    80002c40:	928080e7          	jalr	-1752(ra) # 80002564 <getpinfo>
}
    80002c44:	60e2                	ld	ra,24(sp)
    80002c46:	6442                	ld	s0,16(sp)
    80002c48:	6105                	addi	sp,sp,32
    80002c4a:	8082                	ret
    return -1;
    80002c4c:	557d                	li	a0,-1
    80002c4e:	bfdd                	j	80002c44 <sys_getpinfo+0x2c>

0000000080002c50 <sys_getpid>:


uint64
sys_getpid(void)
{
    80002c50:	1141                	addi	sp,sp,-16
    80002c52:	e406                	sd	ra,8(sp)
    80002c54:	e022                	sd	s0,0(sp)
    80002c56:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002c58:	fffff097          	auipc	ra,0xfffff
    80002c5c:	d3e080e7          	jalr	-706(ra) # 80001996 <myproc>
}
    80002c60:	5908                	lw	a0,48(a0)
    80002c62:	60a2                	ld	ra,8(sp)
    80002c64:	6402                	ld	s0,0(sp)
    80002c66:	0141                	addi	sp,sp,16
    80002c68:	8082                	ret

0000000080002c6a <sys_fork>:

uint64
sys_fork(void)
{
    80002c6a:	1141                	addi	sp,sp,-16
    80002c6c:	e406                	sd	ra,8(sp)
    80002c6e:	e022                	sd	s0,0(sp)
    80002c70:	0800                	addi	s0,sp,16
  return fork();
    80002c72:	fffff097          	auipc	ra,0xfffff
    80002c76:	100080e7          	jalr	256(ra) # 80001d72 <fork>
}
    80002c7a:	60a2                	ld	ra,8(sp)
    80002c7c:	6402                	ld	s0,0(sp)
    80002c7e:	0141                	addi	sp,sp,16
    80002c80:	8082                	ret

0000000080002c82 <sys_wait>:

uint64
sys_wait(void)
{
    80002c82:	1101                	addi	sp,sp,-32
    80002c84:	ec06                	sd	ra,24(sp)
    80002c86:	e822                	sd	s0,16(sp)
    80002c88:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80002c8a:	fe840593          	addi	a1,s0,-24
    80002c8e:	4501                	li	a0,0
    80002c90:	00000097          	auipc	ra,0x0
    80002c94:	e96080e7          	jalr	-362(ra) # 80002b26 <argaddr>
    80002c98:	87aa                	mv	a5,a0
    return -1;
    80002c9a:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80002c9c:	0007c863          	bltz	a5,80002cac <sys_wait+0x2a>
  return wait(p);
    80002ca0:	fe843503          	ld	a0,-24(s0)
    80002ca4:	fffff097          	auipc	ra,0xfffff
    80002ca8:	424080e7          	jalr	1060(ra) # 800020c8 <wait>
}
    80002cac:	60e2                	ld	ra,24(sp)
    80002cae:	6442                	ld	s0,16(sp)
    80002cb0:	6105                	addi	sp,sp,32
    80002cb2:	8082                	ret

0000000080002cb4 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002cb4:	7179                	addi	sp,sp,-48
    80002cb6:	f406                	sd	ra,40(sp)
    80002cb8:	f022                	sd	s0,32(sp)
    80002cba:	ec26                	sd	s1,24(sp)
    80002cbc:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80002cbe:	fdc40593          	addi	a1,s0,-36
    80002cc2:	4501                	li	a0,0
    80002cc4:	00000097          	auipc	ra,0x0
    80002cc8:	e40080e7          	jalr	-448(ra) # 80002b04 <argint>
    80002ccc:	87aa                	mv	a5,a0
    return -1;
    80002cce:	557d                	li	a0,-1
  if(argint(0, &n) < 0)
    80002cd0:	0207c063          	bltz	a5,80002cf0 <sys_sbrk+0x3c>
  addr = myproc()->sz;
    80002cd4:	fffff097          	auipc	ra,0xfffff
    80002cd8:	cc2080e7          	jalr	-830(ra) # 80001996 <myproc>
    80002cdc:	4d24                	lw	s1,88(a0)
  if(growproc(n) < 0)
    80002cde:	fdc42503          	lw	a0,-36(s0)
    80002ce2:	fffff097          	auipc	ra,0xfffff
    80002ce6:	018080e7          	jalr	24(ra) # 80001cfa <growproc>
    80002cea:	00054863          	bltz	a0,80002cfa <sys_sbrk+0x46>
    return -1;
  return addr;
    80002cee:	8526                	mv	a0,s1
}
    80002cf0:	70a2                	ld	ra,40(sp)
    80002cf2:	7402                	ld	s0,32(sp)
    80002cf4:	64e2                	ld	s1,24(sp)
    80002cf6:	6145                	addi	sp,sp,48
    80002cf8:	8082                	ret
    return -1;
    80002cfa:	557d                	li	a0,-1
    80002cfc:	bfd5                	j	80002cf0 <sys_sbrk+0x3c>

0000000080002cfe <sys_sleep>:

uint64
sys_sleep(void)
{
    80002cfe:	7139                	addi	sp,sp,-64
    80002d00:	fc06                	sd	ra,56(sp)
    80002d02:	f822                	sd	s0,48(sp)
    80002d04:	f426                	sd	s1,40(sp)
    80002d06:	f04a                	sd	s2,32(sp)
    80002d08:	ec4e                	sd	s3,24(sp)
    80002d0a:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80002d0c:	fcc40593          	addi	a1,s0,-52
    80002d10:	4501                	li	a0,0
    80002d12:	00000097          	auipc	ra,0x0
    80002d16:	df2080e7          	jalr	-526(ra) # 80002b04 <argint>
    return -1;
    80002d1a:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002d1c:	06054563          	bltz	a0,80002d86 <sys_sleep+0x88>
  acquire(&tickslock);
    80002d20:	00014517          	auipc	a0,0x14
    80002d24:	7b050513          	addi	a0,a0,1968 # 800174d0 <tickslock>
    80002d28:	ffffe097          	auipc	ra,0xffffe
    80002d2c:	ea8080e7          	jalr	-344(ra) # 80000bd0 <acquire>
  ticks0 = ticks;
    80002d30:	00006917          	auipc	s2,0x6
    80002d34:	30092903          	lw	s2,768(s2) # 80009030 <ticks>
  while(ticks - ticks0 < n){
    80002d38:	fcc42783          	lw	a5,-52(s0)
    80002d3c:	cf85                	beqz	a5,80002d74 <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002d3e:	00014997          	auipc	s3,0x14
    80002d42:	79298993          	addi	s3,s3,1938 # 800174d0 <tickslock>
    80002d46:	00006497          	auipc	s1,0x6
    80002d4a:	2ea48493          	addi	s1,s1,746 # 80009030 <ticks>
    if(myproc()->killed){
    80002d4e:	fffff097          	auipc	ra,0xfffff
    80002d52:	c48080e7          	jalr	-952(ra) # 80001996 <myproc>
    80002d56:	551c                	lw	a5,40(a0)
    80002d58:	ef9d                	bnez	a5,80002d96 <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    80002d5a:	85ce                	mv	a1,s3
    80002d5c:	8526                	mv	a0,s1
    80002d5e:	fffff097          	auipc	ra,0xfffff
    80002d62:	306080e7          	jalr	774(ra) # 80002064 <sleep>
  while(ticks - ticks0 < n){
    80002d66:	409c                	lw	a5,0(s1)
    80002d68:	412787bb          	subw	a5,a5,s2
    80002d6c:	fcc42703          	lw	a4,-52(s0)
    80002d70:	fce7efe3          	bltu	a5,a4,80002d4e <sys_sleep+0x50>
  }
  release(&tickslock);
    80002d74:	00014517          	auipc	a0,0x14
    80002d78:	75c50513          	addi	a0,a0,1884 # 800174d0 <tickslock>
    80002d7c:	ffffe097          	auipc	ra,0xffffe
    80002d80:	f08080e7          	jalr	-248(ra) # 80000c84 <release>
  return 0;
    80002d84:	4781                	li	a5,0
}
    80002d86:	853e                	mv	a0,a5
    80002d88:	70e2                	ld	ra,56(sp)
    80002d8a:	7442                	ld	s0,48(sp)
    80002d8c:	74a2                	ld	s1,40(sp)
    80002d8e:	7902                	ld	s2,32(sp)
    80002d90:	69e2                	ld	s3,24(sp)
    80002d92:	6121                	addi	sp,sp,64
    80002d94:	8082                	ret
      release(&tickslock);
    80002d96:	00014517          	auipc	a0,0x14
    80002d9a:	73a50513          	addi	a0,a0,1850 # 800174d0 <tickslock>
    80002d9e:	ffffe097          	auipc	ra,0xffffe
    80002da2:	ee6080e7          	jalr	-282(ra) # 80000c84 <release>
      return -1;
    80002da6:	57fd                	li	a5,-1
    80002da8:	bff9                	j	80002d86 <sys_sleep+0x88>

0000000080002daa <sys_kill>:

uint64
sys_kill(void)
{
    80002daa:	1101                	addi	sp,sp,-32
    80002dac:	ec06                	sd	ra,24(sp)
    80002dae:	e822                	sd	s0,16(sp)
    80002db0:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80002db2:	fec40593          	addi	a1,s0,-20
    80002db6:	4501                	li	a0,0
    80002db8:	00000097          	auipc	ra,0x0
    80002dbc:	d4c080e7          	jalr	-692(ra) # 80002b04 <argint>
    80002dc0:	87aa                	mv	a5,a0
    return -1;
    80002dc2:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    80002dc4:	0007c863          	bltz	a5,80002dd4 <sys_kill+0x2a>
  return kill(pid);
    80002dc8:	fec42503          	lw	a0,-20(s0)
    80002dcc:	fffff097          	auipc	ra,0xfffff
    80002dd0:	5ca080e7          	jalr	1482(ra) # 80002396 <kill>
}
    80002dd4:	60e2                	ld	ra,24(sp)
    80002dd6:	6442                	ld	s0,16(sp)
    80002dd8:	6105                	addi	sp,sp,32
    80002dda:	8082                	ret

0000000080002ddc <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002ddc:	1101                	addi	sp,sp,-32
    80002dde:	ec06                	sd	ra,24(sp)
    80002de0:	e822                	sd	s0,16(sp)
    80002de2:	e426                	sd	s1,8(sp)
    80002de4:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002de6:	00014517          	auipc	a0,0x14
    80002dea:	6ea50513          	addi	a0,a0,1770 # 800174d0 <tickslock>
    80002dee:	ffffe097          	auipc	ra,0xffffe
    80002df2:	de2080e7          	jalr	-542(ra) # 80000bd0 <acquire>
  xticks = ticks;
    80002df6:	00006497          	auipc	s1,0x6
    80002dfa:	23a4a483          	lw	s1,570(s1) # 80009030 <ticks>
  release(&tickslock);
    80002dfe:	00014517          	auipc	a0,0x14
    80002e02:	6d250513          	addi	a0,a0,1746 # 800174d0 <tickslock>
    80002e06:	ffffe097          	auipc	ra,0xffffe
    80002e0a:	e7e080e7          	jalr	-386(ra) # 80000c84 <release>
  return xticks;
}
    80002e0e:	02049513          	slli	a0,s1,0x20
    80002e12:	9101                	srli	a0,a0,0x20
    80002e14:	60e2                	ld	ra,24(sp)
    80002e16:	6442                	ld	s0,16(sp)
    80002e18:	64a2                	ld	s1,8(sp)
    80002e1a:	6105                	addi	sp,sp,32
    80002e1c:	8082                	ret

0000000080002e1e <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002e1e:	7179                	addi	sp,sp,-48
    80002e20:	f406                	sd	ra,40(sp)
    80002e22:	f022                	sd	s0,32(sp)
    80002e24:	ec26                	sd	s1,24(sp)
    80002e26:	e84a                	sd	s2,16(sp)
    80002e28:	e44e                	sd	s3,8(sp)
    80002e2a:	e052                	sd	s4,0(sp)
    80002e2c:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002e2e:	00005597          	auipc	a1,0x5
    80002e32:	6d258593          	addi	a1,a1,1746 # 80008500 <syscalls+0xb8>
    80002e36:	00014517          	auipc	a0,0x14
    80002e3a:	6b250513          	addi	a0,a0,1714 # 800174e8 <bcache>
    80002e3e:	ffffe097          	auipc	ra,0xffffe
    80002e42:	d02080e7          	jalr	-766(ra) # 80000b40 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002e46:	0001c797          	auipc	a5,0x1c
    80002e4a:	6a278793          	addi	a5,a5,1698 # 8001f4e8 <bcache+0x8000>
    80002e4e:	0001d717          	auipc	a4,0x1d
    80002e52:	90270713          	addi	a4,a4,-1790 # 8001f750 <bcache+0x8268>
    80002e56:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002e5a:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002e5e:	00014497          	auipc	s1,0x14
    80002e62:	6a248493          	addi	s1,s1,1698 # 80017500 <bcache+0x18>
    b->next = bcache.head.next;
    80002e66:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002e68:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002e6a:	00005a17          	auipc	s4,0x5
    80002e6e:	69ea0a13          	addi	s4,s4,1694 # 80008508 <syscalls+0xc0>
    b->next = bcache.head.next;
    80002e72:	2b893783          	ld	a5,696(s2)
    80002e76:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002e78:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002e7c:	85d2                	mv	a1,s4
    80002e7e:	01048513          	addi	a0,s1,16
    80002e82:	00001097          	auipc	ra,0x1
    80002e86:	4c2080e7          	jalr	1218(ra) # 80004344 <initsleeplock>
    bcache.head.next->prev = b;
    80002e8a:	2b893783          	ld	a5,696(s2)
    80002e8e:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002e90:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002e94:	45848493          	addi	s1,s1,1112
    80002e98:	fd349de3          	bne	s1,s3,80002e72 <binit+0x54>
  }
}
    80002e9c:	70a2                	ld	ra,40(sp)
    80002e9e:	7402                	ld	s0,32(sp)
    80002ea0:	64e2                	ld	s1,24(sp)
    80002ea2:	6942                	ld	s2,16(sp)
    80002ea4:	69a2                	ld	s3,8(sp)
    80002ea6:	6a02                	ld	s4,0(sp)
    80002ea8:	6145                	addi	sp,sp,48
    80002eaa:	8082                	ret

0000000080002eac <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002eac:	7179                	addi	sp,sp,-48
    80002eae:	f406                	sd	ra,40(sp)
    80002eb0:	f022                	sd	s0,32(sp)
    80002eb2:	ec26                	sd	s1,24(sp)
    80002eb4:	e84a                	sd	s2,16(sp)
    80002eb6:	e44e                	sd	s3,8(sp)
    80002eb8:	1800                	addi	s0,sp,48
    80002eba:	892a                	mv	s2,a0
    80002ebc:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80002ebe:	00014517          	auipc	a0,0x14
    80002ec2:	62a50513          	addi	a0,a0,1578 # 800174e8 <bcache>
    80002ec6:	ffffe097          	auipc	ra,0xffffe
    80002eca:	d0a080e7          	jalr	-758(ra) # 80000bd0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80002ece:	0001d497          	auipc	s1,0x1d
    80002ed2:	8d24b483          	ld	s1,-1838(s1) # 8001f7a0 <bcache+0x82b8>
    80002ed6:	0001d797          	auipc	a5,0x1d
    80002eda:	87a78793          	addi	a5,a5,-1926 # 8001f750 <bcache+0x8268>
    80002ede:	02f48f63          	beq	s1,a5,80002f1c <bread+0x70>
    80002ee2:	873e                	mv	a4,a5
    80002ee4:	a021                	j	80002eec <bread+0x40>
    80002ee6:	68a4                	ld	s1,80(s1)
    80002ee8:	02e48a63          	beq	s1,a4,80002f1c <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002eec:	449c                	lw	a5,8(s1)
    80002eee:	ff279ce3          	bne	a5,s2,80002ee6 <bread+0x3a>
    80002ef2:	44dc                	lw	a5,12(s1)
    80002ef4:	ff3799e3          	bne	a5,s3,80002ee6 <bread+0x3a>
      b->refcnt++;
    80002ef8:	40bc                	lw	a5,64(s1)
    80002efa:	2785                	addiw	a5,a5,1
    80002efc:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002efe:	00014517          	auipc	a0,0x14
    80002f02:	5ea50513          	addi	a0,a0,1514 # 800174e8 <bcache>
    80002f06:	ffffe097          	auipc	ra,0xffffe
    80002f0a:	d7e080e7          	jalr	-642(ra) # 80000c84 <release>
      acquiresleep(&b->lock);
    80002f0e:	01048513          	addi	a0,s1,16
    80002f12:	00001097          	auipc	ra,0x1
    80002f16:	46c080e7          	jalr	1132(ra) # 8000437e <acquiresleep>
      return b;
    80002f1a:	a8b9                	j	80002f78 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002f1c:	0001d497          	auipc	s1,0x1d
    80002f20:	87c4b483          	ld	s1,-1924(s1) # 8001f798 <bcache+0x82b0>
    80002f24:	0001d797          	auipc	a5,0x1d
    80002f28:	82c78793          	addi	a5,a5,-2004 # 8001f750 <bcache+0x8268>
    80002f2c:	00f48863          	beq	s1,a5,80002f3c <bread+0x90>
    80002f30:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80002f32:	40bc                	lw	a5,64(s1)
    80002f34:	cf81                	beqz	a5,80002f4c <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002f36:	64a4                	ld	s1,72(s1)
    80002f38:	fee49de3          	bne	s1,a4,80002f32 <bread+0x86>
  panic("bget: no buffers");
    80002f3c:	00005517          	auipc	a0,0x5
    80002f40:	5d450513          	addi	a0,a0,1492 # 80008510 <syscalls+0xc8>
    80002f44:	ffffd097          	auipc	ra,0xffffd
    80002f48:	5f6080e7          	jalr	1526(ra) # 8000053a <panic>
      b->dev = dev;
    80002f4c:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002f50:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80002f54:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002f58:	4785                	li	a5,1
    80002f5a:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002f5c:	00014517          	auipc	a0,0x14
    80002f60:	58c50513          	addi	a0,a0,1420 # 800174e8 <bcache>
    80002f64:	ffffe097          	auipc	ra,0xffffe
    80002f68:	d20080e7          	jalr	-736(ra) # 80000c84 <release>
      acquiresleep(&b->lock);
    80002f6c:	01048513          	addi	a0,s1,16
    80002f70:	00001097          	auipc	ra,0x1
    80002f74:	40e080e7          	jalr	1038(ra) # 8000437e <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002f78:	409c                	lw	a5,0(s1)
    80002f7a:	cb89                	beqz	a5,80002f8c <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002f7c:	8526                	mv	a0,s1
    80002f7e:	70a2                	ld	ra,40(sp)
    80002f80:	7402                	ld	s0,32(sp)
    80002f82:	64e2                	ld	s1,24(sp)
    80002f84:	6942                	ld	s2,16(sp)
    80002f86:	69a2                	ld	s3,8(sp)
    80002f88:	6145                	addi	sp,sp,48
    80002f8a:	8082                	ret
    virtio_disk_rw(b, 0);
    80002f8c:	4581                	li	a1,0
    80002f8e:	8526                	mv	a0,s1
    80002f90:	00003097          	auipc	ra,0x3
    80002f94:	f22080e7          	jalr	-222(ra) # 80005eb2 <virtio_disk_rw>
    b->valid = 1;
    80002f98:	4785                	li	a5,1
    80002f9a:	c09c                	sw	a5,0(s1)
  return b;
    80002f9c:	b7c5                	j	80002f7c <bread+0xd0>

0000000080002f9e <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002f9e:	1101                	addi	sp,sp,-32
    80002fa0:	ec06                	sd	ra,24(sp)
    80002fa2:	e822                	sd	s0,16(sp)
    80002fa4:	e426                	sd	s1,8(sp)
    80002fa6:	1000                	addi	s0,sp,32
    80002fa8:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002faa:	0541                	addi	a0,a0,16
    80002fac:	00001097          	auipc	ra,0x1
    80002fb0:	46c080e7          	jalr	1132(ra) # 80004418 <holdingsleep>
    80002fb4:	cd01                	beqz	a0,80002fcc <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002fb6:	4585                	li	a1,1
    80002fb8:	8526                	mv	a0,s1
    80002fba:	00003097          	auipc	ra,0x3
    80002fbe:	ef8080e7          	jalr	-264(ra) # 80005eb2 <virtio_disk_rw>
}
    80002fc2:	60e2                	ld	ra,24(sp)
    80002fc4:	6442                	ld	s0,16(sp)
    80002fc6:	64a2                	ld	s1,8(sp)
    80002fc8:	6105                	addi	sp,sp,32
    80002fca:	8082                	ret
    panic("bwrite");
    80002fcc:	00005517          	auipc	a0,0x5
    80002fd0:	55c50513          	addi	a0,a0,1372 # 80008528 <syscalls+0xe0>
    80002fd4:	ffffd097          	auipc	ra,0xffffd
    80002fd8:	566080e7          	jalr	1382(ra) # 8000053a <panic>

0000000080002fdc <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80002fdc:	1101                	addi	sp,sp,-32
    80002fde:	ec06                	sd	ra,24(sp)
    80002fe0:	e822                	sd	s0,16(sp)
    80002fe2:	e426                	sd	s1,8(sp)
    80002fe4:	e04a                	sd	s2,0(sp)
    80002fe6:	1000                	addi	s0,sp,32
    80002fe8:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002fea:	01050913          	addi	s2,a0,16
    80002fee:	854a                	mv	a0,s2
    80002ff0:	00001097          	auipc	ra,0x1
    80002ff4:	428080e7          	jalr	1064(ra) # 80004418 <holdingsleep>
    80002ff8:	c92d                	beqz	a0,8000306a <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80002ffa:	854a                	mv	a0,s2
    80002ffc:	00001097          	auipc	ra,0x1
    80003000:	3d8080e7          	jalr	984(ra) # 800043d4 <releasesleep>

  acquire(&bcache.lock);
    80003004:	00014517          	auipc	a0,0x14
    80003008:	4e450513          	addi	a0,a0,1252 # 800174e8 <bcache>
    8000300c:	ffffe097          	auipc	ra,0xffffe
    80003010:	bc4080e7          	jalr	-1084(ra) # 80000bd0 <acquire>
  b->refcnt--;
    80003014:	40bc                	lw	a5,64(s1)
    80003016:	37fd                	addiw	a5,a5,-1
    80003018:	0007871b          	sext.w	a4,a5
    8000301c:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    8000301e:	eb05                	bnez	a4,8000304e <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80003020:	68bc                	ld	a5,80(s1)
    80003022:	64b8                	ld	a4,72(s1)
    80003024:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80003026:	64bc                	ld	a5,72(s1)
    80003028:	68b8                	ld	a4,80(s1)
    8000302a:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8000302c:	0001c797          	auipc	a5,0x1c
    80003030:	4bc78793          	addi	a5,a5,1212 # 8001f4e8 <bcache+0x8000>
    80003034:	2b87b703          	ld	a4,696(a5)
    80003038:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    8000303a:	0001c717          	auipc	a4,0x1c
    8000303e:	71670713          	addi	a4,a4,1814 # 8001f750 <bcache+0x8268>
    80003042:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80003044:	2b87b703          	ld	a4,696(a5)
    80003048:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    8000304a:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    8000304e:	00014517          	auipc	a0,0x14
    80003052:	49a50513          	addi	a0,a0,1178 # 800174e8 <bcache>
    80003056:	ffffe097          	auipc	ra,0xffffe
    8000305a:	c2e080e7          	jalr	-978(ra) # 80000c84 <release>
}
    8000305e:	60e2                	ld	ra,24(sp)
    80003060:	6442                	ld	s0,16(sp)
    80003062:	64a2                	ld	s1,8(sp)
    80003064:	6902                	ld	s2,0(sp)
    80003066:	6105                	addi	sp,sp,32
    80003068:	8082                	ret
    panic("brelse");
    8000306a:	00005517          	auipc	a0,0x5
    8000306e:	4c650513          	addi	a0,a0,1222 # 80008530 <syscalls+0xe8>
    80003072:	ffffd097          	auipc	ra,0xffffd
    80003076:	4c8080e7          	jalr	1224(ra) # 8000053a <panic>

000000008000307a <bpin>:

void
bpin(struct buf *b) {
    8000307a:	1101                	addi	sp,sp,-32
    8000307c:	ec06                	sd	ra,24(sp)
    8000307e:	e822                	sd	s0,16(sp)
    80003080:	e426                	sd	s1,8(sp)
    80003082:	1000                	addi	s0,sp,32
    80003084:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003086:	00014517          	auipc	a0,0x14
    8000308a:	46250513          	addi	a0,a0,1122 # 800174e8 <bcache>
    8000308e:	ffffe097          	auipc	ra,0xffffe
    80003092:	b42080e7          	jalr	-1214(ra) # 80000bd0 <acquire>
  b->refcnt++;
    80003096:	40bc                	lw	a5,64(s1)
    80003098:	2785                	addiw	a5,a5,1
    8000309a:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000309c:	00014517          	auipc	a0,0x14
    800030a0:	44c50513          	addi	a0,a0,1100 # 800174e8 <bcache>
    800030a4:	ffffe097          	auipc	ra,0xffffe
    800030a8:	be0080e7          	jalr	-1056(ra) # 80000c84 <release>
}
    800030ac:	60e2                	ld	ra,24(sp)
    800030ae:	6442                	ld	s0,16(sp)
    800030b0:	64a2                	ld	s1,8(sp)
    800030b2:	6105                	addi	sp,sp,32
    800030b4:	8082                	ret

00000000800030b6 <bunpin>:

void
bunpin(struct buf *b) {
    800030b6:	1101                	addi	sp,sp,-32
    800030b8:	ec06                	sd	ra,24(sp)
    800030ba:	e822                	sd	s0,16(sp)
    800030bc:	e426                	sd	s1,8(sp)
    800030be:	1000                	addi	s0,sp,32
    800030c0:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800030c2:	00014517          	auipc	a0,0x14
    800030c6:	42650513          	addi	a0,a0,1062 # 800174e8 <bcache>
    800030ca:	ffffe097          	auipc	ra,0xffffe
    800030ce:	b06080e7          	jalr	-1274(ra) # 80000bd0 <acquire>
  b->refcnt--;
    800030d2:	40bc                	lw	a5,64(s1)
    800030d4:	37fd                	addiw	a5,a5,-1
    800030d6:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800030d8:	00014517          	auipc	a0,0x14
    800030dc:	41050513          	addi	a0,a0,1040 # 800174e8 <bcache>
    800030e0:	ffffe097          	auipc	ra,0xffffe
    800030e4:	ba4080e7          	jalr	-1116(ra) # 80000c84 <release>
}
    800030e8:	60e2                	ld	ra,24(sp)
    800030ea:	6442                	ld	s0,16(sp)
    800030ec:	64a2                	ld	s1,8(sp)
    800030ee:	6105                	addi	sp,sp,32
    800030f0:	8082                	ret

00000000800030f2 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800030f2:	1101                	addi	sp,sp,-32
    800030f4:	ec06                	sd	ra,24(sp)
    800030f6:	e822                	sd	s0,16(sp)
    800030f8:	e426                	sd	s1,8(sp)
    800030fa:	e04a                	sd	s2,0(sp)
    800030fc:	1000                	addi	s0,sp,32
    800030fe:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80003100:	00d5d59b          	srliw	a1,a1,0xd
    80003104:	0001d797          	auipc	a5,0x1d
    80003108:	ac07a783          	lw	a5,-1344(a5) # 8001fbc4 <sb+0x1c>
    8000310c:	9dbd                	addw	a1,a1,a5
    8000310e:	00000097          	auipc	ra,0x0
    80003112:	d9e080e7          	jalr	-610(ra) # 80002eac <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80003116:	0074f713          	andi	a4,s1,7
    8000311a:	4785                	li	a5,1
    8000311c:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    80003120:	14ce                	slli	s1,s1,0x33
    80003122:	90d9                	srli	s1,s1,0x36
    80003124:	00950733          	add	a4,a0,s1
    80003128:	05874703          	lbu	a4,88(a4)
    8000312c:	00e7f6b3          	and	a3,a5,a4
    80003130:	c69d                	beqz	a3,8000315e <bfree+0x6c>
    80003132:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80003134:	94aa                	add	s1,s1,a0
    80003136:	fff7c793          	not	a5,a5
    8000313a:	8f7d                	and	a4,a4,a5
    8000313c:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    80003140:	00001097          	auipc	ra,0x1
    80003144:	120080e7          	jalr	288(ra) # 80004260 <log_write>
  brelse(bp);
    80003148:	854a                	mv	a0,s2
    8000314a:	00000097          	auipc	ra,0x0
    8000314e:	e92080e7          	jalr	-366(ra) # 80002fdc <brelse>
}
    80003152:	60e2                	ld	ra,24(sp)
    80003154:	6442                	ld	s0,16(sp)
    80003156:	64a2                	ld	s1,8(sp)
    80003158:	6902                	ld	s2,0(sp)
    8000315a:	6105                	addi	sp,sp,32
    8000315c:	8082                	ret
    panic("freeing free block");
    8000315e:	00005517          	auipc	a0,0x5
    80003162:	3da50513          	addi	a0,a0,986 # 80008538 <syscalls+0xf0>
    80003166:	ffffd097          	auipc	ra,0xffffd
    8000316a:	3d4080e7          	jalr	980(ra) # 8000053a <panic>

000000008000316e <balloc>:
{
    8000316e:	711d                	addi	sp,sp,-96
    80003170:	ec86                	sd	ra,88(sp)
    80003172:	e8a2                	sd	s0,80(sp)
    80003174:	e4a6                	sd	s1,72(sp)
    80003176:	e0ca                	sd	s2,64(sp)
    80003178:	fc4e                	sd	s3,56(sp)
    8000317a:	f852                	sd	s4,48(sp)
    8000317c:	f456                	sd	s5,40(sp)
    8000317e:	f05a                	sd	s6,32(sp)
    80003180:	ec5e                	sd	s7,24(sp)
    80003182:	e862                	sd	s8,16(sp)
    80003184:	e466                	sd	s9,8(sp)
    80003186:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80003188:	0001d797          	auipc	a5,0x1d
    8000318c:	a247a783          	lw	a5,-1500(a5) # 8001fbac <sb+0x4>
    80003190:	cbc1                	beqz	a5,80003220 <balloc+0xb2>
    80003192:	8baa                	mv	s7,a0
    80003194:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80003196:	0001db17          	auipc	s6,0x1d
    8000319a:	a12b0b13          	addi	s6,s6,-1518 # 8001fba8 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000319e:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    800031a0:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800031a2:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    800031a4:	6c89                	lui	s9,0x2
    800031a6:	a831                	j	800031c2 <balloc+0x54>
    brelse(bp);
    800031a8:	854a                	mv	a0,s2
    800031aa:	00000097          	auipc	ra,0x0
    800031ae:	e32080e7          	jalr	-462(ra) # 80002fdc <brelse>
  for(b = 0; b < sb.size; b += BPB){
    800031b2:	015c87bb          	addw	a5,s9,s5
    800031b6:	00078a9b          	sext.w	s5,a5
    800031ba:	004b2703          	lw	a4,4(s6)
    800031be:	06eaf163          	bgeu	s5,a4,80003220 <balloc+0xb2>
    bp = bread(dev, BBLOCK(b, sb));
    800031c2:	41fad79b          	sraiw	a5,s5,0x1f
    800031c6:	0137d79b          	srliw	a5,a5,0x13
    800031ca:	015787bb          	addw	a5,a5,s5
    800031ce:	40d7d79b          	sraiw	a5,a5,0xd
    800031d2:	01cb2583          	lw	a1,28(s6)
    800031d6:	9dbd                	addw	a1,a1,a5
    800031d8:	855e                	mv	a0,s7
    800031da:	00000097          	auipc	ra,0x0
    800031de:	cd2080e7          	jalr	-814(ra) # 80002eac <bread>
    800031e2:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800031e4:	004b2503          	lw	a0,4(s6)
    800031e8:	000a849b          	sext.w	s1,s5
    800031ec:	8762                	mv	a4,s8
    800031ee:	faa4fde3          	bgeu	s1,a0,800031a8 <balloc+0x3a>
      m = 1 << (bi % 8);
    800031f2:	00777693          	andi	a3,a4,7
    800031f6:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800031fa:	41f7579b          	sraiw	a5,a4,0x1f
    800031fe:	01d7d79b          	srliw	a5,a5,0x1d
    80003202:	9fb9                	addw	a5,a5,a4
    80003204:	4037d79b          	sraiw	a5,a5,0x3
    80003208:	00f90633          	add	a2,s2,a5
    8000320c:	05864603          	lbu	a2,88(a2)
    80003210:	00c6f5b3          	and	a1,a3,a2
    80003214:	cd91                	beqz	a1,80003230 <balloc+0xc2>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003216:	2705                	addiw	a4,a4,1
    80003218:	2485                	addiw	s1,s1,1
    8000321a:	fd471ae3          	bne	a4,s4,800031ee <balloc+0x80>
    8000321e:	b769                	j	800031a8 <balloc+0x3a>
  panic("balloc: out of blocks");
    80003220:	00005517          	auipc	a0,0x5
    80003224:	33050513          	addi	a0,a0,816 # 80008550 <syscalls+0x108>
    80003228:	ffffd097          	auipc	ra,0xffffd
    8000322c:	312080e7          	jalr	786(ra) # 8000053a <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    80003230:	97ca                	add	a5,a5,s2
    80003232:	8e55                	or	a2,a2,a3
    80003234:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    80003238:	854a                	mv	a0,s2
    8000323a:	00001097          	auipc	ra,0x1
    8000323e:	026080e7          	jalr	38(ra) # 80004260 <log_write>
        brelse(bp);
    80003242:	854a                	mv	a0,s2
    80003244:	00000097          	auipc	ra,0x0
    80003248:	d98080e7          	jalr	-616(ra) # 80002fdc <brelse>
  bp = bread(dev, bno);
    8000324c:	85a6                	mv	a1,s1
    8000324e:	855e                	mv	a0,s7
    80003250:	00000097          	auipc	ra,0x0
    80003254:	c5c080e7          	jalr	-932(ra) # 80002eac <bread>
    80003258:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    8000325a:	40000613          	li	a2,1024
    8000325e:	4581                	li	a1,0
    80003260:	05850513          	addi	a0,a0,88
    80003264:	ffffe097          	auipc	ra,0xffffe
    80003268:	a68080e7          	jalr	-1432(ra) # 80000ccc <memset>
  log_write(bp);
    8000326c:	854a                	mv	a0,s2
    8000326e:	00001097          	auipc	ra,0x1
    80003272:	ff2080e7          	jalr	-14(ra) # 80004260 <log_write>
  brelse(bp);
    80003276:	854a                	mv	a0,s2
    80003278:	00000097          	auipc	ra,0x0
    8000327c:	d64080e7          	jalr	-668(ra) # 80002fdc <brelse>
}
    80003280:	8526                	mv	a0,s1
    80003282:	60e6                	ld	ra,88(sp)
    80003284:	6446                	ld	s0,80(sp)
    80003286:	64a6                	ld	s1,72(sp)
    80003288:	6906                	ld	s2,64(sp)
    8000328a:	79e2                	ld	s3,56(sp)
    8000328c:	7a42                	ld	s4,48(sp)
    8000328e:	7aa2                	ld	s5,40(sp)
    80003290:	7b02                	ld	s6,32(sp)
    80003292:	6be2                	ld	s7,24(sp)
    80003294:	6c42                	ld	s8,16(sp)
    80003296:	6ca2                	ld	s9,8(sp)
    80003298:	6125                	addi	sp,sp,96
    8000329a:	8082                	ret

000000008000329c <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    8000329c:	7179                	addi	sp,sp,-48
    8000329e:	f406                	sd	ra,40(sp)
    800032a0:	f022                	sd	s0,32(sp)
    800032a2:	ec26                	sd	s1,24(sp)
    800032a4:	e84a                	sd	s2,16(sp)
    800032a6:	e44e                	sd	s3,8(sp)
    800032a8:	e052                	sd	s4,0(sp)
    800032aa:	1800                	addi	s0,sp,48
    800032ac:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800032ae:	47ad                	li	a5,11
    800032b0:	04b7fe63          	bgeu	a5,a1,8000330c <bmap+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    800032b4:	ff45849b          	addiw	s1,a1,-12
    800032b8:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    800032bc:	0ff00793          	li	a5,255
    800032c0:	0ae7e463          	bltu	a5,a4,80003368 <bmap+0xcc>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    800032c4:	08052583          	lw	a1,128(a0)
    800032c8:	c5b5                	beqz	a1,80003334 <bmap+0x98>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    800032ca:	00092503          	lw	a0,0(s2)
    800032ce:	00000097          	auipc	ra,0x0
    800032d2:	bde080e7          	jalr	-1058(ra) # 80002eac <bread>
    800032d6:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    800032d8:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    800032dc:	02049713          	slli	a4,s1,0x20
    800032e0:	01e75593          	srli	a1,a4,0x1e
    800032e4:	00b784b3          	add	s1,a5,a1
    800032e8:	0004a983          	lw	s3,0(s1)
    800032ec:	04098e63          	beqz	s3,80003348 <bmap+0xac>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    800032f0:	8552                	mv	a0,s4
    800032f2:	00000097          	auipc	ra,0x0
    800032f6:	cea080e7          	jalr	-790(ra) # 80002fdc <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    800032fa:	854e                	mv	a0,s3
    800032fc:	70a2                	ld	ra,40(sp)
    800032fe:	7402                	ld	s0,32(sp)
    80003300:	64e2                	ld	s1,24(sp)
    80003302:	6942                	ld	s2,16(sp)
    80003304:	69a2                	ld	s3,8(sp)
    80003306:	6a02                	ld	s4,0(sp)
    80003308:	6145                	addi	sp,sp,48
    8000330a:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    8000330c:	02059793          	slli	a5,a1,0x20
    80003310:	01e7d593          	srli	a1,a5,0x1e
    80003314:	00b504b3          	add	s1,a0,a1
    80003318:	0504a983          	lw	s3,80(s1)
    8000331c:	fc099fe3          	bnez	s3,800032fa <bmap+0x5e>
      ip->addrs[bn] = addr = balloc(ip->dev);
    80003320:	4108                	lw	a0,0(a0)
    80003322:	00000097          	auipc	ra,0x0
    80003326:	e4c080e7          	jalr	-436(ra) # 8000316e <balloc>
    8000332a:	0005099b          	sext.w	s3,a0
    8000332e:	0534a823          	sw	s3,80(s1)
    80003332:	b7e1                	j	800032fa <bmap+0x5e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80003334:	4108                	lw	a0,0(a0)
    80003336:	00000097          	auipc	ra,0x0
    8000333a:	e38080e7          	jalr	-456(ra) # 8000316e <balloc>
    8000333e:	0005059b          	sext.w	a1,a0
    80003342:	08b92023          	sw	a1,128(s2)
    80003346:	b751                	j	800032ca <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    80003348:	00092503          	lw	a0,0(s2)
    8000334c:	00000097          	auipc	ra,0x0
    80003350:	e22080e7          	jalr	-478(ra) # 8000316e <balloc>
    80003354:	0005099b          	sext.w	s3,a0
    80003358:	0134a023          	sw	s3,0(s1)
      log_write(bp);
    8000335c:	8552                	mv	a0,s4
    8000335e:	00001097          	auipc	ra,0x1
    80003362:	f02080e7          	jalr	-254(ra) # 80004260 <log_write>
    80003366:	b769                	j	800032f0 <bmap+0x54>
  panic("bmap: out of range");
    80003368:	00005517          	auipc	a0,0x5
    8000336c:	20050513          	addi	a0,a0,512 # 80008568 <syscalls+0x120>
    80003370:	ffffd097          	auipc	ra,0xffffd
    80003374:	1ca080e7          	jalr	458(ra) # 8000053a <panic>

0000000080003378 <iget>:
{
    80003378:	7179                	addi	sp,sp,-48
    8000337a:	f406                	sd	ra,40(sp)
    8000337c:	f022                	sd	s0,32(sp)
    8000337e:	ec26                	sd	s1,24(sp)
    80003380:	e84a                	sd	s2,16(sp)
    80003382:	e44e                	sd	s3,8(sp)
    80003384:	e052                	sd	s4,0(sp)
    80003386:	1800                	addi	s0,sp,48
    80003388:	89aa                	mv	s3,a0
    8000338a:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    8000338c:	0001d517          	auipc	a0,0x1d
    80003390:	83c50513          	addi	a0,a0,-1988 # 8001fbc8 <itable>
    80003394:	ffffe097          	auipc	ra,0xffffe
    80003398:	83c080e7          	jalr	-1988(ra) # 80000bd0 <acquire>
  empty = 0;
    8000339c:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    8000339e:	0001d497          	auipc	s1,0x1d
    800033a2:	84248493          	addi	s1,s1,-1982 # 8001fbe0 <itable+0x18>
    800033a6:	0001e697          	auipc	a3,0x1e
    800033aa:	2ca68693          	addi	a3,a3,714 # 80021670 <log>
    800033ae:	a039                	j	800033bc <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800033b0:	02090b63          	beqz	s2,800033e6 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800033b4:	08848493          	addi	s1,s1,136
    800033b8:	02d48a63          	beq	s1,a3,800033ec <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800033bc:	449c                	lw	a5,8(s1)
    800033be:	fef059e3          	blez	a5,800033b0 <iget+0x38>
    800033c2:	4098                	lw	a4,0(s1)
    800033c4:	ff3716e3          	bne	a4,s3,800033b0 <iget+0x38>
    800033c8:	40d8                	lw	a4,4(s1)
    800033ca:	ff4713e3          	bne	a4,s4,800033b0 <iget+0x38>
      ip->ref++;
    800033ce:	2785                	addiw	a5,a5,1
    800033d0:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    800033d2:	0001c517          	auipc	a0,0x1c
    800033d6:	7f650513          	addi	a0,a0,2038 # 8001fbc8 <itable>
    800033da:	ffffe097          	auipc	ra,0xffffe
    800033de:	8aa080e7          	jalr	-1878(ra) # 80000c84 <release>
      return ip;
    800033e2:	8926                	mv	s2,s1
    800033e4:	a03d                	j	80003412 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800033e6:	f7f9                	bnez	a5,800033b4 <iget+0x3c>
    800033e8:	8926                	mv	s2,s1
    800033ea:	b7e9                	j	800033b4 <iget+0x3c>
  if(empty == 0)
    800033ec:	02090c63          	beqz	s2,80003424 <iget+0xac>
  ip->dev = dev;
    800033f0:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    800033f4:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    800033f8:	4785                	li	a5,1
    800033fa:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    800033fe:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80003402:	0001c517          	auipc	a0,0x1c
    80003406:	7c650513          	addi	a0,a0,1990 # 8001fbc8 <itable>
    8000340a:	ffffe097          	auipc	ra,0xffffe
    8000340e:	87a080e7          	jalr	-1926(ra) # 80000c84 <release>
}
    80003412:	854a                	mv	a0,s2
    80003414:	70a2                	ld	ra,40(sp)
    80003416:	7402                	ld	s0,32(sp)
    80003418:	64e2                	ld	s1,24(sp)
    8000341a:	6942                	ld	s2,16(sp)
    8000341c:	69a2                	ld	s3,8(sp)
    8000341e:	6a02                	ld	s4,0(sp)
    80003420:	6145                	addi	sp,sp,48
    80003422:	8082                	ret
    panic("iget: no inodes");
    80003424:	00005517          	auipc	a0,0x5
    80003428:	15c50513          	addi	a0,a0,348 # 80008580 <syscalls+0x138>
    8000342c:	ffffd097          	auipc	ra,0xffffd
    80003430:	10e080e7          	jalr	270(ra) # 8000053a <panic>

0000000080003434 <fsinit>:
fsinit(int dev) {
    80003434:	7179                	addi	sp,sp,-48
    80003436:	f406                	sd	ra,40(sp)
    80003438:	f022                	sd	s0,32(sp)
    8000343a:	ec26                	sd	s1,24(sp)
    8000343c:	e84a                	sd	s2,16(sp)
    8000343e:	e44e                	sd	s3,8(sp)
    80003440:	1800                	addi	s0,sp,48
    80003442:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80003444:	4585                	li	a1,1
    80003446:	00000097          	auipc	ra,0x0
    8000344a:	a66080e7          	jalr	-1434(ra) # 80002eac <bread>
    8000344e:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80003450:	0001c997          	auipc	s3,0x1c
    80003454:	75898993          	addi	s3,s3,1880 # 8001fba8 <sb>
    80003458:	02000613          	li	a2,32
    8000345c:	05850593          	addi	a1,a0,88
    80003460:	854e                	mv	a0,s3
    80003462:	ffffe097          	auipc	ra,0xffffe
    80003466:	8c6080e7          	jalr	-1850(ra) # 80000d28 <memmove>
  brelse(bp);
    8000346a:	8526                	mv	a0,s1
    8000346c:	00000097          	auipc	ra,0x0
    80003470:	b70080e7          	jalr	-1168(ra) # 80002fdc <brelse>
  if(sb.magic != FSMAGIC)
    80003474:	0009a703          	lw	a4,0(s3)
    80003478:	102037b7          	lui	a5,0x10203
    8000347c:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80003480:	02f71263          	bne	a4,a5,800034a4 <fsinit+0x70>
  initlog(dev, &sb);
    80003484:	0001c597          	auipc	a1,0x1c
    80003488:	72458593          	addi	a1,a1,1828 # 8001fba8 <sb>
    8000348c:	854a                	mv	a0,s2
    8000348e:	00001097          	auipc	ra,0x1
    80003492:	b56080e7          	jalr	-1194(ra) # 80003fe4 <initlog>
}
    80003496:	70a2                	ld	ra,40(sp)
    80003498:	7402                	ld	s0,32(sp)
    8000349a:	64e2                	ld	s1,24(sp)
    8000349c:	6942                	ld	s2,16(sp)
    8000349e:	69a2                	ld	s3,8(sp)
    800034a0:	6145                	addi	sp,sp,48
    800034a2:	8082                	ret
    panic("invalid file system");
    800034a4:	00005517          	auipc	a0,0x5
    800034a8:	0ec50513          	addi	a0,a0,236 # 80008590 <syscalls+0x148>
    800034ac:	ffffd097          	auipc	ra,0xffffd
    800034b0:	08e080e7          	jalr	142(ra) # 8000053a <panic>

00000000800034b4 <iinit>:
{
    800034b4:	7179                	addi	sp,sp,-48
    800034b6:	f406                	sd	ra,40(sp)
    800034b8:	f022                	sd	s0,32(sp)
    800034ba:	ec26                	sd	s1,24(sp)
    800034bc:	e84a                	sd	s2,16(sp)
    800034be:	e44e                	sd	s3,8(sp)
    800034c0:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    800034c2:	00005597          	auipc	a1,0x5
    800034c6:	0e658593          	addi	a1,a1,230 # 800085a8 <syscalls+0x160>
    800034ca:	0001c517          	auipc	a0,0x1c
    800034ce:	6fe50513          	addi	a0,a0,1790 # 8001fbc8 <itable>
    800034d2:	ffffd097          	auipc	ra,0xffffd
    800034d6:	66e080e7          	jalr	1646(ra) # 80000b40 <initlock>
  for(i = 0; i < NINODE; i++) {
    800034da:	0001c497          	auipc	s1,0x1c
    800034de:	71648493          	addi	s1,s1,1814 # 8001fbf0 <itable+0x28>
    800034e2:	0001e997          	auipc	s3,0x1e
    800034e6:	19e98993          	addi	s3,s3,414 # 80021680 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    800034ea:	00005917          	auipc	s2,0x5
    800034ee:	0c690913          	addi	s2,s2,198 # 800085b0 <syscalls+0x168>
    800034f2:	85ca                	mv	a1,s2
    800034f4:	8526                	mv	a0,s1
    800034f6:	00001097          	auipc	ra,0x1
    800034fa:	e4e080e7          	jalr	-434(ra) # 80004344 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    800034fe:	08848493          	addi	s1,s1,136
    80003502:	ff3498e3          	bne	s1,s3,800034f2 <iinit+0x3e>
}
    80003506:	70a2                	ld	ra,40(sp)
    80003508:	7402                	ld	s0,32(sp)
    8000350a:	64e2                	ld	s1,24(sp)
    8000350c:	6942                	ld	s2,16(sp)
    8000350e:	69a2                	ld	s3,8(sp)
    80003510:	6145                	addi	sp,sp,48
    80003512:	8082                	ret

0000000080003514 <ialloc>:
{
    80003514:	715d                	addi	sp,sp,-80
    80003516:	e486                	sd	ra,72(sp)
    80003518:	e0a2                	sd	s0,64(sp)
    8000351a:	fc26                	sd	s1,56(sp)
    8000351c:	f84a                	sd	s2,48(sp)
    8000351e:	f44e                	sd	s3,40(sp)
    80003520:	f052                	sd	s4,32(sp)
    80003522:	ec56                	sd	s5,24(sp)
    80003524:	e85a                	sd	s6,16(sp)
    80003526:	e45e                	sd	s7,8(sp)
    80003528:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    8000352a:	0001c717          	auipc	a4,0x1c
    8000352e:	68a72703          	lw	a4,1674(a4) # 8001fbb4 <sb+0xc>
    80003532:	4785                	li	a5,1
    80003534:	04e7fa63          	bgeu	a5,a4,80003588 <ialloc+0x74>
    80003538:	8aaa                	mv	s5,a0
    8000353a:	8bae                	mv	s7,a1
    8000353c:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    8000353e:	0001ca17          	auipc	s4,0x1c
    80003542:	66aa0a13          	addi	s4,s4,1642 # 8001fba8 <sb>
    80003546:	00048b1b          	sext.w	s6,s1
    8000354a:	0044d593          	srli	a1,s1,0x4
    8000354e:	018a2783          	lw	a5,24(s4)
    80003552:	9dbd                	addw	a1,a1,a5
    80003554:	8556                	mv	a0,s5
    80003556:	00000097          	auipc	ra,0x0
    8000355a:	956080e7          	jalr	-1706(ra) # 80002eac <bread>
    8000355e:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80003560:	05850993          	addi	s3,a0,88
    80003564:	00f4f793          	andi	a5,s1,15
    80003568:	079a                	slli	a5,a5,0x6
    8000356a:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    8000356c:	00099783          	lh	a5,0(s3)
    80003570:	c785                	beqz	a5,80003598 <ialloc+0x84>
    brelse(bp);
    80003572:	00000097          	auipc	ra,0x0
    80003576:	a6a080e7          	jalr	-1430(ra) # 80002fdc <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    8000357a:	0485                	addi	s1,s1,1
    8000357c:	00ca2703          	lw	a4,12(s4)
    80003580:	0004879b          	sext.w	a5,s1
    80003584:	fce7e1e3          	bltu	a5,a4,80003546 <ialloc+0x32>
  panic("ialloc: no inodes");
    80003588:	00005517          	auipc	a0,0x5
    8000358c:	03050513          	addi	a0,a0,48 # 800085b8 <syscalls+0x170>
    80003590:	ffffd097          	auipc	ra,0xffffd
    80003594:	faa080e7          	jalr	-86(ra) # 8000053a <panic>
      memset(dip, 0, sizeof(*dip));
    80003598:	04000613          	li	a2,64
    8000359c:	4581                	li	a1,0
    8000359e:	854e                	mv	a0,s3
    800035a0:	ffffd097          	auipc	ra,0xffffd
    800035a4:	72c080e7          	jalr	1836(ra) # 80000ccc <memset>
      dip->type = type;
    800035a8:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    800035ac:	854a                	mv	a0,s2
    800035ae:	00001097          	auipc	ra,0x1
    800035b2:	cb2080e7          	jalr	-846(ra) # 80004260 <log_write>
      brelse(bp);
    800035b6:	854a                	mv	a0,s2
    800035b8:	00000097          	auipc	ra,0x0
    800035bc:	a24080e7          	jalr	-1500(ra) # 80002fdc <brelse>
      return iget(dev, inum);
    800035c0:	85da                	mv	a1,s6
    800035c2:	8556                	mv	a0,s5
    800035c4:	00000097          	auipc	ra,0x0
    800035c8:	db4080e7          	jalr	-588(ra) # 80003378 <iget>
}
    800035cc:	60a6                	ld	ra,72(sp)
    800035ce:	6406                	ld	s0,64(sp)
    800035d0:	74e2                	ld	s1,56(sp)
    800035d2:	7942                	ld	s2,48(sp)
    800035d4:	79a2                	ld	s3,40(sp)
    800035d6:	7a02                	ld	s4,32(sp)
    800035d8:	6ae2                	ld	s5,24(sp)
    800035da:	6b42                	ld	s6,16(sp)
    800035dc:	6ba2                	ld	s7,8(sp)
    800035de:	6161                	addi	sp,sp,80
    800035e0:	8082                	ret

00000000800035e2 <iupdate>:
{
    800035e2:	1101                	addi	sp,sp,-32
    800035e4:	ec06                	sd	ra,24(sp)
    800035e6:	e822                	sd	s0,16(sp)
    800035e8:	e426                	sd	s1,8(sp)
    800035ea:	e04a                	sd	s2,0(sp)
    800035ec:	1000                	addi	s0,sp,32
    800035ee:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800035f0:	415c                	lw	a5,4(a0)
    800035f2:	0047d79b          	srliw	a5,a5,0x4
    800035f6:	0001c597          	auipc	a1,0x1c
    800035fa:	5ca5a583          	lw	a1,1482(a1) # 8001fbc0 <sb+0x18>
    800035fe:	9dbd                	addw	a1,a1,a5
    80003600:	4108                	lw	a0,0(a0)
    80003602:	00000097          	auipc	ra,0x0
    80003606:	8aa080e7          	jalr	-1878(ra) # 80002eac <bread>
    8000360a:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    8000360c:	05850793          	addi	a5,a0,88
    80003610:	40d8                	lw	a4,4(s1)
    80003612:	8b3d                	andi	a4,a4,15
    80003614:	071a                	slli	a4,a4,0x6
    80003616:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80003618:	04449703          	lh	a4,68(s1)
    8000361c:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80003620:	04649703          	lh	a4,70(s1)
    80003624:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80003628:	04849703          	lh	a4,72(s1)
    8000362c:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80003630:	04a49703          	lh	a4,74(s1)
    80003634:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80003638:	44f8                	lw	a4,76(s1)
    8000363a:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    8000363c:	03400613          	li	a2,52
    80003640:	05048593          	addi	a1,s1,80
    80003644:	00c78513          	addi	a0,a5,12
    80003648:	ffffd097          	auipc	ra,0xffffd
    8000364c:	6e0080e7          	jalr	1760(ra) # 80000d28 <memmove>
  log_write(bp);
    80003650:	854a                	mv	a0,s2
    80003652:	00001097          	auipc	ra,0x1
    80003656:	c0e080e7          	jalr	-1010(ra) # 80004260 <log_write>
  brelse(bp);
    8000365a:	854a                	mv	a0,s2
    8000365c:	00000097          	auipc	ra,0x0
    80003660:	980080e7          	jalr	-1664(ra) # 80002fdc <brelse>
}
    80003664:	60e2                	ld	ra,24(sp)
    80003666:	6442                	ld	s0,16(sp)
    80003668:	64a2                	ld	s1,8(sp)
    8000366a:	6902                	ld	s2,0(sp)
    8000366c:	6105                	addi	sp,sp,32
    8000366e:	8082                	ret

0000000080003670 <idup>:
{
    80003670:	1101                	addi	sp,sp,-32
    80003672:	ec06                	sd	ra,24(sp)
    80003674:	e822                	sd	s0,16(sp)
    80003676:	e426                	sd	s1,8(sp)
    80003678:	1000                	addi	s0,sp,32
    8000367a:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    8000367c:	0001c517          	auipc	a0,0x1c
    80003680:	54c50513          	addi	a0,a0,1356 # 8001fbc8 <itable>
    80003684:	ffffd097          	auipc	ra,0xffffd
    80003688:	54c080e7          	jalr	1356(ra) # 80000bd0 <acquire>
  ip->ref++;
    8000368c:	449c                	lw	a5,8(s1)
    8000368e:	2785                	addiw	a5,a5,1
    80003690:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003692:	0001c517          	auipc	a0,0x1c
    80003696:	53650513          	addi	a0,a0,1334 # 8001fbc8 <itable>
    8000369a:	ffffd097          	auipc	ra,0xffffd
    8000369e:	5ea080e7          	jalr	1514(ra) # 80000c84 <release>
}
    800036a2:	8526                	mv	a0,s1
    800036a4:	60e2                	ld	ra,24(sp)
    800036a6:	6442                	ld	s0,16(sp)
    800036a8:	64a2                	ld	s1,8(sp)
    800036aa:	6105                	addi	sp,sp,32
    800036ac:	8082                	ret

00000000800036ae <ilock>:
{
    800036ae:	1101                	addi	sp,sp,-32
    800036b0:	ec06                	sd	ra,24(sp)
    800036b2:	e822                	sd	s0,16(sp)
    800036b4:	e426                	sd	s1,8(sp)
    800036b6:	e04a                	sd	s2,0(sp)
    800036b8:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    800036ba:	c115                	beqz	a0,800036de <ilock+0x30>
    800036bc:	84aa                	mv	s1,a0
    800036be:	451c                	lw	a5,8(a0)
    800036c0:	00f05f63          	blez	a5,800036de <ilock+0x30>
  acquiresleep(&ip->lock);
    800036c4:	0541                	addi	a0,a0,16
    800036c6:	00001097          	auipc	ra,0x1
    800036ca:	cb8080e7          	jalr	-840(ra) # 8000437e <acquiresleep>
  if(ip->valid == 0){
    800036ce:	40bc                	lw	a5,64(s1)
    800036d0:	cf99                	beqz	a5,800036ee <ilock+0x40>
}
    800036d2:	60e2                	ld	ra,24(sp)
    800036d4:	6442                	ld	s0,16(sp)
    800036d6:	64a2                	ld	s1,8(sp)
    800036d8:	6902                	ld	s2,0(sp)
    800036da:	6105                	addi	sp,sp,32
    800036dc:	8082                	ret
    panic("ilock");
    800036de:	00005517          	auipc	a0,0x5
    800036e2:	ef250513          	addi	a0,a0,-270 # 800085d0 <syscalls+0x188>
    800036e6:	ffffd097          	auipc	ra,0xffffd
    800036ea:	e54080e7          	jalr	-428(ra) # 8000053a <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800036ee:	40dc                	lw	a5,4(s1)
    800036f0:	0047d79b          	srliw	a5,a5,0x4
    800036f4:	0001c597          	auipc	a1,0x1c
    800036f8:	4cc5a583          	lw	a1,1228(a1) # 8001fbc0 <sb+0x18>
    800036fc:	9dbd                	addw	a1,a1,a5
    800036fe:	4088                	lw	a0,0(s1)
    80003700:	fffff097          	auipc	ra,0xfffff
    80003704:	7ac080e7          	jalr	1964(ra) # 80002eac <bread>
    80003708:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    8000370a:	05850593          	addi	a1,a0,88
    8000370e:	40dc                	lw	a5,4(s1)
    80003710:	8bbd                	andi	a5,a5,15
    80003712:	079a                	slli	a5,a5,0x6
    80003714:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80003716:	00059783          	lh	a5,0(a1)
    8000371a:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    8000371e:	00259783          	lh	a5,2(a1)
    80003722:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80003726:	00459783          	lh	a5,4(a1)
    8000372a:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    8000372e:	00659783          	lh	a5,6(a1)
    80003732:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80003736:	459c                	lw	a5,8(a1)
    80003738:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    8000373a:	03400613          	li	a2,52
    8000373e:	05b1                	addi	a1,a1,12
    80003740:	05048513          	addi	a0,s1,80
    80003744:	ffffd097          	auipc	ra,0xffffd
    80003748:	5e4080e7          	jalr	1508(ra) # 80000d28 <memmove>
    brelse(bp);
    8000374c:	854a                	mv	a0,s2
    8000374e:	00000097          	auipc	ra,0x0
    80003752:	88e080e7          	jalr	-1906(ra) # 80002fdc <brelse>
    ip->valid = 1;
    80003756:	4785                	li	a5,1
    80003758:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    8000375a:	04449783          	lh	a5,68(s1)
    8000375e:	fbb5                	bnez	a5,800036d2 <ilock+0x24>
      panic("ilock: no type");
    80003760:	00005517          	auipc	a0,0x5
    80003764:	e7850513          	addi	a0,a0,-392 # 800085d8 <syscalls+0x190>
    80003768:	ffffd097          	auipc	ra,0xffffd
    8000376c:	dd2080e7          	jalr	-558(ra) # 8000053a <panic>

0000000080003770 <iunlock>:
{
    80003770:	1101                	addi	sp,sp,-32
    80003772:	ec06                	sd	ra,24(sp)
    80003774:	e822                	sd	s0,16(sp)
    80003776:	e426                	sd	s1,8(sp)
    80003778:	e04a                	sd	s2,0(sp)
    8000377a:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    8000377c:	c905                	beqz	a0,800037ac <iunlock+0x3c>
    8000377e:	84aa                	mv	s1,a0
    80003780:	01050913          	addi	s2,a0,16
    80003784:	854a                	mv	a0,s2
    80003786:	00001097          	auipc	ra,0x1
    8000378a:	c92080e7          	jalr	-878(ra) # 80004418 <holdingsleep>
    8000378e:	cd19                	beqz	a0,800037ac <iunlock+0x3c>
    80003790:	449c                	lw	a5,8(s1)
    80003792:	00f05d63          	blez	a5,800037ac <iunlock+0x3c>
  releasesleep(&ip->lock);
    80003796:	854a                	mv	a0,s2
    80003798:	00001097          	auipc	ra,0x1
    8000379c:	c3c080e7          	jalr	-964(ra) # 800043d4 <releasesleep>
}
    800037a0:	60e2                	ld	ra,24(sp)
    800037a2:	6442                	ld	s0,16(sp)
    800037a4:	64a2                	ld	s1,8(sp)
    800037a6:	6902                	ld	s2,0(sp)
    800037a8:	6105                	addi	sp,sp,32
    800037aa:	8082                	ret
    panic("iunlock");
    800037ac:	00005517          	auipc	a0,0x5
    800037b0:	e3c50513          	addi	a0,a0,-452 # 800085e8 <syscalls+0x1a0>
    800037b4:	ffffd097          	auipc	ra,0xffffd
    800037b8:	d86080e7          	jalr	-634(ra) # 8000053a <panic>

00000000800037bc <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    800037bc:	7179                	addi	sp,sp,-48
    800037be:	f406                	sd	ra,40(sp)
    800037c0:	f022                	sd	s0,32(sp)
    800037c2:	ec26                	sd	s1,24(sp)
    800037c4:	e84a                	sd	s2,16(sp)
    800037c6:	e44e                	sd	s3,8(sp)
    800037c8:	e052                	sd	s4,0(sp)
    800037ca:	1800                	addi	s0,sp,48
    800037cc:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    800037ce:	05050493          	addi	s1,a0,80
    800037d2:	08050913          	addi	s2,a0,128
    800037d6:	a021                	j	800037de <itrunc+0x22>
    800037d8:	0491                	addi	s1,s1,4
    800037da:	01248d63          	beq	s1,s2,800037f4 <itrunc+0x38>
    if(ip->addrs[i]){
    800037de:	408c                	lw	a1,0(s1)
    800037e0:	dde5                	beqz	a1,800037d8 <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    800037e2:	0009a503          	lw	a0,0(s3)
    800037e6:	00000097          	auipc	ra,0x0
    800037ea:	90c080e7          	jalr	-1780(ra) # 800030f2 <bfree>
      ip->addrs[i] = 0;
    800037ee:	0004a023          	sw	zero,0(s1)
    800037f2:	b7dd                	j	800037d8 <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    800037f4:	0809a583          	lw	a1,128(s3)
    800037f8:	e185                	bnez	a1,80003818 <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    800037fa:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    800037fe:	854e                	mv	a0,s3
    80003800:	00000097          	auipc	ra,0x0
    80003804:	de2080e7          	jalr	-542(ra) # 800035e2 <iupdate>
}
    80003808:	70a2                	ld	ra,40(sp)
    8000380a:	7402                	ld	s0,32(sp)
    8000380c:	64e2                	ld	s1,24(sp)
    8000380e:	6942                	ld	s2,16(sp)
    80003810:	69a2                	ld	s3,8(sp)
    80003812:	6a02                	ld	s4,0(sp)
    80003814:	6145                	addi	sp,sp,48
    80003816:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80003818:	0009a503          	lw	a0,0(s3)
    8000381c:	fffff097          	auipc	ra,0xfffff
    80003820:	690080e7          	jalr	1680(ra) # 80002eac <bread>
    80003824:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80003826:	05850493          	addi	s1,a0,88
    8000382a:	45850913          	addi	s2,a0,1112
    8000382e:	a021                	j	80003836 <itrunc+0x7a>
    80003830:	0491                	addi	s1,s1,4
    80003832:	01248b63          	beq	s1,s2,80003848 <itrunc+0x8c>
      if(a[j])
    80003836:	408c                	lw	a1,0(s1)
    80003838:	dde5                	beqz	a1,80003830 <itrunc+0x74>
        bfree(ip->dev, a[j]);
    8000383a:	0009a503          	lw	a0,0(s3)
    8000383e:	00000097          	auipc	ra,0x0
    80003842:	8b4080e7          	jalr	-1868(ra) # 800030f2 <bfree>
    80003846:	b7ed                	j	80003830 <itrunc+0x74>
    brelse(bp);
    80003848:	8552                	mv	a0,s4
    8000384a:	fffff097          	auipc	ra,0xfffff
    8000384e:	792080e7          	jalr	1938(ra) # 80002fdc <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80003852:	0809a583          	lw	a1,128(s3)
    80003856:	0009a503          	lw	a0,0(s3)
    8000385a:	00000097          	auipc	ra,0x0
    8000385e:	898080e7          	jalr	-1896(ra) # 800030f2 <bfree>
    ip->addrs[NDIRECT] = 0;
    80003862:	0809a023          	sw	zero,128(s3)
    80003866:	bf51                	j	800037fa <itrunc+0x3e>

0000000080003868 <iput>:
{
    80003868:	1101                	addi	sp,sp,-32
    8000386a:	ec06                	sd	ra,24(sp)
    8000386c:	e822                	sd	s0,16(sp)
    8000386e:	e426                	sd	s1,8(sp)
    80003870:	e04a                	sd	s2,0(sp)
    80003872:	1000                	addi	s0,sp,32
    80003874:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003876:	0001c517          	auipc	a0,0x1c
    8000387a:	35250513          	addi	a0,a0,850 # 8001fbc8 <itable>
    8000387e:	ffffd097          	auipc	ra,0xffffd
    80003882:	352080e7          	jalr	850(ra) # 80000bd0 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003886:	4498                	lw	a4,8(s1)
    80003888:	4785                	li	a5,1
    8000388a:	02f70363          	beq	a4,a5,800038b0 <iput+0x48>
  ip->ref--;
    8000388e:	449c                	lw	a5,8(s1)
    80003890:	37fd                	addiw	a5,a5,-1
    80003892:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003894:	0001c517          	auipc	a0,0x1c
    80003898:	33450513          	addi	a0,a0,820 # 8001fbc8 <itable>
    8000389c:	ffffd097          	auipc	ra,0xffffd
    800038a0:	3e8080e7          	jalr	1000(ra) # 80000c84 <release>
}
    800038a4:	60e2                	ld	ra,24(sp)
    800038a6:	6442                	ld	s0,16(sp)
    800038a8:	64a2                	ld	s1,8(sp)
    800038aa:	6902                	ld	s2,0(sp)
    800038ac:	6105                	addi	sp,sp,32
    800038ae:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800038b0:	40bc                	lw	a5,64(s1)
    800038b2:	dff1                	beqz	a5,8000388e <iput+0x26>
    800038b4:	04a49783          	lh	a5,74(s1)
    800038b8:	fbf9                	bnez	a5,8000388e <iput+0x26>
    acquiresleep(&ip->lock);
    800038ba:	01048913          	addi	s2,s1,16
    800038be:	854a                	mv	a0,s2
    800038c0:	00001097          	auipc	ra,0x1
    800038c4:	abe080e7          	jalr	-1346(ra) # 8000437e <acquiresleep>
    release(&itable.lock);
    800038c8:	0001c517          	auipc	a0,0x1c
    800038cc:	30050513          	addi	a0,a0,768 # 8001fbc8 <itable>
    800038d0:	ffffd097          	auipc	ra,0xffffd
    800038d4:	3b4080e7          	jalr	948(ra) # 80000c84 <release>
    itrunc(ip);
    800038d8:	8526                	mv	a0,s1
    800038da:	00000097          	auipc	ra,0x0
    800038de:	ee2080e7          	jalr	-286(ra) # 800037bc <itrunc>
    ip->type = 0;
    800038e2:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    800038e6:	8526                	mv	a0,s1
    800038e8:	00000097          	auipc	ra,0x0
    800038ec:	cfa080e7          	jalr	-774(ra) # 800035e2 <iupdate>
    ip->valid = 0;
    800038f0:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    800038f4:	854a                	mv	a0,s2
    800038f6:	00001097          	auipc	ra,0x1
    800038fa:	ade080e7          	jalr	-1314(ra) # 800043d4 <releasesleep>
    acquire(&itable.lock);
    800038fe:	0001c517          	auipc	a0,0x1c
    80003902:	2ca50513          	addi	a0,a0,714 # 8001fbc8 <itable>
    80003906:	ffffd097          	auipc	ra,0xffffd
    8000390a:	2ca080e7          	jalr	714(ra) # 80000bd0 <acquire>
    8000390e:	b741                	j	8000388e <iput+0x26>

0000000080003910 <iunlockput>:
{
    80003910:	1101                	addi	sp,sp,-32
    80003912:	ec06                	sd	ra,24(sp)
    80003914:	e822                	sd	s0,16(sp)
    80003916:	e426                	sd	s1,8(sp)
    80003918:	1000                	addi	s0,sp,32
    8000391a:	84aa                	mv	s1,a0
  iunlock(ip);
    8000391c:	00000097          	auipc	ra,0x0
    80003920:	e54080e7          	jalr	-428(ra) # 80003770 <iunlock>
  iput(ip);
    80003924:	8526                	mv	a0,s1
    80003926:	00000097          	auipc	ra,0x0
    8000392a:	f42080e7          	jalr	-190(ra) # 80003868 <iput>
}
    8000392e:	60e2                	ld	ra,24(sp)
    80003930:	6442                	ld	s0,16(sp)
    80003932:	64a2                	ld	s1,8(sp)
    80003934:	6105                	addi	sp,sp,32
    80003936:	8082                	ret

0000000080003938 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80003938:	1141                	addi	sp,sp,-16
    8000393a:	e422                	sd	s0,8(sp)
    8000393c:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    8000393e:	411c                	lw	a5,0(a0)
    80003940:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80003942:	415c                	lw	a5,4(a0)
    80003944:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80003946:	04451783          	lh	a5,68(a0)
    8000394a:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    8000394e:	04a51783          	lh	a5,74(a0)
    80003952:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80003956:	04c56783          	lwu	a5,76(a0)
    8000395a:	e99c                	sd	a5,16(a1)
}
    8000395c:	6422                	ld	s0,8(sp)
    8000395e:	0141                	addi	sp,sp,16
    80003960:	8082                	ret

0000000080003962 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003962:	457c                	lw	a5,76(a0)
    80003964:	0ed7e963          	bltu	a5,a3,80003a56 <readi+0xf4>
{
    80003968:	7159                	addi	sp,sp,-112
    8000396a:	f486                	sd	ra,104(sp)
    8000396c:	f0a2                	sd	s0,96(sp)
    8000396e:	eca6                	sd	s1,88(sp)
    80003970:	e8ca                	sd	s2,80(sp)
    80003972:	e4ce                	sd	s3,72(sp)
    80003974:	e0d2                	sd	s4,64(sp)
    80003976:	fc56                	sd	s5,56(sp)
    80003978:	f85a                	sd	s6,48(sp)
    8000397a:	f45e                	sd	s7,40(sp)
    8000397c:	f062                	sd	s8,32(sp)
    8000397e:	ec66                	sd	s9,24(sp)
    80003980:	e86a                	sd	s10,16(sp)
    80003982:	e46e                	sd	s11,8(sp)
    80003984:	1880                	addi	s0,sp,112
    80003986:	8baa                	mv	s7,a0
    80003988:	8c2e                	mv	s8,a1
    8000398a:	8ab2                	mv	s5,a2
    8000398c:	84b6                	mv	s1,a3
    8000398e:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003990:	9f35                	addw	a4,a4,a3
    return 0;
    80003992:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003994:	0ad76063          	bltu	a4,a3,80003a34 <readi+0xd2>
  if(off + n > ip->size)
    80003998:	00e7f463          	bgeu	a5,a4,800039a0 <readi+0x3e>
    n = ip->size - off;
    8000399c:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800039a0:	0a0b0963          	beqz	s6,80003a52 <readi+0xf0>
    800039a4:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    800039a6:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    800039aa:	5cfd                	li	s9,-1
    800039ac:	a82d                	j	800039e6 <readi+0x84>
    800039ae:	020a1d93          	slli	s11,s4,0x20
    800039b2:	020ddd93          	srli	s11,s11,0x20
    800039b6:	05890613          	addi	a2,s2,88
    800039ba:	86ee                	mv	a3,s11
    800039bc:	963a                	add	a2,a2,a4
    800039be:	85d6                	mv	a1,s5
    800039c0:	8562                	mv	a0,s8
    800039c2:	fffff097          	auipc	ra,0xfffff
    800039c6:	a46080e7          	jalr	-1466(ra) # 80002408 <either_copyout>
    800039ca:	05950d63          	beq	a0,s9,80003a24 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    800039ce:	854a                	mv	a0,s2
    800039d0:	fffff097          	auipc	ra,0xfffff
    800039d4:	60c080e7          	jalr	1548(ra) # 80002fdc <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800039d8:	013a09bb          	addw	s3,s4,s3
    800039dc:	009a04bb          	addw	s1,s4,s1
    800039e0:	9aee                	add	s5,s5,s11
    800039e2:	0569f763          	bgeu	s3,s6,80003a30 <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    800039e6:	000ba903          	lw	s2,0(s7)
    800039ea:	00a4d59b          	srliw	a1,s1,0xa
    800039ee:	855e                	mv	a0,s7
    800039f0:	00000097          	auipc	ra,0x0
    800039f4:	8ac080e7          	jalr	-1876(ra) # 8000329c <bmap>
    800039f8:	0005059b          	sext.w	a1,a0
    800039fc:	854a                	mv	a0,s2
    800039fe:	fffff097          	auipc	ra,0xfffff
    80003a02:	4ae080e7          	jalr	1198(ra) # 80002eac <bread>
    80003a06:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003a08:	3ff4f713          	andi	a4,s1,1023
    80003a0c:	40ed07bb          	subw	a5,s10,a4
    80003a10:	413b06bb          	subw	a3,s6,s3
    80003a14:	8a3e                	mv	s4,a5
    80003a16:	2781                	sext.w	a5,a5
    80003a18:	0006861b          	sext.w	a2,a3
    80003a1c:	f8f679e3          	bgeu	a2,a5,800039ae <readi+0x4c>
    80003a20:	8a36                	mv	s4,a3
    80003a22:	b771                	j	800039ae <readi+0x4c>
      brelse(bp);
    80003a24:	854a                	mv	a0,s2
    80003a26:	fffff097          	auipc	ra,0xfffff
    80003a2a:	5b6080e7          	jalr	1462(ra) # 80002fdc <brelse>
      tot = -1;
    80003a2e:	59fd                	li	s3,-1
  }
  return tot;
    80003a30:	0009851b          	sext.w	a0,s3
}
    80003a34:	70a6                	ld	ra,104(sp)
    80003a36:	7406                	ld	s0,96(sp)
    80003a38:	64e6                	ld	s1,88(sp)
    80003a3a:	6946                	ld	s2,80(sp)
    80003a3c:	69a6                	ld	s3,72(sp)
    80003a3e:	6a06                	ld	s4,64(sp)
    80003a40:	7ae2                	ld	s5,56(sp)
    80003a42:	7b42                	ld	s6,48(sp)
    80003a44:	7ba2                	ld	s7,40(sp)
    80003a46:	7c02                	ld	s8,32(sp)
    80003a48:	6ce2                	ld	s9,24(sp)
    80003a4a:	6d42                	ld	s10,16(sp)
    80003a4c:	6da2                	ld	s11,8(sp)
    80003a4e:	6165                	addi	sp,sp,112
    80003a50:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003a52:	89da                	mv	s3,s6
    80003a54:	bff1                	j	80003a30 <readi+0xce>
    return 0;
    80003a56:	4501                	li	a0,0
}
    80003a58:	8082                	ret

0000000080003a5a <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003a5a:	457c                	lw	a5,76(a0)
    80003a5c:	10d7e863          	bltu	a5,a3,80003b6c <writei+0x112>
{
    80003a60:	7159                	addi	sp,sp,-112
    80003a62:	f486                	sd	ra,104(sp)
    80003a64:	f0a2                	sd	s0,96(sp)
    80003a66:	eca6                	sd	s1,88(sp)
    80003a68:	e8ca                	sd	s2,80(sp)
    80003a6a:	e4ce                	sd	s3,72(sp)
    80003a6c:	e0d2                	sd	s4,64(sp)
    80003a6e:	fc56                	sd	s5,56(sp)
    80003a70:	f85a                	sd	s6,48(sp)
    80003a72:	f45e                	sd	s7,40(sp)
    80003a74:	f062                	sd	s8,32(sp)
    80003a76:	ec66                	sd	s9,24(sp)
    80003a78:	e86a                	sd	s10,16(sp)
    80003a7a:	e46e                	sd	s11,8(sp)
    80003a7c:	1880                	addi	s0,sp,112
    80003a7e:	8b2a                	mv	s6,a0
    80003a80:	8c2e                	mv	s8,a1
    80003a82:	8ab2                	mv	s5,a2
    80003a84:	8936                	mv	s2,a3
    80003a86:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    80003a88:	00e687bb          	addw	a5,a3,a4
    80003a8c:	0ed7e263          	bltu	a5,a3,80003b70 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80003a90:	00043737          	lui	a4,0x43
    80003a94:	0ef76063          	bltu	a4,a5,80003b74 <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003a98:	0c0b8863          	beqz	s7,80003b68 <writei+0x10e>
    80003a9c:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003a9e:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003aa2:	5cfd                	li	s9,-1
    80003aa4:	a091                	j	80003ae8 <writei+0x8e>
    80003aa6:	02099d93          	slli	s11,s3,0x20
    80003aaa:	020ddd93          	srli	s11,s11,0x20
    80003aae:	05848513          	addi	a0,s1,88
    80003ab2:	86ee                	mv	a3,s11
    80003ab4:	8656                	mv	a2,s5
    80003ab6:	85e2                	mv	a1,s8
    80003ab8:	953a                	add	a0,a0,a4
    80003aba:	fffff097          	auipc	ra,0xfffff
    80003abe:	9a4080e7          	jalr	-1628(ra) # 8000245e <either_copyin>
    80003ac2:	07950263          	beq	a0,s9,80003b26 <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80003ac6:	8526                	mv	a0,s1
    80003ac8:	00000097          	auipc	ra,0x0
    80003acc:	798080e7          	jalr	1944(ra) # 80004260 <log_write>
    brelse(bp);
    80003ad0:	8526                	mv	a0,s1
    80003ad2:	fffff097          	auipc	ra,0xfffff
    80003ad6:	50a080e7          	jalr	1290(ra) # 80002fdc <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003ada:	01498a3b          	addw	s4,s3,s4
    80003ade:	0129893b          	addw	s2,s3,s2
    80003ae2:	9aee                	add	s5,s5,s11
    80003ae4:	057a7663          	bgeu	s4,s7,80003b30 <writei+0xd6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003ae8:	000b2483          	lw	s1,0(s6)
    80003aec:	00a9559b          	srliw	a1,s2,0xa
    80003af0:	855a                	mv	a0,s6
    80003af2:	fffff097          	auipc	ra,0xfffff
    80003af6:	7aa080e7          	jalr	1962(ra) # 8000329c <bmap>
    80003afa:	0005059b          	sext.w	a1,a0
    80003afe:	8526                	mv	a0,s1
    80003b00:	fffff097          	auipc	ra,0xfffff
    80003b04:	3ac080e7          	jalr	940(ra) # 80002eac <bread>
    80003b08:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003b0a:	3ff97713          	andi	a4,s2,1023
    80003b0e:	40ed07bb          	subw	a5,s10,a4
    80003b12:	414b86bb          	subw	a3,s7,s4
    80003b16:	89be                	mv	s3,a5
    80003b18:	2781                	sext.w	a5,a5
    80003b1a:	0006861b          	sext.w	a2,a3
    80003b1e:	f8f674e3          	bgeu	a2,a5,80003aa6 <writei+0x4c>
    80003b22:	89b6                	mv	s3,a3
    80003b24:	b749                	j	80003aa6 <writei+0x4c>
      brelse(bp);
    80003b26:	8526                	mv	a0,s1
    80003b28:	fffff097          	auipc	ra,0xfffff
    80003b2c:	4b4080e7          	jalr	1204(ra) # 80002fdc <brelse>
  }

  if(off > ip->size)
    80003b30:	04cb2783          	lw	a5,76(s6)
    80003b34:	0127f463          	bgeu	a5,s2,80003b3c <writei+0xe2>
    ip->size = off;
    80003b38:	052b2623          	sw	s2,76(s6)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003b3c:	855a                	mv	a0,s6
    80003b3e:	00000097          	auipc	ra,0x0
    80003b42:	aa4080e7          	jalr	-1372(ra) # 800035e2 <iupdate>

  return tot;
    80003b46:	000a051b          	sext.w	a0,s4
}
    80003b4a:	70a6                	ld	ra,104(sp)
    80003b4c:	7406                	ld	s0,96(sp)
    80003b4e:	64e6                	ld	s1,88(sp)
    80003b50:	6946                	ld	s2,80(sp)
    80003b52:	69a6                	ld	s3,72(sp)
    80003b54:	6a06                	ld	s4,64(sp)
    80003b56:	7ae2                	ld	s5,56(sp)
    80003b58:	7b42                	ld	s6,48(sp)
    80003b5a:	7ba2                	ld	s7,40(sp)
    80003b5c:	7c02                	ld	s8,32(sp)
    80003b5e:	6ce2                	ld	s9,24(sp)
    80003b60:	6d42                	ld	s10,16(sp)
    80003b62:	6da2                	ld	s11,8(sp)
    80003b64:	6165                	addi	sp,sp,112
    80003b66:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003b68:	8a5e                	mv	s4,s7
    80003b6a:	bfc9                	j	80003b3c <writei+0xe2>
    return -1;
    80003b6c:	557d                	li	a0,-1
}
    80003b6e:	8082                	ret
    return -1;
    80003b70:	557d                	li	a0,-1
    80003b72:	bfe1                	j	80003b4a <writei+0xf0>
    return -1;
    80003b74:	557d                	li	a0,-1
    80003b76:	bfd1                	j	80003b4a <writei+0xf0>

0000000080003b78 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003b78:	1141                	addi	sp,sp,-16
    80003b7a:	e406                	sd	ra,8(sp)
    80003b7c:	e022                	sd	s0,0(sp)
    80003b7e:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003b80:	4639                	li	a2,14
    80003b82:	ffffd097          	auipc	ra,0xffffd
    80003b86:	21a080e7          	jalr	538(ra) # 80000d9c <strncmp>
}
    80003b8a:	60a2                	ld	ra,8(sp)
    80003b8c:	6402                	ld	s0,0(sp)
    80003b8e:	0141                	addi	sp,sp,16
    80003b90:	8082                	ret

0000000080003b92 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80003b92:	7139                	addi	sp,sp,-64
    80003b94:	fc06                	sd	ra,56(sp)
    80003b96:	f822                	sd	s0,48(sp)
    80003b98:	f426                	sd	s1,40(sp)
    80003b9a:	f04a                	sd	s2,32(sp)
    80003b9c:	ec4e                	sd	s3,24(sp)
    80003b9e:	e852                	sd	s4,16(sp)
    80003ba0:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003ba2:	04451703          	lh	a4,68(a0)
    80003ba6:	4785                	li	a5,1
    80003ba8:	00f71a63          	bne	a4,a5,80003bbc <dirlookup+0x2a>
    80003bac:	892a                	mv	s2,a0
    80003bae:	89ae                	mv	s3,a1
    80003bb0:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003bb2:	457c                	lw	a5,76(a0)
    80003bb4:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003bb6:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003bb8:	e79d                	bnez	a5,80003be6 <dirlookup+0x54>
    80003bba:	a8a5                	j	80003c32 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003bbc:	00005517          	auipc	a0,0x5
    80003bc0:	a3450513          	addi	a0,a0,-1484 # 800085f0 <syscalls+0x1a8>
    80003bc4:	ffffd097          	auipc	ra,0xffffd
    80003bc8:	976080e7          	jalr	-1674(ra) # 8000053a <panic>
      panic("dirlookup read");
    80003bcc:	00005517          	auipc	a0,0x5
    80003bd0:	a3c50513          	addi	a0,a0,-1476 # 80008608 <syscalls+0x1c0>
    80003bd4:	ffffd097          	auipc	ra,0xffffd
    80003bd8:	966080e7          	jalr	-1690(ra) # 8000053a <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003bdc:	24c1                	addiw	s1,s1,16
    80003bde:	04c92783          	lw	a5,76(s2)
    80003be2:	04f4f763          	bgeu	s1,a5,80003c30 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003be6:	4741                	li	a4,16
    80003be8:	86a6                	mv	a3,s1
    80003bea:	fc040613          	addi	a2,s0,-64
    80003bee:	4581                	li	a1,0
    80003bf0:	854a                	mv	a0,s2
    80003bf2:	00000097          	auipc	ra,0x0
    80003bf6:	d70080e7          	jalr	-656(ra) # 80003962 <readi>
    80003bfa:	47c1                	li	a5,16
    80003bfc:	fcf518e3          	bne	a0,a5,80003bcc <dirlookup+0x3a>
    if(de.inum == 0)
    80003c00:	fc045783          	lhu	a5,-64(s0)
    80003c04:	dfe1                	beqz	a5,80003bdc <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80003c06:	fc240593          	addi	a1,s0,-62
    80003c0a:	854e                	mv	a0,s3
    80003c0c:	00000097          	auipc	ra,0x0
    80003c10:	f6c080e7          	jalr	-148(ra) # 80003b78 <namecmp>
    80003c14:	f561                	bnez	a0,80003bdc <dirlookup+0x4a>
      if(poff)
    80003c16:	000a0463          	beqz	s4,80003c1e <dirlookup+0x8c>
        *poff = off;
    80003c1a:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80003c1e:	fc045583          	lhu	a1,-64(s0)
    80003c22:	00092503          	lw	a0,0(s2)
    80003c26:	fffff097          	auipc	ra,0xfffff
    80003c2a:	752080e7          	jalr	1874(ra) # 80003378 <iget>
    80003c2e:	a011                	j	80003c32 <dirlookup+0xa0>
  return 0;
    80003c30:	4501                	li	a0,0
}
    80003c32:	70e2                	ld	ra,56(sp)
    80003c34:	7442                	ld	s0,48(sp)
    80003c36:	74a2                	ld	s1,40(sp)
    80003c38:	7902                	ld	s2,32(sp)
    80003c3a:	69e2                	ld	s3,24(sp)
    80003c3c:	6a42                	ld	s4,16(sp)
    80003c3e:	6121                	addi	sp,sp,64
    80003c40:	8082                	ret

0000000080003c42 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003c42:	711d                	addi	sp,sp,-96
    80003c44:	ec86                	sd	ra,88(sp)
    80003c46:	e8a2                	sd	s0,80(sp)
    80003c48:	e4a6                	sd	s1,72(sp)
    80003c4a:	e0ca                	sd	s2,64(sp)
    80003c4c:	fc4e                	sd	s3,56(sp)
    80003c4e:	f852                	sd	s4,48(sp)
    80003c50:	f456                	sd	s5,40(sp)
    80003c52:	f05a                	sd	s6,32(sp)
    80003c54:	ec5e                	sd	s7,24(sp)
    80003c56:	e862                	sd	s8,16(sp)
    80003c58:	e466                	sd	s9,8(sp)
    80003c5a:	e06a                	sd	s10,0(sp)
    80003c5c:	1080                	addi	s0,sp,96
    80003c5e:	84aa                	mv	s1,a0
    80003c60:	8b2e                	mv	s6,a1
    80003c62:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003c64:	00054703          	lbu	a4,0(a0)
    80003c68:	02f00793          	li	a5,47
    80003c6c:	02f70363          	beq	a4,a5,80003c92 <namex+0x50>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003c70:	ffffe097          	auipc	ra,0xffffe
    80003c74:	d26080e7          	jalr	-730(ra) # 80001996 <myproc>
    80003c78:	16053503          	ld	a0,352(a0)
    80003c7c:	00000097          	auipc	ra,0x0
    80003c80:	9f4080e7          	jalr	-1548(ra) # 80003670 <idup>
    80003c84:	8a2a                	mv	s4,a0
  while(*path == '/')
    80003c86:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    80003c8a:	4cb5                	li	s9,13
  len = path - s;
    80003c8c:	4b81                	li	s7,0

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003c8e:	4c05                	li	s8,1
    80003c90:	a87d                	j	80003d4e <namex+0x10c>
    ip = iget(ROOTDEV, ROOTINO);
    80003c92:	4585                	li	a1,1
    80003c94:	4505                	li	a0,1
    80003c96:	fffff097          	auipc	ra,0xfffff
    80003c9a:	6e2080e7          	jalr	1762(ra) # 80003378 <iget>
    80003c9e:	8a2a                	mv	s4,a0
    80003ca0:	b7dd                	j	80003c86 <namex+0x44>
      iunlockput(ip);
    80003ca2:	8552                	mv	a0,s4
    80003ca4:	00000097          	auipc	ra,0x0
    80003ca8:	c6c080e7          	jalr	-916(ra) # 80003910 <iunlockput>
      return 0;
    80003cac:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003cae:	8552                	mv	a0,s4
    80003cb0:	60e6                	ld	ra,88(sp)
    80003cb2:	6446                	ld	s0,80(sp)
    80003cb4:	64a6                	ld	s1,72(sp)
    80003cb6:	6906                	ld	s2,64(sp)
    80003cb8:	79e2                	ld	s3,56(sp)
    80003cba:	7a42                	ld	s4,48(sp)
    80003cbc:	7aa2                	ld	s5,40(sp)
    80003cbe:	7b02                	ld	s6,32(sp)
    80003cc0:	6be2                	ld	s7,24(sp)
    80003cc2:	6c42                	ld	s8,16(sp)
    80003cc4:	6ca2                	ld	s9,8(sp)
    80003cc6:	6d02                	ld	s10,0(sp)
    80003cc8:	6125                	addi	sp,sp,96
    80003cca:	8082                	ret
      iunlock(ip);
    80003ccc:	8552                	mv	a0,s4
    80003cce:	00000097          	auipc	ra,0x0
    80003cd2:	aa2080e7          	jalr	-1374(ra) # 80003770 <iunlock>
      return ip;
    80003cd6:	bfe1                	j	80003cae <namex+0x6c>
      iunlockput(ip);
    80003cd8:	8552                	mv	a0,s4
    80003cda:	00000097          	auipc	ra,0x0
    80003cde:	c36080e7          	jalr	-970(ra) # 80003910 <iunlockput>
      return 0;
    80003ce2:	8a4e                	mv	s4,s3
    80003ce4:	b7e9                	j	80003cae <namex+0x6c>
  len = path - s;
    80003ce6:	40998633          	sub	a2,s3,s1
    80003cea:	00060d1b          	sext.w	s10,a2
  if(len >= DIRSIZ)
    80003cee:	09acd863          	bge	s9,s10,80003d7e <namex+0x13c>
    memmove(name, s, DIRSIZ);
    80003cf2:	4639                	li	a2,14
    80003cf4:	85a6                	mv	a1,s1
    80003cf6:	8556                	mv	a0,s5
    80003cf8:	ffffd097          	auipc	ra,0xffffd
    80003cfc:	030080e7          	jalr	48(ra) # 80000d28 <memmove>
    80003d00:	84ce                	mv	s1,s3
  while(*path == '/')
    80003d02:	0004c783          	lbu	a5,0(s1)
    80003d06:	01279763          	bne	a5,s2,80003d14 <namex+0xd2>
    path++;
    80003d0a:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003d0c:	0004c783          	lbu	a5,0(s1)
    80003d10:	ff278de3          	beq	a5,s2,80003d0a <namex+0xc8>
    ilock(ip);
    80003d14:	8552                	mv	a0,s4
    80003d16:	00000097          	auipc	ra,0x0
    80003d1a:	998080e7          	jalr	-1640(ra) # 800036ae <ilock>
    if(ip->type != T_DIR){
    80003d1e:	044a1783          	lh	a5,68(s4)
    80003d22:	f98790e3          	bne	a5,s8,80003ca2 <namex+0x60>
    if(nameiparent && *path == '\0'){
    80003d26:	000b0563          	beqz	s6,80003d30 <namex+0xee>
    80003d2a:	0004c783          	lbu	a5,0(s1)
    80003d2e:	dfd9                	beqz	a5,80003ccc <namex+0x8a>
    if((next = dirlookup(ip, name, 0)) == 0){
    80003d30:	865e                	mv	a2,s7
    80003d32:	85d6                	mv	a1,s5
    80003d34:	8552                	mv	a0,s4
    80003d36:	00000097          	auipc	ra,0x0
    80003d3a:	e5c080e7          	jalr	-420(ra) # 80003b92 <dirlookup>
    80003d3e:	89aa                	mv	s3,a0
    80003d40:	dd41                	beqz	a0,80003cd8 <namex+0x96>
    iunlockput(ip);
    80003d42:	8552                	mv	a0,s4
    80003d44:	00000097          	auipc	ra,0x0
    80003d48:	bcc080e7          	jalr	-1076(ra) # 80003910 <iunlockput>
    ip = next;
    80003d4c:	8a4e                	mv	s4,s3
  while(*path == '/')
    80003d4e:	0004c783          	lbu	a5,0(s1)
    80003d52:	01279763          	bne	a5,s2,80003d60 <namex+0x11e>
    path++;
    80003d56:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003d58:	0004c783          	lbu	a5,0(s1)
    80003d5c:	ff278de3          	beq	a5,s2,80003d56 <namex+0x114>
  if(*path == 0)
    80003d60:	cb9d                	beqz	a5,80003d96 <namex+0x154>
  while(*path != '/' && *path != 0)
    80003d62:	0004c783          	lbu	a5,0(s1)
    80003d66:	89a6                	mv	s3,s1
  len = path - s;
    80003d68:	8d5e                	mv	s10,s7
    80003d6a:	865e                	mv	a2,s7
  while(*path != '/' && *path != 0)
    80003d6c:	01278963          	beq	a5,s2,80003d7e <namex+0x13c>
    80003d70:	dbbd                	beqz	a5,80003ce6 <namex+0xa4>
    path++;
    80003d72:	0985                	addi	s3,s3,1
  while(*path != '/' && *path != 0)
    80003d74:	0009c783          	lbu	a5,0(s3)
    80003d78:	ff279ce3          	bne	a5,s2,80003d70 <namex+0x12e>
    80003d7c:	b7ad                	j	80003ce6 <namex+0xa4>
    memmove(name, s, len);
    80003d7e:	2601                	sext.w	a2,a2
    80003d80:	85a6                	mv	a1,s1
    80003d82:	8556                	mv	a0,s5
    80003d84:	ffffd097          	auipc	ra,0xffffd
    80003d88:	fa4080e7          	jalr	-92(ra) # 80000d28 <memmove>
    name[len] = 0;
    80003d8c:	9d56                	add	s10,s10,s5
    80003d8e:	000d0023          	sb	zero,0(s10)
    80003d92:	84ce                	mv	s1,s3
    80003d94:	b7bd                	j	80003d02 <namex+0xc0>
  if(nameiparent){
    80003d96:	f00b0ce3          	beqz	s6,80003cae <namex+0x6c>
    iput(ip);
    80003d9a:	8552                	mv	a0,s4
    80003d9c:	00000097          	auipc	ra,0x0
    80003da0:	acc080e7          	jalr	-1332(ra) # 80003868 <iput>
    return 0;
    80003da4:	4a01                	li	s4,0
    80003da6:	b721                	j	80003cae <namex+0x6c>

0000000080003da8 <dirlink>:
{
    80003da8:	7139                	addi	sp,sp,-64
    80003daa:	fc06                	sd	ra,56(sp)
    80003dac:	f822                	sd	s0,48(sp)
    80003dae:	f426                	sd	s1,40(sp)
    80003db0:	f04a                	sd	s2,32(sp)
    80003db2:	ec4e                	sd	s3,24(sp)
    80003db4:	e852                	sd	s4,16(sp)
    80003db6:	0080                	addi	s0,sp,64
    80003db8:	892a                	mv	s2,a0
    80003dba:	8a2e                	mv	s4,a1
    80003dbc:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003dbe:	4601                	li	a2,0
    80003dc0:	00000097          	auipc	ra,0x0
    80003dc4:	dd2080e7          	jalr	-558(ra) # 80003b92 <dirlookup>
    80003dc8:	e93d                	bnez	a0,80003e3e <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003dca:	04c92483          	lw	s1,76(s2)
    80003dce:	c49d                	beqz	s1,80003dfc <dirlink+0x54>
    80003dd0:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003dd2:	4741                	li	a4,16
    80003dd4:	86a6                	mv	a3,s1
    80003dd6:	fc040613          	addi	a2,s0,-64
    80003dda:	4581                	li	a1,0
    80003ddc:	854a                	mv	a0,s2
    80003dde:	00000097          	auipc	ra,0x0
    80003de2:	b84080e7          	jalr	-1148(ra) # 80003962 <readi>
    80003de6:	47c1                	li	a5,16
    80003de8:	06f51163          	bne	a0,a5,80003e4a <dirlink+0xa2>
    if(de.inum == 0)
    80003dec:	fc045783          	lhu	a5,-64(s0)
    80003df0:	c791                	beqz	a5,80003dfc <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003df2:	24c1                	addiw	s1,s1,16
    80003df4:	04c92783          	lw	a5,76(s2)
    80003df8:	fcf4ede3          	bltu	s1,a5,80003dd2 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    80003dfc:	4639                	li	a2,14
    80003dfe:	85d2                	mv	a1,s4
    80003e00:	fc240513          	addi	a0,s0,-62
    80003e04:	ffffd097          	auipc	ra,0xffffd
    80003e08:	fd4080e7          	jalr	-44(ra) # 80000dd8 <strncpy>
  de.inum = inum;
    80003e0c:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003e10:	4741                	li	a4,16
    80003e12:	86a6                	mv	a3,s1
    80003e14:	fc040613          	addi	a2,s0,-64
    80003e18:	4581                	li	a1,0
    80003e1a:	854a                	mv	a0,s2
    80003e1c:	00000097          	auipc	ra,0x0
    80003e20:	c3e080e7          	jalr	-962(ra) # 80003a5a <writei>
    80003e24:	872a                	mv	a4,a0
    80003e26:	47c1                	li	a5,16
  return 0;
    80003e28:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003e2a:	02f71863          	bne	a4,a5,80003e5a <dirlink+0xb2>
}
    80003e2e:	70e2                	ld	ra,56(sp)
    80003e30:	7442                	ld	s0,48(sp)
    80003e32:	74a2                	ld	s1,40(sp)
    80003e34:	7902                	ld	s2,32(sp)
    80003e36:	69e2                	ld	s3,24(sp)
    80003e38:	6a42                	ld	s4,16(sp)
    80003e3a:	6121                	addi	sp,sp,64
    80003e3c:	8082                	ret
    iput(ip);
    80003e3e:	00000097          	auipc	ra,0x0
    80003e42:	a2a080e7          	jalr	-1494(ra) # 80003868 <iput>
    return -1;
    80003e46:	557d                	li	a0,-1
    80003e48:	b7dd                	j	80003e2e <dirlink+0x86>
      panic("dirlink read");
    80003e4a:	00004517          	auipc	a0,0x4
    80003e4e:	7ce50513          	addi	a0,a0,1998 # 80008618 <syscalls+0x1d0>
    80003e52:	ffffc097          	auipc	ra,0xffffc
    80003e56:	6e8080e7          	jalr	1768(ra) # 8000053a <panic>
    panic("dirlink");
    80003e5a:	00005517          	auipc	a0,0x5
    80003e5e:	8ce50513          	addi	a0,a0,-1842 # 80008728 <syscalls+0x2e0>
    80003e62:	ffffc097          	auipc	ra,0xffffc
    80003e66:	6d8080e7          	jalr	1752(ra) # 8000053a <panic>

0000000080003e6a <namei>:

struct inode*
namei(char *path)
{
    80003e6a:	1101                	addi	sp,sp,-32
    80003e6c:	ec06                	sd	ra,24(sp)
    80003e6e:	e822                	sd	s0,16(sp)
    80003e70:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003e72:	fe040613          	addi	a2,s0,-32
    80003e76:	4581                	li	a1,0
    80003e78:	00000097          	auipc	ra,0x0
    80003e7c:	dca080e7          	jalr	-566(ra) # 80003c42 <namex>
}
    80003e80:	60e2                	ld	ra,24(sp)
    80003e82:	6442                	ld	s0,16(sp)
    80003e84:	6105                	addi	sp,sp,32
    80003e86:	8082                	ret

0000000080003e88 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003e88:	1141                	addi	sp,sp,-16
    80003e8a:	e406                	sd	ra,8(sp)
    80003e8c:	e022                	sd	s0,0(sp)
    80003e8e:	0800                	addi	s0,sp,16
    80003e90:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003e92:	4585                	li	a1,1
    80003e94:	00000097          	auipc	ra,0x0
    80003e98:	dae080e7          	jalr	-594(ra) # 80003c42 <namex>
}
    80003e9c:	60a2                	ld	ra,8(sp)
    80003e9e:	6402                	ld	s0,0(sp)
    80003ea0:	0141                	addi	sp,sp,16
    80003ea2:	8082                	ret

0000000080003ea4 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80003ea4:	1101                	addi	sp,sp,-32
    80003ea6:	ec06                	sd	ra,24(sp)
    80003ea8:	e822                	sd	s0,16(sp)
    80003eaa:	e426                	sd	s1,8(sp)
    80003eac:	e04a                	sd	s2,0(sp)
    80003eae:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003eb0:	0001d917          	auipc	s2,0x1d
    80003eb4:	7c090913          	addi	s2,s2,1984 # 80021670 <log>
    80003eb8:	01892583          	lw	a1,24(s2)
    80003ebc:	02892503          	lw	a0,40(s2)
    80003ec0:	fffff097          	auipc	ra,0xfffff
    80003ec4:	fec080e7          	jalr	-20(ra) # 80002eac <bread>
    80003ec8:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80003eca:	02c92683          	lw	a3,44(s2)
    80003ece:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003ed0:	02d05863          	blez	a3,80003f00 <write_head+0x5c>
    80003ed4:	0001d797          	auipc	a5,0x1d
    80003ed8:	7cc78793          	addi	a5,a5,1996 # 800216a0 <log+0x30>
    80003edc:	05c50713          	addi	a4,a0,92
    80003ee0:	36fd                	addiw	a3,a3,-1
    80003ee2:	02069613          	slli	a2,a3,0x20
    80003ee6:	01e65693          	srli	a3,a2,0x1e
    80003eea:	0001d617          	auipc	a2,0x1d
    80003eee:	7ba60613          	addi	a2,a2,1978 # 800216a4 <log+0x34>
    80003ef2:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    80003ef4:	4390                	lw	a2,0(a5)
    80003ef6:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003ef8:	0791                	addi	a5,a5,4
    80003efa:	0711                	addi	a4,a4,4
    80003efc:	fed79ce3          	bne	a5,a3,80003ef4 <write_head+0x50>
  }
  bwrite(buf);
    80003f00:	8526                	mv	a0,s1
    80003f02:	fffff097          	auipc	ra,0xfffff
    80003f06:	09c080e7          	jalr	156(ra) # 80002f9e <bwrite>
  brelse(buf);
    80003f0a:	8526                	mv	a0,s1
    80003f0c:	fffff097          	auipc	ra,0xfffff
    80003f10:	0d0080e7          	jalr	208(ra) # 80002fdc <brelse>
}
    80003f14:	60e2                	ld	ra,24(sp)
    80003f16:	6442                	ld	s0,16(sp)
    80003f18:	64a2                	ld	s1,8(sp)
    80003f1a:	6902                	ld	s2,0(sp)
    80003f1c:	6105                	addi	sp,sp,32
    80003f1e:	8082                	ret

0000000080003f20 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80003f20:	0001d797          	auipc	a5,0x1d
    80003f24:	77c7a783          	lw	a5,1916(a5) # 8002169c <log+0x2c>
    80003f28:	0af05d63          	blez	a5,80003fe2 <install_trans+0xc2>
{
    80003f2c:	7139                	addi	sp,sp,-64
    80003f2e:	fc06                	sd	ra,56(sp)
    80003f30:	f822                	sd	s0,48(sp)
    80003f32:	f426                	sd	s1,40(sp)
    80003f34:	f04a                	sd	s2,32(sp)
    80003f36:	ec4e                	sd	s3,24(sp)
    80003f38:	e852                	sd	s4,16(sp)
    80003f3a:	e456                	sd	s5,8(sp)
    80003f3c:	e05a                	sd	s6,0(sp)
    80003f3e:	0080                	addi	s0,sp,64
    80003f40:	8b2a                	mv	s6,a0
    80003f42:	0001da97          	auipc	s5,0x1d
    80003f46:	75ea8a93          	addi	s5,s5,1886 # 800216a0 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003f4a:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003f4c:	0001d997          	auipc	s3,0x1d
    80003f50:	72498993          	addi	s3,s3,1828 # 80021670 <log>
    80003f54:	a00d                	j	80003f76 <install_trans+0x56>
    brelse(lbuf);
    80003f56:	854a                	mv	a0,s2
    80003f58:	fffff097          	auipc	ra,0xfffff
    80003f5c:	084080e7          	jalr	132(ra) # 80002fdc <brelse>
    brelse(dbuf);
    80003f60:	8526                	mv	a0,s1
    80003f62:	fffff097          	auipc	ra,0xfffff
    80003f66:	07a080e7          	jalr	122(ra) # 80002fdc <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003f6a:	2a05                	addiw	s4,s4,1
    80003f6c:	0a91                	addi	s5,s5,4
    80003f6e:	02c9a783          	lw	a5,44(s3)
    80003f72:	04fa5e63          	bge	s4,a5,80003fce <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003f76:	0189a583          	lw	a1,24(s3)
    80003f7a:	014585bb          	addw	a1,a1,s4
    80003f7e:	2585                	addiw	a1,a1,1
    80003f80:	0289a503          	lw	a0,40(s3)
    80003f84:	fffff097          	auipc	ra,0xfffff
    80003f88:	f28080e7          	jalr	-216(ra) # 80002eac <bread>
    80003f8c:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80003f8e:	000aa583          	lw	a1,0(s5)
    80003f92:	0289a503          	lw	a0,40(s3)
    80003f96:	fffff097          	auipc	ra,0xfffff
    80003f9a:	f16080e7          	jalr	-234(ra) # 80002eac <bread>
    80003f9e:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003fa0:	40000613          	li	a2,1024
    80003fa4:	05890593          	addi	a1,s2,88
    80003fa8:	05850513          	addi	a0,a0,88
    80003fac:	ffffd097          	auipc	ra,0xffffd
    80003fb0:	d7c080e7          	jalr	-644(ra) # 80000d28 <memmove>
    bwrite(dbuf);  // write dst to disk
    80003fb4:	8526                	mv	a0,s1
    80003fb6:	fffff097          	auipc	ra,0xfffff
    80003fba:	fe8080e7          	jalr	-24(ra) # 80002f9e <bwrite>
    if(recovering == 0)
    80003fbe:	f80b1ce3          	bnez	s6,80003f56 <install_trans+0x36>
      bunpin(dbuf);
    80003fc2:	8526                	mv	a0,s1
    80003fc4:	fffff097          	auipc	ra,0xfffff
    80003fc8:	0f2080e7          	jalr	242(ra) # 800030b6 <bunpin>
    80003fcc:	b769                	j	80003f56 <install_trans+0x36>
}
    80003fce:	70e2                	ld	ra,56(sp)
    80003fd0:	7442                	ld	s0,48(sp)
    80003fd2:	74a2                	ld	s1,40(sp)
    80003fd4:	7902                	ld	s2,32(sp)
    80003fd6:	69e2                	ld	s3,24(sp)
    80003fd8:	6a42                	ld	s4,16(sp)
    80003fda:	6aa2                	ld	s5,8(sp)
    80003fdc:	6b02                	ld	s6,0(sp)
    80003fde:	6121                	addi	sp,sp,64
    80003fe0:	8082                	ret
    80003fe2:	8082                	ret

0000000080003fe4 <initlog>:
{
    80003fe4:	7179                	addi	sp,sp,-48
    80003fe6:	f406                	sd	ra,40(sp)
    80003fe8:	f022                	sd	s0,32(sp)
    80003fea:	ec26                	sd	s1,24(sp)
    80003fec:	e84a                	sd	s2,16(sp)
    80003fee:	e44e                	sd	s3,8(sp)
    80003ff0:	1800                	addi	s0,sp,48
    80003ff2:	892a                	mv	s2,a0
    80003ff4:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003ff6:	0001d497          	auipc	s1,0x1d
    80003ffa:	67a48493          	addi	s1,s1,1658 # 80021670 <log>
    80003ffe:	00004597          	auipc	a1,0x4
    80004002:	62a58593          	addi	a1,a1,1578 # 80008628 <syscalls+0x1e0>
    80004006:	8526                	mv	a0,s1
    80004008:	ffffd097          	auipc	ra,0xffffd
    8000400c:	b38080e7          	jalr	-1224(ra) # 80000b40 <initlock>
  log.start = sb->logstart;
    80004010:	0149a583          	lw	a1,20(s3)
    80004014:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80004016:	0109a783          	lw	a5,16(s3)
    8000401a:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    8000401c:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80004020:	854a                	mv	a0,s2
    80004022:	fffff097          	auipc	ra,0xfffff
    80004026:	e8a080e7          	jalr	-374(ra) # 80002eac <bread>
  log.lh.n = lh->n;
    8000402a:	4d34                	lw	a3,88(a0)
    8000402c:	d4d4                	sw	a3,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    8000402e:	02d05663          	blez	a3,8000405a <initlog+0x76>
    80004032:	05c50793          	addi	a5,a0,92
    80004036:	0001d717          	auipc	a4,0x1d
    8000403a:	66a70713          	addi	a4,a4,1642 # 800216a0 <log+0x30>
    8000403e:	36fd                	addiw	a3,a3,-1
    80004040:	02069613          	slli	a2,a3,0x20
    80004044:	01e65693          	srli	a3,a2,0x1e
    80004048:	06050613          	addi	a2,a0,96
    8000404c:	96b2                	add	a3,a3,a2
    log.lh.block[i] = lh->block[i];
    8000404e:	4390                	lw	a2,0(a5)
    80004050:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80004052:	0791                	addi	a5,a5,4
    80004054:	0711                	addi	a4,a4,4
    80004056:	fed79ce3          	bne	a5,a3,8000404e <initlog+0x6a>
  brelse(buf);
    8000405a:	fffff097          	auipc	ra,0xfffff
    8000405e:	f82080e7          	jalr	-126(ra) # 80002fdc <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80004062:	4505                	li	a0,1
    80004064:	00000097          	auipc	ra,0x0
    80004068:	ebc080e7          	jalr	-324(ra) # 80003f20 <install_trans>
  log.lh.n = 0;
    8000406c:	0001d797          	auipc	a5,0x1d
    80004070:	6207a823          	sw	zero,1584(a5) # 8002169c <log+0x2c>
  write_head(); // clear the log
    80004074:	00000097          	auipc	ra,0x0
    80004078:	e30080e7          	jalr	-464(ra) # 80003ea4 <write_head>
}
    8000407c:	70a2                	ld	ra,40(sp)
    8000407e:	7402                	ld	s0,32(sp)
    80004080:	64e2                	ld	s1,24(sp)
    80004082:	6942                	ld	s2,16(sp)
    80004084:	69a2                	ld	s3,8(sp)
    80004086:	6145                	addi	sp,sp,48
    80004088:	8082                	ret

000000008000408a <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    8000408a:	1101                	addi	sp,sp,-32
    8000408c:	ec06                	sd	ra,24(sp)
    8000408e:	e822                	sd	s0,16(sp)
    80004090:	e426                	sd	s1,8(sp)
    80004092:	e04a                	sd	s2,0(sp)
    80004094:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80004096:	0001d517          	auipc	a0,0x1d
    8000409a:	5da50513          	addi	a0,a0,1498 # 80021670 <log>
    8000409e:	ffffd097          	auipc	ra,0xffffd
    800040a2:	b32080e7          	jalr	-1230(ra) # 80000bd0 <acquire>
  while(1){
    if(log.committing){
    800040a6:	0001d497          	auipc	s1,0x1d
    800040aa:	5ca48493          	addi	s1,s1,1482 # 80021670 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800040ae:	4979                	li	s2,30
    800040b0:	a039                	j	800040be <begin_op+0x34>
      sleep(&log, &log.lock);
    800040b2:	85a6                	mv	a1,s1
    800040b4:	8526                	mv	a0,s1
    800040b6:	ffffe097          	auipc	ra,0xffffe
    800040ba:	fae080e7          	jalr	-82(ra) # 80002064 <sleep>
    if(log.committing){
    800040be:	50dc                	lw	a5,36(s1)
    800040c0:	fbed                	bnez	a5,800040b2 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800040c2:	5098                	lw	a4,32(s1)
    800040c4:	2705                	addiw	a4,a4,1
    800040c6:	0007069b          	sext.w	a3,a4
    800040ca:	0027179b          	slliw	a5,a4,0x2
    800040ce:	9fb9                	addw	a5,a5,a4
    800040d0:	0017979b          	slliw	a5,a5,0x1
    800040d4:	54d8                	lw	a4,44(s1)
    800040d6:	9fb9                	addw	a5,a5,a4
    800040d8:	00f95963          	bge	s2,a5,800040ea <begin_op+0x60>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800040dc:	85a6                	mv	a1,s1
    800040de:	8526                	mv	a0,s1
    800040e0:	ffffe097          	auipc	ra,0xffffe
    800040e4:	f84080e7          	jalr	-124(ra) # 80002064 <sleep>
    800040e8:	bfd9                	j	800040be <begin_op+0x34>
    } else {
      log.outstanding += 1;
    800040ea:	0001d517          	auipc	a0,0x1d
    800040ee:	58650513          	addi	a0,a0,1414 # 80021670 <log>
    800040f2:	d114                	sw	a3,32(a0)
      release(&log.lock);
    800040f4:	ffffd097          	auipc	ra,0xffffd
    800040f8:	b90080e7          	jalr	-1136(ra) # 80000c84 <release>
      break;
    }
  }
}
    800040fc:	60e2                	ld	ra,24(sp)
    800040fe:	6442                	ld	s0,16(sp)
    80004100:	64a2                	ld	s1,8(sp)
    80004102:	6902                	ld	s2,0(sp)
    80004104:	6105                	addi	sp,sp,32
    80004106:	8082                	ret

0000000080004108 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80004108:	7139                	addi	sp,sp,-64
    8000410a:	fc06                	sd	ra,56(sp)
    8000410c:	f822                	sd	s0,48(sp)
    8000410e:	f426                	sd	s1,40(sp)
    80004110:	f04a                	sd	s2,32(sp)
    80004112:	ec4e                	sd	s3,24(sp)
    80004114:	e852                	sd	s4,16(sp)
    80004116:	e456                	sd	s5,8(sp)
    80004118:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    8000411a:	0001d497          	auipc	s1,0x1d
    8000411e:	55648493          	addi	s1,s1,1366 # 80021670 <log>
    80004122:	8526                	mv	a0,s1
    80004124:	ffffd097          	auipc	ra,0xffffd
    80004128:	aac080e7          	jalr	-1364(ra) # 80000bd0 <acquire>
  log.outstanding -= 1;
    8000412c:	509c                	lw	a5,32(s1)
    8000412e:	37fd                	addiw	a5,a5,-1
    80004130:	0007891b          	sext.w	s2,a5
    80004134:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80004136:	50dc                	lw	a5,36(s1)
    80004138:	e7b9                	bnez	a5,80004186 <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    8000413a:	04091e63          	bnez	s2,80004196 <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    8000413e:	0001d497          	auipc	s1,0x1d
    80004142:	53248493          	addi	s1,s1,1330 # 80021670 <log>
    80004146:	4785                	li	a5,1
    80004148:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    8000414a:	8526                	mv	a0,s1
    8000414c:	ffffd097          	auipc	ra,0xffffd
    80004150:	b38080e7          	jalr	-1224(ra) # 80000c84 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80004154:	54dc                	lw	a5,44(s1)
    80004156:	06f04763          	bgtz	a5,800041c4 <end_op+0xbc>
    acquire(&log.lock);
    8000415a:	0001d497          	auipc	s1,0x1d
    8000415e:	51648493          	addi	s1,s1,1302 # 80021670 <log>
    80004162:	8526                	mv	a0,s1
    80004164:	ffffd097          	auipc	ra,0xffffd
    80004168:	a6c080e7          	jalr	-1428(ra) # 80000bd0 <acquire>
    log.committing = 0;
    8000416c:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80004170:	8526                	mv	a0,s1
    80004172:	ffffe097          	auipc	ra,0xffffe
    80004176:	07e080e7          	jalr	126(ra) # 800021f0 <wakeup>
    release(&log.lock);
    8000417a:	8526                	mv	a0,s1
    8000417c:	ffffd097          	auipc	ra,0xffffd
    80004180:	b08080e7          	jalr	-1272(ra) # 80000c84 <release>
}
    80004184:	a03d                	j	800041b2 <end_op+0xaa>
    panic("log.committing");
    80004186:	00004517          	auipc	a0,0x4
    8000418a:	4aa50513          	addi	a0,a0,1194 # 80008630 <syscalls+0x1e8>
    8000418e:	ffffc097          	auipc	ra,0xffffc
    80004192:	3ac080e7          	jalr	940(ra) # 8000053a <panic>
    wakeup(&log);
    80004196:	0001d497          	auipc	s1,0x1d
    8000419a:	4da48493          	addi	s1,s1,1242 # 80021670 <log>
    8000419e:	8526                	mv	a0,s1
    800041a0:	ffffe097          	auipc	ra,0xffffe
    800041a4:	050080e7          	jalr	80(ra) # 800021f0 <wakeup>
  release(&log.lock);
    800041a8:	8526                	mv	a0,s1
    800041aa:	ffffd097          	auipc	ra,0xffffd
    800041ae:	ada080e7          	jalr	-1318(ra) # 80000c84 <release>
}
    800041b2:	70e2                	ld	ra,56(sp)
    800041b4:	7442                	ld	s0,48(sp)
    800041b6:	74a2                	ld	s1,40(sp)
    800041b8:	7902                	ld	s2,32(sp)
    800041ba:	69e2                	ld	s3,24(sp)
    800041bc:	6a42                	ld	s4,16(sp)
    800041be:	6aa2                	ld	s5,8(sp)
    800041c0:	6121                	addi	sp,sp,64
    800041c2:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    800041c4:	0001da97          	auipc	s5,0x1d
    800041c8:	4dca8a93          	addi	s5,s5,1244 # 800216a0 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800041cc:	0001da17          	auipc	s4,0x1d
    800041d0:	4a4a0a13          	addi	s4,s4,1188 # 80021670 <log>
    800041d4:	018a2583          	lw	a1,24(s4)
    800041d8:	012585bb          	addw	a1,a1,s2
    800041dc:	2585                	addiw	a1,a1,1
    800041de:	028a2503          	lw	a0,40(s4)
    800041e2:	fffff097          	auipc	ra,0xfffff
    800041e6:	cca080e7          	jalr	-822(ra) # 80002eac <bread>
    800041ea:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800041ec:	000aa583          	lw	a1,0(s5)
    800041f0:	028a2503          	lw	a0,40(s4)
    800041f4:	fffff097          	auipc	ra,0xfffff
    800041f8:	cb8080e7          	jalr	-840(ra) # 80002eac <bread>
    800041fc:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    800041fe:	40000613          	li	a2,1024
    80004202:	05850593          	addi	a1,a0,88
    80004206:	05848513          	addi	a0,s1,88
    8000420a:	ffffd097          	auipc	ra,0xffffd
    8000420e:	b1e080e7          	jalr	-1250(ra) # 80000d28 <memmove>
    bwrite(to);  // write the log
    80004212:	8526                	mv	a0,s1
    80004214:	fffff097          	auipc	ra,0xfffff
    80004218:	d8a080e7          	jalr	-630(ra) # 80002f9e <bwrite>
    brelse(from);
    8000421c:	854e                	mv	a0,s3
    8000421e:	fffff097          	auipc	ra,0xfffff
    80004222:	dbe080e7          	jalr	-578(ra) # 80002fdc <brelse>
    brelse(to);
    80004226:	8526                	mv	a0,s1
    80004228:	fffff097          	auipc	ra,0xfffff
    8000422c:	db4080e7          	jalr	-588(ra) # 80002fdc <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80004230:	2905                	addiw	s2,s2,1
    80004232:	0a91                	addi	s5,s5,4
    80004234:	02ca2783          	lw	a5,44(s4)
    80004238:	f8f94ee3          	blt	s2,a5,800041d4 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    8000423c:	00000097          	auipc	ra,0x0
    80004240:	c68080e7          	jalr	-920(ra) # 80003ea4 <write_head>
    install_trans(0); // Now install writes to home locations
    80004244:	4501                	li	a0,0
    80004246:	00000097          	auipc	ra,0x0
    8000424a:	cda080e7          	jalr	-806(ra) # 80003f20 <install_trans>
    log.lh.n = 0;
    8000424e:	0001d797          	auipc	a5,0x1d
    80004252:	4407a723          	sw	zero,1102(a5) # 8002169c <log+0x2c>
    write_head();    // Erase the transaction from the log
    80004256:	00000097          	auipc	ra,0x0
    8000425a:	c4e080e7          	jalr	-946(ra) # 80003ea4 <write_head>
    8000425e:	bdf5                	j	8000415a <end_op+0x52>

0000000080004260 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80004260:	1101                	addi	sp,sp,-32
    80004262:	ec06                	sd	ra,24(sp)
    80004264:	e822                	sd	s0,16(sp)
    80004266:	e426                	sd	s1,8(sp)
    80004268:	e04a                	sd	s2,0(sp)
    8000426a:	1000                	addi	s0,sp,32
    8000426c:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    8000426e:	0001d917          	auipc	s2,0x1d
    80004272:	40290913          	addi	s2,s2,1026 # 80021670 <log>
    80004276:	854a                	mv	a0,s2
    80004278:	ffffd097          	auipc	ra,0xffffd
    8000427c:	958080e7          	jalr	-1704(ra) # 80000bd0 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80004280:	02c92603          	lw	a2,44(s2)
    80004284:	47f5                	li	a5,29
    80004286:	06c7c563          	blt	a5,a2,800042f0 <log_write+0x90>
    8000428a:	0001d797          	auipc	a5,0x1d
    8000428e:	4027a783          	lw	a5,1026(a5) # 8002168c <log+0x1c>
    80004292:	37fd                	addiw	a5,a5,-1
    80004294:	04f65e63          	bge	a2,a5,800042f0 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80004298:	0001d797          	auipc	a5,0x1d
    8000429c:	3f87a783          	lw	a5,1016(a5) # 80021690 <log+0x20>
    800042a0:	06f05063          	blez	a5,80004300 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    800042a4:	4781                	li	a5,0
    800042a6:	06c05563          	blez	a2,80004310 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    800042aa:	44cc                	lw	a1,12(s1)
    800042ac:	0001d717          	auipc	a4,0x1d
    800042b0:	3f470713          	addi	a4,a4,1012 # 800216a0 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    800042b4:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    800042b6:	4314                	lw	a3,0(a4)
    800042b8:	04b68c63          	beq	a3,a1,80004310 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    800042bc:	2785                	addiw	a5,a5,1
    800042be:	0711                	addi	a4,a4,4
    800042c0:	fef61be3          	bne	a2,a5,800042b6 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    800042c4:	0621                	addi	a2,a2,8
    800042c6:	060a                	slli	a2,a2,0x2
    800042c8:	0001d797          	auipc	a5,0x1d
    800042cc:	3a878793          	addi	a5,a5,936 # 80021670 <log>
    800042d0:	97b2                	add	a5,a5,a2
    800042d2:	44d8                	lw	a4,12(s1)
    800042d4:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    800042d6:	8526                	mv	a0,s1
    800042d8:	fffff097          	auipc	ra,0xfffff
    800042dc:	da2080e7          	jalr	-606(ra) # 8000307a <bpin>
    log.lh.n++;
    800042e0:	0001d717          	auipc	a4,0x1d
    800042e4:	39070713          	addi	a4,a4,912 # 80021670 <log>
    800042e8:	575c                	lw	a5,44(a4)
    800042ea:	2785                	addiw	a5,a5,1
    800042ec:	d75c                	sw	a5,44(a4)
    800042ee:	a82d                	j	80004328 <log_write+0xc8>
    panic("too big a transaction");
    800042f0:	00004517          	auipc	a0,0x4
    800042f4:	35050513          	addi	a0,a0,848 # 80008640 <syscalls+0x1f8>
    800042f8:	ffffc097          	auipc	ra,0xffffc
    800042fc:	242080e7          	jalr	578(ra) # 8000053a <panic>
    panic("log_write outside of trans");
    80004300:	00004517          	auipc	a0,0x4
    80004304:	35850513          	addi	a0,a0,856 # 80008658 <syscalls+0x210>
    80004308:	ffffc097          	auipc	ra,0xffffc
    8000430c:	232080e7          	jalr	562(ra) # 8000053a <panic>
  log.lh.block[i] = b->blockno;
    80004310:	00878693          	addi	a3,a5,8
    80004314:	068a                	slli	a3,a3,0x2
    80004316:	0001d717          	auipc	a4,0x1d
    8000431a:	35a70713          	addi	a4,a4,858 # 80021670 <log>
    8000431e:	9736                	add	a4,a4,a3
    80004320:	44d4                	lw	a3,12(s1)
    80004322:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80004324:	faf609e3          	beq	a2,a5,800042d6 <log_write+0x76>
  }
  release(&log.lock);
    80004328:	0001d517          	auipc	a0,0x1d
    8000432c:	34850513          	addi	a0,a0,840 # 80021670 <log>
    80004330:	ffffd097          	auipc	ra,0xffffd
    80004334:	954080e7          	jalr	-1708(ra) # 80000c84 <release>
}
    80004338:	60e2                	ld	ra,24(sp)
    8000433a:	6442                	ld	s0,16(sp)
    8000433c:	64a2                	ld	s1,8(sp)
    8000433e:	6902                	ld	s2,0(sp)
    80004340:	6105                	addi	sp,sp,32
    80004342:	8082                	ret

0000000080004344 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80004344:	1101                	addi	sp,sp,-32
    80004346:	ec06                	sd	ra,24(sp)
    80004348:	e822                	sd	s0,16(sp)
    8000434a:	e426                	sd	s1,8(sp)
    8000434c:	e04a                	sd	s2,0(sp)
    8000434e:	1000                	addi	s0,sp,32
    80004350:	84aa                	mv	s1,a0
    80004352:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80004354:	00004597          	auipc	a1,0x4
    80004358:	32458593          	addi	a1,a1,804 # 80008678 <syscalls+0x230>
    8000435c:	0521                	addi	a0,a0,8
    8000435e:	ffffc097          	auipc	ra,0xffffc
    80004362:	7e2080e7          	jalr	2018(ra) # 80000b40 <initlock>
  lk->name = name;
    80004366:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    8000436a:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000436e:	0204a423          	sw	zero,40(s1)
}
    80004372:	60e2                	ld	ra,24(sp)
    80004374:	6442                	ld	s0,16(sp)
    80004376:	64a2                	ld	s1,8(sp)
    80004378:	6902                	ld	s2,0(sp)
    8000437a:	6105                	addi	sp,sp,32
    8000437c:	8082                	ret

000000008000437e <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    8000437e:	1101                	addi	sp,sp,-32
    80004380:	ec06                	sd	ra,24(sp)
    80004382:	e822                	sd	s0,16(sp)
    80004384:	e426                	sd	s1,8(sp)
    80004386:	e04a                	sd	s2,0(sp)
    80004388:	1000                	addi	s0,sp,32
    8000438a:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000438c:	00850913          	addi	s2,a0,8
    80004390:	854a                	mv	a0,s2
    80004392:	ffffd097          	auipc	ra,0xffffd
    80004396:	83e080e7          	jalr	-1986(ra) # 80000bd0 <acquire>
  while (lk->locked) {
    8000439a:	409c                	lw	a5,0(s1)
    8000439c:	cb89                	beqz	a5,800043ae <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    8000439e:	85ca                	mv	a1,s2
    800043a0:	8526                	mv	a0,s1
    800043a2:	ffffe097          	auipc	ra,0xffffe
    800043a6:	cc2080e7          	jalr	-830(ra) # 80002064 <sleep>
  while (lk->locked) {
    800043aa:	409c                	lw	a5,0(s1)
    800043ac:	fbed                	bnez	a5,8000439e <acquiresleep+0x20>
  }
  lk->locked = 1;
    800043ae:	4785                	li	a5,1
    800043b0:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    800043b2:	ffffd097          	auipc	ra,0xffffd
    800043b6:	5e4080e7          	jalr	1508(ra) # 80001996 <myproc>
    800043ba:	591c                	lw	a5,48(a0)
    800043bc:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    800043be:	854a                	mv	a0,s2
    800043c0:	ffffd097          	auipc	ra,0xffffd
    800043c4:	8c4080e7          	jalr	-1852(ra) # 80000c84 <release>
}
    800043c8:	60e2                	ld	ra,24(sp)
    800043ca:	6442                	ld	s0,16(sp)
    800043cc:	64a2                	ld	s1,8(sp)
    800043ce:	6902                	ld	s2,0(sp)
    800043d0:	6105                	addi	sp,sp,32
    800043d2:	8082                	ret

00000000800043d4 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800043d4:	1101                	addi	sp,sp,-32
    800043d6:	ec06                	sd	ra,24(sp)
    800043d8:	e822                	sd	s0,16(sp)
    800043da:	e426                	sd	s1,8(sp)
    800043dc:	e04a                	sd	s2,0(sp)
    800043de:	1000                	addi	s0,sp,32
    800043e0:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800043e2:	00850913          	addi	s2,a0,8
    800043e6:	854a                	mv	a0,s2
    800043e8:	ffffc097          	auipc	ra,0xffffc
    800043ec:	7e8080e7          	jalr	2024(ra) # 80000bd0 <acquire>
  lk->locked = 0;
    800043f0:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800043f4:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    800043f8:	8526                	mv	a0,s1
    800043fa:	ffffe097          	auipc	ra,0xffffe
    800043fe:	df6080e7          	jalr	-522(ra) # 800021f0 <wakeup>
  release(&lk->lk);
    80004402:	854a                	mv	a0,s2
    80004404:	ffffd097          	auipc	ra,0xffffd
    80004408:	880080e7          	jalr	-1920(ra) # 80000c84 <release>
}
    8000440c:	60e2                	ld	ra,24(sp)
    8000440e:	6442                	ld	s0,16(sp)
    80004410:	64a2                	ld	s1,8(sp)
    80004412:	6902                	ld	s2,0(sp)
    80004414:	6105                	addi	sp,sp,32
    80004416:	8082                	ret

0000000080004418 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80004418:	7179                	addi	sp,sp,-48
    8000441a:	f406                	sd	ra,40(sp)
    8000441c:	f022                	sd	s0,32(sp)
    8000441e:	ec26                	sd	s1,24(sp)
    80004420:	e84a                	sd	s2,16(sp)
    80004422:	e44e                	sd	s3,8(sp)
    80004424:	1800                	addi	s0,sp,48
    80004426:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80004428:	00850913          	addi	s2,a0,8
    8000442c:	854a                	mv	a0,s2
    8000442e:	ffffc097          	auipc	ra,0xffffc
    80004432:	7a2080e7          	jalr	1954(ra) # 80000bd0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80004436:	409c                	lw	a5,0(s1)
    80004438:	ef99                	bnez	a5,80004456 <holdingsleep+0x3e>
    8000443a:	4481                	li	s1,0
  release(&lk->lk);
    8000443c:	854a                	mv	a0,s2
    8000443e:	ffffd097          	auipc	ra,0xffffd
    80004442:	846080e7          	jalr	-1978(ra) # 80000c84 <release>
  return r;
}
    80004446:	8526                	mv	a0,s1
    80004448:	70a2                	ld	ra,40(sp)
    8000444a:	7402                	ld	s0,32(sp)
    8000444c:	64e2                	ld	s1,24(sp)
    8000444e:	6942                	ld	s2,16(sp)
    80004450:	69a2                	ld	s3,8(sp)
    80004452:	6145                	addi	sp,sp,48
    80004454:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80004456:	0284a983          	lw	s3,40(s1)
    8000445a:	ffffd097          	auipc	ra,0xffffd
    8000445e:	53c080e7          	jalr	1340(ra) # 80001996 <myproc>
    80004462:	5904                	lw	s1,48(a0)
    80004464:	413484b3          	sub	s1,s1,s3
    80004468:	0014b493          	seqz	s1,s1
    8000446c:	bfc1                	j	8000443c <holdingsleep+0x24>

000000008000446e <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    8000446e:	1141                	addi	sp,sp,-16
    80004470:	e406                	sd	ra,8(sp)
    80004472:	e022                	sd	s0,0(sp)
    80004474:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80004476:	00004597          	auipc	a1,0x4
    8000447a:	21258593          	addi	a1,a1,530 # 80008688 <syscalls+0x240>
    8000447e:	0001d517          	auipc	a0,0x1d
    80004482:	33a50513          	addi	a0,a0,826 # 800217b8 <ftable>
    80004486:	ffffc097          	auipc	ra,0xffffc
    8000448a:	6ba080e7          	jalr	1722(ra) # 80000b40 <initlock>
}
    8000448e:	60a2                	ld	ra,8(sp)
    80004490:	6402                	ld	s0,0(sp)
    80004492:	0141                	addi	sp,sp,16
    80004494:	8082                	ret

0000000080004496 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80004496:	1101                	addi	sp,sp,-32
    80004498:	ec06                	sd	ra,24(sp)
    8000449a:	e822                	sd	s0,16(sp)
    8000449c:	e426                	sd	s1,8(sp)
    8000449e:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800044a0:	0001d517          	auipc	a0,0x1d
    800044a4:	31850513          	addi	a0,a0,792 # 800217b8 <ftable>
    800044a8:	ffffc097          	auipc	ra,0xffffc
    800044ac:	728080e7          	jalr	1832(ra) # 80000bd0 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800044b0:	0001d497          	auipc	s1,0x1d
    800044b4:	32048493          	addi	s1,s1,800 # 800217d0 <ftable+0x18>
    800044b8:	0001e717          	auipc	a4,0x1e
    800044bc:	2b870713          	addi	a4,a4,696 # 80022770 <ftable+0xfb8>
    if(f->ref == 0){
    800044c0:	40dc                	lw	a5,4(s1)
    800044c2:	cf99                	beqz	a5,800044e0 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800044c4:	02848493          	addi	s1,s1,40
    800044c8:	fee49ce3          	bne	s1,a4,800044c0 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    800044cc:	0001d517          	auipc	a0,0x1d
    800044d0:	2ec50513          	addi	a0,a0,748 # 800217b8 <ftable>
    800044d4:	ffffc097          	auipc	ra,0xffffc
    800044d8:	7b0080e7          	jalr	1968(ra) # 80000c84 <release>
  return 0;
    800044dc:	4481                	li	s1,0
    800044de:	a819                	j	800044f4 <filealloc+0x5e>
      f->ref = 1;
    800044e0:	4785                	li	a5,1
    800044e2:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800044e4:	0001d517          	auipc	a0,0x1d
    800044e8:	2d450513          	addi	a0,a0,724 # 800217b8 <ftable>
    800044ec:	ffffc097          	auipc	ra,0xffffc
    800044f0:	798080e7          	jalr	1944(ra) # 80000c84 <release>
}
    800044f4:	8526                	mv	a0,s1
    800044f6:	60e2                	ld	ra,24(sp)
    800044f8:	6442                	ld	s0,16(sp)
    800044fa:	64a2                	ld	s1,8(sp)
    800044fc:	6105                	addi	sp,sp,32
    800044fe:	8082                	ret

0000000080004500 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80004500:	1101                	addi	sp,sp,-32
    80004502:	ec06                	sd	ra,24(sp)
    80004504:	e822                	sd	s0,16(sp)
    80004506:	e426                	sd	s1,8(sp)
    80004508:	1000                	addi	s0,sp,32
    8000450a:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    8000450c:	0001d517          	auipc	a0,0x1d
    80004510:	2ac50513          	addi	a0,a0,684 # 800217b8 <ftable>
    80004514:	ffffc097          	auipc	ra,0xffffc
    80004518:	6bc080e7          	jalr	1724(ra) # 80000bd0 <acquire>
  if(f->ref < 1)
    8000451c:	40dc                	lw	a5,4(s1)
    8000451e:	02f05263          	blez	a5,80004542 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80004522:	2785                	addiw	a5,a5,1
    80004524:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80004526:	0001d517          	auipc	a0,0x1d
    8000452a:	29250513          	addi	a0,a0,658 # 800217b8 <ftable>
    8000452e:	ffffc097          	auipc	ra,0xffffc
    80004532:	756080e7          	jalr	1878(ra) # 80000c84 <release>
  return f;
}
    80004536:	8526                	mv	a0,s1
    80004538:	60e2                	ld	ra,24(sp)
    8000453a:	6442                	ld	s0,16(sp)
    8000453c:	64a2                	ld	s1,8(sp)
    8000453e:	6105                	addi	sp,sp,32
    80004540:	8082                	ret
    panic("filedup");
    80004542:	00004517          	auipc	a0,0x4
    80004546:	14e50513          	addi	a0,a0,334 # 80008690 <syscalls+0x248>
    8000454a:	ffffc097          	auipc	ra,0xffffc
    8000454e:	ff0080e7          	jalr	-16(ra) # 8000053a <panic>

0000000080004552 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80004552:	7139                	addi	sp,sp,-64
    80004554:	fc06                	sd	ra,56(sp)
    80004556:	f822                	sd	s0,48(sp)
    80004558:	f426                	sd	s1,40(sp)
    8000455a:	f04a                	sd	s2,32(sp)
    8000455c:	ec4e                	sd	s3,24(sp)
    8000455e:	e852                	sd	s4,16(sp)
    80004560:	e456                	sd	s5,8(sp)
    80004562:	0080                	addi	s0,sp,64
    80004564:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80004566:	0001d517          	auipc	a0,0x1d
    8000456a:	25250513          	addi	a0,a0,594 # 800217b8 <ftable>
    8000456e:	ffffc097          	auipc	ra,0xffffc
    80004572:	662080e7          	jalr	1634(ra) # 80000bd0 <acquire>
  if(f->ref < 1)
    80004576:	40dc                	lw	a5,4(s1)
    80004578:	06f05163          	blez	a5,800045da <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    8000457c:	37fd                	addiw	a5,a5,-1
    8000457e:	0007871b          	sext.w	a4,a5
    80004582:	c0dc                	sw	a5,4(s1)
    80004584:	06e04363          	bgtz	a4,800045ea <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80004588:	0004a903          	lw	s2,0(s1)
    8000458c:	0094ca83          	lbu	s5,9(s1)
    80004590:	0104ba03          	ld	s4,16(s1)
    80004594:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80004598:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    8000459c:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    800045a0:	0001d517          	auipc	a0,0x1d
    800045a4:	21850513          	addi	a0,a0,536 # 800217b8 <ftable>
    800045a8:	ffffc097          	auipc	ra,0xffffc
    800045ac:	6dc080e7          	jalr	1756(ra) # 80000c84 <release>

  if(ff.type == FD_PIPE){
    800045b0:	4785                	li	a5,1
    800045b2:	04f90d63          	beq	s2,a5,8000460c <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    800045b6:	3979                	addiw	s2,s2,-2
    800045b8:	4785                	li	a5,1
    800045ba:	0527e063          	bltu	a5,s2,800045fa <fileclose+0xa8>
    begin_op();
    800045be:	00000097          	auipc	ra,0x0
    800045c2:	acc080e7          	jalr	-1332(ra) # 8000408a <begin_op>
    iput(ff.ip);
    800045c6:	854e                	mv	a0,s3
    800045c8:	fffff097          	auipc	ra,0xfffff
    800045cc:	2a0080e7          	jalr	672(ra) # 80003868 <iput>
    end_op();
    800045d0:	00000097          	auipc	ra,0x0
    800045d4:	b38080e7          	jalr	-1224(ra) # 80004108 <end_op>
    800045d8:	a00d                	j	800045fa <fileclose+0xa8>
    panic("fileclose");
    800045da:	00004517          	auipc	a0,0x4
    800045de:	0be50513          	addi	a0,a0,190 # 80008698 <syscalls+0x250>
    800045e2:	ffffc097          	auipc	ra,0xffffc
    800045e6:	f58080e7          	jalr	-168(ra) # 8000053a <panic>
    release(&ftable.lock);
    800045ea:	0001d517          	auipc	a0,0x1d
    800045ee:	1ce50513          	addi	a0,a0,462 # 800217b8 <ftable>
    800045f2:	ffffc097          	auipc	ra,0xffffc
    800045f6:	692080e7          	jalr	1682(ra) # 80000c84 <release>
  }
}
    800045fa:	70e2                	ld	ra,56(sp)
    800045fc:	7442                	ld	s0,48(sp)
    800045fe:	74a2                	ld	s1,40(sp)
    80004600:	7902                	ld	s2,32(sp)
    80004602:	69e2                	ld	s3,24(sp)
    80004604:	6a42                	ld	s4,16(sp)
    80004606:	6aa2                	ld	s5,8(sp)
    80004608:	6121                	addi	sp,sp,64
    8000460a:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    8000460c:	85d6                	mv	a1,s5
    8000460e:	8552                	mv	a0,s4
    80004610:	00000097          	auipc	ra,0x0
    80004614:	34c080e7          	jalr	844(ra) # 8000495c <pipeclose>
    80004618:	b7cd                	j	800045fa <fileclose+0xa8>

000000008000461a <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    8000461a:	715d                	addi	sp,sp,-80
    8000461c:	e486                	sd	ra,72(sp)
    8000461e:	e0a2                	sd	s0,64(sp)
    80004620:	fc26                	sd	s1,56(sp)
    80004622:	f84a                	sd	s2,48(sp)
    80004624:	f44e                	sd	s3,40(sp)
    80004626:	0880                	addi	s0,sp,80
    80004628:	84aa                	mv	s1,a0
    8000462a:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    8000462c:	ffffd097          	auipc	ra,0xffffd
    80004630:	36a080e7          	jalr	874(ra) # 80001996 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80004634:	409c                	lw	a5,0(s1)
    80004636:	37f9                	addiw	a5,a5,-2
    80004638:	4705                	li	a4,1
    8000463a:	04f76763          	bltu	a4,a5,80004688 <filestat+0x6e>
    8000463e:	892a                	mv	s2,a0
    ilock(f->ip);
    80004640:	6c88                	ld	a0,24(s1)
    80004642:	fffff097          	auipc	ra,0xfffff
    80004646:	06c080e7          	jalr	108(ra) # 800036ae <ilock>
    stati(f->ip, &st);
    8000464a:	fb840593          	addi	a1,s0,-72
    8000464e:	6c88                	ld	a0,24(s1)
    80004650:	fffff097          	auipc	ra,0xfffff
    80004654:	2e8080e7          	jalr	744(ra) # 80003938 <stati>
    iunlock(f->ip);
    80004658:	6c88                	ld	a0,24(s1)
    8000465a:	fffff097          	auipc	ra,0xfffff
    8000465e:	116080e7          	jalr	278(ra) # 80003770 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80004662:	46e1                	li	a3,24
    80004664:	fb840613          	addi	a2,s0,-72
    80004668:	85ce                	mv	a1,s3
    8000466a:	06093503          	ld	a0,96(s2)
    8000466e:	ffffd097          	auipc	ra,0xffffd
    80004672:	fec080e7          	jalr	-20(ra) # 8000165a <copyout>
    80004676:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    8000467a:	60a6                	ld	ra,72(sp)
    8000467c:	6406                	ld	s0,64(sp)
    8000467e:	74e2                	ld	s1,56(sp)
    80004680:	7942                	ld	s2,48(sp)
    80004682:	79a2                	ld	s3,40(sp)
    80004684:	6161                	addi	sp,sp,80
    80004686:	8082                	ret
  return -1;
    80004688:	557d                	li	a0,-1
    8000468a:	bfc5                	j	8000467a <filestat+0x60>

000000008000468c <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    8000468c:	7179                	addi	sp,sp,-48
    8000468e:	f406                	sd	ra,40(sp)
    80004690:	f022                	sd	s0,32(sp)
    80004692:	ec26                	sd	s1,24(sp)
    80004694:	e84a                	sd	s2,16(sp)
    80004696:	e44e                	sd	s3,8(sp)
    80004698:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    8000469a:	00854783          	lbu	a5,8(a0)
    8000469e:	c3d5                	beqz	a5,80004742 <fileread+0xb6>
    800046a0:	84aa                	mv	s1,a0
    800046a2:	89ae                	mv	s3,a1
    800046a4:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    800046a6:	411c                	lw	a5,0(a0)
    800046a8:	4705                	li	a4,1
    800046aa:	04e78963          	beq	a5,a4,800046fc <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800046ae:	470d                	li	a4,3
    800046b0:	04e78d63          	beq	a5,a4,8000470a <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    800046b4:	4709                	li	a4,2
    800046b6:	06e79e63          	bne	a5,a4,80004732 <fileread+0xa6>
    ilock(f->ip);
    800046ba:	6d08                	ld	a0,24(a0)
    800046bc:	fffff097          	auipc	ra,0xfffff
    800046c0:	ff2080e7          	jalr	-14(ra) # 800036ae <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    800046c4:	874a                	mv	a4,s2
    800046c6:	5094                	lw	a3,32(s1)
    800046c8:	864e                	mv	a2,s3
    800046ca:	4585                	li	a1,1
    800046cc:	6c88                	ld	a0,24(s1)
    800046ce:	fffff097          	auipc	ra,0xfffff
    800046d2:	294080e7          	jalr	660(ra) # 80003962 <readi>
    800046d6:	892a                	mv	s2,a0
    800046d8:	00a05563          	blez	a0,800046e2 <fileread+0x56>
      f->off += r;
    800046dc:	509c                	lw	a5,32(s1)
    800046de:	9fa9                	addw	a5,a5,a0
    800046e0:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    800046e2:	6c88                	ld	a0,24(s1)
    800046e4:	fffff097          	auipc	ra,0xfffff
    800046e8:	08c080e7          	jalr	140(ra) # 80003770 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    800046ec:	854a                	mv	a0,s2
    800046ee:	70a2                	ld	ra,40(sp)
    800046f0:	7402                	ld	s0,32(sp)
    800046f2:	64e2                	ld	s1,24(sp)
    800046f4:	6942                	ld	s2,16(sp)
    800046f6:	69a2                	ld	s3,8(sp)
    800046f8:	6145                	addi	sp,sp,48
    800046fa:	8082                	ret
    r = piperead(f->pipe, addr, n);
    800046fc:	6908                	ld	a0,16(a0)
    800046fe:	00000097          	auipc	ra,0x0
    80004702:	3c0080e7          	jalr	960(ra) # 80004abe <piperead>
    80004706:	892a                	mv	s2,a0
    80004708:	b7d5                	j	800046ec <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    8000470a:	02451783          	lh	a5,36(a0)
    8000470e:	03079693          	slli	a3,a5,0x30
    80004712:	92c1                	srli	a3,a3,0x30
    80004714:	4725                	li	a4,9
    80004716:	02d76863          	bltu	a4,a3,80004746 <fileread+0xba>
    8000471a:	0792                	slli	a5,a5,0x4
    8000471c:	0001d717          	auipc	a4,0x1d
    80004720:	ffc70713          	addi	a4,a4,-4 # 80021718 <devsw>
    80004724:	97ba                	add	a5,a5,a4
    80004726:	639c                	ld	a5,0(a5)
    80004728:	c38d                	beqz	a5,8000474a <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    8000472a:	4505                	li	a0,1
    8000472c:	9782                	jalr	a5
    8000472e:	892a                	mv	s2,a0
    80004730:	bf75                	j	800046ec <fileread+0x60>
    panic("fileread");
    80004732:	00004517          	auipc	a0,0x4
    80004736:	f7650513          	addi	a0,a0,-138 # 800086a8 <syscalls+0x260>
    8000473a:	ffffc097          	auipc	ra,0xffffc
    8000473e:	e00080e7          	jalr	-512(ra) # 8000053a <panic>
    return -1;
    80004742:	597d                	li	s2,-1
    80004744:	b765                	j	800046ec <fileread+0x60>
      return -1;
    80004746:	597d                	li	s2,-1
    80004748:	b755                	j	800046ec <fileread+0x60>
    8000474a:	597d                	li	s2,-1
    8000474c:	b745                	j	800046ec <fileread+0x60>

000000008000474e <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    8000474e:	715d                	addi	sp,sp,-80
    80004750:	e486                	sd	ra,72(sp)
    80004752:	e0a2                	sd	s0,64(sp)
    80004754:	fc26                	sd	s1,56(sp)
    80004756:	f84a                	sd	s2,48(sp)
    80004758:	f44e                	sd	s3,40(sp)
    8000475a:	f052                	sd	s4,32(sp)
    8000475c:	ec56                	sd	s5,24(sp)
    8000475e:	e85a                	sd	s6,16(sp)
    80004760:	e45e                	sd	s7,8(sp)
    80004762:	e062                	sd	s8,0(sp)
    80004764:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    80004766:	00954783          	lbu	a5,9(a0)
    8000476a:	10078663          	beqz	a5,80004876 <filewrite+0x128>
    8000476e:	892a                	mv	s2,a0
    80004770:	8b2e                	mv	s6,a1
    80004772:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80004774:	411c                	lw	a5,0(a0)
    80004776:	4705                	li	a4,1
    80004778:	02e78263          	beq	a5,a4,8000479c <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    8000477c:	470d                	li	a4,3
    8000477e:	02e78663          	beq	a5,a4,800047aa <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80004782:	4709                	li	a4,2
    80004784:	0ee79163          	bne	a5,a4,80004866 <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80004788:	0ac05d63          	blez	a2,80004842 <filewrite+0xf4>
    int i = 0;
    8000478c:	4981                	li	s3,0
    8000478e:	6b85                	lui	s7,0x1
    80004790:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80004794:	6c05                	lui	s8,0x1
    80004796:	c00c0c1b          	addiw	s8,s8,-1024
    8000479a:	a861                	j	80004832 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    8000479c:	6908                	ld	a0,16(a0)
    8000479e:	00000097          	auipc	ra,0x0
    800047a2:	22e080e7          	jalr	558(ra) # 800049cc <pipewrite>
    800047a6:	8a2a                	mv	s4,a0
    800047a8:	a045                	j	80004848 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    800047aa:	02451783          	lh	a5,36(a0)
    800047ae:	03079693          	slli	a3,a5,0x30
    800047b2:	92c1                	srli	a3,a3,0x30
    800047b4:	4725                	li	a4,9
    800047b6:	0cd76263          	bltu	a4,a3,8000487a <filewrite+0x12c>
    800047ba:	0792                	slli	a5,a5,0x4
    800047bc:	0001d717          	auipc	a4,0x1d
    800047c0:	f5c70713          	addi	a4,a4,-164 # 80021718 <devsw>
    800047c4:	97ba                	add	a5,a5,a4
    800047c6:	679c                	ld	a5,8(a5)
    800047c8:	cbdd                	beqz	a5,8000487e <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    800047ca:	4505                	li	a0,1
    800047cc:	9782                	jalr	a5
    800047ce:	8a2a                	mv	s4,a0
    800047d0:	a8a5                	j	80004848 <filewrite+0xfa>
    800047d2:	00048a9b          	sext.w	s5,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    800047d6:	00000097          	auipc	ra,0x0
    800047da:	8b4080e7          	jalr	-1868(ra) # 8000408a <begin_op>
      ilock(f->ip);
    800047de:	01893503          	ld	a0,24(s2)
    800047e2:	fffff097          	auipc	ra,0xfffff
    800047e6:	ecc080e7          	jalr	-308(ra) # 800036ae <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    800047ea:	8756                	mv	a4,s5
    800047ec:	02092683          	lw	a3,32(s2)
    800047f0:	01698633          	add	a2,s3,s6
    800047f4:	4585                	li	a1,1
    800047f6:	01893503          	ld	a0,24(s2)
    800047fa:	fffff097          	auipc	ra,0xfffff
    800047fe:	260080e7          	jalr	608(ra) # 80003a5a <writei>
    80004802:	84aa                	mv	s1,a0
    80004804:	00a05763          	blez	a0,80004812 <filewrite+0xc4>
        f->off += r;
    80004808:	02092783          	lw	a5,32(s2)
    8000480c:	9fa9                	addw	a5,a5,a0
    8000480e:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80004812:	01893503          	ld	a0,24(s2)
    80004816:	fffff097          	auipc	ra,0xfffff
    8000481a:	f5a080e7          	jalr	-166(ra) # 80003770 <iunlock>
      end_op();
    8000481e:	00000097          	auipc	ra,0x0
    80004822:	8ea080e7          	jalr	-1814(ra) # 80004108 <end_op>

      if(r != n1){
    80004826:	009a9f63          	bne	s5,s1,80004844 <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    8000482a:	013489bb          	addw	s3,s1,s3
    while(i < n){
    8000482e:	0149db63          	bge	s3,s4,80004844 <filewrite+0xf6>
      int n1 = n - i;
    80004832:	413a04bb          	subw	s1,s4,s3
    80004836:	0004879b          	sext.w	a5,s1
    8000483a:	f8fbdce3          	bge	s7,a5,800047d2 <filewrite+0x84>
    8000483e:	84e2                	mv	s1,s8
    80004840:	bf49                	j	800047d2 <filewrite+0x84>
    int i = 0;
    80004842:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80004844:	013a1f63          	bne	s4,s3,80004862 <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80004848:	8552                	mv	a0,s4
    8000484a:	60a6                	ld	ra,72(sp)
    8000484c:	6406                	ld	s0,64(sp)
    8000484e:	74e2                	ld	s1,56(sp)
    80004850:	7942                	ld	s2,48(sp)
    80004852:	79a2                	ld	s3,40(sp)
    80004854:	7a02                	ld	s4,32(sp)
    80004856:	6ae2                	ld	s5,24(sp)
    80004858:	6b42                	ld	s6,16(sp)
    8000485a:	6ba2                	ld	s7,8(sp)
    8000485c:	6c02                	ld	s8,0(sp)
    8000485e:	6161                	addi	sp,sp,80
    80004860:	8082                	ret
    ret = (i == n ? n : -1);
    80004862:	5a7d                	li	s4,-1
    80004864:	b7d5                	j	80004848 <filewrite+0xfa>
    panic("filewrite");
    80004866:	00004517          	auipc	a0,0x4
    8000486a:	e5250513          	addi	a0,a0,-430 # 800086b8 <syscalls+0x270>
    8000486e:	ffffc097          	auipc	ra,0xffffc
    80004872:	ccc080e7          	jalr	-820(ra) # 8000053a <panic>
    return -1;
    80004876:	5a7d                	li	s4,-1
    80004878:	bfc1                	j	80004848 <filewrite+0xfa>
      return -1;
    8000487a:	5a7d                	li	s4,-1
    8000487c:	b7f1                	j	80004848 <filewrite+0xfa>
    8000487e:	5a7d                	li	s4,-1
    80004880:	b7e1                	j	80004848 <filewrite+0xfa>

0000000080004882 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80004882:	7179                	addi	sp,sp,-48
    80004884:	f406                	sd	ra,40(sp)
    80004886:	f022                	sd	s0,32(sp)
    80004888:	ec26                	sd	s1,24(sp)
    8000488a:	e84a                	sd	s2,16(sp)
    8000488c:	e44e                	sd	s3,8(sp)
    8000488e:	e052                	sd	s4,0(sp)
    80004890:	1800                	addi	s0,sp,48
    80004892:	84aa                	mv	s1,a0
    80004894:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80004896:	0005b023          	sd	zero,0(a1)
    8000489a:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    8000489e:	00000097          	auipc	ra,0x0
    800048a2:	bf8080e7          	jalr	-1032(ra) # 80004496 <filealloc>
    800048a6:	e088                	sd	a0,0(s1)
    800048a8:	c551                	beqz	a0,80004934 <pipealloc+0xb2>
    800048aa:	00000097          	auipc	ra,0x0
    800048ae:	bec080e7          	jalr	-1044(ra) # 80004496 <filealloc>
    800048b2:	00aa3023          	sd	a0,0(s4)
    800048b6:	c92d                	beqz	a0,80004928 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800048b8:	ffffc097          	auipc	ra,0xffffc
    800048bc:	228080e7          	jalr	552(ra) # 80000ae0 <kalloc>
    800048c0:	892a                	mv	s2,a0
    800048c2:	c125                	beqz	a0,80004922 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    800048c4:	4985                	li	s3,1
    800048c6:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    800048ca:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    800048ce:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    800048d2:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    800048d6:	00004597          	auipc	a1,0x4
    800048da:	df258593          	addi	a1,a1,-526 # 800086c8 <syscalls+0x280>
    800048de:	ffffc097          	auipc	ra,0xffffc
    800048e2:	262080e7          	jalr	610(ra) # 80000b40 <initlock>
  (*f0)->type = FD_PIPE;
    800048e6:	609c                	ld	a5,0(s1)
    800048e8:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    800048ec:	609c                	ld	a5,0(s1)
    800048ee:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    800048f2:	609c                	ld	a5,0(s1)
    800048f4:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    800048f8:	609c                	ld	a5,0(s1)
    800048fa:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    800048fe:	000a3783          	ld	a5,0(s4)
    80004902:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80004906:	000a3783          	ld	a5,0(s4)
    8000490a:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    8000490e:	000a3783          	ld	a5,0(s4)
    80004912:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80004916:	000a3783          	ld	a5,0(s4)
    8000491a:	0127b823          	sd	s2,16(a5)
  return 0;
    8000491e:	4501                	li	a0,0
    80004920:	a025                	j	80004948 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004922:	6088                	ld	a0,0(s1)
    80004924:	e501                	bnez	a0,8000492c <pipealloc+0xaa>
    80004926:	a039                	j	80004934 <pipealloc+0xb2>
    80004928:	6088                	ld	a0,0(s1)
    8000492a:	c51d                	beqz	a0,80004958 <pipealloc+0xd6>
    fileclose(*f0);
    8000492c:	00000097          	auipc	ra,0x0
    80004930:	c26080e7          	jalr	-986(ra) # 80004552 <fileclose>
  if(*f1)
    80004934:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80004938:	557d                	li	a0,-1
  if(*f1)
    8000493a:	c799                	beqz	a5,80004948 <pipealloc+0xc6>
    fileclose(*f1);
    8000493c:	853e                	mv	a0,a5
    8000493e:	00000097          	auipc	ra,0x0
    80004942:	c14080e7          	jalr	-1004(ra) # 80004552 <fileclose>
  return -1;
    80004946:	557d                	li	a0,-1
}
    80004948:	70a2                	ld	ra,40(sp)
    8000494a:	7402                	ld	s0,32(sp)
    8000494c:	64e2                	ld	s1,24(sp)
    8000494e:	6942                	ld	s2,16(sp)
    80004950:	69a2                	ld	s3,8(sp)
    80004952:	6a02                	ld	s4,0(sp)
    80004954:	6145                	addi	sp,sp,48
    80004956:	8082                	ret
  return -1;
    80004958:	557d                	li	a0,-1
    8000495a:	b7fd                	j	80004948 <pipealloc+0xc6>

000000008000495c <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    8000495c:	1101                	addi	sp,sp,-32
    8000495e:	ec06                	sd	ra,24(sp)
    80004960:	e822                	sd	s0,16(sp)
    80004962:	e426                	sd	s1,8(sp)
    80004964:	e04a                	sd	s2,0(sp)
    80004966:	1000                	addi	s0,sp,32
    80004968:	84aa                	mv	s1,a0
    8000496a:	892e                	mv	s2,a1
  acquire(&pi->lock);
    8000496c:	ffffc097          	auipc	ra,0xffffc
    80004970:	264080e7          	jalr	612(ra) # 80000bd0 <acquire>
  if(writable){
    80004974:	02090d63          	beqz	s2,800049ae <pipeclose+0x52>
    pi->writeopen = 0;
    80004978:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    8000497c:	21848513          	addi	a0,s1,536
    80004980:	ffffe097          	auipc	ra,0xffffe
    80004984:	870080e7          	jalr	-1936(ra) # 800021f0 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004988:	2204b783          	ld	a5,544(s1)
    8000498c:	eb95                	bnez	a5,800049c0 <pipeclose+0x64>
    release(&pi->lock);
    8000498e:	8526                	mv	a0,s1
    80004990:	ffffc097          	auipc	ra,0xffffc
    80004994:	2f4080e7          	jalr	756(ra) # 80000c84 <release>
    kfree((char*)pi);
    80004998:	8526                	mv	a0,s1
    8000499a:	ffffc097          	auipc	ra,0xffffc
    8000499e:	048080e7          	jalr	72(ra) # 800009e2 <kfree>
  } else
    release(&pi->lock);
}
    800049a2:	60e2                	ld	ra,24(sp)
    800049a4:	6442                	ld	s0,16(sp)
    800049a6:	64a2                	ld	s1,8(sp)
    800049a8:	6902                	ld	s2,0(sp)
    800049aa:	6105                	addi	sp,sp,32
    800049ac:	8082                	ret
    pi->readopen = 0;
    800049ae:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    800049b2:	21c48513          	addi	a0,s1,540
    800049b6:	ffffe097          	auipc	ra,0xffffe
    800049ba:	83a080e7          	jalr	-1990(ra) # 800021f0 <wakeup>
    800049be:	b7e9                	j	80004988 <pipeclose+0x2c>
    release(&pi->lock);
    800049c0:	8526                	mv	a0,s1
    800049c2:	ffffc097          	auipc	ra,0xffffc
    800049c6:	2c2080e7          	jalr	706(ra) # 80000c84 <release>
}
    800049ca:	bfe1                	j	800049a2 <pipeclose+0x46>

00000000800049cc <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800049cc:	711d                	addi	sp,sp,-96
    800049ce:	ec86                	sd	ra,88(sp)
    800049d0:	e8a2                	sd	s0,80(sp)
    800049d2:	e4a6                	sd	s1,72(sp)
    800049d4:	e0ca                	sd	s2,64(sp)
    800049d6:	fc4e                	sd	s3,56(sp)
    800049d8:	f852                	sd	s4,48(sp)
    800049da:	f456                	sd	s5,40(sp)
    800049dc:	f05a                	sd	s6,32(sp)
    800049de:	ec5e                	sd	s7,24(sp)
    800049e0:	e862                	sd	s8,16(sp)
    800049e2:	1080                	addi	s0,sp,96
    800049e4:	84aa                	mv	s1,a0
    800049e6:	8aae                	mv	s5,a1
    800049e8:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    800049ea:	ffffd097          	auipc	ra,0xffffd
    800049ee:	fac080e7          	jalr	-84(ra) # 80001996 <myproc>
    800049f2:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    800049f4:	8526                	mv	a0,s1
    800049f6:	ffffc097          	auipc	ra,0xffffc
    800049fa:	1da080e7          	jalr	474(ra) # 80000bd0 <acquire>
  while(i < n){
    800049fe:	0b405363          	blez	s4,80004aa4 <pipewrite+0xd8>
  int i = 0;
    80004a02:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004a04:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80004a06:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80004a0a:	21c48b93          	addi	s7,s1,540
    80004a0e:	a089                	j	80004a50 <pipewrite+0x84>
      release(&pi->lock);
    80004a10:	8526                	mv	a0,s1
    80004a12:	ffffc097          	auipc	ra,0xffffc
    80004a16:	272080e7          	jalr	626(ra) # 80000c84 <release>
      return -1;
    80004a1a:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004a1c:	854a                	mv	a0,s2
    80004a1e:	60e6                	ld	ra,88(sp)
    80004a20:	6446                	ld	s0,80(sp)
    80004a22:	64a6                	ld	s1,72(sp)
    80004a24:	6906                	ld	s2,64(sp)
    80004a26:	79e2                	ld	s3,56(sp)
    80004a28:	7a42                	ld	s4,48(sp)
    80004a2a:	7aa2                	ld	s5,40(sp)
    80004a2c:	7b02                	ld	s6,32(sp)
    80004a2e:	6be2                	ld	s7,24(sp)
    80004a30:	6c42                	ld	s8,16(sp)
    80004a32:	6125                	addi	sp,sp,96
    80004a34:	8082                	ret
      wakeup(&pi->nread);
    80004a36:	8562                	mv	a0,s8
    80004a38:	ffffd097          	auipc	ra,0xffffd
    80004a3c:	7b8080e7          	jalr	1976(ra) # 800021f0 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004a40:	85a6                	mv	a1,s1
    80004a42:	855e                	mv	a0,s7
    80004a44:	ffffd097          	auipc	ra,0xffffd
    80004a48:	620080e7          	jalr	1568(ra) # 80002064 <sleep>
  while(i < n){
    80004a4c:	05495d63          	bge	s2,s4,80004aa6 <pipewrite+0xda>
    if(pi->readopen == 0 || pr->killed){
    80004a50:	2204a783          	lw	a5,544(s1)
    80004a54:	dfd5                	beqz	a5,80004a10 <pipewrite+0x44>
    80004a56:	0289a783          	lw	a5,40(s3)
    80004a5a:	fbdd                	bnez	a5,80004a10 <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004a5c:	2184a783          	lw	a5,536(s1)
    80004a60:	21c4a703          	lw	a4,540(s1)
    80004a64:	2007879b          	addiw	a5,a5,512
    80004a68:	fcf707e3          	beq	a4,a5,80004a36 <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004a6c:	4685                	li	a3,1
    80004a6e:	01590633          	add	a2,s2,s5
    80004a72:	faf40593          	addi	a1,s0,-81
    80004a76:	0609b503          	ld	a0,96(s3)
    80004a7a:	ffffd097          	auipc	ra,0xffffd
    80004a7e:	c6c080e7          	jalr	-916(ra) # 800016e6 <copyin>
    80004a82:	03650263          	beq	a0,s6,80004aa6 <pipewrite+0xda>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004a86:	21c4a783          	lw	a5,540(s1)
    80004a8a:	0017871b          	addiw	a4,a5,1
    80004a8e:	20e4ae23          	sw	a4,540(s1)
    80004a92:	1ff7f793          	andi	a5,a5,511
    80004a96:	97a6                	add	a5,a5,s1
    80004a98:	faf44703          	lbu	a4,-81(s0)
    80004a9c:	00e78c23          	sb	a4,24(a5)
      i++;
    80004aa0:	2905                	addiw	s2,s2,1
    80004aa2:	b76d                	j	80004a4c <pipewrite+0x80>
  int i = 0;
    80004aa4:	4901                	li	s2,0
  wakeup(&pi->nread);
    80004aa6:	21848513          	addi	a0,s1,536
    80004aaa:	ffffd097          	auipc	ra,0xffffd
    80004aae:	746080e7          	jalr	1862(ra) # 800021f0 <wakeup>
  release(&pi->lock);
    80004ab2:	8526                	mv	a0,s1
    80004ab4:	ffffc097          	auipc	ra,0xffffc
    80004ab8:	1d0080e7          	jalr	464(ra) # 80000c84 <release>
  return i;
    80004abc:	b785                	j	80004a1c <pipewrite+0x50>

0000000080004abe <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004abe:	715d                	addi	sp,sp,-80
    80004ac0:	e486                	sd	ra,72(sp)
    80004ac2:	e0a2                	sd	s0,64(sp)
    80004ac4:	fc26                	sd	s1,56(sp)
    80004ac6:	f84a                	sd	s2,48(sp)
    80004ac8:	f44e                	sd	s3,40(sp)
    80004aca:	f052                	sd	s4,32(sp)
    80004acc:	ec56                	sd	s5,24(sp)
    80004ace:	e85a                	sd	s6,16(sp)
    80004ad0:	0880                	addi	s0,sp,80
    80004ad2:	84aa                	mv	s1,a0
    80004ad4:	892e                	mv	s2,a1
    80004ad6:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80004ad8:	ffffd097          	auipc	ra,0xffffd
    80004adc:	ebe080e7          	jalr	-322(ra) # 80001996 <myproc>
    80004ae0:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80004ae2:	8526                	mv	a0,s1
    80004ae4:	ffffc097          	auipc	ra,0xffffc
    80004ae8:	0ec080e7          	jalr	236(ra) # 80000bd0 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004aec:	2184a703          	lw	a4,536(s1)
    80004af0:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004af4:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004af8:	02f71463          	bne	a4,a5,80004b20 <piperead+0x62>
    80004afc:	2244a783          	lw	a5,548(s1)
    80004b00:	c385                	beqz	a5,80004b20 <piperead+0x62>
    if(pr->killed){
    80004b02:	028a2783          	lw	a5,40(s4)
    80004b06:	ebc9                	bnez	a5,80004b98 <piperead+0xda>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004b08:	85a6                	mv	a1,s1
    80004b0a:	854e                	mv	a0,s3
    80004b0c:	ffffd097          	auipc	ra,0xffffd
    80004b10:	558080e7          	jalr	1368(ra) # 80002064 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004b14:	2184a703          	lw	a4,536(s1)
    80004b18:	21c4a783          	lw	a5,540(s1)
    80004b1c:	fef700e3          	beq	a4,a5,80004afc <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004b20:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004b22:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004b24:	05505463          	blez	s5,80004b6c <piperead+0xae>
    if(pi->nread == pi->nwrite)
    80004b28:	2184a783          	lw	a5,536(s1)
    80004b2c:	21c4a703          	lw	a4,540(s1)
    80004b30:	02f70e63          	beq	a4,a5,80004b6c <piperead+0xae>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004b34:	0017871b          	addiw	a4,a5,1
    80004b38:	20e4ac23          	sw	a4,536(s1)
    80004b3c:	1ff7f793          	andi	a5,a5,511
    80004b40:	97a6                	add	a5,a5,s1
    80004b42:	0187c783          	lbu	a5,24(a5)
    80004b46:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004b4a:	4685                	li	a3,1
    80004b4c:	fbf40613          	addi	a2,s0,-65
    80004b50:	85ca                	mv	a1,s2
    80004b52:	060a3503          	ld	a0,96(s4)
    80004b56:	ffffd097          	auipc	ra,0xffffd
    80004b5a:	b04080e7          	jalr	-1276(ra) # 8000165a <copyout>
    80004b5e:	01650763          	beq	a0,s6,80004b6c <piperead+0xae>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004b62:	2985                	addiw	s3,s3,1
    80004b64:	0905                	addi	s2,s2,1
    80004b66:	fd3a91e3          	bne	s5,s3,80004b28 <piperead+0x6a>
    80004b6a:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004b6c:	21c48513          	addi	a0,s1,540
    80004b70:	ffffd097          	auipc	ra,0xffffd
    80004b74:	680080e7          	jalr	1664(ra) # 800021f0 <wakeup>
  release(&pi->lock);
    80004b78:	8526                	mv	a0,s1
    80004b7a:	ffffc097          	auipc	ra,0xffffc
    80004b7e:	10a080e7          	jalr	266(ra) # 80000c84 <release>
  return i;
}
    80004b82:	854e                	mv	a0,s3
    80004b84:	60a6                	ld	ra,72(sp)
    80004b86:	6406                	ld	s0,64(sp)
    80004b88:	74e2                	ld	s1,56(sp)
    80004b8a:	7942                	ld	s2,48(sp)
    80004b8c:	79a2                	ld	s3,40(sp)
    80004b8e:	7a02                	ld	s4,32(sp)
    80004b90:	6ae2                	ld	s5,24(sp)
    80004b92:	6b42                	ld	s6,16(sp)
    80004b94:	6161                	addi	sp,sp,80
    80004b96:	8082                	ret
      release(&pi->lock);
    80004b98:	8526                	mv	a0,s1
    80004b9a:	ffffc097          	auipc	ra,0xffffc
    80004b9e:	0ea080e7          	jalr	234(ra) # 80000c84 <release>
      return -1;
    80004ba2:	59fd                	li	s3,-1
    80004ba4:	bff9                	j	80004b82 <piperead+0xc4>

0000000080004ba6 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    80004ba6:	de010113          	addi	sp,sp,-544
    80004baa:	20113c23          	sd	ra,536(sp)
    80004bae:	20813823          	sd	s0,528(sp)
    80004bb2:	20913423          	sd	s1,520(sp)
    80004bb6:	21213023          	sd	s2,512(sp)
    80004bba:	ffce                	sd	s3,504(sp)
    80004bbc:	fbd2                	sd	s4,496(sp)
    80004bbe:	f7d6                	sd	s5,488(sp)
    80004bc0:	f3da                	sd	s6,480(sp)
    80004bc2:	efde                	sd	s7,472(sp)
    80004bc4:	ebe2                	sd	s8,464(sp)
    80004bc6:	e7e6                	sd	s9,456(sp)
    80004bc8:	e3ea                	sd	s10,448(sp)
    80004bca:	ff6e                	sd	s11,440(sp)
    80004bcc:	1400                	addi	s0,sp,544
    80004bce:	892a                	mv	s2,a0
    80004bd0:	dea43423          	sd	a0,-536(s0)
    80004bd4:	deb43823          	sd	a1,-528(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004bd8:	ffffd097          	auipc	ra,0xffffd
    80004bdc:	dbe080e7          	jalr	-578(ra) # 80001996 <myproc>
    80004be0:	84aa                	mv	s1,a0

  begin_op();
    80004be2:	fffff097          	auipc	ra,0xfffff
    80004be6:	4a8080e7          	jalr	1192(ra) # 8000408a <begin_op>

  if((ip = namei(path)) == 0){
    80004bea:	854a                	mv	a0,s2
    80004bec:	fffff097          	auipc	ra,0xfffff
    80004bf0:	27e080e7          	jalr	638(ra) # 80003e6a <namei>
    80004bf4:	c93d                	beqz	a0,80004c6a <exec+0xc4>
    80004bf6:	8aaa                	mv	s5,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004bf8:	fffff097          	auipc	ra,0xfffff
    80004bfc:	ab6080e7          	jalr	-1354(ra) # 800036ae <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004c00:	04000713          	li	a4,64
    80004c04:	4681                	li	a3,0
    80004c06:	e5040613          	addi	a2,s0,-432
    80004c0a:	4581                	li	a1,0
    80004c0c:	8556                	mv	a0,s5
    80004c0e:	fffff097          	auipc	ra,0xfffff
    80004c12:	d54080e7          	jalr	-684(ra) # 80003962 <readi>
    80004c16:	04000793          	li	a5,64
    80004c1a:	00f51a63          	bne	a0,a5,80004c2e <exec+0x88>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80004c1e:	e5042703          	lw	a4,-432(s0)
    80004c22:	464c47b7          	lui	a5,0x464c4
    80004c26:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004c2a:	04f70663          	beq	a4,a5,80004c76 <exec+0xd0>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80004c2e:	8556                	mv	a0,s5
    80004c30:	fffff097          	auipc	ra,0xfffff
    80004c34:	ce0080e7          	jalr	-800(ra) # 80003910 <iunlockput>
    end_op();
    80004c38:	fffff097          	auipc	ra,0xfffff
    80004c3c:	4d0080e7          	jalr	1232(ra) # 80004108 <end_op>
  }
  return -1;
    80004c40:	557d                	li	a0,-1
}
    80004c42:	21813083          	ld	ra,536(sp)
    80004c46:	21013403          	ld	s0,528(sp)
    80004c4a:	20813483          	ld	s1,520(sp)
    80004c4e:	20013903          	ld	s2,512(sp)
    80004c52:	79fe                	ld	s3,504(sp)
    80004c54:	7a5e                	ld	s4,496(sp)
    80004c56:	7abe                	ld	s5,488(sp)
    80004c58:	7b1e                	ld	s6,480(sp)
    80004c5a:	6bfe                	ld	s7,472(sp)
    80004c5c:	6c5e                	ld	s8,464(sp)
    80004c5e:	6cbe                	ld	s9,456(sp)
    80004c60:	6d1e                	ld	s10,448(sp)
    80004c62:	7dfa                	ld	s11,440(sp)
    80004c64:	22010113          	addi	sp,sp,544
    80004c68:	8082                	ret
    end_op();
    80004c6a:	fffff097          	auipc	ra,0xfffff
    80004c6e:	49e080e7          	jalr	1182(ra) # 80004108 <end_op>
    return -1;
    80004c72:	557d                	li	a0,-1
    80004c74:	b7f9                	j	80004c42 <exec+0x9c>
  if((pagetable = proc_pagetable(p)) == 0)
    80004c76:	8526                	mv	a0,s1
    80004c78:	ffffd097          	auipc	ra,0xffffd
    80004c7c:	de2080e7          	jalr	-542(ra) # 80001a5a <proc_pagetable>
    80004c80:	8b2a                	mv	s6,a0
    80004c82:	d555                	beqz	a0,80004c2e <exec+0x88>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004c84:	e7042783          	lw	a5,-400(s0)
    80004c88:	e8845703          	lhu	a4,-376(s0)
    80004c8c:	c735                	beqz	a4,80004cf8 <exec+0x152>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004c8e:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004c90:	e0043423          	sd	zero,-504(s0)
    if((ph.vaddr % PGSIZE) != 0)
    80004c94:	6a05                	lui	s4,0x1
    80004c96:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    80004c9a:	dee43023          	sd	a4,-544(s0)
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    80004c9e:	6d85                	lui	s11,0x1
    80004ca0:	7d7d                	lui	s10,0xfffff
    80004ca2:	ac1d                	j	80004ed8 <exec+0x332>
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    80004ca4:	00004517          	auipc	a0,0x4
    80004ca8:	a2c50513          	addi	a0,a0,-1492 # 800086d0 <syscalls+0x288>
    80004cac:	ffffc097          	auipc	ra,0xffffc
    80004cb0:	88e080e7          	jalr	-1906(ra) # 8000053a <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004cb4:	874a                	mv	a4,s2
    80004cb6:	009c86bb          	addw	a3,s9,s1
    80004cba:	4581                	li	a1,0
    80004cbc:	8556                	mv	a0,s5
    80004cbe:	fffff097          	auipc	ra,0xfffff
    80004cc2:	ca4080e7          	jalr	-860(ra) # 80003962 <readi>
    80004cc6:	2501                	sext.w	a0,a0
    80004cc8:	1aa91863          	bne	s2,a0,80004e78 <exec+0x2d2>
  for(i = 0; i < sz; i += PGSIZE){
    80004ccc:	009d84bb          	addw	s1,s11,s1
    80004cd0:	013d09bb          	addw	s3,s10,s3
    80004cd4:	1f74f263          	bgeu	s1,s7,80004eb8 <exec+0x312>
    pa = walkaddr(pagetable, va + i);
    80004cd8:	02049593          	slli	a1,s1,0x20
    80004cdc:	9181                	srli	a1,a1,0x20
    80004cde:	95e2                	add	a1,a1,s8
    80004ce0:	855a                	mv	a0,s6
    80004ce2:	ffffc097          	auipc	ra,0xffffc
    80004ce6:	370080e7          	jalr	880(ra) # 80001052 <walkaddr>
    80004cea:	862a                	mv	a2,a0
    if(pa == 0)
    80004cec:	dd45                	beqz	a0,80004ca4 <exec+0xfe>
      n = PGSIZE;
    80004cee:	8952                	mv	s2,s4
    if(sz - i < PGSIZE)
    80004cf0:	fd49f2e3          	bgeu	s3,s4,80004cb4 <exec+0x10e>
      n = sz - i;
    80004cf4:	894e                	mv	s2,s3
    80004cf6:	bf7d                	j	80004cb4 <exec+0x10e>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004cf8:	4481                	li	s1,0
  iunlockput(ip);
    80004cfa:	8556                	mv	a0,s5
    80004cfc:	fffff097          	auipc	ra,0xfffff
    80004d00:	c14080e7          	jalr	-1004(ra) # 80003910 <iunlockput>
  end_op();
    80004d04:	fffff097          	auipc	ra,0xfffff
    80004d08:	404080e7          	jalr	1028(ra) # 80004108 <end_op>
  p = myproc();
    80004d0c:	ffffd097          	auipc	ra,0xffffd
    80004d10:	c8a080e7          	jalr	-886(ra) # 80001996 <myproc>
    80004d14:	8baa                	mv	s7,a0
  uint64 oldsz = p->sz;
    80004d16:	05853d03          	ld	s10,88(a0)
  sz = PGROUNDUP(sz);
    80004d1a:	6785                	lui	a5,0x1
    80004d1c:	17fd                	addi	a5,a5,-1
    80004d1e:	97a6                	add	a5,a5,s1
    80004d20:	777d                	lui	a4,0xfffff
    80004d22:	8ff9                	and	a5,a5,a4
    80004d24:	def43c23          	sd	a5,-520(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004d28:	6609                	lui	a2,0x2
    80004d2a:	963e                	add	a2,a2,a5
    80004d2c:	85be                	mv	a1,a5
    80004d2e:	855a                	mv	a0,s6
    80004d30:	ffffc097          	auipc	ra,0xffffc
    80004d34:	6d6080e7          	jalr	1750(ra) # 80001406 <uvmalloc>
    80004d38:	8c2a                	mv	s8,a0
  ip = 0;
    80004d3a:	4a81                	li	s5,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004d3c:	12050e63          	beqz	a0,80004e78 <exec+0x2d2>
  uvmclear(pagetable, sz-2*PGSIZE);
    80004d40:	75f9                	lui	a1,0xffffe
    80004d42:	95aa                	add	a1,a1,a0
    80004d44:	855a                	mv	a0,s6
    80004d46:	ffffd097          	auipc	ra,0xffffd
    80004d4a:	8e2080e7          	jalr	-1822(ra) # 80001628 <uvmclear>
  stackbase = sp - PGSIZE;
    80004d4e:	7afd                	lui	s5,0xfffff
    80004d50:	9ae2                	add	s5,s5,s8
  for(argc = 0; argv[argc]; argc++) {
    80004d52:	df043783          	ld	a5,-528(s0)
    80004d56:	6388                	ld	a0,0(a5)
    80004d58:	c925                	beqz	a0,80004dc8 <exec+0x222>
    80004d5a:	e9040993          	addi	s3,s0,-368
    80004d5e:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    80004d62:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80004d64:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    80004d66:	ffffc097          	auipc	ra,0xffffc
    80004d6a:	0e2080e7          	jalr	226(ra) # 80000e48 <strlen>
    80004d6e:	0015079b          	addiw	a5,a0,1
    80004d72:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004d76:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    80004d7a:	13596363          	bltu	s2,s5,80004ea0 <exec+0x2fa>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004d7e:	df043d83          	ld	s11,-528(s0)
    80004d82:	000dba03          	ld	s4,0(s11) # 1000 <_entry-0x7ffff000>
    80004d86:	8552                	mv	a0,s4
    80004d88:	ffffc097          	auipc	ra,0xffffc
    80004d8c:	0c0080e7          	jalr	192(ra) # 80000e48 <strlen>
    80004d90:	0015069b          	addiw	a3,a0,1
    80004d94:	8652                	mv	a2,s4
    80004d96:	85ca                	mv	a1,s2
    80004d98:	855a                	mv	a0,s6
    80004d9a:	ffffd097          	auipc	ra,0xffffd
    80004d9e:	8c0080e7          	jalr	-1856(ra) # 8000165a <copyout>
    80004da2:	10054363          	bltz	a0,80004ea8 <exec+0x302>
    ustack[argc] = sp;
    80004da6:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80004daa:	0485                	addi	s1,s1,1
    80004dac:	008d8793          	addi	a5,s11,8
    80004db0:	def43823          	sd	a5,-528(s0)
    80004db4:	008db503          	ld	a0,8(s11)
    80004db8:	c911                	beqz	a0,80004dcc <exec+0x226>
    if(argc >= MAXARG)
    80004dba:	09a1                	addi	s3,s3,8
    80004dbc:	fb3c95e3          	bne	s9,s3,80004d66 <exec+0x1c0>
  sz = sz1;
    80004dc0:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004dc4:	4a81                	li	s5,0
    80004dc6:	a84d                	j	80004e78 <exec+0x2d2>
  sp = sz;
    80004dc8:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80004dca:	4481                	li	s1,0
  ustack[argc] = 0;
    80004dcc:	00349793          	slli	a5,s1,0x3
    80004dd0:	f9078793          	addi	a5,a5,-112 # f90 <_entry-0x7ffff070>
    80004dd4:	97a2                	add	a5,a5,s0
    80004dd6:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80004dda:	00148693          	addi	a3,s1,1
    80004dde:	068e                	slli	a3,a3,0x3
    80004de0:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004de4:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80004de8:	01597663          	bgeu	s2,s5,80004df4 <exec+0x24e>
  sz = sz1;
    80004dec:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004df0:	4a81                	li	s5,0
    80004df2:	a059                	j	80004e78 <exec+0x2d2>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004df4:	e9040613          	addi	a2,s0,-368
    80004df8:	85ca                	mv	a1,s2
    80004dfa:	855a                	mv	a0,s6
    80004dfc:	ffffd097          	auipc	ra,0xffffd
    80004e00:	85e080e7          	jalr	-1954(ra) # 8000165a <copyout>
    80004e04:	0a054663          	bltz	a0,80004eb0 <exec+0x30a>
  p->trapframe->a1 = sp;
    80004e08:	068bb783          	ld	a5,104(s7)
    80004e0c:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80004e10:	de843783          	ld	a5,-536(s0)
    80004e14:	0007c703          	lbu	a4,0(a5)
    80004e18:	cf11                	beqz	a4,80004e34 <exec+0x28e>
    80004e1a:	0785                	addi	a5,a5,1
    if(*s == '/')
    80004e1c:	02f00693          	li	a3,47
    80004e20:	a039                	j	80004e2e <exec+0x288>
      last = s+1;
    80004e22:	def43423          	sd	a5,-536(s0)
  for(last=s=path; *s; s++)
    80004e26:	0785                	addi	a5,a5,1
    80004e28:	fff7c703          	lbu	a4,-1(a5)
    80004e2c:	c701                	beqz	a4,80004e34 <exec+0x28e>
    if(*s == '/')
    80004e2e:	fed71ce3          	bne	a4,a3,80004e26 <exec+0x280>
    80004e32:	bfc5                	j	80004e22 <exec+0x27c>
  safestrcpy(p->name, last, sizeof(p->name));
    80004e34:	4641                	li	a2,16
    80004e36:	de843583          	ld	a1,-536(s0)
    80004e3a:	168b8513          	addi	a0,s7,360
    80004e3e:	ffffc097          	auipc	ra,0xffffc
    80004e42:	fd8080e7          	jalr	-40(ra) # 80000e16 <safestrcpy>
  oldpagetable = p->pagetable;
    80004e46:	060bb503          	ld	a0,96(s7)
  p->pagetable = pagetable;
    80004e4a:	076bb023          	sd	s6,96(s7)
  p->sz = sz;
    80004e4e:	058bbc23          	sd	s8,88(s7)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80004e52:	068bb783          	ld	a5,104(s7)
    80004e56:	e6843703          	ld	a4,-408(s0)
    80004e5a:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80004e5c:	068bb783          	ld	a5,104(s7)
    80004e60:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80004e64:	85ea                	mv	a1,s10
    80004e66:	ffffd097          	auipc	ra,0xffffd
    80004e6a:	c90080e7          	jalr	-880(ra) # 80001af6 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004e6e:	0004851b          	sext.w	a0,s1
    80004e72:	bbc1                	j	80004c42 <exec+0x9c>
    80004e74:	de943c23          	sd	s1,-520(s0)
    proc_freepagetable(pagetable, sz);
    80004e78:	df843583          	ld	a1,-520(s0)
    80004e7c:	855a                	mv	a0,s6
    80004e7e:	ffffd097          	auipc	ra,0xffffd
    80004e82:	c78080e7          	jalr	-904(ra) # 80001af6 <proc_freepagetable>
  if(ip){
    80004e86:	da0a94e3          	bnez	s5,80004c2e <exec+0x88>
  return -1;
    80004e8a:	557d                	li	a0,-1
    80004e8c:	bb5d                	j	80004c42 <exec+0x9c>
    80004e8e:	de943c23          	sd	s1,-520(s0)
    80004e92:	b7dd                	j	80004e78 <exec+0x2d2>
    80004e94:	de943c23          	sd	s1,-520(s0)
    80004e98:	b7c5                	j	80004e78 <exec+0x2d2>
    80004e9a:	de943c23          	sd	s1,-520(s0)
    80004e9e:	bfe9                	j	80004e78 <exec+0x2d2>
  sz = sz1;
    80004ea0:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004ea4:	4a81                	li	s5,0
    80004ea6:	bfc9                	j	80004e78 <exec+0x2d2>
  sz = sz1;
    80004ea8:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004eac:	4a81                	li	s5,0
    80004eae:	b7e9                	j	80004e78 <exec+0x2d2>
  sz = sz1;
    80004eb0:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004eb4:	4a81                	li	s5,0
    80004eb6:	b7c9                	j	80004e78 <exec+0x2d2>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80004eb8:	df843483          	ld	s1,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004ebc:	e0843783          	ld	a5,-504(s0)
    80004ec0:	0017869b          	addiw	a3,a5,1
    80004ec4:	e0d43423          	sd	a3,-504(s0)
    80004ec8:	e0043783          	ld	a5,-512(s0)
    80004ecc:	0387879b          	addiw	a5,a5,56
    80004ed0:	e8845703          	lhu	a4,-376(s0)
    80004ed4:	e2e6d3e3          	bge	a3,a4,80004cfa <exec+0x154>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004ed8:	2781                	sext.w	a5,a5
    80004eda:	e0f43023          	sd	a5,-512(s0)
    80004ede:	03800713          	li	a4,56
    80004ee2:	86be                	mv	a3,a5
    80004ee4:	e1840613          	addi	a2,s0,-488
    80004ee8:	4581                	li	a1,0
    80004eea:	8556                	mv	a0,s5
    80004eec:	fffff097          	auipc	ra,0xfffff
    80004ef0:	a76080e7          	jalr	-1418(ra) # 80003962 <readi>
    80004ef4:	03800793          	li	a5,56
    80004ef8:	f6f51ee3          	bne	a0,a5,80004e74 <exec+0x2ce>
    if(ph.type != ELF_PROG_LOAD)
    80004efc:	e1842783          	lw	a5,-488(s0)
    80004f00:	4705                	li	a4,1
    80004f02:	fae79de3          	bne	a5,a4,80004ebc <exec+0x316>
    if(ph.memsz < ph.filesz)
    80004f06:	e4043603          	ld	a2,-448(s0)
    80004f0a:	e3843783          	ld	a5,-456(s0)
    80004f0e:	f8f660e3          	bltu	a2,a5,80004e8e <exec+0x2e8>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004f12:	e2843783          	ld	a5,-472(s0)
    80004f16:	963e                	add	a2,a2,a5
    80004f18:	f6f66ee3          	bltu	a2,a5,80004e94 <exec+0x2ee>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80004f1c:	85a6                	mv	a1,s1
    80004f1e:	855a                	mv	a0,s6
    80004f20:	ffffc097          	auipc	ra,0xffffc
    80004f24:	4e6080e7          	jalr	1254(ra) # 80001406 <uvmalloc>
    80004f28:	dea43c23          	sd	a0,-520(s0)
    80004f2c:	d53d                	beqz	a0,80004e9a <exec+0x2f4>
    if((ph.vaddr % PGSIZE) != 0)
    80004f2e:	e2843c03          	ld	s8,-472(s0)
    80004f32:	de043783          	ld	a5,-544(s0)
    80004f36:	00fc77b3          	and	a5,s8,a5
    80004f3a:	ff9d                	bnez	a5,80004e78 <exec+0x2d2>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004f3c:	e2042c83          	lw	s9,-480(s0)
    80004f40:	e3842b83          	lw	s7,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004f44:	f60b8ae3          	beqz	s7,80004eb8 <exec+0x312>
    80004f48:	89de                	mv	s3,s7
    80004f4a:	4481                	li	s1,0
    80004f4c:	b371                	j	80004cd8 <exec+0x132>

0000000080004f4e <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80004f4e:	7179                	addi	sp,sp,-48
    80004f50:	f406                	sd	ra,40(sp)
    80004f52:	f022                	sd	s0,32(sp)
    80004f54:	ec26                	sd	s1,24(sp)
    80004f56:	e84a                	sd	s2,16(sp)
    80004f58:	1800                	addi	s0,sp,48
    80004f5a:	892e                	mv	s2,a1
    80004f5c:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80004f5e:	fdc40593          	addi	a1,s0,-36
    80004f62:	ffffe097          	auipc	ra,0xffffe
    80004f66:	ba2080e7          	jalr	-1118(ra) # 80002b04 <argint>
    80004f6a:	04054063          	bltz	a0,80004faa <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80004f6e:	fdc42703          	lw	a4,-36(s0)
    80004f72:	47bd                	li	a5,15
    80004f74:	02e7ed63          	bltu	a5,a4,80004fae <argfd+0x60>
    80004f78:	ffffd097          	auipc	ra,0xffffd
    80004f7c:	a1e080e7          	jalr	-1506(ra) # 80001996 <myproc>
    80004f80:	fdc42703          	lw	a4,-36(s0)
    80004f84:	01c70793          	addi	a5,a4,28 # fffffffffffff01c <end+0xffffffff7ffd901c>
    80004f88:	078e                	slli	a5,a5,0x3
    80004f8a:	953e                	add	a0,a0,a5
    80004f8c:	611c                	ld	a5,0(a0)
    80004f8e:	c395                	beqz	a5,80004fb2 <argfd+0x64>
    return -1;
  if(pfd)
    80004f90:	00090463          	beqz	s2,80004f98 <argfd+0x4a>
    *pfd = fd;
    80004f94:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80004f98:	4501                	li	a0,0
  if(pf)
    80004f9a:	c091                	beqz	s1,80004f9e <argfd+0x50>
    *pf = f;
    80004f9c:	e09c                	sd	a5,0(s1)
}
    80004f9e:	70a2                	ld	ra,40(sp)
    80004fa0:	7402                	ld	s0,32(sp)
    80004fa2:	64e2                	ld	s1,24(sp)
    80004fa4:	6942                	ld	s2,16(sp)
    80004fa6:	6145                	addi	sp,sp,48
    80004fa8:	8082                	ret
    return -1;
    80004faa:	557d                	li	a0,-1
    80004fac:	bfcd                	j	80004f9e <argfd+0x50>
    return -1;
    80004fae:	557d                	li	a0,-1
    80004fb0:	b7fd                	j	80004f9e <argfd+0x50>
    80004fb2:	557d                	li	a0,-1
    80004fb4:	b7ed                	j	80004f9e <argfd+0x50>

0000000080004fb6 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80004fb6:	1101                	addi	sp,sp,-32
    80004fb8:	ec06                	sd	ra,24(sp)
    80004fba:	e822                	sd	s0,16(sp)
    80004fbc:	e426                	sd	s1,8(sp)
    80004fbe:	1000                	addi	s0,sp,32
    80004fc0:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80004fc2:	ffffd097          	auipc	ra,0xffffd
    80004fc6:	9d4080e7          	jalr	-1580(ra) # 80001996 <myproc>
    80004fca:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80004fcc:	0e050793          	addi	a5,a0,224
    80004fd0:	4501                	li	a0,0
    80004fd2:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80004fd4:	6398                	ld	a4,0(a5)
    80004fd6:	cb19                	beqz	a4,80004fec <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80004fd8:	2505                	addiw	a0,a0,1
    80004fda:	07a1                	addi	a5,a5,8
    80004fdc:	fed51ce3          	bne	a0,a3,80004fd4 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004fe0:	557d                	li	a0,-1
}
    80004fe2:	60e2                	ld	ra,24(sp)
    80004fe4:	6442                	ld	s0,16(sp)
    80004fe6:	64a2                	ld	s1,8(sp)
    80004fe8:	6105                	addi	sp,sp,32
    80004fea:	8082                	ret
      p->ofile[fd] = f;
    80004fec:	01c50793          	addi	a5,a0,28
    80004ff0:	078e                	slli	a5,a5,0x3
    80004ff2:	963e                	add	a2,a2,a5
    80004ff4:	e204                	sd	s1,0(a2)
      return fd;
    80004ff6:	b7f5                	j	80004fe2 <fdalloc+0x2c>

0000000080004ff8 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80004ff8:	715d                	addi	sp,sp,-80
    80004ffa:	e486                	sd	ra,72(sp)
    80004ffc:	e0a2                	sd	s0,64(sp)
    80004ffe:	fc26                	sd	s1,56(sp)
    80005000:	f84a                	sd	s2,48(sp)
    80005002:	f44e                	sd	s3,40(sp)
    80005004:	f052                	sd	s4,32(sp)
    80005006:	ec56                	sd	s5,24(sp)
    80005008:	0880                	addi	s0,sp,80
    8000500a:	89ae                	mv	s3,a1
    8000500c:	8ab2                	mv	s5,a2
    8000500e:	8a36                	mv	s4,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80005010:	fb040593          	addi	a1,s0,-80
    80005014:	fffff097          	auipc	ra,0xfffff
    80005018:	e74080e7          	jalr	-396(ra) # 80003e88 <nameiparent>
    8000501c:	892a                	mv	s2,a0
    8000501e:	12050e63          	beqz	a0,8000515a <create+0x162>
    return 0;

  ilock(dp);
    80005022:	ffffe097          	auipc	ra,0xffffe
    80005026:	68c080e7          	jalr	1676(ra) # 800036ae <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    8000502a:	4601                	li	a2,0
    8000502c:	fb040593          	addi	a1,s0,-80
    80005030:	854a                	mv	a0,s2
    80005032:	fffff097          	auipc	ra,0xfffff
    80005036:	b60080e7          	jalr	-1184(ra) # 80003b92 <dirlookup>
    8000503a:	84aa                	mv	s1,a0
    8000503c:	c921                	beqz	a0,8000508c <create+0x94>
    iunlockput(dp);
    8000503e:	854a                	mv	a0,s2
    80005040:	fffff097          	auipc	ra,0xfffff
    80005044:	8d0080e7          	jalr	-1840(ra) # 80003910 <iunlockput>
    ilock(ip);
    80005048:	8526                	mv	a0,s1
    8000504a:	ffffe097          	auipc	ra,0xffffe
    8000504e:	664080e7          	jalr	1636(ra) # 800036ae <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80005052:	2981                	sext.w	s3,s3
    80005054:	4789                	li	a5,2
    80005056:	02f99463          	bne	s3,a5,8000507e <create+0x86>
    8000505a:	0444d783          	lhu	a5,68(s1)
    8000505e:	37f9                	addiw	a5,a5,-2
    80005060:	17c2                	slli	a5,a5,0x30
    80005062:	93c1                	srli	a5,a5,0x30
    80005064:	4705                	li	a4,1
    80005066:	00f76c63          	bltu	a4,a5,8000507e <create+0x86>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    8000506a:	8526                	mv	a0,s1
    8000506c:	60a6                	ld	ra,72(sp)
    8000506e:	6406                	ld	s0,64(sp)
    80005070:	74e2                	ld	s1,56(sp)
    80005072:	7942                	ld	s2,48(sp)
    80005074:	79a2                	ld	s3,40(sp)
    80005076:	7a02                	ld	s4,32(sp)
    80005078:	6ae2                	ld	s5,24(sp)
    8000507a:	6161                	addi	sp,sp,80
    8000507c:	8082                	ret
    iunlockput(ip);
    8000507e:	8526                	mv	a0,s1
    80005080:	fffff097          	auipc	ra,0xfffff
    80005084:	890080e7          	jalr	-1904(ra) # 80003910 <iunlockput>
    return 0;
    80005088:	4481                	li	s1,0
    8000508a:	b7c5                	j	8000506a <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0)
    8000508c:	85ce                	mv	a1,s3
    8000508e:	00092503          	lw	a0,0(s2)
    80005092:	ffffe097          	auipc	ra,0xffffe
    80005096:	482080e7          	jalr	1154(ra) # 80003514 <ialloc>
    8000509a:	84aa                	mv	s1,a0
    8000509c:	c521                	beqz	a0,800050e4 <create+0xec>
  ilock(ip);
    8000509e:	ffffe097          	auipc	ra,0xffffe
    800050a2:	610080e7          	jalr	1552(ra) # 800036ae <ilock>
  ip->major = major;
    800050a6:	05549323          	sh	s5,70(s1)
  ip->minor = minor;
    800050aa:	05449423          	sh	s4,72(s1)
  ip->nlink = 1;
    800050ae:	4a05                	li	s4,1
    800050b0:	05449523          	sh	s4,74(s1)
  iupdate(ip);
    800050b4:	8526                	mv	a0,s1
    800050b6:	ffffe097          	auipc	ra,0xffffe
    800050ba:	52c080e7          	jalr	1324(ra) # 800035e2 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    800050be:	2981                	sext.w	s3,s3
    800050c0:	03498a63          	beq	s3,s4,800050f4 <create+0xfc>
  if(dirlink(dp, name, ip->inum) < 0)
    800050c4:	40d0                	lw	a2,4(s1)
    800050c6:	fb040593          	addi	a1,s0,-80
    800050ca:	854a                	mv	a0,s2
    800050cc:	fffff097          	auipc	ra,0xfffff
    800050d0:	cdc080e7          	jalr	-804(ra) # 80003da8 <dirlink>
    800050d4:	06054b63          	bltz	a0,8000514a <create+0x152>
  iunlockput(dp);
    800050d8:	854a                	mv	a0,s2
    800050da:	fffff097          	auipc	ra,0xfffff
    800050de:	836080e7          	jalr	-1994(ra) # 80003910 <iunlockput>
  return ip;
    800050e2:	b761                	j	8000506a <create+0x72>
    panic("create: ialloc");
    800050e4:	00003517          	auipc	a0,0x3
    800050e8:	60c50513          	addi	a0,a0,1548 # 800086f0 <syscalls+0x2a8>
    800050ec:	ffffb097          	auipc	ra,0xffffb
    800050f0:	44e080e7          	jalr	1102(ra) # 8000053a <panic>
    dp->nlink++;  // for ".."
    800050f4:	04a95783          	lhu	a5,74(s2)
    800050f8:	2785                	addiw	a5,a5,1
    800050fa:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    800050fe:	854a                	mv	a0,s2
    80005100:	ffffe097          	auipc	ra,0xffffe
    80005104:	4e2080e7          	jalr	1250(ra) # 800035e2 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80005108:	40d0                	lw	a2,4(s1)
    8000510a:	00003597          	auipc	a1,0x3
    8000510e:	5f658593          	addi	a1,a1,1526 # 80008700 <syscalls+0x2b8>
    80005112:	8526                	mv	a0,s1
    80005114:	fffff097          	auipc	ra,0xfffff
    80005118:	c94080e7          	jalr	-876(ra) # 80003da8 <dirlink>
    8000511c:	00054f63          	bltz	a0,8000513a <create+0x142>
    80005120:	00492603          	lw	a2,4(s2)
    80005124:	00003597          	auipc	a1,0x3
    80005128:	5e458593          	addi	a1,a1,1508 # 80008708 <syscalls+0x2c0>
    8000512c:	8526                	mv	a0,s1
    8000512e:	fffff097          	auipc	ra,0xfffff
    80005132:	c7a080e7          	jalr	-902(ra) # 80003da8 <dirlink>
    80005136:	f80557e3          	bgez	a0,800050c4 <create+0xcc>
      panic("create dots");
    8000513a:	00003517          	auipc	a0,0x3
    8000513e:	5d650513          	addi	a0,a0,1494 # 80008710 <syscalls+0x2c8>
    80005142:	ffffb097          	auipc	ra,0xffffb
    80005146:	3f8080e7          	jalr	1016(ra) # 8000053a <panic>
    panic("create: dirlink");
    8000514a:	00003517          	auipc	a0,0x3
    8000514e:	5d650513          	addi	a0,a0,1494 # 80008720 <syscalls+0x2d8>
    80005152:	ffffb097          	auipc	ra,0xffffb
    80005156:	3e8080e7          	jalr	1000(ra) # 8000053a <panic>
    return 0;
    8000515a:	84aa                	mv	s1,a0
    8000515c:	b739                	j	8000506a <create+0x72>

000000008000515e <sys_dup>:
{
    8000515e:	7179                	addi	sp,sp,-48
    80005160:	f406                	sd	ra,40(sp)
    80005162:	f022                	sd	s0,32(sp)
    80005164:	ec26                	sd	s1,24(sp)
    80005166:	e84a                	sd	s2,16(sp)
    80005168:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    8000516a:	fd840613          	addi	a2,s0,-40
    8000516e:	4581                	li	a1,0
    80005170:	4501                	li	a0,0
    80005172:	00000097          	auipc	ra,0x0
    80005176:	ddc080e7          	jalr	-548(ra) # 80004f4e <argfd>
    return -1;
    8000517a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    8000517c:	02054363          	bltz	a0,800051a2 <sys_dup+0x44>
  if((fd=fdalloc(f)) < 0)
    80005180:	fd843903          	ld	s2,-40(s0)
    80005184:	854a                	mv	a0,s2
    80005186:	00000097          	auipc	ra,0x0
    8000518a:	e30080e7          	jalr	-464(ra) # 80004fb6 <fdalloc>
    8000518e:	84aa                	mv	s1,a0
    return -1;
    80005190:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80005192:	00054863          	bltz	a0,800051a2 <sys_dup+0x44>
  filedup(f);
    80005196:	854a                	mv	a0,s2
    80005198:	fffff097          	auipc	ra,0xfffff
    8000519c:	368080e7          	jalr	872(ra) # 80004500 <filedup>
  return fd;
    800051a0:	87a6                	mv	a5,s1
}
    800051a2:	853e                	mv	a0,a5
    800051a4:	70a2                	ld	ra,40(sp)
    800051a6:	7402                	ld	s0,32(sp)
    800051a8:	64e2                	ld	s1,24(sp)
    800051aa:	6942                	ld	s2,16(sp)
    800051ac:	6145                	addi	sp,sp,48
    800051ae:	8082                	ret

00000000800051b0 <sys_read>:
{
    800051b0:	7179                	addi	sp,sp,-48
    800051b2:	f406                	sd	ra,40(sp)
    800051b4:	f022                	sd	s0,32(sp)
    800051b6:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800051b8:	fe840613          	addi	a2,s0,-24
    800051bc:	4581                	li	a1,0
    800051be:	4501                	li	a0,0
    800051c0:	00000097          	auipc	ra,0x0
    800051c4:	d8e080e7          	jalr	-626(ra) # 80004f4e <argfd>
    return -1;
    800051c8:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800051ca:	04054163          	bltz	a0,8000520c <sys_read+0x5c>
    800051ce:	fe440593          	addi	a1,s0,-28
    800051d2:	4509                	li	a0,2
    800051d4:	ffffe097          	auipc	ra,0xffffe
    800051d8:	930080e7          	jalr	-1744(ra) # 80002b04 <argint>
    return -1;
    800051dc:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800051de:	02054763          	bltz	a0,8000520c <sys_read+0x5c>
    800051e2:	fd840593          	addi	a1,s0,-40
    800051e6:	4505                	li	a0,1
    800051e8:	ffffe097          	auipc	ra,0xffffe
    800051ec:	93e080e7          	jalr	-1730(ra) # 80002b26 <argaddr>
    return -1;
    800051f0:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800051f2:	00054d63          	bltz	a0,8000520c <sys_read+0x5c>
  return fileread(f, p, n);
    800051f6:	fe442603          	lw	a2,-28(s0)
    800051fa:	fd843583          	ld	a1,-40(s0)
    800051fe:	fe843503          	ld	a0,-24(s0)
    80005202:	fffff097          	auipc	ra,0xfffff
    80005206:	48a080e7          	jalr	1162(ra) # 8000468c <fileread>
    8000520a:	87aa                	mv	a5,a0
}
    8000520c:	853e                	mv	a0,a5
    8000520e:	70a2                	ld	ra,40(sp)
    80005210:	7402                	ld	s0,32(sp)
    80005212:	6145                	addi	sp,sp,48
    80005214:	8082                	ret

0000000080005216 <sys_write>:
{
    80005216:	7179                	addi	sp,sp,-48
    80005218:	f406                	sd	ra,40(sp)
    8000521a:	f022                	sd	s0,32(sp)
    8000521c:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000521e:	fe840613          	addi	a2,s0,-24
    80005222:	4581                	li	a1,0
    80005224:	4501                	li	a0,0
    80005226:	00000097          	auipc	ra,0x0
    8000522a:	d28080e7          	jalr	-728(ra) # 80004f4e <argfd>
    return -1;
    8000522e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005230:	04054163          	bltz	a0,80005272 <sys_write+0x5c>
    80005234:	fe440593          	addi	a1,s0,-28
    80005238:	4509                	li	a0,2
    8000523a:	ffffe097          	auipc	ra,0xffffe
    8000523e:	8ca080e7          	jalr	-1846(ra) # 80002b04 <argint>
    return -1;
    80005242:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005244:	02054763          	bltz	a0,80005272 <sys_write+0x5c>
    80005248:	fd840593          	addi	a1,s0,-40
    8000524c:	4505                	li	a0,1
    8000524e:	ffffe097          	auipc	ra,0xffffe
    80005252:	8d8080e7          	jalr	-1832(ra) # 80002b26 <argaddr>
    return -1;
    80005256:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005258:	00054d63          	bltz	a0,80005272 <sys_write+0x5c>
  return filewrite(f, p, n);
    8000525c:	fe442603          	lw	a2,-28(s0)
    80005260:	fd843583          	ld	a1,-40(s0)
    80005264:	fe843503          	ld	a0,-24(s0)
    80005268:	fffff097          	auipc	ra,0xfffff
    8000526c:	4e6080e7          	jalr	1254(ra) # 8000474e <filewrite>
    80005270:	87aa                	mv	a5,a0
}
    80005272:	853e                	mv	a0,a5
    80005274:	70a2                	ld	ra,40(sp)
    80005276:	7402                	ld	s0,32(sp)
    80005278:	6145                	addi	sp,sp,48
    8000527a:	8082                	ret

000000008000527c <sys_close>:
{
    8000527c:	1101                	addi	sp,sp,-32
    8000527e:	ec06                	sd	ra,24(sp)
    80005280:	e822                	sd	s0,16(sp)
    80005282:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80005284:	fe040613          	addi	a2,s0,-32
    80005288:	fec40593          	addi	a1,s0,-20
    8000528c:	4501                	li	a0,0
    8000528e:	00000097          	auipc	ra,0x0
    80005292:	cc0080e7          	jalr	-832(ra) # 80004f4e <argfd>
    return -1;
    80005296:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80005298:	02054463          	bltz	a0,800052c0 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    8000529c:	ffffc097          	auipc	ra,0xffffc
    800052a0:	6fa080e7          	jalr	1786(ra) # 80001996 <myproc>
    800052a4:	fec42783          	lw	a5,-20(s0)
    800052a8:	07f1                	addi	a5,a5,28
    800052aa:	078e                	slli	a5,a5,0x3
    800052ac:	953e                	add	a0,a0,a5
    800052ae:	00053023          	sd	zero,0(a0)
  fileclose(f);
    800052b2:	fe043503          	ld	a0,-32(s0)
    800052b6:	fffff097          	auipc	ra,0xfffff
    800052ba:	29c080e7          	jalr	668(ra) # 80004552 <fileclose>
  return 0;
    800052be:	4781                	li	a5,0
}
    800052c0:	853e                	mv	a0,a5
    800052c2:	60e2                	ld	ra,24(sp)
    800052c4:	6442                	ld	s0,16(sp)
    800052c6:	6105                	addi	sp,sp,32
    800052c8:	8082                	ret

00000000800052ca <sys_fstat>:
{
    800052ca:	1101                	addi	sp,sp,-32
    800052cc:	ec06                	sd	ra,24(sp)
    800052ce:	e822                	sd	s0,16(sp)
    800052d0:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800052d2:	fe840613          	addi	a2,s0,-24
    800052d6:	4581                	li	a1,0
    800052d8:	4501                	li	a0,0
    800052da:	00000097          	auipc	ra,0x0
    800052de:	c74080e7          	jalr	-908(ra) # 80004f4e <argfd>
    return -1;
    800052e2:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800052e4:	02054563          	bltz	a0,8000530e <sys_fstat+0x44>
    800052e8:	fe040593          	addi	a1,s0,-32
    800052ec:	4505                	li	a0,1
    800052ee:	ffffe097          	auipc	ra,0xffffe
    800052f2:	838080e7          	jalr	-1992(ra) # 80002b26 <argaddr>
    return -1;
    800052f6:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800052f8:	00054b63          	bltz	a0,8000530e <sys_fstat+0x44>
  return filestat(f, st);
    800052fc:	fe043583          	ld	a1,-32(s0)
    80005300:	fe843503          	ld	a0,-24(s0)
    80005304:	fffff097          	auipc	ra,0xfffff
    80005308:	316080e7          	jalr	790(ra) # 8000461a <filestat>
    8000530c:	87aa                	mv	a5,a0
}
    8000530e:	853e                	mv	a0,a5
    80005310:	60e2                	ld	ra,24(sp)
    80005312:	6442                	ld	s0,16(sp)
    80005314:	6105                	addi	sp,sp,32
    80005316:	8082                	ret

0000000080005318 <sys_link>:
{
    80005318:	7169                	addi	sp,sp,-304
    8000531a:	f606                	sd	ra,296(sp)
    8000531c:	f222                	sd	s0,288(sp)
    8000531e:	ee26                	sd	s1,280(sp)
    80005320:	ea4a                	sd	s2,272(sp)
    80005322:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80005324:	08000613          	li	a2,128
    80005328:	ed040593          	addi	a1,s0,-304
    8000532c:	4501                	li	a0,0
    8000532e:	ffffe097          	auipc	ra,0xffffe
    80005332:	81a080e7          	jalr	-2022(ra) # 80002b48 <argstr>
    return -1;
    80005336:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80005338:	10054e63          	bltz	a0,80005454 <sys_link+0x13c>
    8000533c:	08000613          	li	a2,128
    80005340:	f5040593          	addi	a1,s0,-176
    80005344:	4505                	li	a0,1
    80005346:	ffffe097          	auipc	ra,0xffffe
    8000534a:	802080e7          	jalr	-2046(ra) # 80002b48 <argstr>
    return -1;
    8000534e:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80005350:	10054263          	bltz	a0,80005454 <sys_link+0x13c>
  begin_op();
    80005354:	fffff097          	auipc	ra,0xfffff
    80005358:	d36080e7          	jalr	-714(ra) # 8000408a <begin_op>
  if((ip = namei(old)) == 0){
    8000535c:	ed040513          	addi	a0,s0,-304
    80005360:	fffff097          	auipc	ra,0xfffff
    80005364:	b0a080e7          	jalr	-1270(ra) # 80003e6a <namei>
    80005368:	84aa                	mv	s1,a0
    8000536a:	c551                	beqz	a0,800053f6 <sys_link+0xde>
  ilock(ip);
    8000536c:	ffffe097          	auipc	ra,0xffffe
    80005370:	342080e7          	jalr	834(ra) # 800036ae <ilock>
  if(ip->type == T_DIR){
    80005374:	04449703          	lh	a4,68(s1)
    80005378:	4785                	li	a5,1
    8000537a:	08f70463          	beq	a4,a5,80005402 <sys_link+0xea>
  ip->nlink++;
    8000537e:	04a4d783          	lhu	a5,74(s1)
    80005382:	2785                	addiw	a5,a5,1
    80005384:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80005388:	8526                	mv	a0,s1
    8000538a:	ffffe097          	auipc	ra,0xffffe
    8000538e:	258080e7          	jalr	600(ra) # 800035e2 <iupdate>
  iunlock(ip);
    80005392:	8526                	mv	a0,s1
    80005394:	ffffe097          	auipc	ra,0xffffe
    80005398:	3dc080e7          	jalr	988(ra) # 80003770 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    8000539c:	fd040593          	addi	a1,s0,-48
    800053a0:	f5040513          	addi	a0,s0,-176
    800053a4:	fffff097          	auipc	ra,0xfffff
    800053a8:	ae4080e7          	jalr	-1308(ra) # 80003e88 <nameiparent>
    800053ac:	892a                	mv	s2,a0
    800053ae:	c935                	beqz	a0,80005422 <sys_link+0x10a>
  ilock(dp);
    800053b0:	ffffe097          	auipc	ra,0xffffe
    800053b4:	2fe080e7          	jalr	766(ra) # 800036ae <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    800053b8:	00092703          	lw	a4,0(s2)
    800053bc:	409c                	lw	a5,0(s1)
    800053be:	04f71d63          	bne	a4,a5,80005418 <sys_link+0x100>
    800053c2:	40d0                	lw	a2,4(s1)
    800053c4:	fd040593          	addi	a1,s0,-48
    800053c8:	854a                	mv	a0,s2
    800053ca:	fffff097          	auipc	ra,0xfffff
    800053ce:	9de080e7          	jalr	-1570(ra) # 80003da8 <dirlink>
    800053d2:	04054363          	bltz	a0,80005418 <sys_link+0x100>
  iunlockput(dp);
    800053d6:	854a                	mv	a0,s2
    800053d8:	ffffe097          	auipc	ra,0xffffe
    800053dc:	538080e7          	jalr	1336(ra) # 80003910 <iunlockput>
  iput(ip);
    800053e0:	8526                	mv	a0,s1
    800053e2:	ffffe097          	auipc	ra,0xffffe
    800053e6:	486080e7          	jalr	1158(ra) # 80003868 <iput>
  end_op();
    800053ea:	fffff097          	auipc	ra,0xfffff
    800053ee:	d1e080e7          	jalr	-738(ra) # 80004108 <end_op>
  return 0;
    800053f2:	4781                	li	a5,0
    800053f4:	a085                	j	80005454 <sys_link+0x13c>
    end_op();
    800053f6:	fffff097          	auipc	ra,0xfffff
    800053fa:	d12080e7          	jalr	-750(ra) # 80004108 <end_op>
    return -1;
    800053fe:	57fd                	li	a5,-1
    80005400:	a891                	j	80005454 <sys_link+0x13c>
    iunlockput(ip);
    80005402:	8526                	mv	a0,s1
    80005404:	ffffe097          	auipc	ra,0xffffe
    80005408:	50c080e7          	jalr	1292(ra) # 80003910 <iunlockput>
    end_op();
    8000540c:	fffff097          	auipc	ra,0xfffff
    80005410:	cfc080e7          	jalr	-772(ra) # 80004108 <end_op>
    return -1;
    80005414:	57fd                	li	a5,-1
    80005416:	a83d                	j	80005454 <sys_link+0x13c>
    iunlockput(dp);
    80005418:	854a                	mv	a0,s2
    8000541a:	ffffe097          	auipc	ra,0xffffe
    8000541e:	4f6080e7          	jalr	1270(ra) # 80003910 <iunlockput>
  ilock(ip);
    80005422:	8526                	mv	a0,s1
    80005424:	ffffe097          	auipc	ra,0xffffe
    80005428:	28a080e7          	jalr	650(ra) # 800036ae <ilock>
  ip->nlink--;
    8000542c:	04a4d783          	lhu	a5,74(s1)
    80005430:	37fd                	addiw	a5,a5,-1
    80005432:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80005436:	8526                	mv	a0,s1
    80005438:	ffffe097          	auipc	ra,0xffffe
    8000543c:	1aa080e7          	jalr	426(ra) # 800035e2 <iupdate>
  iunlockput(ip);
    80005440:	8526                	mv	a0,s1
    80005442:	ffffe097          	auipc	ra,0xffffe
    80005446:	4ce080e7          	jalr	1230(ra) # 80003910 <iunlockput>
  end_op();
    8000544a:	fffff097          	auipc	ra,0xfffff
    8000544e:	cbe080e7          	jalr	-834(ra) # 80004108 <end_op>
  return -1;
    80005452:	57fd                	li	a5,-1
}
    80005454:	853e                	mv	a0,a5
    80005456:	70b2                	ld	ra,296(sp)
    80005458:	7412                	ld	s0,288(sp)
    8000545a:	64f2                	ld	s1,280(sp)
    8000545c:	6952                	ld	s2,272(sp)
    8000545e:	6155                	addi	sp,sp,304
    80005460:	8082                	ret

0000000080005462 <sys_unlink>:
{
    80005462:	7151                	addi	sp,sp,-240
    80005464:	f586                	sd	ra,232(sp)
    80005466:	f1a2                	sd	s0,224(sp)
    80005468:	eda6                	sd	s1,216(sp)
    8000546a:	e9ca                	sd	s2,208(sp)
    8000546c:	e5ce                	sd	s3,200(sp)
    8000546e:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80005470:	08000613          	li	a2,128
    80005474:	f3040593          	addi	a1,s0,-208
    80005478:	4501                	li	a0,0
    8000547a:	ffffd097          	auipc	ra,0xffffd
    8000547e:	6ce080e7          	jalr	1742(ra) # 80002b48 <argstr>
    80005482:	18054163          	bltz	a0,80005604 <sys_unlink+0x1a2>
  begin_op();
    80005486:	fffff097          	auipc	ra,0xfffff
    8000548a:	c04080e7          	jalr	-1020(ra) # 8000408a <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    8000548e:	fb040593          	addi	a1,s0,-80
    80005492:	f3040513          	addi	a0,s0,-208
    80005496:	fffff097          	auipc	ra,0xfffff
    8000549a:	9f2080e7          	jalr	-1550(ra) # 80003e88 <nameiparent>
    8000549e:	84aa                	mv	s1,a0
    800054a0:	c979                	beqz	a0,80005576 <sys_unlink+0x114>
  ilock(dp);
    800054a2:	ffffe097          	auipc	ra,0xffffe
    800054a6:	20c080e7          	jalr	524(ra) # 800036ae <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    800054aa:	00003597          	auipc	a1,0x3
    800054ae:	25658593          	addi	a1,a1,598 # 80008700 <syscalls+0x2b8>
    800054b2:	fb040513          	addi	a0,s0,-80
    800054b6:	ffffe097          	auipc	ra,0xffffe
    800054ba:	6c2080e7          	jalr	1730(ra) # 80003b78 <namecmp>
    800054be:	14050a63          	beqz	a0,80005612 <sys_unlink+0x1b0>
    800054c2:	00003597          	auipc	a1,0x3
    800054c6:	24658593          	addi	a1,a1,582 # 80008708 <syscalls+0x2c0>
    800054ca:	fb040513          	addi	a0,s0,-80
    800054ce:	ffffe097          	auipc	ra,0xffffe
    800054d2:	6aa080e7          	jalr	1706(ra) # 80003b78 <namecmp>
    800054d6:	12050e63          	beqz	a0,80005612 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    800054da:	f2c40613          	addi	a2,s0,-212
    800054de:	fb040593          	addi	a1,s0,-80
    800054e2:	8526                	mv	a0,s1
    800054e4:	ffffe097          	auipc	ra,0xffffe
    800054e8:	6ae080e7          	jalr	1710(ra) # 80003b92 <dirlookup>
    800054ec:	892a                	mv	s2,a0
    800054ee:	12050263          	beqz	a0,80005612 <sys_unlink+0x1b0>
  ilock(ip);
    800054f2:	ffffe097          	auipc	ra,0xffffe
    800054f6:	1bc080e7          	jalr	444(ra) # 800036ae <ilock>
  if(ip->nlink < 1)
    800054fa:	04a91783          	lh	a5,74(s2)
    800054fe:	08f05263          	blez	a5,80005582 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80005502:	04491703          	lh	a4,68(s2)
    80005506:	4785                	li	a5,1
    80005508:	08f70563          	beq	a4,a5,80005592 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    8000550c:	4641                	li	a2,16
    8000550e:	4581                	li	a1,0
    80005510:	fc040513          	addi	a0,s0,-64
    80005514:	ffffb097          	auipc	ra,0xffffb
    80005518:	7b8080e7          	jalr	1976(ra) # 80000ccc <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000551c:	4741                	li	a4,16
    8000551e:	f2c42683          	lw	a3,-212(s0)
    80005522:	fc040613          	addi	a2,s0,-64
    80005526:	4581                	li	a1,0
    80005528:	8526                	mv	a0,s1
    8000552a:	ffffe097          	auipc	ra,0xffffe
    8000552e:	530080e7          	jalr	1328(ra) # 80003a5a <writei>
    80005532:	47c1                	li	a5,16
    80005534:	0af51563          	bne	a0,a5,800055de <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    80005538:	04491703          	lh	a4,68(s2)
    8000553c:	4785                	li	a5,1
    8000553e:	0af70863          	beq	a4,a5,800055ee <sys_unlink+0x18c>
  iunlockput(dp);
    80005542:	8526                	mv	a0,s1
    80005544:	ffffe097          	auipc	ra,0xffffe
    80005548:	3cc080e7          	jalr	972(ra) # 80003910 <iunlockput>
  ip->nlink--;
    8000554c:	04a95783          	lhu	a5,74(s2)
    80005550:	37fd                	addiw	a5,a5,-1
    80005552:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80005556:	854a                	mv	a0,s2
    80005558:	ffffe097          	auipc	ra,0xffffe
    8000555c:	08a080e7          	jalr	138(ra) # 800035e2 <iupdate>
  iunlockput(ip);
    80005560:	854a                	mv	a0,s2
    80005562:	ffffe097          	auipc	ra,0xffffe
    80005566:	3ae080e7          	jalr	942(ra) # 80003910 <iunlockput>
  end_op();
    8000556a:	fffff097          	auipc	ra,0xfffff
    8000556e:	b9e080e7          	jalr	-1122(ra) # 80004108 <end_op>
  return 0;
    80005572:	4501                	li	a0,0
    80005574:	a84d                	j	80005626 <sys_unlink+0x1c4>
    end_op();
    80005576:	fffff097          	auipc	ra,0xfffff
    8000557a:	b92080e7          	jalr	-1134(ra) # 80004108 <end_op>
    return -1;
    8000557e:	557d                	li	a0,-1
    80005580:	a05d                	j	80005626 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80005582:	00003517          	auipc	a0,0x3
    80005586:	1ae50513          	addi	a0,a0,430 # 80008730 <syscalls+0x2e8>
    8000558a:	ffffb097          	auipc	ra,0xffffb
    8000558e:	fb0080e7          	jalr	-80(ra) # 8000053a <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005592:	04c92703          	lw	a4,76(s2)
    80005596:	02000793          	li	a5,32
    8000559a:	f6e7f9e3          	bgeu	a5,a4,8000550c <sys_unlink+0xaa>
    8000559e:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800055a2:	4741                	li	a4,16
    800055a4:	86ce                	mv	a3,s3
    800055a6:	f1840613          	addi	a2,s0,-232
    800055aa:	4581                	li	a1,0
    800055ac:	854a                	mv	a0,s2
    800055ae:	ffffe097          	auipc	ra,0xffffe
    800055b2:	3b4080e7          	jalr	948(ra) # 80003962 <readi>
    800055b6:	47c1                	li	a5,16
    800055b8:	00f51b63          	bne	a0,a5,800055ce <sys_unlink+0x16c>
    if(de.inum != 0)
    800055bc:	f1845783          	lhu	a5,-232(s0)
    800055c0:	e7a1                	bnez	a5,80005608 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800055c2:	29c1                	addiw	s3,s3,16
    800055c4:	04c92783          	lw	a5,76(s2)
    800055c8:	fcf9ede3          	bltu	s3,a5,800055a2 <sys_unlink+0x140>
    800055cc:	b781                	j	8000550c <sys_unlink+0xaa>
      panic("isdirempty: readi");
    800055ce:	00003517          	auipc	a0,0x3
    800055d2:	17a50513          	addi	a0,a0,378 # 80008748 <syscalls+0x300>
    800055d6:	ffffb097          	auipc	ra,0xffffb
    800055da:	f64080e7          	jalr	-156(ra) # 8000053a <panic>
    panic("unlink: writei");
    800055de:	00003517          	auipc	a0,0x3
    800055e2:	18250513          	addi	a0,a0,386 # 80008760 <syscalls+0x318>
    800055e6:	ffffb097          	auipc	ra,0xffffb
    800055ea:	f54080e7          	jalr	-172(ra) # 8000053a <panic>
    dp->nlink--;
    800055ee:	04a4d783          	lhu	a5,74(s1)
    800055f2:	37fd                	addiw	a5,a5,-1
    800055f4:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    800055f8:	8526                	mv	a0,s1
    800055fa:	ffffe097          	auipc	ra,0xffffe
    800055fe:	fe8080e7          	jalr	-24(ra) # 800035e2 <iupdate>
    80005602:	b781                	j	80005542 <sys_unlink+0xe0>
    return -1;
    80005604:	557d                	li	a0,-1
    80005606:	a005                	j	80005626 <sys_unlink+0x1c4>
    iunlockput(ip);
    80005608:	854a                	mv	a0,s2
    8000560a:	ffffe097          	auipc	ra,0xffffe
    8000560e:	306080e7          	jalr	774(ra) # 80003910 <iunlockput>
  iunlockput(dp);
    80005612:	8526                	mv	a0,s1
    80005614:	ffffe097          	auipc	ra,0xffffe
    80005618:	2fc080e7          	jalr	764(ra) # 80003910 <iunlockput>
  end_op();
    8000561c:	fffff097          	auipc	ra,0xfffff
    80005620:	aec080e7          	jalr	-1300(ra) # 80004108 <end_op>
  return -1;
    80005624:	557d                	li	a0,-1
}
    80005626:	70ae                	ld	ra,232(sp)
    80005628:	740e                	ld	s0,224(sp)
    8000562a:	64ee                	ld	s1,216(sp)
    8000562c:	694e                	ld	s2,208(sp)
    8000562e:	69ae                	ld	s3,200(sp)
    80005630:	616d                	addi	sp,sp,240
    80005632:	8082                	ret

0000000080005634 <sys_open>:

uint64
sys_open(void)
{
    80005634:	7131                	addi	sp,sp,-192
    80005636:	fd06                	sd	ra,184(sp)
    80005638:	f922                	sd	s0,176(sp)
    8000563a:	f526                	sd	s1,168(sp)
    8000563c:	f14a                	sd	s2,160(sp)
    8000563e:	ed4e                	sd	s3,152(sp)
    80005640:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80005642:	08000613          	li	a2,128
    80005646:	f5040593          	addi	a1,s0,-176
    8000564a:	4501                	li	a0,0
    8000564c:	ffffd097          	auipc	ra,0xffffd
    80005650:	4fc080e7          	jalr	1276(ra) # 80002b48 <argstr>
    return -1;
    80005654:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80005656:	0c054163          	bltz	a0,80005718 <sys_open+0xe4>
    8000565a:	f4c40593          	addi	a1,s0,-180
    8000565e:	4505                	li	a0,1
    80005660:	ffffd097          	auipc	ra,0xffffd
    80005664:	4a4080e7          	jalr	1188(ra) # 80002b04 <argint>
    80005668:	0a054863          	bltz	a0,80005718 <sys_open+0xe4>

  begin_op();
    8000566c:	fffff097          	auipc	ra,0xfffff
    80005670:	a1e080e7          	jalr	-1506(ra) # 8000408a <begin_op>

  if(omode & O_CREATE){
    80005674:	f4c42783          	lw	a5,-180(s0)
    80005678:	2007f793          	andi	a5,a5,512
    8000567c:	cbdd                	beqz	a5,80005732 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    8000567e:	4681                	li	a3,0
    80005680:	4601                	li	a2,0
    80005682:	4589                	li	a1,2
    80005684:	f5040513          	addi	a0,s0,-176
    80005688:	00000097          	auipc	ra,0x0
    8000568c:	970080e7          	jalr	-1680(ra) # 80004ff8 <create>
    80005690:	892a                	mv	s2,a0
    if(ip == 0){
    80005692:	c959                	beqz	a0,80005728 <sys_open+0xf4>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80005694:	04491703          	lh	a4,68(s2)
    80005698:	478d                	li	a5,3
    8000569a:	00f71763          	bne	a4,a5,800056a8 <sys_open+0x74>
    8000569e:	04695703          	lhu	a4,70(s2)
    800056a2:	47a5                	li	a5,9
    800056a4:	0ce7ec63          	bltu	a5,a4,8000577c <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    800056a8:	fffff097          	auipc	ra,0xfffff
    800056ac:	dee080e7          	jalr	-530(ra) # 80004496 <filealloc>
    800056b0:	89aa                	mv	s3,a0
    800056b2:	10050263          	beqz	a0,800057b6 <sys_open+0x182>
    800056b6:	00000097          	auipc	ra,0x0
    800056ba:	900080e7          	jalr	-1792(ra) # 80004fb6 <fdalloc>
    800056be:	84aa                	mv	s1,a0
    800056c0:	0e054663          	bltz	a0,800057ac <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    800056c4:	04491703          	lh	a4,68(s2)
    800056c8:	478d                	li	a5,3
    800056ca:	0cf70463          	beq	a4,a5,80005792 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    800056ce:	4789                	li	a5,2
    800056d0:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    800056d4:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    800056d8:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    800056dc:	f4c42783          	lw	a5,-180(s0)
    800056e0:	0017c713          	xori	a4,a5,1
    800056e4:	8b05                	andi	a4,a4,1
    800056e6:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    800056ea:	0037f713          	andi	a4,a5,3
    800056ee:	00e03733          	snez	a4,a4
    800056f2:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    800056f6:	4007f793          	andi	a5,a5,1024
    800056fa:	c791                	beqz	a5,80005706 <sys_open+0xd2>
    800056fc:	04491703          	lh	a4,68(s2)
    80005700:	4789                	li	a5,2
    80005702:	08f70f63          	beq	a4,a5,800057a0 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80005706:	854a                	mv	a0,s2
    80005708:	ffffe097          	auipc	ra,0xffffe
    8000570c:	068080e7          	jalr	104(ra) # 80003770 <iunlock>
  end_op();
    80005710:	fffff097          	auipc	ra,0xfffff
    80005714:	9f8080e7          	jalr	-1544(ra) # 80004108 <end_op>

  return fd;
}
    80005718:	8526                	mv	a0,s1
    8000571a:	70ea                	ld	ra,184(sp)
    8000571c:	744a                	ld	s0,176(sp)
    8000571e:	74aa                	ld	s1,168(sp)
    80005720:	790a                	ld	s2,160(sp)
    80005722:	69ea                	ld	s3,152(sp)
    80005724:	6129                	addi	sp,sp,192
    80005726:	8082                	ret
      end_op();
    80005728:	fffff097          	auipc	ra,0xfffff
    8000572c:	9e0080e7          	jalr	-1568(ra) # 80004108 <end_op>
      return -1;
    80005730:	b7e5                	j	80005718 <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80005732:	f5040513          	addi	a0,s0,-176
    80005736:	ffffe097          	auipc	ra,0xffffe
    8000573a:	734080e7          	jalr	1844(ra) # 80003e6a <namei>
    8000573e:	892a                	mv	s2,a0
    80005740:	c905                	beqz	a0,80005770 <sys_open+0x13c>
    ilock(ip);
    80005742:	ffffe097          	auipc	ra,0xffffe
    80005746:	f6c080e7          	jalr	-148(ra) # 800036ae <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    8000574a:	04491703          	lh	a4,68(s2)
    8000574e:	4785                	li	a5,1
    80005750:	f4f712e3          	bne	a4,a5,80005694 <sys_open+0x60>
    80005754:	f4c42783          	lw	a5,-180(s0)
    80005758:	dba1                	beqz	a5,800056a8 <sys_open+0x74>
      iunlockput(ip);
    8000575a:	854a                	mv	a0,s2
    8000575c:	ffffe097          	auipc	ra,0xffffe
    80005760:	1b4080e7          	jalr	436(ra) # 80003910 <iunlockput>
      end_op();
    80005764:	fffff097          	auipc	ra,0xfffff
    80005768:	9a4080e7          	jalr	-1628(ra) # 80004108 <end_op>
      return -1;
    8000576c:	54fd                	li	s1,-1
    8000576e:	b76d                	j	80005718 <sys_open+0xe4>
      end_op();
    80005770:	fffff097          	auipc	ra,0xfffff
    80005774:	998080e7          	jalr	-1640(ra) # 80004108 <end_op>
      return -1;
    80005778:	54fd                	li	s1,-1
    8000577a:	bf79                	j	80005718 <sys_open+0xe4>
    iunlockput(ip);
    8000577c:	854a                	mv	a0,s2
    8000577e:	ffffe097          	auipc	ra,0xffffe
    80005782:	192080e7          	jalr	402(ra) # 80003910 <iunlockput>
    end_op();
    80005786:	fffff097          	auipc	ra,0xfffff
    8000578a:	982080e7          	jalr	-1662(ra) # 80004108 <end_op>
    return -1;
    8000578e:	54fd                	li	s1,-1
    80005790:	b761                	j	80005718 <sys_open+0xe4>
    f->type = FD_DEVICE;
    80005792:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80005796:	04691783          	lh	a5,70(s2)
    8000579a:	02f99223          	sh	a5,36(s3)
    8000579e:	bf2d                	j	800056d8 <sys_open+0xa4>
    itrunc(ip);
    800057a0:	854a                	mv	a0,s2
    800057a2:	ffffe097          	auipc	ra,0xffffe
    800057a6:	01a080e7          	jalr	26(ra) # 800037bc <itrunc>
    800057aa:	bfb1                	j	80005706 <sys_open+0xd2>
      fileclose(f);
    800057ac:	854e                	mv	a0,s3
    800057ae:	fffff097          	auipc	ra,0xfffff
    800057b2:	da4080e7          	jalr	-604(ra) # 80004552 <fileclose>
    iunlockput(ip);
    800057b6:	854a                	mv	a0,s2
    800057b8:	ffffe097          	auipc	ra,0xffffe
    800057bc:	158080e7          	jalr	344(ra) # 80003910 <iunlockput>
    end_op();
    800057c0:	fffff097          	auipc	ra,0xfffff
    800057c4:	948080e7          	jalr	-1720(ra) # 80004108 <end_op>
    return -1;
    800057c8:	54fd                	li	s1,-1
    800057ca:	b7b9                	j	80005718 <sys_open+0xe4>

00000000800057cc <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800057cc:	7175                	addi	sp,sp,-144
    800057ce:	e506                	sd	ra,136(sp)
    800057d0:	e122                	sd	s0,128(sp)
    800057d2:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    800057d4:	fffff097          	auipc	ra,0xfffff
    800057d8:	8b6080e7          	jalr	-1866(ra) # 8000408a <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    800057dc:	08000613          	li	a2,128
    800057e0:	f7040593          	addi	a1,s0,-144
    800057e4:	4501                	li	a0,0
    800057e6:	ffffd097          	auipc	ra,0xffffd
    800057ea:	362080e7          	jalr	866(ra) # 80002b48 <argstr>
    800057ee:	02054963          	bltz	a0,80005820 <sys_mkdir+0x54>
    800057f2:	4681                	li	a3,0
    800057f4:	4601                	li	a2,0
    800057f6:	4585                	li	a1,1
    800057f8:	f7040513          	addi	a0,s0,-144
    800057fc:	fffff097          	auipc	ra,0xfffff
    80005800:	7fc080e7          	jalr	2044(ra) # 80004ff8 <create>
    80005804:	cd11                	beqz	a0,80005820 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005806:	ffffe097          	auipc	ra,0xffffe
    8000580a:	10a080e7          	jalr	266(ra) # 80003910 <iunlockput>
  end_op();
    8000580e:	fffff097          	auipc	ra,0xfffff
    80005812:	8fa080e7          	jalr	-1798(ra) # 80004108 <end_op>
  return 0;
    80005816:	4501                	li	a0,0
}
    80005818:	60aa                	ld	ra,136(sp)
    8000581a:	640a                	ld	s0,128(sp)
    8000581c:	6149                	addi	sp,sp,144
    8000581e:	8082                	ret
    end_op();
    80005820:	fffff097          	auipc	ra,0xfffff
    80005824:	8e8080e7          	jalr	-1816(ra) # 80004108 <end_op>
    return -1;
    80005828:	557d                	li	a0,-1
    8000582a:	b7fd                	j	80005818 <sys_mkdir+0x4c>

000000008000582c <sys_mknod>:

uint64
sys_mknod(void)
{
    8000582c:	7135                	addi	sp,sp,-160
    8000582e:	ed06                	sd	ra,152(sp)
    80005830:	e922                	sd	s0,144(sp)
    80005832:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80005834:	fffff097          	auipc	ra,0xfffff
    80005838:	856080e7          	jalr	-1962(ra) # 8000408a <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    8000583c:	08000613          	li	a2,128
    80005840:	f7040593          	addi	a1,s0,-144
    80005844:	4501                	li	a0,0
    80005846:	ffffd097          	auipc	ra,0xffffd
    8000584a:	302080e7          	jalr	770(ra) # 80002b48 <argstr>
    8000584e:	04054a63          	bltz	a0,800058a2 <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80005852:	f6c40593          	addi	a1,s0,-148
    80005856:	4505                	li	a0,1
    80005858:	ffffd097          	auipc	ra,0xffffd
    8000585c:	2ac080e7          	jalr	684(ra) # 80002b04 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005860:	04054163          	bltz	a0,800058a2 <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80005864:	f6840593          	addi	a1,s0,-152
    80005868:	4509                	li	a0,2
    8000586a:	ffffd097          	auipc	ra,0xffffd
    8000586e:	29a080e7          	jalr	666(ra) # 80002b04 <argint>
     argint(1, &major) < 0 ||
    80005872:	02054863          	bltz	a0,800058a2 <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80005876:	f6841683          	lh	a3,-152(s0)
    8000587a:	f6c41603          	lh	a2,-148(s0)
    8000587e:	458d                	li	a1,3
    80005880:	f7040513          	addi	a0,s0,-144
    80005884:	fffff097          	auipc	ra,0xfffff
    80005888:	774080e7          	jalr	1908(ra) # 80004ff8 <create>
     argint(2, &minor) < 0 ||
    8000588c:	c919                	beqz	a0,800058a2 <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    8000588e:	ffffe097          	auipc	ra,0xffffe
    80005892:	082080e7          	jalr	130(ra) # 80003910 <iunlockput>
  end_op();
    80005896:	fffff097          	auipc	ra,0xfffff
    8000589a:	872080e7          	jalr	-1934(ra) # 80004108 <end_op>
  return 0;
    8000589e:	4501                	li	a0,0
    800058a0:	a031                	j	800058ac <sys_mknod+0x80>
    end_op();
    800058a2:	fffff097          	auipc	ra,0xfffff
    800058a6:	866080e7          	jalr	-1946(ra) # 80004108 <end_op>
    return -1;
    800058aa:	557d                	li	a0,-1
}
    800058ac:	60ea                	ld	ra,152(sp)
    800058ae:	644a                	ld	s0,144(sp)
    800058b0:	610d                	addi	sp,sp,160
    800058b2:	8082                	ret

00000000800058b4 <sys_chdir>:

uint64
sys_chdir(void)
{
    800058b4:	7135                	addi	sp,sp,-160
    800058b6:	ed06                	sd	ra,152(sp)
    800058b8:	e922                	sd	s0,144(sp)
    800058ba:	e526                	sd	s1,136(sp)
    800058bc:	e14a                	sd	s2,128(sp)
    800058be:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800058c0:	ffffc097          	auipc	ra,0xffffc
    800058c4:	0d6080e7          	jalr	214(ra) # 80001996 <myproc>
    800058c8:	892a                	mv	s2,a0
  
  begin_op();
    800058ca:	ffffe097          	auipc	ra,0xffffe
    800058ce:	7c0080e7          	jalr	1984(ra) # 8000408a <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    800058d2:	08000613          	li	a2,128
    800058d6:	f6040593          	addi	a1,s0,-160
    800058da:	4501                	li	a0,0
    800058dc:	ffffd097          	auipc	ra,0xffffd
    800058e0:	26c080e7          	jalr	620(ra) # 80002b48 <argstr>
    800058e4:	04054b63          	bltz	a0,8000593a <sys_chdir+0x86>
    800058e8:	f6040513          	addi	a0,s0,-160
    800058ec:	ffffe097          	auipc	ra,0xffffe
    800058f0:	57e080e7          	jalr	1406(ra) # 80003e6a <namei>
    800058f4:	84aa                	mv	s1,a0
    800058f6:	c131                	beqz	a0,8000593a <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    800058f8:	ffffe097          	auipc	ra,0xffffe
    800058fc:	db6080e7          	jalr	-586(ra) # 800036ae <ilock>
  if(ip->type != T_DIR){
    80005900:	04449703          	lh	a4,68(s1)
    80005904:	4785                	li	a5,1
    80005906:	04f71063          	bne	a4,a5,80005946 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    8000590a:	8526                	mv	a0,s1
    8000590c:	ffffe097          	auipc	ra,0xffffe
    80005910:	e64080e7          	jalr	-412(ra) # 80003770 <iunlock>
  iput(p->cwd);
    80005914:	16093503          	ld	a0,352(s2)
    80005918:	ffffe097          	auipc	ra,0xffffe
    8000591c:	f50080e7          	jalr	-176(ra) # 80003868 <iput>
  end_op();
    80005920:	ffffe097          	auipc	ra,0xffffe
    80005924:	7e8080e7          	jalr	2024(ra) # 80004108 <end_op>
  p->cwd = ip;
    80005928:	16993023          	sd	s1,352(s2)
  return 0;
    8000592c:	4501                	li	a0,0
}
    8000592e:	60ea                	ld	ra,152(sp)
    80005930:	644a                	ld	s0,144(sp)
    80005932:	64aa                	ld	s1,136(sp)
    80005934:	690a                	ld	s2,128(sp)
    80005936:	610d                	addi	sp,sp,160
    80005938:	8082                	ret
    end_op();
    8000593a:	ffffe097          	auipc	ra,0xffffe
    8000593e:	7ce080e7          	jalr	1998(ra) # 80004108 <end_op>
    return -1;
    80005942:	557d                	li	a0,-1
    80005944:	b7ed                	j	8000592e <sys_chdir+0x7a>
    iunlockput(ip);
    80005946:	8526                	mv	a0,s1
    80005948:	ffffe097          	auipc	ra,0xffffe
    8000594c:	fc8080e7          	jalr	-56(ra) # 80003910 <iunlockput>
    end_op();
    80005950:	ffffe097          	auipc	ra,0xffffe
    80005954:	7b8080e7          	jalr	1976(ra) # 80004108 <end_op>
    return -1;
    80005958:	557d                	li	a0,-1
    8000595a:	bfd1                	j	8000592e <sys_chdir+0x7a>

000000008000595c <sys_exec>:

uint64
sys_exec(void)
{
    8000595c:	7145                	addi	sp,sp,-464
    8000595e:	e786                	sd	ra,456(sp)
    80005960:	e3a2                	sd	s0,448(sp)
    80005962:	ff26                	sd	s1,440(sp)
    80005964:	fb4a                	sd	s2,432(sp)
    80005966:	f74e                	sd	s3,424(sp)
    80005968:	f352                	sd	s4,416(sp)
    8000596a:	ef56                	sd	s5,408(sp)
    8000596c:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    8000596e:	08000613          	li	a2,128
    80005972:	f4040593          	addi	a1,s0,-192
    80005976:	4501                	li	a0,0
    80005978:	ffffd097          	auipc	ra,0xffffd
    8000597c:	1d0080e7          	jalr	464(ra) # 80002b48 <argstr>
    return -1;
    80005980:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80005982:	0c054b63          	bltz	a0,80005a58 <sys_exec+0xfc>
    80005986:	e3840593          	addi	a1,s0,-456
    8000598a:	4505                	li	a0,1
    8000598c:	ffffd097          	auipc	ra,0xffffd
    80005990:	19a080e7          	jalr	410(ra) # 80002b26 <argaddr>
    80005994:	0c054263          	bltz	a0,80005a58 <sys_exec+0xfc>
  }
  memset(argv, 0, sizeof(argv));
    80005998:	10000613          	li	a2,256
    8000599c:	4581                	li	a1,0
    8000599e:	e4040513          	addi	a0,s0,-448
    800059a2:	ffffb097          	auipc	ra,0xffffb
    800059a6:	32a080e7          	jalr	810(ra) # 80000ccc <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    800059aa:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    800059ae:	89a6                	mv	s3,s1
    800059b0:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    800059b2:	02000a13          	li	s4,32
    800059b6:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800059ba:	00391513          	slli	a0,s2,0x3
    800059be:	e3040593          	addi	a1,s0,-464
    800059c2:	e3843783          	ld	a5,-456(s0)
    800059c6:	953e                	add	a0,a0,a5
    800059c8:	ffffd097          	auipc	ra,0xffffd
    800059cc:	0a2080e7          	jalr	162(ra) # 80002a6a <fetchaddr>
    800059d0:	02054a63          	bltz	a0,80005a04 <sys_exec+0xa8>
      goto bad;
    }
    if(uarg == 0){
    800059d4:	e3043783          	ld	a5,-464(s0)
    800059d8:	c3b9                	beqz	a5,80005a1e <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    800059da:	ffffb097          	auipc	ra,0xffffb
    800059de:	106080e7          	jalr	262(ra) # 80000ae0 <kalloc>
    800059e2:	85aa                	mv	a1,a0
    800059e4:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    800059e8:	cd11                	beqz	a0,80005a04 <sys_exec+0xa8>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800059ea:	6605                	lui	a2,0x1
    800059ec:	e3043503          	ld	a0,-464(s0)
    800059f0:	ffffd097          	auipc	ra,0xffffd
    800059f4:	0cc080e7          	jalr	204(ra) # 80002abc <fetchstr>
    800059f8:	00054663          	bltz	a0,80005a04 <sys_exec+0xa8>
    if(i >= NELEM(argv)){
    800059fc:	0905                	addi	s2,s2,1
    800059fe:	09a1                	addi	s3,s3,8
    80005a00:	fb491be3          	bne	s2,s4,800059b6 <sys_exec+0x5a>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005a04:	f4040913          	addi	s2,s0,-192
    80005a08:	6088                	ld	a0,0(s1)
    80005a0a:	c531                	beqz	a0,80005a56 <sys_exec+0xfa>
    kfree(argv[i]);
    80005a0c:	ffffb097          	auipc	ra,0xffffb
    80005a10:	fd6080e7          	jalr	-42(ra) # 800009e2 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005a14:	04a1                	addi	s1,s1,8
    80005a16:	ff2499e3          	bne	s1,s2,80005a08 <sys_exec+0xac>
  return -1;
    80005a1a:	597d                	li	s2,-1
    80005a1c:	a835                	j	80005a58 <sys_exec+0xfc>
      argv[i] = 0;
    80005a1e:	0a8e                	slli	s5,s5,0x3
    80005a20:	fc0a8793          	addi	a5,s5,-64 # ffffffffffffefc0 <end+0xffffffff7ffd8fc0>
    80005a24:	00878ab3          	add	s5,a5,s0
    80005a28:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    80005a2c:	e4040593          	addi	a1,s0,-448
    80005a30:	f4040513          	addi	a0,s0,-192
    80005a34:	fffff097          	auipc	ra,0xfffff
    80005a38:	172080e7          	jalr	370(ra) # 80004ba6 <exec>
    80005a3c:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005a3e:	f4040993          	addi	s3,s0,-192
    80005a42:	6088                	ld	a0,0(s1)
    80005a44:	c911                	beqz	a0,80005a58 <sys_exec+0xfc>
    kfree(argv[i]);
    80005a46:	ffffb097          	auipc	ra,0xffffb
    80005a4a:	f9c080e7          	jalr	-100(ra) # 800009e2 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005a4e:	04a1                	addi	s1,s1,8
    80005a50:	ff3499e3          	bne	s1,s3,80005a42 <sys_exec+0xe6>
    80005a54:	a011                	j	80005a58 <sys_exec+0xfc>
  return -1;
    80005a56:	597d                	li	s2,-1
}
    80005a58:	854a                	mv	a0,s2
    80005a5a:	60be                	ld	ra,456(sp)
    80005a5c:	641e                	ld	s0,448(sp)
    80005a5e:	74fa                	ld	s1,440(sp)
    80005a60:	795a                	ld	s2,432(sp)
    80005a62:	79ba                	ld	s3,424(sp)
    80005a64:	7a1a                	ld	s4,416(sp)
    80005a66:	6afa                	ld	s5,408(sp)
    80005a68:	6179                	addi	sp,sp,464
    80005a6a:	8082                	ret

0000000080005a6c <sys_pipe>:

uint64
sys_pipe(void)
{
    80005a6c:	7139                	addi	sp,sp,-64
    80005a6e:	fc06                	sd	ra,56(sp)
    80005a70:	f822                	sd	s0,48(sp)
    80005a72:	f426                	sd	s1,40(sp)
    80005a74:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005a76:	ffffc097          	auipc	ra,0xffffc
    80005a7a:	f20080e7          	jalr	-224(ra) # 80001996 <myproc>
    80005a7e:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    80005a80:	fd840593          	addi	a1,s0,-40
    80005a84:	4501                	li	a0,0
    80005a86:	ffffd097          	auipc	ra,0xffffd
    80005a8a:	0a0080e7          	jalr	160(ra) # 80002b26 <argaddr>
    return -1;
    80005a8e:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    80005a90:	0e054063          	bltz	a0,80005b70 <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    80005a94:	fc840593          	addi	a1,s0,-56
    80005a98:	fd040513          	addi	a0,s0,-48
    80005a9c:	fffff097          	auipc	ra,0xfffff
    80005aa0:	de6080e7          	jalr	-538(ra) # 80004882 <pipealloc>
    return -1;
    80005aa4:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005aa6:	0c054563          	bltz	a0,80005b70 <sys_pipe+0x104>
  fd0 = -1;
    80005aaa:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005aae:	fd043503          	ld	a0,-48(s0)
    80005ab2:	fffff097          	auipc	ra,0xfffff
    80005ab6:	504080e7          	jalr	1284(ra) # 80004fb6 <fdalloc>
    80005aba:	fca42223          	sw	a0,-60(s0)
    80005abe:	08054c63          	bltz	a0,80005b56 <sys_pipe+0xea>
    80005ac2:	fc843503          	ld	a0,-56(s0)
    80005ac6:	fffff097          	auipc	ra,0xfffff
    80005aca:	4f0080e7          	jalr	1264(ra) # 80004fb6 <fdalloc>
    80005ace:	fca42023          	sw	a0,-64(s0)
    80005ad2:	06054963          	bltz	a0,80005b44 <sys_pipe+0xd8>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005ad6:	4691                	li	a3,4
    80005ad8:	fc440613          	addi	a2,s0,-60
    80005adc:	fd843583          	ld	a1,-40(s0)
    80005ae0:	70a8                	ld	a0,96(s1)
    80005ae2:	ffffc097          	auipc	ra,0xffffc
    80005ae6:	b78080e7          	jalr	-1160(ra) # 8000165a <copyout>
    80005aea:	02054063          	bltz	a0,80005b0a <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005aee:	4691                	li	a3,4
    80005af0:	fc040613          	addi	a2,s0,-64
    80005af4:	fd843583          	ld	a1,-40(s0)
    80005af8:	0591                	addi	a1,a1,4
    80005afa:	70a8                	ld	a0,96(s1)
    80005afc:	ffffc097          	auipc	ra,0xffffc
    80005b00:	b5e080e7          	jalr	-1186(ra) # 8000165a <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005b04:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005b06:	06055563          	bgez	a0,80005b70 <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    80005b0a:	fc442783          	lw	a5,-60(s0)
    80005b0e:	07f1                	addi	a5,a5,28
    80005b10:	078e                	slli	a5,a5,0x3
    80005b12:	97a6                	add	a5,a5,s1
    80005b14:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80005b18:	fc042783          	lw	a5,-64(s0)
    80005b1c:	07f1                	addi	a5,a5,28
    80005b1e:	078e                	slli	a5,a5,0x3
    80005b20:	00f48533          	add	a0,s1,a5
    80005b24:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005b28:	fd043503          	ld	a0,-48(s0)
    80005b2c:	fffff097          	auipc	ra,0xfffff
    80005b30:	a26080e7          	jalr	-1498(ra) # 80004552 <fileclose>
    fileclose(wf);
    80005b34:	fc843503          	ld	a0,-56(s0)
    80005b38:	fffff097          	auipc	ra,0xfffff
    80005b3c:	a1a080e7          	jalr	-1510(ra) # 80004552 <fileclose>
    return -1;
    80005b40:	57fd                	li	a5,-1
    80005b42:	a03d                	j	80005b70 <sys_pipe+0x104>
    if(fd0 >= 0)
    80005b44:	fc442783          	lw	a5,-60(s0)
    80005b48:	0007c763          	bltz	a5,80005b56 <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    80005b4c:	07f1                	addi	a5,a5,28
    80005b4e:	078e                	slli	a5,a5,0x3
    80005b50:	97a6                	add	a5,a5,s1
    80005b52:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80005b56:	fd043503          	ld	a0,-48(s0)
    80005b5a:	fffff097          	auipc	ra,0xfffff
    80005b5e:	9f8080e7          	jalr	-1544(ra) # 80004552 <fileclose>
    fileclose(wf);
    80005b62:	fc843503          	ld	a0,-56(s0)
    80005b66:	fffff097          	auipc	ra,0xfffff
    80005b6a:	9ec080e7          	jalr	-1556(ra) # 80004552 <fileclose>
    return -1;
    80005b6e:	57fd                	li	a5,-1
}
    80005b70:	853e                	mv	a0,a5
    80005b72:	70e2                	ld	ra,56(sp)
    80005b74:	7442                	ld	s0,48(sp)
    80005b76:	74a2                	ld	s1,40(sp)
    80005b78:	6121                	addi	sp,sp,64
    80005b7a:	8082                	ret
    80005b7c:	0000                	unimp
	...

0000000080005b80 <kernelvec>:
    80005b80:	7111                	addi	sp,sp,-256
    80005b82:	e006                	sd	ra,0(sp)
    80005b84:	e40a                	sd	sp,8(sp)
    80005b86:	e80e                	sd	gp,16(sp)
    80005b88:	ec12                	sd	tp,24(sp)
    80005b8a:	f016                	sd	t0,32(sp)
    80005b8c:	f41a                	sd	t1,40(sp)
    80005b8e:	f81e                	sd	t2,48(sp)
    80005b90:	fc22                	sd	s0,56(sp)
    80005b92:	e0a6                	sd	s1,64(sp)
    80005b94:	e4aa                	sd	a0,72(sp)
    80005b96:	e8ae                	sd	a1,80(sp)
    80005b98:	ecb2                	sd	a2,88(sp)
    80005b9a:	f0b6                	sd	a3,96(sp)
    80005b9c:	f4ba                	sd	a4,104(sp)
    80005b9e:	f8be                	sd	a5,112(sp)
    80005ba0:	fcc2                	sd	a6,120(sp)
    80005ba2:	e146                	sd	a7,128(sp)
    80005ba4:	e54a                	sd	s2,136(sp)
    80005ba6:	e94e                	sd	s3,144(sp)
    80005ba8:	ed52                	sd	s4,152(sp)
    80005baa:	f156                	sd	s5,160(sp)
    80005bac:	f55a                	sd	s6,168(sp)
    80005bae:	f95e                	sd	s7,176(sp)
    80005bb0:	fd62                	sd	s8,184(sp)
    80005bb2:	e1e6                	sd	s9,192(sp)
    80005bb4:	e5ea                	sd	s10,200(sp)
    80005bb6:	e9ee                	sd	s11,208(sp)
    80005bb8:	edf2                	sd	t3,216(sp)
    80005bba:	f1f6                	sd	t4,224(sp)
    80005bbc:	f5fa                	sd	t5,232(sp)
    80005bbe:	f9fe                	sd	t6,240(sp)
    80005bc0:	d77fc0ef          	jal	ra,80002936 <kerneltrap>
    80005bc4:	6082                	ld	ra,0(sp)
    80005bc6:	6122                	ld	sp,8(sp)
    80005bc8:	61c2                	ld	gp,16(sp)
    80005bca:	7282                	ld	t0,32(sp)
    80005bcc:	7322                	ld	t1,40(sp)
    80005bce:	73c2                	ld	t2,48(sp)
    80005bd0:	7462                	ld	s0,56(sp)
    80005bd2:	6486                	ld	s1,64(sp)
    80005bd4:	6526                	ld	a0,72(sp)
    80005bd6:	65c6                	ld	a1,80(sp)
    80005bd8:	6666                	ld	a2,88(sp)
    80005bda:	7686                	ld	a3,96(sp)
    80005bdc:	7726                	ld	a4,104(sp)
    80005bde:	77c6                	ld	a5,112(sp)
    80005be0:	7866                	ld	a6,120(sp)
    80005be2:	688a                	ld	a7,128(sp)
    80005be4:	692a                	ld	s2,136(sp)
    80005be6:	69ca                	ld	s3,144(sp)
    80005be8:	6a6a                	ld	s4,152(sp)
    80005bea:	7a8a                	ld	s5,160(sp)
    80005bec:	7b2a                	ld	s6,168(sp)
    80005bee:	7bca                	ld	s7,176(sp)
    80005bf0:	7c6a                	ld	s8,184(sp)
    80005bf2:	6c8e                	ld	s9,192(sp)
    80005bf4:	6d2e                	ld	s10,200(sp)
    80005bf6:	6dce                	ld	s11,208(sp)
    80005bf8:	6e6e                	ld	t3,216(sp)
    80005bfa:	7e8e                	ld	t4,224(sp)
    80005bfc:	7f2e                	ld	t5,232(sp)
    80005bfe:	7fce                	ld	t6,240(sp)
    80005c00:	6111                	addi	sp,sp,256
    80005c02:	10200073          	sret
    80005c06:	00000013          	nop
    80005c0a:	00000013          	nop
    80005c0e:	0001                	nop

0000000080005c10 <timervec>:
    80005c10:	34051573          	csrrw	a0,mscratch,a0
    80005c14:	e10c                	sd	a1,0(a0)
    80005c16:	e510                	sd	a2,8(a0)
    80005c18:	e914                	sd	a3,16(a0)
    80005c1a:	6d0c                	ld	a1,24(a0)
    80005c1c:	7110                	ld	a2,32(a0)
    80005c1e:	6194                	ld	a3,0(a1)
    80005c20:	96b2                	add	a3,a3,a2
    80005c22:	e194                	sd	a3,0(a1)
    80005c24:	4589                	li	a1,2
    80005c26:	14459073          	csrw	sip,a1
    80005c2a:	6914                	ld	a3,16(a0)
    80005c2c:	6510                	ld	a2,8(a0)
    80005c2e:	610c                	ld	a1,0(a0)
    80005c30:	34051573          	csrrw	a0,mscratch,a0
    80005c34:	30200073          	mret
	...

0000000080005c3a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80005c3a:	1141                	addi	sp,sp,-16
    80005c3c:	e422                	sd	s0,8(sp)
    80005c3e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005c40:	0c0007b7          	lui	a5,0xc000
    80005c44:	4705                	li	a4,1
    80005c46:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005c48:	c3d8                	sw	a4,4(a5)
}
    80005c4a:	6422                	ld	s0,8(sp)
    80005c4c:	0141                	addi	sp,sp,16
    80005c4e:	8082                	ret

0000000080005c50 <plicinithart>:

void
plicinithart(void)
{
    80005c50:	1141                	addi	sp,sp,-16
    80005c52:	e406                	sd	ra,8(sp)
    80005c54:	e022                	sd	s0,0(sp)
    80005c56:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005c58:	ffffc097          	auipc	ra,0xffffc
    80005c5c:	d12080e7          	jalr	-750(ra) # 8000196a <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005c60:	0085171b          	slliw	a4,a0,0x8
    80005c64:	0c0027b7          	lui	a5,0xc002
    80005c68:	97ba                	add	a5,a5,a4
    80005c6a:	40200713          	li	a4,1026
    80005c6e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005c72:	00d5151b          	slliw	a0,a0,0xd
    80005c76:	0c2017b7          	lui	a5,0xc201
    80005c7a:	97aa                	add	a5,a5,a0
    80005c7c:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80005c80:	60a2                	ld	ra,8(sp)
    80005c82:	6402                	ld	s0,0(sp)
    80005c84:	0141                	addi	sp,sp,16
    80005c86:	8082                	ret

0000000080005c88 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005c88:	1141                	addi	sp,sp,-16
    80005c8a:	e406                	sd	ra,8(sp)
    80005c8c:	e022                	sd	s0,0(sp)
    80005c8e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005c90:	ffffc097          	auipc	ra,0xffffc
    80005c94:	cda080e7          	jalr	-806(ra) # 8000196a <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005c98:	00d5151b          	slliw	a0,a0,0xd
    80005c9c:	0c2017b7          	lui	a5,0xc201
    80005ca0:	97aa                	add	a5,a5,a0
  return irq;
}
    80005ca2:	43c8                	lw	a0,4(a5)
    80005ca4:	60a2                	ld	ra,8(sp)
    80005ca6:	6402                	ld	s0,0(sp)
    80005ca8:	0141                	addi	sp,sp,16
    80005caa:	8082                	ret

0000000080005cac <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80005cac:	1101                	addi	sp,sp,-32
    80005cae:	ec06                	sd	ra,24(sp)
    80005cb0:	e822                	sd	s0,16(sp)
    80005cb2:	e426                	sd	s1,8(sp)
    80005cb4:	1000                	addi	s0,sp,32
    80005cb6:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005cb8:	ffffc097          	auipc	ra,0xffffc
    80005cbc:	cb2080e7          	jalr	-846(ra) # 8000196a <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005cc0:	00d5151b          	slliw	a0,a0,0xd
    80005cc4:	0c2017b7          	lui	a5,0xc201
    80005cc8:	97aa                	add	a5,a5,a0
    80005cca:	c3c4                	sw	s1,4(a5)
}
    80005ccc:	60e2                	ld	ra,24(sp)
    80005cce:	6442                	ld	s0,16(sp)
    80005cd0:	64a2                	ld	s1,8(sp)
    80005cd2:	6105                	addi	sp,sp,32
    80005cd4:	8082                	ret

0000000080005cd6 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005cd6:	1141                	addi	sp,sp,-16
    80005cd8:	e406                	sd	ra,8(sp)
    80005cda:	e022                	sd	s0,0(sp)
    80005cdc:	0800                	addi	s0,sp,16
  if(i >= NUM)
    80005cde:	479d                	li	a5,7
    80005ce0:	06a7c863          	blt	a5,a0,80005d50 <free_desc+0x7a>
    panic("free_desc 1");
  if(disk.free[i])
    80005ce4:	0001d717          	auipc	a4,0x1d
    80005ce8:	31c70713          	addi	a4,a4,796 # 80023000 <disk>
    80005cec:	972a                	add	a4,a4,a0
    80005cee:	6789                	lui	a5,0x2
    80005cf0:	97ba                	add	a5,a5,a4
    80005cf2:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    80005cf6:	e7ad                	bnez	a5,80005d60 <free_desc+0x8a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005cf8:	00451793          	slli	a5,a0,0x4
    80005cfc:	0001f717          	auipc	a4,0x1f
    80005d00:	30470713          	addi	a4,a4,772 # 80025000 <disk+0x2000>
    80005d04:	6314                	ld	a3,0(a4)
    80005d06:	96be                	add	a3,a3,a5
    80005d08:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    80005d0c:	6314                	ld	a3,0(a4)
    80005d0e:	96be                	add	a3,a3,a5
    80005d10:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    80005d14:	6314                	ld	a3,0(a4)
    80005d16:	96be                	add	a3,a3,a5
    80005d18:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    80005d1c:	6318                	ld	a4,0(a4)
    80005d1e:	97ba                	add	a5,a5,a4
    80005d20:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80005d24:	0001d717          	auipc	a4,0x1d
    80005d28:	2dc70713          	addi	a4,a4,732 # 80023000 <disk>
    80005d2c:	972a                	add	a4,a4,a0
    80005d2e:	6789                	lui	a5,0x2
    80005d30:	97ba                	add	a5,a5,a4
    80005d32:	4705                	li	a4,1
    80005d34:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    80005d38:	0001f517          	auipc	a0,0x1f
    80005d3c:	2e050513          	addi	a0,a0,736 # 80025018 <disk+0x2018>
    80005d40:	ffffc097          	auipc	ra,0xffffc
    80005d44:	4b0080e7          	jalr	1200(ra) # 800021f0 <wakeup>
}
    80005d48:	60a2                	ld	ra,8(sp)
    80005d4a:	6402                	ld	s0,0(sp)
    80005d4c:	0141                	addi	sp,sp,16
    80005d4e:	8082                	ret
    panic("free_desc 1");
    80005d50:	00003517          	auipc	a0,0x3
    80005d54:	a2050513          	addi	a0,a0,-1504 # 80008770 <syscalls+0x328>
    80005d58:	ffffa097          	auipc	ra,0xffffa
    80005d5c:	7e2080e7          	jalr	2018(ra) # 8000053a <panic>
    panic("free_desc 2");
    80005d60:	00003517          	auipc	a0,0x3
    80005d64:	a2050513          	addi	a0,a0,-1504 # 80008780 <syscalls+0x338>
    80005d68:	ffffa097          	auipc	ra,0xffffa
    80005d6c:	7d2080e7          	jalr	2002(ra) # 8000053a <panic>

0000000080005d70 <virtio_disk_init>:
{
    80005d70:	1101                	addi	sp,sp,-32
    80005d72:	ec06                	sd	ra,24(sp)
    80005d74:	e822                	sd	s0,16(sp)
    80005d76:	e426                	sd	s1,8(sp)
    80005d78:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005d7a:	00003597          	auipc	a1,0x3
    80005d7e:	a1658593          	addi	a1,a1,-1514 # 80008790 <syscalls+0x348>
    80005d82:	0001f517          	auipc	a0,0x1f
    80005d86:	3a650513          	addi	a0,a0,934 # 80025128 <disk+0x2128>
    80005d8a:	ffffb097          	auipc	ra,0xffffb
    80005d8e:	db6080e7          	jalr	-586(ra) # 80000b40 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005d92:	100017b7          	lui	a5,0x10001
    80005d96:	4398                	lw	a4,0(a5)
    80005d98:	2701                	sext.w	a4,a4
    80005d9a:	747277b7          	lui	a5,0x74727
    80005d9e:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005da2:	0ef71063          	bne	a4,a5,80005e82 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005da6:	100017b7          	lui	a5,0x10001
    80005daa:	43dc                	lw	a5,4(a5)
    80005dac:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005dae:	4705                	li	a4,1
    80005db0:	0ce79963          	bne	a5,a4,80005e82 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005db4:	100017b7          	lui	a5,0x10001
    80005db8:	479c                	lw	a5,8(a5)
    80005dba:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005dbc:	4709                	li	a4,2
    80005dbe:	0ce79263          	bne	a5,a4,80005e82 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005dc2:	100017b7          	lui	a5,0x10001
    80005dc6:	47d8                	lw	a4,12(a5)
    80005dc8:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005dca:	554d47b7          	lui	a5,0x554d4
    80005dce:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005dd2:	0af71863          	bne	a4,a5,80005e82 <virtio_disk_init+0x112>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005dd6:	100017b7          	lui	a5,0x10001
    80005dda:	4705                	li	a4,1
    80005ddc:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005dde:	470d                	li	a4,3
    80005de0:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005de2:	4b98                	lw	a4,16(a5)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005de4:	c7ffe6b7          	lui	a3,0xc7ffe
    80005de8:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fd875f>
    80005dec:	8f75                	and	a4,a4,a3
    80005dee:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005df0:	472d                	li	a4,11
    80005df2:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005df4:	473d                	li	a4,15
    80005df6:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    80005df8:	6705                	lui	a4,0x1
    80005dfa:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005dfc:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005e00:	5bdc                	lw	a5,52(a5)
    80005e02:	2781                	sext.w	a5,a5
  if(max == 0)
    80005e04:	c7d9                	beqz	a5,80005e92 <virtio_disk_init+0x122>
  if(max < NUM)
    80005e06:	471d                	li	a4,7
    80005e08:	08f77d63          	bgeu	a4,a5,80005ea2 <virtio_disk_init+0x132>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005e0c:	100014b7          	lui	s1,0x10001
    80005e10:	47a1                	li	a5,8
    80005e12:	dc9c                	sw	a5,56(s1)
  memset(disk.pages, 0, sizeof(disk.pages));
    80005e14:	6609                	lui	a2,0x2
    80005e16:	4581                	li	a1,0
    80005e18:	0001d517          	auipc	a0,0x1d
    80005e1c:	1e850513          	addi	a0,a0,488 # 80023000 <disk>
    80005e20:	ffffb097          	auipc	ra,0xffffb
    80005e24:	eac080e7          	jalr	-340(ra) # 80000ccc <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    80005e28:	0001d717          	auipc	a4,0x1d
    80005e2c:	1d870713          	addi	a4,a4,472 # 80023000 <disk>
    80005e30:	00c75793          	srli	a5,a4,0xc
    80005e34:	2781                	sext.w	a5,a5
    80005e36:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct virtq_desc *) disk.pages;
    80005e38:	0001f797          	auipc	a5,0x1f
    80005e3c:	1c878793          	addi	a5,a5,456 # 80025000 <disk+0x2000>
    80005e40:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    80005e42:	0001d717          	auipc	a4,0x1d
    80005e46:	23e70713          	addi	a4,a4,574 # 80023080 <disk+0x80>
    80005e4a:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    80005e4c:	0001e717          	auipc	a4,0x1e
    80005e50:	1b470713          	addi	a4,a4,436 # 80024000 <disk+0x1000>
    80005e54:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    80005e56:	4705                	li	a4,1
    80005e58:	00e78c23          	sb	a4,24(a5)
    80005e5c:	00e78ca3          	sb	a4,25(a5)
    80005e60:	00e78d23          	sb	a4,26(a5)
    80005e64:	00e78da3          	sb	a4,27(a5)
    80005e68:	00e78e23          	sb	a4,28(a5)
    80005e6c:	00e78ea3          	sb	a4,29(a5)
    80005e70:	00e78f23          	sb	a4,30(a5)
    80005e74:	00e78fa3          	sb	a4,31(a5)
}
    80005e78:	60e2                	ld	ra,24(sp)
    80005e7a:	6442                	ld	s0,16(sp)
    80005e7c:	64a2                	ld	s1,8(sp)
    80005e7e:	6105                	addi	sp,sp,32
    80005e80:	8082                	ret
    panic("could not find virtio disk");
    80005e82:	00003517          	auipc	a0,0x3
    80005e86:	91e50513          	addi	a0,a0,-1762 # 800087a0 <syscalls+0x358>
    80005e8a:	ffffa097          	auipc	ra,0xffffa
    80005e8e:	6b0080e7          	jalr	1712(ra) # 8000053a <panic>
    panic("virtio disk has no queue 0");
    80005e92:	00003517          	auipc	a0,0x3
    80005e96:	92e50513          	addi	a0,a0,-1746 # 800087c0 <syscalls+0x378>
    80005e9a:	ffffa097          	auipc	ra,0xffffa
    80005e9e:	6a0080e7          	jalr	1696(ra) # 8000053a <panic>
    panic("virtio disk max queue too short");
    80005ea2:	00003517          	auipc	a0,0x3
    80005ea6:	93e50513          	addi	a0,a0,-1730 # 800087e0 <syscalls+0x398>
    80005eaa:	ffffa097          	auipc	ra,0xffffa
    80005eae:	690080e7          	jalr	1680(ra) # 8000053a <panic>

0000000080005eb2 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80005eb2:	7119                	addi	sp,sp,-128
    80005eb4:	fc86                	sd	ra,120(sp)
    80005eb6:	f8a2                	sd	s0,112(sp)
    80005eb8:	f4a6                	sd	s1,104(sp)
    80005eba:	f0ca                	sd	s2,96(sp)
    80005ebc:	ecce                	sd	s3,88(sp)
    80005ebe:	e8d2                	sd	s4,80(sp)
    80005ec0:	e4d6                	sd	s5,72(sp)
    80005ec2:	e0da                	sd	s6,64(sp)
    80005ec4:	fc5e                	sd	s7,56(sp)
    80005ec6:	f862                	sd	s8,48(sp)
    80005ec8:	f466                	sd	s9,40(sp)
    80005eca:	f06a                	sd	s10,32(sp)
    80005ecc:	ec6e                	sd	s11,24(sp)
    80005ece:	0100                	addi	s0,sp,128
    80005ed0:	8aaa                	mv	s5,a0
    80005ed2:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005ed4:	00c52c83          	lw	s9,12(a0)
    80005ed8:	001c9c9b          	slliw	s9,s9,0x1
    80005edc:	1c82                	slli	s9,s9,0x20
    80005ede:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80005ee2:	0001f517          	auipc	a0,0x1f
    80005ee6:	24650513          	addi	a0,a0,582 # 80025128 <disk+0x2128>
    80005eea:	ffffb097          	auipc	ra,0xffffb
    80005eee:	ce6080e7          	jalr	-794(ra) # 80000bd0 <acquire>
  for(int i = 0; i < 3; i++){
    80005ef2:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80005ef4:	44a1                	li	s1,8
      disk.free[i] = 0;
    80005ef6:	0001dc17          	auipc	s8,0x1d
    80005efa:	10ac0c13          	addi	s8,s8,266 # 80023000 <disk>
    80005efe:	6b89                	lui	s7,0x2
  for(int i = 0; i < 3; i++){
    80005f00:	4b0d                	li	s6,3
    80005f02:	a0ad                	j	80005f6c <virtio_disk_rw+0xba>
      disk.free[i] = 0;
    80005f04:	00fc0733          	add	a4,s8,a5
    80005f08:	975e                	add	a4,a4,s7
    80005f0a:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80005f0e:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80005f10:	0207c563          	bltz	a5,80005f3a <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    80005f14:	2905                	addiw	s2,s2,1
    80005f16:	0611                	addi	a2,a2,4
    80005f18:	19690c63          	beq	s2,s6,800060b0 <virtio_disk_rw+0x1fe>
    idx[i] = alloc_desc();
    80005f1c:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80005f1e:	0001f717          	auipc	a4,0x1f
    80005f22:	0fa70713          	addi	a4,a4,250 # 80025018 <disk+0x2018>
    80005f26:	87ce                	mv	a5,s3
    if(disk.free[i]){
    80005f28:	00074683          	lbu	a3,0(a4)
    80005f2c:	fee1                	bnez	a3,80005f04 <virtio_disk_rw+0x52>
  for(int i = 0; i < NUM; i++){
    80005f2e:	2785                	addiw	a5,a5,1
    80005f30:	0705                	addi	a4,a4,1
    80005f32:	fe979be3          	bne	a5,s1,80005f28 <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    80005f36:	57fd                	li	a5,-1
    80005f38:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    80005f3a:	01205d63          	blez	s2,80005f54 <virtio_disk_rw+0xa2>
    80005f3e:	8dce                	mv	s11,s3
        free_desc(idx[j]);
    80005f40:	000a2503          	lw	a0,0(s4)
    80005f44:	00000097          	auipc	ra,0x0
    80005f48:	d92080e7          	jalr	-622(ra) # 80005cd6 <free_desc>
      for(int j = 0; j < i; j++)
    80005f4c:	2d85                	addiw	s11,s11,1
    80005f4e:	0a11                	addi	s4,s4,4
    80005f50:	ff2d98e3          	bne	s11,s2,80005f40 <virtio_disk_rw+0x8e>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005f54:	0001f597          	auipc	a1,0x1f
    80005f58:	1d458593          	addi	a1,a1,468 # 80025128 <disk+0x2128>
    80005f5c:	0001f517          	auipc	a0,0x1f
    80005f60:	0bc50513          	addi	a0,a0,188 # 80025018 <disk+0x2018>
    80005f64:	ffffc097          	auipc	ra,0xffffc
    80005f68:	100080e7          	jalr	256(ra) # 80002064 <sleep>
  for(int i = 0; i < 3; i++){
    80005f6c:	f8040a13          	addi	s4,s0,-128
{
    80005f70:	8652                	mv	a2,s4
  for(int i = 0; i < 3; i++){
    80005f72:	894e                	mv	s2,s3
    80005f74:	b765                	j	80005f1c <virtio_disk_rw+0x6a>
  disk.desc[idx[0]].next = idx[1];

  disk.desc[idx[1]].addr = (uint64) b->data;
  disk.desc[idx[1]].len = BSIZE;
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80005f76:	0001f697          	auipc	a3,0x1f
    80005f7a:	08a6b683          	ld	a3,138(a3) # 80025000 <disk+0x2000>
    80005f7e:	96ba                	add	a3,a3,a4
    80005f80:	00069623          	sh	zero,12(a3)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80005f84:	0001d817          	auipc	a6,0x1d
    80005f88:	07c80813          	addi	a6,a6,124 # 80023000 <disk>
    80005f8c:	0001f697          	auipc	a3,0x1f
    80005f90:	07468693          	addi	a3,a3,116 # 80025000 <disk+0x2000>
    80005f94:	6290                	ld	a2,0(a3)
    80005f96:	963a                	add	a2,a2,a4
    80005f98:	00c65583          	lhu	a1,12(a2) # 200c <_entry-0x7fffdff4>
    80005f9c:	0015e593          	ori	a1,a1,1
    80005fa0:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[1]].next = idx[2];
    80005fa4:	f8842603          	lw	a2,-120(s0)
    80005fa8:	628c                	ld	a1,0(a3)
    80005faa:	972e                	add	a4,a4,a1
    80005fac:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005fb0:	20050593          	addi	a1,a0,512
    80005fb4:	0592                	slli	a1,a1,0x4
    80005fb6:	95c2                	add	a1,a1,a6
    80005fb8:	577d                	li	a4,-1
    80005fba:	02e58823          	sb	a4,48(a1)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80005fbe:	00461713          	slli	a4,a2,0x4
    80005fc2:	6290                	ld	a2,0(a3)
    80005fc4:	963a                	add	a2,a2,a4
    80005fc6:	03078793          	addi	a5,a5,48
    80005fca:	97c2                	add	a5,a5,a6
    80005fcc:	e21c                	sd	a5,0(a2)
  disk.desc[idx[2]].len = 1;
    80005fce:	629c                	ld	a5,0(a3)
    80005fd0:	97ba                	add	a5,a5,a4
    80005fd2:	4605                	li	a2,1
    80005fd4:	c790                	sw	a2,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005fd6:	629c                	ld	a5,0(a3)
    80005fd8:	97ba                	add	a5,a5,a4
    80005fda:	4809                	li	a6,2
    80005fdc:	01079623          	sh	a6,12(a5)
  disk.desc[idx[2]].next = 0;
    80005fe0:	629c                	ld	a5,0(a3)
    80005fe2:	97ba                	add	a5,a5,a4
    80005fe4:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80005fe8:	00caa223          	sw	a2,4(s5)
  disk.info[idx[0]].b = b;
    80005fec:	0355b423          	sd	s5,40(a1)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80005ff0:	6698                	ld	a4,8(a3)
    80005ff2:	00275783          	lhu	a5,2(a4)
    80005ff6:	8b9d                	andi	a5,a5,7
    80005ff8:	0786                	slli	a5,a5,0x1
    80005ffa:	973e                	add	a4,a4,a5
    80005ffc:	00a71223          	sh	a0,4(a4)

  __sync_synchronize();
    80006000:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80006004:	6698                	ld	a4,8(a3)
    80006006:	00275783          	lhu	a5,2(a4)
    8000600a:	2785                	addiw	a5,a5,1
    8000600c:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80006010:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80006014:	100017b7          	lui	a5,0x10001
    80006018:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    8000601c:	004aa783          	lw	a5,4(s5)
    80006020:	02c79163          	bne	a5,a2,80006042 <virtio_disk_rw+0x190>
    sleep(b, &disk.vdisk_lock);
    80006024:	0001f917          	auipc	s2,0x1f
    80006028:	10490913          	addi	s2,s2,260 # 80025128 <disk+0x2128>
  while(b->disk == 1) {
    8000602c:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    8000602e:	85ca                	mv	a1,s2
    80006030:	8556                	mv	a0,s5
    80006032:	ffffc097          	auipc	ra,0xffffc
    80006036:	032080e7          	jalr	50(ra) # 80002064 <sleep>
  while(b->disk == 1) {
    8000603a:	004aa783          	lw	a5,4(s5)
    8000603e:	fe9788e3          	beq	a5,s1,8000602e <virtio_disk_rw+0x17c>
  }

  disk.info[idx[0]].b = 0;
    80006042:	f8042903          	lw	s2,-128(s0)
    80006046:	20090713          	addi	a4,s2,512
    8000604a:	0712                	slli	a4,a4,0x4
    8000604c:	0001d797          	auipc	a5,0x1d
    80006050:	fb478793          	addi	a5,a5,-76 # 80023000 <disk>
    80006054:	97ba                	add	a5,a5,a4
    80006056:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    8000605a:	0001f997          	auipc	s3,0x1f
    8000605e:	fa698993          	addi	s3,s3,-90 # 80025000 <disk+0x2000>
    80006062:	00491713          	slli	a4,s2,0x4
    80006066:	0009b783          	ld	a5,0(s3)
    8000606a:	97ba                	add	a5,a5,a4
    8000606c:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80006070:	854a                	mv	a0,s2
    80006072:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80006076:	00000097          	auipc	ra,0x0
    8000607a:	c60080e7          	jalr	-928(ra) # 80005cd6 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    8000607e:	8885                	andi	s1,s1,1
    80006080:	f0ed                	bnez	s1,80006062 <virtio_disk_rw+0x1b0>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80006082:	0001f517          	auipc	a0,0x1f
    80006086:	0a650513          	addi	a0,a0,166 # 80025128 <disk+0x2128>
    8000608a:	ffffb097          	auipc	ra,0xffffb
    8000608e:	bfa080e7          	jalr	-1030(ra) # 80000c84 <release>
}
    80006092:	70e6                	ld	ra,120(sp)
    80006094:	7446                	ld	s0,112(sp)
    80006096:	74a6                	ld	s1,104(sp)
    80006098:	7906                	ld	s2,96(sp)
    8000609a:	69e6                	ld	s3,88(sp)
    8000609c:	6a46                	ld	s4,80(sp)
    8000609e:	6aa6                	ld	s5,72(sp)
    800060a0:	6b06                	ld	s6,64(sp)
    800060a2:	7be2                	ld	s7,56(sp)
    800060a4:	7c42                	ld	s8,48(sp)
    800060a6:	7ca2                	ld	s9,40(sp)
    800060a8:	7d02                	ld	s10,32(sp)
    800060aa:	6de2                	ld	s11,24(sp)
    800060ac:	6109                	addi	sp,sp,128
    800060ae:	8082                	ret
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800060b0:	f8042503          	lw	a0,-128(s0)
    800060b4:	20050793          	addi	a5,a0,512
    800060b8:	0792                	slli	a5,a5,0x4
  if(write)
    800060ba:	0001d817          	auipc	a6,0x1d
    800060be:	f4680813          	addi	a6,a6,-186 # 80023000 <disk>
    800060c2:	00f80733          	add	a4,a6,a5
    800060c6:	01a036b3          	snez	a3,s10
    800060ca:	0ad72423          	sw	a3,168(a4)
  buf0->reserved = 0;
    800060ce:	0a072623          	sw	zero,172(a4)
  buf0->sector = sector;
    800060d2:	0b973823          	sd	s9,176(a4)
  disk.desc[idx[0]].addr = (uint64) buf0;
    800060d6:	7679                	lui	a2,0xffffe
    800060d8:	963e                	add	a2,a2,a5
    800060da:	0001f697          	auipc	a3,0x1f
    800060de:	f2668693          	addi	a3,a3,-218 # 80025000 <disk+0x2000>
    800060e2:	6298                	ld	a4,0(a3)
    800060e4:	9732                	add	a4,a4,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800060e6:	0a878593          	addi	a1,a5,168
    800060ea:	95c2                	add	a1,a1,a6
  disk.desc[idx[0]].addr = (uint64) buf0;
    800060ec:	e30c                	sd	a1,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800060ee:	6298                	ld	a4,0(a3)
    800060f0:	9732                	add	a4,a4,a2
    800060f2:	45c1                	li	a1,16
    800060f4:	c70c                	sw	a1,8(a4)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800060f6:	6298                	ld	a4,0(a3)
    800060f8:	9732                	add	a4,a4,a2
    800060fa:	4585                	li	a1,1
    800060fc:	00b71623          	sh	a1,12(a4)
  disk.desc[idx[0]].next = idx[1];
    80006100:	f8442703          	lw	a4,-124(s0)
    80006104:	628c                	ld	a1,0(a3)
    80006106:	962e                	add	a2,a2,a1
    80006108:	00e61723          	sh	a4,14(a2) # ffffffffffffe00e <end+0xffffffff7ffd800e>
  disk.desc[idx[1]].addr = (uint64) b->data;
    8000610c:	0712                	slli	a4,a4,0x4
    8000610e:	6290                	ld	a2,0(a3)
    80006110:	963a                	add	a2,a2,a4
    80006112:	058a8593          	addi	a1,s5,88
    80006116:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    80006118:	6294                	ld	a3,0(a3)
    8000611a:	96ba                	add	a3,a3,a4
    8000611c:	40000613          	li	a2,1024
    80006120:	c690                	sw	a2,8(a3)
  if(write)
    80006122:	e40d1ae3          	bnez	s10,80005f76 <virtio_disk_rw+0xc4>
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80006126:	0001f697          	auipc	a3,0x1f
    8000612a:	eda6b683          	ld	a3,-294(a3) # 80025000 <disk+0x2000>
    8000612e:	96ba                	add	a3,a3,a4
    80006130:	4609                	li	a2,2
    80006132:	00c69623          	sh	a2,12(a3)
    80006136:	b5b9                	j	80005f84 <virtio_disk_rw+0xd2>

0000000080006138 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80006138:	1101                	addi	sp,sp,-32
    8000613a:	ec06                	sd	ra,24(sp)
    8000613c:	e822                	sd	s0,16(sp)
    8000613e:	e426                	sd	s1,8(sp)
    80006140:	e04a                	sd	s2,0(sp)
    80006142:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80006144:	0001f517          	auipc	a0,0x1f
    80006148:	fe450513          	addi	a0,a0,-28 # 80025128 <disk+0x2128>
    8000614c:	ffffb097          	auipc	ra,0xffffb
    80006150:	a84080e7          	jalr	-1404(ra) # 80000bd0 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80006154:	10001737          	lui	a4,0x10001
    80006158:	533c                	lw	a5,96(a4)
    8000615a:	8b8d                	andi	a5,a5,3
    8000615c:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    8000615e:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80006162:	0001f797          	auipc	a5,0x1f
    80006166:	e9e78793          	addi	a5,a5,-354 # 80025000 <disk+0x2000>
    8000616a:	6b94                	ld	a3,16(a5)
    8000616c:	0207d703          	lhu	a4,32(a5)
    80006170:	0026d783          	lhu	a5,2(a3)
    80006174:	06f70163          	beq	a4,a5,800061d6 <virtio_disk_intr+0x9e>
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80006178:	0001d917          	auipc	s2,0x1d
    8000617c:	e8890913          	addi	s2,s2,-376 # 80023000 <disk>
    80006180:	0001f497          	auipc	s1,0x1f
    80006184:	e8048493          	addi	s1,s1,-384 # 80025000 <disk+0x2000>
    __sync_synchronize();
    80006188:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000618c:	6898                	ld	a4,16(s1)
    8000618e:	0204d783          	lhu	a5,32(s1)
    80006192:	8b9d                	andi	a5,a5,7
    80006194:	078e                	slli	a5,a5,0x3
    80006196:	97ba                	add	a5,a5,a4
    80006198:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    8000619a:	20078713          	addi	a4,a5,512
    8000619e:	0712                	slli	a4,a4,0x4
    800061a0:	974a                	add	a4,a4,s2
    800061a2:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    800061a6:	e731                	bnez	a4,800061f2 <virtio_disk_intr+0xba>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    800061a8:	20078793          	addi	a5,a5,512
    800061ac:	0792                	slli	a5,a5,0x4
    800061ae:	97ca                	add	a5,a5,s2
    800061b0:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    800061b2:	00052223          	sw	zero,4(a0)
    wakeup(b);
    800061b6:	ffffc097          	auipc	ra,0xffffc
    800061ba:	03a080e7          	jalr	58(ra) # 800021f0 <wakeup>

    disk.used_idx += 1;
    800061be:	0204d783          	lhu	a5,32(s1)
    800061c2:	2785                	addiw	a5,a5,1
    800061c4:	17c2                	slli	a5,a5,0x30
    800061c6:	93c1                	srli	a5,a5,0x30
    800061c8:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    800061cc:	6898                	ld	a4,16(s1)
    800061ce:	00275703          	lhu	a4,2(a4)
    800061d2:	faf71be3          	bne	a4,a5,80006188 <virtio_disk_intr+0x50>
  }

  release(&disk.vdisk_lock);
    800061d6:	0001f517          	auipc	a0,0x1f
    800061da:	f5250513          	addi	a0,a0,-174 # 80025128 <disk+0x2128>
    800061de:	ffffb097          	auipc	ra,0xffffb
    800061e2:	aa6080e7          	jalr	-1370(ra) # 80000c84 <release>
}
    800061e6:	60e2                	ld	ra,24(sp)
    800061e8:	6442                	ld	s0,16(sp)
    800061ea:	64a2                	ld	s1,8(sp)
    800061ec:	6902                	ld	s2,0(sp)
    800061ee:	6105                	addi	sp,sp,32
    800061f0:	8082                	ret
      panic("virtio_disk_intr status");
    800061f2:	00002517          	auipc	a0,0x2
    800061f6:	60e50513          	addi	a0,a0,1550 # 80008800 <syscalls+0x3b8>
    800061fa:	ffffa097          	auipc	ra,0xffffa
    800061fe:	340080e7          	jalr	832(ra) # 8000053a <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
	...
