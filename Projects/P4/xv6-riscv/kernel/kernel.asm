
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	8c013103          	ld	sp,-1856(sp) # 800088c0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	078000ef          	jal	ra,8000008e <start>

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
    80000026:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    8000002a:	0037979b          	slliw	a5,a5,0x3
    8000002e:	02004737          	lui	a4,0x2004
    80000032:	97ba                	add	a5,a5,a4
    80000034:	0200c737          	lui	a4,0x200c
    80000038:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000003c:	000f4637          	lui	a2,0xf4
    80000040:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80000044:	95b2                	add	a1,a1,a2
    80000046:	e38c                	sd	a1,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80000048:	00269713          	slli	a4,a3,0x2
    8000004c:	9736                	add	a4,a4,a3
    8000004e:	00371693          	slli	a3,a4,0x3
    80000052:	00009717          	auipc	a4,0x9
    80000056:	fee70713          	addi	a4,a4,-18 # 80009040 <timer_scratch>
    8000005a:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    8000005c:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    8000005e:	f310                	sd	a2,32(a4)
}

static inline void 
w_mscratch(uint64 x)
{
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80000060:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80000064:	00006797          	auipc	a5,0x6
    80000068:	e0c78793          	addi	a5,a5,-500 # 80005e70 <timervec>
    8000006c:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000070:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80000074:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80000078:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    8000007c:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80000080:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80000084:	30479073          	csrw	mie,a5
}
    80000088:	6422                	ld	s0,8(sp)
    8000008a:	0141                	addi	sp,sp,16
    8000008c:	8082                	ret

000000008000008e <start>:
{
    8000008e:	1141                	addi	sp,sp,-16
    80000090:	e406                	sd	ra,8(sp)
    80000092:	e022                	sd	s0,0(sp)
    80000094:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000096:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    8000009a:	7779                	lui	a4,0xffffe
    8000009c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd87ff>
    800000a0:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800000a2:	6705                	lui	a4,0x1
    800000a4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800000a8:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800000aa:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800000ae:	00001797          	auipc	a5,0x1
    800000b2:	dc478793          	addi	a5,a5,-572 # 80000e72 <main>
    800000b6:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800000ba:	4781                	li	a5,0
    800000bc:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000c0:	67c1                	lui	a5,0x10
    800000c2:	17fd                	addi	a5,a5,-1
    800000c4:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    800000c8:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    800000cc:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800000d0:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    800000d4:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    800000d8:	57fd                	li	a5,-1
    800000da:	83a9                	srli	a5,a5,0xa
    800000dc:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    800000e0:	47bd                	li	a5,15
    800000e2:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    800000e6:	00000097          	auipc	ra,0x0
    800000ea:	f36080e7          	jalr	-202(ra) # 8000001c <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800000ee:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800000f2:	2781                	sext.w	a5,a5
}

static inline void 
w_tp(uint64 x)
{
  asm volatile("mv tp, %0" : : "r" (x));
    800000f4:	823e                	mv	tp,a5
  asm volatile("mret");
    800000f6:	30200073          	mret
}
    800000fa:	60a2                	ld	ra,8(sp)
    800000fc:	6402                	ld	s0,0(sp)
    800000fe:	0141                	addi	sp,sp,16
    80000100:	8082                	ret

0000000080000102 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80000102:	715d                	addi	sp,sp,-80
    80000104:	e486                	sd	ra,72(sp)
    80000106:	e0a2                	sd	s0,64(sp)
    80000108:	fc26                	sd	s1,56(sp)
    8000010a:	f84a                	sd	s2,48(sp)
    8000010c:	f44e                	sd	s3,40(sp)
    8000010e:	f052                	sd	s4,32(sp)
    80000110:	ec56                	sd	s5,24(sp)
    80000112:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80000114:	04c05663          	blez	a2,80000160 <consolewrite+0x5e>
    80000118:	8a2a                	mv	s4,a0
    8000011a:	84ae                	mv	s1,a1
    8000011c:	89b2                	mv	s3,a2
    8000011e:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80000120:	5afd                	li	s5,-1
    80000122:	4685                	li	a3,1
    80000124:	8626                	mv	a2,s1
    80000126:	85d2                	mv	a1,s4
    80000128:	fbf40513          	addi	a0,s0,-65
    8000012c:	00002097          	auipc	ra,0x2
    80000130:	340080e7          	jalr	832(ra) # 8000246c <either_copyin>
    80000134:	01550c63          	beq	a0,s5,8000014c <consolewrite+0x4a>
      break;
    uartputc(c);
    80000138:	fbf44503          	lbu	a0,-65(s0)
    8000013c:	00000097          	auipc	ra,0x0
    80000140:	77a080e7          	jalr	1914(ra) # 800008b6 <uartputc>
  for(i = 0; i < n; i++){
    80000144:	2905                	addiw	s2,s2,1
    80000146:	0485                	addi	s1,s1,1
    80000148:	fd299de3          	bne	s3,s2,80000122 <consolewrite+0x20>
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
    80000162:	b7ed                	j	8000014c <consolewrite+0x4a>

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
    800001d4:	e92080e7          	jalr	-366(ra) # 80002062 <sleep>
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
    80000210:	20a080e7          	jalr	522(ra) # 80002416 <either_copyout>
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
    8000028a:	55e080e7          	jalr	1374(ra) # 800007e4 <uartputc_sync>
}
    8000028e:	60a2                	ld	ra,8(sp)
    80000290:	6402                	ld	s0,0(sp)
    80000292:	0141                	addi	sp,sp,16
    80000294:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80000296:	4521                	li	a0,8
    80000298:	00000097          	auipc	ra,0x0
    8000029c:	54c080e7          	jalr	1356(ra) # 800007e4 <uartputc_sync>
    800002a0:	02000513          	li	a0,32
    800002a4:	00000097          	auipc	ra,0x0
    800002a8:	540080e7          	jalr	1344(ra) # 800007e4 <uartputc_sync>
    800002ac:	4521                	li	a0,8
    800002ae:	00000097          	auipc	ra,0x0
    800002b2:	536080e7          	jalr	1334(ra) # 800007e4 <uartputc_sync>
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
    800002f0:	1d6080e7          	jalr	470(ra) # 800024c2 <procdump>
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
    80000444:	dbe080e7          	jalr	-578(ra) # 800021fe <wakeup>
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
    8000046e:	32a080e7          	jalr	810(ra) # 80000794 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80000472:	00021797          	auipc	a5,0x21
    80000476:	4a678793          	addi	a5,a5,1190 # 80021918 <devsw>
    8000047a:	00000717          	auipc	a4,0x0
    8000047e:	cea70713          	addi	a4,a4,-790 # 80000164 <consoleread>
    80000482:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80000484:	00000717          	auipc	a4,0x0
    80000488:	c7e70713          	addi	a4,a4,-898 # 80000102 <consolewrite>
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
    800004a4:	08054663          	bltz	a0,80000530 <printint+0x9a>
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
    800004e0:	00088b63          	beqz	a7,800004f6 <printint+0x60>
    buf[i++] = '-';
    800004e4:	fe040793          	addi	a5,s0,-32
    800004e8:	973e                	add	a4,a4,a5
    800004ea:	02d00793          	li	a5,45
    800004ee:	fef70823          	sb	a5,-16(a4)
    800004f2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    800004f6:	02e05763          	blez	a4,80000524 <printint+0x8e>
    800004fa:	fd040793          	addi	a5,s0,-48
    800004fe:	00e784b3          	add	s1,a5,a4
    80000502:	fff78913          	addi	s2,a5,-1
    80000506:	993a                	add	s2,s2,a4
    80000508:	377d                	addiw	a4,a4,-1
    8000050a:	1702                	slli	a4,a4,0x20
    8000050c:	9301                	srli	a4,a4,0x20
    8000050e:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80000512:	fff4c503          	lbu	a0,-1(s1)
    80000516:	00000097          	auipc	ra,0x0
    8000051a:	d60080e7          	jalr	-672(ra) # 80000276 <consputc>
  while(--i >= 0)
    8000051e:	14fd                	addi	s1,s1,-1
    80000520:	ff2499e3          	bne	s1,s2,80000512 <printint+0x7c>
}
    80000524:	70a2                	ld	ra,40(sp)
    80000526:	7402                	ld	s0,32(sp)
    80000528:	64e2                	ld	s1,24(sp)
    8000052a:	6942                	ld	s2,16(sp)
    8000052c:	6145                	addi	sp,sp,48
    8000052e:	8082                	ret
    x = -xx;
    80000530:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80000534:	4885                	li	a7,1
    x = -xx;
    80000536:	bf9d                	j	800004ac <printint+0x16>

0000000080000538 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80000538:	1101                	addi	sp,sp,-32
    8000053a:	ec06                	sd	ra,24(sp)
    8000053c:	e822                	sd	s0,16(sp)
    8000053e:	e426                	sd	s1,8(sp)
    80000540:	1000                	addi	s0,sp,32
    80000542:	84aa                	mv	s1,a0
  pr.locking = 0;
    80000544:	00011797          	auipc	a5,0x11
    80000548:	ce07ae23          	sw	zero,-772(a5) # 80011240 <pr+0x18>
  printf("panic: ");
    8000054c:	00008517          	auipc	a0,0x8
    80000550:	acc50513          	addi	a0,a0,-1332 # 80008018 <etext+0x18>
    80000554:	00000097          	auipc	ra,0x0
    80000558:	02e080e7          	jalr	46(ra) # 80000582 <printf>
  printf(s);
    8000055c:	8526                	mv	a0,s1
    8000055e:	00000097          	auipc	ra,0x0
    80000562:	024080e7          	jalr	36(ra) # 80000582 <printf>
  printf("\n");
    80000566:	00008517          	auipc	a0,0x8
    8000056a:	b6250513          	addi	a0,a0,-1182 # 800080c8 <digits+0x88>
    8000056e:	00000097          	auipc	ra,0x0
    80000572:	014080e7          	jalr	20(ra) # 80000582 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80000576:	4785                	li	a5,1
    80000578:	00009717          	auipc	a4,0x9
    8000057c:	a8f72423          	sw	a5,-1400(a4) # 80009000 <panicked>
  for(;;)
    80000580:	a001                	j	80000580 <panic+0x48>

0000000080000582 <printf>:
{
    80000582:	7131                	addi	sp,sp,-192
    80000584:	fc86                	sd	ra,120(sp)
    80000586:	f8a2                	sd	s0,112(sp)
    80000588:	f4a6                	sd	s1,104(sp)
    8000058a:	f0ca                	sd	s2,96(sp)
    8000058c:	ecce                	sd	s3,88(sp)
    8000058e:	e8d2                	sd	s4,80(sp)
    80000590:	e4d6                	sd	s5,72(sp)
    80000592:	e0da                	sd	s6,64(sp)
    80000594:	fc5e                	sd	s7,56(sp)
    80000596:	f862                	sd	s8,48(sp)
    80000598:	f466                	sd	s9,40(sp)
    8000059a:	f06a                	sd	s10,32(sp)
    8000059c:	ec6e                	sd	s11,24(sp)
    8000059e:	0100                	addi	s0,sp,128
    800005a0:	8a2a                	mv	s4,a0
    800005a2:	e40c                	sd	a1,8(s0)
    800005a4:	e810                	sd	a2,16(s0)
    800005a6:	ec14                	sd	a3,24(s0)
    800005a8:	f018                	sd	a4,32(s0)
    800005aa:	f41c                	sd	a5,40(s0)
    800005ac:	03043823          	sd	a6,48(s0)
    800005b0:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800005b4:	00011d97          	auipc	s11,0x11
    800005b8:	c8cdad83          	lw	s11,-884(s11) # 80011240 <pr+0x18>
  if(locking)
    800005bc:	020d9b63          	bnez	s11,800005f2 <printf+0x70>
  if (fmt == 0)
    800005c0:	040a0263          	beqz	s4,80000604 <printf+0x82>
  va_start(ap, fmt);
    800005c4:	00840793          	addi	a5,s0,8
    800005c8:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800005cc:	000a4503          	lbu	a0,0(s4)
    800005d0:	14050f63          	beqz	a0,8000072e <printf+0x1ac>
    800005d4:	4981                	li	s3,0
    if(c != '%'){
    800005d6:	02500a93          	li	s5,37
    switch(c){
    800005da:	07000b93          	li	s7,112
  consputc('x');
    800005de:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800005e0:	00008b17          	auipc	s6,0x8
    800005e4:	a60b0b13          	addi	s6,s6,-1440 # 80008040 <digits>
    switch(c){
    800005e8:	07300c93          	li	s9,115
    800005ec:	06400c13          	li	s8,100
    800005f0:	a82d                	j	8000062a <printf+0xa8>
    acquire(&pr.lock);
    800005f2:	00011517          	auipc	a0,0x11
    800005f6:	c3650513          	addi	a0,a0,-970 # 80011228 <pr>
    800005fa:	00000097          	auipc	ra,0x0
    800005fe:	5d6080e7          	jalr	1494(ra) # 80000bd0 <acquire>
    80000602:	bf7d                	j	800005c0 <printf+0x3e>
    panic("null fmt");
    80000604:	00008517          	auipc	a0,0x8
    80000608:	a2450513          	addi	a0,a0,-1500 # 80008028 <etext+0x28>
    8000060c:	00000097          	auipc	ra,0x0
    80000610:	f2c080e7          	jalr	-212(ra) # 80000538 <panic>
      consputc(c);
    80000614:	00000097          	auipc	ra,0x0
    80000618:	c62080e7          	jalr	-926(ra) # 80000276 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    8000061c:	2985                	addiw	s3,s3,1
    8000061e:	013a07b3          	add	a5,s4,s3
    80000622:	0007c503          	lbu	a0,0(a5)
    80000626:	10050463          	beqz	a0,8000072e <printf+0x1ac>
    if(c != '%'){
    8000062a:	ff5515e3          	bne	a0,s5,80000614 <printf+0x92>
    c = fmt[++i] & 0xff;
    8000062e:	2985                	addiw	s3,s3,1
    80000630:	013a07b3          	add	a5,s4,s3
    80000634:	0007c783          	lbu	a5,0(a5)
    80000638:	0007849b          	sext.w	s1,a5
    if(c == 0)
    8000063c:	cbed                	beqz	a5,8000072e <printf+0x1ac>
    switch(c){
    8000063e:	05778a63          	beq	a5,s7,80000692 <printf+0x110>
    80000642:	02fbf663          	bgeu	s7,a5,8000066e <printf+0xec>
    80000646:	09978863          	beq	a5,s9,800006d6 <printf+0x154>
    8000064a:	07800713          	li	a4,120
    8000064e:	0ce79563          	bne	a5,a4,80000718 <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    80000652:	f8843783          	ld	a5,-120(s0)
    80000656:	00878713          	addi	a4,a5,8
    8000065a:	f8e43423          	sd	a4,-120(s0)
    8000065e:	4605                	li	a2,1
    80000660:	85ea                	mv	a1,s10
    80000662:	4388                	lw	a0,0(a5)
    80000664:	00000097          	auipc	ra,0x0
    80000668:	e32080e7          	jalr	-462(ra) # 80000496 <printint>
      break;
    8000066c:	bf45                	j	8000061c <printf+0x9a>
    switch(c){
    8000066e:	09578f63          	beq	a5,s5,8000070c <printf+0x18a>
    80000672:	0b879363          	bne	a5,s8,80000718 <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    80000676:	f8843783          	ld	a5,-120(s0)
    8000067a:	00878713          	addi	a4,a5,8
    8000067e:	f8e43423          	sd	a4,-120(s0)
    80000682:	4605                	li	a2,1
    80000684:	45a9                	li	a1,10
    80000686:	4388                	lw	a0,0(a5)
    80000688:	00000097          	auipc	ra,0x0
    8000068c:	e0e080e7          	jalr	-498(ra) # 80000496 <printint>
      break;
    80000690:	b771                	j	8000061c <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80000692:	f8843783          	ld	a5,-120(s0)
    80000696:	00878713          	addi	a4,a5,8
    8000069a:	f8e43423          	sd	a4,-120(s0)
    8000069e:	0007b903          	ld	s2,0(a5)
  consputc('0');
    800006a2:	03000513          	li	a0,48
    800006a6:	00000097          	auipc	ra,0x0
    800006aa:	bd0080e7          	jalr	-1072(ra) # 80000276 <consputc>
  consputc('x');
    800006ae:	07800513          	li	a0,120
    800006b2:	00000097          	auipc	ra,0x0
    800006b6:	bc4080e7          	jalr	-1084(ra) # 80000276 <consputc>
    800006ba:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800006bc:	03c95793          	srli	a5,s2,0x3c
    800006c0:	97da                	add	a5,a5,s6
    800006c2:	0007c503          	lbu	a0,0(a5)
    800006c6:	00000097          	auipc	ra,0x0
    800006ca:	bb0080e7          	jalr	-1104(ra) # 80000276 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800006ce:	0912                	slli	s2,s2,0x4
    800006d0:	34fd                	addiw	s1,s1,-1
    800006d2:	f4ed                	bnez	s1,800006bc <printf+0x13a>
    800006d4:	b7a1                	j	8000061c <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    800006d6:	f8843783          	ld	a5,-120(s0)
    800006da:	00878713          	addi	a4,a5,8
    800006de:	f8e43423          	sd	a4,-120(s0)
    800006e2:	6384                	ld	s1,0(a5)
    800006e4:	cc89                	beqz	s1,800006fe <printf+0x17c>
      for(; *s; s++)
    800006e6:	0004c503          	lbu	a0,0(s1)
    800006ea:	d90d                	beqz	a0,8000061c <printf+0x9a>
        consputc(*s);
    800006ec:	00000097          	auipc	ra,0x0
    800006f0:	b8a080e7          	jalr	-1142(ra) # 80000276 <consputc>
      for(; *s; s++)
    800006f4:	0485                	addi	s1,s1,1
    800006f6:	0004c503          	lbu	a0,0(s1)
    800006fa:	f96d                	bnez	a0,800006ec <printf+0x16a>
    800006fc:	b705                	j	8000061c <printf+0x9a>
        s = "(null)";
    800006fe:	00008497          	auipc	s1,0x8
    80000702:	92248493          	addi	s1,s1,-1758 # 80008020 <etext+0x20>
      for(; *s; s++)
    80000706:	02800513          	li	a0,40
    8000070a:	b7cd                	j	800006ec <printf+0x16a>
      consputc('%');
    8000070c:	8556                	mv	a0,s5
    8000070e:	00000097          	auipc	ra,0x0
    80000712:	b68080e7          	jalr	-1176(ra) # 80000276 <consputc>
      break;
    80000716:	b719                	j	8000061c <printf+0x9a>
      consputc('%');
    80000718:	8556                	mv	a0,s5
    8000071a:	00000097          	auipc	ra,0x0
    8000071e:	b5c080e7          	jalr	-1188(ra) # 80000276 <consputc>
      consputc(c);
    80000722:	8526                	mv	a0,s1
    80000724:	00000097          	auipc	ra,0x0
    80000728:	b52080e7          	jalr	-1198(ra) # 80000276 <consputc>
      break;
    8000072c:	bdc5                	j	8000061c <printf+0x9a>
  if(locking)
    8000072e:	020d9163          	bnez	s11,80000750 <printf+0x1ce>
}
    80000732:	70e6                	ld	ra,120(sp)
    80000734:	7446                	ld	s0,112(sp)
    80000736:	74a6                	ld	s1,104(sp)
    80000738:	7906                	ld	s2,96(sp)
    8000073a:	69e6                	ld	s3,88(sp)
    8000073c:	6a46                	ld	s4,80(sp)
    8000073e:	6aa6                	ld	s5,72(sp)
    80000740:	6b06                	ld	s6,64(sp)
    80000742:	7be2                	ld	s7,56(sp)
    80000744:	7c42                	ld	s8,48(sp)
    80000746:	7ca2                	ld	s9,40(sp)
    80000748:	7d02                	ld	s10,32(sp)
    8000074a:	6de2                	ld	s11,24(sp)
    8000074c:	6129                	addi	sp,sp,192
    8000074e:	8082                	ret
    release(&pr.lock);
    80000750:	00011517          	auipc	a0,0x11
    80000754:	ad850513          	addi	a0,a0,-1320 # 80011228 <pr>
    80000758:	00000097          	auipc	ra,0x0
    8000075c:	52c080e7          	jalr	1324(ra) # 80000c84 <release>
}
    80000760:	bfc9                	j	80000732 <printf+0x1b0>

0000000080000762 <printfinit>:
    ;
}

void
printfinit(void)
{
    80000762:	1101                	addi	sp,sp,-32
    80000764:	ec06                	sd	ra,24(sp)
    80000766:	e822                	sd	s0,16(sp)
    80000768:	e426                	sd	s1,8(sp)
    8000076a:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    8000076c:	00011497          	auipc	s1,0x11
    80000770:	abc48493          	addi	s1,s1,-1348 # 80011228 <pr>
    80000774:	00008597          	auipc	a1,0x8
    80000778:	8c458593          	addi	a1,a1,-1852 # 80008038 <etext+0x38>
    8000077c:	8526                	mv	a0,s1
    8000077e:	00000097          	auipc	ra,0x0
    80000782:	3c2080e7          	jalr	962(ra) # 80000b40 <initlock>
  pr.locking = 1;
    80000786:	4785                	li	a5,1
    80000788:	cc9c                	sw	a5,24(s1)
}
    8000078a:	60e2                	ld	ra,24(sp)
    8000078c:	6442                	ld	s0,16(sp)
    8000078e:	64a2                	ld	s1,8(sp)
    80000790:	6105                	addi	sp,sp,32
    80000792:	8082                	ret

0000000080000794 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80000794:	1141                	addi	sp,sp,-16
    80000796:	e406                	sd	ra,8(sp)
    80000798:	e022                	sd	s0,0(sp)
    8000079a:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    8000079c:	100007b7          	lui	a5,0x10000
    800007a0:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800007a4:	f8000713          	li	a4,-128
    800007a8:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800007ac:	470d                	li	a4,3
    800007ae:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800007b2:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800007b6:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800007ba:	469d                	li	a3,7
    800007bc:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800007c0:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    800007c4:	00008597          	auipc	a1,0x8
    800007c8:	89458593          	addi	a1,a1,-1900 # 80008058 <digits+0x18>
    800007cc:	00011517          	auipc	a0,0x11
    800007d0:	a7c50513          	addi	a0,a0,-1412 # 80011248 <uart_tx_lock>
    800007d4:	00000097          	auipc	ra,0x0
    800007d8:	36c080e7          	jalr	876(ra) # 80000b40 <initlock>
}
    800007dc:	60a2                	ld	ra,8(sp)
    800007de:	6402                	ld	s0,0(sp)
    800007e0:	0141                	addi	sp,sp,16
    800007e2:	8082                	ret

00000000800007e4 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800007e4:	1101                	addi	sp,sp,-32
    800007e6:	ec06                	sd	ra,24(sp)
    800007e8:	e822                	sd	s0,16(sp)
    800007ea:	e426                	sd	s1,8(sp)
    800007ec:	1000                	addi	s0,sp,32
    800007ee:	84aa                	mv	s1,a0
  push_off();
    800007f0:	00000097          	auipc	ra,0x0
    800007f4:	394080e7          	jalr	916(ra) # 80000b84 <push_off>

  if(panicked){
    800007f8:	00009797          	auipc	a5,0x9
    800007fc:	8087a783          	lw	a5,-2040(a5) # 80009000 <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000800:	10000737          	lui	a4,0x10000
  if(panicked){
    80000804:	c391                	beqz	a5,80000808 <uartputc_sync+0x24>
    for(;;)
    80000806:	a001                	j	80000806 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000808:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000080c:	0207f793          	andi	a5,a5,32
    80000810:	dfe5                	beqz	a5,80000808 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80000812:	0ff4f513          	andi	a0,s1,255
    80000816:	100007b7          	lui	a5,0x10000
    8000081a:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    8000081e:	00000097          	auipc	ra,0x0
    80000822:	406080e7          	jalr	1030(ra) # 80000c24 <pop_off>
}
    80000826:	60e2                	ld	ra,24(sp)
    80000828:	6442                	ld	s0,16(sp)
    8000082a:	64a2                	ld	s1,8(sp)
    8000082c:	6105                	addi	sp,sp,32
    8000082e:	8082                	ret

0000000080000830 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80000830:	00008797          	auipc	a5,0x8
    80000834:	7d87b783          	ld	a5,2008(a5) # 80009008 <uart_tx_r>
    80000838:	00008717          	auipc	a4,0x8
    8000083c:	7d873703          	ld	a4,2008(a4) # 80009010 <uart_tx_w>
    80000840:	06f70a63          	beq	a4,a5,800008b4 <uartstart+0x84>
{
    80000844:	7139                	addi	sp,sp,-64
    80000846:	fc06                	sd	ra,56(sp)
    80000848:	f822                	sd	s0,48(sp)
    8000084a:	f426                	sd	s1,40(sp)
    8000084c:	f04a                	sd	s2,32(sp)
    8000084e:	ec4e                	sd	s3,24(sp)
    80000850:	e852                	sd	s4,16(sp)
    80000852:	e456                	sd	s5,8(sp)
    80000854:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000856:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000085a:	00011a17          	auipc	s4,0x11
    8000085e:	9eea0a13          	addi	s4,s4,-1554 # 80011248 <uart_tx_lock>
    uart_tx_r += 1;
    80000862:	00008497          	auipc	s1,0x8
    80000866:	7a648493          	addi	s1,s1,1958 # 80009008 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    8000086a:	00008997          	auipc	s3,0x8
    8000086e:	7a698993          	addi	s3,s3,1958 # 80009010 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000872:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    80000876:	02077713          	andi	a4,a4,32
    8000087a:	c705                	beqz	a4,800008a2 <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000087c:	01f7f713          	andi	a4,a5,31
    80000880:	9752                	add	a4,a4,s4
    80000882:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    80000886:	0785                	addi	a5,a5,1
    80000888:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    8000088a:	8526                	mv	a0,s1
    8000088c:	00002097          	auipc	ra,0x2
    80000890:	972080e7          	jalr	-1678(ra) # 800021fe <wakeup>
    
    WriteReg(THR, c);
    80000894:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    80000898:	609c                	ld	a5,0(s1)
    8000089a:	0009b703          	ld	a4,0(s3)
    8000089e:	fcf71ae3          	bne	a4,a5,80000872 <uartstart+0x42>
  }
}
    800008a2:	70e2                	ld	ra,56(sp)
    800008a4:	7442                	ld	s0,48(sp)
    800008a6:	74a2                	ld	s1,40(sp)
    800008a8:	7902                	ld	s2,32(sp)
    800008aa:	69e2                	ld	s3,24(sp)
    800008ac:	6a42                	ld	s4,16(sp)
    800008ae:	6aa2                	ld	s5,8(sp)
    800008b0:	6121                	addi	sp,sp,64
    800008b2:	8082                	ret
    800008b4:	8082                	ret

00000000800008b6 <uartputc>:
{
    800008b6:	7179                	addi	sp,sp,-48
    800008b8:	f406                	sd	ra,40(sp)
    800008ba:	f022                	sd	s0,32(sp)
    800008bc:	ec26                	sd	s1,24(sp)
    800008be:	e84a                	sd	s2,16(sp)
    800008c0:	e44e                	sd	s3,8(sp)
    800008c2:	e052                	sd	s4,0(sp)
    800008c4:	1800                	addi	s0,sp,48
    800008c6:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    800008c8:	00011517          	auipc	a0,0x11
    800008cc:	98050513          	addi	a0,a0,-1664 # 80011248 <uart_tx_lock>
    800008d0:	00000097          	auipc	ra,0x0
    800008d4:	300080e7          	jalr	768(ra) # 80000bd0 <acquire>
  if(panicked){
    800008d8:	00008797          	auipc	a5,0x8
    800008dc:	7287a783          	lw	a5,1832(a5) # 80009000 <panicked>
    800008e0:	c391                	beqz	a5,800008e4 <uartputc+0x2e>
    for(;;)
    800008e2:	a001                	j	800008e2 <uartputc+0x2c>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800008e4:	00008717          	auipc	a4,0x8
    800008e8:	72c73703          	ld	a4,1836(a4) # 80009010 <uart_tx_w>
    800008ec:	00008797          	auipc	a5,0x8
    800008f0:	71c7b783          	ld	a5,1820(a5) # 80009008 <uart_tx_r>
    800008f4:	02078793          	addi	a5,a5,32
    800008f8:	02e79b63          	bne	a5,a4,8000092e <uartputc+0x78>
      sleep(&uart_tx_r, &uart_tx_lock);
    800008fc:	00011997          	auipc	s3,0x11
    80000900:	94c98993          	addi	s3,s3,-1716 # 80011248 <uart_tx_lock>
    80000904:	00008497          	auipc	s1,0x8
    80000908:	70448493          	addi	s1,s1,1796 # 80009008 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000090c:	00008917          	auipc	s2,0x8
    80000910:	70490913          	addi	s2,s2,1796 # 80009010 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    80000914:	85ce                	mv	a1,s3
    80000916:	8526                	mv	a0,s1
    80000918:	00001097          	auipc	ra,0x1
    8000091c:	74a080e7          	jalr	1866(ra) # 80002062 <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000920:	00093703          	ld	a4,0(s2)
    80000924:	609c                	ld	a5,0(s1)
    80000926:	02078793          	addi	a5,a5,32
    8000092a:	fee785e3          	beq	a5,a4,80000914 <uartputc+0x5e>
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    8000092e:	00011497          	auipc	s1,0x11
    80000932:	91a48493          	addi	s1,s1,-1766 # 80011248 <uart_tx_lock>
    80000936:	01f77793          	andi	a5,a4,31
    8000093a:	97a6                	add	a5,a5,s1
    8000093c:	01478c23          	sb	s4,24(a5)
      uart_tx_w += 1;
    80000940:	0705                	addi	a4,a4,1
    80000942:	00008797          	auipc	a5,0x8
    80000946:	6ce7b723          	sd	a4,1742(a5) # 80009010 <uart_tx_w>
      uartstart();
    8000094a:	00000097          	auipc	ra,0x0
    8000094e:	ee6080e7          	jalr	-282(ra) # 80000830 <uartstart>
      release(&uart_tx_lock);
    80000952:	8526                	mv	a0,s1
    80000954:	00000097          	auipc	ra,0x0
    80000958:	330080e7          	jalr	816(ra) # 80000c84 <release>
}
    8000095c:	70a2                	ld	ra,40(sp)
    8000095e:	7402                	ld	s0,32(sp)
    80000960:	64e2                	ld	s1,24(sp)
    80000962:	6942                	ld	s2,16(sp)
    80000964:	69a2                	ld	s3,8(sp)
    80000966:	6a02                	ld	s4,0(sp)
    80000968:	6145                	addi	sp,sp,48
    8000096a:	8082                	ret

000000008000096c <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    8000096c:	1141                	addi	sp,sp,-16
    8000096e:	e422                	sd	s0,8(sp)
    80000970:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000972:	100007b7          	lui	a5,0x10000
    80000976:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    8000097a:	8b85                	andi	a5,a5,1
    8000097c:	cb91                	beqz	a5,80000990 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    8000097e:	100007b7          	lui	a5,0x10000
    80000982:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    80000986:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    8000098a:	6422                	ld	s0,8(sp)
    8000098c:	0141                	addi	sp,sp,16
    8000098e:	8082                	ret
    return -1;
    80000990:	557d                	li	a0,-1
    80000992:	bfe5                	j	8000098a <uartgetc+0x1e>

0000000080000994 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    80000994:	1101                	addi	sp,sp,-32
    80000996:	ec06                	sd	ra,24(sp)
    80000998:	e822                	sd	s0,16(sp)
    8000099a:	e426                	sd	s1,8(sp)
    8000099c:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    8000099e:	54fd                	li	s1,-1
    800009a0:	a029                	j	800009aa <uartintr+0x16>
      break;
    consoleintr(c);
    800009a2:	00000097          	auipc	ra,0x0
    800009a6:	916080e7          	jalr	-1770(ra) # 800002b8 <consoleintr>
    int c = uartgetc();
    800009aa:	00000097          	auipc	ra,0x0
    800009ae:	fc2080e7          	jalr	-62(ra) # 8000096c <uartgetc>
    if(c == -1)
    800009b2:	fe9518e3          	bne	a0,s1,800009a2 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800009b6:	00011497          	auipc	s1,0x11
    800009ba:	89248493          	addi	s1,s1,-1902 # 80011248 <uart_tx_lock>
    800009be:	8526                	mv	a0,s1
    800009c0:	00000097          	auipc	ra,0x0
    800009c4:	210080e7          	jalr	528(ra) # 80000bd0 <acquire>
  uartstart();
    800009c8:	00000097          	auipc	ra,0x0
    800009cc:	e68080e7          	jalr	-408(ra) # 80000830 <uartstart>
  release(&uart_tx_lock);
    800009d0:	8526                	mv	a0,s1
    800009d2:	00000097          	auipc	ra,0x0
    800009d6:	2b2080e7          	jalr	690(ra) # 80000c84 <release>
}
    800009da:	60e2                	ld	ra,24(sp)
    800009dc:	6442                	ld	s0,16(sp)
    800009de:	64a2                	ld	s1,8(sp)
    800009e0:	6105                	addi	sp,sp,32
    800009e2:	8082                	ret

00000000800009e4 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    800009e4:	1101                	addi	sp,sp,-32
    800009e6:	ec06                	sd	ra,24(sp)
    800009e8:	e822                	sd	s0,16(sp)
    800009ea:	e426                	sd	s1,8(sp)
    800009ec:	e04a                	sd	s2,0(sp)
    800009ee:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    800009f0:	03451793          	slli	a5,a0,0x34
    800009f4:	ebb9                	bnez	a5,80000a4a <kfree+0x66>
    800009f6:	84aa                	mv	s1,a0
    800009f8:	00025797          	auipc	a5,0x25
    800009fc:	60878793          	addi	a5,a5,1544 # 80026000 <end>
    80000a00:	04f56563          	bltu	a0,a5,80000a4a <kfree+0x66>
    80000a04:	47c5                	li	a5,17
    80000a06:	07ee                	slli	a5,a5,0x1b
    80000a08:	04f57163          	bgeu	a0,a5,80000a4a <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000a0c:	6605                	lui	a2,0x1
    80000a0e:	4585                	li	a1,1
    80000a10:	00000097          	auipc	ra,0x0
    80000a14:	2bc080e7          	jalr	700(ra) # 80000ccc <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000a18:	00011917          	auipc	s2,0x11
    80000a1c:	86890913          	addi	s2,s2,-1944 # 80011280 <kmem>
    80000a20:	854a                	mv	a0,s2
    80000a22:	00000097          	auipc	ra,0x0
    80000a26:	1ae080e7          	jalr	430(ra) # 80000bd0 <acquire>
  r->next = kmem.freelist;
    80000a2a:	01893783          	ld	a5,24(s2)
    80000a2e:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000a30:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000a34:	854a                	mv	a0,s2
    80000a36:	00000097          	auipc	ra,0x0
    80000a3a:	24e080e7          	jalr	590(ra) # 80000c84 <release>
}
    80000a3e:	60e2                	ld	ra,24(sp)
    80000a40:	6442                	ld	s0,16(sp)
    80000a42:	64a2                	ld	s1,8(sp)
    80000a44:	6902                	ld	s2,0(sp)
    80000a46:	6105                	addi	sp,sp,32
    80000a48:	8082                	ret
    panic("kfree");
    80000a4a:	00007517          	auipc	a0,0x7
    80000a4e:	61650513          	addi	a0,a0,1558 # 80008060 <digits+0x20>
    80000a52:	00000097          	auipc	ra,0x0
    80000a56:	ae6080e7          	jalr	-1306(ra) # 80000538 <panic>

0000000080000a5a <freerange>:
{
    80000a5a:	7179                	addi	sp,sp,-48
    80000a5c:	f406                	sd	ra,40(sp)
    80000a5e:	f022                	sd	s0,32(sp)
    80000a60:	ec26                	sd	s1,24(sp)
    80000a62:	e84a                	sd	s2,16(sp)
    80000a64:	e44e                	sd	s3,8(sp)
    80000a66:	e052                	sd	s4,0(sp)
    80000a68:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    80000a6a:	6785                	lui	a5,0x1
    80000a6c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80000a70:	94aa                	add	s1,s1,a0
    80000a72:	757d                	lui	a0,0xfffff
    80000a74:	8ce9                	and	s1,s1,a0
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a76:	94be                	add	s1,s1,a5
    80000a78:	0095ee63          	bltu	a1,s1,80000a94 <freerange+0x3a>
    80000a7c:	892e                	mv	s2,a1
    kfree(p);
    80000a7e:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a80:	6985                	lui	s3,0x1
    kfree(p);
    80000a82:	01448533          	add	a0,s1,s4
    80000a86:	00000097          	auipc	ra,0x0
    80000a8a:	f5e080e7          	jalr	-162(ra) # 800009e4 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a8e:	94ce                	add	s1,s1,s3
    80000a90:	fe9979e3          	bgeu	s2,s1,80000a82 <freerange+0x28>
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
    80000ad4:	f8a080e7          	jalr	-118(ra) # 80000a5a <freerange>
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
    80000c20:	91c080e7          	jalr	-1764(ra) # 80000538 <panic>

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
    80000c70:	8cc080e7          	jalr	-1844(ra) # 80000538 <panic>
    panic("pop_off");
    80000c74:	00007517          	auipc	a0,0x7
    80000c78:	41c50513          	addi	a0,a0,1052 # 80008090 <digits+0x50>
    80000c7c:	00000097          	auipc	ra,0x0
    80000c80:	8bc080e7          	jalr	-1860(ra) # 80000538 <panic>

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
    80000cc8:	874080e7          	jalr	-1932(ra) # 80000538 <panic>

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
    80000d46:	fed70fa3          	sb	a3,-1(a4)
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
    80000e02:	fff6c793          	not	a5,a3
    80000e06:	9fb9                	addw	a5,a5,a4
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
    80000eac:	6da080e7          	jalr	1754(ra) # 80000582 <printf>
    kvminithart();    // turn on paging
    80000eb0:	00000097          	auipc	ra,0x0
    80000eb4:	0d8080e7          	jalr	216(ra) # 80000f88 <kvminithart>
    trapinithart();   // install kernel trap vector
    80000eb8:	00002097          	auipc	ra,0x2
    80000ebc:	a00080e7          	jalr	-1536(ra) # 800028b8 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000ec0:	00005097          	auipc	ra,0x5
    80000ec4:	ff0080e7          	jalr	-16(ra) # 80005eb0 <plicinithart>
  }

  scheduler();        
    80000ec8:	00001097          	auipc	ra,0x1
    80000ecc:	fe8080e7          	jalr	-24(ra) # 80001eb0 <scheduler>
    consoleinit();
    80000ed0:	fffff097          	auipc	ra,0xfffff
    80000ed4:	57a080e7          	jalr	1402(ra) # 8000044a <consoleinit>
    printfinit();
    80000ed8:	00000097          	auipc	ra,0x0
    80000edc:	88a080e7          	jalr	-1910(ra) # 80000762 <printfinit>
    printf("\n");
    80000ee0:	00007517          	auipc	a0,0x7
    80000ee4:	1e850513          	addi	a0,a0,488 # 800080c8 <digits+0x88>
    80000ee8:	fffff097          	auipc	ra,0xfffff
    80000eec:	69a080e7          	jalr	1690(ra) # 80000582 <printf>
    printf("xv6 kernel is booting\n");
    80000ef0:	00007517          	auipc	a0,0x7
    80000ef4:	1b050513          	addi	a0,a0,432 # 800080a0 <digits+0x60>
    80000ef8:	fffff097          	auipc	ra,0xfffff
    80000efc:	68a080e7          	jalr	1674(ra) # 80000582 <printf>
    printf("\n");
    80000f00:	00007517          	auipc	a0,0x7
    80000f04:	1c850513          	addi	a0,a0,456 # 800080c8 <digits+0x88>
    80000f08:	fffff097          	auipc	ra,0xfffff
    80000f0c:	67a080e7          	jalr	1658(ra) # 80000582 <printf>
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
    80000f30:	00002097          	auipc	ra,0x2
    80000f34:	960080e7          	jalr	-1696(ra) # 80002890 <trapinit>
    trapinithart();  // install kernel trap vector
    80000f38:	00002097          	auipc	ra,0x2
    80000f3c:	980080e7          	jalr	-1664(ra) # 800028b8 <trapinithart>
    plicinit();      // set up interrupt controller
    80000f40:	00005097          	auipc	ra,0x5
    80000f44:	f5a080e7          	jalr	-166(ra) # 80005e9a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000f48:	00005097          	auipc	ra,0x5
    80000f4c:	f68080e7          	jalr	-152(ra) # 80005eb0 <plicinithart>
    binit();         // buffer cache
    80000f50:	00002097          	auipc	ra,0x2
    80000f54:	13e080e7          	jalr	318(ra) # 8000308e <binit>
    iinit();         // inode table
    80000f58:	00002097          	auipc	ra,0x2
    80000f5c:	7ce080e7          	jalr	1998(ra) # 80003726 <iinit>
    fileinit();      // file table
    80000f60:	00003097          	auipc	ra,0x3
    80000f64:	778080e7          	jalr	1912(ra) # 800046d8 <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000f68:	00005097          	auipc	ra,0x5
    80000f6c:	06a080e7          	jalr	106(ra) # 80005fd2 <virtio_disk_init>
    userinit();      // first user process
    80000f70:	00001097          	auipc	ra,0x1
    80000f74:	d0a080e7          	jalr	-758(ra) # 80001c7a <userinit>
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
    80000fde:	55e080e7          	jalr	1374(ra) # 80000538 <panic>
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
    80001088:	00a7d513          	srli	a0,a5,0xa
    8000108c:	0532                	slli	a0,a0,0xc
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
    800010b0:	77fd                	lui	a5,0xfffff
    800010b2:	00f5fa33          	and	s4,a1,a5
  last = PGROUNDDOWN(va + size - 1);
    800010b6:	15fd                	addi	a1,a1,-1
    800010b8:	00c589b3          	add	s3,a1,a2
    800010bc:	00f9f9b3          	and	s3,s3,a5
  a = PGROUNDDOWN(va);
    800010c0:	8952                	mv	s2,s4
    800010c2:	41468a33          	sub	s4,a3,s4
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
    80001104:	438080e7          	jalr	1080(ra) # 80000538 <panic>
      panic("mappages: remap");
    80001108:	00007517          	auipc	a0,0x7
    8000110c:	fe050513          	addi	a0,a0,-32 # 800080e8 <digits+0xa8>
    80001110:	fffff097          	auipc	ra,0xfffff
    80001114:	428080e7          	jalr	1064(ra) # 80000538 <panic>
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
    80001160:	3dc080e7          	jalr	988(ra) # 80000538 <panic>

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
    800012ac:	290080e7          	jalr	656(ra) # 80000538 <panic>
      panic("uvmunmap: walk");
    800012b0:	00007517          	auipc	a0,0x7
    800012b4:	e6850513          	addi	a0,a0,-408 # 80008118 <digits+0xd8>
    800012b8:	fffff097          	auipc	ra,0xfffff
    800012bc:	280080e7          	jalr	640(ra) # 80000538 <panic>
      panic("uvmunmap: not mapped");
    800012c0:	00007517          	auipc	a0,0x7
    800012c4:	e6850513          	addi	a0,a0,-408 # 80008128 <digits+0xe8>
    800012c8:	fffff097          	auipc	ra,0xfffff
    800012cc:	270080e7          	jalr	624(ra) # 80000538 <panic>
      panic("uvmunmap: not a leaf");
    800012d0:	00007517          	auipc	a0,0x7
    800012d4:	e7050513          	addi	a0,a0,-400 # 80008140 <digits+0x100>
    800012d8:	fffff097          	auipc	ra,0xfffff
    800012dc:	260080e7          	jalr	608(ra) # 80000538 <panic>
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
    80001318:	6d0080e7          	jalr	1744(ra) # 800009e4 <kfree>
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
    800013ba:	182080e7          	jalr	386(ra) # 80000538 <panic>

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
    800013d8:	767d                	lui	a2,0xfffff
    800013da:	8f71                	and	a4,a4,a2
    800013dc:	97ae                	add	a5,a5,a1
    800013de:	8ff1                	and	a5,a5,a2
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
    80001420:	6985                	lui	s3,0x1
    80001422:	19fd                	addi	s3,s3,-1
    80001424:	95ce                	add	a1,a1,s3
    80001426:	79fd                	lui	s3,0xfffff
    80001428:	0135f9b3          	and	s3,a1,s3
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
    80001492:	556080e7          	jalr	1366(ra) # 800009e4 <kfree>
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
    800014ca:	a821                	j	800014e2 <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800014cc:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    800014ce:	0532                	slli	a0,a0,0xc
    800014d0:	00000097          	auipc	ra,0x0
    800014d4:	fe0080e7          	jalr	-32(ra) # 800014b0 <freewalk>
      pagetable[i] = 0;
    800014d8:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    800014dc:	04a1                	addi	s1,s1,8
    800014de:	03248163          	beq	s1,s2,80001500 <freewalk+0x50>
    pte_t pte = pagetable[i];
    800014e2:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800014e4:	00f57793          	andi	a5,a0,15
    800014e8:	ff3782e3          	beq	a5,s3,800014cc <freewalk+0x1c>
    } else if(pte & PTE_V){
    800014ec:	8905                	andi	a0,a0,1
    800014ee:	d57d                	beqz	a0,800014dc <freewalk+0x2c>
      panic("freewalk: leaf");
    800014f0:	00007517          	auipc	a0,0x7
    800014f4:	c8850513          	addi	a0,a0,-888 # 80008178 <digits+0x138>
    800014f8:	fffff097          	auipc	ra,0xfffff
    800014fc:	040080e7          	jalr	64(ra) # 80000538 <panic>
    }
  }
  kfree((void*)pagetable);
    80001500:	8552                	mv	a0,s4
    80001502:	fffff097          	auipc	ra,0xfffff
    80001506:	4e2080e7          	jalr	1250(ra) # 800009e4 <kfree>
}
    8000150a:	70a2                	ld	ra,40(sp)
    8000150c:	7402                	ld	s0,32(sp)
    8000150e:	64e2                	ld	s1,24(sp)
    80001510:	6942                	ld	s2,16(sp)
    80001512:	69a2                	ld	s3,8(sp)
    80001514:	6a02                	ld	s4,0(sp)
    80001516:	6145                	addi	sp,sp,48
    80001518:	8082                	ret

000000008000151a <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    8000151a:	1101                	addi	sp,sp,-32
    8000151c:	ec06                	sd	ra,24(sp)
    8000151e:	e822                	sd	s0,16(sp)
    80001520:	e426                	sd	s1,8(sp)
    80001522:	1000                	addi	s0,sp,32
    80001524:	84aa                	mv	s1,a0
  if(sz > 0)
    80001526:	e999                	bnez	a1,8000153c <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80001528:	8526                	mv	a0,s1
    8000152a:	00000097          	auipc	ra,0x0
    8000152e:	f86080e7          	jalr	-122(ra) # 800014b0 <freewalk>
}
    80001532:	60e2                	ld	ra,24(sp)
    80001534:	6442                	ld	s0,16(sp)
    80001536:	64a2                	ld	s1,8(sp)
    80001538:	6105                	addi	sp,sp,32
    8000153a:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    8000153c:	6605                	lui	a2,0x1
    8000153e:	167d                	addi	a2,a2,-1
    80001540:	962e                	add	a2,a2,a1
    80001542:	4685                	li	a3,1
    80001544:	8231                	srli	a2,a2,0xc
    80001546:	4581                	li	a1,0
    80001548:	00000097          	auipc	ra,0x0
    8000154c:	d12080e7          	jalr	-750(ra) # 8000125a <uvmunmap>
    80001550:	bfe1                	j	80001528 <uvmfree+0xe>

0000000080001552 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80001552:	c679                	beqz	a2,80001620 <uvmcopy+0xce>
{
    80001554:	715d                	addi	sp,sp,-80
    80001556:	e486                	sd	ra,72(sp)
    80001558:	e0a2                	sd	s0,64(sp)
    8000155a:	fc26                	sd	s1,56(sp)
    8000155c:	f84a                	sd	s2,48(sp)
    8000155e:	f44e                	sd	s3,40(sp)
    80001560:	f052                	sd	s4,32(sp)
    80001562:	ec56                	sd	s5,24(sp)
    80001564:	e85a                	sd	s6,16(sp)
    80001566:	e45e                	sd	s7,8(sp)
    80001568:	0880                	addi	s0,sp,80
    8000156a:	8b2a                	mv	s6,a0
    8000156c:	8aae                	mv	s5,a1
    8000156e:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80001570:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80001572:	4601                	li	a2,0
    80001574:	85ce                	mv	a1,s3
    80001576:	855a                	mv	a0,s6
    80001578:	00000097          	auipc	ra,0x0
    8000157c:	a34080e7          	jalr	-1484(ra) # 80000fac <walk>
    80001580:	c531                	beqz	a0,800015cc <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80001582:	6118                	ld	a4,0(a0)
    80001584:	00177793          	andi	a5,a4,1
    80001588:	cbb1                	beqz	a5,800015dc <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    8000158a:	00a75593          	srli	a1,a4,0xa
    8000158e:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80001592:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80001596:	fffff097          	auipc	ra,0xfffff
    8000159a:	54a080e7          	jalr	1354(ra) # 80000ae0 <kalloc>
    8000159e:	892a                	mv	s2,a0
    800015a0:	c939                	beqz	a0,800015f6 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    800015a2:	6605                	lui	a2,0x1
    800015a4:	85de                	mv	a1,s7
    800015a6:	fffff097          	auipc	ra,0xfffff
    800015aa:	782080e7          	jalr	1922(ra) # 80000d28 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    800015ae:	8726                	mv	a4,s1
    800015b0:	86ca                	mv	a3,s2
    800015b2:	6605                	lui	a2,0x1
    800015b4:	85ce                	mv	a1,s3
    800015b6:	8556                	mv	a0,s5
    800015b8:	00000097          	auipc	ra,0x0
    800015bc:	adc080e7          	jalr	-1316(ra) # 80001094 <mappages>
    800015c0:	e515                	bnez	a0,800015ec <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    800015c2:	6785                	lui	a5,0x1
    800015c4:	99be                	add	s3,s3,a5
    800015c6:	fb49e6e3          	bltu	s3,s4,80001572 <uvmcopy+0x20>
    800015ca:	a081                	j	8000160a <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    800015cc:	00007517          	auipc	a0,0x7
    800015d0:	bbc50513          	addi	a0,a0,-1092 # 80008188 <digits+0x148>
    800015d4:	fffff097          	auipc	ra,0xfffff
    800015d8:	f64080e7          	jalr	-156(ra) # 80000538 <panic>
      panic("uvmcopy: page not present");
    800015dc:	00007517          	auipc	a0,0x7
    800015e0:	bcc50513          	addi	a0,a0,-1076 # 800081a8 <digits+0x168>
    800015e4:	fffff097          	auipc	ra,0xfffff
    800015e8:	f54080e7          	jalr	-172(ra) # 80000538 <panic>
      kfree(mem);
    800015ec:	854a                	mv	a0,s2
    800015ee:	fffff097          	auipc	ra,0xfffff
    800015f2:	3f6080e7          	jalr	1014(ra) # 800009e4 <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    800015f6:	4685                	li	a3,1
    800015f8:	00c9d613          	srli	a2,s3,0xc
    800015fc:	4581                	li	a1,0
    800015fe:	8556                	mv	a0,s5
    80001600:	00000097          	auipc	ra,0x0
    80001604:	c5a080e7          	jalr	-934(ra) # 8000125a <uvmunmap>
  return -1;
    80001608:	557d                	li	a0,-1
}
    8000160a:	60a6                	ld	ra,72(sp)
    8000160c:	6406                	ld	s0,64(sp)
    8000160e:	74e2                	ld	s1,56(sp)
    80001610:	7942                	ld	s2,48(sp)
    80001612:	79a2                	ld	s3,40(sp)
    80001614:	7a02                	ld	s4,32(sp)
    80001616:	6ae2                	ld	s5,24(sp)
    80001618:	6b42                	ld	s6,16(sp)
    8000161a:	6ba2                	ld	s7,8(sp)
    8000161c:	6161                	addi	sp,sp,80
    8000161e:	8082                	ret
  return 0;
    80001620:	4501                	li	a0,0
}
    80001622:	8082                	ret

0000000080001624 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80001624:	1141                	addi	sp,sp,-16
    80001626:	e406                	sd	ra,8(sp)
    80001628:	e022                	sd	s0,0(sp)
    8000162a:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    8000162c:	4601                	li	a2,0
    8000162e:	00000097          	auipc	ra,0x0
    80001632:	97e080e7          	jalr	-1666(ra) # 80000fac <walk>
  if(pte == 0)
    80001636:	c901                	beqz	a0,80001646 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80001638:	611c                	ld	a5,0(a0)
    8000163a:	9bbd                	andi	a5,a5,-17
    8000163c:	e11c                	sd	a5,0(a0)
}
    8000163e:	60a2                	ld	ra,8(sp)
    80001640:	6402                	ld	s0,0(sp)
    80001642:	0141                	addi	sp,sp,16
    80001644:	8082                	ret
    panic("uvmclear");
    80001646:	00007517          	auipc	a0,0x7
    8000164a:	b8250513          	addi	a0,a0,-1150 # 800081c8 <digits+0x188>
    8000164e:	fffff097          	auipc	ra,0xfffff
    80001652:	eea080e7          	jalr	-278(ra) # 80000538 <panic>

0000000080001656 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80001656:	c6bd                	beqz	a3,800016c4 <copyout+0x6e>
{
    80001658:	715d                	addi	sp,sp,-80
    8000165a:	e486                	sd	ra,72(sp)
    8000165c:	e0a2                	sd	s0,64(sp)
    8000165e:	fc26                	sd	s1,56(sp)
    80001660:	f84a                	sd	s2,48(sp)
    80001662:	f44e                	sd	s3,40(sp)
    80001664:	f052                	sd	s4,32(sp)
    80001666:	ec56                	sd	s5,24(sp)
    80001668:	e85a                	sd	s6,16(sp)
    8000166a:	e45e                	sd	s7,8(sp)
    8000166c:	e062                	sd	s8,0(sp)
    8000166e:	0880                	addi	s0,sp,80
    80001670:	8b2a                	mv	s6,a0
    80001672:	8c2e                	mv	s8,a1
    80001674:	8a32                	mv	s4,a2
    80001676:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80001678:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    8000167a:	6a85                	lui	s5,0x1
    8000167c:	a015                	j	800016a0 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    8000167e:	9562                	add	a0,a0,s8
    80001680:	0004861b          	sext.w	a2,s1
    80001684:	85d2                	mv	a1,s4
    80001686:	41250533          	sub	a0,a0,s2
    8000168a:	fffff097          	auipc	ra,0xfffff
    8000168e:	69e080e7          	jalr	1694(ra) # 80000d28 <memmove>

    len -= n;
    80001692:	409989b3          	sub	s3,s3,s1
    src += n;
    80001696:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80001698:	01590c33          	add	s8,s2,s5
  while(len > 0){
    8000169c:	02098263          	beqz	s3,800016c0 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    800016a0:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    800016a4:	85ca                	mv	a1,s2
    800016a6:	855a                	mv	a0,s6
    800016a8:	00000097          	auipc	ra,0x0
    800016ac:	9aa080e7          	jalr	-1622(ra) # 80001052 <walkaddr>
    if(pa0 == 0)
    800016b0:	cd01                	beqz	a0,800016c8 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    800016b2:	418904b3          	sub	s1,s2,s8
    800016b6:	94d6                	add	s1,s1,s5
    if(n > len)
    800016b8:	fc99f3e3          	bgeu	s3,s1,8000167e <copyout+0x28>
    800016bc:	84ce                	mv	s1,s3
    800016be:	b7c1                	j	8000167e <copyout+0x28>
  }
  return 0;
    800016c0:	4501                	li	a0,0
    800016c2:	a021                	j	800016ca <copyout+0x74>
    800016c4:	4501                	li	a0,0
}
    800016c6:	8082                	ret
      return -1;
    800016c8:	557d                	li	a0,-1
}
    800016ca:	60a6                	ld	ra,72(sp)
    800016cc:	6406                	ld	s0,64(sp)
    800016ce:	74e2                	ld	s1,56(sp)
    800016d0:	7942                	ld	s2,48(sp)
    800016d2:	79a2                	ld	s3,40(sp)
    800016d4:	7a02                	ld	s4,32(sp)
    800016d6:	6ae2                	ld	s5,24(sp)
    800016d8:	6b42                	ld	s6,16(sp)
    800016da:	6ba2                	ld	s7,8(sp)
    800016dc:	6c02                	ld	s8,0(sp)
    800016de:	6161                	addi	sp,sp,80
    800016e0:	8082                	ret

00000000800016e2 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    800016e2:	caa5                	beqz	a3,80001752 <copyin+0x70>
{
    800016e4:	715d                	addi	sp,sp,-80
    800016e6:	e486                	sd	ra,72(sp)
    800016e8:	e0a2                	sd	s0,64(sp)
    800016ea:	fc26                	sd	s1,56(sp)
    800016ec:	f84a                	sd	s2,48(sp)
    800016ee:	f44e                	sd	s3,40(sp)
    800016f0:	f052                	sd	s4,32(sp)
    800016f2:	ec56                	sd	s5,24(sp)
    800016f4:	e85a                	sd	s6,16(sp)
    800016f6:	e45e                	sd	s7,8(sp)
    800016f8:	e062                	sd	s8,0(sp)
    800016fa:	0880                	addi	s0,sp,80
    800016fc:	8b2a                	mv	s6,a0
    800016fe:	8a2e                	mv	s4,a1
    80001700:	8c32                	mv	s8,a2
    80001702:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80001704:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80001706:	6a85                	lui	s5,0x1
    80001708:	a01d                	j	8000172e <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    8000170a:	018505b3          	add	a1,a0,s8
    8000170e:	0004861b          	sext.w	a2,s1
    80001712:	412585b3          	sub	a1,a1,s2
    80001716:	8552                	mv	a0,s4
    80001718:	fffff097          	auipc	ra,0xfffff
    8000171c:	610080e7          	jalr	1552(ra) # 80000d28 <memmove>

    len -= n;
    80001720:	409989b3          	sub	s3,s3,s1
    dst += n;
    80001724:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80001726:	01590c33          	add	s8,s2,s5
  while(len > 0){
    8000172a:	02098263          	beqz	s3,8000174e <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    8000172e:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80001732:	85ca                	mv	a1,s2
    80001734:	855a                	mv	a0,s6
    80001736:	00000097          	auipc	ra,0x0
    8000173a:	91c080e7          	jalr	-1764(ra) # 80001052 <walkaddr>
    if(pa0 == 0)
    8000173e:	cd01                	beqz	a0,80001756 <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80001740:	418904b3          	sub	s1,s2,s8
    80001744:	94d6                	add	s1,s1,s5
    if(n > len)
    80001746:	fc99f2e3          	bgeu	s3,s1,8000170a <copyin+0x28>
    8000174a:	84ce                	mv	s1,s3
    8000174c:	bf7d                	j	8000170a <copyin+0x28>
  }
  return 0;
    8000174e:	4501                	li	a0,0
    80001750:	a021                	j	80001758 <copyin+0x76>
    80001752:	4501                	li	a0,0
}
    80001754:	8082                	ret
      return -1;
    80001756:	557d                	li	a0,-1
}
    80001758:	60a6                	ld	ra,72(sp)
    8000175a:	6406                	ld	s0,64(sp)
    8000175c:	74e2                	ld	s1,56(sp)
    8000175e:	7942                	ld	s2,48(sp)
    80001760:	79a2                	ld	s3,40(sp)
    80001762:	7a02                	ld	s4,32(sp)
    80001764:	6ae2                	ld	s5,24(sp)
    80001766:	6b42                	ld	s6,16(sp)
    80001768:	6ba2                	ld	s7,8(sp)
    8000176a:	6c02                	ld	s8,0(sp)
    8000176c:	6161                	addi	sp,sp,80
    8000176e:	8082                	ret

0000000080001770 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80001770:	c6c5                	beqz	a3,80001818 <copyinstr+0xa8>
{
    80001772:	715d                	addi	sp,sp,-80
    80001774:	e486                	sd	ra,72(sp)
    80001776:	e0a2                	sd	s0,64(sp)
    80001778:	fc26                	sd	s1,56(sp)
    8000177a:	f84a                	sd	s2,48(sp)
    8000177c:	f44e                	sd	s3,40(sp)
    8000177e:	f052                	sd	s4,32(sp)
    80001780:	ec56                	sd	s5,24(sp)
    80001782:	e85a                	sd	s6,16(sp)
    80001784:	e45e                	sd	s7,8(sp)
    80001786:	0880                	addi	s0,sp,80
    80001788:	8a2a                	mv	s4,a0
    8000178a:	8b2e                	mv	s6,a1
    8000178c:	8bb2                	mv	s7,a2
    8000178e:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80001790:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80001792:	6985                	lui	s3,0x1
    80001794:	a035                	j	800017c0 <copyinstr+0x50>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80001796:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    8000179a:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    8000179c:	0017b793          	seqz	a5,a5
    800017a0:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    800017a4:	60a6                	ld	ra,72(sp)
    800017a6:	6406                	ld	s0,64(sp)
    800017a8:	74e2                	ld	s1,56(sp)
    800017aa:	7942                	ld	s2,48(sp)
    800017ac:	79a2                	ld	s3,40(sp)
    800017ae:	7a02                	ld	s4,32(sp)
    800017b0:	6ae2                	ld	s5,24(sp)
    800017b2:	6b42                	ld	s6,16(sp)
    800017b4:	6ba2                	ld	s7,8(sp)
    800017b6:	6161                	addi	sp,sp,80
    800017b8:	8082                	ret
    srcva = va0 + PGSIZE;
    800017ba:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    800017be:	c8a9                	beqz	s1,80001810 <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    800017c0:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    800017c4:	85ca                	mv	a1,s2
    800017c6:	8552                	mv	a0,s4
    800017c8:	00000097          	auipc	ra,0x0
    800017cc:	88a080e7          	jalr	-1910(ra) # 80001052 <walkaddr>
    if(pa0 == 0)
    800017d0:	c131                	beqz	a0,80001814 <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    800017d2:	41790833          	sub	a6,s2,s7
    800017d6:	984e                	add	a6,a6,s3
    if(n > max)
    800017d8:	0104f363          	bgeu	s1,a6,800017de <copyinstr+0x6e>
    800017dc:	8826                	mv	a6,s1
    char *p = (char *) (pa0 + (srcva - va0));
    800017de:	955e                	add	a0,a0,s7
    800017e0:	41250533          	sub	a0,a0,s2
    while(n > 0){
    800017e4:	fc080be3          	beqz	a6,800017ba <copyinstr+0x4a>
    800017e8:	985a                	add	a6,a6,s6
    800017ea:	87da                	mv	a5,s6
      if(*p == '\0'){
    800017ec:	41650633          	sub	a2,a0,s6
    800017f0:	14fd                	addi	s1,s1,-1
    800017f2:	9b26                	add	s6,s6,s1
    800017f4:	00f60733          	add	a4,a2,a5
    800017f8:	00074703          	lbu	a4,0(a4)
    800017fc:	df49                	beqz	a4,80001796 <copyinstr+0x26>
        *dst = *p;
    800017fe:	00e78023          	sb	a4,0(a5)
      --max;
    80001802:	40fb04b3          	sub	s1,s6,a5
      dst++;
    80001806:	0785                	addi	a5,a5,1
    while(n > 0){
    80001808:	ff0796e3          	bne	a5,a6,800017f4 <copyinstr+0x84>
      dst++;
    8000180c:	8b42                	mv	s6,a6
    8000180e:	b775                	j	800017ba <copyinstr+0x4a>
    80001810:	4781                	li	a5,0
    80001812:	b769                	j	8000179c <copyinstr+0x2c>
      return -1;
    80001814:	557d                	li	a0,-1
    80001816:	b779                	j	800017a4 <copyinstr+0x34>
  int got_null = 0;
    80001818:	4781                	li	a5,0
  if(got_null){
    8000181a:	0017b793          	seqz	a5,a5
    8000181e:	40f00533          	neg	a0,a5
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
    80001858:	e7ca0a13          	addi	s4,s4,-388 # 800176d0 <tickslock>
    char *pa = kalloc();
    8000185c:	fffff097          	auipc	ra,0xfffff
    80001860:	284080e7          	jalr	644(ra) # 80000ae0 <kalloc>
    80001864:	862a                	mv	a2,a0
    if(pa == 0)
    80001866:	c131                	beqz	a0,800018aa <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80001868:	416485b3          	sub	a1,s1,s6
    8000186c:	859d                	srai	a1,a1,0x7
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
    8000188e:	18048493          	addi	s1,s1,384
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
    800018b6:	c86080e7          	jalr	-890(ra) # 80000538 <panic>

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
    80001924:	db098993          	addi	s3,s3,-592 # 800176d0 <tickslock>
      initlock(&p->lock, "proc");
    80001928:	85da                	mv	a1,s6
    8000192a:	8526                	mv	a0,s1
    8000192c:	fffff097          	auipc	ra,0xfffff
    80001930:	214080e7          	jalr	532(ra) # 80000b40 <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80001934:	415487b3          	sub	a5,s1,s5
    80001938:	879d                	srai	a5,a5,0x7
    8000193a:	000a3703          	ld	a4,0(s4)
    8000193e:	02e787b3          	mul	a5,a5,a4
    80001942:	2785                	addiw	a5,a5,1
    80001944:	00d7979b          	slliw	a5,a5,0xd
    80001948:	40f907b3          	sub	a5,s2,a5
    8000194c:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    8000194e:	18048493          	addi	s1,s1,384
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
    800019ea:	e8a7a783          	lw	a5,-374(a5) # 80008870 <first.1>
    800019ee:	eb89                	bnez	a5,80001a00 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    800019f0:	00001097          	auipc	ra,0x1
    800019f4:	ee0080e7          	jalr	-288(ra) # 800028d0 <usertrapret>
}
    800019f8:	60a2                	ld	ra,8(sp)
    800019fa:	6402                	ld	s0,0(sp)
    800019fc:	0141                	addi	sp,sp,16
    800019fe:	8082                	ret
    first = 0;
    80001a00:	00007797          	auipc	a5,0x7
    80001a04:	e607a823          	sw	zero,-400(a5) # 80008870 <first.1>
    fsinit(ROOTDEV);
    80001a08:	4505                	li	a0,1
    80001a0a:	00002097          	auipc	ra,0x2
    80001a0e:	c9c080e7          	jalr	-868(ra) # 800036a6 <fsinit>
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
    80001a36:	e4278793          	addi	a5,a5,-446 # 80008874 <nextpid>
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
    80001a96:	05893683          	ld	a3,88(s2)
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
    80001ac8:	a56080e7          	jalr	-1450(ra) # 8000151a <uvmfree>
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
    80001aee:	a30080e7          	jalr	-1488(ra) # 8000151a <uvmfree>
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
    80001b38:	9e6080e7          	jalr	-1562(ra) # 8000151a <uvmfree>
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
    80001b54:	6d28                	ld	a0,88(a0)
    80001b56:	c509                	beqz	a0,80001b60 <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001b58:	fffff097          	auipc	ra,0xfffff
    80001b5c:	e8c080e7          	jalr	-372(ra) # 800009e4 <kfree>
  p->trapframe = 0;
    80001b60:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80001b64:	68a8                	ld	a0,80(s1)
    80001b66:	c511                	beqz	a0,80001b72 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001b68:	64ac                	ld	a1,72(s1)
    80001b6a:	00000097          	auipc	ra,0x0
    80001b6e:	f8c080e7          	jalr	-116(ra) # 80001af6 <proc_freepagetable>
  p->pagetable = 0;
    80001b72:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001b76:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001b7a:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001b7e:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80001b82:	14048c23          	sb	zero,344(s1)
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
    80001bb8:	b1c90913          	addi	s2,s2,-1252 # 800176d0 <tickslock>
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
    80001bd4:	18048493          	addi	s1,s1,384
    80001bd8:	ff2492e3          	bne	s1,s2,80001bbc <allocproc+0x1c>
  return 0;
    80001bdc:	4481                	li	s1,0
    80001bde:	a8b9                	j	80001c3c <allocproc+0x9c>
  p->pid = allocpid();
    80001be0:	00000097          	auipc	ra,0x0
    80001be4:	e34080e7          	jalr	-460(ra) # 80001a14 <allocpid>
    80001be8:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001bea:	4785                	li	a5,1
    80001bec:	cc9c                	sw	a5,24(s1)
  p->bottom_ustack = 0;
    80001bee:	1604b823          	sd	zero,368(s1)
  p->top_ustack = 0;
    80001bf2:	1604b423          	sd	zero,360(s1)
  p->referencias = 1;
    80001bf6:	16f4ac23          	sw	a5,376(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001bfa:	fffff097          	auipc	ra,0xfffff
    80001bfe:	ee6080e7          	jalr	-282(ra) # 80000ae0 <kalloc>
    80001c02:	892a                	mv	s2,a0
    80001c04:	eca8                	sd	a0,88(s1)
    80001c06:	c131                	beqz	a0,80001c4a <allocproc+0xaa>
  p->pagetable = proc_pagetable(p);
    80001c08:	8526                	mv	a0,s1
    80001c0a:	00000097          	auipc	ra,0x0
    80001c0e:	e50080e7          	jalr	-432(ra) # 80001a5a <proc_pagetable>
    80001c12:	892a                	mv	s2,a0
    80001c14:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    80001c16:	c531                	beqz	a0,80001c62 <allocproc+0xc2>
  memset(&p->context, 0, sizeof(p->context));
    80001c18:	07000613          	li	a2,112
    80001c1c:	4581                	li	a1,0
    80001c1e:	06048513          	addi	a0,s1,96
    80001c22:	fffff097          	auipc	ra,0xfffff
    80001c26:	0aa080e7          	jalr	170(ra) # 80000ccc <memset>
  p->context.ra = (uint64)forkret;
    80001c2a:	00000797          	auipc	a5,0x0
    80001c2e:	da478793          	addi	a5,a5,-604 # 800019ce <forkret>
    80001c32:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001c34:	60bc                	ld	a5,64(s1)
    80001c36:	6705                	lui	a4,0x1
    80001c38:	97ba                	add	a5,a5,a4
    80001c3a:	f4bc                	sd	a5,104(s1)
}
    80001c3c:	8526                	mv	a0,s1
    80001c3e:	60e2                	ld	ra,24(sp)
    80001c40:	6442                	ld	s0,16(sp)
    80001c42:	64a2                	ld	s1,8(sp)
    80001c44:	6902                	ld	s2,0(sp)
    80001c46:	6105                	addi	sp,sp,32
    80001c48:	8082                	ret
    freeproc(p);
    80001c4a:	8526                	mv	a0,s1
    80001c4c:	00000097          	auipc	ra,0x0
    80001c50:	efc080e7          	jalr	-260(ra) # 80001b48 <freeproc>
    release(&p->lock);
    80001c54:	8526                	mv	a0,s1
    80001c56:	fffff097          	auipc	ra,0xfffff
    80001c5a:	02e080e7          	jalr	46(ra) # 80000c84 <release>
    return 0;
    80001c5e:	84ca                	mv	s1,s2
    80001c60:	bff1                	j	80001c3c <allocproc+0x9c>
    freeproc(p);
    80001c62:	8526                	mv	a0,s1
    80001c64:	00000097          	auipc	ra,0x0
    80001c68:	ee4080e7          	jalr	-284(ra) # 80001b48 <freeproc>
    release(&p->lock);
    80001c6c:	8526                	mv	a0,s1
    80001c6e:	fffff097          	auipc	ra,0xfffff
    80001c72:	016080e7          	jalr	22(ra) # 80000c84 <release>
    return 0;
    80001c76:	84ca                	mv	s1,s2
    80001c78:	b7d1                	j	80001c3c <allocproc+0x9c>

0000000080001c7a <userinit>:
{
    80001c7a:	1101                	addi	sp,sp,-32
    80001c7c:	ec06                	sd	ra,24(sp)
    80001c7e:	e822                	sd	s0,16(sp)
    80001c80:	e426                	sd	s1,8(sp)
    80001c82:	1000                	addi	s0,sp,32
  p = allocproc();
    80001c84:	00000097          	auipc	ra,0x0
    80001c88:	f1c080e7          	jalr	-228(ra) # 80001ba0 <allocproc>
    80001c8c:	84aa                	mv	s1,a0
  initproc = p;
    80001c8e:	00007797          	auipc	a5,0x7
    80001c92:	38a7bd23          	sd	a0,922(a5) # 80009028 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80001c96:	03400613          	li	a2,52
    80001c9a:	00007597          	auipc	a1,0x7
    80001c9e:	be658593          	addi	a1,a1,-1050 # 80008880 <initcode>
    80001ca2:	6928                	ld	a0,80(a0)
    80001ca4:	fffff097          	auipc	ra,0xfffff
    80001ca8:	6a8080e7          	jalr	1704(ra) # 8000134c <uvminit>
  p->sz = PGSIZE;
    80001cac:	6785                	lui	a5,0x1
    80001cae:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001cb0:	6cb8                	ld	a4,88(s1)
    80001cb2:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001cb6:	6cb8                	ld	a4,88(s1)
    80001cb8:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001cba:	4641                	li	a2,16
    80001cbc:	00006597          	auipc	a1,0x6
    80001cc0:	54458593          	addi	a1,a1,1348 # 80008200 <digits+0x1c0>
    80001cc4:	15848513          	addi	a0,s1,344
    80001cc8:	fffff097          	auipc	ra,0xfffff
    80001ccc:	14e080e7          	jalr	334(ra) # 80000e16 <safestrcpy>
  p->cwd = namei("/");
    80001cd0:	00006517          	auipc	a0,0x6
    80001cd4:	54050513          	addi	a0,a0,1344 # 80008210 <digits+0x1d0>
    80001cd8:	00002097          	auipc	ra,0x2
    80001cdc:	3fc080e7          	jalr	1020(ra) # 800040d4 <namei>
    80001ce0:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001ce4:	478d                	li	a5,3
    80001ce6:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001ce8:	8526                	mv	a0,s1
    80001cea:	fffff097          	auipc	ra,0xfffff
    80001cee:	f9a080e7          	jalr	-102(ra) # 80000c84 <release>
}
    80001cf2:	60e2                	ld	ra,24(sp)
    80001cf4:	6442                	ld	s0,16(sp)
    80001cf6:	64a2                	ld	s1,8(sp)
    80001cf8:	6105                	addi	sp,sp,32
    80001cfa:	8082                	ret

0000000080001cfc <growproc>:
{
    80001cfc:	1101                	addi	sp,sp,-32
    80001cfe:	ec06                	sd	ra,24(sp)
    80001d00:	e822                	sd	s0,16(sp)
    80001d02:	e426                	sd	s1,8(sp)
    80001d04:	e04a                	sd	s2,0(sp)
    80001d06:	1000                	addi	s0,sp,32
    80001d08:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001d0a:	00000097          	auipc	ra,0x0
    80001d0e:	c8c080e7          	jalr	-884(ra) # 80001996 <myproc>
    80001d12:	892a                	mv	s2,a0
  sz = p->sz;
    80001d14:	652c                	ld	a1,72(a0)
    80001d16:	0005861b          	sext.w	a2,a1
  if(n > 0){
    80001d1a:	00904f63          	bgtz	s1,80001d38 <growproc+0x3c>
  } else if(n < 0){
    80001d1e:	0204cc63          	bltz	s1,80001d56 <growproc+0x5a>
  p->sz = sz;
    80001d22:	1602                	slli	a2,a2,0x20
    80001d24:	9201                	srli	a2,a2,0x20
    80001d26:	04c93423          	sd	a2,72(s2)
  return 0;
    80001d2a:	4501                	li	a0,0
}
    80001d2c:	60e2                	ld	ra,24(sp)
    80001d2e:	6442                	ld	s0,16(sp)
    80001d30:	64a2                	ld	s1,8(sp)
    80001d32:	6902                	ld	s2,0(sp)
    80001d34:	6105                	addi	sp,sp,32
    80001d36:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80001d38:	9e25                	addw	a2,a2,s1
    80001d3a:	1602                	slli	a2,a2,0x20
    80001d3c:	9201                	srli	a2,a2,0x20
    80001d3e:	1582                	slli	a1,a1,0x20
    80001d40:	9181                	srli	a1,a1,0x20
    80001d42:	6928                	ld	a0,80(a0)
    80001d44:	fffff097          	auipc	ra,0xfffff
    80001d48:	6c2080e7          	jalr	1730(ra) # 80001406 <uvmalloc>
    80001d4c:	0005061b          	sext.w	a2,a0
    80001d50:	fa69                	bnez	a2,80001d22 <growproc+0x26>
      return -1;
    80001d52:	557d                	li	a0,-1
    80001d54:	bfe1                	j	80001d2c <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001d56:	9e25                	addw	a2,a2,s1
    80001d58:	1602                	slli	a2,a2,0x20
    80001d5a:	9201                	srli	a2,a2,0x20
    80001d5c:	1582                	slli	a1,a1,0x20
    80001d5e:	9181                	srli	a1,a1,0x20
    80001d60:	6928                	ld	a0,80(a0)
    80001d62:	fffff097          	auipc	ra,0xfffff
    80001d66:	65c080e7          	jalr	1628(ra) # 800013be <uvmdealloc>
    80001d6a:	0005061b          	sext.w	a2,a0
    80001d6e:	bf55                	j	80001d22 <growproc+0x26>

0000000080001d70 <fork>:
{
    80001d70:	7139                	addi	sp,sp,-64
    80001d72:	fc06                	sd	ra,56(sp)
    80001d74:	f822                	sd	s0,48(sp)
    80001d76:	f426                	sd	s1,40(sp)
    80001d78:	f04a                	sd	s2,32(sp)
    80001d7a:	ec4e                	sd	s3,24(sp)
    80001d7c:	e852                	sd	s4,16(sp)
    80001d7e:	e456                	sd	s5,8(sp)
    80001d80:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001d82:	00000097          	auipc	ra,0x0
    80001d86:	c14080e7          	jalr	-1004(ra) # 80001996 <myproc>
    80001d8a:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001d8c:	00000097          	auipc	ra,0x0
    80001d90:	e14080e7          	jalr	-492(ra) # 80001ba0 <allocproc>
    80001d94:	10050c63          	beqz	a0,80001eac <fork+0x13c>
    80001d98:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001d9a:	048ab603          	ld	a2,72(s5)
    80001d9e:	692c                	ld	a1,80(a0)
    80001da0:	050ab503          	ld	a0,80(s5)
    80001da4:	fffff097          	auipc	ra,0xfffff
    80001da8:	7ae080e7          	jalr	1966(ra) # 80001552 <uvmcopy>
    80001dac:	04054863          	bltz	a0,80001dfc <fork+0x8c>
  np->sz = p->sz;
    80001db0:	048ab783          	ld	a5,72(s5)
    80001db4:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    80001db8:	058ab683          	ld	a3,88(s5)
    80001dbc:	87b6                	mv	a5,a3
    80001dbe:	058a3703          	ld	a4,88(s4)
    80001dc2:	12068693          	addi	a3,a3,288
    80001dc6:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001dca:	6788                	ld	a0,8(a5)
    80001dcc:	6b8c                	ld	a1,16(a5)
    80001dce:	6f90                	ld	a2,24(a5)
    80001dd0:	01073023          	sd	a6,0(a4)
    80001dd4:	e708                	sd	a0,8(a4)
    80001dd6:	eb0c                	sd	a1,16(a4)
    80001dd8:	ef10                	sd	a2,24(a4)
    80001dda:	02078793          	addi	a5,a5,32
    80001dde:	02070713          	addi	a4,a4,32
    80001de2:	fed792e3          	bne	a5,a3,80001dc6 <fork+0x56>
  np->trapframe->a0 = 0;
    80001de6:	058a3783          	ld	a5,88(s4)
    80001dea:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001dee:	0d0a8493          	addi	s1,s5,208
    80001df2:	0d0a0913          	addi	s2,s4,208
    80001df6:	150a8993          	addi	s3,s5,336
    80001dfa:	a00d                	j	80001e1c <fork+0xac>
    freeproc(np);
    80001dfc:	8552                	mv	a0,s4
    80001dfe:	00000097          	auipc	ra,0x0
    80001e02:	d4a080e7          	jalr	-694(ra) # 80001b48 <freeproc>
    release(&np->lock);
    80001e06:	8552                	mv	a0,s4
    80001e08:	fffff097          	auipc	ra,0xfffff
    80001e0c:	e7c080e7          	jalr	-388(ra) # 80000c84 <release>
    return -1;
    80001e10:	597d                	li	s2,-1
    80001e12:	a059                	j	80001e98 <fork+0x128>
  for(i = 0; i < NOFILE; i++)
    80001e14:	04a1                	addi	s1,s1,8
    80001e16:	0921                	addi	s2,s2,8
    80001e18:	01348b63          	beq	s1,s3,80001e2e <fork+0xbe>
    if(p->ofile[i])
    80001e1c:	6088                	ld	a0,0(s1)
    80001e1e:	d97d                	beqz	a0,80001e14 <fork+0xa4>
      np->ofile[i] = filedup(p->ofile[i]);
    80001e20:	00003097          	auipc	ra,0x3
    80001e24:	94a080e7          	jalr	-1718(ra) # 8000476a <filedup>
    80001e28:	00a93023          	sd	a0,0(s2)
    80001e2c:	b7e5                	j	80001e14 <fork+0xa4>
  np->cwd = idup(p->cwd);
    80001e2e:	150ab503          	ld	a0,336(s5)
    80001e32:	00002097          	auipc	ra,0x2
    80001e36:	aae080e7          	jalr	-1362(ra) # 800038e0 <idup>
    80001e3a:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001e3e:	4641                	li	a2,16
    80001e40:	158a8593          	addi	a1,s5,344
    80001e44:	158a0513          	addi	a0,s4,344
    80001e48:	fffff097          	auipc	ra,0xfffff
    80001e4c:	fce080e7          	jalr	-50(ra) # 80000e16 <safestrcpy>
  pid = np->pid;
    80001e50:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    80001e54:	8552                	mv	a0,s4
    80001e56:	fffff097          	auipc	ra,0xfffff
    80001e5a:	e2e080e7          	jalr	-466(ra) # 80000c84 <release>
  acquire(&wait_lock);
    80001e5e:	0000f497          	auipc	s1,0xf
    80001e62:	45a48493          	addi	s1,s1,1114 # 800112b8 <wait_lock>
    80001e66:	8526                	mv	a0,s1
    80001e68:	fffff097          	auipc	ra,0xfffff
    80001e6c:	d68080e7          	jalr	-664(ra) # 80000bd0 <acquire>
  np->parent = p;
    80001e70:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001e74:	8526                	mv	a0,s1
    80001e76:	fffff097          	auipc	ra,0xfffff
    80001e7a:	e0e080e7          	jalr	-498(ra) # 80000c84 <release>
  acquire(&np->lock);
    80001e7e:	8552                	mv	a0,s4
    80001e80:	fffff097          	auipc	ra,0xfffff
    80001e84:	d50080e7          	jalr	-688(ra) # 80000bd0 <acquire>
  np->state = RUNNABLE;
    80001e88:	478d                	li	a5,3
    80001e8a:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001e8e:	8552                	mv	a0,s4
    80001e90:	fffff097          	auipc	ra,0xfffff
    80001e94:	df4080e7          	jalr	-524(ra) # 80000c84 <release>
}
    80001e98:	854a                	mv	a0,s2
    80001e9a:	70e2                	ld	ra,56(sp)
    80001e9c:	7442                	ld	s0,48(sp)
    80001e9e:	74a2                	ld	s1,40(sp)
    80001ea0:	7902                	ld	s2,32(sp)
    80001ea2:	69e2                	ld	s3,24(sp)
    80001ea4:	6a42                	ld	s4,16(sp)
    80001ea6:	6aa2                	ld	s5,8(sp)
    80001ea8:	6121                	addi	sp,sp,64
    80001eaa:	8082                	ret
    return -1;
    80001eac:	597d                	li	s2,-1
    80001eae:	b7ed                	j	80001e98 <fork+0x128>

0000000080001eb0 <scheduler>:
{
    80001eb0:	7139                	addi	sp,sp,-64
    80001eb2:	fc06                	sd	ra,56(sp)
    80001eb4:	f822                	sd	s0,48(sp)
    80001eb6:	f426                	sd	s1,40(sp)
    80001eb8:	f04a                	sd	s2,32(sp)
    80001eba:	ec4e                	sd	s3,24(sp)
    80001ebc:	e852                	sd	s4,16(sp)
    80001ebe:	e456                	sd	s5,8(sp)
    80001ec0:	e05a                	sd	s6,0(sp)
    80001ec2:	0080                	addi	s0,sp,64
    80001ec4:	8792                	mv	a5,tp
  int id = r_tp();
    80001ec6:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001ec8:	00779a93          	slli	s5,a5,0x7
    80001ecc:	0000f717          	auipc	a4,0xf
    80001ed0:	3d470713          	addi	a4,a4,980 # 800112a0 <pid_lock>
    80001ed4:	9756                	add	a4,a4,s5
    80001ed6:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001eda:	0000f717          	auipc	a4,0xf
    80001ede:	3fe70713          	addi	a4,a4,1022 # 800112d8 <cpus+0x8>
    80001ee2:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    80001ee4:	498d                	li	s3,3
        p->state = RUNNING;
    80001ee6:	4b11                	li	s6,4
        c->proc = p;
    80001ee8:	079e                	slli	a5,a5,0x7
    80001eea:	0000fa17          	auipc	s4,0xf
    80001eee:	3b6a0a13          	addi	s4,s4,950 # 800112a0 <pid_lock>
    80001ef2:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001ef4:	00015917          	auipc	s2,0x15
    80001ef8:	7dc90913          	addi	s2,s2,2012 # 800176d0 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001efc:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001f00:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001f04:	10079073          	csrw	sstatus,a5
    80001f08:	0000f497          	auipc	s1,0xf
    80001f0c:	7c848493          	addi	s1,s1,1992 # 800116d0 <proc>
    80001f10:	a811                	j	80001f24 <scheduler+0x74>
      release(&p->lock);
    80001f12:	8526                	mv	a0,s1
    80001f14:	fffff097          	auipc	ra,0xfffff
    80001f18:	d70080e7          	jalr	-656(ra) # 80000c84 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001f1c:	18048493          	addi	s1,s1,384
    80001f20:	fd248ee3          	beq	s1,s2,80001efc <scheduler+0x4c>
      acquire(&p->lock);
    80001f24:	8526                	mv	a0,s1
    80001f26:	fffff097          	auipc	ra,0xfffff
    80001f2a:	caa080e7          	jalr	-854(ra) # 80000bd0 <acquire>
      if(p->state == RUNNABLE) {
    80001f2e:	4c9c                	lw	a5,24(s1)
    80001f30:	ff3791e3          	bne	a5,s3,80001f12 <scheduler+0x62>
        p->state = RUNNING;
    80001f34:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    80001f38:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    80001f3c:	06048593          	addi	a1,s1,96
    80001f40:	8556                	mv	a0,s5
    80001f42:	00001097          	auipc	ra,0x1
    80001f46:	8e4080e7          	jalr	-1820(ra) # 80002826 <swtch>
        c->proc = 0;
    80001f4a:	020a3823          	sd	zero,48(s4)
    80001f4e:	b7d1                	j	80001f12 <scheduler+0x62>

0000000080001f50 <sched>:
{
    80001f50:	7179                	addi	sp,sp,-48
    80001f52:	f406                	sd	ra,40(sp)
    80001f54:	f022                	sd	s0,32(sp)
    80001f56:	ec26                	sd	s1,24(sp)
    80001f58:	e84a                	sd	s2,16(sp)
    80001f5a:	e44e                	sd	s3,8(sp)
    80001f5c:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001f5e:	00000097          	auipc	ra,0x0
    80001f62:	a38080e7          	jalr	-1480(ra) # 80001996 <myproc>
    80001f66:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001f68:	fffff097          	auipc	ra,0xfffff
    80001f6c:	bee080e7          	jalr	-1042(ra) # 80000b56 <holding>
    80001f70:	c93d                	beqz	a0,80001fe6 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001f72:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001f74:	2781                	sext.w	a5,a5
    80001f76:	079e                	slli	a5,a5,0x7
    80001f78:	0000f717          	auipc	a4,0xf
    80001f7c:	32870713          	addi	a4,a4,808 # 800112a0 <pid_lock>
    80001f80:	97ba                	add	a5,a5,a4
    80001f82:	0a87a703          	lw	a4,168(a5)
    80001f86:	4785                	li	a5,1
    80001f88:	06f71763          	bne	a4,a5,80001ff6 <sched+0xa6>
  if(p->state == RUNNING)
    80001f8c:	4c98                	lw	a4,24(s1)
    80001f8e:	4791                	li	a5,4
    80001f90:	06f70b63          	beq	a4,a5,80002006 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f94:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001f98:	8b89                	andi	a5,a5,2
  if(intr_get())
    80001f9a:	efb5                	bnez	a5,80002016 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001f9c:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001f9e:	0000f917          	auipc	s2,0xf
    80001fa2:	30290913          	addi	s2,s2,770 # 800112a0 <pid_lock>
    80001fa6:	2781                	sext.w	a5,a5
    80001fa8:	079e                	slli	a5,a5,0x7
    80001faa:	97ca                	add	a5,a5,s2
    80001fac:	0ac7a983          	lw	s3,172(a5)
    80001fb0:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001fb2:	2781                	sext.w	a5,a5
    80001fb4:	079e                	slli	a5,a5,0x7
    80001fb6:	0000f597          	auipc	a1,0xf
    80001fba:	32258593          	addi	a1,a1,802 # 800112d8 <cpus+0x8>
    80001fbe:	95be                	add	a1,a1,a5
    80001fc0:	06048513          	addi	a0,s1,96
    80001fc4:	00001097          	auipc	ra,0x1
    80001fc8:	862080e7          	jalr	-1950(ra) # 80002826 <swtch>
    80001fcc:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001fce:	2781                	sext.w	a5,a5
    80001fd0:	079e                	slli	a5,a5,0x7
    80001fd2:	97ca                	add	a5,a5,s2
    80001fd4:	0b37a623          	sw	s3,172(a5)
}
    80001fd8:	70a2                	ld	ra,40(sp)
    80001fda:	7402                	ld	s0,32(sp)
    80001fdc:	64e2                	ld	s1,24(sp)
    80001fde:	6942                	ld	s2,16(sp)
    80001fe0:	69a2                	ld	s3,8(sp)
    80001fe2:	6145                	addi	sp,sp,48
    80001fe4:	8082                	ret
    panic("sched p->lock");
    80001fe6:	00006517          	auipc	a0,0x6
    80001fea:	23250513          	addi	a0,a0,562 # 80008218 <digits+0x1d8>
    80001fee:	ffffe097          	auipc	ra,0xffffe
    80001ff2:	54a080e7          	jalr	1354(ra) # 80000538 <panic>
    panic("sched locks");
    80001ff6:	00006517          	auipc	a0,0x6
    80001ffa:	23250513          	addi	a0,a0,562 # 80008228 <digits+0x1e8>
    80001ffe:	ffffe097          	auipc	ra,0xffffe
    80002002:	53a080e7          	jalr	1338(ra) # 80000538 <panic>
    panic("sched running");
    80002006:	00006517          	auipc	a0,0x6
    8000200a:	23250513          	addi	a0,a0,562 # 80008238 <digits+0x1f8>
    8000200e:	ffffe097          	auipc	ra,0xffffe
    80002012:	52a080e7          	jalr	1322(ra) # 80000538 <panic>
    panic("sched interruptible");
    80002016:	00006517          	auipc	a0,0x6
    8000201a:	23250513          	addi	a0,a0,562 # 80008248 <digits+0x208>
    8000201e:	ffffe097          	auipc	ra,0xffffe
    80002022:	51a080e7          	jalr	1306(ra) # 80000538 <panic>

0000000080002026 <yield>:
{
    80002026:	1101                	addi	sp,sp,-32
    80002028:	ec06                	sd	ra,24(sp)
    8000202a:	e822                	sd	s0,16(sp)
    8000202c:	e426                	sd	s1,8(sp)
    8000202e:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80002030:	00000097          	auipc	ra,0x0
    80002034:	966080e7          	jalr	-1690(ra) # 80001996 <myproc>
    80002038:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000203a:	fffff097          	auipc	ra,0xfffff
    8000203e:	b96080e7          	jalr	-1130(ra) # 80000bd0 <acquire>
  p->state = RUNNABLE;
    80002042:	478d                	li	a5,3
    80002044:	cc9c                	sw	a5,24(s1)
  sched();
    80002046:	00000097          	auipc	ra,0x0
    8000204a:	f0a080e7          	jalr	-246(ra) # 80001f50 <sched>
  release(&p->lock);
    8000204e:	8526                	mv	a0,s1
    80002050:	fffff097          	auipc	ra,0xfffff
    80002054:	c34080e7          	jalr	-972(ra) # 80000c84 <release>
}
    80002058:	60e2                	ld	ra,24(sp)
    8000205a:	6442                	ld	s0,16(sp)
    8000205c:	64a2                	ld	s1,8(sp)
    8000205e:	6105                	addi	sp,sp,32
    80002060:	8082                	ret

0000000080002062 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80002062:	7179                	addi	sp,sp,-48
    80002064:	f406                	sd	ra,40(sp)
    80002066:	f022                	sd	s0,32(sp)
    80002068:	ec26                	sd	s1,24(sp)
    8000206a:	e84a                	sd	s2,16(sp)
    8000206c:	e44e                	sd	s3,8(sp)
    8000206e:	1800                	addi	s0,sp,48
    80002070:	89aa                	mv	s3,a0
    80002072:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002074:	00000097          	auipc	ra,0x0
    80002078:	922080e7          	jalr	-1758(ra) # 80001996 <myproc>
    8000207c:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    8000207e:	fffff097          	auipc	ra,0xfffff
    80002082:	b52080e7          	jalr	-1198(ra) # 80000bd0 <acquire>
  release(lk);
    80002086:	854a                	mv	a0,s2
    80002088:	fffff097          	auipc	ra,0xfffff
    8000208c:	bfc080e7          	jalr	-1028(ra) # 80000c84 <release>

  // Go to sleep.
  p->chan = chan;
    80002090:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80002094:	4789                	li	a5,2
    80002096:	cc9c                	sw	a5,24(s1)

  sched();
    80002098:	00000097          	auipc	ra,0x0
    8000209c:	eb8080e7          	jalr	-328(ra) # 80001f50 <sched>

  // Tidy up.
  p->chan = 0;
    800020a0:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    800020a4:	8526                	mv	a0,s1
    800020a6:	fffff097          	auipc	ra,0xfffff
    800020aa:	bde080e7          	jalr	-1058(ra) # 80000c84 <release>
  acquire(lk);
    800020ae:	854a                	mv	a0,s2
    800020b0:	fffff097          	auipc	ra,0xfffff
    800020b4:	b20080e7          	jalr	-1248(ra) # 80000bd0 <acquire>
}
    800020b8:	70a2                	ld	ra,40(sp)
    800020ba:	7402                	ld	s0,32(sp)
    800020bc:	64e2                	ld	s1,24(sp)
    800020be:	6942                	ld	s2,16(sp)
    800020c0:	69a2                	ld	s3,8(sp)
    800020c2:	6145                	addi	sp,sp,48
    800020c4:	8082                	ret

00000000800020c6 <wait>:
{
    800020c6:	715d                	addi	sp,sp,-80
    800020c8:	e486                	sd	ra,72(sp)
    800020ca:	e0a2                	sd	s0,64(sp)
    800020cc:	fc26                	sd	s1,56(sp)
    800020ce:	f84a                	sd	s2,48(sp)
    800020d0:	f44e                	sd	s3,40(sp)
    800020d2:	f052                	sd	s4,32(sp)
    800020d4:	ec56                	sd	s5,24(sp)
    800020d6:	e85a                	sd	s6,16(sp)
    800020d8:	e45e                	sd	s7,8(sp)
    800020da:	e062                	sd	s8,0(sp)
    800020dc:	0880                	addi	s0,sp,80
    800020de:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    800020e0:	00000097          	auipc	ra,0x0
    800020e4:	8b6080e7          	jalr	-1866(ra) # 80001996 <myproc>
    800020e8:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800020ea:	0000f517          	auipc	a0,0xf
    800020ee:	1ce50513          	addi	a0,a0,462 # 800112b8 <wait_lock>
    800020f2:	fffff097          	auipc	ra,0xfffff
    800020f6:	ade080e7          	jalr	-1314(ra) # 80000bd0 <acquire>
    havekids = 0;
    800020fa:	4b81                	li	s7,0
        if(np->state == ZOMBIE && np->referencias == 1){ //tiene 
    800020fc:	4a95                	li	s5,5
        havekids = 1;
    800020fe:	4a05                	li	s4,1
    for(np = proc; np < &proc[NPROC]; np++){
    80002100:	00015997          	auipc	s3,0x15
    80002104:	5d098993          	addi	s3,s3,1488 # 800176d0 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80002108:	0000fc17          	auipc	s8,0xf
    8000210c:	1b0c0c13          	addi	s8,s8,432 # 800112b8 <wait_lock>
    havekids = 0;
    80002110:	86de                	mv	a3,s7
    for(np = proc; np < &proc[NPROC]; np++){
    80002112:	0000f497          	auipc	s1,0xf
    80002116:	5be48493          	addi	s1,s1,1470 # 800116d0 <proc>
    8000211a:	a815                	j	8000214e <wait+0x88>
            release(&np->lock);
    8000211c:	8526                	mv	a0,s1
    8000211e:	fffff097          	auipc	ra,0xfffff
    80002122:	b66080e7          	jalr	-1178(ra) # 80000c84 <release>
            release(&wait_lock);
    80002126:	0000f517          	auipc	a0,0xf
    8000212a:	19250513          	addi	a0,a0,402 # 800112b8 <wait_lock>
    8000212e:	fffff097          	auipc	ra,0xfffff
    80002132:	b56080e7          	jalr	-1194(ra) # 80000c84 <release>
            return -1;
    80002136:	59fd                	li	s3,-1
    80002138:	a879                	j	800021d6 <wait+0x110>
        release(&np->lock);
    8000213a:	8526                	mv	a0,s1
    8000213c:	fffff097          	auipc	ra,0xfffff
    80002140:	b48080e7          	jalr	-1208(ra) # 80000c84 <release>
        havekids = 1;
    80002144:	86d2                	mv	a3,s4
    for(np = proc; np < &proc[NPROC]; np++){
    80002146:	18048493          	addi	s1,s1,384
    8000214a:	07348963          	beq	s1,s3,800021bc <wait+0xf6>
      if(np->parent == p && np->pagetable != p->pagetable){ //Proceso hijo no puede compartir el espacio de direcciones el padre
    8000214e:	7c9c                	ld	a5,56(s1)
    80002150:	ff279be3          	bne	a5,s2,80002146 <wait+0x80>
    80002154:	68b8                	ld	a4,80(s1)
    80002156:	05093783          	ld	a5,80(s2)
    8000215a:	fef706e3          	beq	a4,a5,80002146 <wait+0x80>
        acquire(&np->lock);
    8000215e:	8526                	mv	a0,s1
    80002160:	fffff097          	auipc	ra,0xfffff
    80002164:	a70080e7          	jalr	-1424(ra) # 80000bd0 <acquire>
        if(np->state == ZOMBIE && np->referencias == 1){ //tiene 
    80002168:	4c9c                	lw	a5,24(s1)
    8000216a:	fd5798e3          	bne	a5,s5,8000213a <wait+0x74>
    8000216e:	1784a783          	lw	a5,376(s1)
    80002172:	fd4794e3          	bne	a5,s4,8000213a <wait+0x74>
          pid = np->pid;
    80002176:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    8000217a:	000b0e63          	beqz	s6,80002196 <wait+0xd0>
    8000217e:	4691                	li	a3,4
    80002180:	02c48613          	addi	a2,s1,44
    80002184:	85da                	mv	a1,s6
    80002186:	05093503          	ld	a0,80(s2)
    8000218a:	fffff097          	auipc	ra,0xfffff
    8000218e:	4cc080e7          	jalr	1228(ra) # 80001656 <copyout>
    80002192:	f80545e3          	bltz	a0,8000211c <wait+0x56>
          freeproc(np);
    80002196:	8526                	mv	a0,s1
    80002198:	00000097          	auipc	ra,0x0
    8000219c:	9b0080e7          	jalr	-1616(ra) # 80001b48 <freeproc>
          release(&np->lock);
    800021a0:	8526                	mv	a0,s1
    800021a2:	fffff097          	auipc	ra,0xfffff
    800021a6:	ae2080e7          	jalr	-1310(ra) # 80000c84 <release>
          release(&wait_lock);
    800021aa:	0000f517          	auipc	a0,0xf
    800021ae:	10e50513          	addi	a0,a0,270 # 800112b8 <wait_lock>
    800021b2:	fffff097          	auipc	ra,0xfffff
    800021b6:	ad2080e7          	jalr	-1326(ra) # 80000c84 <release>
          return pid;
    800021ba:	a831                	j	800021d6 <wait+0x110>
    if(!havekids || p->killed){
    800021bc:	c681                	beqz	a3,800021c4 <wait+0xfe>
    800021be:	02892783          	lw	a5,40(s2)
    800021c2:	c79d                	beqz	a5,800021f0 <wait+0x12a>
      release(&wait_lock);
    800021c4:	0000f517          	auipc	a0,0xf
    800021c8:	0f450513          	addi	a0,a0,244 # 800112b8 <wait_lock>
    800021cc:	fffff097          	auipc	ra,0xfffff
    800021d0:	ab8080e7          	jalr	-1352(ra) # 80000c84 <release>
      return -1;
    800021d4:	59fd                	li	s3,-1
}
    800021d6:	854e                	mv	a0,s3
    800021d8:	60a6                	ld	ra,72(sp)
    800021da:	6406                	ld	s0,64(sp)
    800021dc:	74e2                	ld	s1,56(sp)
    800021de:	7942                	ld	s2,48(sp)
    800021e0:	79a2                	ld	s3,40(sp)
    800021e2:	7a02                	ld	s4,32(sp)
    800021e4:	6ae2                	ld	s5,24(sp)
    800021e6:	6b42                	ld	s6,16(sp)
    800021e8:	6ba2                	ld	s7,8(sp)
    800021ea:	6c02                	ld	s8,0(sp)
    800021ec:	6161                	addi	sp,sp,80
    800021ee:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800021f0:	85e2                	mv	a1,s8
    800021f2:	854a                	mv	a0,s2
    800021f4:	00000097          	auipc	ra,0x0
    800021f8:	e6e080e7          	jalr	-402(ra) # 80002062 <sleep>
    havekids = 0;
    800021fc:	bf11                	j	80002110 <wait+0x4a>

00000000800021fe <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800021fe:	7139                	addi	sp,sp,-64
    80002200:	fc06                	sd	ra,56(sp)
    80002202:	f822                	sd	s0,48(sp)
    80002204:	f426                	sd	s1,40(sp)
    80002206:	f04a                	sd	s2,32(sp)
    80002208:	ec4e                	sd	s3,24(sp)
    8000220a:	e852                	sd	s4,16(sp)
    8000220c:	e456                	sd	s5,8(sp)
    8000220e:	0080                	addi	s0,sp,64
    80002210:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80002212:	0000f497          	auipc	s1,0xf
    80002216:	4be48493          	addi	s1,s1,1214 # 800116d0 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    8000221a:	4989                	li	s3,2
        p->state = RUNNABLE;
    8000221c:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    8000221e:	00015917          	auipc	s2,0x15
    80002222:	4b290913          	addi	s2,s2,1202 # 800176d0 <tickslock>
    80002226:	a811                	j	8000223a <wakeup+0x3c>
      }
      release(&p->lock);
    80002228:	8526                	mv	a0,s1
    8000222a:	fffff097          	auipc	ra,0xfffff
    8000222e:	a5a080e7          	jalr	-1446(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002232:	18048493          	addi	s1,s1,384
    80002236:	03248663          	beq	s1,s2,80002262 <wakeup+0x64>
    if(p != myproc()){
    8000223a:	fffff097          	auipc	ra,0xfffff
    8000223e:	75c080e7          	jalr	1884(ra) # 80001996 <myproc>
    80002242:	fea488e3          	beq	s1,a0,80002232 <wakeup+0x34>
      acquire(&p->lock);
    80002246:	8526                	mv	a0,s1
    80002248:	fffff097          	auipc	ra,0xfffff
    8000224c:	988080e7          	jalr	-1656(ra) # 80000bd0 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80002250:	4c9c                	lw	a5,24(s1)
    80002252:	fd379be3          	bne	a5,s3,80002228 <wakeup+0x2a>
    80002256:	709c                	ld	a5,32(s1)
    80002258:	fd4798e3          	bne	a5,s4,80002228 <wakeup+0x2a>
        p->state = RUNNABLE;
    8000225c:	0154ac23          	sw	s5,24(s1)
    80002260:	b7e1                	j	80002228 <wakeup+0x2a>
    }
  }
}
    80002262:	70e2                	ld	ra,56(sp)
    80002264:	7442                	ld	s0,48(sp)
    80002266:	74a2                	ld	s1,40(sp)
    80002268:	7902                	ld	s2,32(sp)
    8000226a:	69e2                	ld	s3,24(sp)
    8000226c:	6a42                	ld	s4,16(sp)
    8000226e:	6aa2                	ld	s5,8(sp)
    80002270:	6121                	addi	sp,sp,64
    80002272:	8082                	ret

0000000080002274 <reparent>:
{
    80002274:	7179                	addi	sp,sp,-48
    80002276:	f406                	sd	ra,40(sp)
    80002278:	f022                	sd	s0,32(sp)
    8000227a:	ec26                	sd	s1,24(sp)
    8000227c:	e84a                	sd	s2,16(sp)
    8000227e:	e44e                	sd	s3,8(sp)
    80002280:	e052                	sd	s4,0(sp)
    80002282:	1800                	addi	s0,sp,48
    80002284:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002286:	0000f497          	auipc	s1,0xf
    8000228a:	44a48493          	addi	s1,s1,1098 # 800116d0 <proc>
      pp->parent = initproc;
    8000228e:	00007a17          	auipc	s4,0x7
    80002292:	d9aa0a13          	addi	s4,s4,-614 # 80009028 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002296:	00015997          	auipc	s3,0x15
    8000229a:	43a98993          	addi	s3,s3,1082 # 800176d0 <tickslock>
    8000229e:	a029                	j	800022a8 <reparent+0x34>
    800022a0:	18048493          	addi	s1,s1,384
    800022a4:	01348d63          	beq	s1,s3,800022be <reparent+0x4a>
    if(pp->parent == p){
    800022a8:	7c9c                	ld	a5,56(s1)
    800022aa:	ff279be3          	bne	a5,s2,800022a0 <reparent+0x2c>
      pp->parent = initproc;
    800022ae:	000a3503          	ld	a0,0(s4)
    800022b2:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    800022b4:	00000097          	auipc	ra,0x0
    800022b8:	f4a080e7          	jalr	-182(ra) # 800021fe <wakeup>
    800022bc:	b7d5                	j	800022a0 <reparent+0x2c>
}
    800022be:	70a2                	ld	ra,40(sp)
    800022c0:	7402                	ld	s0,32(sp)
    800022c2:	64e2                	ld	s1,24(sp)
    800022c4:	6942                	ld	s2,16(sp)
    800022c6:	69a2                	ld	s3,8(sp)
    800022c8:	6a02                	ld	s4,0(sp)
    800022ca:	6145                	addi	sp,sp,48
    800022cc:	8082                	ret

00000000800022ce <exit>:
{
    800022ce:	7179                	addi	sp,sp,-48
    800022d0:	f406                	sd	ra,40(sp)
    800022d2:	f022                	sd	s0,32(sp)
    800022d4:	ec26                	sd	s1,24(sp)
    800022d6:	e84a                	sd	s2,16(sp)
    800022d8:	e44e                	sd	s3,8(sp)
    800022da:	e052                	sd	s4,0(sp)
    800022dc:	1800                	addi	s0,sp,48
    800022de:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800022e0:	fffff097          	auipc	ra,0xfffff
    800022e4:	6b6080e7          	jalr	1718(ra) # 80001996 <myproc>
    800022e8:	89aa                	mv	s3,a0
  if(p == initproc)
    800022ea:	00007797          	auipc	a5,0x7
    800022ee:	d3e7b783          	ld	a5,-706(a5) # 80009028 <initproc>
    800022f2:	0d050493          	addi	s1,a0,208
    800022f6:	15050913          	addi	s2,a0,336
    800022fa:	02a79363          	bne	a5,a0,80002320 <exit+0x52>
    panic("init exiting");
    800022fe:	00006517          	auipc	a0,0x6
    80002302:	f6250513          	addi	a0,a0,-158 # 80008260 <digits+0x220>
    80002306:	ffffe097          	auipc	ra,0xffffe
    8000230a:	232080e7          	jalr	562(ra) # 80000538 <panic>
      fileclose(f);
    8000230e:	00002097          	auipc	ra,0x2
    80002312:	4ae080e7          	jalr	1198(ra) # 800047bc <fileclose>
      p->ofile[fd] = 0;
    80002316:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    8000231a:	04a1                	addi	s1,s1,8
    8000231c:	01248563          	beq	s1,s2,80002326 <exit+0x58>
    if(p->ofile[fd]){
    80002320:	6088                	ld	a0,0(s1)
    80002322:	f575                	bnez	a0,8000230e <exit+0x40>
    80002324:	bfdd                	j	8000231a <exit+0x4c>
  begin_op();
    80002326:	00002097          	auipc	ra,0x2
    8000232a:	fca080e7          	jalr	-54(ra) # 800042f0 <begin_op>
  iput(p->cwd);
    8000232e:	1509b503          	ld	a0,336(s3)
    80002332:	00001097          	auipc	ra,0x1
    80002336:	7a6080e7          	jalr	1958(ra) # 80003ad8 <iput>
  end_op();
    8000233a:	00002097          	auipc	ra,0x2
    8000233e:	036080e7          	jalr	54(ra) # 80004370 <end_op>
  p->cwd = 0;
    80002342:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80002346:	0000f497          	auipc	s1,0xf
    8000234a:	f7248493          	addi	s1,s1,-142 # 800112b8 <wait_lock>
    8000234e:	8526                	mv	a0,s1
    80002350:	fffff097          	auipc	ra,0xfffff
    80002354:	880080e7          	jalr	-1920(ra) # 80000bd0 <acquire>
  reparent(p);
    80002358:	854e                	mv	a0,s3
    8000235a:	00000097          	auipc	ra,0x0
    8000235e:	f1a080e7          	jalr	-230(ra) # 80002274 <reparent>
  wakeup(p->parent);
    80002362:	0389b503          	ld	a0,56(s3)
    80002366:	00000097          	auipc	ra,0x0
    8000236a:	e98080e7          	jalr	-360(ra) # 800021fe <wakeup>
  acquire(&p->lock);
    8000236e:	854e                	mv	a0,s3
    80002370:	fffff097          	auipc	ra,0xfffff
    80002374:	860080e7          	jalr	-1952(ra) # 80000bd0 <acquire>
  p->xstate = status;
    80002378:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    8000237c:	4795                	li	a5,5
    8000237e:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80002382:	8526                	mv	a0,s1
    80002384:	fffff097          	auipc	ra,0xfffff
    80002388:	900080e7          	jalr	-1792(ra) # 80000c84 <release>
  sched();
    8000238c:	00000097          	auipc	ra,0x0
    80002390:	bc4080e7          	jalr	-1084(ra) # 80001f50 <sched>
  panic("zombie exit");
    80002394:	00006517          	auipc	a0,0x6
    80002398:	edc50513          	addi	a0,a0,-292 # 80008270 <digits+0x230>
    8000239c:	ffffe097          	auipc	ra,0xffffe
    800023a0:	19c080e7          	jalr	412(ra) # 80000538 <panic>

00000000800023a4 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800023a4:	7179                	addi	sp,sp,-48
    800023a6:	f406                	sd	ra,40(sp)
    800023a8:	f022                	sd	s0,32(sp)
    800023aa:	ec26                	sd	s1,24(sp)
    800023ac:	e84a                	sd	s2,16(sp)
    800023ae:	e44e                	sd	s3,8(sp)
    800023b0:	1800                	addi	s0,sp,48
    800023b2:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800023b4:	0000f497          	auipc	s1,0xf
    800023b8:	31c48493          	addi	s1,s1,796 # 800116d0 <proc>
    800023bc:	00015997          	auipc	s3,0x15
    800023c0:	31498993          	addi	s3,s3,788 # 800176d0 <tickslock>
    acquire(&p->lock);
    800023c4:	8526                	mv	a0,s1
    800023c6:	fffff097          	auipc	ra,0xfffff
    800023ca:	80a080e7          	jalr	-2038(ra) # 80000bd0 <acquire>
    if(p->pid == pid){
    800023ce:	589c                	lw	a5,48(s1)
    800023d0:	01278d63          	beq	a5,s2,800023ea <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800023d4:	8526                	mv	a0,s1
    800023d6:	fffff097          	auipc	ra,0xfffff
    800023da:	8ae080e7          	jalr	-1874(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800023de:	18048493          	addi	s1,s1,384
    800023e2:	ff3491e3          	bne	s1,s3,800023c4 <kill+0x20>
  }
  return -1;
    800023e6:	557d                	li	a0,-1
    800023e8:	a829                	j	80002402 <kill+0x5e>
      p->killed = 1;
    800023ea:	4785                	li	a5,1
    800023ec:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    800023ee:	4c98                	lw	a4,24(s1)
    800023f0:	4789                	li	a5,2
    800023f2:	00f70f63          	beq	a4,a5,80002410 <kill+0x6c>
      release(&p->lock);
    800023f6:	8526                	mv	a0,s1
    800023f8:	fffff097          	auipc	ra,0xfffff
    800023fc:	88c080e7          	jalr	-1908(ra) # 80000c84 <release>
      return 0;
    80002400:	4501                	li	a0,0
}
    80002402:	70a2                	ld	ra,40(sp)
    80002404:	7402                	ld	s0,32(sp)
    80002406:	64e2                	ld	s1,24(sp)
    80002408:	6942                	ld	s2,16(sp)
    8000240a:	69a2                	ld	s3,8(sp)
    8000240c:	6145                	addi	sp,sp,48
    8000240e:	8082                	ret
        p->state = RUNNABLE;
    80002410:	478d                	li	a5,3
    80002412:	cc9c                	sw	a5,24(s1)
    80002414:	b7cd                	j	800023f6 <kill+0x52>

0000000080002416 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80002416:	7179                	addi	sp,sp,-48
    80002418:	f406                	sd	ra,40(sp)
    8000241a:	f022                	sd	s0,32(sp)
    8000241c:	ec26                	sd	s1,24(sp)
    8000241e:	e84a                	sd	s2,16(sp)
    80002420:	e44e                	sd	s3,8(sp)
    80002422:	e052                	sd	s4,0(sp)
    80002424:	1800                	addi	s0,sp,48
    80002426:	84aa                	mv	s1,a0
    80002428:	892e                	mv	s2,a1
    8000242a:	89b2                	mv	s3,a2
    8000242c:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    8000242e:	fffff097          	auipc	ra,0xfffff
    80002432:	568080e7          	jalr	1384(ra) # 80001996 <myproc>
  if(user_dst){
    80002436:	c08d                	beqz	s1,80002458 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80002438:	86d2                	mv	a3,s4
    8000243a:	864e                	mv	a2,s3
    8000243c:	85ca                	mv	a1,s2
    8000243e:	6928                	ld	a0,80(a0)
    80002440:	fffff097          	auipc	ra,0xfffff
    80002444:	216080e7          	jalr	534(ra) # 80001656 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80002448:	70a2                	ld	ra,40(sp)
    8000244a:	7402                	ld	s0,32(sp)
    8000244c:	64e2                	ld	s1,24(sp)
    8000244e:	6942                	ld	s2,16(sp)
    80002450:	69a2                	ld	s3,8(sp)
    80002452:	6a02                	ld	s4,0(sp)
    80002454:	6145                	addi	sp,sp,48
    80002456:	8082                	ret
    memmove((char *)dst, src, len);
    80002458:	000a061b          	sext.w	a2,s4
    8000245c:	85ce                	mv	a1,s3
    8000245e:	854a                	mv	a0,s2
    80002460:	fffff097          	auipc	ra,0xfffff
    80002464:	8c8080e7          	jalr	-1848(ra) # 80000d28 <memmove>
    return 0;
    80002468:	8526                	mv	a0,s1
    8000246a:	bff9                	j	80002448 <either_copyout+0x32>

000000008000246c <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    8000246c:	7179                	addi	sp,sp,-48
    8000246e:	f406                	sd	ra,40(sp)
    80002470:	f022                	sd	s0,32(sp)
    80002472:	ec26                	sd	s1,24(sp)
    80002474:	e84a                	sd	s2,16(sp)
    80002476:	e44e                	sd	s3,8(sp)
    80002478:	e052                	sd	s4,0(sp)
    8000247a:	1800                	addi	s0,sp,48
    8000247c:	892a                	mv	s2,a0
    8000247e:	84ae                	mv	s1,a1
    80002480:	89b2                	mv	s3,a2
    80002482:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80002484:	fffff097          	auipc	ra,0xfffff
    80002488:	512080e7          	jalr	1298(ra) # 80001996 <myproc>
  if(user_src){
    8000248c:	c08d                	beqz	s1,800024ae <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    8000248e:	86d2                	mv	a3,s4
    80002490:	864e                	mv	a2,s3
    80002492:	85ca                	mv	a1,s2
    80002494:	6928                	ld	a0,80(a0)
    80002496:	fffff097          	auipc	ra,0xfffff
    8000249a:	24c080e7          	jalr	588(ra) # 800016e2 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    8000249e:	70a2                	ld	ra,40(sp)
    800024a0:	7402                	ld	s0,32(sp)
    800024a2:	64e2                	ld	s1,24(sp)
    800024a4:	6942                	ld	s2,16(sp)
    800024a6:	69a2                	ld	s3,8(sp)
    800024a8:	6a02                	ld	s4,0(sp)
    800024aa:	6145                	addi	sp,sp,48
    800024ac:	8082                	ret
    memmove(dst, (char*)src, len);
    800024ae:	000a061b          	sext.w	a2,s4
    800024b2:	85ce                	mv	a1,s3
    800024b4:	854a                	mv	a0,s2
    800024b6:	fffff097          	auipc	ra,0xfffff
    800024ba:	872080e7          	jalr	-1934(ra) # 80000d28 <memmove>
    return 0;
    800024be:	8526                	mv	a0,s1
    800024c0:	bff9                	j	8000249e <either_copyin+0x32>

00000000800024c2 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800024c2:	715d                	addi	sp,sp,-80
    800024c4:	e486                	sd	ra,72(sp)
    800024c6:	e0a2                	sd	s0,64(sp)
    800024c8:	fc26                	sd	s1,56(sp)
    800024ca:	f84a                	sd	s2,48(sp)
    800024cc:	f44e                	sd	s3,40(sp)
    800024ce:	f052                	sd	s4,32(sp)
    800024d0:	ec56                	sd	s5,24(sp)
    800024d2:	e85a                	sd	s6,16(sp)
    800024d4:	e45e                	sd	s7,8(sp)
    800024d6:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    800024d8:	00006517          	auipc	a0,0x6
    800024dc:	bf050513          	addi	a0,a0,-1040 # 800080c8 <digits+0x88>
    800024e0:	ffffe097          	auipc	ra,0xffffe
    800024e4:	0a2080e7          	jalr	162(ra) # 80000582 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800024e8:	0000f497          	auipc	s1,0xf
    800024ec:	34048493          	addi	s1,s1,832 # 80011828 <proc+0x158>
    800024f0:	00015917          	auipc	s2,0x15
    800024f4:	33890913          	addi	s2,s2,824 # 80017828 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800024f8:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    800024fa:	00006997          	auipc	s3,0x6
    800024fe:	d8698993          	addi	s3,s3,-634 # 80008280 <digits+0x240>
    printf("%d %s %s", p->pid, state, p->name);
    80002502:	00006a97          	auipc	s5,0x6
    80002506:	d86a8a93          	addi	s5,s5,-634 # 80008288 <digits+0x248>
    printf("\n");
    8000250a:	00006a17          	auipc	s4,0x6
    8000250e:	bbea0a13          	addi	s4,s4,-1090 # 800080c8 <digits+0x88>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002512:	00006b97          	auipc	s7,0x6
    80002516:	df6b8b93          	addi	s7,s7,-522 # 80008308 <states.0>
    8000251a:	a00d                	j	8000253c <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    8000251c:	ed86a583          	lw	a1,-296(a3)
    80002520:	8556                	mv	a0,s5
    80002522:	ffffe097          	auipc	ra,0xffffe
    80002526:	060080e7          	jalr	96(ra) # 80000582 <printf>
    printf("\n");
    8000252a:	8552                	mv	a0,s4
    8000252c:	ffffe097          	auipc	ra,0xffffe
    80002530:	056080e7          	jalr	86(ra) # 80000582 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80002534:	18048493          	addi	s1,s1,384
    80002538:	03248163          	beq	s1,s2,8000255a <procdump+0x98>
    if(p->state == UNUSED)
    8000253c:	86a6                	mv	a3,s1
    8000253e:	ec04a783          	lw	a5,-320(s1)
    80002542:	dbed                	beqz	a5,80002534 <procdump+0x72>
      state = "???";
    80002544:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002546:	fcfb6be3          	bltu	s6,a5,8000251c <procdump+0x5a>
    8000254a:	1782                	slli	a5,a5,0x20
    8000254c:	9381                	srli	a5,a5,0x20
    8000254e:	078e                	slli	a5,a5,0x3
    80002550:	97de                	add	a5,a5,s7
    80002552:	6390                	ld	a2,0(a5)
    80002554:	f661                	bnez	a2,8000251c <procdump+0x5a>
      state = "???";
    80002556:	864e                	mv	a2,s3
    80002558:	b7d1                	j	8000251c <procdump+0x5a>
  }
}
    8000255a:	60a6                	ld	ra,72(sp)
    8000255c:	6406                	ld	s0,64(sp)
    8000255e:	74e2                	ld	s1,56(sp)
    80002560:	7942                	ld	s2,48(sp)
    80002562:	79a2                	ld	s3,40(sp)
    80002564:	7a02                	ld	s4,32(sp)
    80002566:	6ae2                	ld	s5,24(sp)
    80002568:	6b42                	ld	s6,16(sp)
    8000256a:	6ba2                	ld	s7,8(sp)
    8000256c:	6161                	addi	sp,sp,80
    8000256e:	8082                	ret

0000000080002570 <clone>:


int clone(void(*fcn)(void*), void *arg, void*stack)
{
    80002570:	715d                	addi	sp,sp,-80
    80002572:	e486                	sd	ra,72(sp)
    80002574:	e0a2                	sd	s0,64(sp)
    80002576:	fc26                	sd	s1,56(sp)
    80002578:	f84a                	sd	s2,48(sp)
    8000257a:	f44e                	sd	s3,40(sp)
    8000257c:	f052                	sd	s4,32(sp)
    8000257e:	ec56                	sd	s5,24(sp)
    80002580:	0880                	addi	s0,sp,80
    80002582:	8a2a                	mv	s4,a0
    80002584:	892e                	mv	s2,a1
    80002586:	84b2                	mv	s1,a2

    int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    80002588:	fffff097          	auipc	ra,0xfffff
    8000258c:	40e080e7          	jalr	1038(ra) # 80001996 <myproc>
    80002590:	8aaa                	mv	s5,a0

  // Allocate process.
  if((np = allocproc()) == 0){
    80002592:	fffff097          	auipc	ra,0xfffff
    80002596:	60e080e7          	jalr	1550(ra) # 80001ba0 <allocproc>
    8000259a:	14050e63          	beqz	a0,800026f6 <clone+0x186>
    8000259e:	89aa                	mv	s3,a0
    return -1;
  }

  //Hacemos que el proceso hijo comparta la tabla de páginas del proceso padre
  np->pagetable = p->pagetable;
    800025a0:	050ab783          	ld	a5,80(s5)
    800025a4:	e93c                	sd	a5,80(a0)
  np->sz = p->sz;
    800025a6:	048ab783          	ld	a5,72(s5)
    800025aa:	e53c                	sd	a5,72(a0)

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    800025ac:	058ab683          	ld	a3,88(s5)
    800025b0:	87b6                	mv	a5,a3
    800025b2:	6d38                	ld	a4,88(a0)
    800025b4:	12068693          	addi	a3,a3,288
    800025b8:	6388                	ld	a0,0(a5)
    800025ba:	678c                	ld	a1,8(a5)
    800025bc:	0107b803          	ld	a6,16(a5)
    800025c0:	6f90                	ld	a2,24(a5)
    800025c2:	e308                	sd	a0,0(a4)
    800025c4:	e70c                	sd	a1,8(a4)
    800025c6:	01073823          	sd	a6,16(a4)
    800025ca:	ef10                	sd	a2,24(a4)
    800025cc:	02078793          	addi	a5,a5,32
    800025d0:	02070713          	addi	a4,a4,32
    800025d4:	fed792e3          	bne	a5,a3,800025b8 <clone+0x48>

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;
    800025d8:	0589b783          	ld	a5,88(s3)
    800025dc:	0607b823          	sd	zero,112(a5)

  
  //Apuntamos al final del stack y luego vamos insertamos
  uint64 stack_args[2]; 
  stack_args[0] =  (uint64)arg; //PC retorno
    800025e0:	fb243823          	sd	s2,-80(s0)
  stack_args[1] =  0xffffffff; //cast uint64
    800025e4:	57fd                	li	a5,-1
    800025e6:	9381                	srli	a5,a5,0x20
    800025e8:	faf43c23          	sd	a5,-72(s0)

  np->bottom_ustack = (uint64) stack; //base de stack, para liberar en join
    800025ec:	1699b823          	sd	s1,368(s3)
  np->top_ustack = np->bottom_ustack + PGSIZE; //tope de stack
  np->top_ustack -= 8; 
    800025f0:	6785                	lui	a5,0x1
    800025f2:	17e1                	addi	a5,a5,-8
    800025f4:	94be                	add	s1,s1,a5
    800025f6:	1699b423          	sd	s1,360(s3)


  printf ("Antes de hacer copyout.\n");
    800025fa:	00006517          	auipc	a0,0x6
    800025fe:	c9e50513          	addi	a0,a0,-866 # 80008298 <digits+0x258>
    80002602:	ffffe097          	auipc	ra,0xffffe
    80002606:	f80080e7          	jalr	-128(ra) # 80000582 <printf>

  //copyout
  if (copyout(np->pagetable, np->top_ustack, (char *) stack_args, 8) < 0) {
    8000260a:	46a1                	li	a3,8
    8000260c:	fb040613          	addi	a2,s0,-80
    80002610:	1689b583          	ld	a1,360(s3)
    80002614:	0509b503          	ld	a0,80(s3)
    80002618:	fffff097          	auipc	ra,0xfffff
    8000261c:	03e080e7          	jalr	62(ra) # 80001656 <copyout>
    80002620:	0c054d63          	bltz	a0,800026fa <clone+0x18a>
        return -1;
    }

 
  printf ("Copyout correcto al stack del thread.\n");
    80002624:	00006517          	auipc	a0,0x6
    80002628:	c9450513          	addi	a0,a0,-876 # 800082b8 <digits+0x278>
    8000262c:	ffffe097          	auipc	ra,0xffffe
    80002630:	f56080e7          	jalr	-170(ra) # 80000582 <printf>

   //cambiar program counter a la función que debe ejecutar
  np->trapframe->epc = (uint64) fcn;
    80002634:	0589b783          	ld	a5,88(s3)
    80002638:	0147bc23          	sd	s4,24(a5) # 1018 <_entry-0x7fffefe8>

  //actualiza stack pointer
  np->trapframe->sp = np->top_ustack;
    8000263c:	0589b783          	ld	a5,88(s3)
    80002640:	1689b703          	ld	a4,360(s3)
    80002644:	fb98                	sd	a4,48(a5)
  
  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    80002646:	0d0a8493          	addi	s1,s5,208
    8000264a:	0d098913          	addi	s2,s3,208
    8000264e:	150a8a13          	addi	s4,s5,336
    80002652:	a819                	j	80002668 <clone+0xf8>
    if(p->ofile[i])
      np->ofile[i] = filedup(p->ofile[i]);
    80002654:	00002097          	auipc	ra,0x2
    80002658:	116080e7          	jalr	278(ra) # 8000476a <filedup>
    8000265c:	00a93023          	sd	a0,0(s2)
  for(i = 0; i < NOFILE; i++)
    80002660:	04a1                	addi	s1,s1,8
    80002662:	0921                	addi	s2,s2,8
    80002664:	01448563          	beq	s1,s4,8000266e <clone+0xfe>
    if(p->ofile[i])
    80002668:	6088                	ld	a0,0(s1)
    8000266a:	f56d                	bnez	a0,80002654 <clone+0xe4>
    8000266c:	bfd5                	j	80002660 <clone+0xf0>
  np->cwd = idup(p->cwd);
    8000266e:	150ab503          	ld	a0,336(s5)
    80002672:	00001097          	auipc	ra,0x1
    80002676:	26e080e7          	jalr	622(ra) # 800038e0 <idup>
    8000267a:	14a9b823          	sd	a0,336(s3)

  safestrcpy(np->name, p->name, sizeof(p->name));
    8000267e:	4641                	li	a2,16
    80002680:	158a8593          	addi	a1,s5,344
    80002684:	15898513          	addi	a0,s3,344
    80002688:	ffffe097          	auipc	ra,0xffffe
    8000268c:	78e080e7          	jalr	1934(ra) # 80000e16 <safestrcpy>

  //para devolverlo
  pid = np->pid;
    80002690:	0309a903          	lw	s2,48(s3)

  //asignamos también al hijo las referencias que tiene el padre y sumamos al hijo
  np->referencias = p->referencias;
  np->referencias = np->referencias +1;
    80002694:	178aa783          	lw	a5,376(s5)
    80002698:	2785                	addiw	a5,a5,1
    8000269a:	16f9ac23          	sw	a5,376(s3)

  release(&np->lock);
    8000269e:	854e                	mv	a0,s3
    800026a0:	ffffe097          	auipc	ra,0xffffe
    800026a4:	5e4080e7          	jalr	1508(ra) # 80000c84 <release>

  //para registrar cual es su padre
  acquire(&wait_lock);
    800026a8:	0000f497          	auipc	s1,0xf
    800026ac:	c1048493          	addi	s1,s1,-1008 # 800112b8 <wait_lock>
    800026b0:	8526                	mv	a0,s1
    800026b2:	ffffe097          	auipc	ra,0xffffe
    800026b6:	51e080e7          	jalr	1310(ra) # 80000bd0 <acquire>
  np->parent = p;
    800026ba:	0359bc23          	sd	s5,56(s3)
  release(&wait_lock);
    800026be:	8526                	mv	a0,s1
    800026c0:	ffffe097          	auipc	ra,0xffffe
    800026c4:	5c4080e7          	jalr	1476(ra) # 80000c84 <release>

  //para cambiar su estado a ejecutable
  acquire(&np->lock);
    800026c8:	854e                	mv	a0,s3
    800026ca:	ffffe097          	auipc	ra,0xffffe
    800026ce:	506080e7          	jalr	1286(ra) # 80000bd0 <acquire>
  np->state = RUNNABLE;
    800026d2:	478d                	li	a5,3
    800026d4:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    800026d8:	854e                	mv	a0,s3
    800026da:	ffffe097          	auipc	ra,0xffffe
    800026de:	5aa080e7          	jalr	1450(ra) # 80000c84 <release>

  return pid;

}
    800026e2:	854a                	mv	a0,s2
    800026e4:	60a6                	ld	ra,72(sp)
    800026e6:	6406                	ld	s0,64(sp)
    800026e8:	74e2                	ld	s1,56(sp)
    800026ea:	7942                	ld	s2,48(sp)
    800026ec:	79a2                	ld	s3,40(sp)
    800026ee:	7a02                	ld	s4,32(sp)
    800026f0:	6ae2                	ld	s5,24(sp)
    800026f2:	6161                	addi	sp,sp,80
    800026f4:	8082                	ret
    return -1;
    800026f6:	597d                	li	s2,-1
    800026f8:	b7ed                	j	800026e2 <clone+0x172>
        return -1;
    800026fa:	597d                	li	s2,-1
    800026fc:	b7dd                	j	800026e2 <clone+0x172>

00000000800026fe <join>:


int join (void **stack){
    800026fe:	715d                	addi	sp,sp,-80
    80002700:	e486                	sd	ra,72(sp)
    80002702:	e0a2                	sd	s0,64(sp)
    80002704:	fc26                	sd	s1,56(sp)
    80002706:	f84a                	sd	s2,48(sp)
    80002708:	f44e                	sd	s3,40(sp)
    8000270a:	f052                	sd	s4,32(sp)
    8000270c:	ec56                	sd	s5,24(sp)
    8000270e:	e85a                	sd	s6,16(sp)
    80002710:	e45e                	sd	s7,8(sp)
    80002712:	e062                	sd	s8,0(sp)
    80002714:	0880                	addi	s0,sp,80
    80002716:	8b2a                	mv	s6,a0

  struct proc *np;
  int havekids, pid;
  struct proc *p = myproc();
    80002718:	fffff097          	auipc	ra,0xfffff
    8000271c:	27e080e7          	jalr	638(ra) # 80001996 <myproc>
    80002720:	892a                	mv	s2,a0

  acquire(&wait_lock);
    80002722:	0000f517          	auipc	a0,0xf
    80002726:	b9650513          	addi	a0,a0,-1130 # 800112b8 <wait_lock>
    8000272a:	ffffe097          	auipc	ra,0xffffe
    8000272e:	4a6080e7          	jalr	1190(ra) # 80000bd0 <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    80002732:	4b81                	li	s7,0

        // make sure the child isn't still in exit() or swtch().
        acquire(&np->lock);

        havekids = 1;
        if(np->state == ZOMBIE){
    80002734:	4a15                	li	s4,5
        havekids = 1;
    80002736:	4a85                	li	s5,1
    for(np = proc; np < &proc[NPROC]; np++){
    80002738:	00015997          	auipc	s3,0x15
    8000273c:	f9898993          	addi	s3,s3,-104 # 800176d0 <tickslock>
      release(&wait_lock);
      return -1;
    }
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80002740:	0000fc17          	auipc	s8,0xf
    80002744:	b78c0c13          	addi	s8,s8,-1160 # 800112b8 <wait_lock>
    havekids = 0;
    80002748:	86de                	mv	a3,s7
    for(np = proc; np < &proc[NPROC]; np++){
    8000274a:	0000f497          	auipc	s1,0xf
    8000274e:	f8648493          	addi	s1,s1,-122 # 800116d0 <proc>
    80002752:	a095                	j	800027b6 <join+0xb8>
          *stack = (void *) np->bottom_ustack; //Debe apuntar al principio o cabeza de stack?
    80002754:	1704b783          	ld	a5,368(s1)
    80002758:	00fb3023          	sd	a5,0(s6)
          pid = np->pid;
    8000275c:	0304a903          	lw	s2,48(s1)
          np->trapframe = 0;
    80002760:	0404bc23          	sd	zero,88(s1)
          np->pagetable = 0; //no modifica tabla de paginas del padre
    80002764:	0404b823          	sd	zero,80(s1)
          np->sz = 0; //no modifica sz del padre
    80002768:	0404b423          	sd	zero,72(s1)
          np->pid = 0; //lock tomado
    8000276c:	0204a823          	sw	zero,48(s1)
          np->parent = 0;
    80002770:	0204bc23          	sd	zero,56(s1)
          np->name[0] = 0;
    80002774:	14048c23          	sb	zero,344(s1)
          np->chan = 0; //?? no se que es, lock tomado
    80002778:	0204b023          	sd	zero,32(s1)
          np->killed = 0; //lock tomado
    8000277c:	0204a423          	sw	zero,40(s1)
          np->xstate = 0; //lock está tomado
    80002780:	0204a623          	sw	zero,44(s1)
          np->state = UNUSED; //lock tomado
    80002784:	0004ac23          	sw	zero,24(s1)
          np->referencias = np->referencias -1;
    80002788:	1784a783          	lw	a5,376(s1)
    8000278c:	37fd                	addiw	a5,a5,-1
    8000278e:	16f4ac23          	sw	a5,376(s1)
          release(&np->lock); //libera thread
    80002792:	8526                	mv	a0,s1
    80002794:	ffffe097          	auipc	ra,0xffffe
    80002798:	4f0080e7          	jalr	1264(ra) # 80000c84 <release>
          release(&wait_lock);
    8000279c:	0000f517          	auipc	a0,0xf
    800027a0:	b1c50513          	addi	a0,a0,-1252 # 800112b8 <wait_lock>
    800027a4:	ffffe097          	auipc	ra,0xffffe
    800027a8:	4e0080e7          	jalr	1248(ra) # 80000c84 <release>
          return pid; //devolvemos TID 
    800027ac:	a889                	j	800027fe <join+0x100>
    for(np = proc; np < &proc[NPROC]; np++){
    800027ae:	18048493          	addi	s1,s1,384
    800027b2:	03348963          	beq	s1,s3,800027e4 <join+0xe6>
      if(np->parent == p && np->pagetable == p->pagetable){ //modificamos la condición para que se seleccione solo al thread hijo del proceso
    800027b6:	7c9c                	ld	a5,56(s1)
    800027b8:	ff279be3          	bne	a5,s2,800027ae <join+0xb0>
    800027bc:	68b8                	ld	a4,80(s1)
    800027be:	05093783          	ld	a5,80(s2)
    800027c2:	fef716e3          	bne	a4,a5,800027ae <join+0xb0>
        acquire(&np->lock);
    800027c6:	8526                	mv	a0,s1
    800027c8:	ffffe097          	auipc	ra,0xffffe
    800027cc:	408080e7          	jalr	1032(ra) # 80000bd0 <acquire>
        if(np->state == ZOMBIE){
    800027d0:	4c9c                	lw	a5,24(s1)
    800027d2:	f94781e3          	beq	a5,s4,80002754 <join+0x56>
        release(&np->lock);
    800027d6:	8526                	mv	a0,s1
    800027d8:	ffffe097          	auipc	ra,0xffffe
    800027dc:	4ac080e7          	jalr	1196(ra) # 80000c84 <release>
        havekids = 1;
    800027e0:	86d6                	mv	a3,s5
    800027e2:	b7f1                	j	800027ae <join+0xb0>
    if(!havekids || p->killed){
    800027e4:	c681                	beqz	a3,800027ec <join+0xee>
    800027e6:	02892783          	lw	a5,40(s2)
    800027ea:	c79d                	beqz	a5,80002818 <join+0x11a>
      release(&wait_lock);
    800027ec:	0000f517          	auipc	a0,0xf
    800027f0:	acc50513          	addi	a0,a0,-1332 # 800112b8 <wait_lock>
    800027f4:	ffffe097          	auipc	ra,0xffffe
    800027f8:	490080e7          	jalr	1168(ra) # 80000c84 <release>
      return -1;
    800027fc:	597d                	li	s2,-1
  }

    800027fe:	854a                	mv	a0,s2
    80002800:	60a6                	ld	ra,72(sp)
    80002802:	6406                	ld	s0,64(sp)
    80002804:	74e2                	ld	s1,56(sp)
    80002806:	7942                	ld	s2,48(sp)
    80002808:	79a2                	ld	s3,40(sp)
    8000280a:	7a02                	ld	s4,32(sp)
    8000280c:	6ae2                	ld	s5,24(sp)
    8000280e:	6b42                	ld	s6,16(sp)
    80002810:	6ba2                	ld	s7,8(sp)
    80002812:	6c02                	ld	s8,0(sp)
    80002814:	6161                	addi	sp,sp,80
    80002816:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80002818:	85e2                	mv	a1,s8
    8000281a:	854a                	mv	a0,s2
    8000281c:	00000097          	auipc	ra,0x0
    80002820:	846080e7          	jalr	-1978(ra) # 80002062 <sleep>
    havekids = 0;
    80002824:	b715                	j	80002748 <join+0x4a>

0000000080002826 <swtch>:
    80002826:	00153023          	sd	ra,0(a0)
    8000282a:	00253423          	sd	sp,8(a0)
    8000282e:	e900                	sd	s0,16(a0)
    80002830:	ed04                	sd	s1,24(a0)
    80002832:	03253023          	sd	s2,32(a0)
    80002836:	03353423          	sd	s3,40(a0)
    8000283a:	03453823          	sd	s4,48(a0)
    8000283e:	03553c23          	sd	s5,56(a0)
    80002842:	05653023          	sd	s6,64(a0)
    80002846:	05753423          	sd	s7,72(a0)
    8000284a:	05853823          	sd	s8,80(a0)
    8000284e:	05953c23          	sd	s9,88(a0)
    80002852:	07a53023          	sd	s10,96(a0)
    80002856:	07b53423          	sd	s11,104(a0)
    8000285a:	0005b083          	ld	ra,0(a1)
    8000285e:	0085b103          	ld	sp,8(a1)
    80002862:	6980                	ld	s0,16(a1)
    80002864:	6d84                	ld	s1,24(a1)
    80002866:	0205b903          	ld	s2,32(a1)
    8000286a:	0285b983          	ld	s3,40(a1)
    8000286e:	0305ba03          	ld	s4,48(a1)
    80002872:	0385ba83          	ld	s5,56(a1)
    80002876:	0405bb03          	ld	s6,64(a1)
    8000287a:	0485bb83          	ld	s7,72(a1)
    8000287e:	0505bc03          	ld	s8,80(a1)
    80002882:	0585bc83          	ld	s9,88(a1)
    80002886:	0605bd03          	ld	s10,96(a1)
    8000288a:	0685bd83          	ld	s11,104(a1)
    8000288e:	8082                	ret

0000000080002890 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80002890:	1141                	addi	sp,sp,-16
    80002892:	e406                	sd	ra,8(sp)
    80002894:	e022                	sd	s0,0(sp)
    80002896:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80002898:	00006597          	auipc	a1,0x6
    8000289c:	aa058593          	addi	a1,a1,-1376 # 80008338 <states.0+0x30>
    800028a0:	00015517          	auipc	a0,0x15
    800028a4:	e3050513          	addi	a0,a0,-464 # 800176d0 <tickslock>
    800028a8:	ffffe097          	auipc	ra,0xffffe
    800028ac:	298080e7          	jalr	664(ra) # 80000b40 <initlock>
}
    800028b0:	60a2                	ld	ra,8(sp)
    800028b2:	6402                	ld	s0,0(sp)
    800028b4:	0141                	addi	sp,sp,16
    800028b6:	8082                	ret

00000000800028b8 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    800028b8:	1141                	addi	sp,sp,-16
    800028ba:	e422                	sd	s0,8(sp)
    800028bc:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    800028be:	00003797          	auipc	a5,0x3
    800028c2:	52278793          	addi	a5,a5,1314 # 80005de0 <kernelvec>
    800028c6:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    800028ca:	6422                	ld	s0,8(sp)
    800028cc:	0141                	addi	sp,sp,16
    800028ce:	8082                	ret

00000000800028d0 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    800028d0:	1141                	addi	sp,sp,-16
    800028d2:	e406                	sd	ra,8(sp)
    800028d4:	e022                	sd	s0,0(sp)
    800028d6:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    800028d8:	fffff097          	auipc	ra,0xfffff
    800028dc:	0be080e7          	jalr	190(ra) # 80001996 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800028e0:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800028e4:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800028e6:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    800028ea:	00004617          	auipc	a2,0x4
    800028ee:	71660613          	addi	a2,a2,1814 # 80007000 <_trampoline>
    800028f2:	00004697          	auipc	a3,0x4
    800028f6:	70e68693          	addi	a3,a3,1806 # 80007000 <_trampoline>
    800028fa:	8e91                	sub	a3,a3,a2
    800028fc:	040007b7          	lui	a5,0x4000
    80002900:	17fd                	addi	a5,a5,-1
    80002902:	07b2                	slli	a5,a5,0xc
    80002904:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002906:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    8000290a:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    8000290c:	180026f3          	csrr	a3,satp
    80002910:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80002912:	6d38                	ld	a4,88(a0)
    80002914:	6134                	ld	a3,64(a0)
    80002916:	6585                	lui	a1,0x1
    80002918:	96ae                	add	a3,a3,a1
    8000291a:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    8000291c:	6d38                	ld	a4,88(a0)
    8000291e:	00000697          	auipc	a3,0x0
    80002922:	13868693          	addi	a3,a3,312 # 80002a56 <usertrap>
    80002926:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80002928:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    8000292a:	8692                	mv	a3,tp
    8000292c:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000292e:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80002932:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80002936:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000293a:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    8000293e:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002940:	6f18                	ld	a4,24(a4)
    80002942:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80002946:	692c                	ld	a1,80(a0)
    80002948:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    8000294a:	00004717          	auipc	a4,0x4
    8000294e:	74670713          	addi	a4,a4,1862 # 80007090 <userret>
    80002952:	8f11                	sub	a4,a4,a2
    80002954:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80002956:	577d                	li	a4,-1
    80002958:	177e                	slli	a4,a4,0x3f
    8000295a:	8dd9                	or	a1,a1,a4
    8000295c:	02000537          	lui	a0,0x2000
    80002960:	157d                	addi	a0,a0,-1
    80002962:	0536                	slli	a0,a0,0xd
    80002964:	9782                	jalr	a5
}
    80002966:	60a2                	ld	ra,8(sp)
    80002968:	6402                	ld	s0,0(sp)
    8000296a:	0141                	addi	sp,sp,16
    8000296c:	8082                	ret

000000008000296e <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    8000296e:	1101                	addi	sp,sp,-32
    80002970:	ec06                	sd	ra,24(sp)
    80002972:	e822                	sd	s0,16(sp)
    80002974:	e426                	sd	s1,8(sp)
    80002976:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80002978:	00015497          	auipc	s1,0x15
    8000297c:	d5848493          	addi	s1,s1,-680 # 800176d0 <tickslock>
    80002980:	8526                	mv	a0,s1
    80002982:	ffffe097          	auipc	ra,0xffffe
    80002986:	24e080e7          	jalr	590(ra) # 80000bd0 <acquire>
  ticks++;
    8000298a:	00006517          	auipc	a0,0x6
    8000298e:	6a650513          	addi	a0,a0,1702 # 80009030 <ticks>
    80002992:	411c                	lw	a5,0(a0)
    80002994:	2785                	addiw	a5,a5,1
    80002996:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80002998:	00000097          	auipc	ra,0x0
    8000299c:	866080e7          	jalr	-1946(ra) # 800021fe <wakeup>
  release(&tickslock);
    800029a0:	8526                	mv	a0,s1
    800029a2:	ffffe097          	auipc	ra,0xffffe
    800029a6:	2e2080e7          	jalr	738(ra) # 80000c84 <release>
}
    800029aa:	60e2                	ld	ra,24(sp)
    800029ac:	6442                	ld	s0,16(sp)
    800029ae:	64a2                	ld	s1,8(sp)
    800029b0:	6105                	addi	sp,sp,32
    800029b2:	8082                	ret

00000000800029b4 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    800029b4:	1101                	addi	sp,sp,-32
    800029b6:	ec06                	sd	ra,24(sp)
    800029b8:	e822                	sd	s0,16(sp)
    800029ba:	e426                	sd	s1,8(sp)
    800029bc:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    800029be:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    800029c2:	00074d63          	bltz	a4,800029dc <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    800029c6:	57fd                	li	a5,-1
    800029c8:	17fe                	slli	a5,a5,0x3f
    800029ca:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    800029cc:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    800029ce:	06f70363          	beq	a4,a5,80002a34 <devintr+0x80>
  }
}
    800029d2:	60e2                	ld	ra,24(sp)
    800029d4:	6442                	ld	s0,16(sp)
    800029d6:	64a2                	ld	s1,8(sp)
    800029d8:	6105                	addi	sp,sp,32
    800029da:	8082                	ret
     (scause & 0xff) == 9){
    800029dc:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    800029e0:	46a5                	li	a3,9
    800029e2:	fed792e3          	bne	a5,a3,800029c6 <devintr+0x12>
    int irq = plic_claim();
    800029e6:	00003097          	auipc	ra,0x3
    800029ea:	502080e7          	jalr	1282(ra) # 80005ee8 <plic_claim>
    800029ee:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    800029f0:	47a9                	li	a5,10
    800029f2:	02f50763          	beq	a0,a5,80002a20 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    800029f6:	4785                	li	a5,1
    800029f8:	02f50963          	beq	a0,a5,80002a2a <devintr+0x76>
    return 1;
    800029fc:	4505                	li	a0,1
    } else if(irq){
    800029fe:	d8f1                	beqz	s1,800029d2 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80002a00:	85a6                	mv	a1,s1
    80002a02:	00006517          	auipc	a0,0x6
    80002a06:	93e50513          	addi	a0,a0,-1730 # 80008340 <states.0+0x38>
    80002a0a:	ffffe097          	auipc	ra,0xffffe
    80002a0e:	b78080e7          	jalr	-1160(ra) # 80000582 <printf>
      plic_complete(irq);
    80002a12:	8526                	mv	a0,s1
    80002a14:	00003097          	auipc	ra,0x3
    80002a18:	4f8080e7          	jalr	1272(ra) # 80005f0c <plic_complete>
    return 1;
    80002a1c:	4505                	li	a0,1
    80002a1e:	bf55                	j	800029d2 <devintr+0x1e>
      uartintr();
    80002a20:	ffffe097          	auipc	ra,0xffffe
    80002a24:	f74080e7          	jalr	-140(ra) # 80000994 <uartintr>
    80002a28:	b7ed                	j	80002a12 <devintr+0x5e>
      virtio_disk_intr();
    80002a2a:	00004097          	auipc	ra,0x4
    80002a2e:	974080e7          	jalr	-1676(ra) # 8000639e <virtio_disk_intr>
    80002a32:	b7c5                	j	80002a12 <devintr+0x5e>
    if(cpuid() == 0){
    80002a34:	fffff097          	auipc	ra,0xfffff
    80002a38:	f36080e7          	jalr	-202(ra) # 8000196a <cpuid>
    80002a3c:	c901                	beqz	a0,80002a4c <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80002a3e:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80002a42:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80002a44:	14479073          	csrw	sip,a5
    return 2;
    80002a48:	4509                	li	a0,2
    80002a4a:	b761                	j	800029d2 <devintr+0x1e>
      clockintr();
    80002a4c:	00000097          	auipc	ra,0x0
    80002a50:	f22080e7          	jalr	-222(ra) # 8000296e <clockintr>
    80002a54:	b7ed                	j	80002a3e <devintr+0x8a>

0000000080002a56 <usertrap>:
{
    80002a56:	1101                	addi	sp,sp,-32
    80002a58:	ec06                	sd	ra,24(sp)
    80002a5a:	e822                	sd	s0,16(sp)
    80002a5c:	e426                	sd	s1,8(sp)
    80002a5e:	e04a                	sd	s2,0(sp)
    80002a60:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002a62:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80002a66:	1007f793          	andi	a5,a5,256
    80002a6a:	e3ad                	bnez	a5,80002acc <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002a6c:	00003797          	auipc	a5,0x3
    80002a70:	37478793          	addi	a5,a5,884 # 80005de0 <kernelvec>
    80002a74:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80002a78:	fffff097          	auipc	ra,0xfffff
    80002a7c:	f1e080e7          	jalr	-226(ra) # 80001996 <myproc>
    80002a80:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80002a82:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002a84:	14102773          	csrr	a4,sepc
    80002a88:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002a8a:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80002a8e:	47a1                	li	a5,8
    80002a90:	04f71c63          	bne	a4,a5,80002ae8 <usertrap+0x92>
    if(p->killed)
    80002a94:	551c                	lw	a5,40(a0)
    80002a96:	e3b9                	bnez	a5,80002adc <usertrap+0x86>
    p->trapframe->epc += 4;
    80002a98:	6cb8                	ld	a4,88(s1)
    80002a9a:	6f1c                	ld	a5,24(a4)
    80002a9c:	0791                	addi	a5,a5,4
    80002a9e:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002aa0:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002aa4:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002aa8:	10079073          	csrw	sstatus,a5
    syscall();
    80002aac:	00000097          	auipc	ra,0x0
    80002ab0:	2e0080e7          	jalr	736(ra) # 80002d8c <syscall>
  if(p->killed)
    80002ab4:	549c                	lw	a5,40(s1)
    80002ab6:	ebc1                	bnez	a5,80002b46 <usertrap+0xf0>
  usertrapret();
    80002ab8:	00000097          	auipc	ra,0x0
    80002abc:	e18080e7          	jalr	-488(ra) # 800028d0 <usertrapret>
}
    80002ac0:	60e2                	ld	ra,24(sp)
    80002ac2:	6442                	ld	s0,16(sp)
    80002ac4:	64a2                	ld	s1,8(sp)
    80002ac6:	6902                	ld	s2,0(sp)
    80002ac8:	6105                	addi	sp,sp,32
    80002aca:	8082                	ret
    panic("usertrap: not from user mode");
    80002acc:	00006517          	auipc	a0,0x6
    80002ad0:	89450513          	addi	a0,a0,-1900 # 80008360 <states.0+0x58>
    80002ad4:	ffffe097          	auipc	ra,0xffffe
    80002ad8:	a64080e7          	jalr	-1436(ra) # 80000538 <panic>
      exit(-1);
    80002adc:	557d                	li	a0,-1
    80002ade:	fffff097          	auipc	ra,0xfffff
    80002ae2:	7f0080e7          	jalr	2032(ra) # 800022ce <exit>
    80002ae6:	bf4d                	j	80002a98 <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    80002ae8:	00000097          	auipc	ra,0x0
    80002aec:	ecc080e7          	jalr	-308(ra) # 800029b4 <devintr>
    80002af0:	892a                	mv	s2,a0
    80002af2:	c501                	beqz	a0,80002afa <usertrap+0xa4>
  if(p->killed)
    80002af4:	549c                	lw	a5,40(s1)
    80002af6:	c3a1                	beqz	a5,80002b36 <usertrap+0xe0>
    80002af8:	a815                	j	80002b2c <usertrap+0xd6>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002afa:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80002afe:	5890                	lw	a2,48(s1)
    80002b00:	00006517          	auipc	a0,0x6
    80002b04:	88050513          	addi	a0,a0,-1920 # 80008380 <states.0+0x78>
    80002b08:	ffffe097          	auipc	ra,0xffffe
    80002b0c:	a7a080e7          	jalr	-1414(ra) # 80000582 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002b10:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002b14:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002b18:	00006517          	auipc	a0,0x6
    80002b1c:	89850513          	addi	a0,a0,-1896 # 800083b0 <states.0+0xa8>
    80002b20:	ffffe097          	auipc	ra,0xffffe
    80002b24:	a62080e7          	jalr	-1438(ra) # 80000582 <printf>
    p->killed = 1;
    80002b28:	4785                	li	a5,1
    80002b2a:	d49c                	sw	a5,40(s1)
    exit(-1);
    80002b2c:	557d                	li	a0,-1
    80002b2e:	fffff097          	auipc	ra,0xfffff
    80002b32:	7a0080e7          	jalr	1952(ra) # 800022ce <exit>
  if(which_dev == 2)
    80002b36:	4789                	li	a5,2
    80002b38:	f8f910e3          	bne	s2,a5,80002ab8 <usertrap+0x62>
    yield();
    80002b3c:	fffff097          	auipc	ra,0xfffff
    80002b40:	4ea080e7          	jalr	1258(ra) # 80002026 <yield>
    80002b44:	bf95                	j	80002ab8 <usertrap+0x62>
  int which_dev = 0;
    80002b46:	4901                	li	s2,0
    80002b48:	b7d5                	j	80002b2c <usertrap+0xd6>

0000000080002b4a <kerneltrap>:
{
    80002b4a:	7179                	addi	sp,sp,-48
    80002b4c:	f406                	sd	ra,40(sp)
    80002b4e:	f022                	sd	s0,32(sp)
    80002b50:	ec26                	sd	s1,24(sp)
    80002b52:	e84a                	sd	s2,16(sp)
    80002b54:	e44e                	sd	s3,8(sp)
    80002b56:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002b58:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002b5c:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002b60:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80002b64:	1004f793          	andi	a5,s1,256
    80002b68:	cb85                	beqz	a5,80002b98 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002b6a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80002b6e:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80002b70:	ef85                	bnez	a5,80002ba8 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80002b72:	00000097          	auipc	ra,0x0
    80002b76:	e42080e7          	jalr	-446(ra) # 800029b4 <devintr>
    80002b7a:	cd1d                	beqz	a0,80002bb8 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002b7c:	4789                	li	a5,2
    80002b7e:	06f50a63          	beq	a0,a5,80002bf2 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002b82:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002b86:	10049073          	csrw	sstatus,s1
}
    80002b8a:	70a2                	ld	ra,40(sp)
    80002b8c:	7402                	ld	s0,32(sp)
    80002b8e:	64e2                	ld	s1,24(sp)
    80002b90:	6942                	ld	s2,16(sp)
    80002b92:	69a2                	ld	s3,8(sp)
    80002b94:	6145                	addi	sp,sp,48
    80002b96:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80002b98:	00006517          	auipc	a0,0x6
    80002b9c:	83850513          	addi	a0,a0,-1992 # 800083d0 <states.0+0xc8>
    80002ba0:	ffffe097          	auipc	ra,0xffffe
    80002ba4:	998080e7          	jalr	-1640(ra) # 80000538 <panic>
    panic("kerneltrap: interrupts enabled");
    80002ba8:	00006517          	auipc	a0,0x6
    80002bac:	85050513          	addi	a0,a0,-1968 # 800083f8 <states.0+0xf0>
    80002bb0:	ffffe097          	auipc	ra,0xffffe
    80002bb4:	988080e7          	jalr	-1656(ra) # 80000538 <panic>
    printf("scause %p\n", scause);
    80002bb8:	85ce                	mv	a1,s3
    80002bba:	00006517          	auipc	a0,0x6
    80002bbe:	85e50513          	addi	a0,a0,-1954 # 80008418 <states.0+0x110>
    80002bc2:	ffffe097          	auipc	ra,0xffffe
    80002bc6:	9c0080e7          	jalr	-1600(ra) # 80000582 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002bca:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002bce:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002bd2:	00006517          	auipc	a0,0x6
    80002bd6:	85650513          	addi	a0,a0,-1962 # 80008428 <states.0+0x120>
    80002bda:	ffffe097          	auipc	ra,0xffffe
    80002bde:	9a8080e7          	jalr	-1624(ra) # 80000582 <printf>
    panic("kerneltrap");
    80002be2:	00006517          	auipc	a0,0x6
    80002be6:	85e50513          	addi	a0,a0,-1954 # 80008440 <states.0+0x138>
    80002bea:	ffffe097          	auipc	ra,0xffffe
    80002bee:	94e080e7          	jalr	-1714(ra) # 80000538 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002bf2:	fffff097          	auipc	ra,0xfffff
    80002bf6:	da4080e7          	jalr	-604(ra) # 80001996 <myproc>
    80002bfa:	d541                	beqz	a0,80002b82 <kerneltrap+0x38>
    80002bfc:	fffff097          	auipc	ra,0xfffff
    80002c00:	d9a080e7          	jalr	-614(ra) # 80001996 <myproc>
    80002c04:	4d18                	lw	a4,24(a0)
    80002c06:	4791                	li	a5,4
    80002c08:	f6f71de3          	bne	a4,a5,80002b82 <kerneltrap+0x38>
    yield();
    80002c0c:	fffff097          	auipc	ra,0xfffff
    80002c10:	41a080e7          	jalr	1050(ra) # 80002026 <yield>
    80002c14:	b7bd                	j	80002b82 <kerneltrap+0x38>

0000000080002c16 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002c16:	1101                	addi	sp,sp,-32
    80002c18:	ec06                	sd	ra,24(sp)
    80002c1a:	e822                	sd	s0,16(sp)
    80002c1c:	e426                	sd	s1,8(sp)
    80002c1e:	1000                	addi	s0,sp,32
    80002c20:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80002c22:	fffff097          	auipc	ra,0xfffff
    80002c26:	d74080e7          	jalr	-652(ra) # 80001996 <myproc>
  switch (n) {
    80002c2a:	4795                	li	a5,5
    80002c2c:	0497e163          	bltu	a5,s1,80002c6e <argraw+0x58>
    80002c30:	048a                	slli	s1,s1,0x2
    80002c32:	00006717          	auipc	a4,0x6
    80002c36:	84670713          	addi	a4,a4,-1978 # 80008478 <states.0+0x170>
    80002c3a:	94ba                	add	s1,s1,a4
    80002c3c:	409c                	lw	a5,0(s1)
    80002c3e:	97ba                	add	a5,a5,a4
    80002c40:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80002c42:	6d3c                	ld	a5,88(a0)
    80002c44:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002c46:	60e2                	ld	ra,24(sp)
    80002c48:	6442                	ld	s0,16(sp)
    80002c4a:	64a2                	ld	s1,8(sp)
    80002c4c:	6105                	addi	sp,sp,32
    80002c4e:	8082                	ret
    return p->trapframe->a1;
    80002c50:	6d3c                	ld	a5,88(a0)
    80002c52:	7fa8                	ld	a0,120(a5)
    80002c54:	bfcd                	j	80002c46 <argraw+0x30>
    return p->trapframe->a2;
    80002c56:	6d3c                	ld	a5,88(a0)
    80002c58:	63c8                	ld	a0,128(a5)
    80002c5a:	b7f5                	j	80002c46 <argraw+0x30>
    return p->trapframe->a3;
    80002c5c:	6d3c                	ld	a5,88(a0)
    80002c5e:	67c8                	ld	a0,136(a5)
    80002c60:	b7dd                	j	80002c46 <argraw+0x30>
    return p->trapframe->a4;
    80002c62:	6d3c                	ld	a5,88(a0)
    80002c64:	6bc8                	ld	a0,144(a5)
    80002c66:	b7c5                	j	80002c46 <argraw+0x30>
    return p->trapframe->a5;
    80002c68:	6d3c                	ld	a5,88(a0)
    80002c6a:	6fc8                	ld	a0,152(a5)
    80002c6c:	bfe9                	j	80002c46 <argraw+0x30>
  panic("argraw");
    80002c6e:	00005517          	auipc	a0,0x5
    80002c72:	7e250513          	addi	a0,a0,2018 # 80008450 <states.0+0x148>
    80002c76:	ffffe097          	auipc	ra,0xffffe
    80002c7a:	8c2080e7          	jalr	-1854(ra) # 80000538 <panic>

0000000080002c7e <fetchaddr>:
{
    80002c7e:	1101                	addi	sp,sp,-32
    80002c80:	ec06                	sd	ra,24(sp)
    80002c82:	e822                	sd	s0,16(sp)
    80002c84:	e426                	sd	s1,8(sp)
    80002c86:	e04a                	sd	s2,0(sp)
    80002c88:	1000                	addi	s0,sp,32
    80002c8a:	84aa                	mv	s1,a0
    80002c8c:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002c8e:	fffff097          	auipc	ra,0xfffff
    80002c92:	d08080e7          	jalr	-760(ra) # 80001996 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80002c96:	653c                	ld	a5,72(a0)
    80002c98:	02f4f863          	bgeu	s1,a5,80002cc8 <fetchaddr+0x4a>
    80002c9c:	00848713          	addi	a4,s1,8
    80002ca0:	02e7e663          	bltu	a5,a4,80002ccc <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002ca4:	46a1                	li	a3,8
    80002ca6:	8626                	mv	a2,s1
    80002ca8:	85ca                	mv	a1,s2
    80002caa:	6928                	ld	a0,80(a0)
    80002cac:	fffff097          	auipc	ra,0xfffff
    80002cb0:	a36080e7          	jalr	-1482(ra) # 800016e2 <copyin>
    80002cb4:	00a03533          	snez	a0,a0
    80002cb8:	40a00533          	neg	a0,a0
}
    80002cbc:	60e2                	ld	ra,24(sp)
    80002cbe:	6442                	ld	s0,16(sp)
    80002cc0:	64a2                	ld	s1,8(sp)
    80002cc2:	6902                	ld	s2,0(sp)
    80002cc4:	6105                	addi	sp,sp,32
    80002cc6:	8082                	ret
    return -1;
    80002cc8:	557d                	li	a0,-1
    80002cca:	bfcd                	j	80002cbc <fetchaddr+0x3e>
    80002ccc:	557d                	li	a0,-1
    80002cce:	b7fd                	j	80002cbc <fetchaddr+0x3e>

0000000080002cd0 <fetchstr>:
{
    80002cd0:	7179                	addi	sp,sp,-48
    80002cd2:	f406                	sd	ra,40(sp)
    80002cd4:	f022                	sd	s0,32(sp)
    80002cd6:	ec26                	sd	s1,24(sp)
    80002cd8:	e84a                	sd	s2,16(sp)
    80002cda:	e44e                	sd	s3,8(sp)
    80002cdc:	1800                	addi	s0,sp,48
    80002cde:	892a                	mv	s2,a0
    80002ce0:	84ae                	mv	s1,a1
    80002ce2:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80002ce4:	fffff097          	auipc	ra,0xfffff
    80002ce8:	cb2080e7          	jalr	-846(ra) # 80001996 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    80002cec:	86ce                	mv	a3,s3
    80002cee:	864a                	mv	a2,s2
    80002cf0:	85a6                	mv	a1,s1
    80002cf2:	6928                	ld	a0,80(a0)
    80002cf4:	fffff097          	auipc	ra,0xfffff
    80002cf8:	a7c080e7          	jalr	-1412(ra) # 80001770 <copyinstr>
  if(err < 0)
    80002cfc:	00054763          	bltz	a0,80002d0a <fetchstr+0x3a>
  return strlen(buf);
    80002d00:	8526                	mv	a0,s1
    80002d02:	ffffe097          	auipc	ra,0xffffe
    80002d06:	146080e7          	jalr	326(ra) # 80000e48 <strlen>
}
    80002d0a:	70a2                	ld	ra,40(sp)
    80002d0c:	7402                	ld	s0,32(sp)
    80002d0e:	64e2                	ld	s1,24(sp)
    80002d10:	6942                	ld	s2,16(sp)
    80002d12:	69a2                	ld	s3,8(sp)
    80002d14:	6145                	addi	sp,sp,48
    80002d16:	8082                	ret

0000000080002d18 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80002d18:	1101                	addi	sp,sp,-32
    80002d1a:	ec06                	sd	ra,24(sp)
    80002d1c:	e822                	sd	s0,16(sp)
    80002d1e:	e426                	sd	s1,8(sp)
    80002d20:	1000                	addi	s0,sp,32
    80002d22:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002d24:	00000097          	auipc	ra,0x0
    80002d28:	ef2080e7          	jalr	-270(ra) # 80002c16 <argraw>
    80002d2c:	c088                	sw	a0,0(s1)
  return 0;
}
    80002d2e:	4501                	li	a0,0
    80002d30:	60e2                	ld	ra,24(sp)
    80002d32:	6442                	ld	s0,16(sp)
    80002d34:	64a2                	ld	s1,8(sp)
    80002d36:	6105                	addi	sp,sp,32
    80002d38:	8082                	ret

0000000080002d3a <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80002d3a:	1101                	addi	sp,sp,-32
    80002d3c:	ec06                	sd	ra,24(sp)
    80002d3e:	e822                	sd	s0,16(sp)
    80002d40:	e426                	sd	s1,8(sp)
    80002d42:	1000                	addi	s0,sp,32
    80002d44:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002d46:	00000097          	auipc	ra,0x0
    80002d4a:	ed0080e7          	jalr	-304(ra) # 80002c16 <argraw>
    80002d4e:	e088                	sd	a0,0(s1)
  return 0;
}
    80002d50:	4501                	li	a0,0
    80002d52:	60e2                	ld	ra,24(sp)
    80002d54:	6442                	ld	s0,16(sp)
    80002d56:	64a2                	ld	s1,8(sp)
    80002d58:	6105                	addi	sp,sp,32
    80002d5a:	8082                	ret

0000000080002d5c <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002d5c:	1101                	addi	sp,sp,-32
    80002d5e:	ec06                	sd	ra,24(sp)
    80002d60:	e822                	sd	s0,16(sp)
    80002d62:	e426                	sd	s1,8(sp)
    80002d64:	e04a                	sd	s2,0(sp)
    80002d66:	1000                	addi	s0,sp,32
    80002d68:	84ae                	mv	s1,a1
    80002d6a:	8932                	mv	s2,a2
  *ip = argraw(n);
    80002d6c:	00000097          	auipc	ra,0x0
    80002d70:	eaa080e7          	jalr	-342(ra) # 80002c16 <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80002d74:	864a                	mv	a2,s2
    80002d76:	85a6                	mv	a1,s1
    80002d78:	00000097          	auipc	ra,0x0
    80002d7c:	f58080e7          	jalr	-168(ra) # 80002cd0 <fetchstr>
}
    80002d80:	60e2                	ld	ra,24(sp)
    80002d82:	6442                	ld	s0,16(sp)
    80002d84:	64a2                	ld	s1,8(sp)
    80002d86:	6902                	ld	s2,0(sp)
    80002d88:	6105                	addi	sp,sp,32
    80002d8a:	8082                	ret

0000000080002d8c <syscall>:
[SYS_join]    sys_join
};

void
syscall(void)
{
    80002d8c:	1101                	addi	sp,sp,-32
    80002d8e:	ec06                	sd	ra,24(sp)
    80002d90:	e822                	sd	s0,16(sp)
    80002d92:	e426                	sd	s1,8(sp)
    80002d94:	e04a                	sd	s2,0(sp)
    80002d96:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002d98:	fffff097          	auipc	ra,0xfffff
    80002d9c:	bfe080e7          	jalr	-1026(ra) # 80001996 <myproc>
    80002da0:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80002da2:	05853903          	ld	s2,88(a0)
    80002da6:	0a893783          	ld	a5,168(s2)
    80002daa:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002dae:	37fd                	addiw	a5,a5,-1
    80002db0:	4759                	li	a4,22
    80002db2:	00f76f63          	bltu	a4,a5,80002dd0 <syscall+0x44>
    80002db6:	00369713          	slli	a4,a3,0x3
    80002dba:	00005797          	auipc	a5,0x5
    80002dbe:	6d678793          	addi	a5,a5,1750 # 80008490 <syscalls>
    80002dc2:	97ba                	add	a5,a5,a4
    80002dc4:	639c                	ld	a5,0(a5)
    80002dc6:	c789                	beqz	a5,80002dd0 <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    80002dc8:	9782                	jalr	a5
    80002dca:	06a93823          	sd	a0,112(s2)
    80002dce:	a839                	j	80002dec <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002dd0:	15848613          	addi	a2,s1,344
    80002dd4:	588c                	lw	a1,48(s1)
    80002dd6:	00005517          	auipc	a0,0x5
    80002dda:	68250513          	addi	a0,a0,1666 # 80008458 <states.0+0x150>
    80002dde:	ffffd097          	auipc	ra,0xffffd
    80002de2:	7a4080e7          	jalr	1956(ra) # 80000582 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80002de6:	6cbc                	ld	a5,88(s1)
    80002de8:	577d                	li	a4,-1
    80002dea:	fbb8                	sd	a4,112(a5)
  }
}
    80002dec:	60e2                	ld	ra,24(sp)
    80002dee:	6442                	ld	s0,16(sp)
    80002df0:	64a2                	ld	s1,8(sp)
    80002df2:	6902                	ld	s2,0(sp)
    80002df4:	6105                	addi	sp,sp,32
    80002df6:	8082                	ret

0000000080002df8 <sys_clone>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_clone (void)
{
    80002df8:	7179                	addi	sp,sp,-48
    80002dfa:	f406                	sd	ra,40(sp)
    80002dfc:	f022                	sd	s0,32(sp)
    80002dfe:	1800                	addi	s0,sp,48
  uint64 stack;
  uint64 arg;
  uint64 fcn;

   //obtenemos puntero función
   if(argaddr(2, &fcn) < 0){
    80002e00:	fd840593          	addi	a1,s0,-40
    80002e04:	4509                	li	a0,2
    80002e06:	00000097          	auipc	ra,0x0
    80002e0a:	f34080e7          	jalr	-204(ra) # 80002d3a <argaddr>
     return -1;
    80002e0e:	57fd                	li	a5,-1
   if(argaddr(2, &fcn) < 0){
    80002e10:	04054163          	bltz	a0,80002e52 <sys_clone+0x5a>
   }

   //obtenemos puntero a argumento de función
   if(argaddr(1, &arg) < 0){
    80002e14:	fe040593          	addi	a1,s0,-32
    80002e18:	4505                	li	a0,1
    80002e1a:	00000097          	auipc	ra,0x0
    80002e1e:	f20080e7          	jalr	-224(ra) # 80002d3a <argaddr>
     return -1;
    80002e22:	57fd                	li	a5,-1
   if(argaddr(1, &arg) < 0){
    80002e24:	02054763          	bltz	a0,80002e52 <sys_clone+0x5a>
   }

   //obtenemos putnero a stack de usuario
   if(argaddr(0, &stack) < 0){
    80002e28:	fe840593          	addi	a1,s0,-24
    80002e2c:	4501                	li	a0,0
    80002e2e:	00000097          	auipc	ra,0x0
    80002e32:	f0c080e7          	jalr	-244(ra) # 80002d3a <argaddr>
     return -1;
    80002e36:	57fd                	li	a5,-1
   if(argaddr(0, &stack) < 0){
    80002e38:	00054d63          	bltz	a0,80002e52 <sys_clone+0x5a>
   }

  return clone((void *)fcn, (void *)arg, (void *)stack);
    80002e3c:	fe843603          	ld	a2,-24(s0)
    80002e40:	fe043583          	ld	a1,-32(s0)
    80002e44:	fd843503          	ld	a0,-40(s0)
    80002e48:	fffff097          	auipc	ra,0xfffff
    80002e4c:	728080e7          	jalr	1832(ra) # 80002570 <clone>
    80002e50:	87aa                	mv	a5,a0
}
    80002e52:	853e                	mv	a0,a5
    80002e54:	70a2                	ld	ra,40(sp)
    80002e56:	7402                	ld	s0,32(sp)
    80002e58:	6145                	addi	sp,sp,48
    80002e5a:	8082                	ret

0000000080002e5c <sys_join>:

uint64
sys_join (void)
{
    80002e5c:	1101                	addi	sp,sp,-32
    80002e5e:	ec06                	sd	ra,24(sp)
    80002e60:	e822                	sd	s0,16(sp)
    80002e62:	1000                	addi	s0,sp,32
  uint64 stack;
  if(argaddr(0, &stack) < 0){
    80002e64:	fe840593          	addi	a1,s0,-24
    80002e68:	4501                	li	a0,0
    80002e6a:	00000097          	auipc	ra,0x0
    80002e6e:	ed0080e7          	jalr	-304(ra) # 80002d3a <argaddr>
    80002e72:	87aa                	mv	a5,a0
     return -1;
    80002e74:	557d                	li	a0,-1
  if(argaddr(0, &stack) < 0){
    80002e76:	0007c863          	bltz	a5,80002e86 <sys_join+0x2a>
  }

  return join ((void **)stack);
    80002e7a:	fe843503          	ld	a0,-24(s0)
    80002e7e:	00000097          	auipc	ra,0x0
    80002e82:	880080e7          	jalr	-1920(ra) # 800026fe <join>
}
    80002e86:	60e2                	ld	ra,24(sp)
    80002e88:	6442                	ld	s0,16(sp)
    80002e8a:	6105                	addi	sp,sp,32
    80002e8c:	8082                	ret

0000000080002e8e <sys_exit>:


uint64
sys_exit(void)
{
    80002e8e:	1101                	addi	sp,sp,-32
    80002e90:	ec06                	sd	ra,24(sp)
    80002e92:	e822                	sd	s0,16(sp)
    80002e94:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80002e96:	fec40593          	addi	a1,s0,-20
    80002e9a:	4501                	li	a0,0
    80002e9c:	00000097          	auipc	ra,0x0
    80002ea0:	e7c080e7          	jalr	-388(ra) # 80002d18 <argint>
    return -1;
    80002ea4:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002ea6:	00054963          	bltz	a0,80002eb8 <sys_exit+0x2a>
  exit(n);
    80002eaa:	fec42503          	lw	a0,-20(s0)
    80002eae:	fffff097          	auipc	ra,0xfffff
    80002eb2:	420080e7          	jalr	1056(ra) # 800022ce <exit>
  return 0;  // not reached
    80002eb6:	4781                	li	a5,0
}
    80002eb8:	853e                	mv	a0,a5
    80002eba:	60e2                	ld	ra,24(sp)
    80002ebc:	6442                	ld	s0,16(sp)
    80002ebe:	6105                	addi	sp,sp,32
    80002ec0:	8082                	ret

0000000080002ec2 <sys_getpid>:

uint64
sys_getpid(void)
{
    80002ec2:	1141                	addi	sp,sp,-16
    80002ec4:	e406                	sd	ra,8(sp)
    80002ec6:	e022                	sd	s0,0(sp)
    80002ec8:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002eca:	fffff097          	auipc	ra,0xfffff
    80002ece:	acc080e7          	jalr	-1332(ra) # 80001996 <myproc>
}
    80002ed2:	5908                	lw	a0,48(a0)
    80002ed4:	60a2                	ld	ra,8(sp)
    80002ed6:	6402                	ld	s0,0(sp)
    80002ed8:	0141                	addi	sp,sp,16
    80002eda:	8082                	ret

0000000080002edc <sys_fork>:

uint64
sys_fork(void)
{
    80002edc:	1141                	addi	sp,sp,-16
    80002ede:	e406                	sd	ra,8(sp)
    80002ee0:	e022                	sd	s0,0(sp)
    80002ee2:	0800                	addi	s0,sp,16
  return fork();
    80002ee4:	fffff097          	auipc	ra,0xfffff
    80002ee8:	e8c080e7          	jalr	-372(ra) # 80001d70 <fork>
}
    80002eec:	60a2                	ld	ra,8(sp)
    80002eee:	6402                	ld	s0,0(sp)
    80002ef0:	0141                	addi	sp,sp,16
    80002ef2:	8082                	ret

0000000080002ef4 <sys_wait>:

uint64
sys_wait(void)
{
    80002ef4:	1101                	addi	sp,sp,-32
    80002ef6:	ec06                	sd	ra,24(sp)
    80002ef8:	e822                	sd	s0,16(sp)
    80002efa:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80002efc:	fe840593          	addi	a1,s0,-24
    80002f00:	4501                	li	a0,0
    80002f02:	00000097          	auipc	ra,0x0
    80002f06:	e38080e7          	jalr	-456(ra) # 80002d3a <argaddr>
    80002f0a:	87aa                	mv	a5,a0
    return -1;
    80002f0c:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80002f0e:	0007c863          	bltz	a5,80002f1e <sys_wait+0x2a>
  return wait(p);
    80002f12:	fe843503          	ld	a0,-24(s0)
    80002f16:	fffff097          	auipc	ra,0xfffff
    80002f1a:	1b0080e7          	jalr	432(ra) # 800020c6 <wait>
}
    80002f1e:	60e2                	ld	ra,24(sp)
    80002f20:	6442                	ld	s0,16(sp)
    80002f22:	6105                	addi	sp,sp,32
    80002f24:	8082                	ret

0000000080002f26 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002f26:	7179                	addi	sp,sp,-48
    80002f28:	f406                	sd	ra,40(sp)
    80002f2a:	f022                	sd	s0,32(sp)
    80002f2c:	ec26                	sd	s1,24(sp)
    80002f2e:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80002f30:	fdc40593          	addi	a1,s0,-36
    80002f34:	4501                	li	a0,0
    80002f36:	00000097          	auipc	ra,0x0
    80002f3a:	de2080e7          	jalr	-542(ra) # 80002d18 <argint>
    return -1;
    80002f3e:	54fd                	li	s1,-1
  if(argint(0, &n) < 0)
    80002f40:	00054f63          	bltz	a0,80002f5e <sys_sbrk+0x38>
  addr = myproc()->sz;
    80002f44:	fffff097          	auipc	ra,0xfffff
    80002f48:	a52080e7          	jalr	-1454(ra) # 80001996 <myproc>
    80002f4c:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    80002f4e:	fdc42503          	lw	a0,-36(s0)
    80002f52:	fffff097          	auipc	ra,0xfffff
    80002f56:	daa080e7          	jalr	-598(ra) # 80001cfc <growproc>
    80002f5a:	00054863          	bltz	a0,80002f6a <sys_sbrk+0x44>
    return -1;
  return addr;
}
    80002f5e:	8526                	mv	a0,s1
    80002f60:	70a2                	ld	ra,40(sp)
    80002f62:	7402                	ld	s0,32(sp)
    80002f64:	64e2                	ld	s1,24(sp)
    80002f66:	6145                	addi	sp,sp,48
    80002f68:	8082                	ret
    return -1;
    80002f6a:	54fd                	li	s1,-1
    80002f6c:	bfcd                	j	80002f5e <sys_sbrk+0x38>

0000000080002f6e <sys_sleep>:

uint64
sys_sleep(void)
{
    80002f6e:	7139                	addi	sp,sp,-64
    80002f70:	fc06                	sd	ra,56(sp)
    80002f72:	f822                	sd	s0,48(sp)
    80002f74:	f426                	sd	s1,40(sp)
    80002f76:	f04a                	sd	s2,32(sp)
    80002f78:	ec4e                	sd	s3,24(sp)
    80002f7a:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80002f7c:	fcc40593          	addi	a1,s0,-52
    80002f80:	4501                	li	a0,0
    80002f82:	00000097          	auipc	ra,0x0
    80002f86:	d96080e7          	jalr	-618(ra) # 80002d18 <argint>
    return -1;
    80002f8a:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002f8c:	06054563          	bltz	a0,80002ff6 <sys_sleep+0x88>
  acquire(&tickslock);
    80002f90:	00014517          	auipc	a0,0x14
    80002f94:	74050513          	addi	a0,a0,1856 # 800176d0 <tickslock>
    80002f98:	ffffe097          	auipc	ra,0xffffe
    80002f9c:	c38080e7          	jalr	-968(ra) # 80000bd0 <acquire>
  ticks0 = ticks;
    80002fa0:	00006917          	auipc	s2,0x6
    80002fa4:	09092903          	lw	s2,144(s2) # 80009030 <ticks>
  while(ticks - ticks0 < n){
    80002fa8:	fcc42783          	lw	a5,-52(s0)
    80002fac:	cf85                	beqz	a5,80002fe4 <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002fae:	00014997          	auipc	s3,0x14
    80002fb2:	72298993          	addi	s3,s3,1826 # 800176d0 <tickslock>
    80002fb6:	00006497          	auipc	s1,0x6
    80002fba:	07a48493          	addi	s1,s1,122 # 80009030 <ticks>
    if(myproc()->killed){
    80002fbe:	fffff097          	auipc	ra,0xfffff
    80002fc2:	9d8080e7          	jalr	-1576(ra) # 80001996 <myproc>
    80002fc6:	551c                	lw	a5,40(a0)
    80002fc8:	ef9d                	bnez	a5,80003006 <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    80002fca:	85ce                	mv	a1,s3
    80002fcc:	8526                	mv	a0,s1
    80002fce:	fffff097          	auipc	ra,0xfffff
    80002fd2:	094080e7          	jalr	148(ra) # 80002062 <sleep>
  while(ticks - ticks0 < n){
    80002fd6:	409c                	lw	a5,0(s1)
    80002fd8:	412787bb          	subw	a5,a5,s2
    80002fdc:	fcc42703          	lw	a4,-52(s0)
    80002fe0:	fce7efe3          	bltu	a5,a4,80002fbe <sys_sleep+0x50>
  }
  release(&tickslock);
    80002fe4:	00014517          	auipc	a0,0x14
    80002fe8:	6ec50513          	addi	a0,a0,1772 # 800176d0 <tickslock>
    80002fec:	ffffe097          	auipc	ra,0xffffe
    80002ff0:	c98080e7          	jalr	-872(ra) # 80000c84 <release>
  return 0;
    80002ff4:	4781                	li	a5,0
}
    80002ff6:	853e                	mv	a0,a5
    80002ff8:	70e2                	ld	ra,56(sp)
    80002ffa:	7442                	ld	s0,48(sp)
    80002ffc:	74a2                	ld	s1,40(sp)
    80002ffe:	7902                	ld	s2,32(sp)
    80003000:	69e2                	ld	s3,24(sp)
    80003002:	6121                	addi	sp,sp,64
    80003004:	8082                	ret
      release(&tickslock);
    80003006:	00014517          	auipc	a0,0x14
    8000300a:	6ca50513          	addi	a0,a0,1738 # 800176d0 <tickslock>
    8000300e:	ffffe097          	auipc	ra,0xffffe
    80003012:	c76080e7          	jalr	-906(ra) # 80000c84 <release>
      return -1;
    80003016:	57fd                	li	a5,-1
    80003018:	bff9                	j	80002ff6 <sys_sleep+0x88>

000000008000301a <sys_kill>:

uint64
sys_kill(void)
{
    8000301a:	1101                	addi	sp,sp,-32
    8000301c:	ec06                	sd	ra,24(sp)
    8000301e:	e822                	sd	s0,16(sp)
    80003020:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80003022:	fec40593          	addi	a1,s0,-20
    80003026:	4501                	li	a0,0
    80003028:	00000097          	auipc	ra,0x0
    8000302c:	cf0080e7          	jalr	-784(ra) # 80002d18 <argint>
    80003030:	87aa                	mv	a5,a0
    return -1;
    80003032:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    80003034:	0007c863          	bltz	a5,80003044 <sys_kill+0x2a>
  return kill(pid);
    80003038:	fec42503          	lw	a0,-20(s0)
    8000303c:	fffff097          	auipc	ra,0xfffff
    80003040:	368080e7          	jalr	872(ra) # 800023a4 <kill>
}
    80003044:	60e2                	ld	ra,24(sp)
    80003046:	6442                	ld	s0,16(sp)
    80003048:	6105                	addi	sp,sp,32
    8000304a:	8082                	ret

000000008000304c <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    8000304c:	1101                	addi	sp,sp,-32
    8000304e:	ec06                	sd	ra,24(sp)
    80003050:	e822                	sd	s0,16(sp)
    80003052:	e426                	sd	s1,8(sp)
    80003054:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80003056:	00014517          	auipc	a0,0x14
    8000305a:	67a50513          	addi	a0,a0,1658 # 800176d0 <tickslock>
    8000305e:	ffffe097          	auipc	ra,0xffffe
    80003062:	b72080e7          	jalr	-1166(ra) # 80000bd0 <acquire>
  xticks = ticks;
    80003066:	00006497          	auipc	s1,0x6
    8000306a:	fca4a483          	lw	s1,-54(s1) # 80009030 <ticks>
  release(&tickslock);
    8000306e:	00014517          	auipc	a0,0x14
    80003072:	66250513          	addi	a0,a0,1634 # 800176d0 <tickslock>
    80003076:	ffffe097          	auipc	ra,0xffffe
    8000307a:	c0e080e7          	jalr	-1010(ra) # 80000c84 <release>
  return xticks;
}
    8000307e:	02049513          	slli	a0,s1,0x20
    80003082:	9101                	srli	a0,a0,0x20
    80003084:	60e2                	ld	ra,24(sp)
    80003086:	6442                	ld	s0,16(sp)
    80003088:	64a2                	ld	s1,8(sp)
    8000308a:	6105                	addi	sp,sp,32
    8000308c:	8082                	ret

000000008000308e <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    8000308e:	7179                	addi	sp,sp,-48
    80003090:	f406                	sd	ra,40(sp)
    80003092:	f022                	sd	s0,32(sp)
    80003094:	ec26                	sd	s1,24(sp)
    80003096:	e84a                	sd	s2,16(sp)
    80003098:	e44e                	sd	s3,8(sp)
    8000309a:	e052                	sd	s4,0(sp)
    8000309c:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    8000309e:	00005597          	auipc	a1,0x5
    800030a2:	4b258593          	addi	a1,a1,1202 # 80008550 <syscalls+0xc0>
    800030a6:	00014517          	auipc	a0,0x14
    800030aa:	64250513          	addi	a0,a0,1602 # 800176e8 <bcache>
    800030ae:	ffffe097          	auipc	ra,0xffffe
    800030b2:	a92080e7          	jalr	-1390(ra) # 80000b40 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    800030b6:	0001c797          	auipc	a5,0x1c
    800030ba:	63278793          	addi	a5,a5,1586 # 8001f6e8 <bcache+0x8000>
    800030be:	0001d717          	auipc	a4,0x1d
    800030c2:	89270713          	addi	a4,a4,-1902 # 8001f950 <bcache+0x8268>
    800030c6:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    800030ca:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800030ce:	00014497          	auipc	s1,0x14
    800030d2:	63248493          	addi	s1,s1,1586 # 80017700 <bcache+0x18>
    b->next = bcache.head.next;
    800030d6:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    800030d8:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    800030da:	00005a17          	auipc	s4,0x5
    800030de:	47ea0a13          	addi	s4,s4,1150 # 80008558 <syscalls+0xc8>
    b->next = bcache.head.next;
    800030e2:	2b893783          	ld	a5,696(s2)
    800030e6:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    800030e8:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    800030ec:	85d2                	mv	a1,s4
    800030ee:	01048513          	addi	a0,s1,16
    800030f2:	00001097          	auipc	ra,0x1
    800030f6:	4bc080e7          	jalr	1212(ra) # 800045ae <initsleeplock>
    bcache.head.next->prev = b;
    800030fa:	2b893783          	ld	a5,696(s2)
    800030fe:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80003100:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80003104:	45848493          	addi	s1,s1,1112
    80003108:	fd349de3          	bne	s1,s3,800030e2 <binit+0x54>
  }
}
    8000310c:	70a2                	ld	ra,40(sp)
    8000310e:	7402                	ld	s0,32(sp)
    80003110:	64e2                	ld	s1,24(sp)
    80003112:	6942                	ld	s2,16(sp)
    80003114:	69a2                	ld	s3,8(sp)
    80003116:	6a02                	ld	s4,0(sp)
    80003118:	6145                	addi	sp,sp,48
    8000311a:	8082                	ret

000000008000311c <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    8000311c:	7179                	addi	sp,sp,-48
    8000311e:	f406                	sd	ra,40(sp)
    80003120:	f022                	sd	s0,32(sp)
    80003122:	ec26                	sd	s1,24(sp)
    80003124:	e84a                	sd	s2,16(sp)
    80003126:	e44e                	sd	s3,8(sp)
    80003128:	1800                	addi	s0,sp,48
    8000312a:	892a                	mv	s2,a0
    8000312c:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    8000312e:	00014517          	auipc	a0,0x14
    80003132:	5ba50513          	addi	a0,a0,1466 # 800176e8 <bcache>
    80003136:	ffffe097          	auipc	ra,0xffffe
    8000313a:	a9a080e7          	jalr	-1382(ra) # 80000bd0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    8000313e:	0001d497          	auipc	s1,0x1d
    80003142:	8624b483          	ld	s1,-1950(s1) # 8001f9a0 <bcache+0x82b8>
    80003146:	0001d797          	auipc	a5,0x1d
    8000314a:	80a78793          	addi	a5,a5,-2038 # 8001f950 <bcache+0x8268>
    8000314e:	02f48f63          	beq	s1,a5,8000318c <bread+0x70>
    80003152:	873e                	mv	a4,a5
    80003154:	a021                	j	8000315c <bread+0x40>
    80003156:	68a4                	ld	s1,80(s1)
    80003158:	02e48a63          	beq	s1,a4,8000318c <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    8000315c:	449c                	lw	a5,8(s1)
    8000315e:	ff279ce3          	bne	a5,s2,80003156 <bread+0x3a>
    80003162:	44dc                	lw	a5,12(s1)
    80003164:	ff3799e3          	bne	a5,s3,80003156 <bread+0x3a>
      b->refcnt++;
    80003168:	40bc                	lw	a5,64(s1)
    8000316a:	2785                	addiw	a5,a5,1
    8000316c:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000316e:	00014517          	auipc	a0,0x14
    80003172:	57a50513          	addi	a0,a0,1402 # 800176e8 <bcache>
    80003176:	ffffe097          	auipc	ra,0xffffe
    8000317a:	b0e080e7          	jalr	-1266(ra) # 80000c84 <release>
      acquiresleep(&b->lock);
    8000317e:	01048513          	addi	a0,s1,16
    80003182:	00001097          	auipc	ra,0x1
    80003186:	466080e7          	jalr	1126(ra) # 800045e8 <acquiresleep>
      return b;
    8000318a:	a8b9                	j	800031e8 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8000318c:	0001d497          	auipc	s1,0x1d
    80003190:	80c4b483          	ld	s1,-2036(s1) # 8001f998 <bcache+0x82b0>
    80003194:	0001c797          	auipc	a5,0x1c
    80003198:	7bc78793          	addi	a5,a5,1980 # 8001f950 <bcache+0x8268>
    8000319c:	00f48863          	beq	s1,a5,800031ac <bread+0x90>
    800031a0:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    800031a2:	40bc                	lw	a5,64(s1)
    800031a4:	cf81                	beqz	a5,800031bc <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800031a6:	64a4                	ld	s1,72(s1)
    800031a8:	fee49de3          	bne	s1,a4,800031a2 <bread+0x86>
  panic("bget: no buffers");
    800031ac:	00005517          	auipc	a0,0x5
    800031b0:	3b450513          	addi	a0,a0,948 # 80008560 <syscalls+0xd0>
    800031b4:	ffffd097          	auipc	ra,0xffffd
    800031b8:	384080e7          	jalr	900(ra) # 80000538 <panic>
      b->dev = dev;
    800031bc:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    800031c0:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    800031c4:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800031c8:	4785                	li	a5,1
    800031ca:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800031cc:	00014517          	auipc	a0,0x14
    800031d0:	51c50513          	addi	a0,a0,1308 # 800176e8 <bcache>
    800031d4:	ffffe097          	auipc	ra,0xffffe
    800031d8:	ab0080e7          	jalr	-1360(ra) # 80000c84 <release>
      acquiresleep(&b->lock);
    800031dc:	01048513          	addi	a0,s1,16
    800031e0:	00001097          	auipc	ra,0x1
    800031e4:	408080e7          	jalr	1032(ra) # 800045e8 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    800031e8:	409c                	lw	a5,0(s1)
    800031ea:	cb89                	beqz	a5,800031fc <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    800031ec:	8526                	mv	a0,s1
    800031ee:	70a2                	ld	ra,40(sp)
    800031f0:	7402                	ld	s0,32(sp)
    800031f2:	64e2                	ld	s1,24(sp)
    800031f4:	6942                	ld	s2,16(sp)
    800031f6:	69a2                	ld	s3,8(sp)
    800031f8:	6145                	addi	sp,sp,48
    800031fa:	8082                	ret
    virtio_disk_rw(b, 0);
    800031fc:	4581                	li	a1,0
    800031fe:	8526                	mv	a0,s1
    80003200:	00003097          	auipc	ra,0x3
    80003204:	f16080e7          	jalr	-234(ra) # 80006116 <virtio_disk_rw>
    b->valid = 1;
    80003208:	4785                	li	a5,1
    8000320a:	c09c                	sw	a5,0(s1)
  return b;
    8000320c:	b7c5                	j	800031ec <bread+0xd0>

000000008000320e <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    8000320e:	1101                	addi	sp,sp,-32
    80003210:	ec06                	sd	ra,24(sp)
    80003212:	e822                	sd	s0,16(sp)
    80003214:	e426                	sd	s1,8(sp)
    80003216:	1000                	addi	s0,sp,32
    80003218:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000321a:	0541                	addi	a0,a0,16
    8000321c:	00001097          	auipc	ra,0x1
    80003220:	466080e7          	jalr	1126(ra) # 80004682 <holdingsleep>
    80003224:	cd01                	beqz	a0,8000323c <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80003226:	4585                	li	a1,1
    80003228:	8526                	mv	a0,s1
    8000322a:	00003097          	auipc	ra,0x3
    8000322e:	eec080e7          	jalr	-276(ra) # 80006116 <virtio_disk_rw>
}
    80003232:	60e2                	ld	ra,24(sp)
    80003234:	6442                	ld	s0,16(sp)
    80003236:	64a2                	ld	s1,8(sp)
    80003238:	6105                	addi	sp,sp,32
    8000323a:	8082                	ret
    panic("bwrite");
    8000323c:	00005517          	auipc	a0,0x5
    80003240:	33c50513          	addi	a0,a0,828 # 80008578 <syscalls+0xe8>
    80003244:	ffffd097          	auipc	ra,0xffffd
    80003248:	2f4080e7          	jalr	756(ra) # 80000538 <panic>

000000008000324c <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    8000324c:	1101                	addi	sp,sp,-32
    8000324e:	ec06                	sd	ra,24(sp)
    80003250:	e822                	sd	s0,16(sp)
    80003252:	e426                	sd	s1,8(sp)
    80003254:	e04a                	sd	s2,0(sp)
    80003256:	1000                	addi	s0,sp,32
    80003258:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000325a:	01050913          	addi	s2,a0,16
    8000325e:	854a                	mv	a0,s2
    80003260:	00001097          	auipc	ra,0x1
    80003264:	422080e7          	jalr	1058(ra) # 80004682 <holdingsleep>
    80003268:	c92d                	beqz	a0,800032da <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    8000326a:	854a                	mv	a0,s2
    8000326c:	00001097          	auipc	ra,0x1
    80003270:	3d2080e7          	jalr	978(ra) # 8000463e <releasesleep>

  acquire(&bcache.lock);
    80003274:	00014517          	auipc	a0,0x14
    80003278:	47450513          	addi	a0,a0,1140 # 800176e8 <bcache>
    8000327c:	ffffe097          	auipc	ra,0xffffe
    80003280:	954080e7          	jalr	-1708(ra) # 80000bd0 <acquire>
  b->refcnt--;
    80003284:	40bc                	lw	a5,64(s1)
    80003286:	37fd                	addiw	a5,a5,-1
    80003288:	0007871b          	sext.w	a4,a5
    8000328c:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    8000328e:	eb05                	bnez	a4,800032be <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80003290:	68bc                	ld	a5,80(s1)
    80003292:	64b8                	ld	a4,72(s1)
    80003294:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80003296:	64bc                	ld	a5,72(s1)
    80003298:	68b8                	ld	a4,80(s1)
    8000329a:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8000329c:	0001c797          	auipc	a5,0x1c
    800032a0:	44c78793          	addi	a5,a5,1100 # 8001f6e8 <bcache+0x8000>
    800032a4:	2b87b703          	ld	a4,696(a5)
    800032a8:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800032aa:	0001c717          	auipc	a4,0x1c
    800032ae:	6a670713          	addi	a4,a4,1702 # 8001f950 <bcache+0x8268>
    800032b2:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    800032b4:	2b87b703          	ld	a4,696(a5)
    800032b8:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    800032ba:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    800032be:	00014517          	auipc	a0,0x14
    800032c2:	42a50513          	addi	a0,a0,1066 # 800176e8 <bcache>
    800032c6:	ffffe097          	auipc	ra,0xffffe
    800032ca:	9be080e7          	jalr	-1602(ra) # 80000c84 <release>
}
    800032ce:	60e2                	ld	ra,24(sp)
    800032d0:	6442                	ld	s0,16(sp)
    800032d2:	64a2                	ld	s1,8(sp)
    800032d4:	6902                	ld	s2,0(sp)
    800032d6:	6105                	addi	sp,sp,32
    800032d8:	8082                	ret
    panic("brelse");
    800032da:	00005517          	auipc	a0,0x5
    800032de:	2a650513          	addi	a0,a0,678 # 80008580 <syscalls+0xf0>
    800032e2:	ffffd097          	auipc	ra,0xffffd
    800032e6:	256080e7          	jalr	598(ra) # 80000538 <panic>

00000000800032ea <bpin>:

void
bpin(struct buf *b) {
    800032ea:	1101                	addi	sp,sp,-32
    800032ec:	ec06                	sd	ra,24(sp)
    800032ee:	e822                	sd	s0,16(sp)
    800032f0:	e426                	sd	s1,8(sp)
    800032f2:	1000                	addi	s0,sp,32
    800032f4:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800032f6:	00014517          	auipc	a0,0x14
    800032fa:	3f250513          	addi	a0,a0,1010 # 800176e8 <bcache>
    800032fe:	ffffe097          	auipc	ra,0xffffe
    80003302:	8d2080e7          	jalr	-1838(ra) # 80000bd0 <acquire>
  b->refcnt++;
    80003306:	40bc                	lw	a5,64(s1)
    80003308:	2785                	addiw	a5,a5,1
    8000330a:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000330c:	00014517          	auipc	a0,0x14
    80003310:	3dc50513          	addi	a0,a0,988 # 800176e8 <bcache>
    80003314:	ffffe097          	auipc	ra,0xffffe
    80003318:	970080e7          	jalr	-1680(ra) # 80000c84 <release>
}
    8000331c:	60e2                	ld	ra,24(sp)
    8000331e:	6442                	ld	s0,16(sp)
    80003320:	64a2                	ld	s1,8(sp)
    80003322:	6105                	addi	sp,sp,32
    80003324:	8082                	ret

0000000080003326 <bunpin>:

void
bunpin(struct buf *b) {
    80003326:	1101                	addi	sp,sp,-32
    80003328:	ec06                	sd	ra,24(sp)
    8000332a:	e822                	sd	s0,16(sp)
    8000332c:	e426                	sd	s1,8(sp)
    8000332e:	1000                	addi	s0,sp,32
    80003330:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003332:	00014517          	auipc	a0,0x14
    80003336:	3b650513          	addi	a0,a0,950 # 800176e8 <bcache>
    8000333a:	ffffe097          	auipc	ra,0xffffe
    8000333e:	896080e7          	jalr	-1898(ra) # 80000bd0 <acquire>
  b->refcnt--;
    80003342:	40bc                	lw	a5,64(s1)
    80003344:	37fd                	addiw	a5,a5,-1
    80003346:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80003348:	00014517          	auipc	a0,0x14
    8000334c:	3a050513          	addi	a0,a0,928 # 800176e8 <bcache>
    80003350:	ffffe097          	auipc	ra,0xffffe
    80003354:	934080e7          	jalr	-1740(ra) # 80000c84 <release>
}
    80003358:	60e2                	ld	ra,24(sp)
    8000335a:	6442                	ld	s0,16(sp)
    8000335c:	64a2                	ld	s1,8(sp)
    8000335e:	6105                	addi	sp,sp,32
    80003360:	8082                	ret

0000000080003362 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80003362:	1101                	addi	sp,sp,-32
    80003364:	ec06                	sd	ra,24(sp)
    80003366:	e822                	sd	s0,16(sp)
    80003368:	e426                	sd	s1,8(sp)
    8000336a:	e04a                	sd	s2,0(sp)
    8000336c:	1000                	addi	s0,sp,32
    8000336e:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80003370:	00d5d59b          	srliw	a1,a1,0xd
    80003374:	0001d797          	auipc	a5,0x1d
    80003378:	a507a783          	lw	a5,-1456(a5) # 8001fdc4 <sb+0x1c>
    8000337c:	9dbd                	addw	a1,a1,a5
    8000337e:	00000097          	auipc	ra,0x0
    80003382:	d9e080e7          	jalr	-610(ra) # 8000311c <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80003386:	0074f713          	andi	a4,s1,7
    8000338a:	4785                	li	a5,1
    8000338c:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    80003390:	14ce                	slli	s1,s1,0x33
    80003392:	90d9                	srli	s1,s1,0x36
    80003394:	00950733          	add	a4,a0,s1
    80003398:	05874703          	lbu	a4,88(a4)
    8000339c:	00e7f6b3          	and	a3,a5,a4
    800033a0:	c69d                	beqz	a3,800033ce <bfree+0x6c>
    800033a2:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    800033a4:	94aa                	add	s1,s1,a0
    800033a6:	fff7c793          	not	a5,a5
    800033aa:	8ff9                	and	a5,a5,a4
    800033ac:	04f48c23          	sb	a5,88(s1)
  log_write(bp);
    800033b0:	00001097          	auipc	ra,0x1
    800033b4:	118080e7          	jalr	280(ra) # 800044c8 <log_write>
  brelse(bp);
    800033b8:	854a                	mv	a0,s2
    800033ba:	00000097          	auipc	ra,0x0
    800033be:	e92080e7          	jalr	-366(ra) # 8000324c <brelse>
}
    800033c2:	60e2                	ld	ra,24(sp)
    800033c4:	6442                	ld	s0,16(sp)
    800033c6:	64a2                	ld	s1,8(sp)
    800033c8:	6902                	ld	s2,0(sp)
    800033ca:	6105                	addi	sp,sp,32
    800033cc:	8082                	ret
    panic("freeing free block");
    800033ce:	00005517          	auipc	a0,0x5
    800033d2:	1ba50513          	addi	a0,a0,442 # 80008588 <syscalls+0xf8>
    800033d6:	ffffd097          	auipc	ra,0xffffd
    800033da:	162080e7          	jalr	354(ra) # 80000538 <panic>

00000000800033de <balloc>:
{
    800033de:	711d                	addi	sp,sp,-96
    800033e0:	ec86                	sd	ra,88(sp)
    800033e2:	e8a2                	sd	s0,80(sp)
    800033e4:	e4a6                	sd	s1,72(sp)
    800033e6:	e0ca                	sd	s2,64(sp)
    800033e8:	fc4e                	sd	s3,56(sp)
    800033ea:	f852                	sd	s4,48(sp)
    800033ec:	f456                	sd	s5,40(sp)
    800033ee:	f05a                	sd	s6,32(sp)
    800033f0:	ec5e                	sd	s7,24(sp)
    800033f2:	e862                	sd	s8,16(sp)
    800033f4:	e466                	sd	s9,8(sp)
    800033f6:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    800033f8:	0001d797          	auipc	a5,0x1d
    800033fc:	9b47a783          	lw	a5,-1612(a5) # 8001fdac <sb+0x4>
    80003400:	cbd1                	beqz	a5,80003494 <balloc+0xb6>
    80003402:	8baa                	mv	s7,a0
    80003404:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80003406:	0001db17          	auipc	s6,0x1d
    8000340a:	9a2b0b13          	addi	s6,s6,-1630 # 8001fda8 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000340e:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    80003410:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003412:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80003414:	6c89                	lui	s9,0x2
    80003416:	a831                	j	80003432 <balloc+0x54>
    brelse(bp);
    80003418:	854a                	mv	a0,s2
    8000341a:	00000097          	auipc	ra,0x0
    8000341e:	e32080e7          	jalr	-462(ra) # 8000324c <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80003422:	015c87bb          	addw	a5,s9,s5
    80003426:	00078a9b          	sext.w	s5,a5
    8000342a:	004b2703          	lw	a4,4(s6)
    8000342e:	06eaf363          	bgeu	s5,a4,80003494 <balloc+0xb6>
    bp = bread(dev, BBLOCK(b, sb));
    80003432:	41fad79b          	sraiw	a5,s5,0x1f
    80003436:	0137d79b          	srliw	a5,a5,0x13
    8000343a:	015787bb          	addw	a5,a5,s5
    8000343e:	40d7d79b          	sraiw	a5,a5,0xd
    80003442:	01cb2583          	lw	a1,28(s6)
    80003446:	9dbd                	addw	a1,a1,a5
    80003448:	855e                	mv	a0,s7
    8000344a:	00000097          	auipc	ra,0x0
    8000344e:	cd2080e7          	jalr	-814(ra) # 8000311c <bread>
    80003452:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003454:	004b2503          	lw	a0,4(s6)
    80003458:	000a849b          	sext.w	s1,s5
    8000345c:	8662                	mv	a2,s8
    8000345e:	faa4fde3          	bgeu	s1,a0,80003418 <balloc+0x3a>
      m = 1 << (bi % 8);
    80003462:	41f6579b          	sraiw	a5,a2,0x1f
    80003466:	01d7d69b          	srliw	a3,a5,0x1d
    8000346a:	00c6873b          	addw	a4,a3,a2
    8000346e:	00777793          	andi	a5,a4,7
    80003472:	9f95                	subw	a5,a5,a3
    80003474:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80003478:	4037571b          	sraiw	a4,a4,0x3
    8000347c:	00e906b3          	add	a3,s2,a4
    80003480:	0586c683          	lbu	a3,88(a3)
    80003484:	00d7f5b3          	and	a1,a5,a3
    80003488:	cd91                	beqz	a1,800034a4 <balloc+0xc6>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000348a:	2605                	addiw	a2,a2,1
    8000348c:	2485                	addiw	s1,s1,1
    8000348e:	fd4618e3          	bne	a2,s4,8000345e <balloc+0x80>
    80003492:	b759                	j	80003418 <balloc+0x3a>
  panic("balloc: out of blocks");
    80003494:	00005517          	auipc	a0,0x5
    80003498:	10c50513          	addi	a0,a0,268 # 800085a0 <syscalls+0x110>
    8000349c:	ffffd097          	auipc	ra,0xffffd
    800034a0:	09c080e7          	jalr	156(ra) # 80000538 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    800034a4:	974a                	add	a4,a4,s2
    800034a6:	8fd5                	or	a5,a5,a3
    800034a8:	04f70c23          	sb	a5,88(a4)
        log_write(bp);
    800034ac:	854a                	mv	a0,s2
    800034ae:	00001097          	auipc	ra,0x1
    800034b2:	01a080e7          	jalr	26(ra) # 800044c8 <log_write>
        brelse(bp);
    800034b6:	854a                	mv	a0,s2
    800034b8:	00000097          	auipc	ra,0x0
    800034bc:	d94080e7          	jalr	-620(ra) # 8000324c <brelse>
  bp = bread(dev, bno);
    800034c0:	85a6                	mv	a1,s1
    800034c2:	855e                	mv	a0,s7
    800034c4:	00000097          	auipc	ra,0x0
    800034c8:	c58080e7          	jalr	-936(ra) # 8000311c <bread>
    800034cc:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800034ce:	40000613          	li	a2,1024
    800034d2:	4581                	li	a1,0
    800034d4:	05850513          	addi	a0,a0,88
    800034d8:	ffffd097          	auipc	ra,0xffffd
    800034dc:	7f4080e7          	jalr	2036(ra) # 80000ccc <memset>
  log_write(bp);
    800034e0:	854a                	mv	a0,s2
    800034e2:	00001097          	auipc	ra,0x1
    800034e6:	fe6080e7          	jalr	-26(ra) # 800044c8 <log_write>
  brelse(bp);
    800034ea:	854a                	mv	a0,s2
    800034ec:	00000097          	auipc	ra,0x0
    800034f0:	d60080e7          	jalr	-672(ra) # 8000324c <brelse>
}
    800034f4:	8526                	mv	a0,s1
    800034f6:	60e6                	ld	ra,88(sp)
    800034f8:	6446                	ld	s0,80(sp)
    800034fa:	64a6                	ld	s1,72(sp)
    800034fc:	6906                	ld	s2,64(sp)
    800034fe:	79e2                	ld	s3,56(sp)
    80003500:	7a42                	ld	s4,48(sp)
    80003502:	7aa2                	ld	s5,40(sp)
    80003504:	7b02                	ld	s6,32(sp)
    80003506:	6be2                	ld	s7,24(sp)
    80003508:	6c42                	ld	s8,16(sp)
    8000350a:	6ca2                	ld	s9,8(sp)
    8000350c:	6125                	addi	sp,sp,96
    8000350e:	8082                	ret

0000000080003510 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80003510:	7179                	addi	sp,sp,-48
    80003512:	f406                	sd	ra,40(sp)
    80003514:	f022                	sd	s0,32(sp)
    80003516:	ec26                	sd	s1,24(sp)
    80003518:	e84a                	sd	s2,16(sp)
    8000351a:	e44e                	sd	s3,8(sp)
    8000351c:	e052                	sd	s4,0(sp)
    8000351e:	1800                	addi	s0,sp,48
    80003520:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80003522:	47ad                	li	a5,11
    80003524:	04b7fe63          	bgeu	a5,a1,80003580 <bmap+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    80003528:	ff45849b          	addiw	s1,a1,-12
    8000352c:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    80003530:	0ff00793          	li	a5,255
    80003534:	0ae7e363          	bltu	a5,a4,800035da <bmap+0xca>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80003538:	08052583          	lw	a1,128(a0)
    8000353c:	c5ad                	beqz	a1,800035a6 <bmap+0x96>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    8000353e:	00092503          	lw	a0,0(s2)
    80003542:	00000097          	auipc	ra,0x0
    80003546:	bda080e7          	jalr	-1062(ra) # 8000311c <bread>
    8000354a:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    8000354c:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80003550:	02049593          	slli	a1,s1,0x20
    80003554:	9181                	srli	a1,a1,0x20
    80003556:	058a                	slli	a1,a1,0x2
    80003558:	00b784b3          	add	s1,a5,a1
    8000355c:	0004a983          	lw	s3,0(s1)
    80003560:	04098d63          	beqz	s3,800035ba <bmap+0xaa>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    80003564:	8552                	mv	a0,s4
    80003566:	00000097          	auipc	ra,0x0
    8000356a:	ce6080e7          	jalr	-794(ra) # 8000324c <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    8000356e:	854e                	mv	a0,s3
    80003570:	70a2                	ld	ra,40(sp)
    80003572:	7402                	ld	s0,32(sp)
    80003574:	64e2                	ld	s1,24(sp)
    80003576:	6942                	ld	s2,16(sp)
    80003578:	69a2                	ld	s3,8(sp)
    8000357a:	6a02                	ld	s4,0(sp)
    8000357c:	6145                	addi	sp,sp,48
    8000357e:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    80003580:	02059493          	slli	s1,a1,0x20
    80003584:	9081                	srli	s1,s1,0x20
    80003586:	048a                	slli	s1,s1,0x2
    80003588:	94aa                	add	s1,s1,a0
    8000358a:	0504a983          	lw	s3,80(s1)
    8000358e:	fe0990e3          	bnez	s3,8000356e <bmap+0x5e>
      ip->addrs[bn] = addr = balloc(ip->dev);
    80003592:	4108                	lw	a0,0(a0)
    80003594:	00000097          	auipc	ra,0x0
    80003598:	e4a080e7          	jalr	-438(ra) # 800033de <balloc>
    8000359c:	0005099b          	sext.w	s3,a0
    800035a0:	0534a823          	sw	s3,80(s1)
    800035a4:	b7e9                	j	8000356e <bmap+0x5e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    800035a6:	4108                	lw	a0,0(a0)
    800035a8:	00000097          	auipc	ra,0x0
    800035ac:	e36080e7          	jalr	-458(ra) # 800033de <balloc>
    800035b0:	0005059b          	sext.w	a1,a0
    800035b4:	08b92023          	sw	a1,128(s2)
    800035b8:	b759                	j	8000353e <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    800035ba:	00092503          	lw	a0,0(s2)
    800035be:	00000097          	auipc	ra,0x0
    800035c2:	e20080e7          	jalr	-480(ra) # 800033de <balloc>
    800035c6:	0005099b          	sext.w	s3,a0
    800035ca:	0134a023          	sw	s3,0(s1)
      log_write(bp);
    800035ce:	8552                	mv	a0,s4
    800035d0:	00001097          	auipc	ra,0x1
    800035d4:	ef8080e7          	jalr	-264(ra) # 800044c8 <log_write>
    800035d8:	b771                	j	80003564 <bmap+0x54>
  panic("bmap: out of range");
    800035da:	00005517          	auipc	a0,0x5
    800035de:	fde50513          	addi	a0,a0,-34 # 800085b8 <syscalls+0x128>
    800035e2:	ffffd097          	auipc	ra,0xffffd
    800035e6:	f56080e7          	jalr	-170(ra) # 80000538 <panic>

00000000800035ea <iget>:
{
    800035ea:	7179                	addi	sp,sp,-48
    800035ec:	f406                	sd	ra,40(sp)
    800035ee:	f022                	sd	s0,32(sp)
    800035f0:	ec26                	sd	s1,24(sp)
    800035f2:	e84a                	sd	s2,16(sp)
    800035f4:	e44e                	sd	s3,8(sp)
    800035f6:	e052                	sd	s4,0(sp)
    800035f8:	1800                	addi	s0,sp,48
    800035fa:	89aa                	mv	s3,a0
    800035fc:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    800035fe:	0001c517          	auipc	a0,0x1c
    80003602:	7ca50513          	addi	a0,a0,1994 # 8001fdc8 <itable>
    80003606:	ffffd097          	auipc	ra,0xffffd
    8000360a:	5ca080e7          	jalr	1482(ra) # 80000bd0 <acquire>
  empty = 0;
    8000360e:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80003610:	0001c497          	auipc	s1,0x1c
    80003614:	7d048493          	addi	s1,s1,2000 # 8001fde0 <itable+0x18>
    80003618:	0001e697          	auipc	a3,0x1e
    8000361c:	25868693          	addi	a3,a3,600 # 80021870 <log>
    80003620:	a039                	j	8000362e <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80003622:	02090b63          	beqz	s2,80003658 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80003626:	08848493          	addi	s1,s1,136
    8000362a:	02d48a63          	beq	s1,a3,8000365e <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    8000362e:	449c                	lw	a5,8(s1)
    80003630:	fef059e3          	blez	a5,80003622 <iget+0x38>
    80003634:	4098                	lw	a4,0(s1)
    80003636:	ff3716e3          	bne	a4,s3,80003622 <iget+0x38>
    8000363a:	40d8                	lw	a4,4(s1)
    8000363c:	ff4713e3          	bne	a4,s4,80003622 <iget+0x38>
      ip->ref++;
    80003640:	2785                	addiw	a5,a5,1
    80003642:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80003644:	0001c517          	auipc	a0,0x1c
    80003648:	78450513          	addi	a0,a0,1924 # 8001fdc8 <itable>
    8000364c:	ffffd097          	auipc	ra,0xffffd
    80003650:	638080e7          	jalr	1592(ra) # 80000c84 <release>
      return ip;
    80003654:	8926                	mv	s2,s1
    80003656:	a03d                	j	80003684 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80003658:	f7f9                	bnez	a5,80003626 <iget+0x3c>
    8000365a:	8926                	mv	s2,s1
    8000365c:	b7e9                	j	80003626 <iget+0x3c>
  if(empty == 0)
    8000365e:	02090c63          	beqz	s2,80003696 <iget+0xac>
  ip->dev = dev;
    80003662:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80003666:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    8000366a:	4785                	li	a5,1
    8000366c:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80003670:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80003674:	0001c517          	auipc	a0,0x1c
    80003678:	75450513          	addi	a0,a0,1876 # 8001fdc8 <itable>
    8000367c:	ffffd097          	auipc	ra,0xffffd
    80003680:	608080e7          	jalr	1544(ra) # 80000c84 <release>
}
    80003684:	854a                	mv	a0,s2
    80003686:	70a2                	ld	ra,40(sp)
    80003688:	7402                	ld	s0,32(sp)
    8000368a:	64e2                	ld	s1,24(sp)
    8000368c:	6942                	ld	s2,16(sp)
    8000368e:	69a2                	ld	s3,8(sp)
    80003690:	6a02                	ld	s4,0(sp)
    80003692:	6145                	addi	sp,sp,48
    80003694:	8082                	ret
    panic("iget: no inodes");
    80003696:	00005517          	auipc	a0,0x5
    8000369a:	f3a50513          	addi	a0,a0,-198 # 800085d0 <syscalls+0x140>
    8000369e:	ffffd097          	auipc	ra,0xffffd
    800036a2:	e9a080e7          	jalr	-358(ra) # 80000538 <panic>

00000000800036a6 <fsinit>:
fsinit(int dev) {
    800036a6:	7179                	addi	sp,sp,-48
    800036a8:	f406                	sd	ra,40(sp)
    800036aa:	f022                	sd	s0,32(sp)
    800036ac:	ec26                	sd	s1,24(sp)
    800036ae:	e84a                	sd	s2,16(sp)
    800036b0:	e44e                	sd	s3,8(sp)
    800036b2:	1800                	addi	s0,sp,48
    800036b4:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    800036b6:	4585                	li	a1,1
    800036b8:	00000097          	auipc	ra,0x0
    800036bc:	a64080e7          	jalr	-1436(ra) # 8000311c <bread>
    800036c0:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    800036c2:	0001c997          	auipc	s3,0x1c
    800036c6:	6e698993          	addi	s3,s3,1766 # 8001fda8 <sb>
    800036ca:	02000613          	li	a2,32
    800036ce:	05850593          	addi	a1,a0,88
    800036d2:	854e                	mv	a0,s3
    800036d4:	ffffd097          	auipc	ra,0xffffd
    800036d8:	654080e7          	jalr	1620(ra) # 80000d28 <memmove>
  brelse(bp);
    800036dc:	8526                	mv	a0,s1
    800036de:	00000097          	auipc	ra,0x0
    800036e2:	b6e080e7          	jalr	-1170(ra) # 8000324c <brelse>
  if(sb.magic != FSMAGIC)
    800036e6:	0009a703          	lw	a4,0(s3)
    800036ea:	102037b7          	lui	a5,0x10203
    800036ee:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    800036f2:	02f71263          	bne	a4,a5,80003716 <fsinit+0x70>
  initlog(dev, &sb);
    800036f6:	0001c597          	auipc	a1,0x1c
    800036fa:	6b258593          	addi	a1,a1,1714 # 8001fda8 <sb>
    800036fe:	854a                	mv	a0,s2
    80003700:	00001097          	auipc	ra,0x1
    80003704:	b4c080e7          	jalr	-1204(ra) # 8000424c <initlog>
}
    80003708:	70a2                	ld	ra,40(sp)
    8000370a:	7402                	ld	s0,32(sp)
    8000370c:	64e2                	ld	s1,24(sp)
    8000370e:	6942                	ld	s2,16(sp)
    80003710:	69a2                	ld	s3,8(sp)
    80003712:	6145                	addi	sp,sp,48
    80003714:	8082                	ret
    panic("invalid file system");
    80003716:	00005517          	auipc	a0,0x5
    8000371a:	eca50513          	addi	a0,a0,-310 # 800085e0 <syscalls+0x150>
    8000371e:	ffffd097          	auipc	ra,0xffffd
    80003722:	e1a080e7          	jalr	-486(ra) # 80000538 <panic>

0000000080003726 <iinit>:
{
    80003726:	7179                	addi	sp,sp,-48
    80003728:	f406                	sd	ra,40(sp)
    8000372a:	f022                	sd	s0,32(sp)
    8000372c:	ec26                	sd	s1,24(sp)
    8000372e:	e84a                	sd	s2,16(sp)
    80003730:	e44e                	sd	s3,8(sp)
    80003732:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80003734:	00005597          	auipc	a1,0x5
    80003738:	ec458593          	addi	a1,a1,-316 # 800085f8 <syscalls+0x168>
    8000373c:	0001c517          	auipc	a0,0x1c
    80003740:	68c50513          	addi	a0,a0,1676 # 8001fdc8 <itable>
    80003744:	ffffd097          	auipc	ra,0xffffd
    80003748:	3fc080e7          	jalr	1020(ra) # 80000b40 <initlock>
  for(i = 0; i < NINODE; i++) {
    8000374c:	0001c497          	auipc	s1,0x1c
    80003750:	6a448493          	addi	s1,s1,1700 # 8001fdf0 <itable+0x28>
    80003754:	0001e997          	auipc	s3,0x1e
    80003758:	12c98993          	addi	s3,s3,300 # 80021880 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    8000375c:	00005917          	auipc	s2,0x5
    80003760:	ea490913          	addi	s2,s2,-348 # 80008600 <syscalls+0x170>
    80003764:	85ca                	mv	a1,s2
    80003766:	8526                	mv	a0,s1
    80003768:	00001097          	auipc	ra,0x1
    8000376c:	e46080e7          	jalr	-442(ra) # 800045ae <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80003770:	08848493          	addi	s1,s1,136
    80003774:	ff3498e3          	bne	s1,s3,80003764 <iinit+0x3e>
}
    80003778:	70a2                	ld	ra,40(sp)
    8000377a:	7402                	ld	s0,32(sp)
    8000377c:	64e2                	ld	s1,24(sp)
    8000377e:	6942                	ld	s2,16(sp)
    80003780:	69a2                	ld	s3,8(sp)
    80003782:	6145                	addi	sp,sp,48
    80003784:	8082                	ret

0000000080003786 <ialloc>:
{
    80003786:	715d                	addi	sp,sp,-80
    80003788:	e486                	sd	ra,72(sp)
    8000378a:	e0a2                	sd	s0,64(sp)
    8000378c:	fc26                	sd	s1,56(sp)
    8000378e:	f84a                	sd	s2,48(sp)
    80003790:	f44e                	sd	s3,40(sp)
    80003792:	f052                	sd	s4,32(sp)
    80003794:	ec56                	sd	s5,24(sp)
    80003796:	e85a                	sd	s6,16(sp)
    80003798:	e45e                	sd	s7,8(sp)
    8000379a:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    8000379c:	0001c717          	auipc	a4,0x1c
    800037a0:	61872703          	lw	a4,1560(a4) # 8001fdb4 <sb+0xc>
    800037a4:	4785                	li	a5,1
    800037a6:	04e7fa63          	bgeu	a5,a4,800037fa <ialloc+0x74>
    800037aa:	8aaa                	mv	s5,a0
    800037ac:	8bae                	mv	s7,a1
    800037ae:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    800037b0:	0001ca17          	auipc	s4,0x1c
    800037b4:	5f8a0a13          	addi	s4,s4,1528 # 8001fda8 <sb>
    800037b8:	00048b1b          	sext.w	s6,s1
    800037bc:	0044d793          	srli	a5,s1,0x4
    800037c0:	018a2583          	lw	a1,24(s4)
    800037c4:	9dbd                	addw	a1,a1,a5
    800037c6:	8556                	mv	a0,s5
    800037c8:	00000097          	auipc	ra,0x0
    800037cc:	954080e7          	jalr	-1708(ra) # 8000311c <bread>
    800037d0:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    800037d2:	05850993          	addi	s3,a0,88
    800037d6:	00f4f793          	andi	a5,s1,15
    800037da:	079a                	slli	a5,a5,0x6
    800037dc:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    800037de:	00099783          	lh	a5,0(s3)
    800037e2:	c785                	beqz	a5,8000380a <ialloc+0x84>
    brelse(bp);
    800037e4:	00000097          	auipc	ra,0x0
    800037e8:	a68080e7          	jalr	-1432(ra) # 8000324c <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    800037ec:	0485                	addi	s1,s1,1
    800037ee:	00ca2703          	lw	a4,12(s4)
    800037f2:	0004879b          	sext.w	a5,s1
    800037f6:	fce7e1e3          	bltu	a5,a4,800037b8 <ialloc+0x32>
  panic("ialloc: no inodes");
    800037fa:	00005517          	auipc	a0,0x5
    800037fe:	e0e50513          	addi	a0,a0,-498 # 80008608 <syscalls+0x178>
    80003802:	ffffd097          	auipc	ra,0xffffd
    80003806:	d36080e7          	jalr	-714(ra) # 80000538 <panic>
      memset(dip, 0, sizeof(*dip));
    8000380a:	04000613          	li	a2,64
    8000380e:	4581                	li	a1,0
    80003810:	854e                	mv	a0,s3
    80003812:	ffffd097          	auipc	ra,0xffffd
    80003816:	4ba080e7          	jalr	1210(ra) # 80000ccc <memset>
      dip->type = type;
    8000381a:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    8000381e:	854a                	mv	a0,s2
    80003820:	00001097          	auipc	ra,0x1
    80003824:	ca8080e7          	jalr	-856(ra) # 800044c8 <log_write>
      brelse(bp);
    80003828:	854a                	mv	a0,s2
    8000382a:	00000097          	auipc	ra,0x0
    8000382e:	a22080e7          	jalr	-1502(ra) # 8000324c <brelse>
      return iget(dev, inum);
    80003832:	85da                	mv	a1,s6
    80003834:	8556                	mv	a0,s5
    80003836:	00000097          	auipc	ra,0x0
    8000383a:	db4080e7          	jalr	-588(ra) # 800035ea <iget>
}
    8000383e:	60a6                	ld	ra,72(sp)
    80003840:	6406                	ld	s0,64(sp)
    80003842:	74e2                	ld	s1,56(sp)
    80003844:	7942                	ld	s2,48(sp)
    80003846:	79a2                	ld	s3,40(sp)
    80003848:	7a02                	ld	s4,32(sp)
    8000384a:	6ae2                	ld	s5,24(sp)
    8000384c:	6b42                	ld	s6,16(sp)
    8000384e:	6ba2                	ld	s7,8(sp)
    80003850:	6161                	addi	sp,sp,80
    80003852:	8082                	ret

0000000080003854 <iupdate>:
{
    80003854:	1101                	addi	sp,sp,-32
    80003856:	ec06                	sd	ra,24(sp)
    80003858:	e822                	sd	s0,16(sp)
    8000385a:	e426                	sd	s1,8(sp)
    8000385c:	e04a                	sd	s2,0(sp)
    8000385e:	1000                	addi	s0,sp,32
    80003860:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003862:	415c                	lw	a5,4(a0)
    80003864:	0047d79b          	srliw	a5,a5,0x4
    80003868:	0001c597          	auipc	a1,0x1c
    8000386c:	5585a583          	lw	a1,1368(a1) # 8001fdc0 <sb+0x18>
    80003870:	9dbd                	addw	a1,a1,a5
    80003872:	4108                	lw	a0,0(a0)
    80003874:	00000097          	auipc	ra,0x0
    80003878:	8a8080e7          	jalr	-1880(ra) # 8000311c <bread>
    8000387c:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    8000387e:	05850793          	addi	a5,a0,88
    80003882:	40c8                	lw	a0,4(s1)
    80003884:	893d                	andi	a0,a0,15
    80003886:	051a                	slli	a0,a0,0x6
    80003888:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    8000388a:	04449703          	lh	a4,68(s1)
    8000388e:	00e51023          	sh	a4,0(a0)
  dip->major = ip->major;
    80003892:	04649703          	lh	a4,70(s1)
    80003896:	00e51123          	sh	a4,2(a0)
  dip->minor = ip->minor;
    8000389a:	04849703          	lh	a4,72(s1)
    8000389e:	00e51223          	sh	a4,4(a0)
  dip->nlink = ip->nlink;
    800038a2:	04a49703          	lh	a4,74(s1)
    800038a6:	00e51323          	sh	a4,6(a0)
  dip->size = ip->size;
    800038aa:	44f8                	lw	a4,76(s1)
    800038ac:	c518                	sw	a4,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    800038ae:	03400613          	li	a2,52
    800038b2:	05048593          	addi	a1,s1,80
    800038b6:	0531                	addi	a0,a0,12
    800038b8:	ffffd097          	auipc	ra,0xffffd
    800038bc:	470080e7          	jalr	1136(ra) # 80000d28 <memmove>
  log_write(bp);
    800038c0:	854a                	mv	a0,s2
    800038c2:	00001097          	auipc	ra,0x1
    800038c6:	c06080e7          	jalr	-1018(ra) # 800044c8 <log_write>
  brelse(bp);
    800038ca:	854a                	mv	a0,s2
    800038cc:	00000097          	auipc	ra,0x0
    800038d0:	980080e7          	jalr	-1664(ra) # 8000324c <brelse>
}
    800038d4:	60e2                	ld	ra,24(sp)
    800038d6:	6442                	ld	s0,16(sp)
    800038d8:	64a2                	ld	s1,8(sp)
    800038da:	6902                	ld	s2,0(sp)
    800038dc:	6105                	addi	sp,sp,32
    800038de:	8082                	ret

00000000800038e0 <idup>:
{
    800038e0:	1101                	addi	sp,sp,-32
    800038e2:	ec06                	sd	ra,24(sp)
    800038e4:	e822                	sd	s0,16(sp)
    800038e6:	e426                	sd	s1,8(sp)
    800038e8:	1000                	addi	s0,sp,32
    800038ea:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    800038ec:	0001c517          	auipc	a0,0x1c
    800038f0:	4dc50513          	addi	a0,a0,1244 # 8001fdc8 <itable>
    800038f4:	ffffd097          	auipc	ra,0xffffd
    800038f8:	2dc080e7          	jalr	732(ra) # 80000bd0 <acquire>
  ip->ref++;
    800038fc:	449c                	lw	a5,8(s1)
    800038fe:	2785                	addiw	a5,a5,1
    80003900:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003902:	0001c517          	auipc	a0,0x1c
    80003906:	4c650513          	addi	a0,a0,1222 # 8001fdc8 <itable>
    8000390a:	ffffd097          	auipc	ra,0xffffd
    8000390e:	37a080e7          	jalr	890(ra) # 80000c84 <release>
}
    80003912:	8526                	mv	a0,s1
    80003914:	60e2                	ld	ra,24(sp)
    80003916:	6442                	ld	s0,16(sp)
    80003918:	64a2                	ld	s1,8(sp)
    8000391a:	6105                	addi	sp,sp,32
    8000391c:	8082                	ret

000000008000391e <ilock>:
{
    8000391e:	1101                	addi	sp,sp,-32
    80003920:	ec06                	sd	ra,24(sp)
    80003922:	e822                	sd	s0,16(sp)
    80003924:	e426                	sd	s1,8(sp)
    80003926:	e04a                	sd	s2,0(sp)
    80003928:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    8000392a:	c115                	beqz	a0,8000394e <ilock+0x30>
    8000392c:	84aa                	mv	s1,a0
    8000392e:	451c                	lw	a5,8(a0)
    80003930:	00f05f63          	blez	a5,8000394e <ilock+0x30>
  acquiresleep(&ip->lock);
    80003934:	0541                	addi	a0,a0,16
    80003936:	00001097          	auipc	ra,0x1
    8000393a:	cb2080e7          	jalr	-846(ra) # 800045e8 <acquiresleep>
  if(ip->valid == 0){
    8000393e:	40bc                	lw	a5,64(s1)
    80003940:	cf99                	beqz	a5,8000395e <ilock+0x40>
}
    80003942:	60e2                	ld	ra,24(sp)
    80003944:	6442                	ld	s0,16(sp)
    80003946:	64a2                	ld	s1,8(sp)
    80003948:	6902                	ld	s2,0(sp)
    8000394a:	6105                	addi	sp,sp,32
    8000394c:	8082                	ret
    panic("ilock");
    8000394e:	00005517          	auipc	a0,0x5
    80003952:	cd250513          	addi	a0,a0,-814 # 80008620 <syscalls+0x190>
    80003956:	ffffd097          	auipc	ra,0xffffd
    8000395a:	be2080e7          	jalr	-1054(ra) # 80000538 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    8000395e:	40dc                	lw	a5,4(s1)
    80003960:	0047d79b          	srliw	a5,a5,0x4
    80003964:	0001c597          	auipc	a1,0x1c
    80003968:	45c5a583          	lw	a1,1116(a1) # 8001fdc0 <sb+0x18>
    8000396c:	9dbd                	addw	a1,a1,a5
    8000396e:	4088                	lw	a0,0(s1)
    80003970:	fffff097          	auipc	ra,0xfffff
    80003974:	7ac080e7          	jalr	1964(ra) # 8000311c <bread>
    80003978:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    8000397a:	05850593          	addi	a1,a0,88
    8000397e:	40dc                	lw	a5,4(s1)
    80003980:	8bbd                	andi	a5,a5,15
    80003982:	079a                	slli	a5,a5,0x6
    80003984:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80003986:	00059783          	lh	a5,0(a1)
    8000398a:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    8000398e:	00259783          	lh	a5,2(a1)
    80003992:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80003996:	00459783          	lh	a5,4(a1)
    8000399a:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    8000399e:	00659783          	lh	a5,6(a1)
    800039a2:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    800039a6:	459c                	lw	a5,8(a1)
    800039a8:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    800039aa:	03400613          	li	a2,52
    800039ae:	05b1                	addi	a1,a1,12
    800039b0:	05048513          	addi	a0,s1,80
    800039b4:	ffffd097          	auipc	ra,0xffffd
    800039b8:	374080e7          	jalr	884(ra) # 80000d28 <memmove>
    brelse(bp);
    800039bc:	854a                	mv	a0,s2
    800039be:	00000097          	auipc	ra,0x0
    800039c2:	88e080e7          	jalr	-1906(ra) # 8000324c <brelse>
    ip->valid = 1;
    800039c6:	4785                	li	a5,1
    800039c8:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    800039ca:	04449783          	lh	a5,68(s1)
    800039ce:	fbb5                	bnez	a5,80003942 <ilock+0x24>
      panic("ilock: no type");
    800039d0:	00005517          	auipc	a0,0x5
    800039d4:	c5850513          	addi	a0,a0,-936 # 80008628 <syscalls+0x198>
    800039d8:	ffffd097          	auipc	ra,0xffffd
    800039dc:	b60080e7          	jalr	-1184(ra) # 80000538 <panic>

00000000800039e0 <iunlock>:
{
    800039e0:	1101                	addi	sp,sp,-32
    800039e2:	ec06                	sd	ra,24(sp)
    800039e4:	e822                	sd	s0,16(sp)
    800039e6:	e426                	sd	s1,8(sp)
    800039e8:	e04a                	sd	s2,0(sp)
    800039ea:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    800039ec:	c905                	beqz	a0,80003a1c <iunlock+0x3c>
    800039ee:	84aa                	mv	s1,a0
    800039f0:	01050913          	addi	s2,a0,16
    800039f4:	854a                	mv	a0,s2
    800039f6:	00001097          	auipc	ra,0x1
    800039fa:	c8c080e7          	jalr	-884(ra) # 80004682 <holdingsleep>
    800039fe:	cd19                	beqz	a0,80003a1c <iunlock+0x3c>
    80003a00:	449c                	lw	a5,8(s1)
    80003a02:	00f05d63          	blez	a5,80003a1c <iunlock+0x3c>
  releasesleep(&ip->lock);
    80003a06:	854a                	mv	a0,s2
    80003a08:	00001097          	auipc	ra,0x1
    80003a0c:	c36080e7          	jalr	-970(ra) # 8000463e <releasesleep>
}
    80003a10:	60e2                	ld	ra,24(sp)
    80003a12:	6442                	ld	s0,16(sp)
    80003a14:	64a2                	ld	s1,8(sp)
    80003a16:	6902                	ld	s2,0(sp)
    80003a18:	6105                	addi	sp,sp,32
    80003a1a:	8082                	ret
    panic("iunlock");
    80003a1c:	00005517          	auipc	a0,0x5
    80003a20:	c1c50513          	addi	a0,a0,-996 # 80008638 <syscalls+0x1a8>
    80003a24:	ffffd097          	auipc	ra,0xffffd
    80003a28:	b14080e7          	jalr	-1260(ra) # 80000538 <panic>

0000000080003a2c <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80003a2c:	7179                	addi	sp,sp,-48
    80003a2e:	f406                	sd	ra,40(sp)
    80003a30:	f022                	sd	s0,32(sp)
    80003a32:	ec26                	sd	s1,24(sp)
    80003a34:	e84a                	sd	s2,16(sp)
    80003a36:	e44e                	sd	s3,8(sp)
    80003a38:	e052                	sd	s4,0(sp)
    80003a3a:	1800                	addi	s0,sp,48
    80003a3c:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80003a3e:	05050493          	addi	s1,a0,80
    80003a42:	08050913          	addi	s2,a0,128
    80003a46:	a021                	j	80003a4e <itrunc+0x22>
    80003a48:	0491                	addi	s1,s1,4
    80003a4a:	01248d63          	beq	s1,s2,80003a64 <itrunc+0x38>
    if(ip->addrs[i]){
    80003a4e:	408c                	lw	a1,0(s1)
    80003a50:	dde5                	beqz	a1,80003a48 <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80003a52:	0009a503          	lw	a0,0(s3)
    80003a56:	00000097          	auipc	ra,0x0
    80003a5a:	90c080e7          	jalr	-1780(ra) # 80003362 <bfree>
      ip->addrs[i] = 0;
    80003a5e:	0004a023          	sw	zero,0(s1)
    80003a62:	b7dd                	j	80003a48 <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80003a64:	0809a583          	lw	a1,128(s3)
    80003a68:	e185                	bnez	a1,80003a88 <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80003a6a:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80003a6e:	854e                	mv	a0,s3
    80003a70:	00000097          	auipc	ra,0x0
    80003a74:	de4080e7          	jalr	-540(ra) # 80003854 <iupdate>
}
    80003a78:	70a2                	ld	ra,40(sp)
    80003a7a:	7402                	ld	s0,32(sp)
    80003a7c:	64e2                	ld	s1,24(sp)
    80003a7e:	6942                	ld	s2,16(sp)
    80003a80:	69a2                	ld	s3,8(sp)
    80003a82:	6a02                	ld	s4,0(sp)
    80003a84:	6145                	addi	sp,sp,48
    80003a86:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80003a88:	0009a503          	lw	a0,0(s3)
    80003a8c:	fffff097          	auipc	ra,0xfffff
    80003a90:	690080e7          	jalr	1680(ra) # 8000311c <bread>
    80003a94:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80003a96:	05850493          	addi	s1,a0,88
    80003a9a:	45850913          	addi	s2,a0,1112
    80003a9e:	a021                	j	80003aa6 <itrunc+0x7a>
    80003aa0:	0491                	addi	s1,s1,4
    80003aa2:	01248b63          	beq	s1,s2,80003ab8 <itrunc+0x8c>
      if(a[j])
    80003aa6:	408c                	lw	a1,0(s1)
    80003aa8:	dde5                	beqz	a1,80003aa0 <itrunc+0x74>
        bfree(ip->dev, a[j]);
    80003aaa:	0009a503          	lw	a0,0(s3)
    80003aae:	00000097          	auipc	ra,0x0
    80003ab2:	8b4080e7          	jalr	-1868(ra) # 80003362 <bfree>
    80003ab6:	b7ed                	j	80003aa0 <itrunc+0x74>
    brelse(bp);
    80003ab8:	8552                	mv	a0,s4
    80003aba:	fffff097          	auipc	ra,0xfffff
    80003abe:	792080e7          	jalr	1938(ra) # 8000324c <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80003ac2:	0809a583          	lw	a1,128(s3)
    80003ac6:	0009a503          	lw	a0,0(s3)
    80003aca:	00000097          	auipc	ra,0x0
    80003ace:	898080e7          	jalr	-1896(ra) # 80003362 <bfree>
    ip->addrs[NDIRECT] = 0;
    80003ad2:	0809a023          	sw	zero,128(s3)
    80003ad6:	bf51                	j	80003a6a <itrunc+0x3e>

0000000080003ad8 <iput>:
{
    80003ad8:	1101                	addi	sp,sp,-32
    80003ada:	ec06                	sd	ra,24(sp)
    80003adc:	e822                	sd	s0,16(sp)
    80003ade:	e426                	sd	s1,8(sp)
    80003ae0:	e04a                	sd	s2,0(sp)
    80003ae2:	1000                	addi	s0,sp,32
    80003ae4:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003ae6:	0001c517          	auipc	a0,0x1c
    80003aea:	2e250513          	addi	a0,a0,738 # 8001fdc8 <itable>
    80003aee:	ffffd097          	auipc	ra,0xffffd
    80003af2:	0e2080e7          	jalr	226(ra) # 80000bd0 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003af6:	4498                	lw	a4,8(s1)
    80003af8:	4785                	li	a5,1
    80003afa:	02f70363          	beq	a4,a5,80003b20 <iput+0x48>
  ip->ref--;
    80003afe:	449c                	lw	a5,8(s1)
    80003b00:	37fd                	addiw	a5,a5,-1
    80003b02:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003b04:	0001c517          	auipc	a0,0x1c
    80003b08:	2c450513          	addi	a0,a0,708 # 8001fdc8 <itable>
    80003b0c:	ffffd097          	auipc	ra,0xffffd
    80003b10:	178080e7          	jalr	376(ra) # 80000c84 <release>
}
    80003b14:	60e2                	ld	ra,24(sp)
    80003b16:	6442                	ld	s0,16(sp)
    80003b18:	64a2                	ld	s1,8(sp)
    80003b1a:	6902                	ld	s2,0(sp)
    80003b1c:	6105                	addi	sp,sp,32
    80003b1e:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003b20:	40bc                	lw	a5,64(s1)
    80003b22:	dff1                	beqz	a5,80003afe <iput+0x26>
    80003b24:	04a49783          	lh	a5,74(s1)
    80003b28:	fbf9                	bnez	a5,80003afe <iput+0x26>
    acquiresleep(&ip->lock);
    80003b2a:	01048913          	addi	s2,s1,16
    80003b2e:	854a                	mv	a0,s2
    80003b30:	00001097          	auipc	ra,0x1
    80003b34:	ab8080e7          	jalr	-1352(ra) # 800045e8 <acquiresleep>
    release(&itable.lock);
    80003b38:	0001c517          	auipc	a0,0x1c
    80003b3c:	29050513          	addi	a0,a0,656 # 8001fdc8 <itable>
    80003b40:	ffffd097          	auipc	ra,0xffffd
    80003b44:	144080e7          	jalr	324(ra) # 80000c84 <release>
    itrunc(ip);
    80003b48:	8526                	mv	a0,s1
    80003b4a:	00000097          	auipc	ra,0x0
    80003b4e:	ee2080e7          	jalr	-286(ra) # 80003a2c <itrunc>
    ip->type = 0;
    80003b52:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80003b56:	8526                	mv	a0,s1
    80003b58:	00000097          	auipc	ra,0x0
    80003b5c:	cfc080e7          	jalr	-772(ra) # 80003854 <iupdate>
    ip->valid = 0;
    80003b60:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80003b64:	854a                	mv	a0,s2
    80003b66:	00001097          	auipc	ra,0x1
    80003b6a:	ad8080e7          	jalr	-1320(ra) # 8000463e <releasesleep>
    acquire(&itable.lock);
    80003b6e:	0001c517          	auipc	a0,0x1c
    80003b72:	25a50513          	addi	a0,a0,602 # 8001fdc8 <itable>
    80003b76:	ffffd097          	auipc	ra,0xffffd
    80003b7a:	05a080e7          	jalr	90(ra) # 80000bd0 <acquire>
    80003b7e:	b741                	j	80003afe <iput+0x26>

0000000080003b80 <iunlockput>:
{
    80003b80:	1101                	addi	sp,sp,-32
    80003b82:	ec06                	sd	ra,24(sp)
    80003b84:	e822                	sd	s0,16(sp)
    80003b86:	e426                	sd	s1,8(sp)
    80003b88:	1000                	addi	s0,sp,32
    80003b8a:	84aa                	mv	s1,a0
  iunlock(ip);
    80003b8c:	00000097          	auipc	ra,0x0
    80003b90:	e54080e7          	jalr	-428(ra) # 800039e0 <iunlock>
  iput(ip);
    80003b94:	8526                	mv	a0,s1
    80003b96:	00000097          	auipc	ra,0x0
    80003b9a:	f42080e7          	jalr	-190(ra) # 80003ad8 <iput>
}
    80003b9e:	60e2                	ld	ra,24(sp)
    80003ba0:	6442                	ld	s0,16(sp)
    80003ba2:	64a2                	ld	s1,8(sp)
    80003ba4:	6105                	addi	sp,sp,32
    80003ba6:	8082                	ret

0000000080003ba8 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80003ba8:	1141                	addi	sp,sp,-16
    80003baa:	e422                	sd	s0,8(sp)
    80003bac:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80003bae:	411c                	lw	a5,0(a0)
    80003bb0:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80003bb2:	415c                	lw	a5,4(a0)
    80003bb4:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80003bb6:	04451783          	lh	a5,68(a0)
    80003bba:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80003bbe:	04a51783          	lh	a5,74(a0)
    80003bc2:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80003bc6:	04c56783          	lwu	a5,76(a0)
    80003bca:	e99c                	sd	a5,16(a1)
}
    80003bcc:	6422                	ld	s0,8(sp)
    80003bce:	0141                	addi	sp,sp,16
    80003bd0:	8082                	ret

0000000080003bd2 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003bd2:	457c                	lw	a5,76(a0)
    80003bd4:	0ed7e963          	bltu	a5,a3,80003cc6 <readi+0xf4>
{
    80003bd8:	7159                	addi	sp,sp,-112
    80003bda:	f486                	sd	ra,104(sp)
    80003bdc:	f0a2                	sd	s0,96(sp)
    80003bde:	eca6                	sd	s1,88(sp)
    80003be0:	e8ca                	sd	s2,80(sp)
    80003be2:	e4ce                	sd	s3,72(sp)
    80003be4:	e0d2                	sd	s4,64(sp)
    80003be6:	fc56                	sd	s5,56(sp)
    80003be8:	f85a                	sd	s6,48(sp)
    80003bea:	f45e                	sd	s7,40(sp)
    80003bec:	f062                	sd	s8,32(sp)
    80003bee:	ec66                	sd	s9,24(sp)
    80003bf0:	e86a                	sd	s10,16(sp)
    80003bf2:	e46e                	sd	s11,8(sp)
    80003bf4:	1880                	addi	s0,sp,112
    80003bf6:	8baa                	mv	s7,a0
    80003bf8:	8c2e                	mv	s8,a1
    80003bfa:	8ab2                	mv	s5,a2
    80003bfc:	84b6                	mv	s1,a3
    80003bfe:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003c00:	9f35                	addw	a4,a4,a3
    return 0;
    80003c02:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003c04:	0ad76063          	bltu	a4,a3,80003ca4 <readi+0xd2>
  if(off + n > ip->size)
    80003c08:	00e7f463          	bgeu	a5,a4,80003c10 <readi+0x3e>
    n = ip->size - off;
    80003c0c:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003c10:	0a0b0963          	beqz	s6,80003cc2 <readi+0xf0>
    80003c14:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003c16:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80003c1a:	5cfd                	li	s9,-1
    80003c1c:	a82d                	j	80003c56 <readi+0x84>
    80003c1e:	020a1d93          	slli	s11,s4,0x20
    80003c22:	020ddd93          	srli	s11,s11,0x20
    80003c26:	05890793          	addi	a5,s2,88
    80003c2a:	86ee                	mv	a3,s11
    80003c2c:	963e                	add	a2,a2,a5
    80003c2e:	85d6                	mv	a1,s5
    80003c30:	8562                	mv	a0,s8
    80003c32:	ffffe097          	auipc	ra,0xffffe
    80003c36:	7e4080e7          	jalr	2020(ra) # 80002416 <either_copyout>
    80003c3a:	05950d63          	beq	a0,s9,80003c94 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80003c3e:	854a                	mv	a0,s2
    80003c40:	fffff097          	auipc	ra,0xfffff
    80003c44:	60c080e7          	jalr	1548(ra) # 8000324c <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003c48:	013a09bb          	addw	s3,s4,s3
    80003c4c:	009a04bb          	addw	s1,s4,s1
    80003c50:	9aee                	add	s5,s5,s11
    80003c52:	0569f763          	bgeu	s3,s6,80003ca0 <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003c56:	000ba903          	lw	s2,0(s7)
    80003c5a:	00a4d59b          	srliw	a1,s1,0xa
    80003c5e:	855e                	mv	a0,s7
    80003c60:	00000097          	auipc	ra,0x0
    80003c64:	8b0080e7          	jalr	-1872(ra) # 80003510 <bmap>
    80003c68:	0005059b          	sext.w	a1,a0
    80003c6c:	854a                	mv	a0,s2
    80003c6e:	fffff097          	auipc	ra,0xfffff
    80003c72:	4ae080e7          	jalr	1198(ra) # 8000311c <bread>
    80003c76:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003c78:	3ff4f613          	andi	a2,s1,1023
    80003c7c:	40cd07bb          	subw	a5,s10,a2
    80003c80:	413b073b          	subw	a4,s6,s3
    80003c84:	8a3e                	mv	s4,a5
    80003c86:	2781                	sext.w	a5,a5
    80003c88:	0007069b          	sext.w	a3,a4
    80003c8c:	f8f6f9e3          	bgeu	a3,a5,80003c1e <readi+0x4c>
    80003c90:	8a3a                	mv	s4,a4
    80003c92:	b771                	j	80003c1e <readi+0x4c>
      brelse(bp);
    80003c94:	854a                	mv	a0,s2
    80003c96:	fffff097          	auipc	ra,0xfffff
    80003c9a:	5b6080e7          	jalr	1462(ra) # 8000324c <brelse>
      tot = -1;
    80003c9e:	59fd                	li	s3,-1
  }
  return tot;
    80003ca0:	0009851b          	sext.w	a0,s3
}
    80003ca4:	70a6                	ld	ra,104(sp)
    80003ca6:	7406                	ld	s0,96(sp)
    80003ca8:	64e6                	ld	s1,88(sp)
    80003caa:	6946                	ld	s2,80(sp)
    80003cac:	69a6                	ld	s3,72(sp)
    80003cae:	6a06                	ld	s4,64(sp)
    80003cb0:	7ae2                	ld	s5,56(sp)
    80003cb2:	7b42                	ld	s6,48(sp)
    80003cb4:	7ba2                	ld	s7,40(sp)
    80003cb6:	7c02                	ld	s8,32(sp)
    80003cb8:	6ce2                	ld	s9,24(sp)
    80003cba:	6d42                	ld	s10,16(sp)
    80003cbc:	6da2                	ld	s11,8(sp)
    80003cbe:	6165                	addi	sp,sp,112
    80003cc0:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003cc2:	89da                	mv	s3,s6
    80003cc4:	bff1                	j	80003ca0 <readi+0xce>
    return 0;
    80003cc6:	4501                	li	a0,0
}
    80003cc8:	8082                	ret

0000000080003cca <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003cca:	457c                	lw	a5,76(a0)
    80003ccc:	10d7e863          	bltu	a5,a3,80003ddc <writei+0x112>
{
    80003cd0:	7159                	addi	sp,sp,-112
    80003cd2:	f486                	sd	ra,104(sp)
    80003cd4:	f0a2                	sd	s0,96(sp)
    80003cd6:	eca6                	sd	s1,88(sp)
    80003cd8:	e8ca                	sd	s2,80(sp)
    80003cda:	e4ce                	sd	s3,72(sp)
    80003cdc:	e0d2                	sd	s4,64(sp)
    80003cde:	fc56                	sd	s5,56(sp)
    80003ce0:	f85a                	sd	s6,48(sp)
    80003ce2:	f45e                	sd	s7,40(sp)
    80003ce4:	f062                	sd	s8,32(sp)
    80003ce6:	ec66                	sd	s9,24(sp)
    80003ce8:	e86a                	sd	s10,16(sp)
    80003cea:	e46e                	sd	s11,8(sp)
    80003cec:	1880                	addi	s0,sp,112
    80003cee:	8b2a                	mv	s6,a0
    80003cf0:	8c2e                	mv	s8,a1
    80003cf2:	8ab2                	mv	s5,a2
    80003cf4:	8936                	mv	s2,a3
    80003cf6:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    80003cf8:	00e687bb          	addw	a5,a3,a4
    80003cfc:	0ed7e263          	bltu	a5,a3,80003de0 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80003d00:	00043737          	lui	a4,0x43
    80003d04:	0ef76063          	bltu	a4,a5,80003de4 <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003d08:	0c0b8863          	beqz	s7,80003dd8 <writei+0x10e>
    80003d0c:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003d0e:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003d12:	5cfd                	li	s9,-1
    80003d14:	a091                	j	80003d58 <writei+0x8e>
    80003d16:	02099d93          	slli	s11,s3,0x20
    80003d1a:	020ddd93          	srli	s11,s11,0x20
    80003d1e:	05848793          	addi	a5,s1,88
    80003d22:	86ee                	mv	a3,s11
    80003d24:	8656                	mv	a2,s5
    80003d26:	85e2                	mv	a1,s8
    80003d28:	953e                	add	a0,a0,a5
    80003d2a:	ffffe097          	auipc	ra,0xffffe
    80003d2e:	742080e7          	jalr	1858(ra) # 8000246c <either_copyin>
    80003d32:	07950263          	beq	a0,s9,80003d96 <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80003d36:	8526                	mv	a0,s1
    80003d38:	00000097          	auipc	ra,0x0
    80003d3c:	790080e7          	jalr	1936(ra) # 800044c8 <log_write>
    brelse(bp);
    80003d40:	8526                	mv	a0,s1
    80003d42:	fffff097          	auipc	ra,0xfffff
    80003d46:	50a080e7          	jalr	1290(ra) # 8000324c <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003d4a:	01498a3b          	addw	s4,s3,s4
    80003d4e:	0129893b          	addw	s2,s3,s2
    80003d52:	9aee                	add	s5,s5,s11
    80003d54:	057a7663          	bgeu	s4,s7,80003da0 <writei+0xd6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003d58:	000b2483          	lw	s1,0(s6)
    80003d5c:	00a9559b          	srliw	a1,s2,0xa
    80003d60:	855a                	mv	a0,s6
    80003d62:	fffff097          	auipc	ra,0xfffff
    80003d66:	7ae080e7          	jalr	1966(ra) # 80003510 <bmap>
    80003d6a:	0005059b          	sext.w	a1,a0
    80003d6e:	8526                	mv	a0,s1
    80003d70:	fffff097          	auipc	ra,0xfffff
    80003d74:	3ac080e7          	jalr	940(ra) # 8000311c <bread>
    80003d78:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003d7a:	3ff97513          	andi	a0,s2,1023
    80003d7e:	40ad07bb          	subw	a5,s10,a0
    80003d82:	414b873b          	subw	a4,s7,s4
    80003d86:	89be                	mv	s3,a5
    80003d88:	2781                	sext.w	a5,a5
    80003d8a:	0007069b          	sext.w	a3,a4
    80003d8e:	f8f6f4e3          	bgeu	a3,a5,80003d16 <writei+0x4c>
    80003d92:	89ba                	mv	s3,a4
    80003d94:	b749                	j	80003d16 <writei+0x4c>
      brelse(bp);
    80003d96:	8526                	mv	a0,s1
    80003d98:	fffff097          	auipc	ra,0xfffff
    80003d9c:	4b4080e7          	jalr	1204(ra) # 8000324c <brelse>
  }

  if(off > ip->size)
    80003da0:	04cb2783          	lw	a5,76(s6)
    80003da4:	0127f463          	bgeu	a5,s2,80003dac <writei+0xe2>
    ip->size = off;
    80003da8:	052b2623          	sw	s2,76(s6)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003dac:	855a                	mv	a0,s6
    80003dae:	00000097          	auipc	ra,0x0
    80003db2:	aa6080e7          	jalr	-1370(ra) # 80003854 <iupdate>

  return tot;
    80003db6:	000a051b          	sext.w	a0,s4
}
    80003dba:	70a6                	ld	ra,104(sp)
    80003dbc:	7406                	ld	s0,96(sp)
    80003dbe:	64e6                	ld	s1,88(sp)
    80003dc0:	6946                	ld	s2,80(sp)
    80003dc2:	69a6                	ld	s3,72(sp)
    80003dc4:	6a06                	ld	s4,64(sp)
    80003dc6:	7ae2                	ld	s5,56(sp)
    80003dc8:	7b42                	ld	s6,48(sp)
    80003dca:	7ba2                	ld	s7,40(sp)
    80003dcc:	7c02                	ld	s8,32(sp)
    80003dce:	6ce2                	ld	s9,24(sp)
    80003dd0:	6d42                	ld	s10,16(sp)
    80003dd2:	6da2                	ld	s11,8(sp)
    80003dd4:	6165                	addi	sp,sp,112
    80003dd6:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003dd8:	8a5e                	mv	s4,s7
    80003dda:	bfc9                	j	80003dac <writei+0xe2>
    return -1;
    80003ddc:	557d                	li	a0,-1
}
    80003dde:	8082                	ret
    return -1;
    80003de0:	557d                	li	a0,-1
    80003de2:	bfe1                	j	80003dba <writei+0xf0>
    return -1;
    80003de4:	557d                	li	a0,-1
    80003de6:	bfd1                	j	80003dba <writei+0xf0>

0000000080003de8 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003de8:	1141                	addi	sp,sp,-16
    80003dea:	e406                	sd	ra,8(sp)
    80003dec:	e022                	sd	s0,0(sp)
    80003dee:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003df0:	4639                	li	a2,14
    80003df2:	ffffd097          	auipc	ra,0xffffd
    80003df6:	faa080e7          	jalr	-86(ra) # 80000d9c <strncmp>
}
    80003dfa:	60a2                	ld	ra,8(sp)
    80003dfc:	6402                	ld	s0,0(sp)
    80003dfe:	0141                	addi	sp,sp,16
    80003e00:	8082                	ret

0000000080003e02 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80003e02:	7139                	addi	sp,sp,-64
    80003e04:	fc06                	sd	ra,56(sp)
    80003e06:	f822                	sd	s0,48(sp)
    80003e08:	f426                	sd	s1,40(sp)
    80003e0a:	f04a                	sd	s2,32(sp)
    80003e0c:	ec4e                	sd	s3,24(sp)
    80003e0e:	e852                	sd	s4,16(sp)
    80003e10:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003e12:	04451703          	lh	a4,68(a0)
    80003e16:	4785                	li	a5,1
    80003e18:	00f71a63          	bne	a4,a5,80003e2c <dirlookup+0x2a>
    80003e1c:	892a                	mv	s2,a0
    80003e1e:	89ae                	mv	s3,a1
    80003e20:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003e22:	457c                	lw	a5,76(a0)
    80003e24:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003e26:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003e28:	e79d                	bnez	a5,80003e56 <dirlookup+0x54>
    80003e2a:	a8a5                	j	80003ea2 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003e2c:	00005517          	auipc	a0,0x5
    80003e30:	81450513          	addi	a0,a0,-2028 # 80008640 <syscalls+0x1b0>
    80003e34:	ffffc097          	auipc	ra,0xffffc
    80003e38:	704080e7          	jalr	1796(ra) # 80000538 <panic>
      panic("dirlookup read");
    80003e3c:	00005517          	auipc	a0,0x5
    80003e40:	81c50513          	addi	a0,a0,-2020 # 80008658 <syscalls+0x1c8>
    80003e44:	ffffc097          	auipc	ra,0xffffc
    80003e48:	6f4080e7          	jalr	1780(ra) # 80000538 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003e4c:	24c1                	addiw	s1,s1,16
    80003e4e:	04c92783          	lw	a5,76(s2)
    80003e52:	04f4f763          	bgeu	s1,a5,80003ea0 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003e56:	4741                	li	a4,16
    80003e58:	86a6                	mv	a3,s1
    80003e5a:	fc040613          	addi	a2,s0,-64
    80003e5e:	4581                	li	a1,0
    80003e60:	854a                	mv	a0,s2
    80003e62:	00000097          	auipc	ra,0x0
    80003e66:	d70080e7          	jalr	-656(ra) # 80003bd2 <readi>
    80003e6a:	47c1                	li	a5,16
    80003e6c:	fcf518e3          	bne	a0,a5,80003e3c <dirlookup+0x3a>
    if(de.inum == 0)
    80003e70:	fc045783          	lhu	a5,-64(s0)
    80003e74:	dfe1                	beqz	a5,80003e4c <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80003e76:	fc240593          	addi	a1,s0,-62
    80003e7a:	854e                	mv	a0,s3
    80003e7c:	00000097          	auipc	ra,0x0
    80003e80:	f6c080e7          	jalr	-148(ra) # 80003de8 <namecmp>
    80003e84:	f561                	bnez	a0,80003e4c <dirlookup+0x4a>
      if(poff)
    80003e86:	000a0463          	beqz	s4,80003e8e <dirlookup+0x8c>
        *poff = off;
    80003e8a:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80003e8e:	fc045583          	lhu	a1,-64(s0)
    80003e92:	00092503          	lw	a0,0(s2)
    80003e96:	fffff097          	auipc	ra,0xfffff
    80003e9a:	754080e7          	jalr	1876(ra) # 800035ea <iget>
    80003e9e:	a011                	j	80003ea2 <dirlookup+0xa0>
  return 0;
    80003ea0:	4501                	li	a0,0
}
    80003ea2:	70e2                	ld	ra,56(sp)
    80003ea4:	7442                	ld	s0,48(sp)
    80003ea6:	74a2                	ld	s1,40(sp)
    80003ea8:	7902                	ld	s2,32(sp)
    80003eaa:	69e2                	ld	s3,24(sp)
    80003eac:	6a42                	ld	s4,16(sp)
    80003eae:	6121                	addi	sp,sp,64
    80003eb0:	8082                	ret

0000000080003eb2 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003eb2:	711d                	addi	sp,sp,-96
    80003eb4:	ec86                	sd	ra,88(sp)
    80003eb6:	e8a2                	sd	s0,80(sp)
    80003eb8:	e4a6                	sd	s1,72(sp)
    80003eba:	e0ca                	sd	s2,64(sp)
    80003ebc:	fc4e                	sd	s3,56(sp)
    80003ebe:	f852                	sd	s4,48(sp)
    80003ec0:	f456                	sd	s5,40(sp)
    80003ec2:	f05a                	sd	s6,32(sp)
    80003ec4:	ec5e                	sd	s7,24(sp)
    80003ec6:	e862                	sd	s8,16(sp)
    80003ec8:	e466                	sd	s9,8(sp)
    80003eca:	1080                	addi	s0,sp,96
    80003ecc:	84aa                	mv	s1,a0
    80003ece:	8aae                	mv	s5,a1
    80003ed0:	8a32                	mv	s4,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003ed2:	00054703          	lbu	a4,0(a0)
    80003ed6:	02f00793          	li	a5,47
    80003eda:	02f70363          	beq	a4,a5,80003f00 <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003ede:	ffffe097          	auipc	ra,0xffffe
    80003ee2:	ab8080e7          	jalr	-1352(ra) # 80001996 <myproc>
    80003ee6:	15053503          	ld	a0,336(a0)
    80003eea:	00000097          	auipc	ra,0x0
    80003eee:	9f6080e7          	jalr	-1546(ra) # 800038e0 <idup>
    80003ef2:	89aa                	mv	s3,a0
  while(*path == '/')
    80003ef4:	02f00913          	li	s2,47
  len = path - s;
    80003ef8:	4b01                	li	s6,0
  if(len >= DIRSIZ)
    80003efa:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003efc:	4b85                	li	s7,1
    80003efe:	a865                	j	80003fb6 <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    80003f00:	4585                	li	a1,1
    80003f02:	4505                	li	a0,1
    80003f04:	fffff097          	auipc	ra,0xfffff
    80003f08:	6e6080e7          	jalr	1766(ra) # 800035ea <iget>
    80003f0c:	89aa                	mv	s3,a0
    80003f0e:	b7dd                	j	80003ef4 <namex+0x42>
      iunlockput(ip);
    80003f10:	854e                	mv	a0,s3
    80003f12:	00000097          	auipc	ra,0x0
    80003f16:	c6e080e7          	jalr	-914(ra) # 80003b80 <iunlockput>
      return 0;
    80003f1a:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003f1c:	854e                	mv	a0,s3
    80003f1e:	60e6                	ld	ra,88(sp)
    80003f20:	6446                	ld	s0,80(sp)
    80003f22:	64a6                	ld	s1,72(sp)
    80003f24:	6906                	ld	s2,64(sp)
    80003f26:	79e2                	ld	s3,56(sp)
    80003f28:	7a42                	ld	s4,48(sp)
    80003f2a:	7aa2                	ld	s5,40(sp)
    80003f2c:	7b02                	ld	s6,32(sp)
    80003f2e:	6be2                	ld	s7,24(sp)
    80003f30:	6c42                	ld	s8,16(sp)
    80003f32:	6ca2                	ld	s9,8(sp)
    80003f34:	6125                	addi	sp,sp,96
    80003f36:	8082                	ret
      iunlock(ip);
    80003f38:	854e                	mv	a0,s3
    80003f3a:	00000097          	auipc	ra,0x0
    80003f3e:	aa6080e7          	jalr	-1370(ra) # 800039e0 <iunlock>
      return ip;
    80003f42:	bfe9                	j	80003f1c <namex+0x6a>
      iunlockput(ip);
    80003f44:	854e                	mv	a0,s3
    80003f46:	00000097          	auipc	ra,0x0
    80003f4a:	c3a080e7          	jalr	-966(ra) # 80003b80 <iunlockput>
      return 0;
    80003f4e:	89e6                	mv	s3,s9
    80003f50:	b7f1                	j	80003f1c <namex+0x6a>
  len = path - s;
    80003f52:	40b48633          	sub	a2,s1,a1
    80003f56:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    80003f5a:	099c5463          	bge	s8,s9,80003fe2 <namex+0x130>
    memmove(name, s, DIRSIZ);
    80003f5e:	4639                	li	a2,14
    80003f60:	8552                	mv	a0,s4
    80003f62:	ffffd097          	auipc	ra,0xffffd
    80003f66:	dc6080e7          	jalr	-570(ra) # 80000d28 <memmove>
  while(*path == '/')
    80003f6a:	0004c783          	lbu	a5,0(s1)
    80003f6e:	01279763          	bne	a5,s2,80003f7c <namex+0xca>
    path++;
    80003f72:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003f74:	0004c783          	lbu	a5,0(s1)
    80003f78:	ff278de3          	beq	a5,s2,80003f72 <namex+0xc0>
    ilock(ip);
    80003f7c:	854e                	mv	a0,s3
    80003f7e:	00000097          	auipc	ra,0x0
    80003f82:	9a0080e7          	jalr	-1632(ra) # 8000391e <ilock>
    if(ip->type != T_DIR){
    80003f86:	04499783          	lh	a5,68(s3)
    80003f8a:	f97793e3          	bne	a5,s7,80003f10 <namex+0x5e>
    if(nameiparent && *path == '\0'){
    80003f8e:	000a8563          	beqz	s5,80003f98 <namex+0xe6>
    80003f92:	0004c783          	lbu	a5,0(s1)
    80003f96:	d3cd                	beqz	a5,80003f38 <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    80003f98:	865a                	mv	a2,s6
    80003f9a:	85d2                	mv	a1,s4
    80003f9c:	854e                	mv	a0,s3
    80003f9e:	00000097          	auipc	ra,0x0
    80003fa2:	e64080e7          	jalr	-412(ra) # 80003e02 <dirlookup>
    80003fa6:	8caa                	mv	s9,a0
    80003fa8:	dd51                	beqz	a0,80003f44 <namex+0x92>
    iunlockput(ip);
    80003faa:	854e                	mv	a0,s3
    80003fac:	00000097          	auipc	ra,0x0
    80003fb0:	bd4080e7          	jalr	-1068(ra) # 80003b80 <iunlockput>
    ip = next;
    80003fb4:	89e6                	mv	s3,s9
  while(*path == '/')
    80003fb6:	0004c783          	lbu	a5,0(s1)
    80003fba:	05279763          	bne	a5,s2,80004008 <namex+0x156>
    path++;
    80003fbe:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003fc0:	0004c783          	lbu	a5,0(s1)
    80003fc4:	ff278de3          	beq	a5,s2,80003fbe <namex+0x10c>
  if(*path == 0)
    80003fc8:	c79d                	beqz	a5,80003ff6 <namex+0x144>
    path++;
    80003fca:	85a6                	mv	a1,s1
  len = path - s;
    80003fcc:	8cda                	mv	s9,s6
    80003fce:	865a                	mv	a2,s6
  while(*path != '/' && *path != 0)
    80003fd0:	01278963          	beq	a5,s2,80003fe2 <namex+0x130>
    80003fd4:	dfbd                	beqz	a5,80003f52 <namex+0xa0>
    path++;
    80003fd6:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    80003fd8:	0004c783          	lbu	a5,0(s1)
    80003fdc:	ff279ce3          	bne	a5,s2,80003fd4 <namex+0x122>
    80003fe0:	bf8d                	j	80003f52 <namex+0xa0>
    memmove(name, s, len);
    80003fe2:	2601                	sext.w	a2,a2
    80003fe4:	8552                	mv	a0,s4
    80003fe6:	ffffd097          	auipc	ra,0xffffd
    80003fea:	d42080e7          	jalr	-702(ra) # 80000d28 <memmove>
    name[len] = 0;
    80003fee:	9cd2                	add	s9,s9,s4
    80003ff0:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    80003ff4:	bf9d                	j	80003f6a <namex+0xb8>
  if(nameiparent){
    80003ff6:	f20a83e3          	beqz	s5,80003f1c <namex+0x6a>
    iput(ip);
    80003ffa:	854e                	mv	a0,s3
    80003ffc:	00000097          	auipc	ra,0x0
    80004000:	adc080e7          	jalr	-1316(ra) # 80003ad8 <iput>
    return 0;
    80004004:	4981                	li	s3,0
    80004006:	bf19                	j	80003f1c <namex+0x6a>
  if(*path == 0)
    80004008:	d7fd                	beqz	a5,80003ff6 <namex+0x144>
  while(*path != '/' && *path != 0)
    8000400a:	0004c783          	lbu	a5,0(s1)
    8000400e:	85a6                	mv	a1,s1
    80004010:	b7d1                	j	80003fd4 <namex+0x122>

0000000080004012 <dirlink>:
{
    80004012:	7139                	addi	sp,sp,-64
    80004014:	fc06                	sd	ra,56(sp)
    80004016:	f822                	sd	s0,48(sp)
    80004018:	f426                	sd	s1,40(sp)
    8000401a:	f04a                	sd	s2,32(sp)
    8000401c:	ec4e                	sd	s3,24(sp)
    8000401e:	e852                	sd	s4,16(sp)
    80004020:	0080                	addi	s0,sp,64
    80004022:	892a                	mv	s2,a0
    80004024:	8a2e                	mv	s4,a1
    80004026:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80004028:	4601                	li	a2,0
    8000402a:	00000097          	auipc	ra,0x0
    8000402e:	dd8080e7          	jalr	-552(ra) # 80003e02 <dirlookup>
    80004032:	e93d                	bnez	a0,800040a8 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80004034:	04c92483          	lw	s1,76(s2)
    80004038:	c49d                	beqz	s1,80004066 <dirlink+0x54>
    8000403a:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000403c:	4741                	li	a4,16
    8000403e:	86a6                	mv	a3,s1
    80004040:	fc040613          	addi	a2,s0,-64
    80004044:	4581                	li	a1,0
    80004046:	854a                	mv	a0,s2
    80004048:	00000097          	auipc	ra,0x0
    8000404c:	b8a080e7          	jalr	-1142(ra) # 80003bd2 <readi>
    80004050:	47c1                	li	a5,16
    80004052:	06f51163          	bne	a0,a5,800040b4 <dirlink+0xa2>
    if(de.inum == 0)
    80004056:	fc045783          	lhu	a5,-64(s0)
    8000405a:	c791                	beqz	a5,80004066 <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000405c:	24c1                	addiw	s1,s1,16
    8000405e:	04c92783          	lw	a5,76(s2)
    80004062:	fcf4ede3          	bltu	s1,a5,8000403c <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    80004066:	4639                	li	a2,14
    80004068:	85d2                	mv	a1,s4
    8000406a:	fc240513          	addi	a0,s0,-62
    8000406e:	ffffd097          	auipc	ra,0xffffd
    80004072:	d6a080e7          	jalr	-662(ra) # 80000dd8 <strncpy>
  de.inum = inum;
    80004076:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000407a:	4741                	li	a4,16
    8000407c:	86a6                	mv	a3,s1
    8000407e:	fc040613          	addi	a2,s0,-64
    80004082:	4581                	li	a1,0
    80004084:	854a                	mv	a0,s2
    80004086:	00000097          	auipc	ra,0x0
    8000408a:	c44080e7          	jalr	-956(ra) # 80003cca <writei>
    8000408e:	872a                	mv	a4,a0
    80004090:	47c1                	li	a5,16
  return 0;
    80004092:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004094:	02f71863          	bne	a4,a5,800040c4 <dirlink+0xb2>
}
    80004098:	70e2                	ld	ra,56(sp)
    8000409a:	7442                	ld	s0,48(sp)
    8000409c:	74a2                	ld	s1,40(sp)
    8000409e:	7902                	ld	s2,32(sp)
    800040a0:	69e2                	ld	s3,24(sp)
    800040a2:	6a42                	ld	s4,16(sp)
    800040a4:	6121                	addi	sp,sp,64
    800040a6:	8082                	ret
    iput(ip);
    800040a8:	00000097          	auipc	ra,0x0
    800040ac:	a30080e7          	jalr	-1488(ra) # 80003ad8 <iput>
    return -1;
    800040b0:	557d                	li	a0,-1
    800040b2:	b7dd                	j	80004098 <dirlink+0x86>
      panic("dirlink read");
    800040b4:	00004517          	auipc	a0,0x4
    800040b8:	5b450513          	addi	a0,a0,1460 # 80008668 <syscalls+0x1d8>
    800040bc:	ffffc097          	auipc	ra,0xffffc
    800040c0:	47c080e7          	jalr	1148(ra) # 80000538 <panic>
    panic("dirlink");
    800040c4:	00004517          	auipc	a0,0x4
    800040c8:	6b450513          	addi	a0,a0,1716 # 80008778 <syscalls+0x2e8>
    800040cc:	ffffc097          	auipc	ra,0xffffc
    800040d0:	46c080e7          	jalr	1132(ra) # 80000538 <panic>

00000000800040d4 <namei>:

struct inode*
namei(char *path)
{
    800040d4:	1101                	addi	sp,sp,-32
    800040d6:	ec06                	sd	ra,24(sp)
    800040d8:	e822                	sd	s0,16(sp)
    800040da:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    800040dc:	fe040613          	addi	a2,s0,-32
    800040e0:	4581                	li	a1,0
    800040e2:	00000097          	auipc	ra,0x0
    800040e6:	dd0080e7          	jalr	-560(ra) # 80003eb2 <namex>
}
    800040ea:	60e2                	ld	ra,24(sp)
    800040ec:	6442                	ld	s0,16(sp)
    800040ee:	6105                	addi	sp,sp,32
    800040f0:	8082                	ret

00000000800040f2 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    800040f2:	1141                	addi	sp,sp,-16
    800040f4:	e406                	sd	ra,8(sp)
    800040f6:	e022                	sd	s0,0(sp)
    800040f8:	0800                	addi	s0,sp,16
    800040fa:	862e                	mv	a2,a1
  return namex(path, 1, name);
    800040fc:	4585                	li	a1,1
    800040fe:	00000097          	auipc	ra,0x0
    80004102:	db4080e7          	jalr	-588(ra) # 80003eb2 <namex>
}
    80004106:	60a2                	ld	ra,8(sp)
    80004108:	6402                	ld	s0,0(sp)
    8000410a:	0141                	addi	sp,sp,16
    8000410c:	8082                	ret

000000008000410e <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    8000410e:	1101                	addi	sp,sp,-32
    80004110:	ec06                	sd	ra,24(sp)
    80004112:	e822                	sd	s0,16(sp)
    80004114:	e426                	sd	s1,8(sp)
    80004116:	e04a                	sd	s2,0(sp)
    80004118:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    8000411a:	0001d917          	auipc	s2,0x1d
    8000411e:	75690913          	addi	s2,s2,1878 # 80021870 <log>
    80004122:	01892583          	lw	a1,24(s2)
    80004126:	02892503          	lw	a0,40(s2)
    8000412a:	fffff097          	auipc	ra,0xfffff
    8000412e:	ff2080e7          	jalr	-14(ra) # 8000311c <bread>
    80004132:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80004134:	02c92683          	lw	a3,44(s2)
    80004138:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    8000413a:	02d05763          	blez	a3,80004168 <write_head+0x5a>
    8000413e:	0001d797          	auipc	a5,0x1d
    80004142:	76278793          	addi	a5,a5,1890 # 800218a0 <log+0x30>
    80004146:	05c50713          	addi	a4,a0,92
    8000414a:	36fd                	addiw	a3,a3,-1
    8000414c:	1682                	slli	a3,a3,0x20
    8000414e:	9281                	srli	a3,a3,0x20
    80004150:	068a                	slli	a3,a3,0x2
    80004152:	0001d617          	auipc	a2,0x1d
    80004156:	75260613          	addi	a2,a2,1874 # 800218a4 <log+0x34>
    8000415a:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    8000415c:	4390                	lw	a2,0(a5)
    8000415e:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80004160:	0791                	addi	a5,a5,4
    80004162:	0711                	addi	a4,a4,4
    80004164:	fed79ce3          	bne	a5,a3,8000415c <write_head+0x4e>
  }
  bwrite(buf);
    80004168:	8526                	mv	a0,s1
    8000416a:	fffff097          	auipc	ra,0xfffff
    8000416e:	0a4080e7          	jalr	164(ra) # 8000320e <bwrite>
  brelse(buf);
    80004172:	8526                	mv	a0,s1
    80004174:	fffff097          	auipc	ra,0xfffff
    80004178:	0d8080e7          	jalr	216(ra) # 8000324c <brelse>
}
    8000417c:	60e2                	ld	ra,24(sp)
    8000417e:	6442                	ld	s0,16(sp)
    80004180:	64a2                	ld	s1,8(sp)
    80004182:	6902                	ld	s2,0(sp)
    80004184:	6105                	addi	sp,sp,32
    80004186:	8082                	ret

0000000080004188 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80004188:	0001d797          	auipc	a5,0x1d
    8000418c:	7147a783          	lw	a5,1812(a5) # 8002189c <log+0x2c>
    80004190:	0af05d63          	blez	a5,8000424a <install_trans+0xc2>
{
    80004194:	7139                	addi	sp,sp,-64
    80004196:	fc06                	sd	ra,56(sp)
    80004198:	f822                	sd	s0,48(sp)
    8000419a:	f426                	sd	s1,40(sp)
    8000419c:	f04a                	sd	s2,32(sp)
    8000419e:	ec4e                	sd	s3,24(sp)
    800041a0:	e852                	sd	s4,16(sp)
    800041a2:	e456                	sd	s5,8(sp)
    800041a4:	e05a                	sd	s6,0(sp)
    800041a6:	0080                	addi	s0,sp,64
    800041a8:	8b2a                	mv	s6,a0
    800041aa:	0001da97          	auipc	s5,0x1d
    800041ae:	6f6a8a93          	addi	s5,s5,1782 # 800218a0 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    800041b2:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800041b4:	0001d997          	auipc	s3,0x1d
    800041b8:	6bc98993          	addi	s3,s3,1724 # 80021870 <log>
    800041bc:	a00d                	j	800041de <install_trans+0x56>
    brelse(lbuf);
    800041be:	854a                	mv	a0,s2
    800041c0:	fffff097          	auipc	ra,0xfffff
    800041c4:	08c080e7          	jalr	140(ra) # 8000324c <brelse>
    brelse(dbuf);
    800041c8:	8526                	mv	a0,s1
    800041ca:	fffff097          	auipc	ra,0xfffff
    800041ce:	082080e7          	jalr	130(ra) # 8000324c <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800041d2:	2a05                	addiw	s4,s4,1
    800041d4:	0a91                	addi	s5,s5,4
    800041d6:	02c9a783          	lw	a5,44(s3)
    800041da:	04fa5e63          	bge	s4,a5,80004236 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800041de:	0189a583          	lw	a1,24(s3)
    800041e2:	014585bb          	addw	a1,a1,s4
    800041e6:	2585                	addiw	a1,a1,1
    800041e8:	0289a503          	lw	a0,40(s3)
    800041ec:	fffff097          	auipc	ra,0xfffff
    800041f0:	f30080e7          	jalr	-208(ra) # 8000311c <bread>
    800041f4:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    800041f6:	000aa583          	lw	a1,0(s5)
    800041fa:	0289a503          	lw	a0,40(s3)
    800041fe:	fffff097          	auipc	ra,0xfffff
    80004202:	f1e080e7          	jalr	-226(ra) # 8000311c <bread>
    80004206:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80004208:	40000613          	li	a2,1024
    8000420c:	05890593          	addi	a1,s2,88
    80004210:	05850513          	addi	a0,a0,88
    80004214:	ffffd097          	auipc	ra,0xffffd
    80004218:	b14080e7          	jalr	-1260(ra) # 80000d28 <memmove>
    bwrite(dbuf);  // write dst to disk
    8000421c:	8526                	mv	a0,s1
    8000421e:	fffff097          	auipc	ra,0xfffff
    80004222:	ff0080e7          	jalr	-16(ra) # 8000320e <bwrite>
    if(recovering == 0)
    80004226:	f80b1ce3          	bnez	s6,800041be <install_trans+0x36>
      bunpin(dbuf);
    8000422a:	8526                	mv	a0,s1
    8000422c:	fffff097          	auipc	ra,0xfffff
    80004230:	0fa080e7          	jalr	250(ra) # 80003326 <bunpin>
    80004234:	b769                	j	800041be <install_trans+0x36>
}
    80004236:	70e2                	ld	ra,56(sp)
    80004238:	7442                	ld	s0,48(sp)
    8000423a:	74a2                	ld	s1,40(sp)
    8000423c:	7902                	ld	s2,32(sp)
    8000423e:	69e2                	ld	s3,24(sp)
    80004240:	6a42                	ld	s4,16(sp)
    80004242:	6aa2                	ld	s5,8(sp)
    80004244:	6b02                	ld	s6,0(sp)
    80004246:	6121                	addi	sp,sp,64
    80004248:	8082                	ret
    8000424a:	8082                	ret

000000008000424c <initlog>:
{
    8000424c:	7179                	addi	sp,sp,-48
    8000424e:	f406                	sd	ra,40(sp)
    80004250:	f022                	sd	s0,32(sp)
    80004252:	ec26                	sd	s1,24(sp)
    80004254:	e84a                	sd	s2,16(sp)
    80004256:	e44e                	sd	s3,8(sp)
    80004258:	1800                	addi	s0,sp,48
    8000425a:	892a                	mv	s2,a0
    8000425c:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    8000425e:	0001d497          	auipc	s1,0x1d
    80004262:	61248493          	addi	s1,s1,1554 # 80021870 <log>
    80004266:	00004597          	auipc	a1,0x4
    8000426a:	41258593          	addi	a1,a1,1042 # 80008678 <syscalls+0x1e8>
    8000426e:	8526                	mv	a0,s1
    80004270:	ffffd097          	auipc	ra,0xffffd
    80004274:	8d0080e7          	jalr	-1840(ra) # 80000b40 <initlock>
  log.start = sb->logstart;
    80004278:	0149a583          	lw	a1,20(s3)
    8000427c:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    8000427e:	0109a783          	lw	a5,16(s3)
    80004282:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80004284:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80004288:	854a                	mv	a0,s2
    8000428a:	fffff097          	auipc	ra,0xfffff
    8000428e:	e92080e7          	jalr	-366(ra) # 8000311c <bread>
  log.lh.n = lh->n;
    80004292:	4d34                	lw	a3,88(a0)
    80004294:	d4d4                	sw	a3,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80004296:	02d05563          	blez	a3,800042c0 <initlog+0x74>
    8000429a:	05c50793          	addi	a5,a0,92
    8000429e:	0001d717          	auipc	a4,0x1d
    800042a2:	60270713          	addi	a4,a4,1538 # 800218a0 <log+0x30>
    800042a6:	36fd                	addiw	a3,a3,-1
    800042a8:	1682                	slli	a3,a3,0x20
    800042aa:	9281                	srli	a3,a3,0x20
    800042ac:	068a                	slli	a3,a3,0x2
    800042ae:	06050613          	addi	a2,a0,96
    800042b2:	96b2                	add	a3,a3,a2
    log.lh.block[i] = lh->block[i];
    800042b4:	4390                	lw	a2,0(a5)
    800042b6:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800042b8:	0791                	addi	a5,a5,4
    800042ba:	0711                	addi	a4,a4,4
    800042bc:	fed79ce3          	bne	a5,a3,800042b4 <initlog+0x68>
  brelse(buf);
    800042c0:	fffff097          	auipc	ra,0xfffff
    800042c4:	f8c080e7          	jalr	-116(ra) # 8000324c <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    800042c8:	4505                	li	a0,1
    800042ca:	00000097          	auipc	ra,0x0
    800042ce:	ebe080e7          	jalr	-322(ra) # 80004188 <install_trans>
  log.lh.n = 0;
    800042d2:	0001d797          	auipc	a5,0x1d
    800042d6:	5c07a523          	sw	zero,1482(a5) # 8002189c <log+0x2c>
  write_head(); // clear the log
    800042da:	00000097          	auipc	ra,0x0
    800042de:	e34080e7          	jalr	-460(ra) # 8000410e <write_head>
}
    800042e2:	70a2                	ld	ra,40(sp)
    800042e4:	7402                	ld	s0,32(sp)
    800042e6:	64e2                	ld	s1,24(sp)
    800042e8:	6942                	ld	s2,16(sp)
    800042ea:	69a2                	ld	s3,8(sp)
    800042ec:	6145                	addi	sp,sp,48
    800042ee:	8082                	ret

00000000800042f0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    800042f0:	1101                	addi	sp,sp,-32
    800042f2:	ec06                	sd	ra,24(sp)
    800042f4:	e822                	sd	s0,16(sp)
    800042f6:	e426                	sd	s1,8(sp)
    800042f8:	e04a                	sd	s2,0(sp)
    800042fa:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    800042fc:	0001d517          	auipc	a0,0x1d
    80004300:	57450513          	addi	a0,a0,1396 # 80021870 <log>
    80004304:	ffffd097          	auipc	ra,0xffffd
    80004308:	8cc080e7          	jalr	-1844(ra) # 80000bd0 <acquire>
  while(1){
    if(log.committing){
    8000430c:	0001d497          	auipc	s1,0x1d
    80004310:	56448493          	addi	s1,s1,1380 # 80021870 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80004314:	4979                	li	s2,30
    80004316:	a039                	j	80004324 <begin_op+0x34>
      sleep(&log, &log.lock);
    80004318:	85a6                	mv	a1,s1
    8000431a:	8526                	mv	a0,s1
    8000431c:	ffffe097          	auipc	ra,0xffffe
    80004320:	d46080e7          	jalr	-698(ra) # 80002062 <sleep>
    if(log.committing){
    80004324:	50dc                	lw	a5,36(s1)
    80004326:	fbed                	bnez	a5,80004318 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80004328:	509c                	lw	a5,32(s1)
    8000432a:	0017871b          	addiw	a4,a5,1
    8000432e:	0007069b          	sext.w	a3,a4
    80004332:	0027179b          	slliw	a5,a4,0x2
    80004336:	9fb9                	addw	a5,a5,a4
    80004338:	0017979b          	slliw	a5,a5,0x1
    8000433c:	54d8                	lw	a4,44(s1)
    8000433e:	9fb9                	addw	a5,a5,a4
    80004340:	00f95963          	bge	s2,a5,80004352 <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80004344:	85a6                	mv	a1,s1
    80004346:	8526                	mv	a0,s1
    80004348:	ffffe097          	auipc	ra,0xffffe
    8000434c:	d1a080e7          	jalr	-742(ra) # 80002062 <sleep>
    80004350:	bfd1                	j	80004324 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80004352:	0001d517          	auipc	a0,0x1d
    80004356:	51e50513          	addi	a0,a0,1310 # 80021870 <log>
    8000435a:	d114                	sw	a3,32(a0)
      release(&log.lock);
    8000435c:	ffffd097          	auipc	ra,0xffffd
    80004360:	928080e7          	jalr	-1752(ra) # 80000c84 <release>
      break;
    }
  }
}
    80004364:	60e2                	ld	ra,24(sp)
    80004366:	6442                	ld	s0,16(sp)
    80004368:	64a2                	ld	s1,8(sp)
    8000436a:	6902                	ld	s2,0(sp)
    8000436c:	6105                	addi	sp,sp,32
    8000436e:	8082                	ret

0000000080004370 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80004370:	7139                	addi	sp,sp,-64
    80004372:	fc06                	sd	ra,56(sp)
    80004374:	f822                	sd	s0,48(sp)
    80004376:	f426                	sd	s1,40(sp)
    80004378:	f04a                	sd	s2,32(sp)
    8000437a:	ec4e                	sd	s3,24(sp)
    8000437c:	e852                	sd	s4,16(sp)
    8000437e:	e456                	sd	s5,8(sp)
    80004380:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80004382:	0001d497          	auipc	s1,0x1d
    80004386:	4ee48493          	addi	s1,s1,1262 # 80021870 <log>
    8000438a:	8526                	mv	a0,s1
    8000438c:	ffffd097          	auipc	ra,0xffffd
    80004390:	844080e7          	jalr	-1980(ra) # 80000bd0 <acquire>
  log.outstanding -= 1;
    80004394:	509c                	lw	a5,32(s1)
    80004396:	37fd                	addiw	a5,a5,-1
    80004398:	0007891b          	sext.w	s2,a5
    8000439c:	d09c                	sw	a5,32(s1)
  if(log.committing)
    8000439e:	50dc                	lw	a5,36(s1)
    800043a0:	e7b9                	bnez	a5,800043ee <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    800043a2:	04091e63          	bnez	s2,800043fe <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    800043a6:	0001d497          	auipc	s1,0x1d
    800043aa:	4ca48493          	addi	s1,s1,1226 # 80021870 <log>
    800043ae:	4785                	li	a5,1
    800043b0:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800043b2:	8526                	mv	a0,s1
    800043b4:	ffffd097          	auipc	ra,0xffffd
    800043b8:	8d0080e7          	jalr	-1840(ra) # 80000c84 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800043bc:	54dc                	lw	a5,44(s1)
    800043be:	06f04763          	bgtz	a5,8000442c <end_op+0xbc>
    acquire(&log.lock);
    800043c2:	0001d497          	auipc	s1,0x1d
    800043c6:	4ae48493          	addi	s1,s1,1198 # 80021870 <log>
    800043ca:	8526                	mv	a0,s1
    800043cc:	ffffd097          	auipc	ra,0xffffd
    800043d0:	804080e7          	jalr	-2044(ra) # 80000bd0 <acquire>
    log.committing = 0;
    800043d4:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    800043d8:	8526                	mv	a0,s1
    800043da:	ffffe097          	auipc	ra,0xffffe
    800043de:	e24080e7          	jalr	-476(ra) # 800021fe <wakeup>
    release(&log.lock);
    800043e2:	8526                	mv	a0,s1
    800043e4:	ffffd097          	auipc	ra,0xffffd
    800043e8:	8a0080e7          	jalr	-1888(ra) # 80000c84 <release>
}
    800043ec:	a03d                	j	8000441a <end_op+0xaa>
    panic("log.committing");
    800043ee:	00004517          	auipc	a0,0x4
    800043f2:	29250513          	addi	a0,a0,658 # 80008680 <syscalls+0x1f0>
    800043f6:	ffffc097          	auipc	ra,0xffffc
    800043fa:	142080e7          	jalr	322(ra) # 80000538 <panic>
    wakeup(&log);
    800043fe:	0001d497          	auipc	s1,0x1d
    80004402:	47248493          	addi	s1,s1,1138 # 80021870 <log>
    80004406:	8526                	mv	a0,s1
    80004408:	ffffe097          	auipc	ra,0xffffe
    8000440c:	df6080e7          	jalr	-522(ra) # 800021fe <wakeup>
  release(&log.lock);
    80004410:	8526                	mv	a0,s1
    80004412:	ffffd097          	auipc	ra,0xffffd
    80004416:	872080e7          	jalr	-1934(ra) # 80000c84 <release>
}
    8000441a:	70e2                	ld	ra,56(sp)
    8000441c:	7442                	ld	s0,48(sp)
    8000441e:	74a2                	ld	s1,40(sp)
    80004420:	7902                	ld	s2,32(sp)
    80004422:	69e2                	ld	s3,24(sp)
    80004424:	6a42                	ld	s4,16(sp)
    80004426:	6aa2                	ld	s5,8(sp)
    80004428:	6121                	addi	sp,sp,64
    8000442a:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    8000442c:	0001da97          	auipc	s5,0x1d
    80004430:	474a8a93          	addi	s5,s5,1140 # 800218a0 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80004434:	0001da17          	auipc	s4,0x1d
    80004438:	43ca0a13          	addi	s4,s4,1084 # 80021870 <log>
    8000443c:	018a2583          	lw	a1,24(s4)
    80004440:	012585bb          	addw	a1,a1,s2
    80004444:	2585                	addiw	a1,a1,1
    80004446:	028a2503          	lw	a0,40(s4)
    8000444a:	fffff097          	auipc	ra,0xfffff
    8000444e:	cd2080e7          	jalr	-814(ra) # 8000311c <bread>
    80004452:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80004454:	000aa583          	lw	a1,0(s5)
    80004458:	028a2503          	lw	a0,40(s4)
    8000445c:	fffff097          	auipc	ra,0xfffff
    80004460:	cc0080e7          	jalr	-832(ra) # 8000311c <bread>
    80004464:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80004466:	40000613          	li	a2,1024
    8000446a:	05850593          	addi	a1,a0,88
    8000446e:	05848513          	addi	a0,s1,88
    80004472:	ffffd097          	auipc	ra,0xffffd
    80004476:	8b6080e7          	jalr	-1866(ra) # 80000d28 <memmove>
    bwrite(to);  // write the log
    8000447a:	8526                	mv	a0,s1
    8000447c:	fffff097          	auipc	ra,0xfffff
    80004480:	d92080e7          	jalr	-622(ra) # 8000320e <bwrite>
    brelse(from);
    80004484:	854e                	mv	a0,s3
    80004486:	fffff097          	auipc	ra,0xfffff
    8000448a:	dc6080e7          	jalr	-570(ra) # 8000324c <brelse>
    brelse(to);
    8000448e:	8526                	mv	a0,s1
    80004490:	fffff097          	auipc	ra,0xfffff
    80004494:	dbc080e7          	jalr	-580(ra) # 8000324c <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80004498:	2905                	addiw	s2,s2,1
    8000449a:	0a91                	addi	s5,s5,4
    8000449c:	02ca2783          	lw	a5,44(s4)
    800044a0:	f8f94ee3          	blt	s2,a5,8000443c <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    800044a4:	00000097          	auipc	ra,0x0
    800044a8:	c6a080e7          	jalr	-918(ra) # 8000410e <write_head>
    install_trans(0); // Now install writes to home locations
    800044ac:	4501                	li	a0,0
    800044ae:	00000097          	auipc	ra,0x0
    800044b2:	cda080e7          	jalr	-806(ra) # 80004188 <install_trans>
    log.lh.n = 0;
    800044b6:	0001d797          	auipc	a5,0x1d
    800044ba:	3e07a323          	sw	zero,998(a5) # 8002189c <log+0x2c>
    write_head();    // Erase the transaction from the log
    800044be:	00000097          	auipc	ra,0x0
    800044c2:	c50080e7          	jalr	-944(ra) # 8000410e <write_head>
    800044c6:	bdf5                	j	800043c2 <end_op+0x52>

00000000800044c8 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800044c8:	1101                	addi	sp,sp,-32
    800044ca:	ec06                	sd	ra,24(sp)
    800044cc:	e822                	sd	s0,16(sp)
    800044ce:	e426                	sd	s1,8(sp)
    800044d0:	e04a                	sd	s2,0(sp)
    800044d2:	1000                	addi	s0,sp,32
    800044d4:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    800044d6:	0001d917          	auipc	s2,0x1d
    800044da:	39a90913          	addi	s2,s2,922 # 80021870 <log>
    800044de:	854a                	mv	a0,s2
    800044e0:	ffffc097          	auipc	ra,0xffffc
    800044e4:	6f0080e7          	jalr	1776(ra) # 80000bd0 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    800044e8:	02c92603          	lw	a2,44(s2)
    800044ec:	47f5                	li	a5,29
    800044ee:	06c7c563          	blt	a5,a2,80004558 <log_write+0x90>
    800044f2:	0001d797          	auipc	a5,0x1d
    800044f6:	39a7a783          	lw	a5,922(a5) # 8002188c <log+0x1c>
    800044fa:	37fd                	addiw	a5,a5,-1
    800044fc:	04f65e63          	bge	a2,a5,80004558 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80004500:	0001d797          	auipc	a5,0x1d
    80004504:	3907a783          	lw	a5,912(a5) # 80021890 <log+0x20>
    80004508:	06f05063          	blez	a5,80004568 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    8000450c:	4781                	li	a5,0
    8000450e:	06c05563          	blez	a2,80004578 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80004512:	44cc                	lw	a1,12(s1)
    80004514:	0001d717          	auipc	a4,0x1d
    80004518:	38c70713          	addi	a4,a4,908 # 800218a0 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    8000451c:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000451e:	4314                	lw	a3,0(a4)
    80004520:	04b68c63          	beq	a3,a1,80004578 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80004524:	2785                	addiw	a5,a5,1
    80004526:	0711                	addi	a4,a4,4
    80004528:	fef61be3          	bne	a2,a5,8000451e <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    8000452c:	0621                	addi	a2,a2,8
    8000452e:	060a                	slli	a2,a2,0x2
    80004530:	0001d797          	auipc	a5,0x1d
    80004534:	34078793          	addi	a5,a5,832 # 80021870 <log>
    80004538:	963e                	add	a2,a2,a5
    8000453a:	44dc                	lw	a5,12(s1)
    8000453c:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    8000453e:	8526                	mv	a0,s1
    80004540:	fffff097          	auipc	ra,0xfffff
    80004544:	daa080e7          	jalr	-598(ra) # 800032ea <bpin>
    log.lh.n++;
    80004548:	0001d717          	auipc	a4,0x1d
    8000454c:	32870713          	addi	a4,a4,808 # 80021870 <log>
    80004550:	575c                	lw	a5,44(a4)
    80004552:	2785                	addiw	a5,a5,1
    80004554:	d75c                	sw	a5,44(a4)
    80004556:	a835                	j	80004592 <log_write+0xca>
    panic("too big a transaction");
    80004558:	00004517          	auipc	a0,0x4
    8000455c:	13850513          	addi	a0,a0,312 # 80008690 <syscalls+0x200>
    80004560:	ffffc097          	auipc	ra,0xffffc
    80004564:	fd8080e7          	jalr	-40(ra) # 80000538 <panic>
    panic("log_write outside of trans");
    80004568:	00004517          	auipc	a0,0x4
    8000456c:	14050513          	addi	a0,a0,320 # 800086a8 <syscalls+0x218>
    80004570:	ffffc097          	auipc	ra,0xffffc
    80004574:	fc8080e7          	jalr	-56(ra) # 80000538 <panic>
  log.lh.block[i] = b->blockno;
    80004578:	00878713          	addi	a4,a5,8
    8000457c:	00271693          	slli	a3,a4,0x2
    80004580:	0001d717          	auipc	a4,0x1d
    80004584:	2f070713          	addi	a4,a4,752 # 80021870 <log>
    80004588:	9736                	add	a4,a4,a3
    8000458a:	44d4                	lw	a3,12(s1)
    8000458c:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    8000458e:	faf608e3          	beq	a2,a5,8000453e <log_write+0x76>
  }
  release(&log.lock);
    80004592:	0001d517          	auipc	a0,0x1d
    80004596:	2de50513          	addi	a0,a0,734 # 80021870 <log>
    8000459a:	ffffc097          	auipc	ra,0xffffc
    8000459e:	6ea080e7          	jalr	1770(ra) # 80000c84 <release>
}
    800045a2:	60e2                	ld	ra,24(sp)
    800045a4:	6442                	ld	s0,16(sp)
    800045a6:	64a2                	ld	s1,8(sp)
    800045a8:	6902                	ld	s2,0(sp)
    800045aa:	6105                	addi	sp,sp,32
    800045ac:	8082                	ret

00000000800045ae <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800045ae:	1101                	addi	sp,sp,-32
    800045b0:	ec06                	sd	ra,24(sp)
    800045b2:	e822                	sd	s0,16(sp)
    800045b4:	e426                	sd	s1,8(sp)
    800045b6:	e04a                	sd	s2,0(sp)
    800045b8:	1000                	addi	s0,sp,32
    800045ba:	84aa                	mv	s1,a0
    800045bc:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800045be:	00004597          	auipc	a1,0x4
    800045c2:	10a58593          	addi	a1,a1,266 # 800086c8 <syscalls+0x238>
    800045c6:	0521                	addi	a0,a0,8
    800045c8:	ffffc097          	auipc	ra,0xffffc
    800045cc:	578080e7          	jalr	1400(ra) # 80000b40 <initlock>
  lk->name = name;
    800045d0:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    800045d4:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800045d8:	0204a423          	sw	zero,40(s1)
}
    800045dc:	60e2                	ld	ra,24(sp)
    800045de:	6442                	ld	s0,16(sp)
    800045e0:	64a2                	ld	s1,8(sp)
    800045e2:	6902                	ld	s2,0(sp)
    800045e4:	6105                	addi	sp,sp,32
    800045e6:	8082                	ret

00000000800045e8 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800045e8:	1101                	addi	sp,sp,-32
    800045ea:	ec06                	sd	ra,24(sp)
    800045ec:	e822                	sd	s0,16(sp)
    800045ee:	e426                	sd	s1,8(sp)
    800045f0:	e04a                	sd	s2,0(sp)
    800045f2:	1000                	addi	s0,sp,32
    800045f4:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800045f6:	00850913          	addi	s2,a0,8
    800045fa:	854a                	mv	a0,s2
    800045fc:	ffffc097          	auipc	ra,0xffffc
    80004600:	5d4080e7          	jalr	1492(ra) # 80000bd0 <acquire>
  while (lk->locked) {
    80004604:	409c                	lw	a5,0(s1)
    80004606:	cb89                	beqz	a5,80004618 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80004608:	85ca                	mv	a1,s2
    8000460a:	8526                	mv	a0,s1
    8000460c:	ffffe097          	auipc	ra,0xffffe
    80004610:	a56080e7          	jalr	-1450(ra) # 80002062 <sleep>
  while (lk->locked) {
    80004614:	409c                	lw	a5,0(s1)
    80004616:	fbed                	bnez	a5,80004608 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80004618:	4785                	li	a5,1
    8000461a:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    8000461c:	ffffd097          	auipc	ra,0xffffd
    80004620:	37a080e7          	jalr	890(ra) # 80001996 <myproc>
    80004624:	591c                	lw	a5,48(a0)
    80004626:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80004628:	854a                	mv	a0,s2
    8000462a:	ffffc097          	auipc	ra,0xffffc
    8000462e:	65a080e7          	jalr	1626(ra) # 80000c84 <release>
}
    80004632:	60e2                	ld	ra,24(sp)
    80004634:	6442                	ld	s0,16(sp)
    80004636:	64a2                	ld	s1,8(sp)
    80004638:	6902                	ld	s2,0(sp)
    8000463a:	6105                	addi	sp,sp,32
    8000463c:	8082                	ret

000000008000463e <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    8000463e:	1101                	addi	sp,sp,-32
    80004640:	ec06                	sd	ra,24(sp)
    80004642:	e822                	sd	s0,16(sp)
    80004644:	e426                	sd	s1,8(sp)
    80004646:	e04a                	sd	s2,0(sp)
    80004648:	1000                	addi	s0,sp,32
    8000464a:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000464c:	00850913          	addi	s2,a0,8
    80004650:	854a                	mv	a0,s2
    80004652:	ffffc097          	auipc	ra,0xffffc
    80004656:	57e080e7          	jalr	1406(ra) # 80000bd0 <acquire>
  lk->locked = 0;
    8000465a:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000465e:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80004662:	8526                	mv	a0,s1
    80004664:	ffffe097          	auipc	ra,0xffffe
    80004668:	b9a080e7          	jalr	-1126(ra) # 800021fe <wakeup>
  release(&lk->lk);
    8000466c:	854a                	mv	a0,s2
    8000466e:	ffffc097          	auipc	ra,0xffffc
    80004672:	616080e7          	jalr	1558(ra) # 80000c84 <release>
}
    80004676:	60e2                	ld	ra,24(sp)
    80004678:	6442                	ld	s0,16(sp)
    8000467a:	64a2                	ld	s1,8(sp)
    8000467c:	6902                	ld	s2,0(sp)
    8000467e:	6105                	addi	sp,sp,32
    80004680:	8082                	ret

0000000080004682 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80004682:	7179                	addi	sp,sp,-48
    80004684:	f406                	sd	ra,40(sp)
    80004686:	f022                	sd	s0,32(sp)
    80004688:	ec26                	sd	s1,24(sp)
    8000468a:	e84a                	sd	s2,16(sp)
    8000468c:	e44e                	sd	s3,8(sp)
    8000468e:	1800                	addi	s0,sp,48
    80004690:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80004692:	00850913          	addi	s2,a0,8
    80004696:	854a                	mv	a0,s2
    80004698:	ffffc097          	auipc	ra,0xffffc
    8000469c:	538080e7          	jalr	1336(ra) # 80000bd0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800046a0:	409c                	lw	a5,0(s1)
    800046a2:	ef99                	bnez	a5,800046c0 <holdingsleep+0x3e>
    800046a4:	4481                	li	s1,0
  release(&lk->lk);
    800046a6:	854a                	mv	a0,s2
    800046a8:	ffffc097          	auipc	ra,0xffffc
    800046ac:	5dc080e7          	jalr	1500(ra) # 80000c84 <release>
  return r;
}
    800046b0:	8526                	mv	a0,s1
    800046b2:	70a2                	ld	ra,40(sp)
    800046b4:	7402                	ld	s0,32(sp)
    800046b6:	64e2                	ld	s1,24(sp)
    800046b8:	6942                	ld	s2,16(sp)
    800046ba:	69a2                	ld	s3,8(sp)
    800046bc:	6145                	addi	sp,sp,48
    800046be:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    800046c0:	0284a983          	lw	s3,40(s1)
    800046c4:	ffffd097          	auipc	ra,0xffffd
    800046c8:	2d2080e7          	jalr	722(ra) # 80001996 <myproc>
    800046cc:	5904                	lw	s1,48(a0)
    800046ce:	413484b3          	sub	s1,s1,s3
    800046d2:	0014b493          	seqz	s1,s1
    800046d6:	bfc1                	j	800046a6 <holdingsleep+0x24>

00000000800046d8 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    800046d8:	1141                	addi	sp,sp,-16
    800046da:	e406                	sd	ra,8(sp)
    800046dc:	e022                	sd	s0,0(sp)
    800046de:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    800046e0:	00004597          	auipc	a1,0x4
    800046e4:	ff858593          	addi	a1,a1,-8 # 800086d8 <syscalls+0x248>
    800046e8:	0001d517          	auipc	a0,0x1d
    800046ec:	2d050513          	addi	a0,a0,720 # 800219b8 <ftable>
    800046f0:	ffffc097          	auipc	ra,0xffffc
    800046f4:	450080e7          	jalr	1104(ra) # 80000b40 <initlock>
}
    800046f8:	60a2                	ld	ra,8(sp)
    800046fa:	6402                	ld	s0,0(sp)
    800046fc:	0141                	addi	sp,sp,16
    800046fe:	8082                	ret

0000000080004700 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80004700:	1101                	addi	sp,sp,-32
    80004702:	ec06                	sd	ra,24(sp)
    80004704:	e822                	sd	s0,16(sp)
    80004706:	e426                	sd	s1,8(sp)
    80004708:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    8000470a:	0001d517          	auipc	a0,0x1d
    8000470e:	2ae50513          	addi	a0,a0,686 # 800219b8 <ftable>
    80004712:	ffffc097          	auipc	ra,0xffffc
    80004716:	4be080e7          	jalr	1214(ra) # 80000bd0 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000471a:	0001d497          	auipc	s1,0x1d
    8000471e:	2b648493          	addi	s1,s1,694 # 800219d0 <ftable+0x18>
    80004722:	0001e717          	auipc	a4,0x1e
    80004726:	24e70713          	addi	a4,a4,590 # 80022970 <ftable+0xfb8>
    if(f->ref == 0){
    8000472a:	40dc                	lw	a5,4(s1)
    8000472c:	cf99                	beqz	a5,8000474a <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000472e:	02848493          	addi	s1,s1,40
    80004732:	fee49ce3          	bne	s1,a4,8000472a <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80004736:	0001d517          	auipc	a0,0x1d
    8000473a:	28250513          	addi	a0,a0,642 # 800219b8 <ftable>
    8000473e:	ffffc097          	auipc	ra,0xffffc
    80004742:	546080e7          	jalr	1350(ra) # 80000c84 <release>
  return 0;
    80004746:	4481                	li	s1,0
    80004748:	a819                	j	8000475e <filealloc+0x5e>
      f->ref = 1;
    8000474a:	4785                	li	a5,1
    8000474c:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    8000474e:	0001d517          	auipc	a0,0x1d
    80004752:	26a50513          	addi	a0,a0,618 # 800219b8 <ftable>
    80004756:	ffffc097          	auipc	ra,0xffffc
    8000475a:	52e080e7          	jalr	1326(ra) # 80000c84 <release>
}
    8000475e:	8526                	mv	a0,s1
    80004760:	60e2                	ld	ra,24(sp)
    80004762:	6442                	ld	s0,16(sp)
    80004764:	64a2                	ld	s1,8(sp)
    80004766:	6105                	addi	sp,sp,32
    80004768:	8082                	ret

000000008000476a <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    8000476a:	1101                	addi	sp,sp,-32
    8000476c:	ec06                	sd	ra,24(sp)
    8000476e:	e822                	sd	s0,16(sp)
    80004770:	e426                	sd	s1,8(sp)
    80004772:	1000                	addi	s0,sp,32
    80004774:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80004776:	0001d517          	auipc	a0,0x1d
    8000477a:	24250513          	addi	a0,a0,578 # 800219b8 <ftable>
    8000477e:	ffffc097          	auipc	ra,0xffffc
    80004782:	452080e7          	jalr	1106(ra) # 80000bd0 <acquire>
  if(f->ref < 1)
    80004786:	40dc                	lw	a5,4(s1)
    80004788:	02f05263          	blez	a5,800047ac <filedup+0x42>
    panic("filedup");
  f->ref++;
    8000478c:	2785                	addiw	a5,a5,1
    8000478e:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80004790:	0001d517          	auipc	a0,0x1d
    80004794:	22850513          	addi	a0,a0,552 # 800219b8 <ftable>
    80004798:	ffffc097          	auipc	ra,0xffffc
    8000479c:	4ec080e7          	jalr	1260(ra) # 80000c84 <release>
  return f;
}
    800047a0:	8526                	mv	a0,s1
    800047a2:	60e2                	ld	ra,24(sp)
    800047a4:	6442                	ld	s0,16(sp)
    800047a6:	64a2                	ld	s1,8(sp)
    800047a8:	6105                	addi	sp,sp,32
    800047aa:	8082                	ret
    panic("filedup");
    800047ac:	00004517          	auipc	a0,0x4
    800047b0:	f3450513          	addi	a0,a0,-204 # 800086e0 <syscalls+0x250>
    800047b4:	ffffc097          	auipc	ra,0xffffc
    800047b8:	d84080e7          	jalr	-636(ra) # 80000538 <panic>

00000000800047bc <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    800047bc:	7139                	addi	sp,sp,-64
    800047be:	fc06                	sd	ra,56(sp)
    800047c0:	f822                	sd	s0,48(sp)
    800047c2:	f426                	sd	s1,40(sp)
    800047c4:	f04a                	sd	s2,32(sp)
    800047c6:	ec4e                	sd	s3,24(sp)
    800047c8:	e852                	sd	s4,16(sp)
    800047ca:	e456                	sd	s5,8(sp)
    800047cc:	0080                	addi	s0,sp,64
    800047ce:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    800047d0:	0001d517          	auipc	a0,0x1d
    800047d4:	1e850513          	addi	a0,a0,488 # 800219b8 <ftable>
    800047d8:	ffffc097          	auipc	ra,0xffffc
    800047dc:	3f8080e7          	jalr	1016(ra) # 80000bd0 <acquire>
  if(f->ref < 1)
    800047e0:	40dc                	lw	a5,4(s1)
    800047e2:	06f05163          	blez	a5,80004844 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    800047e6:	37fd                	addiw	a5,a5,-1
    800047e8:	0007871b          	sext.w	a4,a5
    800047ec:	c0dc                	sw	a5,4(s1)
    800047ee:	06e04363          	bgtz	a4,80004854 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    800047f2:	0004a903          	lw	s2,0(s1)
    800047f6:	0094ca83          	lbu	s5,9(s1)
    800047fa:	0104ba03          	ld	s4,16(s1)
    800047fe:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80004802:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80004806:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    8000480a:	0001d517          	auipc	a0,0x1d
    8000480e:	1ae50513          	addi	a0,a0,430 # 800219b8 <ftable>
    80004812:	ffffc097          	auipc	ra,0xffffc
    80004816:	472080e7          	jalr	1138(ra) # 80000c84 <release>

  if(ff.type == FD_PIPE){
    8000481a:	4785                	li	a5,1
    8000481c:	04f90d63          	beq	s2,a5,80004876 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80004820:	3979                	addiw	s2,s2,-2
    80004822:	4785                	li	a5,1
    80004824:	0527e063          	bltu	a5,s2,80004864 <fileclose+0xa8>
    begin_op();
    80004828:	00000097          	auipc	ra,0x0
    8000482c:	ac8080e7          	jalr	-1336(ra) # 800042f0 <begin_op>
    iput(ff.ip);
    80004830:	854e                	mv	a0,s3
    80004832:	fffff097          	auipc	ra,0xfffff
    80004836:	2a6080e7          	jalr	678(ra) # 80003ad8 <iput>
    end_op();
    8000483a:	00000097          	auipc	ra,0x0
    8000483e:	b36080e7          	jalr	-1226(ra) # 80004370 <end_op>
    80004842:	a00d                	j	80004864 <fileclose+0xa8>
    panic("fileclose");
    80004844:	00004517          	auipc	a0,0x4
    80004848:	ea450513          	addi	a0,a0,-348 # 800086e8 <syscalls+0x258>
    8000484c:	ffffc097          	auipc	ra,0xffffc
    80004850:	cec080e7          	jalr	-788(ra) # 80000538 <panic>
    release(&ftable.lock);
    80004854:	0001d517          	auipc	a0,0x1d
    80004858:	16450513          	addi	a0,a0,356 # 800219b8 <ftable>
    8000485c:	ffffc097          	auipc	ra,0xffffc
    80004860:	428080e7          	jalr	1064(ra) # 80000c84 <release>
  }
}
    80004864:	70e2                	ld	ra,56(sp)
    80004866:	7442                	ld	s0,48(sp)
    80004868:	74a2                	ld	s1,40(sp)
    8000486a:	7902                	ld	s2,32(sp)
    8000486c:	69e2                	ld	s3,24(sp)
    8000486e:	6a42                	ld	s4,16(sp)
    80004870:	6aa2                	ld	s5,8(sp)
    80004872:	6121                	addi	sp,sp,64
    80004874:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80004876:	85d6                	mv	a1,s5
    80004878:	8552                	mv	a0,s4
    8000487a:	00000097          	auipc	ra,0x0
    8000487e:	34c080e7          	jalr	844(ra) # 80004bc6 <pipeclose>
    80004882:	b7cd                	j	80004864 <fileclose+0xa8>

0000000080004884 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80004884:	715d                	addi	sp,sp,-80
    80004886:	e486                	sd	ra,72(sp)
    80004888:	e0a2                	sd	s0,64(sp)
    8000488a:	fc26                	sd	s1,56(sp)
    8000488c:	f84a                	sd	s2,48(sp)
    8000488e:	f44e                	sd	s3,40(sp)
    80004890:	0880                	addi	s0,sp,80
    80004892:	84aa                	mv	s1,a0
    80004894:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80004896:	ffffd097          	auipc	ra,0xffffd
    8000489a:	100080e7          	jalr	256(ra) # 80001996 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    8000489e:	409c                	lw	a5,0(s1)
    800048a0:	37f9                	addiw	a5,a5,-2
    800048a2:	4705                	li	a4,1
    800048a4:	04f76763          	bltu	a4,a5,800048f2 <filestat+0x6e>
    800048a8:	892a                	mv	s2,a0
    ilock(f->ip);
    800048aa:	6c88                	ld	a0,24(s1)
    800048ac:	fffff097          	auipc	ra,0xfffff
    800048b0:	072080e7          	jalr	114(ra) # 8000391e <ilock>
    stati(f->ip, &st);
    800048b4:	fb840593          	addi	a1,s0,-72
    800048b8:	6c88                	ld	a0,24(s1)
    800048ba:	fffff097          	auipc	ra,0xfffff
    800048be:	2ee080e7          	jalr	750(ra) # 80003ba8 <stati>
    iunlock(f->ip);
    800048c2:	6c88                	ld	a0,24(s1)
    800048c4:	fffff097          	auipc	ra,0xfffff
    800048c8:	11c080e7          	jalr	284(ra) # 800039e0 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    800048cc:	46e1                	li	a3,24
    800048ce:	fb840613          	addi	a2,s0,-72
    800048d2:	85ce                	mv	a1,s3
    800048d4:	05093503          	ld	a0,80(s2)
    800048d8:	ffffd097          	auipc	ra,0xffffd
    800048dc:	d7e080e7          	jalr	-642(ra) # 80001656 <copyout>
    800048e0:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    800048e4:	60a6                	ld	ra,72(sp)
    800048e6:	6406                	ld	s0,64(sp)
    800048e8:	74e2                	ld	s1,56(sp)
    800048ea:	7942                	ld	s2,48(sp)
    800048ec:	79a2                	ld	s3,40(sp)
    800048ee:	6161                	addi	sp,sp,80
    800048f0:	8082                	ret
  return -1;
    800048f2:	557d                	li	a0,-1
    800048f4:	bfc5                	j	800048e4 <filestat+0x60>

00000000800048f6 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    800048f6:	7179                	addi	sp,sp,-48
    800048f8:	f406                	sd	ra,40(sp)
    800048fa:	f022                	sd	s0,32(sp)
    800048fc:	ec26                	sd	s1,24(sp)
    800048fe:	e84a                	sd	s2,16(sp)
    80004900:	e44e                	sd	s3,8(sp)
    80004902:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80004904:	00854783          	lbu	a5,8(a0)
    80004908:	c3d5                	beqz	a5,800049ac <fileread+0xb6>
    8000490a:	84aa                	mv	s1,a0
    8000490c:	89ae                	mv	s3,a1
    8000490e:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80004910:	411c                	lw	a5,0(a0)
    80004912:	4705                	li	a4,1
    80004914:	04e78963          	beq	a5,a4,80004966 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80004918:	470d                	li	a4,3
    8000491a:	04e78d63          	beq	a5,a4,80004974 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    8000491e:	4709                	li	a4,2
    80004920:	06e79e63          	bne	a5,a4,8000499c <fileread+0xa6>
    ilock(f->ip);
    80004924:	6d08                	ld	a0,24(a0)
    80004926:	fffff097          	auipc	ra,0xfffff
    8000492a:	ff8080e7          	jalr	-8(ra) # 8000391e <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    8000492e:	874a                	mv	a4,s2
    80004930:	5094                	lw	a3,32(s1)
    80004932:	864e                	mv	a2,s3
    80004934:	4585                	li	a1,1
    80004936:	6c88                	ld	a0,24(s1)
    80004938:	fffff097          	auipc	ra,0xfffff
    8000493c:	29a080e7          	jalr	666(ra) # 80003bd2 <readi>
    80004940:	892a                	mv	s2,a0
    80004942:	00a05563          	blez	a0,8000494c <fileread+0x56>
      f->off += r;
    80004946:	509c                	lw	a5,32(s1)
    80004948:	9fa9                	addw	a5,a5,a0
    8000494a:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    8000494c:	6c88                	ld	a0,24(s1)
    8000494e:	fffff097          	auipc	ra,0xfffff
    80004952:	092080e7          	jalr	146(ra) # 800039e0 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80004956:	854a                	mv	a0,s2
    80004958:	70a2                	ld	ra,40(sp)
    8000495a:	7402                	ld	s0,32(sp)
    8000495c:	64e2                	ld	s1,24(sp)
    8000495e:	6942                	ld	s2,16(sp)
    80004960:	69a2                	ld	s3,8(sp)
    80004962:	6145                	addi	sp,sp,48
    80004964:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80004966:	6908                	ld	a0,16(a0)
    80004968:	00000097          	auipc	ra,0x0
    8000496c:	3c0080e7          	jalr	960(ra) # 80004d28 <piperead>
    80004970:	892a                	mv	s2,a0
    80004972:	b7d5                	j	80004956 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80004974:	02451783          	lh	a5,36(a0)
    80004978:	03079693          	slli	a3,a5,0x30
    8000497c:	92c1                	srli	a3,a3,0x30
    8000497e:	4725                	li	a4,9
    80004980:	02d76863          	bltu	a4,a3,800049b0 <fileread+0xba>
    80004984:	0792                	slli	a5,a5,0x4
    80004986:	0001d717          	auipc	a4,0x1d
    8000498a:	f9270713          	addi	a4,a4,-110 # 80021918 <devsw>
    8000498e:	97ba                	add	a5,a5,a4
    80004990:	639c                	ld	a5,0(a5)
    80004992:	c38d                	beqz	a5,800049b4 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80004994:	4505                	li	a0,1
    80004996:	9782                	jalr	a5
    80004998:	892a                	mv	s2,a0
    8000499a:	bf75                	j	80004956 <fileread+0x60>
    panic("fileread");
    8000499c:	00004517          	auipc	a0,0x4
    800049a0:	d5c50513          	addi	a0,a0,-676 # 800086f8 <syscalls+0x268>
    800049a4:	ffffc097          	auipc	ra,0xffffc
    800049a8:	b94080e7          	jalr	-1132(ra) # 80000538 <panic>
    return -1;
    800049ac:	597d                	li	s2,-1
    800049ae:	b765                	j	80004956 <fileread+0x60>
      return -1;
    800049b0:	597d                	li	s2,-1
    800049b2:	b755                	j	80004956 <fileread+0x60>
    800049b4:	597d                	li	s2,-1
    800049b6:	b745                	j	80004956 <fileread+0x60>

00000000800049b8 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    800049b8:	715d                	addi	sp,sp,-80
    800049ba:	e486                	sd	ra,72(sp)
    800049bc:	e0a2                	sd	s0,64(sp)
    800049be:	fc26                	sd	s1,56(sp)
    800049c0:	f84a                	sd	s2,48(sp)
    800049c2:	f44e                	sd	s3,40(sp)
    800049c4:	f052                	sd	s4,32(sp)
    800049c6:	ec56                	sd	s5,24(sp)
    800049c8:	e85a                	sd	s6,16(sp)
    800049ca:	e45e                	sd	s7,8(sp)
    800049cc:	e062                	sd	s8,0(sp)
    800049ce:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    800049d0:	00954783          	lbu	a5,9(a0)
    800049d4:	10078663          	beqz	a5,80004ae0 <filewrite+0x128>
    800049d8:	892a                	mv	s2,a0
    800049da:	8aae                	mv	s5,a1
    800049dc:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    800049de:	411c                	lw	a5,0(a0)
    800049e0:	4705                	li	a4,1
    800049e2:	02e78263          	beq	a5,a4,80004a06 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800049e6:	470d                	li	a4,3
    800049e8:	02e78663          	beq	a5,a4,80004a14 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    800049ec:	4709                	li	a4,2
    800049ee:	0ee79163          	bne	a5,a4,80004ad0 <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    800049f2:	0ac05d63          	blez	a2,80004aac <filewrite+0xf4>
    int i = 0;
    800049f6:	4981                	li	s3,0
    800049f8:	6b05                	lui	s6,0x1
    800049fa:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    800049fe:	6b85                	lui	s7,0x1
    80004a00:	c00b8b9b          	addiw	s7,s7,-1024
    80004a04:	a861                	j	80004a9c <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    80004a06:	6908                	ld	a0,16(a0)
    80004a08:	00000097          	auipc	ra,0x0
    80004a0c:	22e080e7          	jalr	558(ra) # 80004c36 <pipewrite>
    80004a10:	8a2a                	mv	s4,a0
    80004a12:	a045                	j	80004ab2 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80004a14:	02451783          	lh	a5,36(a0)
    80004a18:	03079693          	slli	a3,a5,0x30
    80004a1c:	92c1                	srli	a3,a3,0x30
    80004a1e:	4725                	li	a4,9
    80004a20:	0cd76263          	bltu	a4,a3,80004ae4 <filewrite+0x12c>
    80004a24:	0792                	slli	a5,a5,0x4
    80004a26:	0001d717          	auipc	a4,0x1d
    80004a2a:	ef270713          	addi	a4,a4,-270 # 80021918 <devsw>
    80004a2e:	97ba                	add	a5,a5,a4
    80004a30:	679c                	ld	a5,8(a5)
    80004a32:	cbdd                	beqz	a5,80004ae8 <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    80004a34:	4505                	li	a0,1
    80004a36:	9782                	jalr	a5
    80004a38:	8a2a                	mv	s4,a0
    80004a3a:	a8a5                	j	80004ab2 <filewrite+0xfa>
    80004a3c:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80004a40:	00000097          	auipc	ra,0x0
    80004a44:	8b0080e7          	jalr	-1872(ra) # 800042f0 <begin_op>
      ilock(f->ip);
    80004a48:	01893503          	ld	a0,24(s2)
    80004a4c:	fffff097          	auipc	ra,0xfffff
    80004a50:	ed2080e7          	jalr	-302(ra) # 8000391e <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80004a54:	8762                	mv	a4,s8
    80004a56:	02092683          	lw	a3,32(s2)
    80004a5a:	01598633          	add	a2,s3,s5
    80004a5e:	4585                	li	a1,1
    80004a60:	01893503          	ld	a0,24(s2)
    80004a64:	fffff097          	auipc	ra,0xfffff
    80004a68:	266080e7          	jalr	614(ra) # 80003cca <writei>
    80004a6c:	84aa                	mv	s1,a0
    80004a6e:	00a05763          	blez	a0,80004a7c <filewrite+0xc4>
        f->off += r;
    80004a72:	02092783          	lw	a5,32(s2)
    80004a76:	9fa9                	addw	a5,a5,a0
    80004a78:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80004a7c:	01893503          	ld	a0,24(s2)
    80004a80:	fffff097          	auipc	ra,0xfffff
    80004a84:	f60080e7          	jalr	-160(ra) # 800039e0 <iunlock>
      end_op();
    80004a88:	00000097          	auipc	ra,0x0
    80004a8c:	8e8080e7          	jalr	-1816(ra) # 80004370 <end_op>

      if(r != n1){
    80004a90:	009c1f63          	bne	s8,s1,80004aae <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    80004a94:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80004a98:	0149db63          	bge	s3,s4,80004aae <filewrite+0xf6>
      int n1 = n - i;
    80004a9c:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    80004aa0:	84be                	mv	s1,a5
    80004aa2:	2781                	sext.w	a5,a5
    80004aa4:	f8fb5ce3          	bge	s6,a5,80004a3c <filewrite+0x84>
    80004aa8:	84de                	mv	s1,s7
    80004aaa:	bf49                	j	80004a3c <filewrite+0x84>
    int i = 0;
    80004aac:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80004aae:	013a1f63          	bne	s4,s3,80004acc <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80004ab2:	8552                	mv	a0,s4
    80004ab4:	60a6                	ld	ra,72(sp)
    80004ab6:	6406                	ld	s0,64(sp)
    80004ab8:	74e2                	ld	s1,56(sp)
    80004aba:	7942                	ld	s2,48(sp)
    80004abc:	79a2                	ld	s3,40(sp)
    80004abe:	7a02                	ld	s4,32(sp)
    80004ac0:	6ae2                	ld	s5,24(sp)
    80004ac2:	6b42                	ld	s6,16(sp)
    80004ac4:	6ba2                	ld	s7,8(sp)
    80004ac6:	6c02                	ld	s8,0(sp)
    80004ac8:	6161                	addi	sp,sp,80
    80004aca:	8082                	ret
    ret = (i == n ? n : -1);
    80004acc:	5a7d                	li	s4,-1
    80004ace:	b7d5                	j	80004ab2 <filewrite+0xfa>
    panic("filewrite");
    80004ad0:	00004517          	auipc	a0,0x4
    80004ad4:	c3850513          	addi	a0,a0,-968 # 80008708 <syscalls+0x278>
    80004ad8:	ffffc097          	auipc	ra,0xffffc
    80004adc:	a60080e7          	jalr	-1440(ra) # 80000538 <panic>
    return -1;
    80004ae0:	5a7d                	li	s4,-1
    80004ae2:	bfc1                	j	80004ab2 <filewrite+0xfa>
      return -1;
    80004ae4:	5a7d                	li	s4,-1
    80004ae6:	b7f1                	j	80004ab2 <filewrite+0xfa>
    80004ae8:	5a7d                	li	s4,-1
    80004aea:	b7e1                	j	80004ab2 <filewrite+0xfa>

0000000080004aec <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80004aec:	7179                	addi	sp,sp,-48
    80004aee:	f406                	sd	ra,40(sp)
    80004af0:	f022                	sd	s0,32(sp)
    80004af2:	ec26                	sd	s1,24(sp)
    80004af4:	e84a                	sd	s2,16(sp)
    80004af6:	e44e                	sd	s3,8(sp)
    80004af8:	e052                	sd	s4,0(sp)
    80004afa:	1800                	addi	s0,sp,48
    80004afc:	84aa                	mv	s1,a0
    80004afe:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80004b00:	0005b023          	sd	zero,0(a1)
    80004b04:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80004b08:	00000097          	auipc	ra,0x0
    80004b0c:	bf8080e7          	jalr	-1032(ra) # 80004700 <filealloc>
    80004b10:	e088                	sd	a0,0(s1)
    80004b12:	c551                	beqz	a0,80004b9e <pipealloc+0xb2>
    80004b14:	00000097          	auipc	ra,0x0
    80004b18:	bec080e7          	jalr	-1044(ra) # 80004700 <filealloc>
    80004b1c:	00aa3023          	sd	a0,0(s4)
    80004b20:	c92d                	beqz	a0,80004b92 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80004b22:	ffffc097          	auipc	ra,0xffffc
    80004b26:	fbe080e7          	jalr	-66(ra) # 80000ae0 <kalloc>
    80004b2a:	892a                	mv	s2,a0
    80004b2c:	c125                	beqz	a0,80004b8c <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80004b2e:	4985                	li	s3,1
    80004b30:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80004b34:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80004b38:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80004b3c:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80004b40:	00004597          	auipc	a1,0x4
    80004b44:	bd858593          	addi	a1,a1,-1064 # 80008718 <syscalls+0x288>
    80004b48:	ffffc097          	auipc	ra,0xffffc
    80004b4c:	ff8080e7          	jalr	-8(ra) # 80000b40 <initlock>
  (*f0)->type = FD_PIPE;
    80004b50:	609c                	ld	a5,0(s1)
    80004b52:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80004b56:	609c                	ld	a5,0(s1)
    80004b58:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80004b5c:	609c                	ld	a5,0(s1)
    80004b5e:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80004b62:	609c                	ld	a5,0(s1)
    80004b64:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80004b68:	000a3783          	ld	a5,0(s4)
    80004b6c:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80004b70:	000a3783          	ld	a5,0(s4)
    80004b74:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80004b78:	000a3783          	ld	a5,0(s4)
    80004b7c:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80004b80:	000a3783          	ld	a5,0(s4)
    80004b84:	0127b823          	sd	s2,16(a5)
  return 0;
    80004b88:	4501                	li	a0,0
    80004b8a:	a025                	j	80004bb2 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004b8c:	6088                	ld	a0,0(s1)
    80004b8e:	e501                	bnez	a0,80004b96 <pipealloc+0xaa>
    80004b90:	a039                	j	80004b9e <pipealloc+0xb2>
    80004b92:	6088                	ld	a0,0(s1)
    80004b94:	c51d                	beqz	a0,80004bc2 <pipealloc+0xd6>
    fileclose(*f0);
    80004b96:	00000097          	auipc	ra,0x0
    80004b9a:	c26080e7          	jalr	-986(ra) # 800047bc <fileclose>
  if(*f1)
    80004b9e:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80004ba2:	557d                	li	a0,-1
  if(*f1)
    80004ba4:	c799                	beqz	a5,80004bb2 <pipealloc+0xc6>
    fileclose(*f1);
    80004ba6:	853e                	mv	a0,a5
    80004ba8:	00000097          	auipc	ra,0x0
    80004bac:	c14080e7          	jalr	-1004(ra) # 800047bc <fileclose>
  return -1;
    80004bb0:	557d                	li	a0,-1
}
    80004bb2:	70a2                	ld	ra,40(sp)
    80004bb4:	7402                	ld	s0,32(sp)
    80004bb6:	64e2                	ld	s1,24(sp)
    80004bb8:	6942                	ld	s2,16(sp)
    80004bba:	69a2                	ld	s3,8(sp)
    80004bbc:	6a02                	ld	s4,0(sp)
    80004bbe:	6145                	addi	sp,sp,48
    80004bc0:	8082                	ret
  return -1;
    80004bc2:	557d                	li	a0,-1
    80004bc4:	b7fd                	j	80004bb2 <pipealloc+0xc6>

0000000080004bc6 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004bc6:	1101                	addi	sp,sp,-32
    80004bc8:	ec06                	sd	ra,24(sp)
    80004bca:	e822                	sd	s0,16(sp)
    80004bcc:	e426                	sd	s1,8(sp)
    80004bce:	e04a                	sd	s2,0(sp)
    80004bd0:	1000                	addi	s0,sp,32
    80004bd2:	84aa                	mv	s1,a0
    80004bd4:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80004bd6:	ffffc097          	auipc	ra,0xffffc
    80004bda:	ffa080e7          	jalr	-6(ra) # 80000bd0 <acquire>
  if(writable){
    80004bde:	02090d63          	beqz	s2,80004c18 <pipeclose+0x52>
    pi->writeopen = 0;
    80004be2:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80004be6:	21848513          	addi	a0,s1,536
    80004bea:	ffffd097          	auipc	ra,0xffffd
    80004bee:	614080e7          	jalr	1556(ra) # 800021fe <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004bf2:	2204b783          	ld	a5,544(s1)
    80004bf6:	eb95                	bnez	a5,80004c2a <pipeclose+0x64>
    release(&pi->lock);
    80004bf8:	8526                	mv	a0,s1
    80004bfa:	ffffc097          	auipc	ra,0xffffc
    80004bfe:	08a080e7          	jalr	138(ra) # 80000c84 <release>
    kfree((char*)pi);
    80004c02:	8526                	mv	a0,s1
    80004c04:	ffffc097          	auipc	ra,0xffffc
    80004c08:	de0080e7          	jalr	-544(ra) # 800009e4 <kfree>
  } else
    release(&pi->lock);
}
    80004c0c:	60e2                	ld	ra,24(sp)
    80004c0e:	6442                	ld	s0,16(sp)
    80004c10:	64a2                	ld	s1,8(sp)
    80004c12:	6902                	ld	s2,0(sp)
    80004c14:	6105                	addi	sp,sp,32
    80004c16:	8082                	ret
    pi->readopen = 0;
    80004c18:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80004c1c:	21c48513          	addi	a0,s1,540
    80004c20:	ffffd097          	auipc	ra,0xffffd
    80004c24:	5de080e7          	jalr	1502(ra) # 800021fe <wakeup>
    80004c28:	b7e9                	j	80004bf2 <pipeclose+0x2c>
    release(&pi->lock);
    80004c2a:	8526                	mv	a0,s1
    80004c2c:	ffffc097          	auipc	ra,0xffffc
    80004c30:	058080e7          	jalr	88(ra) # 80000c84 <release>
}
    80004c34:	bfe1                	j	80004c0c <pipeclose+0x46>

0000000080004c36 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80004c36:	711d                	addi	sp,sp,-96
    80004c38:	ec86                	sd	ra,88(sp)
    80004c3a:	e8a2                	sd	s0,80(sp)
    80004c3c:	e4a6                	sd	s1,72(sp)
    80004c3e:	e0ca                	sd	s2,64(sp)
    80004c40:	fc4e                	sd	s3,56(sp)
    80004c42:	f852                	sd	s4,48(sp)
    80004c44:	f456                	sd	s5,40(sp)
    80004c46:	f05a                	sd	s6,32(sp)
    80004c48:	ec5e                	sd	s7,24(sp)
    80004c4a:	e862                	sd	s8,16(sp)
    80004c4c:	1080                	addi	s0,sp,96
    80004c4e:	84aa                	mv	s1,a0
    80004c50:	8aae                	mv	s5,a1
    80004c52:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80004c54:	ffffd097          	auipc	ra,0xffffd
    80004c58:	d42080e7          	jalr	-702(ra) # 80001996 <myproc>
    80004c5c:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80004c5e:	8526                	mv	a0,s1
    80004c60:	ffffc097          	auipc	ra,0xffffc
    80004c64:	f70080e7          	jalr	-144(ra) # 80000bd0 <acquire>
  while(i < n){
    80004c68:	0b405363          	blez	s4,80004d0e <pipewrite+0xd8>
  int i = 0;
    80004c6c:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004c6e:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80004c70:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80004c74:	21c48b93          	addi	s7,s1,540
    80004c78:	a089                	j	80004cba <pipewrite+0x84>
      release(&pi->lock);
    80004c7a:	8526                	mv	a0,s1
    80004c7c:	ffffc097          	auipc	ra,0xffffc
    80004c80:	008080e7          	jalr	8(ra) # 80000c84 <release>
      return -1;
    80004c84:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004c86:	854a                	mv	a0,s2
    80004c88:	60e6                	ld	ra,88(sp)
    80004c8a:	6446                	ld	s0,80(sp)
    80004c8c:	64a6                	ld	s1,72(sp)
    80004c8e:	6906                	ld	s2,64(sp)
    80004c90:	79e2                	ld	s3,56(sp)
    80004c92:	7a42                	ld	s4,48(sp)
    80004c94:	7aa2                	ld	s5,40(sp)
    80004c96:	7b02                	ld	s6,32(sp)
    80004c98:	6be2                	ld	s7,24(sp)
    80004c9a:	6c42                	ld	s8,16(sp)
    80004c9c:	6125                	addi	sp,sp,96
    80004c9e:	8082                	ret
      wakeup(&pi->nread);
    80004ca0:	8562                	mv	a0,s8
    80004ca2:	ffffd097          	auipc	ra,0xffffd
    80004ca6:	55c080e7          	jalr	1372(ra) # 800021fe <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004caa:	85a6                	mv	a1,s1
    80004cac:	855e                	mv	a0,s7
    80004cae:	ffffd097          	auipc	ra,0xffffd
    80004cb2:	3b4080e7          	jalr	948(ra) # 80002062 <sleep>
  while(i < n){
    80004cb6:	05495d63          	bge	s2,s4,80004d10 <pipewrite+0xda>
    if(pi->readopen == 0 || pr->killed){
    80004cba:	2204a783          	lw	a5,544(s1)
    80004cbe:	dfd5                	beqz	a5,80004c7a <pipewrite+0x44>
    80004cc0:	0289a783          	lw	a5,40(s3)
    80004cc4:	fbdd                	bnez	a5,80004c7a <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004cc6:	2184a783          	lw	a5,536(s1)
    80004cca:	21c4a703          	lw	a4,540(s1)
    80004cce:	2007879b          	addiw	a5,a5,512
    80004cd2:	fcf707e3          	beq	a4,a5,80004ca0 <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004cd6:	4685                	li	a3,1
    80004cd8:	01590633          	add	a2,s2,s5
    80004cdc:	faf40593          	addi	a1,s0,-81
    80004ce0:	0509b503          	ld	a0,80(s3)
    80004ce4:	ffffd097          	auipc	ra,0xffffd
    80004ce8:	9fe080e7          	jalr	-1538(ra) # 800016e2 <copyin>
    80004cec:	03650263          	beq	a0,s6,80004d10 <pipewrite+0xda>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004cf0:	21c4a783          	lw	a5,540(s1)
    80004cf4:	0017871b          	addiw	a4,a5,1
    80004cf8:	20e4ae23          	sw	a4,540(s1)
    80004cfc:	1ff7f793          	andi	a5,a5,511
    80004d00:	97a6                	add	a5,a5,s1
    80004d02:	faf44703          	lbu	a4,-81(s0)
    80004d06:	00e78c23          	sb	a4,24(a5)
      i++;
    80004d0a:	2905                	addiw	s2,s2,1
    80004d0c:	b76d                	j	80004cb6 <pipewrite+0x80>
  int i = 0;
    80004d0e:	4901                	li	s2,0
  wakeup(&pi->nread);
    80004d10:	21848513          	addi	a0,s1,536
    80004d14:	ffffd097          	auipc	ra,0xffffd
    80004d18:	4ea080e7          	jalr	1258(ra) # 800021fe <wakeup>
  release(&pi->lock);
    80004d1c:	8526                	mv	a0,s1
    80004d1e:	ffffc097          	auipc	ra,0xffffc
    80004d22:	f66080e7          	jalr	-154(ra) # 80000c84 <release>
  return i;
    80004d26:	b785                	j	80004c86 <pipewrite+0x50>

0000000080004d28 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004d28:	715d                	addi	sp,sp,-80
    80004d2a:	e486                	sd	ra,72(sp)
    80004d2c:	e0a2                	sd	s0,64(sp)
    80004d2e:	fc26                	sd	s1,56(sp)
    80004d30:	f84a                	sd	s2,48(sp)
    80004d32:	f44e                	sd	s3,40(sp)
    80004d34:	f052                	sd	s4,32(sp)
    80004d36:	ec56                	sd	s5,24(sp)
    80004d38:	e85a                	sd	s6,16(sp)
    80004d3a:	0880                	addi	s0,sp,80
    80004d3c:	84aa                	mv	s1,a0
    80004d3e:	892e                	mv	s2,a1
    80004d40:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80004d42:	ffffd097          	auipc	ra,0xffffd
    80004d46:	c54080e7          	jalr	-940(ra) # 80001996 <myproc>
    80004d4a:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80004d4c:	8526                	mv	a0,s1
    80004d4e:	ffffc097          	auipc	ra,0xffffc
    80004d52:	e82080e7          	jalr	-382(ra) # 80000bd0 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004d56:	2184a703          	lw	a4,536(s1)
    80004d5a:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004d5e:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004d62:	02f71463          	bne	a4,a5,80004d8a <piperead+0x62>
    80004d66:	2244a783          	lw	a5,548(s1)
    80004d6a:	c385                	beqz	a5,80004d8a <piperead+0x62>
    if(pr->killed){
    80004d6c:	028a2783          	lw	a5,40(s4)
    80004d70:	ebc1                	bnez	a5,80004e00 <piperead+0xd8>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004d72:	85a6                	mv	a1,s1
    80004d74:	854e                	mv	a0,s3
    80004d76:	ffffd097          	auipc	ra,0xffffd
    80004d7a:	2ec080e7          	jalr	748(ra) # 80002062 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004d7e:	2184a703          	lw	a4,536(s1)
    80004d82:	21c4a783          	lw	a5,540(s1)
    80004d86:	fef700e3          	beq	a4,a5,80004d66 <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004d8a:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004d8c:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004d8e:	05505363          	blez	s5,80004dd4 <piperead+0xac>
    if(pi->nread == pi->nwrite)
    80004d92:	2184a783          	lw	a5,536(s1)
    80004d96:	21c4a703          	lw	a4,540(s1)
    80004d9a:	02f70d63          	beq	a4,a5,80004dd4 <piperead+0xac>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004d9e:	0017871b          	addiw	a4,a5,1
    80004da2:	20e4ac23          	sw	a4,536(s1)
    80004da6:	1ff7f793          	andi	a5,a5,511
    80004daa:	97a6                	add	a5,a5,s1
    80004dac:	0187c783          	lbu	a5,24(a5)
    80004db0:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004db4:	4685                	li	a3,1
    80004db6:	fbf40613          	addi	a2,s0,-65
    80004dba:	85ca                	mv	a1,s2
    80004dbc:	050a3503          	ld	a0,80(s4)
    80004dc0:	ffffd097          	auipc	ra,0xffffd
    80004dc4:	896080e7          	jalr	-1898(ra) # 80001656 <copyout>
    80004dc8:	01650663          	beq	a0,s6,80004dd4 <piperead+0xac>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004dcc:	2985                	addiw	s3,s3,1
    80004dce:	0905                	addi	s2,s2,1
    80004dd0:	fd3a91e3          	bne	s5,s3,80004d92 <piperead+0x6a>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004dd4:	21c48513          	addi	a0,s1,540
    80004dd8:	ffffd097          	auipc	ra,0xffffd
    80004ddc:	426080e7          	jalr	1062(ra) # 800021fe <wakeup>
  release(&pi->lock);
    80004de0:	8526                	mv	a0,s1
    80004de2:	ffffc097          	auipc	ra,0xffffc
    80004de6:	ea2080e7          	jalr	-350(ra) # 80000c84 <release>
  return i;
}
    80004dea:	854e                	mv	a0,s3
    80004dec:	60a6                	ld	ra,72(sp)
    80004dee:	6406                	ld	s0,64(sp)
    80004df0:	74e2                	ld	s1,56(sp)
    80004df2:	7942                	ld	s2,48(sp)
    80004df4:	79a2                	ld	s3,40(sp)
    80004df6:	7a02                	ld	s4,32(sp)
    80004df8:	6ae2                	ld	s5,24(sp)
    80004dfa:	6b42                	ld	s6,16(sp)
    80004dfc:	6161                	addi	sp,sp,80
    80004dfe:	8082                	ret
      release(&pi->lock);
    80004e00:	8526                	mv	a0,s1
    80004e02:	ffffc097          	auipc	ra,0xffffc
    80004e06:	e82080e7          	jalr	-382(ra) # 80000c84 <release>
      return -1;
    80004e0a:	59fd                	li	s3,-1
    80004e0c:	bff9                	j	80004dea <piperead+0xc2>

0000000080004e0e <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    80004e0e:	de010113          	addi	sp,sp,-544
    80004e12:	20113c23          	sd	ra,536(sp)
    80004e16:	20813823          	sd	s0,528(sp)
    80004e1a:	20913423          	sd	s1,520(sp)
    80004e1e:	21213023          	sd	s2,512(sp)
    80004e22:	ffce                	sd	s3,504(sp)
    80004e24:	fbd2                	sd	s4,496(sp)
    80004e26:	f7d6                	sd	s5,488(sp)
    80004e28:	f3da                	sd	s6,480(sp)
    80004e2a:	efde                	sd	s7,472(sp)
    80004e2c:	ebe2                	sd	s8,464(sp)
    80004e2e:	e7e6                	sd	s9,456(sp)
    80004e30:	e3ea                	sd	s10,448(sp)
    80004e32:	ff6e                	sd	s11,440(sp)
    80004e34:	1400                	addi	s0,sp,544
    80004e36:	892a                	mv	s2,a0
    80004e38:	dea43423          	sd	a0,-536(s0)
    80004e3c:	deb43823          	sd	a1,-528(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004e40:	ffffd097          	auipc	ra,0xffffd
    80004e44:	b56080e7          	jalr	-1194(ra) # 80001996 <myproc>
    80004e48:	84aa                	mv	s1,a0

  begin_op();
    80004e4a:	fffff097          	auipc	ra,0xfffff
    80004e4e:	4a6080e7          	jalr	1190(ra) # 800042f0 <begin_op>

  if((ip = namei(path)) == 0){
    80004e52:	854a                	mv	a0,s2
    80004e54:	fffff097          	auipc	ra,0xfffff
    80004e58:	280080e7          	jalr	640(ra) # 800040d4 <namei>
    80004e5c:	c93d                	beqz	a0,80004ed2 <exec+0xc4>
    80004e5e:	8aaa                	mv	s5,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004e60:	fffff097          	auipc	ra,0xfffff
    80004e64:	abe080e7          	jalr	-1346(ra) # 8000391e <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004e68:	04000713          	li	a4,64
    80004e6c:	4681                	li	a3,0
    80004e6e:	e5040613          	addi	a2,s0,-432
    80004e72:	4581                	li	a1,0
    80004e74:	8556                	mv	a0,s5
    80004e76:	fffff097          	auipc	ra,0xfffff
    80004e7a:	d5c080e7          	jalr	-676(ra) # 80003bd2 <readi>
    80004e7e:	04000793          	li	a5,64
    80004e82:	00f51a63          	bne	a0,a5,80004e96 <exec+0x88>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80004e86:	e5042703          	lw	a4,-432(s0)
    80004e8a:	464c47b7          	lui	a5,0x464c4
    80004e8e:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004e92:	04f70663          	beq	a4,a5,80004ede <exec+0xd0>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80004e96:	8556                	mv	a0,s5
    80004e98:	fffff097          	auipc	ra,0xfffff
    80004e9c:	ce8080e7          	jalr	-792(ra) # 80003b80 <iunlockput>
    end_op();
    80004ea0:	fffff097          	auipc	ra,0xfffff
    80004ea4:	4d0080e7          	jalr	1232(ra) # 80004370 <end_op>
  }
  return -1;
    80004ea8:	557d                	li	a0,-1
}
    80004eaa:	21813083          	ld	ra,536(sp)
    80004eae:	21013403          	ld	s0,528(sp)
    80004eb2:	20813483          	ld	s1,520(sp)
    80004eb6:	20013903          	ld	s2,512(sp)
    80004eba:	79fe                	ld	s3,504(sp)
    80004ebc:	7a5e                	ld	s4,496(sp)
    80004ebe:	7abe                	ld	s5,488(sp)
    80004ec0:	7b1e                	ld	s6,480(sp)
    80004ec2:	6bfe                	ld	s7,472(sp)
    80004ec4:	6c5e                	ld	s8,464(sp)
    80004ec6:	6cbe                	ld	s9,456(sp)
    80004ec8:	6d1e                	ld	s10,448(sp)
    80004eca:	7dfa                	ld	s11,440(sp)
    80004ecc:	22010113          	addi	sp,sp,544
    80004ed0:	8082                	ret
    end_op();
    80004ed2:	fffff097          	auipc	ra,0xfffff
    80004ed6:	49e080e7          	jalr	1182(ra) # 80004370 <end_op>
    return -1;
    80004eda:	557d                	li	a0,-1
    80004edc:	b7f9                	j	80004eaa <exec+0x9c>
  if((pagetable = proc_pagetable(p)) == 0)
    80004ede:	8526                	mv	a0,s1
    80004ee0:	ffffd097          	auipc	ra,0xffffd
    80004ee4:	b7a080e7          	jalr	-1158(ra) # 80001a5a <proc_pagetable>
    80004ee8:	8b2a                	mv	s6,a0
    80004eea:	d555                	beqz	a0,80004e96 <exec+0x88>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004eec:	e7042783          	lw	a5,-400(s0)
    80004ef0:	e8845703          	lhu	a4,-376(s0)
    80004ef4:	c735                	beqz	a4,80004f60 <exec+0x152>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004ef6:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004ef8:	e0043423          	sd	zero,-504(s0)
    if((ph.vaddr % PGSIZE) != 0)
    80004efc:	6a05                	lui	s4,0x1
    80004efe:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    80004f02:	dee43023          	sd	a4,-544(s0)
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    80004f06:	6d85                	lui	s11,0x1
    80004f08:	7d7d                	lui	s10,0xfffff
    80004f0a:	ac1d                	j	80005140 <exec+0x332>
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    80004f0c:	00004517          	auipc	a0,0x4
    80004f10:	81450513          	addi	a0,a0,-2028 # 80008720 <syscalls+0x290>
    80004f14:	ffffb097          	auipc	ra,0xffffb
    80004f18:	624080e7          	jalr	1572(ra) # 80000538 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004f1c:	874a                	mv	a4,s2
    80004f1e:	009c86bb          	addw	a3,s9,s1
    80004f22:	4581                	li	a1,0
    80004f24:	8556                	mv	a0,s5
    80004f26:	fffff097          	auipc	ra,0xfffff
    80004f2a:	cac080e7          	jalr	-852(ra) # 80003bd2 <readi>
    80004f2e:	2501                	sext.w	a0,a0
    80004f30:	1aa91863          	bne	s2,a0,800050e0 <exec+0x2d2>
  for(i = 0; i < sz; i += PGSIZE){
    80004f34:	009d84bb          	addw	s1,s11,s1
    80004f38:	013d09bb          	addw	s3,s10,s3
    80004f3c:	1f74f263          	bgeu	s1,s7,80005120 <exec+0x312>
    pa = walkaddr(pagetable, va + i);
    80004f40:	02049593          	slli	a1,s1,0x20
    80004f44:	9181                	srli	a1,a1,0x20
    80004f46:	95e2                	add	a1,a1,s8
    80004f48:	855a                	mv	a0,s6
    80004f4a:	ffffc097          	auipc	ra,0xffffc
    80004f4e:	108080e7          	jalr	264(ra) # 80001052 <walkaddr>
    80004f52:	862a                	mv	a2,a0
    if(pa == 0)
    80004f54:	dd45                	beqz	a0,80004f0c <exec+0xfe>
      n = PGSIZE;
    80004f56:	8952                	mv	s2,s4
    if(sz - i < PGSIZE)
    80004f58:	fd49f2e3          	bgeu	s3,s4,80004f1c <exec+0x10e>
      n = sz - i;
    80004f5c:	894e                	mv	s2,s3
    80004f5e:	bf7d                	j	80004f1c <exec+0x10e>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004f60:	4481                	li	s1,0
  iunlockput(ip);
    80004f62:	8556                	mv	a0,s5
    80004f64:	fffff097          	auipc	ra,0xfffff
    80004f68:	c1c080e7          	jalr	-996(ra) # 80003b80 <iunlockput>
  end_op();
    80004f6c:	fffff097          	auipc	ra,0xfffff
    80004f70:	404080e7          	jalr	1028(ra) # 80004370 <end_op>
  p = myproc();
    80004f74:	ffffd097          	auipc	ra,0xffffd
    80004f78:	a22080e7          	jalr	-1502(ra) # 80001996 <myproc>
    80004f7c:	8baa                	mv	s7,a0
  uint64 oldsz = p->sz;
    80004f7e:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    80004f82:	6785                	lui	a5,0x1
    80004f84:	17fd                	addi	a5,a5,-1
    80004f86:	94be                	add	s1,s1,a5
    80004f88:	77fd                	lui	a5,0xfffff
    80004f8a:	8fe5                	and	a5,a5,s1
    80004f8c:	def43c23          	sd	a5,-520(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004f90:	6609                	lui	a2,0x2
    80004f92:	963e                	add	a2,a2,a5
    80004f94:	85be                	mv	a1,a5
    80004f96:	855a                	mv	a0,s6
    80004f98:	ffffc097          	auipc	ra,0xffffc
    80004f9c:	46e080e7          	jalr	1134(ra) # 80001406 <uvmalloc>
    80004fa0:	8c2a                	mv	s8,a0
  ip = 0;
    80004fa2:	4a81                	li	s5,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004fa4:	12050e63          	beqz	a0,800050e0 <exec+0x2d2>
  uvmclear(pagetable, sz-2*PGSIZE);
    80004fa8:	75f9                	lui	a1,0xffffe
    80004faa:	95aa                	add	a1,a1,a0
    80004fac:	855a                	mv	a0,s6
    80004fae:	ffffc097          	auipc	ra,0xffffc
    80004fb2:	676080e7          	jalr	1654(ra) # 80001624 <uvmclear>
  stackbase = sp - PGSIZE;
    80004fb6:	7afd                	lui	s5,0xfffff
    80004fb8:	9ae2                	add	s5,s5,s8
  for(argc = 0; argv[argc]; argc++) {
    80004fba:	df043783          	ld	a5,-528(s0)
    80004fbe:	6388                	ld	a0,0(a5)
    80004fc0:	c925                	beqz	a0,80005030 <exec+0x222>
    80004fc2:	e9040993          	addi	s3,s0,-368
    80004fc6:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    80004fca:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80004fcc:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    80004fce:	ffffc097          	auipc	ra,0xffffc
    80004fd2:	e7a080e7          	jalr	-390(ra) # 80000e48 <strlen>
    80004fd6:	0015079b          	addiw	a5,a0,1
    80004fda:	40f90933          	sub	s2,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004fde:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    80004fe2:	13596363          	bltu	s2,s5,80005108 <exec+0x2fa>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004fe6:	df043d83          	ld	s11,-528(s0)
    80004fea:	000dba03          	ld	s4,0(s11) # 1000 <_entry-0x7ffff000>
    80004fee:	8552                	mv	a0,s4
    80004ff0:	ffffc097          	auipc	ra,0xffffc
    80004ff4:	e58080e7          	jalr	-424(ra) # 80000e48 <strlen>
    80004ff8:	0015069b          	addiw	a3,a0,1
    80004ffc:	8652                	mv	a2,s4
    80004ffe:	85ca                	mv	a1,s2
    80005000:	855a                	mv	a0,s6
    80005002:	ffffc097          	auipc	ra,0xffffc
    80005006:	654080e7          	jalr	1620(ra) # 80001656 <copyout>
    8000500a:	10054363          	bltz	a0,80005110 <exec+0x302>
    ustack[argc] = sp;
    8000500e:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80005012:	0485                	addi	s1,s1,1
    80005014:	008d8793          	addi	a5,s11,8
    80005018:	def43823          	sd	a5,-528(s0)
    8000501c:	008db503          	ld	a0,8(s11)
    80005020:	c911                	beqz	a0,80005034 <exec+0x226>
    if(argc >= MAXARG)
    80005022:	09a1                	addi	s3,s3,8
    80005024:	fb3c95e3          	bne	s9,s3,80004fce <exec+0x1c0>
  sz = sz1;
    80005028:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    8000502c:	4a81                	li	s5,0
    8000502e:	a84d                	j	800050e0 <exec+0x2d2>
  sp = sz;
    80005030:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80005032:	4481                	li	s1,0
  ustack[argc] = 0;
    80005034:	00349793          	slli	a5,s1,0x3
    80005038:	f9040713          	addi	a4,s0,-112
    8000503c:	97ba                	add	a5,a5,a4
    8000503e:	f007b023          	sd	zero,-256(a5) # ffffffffffffef00 <end+0xffffffff7ffd8f00>
  sp -= (argc+1) * sizeof(uint64);
    80005042:	00148693          	addi	a3,s1,1
    80005046:	068e                	slli	a3,a3,0x3
    80005048:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    8000504c:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80005050:	01597663          	bgeu	s2,s5,8000505c <exec+0x24e>
  sz = sz1;
    80005054:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80005058:	4a81                	li	s5,0
    8000505a:	a059                	j	800050e0 <exec+0x2d2>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    8000505c:	e9040613          	addi	a2,s0,-368
    80005060:	85ca                	mv	a1,s2
    80005062:	855a                	mv	a0,s6
    80005064:	ffffc097          	auipc	ra,0xffffc
    80005068:	5f2080e7          	jalr	1522(ra) # 80001656 <copyout>
    8000506c:	0a054663          	bltz	a0,80005118 <exec+0x30a>
  p->trapframe->a1 = sp;
    80005070:	058bb783          	ld	a5,88(s7) # 1058 <_entry-0x7fffefa8>
    80005074:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80005078:	de843783          	ld	a5,-536(s0)
    8000507c:	0007c703          	lbu	a4,0(a5)
    80005080:	cf11                	beqz	a4,8000509c <exec+0x28e>
    80005082:	0785                	addi	a5,a5,1
    if(*s == '/')
    80005084:	02f00693          	li	a3,47
    80005088:	a039                	j	80005096 <exec+0x288>
      last = s+1;
    8000508a:	def43423          	sd	a5,-536(s0)
  for(last=s=path; *s; s++)
    8000508e:	0785                	addi	a5,a5,1
    80005090:	fff7c703          	lbu	a4,-1(a5)
    80005094:	c701                	beqz	a4,8000509c <exec+0x28e>
    if(*s == '/')
    80005096:	fed71ce3          	bne	a4,a3,8000508e <exec+0x280>
    8000509a:	bfc5                	j	8000508a <exec+0x27c>
  safestrcpy(p->name, last, sizeof(p->name));
    8000509c:	4641                	li	a2,16
    8000509e:	de843583          	ld	a1,-536(s0)
    800050a2:	158b8513          	addi	a0,s7,344
    800050a6:	ffffc097          	auipc	ra,0xffffc
    800050aa:	d70080e7          	jalr	-656(ra) # 80000e16 <safestrcpy>
  oldpagetable = p->pagetable;
    800050ae:	050bb503          	ld	a0,80(s7)
  p->pagetable = pagetable;
    800050b2:	056bb823          	sd	s6,80(s7)
  p->sz = sz;
    800050b6:	058bb423          	sd	s8,72(s7)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800050ba:	058bb783          	ld	a5,88(s7)
    800050be:	e6843703          	ld	a4,-408(s0)
    800050c2:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800050c4:	058bb783          	ld	a5,88(s7)
    800050c8:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800050cc:	85ea                	mv	a1,s10
    800050ce:	ffffd097          	auipc	ra,0xffffd
    800050d2:	a28080e7          	jalr	-1496(ra) # 80001af6 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800050d6:	0004851b          	sext.w	a0,s1
    800050da:	bbc1                	j	80004eaa <exec+0x9c>
    800050dc:	de943c23          	sd	s1,-520(s0)
    proc_freepagetable(pagetable, sz);
    800050e0:	df843583          	ld	a1,-520(s0)
    800050e4:	855a                	mv	a0,s6
    800050e6:	ffffd097          	auipc	ra,0xffffd
    800050ea:	a10080e7          	jalr	-1520(ra) # 80001af6 <proc_freepagetable>
  if(ip){
    800050ee:	da0a94e3          	bnez	s5,80004e96 <exec+0x88>
  return -1;
    800050f2:	557d                	li	a0,-1
    800050f4:	bb5d                	j	80004eaa <exec+0x9c>
    800050f6:	de943c23          	sd	s1,-520(s0)
    800050fa:	b7dd                	j	800050e0 <exec+0x2d2>
    800050fc:	de943c23          	sd	s1,-520(s0)
    80005100:	b7c5                	j	800050e0 <exec+0x2d2>
    80005102:	de943c23          	sd	s1,-520(s0)
    80005106:	bfe9                	j	800050e0 <exec+0x2d2>
  sz = sz1;
    80005108:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    8000510c:	4a81                	li	s5,0
    8000510e:	bfc9                	j	800050e0 <exec+0x2d2>
  sz = sz1;
    80005110:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80005114:	4a81                	li	s5,0
    80005116:	b7e9                	j	800050e0 <exec+0x2d2>
  sz = sz1;
    80005118:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    8000511c:	4a81                	li	s5,0
    8000511e:	b7c9                	j	800050e0 <exec+0x2d2>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80005120:	df843483          	ld	s1,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80005124:	e0843783          	ld	a5,-504(s0)
    80005128:	0017869b          	addiw	a3,a5,1
    8000512c:	e0d43423          	sd	a3,-504(s0)
    80005130:	e0043783          	ld	a5,-512(s0)
    80005134:	0387879b          	addiw	a5,a5,56
    80005138:	e8845703          	lhu	a4,-376(s0)
    8000513c:	e2e6d3e3          	bge	a3,a4,80004f62 <exec+0x154>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80005140:	2781                	sext.w	a5,a5
    80005142:	e0f43023          	sd	a5,-512(s0)
    80005146:	03800713          	li	a4,56
    8000514a:	86be                	mv	a3,a5
    8000514c:	e1840613          	addi	a2,s0,-488
    80005150:	4581                	li	a1,0
    80005152:	8556                	mv	a0,s5
    80005154:	fffff097          	auipc	ra,0xfffff
    80005158:	a7e080e7          	jalr	-1410(ra) # 80003bd2 <readi>
    8000515c:	03800793          	li	a5,56
    80005160:	f6f51ee3          	bne	a0,a5,800050dc <exec+0x2ce>
    if(ph.type != ELF_PROG_LOAD)
    80005164:	e1842783          	lw	a5,-488(s0)
    80005168:	4705                	li	a4,1
    8000516a:	fae79de3          	bne	a5,a4,80005124 <exec+0x316>
    if(ph.memsz < ph.filesz)
    8000516e:	e4043603          	ld	a2,-448(s0)
    80005172:	e3843783          	ld	a5,-456(s0)
    80005176:	f8f660e3          	bltu	a2,a5,800050f6 <exec+0x2e8>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    8000517a:	e2843783          	ld	a5,-472(s0)
    8000517e:	963e                	add	a2,a2,a5
    80005180:	f6f66ee3          	bltu	a2,a5,800050fc <exec+0x2ee>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80005184:	85a6                	mv	a1,s1
    80005186:	855a                	mv	a0,s6
    80005188:	ffffc097          	auipc	ra,0xffffc
    8000518c:	27e080e7          	jalr	638(ra) # 80001406 <uvmalloc>
    80005190:	dea43c23          	sd	a0,-520(s0)
    80005194:	d53d                	beqz	a0,80005102 <exec+0x2f4>
    if((ph.vaddr % PGSIZE) != 0)
    80005196:	e2843c03          	ld	s8,-472(s0)
    8000519a:	de043783          	ld	a5,-544(s0)
    8000519e:	00fc77b3          	and	a5,s8,a5
    800051a2:	ff9d                	bnez	a5,800050e0 <exec+0x2d2>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800051a4:	e2042c83          	lw	s9,-480(s0)
    800051a8:	e3842b83          	lw	s7,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    800051ac:	f60b8ae3          	beqz	s7,80005120 <exec+0x312>
    800051b0:	89de                	mv	s3,s7
    800051b2:	4481                	li	s1,0
    800051b4:	b371                	j	80004f40 <exec+0x132>

00000000800051b6 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    800051b6:	7179                	addi	sp,sp,-48
    800051b8:	f406                	sd	ra,40(sp)
    800051ba:	f022                	sd	s0,32(sp)
    800051bc:	ec26                	sd	s1,24(sp)
    800051be:	e84a                	sd	s2,16(sp)
    800051c0:	1800                	addi	s0,sp,48
    800051c2:	892e                	mv	s2,a1
    800051c4:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    800051c6:	fdc40593          	addi	a1,s0,-36
    800051ca:	ffffe097          	auipc	ra,0xffffe
    800051ce:	b4e080e7          	jalr	-1202(ra) # 80002d18 <argint>
    800051d2:	04054063          	bltz	a0,80005212 <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    800051d6:	fdc42703          	lw	a4,-36(s0)
    800051da:	47bd                	li	a5,15
    800051dc:	02e7ed63          	bltu	a5,a4,80005216 <argfd+0x60>
    800051e0:	ffffc097          	auipc	ra,0xffffc
    800051e4:	7b6080e7          	jalr	1974(ra) # 80001996 <myproc>
    800051e8:	fdc42703          	lw	a4,-36(s0)
    800051ec:	01a70793          	addi	a5,a4,26
    800051f0:	078e                	slli	a5,a5,0x3
    800051f2:	953e                	add	a0,a0,a5
    800051f4:	611c                	ld	a5,0(a0)
    800051f6:	c395                	beqz	a5,8000521a <argfd+0x64>
    return -1;
  if(pfd)
    800051f8:	00090463          	beqz	s2,80005200 <argfd+0x4a>
    *pfd = fd;
    800051fc:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80005200:	4501                	li	a0,0
  if(pf)
    80005202:	c091                	beqz	s1,80005206 <argfd+0x50>
    *pf = f;
    80005204:	e09c                	sd	a5,0(s1)
}
    80005206:	70a2                	ld	ra,40(sp)
    80005208:	7402                	ld	s0,32(sp)
    8000520a:	64e2                	ld	s1,24(sp)
    8000520c:	6942                	ld	s2,16(sp)
    8000520e:	6145                	addi	sp,sp,48
    80005210:	8082                	ret
    return -1;
    80005212:	557d                	li	a0,-1
    80005214:	bfcd                	j	80005206 <argfd+0x50>
    return -1;
    80005216:	557d                	li	a0,-1
    80005218:	b7fd                	j	80005206 <argfd+0x50>
    8000521a:	557d                	li	a0,-1
    8000521c:	b7ed                	j	80005206 <argfd+0x50>

000000008000521e <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    8000521e:	1101                	addi	sp,sp,-32
    80005220:	ec06                	sd	ra,24(sp)
    80005222:	e822                	sd	s0,16(sp)
    80005224:	e426                	sd	s1,8(sp)
    80005226:	1000                	addi	s0,sp,32
    80005228:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    8000522a:	ffffc097          	auipc	ra,0xffffc
    8000522e:	76c080e7          	jalr	1900(ra) # 80001996 <myproc>
    80005232:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80005234:	0d050793          	addi	a5,a0,208
    80005238:	4501                	li	a0,0
    8000523a:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    8000523c:	6398                	ld	a4,0(a5)
    8000523e:	cb19                	beqz	a4,80005254 <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80005240:	2505                	addiw	a0,a0,1
    80005242:	07a1                	addi	a5,a5,8
    80005244:	fed51ce3          	bne	a0,a3,8000523c <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80005248:	557d                	li	a0,-1
}
    8000524a:	60e2                	ld	ra,24(sp)
    8000524c:	6442                	ld	s0,16(sp)
    8000524e:	64a2                	ld	s1,8(sp)
    80005250:	6105                	addi	sp,sp,32
    80005252:	8082                	ret
      p->ofile[fd] = f;
    80005254:	01a50793          	addi	a5,a0,26
    80005258:	078e                	slli	a5,a5,0x3
    8000525a:	963e                	add	a2,a2,a5
    8000525c:	e204                	sd	s1,0(a2)
      return fd;
    8000525e:	b7f5                	j	8000524a <fdalloc+0x2c>

0000000080005260 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80005260:	715d                	addi	sp,sp,-80
    80005262:	e486                	sd	ra,72(sp)
    80005264:	e0a2                	sd	s0,64(sp)
    80005266:	fc26                	sd	s1,56(sp)
    80005268:	f84a                	sd	s2,48(sp)
    8000526a:	f44e                	sd	s3,40(sp)
    8000526c:	f052                	sd	s4,32(sp)
    8000526e:	ec56                	sd	s5,24(sp)
    80005270:	0880                	addi	s0,sp,80
    80005272:	89ae                	mv	s3,a1
    80005274:	8ab2                	mv	s5,a2
    80005276:	8a36                	mv	s4,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80005278:	fb040593          	addi	a1,s0,-80
    8000527c:	fffff097          	auipc	ra,0xfffff
    80005280:	e76080e7          	jalr	-394(ra) # 800040f2 <nameiparent>
    80005284:	892a                	mv	s2,a0
    80005286:	12050e63          	beqz	a0,800053c2 <create+0x162>
    return 0;

  ilock(dp);
    8000528a:	ffffe097          	auipc	ra,0xffffe
    8000528e:	694080e7          	jalr	1684(ra) # 8000391e <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80005292:	4601                	li	a2,0
    80005294:	fb040593          	addi	a1,s0,-80
    80005298:	854a                	mv	a0,s2
    8000529a:	fffff097          	auipc	ra,0xfffff
    8000529e:	b68080e7          	jalr	-1176(ra) # 80003e02 <dirlookup>
    800052a2:	84aa                	mv	s1,a0
    800052a4:	c921                	beqz	a0,800052f4 <create+0x94>
    iunlockput(dp);
    800052a6:	854a                	mv	a0,s2
    800052a8:	fffff097          	auipc	ra,0xfffff
    800052ac:	8d8080e7          	jalr	-1832(ra) # 80003b80 <iunlockput>
    ilock(ip);
    800052b0:	8526                	mv	a0,s1
    800052b2:	ffffe097          	auipc	ra,0xffffe
    800052b6:	66c080e7          	jalr	1644(ra) # 8000391e <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    800052ba:	2981                	sext.w	s3,s3
    800052bc:	4789                	li	a5,2
    800052be:	02f99463          	bne	s3,a5,800052e6 <create+0x86>
    800052c2:	0444d783          	lhu	a5,68(s1)
    800052c6:	37f9                	addiw	a5,a5,-2
    800052c8:	17c2                	slli	a5,a5,0x30
    800052ca:	93c1                	srli	a5,a5,0x30
    800052cc:	4705                	li	a4,1
    800052ce:	00f76c63          	bltu	a4,a5,800052e6 <create+0x86>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    800052d2:	8526                	mv	a0,s1
    800052d4:	60a6                	ld	ra,72(sp)
    800052d6:	6406                	ld	s0,64(sp)
    800052d8:	74e2                	ld	s1,56(sp)
    800052da:	7942                	ld	s2,48(sp)
    800052dc:	79a2                	ld	s3,40(sp)
    800052de:	7a02                	ld	s4,32(sp)
    800052e0:	6ae2                	ld	s5,24(sp)
    800052e2:	6161                	addi	sp,sp,80
    800052e4:	8082                	ret
    iunlockput(ip);
    800052e6:	8526                	mv	a0,s1
    800052e8:	fffff097          	auipc	ra,0xfffff
    800052ec:	898080e7          	jalr	-1896(ra) # 80003b80 <iunlockput>
    return 0;
    800052f0:	4481                	li	s1,0
    800052f2:	b7c5                	j	800052d2 <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0)
    800052f4:	85ce                	mv	a1,s3
    800052f6:	00092503          	lw	a0,0(s2)
    800052fa:	ffffe097          	auipc	ra,0xffffe
    800052fe:	48c080e7          	jalr	1164(ra) # 80003786 <ialloc>
    80005302:	84aa                	mv	s1,a0
    80005304:	c521                	beqz	a0,8000534c <create+0xec>
  ilock(ip);
    80005306:	ffffe097          	auipc	ra,0xffffe
    8000530a:	618080e7          	jalr	1560(ra) # 8000391e <ilock>
  ip->major = major;
    8000530e:	05549323          	sh	s5,70(s1)
  ip->minor = minor;
    80005312:	05449423          	sh	s4,72(s1)
  ip->nlink = 1;
    80005316:	4a05                	li	s4,1
    80005318:	05449523          	sh	s4,74(s1)
  iupdate(ip);
    8000531c:	8526                	mv	a0,s1
    8000531e:	ffffe097          	auipc	ra,0xffffe
    80005322:	536080e7          	jalr	1334(ra) # 80003854 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80005326:	2981                	sext.w	s3,s3
    80005328:	03498a63          	beq	s3,s4,8000535c <create+0xfc>
  if(dirlink(dp, name, ip->inum) < 0)
    8000532c:	40d0                	lw	a2,4(s1)
    8000532e:	fb040593          	addi	a1,s0,-80
    80005332:	854a                	mv	a0,s2
    80005334:	fffff097          	auipc	ra,0xfffff
    80005338:	cde080e7          	jalr	-802(ra) # 80004012 <dirlink>
    8000533c:	06054b63          	bltz	a0,800053b2 <create+0x152>
  iunlockput(dp);
    80005340:	854a                	mv	a0,s2
    80005342:	fffff097          	auipc	ra,0xfffff
    80005346:	83e080e7          	jalr	-1986(ra) # 80003b80 <iunlockput>
  return ip;
    8000534a:	b761                	j	800052d2 <create+0x72>
    panic("create: ialloc");
    8000534c:	00003517          	auipc	a0,0x3
    80005350:	3f450513          	addi	a0,a0,1012 # 80008740 <syscalls+0x2b0>
    80005354:	ffffb097          	auipc	ra,0xffffb
    80005358:	1e4080e7          	jalr	484(ra) # 80000538 <panic>
    dp->nlink++;  // for ".."
    8000535c:	04a95783          	lhu	a5,74(s2)
    80005360:	2785                	addiw	a5,a5,1
    80005362:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    80005366:	854a                	mv	a0,s2
    80005368:	ffffe097          	auipc	ra,0xffffe
    8000536c:	4ec080e7          	jalr	1260(ra) # 80003854 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80005370:	40d0                	lw	a2,4(s1)
    80005372:	00003597          	auipc	a1,0x3
    80005376:	3de58593          	addi	a1,a1,990 # 80008750 <syscalls+0x2c0>
    8000537a:	8526                	mv	a0,s1
    8000537c:	fffff097          	auipc	ra,0xfffff
    80005380:	c96080e7          	jalr	-874(ra) # 80004012 <dirlink>
    80005384:	00054f63          	bltz	a0,800053a2 <create+0x142>
    80005388:	00492603          	lw	a2,4(s2)
    8000538c:	00003597          	auipc	a1,0x3
    80005390:	3cc58593          	addi	a1,a1,972 # 80008758 <syscalls+0x2c8>
    80005394:	8526                	mv	a0,s1
    80005396:	fffff097          	auipc	ra,0xfffff
    8000539a:	c7c080e7          	jalr	-900(ra) # 80004012 <dirlink>
    8000539e:	f80557e3          	bgez	a0,8000532c <create+0xcc>
      panic("create dots");
    800053a2:	00003517          	auipc	a0,0x3
    800053a6:	3be50513          	addi	a0,a0,958 # 80008760 <syscalls+0x2d0>
    800053aa:	ffffb097          	auipc	ra,0xffffb
    800053ae:	18e080e7          	jalr	398(ra) # 80000538 <panic>
    panic("create: dirlink");
    800053b2:	00003517          	auipc	a0,0x3
    800053b6:	3be50513          	addi	a0,a0,958 # 80008770 <syscalls+0x2e0>
    800053ba:	ffffb097          	auipc	ra,0xffffb
    800053be:	17e080e7          	jalr	382(ra) # 80000538 <panic>
    return 0;
    800053c2:	84aa                	mv	s1,a0
    800053c4:	b739                	j	800052d2 <create+0x72>

00000000800053c6 <sys_dup>:
{
    800053c6:	7179                	addi	sp,sp,-48
    800053c8:	f406                	sd	ra,40(sp)
    800053ca:	f022                	sd	s0,32(sp)
    800053cc:	ec26                	sd	s1,24(sp)
    800053ce:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    800053d0:	fd840613          	addi	a2,s0,-40
    800053d4:	4581                	li	a1,0
    800053d6:	4501                	li	a0,0
    800053d8:	00000097          	auipc	ra,0x0
    800053dc:	dde080e7          	jalr	-546(ra) # 800051b6 <argfd>
    return -1;
    800053e0:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800053e2:	02054363          	bltz	a0,80005408 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    800053e6:	fd843503          	ld	a0,-40(s0)
    800053ea:	00000097          	auipc	ra,0x0
    800053ee:	e34080e7          	jalr	-460(ra) # 8000521e <fdalloc>
    800053f2:	84aa                	mv	s1,a0
    return -1;
    800053f4:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    800053f6:	00054963          	bltz	a0,80005408 <sys_dup+0x42>
  filedup(f);
    800053fa:	fd843503          	ld	a0,-40(s0)
    800053fe:	fffff097          	auipc	ra,0xfffff
    80005402:	36c080e7          	jalr	876(ra) # 8000476a <filedup>
  return fd;
    80005406:	87a6                	mv	a5,s1
}
    80005408:	853e                	mv	a0,a5
    8000540a:	70a2                	ld	ra,40(sp)
    8000540c:	7402                	ld	s0,32(sp)
    8000540e:	64e2                	ld	s1,24(sp)
    80005410:	6145                	addi	sp,sp,48
    80005412:	8082                	ret

0000000080005414 <sys_read>:
{
    80005414:	7179                	addi	sp,sp,-48
    80005416:	f406                	sd	ra,40(sp)
    80005418:	f022                	sd	s0,32(sp)
    8000541a:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000541c:	fe840613          	addi	a2,s0,-24
    80005420:	4581                	li	a1,0
    80005422:	4501                	li	a0,0
    80005424:	00000097          	auipc	ra,0x0
    80005428:	d92080e7          	jalr	-622(ra) # 800051b6 <argfd>
    return -1;
    8000542c:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000542e:	04054163          	bltz	a0,80005470 <sys_read+0x5c>
    80005432:	fe440593          	addi	a1,s0,-28
    80005436:	4509                	li	a0,2
    80005438:	ffffe097          	auipc	ra,0xffffe
    8000543c:	8e0080e7          	jalr	-1824(ra) # 80002d18 <argint>
    return -1;
    80005440:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005442:	02054763          	bltz	a0,80005470 <sys_read+0x5c>
    80005446:	fd840593          	addi	a1,s0,-40
    8000544a:	4505                	li	a0,1
    8000544c:	ffffe097          	auipc	ra,0xffffe
    80005450:	8ee080e7          	jalr	-1810(ra) # 80002d3a <argaddr>
    return -1;
    80005454:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005456:	00054d63          	bltz	a0,80005470 <sys_read+0x5c>
  return fileread(f, p, n);
    8000545a:	fe442603          	lw	a2,-28(s0)
    8000545e:	fd843583          	ld	a1,-40(s0)
    80005462:	fe843503          	ld	a0,-24(s0)
    80005466:	fffff097          	auipc	ra,0xfffff
    8000546a:	490080e7          	jalr	1168(ra) # 800048f6 <fileread>
    8000546e:	87aa                	mv	a5,a0
}
    80005470:	853e                	mv	a0,a5
    80005472:	70a2                	ld	ra,40(sp)
    80005474:	7402                	ld	s0,32(sp)
    80005476:	6145                	addi	sp,sp,48
    80005478:	8082                	ret

000000008000547a <sys_write>:
{
    8000547a:	7179                	addi	sp,sp,-48
    8000547c:	f406                	sd	ra,40(sp)
    8000547e:	f022                	sd	s0,32(sp)
    80005480:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005482:	fe840613          	addi	a2,s0,-24
    80005486:	4581                	li	a1,0
    80005488:	4501                	li	a0,0
    8000548a:	00000097          	auipc	ra,0x0
    8000548e:	d2c080e7          	jalr	-724(ra) # 800051b6 <argfd>
    return -1;
    80005492:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005494:	04054163          	bltz	a0,800054d6 <sys_write+0x5c>
    80005498:	fe440593          	addi	a1,s0,-28
    8000549c:	4509                	li	a0,2
    8000549e:	ffffe097          	auipc	ra,0xffffe
    800054a2:	87a080e7          	jalr	-1926(ra) # 80002d18 <argint>
    return -1;
    800054a6:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800054a8:	02054763          	bltz	a0,800054d6 <sys_write+0x5c>
    800054ac:	fd840593          	addi	a1,s0,-40
    800054b0:	4505                	li	a0,1
    800054b2:	ffffe097          	auipc	ra,0xffffe
    800054b6:	888080e7          	jalr	-1912(ra) # 80002d3a <argaddr>
    return -1;
    800054ba:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800054bc:	00054d63          	bltz	a0,800054d6 <sys_write+0x5c>
  return filewrite(f, p, n);
    800054c0:	fe442603          	lw	a2,-28(s0)
    800054c4:	fd843583          	ld	a1,-40(s0)
    800054c8:	fe843503          	ld	a0,-24(s0)
    800054cc:	fffff097          	auipc	ra,0xfffff
    800054d0:	4ec080e7          	jalr	1260(ra) # 800049b8 <filewrite>
    800054d4:	87aa                	mv	a5,a0
}
    800054d6:	853e                	mv	a0,a5
    800054d8:	70a2                	ld	ra,40(sp)
    800054da:	7402                	ld	s0,32(sp)
    800054dc:	6145                	addi	sp,sp,48
    800054de:	8082                	ret

00000000800054e0 <sys_close>:
{
    800054e0:	1101                	addi	sp,sp,-32
    800054e2:	ec06                	sd	ra,24(sp)
    800054e4:	e822                	sd	s0,16(sp)
    800054e6:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800054e8:	fe040613          	addi	a2,s0,-32
    800054ec:	fec40593          	addi	a1,s0,-20
    800054f0:	4501                	li	a0,0
    800054f2:	00000097          	auipc	ra,0x0
    800054f6:	cc4080e7          	jalr	-828(ra) # 800051b6 <argfd>
    return -1;
    800054fa:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800054fc:	02054463          	bltz	a0,80005524 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80005500:	ffffc097          	auipc	ra,0xffffc
    80005504:	496080e7          	jalr	1174(ra) # 80001996 <myproc>
    80005508:	fec42783          	lw	a5,-20(s0)
    8000550c:	07e9                	addi	a5,a5,26
    8000550e:	078e                	slli	a5,a5,0x3
    80005510:	97aa                	add	a5,a5,a0
    80005512:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    80005516:	fe043503          	ld	a0,-32(s0)
    8000551a:	fffff097          	auipc	ra,0xfffff
    8000551e:	2a2080e7          	jalr	674(ra) # 800047bc <fileclose>
  return 0;
    80005522:	4781                	li	a5,0
}
    80005524:	853e                	mv	a0,a5
    80005526:	60e2                	ld	ra,24(sp)
    80005528:	6442                	ld	s0,16(sp)
    8000552a:	6105                	addi	sp,sp,32
    8000552c:	8082                	ret

000000008000552e <sys_fstat>:
{
    8000552e:	1101                	addi	sp,sp,-32
    80005530:	ec06                	sd	ra,24(sp)
    80005532:	e822                	sd	s0,16(sp)
    80005534:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80005536:	fe840613          	addi	a2,s0,-24
    8000553a:	4581                	li	a1,0
    8000553c:	4501                	li	a0,0
    8000553e:	00000097          	auipc	ra,0x0
    80005542:	c78080e7          	jalr	-904(ra) # 800051b6 <argfd>
    return -1;
    80005546:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80005548:	02054563          	bltz	a0,80005572 <sys_fstat+0x44>
    8000554c:	fe040593          	addi	a1,s0,-32
    80005550:	4505                	li	a0,1
    80005552:	ffffd097          	auipc	ra,0xffffd
    80005556:	7e8080e7          	jalr	2024(ra) # 80002d3a <argaddr>
    return -1;
    8000555a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    8000555c:	00054b63          	bltz	a0,80005572 <sys_fstat+0x44>
  return filestat(f, st);
    80005560:	fe043583          	ld	a1,-32(s0)
    80005564:	fe843503          	ld	a0,-24(s0)
    80005568:	fffff097          	auipc	ra,0xfffff
    8000556c:	31c080e7          	jalr	796(ra) # 80004884 <filestat>
    80005570:	87aa                	mv	a5,a0
}
    80005572:	853e                	mv	a0,a5
    80005574:	60e2                	ld	ra,24(sp)
    80005576:	6442                	ld	s0,16(sp)
    80005578:	6105                	addi	sp,sp,32
    8000557a:	8082                	ret

000000008000557c <sys_link>:
{
    8000557c:	7169                	addi	sp,sp,-304
    8000557e:	f606                	sd	ra,296(sp)
    80005580:	f222                	sd	s0,288(sp)
    80005582:	ee26                	sd	s1,280(sp)
    80005584:	ea4a                	sd	s2,272(sp)
    80005586:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80005588:	08000613          	li	a2,128
    8000558c:	ed040593          	addi	a1,s0,-304
    80005590:	4501                	li	a0,0
    80005592:	ffffd097          	auipc	ra,0xffffd
    80005596:	7ca080e7          	jalr	1994(ra) # 80002d5c <argstr>
    return -1;
    8000559a:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000559c:	10054e63          	bltz	a0,800056b8 <sys_link+0x13c>
    800055a0:	08000613          	li	a2,128
    800055a4:	f5040593          	addi	a1,s0,-176
    800055a8:	4505                	li	a0,1
    800055aa:	ffffd097          	auipc	ra,0xffffd
    800055ae:	7b2080e7          	jalr	1970(ra) # 80002d5c <argstr>
    return -1;
    800055b2:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800055b4:	10054263          	bltz	a0,800056b8 <sys_link+0x13c>
  begin_op();
    800055b8:	fffff097          	auipc	ra,0xfffff
    800055bc:	d38080e7          	jalr	-712(ra) # 800042f0 <begin_op>
  if((ip = namei(old)) == 0){
    800055c0:	ed040513          	addi	a0,s0,-304
    800055c4:	fffff097          	auipc	ra,0xfffff
    800055c8:	b10080e7          	jalr	-1264(ra) # 800040d4 <namei>
    800055cc:	84aa                	mv	s1,a0
    800055ce:	c551                	beqz	a0,8000565a <sys_link+0xde>
  ilock(ip);
    800055d0:	ffffe097          	auipc	ra,0xffffe
    800055d4:	34e080e7          	jalr	846(ra) # 8000391e <ilock>
  if(ip->type == T_DIR){
    800055d8:	04449703          	lh	a4,68(s1)
    800055dc:	4785                	li	a5,1
    800055de:	08f70463          	beq	a4,a5,80005666 <sys_link+0xea>
  ip->nlink++;
    800055e2:	04a4d783          	lhu	a5,74(s1)
    800055e6:	2785                	addiw	a5,a5,1
    800055e8:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800055ec:	8526                	mv	a0,s1
    800055ee:	ffffe097          	auipc	ra,0xffffe
    800055f2:	266080e7          	jalr	614(ra) # 80003854 <iupdate>
  iunlock(ip);
    800055f6:	8526                	mv	a0,s1
    800055f8:	ffffe097          	auipc	ra,0xffffe
    800055fc:	3e8080e7          	jalr	1000(ra) # 800039e0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80005600:	fd040593          	addi	a1,s0,-48
    80005604:	f5040513          	addi	a0,s0,-176
    80005608:	fffff097          	auipc	ra,0xfffff
    8000560c:	aea080e7          	jalr	-1302(ra) # 800040f2 <nameiparent>
    80005610:	892a                	mv	s2,a0
    80005612:	c935                	beqz	a0,80005686 <sys_link+0x10a>
  ilock(dp);
    80005614:	ffffe097          	auipc	ra,0xffffe
    80005618:	30a080e7          	jalr	778(ra) # 8000391e <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    8000561c:	00092703          	lw	a4,0(s2)
    80005620:	409c                	lw	a5,0(s1)
    80005622:	04f71d63          	bne	a4,a5,8000567c <sys_link+0x100>
    80005626:	40d0                	lw	a2,4(s1)
    80005628:	fd040593          	addi	a1,s0,-48
    8000562c:	854a                	mv	a0,s2
    8000562e:	fffff097          	auipc	ra,0xfffff
    80005632:	9e4080e7          	jalr	-1564(ra) # 80004012 <dirlink>
    80005636:	04054363          	bltz	a0,8000567c <sys_link+0x100>
  iunlockput(dp);
    8000563a:	854a                	mv	a0,s2
    8000563c:	ffffe097          	auipc	ra,0xffffe
    80005640:	544080e7          	jalr	1348(ra) # 80003b80 <iunlockput>
  iput(ip);
    80005644:	8526                	mv	a0,s1
    80005646:	ffffe097          	auipc	ra,0xffffe
    8000564a:	492080e7          	jalr	1170(ra) # 80003ad8 <iput>
  end_op();
    8000564e:	fffff097          	auipc	ra,0xfffff
    80005652:	d22080e7          	jalr	-734(ra) # 80004370 <end_op>
  return 0;
    80005656:	4781                	li	a5,0
    80005658:	a085                	j	800056b8 <sys_link+0x13c>
    end_op();
    8000565a:	fffff097          	auipc	ra,0xfffff
    8000565e:	d16080e7          	jalr	-746(ra) # 80004370 <end_op>
    return -1;
    80005662:	57fd                	li	a5,-1
    80005664:	a891                	j	800056b8 <sys_link+0x13c>
    iunlockput(ip);
    80005666:	8526                	mv	a0,s1
    80005668:	ffffe097          	auipc	ra,0xffffe
    8000566c:	518080e7          	jalr	1304(ra) # 80003b80 <iunlockput>
    end_op();
    80005670:	fffff097          	auipc	ra,0xfffff
    80005674:	d00080e7          	jalr	-768(ra) # 80004370 <end_op>
    return -1;
    80005678:	57fd                	li	a5,-1
    8000567a:	a83d                	j	800056b8 <sys_link+0x13c>
    iunlockput(dp);
    8000567c:	854a                	mv	a0,s2
    8000567e:	ffffe097          	auipc	ra,0xffffe
    80005682:	502080e7          	jalr	1282(ra) # 80003b80 <iunlockput>
  ilock(ip);
    80005686:	8526                	mv	a0,s1
    80005688:	ffffe097          	auipc	ra,0xffffe
    8000568c:	296080e7          	jalr	662(ra) # 8000391e <ilock>
  ip->nlink--;
    80005690:	04a4d783          	lhu	a5,74(s1)
    80005694:	37fd                	addiw	a5,a5,-1
    80005696:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    8000569a:	8526                	mv	a0,s1
    8000569c:	ffffe097          	auipc	ra,0xffffe
    800056a0:	1b8080e7          	jalr	440(ra) # 80003854 <iupdate>
  iunlockput(ip);
    800056a4:	8526                	mv	a0,s1
    800056a6:	ffffe097          	auipc	ra,0xffffe
    800056aa:	4da080e7          	jalr	1242(ra) # 80003b80 <iunlockput>
  end_op();
    800056ae:	fffff097          	auipc	ra,0xfffff
    800056b2:	cc2080e7          	jalr	-830(ra) # 80004370 <end_op>
  return -1;
    800056b6:	57fd                	li	a5,-1
}
    800056b8:	853e                	mv	a0,a5
    800056ba:	70b2                	ld	ra,296(sp)
    800056bc:	7412                	ld	s0,288(sp)
    800056be:	64f2                	ld	s1,280(sp)
    800056c0:	6952                	ld	s2,272(sp)
    800056c2:	6155                	addi	sp,sp,304
    800056c4:	8082                	ret

00000000800056c6 <sys_unlink>:
{
    800056c6:	7151                	addi	sp,sp,-240
    800056c8:	f586                	sd	ra,232(sp)
    800056ca:	f1a2                	sd	s0,224(sp)
    800056cc:	eda6                	sd	s1,216(sp)
    800056ce:	e9ca                	sd	s2,208(sp)
    800056d0:	e5ce                	sd	s3,200(sp)
    800056d2:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    800056d4:	08000613          	li	a2,128
    800056d8:	f3040593          	addi	a1,s0,-208
    800056dc:	4501                	li	a0,0
    800056de:	ffffd097          	auipc	ra,0xffffd
    800056e2:	67e080e7          	jalr	1662(ra) # 80002d5c <argstr>
    800056e6:	18054163          	bltz	a0,80005868 <sys_unlink+0x1a2>
  begin_op();
    800056ea:	fffff097          	auipc	ra,0xfffff
    800056ee:	c06080e7          	jalr	-1018(ra) # 800042f0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800056f2:	fb040593          	addi	a1,s0,-80
    800056f6:	f3040513          	addi	a0,s0,-208
    800056fa:	fffff097          	auipc	ra,0xfffff
    800056fe:	9f8080e7          	jalr	-1544(ra) # 800040f2 <nameiparent>
    80005702:	84aa                	mv	s1,a0
    80005704:	c979                	beqz	a0,800057da <sys_unlink+0x114>
  ilock(dp);
    80005706:	ffffe097          	auipc	ra,0xffffe
    8000570a:	218080e7          	jalr	536(ra) # 8000391e <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    8000570e:	00003597          	auipc	a1,0x3
    80005712:	04258593          	addi	a1,a1,66 # 80008750 <syscalls+0x2c0>
    80005716:	fb040513          	addi	a0,s0,-80
    8000571a:	ffffe097          	auipc	ra,0xffffe
    8000571e:	6ce080e7          	jalr	1742(ra) # 80003de8 <namecmp>
    80005722:	14050a63          	beqz	a0,80005876 <sys_unlink+0x1b0>
    80005726:	00003597          	auipc	a1,0x3
    8000572a:	03258593          	addi	a1,a1,50 # 80008758 <syscalls+0x2c8>
    8000572e:	fb040513          	addi	a0,s0,-80
    80005732:	ffffe097          	auipc	ra,0xffffe
    80005736:	6b6080e7          	jalr	1718(ra) # 80003de8 <namecmp>
    8000573a:	12050e63          	beqz	a0,80005876 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    8000573e:	f2c40613          	addi	a2,s0,-212
    80005742:	fb040593          	addi	a1,s0,-80
    80005746:	8526                	mv	a0,s1
    80005748:	ffffe097          	auipc	ra,0xffffe
    8000574c:	6ba080e7          	jalr	1722(ra) # 80003e02 <dirlookup>
    80005750:	892a                	mv	s2,a0
    80005752:	12050263          	beqz	a0,80005876 <sys_unlink+0x1b0>
  ilock(ip);
    80005756:	ffffe097          	auipc	ra,0xffffe
    8000575a:	1c8080e7          	jalr	456(ra) # 8000391e <ilock>
  if(ip->nlink < 1)
    8000575e:	04a91783          	lh	a5,74(s2)
    80005762:	08f05263          	blez	a5,800057e6 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80005766:	04491703          	lh	a4,68(s2)
    8000576a:	4785                	li	a5,1
    8000576c:	08f70563          	beq	a4,a5,800057f6 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80005770:	4641                	li	a2,16
    80005772:	4581                	li	a1,0
    80005774:	fc040513          	addi	a0,s0,-64
    80005778:	ffffb097          	auipc	ra,0xffffb
    8000577c:	554080e7          	jalr	1364(ra) # 80000ccc <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005780:	4741                	li	a4,16
    80005782:	f2c42683          	lw	a3,-212(s0)
    80005786:	fc040613          	addi	a2,s0,-64
    8000578a:	4581                	li	a1,0
    8000578c:	8526                	mv	a0,s1
    8000578e:	ffffe097          	auipc	ra,0xffffe
    80005792:	53c080e7          	jalr	1340(ra) # 80003cca <writei>
    80005796:	47c1                	li	a5,16
    80005798:	0af51563          	bne	a0,a5,80005842 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    8000579c:	04491703          	lh	a4,68(s2)
    800057a0:	4785                	li	a5,1
    800057a2:	0af70863          	beq	a4,a5,80005852 <sys_unlink+0x18c>
  iunlockput(dp);
    800057a6:	8526                	mv	a0,s1
    800057a8:	ffffe097          	auipc	ra,0xffffe
    800057ac:	3d8080e7          	jalr	984(ra) # 80003b80 <iunlockput>
  ip->nlink--;
    800057b0:	04a95783          	lhu	a5,74(s2)
    800057b4:	37fd                	addiw	a5,a5,-1
    800057b6:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    800057ba:	854a                	mv	a0,s2
    800057bc:	ffffe097          	auipc	ra,0xffffe
    800057c0:	098080e7          	jalr	152(ra) # 80003854 <iupdate>
  iunlockput(ip);
    800057c4:	854a                	mv	a0,s2
    800057c6:	ffffe097          	auipc	ra,0xffffe
    800057ca:	3ba080e7          	jalr	954(ra) # 80003b80 <iunlockput>
  end_op();
    800057ce:	fffff097          	auipc	ra,0xfffff
    800057d2:	ba2080e7          	jalr	-1118(ra) # 80004370 <end_op>
  return 0;
    800057d6:	4501                	li	a0,0
    800057d8:	a84d                	j	8000588a <sys_unlink+0x1c4>
    end_op();
    800057da:	fffff097          	auipc	ra,0xfffff
    800057de:	b96080e7          	jalr	-1130(ra) # 80004370 <end_op>
    return -1;
    800057e2:	557d                	li	a0,-1
    800057e4:	a05d                	j	8000588a <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    800057e6:	00003517          	auipc	a0,0x3
    800057ea:	f9a50513          	addi	a0,a0,-102 # 80008780 <syscalls+0x2f0>
    800057ee:	ffffb097          	auipc	ra,0xffffb
    800057f2:	d4a080e7          	jalr	-694(ra) # 80000538 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800057f6:	04c92703          	lw	a4,76(s2)
    800057fa:	02000793          	li	a5,32
    800057fe:	f6e7f9e3          	bgeu	a5,a4,80005770 <sys_unlink+0xaa>
    80005802:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005806:	4741                	li	a4,16
    80005808:	86ce                	mv	a3,s3
    8000580a:	f1840613          	addi	a2,s0,-232
    8000580e:	4581                	li	a1,0
    80005810:	854a                	mv	a0,s2
    80005812:	ffffe097          	auipc	ra,0xffffe
    80005816:	3c0080e7          	jalr	960(ra) # 80003bd2 <readi>
    8000581a:	47c1                	li	a5,16
    8000581c:	00f51b63          	bne	a0,a5,80005832 <sys_unlink+0x16c>
    if(de.inum != 0)
    80005820:	f1845783          	lhu	a5,-232(s0)
    80005824:	e7a1                	bnez	a5,8000586c <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005826:	29c1                	addiw	s3,s3,16
    80005828:	04c92783          	lw	a5,76(s2)
    8000582c:	fcf9ede3          	bltu	s3,a5,80005806 <sys_unlink+0x140>
    80005830:	b781                	j	80005770 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80005832:	00003517          	auipc	a0,0x3
    80005836:	f6650513          	addi	a0,a0,-154 # 80008798 <syscalls+0x308>
    8000583a:	ffffb097          	auipc	ra,0xffffb
    8000583e:	cfe080e7          	jalr	-770(ra) # 80000538 <panic>
    panic("unlink: writei");
    80005842:	00003517          	auipc	a0,0x3
    80005846:	f6e50513          	addi	a0,a0,-146 # 800087b0 <syscalls+0x320>
    8000584a:	ffffb097          	auipc	ra,0xffffb
    8000584e:	cee080e7          	jalr	-786(ra) # 80000538 <panic>
    dp->nlink--;
    80005852:	04a4d783          	lhu	a5,74(s1)
    80005856:	37fd                	addiw	a5,a5,-1
    80005858:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    8000585c:	8526                	mv	a0,s1
    8000585e:	ffffe097          	auipc	ra,0xffffe
    80005862:	ff6080e7          	jalr	-10(ra) # 80003854 <iupdate>
    80005866:	b781                	j	800057a6 <sys_unlink+0xe0>
    return -1;
    80005868:	557d                	li	a0,-1
    8000586a:	a005                	j	8000588a <sys_unlink+0x1c4>
    iunlockput(ip);
    8000586c:	854a                	mv	a0,s2
    8000586e:	ffffe097          	auipc	ra,0xffffe
    80005872:	312080e7          	jalr	786(ra) # 80003b80 <iunlockput>
  iunlockput(dp);
    80005876:	8526                	mv	a0,s1
    80005878:	ffffe097          	auipc	ra,0xffffe
    8000587c:	308080e7          	jalr	776(ra) # 80003b80 <iunlockput>
  end_op();
    80005880:	fffff097          	auipc	ra,0xfffff
    80005884:	af0080e7          	jalr	-1296(ra) # 80004370 <end_op>
  return -1;
    80005888:	557d                	li	a0,-1
}
    8000588a:	70ae                	ld	ra,232(sp)
    8000588c:	740e                	ld	s0,224(sp)
    8000588e:	64ee                	ld	s1,216(sp)
    80005890:	694e                	ld	s2,208(sp)
    80005892:	69ae                	ld	s3,200(sp)
    80005894:	616d                	addi	sp,sp,240
    80005896:	8082                	ret

0000000080005898 <sys_open>:

uint64
sys_open(void)
{
    80005898:	7131                	addi	sp,sp,-192
    8000589a:	fd06                	sd	ra,184(sp)
    8000589c:	f922                	sd	s0,176(sp)
    8000589e:	f526                	sd	s1,168(sp)
    800058a0:	f14a                	sd	s2,160(sp)
    800058a2:	ed4e                	sd	s3,152(sp)
    800058a4:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800058a6:	08000613          	li	a2,128
    800058aa:	f5040593          	addi	a1,s0,-176
    800058ae:	4501                	li	a0,0
    800058b0:	ffffd097          	auipc	ra,0xffffd
    800058b4:	4ac080e7          	jalr	1196(ra) # 80002d5c <argstr>
    return -1;
    800058b8:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800058ba:	0c054163          	bltz	a0,8000597c <sys_open+0xe4>
    800058be:	f4c40593          	addi	a1,s0,-180
    800058c2:	4505                	li	a0,1
    800058c4:	ffffd097          	auipc	ra,0xffffd
    800058c8:	454080e7          	jalr	1108(ra) # 80002d18 <argint>
    800058cc:	0a054863          	bltz	a0,8000597c <sys_open+0xe4>

  begin_op();
    800058d0:	fffff097          	auipc	ra,0xfffff
    800058d4:	a20080e7          	jalr	-1504(ra) # 800042f0 <begin_op>

  if(omode & O_CREATE){
    800058d8:	f4c42783          	lw	a5,-180(s0)
    800058dc:	2007f793          	andi	a5,a5,512
    800058e0:	cbdd                	beqz	a5,80005996 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    800058e2:	4681                	li	a3,0
    800058e4:	4601                	li	a2,0
    800058e6:	4589                	li	a1,2
    800058e8:	f5040513          	addi	a0,s0,-176
    800058ec:	00000097          	auipc	ra,0x0
    800058f0:	974080e7          	jalr	-1676(ra) # 80005260 <create>
    800058f4:	892a                	mv	s2,a0
    if(ip == 0){
    800058f6:	c959                	beqz	a0,8000598c <sys_open+0xf4>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    800058f8:	04491703          	lh	a4,68(s2)
    800058fc:	478d                	li	a5,3
    800058fe:	00f71763          	bne	a4,a5,8000590c <sys_open+0x74>
    80005902:	04695703          	lhu	a4,70(s2)
    80005906:	47a5                	li	a5,9
    80005908:	0ce7ec63          	bltu	a5,a4,800059e0 <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    8000590c:	fffff097          	auipc	ra,0xfffff
    80005910:	df4080e7          	jalr	-524(ra) # 80004700 <filealloc>
    80005914:	89aa                	mv	s3,a0
    80005916:	10050263          	beqz	a0,80005a1a <sys_open+0x182>
    8000591a:	00000097          	auipc	ra,0x0
    8000591e:	904080e7          	jalr	-1788(ra) # 8000521e <fdalloc>
    80005922:	84aa                	mv	s1,a0
    80005924:	0e054663          	bltz	a0,80005a10 <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80005928:	04491703          	lh	a4,68(s2)
    8000592c:	478d                	li	a5,3
    8000592e:	0cf70463          	beq	a4,a5,800059f6 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80005932:	4789                	li	a5,2
    80005934:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80005938:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    8000593c:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    80005940:	f4c42783          	lw	a5,-180(s0)
    80005944:	0017c713          	xori	a4,a5,1
    80005948:	8b05                	andi	a4,a4,1
    8000594a:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000594e:	0037f713          	andi	a4,a5,3
    80005952:	00e03733          	snez	a4,a4
    80005956:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    8000595a:	4007f793          	andi	a5,a5,1024
    8000595e:	c791                	beqz	a5,8000596a <sys_open+0xd2>
    80005960:	04491703          	lh	a4,68(s2)
    80005964:	4789                	li	a5,2
    80005966:	08f70f63          	beq	a4,a5,80005a04 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    8000596a:	854a                	mv	a0,s2
    8000596c:	ffffe097          	auipc	ra,0xffffe
    80005970:	074080e7          	jalr	116(ra) # 800039e0 <iunlock>
  end_op();
    80005974:	fffff097          	auipc	ra,0xfffff
    80005978:	9fc080e7          	jalr	-1540(ra) # 80004370 <end_op>

  return fd;
}
    8000597c:	8526                	mv	a0,s1
    8000597e:	70ea                	ld	ra,184(sp)
    80005980:	744a                	ld	s0,176(sp)
    80005982:	74aa                	ld	s1,168(sp)
    80005984:	790a                	ld	s2,160(sp)
    80005986:	69ea                	ld	s3,152(sp)
    80005988:	6129                	addi	sp,sp,192
    8000598a:	8082                	ret
      end_op();
    8000598c:	fffff097          	auipc	ra,0xfffff
    80005990:	9e4080e7          	jalr	-1564(ra) # 80004370 <end_op>
      return -1;
    80005994:	b7e5                	j	8000597c <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80005996:	f5040513          	addi	a0,s0,-176
    8000599a:	ffffe097          	auipc	ra,0xffffe
    8000599e:	73a080e7          	jalr	1850(ra) # 800040d4 <namei>
    800059a2:	892a                	mv	s2,a0
    800059a4:	c905                	beqz	a0,800059d4 <sys_open+0x13c>
    ilock(ip);
    800059a6:	ffffe097          	auipc	ra,0xffffe
    800059aa:	f78080e7          	jalr	-136(ra) # 8000391e <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    800059ae:	04491703          	lh	a4,68(s2)
    800059b2:	4785                	li	a5,1
    800059b4:	f4f712e3          	bne	a4,a5,800058f8 <sys_open+0x60>
    800059b8:	f4c42783          	lw	a5,-180(s0)
    800059bc:	dba1                	beqz	a5,8000590c <sys_open+0x74>
      iunlockput(ip);
    800059be:	854a                	mv	a0,s2
    800059c0:	ffffe097          	auipc	ra,0xffffe
    800059c4:	1c0080e7          	jalr	448(ra) # 80003b80 <iunlockput>
      end_op();
    800059c8:	fffff097          	auipc	ra,0xfffff
    800059cc:	9a8080e7          	jalr	-1624(ra) # 80004370 <end_op>
      return -1;
    800059d0:	54fd                	li	s1,-1
    800059d2:	b76d                	j	8000597c <sys_open+0xe4>
      end_op();
    800059d4:	fffff097          	auipc	ra,0xfffff
    800059d8:	99c080e7          	jalr	-1636(ra) # 80004370 <end_op>
      return -1;
    800059dc:	54fd                	li	s1,-1
    800059de:	bf79                	j	8000597c <sys_open+0xe4>
    iunlockput(ip);
    800059e0:	854a                	mv	a0,s2
    800059e2:	ffffe097          	auipc	ra,0xffffe
    800059e6:	19e080e7          	jalr	414(ra) # 80003b80 <iunlockput>
    end_op();
    800059ea:	fffff097          	auipc	ra,0xfffff
    800059ee:	986080e7          	jalr	-1658(ra) # 80004370 <end_op>
    return -1;
    800059f2:	54fd                	li	s1,-1
    800059f4:	b761                	j	8000597c <sys_open+0xe4>
    f->type = FD_DEVICE;
    800059f6:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    800059fa:	04691783          	lh	a5,70(s2)
    800059fe:	02f99223          	sh	a5,36(s3)
    80005a02:	bf2d                	j	8000593c <sys_open+0xa4>
    itrunc(ip);
    80005a04:	854a                	mv	a0,s2
    80005a06:	ffffe097          	auipc	ra,0xffffe
    80005a0a:	026080e7          	jalr	38(ra) # 80003a2c <itrunc>
    80005a0e:	bfb1                	j	8000596a <sys_open+0xd2>
      fileclose(f);
    80005a10:	854e                	mv	a0,s3
    80005a12:	fffff097          	auipc	ra,0xfffff
    80005a16:	daa080e7          	jalr	-598(ra) # 800047bc <fileclose>
    iunlockput(ip);
    80005a1a:	854a                	mv	a0,s2
    80005a1c:	ffffe097          	auipc	ra,0xffffe
    80005a20:	164080e7          	jalr	356(ra) # 80003b80 <iunlockput>
    end_op();
    80005a24:	fffff097          	auipc	ra,0xfffff
    80005a28:	94c080e7          	jalr	-1716(ra) # 80004370 <end_op>
    return -1;
    80005a2c:	54fd                	li	s1,-1
    80005a2e:	b7b9                	j	8000597c <sys_open+0xe4>

0000000080005a30 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80005a30:	7175                	addi	sp,sp,-144
    80005a32:	e506                	sd	ra,136(sp)
    80005a34:	e122                	sd	s0,128(sp)
    80005a36:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80005a38:	fffff097          	auipc	ra,0xfffff
    80005a3c:	8b8080e7          	jalr	-1864(ra) # 800042f0 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80005a40:	08000613          	li	a2,128
    80005a44:	f7040593          	addi	a1,s0,-144
    80005a48:	4501                	li	a0,0
    80005a4a:	ffffd097          	auipc	ra,0xffffd
    80005a4e:	312080e7          	jalr	786(ra) # 80002d5c <argstr>
    80005a52:	02054963          	bltz	a0,80005a84 <sys_mkdir+0x54>
    80005a56:	4681                	li	a3,0
    80005a58:	4601                	li	a2,0
    80005a5a:	4585                	li	a1,1
    80005a5c:	f7040513          	addi	a0,s0,-144
    80005a60:	00000097          	auipc	ra,0x0
    80005a64:	800080e7          	jalr	-2048(ra) # 80005260 <create>
    80005a68:	cd11                	beqz	a0,80005a84 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005a6a:	ffffe097          	auipc	ra,0xffffe
    80005a6e:	116080e7          	jalr	278(ra) # 80003b80 <iunlockput>
  end_op();
    80005a72:	fffff097          	auipc	ra,0xfffff
    80005a76:	8fe080e7          	jalr	-1794(ra) # 80004370 <end_op>
  return 0;
    80005a7a:	4501                	li	a0,0
}
    80005a7c:	60aa                	ld	ra,136(sp)
    80005a7e:	640a                	ld	s0,128(sp)
    80005a80:	6149                	addi	sp,sp,144
    80005a82:	8082                	ret
    end_op();
    80005a84:	fffff097          	auipc	ra,0xfffff
    80005a88:	8ec080e7          	jalr	-1812(ra) # 80004370 <end_op>
    return -1;
    80005a8c:	557d                	li	a0,-1
    80005a8e:	b7fd                	j	80005a7c <sys_mkdir+0x4c>

0000000080005a90 <sys_mknod>:

uint64
sys_mknod(void)
{
    80005a90:	7135                	addi	sp,sp,-160
    80005a92:	ed06                	sd	ra,152(sp)
    80005a94:	e922                	sd	s0,144(sp)
    80005a96:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80005a98:	fffff097          	auipc	ra,0xfffff
    80005a9c:	858080e7          	jalr	-1960(ra) # 800042f0 <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005aa0:	08000613          	li	a2,128
    80005aa4:	f7040593          	addi	a1,s0,-144
    80005aa8:	4501                	li	a0,0
    80005aaa:	ffffd097          	auipc	ra,0xffffd
    80005aae:	2b2080e7          	jalr	690(ra) # 80002d5c <argstr>
    80005ab2:	04054a63          	bltz	a0,80005b06 <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80005ab6:	f6c40593          	addi	a1,s0,-148
    80005aba:	4505                	li	a0,1
    80005abc:	ffffd097          	auipc	ra,0xffffd
    80005ac0:	25c080e7          	jalr	604(ra) # 80002d18 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005ac4:	04054163          	bltz	a0,80005b06 <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80005ac8:	f6840593          	addi	a1,s0,-152
    80005acc:	4509                	li	a0,2
    80005ace:	ffffd097          	auipc	ra,0xffffd
    80005ad2:	24a080e7          	jalr	586(ra) # 80002d18 <argint>
     argint(1, &major) < 0 ||
    80005ad6:	02054863          	bltz	a0,80005b06 <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80005ada:	f6841683          	lh	a3,-152(s0)
    80005ade:	f6c41603          	lh	a2,-148(s0)
    80005ae2:	458d                	li	a1,3
    80005ae4:	f7040513          	addi	a0,s0,-144
    80005ae8:	fffff097          	auipc	ra,0xfffff
    80005aec:	778080e7          	jalr	1912(ra) # 80005260 <create>
     argint(2, &minor) < 0 ||
    80005af0:	c919                	beqz	a0,80005b06 <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005af2:	ffffe097          	auipc	ra,0xffffe
    80005af6:	08e080e7          	jalr	142(ra) # 80003b80 <iunlockput>
  end_op();
    80005afa:	fffff097          	auipc	ra,0xfffff
    80005afe:	876080e7          	jalr	-1930(ra) # 80004370 <end_op>
  return 0;
    80005b02:	4501                	li	a0,0
    80005b04:	a031                	j	80005b10 <sys_mknod+0x80>
    end_op();
    80005b06:	fffff097          	auipc	ra,0xfffff
    80005b0a:	86a080e7          	jalr	-1942(ra) # 80004370 <end_op>
    return -1;
    80005b0e:	557d                	li	a0,-1
}
    80005b10:	60ea                	ld	ra,152(sp)
    80005b12:	644a                	ld	s0,144(sp)
    80005b14:	610d                	addi	sp,sp,160
    80005b16:	8082                	ret

0000000080005b18 <sys_chdir>:

uint64
sys_chdir(void)
{
    80005b18:	7135                	addi	sp,sp,-160
    80005b1a:	ed06                	sd	ra,152(sp)
    80005b1c:	e922                	sd	s0,144(sp)
    80005b1e:	e526                	sd	s1,136(sp)
    80005b20:	e14a                	sd	s2,128(sp)
    80005b22:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80005b24:	ffffc097          	auipc	ra,0xffffc
    80005b28:	e72080e7          	jalr	-398(ra) # 80001996 <myproc>
    80005b2c:	892a                	mv	s2,a0
  
  begin_op();
    80005b2e:	ffffe097          	auipc	ra,0xffffe
    80005b32:	7c2080e7          	jalr	1986(ra) # 800042f0 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80005b36:	08000613          	li	a2,128
    80005b3a:	f6040593          	addi	a1,s0,-160
    80005b3e:	4501                	li	a0,0
    80005b40:	ffffd097          	auipc	ra,0xffffd
    80005b44:	21c080e7          	jalr	540(ra) # 80002d5c <argstr>
    80005b48:	04054b63          	bltz	a0,80005b9e <sys_chdir+0x86>
    80005b4c:	f6040513          	addi	a0,s0,-160
    80005b50:	ffffe097          	auipc	ra,0xffffe
    80005b54:	584080e7          	jalr	1412(ra) # 800040d4 <namei>
    80005b58:	84aa                	mv	s1,a0
    80005b5a:	c131                	beqz	a0,80005b9e <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80005b5c:	ffffe097          	auipc	ra,0xffffe
    80005b60:	dc2080e7          	jalr	-574(ra) # 8000391e <ilock>
  if(ip->type != T_DIR){
    80005b64:	04449703          	lh	a4,68(s1)
    80005b68:	4785                	li	a5,1
    80005b6a:	04f71063          	bne	a4,a5,80005baa <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80005b6e:	8526                	mv	a0,s1
    80005b70:	ffffe097          	auipc	ra,0xffffe
    80005b74:	e70080e7          	jalr	-400(ra) # 800039e0 <iunlock>
  iput(p->cwd);
    80005b78:	15093503          	ld	a0,336(s2)
    80005b7c:	ffffe097          	auipc	ra,0xffffe
    80005b80:	f5c080e7          	jalr	-164(ra) # 80003ad8 <iput>
  end_op();
    80005b84:	ffffe097          	auipc	ra,0xffffe
    80005b88:	7ec080e7          	jalr	2028(ra) # 80004370 <end_op>
  p->cwd = ip;
    80005b8c:	14993823          	sd	s1,336(s2)
  return 0;
    80005b90:	4501                	li	a0,0
}
    80005b92:	60ea                	ld	ra,152(sp)
    80005b94:	644a                	ld	s0,144(sp)
    80005b96:	64aa                	ld	s1,136(sp)
    80005b98:	690a                	ld	s2,128(sp)
    80005b9a:	610d                	addi	sp,sp,160
    80005b9c:	8082                	ret
    end_op();
    80005b9e:	ffffe097          	auipc	ra,0xffffe
    80005ba2:	7d2080e7          	jalr	2002(ra) # 80004370 <end_op>
    return -1;
    80005ba6:	557d                	li	a0,-1
    80005ba8:	b7ed                	j	80005b92 <sys_chdir+0x7a>
    iunlockput(ip);
    80005baa:	8526                	mv	a0,s1
    80005bac:	ffffe097          	auipc	ra,0xffffe
    80005bb0:	fd4080e7          	jalr	-44(ra) # 80003b80 <iunlockput>
    end_op();
    80005bb4:	ffffe097          	auipc	ra,0xffffe
    80005bb8:	7bc080e7          	jalr	1980(ra) # 80004370 <end_op>
    return -1;
    80005bbc:	557d                	li	a0,-1
    80005bbe:	bfd1                	j	80005b92 <sys_chdir+0x7a>

0000000080005bc0 <sys_exec>:

uint64
sys_exec(void)
{
    80005bc0:	7145                	addi	sp,sp,-464
    80005bc2:	e786                	sd	ra,456(sp)
    80005bc4:	e3a2                	sd	s0,448(sp)
    80005bc6:	ff26                	sd	s1,440(sp)
    80005bc8:	fb4a                	sd	s2,432(sp)
    80005bca:	f74e                	sd	s3,424(sp)
    80005bcc:	f352                	sd	s4,416(sp)
    80005bce:	ef56                	sd	s5,408(sp)
    80005bd0:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80005bd2:	08000613          	li	a2,128
    80005bd6:	f4040593          	addi	a1,s0,-192
    80005bda:	4501                	li	a0,0
    80005bdc:	ffffd097          	auipc	ra,0xffffd
    80005be0:	180080e7          	jalr	384(ra) # 80002d5c <argstr>
    return -1;
    80005be4:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80005be6:	0c054a63          	bltz	a0,80005cba <sys_exec+0xfa>
    80005bea:	e3840593          	addi	a1,s0,-456
    80005bee:	4505                	li	a0,1
    80005bf0:	ffffd097          	auipc	ra,0xffffd
    80005bf4:	14a080e7          	jalr	330(ra) # 80002d3a <argaddr>
    80005bf8:	0c054163          	bltz	a0,80005cba <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    80005bfc:	10000613          	li	a2,256
    80005c00:	4581                	li	a1,0
    80005c02:	e4040513          	addi	a0,s0,-448
    80005c06:	ffffb097          	auipc	ra,0xffffb
    80005c0a:	0c6080e7          	jalr	198(ra) # 80000ccc <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80005c0e:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    80005c12:	89a6                	mv	s3,s1
    80005c14:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80005c16:	02000a13          	li	s4,32
    80005c1a:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005c1e:	00391793          	slli	a5,s2,0x3
    80005c22:	e3040593          	addi	a1,s0,-464
    80005c26:	e3843503          	ld	a0,-456(s0)
    80005c2a:	953e                	add	a0,a0,a5
    80005c2c:	ffffd097          	auipc	ra,0xffffd
    80005c30:	052080e7          	jalr	82(ra) # 80002c7e <fetchaddr>
    80005c34:	02054a63          	bltz	a0,80005c68 <sys_exec+0xa8>
      goto bad;
    }
    if(uarg == 0){
    80005c38:	e3043783          	ld	a5,-464(s0)
    80005c3c:	c3b9                	beqz	a5,80005c82 <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80005c3e:	ffffb097          	auipc	ra,0xffffb
    80005c42:	ea2080e7          	jalr	-350(ra) # 80000ae0 <kalloc>
    80005c46:	85aa                	mv	a1,a0
    80005c48:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005c4c:	cd11                	beqz	a0,80005c68 <sys_exec+0xa8>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005c4e:	6605                	lui	a2,0x1
    80005c50:	e3043503          	ld	a0,-464(s0)
    80005c54:	ffffd097          	auipc	ra,0xffffd
    80005c58:	07c080e7          	jalr	124(ra) # 80002cd0 <fetchstr>
    80005c5c:	00054663          	bltz	a0,80005c68 <sys_exec+0xa8>
    if(i >= NELEM(argv)){
    80005c60:	0905                	addi	s2,s2,1
    80005c62:	09a1                	addi	s3,s3,8
    80005c64:	fb491be3          	bne	s2,s4,80005c1a <sys_exec+0x5a>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005c68:	10048913          	addi	s2,s1,256
    80005c6c:	6088                	ld	a0,0(s1)
    80005c6e:	c529                	beqz	a0,80005cb8 <sys_exec+0xf8>
    kfree(argv[i]);
    80005c70:	ffffb097          	auipc	ra,0xffffb
    80005c74:	d74080e7          	jalr	-652(ra) # 800009e4 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005c78:	04a1                	addi	s1,s1,8
    80005c7a:	ff2499e3          	bne	s1,s2,80005c6c <sys_exec+0xac>
  return -1;
    80005c7e:	597d                	li	s2,-1
    80005c80:	a82d                	j	80005cba <sys_exec+0xfa>
      argv[i] = 0;
    80005c82:	0a8e                	slli	s5,s5,0x3
    80005c84:	fc040793          	addi	a5,s0,-64
    80005c88:	9abe                	add	s5,s5,a5
    80005c8a:	e80ab023          	sd	zero,-384(s5) # ffffffffffffee80 <end+0xffffffff7ffd8e80>
  int ret = exec(path, argv);
    80005c8e:	e4040593          	addi	a1,s0,-448
    80005c92:	f4040513          	addi	a0,s0,-192
    80005c96:	fffff097          	auipc	ra,0xfffff
    80005c9a:	178080e7          	jalr	376(ra) # 80004e0e <exec>
    80005c9e:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005ca0:	10048993          	addi	s3,s1,256
    80005ca4:	6088                	ld	a0,0(s1)
    80005ca6:	c911                	beqz	a0,80005cba <sys_exec+0xfa>
    kfree(argv[i]);
    80005ca8:	ffffb097          	auipc	ra,0xffffb
    80005cac:	d3c080e7          	jalr	-708(ra) # 800009e4 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005cb0:	04a1                	addi	s1,s1,8
    80005cb2:	ff3499e3          	bne	s1,s3,80005ca4 <sys_exec+0xe4>
    80005cb6:	a011                	j	80005cba <sys_exec+0xfa>
  return -1;
    80005cb8:	597d                	li	s2,-1
}
    80005cba:	854a                	mv	a0,s2
    80005cbc:	60be                	ld	ra,456(sp)
    80005cbe:	641e                	ld	s0,448(sp)
    80005cc0:	74fa                	ld	s1,440(sp)
    80005cc2:	795a                	ld	s2,432(sp)
    80005cc4:	79ba                	ld	s3,424(sp)
    80005cc6:	7a1a                	ld	s4,416(sp)
    80005cc8:	6afa                	ld	s5,408(sp)
    80005cca:	6179                	addi	sp,sp,464
    80005ccc:	8082                	ret

0000000080005cce <sys_pipe>:

uint64
sys_pipe(void)
{
    80005cce:	7139                	addi	sp,sp,-64
    80005cd0:	fc06                	sd	ra,56(sp)
    80005cd2:	f822                	sd	s0,48(sp)
    80005cd4:	f426                	sd	s1,40(sp)
    80005cd6:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005cd8:	ffffc097          	auipc	ra,0xffffc
    80005cdc:	cbe080e7          	jalr	-834(ra) # 80001996 <myproc>
    80005ce0:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    80005ce2:	fd840593          	addi	a1,s0,-40
    80005ce6:	4501                	li	a0,0
    80005ce8:	ffffd097          	auipc	ra,0xffffd
    80005cec:	052080e7          	jalr	82(ra) # 80002d3a <argaddr>
    return -1;
    80005cf0:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    80005cf2:	0e054063          	bltz	a0,80005dd2 <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    80005cf6:	fc840593          	addi	a1,s0,-56
    80005cfa:	fd040513          	addi	a0,s0,-48
    80005cfe:	fffff097          	auipc	ra,0xfffff
    80005d02:	dee080e7          	jalr	-530(ra) # 80004aec <pipealloc>
    return -1;
    80005d06:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005d08:	0c054563          	bltz	a0,80005dd2 <sys_pipe+0x104>
  fd0 = -1;
    80005d0c:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005d10:	fd043503          	ld	a0,-48(s0)
    80005d14:	fffff097          	auipc	ra,0xfffff
    80005d18:	50a080e7          	jalr	1290(ra) # 8000521e <fdalloc>
    80005d1c:	fca42223          	sw	a0,-60(s0)
    80005d20:	08054c63          	bltz	a0,80005db8 <sys_pipe+0xea>
    80005d24:	fc843503          	ld	a0,-56(s0)
    80005d28:	fffff097          	auipc	ra,0xfffff
    80005d2c:	4f6080e7          	jalr	1270(ra) # 8000521e <fdalloc>
    80005d30:	fca42023          	sw	a0,-64(s0)
    80005d34:	06054863          	bltz	a0,80005da4 <sys_pipe+0xd6>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005d38:	4691                	li	a3,4
    80005d3a:	fc440613          	addi	a2,s0,-60
    80005d3e:	fd843583          	ld	a1,-40(s0)
    80005d42:	68a8                	ld	a0,80(s1)
    80005d44:	ffffc097          	auipc	ra,0xffffc
    80005d48:	912080e7          	jalr	-1774(ra) # 80001656 <copyout>
    80005d4c:	02054063          	bltz	a0,80005d6c <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005d50:	4691                	li	a3,4
    80005d52:	fc040613          	addi	a2,s0,-64
    80005d56:	fd843583          	ld	a1,-40(s0)
    80005d5a:	0591                	addi	a1,a1,4
    80005d5c:	68a8                	ld	a0,80(s1)
    80005d5e:	ffffc097          	auipc	ra,0xffffc
    80005d62:	8f8080e7          	jalr	-1800(ra) # 80001656 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005d66:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005d68:	06055563          	bgez	a0,80005dd2 <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    80005d6c:	fc442783          	lw	a5,-60(s0)
    80005d70:	07e9                	addi	a5,a5,26
    80005d72:	078e                	slli	a5,a5,0x3
    80005d74:	97a6                	add	a5,a5,s1
    80005d76:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80005d7a:	fc042503          	lw	a0,-64(s0)
    80005d7e:	0569                	addi	a0,a0,26
    80005d80:	050e                	slli	a0,a0,0x3
    80005d82:	9526                	add	a0,a0,s1
    80005d84:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005d88:	fd043503          	ld	a0,-48(s0)
    80005d8c:	fffff097          	auipc	ra,0xfffff
    80005d90:	a30080e7          	jalr	-1488(ra) # 800047bc <fileclose>
    fileclose(wf);
    80005d94:	fc843503          	ld	a0,-56(s0)
    80005d98:	fffff097          	auipc	ra,0xfffff
    80005d9c:	a24080e7          	jalr	-1500(ra) # 800047bc <fileclose>
    return -1;
    80005da0:	57fd                	li	a5,-1
    80005da2:	a805                	j	80005dd2 <sys_pipe+0x104>
    if(fd0 >= 0)
    80005da4:	fc442783          	lw	a5,-60(s0)
    80005da8:	0007c863          	bltz	a5,80005db8 <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    80005dac:	01a78513          	addi	a0,a5,26
    80005db0:	050e                	slli	a0,a0,0x3
    80005db2:	9526                	add	a0,a0,s1
    80005db4:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005db8:	fd043503          	ld	a0,-48(s0)
    80005dbc:	fffff097          	auipc	ra,0xfffff
    80005dc0:	a00080e7          	jalr	-1536(ra) # 800047bc <fileclose>
    fileclose(wf);
    80005dc4:	fc843503          	ld	a0,-56(s0)
    80005dc8:	fffff097          	auipc	ra,0xfffff
    80005dcc:	9f4080e7          	jalr	-1548(ra) # 800047bc <fileclose>
    return -1;
    80005dd0:	57fd                	li	a5,-1
}
    80005dd2:	853e                	mv	a0,a5
    80005dd4:	70e2                	ld	ra,56(sp)
    80005dd6:	7442                	ld	s0,48(sp)
    80005dd8:	74a2                	ld	s1,40(sp)
    80005dda:	6121                	addi	sp,sp,64
    80005ddc:	8082                	ret
	...

0000000080005de0 <kernelvec>:
    80005de0:	7111                	addi	sp,sp,-256
    80005de2:	e006                	sd	ra,0(sp)
    80005de4:	e40a                	sd	sp,8(sp)
    80005de6:	e80e                	sd	gp,16(sp)
    80005de8:	ec12                	sd	tp,24(sp)
    80005dea:	f016                	sd	t0,32(sp)
    80005dec:	f41a                	sd	t1,40(sp)
    80005dee:	f81e                	sd	t2,48(sp)
    80005df0:	fc22                	sd	s0,56(sp)
    80005df2:	e0a6                	sd	s1,64(sp)
    80005df4:	e4aa                	sd	a0,72(sp)
    80005df6:	e8ae                	sd	a1,80(sp)
    80005df8:	ecb2                	sd	a2,88(sp)
    80005dfa:	f0b6                	sd	a3,96(sp)
    80005dfc:	f4ba                	sd	a4,104(sp)
    80005dfe:	f8be                	sd	a5,112(sp)
    80005e00:	fcc2                	sd	a6,120(sp)
    80005e02:	e146                	sd	a7,128(sp)
    80005e04:	e54a                	sd	s2,136(sp)
    80005e06:	e94e                	sd	s3,144(sp)
    80005e08:	ed52                	sd	s4,152(sp)
    80005e0a:	f156                	sd	s5,160(sp)
    80005e0c:	f55a                	sd	s6,168(sp)
    80005e0e:	f95e                	sd	s7,176(sp)
    80005e10:	fd62                	sd	s8,184(sp)
    80005e12:	e1e6                	sd	s9,192(sp)
    80005e14:	e5ea                	sd	s10,200(sp)
    80005e16:	e9ee                	sd	s11,208(sp)
    80005e18:	edf2                	sd	t3,216(sp)
    80005e1a:	f1f6                	sd	t4,224(sp)
    80005e1c:	f5fa                	sd	t5,232(sp)
    80005e1e:	f9fe                	sd	t6,240(sp)
    80005e20:	d2bfc0ef          	jal	ra,80002b4a <kerneltrap>
    80005e24:	6082                	ld	ra,0(sp)
    80005e26:	6122                	ld	sp,8(sp)
    80005e28:	61c2                	ld	gp,16(sp)
    80005e2a:	7282                	ld	t0,32(sp)
    80005e2c:	7322                	ld	t1,40(sp)
    80005e2e:	73c2                	ld	t2,48(sp)
    80005e30:	7462                	ld	s0,56(sp)
    80005e32:	6486                	ld	s1,64(sp)
    80005e34:	6526                	ld	a0,72(sp)
    80005e36:	65c6                	ld	a1,80(sp)
    80005e38:	6666                	ld	a2,88(sp)
    80005e3a:	7686                	ld	a3,96(sp)
    80005e3c:	7726                	ld	a4,104(sp)
    80005e3e:	77c6                	ld	a5,112(sp)
    80005e40:	7866                	ld	a6,120(sp)
    80005e42:	688a                	ld	a7,128(sp)
    80005e44:	692a                	ld	s2,136(sp)
    80005e46:	69ca                	ld	s3,144(sp)
    80005e48:	6a6a                	ld	s4,152(sp)
    80005e4a:	7a8a                	ld	s5,160(sp)
    80005e4c:	7b2a                	ld	s6,168(sp)
    80005e4e:	7bca                	ld	s7,176(sp)
    80005e50:	7c6a                	ld	s8,184(sp)
    80005e52:	6c8e                	ld	s9,192(sp)
    80005e54:	6d2e                	ld	s10,200(sp)
    80005e56:	6dce                	ld	s11,208(sp)
    80005e58:	6e6e                	ld	t3,216(sp)
    80005e5a:	7e8e                	ld	t4,224(sp)
    80005e5c:	7f2e                	ld	t5,232(sp)
    80005e5e:	7fce                	ld	t6,240(sp)
    80005e60:	6111                	addi	sp,sp,256
    80005e62:	10200073          	sret
    80005e66:	00000013          	nop
    80005e6a:	00000013          	nop
    80005e6e:	0001                	nop

0000000080005e70 <timervec>:
    80005e70:	34051573          	csrrw	a0,mscratch,a0
    80005e74:	e10c                	sd	a1,0(a0)
    80005e76:	e510                	sd	a2,8(a0)
    80005e78:	e914                	sd	a3,16(a0)
    80005e7a:	6d0c                	ld	a1,24(a0)
    80005e7c:	7110                	ld	a2,32(a0)
    80005e7e:	6194                	ld	a3,0(a1)
    80005e80:	96b2                	add	a3,a3,a2
    80005e82:	e194                	sd	a3,0(a1)
    80005e84:	4589                	li	a1,2
    80005e86:	14459073          	csrw	sip,a1
    80005e8a:	6914                	ld	a3,16(a0)
    80005e8c:	6510                	ld	a2,8(a0)
    80005e8e:	610c                	ld	a1,0(a0)
    80005e90:	34051573          	csrrw	a0,mscratch,a0
    80005e94:	30200073          	mret
	...

0000000080005e9a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80005e9a:	1141                	addi	sp,sp,-16
    80005e9c:	e422                	sd	s0,8(sp)
    80005e9e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005ea0:	0c0007b7          	lui	a5,0xc000
    80005ea4:	4705                	li	a4,1
    80005ea6:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005ea8:	c3d8                	sw	a4,4(a5)
}
    80005eaa:	6422                	ld	s0,8(sp)
    80005eac:	0141                	addi	sp,sp,16
    80005eae:	8082                	ret

0000000080005eb0 <plicinithart>:

void
plicinithart(void)
{
    80005eb0:	1141                	addi	sp,sp,-16
    80005eb2:	e406                	sd	ra,8(sp)
    80005eb4:	e022                	sd	s0,0(sp)
    80005eb6:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005eb8:	ffffc097          	auipc	ra,0xffffc
    80005ebc:	ab2080e7          	jalr	-1358(ra) # 8000196a <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005ec0:	0085171b          	slliw	a4,a0,0x8
    80005ec4:	0c0027b7          	lui	a5,0xc002
    80005ec8:	97ba                	add	a5,a5,a4
    80005eca:	40200713          	li	a4,1026
    80005ece:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005ed2:	00d5151b          	slliw	a0,a0,0xd
    80005ed6:	0c2017b7          	lui	a5,0xc201
    80005eda:	953e                	add	a0,a0,a5
    80005edc:	00052023          	sw	zero,0(a0)
}
    80005ee0:	60a2                	ld	ra,8(sp)
    80005ee2:	6402                	ld	s0,0(sp)
    80005ee4:	0141                	addi	sp,sp,16
    80005ee6:	8082                	ret

0000000080005ee8 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005ee8:	1141                	addi	sp,sp,-16
    80005eea:	e406                	sd	ra,8(sp)
    80005eec:	e022                	sd	s0,0(sp)
    80005eee:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005ef0:	ffffc097          	auipc	ra,0xffffc
    80005ef4:	a7a080e7          	jalr	-1414(ra) # 8000196a <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005ef8:	00d5179b          	slliw	a5,a0,0xd
    80005efc:	0c201537          	lui	a0,0xc201
    80005f00:	953e                	add	a0,a0,a5
  return irq;
}
    80005f02:	4148                	lw	a0,4(a0)
    80005f04:	60a2                	ld	ra,8(sp)
    80005f06:	6402                	ld	s0,0(sp)
    80005f08:	0141                	addi	sp,sp,16
    80005f0a:	8082                	ret

0000000080005f0c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80005f0c:	1101                	addi	sp,sp,-32
    80005f0e:	ec06                	sd	ra,24(sp)
    80005f10:	e822                	sd	s0,16(sp)
    80005f12:	e426                	sd	s1,8(sp)
    80005f14:	1000                	addi	s0,sp,32
    80005f16:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005f18:	ffffc097          	auipc	ra,0xffffc
    80005f1c:	a52080e7          	jalr	-1454(ra) # 8000196a <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005f20:	00d5151b          	slliw	a0,a0,0xd
    80005f24:	0c2017b7          	lui	a5,0xc201
    80005f28:	97aa                	add	a5,a5,a0
    80005f2a:	c3c4                	sw	s1,4(a5)
}
    80005f2c:	60e2                	ld	ra,24(sp)
    80005f2e:	6442                	ld	s0,16(sp)
    80005f30:	64a2                	ld	s1,8(sp)
    80005f32:	6105                	addi	sp,sp,32
    80005f34:	8082                	ret

0000000080005f36 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005f36:	1141                	addi	sp,sp,-16
    80005f38:	e406                	sd	ra,8(sp)
    80005f3a:	e022                	sd	s0,0(sp)
    80005f3c:	0800                	addi	s0,sp,16
  if(i >= NUM)
    80005f3e:	479d                	li	a5,7
    80005f40:	06a7c963          	blt	a5,a0,80005fb2 <free_desc+0x7c>
    panic("free_desc 1");
  if(disk.free[i])
    80005f44:	0001d797          	auipc	a5,0x1d
    80005f48:	0bc78793          	addi	a5,a5,188 # 80023000 <disk>
    80005f4c:	00a78733          	add	a4,a5,a0
    80005f50:	6789                	lui	a5,0x2
    80005f52:	97ba                	add	a5,a5,a4
    80005f54:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    80005f58:	e7ad                	bnez	a5,80005fc2 <free_desc+0x8c>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005f5a:	00451793          	slli	a5,a0,0x4
    80005f5e:	0001f717          	auipc	a4,0x1f
    80005f62:	0a270713          	addi	a4,a4,162 # 80025000 <disk+0x2000>
    80005f66:	6314                	ld	a3,0(a4)
    80005f68:	96be                	add	a3,a3,a5
    80005f6a:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    80005f6e:	6314                	ld	a3,0(a4)
    80005f70:	96be                	add	a3,a3,a5
    80005f72:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    80005f76:	6314                	ld	a3,0(a4)
    80005f78:	96be                	add	a3,a3,a5
    80005f7a:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    80005f7e:	6318                	ld	a4,0(a4)
    80005f80:	97ba                	add	a5,a5,a4
    80005f82:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80005f86:	0001d797          	auipc	a5,0x1d
    80005f8a:	07a78793          	addi	a5,a5,122 # 80023000 <disk>
    80005f8e:	97aa                	add	a5,a5,a0
    80005f90:	6509                	lui	a0,0x2
    80005f92:	953e                	add	a0,a0,a5
    80005f94:	4785                	li	a5,1
    80005f96:	00f50c23          	sb	a5,24(a0) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    80005f9a:	0001f517          	auipc	a0,0x1f
    80005f9e:	07e50513          	addi	a0,a0,126 # 80025018 <disk+0x2018>
    80005fa2:	ffffc097          	auipc	ra,0xffffc
    80005fa6:	25c080e7          	jalr	604(ra) # 800021fe <wakeup>
}
    80005faa:	60a2                	ld	ra,8(sp)
    80005fac:	6402                	ld	s0,0(sp)
    80005fae:	0141                	addi	sp,sp,16
    80005fb0:	8082                	ret
    panic("free_desc 1");
    80005fb2:	00003517          	auipc	a0,0x3
    80005fb6:	80e50513          	addi	a0,a0,-2034 # 800087c0 <syscalls+0x330>
    80005fba:	ffffa097          	auipc	ra,0xffffa
    80005fbe:	57e080e7          	jalr	1406(ra) # 80000538 <panic>
    panic("free_desc 2");
    80005fc2:	00003517          	auipc	a0,0x3
    80005fc6:	80e50513          	addi	a0,a0,-2034 # 800087d0 <syscalls+0x340>
    80005fca:	ffffa097          	auipc	ra,0xffffa
    80005fce:	56e080e7          	jalr	1390(ra) # 80000538 <panic>

0000000080005fd2 <virtio_disk_init>:
{
    80005fd2:	1101                	addi	sp,sp,-32
    80005fd4:	ec06                	sd	ra,24(sp)
    80005fd6:	e822                	sd	s0,16(sp)
    80005fd8:	e426                	sd	s1,8(sp)
    80005fda:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005fdc:	00003597          	auipc	a1,0x3
    80005fe0:	80458593          	addi	a1,a1,-2044 # 800087e0 <syscalls+0x350>
    80005fe4:	0001f517          	auipc	a0,0x1f
    80005fe8:	14450513          	addi	a0,a0,324 # 80025128 <disk+0x2128>
    80005fec:	ffffb097          	auipc	ra,0xffffb
    80005ff0:	b54080e7          	jalr	-1196(ra) # 80000b40 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005ff4:	100017b7          	lui	a5,0x10001
    80005ff8:	4398                	lw	a4,0(a5)
    80005ffa:	2701                	sext.w	a4,a4
    80005ffc:	747277b7          	lui	a5,0x74727
    80006000:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80006004:	0ef71163          	bne	a4,a5,800060e6 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80006008:	100017b7          	lui	a5,0x10001
    8000600c:	43dc                	lw	a5,4(a5)
    8000600e:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80006010:	4705                	li	a4,1
    80006012:	0ce79a63          	bne	a5,a4,800060e6 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80006016:	100017b7          	lui	a5,0x10001
    8000601a:	479c                	lw	a5,8(a5)
    8000601c:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    8000601e:	4709                	li	a4,2
    80006020:	0ce79363          	bne	a5,a4,800060e6 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80006024:	100017b7          	lui	a5,0x10001
    80006028:	47d8                	lw	a4,12(a5)
    8000602a:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000602c:	554d47b7          	lui	a5,0x554d4
    80006030:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80006034:	0af71963          	bne	a4,a5,800060e6 <virtio_disk_init+0x114>
  *R(VIRTIO_MMIO_STATUS) = status;
    80006038:	100017b7          	lui	a5,0x10001
    8000603c:	4705                	li	a4,1
    8000603e:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80006040:	470d                	li	a4,3
    80006042:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80006044:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80006046:	c7ffe737          	lui	a4,0xc7ffe
    8000604a:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fd875f>
    8000604e:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80006050:	2701                	sext.w	a4,a4
    80006052:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80006054:	472d                	li	a4,11
    80006056:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80006058:	473d                	li	a4,15
    8000605a:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    8000605c:	6705                	lui	a4,0x1
    8000605e:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80006060:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80006064:	5bdc                	lw	a5,52(a5)
    80006066:	2781                	sext.w	a5,a5
  if(max == 0)
    80006068:	c7d9                	beqz	a5,800060f6 <virtio_disk_init+0x124>
  if(max < NUM)
    8000606a:	471d                	li	a4,7
    8000606c:	08f77d63          	bgeu	a4,a5,80006106 <virtio_disk_init+0x134>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80006070:	100014b7          	lui	s1,0x10001
    80006074:	47a1                	li	a5,8
    80006076:	dc9c                	sw	a5,56(s1)
  memset(disk.pages, 0, sizeof(disk.pages));
    80006078:	6609                	lui	a2,0x2
    8000607a:	4581                	li	a1,0
    8000607c:	0001d517          	auipc	a0,0x1d
    80006080:	f8450513          	addi	a0,a0,-124 # 80023000 <disk>
    80006084:	ffffb097          	auipc	ra,0xffffb
    80006088:	c48080e7          	jalr	-952(ra) # 80000ccc <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    8000608c:	0001d717          	auipc	a4,0x1d
    80006090:	f7470713          	addi	a4,a4,-140 # 80023000 <disk>
    80006094:	00c75793          	srli	a5,a4,0xc
    80006098:	2781                	sext.w	a5,a5
    8000609a:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct virtq_desc *) disk.pages;
    8000609c:	0001f797          	auipc	a5,0x1f
    800060a0:	f6478793          	addi	a5,a5,-156 # 80025000 <disk+0x2000>
    800060a4:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    800060a6:	0001d717          	auipc	a4,0x1d
    800060aa:	fda70713          	addi	a4,a4,-38 # 80023080 <disk+0x80>
    800060ae:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    800060b0:	0001e717          	auipc	a4,0x1e
    800060b4:	f5070713          	addi	a4,a4,-176 # 80024000 <disk+0x1000>
    800060b8:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    800060ba:	4705                	li	a4,1
    800060bc:	00e78c23          	sb	a4,24(a5)
    800060c0:	00e78ca3          	sb	a4,25(a5)
    800060c4:	00e78d23          	sb	a4,26(a5)
    800060c8:	00e78da3          	sb	a4,27(a5)
    800060cc:	00e78e23          	sb	a4,28(a5)
    800060d0:	00e78ea3          	sb	a4,29(a5)
    800060d4:	00e78f23          	sb	a4,30(a5)
    800060d8:	00e78fa3          	sb	a4,31(a5)
}
    800060dc:	60e2                	ld	ra,24(sp)
    800060de:	6442                	ld	s0,16(sp)
    800060e0:	64a2                	ld	s1,8(sp)
    800060e2:	6105                	addi	sp,sp,32
    800060e4:	8082                	ret
    panic("could not find virtio disk");
    800060e6:	00002517          	auipc	a0,0x2
    800060ea:	70a50513          	addi	a0,a0,1802 # 800087f0 <syscalls+0x360>
    800060ee:	ffffa097          	auipc	ra,0xffffa
    800060f2:	44a080e7          	jalr	1098(ra) # 80000538 <panic>
    panic("virtio disk has no queue 0");
    800060f6:	00002517          	auipc	a0,0x2
    800060fa:	71a50513          	addi	a0,a0,1818 # 80008810 <syscalls+0x380>
    800060fe:	ffffa097          	auipc	ra,0xffffa
    80006102:	43a080e7          	jalr	1082(ra) # 80000538 <panic>
    panic("virtio disk max queue too short");
    80006106:	00002517          	auipc	a0,0x2
    8000610a:	72a50513          	addi	a0,a0,1834 # 80008830 <syscalls+0x3a0>
    8000610e:	ffffa097          	auipc	ra,0xffffa
    80006112:	42a080e7          	jalr	1066(ra) # 80000538 <panic>

0000000080006116 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80006116:	7119                	addi	sp,sp,-128
    80006118:	fc86                	sd	ra,120(sp)
    8000611a:	f8a2                	sd	s0,112(sp)
    8000611c:	f4a6                	sd	s1,104(sp)
    8000611e:	f0ca                	sd	s2,96(sp)
    80006120:	ecce                	sd	s3,88(sp)
    80006122:	e8d2                	sd	s4,80(sp)
    80006124:	e4d6                	sd	s5,72(sp)
    80006126:	e0da                	sd	s6,64(sp)
    80006128:	fc5e                	sd	s7,56(sp)
    8000612a:	f862                	sd	s8,48(sp)
    8000612c:	f466                	sd	s9,40(sp)
    8000612e:	f06a                	sd	s10,32(sp)
    80006130:	ec6e                	sd	s11,24(sp)
    80006132:	0100                	addi	s0,sp,128
    80006134:	8aaa                	mv	s5,a0
    80006136:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80006138:	00c52c83          	lw	s9,12(a0)
    8000613c:	001c9c9b          	slliw	s9,s9,0x1
    80006140:	1c82                	slli	s9,s9,0x20
    80006142:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80006146:	0001f517          	auipc	a0,0x1f
    8000614a:	fe250513          	addi	a0,a0,-30 # 80025128 <disk+0x2128>
    8000614e:	ffffb097          	auipc	ra,0xffffb
    80006152:	a82080e7          	jalr	-1406(ra) # 80000bd0 <acquire>
  for(int i = 0; i < 3; i++){
    80006156:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80006158:	44a1                	li	s1,8
      disk.free[i] = 0;
    8000615a:	0001dc17          	auipc	s8,0x1d
    8000615e:	ea6c0c13          	addi	s8,s8,-346 # 80023000 <disk>
    80006162:	6b89                	lui	s7,0x2
  for(int i = 0; i < 3; i++){
    80006164:	4b0d                	li	s6,3
    80006166:	a0ad                	j	800061d0 <virtio_disk_rw+0xba>
      disk.free[i] = 0;
    80006168:	00fc0733          	add	a4,s8,a5
    8000616c:	975e                	add	a4,a4,s7
    8000616e:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80006172:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80006174:	0207c563          	bltz	a5,8000619e <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    80006178:	2905                	addiw	s2,s2,1
    8000617a:	0611                	addi	a2,a2,4
    8000617c:	19690d63          	beq	s2,s6,80006316 <virtio_disk_rw+0x200>
    idx[i] = alloc_desc();
    80006180:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80006182:	0001f717          	auipc	a4,0x1f
    80006186:	e9670713          	addi	a4,a4,-362 # 80025018 <disk+0x2018>
    8000618a:	87ce                	mv	a5,s3
    if(disk.free[i]){
    8000618c:	00074683          	lbu	a3,0(a4)
    80006190:	fee1                	bnez	a3,80006168 <virtio_disk_rw+0x52>
  for(int i = 0; i < NUM; i++){
    80006192:	2785                	addiw	a5,a5,1
    80006194:	0705                	addi	a4,a4,1
    80006196:	fe979be3          	bne	a5,s1,8000618c <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    8000619a:	57fd                	li	a5,-1
    8000619c:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    8000619e:	01205d63          	blez	s2,800061b8 <virtio_disk_rw+0xa2>
    800061a2:	8dce                	mv	s11,s3
        free_desc(idx[j]);
    800061a4:	000a2503          	lw	a0,0(s4)
    800061a8:	00000097          	auipc	ra,0x0
    800061ac:	d8e080e7          	jalr	-626(ra) # 80005f36 <free_desc>
      for(int j = 0; j < i; j++)
    800061b0:	2d85                	addiw	s11,s11,1
    800061b2:	0a11                	addi	s4,s4,4
    800061b4:	ffb918e3          	bne	s2,s11,800061a4 <virtio_disk_rw+0x8e>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    800061b8:	0001f597          	auipc	a1,0x1f
    800061bc:	f7058593          	addi	a1,a1,-144 # 80025128 <disk+0x2128>
    800061c0:	0001f517          	auipc	a0,0x1f
    800061c4:	e5850513          	addi	a0,a0,-424 # 80025018 <disk+0x2018>
    800061c8:	ffffc097          	auipc	ra,0xffffc
    800061cc:	e9a080e7          	jalr	-358(ra) # 80002062 <sleep>
  for(int i = 0; i < 3; i++){
    800061d0:	f8040a13          	addi	s4,s0,-128
{
    800061d4:	8652                	mv	a2,s4
  for(int i = 0; i < 3; i++){
    800061d6:	894e                	mv	s2,s3
    800061d8:	b765                	j	80006180 <virtio_disk_rw+0x6a>
  disk.desc[idx[0]].next = idx[1];

  disk.desc[idx[1]].addr = (uint64) b->data;
  disk.desc[idx[1]].len = BSIZE;
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
    800061da:	0001f697          	auipc	a3,0x1f
    800061de:	e266b683          	ld	a3,-474(a3) # 80025000 <disk+0x2000>
    800061e2:	96ba                	add	a3,a3,a4
    800061e4:	00069623          	sh	zero,12(a3)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800061e8:	0001d817          	auipc	a6,0x1d
    800061ec:	e1880813          	addi	a6,a6,-488 # 80023000 <disk>
    800061f0:	0001f697          	auipc	a3,0x1f
    800061f4:	e1068693          	addi	a3,a3,-496 # 80025000 <disk+0x2000>
    800061f8:	6290                	ld	a2,0(a3)
    800061fa:	963a                	add	a2,a2,a4
    800061fc:	00c65583          	lhu	a1,12(a2) # 200c <_entry-0x7fffdff4>
    80006200:	0015e593          	ori	a1,a1,1
    80006204:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[1]].next = idx[2];
    80006208:	f8842603          	lw	a2,-120(s0)
    8000620c:	628c                	ld	a1,0(a3)
    8000620e:	972e                	add	a4,a4,a1
    80006210:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80006214:	20050593          	addi	a1,a0,512
    80006218:	0592                	slli	a1,a1,0x4
    8000621a:	95c2                	add	a1,a1,a6
    8000621c:	577d                	li	a4,-1
    8000621e:	02e58823          	sb	a4,48(a1)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80006222:	00461713          	slli	a4,a2,0x4
    80006226:	6290                	ld	a2,0(a3)
    80006228:	963a                	add	a2,a2,a4
    8000622a:	03078793          	addi	a5,a5,48
    8000622e:	97c2                	add	a5,a5,a6
    80006230:	e21c                	sd	a5,0(a2)
  disk.desc[idx[2]].len = 1;
    80006232:	629c                	ld	a5,0(a3)
    80006234:	97ba                	add	a5,a5,a4
    80006236:	4605                	li	a2,1
    80006238:	c790                	sw	a2,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    8000623a:	629c                	ld	a5,0(a3)
    8000623c:	97ba                	add	a5,a5,a4
    8000623e:	4809                	li	a6,2
    80006240:	01079623          	sh	a6,12(a5)
  disk.desc[idx[2]].next = 0;
    80006244:	629c                	ld	a5,0(a3)
    80006246:	973e                	add	a4,a4,a5
    80006248:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000624c:	00caa223          	sw	a2,4(s5)
  disk.info[idx[0]].b = b;
    80006250:	0355b423          	sd	s5,40(a1)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80006254:	6698                	ld	a4,8(a3)
    80006256:	00275783          	lhu	a5,2(a4)
    8000625a:	8b9d                	andi	a5,a5,7
    8000625c:	0786                	slli	a5,a5,0x1
    8000625e:	97ba                	add	a5,a5,a4
    80006260:	00a79223          	sh	a0,4(a5)

  __sync_synchronize();
    80006264:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80006268:	6698                	ld	a4,8(a3)
    8000626a:	00275783          	lhu	a5,2(a4)
    8000626e:	2785                	addiw	a5,a5,1
    80006270:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80006274:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80006278:	100017b7          	lui	a5,0x10001
    8000627c:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80006280:	004aa783          	lw	a5,4(s5)
    80006284:	02c79163          	bne	a5,a2,800062a6 <virtio_disk_rw+0x190>
    sleep(b, &disk.vdisk_lock);
    80006288:	0001f917          	auipc	s2,0x1f
    8000628c:	ea090913          	addi	s2,s2,-352 # 80025128 <disk+0x2128>
  while(b->disk == 1) {
    80006290:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    80006292:	85ca                	mv	a1,s2
    80006294:	8556                	mv	a0,s5
    80006296:	ffffc097          	auipc	ra,0xffffc
    8000629a:	dcc080e7          	jalr	-564(ra) # 80002062 <sleep>
  while(b->disk == 1) {
    8000629e:	004aa783          	lw	a5,4(s5)
    800062a2:	fe9788e3          	beq	a5,s1,80006292 <virtio_disk_rw+0x17c>
  }

  disk.info[idx[0]].b = 0;
    800062a6:	f8042903          	lw	s2,-128(s0)
    800062aa:	20090793          	addi	a5,s2,512
    800062ae:	00479713          	slli	a4,a5,0x4
    800062b2:	0001d797          	auipc	a5,0x1d
    800062b6:	d4e78793          	addi	a5,a5,-690 # 80023000 <disk>
    800062ba:	97ba                	add	a5,a5,a4
    800062bc:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    800062c0:	0001f997          	auipc	s3,0x1f
    800062c4:	d4098993          	addi	s3,s3,-704 # 80025000 <disk+0x2000>
    800062c8:	00491713          	slli	a4,s2,0x4
    800062cc:	0009b783          	ld	a5,0(s3)
    800062d0:	97ba                	add	a5,a5,a4
    800062d2:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    800062d6:	854a                	mv	a0,s2
    800062d8:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    800062dc:	00000097          	auipc	ra,0x0
    800062e0:	c5a080e7          	jalr	-934(ra) # 80005f36 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800062e4:	8885                	andi	s1,s1,1
    800062e6:	f0ed                	bnez	s1,800062c8 <virtio_disk_rw+0x1b2>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    800062e8:	0001f517          	auipc	a0,0x1f
    800062ec:	e4050513          	addi	a0,a0,-448 # 80025128 <disk+0x2128>
    800062f0:	ffffb097          	auipc	ra,0xffffb
    800062f4:	994080e7          	jalr	-1644(ra) # 80000c84 <release>
}
    800062f8:	70e6                	ld	ra,120(sp)
    800062fa:	7446                	ld	s0,112(sp)
    800062fc:	74a6                	ld	s1,104(sp)
    800062fe:	7906                	ld	s2,96(sp)
    80006300:	69e6                	ld	s3,88(sp)
    80006302:	6a46                	ld	s4,80(sp)
    80006304:	6aa6                	ld	s5,72(sp)
    80006306:	6b06                	ld	s6,64(sp)
    80006308:	7be2                	ld	s7,56(sp)
    8000630a:	7c42                	ld	s8,48(sp)
    8000630c:	7ca2                	ld	s9,40(sp)
    8000630e:	7d02                	ld	s10,32(sp)
    80006310:	6de2                	ld	s11,24(sp)
    80006312:	6109                	addi	sp,sp,128
    80006314:	8082                	ret
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80006316:	f8042503          	lw	a0,-128(s0)
    8000631a:	20050793          	addi	a5,a0,512
    8000631e:	0792                	slli	a5,a5,0x4
  if(write)
    80006320:	0001d817          	auipc	a6,0x1d
    80006324:	ce080813          	addi	a6,a6,-800 # 80023000 <disk>
    80006328:	00f80733          	add	a4,a6,a5
    8000632c:	01a036b3          	snez	a3,s10
    80006330:	0ad72423          	sw	a3,168(a4)
  buf0->reserved = 0;
    80006334:	0a072623          	sw	zero,172(a4)
  buf0->sector = sector;
    80006338:	0b973823          	sd	s9,176(a4)
  disk.desc[idx[0]].addr = (uint64) buf0;
    8000633c:	7679                	lui	a2,0xffffe
    8000633e:	963e                	add	a2,a2,a5
    80006340:	0001f697          	auipc	a3,0x1f
    80006344:	cc068693          	addi	a3,a3,-832 # 80025000 <disk+0x2000>
    80006348:	6298                	ld	a4,0(a3)
    8000634a:	9732                	add	a4,a4,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    8000634c:	0a878593          	addi	a1,a5,168
    80006350:	95c2                	add	a1,a1,a6
  disk.desc[idx[0]].addr = (uint64) buf0;
    80006352:	e30c                	sd	a1,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80006354:	6298                	ld	a4,0(a3)
    80006356:	9732                	add	a4,a4,a2
    80006358:	45c1                	li	a1,16
    8000635a:	c70c                	sw	a1,8(a4)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    8000635c:	6298                	ld	a4,0(a3)
    8000635e:	9732                	add	a4,a4,a2
    80006360:	4585                	li	a1,1
    80006362:	00b71623          	sh	a1,12(a4)
  disk.desc[idx[0]].next = idx[1];
    80006366:	f8442703          	lw	a4,-124(s0)
    8000636a:	628c                	ld	a1,0(a3)
    8000636c:	962e                	add	a2,a2,a1
    8000636e:	00e61723          	sh	a4,14(a2) # ffffffffffffe00e <end+0xffffffff7ffd800e>
  disk.desc[idx[1]].addr = (uint64) b->data;
    80006372:	0712                	slli	a4,a4,0x4
    80006374:	6290                	ld	a2,0(a3)
    80006376:	963a                	add	a2,a2,a4
    80006378:	058a8593          	addi	a1,s5,88
    8000637c:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    8000637e:	6294                	ld	a3,0(a3)
    80006380:	96ba                	add	a3,a3,a4
    80006382:	40000613          	li	a2,1024
    80006386:	c690                	sw	a2,8(a3)
  if(write)
    80006388:	e40d19e3          	bnez	s10,800061da <virtio_disk_rw+0xc4>
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    8000638c:	0001f697          	auipc	a3,0x1f
    80006390:	c746b683          	ld	a3,-908(a3) # 80025000 <disk+0x2000>
    80006394:	96ba                	add	a3,a3,a4
    80006396:	4609                	li	a2,2
    80006398:	00c69623          	sh	a2,12(a3)
    8000639c:	b5b1                	j	800061e8 <virtio_disk_rw+0xd2>

000000008000639e <virtio_disk_intr>:

void
virtio_disk_intr()
{
    8000639e:	1101                	addi	sp,sp,-32
    800063a0:	ec06                	sd	ra,24(sp)
    800063a2:	e822                	sd	s0,16(sp)
    800063a4:	e426                	sd	s1,8(sp)
    800063a6:	e04a                	sd	s2,0(sp)
    800063a8:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    800063aa:	0001f517          	auipc	a0,0x1f
    800063ae:	d7e50513          	addi	a0,a0,-642 # 80025128 <disk+0x2128>
    800063b2:	ffffb097          	auipc	ra,0xffffb
    800063b6:	81e080e7          	jalr	-2018(ra) # 80000bd0 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800063ba:	10001737          	lui	a4,0x10001
    800063be:	533c                	lw	a5,96(a4)
    800063c0:	8b8d                	andi	a5,a5,3
    800063c2:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    800063c4:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    800063c8:	0001f797          	auipc	a5,0x1f
    800063cc:	c3878793          	addi	a5,a5,-968 # 80025000 <disk+0x2000>
    800063d0:	6b94                	ld	a3,16(a5)
    800063d2:	0207d703          	lhu	a4,32(a5)
    800063d6:	0026d783          	lhu	a5,2(a3)
    800063da:	06f70163          	beq	a4,a5,8000643c <virtio_disk_intr+0x9e>
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800063de:	0001d917          	auipc	s2,0x1d
    800063e2:	c2290913          	addi	s2,s2,-990 # 80023000 <disk>
    800063e6:	0001f497          	auipc	s1,0x1f
    800063ea:	c1a48493          	addi	s1,s1,-998 # 80025000 <disk+0x2000>
    __sync_synchronize();
    800063ee:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800063f2:	6898                	ld	a4,16(s1)
    800063f4:	0204d783          	lhu	a5,32(s1)
    800063f8:	8b9d                	andi	a5,a5,7
    800063fa:	078e                	slli	a5,a5,0x3
    800063fc:	97ba                	add	a5,a5,a4
    800063fe:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80006400:	20078713          	addi	a4,a5,512
    80006404:	0712                	slli	a4,a4,0x4
    80006406:	974a                	add	a4,a4,s2
    80006408:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    8000640c:	e731                	bnez	a4,80006458 <virtio_disk_intr+0xba>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    8000640e:	20078793          	addi	a5,a5,512
    80006412:	0792                	slli	a5,a5,0x4
    80006414:	97ca                	add	a5,a5,s2
    80006416:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80006418:	00052223          	sw	zero,4(a0)
    wakeup(b);
    8000641c:	ffffc097          	auipc	ra,0xffffc
    80006420:	de2080e7          	jalr	-542(ra) # 800021fe <wakeup>

    disk.used_idx += 1;
    80006424:	0204d783          	lhu	a5,32(s1)
    80006428:	2785                	addiw	a5,a5,1
    8000642a:	17c2                	slli	a5,a5,0x30
    8000642c:	93c1                	srli	a5,a5,0x30
    8000642e:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80006432:	6898                	ld	a4,16(s1)
    80006434:	00275703          	lhu	a4,2(a4)
    80006438:	faf71be3          	bne	a4,a5,800063ee <virtio_disk_intr+0x50>
  }

  release(&disk.vdisk_lock);
    8000643c:	0001f517          	auipc	a0,0x1f
    80006440:	cec50513          	addi	a0,a0,-788 # 80025128 <disk+0x2128>
    80006444:	ffffb097          	auipc	ra,0xffffb
    80006448:	840080e7          	jalr	-1984(ra) # 80000c84 <release>
}
    8000644c:	60e2                	ld	ra,24(sp)
    8000644e:	6442                	ld	s0,16(sp)
    80006450:	64a2                	ld	s1,8(sp)
    80006452:	6902                	ld	s2,0(sp)
    80006454:	6105                	addi	sp,sp,32
    80006456:	8082                	ret
      panic("virtio_disk_intr status");
    80006458:	00002517          	auipc	a0,0x2
    8000645c:	3f850513          	addi	a0,a0,1016 # 80008850 <syscalls+0x3c0>
    80006460:	ffffa097          	auipc	ra,0xffffa
    80006464:	0d8080e7          	jalr	216(ra) # 80000538 <panic>
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
