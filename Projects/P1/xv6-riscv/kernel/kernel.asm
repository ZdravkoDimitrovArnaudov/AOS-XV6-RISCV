
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	87013103          	ld	sp,-1936(sp) # 80008870 <_GLOBAL_OFFSET_TABLE_+0x8>
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
    80000068:	b1c78793          	addi	a5,a5,-1252 # 80005b80 <timervec>
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
    80000130:	324080e7          	jalr	804(ra) # 80002450 <either_copyin>
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
    800001d4:	e86080e7          	jalr	-378(ra) # 80002056 <sleep>
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
    80000210:	1ee080e7          	jalr	494(ra) # 800023fa <either_copyout>
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
    800002f0:	1ba080e7          	jalr	442(ra) # 800024a6 <procdump>
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
    80000444:	da2080e7          	jalr	-606(ra) # 800021e2 <wakeup>
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
    80000476:	ea678793          	addi	a5,a5,-346 # 80021318 <devsw>
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
    80000890:	956080e7          	jalr	-1706(ra) # 800021e2 <wakeup>
    
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
    8000091c:	73e080e7          	jalr	1854(ra) # 80002056 <sleep>
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
    80000eb8:	00001097          	auipc	ra,0x1
    80000ebc:	784080e7          	jalr	1924(ra) # 8000263c <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000ec0:	00005097          	auipc	ra,0x5
    80000ec4:	d00080e7          	jalr	-768(ra) # 80005bc0 <plicinithart>
  }

  scheduler();        
    80000ec8:	00001097          	auipc	ra,0x1
    80000ecc:	fdc080e7          	jalr	-36(ra) # 80001ea4 <scheduler>
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
    80000f30:	00001097          	auipc	ra,0x1
    80000f34:	6e4080e7          	jalr	1764(ra) # 80002614 <trapinit>
    trapinithart();  // install kernel trap vector
    80000f38:	00001097          	auipc	ra,0x1
    80000f3c:	704080e7          	jalr	1796(ra) # 8000263c <trapinithart>
    plicinit();      // set up interrupt controller
    80000f40:	00005097          	auipc	ra,0x5
    80000f44:	c6a080e7          	jalr	-918(ra) # 80005baa <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000f48:	00005097          	auipc	ra,0x5
    80000f4c:	c78080e7          	jalr	-904(ra) # 80005bc0 <plicinithart>
    binit();         // buffer cache
    80000f50:	00002097          	auipc	ra,0x2
    80000f54:	e44080e7          	jalr	-444(ra) # 80002d94 <binit>
    iinit();         // inode table
    80000f58:	00002097          	auipc	ra,0x2
    80000f5c:	4d4080e7          	jalr	1236(ra) # 8000342c <iinit>
    fileinit();      // file table
    80000f60:	00003097          	auipc	ra,0x3
    80000f64:	47e080e7          	jalr	1150(ra) # 800043de <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000f68:	00005097          	auipc	ra,0x5
    80000f6c:	d7a080e7          	jalr	-646(ra) # 80005ce2 <virtio_disk_init>
    userinit();      // first user process
    80000f70:	00001097          	auipc	ra,0x1
    80000f74:	cfe080e7          	jalr	-770(ra) # 80001c6e <userinit>
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
    80001858:	87ca0a13          	addi	s4,s4,-1924 # 800170d0 <tickslock>
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
    8000188e:	16848493          	addi	s1,s1,360
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
    80001920:	00015997          	auipc	s3,0x15
    80001924:	7b098993          	addi	s3,s3,1968 # 800170d0 <tickslock>
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
    8000194c:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    8000194e:	16848493          	addi	s1,s1,360
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
    800019f4:	c64080e7          	jalr	-924(ra) # 80002654 <usertrapret>
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
    80001a0e:	9a2080e7          	jalr	-1630(ra) # 800033ac <fsinit>
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
    80001bb4:	00015917          	auipc	s2,0x15
    80001bb8:	51c90913          	addi	s2,s2,1308 # 800170d0 <tickslock>
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
    80001bd4:	16848493          	addi	s1,s1,360
    80001bd8:	ff2492e3          	bne	s1,s2,80001bbc <allocproc+0x1c>
  return 0;
    80001bdc:	4481                	li	s1,0
    80001bde:	a889                	j	80001c30 <allocproc+0x90>
  p->pid = allocpid();
    80001be0:	00000097          	auipc	ra,0x0
    80001be4:	e34080e7          	jalr	-460(ra) # 80001a14 <allocpid>
    80001be8:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001bea:	4785                	li	a5,1
    80001bec:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001bee:	fffff097          	auipc	ra,0xfffff
    80001bf2:	ef2080e7          	jalr	-270(ra) # 80000ae0 <kalloc>
    80001bf6:	892a                	mv	s2,a0
    80001bf8:	eca8                	sd	a0,88(s1)
    80001bfa:	c131                	beqz	a0,80001c3e <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    80001bfc:	8526                	mv	a0,s1
    80001bfe:	00000097          	auipc	ra,0x0
    80001c02:	e5c080e7          	jalr	-420(ra) # 80001a5a <proc_pagetable>
    80001c06:	892a                	mv	s2,a0
    80001c08:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    80001c0a:	c531                	beqz	a0,80001c56 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    80001c0c:	07000613          	li	a2,112
    80001c10:	4581                	li	a1,0
    80001c12:	06048513          	addi	a0,s1,96
    80001c16:	fffff097          	auipc	ra,0xfffff
    80001c1a:	0b6080e7          	jalr	182(ra) # 80000ccc <memset>
  p->context.ra = (uint64)forkret;
    80001c1e:	00000797          	auipc	a5,0x0
    80001c22:	db078793          	addi	a5,a5,-592 # 800019ce <forkret>
    80001c26:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001c28:	60bc                	ld	a5,64(s1)
    80001c2a:	6705                	lui	a4,0x1
    80001c2c:	97ba                	add	a5,a5,a4
    80001c2e:	f4bc                	sd	a5,104(s1)
}
    80001c30:	8526                	mv	a0,s1
    80001c32:	60e2                	ld	ra,24(sp)
    80001c34:	6442                	ld	s0,16(sp)
    80001c36:	64a2                	ld	s1,8(sp)
    80001c38:	6902                	ld	s2,0(sp)
    80001c3a:	6105                	addi	sp,sp,32
    80001c3c:	8082                	ret
    freeproc(p);
    80001c3e:	8526                	mv	a0,s1
    80001c40:	00000097          	auipc	ra,0x0
    80001c44:	f08080e7          	jalr	-248(ra) # 80001b48 <freeproc>
    release(&p->lock);
    80001c48:	8526                	mv	a0,s1
    80001c4a:	fffff097          	auipc	ra,0xfffff
    80001c4e:	03a080e7          	jalr	58(ra) # 80000c84 <release>
    return 0;
    80001c52:	84ca                	mv	s1,s2
    80001c54:	bff1                	j	80001c30 <allocproc+0x90>
    freeproc(p);
    80001c56:	8526                	mv	a0,s1
    80001c58:	00000097          	auipc	ra,0x0
    80001c5c:	ef0080e7          	jalr	-272(ra) # 80001b48 <freeproc>
    release(&p->lock);
    80001c60:	8526                	mv	a0,s1
    80001c62:	fffff097          	auipc	ra,0xfffff
    80001c66:	022080e7          	jalr	34(ra) # 80000c84 <release>
    return 0;
    80001c6a:	84ca                	mv	s1,s2
    80001c6c:	b7d1                	j	80001c30 <allocproc+0x90>

0000000080001c6e <userinit>:
{
    80001c6e:	1101                	addi	sp,sp,-32
    80001c70:	ec06                	sd	ra,24(sp)
    80001c72:	e822                	sd	s0,16(sp)
    80001c74:	e426                	sd	s1,8(sp)
    80001c76:	1000                	addi	s0,sp,32
  p = allocproc();
    80001c78:	00000097          	auipc	ra,0x0
    80001c7c:	f28080e7          	jalr	-216(ra) # 80001ba0 <allocproc>
    80001c80:	84aa                	mv	s1,a0
  initproc = p;
    80001c82:	00007797          	auipc	a5,0x7
    80001c86:	3aa7b323          	sd	a0,934(a5) # 80009028 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80001c8a:	03400613          	li	a2,52
    80001c8e:	00007597          	auipc	a1,0x7
    80001c92:	ba258593          	addi	a1,a1,-1118 # 80008830 <initcode>
    80001c96:	6928                	ld	a0,80(a0)
    80001c98:	fffff097          	auipc	ra,0xfffff
    80001c9c:	6b4080e7          	jalr	1716(ra) # 8000134c <uvminit>
  p->sz = PGSIZE;
    80001ca0:	6785                	lui	a5,0x1
    80001ca2:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001ca4:	6cb8                	ld	a4,88(s1)
    80001ca6:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001caa:	6cb8                	ld	a4,88(s1)
    80001cac:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001cae:	4641                	li	a2,16
    80001cb0:	00006597          	auipc	a1,0x6
    80001cb4:	55058593          	addi	a1,a1,1360 # 80008200 <digits+0x1c0>
    80001cb8:	15848513          	addi	a0,s1,344
    80001cbc:	fffff097          	auipc	ra,0xfffff
    80001cc0:	15a080e7          	jalr	346(ra) # 80000e16 <safestrcpy>
  p->cwd = namei("/");
    80001cc4:	00006517          	auipc	a0,0x6
    80001cc8:	54c50513          	addi	a0,a0,1356 # 80008210 <digits+0x1d0>
    80001ccc:	00002097          	auipc	ra,0x2
    80001cd0:	10e080e7          	jalr	270(ra) # 80003dda <namei>
    80001cd4:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001cd8:	478d                	li	a5,3
    80001cda:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001cdc:	8526                	mv	a0,s1
    80001cde:	fffff097          	auipc	ra,0xfffff
    80001ce2:	fa6080e7          	jalr	-90(ra) # 80000c84 <release>
}
    80001ce6:	60e2                	ld	ra,24(sp)
    80001ce8:	6442                	ld	s0,16(sp)
    80001cea:	64a2                	ld	s1,8(sp)
    80001cec:	6105                	addi	sp,sp,32
    80001cee:	8082                	ret

0000000080001cf0 <growproc>:
{
    80001cf0:	1101                	addi	sp,sp,-32
    80001cf2:	ec06                	sd	ra,24(sp)
    80001cf4:	e822                	sd	s0,16(sp)
    80001cf6:	e426                	sd	s1,8(sp)
    80001cf8:	e04a                	sd	s2,0(sp)
    80001cfa:	1000                	addi	s0,sp,32
    80001cfc:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001cfe:	00000097          	auipc	ra,0x0
    80001d02:	c98080e7          	jalr	-872(ra) # 80001996 <myproc>
    80001d06:	892a                	mv	s2,a0
  sz = p->sz;
    80001d08:	652c                	ld	a1,72(a0)
    80001d0a:	0005861b          	sext.w	a2,a1
  if(n > 0){
    80001d0e:	00904f63          	bgtz	s1,80001d2c <growproc+0x3c>
  } else if(n < 0){
    80001d12:	0204cc63          	bltz	s1,80001d4a <growproc+0x5a>
  p->sz = sz;
    80001d16:	1602                	slli	a2,a2,0x20
    80001d18:	9201                	srli	a2,a2,0x20
    80001d1a:	04c93423          	sd	a2,72(s2)
  return 0;
    80001d1e:	4501                	li	a0,0
}
    80001d20:	60e2                	ld	ra,24(sp)
    80001d22:	6442                	ld	s0,16(sp)
    80001d24:	64a2                	ld	s1,8(sp)
    80001d26:	6902                	ld	s2,0(sp)
    80001d28:	6105                	addi	sp,sp,32
    80001d2a:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80001d2c:	9e25                	addw	a2,a2,s1
    80001d2e:	1602                	slli	a2,a2,0x20
    80001d30:	9201                	srli	a2,a2,0x20
    80001d32:	1582                	slli	a1,a1,0x20
    80001d34:	9181                	srli	a1,a1,0x20
    80001d36:	6928                	ld	a0,80(a0)
    80001d38:	fffff097          	auipc	ra,0xfffff
    80001d3c:	6ce080e7          	jalr	1742(ra) # 80001406 <uvmalloc>
    80001d40:	0005061b          	sext.w	a2,a0
    80001d44:	fa69                	bnez	a2,80001d16 <growproc+0x26>
      return -1;
    80001d46:	557d                	li	a0,-1
    80001d48:	bfe1                	j	80001d20 <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001d4a:	9e25                	addw	a2,a2,s1
    80001d4c:	1602                	slli	a2,a2,0x20
    80001d4e:	9201                	srli	a2,a2,0x20
    80001d50:	1582                	slli	a1,a1,0x20
    80001d52:	9181                	srli	a1,a1,0x20
    80001d54:	6928                	ld	a0,80(a0)
    80001d56:	fffff097          	auipc	ra,0xfffff
    80001d5a:	668080e7          	jalr	1640(ra) # 800013be <uvmdealloc>
    80001d5e:	0005061b          	sext.w	a2,a0
    80001d62:	bf55                	j	80001d16 <growproc+0x26>

0000000080001d64 <fork>:
{
    80001d64:	7139                	addi	sp,sp,-64
    80001d66:	fc06                	sd	ra,56(sp)
    80001d68:	f822                	sd	s0,48(sp)
    80001d6a:	f426                	sd	s1,40(sp)
    80001d6c:	f04a                	sd	s2,32(sp)
    80001d6e:	ec4e                	sd	s3,24(sp)
    80001d70:	e852                	sd	s4,16(sp)
    80001d72:	e456                	sd	s5,8(sp)
    80001d74:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001d76:	00000097          	auipc	ra,0x0
    80001d7a:	c20080e7          	jalr	-992(ra) # 80001996 <myproc>
    80001d7e:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001d80:	00000097          	auipc	ra,0x0
    80001d84:	e20080e7          	jalr	-480(ra) # 80001ba0 <allocproc>
    80001d88:	10050c63          	beqz	a0,80001ea0 <fork+0x13c>
    80001d8c:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001d8e:	048ab603          	ld	a2,72(s5)
    80001d92:	692c                	ld	a1,80(a0)
    80001d94:	050ab503          	ld	a0,80(s5)
    80001d98:	fffff097          	auipc	ra,0xfffff
    80001d9c:	7ba080e7          	jalr	1978(ra) # 80001552 <uvmcopy>
    80001da0:	04054863          	bltz	a0,80001df0 <fork+0x8c>
  np->sz = p->sz;
    80001da4:	048ab783          	ld	a5,72(s5)
    80001da8:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    80001dac:	058ab683          	ld	a3,88(s5)
    80001db0:	87b6                	mv	a5,a3
    80001db2:	058a3703          	ld	a4,88(s4)
    80001db6:	12068693          	addi	a3,a3,288
    80001dba:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001dbe:	6788                	ld	a0,8(a5)
    80001dc0:	6b8c                	ld	a1,16(a5)
    80001dc2:	6f90                	ld	a2,24(a5)
    80001dc4:	01073023          	sd	a6,0(a4)
    80001dc8:	e708                	sd	a0,8(a4)
    80001dca:	eb0c                	sd	a1,16(a4)
    80001dcc:	ef10                	sd	a2,24(a4)
    80001dce:	02078793          	addi	a5,a5,32
    80001dd2:	02070713          	addi	a4,a4,32
    80001dd6:	fed792e3          	bne	a5,a3,80001dba <fork+0x56>
  np->trapframe->a0 = 0;
    80001dda:	058a3783          	ld	a5,88(s4)
    80001dde:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001de2:	0d0a8493          	addi	s1,s5,208
    80001de6:	0d0a0913          	addi	s2,s4,208
    80001dea:	150a8993          	addi	s3,s5,336
    80001dee:	a00d                	j	80001e10 <fork+0xac>
    freeproc(np);
    80001df0:	8552                	mv	a0,s4
    80001df2:	00000097          	auipc	ra,0x0
    80001df6:	d56080e7          	jalr	-682(ra) # 80001b48 <freeproc>
    release(&np->lock);
    80001dfa:	8552                	mv	a0,s4
    80001dfc:	fffff097          	auipc	ra,0xfffff
    80001e00:	e88080e7          	jalr	-376(ra) # 80000c84 <release>
    return -1;
    80001e04:	597d                	li	s2,-1
    80001e06:	a059                	j	80001e8c <fork+0x128>
  for(i = 0; i < NOFILE; i++)
    80001e08:	04a1                	addi	s1,s1,8
    80001e0a:	0921                	addi	s2,s2,8
    80001e0c:	01348b63          	beq	s1,s3,80001e22 <fork+0xbe>
    if(p->ofile[i])
    80001e10:	6088                	ld	a0,0(s1)
    80001e12:	d97d                	beqz	a0,80001e08 <fork+0xa4>
      np->ofile[i] = filedup(p->ofile[i]);
    80001e14:	00002097          	auipc	ra,0x2
    80001e18:	65c080e7          	jalr	1628(ra) # 80004470 <filedup>
    80001e1c:	00a93023          	sd	a0,0(s2)
    80001e20:	b7e5                	j	80001e08 <fork+0xa4>
  np->cwd = idup(p->cwd);
    80001e22:	150ab503          	ld	a0,336(s5)
    80001e26:	00001097          	auipc	ra,0x1
    80001e2a:	7c0080e7          	jalr	1984(ra) # 800035e6 <idup>
    80001e2e:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001e32:	4641                	li	a2,16
    80001e34:	158a8593          	addi	a1,s5,344
    80001e38:	158a0513          	addi	a0,s4,344
    80001e3c:	fffff097          	auipc	ra,0xfffff
    80001e40:	fda080e7          	jalr	-38(ra) # 80000e16 <safestrcpy>
  pid = np->pid;
    80001e44:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    80001e48:	8552                	mv	a0,s4
    80001e4a:	fffff097          	auipc	ra,0xfffff
    80001e4e:	e3a080e7          	jalr	-454(ra) # 80000c84 <release>
  acquire(&wait_lock);
    80001e52:	0000f497          	auipc	s1,0xf
    80001e56:	46648493          	addi	s1,s1,1126 # 800112b8 <wait_lock>
    80001e5a:	8526                	mv	a0,s1
    80001e5c:	fffff097          	auipc	ra,0xfffff
    80001e60:	d74080e7          	jalr	-652(ra) # 80000bd0 <acquire>
  np->parent = p;
    80001e64:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001e68:	8526                	mv	a0,s1
    80001e6a:	fffff097          	auipc	ra,0xfffff
    80001e6e:	e1a080e7          	jalr	-486(ra) # 80000c84 <release>
  acquire(&np->lock);
    80001e72:	8552                	mv	a0,s4
    80001e74:	fffff097          	auipc	ra,0xfffff
    80001e78:	d5c080e7          	jalr	-676(ra) # 80000bd0 <acquire>
  np->state = RUNNABLE;
    80001e7c:	478d                	li	a5,3
    80001e7e:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001e82:	8552                	mv	a0,s4
    80001e84:	fffff097          	auipc	ra,0xfffff
    80001e88:	e00080e7          	jalr	-512(ra) # 80000c84 <release>
}
    80001e8c:	854a                	mv	a0,s2
    80001e8e:	70e2                	ld	ra,56(sp)
    80001e90:	7442                	ld	s0,48(sp)
    80001e92:	74a2                	ld	s1,40(sp)
    80001e94:	7902                	ld	s2,32(sp)
    80001e96:	69e2                	ld	s3,24(sp)
    80001e98:	6a42                	ld	s4,16(sp)
    80001e9a:	6aa2                	ld	s5,8(sp)
    80001e9c:	6121                	addi	sp,sp,64
    80001e9e:	8082                	ret
    return -1;
    80001ea0:	597d                	li	s2,-1
    80001ea2:	b7ed                	j	80001e8c <fork+0x128>

0000000080001ea4 <scheduler>:
{
    80001ea4:	7139                	addi	sp,sp,-64
    80001ea6:	fc06                	sd	ra,56(sp)
    80001ea8:	f822                	sd	s0,48(sp)
    80001eaa:	f426                	sd	s1,40(sp)
    80001eac:	f04a                	sd	s2,32(sp)
    80001eae:	ec4e                	sd	s3,24(sp)
    80001eb0:	e852                	sd	s4,16(sp)
    80001eb2:	e456                	sd	s5,8(sp)
    80001eb4:	e05a                	sd	s6,0(sp)
    80001eb6:	0080                	addi	s0,sp,64
    80001eb8:	8792                	mv	a5,tp
  int id = r_tp();
    80001eba:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001ebc:	00779a93          	slli	s5,a5,0x7
    80001ec0:	0000f717          	auipc	a4,0xf
    80001ec4:	3e070713          	addi	a4,a4,992 # 800112a0 <pid_lock>
    80001ec8:	9756                	add	a4,a4,s5
    80001eca:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001ece:	0000f717          	auipc	a4,0xf
    80001ed2:	40a70713          	addi	a4,a4,1034 # 800112d8 <cpus+0x8>
    80001ed6:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    80001ed8:	498d                	li	s3,3
        p->state = RUNNING;
    80001eda:	4b11                	li	s6,4
        c->proc = p;
    80001edc:	079e                	slli	a5,a5,0x7
    80001ede:	0000fa17          	auipc	s4,0xf
    80001ee2:	3c2a0a13          	addi	s4,s4,962 # 800112a0 <pid_lock>
    80001ee6:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001ee8:	00015917          	auipc	s2,0x15
    80001eec:	1e890913          	addi	s2,s2,488 # 800170d0 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001ef0:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001ef4:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001ef8:	10079073          	csrw	sstatus,a5
    80001efc:	0000f497          	auipc	s1,0xf
    80001f00:	7d448493          	addi	s1,s1,2004 # 800116d0 <proc>
    80001f04:	a811                	j	80001f18 <scheduler+0x74>
      release(&p->lock);
    80001f06:	8526                	mv	a0,s1
    80001f08:	fffff097          	auipc	ra,0xfffff
    80001f0c:	d7c080e7          	jalr	-644(ra) # 80000c84 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001f10:	16848493          	addi	s1,s1,360
    80001f14:	fd248ee3          	beq	s1,s2,80001ef0 <scheduler+0x4c>
      acquire(&p->lock);
    80001f18:	8526                	mv	a0,s1
    80001f1a:	fffff097          	auipc	ra,0xfffff
    80001f1e:	cb6080e7          	jalr	-842(ra) # 80000bd0 <acquire>
      if(p->state == RUNNABLE) {
    80001f22:	4c9c                	lw	a5,24(s1)
    80001f24:	ff3791e3          	bne	a5,s3,80001f06 <scheduler+0x62>
        p->state = RUNNING;
    80001f28:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    80001f2c:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    80001f30:	06048593          	addi	a1,s1,96
    80001f34:	8556                	mv	a0,s5
    80001f36:	00000097          	auipc	ra,0x0
    80001f3a:	674080e7          	jalr	1652(ra) # 800025aa <swtch>
        c->proc = 0;
    80001f3e:	020a3823          	sd	zero,48(s4)
    80001f42:	b7d1                	j	80001f06 <scheduler+0x62>

0000000080001f44 <sched>:
{
    80001f44:	7179                	addi	sp,sp,-48
    80001f46:	f406                	sd	ra,40(sp)
    80001f48:	f022                	sd	s0,32(sp)
    80001f4a:	ec26                	sd	s1,24(sp)
    80001f4c:	e84a                	sd	s2,16(sp)
    80001f4e:	e44e                	sd	s3,8(sp)
    80001f50:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001f52:	00000097          	auipc	ra,0x0
    80001f56:	a44080e7          	jalr	-1468(ra) # 80001996 <myproc>
    80001f5a:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001f5c:	fffff097          	auipc	ra,0xfffff
    80001f60:	bfa080e7          	jalr	-1030(ra) # 80000b56 <holding>
    80001f64:	c93d                	beqz	a0,80001fda <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001f66:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001f68:	2781                	sext.w	a5,a5
    80001f6a:	079e                	slli	a5,a5,0x7
    80001f6c:	0000f717          	auipc	a4,0xf
    80001f70:	33470713          	addi	a4,a4,820 # 800112a0 <pid_lock>
    80001f74:	97ba                	add	a5,a5,a4
    80001f76:	0a87a703          	lw	a4,168(a5)
    80001f7a:	4785                	li	a5,1
    80001f7c:	06f71763          	bne	a4,a5,80001fea <sched+0xa6>
  if(p->state == RUNNING)
    80001f80:	4c98                	lw	a4,24(s1)
    80001f82:	4791                	li	a5,4
    80001f84:	06f70b63          	beq	a4,a5,80001ffa <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f88:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001f8c:	8b89                	andi	a5,a5,2
  if(intr_get())
    80001f8e:	efb5                	bnez	a5,8000200a <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001f90:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001f92:	0000f917          	auipc	s2,0xf
    80001f96:	30e90913          	addi	s2,s2,782 # 800112a0 <pid_lock>
    80001f9a:	2781                	sext.w	a5,a5
    80001f9c:	079e                	slli	a5,a5,0x7
    80001f9e:	97ca                	add	a5,a5,s2
    80001fa0:	0ac7a983          	lw	s3,172(a5)
    80001fa4:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001fa6:	2781                	sext.w	a5,a5
    80001fa8:	079e                	slli	a5,a5,0x7
    80001faa:	0000f597          	auipc	a1,0xf
    80001fae:	32e58593          	addi	a1,a1,814 # 800112d8 <cpus+0x8>
    80001fb2:	95be                	add	a1,a1,a5
    80001fb4:	06048513          	addi	a0,s1,96
    80001fb8:	00000097          	auipc	ra,0x0
    80001fbc:	5f2080e7          	jalr	1522(ra) # 800025aa <swtch>
    80001fc0:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001fc2:	2781                	sext.w	a5,a5
    80001fc4:	079e                	slli	a5,a5,0x7
    80001fc6:	97ca                	add	a5,a5,s2
    80001fc8:	0b37a623          	sw	s3,172(a5)
}
    80001fcc:	70a2                	ld	ra,40(sp)
    80001fce:	7402                	ld	s0,32(sp)
    80001fd0:	64e2                	ld	s1,24(sp)
    80001fd2:	6942                	ld	s2,16(sp)
    80001fd4:	69a2                	ld	s3,8(sp)
    80001fd6:	6145                	addi	sp,sp,48
    80001fd8:	8082                	ret
    panic("sched p->lock");
    80001fda:	00006517          	auipc	a0,0x6
    80001fde:	23e50513          	addi	a0,a0,574 # 80008218 <digits+0x1d8>
    80001fe2:	ffffe097          	auipc	ra,0xffffe
    80001fe6:	556080e7          	jalr	1366(ra) # 80000538 <panic>
    panic("sched locks");
    80001fea:	00006517          	auipc	a0,0x6
    80001fee:	23e50513          	addi	a0,a0,574 # 80008228 <digits+0x1e8>
    80001ff2:	ffffe097          	auipc	ra,0xffffe
    80001ff6:	546080e7          	jalr	1350(ra) # 80000538 <panic>
    panic("sched running");
    80001ffa:	00006517          	auipc	a0,0x6
    80001ffe:	23e50513          	addi	a0,a0,574 # 80008238 <digits+0x1f8>
    80002002:	ffffe097          	auipc	ra,0xffffe
    80002006:	536080e7          	jalr	1334(ra) # 80000538 <panic>
    panic("sched interruptible");
    8000200a:	00006517          	auipc	a0,0x6
    8000200e:	23e50513          	addi	a0,a0,574 # 80008248 <digits+0x208>
    80002012:	ffffe097          	auipc	ra,0xffffe
    80002016:	526080e7          	jalr	1318(ra) # 80000538 <panic>

000000008000201a <yield>:
{
    8000201a:	1101                	addi	sp,sp,-32
    8000201c:	ec06                	sd	ra,24(sp)
    8000201e:	e822                	sd	s0,16(sp)
    80002020:	e426                	sd	s1,8(sp)
    80002022:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80002024:	00000097          	auipc	ra,0x0
    80002028:	972080e7          	jalr	-1678(ra) # 80001996 <myproc>
    8000202c:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000202e:	fffff097          	auipc	ra,0xfffff
    80002032:	ba2080e7          	jalr	-1118(ra) # 80000bd0 <acquire>
  p->state = RUNNABLE;
    80002036:	478d                	li	a5,3
    80002038:	cc9c                	sw	a5,24(s1)
  sched();
    8000203a:	00000097          	auipc	ra,0x0
    8000203e:	f0a080e7          	jalr	-246(ra) # 80001f44 <sched>
  release(&p->lock);
    80002042:	8526                	mv	a0,s1
    80002044:	fffff097          	auipc	ra,0xfffff
    80002048:	c40080e7          	jalr	-960(ra) # 80000c84 <release>
}
    8000204c:	60e2                	ld	ra,24(sp)
    8000204e:	6442                	ld	s0,16(sp)
    80002050:	64a2                	ld	s1,8(sp)
    80002052:	6105                	addi	sp,sp,32
    80002054:	8082                	ret

0000000080002056 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80002056:	7179                	addi	sp,sp,-48
    80002058:	f406                	sd	ra,40(sp)
    8000205a:	f022                	sd	s0,32(sp)
    8000205c:	ec26                	sd	s1,24(sp)
    8000205e:	e84a                	sd	s2,16(sp)
    80002060:	e44e                	sd	s3,8(sp)
    80002062:	1800                	addi	s0,sp,48
    80002064:	89aa                	mv	s3,a0
    80002066:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002068:	00000097          	auipc	ra,0x0
    8000206c:	92e080e7          	jalr	-1746(ra) # 80001996 <myproc>
    80002070:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80002072:	fffff097          	auipc	ra,0xfffff
    80002076:	b5e080e7          	jalr	-1186(ra) # 80000bd0 <acquire>
  release(lk);
    8000207a:	854a                	mv	a0,s2
    8000207c:	fffff097          	auipc	ra,0xfffff
    80002080:	c08080e7          	jalr	-1016(ra) # 80000c84 <release>

  // Go to sleep.
  p->chan = chan;
    80002084:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80002088:	4789                	li	a5,2
    8000208a:	cc9c                	sw	a5,24(s1)

  sched();
    8000208c:	00000097          	auipc	ra,0x0
    80002090:	eb8080e7          	jalr	-328(ra) # 80001f44 <sched>

  // Tidy up.
  p->chan = 0;
    80002094:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    80002098:	8526                	mv	a0,s1
    8000209a:	fffff097          	auipc	ra,0xfffff
    8000209e:	bea080e7          	jalr	-1046(ra) # 80000c84 <release>
  acquire(lk);
    800020a2:	854a                	mv	a0,s2
    800020a4:	fffff097          	auipc	ra,0xfffff
    800020a8:	b2c080e7          	jalr	-1236(ra) # 80000bd0 <acquire>
}
    800020ac:	70a2                	ld	ra,40(sp)
    800020ae:	7402                	ld	s0,32(sp)
    800020b0:	64e2                	ld	s1,24(sp)
    800020b2:	6942                	ld	s2,16(sp)
    800020b4:	69a2                	ld	s3,8(sp)
    800020b6:	6145                	addi	sp,sp,48
    800020b8:	8082                	ret

00000000800020ba <wait>:
{
    800020ba:	715d                	addi	sp,sp,-80
    800020bc:	e486                	sd	ra,72(sp)
    800020be:	e0a2                	sd	s0,64(sp)
    800020c0:	fc26                	sd	s1,56(sp)
    800020c2:	f84a                	sd	s2,48(sp)
    800020c4:	f44e                	sd	s3,40(sp)
    800020c6:	f052                	sd	s4,32(sp)
    800020c8:	ec56                	sd	s5,24(sp)
    800020ca:	e85a                	sd	s6,16(sp)
    800020cc:	e45e                	sd	s7,8(sp)
    800020ce:	e062                	sd	s8,0(sp)
    800020d0:	0880                	addi	s0,sp,80
    800020d2:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    800020d4:	00000097          	auipc	ra,0x0
    800020d8:	8c2080e7          	jalr	-1854(ra) # 80001996 <myproc>
    800020dc:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800020de:	0000f517          	auipc	a0,0xf
    800020e2:	1da50513          	addi	a0,a0,474 # 800112b8 <wait_lock>
    800020e6:	fffff097          	auipc	ra,0xfffff
    800020ea:	aea080e7          	jalr	-1302(ra) # 80000bd0 <acquire>
    havekids = 0;
    800020ee:	4b81                	li	s7,0
        if(np->state == ZOMBIE){
    800020f0:	4a15                	li	s4,5
        havekids = 1;
    800020f2:	4a85                	li	s5,1
    for(np = proc; np < &proc[NPROC]; np++){
    800020f4:	00015997          	auipc	s3,0x15
    800020f8:	fdc98993          	addi	s3,s3,-36 # 800170d0 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800020fc:	0000fc17          	auipc	s8,0xf
    80002100:	1bcc0c13          	addi	s8,s8,444 # 800112b8 <wait_lock>
    havekids = 0;
    80002104:	875e                	mv	a4,s7
    for(np = proc; np < &proc[NPROC]; np++){
    80002106:	0000f497          	auipc	s1,0xf
    8000210a:	5ca48493          	addi	s1,s1,1482 # 800116d0 <proc>
    8000210e:	a0bd                	j	8000217c <wait+0xc2>
          pid = np->pid;
    80002110:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    80002114:	000b0e63          	beqz	s6,80002130 <wait+0x76>
    80002118:	4691                	li	a3,4
    8000211a:	02c48613          	addi	a2,s1,44
    8000211e:	85da                	mv	a1,s6
    80002120:	05093503          	ld	a0,80(s2)
    80002124:	fffff097          	auipc	ra,0xfffff
    80002128:	532080e7          	jalr	1330(ra) # 80001656 <copyout>
    8000212c:	02054563          	bltz	a0,80002156 <wait+0x9c>
          freeproc(np);
    80002130:	8526                	mv	a0,s1
    80002132:	00000097          	auipc	ra,0x0
    80002136:	a16080e7          	jalr	-1514(ra) # 80001b48 <freeproc>
          release(&np->lock);
    8000213a:	8526                	mv	a0,s1
    8000213c:	fffff097          	auipc	ra,0xfffff
    80002140:	b48080e7          	jalr	-1208(ra) # 80000c84 <release>
          release(&wait_lock);
    80002144:	0000f517          	auipc	a0,0xf
    80002148:	17450513          	addi	a0,a0,372 # 800112b8 <wait_lock>
    8000214c:	fffff097          	auipc	ra,0xfffff
    80002150:	b38080e7          	jalr	-1224(ra) # 80000c84 <release>
          return pid;
    80002154:	a09d                	j	800021ba <wait+0x100>
            release(&np->lock);
    80002156:	8526                	mv	a0,s1
    80002158:	fffff097          	auipc	ra,0xfffff
    8000215c:	b2c080e7          	jalr	-1236(ra) # 80000c84 <release>
            release(&wait_lock);
    80002160:	0000f517          	auipc	a0,0xf
    80002164:	15850513          	addi	a0,a0,344 # 800112b8 <wait_lock>
    80002168:	fffff097          	auipc	ra,0xfffff
    8000216c:	b1c080e7          	jalr	-1252(ra) # 80000c84 <release>
            return -1;
    80002170:	59fd                	li	s3,-1
    80002172:	a0a1                	j	800021ba <wait+0x100>
    for(np = proc; np < &proc[NPROC]; np++){
    80002174:	16848493          	addi	s1,s1,360
    80002178:	03348463          	beq	s1,s3,800021a0 <wait+0xe6>
      if(np->parent == p){
    8000217c:	7c9c                	ld	a5,56(s1)
    8000217e:	ff279be3          	bne	a5,s2,80002174 <wait+0xba>
        acquire(&np->lock);
    80002182:	8526                	mv	a0,s1
    80002184:	fffff097          	auipc	ra,0xfffff
    80002188:	a4c080e7          	jalr	-1460(ra) # 80000bd0 <acquire>
        if(np->state == ZOMBIE){
    8000218c:	4c9c                	lw	a5,24(s1)
    8000218e:	f94781e3          	beq	a5,s4,80002110 <wait+0x56>
        release(&np->lock);
    80002192:	8526                	mv	a0,s1
    80002194:	fffff097          	auipc	ra,0xfffff
    80002198:	af0080e7          	jalr	-1296(ra) # 80000c84 <release>
        havekids = 1;
    8000219c:	8756                	mv	a4,s5
    8000219e:	bfd9                	j	80002174 <wait+0xba>
    if(!havekids || p->killed){
    800021a0:	c701                	beqz	a4,800021a8 <wait+0xee>
    800021a2:	02892783          	lw	a5,40(s2)
    800021a6:	c79d                	beqz	a5,800021d4 <wait+0x11a>
      release(&wait_lock);
    800021a8:	0000f517          	auipc	a0,0xf
    800021ac:	11050513          	addi	a0,a0,272 # 800112b8 <wait_lock>
    800021b0:	fffff097          	auipc	ra,0xfffff
    800021b4:	ad4080e7          	jalr	-1324(ra) # 80000c84 <release>
      return -1;
    800021b8:	59fd                	li	s3,-1
}
    800021ba:	854e                	mv	a0,s3
    800021bc:	60a6                	ld	ra,72(sp)
    800021be:	6406                	ld	s0,64(sp)
    800021c0:	74e2                	ld	s1,56(sp)
    800021c2:	7942                	ld	s2,48(sp)
    800021c4:	79a2                	ld	s3,40(sp)
    800021c6:	7a02                	ld	s4,32(sp)
    800021c8:	6ae2                	ld	s5,24(sp)
    800021ca:	6b42                	ld	s6,16(sp)
    800021cc:	6ba2                	ld	s7,8(sp)
    800021ce:	6c02                	ld	s8,0(sp)
    800021d0:	6161                	addi	sp,sp,80
    800021d2:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800021d4:	85e2                	mv	a1,s8
    800021d6:	854a                	mv	a0,s2
    800021d8:	00000097          	auipc	ra,0x0
    800021dc:	e7e080e7          	jalr	-386(ra) # 80002056 <sleep>
    havekids = 0;
    800021e0:	b715                	j	80002104 <wait+0x4a>

00000000800021e2 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800021e2:	7139                	addi	sp,sp,-64
    800021e4:	fc06                	sd	ra,56(sp)
    800021e6:	f822                	sd	s0,48(sp)
    800021e8:	f426                	sd	s1,40(sp)
    800021ea:	f04a                	sd	s2,32(sp)
    800021ec:	ec4e                	sd	s3,24(sp)
    800021ee:	e852                	sd	s4,16(sp)
    800021f0:	e456                	sd	s5,8(sp)
    800021f2:	0080                	addi	s0,sp,64
    800021f4:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800021f6:	0000f497          	auipc	s1,0xf
    800021fa:	4da48493          	addi	s1,s1,1242 # 800116d0 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800021fe:	4989                	li	s3,2
        p->state = RUNNABLE;
    80002200:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    80002202:	00015917          	auipc	s2,0x15
    80002206:	ece90913          	addi	s2,s2,-306 # 800170d0 <tickslock>
    8000220a:	a811                	j	8000221e <wakeup+0x3c>
      }
      release(&p->lock);
    8000220c:	8526                	mv	a0,s1
    8000220e:	fffff097          	auipc	ra,0xfffff
    80002212:	a76080e7          	jalr	-1418(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002216:	16848493          	addi	s1,s1,360
    8000221a:	03248663          	beq	s1,s2,80002246 <wakeup+0x64>
    if(p != myproc()){
    8000221e:	fffff097          	auipc	ra,0xfffff
    80002222:	778080e7          	jalr	1912(ra) # 80001996 <myproc>
    80002226:	fea488e3          	beq	s1,a0,80002216 <wakeup+0x34>
      acquire(&p->lock);
    8000222a:	8526                	mv	a0,s1
    8000222c:	fffff097          	auipc	ra,0xfffff
    80002230:	9a4080e7          	jalr	-1628(ra) # 80000bd0 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80002234:	4c9c                	lw	a5,24(s1)
    80002236:	fd379be3          	bne	a5,s3,8000220c <wakeup+0x2a>
    8000223a:	709c                	ld	a5,32(s1)
    8000223c:	fd4798e3          	bne	a5,s4,8000220c <wakeup+0x2a>
        p->state = RUNNABLE;
    80002240:	0154ac23          	sw	s5,24(s1)
    80002244:	b7e1                	j	8000220c <wakeup+0x2a>
    }
  }
}
    80002246:	70e2                	ld	ra,56(sp)
    80002248:	7442                	ld	s0,48(sp)
    8000224a:	74a2                	ld	s1,40(sp)
    8000224c:	7902                	ld	s2,32(sp)
    8000224e:	69e2                	ld	s3,24(sp)
    80002250:	6a42                	ld	s4,16(sp)
    80002252:	6aa2                	ld	s5,8(sp)
    80002254:	6121                	addi	sp,sp,64
    80002256:	8082                	ret

0000000080002258 <reparent>:
{
    80002258:	7179                	addi	sp,sp,-48
    8000225a:	f406                	sd	ra,40(sp)
    8000225c:	f022                	sd	s0,32(sp)
    8000225e:	ec26                	sd	s1,24(sp)
    80002260:	e84a                	sd	s2,16(sp)
    80002262:	e44e                	sd	s3,8(sp)
    80002264:	e052                	sd	s4,0(sp)
    80002266:	1800                	addi	s0,sp,48
    80002268:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000226a:	0000f497          	auipc	s1,0xf
    8000226e:	46648493          	addi	s1,s1,1126 # 800116d0 <proc>
      pp->parent = initproc;
    80002272:	00007a17          	auipc	s4,0x7
    80002276:	db6a0a13          	addi	s4,s4,-586 # 80009028 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000227a:	00015997          	auipc	s3,0x15
    8000227e:	e5698993          	addi	s3,s3,-426 # 800170d0 <tickslock>
    80002282:	a029                	j	8000228c <reparent+0x34>
    80002284:	16848493          	addi	s1,s1,360
    80002288:	01348d63          	beq	s1,s3,800022a2 <reparent+0x4a>
    if(pp->parent == p){
    8000228c:	7c9c                	ld	a5,56(s1)
    8000228e:	ff279be3          	bne	a5,s2,80002284 <reparent+0x2c>
      pp->parent = initproc;
    80002292:	000a3503          	ld	a0,0(s4)
    80002296:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80002298:	00000097          	auipc	ra,0x0
    8000229c:	f4a080e7          	jalr	-182(ra) # 800021e2 <wakeup>
    800022a0:	b7d5                	j	80002284 <reparent+0x2c>
}
    800022a2:	70a2                	ld	ra,40(sp)
    800022a4:	7402                	ld	s0,32(sp)
    800022a6:	64e2                	ld	s1,24(sp)
    800022a8:	6942                	ld	s2,16(sp)
    800022aa:	69a2                	ld	s3,8(sp)
    800022ac:	6a02                	ld	s4,0(sp)
    800022ae:	6145                	addi	sp,sp,48
    800022b0:	8082                	ret

00000000800022b2 <exit>:
{
    800022b2:	7179                	addi	sp,sp,-48
    800022b4:	f406                	sd	ra,40(sp)
    800022b6:	f022                	sd	s0,32(sp)
    800022b8:	ec26                	sd	s1,24(sp)
    800022ba:	e84a                	sd	s2,16(sp)
    800022bc:	e44e                	sd	s3,8(sp)
    800022be:	e052                	sd	s4,0(sp)
    800022c0:	1800                	addi	s0,sp,48
    800022c2:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800022c4:	fffff097          	auipc	ra,0xfffff
    800022c8:	6d2080e7          	jalr	1746(ra) # 80001996 <myproc>
    800022cc:	89aa                	mv	s3,a0
  if(p == initproc)
    800022ce:	00007797          	auipc	a5,0x7
    800022d2:	d5a7b783          	ld	a5,-678(a5) # 80009028 <initproc>
    800022d6:	0d050493          	addi	s1,a0,208
    800022da:	15050913          	addi	s2,a0,336
    800022de:	02a79363          	bne	a5,a0,80002304 <exit+0x52>
    panic("init exiting");
    800022e2:	00006517          	auipc	a0,0x6
    800022e6:	f7e50513          	addi	a0,a0,-130 # 80008260 <digits+0x220>
    800022ea:	ffffe097          	auipc	ra,0xffffe
    800022ee:	24e080e7          	jalr	590(ra) # 80000538 <panic>
      fileclose(f);
    800022f2:	00002097          	auipc	ra,0x2
    800022f6:	1d0080e7          	jalr	464(ra) # 800044c2 <fileclose>
      p->ofile[fd] = 0;
    800022fa:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    800022fe:	04a1                	addi	s1,s1,8
    80002300:	01248563          	beq	s1,s2,8000230a <exit+0x58>
    if(p->ofile[fd]){
    80002304:	6088                	ld	a0,0(s1)
    80002306:	f575                	bnez	a0,800022f2 <exit+0x40>
    80002308:	bfdd                	j	800022fe <exit+0x4c>
  begin_op();
    8000230a:	00002097          	auipc	ra,0x2
    8000230e:	cec080e7          	jalr	-788(ra) # 80003ff6 <begin_op>
  iput(p->cwd);
    80002312:	1509b503          	ld	a0,336(s3)
    80002316:	00001097          	auipc	ra,0x1
    8000231a:	4c8080e7          	jalr	1224(ra) # 800037de <iput>
  end_op();
    8000231e:	00002097          	auipc	ra,0x2
    80002322:	d58080e7          	jalr	-680(ra) # 80004076 <end_op>
  p->cwd = 0;
    80002326:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    8000232a:	0000f497          	auipc	s1,0xf
    8000232e:	f8e48493          	addi	s1,s1,-114 # 800112b8 <wait_lock>
    80002332:	8526                	mv	a0,s1
    80002334:	fffff097          	auipc	ra,0xfffff
    80002338:	89c080e7          	jalr	-1892(ra) # 80000bd0 <acquire>
  reparent(p);
    8000233c:	854e                	mv	a0,s3
    8000233e:	00000097          	auipc	ra,0x0
    80002342:	f1a080e7          	jalr	-230(ra) # 80002258 <reparent>
  wakeup(p->parent);
    80002346:	0389b503          	ld	a0,56(s3)
    8000234a:	00000097          	auipc	ra,0x0
    8000234e:	e98080e7          	jalr	-360(ra) # 800021e2 <wakeup>
  acquire(&p->lock);
    80002352:	854e                	mv	a0,s3
    80002354:	fffff097          	auipc	ra,0xfffff
    80002358:	87c080e7          	jalr	-1924(ra) # 80000bd0 <acquire>
  p->xstate = status;
    8000235c:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80002360:	4795                	li	a5,5
    80002362:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80002366:	8526                	mv	a0,s1
    80002368:	fffff097          	auipc	ra,0xfffff
    8000236c:	91c080e7          	jalr	-1764(ra) # 80000c84 <release>
  sched();
    80002370:	00000097          	auipc	ra,0x0
    80002374:	bd4080e7          	jalr	-1068(ra) # 80001f44 <sched>
  panic("zombie exit");
    80002378:	00006517          	auipc	a0,0x6
    8000237c:	ef850513          	addi	a0,a0,-264 # 80008270 <digits+0x230>
    80002380:	ffffe097          	auipc	ra,0xffffe
    80002384:	1b8080e7          	jalr	440(ra) # 80000538 <panic>

0000000080002388 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80002388:	7179                	addi	sp,sp,-48
    8000238a:	f406                	sd	ra,40(sp)
    8000238c:	f022                	sd	s0,32(sp)
    8000238e:	ec26                	sd	s1,24(sp)
    80002390:	e84a                	sd	s2,16(sp)
    80002392:	e44e                	sd	s3,8(sp)
    80002394:	1800                	addi	s0,sp,48
    80002396:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80002398:	0000f497          	auipc	s1,0xf
    8000239c:	33848493          	addi	s1,s1,824 # 800116d0 <proc>
    800023a0:	00015997          	auipc	s3,0x15
    800023a4:	d3098993          	addi	s3,s3,-720 # 800170d0 <tickslock>
    acquire(&p->lock);
    800023a8:	8526                	mv	a0,s1
    800023aa:	fffff097          	auipc	ra,0xfffff
    800023ae:	826080e7          	jalr	-2010(ra) # 80000bd0 <acquire>
    if(p->pid == pid){
    800023b2:	589c                	lw	a5,48(s1)
    800023b4:	01278d63          	beq	a5,s2,800023ce <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800023b8:	8526                	mv	a0,s1
    800023ba:	fffff097          	auipc	ra,0xfffff
    800023be:	8ca080e7          	jalr	-1846(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800023c2:	16848493          	addi	s1,s1,360
    800023c6:	ff3491e3          	bne	s1,s3,800023a8 <kill+0x20>
  }
  return -1;
    800023ca:	557d                	li	a0,-1
    800023cc:	a829                	j	800023e6 <kill+0x5e>
      p->killed = 1;
    800023ce:	4785                	li	a5,1
    800023d0:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    800023d2:	4c98                	lw	a4,24(s1)
    800023d4:	4789                	li	a5,2
    800023d6:	00f70f63          	beq	a4,a5,800023f4 <kill+0x6c>
      release(&p->lock);
    800023da:	8526                	mv	a0,s1
    800023dc:	fffff097          	auipc	ra,0xfffff
    800023e0:	8a8080e7          	jalr	-1880(ra) # 80000c84 <release>
      return 0;
    800023e4:	4501                	li	a0,0
}
    800023e6:	70a2                	ld	ra,40(sp)
    800023e8:	7402                	ld	s0,32(sp)
    800023ea:	64e2                	ld	s1,24(sp)
    800023ec:	6942                	ld	s2,16(sp)
    800023ee:	69a2                	ld	s3,8(sp)
    800023f0:	6145                	addi	sp,sp,48
    800023f2:	8082                	ret
        p->state = RUNNABLE;
    800023f4:	478d                	li	a5,3
    800023f6:	cc9c                	sw	a5,24(s1)
    800023f8:	b7cd                	j	800023da <kill+0x52>

00000000800023fa <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    800023fa:	7179                	addi	sp,sp,-48
    800023fc:	f406                	sd	ra,40(sp)
    800023fe:	f022                	sd	s0,32(sp)
    80002400:	ec26                	sd	s1,24(sp)
    80002402:	e84a                	sd	s2,16(sp)
    80002404:	e44e                	sd	s3,8(sp)
    80002406:	e052                	sd	s4,0(sp)
    80002408:	1800                	addi	s0,sp,48
    8000240a:	84aa                	mv	s1,a0
    8000240c:	892e                	mv	s2,a1
    8000240e:	89b2                	mv	s3,a2
    80002410:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80002412:	fffff097          	auipc	ra,0xfffff
    80002416:	584080e7          	jalr	1412(ra) # 80001996 <myproc>
  if(user_dst){
    8000241a:	c08d                	beqz	s1,8000243c <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    8000241c:	86d2                	mv	a3,s4
    8000241e:	864e                	mv	a2,s3
    80002420:	85ca                	mv	a1,s2
    80002422:	6928                	ld	a0,80(a0)
    80002424:	fffff097          	auipc	ra,0xfffff
    80002428:	232080e7          	jalr	562(ra) # 80001656 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    8000242c:	70a2                	ld	ra,40(sp)
    8000242e:	7402                	ld	s0,32(sp)
    80002430:	64e2                	ld	s1,24(sp)
    80002432:	6942                	ld	s2,16(sp)
    80002434:	69a2                	ld	s3,8(sp)
    80002436:	6a02                	ld	s4,0(sp)
    80002438:	6145                	addi	sp,sp,48
    8000243a:	8082                	ret
    memmove((char *)dst, src, len);
    8000243c:	000a061b          	sext.w	a2,s4
    80002440:	85ce                	mv	a1,s3
    80002442:	854a                	mv	a0,s2
    80002444:	fffff097          	auipc	ra,0xfffff
    80002448:	8e4080e7          	jalr	-1820(ra) # 80000d28 <memmove>
    return 0;
    8000244c:	8526                	mv	a0,s1
    8000244e:	bff9                	j	8000242c <either_copyout+0x32>

0000000080002450 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80002450:	7179                	addi	sp,sp,-48
    80002452:	f406                	sd	ra,40(sp)
    80002454:	f022                	sd	s0,32(sp)
    80002456:	ec26                	sd	s1,24(sp)
    80002458:	e84a                	sd	s2,16(sp)
    8000245a:	e44e                	sd	s3,8(sp)
    8000245c:	e052                	sd	s4,0(sp)
    8000245e:	1800                	addi	s0,sp,48
    80002460:	892a                	mv	s2,a0
    80002462:	84ae                	mv	s1,a1
    80002464:	89b2                	mv	s3,a2
    80002466:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80002468:	fffff097          	auipc	ra,0xfffff
    8000246c:	52e080e7          	jalr	1326(ra) # 80001996 <myproc>
  if(user_src){
    80002470:	c08d                	beqz	s1,80002492 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80002472:	86d2                	mv	a3,s4
    80002474:	864e                	mv	a2,s3
    80002476:	85ca                	mv	a1,s2
    80002478:	6928                	ld	a0,80(a0)
    8000247a:	fffff097          	auipc	ra,0xfffff
    8000247e:	268080e7          	jalr	616(ra) # 800016e2 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80002482:	70a2                	ld	ra,40(sp)
    80002484:	7402                	ld	s0,32(sp)
    80002486:	64e2                	ld	s1,24(sp)
    80002488:	6942                	ld	s2,16(sp)
    8000248a:	69a2                	ld	s3,8(sp)
    8000248c:	6a02                	ld	s4,0(sp)
    8000248e:	6145                	addi	sp,sp,48
    80002490:	8082                	ret
    memmove(dst, (char*)src, len);
    80002492:	000a061b          	sext.w	a2,s4
    80002496:	85ce                	mv	a1,s3
    80002498:	854a                	mv	a0,s2
    8000249a:	fffff097          	auipc	ra,0xfffff
    8000249e:	88e080e7          	jalr	-1906(ra) # 80000d28 <memmove>
    return 0;
    800024a2:	8526                	mv	a0,s1
    800024a4:	bff9                	j	80002482 <either_copyin+0x32>

00000000800024a6 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800024a6:	715d                	addi	sp,sp,-80
    800024a8:	e486                	sd	ra,72(sp)
    800024aa:	e0a2                	sd	s0,64(sp)
    800024ac:	fc26                	sd	s1,56(sp)
    800024ae:	f84a                	sd	s2,48(sp)
    800024b0:	f44e                	sd	s3,40(sp)
    800024b2:	f052                	sd	s4,32(sp)
    800024b4:	ec56                	sd	s5,24(sp)
    800024b6:	e85a                	sd	s6,16(sp)
    800024b8:	e45e                	sd	s7,8(sp)
    800024ba:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    800024bc:	00006517          	auipc	a0,0x6
    800024c0:	c0c50513          	addi	a0,a0,-1012 # 800080c8 <digits+0x88>
    800024c4:	ffffe097          	auipc	ra,0xffffe
    800024c8:	0be080e7          	jalr	190(ra) # 80000582 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800024cc:	0000f497          	auipc	s1,0xf
    800024d0:	35c48493          	addi	s1,s1,860 # 80011828 <proc+0x158>
    800024d4:	00015917          	auipc	s2,0x15
    800024d8:	d5490913          	addi	s2,s2,-684 # 80017228 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800024dc:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    800024de:	00006997          	auipc	s3,0x6
    800024e2:	da298993          	addi	s3,s3,-606 # 80008280 <digits+0x240>
    printf("%d %s %s", p->pid, state, p->name);
    800024e6:	00006a97          	auipc	s5,0x6
    800024ea:	da2a8a93          	addi	s5,s5,-606 # 80008288 <digits+0x248>
    printf("\n");
    800024ee:	00006a17          	auipc	s4,0x6
    800024f2:	bdaa0a13          	addi	s4,s4,-1062 # 800080c8 <digits+0x88>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800024f6:	00006b97          	auipc	s7,0x6
    800024fa:	dcab8b93          	addi	s7,s7,-566 # 800082c0 <states.0>
    800024fe:	a00d                	j	80002520 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80002500:	ed86a583          	lw	a1,-296(a3)
    80002504:	8556                	mv	a0,s5
    80002506:	ffffe097          	auipc	ra,0xffffe
    8000250a:	07c080e7          	jalr	124(ra) # 80000582 <printf>
    printf("\n");
    8000250e:	8552                	mv	a0,s4
    80002510:	ffffe097          	auipc	ra,0xffffe
    80002514:	072080e7          	jalr	114(ra) # 80000582 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80002518:	16848493          	addi	s1,s1,360
    8000251c:	03248163          	beq	s1,s2,8000253e <procdump+0x98>
    if(p->state == UNUSED)
    80002520:	86a6                	mv	a3,s1
    80002522:	ec04a783          	lw	a5,-320(s1)
    80002526:	dbed                	beqz	a5,80002518 <procdump+0x72>
      state = "???";
    80002528:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000252a:	fcfb6be3          	bltu	s6,a5,80002500 <procdump+0x5a>
    8000252e:	1782                	slli	a5,a5,0x20
    80002530:	9381                	srli	a5,a5,0x20
    80002532:	078e                	slli	a5,a5,0x3
    80002534:	97de                	add	a5,a5,s7
    80002536:	6390                	ld	a2,0(a5)
    80002538:	f661                	bnez	a2,80002500 <procdump+0x5a>
      state = "???";
    8000253a:	864e                	mv	a2,s3
    8000253c:	b7d1                	j	80002500 <procdump+0x5a>
  }
}
    8000253e:	60a6                	ld	ra,72(sp)
    80002540:	6406                	ld	s0,64(sp)
    80002542:	74e2                	ld	s1,56(sp)
    80002544:	7942                	ld	s2,48(sp)
    80002546:	79a2                	ld	s3,40(sp)
    80002548:	7a02                	ld	s4,32(sp)
    8000254a:	6ae2                	ld	s5,24(sp)
    8000254c:	6b42                	ld	s6,16(sp)
    8000254e:	6ba2                	ld	s7,8(sp)
    80002550:	6161                	addi	sp,sp,80
    80002552:	8082                	ret

0000000080002554 <getprocs>:


int 
getprocs (void)
{
    80002554:	7179                	addi	sp,sp,-48
    80002556:	f406                	sd	ra,40(sp)
    80002558:	f022                	sd	s0,32(sp)
    8000255a:	ec26                	sd	s1,24(sp)
    8000255c:	e84a                	sd	s2,16(sp)
    8000255e:	e44e                	sd	s3,8(sp)
    80002560:	1800                	addi	s0,sp,48
  int counter  = 0;
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80002562:	0000f497          	auipc	s1,0xf
    80002566:	16e48493          	addi	s1,s1,366 # 800116d0 <proc>
  int counter  = 0;
    8000256a:	4901                	li	s2,0
  for(p = proc; p < &proc[NPROC]; p++) {
    8000256c:	00015997          	auipc	s3,0x15
    80002570:	b6498993          	addi	s3,s3,-1180 # 800170d0 <tickslock>
    80002574:	a811                	j	80002588 <getprocs+0x34>
    acquire(&p->lock);
    if(p->state != UNUSED) {
      counter++;
    }
    release(&p->lock);
    80002576:	8526                	mv	a0,s1
    80002578:	ffffe097          	auipc	ra,0xffffe
    8000257c:	70c080e7          	jalr	1804(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002580:	16848493          	addi	s1,s1,360
    80002584:	01348b63          	beq	s1,s3,8000259a <getprocs+0x46>
    acquire(&p->lock);
    80002588:	8526                	mv	a0,s1
    8000258a:	ffffe097          	auipc	ra,0xffffe
    8000258e:	646080e7          	jalr	1606(ra) # 80000bd0 <acquire>
    if(p->state != UNUSED) {
    80002592:	4c9c                	lw	a5,24(s1)
    80002594:	d3ed                	beqz	a5,80002576 <getprocs+0x22>
      counter++;
    80002596:	2905                	addiw	s2,s2,1
    80002598:	bff9                	j	80002576 <getprocs+0x22>
  }

  return counter;
}
    8000259a:	854a                	mv	a0,s2
    8000259c:	70a2                	ld	ra,40(sp)
    8000259e:	7402                	ld	s0,32(sp)
    800025a0:	64e2                	ld	s1,24(sp)
    800025a2:	6942                	ld	s2,16(sp)
    800025a4:	69a2                	ld	s3,8(sp)
    800025a6:	6145                	addi	sp,sp,48
    800025a8:	8082                	ret

00000000800025aa <swtch>:
    800025aa:	00153023          	sd	ra,0(a0)
    800025ae:	00253423          	sd	sp,8(a0)
    800025b2:	e900                	sd	s0,16(a0)
    800025b4:	ed04                	sd	s1,24(a0)
    800025b6:	03253023          	sd	s2,32(a0)
    800025ba:	03353423          	sd	s3,40(a0)
    800025be:	03453823          	sd	s4,48(a0)
    800025c2:	03553c23          	sd	s5,56(a0)
    800025c6:	05653023          	sd	s6,64(a0)
    800025ca:	05753423          	sd	s7,72(a0)
    800025ce:	05853823          	sd	s8,80(a0)
    800025d2:	05953c23          	sd	s9,88(a0)
    800025d6:	07a53023          	sd	s10,96(a0)
    800025da:	07b53423          	sd	s11,104(a0)
    800025de:	0005b083          	ld	ra,0(a1)
    800025e2:	0085b103          	ld	sp,8(a1)
    800025e6:	6980                	ld	s0,16(a1)
    800025e8:	6d84                	ld	s1,24(a1)
    800025ea:	0205b903          	ld	s2,32(a1)
    800025ee:	0285b983          	ld	s3,40(a1)
    800025f2:	0305ba03          	ld	s4,48(a1)
    800025f6:	0385ba83          	ld	s5,56(a1)
    800025fa:	0405bb03          	ld	s6,64(a1)
    800025fe:	0485bb83          	ld	s7,72(a1)
    80002602:	0505bc03          	ld	s8,80(a1)
    80002606:	0585bc83          	ld	s9,88(a1)
    8000260a:	0605bd03          	ld	s10,96(a1)
    8000260e:	0685bd83          	ld	s11,104(a1)
    80002612:	8082                	ret

0000000080002614 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80002614:	1141                	addi	sp,sp,-16
    80002616:	e406                	sd	ra,8(sp)
    80002618:	e022                	sd	s0,0(sp)
    8000261a:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    8000261c:	00006597          	auipc	a1,0x6
    80002620:	cd458593          	addi	a1,a1,-812 # 800082f0 <states.0+0x30>
    80002624:	00015517          	auipc	a0,0x15
    80002628:	aac50513          	addi	a0,a0,-1364 # 800170d0 <tickslock>
    8000262c:	ffffe097          	auipc	ra,0xffffe
    80002630:	514080e7          	jalr	1300(ra) # 80000b40 <initlock>
}
    80002634:	60a2                	ld	ra,8(sp)
    80002636:	6402                	ld	s0,0(sp)
    80002638:	0141                	addi	sp,sp,16
    8000263a:	8082                	ret

000000008000263c <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    8000263c:	1141                	addi	sp,sp,-16
    8000263e:	e422                	sd	s0,8(sp)
    80002640:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002642:	00003797          	auipc	a5,0x3
    80002646:	4ae78793          	addi	a5,a5,1198 # 80005af0 <kernelvec>
    8000264a:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    8000264e:	6422                	ld	s0,8(sp)
    80002650:	0141                	addi	sp,sp,16
    80002652:	8082                	ret

0000000080002654 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80002654:	1141                	addi	sp,sp,-16
    80002656:	e406                	sd	ra,8(sp)
    80002658:	e022                	sd	s0,0(sp)
    8000265a:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    8000265c:	fffff097          	auipc	ra,0xfffff
    80002660:	33a080e7          	jalr	826(ra) # 80001996 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002664:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80002668:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000266a:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    8000266e:	00005617          	auipc	a2,0x5
    80002672:	99260613          	addi	a2,a2,-1646 # 80007000 <_trampoline>
    80002676:	00005697          	auipc	a3,0x5
    8000267a:	98a68693          	addi	a3,a3,-1654 # 80007000 <_trampoline>
    8000267e:	8e91                	sub	a3,a3,a2
    80002680:	040007b7          	lui	a5,0x4000
    80002684:	17fd                	addi	a5,a5,-1
    80002686:	07b2                	slli	a5,a5,0xc
    80002688:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    8000268a:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    8000268e:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80002690:	180026f3          	csrr	a3,satp
    80002694:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80002696:	6d38                	ld	a4,88(a0)
    80002698:	6134                	ld	a3,64(a0)
    8000269a:	6585                	lui	a1,0x1
    8000269c:	96ae                	add	a3,a3,a1
    8000269e:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    800026a0:	6d38                	ld	a4,88(a0)
    800026a2:	00000697          	auipc	a3,0x0
    800026a6:	13868693          	addi	a3,a3,312 # 800027da <usertrap>
    800026aa:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    800026ac:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    800026ae:	8692                	mv	a3,tp
    800026b0:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800026b2:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800026b6:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800026ba:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800026be:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    800026c2:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    800026c4:	6f18                	ld	a4,24(a4)
    800026c6:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    800026ca:	692c                	ld	a1,80(a0)
    800026cc:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    800026ce:	00005717          	auipc	a4,0x5
    800026d2:	9c270713          	addi	a4,a4,-1598 # 80007090 <userret>
    800026d6:	8f11                	sub	a4,a4,a2
    800026d8:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    800026da:	577d                	li	a4,-1
    800026dc:	177e                	slli	a4,a4,0x3f
    800026de:	8dd9                	or	a1,a1,a4
    800026e0:	02000537          	lui	a0,0x2000
    800026e4:	157d                	addi	a0,a0,-1
    800026e6:	0536                	slli	a0,a0,0xd
    800026e8:	9782                	jalr	a5
}
    800026ea:	60a2                	ld	ra,8(sp)
    800026ec:	6402                	ld	s0,0(sp)
    800026ee:	0141                	addi	sp,sp,16
    800026f0:	8082                	ret

00000000800026f2 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    800026f2:	1101                	addi	sp,sp,-32
    800026f4:	ec06                	sd	ra,24(sp)
    800026f6:	e822                	sd	s0,16(sp)
    800026f8:	e426                	sd	s1,8(sp)
    800026fa:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    800026fc:	00015497          	auipc	s1,0x15
    80002700:	9d448493          	addi	s1,s1,-1580 # 800170d0 <tickslock>
    80002704:	8526                	mv	a0,s1
    80002706:	ffffe097          	auipc	ra,0xffffe
    8000270a:	4ca080e7          	jalr	1226(ra) # 80000bd0 <acquire>
  ticks++;
    8000270e:	00007517          	auipc	a0,0x7
    80002712:	92250513          	addi	a0,a0,-1758 # 80009030 <ticks>
    80002716:	411c                	lw	a5,0(a0)
    80002718:	2785                	addiw	a5,a5,1
    8000271a:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    8000271c:	00000097          	auipc	ra,0x0
    80002720:	ac6080e7          	jalr	-1338(ra) # 800021e2 <wakeup>
  release(&tickslock);
    80002724:	8526                	mv	a0,s1
    80002726:	ffffe097          	auipc	ra,0xffffe
    8000272a:	55e080e7          	jalr	1374(ra) # 80000c84 <release>
}
    8000272e:	60e2                	ld	ra,24(sp)
    80002730:	6442                	ld	s0,16(sp)
    80002732:	64a2                	ld	s1,8(sp)
    80002734:	6105                	addi	sp,sp,32
    80002736:	8082                	ret

0000000080002738 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80002738:	1101                	addi	sp,sp,-32
    8000273a:	ec06                	sd	ra,24(sp)
    8000273c:	e822                	sd	s0,16(sp)
    8000273e:	e426                	sd	s1,8(sp)
    80002740:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002742:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80002746:	00074d63          	bltz	a4,80002760 <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    8000274a:	57fd                	li	a5,-1
    8000274c:	17fe                	slli	a5,a5,0x3f
    8000274e:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80002750:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80002752:	06f70363          	beq	a4,a5,800027b8 <devintr+0x80>
  }
}
    80002756:	60e2                	ld	ra,24(sp)
    80002758:	6442                	ld	s0,16(sp)
    8000275a:	64a2                	ld	s1,8(sp)
    8000275c:	6105                	addi	sp,sp,32
    8000275e:	8082                	ret
     (scause & 0xff) == 9){
    80002760:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    80002764:	46a5                	li	a3,9
    80002766:	fed792e3          	bne	a5,a3,8000274a <devintr+0x12>
    int irq = plic_claim();
    8000276a:	00003097          	auipc	ra,0x3
    8000276e:	48e080e7          	jalr	1166(ra) # 80005bf8 <plic_claim>
    80002772:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80002774:	47a9                	li	a5,10
    80002776:	02f50763          	beq	a0,a5,800027a4 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    8000277a:	4785                	li	a5,1
    8000277c:	02f50963          	beq	a0,a5,800027ae <devintr+0x76>
    return 1;
    80002780:	4505                	li	a0,1
    } else if(irq){
    80002782:	d8f1                	beqz	s1,80002756 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80002784:	85a6                	mv	a1,s1
    80002786:	00006517          	auipc	a0,0x6
    8000278a:	b7250513          	addi	a0,a0,-1166 # 800082f8 <states.0+0x38>
    8000278e:	ffffe097          	auipc	ra,0xffffe
    80002792:	df4080e7          	jalr	-524(ra) # 80000582 <printf>
      plic_complete(irq);
    80002796:	8526                	mv	a0,s1
    80002798:	00003097          	auipc	ra,0x3
    8000279c:	484080e7          	jalr	1156(ra) # 80005c1c <plic_complete>
    return 1;
    800027a0:	4505                	li	a0,1
    800027a2:	bf55                	j	80002756 <devintr+0x1e>
      uartintr();
    800027a4:	ffffe097          	auipc	ra,0xffffe
    800027a8:	1f0080e7          	jalr	496(ra) # 80000994 <uartintr>
    800027ac:	b7ed                	j	80002796 <devintr+0x5e>
      virtio_disk_intr();
    800027ae:	00004097          	auipc	ra,0x4
    800027b2:	900080e7          	jalr	-1792(ra) # 800060ae <virtio_disk_intr>
    800027b6:	b7c5                	j	80002796 <devintr+0x5e>
    if(cpuid() == 0){
    800027b8:	fffff097          	auipc	ra,0xfffff
    800027bc:	1b2080e7          	jalr	434(ra) # 8000196a <cpuid>
    800027c0:	c901                	beqz	a0,800027d0 <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    800027c2:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    800027c6:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    800027c8:	14479073          	csrw	sip,a5
    return 2;
    800027cc:	4509                	li	a0,2
    800027ce:	b761                	j	80002756 <devintr+0x1e>
      clockintr();
    800027d0:	00000097          	auipc	ra,0x0
    800027d4:	f22080e7          	jalr	-222(ra) # 800026f2 <clockintr>
    800027d8:	b7ed                	j	800027c2 <devintr+0x8a>

00000000800027da <usertrap>:
{
    800027da:	1101                	addi	sp,sp,-32
    800027dc:	ec06                	sd	ra,24(sp)
    800027de:	e822                	sd	s0,16(sp)
    800027e0:	e426                	sd	s1,8(sp)
    800027e2:	e04a                	sd	s2,0(sp)
    800027e4:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800027e6:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    800027ea:	1007f793          	andi	a5,a5,256
    800027ee:	e3ad                	bnez	a5,80002850 <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    800027f0:	00003797          	auipc	a5,0x3
    800027f4:	30078793          	addi	a5,a5,768 # 80005af0 <kernelvec>
    800027f8:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    800027fc:	fffff097          	auipc	ra,0xfffff
    80002800:	19a080e7          	jalr	410(ra) # 80001996 <myproc>
    80002804:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80002806:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002808:	14102773          	csrr	a4,sepc
    8000280c:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000280e:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80002812:	47a1                	li	a5,8
    80002814:	04f71c63          	bne	a4,a5,8000286c <usertrap+0x92>
    if(p->killed)
    80002818:	551c                	lw	a5,40(a0)
    8000281a:	e3b9                	bnez	a5,80002860 <usertrap+0x86>
    p->trapframe->epc += 4;
    8000281c:	6cb8                	ld	a4,88(s1)
    8000281e:	6f1c                	ld	a5,24(a4)
    80002820:	0791                	addi	a5,a5,4
    80002822:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002824:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002828:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000282c:	10079073          	csrw	sstatus,a5
    syscall();
    80002830:	00000097          	auipc	ra,0x0
    80002834:	2e0080e7          	jalr	736(ra) # 80002b10 <syscall>
  if(p->killed)
    80002838:	549c                	lw	a5,40(s1)
    8000283a:	ebc1                	bnez	a5,800028ca <usertrap+0xf0>
  usertrapret();
    8000283c:	00000097          	auipc	ra,0x0
    80002840:	e18080e7          	jalr	-488(ra) # 80002654 <usertrapret>
}
    80002844:	60e2                	ld	ra,24(sp)
    80002846:	6442                	ld	s0,16(sp)
    80002848:	64a2                	ld	s1,8(sp)
    8000284a:	6902                	ld	s2,0(sp)
    8000284c:	6105                	addi	sp,sp,32
    8000284e:	8082                	ret
    panic("usertrap: not from user mode");
    80002850:	00006517          	auipc	a0,0x6
    80002854:	ac850513          	addi	a0,a0,-1336 # 80008318 <states.0+0x58>
    80002858:	ffffe097          	auipc	ra,0xffffe
    8000285c:	ce0080e7          	jalr	-800(ra) # 80000538 <panic>
      exit(-1);
    80002860:	557d                	li	a0,-1
    80002862:	00000097          	auipc	ra,0x0
    80002866:	a50080e7          	jalr	-1456(ra) # 800022b2 <exit>
    8000286a:	bf4d                	j	8000281c <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    8000286c:	00000097          	auipc	ra,0x0
    80002870:	ecc080e7          	jalr	-308(ra) # 80002738 <devintr>
    80002874:	892a                	mv	s2,a0
    80002876:	c501                	beqz	a0,8000287e <usertrap+0xa4>
  if(p->killed)
    80002878:	549c                	lw	a5,40(s1)
    8000287a:	c3a1                	beqz	a5,800028ba <usertrap+0xe0>
    8000287c:	a815                	j	800028b0 <usertrap+0xd6>
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000287e:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80002882:	5890                	lw	a2,48(s1)
    80002884:	00006517          	auipc	a0,0x6
    80002888:	ab450513          	addi	a0,a0,-1356 # 80008338 <states.0+0x78>
    8000288c:	ffffe097          	auipc	ra,0xffffe
    80002890:	cf6080e7          	jalr	-778(ra) # 80000582 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002894:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002898:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    8000289c:	00006517          	auipc	a0,0x6
    800028a0:	acc50513          	addi	a0,a0,-1332 # 80008368 <states.0+0xa8>
    800028a4:	ffffe097          	auipc	ra,0xffffe
    800028a8:	cde080e7          	jalr	-802(ra) # 80000582 <printf>
    p->killed = 1;
    800028ac:	4785                	li	a5,1
    800028ae:	d49c                	sw	a5,40(s1)
    exit(-1);
    800028b0:	557d                	li	a0,-1
    800028b2:	00000097          	auipc	ra,0x0
    800028b6:	a00080e7          	jalr	-1536(ra) # 800022b2 <exit>
  if(which_dev == 2)
    800028ba:	4789                	li	a5,2
    800028bc:	f8f910e3          	bne	s2,a5,8000283c <usertrap+0x62>
    yield();
    800028c0:	fffff097          	auipc	ra,0xfffff
    800028c4:	75a080e7          	jalr	1882(ra) # 8000201a <yield>
    800028c8:	bf95                	j	8000283c <usertrap+0x62>
  int which_dev = 0;
    800028ca:	4901                	li	s2,0
    800028cc:	b7d5                	j	800028b0 <usertrap+0xd6>

00000000800028ce <kerneltrap>:
{
    800028ce:	7179                	addi	sp,sp,-48
    800028d0:	f406                	sd	ra,40(sp)
    800028d2:	f022                	sd	s0,32(sp)
    800028d4:	ec26                	sd	s1,24(sp)
    800028d6:	e84a                	sd	s2,16(sp)
    800028d8:	e44e                	sd	s3,8(sp)
    800028da:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800028dc:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800028e0:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    800028e4:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    800028e8:	1004f793          	andi	a5,s1,256
    800028ec:	cb85                	beqz	a5,8000291c <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800028ee:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800028f2:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    800028f4:	ef85                	bnez	a5,8000292c <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    800028f6:	00000097          	auipc	ra,0x0
    800028fa:	e42080e7          	jalr	-446(ra) # 80002738 <devintr>
    800028fe:	cd1d                	beqz	a0,8000293c <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002900:	4789                	li	a5,2
    80002902:	06f50a63          	beq	a0,a5,80002976 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002906:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000290a:	10049073          	csrw	sstatus,s1
}
    8000290e:	70a2                	ld	ra,40(sp)
    80002910:	7402                	ld	s0,32(sp)
    80002912:	64e2                	ld	s1,24(sp)
    80002914:	6942                	ld	s2,16(sp)
    80002916:	69a2                	ld	s3,8(sp)
    80002918:	6145                	addi	sp,sp,48
    8000291a:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    8000291c:	00006517          	auipc	a0,0x6
    80002920:	a6c50513          	addi	a0,a0,-1428 # 80008388 <states.0+0xc8>
    80002924:	ffffe097          	auipc	ra,0xffffe
    80002928:	c14080e7          	jalr	-1004(ra) # 80000538 <panic>
    panic("kerneltrap: interrupts enabled");
    8000292c:	00006517          	auipc	a0,0x6
    80002930:	a8450513          	addi	a0,a0,-1404 # 800083b0 <states.0+0xf0>
    80002934:	ffffe097          	auipc	ra,0xffffe
    80002938:	c04080e7          	jalr	-1020(ra) # 80000538 <panic>
    printf("scause %p\n", scause);
    8000293c:	85ce                	mv	a1,s3
    8000293e:	00006517          	auipc	a0,0x6
    80002942:	a9250513          	addi	a0,a0,-1390 # 800083d0 <states.0+0x110>
    80002946:	ffffe097          	auipc	ra,0xffffe
    8000294a:	c3c080e7          	jalr	-964(ra) # 80000582 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    8000294e:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002952:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002956:	00006517          	auipc	a0,0x6
    8000295a:	a8a50513          	addi	a0,a0,-1398 # 800083e0 <states.0+0x120>
    8000295e:	ffffe097          	auipc	ra,0xffffe
    80002962:	c24080e7          	jalr	-988(ra) # 80000582 <printf>
    panic("kerneltrap");
    80002966:	00006517          	auipc	a0,0x6
    8000296a:	a9250513          	addi	a0,a0,-1390 # 800083f8 <states.0+0x138>
    8000296e:	ffffe097          	auipc	ra,0xffffe
    80002972:	bca080e7          	jalr	-1078(ra) # 80000538 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002976:	fffff097          	auipc	ra,0xfffff
    8000297a:	020080e7          	jalr	32(ra) # 80001996 <myproc>
    8000297e:	d541                	beqz	a0,80002906 <kerneltrap+0x38>
    80002980:	fffff097          	auipc	ra,0xfffff
    80002984:	016080e7          	jalr	22(ra) # 80001996 <myproc>
    80002988:	4d18                	lw	a4,24(a0)
    8000298a:	4791                	li	a5,4
    8000298c:	f6f71de3          	bne	a4,a5,80002906 <kerneltrap+0x38>
    yield();
    80002990:	fffff097          	auipc	ra,0xfffff
    80002994:	68a080e7          	jalr	1674(ra) # 8000201a <yield>
    80002998:	b7bd                	j	80002906 <kerneltrap+0x38>

000000008000299a <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    8000299a:	1101                	addi	sp,sp,-32
    8000299c:	ec06                	sd	ra,24(sp)
    8000299e:	e822                	sd	s0,16(sp)
    800029a0:	e426                	sd	s1,8(sp)
    800029a2:	1000                	addi	s0,sp,32
    800029a4:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    800029a6:	fffff097          	auipc	ra,0xfffff
    800029aa:	ff0080e7          	jalr	-16(ra) # 80001996 <myproc>
  switch (n) {
    800029ae:	4795                	li	a5,5
    800029b0:	0497e163          	bltu	a5,s1,800029f2 <argraw+0x58>
    800029b4:	048a                	slli	s1,s1,0x2
    800029b6:	00006717          	auipc	a4,0x6
    800029ba:	a7a70713          	addi	a4,a4,-1414 # 80008430 <states.0+0x170>
    800029be:	94ba                	add	s1,s1,a4
    800029c0:	409c                	lw	a5,0(s1)
    800029c2:	97ba                	add	a5,a5,a4
    800029c4:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    800029c6:	6d3c                	ld	a5,88(a0)
    800029c8:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    800029ca:	60e2                	ld	ra,24(sp)
    800029cc:	6442                	ld	s0,16(sp)
    800029ce:	64a2                	ld	s1,8(sp)
    800029d0:	6105                	addi	sp,sp,32
    800029d2:	8082                	ret
    return p->trapframe->a1;
    800029d4:	6d3c                	ld	a5,88(a0)
    800029d6:	7fa8                	ld	a0,120(a5)
    800029d8:	bfcd                	j	800029ca <argraw+0x30>
    return p->trapframe->a2;
    800029da:	6d3c                	ld	a5,88(a0)
    800029dc:	63c8                	ld	a0,128(a5)
    800029de:	b7f5                	j	800029ca <argraw+0x30>
    return p->trapframe->a3;
    800029e0:	6d3c                	ld	a5,88(a0)
    800029e2:	67c8                	ld	a0,136(a5)
    800029e4:	b7dd                	j	800029ca <argraw+0x30>
    return p->trapframe->a4;
    800029e6:	6d3c                	ld	a5,88(a0)
    800029e8:	6bc8                	ld	a0,144(a5)
    800029ea:	b7c5                	j	800029ca <argraw+0x30>
    return p->trapframe->a5;
    800029ec:	6d3c                	ld	a5,88(a0)
    800029ee:	6fc8                	ld	a0,152(a5)
    800029f0:	bfe9                	j	800029ca <argraw+0x30>
  panic("argraw");
    800029f2:	00006517          	auipc	a0,0x6
    800029f6:	a1650513          	addi	a0,a0,-1514 # 80008408 <states.0+0x148>
    800029fa:	ffffe097          	auipc	ra,0xffffe
    800029fe:	b3e080e7          	jalr	-1218(ra) # 80000538 <panic>

0000000080002a02 <fetchaddr>:
{
    80002a02:	1101                	addi	sp,sp,-32
    80002a04:	ec06                	sd	ra,24(sp)
    80002a06:	e822                	sd	s0,16(sp)
    80002a08:	e426                	sd	s1,8(sp)
    80002a0a:	e04a                	sd	s2,0(sp)
    80002a0c:	1000                	addi	s0,sp,32
    80002a0e:	84aa                	mv	s1,a0
    80002a10:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002a12:	fffff097          	auipc	ra,0xfffff
    80002a16:	f84080e7          	jalr	-124(ra) # 80001996 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80002a1a:	653c                	ld	a5,72(a0)
    80002a1c:	02f4f863          	bgeu	s1,a5,80002a4c <fetchaddr+0x4a>
    80002a20:	00848713          	addi	a4,s1,8
    80002a24:	02e7e663          	bltu	a5,a4,80002a50 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002a28:	46a1                	li	a3,8
    80002a2a:	8626                	mv	a2,s1
    80002a2c:	85ca                	mv	a1,s2
    80002a2e:	6928                	ld	a0,80(a0)
    80002a30:	fffff097          	auipc	ra,0xfffff
    80002a34:	cb2080e7          	jalr	-846(ra) # 800016e2 <copyin>
    80002a38:	00a03533          	snez	a0,a0
    80002a3c:	40a00533          	neg	a0,a0
}
    80002a40:	60e2                	ld	ra,24(sp)
    80002a42:	6442                	ld	s0,16(sp)
    80002a44:	64a2                	ld	s1,8(sp)
    80002a46:	6902                	ld	s2,0(sp)
    80002a48:	6105                	addi	sp,sp,32
    80002a4a:	8082                	ret
    return -1;
    80002a4c:	557d                	li	a0,-1
    80002a4e:	bfcd                	j	80002a40 <fetchaddr+0x3e>
    80002a50:	557d                	li	a0,-1
    80002a52:	b7fd                	j	80002a40 <fetchaddr+0x3e>

0000000080002a54 <fetchstr>:
{
    80002a54:	7179                	addi	sp,sp,-48
    80002a56:	f406                	sd	ra,40(sp)
    80002a58:	f022                	sd	s0,32(sp)
    80002a5a:	ec26                	sd	s1,24(sp)
    80002a5c:	e84a                	sd	s2,16(sp)
    80002a5e:	e44e                	sd	s3,8(sp)
    80002a60:	1800                	addi	s0,sp,48
    80002a62:	892a                	mv	s2,a0
    80002a64:	84ae                	mv	s1,a1
    80002a66:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80002a68:	fffff097          	auipc	ra,0xfffff
    80002a6c:	f2e080e7          	jalr	-210(ra) # 80001996 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    80002a70:	86ce                	mv	a3,s3
    80002a72:	864a                	mv	a2,s2
    80002a74:	85a6                	mv	a1,s1
    80002a76:	6928                	ld	a0,80(a0)
    80002a78:	fffff097          	auipc	ra,0xfffff
    80002a7c:	cf8080e7          	jalr	-776(ra) # 80001770 <copyinstr>
  if(err < 0)
    80002a80:	00054763          	bltz	a0,80002a8e <fetchstr+0x3a>
  return strlen(buf);
    80002a84:	8526                	mv	a0,s1
    80002a86:	ffffe097          	auipc	ra,0xffffe
    80002a8a:	3c2080e7          	jalr	962(ra) # 80000e48 <strlen>
}
    80002a8e:	70a2                	ld	ra,40(sp)
    80002a90:	7402                	ld	s0,32(sp)
    80002a92:	64e2                	ld	s1,24(sp)
    80002a94:	6942                	ld	s2,16(sp)
    80002a96:	69a2                	ld	s3,8(sp)
    80002a98:	6145                	addi	sp,sp,48
    80002a9a:	8082                	ret

0000000080002a9c <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80002a9c:	1101                	addi	sp,sp,-32
    80002a9e:	ec06                	sd	ra,24(sp)
    80002aa0:	e822                	sd	s0,16(sp)
    80002aa2:	e426                	sd	s1,8(sp)
    80002aa4:	1000                	addi	s0,sp,32
    80002aa6:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002aa8:	00000097          	auipc	ra,0x0
    80002aac:	ef2080e7          	jalr	-270(ra) # 8000299a <argraw>
    80002ab0:	c088                	sw	a0,0(s1)
  return 0;
}
    80002ab2:	4501                	li	a0,0
    80002ab4:	60e2                	ld	ra,24(sp)
    80002ab6:	6442                	ld	s0,16(sp)
    80002ab8:	64a2                	ld	s1,8(sp)
    80002aba:	6105                	addi	sp,sp,32
    80002abc:	8082                	ret

0000000080002abe <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80002abe:	1101                	addi	sp,sp,-32
    80002ac0:	ec06                	sd	ra,24(sp)
    80002ac2:	e822                	sd	s0,16(sp)
    80002ac4:	e426                	sd	s1,8(sp)
    80002ac6:	1000                	addi	s0,sp,32
    80002ac8:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002aca:	00000097          	auipc	ra,0x0
    80002ace:	ed0080e7          	jalr	-304(ra) # 8000299a <argraw>
    80002ad2:	e088                	sd	a0,0(s1)
  return 0;
}
    80002ad4:	4501                	li	a0,0
    80002ad6:	60e2                	ld	ra,24(sp)
    80002ad8:	6442                	ld	s0,16(sp)
    80002ada:	64a2                	ld	s1,8(sp)
    80002adc:	6105                	addi	sp,sp,32
    80002ade:	8082                	ret

0000000080002ae0 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002ae0:	1101                	addi	sp,sp,-32
    80002ae2:	ec06                	sd	ra,24(sp)
    80002ae4:	e822                	sd	s0,16(sp)
    80002ae6:	e426                	sd	s1,8(sp)
    80002ae8:	e04a                	sd	s2,0(sp)
    80002aea:	1000                	addi	s0,sp,32
    80002aec:	84ae                	mv	s1,a1
    80002aee:	8932                	mv	s2,a2
  *ip = argraw(n);
    80002af0:	00000097          	auipc	ra,0x0
    80002af4:	eaa080e7          	jalr	-342(ra) # 8000299a <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80002af8:	864a                	mv	a2,s2
    80002afa:	85a6                	mv	a1,s1
    80002afc:	00000097          	auipc	ra,0x0
    80002b00:	f58080e7          	jalr	-168(ra) # 80002a54 <fetchstr>
}
    80002b04:	60e2                	ld	ra,24(sp)
    80002b06:	6442                	ld	s0,16(sp)
    80002b08:	64a2                	ld	s1,8(sp)
    80002b0a:	6902                	ld	s2,0(sp)
    80002b0c:	6105                	addi	sp,sp,32
    80002b0e:	8082                	ret

0000000080002b10 <syscall>:
[SYS_getprocs] sys_getprocs
};

void
syscall(void)
{
    80002b10:	1101                	addi	sp,sp,-32
    80002b12:	ec06                	sd	ra,24(sp)
    80002b14:	e822                	sd	s0,16(sp)
    80002b16:	e426                	sd	s1,8(sp)
    80002b18:	e04a                	sd	s2,0(sp)
    80002b1a:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002b1c:	fffff097          	auipc	ra,0xfffff
    80002b20:	e7a080e7          	jalr	-390(ra) # 80001996 <myproc>
    80002b24:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80002b26:	05853903          	ld	s2,88(a0)
    80002b2a:	0a893783          	ld	a5,168(s2)
    80002b2e:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002b32:	37fd                	addiw	a5,a5,-1
    80002b34:	4755                	li	a4,21
    80002b36:	00f76f63          	bltu	a4,a5,80002b54 <syscall+0x44>
    80002b3a:	00369713          	slli	a4,a3,0x3
    80002b3e:	00006797          	auipc	a5,0x6
    80002b42:	90a78793          	addi	a5,a5,-1782 # 80008448 <syscalls>
    80002b46:	97ba                	add	a5,a5,a4
    80002b48:	639c                	ld	a5,0(a5)
    80002b4a:	c789                	beqz	a5,80002b54 <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    80002b4c:	9782                	jalr	a5
    80002b4e:	06a93823          	sd	a0,112(s2)
    80002b52:	a839                	j	80002b70 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002b54:	15848613          	addi	a2,s1,344
    80002b58:	588c                	lw	a1,48(s1)
    80002b5a:	00006517          	auipc	a0,0x6
    80002b5e:	8b650513          	addi	a0,a0,-1866 # 80008410 <states.0+0x150>
    80002b62:	ffffe097          	auipc	ra,0xffffe
    80002b66:	a20080e7          	jalr	-1504(ra) # 80000582 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80002b6a:	6cbc                	ld	a5,88(s1)
    80002b6c:	577d                	li	a4,-1
    80002b6e:	fbb8                	sd	a4,112(a5)
  }
}
    80002b70:	60e2                	ld	ra,24(sp)
    80002b72:	6442                	ld	s0,16(sp)
    80002b74:	64a2                	ld	s1,8(sp)
    80002b76:	6902                	ld	s2,0(sp)
    80002b78:	6105                	addi	sp,sp,32
    80002b7a:	8082                	ret

0000000080002b7c <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80002b7c:	1101                	addi	sp,sp,-32
    80002b7e:	ec06                	sd	ra,24(sp)
    80002b80:	e822                	sd	s0,16(sp)
    80002b82:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80002b84:	fec40593          	addi	a1,s0,-20
    80002b88:	4501                	li	a0,0
    80002b8a:	00000097          	auipc	ra,0x0
    80002b8e:	f12080e7          	jalr	-238(ra) # 80002a9c <argint>
    return -1;
    80002b92:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002b94:	00054963          	bltz	a0,80002ba6 <sys_exit+0x2a>
  exit(n);
    80002b98:	fec42503          	lw	a0,-20(s0)
    80002b9c:	fffff097          	auipc	ra,0xfffff
    80002ba0:	716080e7          	jalr	1814(ra) # 800022b2 <exit>
  return 0;  // not reached
    80002ba4:	4781                	li	a5,0
}
    80002ba6:	853e                	mv	a0,a5
    80002ba8:	60e2                	ld	ra,24(sp)
    80002baa:	6442                	ld	s0,16(sp)
    80002bac:	6105                	addi	sp,sp,32
    80002bae:	8082                	ret

0000000080002bb0 <sys_getpid>:

uint64
sys_getpid(void)
{
    80002bb0:	1141                	addi	sp,sp,-16
    80002bb2:	e406                	sd	ra,8(sp)
    80002bb4:	e022                	sd	s0,0(sp)
    80002bb6:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002bb8:	fffff097          	auipc	ra,0xfffff
    80002bbc:	dde080e7          	jalr	-546(ra) # 80001996 <myproc>
}
    80002bc0:	5908                	lw	a0,48(a0)
    80002bc2:	60a2                	ld	ra,8(sp)
    80002bc4:	6402                	ld	s0,0(sp)
    80002bc6:	0141                	addi	sp,sp,16
    80002bc8:	8082                	ret

0000000080002bca <sys_getprocs>:

uint64
sys_getprocs (void)
{
    80002bca:	1141                	addi	sp,sp,-16
    80002bcc:	e406                	sd	ra,8(sp)
    80002bce:	e022                	sd	s0,0(sp)
    80002bd0:	0800                	addi	s0,sp,16
  return getprocs();
    80002bd2:	00000097          	auipc	ra,0x0
    80002bd6:	982080e7          	jalr	-1662(ra) # 80002554 <getprocs>
}
    80002bda:	60a2                	ld	ra,8(sp)
    80002bdc:	6402                	ld	s0,0(sp)
    80002bde:	0141                	addi	sp,sp,16
    80002be0:	8082                	ret

0000000080002be2 <sys_fork>:


uint64
sys_fork(void)
{
    80002be2:	1141                	addi	sp,sp,-16
    80002be4:	e406                	sd	ra,8(sp)
    80002be6:	e022                	sd	s0,0(sp)
    80002be8:	0800                	addi	s0,sp,16
  return fork();
    80002bea:	fffff097          	auipc	ra,0xfffff
    80002bee:	17a080e7          	jalr	378(ra) # 80001d64 <fork>
}
    80002bf2:	60a2                	ld	ra,8(sp)
    80002bf4:	6402                	ld	s0,0(sp)
    80002bf6:	0141                	addi	sp,sp,16
    80002bf8:	8082                	ret

0000000080002bfa <sys_wait>:

uint64
sys_wait(void)
{
    80002bfa:	1101                	addi	sp,sp,-32
    80002bfc:	ec06                	sd	ra,24(sp)
    80002bfe:	e822                	sd	s0,16(sp)
    80002c00:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80002c02:	fe840593          	addi	a1,s0,-24
    80002c06:	4501                	li	a0,0
    80002c08:	00000097          	auipc	ra,0x0
    80002c0c:	eb6080e7          	jalr	-330(ra) # 80002abe <argaddr>
    80002c10:	87aa                	mv	a5,a0
    return -1;
    80002c12:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80002c14:	0007c863          	bltz	a5,80002c24 <sys_wait+0x2a>
  return wait(p);
    80002c18:	fe843503          	ld	a0,-24(s0)
    80002c1c:	fffff097          	auipc	ra,0xfffff
    80002c20:	49e080e7          	jalr	1182(ra) # 800020ba <wait>
}
    80002c24:	60e2                	ld	ra,24(sp)
    80002c26:	6442                	ld	s0,16(sp)
    80002c28:	6105                	addi	sp,sp,32
    80002c2a:	8082                	ret

0000000080002c2c <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002c2c:	7179                	addi	sp,sp,-48
    80002c2e:	f406                	sd	ra,40(sp)
    80002c30:	f022                	sd	s0,32(sp)
    80002c32:	ec26                	sd	s1,24(sp)
    80002c34:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80002c36:	fdc40593          	addi	a1,s0,-36
    80002c3a:	4501                	li	a0,0
    80002c3c:	00000097          	auipc	ra,0x0
    80002c40:	e60080e7          	jalr	-416(ra) # 80002a9c <argint>
    return -1;
    80002c44:	54fd                	li	s1,-1
  if(argint(0, &n) < 0)
    80002c46:	00054f63          	bltz	a0,80002c64 <sys_sbrk+0x38>
  addr = myproc()->sz;
    80002c4a:	fffff097          	auipc	ra,0xfffff
    80002c4e:	d4c080e7          	jalr	-692(ra) # 80001996 <myproc>
    80002c52:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    80002c54:	fdc42503          	lw	a0,-36(s0)
    80002c58:	fffff097          	auipc	ra,0xfffff
    80002c5c:	098080e7          	jalr	152(ra) # 80001cf0 <growproc>
    80002c60:	00054863          	bltz	a0,80002c70 <sys_sbrk+0x44>
    return -1;
  return addr;
}
    80002c64:	8526                	mv	a0,s1
    80002c66:	70a2                	ld	ra,40(sp)
    80002c68:	7402                	ld	s0,32(sp)
    80002c6a:	64e2                	ld	s1,24(sp)
    80002c6c:	6145                	addi	sp,sp,48
    80002c6e:	8082                	ret
    return -1;
    80002c70:	54fd                	li	s1,-1
    80002c72:	bfcd                	j	80002c64 <sys_sbrk+0x38>

0000000080002c74 <sys_sleep>:

uint64
sys_sleep(void)
{
    80002c74:	7139                	addi	sp,sp,-64
    80002c76:	fc06                	sd	ra,56(sp)
    80002c78:	f822                	sd	s0,48(sp)
    80002c7a:	f426                	sd	s1,40(sp)
    80002c7c:	f04a                	sd	s2,32(sp)
    80002c7e:	ec4e                	sd	s3,24(sp)
    80002c80:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80002c82:	fcc40593          	addi	a1,s0,-52
    80002c86:	4501                	li	a0,0
    80002c88:	00000097          	auipc	ra,0x0
    80002c8c:	e14080e7          	jalr	-492(ra) # 80002a9c <argint>
    return -1;
    80002c90:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002c92:	06054563          	bltz	a0,80002cfc <sys_sleep+0x88>
  acquire(&tickslock);
    80002c96:	00014517          	auipc	a0,0x14
    80002c9a:	43a50513          	addi	a0,a0,1082 # 800170d0 <tickslock>
    80002c9e:	ffffe097          	auipc	ra,0xffffe
    80002ca2:	f32080e7          	jalr	-206(ra) # 80000bd0 <acquire>
  ticks0 = ticks;
    80002ca6:	00006917          	auipc	s2,0x6
    80002caa:	38a92903          	lw	s2,906(s2) # 80009030 <ticks>
  while(ticks - ticks0 < n){
    80002cae:	fcc42783          	lw	a5,-52(s0)
    80002cb2:	cf85                	beqz	a5,80002cea <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002cb4:	00014997          	auipc	s3,0x14
    80002cb8:	41c98993          	addi	s3,s3,1052 # 800170d0 <tickslock>
    80002cbc:	00006497          	auipc	s1,0x6
    80002cc0:	37448493          	addi	s1,s1,884 # 80009030 <ticks>
    if(myproc()->killed){
    80002cc4:	fffff097          	auipc	ra,0xfffff
    80002cc8:	cd2080e7          	jalr	-814(ra) # 80001996 <myproc>
    80002ccc:	551c                	lw	a5,40(a0)
    80002cce:	ef9d                	bnez	a5,80002d0c <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    80002cd0:	85ce                	mv	a1,s3
    80002cd2:	8526                	mv	a0,s1
    80002cd4:	fffff097          	auipc	ra,0xfffff
    80002cd8:	382080e7          	jalr	898(ra) # 80002056 <sleep>
  while(ticks - ticks0 < n){
    80002cdc:	409c                	lw	a5,0(s1)
    80002cde:	412787bb          	subw	a5,a5,s2
    80002ce2:	fcc42703          	lw	a4,-52(s0)
    80002ce6:	fce7efe3          	bltu	a5,a4,80002cc4 <sys_sleep+0x50>
  }
  release(&tickslock);
    80002cea:	00014517          	auipc	a0,0x14
    80002cee:	3e650513          	addi	a0,a0,998 # 800170d0 <tickslock>
    80002cf2:	ffffe097          	auipc	ra,0xffffe
    80002cf6:	f92080e7          	jalr	-110(ra) # 80000c84 <release>
  return 0;
    80002cfa:	4781                	li	a5,0
}
    80002cfc:	853e                	mv	a0,a5
    80002cfe:	70e2                	ld	ra,56(sp)
    80002d00:	7442                	ld	s0,48(sp)
    80002d02:	74a2                	ld	s1,40(sp)
    80002d04:	7902                	ld	s2,32(sp)
    80002d06:	69e2                	ld	s3,24(sp)
    80002d08:	6121                	addi	sp,sp,64
    80002d0a:	8082                	ret
      release(&tickslock);
    80002d0c:	00014517          	auipc	a0,0x14
    80002d10:	3c450513          	addi	a0,a0,964 # 800170d0 <tickslock>
    80002d14:	ffffe097          	auipc	ra,0xffffe
    80002d18:	f70080e7          	jalr	-144(ra) # 80000c84 <release>
      return -1;
    80002d1c:	57fd                	li	a5,-1
    80002d1e:	bff9                	j	80002cfc <sys_sleep+0x88>

0000000080002d20 <sys_kill>:

uint64
sys_kill(void)
{
    80002d20:	1101                	addi	sp,sp,-32
    80002d22:	ec06                	sd	ra,24(sp)
    80002d24:	e822                	sd	s0,16(sp)
    80002d26:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80002d28:	fec40593          	addi	a1,s0,-20
    80002d2c:	4501                	li	a0,0
    80002d2e:	00000097          	auipc	ra,0x0
    80002d32:	d6e080e7          	jalr	-658(ra) # 80002a9c <argint>
    80002d36:	87aa                	mv	a5,a0
    return -1;
    80002d38:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    80002d3a:	0007c863          	bltz	a5,80002d4a <sys_kill+0x2a>
  return kill(pid);
    80002d3e:	fec42503          	lw	a0,-20(s0)
    80002d42:	fffff097          	auipc	ra,0xfffff
    80002d46:	646080e7          	jalr	1606(ra) # 80002388 <kill>
}
    80002d4a:	60e2                	ld	ra,24(sp)
    80002d4c:	6442                	ld	s0,16(sp)
    80002d4e:	6105                	addi	sp,sp,32
    80002d50:	8082                	ret

0000000080002d52 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002d52:	1101                	addi	sp,sp,-32
    80002d54:	ec06                	sd	ra,24(sp)
    80002d56:	e822                	sd	s0,16(sp)
    80002d58:	e426                	sd	s1,8(sp)
    80002d5a:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002d5c:	00014517          	auipc	a0,0x14
    80002d60:	37450513          	addi	a0,a0,884 # 800170d0 <tickslock>
    80002d64:	ffffe097          	auipc	ra,0xffffe
    80002d68:	e6c080e7          	jalr	-404(ra) # 80000bd0 <acquire>
  xticks = ticks;
    80002d6c:	00006497          	auipc	s1,0x6
    80002d70:	2c44a483          	lw	s1,708(s1) # 80009030 <ticks>
  release(&tickslock);
    80002d74:	00014517          	auipc	a0,0x14
    80002d78:	35c50513          	addi	a0,a0,860 # 800170d0 <tickslock>
    80002d7c:	ffffe097          	auipc	ra,0xffffe
    80002d80:	f08080e7          	jalr	-248(ra) # 80000c84 <release>
  return xticks;
}
    80002d84:	02049513          	slli	a0,s1,0x20
    80002d88:	9101                	srli	a0,a0,0x20
    80002d8a:	60e2                	ld	ra,24(sp)
    80002d8c:	6442                	ld	s0,16(sp)
    80002d8e:	64a2                	ld	s1,8(sp)
    80002d90:	6105                	addi	sp,sp,32
    80002d92:	8082                	ret

0000000080002d94 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002d94:	7179                	addi	sp,sp,-48
    80002d96:	f406                	sd	ra,40(sp)
    80002d98:	f022                	sd	s0,32(sp)
    80002d9a:	ec26                	sd	s1,24(sp)
    80002d9c:	e84a                	sd	s2,16(sp)
    80002d9e:	e44e                	sd	s3,8(sp)
    80002da0:	e052                	sd	s4,0(sp)
    80002da2:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002da4:	00005597          	auipc	a1,0x5
    80002da8:	75c58593          	addi	a1,a1,1884 # 80008500 <syscalls+0xb8>
    80002dac:	00014517          	auipc	a0,0x14
    80002db0:	33c50513          	addi	a0,a0,828 # 800170e8 <bcache>
    80002db4:	ffffe097          	auipc	ra,0xffffe
    80002db8:	d8c080e7          	jalr	-628(ra) # 80000b40 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002dbc:	0001c797          	auipc	a5,0x1c
    80002dc0:	32c78793          	addi	a5,a5,812 # 8001f0e8 <bcache+0x8000>
    80002dc4:	0001c717          	auipc	a4,0x1c
    80002dc8:	58c70713          	addi	a4,a4,1420 # 8001f350 <bcache+0x8268>
    80002dcc:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002dd0:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002dd4:	00014497          	auipc	s1,0x14
    80002dd8:	32c48493          	addi	s1,s1,812 # 80017100 <bcache+0x18>
    b->next = bcache.head.next;
    80002ddc:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002dde:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002de0:	00005a17          	auipc	s4,0x5
    80002de4:	728a0a13          	addi	s4,s4,1832 # 80008508 <syscalls+0xc0>
    b->next = bcache.head.next;
    80002de8:	2b893783          	ld	a5,696(s2)
    80002dec:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002dee:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002df2:	85d2                	mv	a1,s4
    80002df4:	01048513          	addi	a0,s1,16
    80002df8:	00001097          	auipc	ra,0x1
    80002dfc:	4bc080e7          	jalr	1212(ra) # 800042b4 <initsleeplock>
    bcache.head.next->prev = b;
    80002e00:	2b893783          	ld	a5,696(s2)
    80002e04:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002e06:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002e0a:	45848493          	addi	s1,s1,1112
    80002e0e:	fd349de3          	bne	s1,s3,80002de8 <binit+0x54>
  }
}
    80002e12:	70a2                	ld	ra,40(sp)
    80002e14:	7402                	ld	s0,32(sp)
    80002e16:	64e2                	ld	s1,24(sp)
    80002e18:	6942                	ld	s2,16(sp)
    80002e1a:	69a2                	ld	s3,8(sp)
    80002e1c:	6a02                	ld	s4,0(sp)
    80002e1e:	6145                	addi	sp,sp,48
    80002e20:	8082                	ret

0000000080002e22 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002e22:	7179                	addi	sp,sp,-48
    80002e24:	f406                	sd	ra,40(sp)
    80002e26:	f022                	sd	s0,32(sp)
    80002e28:	ec26                	sd	s1,24(sp)
    80002e2a:	e84a                	sd	s2,16(sp)
    80002e2c:	e44e                	sd	s3,8(sp)
    80002e2e:	1800                	addi	s0,sp,48
    80002e30:	892a                	mv	s2,a0
    80002e32:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80002e34:	00014517          	auipc	a0,0x14
    80002e38:	2b450513          	addi	a0,a0,692 # 800170e8 <bcache>
    80002e3c:	ffffe097          	auipc	ra,0xffffe
    80002e40:	d94080e7          	jalr	-620(ra) # 80000bd0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80002e44:	0001c497          	auipc	s1,0x1c
    80002e48:	55c4b483          	ld	s1,1372(s1) # 8001f3a0 <bcache+0x82b8>
    80002e4c:	0001c797          	auipc	a5,0x1c
    80002e50:	50478793          	addi	a5,a5,1284 # 8001f350 <bcache+0x8268>
    80002e54:	02f48f63          	beq	s1,a5,80002e92 <bread+0x70>
    80002e58:	873e                	mv	a4,a5
    80002e5a:	a021                	j	80002e62 <bread+0x40>
    80002e5c:	68a4                	ld	s1,80(s1)
    80002e5e:	02e48a63          	beq	s1,a4,80002e92 <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002e62:	449c                	lw	a5,8(s1)
    80002e64:	ff279ce3          	bne	a5,s2,80002e5c <bread+0x3a>
    80002e68:	44dc                	lw	a5,12(s1)
    80002e6a:	ff3799e3          	bne	a5,s3,80002e5c <bread+0x3a>
      b->refcnt++;
    80002e6e:	40bc                	lw	a5,64(s1)
    80002e70:	2785                	addiw	a5,a5,1
    80002e72:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002e74:	00014517          	auipc	a0,0x14
    80002e78:	27450513          	addi	a0,a0,628 # 800170e8 <bcache>
    80002e7c:	ffffe097          	auipc	ra,0xffffe
    80002e80:	e08080e7          	jalr	-504(ra) # 80000c84 <release>
      acquiresleep(&b->lock);
    80002e84:	01048513          	addi	a0,s1,16
    80002e88:	00001097          	auipc	ra,0x1
    80002e8c:	466080e7          	jalr	1126(ra) # 800042ee <acquiresleep>
      return b;
    80002e90:	a8b9                	j	80002eee <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002e92:	0001c497          	auipc	s1,0x1c
    80002e96:	5064b483          	ld	s1,1286(s1) # 8001f398 <bcache+0x82b0>
    80002e9a:	0001c797          	auipc	a5,0x1c
    80002e9e:	4b678793          	addi	a5,a5,1206 # 8001f350 <bcache+0x8268>
    80002ea2:	00f48863          	beq	s1,a5,80002eb2 <bread+0x90>
    80002ea6:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80002ea8:	40bc                	lw	a5,64(s1)
    80002eaa:	cf81                	beqz	a5,80002ec2 <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002eac:	64a4                	ld	s1,72(s1)
    80002eae:	fee49de3          	bne	s1,a4,80002ea8 <bread+0x86>
  panic("bget: no buffers");
    80002eb2:	00005517          	auipc	a0,0x5
    80002eb6:	65e50513          	addi	a0,a0,1630 # 80008510 <syscalls+0xc8>
    80002eba:	ffffd097          	auipc	ra,0xffffd
    80002ebe:	67e080e7          	jalr	1662(ra) # 80000538 <panic>
      b->dev = dev;
    80002ec2:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002ec6:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80002eca:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002ece:	4785                	li	a5,1
    80002ed0:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002ed2:	00014517          	auipc	a0,0x14
    80002ed6:	21650513          	addi	a0,a0,534 # 800170e8 <bcache>
    80002eda:	ffffe097          	auipc	ra,0xffffe
    80002ede:	daa080e7          	jalr	-598(ra) # 80000c84 <release>
      acquiresleep(&b->lock);
    80002ee2:	01048513          	addi	a0,s1,16
    80002ee6:	00001097          	auipc	ra,0x1
    80002eea:	408080e7          	jalr	1032(ra) # 800042ee <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002eee:	409c                	lw	a5,0(s1)
    80002ef0:	cb89                	beqz	a5,80002f02 <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002ef2:	8526                	mv	a0,s1
    80002ef4:	70a2                	ld	ra,40(sp)
    80002ef6:	7402                	ld	s0,32(sp)
    80002ef8:	64e2                	ld	s1,24(sp)
    80002efa:	6942                	ld	s2,16(sp)
    80002efc:	69a2                	ld	s3,8(sp)
    80002efe:	6145                	addi	sp,sp,48
    80002f00:	8082                	ret
    virtio_disk_rw(b, 0);
    80002f02:	4581                	li	a1,0
    80002f04:	8526                	mv	a0,s1
    80002f06:	00003097          	auipc	ra,0x3
    80002f0a:	f20080e7          	jalr	-224(ra) # 80005e26 <virtio_disk_rw>
    b->valid = 1;
    80002f0e:	4785                	li	a5,1
    80002f10:	c09c                	sw	a5,0(s1)
  return b;
    80002f12:	b7c5                	j	80002ef2 <bread+0xd0>

0000000080002f14 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002f14:	1101                	addi	sp,sp,-32
    80002f16:	ec06                	sd	ra,24(sp)
    80002f18:	e822                	sd	s0,16(sp)
    80002f1a:	e426                	sd	s1,8(sp)
    80002f1c:	1000                	addi	s0,sp,32
    80002f1e:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002f20:	0541                	addi	a0,a0,16
    80002f22:	00001097          	auipc	ra,0x1
    80002f26:	466080e7          	jalr	1126(ra) # 80004388 <holdingsleep>
    80002f2a:	cd01                	beqz	a0,80002f42 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002f2c:	4585                	li	a1,1
    80002f2e:	8526                	mv	a0,s1
    80002f30:	00003097          	auipc	ra,0x3
    80002f34:	ef6080e7          	jalr	-266(ra) # 80005e26 <virtio_disk_rw>
}
    80002f38:	60e2                	ld	ra,24(sp)
    80002f3a:	6442                	ld	s0,16(sp)
    80002f3c:	64a2                	ld	s1,8(sp)
    80002f3e:	6105                	addi	sp,sp,32
    80002f40:	8082                	ret
    panic("bwrite");
    80002f42:	00005517          	auipc	a0,0x5
    80002f46:	5e650513          	addi	a0,a0,1510 # 80008528 <syscalls+0xe0>
    80002f4a:	ffffd097          	auipc	ra,0xffffd
    80002f4e:	5ee080e7          	jalr	1518(ra) # 80000538 <panic>

0000000080002f52 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80002f52:	1101                	addi	sp,sp,-32
    80002f54:	ec06                	sd	ra,24(sp)
    80002f56:	e822                	sd	s0,16(sp)
    80002f58:	e426                	sd	s1,8(sp)
    80002f5a:	e04a                	sd	s2,0(sp)
    80002f5c:	1000                	addi	s0,sp,32
    80002f5e:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002f60:	01050913          	addi	s2,a0,16
    80002f64:	854a                	mv	a0,s2
    80002f66:	00001097          	auipc	ra,0x1
    80002f6a:	422080e7          	jalr	1058(ra) # 80004388 <holdingsleep>
    80002f6e:	c92d                	beqz	a0,80002fe0 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80002f70:	854a                	mv	a0,s2
    80002f72:	00001097          	auipc	ra,0x1
    80002f76:	3d2080e7          	jalr	978(ra) # 80004344 <releasesleep>

  acquire(&bcache.lock);
    80002f7a:	00014517          	auipc	a0,0x14
    80002f7e:	16e50513          	addi	a0,a0,366 # 800170e8 <bcache>
    80002f82:	ffffe097          	auipc	ra,0xffffe
    80002f86:	c4e080e7          	jalr	-946(ra) # 80000bd0 <acquire>
  b->refcnt--;
    80002f8a:	40bc                	lw	a5,64(s1)
    80002f8c:	37fd                	addiw	a5,a5,-1
    80002f8e:	0007871b          	sext.w	a4,a5
    80002f92:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002f94:	eb05                	bnez	a4,80002fc4 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80002f96:	68bc                	ld	a5,80(s1)
    80002f98:	64b8                	ld	a4,72(s1)
    80002f9a:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80002f9c:	64bc                	ld	a5,72(s1)
    80002f9e:	68b8                	ld	a4,80(s1)
    80002fa0:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002fa2:	0001c797          	auipc	a5,0x1c
    80002fa6:	14678793          	addi	a5,a5,326 # 8001f0e8 <bcache+0x8000>
    80002faa:	2b87b703          	ld	a4,696(a5)
    80002fae:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002fb0:	0001c717          	auipc	a4,0x1c
    80002fb4:	3a070713          	addi	a4,a4,928 # 8001f350 <bcache+0x8268>
    80002fb8:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002fba:	2b87b703          	ld	a4,696(a5)
    80002fbe:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002fc0:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    80002fc4:	00014517          	auipc	a0,0x14
    80002fc8:	12450513          	addi	a0,a0,292 # 800170e8 <bcache>
    80002fcc:	ffffe097          	auipc	ra,0xffffe
    80002fd0:	cb8080e7          	jalr	-840(ra) # 80000c84 <release>
}
    80002fd4:	60e2                	ld	ra,24(sp)
    80002fd6:	6442                	ld	s0,16(sp)
    80002fd8:	64a2                	ld	s1,8(sp)
    80002fda:	6902                	ld	s2,0(sp)
    80002fdc:	6105                	addi	sp,sp,32
    80002fde:	8082                	ret
    panic("brelse");
    80002fe0:	00005517          	auipc	a0,0x5
    80002fe4:	55050513          	addi	a0,a0,1360 # 80008530 <syscalls+0xe8>
    80002fe8:	ffffd097          	auipc	ra,0xffffd
    80002fec:	550080e7          	jalr	1360(ra) # 80000538 <panic>

0000000080002ff0 <bpin>:

void
bpin(struct buf *b) {
    80002ff0:	1101                	addi	sp,sp,-32
    80002ff2:	ec06                	sd	ra,24(sp)
    80002ff4:	e822                	sd	s0,16(sp)
    80002ff6:	e426                	sd	s1,8(sp)
    80002ff8:	1000                	addi	s0,sp,32
    80002ffa:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002ffc:	00014517          	auipc	a0,0x14
    80003000:	0ec50513          	addi	a0,a0,236 # 800170e8 <bcache>
    80003004:	ffffe097          	auipc	ra,0xffffe
    80003008:	bcc080e7          	jalr	-1076(ra) # 80000bd0 <acquire>
  b->refcnt++;
    8000300c:	40bc                	lw	a5,64(s1)
    8000300e:	2785                	addiw	a5,a5,1
    80003010:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80003012:	00014517          	auipc	a0,0x14
    80003016:	0d650513          	addi	a0,a0,214 # 800170e8 <bcache>
    8000301a:	ffffe097          	auipc	ra,0xffffe
    8000301e:	c6a080e7          	jalr	-918(ra) # 80000c84 <release>
}
    80003022:	60e2                	ld	ra,24(sp)
    80003024:	6442                	ld	s0,16(sp)
    80003026:	64a2                	ld	s1,8(sp)
    80003028:	6105                	addi	sp,sp,32
    8000302a:	8082                	ret

000000008000302c <bunpin>:

void
bunpin(struct buf *b) {
    8000302c:	1101                	addi	sp,sp,-32
    8000302e:	ec06                	sd	ra,24(sp)
    80003030:	e822                	sd	s0,16(sp)
    80003032:	e426                	sd	s1,8(sp)
    80003034:	1000                	addi	s0,sp,32
    80003036:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003038:	00014517          	auipc	a0,0x14
    8000303c:	0b050513          	addi	a0,a0,176 # 800170e8 <bcache>
    80003040:	ffffe097          	auipc	ra,0xffffe
    80003044:	b90080e7          	jalr	-1136(ra) # 80000bd0 <acquire>
  b->refcnt--;
    80003048:	40bc                	lw	a5,64(s1)
    8000304a:	37fd                	addiw	a5,a5,-1
    8000304c:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000304e:	00014517          	auipc	a0,0x14
    80003052:	09a50513          	addi	a0,a0,154 # 800170e8 <bcache>
    80003056:	ffffe097          	auipc	ra,0xffffe
    8000305a:	c2e080e7          	jalr	-978(ra) # 80000c84 <release>
}
    8000305e:	60e2                	ld	ra,24(sp)
    80003060:	6442                	ld	s0,16(sp)
    80003062:	64a2                	ld	s1,8(sp)
    80003064:	6105                	addi	sp,sp,32
    80003066:	8082                	ret

0000000080003068 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80003068:	1101                	addi	sp,sp,-32
    8000306a:	ec06                	sd	ra,24(sp)
    8000306c:	e822                	sd	s0,16(sp)
    8000306e:	e426                	sd	s1,8(sp)
    80003070:	e04a                	sd	s2,0(sp)
    80003072:	1000                	addi	s0,sp,32
    80003074:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80003076:	00d5d59b          	srliw	a1,a1,0xd
    8000307a:	0001c797          	auipc	a5,0x1c
    8000307e:	74a7a783          	lw	a5,1866(a5) # 8001f7c4 <sb+0x1c>
    80003082:	9dbd                	addw	a1,a1,a5
    80003084:	00000097          	auipc	ra,0x0
    80003088:	d9e080e7          	jalr	-610(ra) # 80002e22 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    8000308c:	0074f713          	andi	a4,s1,7
    80003090:	4785                	li	a5,1
    80003092:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    80003096:	14ce                	slli	s1,s1,0x33
    80003098:	90d9                	srli	s1,s1,0x36
    8000309a:	00950733          	add	a4,a0,s1
    8000309e:	05874703          	lbu	a4,88(a4)
    800030a2:	00e7f6b3          	and	a3,a5,a4
    800030a6:	c69d                	beqz	a3,800030d4 <bfree+0x6c>
    800030a8:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    800030aa:	94aa                	add	s1,s1,a0
    800030ac:	fff7c793          	not	a5,a5
    800030b0:	8ff9                	and	a5,a5,a4
    800030b2:	04f48c23          	sb	a5,88(s1)
  log_write(bp);
    800030b6:	00001097          	auipc	ra,0x1
    800030ba:	118080e7          	jalr	280(ra) # 800041ce <log_write>
  brelse(bp);
    800030be:	854a                	mv	a0,s2
    800030c0:	00000097          	auipc	ra,0x0
    800030c4:	e92080e7          	jalr	-366(ra) # 80002f52 <brelse>
}
    800030c8:	60e2                	ld	ra,24(sp)
    800030ca:	6442                	ld	s0,16(sp)
    800030cc:	64a2                	ld	s1,8(sp)
    800030ce:	6902                	ld	s2,0(sp)
    800030d0:	6105                	addi	sp,sp,32
    800030d2:	8082                	ret
    panic("freeing free block");
    800030d4:	00005517          	auipc	a0,0x5
    800030d8:	46450513          	addi	a0,a0,1124 # 80008538 <syscalls+0xf0>
    800030dc:	ffffd097          	auipc	ra,0xffffd
    800030e0:	45c080e7          	jalr	1116(ra) # 80000538 <panic>

00000000800030e4 <balloc>:
{
    800030e4:	711d                	addi	sp,sp,-96
    800030e6:	ec86                	sd	ra,88(sp)
    800030e8:	e8a2                	sd	s0,80(sp)
    800030ea:	e4a6                	sd	s1,72(sp)
    800030ec:	e0ca                	sd	s2,64(sp)
    800030ee:	fc4e                	sd	s3,56(sp)
    800030f0:	f852                	sd	s4,48(sp)
    800030f2:	f456                	sd	s5,40(sp)
    800030f4:	f05a                	sd	s6,32(sp)
    800030f6:	ec5e                	sd	s7,24(sp)
    800030f8:	e862                	sd	s8,16(sp)
    800030fa:	e466                	sd	s9,8(sp)
    800030fc:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    800030fe:	0001c797          	auipc	a5,0x1c
    80003102:	6ae7a783          	lw	a5,1710(a5) # 8001f7ac <sb+0x4>
    80003106:	cbd1                	beqz	a5,8000319a <balloc+0xb6>
    80003108:	8baa                	mv	s7,a0
    8000310a:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    8000310c:	0001cb17          	auipc	s6,0x1c
    80003110:	69cb0b13          	addi	s6,s6,1692 # 8001f7a8 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003114:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    80003116:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003118:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    8000311a:	6c89                	lui	s9,0x2
    8000311c:	a831                	j	80003138 <balloc+0x54>
    brelse(bp);
    8000311e:	854a                	mv	a0,s2
    80003120:	00000097          	auipc	ra,0x0
    80003124:	e32080e7          	jalr	-462(ra) # 80002f52 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80003128:	015c87bb          	addw	a5,s9,s5
    8000312c:	00078a9b          	sext.w	s5,a5
    80003130:	004b2703          	lw	a4,4(s6)
    80003134:	06eaf363          	bgeu	s5,a4,8000319a <balloc+0xb6>
    bp = bread(dev, BBLOCK(b, sb));
    80003138:	41fad79b          	sraiw	a5,s5,0x1f
    8000313c:	0137d79b          	srliw	a5,a5,0x13
    80003140:	015787bb          	addw	a5,a5,s5
    80003144:	40d7d79b          	sraiw	a5,a5,0xd
    80003148:	01cb2583          	lw	a1,28(s6)
    8000314c:	9dbd                	addw	a1,a1,a5
    8000314e:	855e                	mv	a0,s7
    80003150:	00000097          	auipc	ra,0x0
    80003154:	cd2080e7          	jalr	-814(ra) # 80002e22 <bread>
    80003158:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000315a:	004b2503          	lw	a0,4(s6)
    8000315e:	000a849b          	sext.w	s1,s5
    80003162:	8662                	mv	a2,s8
    80003164:	faa4fde3          	bgeu	s1,a0,8000311e <balloc+0x3a>
      m = 1 << (bi % 8);
    80003168:	41f6579b          	sraiw	a5,a2,0x1f
    8000316c:	01d7d69b          	srliw	a3,a5,0x1d
    80003170:	00c6873b          	addw	a4,a3,a2
    80003174:	00777793          	andi	a5,a4,7
    80003178:	9f95                	subw	a5,a5,a3
    8000317a:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    8000317e:	4037571b          	sraiw	a4,a4,0x3
    80003182:	00e906b3          	add	a3,s2,a4
    80003186:	0586c683          	lbu	a3,88(a3)
    8000318a:	00d7f5b3          	and	a1,a5,a3
    8000318e:	cd91                	beqz	a1,800031aa <balloc+0xc6>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003190:	2605                	addiw	a2,a2,1
    80003192:	2485                	addiw	s1,s1,1
    80003194:	fd4618e3          	bne	a2,s4,80003164 <balloc+0x80>
    80003198:	b759                	j	8000311e <balloc+0x3a>
  panic("balloc: out of blocks");
    8000319a:	00005517          	auipc	a0,0x5
    8000319e:	3b650513          	addi	a0,a0,950 # 80008550 <syscalls+0x108>
    800031a2:	ffffd097          	auipc	ra,0xffffd
    800031a6:	396080e7          	jalr	918(ra) # 80000538 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    800031aa:	974a                	add	a4,a4,s2
    800031ac:	8fd5                	or	a5,a5,a3
    800031ae:	04f70c23          	sb	a5,88(a4)
        log_write(bp);
    800031b2:	854a                	mv	a0,s2
    800031b4:	00001097          	auipc	ra,0x1
    800031b8:	01a080e7          	jalr	26(ra) # 800041ce <log_write>
        brelse(bp);
    800031bc:	854a                	mv	a0,s2
    800031be:	00000097          	auipc	ra,0x0
    800031c2:	d94080e7          	jalr	-620(ra) # 80002f52 <brelse>
  bp = bread(dev, bno);
    800031c6:	85a6                	mv	a1,s1
    800031c8:	855e                	mv	a0,s7
    800031ca:	00000097          	auipc	ra,0x0
    800031ce:	c58080e7          	jalr	-936(ra) # 80002e22 <bread>
    800031d2:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800031d4:	40000613          	li	a2,1024
    800031d8:	4581                	li	a1,0
    800031da:	05850513          	addi	a0,a0,88
    800031de:	ffffe097          	auipc	ra,0xffffe
    800031e2:	aee080e7          	jalr	-1298(ra) # 80000ccc <memset>
  log_write(bp);
    800031e6:	854a                	mv	a0,s2
    800031e8:	00001097          	auipc	ra,0x1
    800031ec:	fe6080e7          	jalr	-26(ra) # 800041ce <log_write>
  brelse(bp);
    800031f0:	854a                	mv	a0,s2
    800031f2:	00000097          	auipc	ra,0x0
    800031f6:	d60080e7          	jalr	-672(ra) # 80002f52 <brelse>
}
    800031fa:	8526                	mv	a0,s1
    800031fc:	60e6                	ld	ra,88(sp)
    800031fe:	6446                	ld	s0,80(sp)
    80003200:	64a6                	ld	s1,72(sp)
    80003202:	6906                	ld	s2,64(sp)
    80003204:	79e2                	ld	s3,56(sp)
    80003206:	7a42                	ld	s4,48(sp)
    80003208:	7aa2                	ld	s5,40(sp)
    8000320a:	7b02                	ld	s6,32(sp)
    8000320c:	6be2                	ld	s7,24(sp)
    8000320e:	6c42                	ld	s8,16(sp)
    80003210:	6ca2                	ld	s9,8(sp)
    80003212:	6125                	addi	sp,sp,96
    80003214:	8082                	ret

0000000080003216 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80003216:	7179                	addi	sp,sp,-48
    80003218:	f406                	sd	ra,40(sp)
    8000321a:	f022                	sd	s0,32(sp)
    8000321c:	ec26                	sd	s1,24(sp)
    8000321e:	e84a                	sd	s2,16(sp)
    80003220:	e44e                	sd	s3,8(sp)
    80003222:	e052                	sd	s4,0(sp)
    80003224:	1800                	addi	s0,sp,48
    80003226:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80003228:	47ad                	li	a5,11
    8000322a:	04b7fe63          	bgeu	a5,a1,80003286 <bmap+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    8000322e:	ff45849b          	addiw	s1,a1,-12
    80003232:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    80003236:	0ff00793          	li	a5,255
    8000323a:	0ae7e363          	bltu	a5,a4,800032e0 <bmap+0xca>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    8000323e:	08052583          	lw	a1,128(a0)
    80003242:	c5ad                	beqz	a1,800032ac <bmap+0x96>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    80003244:	00092503          	lw	a0,0(s2)
    80003248:	00000097          	auipc	ra,0x0
    8000324c:	bda080e7          	jalr	-1062(ra) # 80002e22 <bread>
    80003250:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80003252:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80003256:	02049593          	slli	a1,s1,0x20
    8000325a:	9181                	srli	a1,a1,0x20
    8000325c:	058a                	slli	a1,a1,0x2
    8000325e:	00b784b3          	add	s1,a5,a1
    80003262:	0004a983          	lw	s3,0(s1)
    80003266:	04098d63          	beqz	s3,800032c0 <bmap+0xaa>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    8000326a:	8552                	mv	a0,s4
    8000326c:	00000097          	auipc	ra,0x0
    80003270:	ce6080e7          	jalr	-794(ra) # 80002f52 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    80003274:	854e                	mv	a0,s3
    80003276:	70a2                	ld	ra,40(sp)
    80003278:	7402                	ld	s0,32(sp)
    8000327a:	64e2                	ld	s1,24(sp)
    8000327c:	6942                	ld	s2,16(sp)
    8000327e:	69a2                	ld	s3,8(sp)
    80003280:	6a02                	ld	s4,0(sp)
    80003282:	6145                	addi	sp,sp,48
    80003284:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    80003286:	02059493          	slli	s1,a1,0x20
    8000328a:	9081                	srli	s1,s1,0x20
    8000328c:	048a                	slli	s1,s1,0x2
    8000328e:	94aa                	add	s1,s1,a0
    80003290:	0504a983          	lw	s3,80(s1)
    80003294:	fe0990e3          	bnez	s3,80003274 <bmap+0x5e>
      ip->addrs[bn] = addr = balloc(ip->dev);
    80003298:	4108                	lw	a0,0(a0)
    8000329a:	00000097          	auipc	ra,0x0
    8000329e:	e4a080e7          	jalr	-438(ra) # 800030e4 <balloc>
    800032a2:	0005099b          	sext.w	s3,a0
    800032a6:	0534a823          	sw	s3,80(s1)
    800032aa:	b7e9                	j	80003274 <bmap+0x5e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    800032ac:	4108                	lw	a0,0(a0)
    800032ae:	00000097          	auipc	ra,0x0
    800032b2:	e36080e7          	jalr	-458(ra) # 800030e4 <balloc>
    800032b6:	0005059b          	sext.w	a1,a0
    800032ba:	08b92023          	sw	a1,128(s2)
    800032be:	b759                	j	80003244 <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    800032c0:	00092503          	lw	a0,0(s2)
    800032c4:	00000097          	auipc	ra,0x0
    800032c8:	e20080e7          	jalr	-480(ra) # 800030e4 <balloc>
    800032cc:	0005099b          	sext.w	s3,a0
    800032d0:	0134a023          	sw	s3,0(s1)
      log_write(bp);
    800032d4:	8552                	mv	a0,s4
    800032d6:	00001097          	auipc	ra,0x1
    800032da:	ef8080e7          	jalr	-264(ra) # 800041ce <log_write>
    800032de:	b771                	j	8000326a <bmap+0x54>
  panic("bmap: out of range");
    800032e0:	00005517          	auipc	a0,0x5
    800032e4:	28850513          	addi	a0,a0,648 # 80008568 <syscalls+0x120>
    800032e8:	ffffd097          	auipc	ra,0xffffd
    800032ec:	250080e7          	jalr	592(ra) # 80000538 <panic>

00000000800032f0 <iget>:
{
    800032f0:	7179                	addi	sp,sp,-48
    800032f2:	f406                	sd	ra,40(sp)
    800032f4:	f022                	sd	s0,32(sp)
    800032f6:	ec26                	sd	s1,24(sp)
    800032f8:	e84a                	sd	s2,16(sp)
    800032fa:	e44e                	sd	s3,8(sp)
    800032fc:	e052                	sd	s4,0(sp)
    800032fe:	1800                	addi	s0,sp,48
    80003300:	89aa                	mv	s3,a0
    80003302:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80003304:	0001c517          	auipc	a0,0x1c
    80003308:	4c450513          	addi	a0,a0,1220 # 8001f7c8 <itable>
    8000330c:	ffffe097          	auipc	ra,0xffffe
    80003310:	8c4080e7          	jalr	-1852(ra) # 80000bd0 <acquire>
  empty = 0;
    80003314:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80003316:	0001c497          	auipc	s1,0x1c
    8000331a:	4ca48493          	addi	s1,s1,1226 # 8001f7e0 <itable+0x18>
    8000331e:	0001e697          	auipc	a3,0x1e
    80003322:	f5268693          	addi	a3,a3,-174 # 80021270 <log>
    80003326:	a039                	j	80003334 <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80003328:	02090b63          	beqz	s2,8000335e <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    8000332c:	08848493          	addi	s1,s1,136
    80003330:	02d48a63          	beq	s1,a3,80003364 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80003334:	449c                	lw	a5,8(s1)
    80003336:	fef059e3          	blez	a5,80003328 <iget+0x38>
    8000333a:	4098                	lw	a4,0(s1)
    8000333c:	ff3716e3          	bne	a4,s3,80003328 <iget+0x38>
    80003340:	40d8                	lw	a4,4(s1)
    80003342:	ff4713e3          	bne	a4,s4,80003328 <iget+0x38>
      ip->ref++;
    80003346:	2785                	addiw	a5,a5,1
    80003348:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    8000334a:	0001c517          	auipc	a0,0x1c
    8000334e:	47e50513          	addi	a0,a0,1150 # 8001f7c8 <itable>
    80003352:	ffffe097          	auipc	ra,0xffffe
    80003356:	932080e7          	jalr	-1742(ra) # 80000c84 <release>
      return ip;
    8000335a:	8926                	mv	s2,s1
    8000335c:	a03d                	j	8000338a <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    8000335e:	f7f9                	bnez	a5,8000332c <iget+0x3c>
    80003360:	8926                	mv	s2,s1
    80003362:	b7e9                	j	8000332c <iget+0x3c>
  if(empty == 0)
    80003364:	02090c63          	beqz	s2,8000339c <iget+0xac>
  ip->dev = dev;
    80003368:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    8000336c:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80003370:	4785                	li	a5,1
    80003372:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80003376:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    8000337a:	0001c517          	auipc	a0,0x1c
    8000337e:	44e50513          	addi	a0,a0,1102 # 8001f7c8 <itable>
    80003382:	ffffe097          	auipc	ra,0xffffe
    80003386:	902080e7          	jalr	-1790(ra) # 80000c84 <release>
}
    8000338a:	854a                	mv	a0,s2
    8000338c:	70a2                	ld	ra,40(sp)
    8000338e:	7402                	ld	s0,32(sp)
    80003390:	64e2                	ld	s1,24(sp)
    80003392:	6942                	ld	s2,16(sp)
    80003394:	69a2                	ld	s3,8(sp)
    80003396:	6a02                	ld	s4,0(sp)
    80003398:	6145                	addi	sp,sp,48
    8000339a:	8082                	ret
    panic("iget: no inodes");
    8000339c:	00005517          	auipc	a0,0x5
    800033a0:	1e450513          	addi	a0,a0,484 # 80008580 <syscalls+0x138>
    800033a4:	ffffd097          	auipc	ra,0xffffd
    800033a8:	194080e7          	jalr	404(ra) # 80000538 <panic>

00000000800033ac <fsinit>:
fsinit(int dev) {
    800033ac:	7179                	addi	sp,sp,-48
    800033ae:	f406                	sd	ra,40(sp)
    800033b0:	f022                	sd	s0,32(sp)
    800033b2:	ec26                	sd	s1,24(sp)
    800033b4:	e84a                	sd	s2,16(sp)
    800033b6:	e44e                	sd	s3,8(sp)
    800033b8:	1800                	addi	s0,sp,48
    800033ba:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    800033bc:	4585                	li	a1,1
    800033be:	00000097          	auipc	ra,0x0
    800033c2:	a64080e7          	jalr	-1436(ra) # 80002e22 <bread>
    800033c6:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    800033c8:	0001c997          	auipc	s3,0x1c
    800033cc:	3e098993          	addi	s3,s3,992 # 8001f7a8 <sb>
    800033d0:	02000613          	li	a2,32
    800033d4:	05850593          	addi	a1,a0,88
    800033d8:	854e                	mv	a0,s3
    800033da:	ffffe097          	auipc	ra,0xffffe
    800033de:	94e080e7          	jalr	-1714(ra) # 80000d28 <memmove>
  brelse(bp);
    800033e2:	8526                	mv	a0,s1
    800033e4:	00000097          	auipc	ra,0x0
    800033e8:	b6e080e7          	jalr	-1170(ra) # 80002f52 <brelse>
  if(sb.magic != FSMAGIC)
    800033ec:	0009a703          	lw	a4,0(s3)
    800033f0:	102037b7          	lui	a5,0x10203
    800033f4:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    800033f8:	02f71263          	bne	a4,a5,8000341c <fsinit+0x70>
  initlog(dev, &sb);
    800033fc:	0001c597          	auipc	a1,0x1c
    80003400:	3ac58593          	addi	a1,a1,940 # 8001f7a8 <sb>
    80003404:	854a                	mv	a0,s2
    80003406:	00001097          	auipc	ra,0x1
    8000340a:	b4c080e7          	jalr	-1204(ra) # 80003f52 <initlog>
}
    8000340e:	70a2                	ld	ra,40(sp)
    80003410:	7402                	ld	s0,32(sp)
    80003412:	64e2                	ld	s1,24(sp)
    80003414:	6942                	ld	s2,16(sp)
    80003416:	69a2                	ld	s3,8(sp)
    80003418:	6145                	addi	sp,sp,48
    8000341a:	8082                	ret
    panic("invalid file system");
    8000341c:	00005517          	auipc	a0,0x5
    80003420:	17450513          	addi	a0,a0,372 # 80008590 <syscalls+0x148>
    80003424:	ffffd097          	auipc	ra,0xffffd
    80003428:	114080e7          	jalr	276(ra) # 80000538 <panic>

000000008000342c <iinit>:
{
    8000342c:	7179                	addi	sp,sp,-48
    8000342e:	f406                	sd	ra,40(sp)
    80003430:	f022                	sd	s0,32(sp)
    80003432:	ec26                	sd	s1,24(sp)
    80003434:	e84a                	sd	s2,16(sp)
    80003436:	e44e                	sd	s3,8(sp)
    80003438:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    8000343a:	00005597          	auipc	a1,0x5
    8000343e:	16e58593          	addi	a1,a1,366 # 800085a8 <syscalls+0x160>
    80003442:	0001c517          	auipc	a0,0x1c
    80003446:	38650513          	addi	a0,a0,902 # 8001f7c8 <itable>
    8000344a:	ffffd097          	auipc	ra,0xffffd
    8000344e:	6f6080e7          	jalr	1782(ra) # 80000b40 <initlock>
  for(i = 0; i < NINODE; i++) {
    80003452:	0001c497          	auipc	s1,0x1c
    80003456:	39e48493          	addi	s1,s1,926 # 8001f7f0 <itable+0x28>
    8000345a:	0001e997          	auipc	s3,0x1e
    8000345e:	e2698993          	addi	s3,s3,-474 # 80021280 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80003462:	00005917          	auipc	s2,0x5
    80003466:	14e90913          	addi	s2,s2,334 # 800085b0 <syscalls+0x168>
    8000346a:	85ca                	mv	a1,s2
    8000346c:	8526                	mv	a0,s1
    8000346e:	00001097          	auipc	ra,0x1
    80003472:	e46080e7          	jalr	-442(ra) # 800042b4 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80003476:	08848493          	addi	s1,s1,136
    8000347a:	ff3498e3          	bne	s1,s3,8000346a <iinit+0x3e>
}
    8000347e:	70a2                	ld	ra,40(sp)
    80003480:	7402                	ld	s0,32(sp)
    80003482:	64e2                	ld	s1,24(sp)
    80003484:	6942                	ld	s2,16(sp)
    80003486:	69a2                	ld	s3,8(sp)
    80003488:	6145                	addi	sp,sp,48
    8000348a:	8082                	ret

000000008000348c <ialloc>:
{
    8000348c:	715d                	addi	sp,sp,-80
    8000348e:	e486                	sd	ra,72(sp)
    80003490:	e0a2                	sd	s0,64(sp)
    80003492:	fc26                	sd	s1,56(sp)
    80003494:	f84a                	sd	s2,48(sp)
    80003496:	f44e                	sd	s3,40(sp)
    80003498:	f052                	sd	s4,32(sp)
    8000349a:	ec56                	sd	s5,24(sp)
    8000349c:	e85a                	sd	s6,16(sp)
    8000349e:	e45e                	sd	s7,8(sp)
    800034a0:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    800034a2:	0001c717          	auipc	a4,0x1c
    800034a6:	31272703          	lw	a4,786(a4) # 8001f7b4 <sb+0xc>
    800034aa:	4785                	li	a5,1
    800034ac:	04e7fa63          	bgeu	a5,a4,80003500 <ialloc+0x74>
    800034b0:	8aaa                	mv	s5,a0
    800034b2:	8bae                	mv	s7,a1
    800034b4:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    800034b6:	0001ca17          	auipc	s4,0x1c
    800034ba:	2f2a0a13          	addi	s4,s4,754 # 8001f7a8 <sb>
    800034be:	00048b1b          	sext.w	s6,s1
    800034c2:	0044d793          	srli	a5,s1,0x4
    800034c6:	018a2583          	lw	a1,24(s4)
    800034ca:	9dbd                	addw	a1,a1,a5
    800034cc:	8556                	mv	a0,s5
    800034ce:	00000097          	auipc	ra,0x0
    800034d2:	954080e7          	jalr	-1708(ra) # 80002e22 <bread>
    800034d6:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    800034d8:	05850993          	addi	s3,a0,88
    800034dc:	00f4f793          	andi	a5,s1,15
    800034e0:	079a                	slli	a5,a5,0x6
    800034e2:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    800034e4:	00099783          	lh	a5,0(s3)
    800034e8:	c785                	beqz	a5,80003510 <ialloc+0x84>
    brelse(bp);
    800034ea:	00000097          	auipc	ra,0x0
    800034ee:	a68080e7          	jalr	-1432(ra) # 80002f52 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    800034f2:	0485                	addi	s1,s1,1
    800034f4:	00ca2703          	lw	a4,12(s4)
    800034f8:	0004879b          	sext.w	a5,s1
    800034fc:	fce7e1e3          	bltu	a5,a4,800034be <ialloc+0x32>
  panic("ialloc: no inodes");
    80003500:	00005517          	auipc	a0,0x5
    80003504:	0b850513          	addi	a0,a0,184 # 800085b8 <syscalls+0x170>
    80003508:	ffffd097          	auipc	ra,0xffffd
    8000350c:	030080e7          	jalr	48(ra) # 80000538 <panic>
      memset(dip, 0, sizeof(*dip));
    80003510:	04000613          	li	a2,64
    80003514:	4581                	li	a1,0
    80003516:	854e                	mv	a0,s3
    80003518:	ffffd097          	auipc	ra,0xffffd
    8000351c:	7b4080e7          	jalr	1972(ra) # 80000ccc <memset>
      dip->type = type;
    80003520:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80003524:	854a                	mv	a0,s2
    80003526:	00001097          	auipc	ra,0x1
    8000352a:	ca8080e7          	jalr	-856(ra) # 800041ce <log_write>
      brelse(bp);
    8000352e:	854a                	mv	a0,s2
    80003530:	00000097          	auipc	ra,0x0
    80003534:	a22080e7          	jalr	-1502(ra) # 80002f52 <brelse>
      return iget(dev, inum);
    80003538:	85da                	mv	a1,s6
    8000353a:	8556                	mv	a0,s5
    8000353c:	00000097          	auipc	ra,0x0
    80003540:	db4080e7          	jalr	-588(ra) # 800032f0 <iget>
}
    80003544:	60a6                	ld	ra,72(sp)
    80003546:	6406                	ld	s0,64(sp)
    80003548:	74e2                	ld	s1,56(sp)
    8000354a:	7942                	ld	s2,48(sp)
    8000354c:	79a2                	ld	s3,40(sp)
    8000354e:	7a02                	ld	s4,32(sp)
    80003550:	6ae2                	ld	s5,24(sp)
    80003552:	6b42                	ld	s6,16(sp)
    80003554:	6ba2                	ld	s7,8(sp)
    80003556:	6161                	addi	sp,sp,80
    80003558:	8082                	ret

000000008000355a <iupdate>:
{
    8000355a:	1101                	addi	sp,sp,-32
    8000355c:	ec06                	sd	ra,24(sp)
    8000355e:	e822                	sd	s0,16(sp)
    80003560:	e426                	sd	s1,8(sp)
    80003562:	e04a                	sd	s2,0(sp)
    80003564:	1000                	addi	s0,sp,32
    80003566:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003568:	415c                	lw	a5,4(a0)
    8000356a:	0047d79b          	srliw	a5,a5,0x4
    8000356e:	0001c597          	auipc	a1,0x1c
    80003572:	2525a583          	lw	a1,594(a1) # 8001f7c0 <sb+0x18>
    80003576:	9dbd                	addw	a1,a1,a5
    80003578:	4108                	lw	a0,0(a0)
    8000357a:	00000097          	auipc	ra,0x0
    8000357e:	8a8080e7          	jalr	-1880(ra) # 80002e22 <bread>
    80003582:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003584:	05850793          	addi	a5,a0,88
    80003588:	40c8                	lw	a0,4(s1)
    8000358a:	893d                	andi	a0,a0,15
    8000358c:	051a                	slli	a0,a0,0x6
    8000358e:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    80003590:	04449703          	lh	a4,68(s1)
    80003594:	00e51023          	sh	a4,0(a0)
  dip->major = ip->major;
    80003598:	04649703          	lh	a4,70(s1)
    8000359c:	00e51123          	sh	a4,2(a0)
  dip->minor = ip->minor;
    800035a0:	04849703          	lh	a4,72(s1)
    800035a4:	00e51223          	sh	a4,4(a0)
  dip->nlink = ip->nlink;
    800035a8:	04a49703          	lh	a4,74(s1)
    800035ac:	00e51323          	sh	a4,6(a0)
  dip->size = ip->size;
    800035b0:	44f8                	lw	a4,76(s1)
    800035b2:	c518                	sw	a4,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    800035b4:	03400613          	li	a2,52
    800035b8:	05048593          	addi	a1,s1,80
    800035bc:	0531                	addi	a0,a0,12
    800035be:	ffffd097          	auipc	ra,0xffffd
    800035c2:	76a080e7          	jalr	1898(ra) # 80000d28 <memmove>
  log_write(bp);
    800035c6:	854a                	mv	a0,s2
    800035c8:	00001097          	auipc	ra,0x1
    800035cc:	c06080e7          	jalr	-1018(ra) # 800041ce <log_write>
  brelse(bp);
    800035d0:	854a                	mv	a0,s2
    800035d2:	00000097          	auipc	ra,0x0
    800035d6:	980080e7          	jalr	-1664(ra) # 80002f52 <brelse>
}
    800035da:	60e2                	ld	ra,24(sp)
    800035dc:	6442                	ld	s0,16(sp)
    800035de:	64a2                	ld	s1,8(sp)
    800035e0:	6902                	ld	s2,0(sp)
    800035e2:	6105                	addi	sp,sp,32
    800035e4:	8082                	ret

00000000800035e6 <idup>:
{
    800035e6:	1101                	addi	sp,sp,-32
    800035e8:	ec06                	sd	ra,24(sp)
    800035ea:	e822                	sd	s0,16(sp)
    800035ec:	e426                	sd	s1,8(sp)
    800035ee:	1000                	addi	s0,sp,32
    800035f0:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    800035f2:	0001c517          	auipc	a0,0x1c
    800035f6:	1d650513          	addi	a0,a0,470 # 8001f7c8 <itable>
    800035fa:	ffffd097          	auipc	ra,0xffffd
    800035fe:	5d6080e7          	jalr	1494(ra) # 80000bd0 <acquire>
  ip->ref++;
    80003602:	449c                	lw	a5,8(s1)
    80003604:	2785                	addiw	a5,a5,1
    80003606:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003608:	0001c517          	auipc	a0,0x1c
    8000360c:	1c050513          	addi	a0,a0,448 # 8001f7c8 <itable>
    80003610:	ffffd097          	auipc	ra,0xffffd
    80003614:	674080e7          	jalr	1652(ra) # 80000c84 <release>
}
    80003618:	8526                	mv	a0,s1
    8000361a:	60e2                	ld	ra,24(sp)
    8000361c:	6442                	ld	s0,16(sp)
    8000361e:	64a2                	ld	s1,8(sp)
    80003620:	6105                	addi	sp,sp,32
    80003622:	8082                	ret

0000000080003624 <ilock>:
{
    80003624:	1101                	addi	sp,sp,-32
    80003626:	ec06                	sd	ra,24(sp)
    80003628:	e822                	sd	s0,16(sp)
    8000362a:	e426                	sd	s1,8(sp)
    8000362c:	e04a                	sd	s2,0(sp)
    8000362e:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80003630:	c115                	beqz	a0,80003654 <ilock+0x30>
    80003632:	84aa                	mv	s1,a0
    80003634:	451c                	lw	a5,8(a0)
    80003636:	00f05f63          	blez	a5,80003654 <ilock+0x30>
  acquiresleep(&ip->lock);
    8000363a:	0541                	addi	a0,a0,16
    8000363c:	00001097          	auipc	ra,0x1
    80003640:	cb2080e7          	jalr	-846(ra) # 800042ee <acquiresleep>
  if(ip->valid == 0){
    80003644:	40bc                	lw	a5,64(s1)
    80003646:	cf99                	beqz	a5,80003664 <ilock+0x40>
}
    80003648:	60e2                	ld	ra,24(sp)
    8000364a:	6442                	ld	s0,16(sp)
    8000364c:	64a2                	ld	s1,8(sp)
    8000364e:	6902                	ld	s2,0(sp)
    80003650:	6105                	addi	sp,sp,32
    80003652:	8082                	ret
    panic("ilock");
    80003654:	00005517          	auipc	a0,0x5
    80003658:	f7c50513          	addi	a0,a0,-132 # 800085d0 <syscalls+0x188>
    8000365c:	ffffd097          	auipc	ra,0xffffd
    80003660:	edc080e7          	jalr	-292(ra) # 80000538 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003664:	40dc                	lw	a5,4(s1)
    80003666:	0047d79b          	srliw	a5,a5,0x4
    8000366a:	0001c597          	auipc	a1,0x1c
    8000366e:	1565a583          	lw	a1,342(a1) # 8001f7c0 <sb+0x18>
    80003672:	9dbd                	addw	a1,a1,a5
    80003674:	4088                	lw	a0,0(s1)
    80003676:	fffff097          	auipc	ra,0xfffff
    8000367a:	7ac080e7          	jalr	1964(ra) # 80002e22 <bread>
    8000367e:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003680:	05850593          	addi	a1,a0,88
    80003684:	40dc                	lw	a5,4(s1)
    80003686:	8bbd                	andi	a5,a5,15
    80003688:	079a                	slli	a5,a5,0x6
    8000368a:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    8000368c:	00059783          	lh	a5,0(a1)
    80003690:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80003694:	00259783          	lh	a5,2(a1)
    80003698:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    8000369c:	00459783          	lh	a5,4(a1)
    800036a0:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    800036a4:	00659783          	lh	a5,6(a1)
    800036a8:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    800036ac:	459c                	lw	a5,8(a1)
    800036ae:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    800036b0:	03400613          	li	a2,52
    800036b4:	05b1                	addi	a1,a1,12
    800036b6:	05048513          	addi	a0,s1,80
    800036ba:	ffffd097          	auipc	ra,0xffffd
    800036be:	66e080e7          	jalr	1646(ra) # 80000d28 <memmove>
    brelse(bp);
    800036c2:	854a                	mv	a0,s2
    800036c4:	00000097          	auipc	ra,0x0
    800036c8:	88e080e7          	jalr	-1906(ra) # 80002f52 <brelse>
    ip->valid = 1;
    800036cc:	4785                	li	a5,1
    800036ce:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    800036d0:	04449783          	lh	a5,68(s1)
    800036d4:	fbb5                	bnez	a5,80003648 <ilock+0x24>
      panic("ilock: no type");
    800036d6:	00005517          	auipc	a0,0x5
    800036da:	f0250513          	addi	a0,a0,-254 # 800085d8 <syscalls+0x190>
    800036de:	ffffd097          	auipc	ra,0xffffd
    800036e2:	e5a080e7          	jalr	-422(ra) # 80000538 <panic>

00000000800036e6 <iunlock>:
{
    800036e6:	1101                	addi	sp,sp,-32
    800036e8:	ec06                	sd	ra,24(sp)
    800036ea:	e822                	sd	s0,16(sp)
    800036ec:	e426                	sd	s1,8(sp)
    800036ee:	e04a                	sd	s2,0(sp)
    800036f0:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    800036f2:	c905                	beqz	a0,80003722 <iunlock+0x3c>
    800036f4:	84aa                	mv	s1,a0
    800036f6:	01050913          	addi	s2,a0,16
    800036fa:	854a                	mv	a0,s2
    800036fc:	00001097          	auipc	ra,0x1
    80003700:	c8c080e7          	jalr	-884(ra) # 80004388 <holdingsleep>
    80003704:	cd19                	beqz	a0,80003722 <iunlock+0x3c>
    80003706:	449c                	lw	a5,8(s1)
    80003708:	00f05d63          	blez	a5,80003722 <iunlock+0x3c>
  releasesleep(&ip->lock);
    8000370c:	854a                	mv	a0,s2
    8000370e:	00001097          	auipc	ra,0x1
    80003712:	c36080e7          	jalr	-970(ra) # 80004344 <releasesleep>
}
    80003716:	60e2                	ld	ra,24(sp)
    80003718:	6442                	ld	s0,16(sp)
    8000371a:	64a2                	ld	s1,8(sp)
    8000371c:	6902                	ld	s2,0(sp)
    8000371e:	6105                	addi	sp,sp,32
    80003720:	8082                	ret
    panic("iunlock");
    80003722:	00005517          	auipc	a0,0x5
    80003726:	ec650513          	addi	a0,a0,-314 # 800085e8 <syscalls+0x1a0>
    8000372a:	ffffd097          	auipc	ra,0xffffd
    8000372e:	e0e080e7          	jalr	-498(ra) # 80000538 <panic>

0000000080003732 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80003732:	7179                	addi	sp,sp,-48
    80003734:	f406                	sd	ra,40(sp)
    80003736:	f022                	sd	s0,32(sp)
    80003738:	ec26                	sd	s1,24(sp)
    8000373a:	e84a                	sd	s2,16(sp)
    8000373c:	e44e                	sd	s3,8(sp)
    8000373e:	e052                	sd	s4,0(sp)
    80003740:	1800                	addi	s0,sp,48
    80003742:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80003744:	05050493          	addi	s1,a0,80
    80003748:	08050913          	addi	s2,a0,128
    8000374c:	a021                	j	80003754 <itrunc+0x22>
    8000374e:	0491                	addi	s1,s1,4
    80003750:	01248d63          	beq	s1,s2,8000376a <itrunc+0x38>
    if(ip->addrs[i]){
    80003754:	408c                	lw	a1,0(s1)
    80003756:	dde5                	beqz	a1,8000374e <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80003758:	0009a503          	lw	a0,0(s3)
    8000375c:	00000097          	auipc	ra,0x0
    80003760:	90c080e7          	jalr	-1780(ra) # 80003068 <bfree>
      ip->addrs[i] = 0;
    80003764:	0004a023          	sw	zero,0(s1)
    80003768:	b7dd                	j	8000374e <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    8000376a:	0809a583          	lw	a1,128(s3)
    8000376e:	e185                	bnez	a1,8000378e <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80003770:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80003774:	854e                	mv	a0,s3
    80003776:	00000097          	auipc	ra,0x0
    8000377a:	de4080e7          	jalr	-540(ra) # 8000355a <iupdate>
}
    8000377e:	70a2                	ld	ra,40(sp)
    80003780:	7402                	ld	s0,32(sp)
    80003782:	64e2                	ld	s1,24(sp)
    80003784:	6942                	ld	s2,16(sp)
    80003786:	69a2                	ld	s3,8(sp)
    80003788:	6a02                	ld	s4,0(sp)
    8000378a:	6145                	addi	sp,sp,48
    8000378c:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    8000378e:	0009a503          	lw	a0,0(s3)
    80003792:	fffff097          	auipc	ra,0xfffff
    80003796:	690080e7          	jalr	1680(ra) # 80002e22 <bread>
    8000379a:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    8000379c:	05850493          	addi	s1,a0,88
    800037a0:	45850913          	addi	s2,a0,1112
    800037a4:	a021                	j	800037ac <itrunc+0x7a>
    800037a6:	0491                	addi	s1,s1,4
    800037a8:	01248b63          	beq	s1,s2,800037be <itrunc+0x8c>
      if(a[j])
    800037ac:	408c                	lw	a1,0(s1)
    800037ae:	dde5                	beqz	a1,800037a6 <itrunc+0x74>
        bfree(ip->dev, a[j]);
    800037b0:	0009a503          	lw	a0,0(s3)
    800037b4:	00000097          	auipc	ra,0x0
    800037b8:	8b4080e7          	jalr	-1868(ra) # 80003068 <bfree>
    800037bc:	b7ed                	j	800037a6 <itrunc+0x74>
    brelse(bp);
    800037be:	8552                	mv	a0,s4
    800037c0:	fffff097          	auipc	ra,0xfffff
    800037c4:	792080e7          	jalr	1938(ra) # 80002f52 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    800037c8:	0809a583          	lw	a1,128(s3)
    800037cc:	0009a503          	lw	a0,0(s3)
    800037d0:	00000097          	auipc	ra,0x0
    800037d4:	898080e7          	jalr	-1896(ra) # 80003068 <bfree>
    ip->addrs[NDIRECT] = 0;
    800037d8:	0809a023          	sw	zero,128(s3)
    800037dc:	bf51                	j	80003770 <itrunc+0x3e>

00000000800037de <iput>:
{
    800037de:	1101                	addi	sp,sp,-32
    800037e0:	ec06                	sd	ra,24(sp)
    800037e2:	e822                	sd	s0,16(sp)
    800037e4:	e426                	sd	s1,8(sp)
    800037e6:	e04a                	sd	s2,0(sp)
    800037e8:	1000                	addi	s0,sp,32
    800037ea:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    800037ec:	0001c517          	auipc	a0,0x1c
    800037f0:	fdc50513          	addi	a0,a0,-36 # 8001f7c8 <itable>
    800037f4:	ffffd097          	auipc	ra,0xffffd
    800037f8:	3dc080e7          	jalr	988(ra) # 80000bd0 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800037fc:	4498                	lw	a4,8(s1)
    800037fe:	4785                	li	a5,1
    80003800:	02f70363          	beq	a4,a5,80003826 <iput+0x48>
  ip->ref--;
    80003804:	449c                	lw	a5,8(s1)
    80003806:	37fd                	addiw	a5,a5,-1
    80003808:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    8000380a:	0001c517          	auipc	a0,0x1c
    8000380e:	fbe50513          	addi	a0,a0,-66 # 8001f7c8 <itable>
    80003812:	ffffd097          	auipc	ra,0xffffd
    80003816:	472080e7          	jalr	1138(ra) # 80000c84 <release>
}
    8000381a:	60e2                	ld	ra,24(sp)
    8000381c:	6442                	ld	s0,16(sp)
    8000381e:	64a2                	ld	s1,8(sp)
    80003820:	6902                	ld	s2,0(sp)
    80003822:	6105                	addi	sp,sp,32
    80003824:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003826:	40bc                	lw	a5,64(s1)
    80003828:	dff1                	beqz	a5,80003804 <iput+0x26>
    8000382a:	04a49783          	lh	a5,74(s1)
    8000382e:	fbf9                	bnez	a5,80003804 <iput+0x26>
    acquiresleep(&ip->lock);
    80003830:	01048913          	addi	s2,s1,16
    80003834:	854a                	mv	a0,s2
    80003836:	00001097          	auipc	ra,0x1
    8000383a:	ab8080e7          	jalr	-1352(ra) # 800042ee <acquiresleep>
    release(&itable.lock);
    8000383e:	0001c517          	auipc	a0,0x1c
    80003842:	f8a50513          	addi	a0,a0,-118 # 8001f7c8 <itable>
    80003846:	ffffd097          	auipc	ra,0xffffd
    8000384a:	43e080e7          	jalr	1086(ra) # 80000c84 <release>
    itrunc(ip);
    8000384e:	8526                	mv	a0,s1
    80003850:	00000097          	auipc	ra,0x0
    80003854:	ee2080e7          	jalr	-286(ra) # 80003732 <itrunc>
    ip->type = 0;
    80003858:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    8000385c:	8526                	mv	a0,s1
    8000385e:	00000097          	auipc	ra,0x0
    80003862:	cfc080e7          	jalr	-772(ra) # 8000355a <iupdate>
    ip->valid = 0;
    80003866:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    8000386a:	854a                	mv	a0,s2
    8000386c:	00001097          	auipc	ra,0x1
    80003870:	ad8080e7          	jalr	-1320(ra) # 80004344 <releasesleep>
    acquire(&itable.lock);
    80003874:	0001c517          	auipc	a0,0x1c
    80003878:	f5450513          	addi	a0,a0,-172 # 8001f7c8 <itable>
    8000387c:	ffffd097          	auipc	ra,0xffffd
    80003880:	354080e7          	jalr	852(ra) # 80000bd0 <acquire>
    80003884:	b741                	j	80003804 <iput+0x26>

0000000080003886 <iunlockput>:
{
    80003886:	1101                	addi	sp,sp,-32
    80003888:	ec06                	sd	ra,24(sp)
    8000388a:	e822                	sd	s0,16(sp)
    8000388c:	e426                	sd	s1,8(sp)
    8000388e:	1000                	addi	s0,sp,32
    80003890:	84aa                	mv	s1,a0
  iunlock(ip);
    80003892:	00000097          	auipc	ra,0x0
    80003896:	e54080e7          	jalr	-428(ra) # 800036e6 <iunlock>
  iput(ip);
    8000389a:	8526                	mv	a0,s1
    8000389c:	00000097          	auipc	ra,0x0
    800038a0:	f42080e7          	jalr	-190(ra) # 800037de <iput>
}
    800038a4:	60e2                	ld	ra,24(sp)
    800038a6:	6442                	ld	s0,16(sp)
    800038a8:	64a2                	ld	s1,8(sp)
    800038aa:	6105                	addi	sp,sp,32
    800038ac:	8082                	ret

00000000800038ae <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    800038ae:	1141                	addi	sp,sp,-16
    800038b0:	e422                	sd	s0,8(sp)
    800038b2:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    800038b4:	411c                	lw	a5,0(a0)
    800038b6:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    800038b8:	415c                	lw	a5,4(a0)
    800038ba:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    800038bc:	04451783          	lh	a5,68(a0)
    800038c0:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    800038c4:	04a51783          	lh	a5,74(a0)
    800038c8:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    800038cc:	04c56783          	lwu	a5,76(a0)
    800038d0:	e99c                	sd	a5,16(a1)
}
    800038d2:	6422                	ld	s0,8(sp)
    800038d4:	0141                	addi	sp,sp,16
    800038d6:	8082                	ret

00000000800038d8 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800038d8:	457c                	lw	a5,76(a0)
    800038da:	0ed7e963          	bltu	a5,a3,800039cc <readi+0xf4>
{
    800038de:	7159                	addi	sp,sp,-112
    800038e0:	f486                	sd	ra,104(sp)
    800038e2:	f0a2                	sd	s0,96(sp)
    800038e4:	eca6                	sd	s1,88(sp)
    800038e6:	e8ca                	sd	s2,80(sp)
    800038e8:	e4ce                	sd	s3,72(sp)
    800038ea:	e0d2                	sd	s4,64(sp)
    800038ec:	fc56                	sd	s5,56(sp)
    800038ee:	f85a                	sd	s6,48(sp)
    800038f0:	f45e                	sd	s7,40(sp)
    800038f2:	f062                	sd	s8,32(sp)
    800038f4:	ec66                	sd	s9,24(sp)
    800038f6:	e86a                	sd	s10,16(sp)
    800038f8:	e46e                	sd	s11,8(sp)
    800038fa:	1880                	addi	s0,sp,112
    800038fc:	8baa                	mv	s7,a0
    800038fe:	8c2e                	mv	s8,a1
    80003900:	8ab2                	mv	s5,a2
    80003902:	84b6                	mv	s1,a3
    80003904:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003906:	9f35                	addw	a4,a4,a3
    return 0;
    80003908:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    8000390a:	0ad76063          	bltu	a4,a3,800039aa <readi+0xd2>
  if(off + n > ip->size)
    8000390e:	00e7f463          	bgeu	a5,a4,80003916 <readi+0x3e>
    n = ip->size - off;
    80003912:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003916:	0a0b0963          	beqz	s6,800039c8 <readi+0xf0>
    8000391a:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    8000391c:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80003920:	5cfd                	li	s9,-1
    80003922:	a82d                	j	8000395c <readi+0x84>
    80003924:	020a1d93          	slli	s11,s4,0x20
    80003928:	020ddd93          	srli	s11,s11,0x20
    8000392c:	05890793          	addi	a5,s2,88
    80003930:	86ee                	mv	a3,s11
    80003932:	963e                	add	a2,a2,a5
    80003934:	85d6                	mv	a1,s5
    80003936:	8562                	mv	a0,s8
    80003938:	fffff097          	auipc	ra,0xfffff
    8000393c:	ac2080e7          	jalr	-1342(ra) # 800023fa <either_copyout>
    80003940:	05950d63          	beq	a0,s9,8000399a <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80003944:	854a                	mv	a0,s2
    80003946:	fffff097          	auipc	ra,0xfffff
    8000394a:	60c080e7          	jalr	1548(ra) # 80002f52 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000394e:	013a09bb          	addw	s3,s4,s3
    80003952:	009a04bb          	addw	s1,s4,s1
    80003956:	9aee                	add	s5,s5,s11
    80003958:	0569f763          	bgeu	s3,s6,800039a6 <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    8000395c:	000ba903          	lw	s2,0(s7)
    80003960:	00a4d59b          	srliw	a1,s1,0xa
    80003964:	855e                	mv	a0,s7
    80003966:	00000097          	auipc	ra,0x0
    8000396a:	8b0080e7          	jalr	-1872(ra) # 80003216 <bmap>
    8000396e:	0005059b          	sext.w	a1,a0
    80003972:	854a                	mv	a0,s2
    80003974:	fffff097          	auipc	ra,0xfffff
    80003978:	4ae080e7          	jalr	1198(ra) # 80002e22 <bread>
    8000397c:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    8000397e:	3ff4f613          	andi	a2,s1,1023
    80003982:	40cd07bb          	subw	a5,s10,a2
    80003986:	413b073b          	subw	a4,s6,s3
    8000398a:	8a3e                	mv	s4,a5
    8000398c:	2781                	sext.w	a5,a5
    8000398e:	0007069b          	sext.w	a3,a4
    80003992:	f8f6f9e3          	bgeu	a3,a5,80003924 <readi+0x4c>
    80003996:	8a3a                	mv	s4,a4
    80003998:	b771                	j	80003924 <readi+0x4c>
      brelse(bp);
    8000399a:	854a                	mv	a0,s2
    8000399c:	fffff097          	auipc	ra,0xfffff
    800039a0:	5b6080e7          	jalr	1462(ra) # 80002f52 <brelse>
      tot = -1;
    800039a4:	59fd                	li	s3,-1
  }
  return tot;
    800039a6:	0009851b          	sext.w	a0,s3
}
    800039aa:	70a6                	ld	ra,104(sp)
    800039ac:	7406                	ld	s0,96(sp)
    800039ae:	64e6                	ld	s1,88(sp)
    800039b0:	6946                	ld	s2,80(sp)
    800039b2:	69a6                	ld	s3,72(sp)
    800039b4:	6a06                	ld	s4,64(sp)
    800039b6:	7ae2                	ld	s5,56(sp)
    800039b8:	7b42                	ld	s6,48(sp)
    800039ba:	7ba2                	ld	s7,40(sp)
    800039bc:	7c02                	ld	s8,32(sp)
    800039be:	6ce2                	ld	s9,24(sp)
    800039c0:	6d42                	ld	s10,16(sp)
    800039c2:	6da2                	ld	s11,8(sp)
    800039c4:	6165                	addi	sp,sp,112
    800039c6:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800039c8:	89da                	mv	s3,s6
    800039ca:	bff1                	j	800039a6 <readi+0xce>
    return 0;
    800039cc:	4501                	li	a0,0
}
    800039ce:	8082                	ret

00000000800039d0 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800039d0:	457c                	lw	a5,76(a0)
    800039d2:	10d7e863          	bltu	a5,a3,80003ae2 <writei+0x112>
{
    800039d6:	7159                	addi	sp,sp,-112
    800039d8:	f486                	sd	ra,104(sp)
    800039da:	f0a2                	sd	s0,96(sp)
    800039dc:	eca6                	sd	s1,88(sp)
    800039de:	e8ca                	sd	s2,80(sp)
    800039e0:	e4ce                	sd	s3,72(sp)
    800039e2:	e0d2                	sd	s4,64(sp)
    800039e4:	fc56                	sd	s5,56(sp)
    800039e6:	f85a                	sd	s6,48(sp)
    800039e8:	f45e                	sd	s7,40(sp)
    800039ea:	f062                	sd	s8,32(sp)
    800039ec:	ec66                	sd	s9,24(sp)
    800039ee:	e86a                	sd	s10,16(sp)
    800039f0:	e46e                	sd	s11,8(sp)
    800039f2:	1880                	addi	s0,sp,112
    800039f4:	8b2a                	mv	s6,a0
    800039f6:	8c2e                	mv	s8,a1
    800039f8:	8ab2                	mv	s5,a2
    800039fa:	8936                	mv	s2,a3
    800039fc:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    800039fe:	00e687bb          	addw	a5,a3,a4
    80003a02:	0ed7e263          	bltu	a5,a3,80003ae6 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80003a06:	00043737          	lui	a4,0x43
    80003a0a:	0ef76063          	bltu	a4,a5,80003aea <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003a0e:	0c0b8863          	beqz	s7,80003ade <writei+0x10e>
    80003a12:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003a14:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003a18:	5cfd                	li	s9,-1
    80003a1a:	a091                	j	80003a5e <writei+0x8e>
    80003a1c:	02099d93          	slli	s11,s3,0x20
    80003a20:	020ddd93          	srli	s11,s11,0x20
    80003a24:	05848793          	addi	a5,s1,88
    80003a28:	86ee                	mv	a3,s11
    80003a2a:	8656                	mv	a2,s5
    80003a2c:	85e2                	mv	a1,s8
    80003a2e:	953e                	add	a0,a0,a5
    80003a30:	fffff097          	auipc	ra,0xfffff
    80003a34:	a20080e7          	jalr	-1504(ra) # 80002450 <either_copyin>
    80003a38:	07950263          	beq	a0,s9,80003a9c <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80003a3c:	8526                	mv	a0,s1
    80003a3e:	00000097          	auipc	ra,0x0
    80003a42:	790080e7          	jalr	1936(ra) # 800041ce <log_write>
    brelse(bp);
    80003a46:	8526                	mv	a0,s1
    80003a48:	fffff097          	auipc	ra,0xfffff
    80003a4c:	50a080e7          	jalr	1290(ra) # 80002f52 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003a50:	01498a3b          	addw	s4,s3,s4
    80003a54:	0129893b          	addw	s2,s3,s2
    80003a58:	9aee                	add	s5,s5,s11
    80003a5a:	057a7663          	bgeu	s4,s7,80003aa6 <writei+0xd6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003a5e:	000b2483          	lw	s1,0(s6)
    80003a62:	00a9559b          	srliw	a1,s2,0xa
    80003a66:	855a                	mv	a0,s6
    80003a68:	fffff097          	auipc	ra,0xfffff
    80003a6c:	7ae080e7          	jalr	1966(ra) # 80003216 <bmap>
    80003a70:	0005059b          	sext.w	a1,a0
    80003a74:	8526                	mv	a0,s1
    80003a76:	fffff097          	auipc	ra,0xfffff
    80003a7a:	3ac080e7          	jalr	940(ra) # 80002e22 <bread>
    80003a7e:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003a80:	3ff97513          	andi	a0,s2,1023
    80003a84:	40ad07bb          	subw	a5,s10,a0
    80003a88:	414b873b          	subw	a4,s7,s4
    80003a8c:	89be                	mv	s3,a5
    80003a8e:	2781                	sext.w	a5,a5
    80003a90:	0007069b          	sext.w	a3,a4
    80003a94:	f8f6f4e3          	bgeu	a3,a5,80003a1c <writei+0x4c>
    80003a98:	89ba                	mv	s3,a4
    80003a9a:	b749                	j	80003a1c <writei+0x4c>
      brelse(bp);
    80003a9c:	8526                	mv	a0,s1
    80003a9e:	fffff097          	auipc	ra,0xfffff
    80003aa2:	4b4080e7          	jalr	1204(ra) # 80002f52 <brelse>
  }

  if(off > ip->size)
    80003aa6:	04cb2783          	lw	a5,76(s6)
    80003aaa:	0127f463          	bgeu	a5,s2,80003ab2 <writei+0xe2>
    ip->size = off;
    80003aae:	052b2623          	sw	s2,76(s6)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003ab2:	855a                	mv	a0,s6
    80003ab4:	00000097          	auipc	ra,0x0
    80003ab8:	aa6080e7          	jalr	-1370(ra) # 8000355a <iupdate>

  return tot;
    80003abc:	000a051b          	sext.w	a0,s4
}
    80003ac0:	70a6                	ld	ra,104(sp)
    80003ac2:	7406                	ld	s0,96(sp)
    80003ac4:	64e6                	ld	s1,88(sp)
    80003ac6:	6946                	ld	s2,80(sp)
    80003ac8:	69a6                	ld	s3,72(sp)
    80003aca:	6a06                	ld	s4,64(sp)
    80003acc:	7ae2                	ld	s5,56(sp)
    80003ace:	7b42                	ld	s6,48(sp)
    80003ad0:	7ba2                	ld	s7,40(sp)
    80003ad2:	7c02                	ld	s8,32(sp)
    80003ad4:	6ce2                	ld	s9,24(sp)
    80003ad6:	6d42                	ld	s10,16(sp)
    80003ad8:	6da2                	ld	s11,8(sp)
    80003ada:	6165                	addi	sp,sp,112
    80003adc:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003ade:	8a5e                	mv	s4,s7
    80003ae0:	bfc9                	j	80003ab2 <writei+0xe2>
    return -1;
    80003ae2:	557d                	li	a0,-1
}
    80003ae4:	8082                	ret
    return -1;
    80003ae6:	557d                	li	a0,-1
    80003ae8:	bfe1                	j	80003ac0 <writei+0xf0>
    return -1;
    80003aea:	557d                	li	a0,-1
    80003aec:	bfd1                	j	80003ac0 <writei+0xf0>

0000000080003aee <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003aee:	1141                	addi	sp,sp,-16
    80003af0:	e406                	sd	ra,8(sp)
    80003af2:	e022                	sd	s0,0(sp)
    80003af4:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003af6:	4639                	li	a2,14
    80003af8:	ffffd097          	auipc	ra,0xffffd
    80003afc:	2a4080e7          	jalr	676(ra) # 80000d9c <strncmp>
}
    80003b00:	60a2                	ld	ra,8(sp)
    80003b02:	6402                	ld	s0,0(sp)
    80003b04:	0141                	addi	sp,sp,16
    80003b06:	8082                	ret

0000000080003b08 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80003b08:	7139                	addi	sp,sp,-64
    80003b0a:	fc06                	sd	ra,56(sp)
    80003b0c:	f822                	sd	s0,48(sp)
    80003b0e:	f426                	sd	s1,40(sp)
    80003b10:	f04a                	sd	s2,32(sp)
    80003b12:	ec4e                	sd	s3,24(sp)
    80003b14:	e852                	sd	s4,16(sp)
    80003b16:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003b18:	04451703          	lh	a4,68(a0)
    80003b1c:	4785                	li	a5,1
    80003b1e:	00f71a63          	bne	a4,a5,80003b32 <dirlookup+0x2a>
    80003b22:	892a                	mv	s2,a0
    80003b24:	89ae                	mv	s3,a1
    80003b26:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003b28:	457c                	lw	a5,76(a0)
    80003b2a:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003b2c:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003b2e:	e79d                	bnez	a5,80003b5c <dirlookup+0x54>
    80003b30:	a8a5                	j	80003ba8 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003b32:	00005517          	auipc	a0,0x5
    80003b36:	abe50513          	addi	a0,a0,-1346 # 800085f0 <syscalls+0x1a8>
    80003b3a:	ffffd097          	auipc	ra,0xffffd
    80003b3e:	9fe080e7          	jalr	-1538(ra) # 80000538 <panic>
      panic("dirlookup read");
    80003b42:	00005517          	auipc	a0,0x5
    80003b46:	ac650513          	addi	a0,a0,-1338 # 80008608 <syscalls+0x1c0>
    80003b4a:	ffffd097          	auipc	ra,0xffffd
    80003b4e:	9ee080e7          	jalr	-1554(ra) # 80000538 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003b52:	24c1                	addiw	s1,s1,16
    80003b54:	04c92783          	lw	a5,76(s2)
    80003b58:	04f4f763          	bgeu	s1,a5,80003ba6 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003b5c:	4741                	li	a4,16
    80003b5e:	86a6                	mv	a3,s1
    80003b60:	fc040613          	addi	a2,s0,-64
    80003b64:	4581                	li	a1,0
    80003b66:	854a                	mv	a0,s2
    80003b68:	00000097          	auipc	ra,0x0
    80003b6c:	d70080e7          	jalr	-656(ra) # 800038d8 <readi>
    80003b70:	47c1                	li	a5,16
    80003b72:	fcf518e3          	bne	a0,a5,80003b42 <dirlookup+0x3a>
    if(de.inum == 0)
    80003b76:	fc045783          	lhu	a5,-64(s0)
    80003b7a:	dfe1                	beqz	a5,80003b52 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80003b7c:	fc240593          	addi	a1,s0,-62
    80003b80:	854e                	mv	a0,s3
    80003b82:	00000097          	auipc	ra,0x0
    80003b86:	f6c080e7          	jalr	-148(ra) # 80003aee <namecmp>
    80003b8a:	f561                	bnez	a0,80003b52 <dirlookup+0x4a>
      if(poff)
    80003b8c:	000a0463          	beqz	s4,80003b94 <dirlookup+0x8c>
        *poff = off;
    80003b90:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80003b94:	fc045583          	lhu	a1,-64(s0)
    80003b98:	00092503          	lw	a0,0(s2)
    80003b9c:	fffff097          	auipc	ra,0xfffff
    80003ba0:	754080e7          	jalr	1876(ra) # 800032f0 <iget>
    80003ba4:	a011                	j	80003ba8 <dirlookup+0xa0>
  return 0;
    80003ba6:	4501                	li	a0,0
}
    80003ba8:	70e2                	ld	ra,56(sp)
    80003baa:	7442                	ld	s0,48(sp)
    80003bac:	74a2                	ld	s1,40(sp)
    80003bae:	7902                	ld	s2,32(sp)
    80003bb0:	69e2                	ld	s3,24(sp)
    80003bb2:	6a42                	ld	s4,16(sp)
    80003bb4:	6121                	addi	sp,sp,64
    80003bb6:	8082                	ret

0000000080003bb8 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003bb8:	711d                	addi	sp,sp,-96
    80003bba:	ec86                	sd	ra,88(sp)
    80003bbc:	e8a2                	sd	s0,80(sp)
    80003bbe:	e4a6                	sd	s1,72(sp)
    80003bc0:	e0ca                	sd	s2,64(sp)
    80003bc2:	fc4e                	sd	s3,56(sp)
    80003bc4:	f852                	sd	s4,48(sp)
    80003bc6:	f456                	sd	s5,40(sp)
    80003bc8:	f05a                	sd	s6,32(sp)
    80003bca:	ec5e                	sd	s7,24(sp)
    80003bcc:	e862                	sd	s8,16(sp)
    80003bce:	e466                	sd	s9,8(sp)
    80003bd0:	1080                	addi	s0,sp,96
    80003bd2:	84aa                	mv	s1,a0
    80003bd4:	8aae                	mv	s5,a1
    80003bd6:	8a32                	mv	s4,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003bd8:	00054703          	lbu	a4,0(a0)
    80003bdc:	02f00793          	li	a5,47
    80003be0:	02f70363          	beq	a4,a5,80003c06 <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003be4:	ffffe097          	auipc	ra,0xffffe
    80003be8:	db2080e7          	jalr	-590(ra) # 80001996 <myproc>
    80003bec:	15053503          	ld	a0,336(a0)
    80003bf0:	00000097          	auipc	ra,0x0
    80003bf4:	9f6080e7          	jalr	-1546(ra) # 800035e6 <idup>
    80003bf8:	89aa                	mv	s3,a0
  while(*path == '/')
    80003bfa:	02f00913          	li	s2,47
  len = path - s;
    80003bfe:	4b01                	li	s6,0
  if(len >= DIRSIZ)
    80003c00:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003c02:	4b85                	li	s7,1
    80003c04:	a865                	j	80003cbc <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    80003c06:	4585                	li	a1,1
    80003c08:	4505                	li	a0,1
    80003c0a:	fffff097          	auipc	ra,0xfffff
    80003c0e:	6e6080e7          	jalr	1766(ra) # 800032f0 <iget>
    80003c12:	89aa                	mv	s3,a0
    80003c14:	b7dd                	j	80003bfa <namex+0x42>
      iunlockput(ip);
    80003c16:	854e                	mv	a0,s3
    80003c18:	00000097          	auipc	ra,0x0
    80003c1c:	c6e080e7          	jalr	-914(ra) # 80003886 <iunlockput>
      return 0;
    80003c20:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003c22:	854e                	mv	a0,s3
    80003c24:	60e6                	ld	ra,88(sp)
    80003c26:	6446                	ld	s0,80(sp)
    80003c28:	64a6                	ld	s1,72(sp)
    80003c2a:	6906                	ld	s2,64(sp)
    80003c2c:	79e2                	ld	s3,56(sp)
    80003c2e:	7a42                	ld	s4,48(sp)
    80003c30:	7aa2                	ld	s5,40(sp)
    80003c32:	7b02                	ld	s6,32(sp)
    80003c34:	6be2                	ld	s7,24(sp)
    80003c36:	6c42                	ld	s8,16(sp)
    80003c38:	6ca2                	ld	s9,8(sp)
    80003c3a:	6125                	addi	sp,sp,96
    80003c3c:	8082                	ret
      iunlock(ip);
    80003c3e:	854e                	mv	a0,s3
    80003c40:	00000097          	auipc	ra,0x0
    80003c44:	aa6080e7          	jalr	-1370(ra) # 800036e6 <iunlock>
      return ip;
    80003c48:	bfe9                	j	80003c22 <namex+0x6a>
      iunlockput(ip);
    80003c4a:	854e                	mv	a0,s3
    80003c4c:	00000097          	auipc	ra,0x0
    80003c50:	c3a080e7          	jalr	-966(ra) # 80003886 <iunlockput>
      return 0;
    80003c54:	89e6                	mv	s3,s9
    80003c56:	b7f1                	j	80003c22 <namex+0x6a>
  len = path - s;
    80003c58:	40b48633          	sub	a2,s1,a1
    80003c5c:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    80003c60:	099c5463          	bge	s8,s9,80003ce8 <namex+0x130>
    memmove(name, s, DIRSIZ);
    80003c64:	4639                	li	a2,14
    80003c66:	8552                	mv	a0,s4
    80003c68:	ffffd097          	auipc	ra,0xffffd
    80003c6c:	0c0080e7          	jalr	192(ra) # 80000d28 <memmove>
  while(*path == '/')
    80003c70:	0004c783          	lbu	a5,0(s1)
    80003c74:	01279763          	bne	a5,s2,80003c82 <namex+0xca>
    path++;
    80003c78:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003c7a:	0004c783          	lbu	a5,0(s1)
    80003c7e:	ff278de3          	beq	a5,s2,80003c78 <namex+0xc0>
    ilock(ip);
    80003c82:	854e                	mv	a0,s3
    80003c84:	00000097          	auipc	ra,0x0
    80003c88:	9a0080e7          	jalr	-1632(ra) # 80003624 <ilock>
    if(ip->type != T_DIR){
    80003c8c:	04499783          	lh	a5,68(s3)
    80003c90:	f97793e3          	bne	a5,s7,80003c16 <namex+0x5e>
    if(nameiparent && *path == '\0'){
    80003c94:	000a8563          	beqz	s5,80003c9e <namex+0xe6>
    80003c98:	0004c783          	lbu	a5,0(s1)
    80003c9c:	d3cd                	beqz	a5,80003c3e <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    80003c9e:	865a                	mv	a2,s6
    80003ca0:	85d2                	mv	a1,s4
    80003ca2:	854e                	mv	a0,s3
    80003ca4:	00000097          	auipc	ra,0x0
    80003ca8:	e64080e7          	jalr	-412(ra) # 80003b08 <dirlookup>
    80003cac:	8caa                	mv	s9,a0
    80003cae:	dd51                	beqz	a0,80003c4a <namex+0x92>
    iunlockput(ip);
    80003cb0:	854e                	mv	a0,s3
    80003cb2:	00000097          	auipc	ra,0x0
    80003cb6:	bd4080e7          	jalr	-1068(ra) # 80003886 <iunlockput>
    ip = next;
    80003cba:	89e6                	mv	s3,s9
  while(*path == '/')
    80003cbc:	0004c783          	lbu	a5,0(s1)
    80003cc0:	05279763          	bne	a5,s2,80003d0e <namex+0x156>
    path++;
    80003cc4:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003cc6:	0004c783          	lbu	a5,0(s1)
    80003cca:	ff278de3          	beq	a5,s2,80003cc4 <namex+0x10c>
  if(*path == 0)
    80003cce:	c79d                	beqz	a5,80003cfc <namex+0x144>
    path++;
    80003cd0:	85a6                	mv	a1,s1
  len = path - s;
    80003cd2:	8cda                	mv	s9,s6
    80003cd4:	865a                	mv	a2,s6
  while(*path != '/' && *path != 0)
    80003cd6:	01278963          	beq	a5,s2,80003ce8 <namex+0x130>
    80003cda:	dfbd                	beqz	a5,80003c58 <namex+0xa0>
    path++;
    80003cdc:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    80003cde:	0004c783          	lbu	a5,0(s1)
    80003ce2:	ff279ce3          	bne	a5,s2,80003cda <namex+0x122>
    80003ce6:	bf8d                	j	80003c58 <namex+0xa0>
    memmove(name, s, len);
    80003ce8:	2601                	sext.w	a2,a2
    80003cea:	8552                	mv	a0,s4
    80003cec:	ffffd097          	auipc	ra,0xffffd
    80003cf0:	03c080e7          	jalr	60(ra) # 80000d28 <memmove>
    name[len] = 0;
    80003cf4:	9cd2                	add	s9,s9,s4
    80003cf6:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    80003cfa:	bf9d                	j	80003c70 <namex+0xb8>
  if(nameiparent){
    80003cfc:	f20a83e3          	beqz	s5,80003c22 <namex+0x6a>
    iput(ip);
    80003d00:	854e                	mv	a0,s3
    80003d02:	00000097          	auipc	ra,0x0
    80003d06:	adc080e7          	jalr	-1316(ra) # 800037de <iput>
    return 0;
    80003d0a:	4981                	li	s3,0
    80003d0c:	bf19                	j	80003c22 <namex+0x6a>
  if(*path == 0)
    80003d0e:	d7fd                	beqz	a5,80003cfc <namex+0x144>
  while(*path != '/' && *path != 0)
    80003d10:	0004c783          	lbu	a5,0(s1)
    80003d14:	85a6                	mv	a1,s1
    80003d16:	b7d1                	j	80003cda <namex+0x122>

0000000080003d18 <dirlink>:
{
    80003d18:	7139                	addi	sp,sp,-64
    80003d1a:	fc06                	sd	ra,56(sp)
    80003d1c:	f822                	sd	s0,48(sp)
    80003d1e:	f426                	sd	s1,40(sp)
    80003d20:	f04a                	sd	s2,32(sp)
    80003d22:	ec4e                	sd	s3,24(sp)
    80003d24:	e852                	sd	s4,16(sp)
    80003d26:	0080                	addi	s0,sp,64
    80003d28:	892a                	mv	s2,a0
    80003d2a:	8a2e                	mv	s4,a1
    80003d2c:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003d2e:	4601                	li	a2,0
    80003d30:	00000097          	auipc	ra,0x0
    80003d34:	dd8080e7          	jalr	-552(ra) # 80003b08 <dirlookup>
    80003d38:	e93d                	bnez	a0,80003dae <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003d3a:	04c92483          	lw	s1,76(s2)
    80003d3e:	c49d                	beqz	s1,80003d6c <dirlink+0x54>
    80003d40:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003d42:	4741                	li	a4,16
    80003d44:	86a6                	mv	a3,s1
    80003d46:	fc040613          	addi	a2,s0,-64
    80003d4a:	4581                	li	a1,0
    80003d4c:	854a                	mv	a0,s2
    80003d4e:	00000097          	auipc	ra,0x0
    80003d52:	b8a080e7          	jalr	-1142(ra) # 800038d8 <readi>
    80003d56:	47c1                	li	a5,16
    80003d58:	06f51163          	bne	a0,a5,80003dba <dirlink+0xa2>
    if(de.inum == 0)
    80003d5c:	fc045783          	lhu	a5,-64(s0)
    80003d60:	c791                	beqz	a5,80003d6c <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003d62:	24c1                	addiw	s1,s1,16
    80003d64:	04c92783          	lw	a5,76(s2)
    80003d68:	fcf4ede3          	bltu	s1,a5,80003d42 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    80003d6c:	4639                	li	a2,14
    80003d6e:	85d2                	mv	a1,s4
    80003d70:	fc240513          	addi	a0,s0,-62
    80003d74:	ffffd097          	auipc	ra,0xffffd
    80003d78:	064080e7          	jalr	100(ra) # 80000dd8 <strncpy>
  de.inum = inum;
    80003d7c:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003d80:	4741                	li	a4,16
    80003d82:	86a6                	mv	a3,s1
    80003d84:	fc040613          	addi	a2,s0,-64
    80003d88:	4581                	li	a1,0
    80003d8a:	854a                	mv	a0,s2
    80003d8c:	00000097          	auipc	ra,0x0
    80003d90:	c44080e7          	jalr	-956(ra) # 800039d0 <writei>
    80003d94:	872a                	mv	a4,a0
    80003d96:	47c1                	li	a5,16
  return 0;
    80003d98:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003d9a:	02f71863          	bne	a4,a5,80003dca <dirlink+0xb2>
}
    80003d9e:	70e2                	ld	ra,56(sp)
    80003da0:	7442                	ld	s0,48(sp)
    80003da2:	74a2                	ld	s1,40(sp)
    80003da4:	7902                	ld	s2,32(sp)
    80003da6:	69e2                	ld	s3,24(sp)
    80003da8:	6a42                	ld	s4,16(sp)
    80003daa:	6121                	addi	sp,sp,64
    80003dac:	8082                	ret
    iput(ip);
    80003dae:	00000097          	auipc	ra,0x0
    80003db2:	a30080e7          	jalr	-1488(ra) # 800037de <iput>
    return -1;
    80003db6:	557d                	li	a0,-1
    80003db8:	b7dd                	j	80003d9e <dirlink+0x86>
      panic("dirlink read");
    80003dba:	00005517          	auipc	a0,0x5
    80003dbe:	85e50513          	addi	a0,a0,-1954 # 80008618 <syscalls+0x1d0>
    80003dc2:	ffffc097          	auipc	ra,0xffffc
    80003dc6:	776080e7          	jalr	1910(ra) # 80000538 <panic>
    panic("dirlink");
    80003dca:	00005517          	auipc	a0,0x5
    80003dce:	95e50513          	addi	a0,a0,-1698 # 80008728 <syscalls+0x2e0>
    80003dd2:	ffffc097          	auipc	ra,0xffffc
    80003dd6:	766080e7          	jalr	1894(ra) # 80000538 <panic>

0000000080003dda <namei>:

struct inode*
namei(char *path)
{
    80003dda:	1101                	addi	sp,sp,-32
    80003ddc:	ec06                	sd	ra,24(sp)
    80003dde:	e822                	sd	s0,16(sp)
    80003de0:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003de2:	fe040613          	addi	a2,s0,-32
    80003de6:	4581                	li	a1,0
    80003de8:	00000097          	auipc	ra,0x0
    80003dec:	dd0080e7          	jalr	-560(ra) # 80003bb8 <namex>
}
    80003df0:	60e2                	ld	ra,24(sp)
    80003df2:	6442                	ld	s0,16(sp)
    80003df4:	6105                	addi	sp,sp,32
    80003df6:	8082                	ret

0000000080003df8 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003df8:	1141                	addi	sp,sp,-16
    80003dfa:	e406                	sd	ra,8(sp)
    80003dfc:	e022                	sd	s0,0(sp)
    80003dfe:	0800                	addi	s0,sp,16
    80003e00:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003e02:	4585                	li	a1,1
    80003e04:	00000097          	auipc	ra,0x0
    80003e08:	db4080e7          	jalr	-588(ra) # 80003bb8 <namex>
}
    80003e0c:	60a2                	ld	ra,8(sp)
    80003e0e:	6402                	ld	s0,0(sp)
    80003e10:	0141                	addi	sp,sp,16
    80003e12:	8082                	ret

0000000080003e14 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80003e14:	1101                	addi	sp,sp,-32
    80003e16:	ec06                	sd	ra,24(sp)
    80003e18:	e822                	sd	s0,16(sp)
    80003e1a:	e426                	sd	s1,8(sp)
    80003e1c:	e04a                	sd	s2,0(sp)
    80003e1e:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003e20:	0001d917          	auipc	s2,0x1d
    80003e24:	45090913          	addi	s2,s2,1104 # 80021270 <log>
    80003e28:	01892583          	lw	a1,24(s2)
    80003e2c:	02892503          	lw	a0,40(s2)
    80003e30:	fffff097          	auipc	ra,0xfffff
    80003e34:	ff2080e7          	jalr	-14(ra) # 80002e22 <bread>
    80003e38:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80003e3a:	02c92683          	lw	a3,44(s2)
    80003e3e:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003e40:	02d05763          	blez	a3,80003e6e <write_head+0x5a>
    80003e44:	0001d797          	auipc	a5,0x1d
    80003e48:	45c78793          	addi	a5,a5,1116 # 800212a0 <log+0x30>
    80003e4c:	05c50713          	addi	a4,a0,92
    80003e50:	36fd                	addiw	a3,a3,-1
    80003e52:	1682                	slli	a3,a3,0x20
    80003e54:	9281                	srli	a3,a3,0x20
    80003e56:	068a                	slli	a3,a3,0x2
    80003e58:	0001d617          	auipc	a2,0x1d
    80003e5c:	44c60613          	addi	a2,a2,1100 # 800212a4 <log+0x34>
    80003e60:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    80003e62:	4390                	lw	a2,0(a5)
    80003e64:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003e66:	0791                	addi	a5,a5,4
    80003e68:	0711                	addi	a4,a4,4
    80003e6a:	fed79ce3          	bne	a5,a3,80003e62 <write_head+0x4e>
  }
  bwrite(buf);
    80003e6e:	8526                	mv	a0,s1
    80003e70:	fffff097          	auipc	ra,0xfffff
    80003e74:	0a4080e7          	jalr	164(ra) # 80002f14 <bwrite>
  brelse(buf);
    80003e78:	8526                	mv	a0,s1
    80003e7a:	fffff097          	auipc	ra,0xfffff
    80003e7e:	0d8080e7          	jalr	216(ra) # 80002f52 <brelse>
}
    80003e82:	60e2                	ld	ra,24(sp)
    80003e84:	6442                	ld	s0,16(sp)
    80003e86:	64a2                	ld	s1,8(sp)
    80003e88:	6902                	ld	s2,0(sp)
    80003e8a:	6105                	addi	sp,sp,32
    80003e8c:	8082                	ret

0000000080003e8e <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80003e8e:	0001d797          	auipc	a5,0x1d
    80003e92:	40e7a783          	lw	a5,1038(a5) # 8002129c <log+0x2c>
    80003e96:	0af05d63          	blez	a5,80003f50 <install_trans+0xc2>
{
    80003e9a:	7139                	addi	sp,sp,-64
    80003e9c:	fc06                	sd	ra,56(sp)
    80003e9e:	f822                	sd	s0,48(sp)
    80003ea0:	f426                	sd	s1,40(sp)
    80003ea2:	f04a                	sd	s2,32(sp)
    80003ea4:	ec4e                	sd	s3,24(sp)
    80003ea6:	e852                	sd	s4,16(sp)
    80003ea8:	e456                	sd	s5,8(sp)
    80003eaa:	e05a                	sd	s6,0(sp)
    80003eac:	0080                	addi	s0,sp,64
    80003eae:	8b2a                	mv	s6,a0
    80003eb0:	0001da97          	auipc	s5,0x1d
    80003eb4:	3f0a8a93          	addi	s5,s5,1008 # 800212a0 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003eb8:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003eba:	0001d997          	auipc	s3,0x1d
    80003ebe:	3b698993          	addi	s3,s3,950 # 80021270 <log>
    80003ec2:	a00d                	j	80003ee4 <install_trans+0x56>
    brelse(lbuf);
    80003ec4:	854a                	mv	a0,s2
    80003ec6:	fffff097          	auipc	ra,0xfffff
    80003eca:	08c080e7          	jalr	140(ra) # 80002f52 <brelse>
    brelse(dbuf);
    80003ece:	8526                	mv	a0,s1
    80003ed0:	fffff097          	auipc	ra,0xfffff
    80003ed4:	082080e7          	jalr	130(ra) # 80002f52 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003ed8:	2a05                	addiw	s4,s4,1
    80003eda:	0a91                	addi	s5,s5,4
    80003edc:	02c9a783          	lw	a5,44(s3)
    80003ee0:	04fa5e63          	bge	s4,a5,80003f3c <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003ee4:	0189a583          	lw	a1,24(s3)
    80003ee8:	014585bb          	addw	a1,a1,s4
    80003eec:	2585                	addiw	a1,a1,1
    80003eee:	0289a503          	lw	a0,40(s3)
    80003ef2:	fffff097          	auipc	ra,0xfffff
    80003ef6:	f30080e7          	jalr	-208(ra) # 80002e22 <bread>
    80003efa:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80003efc:	000aa583          	lw	a1,0(s5)
    80003f00:	0289a503          	lw	a0,40(s3)
    80003f04:	fffff097          	auipc	ra,0xfffff
    80003f08:	f1e080e7          	jalr	-226(ra) # 80002e22 <bread>
    80003f0c:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003f0e:	40000613          	li	a2,1024
    80003f12:	05890593          	addi	a1,s2,88
    80003f16:	05850513          	addi	a0,a0,88
    80003f1a:	ffffd097          	auipc	ra,0xffffd
    80003f1e:	e0e080e7          	jalr	-498(ra) # 80000d28 <memmove>
    bwrite(dbuf);  // write dst to disk
    80003f22:	8526                	mv	a0,s1
    80003f24:	fffff097          	auipc	ra,0xfffff
    80003f28:	ff0080e7          	jalr	-16(ra) # 80002f14 <bwrite>
    if(recovering == 0)
    80003f2c:	f80b1ce3          	bnez	s6,80003ec4 <install_trans+0x36>
      bunpin(dbuf);
    80003f30:	8526                	mv	a0,s1
    80003f32:	fffff097          	auipc	ra,0xfffff
    80003f36:	0fa080e7          	jalr	250(ra) # 8000302c <bunpin>
    80003f3a:	b769                	j	80003ec4 <install_trans+0x36>
}
    80003f3c:	70e2                	ld	ra,56(sp)
    80003f3e:	7442                	ld	s0,48(sp)
    80003f40:	74a2                	ld	s1,40(sp)
    80003f42:	7902                	ld	s2,32(sp)
    80003f44:	69e2                	ld	s3,24(sp)
    80003f46:	6a42                	ld	s4,16(sp)
    80003f48:	6aa2                	ld	s5,8(sp)
    80003f4a:	6b02                	ld	s6,0(sp)
    80003f4c:	6121                	addi	sp,sp,64
    80003f4e:	8082                	ret
    80003f50:	8082                	ret

0000000080003f52 <initlog>:
{
    80003f52:	7179                	addi	sp,sp,-48
    80003f54:	f406                	sd	ra,40(sp)
    80003f56:	f022                	sd	s0,32(sp)
    80003f58:	ec26                	sd	s1,24(sp)
    80003f5a:	e84a                	sd	s2,16(sp)
    80003f5c:	e44e                	sd	s3,8(sp)
    80003f5e:	1800                	addi	s0,sp,48
    80003f60:	892a                	mv	s2,a0
    80003f62:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003f64:	0001d497          	auipc	s1,0x1d
    80003f68:	30c48493          	addi	s1,s1,780 # 80021270 <log>
    80003f6c:	00004597          	auipc	a1,0x4
    80003f70:	6bc58593          	addi	a1,a1,1724 # 80008628 <syscalls+0x1e0>
    80003f74:	8526                	mv	a0,s1
    80003f76:	ffffd097          	auipc	ra,0xffffd
    80003f7a:	bca080e7          	jalr	-1078(ra) # 80000b40 <initlock>
  log.start = sb->logstart;
    80003f7e:	0149a583          	lw	a1,20(s3)
    80003f82:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80003f84:	0109a783          	lw	a5,16(s3)
    80003f88:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80003f8a:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80003f8e:	854a                	mv	a0,s2
    80003f90:	fffff097          	auipc	ra,0xfffff
    80003f94:	e92080e7          	jalr	-366(ra) # 80002e22 <bread>
  log.lh.n = lh->n;
    80003f98:	4d34                	lw	a3,88(a0)
    80003f9a:	d4d4                	sw	a3,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80003f9c:	02d05563          	blez	a3,80003fc6 <initlog+0x74>
    80003fa0:	05c50793          	addi	a5,a0,92
    80003fa4:	0001d717          	auipc	a4,0x1d
    80003fa8:	2fc70713          	addi	a4,a4,764 # 800212a0 <log+0x30>
    80003fac:	36fd                	addiw	a3,a3,-1
    80003fae:	1682                	slli	a3,a3,0x20
    80003fb0:	9281                	srli	a3,a3,0x20
    80003fb2:	068a                	slli	a3,a3,0x2
    80003fb4:	06050613          	addi	a2,a0,96
    80003fb8:	96b2                	add	a3,a3,a2
    log.lh.block[i] = lh->block[i];
    80003fba:	4390                	lw	a2,0(a5)
    80003fbc:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003fbe:	0791                	addi	a5,a5,4
    80003fc0:	0711                	addi	a4,a4,4
    80003fc2:	fed79ce3          	bne	a5,a3,80003fba <initlog+0x68>
  brelse(buf);
    80003fc6:	fffff097          	auipc	ra,0xfffff
    80003fca:	f8c080e7          	jalr	-116(ra) # 80002f52 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80003fce:	4505                	li	a0,1
    80003fd0:	00000097          	auipc	ra,0x0
    80003fd4:	ebe080e7          	jalr	-322(ra) # 80003e8e <install_trans>
  log.lh.n = 0;
    80003fd8:	0001d797          	auipc	a5,0x1d
    80003fdc:	2c07a223          	sw	zero,708(a5) # 8002129c <log+0x2c>
  write_head(); // clear the log
    80003fe0:	00000097          	auipc	ra,0x0
    80003fe4:	e34080e7          	jalr	-460(ra) # 80003e14 <write_head>
}
    80003fe8:	70a2                	ld	ra,40(sp)
    80003fea:	7402                	ld	s0,32(sp)
    80003fec:	64e2                	ld	s1,24(sp)
    80003fee:	6942                	ld	s2,16(sp)
    80003ff0:	69a2                	ld	s3,8(sp)
    80003ff2:	6145                	addi	sp,sp,48
    80003ff4:	8082                	ret

0000000080003ff6 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003ff6:	1101                	addi	sp,sp,-32
    80003ff8:	ec06                	sd	ra,24(sp)
    80003ffa:	e822                	sd	s0,16(sp)
    80003ffc:	e426                	sd	s1,8(sp)
    80003ffe:	e04a                	sd	s2,0(sp)
    80004000:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80004002:	0001d517          	auipc	a0,0x1d
    80004006:	26e50513          	addi	a0,a0,622 # 80021270 <log>
    8000400a:	ffffd097          	auipc	ra,0xffffd
    8000400e:	bc6080e7          	jalr	-1082(ra) # 80000bd0 <acquire>
  while(1){
    if(log.committing){
    80004012:	0001d497          	auipc	s1,0x1d
    80004016:	25e48493          	addi	s1,s1,606 # 80021270 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000401a:	4979                	li	s2,30
    8000401c:	a039                	j	8000402a <begin_op+0x34>
      sleep(&log, &log.lock);
    8000401e:	85a6                	mv	a1,s1
    80004020:	8526                	mv	a0,s1
    80004022:	ffffe097          	auipc	ra,0xffffe
    80004026:	034080e7          	jalr	52(ra) # 80002056 <sleep>
    if(log.committing){
    8000402a:	50dc                	lw	a5,36(s1)
    8000402c:	fbed                	bnez	a5,8000401e <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000402e:	509c                	lw	a5,32(s1)
    80004030:	0017871b          	addiw	a4,a5,1
    80004034:	0007069b          	sext.w	a3,a4
    80004038:	0027179b          	slliw	a5,a4,0x2
    8000403c:	9fb9                	addw	a5,a5,a4
    8000403e:	0017979b          	slliw	a5,a5,0x1
    80004042:	54d8                	lw	a4,44(s1)
    80004044:	9fb9                	addw	a5,a5,a4
    80004046:	00f95963          	bge	s2,a5,80004058 <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    8000404a:	85a6                	mv	a1,s1
    8000404c:	8526                	mv	a0,s1
    8000404e:	ffffe097          	auipc	ra,0xffffe
    80004052:	008080e7          	jalr	8(ra) # 80002056 <sleep>
    80004056:	bfd1                	j	8000402a <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80004058:	0001d517          	auipc	a0,0x1d
    8000405c:	21850513          	addi	a0,a0,536 # 80021270 <log>
    80004060:	d114                	sw	a3,32(a0)
      release(&log.lock);
    80004062:	ffffd097          	auipc	ra,0xffffd
    80004066:	c22080e7          	jalr	-990(ra) # 80000c84 <release>
      break;
    }
  }
}
    8000406a:	60e2                	ld	ra,24(sp)
    8000406c:	6442                	ld	s0,16(sp)
    8000406e:	64a2                	ld	s1,8(sp)
    80004070:	6902                	ld	s2,0(sp)
    80004072:	6105                	addi	sp,sp,32
    80004074:	8082                	ret

0000000080004076 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80004076:	7139                	addi	sp,sp,-64
    80004078:	fc06                	sd	ra,56(sp)
    8000407a:	f822                	sd	s0,48(sp)
    8000407c:	f426                	sd	s1,40(sp)
    8000407e:	f04a                	sd	s2,32(sp)
    80004080:	ec4e                	sd	s3,24(sp)
    80004082:	e852                	sd	s4,16(sp)
    80004084:	e456                	sd	s5,8(sp)
    80004086:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80004088:	0001d497          	auipc	s1,0x1d
    8000408c:	1e848493          	addi	s1,s1,488 # 80021270 <log>
    80004090:	8526                	mv	a0,s1
    80004092:	ffffd097          	auipc	ra,0xffffd
    80004096:	b3e080e7          	jalr	-1218(ra) # 80000bd0 <acquire>
  log.outstanding -= 1;
    8000409a:	509c                	lw	a5,32(s1)
    8000409c:	37fd                	addiw	a5,a5,-1
    8000409e:	0007891b          	sext.w	s2,a5
    800040a2:	d09c                	sw	a5,32(s1)
  if(log.committing)
    800040a4:	50dc                	lw	a5,36(s1)
    800040a6:	e7b9                	bnez	a5,800040f4 <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    800040a8:	04091e63          	bnez	s2,80004104 <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    800040ac:	0001d497          	auipc	s1,0x1d
    800040b0:	1c448493          	addi	s1,s1,452 # 80021270 <log>
    800040b4:	4785                	li	a5,1
    800040b6:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800040b8:	8526                	mv	a0,s1
    800040ba:	ffffd097          	auipc	ra,0xffffd
    800040be:	bca080e7          	jalr	-1078(ra) # 80000c84 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800040c2:	54dc                	lw	a5,44(s1)
    800040c4:	06f04763          	bgtz	a5,80004132 <end_op+0xbc>
    acquire(&log.lock);
    800040c8:	0001d497          	auipc	s1,0x1d
    800040cc:	1a848493          	addi	s1,s1,424 # 80021270 <log>
    800040d0:	8526                	mv	a0,s1
    800040d2:	ffffd097          	auipc	ra,0xffffd
    800040d6:	afe080e7          	jalr	-1282(ra) # 80000bd0 <acquire>
    log.committing = 0;
    800040da:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    800040de:	8526                	mv	a0,s1
    800040e0:	ffffe097          	auipc	ra,0xffffe
    800040e4:	102080e7          	jalr	258(ra) # 800021e2 <wakeup>
    release(&log.lock);
    800040e8:	8526                	mv	a0,s1
    800040ea:	ffffd097          	auipc	ra,0xffffd
    800040ee:	b9a080e7          	jalr	-1126(ra) # 80000c84 <release>
}
    800040f2:	a03d                	j	80004120 <end_op+0xaa>
    panic("log.committing");
    800040f4:	00004517          	auipc	a0,0x4
    800040f8:	53c50513          	addi	a0,a0,1340 # 80008630 <syscalls+0x1e8>
    800040fc:	ffffc097          	auipc	ra,0xffffc
    80004100:	43c080e7          	jalr	1084(ra) # 80000538 <panic>
    wakeup(&log);
    80004104:	0001d497          	auipc	s1,0x1d
    80004108:	16c48493          	addi	s1,s1,364 # 80021270 <log>
    8000410c:	8526                	mv	a0,s1
    8000410e:	ffffe097          	auipc	ra,0xffffe
    80004112:	0d4080e7          	jalr	212(ra) # 800021e2 <wakeup>
  release(&log.lock);
    80004116:	8526                	mv	a0,s1
    80004118:	ffffd097          	auipc	ra,0xffffd
    8000411c:	b6c080e7          	jalr	-1172(ra) # 80000c84 <release>
}
    80004120:	70e2                	ld	ra,56(sp)
    80004122:	7442                	ld	s0,48(sp)
    80004124:	74a2                	ld	s1,40(sp)
    80004126:	7902                	ld	s2,32(sp)
    80004128:	69e2                	ld	s3,24(sp)
    8000412a:	6a42                	ld	s4,16(sp)
    8000412c:	6aa2                	ld	s5,8(sp)
    8000412e:	6121                	addi	sp,sp,64
    80004130:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    80004132:	0001da97          	auipc	s5,0x1d
    80004136:	16ea8a93          	addi	s5,s5,366 # 800212a0 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    8000413a:	0001da17          	auipc	s4,0x1d
    8000413e:	136a0a13          	addi	s4,s4,310 # 80021270 <log>
    80004142:	018a2583          	lw	a1,24(s4)
    80004146:	012585bb          	addw	a1,a1,s2
    8000414a:	2585                	addiw	a1,a1,1
    8000414c:	028a2503          	lw	a0,40(s4)
    80004150:	fffff097          	auipc	ra,0xfffff
    80004154:	cd2080e7          	jalr	-814(ra) # 80002e22 <bread>
    80004158:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    8000415a:	000aa583          	lw	a1,0(s5)
    8000415e:	028a2503          	lw	a0,40(s4)
    80004162:	fffff097          	auipc	ra,0xfffff
    80004166:	cc0080e7          	jalr	-832(ra) # 80002e22 <bread>
    8000416a:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    8000416c:	40000613          	li	a2,1024
    80004170:	05850593          	addi	a1,a0,88
    80004174:	05848513          	addi	a0,s1,88
    80004178:	ffffd097          	auipc	ra,0xffffd
    8000417c:	bb0080e7          	jalr	-1104(ra) # 80000d28 <memmove>
    bwrite(to);  // write the log
    80004180:	8526                	mv	a0,s1
    80004182:	fffff097          	auipc	ra,0xfffff
    80004186:	d92080e7          	jalr	-622(ra) # 80002f14 <bwrite>
    brelse(from);
    8000418a:	854e                	mv	a0,s3
    8000418c:	fffff097          	auipc	ra,0xfffff
    80004190:	dc6080e7          	jalr	-570(ra) # 80002f52 <brelse>
    brelse(to);
    80004194:	8526                	mv	a0,s1
    80004196:	fffff097          	auipc	ra,0xfffff
    8000419a:	dbc080e7          	jalr	-580(ra) # 80002f52 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000419e:	2905                	addiw	s2,s2,1
    800041a0:	0a91                	addi	s5,s5,4
    800041a2:	02ca2783          	lw	a5,44(s4)
    800041a6:	f8f94ee3          	blt	s2,a5,80004142 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    800041aa:	00000097          	auipc	ra,0x0
    800041ae:	c6a080e7          	jalr	-918(ra) # 80003e14 <write_head>
    install_trans(0); // Now install writes to home locations
    800041b2:	4501                	li	a0,0
    800041b4:	00000097          	auipc	ra,0x0
    800041b8:	cda080e7          	jalr	-806(ra) # 80003e8e <install_trans>
    log.lh.n = 0;
    800041bc:	0001d797          	auipc	a5,0x1d
    800041c0:	0e07a023          	sw	zero,224(a5) # 8002129c <log+0x2c>
    write_head();    // Erase the transaction from the log
    800041c4:	00000097          	auipc	ra,0x0
    800041c8:	c50080e7          	jalr	-944(ra) # 80003e14 <write_head>
    800041cc:	bdf5                	j	800040c8 <end_op+0x52>

00000000800041ce <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800041ce:	1101                	addi	sp,sp,-32
    800041d0:	ec06                	sd	ra,24(sp)
    800041d2:	e822                	sd	s0,16(sp)
    800041d4:	e426                	sd	s1,8(sp)
    800041d6:	e04a                	sd	s2,0(sp)
    800041d8:	1000                	addi	s0,sp,32
    800041da:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    800041dc:	0001d917          	auipc	s2,0x1d
    800041e0:	09490913          	addi	s2,s2,148 # 80021270 <log>
    800041e4:	854a                	mv	a0,s2
    800041e6:	ffffd097          	auipc	ra,0xffffd
    800041ea:	9ea080e7          	jalr	-1558(ra) # 80000bd0 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    800041ee:	02c92603          	lw	a2,44(s2)
    800041f2:	47f5                	li	a5,29
    800041f4:	06c7c563          	blt	a5,a2,8000425e <log_write+0x90>
    800041f8:	0001d797          	auipc	a5,0x1d
    800041fc:	0947a783          	lw	a5,148(a5) # 8002128c <log+0x1c>
    80004200:	37fd                	addiw	a5,a5,-1
    80004202:	04f65e63          	bge	a2,a5,8000425e <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80004206:	0001d797          	auipc	a5,0x1d
    8000420a:	08a7a783          	lw	a5,138(a5) # 80021290 <log+0x20>
    8000420e:	06f05063          	blez	a5,8000426e <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80004212:	4781                	li	a5,0
    80004214:	06c05563          	blez	a2,8000427e <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80004218:	44cc                	lw	a1,12(s1)
    8000421a:	0001d717          	auipc	a4,0x1d
    8000421e:	08670713          	addi	a4,a4,134 # 800212a0 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80004222:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    80004224:	4314                	lw	a3,0(a4)
    80004226:	04b68c63          	beq	a3,a1,8000427e <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    8000422a:	2785                	addiw	a5,a5,1
    8000422c:	0711                	addi	a4,a4,4
    8000422e:	fef61be3          	bne	a2,a5,80004224 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    80004232:	0621                	addi	a2,a2,8
    80004234:	060a                	slli	a2,a2,0x2
    80004236:	0001d797          	auipc	a5,0x1d
    8000423a:	03a78793          	addi	a5,a5,58 # 80021270 <log>
    8000423e:	963e                	add	a2,a2,a5
    80004240:	44dc                	lw	a5,12(s1)
    80004242:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80004244:	8526                	mv	a0,s1
    80004246:	fffff097          	auipc	ra,0xfffff
    8000424a:	daa080e7          	jalr	-598(ra) # 80002ff0 <bpin>
    log.lh.n++;
    8000424e:	0001d717          	auipc	a4,0x1d
    80004252:	02270713          	addi	a4,a4,34 # 80021270 <log>
    80004256:	575c                	lw	a5,44(a4)
    80004258:	2785                	addiw	a5,a5,1
    8000425a:	d75c                	sw	a5,44(a4)
    8000425c:	a835                	j	80004298 <log_write+0xca>
    panic("too big a transaction");
    8000425e:	00004517          	auipc	a0,0x4
    80004262:	3e250513          	addi	a0,a0,994 # 80008640 <syscalls+0x1f8>
    80004266:	ffffc097          	auipc	ra,0xffffc
    8000426a:	2d2080e7          	jalr	722(ra) # 80000538 <panic>
    panic("log_write outside of trans");
    8000426e:	00004517          	auipc	a0,0x4
    80004272:	3ea50513          	addi	a0,a0,1002 # 80008658 <syscalls+0x210>
    80004276:	ffffc097          	auipc	ra,0xffffc
    8000427a:	2c2080e7          	jalr	706(ra) # 80000538 <panic>
  log.lh.block[i] = b->blockno;
    8000427e:	00878713          	addi	a4,a5,8
    80004282:	00271693          	slli	a3,a4,0x2
    80004286:	0001d717          	auipc	a4,0x1d
    8000428a:	fea70713          	addi	a4,a4,-22 # 80021270 <log>
    8000428e:	9736                	add	a4,a4,a3
    80004290:	44d4                	lw	a3,12(s1)
    80004292:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80004294:	faf608e3          	beq	a2,a5,80004244 <log_write+0x76>
  }
  release(&log.lock);
    80004298:	0001d517          	auipc	a0,0x1d
    8000429c:	fd850513          	addi	a0,a0,-40 # 80021270 <log>
    800042a0:	ffffd097          	auipc	ra,0xffffd
    800042a4:	9e4080e7          	jalr	-1564(ra) # 80000c84 <release>
}
    800042a8:	60e2                	ld	ra,24(sp)
    800042aa:	6442                	ld	s0,16(sp)
    800042ac:	64a2                	ld	s1,8(sp)
    800042ae:	6902                	ld	s2,0(sp)
    800042b0:	6105                	addi	sp,sp,32
    800042b2:	8082                	ret

00000000800042b4 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800042b4:	1101                	addi	sp,sp,-32
    800042b6:	ec06                	sd	ra,24(sp)
    800042b8:	e822                	sd	s0,16(sp)
    800042ba:	e426                	sd	s1,8(sp)
    800042bc:	e04a                	sd	s2,0(sp)
    800042be:	1000                	addi	s0,sp,32
    800042c0:	84aa                	mv	s1,a0
    800042c2:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800042c4:	00004597          	auipc	a1,0x4
    800042c8:	3b458593          	addi	a1,a1,948 # 80008678 <syscalls+0x230>
    800042cc:	0521                	addi	a0,a0,8
    800042ce:	ffffd097          	auipc	ra,0xffffd
    800042d2:	872080e7          	jalr	-1934(ra) # 80000b40 <initlock>
  lk->name = name;
    800042d6:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    800042da:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800042de:	0204a423          	sw	zero,40(s1)
}
    800042e2:	60e2                	ld	ra,24(sp)
    800042e4:	6442                	ld	s0,16(sp)
    800042e6:	64a2                	ld	s1,8(sp)
    800042e8:	6902                	ld	s2,0(sp)
    800042ea:	6105                	addi	sp,sp,32
    800042ec:	8082                	ret

00000000800042ee <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800042ee:	1101                	addi	sp,sp,-32
    800042f0:	ec06                	sd	ra,24(sp)
    800042f2:	e822                	sd	s0,16(sp)
    800042f4:	e426                	sd	s1,8(sp)
    800042f6:	e04a                	sd	s2,0(sp)
    800042f8:	1000                	addi	s0,sp,32
    800042fa:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800042fc:	00850913          	addi	s2,a0,8
    80004300:	854a                	mv	a0,s2
    80004302:	ffffd097          	auipc	ra,0xffffd
    80004306:	8ce080e7          	jalr	-1842(ra) # 80000bd0 <acquire>
  while (lk->locked) {
    8000430a:	409c                	lw	a5,0(s1)
    8000430c:	cb89                	beqz	a5,8000431e <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    8000430e:	85ca                	mv	a1,s2
    80004310:	8526                	mv	a0,s1
    80004312:	ffffe097          	auipc	ra,0xffffe
    80004316:	d44080e7          	jalr	-700(ra) # 80002056 <sleep>
  while (lk->locked) {
    8000431a:	409c                	lw	a5,0(s1)
    8000431c:	fbed                	bnez	a5,8000430e <acquiresleep+0x20>
  }
  lk->locked = 1;
    8000431e:	4785                	li	a5,1
    80004320:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80004322:	ffffd097          	auipc	ra,0xffffd
    80004326:	674080e7          	jalr	1652(ra) # 80001996 <myproc>
    8000432a:	591c                	lw	a5,48(a0)
    8000432c:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    8000432e:	854a                	mv	a0,s2
    80004330:	ffffd097          	auipc	ra,0xffffd
    80004334:	954080e7          	jalr	-1708(ra) # 80000c84 <release>
}
    80004338:	60e2                	ld	ra,24(sp)
    8000433a:	6442                	ld	s0,16(sp)
    8000433c:	64a2                	ld	s1,8(sp)
    8000433e:	6902                	ld	s2,0(sp)
    80004340:	6105                	addi	sp,sp,32
    80004342:	8082                	ret

0000000080004344 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80004344:	1101                	addi	sp,sp,-32
    80004346:	ec06                	sd	ra,24(sp)
    80004348:	e822                	sd	s0,16(sp)
    8000434a:	e426                	sd	s1,8(sp)
    8000434c:	e04a                	sd	s2,0(sp)
    8000434e:	1000                	addi	s0,sp,32
    80004350:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80004352:	00850913          	addi	s2,a0,8
    80004356:	854a                	mv	a0,s2
    80004358:	ffffd097          	auipc	ra,0xffffd
    8000435c:	878080e7          	jalr	-1928(ra) # 80000bd0 <acquire>
  lk->locked = 0;
    80004360:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80004364:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80004368:	8526                	mv	a0,s1
    8000436a:	ffffe097          	auipc	ra,0xffffe
    8000436e:	e78080e7          	jalr	-392(ra) # 800021e2 <wakeup>
  release(&lk->lk);
    80004372:	854a                	mv	a0,s2
    80004374:	ffffd097          	auipc	ra,0xffffd
    80004378:	910080e7          	jalr	-1776(ra) # 80000c84 <release>
}
    8000437c:	60e2                	ld	ra,24(sp)
    8000437e:	6442                	ld	s0,16(sp)
    80004380:	64a2                	ld	s1,8(sp)
    80004382:	6902                	ld	s2,0(sp)
    80004384:	6105                	addi	sp,sp,32
    80004386:	8082                	ret

0000000080004388 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80004388:	7179                	addi	sp,sp,-48
    8000438a:	f406                	sd	ra,40(sp)
    8000438c:	f022                	sd	s0,32(sp)
    8000438e:	ec26                	sd	s1,24(sp)
    80004390:	e84a                	sd	s2,16(sp)
    80004392:	e44e                	sd	s3,8(sp)
    80004394:	1800                	addi	s0,sp,48
    80004396:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80004398:	00850913          	addi	s2,a0,8
    8000439c:	854a                	mv	a0,s2
    8000439e:	ffffd097          	auipc	ra,0xffffd
    800043a2:	832080e7          	jalr	-1998(ra) # 80000bd0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800043a6:	409c                	lw	a5,0(s1)
    800043a8:	ef99                	bnez	a5,800043c6 <holdingsleep+0x3e>
    800043aa:	4481                	li	s1,0
  release(&lk->lk);
    800043ac:	854a                	mv	a0,s2
    800043ae:	ffffd097          	auipc	ra,0xffffd
    800043b2:	8d6080e7          	jalr	-1834(ra) # 80000c84 <release>
  return r;
}
    800043b6:	8526                	mv	a0,s1
    800043b8:	70a2                	ld	ra,40(sp)
    800043ba:	7402                	ld	s0,32(sp)
    800043bc:	64e2                	ld	s1,24(sp)
    800043be:	6942                	ld	s2,16(sp)
    800043c0:	69a2                	ld	s3,8(sp)
    800043c2:	6145                	addi	sp,sp,48
    800043c4:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    800043c6:	0284a983          	lw	s3,40(s1)
    800043ca:	ffffd097          	auipc	ra,0xffffd
    800043ce:	5cc080e7          	jalr	1484(ra) # 80001996 <myproc>
    800043d2:	5904                	lw	s1,48(a0)
    800043d4:	413484b3          	sub	s1,s1,s3
    800043d8:	0014b493          	seqz	s1,s1
    800043dc:	bfc1                	j	800043ac <holdingsleep+0x24>

00000000800043de <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    800043de:	1141                	addi	sp,sp,-16
    800043e0:	e406                	sd	ra,8(sp)
    800043e2:	e022                	sd	s0,0(sp)
    800043e4:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    800043e6:	00004597          	auipc	a1,0x4
    800043ea:	2a258593          	addi	a1,a1,674 # 80008688 <syscalls+0x240>
    800043ee:	0001d517          	auipc	a0,0x1d
    800043f2:	fca50513          	addi	a0,a0,-54 # 800213b8 <ftable>
    800043f6:	ffffc097          	auipc	ra,0xffffc
    800043fa:	74a080e7          	jalr	1866(ra) # 80000b40 <initlock>
}
    800043fe:	60a2                	ld	ra,8(sp)
    80004400:	6402                	ld	s0,0(sp)
    80004402:	0141                	addi	sp,sp,16
    80004404:	8082                	ret

0000000080004406 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80004406:	1101                	addi	sp,sp,-32
    80004408:	ec06                	sd	ra,24(sp)
    8000440a:	e822                	sd	s0,16(sp)
    8000440c:	e426                	sd	s1,8(sp)
    8000440e:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80004410:	0001d517          	auipc	a0,0x1d
    80004414:	fa850513          	addi	a0,a0,-88 # 800213b8 <ftable>
    80004418:	ffffc097          	auipc	ra,0xffffc
    8000441c:	7b8080e7          	jalr	1976(ra) # 80000bd0 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80004420:	0001d497          	auipc	s1,0x1d
    80004424:	fb048493          	addi	s1,s1,-80 # 800213d0 <ftable+0x18>
    80004428:	0001e717          	auipc	a4,0x1e
    8000442c:	f4870713          	addi	a4,a4,-184 # 80022370 <ftable+0xfb8>
    if(f->ref == 0){
    80004430:	40dc                	lw	a5,4(s1)
    80004432:	cf99                	beqz	a5,80004450 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80004434:	02848493          	addi	s1,s1,40
    80004438:	fee49ce3          	bne	s1,a4,80004430 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    8000443c:	0001d517          	auipc	a0,0x1d
    80004440:	f7c50513          	addi	a0,a0,-132 # 800213b8 <ftable>
    80004444:	ffffd097          	auipc	ra,0xffffd
    80004448:	840080e7          	jalr	-1984(ra) # 80000c84 <release>
  return 0;
    8000444c:	4481                	li	s1,0
    8000444e:	a819                	j	80004464 <filealloc+0x5e>
      f->ref = 1;
    80004450:	4785                	li	a5,1
    80004452:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80004454:	0001d517          	auipc	a0,0x1d
    80004458:	f6450513          	addi	a0,a0,-156 # 800213b8 <ftable>
    8000445c:	ffffd097          	auipc	ra,0xffffd
    80004460:	828080e7          	jalr	-2008(ra) # 80000c84 <release>
}
    80004464:	8526                	mv	a0,s1
    80004466:	60e2                	ld	ra,24(sp)
    80004468:	6442                	ld	s0,16(sp)
    8000446a:	64a2                	ld	s1,8(sp)
    8000446c:	6105                	addi	sp,sp,32
    8000446e:	8082                	ret

0000000080004470 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80004470:	1101                	addi	sp,sp,-32
    80004472:	ec06                	sd	ra,24(sp)
    80004474:	e822                	sd	s0,16(sp)
    80004476:	e426                	sd	s1,8(sp)
    80004478:	1000                	addi	s0,sp,32
    8000447a:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    8000447c:	0001d517          	auipc	a0,0x1d
    80004480:	f3c50513          	addi	a0,a0,-196 # 800213b8 <ftable>
    80004484:	ffffc097          	auipc	ra,0xffffc
    80004488:	74c080e7          	jalr	1868(ra) # 80000bd0 <acquire>
  if(f->ref < 1)
    8000448c:	40dc                	lw	a5,4(s1)
    8000448e:	02f05263          	blez	a5,800044b2 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80004492:	2785                	addiw	a5,a5,1
    80004494:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80004496:	0001d517          	auipc	a0,0x1d
    8000449a:	f2250513          	addi	a0,a0,-222 # 800213b8 <ftable>
    8000449e:	ffffc097          	auipc	ra,0xffffc
    800044a2:	7e6080e7          	jalr	2022(ra) # 80000c84 <release>
  return f;
}
    800044a6:	8526                	mv	a0,s1
    800044a8:	60e2                	ld	ra,24(sp)
    800044aa:	6442                	ld	s0,16(sp)
    800044ac:	64a2                	ld	s1,8(sp)
    800044ae:	6105                	addi	sp,sp,32
    800044b0:	8082                	ret
    panic("filedup");
    800044b2:	00004517          	auipc	a0,0x4
    800044b6:	1de50513          	addi	a0,a0,478 # 80008690 <syscalls+0x248>
    800044ba:	ffffc097          	auipc	ra,0xffffc
    800044be:	07e080e7          	jalr	126(ra) # 80000538 <panic>

00000000800044c2 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    800044c2:	7139                	addi	sp,sp,-64
    800044c4:	fc06                	sd	ra,56(sp)
    800044c6:	f822                	sd	s0,48(sp)
    800044c8:	f426                	sd	s1,40(sp)
    800044ca:	f04a                	sd	s2,32(sp)
    800044cc:	ec4e                	sd	s3,24(sp)
    800044ce:	e852                	sd	s4,16(sp)
    800044d0:	e456                	sd	s5,8(sp)
    800044d2:	0080                	addi	s0,sp,64
    800044d4:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    800044d6:	0001d517          	auipc	a0,0x1d
    800044da:	ee250513          	addi	a0,a0,-286 # 800213b8 <ftable>
    800044de:	ffffc097          	auipc	ra,0xffffc
    800044e2:	6f2080e7          	jalr	1778(ra) # 80000bd0 <acquire>
  if(f->ref < 1)
    800044e6:	40dc                	lw	a5,4(s1)
    800044e8:	06f05163          	blez	a5,8000454a <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    800044ec:	37fd                	addiw	a5,a5,-1
    800044ee:	0007871b          	sext.w	a4,a5
    800044f2:	c0dc                	sw	a5,4(s1)
    800044f4:	06e04363          	bgtz	a4,8000455a <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    800044f8:	0004a903          	lw	s2,0(s1)
    800044fc:	0094ca83          	lbu	s5,9(s1)
    80004500:	0104ba03          	ld	s4,16(s1)
    80004504:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80004508:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    8000450c:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80004510:	0001d517          	auipc	a0,0x1d
    80004514:	ea850513          	addi	a0,a0,-344 # 800213b8 <ftable>
    80004518:	ffffc097          	auipc	ra,0xffffc
    8000451c:	76c080e7          	jalr	1900(ra) # 80000c84 <release>

  if(ff.type == FD_PIPE){
    80004520:	4785                	li	a5,1
    80004522:	04f90d63          	beq	s2,a5,8000457c <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80004526:	3979                	addiw	s2,s2,-2
    80004528:	4785                	li	a5,1
    8000452a:	0527e063          	bltu	a5,s2,8000456a <fileclose+0xa8>
    begin_op();
    8000452e:	00000097          	auipc	ra,0x0
    80004532:	ac8080e7          	jalr	-1336(ra) # 80003ff6 <begin_op>
    iput(ff.ip);
    80004536:	854e                	mv	a0,s3
    80004538:	fffff097          	auipc	ra,0xfffff
    8000453c:	2a6080e7          	jalr	678(ra) # 800037de <iput>
    end_op();
    80004540:	00000097          	auipc	ra,0x0
    80004544:	b36080e7          	jalr	-1226(ra) # 80004076 <end_op>
    80004548:	a00d                	j	8000456a <fileclose+0xa8>
    panic("fileclose");
    8000454a:	00004517          	auipc	a0,0x4
    8000454e:	14e50513          	addi	a0,a0,334 # 80008698 <syscalls+0x250>
    80004552:	ffffc097          	auipc	ra,0xffffc
    80004556:	fe6080e7          	jalr	-26(ra) # 80000538 <panic>
    release(&ftable.lock);
    8000455a:	0001d517          	auipc	a0,0x1d
    8000455e:	e5e50513          	addi	a0,a0,-418 # 800213b8 <ftable>
    80004562:	ffffc097          	auipc	ra,0xffffc
    80004566:	722080e7          	jalr	1826(ra) # 80000c84 <release>
  }
}
    8000456a:	70e2                	ld	ra,56(sp)
    8000456c:	7442                	ld	s0,48(sp)
    8000456e:	74a2                	ld	s1,40(sp)
    80004570:	7902                	ld	s2,32(sp)
    80004572:	69e2                	ld	s3,24(sp)
    80004574:	6a42                	ld	s4,16(sp)
    80004576:	6aa2                	ld	s5,8(sp)
    80004578:	6121                	addi	sp,sp,64
    8000457a:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    8000457c:	85d6                	mv	a1,s5
    8000457e:	8552                	mv	a0,s4
    80004580:	00000097          	auipc	ra,0x0
    80004584:	34c080e7          	jalr	844(ra) # 800048cc <pipeclose>
    80004588:	b7cd                	j	8000456a <fileclose+0xa8>

000000008000458a <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    8000458a:	715d                	addi	sp,sp,-80
    8000458c:	e486                	sd	ra,72(sp)
    8000458e:	e0a2                	sd	s0,64(sp)
    80004590:	fc26                	sd	s1,56(sp)
    80004592:	f84a                	sd	s2,48(sp)
    80004594:	f44e                	sd	s3,40(sp)
    80004596:	0880                	addi	s0,sp,80
    80004598:	84aa                	mv	s1,a0
    8000459a:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    8000459c:	ffffd097          	auipc	ra,0xffffd
    800045a0:	3fa080e7          	jalr	1018(ra) # 80001996 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    800045a4:	409c                	lw	a5,0(s1)
    800045a6:	37f9                	addiw	a5,a5,-2
    800045a8:	4705                	li	a4,1
    800045aa:	04f76763          	bltu	a4,a5,800045f8 <filestat+0x6e>
    800045ae:	892a                	mv	s2,a0
    ilock(f->ip);
    800045b0:	6c88                	ld	a0,24(s1)
    800045b2:	fffff097          	auipc	ra,0xfffff
    800045b6:	072080e7          	jalr	114(ra) # 80003624 <ilock>
    stati(f->ip, &st);
    800045ba:	fb840593          	addi	a1,s0,-72
    800045be:	6c88                	ld	a0,24(s1)
    800045c0:	fffff097          	auipc	ra,0xfffff
    800045c4:	2ee080e7          	jalr	750(ra) # 800038ae <stati>
    iunlock(f->ip);
    800045c8:	6c88                	ld	a0,24(s1)
    800045ca:	fffff097          	auipc	ra,0xfffff
    800045ce:	11c080e7          	jalr	284(ra) # 800036e6 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    800045d2:	46e1                	li	a3,24
    800045d4:	fb840613          	addi	a2,s0,-72
    800045d8:	85ce                	mv	a1,s3
    800045da:	05093503          	ld	a0,80(s2)
    800045de:	ffffd097          	auipc	ra,0xffffd
    800045e2:	078080e7          	jalr	120(ra) # 80001656 <copyout>
    800045e6:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    800045ea:	60a6                	ld	ra,72(sp)
    800045ec:	6406                	ld	s0,64(sp)
    800045ee:	74e2                	ld	s1,56(sp)
    800045f0:	7942                	ld	s2,48(sp)
    800045f2:	79a2                	ld	s3,40(sp)
    800045f4:	6161                	addi	sp,sp,80
    800045f6:	8082                	ret
  return -1;
    800045f8:	557d                	li	a0,-1
    800045fa:	bfc5                	j	800045ea <filestat+0x60>

00000000800045fc <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    800045fc:	7179                	addi	sp,sp,-48
    800045fe:	f406                	sd	ra,40(sp)
    80004600:	f022                	sd	s0,32(sp)
    80004602:	ec26                	sd	s1,24(sp)
    80004604:	e84a                	sd	s2,16(sp)
    80004606:	e44e                	sd	s3,8(sp)
    80004608:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    8000460a:	00854783          	lbu	a5,8(a0)
    8000460e:	c3d5                	beqz	a5,800046b2 <fileread+0xb6>
    80004610:	84aa                	mv	s1,a0
    80004612:	89ae                	mv	s3,a1
    80004614:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80004616:	411c                	lw	a5,0(a0)
    80004618:	4705                	li	a4,1
    8000461a:	04e78963          	beq	a5,a4,8000466c <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    8000461e:	470d                	li	a4,3
    80004620:	04e78d63          	beq	a5,a4,8000467a <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80004624:	4709                	li	a4,2
    80004626:	06e79e63          	bne	a5,a4,800046a2 <fileread+0xa6>
    ilock(f->ip);
    8000462a:	6d08                	ld	a0,24(a0)
    8000462c:	fffff097          	auipc	ra,0xfffff
    80004630:	ff8080e7          	jalr	-8(ra) # 80003624 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80004634:	874a                	mv	a4,s2
    80004636:	5094                	lw	a3,32(s1)
    80004638:	864e                	mv	a2,s3
    8000463a:	4585                	li	a1,1
    8000463c:	6c88                	ld	a0,24(s1)
    8000463e:	fffff097          	auipc	ra,0xfffff
    80004642:	29a080e7          	jalr	666(ra) # 800038d8 <readi>
    80004646:	892a                	mv	s2,a0
    80004648:	00a05563          	blez	a0,80004652 <fileread+0x56>
      f->off += r;
    8000464c:	509c                	lw	a5,32(s1)
    8000464e:	9fa9                	addw	a5,a5,a0
    80004650:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80004652:	6c88                	ld	a0,24(s1)
    80004654:	fffff097          	auipc	ra,0xfffff
    80004658:	092080e7          	jalr	146(ra) # 800036e6 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    8000465c:	854a                	mv	a0,s2
    8000465e:	70a2                	ld	ra,40(sp)
    80004660:	7402                	ld	s0,32(sp)
    80004662:	64e2                	ld	s1,24(sp)
    80004664:	6942                	ld	s2,16(sp)
    80004666:	69a2                	ld	s3,8(sp)
    80004668:	6145                	addi	sp,sp,48
    8000466a:	8082                	ret
    r = piperead(f->pipe, addr, n);
    8000466c:	6908                	ld	a0,16(a0)
    8000466e:	00000097          	auipc	ra,0x0
    80004672:	3c0080e7          	jalr	960(ra) # 80004a2e <piperead>
    80004676:	892a                	mv	s2,a0
    80004678:	b7d5                	j	8000465c <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    8000467a:	02451783          	lh	a5,36(a0)
    8000467e:	03079693          	slli	a3,a5,0x30
    80004682:	92c1                	srli	a3,a3,0x30
    80004684:	4725                	li	a4,9
    80004686:	02d76863          	bltu	a4,a3,800046b6 <fileread+0xba>
    8000468a:	0792                	slli	a5,a5,0x4
    8000468c:	0001d717          	auipc	a4,0x1d
    80004690:	c8c70713          	addi	a4,a4,-884 # 80021318 <devsw>
    80004694:	97ba                	add	a5,a5,a4
    80004696:	639c                	ld	a5,0(a5)
    80004698:	c38d                	beqz	a5,800046ba <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    8000469a:	4505                	li	a0,1
    8000469c:	9782                	jalr	a5
    8000469e:	892a                	mv	s2,a0
    800046a0:	bf75                	j	8000465c <fileread+0x60>
    panic("fileread");
    800046a2:	00004517          	auipc	a0,0x4
    800046a6:	00650513          	addi	a0,a0,6 # 800086a8 <syscalls+0x260>
    800046aa:	ffffc097          	auipc	ra,0xffffc
    800046ae:	e8e080e7          	jalr	-370(ra) # 80000538 <panic>
    return -1;
    800046b2:	597d                	li	s2,-1
    800046b4:	b765                	j	8000465c <fileread+0x60>
      return -1;
    800046b6:	597d                	li	s2,-1
    800046b8:	b755                	j	8000465c <fileread+0x60>
    800046ba:	597d                	li	s2,-1
    800046bc:	b745                	j	8000465c <fileread+0x60>

00000000800046be <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    800046be:	715d                	addi	sp,sp,-80
    800046c0:	e486                	sd	ra,72(sp)
    800046c2:	e0a2                	sd	s0,64(sp)
    800046c4:	fc26                	sd	s1,56(sp)
    800046c6:	f84a                	sd	s2,48(sp)
    800046c8:	f44e                	sd	s3,40(sp)
    800046ca:	f052                	sd	s4,32(sp)
    800046cc:	ec56                	sd	s5,24(sp)
    800046ce:	e85a                	sd	s6,16(sp)
    800046d0:	e45e                	sd	s7,8(sp)
    800046d2:	e062                	sd	s8,0(sp)
    800046d4:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    800046d6:	00954783          	lbu	a5,9(a0)
    800046da:	10078663          	beqz	a5,800047e6 <filewrite+0x128>
    800046de:	892a                	mv	s2,a0
    800046e0:	8aae                	mv	s5,a1
    800046e2:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    800046e4:	411c                	lw	a5,0(a0)
    800046e6:	4705                	li	a4,1
    800046e8:	02e78263          	beq	a5,a4,8000470c <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800046ec:	470d                	li	a4,3
    800046ee:	02e78663          	beq	a5,a4,8000471a <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    800046f2:	4709                	li	a4,2
    800046f4:	0ee79163          	bne	a5,a4,800047d6 <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    800046f8:	0ac05d63          	blez	a2,800047b2 <filewrite+0xf4>
    int i = 0;
    800046fc:	4981                	li	s3,0
    800046fe:	6b05                	lui	s6,0x1
    80004700:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80004704:	6b85                	lui	s7,0x1
    80004706:	c00b8b9b          	addiw	s7,s7,-1024
    8000470a:	a861                	j	800047a2 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    8000470c:	6908                	ld	a0,16(a0)
    8000470e:	00000097          	auipc	ra,0x0
    80004712:	22e080e7          	jalr	558(ra) # 8000493c <pipewrite>
    80004716:	8a2a                	mv	s4,a0
    80004718:	a045                	j	800047b8 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    8000471a:	02451783          	lh	a5,36(a0)
    8000471e:	03079693          	slli	a3,a5,0x30
    80004722:	92c1                	srli	a3,a3,0x30
    80004724:	4725                	li	a4,9
    80004726:	0cd76263          	bltu	a4,a3,800047ea <filewrite+0x12c>
    8000472a:	0792                	slli	a5,a5,0x4
    8000472c:	0001d717          	auipc	a4,0x1d
    80004730:	bec70713          	addi	a4,a4,-1044 # 80021318 <devsw>
    80004734:	97ba                	add	a5,a5,a4
    80004736:	679c                	ld	a5,8(a5)
    80004738:	cbdd                	beqz	a5,800047ee <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    8000473a:	4505                	li	a0,1
    8000473c:	9782                	jalr	a5
    8000473e:	8a2a                	mv	s4,a0
    80004740:	a8a5                	j	800047b8 <filewrite+0xfa>
    80004742:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80004746:	00000097          	auipc	ra,0x0
    8000474a:	8b0080e7          	jalr	-1872(ra) # 80003ff6 <begin_op>
      ilock(f->ip);
    8000474e:	01893503          	ld	a0,24(s2)
    80004752:	fffff097          	auipc	ra,0xfffff
    80004756:	ed2080e7          	jalr	-302(ra) # 80003624 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    8000475a:	8762                	mv	a4,s8
    8000475c:	02092683          	lw	a3,32(s2)
    80004760:	01598633          	add	a2,s3,s5
    80004764:	4585                	li	a1,1
    80004766:	01893503          	ld	a0,24(s2)
    8000476a:	fffff097          	auipc	ra,0xfffff
    8000476e:	266080e7          	jalr	614(ra) # 800039d0 <writei>
    80004772:	84aa                	mv	s1,a0
    80004774:	00a05763          	blez	a0,80004782 <filewrite+0xc4>
        f->off += r;
    80004778:	02092783          	lw	a5,32(s2)
    8000477c:	9fa9                	addw	a5,a5,a0
    8000477e:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80004782:	01893503          	ld	a0,24(s2)
    80004786:	fffff097          	auipc	ra,0xfffff
    8000478a:	f60080e7          	jalr	-160(ra) # 800036e6 <iunlock>
      end_op();
    8000478e:	00000097          	auipc	ra,0x0
    80004792:	8e8080e7          	jalr	-1816(ra) # 80004076 <end_op>

      if(r != n1){
    80004796:	009c1f63          	bne	s8,s1,800047b4 <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    8000479a:	013489bb          	addw	s3,s1,s3
    while(i < n){
    8000479e:	0149db63          	bge	s3,s4,800047b4 <filewrite+0xf6>
      int n1 = n - i;
    800047a2:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    800047a6:	84be                	mv	s1,a5
    800047a8:	2781                	sext.w	a5,a5
    800047aa:	f8fb5ce3          	bge	s6,a5,80004742 <filewrite+0x84>
    800047ae:	84de                	mv	s1,s7
    800047b0:	bf49                	j	80004742 <filewrite+0x84>
    int i = 0;
    800047b2:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    800047b4:	013a1f63          	bne	s4,s3,800047d2 <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    800047b8:	8552                	mv	a0,s4
    800047ba:	60a6                	ld	ra,72(sp)
    800047bc:	6406                	ld	s0,64(sp)
    800047be:	74e2                	ld	s1,56(sp)
    800047c0:	7942                	ld	s2,48(sp)
    800047c2:	79a2                	ld	s3,40(sp)
    800047c4:	7a02                	ld	s4,32(sp)
    800047c6:	6ae2                	ld	s5,24(sp)
    800047c8:	6b42                	ld	s6,16(sp)
    800047ca:	6ba2                	ld	s7,8(sp)
    800047cc:	6c02                	ld	s8,0(sp)
    800047ce:	6161                	addi	sp,sp,80
    800047d0:	8082                	ret
    ret = (i == n ? n : -1);
    800047d2:	5a7d                	li	s4,-1
    800047d4:	b7d5                	j	800047b8 <filewrite+0xfa>
    panic("filewrite");
    800047d6:	00004517          	auipc	a0,0x4
    800047da:	ee250513          	addi	a0,a0,-286 # 800086b8 <syscalls+0x270>
    800047de:	ffffc097          	auipc	ra,0xffffc
    800047e2:	d5a080e7          	jalr	-678(ra) # 80000538 <panic>
    return -1;
    800047e6:	5a7d                	li	s4,-1
    800047e8:	bfc1                	j	800047b8 <filewrite+0xfa>
      return -1;
    800047ea:	5a7d                	li	s4,-1
    800047ec:	b7f1                	j	800047b8 <filewrite+0xfa>
    800047ee:	5a7d                	li	s4,-1
    800047f0:	b7e1                	j	800047b8 <filewrite+0xfa>

00000000800047f2 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    800047f2:	7179                	addi	sp,sp,-48
    800047f4:	f406                	sd	ra,40(sp)
    800047f6:	f022                	sd	s0,32(sp)
    800047f8:	ec26                	sd	s1,24(sp)
    800047fa:	e84a                	sd	s2,16(sp)
    800047fc:	e44e                	sd	s3,8(sp)
    800047fe:	e052                	sd	s4,0(sp)
    80004800:	1800                	addi	s0,sp,48
    80004802:	84aa                	mv	s1,a0
    80004804:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80004806:	0005b023          	sd	zero,0(a1)
    8000480a:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    8000480e:	00000097          	auipc	ra,0x0
    80004812:	bf8080e7          	jalr	-1032(ra) # 80004406 <filealloc>
    80004816:	e088                	sd	a0,0(s1)
    80004818:	c551                	beqz	a0,800048a4 <pipealloc+0xb2>
    8000481a:	00000097          	auipc	ra,0x0
    8000481e:	bec080e7          	jalr	-1044(ra) # 80004406 <filealloc>
    80004822:	00aa3023          	sd	a0,0(s4)
    80004826:	c92d                	beqz	a0,80004898 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80004828:	ffffc097          	auipc	ra,0xffffc
    8000482c:	2b8080e7          	jalr	696(ra) # 80000ae0 <kalloc>
    80004830:	892a                	mv	s2,a0
    80004832:	c125                	beqz	a0,80004892 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80004834:	4985                	li	s3,1
    80004836:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    8000483a:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    8000483e:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80004842:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80004846:	00004597          	auipc	a1,0x4
    8000484a:	e8258593          	addi	a1,a1,-382 # 800086c8 <syscalls+0x280>
    8000484e:	ffffc097          	auipc	ra,0xffffc
    80004852:	2f2080e7          	jalr	754(ra) # 80000b40 <initlock>
  (*f0)->type = FD_PIPE;
    80004856:	609c                	ld	a5,0(s1)
    80004858:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    8000485c:	609c                	ld	a5,0(s1)
    8000485e:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80004862:	609c                	ld	a5,0(s1)
    80004864:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80004868:	609c                	ld	a5,0(s1)
    8000486a:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    8000486e:	000a3783          	ld	a5,0(s4)
    80004872:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80004876:	000a3783          	ld	a5,0(s4)
    8000487a:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    8000487e:	000a3783          	ld	a5,0(s4)
    80004882:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80004886:	000a3783          	ld	a5,0(s4)
    8000488a:	0127b823          	sd	s2,16(a5)
  return 0;
    8000488e:	4501                	li	a0,0
    80004890:	a025                	j	800048b8 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004892:	6088                	ld	a0,0(s1)
    80004894:	e501                	bnez	a0,8000489c <pipealloc+0xaa>
    80004896:	a039                	j	800048a4 <pipealloc+0xb2>
    80004898:	6088                	ld	a0,0(s1)
    8000489a:	c51d                	beqz	a0,800048c8 <pipealloc+0xd6>
    fileclose(*f0);
    8000489c:	00000097          	auipc	ra,0x0
    800048a0:	c26080e7          	jalr	-986(ra) # 800044c2 <fileclose>
  if(*f1)
    800048a4:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    800048a8:	557d                	li	a0,-1
  if(*f1)
    800048aa:	c799                	beqz	a5,800048b8 <pipealloc+0xc6>
    fileclose(*f1);
    800048ac:	853e                	mv	a0,a5
    800048ae:	00000097          	auipc	ra,0x0
    800048b2:	c14080e7          	jalr	-1004(ra) # 800044c2 <fileclose>
  return -1;
    800048b6:	557d                	li	a0,-1
}
    800048b8:	70a2                	ld	ra,40(sp)
    800048ba:	7402                	ld	s0,32(sp)
    800048bc:	64e2                	ld	s1,24(sp)
    800048be:	6942                	ld	s2,16(sp)
    800048c0:	69a2                	ld	s3,8(sp)
    800048c2:	6a02                	ld	s4,0(sp)
    800048c4:	6145                	addi	sp,sp,48
    800048c6:	8082                	ret
  return -1;
    800048c8:	557d                	li	a0,-1
    800048ca:	b7fd                	j	800048b8 <pipealloc+0xc6>

00000000800048cc <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    800048cc:	1101                	addi	sp,sp,-32
    800048ce:	ec06                	sd	ra,24(sp)
    800048d0:	e822                	sd	s0,16(sp)
    800048d2:	e426                	sd	s1,8(sp)
    800048d4:	e04a                	sd	s2,0(sp)
    800048d6:	1000                	addi	s0,sp,32
    800048d8:	84aa                	mv	s1,a0
    800048da:	892e                	mv	s2,a1
  acquire(&pi->lock);
    800048dc:	ffffc097          	auipc	ra,0xffffc
    800048e0:	2f4080e7          	jalr	756(ra) # 80000bd0 <acquire>
  if(writable){
    800048e4:	02090d63          	beqz	s2,8000491e <pipeclose+0x52>
    pi->writeopen = 0;
    800048e8:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    800048ec:	21848513          	addi	a0,s1,536
    800048f0:	ffffe097          	auipc	ra,0xffffe
    800048f4:	8f2080e7          	jalr	-1806(ra) # 800021e2 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    800048f8:	2204b783          	ld	a5,544(s1)
    800048fc:	eb95                	bnez	a5,80004930 <pipeclose+0x64>
    release(&pi->lock);
    800048fe:	8526                	mv	a0,s1
    80004900:	ffffc097          	auipc	ra,0xffffc
    80004904:	384080e7          	jalr	900(ra) # 80000c84 <release>
    kfree((char*)pi);
    80004908:	8526                	mv	a0,s1
    8000490a:	ffffc097          	auipc	ra,0xffffc
    8000490e:	0da080e7          	jalr	218(ra) # 800009e4 <kfree>
  } else
    release(&pi->lock);
}
    80004912:	60e2                	ld	ra,24(sp)
    80004914:	6442                	ld	s0,16(sp)
    80004916:	64a2                	ld	s1,8(sp)
    80004918:	6902                	ld	s2,0(sp)
    8000491a:	6105                	addi	sp,sp,32
    8000491c:	8082                	ret
    pi->readopen = 0;
    8000491e:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80004922:	21c48513          	addi	a0,s1,540
    80004926:	ffffe097          	auipc	ra,0xffffe
    8000492a:	8bc080e7          	jalr	-1860(ra) # 800021e2 <wakeup>
    8000492e:	b7e9                	j	800048f8 <pipeclose+0x2c>
    release(&pi->lock);
    80004930:	8526                	mv	a0,s1
    80004932:	ffffc097          	auipc	ra,0xffffc
    80004936:	352080e7          	jalr	850(ra) # 80000c84 <release>
}
    8000493a:	bfe1                	j	80004912 <pipeclose+0x46>

000000008000493c <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    8000493c:	711d                	addi	sp,sp,-96
    8000493e:	ec86                	sd	ra,88(sp)
    80004940:	e8a2                	sd	s0,80(sp)
    80004942:	e4a6                	sd	s1,72(sp)
    80004944:	e0ca                	sd	s2,64(sp)
    80004946:	fc4e                	sd	s3,56(sp)
    80004948:	f852                	sd	s4,48(sp)
    8000494a:	f456                	sd	s5,40(sp)
    8000494c:	f05a                	sd	s6,32(sp)
    8000494e:	ec5e                	sd	s7,24(sp)
    80004950:	e862                	sd	s8,16(sp)
    80004952:	1080                	addi	s0,sp,96
    80004954:	84aa                	mv	s1,a0
    80004956:	8aae                	mv	s5,a1
    80004958:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    8000495a:	ffffd097          	auipc	ra,0xffffd
    8000495e:	03c080e7          	jalr	60(ra) # 80001996 <myproc>
    80004962:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80004964:	8526                	mv	a0,s1
    80004966:	ffffc097          	auipc	ra,0xffffc
    8000496a:	26a080e7          	jalr	618(ra) # 80000bd0 <acquire>
  while(i < n){
    8000496e:	0b405363          	blez	s4,80004a14 <pipewrite+0xd8>
  int i = 0;
    80004972:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004974:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80004976:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    8000497a:	21c48b93          	addi	s7,s1,540
    8000497e:	a089                	j	800049c0 <pipewrite+0x84>
      release(&pi->lock);
    80004980:	8526                	mv	a0,s1
    80004982:	ffffc097          	auipc	ra,0xffffc
    80004986:	302080e7          	jalr	770(ra) # 80000c84 <release>
      return -1;
    8000498a:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    8000498c:	854a                	mv	a0,s2
    8000498e:	60e6                	ld	ra,88(sp)
    80004990:	6446                	ld	s0,80(sp)
    80004992:	64a6                	ld	s1,72(sp)
    80004994:	6906                	ld	s2,64(sp)
    80004996:	79e2                	ld	s3,56(sp)
    80004998:	7a42                	ld	s4,48(sp)
    8000499a:	7aa2                	ld	s5,40(sp)
    8000499c:	7b02                	ld	s6,32(sp)
    8000499e:	6be2                	ld	s7,24(sp)
    800049a0:	6c42                	ld	s8,16(sp)
    800049a2:	6125                	addi	sp,sp,96
    800049a4:	8082                	ret
      wakeup(&pi->nread);
    800049a6:	8562                	mv	a0,s8
    800049a8:	ffffe097          	auipc	ra,0xffffe
    800049ac:	83a080e7          	jalr	-1990(ra) # 800021e2 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    800049b0:	85a6                	mv	a1,s1
    800049b2:	855e                	mv	a0,s7
    800049b4:	ffffd097          	auipc	ra,0xffffd
    800049b8:	6a2080e7          	jalr	1698(ra) # 80002056 <sleep>
  while(i < n){
    800049bc:	05495d63          	bge	s2,s4,80004a16 <pipewrite+0xda>
    if(pi->readopen == 0 || pr->killed){
    800049c0:	2204a783          	lw	a5,544(s1)
    800049c4:	dfd5                	beqz	a5,80004980 <pipewrite+0x44>
    800049c6:	0289a783          	lw	a5,40(s3)
    800049ca:	fbdd                	bnez	a5,80004980 <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    800049cc:	2184a783          	lw	a5,536(s1)
    800049d0:	21c4a703          	lw	a4,540(s1)
    800049d4:	2007879b          	addiw	a5,a5,512
    800049d8:	fcf707e3          	beq	a4,a5,800049a6 <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800049dc:	4685                	li	a3,1
    800049de:	01590633          	add	a2,s2,s5
    800049e2:	faf40593          	addi	a1,s0,-81
    800049e6:	0509b503          	ld	a0,80(s3)
    800049ea:	ffffd097          	auipc	ra,0xffffd
    800049ee:	cf8080e7          	jalr	-776(ra) # 800016e2 <copyin>
    800049f2:	03650263          	beq	a0,s6,80004a16 <pipewrite+0xda>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    800049f6:	21c4a783          	lw	a5,540(s1)
    800049fa:	0017871b          	addiw	a4,a5,1
    800049fe:	20e4ae23          	sw	a4,540(s1)
    80004a02:	1ff7f793          	andi	a5,a5,511
    80004a06:	97a6                	add	a5,a5,s1
    80004a08:	faf44703          	lbu	a4,-81(s0)
    80004a0c:	00e78c23          	sb	a4,24(a5)
      i++;
    80004a10:	2905                	addiw	s2,s2,1
    80004a12:	b76d                	j	800049bc <pipewrite+0x80>
  int i = 0;
    80004a14:	4901                	li	s2,0
  wakeup(&pi->nread);
    80004a16:	21848513          	addi	a0,s1,536
    80004a1a:	ffffd097          	auipc	ra,0xffffd
    80004a1e:	7c8080e7          	jalr	1992(ra) # 800021e2 <wakeup>
  release(&pi->lock);
    80004a22:	8526                	mv	a0,s1
    80004a24:	ffffc097          	auipc	ra,0xffffc
    80004a28:	260080e7          	jalr	608(ra) # 80000c84 <release>
  return i;
    80004a2c:	b785                	j	8000498c <pipewrite+0x50>

0000000080004a2e <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004a2e:	715d                	addi	sp,sp,-80
    80004a30:	e486                	sd	ra,72(sp)
    80004a32:	e0a2                	sd	s0,64(sp)
    80004a34:	fc26                	sd	s1,56(sp)
    80004a36:	f84a                	sd	s2,48(sp)
    80004a38:	f44e                	sd	s3,40(sp)
    80004a3a:	f052                	sd	s4,32(sp)
    80004a3c:	ec56                	sd	s5,24(sp)
    80004a3e:	e85a                	sd	s6,16(sp)
    80004a40:	0880                	addi	s0,sp,80
    80004a42:	84aa                	mv	s1,a0
    80004a44:	892e                	mv	s2,a1
    80004a46:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80004a48:	ffffd097          	auipc	ra,0xffffd
    80004a4c:	f4e080e7          	jalr	-178(ra) # 80001996 <myproc>
    80004a50:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80004a52:	8526                	mv	a0,s1
    80004a54:	ffffc097          	auipc	ra,0xffffc
    80004a58:	17c080e7          	jalr	380(ra) # 80000bd0 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004a5c:	2184a703          	lw	a4,536(s1)
    80004a60:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004a64:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004a68:	02f71463          	bne	a4,a5,80004a90 <piperead+0x62>
    80004a6c:	2244a783          	lw	a5,548(s1)
    80004a70:	c385                	beqz	a5,80004a90 <piperead+0x62>
    if(pr->killed){
    80004a72:	028a2783          	lw	a5,40(s4)
    80004a76:	ebc1                	bnez	a5,80004b06 <piperead+0xd8>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004a78:	85a6                	mv	a1,s1
    80004a7a:	854e                	mv	a0,s3
    80004a7c:	ffffd097          	auipc	ra,0xffffd
    80004a80:	5da080e7          	jalr	1498(ra) # 80002056 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004a84:	2184a703          	lw	a4,536(s1)
    80004a88:	21c4a783          	lw	a5,540(s1)
    80004a8c:	fef700e3          	beq	a4,a5,80004a6c <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004a90:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004a92:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004a94:	05505363          	blez	s5,80004ada <piperead+0xac>
    if(pi->nread == pi->nwrite)
    80004a98:	2184a783          	lw	a5,536(s1)
    80004a9c:	21c4a703          	lw	a4,540(s1)
    80004aa0:	02f70d63          	beq	a4,a5,80004ada <piperead+0xac>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004aa4:	0017871b          	addiw	a4,a5,1
    80004aa8:	20e4ac23          	sw	a4,536(s1)
    80004aac:	1ff7f793          	andi	a5,a5,511
    80004ab0:	97a6                	add	a5,a5,s1
    80004ab2:	0187c783          	lbu	a5,24(a5)
    80004ab6:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004aba:	4685                	li	a3,1
    80004abc:	fbf40613          	addi	a2,s0,-65
    80004ac0:	85ca                	mv	a1,s2
    80004ac2:	050a3503          	ld	a0,80(s4)
    80004ac6:	ffffd097          	auipc	ra,0xffffd
    80004aca:	b90080e7          	jalr	-1136(ra) # 80001656 <copyout>
    80004ace:	01650663          	beq	a0,s6,80004ada <piperead+0xac>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004ad2:	2985                	addiw	s3,s3,1
    80004ad4:	0905                	addi	s2,s2,1
    80004ad6:	fd3a91e3          	bne	s5,s3,80004a98 <piperead+0x6a>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004ada:	21c48513          	addi	a0,s1,540
    80004ade:	ffffd097          	auipc	ra,0xffffd
    80004ae2:	704080e7          	jalr	1796(ra) # 800021e2 <wakeup>
  release(&pi->lock);
    80004ae6:	8526                	mv	a0,s1
    80004ae8:	ffffc097          	auipc	ra,0xffffc
    80004aec:	19c080e7          	jalr	412(ra) # 80000c84 <release>
  return i;
}
    80004af0:	854e                	mv	a0,s3
    80004af2:	60a6                	ld	ra,72(sp)
    80004af4:	6406                	ld	s0,64(sp)
    80004af6:	74e2                	ld	s1,56(sp)
    80004af8:	7942                	ld	s2,48(sp)
    80004afa:	79a2                	ld	s3,40(sp)
    80004afc:	7a02                	ld	s4,32(sp)
    80004afe:	6ae2                	ld	s5,24(sp)
    80004b00:	6b42                	ld	s6,16(sp)
    80004b02:	6161                	addi	sp,sp,80
    80004b04:	8082                	ret
      release(&pi->lock);
    80004b06:	8526                	mv	a0,s1
    80004b08:	ffffc097          	auipc	ra,0xffffc
    80004b0c:	17c080e7          	jalr	380(ra) # 80000c84 <release>
      return -1;
    80004b10:	59fd                	li	s3,-1
    80004b12:	bff9                	j	80004af0 <piperead+0xc2>

0000000080004b14 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    80004b14:	de010113          	addi	sp,sp,-544
    80004b18:	20113c23          	sd	ra,536(sp)
    80004b1c:	20813823          	sd	s0,528(sp)
    80004b20:	20913423          	sd	s1,520(sp)
    80004b24:	21213023          	sd	s2,512(sp)
    80004b28:	ffce                	sd	s3,504(sp)
    80004b2a:	fbd2                	sd	s4,496(sp)
    80004b2c:	f7d6                	sd	s5,488(sp)
    80004b2e:	f3da                	sd	s6,480(sp)
    80004b30:	efde                	sd	s7,472(sp)
    80004b32:	ebe2                	sd	s8,464(sp)
    80004b34:	e7e6                	sd	s9,456(sp)
    80004b36:	e3ea                	sd	s10,448(sp)
    80004b38:	ff6e                	sd	s11,440(sp)
    80004b3a:	1400                	addi	s0,sp,544
    80004b3c:	892a                	mv	s2,a0
    80004b3e:	dea43423          	sd	a0,-536(s0)
    80004b42:	deb43823          	sd	a1,-528(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004b46:	ffffd097          	auipc	ra,0xffffd
    80004b4a:	e50080e7          	jalr	-432(ra) # 80001996 <myproc>
    80004b4e:	84aa                	mv	s1,a0

  begin_op();
    80004b50:	fffff097          	auipc	ra,0xfffff
    80004b54:	4a6080e7          	jalr	1190(ra) # 80003ff6 <begin_op>

  if((ip = namei(path)) == 0){
    80004b58:	854a                	mv	a0,s2
    80004b5a:	fffff097          	auipc	ra,0xfffff
    80004b5e:	280080e7          	jalr	640(ra) # 80003dda <namei>
    80004b62:	c93d                	beqz	a0,80004bd8 <exec+0xc4>
    80004b64:	8aaa                	mv	s5,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004b66:	fffff097          	auipc	ra,0xfffff
    80004b6a:	abe080e7          	jalr	-1346(ra) # 80003624 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004b6e:	04000713          	li	a4,64
    80004b72:	4681                	li	a3,0
    80004b74:	e5040613          	addi	a2,s0,-432
    80004b78:	4581                	li	a1,0
    80004b7a:	8556                	mv	a0,s5
    80004b7c:	fffff097          	auipc	ra,0xfffff
    80004b80:	d5c080e7          	jalr	-676(ra) # 800038d8 <readi>
    80004b84:	04000793          	li	a5,64
    80004b88:	00f51a63          	bne	a0,a5,80004b9c <exec+0x88>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80004b8c:	e5042703          	lw	a4,-432(s0)
    80004b90:	464c47b7          	lui	a5,0x464c4
    80004b94:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004b98:	04f70663          	beq	a4,a5,80004be4 <exec+0xd0>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80004b9c:	8556                	mv	a0,s5
    80004b9e:	fffff097          	auipc	ra,0xfffff
    80004ba2:	ce8080e7          	jalr	-792(ra) # 80003886 <iunlockput>
    end_op();
    80004ba6:	fffff097          	auipc	ra,0xfffff
    80004baa:	4d0080e7          	jalr	1232(ra) # 80004076 <end_op>
  }
  return -1;
    80004bae:	557d                	li	a0,-1
}
    80004bb0:	21813083          	ld	ra,536(sp)
    80004bb4:	21013403          	ld	s0,528(sp)
    80004bb8:	20813483          	ld	s1,520(sp)
    80004bbc:	20013903          	ld	s2,512(sp)
    80004bc0:	79fe                	ld	s3,504(sp)
    80004bc2:	7a5e                	ld	s4,496(sp)
    80004bc4:	7abe                	ld	s5,488(sp)
    80004bc6:	7b1e                	ld	s6,480(sp)
    80004bc8:	6bfe                	ld	s7,472(sp)
    80004bca:	6c5e                	ld	s8,464(sp)
    80004bcc:	6cbe                	ld	s9,456(sp)
    80004bce:	6d1e                	ld	s10,448(sp)
    80004bd0:	7dfa                	ld	s11,440(sp)
    80004bd2:	22010113          	addi	sp,sp,544
    80004bd6:	8082                	ret
    end_op();
    80004bd8:	fffff097          	auipc	ra,0xfffff
    80004bdc:	49e080e7          	jalr	1182(ra) # 80004076 <end_op>
    return -1;
    80004be0:	557d                	li	a0,-1
    80004be2:	b7f9                	j	80004bb0 <exec+0x9c>
  if((pagetable = proc_pagetable(p)) == 0)
    80004be4:	8526                	mv	a0,s1
    80004be6:	ffffd097          	auipc	ra,0xffffd
    80004bea:	e74080e7          	jalr	-396(ra) # 80001a5a <proc_pagetable>
    80004bee:	8b2a                	mv	s6,a0
    80004bf0:	d555                	beqz	a0,80004b9c <exec+0x88>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004bf2:	e7042783          	lw	a5,-400(s0)
    80004bf6:	e8845703          	lhu	a4,-376(s0)
    80004bfa:	c735                	beqz	a4,80004c66 <exec+0x152>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004bfc:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004bfe:	e0043423          	sd	zero,-504(s0)
    if((ph.vaddr % PGSIZE) != 0)
    80004c02:	6a05                	lui	s4,0x1
    80004c04:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    80004c08:	dee43023          	sd	a4,-544(s0)
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    80004c0c:	6d85                	lui	s11,0x1
    80004c0e:	7d7d                	lui	s10,0xfffff
    80004c10:	ac1d                	j	80004e46 <exec+0x332>
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    80004c12:	00004517          	auipc	a0,0x4
    80004c16:	abe50513          	addi	a0,a0,-1346 # 800086d0 <syscalls+0x288>
    80004c1a:	ffffc097          	auipc	ra,0xffffc
    80004c1e:	91e080e7          	jalr	-1762(ra) # 80000538 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004c22:	874a                	mv	a4,s2
    80004c24:	009c86bb          	addw	a3,s9,s1
    80004c28:	4581                	li	a1,0
    80004c2a:	8556                	mv	a0,s5
    80004c2c:	fffff097          	auipc	ra,0xfffff
    80004c30:	cac080e7          	jalr	-852(ra) # 800038d8 <readi>
    80004c34:	2501                	sext.w	a0,a0
    80004c36:	1aa91863          	bne	s2,a0,80004de6 <exec+0x2d2>
  for(i = 0; i < sz; i += PGSIZE){
    80004c3a:	009d84bb          	addw	s1,s11,s1
    80004c3e:	013d09bb          	addw	s3,s10,s3
    80004c42:	1f74f263          	bgeu	s1,s7,80004e26 <exec+0x312>
    pa = walkaddr(pagetable, va + i);
    80004c46:	02049593          	slli	a1,s1,0x20
    80004c4a:	9181                	srli	a1,a1,0x20
    80004c4c:	95e2                	add	a1,a1,s8
    80004c4e:	855a                	mv	a0,s6
    80004c50:	ffffc097          	auipc	ra,0xffffc
    80004c54:	402080e7          	jalr	1026(ra) # 80001052 <walkaddr>
    80004c58:	862a                	mv	a2,a0
    if(pa == 0)
    80004c5a:	dd45                	beqz	a0,80004c12 <exec+0xfe>
      n = PGSIZE;
    80004c5c:	8952                	mv	s2,s4
    if(sz - i < PGSIZE)
    80004c5e:	fd49f2e3          	bgeu	s3,s4,80004c22 <exec+0x10e>
      n = sz - i;
    80004c62:	894e                	mv	s2,s3
    80004c64:	bf7d                	j	80004c22 <exec+0x10e>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004c66:	4481                	li	s1,0
  iunlockput(ip);
    80004c68:	8556                	mv	a0,s5
    80004c6a:	fffff097          	auipc	ra,0xfffff
    80004c6e:	c1c080e7          	jalr	-996(ra) # 80003886 <iunlockput>
  end_op();
    80004c72:	fffff097          	auipc	ra,0xfffff
    80004c76:	404080e7          	jalr	1028(ra) # 80004076 <end_op>
  p = myproc();
    80004c7a:	ffffd097          	auipc	ra,0xffffd
    80004c7e:	d1c080e7          	jalr	-740(ra) # 80001996 <myproc>
    80004c82:	8baa                	mv	s7,a0
  uint64 oldsz = p->sz;
    80004c84:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    80004c88:	6785                	lui	a5,0x1
    80004c8a:	17fd                	addi	a5,a5,-1
    80004c8c:	94be                	add	s1,s1,a5
    80004c8e:	77fd                	lui	a5,0xfffff
    80004c90:	8fe5                	and	a5,a5,s1
    80004c92:	def43c23          	sd	a5,-520(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004c96:	6609                	lui	a2,0x2
    80004c98:	963e                	add	a2,a2,a5
    80004c9a:	85be                	mv	a1,a5
    80004c9c:	855a                	mv	a0,s6
    80004c9e:	ffffc097          	auipc	ra,0xffffc
    80004ca2:	768080e7          	jalr	1896(ra) # 80001406 <uvmalloc>
    80004ca6:	8c2a                	mv	s8,a0
  ip = 0;
    80004ca8:	4a81                	li	s5,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004caa:	12050e63          	beqz	a0,80004de6 <exec+0x2d2>
  uvmclear(pagetable, sz-2*PGSIZE);
    80004cae:	75f9                	lui	a1,0xffffe
    80004cb0:	95aa                	add	a1,a1,a0
    80004cb2:	855a                	mv	a0,s6
    80004cb4:	ffffd097          	auipc	ra,0xffffd
    80004cb8:	970080e7          	jalr	-1680(ra) # 80001624 <uvmclear>
  stackbase = sp - PGSIZE;
    80004cbc:	7afd                	lui	s5,0xfffff
    80004cbe:	9ae2                	add	s5,s5,s8
  for(argc = 0; argv[argc]; argc++) {
    80004cc0:	df043783          	ld	a5,-528(s0)
    80004cc4:	6388                	ld	a0,0(a5)
    80004cc6:	c925                	beqz	a0,80004d36 <exec+0x222>
    80004cc8:	e9040993          	addi	s3,s0,-368
    80004ccc:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    80004cd0:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80004cd2:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    80004cd4:	ffffc097          	auipc	ra,0xffffc
    80004cd8:	174080e7          	jalr	372(ra) # 80000e48 <strlen>
    80004cdc:	0015079b          	addiw	a5,a0,1
    80004ce0:	40f90933          	sub	s2,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004ce4:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    80004ce8:	13596363          	bltu	s2,s5,80004e0e <exec+0x2fa>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004cec:	df043d83          	ld	s11,-528(s0)
    80004cf0:	000dba03          	ld	s4,0(s11) # 1000 <_entry-0x7ffff000>
    80004cf4:	8552                	mv	a0,s4
    80004cf6:	ffffc097          	auipc	ra,0xffffc
    80004cfa:	152080e7          	jalr	338(ra) # 80000e48 <strlen>
    80004cfe:	0015069b          	addiw	a3,a0,1
    80004d02:	8652                	mv	a2,s4
    80004d04:	85ca                	mv	a1,s2
    80004d06:	855a                	mv	a0,s6
    80004d08:	ffffd097          	auipc	ra,0xffffd
    80004d0c:	94e080e7          	jalr	-1714(ra) # 80001656 <copyout>
    80004d10:	10054363          	bltz	a0,80004e16 <exec+0x302>
    ustack[argc] = sp;
    80004d14:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80004d18:	0485                	addi	s1,s1,1
    80004d1a:	008d8793          	addi	a5,s11,8
    80004d1e:	def43823          	sd	a5,-528(s0)
    80004d22:	008db503          	ld	a0,8(s11)
    80004d26:	c911                	beqz	a0,80004d3a <exec+0x226>
    if(argc >= MAXARG)
    80004d28:	09a1                	addi	s3,s3,8
    80004d2a:	fb3c95e3          	bne	s9,s3,80004cd4 <exec+0x1c0>
  sz = sz1;
    80004d2e:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004d32:	4a81                	li	s5,0
    80004d34:	a84d                	j	80004de6 <exec+0x2d2>
  sp = sz;
    80004d36:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80004d38:	4481                	li	s1,0
  ustack[argc] = 0;
    80004d3a:	00349793          	slli	a5,s1,0x3
    80004d3e:	f9040713          	addi	a4,s0,-112
    80004d42:	97ba                	add	a5,a5,a4
    80004d44:	f007b023          	sd	zero,-256(a5) # ffffffffffffef00 <end+0xffffffff7ffd8f00>
  sp -= (argc+1) * sizeof(uint64);
    80004d48:	00148693          	addi	a3,s1,1
    80004d4c:	068e                	slli	a3,a3,0x3
    80004d4e:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004d52:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80004d56:	01597663          	bgeu	s2,s5,80004d62 <exec+0x24e>
  sz = sz1;
    80004d5a:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004d5e:	4a81                	li	s5,0
    80004d60:	a059                	j	80004de6 <exec+0x2d2>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004d62:	e9040613          	addi	a2,s0,-368
    80004d66:	85ca                	mv	a1,s2
    80004d68:	855a                	mv	a0,s6
    80004d6a:	ffffd097          	auipc	ra,0xffffd
    80004d6e:	8ec080e7          	jalr	-1812(ra) # 80001656 <copyout>
    80004d72:	0a054663          	bltz	a0,80004e1e <exec+0x30a>
  p->trapframe->a1 = sp;
    80004d76:	058bb783          	ld	a5,88(s7) # 1058 <_entry-0x7fffefa8>
    80004d7a:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80004d7e:	de843783          	ld	a5,-536(s0)
    80004d82:	0007c703          	lbu	a4,0(a5)
    80004d86:	cf11                	beqz	a4,80004da2 <exec+0x28e>
    80004d88:	0785                	addi	a5,a5,1
    if(*s == '/')
    80004d8a:	02f00693          	li	a3,47
    80004d8e:	a039                	j	80004d9c <exec+0x288>
      last = s+1;
    80004d90:	def43423          	sd	a5,-536(s0)
  for(last=s=path; *s; s++)
    80004d94:	0785                	addi	a5,a5,1
    80004d96:	fff7c703          	lbu	a4,-1(a5)
    80004d9a:	c701                	beqz	a4,80004da2 <exec+0x28e>
    if(*s == '/')
    80004d9c:	fed71ce3          	bne	a4,a3,80004d94 <exec+0x280>
    80004da0:	bfc5                	j	80004d90 <exec+0x27c>
  safestrcpy(p->name, last, sizeof(p->name));
    80004da2:	4641                	li	a2,16
    80004da4:	de843583          	ld	a1,-536(s0)
    80004da8:	158b8513          	addi	a0,s7,344
    80004dac:	ffffc097          	auipc	ra,0xffffc
    80004db0:	06a080e7          	jalr	106(ra) # 80000e16 <safestrcpy>
  oldpagetable = p->pagetable;
    80004db4:	050bb503          	ld	a0,80(s7)
  p->pagetable = pagetable;
    80004db8:	056bb823          	sd	s6,80(s7)
  p->sz = sz;
    80004dbc:	058bb423          	sd	s8,72(s7)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80004dc0:	058bb783          	ld	a5,88(s7)
    80004dc4:	e6843703          	ld	a4,-408(s0)
    80004dc8:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80004dca:	058bb783          	ld	a5,88(s7)
    80004dce:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80004dd2:	85ea                	mv	a1,s10
    80004dd4:	ffffd097          	auipc	ra,0xffffd
    80004dd8:	d22080e7          	jalr	-734(ra) # 80001af6 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004ddc:	0004851b          	sext.w	a0,s1
    80004de0:	bbc1                	j	80004bb0 <exec+0x9c>
    80004de2:	de943c23          	sd	s1,-520(s0)
    proc_freepagetable(pagetable, sz);
    80004de6:	df843583          	ld	a1,-520(s0)
    80004dea:	855a                	mv	a0,s6
    80004dec:	ffffd097          	auipc	ra,0xffffd
    80004df0:	d0a080e7          	jalr	-758(ra) # 80001af6 <proc_freepagetable>
  if(ip){
    80004df4:	da0a94e3          	bnez	s5,80004b9c <exec+0x88>
  return -1;
    80004df8:	557d                	li	a0,-1
    80004dfa:	bb5d                	j	80004bb0 <exec+0x9c>
    80004dfc:	de943c23          	sd	s1,-520(s0)
    80004e00:	b7dd                	j	80004de6 <exec+0x2d2>
    80004e02:	de943c23          	sd	s1,-520(s0)
    80004e06:	b7c5                	j	80004de6 <exec+0x2d2>
    80004e08:	de943c23          	sd	s1,-520(s0)
    80004e0c:	bfe9                	j	80004de6 <exec+0x2d2>
  sz = sz1;
    80004e0e:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004e12:	4a81                	li	s5,0
    80004e14:	bfc9                	j	80004de6 <exec+0x2d2>
  sz = sz1;
    80004e16:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004e1a:	4a81                	li	s5,0
    80004e1c:	b7e9                	j	80004de6 <exec+0x2d2>
  sz = sz1;
    80004e1e:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004e22:	4a81                	li	s5,0
    80004e24:	b7c9                	j	80004de6 <exec+0x2d2>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80004e26:	df843483          	ld	s1,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004e2a:	e0843783          	ld	a5,-504(s0)
    80004e2e:	0017869b          	addiw	a3,a5,1
    80004e32:	e0d43423          	sd	a3,-504(s0)
    80004e36:	e0043783          	ld	a5,-512(s0)
    80004e3a:	0387879b          	addiw	a5,a5,56
    80004e3e:	e8845703          	lhu	a4,-376(s0)
    80004e42:	e2e6d3e3          	bge	a3,a4,80004c68 <exec+0x154>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004e46:	2781                	sext.w	a5,a5
    80004e48:	e0f43023          	sd	a5,-512(s0)
    80004e4c:	03800713          	li	a4,56
    80004e50:	86be                	mv	a3,a5
    80004e52:	e1840613          	addi	a2,s0,-488
    80004e56:	4581                	li	a1,0
    80004e58:	8556                	mv	a0,s5
    80004e5a:	fffff097          	auipc	ra,0xfffff
    80004e5e:	a7e080e7          	jalr	-1410(ra) # 800038d8 <readi>
    80004e62:	03800793          	li	a5,56
    80004e66:	f6f51ee3          	bne	a0,a5,80004de2 <exec+0x2ce>
    if(ph.type != ELF_PROG_LOAD)
    80004e6a:	e1842783          	lw	a5,-488(s0)
    80004e6e:	4705                	li	a4,1
    80004e70:	fae79de3          	bne	a5,a4,80004e2a <exec+0x316>
    if(ph.memsz < ph.filesz)
    80004e74:	e4043603          	ld	a2,-448(s0)
    80004e78:	e3843783          	ld	a5,-456(s0)
    80004e7c:	f8f660e3          	bltu	a2,a5,80004dfc <exec+0x2e8>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004e80:	e2843783          	ld	a5,-472(s0)
    80004e84:	963e                	add	a2,a2,a5
    80004e86:	f6f66ee3          	bltu	a2,a5,80004e02 <exec+0x2ee>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80004e8a:	85a6                	mv	a1,s1
    80004e8c:	855a                	mv	a0,s6
    80004e8e:	ffffc097          	auipc	ra,0xffffc
    80004e92:	578080e7          	jalr	1400(ra) # 80001406 <uvmalloc>
    80004e96:	dea43c23          	sd	a0,-520(s0)
    80004e9a:	d53d                	beqz	a0,80004e08 <exec+0x2f4>
    if((ph.vaddr % PGSIZE) != 0)
    80004e9c:	e2843c03          	ld	s8,-472(s0)
    80004ea0:	de043783          	ld	a5,-544(s0)
    80004ea4:	00fc77b3          	and	a5,s8,a5
    80004ea8:	ff9d                	bnez	a5,80004de6 <exec+0x2d2>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004eaa:	e2042c83          	lw	s9,-480(s0)
    80004eae:	e3842b83          	lw	s7,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004eb2:	f60b8ae3          	beqz	s7,80004e26 <exec+0x312>
    80004eb6:	89de                	mv	s3,s7
    80004eb8:	4481                	li	s1,0
    80004eba:	b371                	j	80004c46 <exec+0x132>

0000000080004ebc <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80004ebc:	7179                	addi	sp,sp,-48
    80004ebe:	f406                	sd	ra,40(sp)
    80004ec0:	f022                	sd	s0,32(sp)
    80004ec2:	ec26                	sd	s1,24(sp)
    80004ec4:	e84a                	sd	s2,16(sp)
    80004ec6:	1800                	addi	s0,sp,48
    80004ec8:	892e                	mv	s2,a1
    80004eca:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80004ecc:	fdc40593          	addi	a1,s0,-36
    80004ed0:	ffffe097          	auipc	ra,0xffffe
    80004ed4:	bcc080e7          	jalr	-1076(ra) # 80002a9c <argint>
    80004ed8:	04054063          	bltz	a0,80004f18 <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80004edc:	fdc42703          	lw	a4,-36(s0)
    80004ee0:	47bd                	li	a5,15
    80004ee2:	02e7ed63          	bltu	a5,a4,80004f1c <argfd+0x60>
    80004ee6:	ffffd097          	auipc	ra,0xffffd
    80004eea:	ab0080e7          	jalr	-1360(ra) # 80001996 <myproc>
    80004eee:	fdc42703          	lw	a4,-36(s0)
    80004ef2:	01a70793          	addi	a5,a4,26
    80004ef6:	078e                	slli	a5,a5,0x3
    80004ef8:	953e                	add	a0,a0,a5
    80004efa:	611c                	ld	a5,0(a0)
    80004efc:	c395                	beqz	a5,80004f20 <argfd+0x64>
    return -1;
  if(pfd)
    80004efe:	00090463          	beqz	s2,80004f06 <argfd+0x4a>
    *pfd = fd;
    80004f02:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80004f06:	4501                	li	a0,0
  if(pf)
    80004f08:	c091                	beqz	s1,80004f0c <argfd+0x50>
    *pf = f;
    80004f0a:	e09c                	sd	a5,0(s1)
}
    80004f0c:	70a2                	ld	ra,40(sp)
    80004f0e:	7402                	ld	s0,32(sp)
    80004f10:	64e2                	ld	s1,24(sp)
    80004f12:	6942                	ld	s2,16(sp)
    80004f14:	6145                	addi	sp,sp,48
    80004f16:	8082                	ret
    return -1;
    80004f18:	557d                	li	a0,-1
    80004f1a:	bfcd                	j	80004f0c <argfd+0x50>
    return -1;
    80004f1c:	557d                	li	a0,-1
    80004f1e:	b7fd                	j	80004f0c <argfd+0x50>
    80004f20:	557d                	li	a0,-1
    80004f22:	b7ed                	j	80004f0c <argfd+0x50>

0000000080004f24 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80004f24:	1101                	addi	sp,sp,-32
    80004f26:	ec06                	sd	ra,24(sp)
    80004f28:	e822                	sd	s0,16(sp)
    80004f2a:	e426                	sd	s1,8(sp)
    80004f2c:	1000                	addi	s0,sp,32
    80004f2e:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80004f30:	ffffd097          	auipc	ra,0xffffd
    80004f34:	a66080e7          	jalr	-1434(ra) # 80001996 <myproc>
    80004f38:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80004f3a:	0d050793          	addi	a5,a0,208
    80004f3e:	4501                	li	a0,0
    80004f40:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80004f42:	6398                	ld	a4,0(a5)
    80004f44:	cb19                	beqz	a4,80004f5a <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80004f46:	2505                	addiw	a0,a0,1
    80004f48:	07a1                	addi	a5,a5,8
    80004f4a:	fed51ce3          	bne	a0,a3,80004f42 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004f4e:	557d                	li	a0,-1
}
    80004f50:	60e2                	ld	ra,24(sp)
    80004f52:	6442                	ld	s0,16(sp)
    80004f54:	64a2                	ld	s1,8(sp)
    80004f56:	6105                	addi	sp,sp,32
    80004f58:	8082                	ret
      p->ofile[fd] = f;
    80004f5a:	01a50793          	addi	a5,a0,26
    80004f5e:	078e                	slli	a5,a5,0x3
    80004f60:	963e                	add	a2,a2,a5
    80004f62:	e204                	sd	s1,0(a2)
      return fd;
    80004f64:	b7f5                	j	80004f50 <fdalloc+0x2c>

0000000080004f66 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80004f66:	715d                	addi	sp,sp,-80
    80004f68:	e486                	sd	ra,72(sp)
    80004f6a:	e0a2                	sd	s0,64(sp)
    80004f6c:	fc26                	sd	s1,56(sp)
    80004f6e:	f84a                	sd	s2,48(sp)
    80004f70:	f44e                	sd	s3,40(sp)
    80004f72:	f052                	sd	s4,32(sp)
    80004f74:	ec56                	sd	s5,24(sp)
    80004f76:	0880                	addi	s0,sp,80
    80004f78:	89ae                	mv	s3,a1
    80004f7a:	8ab2                	mv	s5,a2
    80004f7c:	8a36                	mv	s4,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004f7e:	fb040593          	addi	a1,s0,-80
    80004f82:	fffff097          	auipc	ra,0xfffff
    80004f86:	e76080e7          	jalr	-394(ra) # 80003df8 <nameiparent>
    80004f8a:	892a                	mv	s2,a0
    80004f8c:	12050e63          	beqz	a0,800050c8 <create+0x162>
    return 0;

  ilock(dp);
    80004f90:	ffffe097          	auipc	ra,0xffffe
    80004f94:	694080e7          	jalr	1684(ra) # 80003624 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80004f98:	4601                	li	a2,0
    80004f9a:	fb040593          	addi	a1,s0,-80
    80004f9e:	854a                	mv	a0,s2
    80004fa0:	fffff097          	auipc	ra,0xfffff
    80004fa4:	b68080e7          	jalr	-1176(ra) # 80003b08 <dirlookup>
    80004fa8:	84aa                	mv	s1,a0
    80004faa:	c921                	beqz	a0,80004ffa <create+0x94>
    iunlockput(dp);
    80004fac:	854a                	mv	a0,s2
    80004fae:	fffff097          	auipc	ra,0xfffff
    80004fb2:	8d8080e7          	jalr	-1832(ra) # 80003886 <iunlockput>
    ilock(ip);
    80004fb6:	8526                	mv	a0,s1
    80004fb8:	ffffe097          	auipc	ra,0xffffe
    80004fbc:	66c080e7          	jalr	1644(ra) # 80003624 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004fc0:	2981                	sext.w	s3,s3
    80004fc2:	4789                	li	a5,2
    80004fc4:	02f99463          	bne	s3,a5,80004fec <create+0x86>
    80004fc8:	0444d783          	lhu	a5,68(s1)
    80004fcc:	37f9                	addiw	a5,a5,-2
    80004fce:	17c2                	slli	a5,a5,0x30
    80004fd0:	93c1                	srli	a5,a5,0x30
    80004fd2:	4705                	li	a4,1
    80004fd4:	00f76c63          	bltu	a4,a5,80004fec <create+0x86>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    80004fd8:	8526                	mv	a0,s1
    80004fda:	60a6                	ld	ra,72(sp)
    80004fdc:	6406                	ld	s0,64(sp)
    80004fde:	74e2                	ld	s1,56(sp)
    80004fe0:	7942                	ld	s2,48(sp)
    80004fe2:	79a2                	ld	s3,40(sp)
    80004fe4:	7a02                	ld	s4,32(sp)
    80004fe6:	6ae2                	ld	s5,24(sp)
    80004fe8:	6161                	addi	sp,sp,80
    80004fea:	8082                	ret
    iunlockput(ip);
    80004fec:	8526                	mv	a0,s1
    80004fee:	fffff097          	auipc	ra,0xfffff
    80004ff2:	898080e7          	jalr	-1896(ra) # 80003886 <iunlockput>
    return 0;
    80004ff6:	4481                	li	s1,0
    80004ff8:	b7c5                	j	80004fd8 <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0)
    80004ffa:	85ce                	mv	a1,s3
    80004ffc:	00092503          	lw	a0,0(s2)
    80005000:	ffffe097          	auipc	ra,0xffffe
    80005004:	48c080e7          	jalr	1164(ra) # 8000348c <ialloc>
    80005008:	84aa                	mv	s1,a0
    8000500a:	c521                	beqz	a0,80005052 <create+0xec>
  ilock(ip);
    8000500c:	ffffe097          	auipc	ra,0xffffe
    80005010:	618080e7          	jalr	1560(ra) # 80003624 <ilock>
  ip->major = major;
    80005014:	05549323          	sh	s5,70(s1)
  ip->minor = minor;
    80005018:	05449423          	sh	s4,72(s1)
  ip->nlink = 1;
    8000501c:	4a05                	li	s4,1
    8000501e:	05449523          	sh	s4,74(s1)
  iupdate(ip);
    80005022:	8526                	mv	a0,s1
    80005024:	ffffe097          	auipc	ra,0xffffe
    80005028:	536080e7          	jalr	1334(ra) # 8000355a <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    8000502c:	2981                	sext.w	s3,s3
    8000502e:	03498a63          	beq	s3,s4,80005062 <create+0xfc>
  if(dirlink(dp, name, ip->inum) < 0)
    80005032:	40d0                	lw	a2,4(s1)
    80005034:	fb040593          	addi	a1,s0,-80
    80005038:	854a                	mv	a0,s2
    8000503a:	fffff097          	auipc	ra,0xfffff
    8000503e:	cde080e7          	jalr	-802(ra) # 80003d18 <dirlink>
    80005042:	06054b63          	bltz	a0,800050b8 <create+0x152>
  iunlockput(dp);
    80005046:	854a                	mv	a0,s2
    80005048:	fffff097          	auipc	ra,0xfffff
    8000504c:	83e080e7          	jalr	-1986(ra) # 80003886 <iunlockput>
  return ip;
    80005050:	b761                	j	80004fd8 <create+0x72>
    panic("create: ialloc");
    80005052:	00003517          	auipc	a0,0x3
    80005056:	69e50513          	addi	a0,a0,1694 # 800086f0 <syscalls+0x2a8>
    8000505a:	ffffb097          	auipc	ra,0xffffb
    8000505e:	4de080e7          	jalr	1246(ra) # 80000538 <panic>
    dp->nlink++;  // for ".."
    80005062:	04a95783          	lhu	a5,74(s2)
    80005066:	2785                	addiw	a5,a5,1
    80005068:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    8000506c:	854a                	mv	a0,s2
    8000506e:	ffffe097          	auipc	ra,0xffffe
    80005072:	4ec080e7          	jalr	1260(ra) # 8000355a <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80005076:	40d0                	lw	a2,4(s1)
    80005078:	00003597          	auipc	a1,0x3
    8000507c:	68858593          	addi	a1,a1,1672 # 80008700 <syscalls+0x2b8>
    80005080:	8526                	mv	a0,s1
    80005082:	fffff097          	auipc	ra,0xfffff
    80005086:	c96080e7          	jalr	-874(ra) # 80003d18 <dirlink>
    8000508a:	00054f63          	bltz	a0,800050a8 <create+0x142>
    8000508e:	00492603          	lw	a2,4(s2)
    80005092:	00003597          	auipc	a1,0x3
    80005096:	67658593          	addi	a1,a1,1654 # 80008708 <syscalls+0x2c0>
    8000509a:	8526                	mv	a0,s1
    8000509c:	fffff097          	auipc	ra,0xfffff
    800050a0:	c7c080e7          	jalr	-900(ra) # 80003d18 <dirlink>
    800050a4:	f80557e3          	bgez	a0,80005032 <create+0xcc>
      panic("create dots");
    800050a8:	00003517          	auipc	a0,0x3
    800050ac:	66850513          	addi	a0,a0,1640 # 80008710 <syscalls+0x2c8>
    800050b0:	ffffb097          	auipc	ra,0xffffb
    800050b4:	488080e7          	jalr	1160(ra) # 80000538 <panic>
    panic("create: dirlink");
    800050b8:	00003517          	auipc	a0,0x3
    800050bc:	66850513          	addi	a0,a0,1640 # 80008720 <syscalls+0x2d8>
    800050c0:	ffffb097          	auipc	ra,0xffffb
    800050c4:	478080e7          	jalr	1144(ra) # 80000538 <panic>
    return 0;
    800050c8:	84aa                	mv	s1,a0
    800050ca:	b739                	j	80004fd8 <create+0x72>

00000000800050cc <sys_dup>:
{
    800050cc:	7179                	addi	sp,sp,-48
    800050ce:	f406                	sd	ra,40(sp)
    800050d0:	f022                	sd	s0,32(sp)
    800050d2:	ec26                	sd	s1,24(sp)
    800050d4:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    800050d6:	fd840613          	addi	a2,s0,-40
    800050da:	4581                	li	a1,0
    800050dc:	4501                	li	a0,0
    800050de:	00000097          	auipc	ra,0x0
    800050e2:	dde080e7          	jalr	-546(ra) # 80004ebc <argfd>
    return -1;
    800050e6:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800050e8:	02054363          	bltz	a0,8000510e <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    800050ec:	fd843503          	ld	a0,-40(s0)
    800050f0:	00000097          	auipc	ra,0x0
    800050f4:	e34080e7          	jalr	-460(ra) # 80004f24 <fdalloc>
    800050f8:	84aa                	mv	s1,a0
    return -1;
    800050fa:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    800050fc:	00054963          	bltz	a0,8000510e <sys_dup+0x42>
  filedup(f);
    80005100:	fd843503          	ld	a0,-40(s0)
    80005104:	fffff097          	auipc	ra,0xfffff
    80005108:	36c080e7          	jalr	876(ra) # 80004470 <filedup>
  return fd;
    8000510c:	87a6                	mv	a5,s1
}
    8000510e:	853e                	mv	a0,a5
    80005110:	70a2                	ld	ra,40(sp)
    80005112:	7402                	ld	s0,32(sp)
    80005114:	64e2                	ld	s1,24(sp)
    80005116:	6145                	addi	sp,sp,48
    80005118:	8082                	ret

000000008000511a <sys_read>:
{
    8000511a:	7179                	addi	sp,sp,-48
    8000511c:	f406                	sd	ra,40(sp)
    8000511e:	f022                	sd	s0,32(sp)
    80005120:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005122:	fe840613          	addi	a2,s0,-24
    80005126:	4581                	li	a1,0
    80005128:	4501                	li	a0,0
    8000512a:	00000097          	auipc	ra,0x0
    8000512e:	d92080e7          	jalr	-622(ra) # 80004ebc <argfd>
    return -1;
    80005132:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005134:	04054163          	bltz	a0,80005176 <sys_read+0x5c>
    80005138:	fe440593          	addi	a1,s0,-28
    8000513c:	4509                	li	a0,2
    8000513e:	ffffe097          	auipc	ra,0xffffe
    80005142:	95e080e7          	jalr	-1698(ra) # 80002a9c <argint>
    return -1;
    80005146:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005148:	02054763          	bltz	a0,80005176 <sys_read+0x5c>
    8000514c:	fd840593          	addi	a1,s0,-40
    80005150:	4505                	li	a0,1
    80005152:	ffffe097          	auipc	ra,0xffffe
    80005156:	96c080e7          	jalr	-1684(ra) # 80002abe <argaddr>
    return -1;
    8000515a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000515c:	00054d63          	bltz	a0,80005176 <sys_read+0x5c>
  return fileread(f, p, n);
    80005160:	fe442603          	lw	a2,-28(s0)
    80005164:	fd843583          	ld	a1,-40(s0)
    80005168:	fe843503          	ld	a0,-24(s0)
    8000516c:	fffff097          	auipc	ra,0xfffff
    80005170:	490080e7          	jalr	1168(ra) # 800045fc <fileread>
    80005174:	87aa                	mv	a5,a0
}
    80005176:	853e                	mv	a0,a5
    80005178:	70a2                	ld	ra,40(sp)
    8000517a:	7402                	ld	s0,32(sp)
    8000517c:	6145                	addi	sp,sp,48
    8000517e:	8082                	ret

0000000080005180 <sys_write>:
{
    80005180:	7179                	addi	sp,sp,-48
    80005182:	f406                	sd	ra,40(sp)
    80005184:	f022                	sd	s0,32(sp)
    80005186:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005188:	fe840613          	addi	a2,s0,-24
    8000518c:	4581                	li	a1,0
    8000518e:	4501                	li	a0,0
    80005190:	00000097          	auipc	ra,0x0
    80005194:	d2c080e7          	jalr	-724(ra) # 80004ebc <argfd>
    return -1;
    80005198:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000519a:	04054163          	bltz	a0,800051dc <sys_write+0x5c>
    8000519e:	fe440593          	addi	a1,s0,-28
    800051a2:	4509                	li	a0,2
    800051a4:	ffffe097          	auipc	ra,0xffffe
    800051a8:	8f8080e7          	jalr	-1800(ra) # 80002a9c <argint>
    return -1;
    800051ac:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800051ae:	02054763          	bltz	a0,800051dc <sys_write+0x5c>
    800051b2:	fd840593          	addi	a1,s0,-40
    800051b6:	4505                	li	a0,1
    800051b8:	ffffe097          	auipc	ra,0xffffe
    800051bc:	906080e7          	jalr	-1786(ra) # 80002abe <argaddr>
    return -1;
    800051c0:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800051c2:	00054d63          	bltz	a0,800051dc <sys_write+0x5c>
  return filewrite(f, p, n);
    800051c6:	fe442603          	lw	a2,-28(s0)
    800051ca:	fd843583          	ld	a1,-40(s0)
    800051ce:	fe843503          	ld	a0,-24(s0)
    800051d2:	fffff097          	auipc	ra,0xfffff
    800051d6:	4ec080e7          	jalr	1260(ra) # 800046be <filewrite>
    800051da:	87aa                	mv	a5,a0
}
    800051dc:	853e                	mv	a0,a5
    800051de:	70a2                	ld	ra,40(sp)
    800051e0:	7402                	ld	s0,32(sp)
    800051e2:	6145                	addi	sp,sp,48
    800051e4:	8082                	ret

00000000800051e6 <sys_close>:
{
    800051e6:	1101                	addi	sp,sp,-32
    800051e8:	ec06                	sd	ra,24(sp)
    800051ea:	e822                	sd	s0,16(sp)
    800051ec:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800051ee:	fe040613          	addi	a2,s0,-32
    800051f2:	fec40593          	addi	a1,s0,-20
    800051f6:	4501                	li	a0,0
    800051f8:	00000097          	auipc	ra,0x0
    800051fc:	cc4080e7          	jalr	-828(ra) # 80004ebc <argfd>
    return -1;
    80005200:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80005202:	02054463          	bltz	a0,8000522a <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80005206:	ffffc097          	auipc	ra,0xffffc
    8000520a:	790080e7          	jalr	1936(ra) # 80001996 <myproc>
    8000520e:	fec42783          	lw	a5,-20(s0)
    80005212:	07e9                	addi	a5,a5,26
    80005214:	078e                	slli	a5,a5,0x3
    80005216:	97aa                	add	a5,a5,a0
    80005218:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    8000521c:	fe043503          	ld	a0,-32(s0)
    80005220:	fffff097          	auipc	ra,0xfffff
    80005224:	2a2080e7          	jalr	674(ra) # 800044c2 <fileclose>
  return 0;
    80005228:	4781                	li	a5,0
}
    8000522a:	853e                	mv	a0,a5
    8000522c:	60e2                	ld	ra,24(sp)
    8000522e:	6442                	ld	s0,16(sp)
    80005230:	6105                	addi	sp,sp,32
    80005232:	8082                	ret

0000000080005234 <sys_fstat>:
{
    80005234:	1101                	addi	sp,sp,-32
    80005236:	ec06                	sd	ra,24(sp)
    80005238:	e822                	sd	s0,16(sp)
    8000523a:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    8000523c:	fe840613          	addi	a2,s0,-24
    80005240:	4581                	li	a1,0
    80005242:	4501                	li	a0,0
    80005244:	00000097          	auipc	ra,0x0
    80005248:	c78080e7          	jalr	-904(ra) # 80004ebc <argfd>
    return -1;
    8000524c:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    8000524e:	02054563          	bltz	a0,80005278 <sys_fstat+0x44>
    80005252:	fe040593          	addi	a1,s0,-32
    80005256:	4505                	li	a0,1
    80005258:	ffffe097          	auipc	ra,0xffffe
    8000525c:	866080e7          	jalr	-1946(ra) # 80002abe <argaddr>
    return -1;
    80005260:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80005262:	00054b63          	bltz	a0,80005278 <sys_fstat+0x44>
  return filestat(f, st);
    80005266:	fe043583          	ld	a1,-32(s0)
    8000526a:	fe843503          	ld	a0,-24(s0)
    8000526e:	fffff097          	auipc	ra,0xfffff
    80005272:	31c080e7          	jalr	796(ra) # 8000458a <filestat>
    80005276:	87aa                	mv	a5,a0
}
    80005278:	853e                	mv	a0,a5
    8000527a:	60e2                	ld	ra,24(sp)
    8000527c:	6442                	ld	s0,16(sp)
    8000527e:	6105                	addi	sp,sp,32
    80005280:	8082                	ret

0000000080005282 <sys_link>:
{
    80005282:	7169                	addi	sp,sp,-304
    80005284:	f606                	sd	ra,296(sp)
    80005286:	f222                	sd	s0,288(sp)
    80005288:	ee26                	sd	s1,280(sp)
    8000528a:	ea4a                	sd	s2,272(sp)
    8000528c:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000528e:	08000613          	li	a2,128
    80005292:	ed040593          	addi	a1,s0,-304
    80005296:	4501                	li	a0,0
    80005298:	ffffe097          	auipc	ra,0xffffe
    8000529c:	848080e7          	jalr	-1976(ra) # 80002ae0 <argstr>
    return -1;
    800052a0:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800052a2:	10054e63          	bltz	a0,800053be <sys_link+0x13c>
    800052a6:	08000613          	li	a2,128
    800052aa:	f5040593          	addi	a1,s0,-176
    800052ae:	4505                	li	a0,1
    800052b0:	ffffe097          	auipc	ra,0xffffe
    800052b4:	830080e7          	jalr	-2000(ra) # 80002ae0 <argstr>
    return -1;
    800052b8:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800052ba:	10054263          	bltz	a0,800053be <sys_link+0x13c>
  begin_op();
    800052be:	fffff097          	auipc	ra,0xfffff
    800052c2:	d38080e7          	jalr	-712(ra) # 80003ff6 <begin_op>
  if((ip = namei(old)) == 0){
    800052c6:	ed040513          	addi	a0,s0,-304
    800052ca:	fffff097          	auipc	ra,0xfffff
    800052ce:	b10080e7          	jalr	-1264(ra) # 80003dda <namei>
    800052d2:	84aa                	mv	s1,a0
    800052d4:	c551                	beqz	a0,80005360 <sys_link+0xde>
  ilock(ip);
    800052d6:	ffffe097          	auipc	ra,0xffffe
    800052da:	34e080e7          	jalr	846(ra) # 80003624 <ilock>
  if(ip->type == T_DIR){
    800052de:	04449703          	lh	a4,68(s1)
    800052e2:	4785                	li	a5,1
    800052e4:	08f70463          	beq	a4,a5,8000536c <sys_link+0xea>
  ip->nlink++;
    800052e8:	04a4d783          	lhu	a5,74(s1)
    800052ec:	2785                	addiw	a5,a5,1
    800052ee:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800052f2:	8526                	mv	a0,s1
    800052f4:	ffffe097          	auipc	ra,0xffffe
    800052f8:	266080e7          	jalr	614(ra) # 8000355a <iupdate>
  iunlock(ip);
    800052fc:	8526                	mv	a0,s1
    800052fe:	ffffe097          	auipc	ra,0xffffe
    80005302:	3e8080e7          	jalr	1000(ra) # 800036e6 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80005306:	fd040593          	addi	a1,s0,-48
    8000530a:	f5040513          	addi	a0,s0,-176
    8000530e:	fffff097          	auipc	ra,0xfffff
    80005312:	aea080e7          	jalr	-1302(ra) # 80003df8 <nameiparent>
    80005316:	892a                	mv	s2,a0
    80005318:	c935                	beqz	a0,8000538c <sys_link+0x10a>
  ilock(dp);
    8000531a:	ffffe097          	auipc	ra,0xffffe
    8000531e:	30a080e7          	jalr	778(ra) # 80003624 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80005322:	00092703          	lw	a4,0(s2)
    80005326:	409c                	lw	a5,0(s1)
    80005328:	04f71d63          	bne	a4,a5,80005382 <sys_link+0x100>
    8000532c:	40d0                	lw	a2,4(s1)
    8000532e:	fd040593          	addi	a1,s0,-48
    80005332:	854a                	mv	a0,s2
    80005334:	fffff097          	auipc	ra,0xfffff
    80005338:	9e4080e7          	jalr	-1564(ra) # 80003d18 <dirlink>
    8000533c:	04054363          	bltz	a0,80005382 <sys_link+0x100>
  iunlockput(dp);
    80005340:	854a                	mv	a0,s2
    80005342:	ffffe097          	auipc	ra,0xffffe
    80005346:	544080e7          	jalr	1348(ra) # 80003886 <iunlockput>
  iput(ip);
    8000534a:	8526                	mv	a0,s1
    8000534c:	ffffe097          	auipc	ra,0xffffe
    80005350:	492080e7          	jalr	1170(ra) # 800037de <iput>
  end_op();
    80005354:	fffff097          	auipc	ra,0xfffff
    80005358:	d22080e7          	jalr	-734(ra) # 80004076 <end_op>
  return 0;
    8000535c:	4781                	li	a5,0
    8000535e:	a085                	j	800053be <sys_link+0x13c>
    end_op();
    80005360:	fffff097          	auipc	ra,0xfffff
    80005364:	d16080e7          	jalr	-746(ra) # 80004076 <end_op>
    return -1;
    80005368:	57fd                	li	a5,-1
    8000536a:	a891                	j	800053be <sys_link+0x13c>
    iunlockput(ip);
    8000536c:	8526                	mv	a0,s1
    8000536e:	ffffe097          	auipc	ra,0xffffe
    80005372:	518080e7          	jalr	1304(ra) # 80003886 <iunlockput>
    end_op();
    80005376:	fffff097          	auipc	ra,0xfffff
    8000537a:	d00080e7          	jalr	-768(ra) # 80004076 <end_op>
    return -1;
    8000537e:	57fd                	li	a5,-1
    80005380:	a83d                	j	800053be <sys_link+0x13c>
    iunlockput(dp);
    80005382:	854a                	mv	a0,s2
    80005384:	ffffe097          	auipc	ra,0xffffe
    80005388:	502080e7          	jalr	1282(ra) # 80003886 <iunlockput>
  ilock(ip);
    8000538c:	8526                	mv	a0,s1
    8000538e:	ffffe097          	auipc	ra,0xffffe
    80005392:	296080e7          	jalr	662(ra) # 80003624 <ilock>
  ip->nlink--;
    80005396:	04a4d783          	lhu	a5,74(s1)
    8000539a:	37fd                	addiw	a5,a5,-1
    8000539c:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800053a0:	8526                	mv	a0,s1
    800053a2:	ffffe097          	auipc	ra,0xffffe
    800053a6:	1b8080e7          	jalr	440(ra) # 8000355a <iupdate>
  iunlockput(ip);
    800053aa:	8526                	mv	a0,s1
    800053ac:	ffffe097          	auipc	ra,0xffffe
    800053b0:	4da080e7          	jalr	1242(ra) # 80003886 <iunlockput>
  end_op();
    800053b4:	fffff097          	auipc	ra,0xfffff
    800053b8:	cc2080e7          	jalr	-830(ra) # 80004076 <end_op>
  return -1;
    800053bc:	57fd                	li	a5,-1
}
    800053be:	853e                	mv	a0,a5
    800053c0:	70b2                	ld	ra,296(sp)
    800053c2:	7412                	ld	s0,288(sp)
    800053c4:	64f2                	ld	s1,280(sp)
    800053c6:	6952                	ld	s2,272(sp)
    800053c8:	6155                	addi	sp,sp,304
    800053ca:	8082                	ret

00000000800053cc <sys_unlink>:
{
    800053cc:	7151                	addi	sp,sp,-240
    800053ce:	f586                	sd	ra,232(sp)
    800053d0:	f1a2                	sd	s0,224(sp)
    800053d2:	eda6                	sd	s1,216(sp)
    800053d4:	e9ca                	sd	s2,208(sp)
    800053d6:	e5ce                	sd	s3,200(sp)
    800053d8:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    800053da:	08000613          	li	a2,128
    800053de:	f3040593          	addi	a1,s0,-208
    800053e2:	4501                	li	a0,0
    800053e4:	ffffd097          	auipc	ra,0xffffd
    800053e8:	6fc080e7          	jalr	1788(ra) # 80002ae0 <argstr>
    800053ec:	18054163          	bltz	a0,8000556e <sys_unlink+0x1a2>
  begin_op();
    800053f0:	fffff097          	auipc	ra,0xfffff
    800053f4:	c06080e7          	jalr	-1018(ra) # 80003ff6 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800053f8:	fb040593          	addi	a1,s0,-80
    800053fc:	f3040513          	addi	a0,s0,-208
    80005400:	fffff097          	auipc	ra,0xfffff
    80005404:	9f8080e7          	jalr	-1544(ra) # 80003df8 <nameiparent>
    80005408:	84aa                	mv	s1,a0
    8000540a:	c979                	beqz	a0,800054e0 <sys_unlink+0x114>
  ilock(dp);
    8000540c:	ffffe097          	auipc	ra,0xffffe
    80005410:	218080e7          	jalr	536(ra) # 80003624 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80005414:	00003597          	auipc	a1,0x3
    80005418:	2ec58593          	addi	a1,a1,748 # 80008700 <syscalls+0x2b8>
    8000541c:	fb040513          	addi	a0,s0,-80
    80005420:	ffffe097          	auipc	ra,0xffffe
    80005424:	6ce080e7          	jalr	1742(ra) # 80003aee <namecmp>
    80005428:	14050a63          	beqz	a0,8000557c <sys_unlink+0x1b0>
    8000542c:	00003597          	auipc	a1,0x3
    80005430:	2dc58593          	addi	a1,a1,732 # 80008708 <syscalls+0x2c0>
    80005434:	fb040513          	addi	a0,s0,-80
    80005438:	ffffe097          	auipc	ra,0xffffe
    8000543c:	6b6080e7          	jalr	1718(ra) # 80003aee <namecmp>
    80005440:	12050e63          	beqz	a0,8000557c <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80005444:	f2c40613          	addi	a2,s0,-212
    80005448:	fb040593          	addi	a1,s0,-80
    8000544c:	8526                	mv	a0,s1
    8000544e:	ffffe097          	auipc	ra,0xffffe
    80005452:	6ba080e7          	jalr	1722(ra) # 80003b08 <dirlookup>
    80005456:	892a                	mv	s2,a0
    80005458:	12050263          	beqz	a0,8000557c <sys_unlink+0x1b0>
  ilock(ip);
    8000545c:	ffffe097          	auipc	ra,0xffffe
    80005460:	1c8080e7          	jalr	456(ra) # 80003624 <ilock>
  if(ip->nlink < 1)
    80005464:	04a91783          	lh	a5,74(s2)
    80005468:	08f05263          	blez	a5,800054ec <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    8000546c:	04491703          	lh	a4,68(s2)
    80005470:	4785                	li	a5,1
    80005472:	08f70563          	beq	a4,a5,800054fc <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80005476:	4641                	li	a2,16
    80005478:	4581                	li	a1,0
    8000547a:	fc040513          	addi	a0,s0,-64
    8000547e:	ffffc097          	auipc	ra,0xffffc
    80005482:	84e080e7          	jalr	-1970(ra) # 80000ccc <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005486:	4741                	li	a4,16
    80005488:	f2c42683          	lw	a3,-212(s0)
    8000548c:	fc040613          	addi	a2,s0,-64
    80005490:	4581                	li	a1,0
    80005492:	8526                	mv	a0,s1
    80005494:	ffffe097          	auipc	ra,0xffffe
    80005498:	53c080e7          	jalr	1340(ra) # 800039d0 <writei>
    8000549c:	47c1                	li	a5,16
    8000549e:	0af51563          	bne	a0,a5,80005548 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    800054a2:	04491703          	lh	a4,68(s2)
    800054a6:	4785                	li	a5,1
    800054a8:	0af70863          	beq	a4,a5,80005558 <sys_unlink+0x18c>
  iunlockput(dp);
    800054ac:	8526                	mv	a0,s1
    800054ae:	ffffe097          	auipc	ra,0xffffe
    800054b2:	3d8080e7          	jalr	984(ra) # 80003886 <iunlockput>
  ip->nlink--;
    800054b6:	04a95783          	lhu	a5,74(s2)
    800054ba:	37fd                	addiw	a5,a5,-1
    800054bc:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    800054c0:	854a                	mv	a0,s2
    800054c2:	ffffe097          	auipc	ra,0xffffe
    800054c6:	098080e7          	jalr	152(ra) # 8000355a <iupdate>
  iunlockput(ip);
    800054ca:	854a                	mv	a0,s2
    800054cc:	ffffe097          	auipc	ra,0xffffe
    800054d0:	3ba080e7          	jalr	954(ra) # 80003886 <iunlockput>
  end_op();
    800054d4:	fffff097          	auipc	ra,0xfffff
    800054d8:	ba2080e7          	jalr	-1118(ra) # 80004076 <end_op>
  return 0;
    800054dc:	4501                	li	a0,0
    800054de:	a84d                	j	80005590 <sys_unlink+0x1c4>
    end_op();
    800054e0:	fffff097          	auipc	ra,0xfffff
    800054e4:	b96080e7          	jalr	-1130(ra) # 80004076 <end_op>
    return -1;
    800054e8:	557d                	li	a0,-1
    800054ea:	a05d                	j	80005590 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    800054ec:	00003517          	auipc	a0,0x3
    800054f0:	24450513          	addi	a0,a0,580 # 80008730 <syscalls+0x2e8>
    800054f4:	ffffb097          	auipc	ra,0xffffb
    800054f8:	044080e7          	jalr	68(ra) # 80000538 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800054fc:	04c92703          	lw	a4,76(s2)
    80005500:	02000793          	li	a5,32
    80005504:	f6e7f9e3          	bgeu	a5,a4,80005476 <sys_unlink+0xaa>
    80005508:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000550c:	4741                	li	a4,16
    8000550e:	86ce                	mv	a3,s3
    80005510:	f1840613          	addi	a2,s0,-232
    80005514:	4581                	li	a1,0
    80005516:	854a                	mv	a0,s2
    80005518:	ffffe097          	auipc	ra,0xffffe
    8000551c:	3c0080e7          	jalr	960(ra) # 800038d8 <readi>
    80005520:	47c1                	li	a5,16
    80005522:	00f51b63          	bne	a0,a5,80005538 <sys_unlink+0x16c>
    if(de.inum != 0)
    80005526:	f1845783          	lhu	a5,-232(s0)
    8000552a:	e7a1                	bnez	a5,80005572 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    8000552c:	29c1                	addiw	s3,s3,16
    8000552e:	04c92783          	lw	a5,76(s2)
    80005532:	fcf9ede3          	bltu	s3,a5,8000550c <sys_unlink+0x140>
    80005536:	b781                	j	80005476 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80005538:	00003517          	auipc	a0,0x3
    8000553c:	21050513          	addi	a0,a0,528 # 80008748 <syscalls+0x300>
    80005540:	ffffb097          	auipc	ra,0xffffb
    80005544:	ff8080e7          	jalr	-8(ra) # 80000538 <panic>
    panic("unlink: writei");
    80005548:	00003517          	auipc	a0,0x3
    8000554c:	21850513          	addi	a0,a0,536 # 80008760 <syscalls+0x318>
    80005550:	ffffb097          	auipc	ra,0xffffb
    80005554:	fe8080e7          	jalr	-24(ra) # 80000538 <panic>
    dp->nlink--;
    80005558:	04a4d783          	lhu	a5,74(s1)
    8000555c:	37fd                	addiw	a5,a5,-1
    8000555e:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80005562:	8526                	mv	a0,s1
    80005564:	ffffe097          	auipc	ra,0xffffe
    80005568:	ff6080e7          	jalr	-10(ra) # 8000355a <iupdate>
    8000556c:	b781                	j	800054ac <sys_unlink+0xe0>
    return -1;
    8000556e:	557d                	li	a0,-1
    80005570:	a005                	j	80005590 <sys_unlink+0x1c4>
    iunlockput(ip);
    80005572:	854a                	mv	a0,s2
    80005574:	ffffe097          	auipc	ra,0xffffe
    80005578:	312080e7          	jalr	786(ra) # 80003886 <iunlockput>
  iunlockput(dp);
    8000557c:	8526                	mv	a0,s1
    8000557e:	ffffe097          	auipc	ra,0xffffe
    80005582:	308080e7          	jalr	776(ra) # 80003886 <iunlockput>
  end_op();
    80005586:	fffff097          	auipc	ra,0xfffff
    8000558a:	af0080e7          	jalr	-1296(ra) # 80004076 <end_op>
  return -1;
    8000558e:	557d                	li	a0,-1
}
    80005590:	70ae                	ld	ra,232(sp)
    80005592:	740e                	ld	s0,224(sp)
    80005594:	64ee                	ld	s1,216(sp)
    80005596:	694e                	ld	s2,208(sp)
    80005598:	69ae                	ld	s3,200(sp)
    8000559a:	616d                	addi	sp,sp,240
    8000559c:	8082                	ret

000000008000559e <sys_open>:

uint64
sys_open(void)
{
    8000559e:	7131                	addi	sp,sp,-192
    800055a0:	fd06                	sd	ra,184(sp)
    800055a2:	f922                	sd	s0,176(sp)
    800055a4:	f526                	sd	s1,168(sp)
    800055a6:	f14a                	sd	s2,160(sp)
    800055a8:	ed4e                	sd	s3,152(sp)
    800055aa:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800055ac:	08000613          	li	a2,128
    800055b0:	f5040593          	addi	a1,s0,-176
    800055b4:	4501                	li	a0,0
    800055b6:	ffffd097          	auipc	ra,0xffffd
    800055ba:	52a080e7          	jalr	1322(ra) # 80002ae0 <argstr>
    return -1;
    800055be:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800055c0:	0c054163          	bltz	a0,80005682 <sys_open+0xe4>
    800055c4:	f4c40593          	addi	a1,s0,-180
    800055c8:	4505                	li	a0,1
    800055ca:	ffffd097          	auipc	ra,0xffffd
    800055ce:	4d2080e7          	jalr	1234(ra) # 80002a9c <argint>
    800055d2:	0a054863          	bltz	a0,80005682 <sys_open+0xe4>

  begin_op();
    800055d6:	fffff097          	auipc	ra,0xfffff
    800055da:	a20080e7          	jalr	-1504(ra) # 80003ff6 <begin_op>

  if(omode & O_CREATE){
    800055de:	f4c42783          	lw	a5,-180(s0)
    800055e2:	2007f793          	andi	a5,a5,512
    800055e6:	cbdd                	beqz	a5,8000569c <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    800055e8:	4681                	li	a3,0
    800055ea:	4601                	li	a2,0
    800055ec:	4589                	li	a1,2
    800055ee:	f5040513          	addi	a0,s0,-176
    800055f2:	00000097          	auipc	ra,0x0
    800055f6:	974080e7          	jalr	-1676(ra) # 80004f66 <create>
    800055fa:	892a                	mv	s2,a0
    if(ip == 0){
    800055fc:	c959                	beqz	a0,80005692 <sys_open+0xf4>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    800055fe:	04491703          	lh	a4,68(s2)
    80005602:	478d                	li	a5,3
    80005604:	00f71763          	bne	a4,a5,80005612 <sys_open+0x74>
    80005608:	04695703          	lhu	a4,70(s2)
    8000560c:	47a5                	li	a5,9
    8000560e:	0ce7ec63          	bltu	a5,a4,800056e6 <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80005612:	fffff097          	auipc	ra,0xfffff
    80005616:	df4080e7          	jalr	-524(ra) # 80004406 <filealloc>
    8000561a:	89aa                	mv	s3,a0
    8000561c:	10050263          	beqz	a0,80005720 <sys_open+0x182>
    80005620:	00000097          	auipc	ra,0x0
    80005624:	904080e7          	jalr	-1788(ra) # 80004f24 <fdalloc>
    80005628:	84aa                	mv	s1,a0
    8000562a:	0e054663          	bltz	a0,80005716 <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    8000562e:	04491703          	lh	a4,68(s2)
    80005632:	478d                	li	a5,3
    80005634:	0cf70463          	beq	a4,a5,800056fc <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80005638:	4789                	li	a5,2
    8000563a:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    8000563e:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80005642:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    80005646:	f4c42783          	lw	a5,-180(s0)
    8000564a:	0017c713          	xori	a4,a5,1
    8000564e:	8b05                	andi	a4,a4,1
    80005650:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80005654:	0037f713          	andi	a4,a5,3
    80005658:	00e03733          	snez	a4,a4
    8000565c:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80005660:	4007f793          	andi	a5,a5,1024
    80005664:	c791                	beqz	a5,80005670 <sys_open+0xd2>
    80005666:	04491703          	lh	a4,68(s2)
    8000566a:	4789                	li	a5,2
    8000566c:	08f70f63          	beq	a4,a5,8000570a <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80005670:	854a                	mv	a0,s2
    80005672:	ffffe097          	auipc	ra,0xffffe
    80005676:	074080e7          	jalr	116(ra) # 800036e6 <iunlock>
  end_op();
    8000567a:	fffff097          	auipc	ra,0xfffff
    8000567e:	9fc080e7          	jalr	-1540(ra) # 80004076 <end_op>

  return fd;
}
    80005682:	8526                	mv	a0,s1
    80005684:	70ea                	ld	ra,184(sp)
    80005686:	744a                	ld	s0,176(sp)
    80005688:	74aa                	ld	s1,168(sp)
    8000568a:	790a                	ld	s2,160(sp)
    8000568c:	69ea                	ld	s3,152(sp)
    8000568e:	6129                	addi	sp,sp,192
    80005690:	8082                	ret
      end_op();
    80005692:	fffff097          	auipc	ra,0xfffff
    80005696:	9e4080e7          	jalr	-1564(ra) # 80004076 <end_op>
      return -1;
    8000569a:	b7e5                	j	80005682 <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    8000569c:	f5040513          	addi	a0,s0,-176
    800056a0:	ffffe097          	auipc	ra,0xffffe
    800056a4:	73a080e7          	jalr	1850(ra) # 80003dda <namei>
    800056a8:	892a                	mv	s2,a0
    800056aa:	c905                	beqz	a0,800056da <sys_open+0x13c>
    ilock(ip);
    800056ac:	ffffe097          	auipc	ra,0xffffe
    800056b0:	f78080e7          	jalr	-136(ra) # 80003624 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    800056b4:	04491703          	lh	a4,68(s2)
    800056b8:	4785                	li	a5,1
    800056ba:	f4f712e3          	bne	a4,a5,800055fe <sys_open+0x60>
    800056be:	f4c42783          	lw	a5,-180(s0)
    800056c2:	dba1                	beqz	a5,80005612 <sys_open+0x74>
      iunlockput(ip);
    800056c4:	854a                	mv	a0,s2
    800056c6:	ffffe097          	auipc	ra,0xffffe
    800056ca:	1c0080e7          	jalr	448(ra) # 80003886 <iunlockput>
      end_op();
    800056ce:	fffff097          	auipc	ra,0xfffff
    800056d2:	9a8080e7          	jalr	-1624(ra) # 80004076 <end_op>
      return -1;
    800056d6:	54fd                	li	s1,-1
    800056d8:	b76d                	j	80005682 <sys_open+0xe4>
      end_op();
    800056da:	fffff097          	auipc	ra,0xfffff
    800056de:	99c080e7          	jalr	-1636(ra) # 80004076 <end_op>
      return -1;
    800056e2:	54fd                	li	s1,-1
    800056e4:	bf79                	j	80005682 <sys_open+0xe4>
    iunlockput(ip);
    800056e6:	854a                	mv	a0,s2
    800056e8:	ffffe097          	auipc	ra,0xffffe
    800056ec:	19e080e7          	jalr	414(ra) # 80003886 <iunlockput>
    end_op();
    800056f0:	fffff097          	auipc	ra,0xfffff
    800056f4:	986080e7          	jalr	-1658(ra) # 80004076 <end_op>
    return -1;
    800056f8:	54fd                	li	s1,-1
    800056fa:	b761                	j	80005682 <sys_open+0xe4>
    f->type = FD_DEVICE;
    800056fc:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80005700:	04691783          	lh	a5,70(s2)
    80005704:	02f99223          	sh	a5,36(s3)
    80005708:	bf2d                	j	80005642 <sys_open+0xa4>
    itrunc(ip);
    8000570a:	854a                	mv	a0,s2
    8000570c:	ffffe097          	auipc	ra,0xffffe
    80005710:	026080e7          	jalr	38(ra) # 80003732 <itrunc>
    80005714:	bfb1                	j	80005670 <sys_open+0xd2>
      fileclose(f);
    80005716:	854e                	mv	a0,s3
    80005718:	fffff097          	auipc	ra,0xfffff
    8000571c:	daa080e7          	jalr	-598(ra) # 800044c2 <fileclose>
    iunlockput(ip);
    80005720:	854a                	mv	a0,s2
    80005722:	ffffe097          	auipc	ra,0xffffe
    80005726:	164080e7          	jalr	356(ra) # 80003886 <iunlockput>
    end_op();
    8000572a:	fffff097          	auipc	ra,0xfffff
    8000572e:	94c080e7          	jalr	-1716(ra) # 80004076 <end_op>
    return -1;
    80005732:	54fd                	li	s1,-1
    80005734:	b7b9                	j	80005682 <sys_open+0xe4>

0000000080005736 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80005736:	7175                	addi	sp,sp,-144
    80005738:	e506                	sd	ra,136(sp)
    8000573a:	e122                	sd	s0,128(sp)
    8000573c:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    8000573e:	fffff097          	auipc	ra,0xfffff
    80005742:	8b8080e7          	jalr	-1864(ra) # 80003ff6 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80005746:	08000613          	li	a2,128
    8000574a:	f7040593          	addi	a1,s0,-144
    8000574e:	4501                	li	a0,0
    80005750:	ffffd097          	auipc	ra,0xffffd
    80005754:	390080e7          	jalr	912(ra) # 80002ae0 <argstr>
    80005758:	02054963          	bltz	a0,8000578a <sys_mkdir+0x54>
    8000575c:	4681                	li	a3,0
    8000575e:	4601                	li	a2,0
    80005760:	4585                	li	a1,1
    80005762:	f7040513          	addi	a0,s0,-144
    80005766:	00000097          	auipc	ra,0x0
    8000576a:	800080e7          	jalr	-2048(ra) # 80004f66 <create>
    8000576e:	cd11                	beqz	a0,8000578a <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005770:	ffffe097          	auipc	ra,0xffffe
    80005774:	116080e7          	jalr	278(ra) # 80003886 <iunlockput>
  end_op();
    80005778:	fffff097          	auipc	ra,0xfffff
    8000577c:	8fe080e7          	jalr	-1794(ra) # 80004076 <end_op>
  return 0;
    80005780:	4501                	li	a0,0
}
    80005782:	60aa                	ld	ra,136(sp)
    80005784:	640a                	ld	s0,128(sp)
    80005786:	6149                	addi	sp,sp,144
    80005788:	8082                	ret
    end_op();
    8000578a:	fffff097          	auipc	ra,0xfffff
    8000578e:	8ec080e7          	jalr	-1812(ra) # 80004076 <end_op>
    return -1;
    80005792:	557d                	li	a0,-1
    80005794:	b7fd                	j	80005782 <sys_mkdir+0x4c>

0000000080005796 <sys_mknod>:

uint64
sys_mknod(void)
{
    80005796:	7135                	addi	sp,sp,-160
    80005798:	ed06                	sd	ra,152(sp)
    8000579a:	e922                	sd	s0,144(sp)
    8000579c:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    8000579e:	fffff097          	auipc	ra,0xfffff
    800057a2:	858080e7          	jalr	-1960(ra) # 80003ff6 <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    800057a6:	08000613          	li	a2,128
    800057aa:	f7040593          	addi	a1,s0,-144
    800057ae:	4501                	li	a0,0
    800057b0:	ffffd097          	auipc	ra,0xffffd
    800057b4:	330080e7          	jalr	816(ra) # 80002ae0 <argstr>
    800057b8:	04054a63          	bltz	a0,8000580c <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    800057bc:	f6c40593          	addi	a1,s0,-148
    800057c0:	4505                	li	a0,1
    800057c2:	ffffd097          	auipc	ra,0xffffd
    800057c6:	2da080e7          	jalr	730(ra) # 80002a9c <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    800057ca:	04054163          	bltz	a0,8000580c <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    800057ce:	f6840593          	addi	a1,s0,-152
    800057d2:	4509                	li	a0,2
    800057d4:	ffffd097          	auipc	ra,0xffffd
    800057d8:	2c8080e7          	jalr	712(ra) # 80002a9c <argint>
     argint(1, &major) < 0 ||
    800057dc:	02054863          	bltz	a0,8000580c <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    800057e0:	f6841683          	lh	a3,-152(s0)
    800057e4:	f6c41603          	lh	a2,-148(s0)
    800057e8:	458d                	li	a1,3
    800057ea:	f7040513          	addi	a0,s0,-144
    800057ee:	fffff097          	auipc	ra,0xfffff
    800057f2:	778080e7          	jalr	1912(ra) # 80004f66 <create>
     argint(2, &minor) < 0 ||
    800057f6:	c919                	beqz	a0,8000580c <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    800057f8:	ffffe097          	auipc	ra,0xffffe
    800057fc:	08e080e7          	jalr	142(ra) # 80003886 <iunlockput>
  end_op();
    80005800:	fffff097          	auipc	ra,0xfffff
    80005804:	876080e7          	jalr	-1930(ra) # 80004076 <end_op>
  return 0;
    80005808:	4501                	li	a0,0
    8000580a:	a031                	j	80005816 <sys_mknod+0x80>
    end_op();
    8000580c:	fffff097          	auipc	ra,0xfffff
    80005810:	86a080e7          	jalr	-1942(ra) # 80004076 <end_op>
    return -1;
    80005814:	557d                	li	a0,-1
}
    80005816:	60ea                	ld	ra,152(sp)
    80005818:	644a                	ld	s0,144(sp)
    8000581a:	610d                	addi	sp,sp,160
    8000581c:	8082                	ret

000000008000581e <sys_chdir>:

uint64
sys_chdir(void)
{
    8000581e:	7135                	addi	sp,sp,-160
    80005820:	ed06                	sd	ra,152(sp)
    80005822:	e922                	sd	s0,144(sp)
    80005824:	e526                	sd	s1,136(sp)
    80005826:	e14a                	sd	s2,128(sp)
    80005828:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    8000582a:	ffffc097          	auipc	ra,0xffffc
    8000582e:	16c080e7          	jalr	364(ra) # 80001996 <myproc>
    80005832:	892a                	mv	s2,a0
  
  begin_op();
    80005834:	ffffe097          	auipc	ra,0xffffe
    80005838:	7c2080e7          	jalr	1986(ra) # 80003ff6 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    8000583c:	08000613          	li	a2,128
    80005840:	f6040593          	addi	a1,s0,-160
    80005844:	4501                	li	a0,0
    80005846:	ffffd097          	auipc	ra,0xffffd
    8000584a:	29a080e7          	jalr	666(ra) # 80002ae0 <argstr>
    8000584e:	04054b63          	bltz	a0,800058a4 <sys_chdir+0x86>
    80005852:	f6040513          	addi	a0,s0,-160
    80005856:	ffffe097          	auipc	ra,0xffffe
    8000585a:	584080e7          	jalr	1412(ra) # 80003dda <namei>
    8000585e:	84aa                	mv	s1,a0
    80005860:	c131                	beqz	a0,800058a4 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80005862:	ffffe097          	auipc	ra,0xffffe
    80005866:	dc2080e7          	jalr	-574(ra) # 80003624 <ilock>
  if(ip->type != T_DIR){
    8000586a:	04449703          	lh	a4,68(s1)
    8000586e:	4785                	li	a5,1
    80005870:	04f71063          	bne	a4,a5,800058b0 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80005874:	8526                	mv	a0,s1
    80005876:	ffffe097          	auipc	ra,0xffffe
    8000587a:	e70080e7          	jalr	-400(ra) # 800036e6 <iunlock>
  iput(p->cwd);
    8000587e:	15093503          	ld	a0,336(s2)
    80005882:	ffffe097          	auipc	ra,0xffffe
    80005886:	f5c080e7          	jalr	-164(ra) # 800037de <iput>
  end_op();
    8000588a:	ffffe097          	auipc	ra,0xffffe
    8000588e:	7ec080e7          	jalr	2028(ra) # 80004076 <end_op>
  p->cwd = ip;
    80005892:	14993823          	sd	s1,336(s2)
  return 0;
    80005896:	4501                	li	a0,0
}
    80005898:	60ea                	ld	ra,152(sp)
    8000589a:	644a                	ld	s0,144(sp)
    8000589c:	64aa                	ld	s1,136(sp)
    8000589e:	690a                	ld	s2,128(sp)
    800058a0:	610d                	addi	sp,sp,160
    800058a2:	8082                	ret
    end_op();
    800058a4:	ffffe097          	auipc	ra,0xffffe
    800058a8:	7d2080e7          	jalr	2002(ra) # 80004076 <end_op>
    return -1;
    800058ac:	557d                	li	a0,-1
    800058ae:	b7ed                	j	80005898 <sys_chdir+0x7a>
    iunlockput(ip);
    800058b0:	8526                	mv	a0,s1
    800058b2:	ffffe097          	auipc	ra,0xffffe
    800058b6:	fd4080e7          	jalr	-44(ra) # 80003886 <iunlockput>
    end_op();
    800058ba:	ffffe097          	auipc	ra,0xffffe
    800058be:	7bc080e7          	jalr	1980(ra) # 80004076 <end_op>
    return -1;
    800058c2:	557d                	li	a0,-1
    800058c4:	bfd1                	j	80005898 <sys_chdir+0x7a>

00000000800058c6 <sys_exec>:

uint64
sys_exec(void)
{
    800058c6:	7145                	addi	sp,sp,-464
    800058c8:	e786                	sd	ra,456(sp)
    800058ca:	e3a2                	sd	s0,448(sp)
    800058cc:	ff26                	sd	s1,440(sp)
    800058ce:	fb4a                	sd	s2,432(sp)
    800058d0:	f74e                	sd	s3,424(sp)
    800058d2:	f352                	sd	s4,416(sp)
    800058d4:	ef56                	sd	s5,408(sp)
    800058d6:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    800058d8:	08000613          	li	a2,128
    800058dc:	f4040593          	addi	a1,s0,-192
    800058e0:	4501                	li	a0,0
    800058e2:	ffffd097          	auipc	ra,0xffffd
    800058e6:	1fe080e7          	jalr	510(ra) # 80002ae0 <argstr>
    return -1;
    800058ea:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    800058ec:	0c054a63          	bltz	a0,800059c0 <sys_exec+0xfa>
    800058f0:	e3840593          	addi	a1,s0,-456
    800058f4:	4505                	li	a0,1
    800058f6:	ffffd097          	auipc	ra,0xffffd
    800058fa:	1c8080e7          	jalr	456(ra) # 80002abe <argaddr>
    800058fe:	0c054163          	bltz	a0,800059c0 <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    80005902:	10000613          	li	a2,256
    80005906:	4581                	li	a1,0
    80005908:	e4040513          	addi	a0,s0,-448
    8000590c:	ffffb097          	auipc	ra,0xffffb
    80005910:	3c0080e7          	jalr	960(ra) # 80000ccc <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80005914:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    80005918:	89a6                	mv	s3,s1
    8000591a:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    8000591c:	02000a13          	li	s4,32
    80005920:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005924:	00391793          	slli	a5,s2,0x3
    80005928:	e3040593          	addi	a1,s0,-464
    8000592c:	e3843503          	ld	a0,-456(s0)
    80005930:	953e                	add	a0,a0,a5
    80005932:	ffffd097          	auipc	ra,0xffffd
    80005936:	0d0080e7          	jalr	208(ra) # 80002a02 <fetchaddr>
    8000593a:	02054a63          	bltz	a0,8000596e <sys_exec+0xa8>
      goto bad;
    }
    if(uarg == 0){
    8000593e:	e3043783          	ld	a5,-464(s0)
    80005942:	c3b9                	beqz	a5,80005988 <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80005944:	ffffb097          	auipc	ra,0xffffb
    80005948:	19c080e7          	jalr	412(ra) # 80000ae0 <kalloc>
    8000594c:	85aa                	mv	a1,a0
    8000594e:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005952:	cd11                	beqz	a0,8000596e <sys_exec+0xa8>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005954:	6605                	lui	a2,0x1
    80005956:	e3043503          	ld	a0,-464(s0)
    8000595a:	ffffd097          	auipc	ra,0xffffd
    8000595e:	0fa080e7          	jalr	250(ra) # 80002a54 <fetchstr>
    80005962:	00054663          	bltz	a0,8000596e <sys_exec+0xa8>
    if(i >= NELEM(argv)){
    80005966:	0905                	addi	s2,s2,1
    80005968:	09a1                	addi	s3,s3,8
    8000596a:	fb491be3          	bne	s2,s4,80005920 <sys_exec+0x5a>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000596e:	10048913          	addi	s2,s1,256
    80005972:	6088                	ld	a0,0(s1)
    80005974:	c529                	beqz	a0,800059be <sys_exec+0xf8>
    kfree(argv[i]);
    80005976:	ffffb097          	auipc	ra,0xffffb
    8000597a:	06e080e7          	jalr	110(ra) # 800009e4 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000597e:	04a1                	addi	s1,s1,8
    80005980:	ff2499e3          	bne	s1,s2,80005972 <sys_exec+0xac>
  return -1;
    80005984:	597d                	li	s2,-1
    80005986:	a82d                	j	800059c0 <sys_exec+0xfa>
      argv[i] = 0;
    80005988:	0a8e                	slli	s5,s5,0x3
    8000598a:	fc040793          	addi	a5,s0,-64
    8000598e:	9abe                	add	s5,s5,a5
    80005990:	e80ab023          	sd	zero,-384(s5) # ffffffffffffee80 <end+0xffffffff7ffd8e80>
  int ret = exec(path, argv);
    80005994:	e4040593          	addi	a1,s0,-448
    80005998:	f4040513          	addi	a0,s0,-192
    8000599c:	fffff097          	auipc	ra,0xfffff
    800059a0:	178080e7          	jalr	376(ra) # 80004b14 <exec>
    800059a4:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800059a6:	10048993          	addi	s3,s1,256
    800059aa:	6088                	ld	a0,0(s1)
    800059ac:	c911                	beqz	a0,800059c0 <sys_exec+0xfa>
    kfree(argv[i]);
    800059ae:	ffffb097          	auipc	ra,0xffffb
    800059b2:	036080e7          	jalr	54(ra) # 800009e4 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800059b6:	04a1                	addi	s1,s1,8
    800059b8:	ff3499e3          	bne	s1,s3,800059aa <sys_exec+0xe4>
    800059bc:	a011                	j	800059c0 <sys_exec+0xfa>
  return -1;
    800059be:	597d                	li	s2,-1
}
    800059c0:	854a                	mv	a0,s2
    800059c2:	60be                	ld	ra,456(sp)
    800059c4:	641e                	ld	s0,448(sp)
    800059c6:	74fa                	ld	s1,440(sp)
    800059c8:	795a                	ld	s2,432(sp)
    800059ca:	79ba                	ld	s3,424(sp)
    800059cc:	7a1a                	ld	s4,416(sp)
    800059ce:	6afa                	ld	s5,408(sp)
    800059d0:	6179                	addi	sp,sp,464
    800059d2:	8082                	ret

00000000800059d4 <sys_pipe>:

uint64
sys_pipe(void)
{
    800059d4:	7139                	addi	sp,sp,-64
    800059d6:	fc06                	sd	ra,56(sp)
    800059d8:	f822                	sd	s0,48(sp)
    800059da:	f426                	sd	s1,40(sp)
    800059dc:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    800059de:	ffffc097          	auipc	ra,0xffffc
    800059e2:	fb8080e7          	jalr	-72(ra) # 80001996 <myproc>
    800059e6:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    800059e8:	fd840593          	addi	a1,s0,-40
    800059ec:	4501                	li	a0,0
    800059ee:	ffffd097          	auipc	ra,0xffffd
    800059f2:	0d0080e7          	jalr	208(ra) # 80002abe <argaddr>
    return -1;
    800059f6:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    800059f8:	0e054063          	bltz	a0,80005ad8 <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    800059fc:	fc840593          	addi	a1,s0,-56
    80005a00:	fd040513          	addi	a0,s0,-48
    80005a04:	fffff097          	auipc	ra,0xfffff
    80005a08:	dee080e7          	jalr	-530(ra) # 800047f2 <pipealloc>
    return -1;
    80005a0c:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005a0e:	0c054563          	bltz	a0,80005ad8 <sys_pipe+0x104>
  fd0 = -1;
    80005a12:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005a16:	fd043503          	ld	a0,-48(s0)
    80005a1a:	fffff097          	auipc	ra,0xfffff
    80005a1e:	50a080e7          	jalr	1290(ra) # 80004f24 <fdalloc>
    80005a22:	fca42223          	sw	a0,-60(s0)
    80005a26:	08054c63          	bltz	a0,80005abe <sys_pipe+0xea>
    80005a2a:	fc843503          	ld	a0,-56(s0)
    80005a2e:	fffff097          	auipc	ra,0xfffff
    80005a32:	4f6080e7          	jalr	1270(ra) # 80004f24 <fdalloc>
    80005a36:	fca42023          	sw	a0,-64(s0)
    80005a3a:	06054863          	bltz	a0,80005aaa <sys_pipe+0xd6>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005a3e:	4691                	li	a3,4
    80005a40:	fc440613          	addi	a2,s0,-60
    80005a44:	fd843583          	ld	a1,-40(s0)
    80005a48:	68a8                	ld	a0,80(s1)
    80005a4a:	ffffc097          	auipc	ra,0xffffc
    80005a4e:	c0c080e7          	jalr	-1012(ra) # 80001656 <copyout>
    80005a52:	02054063          	bltz	a0,80005a72 <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005a56:	4691                	li	a3,4
    80005a58:	fc040613          	addi	a2,s0,-64
    80005a5c:	fd843583          	ld	a1,-40(s0)
    80005a60:	0591                	addi	a1,a1,4
    80005a62:	68a8                	ld	a0,80(s1)
    80005a64:	ffffc097          	auipc	ra,0xffffc
    80005a68:	bf2080e7          	jalr	-1038(ra) # 80001656 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005a6c:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005a6e:	06055563          	bgez	a0,80005ad8 <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    80005a72:	fc442783          	lw	a5,-60(s0)
    80005a76:	07e9                	addi	a5,a5,26
    80005a78:	078e                	slli	a5,a5,0x3
    80005a7a:	97a6                	add	a5,a5,s1
    80005a7c:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80005a80:	fc042503          	lw	a0,-64(s0)
    80005a84:	0569                	addi	a0,a0,26
    80005a86:	050e                	slli	a0,a0,0x3
    80005a88:	9526                	add	a0,a0,s1
    80005a8a:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005a8e:	fd043503          	ld	a0,-48(s0)
    80005a92:	fffff097          	auipc	ra,0xfffff
    80005a96:	a30080e7          	jalr	-1488(ra) # 800044c2 <fileclose>
    fileclose(wf);
    80005a9a:	fc843503          	ld	a0,-56(s0)
    80005a9e:	fffff097          	auipc	ra,0xfffff
    80005aa2:	a24080e7          	jalr	-1500(ra) # 800044c2 <fileclose>
    return -1;
    80005aa6:	57fd                	li	a5,-1
    80005aa8:	a805                	j	80005ad8 <sys_pipe+0x104>
    if(fd0 >= 0)
    80005aaa:	fc442783          	lw	a5,-60(s0)
    80005aae:	0007c863          	bltz	a5,80005abe <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    80005ab2:	01a78513          	addi	a0,a5,26
    80005ab6:	050e                	slli	a0,a0,0x3
    80005ab8:	9526                	add	a0,a0,s1
    80005aba:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005abe:	fd043503          	ld	a0,-48(s0)
    80005ac2:	fffff097          	auipc	ra,0xfffff
    80005ac6:	a00080e7          	jalr	-1536(ra) # 800044c2 <fileclose>
    fileclose(wf);
    80005aca:	fc843503          	ld	a0,-56(s0)
    80005ace:	fffff097          	auipc	ra,0xfffff
    80005ad2:	9f4080e7          	jalr	-1548(ra) # 800044c2 <fileclose>
    return -1;
    80005ad6:	57fd                	li	a5,-1
}
    80005ad8:	853e                	mv	a0,a5
    80005ada:	70e2                	ld	ra,56(sp)
    80005adc:	7442                	ld	s0,48(sp)
    80005ade:	74a2                	ld	s1,40(sp)
    80005ae0:	6121                	addi	sp,sp,64
    80005ae2:	8082                	ret
	...

0000000080005af0 <kernelvec>:
    80005af0:	7111                	addi	sp,sp,-256
    80005af2:	e006                	sd	ra,0(sp)
    80005af4:	e40a                	sd	sp,8(sp)
    80005af6:	e80e                	sd	gp,16(sp)
    80005af8:	ec12                	sd	tp,24(sp)
    80005afa:	f016                	sd	t0,32(sp)
    80005afc:	f41a                	sd	t1,40(sp)
    80005afe:	f81e                	sd	t2,48(sp)
    80005b00:	fc22                	sd	s0,56(sp)
    80005b02:	e0a6                	sd	s1,64(sp)
    80005b04:	e4aa                	sd	a0,72(sp)
    80005b06:	e8ae                	sd	a1,80(sp)
    80005b08:	ecb2                	sd	a2,88(sp)
    80005b0a:	f0b6                	sd	a3,96(sp)
    80005b0c:	f4ba                	sd	a4,104(sp)
    80005b0e:	f8be                	sd	a5,112(sp)
    80005b10:	fcc2                	sd	a6,120(sp)
    80005b12:	e146                	sd	a7,128(sp)
    80005b14:	e54a                	sd	s2,136(sp)
    80005b16:	e94e                	sd	s3,144(sp)
    80005b18:	ed52                	sd	s4,152(sp)
    80005b1a:	f156                	sd	s5,160(sp)
    80005b1c:	f55a                	sd	s6,168(sp)
    80005b1e:	f95e                	sd	s7,176(sp)
    80005b20:	fd62                	sd	s8,184(sp)
    80005b22:	e1e6                	sd	s9,192(sp)
    80005b24:	e5ea                	sd	s10,200(sp)
    80005b26:	e9ee                	sd	s11,208(sp)
    80005b28:	edf2                	sd	t3,216(sp)
    80005b2a:	f1f6                	sd	t4,224(sp)
    80005b2c:	f5fa                	sd	t5,232(sp)
    80005b2e:	f9fe                	sd	t6,240(sp)
    80005b30:	d9ffc0ef          	jal	ra,800028ce <kerneltrap>
    80005b34:	6082                	ld	ra,0(sp)
    80005b36:	6122                	ld	sp,8(sp)
    80005b38:	61c2                	ld	gp,16(sp)
    80005b3a:	7282                	ld	t0,32(sp)
    80005b3c:	7322                	ld	t1,40(sp)
    80005b3e:	73c2                	ld	t2,48(sp)
    80005b40:	7462                	ld	s0,56(sp)
    80005b42:	6486                	ld	s1,64(sp)
    80005b44:	6526                	ld	a0,72(sp)
    80005b46:	65c6                	ld	a1,80(sp)
    80005b48:	6666                	ld	a2,88(sp)
    80005b4a:	7686                	ld	a3,96(sp)
    80005b4c:	7726                	ld	a4,104(sp)
    80005b4e:	77c6                	ld	a5,112(sp)
    80005b50:	7866                	ld	a6,120(sp)
    80005b52:	688a                	ld	a7,128(sp)
    80005b54:	692a                	ld	s2,136(sp)
    80005b56:	69ca                	ld	s3,144(sp)
    80005b58:	6a6a                	ld	s4,152(sp)
    80005b5a:	7a8a                	ld	s5,160(sp)
    80005b5c:	7b2a                	ld	s6,168(sp)
    80005b5e:	7bca                	ld	s7,176(sp)
    80005b60:	7c6a                	ld	s8,184(sp)
    80005b62:	6c8e                	ld	s9,192(sp)
    80005b64:	6d2e                	ld	s10,200(sp)
    80005b66:	6dce                	ld	s11,208(sp)
    80005b68:	6e6e                	ld	t3,216(sp)
    80005b6a:	7e8e                	ld	t4,224(sp)
    80005b6c:	7f2e                	ld	t5,232(sp)
    80005b6e:	7fce                	ld	t6,240(sp)
    80005b70:	6111                	addi	sp,sp,256
    80005b72:	10200073          	sret
    80005b76:	00000013          	nop
    80005b7a:	00000013          	nop
    80005b7e:	0001                	nop

0000000080005b80 <timervec>:
    80005b80:	34051573          	csrrw	a0,mscratch,a0
    80005b84:	e10c                	sd	a1,0(a0)
    80005b86:	e510                	sd	a2,8(a0)
    80005b88:	e914                	sd	a3,16(a0)
    80005b8a:	6d0c                	ld	a1,24(a0)
    80005b8c:	7110                	ld	a2,32(a0)
    80005b8e:	6194                	ld	a3,0(a1)
    80005b90:	96b2                	add	a3,a3,a2
    80005b92:	e194                	sd	a3,0(a1)
    80005b94:	4589                	li	a1,2
    80005b96:	14459073          	csrw	sip,a1
    80005b9a:	6914                	ld	a3,16(a0)
    80005b9c:	6510                	ld	a2,8(a0)
    80005b9e:	610c                	ld	a1,0(a0)
    80005ba0:	34051573          	csrrw	a0,mscratch,a0
    80005ba4:	30200073          	mret
	...

0000000080005baa <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80005baa:	1141                	addi	sp,sp,-16
    80005bac:	e422                	sd	s0,8(sp)
    80005bae:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005bb0:	0c0007b7          	lui	a5,0xc000
    80005bb4:	4705                	li	a4,1
    80005bb6:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005bb8:	c3d8                	sw	a4,4(a5)
}
    80005bba:	6422                	ld	s0,8(sp)
    80005bbc:	0141                	addi	sp,sp,16
    80005bbe:	8082                	ret

0000000080005bc0 <plicinithart>:

void
plicinithart(void)
{
    80005bc0:	1141                	addi	sp,sp,-16
    80005bc2:	e406                	sd	ra,8(sp)
    80005bc4:	e022                	sd	s0,0(sp)
    80005bc6:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005bc8:	ffffc097          	auipc	ra,0xffffc
    80005bcc:	da2080e7          	jalr	-606(ra) # 8000196a <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005bd0:	0085171b          	slliw	a4,a0,0x8
    80005bd4:	0c0027b7          	lui	a5,0xc002
    80005bd8:	97ba                	add	a5,a5,a4
    80005bda:	40200713          	li	a4,1026
    80005bde:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005be2:	00d5151b          	slliw	a0,a0,0xd
    80005be6:	0c2017b7          	lui	a5,0xc201
    80005bea:	953e                	add	a0,a0,a5
    80005bec:	00052023          	sw	zero,0(a0)
}
    80005bf0:	60a2                	ld	ra,8(sp)
    80005bf2:	6402                	ld	s0,0(sp)
    80005bf4:	0141                	addi	sp,sp,16
    80005bf6:	8082                	ret

0000000080005bf8 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005bf8:	1141                	addi	sp,sp,-16
    80005bfa:	e406                	sd	ra,8(sp)
    80005bfc:	e022                	sd	s0,0(sp)
    80005bfe:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005c00:	ffffc097          	auipc	ra,0xffffc
    80005c04:	d6a080e7          	jalr	-662(ra) # 8000196a <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005c08:	00d5179b          	slliw	a5,a0,0xd
    80005c0c:	0c201537          	lui	a0,0xc201
    80005c10:	953e                	add	a0,a0,a5
  return irq;
}
    80005c12:	4148                	lw	a0,4(a0)
    80005c14:	60a2                	ld	ra,8(sp)
    80005c16:	6402                	ld	s0,0(sp)
    80005c18:	0141                	addi	sp,sp,16
    80005c1a:	8082                	ret

0000000080005c1c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80005c1c:	1101                	addi	sp,sp,-32
    80005c1e:	ec06                	sd	ra,24(sp)
    80005c20:	e822                	sd	s0,16(sp)
    80005c22:	e426                	sd	s1,8(sp)
    80005c24:	1000                	addi	s0,sp,32
    80005c26:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005c28:	ffffc097          	auipc	ra,0xffffc
    80005c2c:	d42080e7          	jalr	-702(ra) # 8000196a <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005c30:	00d5151b          	slliw	a0,a0,0xd
    80005c34:	0c2017b7          	lui	a5,0xc201
    80005c38:	97aa                	add	a5,a5,a0
    80005c3a:	c3c4                	sw	s1,4(a5)
}
    80005c3c:	60e2                	ld	ra,24(sp)
    80005c3e:	6442                	ld	s0,16(sp)
    80005c40:	64a2                	ld	s1,8(sp)
    80005c42:	6105                	addi	sp,sp,32
    80005c44:	8082                	ret

0000000080005c46 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005c46:	1141                	addi	sp,sp,-16
    80005c48:	e406                	sd	ra,8(sp)
    80005c4a:	e022                	sd	s0,0(sp)
    80005c4c:	0800                	addi	s0,sp,16
  if(i >= NUM)
    80005c4e:	479d                	li	a5,7
    80005c50:	06a7c963          	blt	a5,a0,80005cc2 <free_desc+0x7c>
    panic("free_desc 1");
  if(disk.free[i])
    80005c54:	0001d797          	auipc	a5,0x1d
    80005c58:	3ac78793          	addi	a5,a5,940 # 80023000 <disk>
    80005c5c:	00a78733          	add	a4,a5,a0
    80005c60:	6789                	lui	a5,0x2
    80005c62:	97ba                	add	a5,a5,a4
    80005c64:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    80005c68:	e7ad                	bnez	a5,80005cd2 <free_desc+0x8c>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005c6a:	00451793          	slli	a5,a0,0x4
    80005c6e:	0001f717          	auipc	a4,0x1f
    80005c72:	39270713          	addi	a4,a4,914 # 80025000 <disk+0x2000>
    80005c76:	6314                	ld	a3,0(a4)
    80005c78:	96be                	add	a3,a3,a5
    80005c7a:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    80005c7e:	6314                	ld	a3,0(a4)
    80005c80:	96be                	add	a3,a3,a5
    80005c82:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    80005c86:	6314                	ld	a3,0(a4)
    80005c88:	96be                	add	a3,a3,a5
    80005c8a:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    80005c8e:	6318                	ld	a4,0(a4)
    80005c90:	97ba                	add	a5,a5,a4
    80005c92:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80005c96:	0001d797          	auipc	a5,0x1d
    80005c9a:	36a78793          	addi	a5,a5,874 # 80023000 <disk>
    80005c9e:	97aa                	add	a5,a5,a0
    80005ca0:	6509                	lui	a0,0x2
    80005ca2:	953e                	add	a0,a0,a5
    80005ca4:	4785                	li	a5,1
    80005ca6:	00f50c23          	sb	a5,24(a0) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    80005caa:	0001f517          	auipc	a0,0x1f
    80005cae:	36e50513          	addi	a0,a0,878 # 80025018 <disk+0x2018>
    80005cb2:	ffffc097          	auipc	ra,0xffffc
    80005cb6:	530080e7          	jalr	1328(ra) # 800021e2 <wakeup>
}
    80005cba:	60a2                	ld	ra,8(sp)
    80005cbc:	6402                	ld	s0,0(sp)
    80005cbe:	0141                	addi	sp,sp,16
    80005cc0:	8082                	ret
    panic("free_desc 1");
    80005cc2:	00003517          	auipc	a0,0x3
    80005cc6:	aae50513          	addi	a0,a0,-1362 # 80008770 <syscalls+0x328>
    80005cca:	ffffb097          	auipc	ra,0xffffb
    80005cce:	86e080e7          	jalr	-1938(ra) # 80000538 <panic>
    panic("free_desc 2");
    80005cd2:	00003517          	auipc	a0,0x3
    80005cd6:	aae50513          	addi	a0,a0,-1362 # 80008780 <syscalls+0x338>
    80005cda:	ffffb097          	auipc	ra,0xffffb
    80005cde:	85e080e7          	jalr	-1954(ra) # 80000538 <panic>

0000000080005ce2 <virtio_disk_init>:
{
    80005ce2:	1101                	addi	sp,sp,-32
    80005ce4:	ec06                	sd	ra,24(sp)
    80005ce6:	e822                	sd	s0,16(sp)
    80005ce8:	e426                	sd	s1,8(sp)
    80005cea:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005cec:	00003597          	auipc	a1,0x3
    80005cf0:	aa458593          	addi	a1,a1,-1372 # 80008790 <syscalls+0x348>
    80005cf4:	0001f517          	auipc	a0,0x1f
    80005cf8:	43450513          	addi	a0,a0,1076 # 80025128 <disk+0x2128>
    80005cfc:	ffffb097          	auipc	ra,0xffffb
    80005d00:	e44080e7          	jalr	-444(ra) # 80000b40 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005d04:	100017b7          	lui	a5,0x10001
    80005d08:	4398                	lw	a4,0(a5)
    80005d0a:	2701                	sext.w	a4,a4
    80005d0c:	747277b7          	lui	a5,0x74727
    80005d10:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005d14:	0ef71163          	bne	a4,a5,80005df6 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005d18:	100017b7          	lui	a5,0x10001
    80005d1c:	43dc                	lw	a5,4(a5)
    80005d1e:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005d20:	4705                	li	a4,1
    80005d22:	0ce79a63          	bne	a5,a4,80005df6 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005d26:	100017b7          	lui	a5,0x10001
    80005d2a:	479c                	lw	a5,8(a5)
    80005d2c:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005d2e:	4709                	li	a4,2
    80005d30:	0ce79363          	bne	a5,a4,80005df6 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005d34:	100017b7          	lui	a5,0x10001
    80005d38:	47d8                	lw	a4,12(a5)
    80005d3a:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005d3c:	554d47b7          	lui	a5,0x554d4
    80005d40:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005d44:	0af71963          	bne	a4,a5,80005df6 <virtio_disk_init+0x114>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005d48:	100017b7          	lui	a5,0x10001
    80005d4c:	4705                	li	a4,1
    80005d4e:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005d50:	470d                	li	a4,3
    80005d52:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005d54:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80005d56:	c7ffe737          	lui	a4,0xc7ffe
    80005d5a:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fd875f>
    80005d5e:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005d60:	2701                	sext.w	a4,a4
    80005d62:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005d64:	472d                	li	a4,11
    80005d66:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005d68:	473d                	li	a4,15
    80005d6a:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    80005d6c:	6705                	lui	a4,0x1
    80005d6e:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005d70:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005d74:	5bdc                	lw	a5,52(a5)
    80005d76:	2781                	sext.w	a5,a5
  if(max == 0)
    80005d78:	c7d9                	beqz	a5,80005e06 <virtio_disk_init+0x124>
  if(max < NUM)
    80005d7a:	471d                	li	a4,7
    80005d7c:	08f77d63          	bgeu	a4,a5,80005e16 <virtio_disk_init+0x134>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005d80:	100014b7          	lui	s1,0x10001
    80005d84:	47a1                	li	a5,8
    80005d86:	dc9c                	sw	a5,56(s1)
  memset(disk.pages, 0, sizeof(disk.pages));
    80005d88:	6609                	lui	a2,0x2
    80005d8a:	4581                	li	a1,0
    80005d8c:	0001d517          	auipc	a0,0x1d
    80005d90:	27450513          	addi	a0,a0,628 # 80023000 <disk>
    80005d94:	ffffb097          	auipc	ra,0xffffb
    80005d98:	f38080e7          	jalr	-200(ra) # 80000ccc <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    80005d9c:	0001d717          	auipc	a4,0x1d
    80005da0:	26470713          	addi	a4,a4,612 # 80023000 <disk>
    80005da4:	00c75793          	srli	a5,a4,0xc
    80005da8:	2781                	sext.w	a5,a5
    80005daa:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct virtq_desc *) disk.pages;
    80005dac:	0001f797          	auipc	a5,0x1f
    80005db0:	25478793          	addi	a5,a5,596 # 80025000 <disk+0x2000>
    80005db4:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    80005db6:	0001d717          	auipc	a4,0x1d
    80005dba:	2ca70713          	addi	a4,a4,714 # 80023080 <disk+0x80>
    80005dbe:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    80005dc0:	0001e717          	auipc	a4,0x1e
    80005dc4:	24070713          	addi	a4,a4,576 # 80024000 <disk+0x1000>
    80005dc8:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    80005dca:	4705                	li	a4,1
    80005dcc:	00e78c23          	sb	a4,24(a5)
    80005dd0:	00e78ca3          	sb	a4,25(a5)
    80005dd4:	00e78d23          	sb	a4,26(a5)
    80005dd8:	00e78da3          	sb	a4,27(a5)
    80005ddc:	00e78e23          	sb	a4,28(a5)
    80005de0:	00e78ea3          	sb	a4,29(a5)
    80005de4:	00e78f23          	sb	a4,30(a5)
    80005de8:	00e78fa3          	sb	a4,31(a5)
}
    80005dec:	60e2                	ld	ra,24(sp)
    80005dee:	6442                	ld	s0,16(sp)
    80005df0:	64a2                	ld	s1,8(sp)
    80005df2:	6105                	addi	sp,sp,32
    80005df4:	8082                	ret
    panic("could not find virtio disk");
    80005df6:	00003517          	auipc	a0,0x3
    80005dfa:	9aa50513          	addi	a0,a0,-1622 # 800087a0 <syscalls+0x358>
    80005dfe:	ffffa097          	auipc	ra,0xffffa
    80005e02:	73a080e7          	jalr	1850(ra) # 80000538 <panic>
    panic("virtio disk has no queue 0");
    80005e06:	00003517          	auipc	a0,0x3
    80005e0a:	9ba50513          	addi	a0,a0,-1606 # 800087c0 <syscalls+0x378>
    80005e0e:	ffffa097          	auipc	ra,0xffffa
    80005e12:	72a080e7          	jalr	1834(ra) # 80000538 <panic>
    panic("virtio disk max queue too short");
    80005e16:	00003517          	auipc	a0,0x3
    80005e1a:	9ca50513          	addi	a0,a0,-1590 # 800087e0 <syscalls+0x398>
    80005e1e:	ffffa097          	auipc	ra,0xffffa
    80005e22:	71a080e7          	jalr	1818(ra) # 80000538 <panic>

0000000080005e26 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80005e26:	7119                	addi	sp,sp,-128
    80005e28:	fc86                	sd	ra,120(sp)
    80005e2a:	f8a2                	sd	s0,112(sp)
    80005e2c:	f4a6                	sd	s1,104(sp)
    80005e2e:	f0ca                	sd	s2,96(sp)
    80005e30:	ecce                	sd	s3,88(sp)
    80005e32:	e8d2                	sd	s4,80(sp)
    80005e34:	e4d6                	sd	s5,72(sp)
    80005e36:	e0da                	sd	s6,64(sp)
    80005e38:	fc5e                	sd	s7,56(sp)
    80005e3a:	f862                	sd	s8,48(sp)
    80005e3c:	f466                	sd	s9,40(sp)
    80005e3e:	f06a                	sd	s10,32(sp)
    80005e40:	ec6e                	sd	s11,24(sp)
    80005e42:	0100                	addi	s0,sp,128
    80005e44:	8aaa                	mv	s5,a0
    80005e46:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005e48:	00c52c83          	lw	s9,12(a0)
    80005e4c:	001c9c9b          	slliw	s9,s9,0x1
    80005e50:	1c82                	slli	s9,s9,0x20
    80005e52:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80005e56:	0001f517          	auipc	a0,0x1f
    80005e5a:	2d250513          	addi	a0,a0,722 # 80025128 <disk+0x2128>
    80005e5e:	ffffb097          	auipc	ra,0xffffb
    80005e62:	d72080e7          	jalr	-654(ra) # 80000bd0 <acquire>
  for(int i = 0; i < 3; i++){
    80005e66:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80005e68:	44a1                	li	s1,8
      disk.free[i] = 0;
    80005e6a:	0001dc17          	auipc	s8,0x1d
    80005e6e:	196c0c13          	addi	s8,s8,406 # 80023000 <disk>
    80005e72:	6b89                	lui	s7,0x2
  for(int i = 0; i < 3; i++){
    80005e74:	4b0d                	li	s6,3
    80005e76:	a0ad                	j	80005ee0 <virtio_disk_rw+0xba>
      disk.free[i] = 0;
    80005e78:	00fc0733          	add	a4,s8,a5
    80005e7c:	975e                	add	a4,a4,s7
    80005e7e:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80005e82:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80005e84:	0207c563          	bltz	a5,80005eae <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    80005e88:	2905                	addiw	s2,s2,1
    80005e8a:	0611                	addi	a2,a2,4
    80005e8c:	19690d63          	beq	s2,s6,80006026 <virtio_disk_rw+0x200>
    idx[i] = alloc_desc();
    80005e90:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80005e92:	0001f717          	auipc	a4,0x1f
    80005e96:	18670713          	addi	a4,a4,390 # 80025018 <disk+0x2018>
    80005e9a:	87ce                	mv	a5,s3
    if(disk.free[i]){
    80005e9c:	00074683          	lbu	a3,0(a4)
    80005ea0:	fee1                	bnez	a3,80005e78 <virtio_disk_rw+0x52>
  for(int i = 0; i < NUM; i++){
    80005ea2:	2785                	addiw	a5,a5,1
    80005ea4:	0705                	addi	a4,a4,1
    80005ea6:	fe979be3          	bne	a5,s1,80005e9c <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    80005eaa:	57fd                	li	a5,-1
    80005eac:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    80005eae:	01205d63          	blez	s2,80005ec8 <virtio_disk_rw+0xa2>
    80005eb2:	8dce                	mv	s11,s3
        free_desc(idx[j]);
    80005eb4:	000a2503          	lw	a0,0(s4)
    80005eb8:	00000097          	auipc	ra,0x0
    80005ebc:	d8e080e7          	jalr	-626(ra) # 80005c46 <free_desc>
      for(int j = 0; j < i; j++)
    80005ec0:	2d85                	addiw	s11,s11,1
    80005ec2:	0a11                	addi	s4,s4,4
    80005ec4:	ffb918e3          	bne	s2,s11,80005eb4 <virtio_disk_rw+0x8e>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005ec8:	0001f597          	auipc	a1,0x1f
    80005ecc:	26058593          	addi	a1,a1,608 # 80025128 <disk+0x2128>
    80005ed0:	0001f517          	auipc	a0,0x1f
    80005ed4:	14850513          	addi	a0,a0,328 # 80025018 <disk+0x2018>
    80005ed8:	ffffc097          	auipc	ra,0xffffc
    80005edc:	17e080e7          	jalr	382(ra) # 80002056 <sleep>
  for(int i = 0; i < 3; i++){
    80005ee0:	f8040a13          	addi	s4,s0,-128
{
    80005ee4:	8652                	mv	a2,s4
  for(int i = 0; i < 3; i++){
    80005ee6:	894e                	mv	s2,s3
    80005ee8:	b765                	j	80005e90 <virtio_disk_rw+0x6a>
  disk.desc[idx[0]].next = idx[1];

  disk.desc[idx[1]].addr = (uint64) b->data;
  disk.desc[idx[1]].len = BSIZE;
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80005eea:	0001f697          	auipc	a3,0x1f
    80005eee:	1166b683          	ld	a3,278(a3) # 80025000 <disk+0x2000>
    80005ef2:	96ba                	add	a3,a3,a4
    80005ef4:	00069623          	sh	zero,12(a3)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80005ef8:	0001d817          	auipc	a6,0x1d
    80005efc:	10880813          	addi	a6,a6,264 # 80023000 <disk>
    80005f00:	0001f697          	auipc	a3,0x1f
    80005f04:	10068693          	addi	a3,a3,256 # 80025000 <disk+0x2000>
    80005f08:	6290                	ld	a2,0(a3)
    80005f0a:	963a                	add	a2,a2,a4
    80005f0c:	00c65583          	lhu	a1,12(a2) # 200c <_entry-0x7fffdff4>
    80005f10:	0015e593          	ori	a1,a1,1
    80005f14:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[1]].next = idx[2];
    80005f18:	f8842603          	lw	a2,-120(s0)
    80005f1c:	628c                	ld	a1,0(a3)
    80005f1e:	972e                	add	a4,a4,a1
    80005f20:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005f24:	20050593          	addi	a1,a0,512
    80005f28:	0592                	slli	a1,a1,0x4
    80005f2a:	95c2                	add	a1,a1,a6
    80005f2c:	577d                	li	a4,-1
    80005f2e:	02e58823          	sb	a4,48(a1)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80005f32:	00461713          	slli	a4,a2,0x4
    80005f36:	6290                	ld	a2,0(a3)
    80005f38:	963a                	add	a2,a2,a4
    80005f3a:	03078793          	addi	a5,a5,48
    80005f3e:	97c2                	add	a5,a5,a6
    80005f40:	e21c                	sd	a5,0(a2)
  disk.desc[idx[2]].len = 1;
    80005f42:	629c                	ld	a5,0(a3)
    80005f44:	97ba                	add	a5,a5,a4
    80005f46:	4605                	li	a2,1
    80005f48:	c790                	sw	a2,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005f4a:	629c                	ld	a5,0(a3)
    80005f4c:	97ba                	add	a5,a5,a4
    80005f4e:	4809                	li	a6,2
    80005f50:	01079623          	sh	a6,12(a5)
  disk.desc[idx[2]].next = 0;
    80005f54:	629c                	ld	a5,0(a3)
    80005f56:	973e                	add	a4,a4,a5
    80005f58:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80005f5c:	00caa223          	sw	a2,4(s5)
  disk.info[idx[0]].b = b;
    80005f60:	0355b423          	sd	s5,40(a1)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80005f64:	6698                	ld	a4,8(a3)
    80005f66:	00275783          	lhu	a5,2(a4)
    80005f6a:	8b9d                	andi	a5,a5,7
    80005f6c:	0786                	slli	a5,a5,0x1
    80005f6e:	97ba                	add	a5,a5,a4
    80005f70:	00a79223          	sh	a0,4(a5)

  __sync_synchronize();
    80005f74:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80005f78:	6698                	ld	a4,8(a3)
    80005f7a:	00275783          	lhu	a5,2(a4)
    80005f7e:	2785                	addiw	a5,a5,1
    80005f80:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80005f84:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005f88:	100017b7          	lui	a5,0x10001
    80005f8c:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80005f90:	004aa783          	lw	a5,4(s5)
    80005f94:	02c79163          	bne	a5,a2,80005fb6 <virtio_disk_rw+0x190>
    sleep(b, &disk.vdisk_lock);
    80005f98:	0001f917          	auipc	s2,0x1f
    80005f9c:	19090913          	addi	s2,s2,400 # 80025128 <disk+0x2128>
  while(b->disk == 1) {
    80005fa0:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    80005fa2:	85ca                	mv	a1,s2
    80005fa4:	8556                	mv	a0,s5
    80005fa6:	ffffc097          	auipc	ra,0xffffc
    80005faa:	0b0080e7          	jalr	176(ra) # 80002056 <sleep>
  while(b->disk == 1) {
    80005fae:	004aa783          	lw	a5,4(s5)
    80005fb2:	fe9788e3          	beq	a5,s1,80005fa2 <virtio_disk_rw+0x17c>
  }

  disk.info[idx[0]].b = 0;
    80005fb6:	f8042903          	lw	s2,-128(s0)
    80005fba:	20090793          	addi	a5,s2,512
    80005fbe:	00479713          	slli	a4,a5,0x4
    80005fc2:	0001d797          	auipc	a5,0x1d
    80005fc6:	03e78793          	addi	a5,a5,62 # 80023000 <disk>
    80005fca:	97ba                	add	a5,a5,a4
    80005fcc:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    80005fd0:	0001f997          	auipc	s3,0x1f
    80005fd4:	03098993          	addi	s3,s3,48 # 80025000 <disk+0x2000>
    80005fd8:	00491713          	slli	a4,s2,0x4
    80005fdc:	0009b783          	ld	a5,0(s3)
    80005fe0:	97ba                	add	a5,a5,a4
    80005fe2:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005fe6:	854a                	mv	a0,s2
    80005fe8:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005fec:	00000097          	auipc	ra,0x0
    80005ff0:	c5a080e7          	jalr	-934(ra) # 80005c46 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80005ff4:	8885                	andi	s1,s1,1
    80005ff6:	f0ed                	bnez	s1,80005fd8 <virtio_disk_rw+0x1b2>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005ff8:	0001f517          	auipc	a0,0x1f
    80005ffc:	13050513          	addi	a0,a0,304 # 80025128 <disk+0x2128>
    80006000:	ffffb097          	auipc	ra,0xffffb
    80006004:	c84080e7          	jalr	-892(ra) # 80000c84 <release>
}
    80006008:	70e6                	ld	ra,120(sp)
    8000600a:	7446                	ld	s0,112(sp)
    8000600c:	74a6                	ld	s1,104(sp)
    8000600e:	7906                	ld	s2,96(sp)
    80006010:	69e6                	ld	s3,88(sp)
    80006012:	6a46                	ld	s4,80(sp)
    80006014:	6aa6                	ld	s5,72(sp)
    80006016:	6b06                	ld	s6,64(sp)
    80006018:	7be2                	ld	s7,56(sp)
    8000601a:	7c42                	ld	s8,48(sp)
    8000601c:	7ca2                	ld	s9,40(sp)
    8000601e:	7d02                	ld	s10,32(sp)
    80006020:	6de2                	ld	s11,24(sp)
    80006022:	6109                	addi	sp,sp,128
    80006024:	8082                	ret
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80006026:	f8042503          	lw	a0,-128(s0)
    8000602a:	20050793          	addi	a5,a0,512
    8000602e:	0792                	slli	a5,a5,0x4
  if(write)
    80006030:	0001d817          	auipc	a6,0x1d
    80006034:	fd080813          	addi	a6,a6,-48 # 80023000 <disk>
    80006038:	00f80733          	add	a4,a6,a5
    8000603c:	01a036b3          	snez	a3,s10
    80006040:	0ad72423          	sw	a3,168(a4)
  buf0->reserved = 0;
    80006044:	0a072623          	sw	zero,172(a4)
  buf0->sector = sector;
    80006048:	0b973823          	sd	s9,176(a4)
  disk.desc[idx[0]].addr = (uint64) buf0;
    8000604c:	7679                	lui	a2,0xffffe
    8000604e:	963e                	add	a2,a2,a5
    80006050:	0001f697          	auipc	a3,0x1f
    80006054:	fb068693          	addi	a3,a3,-80 # 80025000 <disk+0x2000>
    80006058:	6298                	ld	a4,0(a3)
    8000605a:	9732                	add	a4,a4,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    8000605c:	0a878593          	addi	a1,a5,168
    80006060:	95c2                	add	a1,a1,a6
  disk.desc[idx[0]].addr = (uint64) buf0;
    80006062:	e30c                	sd	a1,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80006064:	6298                	ld	a4,0(a3)
    80006066:	9732                	add	a4,a4,a2
    80006068:	45c1                	li	a1,16
    8000606a:	c70c                	sw	a1,8(a4)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    8000606c:	6298                	ld	a4,0(a3)
    8000606e:	9732                	add	a4,a4,a2
    80006070:	4585                	li	a1,1
    80006072:	00b71623          	sh	a1,12(a4)
  disk.desc[idx[0]].next = idx[1];
    80006076:	f8442703          	lw	a4,-124(s0)
    8000607a:	628c                	ld	a1,0(a3)
    8000607c:	962e                	add	a2,a2,a1
    8000607e:	00e61723          	sh	a4,14(a2) # ffffffffffffe00e <end+0xffffffff7ffd800e>
  disk.desc[idx[1]].addr = (uint64) b->data;
    80006082:	0712                	slli	a4,a4,0x4
    80006084:	6290                	ld	a2,0(a3)
    80006086:	963a                	add	a2,a2,a4
    80006088:	058a8593          	addi	a1,s5,88
    8000608c:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    8000608e:	6294                	ld	a3,0(a3)
    80006090:	96ba                	add	a3,a3,a4
    80006092:	40000613          	li	a2,1024
    80006096:	c690                	sw	a2,8(a3)
  if(write)
    80006098:	e40d19e3          	bnez	s10,80005eea <virtio_disk_rw+0xc4>
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    8000609c:	0001f697          	auipc	a3,0x1f
    800060a0:	f646b683          	ld	a3,-156(a3) # 80025000 <disk+0x2000>
    800060a4:	96ba                	add	a3,a3,a4
    800060a6:	4609                	li	a2,2
    800060a8:	00c69623          	sh	a2,12(a3)
    800060ac:	b5b1                	j	80005ef8 <virtio_disk_rw+0xd2>

00000000800060ae <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800060ae:	1101                	addi	sp,sp,-32
    800060b0:	ec06                	sd	ra,24(sp)
    800060b2:	e822                	sd	s0,16(sp)
    800060b4:	e426                	sd	s1,8(sp)
    800060b6:	e04a                	sd	s2,0(sp)
    800060b8:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    800060ba:	0001f517          	auipc	a0,0x1f
    800060be:	06e50513          	addi	a0,a0,110 # 80025128 <disk+0x2128>
    800060c2:	ffffb097          	auipc	ra,0xffffb
    800060c6:	b0e080e7          	jalr	-1266(ra) # 80000bd0 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800060ca:	10001737          	lui	a4,0x10001
    800060ce:	533c                	lw	a5,96(a4)
    800060d0:	8b8d                	andi	a5,a5,3
    800060d2:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    800060d4:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    800060d8:	0001f797          	auipc	a5,0x1f
    800060dc:	f2878793          	addi	a5,a5,-216 # 80025000 <disk+0x2000>
    800060e0:	6b94                	ld	a3,16(a5)
    800060e2:	0207d703          	lhu	a4,32(a5)
    800060e6:	0026d783          	lhu	a5,2(a3)
    800060ea:	06f70163          	beq	a4,a5,8000614c <virtio_disk_intr+0x9e>
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800060ee:	0001d917          	auipc	s2,0x1d
    800060f2:	f1290913          	addi	s2,s2,-238 # 80023000 <disk>
    800060f6:	0001f497          	auipc	s1,0x1f
    800060fa:	f0a48493          	addi	s1,s1,-246 # 80025000 <disk+0x2000>
    __sync_synchronize();
    800060fe:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80006102:	6898                	ld	a4,16(s1)
    80006104:	0204d783          	lhu	a5,32(s1)
    80006108:	8b9d                	andi	a5,a5,7
    8000610a:	078e                	slli	a5,a5,0x3
    8000610c:	97ba                	add	a5,a5,a4
    8000610e:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80006110:	20078713          	addi	a4,a5,512
    80006114:	0712                	slli	a4,a4,0x4
    80006116:	974a                	add	a4,a4,s2
    80006118:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    8000611c:	e731                	bnez	a4,80006168 <virtio_disk_intr+0xba>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    8000611e:	20078793          	addi	a5,a5,512
    80006122:	0792                	slli	a5,a5,0x4
    80006124:	97ca                	add	a5,a5,s2
    80006126:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80006128:	00052223          	sw	zero,4(a0)
    wakeup(b);
    8000612c:	ffffc097          	auipc	ra,0xffffc
    80006130:	0b6080e7          	jalr	182(ra) # 800021e2 <wakeup>

    disk.used_idx += 1;
    80006134:	0204d783          	lhu	a5,32(s1)
    80006138:	2785                	addiw	a5,a5,1
    8000613a:	17c2                	slli	a5,a5,0x30
    8000613c:	93c1                	srli	a5,a5,0x30
    8000613e:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80006142:	6898                	ld	a4,16(s1)
    80006144:	00275703          	lhu	a4,2(a4)
    80006148:	faf71be3          	bne	a4,a5,800060fe <virtio_disk_intr+0x50>
  }

  release(&disk.vdisk_lock);
    8000614c:	0001f517          	auipc	a0,0x1f
    80006150:	fdc50513          	addi	a0,a0,-36 # 80025128 <disk+0x2128>
    80006154:	ffffb097          	auipc	ra,0xffffb
    80006158:	b30080e7          	jalr	-1232(ra) # 80000c84 <release>
}
    8000615c:	60e2                	ld	ra,24(sp)
    8000615e:	6442                	ld	s0,16(sp)
    80006160:	64a2                	ld	s1,8(sp)
    80006162:	6902                	ld	s2,0(sp)
    80006164:	6105                	addi	sp,sp,32
    80006166:	8082                	ret
      panic("virtio_disk_intr status");
    80006168:	00002517          	auipc	a0,0x2
    8000616c:	69850513          	addi	a0,a0,1688 # 80008800 <syscalls+0x3b8>
    80006170:	ffffa097          	auipc	ra,0xffffa
    80006174:	3c8080e7          	jalr	968(ra) # 80000538 <panic>
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
