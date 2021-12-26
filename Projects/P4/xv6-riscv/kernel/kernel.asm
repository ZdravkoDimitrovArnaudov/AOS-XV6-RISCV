
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	8f013103          	ld	sp,-1808(sp) # 800088f0 <_GLOBAL_OFFSET_TABLE_+0x8>
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
    80000068:	f4c78793          	addi	a5,a5,-180 # 80005fb0 <timervec>
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
    8000009c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fbd87ff>
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
    80000130:	472080e7          	jalr	1138(ra) # 8000259e <either_copyin>
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
    800001c0:	00002097          	auipc	ra,0x2
    800001c4:	8d2080e7          	jalr	-1838(ra) # 80001a92 <myproc>
    800001c8:	551c                	lw	a5,40(a0)
    800001ca:	e7b5                	bnez	a5,80000236 <consoleread+0xd2>
      sleep(&cons.r, &cons.lock);
    800001cc:	85a6                	mv	a1,s1
    800001ce:	854a                	mv	a0,s2
    800001d0:	00002097          	auipc	ra,0x2
    800001d4:	fa0080e7          	jalr	-96(ra) # 80002170 <sleep>
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
    80000210:	33c080e7          	jalr	828(ra) # 80002548 <either_copyout>
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
    800002f0:	308080e7          	jalr	776(ra) # 800025f4 <procdump>
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
    80000444:	ed8080e7          	jalr	-296(ra) # 80002318 <wakeup>
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
    80000472:	00421797          	auipc	a5,0x421
    80000476:	4a678793          	addi	a5,a5,1190 # 80421918 <devsw>
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
    80000890:	a8c080e7          	jalr	-1396(ra) # 80002318 <wakeup>
    
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
    80000918:	00002097          	auipc	ra,0x2
    8000091c:	858080e7          	jalr	-1960(ra) # 80002170 <sleep>
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
    800009f8:	00425797          	auipc	a5,0x425
    800009fc:	60878793          	addi	a5,a5,1544 # 80426000 <end>
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
    80000ac8:	00425517          	auipc	a0,0x425
    80000acc:	53850513          	addi	a0,a0,1336 # 80426000 <end>
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
    80000b6e:	f0c080e7          	jalr	-244(ra) # 80001a76 <mycpu>
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
    80000ba0:	eda080e7          	jalr	-294(ra) # 80001a76 <mycpu>
    80000ba4:	5d3c                	lw	a5,120(a0)
    80000ba6:	cf89                	beqz	a5,80000bc0 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80000ba8:	00001097          	auipc	ra,0x1
    80000bac:	ece080e7          	jalr	-306(ra) # 80001a76 <mycpu>
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
    80000bc4:	eb6080e7          	jalr	-330(ra) # 80001a76 <mycpu>
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
    80000c04:	e76080e7          	jalr	-394(ra) # 80001a76 <mycpu>
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
    80000c30:	e4a080e7          	jalr	-438(ra) # 80001a76 <mycpu>
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
    80000e7e:	bec080e7          	jalr	-1044(ra) # 80001a66 <cpuid>
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
    80000e9a:	bd0080e7          	jalr	-1072(ra) # 80001a66 <cpuid>
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
    80000ebc:	b40080e7          	jalr	-1216(ra) # 800029f8 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000ec0:	00005097          	auipc	ra,0x5
    80000ec4:	130080e7          	jalr	304(ra) # 80005ff0 <plicinithart>
  }

  scheduler();        
    80000ec8:	00001097          	auipc	ra,0x1
    80000ecc:	0f0080e7          	jalr	240(ra) # 80001fb8 <scheduler>
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
    80000f2c:	a86080e7          	jalr	-1402(ra) # 800019ae <procinit>
    trapinit();      // trap vectors
    80000f30:	00002097          	auipc	ra,0x2
    80000f34:	aa0080e7          	jalr	-1376(ra) # 800029d0 <trapinit>
    trapinithart();  // install kernel trap vector
    80000f38:	00002097          	auipc	ra,0x2
    80000f3c:	ac0080e7          	jalr	-1344(ra) # 800029f8 <trapinithart>
    plicinit();      // set up interrupt controller
    80000f40:	00005097          	auipc	ra,0x5
    80000f44:	09a080e7          	jalr	154(ra) # 80005fda <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000f48:	00005097          	auipc	ra,0x5
    80000f4c:	0a8080e7          	jalr	168(ra) # 80005ff0 <plicinithart>
    binit();         // buffer cache
    80000f50:	00002097          	auipc	ra,0x2
    80000f54:	27e080e7          	jalr	638(ra) # 800031ce <binit>
    iinit();         // inode table
    80000f58:	00003097          	auipc	ra,0x3
    80000f5c:	90e080e7          	jalr	-1778(ra) # 80003866 <iinit>
    fileinit();      // file table
    80000f60:	00004097          	auipc	ra,0x4
    80000f64:	8b8080e7          	jalr	-1864(ra) # 80004818 <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000f68:	00005097          	auipc	ra,0x5
    80000f6c:	1aa080e7          	jalr	426(ra) # 80006112 <virtio_disk_init>
    userinit();      // first user process
    80000f70:	00001097          	auipc	ra,0x1
    80000f74:	e12080e7          	jalr	-494(ra) # 80001d82 <userinit>
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
    80001228:	6ec080e7          	jalr	1772(ra) # 80001910 <proc_mapstacks>
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

0000000080001824 <print_table>:


void
print_table(pagetable_t pagetable, int level)
{
    80001824:	7159                	addi	sp,sp,-112
    80001826:	f486                	sd	ra,104(sp)
    80001828:	f0a2                	sd	s0,96(sp)
    8000182a:	eca6                	sd	s1,88(sp)
    8000182c:	e8ca                	sd	s2,80(sp)
    8000182e:	e4ce                	sd	s3,72(sp)
    80001830:	e0d2                	sd	s4,64(sp)
    80001832:	fc56                	sd	s5,56(sp)
    80001834:	f85a                	sd	s6,48(sp)
    80001836:	f45e                	sd	s7,40(sp)
    80001838:	f062                	sd	s8,32(sp)
    8000183a:	ec66                	sd	s9,24(sp)
    8000183c:	e86a                	sd	s10,16(sp)
    8000183e:	e46e                	sd	s11,8(sp)
    80001840:	1880                	addi	s0,sp,112
    80001842:	8aae                	mv	s5,a1
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80001844:	8a2a                	mv	s4,a0
    80001846:	4981                	li	s3,0
    pte_t pte = pagetable[i];
    if (pte & PTE_V) {
      for (int j = 0; j <= level; j++) printf(" ..");
      printf("%d: pte %p pa %p\n", i, pte, PTE2PA(pte));
    80001848:	00007c97          	auipc	s9,0x7
    8000184c:	998c8c93          	addi	s9,s9,-1640 # 800081e0 <digits+0x1a0>
      for (int j = 0; j <= level; j++) printf(" ..");
    80001850:	4d01                	li	s10,0
    80001852:	00007b17          	auipc	s6,0x7
    80001856:	986b0b13          	addi	s6,s6,-1658 # 800081d8 <digits+0x198>
    }
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    8000185a:	4c05                	li	s8,1
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
      print_table((pagetable_t)child, level + 1);
    8000185c:	00158d9b          	addiw	s11,a1,1
  for(int i = 0; i < 512; i++){
    80001860:	20000b93          	li	s7,512
    80001864:	a01d                	j	8000188a <print_table+0x66>
      printf("%d: pte %p pa %p\n", i, pte, PTE2PA(pte));
    80001866:	00a95693          	srli	a3,s2,0xa
    8000186a:	06b2                	slli	a3,a3,0xc
    8000186c:	864a                	mv	a2,s2
    8000186e:	85ce                	mv	a1,s3
    80001870:	8566                	mv	a0,s9
    80001872:	fffff097          	auipc	ra,0xfffff
    80001876:	d10080e7          	jalr	-752(ra) # 80000582 <printf>
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    8000187a:	00f97793          	andi	a5,s2,15
    8000187e:	03878763          	beq	a5,s8,800018ac <print_table+0x88>
  for(int i = 0; i < 512; i++){
    80001882:	2985                	addiw	s3,s3,1
    80001884:	0a21                	addi	s4,s4,8
    80001886:	03798c63          	beq	s3,s7,800018be <print_table+0x9a>
    pte_t pte = pagetable[i];
    8000188a:	000a3903          	ld	s2,0(s4) # fffffffffffff000 <end+0xffffffff7fbd9000>
    if (pte & PTE_V) {
    8000188e:	00197793          	andi	a5,s2,1
    80001892:	d7e5                	beqz	a5,8000187a <print_table+0x56>
      for (int j = 0; j <= level; j++) printf(" ..");
    80001894:	fc0ac9e3          	bltz	s5,80001866 <print_table+0x42>
    80001898:	84ea                	mv	s1,s10
    8000189a:	855a                	mv	a0,s6
    8000189c:	fffff097          	auipc	ra,0xfffff
    800018a0:	ce6080e7          	jalr	-794(ra) # 80000582 <printf>
    800018a4:	2485                	addiw	s1,s1,1
    800018a6:	fe9adae3          	bge	s5,s1,8000189a <print_table+0x76>
    800018aa:	bf75                	j	80001866 <print_table+0x42>
      uint64 child = PTE2PA(pte);
    800018ac:	00a95513          	srli	a0,s2,0xa
      print_table((pagetable_t)child, level + 1);
    800018b0:	85ee                	mv	a1,s11
    800018b2:	0532                	slli	a0,a0,0xc
    800018b4:	00000097          	auipc	ra,0x0
    800018b8:	f70080e7          	jalr	-144(ra) # 80001824 <print_table>
    800018bc:	b7d9                	j	80001882 <print_table+0x5e>
    }
  }
}
    800018be:	70a6                	ld	ra,104(sp)
    800018c0:	7406                	ld	s0,96(sp)
    800018c2:	64e6                	ld	s1,88(sp)
    800018c4:	6946                	ld	s2,80(sp)
    800018c6:	69a6                	ld	s3,72(sp)
    800018c8:	6a06                	ld	s4,64(sp)
    800018ca:	7ae2                	ld	s5,56(sp)
    800018cc:	7b42                	ld	s6,48(sp)
    800018ce:	7ba2                	ld	s7,40(sp)
    800018d0:	7c02                	ld	s8,32(sp)
    800018d2:	6ce2                	ld	s9,24(sp)
    800018d4:	6d42                	ld	s10,16(sp)
    800018d6:	6da2                	ld	s11,8(sp)
    800018d8:	6165                	addi	sp,sp,112
    800018da:	8082                	ret

00000000800018dc <vmprint>:

void vmprint(pagetable_t pagetable) {
    800018dc:	1101                	addi	sp,sp,-32
    800018de:	ec06                	sd	ra,24(sp)
    800018e0:	e822                	sd	s0,16(sp)
    800018e2:	e426                	sd	s1,8(sp)
    800018e4:	1000                	addi	s0,sp,32
    800018e6:	84aa                	mv	s1,a0
  printf("page table %p\n", pagetable);
    800018e8:	85aa                	mv	a1,a0
    800018ea:	00007517          	auipc	a0,0x7
    800018ee:	90e50513          	addi	a0,a0,-1778 # 800081f8 <digits+0x1b8>
    800018f2:	fffff097          	auipc	ra,0xfffff
    800018f6:	c90080e7          	jalr	-880(ra) # 80000582 <printf>
  print_table(pagetable, 0);
    800018fa:	4581                	li	a1,0
    800018fc:	8526                	mv	a0,s1
    800018fe:	00000097          	auipc	ra,0x0
    80001902:	f26080e7          	jalr	-218(ra) # 80001824 <print_table>
    80001906:	60e2                	ld	ra,24(sp)
    80001908:	6442                	ld	s0,16(sp)
    8000190a:	64a2                	ld	s1,8(sp)
    8000190c:	6105                	addi	sp,sp,32
    8000190e:	8082                	ret

0000000080001910 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80001910:	715d                	addi	sp,sp,-80
    80001912:	e486                	sd	ra,72(sp)
    80001914:	e0a2                	sd	s0,64(sp)
    80001916:	fc26                	sd	s1,56(sp)
    80001918:	f84a                	sd	s2,48(sp)
    8000191a:	f44e                	sd	s3,40(sp)
    8000191c:	f052                	sd	s4,32(sp)
    8000191e:	ec56                	sd	s5,24(sp)
    80001920:	e85a                	sd	s6,16(sp)
    80001922:	e45e                	sd	s7,8(sp)
    80001924:	0880                	addi	s0,sp,80
    80001926:	8a2a                	mv	s4,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80001928:	00010497          	auipc	s1,0x10
    8000192c:	da848493          	addi	s1,s1,-600 # 800116d0 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80001930:	8ba6                	mv	s7,s1
    80001932:	00006b17          	auipc	s6,0x6
    80001936:	6ceb0b13          	addi	s6,s6,1742 # 80008000 <etext>
    8000193a:	04000937          	lui	s2,0x4000
    8000193e:	197d                	addi	s2,s2,-1
    80001940:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80001942:	69c1                	lui	s3,0x10
    80001944:	18098993          	addi	s3,s3,384 # 10180 <_entry-0x7ffefe80>
    80001948:	00416a97          	auipc	s5,0x416
    8000194c:	d88a8a93          	addi	s5,s5,-632 # 804176d0 <tickslock>
    char *pa = kalloc();
    80001950:	fffff097          	auipc	ra,0xfffff
    80001954:	190080e7          	jalr	400(ra) # 80000ae0 <kalloc>
    80001958:	862a                	mv	a2,a0
    if(pa == 0)
    8000195a:	c131                	beqz	a0,8000199e <proc_mapstacks+0x8e>
    uint64 va = KSTACK((int) (p - proc));
    8000195c:	417485b3          	sub	a1,s1,s7
    80001960:	859d                	srai	a1,a1,0x7
    80001962:	000b3783          	ld	a5,0(s6)
    80001966:	02f585b3          	mul	a1,a1,a5
    8000196a:	2585                	addiw	a1,a1,1
    8000196c:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80001970:	4719                	li	a4,6
    80001972:	6685                	lui	a3,0x1
    80001974:	40b905b3          	sub	a1,s2,a1
    80001978:	8552                	mv	a0,s4
    8000197a:	fffff097          	auipc	ra,0xfffff
    8000197e:	7ba080e7          	jalr	1978(ra) # 80001134 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001982:	94ce                	add	s1,s1,s3
    80001984:	fd5496e3          	bne	s1,s5,80001950 <proc_mapstacks+0x40>
  }
}
    80001988:	60a6                	ld	ra,72(sp)
    8000198a:	6406                	ld	s0,64(sp)
    8000198c:	74e2                	ld	s1,56(sp)
    8000198e:	7942                	ld	s2,48(sp)
    80001990:	79a2                	ld	s3,40(sp)
    80001992:	7a02                	ld	s4,32(sp)
    80001994:	6ae2                	ld	s5,24(sp)
    80001996:	6b42                	ld	s6,16(sp)
    80001998:	6ba2                	ld	s7,8(sp)
    8000199a:	6161                	addi	sp,sp,80
    8000199c:	8082                	ret
      panic("kalloc");
    8000199e:	00007517          	auipc	a0,0x7
    800019a2:	86a50513          	addi	a0,a0,-1942 # 80008208 <digits+0x1c8>
    800019a6:	fffff097          	auipc	ra,0xfffff
    800019aa:	b92080e7          	jalr	-1134(ra) # 80000538 <panic>

00000000800019ae <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    800019ae:	715d                	addi	sp,sp,-80
    800019b0:	e486                	sd	ra,72(sp)
    800019b2:	e0a2                	sd	s0,64(sp)
    800019b4:	fc26                	sd	s1,56(sp)
    800019b6:	f84a                	sd	s2,48(sp)
    800019b8:	f44e                	sd	s3,40(sp)
    800019ba:	f052                	sd	s4,32(sp)
    800019bc:	ec56                	sd	s5,24(sp)
    800019be:	e85a                	sd	s6,16(sp)
    800019c0:	e45e                	sd	s7,8(sp)
    800019c2:	0880                	addi	s0,sp,80
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    800019c4:	00007597          	auipc	a1,0x7
    800019c8:	84c58593          	addi	a1,a1,-1972 # 80008210 <digits+0x1d0>
    800019cc:	00010517          	auipc	a0,0x10
    800019d0:	8d450513          	addi	a0,a0,-1836 # 800112a0 <pid_lock>
    800019d4:	fffff097          	auipc	ra,0xfffff
    800019d8:	16c080e7          	jalr	364(ra) # 80000b40 <initlock>
  initlock(&wait_lock, "wait_lock");
    800019dc:	00007597          	auipc	a1,0x7
    800019e0:	83c58593          	addi	a1,a1,-1988 # 80008218 <digits+0x1d8>
    800019e4:	00010517          	auipc	a0,0x10
    800019e8:	8d450513          	addi	a0,a0,-1836 # 800112b8 <wait_lock>
    800019ec:	fffff097          	auipc	ra,0xfffff
    800019f0:	154080e7          	jalr	340(ra) # 80000b40 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    800019f4:	00010497          	auipc	s1,0x10
    800019f8:	cdc48493          	addi	s1,s1,-804 # 800116d0 <proc>
      initlock(&p->lock, "proc");
    800019fc:	00007b97          	auipc	s7,0x7
    80001a00:	82cb8b93          	addi	s7,s7,-2004 # 80008228 <digits+0x1e8>
      p->kstack = KSTACK((int) (p - proc));
    80001a04:	8b26                	mv	s6,s1
    80001a06:	00006a97          	auipc	s5,0x6
    80001a0a:	5faa8a93          	addi	s5,s5,1530 # 80008000 <etext>
    80001a0e:	04000937          	lui	s2,0x4000
    80001a12:	197d                	addi	s2,s2,-1
    80001a14:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80001a16:	69c1                	lui	s3,0x10
    80001a18:	18098993          	addi	s3,s3,384 # 10180 <_entry-0x7ffefe80>
    80001a1c:	00416a17          	auipc	s4,0x416
    80001a20:	cb4a0a13          	addi	s4,s4,-844 # 804176d0 <tickslock>
      initlock(&p->lock, "proc");
    80001a24:	85de                	mv	a1,s7
    80001a26:	8526                	mv	a0,s1
    80001a28:	fffff097          	auipc	ra,0xfffff
    80001a2c:	118080e7          	jalr	280(ra) # 80000b40 <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80001a30:	416487b3          	sub	a5,s1,s6
    80001a34:	879d                	srai	a5,a5,0x7
    80001a36:	000ab703          	ld	a4,0(s5)
    80001a3a:	02e787b3          	mul	a5,a5,a4
    80001a3e:	2785                	addiw	a5,a5,1
    80001a40:	00d7979b          	slliw	a5,a5,0xd
    80001a44:	40f907b3          	sub	a5,s2,a5
    80001a48:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80001a4a:	94ce                	add	s1,s1,s3
    80001a4c:	fd449ce3          	bne	s1,s4,80001a24 <procinit+0x76>
  }
}
    80001a50:	60a6                	ld	ra,72(sp)
    80001a52:	6406                	ld	s0,64(sp)
    80001a54:	74e2                	ld	s1,56(sp)
    80001a56:	7942                	ld	s2,48(sp)
    80001a58:	79a2                	ld	s3,40(sp)
    80001a5a:	7a02                	ld	s4,32(sp)
    80001a5c:	6ae2                	ld	s5,24(sp)
    80001a5e:	6b42                	ld	s6,16(sp)
    80001a60:	6ba2                	ld	s7,8(sp)
    80001a62:	6161                	addi	sp,sp,80
    80001a64:	8082                	ret

0000000080001a66 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80001a66:	1141                	addi	sp,sp,-16
    80001a68:	e422                	sd	s0,8(sp)
    80001a6a:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80001a6c:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80001a6e:	2501                	sext.w	a0,a0
    80001a70:	6422                	ld	s0,8(sp)
    80001a72:	0141                	addi	sp,sp,16
    80001a74:	8082                	ret

0000000080001a76 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    80001a76:	1141                	addi	sp,sp,-16
    80001a78:	e422                	sd	s0,8(sp)
    80001a7a:	0800                	addi	s0,sp,16
    80001a7c:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80001a7e:	2781                	sext.w	a5,a5
    80001a80:	079e                	slli	a5,a5,0x7
  return c;
}
    80001a82:	00010517          	auipc	a0,0x10
    80001a86:	84e50513          	addi	a0,a0,-1970 # 800112d0 <cpus>
    80001a8a:	953e                	add	a0,a0,a5
    80001a8c:	6422                	ld	s0,8(sp)
    80001a8e:	0141                	addi	sp,sp,16
    80001a90:	8082                	ret

0000000080001a92 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80001a92:	1101                	addi	sp,sp,-32
    80001a94:	ec06                	sd	ra,24(sp)
    80001a96:	e822                	sd	s0,16(sp)
    80001a98:	e426                	sd	s1,8(sp)
    80001a9a:	1000                	addi	s0,sp,32
  push_off();
    80001a9c:	fffff097          	auipc	ra,0xfffff
    80001aa0:	0e8080e7          	jalr	232(ra) # 80000b84 <push_off>
    80001aa4:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80001aa6:	2781                	sext.w	a5,a5
    80001aa8:	079e                	slli	a5,a5,0x7
    80001aaa:	0000f717          	auipc	a4,0xf
    80001aae:	7f670713          	addi	a4,a4,2038 # 800112a0 <pid_lock>
    80001ab2:	97ba                	add	a5,a5,a4
    80001ab4:	7b84                	ld	s1,48(a5)
  pop_off();
    80001ab6:	fffff097          	auipc	ra,0xfffff
    80001aba:	16e080e7          	jalr	366(ra) # 80000c24 <pop_off>
  return p;
}
    80001abe:	8526                	mv	a0,s1
    80001ac0:	60e2                	ld	ra,24(sp)
    80001ac2:	6442                	ld	s0,16(sp)
    80001ac4:	64a2                	ld	s1,8(sp)
    80001ac6:	6105                	addi	sp,sp,32
    80001ac8:	8082                	ret

0000000080001aca <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80001aca:	1141                	addi	sp,sp,-16
    80001acc:	e406                	sd	ra,8(sp)
    80001ace:	e022                	sd	s0,0(sp)
    80001ad0:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80001ad2:	00000097          	auipc	ra,0x0
    80001ad6:	fc0080e7          	jalr	-64(ra) # 80001a92 <myproc>
    80001ada:	fffff097          	auipc	ra,0xfffff
    80001ade:	1aa080e7          	jalr	426(ra) # 80000c84 <release>

  if (first) {
    80001ae2:	00007797          	auipc	a5,0x7
    80001ae6:	dbe7a783          	lw	a5,-578(a5) # 800088a0 <first.1>
    80001aea:	eb89                	bnez	a5,80001afc <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80001aec:	00001097          	auipc	ra,0x1
    80001af0:	f24080e7          	jalr	-220(ra) # 80002a10 <usertrapret>
}
    80001af4:	60a2                	ld	ra,8(sp)
    80001af6:	6402                	ld	s0,0(sp)
    80001af8:	0141                	addi	sp,sp,16
    80001afa:	8082                	ret
    first = 0;
    80001afc:	00007797          	auipc	a5,0x7
    80001b00:	da07a223          	sw	zero,-604(a5) # 800088a0 <first.1>
    fsinit(ROOTDEV);
    80001b04:	4505                	li	a0,1
    80001b06:	00002097          	auipc	ra,0x2
    80001b0a:	ce0080e7          	jalr	-800(ra) # 800037e6 <fsinit>
    80001b0e:	bff9                	j	80001aec <forkret+0x22>

0000000080001b10 <allocpid>:
allocpid() {
    80001b10:	1101                	addi	sp,sp,-32
    80001b12:	ec06                	sd	ra,24(sp)
    80001b14:	e822                	sd	s0,16(sp)
    80001b16:	e426                	sd	s1,8(sp)
    80001b18:	e04a                	sd	s2,0(sp)
    80001b1a:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80001b1c:	0000f917          	auipc	s2,0xf
    80001b20:	78490913          	addi	s2,s2,1924 # 800112a0 <pid_lock>
    80001b24:	854a                	mv	a0,s2
    80001b26:	fffff097          	auipc	ra,0xfffff
    80001b2a:	0aa080e7          	jalr	170(ra) # 80000bd0 <acquire>
  pid = nextpid;
    80001b2e:	00007797          	auipc	a5,0x7
    80001b32:	d7678793          	addi	a5,a5,-650 # 800088a4 <nextpid>
    80001b36:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80001b38:	0014871b          	addiw	a4,s1,1
    80001b3c:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80001b3e:	854a                	mv	a0,s2
    80001b40:	fffff097          	auipc	ra,0xfffff
    80001b44:	144080e7          	jalr	324(ra) # 80000c84 <release>
}
    80001b48:	8526                	mv	a0,s1
    80001b4a:	60e2                	ld	ra,24(sp)
    80001b4c:	6442                	ld	s0,16(sp)
    80001b4e:	64a2                	ld	s1,8(sp)
    80001b50:	6902                	ld	s2,0(sp)
    80001b52:	6105                	addi	sp,sp,32
    80001b54:	8082                	ret

0000000080001b56 <proc_pagetable>:
{
    80001b56:	1101                	addi	sp,sp,-32
    80001b58:	ec06                	sd	ra,24(sp)
    80001b5a:	e822                	sd	s0,16(sp)
    80001b5c:	e426                	sd	s1,8(sp)
    80001b5e:	e04a                	sd	s2,0(sp)
    80001b60:	1000                	addi	s0,sp,32
    80001b62:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001b64:	fffff097          	auipc	ra,0xfffff
    80001b68:	7ba080e7          	jalr	1978(ra) # 8000131e <uvmcreate>
    80001b6c:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001b6e:	c121                	beqz	a0,80001bae <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80001b70:	4729                	li	a4,10
    80001b72:	00005697          	auipc	a3,0x5
    80001b76:	48e68693          	addi	a3,a3,1166 # 80007000 <_trampoline>
    80001b7a:	6605                	lui	a2,0x1
    80001b7c:	040005b7          	lui	a1,0x4000
    80001b80:	15fd                	addi	a1,a1,-1
    80001b82:	05b2                	slli	a1,a1,0xc
    80001b84:	fffff097          	auipc	ra,0xfffff
    80001b88:	510080e7          	jalr	1296(ra) # 80001094 <mappages>
    80001b8c:	02054863          	bltz	a0,80001bbc <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80001b90:	4719                	li	a4,6
    80001b92:	05893683          	ld	a3,88(s2)
    80001b96:	6605                	lui	a2,0x1
    80001b98:	020005b7          	lui	a1,0x2000
    80001b9c:	15fd                	addi	a1,a1,-1
    80001b9e:	05b6                	slli	a1,a1,0xd
    80001ba0:	8526                	mv	a0,s1
    80001ba2:	fffff097          	auipc	ra,0xfffff
    80001ba6:	4f2080e7          	jalr	1266(ra) # 80001094 <mappages>
    80001baa:	02054163          	bltz	a0,80001bcc <proc_pagetable+0x76>
}
    80001bae:	8526                	mv	a0,s1
    80001bb0:	60e2                	ld	ra,24(sp)
    80001bb2:	6442                	ld	s0,16(sp)
    80001bb4:	64a2                	ld	s1,8(sp)
    80001bb6:	6902                	ld	s2,0(sp)
    80001bb8:	6105                	addi	sp,sp,32
    80001bba:	8082                	ret
    uvmfree(pagetable, 0);
    80001bbc:	4581                	li	a1,0
    80001bbe:	8526                	mv	a0,s1
    80001bc0:	00000097          	auipc	ra,0x0
    80001bc4:	95a080e7          	jalr	-1702(ra) # 8000151a <uvmfree>
    return 0;
    80001bc8:	4481                	li	s1,0
    80001bca:	b7d5                	j	80001bae <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001bcc:	4681                	li	a3,0
    80001bce:	4605                	li	a2,1
    80001bd0:	040005b7          	lui	a1,0x4000
    80001bd4:	15fd                	addi	a1,a1,-1
    80001bd6:	05b2                	slli	a1,a1,0xc
    80001bd8:	8526                	mv	a0,s1
    80001bda:	fffff097          	auipc	ra,0xfffff
    80001bde:	680080e7          	jalr	1664(ra) # 8000125a <uvmunmap>
    uvmfree(pagetable, 0);
    80001be2:	4581                	li	a1,0
    80001be4:	8526                	mv	a0,s1
    80001be6:	00000097          	auipc	ra,0x0
    80001bea:	934080e7          	jalr	-1740(ra) # 8000151a <uvmfree>
    return 0;
    80001bee:	4481                	li	s1,0
    80001bf0:	bf7d                	j	80001bae <proc_pagetable+0x58>

0000000080001bf2 <proc_freepagetable>:
{
    80001bf2:	1101                	addi	sp,sp,-32
    80001bf4:	ec06                	sd	ra,24(sp)
    80001bf6:	e822                	sd	s0,16(sp)
    80001bf8:	e426                	sd	s1,8(sp)
    80001bfa:	e04a                	sd	s2,0(sp)
    80001bfc:	1000                	addi	s0,sp,32
    80001bfe:	84aa                	mv	s1,a0
    80001c00:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001c02:	4681                	li	a3,0
    80001c04:	4605                	li	a2,1
    80001c06:	040005b7          	lui	a1,0x4000
    80001c0a:	15fd                	addi	a1,a1,-1
    80001c0c:	05b2                	slli	a1,a1,0xc
    80001c0e:	fffff097          	auipc	ra,0xfffff
    80001c12:	64c080e7          	jalr	1612(ra) # 8000125a <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001c16:	4681                	li	a3,0
    80001c18:	4605                	li	a2,1
    80001c1a:	020005b7          	lui	a1,0x2000
    80001c1e:	15fd                	addi	a1,a1,-1
    80001c20:	05b6                	slli	a1,a1,0xd
    80001c22:	8526                	mv	a0,s1
    80001c24:	fffff097          	auipc	ra,0xfffff
    80001c28:	636080e7          	jalr	1590(ra) # 8000125a <uvmunmap>
  uvmfree(pagetable, sz);
    80001c2c:	85ca                	mv	a1,s2
    80001c2e:	8526                	mv	a0,s1
    80001c30:	00000097          	auipc	ra,0x0
    80001c34:	8ea080e7          	jalr	-1814(ra) # 8000151a <uvmfree>
}
    80001c38:	60e2                	ld	ra,24(sp)
    80001c3a:	6442                	ld	s0,16(sp)
    80001c3c:	64a2                	ld	s1,8(sp)
    80001c3e:	6902                	ld	s2,0(sp)
    80001c40:	6105                	addi	sp,sp,32
    80001c42:	8082                	ret

0000000080001c44 <freeproc>:
{
    80001c44:	1101                	addi	sp,sp,-32
    80001c46:	ec06                	sd	ra,24(sp)
    80001c48:	e822                	sd	s0,16(sp)
    80001c4a:	e426                	sd	s1,8(sp)
    80001c4c:	1000                	addi	s0,sp,32
    80001c4e:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001c50:	6d28                	ld	a0,88(a0)
    80001c52:	c509                	beqz	a0,80001c5c <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001c54:	fffff097          	auipc	ra,0xfffff
    80001c58:	d90080e7          	jalr	-624(ra) # 800009e4 <kfree>
  p->trapframe = 0;
    80001c5c:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80001c60:	68a8                	ld	a0,80(s1)
    80001c62:	c511                	beqz	a0,80001c6e <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001c64:	64ac                	ld	a1,72(s1)
    80001c66:	00000097          	auipc	ra,0x0
    80001c6a:	f8c080e7          	jalr	-116(ra) # 80001bf2 <proc_freepagetable>
  p->pagetable = 0;
    80001c6e:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001c72:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001c76:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001c7a:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80001c7e:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001c82:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001c86:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001c8a:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001c8e:	0004ac23          	sw	zero,24(s1)
}
    80001c92:	60e2                	ld	ra,24(sp)
    80001c94:	6442                	ld	s0,16(sp)
    80001c96:	64a2                	ld	s1,8(sp)
    80001c98:	6105                	addi	sp,sp,32
    80001c9a:	8082                	ret

0000000080001c9c <allocproc>:
{
    80001c9c:	7179                	addi	sp,sp,-48
    80001c9e:	f406                	sd	ra,40(sp)
    80001ca0:	f022                	sd	s0,32(sp)
    80001ca2:	ec26                	sd	s1,24(sp)
    80001ca4:	e84a                	sd	s2,16(sp)
    80001ca6:	e44e                	sd	s3,8(sp)
    80001ca8:	1800                	addi	s0,sp,48
  for(p = proc; p < &proc[NPROC]; p++) {
    80001caa:	00010497          	auipc	s1,0x10
    80001cae:	a2648493          	addi	s1,s1,-1498 # 800116d0 <proc>
    80001cb2:	6941                	lui	s2,0x10
    80001cb4:	18090913          	addi	s2,s2,384 # 10180 <_entry-0x7ffefe80>
    80001cb8:	00416997          	auipc	s3,0x416
    80001cbc:	a1898993          	addi	s3,s3,-1512 # 804176d0 <tickslock>
    acquire(&p->lock);
    80001cc0:	8526                	mv	a0,s1
    80001cc2:	fffff097          	auipc	ra,0xfffff
    80001cc6:	f0e080e7          	jalr	-242(ra) # 80000bd0 <acquire>
    if(p->state == UNUSED) {
    80001cca:	4c9c                	lw	a5,24(s1)
    80001ccc:	cb99                	beqz	a5,80001ce2 <allocproc+0x46>
      release(&p->lock);
    80001cce:	8526                	mv	a0,s1
    80001cd0:	fffff097          	auipc	ra,0xfffff
    80001cd4:	fb4080e7          	jalr	-76(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001cd8:	94ca                	add	s1,s1,s2
    80001cda:	ff3493e3          	bne	s1,s3,80001cc0 <allocproc+0x24>
  return 0;
    80001cde:	4481                	li	s1,0
    80001ce0:	a08d                	j	80001d42 <allocproc+0xa6>
  p->pid = allocpid();
    80001ce2:	00000097          	auipc	ra,0x0
    80001ce6:	e2e080e7          	jalr	-466(ra) # 80001b10 <allocpid>
    80001cea:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001cec:	4705                	li	a4,1
    80001cee:	cc98                	sw	a4,24(s1)
  p->bottom_ustack = 0;
    80001cf0:	1604b823          	sd	zero,368(s1)
  p->top_ustack = 0;
    80001cf4:	1604b423          	sd	zero,360(s1)
  p->referencias = 1;
    80001cf8:	67c1                	lui	a5,0x10
    80001cfa:	97a6                	add	a5,a5,s1
    80001cfc:	16e7ac23          	sw	a4,376(a5) # 10178 <_entry-0x7ffefe88>
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001d00:	fffff097          	auipc	ra,0xfffff
    80001d04:	de0080e7          	jalr	-544(ra) # 80000ae0 <kalloc>
    80001d08:	892a                	mv	s2,a0
    80001d0a:	eca8                	sd	a0,88(s1)
    80001d0c:	c139                	beqz	a0,80001d52 <allocproc+0xb6>
  p->pagetable = proc_pagetable(p);
    80001d0e:	8526                	mv	a0,s1
    80001d10:	00000097          	auipc	ra,0x0
    80001d14:	e46080e7          	jalr	-442(ra) # 80001b56 <proc_pagetable>
    80001d18:	892a                	mv	s2,a0
    80001d1a:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    80001d1c:	c539                	beqz	a0,80001d6a <allocproc+0xce>
  memset(&p->context, 0, sizeof(p->context));
    80001d1e:	07000613          	li	a2,112
    80001d22:	4581                	li	a1,0
    80001d24:	06048513          	addi	a0,s1,96
    80001d28:	fffff097          	auipc	ra,0xfffff
    80001d2c:	fa4080e7          	jalr	-92(ra) # 80000ccc <memset>
  p->context.ra = (uint64)forkret;
    80001d30:	00000797          	auipc	a5,0x0
    80001d34:	d9a78793          	addi	a5,a5,-614 # 80001aca <forkret>
    80001d38:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001d3a:	60bc                	ld	a5,64(s1)
    80001d3c:	6705                	lui	a4,0x1
    80001d3e:	97ba                	add	a5,a5,a4
    80001d40:	f4bc                	sd	a5,104(s1)
}
    80001d42:	8526                	mv	a0,s1
    80001d44:	70a2                	ld	ra,40(sp)
    80001d46:	7402                	ld	s0,32(sp)
    80001d48:	64e2                	ld	s1,24(sp)
    80001d4a:	6942                	ld	s2,16(sp)
    80001d4c:	69a2                	ld	s3,8(sp)
    80001d4e:	6145                	addi	sp,sp,48
    80001d50:	8082                	ret
    freeproc(p);
    80001d52:	8526                	mv	a0,s1
    80001d54:	00000097          	auipc	ra,0x0
    80001d58:	ef0080e7          	jalr	-272(ra) # 80001c44 <freeproc>
    release(&p->lock);
    80001d5c:	8526                	mv	a0,s1
    80001d5e:	fffff097          	auipc	ra,0xfffff
    80001d62:	f26080e7          	jalr	-218(ra) # 80000c84 <release>
    return 0;
    80001d66:	84ca                	mv	s1,s2
    80001d68:	bfe9                	j	80001d42 <allocproc+0xa6>
    freeproc(p);
    80001d6a:	8526                	mv	a0,s1
    80001d6c:	00000097          	auipc	ra,0x0
    80001d70:	ed8080e7          	jalr	-296(ra) # 80001c44 <freeproc>
    release(&p->lock);
    80001d74:	8526                	mv	a0,s1
    80001d76:	fffff097          	auipc	ra,0xfffff
    80001d7a:	f0e080e7          	jalr	-242(ra) # 80000c84 <release>
    return 0;
    80001d7e:	84ca                	mv	s1,s2
    80001d80:	b7c9                	j	80001d42 <allocproc+0xa6>

0000000080001d82 <userinit>:
{
    80001d82:	1101                	addi	sp,sp,-32
    80001d84:	ec06                	sd	ra,24(sp)
    80001d86:	e822                	sd	s0,16(sp)
    80001d88:	e426                	sd	s1,8(sp)
    80001d8a:	1000                	addi	s0,sp,32
  p = allocproc();
    80001d8c:	00000097          	auipc	ra,0x0
    80001d90:	f10080e7          	jalr	-240(ra) # 80001c9c <allocproc>
    80001d94:	84aa                	mv	s1,a0
  initproc = p;
    80001d96:	00007797          	auipc	a5,0x7
    80001d9a:	28a7b923          	sd	a0,658(a5) # 80009028 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80001d9e:	03400613          	li	a2,52
    80001da2:	00007597          	auipc	a1,0x7
    80001da6:	b0e58593          	addi	a1,a1,-1266 # 800088b0 <initcode>
    80001daa:	6928                	ld	a0,80(a0)
    80001dac:	fffff097          	auipc	ra,0xfffff
    80001db0:	5a0080e7          	jalr	1440(ra) # 8000134c <uvminit>
  p->sz = PGSIZE;
    80001db4:	6785                	lui	a5,0x1
    80001db6:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001db8:	6cb8                	ld	a4,88(s1)
    80001dba:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001dbe:	6cb8                	ld	a4,88(s1)
    80001dc0:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001dc2:	4641                	li	a2,16
    80001dc4:	00006597          	auipc	a1,0x6
    80001dc8:	46c58593          	addi	a1,a1,1132 # 80008230 <digits+0x1f0>
    80001dcc:	15848513          	addi	a0,s1,344
    80001dd0:	fffff097          	auipc	ra,0xfffff
    80001dd4:	046080e7          	jalr	70(ra) # 80000e16 <safestrcpy>
  p->cwd = namei("/");
    80001dd8:	00006517          	auipc	a0,0x6
    80001ddc:	46850513          	addi	a0,a0,1128 # 80008240 <digits+0x200>
    80001de0:	00002097          	auipc	ra,0x2
    80001de4:	434080e7          	jalr	1076(ra) # 80004214 <namei>
    80001de8:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001dec:	478d                	li	a5,3
    80001dee:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001df0:	8526                	mv	a0,s1
    80001df2:	fffff097          	auipc	ra,0xfffff
    80001df6:	e92080e7          	jalr	-366(ra) # 80000c84 <release>
}
    80001dfa:	60e2                	ld	ra,24(sp)
    80001dfc:	6442                	ld	s0,16(sp)
    80001dfe:	64a2                	ld	s1,8(sp)
    80001e00:	6105                	addi	sp,sp,32
    80001e02:	8082                	ret

0000000080001e04 <growproc>:
{
    80001e04:	1101                	addi	sp,sp,-32
    80001e06:	ec06                	sd	ra,24(sp)
    80001e08:	e822                	sd	s0,16(sp)
    80001e0a:	e426                	sd	s1,8(sp)
    80001e0c:	e04a                	sd	s2,0(sp)
    80001e0e:	1000                	addi	s0,sp,32
    80001e10:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001e12:	00000097          	auipc	ra,0x0
    80001e16:	c80080e7          	jalr	-896(ra) # 80001a92 <myproc>
    80001e1a:	892a                	mv	s2,a0
  sz = p->sz;
    80001e1c:	652c                	ld	a1,72(a0)
    80001e1e:	0005861b          	sext.w	a2,a1
  if(n > 0){
    80001e22:	00904f63          	bgtz	s1,80001e40 <growproc+0x3c>
  } else if(n < 0){
    80001e26:	0204cc63          	bltz	s1,80001e5e <growproc+0x5a>
  p->sz = sz;
    80001e2a:	1602                	slli	a2,a2,0x20
    80001e2c:	9201                	srli	a2,a2,0x20
    80001e2e:	04c93423          	sd	a2,72(s2)
  return 0;
    80001e32:	4501                	li	a0,0
}
    80001e34:	60e2                	ld	ra,24(sp)
    80001e36:	6442                	ld	s0,16(sp)
    80001e38:	64a2                	ld	s1,8(sp)
    80001e3a:	6902                	ld	s2,0(sp)
    80001e3c:	6105                	addi	sp,sp,32
    80001e3e:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80001e40:	9e25                	addw	a2,a2,s1
    80001e42:	1602                	slli	a2,a2,0x20
    80001e44:	9201                	srli	a2,a2,0x20
    80001e46:	1582                	slli	a1,a1,0x20
    80001e48:	9181                	srli	a1,a1,0x20
    80001e4a:	6928                	ld	a0,80(a0)
    80001e4c:	fffff097          	auipc	ra,0xfffff
    80001e50:	5ba080e7          	jalr	1466(ra) # 80001406 <uvmalloc>
    80001e54:	0005061b          	sext.w	a2,a0
    80001e58:	fa69                	bnez	a2,80001e2a <growproc+0x26>
      return -1;
    80001e5a:	557d                	li	a0,-1
    80001e5c:	bfe1                	j	80001e34 <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001e5e:	9e25                	addw	a2,a2,s1
    80001e60:	1602                	slli	a2,a2,0x20
    80001e62:	9201                	srli	a2,a2,0x20
    80001e64:	1582                	slli	a1,a1,0x20
    80001e66:	9181                	srli	a1,a1,0x20
    80001e68:	6928                	ld	a0,80(a0)
    80001e6a:	fffff097          	auipc	ra,0xfffff
    80001e6e:	554080e7          	jalr	1364(ra) # 800013be <uvmdealloc>
    80001e72:	0005061b          	sext.w	a2,a0
    80001e76:	bf55                	j	80001e2a <growproc+0x26>

0000000080001e78 <fork>:
{
    80001e78:	7139                	addi	sp,sp,-64
    80001e7a:	fc06                	sd	ra,56(sp)
    80001e7c:	f822                	sd	s0,48(sp)
    80001e7e:	f426                	sd	s1,40(sp)
    80001e80:	f04a                	sd	s2,32(sp)
    80001e82:	ec4e                	sd	s3,24(sp)
    80001e84:	e852                	sd	s4,16(sp)
    80001e86:	e456                	sd	s5,8(sp)
    80001e88:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001e8a:	00000097          	auipc	ra,0x0
    80001e8e:	c08080e7          	jalr	-1016(ra) # 80001a92 <myproc>
    80001e92:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001e94:	00000097          	auipc	ra,0x0
    80001e98:	e08080e7          	jalr	-504(ra) # 80001c9c <allocproc>
    80001e9c:	10050c63          	beqz	a0,80001fb4 <fork+0x13c>
    80001ea0:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001ea2:	048ab603          	ld	a2,72(s5)
    80001ea6:	692c                	ld	a1,80(a0)
    80001ea8:	050ab503          	ld	a0,80(s5)
    80001eac:	fffff097          	auipc	ra,0xfffff
    80001eb0:	6a6080e7          	jalr	1702(ra) # 80001552 <uvmcopy>
    80001eb4:	04054863          	bltz	a0,80001f04 <fork+0x8c>
  np->sz = p->sz;
    80001eb8:	048ab783          	ld	a5,72(s5)
    80001ebc:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    80001ec0:	058ab683          	ld	a3,88(s5)
    80001ec4:	87b6                	mv	a5,a3
    80001ec6:	058a3703          	ld	a4,88(s4)
    80001eca:	12068693          	addi	a3,a3,288
    80001ece:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001ed2:	6788                	ld	a0,8(a5)
    80001ed4:	6b8c                	ld	a1,16(a5)
    80001ed6:	6f90                	ld	a2,24(a5)
    80001ed8:	01073023          	sd	a6,0(a4)
    80001edc:	e708                	sd	a0,8(a4)
    80001ede:	eb0c                	sd	a1,16(a4)
    80001ee0:	ef10                	sd	a2,24(a4)
    80001ee2:	02078793          	addi	a5,a5,32
    80001ee6:	02070713          	addi	a4,a4,32
    80001eea:	fed792e3          	bne	a5,a3,80001ece <fork+0x56>
  np->trapframe->a0 = 0;
    80001eee:	058a3783          	ld	a5,88(s4)
    80001ef2:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001ef6:	0d0a8493          	addi	s1,s5,208
    80001efa:	0d0a0913          	addi	s2,s4,208
    80001efe:	150a8993          	addi	s3,s5,336
    80001f02:	a00d                	j	80001f24 <fork+0xac>
    freeproc(np);
    80001f04:	8552                	mv	a0,s4
    80001f06:	00000097          	auipc	ra,0x0
    80001f0a:	d3e080e7          	jalr	-706(ra) # 80001c44 <freeproc>
    release(&np->lock);
    80001f0e:	8552                	mv	a0,s4
    80001f10:	fffff097          	auipc	ra,0xfffff
    80001f14:	d74080e7          	jalr	-652(ra) # 80000c84 <release>
    return -1;
    80001f18:	597d                	li	s2,-1
    80001f1a:	a059                	j	80001fa0 <fork+0x128>
  for(i = 0; i < NOFILE; i++)
    80001f1c:	04a1                	addi	s1,s1,8
    80001f1e:	0921                	addi	s2,s2,8
    80001f20:	01348b63          	beq	s1,s3,80001f36 <fork+0xbe>
    if(p->ofile[i])
    80001f24:	6088                	ld	a0,0(s1)
    80001f26:	d97d                	beqz	a0,80001f1c <fork+0xa4>
      np->ofile[i] = filedup(p->ofile[i]);
    80001f28:	00003097          	auipc	ra,0x3
    80001f2c:	982080e7          	jalr	-1662(ra) # 800048aa <filedup>
    80001f30:	00a93023          	sd	a0,0(s2)
    80001f34:	b7e5                	j	80001f1c <fork+0xa4>
  np->cwd = idup(p->cwd);
    80001f36:	150ab503          	ld	a0,336(s5)
    80001f3a:	00002097          	auipc	ra,0x2
    80001f3e:	ae6080e7          	jalr	-1306(ra) # 80003a20 <idup>
    80001f42:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001f46:	4641                	li	a2,16
    80001f48:	158a8593          	addi	a1,s5,344
    80001f4c:	158a0513          	addi	a0,s4,344
    80001f50:	fffff097          	auipc	ra,0xfffff
    80001f54:	ec6080e7          	jalr	-314(ra) # 80000e16 <safestrcpy>
  pid = np->pid;
    80001f58:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    80001f5c:	8552                	mv	a0,s4
    80001f5e:	fffff097          	auipc	ra,0xfffff
    80001f62:	d26080e7          	jalr	-730(ra) # 80000c84 <release>
  acquire(&wait_lock);
    80001f66:	0000f497          	auipc	s1,0xf
    80001f6a:	35248493          	addi	s1,s1,850 # 800112b8 <wait_lock>
    80001f6e:	8526                	mv	a0,s1
    80001f70:	fffff097          	auipc	ra,0xfffff
    80001f74:	c60080e7          	jalr	-928(ra) # 80000bd0 <acquire>
  np->parent = p;
    80001f78:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001f7c:	8526                	mv	a0,s1
    80001f7e:	fffff097          	auipc	ra,0xfffff
    80001f82:	d06080e7          	jalr	-762(ra) # 80000c84 <release>
  acquire(&np->lock);
    80001f86:	8552                	mv	a0,s4
    80001f88:	fffff097          	auipc	ra,0xfffff
    80001f8c:	c48080e7          	jalr	-952(ra) # 80000bd0 <acquire>
  np->state = RUNNABLE;
    80001f90:	478d                	li	a5,3
    80001f92:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001f96:	8552                	mv	a0,s4
    80001f98:	fffff097          	auipc	ra,0xfffff
    80001f9c:	cec080e7          	jalr	-788(ra) # 80000c84 <release>
}
    80001fa0:	854a                	mv	a0,s2
    80001fa2:	70e2                	ld	ra,56(sp)
    80001fa4:	7442                	ld	s0,48(sp)
    80001fa6:	74a2                	ld	s1,40(sp)
    80001fa8:	7902                	ld	s2,32(sp)
    80001faa:	69e2                	ld	s3,24(sp)
    80001fac:	6a42                	ld	s4,16(sp)
    80001fae:	6aa2                	ld	s5,8(sp)
    80001fb0:	6121                	addi	sp,sp,64
    80001fb2:	8082                	ret
    return -1;
    80001fb4:	597d                	li	s2,-1
    80001fb6:	b7ed                	j	80001fa0 <fork+0x128>

0000000080001fb8 <scheduler>:
{
    80001fb8:	715d                	addi	sp,sp,-80
    80001fba:	e486                	sd	ra,72(sp)
    80001fbc:	e0a2                	sd	s0,64(sp)
    80001fbe:	fc26                	sd	s1,56(sp)
    80001fc0:	f84a                	sd	s2,48(sp)
    80001fc2:	f44e                	sd	s3,40(sp)
    80001fc4:	f052                	sd	s4,32(sp)
    80001fc6:	ec56                	sd	s5,24(sp)
    80001fc8:	e85a                	sd	s6,16(sp)
    80001fca:	e45e                	sd	s7,8(sp)
    80001fcc:	0880                	addi	s0,sp,80
    80001fce:	8792                	mv	a5,tp
  int id = r_tp();
    80001fd0:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001fd2:	00779b13          	slli	s6,a5,0x7
    80001fd6:	0000f717          	auipc	a4,0xf
    80001fda:	2ca70713          	addi	a4,a4,714 # 800112a0 <pid_lock>
    80001fde:	975a                	add	a4,a4,s6
    80001fe0:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001fe4:	0000f717          	auipc	a4,0xf
    80001fe8:	2f470713          	addi	a4,a4,756 # 800112d8 <cpus+0x8>
    80001fec:	9b3a                	add	s6,s6,a4
        p->state = RUNNING;
    80001fee:	4b91                	li	s7,4
        c->proc = p;
    80001ff0:	079e                	slli	a5,a5,0x7
    80001ff2:	0000fa97          	auipc	s5,0xf
    80001ff6:	2aea8a93          	addi	s5,s5,686 # 800112a0 <pid_lock>
    80001ffa:	9abe                	add	s5,s5,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001ffc:	69c1                	lui	s3,0x10
    80001ffe:	18098993          	addi	s3,s3,384 # 10180 <_entry-0x7ffefe80>
    80002002:	00415a17          	auipc	s4,0x415
    80002006:	6cea0a13          	addi	s4,s4,1742 # 804176d0 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000200a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000200e:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002012:	10079073          	csrw	sstatus,a5
    80002016:	0000f497          	auipc	s1,0xf
    8000201a:	6ba48493          	addi	s1,s1,1722 # 800116d0 <proc>
      if(p->state == RUNNABLE) {
    8000201e:	490d                	li	s2,3
    80002020:	a809                	j	80002032 <scheduler+0x7a>
      release(&p->lock);
    80002022:	8526                	mv	a0,s1
    80002024:	fffff097          	auipc	ra,0xfffff
    80002028:	c60080e7          	jalr	-928(ra) # 80000c84 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    8000202c:	94ce                	add	s1,s1,s3
    8000202e:	fd448ee3          	beq	s1,s4,8000200a <scheduler+0x52>
      acquire(&p->lock);
    80002032:	8526                	mv	a0,s1
    80002034:	fffff097          	auipc	ra,0xfffff
    80002038:	b9c080e7          	jalr	-1124(ra) # 80000bd0 <acquire>
      if(p->state == RUNNABLE) {
    8000203c:	4c9c                	lw	a5,24(s1)
    8000203e:	ff2792e3          	bne	a5,s2,80002022 <scheduler+0x6a>
        p->state = RUNNING;
    80002042:	0174ac23          	sw	s7,24(s1)
        c->proc = p;
    80002046:	029ab823          	sd	s1,48(s5)
        swtch(&c->context, &p->context);
    8000204a:	06048593          	addi	a1,s1,96
    8000204e:	855a                	mv	a0,s6
    80002050:	00001097          	auipc	ra,0x1
    80002054:	916080e7          	jalr	-1770(ra) # 80002966 <swtch>
        c->proc = 0;
    80002058:	020ab823          	sd	zero,48(s5)
    8000205c:	b7d9                	j	80002022 <scheduler+0x6a>

000000008000205e <sched>:
{
    8000205e:	7179                	addi	sp,sp,-48
    80002060:	f406                	sd	ra,40(sp)
    80002062:	f022                	sd	s0,32(sp)
    80002064:	ec26                	sd	s1,24(sp)
    80002066:	e84a                	sd	s2,16(sp)
    80002068:	e44e                	sd	s3,8(sp)
    8000206a:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    8000206c:	00000097          	auipc	ra,0x0
    80002070:	a26080e7          	jalr	-1498(ra) # 80001a92 <myproc>
    80002074:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80002076:	fffff097          	auipc	ra,0xfffff
    8000207a:	ae0080e7          	jalr	-1312(ra) # 80000b56 <holding>
    8000207e:	c93d                	beqz	a0,800020f4 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80002080:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80002082:	2781                	sext.w	a5,a5
    80002084:	079e                	slli	a5,a5,0x7
    80002086:	0000f717          	auipc	a4,0xf
    8000208a:	21a70713          	addi	a4,a4,538 # 800112a0 <pid_lock>
    8000208e:	97ba                	add	a5,a5,a4
    80002090:	0a87a703          	lw	a4,168(a5)
    80002094:	4785                	li	a5,1
    80002096:	06f71763          	bne	a4,a5,80002104 <sched+0xa6>
  if(p->state == RUNNING)
    8000209a:	4c98                	lw	a4,24(s1)
    8000209c:	4791                	li	a5,4
    8000209e:	06f70b63          	beq	a4,a5,80002114 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800020a2:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800020a6:	8b89                	andi	a5,a5,2
  if(intr_get())
    800020a8:	efb5                	bnez	a5,80002124 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    800020aa:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800020ac:	0000f917          	auipc	s2,0xf
    800020b0:	1f490913          	addi	s2,s2,500 # 800112a0 <pid_lock>
    800020b4:	2781                	sext.w	a5,a5
    800020b6:	079e                	slli	a5,a5,0x7
    800020b8:	97ca                	add	a5,a5,s2
    800020ba:	0ac7a983          	lw	s3,172(a5)
    800020be:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800020c0:	2781                	sext.w	a5,a5
    800020c2:	079e                	slli	a5,a5,0x7
    800020c4:	0000f597          	auipc	a1,0xf
    800020c8:	21458593          	addi	a1,a1,532 # 800112d8 <cpus+0x8>
    800020cc:	95be                	add	a1,a1,a5
    800020ce:	06048513          	addi	a0,s1,96
    800020d2:	00001097          	auipc	ra,0x1
    800020d6:	894080e7          	jalr	-1900(ra) # 80002966 <swtch>
    800020da:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    800020dc:	2781                	sext.w	a5,a5
    800020de:	079e                	slli	a5,a5,0x7
    800020e0:	97ca                	add	a5,a5,s2
    800020e2:	0b37a623          	sw	s3,172(a5)
}
    800020e6:	70a2                	ld	ra,40(sp)
    800020e8:	7402                	ld	s0,32(sp)
    800020ea:	64e2                	ld	s1,24(sp)
    800020ec:	6942                	ld	s2,16(sp)
    800020ee:	69a2                	ld	s3,8(sp)
    800020f0:	6145                	addi	sp,sp,48
    800020f2:	8082                	ret
    panic("sched p->lock");
    800020f4:	00006517          	auipc	a0,0x6
    800020f8:	15450513          	addi	a0,a0,340 # 80008248 <digits+0x208>
    800020fc:	ffffe097          	auipc	ra,0xffffe
    80002100:	43c080e7          	jalr	1084(ra) # 80000538 <panic>
    panic("sched locks");
    80002104:	00006517          	auipc	a0,0x6
    80002108:	15450513          	addi	a0,a0,340 # 80008258 <digits+0x218>
    8000210c:	ffffe097          	auipc	ra,0xffffe
    80002110:	42c080e7          	jalr	1068(ra) # 80000538 <panic>
    panic("sched running");
    80002114:	00006517          	auipc	a0,0x6
    80002118:	15450513          	addi	a0,a0,340 # 80008268 <digits+0x228>
    8000211c:	ffffe097          	auipc	ra,0xffffe
    80002120:	41c080e7          	jalr	1052(ra) # 80000538 <panic>
    panic("sched interruptible");
    80002124:	00006517          	auipc	a0,0x6
    80002128:	15450513          	addi	a0,a0,340 # 80008278 <digits+0x238>
    8000212c:	ffffe097          	auipc	ra,0xffffe
    80002130:	40c080e7          	jalr	1036(ra) # 80000538 <panic>

0000000080002134 <yield>:
{
    80002134:	1101                	addi	sp,sp,-32
    80002136:	ec06                	sd	ra,24(sp)
    80002138:	e822                	sd	s0,16(sp)
    8000213a:	e426                	sd	s1,8(sp)
    8000213c:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    8000213e:	00000097          	auipc	ra,0x0
    80002142:	954080e7          	jalr	-1708(ra) # 80001a92 <myproc>
    80002146:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80002148:	fffff097          	auipc	ra,0xfffff
    8000214c:	a88080e7          	jalr	-1400(ra) # 80000bd0 <acquire>
  p->state = RUNNABLE;
    80002150:	478d                	li	a5,3
    80002152:	cc9c                	sw	a5,24(s1)
  sched();
    80002154:	00000097          	auipc	ra,0x0
    80002158:	f0a080e7          	jalr	-246(ra) # 8000205e <sched>
  release(&p->lock);
    8000215c:	8526                	mv	a0,s1
    8000215e:	fffff097          	auipc	ra,0xfffff
    80002162:	b26080e7          	jalr	-1242(ra) # 80000c84 <release>
}
    80002166:	60e2                	ld	ra,24(sp)
    80002168:	6442                	ld	s0,16(sp)
    8000216a:	64a2                	ld	s1,8(sp)
    8000216c:	6105                	addi	sp,sp,32
    8000216e:	8082                	ret

0000000080002170 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80002170:	7179                	addi	sp,sp,-48
    80002172:	f406                	sd	ra,40(sp)
    80002174:	f022                	sd	s0,32(sp)
    80002176:	ec26                	sd	s1,24(sp)
    80002178:	e84a                	sd	s2,16(sp)
    8000217a:	e44e                	sd	s3,8(sp)
    8000217c:	1800                	addi	s0,sp,48
    8000217e:	89aa                	mv	s3,a0
    80002180:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002182:	00000097          	auipc	ra,0x0
    80002186:	910080e7          	jalr	-1776(ra) # 80001a92 <myproc>
    8000218a:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    8000218c:	fffff097          	auipc	ra,0xfffff
    80002190:	a44080e7          	jalr	-1468(ra) # 80000bd0 <acquire>
  release(lk);
    80002194:	854a                	mv	a0,s2
    80002196:	fffff097          	auipc	ra,0xfffff
    8000219a:	aee080e7          	jalr	-1298(ra) # 80000c84 <release>

  // Go to sleep.
  p->chan = chan;
    8000219e:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    800021a2:	4789                	li	a5,2
    800021a4:	cc9c                	sw	a5,24(s1)

  sched();
    800021a6:	00000097          	auipc	ra,0x0
    800021aa:	eb8080e7          	jalr	-328(ra) # 8000205e <sched>

  // Tidy up.
  p->chan = 0;
    800021ae:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    800021b2:	8526                	mv	a0,s1
    800021b4:	fffff097          	auipc	ra,0xfffff
    800021b8:	ad0080e7          	jalr	-1328(ra) # 80000c84 <release>
  acquire(lk);
    800021bc:	854a                	mv	a0,s2
    800021be:	fffff097          	auipc	ra,0xfffff
    800021c2:	a12080e7          	jalr	-1518(ra) # 80000bd0 <acquire>
}
    800021c6:	70a2                	ld	ra,40(sp)
    800021c8:	7402                	ld	s0,32(sp)
    800021ca:	64e2                	ld	s1,24(sp)
    800021cc:	6942                	ld	s2,16(sp)
    800021ce:	69a2                	ld	s3,8(sp)
    800021d0:	6145                	addi	sp,sp,48
    800021d2:	8082                	ret

00000000800021d4 <wait>:
{
    800021d4:	711d                	addi	sp,sp,-96
    800021d6:	ec86                	sd	ra,88(sp)
    800021d8:	e8a2                	sd	s0,80(sp)
    800021da:	e4a6                	sd	s1,72(sp)
    800021dc:	e0ca                	sd	s2,64(sp)
    800021de:	fc4e                	sd	s3,56(sp)
    800021e0:	f852                	sd	s4,48(sp)
    800021e2:	f456                	sd	s5,40(sp)
    800021e4:	f05a                	sd	s6,32(sp)
    800021e6:	ec5e                	sd	s7,24(sp)
    800021e8:	e862                	sd	s8,16(sp)
    800021ea:	e466                	sd	s9,8(sp)
    800021ec:	1080                	addi	s0,sp,96
    800021ee:	8c2a                	mv	s8,a0
  struct proc *p = myproc();
    800021f0:	00000097          	auipc	ra,0x0
    800021f4:	8a2080e7          	jalr	-1886(ra) # 80001a92 <myproc>
    800021f8:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800021fa:	0000f517          	auipc	a0,0xf
    800021fe:	0be50513          	addi	a0,a0,190 # 800112b8 <wait_lock>
    80002202:	fffff097          	auipc	ra,0xfffff
    80002206:	9ce080e7          	jalr	-1586(ra) # 80000bd0 <acquire>
        if(np->state == ZOMBIE && np->referencias == 1){ //tiene 
    8000220a:	69c1                	lui	s3,0x10
    8000220c:	17898b93          	addi	s7,s3,376 # 10178 <_entry-0x7ffefe88>
    for(np = proc; np < &proc[NPROC]; np++){
    80002210:	18098993          	addi	s3,s3,384
    80002214:	00415a17          	auipc	s4,0x415
    80002218:	4bca0a13          	addi	s4,s4,1212 # 804176d0 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000221c:	0000fc97          	auipc	s9,0xf
    80002220:	09cc8c93          	addi	s9,s9,156 # 800112b8 <wait_lock>
    havekids = 0;
    80002224:	4681                	li	a3,0
    for(np = proc; np < &proc[NPROC]; np++){
    80002226:	0000f497          	auipc	s1,0xf
    8000222a:	4aa48493          	addi	s1,s1,1194 # 800116d0 <proc>
        if(np->state == ZOMBIE && np->referencias == 1){ //tiene 
    8000222e:	4b15                	li	s6,5
        havekids = 1;
    80002230:	4a85                	li	s5,1
    80002232:	a80d                	j	80002264 <wait+0x90>
            release(&np->lock);
    80002234:	8526                	mv	a0,s1
    80002236:	fffff097          	auipc	ra,0xfffff
    8000223a:	a4e080e7          	jalr	-1458(ra) # 80000c84 <release>
            release(&wait_lock);
    8000223e:	0000f517          	auipc	a0,0xf
    80002242:	07a50513          	addi	a0,a0,122 # 800112b8 <wait_lock>
    80002246:	fffff097          	auipc	ra,0xfffff
    8000224a:	a3e080e7          	jalr	-1474(ra) # 80000c84 <release>
            return -1;
    8000224e:	59fd                	li	s3,-1
    80002250:	a879                	j	800022ee <wait+0x11a>
        release(&np->lock);
    80002252:	8526                	mv	a0,s1
    80002254:	fffff097          	auipc	ra,0xfffff
    80002258:	a30080e7          	jalr	-1488(ra) # 80000c84 <release>
        havekids = 1;
    8000225c:	86d6                	mv	a3,s5
    for(np = proc; np < &proc[NPROC]; np++){
    8000225e:	94ce                	add	s1,s1,s3
    80002260:	07448a63          	beq	s1,s4,800022d4 <wait+0x100>
      if(np->parent == p && np->pagetable != p->pagetable){ //Proceso hijo no puede compartir el espacio de direcciones el padre
    80002264:	7c9c                	ld	a5,56(s1)
    80002266:	ff279ce3          	bne	a5,s2,8000225e <wait+0x8a>
    8000226a:	68b8                	ld	a4,80(s1)
    8000226c:	05093783          	ld	a5,80(s2)
    80002270:	fef707e3          	beq	a4,a5,8000225e <wait+0x8a>
        acquire(&np->lock);
    80002274:	8526                	mv	a0,s1
    80002276:	fffff097          	auipc	ra,0xfffff
    8000227a:	95a080e7          	jalr	-1702(ra) # 80000bd0 <acquire>
        if(np->state == ZOMBIE && np->referencias == 1){ //tiene 
    8000227e:	4c9c                	lw	a5,24(s1)
    80002280:	fd6799e3          	bne	a5,s6,80002252 <wait+0x7e>
    80002284:	017487b3          	add	a5,s1,s7
    80002288:	439c                	lw	a5,0(a5)
    8000228a:	fd5794e3          	bne	a5,s5,80002252 <wait+0x7e>
          pid = np->pid;
    8000228e:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    80002292:	000c0e63          	beqz	s8,800022ae <wait+0xda>
    80002296:	4691                	li	a3,4
    80002298:	02c48613          	addi	a2,s1,44
    8000229c:	85e2                	mv	a1,s8
    8000229e:	05093503          	ld	a0,80(s2)
    800022a2:	fffff097          	auipc	ra,0xfffff
    800022a6:	3b4080e7          	jalr	948(ra) # 80001656 <copyout>
    800022aa:	f80545e3          	bltz	a0,80002234 <wait+0x60>
          freeproc(np);
    800022ae:	8526                	mv	a0,s1
    800022b0:	00000097          	auipc	ra,0x0
    800022b4:	994080e7          	jalr	-1644(ra) # 80001c44 <freeproc>
          release(&np->lock);
    800022b8:	8526                	mv	a0,s1
    800022ba:	fffff097          	auipc	ra,0xfffff
    800022be:	9ca080e7          	jalr	-1590(ra) # 80000c84 <release>
          release(&wait_lock);
    800022c2:	0000f517          	auipc	a0,0xf
    800022c6:	ff650513          	addi	a0,a0,-10 # 800112b8 <wait_lock>
    800022ca:	fffff097          	auipc	ra,0xfffff
    800022ce:	9ba080e7          	jalr	-1606(ra) # 80000c84 <release>
          return pid;
    800022d2:	a831                	j	800022ee <wait+0x11a>
    if(!havekids || p->killed){
    800022d4:	c681                	beqz	a3,800022dc <wait+0x108>
    800022d6:	02892783          	lw	a5,40(s2)
    800022da:	cb85                	beqz	a5,8000230a <wait+0x136>
      release(&wait_lock);
    800022dc:	0000f517          	auipc	a0,0xf
    800022e0:	fdc50513          	addi	a0,a0,-36 # 800112b8 <wait_lock>
    800022e4:	fffff097          	auipc	ra,0xfffff
    800022e8:	9a0080e7          	jalr	-1632(ra) # 80000c84 <release>
      return -1;
    800022ec:	59fd                	li	s3,-1
}
    800022ee:	854e                	mv	a0,s3
    800022f0:	60e6                	ld	ra,88(sp)
    800022f2:	6446                	ld	s0,80(sp)
    800022f4:	64a6                	ld	s1,72(sp)
    800022f6:	6906                	ld	s2,64(sp)
    800022f8:	79e2                	ld	s3,56(sp)
    800022fa:	7a42                	ld	s4,48(sp)
    800022fc:	7aa2                	ld	s5,40(sp)
    800022fe:	7b02                	ld	s6,32(sp)
    80002300:	6be2                	ld	s7,24(sp)
    80002302:	6c42                	ld	s8,16(sp)
    80002304:	6ca2                	ld	s9,8(sp)
    80002306:	6125                	addi	sp,sp,96
    80002308:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000230a:	85e6                	mv	a1,s9
    8000230c:	854a                	mv	a0,s2
    8000230e:	00000097          	auipc	ra,0x0
    80002312:	e62080e7          	jalr	-414(ra) # 80002170 <sleep>
    havekids = 0;
    80002316:	b739                	j	80002224 <wait+0x50>

0000000080002318 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80002318:	7139                	addi	sp,sp,-64
    8000231a:	fc06                	sd	ra,56(sp)
    8000231c:	f822                	sd	s0,48(sp)
    8000231e:	f426                	sd	s1,40(sp)
    80002320:	f04a                	sd	s2,32(sp)
    80002322:	ec4e                	sd	s3,24(sp)
    80002324:	e852                	sd	s4,16(sp)
    80002326:	e456                	sd	s5,8(sp)
    80002328:	e05a                	sd	s6,0(sp)
    8000232a:	0080                	addi	s0,sp,64
    8000232c:	8aaa                	mv	s5,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    8000232e:	0000f497          	auipc	s1,0xf
    80002332:	3a248493          	addi	s1,s1,930 # 800116d0 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    80002336:	4a09                	li	s4,2
        p->state = RUNNABLE;
    80002338:	4b0d                	li	s6,3
  for(p = proc; p < &proc[NPROC]; p++) {
    8000233a:	6941                	lui	s2,0x10
    8000233c:	18090913          	addi	s2,s2,384 # 10180 <_entry-0x7ffefe80>
    80002340:	00415997          	auipc	s3,0x415
    80002344:	39098993          	addi	s3,s3,912 # 804176d0 <tickslock>
    80002348:	a809                	j	8000235a <wakeup+0x42>
      }
      release(&p->lock);
    8000234a:	8526                	mv	a0,s1
    8000234c:	fffff097          	auipc	ra,0xfffff
    80002350:	938080e7          	jalr	-1736(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002354:	94ca                	add	s1,s1,s2
    80002356:	03348663          	beq	s1,s3,80002382 <wakeup+0x6a>
    if(p != myproc()){
    8000235a:	fffff097          	auipc	ra,0xfffff
    8000235e:	738080e7          	jalr	1848(ra) # 80001a92 <myproc>
    80002362:	fea489e3          	beq	s1,a0,80002354 <wakeup+0x3c>
      acquire(&p->lock);
    80002366:	8526                	mv	a0,s1
    80002368:	fffff097          	auipc	ra,0xfffff
    8000236c:	868080e7          	jalr	-1944(ra) # 80000bd0 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80002370:	4c9c                	lw	a5,24(s1)
    80002372:	fd479ce3          	bne	a5,s4,8000234a <wakeup+0x32>
    80002376:	709c                	ld	a5,32(s1)
    80002378:	fd5799e3          	bne	a5,s5,8000234a <wakeup+0x32>
        p->state = RUNNABLE;
    8000237c:	0164ac23          	sw	s6,24(s1)
    80002380:	b7e9                	j	8000234a <wakeup+0x32>
    }
  }
}
    80002382:	70e2                	ld	ra,56(sp)
    80002384:	7442                	ld	s0,48(sp)
    80002386:	74a2                	ld	s1,40(sp)
    80002388:	7902                	ld	s2,32(sp)
    8000238a:	69e2                	ld	s3,24(sp)
    8000238c:	6a42                	ld	s4,16(sp)
    8000238e:	6aa2                	ld	s5,8(sp)
    80002390:	6b02                	ld	s6,0(sp)
    80002392:	6121                	addi	sp,sp,64
    80002394:	8082                	ret

0000000080002396 <reparent>:
{
    80002396:	7139                	addi	sp,sp,-64
    80002398:	fc06                	sd	ra,56(sp)
    8000239a:	f822                	sd	s0,48(sp)
    8000239c:	f426                	sd	s1,40(sp)
    8000239e:	f04a                	sd	s2,32(sp)
    800023a0:	ec4e                	sd	s3,24(sp)
    800023a2:	e852                	sd	s4,16(sp)
    800023a4:	e456                	sd	s5,8(sp)
    800023a6:	0080                	addi	s0,sp,64
    800023a8:	89aa                	mv	s3,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800023aa:	0000f497          	auipc	s1,0xf
    800023ae:	32648493          	addi	s1,s1,806 # 800116d0 <proc>
      pp->parent = initproc;
    800023b2:	00007a97          	auipc	s5,0x7
    800023b6:	c76a8a93          	addi	s5,s5,-906 # 80009028 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800023ba:	6941                	lui	s2,0x10
    800023bc:	18090913          	addi	s2,s2,384 # 10180 <_entry-0x7ffefe80>
    800023c0:	00415a17          	auipc	s4,0x415
    800023c4:	310a0a13          	addi	s4,s4,784 # 804176d0 <tickslock>
    800023c8:	a021                	j	800023d0 <reparent+0x3a>
    800023ca:	94ca                	add	s1,s1,s2
    800023cc:	01448d63          	beq	s1,s4,800023e6 <reparent+0x50>
    if(pp->parent == p){
    800023d0:	7c9c                	ld	a5,56(s1)
    800023d2:	ff379ce3          	bne	a5,s3,800023ca <reparent+0x34>
      pp->parent = initproc;
    800023d6:	000ab503          	ld	a0,0(s5)
    800023da:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    800023dc:	00000097          	auipc	ra,0x0
    800023e0:	f3c080e7          	jalr	-196(ra) # 80002318 <wakeup>
    800023e4:	b7dd                	j	800023ca <reparent+0x34>
}
    800023e6:	70e2                	ld	ra,56(sp)
    800023e8:	7442                	ld	s0,48(sp)
    800023ea:	74a2                	ld	s1,40(sp)
    800023ec:	7902                	ld	s2,32(sp)
    800023ee:	69e2                	ld	s3,24(sp)
    800023f0:	6a42                	ld	s4,16(sp)
    800023f2:	6aa2                	ld	s5,8(sp)
    800023f4:	6121                	addi	sp,sp,64
    800023f6:	8082                	ret

00000000800023f8 <exit>:
{
    800023f8:	7179                	addi	sp,sp,-48
    800023fa:	f406                	sd	ra,40(sp)
    800023fc:	f022                	sd	s0,32(sp)
    800023fe:	ec26                	sd	s1,24(sp)
    80002400:	e84a                	sd	s2,16(sp)
    80002402:	e44e                	sd	s3,8(sp)
    80002404:	e052                	sd	s4,0(sp)
    80002406:	1800                	addi	s0,sp,48
    80002408:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    8000240a:	fffff097          	auipc	ra,0xfffff
    8000240e:	688080e7          	jalr	1672(ra) # 80001a92 <myproc>
    80002412:	89aa                	mv	s3,a0
  if(p == initproc)
    80002414:	00007797          	auipc	a5,0x7
    80002418:	c147b783          	ld	a5,-1004(a5) # 80009028 <initproc>
    8000241c:	0d050493          	addi	s1,a0,208
    80002420:	15050913          	addi	s2,a0,336
    80002424:	02a79363          	bne	a5,a0,8000244a <exit+0x52>
    panic("init exiting");
    80002428:	00006517          	auipc	a0,0x6
    8000242c:	e6850513          	addi	a0,a0,-408 # 80008290 <digits+0x250>
    80002430:	ffffe097          	auipc	ra,0xffffe
    80002434:	108080e7          	jalr	264(ra) # 80000538 <panic>
      fileclose(f);
    80002438:	00002097          	auipc	ra,0x2
    8000243c:	4c4080e7          	jalr	1220(ra) # 800048fc <fileclose>
      p->ofile[fd] = 0;
    80002440:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    80002444:	04a1                	addi	s1,s1,8
    80002446:	01248563          	beq	s1,s2,80002450 <exit+0x58>
    if(p->ofile[fd]){
    8000244a:	6088                	ld	a0,0(s1)
    8000244c:	f575                	bnez	a0,80002438 <exit+0x40>
    8000244e:	bfdd                	j	80002444 <exit+0x4c>
  begin_op();
    80002450:	00002097          	auipc	ra,0x2
    80002454:	fe0080e7          	jalr	-32(ra) # 80004430 <begin_op>
  iput(p->cwd);
    80002458:	1509b503          	ld	a0,336(s3)
    8000245c:	00001097          	auipc	ra,0x1
    80002460:	7bc080e7          	jalr	1980(ra) # 80003c18 <iput>
  end_op();
    80002464:	00002097          	auipc	ra,0x2
    80002468:	04c080e7          	jalr	76(ra) # 800044b0 <end_op>
  p->cwd = 0;
    8000246c:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80002470:	0000f497          	auipc	s1,0xf
    80002474:	e4848493          	addi	s1,s1,-440 # 800112b8 <wait_lock>
    80002478:	8526                	mv	a0,s1
    8000247a:	ffffe097          	auipc	ra,0xffffe
    8000247e:	756080e7          	jalr	1878(ra) # 80000bd0 <acquire>
  reparent(p);
    80002482:	854e                	mv	a0,s3
    80002484:	00000097          	auipc	ra,0x0
    80002488:	f12080e7          	jalr	-238(ra) # 80002396 <reparent>
  wakeup(p->parent);
    8000248c:	0389b503          	ld	a0,56(s3)
    80002490:	00000097          	auipc	ra,0x0
    80002494:	e88080e7          	jalr	-376(ra) # 80002318 <wakeup>
  acquire(&p->lock);
    80002498:	854e                	mv	a0,s3
    8000249a:	ffffe097          	auipc	ra,0xffffe
    8000249e:	736080e7          	jalr	1846(ra) # 80000bd0 <acquire>
  p->xstate = status;
    800024a2:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    800024a6:	4795                	li	a5,5
    800024a8:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    800024ac:	8526                	mv	a0,s1
    800024ae:	ffffe097          	auipc	ra,0xffffe
    800024b2:	7d6080e7          	jalr	2006(ra) # 80000c84 <release>
  sched();
    800024b6:	00000097          	auipc	ra,0x0
    800024ba:	ba8080e7          	jalr	-1112(ra) # 8000205e <sched>
  panic("zombie exit");
    800024be:	00006517          	auipc	a0,0x6
    800024c2:	de250513          	addi	a0,a0,-542 # 800082a0 <digits+0x260>
    800024c6:	ffffe097          	auipc	ra,0xffffe
    800024ca:	072080e7          	jalr	114(ra) # 80000538 <panic>

00000000800024ce <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800024ce:	7179                	addi	sp,sp,-48
    800024d0:	f406                	sd	ra,40(sp)
    800024d2:	f022                	sd	s0,32(sp)
    800024d4:	ec26                	sd	s1,24(sp)
    800024d6:	e84a                	sd	s2,16(sp)
    800024d8:	e44e                	sd	s3,8(sp)
    800024da:	e052                	sd	s4,0(sp)
    800024dc:	1800                	addi	s0,sp,48
    800024de:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800024e0:	0000f497          	auipc	s1,0xf
    800024e4:	1f048493          	addi	s1,s1,496 # 800116d0 <proc>
    800024e8:	69c1                	lui	s3,0x10
    800024ea:	18098993          	addi	s3,s3,384 # 10180 <_entry-0x7ffefe80>
    800024ee:	00415a17          	auipc	s4,0x415
    800024f2:	1e2a0a13          	addi	s4,s4,482 # 804176d0 <tickslock>
    acquire(&p->lock);
    800024f6:	8526                	mv	a0,s1
    800024f8:	ffffe097          	auipc	ra,0xffffe
    800024fc:	6d8080e7          	jalr	1752(ra) # 80000bd0 <acquire>
    if(p->pid == pid){
    80002500:	589c                	lw	a5,48(s1)
    80002502:	01278c63          	beq	a5,s2,8000251a <kill+0x4c>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80002506:	8526                	mv	a0,s1
    80002508:	ffffe097          	auipc	ra,0xffffe
    8000250c:	77c080e7          	jalr	1916(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80002510:	94ce                	add	s1,s1,s3
    80002512:	ff4492e3          	bne	s1,s4,800024f6 <kill+0x28>
  }
  return -1;
    80002516:	557d                	li	a0,-1
    80002518:	a829                	j	80002532 <kill+0x64>
      p->killed = 1;
    8000251a:	4785                	li	a5,1
    8000251c:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    8000251e:	4c98                	lw	a4,24(s1)
    80002520:	4789                	li	a5,2
    80002522:	02f70063          	beq	a4,a5,80002542 <kill+0x74>
      release(&p->lock);
    80002526:	8526                	mv	a0,s1
    80002528:	ffffe097          	auipc	ra,0xffffe
    8000252c:	75c080e7          	jalr	1884(ra) # 80000c84 <release>
      return 0;
    80002530:	4501                	li	a0,0
}
    80002532:	70a2                	ld	ra,40(sp)
    80002534:	7402                	ld	s0,32(sp)
    80002536:	64e2                	ld	s1,24(sp)
    80002538:	6942                	ld	s2,16(sp)
    8000253a:	69a2                	ld	s3,8(sp)
    8000253c:	6a02                	ld	s4,0(sp)
    8000253e:	6145                	addi	sp,sp,48
    80002540:	8082                	ret
        p->state = RUNNABLE;
    80002542:	478d                	li	a5,3
    80002544:	cc9c                	sw	a5,24(s1)
    80002546:	b7c5                	j	80002526 <kill+0x58>

0000000080002548 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80002548:	7179                	addi	sp,sp,-48
    8000254a:	f406                	sd	ra,40(sp)
    8000254c:	f022                	sd	s0,32(sp)
    8000254e:	ec26                	sd	s1,24(sp)
    80002550:	e84a                	sd	s2,16(sp)
    80002552:	e44e                	sd	s3,8(sp)
    80002554:	e052                	sd	s4,0(sp)
    80002556:	1800                	addi	s0,sp,48
    80002558:	84aa                	mv	s1,a0
    8000255a:	892e                	mv	s2,a1
    8000255c:	89b2                	mv	s3,a2
    8000255e:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80002560:	fffff097          	auipc	ra,0xfffff
    80002564:	532080e7          	jalr	1330(ra) # 80001a92 <myproc>
  if(user_dst){
    80002568:	c08d                	beqz	s1,8000258a <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    8000256a:	86d2                	mv	a3,s4
    8000256c:	864e                	mv	a2,s3
    8000256e:	85ca                	mv	a1,s2
    80002570:	6928                	ld	a0,80(a0)
    80002572:	fffff097          	auipc	ra,0xfffff
    80002576:	0e4080e7          	jalr	228(ra) # 80001656 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    8000257a:	70a2                	ld	ra,40(sp)
    8000257c:	7402                	ld	s0,32(sp)
    8000257e:	64e2                	ld	s1,24(sp)
    80002580:	6942                	ld	s2,16(sp)
    80002582:	69a2                	ld	s3,8(sp)
    80002584:	6a02                	ld	s4,0(sp)
    80002586:	6145                	addi	sp,sp,48
    80002588:	8082                	ret
    memmove((char *)dst, src, len);
    8000258a:	000a061b          	sext.w	a2,s4
    8000258e:	85ce                	mv	a1,s3
    80002590:	854a                	mv	a0,s2
    80002592:	ffffe097          	auipc	ra,0xffffe
    80002596:	796080e7          	jalr	1942(ra) # 80000d28 <memmove>
    return 0;
    8000259a:	8526                	mv	a0,s1
    8000259c:	bff9                	j	8000257a <either_copyout+0x32>

000000008000259e <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    8000259e:	7179                	addi	sp,sp,-48
    800025a0:	f406                	sd	ra,40(sp)
    800025a2:	f022                	sd	s0,32(sp)
    800025a4:	ec26                	sd	s1,24(sp)
    800025a6:	e84a                	sd	s2,16(sp)
    800025a8:	e44e                	sd	s3,8(sp)
    800025aa:	e052                	sd	s4,0(sp)
    800025ac:	1800                	addi	s0,sp,48
    800025ae:	892a                	mv	s2,a0
    800025b0:	84ae                	mv	s1,a1
    800025b2:	89b2                	mv	s3,a2
    800025b4:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800025b6:	fffff097          	auipc	ra,0xfffff
    800025ba:	4dc080e7          	jalr	1244(ra) # 80001a92 <myproc>
  if(user_src){
    800025be:	c08d                	beqz	s1,800025e0 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    800025c0:	86d2                	mv	a3,s4
    800025c2:	864e                	mv	a2,s3
    800025c4:	85ca                	mv	a1,s2
    800025c6:	6928                	ld	a0,80(a0)
    800025c8:	fffff097          	auipc	ra,0xfffff
    800025cc:	11a080e7          	jalr	282(ra) # 800016e2 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    800025d0:	70a2                	ld	ra,40(sp)
    800025d2:	7402                	ld	s0,32(sp)
    800025d4:	64e2                	ld	s1,24(sp)
    800025d6:	6942                	ld	s2,16(sp)
    800025d8:	69a2                	ld	s3,8(sp)
    800025da:	6a02                	ld	s4,0(sp)
    800025dc:	6145                	addi	sp,sp,48
    800025de:	8082                	ret
    memmove(dst, (char*)src, len);
    800025e0:	000a061b          	sext.w	a2,s4
    800025e4:	85ce                	mv	a1,s3
    800025e6:	854a                	mv	a0,s2
    800025e8:	ffffe097          	auipc	ra,0xffffe
    800025ec:	740080e7          	jalr	1856(ra) # 80000d28 <memmove>
    return 0;
    800025f0:	8526                	mv	a0,s1
    800025f2:	bff9                	j	800025d0 <either_copyin+0x32>

00000000800025f4 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800025f4:	715d                	addi	sp,sp,-80
    800025f6:	e486                	sd	ra,72(sp)
    800025f8:	e0a2                	sd	s0,64(sp)
    800025fa:	fc26                	sd	s1,56(sp)
    800025fc:	f84a                	sd	s2,48(sp)
    800025fe:	f44e                	sd	s3,40(sp)
    80002600:	f052                	sd	s4,32(sp)
    80002602:	ec56                	sd	s5,24(sp)
    80002604:	e85a                	sd	s6,16(sp)
    80002606:	e45e                	sd	s7,8(sp)
    80002608:	e062                	sd	s8,0(sp)
    8000260a:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    8000260c:	00006517          	auipc	a0,0x6
    80002610:	abc50513          	addi	a0,a0,-1348 # 800080c8 <digits+0x88>
    80002614:	ffffe097          	auipc	ra,0xffffe
    80002618:	f6e080e7          	jalr	-146(ra) # 80000582 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    8000261c:	0000f497          	auipc	s1,0xf
    80002620:	20c48493          	addi	s1,s1,524 # 80011828 <proc+0x158>
    80002624:	00415997          	auipc	s3,0x415
    80002628:	20498993          	addi	s3,s3,516 # 80417828 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000262c:	4b95                	li	s7,5
      state = states[p->state];
    else
      state = "???";
    8000262e:	00006a17          	auipc	s4,0x6
    80002632:	c82a0a13          	addi	s4,s4,-894 # 800082b0 <digits+0x270>
    printf("%d %s %s", p->pid, state, p->name);
    80002636:	00006b17          	auipc	s6,0x6
    8000263a:	c82b0b13          	addi	s6,s6,-894 # 800082b8 <digits+0x278>
    printf("\n");
    8000263e:	00006a97          	auipc	s5,0x6
    80002642:	a8aa8a93          	addi	s5,s5,-1398 # 800080c8 <digits+0x88>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002646:	00006c17          	auipc	s8,0x6
    8000264a:	cf2c0c13          	addi	s8,s8,-782 # 80008338 <states.0>
  for(p = proc; p < &proc[NPROC]; p++){
    8000264e:	6941                	lui	s2,0x10
    80002650:	18090913          	addi	s2,s2,384 # 10180 <_entry-0x7ffefe80>
    80002654:	a005                	j	80002674 <procdump+0x80>
    printf("%d %s %s", p->pid, state, p->name);
    80002656:	ed86a583          	lw	a1,-296(a3)
    8000265a:	855a                	mv	a0,s6
    8000265c:	ffffe097          	auipc	ra,0xffffe
    80002660:	f26080e7          	jalr	-218(ra) # 80000582 <printf>
    printf("\n");
    80002664:	8556                	mv	a0,s5
    80002666:	ffffe097          	auipc	ra,0xffffe
    8000266a:	f1c080e7          	jalr	-228(ra) # 80000582 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    8000266e:	94ca                	add	s1,s1,s2
    80002670:	03348163          	beq	s1,s3,80002692 <procdump+0x9e>
    if(p->state == UNUSED)
    80002674:	86a6                	mv	a3,s1
    80002676:	ec04a783          	lw	a5,-320(s1)
    8000267a:	dbf5                	beqz	a5,8000266e <procdump+0x7a>
      state = "???";
    8000267c:	8652                	mv	a2,s4
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000267e:	fcfbece3          	bltu	s7,a5,80002656 <procdump+0x62>
    80002682:	1782                	slli	a5,a5,0x20
    80002684:	9381                	srli	a5,a5,0x20
    80002686:	078e                	slli	a5,a5,0x3
    80002688:	97e2                	add	a5,a5,s8
    8000268a:	6390                	ld	a2,0(a5)
    8000268c:	f669                	bnez	a2,80002656 <procdump+0x62>
      state = "???";
    8000268e:	8652                	mv	a2,s4
    80002690:	b7d9                	j	80002656 <procdump+0x62>
  }
}
    80002692:	60a6                	ld	ra,72(sp)
    80002694:	6406                	ld	s0,64(sp)
    80002696:	74e2                	ld	s1,56(sp)
    80002698:	7942                	ld	s2,48(sp)
    8000269a:	79a2                	ld	s3,40(sp)
    8000269c:	7a02                	ld	s4,32(sp)
    8000269e:	6ae2                	ld	s5,24(sp)
    800026a0:	6b42                	ld	s6,16(sp)
    800026a2:	6ba2                	ld	s7,8(sp)
    800026a4:	6c02                	ld	s8,0(sp)
    800026a6:	6161                	addi	sp,sp,80
    800026a8:	8082                	ret

00000000800026aa <clone>:


int clone(void(*fcn)(void*), void *arg, void*stack)
{
    800026aa:	715d                	addi	sp,sp,-80
    800026ac:	e486                	sd	ra,72(sp)
    800026ae:	e0a2                	sd	s0,64(sp)
    800026b0:	fc26                	sd	s1,56(sp)
    800026b2:	f84a                	sd	s2,48(sp)
    800026b4:	f44e                	sd	s3,40(sp)
    800026b6:	f052                	sd	s4,32(sp)
    800026b8:	ec56                	sd	s5,24(sp)
    800026ba:	0880                	addi	s0,sp,80
    800026bc:	8a2a                	mv	s4,a0
    800026be:	892e                	mv	s2,a1
    800026c0:	84b2                	mv	s1,a2

    int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    800026c2:	fffff097          	auipc	ra,0xfffff
    800026c6:	3d0080e7          	jalr	976(ra) # 80001a92 <myproc>
    800026ca:	8aaa                	mv	s5,a0

  // Allocate process.
  if((np = allocproc()) == 0){
    800026cc:	fffff097          	auipc	ra,0xfffff
    800026d0:	5d0080e7          	jalr	1488(ra) # 80001c9c <allocproc>
    800026d4:	16050163          	beqz	a0,80002836 <clone+0x18c>
    800026d8:	89aa                	mv	s3,a0
    return -1;
  }

  //Hacemos que el proceso hijo comparta la tabla de páginas del proceso padre
  np->pagetable = p->pagetable;
    800026da:	050ab783          	ld	a5,80(s5)
    800026de:	e93c                	sd	a5,80(a0)
  np->sz = p->sz;
    800026e0:	048ab783          	ld	a5,72(s5)
    800026e4:	e53c                	sd	a5,72(a0)

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    800026e6:	058ab683          	ld	a3,88(s5)
    800026ea:	87b6                	mv	a5,a3
    800026ec:	6d38                	ld	a4,88(a0)
    800026ee:	12068693          	addi	a3,a3,288
    800026f2:	6388                	ld	a0,0(a5)
    800026f4:	678c                	ld	a1,8(a5)
    800026f6:	0107b803          	ld	a6,16(a5)
    800026fa:	6f90                	ld	a2,24(a5)
    800026fc:	e308                	sd	a0,0(a4)
    800026fe:	e70c                	sd	a1,8(a4)
    80002700:	01073823          	sd	a6,16(a4)
    80002704:	ef10                	sd	a2,24(a4)
    80002706:	02078793          	addi	a5,a5,32
    8000270a:	02070713          	addi	a4,a4,32
    8000270e:	fed792e3          	bne	a5,a3,800026f2 <clone+0x48>

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;
    80002712:	0589b783          	ld	a5,88(s3)
    80002716:	0607b823          	sd	zero,112(a5)


  
  //Apuntamos al final del stack y luego vamos insertamos
  uint64 stack_args[2]; 
  stack_args[0] =  (uint64)arg; //PC retorno
    8000271a:	fb243823          	sd	s2,-80(s0)
  stack_args[1] =  0xffffffffffffffff; //cast uint64
    8000271e:	57fd                	li	a5,-1
    80002720:	faf43c23          	sd	a5,-72(s0)

  np->bottom_ustack = (uint64) stack; //base de stack, para liberar en join
    80002724:	1699b823          	sd	s1,368(s3)
  np->top_ustack = np->bottom_ustack + PGSIZE; //tope de stack
  np->top_ustack -= 16; 
    80002728:	6785                	lui	a5,0x1
    8000272a:	17c1                	addi	a5,a5,-16
    8000272c:	94be                	add	s1,s1,a5
    8000272e:	1699b423          	sd	s1,360(s3)


  printf ("Antes de hacer copyout.\n");
    80002732:	00006517          	auipc	a0,0x6
    80002736:	b9650513          	addi	a0,a0,-1130 # 800082c8 <digits+0x288>
    8000273a:	ffffe097          	auipc	ra,0xffffe
    8000273e:	e48080e7          	jalr	-440(ra) # 80000582 <printf>

  //copyout
  if (copyout(np->pagetable, np->top_ustack, (char *) stack_args, 16) < 0) {
    80002742:	46c1                	li	a3,16
    80002744:	fb040613          	addi	a2,s0,-80
    80002748:	1689b583          	ld	a1,360(s3)
    8000274c:	0509b503          	ld	a0,80(s3)
    80002750:	fffff097          	auipc	ra,0xfffff
    80002754:	f06080e7          	jalr	-250(ra) # 80001656 <copyout>
    80002758:	0e054163          	bltz	a0,8000283a <clone+0x190>
        return -1;
    }

 
  printf ("Copyout correcto al stack del thread.\n");
    8000275c:	00006517          	auipc	a0,0x6
    80002760:	b8c50513          	addi	a0,a0,-1140 # 800082e8 <digits+0x2a8>
    80002764:	ffffe097          	auipc	ra,0xffffe
    80002768:	e1e080e7          	jalr	-482(ra) # 80000582 <printf>

   //cambiar program counter a la función que debe ejecutar
  np->trapframe->epc= (uint64) fcn; 
    8000276c:	0589b783          	ld	a5,88(s3)
    80002770:	0147bc23          	sd	s4,24(a5) # 1018 <_entry-0x7fffefe8>

  //actualiza stack pointer
  np->trapframe->sp= np->top_ustack; 
    80002774:	0589b783          	ld	a5,88(s3)
    80002778:	1689b703          	ld	a4,360(s3)
    8000277c:	fb98                	sd	a4,48(a5)
  print_table(np->pagetable, 2);
 */

  
  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    8000277e:	0d0a8493          	addi	s1,s5,208
    80002782:	0d098913          	addi	s2,s3,208
    80002786:	150a8a13          	addi	s4,s5,336
    8000278a:	a819                	j	800027a0 <clone+0xf6>
    if(p->ofile[i])
      np->ofile[i] = filedup(p->ofile[i]);
    8000278c:	00002097          	auipc	ra,0x2
    80002790:	11e080e7          	jalr	286(ra) # 800048aa <filedup>
    80002794:	00a93023          	sd	a0,0(s2)
  for(i = 0; i < NOFILE; i++)
    80002798:	04a1                	addi	s1,s1,8
    8000279a:	0921                	addi	s2,s2,8
    8000279c:	01448563          	beq	s1,s4,800027a6 <clone+0xfc>
    if(p->ofile[i])
    800027a0:	6088                	ld	a0,0(s1)
    800027a2:	f56d                	bnez	a0,8000278c <clone+0xe2>
    800027a4:	bfd5                	j	80002798 <clone+0xee>
  np->cwd = idup(p->cwd);
    800027a6:	150ab503          	ld	a0,336(s5)
    800027aa:	00001097          	auipc	ra,0x1
    800027ae:	276080e7          	jalr	630(ra) # 80003a20 <idup>
    800027b2:	14a9b823          	sd	a0,336(s3)

  safestrcpy(np->name, p->name, sizeof(p->name));
    800027b6:	4641                	li	a2,16
    800027b8:	158a8593          	addi	a1,s5,344
    800027bc:	15898513          	addi	a0,s3,344
    800027c0:	ffffe097          	auipc	ra,0xffffe
    800027c4:	656080e7          	jalr	1622(ra) # 80000e16 <safestrcpy>

  //para devolverlo
  pid = np->pid;
    800027c8:	0309a903          	lw	s2,48(s3)

  //asignamos también al hijo las referencias que tiene el padre y sumamos al hijo
  np->referencias = p->referencias;
  np->referencias = np->referencias +1;
    800027cc:	67c1                	lui	a5,0x10
    800027ce:	00f98733          	add	a4,s3,a5
  np->referencias = p->referencias;
    800027d2:	97d6                	add	a5,a5,s5
  np->referencias = np->referencias +1;
    800027d4:	1787a783          	lw	a5,376(a5) # 10178 <_entry-0x7ffefe88>
    800027d8:	2785                	addiw	a5,a5,1
    800027da:	16f72c23          	sw	a5,376(a4)

  release(&np->lock);
    800027de:	854e                	mv	a0,s3
    800027e0:	ffffe097          	auipc	ra,0xffffe
    800027e4:	4a4080e7          	jalr	1188(ra) # 80000c84 <release>

  //para registrar cual es su padre
  acquire(&wait_lock);
    800027e8:	0000f497          	auipc	s1,0xf
    800027ec:	ad048493          	addi	s1,s1,-1328 # 800112b8 <wait_lock>
    800027f0:	8526                	mv	a0,s1
    800027f2:	ffffe097          	auipc	ra,0xffffe
    800027f6:	3de080e7          	jalr	990(ra) # 80000bd0 <acquire>
  np->parent = p;
    800027fa:	0359bc23          	sd	s5,56(s3)
  release(&wait_lock);
    800027fe:	8526                	mv	a0,s1
    80002800:	ffffe097          	auipc	ra,0xffffe
    80002804:	484080e7          	jalr	1156(ra) # 80000c84 <release>

  //para cambiar su estado a ejecutable
  acquire(&np->lock);
    80002808:	854e                	mv	a0,s3
    8000280a:	ffffe097          	auipc	ra,0xffffe
    8000280e:	3c6080e7          	jalr	966(ra) # 80000bd0 <acquire>
  np->state = RUNNABLE;
    80002812:	478d                	li	a5,3
    80002814:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    80002818:	854e                	mv	a0,s3
    8000281a:	ffffe097          	auipc	ra,0xffffe
    8000281e:	46a080e7          	jalr	1130(ra) # 80000c84 <release>

  return pid;

}
    80002822:	854a                	mv	a0,s2
    80002824:	60a6                	ld	ra,72(sp)
    80002826:	6406                	ld	s0,64(sp)
    80002828:	74e2                	ld	s1,56(sp)
    8000282a:	7942                	ld	s2,48(sp)
    8000282c:	79a2                	ld	s3,40(sp)
    8000282e:	7a02                	ld	s4,32(sp)
    80002830:	6ae2                	ld	s5,24(sp)
    80002832:	6161                	addi	sp,sp,80
    80002834:	8082                	ret
    return -1;
    80002836:	597d                	li	s2,-1
    80002838:	b7ed                	j	80002822 <clone+0x178>
        return -1;
    8000283a:	597d                	li	s2,-1
    8000283c:	b7dd                	j	80002822 <clone+0x178>

000000008000283e <join>:


int join (void **stack){
    8000283e:	715d                	addi	sp,sp,-80
    80002840:	e486                	sd	ra,72(sp)
    80002842:	e0a2                	sd	s0,64(sp)
    80002844:	fc26                	sd	s1,56(sp)
    80002846:	f84a                	sd	s2,48(sp)
    80002848:	f44e                	sd	s3,40(sp)
    8000284a:	f052                	sd	s4,32(sp)
    8000284c:	ec56                	sd	s5,24(sp)
    8000284e:	e85a                	sd	s6,16(sp)
    80002850:	e45e                	sd	s7,8(sp)
    80002852:	0880                	addi	s0,sp,80
    80002854:	8baa                	mv	s7,a0

  struct proc *np;
  int havekids, pid;
  struct proc *p = myproc();
    80002856:	fffff097          	auipc	ra,0xfffff
    8000285a:	23c080e7          	jalr	572(ra) # 80001a92 <myproc>
    8000285e:	892a                	mv	s2,a0

  acquire(&wait_lock);
    80002860:	0000f517          	auipc	a0,0xf
    80002864:	a5850513          	addi	a0,a0,-1448 # 800112b8 <wait_lock>
    80002868:	ffffe097          	auipc	ra,0xffffe
    8000286c:	368080e7          	jalr	872(ra) # 80000bd0 <acquire>

        // make sure the child isn't still in exit() or swtch().
        acquire(&np->lock);

        havekids = 1;
        if(np->state == ZOMBIE){
    80002870:	4a95                	li	s5,5
        havekids = 1;
    80002872:	4b05                	li	s6,1
    for(np = proc; np < &proc[NPROC]; np++){
    80002874:	69c1                	lui	s3,0x10
    80002876:	18098993          	addi	s3,s3,384 # 10180 <_entry-0x7ffefe80>
    8000287a:	00415a17          	auipc	s4,0x415
    8000287e:	e56a0a13          	addi	s4,s4,-426 # 804176d0 <tickslock>
    havekids = 0;
    80002882:	4681                	li	a3,0
    for(np = proc; np < &proc[NPROC]; np++){
    80002884:	0000f497          	auipc	s1,0xf
    80002888:	e4c48493          	addi	s1,s1,-436 # 800116d0 <proc>
    8000288c:	a09d                	j	800028f2 <join+0xb4>
          // Found one.

          //copiamos en el argumento stack la dirección del stack de usuario para que pueda liberarse después con free
          *stack = (void *) np->bottom_ustack; //Debe apuntar al principio o cabeza de stack?
    8000288e:	1704b783          	ld	a5,368(s1)
    80002892:	00fbb023          	sd	a5,0(s7)
          pid = np->pid;
    80002896:	0304a903          	lw	s2,48(s1)

         //modificamos código de freeproc, ya que no debemos usar todo

          // if(p->trapframe)
          //   kfree((void*)p->trapframe);
          np->trapframe = 0;
    8000289a:	0404bc23          	sd	zero,88(s1)
          // if(p->pagetable)
          //   proc_freepagetable(p->pagetable, p->sz);

          np->pagetable = 0; //no modifica tabla de paginas del padre
    8000289e:	0404b823          	sd	zero,80(s1)
          np->sz = 0; //no modifica sz del padre
    800028a2:	0404b423          	sd	zero,72(s1)
          np->pid = 0; //lock tomado
    800028a6:	0204a823          	sw	zero,48(s1)
          np->parent = 0;
    800028aa:	0204bc23          	sd	zero,56(s1)
          np->name[0] = 0;
    800028ae:	14048c23          	sb	zero,344(s1)
          np->chan = 0; //?? no se que es, lock tomado
    800028b2:	0204b023          	sd	zero,32(s1)
          np->killed = 0; //lock tomado
    800028b6:	0204a423          	sw	zero,40(s1)
          np->xstate = 0; //lock está tomado
    800028ba:	0204a623          	sw	zero,44(s1)
          np->state = UNUSED; //lock tomado
    800028be:	0004ac23          	sw	zero,24(s1)

          np->referencias = np->referencias -1;
    800028c2:	67c1                	lui	a5,0x10
    800028c4:	97a6                	add	a5,a5,s1
    800028c6:	1787a703          	lw	a4,376(a5) # 10178 <_entry-0x7ffefe88>
    800028ca:	377d                	addiw	a4,a4,-1
    800028cc:	16e7ac23          	sw	a4,376(a5)
          
          //limpiamos top_stack?

          release(&np->lock); //libera thread
    800028d0:	8526                	mv	a0,s1
    800028d2:	ffffe097          	auipc	ra,0xffffe
    800028d6:	3b2080e7          	jalr	946(ra) # 80000c84 <release>
          release(&wait_lock);
    800028da:	0000f517          	auipc	a0,0xf
    800028de:	9de50513          	addi	a0,a0,-1570 # 800112b8 <wait_lock>
    800028e2:	ffffe097          	auipc	ra,0xffffe
    800028e6:	3a2080e7          	jalr	930(ra) # 80000c84 <release>
          
          return pid; //devolvemos TID 
    800028ea:	a881                	j	8000293a <join+0xfc>
    for(np = proc; np < &proc[NPROC]; np++){
    800028ec:	94ce                	add	s1,s1,s3
    800028ee:	03448963          	beq	s1,s4,80002920 <join+0xe2>
      if(np->parent == p && np->pagetable == p->pagetable){ //modificamos la condición para que se seleccione solo al thread hijo del proceso
    800028f2:	7c9c                	ld	a5,56(s1)
    800028f4:	ff279ce3          	bne	a5,s2,800028ec <join+0xae>
    800028f8:	68b8                	ld	a4,80(s1)
    800028fa:	05093783          	ld	a5,80(s2)
    800028fe:	fef717e3          	bne	a4,a5,800028ec <join+0xae>
        acquire(&np->lock);
    80002902:	8526                	mv	a0,s1
    80002904:	ffffe097          	auipc	ra,0xffffe
    80002908:	2cc080e7          	jalr	716(ra) # 80000bd0 <acquire>
        if(np->state == ZOMBIE){
    8000290c:	4c9c                	lw	a5,24(s1)
    8000290e:	f95780e3          	beq	a5,s5,8000288e <join+0x50>
        }
        release(&np->lock);
    80002912:	8526                	mv	a0,s1
    80002914:	ffffe097          	auipc	ra,0xffffe
    80002918:	370080e7          	jalr	880(ra) # 80000c84 <release>
        havekids = 1;
    8000291c:	86da                	mv	a3,s6
    8000291e:	b7f9                	j	800028ec <join+0xae>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || p->killed){
    80002920:	c681                	beqz	a3,80002928 <join+0xea>
    80002922:	02892783          	lw	a5,40(s2)
    80002926:	c795                	beqz	a5,80002952 <join+0x114>
      release(&wait_lock);
    80002928:	0000f517          	auipc	a0,0xf
    8000292c:	99050513          	addi	a0,a0,-1648 # 800112b8 <wait_lock>
    80002930:	ffffe097          	auipc	ra,0xffffe
    80002934:	354080e7          	jalr	852(ra) # 80000c84 <release>
      return -1;
    80002938:	597d                	li	s2,-1
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
  }

    8000293a:	854a                	mv	a0,s2
    8000293c:	60a6                	ld	ra,72(sp)
    8000293e:	6406                	ld	s0,64(sp)
    80002940:	74e2                	ld	s1,56(sp)
    80002942:	7942                	ld	s2,48(sp)
    80002944:	79a2                	ld	s3,40(sp)
    80002946:	7a02                	ld	s4,32(sp)
    80002948:	6ae2                	ld	s5,24(sp)
    8000294a:	6b42                	ld	s6,16(sp)
    8000294c:	6ba2                	ld	s7,8(sp)
    8000294e:	6161                	addi	sp,sp,80
    80002950:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80002952:	0000f597          	auipc	a1,0xf
    80002956:	96658593          	addi	a1,a1,-1690 # 800112b8 <wait_lock>
    8000295a:	854a                	mv	a0,s2
    8000295c:	00000097          	auipc	ra,0x0
    80002960:	814080e7          	jalr	-2028(ra) # 80002170 <sleep>
    havekids = 0;
    80002964:	bf39                	j	80002882 <join+0x44>

0000000080002966 <swtch>:
    80002966:	00153023          	sd	ra,0(a0)
    8000296a:	00253423          	sd	sp,8(a0)
    8000296e:	e900                	sd	s0,16(a0)
    80002970:	ed04                	sd	s1,24(a0)
    80002972:	03253023          	sd	s2,32(a0)
    80002976:	03353423          	sd	s3,40(a0)
    8000297a:	03453823          	sd	s4,48(a0)
    8000297e:	03553c23          	sd	s5,56(a0)
    80002982:	05653023          	sd	s6,64(a0)
    80002986:	05753423          	sd	s7,72(a0)
    8000298a:	05853823          	sd	s8,80(a0)
    8000298e:	05953c23          	sd	s9,88(a0)
    80002992:	07a53023          	sd	s10,96(a0)
    80002996:	07b53423          	sd	s11,104(a0)
    8000299a:	0005b083          	ld	ra,0(a1)
    8000299e:	0085b103          	ld	sp,8(a1)
    800029a2:	6980                	ld	s0,16(a1)
    800029a4:	6d84                	ld	s1,24(a1)
    800029a6:	0205b903          	ld	s2,32(a1)
    800029aa:	0285b983          	ld	s3,40(a1)
    800029ae:	0305ba03          	ld	s4,48(a1)
    800029b2:	0385ba83          	ld	s5,56(a1)
    800029b6:	0405bb03          	ld	s6,64(a1)
    800029ba:	0485bb83          	ld	s7,72(a1)
    800029be:	0505bc03          	ld	s8,80(a1)
    800029c2:	0585bc83          	ld	s9,88(a1)
    800029c6:	0605bd03          	ld	s10,96(a1)
    800029ca:	0685bd83          	ld	s11,104(a1)
    800029ce:	8082                	ret

00000000800029d0 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    800029d0:	1141                	addi	sp,sp,-16
    800029d2:	e406                	sd	ra,8(sp)
    800029d4:	e022                	sd	s0,0(sp)
    800029d6:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    800029d8:	00006597          	auipc	a1,0x6
    800029dc:	99058593          	addi	a1,a1,-1648 # 80008368 <states.0+0x30>
    800029e0:	00415517          	auipc	a0,0x415
    800029e4:	cf050513          	addi	a0,a0,-784 # 804176d0 <tickslock>
    800029e8:	ffffe097          	auipc	ra,0xffffe
    800029ec:	158080e7          	jalr	344(ra) # 80000b40 <initlock>
}
    800029f0:	60a2                	ld	ra,8(sp)
    800029f2:	6402                	ld	s0,0(sp)
    800029f4:	0141                	addi	sp,sp,16
    800029f6:	8082                	ret

00000000800029f8 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    800029f8:	1141                	addi	sp,sp,-16
    800029fa:	e422                	sd	s0,8(sp)
    800029fc:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    800029fe:	00003797          	auipc	a5,0x3
    80002a02:	52278793          	addi	a5,a5,1314 # 80005f20 <kernelvec>
    80002a06:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80002a0a:	6422                	ld	s0,8(sp)
    80002a0c:	0141                	addi	sp,sp,16
    80002a0e:	8082                	ret

0000000080002a10 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80002a10:	1141                	addi	sp,sp,-16
    80002a12:	e406                	sd	ra,8(sp)
    80002a14:	e022                	sd	s0,0(sp)
    80002a16:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80002a18:	fffff097          	auipc	ra,0xfffff
    80002a1c:	07a080e7          	jalr	122(ra) # 80001a92 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002a20:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80002a24:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002a26:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80002a2a:	00004617          	auipc	a2,0x4
    80002a2e:	5d660613          	addi	a2,a2,1494 # 80007000 <_trampoline>
    80002a32:	00004697          	auipc	a3,0x4
    80002a36:	5ce68693          	addi	a3,a3,1486 # 80007000 <_trampoline>
    80002a3a:	8e91                	sub	a3,a3,a2
    80002a3c:	040007b7          	lui	a5,0x4000
    80002a40:	17fd                	addi	a5,a5,-1
    80002a42:	07b2                	slli	a5,a5,0xc
    80002a44:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002a46:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80002a4a:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80002a4c:	180026f3          	csrr	a3,satp
    80002a50:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80002a52:	6d38                	ld	a4,88(a0)
    80002a54:	6134                	ld	a3,64(a0)
    80002a56:	6585                	lui	a1,0x1
    80002a58:	96ae                	add	a3,a3,a1
    80002a5a:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80002a5c:	6d38                	ld	a4,88(a0)
    80002a5e:	00000697          	auipc	a3,0x0
    80002a62:	13868693          	addi	a3,a3,312 # 80002b96 <usertrap>
    80002a66:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80002a68:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80002a6a:	8692                	mv	a3,tp
    80002a6c:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002a6e:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80002a72:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80002a76:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002a7a:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80002a7e:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002a80:	6f18                	ld	a4,24(a4)
    80002a82:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80002a86:	692c                	ld	a1,80(a0)
    80002a88:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80002a8a:	00004717          	auipc	a4,0x4
    80002a8e:	60670713          	addi	a4,a4,1542 # 80007090 <userret>
    80002a92:	8f11                	sub	a4,a4,a2
    80002a94:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80002a96:	577d                	li	a4,-1
    80002a98:	177e                	slli	a4,a4,0x3f
    80002a9a:	8dd9                	or	a1,a1,a4
    80002a9c:	02000537          	lui	a0,0x2000
    80002aa0:	157d                	addi	a0,a0,-1
    80002aa2:	0536                	slli	a0,a0,0xd
    80002aa4:	9782                	jalr	a5
}
    80002aa6:	60a2                	ld	ra,8(sp)
    80002aa8:	6402                	ld	s0,0(sp)
    80002aaa:	0141                	addi	sp,sp,16
    80002aac:	8082                	ret

0000000080002aae <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80002aae:	1101                	addi	sp,sp,-32
    80002ab0:	ec06                	sd	ra,24(sp)
    80002ab2:	e822                	sd	s0,16(sp)
    80002ab4:	e426                	sd	s1,8(sp)
    80002ab6:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80002ab8:	00415497          	auipc	s1,0x415
    80002abc:	c1848493          	addi	s1,s1,-1000 # 804176d0 <tickslock>
    80002ac0:	8526                	mv	a0,s1
    80002ac2:	ffffe097          	auipc	ra,0xffffe
    80002ac6:	10e080e7          	jalr	270(ra) # 80000bd0 <acquire>
  ticks++;
    80002aca:	00006517          	auipc	a0,0x6
    80002ace:	56650513          	addi	a0,a0,1382 # 80009030 <ticks>
    80002ad2:	411c                	lw	a5,0(a0)
    80002ad4:	2785                	addiw	a5,a5,1
    80002ad6:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80002ad8:	00000097          	auipc	ra,0x0
    80002adc:	840080e7          	jalr	-1984(ra) # 80002318 <wakeup>
  release(&tickslock);
    80002ae0:	8526                	mv	a0,s1
    80002ae2:	ffffe097          	auipc	ra,0xffffe
    80002ae6:	1a2080e7          	jalr	418(ra) # 80000c84 <release>
}
    80002aea:	60e2                	ld	ra,24(sp)
    80002aec:	6442                	ld	s0,16(sp)
    80002aee:	64a2                	ld	s1,8(sp)
    80002af0:	6105                	addi	sp,sp,32
    80002af2:	8082                	ret

0000000080002af4 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80002af4:	1101                	addi	sp,sp,-32
    80002af6:	ec06                	sd	ra,24(sp)
    80002af8:	e822                	sd	s0,16(sp)
    80002afa:	e426                	sd	s1,8(sp)
    80002afc:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002afe:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80002b02:	00074d63          	bltz	a4,80002b1c <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80002b06:	57fd                	li	a5,-1
    80002b08:	17fe                	slli	a5,a5,0x3f
    80002b0a:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80002b0c:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80002b0e:	06f70363          	beq	a4,a5,80002b74 <devintr+0x80>
  }
}
    80002b12:	60e2                	ld	ra,24(sp)
    80002b14:	6442                	ld	s0,16(sp)
    80002b16:	64a2                	ld	s1,8(sp)
    80002b18:	6105                	addi	sp,sp,32
    80002b1a:	8082                	ret
     (scause & 0xff) == 9){
    80002b1c:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    80002b20:	46a5                	li	a3,9
    80002b22:	fed792e3          	bne	a5,a3,80002b06 <devintr+0x12>
    int irq = plic_claim();
    80002b26:	00003097          	auipc	ra,0x3
    80002b2a:	502080e7          	jalr	1282(ra) # 80006028 <plic_claim>
    80002b2e:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80002b30:	47a9                	li	a5,10
    80002b32:	02f50763          	beq	a0,a5,80002b60 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80002b36:	4785                	li	a5,1
    80002b38:	02f50963          	beq	a0,a5,80002b6a <devintr+0x76>
    return 1;
    80002b3c:	4505                	li	a0,1
    } else if(irq){
    80002b3e:	d8f1                	beqz	s1,80002b12 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80002b40:	85a6                	mv	a1,s1
    80002b42:	00006517          	auipc	a0,0x6
    80002b46:	82e50513          	addi	a0,a0,-2002 # 80008370 <states.0+0x38>
    80002b4a:	ffffe097          	auipc	ra,0xffffe
    80002b4e:	a38080e7          	jalr	-1480(ra) # 80000582 <printf>
      plic_complete(irq);
    80002b52:	8526                	mv	a0,s1
    80002b54:	00003097          	auipc	ra,0x3
    80002b58:	4f8080e7          	jalr	1272(ra) # 8000604c <plic_complete>
    return 1;
    80002b5c:	4505                	li	a0,1
    80002b5e:	bf55                	j	80002b12 <devintr+0x1e>
      uartintr();
    80002b60:	ffffe097          	auipc	ra,0xffffe
    80002b64:	e34080e7          	jalr	-460(ra) # 80000994 <uartintr>
    80002b68:	b7ed                	j	80002b52 <devintr+0x5e>
      virtio_disk_intr();
    80002b6a:	00004097          	auipc	ra,0x4
    80002b6e:	974080e7          	jalr	-1676(ra) # 800064de <virtio_disk_intr>
    80002b72:	b7c5                	j	80002b52 <devintr+0x5e>
    if(cpuid() == 0){
    80002b74:	fffff097          	auipc	ra,0xfffff
    80002b78:	ef2080e7          	jalr	-270(ra) # 80001a66 <cpuid>
    80002b7c:	c901                	beqz	a0,80002b8c <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80002b7e:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80002b82:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80002b84:	14479073          	csrw	sip,a5
    return 2;
    80002b88:	4509                	li	a0,2
    80002b8a:	b761                	j	80002b12 <devintr+0x1e>
      clockintr();
    80002b8c:	00000097          	auipc	ra,0x0
    80002b90:	f22080e7          	jalr	-222(ra) # 80002aae <clockintr>
    80002b94:	b7ed                	j	80002b7e <devintr+0x8a>

0000000080002b96 <usertrap>:
{
    80002b96:	1101                	addi	sp,sp,-32
    80002b98:	ec06                	sd	ra,24(sp)
    80002b9a:	e822                	sd	s0,16(sp)
    80002b9c:	e426                	sd	s1,8(sp)
    80002b9e:	e04a                	sd	s2,0(sp)
    80002ba0:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002ba2:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80002ba6:	1007f793          	andi	a5,a5,256
    80002baa:	e3ad                	bnez	a5,80002c0c <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002bac:	00003797          	auipc	a5,0x3
    80002bb0:	37478793          	addi	a5,a5,884 # 80005f20 <kernelvec>
    80002bb4:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80002bb8:	fffff097          	auipc	ra,0xfffff
    80002bbc:	eda080e7          	jalr	-294(ra) # 80001a92 <myproc>
    80002bc0:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80002bc2:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002bc4:	14102773          	csrr	a4,sepc
    80002bc8:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002bca:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80002bce:	47a1                	li	a5,8
    80002bd0:	04f71c63          	bne	a4,a5,80002c28 <usertrap+0x92>
    if(p->killed)
    80002bd4:	551c                	lw	a5,40(a0)
    80002bd6:	e3b9                	bnez	a5,80002c1c <usertrap+0x86>
    p->trapframe->epc += 4;
    80002bd8:	6cb8                	ld	a4,88(s1)
    80002bda:	6f1c                	ld	a5,24(a4)
    80002bdc:	0791                	addi	a5,a5,4
    80002bde:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002be0:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002be4:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002be8:	10079073          	csrw	sstatus,a5
    syscall();
    80002bec:	00000097          	auipc	ra,0x0
    80002bf0:	2e0080e7          	jalr	736(ra) # 80002ecc <syscall>
  if(p->killed)
    80002bf4:	549c                	lw	a5,40(s1)
    80002bf6:	ebc1                	bnez	a5,80002c86 <usertrap+0xf0>
  usertrapret();
    80002bf8:	00000097          	auipc	ra,0x0
    80002bfc:	e18080e7          	jalr	-488(ra) # 80002a10 <usertrapret>
}
    80002c00:	60e2                	ld	ra,24(sp)
    80002c02:	6442                	ld	s0,16(sp)
    80002c04:	64a2                	ld	s1,8(sp)
    80002c06:	6902                	ld	s2,0(sp)
    80002c08:	6105                	addi	sp,sp,32
    80002c0a:	8082                	ret
    panic("usertrap: not from user mode");
    80002c0c:	00005517          	auipc	a0,0x5
    80002c10:	78450513          	addi	a0,a0,1924 # 80008390 <states.0+0x58>
    80002c14:	ffffe097          	auipc	ra,0xffffe
    80002c18:	924080e7          	jalr	-1756(ra) # 80000538 <panic>
      exit(-1);
    80002c1c:	557d                	li	a0,-1
    80002c1e:	fffff097          	auipc	ra,0xfffff
    80002c22:	7da080e7          	jalr	2010(ra) # 800023f8 <exit>
    80002c26:	bf4d                	j	80002bd8 <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    80002c28:	00000097          	auipc	ra,0x0
    80002c2c:	ecc080e7          	jalr	-308(ra) # 80002af4 <devintr>
    80002c30:	892a                	mv	s2,a0
    80002c32:	c501                	beqz	a0,80002c3a <usertrap+0xa4>
  if(p->killed)
    80002c34:	549c                	lw	a5,40(s1)
    80002c36:	c3a1                	beqz	a5,80002c76 <usertrap+0xe0>
    80002c38:	a815                	j	80002c6c <usertrap+0xd6>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002c3a:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80002c3e:	5890                	lw	a2,48(s1)
    80002c40:	00005517          	auipc	a0,0x5
    80002c44:	77050513          	addi	a0,a0,1904 # 800083b0 <states.0+0x78>
    80002c48:	ffffe097          	auipc	ra,0xffffe
    80002c4c:	93a080e7          	jalr	-1734(ra) # 80000582 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002c50:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002c54:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002c58:	00005517          	auipc	a0,0x5
    80002c5c:	78850513          	addi	a0,a0,1928 # 800083e0 <states.0+0xa8>
    80002c60:	ffffe097          	auipc	ra,0xffffe
    80002c64:	922080e7          	jalr	-1758(ra) # 80000582 <printf>
    p->killed = 1;
    80002c68:	4785                	li	a5,1
    80002c6a:	d49c                	sw	a5,40(s1)
    exit(-1);
    80002c6c:	557d                	li	a0,-1
    80002c6e:	fffff097          	auipc	ra,0xfffff
    80002c72:	78a080e7          	jalr	1930(ra) # 800023f8 <exit>
  if(which_dev == 2)
    80002c76:	4789                	li	a5,2
    80002c78:	f8f910e3          	bne	s2,a5,80002bf8 <usertrap+0x62>
    yield();
    80002c7c:	fffff097          	auipc	ra,0xfffff
    80002c80:	4b8080e7          	jalr	1208(ra) # 80002134 <yield>
    80002c84:	bf95                	j	80002bf8 <usertrap+0x62>
  int which_dev = 0;
    80002c86:	4901                	li	s2,0
    80002c88:	b7d5                	j	80002c6c <usertrap+0xd6>

0000000080002c8a <kerneltrap>:
{
    80002c8a:	7179                	addi	sp,sp,-48
    80002c8c:	f406                	sd	ra,40(sp)
    80002c8e:	f022                	sd	s0,32(sp)
    80002c90:	ec26                	sd	s1,24(sp)
    80002c92:	e84a                	sd	s2,16(sp)
    80002c94:	e44e                	sd	s3,8(sp)
    80002c96:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002c98:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002c9c:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002ca0:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80002ca4:	1004f793          	andi	a5,s1,256
    80002ca8:	cb85                	beqz	a5,80002cd8 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002caa:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80002cae:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80002cb0:	ef85                	bnez	a5,80002ce8 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80002cb2:	00000097          	auipc	ra,0x0
    80002cb6:	e42080e7          	jalr	-446(ra) # 80002af4 <devintr>
    80002cba:	cd1d                	beqz	a0,80002cf8 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002cbc:	4789                	li	a5,2
    80002cbe:	06f50a63          	beq	a0,a5,80002d32 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002cc2:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002cc6:	10049073          	csrw	sstatus,s1
}
    80002cca:	70a2                	ld	ra,40(sp)
    80002ccc:	7402                	ld	s0,32(sp)
    80002cce:	64e2                	ld	s1,24(sp)
    80002cd0:	6942                	ld	s2,16(sp)
    80002cd2:	69a2                	ld	s3,8(sp)
    80002cd4:	6145                	addi	sp,sp,48
    80002cd6:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80002cd8:	00005517          	auipc	a0,0x5
    80002cdc:	72850513          	addi	a0,a0,1832 # 80008400 <states.0+0xc8>
    80002ce0:	ffffe097          	auipc	ra,0xffffe
    80002ce4:	858080e7          	jalr	-1960(ra) # 80000538 <panic>
    panic("kerneltrap: interrupts enabled");
    80002ce8:	00005517          	auipc	a0,0x5
    80002cec:	74050513          	addi	a0,a0,1856 # 80008428 <states.0+0xf0>
    80002cf0:	ffffe097          	auipc	ra,0xffffe
    80002cf4:	848080e7          	jalr	-1976(ra) # 80000538 <panic>
    printf("scause %p\n", scause);
    80002cf8:	85ce                	mv	a1,s3
    80002cfa:	00005517          	auipc	a0,0x5
    80002cfe:	74e50513          	addi	a0,a0,1870 # 80008448 <states.0+0x110>
    80002d02:	ffffe097          	auipc	ra,0xffffe
    80002d06:	880080e7          	jalr	-1920(ra) # 80000582 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002d0a:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002d0e:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002d12:	00005517          	auipc	a0,0x5
    80002d16:	74650513          	addi	a0,a0,1862 # 80008458 <states.0+0x120>
    80002d1a:	ffffe097          	auipc	ra,0xffffe
    80002d1e:	868080e7          	jalr	-1944(ra) # 80000582 <printf>
    panic("kerneltrap");
    80002d22:	00005517          	auipc	a0,0x5
    80002d26:	74e50513          	addi	a0,a0,1870 # 80008470 <states.0+0x138>
    80002d2a:	ffffe097          	auipc	ra,0xffffe
    80002d2e:	80e080e7          	jalr	-2034(ra) # 80000538 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002d32:	fffff097          	auipc	ra,0xfffff
    80002d36:	d60080e7          	jalr	-672(ra) # 80001a92 <myproc>
    80002d3a:	d541                	beqz	a0,80002cc2 <kerneltrap+0x38>
    80002d3c:	fffff097          	auipc	ra,0xfffff
    80002d40:	d56080e7          	jalr	-682(ra) # 80001a92 <myproc>
    80002d44:	4d18                	lw	a4,24(a0)
    80002d46:	4791                	li	a5,4
    80002d48:	f6f71de3          	bne	a4,a5,80002cc2 <kerneltrap+0x38>
    yield();
    80002d4c:	fffff097          	auipc	ra,0xfffff
    80002d50:	3e8080e7          	jalr	1000(ra) # 80002134 <yield>
    80002d54:	b7bd                	j	80002cc2 <kerneltrap+0x38>

0000000080002d56 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002d56:	1101                	addi	sp,sp,-32
    80002d58:	ec06                	sd	ra,24(sp)
    80002d5a:	e822                	sd	s0,16(sp)
    80002d5c:	e426                	sd	s1,8(sp)
    80002d5e:	1000                	addi	s0,sp,32
    80002d60:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80002d62:	fffff097          	auipc	ra,0xfffff
    80002d66:	d30080e7          	jalr	-720(ra) # 80001a92 <myproc>
  switch (n) {
    80002d6a:	4795                	li	a5,5
    80002d6c:	0497e163          	bltu	a5,s1,80002dae <argraw+0x58>
    80002d70:	048a                	slli	s1,s1,0x2
    80002d72:	00005717          	auipc	a4,0x5
    80002d76:	73670713          	addi	a4,a4,1846 # 800084a8 <states.0+0x170>
    80002d7a:	94ba                	add	s1,s1,a4
    80002d7c:	409c                	lw	a5,0(s1)
    80002d7e:	97ba                	add	a5,a5,a4
    80002d80:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80002d82:	6d3c                	ld	a5,88(a0)
    80002d84:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002d86:	60e2                	ld	ra,24(sp)
    80002d88:	6442                	ld	s0,16(sp)
    80002d8a:	64a2                	ld	s1,8(sp)
    80002d8c:	6105                	addi	sp,sp,32
    80002d8e:	8082                	ret
    return p->trapframe->a1;
    80002d90:	6d3c                	ld	a5,88(a0)
    80002d92:	7fa8                	ld	a0,120(a5)
    80002d94:	bfcd                	j	80002d86 <argraw+0x30>
    return p->trapframe->a2;
    80002d96:	6d3c                	ld	a5,88(a0)
    80002d98:	63c8                	ld	a0,128(a5)
    80002d9a:	b7f5                	j	80002d86 <argraw+0x30>
    return p->trapframe->a3;
    80002d9c:	6d3c                	ld	a5,88(a0)
    80002d9e:	67c8                	ld	a0,136(a5)
    80002da0:	b7dd                	j	80002d86 <argraw+0x30>
    return p->trapframe->a4;
    80002da2:	6d3c                	ld	a5,88(a0)
    80002da4:	6bc8                	ld	a0,144(a5)
    80002da6:	b7c5                	j	80002d86 <argraw+0x30>
    return p->trapframe->a5;
    80002da8:	6d3c                	ld	a5,88(a0)
    80002daa:	6fc8                	ld	a0,152(a5)
    80002dac:	bfe9                	j	80002d86 <argraw+0x30>
  panic("argraw");
    80002dae:	00005517          	auipc	a0,0x5
    80002db2:	6d250513          	addi	a0,a0,1746 # 80008480 <states.0+0x148>
    80002db6:	ffffd097          	auipc	ra,0xffffd
    80002dba:	782080e7          	jalr	1922(ra) # 80000538 <panic>

0000000080002dbe <fetchaddr>:
{
    80002dbe:	1101                	addi	sp,sp,-32
    80002dc0:	ec06                	sd	ra,24(sp)
    80002dc2:	e822                	sd	s0,16(sp)
    80002dc4:	e426                	sd	s1,8(sp)
    80002dc6:	e04a                	sd	s2,0(sp)
    80002dc8:	1000                	addi	s0,sp,32
    80002dca:	84aa                	mv	s1,a0
    80002dcc:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002dce:	fffff097          	auipc	ra,0xfffff
    80002dd2:	cc4080e7          	jalr	-828(ra) # 80001a92 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80002dd6:	653c                	ld	a5,72(a0)
    80002dd8:	02f4f863          	bgeu	s1,a5,80002e08 <fetchaddr+0x4a>
    80002ddc:	00848713          	addi	a4,s1,8
    80002de0:	02e7e663          	bltu	a5,a4,80002e0c <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002de4:	46a1                	li	a3,8
    80002de6:	8626                	mv	a2,s1
    80002de8:	85ca                	mv	a1,s2
    80002dea:	6928                	ld	a0,80(a0)
    80002dec:	fffff097          	auipc	ra,0xfffff
    80002df0:	8f6080e7          	jalr	-1802(ra) # 800016e2 <copyin>
    80002df4:	00a03533          	snez	a0,a0
    80002df8:	40a00533          	neg	a0,a0
}
    80002dfc:	60e2                	ld	ra,24(sp)
    80002dfe:	6442                	ld	s0,16(sp)
    80002e00:	64a2                	ld	s1,8(sp)
    80002e02:	6902                	ld	s2,0(sp)
    80002e04:	6105                	addi	sp,sp,32
    80002e06:	8082                	ret
    return -1;
    80002e08:	557d                	li	a0,-1
    80002e0a:	bfcd                	j	80002dfc <fetchaddr+0x3e>
    80002e0c:	557d                	li	a0,-1
    80002e0e:	b7fd                	j	80002dfc <fetchaddr+0x3e>

0000000080002e10 <fetchstr>:
{
    80002e10:	7179                	addi	sp,sp,-48
    80002e12:	f406                	sd	ra,40(sp)
    80002e14:	f022                	sd	s0,32(sp)
    80002e16:	ec26                	sd	s1,24(sp)
    80002e18:	e84a                	sd	s2,16(sp)
    80002e1a:	e44e                	sd	s3,8(sp)
    80002e1c:	1800                	addi	s0,sp,48
    80002e1e:	892a                	mv	s2,a0
    80002e20:	84ae                	mv	s1,a1
    80002e22:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80002e24:	fffff097          	auipc	ra,0xfffff
    80002e28:	c6e080e7          	jalr	-914(ra) # 80001a92 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    80002e2c:	86ce                	mv	a3,s3
    80002e2e:	864a                	mv	a2,s2
    80002e30:	85a6                	mv	a1,s1
    80002e32:	6928                	ld	a0,80(a0)
    80002e34:	fffff097          	auipc	ra,0xfffff
    80002e38:	93c080e7          	jalr	-1732(ra) # 80001770 <copyinstr>
  if(err < 0)
    80002e3c:	00054763          	bltz	a0,80002e4a <fetchstr+0x3a>
  return strlen(buf);
    80002e40:	8526                	mv	a0,s1
    80002e42:	ffffe097          	auipc	ra,0xffffe
    80002e46:	006080e7          	jalr	6(ra) # 80000e48 <strlen>
}
    80002e4a:	70a2                	ld	ra,40(sp)
    80002e4c:	7402                	ld	s0,32(sp)
    80002e4e:	64e2                	ld	s1,24(sp)
    80002e50:	6942                	ld	s2,16(sp)
    80002e52:	69a2                	ld	s3,8(sp)
    80002e54:	6145                	addi	sp,sp,48
    80002e56:	8082                	ret

0000000080002e58 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80002e58:	1101                	addi	sp,sp,-32
    80002e5a:	ec06                	sd	ra,24(sp)
    80002e5c:	e822                	sd	s0,16(sp)
    80002e5e:	e426                	sd	s1,8(sp)
    80002e60:	1000                	addi	s0,sp,32
    80002e62:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002e64:	00000097          	auipc	ra,0x0
    80002e68:	ef2080e7          	jalr	-270(ra) # 80002d56 <argraw>
    80002e6c:	c088                	sw	a0,0(s1)
  return 0;
}
    80002e6e:	4501                	li	a0,0
    80002e70:	60e2                	ld	ra,24(sp)
    80002e72:	6442                	ld	s0,16(sp)
    80002e74:	64a2                	ld	s1,8(sp)
    80002e76:	6105                	addi	sp,sp,32
    80002e78:	8082                	ret

0000000080002e7a <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80002e7a:	1101                	addi	sp,sp,-32
    80002e7c:	ec06                	sd	ra,24(sp)
    80002e7e:	e822                	sd	s0,16(sp)
    80002e80:	e426                	sd	s1,8(sp)
    80002e82:	1000                	addi	s0,sp,32
    80002e84:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002e86:	00000097          	auipc	ra,0x0
    80002e8a:	ed0080e7          	jalr	-304(ra) # 80002d56 <argraw>
    80002e8e:	e088                	sd	a0,0(s1)
  return 0;
}
    80002e90:	4501                	li	a0,0
    80002e92:	60e2                	ld	ra,24(sp)
    80002e94:	6442                	ld	s0,16(sp)
    80002e96:	64a2                	ld	s1,8(sp)
    80002e98:	6105                	addi	sp,sp,32
    80002e9a:	8082                	ret

0000000080002e9c <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002e9c:	1101                	addi	sp,sp,-32
    80002e9e:	ec06                	sd	ra,24(sp)
    80002ea0:	e822                	sd	s0,16(sp)
    80002ea2:	e426                	sd	s1,8(sp)
    80002ea4:	e04a                	sd	s2,0(sp)
    80002ea6:	1000                	addi	s0,sp,32
    80002ea8:	84ae                	mv	s1,a1
    80002eaa:	8932                	mv	s2,a2
  *ip = argraw(n);
    80002eac:	00000097          	auipc	ra,0x0
    80002eb0:	eaa080e7          	jalr	-342(ra) # 80002d56 <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80002eb4:	864a                	mv	a2,s2
    80002eb6:	85a6                	mv	a1,s1
    80002eb8:	00000097          	auipc	ra,0x0
    80002ebc:	f58080e7          	jalr	-168(ra) # 80002e10 <fetchstr>
}
    80002ec0:	60e2                	ld	ra,24(sp)
    80002ec2:	6442                	ld	s0,16(sp)
    80002ec4:	64a2                	ld	s1,8(sp)
    80002ec6:	6902                	ld	s2,0(sp)
    80002ec8:	6105                	addi	sp,sp,32
    80002eca:	8082                	ret

0000000080002ecc <syscall>:
[SYS_join]    sys_join
};

void
syscall(void)
{
    80002ecc:	1101                	addi	sp,sp,-32
    80002ece:	ec06                	sd	ra,24(sp)
    80002ed0:	e822                	sd	s0,16(sp)
    80002ed2:	e426                	sd	s1,8(sp)
    80002ed4:	e04a                	sd	s2,0(sp)
    80002ed6:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002ed8:	fffff097          	auipc	ra,0xfffff
    80002edc:	bba080e7          	jalr	-1094(ra) # 80001a92 <myproc>
    80002ee0:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80002ee2:	05853903          	ld	s2,88(a0)
    80002ee6:	0a893783          	ld	a5,168(s2)
    80002eea:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002eee:	37fd                	addiw	a5,a5,-1
    80002ef0:	4759                	li	a4,22
    80002ef2:	00f76f63          	bltu	a4,a5,80002f10 <syscall+0x44>
    80002ef6:	00369713          	slli	a4,a3,0x3
    80002efa:	00005797          	auipc	a5,0x5
    80002efe:	5c678793          	addi	a5,a5,1478 # 800084c0 <syscalls>
    80002f02:	97ba                	add	a5,a5,a4
    80002f04:	639c                	ld	a5,0(a5)
    80002f06:	c789                	beqz	a5,80002f10 <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    80002f08:	9782                	jalr	a5
    80002f0a:	06a93823          	sd	a0,112(s2)
    80002f0e:	a839                	j	80002f2c <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002f10:	15848613          	addi	a2,s1,344
    80002f14:	588c                	lw	a1,48(s1)
    80002f16:	00005517          	auipc	a0,0x5
    80002f1a:	57250513          	addi	a0,a0,1394 # 80008488 <states.0+0x150>
    80002f1e:	ffffd097          	auipc	ra,0xffffd
    80002f22:	664080e7          	jalr	1636(ra) # 80000582 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80002f26:	6cbc                	ld	a5,88(s1)
    80002f28:	577d                	li	a4,-1
    80002f2a:	fbb8                	sd	a4,112(a5)
  }
}
    80002f2c:	60e2                	ld	ra,24(sp)
    80002f2e:	6442                	ld	s0,16(sp)
    80002f30:	64a2                	ld	s1,8(sp)
    80002f32:	6902                	ld	s2,0(sp)
    80002f34:	6105                	addi	sp,sp,32
    80002f36:	8082                	ret

0000000080002f38 <sys_clone>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_clone (void)
{
    80002f38:	7179                	addi	sp,sp,-48
    80002f3a:	f406                	sd	ra,40(sp)
    80002f3c:	f022                	sd	s0,32(sp)
    80002f3e:	1800                	addi	s0,sp,48
  uint64 stack;
  uint64 arg;
  uint64 fcn;

   //obtenemos puntero función
   if(argaddr(2, &fcn) < 0){
    80002f40:	fd840593          	addi	a1,s0,-40
    80002f44:	4509                	li	a0,2
    80002f46:	00000097          	auipc	ra,0x0
    80002f4a:	f34080e7          	jalr	-204(ra) # 80002e7a <argaddr>
     return -1;
    80002f4e:	57fd                	li	a5,-1
   if(argaddr(2, &fcn) < 0){
    80002f50:	04054163          	bltz	a0,80002f92 <sys_clone+0x5a>
   }

   //obtenemos puntero a argumento de función
   if(argaddr(1, &arg) < 0){
    80002f54:	fe040593          	addi	a1,s0,-32
    80002f58:	4505                	li	a0,1
    80002f5a:	00000097          	auipc	ra,0x0
    80002f5e:	f20080e7          	jalr	-224(ra) # 80002e7a <argaddr>
     return -1;
    80002f62:	57fd                	li	a5,-1
   if(argaddr(1, &arg) < 0){
    80002f64:	02054763          	bltz	a0,80002f92 <sys_clone+0x5a>
   }

   //obtenemos putnero a stack de usuario
   if(argaddr(0, &stack) < 0){
    80002f68:	fe840593          	addi	a1,s0,-24
    80002f6c:	4501                	li	a0,0
    80002f6e:	00000097          	auipc	ra,0x0
    80002f72:	f0c080e7          	jalr	-244(ra) # 80002e7a <argaddr>
     return -1;
    80002f76:	57fd                	li	a5,-1
   if(argaddr(0, &stack) < 0){
    80002f78:	00054d63          	bltz	a0,80002f92 <sys_clone+0x5a>
   }

  return clone((void *)fcn, (void *)arg, (void *)stack);
    80002f7c:	fe843603          	ld	a2,-24(s0)
    80002f80:	fe043583          	ld	a1,-32(s0)
    80002f84:	fd843503          	ld	a0,-40(s0)
    80002f88:	fffff097          	auipc	ra,0xfffff
    80002f8c:	722080e7          	jalr	1826(ra) # 800026aa <clone>
    80002f90:	87aa                	mv	a5,a0
}
    80002f92:	853e                	mv	a0,a5
    80002f94:	70a2                	ld	ra,40(sp)
    80002f96:	7402                	ld	s0,32(sp)
    80002f98:	6145                	addi	sp,sp,48
    80002f9a:	8082                	ret

0000000080002f9c <sys_join>:

uint64
sys_join (void)
{
    80002f9c:	1101                	addi	sp,sp,-32
    80002f9e:	ec06                	sd	ra,24(sp)
    80002fa0:	e822                	sd	s0,16(sp)
    80002fa2:	1000                	addi	s0,sp,32
  uint64 stack;
  if(argaddr(0, &stack) < 0){
    80002fa4:	fe840593          	addi	a1,s0,-24
    80002fa8:	4501                	li	a0,0
    80002faa:	00000097          	auipc	ra,0x0
    80002fae:	ed0080e7          	jalr	-304(ra) # 80002e7a <argaddr>
    80002fb2:	87aa                	mv	a5,a0
     return -1;
    80002fb4:	557d                	li	a0,-1
  if(argaddr(0, &stack) < 0){
    80002fb6:	0007c863          	bltz	a5,80002fc6 <sys_join+0x2a>
  }

  return join ((void **)stack);
    80002fba:	fe843503          	ld	a0,-24(s0)
    80002fbe:	00000097          	auipc	ra,0x0
    80002fc2:	880080e7          	jalr	-1920(ra) # 8000283e <join>
}
    80002fc6:	60e2                	ld	ra,24(sp)
    80002fc8:	6442                	ld	s0,16(sp)
    80002fca:	6105                	addi	sp,sp,32
    80002fcc:	8082                	ret

0000000080002fce <sys_exit>:


uint64
sys_exit(void)
{
    80002fce:	1101                	addi	sp,sp,-32
    80002fd0:	ec06                	sd	ra,24(sp)
    80002fd2:	e822                	sd	s0,16(sp)
    80002fd4:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80002fd6:	fec40593          	addi	a1,s0,-20
    80002fda:	4501                	li	a0,0
    80002fdc:	00000097          	auipc	ra,0x0
    80002fe0:	e7c080e7          	jalr	-388(ra) # 80002e58 <argint>
    return -1;
    80002fe4:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002fe6:	00054963          	bltz	a0,80002ff8 <sys_exit+0x2a>
  exit(n);
    80002fea:	fec42503          	lw	a0,-20(s0)
    80002fee:	fffff097          	auipc	ra,0xfffff
    80002ff2:	40a080e7          	jalr	1034(ra) # 800023f8 <exit>
  return 0;  // not reached
    80002ff6:	4781                	li	a5,0
}
    80002ff8:	853e                	mv	a0,a5
    80002ffa:	60e2                	ld	ra,24(sp)
    80002ffc:	6442                	ld	s0,16(sp)
    80002ffe:	6105                	addi	sp,sp,32
    80003000:	8082                	ret

0000000080003002 <sys_getpid>:

uint64
sys_getpid(void)
{
    80003002:	1141                	addi	sp,sp,-16
    80003004:	e406                	sd	ra,8(sp)
    80003006:	e022                	sd	s0,0(sp)
    80003008:	0800                	addi	s0,sp,16
  return myproc()->pid;
    8000300a:	fffff097          	auipc	ra,0xfffff
    8000300e:	a88080e7          	jalr	-1400(ra) # 80001a92 <myproc>
}
    80003012:	5908                	lw	a0,48(a0)
    80003014:	60a2                	ld	ra,8(sp)
    80003016:	6402                	ld	s0,0(sp)
    80003018:	0141                	addi	sp,sp,16
    8000301a:	8082                	ret

000000008000301c <sys_fork>:

uint64
sys_fork(void)
{
    8000301c:	1141                	addi	sp,sp,-16
    8000301e:	e406                	sd	ra,8(sp)
    80003020:	e022                	sd	s0,0(sp)
    80003022:	0800                	addi	s0,sp,16
  return fork();
    80003024:	fffff097          	auipc	ra,0xfffff
    80003028:	e54080e7          	jalr	-428(ra) # 80001e78 <fork>
}
    8000302c:	60a2                	ld	ra,8(sp)
    8000302e:	6402                	ld	s0,0(sp)
    80003030:	0141                	addi	sp,sp,16
    80003032:	8082                	ret

0000000080003034 <sys_wait>:

uint64
sys_wait(void)
{
    80003034:	1101                	addi	sp,sp,-32
    80003036:	ec06                	sd	ra,24(sp)
    80003038:	e822                	sd	s0,16(sp)
    8000303a:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    8000303c:	fe840593          	addi	a1,s0,-24
    80003040:	4501                	li	a0,0
    80003042:	00000097          	auipc	ra,0x0
    80003046:	e38080e7          	jalr	-456(ra) # 80002e7a <argaddr>
    8000304a:	87aa                	mv	a5,a0
    return -1;
    8000304c:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    8000304e:	0007c863          	bltz	a5,8000305e <sys_wait+0x2a>
  return wait(p);
    80003052:	fe843503          	ld	a0,-24(s0)
    80003056:	fffff097          	auipc	ra,0xfffff
    8000305a:	17e080e7          	jalr	382(ra) # 800021d4 <wait>
}
    8000305e:	60e2                	ld	ra,24(sp)
    80003060:	6442                	ld	s0,16(sp)
    80003062:	6105                	addi	sp,sp,32
    80003064:	8082                	ret

0000000080003066 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80003066:	7179                	addi	sp,sp,-48
    80003068:	f406                	sd	ra,40(sp)
    8000306a:	f022                	sd	s0,32(sp)
    8000306c:	ec26                	sd	s1,24(sp)
    8000306e:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80003070:	fdc40593          	addi	a1,s0,-36
    80003074:	4501                	li	a0,0
    80003076:	00000097          	auipc	ra,0x0
    8000307a:	de2080e7          	jalr	-542(ra) # 80002e58 <argint>
    return -1;
    8000307e:	54fd                	li	s1,-1
  if(argint(0, &n) < 0)
    80003080:	00054f63          	bltz	a0,8000309e <sys_sbrk+0x38>
  addr = myproc()->sz;
    80003084:	fffff097          	auipc	ra,0xfffff
    80003088:	a0e080e7          	jalr	-1522(ra) # 80001a92 <myproc>
    8000308c:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    8000308e:	fdc42503          	lw	a0,-36(s0)
    80003092:	fffff097          	auipc	ra,0xfffff
    80003096:	d72080e7          	jalr	-654(ra) # 80001e04 <growproc>
    8000309a:	00054863          	bltz	a0,800030aa <sys_sbrk+0x44>
    return -1;
  return addr;
}
    8000309e:	8526                	mv	a0,s1
    800030a0:	70a2                	ld	ra,40(sp)
    800030a2:	7402                	ld	s0,32(sp)
    800030a4:	64e2                	ld	s1,24(sp)
    800030a6:	6145                	addi	sp,sp,48
    800030a8:	8082                	ret
    return -1;
    800030aa:	54fd                	li	s1,-1
    800030ac:	bfcd                	j	8000309e <sys_sbrk+0x38>

00000000800030ae <sys_sleep>:

uint64
sys_sleep(void)
{
    800030ae:	7139                	addi	sp,sp,-64
    800030b0:	fc06                	sd	ra,56(sp)
    800030b2:	f822                	sd	s0,48(sp)
    800030b4:	f426                	sd	s1,40(sp)
    800030b6:	f04a                	sd	s2,32(sp)
    800030b8:	ec4e                	sd	s3,24(sp)
    800030ba:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    800030bc:	fcc40593          	addi	a1,s0,-52
    800030c0:	4501                	li	a0,0
    800030c2:	00000097          	auipc	ra,0x0
    800030c6:	d96080e7          	jalr	-618(ra) # 80002e58 <argint>
    return -1;
    800030ca:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800030cc:	06054563          	bltz	a0,80003136 <sys_sleep+0x88>
  acquire(&tickslock);
    800030d0:	00414517          	auipc	a0,0x414
    800030d4:	60050513          	addi	a0,a0,1536 # 804176d0 <tickslock>
    800030d8:	ffffe097          	auipc	ra,0xffffe
    800030dc:	af8080e7          	jalr	-1288(ra) # 80000bd0 <acquire>
  ticks0 = ticks;
    800030e0:	00006917          	auipc	s2,0x6
    800030e4:	f5092903          	lw	s2,-176(s2) # 80009030 <ticks>
  while(ticks - ticks0 < n){
    800030e8:	fcc42783          	lw	a5,-52(s0)
    800030ec:	cf85                	beqz	a5,80003124 <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800030ee:	00414997          	auipc	s3,0x414
    800030f2:	5e298993          	addi	s3,s3,1506 # 804176d0 <tickslock>
    800030f6:	00006497          	auipc	s1,0x6
    800030fa:	f3a48493          	addi	s1,s1,-198 # 80009030 <ticks>
    if(myproc()->killed){
    800030fe:	fffff097          	auipc	ra,0xfffff
    80003102:	994080e7          	jalr	-1644(ra) # 80001a92 <myproc>
    80003106:	551c                	lw	a5,40(a0)
    80003108:	ef9d                	bnez	a5,80003146 <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    8000310a:	85ce                	mv	a1,s3
    8000310c:	8526                	mv	a0,s1
    8000310e:	fffff097          	auipc	ra,0xfffff
    80003112:	062080e7          	jalr	98(ra) # 80002170 <sleep>
  while(ticks - ticks0 < n){
    80003116:	409c                	lw	a5,0(s1)
    80003118:	412787bb          	subw	a5,a5,s2
    8000311c:	fcc42703          	lw	a4,-52(s0)
    80003120:	fce7efe3          	bltu	a5,a4,800030fe <sys_sleep+0x50>
  }
  release(&tickslock);
    80003124:	00414517          	auipc	a0,0x414
    80003128:	5ac50513          	addi	a0,a0,1452 # 804176d0 <tickslock>
    8000312c:	ffffe097          	auipc	ra,0xffffe
    80003130:	b58080e7          	jalr	-1192(ra) # 80000c84 <release>
  return 0;
    80003134:	4781                	li	a5,0
}
    80003136:	853e                	mv	a0,a5
    80003138:	70e2                	ld	ra,56(sp)
    8000313a:	7442                	ld	s0,48(sp)
    8000313c:	74a2                	ld	s1,40(sp)
    8000313e:	7902                	ld	s2,32(sp)
    80003140:	69e2                	ld	s3,24(sp)
    80003142:	6121                	addi	sp,sp,64
    80003144:	8082                	ret
      release(&tickslock);
    80003146:	00414517          	auipc	a0,0x414
    8000314a:	58a50513          	addi	a0,a0,1418 # 804176d0 <tickslock>
    8000314e:	ffffe097          	auipc	ra,0xffffe
    80003152:	b36080e7          	jalr	-1226(ra) # 80000c84 <release>
      return -1;
    80003156:	57fd                	li	a5,-1
    80003158:	bff9                	j	80003136 <sys_sleep+0x88>

000000008000315a <sys_kill>:

uint64
sys_kill(void)
{
    8000315a:	1101                	addi	sp,sp,-32
    8000315c:	ec06                	sd	ra,24(sp)
    8000315e:	e822                	sd	s0,16(sp)
    80003160:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80003162:	fec40593          	addi	a1,s0,-20
    80003166:	4501                	li	a0,0
    80003168:	00000097          	auipc	ra,0x0
    8000316c:	cf0080e7          	jalr	-784(ra) # 80002e58 <argint>
    80003170:	87aa                	mv	a5,a0
    return -1;
    80003172:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    80003174:	0007c863          	bltz	a5,80003184 <sys_kill+0x2a>
  return kill(pid);
    80003178:	fec42503          	lw	a0,-20(s0)
    8000317c:	fffff097          	auipc	ra,0xfffff
    80003180:	352080e7          	jalr	850(ra) # 800024ce <kill>
}
    80003184:	60e2                	ld	ra,24(sp)
    80003186:	6442                	ld	s0,16(sp)
    80003188:	6105                	addi	sp,sp,32
    8000318a:	8082                	ret

000000008000318c <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    8000318c:	1101                	addi	sp,sp,-32
    8000318e:	ec06                	sd	ra,24(sp)
    80003190:	e822                	sd	s0,16(sp)
    80003192:	e426                	sd	s1,8(sp)
    80003194:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80003196:	00414517          	auipc	a0,0x414
    8000319a:	53a50513          	addi	a0,a0,1338 # 804176d0 <tickslock>
    8000319e:	ffffe097          	auipc	ra,0xffffe
    800031a2:	a32080e7          	jalr	-1486(ra) # 80000bd0 <acquire>
  xticks = ticks;
    800031a6:	00006497          	auipc	s1,0x6
    800031aa:	e8a4a483          	lw	s1,-374(s1) # 80009030 <ticks>
  release(&tickslock);
    800031ae:	00414517          	auipc	a0,0x414
    800031b2:	52250513          	addi	a0,a0,1314 # 804176d0 <tickslock>
    800031b6:	ffffe097          	auipc	ra,0xffffe
    800031ba:	ace080e7          	jalr	-1330(ra) # 80000c84 <release>
  return xticks;
}
    800031be:	02049513          	slli	a0,s1,0x20
    800031c2:	9101                	srli	a0,a0,0x20
    800031c4:	60e2                	ld	ra,24(sp)
    800031c6:	6442                	ld	s0,16(sp)
    800031c8:	64a2                	ld	s1,8(sp)
    800031ca:	6105                	addi	sp,sp,32
    800031cc:	8082                	ret

00000000800031ce <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    800031ce:	7179                	addi	sp,sp,-48
    800031d0:	f406                	sd	ra,40(sp)
    800031d2:	f022                	sd	s0,32(sp)
    800031d4:	ec26                	sd	s1,24(sp)
    800031d6:	e84a                	sd	s2,16(sp)
    800031d8:	e44e                	sd	s3,8(sp)
    800031da:	e052                	sd	s4,0(sp)
    800031dc:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    800031de:	00005597          	auipc	a1,0x5
    800031e2:	3a258593          	addi	a1,a1,930 # 80008580 <syscalls+0xc0>
    800031e6:	00414517          	auipc	a0,0x414
    800031ea:	50250513          	addi	a0,a0,1282 # 804176e8 <bcache>
    800031ee:	ffffe097          	auipc	ra,0xffffe
    800031f2:	952080e7          	jalr	-1710(ra) # 80000b40 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    800031f6:	0041c797          	auipc	a5,0x41c
    800031fa:	4f278793          	addi	a5,a5,1266 # 8041f6e8 <bcache+0x8000>
    800031fe:	0041c717          	auipc	a4,0x41c
    80003202:	75270713          	addi	a4,a4,1874 # 8041f950 <bcache+0x8268>
    80003206:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    8000320a:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000320e:	00414497          	auipc	s1,0x414
    80003212:	4f248493          	addi	s1,s1,1266 # 80417700 <bcache+0x18>
    b->next = bcache.head.next;
    80003216:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80003218:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    8000321a:	00005a17          	auipc	s4,0x5
    8000321e:	36ea0a13          	addi	s4,s4,878 # 80008588 <syscalls+0xc8>
    b->next = bcache.head.next;
    80003222:	2b893783          	ld	a5,696(s2)
    80003226:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80003228:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    8000322c:	85d2                	mv	a1,s4
    8000322e:	01048513          	addi	a0,s1,16
    80003232:	00001097          	auipc	ra,0x1
    80003236:	4bc080e7          	jalr	1212(ra) # 800046ee <initsleeplock>
    bcache.head.next->prev = b;
    8000323a:	2b893783          	ld	a5,696(s2)
    8000323e:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80003240:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80003244:	45848493          	addi	s1,s1,1112
    80003248:	fd349de3          	bne	s1,s3,80003222 <binit+0x54>
  }
}
    8000324c:	70a2                	ld	ra,40(sp)
    8000324e:	7402                	ld	s0,32(sp)
    80003250:	64e2                	ld	s1,24(sp)
    80003252:	6942                	ld	s2,16(sp)
    80003254:	69a2                	ld	s3,8(sp)
    80003256:	6a02                	ld	s4,0(sp)
    80003258:	6145                	addi	sp,sp,48
    8000325a:	8082                	ret

000000008000325c <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    8000325c:	7179                	addi	sp,sp,-48
    8000325e:	f406                	sd	ra,40(sp)
    80003260:	f022                	sd	s0,32(sp)
    80003262:	ec26                	sd	s1,24(sp)
    80003264:	e84a                	sd	s2,16(sp)
    80003266:	e44e                	sd	s3,8(sp)
    80003268:	1800                	addi	s0,sp,48
    8000326a:	892a                	mv	s2,a0
    8000326c:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    8000326e:	00414517          	auipc	a0,0x414
    80003272:	47a50513          	addi	a0,a0,1146 # 804176e8 <bcache>
    80003276:	ffffe097          	auipc	ra,0xffffe
    8000327a:	95a080e7          	jalr	-1702(ra) # 80000bd0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    8000327e:	0041c497          	auipc	s1,0x41c
    80003282:	7224b483          	ld	s1,1826(s1) # 8041f9a0 <bcache+0x82b8>
    80003286:	0041c797          	auipc	a5,0x41c
    8000328a:	6ca78793          	addi	a5,a5,1738 # 8041f950 <bcache+0x8268>
    8000328e:	02f48f63          	beq	s1,a5,800032cc <bread+0x70>
    80003292:	873e                	mv	a4,a5
    80003294:	a021                	j	8000329c <bread+0x40>
    80003296:	68a4                	ld	s1,80(s1)
    80003298:	02e48a63          	beq	s1,a4,800032cc <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    8000329c:	449c                	lw	a5,8(s1)
    8000329e:	ff279ce3          	bne	a5,s2,80003296 <bread+0x3a>
    800032a2:	44dc                	lw	a5,12(s1)
    800032a4:	ff3799e3          	bne	a5,s3,80003296 <bread+0x3a>
      b->refcnt++;
    800032a8:	40bc                	lw	a5,64(s1)
    800032aa:	2785                	addiw	a5,a5,1
    800032ac:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800032ae:	00414517          	auipc	a0,0x414
    800032b2:	43a50513          	addi	a0,a0,1082 # 804176e8 <bcache>
    800032b6:	ffffe097          	auipc	ra,0xffffe
    800032ba:	9ce080e7          	jalr	-1586(ra) # 80000c84 <release>
      acquiresleep(&b->lock);
    800032be:	01048513          	addi	a0,s1,16
    800032c2:	00001097          	auipc	ra,0x1
    800032c6:	466080e7          	jalr	1126(ra) # 80004728 <acquiresleep>
      return b;
    800032ca:	a8b9                	j	80003328 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800032cc:	0041c497          	auipc	s1,0x41c
    800032d0:	6cc4b483          	ld	s1,1740(s1) # 8041f998 <bcache+0x82b0>
    800032d4:	0041c797          	auipc	a5,0x41c
    800032d8:	67c78793          	addi	a5,a5,1660 # 8041f950 <bcache+0x8268>
    800032dc:	00f48863          	beq	s1,a5,800032ec <bread+0x90>
    800032e0:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    800032e2:	40bc                	lw	a5,64(s1)
    800032e4:	cf81                	beqz	a5,800032fc <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800032e6:	64a4                	ld	s1,72(s1)
    800032e8:	fee49de3          	bne	s1,a4,800032e2 <bread+0x86>
  panic("bget: no buffers");
    800032ec:	00005517          	auipc	a0,0x5
    800032f0:	2a450513          	addi	a0,a0,676 # 80008590 <syscalls+0xd0>
    800032f4:	ffffd097          	auipc	ra,0xffffd
    800032f8:	244080e7          	jalr	580(ra) # 80000538 <panic>
      b->dev = dev;
    800032fc:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80003300:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80003304:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80003308:	4785                	li	a5,1
    8000330a:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000330c:	00414517          	auipc	a0,0x414
    80003310:	3dc50513          	addi	a0,a0,988 # 804176e8 <bcache>
    80003314:	ffffe097          	auipc	ra,0xffffe
    80003318:	970080e7          	jalr	-1680(ra) # 80000c84 <release>
      acquiresleep(&b->lock);
    8000331c:	01048513          	addi	a0,s1,16
    80003320:	00001097          	auipc	ra,0x1
    80003324:	408080e7          	jalr	1032(ra) # 80004728 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80003328:	409c                	lw	a5,0(s1)
    8000332a:	cb89                	beqz	a5,8000333c <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    8000332c:	8526                	mv	a0,s1
    8000332e:	70a2                	ld	ra,40(sp)
    80003330:	7402                	ld	s0,32(sp)
    80003332:	64e2                	ld	s1,24(sp)
    80003334:	6942                	ld	s2,16(sp)
    80003336:	69a2                	ld	s3,8(sp)
    80003338:	6145                	addi	sp,sp,48
    8000333a:	8082                	ret
    virtio_disk_rw(b, 0);
    8000333c:	4581                	li	a1,0
    8000333e:	8526                	mv	a0,s1
    80003340:	00003097          	auipc	ra,0x3
    80003344:	f16080e7          	jalr	-234(ra) # 80006256 <virtio_disk_rw>
    b->valid = 1;
    80003348:	4785                	li	a5,1
    8000334a:	c09c                	sw	a5,0(s1)
  return b;
    8000334c:	b7c5                	j	8000332c <bread+0xd0>

000000008000334e <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    8000334e:	1101                	addi	sp,sp,-32
    80003350:	ec06                	sd	ra,24(sp)
    80003352:	e822                	sd	s0,16(sp)
    80003354:	e426                	sd	s1,8(sp)
    80003356:	1000                	addi	s0,sp,32
    80003358:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000335a:	0541                	addi	a0,a0,16
    8000335c:	00001097          	auipc	ra,0x1
    80003360:	466080e7          	jalr	1126(ra) # 800047c2 <holdingsleep>
    80003364:	cd01                	beqz	a0,8000337c <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80003366:	4585                	li	a1,1
    80003368:	8526                	mv	a0,s1
    8000336a:	00003097          	auipc	ra,0x3
    8000336e:	eec080e7          	jalr	-276(ra) # 80006256 <virtio_disk_rw>
}
    80003372:	60e2                	ld	ra,24(sp)
    80003374:	6442                	ld	s0,16(sp)
    80003376:	64a2                	ld	s1,8(sp)
    80003378:	6105                	addi	sp,sp,32
    8000337a:	8082                	ret
    panic("bwrite");
    8000337c:	00005517          	auipc	a0,0x5
    80003380:	22c50513          	addi	a0,a0,556 # 800085a8 <syscalls+0xe8>
    80003384:	ffffd097          	auipc	ra,0xffffd
    80003388:	1b4080e7          	jalr	436(ra) # 80000538 <panic>

000000008000338c <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    8000338c:	1101                	addi	sp,sp,-32
    8000338e:	ec06                	sd	ra,24(sp)
    80003390:	e822                	sd	s0,16(sp)
    80003392:	e426                	sd	s1,8(sp)
    80003394:	e04a                	sd	s2,0(sp)
    80003396:	1000                	addi	s0,sp,32
    80003398:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000339a:	01050913          	addi	s2,a0,16
    8000339e:	854a                	mv	a0,s2
    800033a0:	00001097          	auipc	ra,0x1
    800033a4:	422080e7          	jalr	1058(ra) # 800047c2 <holdingsleep>
    800033a8:	c92d                	beqz	a0,8000341a <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    800033aa:	854a                	mv	a0,s2
    800033ac:	00001097          	auipc	ra,0x1
    800033b0:	3d2080e7          	jalr	978(ra) # 8000477e <releasesleep>

  acquire(&bcache.lock);
    800033b4:	00414517          	auipc	a0,0x414
    800033b8:	33450513          	addi	a0,a0,820 # 804176e8 <bcache>
    800033bc:	ffffe097          	auipc	ra,0xffffe
    800033c0:	814080e7          	jalr	-2028(ra) # 80000bd0 <acquire>
  b->refcnt--;
    800033c4:	40bc                	lw	a5,64(s1)
    800033c6:	37fd                	addiw	a5,a5,-1
    800033c8:	0007871b          	sext.w	a4,a5
    800033cc:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    800033ce:	eb05                	bnez	a4,800033fe <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    800033d0:	68bc                	ld	a5,80(s1)
    800033d2:	64b8                	ld	a4,72(s1)
    800033d4:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    800033d6:	64bc                	ld	a5,72(s1)
    800033d8:	68b8                	ld	a4,80(s1)
    800033da:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    800033dc:	0041c797          	auipc	a5,0x41c
    800033e0:	30c78793          	addi	a5,a5,780 # 8041f6e8 <bcache+0x8000>
    800033e4:	2b87b703          	ld	a4,696(a5)
    800033e8:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800033ea:	0041c717          	auipc	a4,0x41c
    800033ee:	56670713          	addi	a4,a4,1382 # 8041f950 <bcache+0x8268>
    800033f2:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    800033f4:	2b87b703          	ld	a4,696(a5)
    800033f8:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    800033fa:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    800033fe:	00414517          	auipc	a0,0x414
    80003402:	2ea50513          	addi	a0,a0,746 # 804176e8 <bcache>
    80003406:	ffffe097          	auipc	ra,0xffffe
    8000340a:	87e080e7          	jalr	-1922(ra) # 80000c84 <release>
}
    8000340e:	60e2                	ld	ra,24(sp)
    80003410:	6442                	ld	s0,16(sp)
    80003412:	64a2                	ld	s1,8(sp)
    80003414:	6902                	ld	s2,0(sp)
    80003416:	6105                	addi	sp,sp,32
    80003418:	8082                	ret
    panic("brelse");
    8000341a:	00005517          	auipc	a0,0x5
    8000341e:	19650513          	addi	a0,a0,406 # 800085b0 <syscalls+0xf0>
    80003422:	ffffd097          	auipc	ra,0xffffd
    80003426:	116080e7          	jalr	278(ra) # 80000538 <panic>

000000008000342a <bpin>:

void
bpin(struct buf *b) {
    8000342a:	1101                	addi	sp,sp,-32
    8000342c:	ec06                	sd	ra,24(sp)
    8000342e:	e822                	sd	s0,16(sp)
    80003430:	e426                	sd	s1,8(sp)
    80003432:	1000                	addi	s0,sp,32
    80003434:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003436:	00414517          	auipc	a0,0x414
    8000343a:	2b250513          	addi	a0,a0,690 # 804176e8 <bcache>
    8000343e:	ffffd097          	auipc	ra,0xffffd
    80003442:	792080e7          	jalr	1938(ra) # 80000bd0 <acquire>
  b->refcnt++;
    80003446:	40bc                	lw	a5,64(s1)
    80003448:	2785                	addiw	a5,a5,1
    8000344a:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000344c:	00414517          	auipc	a0,0x414
    80003450:	29c50513          	addi	a0,a0,668 # 804176e8 <bcache>
    80003454:	ffffe097          	auipc	ra,0xffffe
    80003458:	830080e7          	jalr	-2000(ra) # 80000c84 <release>
}
    8000345c:	60e2                	ld	ra,24(sp)
    8000345e:	6442                	ld	s0,16(sp)
    80003460:	64a2                	ld	s1,8(sp)
    80003462:	6105                	addi	sp,sp,32
    80003464:	8082                	ret

0000000080003466 <bunpin>:

void
bunpin(struct buf *b) {
    80003466:	1101                	addi	sp,sp,-32
    80003468:	ec06                	sd	ra,24(sp)
    8000346a:	e822                	sd	s0,16(sp)
    8000346c:	e426                	sd	s1,8(sp)
    8000346e:	1000                	addi	s0,sp,32
    80003470:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003472:	00414517          	auipc	a0,0x414
    80003476:	27650513          	addi	a0,a0,630 # 804176e8 <bcache>
    8000347a:	ffffd097          	auipc	ra,0xffffd
    8000347e:	756080e7          	jalr	1878(ra) # 80000bd0 <acquire>
  b->refcnt--;
    80003482:	40bc                	lw	a5,64(s1)
    80003484:	37fd                	addiw	a5,a5,-1
    80003486:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80003488:	00414517          	auipc	a0,0x414
    8000348c:	26050513          	addi	a0,a0,608 # 804176e8 <bcache>
    80003490:	ffffd097          	auipc	ra,0xffffd
    80003494:	7f4080e7          	jalr	2036(ra) # 80000c84 <release>
}
    80003498:	60e2                	ld	ra,24(sp)
    8000349a:	6442                	ld	s0,16(sp)
    8000349c:	64a2                	ld	s1,8(sp)
    8000349e:	6105                	addi	sp,sp,32
    800034a0:	8082                	ret

00000000800034a2 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800034a2:	1101                	addi	sp,sp,-32
    800034a4:	ec06                	sd	ra,24(sp)
    800034a6:	e822                	sd	s0,16(sp)
    800034a8:	e426                	sd	s1,8(sp)
    800034aa:	e04a                	sd	s2,0(sp)
    800034ac:	1000                	addi	s0,sp,32
    800034ae:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800034b0:	00d5d59b          	srliw	a1,a1,0xd
    800034b4:	0041d797          	auipc	a5,0x41d
    800034b8:	9107a783          	lw	a5,-1776(a5) # 8041fdc4 <sb+0x1c>
    800034bc:	9dbd                	addw	a1,a1,a5
    800034be:	00000097          	auipc	ra,0x0
    800034c2:	d9e080e7          	jalr	-610(ra) # 8000325c <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800034c6:	0074f713          	andi	a4,s1,7
    800034ca:	4785                	li	a5,1
    800034cc:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    800034d0:	14ce                	slli	s1,s1,0x33
    800034d2:	90d9                	srli	s1,s1,0x36
    800034d4:	00950733          	add	a4,a0,s1
    800034d8:	05874703          	lbu	a4,88(a4)
    800034dc:	00e7f6b3          	and	a3,a5,a4
    800034e0:	c69d                	beqz	a3,8000350e <bfree+0x6c>
    800034e2:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    800034e4:	94aa                	add	s1,s1,a0
    800034e6:	fff7c793          	not	a5,a5
    800034ea:	8ff9                	and	a5,a5,a4
    800034ec:	04f48c23          	sb	a5,88(s1)
  log_write(bp);
    800034f0:	00001097          	auipc	ra,0x1
    800034f4:	118080e7          	jalr	280(ra) # 80004608 <log_write>
  brelse(bp);
    800034f8:	854a                	mv	a0,s2
    800034fa:	00000097          	auipc	ra,0x0
    800034fe:	e92080e7          	jalr	-366(ra) # 8000338c <brelse>
}
    80003502:	60e2                	ld	ra,24(sp)
    80003504:	6442                	ld	s0,16(sp)
    80003506:	64a2                	ld	s1,8(sp)
    80003508:	6902                	ld	s2,0(sp)
    8000350a:	6105                	addi	sp,sp,32
    8000350c:	8082                	ret
    panic("freeing free block");
    8000350e:	00005517          	auipc	a0,0x5
    80003512:	0aa50513          	addi	a0,a0,170 # 800085b8 <syscalls+0xf8>
    80003516:	ffffd097          	auipc	ra,0xffffd
    8000351a:	022080e7          	jalr	34(ra) # 80000538 <panic>

000000008000351e <balloc>:
{
    8000351e:	711d                	addi	sp,sp,-96
    80003520:	ec86                	sd	ra,88(sp)
    80003522:	e8a2                	sd	s0,80(sp)
    80003524:	e4a6                	sd	s1,72(sp)
    80003526:	e0ca                	sd	s2,64(sp)
    80003528:	fc4e                	sd	s3,56(sp)
    8000352a:	f852                	sd	s4,48(sp)
    8000352c:	f456                	sd	s5,40(sp)
    8000352e:	f05a                	sd	s6,32(sp)
    80003530:	ec5e                	sd	s7,24(sp)
    80003532:	e862                	sd	s8,16(sp)
    80003534:	e466                	sd	s9,8(sp)
    80003536:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80003538:	0041d797          	auipc	a5,0x41d
    8000353c:	8747a783          	lw	a5,-1932(a5) # 8041fdac <sb+0x4>
    80003540:	cbd1                	beqz	a5,800035d4 <balloc+0xb6>
    80003542:	8baa                	mv	s7,a0
    80003544:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80003546:	0041db17          	auipc	s6,0x41d
    8000354a:	862b0b13          	addi	s6,s6,-1950 # 8041fda8 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000354e:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    80003550:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003552:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80003554:	6c89                	lui	s9,0x2
    80003556:	a831                	j	80003572 <balloc+0x54>
    brelse(bp);
    80003558:	854a                	mv	a0,s2
    8000355a:	00000097          	auipc	ra,0x0
    8000355e:	e32080e7          	jalr	-462(ra) # 8000338c <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80003562:	015c87bb          	addw	a5,s9,s5
    80003566:	00078a9b          	sext.w	s5,a5
    8000356a:	004b2703          	lw	a4,4(s6)
    8000356e:	06eaf363          	bgeu	s5,a4,800035d4 <balloc+0xb6>
    bp = bread(dev, BBLOCK(b, sb));
    80003572:	41fad79b          	sraiw	a5,s5,0x1f
    80003576:	0137d79b          	srliw	a5,a5,0x13
    8000357a:	015787bb          	addw	a5,a5,s5
    8000357e:	40d7d79b          	sraiw	a5,a5,0xd
    80003582:	01cb2583          	lw	a1,28(s6)
    80003586:	9dbd                	addw	a1,a1,a5
    80003588:	855e                	mv	a0,s7
    8000358a:	00000097          	auipc	ra,0x0
    8000358e:	cd2080e7          	jalr	-814(ra) # 8000325c <bread>
    80003592:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003594:	004b2503          	lw	a0,4(s6)
    80003598:	000a849b          	sext.w	s1,s5
    8000359c:	8662                	mv	a2,s8
    8000359e:	faa4fde3          	bgeu	s1,a0,80003558 <balloc+0x3a>
      m = 1 << (bi % 8);
    800035a2:	41f6579b          	sraiw	a5,a2,0x1f
    800035a6:	01d7d69b          	srliw	a3,a5,0x1d
    800035aa:	00c6873b          	addw	a4,a3,a2
    800035ae:	00777793          	andi	a5,a4,7
    800035b2:	9f95                	subw	a5,a5,a3
    800035b4:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800035b8:	4037571b          	sraiw	a4,a4,0x3
    800035bc:	00e906b3          	add	a3,s2,a4
    800035c0:	0586c683          	lbu	a3,88(a3)
    800035c4:	00d7f5b3          	and	a1,a5,a3
    800035c8:	cd91                	beqz	a1,800035e4 <balloc+0xc6>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800035ca:	2605                	addiw	a2,a2,1
    800035cc:	2485                	addiw	s1,s1,1
    800035ce:	fd4618e3          	bne	a2,s4,8000359e <balloc+0x80>
    800035d2:	b759                	j	80003558 <balloc+0x3a>
  panic("balloc: out of blocks");
    800035d4:	00005517          	auipc	a0,0x5
    800035d8:	ffc50513          	addi	a0,a0,-4 # 800085d0 <syscalls+0x110>
    800035dc:	ffffd097          	auipc	ra,0xffffd
    800035e0:	f5c080e7          	jalr	-164(ra) # 80000538 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    800035e4:	974a                	add	a4,a4,s2
    800035e6:	8fd5                	or	a5,a5,a3
    800035e8:	04f70c23          	sb	a5,88(a4)
        log_write(bp);
    800035ec:	854a                	mv	a0,s2
    800035ee:	00001097          	auipc	ra,0x1
    800035f2:	01a080e7          	jalr	26(ra) # 80004608 <log_write>
        brelse(bp);
    800035f6:	854a                	mv	a0,s2
    800035f8:	00000097          	auipc	ra,0x0
    800035fc:	d94080e7          	jalr	-620(ra) # 8000338c <brelse>
  bp = bread(dev, bno);
    80003600:	85a6                	mv	a1,s1
    80003602:	855e                	mv	a0,s7
    80003604:	00000097          	auipc	ra,0x0
    80003608:	c58080e7          	jalr	-936(ra) # 8000325c <bread>
    8000360c:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    8000360e:	40000613          	li	a2,1024
    80003612:	4581                	li	a1,0
    80003614:	05850513          	addi	a0,a0,88
    80003618:	ffffd097          	auipc	ra,0xffffd
    8000361c:	6b4080e7          	jalr	1716(ra) # 80000ccc <memset>
  log_write(bp);
    80003620:	854a                	mv	a0,s2
    80003622:	00001097          	auipc	ra,0x1
    80003626:	fe6080e7          	jalr	-26(ra) # 80004608 <log_write>
  brelse(bp);
    8000362a:	854a                	mv	a0,s2
    8000362c:	00000097          	auipc	ra,0x0
    80003630:	d60080e7          	jalr	-672(ra) # 8000338c <brelse>
}
    80003634:	8526                	mv	a0,s1
    80003636:	60e6                	ld	ra,88(sp)
    80003638:	6446                	ld	s0,80(sp)
    8000363a:	64a6                	ld	s1,72(sp)
    8000363c:	6906                	ld	s2,64(sp)
    8000363e:	79e2                	ld	s3,56(sp)
    80003640:	7a42                	ld	s4,48(sp)
    80003642:	7aa2                	ld	s5,40(sp)
    80003644:	7b02                	ld	s6,32(sp)
    80003646:	6be2                	ld	s7,24(sp)
    80003648:	6c42                	ld	s8,16(sp)
    8000364a:	6ca2                	ld	s9,8(sp)
    8000364c:	6125                	addi	sp,sp,96
    8000364e:	8082                	ret

0000000080003650 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80003650:	7179                	addi	sp,sp,-48
    80003652:	f406                	sd	ra,40(sp)
    80003654:	f022                	sd	s0,32(sp)
    80003656:	ec26                	sd	s1,24(sp)
    80003658:	e84a                	sd	s2,16(sp)
    8000365a:	e44e                	sd	s3,8(sp)
    8000365c:	e052                	sd	s4,0(sp)
    8000365e:	1800                	addi	s0,sp,48
    80003660:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80003662:	47ad                	li	a5,11
    80003664:	04b7fe63          	bgeu	a5,a1,800036c0 <bmap+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    80003668:	ff45849b          	addiw	s1,a1,-12
    8000366c:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    80003670:	0ff00793          	li	a5,255
    80003674:	0ae7e363          	bltu	a5,a4,8000371a <bmap+0xca>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80003678:	08052583          	lw	a1,128(a0)
    8000367c:	c5ad                	beqz	a1,800036e6 <bmap+0x96>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    8000367e:	00092503          	lw	a0,0(s2)
    80003682:	00000097          	auipc	ra,0x0
    80003686:	bda080e7          	jalr	-1062(ra) # 8000325c <bread>
    8000368a:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    8000368c:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80003690:	02049593          	slli	a1,s1,0x20
    80003694:	9181                	srli	a1,a1,0x20
    80003696:	058a                	slli	a1,a1,0x2
    80003698:	00b784b3          	add	s1,a5,a1
    8000369c:	0004a983          	lw	s3,0(s1)
    800036a0:	04098d63          	beqz	s3,800036fa <bmap+0xaa>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    800036a4:	8552                	mv	a0,s4
    800036a6:	00000097          	auipc	ra,0x0
    800036aa:	ce6080e7          	jalr	-794(ra) # 8000338c <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    800036ae:	854e                	mv	a0,s3
    800036b0:	70a2                	ld	ra,40(sp)
    800036b2:	7402                	ld	s0,32(sp)
    800036b4:	64e2                	ld	s1,24(sp)
    800036b6:	6942                	ld	s2,16(sp)
    800036b8:	69a2                	ld	s3,8(sp)
    800036ba:	6a02                	ld	s4,0(sp)
    800036bc:	6145                	addi	sp,sp,48
    800036be:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    800036c0:	02059493          	slli	s1,a1,0x20
    800036c4:	9081                	srli	s1,s1,0x20
    800036c6:	048a                	slli	s1,s1,0x2
    800036c8:	94aa                	add	s1,s1,a0
    800036ca:	0504a983          	lw	s3,80(s1)
    800036ce:	fe0990e3          	bnez	s3,800036ae <bmap+0x5e>
      ip->addrs[bn] = addr = balloc(ip->dev);
    800036d2:	4108                	lw	a0,0(a0)
    800036d4:	00000097          	auipc	ra,0x0
    800036d8:	e4a080e7          	jalr	-438(ra) # 8000351e <balloc>
    800036dc:	0005099b          	sext.w	s3,a0
    800036e0:	0534a823          	sw	s3,80(s1)
    800036e4:	b7e9                	j	800036ae <bmap+0x5e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    800036e6:	4108                	lw	a0,0(a0)
    800036e8:	00000097          	auipc	ra,0x0
    800036ec:	e36080e7          	jalr	-458(ra) # 8000351e <balloc>
    800036f0:	0005059b          	sext.w	a1,a0
    800036f4:	08b92023          	sw	a1,128(s2)
    800036f8:	b759                	j	8000367e <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    800036fa:	00092503          	lw	a0,0(s2)
    800036fe:	00000097          	auipc	ra,0x0
    80003702:	e20080e7          	jalr	-480(ra) # 8000351e <balloc>
    80003706:	0005099b          	sext.w	s3,a0
    8000370a:	0134a023          	sw	s3,0(s1)
      log_write(bp);
    8000370e:	8552                	mv	a0,s4
    80003710:	00001097          	auipc	ra,0x1
    80003714:	ef8080e7          	jalr	-264(ra) # 80004608 <log_write>
    80003718:	b771                	j	800036a4 <bmap+0x54>
  panic("bmap: out of range");
    8000371a:	00005517          	auipc	a0,0x5
    8000371e:	ece50513          	addi	a0,a0,-306 # 800085e8 <syscalls+0x128>
    80003722:	ffffd097          	auipc	ra,0xffffd
    80003726:	e16080e7          	jalr	-490(ra) # 80000538 <panic>

000000008000372a <iget>:
{
    8000372a:	7179                	addi	sp,sp,-48
    8000372c:	f406                	sd	ra,40(sp)
    8000372e:	f022                	sd	s0,32(sp)
    80003730:	ec26                	sd	s1,24(sp)
    80003732:	e84a                	sd	s2,16(sp)
    80003734:	e44e                	sd	s3,8(sp)
    80003736:	e052                	sd	s4,0(sp)
    80003738:	1800                	addi	s0,sp,48
    8000373a:	89aa                	mv	s3,a0
    8000373c:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    8000373e:	0041c517          	auipc	a0,0x41c
    80003742:	68a50513          	addi	a0,a0,1674 # 8041fdc8 <itable>
    80003746:	ffffd097          	auipc	ra,0xffffd
    8000374a:	48a080e7          	jalr	1162(ra) # 80000bd0 <acquire>
  empty = 0;
    8000374e:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80003750:	0041c497          	auipc	s1,0x41c
    80003754:	69048493          	addi	s1,s1,1680 # 8041fde0 <itable+0x18>
    80003758:	0041e697          	auipc	a3,0x41e
    8000375c:	11868693          	addi	a3,a3,280 # 80421870 <log>
    80003760:	a039                	j	8000376e <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80003762:	02090b63          	beqz	s2,80003798 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80003766:	08848493          	addi	s1,s1,136
    8000376a:	02d48a63          	beq	s1,a3,8000379e <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    8000376e:	449c                	lw	a5,8(s1)
    80003770:	fef059e3          	blez	a5,80003762 <iget+0x38>
    80003774:	4098                	lw	a4,0(s1)
    80003776:	ff3716e3          	bne	a4,s3,80003762 <iget+0x38>
    8000377a:	40d8                	lw	a4,4(s1)
    8000377c:	ff4713e3          	bne	a4,s4,80003762 <iget+0x38>
      ip->ref++;
    80003780:	2785                	addiw	a5,a5,1
    80003782:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80003784:	0041c517          	auipc	a0,0x41c
    80003788:	64450513          	addi	a0,a0,1604 # 8041fdc8 <itable>
    8000378c:	ffffd097          	auipc	ra,0xffffd
    80003790:	4f8080e7          	jalr	1272(ra) # 80000c84 <release>
      return ip;
    80003794:	8926                	mv	s2,s1
    80003796:	a03d                	j	800037c4 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80003798:	f7f9                	bnez	a5,80003766 <iget+0x3c>
    8000379a:	8926                	mv	s2,s1
    8000379c:	b7e9                	j	80003766 <iget+0x3c>
  if(empty == 0)
    8000379e:	02090c63          	beqz	s2,800037d6 <iget+0xac>
  ip->dev = dev;
    800037a2:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    800037a6:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    800037aa:	4785                	li	a5,1
    800037ac:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    800037b0:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    800037b4:	0041c517          	auipc	a0,0x41c
    800037b8:	61450513          	addi	a0,a0,1556 # 8041fdc8 <itable>
    800037bc:	ffffd097          	auipc	ra,0xffffd
    800037c0:	4c8080e7          	jalr	1224(ra) # 80000c84 <release>
}
    800037c4:	854a                	mv	a0,s2
    800037c6:	70a2                	ld	ra,40(sp)
    800037c8:	7402                	ld	s0,32(sp)
    800037ca:	64e2                	ld	s1,24(sp)
    800037cc:	6942                	ld	s2,16(sp)
    800037ce:	69a2                	ld	s3,8(sp)
    800037d0:	6a02                	ld	s4,0(sp)
    800037d2:	6145                	addi	sp,sp,48
    800037d4:	8082                	ret
    panic("iget: no inodes");
    800037d6:	00005517          	auipc	a0,0x5
    800037da:	e2a50513          	addi	a0,a0,-470 # 80008600 <syscalls+0x140>
    800037de:	ffffd097          	auipc	ra,0xffffd
    800037e2:	d5a080e7          	jalr	-678(ra) # 80000538 <panic>

00000000800037e6 <fsinit>:
fsinit(int dev) {
    800037e6:	7179                	addi	sp,sp,-48
    800037e8:	f406                	sd	ra,40(sp)
    800037ea:	f022                	sd	s0,32(sp)
    800037ec:	ec26                	sd	s1,24(sp)
    800037ee:	e84a                	sd	s2,16(sp)
    800037f0:	e44e                	sd	s3,8(sp)
    800037f2:	1800                	addi	s0,sp,48
    800037f4:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    800037f6:	4585                	li	a1,1
    800037f8:	00000097          	auipc	ra,0x0
    800037fc:	a64080e7          	jalr	-1436(ra) # 8000325c <bread>
    80003800:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80003802:	0041c997          	auipc	s3,0x41c
    80003806:	5a698993          	addi	s3,s3,1446 # 8041fda8 <sb>
    8000380a:	02000613          	li	a2,32
    8000380e:	05850593          	addi	a1,a0,88
    80003812:	854e                	mv	a0,s3
    80003814:	ffffd097          	auipc	ra,0xffffd
    80003818:	514080e7          	jalr	1300(ra) # 80000d28 <memmove>
  brelse(bp);
    8000381c:	8526                	mv	a0,s1
    8000381e:	00000097          	auipc	ra,0x0
    80003822:	b6e080e7          	jalr	-1170(ra) # 8000338c <brelse>
  if(sb.magic != FSMAGIC)
    80003826:	0009a703          	lw	a4,0(s3)
    8000382a:	102037b7          	lui	a5,0x10203
    8000382e:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80003832:	02f71263          	bne	a4,a5,80003856 <fsinit+0x70>
  initlog(dev, &sb);
    80003836:	0041c597          	auipc	a1,0x41c
    8000383a:	57258593          	addi	a1,a1,1394 # 8041fda8 <sb>
    8000383e:	854a                	mv	a0,s2
    80003840:	00001097          	auipc	ra,0x1
    80003844:	b4c080e7          	jalr	-1204(ra) # 8000438c <initlog>
}
    80003848:	70a2                	ld	ra,40(sp)
    8000384a:	7402                	ld	s0,32(sp)
    8000384c:	64e2                	ld	s1,24(sp)
    8000384e:	6942                	ld	s2,16(sp)
    80003850:	69a2                	ld	s3,8(sp)
    80003852:	6145                	addi	sp,sp,48
    80003854:	8082                	ret
    panic("invalid file system");
    80003856:	00005517          	auipc	a0,0x5
    8000385a:	dba50513          	addi	a0,a0,-582 # 80008610 <syscalls+0x150>
    8000385e:	ffffd097          	auipc	ra,0xffffd
    80003862:	cda080e7          	jalr	-806(ra) # 80000538 <panic>

0000000080003866 <iinit>:
{
    80003866:	7179                	addi	sp,sp,-48
    80003868:	f406                	sd	ra,40(sp)
    8000386a:	f022                	sd	s0,32(sp)
    8000386c:	ec26                	sd	s1,24(sp)
    8000386e:	e84a                	sd	s2,16(sp)
    80003870:	e44e                	sd	s3,8(sp)
    80003872:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80003874:	00005597          	auipc	a1,0x5
    80003878:	db458593          	addi	a1,a1,-588 # 80008628 <syscalls+0x168>
    8000387c:	0041c517          	auipc	a0,0x41c
    80003880:	54c50513          	addi	a0,a0,1356 # 8041fdc8 <itable>
    80003884:	ffffd097          	auipc	ra,0xffffd
    80003888:	2bc080e7          	jalr	700(ra) # 80000b40 <initlock>
  for(i = 0; i < NINODE; i++) {
    8000388c:	0041c497          	auipc	s1,0x41c
    80003890:	56448493          	addi	s1,s1,1380 # 8041fdf0 <itable+0x28>
    80003894:	0041e997          	auipc	s3,0x41e
    80003898:	fec98993          	addi	s3,s3,-20 # 80421880 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    8000389c:	00005917          	auipc	s2,0x5
    800038a0:	d9490913          	addi	s2,s2,-620 # 80008630 <syscalls+0x170>
    800038a4:	85ca                	mv	a1,s2
    800038a6:	8526                	mv	a0,s1
    800038a8:	00001097          	auipc	ra,0x1
    800038ac:	e46080e7          	jalr	-442(ra) # 800046ee <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    800038b0:	08848493          	addi	s1,s1,136
    800038b4:	ff3498e3          	bne	s1,s3,800038a4 <iinit+0x3e>
}
    800038b8:	70a2                	ld	ra,40(sp)
    800038ba:	7402                	ld	s0,32(sp)
    800038bc:	64e2                	ld	s1,24(sp)
    800038be:	6942                	ld	s2,16(sp)
    800038c0:	69a2                	ld	s3,8(sp)
    800038c2:	6145                	addi	sp,sp,48
    800038c4:	8082                	ret

00000000800038c6 <ialloc>:
{
    800038c6:	715d                	addi	sp,sp,-80
    800038c8:	e486                	sd	ra,72(sp)
    800038ca:	e0a2                	sd	s0,64(sp)
    800038cc:	fc26                	sd	s1,56(sp)
    800038ce:	f84a                	sd	s2,48(sp)
    800038d0:	f44e                	sd	s3,40(sp)
    800038d2:	f052                	sd	s4,32(sp)
    800038d4:	ec56                	sd	s5,24(sp)
    800038d6:	e85a                	sd	s6,16(sp)
    800038d8:	e45e                	sd	s7,8(sp)
    800038da:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    800038dc:	0041c717          	auipc	a4,0x41c
    800038e0:	4d872703          	lw	a4,1240(a4) # 8041fdb4 <sb+0xc>
    800038e4:	4785                	li	a5,1
    800038e6:	04e7fa63          	bgeu	a5,a4,8000393a <ialloc+0x74>
    800038ea:	8aaa                	mv	s5,a0
    800038ec:	8bae                	mv	s7,a1
    800038ee:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    800038f0:	0041ca17          	auipc	s4,0x41c
    800038f4:	4b8a0a13          	addi	s4,s4,1208 # 8041fda8 <sb>
    800038f8:	00048b1b          	sext.w	s6,s1
    800038fc:	0044d793          	srli	a5,s1,0x4
    80003900:	018a2583          	lw	a1,24(s4)
    80003904:	9dbd                	addw	a1,a1,a5
    80003906:	8556                	mv	a0,s5
    80003908:	00000097          	auipc	ra,0x0
    8000390c:	954080e7          	jalr	-1708(ra) # 8000325c <bread>
    80003910:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80003912:	05850993          	addi	s3,a0,88
    80003916:	00f4f793          	andi	a5,s1,15
    8000391a:	079a                	slli	a5,a5,0x6
    8000391c:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    8000391e:	00099783          	lh	a5,0(s3)
    80003922:	c785                	beqz	a5,8000394a <ialloc+0x84>
    brelse(bp);
    80003924:	00000097          	auipc	ra,0x0
    80003928:	a68080e7          	jalr	-1432(ra) # 8000338c <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    8000392c:	0485                	addi	s1,s1,1
    8000392e:	00ca2703          	lw	a4,12(s4)
    80003932:	0004879b          	sext.w	a5,s1
    80003936:	fce7e1e3          	bltu	a5,a4,800038f8 <ialloc+0x32>
  panic("ialloc: no inodes");
    8000393a:	00005517          	auipc	a0,0x5
    8000393e:	cfe50513          	addi	a0,a0,-770 # 80008638 <syscalls+0x178>
    80003942:	ffffd097          	auipc	ra,0xffffd
    80003946:	bf6080e7          	jalr	-1034(ra) # 80000538 <panic>
      memset(dip, 0, sizeof(*dip));
    8000394a:	04000613          	li	a2,64
    8000394e:	4581                	li	a1,0
    80003950:	854e                	mv	a0,s3
    80003952:	ffffd097          	auipc	ra,0xffffd
    80003956:	37a080e7          	jalr	890(ra) # 80000ccc <memset>
      dip->type = type;
    8000395a:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    8000395e:	854a                	mv	a0,s2
    80003960:	00001097          	auipc	ra,0x1
    80003964:	ca8080e7          	jalr	-856(ra) # 80004608 <log_write>
      brelse(bp);
    80003968:	854a                	mv	a0,s2
    8000396a:	00000097          	auipc	ra,0x0
    8000396e:	a22080e7          	jalr	-1502(ra) # 8000338c <brelse>
      return iget(dev, inum);
    80003972:	85da                	mv	a1,s6
    80003974:	8556                	mv	a0,s5
    80003976:	00000097          	auipc	ra,0x0
    8000397a:	db4080e7          	jalr	-588(ra) # 8000372a <iget>
}
    8000397e:	60a6                	ld	ra,72(sp)
    80003980:	6406                	ld	s0,64(sp)
    80003982:	74e2                	ld	s1,56(sp)
    80003984:	7942                	ld	s2,48(sp)
    80003986:	79a2                	ld	s3,40(sp)
    80003988:	7a02                	ld	s4,32(sp)
    8000398a:	6ae2                	ld	s5,24(sp)
    8000398c:	6b42                	ld	s6,16(sp)
    8000398e:	6ba2                	ld	s7,8(sp)
    80003990:	6161                	addi	sp,sp,80
    80003992:	8082                	ret

0000000080003994 <iupdate>:
{
    80003994:	1101                	addi	sp,sp,-32
    80003996:	ec06                	sd	ra,24(sp)
    80003998:	e822                	sd	s0,16(sp)
    8000399a:	e426                	sd	s1,8(sp)
    8000399c:	e04a                	sd	s2,0(sp)
    8000399e:	1000                	addi	s0,sp,32
    800039a0:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800039a2:	415c                	lw	a5,4(a0)
    800039a4:	0047d79b          	srliw	a5,a5,0x4
    800039a8:	0041c597          	auipc	a1,0x41c
    800039ac:	4185a583          	lw	a1,1048(a1) # 8041fdc0 <sb+0x18>
    800039b0:	9dbd                	addw	a1,a1,a5
    800039b2:	4108                	lw	a0,0(a0)
    800039b4:	00000097          	auipc	ra,0x0
    800039b8:	8a8080e7          	jalr	-1880(ra) # 8000325c <bread>
    800039bc:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    800039be:	05850793          	addi	a5,a0,88
    800039c2:	40c8                	lw	a0,4(s1)
    800039c4:	893d                	andi	a0,a0,15
    800039c6:	051a                	slli	a0,a0,0x6
    800039c8:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    800039ca:	04449703          	lh	a4,68(s1)
    800039ce:	00e51023          	sh	a4,0(a0)
  dip->major = ip->major;
    800039d2:	04649703          	lh	a4,70(s1)
    800039d6:	00e51123          	sh	a4,2(a0)
  dip->minor = ip->minor;
    800039da:	04849703          	lh	a4,72(s1)
    800039de:	00e51223          	sh	a4,4(a0)
  dip->nlink = ip->nlink;
    800039e2:	04a49703          	lh	a4,74(s1)
    800039e6:	00e51323          	sh	a4,6(a0)
  dip->size = ip->size;
    800039ea:	44f8                	lw	a4,76(s1)
    800039ec:	c518                	sw	a4,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    800039ee:	03400613          	li	a2,52
    800039f2:	05048593          	addi	a1,s1,80
    800039f6:	0531                	addi	a0,a0,12
    800039f8:	ffffd097          	auipc	ra,0xffffd
    800039fc:	330080e7          	jalr	816(ra) # 80000d28 <memmove>
  log_write(bp);
    80003a00:	854a                	mv	a0,s2
    80003a02:	00001097          	auipc	ra,0x1
    80003a06:	c06080e7          	jalr	-1018(ra) # 80004608 <log_write>
  brelse(bp);
    80003a0a:	854a                	mv	a0,s2
    80003a0c:	00000097          	auipc	ra,0x0
    80003a10:	980080e7          	jalr	-1664(ra) # 8000338c <brelse>
}
    80003a14:	60e2                	ld	ra,24(sp)
    80003a16:	6442                	ld	s0,16(sp)
    80003a18:	64a2                	ld	s1,8(sp)
    80003a1a:	6902                	ld	s2,0(sp)
    80003a1c:	6105                	addi	sp,sp,32
    80003a1e:	8082                	ret

0000000080003a20 <idup>:
{
    80003a20:	1101                	addi	sp,sp,-32
    80003a22:	ec06                	sd	ra,24(sp)
    80003a24:	e822                	sd	s0,16(sp)
    80003a26:	e426                	sd	s1,8(sp)
    80003a28:	1000                	addi	s0,sp,32
    80003a2a:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003a2c:	0041c517          	auipc	a0,0x41c
    80003a30:	39c50513          	addi	a0,a0,924 # 8041fdc8 <itable>
    80003a34:	ffffd097          	auipc	ra,0xffffd
    80003a38:	19c080e7          	jalr	412(ra) # 80000bd0 <acquire>
  ip->ref++;
    80003a3c:	449c                	lw	a5,8(s1)
    80003a3e:	2785                	addiw	a5,a5,1
    80003a40:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003a42:	0041c517          	auipc	a0,0x41c
    80003a46:	38650513          	addi	a0,a0,902 # 8041fdc8 <itable>
    80003a4a:	ffffd097          	auipc	ra,0xffffd
    80003a4e:	23a080e7          	jalr	570(ra) # 80000c84 <release>
}
    80003a52:	8526                	mv	a0,s1
    80003a54:	60e2                	ld	ra,24(sp)
    80003a56:	6442                	ld	s0,16(sp)
    80003a58:	64a2                	ld	s1,8(sp)
    80003a5a:	6105                	addi	sp,sp,32
    80003a5c:	8082                	ret

0000000080003a5e <ilock>:
{
    80003a5e:	1101                	addi	sp,sp,-32
    80003a60:	ec06                	sd	ra,24(sp)
    80003a62:	e822                	sd	s0,16(sp)
    80003a64:	e426                	sd	s1,8(sp)
    80003a66:	e04a                	sd	s2,0(sp)
    80003a68:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80003a6a:	c115                	beqz	a0,80003a8e <ilock+0x30>
    80003a6c:	84aa                	mv	s1,a0
    80003a6e:	451c                	lw	a5,8(a0)
    80003a70:	00f05f63          	blez	a5,80003a8e <ilock+0x30>
  acquiresleep(&ip->lock);
    80003a74:	0541                	addi	a0,a0,16
    80003a76:	00001097          	auipc	ra,0x1
    80003a7a:	cb2080e7          	jalr	-846(ra) # 80004728 <acquiresleep>
  if(ip->valid == 0){
    80003a7e:	40bc                	lw	a5,64(s1)
    80003a80:	cf99                	beqz	a5,80003a9e <ilock+0x40>
}
    80003a82:	60e2                	ld	ra,24(sp)
    80003a84:	6442                	ld	s0,16(sp)
    80003a86:	64a2                	ld	s1,8(sp)
    80003a88:	6902                	ld	s2,0(sp)
    80003a8a:	6105                	addi	sp,sp,32
    80003a8c:	8082                	ret
    panic("ilock");
    80003a8e:	00005517          	auipc	a0,0x5
    80003a92:	bc250513          	addi	a0,a0,-1086 # 80008650 <syscalls+0x190>
    80003a96:	ffffd097          	auipc	ra,0xffffd
    80003a9a:	aa2080e7          	jalr	-1374(ra) # 80000538 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003a9e:	40dc                	lw	a5,4(s1)
    80003aa0:	0047d79b          	srliw	a5,a5,0x4
    80003aa4:	0041c597          	auipc	a1,0x41c
    80003aa8:	31c5a583          	lw	a1,796(a1) # 8041fdc0 <sb+0x18>
    80003aac:	9dbd                	addw	a1,a1,a5
    80003aae:	4088                	lw	a0,0(s1)
    80003ab0:	fffff097          	auipc	ra,0xfffff
    80003ab4:	7ac080e7          	jalr	1964(ra) # 8000325c <bread>
    80003ab8:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003aba:	05850593          	addi	a1,a0,88
    80003abe:	40dc                	lw	a5,4(s1)
    80003ac0:	8bbd                	andi	a5,a5,15
    80003ac2:	079a                	slli	a5,a5,0x6
    80003ac4:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80003ac6:	00059783          	lh	a5,0(a1)
    80003aca:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80003ace:	00259783          	lh	a5,2(a1)
    80003ad2:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80003ad6:	00459783          	lh	a5,4(a1)
    80003ada:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80003ade:	00659783          	lh	a5,6(a1)
    80003ae2:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80003ae6:	459c                	lw	a5,8(a1)
    80003ae8:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80003aea:	03400613          	li	a2,52
    80003aee:	05b1                	addi	a1,a1,12
    80003af0:	05048513          	addi	a0,s1,80
    80003af4:	ffffd097          	auipc	ra,0xffffd
    80003af8:	234080e7          	jalr	564(ra) # 80000d28 <memmove>
    brelse(bp);
    80003afc:	854a                	mv	a0,s2
    80003afe:	00000097          	auipc	ra,0x0
    80003b02:	88e080e7          	jalr	-1906(ra) # 8000338c <brelse>
    ip->valid = 1;
    80003b06:	4785                	li	a5,1
    80003b08:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80003b0a:	04449783          	lh	a5,68(s1)
    80003b0e:	fbb5                	bnez	a5,80003a82 <ilock+0x24>
      panic("ilock: no type");
    80003b10:	00005517          	auipc	a0,0x5
    80003b14:	b4850513          	addi	a0,a0,-1208 # 80008658 <syscalls+0x198>
    80003b18:	ffffd097          	auipc	ra,0xffffd
    80003b1c:	a20080e7          	jalr	-1504(ra) # 80000538 <panic>

0000000080003b20 <iunlock>:
{
    80003b20:	1101                	addi	sp,sp,-32
    80003b22:	ec06                	sd	ra,24(sp)
    80003b24:	e822                	sd	s0,16(sp)
    80003b26:	e426                	sd	s1,8(sp)
    80003b28:	e04a                	sd	s2,0(sp)
    80003b2a:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80003b2c:	c905                	beqz	a0,80003b5c <iunlock+0x3c>
    80003b2e:	84aa                	mv	s1,a0
    80003b30:	01050913          	addi	s2,a0,16
    80003b34:	854a                	mv	a0,s2
    80003b36:	00001097          	auipc	ra,0x1
    80003b3a:	c8c080e7          	jalr	-884(ra) # 800047c2 <holdingsleep>
    80003b3e:	cd19                	beqz	a0,80003b5c <iunlock+0x3c>
    80003b40:	449c                	lw	a5,8(s1)
    80003b42:	00f05d63          	blez	a5,80003b5c <iunlock+0x3c>
  releasesleep(&ip->lock);
    80003b46:	854a                	mv	a0,s2
    80003b48:	00001097          	auipc	ra,0x1
    80003b4c:	c36080e7          	jalr	-970(ra) # 8000477e <releasesleep>
}
    80003b50:	60e2                	ld	ra,24(sp)
    80003b52:	6442                	ld	s0,16(sp)
    80003b54:	64a2                	ld	s1,8(sp)
    80003b56:	6902                	ld	s2,0(sp)
    80003b58:	6105                	addi	sp,sp,32
    80003b5a:	8082                	ret
    panic("iunlock");
    80003b5c:	00005517          	auipc	a0,0x5
    80003b60:	b0c50513          	addi	a0,a0,-1268 # 80008668 <syscalls+0x1a8>
    80003b64:	ffffd097          	auipc	ra,0xffffd
    80003b68:	9d4080e7          	jalr	-1580(ra) # 80000538 <panic>

0000000080003b6c <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80003b6c:	7179                	addi	sp,sp,-48
    80003b6e:	f406                	sd	ra,40(sp)
    80003b70:	f022                	sd	s0,32(sp)
    80003b72:	ec26                	sd	s1,24(sp)
    80003b74:	e84a                	sd	s2,16(sp)
    80003b76:	e44e                	sd	s3,8(sp)
    80003b78:	e052                	sd	s4,0(sp)
    80003b7a:	1800                	addi	s0,sp,48
    80003b7c:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80003b7e:	05050493          	addi	s1,a0,80
    80003b82:	08050913          	addi	s2,a0,128
    80003b86:	a021                	j	80003b8e <itrunc+0x22>
    80003b88:	0491                	addi	s1,s1,4
    80003b8a:	01248d63          	beq	s1,s2,80003ba4 <itrunc+0x38>
    if(ip->addrs[i]){
    80003b8e:	408c                	lw	a1,0(s1)
    80003b90:	dde5                	beqz	a1,80003b88 <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80003b92:	0009a503          	lw	a0,0(s3)
    80003b96:	00000097          	auipc	ra,0x0
    80003b9a:	90c080e7          	jalr	-1780(ra) # 800034a2 <bfree>
      ip->addrs[i] = 0;
    80003b9e:	0004a023          	sw	zero,0(s1)
    80003ba2:	b7dd                	j	80003b88 <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80003ba4:	0809a583          	lw	a1,128(s3)
    80003ba8:	e185                	bnez	a1,80003bc8 <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80003baa:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80003bae:	854e                	mv	a0,s3
    80003bb0:	00000097          	auipc	ra,0x0
    80003bb4:	de4080e7          	jalr	-540(ra) # 80003994 <iupdate>
}
    80003bb8:	70a2                	ld	ra,40(sp)
    80003bba:	7402                	ld	s0,32(sp)
    80003bbc:	64e2                	ld	s1,24(sp)
    80003bbe:	6942                	ld	s2,16(sp)
    80003bc0:	69a2                	ld	s3,8(sp)
    80003bc2:	6a02                	ld	s4,0(sp)
    80003bc4:	6145                	addi	sp,sp,48
    80003bc6:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80003bc8:	0009a503          	lw	a0,0(s3)
    80003bcc:	fffff097          	auipc	ra,0xfffff
    80003bd0:	690080e7          	jalr	1680(ra) # 8000325c <bread>
    80003bd4:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80003bd6:	05850493          	addi	s1,a0,88
    80003bda:	45850913          	addi	s2,a0,1112
    80003bde:	a021                	j	80003be6 <itrunc+0x7a>
    80003be0:	0491                	addi	s1,s1,4
    80003be2:	01248b63          	beq	s1,s2,80003bf8 <itrunc+0x8c>
      if(a[j])
    80003be6:	408c                	lw	a1,0(s1)
    80003be8:	dde5                	beqz	a1,80003be0 <itrunc+0x74>
        bfree(ip->dev, a[j]);
    80003bea:	0009a503          	lw	a0,0(s3)
    80003bee:	00000097          	auipc	ra,0x0
    80003bf2:	8b4080e7          	jalr	-1868(ra) # 800034a2 <bfree>
    80003bf6:	b7ed                	j	80003be0 <itrunc+0x74>
    brelse(bp);
    80003bf8:	8552                	mv	a0,s4
    80003bfa:	fffff097          	auipc	ra,0xfffff
    80003bfe:	792080e7          	jalr	1938(ra) # 8000338c <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80003c02:	0809a583          	lw	a1,128(s3)
    80003c06:	0009a503          	lw	a0,0(s3)
    80003c0a:	00000097          	auipc	ra,0x0
    80003c0e:	898080e7          	jalr	-1896(ra) # 800034a2 <bfree>
    ip->addrs[NDIRECT] = 0;
    80003c12:	0809a023          	sw	zero,128(s3)
    80003c16:	bf51                	j	80003baa <itrunc+0x3e>

0000000080003c18 <iput>:
{
    80003c18:	1101                	addi	sp,sp,-32
    80003c1a:	ec06                	sd	ra,24(sp)
    80003c1c:	e822                	sd	s0,16(sp)
    80003c1e:	e426                	sd	s1,8(sp)
    80003c20:	e04a                	sd	s2,0(sp)
    80003c22:	1000                	addi	s0,sp,32
    80003c24:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003c26:	0041c517          	auipc	a0,0x41c
    80003c2a:	1a250513          	addi	a0,a0,418 # 8041fdc8 <itable>
    80003c2e:	ffffd097          	auipc	ra,0xffffd
    80003c32:	fa2080e7          	jalr	-94(ra) # 80000bd0 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003c36:	4498                	lw	a4,8(s1)
    80003c38:	4785                	li	a5,1
    80003c3a:	02f70363          	beq	a4,a5,80003c60 <iput+0x48>
  ip->ref--;
    80003c3e:	449c                	lw	a5,8(s1)
    80003c40:	37fd                	addiw	a5,a5,-1
    80003c42:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003c44:	0041c517          	auipc	a0,0x41c
    80003c48:	18450513          	addi	a0,a0,388 # 8041fdc8 <itable>
    80003c4c:	ffffd097          	auipc	ra,0xffffd
    80003c50:	038080e7          	jalr	56(ra) # 80000c84 <release>
}
    80003c54:	60e2                	ld	ra,24(sp)
    80003c56:	6442                	ld	s0,16(sp)
    80003c58:	64a2                	ld	s1,8(sp)
    80003c5a:	6902                	ld	s2,0(sp)
    80003c5c:	6105                	addi	sp,sp,32
    80003c5e:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003c60:	40bc                	lw	a5,64(s1)
    80003c62:	dff1                	beqz	a5,80003c3e <iput+0x26>
    80003c64:	04a49783          	lh	a5,74(s1)
    80003c68:	fbf9                	bnez	a5,80003c3e <iput+0x26>
    acquiresleep(&ip->lock);
    80003c6a:	01048913          	addi	s2,s1,16
    80003c6e:	854a                	mv	a0,s2
    80003c70:	00001097          	auipc	ra,0x1
    80003c74:	ab8080e7          	jalr	-1352(ra) # 80004728 <acquiresleep>
    release(&itable.lock);
    80003c78:	0041c517          	auipc	a0,0x41c
    80003c7c:	15050513          	addi	a0,a0,336 # 8041fdc8 <itable>
    80003c80:	ffffd097          	auipc	ra,0xffffd
    80003c84:	004080e7          	jalr	4(ra) # 80000c84 <release>
    itrunc(ip);
    80003c88:	8526                	mv	a0,s1
    80003c8a:	00000097          	auipc	ra,0x0
    80003c8e:	ee2080e7          	jalr	-286(ra) # 80003b6c <itrunc>
    ip->type = 0;
    80003c92:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80003c96:	8526                	mv	a0,s1
    80003c98:	00000097          	auipc	ra,0x0
    80003c9c:	cfc080e7          	jalr	-772(ra) # 80003994 <iupdate>
    ip->valid = 0;
    80003ca0:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80003ca4:	854a                	mv	a0,s2
    80003ca6:	00001097          	auipc	ra,0x1
    80003caa:	ad8080e7          	jalr	-1320(ra) # 8000477e <releasesleep>
    acquire(&itable.lock);
    80003cae:	0041c517          	auipc	a0,0x41c
    80003cb2:	11a50513          	addi	a0,a0,282 # 8041fdc8 <itable>
    80003cb6:	ffffd097          	auipc	ra,0xffffd
    80003cba:	f1a080e7          	jalr	-230(ra) # 80000bd0 <acquire>
    80003cbe:	b741                	j	80003c3e <iput+0x26>

0000000080003cc0 <iunlockput>:
{
    80003cc0:	1101                	addi	sp,sp,-32
    80003cc2:	ec06                	sd	ra,24(sp)
    80003cc4:	e822                	sd	s0,16(sp)
    80003cc6:	e426                	sd	s1,8(sp)
    80003cc8:	1000                	addi	s0,sp,32
    80003cca:	84aa                	mv	s1,a0
  iunlock(ip);
    80003ccc:	00000097          	auipc	ra,0x0
    80003cd0:	e54080e7          	jalr	-428(ra) # 80003b20 <iunlock>
  iput(ip);
    80003cd4:	8526                	mv	a0,s1
    80003cd6:	00000097          	auipc	ra,0x0
    80003cda:	f42080e7          	jalr	-190(ra) # 80003c18 <iput>
}
    80003cde:	60e2                	ld	ra,24(sp)
    80003ce0:	6442                	ld	s0,16(sp)
    80003ce2:	64a2                	ld	s1,8(sp)
    80003ce4:	6105                	addi	sp,sp,32
    80003ce6:	8082                	ret

0000000080003ce8 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80003ce8:	1141                	addi	sp,sp,-16
    80003cea:	e422                	sd	s0,8(sp)
    80003cec:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80003cee:	411c                	lw	a5,0(a0)
    80003cf0:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80003cf2:	415c                	lw	a5,4(a0)
    80003cf4:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80003cf6:	04451783          	lh	a5,68(a0)
    80003cfa:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80003cfe:	04a51783          	lh	a5,74(a0)
    80003d02:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80003d06:	04c56783          	lwu	a5,76(a0)
    80003d0a:	e99c                	sd	a5,16(a1)
}
    80003d0c:	6422                	ld	s0,8(sp)
    80003d0e:	0141                	addi	sp,sp,16
    80003d10:	8082                	ret

0000000080003d12 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003d12:	457c                	lw	a5,76(a0)
    80003d14:	0ed7e963          	bltu	a5,a3,80003e06 <readi+0xf4>
{
    80003d18:	7159                	addi	sp,sp,-112
    80003d1a:	f486                	sd	ra,104(sp)
    80003d1c:	f0a2                	sd	s0,96(sp)
    80003d1e:	eca6                	sd	s1,88(sp)
    80003d20:	e8ca                	sd	s2,80(sp)
    80003d22:	e4ce                	sd	s3,72(sp)
    80003d24:	e0d2                	sd	s4,64(sp)
    80003d26:	fc56                	sd	s5,56(sp)
    80003d28:	f85a                	sd	s6,48(sp)
    80003d2a:	f45e                	sd	s7,40(sp)
    80003d2c:	f062                	sd	s8,32(sp)
    80003d2e:	ec66                	sd	s9,24(sp)
    80003d30:	e86a                	sd	s10,16(sp)
    80003d32:	e46e                	sd	s11,8(sp)
    80003d34:	1880                	addi	s0,sp,112
    80003d36:	8baa                	mv	s7,a0
    80003d38:	8c2e                	mv	s8,a1
    80003d3a:	8ab2                	mv	s5,a2
    80003d3c:	84b6                	mv	s1,a3
    80003d3e:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003d40:	9f35                	addw	a4,a4,a3
    return 0;
    80003d42:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003d44:	0ad76063          	bltu	a4,a3,80003de4 <readi+0xd2>
  if(off + n > ip->size)
    80003d48:	00e7f463          	bgeu	a5,a4,80003d50 <readi+0x3e>
    n = ip->size - off;
    80003d4c:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003d50:	0a0b0963          	beqz	s6,80003e02 <readi+0xf0>
    80003d54:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003d56:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80003d5a:	5cfd                	li	s9,-1
    80003d5c:	a82d                	j	80003d96 <readi+0x84>
    80003d5e:	020a1d93          	slli	s11,s4,0x20
    80003d62:	020ddd93          	srli	s11,s11,0x20
    80003d66:	05890793          	addi	a5,s2,88
    80003d6a:	86ee                	mv	a3,s11
    80003d6c:	963e                	add	a2,a2,a5
    80003d6e:	85d6                	mv	a1,s5
    80003d70:	8562                	mv	a0,s8
    80003d72:	ffffe097          	auipc	ra,0xffffe
    80003d76:	7d6080e7          	jalr	2006(ra) # 80002548 <either_copyout>
    80003d7a:	05950d63          	beq	a0,s9,80003dd4 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80003d7e:	854a                	mv	a0,s2
    80003d80:	fffff097          	auipc	ra,0xfffff
    80003d84:	60c080e7          	jalr	1548(ra) # 8000338c <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003d88:	013a09bb          	addw	s3,s4,s3
    80003d8c:	009a04bb          	addw	s1,s4,s1
    80003d90:	9aee                	add	s5,s5,s11
    80003d92:	0569f763          	bgeu	s3,s6,80003de0 <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003d96:	000ba903          	lw	s2,0(s7)
    80003d9a:	00a4d59b          	srliw	a1,s1,0xa
    80003d9e:	855e                	mv	a0,s7
    80003da0:	00000097          	auipc	ra,0x0
    80003da4:	8b0080e7          	jalr	-1872(ra) # 80003650 <bmap>
    80003da8:	0005059b          	sext.w	a1,a0
    80003dac:	854a                	mv	a0,s2
    80003dae:	fffff097          	auipc	ra,0xfffff
    80003db2:	4ae080e7          	jalr	1198(ra) # 8000325c <bread>
    80003db6:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003db8:	3ff4f613          	andi	a2,s1,1023
    80003dbc:	40cd07bb          	subw	a5,s10,a2
    80003dc0:	413b073b          	subw	a4,s6,s3
    80003dc4:	8a3e                	mv	s4,a5
    80003dc6:	2781                	sext.w	a5,a5
    80003dc8:	0007069b          	sext.w	a3,a4
    80003dcc:	f8f6f9e3          	bgeu	a3,a5,80003d5e <readi+0x4c>
    80003dd0:	8a3a                	mv	s4,a4
    80003dd2:	b771                	j	80003d5e <readi+0x4c>
      brelse(bp);
    80003dd4:	854a                	mv	a0,s2
    80003dd6:	fffff097          	auipc	ra,0xfffff
    80003dda:	5b6080e7          	jalr	1462(ra) # 8000338c <brelse>
      tot = -1;
    80003dde:	59fd                	li	s3,-1
  }
  return tot;
    80003de0:	0009851b          	sext.w	a0,s3
}
    80003de4:	70a6                	ld	ra,104(sp)
    80003de6:	7406                	ld	s0,96(sp)
    80003de8:	64e6                	ld	s1,88(sp)
    80003dea:	6946                	ld	s2,80(sp)
    80003dec:	69a6                	ld	s3,72(sp)
    80003dee:	6a06                	ld	s4,64(sp)
    80003df0:	7ae2                	ld	s5,56(sp)
    80003df2:	7b42                	ld	s6,48(sp)
    80003df4:	7ba2                	ld	s7,40(sp)
    80003df6:	7c02                	ld	s8,32(sp)
    80003df8:	6ce2                	ld	s9,24(sp)
    80003dfa:	6d42                	ld	s10,16(sp)
    80003dfc:	6da2                	ld	s11,8(sp)
    80003dfe:	6165                	addi	sp,sp,112
    80003e00:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003e02:	89da                	mv	s3,s6
    80003e04:	bff1                	j	80003de0 <readi+0xce>
    return 0;
    80003e06:	4501                	li	a0,0
}
    80003e08:	8082                	ret

0000000080003e0a <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003e0a:	457c                	lw	a5,76(a0)
    80003e0c:	10d7e863          	bltu	a5,a3,80003f1c <writei+0x112>
{
    80003e10:	7159                	addi	sp,sp,-112
    80003e12:	f486                	sd	ra,104(sp)
    80003e14:	f0a2                	sd	s0,96(sp)
    80003e16:	eca6                	sd	s1,88(sp)
    80003e18:	e8ca                	sd	s2,80(sp)
    80003e1a:	e4ce                	sd	s3,72(sp)
    80003e1c:	e0d2                	sd	s4,64(sp)
    80003e1e:	fc56                	sd	s5,56(sp)
    80003e20:	f85a                	sd	s6,48(sp)
    80003e22:	f45e                	sd	s7,40(sp)
    80003e24:	f062                	sd	s8,32(sp)
    80003e26:	ec66                	sd	s9,24(sp)
    80003e28:	e86a                	sd	s10,16(sp)
    80003e2a:	e46e                	sd	s11,8(sp)
    80003e2c:	1880                	addi	s0,sp,112
    80003e2e:	8b2a                	mv	s6,a0
    80003e30:	8c2e                	mv	s8,a1
    80003e32:	8ab2                	mv	s5,a2
    80003e34:	8936                	mv	s2,a3
    80003e36:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    80003e38:	00e687bb          	addw	a5,a3,a4
    80003e3c:	0ed7e263          	bltu	a5,a3,80003f20 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80003e40:	00043737          	lui	a4,0x43
    80003e44:	0ef76063          	bltu	a4,a5,80003f24 <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003e48:	0c0b8863          	beqz	s7,80003f18 <writei+0x10e>
    80003e4c:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003e4e:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003e52:	5cfd                	li	s9,-1
    80003e54:	a091                	j	80003e98 <writei+0x8e>
    80003e56:	02099d93          	slli	s11,s3,0x20
    80003e5a:	020ddd93          	srli	s11,s11,0x20
    80003e5e:	05848793          	addi	a5,s1,88
    80003e62:	86ee                	mv	a3,s11
    80003e64:	8656                	mv	a2,s5
    80003e66:	85e2                	mv	a1,s8
    80003e68:	953e                	add	a0,a0,a5
    80003e6a:	ffffe097          	auipc	ra,0xffffe
    80003e6e:	734080e7          	jalr	1844(ra) # 8000259e <either_copyin>
    80003e72:	07950263          	beq	a0,s9,80003ed6 <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80003e76:	8526                	mv	a0,s1
    80003e78:	00000097          	auipc	ra,0x0
    80003e7c:	790080e7          	jalr	1936(ra) # 80004608 <log_write>
    brelse(bp);
    80003e80:	8526                	mv	a0,s1
    80003e82:	fffff097          	auipc	ra,0xfffff
    80003e86:	50a080e7          	jalr	1290(ra) # 8000338c <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003e8a:	01498a3b          	addw	s4,s3,s4
    80003e8e:	0129893b          	addw	s2,s3,s2
    80003e92:	9aee                	add	s5,s5,s11
    80003e94:	057a7663          	bgeu	s4,s7,80003ee0 <writei+0xd6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003e98:	000b2483          	lw	s1,0(s6)
    80003e9c:	00a9559b          	srliw	a1,s2,0xa
    80003ea0:	855a                	mv	a0,s6
    80003ea2:	fffff097          	auipc	ra,0xfffff
    80003ea6:	7ae080e7          	jalr	1966(ra) # 80003650 <bmap>
    80003eaa:	0005059b          	sext.w	a1,a0
    80003eae:	8526                	mv	a0,s1
    80003eb0:	fffff097          	auipc	ra,0xfffff
    80003eb4:	3ac080e7          	jalr	940(ra) # 8000325c <bread>
    80003eb8:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003eba:	3ff97513          	andi	a0,s2,1023
    80003ebe:	40ad07bb          	subw	a5,s10,a0
    80003ec2:	414b873b          	subw	a4,s7,s4
    80003ec6:	89be                	mv	s3,a5
    80003ec8:	2781                	sext.w	a5,a5
    80003eca:	0007069b          	sext.w	a3,a4
    80003ece:	f8f6f4e3          	bgeu	a3,a5,80003e56 <writei+0x4c>
    80003ed2:	89ba                	mv	s3,a4
    80003ed4:	b749                	j	80003e56 <writei+0x4c>
      brelse(bp);
    80003ed6:	8526                	mv	a0,s1
    80003ed8:	fffff097          	auipc	ra,0xfffff
    80003edc:	4b4080e7          	jalr	1204(ra) # 8000338c <brelse>
  }

  if(off > ip->size)
    80003ee0:	04cb2783          	lw	a5,76(s6)
    80003ee4:	0127f463          	bgeu	a5,s2,80003eec <writei+0xe2>
    ip->size = off;
    80003ee8:	052b2623          	sw	s2,76(s6)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003eec:	855a                	mv	a0,s6
    80003eee:	00000097          	auipc	ra,0x0
    80003ef2:	aa6080e7          	jalr	-1370(ra) # 80003994 <iupdate>

  return tot;
    80003ef6:	000a051b          	sext.w	a0,s4
}
    80003efa:	70a6                	ld	ra,104(sp)
    80003efc:	7406                	ld	s0,96(sp)
    80003efe:	64e6                	ld	s1,88(sp)
    80003f00:	6946                	ld	s2,80(sp)
    80003f02:	69a6                	ld	s3,72(sp)
    80003f04:	6a06                	ld	s4,64(sp)
    80003f06:	7ae2                	ld	s5,56(sp)
    80003f08:	7b42                	ld	s6,48(sp)
    80003f0a:	7ba2                	ld	s7,40(sp)
    80003f0c:	7c02                	ld	s8,32(sp)
    80003f0e:	6ce2                	ld	s9,24(sp)
    80003f10:	6d42                	ld	s10,16(sp)
    80003f12:	6da2                	ld	s11,8(sp)
    80003f14:	6165                	addi	sp,sp,112
    80003f16:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003f18:	8a5e                	mv	s4,s7
    80003f1a:	bfc9                	j	80003eec <writei+0xe2>
    return -1;
    80003f1c:	557d                	li	a0,-1
}
    80003f1e:	8082                	ret
    return -1;
    80003f20:	557d                	li	a0,-1
    80003f22:	bfe1                	j	80003efa <writei+0xf0>
    return -1;
    80003f24:	557d                	li	a0,-1
    80003f26:	bfd1                	j	80003efa <writei+0xf0>

0000000080003f28 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003f28:	1141                	addi	sp,sp,-16
    80003f2a:	e406                	sd	ra,8(sp)
    80003f2c:	e022                	sd	s0,0(sp)
    80003f2e:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003f30:	4639                	li	a2,14
    80003f32:	ffffd097          	auipc	ra,0xffffd
    80003f36:	e6a080e7          	jalr	-406(ra) # 80000d9c <strncmp>
}
    80003f3a:	60a2                	ld	ra,8(sp)
    80003f3c:	6402                	ld	s0,0(sp)
    80003f3e:	0141                	addi	sp,sp,16
    80003f40:	8082                	ret

0000000080003f42 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80003f42:	7139                	addi	sp,sp,-64
    80003f44:	fc06                	sd	ra,56(sp)
    80003f46:	f822                	sd	s0,48(sp)
    80003f48:	f426                	sd	s1,40(sp)
    80003f4a:	f04a                	sd	s2,32(sp)
    80003f4c:	ec4e                	sd	s3,24(sp)
    80003f4e:	e852                	sd	s4,16(sp)
    80003f50:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003f52:	04451703          	lh	a4,68(a0)
    80003f56:	4785                	li	a5,1
    80003f58:	00f71a63          	bne	a4,a5,80003f6c <dirlookup+0x2a>
    80003f5c:	892a                	mv	s2,a0
    80003f5e:	89ae                	mv	s3,a1
    80003f60:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003f62:	457c                	lw	a5,76(a0)
    80003f64:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003f66:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003f68:	e79d                	bnez	a5,80003f96 <dirlookup+0x54>
    80003f6a:	a8a5                	j	80003fe2 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003f6c:	00004517          	auipc	a0,0x4
    80003f70:	70450513          	addi	a0,a0,1796 # 80008670 <syscalls+0x1b0>
    80003f74:	ffffc097          	auipc	ra,0xffffc
    80003f78:	5c4080e7          	jalr	1476(ra) # 80000538 <panic>
      panic("dirlookup read");
    80003f7c:	00004517          	auipc	a0,0x4
    80003f80:	70c50513          	addi	a0,a0,1804 # 80008688 <syscalls+0x1c8>
    80003f84:	ffffc097          	auipc	ra,0xffffc
    80003f88:	5b4080e7          	jalr	1460(ra) # 80000538 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003f8c:	24c1                	addiw	s1,s1,16
    80003f8e:	04c92783          	lw	a5,76(s2)
    80003f92:	04f4f763          	bgeu	s1,a5,80003fe0 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003f96:	4741                	li	a4,16
    80003f98:	86a6                	mv	a3,s1
    80003f9a:	fc040613          	addi	a2,s0,-64
    80003f9e:	4581                	li	a1,0
    80003fa0:	854a                	mv	a0,s2
    80003fa2:	00000097          	auipc	ra,0x0
    80003fa6:	d70080e7          	jalr	-656(ra) # 80003d12 <readi>
    80003faa:	47c1                	li	a5,16
    80003fac:	fcf518e3          	bne	a0,a5,80003f7c <dirlookup+0x3a>
    if(de.inum == 0)
    80003fb0:	fc045783          	lhu	a5,-64(s0)
    80003fb4:	dfe1                	beqz	a5,80003f8c <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80003fb6:	fc240593          	addi	a1,s0,-62
    80003fba:	854e                	mv	a0,s3
    80003fbc:	00000097          	auipc	ra,0x0
    80003fc0:	f6c080e7          	jalr	-148(ra) # 80003f28 <namecmp>
    80003fc4:	f561                	bnez	a0,80003f8c <dirlookup+0x4a>
      if(poff)
    80003fc6:	000a0463          	beqz	s4,80003fce <dirlookup+0x8c>
        *poff = off;
    80003fca:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80003fce:	fc045583          	lhu	a1,-64(s0)
    80003fd2:	00092503          	lw	a0,0(s2)
    80003fd6:	fffff097          	auipc	ra,0xfffff
    80003fda:	754080e7          	jalr	1876(ra) # 8000372a <iget>
    80003fde:	a011                	j	80003fe2 <dirlookup+0xa0>
  return 0;
    80003fe0:	4501                	li	a0,0
}
    80003fe2:	70e2                	ld	ra,56(sp)
    80003fe4:	7442                	ld	s0,48(sp)
    80003fe6:	74a2                	ld	s1,40(sp)
    80003fe8:	7902                	ld	s2,32(sp)
    80003fea:	69e2                	ld	s3,24(sp)
    80003fec:	6a42                	ld	s4,16(sp)
    80003fee:	6121                	addi	sp,sp,64
    80003ff0:	8082                	ret

0000000080003ff2 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003ff2:	711d                	addi	sp,sp,-96
    80003ff4:	ec86                	sd	ra,88(sp)
    80003ff6:	e8a2                	sd	s0,80(sp)
    80003ff8:	e4a6                	sd	s1,72(sp)
    80003ffa:	e0ca                	sd	s2,64(sp)
    80003ffc:	fc4e                	sd	s3,56(sp)
    80003ffe:	f852                	sd	s4,48(sp)
    80004000:	f456                	sd	s5,40(sp)
    80004002:	f05a                	sd	s6,32(sp)
    80004004:	ec5e                	sd	s7,24(sp)
    80004006:	e862                	sd	s8,16(sp)
    80004008:	e466                	sd	s9,8(sp)
    8000400a:	1080                	addi	s0,sp,96
    8000400c:	84aa                	mv	s1,a0
    8000400e:	8aae                	mv	s5,a1
    80004010:	8a32                	mv	s4,a2
  struct inode *ip, *next;

  if(*path == '/')
    80004012:	00054703          	lbu	a4,0(a0)
    80004016:	02f00793          	li	a5,47
    8000401a:	02f70363          	beq	a4,a5,80004040 <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    8000401e:	ffffe097          	auipc	ra,0xffffe
    80004022:	a74080e7          	jalr	-1420(ra) # 80001a92 <myproc>
    80004026:	15053503          	ld	a0,336(a0)
    8000402a:	00000097          	auipc	ra,0x0
    8000402e:	9f6080e7          	jalr	-1546(ra) # 80003a20 <idup>
    80004032:	89aa                	mv	s3,a0
  while(*path == '/')
    80004034:	02f00913          	li	s2,47
  len = path - s;
    80004038:	4b01                	li	s6,0
  if(len >= DIRSIZ)
    8000403a:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    8000403c:	4b85                	li	s7,1
    8000403e:	a865                	j	800040f6 <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    80004040:	4585                	li	a1,1
    80004042:	4505                	li	a0,1
    80004044:	fffff097          	auipc	ra,0xfffff
    80004048:	6e6080e7          	jalr	1766(ra) # 8000372a <iget>
    8000404c:	89aa                	mv	s3,a0
    8000404e:	b7dd                	j	80004034 <namex+0x42>
      iunlockput(ip);
    80004050:	854e                	mv	a0,s3
    80004052:	00000097          	auipc	ra,0x0
    80004056:	c6e080e7          	jalr	-914(ra) # 80003cc0 <iunlockput>
      return 0;
    8000405a:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    8000405c:	854e                	mv	a0,s3
    8000405e:	60e6                	ld	ra,88(sp)
    80004060:	6446                	ld	s0,80(sp)
    80004062:	64a6                	ld	s1,72(sp)
    80004064:	6906                	ld	s2,64(sp)
    80004066:	79e2                	ld	s3,56(sp)
    80004068:	7a42                	ld	s4,48(sp)
    8000406a:	7aa2                	ld	s5,40(sp)
    8000406c:	7b02                	ld	s6,32(sp)
    8000406e:	6be2                	ld	s7,24(sp)
    80004070:	6c42                	ld	s8,16(sp)
    80004072:	6ca2                	ld	s9,8(sp)
    80004074:	6125                	addi	sp,sp,96
    80004076:	8082                	ret
      iunlock(ip);
    80004078:	854e                	mv	a0,s3
    8000407a:	00000097          	auipc	ra,0x0
    8000407e:	aa6080e7          	jalr	-1370(ra) # 80003b20 <iunlock>
      return ip;
    80004082:	bfe9                	j	8000405c <namex+0x6a>
      iunlockput(ip);
    80004084:	854e                	mv	a0,s3
    80004086:	00000097          	auipc	ra,0x0
    8000408a:	c3a080e7          	jalr	-966(ra) # 80003cc0 <iunlockput>
      return 0;
    8000408e:	89e6                	mv	s3,s9
    80004090:	b7f1                	j	8000405c <namex+0x6a>
  len = path - s;
    80004092:	40b48633          	sub	a2,s1,a1
    80004096:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    8000409a:	099c5463          	bge	s8,s9,80004122 <namex+0x130>
    memmove(name, s, DIRSIZ);
    8000409e:	4639                	li	a2,14
    800040a0:	8552                	mv	a0,s4
    800040a2:	ffffd097          	auipc	ra,0xffffd
    800040a6:	c86080e7          	jalr	-890(ra) # 80000d28 <memmove>
  while(*path == '/')
    800040aa:	0004c783          	lbu	a5,0(s1)
    800040ae:	01279763          	bne	a5,s2,800040bc <namex+0xca>
    path++;
    800040b2:	0485                	addi	s1,s1,1
  while(*path == '/')
    800040b4:	0004c783          	lbu	a5,0(s1)
    800040b8:	ff278de3          	beq	a5,s2,800040b2 <namex+0xc0>
    ilock(ip);
    800040bc:	854e                	mv	a0,s3
    800040be:	00000097          	auipc	ra,0x0
    800040c2:	9a0080e7          	jalr	-1632(ra) # 80003a5e <ilock>
    if(ip->type != T_DIR){
    800040c6:	04499783          	lh	a5,68(s3)
    800040ca:	f97793e3          	bne	a5,s7,80004050 <namex+0x5e>
    if(nameiparent && *path == '\0'){
    800040ce:	000a8563          	beqz	s5,800040d8 <namex+0xe6>
    800040d2:	0004c783          	lbu	a5,0(s1)
    800040d6:	d3cd                	beqz	a5,80004078 <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    800040d8:	865a                	mv	a2,s6
    800040da:	85d2                	mv	a1,s4
    800040dc:	854e                	mv	a0,s3
    800040de:	00000097          	auipc	ra,0x0
    800040e2:	e64080e7          	jalr	-412(ra) # 80003f42 <dirlookup>
    800040e6:	8caa                	mv	s9,a0
    800040e8:	dd51                	beqz	a0,80004084 <namex+0x92>
    iunlockput(ip);
    800040ea:	854e                	mv	a0,s3
    800040ec:	00000097          	auipc	ra,0x0
    800040f0:	bd4080e7          	jalr	-1068(ra) # 80003cc0 <iunlockput>
    ip = next;
    800040f4:	89e6                	mv	s3,s9
  while(*path == '/')
    800040f6:	0004c783          	lbu	a5,0(s1)
    800040fa:	05279763          	bne	a5,s2,80004148 <namex+0x156>
    path++;
    800040fe:	0485                	addi	s1,s1,1
  while(*path == '/')
    80004100:	0004c783          	lbu	a5,0(s1)
    80004104:	ff278de3          	beq	a5,s2,800040fe <namex+0x10c>
  if(*path == 0)
    80004108:	c79d                	beqz	a5,80004136 <namex+0x144>
    path++;
    8000410a:	85a6                	mv	a1,s1
  len = path - s;
    8000410c:	8cda                	mv	s9,s6
    8000410e:	865a                	mv	a2,s6
  while(*path != '/' && *path != 0)
    80004110:	01278963          	beq	a5,s2,80004122 <namex+0x130>
    80004114:	dfbd                	beqz	a5,80004092 <namex+0xa0>
    path++;
    80004116:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    80004118:	0004c783          	lbu	a5,0(s1)
    8000411c:	ff279ce3          	bne	a5,s2,80004114 <namex+0x122>
    80004120:	bf8d                	j	80004092 <namex+0xa0>
    memmove(name, s, len);
    80004122:	2601                	sext.w	a2,a2
    80004124:	8552                	mv	a0,s4
    80004126:	ffffd097          	auipc	ra,0xffffd
    8000412a:	c02080e7          	jalr	-1022(ra) # 80000d28 <memmove>
    name[len] = 0;
    8000412e:	9cd2                	add	s9,s9,s4
    80004130:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    80004134:	bf9d                	j	800040aa <namex+0xb8>
  if(nameiparent){
    80004136:	f20a83e3          	beqz	s5,8000405c <namex+0x6a>
    iput(ip);
    8000413a:	854e                	mv	a0,s3
    8000413c:	00000097          	auipc	ra,0x0
    80004140:	adc080e7          	jalr	-1316(ra) # 80003c18 <iput>
    return 0;
    80004144:	4981                	li	s3,0
    80004146:	bf19                	j	8000405c <namex+0x6a>
  if(*path == 0)
    80004148:	d7fd                	beqz	a5,80004136 <namex+0x144>
  while(*path != '/' && *path != 0)
    8000414a:	0004c783          	lbu	a5,0(s1)
    8000414e:	85a6                	mv	a1,s1
    80004150:	b7d1                	j	80004114 <namex+0x122>

0000000080004152 <dirlink>:
{
    80004152:	7139                	addi	sp,sp,-64
    80004154:	fc06                	sd	ra,56(sp)
    80004156:	f822                	sd	s0,48(sp)
    80004158:	f426                	sd	s1,40(sp)
    8000415a:	f04a                	sd	s2,32(sp)
    8000415c:	ec4e                	sd	s3,24(sp)
    8000415e:	e852                	sd	s4,16(sp)
    80004160:	0080                	addi	s0,sp,64
    80004162:	892a                	mv	s2,a0
    80004164:	8a2e                	mv	s4,a1
    80004166:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80004168:	4601                	li	a2,0
    8000416a:	00000097          	auipc	ra,0x0
    8000416e:	dd8080e7          	jalr	-552(ra) # 80003f42 <dirlookup>
    80004172:	e93d                	bnez	a0,800041e8 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80004174:	04c92483          	lw	s1,76(s2)
    80004178:	c49d                	beqz	s1,800041a6 <dirlink+0x54>
    8000417a:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000417c:	4741                	li	a4,16
    8000417e:	86a6                	mv	a3,s1
    80004180:	fc040613          	addi	a2,s0,-64
    80004184:	4581                	li	a1,0
    80004186:	854a                	mv	a0,s2
    80004188:	00000097          	auipc	ra,0x0
    8000418c:	b8a080e7          	jalr	-1142(ra) # 80003d12 <readi>
    80004190:	47c1                	li	a5,16
    80004192:	06f51163          	bne	a0,a5,800041f4 <dirlink+0xa2>
    if(de.inum == 0)
    80004196:	fc045783          	lhu	a5,-64(s0)
    8000419a:	c791                	beqz	a5,800041a6 <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000419c:	24c1                	addiw	s1,s1,16
    8000419e:	04c92783          	lw	a5,76(s2)
    800041a2:	fcf4ede3          	bltu	s1,a5,8000417c <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    800041a6:	4639                	li	a2,14
    800041a8:	85d2                	mv	a1,s4
    800041aa:	fc240513          	addi	a0,s0,-62
    800041ae:	ffffd097          	auipc	ra,0xffffd
    800041b2:	c2a080e7          	jalr	-982(ra) # 80000dd8 <strncpy>
  de.inum = inum;
    800041b6:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800041ba:	4741                	li	a4,16
    800041bc:	86a6                	mv	a3,s1
    800041be:	fc040613          	addi	a2,s0,-64
    800041c2:	4581                	li	a1,0
    800041c4:	854a                	mv	a0,s2
    800041c6:	00000097          	auipc	ra,0x0
    800041ca:	c44080e7          	jalr	-956(ra) # 80003e0a <writei>
    800041ce:	872a                	mv	a4,a0
    800041d0:	47c1                	li	a5,16
  return 0;
    800041d2:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800041d4:	02f71863          	bne	a4,a5,80004204 <dirlink+0xb2>
}
    800041d8:	70e2                	ld	ra,56(sp)
    800041da:	7442                	ld	s0,48(sp)
    800041dc:	74a2                	ld	s1,40(sp)
    800041de:	7902                	ld	s2,32(sp)
    800041e0:	69e2                	ld	s3,24(sp)
    800041e2:	6a42                	ld	s4,16(sp)
    800041e4:	6121                	addi	sp,sp,64
    800041e6:	8082                	ret
    iput(ip);
    800041e8:	00000097          	auipc	ra,0x0
    800041ec:	a30080e7          	jalr	-1488(ra) # 80003c18 <iput>
    return -1;
    800041f0:	557d                	li	a0,-1
    800041f2:	b7dd                	j	800041d8 <dirlink+0x86>
      panic("dirlink read");
    800041f4:	00004517          	auipc	a0,0x4
    800041f8:	4a450513          	addi	a0,a0,1188 # 80008698 <syscalls+0x1d8>
    800041fc:	ffffc097          	auipc	ra,0xffffc
    80004200:	33c080e7          	jalr	828(ra) # 80000538 <panic>
    panic("dirlink");
    80004204:	00004517          	auipc	a0,0x4
    80004208:	5a450513          	addi	a0,a0,1444 # 800087a8 <syscalls+0x2e8>
    8000420c:	ffffc097          	auipc	ra,0xffffc
    80004210:	32c080e7          	jalr	812(ra) # 80000538 <panic>

0000000080004214 <namei>:

struct inode*
namei(char *path)
{
    80004214:	1101                	addi	sp,sp,-32
    80004216:	ec06                	sd	ra,24(sp)
    80004218:	e822                	sd	s0,16(sp)
    8000421a:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    8000421c:	fe040613          	addi	a2,s0,-32
    80004220:	4581                	li	a1,0
    80004222:	00000097          	auipc	ra,0x0
    80004226:	dd0080e7          	jalr	-560(ra) # 80003ff2 <namex>
}
    8000422a:	60e2                	ld	ra,24(sp)
    8000422c:	6442                	ld	s0,16(sp)
    8000422e:	6105                	addi	sp,sp,32
    80004230:	8082                	ret

0000000080004232 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80004232:	1141                	addi	sp,sp,-16
    80004234:	e406                	sd	ra,8(sp)
    80004236:	e022                	sd	s0,0(sp)
    80004238:	0800                	addi	s0,sp,16
    8000423a:	862e                	mv	a2,a1
  return namex(path, 1, name);
    8000423c:	4585                	li	a1,1
    8000423e:	00000097          	auipc	ra,0x0
    80004242:	db4080e7          	jalr	-588(ra) # 80003ff2 <namex>
}
    80004246:	60a2                	ld	ra,8(sp)
    80004248:	6402                	ld	s0,0(sp)
    8000424a:	0141                	addi	sp,sp,16
    8000424c:	8082                	ret

000000008000424e <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    8000424e:	1101                	addi	sp,sp,-32
    80004250:	ec06                	sd	ra,24(sp)
    80004252:	e822                	sd	s0,16(sp)
    80004254:	e426                	sd	s1,8(sp)
    80004256:	e04a                	sd	s2,0(sp)
    80004258:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    8000425a:	0041d917          	auipc	s2,0x41d
    8000425e:	61690913          	addi	s2,s2,1558 # 80421870 <log>
    80004262:	01892583          	lw	a1,24(s2)
    80004266:	02892503          	lw	a0,40(s2)
    8000426a:	fffff097          	auipc	ra,0xfffff
    8000426e:	ff2080e7          	jalr	-14(ra) # 8000325c <bread>
    80004272:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80004274:	02c92683          	lw	a3,44(s2)
    80004278:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    8000427a:	02d05763          	blez	a3,800042a8 <write_head+0x5a>
    8000427e:	0041d797          	auipc	a5,0x41d
    80004282:	62278793          	addi	a5,a5,1570 # 804218a0 <log+0x30>
    80004286:	05c50713          	addi	a4,a0,92
    8000428a:	36fd                	addiw	a3,a3,-1
    8000428c:	1682                	slli	a3,a3,0x20
    8000428e:	9281                	srli	a3,a3,0x20
    80004290:	068a                	slli	a3,a3,0x2
    80004292:	0041d617          	auipc	a2,0x41d
    80004296:	61260613          	addi	a2,a2,1554 # 804218a4 <log+0x34>
    8000429a:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    8000429c:	4390                	lw	a2,0(a5)
    8000429e:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800042a0:	0791                	addi	a5,a5,4
    800042a2:	0711                	addi	a4,a4,4
    800042a4:	fed79ce3          	bne	a5,a3,8000429c <write_head+0x4e>
  }
  bwrite(buf);
    800042a8:	8526                	mv	a0,s1
    800042aa:	fffff097          	auipc	ra,0xfffff
    800042ae:	0a4080e7          	jalr	164(ra) # 8000334e <bwrite>
  brelse(buf);
    800042b2:	8526                	mv	a0,s1
    800042b4:	fffff097          	auipc	ra,0xfffff
    800042b8:	0d8080e7          	jalr	216(ra) # 8000338c <brelse>
}
    800042bc:	60e2                	ld	ra,24(sp)
    800042be:	6442                	ld	s0,16(sp)
    800042c0:	64a2                	ld	s1,8(sp)
    800042c2:	6902                	ld	s2,0(sp)
    800042c4:	6105                	addi	sp,sp,32
    800042c6:	8082                	ret

00000000800042c8 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    800042c8:	0041d797          	auipc	a5,0x41d
    800042cc:	5d47a783          	lw	a5,1492(a5) # 8042189c <log+0x2c>
    800042d0:	0af05d63          	blez	a5,8000438a <install_trans+0xc2>
{
    800042d4:	7139                	addi	sp,sp,-64
    800042d6:	fc06                	sd	ra,56(sp)
    800042d8:	f822                	sd	s0,48(sp)
    800042da:	f426                	sd	s1,40(sp)
    800042dc:	f04a                	sd	s2,32(sp)
    800042de:	ec4e                	sd	s3,24(sp)
    800042e0:	e852                	sd	s4,16(sp)
    800042e2:	e456                	sd	s5,8(sp)
    800042e4:	e05a                	sd	s6,0(sp)
    800042e6:	0080                	addi	s0,sp,64
    800042e8:	8b2a                	mv	s6,a0
    800042ea:	0041da97          	auipc	s5,0x41d
    800042ee:	5b6a8a93          	addi	s5,s5,1462 # 804218a0 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    800042f2:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800042f4:	0041d997          	auipc	s3,0x41d
    800042f8:	57c98993          	addi	s3,s3,1404 # 80421870 <log>
    800042fc:	a00d                	j	8000431e <install_trans+0x56>
    brelse(lbuf);
    800042fe:	854a                	mv	a0,s2
    80004300:	fffff097          	auipc	ra,0xfffff
    80004304:	08c080e7          	jalr	140(ra) # 8000338c <brelse>
    brelse(dbuf);
    80004308:	8526                	mv	a0,s1
    8000430a:	fffff097          	auipc	ra,0xfffff
    8000430e:	082080e7          	jalr	130(ra) # 8000338c <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80004312:	2a05                	addiw	s4,s4,1
    80004314:	0a91                	addi	s5,s5,4
    80004316:	02c9a783          	lw	a5,44(s3)
    8000431a:	04fa5e63          	bge	s4,a5,80004376 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000431e:	0189a583          	lw	a1,24(s3)
    80004322:	014585bb          	addw	a1,a1,s4
    80004326:	2585                	addiw	a1,a1,1
    80004328:	0289a503          	lw	a0,40(s3)
    8000432c:	fffff097          	auipc	ra,0xfffff
    80004330:	f30080e7          	jalr	-208(ra) # 8000325c <bread>
    80004334:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80004336:	000aa583          	lw	a1,0(s5)
    8000433a:	0289a503          	lw	a0,40(s3)
    8000433e:	fffff097          	auipc	ra,0xfffff
    80004342:	f1e080e7          	jalr	-226(ra) # 8000325c <bread>
    80004346:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80004348:	40000613          	li	a2,1024
    8000434c:	05890593          	addi	a1,s2,88
    80004350:	05850513          	addi	a0,a0,88
    80004354:	ffffd097          	auipc	ra,0xffffd
    80004358:	9d4080e7          	jalr	-1580(ra) # 80000d28 <memmove>
    bwrite(dbuf);  // write dst to disk
    8000435c:	8526                	mv	a0,s1
    8000435e:	fffff097          	auipc	ra,0xfffff
    80004362:	ff0080e7          	jalr	-16(ra) # 8000334e <bwrite>
    if(recovering == 0)
    80004366:	f80b1ce3          	bnez	s6,800042fe <install_trans+0x36>
      bunpin(dbuf);
    8000436a:	8526                	mv	a0,s1
    8000436c:	fffff097          	auipc	ra,0xfffff
    80004370:	0fa080e7          	jalr	250(ra) # 80003466 <bunpin>
    80004374:	b769                	j	800042fe <install_trans+0x36>
}
    80004376:	70e2                	ld	ra,56(sp)
    80004378:	7442                	ld	s0,48(sp)
    8000437a:	74a2                	ld	s1,40(sp)
    8000437c:	7902                	ld	s2,32(sp)
    8000437e:	69e2                	ld	s3,24(sp)
    80004380:	6a42                	ld	s4,16(sp)
    80004382:	6aa2                	ld	s5,8(sp)
    80004384:	6b02                	ld	s6,0(sp)
    80004386:	6121                	addi	sp,sp,64
    80004388:	8082                	ret
    8000438a:	8082                	ret

000000008000438c <initlog>:
{
    8000438c:	7179                	addi	sp,sp,-48
    8000438e:	f406                	sd	ra,40(sp)
    80004390:	f022                	sd	s0,32(sp)
    80004392:	ec26                	sd	s1,24(sp)
    80004394:	e84a                	sd	s2,16(sp)
    80004396:	e44e                	sd	s3,8(sp)
    80004398:	1800                	addi	s0,sp,48
    8000439a:	892a                	mv	s2,a0
    8000439c:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    8000439e:	0041d497          	auipc	s1,0x41d
    800043a2:	4d248493          	addi	s1,s1,1234 # 80421870 <log>
    800043a6:	00004597          	auipc	a1,0x4
    800043aa:	30258593          	addi	a1,a1,770 # 800086a8 <syscalls+0x1e8>
    800043ae:	8526                	mv	a0,s1
    800043b0:	ffffc097          	auipc	ra,0xffffc
    800043b4:	790080e7          	jalr	1936(ra) # 80000b40 <initlock>
  log.start = sb->logstart;
    800043b8:	0149a583          	lw	a1,20(s3)
    800043bc:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    800043be:	0109a783          	lw	a5,16(s3)
    800043c2:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    800043c4:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    800043c8:	854a                	mv	a0,s2
    800043ca:	fffff097          	auipc	ra,0xfffff
    800043ce:	e92080e7          	jalr	-366(ra) # 8000325c <bread>
  log.lh.n = lh->n;
    800043d2:	4d34                	lw	a3,88(a0)
    800043d4:	d4d4                	sw	a3,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    800043d6:	02d05563          	blez	a3,80004400 <initlog+0x74>
    800043da:	05c50793          	addi	a5,a0,92
    800043de:	0041d717          	auipc	a4,0x41d
    800043e2:	4c270713          	addi	a4,a4,1218 # 804218a0 <log+0x30>
    800043e6:	36fd                	addiw	a3,a3,-1
    800043e8:	1682                	slli	a3,a3,0x20
    800043ea:	9281                	srli	a3,a3,0x20
    800043ec:	068a                	slli	a3,a3,0x2
    800043ee:	06050613          	addi	a2,a0,96
    800043f2:	96b2                	add	a3,a3,a2
    log.lh.block[i] = lh->block[i];
    800043f4:	4390                	lw	a2,0(a5)
    800043f6:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800043f8:	0791                	addi	a5,a5,4
    800043fa:	0711                	addi	a4,a4,4
    800043fc:	fed79ce3          	bne	a5,a3,800043f4 <initlog+0x68>
  brelse(buf);
    80004400:	fffff097          	auipc	ra,0xfffff
    80004404:	f8c080e7          	jalr	-116(ra) # 8000338c <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80004408:	4505                	li	a0,1
    8000440a:	00000097          	auipc	ra,0x0
    8000440e:	ebe080e7          	jalr	-322(ra) # 800042c8 <install_trans>
  log.lh.n = 0;
    80004412:	0041d797          	auipc	a5,0x41d
    80004416:	4807a523          	sw	zero,1162(a5) # 8042189c <log+0x2c>
  write_head(); // clear the log
    8000441a:	00000097          	auipc	ra,0x0
    8000441e:	e34080e7          	jalr	-460(ra) # 8000424e <write_head>
}
    80004422:	70a2                	ld	ra,40(sp)
    80004424:	7402                	ld	s0,32(sp)
    80004426:	64e2                	ld	s1,24(sp)
    80004428:	6942                	ld	s2,16(sp)
    8000442a:	69a2                	ld	s3,8(sp)
    8000442c:	6145                	addi	sp,sp,48
    8000442e:	8082                	ret

0000000080004430 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80004430:	1101                	addi	sp,sp,-32
    80004432:	ec06                	sd	ra,24(sp)
    80004434:	e822                	sd	s0,16(sp)
    80004436:	e426                	sd	s1,8(sp)
    80004438:	e04a                	sd	s2,0(sp)
    8000443a:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    8000443c:	0041d517          	auipc	a0,0x41d
    80004440:	43450513          	addi	a0,a0,1076 # 80421870 <log>
    80004444:	ffffc097          	auipc	ra,0xffffc
    80004448:	78c080e7          	jalr	1932(ra) # 80000bd0 <acquire>
  while(1){
    if(log.committing){
    8000444c:	0041d497          	auipc	s1,0x41d
    80004450:	42448493          	addi	s1,s1,1060 # 80421870 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80004454:	4979                	li	s2,30
    80004456:	a039                	j	80004464 <begin_op+0x34>
      sleep(&log, &log.lock);
    80004458:	85a6                	mv	a1,s1
    8000445a:	8526                	mv	a0,s1
    8000445c:	ffffe097          	auipc	ra,0xffffe
    80004460:	d14080e7          	jalr	-748(ra) # 80002170 <sleep>
    if(log.committing){
    80004464:	50dc                	lw	a5,36(s1)
    80004466:	fbed                	bnez	a5,80004458 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80004468:	509c                	lw	a5,32(s1)
    8000446a:	0017871b          	addiw	a4,a5,1
    8000446e:	0007069b          	sext.w	a3,a4
    80004472:	0027179b          	slliw	a5,a4,0x2
    80004476:	9fb9                	addw	a5,a5,a4
    80004478:	0017979b          	slliw	a5,a5,0x1
    8000447c:	54d8                	lw	a4,44(s1)
    8000447e:	9fb9                	addw	a5,a5,a4
    80004480:	00f95963          	bge	s2,a5,80004492 <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80004484:	85a6                	mv	a1,s1
    80004486:	8526                	mv	a0,s1
    80004488:	ffffe097          	auipc	ra,0xffffe
    8000448c:	ce8080e7          	jalr	-792(ra) # 80002170 <sleep>
    80004490:	bfd1                	j	80004464 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80004492:	0041d517          	auipc	a0,0x41d
    80004496:	3de50513          	addi	a0,a0,990 # 80421870 <log>
    8000449a:	d114                	sw	a3,32(a0)
      release(&log.lock);
    8000449c:	ffffc097          	auipc	ra,0xffffc
    800044a0:	7e8080e7          	jalr	2024(ra) # 80000c84 <release>
      break;
    }
  }
}
    800044a4:	60e2                	ld	ra,24(sp)
    800044a6:	6442                	ld	s0,16(sp)
    800044a8:	64a2                	ld	s1,8(sp)
    800044aa:	6902                	ld	s2,0(sp)
    800044ac:	6105                	addi	sp,sp,32
    800044ae:	8082                	ret

00000000800044b0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    800044b0:	7139                	addi	sp,sp,-64
    800044b2:	fc06                	sd	ra,56(sp)
    800044b4:	f822                	sd	s0,48(sp)
    800044b6:	f426                	sd	s1,40(sp)
    800044b8:	f04a                	sd	s2,32(sp)
    800044ba:	ec4e                	sd	s3,24(sp)
    800044bc:	e852                	sd	s4,16(sp)
    800044be:	e456                	sd	s5,8(sp)
    800044c0:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    800044c2:	0041d497          	auipc	s1,0x41d
    800044c6:	3ae48493          	addi	s1,s1,942 # 80421870 <log>
    800044ca:	8526                	mv	a0,s1
    800044cc:	ffffc097          	auipc	ra,0xffffc
    800044d0:	704080e7          	jalr	1796(ra) # 80000bd0 <acquire>
  log.outstanding -= 1;
    800044d4:	509c                	lw	a5,32(s1)
    800044d6:	37fd                	addiw	a5,a5,-1
    800044d8:	0007891b          	sext.w	s2,a5
    800044dc:	d09c                	sw	a5,32(s1)
  if(log.committing)
    800044de:	50dc                	lw	a5,36(s1)
    800044e0:	e7b9                	bnez	a5,8000452e <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    800044e2:	04091e63          	bnez	s2,8000453e <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    800044e6:	0041d497          	auipc	s1,0x41d
    800044ea:	38a48493          	addi	s1,s1,906 # 80421870 <log>
    800044ee:	4785                	li	a5,1
    800044f0:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800044f2:	8526                	mv	a0,s1
    800044f4:	ffffc097          	auipc	ra,0xffffc
    800044f8:	790080e7          	jalr	1936(ra) # 80000c84 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800044fc:	54dc                	lw	a5,44(s1)
    800044fe:	06f04763          	bgtz	a5,8000456c <end_op+0xbc>
    acquire(&log.lock);
    80004502:	0041d497          	auipc	s1,0x41d
    80004506:	36e48493          	addi	s1,s1,878 # 80421870 <log>
    8000450a:	8526                	mv	a0,s1
    8000450c:	ffffc097          	auipc	ra,0xffffc
    80004510:	6c4080e7          	jalr	1732(ra) # 80000bd0 <acquire>
    log.committing = 0;
    80004514:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80004518:	8526                	mv	a0,s1
    8000451a:	ffffe097          	auipc	ra,0xffffe
    8000451e:	dfe080e7          	jalr	-514(ra) # 80002318 <wakeup>
    release(&log.lock);
    80004522:	8526                	mv	a0,s1
    80004524:	ffffc097          	auipc	ra,0xffffc
    80004528:	760080e7          	jalr	1888(ra) # 80000c84 <release>
}
    8000452c:	a03d                	j	8000455a <end_op+0xaa>
    panic("log.committing");
    8000452e:	00004517          	auipc	a0,0x4
    80004532:	18250513          	addi	a0,a0,386 # 800086b0 <syscalls+0x1f0>
    80004536:	ffffc097          	auipc	ra,0xffffc
    8000453a:	002080e7          	jalr	2(ra) # 80000538 <panic>
    wakeup(&log);
    8000453e:	0041d497          	auipc	s1,0x41d
    80004542:	33248493          	addi	s1,s1,818 # 80421870 <log>
    80004546:	8526                	mv	a0,s1
    80004548:	ffffe097          	auipc	ra,0xffffe
    8000454c:	dd0080e7          	jalr	-560(ra) # 80002318 <wakeup>
  release(&log.lock);
    80004550:	8526                	mv	a0,s1
    80004552:	ffffc097          	auipc	ra,0xffffc
    80004556:	732080e7          	jalr	1842(ra) # 80000c84 <release>
}
    8000455a:	70e2                	ld	ra,56(sp)
    8000455c:	7442                	ld	s0,48(sp)
    8000455e:	74a2                	ld	s1,40(sp)
    80004560:	7902                	ld	s2,32(sp)
    80004562:	69e2                	ld	s3,24(sp)
    80004564:	6a42                	ld	s4,16(sp)
    80004566:	6aa2                	ld	s5,8(sp)
    80004568:	6121                	addi	sp,sp,64
    8000456a:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    8000456c:	0041da97          	auipc	s5,0x41d
    80004570:	334a8a93          	addi	s5,s5,820 # 804218a0 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80004574:	0041da17          	auipc	s4,0x41d
    80004578:	2fca0a13          	addi	s4,s4,764 # 80421870 <log>
    8000457c:	018a2583          	lw	a1,24(s4)
    80004580:	012585bb          	addw	a1,a1,s2
    80004584:	2585                	addiw	a1,a1,1
    80004586:	028a2503          	lw	a0,40(s4)
    8000458a:	fffff097          	auipc	ra,0xfffff
    8000458e:	cd2080e7          	jalr	-814(ra) # 8000325c <bread>
    80004592:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80004594:	000aa583          	lw	a1,0(s5)
    80004598:	028a2503          	lw	a0,40(s4)
    8000459c:	fffff097          	auipc	ra,0xfffff
    800045a0:	cc0080e7          	jalr	-832(ra) # 8000325c <bread>
    800045a4:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    800045a6:	40000613          	li	a2,1024
    800045aa:	05850593          	addi	a1,a0,88
    800045ae:	05848513          	addi	a0,s1,88
    800045b2:	ffffc097          	auipc	ra,0xffffc
    800045b6:	776080e7          	jalr	1910(ra) # 80000d28 <memmove>
    bwrite(to);  // write the log
    800045ba:	8526                	mv	a0,s1
    800045bc:	fffff097          	auipc	ra,0xfffff
    800045c0:	d92080e7          	jalr	-622(ra) # 8000334e <bwrite>
    brelse(from);
    800045c4:	854e                	mv	a0,s3
    800045c6:	fffff097          	auipc	ra,0xfffff
    800045ca:	dc6080e7          	jalr	-570(ra) # 8000338c <brelse>
    brelse(to);
    800045ce:	8526                	mv	a0,s1
    800045d0:	fffff097          	auipc	ra,0xfffff
    800045d4:	dbc080e7          	jalr	-580(ra) # 8000338c <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800045d8:	2905                	addiw	s2,s2,1
    800045da:	0a91                	addi	s5,s5,4
    800045dc:	02ca2783          	lw	a5,44(s4)
    800045e0:	f8f94ee3          	blt	s2,a5,8000457c <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    800045e4:	00000097          	auipc	ra,0x0
    800045e8:	c6a080e7          	jalr	-918(ra) # 8000424e <write_head>
    install_trans(0); // Now install writes to home locations
    800045ec:	4501                	li	a0,0
    800045ee:	00000097          	auipc	ra,0x0
    800045f2:	cda080e7          	jalr	-806(ra) # 800042c8 <install_trans>
    log.lh.n = 0;
    800045f6:	0041d797          	auipc	a5,0x41d
    800045fa:	2a07a323          	sw	zero,678(a5) # 8042189c <log+0x2c>
    write_head();    // Erase the transaction from the log
    800045fe:	00000097          	auipc	ra,0x0
    80004602:	c50080e7          	jalr	-944(ra) # 8000424e <write_head>
    80004606:	bdf5                	j	80004502 <end_op+0x52>

0000000080004608 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80004608:	1101                	addi	sp,sp,-32
    8000460a:	ec06                	sd	ra,24(sp)
    8000460c:	e822                	sd	s0,16(sp)
    8000460e:	e426                	sd	s1,8(sp)
    80004610:	e04a                	sd	s2,0(sp)
    80004612:	1000                	addi	s0,sp,32
    80004614:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    80004616:	0041d917          	auipc	s2,0x41d
    8000461a:	25a90913          	addi	s2,s2,602 # 80421870 <log>
    8000461e:	854a                	mv	a0,s2
    80004620:	ffffc097          	auipc	ra,0xffffc
    80004624:	5b0080e7          	jalr	1456(ra) # 80000bd0 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80004628:	02c92603          	lw	a2,44(s2)
    8000462c:	47f5                	li	a5,29
    8000462e:	06c7c563          	blt	a5,a2,80004698 <log_write+0x90>
    80004632:	0041d797          	auipc	a5,0x41d
    80004636:	25a7a783          	lw	a5,602(a5) # 8042188c <log+0x1c>
    8000463a:	37fd                	addiw	a5,a5,-1
    8000463c:	04f65e63          	bge	a2,a5,80004698 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80004640:	0041d797          	auipc	a5,0x41d
    80004644:	2507a783          	lw	a5,592(a5) # 80421890 <log+0x20>
    80004648:	06f05063          	blez	a5,800046a8 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    8000464c:	4781                	li	a5,0
    8000464e:	06c05563          	blez	a2,800046b8 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80004652:	44cc                	lw	a1,12(s1)
    80004654:	0041d717          	auipc	a4,0x41d
    80004658:	24c70713          	addi	a4,a4,588 # 804218a0 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    8000465c:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000465e:	4314                	lw	a3,0(a4)
    80004660:	04b68c63          	beq	a3,a1,800046b8 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80004664:	2785                	addiw	a5,a5,1
    80004666:	0711                	addi	a4,a4,4
    80004668:	fef61be3          	bne	a2,a5,8000465e <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    8000466c:	0621                	addi	a2,a2,8
    8000466e:	060a                	slli	a2,a2,0x2
    80004670:	0041d797          	auipc	a5,0x41d
    80004674:	20078793          	addi	a5,a5,512 # 80421870 <log>
    80004678:	963e                	add	a2,a2,a5
    8000467a:	44dc                	lw	a5,12(s1)
    8000467c:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    8000467e:	8526                	mv	a0,s1
    80004680:	fffff097          	auipc	ra,0xfffff
    80004684:	daa080e7          	jalr	-598(ra) # 8000342a <bpin>
    log.lh.n++;
    80004688:	0041d717          	auipc	a4,0x41d
    8000468c:	1e870713          	addi	a4,a4,488 # 80421870 <log>
    80004690:	575c                	lw	a5,44(a4)
    80004692:	2785                	addiw	a5,a5,1
    80004694:	d75c                	sw	a5,44(a4)
    80004696:	a835                	j	800046d2 <log_write+0xca>
    panic("too big a transaction");
    80004698:	00004517          	auipc	a0,0x4
    8000469c:	02850513          	addi	a0,a0,40 # 800086c0 <syscalls+0x200>
    800046a0:	ffffc097          	auipc	ra,0xffffc
    800046a4:	e98080e7          	jalr	-360(ra) # 80000538 <panic>
    panic("log_write outside of trans");
    800046a8:	00004517          	auipc	a0,0x4
    800046ac:	03050513          	addi	a0,a0,48 # 800086d8 <syscalls+0x218>
    800046b0:	ffffc097          	auipc	ra,0xffffc
    800046b4:	e88080e7          	jalr	-376(ra) # 80000538 <panic>
  log.lh.block[i] = b->blockno;
    800046b8:	00878713          	addi	a4,a5,8
    800046bc:	00271693          	slli	a3,a4,0x2
    800046c0:	0041d717          	auipc	a4,0x41d
    800046c4:	1b070713          	addi	a4,a4,432 # 80421870 <log>
    800046c8:	9736                	add	a4,a4,a3
    800046ca:	44d4                	lw	a3,12(s1)
    800046cc:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800046ce:	faf608e3          	beq	a2,a5,8000467e <log_write+0x76>
  }
  release(&log.lock);
    800046d2:	0041d517          	auipc	a0,0x41d
    800046d6:	19e50513          	addi	a0,a0,414 # 80421870 <log>
    800046da:	ffffc097          	auipc	ra,0xffffc
    800046de:	5aa080e7          	jalr	1450(ra) # 80000c84 <release>
}
    800046e2:	60e2                	ld	ra,24(sp)
    800046e4:	6442                	ld	s0,16(sp)
    800046e6:	64a2                	ld	s1,8(sp)
    800046e8:	6902                	ld	s2,0(sp)
    800046ea:	6105                	addi	sp,sp,32
    800046ec:	8082                	ret

00000000800046ee <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800046ee:	1101                	addi	sp,sp,-32
    800046f0:	ec06                	sd	ra,24(sp)
    800046f2:	e822                	sd	s0,16(sp)
    800046f4:	e426                	sd	s1,8(sp)
    800046f6:	e04a                	sd	s2,0(sp)
    800046f8:	1000                	addi	s0,sp,32
    800046fa:	84aa                	mv	s1,a0
    800046fc:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800046fe:	00004597          	auipc	a1,0x4
    80004702:	ffa58593          	addi	a1,a1,-6 # 800086f8 <syscalls+0x238>
    80004706:	0521                	addi	a0,a0,8
    80004708:	ffffc097          	auipc	ra,0xffffc
    8000470c:	438080e7          	jalr	1080(ra) # 80000b40 <initlock>
  lk->name = name;
    80004710:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80004714:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80004718:	0204a423          	sw	zero,40(s1)
}
    8000471c:	60e2                	ld	ra,24(sp)
    8000471e:	6442                	ld	s0,16(sp)
    80004720:	64a2                	ld	s1,8(sp)
    80004722:	6902                	ld	s2,0(sp)
    80004724:	6105                	addi	sp,sp,32
    80004726:	8082                	ret

0000000080004728 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80004728:	1101                	addi	sp,sp,-32
    8000472a:	ec06                	sd	ra,24(sp)
    8000472c:	e822                	sd	s0,16(sp)
    8000472e:	e426                	sd	s1,8(sp)
    80004730:	e04a                	sd	s2,0(sp)
    80004732:	1000                	addi	s0,sp,32
    80004734:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80004736:	00850913          	addi	s2,a0,8
    8000473a:	854a                	mv	a0,s2
    8000473c:	ffffc097          	auipc	ra,0xffffc
    80004740:	494080e7          	jalr	1172(ra) # 80000bd0 <acquire>
  while (lk->locked) {
    80004744:	409c                	lw	a5,0(s1)
    80004746:	cb89                	beqz	a5,80004758 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80004748:	85ca                	mv	a1,s2
    8000474a:	8526                	mv	a0,s1
    8000474c:	ffffe097          	auipc	ra,0xffffe
    80004750:	a24080e7          	jalr	-1500(ra) # 80002170 <sleep>
  while (lk->locked) {
    80004754:	409c                	lw	a5,0(s1)
    80004756:	fbed                	bnez	a5,80004748 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80004758:	4785                	li	a5,1
    8000475a:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    8000475c:	ffffd097          	auipc	ra,0xffffd
    80004760:	336080e7          	jalr	822(ra) # 80001a92 <myproc>
    80004764:	591c                	lw	a5,48(a0)
    80004766:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80004768:	854a                	mv	a0,s2
    8000476a:	ffffc097          	auipc	ra,0xffffc
    8000476e:	51a080e7          	jalr	1306(ra) # 80000c84 <release>
}
    80004772:	60e2                	ld	ra,24(sp)
    80004774:	6442                	ld	s0,16(sp)
    80004776:	64a2                	ld	s1,8(sp)
    80004778:	6902                	ld	s2,0(sp)
    8000477a:	6105                	addi	sp,sp,32
    8000477c:	8082                	ret

000000008000477e <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    8000477e:	1101                	addi	sp,sp,-32
    80004780:	ec06                	sd	ra,24(sp)
    80004782:	e822                	sd	s0,16(sp)
    80004784:	e426                	sd	s1,8(sp)
    80004786:	e04a                	sd	s2,0(sp)
    80004788:	1000                	addi	s0,sp,32
    8000478a:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000478c:	00850913          	addi	s2,a0,8
    80004790:	854a                	mv	a0,s2
    80004792:	ffffc097          	auipc	ra,0xffffc
    80004796:	43e080e7          	jalr	1086(ra) # 80000bd0 <acquire>
  lk->locked = 0;
    8000479a:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000479e:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    800047a2:	8526                	mv	a0,s1
    800047a4:	ffffe097          	auipc	ra,0xffffe
    800047a8:	b74080e7          	jalr	-1164(ra) # 80002318 <wakeup>
  release(&lk->lk);
    800047ac:	854a                	mv	a0,s2
    800047ae:	ffffc097          	auipc	ra,0xffffc
    800047b2:	4d6080e7          	jalr	1238(ra) # 80000c84 <release>
}
    800047b6:	60e2                	ld	ra,24(sp)
    800047b8:	6442                	ld	s0,16(sp)
    800047ba:	64a2                	ld	s1,8(sp)
    800047bc:	6902                	ld	s2,0(sp)
    800047be:	6105                	addi	sp,sp,32
    800047c0:	8082                	ret

00000000800047c2 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800047c2:	7179                	addi	sp,sp,-48
    800047c4:	f406                	sd	ra,40(sp)
    800047c6:	f022                	sd	s0,32(sp)
    800047c8:	ec26                	sd	s1,24(sp)
    800047ca:	e84a                	sd	s2,16(sp)
    800047cc:	e44e                	sd	s3,8(sp)
    800047ce:	1800                	addi	s0,sp,48
    800047d0:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    800047d2:	00850913          	addi	s2,a0,8
    800047d6:	854a                	mv	a0,s2
    800047d8:	ffffc097          	auipc	ra,0xffffc
    800047dc:	3f8080e7          	jalr	1016(ra) # 80000bd0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800047e0:	409c                	lw	a5,0(s1)
    800047e2:	ef99                	bnez	a5,80004800 <holdingsleep+0x3e>
    800047e4:	4481                	li	s1,0
  release(&lk->lk);
    800047e6:	854a                	mv	a0,s2
    800047e8:	ffffc097          	auipc	ra,0xffffc
    800047ec:	49c080e7          	jalr	1180(ra) # 80000c84 <release>
  return r;
}
    800047f0:	8526                	mv	a0,s1
    800047f2:	70a2                	ld	ra,40(sp)
    800047f4:	7402                	ld	s0,32(sp)
    800047f6:	64e2                	ld	s1,24(sp)
    800047f8:	6942                	ld	s2,16(sp)
    800047fa:	69a2                	ld	s3,8(sp)
    800047fc:	6145                	addi	sp,sp,48
    800047fe:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80004800:	0284a983          	lw	s3,40(s1)
    80004804:	ffffd097          	auipc	ra,0xffffd
    80004808:	28e080e7          	jalr	654(ra) # 80001a92 <myproc>
    8000480c:	5904                	lw	s1,48(a0)
    8000480e:	413484b3          	sub	s1,s1,s3
    80004812:	0014b493          	seqz	s1,s1
    80004816:	bfc1                	j	800047e6 <holdingsleep+0x24>

0000000080004818 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80004818:	1141                	addi	sp,sp,-16
    8000481a:	e406                	sd	ra,8(sp)
    8000481c:	e022                	sd	s0,0(sp)
    8000481e:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80004820:	00004597          	auipc	a1,0x4
    80004824:	ee858593          	addi	a1,a1,-280 # 80008708 <syscalls+0x248>
    80004828:	0041d517          	auipc	a0,0x41d
    8000482c:	19050513          	addi	a0,a0,400 # 804219b8 <ftable>
    80004830:	ffffc097          	auipc	ra,0xffffc
    80004834:	310080e7          	jalr	784(ra) # 80000b40 <initlock>
}
    80004838:	60a2                	ld	ra,8(sp)
    8000483a:	6402                	ld	s0,0(sp)
    8000483c:	0141                	addi	sp,sp,16
    8000483e:	8082                	ret

0000000080004840 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80004840:	1101                	addi	sp,sp,-32
    80004842:	ec06                	sd	ra,24(sp)
    80004844:	e822                	sd	s0,16(sp)
    80004846:	e426                	sd	s1,8(sp)
    80004848:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    8000484a:	0041d517          	auipc	a0,0x41d
    8000484e:	16e50513          	addi	a0,a0,366 # 804219b8 <ftable>
    80004852:	ffffc097          	auipc	ra,0xffffc
    80004856:	37e080e7          	jalr	894(ra) # 80000bd0 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000485a:	0041d497          	auipc	s1,0x41d
    8000485e:	17648493          	addi	s1,s1,374 # 804219d0 <ftable+0x18>
    80004862:	0041e717          	auipc	a4,0x41e
    80004866:	10e70713          	addi	a4,a4,270 # 80422970 <ftable+0xfb8>
    if(f->ref == 0){
    8000486a:	40dc                	lw	a5,4(s1)
    8000486c:	cf99                	beqz	a5,8000488a <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000486e:	02848493          	addi	s1,s1,40
    80004872:	fee49ce3          	bne	s1,a4,8000486a <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80004876:	0041d517          	auipc	a0,0x41d
    8000487a:	14250513          	addi	a0,a0,322 # 804219b8 <ftable>
    8000487e:	ffffc097          	auipc	ra,0xffffc
    80004882:	406080e7          	jalr	1030(ra) # 80000c84 <release>
  return 0;
    80004886:	4481                	li	s1,0
    80004888:	a819                	j	8000489e <filealloc+0x5e>
      f->ref = 1;
    8000488a:	4785                	li	a5,1
    8000488c:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    8000488e:	0041d517          	auipc	a0,0x41d
    80004892:	12a50513          	addi	a0,a0,298 # 804219b8 <ftable>
    80004896:	ffffc097          	auipc	ra,0xffffc
    8000489a:	3ee080e7          	jalr	1006(ra) # 80000c84 <release>
}
    8000489e:	8526                	mv	a0,s1
    800048a0:	60e2                	ld	ra,24(sp)
    800048a2:	6442                	ld	s0,16(sp)
    800048a4:	64a2                	ld	s1,8(sp)
    800048a6:	6105                	addi	sp,sp,32
    800048a8:	8082                	ret

00000000800048aa <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    800048aa:	1101                	addi	sp,sp,-32
    800048ac:	ec06                	sd	ra,24(sp)
    800048ae:	e822                	sd	s0,16(sp)
    800048b0:	e426                	sd	s1,8(sp)
    800048b2:	1000                	addi	s0,sp,32
    800048b4:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    800048b6:	0041d517          	auipc	a0,0x41d
    800048ba:	10250513          	addi	a0,a0,258 # 804219b8 <ftable>
    800048be:	ffffc097          	auipc	ra,0xffffc
    800048c2:	312080e7          	jalr	786(ra) # 80000bd0 <acquire>
  if(f->ref < 1)
    800048c6:	40dc                	lw	a5,4(s1)
    800048c8:	02f05263          	blez	a5,800048ec <filedup+0x42>
    panic("filedup");
  f->ref++;
    800048cc:	2785                	addiw	a5,a5,1
    800048ce:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    800048d0:	0041d517          	auipc	a0,0x41d
    800048d4:	0e850513          	addi	a0,a0,232 # 804219b8 <ftable>
    800048d8:	ffffc097          	auipc	ra,0xffffc
    800048dc:	3ac080e7          	jalr	940(ra) # 80000c84 <release>
  return f;
}
    800048e0:	8526                	mv	a0,s1
    800048e2:	60e2                	ld	ra,24(sp)
    800048e4:	6442                	ld	s0,16(sp)
    800048e6:	64a2                	ld	s1,8(sp)
    800048e8:	6105                	addi	sp,sp,32
    800048ea:	8082                	ret
    panic("filedup");
    800048ec:	00004517          	auipc	a0,0x4
    800048f0:	e2450513          	addi	a0,a0,-476 # 80008710 <syscalls+0x250>
    800048f4:	ffffc097          	auipc	ra,0xffffc
    800048f8:	c44080e7          	jalr	-956(ra) # 80000538 <panic>

00000000800048fc <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    800048fc:	7139                	addi	sp,sp,-64
    800048fe:	fc06                	sd	ra,56(sp)
    80004900:	f822                	sd	s0,48(sp)
    80004902:	f426                	sd	s1,40(sp)
    80004904:	f04a                	sd	s2,32(sp)
    80004906:	ec4e                	sd	s3,24(sp)
    80004908:	e852                	sd	s4,16(sp)
    8000490a:	e456                	sd	s5,8(sp)
    8000490c:	0080                	addi	s0,sp,64
    8000490e:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80004910:	0041d517          	auipc	a0,0x41d
    80004914:	0a850513          	addi	a0,a0,168 # 804219b8 <ftable>
    80004918:	ffffc097          	auipc	ra,0xffffc
    8000491c:	2b8080e7          	jalr	696(ra) # 80000bd0 <acquire>
  if(f->ref < 1)
    80004920:	40dc                	lw	a5,4(s1)
    80004922:	06f05163          	blez	a5,80004984 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80004926:	37fd                	addiw	a5,a5,-1
    80004928:	0007871b          	sext.w	a4,a5
    8000492c:	c0dc                	sw	a5,4(s1)
    8000492e:	06e04363          	bgtz	a4,80004994 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80004932:	0004a903          	lw	s2,0(s1)
    80004936:	0094ca83          	lbu	s5,9(s1)
    8000493a:	0104ba03          	ld	s4,16(s1)
    8000493e:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80004942:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80004946:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    8000494a:	0041d517          	auipc	a0,0x41d
    8000494e:	06e50513          	addi	a0,a0,110 # 804219b8 <ftable>
    80004952:	ffffc097          	auipc	ra,0xffffc
    80004956:	332080e7          	jalr	818(ra) # 80000c84 <release>

  if(ff.type == FD_PIPE){
    8000495a:	4785                	li	a5,1
    8000495c:	04f90d63          	beq	s2,a5,800049b6 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80004960:	3979                	addiw	s2,s2,-2
    80004962:	4785                	li	a5,1
    80004964:	0527e063          	bltu	a5,s2,800049a4 <fileclose+0xa8>
    begin_op();
    80004968:	00000097          	auipc	ra,0x0
    8000496c:	ac8080e7          	jalr	-1336(ra) # 80004430 <begin_op>
    iput(ff.ip);
    80004970:	854e                	mv	a0,s3
    80004972:	fffff097          	auipc	ra,0xfffff
    80004976:	2a6080e7          	jalr	678(ra) # 80003c18 <iput>
    end_op();
    8000497a:	00000097          	auipc	ra,0x0
    8000497e:	b36080e7          	jalr	-1226(ra) # 800044b0 <end_op>
    80004982:	a00d                	j	800049a4 <fileclose+0xa8>
    panic("fileclose");
    80004984:	00004517          	auipc	a0,0x4
    80004988:	d9450513          	addi	a0,a0,-620 # 80008718 <syscalls+0x258>
    8000498c:	ffffc097          	auipc	ra,0xffffc
    80004990:	bac080e7          	jalr	-1108(ra) # 80000538 <panic>
    release(&ftable.lock);
    80004994:	0041d517          	auipc	a0,0x41d
    80004998:	02450513          	addi	a0,a0,36 # 804219b8 <ftable>
    8000499c:	ffffc097          	auipc	ra,0xffffc
    800049a0:	2e8080e7          	jalr	744(ra) # 80000c84 <release>
  }
}
    800049a4:	70e2                	ld	ra,56(sp)
    800049a6:	7442                	ld	s0,48(sp)
    800049a8:	74a2                	ld	s1,40(sp)
    800049aa:	7902                	ld	s2,32(sp)
    800049ac:	69e2                	ld	s3,24(sp)
    800049ae:	6a42                	ld	s4,16(sp)
    800049b0:	6aa2                	ld	s5,8(sp)
    800049b2:	6121                	addi	sp,sp,64
    800049b4:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    800049b6:	85d6                	mv	a1,s5
    800049b8:	8552                	mv	a0,s4
    800049ba:	00000097          	auipc	ra,0x0
    800049be:	34c080e7          	jalr	844(ra) # 80004d06 <pipeclose>
    800049c2:	b7cd                	j	800049a4 <fileclose+0xa8>

00000000800049c4 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    800049c4:	715d                	addi	sp,sp,-80
    800049c6:	e486                	sd	ra,72(sp)
    800049c8:	e0a2                	sd	s0,64(sp)
    800049ca:	fc26                	sd	s1,56(sp)
    800049cc:	f84a                	sd	s2,48(sp)
    800049ce:	f44e                	sd	s3,40(sp)
    800049d0:	0880                	addi	s0,sp,80
    800049d2:	84aa                	mv	s1,a0
    800049d4:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    800049d6:	ffffd097          	auipc	ra,0xffffd
    800049da:	0bc080e7          	jalr	188(ra) # 80001a92 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    800049de:	409c                	lw	a5,0(s1)
    800049e0:	37f9                	addiw	a5,a5,-2
    800049e2:	4705                	li	a4,1
    800049e4:	04f76763          	bltu	a4,a5,80004a32 <filestat+0x6e>
    800049e8:	892a                	mv	s2,a0
    ilock(f->ip);
    800049ea:	6c88                	ld	a0,24(s1)
    800049ec:	fffff097          	auipc	ra,0xfffff
    800049f0:	072080e7          	jalr	114(ra) # 80003a5e <ilock>
    stati(f->ip, &st);
    800049f4:	fb840593          	addi	a1,s0,-72
    800049f8:	6c88                	ld	a0,24(s1)
    800049fa:	fffff097          	auipc	ra,0xfffff
    800049fe:	2ee080e7          	jalr	750(ra) # 80003ce8 <stati>
    iunlock(f->ip);
    80004a02:	6c88                	ld	a0,24(s1)
    80004a04:	fffff097          	auipc	ra,0xfffff
    80004a08:	11c080e7          	jalr	284(ra) # 80003b20 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80004a0c:	46e1                	li	a3,24
    80004a0e:	fb840613          	addi	a2,s0,-72
    80004a12:	85ce                	mv	a1,s3
    80004a14:	05093503          	ld	a0,80(s2)
    80004a18:	ffffd097          	auipc	ra,0xffffd
    80004a1c:	c3e080e7          	jalr	-962(ra) # 80001656 <copyout>
    80004a20:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80004a24:	60a6                	ld	ra,72(sp)
    80004a26:	6406                	ld	s0,64(sp)
    80004a28:	74e2                	ld	s1,56(sp)
    80004a2a:	7942                	ld	s2,48(sp)
    80004a2c:	79a2                	ld	s3,40(sp)
    80004a2e:	6161                	addi	sp,sp,80
    80004a30:	8082                	ret
  return -1;
    80004a32:	557d                	li	a0,-1
    80004a34:	bfc5                	j	80004a24 <filestat+0x60>

0000000080004a36 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80004a36:	7179                	addi	sp,sp,-48
    80004a38:	f406                	sd	ra,40(sp)
    80004a3a:	f022                	sd	s0,32(sp)
    80004a3c:	ec26                	sd	s1,24(sp)
    80004a3e:	e84a                	sd	s2,16(sp)
    80004a40:	e44e                	sd	s3,8(sp)
    80004a42:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80004a44:	00854783          	lbu	a5,8(a0)
    80004a48:	c3d5                	beqz	a5,80004aec <fileread+0xb6>
    80004a4a:	84aa                	mv	s1,a0
    80004a4c:	89ae                	mv	s3,a1
    80004a4e:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80004a50:	411c                	lw	a5,0(a0)
    80004a52:	4705                	li	a4,1
    80004a54:	04e78963          	beq	a5,a4,80004aa6 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80004a58:	470d                	li	a4,3
    80004a5a:	04e78d63          	beq	a5,a4,80004ab4 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80004a5e:	4709                	li	a4,2
    80004a60:	06e79e63          	bne	a5,a4,80004adc <fileread+0xa6>
    ilock(f->ip);
    80004a64:	6d08                	ld	a0,24(a0)
    80004a66:	fffff097          	auipc	ra,0xfffff
    80004a6a:	ff8080e7          	jalr	-8(ra) # 80003a5e <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80004a6e:	874a                	mv	a4,s2
    80004a70:	5094                	lw	a3,32(s1)
    80004a72:	864e                	mv	a2,s3
    80004a74:	4585                	li	a1,1
    80004a76:	6c88                	ld	a0,24(s1)
    80004a78:	fffff097          	auipc	ra,0xfffff
    80004a7c:	29a080e7          	jalr	666(ra) # 80003d12 <readi>
    80004a80:	892a                	mv	s2,a0
    80004a82:	00a05563          	blez	a0,80004a8c <fileread+0x56>
      f->off += r;
    80004a86:	509c                	lw	a5,32(s1)
    80004a88:	9fa9                	addw	a5,a5,a0
    80004a8a:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80004a8c:	6c88                	ld	a0,24(s1)
    80004a8e:	fffff097          	auipc	ra,0xfffff
    80004a92:	092080e7          	jalr	146(ra) # 80003b20 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80004a96:	854a                	mv	a0,s2
    80004a98:	70a2                	ld	ra,40(sp)
    80004a9a:	7402                	ld	s0,32(sp)
    80004a9c:	64e2                	ld	s1,24(sp)
    80004a9e:	6942                	ld	s2,16(sp)
    80004aa0:	69a2                	ld	s3,8(sp)
    80004aa2:	6145                	addi	sp,sp,48
    80004aa4:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80004aa6:	6908                	ld	a0,16(a0)
    80004aa8:	00000097          	auipc	ra,0x0
    80004aac:	3c0080e7          	jalr	960(ra) # 80004e68 <piperead>
    80004ab0:	892a                	mv	s2,a0
    80004ab2:	b7d5                	j	80004a96 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80004ab4:	02451783          	lh	a5,36(a0)
    80004ab8:	03079693          	slli	a3,a5,0x30
    80004abc:	92c1                	srli	a3,a3,0x30
    80004abe:	4725                	li	a4,9
    80004ac0:	02d76863          	bltu	a4,a3,80004af0 <fileread+0xba>
    80004ac4:	0792                	slli	a5,a5,0x4
    80004ac6:	0041d717          	auipc	a4,0x41d
    80004aca:	e5270713          	addi	a4,a4,-430 # 80421918 <devsw>
    80004ace:	97ba                	add	a5,a5,a4
    80004ad0:	639c                	ld	a5,0(a5)
    80004ad2:	c38d                	beqz	a5,80004af4 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80004ad4:	4505                	li	a0,1
    80004ad6:	9782                	jalr	a5
    80004ad8:	892a                	mv	s2,a0
    80004ada:	bf75                	j	80004a96 <fileread+0x60>
    panic("fileread");
    80004adc:	00004517          	auipc	a0,0x4
    80004ae0:	c4c50513          	addi	a0,a0,-948 # 80008728 <syscalls+0x268>
    80004ae4:	ffffc097          	auipc	ra,0xffffc
    80004ae8:	a54080e7          	jalr	-1452(ra) # 80000538 <panic>
    return -1;
    80004aec:	597d                	li	s2,-1
    80004aee:	b765                	j	80004a96 <fileread+0x60>
      return -1;
    80004af0:	597d                	li	s2,-1
    80004af2:	b755                	j	80004a96 <fileread+0x60>
    80004af4:	597d                	li	s2,-1
    80004af6:	b745                	j	80004a96 <fileread+0x60>

0000000080004af8 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80004af8:	715d                	addi	sp,sp,-80
    80004afa:	e486                	sd	ra,72(sp)
    80004afc:	e0a2                	sd	s0,64(sp)
    80004afe:	fc26                	sd	s1,56(sp)
    80004b00:	f84a                	sd	s2,48(sp)
    80004b02:	f44e                	sd	s3,40(sp)
    80004b04:	f052                	sd	s4,32(sp)
    80004b06:	ec56                	sd	s5,24(sp)
    80004b08:	e85a                	sd	s6,16(sp)
    80004b0a:	e45e                	sd	s7,8(sp)
    80004b0c:	e062                	sd	s8,0(sp)
    80004b0e:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    80004b10:	00954783          	lbu	a5,9(a0)
    80004b14:	10078663          	beqz	a5,80004c20 <filewrite+0x128>
    80004b18:	892a                	mv	s2,a0
    80004b1a:	8aae                	mv	s5,a1
    80004b1c:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80004b1e:	411c                	lw	a5,0(a0)
    80004b20:	4705                	li	a4,1
    80004b22:	02e78263          	beq	a5,a4,80004b46 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80004b26:	470d                	li	a4,3
    80004b28:	02e78663          	beq	a5,a4,80004b54 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80004b2c:	4709                	li	a4,2
    80004b2e:	0ee79163          	bne	a5,a4,80004c10 <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80004b32:	0ac05d63          	blez	a2,80004bec <filewrite+0xf4>
    int i = 0;
    80004b36:	4981                	li	s3,0
    80004b38:	6b05                	lui	s6,0x1
    80004b3a:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80004b3e:	6b85                	lui	s7,0x1
    80004b40:	c00b8b9b          	addiw	s7,s7,-1024
    80004b44:	a861                	j	80004bdc <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    80004b46:	6908                	ld	a0,16(a0)
    80004b48:	00000097          	auipc	ra,0x0
    80004b4c:	22e080e7          	jalr	558(ra) # 80004d76 <pipewrite>
    80004b50:	8a2a                	mv	s4,a0
    80004b52:	a045                	j	80004bf2 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80004b54:	02451783          	lh	a5,36(a0)
    80004b58:	03079693          	slli	a3,a5,0x30
    80004b5c:	92c1                	srli	a3,a3,0x30
    80004b5e:	4725                	li	a4,9
    80004b60:	0cd76263          	bltu	a4,a3,80004c24 <filewrite+0x12c>
    80004b64:	0792                	slli	a5,a5,0x4
    80004b66:	0041d717          	auipc	a4,0x41d
    80004b6a:	db270713          	addi	a4,a4,-590 # 80421918 <devsw>
    80004b6e:	97ba                	add	a5,a5,a4
    80004b70:	679c                	ld	a5,8(a5)
    80004b72:	cbdd                	beqz	a5,80004c28 <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    80004b74:	4505                	li	a0,1
    80004b76:	9782                	jalr	a5
    80004b78:	8a2a                	mv	s4,a0
    80004b7a:	a8a5                	j	80004bf2 <filewrite+0xfa>
    80004b7c:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80004b80:	00000097          	auipc	ra,0x0
    80004b84:	8b0080e7          	jalr	-1872(ra) # 80004430 <begin_op>
      ilock(f->ip);
    80004b88:	01893503          	ld	a0,24(s2)
    80004b8c:	fffff097          	auipc	ra,0xfffff
    80004b90:	ed2080e7          	jalr	-302(ra) # 80003a5e <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80004b94:	8762                	mv	a4,s8
    80004b96:	02092683          	lw	a3,32(s2)
    80004b9a:	01598633          	add	a2,s3,s5
    80004b9e:	4585                	li	a1,1
    80004ba0:	01893503          	ld	a0,24(s2)
    80004ba4:	fffff097          	auipc	ra,0xfffff
    80004ba8:	266080e7          	jalr	614(ra) # 80003e0a <writei>
    80004bac:	84aa                	mv	s1,a0
    80004bae:	00a05763          	blez	a0,80004bbc <filewrite+0xc4>
        f->off += r;
    80004bb2:	02092783          	lw	a5,32(s2)
    80004bb6:	9fa9                	addw	a5,a5,a0
    80004bb8:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80004bbc:	01893503          	ld	a0,24(s2)
    80004bc0:	fffff097          	auipc	ra,0xfffff
    80004bc4:	f60080e7          	jalr	-160(ra) # 80003b20 <iunlock>
      end_op();
    80004bc8:	00000097          	auipc	ra,0x0
    80004bcc:	8e8080e7          	jalr	-1816(ra) # 800044b0 <end_op>

      if(r != n1){
    80004bd0:	009c1f63          	bne	s8,s1,80004bee <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    80004bd4:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80004bd8:	0149db63          	bge	s3,s4,80004bee <filewrite+0xf6>
      int n1 = n - i;
    80004bdc:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    80004be0:	84be                	mv	s1,a5
    80004be2:	2781                	sext.w	a5,a5
    80004be4:	f8fb5ce3          	bge	s6,a5,80004b7c <filewrite+0x84>
    80004be8:	84de                	mv	s1,s7
    80004bea:	bf49                	j	80004b7c <filewrite+0x84>
    int i = 0;
    80004bec:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80004bee:	013a1f63          	bne	s4,s3,80004c0c <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80004bf2:	8552                	mv	a0,s4
    80004bf4:	60a6                	ld	ra,72(sp)
    80004bf6:	6406                	ld	s0,64(sp)
    80004bf8:	74e2                	ld	s1,56(sp)
    80004bfa:	7942                	ld	s2,48(sp)
    80004bfc:	79a2                	ld	s3,40(sp)
    80004bfe:	7a02                	ld	s4,32(sp)
    80004c00:	6ae2                	ld	s5,24(sp)
    80004c02:	6b42                	ld	s6,16(sp)
    80004c04:	6ba2                	ld	s7,8(sp)
    80004c06:	6c02                	ld	s8,0(sp)
    80004c08:	6161                	addi	sp,sp,80
    80004c0a:	8082                	ret
    ret = (i == n ? n : -1);
    80004c0c:	5a7d                	li	s4,-1
    80004c0e:	b7d5                	j	80004bf2 <filewrite+0xfa>
    panic("filewrite");
    80004c10:	00004517          	auipc	a0,0x4
    80004c14:	b2850513          	addi	a0,a0,-1240 # 80008738 <syscalls+0x278>
    80004c18:	ffffc097          	auipc	ra,0xffffc
    80004c1c:	920080e7          	jalr	-1760(ra) # 80000538 <panic>
    return -1;
    80004c20:	5a7d                	li	s4,-1
    80004c22:	bfc1                	j	80004bf2 <filewrite+0xfa>
      return -1;
    80004c24:	5a7d                	li	s4,-1
    80004c26:	b7f1                	j	80004bf2 <filewrite+0xfa>
    80004c28:	5a7d                	li	s4,-1
    80004c2a:	b7e1                	j	80004bf2 <filewrite+0xfa>

0000000080004c2c <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80004c2c:	7179                	addi	sp,sp,-48
    80004c2e:	f406                	sd	ra,40(sp)
    80004c30:	f022                	sd	s0,32(sp)
    80004c32:	ec26                	sd	s1,24(sp)
    80004c34:	e84a                	sd	s2,16(sp)
    80004c36:	e44e                	sd	s3,8(sp)
    80004c38:	e052                	sd	s4,0(sp)
    80004c3a:	1800                	addi	s0,sp,48
    80004c3c:	84aa                	mv	s1,a0
    80004c3e:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80004c40:	0005b023          	sd	zero,0(a1)
    80004c44:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80004c48:	00000097          	auipc	ra,0x0
    80004c4c:	bf8080e7          	jalr	-1032(ra) # 80004840 <filealloc>
    80004c50:	e088                	sd	a0,0(s1)
    80004c52:	c551                	beqz	a0,80004cde <pipealloc+0xb2>
    80004c54:	00000097          	auipc	ra,0x0
    80004c58:	bec080e7          	jalr	-1044(ra) # 80004840 <filealloc>
    80004c5c:	00aa3023          	sd	a0,0(s4)
    80004c60:	c92d                	beqz	a0,80004cd2 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80004c62:	ffffc097          	auipc	ra,0xffffc
    80004c66:	e7e080e7          	jalr	-386(ra) # 80000ae0 <kalloc>
    80004c6a:	892a                	mv	s2,a0
    80004c6c:	c125                	beqz	a0,80004ccc <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80004c6e:	4985                	li	s3,1
    80004c70:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80004c74:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80004c78:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80004c7c:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80004c80:	00004597          	auipc	a1,0x4
    80004c84:	ac858593          	addi	a1,a1,-1336 # 80008748 <syscalls+0x288>
    80004c88:	ffffc097          	auipc	ra,0xffffc
    80004c8c:	eb8080e7          	jalr	-328(ra) # 80000b40 <initlock>
  (*f0)->type = FD_PIPE;
    80004c90:	609c                	ld	a5,0(s1)
    80004c92:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80004c96:	609c                	ld	a5,0(s1)
    80004c98:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80004c9c:	609c                	ld	a5,0(s1)
    80004c9e:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80004ca2:	609c                	ld	a5,0(s1)
    80004ca4:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80004ca8:	000a3783          	ld	a5,0(s4)
    80004cac:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80004cb0:	000a3783          	ld	a5,0(s4)
    80004cb4:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80004cb8:	000a3783          	ld	a5,0(s4)
    80004cbc:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80004cc0:	000a3783          	ld	a5,0(s4)
    80004cc4:	0127b823          	sd	s2,16(a5)
  return 0;
    80004cc8:	4501                	li	a0,0
    80004cca:	a025                	j	80004cf2 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004ccc:	6088                	ld	a0,0(s1)
    80004cce:	e501                	bnez	a0,80004cd6 <pipealloc+0xaa>
    80004cd0:	a039                	j	80004cde <pipealloc+0xb2>
    80004cd2:	6088                	ld	a0,0(s1)
    80004cd4:	c51d                	beqz	a0,80004d02 <pipealloc+0xd6>
    fileclose(*f0);
    80004cd6:	00000097          	auipc	ra,0x0
    80004cda:	c26080e7          	jalr	-986(ra) # 800048fc <fileclose>
  if(*f1)
    80004cde:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80004ce2:	557d                	li	a0,-1
  if(*f1)
    80004ce4:	c799                	beqz	a5,80004cf2 <pipealloc+0xc6>
    fileclose(*f1);
    80004ce6:	853e                	mv	a0,a5
    80004ce8:	00000097          	auipc	ra,0x0
    80004cec:	c14080e7          	jalr	-1004(ra) # 800048fc <fileclose>
  return -1;
    80004cf0:	557d                	li	a0,-1
}
    80004cf2:	70a2                	ld	ra,40(sp)
    80004cf4:	7402                	ld	s0,32(sp)
    80004cf6:	64e2                	ld	s1,24(sp)
    80004cf8:	6942                	ld	s2,16(sp)
    80004cfa:	69a2                	ld	s3,8(sp)
    80004cfc:	6a02                	ld	s4,0(sp)
    80004cfe:	6145                	addi	sp,sp,48
    80004d00:	8082                	ret
  return -1;
    80004d02:	557d                	li	a0,-1
    80004d04:	b7fd                	j	80004cf2 <pipealloc+0xc6>

0000000080004d06 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004d06:	1101                	addi	sp,sp,-32
    80004d08:	ec06                	sd	ra,24(sp)
    80004d0a:	e822                	sd	s0,16(sp)
    80004d0c:	e426                	sd	s1,8(sp)
    80004d0e:	e04a                	sd	s2,0(sp)
    80004d10:	1000                	addi	s0,sp,32
    80004d12:	84aa                	mv	s1,a0
    80004d14:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80004d16:	ffffc097          	auipc	ra,0xffffc
    80004d1a:	eba080e7          	jalr	-326(ra) # 80000bd0 <acquire>
  if(writable){
    80004d1e:	02090d63          	beqz	s2,80004d58 <pipeclose+0x52>
    pi->writeopen = 0;
    80004d22:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80004d26:	21848513          	addi	a0,s1,536
    80004d2a:	ffffd097          	auipc	ra,0xffffd
    80004d2e:	5ee080e7          	jalr	1518(ra) # 80002318 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004d32:	2204b783          	ld	a5,544(s1)
    80004d36:	eb95                	bnez	a5,80004d6a <pipeclose+0x64>
    release(&pi->lock);
    80004d38:	8526                	mv	a0,s1
    80004d3a:	ffffc097          	auipc	ra,0xffffc
    80004d3e:	f4a080e7          	jalr	-182(ra) # 80000c84 <release>
    kfree((char*)pi);
    80004d42:	8526                	mv	a0,s1
    80004d44:	ffffc097          	auipc	ra,0xffffc
    80004d48:	ca0080e7          	jalr	-864(ra) # 800009e4 <kfree>
  } else
    release(&pi->lock);
}
    80004d4c:	60e2                	ld	ra,24(sp)
    80004d4e:	6442                	ld	s0,16(sp)
    80004d50:	64a2                	ld	s1,8(sp)
    80004d52:	6902                	ld	s2,0(sp)
    80004d54:	6105                	addi	sp,sp,32
    80004d56:	8082                	ret
    pi->readopen = 0;
    80004d58:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80004d5c:	21c48513          	addi	a0,s1,540
    80004d60:	ffffd097          	auipc	ra,0xffffd
    80004d64:	5b8080e7          	jalr	1464(ra) # 80002318 <wakeup>
    80004d68:	b7e9                	j	80004d32 <pipeclose+0x2c>
    release(&pi->lock);
    80004d6a:	8526                	mv	a0,s1
    80004d6c:	ffffc097          	auipc	ra,0xffffc
    80004d70:	f18080e7          	jalr	-232(ra) # 80000c84 <release>
}
    80004d74:	bfe1                	j	80004d4c <pipeclose+0x46>

0000000080004d76 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80004d76:	711d                	addi	sp,sp,-96
    80004d78:	ec86                	sd	ra,88(sp)
    80004d7a:	e8a2                	sd	s0,80(sp)
    80004d7c:	e4a6                	sd	s1,72(sp)
    80004d7e:	e0ca                	sd	s2,64(sp)
    80004d80:	fc4e                	sd	s3,56(sp)
    80004d82:	f852                	sd	s4,48(sp)
    80004d84:	f456                	sd	s5,40(sp)
    80004d86:	f05a                	sd	s6,32(sp)
    80004d88:	ec5e                	sd	s7,24(sp)
    80004d8a:	e862                	sd	s8,16(sp)
    80004d8c:	1080                	addi	s0,sp,96
    80004d8e:	84aa                	mv	s1,a0
    80004d90:	8aae                	mv	s5,a1
    80004d92:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80004d94:	ffffd097          	auipc	ra,0xffffd
    80004d98:	cfe080e7          	jalr	-770(ra) # 80001a92 <myproc>
    80004d9c:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80004d9e:	8526                	mv	a0,s1
    80004da0:	ffffc097          	auipc	ra,0xffffc
    80004da4:	e30080e7          	jalr	-464(ra) # 80000bd0 <acquire>
  while(i < n){
    80004da8:	0b405363          	blez	s4,80004e4e <pipewrite+0xd8>
  int i = 0;
    80004dac:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004dae:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80004db0:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80004db4:	21c48b93          	addi	s7,s1,540
    80004db8:	a089                	j	80004dfa <pipewrite+0x84>
      release(&pi->lock);
    80004dba:	8526                	mv	a0,s1
    80004dbc:	ffffc097          	auipc	ra,0xffffc
    80004dc0:	ec8080e7          	jalr	-312(ra) # 80000c84 <release>
      return -1;
    80004dc4:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004dc6:	854a                	mv	a0,s2
    80004dc8:	60e6                	ld	ra,88(sp)
    80004dca:	6446                	ld	s0,80(sp)
    80004dcc:	64a6                	ld	s1,72(sp)
    80004dce:	6906                	ld	s2,64(sp)
    80004dd0:	79e2                	ld	s3,56(sp)
    80004dd2:	7a42                	ld	s4,48(sp)
    80004dd4:	7aa2                	ld	s5,40(sp)
    80004dd6:	7b02                	ld	s6,32(sp)
    80004dd8:	6be2                	ld	s7,24(sp)
    80004dda:	6c42                	ld	s8,16(sp)
    80004ddc:	6125                	addi	sp,sp,96
    80004dde:	8082                	ret
      wakeup(&pi->nread);
    80004de0:	8562                	mv	a0,s8
    80004de2:	ffffd097          	auipc	ra,0xffffd
    80004de6:	536080e7          	jalr	1334(ra) # 80002318 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004dea:	85a6                	mv	a1,s1
    80004dec:	855e                	mv	a0,s7
    80004dee:	ffffd097          	auipc	ra,0xffffd
    80004df2:	382080e7          	jalr	898(ra) # 80002170 <sleep>
  while(i < n){
    80004df6:	05495d63          	bge	s2,s4,80004e50 <pipewrite+0xda>
    if(pi->readopen == 0 || pr->killed){
    80004dfa:	2204a783          	lw	a5,544(s1)
    80004dfe:	dfd5                	beqz	a5,80004dba <pipewrite+0x44>
    80004e00:	0289a783          	lw	a5,40(s3)
    80004e04:	fbdd                	bnez	a5,80004dba <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004e06:	2184a783          	lw	a5,536(s1)
    80004e0a:	21c4a703          	lw	a4,540(s1)
    80004e0e:	2007879b          	addiw	a5,a5,512
    80004e12:	fcf707e3          	beq	a4,a5,80004de0 <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004e16:	4685                	li	a3,1
    80004e18:	01590633          	add	a2,s2,s5
    80004e1c:	faf40593          	addi	a1,s0,-81
    80004e20:	0509b503          	ld	a0,80(s3)
    80004e24:	ffffd097          	auipc	ra,0xffffd
    80004e28:	8be080e7          	jalr	-1858(ra) # 800016e2 <copyin>
    80004e2c:	03650263          	beq	a0,s6,80004e50 <pipewrite+0xda>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004e30:	21c4a783          	lw	a5,540(s1)
    80004e34:	0017871b          	addiw	a4,a5,1
    80004e38:	20e4ae23          	sw	a4,540(s1)
    80004e3c:	1ff7f793          	andi	a5,a5,511
    80004e40:	97a6                	add	a5,a5,s1
    80004e42:	faf44703          	lbu	a4,-81(s0)
    80004e46:	00e78c23          	sb	a4,24(a5)
      i++;
    80004e4a:	2905                	addiw	s2,s2,1
    80004e4c:	b76d                	j	80004df6 <pipewrite+0x80>
  int i = 0;
    80004e4e:	4901                	li	s2,0
  wakeup(&pi->nread);
    80004e50:	21848513          	addi	a0,s1,536
    80004e54:	ffffd097          	auipc	ra,0xffffd
    80004e58:	4c4080e7          	jalr	1220(ra) # 80002318 <wakeup>
  release(&pi->lock);
    80004e5c:	8526                	mv	a0,s1
    80004e5e:	ffffc097          	auipc	ra,0xffffc
    80004e62:	e26080e7          	jalr	-474(ra) # 80000c84 <release>
  return i;
    80004e66:	b785                	j	80004dc6 <pipewrite+0x50>

0000000080004e68 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004e68:	715d                	addi	sp,sp,-80
    80004e6a:	e486                	sd	ra,72(sp)
    80004e6c:	e0a2                	sd	s0,64(sp)
    80004e6e:	fc26                	sd	s1,56(sp)
    80004e70:	f84a                	sd	s2,48(sp)
    80004e72:	f44e                	sd	s3,40(sp)
    80004e74:	f052                	sd	s4,32(sp)
    80004e76:	ec56                	sd	s5,24(sp)
    80004e78:	e85a                	sd	s6,16(sp)
    80004e7a:	0880                	addi	s0,sp,80
    80004e7c:	84aa                	mv	s1,a0
    80004e7e:	892e                	mv	s2,a1
    80004e80:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80004e82:	ffffd097          	auipc	ra,0xffffd
    80004e86:	c10080e7          	jalr	-1008(ra) # 80001a92 <myproc>
    80004e8a:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80004e8c:	8526                	mv	a0,s1
    80004e8e:	ffffc097          	auipc	ra,0xffffc
    80004e92:	d42080e7          	jalr	-702(ra) # 80000bd0 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004e96:	2184a703          	lw	a4,536(s1)
    80004e9a:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004e9e:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004ea2:	02f71463          	bne	a4,a5,80004eca <piperead+0x62>
    80004ea6:	2244a783          	lw	a5,548(s1)
    80004eaa:	c385                	beqz	a5,80004eca <piperead+0x62>
    if(pr->killed){
    80004eac:	028a2783          	lw	a5,40(s4)
    80004eb0:	ebc1                	bnez	a5,80004f40 <piperead+0xd8>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004eb2:	85a6                	mv	a1,s1
    80004eb4:	854e                	mv	a0,s3
    80004eb6:	ffffd097          	auipc	ra,0xffffd
    80004eba:	2ba080e7          	jalr	698(ra) # 80002170 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004ebe:	2184a703          	lw	a4,536(s1)
    80004ec2:	21c4a783          	lw	a5,540(s1)
    80004ec6:	fef700e3          	beq	a4,a5,80004ea6 <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004eca:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004ecc:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004ece:	05505363          	blez	s5,80004f14 <piperead+0xac>
    if(pi->nread == pi->nwrite)
    80004ed2:	2184a783          	lw	a5,536(s1)
    80004ed6:	21c4a703          	lw	a4,540(s1)
    80004eda:	02f70d63          	beq	a4,a5,80004f14 <piperead+0xac>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004ede:	0017871b          	addiw	a4,a5,1
    80004ee2:	20e4ac23          	sw	a4,536(s1)
    80004ee6:	1ff7f793          	andi	a5,a5,511
    80004eea:	97a6                	add	a5,a5,s1
    80004eec:	0187c783          	lbu	a5,24(a5)
    80004ef0:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004ef4:	4685                	li	a3,1
    80004ef6:	fbf40613          	addi	a2,s0,-65
    80004efa:	85ca                	mv	a1,s2
    80004efc:	050a3503          	ld	a0,80(s4)
    80004f00:	ffffc097          	auipc	ra,0xffffc
    80004f04:	756080e7          	jalr	1878(ra) # 80001656 <copyout>
    80004f08:	01650663          	beq	a0,s6,80004f14 <piperead+0xac>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004f0c:	2985                	addiw	s3,s3,1
    80004f0e:	0905                	addi	s2,s2,1
    80004f10:	fd3a91e3          	bne	s5,s3,80004ed2 <piperead+0x6a>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004f14:	21c48513          	addi	a0,s1,540
    80004f18:	ffffd097          	auipc	ra,0xffffd
    80004f1c:	400080e7          	jalr	1024(ra) # 80002318 <wakeup>
  release(&pi->lock);
    80004f20:	8526                	mv	a0,s1
    80004f22:	ffffc097          	auipc	ra,0xffffc
    80004f26:	d62080e7          	jalr	-670(ra) # 80000c84 <release>
  return i;
}
    80004f2a:	854e                	mv	a0,s3
    80004f2c:	60a6                	ld	ra,72(sp)
    80004f2e:	6406                	ld	s0,64(sp)
    80004f30:	74e2                	ld	s1,56(sp)
    80004f32:	7942                	ld	s2,48(sp)
    80004f34:	79a2                	ld	s3,40(sp)
    80004f36:	7a02                	ld	s4,32(sp)
    80004f38:	6ae2                	ld	s5,24(sp)
    80004f3a:	6b42                	ld	s6,16(sp)
    80004f3c:	6161                	addi	sp,sp,80
    80004f3e:	8082                	ret
      release(&pi->lock);
    80004f40:	8526                	mv	a0,s1
    80004f42:	ffffc097          	auipc	ra,0xffffc
    80004f46:	d42080e7          	jalr	-702(ra) # 80000c84 <release>
      return -1;
    80004f4a:	59fd                	li	s3,-1
    80004f4c:	bff9                	j	80004f2a <piperead+0xc2>

0000000080004f4e <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    80004f4e:	de010113          	addi	sp,sp,-544
    80004f52:	20113c23          	sd	ra,536(sp)
    80004f56:	20813823          	sd	s0,528(sp)
    80004f5a:	20913423          	sd	s1,520(sp)
    80004f5e:	21213023          	sd	s2,512(sp)
    80004f62:	ffce                	sd	s3,504(sp)
    80004f64:	fbd2                	sd	s4,496(sp)
    80004f66:	f7d6                	sd	s5,488(sp)
    80004f68:	f3da                	sd	s6,480(sp)
    80004f6a:	efde                	sd	s7,472(sp)
    80004f6c:	ebe2                	sd	s8,464(sp)
    80004f6e:	e7e6                	sd	s9,456(sp)
    80004f70:	e3ea                	sd	s10,448(sp)
    80004f72:	ff6e                	sd	s11,440(sp)
    80004f74:	1400                	addi	s0,sp,544
    80004f76:	892a                	mv	s2,a0
    80004f78:	dea43423          	sd	a0,-536(s0)
    80004f7c:	deb43823          	sd	a1,-528(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004f80:	ffffd097          	auipc	ra,0xffffd
    80004f84:	b12080e7          	jalr	-1262(ra) # 80001a92 <myproc>
    80004f88:	84aa                	mv	s1,a0

  begin_op();
    80004f8a:	fffff097          	auipc	ra,0xfffff
    80004f8e:	4a6080e7          	jalr	1190(ra) # 80004430 <begin_op>

  if((ip = namei(path)) == 0){
    80004f92:	854a                	mv	a0,s2
    80004f94:	fffff097          	auipc	ra,0xfffff
    80004f98:	280080e7          	jalr	640(ra) # 80004214 <namei>
    80004f9c:	c93d                	beqz	a0,80005012 <exec+0xc4>
    80004f9e:	8aaa                	mv	s5,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004fa0:	fffff097          	auipc	ra,0xfffff
    80004fa4:	abe080e7          	jalr	-1346(ra) # 80003a5e <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004fa8:	04000713          	li	a4,64
    80004fac:	4681                	li	a3,0
    80004fae:	e5040613          	addi	a2,s0,-432
    80004fb2:	4581                	li	a1,0
    80004fb4:	8556                	mv	a0,s5
    80004fb6:	fffff097          	auipc	ra,0xfffff
    80004fba:	d5c080e7          	jalr	-676(ra) # 80003d12 <readi>
    80004fbe:	04000793          	li	a5,64
    80004fc2:	00f51a63          	bne	a0,a5,80004fd6 <exec+0x88>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80004fc6:	e5042703          	lw	a4,-432(s0)
    80004fca:	464c47b7          	lui	a5,0x464c4
    80004fce:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004fd2:	04f70663          	beq	a4,a5,8000501e <exec+0xd0>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80004fd6:	8556                	mv	a0,s5
    80004fd8:	fffff097          	auipc	ra,0xfffff
    80004fdc:	ce8080e7          	jalr	-792(ra) # 80003cc0 <iunlockput>
    end_op();
    80004fe0:	fffff097          	auipc	ra,0xfffff
    80004fe4:	4d0080e7          	jalr	1232(ra) # 800044b0 <end_op>
  }
  return -1;
    80004fe8:	557d                	li	a0,-1
}
    80004fea:	21813083          	ld	ra,536(sp)
    80004fee:	21013403          	ld	s0,528(sp)
    80004ff2:	20813483          	ld	s1,520(sp)
    80004ff6:	20013903          	ld	s2,512(sp)
    80004ffa:	79fe                	ld	s3,504(sp)
    80004ffc:	7a5e                	ld	s4,496(sp)
    80004ffe:	7abe                	ld	s5,488(sp)
    80005000:	7b1e                	ld	s6,480(sp)
    80005002:	6bfe                	ld	s7,472(sp)
    80005004:	6c5e                	ld	s8,464(sp)
    80005006:	6cbe                	ld	s9,456(sp)
    80005008:	6d1e                	ld	s10,448(sp)
    8000500a:	7dfa                	ld	s11,440(sp)
    8000500c:	22010113          	addi	sp,sp,544
    80005010:	8082                	ret
    end_op();
    80005012:	fffff097          	auipc	ra,0xfffff
    80005016:	49e080e7          	jalr	1182(ra) # 800044b0 <end_op>
    return -1;
    8000501a:	557d                	li	a0,-1
    8000501c:	b7f9                	j	80004fea <exec+0x9c>
  if((pagetable = proc_pagetable(p)) == 0)
    8000501e:	8526                	mv	a0,s1
    80005020:	ffffd097          	auipc	ra,0xffffd
    80005024:	b36080e7          	jalr	-1226(ra) # 80001b56 <proc_pagetable>
    80005028:	8b2a                	mv	s6,a0
    8000502a:	d555                	beqz	a0,80004fd6 <exec+0x88>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000502c:	e7042783          	lw	a5,-400(s0)
    80005030:	e8845703          	lhu	a4,-376(s0)
    80005034:	c735                	beqz	a4,800050a0 <exec+0x152>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80005036:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80005038:	e0043423          	sd	zero,-504(s0)
    if((ph.vaddr % PGSIZE) != 0)
    8000503c:	6a05                	lui	s4,0x1
    8000503e:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    80005042:	dee43023          	sd	a4,-544(s0)
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    80005046:	6d85                	lui	s11,0x1
    80005048:	7d7d                	lui	s10,0xfffff
    8000504a:	ac1d                	j	80005280 <exec+0x332>
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    8000504c:	00003517          	auipc	a0,0x3
    80005050:	70450513          	addi	a0,a0,1796 # 80008750 <syscalls+0x290>
    80005054:	ffffb097          	auipc	ra,0xffffb
    80005058:	4e4080e7          	jalr	1252(ra) # 80000538 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    8000505c:	874a                	mv	a4,s2
    8000505e:	009c86bb          	addw	a3,s9,s1
    80005062:	4581                	li	a1,0
    80005064:	8556                	mv	a0,s5
    80005066:	fffff097          	auipc	ra,0xfffff
    8000506a:	cac080e7          	jalr	-852(ra) # 80003d12 <readi>
    8000506e:	2501                	sext.w	a0,a0
    80005070:	1aa91863          	bne	s2,a0,80005220 <exec+0x2d2>
  for(i = 0; i < sz; i += PGSIZE){
    80005074:	009d84bb          	addw	s1,s11,s1
    80005078:	013d09bb          	addw	s3,s10,s3
    8000507c:	1f74f263          	bgeu	s1,s7,80005260 <exec+0x312>
    pa = walkaddr(pagetable, va + i);
    80005080:	02049593          	slli	a1,s1,0x20
    80005084:	9181                	srli	a1,a1,0x20
    80005086:	95e2                	add	a1,a1,s8
    80005088:	855a                	mv	a0,s6
    8000508a:	ffffc097          	auipc	ra,0xffffc
    8000508e:	fc8080e7          	jalr	-56(ra) # 80001052 <walkaddr>
    80005092:	862a                	mv	a2,a0
    if(pa == 0)
    80005094:	dd45                	beqz	a0,8000504c <exec+0xfe>
      n = PGSIZE;
    80005096:	8952                	mv	s2,s4
    if(sz - i < PGSIZE)
    80005098:	fd49f2e3          	bgeu	s3,s4,8000505c <exec+0x10e>
      n = sz - i;
    8000509c:	894e                	mv	s2,s3
    8000509e:	bf7d                	j	8000505c <exec+0x10e>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800050a0:	4481                	li	s1,0
  iunlockput(ip);
    800050a2:	8556                	mv	a0,s5
    800050a4:	fffff097          	auipc	ra,0xfffff
    800050a8:	c1c080e7          	jalr	-996(ra) # 80003cc0 <iunlockput>
  end_op();
    800050ac:	fffff097          	auipc	ra,0xfffff
    800050b0:	404080e7          	jalr	1028(ra) # 800044b0 <end_op>
  p = myproc();
    800050b4:	ffffd097          	auipc	ra,0xffffd
    800050b8:	9de080e7          	jalr	-1570(ra) # 80001a92 <myproc>
    800050bc:	8baa                	mv	s7,a0
  uint64 oldsz = p->sz;
    800050be:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    800050c2:	6785                	lui	a5,0x1
    800050c4:	17fd                	addi	a5,a5,-1
    800050c6:	94be                	add	s1,s1,a5
    800050c8:	77fd                	lui	a5,0xfffff
    800050ca:	8fe5                	and	a5,a5,s1
    800050cc:	def43c23          	sd	a5,-520(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    800050d0:	6609                	lui	a2,0x2
    800050d2:	963e                	add	a2,a2,a5
    800050d4:	85be                	mv	a1,a5
    800050d6:	855a                	mv	a0,s6
    800050d8:	ffffc097          	auipc	ra,0xffffc
    800050dc:	32e080e7          	jalr	814(ra) # 80001406 <uvmalloc>
    800050e0:	8c2a                	mv	s8,a0
  ip = 0;
    800050e2:	4a81                	li	s5,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    800050e4:	12050e63          	beqz	a0,80005220 <exec+0x2d2>
  uvmclear(pagetable, sz-2*PGSIZE);
    800050e8:	75f9                	lui	a1,0xffffe
    800050ea:	95aa                	add	a1,a1,a0
    800050ec:	855a                	mv	a0,s6
    800050ee:	ffffc097          	auipc	ra,0xffffc
    800050f2:	536080e7          	jalr	1334(ra) # 80001624 <uvmclear>
  stackbase = sp - PGSIZE;
    800050f6:	7afd                	lui	s5,0xfffff
    800050f8:	9ae2                	add	s5,s5,s8
  for(argc = 0; argv[argc]; argc++) {
    800050fa:	df043783          	ld	a5,-528(s0)
    800050fe:	6388                	ld	a0,0(a5)
    80005100:	c925                	beqz	a0,80005170 <exec+0x222>
    80005102:	e9040993          	addi	s3,s0,-368
    80005106:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    8000510a:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    8000510c:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    8000510e:	ffffc097          	auipc	ra,0xffffc
    80005112:	d3a080e7          	jalr	-710(ra) # 80000e48 <strlen>
    80005116:	0015079b          	addiw	a5,a0,1
    8000511a:	40f90933          	sub	s2,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    8000511e:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    80005122:	13596363          	bltu	s2,s5,80005248 <exec+0x2fa>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80005126:	df043d83          	ld	s11,-528(s0)
    8000512a:	000dba03          	ld	s4,0(s11) # 1000 <_entry-0x7ffff000>
    8000512e:	8552                	mv	a0,s4
    80005130:	ffffc097          	auipc	ra,0xffffc
    80005134:	d18080e7          	jalr	-744(ra) # 80000e48 <strlen>
    80005138:	0015069b          	addiw	a3,a0,1
    8000513c:	8652                	mv	a2,s4
    8000513e:	85ca                	mv	a1,s2
    80005140:	855a                	mv	a0,s6
    80005142:	ffffc097          	auipc	ra,0xffffc
    80005146:	514080e7          	jalr	1300(ra) # 80001656 <copyout>
    8000514a:	10054363          	bltz	a0,80005250 <exec+0x302>
    ustack[argc] = sp;
    8000514e:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80005152:	0485                	addi	s1,s1,1
    80005154:	008d8793          	addi	a5,s11,8
    80005158:	def43823          	sd	a5,-528(s0)
    8000515c:	008db503          	ld	a0,8(s11)
    80005160:	c911                	beqz	a0,80005174 <exec+0x226>
    if(argc >= MAXARG)
    80005162:	09a1                	addi	s3,s3,8
    80005164:	fb3c95e3          	bne	s9,s3,8000510e <exec+0x1c0>
  sz = sz1;
    80005168:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    8000516c:	4a81                	li	s5,0
    8000516e:	a84d                	j	80005220 <exec+0x2d2>
  sp = sz;
    80005170:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80005172:	4481                	li	s1,0
  ustack[argc] = 0;
    80005174:	00349793          	slli	a5,s1,0x3
    80005178:	f9040713          	addi	a4,s0,-112
    8000517c:	97ba                	add	a5,a5,a4
    8000517e:	f007b023          	sd	zero,-256(a5) # ffffffffffffef00 <end+0xffffffff7fbd8f00>
  sp -= (argc+1) * sizeof(uint64);
    80005182:	00148693          	addi	a3,s1,1
    80005186:	068e                	slli	a3,a3,0x3
    80005188:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    8000518c:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80005190:	01597663          	bgeu	s2,s5,8000519c <exec+0x24e>
  sz = sz1;
    80005194:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80005198:	4a81                	li	s5,0
    8000519a:	a059                	j	80005220 <exec+0x2d2>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    8000519c:	e9040613          	addi	a2,s0,-368
    800051a0:	85ca                	mv	a1,s2
    800051a2:	855a                	mv	a0,s6
    800051a4:	ffffc097          	auipc	ra,0xffffc
    800051a8:	4b2080e7          	jalr	1202(ra) # 80001656 <copyout>
    800051ac:	0a054663          	bltz	a0,80005258 <exec+0x30a>
  p->trapframe->a1 = sp;
    800051b0:	058bb783          	ld	a5,88(s7) # 1058 <_entry-0x7fffefa8>
    800051b4:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    800051b8:	de843783          	ld	a5,-536(s0)
    800051bc:	0007c703          	lbu	a4,0(a5)
    800051c0:	cf11                	beqz	a4,800051dc <exec+0x28e>
    800051c2:	0785                	addi	a5,a5,1
    if(*s == '/')
    800051c4:	02f00693          	li	a3,47
    800051c8:	a039                	j	800051d6 <exec+0x288>
      last = s+1;
    800051ca:	def43423          	sd	a5,-536(s0)
  for(last=s=path; *s; s++)
    800051ce:	0785                	addi	a5,a5,1
    800051d0:	fff7c703          	lbu	a4,-1(a5)
    800051d4:	c701                	beqz	a4,800051dc <exec+0x28e>
    if(*s == '/')
    800051d6:	fed71ce3          	bne	a4,a3,800051ce <exec+0x280>
    800051da:	bfc5                	j	800051ca <exec+0x27c>
  safestrcpy(p->name, last, sizeof(p->name));
    800051dc:	4641                	li	a2,16
    800051de:	de843583          	ld	a1,-536(s0)
    800051e2:	158b8513          	addi	a0,s7,344
    800051e6:	ffffc097          	auipc	ra,0xffffc
    800051ea:	c30080e7          	jalr	-976(ra) # 80000e16 <safestrcpy>
  oldpagetable = p->pagetable;
    800051ee:	050bb503          	ld	a0,80(s7)
  p->pagetable = pagetable;
    800051f2:	056bb823          	sd	s6,80(s7)
  p->sz = sz;
    800051f6:	058bb423          	sd	s8,72(s7)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800051fa:	058bb783          	ld	a5,88(s7)
    800051fe:	e6843703          	ld	a4,-408(s0)
    80005202:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80005204:	058bb783          	ld	a5,88(s7)
    80005208:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    8000520c:	85ea                	mv	a1,s10
    8000520e:	ffffd097          	auipc	ra,0xffffd
    80005212:	9e4080e7          	jalr	-1564(ra) # 80001bf2 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80005216:	0004851b          	sext.w	a0,s1
    8000521a:	bbc1                	j	80004fea <exec+0x9c>
    8000521c:	de943c23          	sd	s1,-520(s0)
    proc_freepagetable(pagetable, sz);
    80005220:	df843583          	ld	a1,-520(s0)
    80005224:	855a                	mv	a0,s6
    80005226:	ffffd097          	auipc	ra,0xffffd
    8000522a:	9cc080e7          	jalr	-1588(ra) # 80001bf2 <proc_freepagetable>
  if(ip){
    8000522e:	da0a94e3          	bnez	s5,80004fd6 <exec+0x88>
  return -1;
    80005232:	557d                	li	a0,-1
    80005234:	bb5d                	j	80004fea <exec+0x9c>
    80005236:	de943c23          	sd	s1,-520(s0)
    8000523a:	b7dd                	j	80005220 <exec+0x2d2>
    8000523c:	de943c23          	sd	s1,-520(s0)
    80005240:	b7c5                	j	80005220 <exec+0x2d2>
    80005242:	de943c23          	sd	s1,-520(s0)
    80005246:	bfe9                	j	80005220 <exec+0x2d2>
  sz = sz1;
    80005248:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    8000524c:	4a81                	li	s5,0
    8000524e:	bfc9                	j	80005220 <exec+0x2d2>
  sz = sz1;
    80005250:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80005254:	4a81                	li	s5,0
    80005256:	b7e9                	j	80005220 <exec+0x2d2>
  sz = sz1;
    80005258:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    8000525c:	4a81                	li	s5,0
    8000525e:	b7c9                	j	80005220 <exec+0x2d2>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80005260:	df843483          	ld	s1,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80005264:	e0843783          	ld	a5,-504(s0)
    80005268:	0017869b          	addiw	a3,a5,1
    8000526c:	e0d43423          	sd	a3,-504(s0)
    80005270:	e0043783          	ld	a5,-512(s0)
    80005274:	0387879b          	addiw	a5,a5,56
    80005278:	e8845703          	lhu	a4,-376(s0)
    8000527c:	e2e6d3e3          	bge	a3,a4,800050a2 <exec+0x154>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80005280:	2781                	sext.w	a5,a5
    80005282:	e0f43023          	sd	a5,-512(s0)
    80005286:	03800713          	li	a4,56
    8000528a:	86be                	mv	a3,a5
    8000528c:	e1840613          	addi	a2,s0,-488
    80005290:	4581                	li	a1,0
    80005292:	8556                	mv	a0,s5
    80005294:	fffff097          	auipc	ra,0xfffff
    80005298:	a7e080e7          	jalr	-1410(ra) # 80003d12 <readi>
    8000529c:	03800793          	li	a5,56
    800052a0:	f6f51ee3          	bne	a0,a5,8000521c <exec+0x2ce>
    if(ph.type != ELF_PROG_LOAD)
    800052a4:	e1842783          	lw	a5,-488(s0)
    800052a8:	4705                	li	a4,1
    800052aa:	fae79de3          	bne	a5,a4,80005264 <exec+0x316>
    if(ph.memsz < ph.filesz)
    800052ae:	e4043603          	ld	a2,-448(s0)
    800052b2:	e3843783          	ld	a5,-456(s0)
    800052b6:	f8f660e3          	bltu	a2,a5,80005236 <exec+0x2e8>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    800052ba:	e2843783          	ld	a5,-472(s0)
    800052be:	963e                	add	a2,a2,a5
    800052c0:	f6f66ee3          	bltu	a2,a5,8000523c <exec+0x2ee>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    800052c4:	85a6                	mv	a1,s1
    800052c6:	855a                	mv	a0,s6
    800052c8:	ffffc097          	auipc	ra,0xffffc
    800052cc:	13e080e7          	jalr	318(ra) # 80001406 <uvmalloc>
    800052d0:	dea43c23          	sd	a0,-520(s0)
    800052d4:	d53d                	beqz	a0,80005242 <exec+0x2f4>
    if((ph.vaddr % PGSIZE) != 0)
    800052d6:	e2843c03          	ld	s8,-472(s0)
    800052da:	de043783          	ld	a5,-544(s0)
    800052de:	00fc77b3          	and	a5,s8,a5
    800052e2:	ff9d                	bnez	a5,80005220 <exec+0x2d2>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800052e4:	e2042c83          	lw	s9,-480(s0)
    800052e8:	e3842b83          	lw	s7,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    800052ec:	f60b8ae3          	beqz	s7,80005260 <exec+0x312>
    800052f0:	89de                	mv	s3,s7
    800052f2:	4481                	li	s1,0
    800052f4:	b371                	j	80005080 <exec+0x132>

00000000800052f6 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    800052f6:	7179                	addi	sp,sp,-48
    800052f8:	f406                	sd	ra,40(sp)
    800052fa:	f022                	sd	s0,32(sp)
    800052fc:	ec26                	sd	s1,24(sp)
    800052fe:	e84a                	sd	s2,16(sp)
    80005300:	1800                	addi	s0,sp,48
    80005302:	892e                	mv	s2,a1
    80005304:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80005306:	fdc40593          	addi	a1,s0,-36
    8000530a:	ffffe097          	auipc	ra,0xffffe
    8000530e:	b4e080e7          	jalr	-1202(ra) # 80002e58 <argint>
    80005312:	04054063          	bltz	a0,80005352 <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80005316:	fdc42703          	lw	a4,-36(s0)
    8000531a:	47bd                	li	a5,15
    8000531c:	02e7ed63          	bltu	a5,a4,80005356 <argfd+0x60>
    80005320:	ffffc097          	auipc	ra,0xffffc
    80005324:	772080e7          	jalr	1906(ra) # 80001a92 <myproc>
    80005328:	fdc42703          	lw	a4,-36(s0)
    8000532c:	01a70793          	addi	a5,a4,26
    80005330:	078e                	slli	a5,a5,0x3
    80005332:	953e                	add	a0,a0,a5
    80005334:	611c                	ld	a5,0(a0)
    80005336:	c395                	beqz	a5,8000535a <argfd+0x64>
    return -1;
  if(pfd)
    80005338:	00090463          	beqz	s2,80005340 <argfd+0x4a>
    *pfd = fd;
    8000533c:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80005340:	4501                	li	a0,0
  if(pf)
    80005342:	c091                	beqz	s1,80005346 <argfd+0x50>
    *pf = f;
    80005344:	e09c                	sd	a5,0(s1)
}
    80005346:	70a2                	ld	ra,40(sp)
    80005348:	7402                	ld	s0,32(sp)
    8000534a:	64e2                	ld	s1,24(sp)
    8000534c:	6942                	ld	s2,16(sp)
    8000534e:	6145                	addi	sp,sp,48
    80005350:	8082                	ret
    return -1;
    80005352:	557d                	li	a0,-1
    80005354:	bfcd                	j	80005346 <argfd+0x50>
    return -1;
    80005356:	557d                	li	a0,-1
    80005358:	b7fd                	j	80005346 <argfd+0x50>
    8000535a:	557d                	li	a0,-1
    8000535c:	b7ed                	j	80005346 <argfd+0x50>

000000008000535e <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    8000535e:	1101                	addi	sp,sp,-32
    80005360:	ec06                	sd	ra,24(sp)
    80005362:	e822                	sd	s0,16(sp)
    80005364:	e426                	sd	s1,8(sp)
    80005366:	1000                	addi	s0,sp,32
    80005368:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    8000536a:	ffffc097          	auipc	ra,0xffffc
    8000536e:	728080e7          	jalr	1832(ra) # 80001a92 <myproc>
    80005372:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80005374:	0d050793          	addi	a5,a0,208
    80005378:	4501                	li	a0,0
    8000537a:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    8000537c:	6398                	ld	a4,0(a5)
    8000537e:	cb19                	beqz	a4,80005394 <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80005380:	2505                	addiw	a0,a0,1
    80005382:	07a1                	addi	a5,a5,8
    80005384:	fed51ce3          	bne	a0,a3,8000537c <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80005388:	557d                	li	a0,-1
}
    8000538a:	60e2                	ld	ra,24(sp)
    8000538c:	6442                	ld	s0,16(sp)
    8000538e:	64a2                	ld	s1,8(sp)
    80005390:	6105                	addi	sp,sp,32
    80005392:	8082                	ret
      p->ofile[fd] = f;
    80005394:	01a50793          	addi	a5,a0,26
    80005398:	078e                	slli	a5,a5,0x3
    8000539a:	963e                	add	a2,a2,a5
    8000539c:	e204                	sd	s1,0(a2)
      return fd;
    8000539e:	b7f5                	j	8000538a <fdalloc+0x2c>

00000000800053a0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800053a0:	715d                	addi	sp,sp,-80
    800053a2:	e486                	sd	ra,72(sp)
    800053a4:	e0a2                	sd	s0,64(sp)
    800053a6:	fc26                	sd	s1,56(sp)
    800053a8:	f84a                	sd	s2,48(sp)
    800053aa:	f44e                	sd	s3,40(sp)
    800053ac:	f052                	sd	s4,32(sp)
    800053ae:	ec56                	sd	s5,24(sp)
    800053b0:	0880                	addi	s0,sp,80
    800053b2:	89ae                	mv	s3,a1
    800053b4:	8ab2                	mv	s5,a2
    800053b6:	8a36                	mv	s4,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800053b8:	fb040593          	addi	a1,s0,-80
    800053bc:	fffff097          	auipc	ra,0xfffff
    800053c0:	e76080e7          	jalr	-394(ra) # 80004232 <nameiparent>
    800053c4:	892a                	mv	s2,a0
    800053c6:	12050e63          	beqz	a0,80005502 <create+0x162>
    return 0;

  ilock(dp);
    800053ca:	ffffe097          	auipc	ra,0xffffe
    800053ce:	694080e7          	jalr	1684(ra) # 80003a5e <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    800053d2:	4601                	li	a2,0
    800053d4:	fb040593          	addi	a1,s0,-80
    800053d8:	854a                	mv	a0,s2
    800053da:	fffff097          	auipc	ra,0xfffff
    800053de:	b68080e7          	jalr	-1176(ra) # 80003f42 <dirlookup>
    800053e2:	84aa                	mv	s1,a0
    800053e4:	c921                	beqz	a0,80005434 <create+0x94>
    iunlockput(dp);
    800053e6:	854a                	mv	a0,s2
    800053e8:	fffff097          	auipc	ra,0xfffff
    800053ec:	8d8080e7          	jalr	-1832(ra) # 80003cc0 <iunlockput>
    ilock(ip);
    800053f0:	8526                	mv	a0,s1
    800053f2:	ffffe097          	auipc	ra,0xffffe
    800053f6:	66c080e7          	jalr	1644(ra) # 80003a5e <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    800053fa:	2981                	sext.w	s3,s3
    800053fc:	4789                	li	a5,2
    800053fe:	02f99463          	bne	s3,a5,80005426 <create+0x86>
    80005402:	0444d783          	lhu	a5,68(s1)
    80005406:	37f9                	addiw	a5,a5,-2
    80005408:	17c2                	slli	a5,a5,0x30
    8000540a:	93c1                	srli	a5,a5,0x30
    8000540c:	4705                	li	a4,1
    8000540e:	00f76c63          	bltu	a4,a5,80005426 <create+0x86>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    80005412:	8526                	mv	a0,s1
    80005414:	60a6                	ld	ra,72(sp)
    80005416:	6406                	ld	s0,64(sp)
    80005418:	74e2                	ld	s1,56(sp)
    8000541a:	7942                	ld	s2,48(sp)
    8000541c:	79a2                	ld	s3,40(sp)
    8000541e:	7a02                	ld	s4,32(sp)
    80005420:	6ae2                	ld	s5,24(sp)
    80005422:	6161                	addi	sp,sp,80
    80005424:	8082                	ret
    iunlockput(ip);
    80005426:	8526                	mv	a0,s1
    80005428:	fffff097          	auipc	ra,0xfffff
    8000542c:	898080e7          	jalr	-1896(ra) # 80003cc0 <iunlockput>
    return 0;
    80005430:	4481                	li	s1,0
    80005432:	b7c5                	j	80005412 <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0)
    80005434:	85ce                	mv	a1,s3
    80005436:	00092503          	lw	a0,0(s2)
    8000543a:	ffffe097          	auipc	ra,0xffffe
    8000543e:	48c080e7          	jalr	1164(ra) # 800038c6 <ialloc>
    80005442:	84aa                	mv	s1,a0
    80005444:	c521                	beqz	a0,8000548c <create+0xec>
  ilock(ip);
    80005446:	ffffe097          	auipc	ra,0xffffe
    8000544a:	618080e7          	jalr	1560(ra) # 80003a5e <ilock>
  ip->major = major;
    8000544e:	05549323          	sh	s5,70(s1)
  ip->minor = minor;
    80005452:	05449423          	sh	s4,72(s1)
  ip->nlink = 1;
    80005456:	4a05                	li	s4,1
    80005458:	05449523          	sh	s4,74(s1)
  iupdate(ip);
    8000545c:	8526                	mv	a0,s1
    8000545e:	ffffe097          	auipc	ra,0xffffe
    80005462:	536080e7          	jalr	1334(ra) # 80003994 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80005466:	2981                	sext.w	s3,s3
    80005468:	03498a63          	beq	s3,s4,8000549c <create+0xfc>
  if(dirlink(dp, name, ip->inum) < 0)
    8000546c:	40d0                	lw	a2,4(s1)
    8000546e:	fb040593          	addi	a1,s0,-80
    80005472:	854a                	mv	a0,s2
    80005474:	fffff097          	auipc	ra,0xfffff
    80005478:	cde080e7          	jalr	-802(ra) # 80004152 <dirlink>
    8000547c:	06054b63          	bltz	a0,800054f2 <create+0x152>
  iunlockput(dp);
    80005480:	854a                	mv	a0,s2
    80005482:	fffff097          	auipc	ra,0xfffff
    80005486:	83e080e7          	jalr	-1986(ra) # 80003cc0 <iunlockput>
  return ip;
    8000548a:	b761                	j	80005412 <create+0x72>
    panic("create: ialloc");
    8000548c:	00003517          	auipc	a0,0x3
    80005490:	2e450513          	addi	a0,a0,740 # 80008770 <syscalls+0x2b0>
    80005494:	ffffb097          	auipc	ra,0xffffb
    80005498:	0a4080e7          	jalr	164(ra) # 80000538 <panic>
    dp->nlink++;  // for ".."
    8000549c:	04a95783          	lhu	a5,74(s2)
    800054a0:	2785                	addiw	a5,a5,1
    800054a2:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    800054a6:	854a                	mv	a0,s2
    800054a8:	ffffe097          	auipc	ra,0xffffe
    800054ac:	4ec080e7          	jalr	1260(ra) # 80003994 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    800054b0:	40d0                	lw	a2,4(s1)
    800054b2:	00003597          	auipc	a1,0x3
    800054b6:	2ce58593          	addi	a1,a1,718 # 80008780 <syscalls+0x2c0>
    800054ba:	8526                	mv	a0,s1
    800054bc:	fffff097          	auipc	ra,0xfffff
    800054c0:	c96080e7          	jalr	-874(ra) # 80004152 <dirlink>
    800054c4:	00054f63          	bltz	a0,800054e2 <create+0x142>
    800054c8:	00492603          	lw	a2,4(s2)
    800054cc:	00003597          	auipc	a1,0x3
    800054d0:	2bc58593          	addi	a1,a1,700 # 80008788 <syscalls+0x2c8>
    800054d4:	8526                	mv	a0,s1
    800054d6:	fffff097          	auipc	ra,0xfffff
    800054da:	c7c080e7          	jalr	-900(ra) # 80004152 <dirlink>
    800054de:	f80557e3          	bgez	a0,8000546c <create+0xcc>
      panic("create dots");
    800054e2:	00003517          	auipc	a0,0x3
    800054e6:	2ae50513          	addi	a0,a0,686 # 80008790 <syscalls+0x2d0>
    800054ea:	ffffb097          	auipc	ra,0xffffb
    800054ee:	04e080e7          	jalr	78(ra) # 80000538 <panic>
    panic("create: dirlink");
    800054f2:	00003517          	auipc	a0,0x3
    800054f6:	2ae50513          	addi	a0,a0,686 # 800087a0 <syscalls+0x2e0>
    800054fa:	ffffb097          	auipc	ra,0xffffb
    800054fe:	03e080e7          	jalr	62(ra) # 80000538 <panic>
    return 0;
    80005502:	84aa                	mv	s1,a0
    80005504:	b739                	j	80005412 <create+0x72>

0000000080005506 <sys_dup>:
{
    80005506:	7179                	addi	sp,sp,-48
    80005508:	f406                	sd	ra,40(sp)
    8000550a:	f022                	sd	s0,32(sp)
    8000550c:	ec26                	sd	s1,24(sp)
    8000550e:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80005510:	fd840613          	addi	a2,s0,-40
    80005514:	4581                	li	a1,0
    80005516:	4501                	li	a0,0
    80005518:	00000097          	auipc	ra,0x0
    8000551c:	dde080e7          	jalr	-546(ra) # 800052f6 <argfd>
    return -1;
    80005520:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80005522:	02054363          	bltz	a0,80005548 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    80005526:	fd843503          	ld	a0,-40(s0)
    8000552a:	00000097          	auipc	ra,0x0
    8000552e:	e34080e7          	jalr	-460(ra) # 8000535e <fdalloc>
    80005532:	84aa                	mv	s1,a0
    return -1;
    80005534:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80005536:	00054963          	bltz	a0,80005548 <sys_dup+0x42>
  filedup(f);
    8000553a:	fd843503          	ld	a0,-40(s0)
    8000553e:	fffff097          	auipc	ra,0xfffff
    80005542:	36c080e7          	jalr	876(ra) # 800048aa <filedup>
  return fd;
    80005546:	87a6                	mv	a5,s1
}
    80005548:	853e                	mv	a0,a5
    8000554a:	70a2                	ld	ra,40(sp)
    8000554c:	7402                	ld	s0,32(sp)
    8000554e:	64e2                	ld	s1,24(sp)
    80005550:	6145                	addi	sp,sp,48
    80005552:	8082                	ret

0000000080005554 <sys_read>:
{
    80005554:	7179                	addi	sp,sp,-48
    80005556:	f406                	sd	ra,40(sp)
    80005558:	f022                	sd	s0,32(sp)
    8000555a:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000555c:	fe840613          	addi	a2,s0,-24
    80005560:	4581                	li	a1,0
    80005562:	4501                	li	a0,0
    80005564:	00000097          	auipc	ra,0x0
    80005568:	d92080e7          	jalr	-622(ra) # 800052f6 <argfd>
    return -1;
    8000556c:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000556e:	04054163          	bltz	a0,800055b0 <sys_read+0x5c>
    80005572:	fe440593          	addi	a1,s0,-28
    80005576:	4509                	li	a0,2
    80005578:	ffffe097          	auipc	ra,0xffffe
    8000557c:	8e0080e7          	jalr	-1824(ra) # 80002e58 <argint>
    return -1;
    80005580:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005582:	02054763          	bltz	a0,800055b0 <sys_read+0x5c>
    80005586:	fd840593          	addi	a1,s0,-40
    8000558a:	4505                	li	a0,1
    8000558c:	ffffe097          	auipc	ra,0xffffe
    80005590:	8ee080e7          	jalr	-1810(ra) # 80002e7a <argaddr>
    return -1;
    80005594:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005596:	00054d63          	bltz	a0,800055b0 <sys_read+0x5c>
  return fileread(f, p, n);
    8000559a:	fe442603          	lw	a2,-28(s0)
    8000559e:	fd843583          	ld	a1,-40(s0)
    800055a2:	fe843503          	ld	a0,-24(s0)
    800055a6:	fffff097          	auipc	ra,0xfffff
    800055aa:	490080e7          	jalr	1168(ra) # 80004a36 <fileread>
    800055ae:	87aa                	mv	a5,a0
}
    800055b0:	853e                	mv	a0,a5
    800055b2:	70a2                	ld	ra,40(sp)
    800055b4:	7402                	ld	s0,32(sp)
    800055b6:	6145                	addi	sp,sp,48
    800055b8:	8082                	ret

00000000800055ba <sys_write>:
{
    800055ba:	7179                	addi	sp,sp,-48
    800055bc:	f406                	sd	ra,40(sp)
    800055be:	f022                	sd	s0,32(sp)
    800055c0:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800055c2:	fe840613          	addi	a2,s0,-24
    800055c6:	4581                	li	a1,0
    800055c8:	4501                	li	a0,0
    800055ca:	00000097          	auipc	ra,0x0
    800055ce:	d2c080e7          	jalr	-724(ra) # 800052f6 <argfd>
    return -1;
    800055d2:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800055d4:	04054163          	bltz	a0,80005616 <sys_write+0x5c>
    800055d8:	fe440593          	addi	a1,s0,-28
    800055dc:	4509                	li	a0,2
    800055de:	ffffe097          	auipc	ra,0xffffe
    800055e2:	87a080e7          	jalr	-1926(ra) # 80002e58 <argint>
    return -1;
    800055e6:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800055e8:	02054763          	bltz	a0,80005616 <sys_write+0x5c>
    800055ec:	fd840593          	addi	a1,s0,-40
    800055f0:	4505                	li	a0,1
    800055f2:	ffffe097          	auipc	ra,0xffffe
    800055f6:	888080e7          	jalr	-1912(ra) # 80002e7a <argaddr>
    return -1;
    800055fa:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800055fc:	00054d63          	bltz	a0,80005616 <sys_write+0x5c>
  return filewrite(f, p, n);
    80005600:	fe442603          	lw	a2,-28(s0)
    80005604:	fd843583          	ld	a1,-40(s0)
    80005608:	fe843503          	ld	a0,-24(s0)
    8000560c:	fffff097          	auipc	ra,0xfffff
    80005610:	4ec080e7          	jalr	1260(ra) # 80004af8 <filewrite>
    80005614:	87aa                	mv	a5,a0
}
    80005616:	853e                	mv	a0,a5
    80005618:	70a2                	ld	ra,40(sp)
    8000561a:	7402                	ld	s0,32(sp)
    8000561c:	6145                	addi	sp,sp,48
    8000561e:	8082                	ret

0000000080005620 <sys_close>:
{
    80005620:	1101                	addi	sp,sp,-32
    80005622:	ec06                	sd	ra,24(sp)
    80005624:	e822                	sd	s0,16(sp)
    80005626:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80005628:	fe040613          	addi	a2,s0,-32
    8000562c:	fec40593          	addi	a1,s0,-20
    80005630:	4501                	li	a0,0
    80005632:	00000097          	auipc	ra,0x0
    80005636:	cc4080e7          	jalr	-828(ra) # 800052f6 <argfd>
    return -1;
    8000563a:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    8000563c:	02054463          	bltz	a0,80005664 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80005640:	ffffc097          	auipc	ra,0xffffc
    80005644:	452080e7          	jalr	1106(ra) # 80001a92 <myproc>
    80005648:	fec42783          	lw	a5,-20(s0)
    8000564c:	07e9                	addi	a5,a5,26
    8000564e:	078e                	slli	a5,a5,0x3
    80005650:	97aa                	add	a5,a5,a0
    80005652:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    80005656:	fe043503          	ld	a0,-32(s0)
    8000565a:	fffff097          	auipc	ra,0xfffff
    8000565e:	2a2080e7          	jalr	674(ra) # 800048fc <fileclose>
  return 0;
    80005662:	4781                	li	a5,0
}
    80005664:	853e                	mv	a0,a5
    80005666:	60e2                	ld	ra,24(sp)
    80005668:	6442                	ld	s0,16(sp)
    8000566a:	6105                	addi	sp,sp,32
    8000566c:	8082                	ret

000000008000566e <sys_fstat>:
{
    8000566e:	1101                	addi	sp,sp,-32
    80005670:	ec06                	sd	ra,24(sp)
    80005672:	e822                	sd	s0,16(sp)
    80005674:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80005676:	fe840613          	addi	a2,s0,-24
    8000567a:	4581                	li	a1,0
    8000567c:	4501                	li	a0,0
    8000567e:	00000097          	auipc	ra,0x0
    80005682:	c78080e7          	jalr	-904(ra) # 800052f6 <argfd>
    return -1;
    80005686:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80005688:	02054563          	bltz	a0,800056b2 <sys_fstat+0x44>
    8000568c:	fe040593          	addi	a1,s0,-32
    80005690:	4505                	li	a0,1
    80005692:	ffffd097          	auipc	ra,0xffffd
    80005696:	7e8080e7          	jalr	2024(ra) # 80002e7a <argaddr>
    return -1;
    8000569a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    8000569c:	00054b63          	bltz	a0,800056b2 <sys_fstat+0x44>
  return filestat(f, st);
    800056a0:	fe043583          	ld	a1,-32(s0)
    800056a4:	fe843503          	ld	a0,-24(s0)
    800056a8:	fffff097          	auipc	ra,0xfffff
    800056ac:	31c080e7          	jalr	796(ra) # 800049c4 <filestat>
    800056b0:	87aa                	mv	a5,a0
}
    800056b2:	853e                	mv	a0,a5
    800056b4:	60e2                	ld	ra,24(sp)
    800056b6:	6442                	ld	s0,16(sp)
    800056b8:	6105                	addi	sp,sp,32
    800056ba:	8082                	ret

00000000800056bc <sys_link>:
{
    800056bc:	7169                	addi	sp,sp,-304
    800056be:	f606                	sd	ra,296(sp)
    800056c0:	f222                	sd	s0,288(sp)
    800056c2:	ee26                	sd	s1,280(sp)
    800056c4:	ea4a                	sd	s2,272(sp)
    800056c6:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800056c8:	08000613          	li	a2,128
    800056cc:	ed040593          	addi	a1,s0,-304
    800056d0:	4501                	li	a0,0
    800056d2:	ffffd097          	auipc	ra,0xffffd
    800056d6:	7ca080e7          	jalr	1994(ra) # 80002e9c <argstr>
    return -1;
    800056da:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800056dc:	10054e63          	bltz	a0,800057f8 <sys_link+0x13c>
    800056e0:	08000613          	li	a2,128
    800056e4:	f5040593          	addi	a1,s0,-176
    800056e8:	4505                	li	a0,1
    800056ea:	ffffd097          	auipc	ra,0xffffd
    800056ee:	7b2080e7          	jalr	1970(ra) # 80002e9c <argstr>
    return -1;
    800056f2:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800056f4:	10054263          	bltz	a0,800057f8 <sys_link+0x13c>
  begin_op();
    800056f8:	fffff097          	auipc	ra,0xfffff
    800056fc:	d38080e7          	jalr	-712(ra) # 80004430 <begin_op>
  if((ip = namei(old)) == 0){
    80005700:	ed040513          	addi	a0,s0,-304
    80005704:	fffff097          	auipc	ra,0xfffff
    80005708:	b10080e7          	jalr	-1264(ra) # 80004214 <namei>
    8000570c:	84aa                	mv	s1,a0
    8000570e:	c551                	beqz	a0,8000579a <sys_link+0xde>
  ilock(ip);
    80005710:	ffffe097          	auipc	ra,0xffffe
    80005714:	34e080e7          	jalr	846(ra) # 80003a5e <ilock>
  if(ip->type == T_DIR){
    80005718:	04449703          	lh	a4,68(s1)
    8000571c:	4785                	li	a5,1
    8000571e:	08f70463          	beq	a4,a5,800057a6 <sys_link+0xea>
  ip->nlink++;
    80005722:	04a4d783          	lhu	a5,74(s1)
    80005726:	2785                	addiw	a5,a5,1
    80005728:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    8000572c:	8526                	mv	a0,s1
    8000572e:	ffffe097          	auipc	ra,0xffffe
    80005732:	266080e7          	jalr	614(ra) # 80003994 <iupdate>
  iunlock(ip);
    80005736:	8526                	mv	a0,s1
    80005738:	ffffe097          	auipc	ra,0xffffe
    8000573c:	3e8080e7          	jalr	1000(ra) # 80003b20 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80005740:	fd040593          	addi	a1,s0,-48
    80005744:	f5040513          	addi	a0,s0,-176
    80005748:	fffff097          	auipc	ra,0xfffff
    8000574c:	aea080e7          	jalr	-1302(ra) # 80004232 <nameiparent>
    80005750:	892a                	mv	s2,a0
    80005752:	c935                	beqz	a0,800057c6 <sys_link+0x10a>
  ilock(dp);
    80005754:	ffffe097          	auipc	ra,0xffffe
    80005758:	30a080e7          	jalr	778(ra) # 80003a5e <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    8000575c:	00092703          	lw	a4,0(s2)
    80005760:	409c                	lw	a5,0(s1)
    80005762:	04f71d63          	bne	a4,a5,800057bc <sys_link+0x100>
    80005766:	40d0                	lw	a2,4(s1)
    80005768:	fd040593          	addi	a1,s0,-48
    8000576c:	854a                	mv	a0,s2
    8000576e:	fffff097          	auipc	ra,0xfffff
    80005772:	9e4080e7          	jalr	-1564(ra) # 80004152 <dirlink>
    80005776:	04054363          	bltz	a0,800057bc <sys_link+0x100>
  iunlockput(dp);
    8000577a:	854a                	mv	a0,s2
    8000577c:	ffffe097          	auipc	ra,0xffffe
    80005780:	544080e7          	jalr	1348(ra) # 80003cc0 <iunlockput>
  iput(ip);
    80005784:	8526                	mv	a0,s1
    80005786:	ffffe097          	auipc	ra,0xffffe
    8000578a:	492080e7          	jalr	1170(ra) # 80003c18 <iput>
  end_op();
    8000578e:	fffff097          	auipc	ra,0xfffff
    80005792:	d22080e7          	jalr	-734(ra) # 800044b0 <end_op>
  return 0;
    80005796:	4781                	li	a5,0
    80005798:	a085                	j	800057f8 <sys_link+0x13c>
    end_op();
    8000579a:	fffff097          	auipc	ra,0xfffff
    8000579e:	d16080e7          	jalr	-746(ra) # 800044b0 <end_op>
    return -1;
    800057a2:	57fd                	li	a5,-1
    800057a4:	a891                	j	800057f8 <sys_link+0x13c>
    iunlockput(ip);
    800057a6:	8526                	mv	a0,s1
    800057a8:	ffffe097          	auipc	ra,0xffffe
    800057ac:	518080e7          	jalr	1304(ra) # 80003cc0 <iunlockput>
    end_op();
    800057b0:	fffff097          	auipc	ra,0xfffff
    800057b4:	d00080e7          	jalr	-768(ra) # 800044b0 <end_op>
    return -1;
    800057b8:	57fd                	li	a5,-1
    800057ba:	a83d                	j	800057f8 <sys_link+0x13c>
    iunlockput(dp);
    800057bc:	854a                	mv	a0,s2
    800057be:	ffffe097          	auipc	ra,0xffffe
    800057c2:	502080e7          	jalr	1282(ra) # 80003cc0 <iunlockput>
  ilock(ip);
    800057c6:	8526                	mv	a0,s1
    800057c8:	ffffe097          	auipc	ra,0xffffe
    800057cc:	296080e7          	jalr	662(ra) # 80003a5e <ilock>
  ip->nlink--;
    800057d0:	04a4d783          	lhu	a5,74(s1)
    800057d4:	37fd                	addiw	a5,a5,-1
    800057d6:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800057da:	8526                	mv	a0,s1
    800057dc:	ffffe097          	auipc	ra,0xffffe
    800057e0:	1b8080e7          	jalr	440(ra) # 80003994 <iupdate>
  iunlockput(ip);
    800057e4:	8526                	mv	a0,s1
    800057e6:	ffffe097          	auipc	ra,0xffffe
    800057ea:	4da080e7          	jalr	1242(ra) # 80003cc0 <iunlockput>
  end_op();
    800057ee:	fffff097          	auipc	ra,0xfffff
    800057f2:	cc2080e7          	jalr	-830(ra) # 800044b0 <end_op>
  return -1;
    800057f6:	57fd                	li	a5,-1
}
    800057f8:	853e                	mv	a0,a5
    800057fa:	70b2                	ld	ra,296(sp)
    800057fc:	7412                	ld	s0,288(sp)
    800057fe:	64f2                	ld	s1,280(sp)
    80005800:	6952                	ld	s2,272(sp)
    80005802:	6155                	addi	sp,sp,304
    80005804:	8082                	ret

0000000080005806 <sys_unlink>:
{
    80005806:	7151                	addi	sp,sp,-240
    80005808:	f586                	sd	ra,232(sp)
    8000580a:	f1a2                	sd	s0,224(sp)
    8000580c:	eda6                	sd	s1,216(sp)
    8000580e:	e9ca                	sd	s2,208(sp)
    80005810:	e5ce                	sd	s3,200(sp)
    80005812:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80005814:	08000613          	li	a2,128
    80005818:	f3040593          	addi	a1,s0,-208
    8000581c:	4501                	li	a0,0
    8000581e:	ffffd097          	auipc	ra,0xffffd
    80005822:	67e080e7          	jalr	1662(ra) # 80002e9c <argstr>
    80005826:	18054163          	bltz	a0,800059a8 <sys_unlink+0x1a2>
  begin_op();
    8000582a:	fffff097          	auipc	ra,0xfffff
    8000582e:	c06080e7          	jalr	-1018(ra) # 80004430 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80005832:	fb040593          	addi	a1,s0,-80
    80005836:	f3040513          	addi	a0,s0,-208
    8000583a:	fffff097          	auipc	ra,0xfffff
    8000583e:	9f8080e7          	jalr	-1544(ra) # 80004232 <nameiparent>
    80005842:	84aa                	mv	s1,a0
    80005844:	c979                	beqz	a0,8000591a <sys_unlink+0x114>
  ilock(dp);
    80005846:	ffffe097          	auipc	ra,0xffffe
    8000584a:	218080e7          	jalr	536(ra) # 80003a5e <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    8000584e:	00003597          	auipc	a1,0x3
    80005852:	f3258593          	addi	a1,a1,-206 # 80008780 <syscalls+0x2c0>
    80005856:	fb040513          	addi	a0,s0,-80
    8000585a:	ffffe097          	auipc	ra,0xffffe
    8000585e:	6ce080e7          	jalr	1742(ra) # 80003f28 <namecmp>
    80005862:	14050a63          	beqz	a0,800059b6 <sys_unlink+0x1b0>
    80005866:	00003597          	auipc	a1,0x3
    8000586a:	f2258593          	addi	a1,a1,-222 # 80008788 <syscalls+0x2c8>
    8000586e:	fb040513          	addi	a0,s0,-80
    80005872:	ffffe097          	auipc	ra,0xffffe
    80005876:	6b6080e7          	jalr	1718(ra) # 80003f28 <namecmp>
    8000587a:	12050e63          	beqz	a0,800059b6 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    8000587e:	f2c40613          	addi	a2,s0,-212
    80005882:	fb040593          	addi	a1,s0,-80
    80005886:	8526                	mv	a0,s1
    80005888:	ffffe097          	auipc	ra,0xffffe
    8000588c:	6ba080e7          	jalr	1722(ra) # 80003f42 <dirlookup>
    80005890:	892a                	mv	s2,a0
    80005892:	12050263          	beqz	a0,800059b6 <sys_unlink+0x1b0>
  ilock(ip);
    80005896:	ffffe097          	auipc	ra,0xffffe
    8000589a:	1c8080e7          	jalr	456(ra) # 80003a5e <ilock>
  if(ip->nlink < 1)
    8000589e:	04a91783          	lh	a5,74(s2)
    800058a2:	08f05263          	blez	a5,80005926 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    800058a6:	04491703          	lh	a4,68(s2)
    800058aa:	4785                	li	a5,1
    800058ac:	08f70563          	beq	a4,a5,80005936 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    800058b0:	4641                	li	a2,16
    800058b2:	4581                	li	a1,0
    800058b4:	fc040513          	addi	a0,s0,-64
    800058b8:	ffffb097          	auipc	ra,0xffffb
    800058bc:	414080e7          	jalr	1044(ra) # 80000ccc <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800058c0:	4741                	li	a4,16
    800058c2:	f2c42683          	lw	a3,-212(s0)
    800058c6:	fc040613          	addi	a2,s0,-64
    800058ca:	4581                	li	a1,0
    800058cc:	8526                	mv	a0,s1
    800058ce:	ffffe097          	auipc	ra,0xffffe
    800058d2:	53c080e7          	jalr	1340(ra) # 80003e0a <writei>
    800058d6:	47c1                	li	a5,16
    800058d8:	0af51563          	bne	a0,a5,80005982 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    800058dc:	04491703          	lh	a4,68(s2)
    800058e0:	4785                	li	a5,1
    800058e2:	0af70863          	beq	a4,a5,80005992 <sys_unlink+0x18c>
  iunlockput(dp);
    800058e6:	8526                	mv	a0,s1
    800058e8:	ffffe097          	auipc	ra,0xffffe
    800058ec:	3d8080e7          	jalr	984(ra) # 80003cc0 <iunlockput>
  ip->nlink--;
    800058f0:	04a95783          	lhu	a5,74(s2)
    800058f4:	37fd                	addiw	a5,a5,-1
    800058f6:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    800058fa:	854a                	mv	a0,s2
    800058fc:	ffffe097          	auipc	ra,0xffffe
    80005900:	098080e7          	jalr	152(ra) # 80003994 <iupdate>
  iunlockput(ip);
    80005904:	854a                	mv	a0,s2
    80005906:	ffffe097          	auipc	ra,0xffffe
    8000590a:	3ba080e7          	jalr	954(ra) # 80003cc0 <iunlockput>
  end_op();
    8000590e:	fffff097          	auipc	ra,0xfffff
    80005912:	ba2080e7          	jalr	-1118(ra) # 800044b0 <end_op>
  return 0;
    80005916:	4501                	li	a0,0
    80005918:	a84d                	j	800059ca <sys_unlink+0x1c4>
    end_op();
    8000591a:	fffff097          	auipc	ra,0xfffff
    8000591e:	b96080e7          	jalr	-1130(ra) # 800044b0 <end_op>
    return -1;
    80005922:	557d                	li	a0,-1
    80005924:	a05d                	j	800059ca <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80005926:	00003517          	auipc	a0,0x3
    8000592a:	e8a50513          	addi	a0,a0,-374 # 800087b0 <syscalls+0x2f0>
    8000592e:	ffffb097          	auipc	ra,0xffffb
    80005932:	c0a080e7          	jalr	-1014(ra) # 80000538 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005936:	04c92703          	lw	a4,76(s2)
    8000593a:	02000793          	li	a5,32
    8000593e:	f6e7f9e3          	bgeu	a5,a4,800058b0 <sys_unlink+0xaa>
    80005942:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005946:	4741                	li	a4,16
    80005948:	86ce                	mv	a3,s3
    8000594a:	f1840613          	addi	a2,s0,-232
    8000594e:	4581                	li	a1,0
    80005950:	854a                	mv	a0,s2
    80005952:	ffffe097          	auipc	ra,0xffffe
    80005956:	3c0080e7          	jalr	960(ra) # 80003d12 <readi>
    8000595a:	47c1                	li	a5,16
    8000595c:	00f51b63          	bne	a0,a5,80005972 <sys_unlink+0x16c>
    if(de.inum != 0)
    80005960:	f1845783          	lhu	a5,-232(s0)
    80005964:	e7a1                	bnez	a5,800059ac <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005966:	29c1                	addiw	s3,s3,16
    80005968:	04c92783          	lw	a5,76(s2)
    8000596c:	fcf9ede3          	bltu	s3,a5,80005946 <sys_unlink+0x140>
    80005970:	b781                	j	800058b0 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80005972:	00003517          	auipc	a0,0x3
    80005976:	e5650513          	addi	a0,a0,-426 # 800087c8 <syscalls+0x308>
    8000597a:	ffffb097          	auipc	ra,0xffffb
    8000597e:	bbe080e7          	jalr	-1090(ra) # 80000538 <panic>
    panic("unlink: writei");
    80005982:	00003517          	auipc	a0,0x3
    80005986:	e5e50513          	addi	a0,a0,-418 # 800087e0 <syscalls+0x320>
    8000598a:	ffffb097          	auipc	ra,0xffffb
    8000598e:	bae080e7          	jalr	-1106(ra) # 80000538 <panic>
    dp->nlink--;
    80005992:	04a4d783          	lhu	a5,74(s1)
    80005996:	37fd                	addiw	a5,a5,-1
    80005998:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    8000599c:	8526                	mv	a0,s1
    8000599e:	ffffe097          	auipc	ra,0xffffe
    800059a2:	ff6080e7          	jalr	-10(ra) # 80003994 <iupdate>
    800059a6:	b781                	j	800058e6 <sys_unlink+0xe0>
    return -1;
    800059a8:	557d                	li	a0,-1
    800059aa:	a005                	j	800059ca <sys_unlink+0x1c4>
    iunlockput(ip);
    800059ac:	854a                	mv	a0,s2
    800059ae:	ffffe097          	auipc	ra,0xffffe
    800059b2:	312080e7          	jalr	786(ra) # 80003cc0 <iunlockput>
  iunlockput(dp);
    800059b6:	8526                	mv	a0,s1
    800059b8:	ffffe097          	auipc	ra,0xffffe
    800059bc:	308080e7          	jalr	776(ra) # 80003cc0 <iunlockput>
  end_op();
    800059c0:	fffff097          	auipc	ra,0xfffff
    800059c4:	af0080e7          	jalr	-1296(ra) # 800044b0 <end_op>
  return -1;
    800059c8:	557d                	li	a0,-1
}
    800059ca:	70ae                	ld	ra,232(sp)
    800059cc:	740e                	ld	s0,224(sp)
    800059ce:	64ee                	ld	s1,216(sp)
    800059d0:	694e                	ld	s2,208(sp)
    800059d2:	69ae                	ld	s3,200(sp)
    800059d4:	616d                	addi	sp,sp,240
    800059d6:	8082                	ret

00000000800059d8 <sys_open>:

uint64
sys_open(void)
{
    800059d8:	7131                	addi	sp,sp,-192
    800059da:	fd06                	sd	ra,184(sp)
    800059dc:	f922                	sd	s0,176(sp)
    800059de:	f526                	sd	s1,168(sp)
    800059e0:	f14a                	sd	s2,160(sp)
    800059e2:	ed4e                	sd	s3,152(sp)
    800059e4:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800059e6:	08000613          	li	a2,128
    800059ea:	f5040593          	addi	a1,s0,-176
    800059ee:	4501                	li	a0,0
    800059f0:	ffffd097          	auipc	ra,0xffffd
    800059f4:	4ac080e7          	jalr	1196(ra) # 80002e9c <argstr>
    return -1;
    800059f8:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800059fa:	0c054163          	bltz	a0,80005abc <sys_open+0xe4>
    800059fe:	f4c40593          	addi	a1,s0,-180
    80005a02:	4505                	li	a0,1
    80005a04:	ffffd097          	auipc	ra,0xffffd
    80005a08:	454080e7          	jalr	1108(ra) # 80002e58 <argint>
    80005a0c:	0a054863          	bltz	a0,80005abc <sys_open+0xe4>

  begin_op();
    80005a10:	fffff097          	auipc	ra,0xfffff
    80005a14:	a20080e7          	jalr	-1504(ra) # 80004430 <begin_op>

  if(omode & O_CREATE){
    80005a18:	f4c42783          	lw	a5,-180(s0)
    80005a1c:	2007f793          	andi	a5,a5,512
    80005a20:	cbdd                	beqz	a5,80005ad6 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    80005a22:	4681                	li	a3,0
    80005a24:	4601                	li	a2,0
    80005a26:	4589                	li	a1,2
    80005a28:	f5040513          	addi	a0,s0,-176
    80005a2c:	00000097          	auipc	ra,0x0
    80005a30:	974080e7          	jalr	-1676(ra) # 800053a0 <create>
    80005a34:	892a                	mv	s2,a0
    if(ip == 0){
    80005a36:	c959                	beqz	a0,80005acc <sys_open+0xf4>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80005a38:	04491703          	lh	a4,68(s2)
    80005a3c:	478d                	li	a5,3
    80005a3e:	00f71763          	bne	a4,a5,80005a4c <sys_open+0x74>
    80005a42:	04695703          	lhu	a4,70(s2)
    80005a46:	47a5                	li	a5,9
    80005a48:	0ce7ec63          	bltu	a5,a4,80005b20 <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80005a4c:	fffff097          	auipc	ra,0xfffff
    80005a50:	df4080e7          	jalr	-524(ra) # 80004840 <filealloc>
    80005a54:	89aa                	mv	s3,a0
    80005a56:	10050263          	beqz	a0,80005b5a <sys_open+0x182>
    80005a5a:	00000097          	auipc	ra,0x0
    80005a5e:	904080e7          	jalr	-1788(ra) # 8000535e <fdalloc>
    80005a62:	84aa                	mv	s1,a0
    80005a64:	0e054663          	bltz	a0,80005b50 <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80005a68:	04491703          	lh	a4,68(s2)
    80005a6c:	478d                	li	a5,3
    80005a6e:	0cf70463          	beq	a4,a5,80005b36 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80005a72:	4789                	li	a5,2
    80005a74:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80005a78:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80005a7c:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    80005a80:	f4c42783          	lw	a5,-180(s0)
    80005a84:	0017c713          	xori	a4,a5,1
    80005a88:	8b05                	andi	a4,a4,1
    80005a8a:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80005a8e:	0037f713          	andi	a4,a5,3
    80005a92:	00e03733          	snez	a4,a4
    80005a96:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80005a9a:	4007f793          	andi	a5,a5,1024
    80005a9e:	c791                	beqz	a5,80005aaa <sys_open+0xd2>
    80005aa0:	04491703          	lh	a4,68(s2)
    80005aa4:	4789                	li	a5,2
    80005aa6:	08f70f63          	beq	a4,a5,80005b44 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80005aaa:	854a                	mv	a0,s2
    80005aac:	ffffe097          	auipc	ra,0xffffe
    80005ab0:	074080e7          	jalr	116(ra) # 80003b20 <iunlock>
  end_op();
    80005ab4:	fffff097          	auipc	ra,0xfffff
    80005ab8:	9fc080e7          	jalr	-1540(ra) # 800044b0 <end_op>

  return fd;
}
    80005abc:	8526                	mv	a0,s1
    80005abe:	70ea                	ld	ra,184(sp)
    80005ac0:	744a                	ld	s0,176(sp)
    80005ac2:	74aa                	ld	s1,168(sp)
    80005ac4:	790a                	ld	s2,160(sp)
    80005ac6:	69ea                	ld	s3,152(sp)
    80005ac8:	6129                	addi	sp,sp,192
    80005aca:	8082                	ret
      end_op();
    80005acc:	fffff097          	auipc	ra,0xfffff
    80005ad0:	9e4080e7          	jalr	-1564(ra) # 800044b0 <end_op>
      return -1;
    80005ad4:	b7e5                	j	80005abc <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80005ad6:	f5040513          	addi	a0,s0,-176
    80005ada:	ffffe097          	auipc	ra,0xffffe
    80005ade:	73a080e7          	jalr	1850(ra) # 80004214 <namei>
    80005ae2:	892a                	mv	s2,a0
    80005ae4:	c905                	beqz	a0,80005b14 <sys_open+0x13c>
    ilock(ip);
    80005ae6:	ffffe097          	auipc	ra,0xffffe
    80005aea:	f78080e7          	jalr	-136(ra) # 80003a5e <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80005aee:	04491703          	lh	a4,68(s2)
    80005af2:	4785                	li	a5,1
    80005af4:	f4f712e3          	bne	a4,a5,80005a38 <sys_open+0x60>
    80005af8:	f4c42783          	lw	a5,-180(s0)
    80005afc:	dba1                	beqz	a5,80005a4c <sys_open+0x74>
      iunlockput(ip);
    80005afe:	854a                	mv	a0,s2
    80005b00:	ffffe097          	auipc	ra,0xffffe
    80005b04:	1c0080e7          	jalr	448(ra) # 80003cc0 <iunlockput>
      end_op();
    80005b08:	fffff097          	auipc	ra,0xfffff
    80005b0c:	9a8080e7          	jalr	-1624(ra) # 800044b0 <end_op>
      return -1;
    80005b10:	54fd                	li	s1,-1
    80005b12:	b76d                	j	80005abc <sys_open+0xe4>
      end_op();
    80005b14:	fffff097          	auipc	ra,0xfffff
    80005b18:	99c080e7          	jalr	-1636(ra) # 800044b0 <end_op>
      return -1;
    80005b1c:	54fd                	li	s1,-1
    80005b1e:	bf79                	j	80005abc <sys_open+0xe4>
    iunlockput(ip);
    80005b20:	854a                	mv	a0,s2
    80005b22:	ffffe097          	auipc	ra,0xffffe
    80005b26:	19e080e7          	jalr	414(ra) # 80003cc0 <iunlockput>
    end_op();
    80005b2a:	fffff097          	auipc	ra,0xfffff
    80005b2e:	986080e7          	jalr	-1658(ra) # 800044b0 <end_op>
    return -1;
    80005b32:	54fd                	li	s1,-1
    80005b34:	b761                	j	80005abc <sys_open+0xe4>
    f->type = FD_DEVICE;
    80005b36:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80005b3a:	04691783          	lh	a5,70(s2)
    80005b3e:	02f99223          	sh	a5,36(s3)
    80005b42:	bf2d                	j	80005a7c <sys_open+0xa4>
    itrunc(ip);
    80005b44:	854a                	mv	a0,s2
    80005b46:	ffffe097          	auipc	ra,0xffffe
    80005b4a:	026080e7          	jalr	38(ra) # 80003b6c <itrunc>
    80005b4e:	bfb1                	j	80005aaa <sys_open+0xd2>
      fileclose(f);
    80005b50:	854e                	mv	a0,s3
    80005b52:	fffff097          	auipc	ra,0xfffff
    80005b56:	daa080e7          	jalr	-598(ra) # 800048fc <fileclose>
    iunlockput(ip);
    80005b5a:	854a                	mv	a0,s2
    80005b5c:	ffffe097          	auipc	ra,0xffffe
    80005b60:	164080e7          	jalr	356(ra) # 80003cc0 <iunlockput>
    end_op();
    80005b64:	fffff097          	auipc	ra,0xfffff
    80005b68:	94c080e7          	jalr	-1716(ra) # 800044b0 <end_op>
    return -1;
    80005b6c:	54fd                	li	s1,-1
    80005b6e:	b7b9                	j	80005abc <sys_open+0xe4>

0000000080005b70 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80005b70:	7175                	addi	sp,sp,-144
    80005b72:	e506                	sd	ra,136(sp)
    80005b74:	e122                	sd	s0,128(sp)
    80005b76:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80005b78:	fffff097          	auipc	ra,0xfffff
    80005b7c:	8b8080e7          	jalr	-1864(ra) # 80004430 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80005b80:	08000613          	li	a2,128
    80005b84:	f7040593          	addi	a1,s0,-144
    80005b88:	4501                	li	a0,0
    80005b8a:	ffffd097          	auipc	ra,0xffffd
    80005b8e:	312080e7          	jalr	786(ra) # 80002e9c <argstr>
    80005b92:	02054963          	bltz	a0,80005bc4 <sys_mkdir+0x54>
    80005b96:	4681                	li	a3,0
    80005b98:	4601                	li	a2,0
    80005b9a:	4585                	li	a1,1
    80005b9c:	f7040513          	addi	a0,s0,-144
    80005ba0:	00000097          	auipc	ra,0x0
    80005ba4:	800080e7          	jalr	-2048(ra) # 800053a0 <create>
    80005ba8:	cd11                	beqz	a0,80005bc4 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005baa:	ffffe097          	auipc	ra,0xffffe
    80005bae:	116080e7          	jalr	278(ra) # 80003cc0 <iunlockput>
  end_op();
    80005bb2:	fffff097          	auipc	ra,0xfffff
    80005bb6:	8fe080e7          	jalr	-1794(ra) # 800044b0 <end_op>
  return 0;
    80005bba:	4501                	li	a0,0
}
    80005bbc:	60aa                	ld	ra,136(sp)
    80005bbe:	640a                	ld	s0,128(sp)
    80005bc0:	6149                	addi	sp,sp,144
    80005bc2:	8082                	ret
    end_op();
    80005bc4:	fffff097          	auipc	ra,0xfffff
    80005bc8:	8ec080e7          	jalr	-1812(ra) # 800044b0 <end_op>
    return -1;
    80005bcc:	557d                	li	a0,-1
    80005bce:	b7fd                	j	80005bbc <sys_mkdir+0x4c>

0000000080005bd0 <sys_mknod>:

uint64
sys_mknod(void)
{
    80005bd0:	7135                	addi	sp,sp,-160
    80005bd2:	ed06                	sd	ra,152(sp)
    80005bd4:	e922                	sd	s0,144(sp)
    80005bd6:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80005bd8:	fffff097          	auipc	ra,0xfffff
    80005bdc:	858080e7          	jalr	-1960(ra) # 80004430 <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005be0:	08000613          	li	a2,128
    80005be4:	f7040593          	addi	a1,s0,-144
    80005be8:	4501                	li	a0,0
    80005bea:	ffffd097          	auipc	ra,0xffffd
    80005bee:	2b2080e7          	jalr	690(ra) # 80002e9c <argstr>
    80005bf2:	04054a63          	bltz	a0,80005c46 <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80005bf6:	f6c40593          	addi	a1,s0,-148
    80005bfa:	4505                	li	a0,1
    80005bfc:	ffffd097          	auipc	ra,0xffffd
    80005c00:	25c080e7          	jalr	604(ra) # 80002e58 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005c04:	04054163          	bltz	a0,80005c46 <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80005c08:	f6840593          	addi	a1,s0,-152
    80005c0c:	4509                	li	a0,2
    80005c0e:	ffffd097          	auipc	ra,0xffffd
    80005c12:	24a080e7          	jalr	586(ra) # 80002e58 <argint>
     argint(1, &major) < 0 ||
    80005c16:	02054863          	bltz	a0,80005c46 <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80005c1a:	f6841683          	lh	a3,-152(s0)
    80005c1e:	f6c41603          	lh	a2,-148(s0)
    80005c22:	458d                	li	a1,3
    80005c24:	f7040513          	addi	a0,s0,-144
    80005c28:	fffff097          	auipc	ra,0xfffff
    80005c2c:	778080e7          	jalr	1912(ra) # 800053a0 <create>
     argint(2, &minor) < 0 ||
    80005c30:	c919                	beqz	a0,80005c46 <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005c32:	ffffe097          	auipc	ra,0xffffe
    80005c36:	08e080e7          	jalr	142(ra) # 80003cc0 <iunlockput>
  end_op();
    80005c3a:	fffff097          	auipc	ra,0xfffff
    80005c3e:	876080e7          	jalr	-1930(ra) # 800044b0 <end_op>
  return 0;
    80005c42:	4501                	li	a0,0
    80005c44:	a031                	j	80005c50 <sys_mknod+0x80>
    end_op();
    80005c46:	fffff097          	auipc	ra,0xfffff
    80005c4a:	86a080e7          	jalr	-1942(ra) # 800044b0 <end_op>
    return -1;
    80005c4e:	557d                	li	a0,-1
}
    80005c50:	60ea                	ld	ra,152(sp)
    80005c52:	644a                	ld	s0,144(sp)
    80005c54:	610d                	addi	sp,sp,160
    80005c56:	8082                	ret

0000000080005c58 <sys_chdir>:

uint64
sys_chdir(void)
{
    80005c58:	7135                	addi	sp,sp,-160
    80005c5a:	ed06                	sd	ra,152(sp)
    80005c5c:	e922                	sd	s0,144(sp)
    80005c5e:	e526                	sd	s1,136(sp)
    80005c60:	e14a                	sd	s2,128(sp)
    80005c62:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80005c64:	ffffc097          	auipc	ra,0xffffc
    80005c68:	e2e080e7          	jalr	-466(ra) # 80001a92 <myproc>
    80005c6c:	892a                	mv	s2,a0
  
  begin_op();
    80005c6e:	ffffe097          	auipc	ra,0xffffe
    80005c72:	7c2080e7          	jalr	1986(ra) # 80004430 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80005c76:	08000613          	li	a2,128
    80005c7a:	f6040593          	addi	a1,s0,-160
    80005c7e:	4501                	li	a0,0
    80005c80:	ffffd097          	auipc	ra,0xffffd
    80005c84:	21c080e7          	jalr	540(ra) # 80002e9c <argstr>
    80005c88:	04054b63          	bltz	a0,80005cde <sys_chdir+0x86>
    80005c8c:	f6040513          	addi	a0,s0,-160
    80005c90:	ffffe097          	auipc	ra,0xffffe
    80005c94:	584080e7          	jalr	1412(ra) # 80004214 <namei>
    80005c98:	84aa                	mv	s1,a0
    80005c9a:	c131                	beqz	a0,80005cde <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80005c9c:	ffffe097          	auipc	ra,0xffffe
    80005ca0:	dc2080e7          	jalr	-574(ra) # 80003a5e <ilock>
  if(ip->type != T_DIR){
    80005ca4:	04449703          	lh	a4,68(s1)
    80005ca8:	4785                	li	a5,1
    80005caa:	04f71063          	bne	a4,a5,80005cea <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80005cae:	8526                	mv	a0,s1
    80005cb0:	ffffe097          	auipc	ra,0xffffe
    80005cb4:	e70080e7          	jalr	-400(ra) # 80003b20 <iunlock>
  iput(p->cwd);
    80005cb8:	15093503          	ld	a0,336(s2)
    80005cbc:	ffffe097          	auipc	ra,0xffffe
    80005cc0:	f5c080e7          	jalr	-164(ra) # 80003c18 <iput>
  end_op();
    80005cc4:	ffffe097          	auipc	ra,0xffffe
    80005cc8:	7ec080e7          	jalr	2028(ra) # 800044b0 <end_op>
  p->cwd = ip;
    80005ccc:	14993823          	sd	s1,336(s2)
  return 0;
    80005cd0:	4501                	li	a0,0
}
    80005cd2:	60ea                	ld	ra,152(sp)
    80005cd4:	644a                	ld	s0,144(sp)
    80005cd6:	64aa                	ld	s1,136(sp)
    80005cd8:	690a                	ld	s2,128(sp)
    80005cda:	610d                	addi	sp,sp,160
    80005cdc:	8082                	ret
    end_op();
    80005cde:	ffffe097          	auipc	ra,0xffffe
    80005ce2:	7d2080e7          	jalr	2002(ra) # 800044b0 <end_op>
    return -1;
    80005ce6:	557d                	li	a0,-1
    80005ce8:	b7ed                	j	80005cd2 <sys_chdir+0x7a>
    iunlockput(ip);
    80005cea:	8526                	mv	a0,s1
    80005cec:	ffffe097          	auipc	ra,0xffffe
    80005cf0:	fd4080e7          	jalr	-44(ra) # 80003cc0 <iunlockput>
    end_op();
    80005cf4:	ffffe097          	auipc	ra,0xffffe
    80005cf8:	7bc080e7          	jalr	1980(ra) # 800044b0 <end_op>
    return -1;
    80005cfc:	557d                	li	a0,-1
    80005cfe:	bfd1                	j	80005cd2 <sys_chdir+0x7a>

0000000080005d00 <sys_exec>:

uint64
sys_exec(void)
{
    80005d00:	7145                	addi	sp,sp,-464
    80005d02:	e786                	sd	ra,456(sp)
    80005d04:	e3a2                	sd	s0,448(sp)
    80005d06:	ff26                	sd	s1,440(sp)
    80005d08:	fb4a                	sd	s2,432(sp)
    80005d0a:	f74e                	sd	s3,424(sp)
    80005d0c:	f352                	sd	s4,416(sp)
    80005d0e:	ef56                	sd	s5,408(sp)
    80005d10:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80005d12:	08000613          	li	a2,128
    80005d16:	f4040593          	addi	a1,s0,-192
    80005d1a:	4501                	li	a0,0
    80005d1c:	ffffd097          	auipc	ra,0xffffd
    80005d20:	180080e7          	jalr	384(ra) # 80002e9c <argstr>
    return -1;
    80005d24:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80005d26:	0c054a63          	bltz	a0,80005dfa <sys_exec+0xfa>
    80005d2a:	e3840593          	addi	a1,s0,-456
    80005d2e:	4505                	li	a0,1
    80005d30:	ffffd097          	auipc	ra,0xffffd
    80005d34:	14a080e7          	jalr	330(ra) # 80002e7a <argaddr>
    80005d38:	0c054163          	bltz	a0,80005dfa <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    80005d3c:	10000613          	li	a2,256
    80005d40:	4581                	li	a1,0
    80005d42:	e4040513          	addi	a0,s0,-448
    80005d46:	ffffb097          	auipc	ra,0xffffb
    80005d4a:	f86080e7          	jalr	-122(ra) # 80000ccc <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80005d4e:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    80005d52:	89a6                	mv	s3,s1
    80005d54:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80005d56:	02000a13          	li	s4,32
    80005d5a:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005d5e:	00391793          	slli	a5,s2,0x3
    80005d62:	e3040593          	addi	a1,s0,-464
    80005d66:	e3843503          	ld	a0,-456(s0)
    80005d6a:	953e                	add	a0,a0,a5
    80005d6c:	ffffd097          	auipc	ra,0xffffd
    80005d70:	052080e7          	jalr	82(ra) # 80002dbe <fetchaddr>
    80005d74:	02054a63          	bltz	a0,80005da8 <sys_exec+0xa8>
      goto bad;
    }
    if(uarg == 0){
    80005d78:	e3043783          	ld	a5,-464(s0)
    80005d7c:	c3b9                	beqz	a5,80005dc2 <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80005d7e:	ffffb097          	auipc	ra,0xffffb
    80005d82:	d62080e7          	jalr	-670(ra) # 80000ae0 <kalloc>
    80005d86:	85aa                	mv	a1,a0
    80005d88:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005d8c:	cd11                	beqz	a0,80005da8 <sys_exec+0xa8>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005d8e:	6605                	lui	a2,0x1
    80005d90:	e3043503          	ld	a0,-464(s0)
    80005d94:	ffffd097          	auipc	ra,0xffffd
    80005d98:	07c080e7          	jalr	124(ra) # 80002e10 <fetchstr>
    80005d9c:	00054663          	bltz	a0,80005da8 <sys_exec+0xa8>
    if(i >= NELEM(argv)){
    80005da0:	0905                	addi	s2,s2,1
    80005da2:	09a1                	addi	s3,s3,8
    80005da4:	fb491be3          	bne	s2,s4,80005d5a <sys_exec+0x5a>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005da8:	10048913          	addi	s2,s1,256
    80005dac:	6088                	ld	a0,0(s1)
    80005dae:	c529                	beqz	a0,80005df8 <sys_exec+0xf8>
    kfree(argv[i]);
    80005db0:	ffffb097          	auipc	ra,0xffffb
    80005db4:	c34080e7          	jalr	-972(ra) # 800009e4 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005db8:	04a1                	addi	s1,s1,8
    80005dba:	ff2499e3          	bne	s1,s2,80005dac <sys_exec+0xac>
  return -1;
    80005dbe:	597d                	li	s2,-1
    80005dc0:	a82d                	j	80005dfa <sys_exec+0xfa>
      argv[i] = 0;
    80005dc2:	0a8e                	slli	s5,s5,0x3
    80005dc4:	fc040793          	addi	a5,s0,-64
    80005dc8:	9abe                	add	s5,s5,a5
    80005dca:	e80ab023          	sd	zero,-384(s5) # ffffffffffffee80 <end+0xffffffff7fbd8e80>
  int ret = exec(path, argv);
    80005dce:	e4040593          	addi	a1,s0,-448
    80005dd2:	f4040513          	addi	a0,s0,-192
    80005dd6:	fffff097          	auipc	ra,0xfffff
    80005dda:	178080e7          	jalr	376(ra) # 80004f4e <exec>
    80005dde:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005de0:	10048993          	addi	s3,s1,256
    80005de4:	6088                	ld	a0,0(s1)
    80005de6:	c911                	beqz	a0,80005dfa <sys_exec+0xfa>
    kfree(argv[i]);
    80005de8:	ffffb097          	auipc	ra,0xffffb
    80005dec:	bfc080e7          	jalr	-1028(ra) # 800009e4 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005df0:	04a1                	addi	s1,s1,8
    80005df2:	ff3499e3          	bne	s1,s3,80005de4 <sys_exec+0xe4>
    80005df6:	a011                	j	80005dfa <sys_exec+0xfa>
  return -1;
    80005df8:	597d                	li	s2,-1
}
    80005dfa:	854a                	mv	a0,s2
    80005dfc:	60be                	ld	ra,456(sp)
    80005dfe:	641e                	ld	s0,448(sp)
    80005e00:	74fa                	ld	s1,440(sp)
    80005e02:	795a                	ld	s2,432(sp)
    80005e04:	79ba                	ld	s3,424(sp)
    80005e06:	7a1a                	ld	s4,416(sp)
    80005e08:	6afa                	ld	s5,408(sp)
    80005e0a:	6179                	addi	sp,sp,464
    80005e0c:	8082                	ret

0000000080005e0e <sys_pipe>:

uint64
sys_pipe(void)
{
    80005e0e:	7139                	addi	sp,sp,-64
    80005e10:	fc06                	sd	ra,56(sp)
    80005e12:	f822                	sd	s0,48(sp)
    80005e14:	f426                	sd	s1,40(sp)
    80005e16:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005e18:	ffffc097          	auipc	ra,0xffffc
    80005e1c:	c7a080e7          	jalr	-902(ra) # 80001a92 <myproc>
    80005e20:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    80005e22:	fd840593          	addi	a1,s0,-40
    80005e26:	4501                	li	a0,0
    80005e28:	ffffd097          	auipc	ra,0xffffd
    80005e2c:	052080e7          	jalr	82(ra) # 80002e7a <argaddr>
    return -1;
    80005e30:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    80005e32:	0e054063          	bltz	a0,80005f12 <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    80005e36:	fc840593          	addi	a1,s0,-56
    80005e3a:	fd040513          	addi	a0,s0,-48
    80005e3e:	fffff097          	auipc	ra,0xfffff
    80005e42:	dee080e7          	jalr	-530(ra) # 80004c2c <pipealloc>
    return -1;
    80005e46:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005e48:	0c054563          	bltz	a0,80005f12 <sys_pipe+0x104>
  fd0 = -1;
    80005e4c:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005e50:	fd043503          	ld	a0,-48(s0)
    80005e54:	fffff097          	auipc	ra,0xfffff
    80005e58:	50a080e7          	jalr	1290(ra) # 8000535e <fdalloc>
    80005e5c:	fca42223          	sw	a0,-60(s0)
    80005e60:	08054c63          	bltz	a0,80005ef8 <sys_pipe+0xea>
    80005e64:	fc843503          	ld	a0,-56(s0)
    80005e68:	fffff097          	auipc	ra,0xfffff
    80005e6c:	4f6080e7          	jalr	1270(ra) # 8000535e <fdalloc>
    80005e70:	fca42023          	sw	a0,-64(s0)
    80005e74:	06054863          	bltz	a0,80005ee4 <sys_pipe+0xd6>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005e78:	4691                	li	a3,4
    80005e7a:	fc440613          	addi	a2,s0,-60
    80005e7e:	fd843583          	ld	a1,-40(s0)
    80005e82:	68a8                	ld	a0,80(s1)
    80005e84:	ffffb097          	auipc	ra,0xffffb
    80005e88:	7d2080e7          	jalr	2002(ra) # 80001656 <copyout>
    80005e8c:	02054063          	bltz	a0,80005eac <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005e90:	4691                	li	a3,4
    80005e92:	fc040613          	addi	a2,s0,-64
    80005e96:	fd843583          	ld	a1,-40(s0)
    80005e9a:	0591                	addi	a1,a1,4
    80005e9c:	68a8                	ld	a0,80(s1)
    80005e9e:	ffffb097          	auipc	ra,0xffffb
    80005ea2:	7b8080e7          	jalr	1976(ra) # 80001656 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005ea6:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005ea8:	06055563          	bgez	a0,80005f12 <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    80005eac:	fc442783          	lw	a5,-60(s0)
    80005eb0:	07e9                	addi	a5,a5,26
    80005eb2:	078e                	slli	a5,a5,0x3
    80005eb4:	97a6                	add	a5,a5,s1
    80005eb6:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80005eba:	fc042503          	lw	a0,-64(s0)
    80005ebe:	0569                	addi	a0,a0,26
    80005ec0:	050e                	slli	a0,a0,0x3
    80005ec2:	9526                	add	a0,a0,s1
    80005ec4:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005ec8:	fd043503          	ld	a0,-48(s0)
    80005ecc:	fffff097          	auipc	ra,0xfffff
    80005ed0:	a30080e7          	jalr	-1488(ra) # 800048fc <fileclose>
    fileclose(wf);
    80005ed4:	fc843503          	ld	a0,-56(s0)
    80005ed8:	fffff097          	auipc	ra,0xfffff
    80005edc:	a24080e7          	jalr	-1500(ra) # 800048fc <fileclose>
    return -1;
    80005ee0:	57fd                	li	a5,-1
    80005ee2:	a805                	j	80005f12 <sys_pipe+0x104>
    if(fd0 >= 0)
    80005ee4:	fc442783          	lw	a5,-60(s0)
    80005ee8:	0007c863          	bltz	a5,80005ef8 <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    80005eec:	01a78513          	addi	a0,a5,26
    80005ef0:	050e                	slli	a0,a0,0x3
    80005ef2:	9526                	add	a0,a0,s1
    80005ef4:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005ef8:	fd043503          	ld	a0,-48(s0)
    80005efc:	fffff097          	auipc	ra,0xfffff
    80005f00:	a00080e7          	jalr	-1536(ra) # 800048fc <fileclose>
    fileclose(wf);
    80005f04:	fc843503          	ld	a0,-56(s0)
    80005f08:	fffff097          	auipc	ra,0xfffff
    80005f0c:	9f4080e7          	jalr	-1548(ra) # 800048fc <fileclose>
    return -1;
    80005f10:	57fd                	li	a5,-1
}
    80005f12:	853e                	mv	a0,a5
    80005f14:	70e2                	ld	ra,56(sp)
    80005f16:	7442                	ld	s0,48(sp)
    80005f18:	74a2                	ld	s1,40(sp)
    80005f1a:	6121                	addi	sp,sp,64
    80005f1c:	8082                	ret
	...

0000000080005f20 <kernelvec>:
    80005f20:	7111                	addi	sp,sp,-256
    80005f22:	e006                	sd	ra,0(sp)
    80005f24:	e40a                	sd	sp,8(sp)
    80005f26:	e80e                	sd	gp,16(sp)
    80005f28:	ec12                	sd	tp,24(sp)
    80005f2a:	f016                	sd	t0,32(sp)
    80005f2c:	f41a                	sd	t1,40(sp)
    80005f2e:	f81e                	sd	t2,48(sp)
    80005f30:	fc22                	sd	s0,56(sp)
    80005f32:	e0a6                	sd	s1,64(sp)
    80005f34:	e4aa                	sd	a0,72(sp)
    80005f36:	e8ae                	sd	a1,80(sp)
    80005f38:	ecb2                	sd	a2,88(sp)
    80005f3a:	f0b6                	sd	a3,96(sp)
    80005f3c:	f4ba                	sd	a4,104(sp)
    80005f3e:	f8be                	sd	a5,112(sp)
    80005f40:	fcc2                	sd	a6,120(sp)
    80005f42:	e146                	sd	a7,128(sp)
    80005f44:	e54a                	sd	s2,136(sp)
    80005f46:	e94e                	sd	s3,144(sp)
    80005f48:	ed52                	sd	s4,152(sp)
    80005f4a:	f156                	sd	s5,160(sp)
    80005f4c:	f55a                	sd	s6,168(sp)
    80005f4e:	f95e                	sd	s7,176(sp)
    80005f50:	fd62                	sd	s8,184(sp)
    80005f52:	e1e6                	sd	s9,192(sp)
    80005f54:	e5ea                	sd	s10,200(sp)
    80005f56:	e9ee                	sd	s11,208(sp)
    80005f58:	edf2                	sd	t3,216(sp)
    80005f5a:	f1f6                	sd	t4,224(sp)
    80005f5c:	f5fa                	sd	t5,232(sp)
    80005f5e:	f9fe                	sd	t6,240(sp)
    80005f60:	d2bfc0ef          	jal	ra,80002c8a <kerneltrap>
    80005f64:	6082                	ld	ra,0(sp)
    80005f66:	6122                	ld	sp,8(sp)
    80005f68:	61c2                	ld	gp,16(sp)
    80005f6a:	7282                	ld	t0,32(sp)
    80005f6c:	7322                	ld	t1,40(sp)
    80005f6e:	73c2                	ld	t2,48(sp)
    80005f70:	7462                	ld	s0,56(sp)
    80005f72:	6486                	ld	s1,64(sp)
    80005f74:	6526                	ld	a0,72(sp)
    80005f76:	65c6                	ld	a1,80(sp)
    80005f78:	6666                	ld	a2,88(sp)
    80005f7a:	7686                	ld	a3,96(sp)
    80005f7c:	7726                	ld	a4,104(sp)
    80005f7e:	77c6                	ld	a5,112(sp)
    80005f80:	7866                	ld	a6,120(sp)
    80005f82:	688a                	ld	a7,128(sp)
    80005f84:	692a                	ld	s2,136(sp)
    80005f86:	69ca                	ld	s3,144(sp)
    80005f88:	6a6a                	ld	s4,152(sp)
    80005f8a:	7a8a                	ld	s5,160(sp)
    80005f8c:	7b2a                	ld	s6,168(sp)
    80005f8e:	7bca                	ld	s7,176(sp)
    80005f90:	7c6a                	ld	s8,184(sp)
    80005f92:	6c8e                	ld	s9,192(sp)
    80005f94:	6d2e                	ld	s10,200(sp)
    80005f96:	6dce                	ld	s11,208(sp)
    80005f98:	6e6e                	ld	t3,216(sp)
    80005f9a:	7e8e                	ld	t4,224(sp)
    80005f9c:	7f2e                	ld	t5,232(sp)
    80005f9e:	7fce                	ld	t6,240(sp)
    80005fa0:	6111                	addi	sp,sp,256
    80005fa2:	10200073          	sret
    80005fa6:	00000013          	nop
    80005faa:	00000013          	nop
    80005fae:	0001                	nop

0000000080005fb0 <timervec>:
    80005fb0:	34051573          	csrrw	a0,mscratch,a0
    80005fb4:	e10c                	sd	a1,0(a0)
    80005fb6:	e510                	sd	a2,8(a0)
    80005fb8:	e914                	sd	a3,16(a0)
    80005fba:	6d0c                	ld	a1,24(a0)
    80005fbc:	7110                	ld	a2,32(a0)
    80005fbe:	6194                	ld	a3,0(a1)
    80005fc0:	96b2                	add	a3,a3,a2
    80005fc2:	e194                	sd	a3,0(a1)
    80005fc4:	4589                	li	a1,2
    80005fc6:	14459073          	csrw	sip,a1
    80005fca:	6914                	ld	a3,16(a0)
    80005fcc:	6510                	ld	a2,8(a0)
    80005fce:	610c                	ld	a1,0(a0)
    80005fd0:	34051573          	csrrw	a0,mscratch,a0
    80005fd4:	30200073          	mret
	...

0000000080005fda <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80005fda:	1141                	addi	sp,sp,-16
    80005fdc:	e422                	sd	s0,8(sp)
    80005fde:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005fe0:	0c0007b7          	lui	a5,0xc000
    80005fe4:	4705                	li	a4,1
    80005fe6:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005fe8:	c3d8                	sw	a4,4(a5)
}
    80005fea:	6422                	ld	s0,8(sp)
    80005fec:	0141                	addi	sp,sp,16
    80005fee:	8082                	ret

0000000080005ff0 <plicinithart>:

void
plicinithart(void)
{
    80005ff0:	1141                	addi	sp,sp,-16
    80005ff2:	e406                	sd	ra,8(sp)
    80005ff4:	e022                	sd	s0,0(sp)
    80005ff6:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005ff8:	ffffc097          	auipc	ra,0xffffc
    80005ffc:	a6e080e7          	jalr	-1426(ra) # 80001a66 <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80006000:	0085171b          	slliw	a4,a0,0x8
    80006004:	0c0027b7          	lui	a5,0xc002
    80006008:	97ba                	add	a5,a5,a4
    8000600a:	40200713          	li	a4,1026
    8000600e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80006012:	00d5151b          	slliw	a0,a0,0xd
    80006016:	0c2017b7          	lui	a5,0xc201
    8000601a:	953e                	add	a0,a0,a5
    8000601c:	00052023          	sw	zero,0(a0)
}
    80006020:	60a2                	ld	ra,8(sp)
    80006022:	6402                	ld	s0,0(sp)
    80006024:	0141                	addi	sp,sp,16
    80006026:	8082                	ret

0000000080006028 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80006028:	1141                	addi	sp,sp,-16
    8000602a:	e406                	sd	ra,8(sp)
    8000602c:	e022                	sd	s0,0(sp)
    8000602e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80006030:	ffffc097          	auipc	ra,0xffffc
    80006034:	a36080e7          	jalr	-1482(ra) # 80001a66 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80006038:	00d5179b          	slliw	a5,a0,0xd
    8000603c:	0c201537          	lui	a0,0xc201
    80006040:	953e                	add	a0,a0,a5
  return irq;
}
    80006042:	4148                	lw	a0,4(a0)
    80006044:	60a2                	ld	ra,8(sp)
    80006046:	6402                	ld	s0,0(sp)
    80006048:	0141                	addi	sp,sp,16
    8000604a:	8082                	ret

000000008000604c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000604c:	1101                	addi	sp,sp,-32
    8000604e:	ec06                	sd	ra,24(sp)
    80006050:	e822                	sd	s0,16(sp)
    80006052:	e426                	sd	s1,8(sp)
    80006054:	1000                	addi	s0,sp,32
    80006056:	84aa                	mv	s1,a0
  int hart = cpuid();
    80006058:	ffffc097          	auipc	ra,0xffffc
    8000605c:	a0e080e7          	jalr	-1522(ra) # 80001a66 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80006060:	00d5151b          	slliw	a0,a0,0xd
    80006064:	0c2017b7          	lui	a5,0xc201
    80006068:	97aa                	add	a5,a5,a0
    8000606a:	c3c4                	sw	s1,4(a5)
}
    8000606c:	60e2                	ld	ra,24(sp)
    8000606e:	6442                	ld	s0,16(sp)
    80006070:	64a2                	ld	s1,8(sp)
    80006072:	6105                	addi	sp,sp,32
    80006074:	8082                	ret

0000000080006076 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80006076:	1141                	addi	sp,sp,-16
    80006078:	e406                	sd	ra,8(sp)
    8000607a:	e022                	sd	s0,0(sp)
    8000607c:	0800                	addi	s0,sp,16
  if(i >= NUM)
    8000607e:	479d                	li	a5,7
    80006080:	06a7c963          	blt	a5,a0,800060f2 <free_desc+0x7c>
    panic("free_desc 1");
  if(disk.free[i])
    80006084:	0041d797          	auipc	a5,0x41d
    80006088:	f7c78793          	addi	a5,a5,-132 # 80423000 <disk>
    8000608c:	00a78733          	add	a4,a5,a0
    80006090:	6789                	lui	a5,0x2
    80006092:	97ba                	add	a5,a5,a4
    80006094:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    80006098:	e7ad                	bnez	a5,80006102 <free_desc+0x8c>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    8000609a:	00451793          	slli	a5,a0,0x4
    8000609e:	0041f717          	auipc	a4,0x41f
    800060a2:	f6270713          	addi	a4,a4,-158 # 80425000 <disk+0x2000>
    800060a6:	6314                	ld	a3,0(a4)
    800060a8:	96be                	add	a3,a3,a5
    800060aa:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    800060ae:	6314                	ld	a3,0(a4)
    800060b0:	96be                	add	a3,a3,a5
    800060b2:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    800060b6:	6314                	ld	a3,0(a4)
    800060b8:	96be                	add	a3,a3,a5
    800060ba:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    800060be:	6318                	ld	a4,0(a4)
    800060c0:	97ba                	add	a5,a5,a4
    800060c2:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    800060c6:	0041d797          	auipc	a5,0x41d
    800060ca:	f3a78793          	addi	a5,a5,-198 # 80423000 <disk>
    800060ce:	97aa                	add	a5,a5,a0
    800060d0:	6509                	lui	a0,0x2
    800060d2:	953e                	add	a0,a0,a5
    800060d4:	4785                	li	a5,1
    800060d6:	00f50c23          	sb	a5,24(a0) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    800060da:	0041f517          	auipc	a0,0x41f
    800060de:	f3e50513          	addi	a0,a0,-194 # 80425018 <disk+0x2018>
    800060e2:	ffffc097          	auipc	ra,0xffffc
    800060e6:	236080e7          	jalr	566(ra) # 80002318 <wakeup>
}
    800060ea:	60a2                	ld	ra,8(sp)
    800060ec:	6402                	ld	s0,0(sp)
    800060ee:	0141                	addi	sp,sp,16
    800060f0:	8082                	ret
    panic("free_desc 1");
    800060f2:	00002517          	auipc	a0,0x2
    800060f6:	6fe50513          	addi	a0,a0,1790 # 800087f0 <syscalls+0x330>
    800060fa:	ffffa097          	auipc	ra,0xffffa
    800060fe:	43e080e7          	jalr	1086(ra) # 80000538 <panic>
    panic("free_desc 2");
    80006102:	00002517          	auipc	a0,0x2
    80006106:	6fe50513          	addi	a0,a0,1790 # 80008800 <syscalls+0x340>
    8000610a:	ffffa097          	auipc	ra,0xffffa
    8000610e:	42e080e7          	jalr	1070(ra) # 80000538 <panic>

0000000080006112 <virtio_disk_init>:
{
    80006112:	1101                	addi	sp,sp,-32
    80006114:	ec06                	sd	ra,24(sp)
    80006116:	e822                	sd	s0,16(sp)
    80006118:	e426                	sd	s1,8(sp)
    8000611a:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    8000611c:	00002597          	auipc	a1,0x2
    80006120:	6f458593          	addi	a1,a1,1780 # 80008810 <syscalls+0x350>
    80006124:	0041f517          	auipc	a0,0x41f
    80006128:	00450513          	addi	a0,a0,4 # 80425128 <disk+0x2128>
    8000612c:	ffffb097          	auipc	ra,0xffffb
    80006130:	a14080e7          	jalr	-1516(ra) # 80000b40 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80006134:	100017b7          	lui	a5,0x10001
    80006138:	4398                	lw	a4,0(a5)
    8000613a:	2701                	sext.w	a4,a4
    8000613c:	747277b7          	lui	a5,0x74727
    80006140:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80006144:	0ef71163          	bne	a4,a5,80006226 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80006148:	100017b7          	lui	a5,0x10001
    8000614c:	43dc                	lw	a5,4(a5)
    8000614e:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80006150:	4705                	li	a4,1
    80006152:	0ce79a63          	bne	a5,a4,80006226 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80006156:	100017b7          	lui	a5,0x10001
    8000615a:	479c                	lw	a5,8(a5)
    8000615c:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    8000615e:	4709                	li	a4,2
    80006160:	0ce79363          	bne	a5,a4,80006226 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80006164:	100017b7          	lui	a5,0x10001
    80006168:	47d8                	lw	a4,12(a5)
    8000616a:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000616c:	554d47b7          	lui	a5,0x554d4
    80006170:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80006174:	0af71963          	bne	a4,a5,80006226 <virtio_disk_init+0x114>
  *R(VIRTIO_MMIO_STATUS) = status;
    80006178:	100017b7          	lui	a5,0x10001
    8000617c:	4705                	li	a4,1
    8000617e:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80006180:	470d                	li	a4,3
    80006182:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80006184:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80006186:	c7ffe737          	lui	a4,0xc7ffe
    8000618a:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47bd875f>
    8000618e:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80006190:	2701                	sext.w	a4,a4
    80006192:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80006194:	472d                	li	a4,11
    80006196:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80006198:	473d                	li	a4,15
    8000619a:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    8000619c:	6705                	lui	a4,0x1
    8000619e:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    800061a0:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    800061a4:	5bdc                	lw	a5,52(a5)
    800061a6:	2781                	sext.w	a5,a5
  if(max == 0)
    800061a8:	c7d9                	beqz	a5,80006236 <virtio_disk_init+0x124>
  if(max < NUM)
    800061aa:	471d                	li	a4,7
    800061ac:	08f77d63          	bgeu	a4,a5,80006246 <virtio_disk_init+0x134>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800061b0:	100014b7          	lui	s1,0x10001
    800061b4:	47a1                	li	a5,8
    800061b6:	dc9c                	sw	a5,56(s1)
  memset(disk.pages, 0, sizeof(disk.pages));
    800061b8:	6609                	lui	a2,0x2
    800061ba:	4581                	li	a1,0
    800061bc:	0041d517          	auipc	a0,0x41d
    800061c0:	e4450513          	addi	a0,a0,-444 # 80423000 <disk>
    800061c4:	ffffb097          	auipc	ra,0xffffb
    800061c8:	b08080e7          	jalr	-1272(ra) # 80000ccc <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    800061cc:	0041d717          	auipc	a4,0x41d
    800061d0:	e3470713          	addi	a4,a4,-460 # 80423000 <disk>
    800061d4:	00c75793          	srli	a5,a4,0xc
    800061d8:	2781                	sext.w	a5,a5
    800061da:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct virtq_desc *) disk.pages;
    800061dc:	0041f797          	auipc	a5,0x41f
    800061e0:	e2478793          	addi	a5,a5,-476 # 80425000 <disk+0x2000>
    800061e4:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    800061e6:	0041d717          	auipc	a4,0x41d
    800061ea:	e9a70713          	addi	a4,a4,-358 # 80423080 <disk+0x80>
    800061ee:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    800061f0:	0041e717          	auipc	a4,0x41e
    800061f4:	e1070713          	addi	a4,a4,-496 # 80424000 <disk+0x1000>
    800061f8:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    800061fa:	4705                	li	a4,1
    800061fc:	00e78c23          	sb	a4,24(a5)
    80006200:	00e78ca3          	sb	a4,25(a5)
    80006204:	00e78d23          	sb	a4,26(a5)
    80006208:	00e78da3          	sb	a4,27(a5)
    8000620c:	00e78e23          	sb	a4,28(a5)
    80006210:	00e78ea3          	sb	a4,29(a5)
    80006214:	00e78f23          	sb	a4,30(a5)
    80006218:	00e78fa3          	sb	a4,31(a5)
}
    8000621c:	60e2                	ld	ra,24(sp)
    8000621e:	6442                	ld	s0,16(sp)
    80006220:	64a2                	ld	s1,8(sp)
    80006222:	6105                	addi	sp,sp,32
    80006224:	8082                	ret
    panic("could not find virtio disk");
    80006226:	00002517          	auipc	a0,0x2
    8000622a:	5fa50513          	addi	a0,a0,1530 # 80008820 <syscalls+0x360>
    8000622e:	ffffa097          	auipc	ra,0xffffa
    80006232:	30a080e7          	jalr	778(ra) # 80000538 <panic>
    panic("virtio disk has no queue 0");
    80006236:	00002517          	auipc	a0,0x2
    8000623a:	60a50513          	addi	a0,a0,1546 # 80008840 <syscalls+0x380>
    8000623e:	ffffa097          	auipc	ra,0xffffa
    80006242:	2fa080e7          	jalr	762(ra) # 80000538 <panic>
    panic("virtio disk max queue too short");
    80006246:	00002517          	auipc	a0,0x2
    8000624a:	61a50513          	addi	a0,a0,1562 # 80008860 <syscalls+0x3a0>
    8000624e:	ffffa097          	auipc	ra,0xffffa
    80006252:	2ea080e7          	jalr	746(ra) # 80000538 <panic>

0000000080006256 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80006256:	7119                	addi	sp,sp,-128
    80006258:	fc86                	sd	ra,120(sp)
    8000625a:	f8a2                	sd	s0,112(sp)
    8000625c:	f4a6                	sd	s1,104(sp)
    8000625e:	f0ca                	sd	s2,96(sp)
    80006260:	ecce                	sd	s3,88(sp)
    80006262:	e8d2                	sd	s4,80(sp)
    80006264:	e4d6                	sd	s5,72(sp)
    80006266:	e0da                	sd	s6,64(sp)
    80006268:	fc5e                	sd	s7,56(sp)
    8000626a:	f862                	sd	s8,48(sp)
    8000626c:	f466                	sd	s9,40(sp)
    8000626e:	f06a                	sd	s10,32(sp)
    80006270:	ec6e                	sd	s11,24(sp)
    80006272:	0100                	addi	s0,sp,128
    80006274:	8aaa                	mv	s5,a0
    80006276:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80006278:	00c52c83          	lw	s9,12(a0)
    8000627c:	001c9c9b          	slliw	s9,s9,0x1
    80006280:	1c82                	slli	s9,s9,0x20
    80006282:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80006286:	0041f517          	auipc	a0,0x41f
    8000628a:	ea250513          	addi	a0,a0,-350 # 80425128 <disk+0x2128>
    8000628e:	ffffb097          	auipc	ra,0xffffb
    80006292:	942080e7          	jalr	-1726(ra) # 80000bd0 <acquire>
  for(int i = 0; i < 3; i++){
    80006296:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80006298:	44a1                	li	s1,8
      disk.free[i] = 0;
    8000629a:	0041dc17          	auipc	s8,0x41d
    8000629e:	d66c0c13          	addi	s8,s8,-666 # 80423000 <disk>
    800062a2:	6b89                	lui	s7,0x2
  for(int i = 0; i < 3; i++){
    800062a4:	4b0d                	li	s6,3
    800062a6:	a0ad                	j	80006310 <virtio_disk_rw+0xba>
      disk.free[i] = 0;
    800062a8:	00fc0733          	add	a4,s8,a5
    800062ac:	975e                	add	a4,a4,s7
    800062ae:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    800062b2:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    800062b4:	0207c563          	bltz	a5,800062de <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    800062b8:	2905                	addiw	s2,s2,1
    800062ba:	0611                	addi	a2,a2,4
    800062bc:	19690d63          	beq	s2,s6,80006456 <virtio_disk_rw+0x200>
    idx[i] = alloc_desc();
    800062c0:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    800062c2:	0041f717          	auipc	a4,0x41f
    800062c6:	d5670713          	addi	a4,a4,-682 # 80425018 <disk+0x2018>
    800062ca:	87ce                	mv	a5,s3
    if(disk.free[i]){
    800062cc:	00074683          	lbu	a3,0(a4)
    800062d0:	fee1                	bnez	a3,800062a8 <virtio_disk_rw+0x52>
  for(int i = 0; i < NUM; i++){
    800062d2:	2785                	addiw	a5,a5,1
    800062d4:	0705                	addi	a4,a4,1
    800062d6:	fe979be3          	bne	a5,s1,800062cc <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    800062da:	57fd                	li	a5,-1
    800062dc:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    800062de:	01205d63          	blez	s2,800062f8 <virtio_disk_rw+0xa2>
    800062e2:	8dce                	mv	s11,s3
        free_desc(idx[j]);
    800062e4:	000a2503          	lw	a0,0(s4)
    800062e8:	00000097          	auipc	ra,0x0
    800062ec:	d8e080e7          	jalr	-626(ra) # 80006076 <free_desc>
      for(int j = 0; j < i; j++)
    800062f0:	2d85                	addiw	s11,s11,1
    800062f2:	0a11                	addi	s4,s4,4
    800062f4:	ffb918e3          	bne	s2,s11,800062e4 <virtio_disk_rw+0x8e>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    800062f8:	0041f597          	auipc	a1,0x41f
    800062fc:	e3058593          	addi	a1,a1,-464 # 80425128 <disk+0x2128>
    80006300:	0041f517          	auipc	a0,0x41f
    80006304:	d1850513          	addi	a0,a0,-744 # 80425018 <disk+0x2018>
    80006308:	ffffc097          	auipc	ra,0xffffc
    8000630c:	e68080e7          	jalr	-408(ra) # 80002170 <sleep>
  for(int i = 0; i < 3; i++){
    80006310:	f8040a13          	addi	s4,s0,-128
{
    80006314:	8652                	mv	a2,s4
  for(int i = 0; i < 3; i++){
    80006316:	894e                	mv	s2,s3
    80006318:	b765                	j	800062c0 <virtio_disk_rw+0x6a>
  disk.desc[idx[0]].next = idx[1];

  disk.desc[idx[1]].addr = (uint64) b->data;
  disk.desc[idx[1]].len = BSIZE;
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
    8000631a:	0041f697          	auipc	a3,0x41f
    8000631e:	ce66b683          	ld	a3,-794(a3) # 80425000 <disk+0x2000>
    80006322:	96ba                	add	a3,a3,a4
    80006324:	00069623          	sh	zero,12(a3)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80006328:	0041d817          	auipc	a6,0x41d
    8000632c:	cd880813          	addi	a6,a6,-808 # 80423000 <disk>
    80006330:	0041f697          	auipc	a3,0x41f
    80006334:	cd068693          	addi	a3,a3,-816 # 80425000 <disk+0x2000>
    80006338:	6290                	ld	a2,0(a3)
    8000633a:	963a                	add	a2,a2,a4
    8000633c:	00c65583          	lhu	a1,12(a2) # 200c <_entry-0x7fffdff4>
    80006340:	0015e593          	ori	a1,a1,1
    80006344:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[1]].next = idx[2];
    80006348:	f8842603          	lw	a2,-120(s0)
    8000634c:	628c                	ld	a1,0(a3)
    8000634e:	972e                	add	a4,a4,a1
    80006350:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80006354:	20050593          	addi	a1,a0,512
    80006358:	0592                	slli	a1,a1,0x4
    8000635a:	95c2                	add	a1,a1,a6
    8000635c:	577d                	li	a4,-1
    8000635e:	02e58823          	sb	a4,48(a1)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80006362:	00461713          	slli	a4,a2,0x4
    80006366:	6290                	ld	a2,0(a3)
    80006368:	963a                	add	a2,a2,a4
    8000636a:	03078793          	addi	a5,a5,48
    8000636e:	97c2                	add	a5,a5,a6
    80006370:	e21c                	sd	a5,0(a2)
  disk.desc[idx[2]].len = 1;
    80006372:	629c                	ld	a5,0(a3)
    80006374:	97ba                	add	a5,a5,a4
    80006376:	4605                	li	a2,1
    80006378:	c790                	sw	a2,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    8000637a:	629c                	ld	a5,0(a3)
    8000637c:	97ba                	add	a5,a5,a4
    8000637e:	4809                	li	a6,2
    80006380:	01079623          	sh	a6,12(a5)
  disk.desc[idx[2]].next = 0;
    80006384:	629c                	ld	a5,0(a3)
    80006386:	973e                	add	a4,a4,a5
    80006388:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000638c:	00caa223          	sw	a2,4(s5)
  disk.info[idx[0]].b = b;
    80006390:	0355b423          	sd	s5,40(a1)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80006394:	6698                	ld	a4,8(a3)
    80006396:	00275783          	lhu	a5,2(a4)
    8000639a:	8b9d                	andi	a5,a5,7
    8000639c:	0786                	slli	a5,a5,0x1
    8000639e:	97ba                	add	a5,a5,a4
    800063a0:	00a79223          	sh	a0,4(a5)

  __sync_synchronize();
    800063a4:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    800063a8:	6698                	ld	a4,8(a3)
    800063aa:	00275783          	lhu	a5,2(a4)
    800063ae:	2785                	addiw	a5,a5,1
    800063b0:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    800063b4:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    800063b8:	100017b7          	lui	a5,0x10001
    800063bc:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    800063c0:	004aa783          	lw	a5,4(s5)
    800063c4:	02c79163          	bne	a5,a2,800063e6 <virtio_disk_rw+0x190>
    sleep(b, &disk.vdisk_lock);
    800063c8:	0041f917          	auipc	s2,0x41f
    800063cc:	d6090913          	addi	s2,s2,-672 # 80425128 <disk+0x2128>
  while(b->disk == 1) {
    800063d0:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    800063d2:	85ca                	mv	a1,s2
    800063d4:	8556                	mv	a0,s5
    800063d6:	ffffc097          	auipc	ra,0xffffc
    800063da:	d9a080e7          	jalr	-614(ra) # 80002170 <sleep>
  while(b->disk == 1) {
    800063de:	004aa783          	lw	a5,4(s5)
    800063e2:	fe9788e3          	beq	a5,s1,800063d2 <virtio_disk_rw+0x17c>
  }

  disk.info[idx[0]].b = 0;
    800063e6:	f8042903          	lw	s2,-128(s0)
    800063ea:	20090793          	addi	a5,s2,512
    800063ee:	00479713          	slli	a4,a5,0x4
    800063f2:	0041d797          	auipc	a5,0x41d
    800063f6:	c0e78793          	addi	a5,a5,-1010 # 80423000 <disk>
    800063fa:	97ba                	add	a5,a5,a4
    800063fc:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    80006400:	0041f997          	auipc	s3,0x41f
    80006404:	c0098993          	addi	s3,s3,-1024 # 80425000 <disk+0x2000>
    80006408:	00491713          	slli	a4,s2,0x4
    8000640c:	0009b783          	ld	a5,0(s3)
    80006410:	97ba                	add	a5,a5,a4
    80006412:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80006416:	854a                	mv	a0,s2
    80006418:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    8000641c:	00000097          	auipc	ra,0x0
    80006420:	c5a080e7          	jalr	-934(ra) # 80006076 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80006424:	8885                	andi	s1,s1,1
    80006426:	f0ed                	bnez	s1,80006408 <virtio_disk_rw+0x1b2>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80006428:	0041f517          	auipc	a0,0x41f
    8000642c:	d0050513          	addi	a0,a0,-768 # 80425128 <disk+0x2128>
    80006430:	ffffb097          	auipc	ra,0xffffb
    80006434:	854080e7          	jalr	-1964(ra) # 80000c84 <release>
}
    80006438:	70e6                	ld	ra,120(sp)
    8000643a:	7446                	ld	s0,112(sp)
    8000643c:	74a6                	ld	s1,104(sp)
    8000643e:	7906                	ld	s2,96(sp)
    80006440:	69e6                	ld	s3,88(sp)
    80006442:	6a46                	ld	s4,80(sp)
    80006444:	6aa6                	ld	s5,72(sp)
    80006446:	6b06                	ld	s6,64(sp)
    80006448:	7be2                	ld	s7,56(sp)
    8000644a:	7c42                	ld	s8,48(sp)
    8000644c:	7ca2                	ld	s9,40(sp)
    8000644e:	7d02                	ld	s10,32(sp)
    80006450:	6de2                	ld	s11,24(sp)
    80006452:	6109                	addi	sp,sp,128
    80006454:	8082                	ret
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80006456:	f8042503          	lw	a0,-128(s0)
    8000645a:	20050793          	addi	a5,a0,512
    8000645e:	0792                	slli	a5,a5,0x4
  if(write)
    80006460:	0041d817          	auipc	a6,0x41d
    80006464:	ba080813          	addi	a6,a6,-1120 # 80423000 <disk>
    80006468:	00f80733          	add	a4,a6,a5
    8000646c:	01a036b3          	snez	a3,s10
    80006470:	0ad72423          	sw	a3,168(a4)
  buf0->reserved = 0;
    80006474:	0a072623          	sw	zero,172(a4)
  buf0->sector = sector;
    80006478:	0b973823          	sd	s9,176(a4)
  disk.desc[idx[0]].addr = (uint64) buf0;
    8000647c:	7679                	lui	a2,0xffffe
    8000647e:	963e                	add	a2,a2,a5
    80006480:	0041f697          	auipc	a3,0x41f
    80006484:	b8068693          	addi	a3,a3,-1152 # 80425000 <disk+0x2000>
    80006488:	6298                	ld	a4,0(a3)
    8000648a:	9732                	add	a4,a4,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    8000648c:	0a878593          	addi	a1,a5,168
    80006490:	95c2                	add	a1,a1,a6
  disk.desc[idx[0]].addr = (uint64) buf0;
    80006492:	e30c                	sd	a1,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80006494:	6298                	ld	a4,0(a3)
    80006496:	9732                	add	a4,a4,a2
    80006498:	45c1                	li	a1,16
    8000649a:	c70c                	sw	a1,8(a4)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    8000649c:	6298                	ld	a4,0(a3)
    8000649e:	9732                	add	a4,a4,a2
    800064a0:	4585                	li	a1,1
    800064a2:	00b71623          	sh	a1,12(a4)
  disk.desc[idx[0]].next = idx[1];
    800064a6:	f8442703          	lw	a4,-124(s0)
    800064aa:	628c                	ld	a1,0(a3)
    800064ac:	962e                	add	a2,a2,a1
    800064ae:	00e61723          	sh	a4,14(a2) # ffffffffffffe00e <end+0xffffffff7fbd800e>
  disk.desc[idx[1]].addr = (uint64) b->data;
    800064b2:	0712                	slli	a4,a4,0x4
    800064b4:	6290                	ld	a2,0(a3)
    800064b6:	963a                	add	a2,a2,a4
    800064b8:	058a8593          	addi	a1,s5,88
    800064bc:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    800064be:	6294                	ld	a3,0(a3)
    800064c0:	96ba                	add	a3,a3,a4
    800064c2:	40000613          	li	a2,1024
    800064c6:	c690                	sw	a2,8(a3)
  if(write)
    800064c8:	e40d19e3          	bnez	s10,8000631a <virtio_disk_rw+0xc4>
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    800064cc:	0041f697          	auipc	a3,0x41f
    800064d0:	b346b683          	ld	a3,-1228(a3) # 80425000 <disk+0x2000>
    800064d4:	96ba                	add	a3,a3,a4
    800064d6:	4609                	li	a2,2
    800064d8:	00c69623          	sh	a2,12(a3)
    800064dc:	b5b1                	j	80006328 <virtio_disk_rw+0xd2>

00000000800064de <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800064de:	1101                	addi	sp,sp,-32
    800064e0:	ec06                	sd	ra,24(sp)
    800064e2:	e822                	sd	s0,16(sp)
    800064e4:	e426                	sd	s1,8(sp)
    800064e6:	e04a                	sd	s2,0(sp)
    800064e8:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    800064ea:	0041f517          	auipc	a0,0x41f
    800064ee:	c3e50513          	addi	a0,a0,-962 # 80425128 <disk+0x2128>
    800064f2:	ffffa097          	auipc	ra,0xffffa
    800064f6:	6de080e7          	jalr	1758(ra) # 80000bd0 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800064fa:	10001737          	lui	a4,0x10001
    800064fe:	533c                	lw	a5,96(a4)
    80006500:	8b8d                	andi	a5,a5,3
    80006502:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80006504:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80006508:	0041f797          	auipc	a5,0x41f
    8000650c:	af878793          	addi	a5,a5,-1288 # 80425000 <disk+0x2000>
    80006510:	6b94                	ld	a3,16(a5)
    80006512:	0207d703          	lhu	a4,32(a5)
    80006516:	0026d783          	lhu	a5,2(a3)
    8000651a:	06f70163          	beq	a4,a5,8000657c <virtio_disk_intr+0x9e>
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000651e:	0041d917          	auipc	s2,0x41d
    80006522:	ae290913          	addi	s2,s2,-1310 # 80423000 <disk>
    80006526:	0041f497          	auipc	s1,0x41f
    8000652a:	ada48493          	addi	s1,s1,-1318 # 80425000 <disk+0x2000>
    __sync_synchronize();
    8000652e:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80006532:	6898                	ld	a4,16(s1)
    80006534:	0204d783          	lhu	a5,32(s1)
    80006538:	8b9d                	andi	a5,a5,7
    8000653a:	078e                	slli	a5,a5,0x3
    8000653c:	97ba                	add	a5,a5,a4
    8000653e:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80006540:	20078713          	addi	a4,a5,512
    80006544:	0712                	slli	a4,a4,0x4
    80006546:	974a                	add	a4,a4,s2
    80006548:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    8000654c:	e731                	bnez	a4,80006598 <virtio_disk_intr+0xba>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    8000654e:	20078793          	addi	a5,a5,512
    80006552:	0792                	slli	a5,a5,0x4
    80006554:	97ca                	add	a5,a5,s2
    80006556:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80006558:	00052223          	sw	zero,4(a0)
    wakeup(b);
    8000655c:	ffffc097          	auipc	ra,0xffffc
    80006560:	dbc080e7          	jalr	-580(ra) # 80002318 <wakeup>

    disk.used_idx += 1;
    80006564:	0204d783          	lhu	a5,32(s1)
    80006568:	2785                	addiw	a5,a5,1
    8000656a:	17c2                	slli	a5,a5,0x30
    8000656c:	93c1                	srli	a5,a5,0x30
    8000656e:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80006572:	6898                	ld	a4,16(s1)
    80006574:	00275703          	lhu	a4,2(a4)
    80006578:	faf71be3          	bne	a4,a5,8000652e <virtio_disk_intr+0x50>
  }

  release(&disk.vdisk_lock);
    8000657c:	0041f517          	auipc	a0,0x41f
    80006580:	bac50513          	addi	a0,a0,-1108 # 80425128 <disk+0x2128>
    80006584:	ffffa097          	auipc	ra,0xffffa
    80006588:	700080e7          	jalr	1792(ra) # 80000c84 <release>
}
    8000658c:	60e2                	ld	ra,24(sp)
    8000658e:	6442                	ld	s0,16(sp)
    80006590:	64a2                	ld	s1,8(sp)
    80006592:	6902                	ld	s2,0(sp)
    80006594:	6105                	addi	sp,sp,32
    80006596:	8082                	ret
      panic("virtio_disk_intr status");
    80006598:	00002517          	auipc	a0,0x2
    8000659c:	2e850513          	addi	a0,a0,744 # 80008880 <syscalls+0x3c0>
    800065a0:	ffffa097          	auipc	ra,0xffffa
    800065a4:	f98080e7          	jalr	-104(ra) # 80000538 <panic>
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
