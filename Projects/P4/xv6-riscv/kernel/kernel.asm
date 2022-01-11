
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	03010113          	addi	sp,sp,48 # 8000c030 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	1a4000ef          	jal	ra,800001ba <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <r_mhartid>:
// which hart (core) is this?
static inline uint64
r_mhartid()
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec22                	sd	s0,24(sp)
    80000020:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000022:	f14027f3          	csrr	a5,mhartid
    80000026:	fef43423          	sd	a5,-24(s0)
  return x;
    8000002a:	fe843783          	ld	a5,-24(s0)
}
    8000002e:	853e                	mv	a0,a5
    80000030:	6462                	ld	s0,24(sp)
    80000032:	6105                	addi	sp,sp,32
    80000034:	8082                	ret

0000000080000036 <r_mstatus>:
#define MSTATUS_MPP_U (0L << 11)
#define MSTATUS_MIE (1L << 3)    // machine-mode interrupt enable.

static inline uint64
r_mstatus()
{
    80000036:	1101                	addi	sp,sp,-32
    80000038:	ec22                	sd	s0,24(sp)
    8000003a:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000003c:	300027f3          	csrr	a5,mstatus
    80000040:	fef43423          	sd	a5,-24(s0)
  return x;
    80000044:	fe843783          	ld	a5,-24(s0)
}
    80000048:	853e                	mv	a0,a5
    8000004a:	6462                	ld	s0,24(sp)
    8000004c:	6105                	addi	sp,sp,32
    8000004e:	8082                	ret

0000000080000050 <w_mstatus>:

static inline void 
w_mstatus(uint64 x)
{
    80000050:	1101                	addi	sp,sp,-32
    80000052:	ec22                	sd	s0,24(sp)
    80000054:	1000                	addi	s0,sp,32
    80000056:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mstatus, %0" : : "r" (x));
    8000005a:	fe843783          	ld	a5,-24(s0)
    8000005e:	30079073          	csrw	mstatus,a5
}
    80000062:	0001                	nop
    80000064:	6462                	ld	s0,24(sp)
    80000066:	6105                	addi	sp,sp,32
    80000068:	8082                	ret

000000008000006a <w_mepc>:
// machine exception program counter, holds the
// instruction address to which a return from
// exception will go.
static inline void 
w_mepc(uint64 x)
{
    8000006a:	1101                	addi	sp,sp,-32
    8000006c:	ec22                	sd	s0,24(sp)
    8000006e:	1000                	addi	s0,sp,32
    80000070:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mepc, %0" : : "r" (x));
    80000074:	fe843783          	ld	a5,-24(s0)
    80000078:	34179073          	csrw	mepc,a5
}
    8000007c:	0001                	nop
    8000007e:	6462                	ld	s0,24(sp)
    80000080:	6105                	addi	sp,sp,32
    80000082:	8082                	ret

0000000080000084 <r_sie>:
#define SIE_SEIE (1L << 9) // external
#define SIE_STIE (1L << 5) // timer
#define SIE_SSIE (1L << 1) // software
static inline uint64
r_sie()
{
    80000084:	1101                	addi	sp,sp,-32
    80000086:	ec22                	sd	s0,24(sp)
    80000088:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, sie" : "=r" (x) );
    8000008a:	104027f3          	csrr	a5,sie
    8000008e:	fef43423          	sd	a5,-24(s0)
  return x;
    80000092:	fe843783          	ld	a5,-24(s0)
}
    80000096:	853e                	mv	a0,a5
    80000098:	6462                	ld	s0,24(sp)
    8000009a:	6105                	addi	sp,sp,32
    8000009c:	8082                	ret

000000008000009e <w_sie>:

static inline void 
w_sie(uint64 x)
{
    8000009e:	1101                	addi	sp,sp,-32
    800000a0:	ec22                	sd	s0,24(sp)
    800000a2:	1000                	addi	s0,sp,32
    800000a4:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sie, %0" : : "r" (x));
    800000a8:	fe843783          	ld	a5,-24(s0)
    800000ac:	10479073          	csrw	sie,a5
}
    800000b0:	0001                	nop
    800000b2:	6462                	ld	s0,24(sp)
    800000b4:	6105                	addi	sp,sp,32
    800000b6:	8082                	ret

00000000800000b8 <r_mie>:
#define MIE_MEIE (1L << 11) // external
#define MIE_MTIE (1L << 7)  // timer
#define MIE_MSIE (1L << 3)  // software
static inline uint64
r_mie()
{
    800000b8:	1101                	addi	sp,sp,-32
    800000ba:	ec22                	sd	s0,24(sp)
    800000bc:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mie" : "=r" (x) );
    800000be:	304027f3          	csrr	a5,mie
    800000c2:	fef43423          	sd	a5,-24(s0)
  return x;
    800000c6:	fe843783          	ld	a5,-24(s0)
}
    800000ca:	853e                	mv	a0,a5
    800000cc:	6462                	ld	s0,24(sp)
    800000ce:	6105                	addi	sp,sp,32
    800000d0:	8082                	ret

00000000800000d2 <w_mie>:

static inline void 
w_mie(uint64 x)
{
    800000d2:	1101                	addi	sp,sp,-32
    800000d4:	ec22                	sd	s0,24(sp)
    800000d6:	1000                	addi	s0,sp,32
    800000d8:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mie, %0" : : "r" (x));
    800000dc:	fe843783          	ld	a5,-24(s0)
    800000e0:	30479073          	csrw	mie,a5
}
    800000e4:	0001                	nop
    800000e6:	6462                	ld	s0,24(sp)
    800000e8:	6105                	addi	sp,sp,32
    800000ea:	8082                	ret

00000000800000ec <w_medeleg>:
  return x;
}

static inline void 
w_medeleg(uint64 x)
{
    800000ec:	1101                	addi	sp,sp,-32
    800000ee:	ec22                	sd	s0,24(sp)
    800000f0:	1000                	addi	s0,sp,32
    800000f2:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000f6:	fe843783          	ld	a5,-24(s0)
    800000fa:	30279073          	csrw	medeleg,a5
}
    800000fe:	0001                	nop
    80000100:	6462                	ld	s0,24(sp)
    80000102:	6105                	addi	sp,sp,32
    80000104:	8082                	ret

0000000080000106 <w_mideleg>:
  return x;
}

static inline void 
w_mideleg(uint64 x)
{
    80000106:	1101                	addi	sp,sp,-32
    80000108:	ec22                	sd	s0,24(sp)
    8000010a:	1000                	addi	s0,sp,32
    8000010c:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80000110:	fe843783          	ld	a5,-24(s0)
    80000114:	30379073          	csrw	mideleg,a5
}
    80000118:	0001                	nop
    8000011a:	6462                	ld	s0,24(sp)
    8000011c:	6105                	addi	sp,sp,32
    8000011e:	8082                	ret

0000000080000120 <w_mtvec>:
}

// Machine-mode interrupt vector
static inline void 
w_mtvec(uint64 x)
{
    80000120:	1101                	addi	sp,sp,-32
    80000122:	ec22                	sd	s0,24(sp)
    80000124:	1000                	addi	s0,sp,32
    80000126:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mtvec, %0" : : "r" (x));
    8000012a:	fe843783          	ld	a5,-24(s0)
    8000012e:	30579073          	csrw	mtvec,a5
}
    80000132:	0001                	nop
    80000134:	6462                	ld	s0,24(sp)
    80000136:	6105                	addi	sp,sp,32
    80000138:	8082                	ret

000000008000013a <w_pmpcfg0>:

static inline void
w_pmpcfg0(uint64 x)
{
    8000013a:	1101                	addi	sp,sp,-32
    8000013c:	ec22                	sd	s0,24(sp)
    8000013e:	1000                	addi	s0,sp,32
    80000140:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80000144:	fe843783          	ld	a5,-24(s0)
    80000148:	3a079073          	csrw	pmpcfg0,a5
}
    8000014c:	0001                	nop
    8000014e:	6462                	ld	s0,24(sp)
    80000150:	6105                	addi	sp,sp,32
    80000152:	8082                	ret

0000000080000154 <w_pmpaddr0>:

static inline void
w_pmpaddr0(uint64 x)
{
    80000154:	1101                	addi	sp,sp,-32
    80000156:	ec22                	sd	s0,24(sp)
    80000158:	1000                	addi	s0,sp,32
    8000015a:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    8000015e:	fe843783          	ld	a5,-24(s0)
    80000162:	3b079073          	csrw	pmpaddr0,a5
}
    80000166:	0001                	nop
    80000168:	6462                	ld	s0,24(sp)
    8000016a:	6105                	addi	sp,sp,32
    8000016c:	8082                	ret

000000008000016e <w_satp>:

// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
    8000016e:	1101                	addi	sp,sp,-32
    80000170:	ec22                	sd	s0,24(sp)
    80000172:	1000                	addi	s0,sp,32
    80000174:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    80000178:	fe843783          	ld	a5,-24(s0)
    8000017c:	18079073          	csrw	satp,a5
}
    80000180:	0001                	nop
    80000182:	6462                	ld	s0,24(sp)
    80000184:	6105                	addi	sp,sp,32
    80000186:	8082                	ret

0000000080000188 <w_mscratch>:
  asm volatile("csrw sscratch, %0" : : "r" (x));
}

static inline void 
w_mscratch(uint64 x)
{
    80000188:	1101                	addi	sp,sp,-32
    8000018a:	ec22                	sd	s0,24(sp)
    8000018c:	1000                	addi	s0,sp,32
    8000018e:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80000192:	fe843783          	ld	a5,-24(s0)
    80000196:	34079073          	csrw	mscratch,a5
}
    8000019a:	0001                	nop
    8000019c:	6462                	ld	s0,24(sp)
    8000019e:	6105                	addi	sp,sp,32
    800001a0:	8082                	ret

00000000800001a2 <w_tp>:
  return x;
}

static inline void 
w_tp(uint64 x)
{
    800001a2:	1101                	addi	sp,sp,-32
    800001a4:	ec22                	sd	s0,24(sp)
    800001a6:	1000                	addi	s0,sp,32
    800001a8:	fea43423          	sd	a0,-24(s0)
  asm volatile("mv tp, %0" : : "r" (x));
    800001ac:	fe843783          	ld	a5,-24(s0)
    800001b0:	823e                	mv	tp,a5
}
    800001b2:	0001                	nop
    800001b4:	6462                	ld	s0,24(sp)
    800001b6:	6105                	addi	sp,sp,32
    800001b8:	8082                	ret

00000000800001ba <start>:
extern void timervec();

// entry.S jumps here in machine mode on stack0.
void
start()
{
    800001ba:	1101                	addi	sp,sp,-32
    800001bc:	ec06                	sd	ra,24(sp)
    800001be:	e822                	sd	s0,16(sp)
    800001c0:	1000                	addi	s0,sp,32
  // set M Previous Privilege mode to Supervisor, for mret.
  unsigned long x = r_mstatus();
    800001c2:	00000097          	auipc	ra,0x0
    800001c6:	e74080e7          	jalr	-396(ra) # 80000036 <r_mstatus>
    800001ca:	fea43423          	sd	a0,-24(s0)
  x &= ~MSTATUS_MPP_MASK;
    800001ce:	fe843703          	ld	a4,-24(s0)
    800001d2:	77f9                	lui	a5,0xffffe
    800001d4:	7ff78793          	addi	a5,a5,2047 # ffffffffffffe7ff <end+0xffffffff7fb557ff>
    800001d8:	8ff9                	and	a5,a5,a4
    800001da:	fef43423          	sd	a5,-24(s0)
  x |= MSTATUS_MPP_S;
    800001de:	fe843703          	ld	a4,-24(s0)
    800001e2:	6785                	lui	a5,0x1
    800001e4:	80078793          	addi	a5,a5,-2048 # 800 <_entry-0x7ffff800>
    800001e8:	8fd9                	or	a5,a5,a4
    800001ea:	fef43423          	sd	a5,-24(s0)
  w_mstatus(x);
    800001ee:	fe843503          	ld	a0,-24(s0)
    800001f2:	00000097          	auipc	ra,0x0
    800001f6:	e5e080e7          	jalr	-418(ra) # 80000050 <w_mstatus>

  // set M Exception Program Counter to main, for mret.
  // requires gcc -mcmodel=medany
  w_mepc((uint64)main);
    800001fa:	00001797          	auipc	a5,0x1
    800001fe:	5fa78793          	addi	a5,a5,1530 # 800017f4 <main>
    80000202:	853e                	mv	a0,a5
    80000204:	00000097          	auipc	ra,0x0
    80000208:	e66080e7          	jalr	-410(ra) # 8000006a <w_mepc>

  // disable paging for now.
  w_satp(0);
    8000020c:	4501                	li	a0,0
    8000020e:	00000097          	auipc	ra,0x0
    80000212:	f60080e7          	jalr	-160(ra) # 8000016e <w_satp>

  // delegate all interrupts and exceptions to supervisor mode.
  w_medeleg(0xffff);
    80000216:	67c1                	lui	a5,0x10
    80000218:	fff78513          	addi	a0,a5,-1 # ffff <_entry-0x7fff0001>
    8000021c:	00000097          	auipc	ra,0x0
    80000220:	ed0080e7          	jalr	-304(ra) # 800000ec <w_medeleg>
  w_mideleg(0xffff);
    80000224:	67c1                	lui	a5,0x10
    80000226:	fff78513          	addi	a0,a5,-1 # ffff <_entry-0x7fff0001>
    8000022a:	00000097          	auipc	ra,0x0
    8000022e:	edc080e7          	jalr	-292(ra) # 80000106 <w_mideleg>
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80000232:	00000097          	auipc	ra,0x0
    80000236:	e52080e7          	jalr	-430(ra) # 80000084 <r_sie>
    8000023a:	87aa                	mv	a5,a0
    8000023c:	2227e793          	ori	a5,a5,546
    80000240:	853e                	mv	a0,a5
    80000242:	00000097          	auipc	ra,0x0
    80000246:	e5c080e7          	jalr	-420(ra) # 8000009e <w_sie>

  // configure Physical Memory Protection to give supervisor mode
  // access to all of physical memory.
  w_pmpaddr0(0x3fffffffffffffull);
    8000024a:	57fd                	li	a5,-1
    8000024c:	00a7d513          	srli	a0,a5,0xa
    80000250:	00000097          	auipc	ra,0x0
    80000254:	f04080e7          	jalr	-252(ra) # 80000154 <w_pmpaddr0>
  w_pmpcfg0(0xf);
    80000258:	453d                	li	a0,15
    8000025a:	00000097          	auipc	ra,0x0
    8000025e:	ee0080e7          	jalr	-288(ra) # 8000013a <w_pmpcfg0>

  // ask for clock interrupts.
  timerinit();
    80000262:	00000097          	auipc	ra,0x0
    80000266:	032080e7          	jalr	50(ra) # 80000294 <timerinit>

  // keep each CPU's hartid in its tp register, for cpuid().
  int id = r_mhartid();
    8000026a:	00000097          	auipc	ra,0x0
    8000026e:	db2080e7          	jalr	-590(ra) # 8000001c <r_mhartid>
    80000272:	87aa                	mv	a5,a0
    80000274:	fef42223          	sw	a5,-28(s0)
  w_tp(id);
    80000278:	fe442783          	lw	a5,-28(s0)
    8000027c:	853e                	mv	a0,a5
    8000027e:	00000097          	auipc	ra,0x0
    80000282:	f24080e7          	jalr	-220(ra) # 800001a2 <w_tp>

  // switch to supervisor mode and jump to main().
  asm volatile("mret");
    80000286:	30200073          	mret
}
    8000028a:	0001                	nop
    8000028c:	60e2                	ld	ra,24(sp)
    8000028e:	6442                	ld	s0,16(sp)
    80000290:	6105                	addi	sp,sp,32
    80000292:	8082                	ret

0000000080000294 <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80000294:	1101                	addi	sp,sp,-32
    80000296:	ec06                	sd	ra,24(sp)
    80000298:	e822                	sd	s0,16(sp)
    8000029a:	1000                	addi	s0,sp,32
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    8000029c:	00000097          	auipc	ra,0x0
    800002a0:	d80080e7          	jalr	-640(ra) # 8000001c <r_mhartid>
    800002a4:	87aa                	mv	a5,a0
    800002a6:	fef42623          	sw	a5,-20(s0)

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
    800002aa:	000f47b7          	lui	a5,0xf4
    800002ae:	24078793          	addi	a5,a5,576 # f4240 <_entry-0x7ff0bdc0>
    800002b2:	fef42423          	sw	a5,-24(s0)
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    800002b6:	0200c7b7          	lui	a5,0x200c
    800002ba:	17e1                	addi	a5,a5,-8
    800002bc:	6398                	ld	a4,0(a5)
    800002be:	fe842783          	lw	a5,-24(s0)
    800002c2:	fec42683          	lw	a3,-20(s0)
    800002c6:	0036969b          	slliw	a3,a3,0x3
    800002ca:	2681                	sext.w	a3,a3
    800002cc:	8636                	mv	a2,a3
    800002ce:	020046b7          	lui	a3,0x2004
    800002d2:	96b2                	add	a3,a3,a2
    800002d4:	97ba                	add	a5,a5,a4
    800002d6:	e29c                	sd	a5,0(a3)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    800002d8:	fec42703          	lw	a4,-20(s0)
    800002dc:	87ba                	mv	a5,a4
    800002de:	078a                	slli	a5,a5,0x2
    800002e0:	97ba                	add	a5,a5,a4
    800002e2:	078e                	slli	a5,a5,0x3
    800002e4:	00014717          	auipc	a4,0x14
    800002e8:	d4c70713          	addi	a4,a4,-692 # 80014030 <timer_scratch>
    800002ec:	97ba                	add	a5,a5,a4
    800002ee:	fef43023          	sd	a5,-32(s0)
  scratch[3] = CLINT_MTIMECMP(id);
    800002f2:	fec42783          	lw	a5,-20(s0)
    800002f6:	0037979b          	slliw	a5,a5,0x3
    800002fa:	2781                	sext.w	a5,a5
    800002fc:	873e                	mv	a4,a5
    800002fe:	020047b7          	lui	a5,0x2004
    80000302:	973e                	add	a4,a4,a5
    80000304:	fe043783          	ld	a5,-32(s0)
    80000308:	07e1                	addi	a5,a5,24
    8000030a:	e398                	sd	a4,0(a5)
  scratch[4] = interval;
    8000030c:	fe043783          	ld	a5,-32(s0)
    80000310:	02078793          	addi	a5,a5,32 # 2004020 <_entry-0x7dffbfe0>
    80000314:	fe842703          	lw	a4,-24(s0)
    80000318:	e398                	sd	a4,0(a5)
  w_mscratch((uint64)scratch);
    8000031a:	fe043783          	ld	a5,-32(s0)
    8000031e:	853e                	mv	a0,a5
    80000320:	00000097          	auipc	ra,0x0
    80000324:	e68080e7          	jalr	-408(ra) # 80000188 <w_mscratch>

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);
    80000328:	00009797          	auipc	a5,0x9
    8000032c:	fa878793          	addi	a5,a5,-88 # 800092d0 <timervec>
    80000330:	853e                	mv	a0,a5
    80000332:	00000097          	auipc	ra,0x0
    80000336:	dee080e7          	jalr	-530(ra) # 80000120 <w_mtvec>

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    8000033a:	00000097          	auipc	ra,0x0
    8000033e:	cfc080e7          	jalr	-772(ra) # 80000036 <r_mstatus>
    80000342:	87aa                	mv	a5,a0
    80000344:	0087e793          	ori	a5,a5,8
    80000348:	853e                	mv	a0,a5
    8000034a:	00000097          	auipc	ra,0x0
    8000034e:	d06080e7          	jalr	-762(ra) # 80000050 <w_mstatus>

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80000352:	00000097          	auipc	ra,0x0
    80000356:	d66080e7          	jalr	-666(ra) # 800000b8 <r_mie>
    8000035a:	87aa                	mv	a5,a0
    8000035c:	0807e793          	ori	a5,a5,128
    80000360:	853e                	mv	a0,a5
    80000362:	00000097          	auipc	ra,0x0
    80000366:	d70080e7          	jalr	-656(ra) # 800000d2 <w_mie>
}
    8000036a:	0001                	nop
    8000036c:	60e2                	ld	ra,24(sp)
    8000036e:	6442                	ld	s0,16(sp)
    80000370:	6105                	addi	sp,sp,32
    80000372:	8082                	ret

0000000080000374 <consputc>:
// called by printf, and to echo input characters,
// but not from write().
//
void
consputc(int c)
{
    80000374:	1101                	addi	sp,sp,-32
    80000376:	ec06                	sd	ra,24(sp)
    80000378:	e822                	sd	s0,16(sp)
    8000037a:	1000                	addi	s0,sp,32
    8000037c:	87aa                	mv	a5,a0
    8000037e:	fef42623          	sw	a5,-20(s0)
  if(c == BACKSPACE){
    80000382:	fec42783          	lw	a5,-20(s0)
    80000386:	0007871b          	sext.w	a4,a5
    8000038a:	10000793          	li	a5,256
    8000038e:	02f71363          	bne	a4,a5,800003b4 <consputc+0x40>
    // if the user typed backspace, overwrite with a space.
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80000392:	4521                	li	a0,8
    80000394:	00001097          	auipc	ra,0x1
    80000398:	aa8080e7          	jalr	-1368(ra) # 80000e3c <uartputc_sync>
    8000039c:	02000513          	li	a0,32
    800003a0:	00001097          	auipc	ra,0x1
    800003a4:	a9c080e7          	jalr	-1380(ra) # 80000e3c <uartputc_sync>
    800003a8:	4521                	li	a0,8
    800003aa:	00001097          	auipc	ra,0x1
    800003ae:	a92080e7          	jalr	-1390(ra) # 80000e3c <uartputc_sync>
  } else {
    uartputc_sync(c);
  }
}
    800003b2:	a801                	j	800003c2 <consputc+0x4e>
    uartputc_sync(c);
    800003b4:	fec42783          	lw	a5,-20(s0)
    800003b8:	853e                	mv	a0,a5
    800003ba:	00001097          	auipc	ra,0x1
    800003be:	a82080e7          	jalr	-1406(ra) # 80000e3c <uartputc_sync>
}
    800003c2:	0001                	nop
    800003c4:	60e2                	ld	ra,24(sp)
    800003c6:	6442                	ld	s0,16(sp)
    800003c8:	6105                	addi	sp,sp,32
    800003ca:	8082                	ret

00000000800003cc <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    800003cc:	7179                	addi	sp,sp,-48
    800003ce:	f406                	sd	ra,40(sp)
    800003d0:	f022                	sd	s0,32(sp)
    800003d2:	1800                	addi	s0,sp,48
    800003d4:	87aa                	mv	a5,a0
    800003d6:	fcb43823          	sd	a1,-48(s0)
    800003da:	8732                	mv	a4,a2
    800003dc:	fcf42e23          	sw	a5,-36(s0)
    800003e0:	87ba                	mv	a5,a4
    800003e2:	fcf42c23          	sw	a5,-40(s0)
  int i;

  for(i = 0; i < n; i++){
    800003e6:	fe042623          	sw	zero,-20(s0)
    800003ea:	a0a1                	j	80000432 <consolewrite+0x66>
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    800003ec:	fec42703          	lw	a4,-20(s0)
    800003f0:	fd043783          	ld	a5,-48(s0)
    800003f4:	00f70633          	add	a2,a4,a5
    800003f8:	fdc42703          	lw	a4,-36(s0)
    800003fc:	feb40793          	addi	a5,s0,-21
    80000400:	4685                	li	a3,1
    80000402:	85ba                	mv	a1,a4
    80000404:	853e                	mv	a0,a5
    80000406:	00003097          	auipc	ra,0x3
    8000040a:	71a080e7          	jalr	1818(ra) # 80003b20 <either_copyin>
    8000040e:	87aa                	mv	a5,a0
    80000410:	873e                	mv	a4,a5
    80000412:	57fd                	li	a5,-1
    80000414:	02f70963          	beq	a4,a5,80000446 <consolewrite+0x7a>
      break;
    uartputc(c);
    80000418:	feb44783          	lbu	a5,-21(s0)
    8000041c:	2781                	sext.w	a5,a5
    8000041e:	853e                	mv	a0,a5
    80000420:	00001097          	auipc	ra,0x1
    80000424:	95c080e7          	jalr	-1700(ra) # 80000d7c <uartputc>
  for(i = 0; i < n; i++){
    80000428:	fec42783          	lw	a5,-20(s0)
    8000042c:	2785                	addiw	a5,a5,1
    8000042e:	fef42623          	sw	a5,-20(s0)
    80000432:	fec42783          	lw	a5,-20(s0)
    80000436:	873e                	mv	a4,a5
    80000438:	fd842783          	lw	a5,-40(s0)
    8000043c:	2701                	sext.w	a4,a4
    8000043e:	2781                	sext.w	a5,a5
    80000440:	faf746e3          	blt	a4,a5,800003ec <consolewrite+0x20>
    80000444:	a011                	j	80000448 <consolewrite+0x7c>
      break;
    80000446:	0001                	nop
  }

  return i;
    80000448:	fec42783          	lw	a5,-20(s0)
}
    8000044c:	853e                	mv	a0,a5
    8000044e:	70a2                	ld	ra,40(sp)
    80000450:	7402                	ld	s0,32(sp)
    80000452:	6145                	addi	sp,sp,48
    80000454:	8082                	ret

0000000080000456 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80000456:	7179                	addi	sp,sp,-48
    80000458:	f406                	sd	ra,40(sp)
    8000045a:	f022                	sd	s0,32(sp)
    8000045c:	1800                	addi	s0,sp,48
    8000045e:	87aa                	mv	a5,a0
    80000460:	fcb43823          	sd	a1,-48(s0)
    80000464:	8732                	mv	a4,a2
    80000466:	fcf42e23          	sw	a5,-36(s0)
    8000046a:	87ba                	mv	a5,a4
    8000046c:	fcf42c23          	sw	a5,-40(s0)
  uint target;
  int c;
  char cbuf;

  target = n;
    80000470:	fd842783          	lw	a5,-40(s0)
    80000474:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    80000478:	00014517          	auipc	a0,0x14
    8000047c:	cf850513          	addi	a0,a0,-776 # 80014170 <cons>
    80000480:	00001097          	auipc	ra,0x1
    80000484:	dea080e7          	jalr	-534(ra) # 8000126a <acquire>
  while(n > 0){
    80000488:	a215                	j	800005ac <consoleread+0x156>
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
      if(myproc()->killed){
    8000048a:	00002097          	auipc	ra,0x2
    8000048e:	58e080e7          	jalr	1422(ra) # 80002a18 <myproc>
    80000492:	87aa                	mv	a5,a0
    80000494:	579c                	lw	a5,40(a5)
    80000496:	cb99                	beqz	a5,800004ac <consoleread+0x56>
        release(&cons.lock);
    80000498:	00014517          	auipc	a0,0x14
    8000049c:	cd850513          	addi	a0,a0,-808 # 80014170 <cons>
    800004a0:	00001097          	auipc	ra,0x1
    800004a4:	e2e080e7          	jalr	-466(ra) # 800012ce <release>
        return -1;
    800004a8:	57fd                	li	a5,-1
    800004aa:	aa25                	j	800005e2 <consoleread+0x18c>
      }
      sleep(&cons.r, &cons.lock);
    800004ac:	00014597          	auipc	a1,0x14
    800004b0:	cc458593          	addi	a1,a1,-828 # 80014170 <cons>
    800004b4:	00014517          	auipc	a0,0x14
    800004b8:	d5450513          	addi	a0,a0,-684 # 80014208 <cons+0x98>
    800004bc:	00003097          	auipc	ra,0x3
    800004c0:	438080e7          	jalr	1080(ra) # 800038f4 <sleep>
    while(cons.r == cons.w){
    800004c4:	00014797          	auipc	a5,0x14
    800004c8:	cac78793          	addi	a5,a5,-852 # 80014170 <cons>
    800004cc:	0987a703          	lw	a4,152(a5)
    800004d0:	00014797          	auipc	a5,0x14
    800004d4:	ca078793          	addi	a5,a5,-864 # 80014170 <cons>
    800004d8:	09c7a783          	lw	a5,156(a5)
    800004dc:	faf707e3          	beq	a4,a5,8000048a <consoleread+0x34>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];
    800004e0:	00014797          	auipc	a5,0x14
    800004e4:	c9078793          	addi	a5,a5,-880 # 80014170 <cons>
    800004e8:	0987a783          	lw	a5,152(a5)
    800004ec:	2781                	sext.w	a5,a5
    800004ee:	0017871b          	addiw	a4,a5,1
    800004f2:	0007069b          	sext.w	a3,a4
    800004f6:	00014717          	auipc	a4,0x14
    800004fa:	c7a70713          	addi	a4,a4,-902 # 80014170 <cons>
    800004fe:	08d72c23          	sw	a3,152(a4)
    80000502:	07f7f793          	andi	a5,a5,127
    80000506:	2781                	sext.w	a5,a5
    80000508:	00014717          	auipc	a4,0x14
    8000050c:	c6870713          	addi	a4,a4,-920 # 80014170 <cons>
    80000510:	1782                	slli	a5,a5,0x20
    80000512:	9381                	srli	a5,a5,0x20
    80000514:	97ba                	add	a5,a5,a4
    80000516:	0187c783          	lbu	a5,24(a5)
    8000051a:	fef42423          	sw	a5,-24(s0)

    if(c == C('D')){  // end-of-file
    8000051e:	fe842783          	lw	a5,-24(s0)
    80000522:	0007871b          	sext.w	a4,a5
    80000526:	4791                	li	a5,4
    80000528:	02f71963          	bne	a4,a5,8000055a <consoleread+0x104>
      if(n < target){
    8000052c:	fd842703          	lw	a4,-40(s0)
    80000530:	fec42783          	lw	a5,-20(s0)
    80000534:	2781                	sext.w	a5,a5
    80000536:	08f77163          	bgeu	a4,a5,800005b8 <consoleread+0x162>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        cons.r--;
    8000053a:	00014797          	auipc	a5,0x14
    8000053e:	c3678793          	addi	a5,a5,-970 # 80014170 <cons>
    80000542:	0987a783          	lw	a5,152(a5)
    80000546:	37fd                	addiw	a5,a5,-1
    80000548:	0007871b          	sext.w	a4,a5
    8000054c:	00014797          	auipc	a5,0x14
    80000550:	c2478793          	addi	a5,a5,-988 # 80014170 <cons>
    80000554:	08e7ac23          	sw	a4,152(a5)
      }
      break;
    80000558:	a085                	j	800005b8 <consoleread+0x162>
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    8000055a:	fe842783          	lw	a5,-24(s0)
    8000055e:	0ff7f793          	zext.b	a5,a5
    80000562:	fef403a3          	sb	a5,-25(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000566:	fe740713          	addi	a4,s0,-25
    8000056a:	fdc42783          	lw	a5,-36(s0)
    8000056e:	4685                	li	a3,1
    80000570:	863a                	mv	a2,a4
    80000572:	fd043583          	ld	a1,-48(s0)
    80000576:	853e                	mv	a0,a5
    80000578:	00003097          	auipc	ra,0x3
    8000057c:	534080e7          	jalr	1332(ra) # 80003aac <either_copyout>
    80000580:	87aa                	mv	a5,a0
    80000582:	873e                	mv	a4,a5
    80000584:	57fd                	li	a5,-1
    80000586:	02f70b63          	beq	a4,a5,800005bc <consoleread+0x166>
      break;

    dst++;
    8000058a:	fd043783          	ld	a5,-48(s0)
    8000058e:	0785                	addi	a5,a5,1
    80000590:	fcf43823          	sd	a5,-48(s0)
    --n;
    80000594:	fd842783          	lw	a5,-40(s0)
    80000598:	37fd                	addiw	a5,a5,-1
    8000059a:	fcf42c23          	sw	a5,-40(s0)

    if(c == '\n'){
    8000059e:	fe842783          	lw	a5,-24(s0)
    800005a2:	0007871b          	sext.w	a4,a5
    800005a6:	47a9                	li	a5,10
    800005a8:	00f70c63          	beq	a4,a5,800005c0 <consoleread+0x16a>
  while(n > 0){
    800005ac:	fd842783          	lw	a5,-40(s0)
    800005b0:	2781                	sext.w	a5,a5
    800005b2:	f0f049e3          	bgtz	a5,800004c4 <consoleread+0x6e>
    800005b6:	a031                	j	800005c2 <consoleread+0x16c>
      break;
    800005b8:	0001                	nop
    800005ba:	a021                	j	800005c2 <consoleread+0x16c>
      break;
    800005bc:	0001                	nop
    800005be:	a011                	j	800005c2 <consoleread+0x16c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    800005c0:	0001                	nop
    }
  }
  release(&cons.lock);
    800005c2:	00014517          	auipc	a0,0x14
    800005c6:	bae50513          	addi	a0,a0,-1106 # 80014170 <cons>
    800005ca:	00001097          	auipc	ra,0x1
    800005ce:	d04080e7          	jalr	-764(ra) # 800012ce <release>

  return target - n;
    800005d2:	fd842783          	lw	a5,-40(s0)
    800005d6:	fec42703          	lw	a4,-20(s0)
    800005da:	40f707bb          	subw	a5,a4,a5
    800005de:	2781                	sext.w	a5,a5
    800005e0:	2781                	sext.w	a5,a5
}
    800005e2:	853e                	mv	a0,a5
    800005e4:	70a2                	ld	ra,40(sp)
    800005e6:	7402                	ld	s0,32(sp)
    800005e8:	6145                	addi	sp,sp,48
    800005ea:	8082                	ret

00000000800005ec <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800005ec:	1101                	addi	sp,sp,-32
    800005ee:	ec06                	sd	ra,24(sp)
    800005f0:	e822                	sd	s0,16(sp)
    800005f2:	1000                	addi	s0,sp,32
    800005f4:	87aa                	mv	a5,a0
    800005f6:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    800005fa:	00014517          	auipc	a0,0x14
    800005fe:	b7650513          	addi	a0,a0,-1162 # 80014170 <cons>
    80000602:	00001097          	auipc	ra,0x1
    80000606:	c68080e7          	jalr	-920(ra) # 8000126a <acquire>

  switch(c){
    8000060a:	fec42783          	lw	a5,-20(s0)
    8000060e:	0007871b          	sext.w	a4,a5
    80000612:	07f00793          	li	a5,127
    80000616:	0cf70763          	beq	a4,a5,800006e4 <consoleintr+0xf8>
    8000061a:	fec42783          	lw	a5,-20(s0)
    8000061e:	0007871b          	sext.w	a4,a5
    80000622:	07f00793          	li	a5,127
    80000626:	10e7c363          	blt	a5,a4,8000072c <consoleintr+0x140>
    8000062a:	fec42783          	lw	a5,-20(s0)
    8000062e:	0007871b          	sext.w	a4,a5
    80000632:	47d5                	li	a5,21
    80000634:	06f70163          	beq	a4,a5,80000696 <consoleintr+0xaa>
    80000638:	fec42783          	lw	a5,-20(s0)
    8000063c:	0007871b          	sext.w	a4,a5
    80000640:	47d5                	li	a5,21
    80000642:	0ee7c563          	blt	a5,a4,8000072c <consoleintr+0x140>
    80000646:	fec42783          	lw	a5,-20(s0)
    8000064a:	0007871b          	sext.w	a4,a5
    8000064e:	47a1                	li	a5,8
    80000650:	08f70a63          	beq	a4,a5,800006e4 <consoleintr+0xf8>
    80000654:	fec42783          	lw	a5,-20(s0)
    80000658:	0007871b          	sext.w	a4,a5
    8000065c:	47c1                	li	a5,16
    8000065e:	0cf71763          	bne	a4,a5,8000072c <consoleintr+0x140>
  case C('P'):  // Print process list.
    procdump();
    80000662:	00003097          	auipc	ra,0x3
    80000666:	532080e7          	jalr	1330(ra) # 80003b94 <procdump>
    break;
    8000066a:	aac1                	j	8000083a <consoleintr+0x24e>
  case C('U'):  // Kill line.
    while(cons.e != cons.w &&
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
      cons.e--;
    8000066c:	00014797          	auipc	a5,0x14
    80000670:	b0478793          	addi	a5,a5,-1276 # 80014170 <cons>
    80000674:	0a07a783          	lw	a5,160(a5)
    80000678:	37fd                	addiw	a5,a5,-1
    8000067a:	0007871b          	sext.w	a4,a5
    8000067e:	00014797          	auipc	a5,0x14
    80000682:	af278793          	addi	a5,a5,-1294 # 80014170 <cons>
    80000686:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    8000068a:	10000513          	li	a0,256
    8000068e:	00000097          	auipc	ra,0x0
    80000692:	ce6080e7          	jalr	-794(ra) # 80000374 <consputc>
    while(cons.e != cons.w &&
    80000696:	00014797          	auipc	a5,0x14
    8000069a:	ada78793          	addi	a5,a5,-1318 # 80014170 <cons>
    8000069e:	0a07a703          	lw	a4,160(a5)
    800006a2:	00014797          	auipc	a5,0x14
    800006a6:	ace78793          	addi	a5,a5,-1330 # 80014170 <cons>
    800006aa:	09c7a783          	lw	a5,156(a5)
    800006ae:	18f70163          	beq	a4,a5,80000830 <consoleintr+0x244>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800006b2:	00014797          	auipc	a5,0x14
    800006b6:	abe78793          	addi	a5,a5,-1346 # 80014170 <cons>
    800006ba:	0a07a783          	lw	a5,160(a5)
    800006be:	37fd                	addiw	a5,a5,-1
    800006c0:	2781                	sext.w	a5,a5
    800006c2:	07f7f793          	andi	a5,a5,127
    800006c6:	2781                	sext.w	a5,a5
    800006c8:	00014717          	auipc	a4,0x14
    800006cc:	aa870713          	addi	a4,a4,-1368 # 80014170 <cons>
    800006d0:	1782                	slli	a5,a5,0x20
    800006d2:	9381                	srli	a5,a5,0x20
    800006d4:	97ba                	add	a5,a5,a4
    800006d6:	0187c783          	lbu	a5,24(a5)
    while(cons.e != cons.w &&
    800006da:	873e                	mv	a4,a5
    800006dc:	47a9                	li	a5,10
    800006de:	f8f717e3          	bne	a4,a5,8000066c <consoleintr+0x80>
    }
    break;
    800006e2:	a2b9                	j	80000830 <consoleintr+0x244>
  case C('H'): // Backspace
  case '\x7f':
    if(cons.e != cons.w){
    800006e4:	00014797          	auipc	a5,0x14
    800006e8:	a8c78793          	addi	a5,a5,-1396 # 80014170 <cons>
    800006ec:	0a07a703          	lw	a4,160(a5)
    800006f0:	00014797          	auipc	a5,0x14
    800006f4:	a8078793          	addi	a5,a5,-1408 # 80014170 <cons>
    800006f8:	09c7a783          	lw	a5,156(a5)
    800006fc:	12f70c63          	beq	a4,a5,80000834 <consoleintr+0x248>
      cons.e--;
    80000700:	00014797          	auipc	a5,0x14
    80000704:	a7078793          	addi	a5,a5,-1424 # 80014170 <cons>
    80000708:	0a07a783          	lw	a5,160(a5)
    8000070c:	37fd                	addiw	a5,a5,-1
    8000070e:	0007871b          	sext.w	a4,a5
    80000712:	00014797          	auipc	a5,0x14
    80000716:	a5e78793          	addi	a5,a5,-1442 # 80014170 <cons>
    8000071a:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    8000071e:	10000513          	li	a0,256
    80000722:	00000097          	auipc	ra,0x0
    80000726:	c52080e7          	jalr	-942(ra) # 80000374 <consputc>
    }
    break;
    8000072a:	a229                	j	80000834 <consoleintr+0x248>
  default:
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    8000072c:	fec42783          	lw	a5,-20(s0)
    80000730:	2781                	sext.w	a5,a5
    80000732:	10078363          	beqz	a5,80000838 <consoleintr+0x24c>
    80000736:	00014797          	auipc	a5,0x14
    8000073a:	a3a78793          	addi	a5,a5,-1478 # 80014170 <cons>
    8000073e:	0a07a703          	lw	a4,160(a5)
    80000742:	00014797          	auipc	a5,0x14
    80000746:	a2e78793          	addi	a5,a5,-1490 # 80014170 <cons>
    8000074a:	0987a783          	lw	a5,152(a5)
    8000074e:	40f707bb          	subw	a5,a4,a5
    80000752:	2781                	sext.w	a5,a5
    80000754:	873e                	mv	a4,a5
    80000756:	07f00793          	li	a5,127
    8000075a:	0ce7ef63          	bltu	a5,a4,80000838 <consoleintr+0x24c>
      c = (c == '\r') ? '\n' : c;
    8000075e:	fec42783          	lw	a5,-20(s0)
    80000762:	0007871b          	sext.w	a4,a5
    80000766:	47b5                	li	a5,13
    80000768:	00f70563          	beq	a4,a5,80000772 <consoleintr+0x186>
    8000076c:	fec42783          	lw	a5,-20(s0)
    80000770:	a011                	j	80000774 <consoleintr+0x188>
    80000772:	47a9                	li	a5,10
    80000774:	fef42623          	sw	a5,-20(s0)

      // echo back to the user.
      consputc(c);
    80000778:	fec42783          	lw	a5,-20(s0)
    8000077c:	853e                	mv	a0,a5
    8000077e:	00000097          	auipc	ra,0x0
    80000782:	bf6080e7          	jalr	-1034(ra) # 80000374 <consputc>

      // store for consumption by consoleread().
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80000786:	00014797          	auipc	a5,0x14
    8000078a:	9ea78793          	addi	a5,a5,-1558 # 80014170 <cons>
    8000078e:	0a07a783          	lw	a5,160(a5)
    80000792:	2781                	sext.w	a5,a5
    80000794:	0017871b          	addiw	a4,a5,1
    80000798:	0007069b          	sext.w	a3,a4
    8000079c:	00014717          	auipc	a4,0x14
    800007a0:	9d470713          	addi	a4,a4,-1580 # 80014170 <cons>
    800007a4:	0ad72023          	sw	a3,160(a4)
    800007a8:	07f7f793          	andi	a5,a5,127
    800007ac:	2781                	sext.w	a5,a5
    800007ae:	fec42703          	lw	a4,-20(s0)
    800007b2:	0ff77713          	zext.b	a4,a4
    800007b6:	00014697          	auipc	a3,0x14
    800007ba:	9ba68693          	addi	a3,a3,-1606 # 80014170 <cons>
    800007be:	1782                	slli	a5,a5,0x20
    800007c0:	9381                	srli	a5,a5,0x20
    800007c2:	97b6                	add	a5,a5,a3
    800007c4:	00e78c23          	sb	a4,24(a5)

      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    800007c8:	fec42783          	lw	a5,-20(s0)
    800007cc:	0007871b          	sext.w	a4,a5
    800007d0:	47a9                	li	a5,10
    800007d2:	02f70a63          	beq	a4,a5,80000806 <consoleintr+0x21a>
    800007d6:	fec42783          	lw	a5,-20(s0)
    800007da:	0007871b          	sext.w	a4,a5
    800007de:	4791                	li	a5,4
    800007e0:	02f70363          	beq	a4,a5,80000806 <consoleintr+0x21a>
    800007e4:	00014797          	auipc	a5,0x14
    800007e8:	98c78793          	addi	a5,a5,-1652 # 80014170 <cons>
    800007ec:	0a07a703          	lw	a4,160(a5)
    800007f0:	00014797          	auipc	a5,0x14
    800007f4:	98078793          	addi	a5,a5,-1664 # 80014170 <cons>
    800007f8:	0987a783          	lw	a5,152(a5)
    800007fc:	0807879b          	addiw	a5,a5,128
    80000800:	2781                	sext.w	a5,a5
    80000802:	02f71b63          	bne	a4,a5,80000838 <consoleintr+0x24c>
        // wake up consoleread() if a whole line (or end-of-file)
        // has arrived.
        cons.w = cons.e;
    80000806:	00014797          	auipc	a5,0x14
    8000080a:	96a78793          	addi	a5,a5,-1686 # 80014170 <cons>
    8000080e:	0a07a703          	lw	a4,160(a5)
    80000812:	00014797          	auipc	a5,0x14
    80000816:	95e78793          	addi	a5,a5,-1698 # 80014170 <cons>
    8000081a:	08e7ae23          	sw	a4,156(a5)
        wakeup(&cons.r);
    8000081e:	00014517          	auipc	a0,0x14
    80000822:	9ea50513          	addi	a0,a0,-1558 # 80014208 <cons+0x98>
    80000826:	00003097          	auipc	ra,0x3
    8000082a:	14a080e7          	jalr	330(ra) # 80003970 <wakeup>
      }
    }
    break;
    8000082e:	a029                	j	80000838 <consoleintr+0x24c>
    break;
    80000830:	0001                	nop
    80000832:	a021                	j	8000083a <consoleintr+0x24e>
    break;
    80000834:	0001                	nop
    80000836:	a011                	j	8000083a <consoleintr+0x24e>
    break;
    80000838:	0001                	nop
  }
  
  release(&cons.lock);
    8000083a:	00014517          	auipc	a0,0x14
    8000083e:	93650513          	addi	a0,a0,-1738 # 80014170 <cons>
    80000842:	00001097          	auipc	ra,0x1
    80000846:	a8c080e7          	jalr	-1396(ra) # 800012ce <release>
}
    8000084a:	0001                	nop
    8000084c:	60e2                	ld	ra,24(sp)
    8000084e:	6442                	ld	s0,16(sp)
    80000850:	6105                	addi	sp,sp,32
    80000852:	8082                	ret

0000000080000854 <consoleinit>:

void
consoleinit(void)
{
    80000854:	1141                	addi	sp,sp,-16
    80000856:	e406                	sd	ra,8(sp)
    80000858:	e022                	sd	s0,0(sp)
    8000085a:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    8000085c:	0000a597          	auipc	a1,0xa
    80000860:	7a458593          	addi	a1,a1,1956 # 8000b000 <etext>
    80000864:	00014517          	auipc	a0,0x14
    80000868:	90c50513          	addi	a0,a0,-1780 # 80014170 <cons>
    8000086c:	00001097          	auipc	ra,0x1
    80000870:	9ce080e7          	jalr	-1586(ra) # 8000123a <initlock>

  uartinit();
    80000874:	00000097          	auipc	ra,0x0
    80000878:	48e080e7          	jalr	1166(ra) # 80000d02 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    8000087c:	004a4797          	auipc	a5,0x4a4
    80000880:	49478793          	addi	a5,a5,1172 # 804a4d10 <devsw>
    80000884:	00000717          	auipc	a4,0x0
    80000888:	bd270713          	addi	a4,a4,-1070 # 80000456 <consoleread>
    8000088c:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    8000088e:	004a4797          	auipc	a5,0x4a4
    80000892:	48278793          	addi	a5,a5,1154 # 804a4d10 <devsw>
    80000896:	00000717          	auipc	a4,0x0
    8000089a:	b3670713          	addi	a4,a4,-1226 # 800003cc <consolewrite>
    8000089e:	ef98                	sd	a4,24(a5)
}
    800008a0:	0001                	nop
    800008a2:	60a2                	ld	ra,8(sp)
    800008a4:	6402                	ld	s0,0(sp)
    800008a6:	0141                	addi	sp,sp,16
    800008a8:	8082                	ret

00000000800008aa <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    800008aa:	7139                	addi	sp,sp,-64
    800008ac:	fc06                	sd	ra,56(sp)
    800008ae:	f822                	sd	s0,48(sp)
    800008b0:	0080                	addi	s0,sp,64
    800008b2:	87aa                	mv	a5,a0
    800008b4:	86ae                	mv	a3,a1
    800008b6:	8732                	mv	a4,a2
    800008b8:	fcf42623          	sw	a5,-52(s0)
    800008bc:	87b6                	mv	a5,a3
    800008be:	fcf42423          	sw	a5,-56(s0)
    800008c2:	87ba                	mv	a5,a4
    800008c4:	fcf42223          	sw	a5,-60(s0)
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800008c8:	fc442783          	lw	a5,-60(s0)
    800008cc:	2781                	sext.w	a5,a5
    800008ce:	c78d                	beqz	a5,800008f8 <printint+0x4e>
    800008d0:	fcc42783          	lw	a5,-52(s0)
    800008d4:	01f7d79b          	srliw	a5,a5,0x1f
    800008d8:	0ff7f793          	zext.b	a5,a5
    800008dc:	fcf42223          	sw	a5,-60(s0)
    800008e0:	fc442783          	lw	a5,-60(s0)
    800008e4:	2781                	sext.w	a5,a5
    800008e6:	cb89                	beqz	a5,800008f8 <printint+0x4e>
    x = -xx;
    800008e8:	fcc42783          	lw	a5,-52(s0)
    800008ec:	40f007bb          	negw	a5,a5
    800008f0:	2781                	sext.w	a5,a5
    800008f2:	fef42423          	sw	a5,-24(s0)
    800008f6:	a029                	j	80000900 <printint+0x56>
  else
    x = xx;
    800008f8:	fcc42783          	lw	a5,-52(s0)
    800008fc:	fef42423          	sw	a5,-24(s0)

  i = 0;
    80000900:	fe042623          	sw	zero,-20(s0)
  do {
    buf[i++] = digits[x % base];
    80000904:	fc842783          	lw	a5,-56(s0)
    80000908:	fe842703          	lw	a4,-24(s0)
    8000090c:	02f777bb          	remuw	a5,a4,a5
    80000910:	0007861b          	sext.w	a2,a5
    80000914:	fec42783          	lw	a5,-20(s0)
    80000918:	0017871b          	addiw	a4,a5,1
    8000091c:	fee42623          	sw	a4,-20(s0)
    80000920:	0000b697          	auipc	a3,0xb
    80000924:	fc068693          	addi	a3,a3,-64 # 8000b8e0 <digits>
    80000928:	02061713          	slli	a4,a2,0x20
    8000092c:	9301                	srli	a4,a4,0x20
    8000092e:	9736                	add	a4,a4,a3
    80000930:	00074703          	lbu	a4,0(a4)
    80000934:	17c1                	addi	a5,a5,-16
    80000936:	97a2                	add	a5,a5,s0
    80000938:	fee78423          	sb	a4,-24(a5)
  } while((x /= base) != 0);
    8000093c:	fc842783          	lw	a5,-56(s0)
    80000940:	fe842703          	lw	a4,-24(s0)
    80000944:	02f757bb          	divuw	a5,a4,a5
    80000948:	fef42423          	sw	a5,-24(s0)
    8000094c:	fe842783          	lw	a5,-24(s0)
    80000950:	2781                	sext.w	a5,a5
    80000952:	fbcd                	bnez	a5,80000904 <printint+0x5a>

  if(sign)
    80000954:	fc442783          	lw	a5,-60(s0)
    80000958:	2781                	sext.w	a5,a5
    8000095a:	cb95                	beqz	a5,8000098e <printint+0xe4>
    buf[i++] = '-';
    8000095c:	fec42783          	lw	a5,-20(s0)
    80000960:	0017871b          	addiw	a4,a5,1
    80000964:	fee42623          	sw	a4,-20(s0)
    80000968:	17c1                	addi	a5,a5,-16
    8000096a:	97a2                	add	a5,a5,s0
    8000096c:	02d00713          	li	a4,45
    80000970:	fee78423          	sb	a4,-24(a5)

  while(--i >= 0)
    80000974:	a829                	j	8000098e <printint+0xe4>
    consputc(buf[i]);
    80000976:	fec42783          	lw	a5,-20(s0)
    8000097a:	17c1                	addi	a5,a5,-16
    8000097c:	97a2                	add	a5,a5,s0
    8000097e:	fe87c783          	lbu	a5,-24(a5)
    80000982:	2781                	sext.w	a5,a5
    80000984:	853e                	mv	a0,a5
    80000986:	00000097          	auipc	ra,0x0
    8000098a:	9ee080e7          	jalr	-1554(ra) # 80000374 <consputc>
  while(--i >= 0)
    8000098e:	fec42783          	lw	a5,-20(s0)
    80000992:	37fd                	addiw	a5,a5,-1
    80000994:	fef42623          	sw	a5,-20(s0)
    80000998:	fec42783          	lw	a5,-20(s0)
    8000099c:	2781                	sext.w	a5,a5
    8000099e:	fc07dce3          	bgez	a5,80000976 <printint+0xcc>
}
    800009a2:	0001                	nop
    800009a4:	0001                	nop
    800009a6:	70e2                	ld	ra,56(sp)
    800009a8:	7442                	ld	s0,48(sp)
    800009aa:	6121                	addi	sp,sp,64
    800009ac:	8082                	ret

00000000800009ae <printptr>:

static void
printptr(uint64 x)
{
    800009ae:	7179                	addi	sp,sp,-48
    800009b0:	f406                	sd	ra,40(sp)
    800009b2:	f022                	sd	s0,32(sp)
    800009b4:	1800                	addi	s0,sp,48
    800009b6:	fca43c23          	sd	a0,-40(s0)
  int i;
  consputc('0');
    800009ba:	03000513          	li	a0,48
    800009be:	00000097          	auipc	ra,0x0
    800009c2:	9b6080e7          	jalr	-1610(ra) # 80000374 <consputc>
  consputc('x');
    800009c6:	07800513          	li	a0,120
    800009ca:	00000097          	auipc	ra,0x0
    800009ce:	9aa080e7          	jalr	-1622(ra) # 80000374 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800009d2:	fe042623          	sw	zero,-20(s0)
    800009d6:	a81d                	j	80000a0c <printptr+0x5e>
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800009d8:	fd843783          	ld	a5,-40(s0)
    800009dc:	93f1                	srli	a5,a5,0x3c
    800009de:	0000b717          	auipc	a4,0xb
    800009e2:	f0270713          	addi	a4,a4,-254 # 8000b8e0 <digits>
    800009e6:	97ba                	add	a5,a5,a4
    800009e8:	0007c783          	lbu	a5,0(a5)
    800009ec:	2781                	sext.w	a5,a5
    800009ee:	853e                	mv	a0,a5
    800009f0:	00000097          	auipc	ra,0x0
    800009f4:	984080e7          	jalr	-1660(ra) # 80000374 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800009f8:	fec42783          	lw	a5,-20(s0)
    800009fc:	2785                	addiw	a5,a5,1
    800009fe:	fef42623          	sw	a5,-20(s0)
    80000a02:	fd843783          	ld	a5,-40(s0)
    80000a06:	0792                	slli	a5,a5,0x4
    80000a08:	fcf43c23          	sd	a5,-40(s0)
    80000a0c:	fec42783          	lw	a5,-20(s0)
    80000a10:	873e                	mv	a4,a5
    80000a12:	47bd                	li	a5,15
    80000a14:	fce7f2e3          	bgeu	a5,a4,800009d8 <printptr+0x2a>
}
    80000a18:	0001                	nop
    80000a1a:	0001                	nop
    80000a1c:	70a2                	ld	ra,40(sp)
    80000a1e:	7402                	ld	s0,32(sp)
    80000a20:	6145                	addi	sp,sp,48
    80000a22:	8082                	ret

0000000080000a24 <printf>:

// Print to the console. only understands %d, %x, %p, %s.
void
printf(char *fmt, ...)
{
    80000a24:	7119                	addi	sp,sp,-128
    80000a26:	fc06                	sd	ra,56(sp)
    80000a28:	f822                	sd	s0,48(sp)
    80000a2a:	0080                	addi	s0,sp,64
    80000a2c:	fca43423          	sd	a0,-56(s0)
    80000a30:	e40c                	sd	a1,8(s0)
    80000a32:	e810                	sd	a2,16(s0)
    80000a34:	ec14                	sd	a3,24(s0)
    80000a36:	f018                	sd	a4,32(s0)
    80000a38:	f41c                	sd	a5,40(s0)
    80000a3a:	03043823          	sd	a6,48(s0)
    80000a3e:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, c, locking;
  char *s;

  locking = pr.locking;
    80000a42:	00013797          	auipc	a5,0x13
    80000a46:	7d678793          	addi	a5,a5,2006 # 80014218 <pr>
    80000a4a:	4f9c                	lw	a5,24(a5)
    80000a4c:	fcf42e23          	sw	a5,-36(s0)
  if(locking)
    80000a50:	fdc42783          	lw	a5,-36(s0)
    80000a54:	2781                	sext.w	a5,a5
    80000a56:	cb89                	beqz	a5,80000a68 <printf+0x44>
    acquire(&pr.lock);
    80000a58:	00013517          	auipc	a0,0x13
    80000a5c:	7c050513          	addi	a0,a0,1984 # 80014218 <pr>
    80000a60:	00001097          	auipc	ra,0x1
    80000a64:	80a080e7          	jalr	-2038(ra) # 8000126a <acquire>

  if (fmt == 0)
    80000a68:	fc843783          	ld	a5,-56(s0)
    80000a6c:	eb89                	bnez	a5,80000a7e <printf+0x5a>
    panic("null fmt");
    80000a6e:	0000a517          	auipc	a0,0xa
    80000a72:	59a50513          	addi	a0,a0,1434 # 8000b008 <etext+0x8>
    80000a76:	00000097          	auipc	ra,0x0
    80000a7a:	204080e7          	jalr	516(ra) # 80000c7a <panic>

  va_start(ap, fmt);
    80000a7e:	04040793          	addi	a5,s0,64
    80000a82:	fcf43023          	sd	a5,-64(s0)
    80000a86:	fc043783          	ld	a5,-64(s0)
    80000a8a:	fc878793          	addi	a5,a5,-56
    80000a8e:	fcf43823          	sd	a5,-48(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000a92:	fe042623          	sw	zero,-20(s0)
    80000a96:	a24d                	j	80000c38 <printf+0x214>
    if(c != '%'){
    80000a98:	fd842783          	lw	a5,-40(s0)
    80000a9c:	0007871b          	sext.w	a4,a5
    80000aa0:	02500793          	li	a5,37
    80000aa4:	00f70a63          	beq	a4,a5,80000ab8 <printf+0x94>
      consputc(c);
    80000aa8:	fd842783          	lw	a5,-40(s0)
    80000aac:	853e                	mv	a0,a5
    80000aae:	00000097          	auipc	ra,0x0
    80000ab2:	8c6080e7          	jalr	-1850(ra) # 80000374 <consputc>
      continue;
    80000ab6:	aaa5                	j	80000c2e <printf+0x20a>
    }
    c = fmt[++i] & 0xff;
    80000ab8:	fec42783          	lw	a5,-20(s0)
    80000abc:	2785                	addiw	a5,a5,1
    80000abe:	fef42623          	sw	a5,-20(s0)
    80000ac2:	fec42783          	lw	a5,-20(s0)
    80000ac6:	fc843703          	ld	a4,-56(s0)
    80000aca:	97ba                	add	a5,a5,a4
    80000acc:	0007c783          	lbu	a5,0(a5)
    80000ad0:	fcf42c23          	sw	a5,-40(s0)
    if(c == 0)
    80000ad4:	fd842783          	lw	a5,-40(s0)
    80000ad8:	2781                	sext.w	a5,a5
    80000ada:	16078e63          	beqz	a5,80000c56 <printf+0x232>
      break;
    switch(c){
    80000ade:	fd842783          	lw	a5,-40(s0)
    80000ae2:	0007871b          	sext.w	a4,a5
    80000ae6:	07800793          	li	a5,120
    80000aea:	08f70963          	beq	a4,a5,80000b7c <printf+0x158>
    80000aee:	fd842783          	lw	a5,-40(s0)
    80000af2:	0007871b          	sext.w	a4,a5
    80000af6:	07800793          	li	a5,120
    80000afa:	10e7cc63          	blt	a5,a4,80000c12 <printf+0x1ee>
    80000afe:	fd842783          	lw	a5,-40(s0)
    80000b02:	0007871b          	sext.w	a4,a5
    80000b06:	07300793          	li	a5,115
    80000b0a:	0af70563          	beq	a4,a5,80000bb4 <printf+0x190>
    80000b0e:	fd842783          	lw	a5,-40(s0)
    80000b12:	0007871b          	sext.w	a4,a5
    80000b16:	07300793          	li	a5,115
    80000b1a:	0ee7cc63          	blt	a5,a4,80000c12 <printf+0x1ee>
    80000b1e:	fd842783          	lw	a5,-40(s0)
    80000b22:	0007871b          	sext.w	a4,a5
    80000b26:	07000793          	li	a5,112
    80000b2a:	06f70863          	beq	a4,a5,80000b9a <printf+0x176>
    80000b2e:	fd842783          	lw	a5,-40(s0)
    80000b32:	0007871b          	sext.w	a4,a5
    80000b36:	07000793          	li	a5,112
    80000b3a:	0ce7cc63          	blt	a5,a4,80000c12 <printf+0x1ee>
    80000b3e:	fd842783          	lw	a5,-40(s0)
    80000b42:	0007871b          	sext.w	a4,a5
    80000b46:	02500793          	li	a5,37
    80000b4a:	0af70d63          	beq	a4,a5,80000c04 <printf+0x1e0>
    80000b4e:	fd842783          	lw	a5,-40(s0)
    80000b52:	0007871b          	sext.w	a4,a5
    80000b56:	06400793          	li	a5,100
    80000b5a:	0af71c63          	bne	a4,a5,80000c12 <printf+0x1ee>
    case 'd':
      printint(va_arg(ap, int), 10, 1);
    80000b5e:	fd043783          	ld	a5,-48(s0)
    80000b62:	00878713          	addi	a4,a5,8
    80000b66:	fce43823          	sd	a4,-48(s0)
    80000b6a:	439c                	lw	a5,0(a5)
    80000b6c:	4605                	li	a2,1
    80000b6e:	45a9                	li	a1,10
    80000b70:	853e                	mv	a0,a5
    80000b72:	00000097          	auipc	ra,0x0
    80000b76:	d38080e7          	jalr	-712(ra) # 800008aa <printint>
      break;
    80000b7a:	a855                	j	80000c2e <printf+0x20a>
    case 'x':
      printint(va_arg(ap, int), 16, 1);
    80000b7c:	fd043783          	ld	a5,-48(s0)
    80000b80:	00878713          	addi	a4,a5,8
    80000b84:	fce43823          	sd	a4,-48(s0)
    80000b88:	439c                	lw	a5,0(a5)
    80000b8a:	4605                	li	a2,1
    80000b8c:	45c1                	li	a1,16
    80000b8e:	853e                	mv	a0,a5
    80000b90:	00000097          	auipc	ra,0x0
    80000b94:	d1a080e7          	jalr	-742(ra) # 800008aa <printint>
      break;
    80000b98:	a859                	j	80000c2e <printf+0x20a>
    case 'p':
      printptr(va_arg(ap, uint64));
    80000b9a:	fd043783          	ld	a5,-48(s0)
    80000b9e:	00878713          	addi	a4,a5,8
    80000ba2:	fce43823          	sd	a4,-48(s0)
    80000ba6:	639c                	ld	a5,0(a5)
    80000ba8:	853e                	mv	a0,a5
    80000baa:	00000097          	auipc	ra,0x0
    80000bae:	e04080e7          	jalr	-508(ra) # 800009ae <printptr>
      break;
    80000bb2:	a8b5                	j	80000c2e <printf+0x20a>
    case 's':
      if((s = va_arg(ap, char*)) == 0)
    80000bb4:	fd043783          	ld	a5,-48(s0)
    80000bb8:	00878713          	addi	a4,a5,8
    80000bbc:	fce43823          	sd	a4,-48(s0)
    80000bc0:	639c                	ld	a5,0(a5)
    80000bc2:	fef43023          	sd	a5,-32(s0)
    80000bc6:	fe043783          	ld	a5,-32(s0)
    80000bca:	e79d                	bnez	a5,80000bf8 <printf+0x1d4>
        s = "(null)";
    80000bcc:	0000a797          	auipc	a5,0xa
    80000bd0:	44c78793          	addi	a5,a5,1100 # 8000b018 <etext+0x18>
    80000bd4:	fef43023          	sd	a5,-32(s0)
      for(; *s; s++)
    80000bd8:	a005                	j	80000bf8 <printf+0x1d4>
        consputc(*s);
    80000bda:	fe043783          	ld	a5,-32(s0)
    80000bde:	0007c783          	lbu	a5,0(a5)
    80000be2:	2781                	sext.w	a5,a5
    80000be4:	853e                	mv	a0,a5
    80000be6:	fffff097          	auipc	ra,0xfffff
    80000bea:	78e080e7          	jalr	1934(ra) # 80000374 <consputc>
      for(; *s; s++)
    80000bee:	fe043783          	ld	a5,-32(s0)
    80000bf2:	0785                	addi	a5,a5,1
    80000bf4:	fef43023          	sd	a5,-32(s0)
    80000bf8:	fe043783          	ld	a5,-32(s0)
    80000bfc:	0007c783          	lbu	a5,0(a5)
    80000c00:	ffe9                	bnez	a5,80000bda <printf+0x1b6>
      break;
    80000c02:	a035                	j	80000c2e <printf+0x20a>
    case '%':
      consputc('%');
    80000c04:	02500513          	li	a0,37
    80000c08:	fffff097          	auipc	ra,0xfffff
    80000c0c:	76c080e7          	jalr	1900(ra) # 80000374 <consputc>
      break;
    80000c10:	a839                	j	80000c2e <printf+0x20a>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
    80000c12:	02500513          	li	a0,37
    80000c16:	fffff097          	auipc	ra,0xfffff
    80000c1a:	75e080e7          	jalr	1886(ra) # 80000374 <consputc>
      consputc(c);
    80000c1e:	fd842783          	lw	a5,-40(s0)
    80000c22:	853e                	mv	a0,a5
    80000c24:	fffff097          	auipc	ra,0xfffff
    80000c28:	750080e7          	jalr	1872(ra) # 80000374 <consputc>
      break;
    80000c2c:	0001                	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000c2e:	fec42783          	lw	a5,-20(s0)
    80000c32:	2785                	addiw	a5,a5,1
    80000c34:	fef42623          	sw	a5,-20(s0)
    80000c38:	fec42783          	lw	a5,-20(s0)
    80000c3c:	fc843703          	ld	a4,-56(s0)
    80000c40:	97ba                	add	a5,a5,a4
    80000c42:	0007c783          	lbu	a5,0(a5)
    80000c46:	fcf42c23          	sw	a5,-40(s0)
    80000c4a:	fd842783          	lw	a5,-40(s0)
    80000c4e:	2781                	sext.w	a5,a5
    80000c50:	e40794e3          	bnez	a5,80000a98 <printf+0x74>
    80000c54:	a011                	j	80000c58 <printf+0x234>
      break;
    80000c56:	0001                	nop
    }
  }

  if(locking)
    80000c58:	fdc42783          	lw	a5,-36(s0)
    80000c5c:	2781                	sext.w	a5,a5
    80000c5e:	cb89                	beqz	a5,80000c70 <printf+0x24c>
    release(&pr.lock);
    80000c60:	00013517          	auipc	a0,0x13
    80000c64:	5b850513          	addi	a0,a0,1464 # 80014218 <pr>
    80000c68:	00000097          	auipc	ra,0x0
    80000c6c:	666080e7          	jalr	1638(ra) # 800012ce <release>
}
    80000c70:	0001                	nop
    80000c72:	70e2                	ld	ra,56(sp)
    80000c74:	7442                	ld	s0,48(sp)
    80000c76:	6109                	addi	sp,sp,128
    80000c78:	8082                	ret

0000000080000c7a <panic>:

void
panic(char *s)
{
    80000c7a:	1101                	addi	sp,sp,-32
    80000c7c:	ec06                	sd	ra,24(sp)
    80000c7e:	e822                	sd	s0,16(sp)
    80000c80:	1000                	addi	s0,sp,32
    80000c82:	fea43423          	sd	a0,-24(s0)
  pr.locking = 0;
    80000c86:	00013797          	auipc	a5,0x13
    80000c8a:	59278793          	addi	a5,a5,1426 # 80014218 <pr>
    80000c8e:	0007ac23          	sw	zero,24(a5)
  printf("panic: ");
    80000c92:	0000a517          	auipc	a0,0xa
    80000c96:	38e50513          	addi	a0,a0,910 # 8000b020 <etext+0x20>
    80000c9a:	00000097          	auipc	ra,0x0
    80000c9e:	d8a080e7          	jalr	-630(ra) # 80000a24 <printf>
  printf(s);
    80000ca2:	fe843503          	ld	a0,-24(s0)
    80000ca6:	00000097          	auipc	ra,0x0
    80000caa:	d7e080e7          	jalr	-642(ra) # 80000a24 <printf>
  printf("\n");
    80000cae:	0000a517          	auipc	a0,0xa
    80000cb2:	37a50513          	addi	a0,a0,890 # 8000b028 <etext+0x28>
    80000cb6:	00000097          	auipc	ra,0x0
    80000cba:	d6e080e7          	jalr	-658(ra) # 80000a24 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80000cbe:	0000b797          	auipc	a5,0xb
    80000cc2:	34278793          	addi	a5,a5,834 # 8000c000 <panicked>
    80000cc6:	4705                	li	a4,1
    80000cc8:	c398                	sw	a4,0(a5)
  for(;;)
    80000cca:	a001                	j	80000cca <panic+0x50>

0000000080000ccc <printfinit>:
    ;
}

void
printfinit(void)
{
    80000ccc:	1141                	addi	sp,sp,-16
    80000cce:	e406                	sd	ra,8(sp)
    80000cd0:	e022                	sd	s0,0(sp)
    80000cd2:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80000cd4:	0000a597          	auipc	a1,0xa
    80000cd8:	35c58593          	addi	a1,a1,860 # 8000b030 <etext+0x30>
    80000cdc:	00013517          	auipc	a0,0x13
    80000ce0:	53c50513          	addi	a0,a0,1340 # 80014218 <pr>
    80000ce4:	00000097          	auipc	ra,0x0
    80000ce8:	556080e7          	jalr	1366(ra) # 8000123a <initlock>
  pr.locking = 1;
    80000cec:	00013797          	auipc	a5,0x13
    80000cf0:	52c78793          	addi	a5,a5,1324 # 80014218 <pr>
    80000cf4:	4705                	li	a4,1
    80000cf6:	cf98                	sw	a4,24(a5)
}
    80000cf8:	0001                	nop
    80000cfa:	60a2                	ld	ra,8(sp)
    80000cfc:	6402                	ld	s0,0(sp)
    80000cfe:	0141                	addi	sp,sp,16
    80000d00:	8082                	ret

0000000080000d02 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80000d02:	1141                	addi	sp,sp,-16
    80000d04:	e406                	sd	ra,8(sp)
    80000d06:	e022                	sd	s0,0(sp)
    80000d08:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80000d0a:	100007b7          	lui	a5,0x10000
    80000d0e:	0785                	addi	a5,a5,1
    80000d10:	00078023          	sb	zero,0(a5) # 10000000 <_entry-0x70000000>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80000d14:	100007b7          	lui	a5,0x10000
    80000d18:	078d                	addi	a5,a5,3
    80000d1a:	f8000713          	li	a4,-128
    80000d1e:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80000d22:	100007b7          	lui	a5,0x10000
    80000d26:	470d                	li	a4,3
    80000d28:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80000d2c:	100007b7          	lui	a5,0x10000
    80000d30:	0785                	addi	a5,a5,1
    80000d32:	00078023          	sb	zero,0(a5) # 10000000 <_entry-0x70000000>

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80000d36:	100007b7          	lui	a5,0x10000
    80000d3a:	078d                	addi	a5,a5,3
    80000d3c:	470d                	li	a4,3
    80000d3e:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80000d42:	100007b7          	lui	a5,0x10000
    80000d46:	0789                	addi	a5,a5,2
    80000d48:	471d                	li	a4,7
    80000d4a:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80000d4e:	100007b7          	lui	a5,0x10000
    80000d52:	0785                	addi	a5,a5,1
    80000d54:	470d                	li	a4,3
    80000d56:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  initlock(&uart_tx_lock, "uart");
    80000d5a:	0000a597          	auipc	a1,0xa
    80000d5e:	2de58593          	addi	a1,a1,734 # 8000b038 <etext+0x38>
    80000d62:	00013517          	auipc	a0,0x13
    80000d66:	4d650513          	addi	a0,a0,1238 # 80014238 <uart_tx_lock>
    80000d6a:	00000097          	auipc	ra,0x0
    80000d6e:	4d0080e7          	jalr	1232(ra) # 8000123a <initlock>
}
    80000d72:	0001                	nop
    80000d74:	60a2                	ld	ra,8(sp)
    80000d76:	6402                	ld	s0,0(sp)
    80000d78:	0141                	addi	sp,sp,16
    80000d7a:	8082                	ret

0000000080000d7c <uartputc>:
// because it may block, it can't be called
// from interrupts; it's only suitable for use
// by write().
void
uartputc(int c)
{
    80000d7c:	1101                	addi	sp,sp,-32
    80000d7e:	ec06                	sd	ra,24(sp)
    80000d80:	e822                	sd	s0,16(sp)
    80000d82:	1000                	addi	s0,sp,32
    80000d84:	87aa                	mv	a5,a0
    80000d86:	fef42623          	sw	a5,-20(s0)
  acquire(&uart_tx_lock);
    80000d8a:	00013517          	auipc	a0,0x13
    80000d8e:	4ae50513          	addi	a0,a0,1198 # 80014238 <uart_tx_lock>
    80000d92:	00000097          	auipc	ra,0x0
    80000d96:	4d8080e7          	jalr	1240(ra) # 8000126a <acquire>

  if(panicked){
    80000d9a:	0000b797          	auipc	a5,0xb
    80000d9e:	26678793          	addi	a5,a5,614 # 8000c000 <panicked>
    80000da2:	439c                	lw	a5,0(a5)
    80000da4:	2781                	sext.w	a5,a5
    80000da6:	c391                	beqz	a5,80000daa <uartputc+0x2e>
    for(;;)
    80000da8:	a001                	j	80000da8 <uartputc+0x2c>
      ;
  }

  while(1){
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000daa:	0000b797          	auipc	a5,0xb
    80000dae:	26678793          	addi	a5,a5,614 # 8000c010 <uart_tx_r>
    80000db2:	639c                	ld	a5,0(a5)
    80000db4:	02078713          	addi	a4,a5,32
    80000db8:	0000b797          	auipc	a5,0xb
    80000dbc:	25078793          	addi	a5,a5,592 # 8000c008 <uart_tx_w>
    80000dc0:	639c                	ld	a5,0(a5)
    80000dc2:	00f71f63          	bne	a4,a5,80000de0 <uartputc+0x64>
      // buffer is full.
      // wait for uartstart() to open up space in the buffer.
      sleep(&uart_tx_r, &uart_tx_lock);
    80000dc6:	00013597          	auipc	a1,0x13
    80000dca:	47258593          	addi	a1,a1,1138 # 80014238 <uart_tx_lock>
    80000dce:	0000b517          	auipc	a0,0xb
    80000dd2:	24250513          	addi	a0,a0,578 # 8000c010 <uart_tx_r>
    80000dd6:	00003097          	auipc	ra,0x3
    80000dda:	b1e080e7          	jalr	-1250(ra) # 800038f4 <sleep>
    80000dde:	b7f1                	j	80000daa <uartputc+0x2e>
    } else {
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80000de0:	0000b797          	auipc	a5,0xb
    80000de4:	22878793          	addi	a5,a5,552 # 8000c008 <uart_tx_w>
    80000de8:	639c                	ld	a5,0(a5)
    80000dea:	8bfd                	andi	a5,a5,31
    80000dec:	fec42703          	lw	a4,-20(s0)
    80000df0:	0ff77713          	zext.b	a4,a4
    80000df4:	00013697          	auipc	a3,0x13
    80000df8:	45c68693          	addi	a3,a3,1116 # 80014250 <uart_tx_buf>
    80000dfc:	97b6                	add	a5,a5,a3
    80000dfe:	00e78023          	sb	a4,0(a5)
      uart_tx_w += 1;
    80000e02:	0000b797          	auipc	a5,0xb
    80000e06:	20678793          	addi	a5,a5,518 # 8000c008 <uart_tx_w>
    80000e0a:	639c                	ld	a5,0(a5)
    80000e0c:	00178713          	addi	a4,a5,1
    80000e10:	0000b797          	auipc	a5,0xb
    80000e14:	1f878793          	addi	a5,a5,504 # 8000c008 <uart_tx_w>
    80000e18:	e398                	sd	a4,0(a5)
      uartstart();
    80000e1a:	00000097          	auipc	ra,0x0
    80000e1e:	084080e7          	jalr	132(ra) # 80000e9e <uartstart>
      release(&uart_tx_lock);
    80000e22:	00013517          	auipc	a0,0x13
    80000e26:	41650513          	addi	a0,a0,1046 # 80014238 <uart_tx_lock>
    80000e2a:	00000097          	auipc	ra,0x0
    80000e2e:	4a4080e7          	jalr	1188(ra) # 800012ce <release>
      return;
    80000e32:	0001                	nop
    }
  }
}
    80000e34:	60e2                	ld	ra,24(sp)
    80000e36:	6442                	ld	s0,16(sp)
    80000e38:	6105                	addi	sp,sp,32
    80000e3a:	8082                	ret

0000000080000e3c <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80000e3c:	1101                	addi	sp,sp,-32
    80000e3e:	ec06                	sd	ra,24(sp)
    80000e40:	e822                	sd	s0,16(sp)
    80000e42:	1000                	addi	s0,sp,32
    80000e44:	87aa                	mv	a5,a0
    80000e46:	fef42623          	sw	a5,-20(s0)
  push_off();
    80000e4a:	00000097          	auipc	ra,0x0
    80000e4e:	51e080e7          	jalr	1310(ra) # 80001368 <push_off>

  if(panicked){
    80000e52:	0000b797          	auipc	a5,0xb
    80000e56:	1ae78793          	addi	a5,a5,430 # 8000c000 <panicked>
    80000e5a:	439c                	lw	a5,0(a5)
    80000e5c:	2781                	sext.w	a5,a5
    80000e5e:	c391                	beqz	a5,80000e62 <uartputc_sync+0x26>
    for(;;)
    80000e60:	a001                	j	80000e60 <uartputc_sync+0x24>
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000e62:	0001                	nop
    80000e64:	100007b7          	lui	a5,0x10000
    80000e68:	0795                	addi	a5,a5,5
    80000e6a:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000e6e:	0ff7f793          	zext.b	a5,a5
    80000e72:	2781                	sext.w	a5,a5
    80000e74:	0207f793          	andi	a5,a5,32
    80000e78:	2781                	sext.w	a5,a5
    80000e7a:	d7ed                	beqz	a5,80000e64 <uartputc_sync+0x28>
    ;
  WriteReg(THR, c);
    80000e7c:	100007b7          	lui	a5,0x10000
    80000e80:	fec42703          	lw	a4,-20(s0)
    80000e84:	0ff77713          	zext.b	a4,a4
    80000e88:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80000e8c:	00000097          	auipc	ra,0x0
    80000e90:	534080e7          	jalr	1332(ra) # 800013c0 <pop_off>
}
    80000e94:	0001                	nop
    80000e96:	60e2                	ld	ra,24(sp)
    80000e98:	6442                	ld	s0,16(sp)
    80000e9a:	6105                	addi	sp,sp,32
    80000e9c:	8082                	ret

0000000080000e9e <uartstart>:
// in the transmit buffer, send it.
// caller must hold uart_tx_lock.
// called from both the top- and bottom-half.
void
uartstart()
{
    80000e9e:	1101                	addi	sp,sp,-32
    80000ea0:	ec06                	sd	ra,24(sp)
    80000ea2:	e822                	sd	s0,16(sp)
    80000ea4:	1000                	addi	s0,sp,32
  while(1){
    if(uart_tx_w == uart_tx_r){
    80000ea6:	0000b797          	auipc	a5,0xb
    80000eaa:	16278793          	addi	a5,a5,354 # 8000c008 <uart_tx_w>
    80000eae:	6398                	ld	a4,0(a5)
    80000eb0:	0000b797          	auipc	a5,0xb
    80000eb4:	16078793          	addi	a5,a5,352 # 8000c010 <uart_tx_r>
    80000eb8:	639c                	ld	a5,0(a5)
    80000eba:	06f70a63          	beq	a4,a5,80000f2e <uartstart+0x90>
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000ebe:	100007b7          	lui	a5,0x10000
    80000ec2:	0795                	addi	a5,a5,5
    80000ec4:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000ec8:	0ff7f793          	zext.b	a5,a5
    80000ecc:	2781                	sext.w	a5,a5
    80000ece:	0207f793          	andi	a5,a5,32
    80000ed2:	2781                	sext.w	a5,a5
    80000ed4:	cfb9                	beqz	a5,80000f32 <uartstart+0x94>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80000ed6:	0000b797          	auipc	a5,0xb
    80000eda:	13a78793          	addi	a5,a5,314 # 8000c010 <uart_tx_r>
    80000ede:	639c                	ld	a5,0(a5)
    80000ee0:	8bfd                	andi	a5,a5,31
    80000ee2:	00013717          	auipc	a4,0x13
    80000ee6:	36e70713          	addi	a4,a4,878 # 80014250 <uart_tx_buf>
    80000eea:	97ba                	add	a5,a5,a4
    80000eec:	0007c783          	lbu	a5,0(a5)
    80000ef0:	fef42623          	sw	a5,-20(s0)
    uart_tx_r += 1;
    80000ef4:	0000b797          	auipc	a5,0xb
    80000ef8:	11c78793          	addi	a5,a5,284 # 8000c010 <uart_tx_r>
    80000efc:	639c                	ld	a5,0(a5)
    80000efe:	00178713          	addi	a4,a5,1
    80000f02:	0000b797          	auipc	a5,0xb
    80000f06:	10e78793          	addi	a5,a5,270 # 8000c010 <uart_tx_r>
    80000f0a:	e398                	sd	a4,0(a5)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80000f0c:	0000b517          	auipc	a0,0xb
    80000f10:	10450513          	addi	a0,a0,260 # 8000c010 <uart_tx_r>
    80000f14:	00003097          	auipc	ra,0x3
    80000f18:	a5c080e7          	jalr	-1444(ra) # 80003970 <wakeup>
    
    WriteReg(THR, c);
    80000f1c:	100007b7          	lui	a5,0x10000
    80000f20:	fec42703          	lw	a4,-20(s0)
    80000f24:	0ff77713          	zext.b	a4,a4
    80000f28:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>
  while(1){
    80000f2c:	bfad                	j	80000ea6 <uartstart+0x8>
      return;
    80000f2e:	0001                	nop
    80000f30:	a011                	j	80000f34 <uartstart+0x96>
      return;
    80000f32:	0001                	nop
  }
}
    80000f34:	60e2                	ld	ra,24(sp)
    80000f36:	6442                	ld	s0,16(sp)
    80000f38:	6105                	addi	sp,sp,32
    80000f3a:	8082                	ret

0000000080000f3c <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80000f3c:	1141                	addi	sp,sp,-16
    80000f3e:	e422                	sd	s0,8(sp)
    80000f40:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000f42:	100007b7          	lui	a5,0x10000
    80000f46:	0795                	addi	a5,a5,5
    80000f48:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000f4c:	0ff7f793          	zext.b	a5,a5
    80000f50:	2781                	sext.w	a5,a5
    80000f52:	8b85                	andi	a5,a5,1
    80000f54:	2781                	sext.w	a5,a5
    80000f56:	cb89                	beqz	a5,80000f68 <uartgetc+0x2c>
    // input data is ready.
    return ReadReg(RHR);
    80000f58:	100007b7          	lui	a5,0x10000
    80000f5c:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000f60:	0ff7f793          	zext.b	a5,a5
    80000f64:	2781                	sext.w	a5,a5
    80000f66:	a011                	j	80000f6a <uartgetc+0x2e>
  } else {
    return -1;
    80000f68:	57fd                	li	a5,-1
  }
}
    80000f6a:	853e                	mv	a0,a5
    80000f6c:	6422                	ld	s0,8(sp)
    80000f6e:	0141                	addi	sp,sp,16
    80000f70:	8082                	ret

0000000080000f72 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    80000f72:	1101                	addi	sp,sp,-32
    80000f74:	ec06                	sd	ra,24(sp)
    80000f76:	e822                	sd	s0,16(sp)
    80000f78:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    80000f7a:	00000097          	auipc	ra,0x0
    80000f7e:	fc2080e7          	jalr	-62(ra) # 80000f3c <uartgetc>
    80000f82:	87aa                	mv	a5,a0
    80000f84:	fef42623          	sw	a5,-20(s0)
    if(c == -1)
    80000f88:	fec42783          	lw	a5,-20(s0)
    80000f8c:	0007871b          	sext.w	a4,a5
    80000f90:	57fd                	li	a5,-1
    80000f92:	00f70a63          	beq	a4,a5,80000fa6 <uartintr+0x34>
      break;
    consoleintr(c);
    80000f96:	fec42783          	lw	a5,-20(s0)
    80000f9a:	853e                	mv	a0,a5
    80000f9c:	fffff097          	auipc	ra,0xfffff
    80000fa0:	650080e7          	jalr	1616(ra) # 800005ec <consoleintr>
  while(1){
    80000fa4:	bfd9                	j	80000f7a <uartintr+0x8>
      break;
    80000fa6:	0001                	nop
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80000fa8:	00013517          	auipc	a0,0x13
    80000fac:	29050513          	addi	a0,a0,656 # 80014238 <uart_tx_lock>
    80000fb0:	00000097          	auipc	ra,0x0
    80000fb4:	2ba080e7          	jalr	698(ra) # 8000126a <acquire>
  uartstart();
    80000fb8:	00000097          	auipc	ra,0x0
    80000fbc:	ee6080e7          	jalr	-282(ra) # 80000e9e <uartstart>
  release(&uart_tx_lock);
    80000fc0:	00013517          	auipc	a0,0x13
    80000fc4:	27850513          	addi	a0,a0,632 # 80014238 <uart_tx_lock>
    80000fc8:	00000097          	auipc	ra,0x0
    80000fcc:	306080e7          	jalr	774(ra) # 800012ce <release>
}
    80000fd0:	0001                	nop
    80000fd2:	60e2                	ld	ra,24(sp)
    80000fd4:	6442                	ld	s0,16(sp)
    80000fd6:	6105                	addi	sp,sp,32
    80000fd8:	8082                	ret

0000000080000fda <kinit>:
  struct run *freelist;
} kmem;

void
kinit()
{
    80000fda:	1141                	addi	sp,sp,-16
    80000fdc:	e406                	sd	ra,8(sp)
    80000fde:	e022                	sd	s0,0(sp)
    80000fe0:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000fe2:	0000a597          	auipc	a1,0xa
    80000fe6:	05e58593          	addi	a1,a1,94 # 8000b040 <etext+0x40>
    80000fea:	00013517          	auipc	a0,0x13
    80000fee:	28650513          	addi	a0,a0,646 # 80014270 <kmem>
    80000ff2:	00000097          	auipc	ra,0x0
    80000ff6:	248080e7          	jalr	584(ra) # 8000123a <initlock>
  freerange(end, (void*)PHYSTOP);
    80000ffa:	47c5                	li	a5,17
    80000ffc:	01b79593          	slli	a1,a5,0x1b
    80001000:	004a8517          	auipc	a0,0x4a8
    80001004:	00050513          	mv	a0,a0
    80001008:	00000097          	auipc	ra,0x0
    8000100c:	012080e7          	jalr	18(ra) # 8000101a <freerange>
}
    80001010:	0001                	nop
    80001012:	60a2                	ld	ra,8(sp)
    80001014:	6402                	ld	s0,0(sp)
    80001016:	0141                	addi	sp,sp,16
    80001018:	8082                	ret

000000008000101a <freerange>:

void
freerange(void *pa_start, void *pa_end)
{
    8000101a:	7179                	addi	sp,sp,-48
    8000101c:	f406                	sd	ra,40(sp)
    8000101e:	f022                	sd	s0,32(sp)
    80001020:	1800                	addi	s0,sp,48
    80001022:	fca43c23          	sd	a0,-40(s0)
    80001026:	fcb43823          	sd	a1,-48(s0)
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
    8000102a:	fd843703          	ld	a4,-40(s0)
    8000102e:	6785                	lui	a5,0x1
    80001030:	17fd                	addi	a5,a5,-1
    80001032:	973e                	add	a4,a4,a5
    80001034:	77fd                	lui	a5,0xfffff
    80001036:	8ff9                	and	a5,a5,a4
    80001038:	fef43423          	sd	a5,-24(s0)
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    8000103c:	a829                	j	80001056 <freerange+0x3c>
    kfree(p);
    8000103e:	fe843503          	ld	a0,-24(s0)
    80001042:	00000097          	auipc	ra,0x0
    80001046:	030080e7          	jalr	48(ra) # 80001072 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    8000104a:	fe843703          	ld	a4,-24(s0)
    8000104e:	6785                	lui	a5,0x1
    80001050:	97ba                	add	a5,a5,a4
    80001052:	fef43423          	sd	a5,-24(s0)
    80001056:	fe843703          	ld	a4,-24(s0)
    8000105a:	6785                	lui	a5,0x1
    8000105c:	97ba                	add	a5,a5,a4
    8000105e:	fd043703          	ld	a4,-48(s0)
    80001062:	fcf77ee3          	bgeu	a4,a5,8000103e <freerange+0x24>
}
    80001066:	0001                	nop
    80001068:	0001                	nop
    8000106a:	70a2                	ld	ra,40(sp)
    8000106c:	7402                	ld	s0,32(sp)
    8000106e:	6145                	addi	sp,sp,48
    80001070:	8082                	ret

0000000080001072 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80001072:	7179                	addi	sp,sp,-48
    80001074:	f406                	sd	ra,40(sp)
    80001076:	f022                	sd	s0,32(sp)
    80001078:	1800                	addi	s0,sp,48
    8000107a:	fca43c23          	sd	a0,-40(s0)
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    8000107e:	fd843703          	ld	a4,-40(s0)
    80001082:	6785                	lui	a5,0x1
    80001084:	17fd                	addi	a5,a5,-1
    80001086:	8ff9                	and	a5,a5,a4
    80001088:	ef99                	bnez	a5,800010a6 <kfree+0x34>
    8000108a:	fd843703          	ld	a4,-40(s0)
    8000108e:	004a8797          	auipc	a5,0x4a8
    80001092:	f7278793          	addi	a5,a5,-142 # 804a9000 <end>
    80001096:	00f76863          	bltu	a4,a5,800010a6 <kfree+0x34>
    8000109a:	fd843703          	ld	a4,-40(s0)
    8000109e:	47c5                	li	a5,17
    800010a0:	07ee                	slli	a5,a5,0x1b
    800010a2:	00f76a63          	bltu	a4,a5,800010b6 <kfree+0x44>
    panic("kfree");
    800010a6:	0000a517          	auipc	a0,0xa
    800010aa:	fa250513          	addi	a0,a0,-94 # 8000b048 <etext+0x48>
    800010ae:	00000097          	auipc	ra,0x0
    800010b2:	bcc080e7          	jalr	-1076(ra) # 80000c7a <panic>

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    800010b6:	6605                	lui	a2,0x1
    800010b8:	4585                	li	a1,1
    800010ba:	fd843503          	ld	a0,-40(s0)
    800010be:	00000097          	auipc	ra,0x0
    800010c2:	380080e7          	jalr	896(ra) # 8000143e <memset>

  r = (struct run*)pa;
    800010c6:	fd843783          	ld	a5,-40(s0)
    800010ca:	fef43423          	sd	a5,-24(s0)

  acquire(&kmem.lock);
    800010ce:	00013517          	auipc	a0,0x13
    800010d2:	1a250513          	addi	a0,a0,418 # 80014270 <kmem>
    800010d6:	00000097          	auipc	ra,0x0
    800010da:	194080e7          	jalr	404(ra) # 8000126a <acquire>
  r->next = kmem.freelist;
    800010de:	00013797          	auipc	a5,0x13
    800010e2:	19278793          	addi	a5,a5,402 # 80014270 <kmem>
    800010e6:	6f98                	ld	a4,24(a5)
    800010e8:	fe843783          	ld	a5,-24(s0)
    800010ec:	e398                	sd	a4,0(a5)
  kmem.freelist = r;
    800010ee:	00013797          	auipc	a5,0x13
    800010f2:	18278793          	addi	a5,a5,386 # 80014270 <kmem>
    800010f6:	fe843703          	ld	a4,-24(s0)
    800010fa:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    800010fc:	00013517          	auipc	a0,0x13
    80001100:	17450513          	addi	a0,a0,372 # 80014270 <kmem>
    80001104:	00000097          	auipc	ra,0x0
    80001108:	1ca080e7          	jalr	458(ra) # 800012ce <release>
}
    8000110c:	0001                	nop
    8000110e:	70a2                	ld	ra,40(sp)
    80001110:	7402                	ld	s0,32(sp)
    80001112:	6145                	addi	sp,sp,48
    80001114:	8082                	ret

0000000080001116 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80001116:	1101                	addi	sp,sp,-32
    80001118:	ec06                	sd	ra,24(sp)
    8000111a:	e822                	sd	s0,16(sp)
    8000111c:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    8000111e:	00013517          	auipc	a0,0x13
    80001122:	15250513          	addi	a0,a0,338 # 80014270 <kmem>
    80001126:	00000097          	auipc	ra,0x0
    8000112a:	144080e7          	jalr	324(ra) # 8000126a <acquire>
  r = kmem.freelist;
    8000112e:	00013797          	auipc	a5,0x13
    80001132:	14278793          	addi	a5,a5,322 # 80014270 <kmem>
    80001136:	6f9c                	ld	a5,24(a5)
    80001138:	fef43423          	sd	a5,-24(s0)
  if(r)
    8000113c:	fe843783          	ld	a5,-24(s0)
    80001140:	cb89                	beqz	a5,80001152 <kalloc+0x3c>
    kmem.freelist = r->next;
    80001142:	fe843783          	ld	a5,-24(s0)
    80001146:	6398                	ld	a4,0(a5)
    80001148:	00013797          	auipc	a5,0x13
    8000114c:	12878793          	addi	a5,a5,296 # 80014270 <kmem>
    80001150:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    80001152:	00013517          	auipc	a0,0x13
    80001156:	11e50513          	addi	a0,a0,286 # 80014270 <kmem>
    8000115a:	00000097          	auipc	ra,0x0
    8000115e:	174080e7          	jalr	372(ra) # 800012ce <release>

  if(r)
    80001162:	fe843783          	ld	a5,-24(s0)
    80001166:	cb89                	beqz	a5,80001178 <kalloc+0x62>
    memset((char*)r, 5, PGSIZE); // fill with junk
    80001168:	6605                	lui	a2,0x1
    8000116a:	4595                	li	a1,5
    8000116c:	fe843503          	ld	a0,-24(s0)
    80001170:	00000097          	auipc	ra,0x0
    80001174:	2ce080e7          	jalr	718(ra) # 8000143e <memset>
  return (void*)r;
    80001178:	fe843783          	ld	a5,-24(s0)
}
    8000117c:	853e                	mv	a0,a5
    8000117e:	60e2                	ld	ra,24(sp)
    80001180:	6442                	ld	s0,16(sp)
    80001182:	6105                	addi	sp,sp,32
    80001184:	8082                	ret

0000000080001186 <r_sstatus>:
{
    80001186:	1101                	addi	sp,sp,-32
    80001188:	ec22                	sd	s0,24(sp)
    8000118a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000118c:	100027f3          	csrr	a5,sstatus
    80001190:	fef43423          	sd	a5,-24(s0)
  return x;
    80001194:	fe843783          	ld	a5,-24(s0)
}
    80001198:	853e                	mv	a0,a5
    8000119a:	6462                	ld	s0,24(sp)
    8000119c:	6105                	addi	sp,sp,32
    8000119e:	8082                	ret

00000000800011a0 <w_sstatus>:
{
    800011a0:	1101                	addi	sp,sp,-32
    800011a2:	ec22                	sd	s0,24(sp)
    800011a4:	1000                	addi	s0,sp,32
    800011a6:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800011aa:	fe843783          	ld	a5,-24(s0)
    800011ae:	10079073          	csrw	sstatus,a5
}
    800011b2:	0001                	nop
    800011b4:	6462                	ld	s0,24(sp)
    800011b6:	6105                	addi	sp,sp,32
    800011b8:	8082                	ret

00000000800011ba <intr_on>:
{
    800011ba:	1141                	addi	sp,sp,-16
    800011bc:	e406                	sd	ra,8(sp)
    800011be:	e022                	sd	s0,0(sp)
    800011c0:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800011c2:	00000097          	auipc	ra,0x0
    800011c6:	fc4080e7          	jalr	-60(ra) # 80001186 <r_sstatus>
    800011ca:	87aa                	mv	a5,a0
    800011cc:	0027e793          	ori	a5,a5,2
    800011d0:	853e                	mv	a0,a5
    800011d2:	00000097          	auipc	ra,0x0
    800011d6:	fce080e7          	jalr	-50(ra) # 800011a0 <w_sstatus>
}
    800011da:	0001                	nop
    800011dc:	60a2                	ld	ra,8(sp)
    800011de:	6402                	ld	s0,0(sp)
    800011e0:	0141                	addi	sp,sp,16
    800011e2:	8082                	ret

00000000800011e4 <intr_off>:
{
    800011e4:	1141                	addi	sp,sp,-16
    800011e6:	e406                	sd	ra,8(sp)
    800011e8:	e022                	sd	s0,0(sp)
    800011ea:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800011ec:	00000097          	auipc	ra,0x0
    800011f0:	f9a080e7          	jalr	-102(ra) # 80001186 <r_sstatus>
    800011f4:	87aa                	mv	a5,a0
    800011f6:	9bf5                	andi	a5,a5,-3
    800011f8:	853e                	mv	a0,a5
    800011fa:	00000097          	auipc	ra,0x0
    800011fe:	fa6080e7          	jalr	-90(ra) # 800011a0 <w_sstatus>
}
    80001202:	0001                	nop
    80001204:	60a2                	ld	ra,8(sp)
    80001206:	6402                	ld	s0,0(sp)
    80001208:	0141                	addi	sp,sp,16
    8000120a:	8082                	ret

000000008000120c <intr_get>:
{
    8000120c:	1101                	addi	sp,sp,-32
    8000120e:	ec06                	sd	ra,24(sp)
    80001210:	e822                	sd	s0,16(sp)
    80001212:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    80001214:	00000097          	auipc	ra,0x0
    80001218:	f72080e7          	jalr	-142(ra) # 80001186 <r_sstatus>
    8000121c:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    80001220:	fe843783          	ld	a5,-24(s0)
    80001224:	8b89                	andi	a5,a5,2
    80001226:	00f037b3          	snez	a5,a5
    8000122a:	0ff7f793          	zext.b	a5,a5
    8000122e:	2781                	sext.w	a5,a5
}
    80001230:	853e                	mv	a0,a5
    80001232:	60e2                	ld	ra,24(sp)
    80001234:	6442                	ld	s0,16(sp)
    80001236:	6105                	addi	sp,sp,32
    80001238:	8082                	ret

000000008000123a <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    8000123a:	1101                	addi	sp,sp,-32
    8000123c:	ec22                	sd	s0,24(sp)
    8000123e:	1000                	addi	s0,sp,32
    80001240:	fea43423          	sd	a0,-24(s0)
    80001244:	feb43023          	sd	a1,-32(s0)
  lk->name = name;
    80001248:	fe843783          	ld	a5,-24(s0)
    8000124c:	fe043703          	ld	a4,-32(s0)
    80001250:	e798                	sd	a4,8(a5)
  lk->locked = 0;
    80001252:	fe843783          	ld	a5,-24(s0)
    80001256:	0007a023          	sw	zero,0(a5)
  lk->cpu = 0;
    8000125a:	fe843783          	ld	a5,-24(s0)
    8000125e:	0007b823          	sd	zero,16(a5)
}
    80001262:	0001                	nop
    80001264:	6462                	ld	s0,24(sp)
    80001266:	6105                	addi	sp,sp,32
    80001268:	8082                	ret

000000008000126a <acquire>:

// Acquire the lock.
// Loops (spins) until the lock is acquired.
void
acquire(struct spinlock *lk)
{
    8000126a:	1101                	addi	sp,sp,-32
    8000126c:	ec06                	sd	ra,24(sp)
    8000126e:	e822                	sd	s0,16(sp)
    80001270:	1000                	addi	s0,sp,32
    80001272:	fea43423          	sd	a0,-24(s0)
  push_off(); // disable interrupts to avoid deadlock.
    80001276:	00000097          	auipc	ra,0x0
    8000127a:	0f2080e7          	jalr	242(ra) # 80001368 <push_off>
  if(holding(lk))
    8000127e:	fe843503          	ld	a0,-24(s0)
    80001282:	00000097          	auipc	ra,0x0
    80001286:	0a2080e7          	jalr	162(ra) # 80001324 <holding>
    8000128a:	87aa                	mv	a5,a0
    8000128c:	cb89                	beqz	a5,8000129e <acquire+0x34>
    panic("acquire");
    8000128e:	0000a517          	auipc	a0,0xa
    80001292:	dc250513          	addi	a0,a0,-574 # 8000b050 <etext+0x50>
    80001296:	00000097          	auipc	ra,0x0
    8000129a:	9e4080e7          	jalr	-1564(ra) # 80000c7a <panic>

  // On RISC-V, sync_lock_test_and_set turns into an atomic swap:
  //   a5 = 1
  //   s1 = &lk->locked
  //   amoswap.w.aq a5, a5, (s1)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000129e:	0001                	nop
    800012a0:	fe843783          	ld	a5,-24(s0)
    800012a4:	4705                	li	a4,1
    800012a6:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    800012aa:	0007079b          	sext.w	a5,a4
    800012ae:	fbed                	bnez	a5,800012a0 <acquire+0x36>

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen strictly after the lock is acquired.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    800012b0:	0ff0000f          	fence

  // Record info about lock acquisition for holding() and debugging.
  lk->cpu = mycpu();
    800012b4:	00001097          	auipc	ra,0x1
    800012b8:	72a080e7          	jalr	1834(ra) # 800029de <mycpu>
    800012bc:	872a                	mv	a4,a0
    800012be:	fe843783          	ld	a5,-24(s0)
    800012c2:	eb98                	sd	a4,16(a5)
}
    800012c4:	0001                	nop
    800012c6:	60e2                	ld	ra,24(sp)
    800012c8:	6442                	ld	s0,16(sp)
    800012ca:	6105                	addi	sp,sp,32
    800012cc:	8082                	ret

00000000800012ce <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
    800012ce:	1101                	addi	sp,sp,-32
    800012d0:	ec06                	sd	ra,24(sp)
    800012d2:	e822                	sd	s0,16(sp)
    800012d4:	1000                	addi	s0,sp,32
    800012d6:	fea43423          	sd	a0,-24(s0)
  if(!holding(lk))
    800012da:	fe843503          	ld	a0,-24(s0)
    800012de:	00000097          	auipc	ra,0x0
    800012e2:	046080e7          	jalr	70(ra) # 80001324 <holding>
    800012e6:	87aa                	mv	a5,a0
    800012e8:	eb89                	bnez	a5,800012fa <release+0x2c>
    panic("release");
    800012ea:	0000a517          	auipc	a0,0xa
    800012ee:	d6e50513          	addi	a0,a0,-658 # 8000b058 <etext+0x58>
    800012f2:	00000097          	auipc	ra,0x0
    800012f6:	988080e7          	jalr	-1656(ra) # 80000c7a <panic>

  lk->cpu = 0;
    800012fa:	fe843783          	ld	a5,-24(s0)
    800012fe:	0007b823          	sd	zero,16(a5)
  // past this point, to ensure that all the stores in the critical
  // section are visible to other CPUs before the lock is released,
  // and that loads in the critical section occur strictly before
  // the lock is released.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    80001302:	0ff0000f          	fence
  // implies that an assignment might be implemented with
  // multiple store instructions.
  // On RISC-V, sync_lock_release turns into an atomic swap:
  //   s1 = &lk->locked
  //   amoswap.w zero, zero, (s1)
  __sync_lock_release(&lk->locked);
    80001306:	fe843783          	ld	a5,-24(s0)
    8000130a:	0f50000f          	fence	iorw,ow
    8000130e:	0807a02f          	amoswap.w	zero,zero,(a5)

  pop_off();
    80001312:	00000097          	auipc	ra,0x0
    80001316:	0ae080e7          	jalr	174(ra) # 800013c0 <pop_off>
}
    8000131a:	0001                	nop
    8000131c:	60e2                	ld	ra,24(sp)
    8000131e:	6442                	ld	s0,16(sp)
    80001320:	6105                	addi	sp,sp,32
    80001322:	8082                	ret

0000000080001324 <holding>:

// Check whether this cpu is holding the lock.
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
    80001324:	7139                	addi	sp,sp,-64
    80001326:	fc06                	sd	ra,56(sp)
    80001328:	f822                	sd	s0,48(sp)
    8000132a:	f426                	sd	s1,40(sp)
    8000132c:	0080                	addi	s0,sp,64
    8000132e:	fca43423          	sd	a0,-56(s0)
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80001332:	fc843783          	ld	a5,-56(s0)
    80001336:	439c                	lw	a5,0(a5)
    80001338:	cf89                	beqz	a5,80001352 <holding+0x2e>
    8000133a:	fc843783          	ld	a5,-56(s0)
    8000133e:	6b84                	ld	s1,16(a5)
    80001340:	00001097          	auipc	ra,0x1
    80001344:	69e080e7          	jalr	1694(ra) # 800029de <mycpu>
    80001348:	87aa                	mv	a5,a0
    8000134a:	00f49463          	bne	s1,a5,80001352 <holding+0x2e>
    8000134e:	4785                	li	a5,1
    80001350:	a011                	j	80001354 <holding+0x30>
    80001352:	4781                	li	a5,0
    80001354:	fcf42e23          	sw	a5,-36(s0)
  return r;
    80001358:	fdc42783          	lw	a5,-36(s0)
}
    8000135c:	853e                	mv	a0,a5
    8000135e:	70e2                	ld	ra,56(sp)
    80001360:	7442                	ld	s0,48(sp)
    80001362:	74a2                	ld	s1,40(sp)
    80001364:	6121                	addi	sp,sp,64
    80001366:	8082                	ret

0000000080001368 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80001368:	1101                	addi	sp,sp,-32
    8000136a:	ec06                	sd	ra,24(sp)
    8000136c:	e822                	sd	s0,16(sp)
    8000136e:	1000                	addi	s0,sp,32
  int old = intr_get();
    80001370:	00000097          	auipc	ra,0x0
    80001374:	e9c080e7          	jalr	-356(ra) # 8000120c <intr_get>
    80001378:	87aa                	mv	a5,a0
    8000137a:	fef42623          	sw	a5,-20(s0)

  intr_off();
    8000137e:	00000097          	auipc	ra,0x0
    80001382:	e66080e7          	jalr	-410(ra) # 800011e4 <intr_off>
  if(mycpu()->noff == 0)
    80001386:	00001097          	auipc	ra,0x1
    8000138a:	658080e7          	jalr	1624(ra) # 800029de <mycpu>
    8000138e:	87aa                	mv	a5,a0
    80001390:	5fbc                	lw	a5,120(a5)
    80001392:	eb89                	bnez	a5,800013a4 <push_off+0x3c>
    mycpu()->intena = old;
    80001394:	00001097          	auipc	ra,0x1
    80001398:	64a080e7          	jalr	1610(ra) # 800029de <mycpu>
    8000139c:	872a                	mv	a4,a0
    8000139e:	fec42783          	lw	a5,-20(s0)
    800013a2:	df7c                	sw	a5,124(a4)
  mycpu()->noff += 1;
    800013a4:	00001097          	auipc	ra,0x1
    800013a8:	63a080e7          	jalr	1594(ra) # 800029de <mycpu>
    800013ac:	87aa                	mv	a5,a0
    800013ae:	5fb8                	lw	a4,120(a5)
    800013b0:	2705                	addiw	a4,a4,1
    800013b2:	2701                	sext.w	a4,a4
    800013b4:	dfb8                	sw	a4,120(a5)
}
    800013b6:	0001                	nop
    800013b8:	60e2                	ld	ra,24(sp)
    800013ba:	6442                	ld	s0,16(sp)
    800013bc:	6105                	addi	sp,sp,32
    800013be:	8082                	ret

00000000800013c0 <pop_off>:

void
pop_off(void)
{
    800013c0:	1101                	addi	sp,sp,-32
    800013c2:	ec06                	sd	ra,24(sp)
    800013c4:	e822                	sd	s0,16(sp)
    800013c6:	1000                	addi	s0,sp,32
  struct cpu *c = mycpu();
    800013c8:	00001097          	auipc	ra,0x1
    800013cc:	616080e7          	jalr	1558(ra) # 800029de <mycpu>
    800013d0:	fea43423          	sd	a0,-24(s0)
  if(intr_get())
    800013d4:	00000097          	auipc	ra,0x0
    800013d8:	e38080e7          	jalr	-456(ra) # 8000120c <intr_get>
    800013dc:	87aa                	mv	a5,a0
    800013de:	cb89                	beqz	a5,800013f0 <pop_off+0x30>
    panic("pop_off - interruptible");
    800013e0:	0000a517          	auipc	a0,0xa
    800013e4:	c8050513          	addi	a0,a0,-896 # 8000b060 <etext+0x60>
    800013e8:	00000097          	auipc	ra,0x0
    800013ec:	892080e7          	jalr	-1902(ra) # 80000c7a <panic>
  if(c->noff < 1)
    800013f0:	fe843783          	ld	a5,-24(s0)
    800013f4:	5fbc                	lw	a5,120(a5)
    800013f6:	00f04a63          	bgtz	a5,8000140a <pop_off+0x4a>
    panic("pop_off");
    800013fa:	0000a517          	auipc	a0,0xa
    800013fe:	c7e50513          	addi	a0,a0,-898 # 8000b078 <etext+0x78>
    80001402:	00000097          	auipc	ra,0x0
    80001406:	878080e7          	jalr	-1928(ra) # 80000c7a <panic>
  c->noff -= 1;
    8000140a:	fe843783          	ld	a5,-24(s0)
    8000140e:	5fbc                	lw	a5,120(a5)
    80001410:	37fd                	addiw	a5,a5,-1
    80001412:	0007871b          	sext.w	a4,a5
    80001416:	fe843783          	ld	a5,-24(s0)
    8000141a:	dfb8                	sw	a4,120(a5)
  if(c->noff == 0 && c->intena)
    8000141c:	fe843783          	ld	a5,-24(s0)
    80001420:	5fbc                	lw	a5,120(a5)
    80001422:	eb89                	bnez	a5,80001434 <pop_off+0x74>
    80001424:	fe843783          	ld	a5,-24(s0)
    80001428:	5ffc                	lw	a5,124(a5)
    8000142a:	c789                	beqz	a5,80001434 <pop_off+0x74>
    intr_on();
    8000142c:	00000097          	auipc	ra,0x0
    80001430:	d8e080e7          	jalr	-626(ra) # 800011ba <intr_on>
}
    80001434:	0001                	nop
    80001436:	60e2                	ld	ra,24(sp)
    80001438:	6442                	ld	s0,16(sp)
    8000143a:	6105                	addi	sp,sp,32
    8000143c:	8082                	ret

000000008000143e <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000143e:	7179                	addi	sp,sp,-48
    80001440:	f422                	sd	s0,40(sp)
    80001442:	1800                	addi	s0,sp,48
    80001444:	fca43c23          	sd	a0,-40(s0)
    80001448:	87ae                	mv	a5,a1
    8000144a:	8732                	mv	a4,a2
    8000144c:	fcf42a23          	sw	a5,-44(s0)
    80001450:	87ba                	mv	a5,a4
    80001452:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    80001456:	fd843783          	ld	a5,-40(s0)
    8000145a:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    8000145e:	fe042623          	sw	zero,-20(s0)
    80001462:	a00d                	j	80001484 <memset+0x46>
    cdst[i] = c;
    80001464:	fec42783          	lw	a5,-20(s0)
    80001468:	fe043703          	ld	a4,-32(s0)
    8000146c:	97ba                	add	a5,a5,a4
    8000146e:	fd442703          	lw	a4,-44(s0)
    80001472:	0ff77713          	zext.b	a4,a4
    80001476:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    8000147a:	fec42783          	lw	a5,-20(s0)
    8000147e:	2785                	addiw	a5,a5,1
    80001480:	fef42623          	sw	a5,-20(s0)
    80001484:	fec42703          	lw	a4,-20(s0)
    80001488:	fd042783          	lw	a5,-48(s0)
    8000148c:	2781                	sext.w	a5,a5
    8000148e:	fcf76be3          	bltu	a4,a5,80001464 <memset+0x26>
  }
  return dst;
    80001492:	fd843783          	ld	a5,-40(s0)
}
    80001496:	853e                	mv	a0,a5
    80001498:	7422                	ld	s0,40(sp)
    8000149a:	6145                	addi	sp,sp,48
    8000149c:	8082                	ret

000000008000149e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000149e:	7139                	addi	sp,sp,-64
    800014a0:	fc22                	sd	s0,56(sp)
    800014a2:	0080                	addi	s0,sp,64
    800014a4:	fca43c23          	sd	a0,-40(s0)
    800014a8:	fcb43823          	sd	a1,-48(s0)
    800014ac:	87b2                	mv	a5,a2
    800014ae:	fcf42623          	sw	a5,-52(s0)
  const uchar *s1, *s2;

  s1 = v1;
    800014b2:	fd843783          	ld	a5,-40(s0)
    800014b6:	fef43423          	sd	a5,-24(s0)
  s2 = v2;
    800014ba:	fd043783          	ld	a5,-48(s0)
    800014be:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    800014c2:	a0a1                	j	8000150a <memcmp+0x6c>
    if(*s1 != *s2)
    800014c4:	fe843783          	ld	a5,-24(s0)
    800014c8:	0007c703          	lbu	a4,0(a5)
    800014cc:	fe043783          	ld	a5,-32(s0)
    800014d0:	0007c783          	lbu	a5,0(a5)
    800014d4:	02f70163          	beq	a4,a5,800014f6 <memcmp+0x58>
      return *s1 - *s2;
    800014d8:	fe843783          	ld	a5,-24(s0)
    800014dc:	0007c783          	lbu	a5,0(a5)
    800014e0:	0007871b          	sext.w	a4,a5
    800014e4:	fe043783          	ld	a5,-32(s0)
    800014e8:	0007c783          	lbu	a5,0(a5)
    800014ec:	2781                	sext.w	a5,a5
    800014ee:	40f707bb          	subw	a5,a4,a5
    800014f2:	2781                	sext.w	a5,a5
    800014f4:	a01d                	j	8000151a <memcmp+0x7c>
    s1++, s2++;
    800014f6:	fe843783          	ld	a5,-24(s0)
    800014fa:	0785                	addi	a5,a5,1
    800014fc:	fef43423          	sd	a5,-24(s0)
    80001500:	fe043783          	ld	a5,-32(s0)
    80001504:	0785                	addi	a5,a5,1
    80001506:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    8000150a:	fcc42783          	lw	a5,-52(s0)
    8000150e:	fff7871b          	addiw	a4,a5,-1
    80001512:	fce42623          	sw	a4,-52(s0)
    80001516:	f7dd                	bnez	a5,800014c4 <memcmp+0x26>
  }

  return 0;
    80001518:	4781                	li	a5,0
}
    8000151a:	853e                	mv	a0,a5
    8000151c:	7462                	ld	s0,56(sp)
    8000151e:	6121                	addi	sp,sp,64
    80001520:	8082                	ret

0000000080001522 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80001522:	7139                	addi	sp,sp,-64
    80001524:	fc22                	sd	s0,56(sp)
    80001526:	0080                	addi	s0,sp,64
    80001528:	fca43c23          	sd	a0,-40(s0)
    8000152c:	fcb43823          	sd	a1,-48(s0)
    80001530:	87b2                	mv	a5,a2
    80001532:	fcf42623          	sw	a5,-52(s0)
  const char *s;
  char *d;

  if(n == 0)
    80001536:	fcc42783          	lw	a5,-52(s0)
    8000153a:	2781                	sext.w	a5,a5
    8000153c:	e781                	bnez	a5,80001544 <memmove+0x22>
    return dst;
    8000153e:	fd843783          	ld	a5,-40(s0)
    80001542:	a855                	j	800015f6 <memmove+0xd4>
  
  s = src;
    80001544:	fd043783          	ld	a5,-48(s0)
    80001548:	fef43423          	sd	a5,-24(s0)
  d = dst;
    8000154c:	fd843783          	ld	a5,-40(s0)
    80001550:	fef43023          	sd	a5,-32(s0)
  if(s < d && s + n > d){
    80001554:	fe843703          	ld	a4,-24(s0)
    80001558:	fe043783          	ld	a5,-32(s0)
    8000155c:	08f77463          	bgeu	a4,a5,800015e4 <memmove+0xc2>
    80001560:	fcc46783          	lwu	a5,-52(s0)
    80001564:	fe843703          	ld	a4,-24(s0)
    80001568:	97ba                	add	a5,a5,a4
    8000156a:	fe043703          	ld	a4,-32(s0)
    8000156e:	06f77b63          	bgeu	a4,a5,800015e4 <memmove+0xc2>
    s += n;
    80001572:	fcc46783          	lwu	a5,-52(s0)
    80001576:	fe843703          	ld	a4,-24(s0)
    8000157a:	97ba                	add	a5,a5,a4
    8000157c:	fef43423          	sd	a5,-24(s0)
    d += n;
    80001580:	fcc46783          	lwu	a5,-52(s0)
    80001584:	fe043703          	ld	a4,-32(s0)
    80001588:	97ba                	add	a5,a5,a4
    8000158a:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    8000158e:	a01d                	j	800015b4 <memmove+0x92>
      *--d = *--s;
    80001590:	fe843783          	ld	a5,-24(s0)
    80001594:	17fd                	addi	a5,a5,-1
    80001596:	fef43423          	sd	a5,-24(s0)
    8000159a:	fe043783          	ld	a5,-32(s0)
    8000159e:	17fd                	addi	a5,a5,-1
    800015a0:	fef43023          	sd	a5,-32(s0)
    800015a4:	fe843783          	ld	a5,-24(s0)
    800015a8:	0007c703          	lbu	a4,0(a5)
    800015ac:	fe043783          	ld	a5,-32(s0)
    800015b0:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    800015b4:	fcc42783          	lw	a5,-52(s0)
    800015b8:	fff7871b          	addiw	a4,a5,-1
    800015bc:	fce42623          	sw	a4,-52(s0)
    800015c0:	fbe1                	bnez	a5,80001590 <memmove+0x6e>
  if(s < d && s + n > d){
    800015c2:	a805                	j	800015f2 <memmove+0xd0>
  } else
    while(n-- > 0)
      *d++ = *s++;
    800015c4:	fe843703          	ld	a4,-24(s0)
    800015c8:	00170793          	addi	a5,a4,1
    800015cc:	fef43423          	sd	a5,-24(s0)
    800015d0:	fe043783          	ld	a5,-32(s0)
    800015d4:	00178693          	addi	a3,a5,1
    800015d8:	fed43023          	sd	a3,-32(s0)
    800015dc:	00074703          	lbu	a4,0(a4)
    800015e0:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    800015e4:	fcc42783          	lw	a5,-52(s0)
    800015e8:	fff7871b          	addiw	a4,a5,-1
    800015ec:	fce42623          	sw	a4,-52(s0)
    800015f0:	fbf1                	bnez	a5,800015c4 <memmove+0xa2>

  return dst;
    800015f2:	fd843783          	ld	a5,-40(s0)
}
    800015f6:	853e                	mv	a0,a5
    800015f8:	7462                	ld	s0,56(sp)
    800015fa:	6121                	addi	sp,sp,64
    800015fc:	8082                	ret

00000000800015fe <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    800015fe:	7179                	addi	sp,sp,-48
    80001600:	f406                	sd	ra,40(sp)
    80001602:	f022                	sd	s0,32(sp)
    80001604:	1800                	addi	s0,sp,48
    80001606:	fea43423          	sd	a0,-24(s0)
    8000160a:	feb43023          	sd	a1,-32(s0)
    8000160e:	87b2                	mv	a5,a2
    80001610:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    80001614:	fdc42783          	lw	a5,-36(s0)
    80001618:	863e                	mv	a2,a5
    8000161a:	fe043583          	ld	a1,-32(s0)
    8000161e:	fe843503          	ld	a0,-24(s0)
    80001622:	00000097          	auipc	ra,0x0
    80001626:	f00080e7          	jalr	-256(ra) # 80001522 <memmove>
    8000162a:	87aa                	mv	a5,a0
}
    8000162c:	853e                	mv	a0,a5
    8000162e:	70a2                	ld	ra,40(sp)
    80001630:	7402                	ld	s0,32(sp)
    80001632:	6145                	addi	sp,sp,48
    80001634:	8082                	ret

0000000080001636 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80001636:	7179                	addi	sp,sp,-48
    80001638:	f422                	sd	s0,40(sp)
    8000163a:	1800                	addi	s0,sp,48
    8000163c:	fea43423          	sd	a0,-24(s0)
    80001640:	feb43023          	sd	a1,-32(s0)
    80001644:	87b2                	mv	a5,a2
    80001646:	fcf42e23          	sw	a5,-36(s0)
  while(n > 0 && *p && *p == *q)
    8000164a:	a005                	j	8000166a <strncmp+0x34>
    n--, p++, q++;
    8000164c:	fdc42783          	lw	a5,-36(s0)
    80001650:	37fd                	addiw	a5,a5,-1
    80001652:	fcf42e23          	sw	a5,-36(s0)
    80001656:	fe843783          	ld	a5,-24(s0)
    8000165a:	0785                	addi	a5,a5,1
    8000165c:	fef43423          	sd	a5,-24(s0)
    80001660:	fe043783          	ld	a5,-32(s0)
    80001664:	0785                	addi	a5,a5,1
    80001666:	fef43023          	sd	a5,-32(s0)
  while(n > 0 && *p && *p == *q)
    8000166a:	fdc42783          	lw	a5,-36(s0)
    8000166e:	2781                	sext.w	a5,a5
    80001670:	c385                	beqz	a5,80001690 <strncmp+0x5a>
    80001672:	fe843783          	ld	a5,-24(s0)
    80001676:	0007c783          	lbu	a5,0(a5)
    8000167a:	cb99                	beqz	a5,80001690 <strncmp+0x5a>
    8000167c:	fe843783          	ld	a5,-24(s0)
    80001680:	0007c703          	lbu	a4,0(a5)
    80001684:	fe043783          	ld	a5,-32(s0)
    80001688:	0007c783          	lbu	a5,0(a5)
    8000168c:	fcf700e3          	beq	a4,a5,8000164c <strncmp+0x16>
  if(n == 0)
    80001690:	fdc42783          	lw	a5,-36(s0)
    80001694:	2781                	sext.w	a5,a5
    80001696:	e399                	bnez	a5,8000169c <strncmp+0x66>
    return 0;
    80001698:	4781                	li	a5,0
    8000169a:	a839                	j	800016b8 <strncmp+0x82>
  return (uchar)*p - (uchar)*q;
    8000169c:	fe843783          	ld	a5,-24(s0)
    800016a0:	0007c783          	lbu	a5,0(a5)
    800016a4:	0007871b          	sext.w	a4,a5
    800016a8:	fe043783          	ld	a5,-32(s0)
    800016ac:	0007c783          	lbu	a5,0(a5)
    800016b0:	2781                	sext.w	a5,a5
    800016b2:	40f707bb          	subw	a5,a4,a5
    800016b6:	2781                	sext.w	a5,a5
}
    800016b8:	853e                	mv	a0,a5
    800016ba:	7422                	ld	s0,40(sp)
    800016bc:	6145                	addi	sp,sp,48
    800016be:	8082                	ret

00000000800016c0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    800016c0:	7139                	addi	sp,sp,-64
    800016c2:	fc22                	sd	s0,56(sp)
    800016c4:	0080                	addi	s0,sp,64
    800016c6:	fca43c23          	sd	a0,-40(s0)
    800016ca:	fcb43823          	sd	a1,-48(s0)
    800016ce:	87b2                	mv	a5,a2
    800016d0:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    800016d4:	fd843783          	ld	a5,-40(s0)
    800016d8:	fef43423          	sd	a5,-24(s0)
  while(n-- > 0 && (*s++ = *t++) != 0)
    800016dc:	0001                	nop
    800016de:	fcc42783          	lw	a5,-52(s0)
    800016e2:	fff7871b          	addiw	a4,a5,-1
    800016e6:	fce42623          	sw	a4,-52(s0)
    800016ea:	02f05e63          	blez	a5,80001726 <strncpy+0x66>
    800016ee:	fd043703          	ld	a4,-48(s0)
    800016f2:	00170793          	addi	a5,a4,1
    800016f6:	fcf43823          	sd	a5,-48(s0)
    800016fa:	fd843783          	ld	a5,-40(s0)
    800016fe:	00178693          	addi	a3,a5,1
    80001702:	fcd43c23          	sd	a3,-40(s0)
    80001706:	00074703          	lbu	a4,0(a4)
    8000170a:	00e78023          	sb	a4,0(a5)
    8000170e:	0007c783          	lbu	a5,0(a5)
    80001712:	f7f1                	bnez	a5,800016de <strncpy+0x1e>
    ;
  while(n-- > 0)
    80001714:	a809                	j	80001726 <strncpy+0x66>
    *s++ = 0;
    80001716:	fd843783          	ld	a5,-40(s0)
    8000171a:	00178713          	addi	a4,a5,1
    8000171e:	fce43c23          	sd	a4,-40(s0)
    80001722:	00078023          	sb	zero,0(a5)
  while(n-- > 0)
    80001726:	fcc42783          	lw	a5,-52(s0)
    8000172a:	fff7871b          	addiw	a4,a5,-1
    8000172e:	fce42623          	sw	a4,-52(s0)
    80001732:	fef042e3          	bgtz	a5,80001716 <strncpy+0x56>
  return os;
    80001736:	fe843783          	ld	a5,-24(s0)
}
    8000173a:	853e                	mv	a0,a5
    8000173c:	7462                	ld	s0,56(sp)
    8000173e:	6121                	addi	sp,sp,64
    80001740:	8082                	ret

0000000080001742 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80001742:	7139                	addi	sp,sp,-64
    80001744:	fc22                	sd	s0,56(sp)
    80001746:	0080                	addi	s0,sp,64
    80001748:	fca43c23          	sd	a0,-40(s0)
    8000174c:	fcb43823          	sd	a1,-48(s0)
    80001750:	87b2                	mv	a5,a2
    80001752:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    80001756:	fd843783          	ld	a5,-40(s0)
    8000175a:	fef43423          	sd	a5,-24(s0)
  if(n <= 0)
    8000175e:	fcc42783          	lw	a5,-52(s0)
    80001762:	2781                	sext.w	a5,a5
    80001764:	00f04563          	bgtz	a5,8000176e <safestrcpy+0x2c>
    return os;
    80001768:	fe843783          	ld	a5,-24(s0)
    8000176c:	a0a9                	j	800017b6 <safestrcpy+0x74>
  while(--n > 0 && (*s++ = *t++) != 0)
    8000176e:	0001                	nop
    80001770:	fcc42783          	lw	a5,-52(s0)
    80001774:	37fd                	addiw	a5,a5,-1
    80001776:	fcf42623          	sw	a5,-52(s0)
    8000177a:	fcc42783          	lw	a5,-52(s0)
    8000177e:	2781                	sext.w	a5,a5
    80001780:	02f05563          	blez	a5,800017aa <safestrcpy+0x68>
    80001784:	fd043703          	ld	a4,-48(s0)
    80001788:	00170793          	addi	a5,a4,1
    8000178c:	fcf43823          	sd	a5,-48(s0)
    80001790:	fd843783          	ld	a5,-40(s0)
    80001794:	00178693          	addi	a3,a5,1
    80001798:	fcd43c23          	sd	a3,-40(s0)
    8000179c:	00074703          	lbu	a4,0(a4)
    800017a0:	00e78023          	sb	a4,0(a5)
    800017a4:	0007c783          	lbu	a5,0(a5)
    800017a8:	f7e1                	bnez	a5,80001770 <safestrcpy+0x2e>
    ;
  *s = 0;
    800017aa:	fd843783          	ld	a5,-40(s0)
    800017ae:	00078023          	sb	zero,0(a5)
  return os;
    800017b2:	fe843783          	ld	a5,-24(s0)
}
    800017b6:	853e                	mv	a0,a5
    800017b8:	7462                	ld	s0,56(sp)
    800017ba:	6121                	addi	sp,sp,64
    800017bc:	8082                	ret

00000000800017be <strlen>:

int
strlen(const char *s)
{
    800017be:	7179                	addi	sp,sp,-48
    800017c0:	f422                	sd	s0,40(sp)
    800017c2:	1800                	addi	s0,sp,48
    800017c4:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    800017c8:	fe042623          	sw	zero,-20(s0)
    800017cc:	a031                	j	800017d8 <strlen+0x1a>
    800017ce:	fec42783          	lw	a5,-20(s0)
    800017d2:	2785                	addiw	a5,a5,1
    800017d4:	fef42623          	sw	a5,-20(s0)
    800017d8:	fec42783          	lw	a5,-20(s0)
    800017dc:	fd843703          	ld	a4,-40(s0)
    800017e0:	97ba                	add	a5,a5,a4
    800017e2:	0007c783          	lbu	a5,0(a5)
    800017e6:	f7e5                	bnez	a5,800017ce <strlen+0x10>
    ;
  return n;
    800017e8:	fec42783          	lw	a5,-20(s0)
}
    800017ec:	853e                	mv	a0,a5
    800017ee:	7422                	ld	s0,40(sp)
    800017f0:	6145                	addi	sp,sp,48
    800017f2:	8082                	ret

00000000800017f4 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    800017f4:	1141                	addi	sp,sp,-16
    800017f6:	e406                	sd	ra,8(sp)
    800017f8:	e022                	sd	s0,0(sp)
    800017fa:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    800017fc:	00001097          	auipc	ra,0x1
    80001800:	1be080e7          	jalr	446(ra) # 800029ba <cpuid>
    80001804:	87aa                	mv	a5,a0
    80001806:	efd5                	bnez	a5,800018c2 <main+0xce>
    consoleinit();
    80001808:	fffff097          	auipc	ra,0xfffff
    8000180c:	04c080e7          	jalr	76(ra) # 80000854 <consoleinit>
    printfinit();
    80001810:	fffff097          	auipc	ra,0xfffff
    80001814:	4bc080e7          	jalr	1212(ra) # 80000ccc <printfinit>
    printf("\n");
    80001818:	0000a517          	auipc	a0,0xa
    8000181c:	86850513          	addi	a0,a0,-1944 # 8000b080 <etext+0x80>
    80001820:	fffff097          	auipc	ra,0xfffff
    80001824:	204080e7          	jalr	516(ra) # 80000a24 <printf>
    printf("xv6 kernel is booting\n");
    80001828:	0000a517          	auipc	a0,0xa
    8000182c:	86050513          	addi	a0,a0,-1952 # 8000b088 <etext+0x88>
    80001830:	fffff097          	auipc	ra,0xfffff
    80001834:	1f4080e7          	jalr	500(ra) # 80000a24 <printf>
    printf("\n");
    80001838:	0000a517          	auipc	a0,0xa
    8000183c:	84850513          	addi	a0,a0,-1976 # 8000b080 <etext+0x80>
    80001840:	fffff097          	auipc	ra,0xfffff
    80001844:	1e4080e7          	jalr	484(ra) # 80000a24 <printf>
    kinit();         // physical page allocator
    80001848:	fffff097          	auipc	ra,0xfffff
    8000184c:	792080e7          	jalr	1938(ra) # 80000fda <kinit>
    kvminit();       // create kernel page table
    80001850:	00000097          	auipc	ra,0x0
    80001854:	1f4080e7          	jalr	500(ra) # 80001a44 <kvminit>
    kvminithart();   // turn on paging
    80001858:	00000097          	auipc	ra,0x0
    8000185c:	212080e7          	jalr	530(ra) # 80001a6a <kvminithart>
    procinit();      // process table
    80001860:	00001097          	auipc	ra,0x1
    80001864:	090080e7          	jalr	144(ra) # 800028f0 <procinit>
    trapinit();      // trap vectors
    80001868:	00003097          	auipc	ra,0x3
    8000186c:	b12080e7          	jalr	-1262(ra) # 8000437a <trapinit>
    trapinithart();  // install kernel trap vector
    80001870:	00003097          	auipc	ra,0x3
    80001874:	b34080e7          	jalr	-1228(ra) # 800043a4 <trapinithart>
    plicinit();      // set up interrupt controller
    80001878:	00008097          	auipc	ra,0x8
    8000187c:	a82080e7          	jalr	-1406(ra) # 800092fa <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80001880:	00008097          	auipc	ra,0x8
    80001884:	a9e080e7          	jalr	-1378(ra) # 8000931e <plicinithart>
    binit();         // buffer cache
    80001888:	00003097          	auipc	ra,0x3
    8000188c:	6b6080e7          	jalr	1718(ra) # 80004f3e <binit>
    iinit();         // inode table
    80001890:	00004097          	auipc	ra,0x4
    80001894:	eea080e7          	jalr	-278(ra) # 8000577a <iinit>
    fileinit();      // file table
    80001898:	00006097          	auipc	ra,0x6
    8000189c:	89a080e7          	jalr	-1894(ra) # 80007132 <fileinit>
    virtio_disk_init(); // emulated hard disk
    800018a0:	00008097          	auipc	ra,0x8
    800018a4:	b52080e7          	jalr	-1198(ra) # 800093f2 <virtio_disk_init>
    userinit();      // first user process
    800018a8:	00001097          	auipc	ra,0x1
    800018ac:	620080e7          	jalr	1568(ra) # 80002ec8 <userinit>
    __sync_synchronize();
    800018b0:	0ff0000f          	fence
    started = 1;
    800018b4:	00013797          	auipc	a5,0x13
    800018b8:	9dc78793          	addi	a5,a5,-1572 # 80014290 <started>
    800018bc:	4705                	li	a4,1
    800018be:	c398                	sw	a4,0(a5)
    800018c0:	a0a9                	j	8000190a <main+0x116>
  } else {
    while(started == 0)
    800018c2:	0001                	nop
    800018c4:	00013797          	auipc	a5,0x13
    800018c8:	9cc78793          	addi	a5,a5,-1588 # 80014290 <started>
    800018cc:	439c                	lw	a5,0(a5)
    800018ce:	2781                	sext.w	a5,a5
    800018d0:	dbf5                	beqz	a5,800018c4 <main+0xd0>
      ;
    __sync_synchronize();
    800018d2:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    800018d6:	00001097          	auipc	ra,0x1
    800018da:	0e4080e7          	jalr	228(ra) # 800029ba <cpuid>
    800018de:	87aa                	mv	a5,a0
    800018e0:	85be                	mv	a1,a5
    800018e2:	00009517          	auipc	a0,0x9
    800018e6:	7be50513          	addi	a0,a0,1982 # 8000b0a0 <etext+0xa0>
    800018ea:	fffff097          	auipc	ra,0xfffff
    800018ee:	13a080e7          	jalr	314(ra) # 80000a24 <printf>
    kvminithart();    // turn on paging
    800018f2:	00000097          	auipc	ra,0x0
    800018f6:	178080e7          	jalr	376(ra) # 80001a6a <kvminithart>
    trapinithart();   // install kernel trap vector
    800018fa:	00003097          	auipc	ra,0x3
    800018fe:	aaa080e7          	jalr	-1366(ra) # 800043a4 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80001902:	00008097          	auipc	ra,0x8
    80001906:	a1c080e7          	jalr	-1508(ra) # 8000931e <plicinithart>
  }

  scheduler();        
    8000190a:	00002097          	auipc	ra,0x2
    8000190e:	dba080e7          	jalr	-582(ra) # 800036c4 <scheduler>

0000000080001912 <w_satp>:
{
    80001912:	1101                	addi	sp,sp,-32
    80001914:	ec22                	sd	s0,24(sp)
    80001916:	1000                	addi	s0,sp,32
    80001918:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    8000191c:	fe843783          	ld	a5,-24(s0)
    80001920:	18079073          	csrw	satp,a5
}
    80001924:	0001                	nop
    80001926:	6462                	ld	s0,24(sp)
    80001928:	6105                	addi	sp,sp,32
    8000192a:	8082                	ret

000000008000192c <sfence_vma>:
}

// flush the TLB.
static inline void
sfence_vma()
{
    8000192c:	1141                	addi	sp,sp,-16
    8000192e:	e422                	sd	s0,8(sp)
    80001930:	0800                	addi	s0,sp,16
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80001932:	12000073          	sfence.vma
}
    80001936:	0001                	nop
    80001938:	6422                	ld	s0,8(sp)
    8000193a:	0141                	addi	sp,sp,16
    8000193c:	8082                	ret

000000008000193e <kvmmake>:
extern char trampoline[]; // trampoline.S

// Make a direct-map page table for the kernel.
pagetable_t
kvmmake(void)
{
    8000193e:	1101                	addi	sp,sp,-32
    80001940:	ec06                	sd	ra,24(sp)
    80001942:	e822                	sd	s0,16(sp)
    80001944:	1000                	addi	s0,sp,32
  pagetable_t kpgtbl;

  kpgtbl = (pagetable_t) kalloc();
    80001946:	fffff097          	auipc	ra,0xfffff
    8000194a:	7d0080e7          	jalr	2000(ra) # 80001116 <kalloc>
    8000194e:	fea43423          	sd	a0,-24(s0)
  memset(kpgtbl, 0, PGSIZE);
    80001952:	6605                	lui	a2,0x1
    80001954:	4581                	li	a1,0
    80001956:	fe843503          	ld	a0,-24(s0)
    8000195a:	00000097          	auipc	ra,0x0
    8000195e:	ae4080e7          	jalr	-1308(ra) # 8000143e <memset>

  // uart registers
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80001962:	4719                	li	a4,6
    80001964:	6685                	lui	a3,0x1
    80001966:	10000637          	lui	a2,0x10000
    8000196a:	100005b7          	lui	a1,0x10000
    8000196e:	fe843503          	ld	a0,-24(s0)
    80001972:	00000097          	auipc	ra,0x0
    80001976:	29a080e7          	jalr	666(ra) # 80001c0c <kvmmap>

  // virtio mmio disk interface
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000197a:	4719                	li	a4,6
    8000197c:	6685                	lui	a3,0x1
    8000197e:	10001637          	lui	a2,0x10001
    80001982:	100015b7          	lui	a1,0x10001
    80001986:	fe843503          	ld	a0,-24(s0)
    8000198a:	00000097          	auipc	ra,0x0
    8000198e:	282080e7          	jalr	642(ra) # 80001c0c <kvmmap>

  // PLIC
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80001992:	4719                	li	a4,6
    80001994:	004006b7          	lui	a3,0x400
    80001998:	0c000637          	lui	a2,0xc000
    8000199c:	0c0005b7          	lui	a1,0xc000
    800019a0:	fe843503          	ld	a0,-24(s0)
    800019a4:	00000097          	auipc	ra,0x0
    800019a8:	268080e7          	jalr	616(ra) # 80001c0c <kvmmap>

  // map kernel text executable and read-only.
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800019ac:	00009717          	auipc	a4,0x9
    800019b0:	65470713          	addi	a4,a4,1620 # 8000b000 <etext>
    800019b4:	800007b7          	lui	a5,0x80000
    800019b8:	97ba                	add	a5,a5,a4
    800019ba:	4729                	li	a4,10
    800019bc:	86be                	mv	a3,a5
    800019be:	4785                	li	a5,1
    800019c0:	01f79613          	slli	a2,a5,0x1f
    800019c4:	4785                	li	a5,1
    800019c6:	01f79593          	slli	a1,a5,0x1f
    800019ca:	fe843503          	ld	a0,-24(s0)
    800019ce:	00000097          	auipc	ra,0x0
    800019d2:	23e080e7          	jalr	574(ra) # 80001c0c <kvmmap>

  // map kernel data and the physical RAM we'll make use of.
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800019d6:	00009597          	auipc	a1,0x9
    800019da:	62a58593          	addi	a1,a1,1578 # 8000b000 <etext>
    800019de:	00009617          	auipc	a2,0x9
    800019e2:	62260613          	addi	a2,a2,1570 # 8000b000 <etext>
    800019e6:	00009797          	auipc	a5,0x9
    800019ea:	61a78793          	addi	a5,a5,1562 # 8000b000 <etext>
    800019ee:	4745                	li	a4,17
    800019f0:	076e                	slli	a4,a4,0x1b
    800019f2:	40f707b3          	sub	a5,a4,a5
    800019f6:	4719                	li	a4,6
    800019f8:	86be                	mv	a3,a5
    800019fa:	fe843503          	ld	a0,-24(s0)
    800019fe:	00000097          	auipc	ra,0x0
    80001a02:	20e080e7          	jalr	526(ra) # 80001c0c <kvmmap>

  // map the trampoline for trap entry/exit to
  // the highest virtual address in the kernel.
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80001a06:	00008797          	auipc	a5,0x8
    80001a0a:	5fa78793          	addi	a5,a5,1530 # 8000a000 <_trampoline>
    80001a0e:	4729                	li	a4,10
    80001a10:	6685                	lui	a3,0x1
    80001a12:	863e                	mv	a2,a5
    80001a14:	040007b7          	lui	a5,0x4000
    80001a18:	17fd                	addi	a5,a5,-1
    80001a1a:	00c79593          	slli	a1,a5,0xc
    80001a1e:	fe843503          	ld	a0,-24(s0)
    80001a22:	00000097          	auipc	ra,0x0
    80001a26:	1ea080e7          	jalr	490(ra) # 80001c0c <kvmmap>

  // map kernel stacks
  proc_mapstacks(kpgtbl);
    80001a2a:	fe843503          	ld	a0,-24(s0)
    80001a2e:	00001097          	auipc	ra,0x1
    80001a32:	e02080e7          	jalr	-510(ra) # 80002830 <proc_mapstacks>
  
  return kpgtbl;
    80001a36:	fe843783          	ld	a5,-24(s0)
}
    80001a3a:	853e                	mv	a0,a5
    80001a3c:	60e2                	ld	ra,24(sp)
    80001a3e:	6442                	ld	s0,16(sp)
    80001a40:	6105                	addi	sp,sp,32
    80001a42:	8082                	ret

0000000080001a44 <kvminit>:

// Initialize the one kernel_pagetable
void
kvminit(void)
{
    80001a44:	1141                	addi	sp,sp,-16
    80001a46:	e406                	sd	ra,8(sp)
    80001a48:	e022                	sd	s0,0(sp)
    80001a4a:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80001a4c:	00000097          	auipc	ra,0x0
    80001a50:	ef2080e7          	jalr	-270(ra) # 8000193e <kvmmake>
    80001a54:	872a                	mv	a4,a0
    80001a56:	0000a797          	auipc	a5,0xa
    80001a5a:	5c278793          	addi	a5,a5,1474 # 8000c018 <kernel_pagetable>
    80001a5e:	e398                	sd	a4,0(a5)
}
    80001a60:	0001                	nop
    80001a62:	60a2                	ld	ra,8(sp)
    80001a64:	6402                	ld	s0,0(sp)
    80001a66:	0141                	addi	sp,sp,16
    80001a68:	8082                	ret

0000000080001a6a <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80001a6a:	1141                	addi	sp,sp,-16
    80001a6c:	e406                	sd	ra,8(sp)
    80001a6e:	e022                	sd	s0,0(sp)
    80001a70:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80001a72:	0000a797          	auipc	a5,0xa
    80001a76:	5a678793          	addi	a5,a5,1446 # 8000c018 <kernel_pagetable>
    80001a7a:	639c                	ld	a5,0(a5)
    80001a7c:	00c7d713          	srli	a4,a5,0xc
    80001a80:	57fd                	li	a5,-1
    80001a82:	17fe                	slli	a5,a5,0x3f
    80001a84:	8fd9                	or	a5,a5,a4
    80001a86:	853e                	mv	a0,a5
    80001a88:	00000097          	auipc	ra,0x0
    80001a8c:	e8a080e7          	jalr	-374(ra) # 80001912 <w_satp>
  sfence_vma();
    80001a90:	00000097          	auipc	ra,0x0
    80001a94:	e9c080e7          	jalr	-356(ra) # 8000192c <sfence_vma>
}
    80001a98:	0001                	nop
    80001a9a:	60a2                	ld	ra,8(sp)
    80001a9c:	6402                	ld	s0,0(sp)
    80001a9e:	0141                	addi	sp,sp,16
    80001aa0:	8082                	ret

0000000080001aa2 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80001aa2:	7139                	addi	sp,sp,-64
    80001aa4:	fc06                	sd	ra,56(sp)
    80001aa6:	f822                	sd	s0,48(sp)
    80001aa8:	0080                	addi	s0,sp,64
    80001aaa:	fca43c23          	sd	a0,-40(s0)
    80001aae:	fcb43823          	sd	a1,-48(s0)
    80001ab2:	87b2                	mv	a5,a2
    80001ab4:	fcf42623          	sw	a5,-52(s0)
  if(va >= MAXVA)
    80001ab8:	fd043703          	ld	a4,-48(s0)
    80001abc:	57fd                	li	a5,-1
    80001abe:	83e9                	srli	a5,a5,0x1a
    80001ac0:	00e7fa63          	bgeu	a5,a4,80001ad4 <walk+0x32>
    panic("walk");
    80001ac4:	00009517          	auipc	a0,0x9
    80001ac8:	5f450513          	addi	a0,a0,1524 # 8000b0b8 <etext+0xb8>
    80001acc:	fffff097          	auipc	ra,0xfffff
    80001ad0:	1ae080e7          	jalr	430(ra) # 80000c7a <panic>

  for(int level = 2; level > 0; level--) {
    80001ad4:	4789                	li	a5,2
    80001ad6:	fef42623          	sw	a5,-20(s0)
    80001ada:	a851                	j	80001b6e <walk+0xcc>
    pte_t *pte = &pagetable[PX(level, va)];
    80001adc:	fec42783          	lw	a5,-20(s0)
    80001ae0:	873e                	mv	a4,a5
    80001ae2:	87ba                	mv	a5,a4
    80001ae4:	0037979b          	slliw	a5,a5,0x3
    80001ae8:	9fb9                	addw	a5,a5,a4
    80001aea:	2781                	sext.w	a5,a5
    80001aec:	27b1                	addiw	a5,a5,12
    80001aee:	2781                	sext.w	a5,a5
    80001af0:	873e                	mv	a4,a5
    80001af2:	fd043783          	ld	a5,-48(s0)
    80001af6:	00e7d7b3          	srl	a5,a5,a4
    80001afa:	1ff7f793          	andi	a5,a5,511
    80001afe:	078e                	slli	a5,a5,0x3
    80001b00:	fd843703          	ld	a4,-40(s0)
    80001b04:	97ba                	add	a5,a5,a4
    80001b06:	fef43023          	sd	a5,-32(s0)
    if(*pte & PTE_V) {
    80001b0a:	fe043783          	ld	a5,-32(s0)
    80001b0e:	639c                	ld	a5,0(a5)
    80001b10:	8b85                	andi	a5,a5,1
    80001b12:	cb89                	beqz	a5,80001b24 <walk+0x82>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80001b14:	fe043783          	ld	a5,-32(s0)
    80001b18:	639c                	ld	a5,0(a5)
    80001b1a:	83a9                	srli	a5,a5,0xa
    80001b1c:	07b2                	slli	a5,a5,0xc
    80001b1e:	fcf43c23          	sd	a5,-40(s0)
    80001b22:	a089                	j	80001b64 <walk+0xc2>
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80001b24:	fcc42783          	lw	a5,-52(s0)
    80001b28:	2781                	sext.w	a5,a5
    80001b2a:	cb91                	beqz	a5,80001b3e <walk+0x9c>
    80001b2c:	fffff097          	auipc	ra,0xfffff
    80001b30:	5ea080e7          	jalr	1514(ra) # 80001116 <kalloc>
    80001b34:	fca43c23          	sd	a0,-40(s0)
    80001b38:	fd843783          	ld	a5,-40(s0)
    80001b3c:	e399                	bnez	a5,80001b42 <walk+0xa0>
        return 0;
    80001b3e:	4781                	li	a5,0
    80001b40:	a0a9                	j	80001b8a <walk+0xe8>
      memset(pagetable, 0, PGSIZE);
    80001b42:	6605                	lui	a2,0x1
    80001b44:	4581                	li	a1,0
    80001b46:	fd843503          	ld	a0,-40(s0)
    80001b4a:	00000097          	auipc	ra,0x0
    80001b4e:	8f4080e7          	jalr	-1804(ra) # 8000143e <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80001b52:	fd843783          	ld	a5,-40(s0)
    80001b56:	83b1                	srli	a5,a5,0xc
    80001b58:	07aa                	slli	a5,a5,0xa
    80001b5a:	0017e713          	ori	a4,a5,1
    80001b5e:	fe043783          	ld	a5,-32(s0)
    80001b62:	e398                	sd	a4,0(a5)
  for(int level = 2; level > 0; level--) {
    80001b64:	fec42783          	lw	a5,-20(s0)
    80001b68:	37fd                	addiw	a5,a5,-1
    80001b6a:	fef42623          	sw	a5,-20(s0)
    80001b6e:	fec42783          	lw	a5,-20(s0)
    80001b72:	2781                	sext.w	a5,a5
    80001b74:	f6f044e3          	bgtz	a5,80001adc <walk+0x3a>
    }
  }
  return &pagetable[PX(0, va)];
    80001b78:	fd043783          	ld	a5,-48(s0)
    80001b7c:	83b1                	srli	a5,a5,0xc
    80001b7e:	1ff7f793          	andi	a5,a5,511
    80001b82:	078e                	slli	a5,a5,0x3
    80001b84:	fd843703          	ld	a4,-40(s0)
    80001b88:	97ba                	add	a5,a5,a4
}
    80001b8a:	853e                	mv	a0,a5
    80001b8c:	70e2                	ld	ra,56(sp)
    80001b8e:	7442                	ld	s0,48(sp)
    80001b90:	6121                	addi	sp,sp,64
    80001b92:	8082                	ret

0000000080001b94 <walkaddr>:
// Look up a virtual address, return the physical address,
// or 0 if not mapped.
// Can only be used to look up user pages.
uint64
walkaddr(pagetable_t pagetable, uint64 va)
{
    80001b94:	7179                	addi	sp,sp,-48
    80001b96:	f406                	sd	ra,40(sp)
    80001b98:	f022                	sd	s0,32(sp)
    80001b9a:	1800                	addi	s0,sp,48
    80001b9c:	fca43c23          	sd	a0,-40(s0)
    80001ba0:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80001ba4:	fd043703          	ld	a4,-48(s0)
    80001ba8:	57fd                	li	a5,-1
    80001baa:	83e9                	srli	a5,a5,0x1a
    80001bac:	00e7f463          	bgeu	a5,a4,80001bb4 <walkaddr+0x20>
    return 0;
    80001bb0:	4781                	li	a5,0
    80001bb2:	a881                	j	80001c02 <walkaddr+0x6e>

  pte = walk(pagetable, va, 0);
    80001bb4:	4601                	li	a2,0
    80001bb6:	fd043583          	ld	a1,-48(s0)
    80001bba:	fd843503          	ld	a0,-40(s0)
    80001bbe:	00000097          	auipc	ra,0x0
    80001bc2:	ee4080e7          	jalr	-284(ra) # 80001aa2 <walk>
    80001bc6:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    80001bca:	fe843783          	ld	a5,-24(s0)
    80001bce:	e399                	bnez	a5,80001bd4 <walkaddr+0x40>
    return 0;
    80001bd0:	4781                	li	a5,0
    80001bd2:	a805                	j	80001c02 <walkaddr+0x6e>
  if((*pte & PTE_V) == 0)
    80001bd4:	fe843783          	ld	a5,-24(s0)
    80001bd8:	639c                	ld	a5,0(a5)
    80001bda:	8b85                	andi	a5,a5,1
    80001bdc:	e399                	bnez	a5,80001be2 <walkaddr+0x4e>
    return 0;
    80001bde:	4781                	li	a5,0
    80001be0:	a00d                	j	80001c02 <walkaddr+0x6e>
  if((*pte & PTE_U) == 0)
    80001be2:	fe843783          	ld	a5,-24(s0)
    80001be6:	639c                	ld	a5,0(a5)
    80001be8:	8bc1                	andi	a5,a5,16
    80001bea:	e399                	bnez	a5,80001bf0 <walkaddr+0x5c>
    return 0;
    80001bec:	4781                	li	a5,0
    80001bee:	a811                	j	80001c02 <walkaddr+0x6e>
  pa = PTE2PA(*pte);
    80001bf0:	fe843783          	ld	a5,-24(s0)
    80001bf4:	639c                	ld	a5,0(a5)
    80001bf6:	83a9                	srli	a5,a5,0xa
    80001bf8:	07b2                	slli	a5,a5,0xc
    80001bfa:	fef43023          	sd	a5,-32(s0)
  return pa;
    80001bfe:	fe043783          	ld	a5,-32(s0)
}
    80001c02:	853e                	mv	a0,a5
    80001c04:	70a2                	ld	ra,40(sp)
    80001c06:	7402                	ld	s0,32(sp)
    80001c08:	6145                	addi	sp,sp,48
    80001c0a:	8082                	ret

0000000080001c0c <kvmmap>:
// add a mapping to the kernel page table.
// only used when booting.
// does not flush TLB or enable paging.
void
kvmmap(pagetable_t kpgtbl, uint64 va, uint64 pa, uint64 sz, int perm)
{
    80001c0c:	7139                	addi	sp,sp,-64
    80001c0e:	fc06                	sd	ra,56(sp)
    80001c10:	f822                	sd	s0,48(sp)
    80001c12:	0080                	addi	s0,sp,64
    80001c14:	fea43423          	sd	a0,-24(s0)
    80001c18:	feb43023          	sd	a1,-32(s0)
    80001c1c:	fcc43c23          	sd	a2,-40(s0)
    80001c20:	fcd43823          	sd	a3,-48(s0)
    80001c24:	87ba                	mv	a5,a4
    80001c26:	fcf42623          	sw	a5,-52(s0)
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80001c2a:	fcc42783          	lw	a5,-52(s0)
    80001c2e:	873e                	mv	a4,a5
    80001c30:	fd843683          	ld	a3,-40(s0)
    80001c34:	fd043603          	ld	a2,-48(s0)
    80001c38:	fe043583          	ld	a1,-32(s0)
    80001c3c:	fe843503          	ld	a0,-24(s0)
    80001c40:	00000097          	auipc	ra,0x0
    80001c44:	026080e7          	jalr	38(ra) # 80001c66 <mappages>
    80001c48:	87aa                	mv	a5,a0
    80001c4a:	cb89                	beqz	a5,80001c5c <kvmmap+0x50>
    panic("kvmmap");
    80001c4c:	00009517          	auipc	a0,0x9
    80001c50:	47450513          	addi	a0,a0,1140 # 8000b0c0 <etext+0xc0>
    80001c54:	fffff097          	auipc	ra,0xfffff
    80001c58:	026080e7          	jalr	38(ra) # 80000c7a <panic>
}
    80001c5c:	0001                	nop
    80001c5e:	70e2                	ld	ra,56(sp)
    80001c60:	7442                	ld	s0,48(sp)
    80001c62:	6121                	addi	sp,sp,64
    80001c64:	8082                	ret

0000000080001c66 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80001c66:	711d                	addi	sp,sp,-96
    80001c68:	ec86                	sd	ra,88(sp)
    80001c6a:	e8a2                	sd	s0,80(sp)
    80001c6c:	1080                	addi	s0,sp,96
    80001c6e:	fca43423          	sd	a0,-56(s0)
    80001c72:	fcb43023          	sd	a1,-64(s0)
    80001c76:	fac43c23          	sd	a2,-72(s0)
    80001c7a:	fad43823          	sd	a3,-80(s0)
    80001c7e:	87ba                	mv	a5,a4
    80001c80:	faf42623          	sw	a5,-84(s0)
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    80001c84:	fb843783          	ld	a5,-72(s0)
    80001c88:	eb89                	bnez	a5,80001c9a <mappages+0x34>
    panic("mappages: size");
    80001c8a:	00009517          	auipc	a0,0x9
    80001c8e:	43e50513          	addi	a0,a0,1086 # 8000b0c8 <etext+0xc8>
    80001c92:	fffff097          	auipc	ra,0xfffff
    80001c96:	fe8080e7          	jalr	-24(ra) # 80000c7a <panic>
  
  a = PGROUNDDOWN(va);
    80001c9a:	fc043703          	ld	a4,-64(s0)
    80001c9e:	77fd                	lui	a5,0xfffff
    80001ca0:	8ff9                	and	a5,a5,a4
    80001ca2:	fef43423          	sd	a5,-24(s0)
  last = PGROUNDDOWN(va + size - 1);
    80001ca6:	fc043703          	ld	a4,-64(s0)
    80001caa:	fb843783          	ld	a5,-72(s0)
    80001cae:	97ba                	add	a5,a5,a4
    80001cb0:	fff78713          	addi	a4,a5,-1 # ffffffffffffefff <end+0xffffffff7fb55fff>
    80001cb4:	77fd                	lui	a5,0xfffff
    80001cb6:	8ff9                	and	a5,a5,a4
    80001cb8:	fef43023          	sd	a5,-32(s0)
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    80001cbc:	4605                	li	a2,1
    80001cbe:	fe843583          	ld	a1,-24(s0)
    80001cc2:	fc843503          	ld	a0,-56(s0)
    80001cc6:	00000097          	auipc	ra,0x0
    80001cca:	ddc080e7          	jalr	-548(ra) # 80001aa2 <walk>
    80001cce:	fca43c23          	sd	a0,-40(s0)
    80001cd2:	fd843783          	ld	a5,-40(s0)
    80001cd6:	e399                	bnez	a5,80001cdc <mappages+0x76>
      return -1;
    80001cd8:	57fd                	li	a5,-1
    80001cda:	a085                	j	80001d3a <mappages+0xd4>
    if(*pte & PTE_V)
    80001cdc:	fd843783          	ld	a5,-40(s0)
    80001ce0:	639c                	ld	a5,0(a5)
    80001ce2:	8b85                	andi	a5,a5,1
    80001ce4:	cb89                	beqz	a5,80001cf6 <mappages+0x90>
      panic("mappages: remap");
    80001ce6:	00009517          	auipc	a0,0x9
    80001cea:	3f250513          	addi	a0,a0,1010 # 8000b0d8 <etext+0xd8>
    80001cee:	fffff097          	auipc	ra,0xfffff
    80001cf2:	f8c080e7          	jalr	-116(ra) # 80000c7a <panic>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80001cf6:	fb043783          	ld	a5,-80(s0)
    80001cfa:	83b1                	srli	a5,a5,0xc
    80001cfc:	00a79713          	slli	a4,a5,0xa
    80001d00:	fac42783          	lw	a5,-84(s0)
    80001d04:	8fd9                	or	a5,a5,a4
    80001d06:	0017e713          	ori	a4,a5,1
    80001d0a:	fd843783          	ld	a5,-40(s0)
    80001d0e:	e398                	sd	a4,0(a5)
    if(a == last)
    80001d10:	fe843703          	ld	a4,-24(s0)
    80001d14:	fe043783          	ld	a5,-32(s0)
    80001d18:	00f70f63          	beq	a4,a5,80001d36 <mappages+0xd0>
      break;
    a += PGSIZE;
    80001d1c:	fe843703          	ld	a4,-24(s0)
    80001d20:	6785                	lui	a5,0x1
    80001d22:	97ba                	add	a5,a5,a4
    80001d24:	fef43423          	sd	a5,-24(s0)
    pa += PGSIZE;
    80001d28:	fb043703          	ld	a4,-80(s0)
    80001d2c:	6785                	lui	a5,0x1
    80001d2e:	97ba                	add	a5,a5,a4
    80001d30:	faf43823          	sd	a5,-80(s0)
    if((pte = walk(pagetable, a, 1)) == 0)
    80001d34:	b761                	j	80001cbc <mappages+0x56>
      break;
    80001d36:	0001                	nop
  }
  return 0;
    80001d38:	4781                	li	a5,0
}
    80001d3a:	853e                	mv	a0,a5
    80001d3c:	60e6                	ld	ra,88(sp)
    80001d3e:	6446                	ld	s0,80(sp)
    80001d40:	6125                	addi	sp,sp,96
    80001d42:	8082                	ret

0000000080001d44 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80001d44:	715d                	addi	sp,sp,-80
    80001d46:	e486                	sd	ra,72(sp)
    80001d48:	e0a2                	sd	s0,64(sp)
    80001d4a:	0880                	addi	s0,sp,80
    80001d4c:	fca43423          	sd	a0,-56(s0)
    80001d50:	fcb43023          	sd	a1,-64(s0)
    80001d54:	fac43c23          	sd	a2,-72(s0)
    80001d58:	87b6                	mv	a5,a3
    80001d5a:	faf42a23          	sw	a5,-76(s0)
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80001d5e:	fc043703          	ld	a4,-64(s0)
    80001d62:	6785                	lui	a5,0x1
    80001d64:	17fd                	addi	a5,a5,-1
    80001d66:	8ff9                	and	a5,a5,a4
    80001d68:	cb89                	beqz	a5,80001d7a <uvmunmap+0x36>
    panic("uvmunmap: not aligned");
    80001d6a:	00009517          	auipc	a0,0x9
    80001d6e:	37e50513          	addi	a0,a0,894 # 8000b0e8 <etext+0xe8>
    80001d72:	fffff097          	auipc	ra,0xfffff
    80001d76:	f08080e7          	jalr	-248(ra) # 80000c7a <panic>

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001d7a:	fc043783          	ld	a5,-64(s0)
    80001d7e:	fef43423          	sd	a5,-24(s0)
    80001d82:	a045                	j	80001e22 <uvmunmap+0xde>
    if((pte = walk(pagetable, a, 0)) == 0)
    80001d84:	4601                	li	a2,0
    80001d86:	fe843583          	ld	a1,-24(s0)
    80001d8a:	fc843503          	ld	a0,-56(s0)
    80001d8e:	00000097          	auipc	ra,0x0
    80001d92:	d14080e7          	jalr	-748(ra) # 80001aa2 <walk>
    80001d96:	fea43023          	sd	a0,-32(s0)
    80001d9a:	fe043783          	ld	a5,-32(s0)
    80001d9e:	eb89                	bnez	a5,80001db0 <uvmunmap+0x6c>
      panic("uvmunmap: walk");
    80001da0:	00009517          	auipc	a0,0x9
    80001da4:	36050513          	addi	a0,a0,864 # 8000b100 <etext+0x100>
    80001da8:	fffff097          	auipc	ra,0xfffff
    80001dac:	ed2080e7          	jalr	-302(ra) # 80000c7a <panic>
    if((*pte & PTE_V) == 0)
    80001db0:	fe043783          	ld	a5,-32(s0)
    80001db4:	639c                	ld	a5,0(a5)
    80001db6:	8b85                	andi	a5,a5,1
    80001db8:	eb89                	bnez	a5,80001dca <uvmunmap+0x86>
      panic("uvmunmap: not mapped");
    80001dba:	00009517          	auipc	a0,0x9
    80001dbe:	35650513          	addi	a0,a0,854 # 8000b110 <etext+0x110>
    80001dc2:	fffff097          	auipc	ra,0xfffff
    80001dc6:	eb8080e7          	jalr	-328(ra) # 80000c7a <panic>
    if(PTE_FLAGS(*pte) == PTE_V)
    80001dca:	fe043783          	ld	a5,-32(s0)
    80001dce:	639c                	ld	a5,0(a5)
    80001dd0:	3ff7f713          	andi	a4,a5,1023
    80001dd4:	4785                	li	a5,1
    80001dd6:	00f71a63          	bne	a4,a5,80001dea <uvmunmap+0xa6>
      panic("uvmunmap: not a leaf");
    80001dda:	00009517          	auipc	a0,0x9
    80001dde:	34e50513          	addi	a0,a0,846 # 8000b128 <etext+0x128>
    80001de2:	fffff097          	auipc	ra,0xfffff
    80001de6:	e98080e7          	jalr	-360(ra) # 80000c7a <panic>
    if(do_free){
    80001dea:	fb442783          	lw	a5,-76(s0)
    80001dee:	2781                	sext.w	a5,a5
    80001df0:	cf99                	beqz	a5,80001e0e <uvmunmap+0xca>
      uint64 pa = PTE2PA(*pte);
    80001df2:	fe043783          	ld	a5,-32(s0)
    80001df6:	639c                	ld	a5,0(a5)
    80001df8:	83a9                	srli	a5,a5,0xa
    80001dfa:	07b2                	slli	a5,a5,0xc
    80001dfc:	fcf43c23          	sd	a5,-40(s0)
      kfree((void*)pa);
    80001e00:	fd843783          	ld	a5,-40(s0)
    80001e04:	853e                	mv	a0,a5
    80001e06:	fffff097          	auipc	ra,0xfffff
    80001e0a:	26c080e7          	jalr	620(ra) # 80001072 <kfree>
    }
    *pte = 0;
    80001e0e:	fe043783          	ld	a5,-32(s0)
    80001e12:	0007b023          	sd	zero,0(a5) # 1000 <_entry-0x7ffff000>
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001e16:	fe843703          	ld	a4,-24(s0)
    80001e1a:	6785                	lui	a5,0x1
    80001e1c:	97ba                	add	a5,a5,a4
    80001e1e:	fef43423          	sd	a5,-24(s0)
    80001e22:	fb843783          	ld	a5,-72(s0)
    80001e26:	00c79713          	slli	a4,a5,0xc
    80001e2a:	fc043783          	ld	a5,-64(s0)
    80001e2e:	97ba                	add	a5,a5,a4
    80001e30:	fe843703          	ld	a4,-24(s0)
    80001e34:	f4f768e3          	bltu	a4,a5,80001d84 <uvmunmap+0x40>
  }
}
    80001e38:	0001                	nop
    80001e3a:	0001                	nop
    80001e3c:	60a6                	ld	ra,72(sp)
    80001e3e:	6406                	ld	s0,64(sp)
    80001e40:	6161                	addi	sp,sp,80
    80001e42:	8082                	ret

0000000080001e44 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80001e44:	1101                	addi	sp,sp,-32
    80001e46:	ec06                	sd	ra,24(sp)
    80001e48:	e822                	sd	s0,16(sp)
    80001e4a:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80001e4c:	fffff097          	auipc	ra,0xfffff
    80001e50:	2ca080e7          	jalr	714(ra) # 80001116 <kalloc>
    80001e54:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80001e58:	fe843783          	ld	a5,-24(s0)
    80001e5c:	e399                	bnez	a5,80001e62 <uvmcreate+0x1e>
    return 0;
    80001e5e:	4781                	li	a5,0
    80001e60:	a819                	j	80001e76 <uvmcreate+0x32>
  memset(pagetable, 0, PGSIZE);
    80001e62:	6605                	lui	a2,0x1
    80001e64:	4581                	li	a1,0
    80001e66:	fe843503          	ld	a0,-24(s0)
    80001e6a:	fffff097          	auipc	ra,0xfffff
    80001e6e:	5d4080e7          	jalr	1492(ra) # 8000143e <memset>
  return pagetable;
    80001e72:	fe843783          	ld	a5,-24(s0)
}
    80001e76:	853e                	mv	a0,a5
    80001e78:	60e2                	ld	ra,24(sp)
    80001e7a:	6442                	ld	s0,16(sp)
    80001e7c:	6105                	addi	sp,sp,32
    80001e7e:	8082                	ret

0000000080001e80 <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    80001e80:	7139                	addi	sp,sp,-64
    80001e82:	fc06                	sd	ra,56(sp)
    80001e84:	f822                	sd	s0,48(sp)
    80001e86:	0080                	addi	s0,sp,64
    80001e88:	fca43c23          	sd	a0,-40(s0)
    80001e8c:	fcb43823          	sd	a1,-48(s0)
    80001e90:	87b2                	mv	a5,a2
    80001e92:	fcf42623          	sw	a5,-52(s0)
  char *mem;

  if(sz >= PGSIZE)
    80001e96:	fcc42783          	lw	a5,-52(s0)
    80001e9a:	0007871b          	sext.w	a4,a5
    80001e9e:	6785                	lui	a5,0x1
    80001ea0:	00f76a63          	bltu	a4,a5,80001eb4 <uvminit+0x34>
    panic("inituvm: more than a page");
    80001ea4:	00009517          	auipc	a0,0x9
    80001ea8:	29c50513          	addi	a0,a0,668 # 8000b140 <etext+0x140>
    80001eac:	fffff097          	auipc	ra,0xfffff
    80001eb0:	dce080e7          	jalr	-562(ra) # 80000c7a <panic>
  mem = kalloc();
    80001eb4:	fffff097          	auipc	ra,0xfffff
    80001eb8:	262080e7          	jalr	610(ra) # 80001116 <kalloc>
    80001ebc:	fea43423          	sd	a0,-24(s0)
  memset(mem, 0, PGSIZE);
    80001ec0:	6605                	lui	a2,0x1
    80001ec2:	4581                	li	a1,0
    80001ec4:	fe843503          	ld	a0,-24(s0)
    80001ec8:	fffff097          	auipc	ra,0xfffff
    80001ecc:	576080e7          	jalr	1398(ra) # 8000143e <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80001ed0:	fe843783          	ld	a5,-24(s0)
    80001ed4:	4779                	li	a4,30
    80001ed6:	86be                	mv	a3,a5
    80001ed8:	6605                	lui	a2,0x1
    80001eda:	4581                	li	a1,0
    80001edc:	fd843503          	ld	a0,-40(s0)
    80001ee0:	00000097          	auipc	ra,0x0
    80001ee4:	d86080e7          	jalr	-634(ra) # 80001c66 <mappages>
  memmove(mem, src, sz);
    80001ee8:	fcc42783          	lw	a5,-52(s0)
    80001eec:	863e                	mv	a2,a5
    80001eee:	fd043583          	ld	a1,-48(s0)
    80001ef2:	fe843503          	ld	a0,-24(s0)
    80001ef6:	fffff097          	auipc	ra,0xfffff
    80001efa:	62c080e7          	jalr	1580(ra) # 80001522 <memmove>
}
    80001efe:	0001                	nop
    80001f00:	70e2                	ld	ra,56(sp)
    80001f02:	7442                	ld	s0,48(sp)
    80001f04:	6121                	addi	sp,sp,64
    80001f06:	8082                	ret

0000000080001f08 <uvmalloc>:

// Allocate PTEs and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
uint64
uvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80001f08:	7139                	addi	sp,sp,-64
    80001f0a:	fc06                	sd	ra,56(sp)
    80001f0c:	f822                	sd	s0,48(sp)
    80001f0e:	0080                	addi	s0,sp,64
    80001f10:	fca43c23          	sd	a0,-40(s0)
    80001f14:	fcb43823          	sd	a1,-48(s0)
    80001f18:	fcc43423          	sd	a2,-56(s0)
  char *mem;
  uint64 a;

  if(newsz < oldsz)
    80001f1c:	fc843703          	ld	a4,-56(s0)
    80001f20:	fd043783          	ld	a5,-48(s0)
    80001f24:	00f77563          	bgeu	a4,a5,80001f2e <uvmalloc+0x26>
    return oldsz;
    80001f28:	fd043783          	ld	a5,-48(s0)
    80001f2c:	a85d                	j	80001fe2 <uvmalloc+0xda>

  oldsz = PGROUNDUP(oldsz);
    80001f2e:	fd043703          	ld	a4,-48(s0)
    80001f32:	6785                	lui	a5,0x1
    80001f34:	17fd                	addi	a5,a5,-1
    80001f36:	973e                	add	a4,a4,a5
    80001f38:	77fd                	lui	a5,0xfffff
    80001f3a:	8ff9                	and	a5,a5,a4
    80001f3c:	fcf43823          	sd	a5,-48(s0)
  for(a = oldsz; a < newsz; a += PGSIZE){
    80001f40:	fd043783          	ld	a5,-48(s0)
    80001f44:	fef43423          	sd	a5,-24(s0)
    80001f48:	a069                	j	80001fd2 <uvmalloc+0xca>
    mem = kalloc();
    80001f4a:	fffff097          	auipc	ra,0xfffff
    80001f4e:	1cc080e7          	jalr	460(ra) # 80001116 <kalloc>
    80001f52:	fea43023          	sd	a0,-32(s0)
    if(mem == 0){
    80001f56:	fe043783          	ld	a5,-32(s0)
    80001f5a:	ef89                	bnez	a5,80001f74 <uvmalloc+0x6c>
      uvmdealloc(pagetable, a, oldsz);
    80001f5c:	fd043603          	ld	a2,-48(s0)
    80001f60:	fe843583          	ld	a1,-24(s0)
    80001f64:	fd843503          	ld	a0,-40(s0)
    80001f68:	00000097          	auipc	ra,0x0
    80001f6c:	084080e7          	jalr	132(ra) # 80001fec <uvmdealloc>
      return 0;
    80001f70:	4781                	li	a5,0
    80001f72:	a885                	j	80001fe2 <uvmalloc+0xda>
    }
    memset(mem, 0, PGSIZE);
    80001f74:	6605                	lui	a2,0x1
    80001f76:	4581                	li	a1,0
    80001f78:	fe043503          	ld	a0,-32(s0)
    80001f7c:	fffff097          	auipc	ra,0xfffff
    80001f80:	4c2080e7          	jalr	1218(ra) # 8000143e <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    80001f84:	fe043783          	ld	a5,-32(s0)
    80001f88:	4779                	li	a4,30
    80001f8a:	86be                	mv	a3,a5
    80001f8c:	6605                	lui	a2,0x1
    80001f8e:	fe843583          	ld	a1,-24(s0)
    80001f92:	fd843503          	ld	a0,-40(s0)
    80001f96:	00000097          	auipc	ra,0x0
    80001f9a:	cd0080e7          	jalr	-816(ra) # 80001c66 <mappages>
    80001f9e:	87aa                	mv	a5,a0
    80001fa0:	c39d                	beqz	a5,80001fc6 <uvmalloc+0xbe>
      kfree(mem);
    80001fa2:	fe043503          	ld	a0,-32(s0)
    80001fa6:	fffff097          	auipc	ra,0xfffff
    80001faa:	0cc080e7          	jalr	204(ra) # 80001072 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80001fae:	fd043603          	ld	a2,-48(s0)
    80001fb2:	fe843583          	ld	a1,-24(s0)
    80001fb6:	fd843503          	ld	a0,-40(s0)
    80001fba:	00000097          	auipc	ra,0x0
    80001fbe:	032080e7          	jalr	50(ra) # 80001fec <uvmdealloc>
      return 0;
    80001fc2:	4781                	li	a5,0
    80001fc4:	a839                	j	80001fe2 <uvmalloc+0xda>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80001fc6:	fe843703          	ld	a4,-24(s0)
    80001fca:	6785                	lui	a5,0x1
    80001fcc:	97ba                	add	a5,a5,a4
    80001fce:	fef43423          	sd	a5,-24(s0)
    80001fd2:	fe843703          	ld	a4,-24(s0)
    80001fd6:	fc843783          	ld	a5,-56(s0)
    80001fda:	f6f768e3          	bltu	a4,a5,80001f4a <uvmalloc+0x42>
    }
  }
  return newsz;
    80001fde:	fc843783          	ld	a5,-56(s0)
}
    80001fe2:	853e                	mv	a0,a5
    80001fe4:	70e2                	ld	ra,56(sp)
    80001fe6:	7442                	ld	s0,48(sp)
    80001fe8:	6121                	addi	sp,sp,64
    80001fea:	8082                	ret

0000000080001fec <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80001fec:	7139                	addi	sp,sp,-64
    80001fee:	fc06                	sd	ra,56(sp)
    80001ff0:	f822                	sd	s0,48(sp)
    80001ff2:	0080                	addi	s0,sp,64
    80001ff4:	fca43c23          	sd	a0,-40(s0)
    80001ff8:	fcb43823          	sd	a1,-48(s0)
    80001ffc:	fcc43423          	sd	a2,-56(s0)
  if(newsz >= oldsz)
    80002000:	fc843703          	ld	a4,-56(s0)
    80002004:	fd043783          	ld	a5,-48(s0)
    80002008:	00f76563          	bltu	a4,a5,80002012 <uvmdealloc+0x26>
    return oldsz;
    8000200c:	fd043783          	ld	a5,-48(s0)
    80002010:	a885                	j	80002080 <uvmdealloc+0x94>

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80002012:	fc843703          	ld	a4,-56(s0)
    80002016:	6785                	lui	a5,0x1
    80002018:	17fd                	addi	a5,a5,-1
    8000201a:	973e                	add	a4,a4,a5
    8000201c:	77fd                	lui	a5,0xfffff
    8000201e:	8f7d                	and	a4,a4,a5
    80002020:	fd043683          	ld	a3,-48(s0)
    80002024:	6785                	lui	a5,0x1
    80002026:	17fd                	addi	a5,a5,-1
    80002028:	96be                	add	a3,a3,a5
    8000202a:	77fd                	lui	a5,0xfffff
    8000202c:	8ff5                	and	a5,a5,a3
    8000202e:	04f77763          	bgeu	a4,a5,8000207c <uvmdealloc+0x90>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80002032:	fd043703          	ld	a4,-48(s0)
    80002036:	6785                	lui	a5,0x1
    80002038:	17fd                	addi	a5,a5,-1
    8000203a:	973e                	add	a4,a4,a5
    8000203c:	77fd                	lui	a5,0xfffff
    8000203e:	8f7d                	and	a4,a4,a5
    80002040:	fc843683          	ld	a3,-56(s0)
    80002044:	6785                	lui	a5,0x1
    80002046:	17fd                	addi	a5,a5,-1
    80002048:	96be                	add	a3,a3,a5
    8000204a:	77fd                	lui	a5,0xfffff
    8000204c:	8ff5                	and	a5,a5,a3
    8000204e:	40f707b3          	sub	a5,a4,a5
    80002052:	83b1                	srli	a5,a5,0xc
    80002054:	fef42623          	sw	a5,-20(s0)
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80002058:	fc843703          	ld	a4,-56(s0)
    8000205c:	6785                	lui	a5,0x1
    8000205e:	17fd                	addi	a5,a5,-1
    80002060:	973e                	add	a4,a4,a5
    80002062:	77fd                	lui	a5,0xfffff
    80002064:	8ff9                	and	a5,a5,a4
    80002066:	fec42703          	lw	a4,-20(s0)
    8000206a:	4685                	li	a3,1
    8000206c:	863a                	mv	a2,a4
    8000206e:	85be                	mv	a1,a5
    80002070:	fd843503          	ld	a0,-40(s0)
    80002074:	00000097          	auipc	ra,0x0
    80002078:	cd0080e7          	jalr	-816(ra) # 80001d44 <uvmunmap>
  }

  return newsz;
    8000207c:	fc843783          	ld	a5,-56(s0)
}
    80002080:	853e                	mv	a0,a5
    80002082:	70e2                	ld	ra,56(sp)
    80002084:	7442                	ld	s0,48(sp)
    80002086:	6121                	addi	sp,sp,64
    80002088:	8082                	ret

000000008000208a <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    8000208a:	7139                	addi	sp,sp,-64
    8000208c:	fc06                	sd	ra,56(sp)
    8000208e:	f822                	sd	s0,48(sp)
    80002090:	0080                	addi	s0,sp,64
    80002092:	fca43423          	sd	a0,-56(s0)
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80002096:	fe042623          	sw	zero,-20(s0)
    8000209a:	a88d                	j	8000210c <freewalk+0x82>
    pte_t pte = pagetable[i];
    8000209c:	fec42783          	lw	a5,-20(s0)
    800020a0:	078e                	slli	a5,a5,0x3
    800020a2:	fc843703          	ld	a4,-56(s0)
    800020a6:	97ba                	add	a5,a5,a4
    800020a8:	639c                	ld	a5,0(a5)
    800020aa:	fef43023          	sd	a5,-32(s0)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800020ae:	fe043783          	ld	a5,-32(s0)
    800020b2:	8b85                	andi	a5,a5,1
    800020b4:	cb9d                	beqz	a5,800020ea <freewalk+0x60>
    800020b6:	fe043783          	ld	a5,-32(s0)
    800020ba:	8bb9                	andi	a5,a5,14
    800020bc:	e79d                	bnez	a5,800020ea <freewalk+0x60>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800020be:	fe043783          	ld	a5,-32(s0)
    800020c2:	83a9                	srli	a5,a5,0xa
    800020c4:	07b2                	slli	a5,a5,0xc
    800020c6:	fcf43c23          	sd	a5,-40(s0)
      freewalk((pagetable_t)child);
    800020ca:	fd843783          	ld	a5,-40(s0)
    800020ce:	853e                	mv	a0,a5
    800020d0:	00000097          	auipc	ra,0x0
    800020d4:	fba080e7          	jalr	-70(ra) # 8000208a <freewalk>
      pagetable[i] = 0;
    800020d8:	fec42783          	lw	a5,-20(s0)
    800020dc:	078e                	slli	a5,a5,0x3
    800020de:	fc843703          	ld	a4,-56(s0)
    800020e2:	97ba                	add	a5,a5,a4
    800020e4:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0xffffffff7fb56000>
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800020e8:	a829                	j	80002102 <freewalk+0x78>
    } else if(pte & PTE_V){
    800020ea:	fe043783          	ld	a5,-32(s0)
    800020ee:	8b85                	andi	a5,a5,1
    800020f0:	cb89                	beqz	a5,80002102 <freewalk+0x78>
      panic("freewalk: leaf");
    800020f2:	00009517          	auipc	a0,0x9
    800020f6:	06e50513          	addi	a0,a0,110 # 8000b160 <etext+0x160>
    800020fa:	fffff097          	auipc	ra,0xfffff
    800020fe:	b80080e7          	jalr	-1152(ra) # 80000c7a <panic>
  for(int i = 0; i < 512; i++){
    80002102:	fec42783          	lw	a5,-20(s0)
    80002106:	2785                	addiw	a5,a5,1
    80002108:	fef42623          	sw	a5,-20(s0)
    8000210c:	fec42783          	lw	a5,-20(s0)
    80002110:	0007871b          	sext.w	a4,a5
    80002114:	1ff00793          	li	a5,511
    80002118:	f8e7d2e3          	bge	a5,a4,8000209c <freewalk+0x12>
    }
  }
  kfree((void*)pagetable);
    8000211c:	fc843503          	ld	a0,-56(s0)
    80002120:	fffff097          	auipc	ra,0xfffff
    80002124:	f52080e7          	jalr	-174(ra) # 80001072 <kfree>
}
    80002128:	0001                	nop
    8000212a:	70e2                	ld	ra,56(sp)
    8000212c:	7442                	ld	s0,48(sp)
    8000212e:	6121                	addi	sp,sp,64
    80002130:	8082                	ret

0000000080002132 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80002132:	1101                	addi	sp,sp,-32
    80002134:	ec06                	sd	ra,24(sp)
    80002136:	e822                	sd	s0,16(sp)
    80002138:	1000                	addi	s0,sp,32
    8000213a:	fea43423          	sd	a0,-24(s0)
    8000213e:	feb43023          	sd	a1,-32(s0)
  if(sz > 0)
    80002142:	fe043783          	ld	a5,-32(s0)
    80002146:	c385                	beqz	a5,80002166 <uvmfree+0x34>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80002148:	fe043703          	ld	a4,-32(s0)
    8000214c:	6785                	lui	a5,0x1
    8000214e:	17fd                	addi	a5,a5,-1
    80002150:	97ba                	add	a5,a5,a4
    80002152:	83b1                	srli	a5,a5,0xc
    80002154:	4685                	li	a3,1
    80002156:	863e                	mv	a2,a5
    80002158:	4581                	li	a1,0
    8000215a:	fe843503          	ld	a0,-24(s0)
    8000215e:	00000097          	auipc	ra,0x0
    80002162:	be6080e7          	jalr	-1050(ra) # 80001d44 <uvmunmap>
  freewalk(pagetable);
    80002166:	fe843503          	ld	a0,-24(s0)
    8000216a:	00000097          	auipc	ra,0x0
    8000216e:	f20080e7          	jalr	-224(ra) # 8000208a <freewalk>
}
    80002172:	0001                	nop
    80002174:	60e2                	ld	ra,24(sp)
    80002176:	6442                	ld	s0,16(sp)
    80002178:	6105                	addi	sp,sp,32
    8000217a:	8082                	ret

000000008000217c <uvmcopy>:
// physical memory.
// returns 0 on success, -1 on failure.
// frees any allocated pages on failure.
int
uvmcopy(pagetable_t old, pagetable_t new, uint64 sz)
{
    8000217c:	711d                	addi	sp,sp,-96
    8000217e:	ec86                	sd	ra,88(sp)
    80002180:	e8a2                	sd	s0,80(sp)
    80002182:	1080                	addi	s0,sp,96
    80002184:	faa43c23          	sd	a0,-72(s0)
    80002188:	fab43823          	sd	a1,-80(s0)
    8000218c:	fac43423          	sd	a2,-88(s0)
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80002190:	fe043423          	sd	zero,-24(s0)
    80002194:	a0d9                	j	8000225a <uvmcopy+0xde>
    if((pte = walk(old, i, 0)) == 0)
    80002196:	4601                	li	a2,0
    80002198:	fe843583          	ld	a1,-24(s0)
    8000219c:	fb843503          	ld	a0,-72(s0)
    800021a0:	00000097          	auipc	ra,0x0
    800021a4:	902080e7          	jalr	-1790(ra) # 80001aa2 <walk>
    800021a8:	fea43023          	sd	a0,-32(s0)
    800021ac:	fe043783          	ld	a5,-32(s0)
    800021b0:	eb89                	bnez	a5,800021c2 <uvmcopy+0x46>
      panic("uvmcopy: pte should exist");
    800021b2:	00009517          	auipc	a0,0x9
    800021b6:	fbe50513          	addi	a0,a0,-66 # 8000b170 <etext+0x170>
    800021ba:	fffff097          	auipc	ra,0xfffff
    800021be:	ac0080e7          	jalr	-1344(ra) # 80000c7a <panic>
    if((*pte & PTE_V) == 0)
    800021c2:	fe043783          	ld	a5,-32(s0)
    800021c6:	639c                	ld	a5,0(a5)
    800021c8:	8b85                	andi	a5,a5,1
    800021ca:	eb89                	bnez	a5,800021dc <uvmcopy+0x60>
      panic("uvmcopy: page not present");
    800021cc:	00009517          	auipc	a0,0x9
    800021d0:	fc450513          	addi	a0,a0,-60 # 8000b190 <etext+0x190>
    800021d4:	fffff097          	auipc	ra,0xfffff
    800021d8:	aa6080e7          	jalr	-1370(ra) # 80000c7a <panic>
    pa = PTE2PA(*pte);
    800021dc:	fe043783          	ld	a5,-32(s0)
    800021e0:	639c                	ld	a5,0(a5)
    800021e2:	83a9                	srli	a5,a5,0xa
    800021e4:	07b2                	slli	a5,a5,0xc
    800021e6:	fcf43c23          	sd	a5,-40(s0)
    flags = PTE_FLAGS(*pte);
    800021ea:	fe043783          	ld	a5,-32(s0)
    800021ee:	639c                	ld	a5,0(a5)
    800021f0:	2781                	sext.w	a5,a5
    800021f2:	3ff7f793          	andi	a5,a5,1023
    800021f6:	fcf42a23          	sw	a5,-44(s0)
    if((mem = kalloc()) == 0)
    800021fa:	fffff097          	auipc	ra,0xfffff
    800021fe:	f1c080e7          	jalr	-228(ra) # 80001116 <kalloc>
    80002202:	fca43423          	sd	a0,-56(s0)
    80002206:	fc843783          	ld	a5,-56(s0)
    8000220a:	c3a5                	beqz	a5,8000226a <uvmcopy+0xee>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    8000220c:	fd843783          	ld	a5,-40(s0)
    80002210:	6605                	lui	a2,0x1
    80002212:	85be                	mv	a1,a5
    80002214:	fc843503          	ld	a0,-56(s0)
    80002218:	fffff097          	auipc	ra,0xfffff
    8000221c:	30a080e7          	jalr	778(ra) # 80001522 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80002220:	fc843783          	ld	a5,-56(s0)
    80002224:	fd442703          	lw	a4,-44(s0)
    80002228:	86be                	mv	a3,a5
    8000222a:	6605                	lui	a2,0x1
    8000222c:	fe843583          	ld	a1,-24(s0)
    80002230:	fb043503          	ld	a0,-80(s0)
    80002234:	00000097          	auipc	ra,0x0
    80002238:	a32080e7          	jalr	-1486(ra) # 80001c66 <mappages>
    8000223c:	87aa                	mv	a5,a0
    8000223e:	cb81                	beqz	a5,8000224e <uvmcopy+0xd2>
      kfree(mem);
    80002240:	fc843503          	ld	a0,-56(s0)
    80002244:	fffff097          	auipc	ra,0xfffff
    80002248:	e2e080e7          	jalr	-466(ra) # 80001072 <kfree>
      goto err;
    8000224c:	a005                	j	8000226c <uvmcopy+0xf0>
  for(i = 0; i < sz; i += PGSIZE){
    8000224e:	fe843703          	ld	a4,-24(s0)
    80002252:	6785                	lui	a5,0x1
    80002254:	97ba                	add	a5,a5,a4
    80002256:	fef43423          	sd	a5,-24(s0)
    8000225a:	fe843703          	ld	a4,-24(s0)
    8000225e:	fa843783          	ld	a5,-88(s0)
    80002262:	f2f76ae3          	bltu	a4,a5,80002196 <uvmcopy+0x1a>
    }
  }
  return 0;
    80002266:	4781                	li	a5,0
    80002268:	a839                	j	80002286 <uvmcopy+0x10a>
      goto err;
    8000226a:	0001                	nop

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    8000226c:	fe843783          	ld	a5,-24(s0)
    80002270:	83b1                	srli	a5,a5,0xc
    80002272:	4685                	li	a3,1
    80002274:	863e                	mv	a2,a5
    80002276:	4581                	li	a1,0
    80002278:	fb043503          	ld	a0,-80(s0)
    8000227c:	00000097          	auipc	ra,0x0
    80002280:	ac8080e7          	jalr	-1336(ra) # 80001d44 <uvmunmap>
  return -1;
    80002284:	57fd                	li	a5,-1
}
    80002286:	853e                	mv	a0,a5
    80002288:	60e6                	ld	ra,88(sp)
    8000228a:	6446                	ld	s0,80(sp)
    8000228c:	6125                	addi	sp,sp,96
    8000228e:	8082                	ret

0000000080002290 <uvmcopyThread>:


int
uvmcopyThread(pagetable_t old, pagetable_t new, uint64 sz)
{
    80002290:	715d                	addi	sp,sp,-80
    80002292:	e486                	sd	ra,72(sp)
    80002294:	e0a2                	sd	s0,64(sp)
    80002296:	0880                	addi	s0,sp,80
    80002298:	fca43423          	sd	a0,-56(s0)
    8000229c:	fcb43023          	sd	a1,-64(s0)
    800022a0:	fac43c23          	sd	a2,-72(s0)
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  //char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    800022a4:	fe043423          	sd	zero,-24(s0)
    800022a8:	a849                	j	8000233a <uvmcopyThread+0xaa>
    if((pte = walk(old, i, 0)) == 0)
    800022aa:	4601                	li	a2,0
    800022ac:	fe843583          	ld	a1,-24(s0)
    800022b0:	fc843503          	ld	a0,-56(s0)
    800022b4:	fffff097          	auipc	ra,0xfffff
    800022b8:	7ee080e7          	jalr	2030(ra) # 80001aa2 <walk>
    800022bc:	fea43023          	sd	a0,-32(s0)
    800022c0:	fe043783          	ld	a5,-32(s0)
    800022c4:	eb89                	bnez	a5,800022d6 <uvmcopyThread+0x46>
      panic("uvmcopy: pte should exist");
    800022c6:	00009517          	auipc	a0,0x9
    800022ca:	eaa50513          	addi	a0,a0,-342 # 8000b170 <etext+0x170>
    800022ce:	fffff097          	auipc	ra,0xfffff
    800022d2:	9ac080e7          	jalr	-1620(ra) # 80000c7a <panic>
    if((*pte & PTE_V) == 0)
    800022d6:	fe043783          	ld	a5,-32(s0)
    800022da:	639c                	ld	a5,0(a5)
    800022dc:	8b85                	andi	a5,a5,1
    800022de:	eb89                	bnez	a5,800022f0 <uvmcopyThread+0x60>
      panic("uvmcopy: page not present");
    800022e0:	00009517          	auipc	a0,0x9
    800022e4:	eb050513          	addi	a0,a0,-336 # 8000b190 <etext+0x190>
    800022e8:	fffff097          	auipc	ra,0xfffff
    800022ec:	992080e7          	jalr	-1646(ra) # 80000c7a <panic>
    pa = PTE2PA(*pte);
    800022f0:	fe043783          	ld	a5,-32(s0)
    800022f4:	639c                	ld	a5,0(a5)
    800022f6:	83a9                	srli	a5,a5,0xa
    800022f8:	07b2                	slli	a5,a5,0xc
    800022fa:	fcf43c23          	sd	a5,-40(s0)
    flags = PTE_FLAGS(*pte);
    800022fe:	fe043783          	ld	a5,-32(s0)
    80002302:	639c                	ld	a5,0(a5)
    80002304:	2781                	sext.w	a5,a5
    80002306:	3ff7f793          	andi	a5,a5,1023
    8000230a:	fcf42a23          	sw	a5,-44(s0)
    /*if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE);*/
    if(mappages(new, i, PGSIZE, (uint64)pa, flags) != 0){
    8000230e:	fd442783          	lw	a5,-44(s0)
    80002312:	873e                	mv	a4,a5
    80002314:	fd843683          	ld	a3,-40(s0)
    80002318:	6605                	lui	a2,0x1
    8000231a:	fe843583          	ld	a1,-24(s0)
    8000231e:	fc043503          	ld	a0,-64(s0)
    80002322:	00000097          	auipc	ra,0x0
    80002326:	944080e7          	jalr	-1724(ra) # 80001c66 <mappages>
    8000232a:	87aa                	mv	a5,a0
    8000232c:	ef99                	bnez	a5,8000234a <uvmcopyThread+0xba>
  for(i = 0; i < sz; i += PGSIZE){
    8000232e:	fe843703          	ld	a4,-24(s0)
    80002332:	6785                	lui	a5,0x1
    80002334:	97ba                	add	a5,a5,a4
    80002336:	fef43423          	sd	a5,-24(s0)
    8000233a:	fe843703          	ld	a4,-24(s0)
    8000233e:	fb843783          	ld	a5,-72(s0)
    80002342:	f6f764e3          	bltu	a4,a5,800022aa <uvmcopyThread+0x1a>
      goto err;
    }
  }
  return 0;
    80002346:	4781                	li	a5,0
    80002348:	a839                	j	80002366 <uvmcopyThread+0xd6>
      goto err;
    8000234a:	0001                	nop

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    8000234c:	fe843783          	ld	a5,-24(s0)
    80002350:	83b1                	srli	a5,a5,0xc
    80002352:	4685                	li	a3,1
    80002354:	863e                	mv	a2,a5
    80002356:	4581                	li	a1,0
    80002358:	fc043503          	ld	a0,-64(s0)
    8000235c:	00000097          	auipc	ra,0x0
    80002360:	9e8080e7          	jalr	-1560(ra) # 80001d44 <uvmunmap>
  return -1;
    80002364:	57fd                	li	a5,-1
}
    80002366:	853e                	mv	a0,a5
    80002368:	60a6                	ld	ra,72(sp)
    8000236a:	6406                	ld	s0,64(sp)
    8000236c:	6161                	addi	sp,sp,80
    8000236e:	8082                	ret

0000000080002370 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80002370:	7179                	addi	sp,sp,-48
    80002372:	f406                	sd	ra,40(sp)
    80002374:	f022                	sd	s0,32(sp)
    80002376:	1800                	addi	s0,sp,48
    80002378:	fca43c23          	sd	a0,-40(s0)
    8000237c:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80002380:	4601                	li	a2,0
    80002382:	fd043583          	ld	a1,-48(s0)
    80002386:	fd843503          	ld	a0,-40(s0)
    8000238a:	fffff097          	auipc	ra,0xfffff
    8000238e:	718080e7          	jalr	1816(ra) # 80001aa2 <walk>
    80002392:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    80002396:	fe843783          	ld	a5,-24(s0)
    8000239a:	eb89                	bnez	a5,800023ac <uvmclear+0x3c>
    panic("uvmclear");
    8000239c:	00009517          	auipc	a0,0x9
    800023a0:	e1450513          	addi	a0,a0,-492 # 8000b1b0 <etext+0x1b0>
    800023a4:	fffff097          	auipc	ra,0xfffff
    800023a8:	8d6080e7          	jalr	-1834(ra) # 80000c7a <panic>
  *pte &= ~PTE_U;
    800023ac:	fe843783          	ld	a5,-24(s0)
    800023b0:	639c                	ld	a5,0(a5)
    800023b2:	fef7f713          	andi	a4,a5,-17
    800023b6:	fe843783          	ld	a5,-24(s0)
    800023ba:	e398                	sd	a4,0(a5)
}
    800023bc:	0001                	nop
    800023be:	70a2                	ld	ra,40(sp)
    800023c0:	7402                	ld	s0,32(sp)
    800023c2:	6145                	addi	sp,sp,48
    800023c4:	8082                	ret

00000000800023c6 <copyout>:
// Copy from kernel to user.
// Copy len bytes from src to virtual address dstva in a given page table.
// Return 0 on success, -1 on error.
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
    800023c6:	715d                	addi	sp,sp,-80
    800023c8:	e486                	sd	ra,72(sp)
    800023ca:	e0a2                	sd	s0,64(sp)
    800023cc:	0880                	addi	s0,sp,80
    800023ce:	fca43423          	sd	a0,-56(s0)
    800023d2:	fcb43023          	sd	a1,-64(s0)
    800023d6:	fac43c23          	sd	a2,-72(s0)
    800023da:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    800023de:	a055                	j	80002482 <copyout+0xbc>
    va0 = PGROUNDDOWN(dstva);
    800023e0:	fc043703          	ld	a4,-64(s0)
    800023e4:	77fd                	lui	a5,0xfffff
    800023e6:	8ff9                	and	a5,a5,a4
    800023e8:	fef43023          	sd	a5,-32(s0)
    pa0 = walkaddr(pagetable, va0);
    800023ec:	fe043583          	ld	a1,-32(s0)
    800023f0:	fc843503          	ld	a0,-56(s0)
    800023f4:	fffff097          	auipc	ra,0xfffff
    800023f8:	7a0080e7          	jalr	1952(ra) # 80001b94 <walkaddr>
    800023fc:	fca43c23          	sd	a0,-40(s0)
    if(pa0 == 0)
    80002400:	fd843783          	ld	a5,-40(s0)
    80002404:	e399                	bnez	a5,8000240a <copyout+0x44>
      return -1;
    80002406:	57fd                	li	a5,-1
    80002408:	a049                	j	8000248a <copyout+0xc4>
    n = PGSIZE - (dstva - va0);
    8000240a:	fe043703          	ld	a4,-32(s0)
    8000240e:	fc043783          	ld	a5,-64(s0)
    80002412:	8f1d                	sub	a4,a4,a5
    80002414:	6785                	lui	a5,0x1
    80002416:	97ba                	add	a5,a5,a4
    80002418:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    8000241c:	fe843703          	ld	a4,-24(s0)
    80002420:	fb043783          	ld	a5,-80(s0)
    80002424:	00e7f663          	bgeu	a5,a4,80002430 <copyout+0x6a>
      n = len;
    80002428:	fb043783          	ld	a5,-80(s0)
    8000242c:	fef43423          	sd	a5,-24(s0)
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80002430:	fc043703          	ld	a4,-64(s0)
    80002434:	fe043783          	ld	a5,-32(s0)
    80002438:	8f1d                	sub	a4,a4,a5
    8000243a:	fd843783          	ld	a5,-40(s0)
    8000243e:	97ba                	add	a5,a5,a4
    80002440:	873e                	mv	a4,a5
    80002442:	fe843783          	ld	a5,-24(s0)
    80002446:	2781                	sext.w	a5,a5
    80002448:	863e                	mv	a2,a5
    8000244a:	fb843583          	ld	a1,-72(s0)
    8000244e:	853a                	mv	a0,a4
    80002450:	fffff097          	auipc	ra,0xfffff
    80002454:	0d2080e7          	jalr	210(ra) # 80001522 <memmove>

    len -= n;
    80002458:	fb043703          	ld	a4,-80(s0)
    8000245c:	fe843783          	ld	a5,-24(s0)
    80002460:	40f707b3          	sub	a5,a4,a5
    80002464:	faf43823          	sd	a5,-80(s0)
    src += n;
    80002468:	fb843703          	ld	a4,-72(s0)
    8000246c:	fe843783          	ld	a5,-24(s0)
    80002470:	97ba                	add	a5,a5,a4
    80002472:	faf43c23          	sd	a5,-72(s0)
    dstva = va0 + PGSIZE;
    80002476:	fe043703          	ld	a4,-32(s0)
    8000247a:	6785                	lui	a5,0x1
    8000247c:	97ba                	add	a5,a5,a4
    8000247e:	fcf43023          	sd	a5,-64(s0)
  while(len > 0){
    80002482:	fb043783          	ld	a5,-80(s0)
    80002486:	ffa9                	bnez	a5,800023e0 <copyout+0x1a>
  }
  return 0;
    80002488:	4781                	li	a5,0
}
    8000248a:	853e                	mv	a0,a5
    8000248c:	60a6                	ld	ra,72(sp)
    8000248e:	6406                	ld	s0,64(sp)
    80002490:	6161                	addi	sp,sp,80
    80002492:	8082                	ret

0000000080002494 <copyin>:
// Copy from user to kernel.
// Copy len bytes to dst from virtual address srcva in a given page table.
// Return 0 on success, -1 on error.
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
    80002494:	715d                	addi	sp,sp,-80
    80002496:	e486                	sd	ra,72(sp)
    80002498:	e0a2                	sd	s0,64(sp)
    8000249a:	0880                	addi	s0,sp,80
    8000249c:	fca43423          	sd	a0,-56(s0)
    800024a0:	fcb43023          	sd	a1,-64(s0)
    800024a4:	fac43c23          	sd	a2,-72(s0)
    800024a8:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    800024ac:	a055                	j	80002550 <copyin+0xbc>
    va0 = PGROUNDDOWN(srcva);
    800024ae:	fb843703          	ld	a4,-72(s0)
    800024b2:	77fd                	lui	a5,0xfffff
    800024b4:	8ff9                	and	a5,a5,a4
    800024b6:	fef43023          	sd	a5,-32(s0)
    pa0 = walkaddr(pagetable, va0);
    800024ba:	fe043583          	ld	a1,-32(s0)
    800024be:	fc843503          	ld	a0,-56(s0)
    800024c2:	fffff097          	auipc	ra,0xfffff
    800024c6:	6d2080e7          	jalr	1746(ra) # 80001b94 <walkaddr>
    800024ca:	fca43c23          	sd	a0,-40(s0)
    if(pa0 == 0)
    800024ce:	fd843783          	ld	a5,-40(s0)
    800024d2:	e399                	bnez	a5,800024d8 <copyin+0x44>
      return -1;
    800024d4:	57fd                	li	a5,-1
    800024d6:	a049                	j	80002558 <copyin+0xc4>
    n = PGSIZE - (srcva - va0);
    800024d8:	fe043703          	ld	a4,-32(s0)
    800024dc:	fb843783          	ld	a5,-72(s0)
    800024e0:	8f1d                	sub	a4,a4,a5
    800024e2:	6785                	lui	a5,0x1
    800024e4:	97ba                	add	a5,a5,a4
    800024e6:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    800024ea:	fe843703          	ld	a4,-24(s0)
    800024ee:	fb043783          	ld	a5,-80(s0)
    800024f2:	00e7f663          	bgeu	a5,a4,800024fe <copyin+0x6a>
      n = len;
    800024f6:	fb043783          	ld	a5,-80(s0)
    800024fa:	fef43423          	sd	a5,-24(s0)
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    800024fe:	fb843703          	ld	a4,-72(s0)
    80002502:	fe043783          	ld	a5,-32(s0)
    80002506:	8f1d                	sub	a4,a4,a5
    80002508:	fd843783          	ld	a5,-40(s0)
    8000250c:	97ba                	add	a5,a5,a4
    8000250e:	873e                	mv	a4,a5
    80002510:	fe843783          	ld	a5,-24(s0)
    80002514:	2781                	sext.w	a5,a5
    80002516:	863e                	mv	a2,a5
    80002518:	85ba                	mv	a1,a4
    8000251a:	fc043503          	ld	a0,-64(s0)
    8000251e:	fffff097          	auipc	ra,0xfffff
    80002522:	004080e7          	jalr	4(ra) # 80001522 <memmove>

    len -= n;
    80002526:	fb043703          	ld	a4,-80(s0)
    8000252a:	fe843783          	ld	a5,-24(s0)
    8000252e:	40f707b3          	sub	a5,a4,a5
    80002532:	faf43823          	sd	a5,-80(s0)
    dst += n;
    80002536:	fc043703          	ld	a4,-64(s0)
    8000253a:	fe843783          	ld	a5,-24(s0)
    8000253e:	97ba                	add	a5,a5,a4
    80002540:	fcf43023          	sd	a5,-64(s0)
    srcva = va0 + PGSIZE;
    80002544:	fe043703          	ld	a4,-32(s0)
    80002548:	6785                	lui	a5,0x1
    8000254a:	97ba                	add	a5,a5,a4
    8000254c:	faf43c23          	sd	a5,-72(s0)
  while(len > 0){
    80002550:	fb043783          	ld	a5,-80(s0)
    80002554:	ffa9                	bnez	a5,800024ae <copyin+0x1a>
  }
  return 0;
    80002556:	4781                	li	a5,0
}
    80002558:	853e                	mv	a0,a5
    8000255a:	60a6                	ld	ra,72(sp)
    8000255c:	6406                	ld	s0,64(sp)
    8000255e:	6161                	addi	sp,sp,80
    80002560:	8082                	ret

0000000080002562 <copyinstr>:
// Copy bytes to dst from virtual address srcva in a given page table,
// until a '\0', or max.
// Return 0 on success, -1 on error.
int
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
    80002562:	711d                	addi	sp,sp,-96
    80002564:	ec86                	sd	ra,88(sp)
    80002566:	e8a2                	sd	s0,80(sp)
    80002568:	1080                	addi	s0,sp,96
    8000256a:	faa43c23          	sd	a0,-72(s0)
    8000256e:	fab43823          	sd	a1,-80(s0)
    80002572:	fac43423          	sd	a2,-88(s0)
    80002576:	fad43023          	sd	a3,-96(s0)
  uint64 n, va0, pa0;
  int got_null = 0;
    8000257a:	fe042223          	sw	zero,-28(s0)

  while(got_null == 0 && max > 0){
    8000257e:	a0f1                	j	8000264a <copyinstr+0xe8>
    va0 = PGROUNDDOWN(srcva);
    80002580:	fa843703          	ld	a4,-88(s0)
    80002584:	77fd                	lui	a5,0xfffff
    80002586:	8ff9                	and	a5,a5,a4
    80002588:	fcf43823          	sd	a5,-48(s0)
    pa0 = walkaddr(pagetable, va0);
    8000258c:	fd043583          	ld	a1,-48(s0)
    80002590:	fb843503          	ld	a0,-72(s0)
    80002594:	fffff097          	auipc	ra,0xfffff
    80002598:	600080e7          	jalr	1536(ra) # 80001b94 <walkaddr>
    8000259c:	fca43423          	sd	a0,-56(s0)
    if(pa0 == 0)
    800025a0:	fc843783          	ld	a5,-56(s0)
    800025a4:	e399                	bnez	a5,800025aa <copyinstr+0x48>
      return -1;
    800025a6:	57fd                	li	a5,-1
    800025a8:	a87d                	j	80002666 <copyinstr+0x104>
    n = PGSIZE - (srcva - va0);
    800025aa:	fd043703          	ld	a4,-48(s0)
    800025ae:	fa843783          	ld	a5,-88(s0)
    800025b2:	8f1d                	sub	a4,a4,a5
    800025b4:	6785                	lui	a5,0x1
    800025b6:	97ba                	add	a5,a5,a4
    800025b8:	fef43423          	sd	a5,-24(s0)
    if(n > max)
    800025bc:	fe843703          	ld	a4,-24(s0)
    800025c0:	fa043783          	ld	a5,-96(s0)
    800025c4:	00e7f663          	bgeu	a5,a4,800025d0 <copyinstr+0x6e>
      n = max;
    800025c8:	fa043783          	ld	a5,-96(s0)
    800025cc:	fef43423          	sd	a5,-24(s0)

    char *p = (char *) (pa0 + (srcva - va0));
    800025d0:	fa843703          	ld	a4,-88(s0)
    800025d4:	fd043783          	ld	a5,-48(s0)
    800025d8:	8f1d                	sub	a4,a4,a5
    800025da:	fc843783          	ld	a5,-56(s0)
    800025de:	97ba                	add	a5,a5,a4
    800025e0:	fcf43c23          	sd	a5,-40(s0)
    while(n > 0){
    800025e4:	a891                	j	80002638 <copyinstr+0xd6>
      if(*p == '\0'){
    800025e6:	fd843783          	ld	a5,-40(s0)
    800025ea:	0007c783          	lbu	a5,0(a5) # 1000 <_entry-0x7ffff000>
    800025ee:	eb89                	bnez	a5,80002600 <copyinstr+0x9e>
        *dst = '\0';
    800025f0:	fb043783          	ld	a5,-80(s0)
    800025f4:	00078023          	sb	zero,0(a5)
        got_null = 1;
    800025f8:	4785                	li	a5,1
    800025fa:	fef42223          	sw	a5,-28(s0)
        break;
    800025fe:	a081                	j	8000263e <copyinstr+0xdc>
      } else {
        *dst = *p;
    80002600:	fd843783          	ld	a5,-40(s0)
    80002604:	0007c703          	lbu	a4,0(a5)
    80002608:	fb043783          	ld	a5,-80(s0)
    8000260c:	00e78023          	sb	a4,0(a5)
      }
      --n;
    80002610:	fe843783          	ld	a5,-24(s0)
    80002614:	17fd                	addi	a5,a5,-1
    80002616:	fef43423          	sd	a5,-24(s0)
      --max;
    8000261a:	fa043783          	ld	a5,-96(s0)
    8000261e:	17fd                	addi	a5,a5,-1
    80002620:	faf43023          	sd	a5,-96(s0)
      p++;
    80002624:	fd843783          	ld	a5,-40(s0)
    80002628:	0785                	addi	a5,a5,1
    8000262a:	fcf43c23          	sd	a5,-40(s0)
      dst++;
    8000262e:	fb043783          	ld	a5,-80(s0)
    80002632:	0785                	addi	a5,a5,1
    80002634:	faf43823          	sd	a5,-80(s0)
    while(n > 0){
    80002638:	fe843783          	ld	a5,-24(s0)
    8000263c:	f7cd                	bnez	a5,800025e6 <copyinstr+0x84>
    }

    srcva = va0 + PGSIZE;
    8000263e:	fd043703          	ld	a4,-48(s0)
    80002642:	6785                	lui	a5,0x1
    80002644:	97ba                	add	a5,a5,a4
    80002646:	faf43423          	sd	a5,-88(s0)
  while(got_null == 0 && max > 0){
    8000264a:	fe442783          	lw	a5,-28(s0)
    8000264e:	2781                	sext.w	a5,a5
    80002650:	e781                	bnez	a5,80002658 <copyinstr+0xf6>
    80002652:	fa043783          	ld	a5,-96(s0)
    80002656:	f78d                	bnez	a5,80002580 <copyinstr+0x1e>
  }
  if(got_null){
    80002658:	fe442783          	lw	a5,-28(s0)
    8000265c:	2781                	sext.w	a5,a5
    8000265e:	c399                	beqz	a5,80002664 <copyinstr+0x102>
    return 0;
    80002660:	4781                	li	a5,0
    80002662:	a011                	j	80002666 <copyinstr+0x104>
  } else {
    return -1;
    80002664:	57fd                	li	a5,-1
  }
}
    80002666:	853e                	mv	a0,a5
    80002668:	60e6                	ld	ra,88(sp)
    8000266a:	6446                	ld	s0,80(sp)
    8000266c:	6125                	addi	sp,sp,96
    8000266e:	8082                	ret

0000000080002670 <print_table>:


void
print_table(pagetable_t pagetable, int level)
{
    80002670:	7139                	addi	sp,sp,-64
    80002672:	fc06                	sd	ra,56(sp)
    80002674:	f822                	sd	s0,48(sp)
    80002676:	0080                	addi	s0,sp,64
    80002678:	fca43423          	sd	a0,-56(s0)
    8000267c:	87ae                	mv	a5,a1
    8000267e:	fcf42223          	sw	a5,-60(s0)
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80002682:	fe042623          	sw	zero,-20(s0)
    80002686:	a84d                	j	80002738 <print_table+0xc8>
    pte_t pte = pagetable[i];
    80002688:	fec42783          	lw	a5,-20(s0)
    8000268c:	078e                	slli	a5,a5,0x3
    8000268e:	fc843703          	ld	a4,-56(s0)
    80002692:	97ba                	add	a5,a5,a4
    80002694:	639c                	ld	a5,0(a5)
    80002696:	fef43023          	sd	a5,-32(s0)
    if (pte & PTE_V) {
    8000269a:	fe043783          	ld	a5,-32(s0)
    8000269e:	8b85                	andi	a5,a5,1
    800026a0:	cfa9                	beqz	a5,800026fa <print_table+0x8a>
      for (int j = 0; j <= level; j++) printf(" ..");
    800026a2:	fe042423          	sw	zero,-24(s0)
    800026a6:	a831                	j	800026c2 <print_table+0x52>
    800026a8:	00009517          	auipc	a0,0x9
    800026ac:	b1850513          	addi	a0,a0,-1256 # 8000b1c0 <etext+0x1c0>
    800026b0:	ffffe097          	auipc	ra,0xffffe
    800026b4:	374080e7          	jalr	884(ra) # 80000a24 <printf>
    800026b8:	fe842783          	lw	a5,-24(s0)
    800026bc:	2785                	addiw	a5,a5,1
    800026be:	fef42423          	sw	a5,-24(s0)
    800026c2:	fe842783          	lw	a5,-24(s0)
    800026c6:	873e                	mv	a4,a5
    800026c8:	fc442783          	lw	a5,-60(s0)
    800026cc:	2701                	sext.w	a4,a4
    800026ce:	2781                	sext.w	a5,a5
    800026d0:	fce7dce3          	bge	a5,a4,800026a8 <print_table+0x38>
      printf("%d: pte %p pa %p\n", i, pte, PTE2PA(pte));
    800026d4:	fe043783          	ld	a5,-32(s0)
    800026d8:	83a9                	srli	a5,a5,0xa
    800026da:	00c79713          	slli	a4,a5,0xc
    800026de:	fec42783          	lw	a5,-20(s0)
    800026e2:	86ba                	mv	a3,a4
    800026e4:	fe043603          	ld	a2,-32(s0)
    800026e8:	85be                	mv	a1,a5
    800026ea:	00009517          	auipc	a0,0x9
    800026ee:	ade50513          	addi	a0,a0,-1314 # 8000b1c8 <etext+0x1c8>
    800026f2:	ffffe097          	auipc	ra,0xffffe
    800026f6:	332080e7          	jalr	818(ra) # 80000a24 <printf>
    }
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800026fa:	fe043783          	ld	a5,-32(s0)
    800026fe:	8b85                	andi	a5,a5,1
    80002700:	c79d                	beqz	a5,8000272e <print_table+0xbe>
    80002702:	fe043783          	ld	a5,-32(s0)
    80002706:	8bb9                	andi	a5,a5,14
    80002708:	e39d                	bnez	a5,8000272e <print_table+0xbe>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    8000270a:	fe043783          	ld	a5,-32(s0)
    8000270e:	83a9                	srli	a5,a5,0xa
    80002710:	07b2                	slli	a5,a5,0xc
    80002712:	fcf43c23          	sd	a5,-40(s0)
      print_table((pagetable_t)child, level + 1);
    80002716:	fd843783          	ld	a5,-40(s0)
    8000271a:	fc442703          	lw	a4,-60(s0)
    8000271e:	2705                	addiw	a4,a4,1
    80002720:	2701                	sext.w	a4,a4
    80002722:	85ba                	mv	a1,a4
    80002724:	853e                	mv	a0,a5
    80002726:	00000097          	auipc	ra,0x0
    8000272a:	f4a080e7          	jalr	-182(ra) # 80002670 <print_table>
  for(int i = 0; i < 512; i++){
    8000272e:	fec42783          	lw	a5,-20(s0)
    80002732:	2785                	addiw	a5,a5,1
    80002734:	fef42623          	sw	a5,-20(s0)
    80002738:	fec42783          	lw	a5,-20(s0)
    8000273c:	0007871b          	sext.w	a4,a5
    80002740:	1ff00793          	li	a5,511
    80002744:	f4e7d2e3          	bge	a5,a4,80002688 <print_table+0x18>
    }
  }
}
    80002748:	0001                	nop
    8000274a:	0001                	nop
    8000274c:	70e2                	ld	ra,56(sp)
    8000274e:	7442                	ld	s0,48(sp)
    80002750:	6121                	addi	sp,sp,64
    80002752:	8082                	ret

0000000080002754 <vmprint>:

void vmprint(pagetable_t pagetable) {
    80002754:	1101                	addi	sp,sp,-32
    80002756:	ec06                	sd	ra,24(sp)
    80002758:	e822                	sd	s0,16(sp)
    8000275a:	1000                	addi	s0,sp,32
    8000275c:	fea43423          	sd	a0,-24(s0)
  printf("page table %p\n", pagetable);
    80002760:	fe843583          	ld	a1,-24(s0)
    80002764:	00009517          	auipc	a0,0x9
    80002768:	a7c50513          	addi	a0,a0,-1412 # 8000b1e0 <etext+0x1e0>
    8000276c:	ffffe097          	auipc	ra,0xffffe
    80002770:	2b8080e7          	jalr	696(ra) # 80000a24 <printf>
  print_table(pagetable, 0);
    80002774:	4581                	li	a1,0
    80002776:	fe843503          	ld	a0,-24(s0)
    8000277a:	00000097          	auipc	ra,0x0
    8000277e:	ef6080e7          	jalr	-266(ra) # 80002670 <print_table>
    80002782:	0001                	nop
    80002784:	60e2                	ld	ra,24(sp)
    80002786:	6442                	ld	s0,16(sp)
    80002788:	6105                	addi	sp,sp,32
    8000278a:	8082                	ret

000000008000278c <r_sstatus>:
{
    8000278c:	1101                	addi	sp,sp,-32
    8000278e:	ec22                	sd	s0,24(sp)
    80002790:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002792:	100027f3          	csrr	a5,sstatus
    80002796:	fef43423          	sd	a5,-24(s0)
  return x;
    8000279a:	fe843783          	ld	a5,-24(s0)
}
    8000279e:	853e                	mv	a0,a5
    800027a0:	6462                	ld	s0,24(sp)
    800027a2:	6105                	addi	sp,sp,32
    800027a4:	8082                	ret

00000000800027a6 <w_sstatus>:
{
    800027a6:	1101                	addi	sp,sp,-32
    800027a8:	ec22                	sd	s0,24(sp)
    800027aa:	1000                	addi	s0,sp,32
    800027ac:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800027b0:	fe843783          	ld	a5,-24(s0)
    800027b4:	10079073          	csrw	sstatus,a5
}
    800027b8:	0001                	nop
    800027ba:	6462                	ld	s0,24(sp)
    800027bc:	6105                	addi	sp,sp,32
    800027be:	8082                	ret

00000000800027c0 <intr_on>:
{
    800027c0:	1141                	addi	sp,sp,-16
    800027c2:	e406                	sd	ra,8(sp)
    800027c4:	e022                	sd	s0,0(sp)
    800027c6:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800027c8:	00000097          	auipc	ra,0x0
    800027cc:	fc4080e7          	jalr	-60(ra) # 8000278c <r_sstatus>
    800027d0:	87aa                	mv	a5,a0
    800027d2:	0027e793          	ori	a5,a5,2
    800027d6:	853e                	mv	a0,a5
    800027d8:	00000097          	auipc	ra,0x0
    800027dc:	fce080e7          	jalr	-50(ra) # 800027a6 <w_sstatus>
}
    800027e0:	0001                	nop
    800027e2:	60a2                	ld	ra,8(sp)
    800027e4:	6402                	ld	s0,0(sp)
    800027e6:	0141                	addi	sp,sp,16
    800027e8:	8082                	ret

00000000800027ea <intr_get>:
{
    800027ea:	1101                	addi	sp,sp,-32
    800027ec:	ec06                	sd	ra,24(sp)
    800027ee:	e822                	sd	s0,16(sp)
    800027f0:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    800027f2:	00000097          	auipc	ra,0x0
    800027f6:	f9a080e7          	jalr	-102(ra) # 8000278c <r_sstatus>
    800027fa:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    800027fe:	fe843783          	ld	a5,-24(s0)
    80002802:	8b89                	andi	a5,a5,2
    80002804:	00f037b3          	snez	a5,a5
    80002808:	0ff7f793          	zext.b	a5,a5
    8000280c:	2781                	sext.w	a5,a5
}
    8000280e:	853e                	mv	a0,a5
    80002810:	60e2                	ld	ra,24(sp)
    80002812:	6442                	ld	s0,16(sp)
    80002814:	6105                	addi	sp,sp,32
    80002816:	8082                	ret

0000000080002818 <r_tp>:
{
    80002818:	1101                	addi	sp,sp,-32
    8000281a:	ec22                	sd	s0,24(sp)
    8000281c:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    8000281e:	8792                	mv	a5,tp
    80002820:	fef43423          	sd	a5,-24(s0)
  return x;
    80002824:	fe843783          	ld	a5,-24(s0)
}
    80002828:	853e                	mv	a0,a5
    8000282a:	6462                	ld	s0,24(sp)
    8000282c:	6105                	addi	sp,sp,32
    8000282e:	8082                	ret

0000000080002830 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80002830:	7139                	addi	sp,sp,-64
    80002832:	fc06                	sd	ra,56(sp)
    80002834:	f822                	sd	s0,48(sp)
    80002836:	0080                	addi	s0,sp,64
    80002838:	fca43423          	sd	a0,-56(s0)
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    8000283c:	00012797          	auipc	a5,0x12
    80002840:	e5c78793          	addi	a5,a5,-420 # 80014698 <proc>
    80002844:	fef43423          	sd	a5,-24(s0)
    80002848:	a071                	j	800028d4 <proc_mapstacks+0xa4>
    char *pa = kalloc();
    8000284a:	fffff097          	auipc	ra,0xfffff
    8000284e:	8cc080e7          	jalr	-1844(ra) # 80001116 <kalloc>
    80002852:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    80002856:	fe043783          	ld	a5,-32(s0)
    8000285a:	eb89                	bnez	a5,8000286c <proc_mapstacks+0x3c>
      panic("kalloc");
    8000285c:	00009517          	auipc	a0,0x9
    80002860:	99450513          	addi	a0,a0,-1644 # 8000b1f0 <etext+0x1f0>
    80002864:	ffffe097          	auipc	ra,0xffffe
    80002868:	416080e7          	jalr	1046(ra) # 80000c7a <panic>
    uint64 va = KSTACK((int) (p - proc));
    8000286c:	fe843703          	ld	a4,-24(s0)
    80002870:	00012797          	auipc	a5,0x12
    80002874:	e2878793          	addi	a5,a5,-472 # 80014698 <proc>
    80002878:	40f707b3          	sub	a5,a4,a5
    8000287c:	4047d713          	srai	a4,a5,0x4
    80002880:	00009797          	auipc	a5,0x9
    80002884:	b5878793          	addi	a5,a5,-1192 # 8000b3d8 <etext+0x3d8>
    80002888:	639c                	ld	a5,0(a5)
    8000288a:	02f707b3          	mul	a5,a4,a5
    8000288e:	2781                	sext.w	a5,a5
    80002890:	2785                	addiw	a5,a5,1
    80002892:	2781                	sext.w	a5,a5
    80002894:	00d7979b          	slliw	a5,a5,0xd
    80002898:	2781                	sext.w	a5,a5
    8000289a:	873e                	mv	a4,a5
    8000289c:	040007b7          	lui	a5,0x4000
    800028a0:	17fd                	addi	a5,a5,-1
    800028a2:	07b2                	slli	a5,a5,0xc
    800028a4:	8f99                	sub	a5,a5,a4
    800028a6:	fcf43c23          	sd	a5,-40(s0)
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    800028aa:	fe043783          	ld	a5,-32(s0)
    800028ae:	4719                	li	a4,6
    800028b0:	6685                	lui	a3,0x1
    800028b2:	863e                	mv	a2,a5
    800028b4:	fd843583          	ld	a1,-40(s0)
    800028b8:	fc843503          	ld	a0,-56(s0)
    800028bc:	fffff097          	auipc	ra,0xfffff
    800028c0:	350080e7          	jalr	848(ra) # 80001c0c <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    800028c4:	fe843703          	ld	a4,-24(s0)
    800028c8:	67c9                	lui	a5,0x12
    800028ca:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    800028ce:	97ba                	add	a5,a5,a4
    800028d0:	fef43423          	sd	a5,-24(s0)
    800028d4:	fe843703          	ld	a4,-24(s0)
    800028d8:	00498797          	auipc	a5,0x498
    800028dc:	1c078793          	addi	a5,a5,448 # 8049aa98 <pid_lock>
    800028e0:	f6f765e3          	bltu	a4,a5,8000284a <proc_mapstacks+0x1a>
  }
}
    800028e4:	0001                	nop
    800028e6:	0001                	nop
    800028e8:	70e2                	ld	ra,56(sp)
    800028ea:	7442                	ld	s0,48(sp)
    800028ec:	6121                	addi	sp,sp,64
    800028ee:	8082                	ret

00000000800028f0 <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    800028f0:	1101                	addi	sp,sp,-32
    800028f2:	ec06                	sd	ra,24(sp)
    800028f4:	e822                	sd	s0,16(sp)
    800028f6:	1000                	addi	s0,sp,32
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    800028f8:	00009597          	auipc	a1,0x9
    800028fc:	90058593          	addi	a1,a1,-1792 # 8000b1f8 <etext+0x1f8>
    80002900:	00498517          	auipc	a0,0x498
    80002904:	19850513          	addi	a0,a0,408 # 8049aa98 <pid_lock>
    80002908:	fffff097          	auipc	ra,0xfffff
    8000290c:	932080e7          	jalr	-1742(ra) # 8000123a <initlock>
  initlock(&wait_lock, "wait_lock");
    80002910:	00009597          	auipc	a1,0x9
    80002914:	8f058593          	addi	a1,a1,-1808 # 8000b200 <etext+0x200>
    80002918:	00498517          	auipc	a0,0x498
    8000291c:	19850513          	addi	a0,a0,408 # 8049aab0 <wait_lock>
    80002920:	fffff097          	auipc	ra,0xfffff
    80002924:	91a080e7          	jalr	-1766(ra) # 8000123a <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002928:	00012797          	auipc	a5,0x12
    8000292c:	d7078793          	addi	a5,a5,-656 # 80014698 <proc>
    80002930:	fef43423          	sd	a5,-24(s0)
    80002934:	a0ad                	j	8000299e <procinit+0xae>
      initlock(&p->lock, "proc");
    80002936:	fe843783          	ld	a5,-24(s0)
    8000293a:	00009597          	auipc	a1,0x9
    8000293e:	8d658593          	addi	a1,a1,-1834 # 8000b210 <etext+0x210>
    80002942:	853e                	mv	a0,a5
    80002944:	fffff097          	auipc	ra,0xfffff
    80002948:	8f6080e7          	jalr	-1802(ra) # 8000123a <initlock>
      p->kstack = KSTACK((int) (p - proc));
    8000294c:	fe843703          	ld	a4,-24(s0)
    80002950:	00012797          	auipc	a5,0x12
    80002954:	d4878793          	addi	a5,a5,-696 # 80014698 <proc>
    80002958:	40f707b3          	sub	a5,a4,a5
    8000295c:	4047d713          	srai	a4,a5,0x4
    80002960:	00009797          	auipc	a5,0x9
    80002964:	a7878793          	addi	a5,a5,-1416 # 8000b3d8 <etext+0x3d8>
    80002968:	639c                	ld	a5,0(a5)
    8000296a:	02f707b3          	mul	a5,a4,a5
    8000296e:	2781                	sext.w	a5,a5
    80002970:	2785                	addiw	a5,a5,1
    80002972:	2781                	sext.w	a5,a5
    80002974:	00d7979b          	slliw	a5,a5,0xd
    80002978:	2781                	sext.w	a5,a5
    8000297a:	873e                	mv	a4,a5
    8000297c:	040007b7          	lui	a5,0x4000
    80002980:	17fd                	addi	a5,a5,-1
    80002982:	07b2                	slli	a5,a5,0xc
    80002984:	8f99                	sub	a5,a5,a4
    80002986:	873e                	mv	a4,a5
    80002988:	fe843783          	ld	a5,-24(s0)
    8000298c:	e3b8                	sd	a4,64(a5)
  for(p = proc; p < &proc[NPROC]; p++) {
    8000298e:	fe843703          	ld	a4,-24(s0)
    80002992:	67c9                	lui	a5,0x12
    80002994:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80002998:	97ba                	add	a5,a5,a4
    8000299a:	fef43423          	sd	a5,-24(s0)
    8000299e:	fe843703          	ld	a4,-24(s0)
    800029a2:	00498797          	auipc	a5,0x498
    800029a6:	0f678793          	addi	a5,a5,246 # 8049aa98 <pid_lock>
    800029aa:	f8f766e3          	bltu	a4,a5,80002936 <procinit+0x46>
  }
}
    800029ae:	0001                	nop
    800029b0:	0001                	nop
    800029b2:	60e2                	ld	ra,24(sp)
    800029b4:	6442                	ld	s0,16(sp)
    800029b6:	6105                	addi	sp,sp,32
    800029b8:	8082                	ret

00000000800029ba <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    800029ba:	1101                	addi	sp,sp,-32
    800029bc:	ec06                	sd	ra,24(sp)
    800029be:	e822                	sd	s0,16(sp)
    800029c0:	1000                	addi	s0,sp,32
  int id = r_tp();
    800029c2:	00000097          	auipc	ra,0x0
    800029c6:	e56080e7          	jalr	-426(ra) # 80002818 <r_tp>
    800029ca:	87aa                	mv	a5,a0
    800029cc:	fef42623          	sw	a5,-20(s0)
  return id;
    800029d0:	fec42783          	lw	a5,-20(s0)
}
    800029d4:	853e                	mv	a0,a5
    800029d6:	60e2                	ld	ra,24(sp)
    800029d8:	6442                	ld	s0,16(sp)
    800029da:	6105                	addi	sp,sp,32
    800029dc:	8082                	ret

00000000800029de <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    800029de:	1101                	addi	sp,sp,-32
    800029e0:	ec06                	sd	ra,24(sp)
    800029e2:	e822                	sd	s0,16(sp)
    800029e4:	1000                	addi	s0,sp,32
  int id = cpuid();
    800029e6:	00000097          	auipc	ra,0x0
    800029ea:	fd4080e7          	jalr	-44(ra) # 800029ba <cpuid>
    800029ee:	87aa                	mv	a5,a0
    800029f0:	fef42623          	sw	a5,-20(s0)
  struct cpu *c = &cpus[id];
    800029f4:	fec42783          	lw	a5,-20(s0)
    800029f8:	00779713          	slli	a4,a5,0x7
    800029fc:	00012797          	auipc	a5,0x12
    80002a00:	89c78793          	addi	a5,a5,-1892 # 80014298 <cpus>
    80002a04:	97ba                	add	a5,a5,a4
    80002a06:	fef43023          	sd	a5,-32(s0)
  return c;
    80002a0a:	fe043783          	ld	a5,-32(s0)
}
    80002a0e:	853e                	mv	a0,a5
    80002a10:	60e2                	ld	ra,24(sp)
    80002a12:	6442                	ld	s0,16(sp)
    80002a14:	6105                	addi	sp,sp,32
    80002a16:	8082                	ret

0000000080002a18 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80002a18:	1101                	addi	sp,sp,-32
    80002a1a:	ec06                	sd	ra,24(sp)
    80002a1c:	e822                	sd	s0,16(sp)
    80002a1e:	1000                	addi	s0,sp,32
  push_off();
    80002a20:	fffff097          	auipc	ra,0xfffff
    80002a24:	948080e7          	jalr	-1720(ra) # 80001368 <push_off>
  struct cpu *c = mycpu();
    80002a28:	00000097          	auipc	ra,0x0
    80002a2c:	fb6080e7          	jalr	-74(ra) # 800029de <mycpu>
    80002a30:	fea43423          	sd	a0,-24(s0)
  struct proc *p = c->proc;
    80002a34:	fe843783          	ld	a5,-24(s0)
    80002a38:	639c                	ld	a5,0(a5)
    80002a3a:	fef43023          	sd	a5,-32(s0)
  pop_off();
    80002a3e:	fffff097          	auipc	ra,0xfffff
    80002a42:	982080e7          	jalr	-1662(ra) # 800013c0 <pop_off>
  return p;
    80002a46:	fe043783          	ld	a5,-32(s0)
}
    80002a4a:	853e                	mv	a0,a5
    80002a4c:	60e2                	ld	ra,24(sp)
    80002a4e:	6442                	ld	s0,16(sp)
    80002a50:	6105                	addi	sp,sp,32
    80002a52:	8082                	ret

0000000080002a54 <allocpid>:

int
allocpid() {
    80002a54:	1101                	addi	sp,sp,-32
    80002a56:	ec06                	sd	ra,24(sp)
    80002a58:	e822                	sd	s0,16(sp)
    80002a5a:	1000                	addi	s0,sp,32
  int pid;
  
  acquire(&pid_lock);
    80002a5c:	00498517          	auipc	a0,0x498
    80002a60:	03c50513          	addi	a0,a0,60 # 8049aa98 <pid_lock>
    80002a64:	fffff097          	auipc	ra,0xfffff
    80002a68:	806080e7          	jalr	-2042(ra) # 8000126a <acquire>
  pid = nextpid;
    80002a6c:	00009797          	auipc	a5,0x9
    80002a70:	e6478793          	addi	a5,a5,-412 # 8000b8d0 <nextpid>
    80002a74:	439c                	lw	a5,0(a5)
    80002a76:	fef42623          	sw	a5,-20(s0)
  nextpid = nextpid + 1;
    80002a7a:	00009797          	auipc	a5,0x9
    80002a7e:	e5678793          	addi	a5,a5,-426 # 8000b8d0 <nextpid>
    80002a82:	439c                	lw	a5,0(a5)
    80002a84:	2785                	addiw	a5,a5,1
    80002a86:	0007871b          	sext.w	a4,a5
    80002a8a:	00009797          	auipc	a5,0x9
    80002a8e:	e4678793          	addi	a5,a5,-442 # 8000b8d0 <nextpid>
    80002a92:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80002a94:	00498517          	auipc	a0,0x498
    80002a98:	00450513          	addi	a0,a0,4 # 8049aa98 <pid_lock>
    80002a9c:	fffff097          	auipc	ra,0xfffff
    80002aa0:	832080e7          	jalr	-1998(ra) # 800012ce <release>

  return pid;
    80002aa4:	fec42783          	lw	a5,-20(s0)
}
    80002aa8:	853e                	mv	a0,a5
    80002aaa:	60e2                	ld	ra,24(sp)
    80002aac:	6442                	ld	s0,16(sp)
    80002aae:	6105                	addi	sp,sp,32
    80002ab0:	8082                	ret

0000000080002ab2 <allocproc>:
// If found, initialize state required to run in the kernel,
// and return with p->lock held.
// If there are no free procs, or a memory allocation fails, return 0.
static struct proc*
allocproc(void)
{
    80002ab2:	1101                	addi	sp,sp,-32
    80002ab4:	ec06                	sd	ra,24(sp)
    80002ab6:	e822                	sd	s0,16(sp)
    80002ab8:	1000                	addi	s0,sp,32
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80002aba:	00012797          	auipc	a5,0x12
    80002abe:	bde78793          	addi	a5,a5,-1058 # 80014698 <proc>
    80002ac2:	fef43423          	sd	a5,-24(s0)
    80002ac6:	a81d                	j	80002afc <allocproc+0x4a>
    acquire(&p->lock);
    80002ac8:	fe843783          	ld	a5,-24(s0)
    80002acc:	853e                	mv	a0,a5
    80002ace:	ffffe097          	auipc	ra,0xffffe
    80002ad2:	79c080e7          	jalr	1948(ra) # 8000126a <acquire>
    if(p->state == UNUSED) {
    80002ad6:	fe843783          	ld	a5,-24(s0)
    80002ada:	4f9c                	lw	a5,24(a5)
    80002adc:	cb95                	beqz	a5,80002b10 <allocproc+0x5e>
      goto found;
    } else {
      release(&p->lock);
    80002ade:	fe843783          	ld	a5,-24(s0)
    80002ae2:	853e                	mv	a0,a5
    80002ae4:	ffffe097          	auipc	ra,0xffffe
    80002ae8:	7ea080e7          	jalr	2026(ra) # 800012ce <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002aec:	fe843703          	ld	a4,-24(s0)
    80002af0:	67c9                	lui	a5,0x12
    80002af2:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80002af6:	97ba                	add	a5,a5,a4
    80002af8:	fef43423          	sd	a5,-24(s0)
    80002afc:	fe843703          	ld	a4,-24(s0)
    80002b00:	00498797          	auipc	a5,0x498
    80002b04:	f9878793          	addi	a5,a5,-104 # 8049aa98 <pid_lock>
    80002b08:	fcf760e3          	bltu	a4,a5,80002ac8 <allocproc+0x16>
    }
  }
  return 0;
    80002b0c:	4781                	li	a5,0
    80002b0e:	a8e5                	j	80002c06 <allocproc+0x154>
      goto found;
    80002b10:	0001                	nop

found:
  p->pid = allocpid();
    80002b12:	00000097          	auipc	ra,0x0
    80002b16:	f42080e7          	jalr	-190(ra) # 80002a54 <allocpid>
    80002b1a:	87aa                	mv	a5,a0
    80002b1c:	873e                	mv	a4,a5
    80002b1e:	fe843783          	ld	a5,-24(s0)
    80002b22:	db98                	sw	a4,48(a5)
  p->state = USED;
    80002b24:	fe843783          	ld	a5,-24(s0)
    80002b28:	4705                	li	a4,1
    80002b2a:	cf98                	sw	a4,24(a5)


  //inicializamos campos nuevos
  p->bottom_ustack = 0;
    80002b2c:	fe843703          	ld	a4,-24(s0)
    80002b30:	6789                	lui	a5,0x2
    80002b32:	97ba                	add	a5,a5,a4
    80002b34:	1807b023          	sd	zero,384(a5) # 2180 <_entry-0x7fffde80>
  p->top_ustack = 0;  
    80002b38:	fe843703          	ld	a4,-24(s0)
    80002b3c:	6789                	lui	a5,0x2
    80002b3e:	97ba                	add	a5,a5,a4
    80002b40:	1607bc23          	sd	zero,376(a5) # 2178 <_entry-0x7fffde88>
  p->referencias = 0;
    80002b44:	fe843703          	ld	a4,-24(s0)
    80002b48:	67c9                	lui	a5,0x12
    80002b4a:	97ba                	add	a5,a5,a4
    80002b4c:	1807a623          	sw	zero,396(a5) # 1218c <_entry-0x7ffede74>
  p->thread = 0;
    80002b50:	fe843703          	ld	a4,-24(s0)
    80002b54:	67c9                	lui	a5,0x12
    80002b56:	97ba                	add	a5,a5,a4
    80002b58:	1807a423          	sw	zero,392(a5) # 12188 <_entry-0x7ffede78>


  // Allocate a trapframe page. Se alocata para el trapframe privado
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80002b5c:	ffffe097          	auipc	ra,0xffffe
    80002b60:	5ba080e7          	jalr	1466(ra) # 80001116 <kalloc>
    80002b64:	872a                	mv	a4,a0
    80002b66:	fe843783          	ld	a5,-24(s0)
    80002b6a:	f3b8                	sd	a4,96(a5)
    80002b6c:	fe843783          	ld	a5,-24(s0)
    80002b70:	73bc                	ld	a5,96(a5)
    80002b72:	e385                	bnez	a5,80002b92 <allocproc+0xe0>
    freeproc(p);
    80002b74:	fe843503          	ld	a0,-24(s0)
    80002b78:	00000097          	auipc	ra,0x0
    80002b7c:	098080e7          	jalr	152(ra) # 80002c10 <freeproc>
    release(&p->lock);
    80002b80:	fe843783          	ld	a5,-24(s0)
    80002b84:	853e                	mv	a0,a5
    80002b86:	ffffe097          	auipc	ra,0xffffe
    80002b8a:	748080e7          	jalr	1864(ra) # 800012ce <release>
    return 0;
    80002b8e:	4781                	li	a5,0
    80002b90:	a89d                	j	80002c06 <allocproc+0x154>
  }

  // An empty user page table.
  p->pagetable = proc_pagetable(p);
    80002b92:	fe843503          	ld	a0,-24(s0)
    80002b96:	00000097          	auipc	ra,0x0
    80002b9a:	214080e7          	jalr	532(ra) # 80002daa <proc_pagetable>
    80002b9e:	872a                	mv	a4,a0
    80002ba0:	fe843783          	ld	a5,-24(s0)
    80002ba4:	ebb8                	sd	a4,80(a5)
  if(p->pagetable == 0){
    80002ba6:	fe843783          	ld	a5,-24(s0)
    80002baa:	6bbc                	ld	a5,80(a5)
    80002bac:	e385                	bnez	a5,80002bcc <allocproc+0x11a>
    freeproc(p);
    80002bae:	fe843503          	ld	a0,-24(s0)
    80002bb2:	00000097          	auipc	ra,0x0
    80002bb6:	05e080e7          	jalr	94(ra) # 80002c10 <freeproc>
    release(&p->lock);
    80002bba:	fe843783          	ld	a5,-24(s0)
    80002bbe:	853e                	mv	a0,a5
    80002bc0:	ffffe097          	auipc	ra,0xffffe
    80002bc4:	70e080e7          	jalr	1806(ra) # 800012ce <release>
    return 0;
    80002bc8:	4781                	li	a5,0
    80002bca:	a835                	j	80002c06 <allocproc+0x154>
  }

  // Set up new context to start executing at forkret,
  // which returns to user space.
  memset(&p->context, 0, sizeof(p->context));
    80002bcc:	fe843783          	ld	a5,-24(s0)
    80002bd0:	07078793          	addi	a5,a5,112
    80002bd4:	07000613          	li	a2,112
    80002bd8:	4581                	li	a1,0
    80002bda:	853e                	mv	a0,a5
    80002bdc:	fffff097          	auipc	ra,0xfffff
    80002be0:	862080e7          	jalr	-1950(ra) # 8000143e <memset>
  p->context.ra = (uint64)forkret;
    80002be4:	00001717          	auipc	a4,0x1
    80002be8:	cc070713          	addi	a4,a4,-832 # 800038a4 <forkret>
    80002bec:	fe843783          	ld	a5,-24(s0)
    80002bf0:	fbb8                	sd	a4,112(a5)
  p->context.sp = p->kstack + PGSIZE;
    80002bf2:	fe843783          	ld	a5,-24(s0)
    80002bf6:	63b8                	ld	a4,64(a5)
    80002bf8:	6785                	lui	a5,0x1
    80002bfa:	973e                	add	a4,a4,a5
    80002bfc:	fe843783          	ld	a5,-24(s0)
    80002c00:	ffb8                	sd	a4,120(a5)

  return p;
    80002c02:	fe843783          	ld	a5,-24(s0)
}
    80002c06:	853e                	mv	a0,a5
    80002c08:	60e2                	ld	ra,24(sp)
    80002c0a:	6442                	ld	s0,16(sp)
    80002c0c:	6105                	addi	sp,sp,32
    80002c0e:	8082                	ret

0000000080002c10 <freeproc>:
// free a proc structure and the data hanging from it,
// including user pages.
// p->lock must be held.
static void
freeproc(struct proc *p)
{
    80002c10:	1101                	addi	sp,sp,-32
    80002c12:	ec06                	sd	ra,24(sp)
    80002c14:	e822                	sd	s0,16(sp)
    80002c16:	1000                	addi	s0,sp,32
    80002c18:	fea43423          	sd	a0,-24(s0)
  if(p->trapframe)
    80002c1c:	fe843783          	ld	a5,-24(s0)
    80002c20:	73bc                	ld	a5,96(a5)
    80002c22:	cb89                	beqz	a5,80002c34 <freeproc+0x24>
    kfree((void*)p->trapframe);
    80002c24:	fe843783          	ld	a5,-24(s0)
    80002c28:	73bc                	ld	a5,96(a5)
    80002c2a:	853e                	mv	a0,a5
    80002c2c:	ffffe097          	auipc	ra,0xffffe
    80002c30:	446080e7          	jalr	1094(ra) # 80001072 <kfree>
  p->trapframe = 0;
    80002c34:	fe843783          	ld	a5,-24(s0)
    80002c38:	0607b023          	sd	zero,96(a5) # 1060 <_entry-0x7fffefa0>
  if(p->pagetable)
    80002c3c:	fe843783          	ld	a5,-24(s0)
    80002c40:	6bbc                	ld	a5,80(a5)
    80002c42:	cf89                	beqz	a5,80002c5c <freeproc+0x4c>
    proc_freepagetable(p->pagetable, p->sz);
    80002c44:	fe843783          	ld	a5,-24(s0)
    80002c48:	6bb8                	ld	a4,80(a5)
    80002c4a:	fe843783          	ld	a5,-24(s0)
    80002c4e:	67bc                	ld	a5,72(a5)
    80002c50:	85be                	mv	a1,a5
    80002c52:	853a                	mv	a0,a4
    80002c54:	00000097          	auipc	ra,0x0
    80002c58:	216080e7          	jalr	534(ra) # 80002e6a <proc_freepagetable>
  p->pagetable = 0;
    80002c5c:	fe843783          	ld	a5,-24(s0)
    80002c60:	0407b823          	sd	zero,80(a5)
  p->sz = 0;
    80002c64:	fe843783          	ld	a5,-24(s0)
    80002c68:	0407b423          	sd	zero,72(a5)
  p->pid = 0;
    80002c6c:	fe843783          	ld	a5,-24(s0)
    80002c70:	0207a823          	sw	zero,48(a5)
  p->parent = 0;
    80002c74:	fe843783          	ld	a5,-24(s0)
    80002c78:	0207bc23          	sd	zero,56(a5)
  p->name[0] = 0;
    80002c7c:	fe843783          	ld	a5,-24(s0)
    80002c80:	16078423          	sb	zero,360(a5)
  p->chan = 0;
    80002c84:	fe843783          	ld	a5,-24(s0)
    80002c88:	0207b023          	sd	zero,32(a5)
  p->killed = 0;
    80002c8c:	fe843783          	ld	a5,-24(s0)
    80002c90:	0207a423          	sw	zero,40(a5)
  p->xstate = 0;
    80002c94:	fe843783          	ld	a5,-24(s0)
    80002c98:	0207a623          	sw	zero,44(a5)
  p->state = UNUSED;
    80002c9c:	fe843783          	ld	a5,-24(s0)
    80002ca0:	0007ac23          	sw	zero,24(a5)
}
    80002ca4:	0001                	nop
    80002ca6:	60e2                	ld	ra,24(sp)
    80002ca8:	6442                	ld	s0,16(sp)
    80002caa:	6105                	addi	sp,sp,32
    80002cac:	8082                	ret

0000000080002cae <freethread>:


static void
freethread(struct proc *p)
{
    80002cae:	1101                	addi	sp,sp,-32
    80002cb0:	ec06                	sd	ra,24(sp)
    80002cb2:	e822                	sd	s0,16(sp)
    80002cb4:	1000                	addi	s0,sp,32
    80002cb6:	fea43423          	sd	a0,-24(s0)
  if(p->trapframe)
    80002cba:	fe843783          	ld	a5,-24(s0)
    80002cbe:	73bc                	ld	a5,96(a5)
    80002cc0:	cb89                	beqz	a5,80002cd2 <freethread+0x24>
    kfree((void*)p->trapframe);
    80002cc2:	fe843783          	ld	a5,-24(s0)
    80002cc6:	73bc                	ld	a5,96(a5)
    80002cc8:	853e                	mv	a0,a5
    80002cca:	ffffe097          	auipc	ra,0xffffe
    80002cce:	3a8080e7          	jalr	936(ra) # 80001072 <kfree>
  p->trapframe = 0;
    80002cd2:	fe843783          	ld	a5,-24(s0)
    80002cd6:	0607b023          	sd	zero,96(a5)
  if(p->pagetable){
    80002cda:	fe843783          	ld	a5,-24(s0)
    80002cde:	6bbc                	ld	a5,80(a5)
    80002ce0:	cfa5                	beqz	a5,80002d58 <freethread+0xaa>
    uvmunmap(p->pagetable, TRAMPOLINE, 1, 0);
    80002ce2:	fe843783          	ld	a5,-24(s0)
    80002ce6:	6bb8                	ld	a4,80(a5)
    80002ce8:	4681                	li	a3,0
    80002cea:	4605                	li	a2,1
    80002cec:	040007b7          	lui	a5,0x4000
    80002cf0:	17fd                	addi	a5,a5,-1
    80002cf2:	00c79593          	slli	a1,a5,0xc
    80002cf6:	853a                	mv	a0,a4
    80002cf8:	fffff097          	auipc	ra,0xfffff
    80002cfc:	04c080e7          	jalr	76(ra) # 80001d44 <uvmunmap>
    uvmunmap(p->pagetable, TRAPFRAME, 1, 0);
    80002d00:	fe843783          	ld	a5,-24(s0)
    80002d04:	6bb8                	ld	a4,80(a5)
    80002d06:	4681                	li	a3,0
    80002d08:	4605                	li	a2,1
    80002d0a:	020007b7          	lui	a5,0x2000
    80002d0e:	17fd                	addi	a5,a5,-1
    80002d10:	00d79593          	slli	a1,a5,0xd
    80002d14:	853a                	mv	a0,a4
    80002d16:	fffff097          	auipc	ra,0xfffff
    80002d1a:	02e080e7          	jalr	46(ra) # 80001d44 <uvmunmap>
    if(p->sz > 0)
    80002d1e:	fe843783          	ld	a5,-24(s0)
    80002d22:	67bc                	ld	a5,72(a5)
    80002d24:	c395                	beqz	a5,80002d48 <freethread+0x9a>
    uvmunmap(p->pagetable, 0, PGROUNDUP(p->sz)/PGSIZE, 0);
    80002d26:	fe843783          	ld	a5,-24(s0)
    80002d2a:	6ba8                	ld	a0,80(a5)
    80002d2c:	fe843783          	ld	a5,-24(s0)
    80002d30:	67b8                	ld	a4,72(a5)
    80002d32:	6785                	lui	a5,0x1
    80002d34:	17fd                	addi	a5,a5,-1
    80002d36:	97ba                	add	a5,a5,a4
    80002d38:	83b1                	srli	a5,a5,0xc
    80002d3a:	4681                	li	a3,0
    80002d3c:	863e                	mv	a2,a5
    80002d3e:	4581                	li	a1,0
    80002d40:	fffff097          	auipc	ra,0xfffff
    80002d44:	004080e7          	jalr	4(ra) # 80001d44 <uvmunmap>
    kfree((void*)p->pagetable);
    80002d48:	fe843783          	ld	a5,-24(s0)
    80002d4c:	6bbc                	ld	a5,80(a5)
    80002d4e:	853e                	mv	a0,a5
    80002d50:	ffffe097          	auipc	ra,0xffffe
    80002d54:	322080e7          	jalr	802(ra) # 80001072 <kfree>

  }
  p->pagetable = 0;
    80002d58:	fe843783          	ld	a5,-24(s0)
    80002d5c:	0407b823          	sd	zero,80(a5) # 1050 <_entry-0x7fffefb0>
  p->sz = 0;
    80002d60:	fe843783          	ld	a5,-24(s0)
    80002d64:	0407b423          	sd	zero,72(a5)
  p->pid = 0;
    80002d68:	fe843783          	ld	a5,-24(s0)
    80002d6c:	0207a823          	sw	zero,48(a5)
  p->parent = 0;
    80002d70:	fe843783          	ld	a5,-24(s0)
    80002d74:	0207bc23          	sd	zero,56(a5)
  p->name[0] = 0;
    80002d78:	fe843783          	ld	a5,-24(s0)
    80002d7c:	16078423          	sb	zero,360(a5)
  p->chan = 0;
    80002d80:	fe843783          	ld	a5,-24(s0)
    80002d84:	0207b023          	sd	zero,32(a5)
  p->killed = 0;
    80002d88:	fe843783          	ld	a5,-24(s0)
    80002d8c:	0207a423          	sw	zero,40(a5)
  p->xstate = 0;
    80002d90:	fe843783          	ld	a5,-24(s0)
    80002d94:	0207a623          	sw	zero,44(a5)
  p->state = UNUSED;
    80002d98:	fe843783          	ld	a5,-24(s0)
    80002d9c:	0007ac23          	sw	zero,24(a5)
}
    80002da0:	0001                	nop
    80002da2:	60e2                	ld	ra,24(sp)
    80002da4:	6442                	ld	s0,16(sp)
    80002da6:	6105                	addi	sp,sp,32
    80002da8:	8082                	ret

0000000080002daa <proc_pagetable>:

// Create a user page table for a given process,
// with no user memory, but with trampoline pages.
pagetable_t
proc_pagetable(struct proc *p)
{
    80002daa:	7179                	addi	sp,sp,-48
    80002dac:	f406                	sd	ra,40(sp)
    80002dae:	f022                	sd	s0,32(sp)
    80002db0:	1800                	addi	s0,sp,48
    80002db2:	fca43c23          	sd	a0,-40(s0)
  pagetable_t pagetable;

  // An empty page table.
  pagetable = uvmcreate();
    80002db6:	fffff097          	auipc	ra,0xfffff
    80002dba:	08e080e7          	jalr	142(ra) # 80001e44 <uvmcreate>
    80002dbe:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80002dc2:	fe843783          	ld	a5,-24(s0)
    80002dc6:	e399                	bnez	a5,80002dcc <proc_pagetable+0x22>
    return 0;
    80002dc8:	4781                	li	a5,0
    80002dca:	a859                	j	80002e60 <proc_pagetable+0xb6>

  // map the trampoline code (for system call return)
  // at the highest user virtual address.
  // only the supervisor uses it, on the way
  // to/from user space, so not PTE_U.
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80002dcc:	00007797          	auipc	a5,0x7
    80002dd0:	23478793          	addi	a5,a5,564 # 8000a000 <_trampoline>
    80002dd4:	4729                	li	a4,10
    80002dd6:	86be                	mv	a3,a5
    80002dd8:	6605                	lui	a2,0x1
    80002dda:	040007b7          	lui	a5,0x4000
    80002dde:	17fd                	addi	a5,a5,-1
    80002de0:	00c79593          	slli	a1,a5,0xc
    80002de4:	fe843503          	ld	a0,-24(s0)
    80002de8:	fffff097          	auipc	ra,0xfffff
    80002dec:	e7e080e7          	jalr	-386(ra) # 80001c66 <mappages>
    80002df0:	87aa                	mv	a5,a0
    80002df2:	0007db63          	bgez	a5,80002e08 <proc_pagetable+0x5e>
              (uint64)trampoline, PTE_R | PTE_X) < 0){
    uvmfree(pagetable, 0);
    80002df6:	4581                	li	a1,0
    80002df8:	fe843503          	ld	a0,-24(s0)
    80002dfc:	fffff097          	auipc	ra,0xfffff
    80002e00:	336080e7          	jalr	822(ra) # 80002132 <uvmfree>
    return 0;
    80002e04:	4781                	li	a5,0
    80002e06:	a8a9                	j	80002e60 <proc_pagetable+0xb6>
  }

  // map the trapframe just below TRAMPOLINE, for trampoline.S.
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
              (uint64)(p->trapframe), PTE_R | PTE_W) < 0){
    80002e08:	fd843783          	ld	a5,-40(s0)
    80002e0c:	73bc                	ld	a5,96(a5)
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80002e0e:	4719                	li	a4,6
    80002e10:	86be                	mv	a3,a5
    80002e12:	6605                	lui	a2,0x1
    80002e14:	020007b7          	lui	a5,0x2000
    80002e18:	17fd                	addi	a5,a5,-1
    80002e1a:	00d79593          	slli	a1,a5,0xd
    80002e1e:	fe843503          	ld	a0,-24(s0)
    80002e22:	fffff097          	auipc	ra,0xfffff
    80002e26:	e44080e7          	jalr	-444(ra) # 80001c66 <mappages>
    80002e2a:	87aa                	mv	a5,a0
    80002e2c:	0207d863          	bgez	a5,80002e5c <proc_pagetable+0xb2>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002e30:	4681                	li	a3,0
    80002e32:	4605                	li	a2,1
    80002e34:	040007b7          	lui	a5,0x4000
    80002e38:	17fd                	addi	a5,a5,-1
    80002e3a:	00c79593          	slli	a1,a5,0xc
    80002e3e:	fe843503          	ld	a0,-24(s0)
    80002e42:	fffff097          	auipc	ra,0xfffff
    80002e46:	f02080e7          	jalr	-254(ra) # 80001d44 <uvmunmap>
    uvmfree(pagetable, 0);
    80002e4a:	4581                	li	a1,0
    80002e4c:	fe843503          	ld	a0,-24(s0)
    80002e50:	fffff097          	auipc	ra,0xfffff
    80002e54:	2e2080e7          	jalr	738(ra) # 80002132 <uvmfree>
    return 0;
    80002e58:	4781                	li	a5,0
    80002e5a:	a019                	j	80002e60 <proc_pagetable+0xb6>
  }

  return pagetable;
    80002e5c:	fe843783          	ld	a5,-24(s0)
}
    80002e60:	853e                	mv	a0,a5
    80002e62:	70a2                	ld	ra,40(sp)
    80002e64:	7402                	ld	s0,32(sp)
    80002e66:	6145                	addi	sp,sp,48
    80002e68:	8082                	ret

0000000080002e6a <proc_freepagetable>:

// Free a process's page table, and free the
// physical memory it refers to.
void
proc_freepagetable(pagetable_t pagetable, uint64 sz)
{
    80002e6a:	1101                	addi	sp,sp,-32
    80002e6c:	ec06                	sd	ra,24(sp)
    80002e6e:	e822                	sd	s0,16(sp)
    80002e70:	1000                	addi	s0,sp,32
    80002e72:	fea43423          	sd	a0,-24(s0)
    80002e76:	feb43023          	sd	a1,-32(s0)
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002e7a:	4681                	li	a3,0
    80002e7c:	4605                	li	a2,1
    80002e7e:	040007b7          	lui	a5,0x4000
    80002e82:	17fd                	addi	a5,a5,-1
    80002e84:	00c79593          	slli	a1,a5,0xc
    80002e88:	fe843503          	ld	a0,-24(s0)
    80002e8c:	fffff097          	auipc	ra,0xfffff
    80002e90:	eb8080e7          	jalr	-328(ra) # 80001d44 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80002e94:	4681                	li	a3,0
    80002e96:	4605                	li	a2,1
    80002e98:	020007b7          	lui	a5,0x2000
    80002e9c:	17fd                	addi	a5,a5,-1
    80002e9e:	00d79593          	slli	a1,a5,0xd
    80002ea2:	fe843503          	ld	a0,-24(s0)
    80002ea6:	fffff097          	auipc	ra,0xfffff
    80002eaa:	e9e080e7          	jalr	-354(ra) # 80001d44 <uvmunmap>
  uvmfree(pagetable, sz);
    80002eae:	fe043583          	ld	a1,-32(s0)
    80002eb2:	fe843503          	ld	a0,-24(s0)
    80002eb6:	fffff097          	auipc	ra,0xfffff
    80002eba:	27c080e7          	jalr	636(ra) # 80002132 <uvmfree>
}
    80002ebe:	0001                	nop
    80002ec0:	60e2                	ld	ra,24(sp)
    80002ec2:	6442                	ld	s0,16(sp)
    80002ec4:	6105                	addi	sp,sp,32
    80002ec6:	8082                	ret

0000000080002ec8 <userinit>:
};

// Set up first user process.
void
userinit(void)
{
    80002ec8:	1101                	addi	sp,sp,-32
    80002eca:	ec06                	sd	ra,24(sp)
    80002ecc:	e822                	sd	s0,16(sp)
    80002ece:	1000                	addi	s0,sp,32
  struct proc *p;

  p = allocproc();
    80002ed0:	00000097          	auipc	ra,0x0
    80002ed4:	be2080e7          	jalr	-1054(ra) # 80002ab2 <allocproc>
    80002ed8:	fea43423          	sd	a0,-24(s0)
  initproc = p;
    80002edc:	00009797          	auipc	a5,0x9
    80002ee0:	14478793          	addi	a5,a5,324 # 8000c020 <initproc>
    80002ee4:	fe843703          	ld	a4,-24(s0)
    80002ee8:	e398                	sd	a4,0(a5)
  
  // allocate one user page and copy init's instructions
  // and data into it.
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80002eea:	fe843783          	ld	a5,-24(s0)
    80002eee:	6bbc                	ld	a5,80(a5)
    80002ef0:	03400613          	li	a2,52
    80002ef4:	00009597          	auipc	a1,0x9
    80002ef8:	a0458593          	addi	a1,a1,-1532 # 8000b8f8 <initcode>
    80002efc:	853e                	mv	a0,a5
    80002efe:	fffff097          	auipc	ra,0xfffff
    80002f02:	f82080e7          	jalr	-126(ra) # 80001e80 <uvminit>
  p->sz = PGSIZE;
    80002f06:	fe843783          	ld	a5,-24(s0)
    80002f0a:	6705                	lui	a4,0x1
    80002f0c:	e7b8                	sd	a4,72(a5)

  // prepare for the very first "return" from kernel to user.
  p->trapframe->epc = 0;      // user program counter
    80002f0e:	fe843783          	ld	a5,-24(s0)
    80002f12:	73bc                	ld	a5,96(a5)
    80002f14:	0007bc23          	sd	zero,24(a5)
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80002f18:	fe843783          	ld	a5,-24(s0)
    80002f1c:	73bc                	ld	a5,96(a5)
    80002f1e:	6705                	lui	a4,0x1
    80002f20:	fb98                	sd	a4,48(a5)

  safestrcpy(p->name, "initcode", sizeof(p->name));
    80002f22:	fe843783          	ld	a5,-24(s0)
    80002f26:	16878793          	addi	a5,a5,360
    80002f2a:	4641                	li	a2,16
    80002f2c:	00008597          	auipc	a1,0x8
    80002f30:	2ec58593          	addi	a1,a1,748 # 8000b218 <etext+0x218>
    80002f34:	853e                	mv	a0,a5
    80002f36:	fffff097          	auipc	ra,0xfffff
    80002f3a:	80c080e7          	jalr	-2036(ra) # 80001742 <safestrcpy>
  p->cwd = namei("/");
    80002f3e:	00008517          	auipc	a0,0x8
    80002f42:	2ea50513          	addi	a0,a0,746 # 8000b228 <etext+0x228>
    80002f46:	00004097          	auipc	ra,0x4
    80002f4a:	902080e7          	jalr	-1790(ra) # 80006848 <namei>
    80002f4e:	872a                	mv	a4,a0
    80002f50:	fe843783          	ld	a5,-24(s0)
    80002f54:	16e7b023          	sd	a4,352(a5)

  p->state = RUNNABLE;
    80002f58:	fe843783          	ld	a5,-24(s0)
    80002f5c:	470d                	li	a4,3
    80002f5e:	cf98                	sw	a4,24(a5)

  release(&p->lock);
    80002f60:	fe843783          	ld	a5,-24(s0)
    80002f64:	853e                	mv	a0,a5
    80002f66:	ffffe097          	auipc	ra,0xffffe
    80002f6a:	368080e7          	jalr	872(ra) # 800012ce <release>
}
    80002f6e:	0001                	nop
    80002f70:	60e2                	ld	ra,24(sp)
    80002f72:	6442                	ld	s0,16(sp)
    80002f74:	6105                	addi	sp,sp,32
    80002f76:	8082                	ret

0000000080002f78 <growproc>:

// Grow or shrink user memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
    80002f78:	7179                	addi	sp,sp,-48
    80002f7a:	f406                	sd	ra,40(sp)
    80002f7c:	f022                	sd	s0,32(sp)
    80002f7e:	1800                	addi	s0,sp,48
    80002f80:	87aa                	mv	a5,a0
    80002f82:	fcf42e23          	sw	a5,-36(s0)
  uint sz;
  struct proc *p = myproc();
    80002f86:	00000097          	auipc	ra,0x0
    80002f8a:	a92080e7          	jalr	-1390(ra) # 80002a18 <myproc>
    80002f8e:	fea43023          	sd	a0,-32(s0)

  sz = p->sz;
    80002f92:	fe043783          	ld	a5,-32(s0)
    80002f96:	67bc                	ld	a5,72(a5)
    80002f98:	fef42623          	sw	a5,-20(s0)
  if(n > 0){
    80002f9c:	fdc42783          	lw	a5,-36(s0)
    80002fa0:	2781                	sext.w	a5,a5
    80002fa2:	02f05f63          	blez	a5,80002fe0 <growproc+0x68>
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80002fa6:	fe043783          	ld	a5,-32(s0)
    80002faa:	6bb8                	ld	a4,80(a5)
    80002fac:	fec46683          	lwu	a3,-20(s0)
    80002fb0:	fdc42783          	lw	a5,-36(s0)
    80002fb4:	fec42603          	lw	a2,-20(s0)
    80002fb8:	9fb1                	addw	a5,a5,a2
    80002fba:	2781                	sext.w	a5,a5
    80002fbc:	1782                	slli	a5,a5,0x20
    80002fbe:	9381                	srli	a5,a5,0x20
    80002fc0:	863e                	mv	a2,a5
    80002fc2:	85b6                	mv	a1,a3
    80002fc4:	853a                	mv	a0,a4
    80002fc6:	fffff097          	auipc	ra,0xfffff
    80002fca:	f42080e7          	jalr	-190(ra) # 80001f08 <uvmalloc>
    80002fce:	87aa                	mv	a5,a0
    80002fd0:	fef42623          	sw	a5,-20(s0)
    80002fd4:	fec42783          	lw	a5,-20(s0)
    80002fd8:	2781                	sext.w	a5,a5
    80002fda:	ef9d                	bnez	a5,80003018 <growproc+0xa0>
      return -1;
    80002fdc:	57fd                	li	a5,-1
    80002fde:	a099                	j	80003024 <growproc+0xac>
    }
  } else if(n < 0){
    80002fe0:	fdc42783          	lw	a5,-36(s0)
    80002fe4:	2781                	sext.w	a5,a5
    80002fe6:	0207d963          	bgez	a5,80003018 <growproc+0xa0>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80002fea:	fe043783          	ld	a5,-32(s0)
    80002fee:	6bb8                	ld	a4,80(a5)
    80002ff0:	fec46683          	lwu	a3,-20(s0)
    80002ff4:	fdc42783          	lw	a5,-36(s0)
    80002ff8:	fec42603          	lw	a2,-20(s0)
    80002ffc:	9fb1                	addw	a5,a5,a2
    80002ffe:	2781                	sext.w	a5,a5
    80003000:	1782                	slli	a5,a5,0x20
    80003002:	9381                	srli	a5,a5,0x20
    80003004:	863e                	mv	a2,a5
    80003006:	85b6                	mv	a1,a3
    80003008:	853a                	mv	a0,a4
    8000300a:	fffff097          	auipc	ra,0xfffff
    8000300e:	fe2080e7          	jalr	-30(ra) # 80001fec <uvmdealloc>
    80003012:	87aa                	mv	a5,a0
    80003014:	fef42623          	sw	a5,-20(s0)
  }
  p->sz = sz;
    80003018:	fec46703          	lwu	a4,-20(s0)
    8000301c:	fe043783          	ld	a5,-32(s0)
    80003020:	e7b8                	sd	a4,72(a5)
  return 0;
    80003022:	4781                	li	a5,0
}
    80003024:	853e                	mv	a0,a5
    80003026:	70a2                	ld	ra,40(sp)
    80003028:	7402                	ld	s0,32(sp)
    8000302a:	6145                	addi	sp,sp,48
    8000302c:	8082                	ret

000000008000302e <check_grow_threads>:



int check_grow_threads (struct proc *parent, int n, int sz)
{
    8000302e:	7179                	addi	sp,sp,-48
    80003030:	f406                	sd	ra,40(sp)
    80003032:	f022                	sd	s0,32(sp)
    80003034:	1800                	addi	s0,sp,48
    80003036:	fca43c23          	sd	a0,-40(s0)
    8000303a:	87ae                	mv	a5,a1
    8000303c:	8732                	mv	a4,a2
    8000303e:	fcf42a23          	sw	a5,-44(s0)
    80003042:	87ba                	mv	a5,a4
    80003044:	fcf42823          	sw	a5,-48(s0)
  struct proc *np;
  for(np = proc; np < &proc[NPROC]; np++){
    80003048:	00011797          	auipc	a5,0x11
    8000304c:	65078793          	addi	a5,a5,1616 # 80014698 <proc>
    80003050:	fef43423          	sd	a5,-24(s0)
    80003054:	a0bd                	j	800030c2 <check_grow_threads+0x94>
      if(np->parent == parent && np->thread == 1){
    80003056:	fe843783          	ld	a5,-24(s0)
    8000305a:	7f9c                	ld	a5,56(a5)
    8000305c:	fd843703          	ld	a4,-40(s0)
    80003060:	04f71963          	bne	a4,a5,800030b2 <check_grow_threads+0x84>
    80003064:	fe843703          	ld	a4,-24(s0)
    80003068:	67c9                	lui	a5,0x12
    8000306a:	97ba                	add	a5,a5,a4
    8000306c:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    80003070:	873e                	mv	a4,a5
    80003072:	4785                	li	a5,1
    80003074:	02f71f63          	bne	a4,a5,800030b2 <check_grow_threads+0x84>
        if((growproc_thread(parent->pagetable, np->pagetable, sz, n))<0){
    80003078:	fd843783          	ld	a5,-40(s0)
    8000307c:	6bb8                	ld	a4,80(a5)
    8000307e:	fe843783          	ld	a5,-24(s0)
    80003082:	6bbc                	ld	a5,80(a5)
    80003084:	fd042603          	lw	a2,-48(s0)
    80003088:	fd442683          	lw	a3,-44(s0)
    8000308c:	85be                	mv	a1,a5
    8000308e:	853a                	mv	a0,a4
    80003090:	00000097          	auipc	ra,0x0
    80003094:	04e080e7          	jalr	78(ra) # 800030de <growproc_thread>
    80003098:	87aa                	mv	a5,a0
    8000309a:	0007dc63          	bgez	a5,800030b2 <check_grow_threads+0x84>
          printf ("Fallo al expandir en los hijos.\n");
    8000309e:	00008517          	auipc	a0,0x8
    800030a2:	19250513          	addi	a0,a0,402 # 8000b230 <etext+0x230>
    800030a6:	ffffe097          	auipc	ra,0xffffe
    800030aa:	97e080e7          	jalr	-1666(ra) # 80000a24 <printf>
          return -1;
    800030ae:	57fd                	li	a5,-1
    800030b0:	a015                	j	800030d4 <check_grow_threads+0xa6>
  for(np = proc; np < &proc[NPROC]; np++){
    800030b2:	fe843703          	ld	a4,-24(s0)
    800030b6:	67c9                	lui	a5,0x12
    800030b8:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    800030bc:	97ba                	add	a5,a5,a4
    800030be:	fef43423          	sd	a5,-24(s0)
    800030c2:	fe843703          	ld	a4,-24(s0)
    800030c6:	00498797          	auipc	a5,0x498
    800030ca:	9d278793          	addi	a5,a5,-1582 # 8049aa98 <pid_lock>
    800030ce:	f8f764e3          	bltu	a4,a5,80003056 <check_grow_threads+0x28>
        }

      }
  }

  return 0;
    800030d2:	4781                	li	a5,0
}
    800030d4:	853e                	mv	a0,a5
    800030d6:	70a2                	ld	ra,40(sp)
    800030d8:	7402                	ld	s0,32(sp)
    800030da:	6145                	addi	sp,sp,48
    800030dc:	8082                	ret

00000000800030de <growproc_thread>:



int
growproc_thread(pagetable_t old, pagetable_t new, uint64 sz, int n)
{
    800030de:	715d                	addi	sp,sp,-80
    800030e0:	e486                	sd	ra,72(sp)
    800030e2:	e0a2                	sd	s0,64(sp)
    800030e4:	0880                	addi	s0,sp,80
    800030e6:	fca43423          	sd	a0,-56(s0)
    800030ea:	fcb43023          	sd	a1,-64(s0)
    800030ee:	fac43c23          	sd	a2,-72(s0)
    800030f2:	87b6                	mv	a5,a3
    800030f4:	faf42a23          	sw	a5,-76(s0)
  pte_t *pte;
  uint64 pa, i;
  uint flags;

  for(i = sz; i < sz + n; i += PGSIZE){
    800030f8:	fb843783          	ld	a5,-72(s0)
    800030fc:	fef43423          	sd	a5,-24(s0)
    80003100:	a849                	j	80003192 <growproc_thread+0xb4>
    if((pte = walk(old, i, 0)) == 0)
    80003102:	4601                	li	a2,0
    80003104:	fe843583          	ld	a1,-24(s0)
    80003108:	fc843503          	ld	a0,-56(s0)
    8000310c:	fffff097          	auipc	ra,0xfffff
    80003110:	996080e7          	jalr	-1642(ra) # 80001aa2 <walk>
    80003114:	fea43023          	sd	a0,-32(s0)
    80003118:	fe043783          	ld	a5,-32(s0)
    8000311c:	eb89                	bnez	a5,8000312e <growproc_thread+0x50>
      panic("uvmcopy: pte should exist");
    8000311e:	00008517          	auipc	a0,0x8
    80003122:	13a50513          	addi	a0,a0,314 # 8000b258 <etext+0x258>
    80003126:	ffffe097          	auipc	ra,0xffffe
    8000312a:	b54080e7          	jalr	-1196(ra) # 80000c7a <panic>
    if((*pte & PTE_V) == 0)
    8000312e:	fe043783          	ld	a5,-32(s0)
    80003132:	639c                	ld	a5,0(a5)
    80003134:	8b85                	andi	a5,a5,1
    80003136:	eb89                	bnez	a5,80003148 <growproc_thread+0x6a>
      panic("uvmcopy: page not present");
    80003138:	00008517          	auipc	a0,0x8
    8000313c:	14050513          	addi	a0,a0,320 # 8000b278 <etext+0x278>
    80003140:	ffffe097          	auipc	ra,0xffffe
    80003144:	b3a080e7          	jalr	-1222(ra) # 80000c7a <panic>
    pa = PTE2PA(*pte);
    80003148:	fe043783          	ld	a5,-32(s0)
    8000314c:	639c                	ld	a5,0(a5)
    8000314e:	83a9                	srli	a5,a5,0xa
    80003150:	07b2                	slli	a5,a5,0xc
    80003152:	fcf43c23          	sd	a5,-40(s0)
    flags = PTE_FLAGS(*pte);
    80003156:	fe043783          	ld	a5,-32(s0)
    8000315a:	639c                	ld	a5,0(a5)
    8000315c:	2781                	sext.w	a5,a5
    8000315e:	3ff7f793          	andi	a5,a5,1023
    80003162:	fcf42a23          	sw	a5,-44(s0)
    /*if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE);*/
    if(mappages(new, i, PGSIZE, (uint64)pa, flags) != 0){
    80003166:	fd442783          	lw	a5,-44(s0)
    8000316a:	873e                	mv	a4,a5
    8000316c:	fd843683          	ld	a3,-40(s0)
    80003170:	6605                	lui	a2,0x1
    80003172:	fe843583          	ld	a1,-24(s0)
    80003176:	fc043503          	ld	a0,-64(s0)
    8000317a:	fffff097          	auipc	ra,0xfffff
    8000317e:	aec080e7          	jalr	-1300(ra) # 80001c66 <mappages>
    80003182:	87aa                	mv	a5,a0
    80003184:	e395                	bnez	a5,800031a8 <growproc_thread+0xca>
  for(i = sz; i < sz + n; i += PGSIZE){
    80003186:	fe843703          	ld	a4,-24(s0)
    8000318a:	6785                	lui	a5,0x1
    8000318c:	97ba                	add	a5,a5,a4
    8000318e:	fef43423          	sd	a5,-24(s0)
    80003192:	fb442703          	lw	a4,-76(s0)
    80003196:	fb843783          	ld	a5,-72(s0)
    8000319a:	97ba                	add	a5,a5,a4
    8000319c:	fe843703          	ld	a4,-24(s0)
    800031a0:	f6f761e3          	bltu	a4,a5,80003102 <growproc_thread+0x24>
      goto err;
    }
  }
  return 0;
    800031a4:	4781                	li	a5,0
    800031a6:	a839                	j	800031c4 <growproc_thread+0xe6>
      goto err;
    800031a8:	0001                	nop

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    800031aa:	fe843783          	ld	a5,-24(s0)
    800031ae:	83b1                	srli	a5,a5,0xc
    800031b0:	4685                	li	a3,1
    800031b2:	863e                	mv	a2,a5
    800031b4:	4581                	li	a1,0
    800031b6:	fc043503          	ld	a0,-64(s0)
    800031ba:	fffff097          	auipc	ra,0xfffff
    800031be:	b8a080e7          	jalr	-1142(ra) # 80001d44 <uvmunmap>
  return -1;
    800031c2:	57fd                	li	a5,-1
}
    800031c4:	853e                	mv	a0,a5
    800031c6:	60a6                	ld	ra,72(sp)
    800031c8:	6406                	ld	s0,64(sp)
    800031ca:	6161                	addi	sp,sp,80
    800031cc:	8082                	ret

00000000800031ce <fork>:

// Create a new process, copying the parent.
// Sets up child kernel stack to return as if from fork() system call.
int
fork(void)
{
    800031ce:	7179                	addi	sp,sp,-48
    800031d0:	f406                	sd	ra,40(sp)
    800031d2:	f022                	sd	s0,32(sp)
    800031d4:	1800                	addi	s0,sp,48
  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    800031d6:	00000097          	auipc	ra,0x0
    800031da:	842080e7          	jalr	-1982(ra) # 80002a18 <myproc>
    800031de:	fea43023          	sd	a0,-32(s0)

  // Allocate process.
  if((np = allocproc()) == 0){
    800031e2:	00000097          	auipc	ra,0x0
    800031e6:	8d0080e7          	jalr	-1840(ra) # 80002ab2 <allocproc>
    800031ea:	fca43c23          	sd	a0,-40(s0)
    800031ee:	fd843783          	ld	a5,-40(s0)
    800031f2:	e399                	bnez	a5,800031f8 <fork+0x2a>
    return -1;
    800031f4:	57fd                	li	a5,-1
    800031f6:	aab5                	j	80003372 <fork+0x1a4>
  }

  // Copy user memory from parent to child.
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    800031f8:	fe043783          	ld	a5,-32(s0)
    800031fc:	6bb8                	ld	a4,80(a5)
    800031fe:	fd843783          	ld	a5,-40(s0)
    80003202:	6bb4                	ld	a3,80(a5)
    80003204:	fe043783          	ld	a5,-32(s0)
    80003208:	67bc                	ld	a5,72(a5)
    8000320a:	863e                	mv	a2,a5
    8000320c:	85b6                	mv	a1,a3
    8000320e:	853a                	mv	a0,a4
    80003210:	fffff097          	auipc	ra,0xfffff
    80003214:	f6c080e7          	jalr	-148(ra) # 8000217c <uvmcopy>
    80003218:	87aa                	mv	a5,a0
    8000321a:	0207d163          	bgez	a5,8000323c <fork+0x6e>
    freeproc(np);
    8000321e:	fd843503          	ld	a0,-40(s0)
    80003222:	00000097          	auipc	ra,0x0
    80003226:	9ee080e7          	jalr	-1554(ra) # 80002c10 <freeproc>
    release(&np->lock);
    8000322a:	fd843783          	ld	a5,-40(s0)
    8000322e:	853e                	mv	a0,a5
    80003230:	ffffe097          	auipc	ra,0xffffe
    80003234:	09e080e7          	jalr	158(ra) # 800012ce <release>
    return -1;
    80003238:	57fd                	li	a5,-1
    8000323a:	aa25                	j	80003372 <fork+0x1a4>
  }
  np->sz = p->sz;
    8000323c:	fe043783          	ld	a5,-32(s0)
    80003240:	67b8                	ld	a4,72(a5)
    80003242:	fd843783          	ld	a5,-40(s0)
    80003246:	e7b8                	sd	a4,72(a5)

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    80003248:	fe043783          	ld	a5,-32(s0)
    8000324c:	73b8                	ld	a4,96(a5)
    8000324e:	fd843783          	ld	a5,-40(s0)
    80003252:	73bc                	ld	a5,96(a5)
    80003254:	86be                	mv	a3,a5
    80003256:	12000793          	li	a5,288
    8000325a:	863e                	mv	a2,a5
    8000325c:	85ba                	mv	a1,a4
    8000325e:	8536                	mv	a0,a3
    80003260:	ffffe097          	auipc	ra,0xffffe
    80003264:	39e080e7          	jalr	926(ra) # 800015fe <memcpy>


  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;
    80003268:	fd843783          	ld	a5,-40(s0)
    8000326c:	73bc                	ld	a5,96(a5)
    8000326e:	0607b823          	sd	zero,112(a5) # 1070 <_entry-0x7fffef90>

  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    80003272:	fe042623          	sw	zero,-20(s0)
    80003276:	a0a9                	j	800032c0 <fork+0xf2>
    if(p->ofile[i])
    80003278:	fe043703          	ld	a4,-32(s0)
    8000327c:	fec42783          	lw	a5,-20(s0)
    80003280:	07f1                	addi	a5,a5,28
    80003282:	078e                	slli	a5,a5,0x3
    80003284:	97ba                	add	a5,a5,a4
    80003286:	639c                	ld	a5,0(a5)
    80003288:	c79d                	beqz	a5,800032b6 <fork+0xe8>
      np->ofile[i] = filedup(p->ofile[i]);
    8000328a:	fe043703          	ld	a4,-32(s0)
    8000328e:	fec42783          	lw	a5,-20(s0)
    80003292:	07f1                	addi	a5,a5,28
    80003294:	078e                	slli	a5,a5,0x3
    80003296:	97ba                	add	a5,a5,a4
    80003298:	639c                	ld	a5,0(a5)
    8000329a:	853e                	mv	a0,a5
    8000329c:	00004097          	auipc	ra,0x4
    800032a0:	f44080e7          	jalr	-188(ra) # 800071e0 <filedup>
    800032a4:	86aa                	mv	a3,a0
    800032a6:	fd843703          	ld	a4,-40(s0)
    800032aa:	fec42783          	lw	a5,-20(s0)
    800032ae:	07f1                	addi	a5,a5,28
    800032b0:	078e                	slli	a5,a5,0x3
    800032b2:	97ba                	add	a5,a5,a4
    800032b4:	e394                	sd	a3,0(a5)
  for(i = 0; i < NOFILE; i++)
    800032b6:	fec42783          	lw	a5,-20(s0)
    800032ba:	2785                	addiw	a5,a5,1
    800032bc:	fef42623          	sw	a5,-20(s0)
    800032c0:	fec42783          	lw	a5,-20(s0)
    800032c4:	0007871b          	sext.w	a4,a5
    800032c8:	47bd                	li	a5,15
    800032ca:	fae7d7e3          	bge	a5,a4,80003278 <fork+0xaa>
  np->cwd = idup(p->cwd);
    800032ce:	fe043783          	ld	a5,-32(s0)
    800032d2:	1607b783          	ld	a5,352(a5)
    800032d6:	853e                	mv	a0,a5
    800032d8:	00003097          	auipc	ra,0x3
    800032dc:	820080e7          	jalr	-2016(ra) # 80005af8 <idup>
    800032e0:	872a                	mv	a4,a0
    800032e2:	fd843783          	ld	a5,-40(s0)
    800032e6:	16e7b023          	sd	a4,352(a5)

  safestrcpy(np->name, p->name, sizeof(p->name));
    800032ea:	fd843783          	ld	a5,-40(s0)
    800032ee:	16878713          	addi	a4,a5,360
    800032f2:	fe043783          	ld	a5,-32(s0)
    800032f6:	16878793          	addi	a5,a5,360
    800032fa:	4641                	li	a2,16
    800032fc:	85be                	mv	a1,a5
    800032fe:	853a                	mv	a0,a4
    80003300:	ffffe097          	auipc	ra,0xffffe
    80003304:	442080e7          	jalr	1090(ra) # 80001742 <safestrcpy>

  pid = np->pid;
    80003308:	fd843783          	ld	a5,-40(s0)
    8000330c:	5b9c                	lw	a5,48(a5)
    8000330e:	fcf42a23          	sw	a5,-44(s0)

  release(&np->lock);
    80003312:	fd843783          	ld	a5,-40(s0)
    80003316:	853e                	mv	a0,a5
    80003318:	ffffe097          	auipc	ra,0xffffe
    8000331c:	fb6080e7          	jalr	-74(ra) # 800012ce <release>

  acquire(&wait_lock);
    80003320:	00497517          	auipc	a0,0x497
    80003324:	79050513          	addi	a0,a0,1936 # 8049aab0 <wait_lock>
    80003328:	ffffe097          	auipc	ra,0xffffe
    8000332c:	f42080e7          	jalr	-190(ra) # 8000126a <acquire>
  np->parent = p;
    80003330:	fd843783          	ld	a5,-40(s0)
    80003334:	fe043703          	ld	a4,-32(s0)
    80003338:	ff98                	sd	a4,56(a5)
  release(&wait_lock);
    8000333a:	00497517          	auipc	a0,0x497
    8000333e:	77650513          	addi	a0,a0,1910 # 8049aab0 <wait_lock>
    80003342:	ffffe097          	auipc	ra,0xffffe
    80003346:	f8c080e7          	jalr	-116(ra) # 800012ce <release>

  acquire(&np->lock);
    8000334a:	fd843783          	ld	a5,-40(s0)
    8000334e:	853e                	mv	a0,a5
    80003350:	ffffe097          	auipc	ra,0xffffe
    80003354:	f1a080e7          	jalr	-230(ra) # 8000126a <acquire>
  np->state = RUNNABLE;
    80003358:	fd843783          	ld	a5,-40(s0)
    8000335c:	470d                	li	a4,3
    8000335e:	cf98                	sw	a4,24(a5)
  release(&np->lock);
    80003360:	fd843783          	ld	a5,-40(s0)
    80003364:	853e                	mv	a0,a5
    80003366:	ffffe097          	auipc	ra,0xffffe
    8000336a:	f68080e7          	jalr	-152(ra) # 800012ce <release>

  return pid;
    8000336e:	fd442783          	lw	a5,-44(s0)
}
    80003372:	853e                	mv	a0,a5
    80003374:	70a2                	ld	ra,40(sp)
    80003376:	7402                	ld	s0,32(sp)
    80003378:	6145                	addi	sp,sp,48
    8000337a:	8082                	ret

000000008000337c <reparent>:

// Pass p's abandoned children to init.
// Caller must hold wait_lock.
void
reparent(struct proc *p)
{
    8000337c:	7179                	addi	sp,sp,-48
    8000337e:	f406                	sd	ra,40(sp)
    80003380:	f022                	sd	s0,32(sp)
    80003382:	1800                	addi	s0,sp,48
    80003384:	fca43c23          	sd	a0,-40(s0)
  struct proc *pp;

  for(pp = proc; pp < &proc[NPROC]; pp++){
    80003388:	00011797          	auipc	a5,0x11
    8000338c:	31078793          	addi	a5,a5,784 # 80014698 <proc>
    80003390:	fef43423          	sd	a5,-24(s0)
    80003394:	a091                	j	800033d8 <reparent+0x5c>
    if(pp->parent == p){
    80003396:	fe843783          	ld	a5,-24(s0)
    8000339a:	7f9c                	ld	a5,56(a5)
    8000339c:	fd843703          	ld	a4,-40(s0)
    800033a0:	02f71463          	bne	a4,a5,800033c8 <reparent+0x4c>
      pp->parent = initproc;
    800033a4:	00009797          	auipc	a5,0x9
    800033a8:	c7c78793          	addi	a5,a5,-900 # 8000c020 <initproc>
    800033ac:	6398                	ld	a4,0(a5)
    800033ae:	fe843783          	ld	a5,-24(s0)
    800033b2:	ff98                	sd	a4,56(a5)
      wakeup(initproc);
    800033b4:	00009797          	auipc	a5,0x9
    800033b8:	c6c78793          	addi	a5,a5,-916 # 8000c020 <initproc>
    800033bc:	639c                	ld	a5,0(a5)
    800033be:	853e                	mv	a0,a5
    800033c0:	00000097          	auipc	ra,0x0
    800033c4:	5b0080e7          	jalr	1456(ra) # 80003970 <wakeup>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800033c8:	fe843703          	ld	a4,-24(s0)
    800033cc:	67c9                	lui	a5,0x12
    800033ce:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    800033d2:	97ba                	add	a5,a5,a4
    800033d4:	fef43423          	sd	a5,-24(s0)
    800033d8:	fe843703          	ld	a4,-24(s0)
    800033dc:	00497797          	auipc	a5,0x497
    800033e0:	6bc78793          	addi	a5,a5,1724 # 8049aa98 <pid_lock>
    800033e4:	faf769e3          	bltu	a4,a5,80003396 <reparent+0x1a>
    }
  }
}
    800033e8:	0001                	nop
    800033ea:	0001                	nop
    800033ec:	70a2                	ld	ra,40(sp)
    800033ee:	7402                	ld	s0,32(sp)
    800033f0:	6145                	addi	sp,sp,48
    800033f2:	8082                	ret

00000000800033f4 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait().
void
exit(int status)
{
    800033f4:	7139                	addi	sp,sp,-64
    800033f6:	fc06                	sd	ra,56(sp)
    800033f8:	f822                	sd	s0,48(sp)
    800033fa:	0080                	addi	s0,sp,64
    800033fc:	87aa                	mv	a5,a0
    800033fe:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    80003402:	fffff097          	auipc	ra,0xfffff
    80003406:	616080e7          	jalr	1558(ra) # 80002a18 <myproc>
    8000340a:	fea43023          	sd	a0,-32(s0)

  if(p == initproc)
    8000340e:	00009797          	auipc	a5,0x9
    80003412:	c1278793          	addi	a5,a5,-1006 # 8000c020 <initproc>
    80003416:	639c                	ld	a5,0(a5)
    80003418:	fe043703          	ld	a4,-32(s0)
    8000341c:	00f71a63          	bne	a4,a5,80003430 <exit+0x3c>
    panic("init exiting");
    80003420:	00008517          	auipc	a0,0x8
    80003424:	e7850513          	addi	a0,a0,-392 # 8000b298 <etext+0x298>
    80003428:	ffffe097          	auipc	ra,0xffffe
    8000342c:	852080e7          	jalr	-1966(ra) # 80000c7a <panic>

  // Close all open files.
  for(int fd = 0; fd < NOFILE; fd++){
    80003430:	fe042623          	sw	zero,-20(s0)
    80003434:	a881                	j	80003484 <exit+0x90>
    if(p->ofile[fd]){
    80003436:	fe043703          	ld	a4,-32(s0)
    8000343a:	fec42783          	lw	a5,-20(s0)
    8000343e:	07f1                	addi	a5,a5,28
    80003440:	078e                	slli	a5,a5,0x3
    80003442:	97ba                	add	a5,a5,a4
    80003444:	639c                	ld	a5,0(a5)
    80003446:	cb95                	beqz	a5,8000347a <exit+0x86>
      struct file *f = p->ofile[fd];
    80003448:	fe043703          	ld	a4,-32(s0)
    8000344c:	fec42783          	lw	a5,-20(s0)
    80003450:	07f1                	addi	a5,a5,28
    80003452:	078e                	slli	a5,a5,0x3
    80003454:	97ba                	add	a5,a5,a4
    80003456:	639c                	ld	a5,0(a5)
    80003458:	fcf43c23          	sd	a5,-40(s0)
      fileclose(f);
    8000345c:	fd843503          	ld	a0,-40(s0)
    80003460:	00004097          	auipc	ra,0x4
    80003464:	de6080e7          	jalr	-538(ra) # 80007246 <fileclose>
      p->ofile[fd] = 0;
    80003468:	fe043703          	ld	a4,-32(s0)
    8000346c:	fec42783          	lw	a5,-20(s0)
    80003470:	07f1                	addi	a5,a5,28
    80003472:	078e                	slli	a5,a5,0x3
    80003474:	97ba                	add	a5,a5,a4
    80003476:	0007b023          	sd	zero,0(a5)
  for(int fd = 0; fd < NOFILE; fd++){
    8000347a:	fec42783          	lw	a5,-20(s0)
    8000347e:	2785                	addiw	a5,a5,1
    80003480:	fef42623          	sw	a5,-20(s0)
    80003484:	fec42783          	lw	a5,-20(s0)
    80003488:	0007871b          	sext.w	a4,a5
    8000348c:	47bd                	li	a5,15
    8000348e:	fae7d4e3          	bge	a5,a4,80003436 <exit+0x42>
    }
  }

  begin_op();
    80003492:	00003097          	auipc	ra,0x3
    80003496:	71a080e7          	jalr	1818(ra) # 80006bac <begin_op>
  iput(p->cwd);
    8000349a:	fe043783          	ld	a5,-32(s0)
    8000349e:	1607b783          	ld	a5,352(a5)
    800034a2:	853e                	mv	a0,a5
    800034a4:	00003097          	auipc	ra,0x3
    800034a8:	82e080e7          	jalr	-2002(ra) # 80005cd2 <iput>
  end_op();
    800034ac:	00003097          	auipc	ra,0x3
    800034b0:	7c2080e7          	jalr	1986(ra) # 80006c6e <end_op>
  p->cwd = 0;
    800034b4:	fe043783          	ld	a5,-32(s0)
    800034b8:	1607b023          	sd	zero,352(a5)

  acquire(&wait_lock);
    800034bc:	00497517          	auipc	a0,0x497
    800034c0:	5f450513          	addi	a0,a0,1524 # 8049aab0 <wait_lock>
    800034c4:	ffffe097          	auipc	ra,0xffffe
    800034c8:	da6080e7          	jalr	-602(ra) # 8000126a <acquire>

  // Give any children to init.
  reparent(p);
    800034cc:	fe043503          	ld	a0,-32(s0)
    800034d0:	00000097          	auipc	ra,0x0
    800034d4:	eac080e7          	jalr	-340(ra) # 8000337c <reparent>

  // Parent might be sleeping in wait().
  wakeup(p->parent);
    800034d8:	fe043783          	ld	a5,-32(s0)
    800034dc:	7f9c                	ld	a5,56(a5)
    800034de:	853e                	mv	a0,a5
    800034e0:	00000097          	auipc	ra,0x0
    800034e4:	490080e7          	jalr	1168(ra) # 80003970 <wakeup>
  
  acquire(&p->lock);
    800034e8:	fe043783          	ld	a5,-32(s0)
    800034ec:	853e                	mv	a0,a5
    800034ee:	ffffe097          	auipc	ra,0xffffe
    800034f2:	d7c080e7          	jalr	-644(ra) # 8000126a <acquire>

  p->xstate = status;
    800034f6:	fe043783          	ld	a5,-32(s0)
    800034fa:	fcc42703          	lw	a4,-52(s0)
    800034fe:	d7d8                	sw	a4,44(a5)
  p->state = ZOMBIE;
    80003500:	fe043783          	ld	a5,-32(s0)
    80003504:	4715                	li	a4,5
    80003506:	cf98                	sw	a4,24(a5)

  release(&wait_lock);
    80003508:	00497517          	auipc	a0,0x497
    8000350c:	5a850513          	addi	a0,a0,1448 # 8049aab0 <wait_lock>
    80003510:	ffffe097          	auipc	ra,0xffffe
    80003514:	dbe080e7          	jalr	-578(ra) # 800012ce <release>

  // Jump into the scheduler, never to return.
  sched();
    80003518:	00000097          	auipc	ra,0x0
    8000351c:	260080e7          	jalr	608(ra) # 80003778 <sched>
  panic("zombie exit");
    80003520:	00008517          	auipc	a0,0x8
    80003524:	d8850513          	addi	a0,a0,-632 # 8000b2a8 <etext+0x2a8>
    80003528:	ffffd097          	auipc	ra,0xffffd
    8000352c:	752080e7          	jalr	1874(ra) # 80000c7a <panic>

0000000080003530 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(uint64 addr)
{
    80003530:	7139                	addi	sp,sp,-64
    80003532:	fc06                	sd	ra,56(sp)
    80003534:	f822                	sd	s0,48(sp)
    80003536:	0080                	addi	s0,sp,64
    80003538:	fca43423          	sd	a0,-56(s0)
  struct proc *np;
  int havekids, pid;
  struct proc *p = myproc();
    8000353c:	fffff097          	auipc	ra,0xfffff
    80003540:	4dc080e7          	jalr	1244(ra) # 80002a18 <myproc>
    80003544:	fca43c23          	sd	a0,-40(s0)

  acquire(&wait_lock);
    80003548:	00497517          	auipc	a0,0x497
    8000354c:	56850513          	addi	a0,a0,1384 # 8049aab0 <wait_lock>
    80003550:	ffffe097          	auipc	ra,0xffffe
    80003554:	d1a080e7          	jalr	-742(ra) # 8000126a <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    80003558:	fe042223          	sw	zero,-28(s0)
    for(np = proc; np < &proc[NPROC]; np++){
    8000355c:	00011797          	auipc	a5,0x11
    80003560:	13c78793          	addi	a5,a5,316 # 80014698 <proc>
    80003564:	fef43423          	sd	a5,-24(s0)
    80003568:	a221                	j	80003670 <wait+0x140>
      if(np->parent == p && !np->thread){ //Proceso hijo no puede compartir el espacio de direcciones el padre
    8000356a:	fe843783          	ld	a5,-24(s0)
    8000356e:	7f9c                	ld	a5,56(a5)
    80003570:	fd843703          	ld	a4,-40(s0)
    80003574:	0ef71663          	bne	a4,a5,80003660 <wait+0x130>
    80003578:	fe843703          	ld	a4,-24(s0)
    8000357c:	67c9                	lui	a5,0x12
    8000357e:	97ba                	add	a5,a5,a4
    80003580:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    80003584:	eff1                	bnez	a5,80003660 <wait+0x130>
        // make sure the child isn't still in exit() or swtch().
        acquire(&np->lock);
    80003586:	fe843783          	ld	a5,-24(s0)
    8000358a:	853e                	mv	a0,a5
    8000358c:	ffffe097          	auipc	ra,0xffffe
    80003590:	cde080e7          	jalr	-802(ra) # 8000126a <acquire>

        havekids = 1;
    80003594:	4785                	li	a5,1
    80003596:	fef42223          	sw	a5,-28(s0)
        if(np->state == ZOMBIE){ 
    8000359a:	fe843783          	ld	a5,-24(s0)
    8000359e:	4f9c                	lw	a5,24(a5)
    800035a0:	873e                	mv	a4,a5
    800035a2:	4795                	li	a5,5
    800035a4:	0af71763          	bne	a4,a5,80003652 <wait+0x122>
          // Found one.
          pid = np->pid;
    800035a8:	fe843783          	ld	a5,-24(s0)
    800035ac:	5b9c                	lw	a5,48(a5)
    800035ae:	fcf42a23          	sw	a5,-44(s0)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    800035b2:	fc843783          	ld	a5,-56(s0)
    800035b6:	c7a9                	beqz	a5,80003600 <wait+0xd0>
    800035b8:	fd843783          	ld	a5,-40(s0)
    800035bc:	6bb8                	ld	a4,80(a5)
    800035be:	fe843783          	ld	a5,-24(s0)
    800035c2:	02c78793          	addi	a5,a5,44
    800035c6:	4691                	li	a3,4
    800035c8:	863e                	mv	a2,a5
    800035ca:	fc843583          	ld	a1,-56(s0)
    800035ce:	853a                	mv	a0,a4
    800035d0:	fffff097          	auipc	ra,0xfffff
    800035d4:	df6080e7          	jalr	-522(ra) # 800023c6 <copyout>
    800035d8:	87aa                	mv	a5,a0
    800035da:	0207d363          	bgez	a5,80003600 <wait+0xd0>
                                  sizeof(np->xstate)) < 0) {
            release(&np->lock);
    800035de:	fe843783          	ld	a5,-24(s0)
    800035e2:	853e                	mv	a0,a5
    800035e4:	ffffe097          	auipc	ra,0xffffe
    800035e8:	cea080e7          	jalr	-790(ra) # 800012ce <release>
            release(&wait_lock);
    800035ec:	00497517          	auipc	a0,0x497
    800035f0:	4c450513          	addi	a0,a0,1220 # 8049aab0 <wait_lock>
    800035f4:	ffffe097          	auipc	ra,0xffffe
    800035f8:	cda080e7          	jalr	-806(ra) # 800012ce <release>
            return -1;
    800035fc:	57fd                	li	a5,-1
    800035fe:	a875                	j	800036ba <wait+0x18a>
          }
          
          if (np->thread == 1){
    80003600:	fe843703          	ld	a4,-24(s0)
    80003604:	67c9                	lui	a5,0x12
    80003606:	97ba                	add	a5,a5,a4
    80003608:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    8000360c:	873e                	mv	a4,a5
    8000360e:	4785                	li	a5,1
    80003610:	00f71963          	bne	a4,a5,80003622 <wait+0xf2>
            freethread(np);
    80003614:	fe843503          	ld	a0,-24(s0)
    80003618:	fffff097          	auipc	ra,0xfffff
    8000361c:	696080e7          	jalr	1686(ra) # 80002cae <freethread>
    80003620:	a039                	j	8000362e <wait+0xfe>
          } else {
              freeproc(np);
    80003622:	fe843503          	ld	a0,-24(s0)
    80003626:	fffff097          	auipc	ra,0xfffff
    8000362a:	5ea080e7          	jalr	1514(ra) # 80002c10 <freeproc>
          }

          release(&np->lock);
    8000362e:	fe843783          	ld	a5,-24(s0)
    80003632:	853e                	mv	a0,a5
    80003634:	ffffe097          	auipc	ra,0xffffe
    80003638:	c9a080e7          	jalr	-870(ra) # 800012ce <release>
          release(&wait_lock);
    8000363c:	00497517          	auipc	a0,0x497
    80003640:	47450513          	addi	a0,a0,1140 # 8049aab0 <wait_lock>
    80003644:	ffffe097          	auipc	ra,0xffffe
    80003648:	c8a080e7          	jalr	-886(ra) # 800012ce <release>
          return pid;
    8000364c:	fd442783          	lw	a5,-44(s0)
    80003650:	a0ad                	j	800036ba <wait+0x18a>
        }
        release(&np->lock);
    80003652:	fe843783          	ld	a5,-24(s0)
    80003656:	853e                	mv	a0,a5
    80003658:	ffffe097          	auipc	ra,0xffffe
    8000365c:	c76080e7          	jalr	-906(ra) # 800012ce <release>
    for(np = proc; np < &proc[NPROC]; np++){
    80003660:	fe843703          	ld	a4,-24(s0)
    80003664:	67c9                	lui	a5,0x12
    80003666:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    8000366a:	97ba                	add	a5,a5,a4
    8000366c:	fef43423          	sd	a5,-24(s0)
    80003670:	fe843703          	ld	a4,-24(s0)
    80003674:	00497797          	auipc	a5,0x497
    80003678:	42478793          	addi	a5,a5,1060 # 8049aa98 <pid_lock>
    8000367c:	eef767e3          	bltu	a4,a5,8000356a <wait+0x3a>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || p->killed){
    80003680:	fe442783          	lw	a5,-28(s0)
    80003684:	2781                	sext.w	a5,a5
    80003686:	c789                	beqz	a5,80003690 <wait+0x160>
    80003688:	fd843783          	ld	a5,-40(s0)
    8000368c:	579c                	lw	a5,40(a5)
    8000368e:	cb99                	beqz	a5,800036a4 <wait+0x174>
      release(&wait_lock);
    80003690:	00497517          	auipc	a0,0x497
    80003694:	42050513          	addi	a0,a0,1056 # 8049aab0 <wait_lock>
    80003698:	ffffe097          	auipc	ra,0xffffe
    8000369c:	c36080e7          	jalr	-970(ra) # 800012ce <release>
      return -1;
    800036a0:	57fd                	li	a5,-1
    800036a2:	a821                	j	800036ba <wait+0x18a>
    }
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800036a4:	00497597          	auipc	a1,0x497
    800036a8:	40c58593          	addi	a1,a1,1036 # 8049aab0 <wait_lock>
    800036ac:	fd843503          	ld	a0,-40(s0)
    800036b0:	00000097          	auipc	ra,0x0
    800036b4:	244080e7          	jalr	580(ra) # 800038f4 <sleep>
    havekids = 0;
    800036b8:	b545                	j	80003558 <wait+0x28>
  }
}
    800036ba:	853e                	mv	a0,a5
    800036bc:	70e2                	ld	ra,56(sp)
    800036be:	7442                	ld	s0,48(sp)
    800036c0:	6121                	addi	sp,sp,64
    800036c2:	8082                	ret

00000000800036c4 <scheduler>:
//  - swtch to start running that process.
//  - eventually that process transfers control
//    via swtch back to the scheduler.
void
scheduler(void)
{
    800036c4:	1101                	addi	sp,sp,-32
    800036c6:	ec06                	sd	ra,24(sp)
    800036c8:	e822                	sd	s0,16(sp)
    800036ca:	1000                	addi	s0,sp,32
  struct proc *p;
  struct cpu *c = mycpu();
    800036cc:	fffff097          	auipc	ra,0xfffff
    800036d0:	312080e7          	jalr	786(ra) # 800029de <mycpu>
    800036d4:	fea43023          	sd	a0,-32(s0)
  
  c->proc = 0;
    800036d8:	fe043783          	ld	a5,-32(s0)
    800036dc:	0007b023          	sd	zero,0(a5)
  for(;;){
    // Avoid deadlock by ensuring that devices can interrupt.
    intr_on();
    800036e0:	fffff097          	auipc	ra,0xfffff
    800036e4:	0e0080e7          	jalr	224(ra) # 800027c0 <intr_on>

    for(p = proc; p < &proc[NPROC]; p++) {
    800036e8:	00011797          	auipc	a5,0x11
    800036ec:	fb078793          	addi	a5,a5,-80 # 80014698 <proc>
    800036f0:	fef43423          	sd	a5,-24(s0)
    800036f4:	a88d                	j	80003766 <scheduler+0xa2>
      acquire(&p->lock);
    800036f6:	fe843783          	ld	a5,-24(s0)
    800036fa:	853e                	mv	a0,a5
    800036fc:	ffffe097          	auipc	ra,0xffffe
    80003700:	b6e080e7          	jalr	-1170(ra) # 8000126a <acquire>
      if(p->state == RUNNABLE) {
    80003704:	fe843783          	ld	a5,-24(s0)
    80003708:	4f9c                	lw	a5,24(a5)
    8000370a:	873e                	mv	a4,a5
    8000370c:	478d                	li	a5,3
    8000370e:	02f71d63          	bne	a4,a5,80003748 <scheduler+0x84>
        // Switch to chosen process.  It is the process's job
        // to release its lock and then reacquire it
        // before jumping back to us.
        p->state = RUNNING;
    80003712:	fe843783          	ld	a5,-24(s0)
    80003716:	4711                	li	a4,4
    80003718:	cf98                	sw	a4,24(a5)
        c->proc = p;
    8000371a:	fe043783          	ld	a5,-32(s0)
    8000371e:	fe843703          	ld	a4,-24(s0)
    80003722:	e398                	sd	a4,0(a5)
        swtch(&c->context, &p->context);
    80003724:	fe043783          	ld	a5,-32(s0)
    80003728:	00878713          	addi	a4,a5,8
    8000372c:	fe843783          	ld	a5,-24(s0)
    80003730:	07078793          	addi	a5,a5,112
    80003734:	85be                	mv	a1,a5
    80003736:	853a                	mv	a0,a4
    80003738:	00001097          	auipc	ra,0x1
    8000373c:	a3c080e7          	jalr	-1476(ra) # 80004174 <swtch>

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
    80003740:	fe043783          	ld	a5,-32(s0)
    80003744:	0007b023          	sd	zero,0(a5)
      }
      release(&p->lock);
    80003748:	fe843783          	ld	a5,-24(s0)
    8000374c:	853e                	mv	a0,a5
    8000374e:	ffffe097          	auipc	ra,0xffffe
    80003752:	b80080e7          	jalr	-1152(ra) # 800012ce <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80003756:	fe843703          	ld	a4,-24(s0)
    8000375a:	67c9                	lui	a5,0x12
    8000375c:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80003760:	97ba                	add	a5,a5,a4
    80003762:	fef43423          	sd	a5,-24(s0)
    80003766:	fe843703          	ld	a4,-24(s0)
    8000376a:	00497797          	auipc	a5,0x497
    8000376e:	32e78793          	addi	a5,a5,814 # 8049aa98 <pid_lock>
    80003772:	f8f762e3          	bltu	a4,a5,800036f6 <scheduler+0x32>
    intr_on();
    80003776:	b7ad                	j	800036e0 <scheduler+0x1c>

0000000080003778 <sched>:
// be proc->intena and proc->noff, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
    80003778:	7179                	addi	sp,sp,-48
    8000377a:	f406                	sd	ra,40(sp)
    8000377c:	f022                	sd	s0,32(sp)
    8000377e:	ec26                	sd	s1,24(sp)
    80003780:	1800                	addi	s0,sp,48
  int intena;
  struct proc *p = myproc();
    80003782:	fffff097          	auipc	ra,0xfffff
    80003786:	296080e7          	jalr	662(ra) # 80002a18 <myproc>
    8000378a:	fca43c23          	sd	a0,-40(s0)

  if(!holding(&p->lock))
    8000378e:	fd843783          	ld	a5,-40(s0)
    80003792:	853e                	mv	a0,a5
    80003794:	ffffe097          	auipc	ra,0xffffe
    80003798:	b90080e7          	jalr	-1136(ra) # 80001324 <holding>
    8000379c:	87aa                	mv	a5,a0
    8000379e:	eb89                	bnez	a5,800037b0 <sched+0x38>
    panic("sched p->lock");
    800037a0:	00008517          	auipc	a0,0x8
    800037a4:	b1850513          	addi	a0,a0,-1256 # 8000b2b8 <etext+0x2b8>
    800037a8:	ffffd097          	auipc	ra,0xffffd
    800037ac:	4d2080e7          	jalr	1234(ra) # 80000c7a <panic>
  if(mycpu()->noff != 1)
    800037b0:	fffff097          	auipc	ra,0xfffff
    800037b4:	22e080e7          	jalr	558(ra) # 800029de <mycpu>
    800037b8:	87aa                	mv	a5,a0
    800037ba:	5fbc                	lw	a5,120(a5)
    800037bc:	873e                	mv	a4,a5
    800037be:	4785                	li	a5,1
    800037c0:	00f70a63          	beq	a4,a5,800037d4 <sched+0x5c>
    panic("sched locks");
    800037c4:	00008517          	auipc	a0,0x8
    800037c8:	b0450513          	addi	a0,a0,-1276 # 8000b2c8 <etext+0x2c8>
    800037cc:	ffffd097          	auipc	ra,0xffffd
    800037d0:	4ae080e7          	jalr	1198(ra) # 80000c7a <panic>
  if(p->state == RUNNING)
    800037d4:	fd843783          	ld	a5,-40(s0)
    800037d8:	4f9c                	lw	a5,24(a5)
    800037da:	873e                	mv	a4,a5
    800037dc:	4791                	li	a5,4
    800037de:	00f71a63          	bne	a4,a5,800037f2 <sched+0x7a>
    panic("sched running");
    800037e2:	00008517          	auipc	a0,0x8
    800037e6:	af650513          	addi	a0,a0,-1290 # 8000b2d8 <etext+0x2d8>
    800037ea:	ffffd097          	auipc	ra,0xffffd
    800037ee:	490080e7          	jalr	1168(ra) # 80000c7a <panic>
  if(intr_get())
    800037f2:	fffff097          	auipc	ra,0xfffff
    800037f6:	ff8080e7          	jalr	-8(ra) # 800027ea <intr_get>
    800037fa:	87aa                	mv	a5,a0
    800037fc:	cb89                	beqz	a5,8000380e <sched+0x96>
    panic("sched interruptible");
    800037fe:	00008517          	auipc	a0,0x8
    80003802:	aea50513          	addi	a0,a0,-1302 # 8000b2e8 <etext+0x2e8>
    80003806:	ffffd097          	auipc	ra,0xffffd
    8000380a:	474080e7          	jalr	1140(ra) # 80000c7a <panic>

  intena = mycpu()->intena;
    8000380e:	fffff097          	auipc	ra,0xfffff
    80003812:	1d0080e7          	jalr	464(ra) # 800029de <mycpu>
    80003816:	87aa                	mv	a5,a0
    80003818:	5ffc                	lw	a5,124(a5)
    8000381a:	fcf42a23          	sw	a5,-44(s0)
  swtch(&p->context, &mycpu()->context);
    8000381e:	fd843783          	ld	a5,-40(s0)
    80003822:	07078493          	addi	s1,a5,112
    80003826:	fffff097          	auipc	ra,0xfffff
    8000382a:	1b8080e7          	jalr	440(ra) # 800029de <mycpu>
    8000382e:	87aa                	mv	a5,a0
    80003830:	07a1                	addi	a5,a5,8
    80003832:	85be                	mv	a1,a5
    80003834:	8526                	mv	a0,s1
    80003836:	00001097          	auipc	ra,0x1
    8000383a:	93e080e7          	jalr	-1730(ra) # 80004174 <swtch>
  mycpu()->intena = intena;
    8000383e:	fffff097          	auipc	ra,0xfffff
    80003842:	1a0080e7          	jalr	416(ra) # 800029de <mycpu>
    80003846:	872a                	mv	a4,a0
    80003848:	fd442783          	lw	a5,-44(s0)
    8000384c:	df7c                	sw	a5,124(a4)
}
    8000384e:	0001                	nop
    80003850:	70a2                	ld	ra,40(sp)
    80003852:	7402                	ld	s0,32(sp)
    80003854:	64e2                	ld	s1,24(sp)
    80003856:	6145                	addi	sp,sp,48
    80003858:	8082                	ret

000000008000385a <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
    8000385a:	1101                	addi	sp,sp,-32
    8000385c:	ec06                	sd	ra,24(sp)
    8000385e:	e822                	sd	s0,16(sp)
    80003860:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80003862:	fffff097          	auipc	ra,0xfffff
    80003866:	1b6080e7          	jalr	438(ra) # 80002a18 <myproc>
    8000386a:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    8000386e:	fe843783          	ld	a5,-24(s0)
    80003872:	853e                	mv	a0,a5
    80003874:	ffffe097          	auipc	ra,0xffffe
    80003878:	9f6080e7          	jalr	-1546(ra) # 8000126a <acquire>
  p->state = RUNNABLE;
    8000387c:	fe843783          	ld	a5,-24(s0)
    80003880:	470d                	li	a4,3
    80003882:	cf98                	sw	a4,24(a5)
  sched();
    80003884:	00000097          	auipc	ra,0x0
    80003888:	ef4080e7          	jalr	-268(ra) # 80003778 <sched>
  release(&p->lock);
    8000388c:	fe843783          	ld	a5,-24(s0)
    80003890:	853e                	mv	a0,a5
    80003892:	ffffe097          	auipc	ra,0xffffe
    80003896:	a3c080e7          	jalr	-1476(ra) # 800012ce <release>
}
    8000389a:	0001                	nop
    8000389c:	60e2                	ld	ra,24(sp)
    8000389e:	6442                	ld	s0,16(sp)
    800038a0:	6105                	addi	sp,sp,32
    800038a2:	8082                	ret

00000000800038a4 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    800038a4:	1141                	addi	sp,sp,-16
    800038a6:	e406                	sd	ra,8(sp)
    800038a8:	e022                	sd	s0,0(sp)
    800038aa:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    800038ac:	fffff097          	auipc	ra,0xfffff
    800038b0:	16c080e7          	jalr	364(ra) # 80002a18 <myproc>
    800038b4:	87aa                	mv	a5,a0
    800038b6:	853e                	mv	a0,a5
    800038b8:	ffffe097          	auipc	ra,0xffffe
    800038bc:	a16080e7          	jalr	-1514(ra) # 800012ce <release>

  if (first) {
    800038c0:	00008797          	auipc	a5,0x8
    800038c4:	01478793          	addi	a5,a5,20 # 8000b8d4 <first.1>
    800038c8:	439c                	lw	a5,0(a5)
    800038ca:	cf81                	beqz	a5,800038e2 <forkret+0x3e>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    first = 0;
    800038cc:	00008797          	auipc	a5,0x8
    800038d0:	00878793          	addi	a5,a5,8 # 8000b8d4 <first.1>
    800038d4:	0007a023          	sw	zero,0(a5)
    fsinit(ROOTDEV);
    800038d8:	4505                	li	a0,1
    800038da:	00002097          	auipc	ra,0x2
    800038de:	b10080e7          	jalr	-1264(ra) # 800053ea <fsinit>
  }

  usertrapret();
    800038e2:	00001097          	auipc	ra,0x1
    800038e6:	c30080e7          	jalr	-976(ra) # 80004512 <usertrapret>
}
    800038ea:	0001                	nop
    800038ec:	60a2                	ld	ra,8(sp)
    800038ee:	6402                	ld	s0,0(sp)
    800038f0:	0141                	addi	sp,sp,16
    800038f2:	8082                	ret

00000000800038f4 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    800038f4:	7179                	addi	sp,sp,-48
    800038f6:	f406                	sd	ra,40(sp)
    800038f8:	f022                	sd	s0,32(sp)
    800038fa:	1800                	addi	s0,sp,48
    800038fc:	fca43c23          	sd	a0,-40(s0)
    80003900:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    80003904:	fffff097          	auipc	ra,0xfffff
    80003908:	114080e7          	jalr	276(ra) # 80002a18 <myproc>
    8000390c:	fea43423          	sd	a0,-24(s0)
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80003910:	fe843783          	ld	a5,-24(s0)
    80003914:	853e                	mv	a0,a5
    80003916:	ffffe097          	auipc	ra,0xffffe
    8000391a:	954080e7          	jalr	-1708(ra) # 8000126a <acquire>
  release(lk);
    8000391e:	fd043503          	ld	a0,-48(s0)
    80003922:	ffffe097          	auipc	ra,0xffffe
    80003926:	9ac080e7          	jalr	-1620(ra) # 800012ce <release>

  // Go to sleep.
  p->chan = chan;
    8000392a:	fe843783          	ld	a5,-24(s0)
    8000392e:	fd843703          	ld	a4,-40(s0)
    80003932:	f398                	sd	a4,32(a5)
  p->state = SLEEPING;
    80003934:	fe843783          	ld	a5,-24(s0)
    80003938:	4709                	li	a4,2
    8000393a:	cf98                	sw	a4,24(a5)

  sched();
    8000393c:	00000097          	auipc	ra,0x0
    80003940:	e3c080e7          	jalr	-452(ra) # 80003778 <sched>

  // Tidy up.
  p->chan = 0;
    80003944:	fe843783          	ld	a5,-24(s0)
    80003948:	0207b023          	sd	zero,32(a5)

  // Reacquire original lock.
  release(&p->lock);
    8000394c:	fe843783          	ld	a5,-24(s0)
    80003950:	853e                	mv	a0,a5
    80003952:	ffffe097          	auipc	ra,0xffffe
    80003956:	97c080e7          	jalr	-1668(ra) # 800012ce <release>
  acquire(lk);
    8000395a:	fd043503          	ld	a0,-48(s0)
    8000395e:	ffffe097          	auipc	ra,0xffffe
    80003962:	90c080e7          	jalr	-1780(ra) # 8000126a <acquire>
}
    80003966:	0001                	nop
    80003968:	70a2                	ld	ra,40(sp)
    8000396a:	7402                	ld	s0,32(sp)
    8000396c:	6145                	addi	sp,sp,48
    8000396e:	8082                	ret

0000000080003970 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80003970:	7179                	addi	sp,sp,-48
    80003972:	f406                	sd	ra,40(sp)
    80003974:	f022                	sd	s0,32(sp)
    80003976:	1800                	addi	s0,sp,48
    80003978:	fca43c23          	sd	a0,-40(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    8000397c:	00011797          	auipc	a5,0x11
    80003980:	d1c78793          	addi	a5,a5,-740 # 80014698 <proc>
    80003984:	fef43423          	sd	a5,-24(s0)
    80003988:	a095                	j	800039ec <wakeup+0x7c>
    if(p != myproc()){
    8000398a:	fffff097          	auipc	ra,0xfffff
    8000398e:	08e080e7          	jalr	142(ra) # 80002a18 <myproc>
    80003992:	872a                	mv	a4,a0
    80003994:	fe843783          	ld	a5,-24(s0)
    80003998:	04e78263          	beq	a5,a4,800039dc <wakeup+0x6c>
      acquire(&p->lock);
    8000399c:	fe843783          	ld	a5,-24(s0)
    800039a0:	853e                	mv	a0,a5
    800039a2:	ffffe097          	auipc	ra,0xffffe
    800039a6:	8c8080e7          	jalr	-1848(ra) # 8000126a <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800039aa:	fe843783          	ld	a5,-24(s0)
    800039ae:	4f9c                	lw	a5,24(a5)
    800039b0:	873e                	mv	a4,a5
    800039b2:	4789                	li	a5,2
    800039b4:	00f71d63          	bne	a4,a5,800039ce <wakeup+0x5e>
    800039b8:	fe843783          	ld	a5,-24(s0)
    800039bc:	739c                	ld	a5,32(a5)
    800039be:	fd843703          	ld	a4,-40(s0)
    800039c2:	00f71663          	bne	a4,a5,800039ce <wakeup+0x5e>
        p->state = RUNNABLE;
    800039c6:	fe843783          	ld	a5,-24(s0)
    800039ca:	470d                	li	a4,3
    800039cc:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    800039ce:	fe843783          	ld	a5,-24(s0)
    800039d2:	853e                	mv	a0,a5
    800039d4:	ffffe097          	auipc	ra,0xffffe
    800039d8:	8fa080e7          	jalr	-1798(ra) # 800012ce <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800039dc:	fe843703          	ld	a4,-24(s0)
    800039e0:	67c9                	lui	a5,0x12
    800039e2:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    800039e6:	97ba                	add	a5,a5,a4
    800039e8:	fef43423          	sd	a5,-24(s0)
    800039ec:	fe843703          	ld	a4,-24(s0)
    800039f0:	00497797          	auipc	a5,0x497
    800039f4:	0a878793          	addi	a5,a5,168 # 8049aa98 <pid_lock>
    800039f8:	f8f769e3          	bltu	a4,a5,8000398a <wakeup+0x1a>
    }
  }
}
    800039fc:	0001                	nop
    800039fe:	0001                	nop
    80003a00:	70a2                	ld	ra,40(sp)
    80003a02:	7402                	ld	s0,32(sp)
    80003a04:	6145                	addi	sp,sp,48
    80003a06:	8082                	ret

0000000080003a08 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80003a08:	7179                	addi	sp,sp,-48
    80003a0a:	f406                	sd	ra,40(sp)
    80003a0c:	f022                	sd	s0,32(sp)
    80003a0e:	1800                	addi	s0,sp,48
    80003a10:	87aa                	mv	a5,a0
    80003a12:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80003a16:	00011797          	auipc	a5,0x11
    80003a1a:	c8278793          	addi	a5,a5,-894 # 80014698 <proc>
    80003a1e:	fef43423          	sd	a5,-24(s0)
    80003a22:	a0bd                	j	80003a90 <kill+0x88>
    acquire(&p->lock);
    80003a24:	fe843783          	ld	a5,-24(s0)
    80003a28:	853e                	mv	a0,a5
    80003a2a:	ffffe097          	auipc	ra,0xffffe
    80003a2e:	840080e7          	jalr	-1984(ra) # 8000126a <acquire>
    if(p->pid == pid){
    80003a32:	fe843783          	ld	a5,-24(s0)
    80003a36:	5b98                	lw	a4,48(a5)
    80003a38:	fdc42783          	lw	a5,-36(s0)
    80003a3c:	2781                	sext.w	a5,a5
    80003a3e:	02e79a63          	bne	a5,a4,80003a72 <kill+0x6a>
      p->killed = 1;
    80003a42:	fe843783          	ld	a5,-24(s0)
    80003a46:	4705                	li	a4,1
    80003a48:	d798                	sw	a4,40(a5)
      if(p->state == SLEEPING){
    80003a4a:	fe843783          	ld	a5,-24(s0)
    80003a4e:	4f9c                	lw	a5,24(a5)
    80003a50:	873e                	mv	a4,a5
    80003a52:	4789                	li	a5,2
    80003a54:	00f71663          	bne	a4,a5,80003a60 <kill+0x58>
        // Wake process from sleep().
        p->state = RUNNABLE;
    80003a58:	fe843783          	ld	a5,-24(s0)
    80003a5c:	470d                	li	a4,3
    80003a5e:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    80003a60:	fe843783          	ld	a5,-24(s0)
    80003a64:	853e                	mv	a0,a5
    80003a66:	ffffe097          	auipc	ra,0xffffe
    80003a6a:	868080e7          	jalr	-1944(ra) # 800012ce <release>
      return 0;
    80003a6e:	4781                	li	a5,0
    80003a70:	a80d                	j	80003aa2 <kill+0x9a>
    }
    release(&p->lock);
    80003a72:	fe843783          	ld	a5,-24(s0)
    80003a76:	853e                	mv	a0,a5
    80003a78:	ffffe097          	auipc	ra,0xffffe
    80003a7c:	856080e7          	jalr	-1962(ra) # 800012ce <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80003a80:	fe843703          	ld	a4,-24(s0)
    80003a84:	67c9                	lui	a5,0x12
    80003a86:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80003a8a:	97ba                	add	a5,a5,a4
    80003a8c:	fef43423          	sd	a5,-24(s0)
    80003a90:	fe843703          	ld	a4,-24(s0)
    80003a94:	00497797          	auipc	a5,0x497
    80003a98:	00478793          	addi	a5,a5,4 # 8049aa98 <pid_lock>
    80003a9c:	f8f764e3          	bltu	a4,a5,80003a24 <kill+0x1c>
  }
  return -1;
    80003aa0:	57fd                	li	a5,-1
}
    80003aa2:	853e                	mv	a0,a5
    80003aa4:	70a2                	ld	ra,40(sp)
    80003aa6:	7402                	ld	s0,32(sp)
    80003aa8:	6145                	addi	sp,sp,48
    80003aaa:	8082                	ret

0000000080003aac <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80003aac:	7139                	addi	sp,sp,-64
    80003aae:	fc06                	sd	ra,56(sp)
    80003ab0:	f822                	sd	s0,48(sp)
    80003ab2:	0080                	addi	s0,sp,64
    80003ab4:	87aa                	mv	a5,a0
    80003ab6:	fcb43823          	sd	a1,-48(s0)
    80003aba:	fcc43423          	sd	a2,-56(s0)
    80003abe:	fcd43023          	sd	a3,-64(s0)
    80003ac2:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80003ac6:	fffff097          	auipc	ra,0xfffff
    80003aca:	f52080e7          	jalr	-174(ra) # 80002a18 <myproc>
    80003ace:	fea43423          	sd	a0,-24(s0)
  if(user_dst){
    80003ad2:	fdc42783          	lw	a5,-36(s0)
    80003ad6:	2781                	sext.w	a5,a5
    80003ad8:	c38d                	beqz	a5,80003afa <either_copyout+0x4e>
    return copyout(p->pagetable, dst, src, len);
    80003ada:	fe843783          	ld	a5,-24(s0)
    80003ade:	6bbc                	ld	a5,80(a5)
    80003ae0:	fc043683          	ld	a3,-64(s0)
    80003ae4:	fc843603          	ld	a2,-56(s0)
    80003ae8:	fd043583          	ld	a1,-48(s0)
    80003aec:	853e                	mv	a0,a5
    80003aee:	fffff097          	auipc	ra,0xfffff
    80003af2:	8d8080e7          	jalr	-1832(ra) # 800023c6 <copyout>
    80003af6:	87aa                	mv	a5,a0
    80003af8:	a839                	j	80003b16 <either_copyout+0x6a>
  } else {
    memmove((char *)dst, src, len);
    80003afa:	fd043783          	ld	a5,-48(s0)
    80003afe:	fc043703          	ld	a4,-64(s0)
    80003b02:	2701                	sext.w	a4,a4
    80003b04:	863a                	mv	a2,a4
    80003b06:	fc843583          	ld	a1,-56(s0)
    80003b0a:	853e                	mv	a0,a5
    80003b0c:	ffffe097          	auipc	ra,0xffffe
    80003b10:	a16080e7          	jalr	-1514(ra) # 80001522 <memmove>
    return 0;
    80003b14:	4781                	li	a5,0
  }
}
    80003b16:	853e                	mv	a0,a5
    80003b18:	70e2                	ld	ra,56(sp)
    80003b1a:	7442                	ld	s0,48(sp)
    80003b1c:	6121                	addi	sp,sp,64
    80003b1e:	8082                	ret

0000000080003b20 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80003b20:	7139                	addi	sp,sp,-64
    80003b22:	fc06                	sd	ra,56(sp)
    80003b24:	f822                	sd	s0,48(sp)
    80003b26:	0080                	addi	s0,sp,64
    80003b28:	fca43c23          	sd	a0,-40(s0)
    80003b2c:	87ae                	mv	a5,a1
    80003b2e:	fcc43423          	sd	a2,-56(s0)
    80003b32:	fcd43023          	sd	a3,-64(s0)
    80003b36:	fcf42a23          	sw	a5,-44(s0)
  struct proc *p = myproc();
    80003b3a:	fffff097          	auipc	ra,0xfffff
    80003b3e:	ede080e7          	jalr	-290(ra) # 80002a18 <myproc>
    80003b42:	fea43423          	sd	a0,-24(s0)
  if(user_src){
    80003b46:	fd442783          	lw	a5,-44(s0)
    80003b4a:	2781                	sext.w	a5,a5
    80003b4c:	c38d                	beqz	a5,80003b6e <either_copyin+0x4e>
    return copyin(p->pagetable, dst, src, len);
    80003b4e:	fe843783          	ld	a5,-24(s0)
    80003b52:	6bbc                	ld	a5,80(a5)
    80003b54:	fc043683          	ld	a3,-64(s0)
    80003b58:	fc843603          	ld	a2,-56(s0)
    80003b5c:	fd843583          	ld	a1,-40(s0)
    80003b60:	853e                	mv	a0,a5
    80003b62:	fffff097          	auipc	ra,0xfffff
    80003b66:	932080e7          	jalr	-1742(ra) # 80002494 <copyin>
    80003b6a:	87aa                	mv	a5,a0
    80003b6c:	a839                	j	80003b8a <either_copyin+0x6a>
  } else {
    memmove(dst, (char*)src, len);
    80003b6e:	fc843783          	ld	a5,-56(s0)
    80003b72:	fc043703          	ld	a4,-64(s0)
    80003b76:	2701                	sext.w	a4,a4
    80003b78:	863a                	mv	a2,a4
    80003b7a:	85be                	mv	a1,a5
    80003b7c:	fd843503          	ld	a0,-40(s0)
    80003b80:	ffffe097          	auipc	ra,0xffffe
    80003b84:	9a2080e7          	jalr	-1630(ra) # 80001522 <memmove>
    return 0;
    80003b88:	4781                	li	a5,0
  }
}
    80003b8a:	853e                	mv	a0,a5
    80003b8c:	70e2                	ld	ra,56(sp)
    80003b8e:	7442                	ld	s0,48(sp)
    80003b90:	6121                	addi	sp,sp,64
    80003b92:	8082                	ret

0000000080003b94 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80003b94:	1101                	addi	sp,sp,-32
    80003b96:	ec06                	sd	ra,24(sp)
    80003b98:	e822                	sd	s0,16(sp)
    80003b9a:	1000                	addi	s0,sp,32
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80003b9c:	00007517          	auipc	a0,0x7
    80003ba0:	76450513          	addi	a0,a0,1892 # 8000b300 <etext+0x300>
    80003ba4:	ffffd097          	auipc	ra,0xffffd
    80003ba8:	e80080e7          	jalr	-384(ra) # 80000a24 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80003bac:	00011797          	auipc	a5,0x11
    80003bb0:	aec78793          	addi	a5,a5,-1300 # 80014698 <proc>
    80003bb4:	fef43423          	sd	a5,-24(s0)
    80003bb8:	a05d                	j	80003c5e <procdump+0xca>
    if(p->state == UNUSED)
    80003bba:	fe843783          	ld	a5,-24(s0)
    80003bbe:	4f9c                	lw	a5,24(a5)
    80003bc0:	c7d1                	beqz	a5,80003c4c <procdump+0xb8>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80003bc2:	fe843783          	ld	a5,-24(s0)
    80003bc6:	4f9c                	lw	a5,24(a5)
    80003bc8:	873e                	mv	a4,a5
    80003bca:	4795                	li	a5,5
    80003bcc:	02e7ee63          	bltu	a5,a4,80003c08 <procdump+0x74>
    80003bd0:	fe843783          	ld	a5,-24(s0)
    80003bd4:	4f9c                	lw	a5,24(a5)
    80003bd6:	00008717          	auipc	a4,0x8
    80003bda:	d5a70713          	addi	a4,a4,-678 # 8000b930 <states.0>
    80003bde:	1782                	slli	a5,a5,0x20
    80003be0:	9381                	srli	a5,a5,0x20
    80003be2:	078e                	slli	a5,a5,0x3
    80003be4:	97ba                	add	a5,a5,a4
    80003be6:	639c                	ld	a5,0(a5)
    80003be8:	c385                	beqz	a5,80003c08 <procdump+0x74>
      state = states[p->state];
    80003bea:	fe843783          	ld	a5,-24(s0)
    80003bee:	4f9c                	lw	a5,24(a5)
    80003bf0:	00008717          	auipc	a4,0x8
    80003bf4:	d4070713          	addi	a4,a4,-704 # 8000b930 <states.0>
    80003bf8:	1782                	slli	a5,a5,0x20
    80003bfa:	9381                	srli	a5,a5,0x20
    80003bfc:	078e                	slli	a5,a5,0x3
    80003bfe:	97ba                	add	a5,a5,a4
    80003c00:	639c                	ld	a5,0(a5)
    80003c02:	fef43023          	sd	a5,-32(s0)
    80003c06:	a039                	j	80003c14 <procdump+0x80>
    else
      state = "???";
    80003c08:	00007797          	auipc	a5,0x7
    80003c0c:	70078793          	addi	a5,a5,1792 # 8000b308 <etext+0x308>
    80003c10:	fef43023          	sd	a5,-32(s0)
    printf("%d %s %s", p->pid, state, p->name);
    80003c14:	fe843783          	ld	a5,-24(s0)
    80003c18:	5b98                	lw	a4,48(a5)
    80003c1a:	fe843783          	ld	a5,-24(s0)
    80003c1e:	16878793          	addi	a5,a5,360
    80003c22:	86be                	mv	a3,a5
    80003c24:	fe043603          	ld	a2,-32(s0)
    80003c28:	85ba                	mv	a1,a4
    80003c2a:	00007517          	auipc	a0,0x7
    80003c2e:	6e650513          	addi	a0,a0,1766 # 8000b310 <etext+0x310>
    80003c32:	ffffd097          	auipc	ra,0xffffd
    80003c36:	df2080e7          	jalr	-526(ra) # 80000a24 <printf>
    printf("\n");
    80003c3a:	00007517          	auipc	a0,0x7
    80003c3e:	6c650513          	addi	a0,a0,1734 # 8000b300 <etext+0x300>
    80003c42:	ffffd097          	auipc	ra,0xffffd
    80003c46:	de2080e7          	jalr	-542(ra) # 80000a24 <printf>
    80003c4a:	a011                	j	80003c4e <procdump+0xba>
      continue;
    80003c4c:	0001                	nop
  for(p = proc; p < &proc[NPROC]; p++){
    80003c4e:	fe843703          	ld	a4,-24(s0)
    80003c52:	67c9                	lui	a5,0x12
    80003c54:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80003c58:	97ba                	add	a5,a5,a4
    80003c5a:	fef43423          	sd	a5,-24(s0)
    80003c5e:	fe843703          	ld	a4,-24(s0)
    80003c62:	00497797          	auipc	a5,0x497
    80003c66:	e3678793          	addi	a5,a5,-458 # 8049aa98 <pid_lock>
    80003c6a:	f4f768e3          	bltu	a4,a5,80003bba <procdump+0x26>
  }
}
    80003c6e:	0001                	nop
    80003c70:	0001                	nop
    80003c72:	60e2                	ld	ra,24(sp)
    80003c74:	6442                	ld	s0,16(sp)
    80003c76:	6105                	addi	sp,sp,32
    80003c78:	8082                	ret

0000000080003c7a <clone>:


int clone(void(*fcn)(void*), void *arg, void*stack)
{
    80003c7a:	711d                	addi	sp,sp,-96
    80003c7c:	ec86                	sd	ra,88(sp)
    80003c7e:	e8a2                	sd	s0,80(sp)
    80003c80:	1080                	addi	s0,sp,96
    80003c82:	faa43c23          	sd	a0,-72(s0)
    80003c86:	fab43823          	sd	a1,-80(s0)
    80003c8a:	fac43423          	sd	a2,-88(s0)

  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    80003c8e:	fffff097          	auipc	ra,0xfffff
    80003c92:	d8a080e7          	jalr	-630(ra) # 80002a18 <myproc>
    80003c96:	fea43023          	sd	a0,-32(s0)

  // Allocate process.
  if((np = allocproc()) == 0){
    80003c9a:	fffff097          	auipc	ra,0xfffff
    80003c9e:	e18080e7          	jalr	-488(ra) # 80002ab2 <allocproc>
    80003ca2:	fca43c23          	sd	a0,-40(s0)
    80003ca6:	fd843783          	ld	a5,-40(s0)
    80003caa:	e399                	bnez	a5,80003cb0 <clone+0x36>
    return -1;
    80003cac:	57fd                	li	a5,-1
    80003cae:	ac69                	j	80003f48 <clone+0x2ce>
  }

  // Copy user memory from parent to child.
  if(uvmcopyThread(p->pagetable, np->pagetable, p->sz) < 0){
    80003cb0:	fe043783          	ld	a5,-32(s0)
    80003cb4:	6bb8                	ld	a4,80(a5)
    80003cb6:	fd843783          	ld	a5,-40(s0)
    80003cba:	6bb4                	ld	a3,80(a5)
    80003cbc:	fe043783          	ld	a5,-32(s0)
    80003cc0:	67bc                	ld	a5,72(a5)
    80003cc2:	863e                	mv	a2,a5
    80003cc4:	85b6                	mv	a1,a3
    80003cc6:	853a                	mv	a0,a4
    80003cc8:	ffffe097          	auipc	ra,0xffffe
    80003ccc:	5c8080e7          	jalr	1480(ra) # 80002290 <uvmcopyThread>
    80003cd0:	87aa                	mv	a5,a0
    80003cd2:	0207d163          	bgez	a5,80003cf4 <clone+0x7a>
    freeproc(np);
    80003cd6:	fd843503          	ld	a0,-40(s0)
    80003cda:	fffff097          	auipc	ra,0xfffff
    80003cde:	f36080e7          	jalr	-202(ra) # 80002c10 <freeproc>
    release(&np->lock);
    80003ce2:	fd843783          	ld	a5,-40(s0)
    80003ce6:	853e                	mv	a0,a5
    80003ce8:	ffffd097          	auipc	ra,0xffffd
    80003cec:	5e6080e7          	jalr	1510(ra) # 800012ce <release>
    return -1;
    80003cf0:	57fd                	li	a5,-1
    80003cf2:	ac99                	j	80003f48 <clone+0x2ce>
  }

   //comparten el mismo espacio de direcciones
  //np->pagetable = p->pagetable;

  np->thread = 1;
    80003cf4:	fd843703          	ld	a4,-40(s0)
    80003cf8:	67c9                	lui	a5,0x12
    80003cfa:	97ba                	add	a5,a5,a4
    80003cfc:	4705                	li	a4,1
    80003cfe:	18e7a423          	sw	a4,392(a5) # 12188 <_entry-0x7ffede78>
  np->sz = p->sz;
    80003d02:	fe043783          	ld	a5,-32(s0)
    80003d06:	67b8                	ld	a4,72(a5)
    80003d08:	fd843783          	ld	a5,-40(s0)
    80003d0c:	e7b8                	sd	a4,72(a5)

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    80003d0e:	fe043783          	ld	a5,-32(s0)
    80003d12:	73b8                	ld	a4,96(a5)
    80003d14:	fd843783          	ld	a5,-40(s0)
    80003d18:	73bc                	ld	a5,96(a5)
    80003d1a:	86be                	mv	a3,a5
    80003d1c:	12000793          	li	a5,288
    80003d20:	863e                	mv	a2,a5
    80003d22:	85ba                	mv	a1,a4
    80003d24:	8536                	mv	a0,a3
    80003d26:	ffffe097          	auipc	ra,0xffffe
    80003d2a:	8d8080e7          	jalr	-1832(ra) # 800015fe <memcpy>

  //indicamos al hijo que empiece ejecutando en la función
  np->trapframe->epc = (uint64) fcn;
    80003d2e:	fd843783          	ld	a5,-40(s0)
    80003d32:	73bc                	ld	a5,96(a5)
    80003d34:	fb843703          	ld	a4,-72(s0)
    80003d38:	ef98                	sd	a4,24(a5)

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = (uint64)arg;
    80003d3a:	fd843783          	ld	a5,-40(s0)
    80003d3e:	73bc                	ld	a5,96(a5)
    80003d40:	fb043703          	ld	a4,-80(s0)
    80003d44:	fbb8                	sd	a4,112(a5)



  //Apuntamos al final del stack y luego vamos insertamos
  uint64 stack_args[2]; 
  stack_args[0] =  0xffffffff; 
    80003d46:	57fd                	li	a5,-1
    80003d48:	9381                	srli	a5,a5,0x20
    80003d4a:	fcf43023          	sd	a5,-64(s0)
  stack_args[1] =  (uint64)arg;
    80003d4e:	fb043783          	ld	a5,-80(s0)
    80003d52:	fcf43423          	sd	a5,-56(s0)
  
  np->bottom_ustack = (uint64) stack; //base de stack, para liberar en join
    80003d56:	fa843703          	ld	a4,-88(s0)
    80003d5a:	fd843683          	ld	a3,-40(s0)
    80003d5e:	6789                	lui	a5,0x2
    80003d60:	97b6                	add	a5,a5,a3
    80003d62:	18e7b023          	sd	a4,384(a5) # 2180 <_entry-0x7fffde80>
  np->top_ustack = np->bottom_ustack + PGSIZE; //tope de stack
    80003d66:	fd843703          	ld	a4,-40(s0)
    80003d6a:	6789                	lui	a5,0x2
    80003d6c:	97ba                	add	a5,a5,a4
    80003d6e:	1807b703          	ld	a4,384(a5) # 2180 <_entry-0x7fffde80>
    80003d72:	6785                	lui	a5,0x1
    80003d74:	973e                	add	a4,a4,a5
    80003d76:	fd843683          	ld	a3,-40(s0)
    80003d7a:	6789                	lui	a5,0x2
    80003d7c:	97b6                	add	a5,a5,a3
    80003d7e:	16e7bc23          	sd	a4,376(a5) # 2178 <_entry-0x7fffde88>
  np->top_ustack -= 16;
    80003d82:	fd843703          	ld	a4,-40(s0)
    80003d86:	6789                	lui	a5,0x2
    80003d88:	97ba                	add	a5,a5,a4
    80003d8a:	1787b783          	ld	a5,376(a5) # 2178 <_entry-0x7fffde88>
    80003d8e:	ff078713          	addi	a4,a5,-16
    80003d92:	fd843683          	ld	a3,-40(s0)
    80003d96:	6789                	lui	a5,0x2
    80003d98:	97b6                	add	a5,a5,a3
    80003d9a:	16e7bc23          	sd	a4,376(a5) # 2178 <_entry-0x7fffde88>
  //np->top_ustack -=  np->top_ustack %16;


  printf ("Antes de hacer copyout.\n");
    80003d9e:	00007517          	auipc	a0,0x7
    80003da2:	58250513          	addi	a0,a0,1410 # 8000b320 <etext+0x320>
    80003da6:	ffffd097          	auipc	ra,0xffffd
    80003daa:	c7e080e7          	jalr	-898(ra) # 80000a24 <printf>

  //copyout
  if (copyout(np->pagetable, np->top_ustack, (char *) stack_args, 16) < 0) {
    80003dae:	fd843783          	ld	a5,-40(s0)
    80003db2:	6ba8                	ld	a0,80(a5)
    80003db4:	fd843703          	ld	a4,-40(s0)
    80003db8:	6789                	lui	a5,0x2
    80003dba:	97ba                	add	a5,a5,a4
    80003dbc:	1787b783          	ld	a5,376(a5) # 2178 <_entry-0x7fffde88>
    80003dc0:	fc040713          	addi	a4,s0,-64
    80003dc4:	46c1                	li	a3,16
    80003dc6:	863a                	mv	a2,a4
    80003dc8:	85be                	mv	a1,a5
    80003dca:	ffffe097          	auipc	ra,0xffffe
    80003dce:	5fc080e7          	jalr	1532(ra) # 800023c6 <copyout>
    80003dd2:	87aa                	mv	a5,a0
    80003dd4:	0007db63          	bgez	a5,80003dea <clone+0x170>
     release(&np->lock);
    80003dd8:	fd843783          	ld	a5,-40(s0)
    80003ddc:	853e                	mv	a0,a5
    80003dde:	ffffd097          	auipc	ra,0xffffd
    80003de2:	4f0080e7          	jalr	1264(ra) # 800012ce <release>
     //elease(&wait_lock);
        return -1;
    80003de6:	57fd                	li	a5,-1
    80003de8:	a285                	j	80003f48 <clone+0x2ce>
    }



  printf ("Copyout correcto al stack del thread.\n");
    80003dea:	00007517          	auipc	a0,0x7
    80003dee:	55650513          	addi	a0,a0,1366 # 8000b340 <etext+0x340>
    80003df2:	ffffd097          	auipc	ra,0xffffd
    80003df6:	c32080e7          	jalr	-974(ra) # 80000a24 <printf>

  //actualiza stack pointer
  np->trapframe->sp= np->top_ustack; 
    80003dfa:	fd843783          	ld	a5,-40(s0)
    80003dfe:	73bc                	ld	a5,96(a5)
    80003e00:	fd843683          	ld	a3,-40(s0)
    80003e04:	6709                	lui	a4,0x2
    80003e06:	9736                	add	a4,a4,a3
    80003e08:	17873703          	ld	a4,376(a4) # 2178 <_entry-0x7fffde88>
    80003e0c:	fb98                	sd	a4,48(a5)



  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    80003e0e:	fe042623          	sw	zero,-20(s0)
    80003e12:	a0a9                	j	80003e5c <clone+0x1e2>
    if(p->ofile[i])
    80003e14:	fe043703          	ld	a4,-32(s0)
    80003e18:	fec42783          	lw	a5,-20(s0)
    80003e1c:	07f1                	addi	a5,a5,28
    80003e1e:	078e                	slli	a5,a5,0x3
    80003e20:	97ba                	add	a5,a5,a4
    80003e22:	639c                	ld	a5,0(a5)
    80003e24:	c79d                	beqz	a5,80003e52 <clone+0x1d8>
      np->ofile[i] = filedup(p->ofile[i]);
    80003e26:	fe043703          	ld	a4,-32(s0)
    80003e2a:	fec42783          	lw	a5,-20(s0)
    80003e2e:	07f1                	addi	a5,a5,28
    80003e30:	078e                	slli	a5,a5,0x3
    80003e32:	97ba                	add	a5,a5,a4
    80003e34:	639c                	ld	a5,0(a5)
    80003e36:	853e                	mv	a0,a5
    80003e38:	00003097          	auipc	ra,0x3
    80003e3c:	3a8080e7          	jalr	936(ra) # 800071e0 <filedup>
    80003e40:	86aa                	mv	a3,a0
    80003e42:	fd843703          	ld	a4,-40(s0)
    80003e46:	fec42783          	lw	a5,-20(s0)
    80003e4a:	07f1                	addi	a5,a5,28
    80003e4c:	078e                	slli	a5,a5,0x3
    80003e4e:	97ba                	add	a5,a5,a4
    80003e50:	e394                	sd	a3,0(a5)
  for(i = 0; i < NOFILE; i++)
    80003e52:	fec42783          	lw	a5,-20(s0)
    80003e56:	2785                	addiw	a5,a5,1
    80003e58:	fef42623          	sw	a5,-20(s0)
    80003e5c:	fec42783          	lw	a5,-20(s0)
    80003e60:	0007871b          	sext.w	a4,a5
    80003e64:	47bd                	li	a5,15
    80003e66:	fae7d7e3          	bge	a5,a4,80003e14 <clone+0x19a>
  np->cwd = idup(p->cwd);
    80003e6a:	fe043783          	ld	a5,-32(s0)
    80003e6e:	1607b783          	ld	a5,352(a5)
    80003e72:	853e                	mv	a0,a5
    80003e74:	00002097          	auipc	ra,0x2
    80003e78:	c84080e7          	jalr	-892(ra) # 80005af8 <idup>
    80003e7c:	872a                	mv	a4,a0
    80003e7e:	fd843783          	ld	a5,-40(s0)
    80003e82:	16e7b023          	sd	a4,352(a5)

  safestrcpy(np->name, p->name, sizeof(p->name));
    80003e86:	fd843783          	ld	a5,-40(s0)
    80003e8a:	16878713          	addi	a4,a5,360
    80003e8e:	fe043783          	ld	a5,-32(s0)
    80003e92:	16878793          	addi	a5,a5,360
    80003e96:	4641                	li	a2,16
    80003e98:	85be                	mv	a1,a5
    80003e9a:	853a                	mv	a0,a4
    80003e9c:	ffffe097          	auipc	ra,0xffffe
    80003ea0:	8a6080e7          	jalr	-1882(ra) # 80001742 <safestrcpy>

  pid = np->pid;
    80003ea4:	fd843783          	ld	a5,-40(s0)
    80003ea8:	5b9c                	lw	a5,48(a5)
    80003eaa:	fcf42a23          	sw	a5,-44(s0)

  release(&np->lock);
    80003eae:	fd843783          	ld	a5,-40(s0)
    80003eb2:	853e                	mv	a0,a5
    80003eb4:	ffffd097          	auipc	ra,0xffffd
    80003eb8:	41a080e7          	jalr	1050(ra) # 800012ce <release>

  acquire(&wait_lock);
    80003ebc:	00497517          	auipc	a0,0x497
    80003ec0:	bf450513          	addi	a0,a0,-1036 # 8049aab0 <wait_lock>
    80003ec4:	ffffd097          	auipc	ra,0xffffd
    80003ec8:	3a6080e7          	jalr	934(ra) # 8000126a <acquire>
  np->parent = p;
    80003ecc:	fd843783          	ld	a5,-40(s0)
    80003ed0:	fe043703          	ld	a4,-32(s0)
    80003ed4:	ff98                	sd	a4,56(a5)
  release(&wait_lock);
    80003ed6:	00497517          	auipc	a0,0x497
    80003eda:	bda50513          	addi	a0,a0,-1062 # 8049aab0 <wait_lock>
    80003ede:	ffffd097          	auipc	ra,0xffffd
    80003ee2:	3f0080e7          	jalr	1008(ra) # 800012ce <release>

  acquire(&p->lock);
    80003ee6:	fe043783          	ld	a5,-32(s0)
    80003eea:	853e                	mv	a0,a5
    80003eec:	ffffd097          	auipc	ra,0xffffd
    80003ef0:	37e080e7          	jalr	894(ra) # 8000126a <acquire>
  p->referencias++;
    80003ef4:	fe043703          	ld	a4,-32(s0)
    80003ef8:	67c9                	lui	a5,0x12
    80003efa:	97ba                	add	a5,a5,a4
    80003efc:	18c7a783          	lw	a5,396(a5) # 1218c <_entry-0x7ffede74>
    80003f00:	2785                	addiw	a5,a5,1
    80003f02:	0007871b          	sext.w	a4,a5
    80003f06:	fe043683          	ld	a3,-32(s0)
    80003f0a:	67c9                	lui	a5,0x12
    80003f0c:	97b6                	add	a5,a5,a3
    80003f0e:	18e7a623          	sw	a4,396(a5) # 1218c <_entry-0x7ffede74>
  release(&p->lock);
    80003f12:	fe043783          	ld	a5,-32(s0)
    80003f16:	853e                	mv	a0,a5
    80003f18:	ffffd097          	auipc	ra,0xffffd
    80003f1c:	3b6080e7          	jalr	950(ra) # 800012ce <release>



  acquire(&np->lock);
    80003f20:	fd843783          	ld	a5,-40(s0)
    80003f24:	853e                	mv	a0,a5
    80003f26:	ffffd097          	auipc	ra,0xffffd
    80003f2a:	344080e7          	jalr	836(ra) # 8000126a <acquire>
  np->state = RUNNABLE;
    80003f2e:	fd843783          	ld	a5,-40(s0)
    80003f32:	470d                	li	a4,3
    80003f34:	cf98                	sw	a4,24(a5)
  release(&np->lock);
    80003f36:	fd843783          	ld	a5,-40(s0)
    80003f3a:	853e                	mv	a0,a5
    80003f3c:	ffffd097          	auipc	ra,0xffffd
    80003f40:	392080e7          	jalr	914(ra) # 800012ce <release>


  //actualizamos las referencias
  

  return pid;
    80003f44:	fd442783          	lw	a5,-44(s0)


}
    80003f48:	853e                	mv	a0,a5
    80003f4a:	60e6                	ld	ra,88(sp)
    80003f4c:	6446                	ld	s0,80(sp)
    80003f4e:	6125                	addi	sp,sp,96
    80003f50:	8082                	ret

0000000080003f52 <join>:


int join (uint64 addr_stack){
    80003f52:	715d                	addi	sp,sp,-80
    80003f54:	e486                	sd	ra,72(sp)
    80003f56:	e0a2                	sd	s0,64(sp)
    80003f58:	0880                	addi	s0,sp,80
    80003f5a:	faa43c23          	sd	a0,-72(s0)

  struct proc *np;
  int havekids, pid;
  void **stack;
  struct proc *p = myproc();
    80003f5e:	fffff097          	auipc	ra,0xfffff
    80003f62:	aba080e7          	jalr	-1350(ra) # 80002a18 <myproc>
    80003f66:	fca43c23          	sd	a0,-40(s0)

  
  acquire(&wait_lock);
    80003f6a:	00497517          	auipc	a0,0x497
    80003f6e:	b4650513          	addi	a0,a0,-1210 # 8049aab0 <wait_lock>
    80003f72:	ffffd097          	auipc	ra,0xffffd
    80003f76:	2f8080e7          	jalr	760(ra) # 8000126a <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    80003f7a:	fe042223          	sw	zero,-28(s0)
    for(np = proc; np < &proc[NPROC]; np++){
    80003f7e:	00010797          	auipc	a5,0x10
    80003f82:	71a78793          	addi	a5,a5,1818 # 80014698 <proc>
    80003f86:	fef43423          	sd	a5,-24(s0)
    80003f8a:	aa59                	j	80004120 <join+0x1ce>
      if(np->parent == p && np->thread == 1){ //modificamos la condición para que se seleccione solo al thread hijo del proceso
    80003f8c:	fe843783          	ld	a5,-24(s0)
    80003f90:	7f9c                	ld	a5,56(a5)
    80003f92:	fd843703          	ld	a4,-40(s0)
    80003f96:	16f71d63          	bne	a4,a5,80004110 <join+0x1be>
    80003f9a:	fe843703          	ld	a4,-24(s0)
    80003f9e:	67c9                	lui	a5,0x12
    80003fa0:	97ba                	add	a5,a5,a4
    80003fa2:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    80003fa6:	873e                	mv	a4,a5
    80003fa8:	4785                	li	a5,1
    80003faa:	16f71363          	bne	a4,a5,80004110 <join+0x1be>


        // make sure the child isn't still in exit() or swtch().
        acquire(&np->lock);
    80003fae:	fe843783          	ld	a5,-24(s0)
    80003fb2:	853e                	mv	a0,a5
    80003fb4:	ffffd097          	auipc	ra,0xffffd
    80003fb8:	2b6080e7          	jalr	694(ra) # 8000126a <acquire>

        havekids = 1;
    80003fbc:	4785                	li	a5,1
    80003fbe:	fef42223          	sw	a5,-28(s0)
        if(np->state == ZOMBIE){
    80003fc2:	fe843783          	ld	a5,-24(s0)
    80003fc6:	4f9c                	lw	a5,24(a5)
    80003fc8:	873e                	mv	a4,a5
    80003fca:	4795                	li	a5,5
    80003fcc:	12f71b63          	bne	a4,a5,80004102 <join+0x1b0>
          // Found one.

          //copiamos en el argumento stack la dirección del stack de usuario para que pueda liberarse después con free
          stack = (void**)np->bottom_ustack; 
    80003fd0:	fe843703          	ld	a4,-24(s0)
    80003fd4:	6789                	lui	a5,0x2
    80003fd6:	97ba                	add	a5,a5,a4
    80003fd8:	1807b783          	ld	a5,384(a5) # 2180 <_entry-0x7fffde80>
    80003fdc:	fcf43423          	sd	a5,-56(s0)
          pid = np->pid;
    80003fe0:	fe843783          	ld	a5,-24(s0)
    80003fe4:	5b9c                	lw	a5,48(a5)
    80003fe6:	fcf42a23          	sw	a5,-44(s0)

          np->sz = np->parent->sz;
    80003fea:	fe843783          	ld	a5,-24(s0)
    80003fee:	7f9c                	ld	a5,56(a5)
    80003ff0:	67b8                	ld	a4,72(a5)
    80003ff2:	fe843783          	ld	a5,-24(s0)
    80003ff6:	e7b8                	sd	a4,72(a5)

          printf ("ADDR: %d\n", addr_stack);
    80003ff8:	fb843583          	ld	a1,-72(s0)
    80003ffc:	00007517          	auipc	a0,0x7
    80004000:	36c50513          	addi	a0,a0,876 # 8000b368 <etext+0x368>
    80004004:	ffffd097          	auipc	ra,0xffffd
    80004008:	a20080e7          	jalr	-1504(ra) # 80000a24 <printf>
          printf ("Voy a hacer copyout en join\n");
    8000400c:	00007517          	auipc	a0,0x7
    80004010:	36c50513          	addi	a0,a0,876 # 8000b378 <etext+0x378>
    80004014:	ffffd097          	auipc	ra,0xffffd
    80004018:	a10080e7          	jalr	-1520(ra) # 80000a24 <printf>
          if ((copyout (np->pagetable, addr_stack, (char *)&stack, sizeof(uint64))) < 0){
    8000401c:	fe843783          	ld	a5,-24(s0)
    80004020:	6bbc                	ld	a5,80(a5)
    80004022:	fc840713          	addi	a4,s0,-56
    80004026:	46a1                	li	a3,8
    80004028:	863a                	mv	a2,a4
    8000402a:	fb843583          	ld	a1,-72(s0)
    8000402e:	853e                	mv	a0,a5
    80004030:	ffffe097          	auipc	ra,0xffffe
    80004034:	396080e7          	jalr	918(ra) # 800023c6 <copyout>
    80004038:	87aa                	mv	a5,a0
    8000403a:	0207d363          	bgez	a5,80004060 <join+0x10e>
             release(&np->lock); //libera thread
    8000403e:	fe843783          	ld	a5,-24(s0)
    80004042:	853e                	mv	a0,a5
    80004044:	ffffd097          	auipc	ra,0xffffd
    80004048:	28a080e7          	jalr	650(ra) # 800012ce <release>
             release(&wait_lock);
    8000404c:	00497517          	auipc	a0,0x497
    80004050:	a6450513          	addi	a0,a0,-1436 # 8049aab0 <wait_lock>
    80004054:	ffffd097          	auipc	ra,0xffffd
    80004058:	27a080e7          	jalr	634(ra) # 800012ce <release>
             return -1;
    8000405c:	57fd                	li	a5,-1
    8000405e:	a231                	j	8000416a <join+0x218>
          }
         

          printf ("Stack del join: %d\n", stack);
    80004060:	fc843783          	ld	a5,-56(s0)
    80004064:	85be                	mv	a1,a5
    80004066:	00007517          	auipc	a0,0x7
    8000406a:	33250513          	addi	a0,a0,818 # 8000b398 <etext+0x398>
    8000406e:	ffffd097          	auipc	ra,0xffffd
    80004072:	9b6080e7          	jalr	-1610(ra) # 80000a24 <printf>

          acquire(&p->lock);
    80004076:	fd843783          	ld	a5,-40(s0)
    8000407a:	853e                	mv	a0,a5
    8000407c:	ffffd097          	auipc	ra,0xffffd
    80004080:	1ee080e7          	jalr	494(ra) # 8000126a <acquire>
          p->referencias--;
    80004084:	fd843703          	ld	a4,-40(s0)
    80004088:	67c9                	lui	a5,0x12
    8000408a:	97ba                	add	a5,a5,a4
    8000408c:	18c7a783          	lw	a5,396(a5) # 1218c <_entry-0x7ffede74>
    80004090:	37fd                	addiw	a5,a5,-1
    80004092:	0007871b          	sext.w	a4,a5
    80004096:	fd843683          	ld	a3,-40(s0)
    8000409a:	67c9                	lui	a5,0x12
    8000409c:	97b6                	add	a5,a5,a3
    8000409e:	18e7a623          	sw	a4,396(a5) # 1218c <_entry-0x7ffede74>
          release(&p->lock);
    800040a2:	fd843783          	ld	a5,-40(s0)
    800040a6:	853e                	mv	a0,a5
    800040a8:	ffffd097          	auipc	ra,0xffffd
    800040ac:	226080e7          	jalr	550(ra) # 800012ce <release>
          
          if (np->thread == 1){
    800040b0:	fe843703          	ld	a4,-24(s0)
    800040b4:	67c9                	lui	a5,0x12
    800040b6:	97ba                	add	a5,a5,a4
    800040b8:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    800040bc:	873e                	mv	a4,a5
    800040be:	4785                	li	a5,1
    800040c0:	00f71963          	bne	a4,a5,800040d2 <join+0x180>
            freethread(np);
    800040c4:	fe843503          	ld	a0,-24(s0)
    800040c8:	fffff097          	auipc	ra,0xfffff
    800040cc:	be6080e7          	jalr	-1050(ra) # 80002cae <freethread>
    800040d0:	a039                	j	800040de <join+0x18c>

          } else {
              freeproc(np);
    800040d2:	fe843503          	ld	a0,-24(s0)
    800040d6:	fffff097          	auipc	ra,0xfffff
    800040da:	b3a080e7          	jalr	-1222(ra) # 80002c10 <freeproc>
          }


          release(&np->lock); //libera thread
    800040de:	fe843783          	ld	a5,-24(s0)
    800040e2:	853e                	mv	a0,a5
    800040e4:	ffffd097          	auipc	ra,0xffffd
    800040e8:	1ea080e7          	jalr	490(ra) # 800012ce <release>
          release(&wait_lock);
    800040ec:	00497517          	auipc	a0,0x497
    800040f0:	9c450513          	addi	a0,a0,-1596 # 8049aab0 <wait_lock>
    800040f4:	ffffd097          	auipc	ra,0xffffd
    800040f8:	1da080e7          	jalr	474(ra) # 800012ce <release>
          
          return pid; //devolvemos TID 
    800040fc:	fd442783          	lw	a5,-44(s0)
    80004100:	a0ad                	j	8000416a <join+0x218>
        }
        release(&np->lock);
    80004102:	fe843783          	ld	a5,-24(s0)
    80004106:	853e                	mv	a0,a5
    80004108:	ffffd097          	auipc	ra,0xffffd
    8000410c:	1c6080e7          	jalr	454(ra) # 800012ce <release>
    for(np = proc; np < &proc[NPROC]; np++){
    80004110:	fe843703          	ld	a4,-24(s0)
    80004114:	67c9                	lui	a5,0x12
    80004116:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    8000411a:	97ba                	add	a5,a5,a4
    8000411c:	fef43423          	sd	a5,-24(s0)
    80004120:	fe843703          	ld	a4,-24(s0)
    80004124:	00497797          	auipc	a5,0x497
    80004128:	97478793          	addi	a5,a5,-1676 # 8049aa98 <pid_lock>
    8000412c:	e6f760e3          	bltu	a4,a5,80003f8c <join+0x3a>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || p->killed){
    80004130:	fe442783          	lw	a5,-28(s0)
    80004134:	2781                	sext.w	a5,a5
    80004136:	c789                	beqz	a5,80004140 <join+0x1ee>
    80004138:	fd843783          	ld	a5,-40(s0)
    8000413c:	579c                	lw	a5,40(a5)
    8000413e:	cb99                	beqz	a5,80004154 <join+0x202>
      release(&wait_lock);
    80004140:	00497517          	auipc	a0,0x497
    80004144:	97050513          	addi	a0,a0,-1680 # 8049aab0 <wait_lock>
    80004148:	ffffd097          	auipc	ra,0xffffd
    8000414c:	186080e7          	jalr	390(ra) # 800012ce <release>
      return -1;
    80004150:	57fd                	li	a5,-1
    80004152:	a821                	j	8000416a <join+0x218>
    }

    
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80004154:	00497597          	auipc	a1,0x497
    80004158:	95c58593          	addi	a1,a1,-1700 # 8049aab0 <wait_lock>
    8000415c:	fd843503          	ld	a0,-40(s0)
    80004160:	fffff097          	auipc	ra,0xfffff
    80004164:	794080e7          	jalr	1940(ra) # 800038f4 <sleep>
    havekids = 0;
    80004168:	bd09                	j	80003f7a <join+0x28>

  }

}
    8000416a:	853e                	mv	a0,a5
    8000416c:	60a6                	ld	ra,72(sp)
    8000416e:	6406                	ld	s0,64(sp)
    80004170:	6161                	addi	sp,sp,80
    80004172:	8082                	ret

0000000080004174 <swtch>:
    80004174:	00153023          	sd	ra,0(a0)
    80004178:	00253423          	sd	sp,8(a0)
    8000417c:	e900                	sd	s0,16(a0)
    8000417e:	ed04                	sd	s1,24(a0)
    80004180:	03253023          	sd	s2,32(a0)
    80004184:	03353423          	sd	s3,40(a0)
    80004188:	03453823          	sd	s4,48(a0)
    8000418c:	03553c23          	sd	s5,56(a0)
    80004190:	05653023          	sd	s6,64(a0)
    80004194:	05753423          	sd	s7,72(a0)
    80004198:	05853823          	sd	s8,80(a0)
    8000419c:	05953c23          	sd	s9,88(a0)
    800041a0:	07a53023          	sd	s10,96(a0)
    800041a4:	07b53423          	sd	s11,104(a0)
    800041a8:	0005b083          	ld	ra,0(a1)
    800041ac:	0085b103          	ld	sp,8(a1)
    800041b0:	6980                	ld	s0,16(a1)
    800041b2:	6d84                	ld	s1,24(a1)
    800041b4:	0205b903          	ld	s2,32(a1)
    800041b8:	0285b983          	ld	s3,40(a1)
    800041bc:	0305ba03          	ld	s4,48(a1)
    800041c0:	0385ba83          	ld	s5,56(a1)
    800041c4:	0405bb03          	ld	s6,64(a1)
    800041c8:	0485bb83          	ld	s7,72(a1)
    800041cc:	0505bc03          	ld	s8,80(a1)
    800041d0:	0585bc83          	ld	s9,88(a1)
    800041d4:	0605bd03          	ld	s10,96(a1)
    800041d8:	0685bd83          	ld	s11,104(a1)
    800041dc:	8082                	ret

00000000800041de <r_sstatus>:
{
    800041de:	1101                	addi	sp,sp,-32
    800041e0:	ec22                	sd	s0,24(sp)
    800041e2:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800041e4:	100027f3          	csrr	a5,sstatus
    800041e8:	fef43423          	sd	a5,-24(s0)
  return x;
    800041ec:	fe843783          	ld	a5,-24(s0)
}
    800041f0:	853e                	mv	a0,a5
    800041f2:	6462                	ld	s0,24(sp)
    800041f4:	6105                	addi	sp,sp,32
    800041f6:	8082                	ret

00000000800041f8 <w_sstatus>:
{
    800041f8:	1101                	addi	sp,sp,-32
    800041fa:	ec22                	sd	s0,24(sp)
    800041fc:	1000                	addi	s0,sp,32
    800041fe:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80004202:	fe843783          	ld	a5,-24(s0)
    80004206:	10079073          	csrw	sstatus,a5
}
    8000420a:	0001                	nop
    8000420c:	6462                	ld	s0,24(sp)
    8000420e:	6105                	addi	sp,sp,32
    80004210:	8082                	ret

0000000080004212 <r_sip>:
{
    80004212:	1101                	addi	sp,sp,-32
    80004214:	ec22                	sd	s0,24(sp)
    80004216:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sip" : "=r" (x) );
    80004218:	144027f3          	csrr	a5,sip
    8000421c:	fef43423          	sd	a5,-24(s0)
  return x;
    80004220:	fe843783          	ld	a5,-24(s0)
}
    80004224:	853e                	mv	a0,a5
    80004226:	6462                	ld	s0,24(sp)
    80004228:	6105                	addi	sp,sp,32
    8000422a:	8082                	ret

000000008000422c <w_sip>:
{
    8000422c:	1101                	addi	sp,sp,-32
    8000422e:	ec22                	sd	s0,24(sp)
    80004230:	1000                	addi	s0,sp,32
    80004232:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sip, %0" : : "r" (x));
    80004236:	fe843783          	ld	a5,-24(s0)
    8000423a:	14479073          	csrw	sip,a5
}
    8000423e:	0001                	nop
    80004240:	6462                	ld	s0,24(sp)
    80004242:	6105                	addi	sp,sp,32
    80004244:	8082                	ret

0000000080004246 <w_sepc>:
{
    80004246:	1101                	addi	sp,sp,-32
    80004248:	ec22                	sd	s0,24(sp)
    8000424a:	1000                	addi	s0,sp,32
    8000424c:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80004250:	fe843783          	ld	a5,-24(s0)
    80004254:	14179073          	csrw	sepc,a5
}
    80004258:	0001                	nop
    8000425a:	6462                	ld	s0,24(sp)
    8000425c:	6105                	addi	sp,sp,32
    8000425e:	8082                	ret

0000000080004260 <r_sepc>:
{
    80004260:	1101                	addi	sp,sp,-32
    80004262:	ec22                	sd	s0,24(sp)
    80004264:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80004266:	141027f3          	csrr	a5,sepc
    8000426a:	fef43423          	sd	a5,-24(s0)
  return x;
    8000426e:	fe843783          	ld	a5,-24(s0)
}
    80004272:	853e                	mv	a0,a5
    80004274:	6462                	ld	s0,24(sp)
    80004276:	6105                	addi	sp,sp,32
    80004278:	8082                	ret

000000008000427a <w_stvec>:
{
    8000427a:	1101                	addi	sp,sp,-32
    8000427c:	ec22                	sd	s0,24(sp)
    8000427e:	1000                	addi	s0,sp,32
    80004280:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw stvec, %0" : : "r" (x));
    80004284:	fe843783          	ld	a5,-24(s0)
    80004288:	10579073          	csrw	stvec,a5
}
    8000428c:	0001                	nop
    8000428e:	6462                	ld	s0,24(sp)
    80004290:	6105                	addi	sp,sp,32
    80004292:	8082                	ret

0000000080004294 <r_satp>:
{
    80004294:	1101                	addi	sp,sp,-32
    80004296:	ec22                	sd	s0,24(sp)
    80004298:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, satp" : "=r" (x) );
    8000429a:	180027f3          	csrr	a5,satp
    8000429e:	fef43423          	sd	a5,-24(s0)
  return x;
    800042a2:	fe843783          	ld	a5,-24(s0)
}
    800042a6:	853e                	mv	a0,a5
    800042a8:	6462                	ld	s0,24(sp)
    800042aa:	6105                	addi	sp,sp,32
    800042ac:	8082                	ret

00000000800042ae <r_scause>:
{
    800042ae:	1101                	addi	sp,sp,-32
    800042b0:	ec22                	sd	s0,24(sp)
    800042b2:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    800042b4:	142027f3          	csrr	a5,scause
    800042b8:	fef43423          	sd	a5,-24(s0)
  return x;
    800042bc:	fe843783          	ld	a5,-24(s0)
}
    800042c0:	853e                	mv	a0,a5
    800042c2:	6462                	ld	s0,24(sp)
    800042c4:	6105                	addi	sp,sp,32
    800042c6:	8082                	ret

00000000800042c8 <r_stval>:
{
    800042c8:	1101                	addi	sp,sp,-32
    800042ca:	ec22                	sd	s0,24(sp)
    800042cc:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, stval" : "=r" (x) );
    800042ce:	143027f3          	csrr	a5,stval
    800042d2:	fef43423          	sd	a5,-24(s0)
  return x;
    800042d6:	fe843783          	ld	a5,-24(s0)
}
    800042da:	853e                	mv	a0,a5
    800042dc:	6462                	ld	s0,24(sp)
    800042de:	6105                	addi	sp,sp,32
    800042e0:	8082                	ret

00000000800042e2 <intr_on>:
{
    800042e2:	1141                	addi	sp,sp,-16
    800042e4:	e406                	sd	ra,8(sp)
    800042e6:	e022                	sd	s0,0(sp)
    800042e8:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800042ea:	00000097          	auipc	ra,0x0
    800042ee:	ef4080e7          	jalr	-268(ra) # 800041de <r_sstatus>
    800042f2:	87aa                	mv	a5,a0
    800042f4:	0027e793          	ori	a5,a5,2
    800042f8:	853e                	mv	a0,a5
    800042fa:	00000097          	auipc	ra,0x0
    800042fe:	efe080e7          	jalr	-258(ra) # 800041f8 <w_sstatus>
}
    80004302:	0001                	nop
    80004304:	60a2                	ld	ra,8(sp)
    80004306:	6402                	ld	s0,0(sp)
    80004308:	0141                	addi	sp,sp,16
    8000430a:	8082                	ret

000000008000430c <intr_off>:
{
    8000430c:	1141                	addi	sp,sp,-16
    8000430e:	e406                	sd	ra,8(sp)
    80004310:	e022                	sd	s0,0(sp)
    80004312:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80004314:	00000097          	auipc	ra,0x0
    80004318:	eca080e7          	jalr	-310(ra) # 800041de <r_sstatus>
    8000431c:	87aa                	mv	a5,a0
    8000431e:	9bf5                	andi	a5,a5,-3
    80004320:	853e                	mv	a0,a5
    80004322:	00000097          	auipc	ra,0x0
    80004326:	ed6080e7          	jalr	-298(ra) # 800041f8 <w_sstatus>
}
    8000432a:	0001                	nop
    8000432c:	60a2                	ld	ra,8(sp)
    8000432e:	6402                	ld	s0,0(sp)
    80004330:	0141                	addi	sp,sp,16
    80004332:	8082                	ret

0000000080004334 <intr_get>:
{
    80004334:	1101                	addi	sp,sp,-32
    80004336:	ec06                	sd	ra,24(sp)
    80004338:	e822                	sd	s0,16(sp)
    8000433a:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    8000433c:	00000097          	auipc	ra,0x0
    80004340:	ea2080e7          	jalr	-350(ra) # 800041de <r_sstatus>
    80004344:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    80004348:	fe843783          	ld	a5,-24(s0)
    8000434c:	8b89                	andi	a5,a5,2
    8000434e:	00f037b3          	snez	a5,a5
    80004352:	0ff7f793          	zext.b	a5,a5
    80004356:	2781                	sext.w	a5,a5
}
    80004358:	853e                	mv	a0,a5
    8000435a:	60e2                	ld	ra,24(sp)
    8000435c:	6442                	ld	s0,16(sp)
    8000435e:	6105                	addi	sp,sp,32
    80004360:	8082                	ret

0000000080004362 <r_tp>:
{
    80004362:	1101                	addi	sp,sp,-32
    80004364:	ec22                	sd	s0,24(sp)
    80004366:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    80004368:	8792                	mv	a5,tp
    8000436a:	fef43423          	sd	a5,-24(s0)
  return x;
    8000436e:	fe843783          	ld	a5,-24(s0)
}
    80004372:	853e                	mv	a0,a5
    80004374:	6462                	ld	s0,24(sp)
    80004376:	6105                	addi	sp,sp,32
    80004378:	8082                	ret

000000008000437a <trapinit>:

extern int devintr();

void
trapinit(void)
{
    8000437a:	1141                	addi	sp,sp,-16
    8000437c:	e406                	sd	ra,8(sp)
    8000437e:	e022                	sd	s0,0(sp)
    80004380:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80004382:	00007597          	auipc	a1,0x7
    80004386:	05e58593          	addi	a1,a1,94 # 8000b3e0 <etext+0x3e0>
    8000438a:	00496517          	auipc	a0,0x496
    8000438e:	73e50513          	addi	a0,a0,1854 # 8049aac8 <tickslock>
    80004392:	ffffd097          	auipc	ra,0xffffd
    80004396:	ea8080e7          	jalr	-344(ra) # 8000123a <initlock>
}
    8000439a:	0001                	nop
    8000439c:	60a2                	ld	ra,8(sp)
    8000439e:	6402                	ld	s0,0(sp)
    800043a0:	0141                	addi	sp,sp,16
    800043a2:	8082                	ret

00000000800043a4 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    800043a4:	1141                	addi	sp,sp,-16
    800043a6:	e406                	sd	ra,8(sp)
    800043a8:	e022                	sd	s0,0(sp)
    800043aa:	0800                	addi	s0,sp,16
  w_stvec((uint64)kernelvec);
    800043ac:	00005797          	auipc	a5,0x5
    800043b0:	e9478793          	addi	a5,a5,-364 # 80009240 <kernelvec>
    800043b4:	853e                	mv	a0,a5
    800043b6:	00000097          	auipc	ra,0x0
    800043ba:	ec4080e7          	jalr	-316(ra) # 8000427a <w_stvec>
}
    800043be:	0001                	nop
    800043c0:	60a2                	ld	ra,8(sp)
    800043c2:	6402                	ld	s0,0(sp)
    800043c4:	0141                	addi	sp,sp,16
    800043c6:	8082                	ret

00000000800043c8 <usertrap>:
// handle an interrupt, exception, or system call from user space.
// called from trampoline.S
//
void
usertrap(void)
{
    800043c8:	7179                	addi	sp,sp,-48
    800043ca:	f406                	sd	ra,40(sp)
    800043cc:	f022                	sd	s0,32(sp)
    800043ce:	ec26                	sd	s1,24(sp)
    800043d0:	1800                	addi	s0,sp,48
  int which_dev = 0;
    800043d2:	fc042e23          	sw	zero,-36(s0)

  if((r_sstatus() & SSTATUS_SPP) != 0)
    800043d6:	00000097          	auipc	ra,0x0
    800043da:	e08080e7          	jalr	-504(ra) # 800041de <r_sstatus>
    800043de:	87aa                	mv	a5,a0
    800043e0:	1007f793          	andi	a5,a5,256
    800043e4:	cb89                	beqz	a5,800043f6 <usertrap+0x2e>
    panic("usertrap: not from user mode");
    800043e6:	00007517          	auipc	a0,0x7
    800043ea:	00250513          	addi	a0,a0,2 # 8000b3e8 <etext+0x3e8>
    800043ee:	ffffd097          	auipc	ra,0xffffd
    800043f2:	88c080e7          	jalr	-1908(ra) # 80000c7a <panic>

  // send interrupts and exceptions to kerneltrap(),
  // since we're now in the kernel.
  w_stvec((uint64)kernelvec);
    800043f6:	00005797          	auipc	a5,0x5
    800043fa:	e4a78793          	addi	a5,a5,-438 # 80009240 <kernelvec>
    800043fe:	853e                	mv	a0,a5
    80004400:	00000097          	auipc	ra,0x0
    80004404:	e7a080e7          	jalr	-390(ra) # 8000427a <w_stvec>

  struct proc *p = myproc();
    80004408:	ffffe097          	auipc	ra,0xffffe
    8000440c:	610080e7          	jalr	1552(ra) # 80002a18 <myproc>
    80004410:	fca43823          	sd	a0,-48(s0)
  
  // save user program counter.
  p->trapframe->epc = r_sepc();
    80004414:	fd043783          	ld	a5,-48(s0)
    80004418:	73a4                	ld	s1,96(a5)
    8000441a:	00000097          	auipc	ra,0x0
    8000441e:	e46080e7          	jalr	-442(ra) # 80004260 <r_sepc>
    80004422:	87aa                	mv	a5,a0
    80004424:	ec9c                	sd	a5,24(s1)
  
  if(r_scause() == 8){
    80004426:	00000097          	auipc	ra,0x0
    8000442a:	e88080e7          	jalr	-376(ra) # 800042ae <r_scause>
    8000442e:	872a                	mv	a4,a0
    80004430:	47a1                	li	a5,8
    80004432:	02f71d63          	bne	a4,a5,8000446c <usertrap+0xa4>
    // system call

    if(p->killed)
    80004436:	fd043783          	ld	a5,-48(s0)
    8000443a:	579c                	lw	a5,40(a5)
    8000443c:	c791                	beqz	a5,80004448 <usertrap+0x80>
      exit(-1);
    8000443e:	557d                	li	a0,-1
    80004440:	fffff097          	auipc	ra,0xfffff
    80004444:	fb4080e7          	jalr	-76(ra) # 800033f4 <exit>

    // sepc points to the ecall instruction,
    // but we want to return to the next instruction.
    p->trapframe->epc += 4;
    80004448:	fd043783          	ld	a5,-48(s0)
    8000444c:	73bc                	ld	a5,96(a5)
    8000444e:	6f98                	ld	a4,24(a5)
    80004450:	fd043783          	ld	a5,-48(s0)
    80004454:	73bc                	ld	a5,96(a5)
    80004456:	0711                	addi	a4,a4,4
    80004458:	ef98                	sd	a4,24(a5)

    // an interrupt will change sstatus &c registers,
    // so don't enable until done with those registers.
    intr_on();
    8000445a:	00000097          	auipc	ra,0x0
    8000445e:	e88080e7          	jalr	-376(ra) # 800042e2 <intr_on>

    syscall();
    80004462:	00000097          	auipc	ra,0x0
    80004466:	67e080e7          	jalr	1662(ra) # 80004ae0 <syscall>
    8000446a:	a0b5                	j	800044d6 <usertrap+0x10e>
  } else if((which_dev = devintr()) != 0){
    8000446c:	00000097          	auipc	ra,0x0
    80004470:	346080e7          	jalr	838(ra) # 800047b2 <devintr>
    80004474:	87aa                	mv	a5,a0
    80004476:	fcf42e23          	sw	a5,-36(s0)
    8000447a:	fdc42783          	lw	a5,-36(s0)
    8000447e:	2781                	sext.w	a5,a5
    80004480:	ebb9                	bnez	a5,800044d6 <usertrap+0x10e>
    // ok
  } else {
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80004482:	00000097          	auipc	ra,0x0
    80004486:	e2c080e7          	jalr	-468(ra) # 800042ae <r_scause>
    8000448a:	872a                	mv	a4,a0
    8000448c:	fd043783          	ld	a5,-48(s0)
    80004490:	5b9c                	lw	a5,48(a5)
    80004492:	863e                	mv	a2,a5
    80004494:	85ba                	mv	a1,a4
    80004496:	00007517          	auipc	a0,0x7
    8000449a:	f7250513          	addi	a0,a0,-142 # 8000b408 <etext+0x408>
    8000449e:	ffffc097          	auipc	ra,0xffffc
    800044a2:	586080e7          	jalr	1414(ra) # 80000a24 <printf>
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    800044a6:	00000097          	auipc	ra,0x0
    800044aa:	dba080e7          	jalr	-582(ra) # 80004260 <r_sepc>
    800044ae:	84aa                	mv	s1,a0
    800044b0:	00000097          	auipc	ra,0x0
    800044b4:	e18080e7          	jalr	-488(ra) # 800042c8 <r_stval>
    800044b8:	87aa                	mv	a5,a0
    800044ba:	863e                	mv	a2,a5
    800044bc:	85a6                	mv	a1,s1
    800044be:	00007517          	auipc	a0,0x7
    800044c2:	f7a50513          	addi	a0,a0,-134 # 8000b438 <etext+0x438>
    800044c6:	ffffc097          	auipc	ra,0xffffc
    800044ca:	55e080e7          	jalr	1374(ra) # 80000a24 <printf>
    p->killed = 1;
    800044ce:	fd043783          	ld	a5,-48(s0)
    800044d2:	4705                	li	a4,1
    800044d4:	d798                	sw	a4,40(a5)
  }

  if(p->killed)
    800044d6:	fd043783          	ld	a5,-48(s0)
    800044da:	579c                	lw	a5,40(a5)
    800044dc:	c791                	beqz	a5,800044e8 <usertrap+0x120>
    exit(-1);
    800044de:	557d                	li	a0,-1
    800044e0:	fffff097          	auipc	ra,0xfffff
    800044e4:	f14080e7          	jalr	-236(ra) # 800033f4 <exit>

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2)
    800044e8:	fdc42783          	lw	a5,-36(s0)
    800044ec:	0007871b          	sext.w	a4,a5
    800044f0:	4789                	li	a5,2
    800044f2:	00f71663          	bne	a4,a5,800044fe <usertrap+0x136>
    yield();
    800044f6:	fffff097          	auipc	ra,0xfffff
    800044fa:	364080e7          	jalr	868(ra) # 8000385a <yield>

  usertrapret();
    800044fe:	00000097          	auipc	ra,0x0
    80004502:	014080e7          	jalr	20(ra) # 80004512 <usertrapret>
}
    80004506:	0001                	nop
    80004508:	70a2                	ld	ra,40(sp)
    8000450a:	7402                	ld	s0,32(sp)
    8000450c:	64e2                	ld	s1,24(sp)
    8000450e:	6145                	addi	sp,sp,48
    80004510:	8082                	ret

0000000080004512 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80004512:	7139                	addi	sp,sp,-64
    80004514:	fc06                	sd	ra,56(sp)
    80004516:	f822                	sd	s0,48(sp)
    80004518:	f426                	sd	s1,40(sp)
    8000451a:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    8000451c:	ffffe097          	auipc	ra,0xffffe
    80004520:	4fc080e7          	jalr	1276(ra) # 80002a18 <myproc>
    80004524:	fca43c23          	sd	a0,-40(s0)

  // we're about to switch the destination of traps from
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();
    80004528:	00000097          	auipc	ra,0x0
    8000452c:	de4080e7          	jalr	-540(ra) # 8000430c <intr_off>

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80004530:	00006717          	auipc	a4,0x6
    80004534:	ad070713          	addi	a4,a4,-1328 # 8000a000 <_trampoline>
    80004538:	00006797          	auipc	a5,0x6
    8000453c:	ac878793          	addi	a5,a5,-1336 # 8000a000 <_trampoline>
    80004540:	8f1d                	sub	a4,a4,a5
    80004542:	040007b7          	lui	a5,0x4000
    80004546:	17fd                	addi	a5,a5,-1
    80004548:	07b2                	slli	a5,a5,0xc
    8000454a:	97ba                	add	a5,a5,a4
    8000454c:	853e                	mv	a0,a5
    8000454e:	00000097          	auipc	ra,0x0
    80004552:	d2c080e7          	jalr	-724(ra) # 8000427a <w_stvec>

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80004556:	fd843783          	ld	a5,-40(s0)
    8000455a:	73a4                	ld	s1,96(a5)
    8000455c:	00000097          	auipc	ra,0x0
    80004560:	d38080e7          	jalr	-712(ra) # 80004294 <r_satp>
    80004564:	87aa                	mv	a5,a0
    80004566:	e09c                	sd	a5,0(s1)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80004568:	fd843783          	ld	a5,-40(s0)
    8000456c:	63b4                	ld	a3,64(a5)
    8000456e:	fd843783          	ld	a5,-40(s0)
    80004572:	73bc                	ld	a5,96(a5)
    80004574:	6705                	lui	a4,0x1
    80004576:	9736                	add	a4,a4,a3
    80004578:	e798                	sd	a4,8(a5)
  p->trapframe->kernel_trap = (uint64)usertrap;
    8000457a:	fd843783          	ld	a5,-40(s0)
    8000457e:	73bc                	ld	a5,96(a5)
    80004580:	00000717          	auipc	a4,0x0
    80004584:	e4870713          	addi	a4,a4,-440 # 800043c8 <usertrap>
    80004588:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    8000458a:	fd843783          	ld	a5,-40(s0)
    8000458e:	73a4                	ld	s1,96(a5)
    80004590:	00000097          	auipc	ra,0x0
    80004594:	dd2080e7          	jalr	-558(ra) # 80004362 <r_tp>
    80004598:	87aa                	mv	a5,a0
    8000459a:	f09c                	sd	a5,32(s1)

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
    8000459c:	00000097          	auipc	ra,0x0
    800045a0:	c42080e7          	jalr	-958(ra) # 800041de <r_sstatus>
    800045a4:	fca43823          	sd	a0,-48(s0)
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800045a8:	fd043783          	ld	a5,-48(s0)
    800045ac:	eff7f793          	andi	a5,a5,-257
    800045b0:	fcf43823          	sd	a5,-48(s0)
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800045b4:	fd043783          	ld	a5,-48(s0)
    800045b8:	0207e793          	ori	a5,a5,32
    800045bc:	fcf43823          	sd	a5,-48(s0)
  w_sstatus(x);
    800045c0:	fd043503          	ld	a0,-48(s0)
    800045c4:	00000097          	auipc	ra,0x0
    800045c8:	c34080e7          	jalr	-972(ra) # 800041f8 <w_sstatus>

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    800045cc:	fd843783          	ld	a5,-40(s0)
    800045d0:	73bc                	ld	a5,96(a5)
    800045d2:	6f9c                	ld	a5,24(a5)
    800045d4:	853e                	mv	a0,a5
    800045d6:	00000097          	auipc	ra,0x0
    800045da:	c70080e7          	jalr	-912(ra) # 80004246 <w_sepc>

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    800045de:	fd843783          	ld	a5,-40(s0)
    800045e2:	6bbc                	ld	a5,80(a5)
    800045e4:	00c7d713          	srli	a4,a5,0xc
    800045e8:	57fd                	li	a5,-1
    800045ea:	17fe                	slli	a5,a5,0x3f
    800045ec:	8fd9                	or	a5,a5,a4
    800045ee:	fcf43423          	sd	a5,-56(s0)

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    800045f2:	00006717          	auipc	a4,0x6
    800045f6:	a9e70713          	addi	a4,a4,-1378 # 8000a090 <userret>
    800045fa:	00006797          	auipc	a5,0x6
    800045fe:	a0678793          	addi	a5,a5,-1530 # 8000a000 <_trampoline>
    80004602:	8f1d                	sub	a4,a4,a5
    80004604:	040007b7          	lui	a5,0x4000
    80004608:	17fd                	addi	a5,a5,-1
    8000460a:	07b2                	slli	a5,a5,0xc
    8000460c:	97ba                	add	a5,a5,a4
    8000460e:	fcf43023          	sd	a5,-64(s0)
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80004612:	fc043703          	ld	a4,-64(s0)
    80004616:	fc843583          	ld	a1,-56(s0)
    8000461a:	020007b7          	lui	a5,0x2000
    8000461e:	17fd                	addi	a5,a5,-1
    80004620:	00d79513          	slli	a0,a5,0xd
    80004624:	9702                	jalr	a4
}
    80004626:	0001                	nop
    80004628:	70e2                	ld	ra,56(sp)
    8000462a:	7442                	ld	s0,48(sp)
    8000462c:	74a2                	ld	s1,40(sp)
    8000462e:	6121                	addi	sp,sp,64
    80004630:	8082                	ret

0000000080004632 <kerneltrap>:

// interrupts and exceptions from kernel code go here via kernelvec,
// on whatever the current kernel stack is.
void 
kerneltrap()
{
    80004632:	7139                	addi	sp,sp,-64
    80004634:	fc06                	sd	ra,56(sp)
    80004636:	f822                	sd	s0,48(sp)
    80004638:	f426                	sd	s1,40(sp)
    8000463a:	0080                	addi	s0,sp,64
  int which_dev = 0;
    8000463c:	fc042e23          	sw	zero,-36(s0)
  uint64 sepc = r_sepc();
    80004640:	00000097          	auipc	ra,0x0
    80004644:	c20080e7          	jalr	-992(ra) # 80004260 <r_sepc>
    80004648:	fca43823          	sd	a0,-48(s0)
  uint64 sstatus = r_sstatus();
    8000464c:	00000097          	auipc	ra,0x0
    80004650:	b92080e7          	jalr	-1134(ra) # 800041de <r_sstatus>
    80004654:	fca43423          	sd	a0,-56(s0)
  uint64 scause = r_scause();
    80004658:	00000097          	auipc	ra,0x0
    8000465c:	c56080e7          	jalr	-938(ra) # 800042ae <r_scause>
    80004660:	fca43023          	sd	a0,-64(s0)
  
  if((sstatus & SSTATUS_SPP) == 0)
    80004664:	fc843783          	ld	a5,-56(s0)
    80004668:	1007f793          	andi	a5,a5,256
    8000466c:	eb89                	bnez	a5,8000467e <kerneltrap+0x4c>
    panic("kerneltrap: not from supervisor mode");
    8000466e:	00007517          	auipc	a0,0x7
    80004672:	dea50513          	addi	a0,a0,-534 # 8000b458 <etext+0x458>
    80004676:	ffffc097          	auipc	ra,0xffffc
    8000467a:	604080e7          	jalr	1540(ra) # 80000c7a <panic>
  if(intr_get() != 0)
    8000467e:	00000097          	auipc	ra,0x0
    80004682:	cb6080e7          	jalr	-842(ra) # 80004334 <intr_get>
    80004686:	87aa                	mv	a5,a0
    80004688:	cb89                	beqz	a5,8000469a <kerneltrap+0x68>
    panic("kerneltrap: interrupts enabled");
    8000468a:	00007517          	auipc	a0,0x7
    8000468e:	df650513          	addi	a0,a0,-522 # 8000b480 <etext+0x480>
    80004692:	ffffc097          	auipc	ra,0xffffc
    80004696:	5e8080e7          	jalr	1512(ra) # 80000c7a <panic>

  if((which_dev = devintr()) == 0){
    8000469a:	00000097          	auipc	ra,0x0
    8000469e:	118080e7          	jalr	280(ra) # 800047b2 <devintr>
    800046a2:	87aa                	mv	a5,a0
    800046a4:	fcf42e23          	sw	a5,-36(s0)
    800046a8:	fdc42783          	lw	a5,-36(s0)
    800046ac:	2781                	sext.w	a5,a5
    800046ae:	e7b9                	bnez	a5,800046fc <kerneltrap+0xca>
    printf("scause %p\n", scause);
    800046b0:	fc043583          	ld	a1,-64(s0)
    800046b4:	00007517          	auipc	a0,0x7
    800046b8:	dec50513          	addi	a0,a0,-532 # 8000b4a0 <etext+0x4a0>
    800046bc:	ffffc097          	auipc	ra,0xffffc
    800046c0:	368080e7          	jalr	872(ra) # 80000a24 <printf>
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    800046c4:	00000097          	auipc	ra,0x0
    800046c8:	b9c080e7          	jalr	-1124(ra) # 80004260 <r_sepc>
    800046cc:	84aa                	mv	s1,a0
    800046ce:	00000097          	auipc	ra,0x0
    800046d2:	bfa080e7          	jalr	-1030(ra) # 800042c8 <r_stval>
    800046d6:	87aa                	mv	a5,a0
    800046d8:	863e                	mv	a2,a5
    800046da:	85a6                	mv	a1,s1
    800046dc:	00007517          	auipc	a0,0x7
    800046e0:	dd450513          	addi	a0,a0,-556 # 8000b4b0 <etext+0x4b0>
    800046e4:	ffffc097          	auipc	ra,0xffffc
    800046e8:	340080e7          	jalr	832(ra) # 80000a24 <printf>
    panic("kerneltrap");
    800046ec:	00007517          	auipc	a0,0x7
    800046f0:	ddc50513          	addi	a0,a0,-548 # 8000b4c8 <etext+0x4c8>
    800046f4:	ffffc097          	auipc	ra,0xffffc
    800046f8:	586080e7          	jalr	1414(ra) # 80000c7a <panic>
  }

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    800046fc:	fdc42783          	lw	a5,-36(s0)
    80004700:	0007871b          	sext.w	a4,a5
    80004704:	4789                	li	a5,2
    80004706:	02f71663          	bne	a4,a5,80004732 <kerneltrap+0x100>
    8000470a:	ffffe097          	auipc	ra,0xffffe
    8000470e:	30e080e7          	jalr	782(ra) # 80002a18 <myproc>
    80004712:	87aa                	mv	a5,a0
    80004714:	cf99                	beqz	a5,80004732 <kerneltrap+0x100>
    80004716:	ffffe097          	auipc	ra,0xffffe
    8000471a:	302080e7          	jalr	770(ra) # 80002a18 <myproc>
    8000471e:	87aa                	mv	a5,a0
    80004720:	4f9c                	lw	a5,24(a5)
    80004722:	873e                	mv	a4,a5
    80004724:	4791                	li	a5,4
    80004726:	00f71663          	bne	a4,a5,80004732 <kerneltrap+0x100>
    yield();
    8000472a:	fffff097          	auipc	ra,0xfffff
    8000472e:	130080e7          	jalr	304(ra) # 8000385a <yield>

  // the yield() may have caused some traps to occur,
  // so restore trap registers for use by kernelvec.S's sepc instruction.
  w_sepc(sepc);
    80004732:	fd043503          	ld	a0,-48(s0)
    80004736:	00000097          	auipc	ra,0x0
    8000473a:	b10080e7          	jalr	-1264(ra) # 80004246 <w_sepc>
  w_sstatus(sstatus);
    8000473e:	fc843503          	ld	a0,-56(s0)
    80004742:	00000097          	auipc	ra,0x0
    80004746:	ab6080e7          	jalr	-1354(ra) # 800041f8 <w_sstatus>
}
    8000474a:	0001                	nop
    8000474c:	70e2                	ld	ra,56(sp)
    8000474e:	7442                	ld	s0,48(sp)
    80004750:	74a2                	ld	s1,40(sp)
    80004752:	6121                	addi	sp,sp,64
    80004754:	8082                	ret

0000000080004756 <clockintr>:

void
clockintr()
{
    80004756:	1141                	addi	sp,sp,-16
    80004758:	e406                	sd	ra,8(sp)
    8000475a:	e022                	sd	s0,0(sp)
    8000475c:	0800                	addi	s0,sp,16
  acquire(&tickslock);
    8000475e:	00496517          	auipc	a0,0x496
    80004762:	36a50513          	addi	a0,a0,874 # 8049aac8 <tickslock>
    80004766:	ffffd097          	auipc	ra,0xffffd
    8000476a:	b04080e7          	jalr	-1276(ra) # 8000126a <acquire>
  ticks++;
    8000476e:	00008797          	auipc	a5,0x8
    80004772:	8ba78793          	addi	a5,a5,-1862 # 8000c028 <ticks>
    80004776:	439c                	lw	a5,0(a5)
    80004778:	2785                	addiw	a5,a5,1
    8000477a:	0007871b          	sext.w	a4,a5
    8000477e:	00008797          	auipc	a5,0x8
    80004782:	8aa78793          	addi	a5,a5,-1878 # 8000c028 <ticks>
    80004786:	c398                	sw	a4,0(a5)
  wakeup(&ticks);
    80004788:	00008517          	auipc	a0,0x8
    8000478c:	8a050513          	addi	a0,a0,-1888 # 8000c028 <ticks>
    80004790:	fffff097          	auipc	ra,0xfffff
    80004794:	1e0080e7          	jalr	480(ra) # 80003970 <wakeup>
  release(&tickslock);
    80004798:	00496517          	auipc	a0,0x496
    8000479c:	33050513          	addi	a0,a0,816 # 8049aac8 <tickslock>
    800047a0:	ffffd097          	auipc	ra,0xffffd
    800047a4:	b2e080e7          	jalr	-1234(ra) # 800012ce <release>
}
    800047a8:	0001                	nop
    800047aa:	60a2                	ld	ra,8(sp)
    800047ac:	6402                	ld	s0,0(sp)
    800047ae:	0141                	addi	sp,sp,16
    800047b0:	8082                	ret

00000000800047b2 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    800047b2:	1101                	addi	sp,sp,-32
    800047b4:	ec06                	sd	ra,24(sp)
    800047b6:	e822                	sd	s0,16(sp)
    800047b8:	1000                	addi	s0,sp,32
  uint64 scause = r_scause();
    800047ba:	00000097          	auipc	ra,0x0
    800047be:	af4080e7          	jalr	-1292(ra) # 800042ae <r_scause>
    800047c2:	fea43423          	sd	a0,-24(s0)

  if((scause & 0x8000000000000000L) &&
    800047c6:	fe843783          	ld	a5,-24(s0)
    800047ca:	0807d463          	bgez	a5,80004852 <devintr+0xa0>
     (scause & 0xff) == 9){
    800047ce:	fe843783          	ld	a5,-24(s0)
    800047d2:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    800047d6:	47a5                	li	a5,9
    800047d8:	06f71d63          	bne	a4,a5,80004852 <devintr+0xa0>
    // this is a supervisor external interrupt, via PLIC.

    // irq indicates which device interrupted.
    int irq = plic_claim();
    800047dc:	00005097          	auipc	ra,0x5
    800047e0:	b96080e7          	jalr	-1130(ra) # 80009372 <plic_claim>
    800047e4:	87aa                	mv	a5,a0
    800047e6:	fef42223          	sw	a5,-28(s0)

    if(irq == UART0_IRQ){
    800047ea:	fe442783          	lw	a5,-28(s0)
    800047ee:	0007871b          	sext.w	a4,a5
    800047f2:	47a9                	li	a5,10
    800047f4:	00f71763          	bne	a4,a5,80004802 <devintr+0x50>
      uartintr();
    800047f8:	ffffc097          	auipc	ra,0xffffc
    800047fc:	77a080e7          	jalr	1914(ra) # 80000f72 <uartintr>
    80004800:	a825                	j	80004838 <devintr+0x86>
    } else if(irq == VIRTIO0_IRQ){
    80004802:	fe442783          	lw	a5,-28(s0)
    80004806:	0007871b          	sext.w	a4,a5
    8000480a:	4785                	li	a5,1
    8000480c:	00f71763          	bne	a4,a5,8000481a <devintr+0x68>
      virtio_disk_intr();
    80004810:	00005097          	auipc	ra,0x5
    80004814:	478080e7          	jalr	1144(ra) # 80009c88 <virtio_disk_intr>
    80004818:	a005                	j	80004838 <devintr+0x86>
    } else if(irq){
    8000481a:	fe442783          	lw	a5,-28(s0)
    8000481e:	2781                	sext.w	a5,a5
    80004820:	cf81                	beqz	a5,80004838 <devintr+0x86>
      printf("unexpected interrupt irq=%d\n", irq);
    80004822:	fe442783          	lw	a5,-28(s0)
    80004826:	85be                	mv	a1,a5
    80004828:	00007517          	auipc	a0,0x7
    8000482c:	cb050513          	addi	a0,a0,-848 # 8000b4d8 <etext+0x4d8>
    80004830:	ffffc097          	auipc	ra,0xffffc
    80004834:	1f4080e7          	jalr	500(ra) # 80000a24 <printf>
    }

    // the PLIC allows each device to raise at most one
    // interrupt at a time; tell the PLIC the device is
    // now allowed to interrupt again.
    if(irq)
    80004838:	fe442783          	lw	a5,-28(s0)
    8000483c:	2781                	sext.w	a5,a5
    8000483e:	cb81                	beqz	a5,8000484e <devintr+0x9c>
      plic_complete(irq);
    80004840:	fe442783          	lw	a5,-28(s0)
    80004844:	853e                	mv	a0,a5
    80004846:	00005097          	auipc	ra,0x5
    8000484a:	b6a080e7          	jalr	-1174(ra) # 800093b0 <plic_complete>

    return 1;
    8000484e:	4785                	li	a5,1
    80004850:	a081                	j	80004890 <devintr+0xde>
  } else if(scause == 0x8000000000000001L){
    80004852:	fe843703          	ld	a4,-24(s0)
    80004856:	57fd                	li	a5,-1
    80004858:	17fe                	slli	a5,a5,0x3f
    8000485a:	0785                	addi	a5,a5,1
    8000485c:	02f71963          	bne	a4,a5,8000488e <devintr+0xdc>
    // software interrupt from a machine-mode timer interrupt,
    // forwarded by timervec in kernelvec.S.

    if(cpuid() == 0){
    80004860:	ffffe097          	auipc	ra,0xffffe
    80004864:	15a080e7          	jalr	346(ra) # 800029ba <cpuid>
    80004868:	87aa                	mv	a5,a0
    8000486a:	e789                	bnez	a5,80004874 <devintr+0xc2>
      clockintr();
    8000486c:	00000097          	auipc	ra,0x0
    80004870:	eea080e7          	jalr	-278(ra) # 80004756 <clockintr>
    }
    
    // acknowledge the software interrupt by clearing
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);
    80004874:	00000097          	auipc	ra,0x0
    80004878:	99e080e7          	jalr	-1634(ra) # 80004212 <r_sip>
    8000487c:	87aa                	mv	a5,a0
    8000487e:	9bf5                	andi	a5,a5,-3
    80004880:	853e                	mv	a0,a5
    80004882:	00000097          	auipc	ra,0x0
    80004886:	9aa080e7          	jalr	-1622(ra) # 8000422c <w_sip>

    return 2;
    8000488a:	4789                	li	a5,2
    8000488c:	a011                	j	80004890 <devintr+0xde>
  } else {
    return 0;
    8000488e:	4781                	li	a5,0
  }
}
    80004890:	853e                	mv	a0,a5
    80004892:	60e2                	ld	ra,24(sp)
    80004894:	6442                	ld	s0,16(sp)
    80004896:	6105                	addi	sp,sp,32
    80004898:	8082                	ret

000000008000489a <fetchaddr>:
#include "defs.h"

// Fetch the uint64 at addr from the current process.
int
fetchaddr(uint64 addr, uint64 *ip)
{
    8000489a:	7179                	addi	sp,sp,-48
    8000489c:	f406                	sd	ra,40(sp)
    8000489e:	f022                	sd	s0,32(sp)
    800048a0:	1800                	addi	s0,sp,48
    800048a2:	fca43c23          	sd	a0,-40(s0)
    800048a6:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    800048aa:	ffffe097          	auipc	ra,0xffffe
    800048ae:	16e080e7          	jalr	366(ra) # 80002a18 <myproc>
    800048b2:	fea43423          	sd	a0,-24(s0)
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    800048b6:	fe843783          	ld	a5,-24(s0)
    800048ba:	67bc                	ld	a5,72(a5)
    800048bc:	fd843703          	ld	a4,-40(s0)
    800048c0:	00f77b63          	bgeu	a4,a5,800048d6 <fetchaddr+0x3c>
    800048c4:	fd843783          	ld	a5,-40(s0)
    800048c8:	00878713          	addi	a4,a5,8
    800048cc:	fe843783          	ld	a5,-24(s0)
    800048d0:	67bc                	ld	a5,72(a5)
    800048d2:	00e7f463          	bgeu	a5,a4,800048da <fetchaddr+0x40>
    return -1;
    800048d6:	57fd                	li	a5,-1
    800048d8:	a01d                	j	800048fe <fetchaddr+0x64>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    800048da:	fe843783          	ld	a5,-24(s0)
    800048de:	6bbc                	ld	a5,80(a5)
    800048e0:	46a1                	li	a3,8
    800048e2:	fd843603          	ld	a2,-40(s0)
    800048e6:	fd043583          	ld	a1,-48(s0)
    800048ea:	853e                	mv	a0,a5
    800048ec:	ffffe097          	auipc	ra,0xffffe
    800048f0:	ba8080e7          	jalr	-1112(ra) # 80002494 <copyin>
    800048f4:	87aa                	mv	a5,a0
    800048f6:	c399                	beqz	a5,800048fc <fetchaddr+0x62>
    return -1;
    800048f8:	57fd                	li	a5,-1
    800048fa:	a011                	j	800048fe <fetchaddr+0x64>
  return 0;
    800048fc:	4781                	li	a5,0
}
    800048fe:	853e                	mv	a0,a5
    80004900:	70a2                	ld	ra,40(sp)
    80004902:	7402                	ld	s0,32(sp)
    80004904:	6145                	addi	sp,sp,48
    80004906:	8082                	ret

0000000080004908 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Returns length of string, not including nul, or -1 for error.
int
fetchstr(uint64 addr, char *buf, int max)
{
    80004908:	7139                	addi	sp,sp,-64
    8000490a:	fc06                	sd	ra,56(sp)
    8000490c:	f822                	sd	s0,48(sp)
    8000490e:	0080                	addi	s0,sp,64
    80004910:	fca43c23          	sd	a0,-40(s0)
    80004914:	fcb43823          	sd	a1,-48(s0)
    80004918:	87b2                	mv	a5,a2
    8000491a:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    8000491e:	ffffe097          	auipc	ra,0xffffe
    80004922:	0fa080e7          	jalr	250(ra) # 80002a18 <myproc>
    80004926:	fea43423          	sd	a0,-24(s0)
  int err = copyinstr(p->pagetable, buf, addr, max);
    8000492a:	fe843783          	ld	a5,-24(s0)
    8000492e:	6bbc                	ld	a5,80(a5)
    80004930:	fcc42703          	lw	a4,-52(s0)
    80004934:	86ba                	mv	a3,a4
    80004936:	fd843603          	ld	a2,-40(s0)
    8000493a:	fd043583          	ld	a1,-48(s0)
    8000493e:	853e                	mv	a0,a5
    80004940:	ffffe097          	auipc	ra,0xffffe
    80004944:	c22080e7          	jalr	-990(ra) # 80002562 <copyinstr>
    80004948:	87aa                	mv	a5,a0
    8000494a:	fef42223          	sw	a5,-28(s0)
  if(err < 0)
    8000494e:	fe442783          	lw	a5,-28(s0)
    80004952:	2781                	sext.w	a5,a5
    80004954:	0007d563          	bgez	a5,8000495e <fetchstr+0x56>
    return err;
    80004958:	fe442783          	lw	a5,-28(s0)
    8000495c:	a801                	j	8000496c <fetchstr+0x64>
  return strlen(buf);
    8000495e:	fd043503          	ld	a0,-48(s0)
    80004962:	ffffd097          	auipc	ra,0xffffd
    80004966:	e5c080e7          	jalr	-420(ra) # 800017be <strlen>
    8000496a:	87aa                	mv	a5,a0
}
    8000496c:	853e                	mv	a0,a5
    8000496e:	70e2                	ld	ra,56(sp)
    80004970:	7442                	ld	s0,48(sp)
    80004972:	6121                	addi	sp,sp,64
    80004974:	8082                	ret

0000000080004976 <argraw>:

static uint64
argraw(int n)
{
    80004976:	7179                	addi	sp,sp,-48
    80004978:	f406                	sd	ra,40(sp)
    8000497a:	f022                	sd	s0,32(sp)
    8000497c:	1800                	addi	s0,sp,48
    8000497e:	87aa                	mv	a5,a0
    80004980:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80004984:	ffffe097          	auipc	ra,0xffffe
    80004988:	094080e7          	jalr	148(ra) # 80002a18 <myproc>
    8000498c:	fea43423          	sd	a0,-24(s0)
  switch (n) {
    80004990:	fdc42783          	lw	a5,-36(s0)
    80004994:	0007871b          	sext.w	a4,a5
    80004998:	4795                	li	a5,5
    8000499a:	06e7e263          	bltu	a5,a4,800049fe <argraw+0x88>
    8000499e:	fdc46783          	lwu	a5,-36(s0)
    800049a2:	00279713          	slli	a4,a5,0x2
    800049a6:	00007797          	auipc	a5,0x7
    800049aa:	b5a78793          	addi	a5,a5,-1190 # 8000b500 <etext+0x500>
    800049ae:	97ba                	add	a5,a5,a4
    800049b0:	439c                	lw	a5,0(a5)
    800049b2:	0007871b          	sext.w	a4,a5
    800049b6:	00007797          	auipc	a5,0x7
    800049ba:	b4a78793          	addi	a5,a5,-1206 # 8000b500 <etext+0x500>
    800049be:	97ba                	add	a5,a5,a4
    800049c0:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    800049c2:	fe843783          	ld	a5,-24(s0)
    800049c6:	73bc                	ld	a5,96(a5)
    800049c8:	7bbc                	ld	a5,112(a5)
    800049ca:	a091                	j	80004a0e <argraw+0x98>
  case 1:
    return p->trapframe->a1;
    800049cc:	fe843783          	ld	a5,-24(s0)
    800049d0:	73bc                	ld	a5,96(a5)
    800049d2:	7fbc                	ld	a5,120(a5)
    800049d4:	a82d                	j	80004a0e <argraw+0x98>
  case 2:
    return p->trapframe->a2;
    800049d6:	fe843783          	ld	a5,-24(s0)
    800049da:	73bc                	ld	a5,96(a5)
    800049dc:	63dc                	ld	a5,128(a5)
    800049de:	a805                	j	80004a0e <argraw+0x98>
  case 3:
    return p->trapframe->a3;
    800049e0:	fe843783          	ld	a5,-24(s0)
    800049e4:	73bc                	ld	a5,96(a5)
    800049e6:	67dc                	ld	a5,136(a5)
    800049e8:	a01d                	j	80004a0e <argraw+0x98>
  case 4:
    return p->trapframe->a4;
    800049ea:	fe843783          	ld	a5,-24(s0)
    800049ee:	73bc                	ld	a5,96(a5)
    800049f0:	6bdc                	ld	a5,144(a5)
    800049f2:	a831                	j	80004a0e <argraw+0x98>
  case 5:
    return p->trapframe->a5;
    800049f4:	fe843783          	ld	a5,-24(s0)
    800049f8:	73bc                	ld	a5,96(a5)
    800049fa:	6fdc                	ld	a5,152(a5)
    800049fc:	a809                	j	80004a0e <argraw+0x98>
  }
  panic("argraw");
    800049fe:	00007517          	auipc	a0,0x7
    80004a02:	afa50513          	addi	a0,a0,-1286 # 8000b4f8 <etext+0x4f8>
    80004a06:	ffffc097          	auipc	ra,0xffffc
    80004a0a:	274080e7          	jalr	628(ra) # 80000c7a <panic>
  return -1;
}
    80004a0e:	853e                	mv	a0,a5
    80004a10:	70a2                	ld	ra,40(sp)
    80004a12:	7402                	ld	s0,32(sp)
    80004a14:	6145                	addi	sp,sp,48
    80004a16:	8082                	ret

0000000080004a18 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80004a18:	1101                	addi	sp,sp,-32
    80004a1a:	ec06                	sd	ra,24(sp)
    80004a1c:	e822                	sd	s0,16(sp)
    80004a1e:	1000                	addi	s0,sp,32
    80004a20:	87aa                	mv	a5,a0
    80004a22:	feb43023          	sd	a1,-32(s0)
    80004a26:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    80004a2a:	fec42783          	lw	a5,-20(s0)
    80004a2e:	853e                	mv	a0,a5
    80004a30:	00000097          	auipc	ra,0x0
    80004a34:	f46080e7          	jalr	-186(ra) # 80004976 <argraw>
    80004a38:	87aa                	mv	a5,a0
    80004a3a:	0007871b          	sext.w	a4,a5
    80004a3e:	fe043783          	ld	a5,-32(s0)
    80004a42:	c398                	sw	a4,0(a5)
  return 0;
    80004a44:	4781                	li	a5,0
}
    80004a46:	853e                	mv	a0,a5
    80004a48:	60e2                	ld	ra,24(sp)
    80004a4a:	6442                	ld	s0,16(sp)
    80004a4c:	6105                	addi	sp,sp,32
    80004a4e:	8082                	ret

0000000080004a50 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80004a50:	1101                	addi	sp,sp,-32
    80004a52:	ec06                	sd	ra,24(sp)
    80004a54:	e822                	sd	s0,16(sp)
    80004a56:	1000                	addi	s0,sp,32
    80004a58:	87aa                	mv	a5,a0
    80004a5a:	feb43023          	sd	a1,-32(s0)
    80004a5e:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    80004a62:	fec42783          	lw	a5,-20(s0)
    80004a66:	853e                	mv	a0,a5
    80004a68:	00000097          	auipc	ra,0x0
    80004a6c:	f0e080e7          	jalr	-242(ra) # 80004976 <argraw>
    80004a70:	872a                	mv	a4,a0
    80004a72:	fe043783          	ld	a5,-32(s0)
    80004a76:	e398                	sd	a4,0(a5)
  return 0;
    80004a78:	4781                	li	a5,0
}
    80004a7a:	853e                	mv	a0,a5
    80004a7c:	60e2                	ld	ra,24(sp)
    80004a7e:	6442                	ld	s0,16(sp)
    80004a80:	6105                	addi	sp,sp,32
    80004a82:	8082                	ret

0000000080004a84 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80004a84:	7179                	addi	sp,sp,-48
    80004a86:	f406                	sd	ra,40(sp)
    80004a88:	f022                	sd	s0,32(sp)
    80004a8a:	1800                	addi	s0,sp,48
    80004a8c:	87aa                	mv	a5,a0
    80004a8e:	fcb43823          	sd	a1,-48(s0)
    80004a92:	8732                	mv	a4,a2
    80004a94:	fcf42e23          	sw	a5,-36(s0)
    80004a98:	87ba                	mv	a5,a4
    80004a9a:	fcf42c23          	sw	a5,-40(s0)
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    80004a9e:	fe840713          	addi	a4,s0,-24
    80004aa2:	fdc42783          	lw	a5,-36(s0)
    80004aa6:	85ba                	mv	a1,a4
    80004aa8:	853e                	mv	a0,a5
    80004aaa:	00000097          	auipc	ra,0x0
    80004aae:	fa6080e7          	jalr	-90(ra) # 80004a50 <argaddr>
    80004ab2:	87aa                	mv	a5,a0
    80004ab4:	0007d463          	bgez	a5,80004abc <argstr+0x38>
    return -1;
    80004ab8:	57fd                	li	a5,-1
    80004aba:	a831                	j	80004ad6 <argstr+0x52>
  return fetchstr(addr, buf, max);
    80004abc:	fe843783          	ld	a5,-24(s0)
    80004ac0:	fd842703          	lw	a4,-40(s0)
    80004ac4:	863a                	mv	a2,a4
    80004ac6:	fd043583          	ld	a1,-48(s0)
    80004aca:	853e                	mv	a0,a5
    80004acc:	00000097          	auipc	ra,0x0
    80004ad0:	e3c080e7          	jalr	-452(ra) # 80004908 <fetchstr>
    80004ad4:	87aa                	mv	a5,a0
}
    80004ad6:	853e                	mv	a0,a5
    80004ad8:	70a2                	ld	ra,40(sp)
    80004ada:	7402                	ld	s0,32(sp)
    80004adc:	6145                	addi	sp,sp,48
    80004ade:	8082                	ret

0000000080004ae0 <syscall>:
[SYS_join]    sys_join
};

void
syscall(void)
{
    80004ae0:	7179                	addi	sp,sp,-48
    80004ae2:	f406                	sd	ra,40(sp)
    80004ae4:	f022                	sd	s0,32(sp)
    80004ae6:	ec26                	sd	s1,24(sp)
    80004ae8:	1800                	addi	s0,sp,48
  int num;
  struct proc *p = myproc();
    80004aea:	ffffe097          	auipc	ra,0xffffe
    80004aee:	f2e080e7          	jalr	-210(ra) # 80002a18 <myproc>
    80004af2:	fca43c23          	sd	a0,-40(s0)

  num = p->trapframe->a7;
    80004af6:	fd843783          	ld	a5,-40(s0)
    80004afa:	73bc                	ld	a5,96(a5)
    80004afc:	77dc                	ld	a5,168(a5)
    80004afe:	fcf42a23          	sw	a5,-44(s0)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80004b02:	fd442783          	lw	a5,-44(s0)
    80004b06:	2781                	sext.w	a5,a5
    80004b08:	04f05263          	blez	a5,80004b4c <syscall+0x6c>
    80004b0c:	fd442783          	lw	a5,-44(s0)
    80004b10:	873e                	mv	a4,a5
    80004b12:	47dd                	li	a5,23
    80004b14:	02e7ec63          	bltu	a5,a4,80004b4c <syscall+0x6c>
    80004b18:	00007717          	auipc	a4,0x7
    80004b1c:	e4870713          	addi	a4,a4,-440 # 8000b960 <syscalls>
    80004b20:	fd442783          	lw	a5,-44(s0)
    80004b24:	078e                	slli	a5,a5,0x3
    80004b26:	97ba                	add	a5,a5,a4
    80004b28:	639c                	ld	a5,0(a5)
    80004b2a:	c38d                	beqz	a5,80004b4c <syscall+0x6c>
    p->trapframe->a0 = syscalls[num]();
    80004b2c:	00007717          	auipc	a4,0x7
    80004b30:	e3470713          	addi	a4,a4,-460 # 8000b960 <syscalls>
    80004b34:	fd442783          	lw	a5,-44(s0)
    80004b38:	078e                	slli	a5,a5,0x3
    80004b3a:	97ba                	add	a5,a5,a4
    80004b3c:	6398                	ld	a4,0(a5)
    80004b3e:	fd843783          	ld	a5,-40(s0)
    80004b42:	73a4                	ld	s1,96(a5)
    80004b44:	9702                	jalr	a4
    80004b46:	87aa                	mv	a5,a0
    80004b48:	f8bc                	sd	a5,112(s1)
    80004b4a:	a815                	j	80004b7e <syscall+0x9e>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80004b4c:	fd843783          	ld	a5,-40(s0)
    80004b50:	5b98                	lw	a4,48(a5)
            p->pid, p->name, num);
    80004b52:	fd843783          	ld	a5,-40(s0)
    80004b56:	16878793          	addi	a5,a5,360
    printf("%d %s: unknown sys call %d\n",
    80004b5a:	fd442683          	lw	a3,-44(s0)
    80004b5e:	863e                	mv	a2,a5
    80004b60:	85ba                	mv	a1,a4
    80004b62:	00007517          	auipc	a0,0x7
    80004b66:	9b650513          	addi	a0,a0,-1610 # 8000b518 <etext+0x518>
    80004b6a:	ffffc097          	auipc	ra,0xffffc
    80004b6e:	eba080e7          	jalr	-326(ra) # 80000a24 <printf>
    p->trapframe->a0 = -1;
    80004b72:	fd843783          	ld	a5,-40(s0)
    80004b76:	73bc                	ld	a5,96(a5)
    80004b78:	577d                	li	a4,-1
    80004b7a:	fbb8                	sd	a4,112(a5)
  }
}
    80004b7c:	0001                	nop
    80004b7e:	0001                	nop
    80004b80:	70a2                	ld	ra,40(sp)
    80004b82:	7402                	ld	s0,32(sp)
    80004b84:	64e2                	ld	s1,24(sp)
    80004b86:	6145                	addi	sp,sp,48
    80004b88:	8082                	ret

0000000080004b8a <sys_clone>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_clone (void)
{
    80004b8a:	7139                	addi	sp,sp,-64
    80004b8c:	fc06                	sd	ra,56(sp)
    80004b8e:	f822                	sd	s0,48(sp)
    80004b90:	0080                	addi	s0,sp,64
  uint64 stack;
  uint64 arg;
  uint64 fcn;

   //obtenemos puntero función
   if(argaddr(0, &fcn) < 0){
    80004b92:	fc840793          	addi	a5,s0,-56
    80004b96:	85be                	mv	a1,a5
    80004b98:	4501                	li	a0,0
    80004b9a:	00000097          	auipc	ra,0x0
    80004b9e:	eb6080e7          	jalr	-330(ra) # 80004a50 <argaddr>
    80004ba2:	87aa                	mv	a5,a0
    80004ba4:	0007d463          	bgez	a5,80004bac <sys_clone+0x22>
     return -1;
    80004ba8:	57fd                	li	a5,-1
    80004baa:	a071                	j	80004c36 <sys_clone+0xac>
   }

   //obtenemos puntero a argumento de función
   if(argaddr(1, &arg) < 0){
    80004bac:	fd040793          	addi	a5,s0,-48
    80004bb0:	85be                	mv	a1,a5
    80004bb2:	4505                	li	a0,1
    80004bb4:	00000097          	auipc	ra,0x0
    80004bb8:	e9c080e7          	jalr	-356(ra) # 80004a50 <argaddr>
    80004bbc:	87aa                	mv	a5,a0
    80004bbe:	0007d463          	bgez	a5,80004bc6 <sys_clone+0x3c>
     return -1;
    80004bc2:	57fd                	li	a5,-1
    80004bc4:	a88d                	j	80004c36 <sys_clone+0xac>
   }

   //obtenemos putnero a stack de usuario
   if(argaddr(2, &stack) < 0){
    80004bc6:	fd840793          	addi	a5,s0,-40
    80004bca:	85be                	mv	a1,a5
    80004bcc:	4509                	li	a0,2
    80004bce:	00000097          	auipc	ra,0x0
    80004bd2:	e82080e7          	jalr	-382(ra) # 80004a50 <argaddr>
    80004bd6:	87aa                	mv	a5,a0
    80004bd8:	0007d463          	bgez	a5,80004be0 <sys_clone+0x56>
     return -1;
    80004bdc:	57fd                	li	a5,-1
    80004bde:	a8a1                	j	80004c36 <sys_clone+0xac>
   }

  struct proc *p = myproc();
    80004be0:	ffffe097          	auipc	ra,0xffffe
    80004be4:	e38080e7          	jalr	-456(ra) # 80002a18 <myproc>
    80004be8:	fea43423          	sd	a0,-24(s0)
  uint64 sz = p->sz;
    80004bec:	fe843783          	ld	a5,-24(s0)
    80004bf0:	67bc                	ld	a5,72(a5)
    80004bf2:	fef43023          	sd	a5,-32(s0)

   //comprobamos que stack este alineado a pagina
   if ((stack % PGSIZE) != 0 || ((sz - stack) < PGSIZE)){
    80004bf6:	fd843703          	ld	a4,-40(s0)
    80004bfa:	6785                	lui	a5,0x1
    80004bfc:	17fd                	addi	a5,a5,-1
    80004bfe:	8ff9                	and	a5,a5,a4
    80004c00:	eb89                	bnez	a5,80004c12 <sys_clone+0x88>
    80004c02:	fd843783          	ld	a5,-40(s0)
    80004c06:	fe043703          	ld	a4,-32(s0)
    80004c0a:	8f1d                	sub	a4,a4,a5
    80004c0c:	6785                	lui	a5,0x1
    80004c0e:	00f77463          	bgeu	a4,a5,80004c16 <sys_clone+0x8c>
     return -1;
    80004c12:	57fd                	li	a5,-1
    80004c14:	a00d                	j	80004c36 <sys_clone+0xac>
   }

  return clone((void *)fcn, (void *)arg, (void *)stack);
    80004c16:	fc843783          	ld	a5,-56(s0)
    80004c1a:	873e                	mv	a4,a5
    80004c1c:	fd043783          	ld	a5,-48(s0)
    80004c20:	86be                	mv	a3,a5
    80004c22:	fd843783          	ld	a5,-40(s0)
    80004c26:	863e                	mv	a2,a5
    80004c28:	85b6                	mv	a1,a3
    80004c2a:	853a                	mv	a0,a4
    80004c2c:	fffff097          	auipc	ra,0xfffff
    80004c30:	04e080e7          	jalr	78(ra) # 80003c7a <clone>
    80004c34:	87aa                	mv	a5,a0
}
    80004c36:	853e                	mv	a0,a5
    80004c38:	70e2                	ld	ra,56(sp)
    80004c3a:	7442                	ld	s0,48(sp)
    80004c3c:	6121                	addi	sp,sp,64
    80004c3e:	8082                	ret

0000000080004c40 <sys_join>:

uint64
sys_join (void)
{
    80004c40:	1101                	addi	sp,sp,-32
    80004c42:	ec06                	sd	ra,24(sp)
    80004c44:	e822                	sd	s0,16(sp)
    80004c46:	1000                	addi	s0,sp,32
  uint64 stack;
  if(argaddr(0, &stack) < 0){
    80004c48:	fe840793          	addi	a5,s0,-24
    80004c4c:	85be                	mv	a1,a5
    80004c4e:	4501                	li	a0,0
    80004c50:	00000097          	auipc	ra,0x0
    80004c54:	e00080e7          	jalr	-512(ra) # 80004a50 <argaddr>
    80004c58:	87aa                	mv	a5,a0
    80004c5a:	0007dc63          	bgez	a5,80004c72 <sys_join+0x32>
     printf ("SYSPROC: argumento no valido\n");
    80004c5e:	00007517          	auipc	a0,0x7
    80004c62:	8da50513          	addi	a0,a0,-1830 # 8000b538 <etext+0x538>
    80004c66:	ffffc097          	auipc	ra,0xffffc
    80004c6a:	dbe080e7          	jalr	-578(ra) # 80000a24 <printf>
     return -1;
    80004c6e:	57fd                	li	a5,-1
    80004c70:	a091                	j	80004cb4 <sys_join+0x74>
  }

  printf ("SYSPROC: lo que vale stack es: %d\n", stack);
    80004c72:	fe843783          	ld	a5,-24(s0)
    80004c76:	85be                	mv	a1,a5
    80004c78:	00007517          	auipc	a0,0x7
    80004c7c:	8e050513          	addi	a0,a0,-1824 # 8000b558 <etext+0x558>
    80004c80:	ffffc097          	auipc	ra,0xffffc
    80004c84:	da4080e7          	jalr	-604(ra) # 80000a24 <printf>

  if (stack % 4 != 0){
    80004c88:	fe843783          	ld	a5,-24(s0)
    80004c8c:	8b8d                	andi	a5,a5,3
    80004c8e:	cb99                	beqz	a5,80004ca4 <sys_join+0x64>
    printf ("SYSPROC: Dirección no alineada a word\n");
    80004c90:	00007517          	auipc	a0,0x7
    80004c94:	8f050513          	addi	a0,a0,-1808 # 8000b580 <etext+0x580>
    80004c98:	ffffc097          	auipc	ra,0xffffc
    80004c9c:	d8c080e7          	jalr	-628(ra) # 80000a24 <printf>
    return -1;
    80004ca0:	57fd                	li	a5,-1
    80004ca2:	a809                	j	80004cb4 <sys_join+0x74>
  }

  //hay que comprobar que en la dirección hay algo (aqui o en proc.c)

  return join (stack);
    80004ca4:	fe843783          	ld	a5,-24(s0)
    80004ca8:	853e                	mv	a0,a5
    80004caa:	fffff097          	auipc	ra,0xfffff
    80004cae:	2a8080e7          	jalr	680(ra) # 80003f52 <join>
    80004cb2:	87aa                	mv	a5,a0
}
    80004cb4:	853e                	mv	a0,a5
    80004cb6:	60e2                	ld	ra,24(sp)
    80004cb8:	6442                	ld	s0,16(sp)
    80004cba:	6105                	addi	sp,sp,32
    80004cbc:	8082                	ret

0000000080004cbe <sys_exit>:


uint64
sys_exit(void)
{
    80004cbe:	1101                	addi	sp,sp,-32
    80004cc0:	ec06                	sd	ra,24(sp)
    80004cc2:	e822                	sd	s0,16(sp)
    80004cc4:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80004cc6:	fec40793          	addi	a5,s0,-20
    80004cca:	85be                	mv	a1,a5
    80004ccc:	4501                	li	a0,0
    80004cce:	00000097          	auipc	ra,0x0
    80004cd2:	d4a080e7          	jalr	-694(ra) # 80004a18 <argint>
    80004cd6:	87aa                	mv	a5,a0
    80004cd8:	0007d463          	bgez	a5,80004ce0 <sys_exit+0x22>
    return -1;
    80004cdc:	57fd                	li	a5,-1
    80004cde:	a809                	j	80004cf0 <sys_exit+0x32>
  exit(n);
    80004ce0:	fec42783          	lw	a5,-20(s0)
    80004ce4:	853e                	mv	a0,a5
    80004ce6:	ffffe097          	auipc	ra,0xffffe
    80004cea:	70e080e7          	jalr	1806(ra) # 800033f4 <exit>
  return 0;  // not reached
    80004cee:	4781                	li	a5,0
}
    80004cf0:	853e                	mv	a0,a5
    80004cf2:	60e2                	ld	ra,24(sp)
    80004cf4:	6442                	ld	s0,16(sp)
    80004cf6:	6105                	addi	sp,sp,32
    80004cf8:	8082                	ret

0000000080004cfa <sys_getpid>:

uint64
sys_getpid(void)
{
    80004cfa:	1141                	addi	sp,sp,-16
    80004cfc:	e406                	sd	ra,8(sp)
    80004cfe:	e022                	sd	s0,0(sp)
    80004d00:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80004d02:	ffffe097          	auipc	ra,0xffffe
    80004d06:	d16080e7          	jalr	-746(ra) # 80002a18 <myproc>
    80004d0a:	87aa                	mv	a5,a0
    80004d0c:	5b9c                	lw	a5,48(a5)
}
    80004d0e:	853e                	mv	a0,a5
    80004d10:	60a2                	ld	ra,8(sp)
    80004d12:	6402                	ld	s0,0(sp)
    80004d14:	0141                	addi	sp,sp,16
    80004d16:	8082                	ret

0000000080004d18 <sys_fork>:

uint64
sys_fork(void)
{
    80004d18:	1141                	addi	sp,sp,-16
    80004d1a:	e406                	sd	ra,8(sp)
    80004d1c:	e022                	sd	s0,0(sp)
    80004d1e:	0800                	addi	s0,sp,16
  return fork();
    80004d20:	ffffe097          	auipc	ra,0xffffe
    80004d24:	4ae080e7          	jalr	1198(ra) # 800031ce <fork>
    80004d28:	87aa                	mv	a5,a0
}
    80004d2a:	853e                	mv	a0,a5
    80004d2c:	60a2                	ld	ra,8(sp)
    80004d2e:	6402                	ld	s0,0(sp)
    80004d30:	0141                	addi	sp,sp,16
    80004d32:	8082                	ret

0000000080004d34 <sys_wait>:

uint64
sys_wait(void)
{
    80004d34:	1101                	addi	sp,sp,-32
    80004d36:	ec06                	sd	ra,24(sp)
    80004d38:	e822                	sd	s0,16(sp)
    80004d3a:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80004d3c:	fe840793          	addi	a5,s0,-24
    80004d40:	85be                	mv	a1,a5
    80004d42:	4501                	li	a0,0
    80004d44:	00000097          	auipc	ra,0x0
    80004d48:	d0c080e7          	jalr	-756(ra) # 80004a50 <argaddr>
    80004d4c:	87aa                	mv	a5,a0
    80004d4e:	0007d463          	bgez	a5,80004d56 <sys_wait+0x22>
    return -1;
    80004d52:	57fd                	li	a5,-1
    80004d54:	a809                	j	80004d66 <sys_wait+0x32>
  return wait(p);
    80004d56:	fe843783          	ld	a5,-24(s0)
    80004d5a:	853e                	mv	a0,a5
    80004d5c:	ffffe097          	auipc	ra,0xffffe
    80004d60:	7d4080e7          	jalr	2004(ra) # 80003530 <wait>
    80004d64:	87aa                	mv	a5,a0
}
    80004d66:	853e                	mv	a0,a5
    80004d68:	60e2                	ld	ra,24(sp)
    80004d6a:	6442                	ld	s0,16(sp)
    80004d6c:	6105                	addi	sp,sp,32
    80004d6e:	8082                	ret

0000000080004d70 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80004d70:	1101                	addi	sp,sp,-32
    80004d72:	ec06                	sd	ra,24(sp)
    80004d74:	e822                	sd	s0,16(sp)
    80004d76:	1000                	addi	s0,sp,32
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80004d78:	fe040793          	addi	a5,s0,-32
    80004d7c:	85be                	mv	a1,a5
    80004d7e:	4501                	li	a0,0
    80004d80:	00000097          	auipc	ra,0x0
    80004d84:	c98080e7          	jalr	-872(ra) # 80004a18 <argint>
    80004d88:	87aa                	mv	a5,a0
    80004d8a:	0007d463          	bgez	a5,80004d92 <sys_sbrk+0x22>
    return -1;
    80004d8e:	57fd                	li	a5,-1
    80004d90:	a0bd                	j	80004dfe <sys_sbrk+0x8e>
  
  struct proc *p = myproc();
    80004d92:	ffffe097          	auipc	ra,0xffffe
    80004d96:	c86080e7          	jalr	-890(ra) # 80002a18 <myproc>
    80004d9a:	fea43423          	sd	a0,-24(s0)
  addr = p->sz;
    80004d9e:	fe843783          	ld	a5,-24(s0)
    80004da2:	67bc                	ld	a5,72(a5)
    80004da4:	fef42223          	sw	a5,-28(s0)

  if(growproc(n) < 0)
    80004da8:	fe042783          	lw	a5,-32(s0)
    80004dac:	853e                	mv	a0,a5
    80004dae:	ffffe097          	auipc	ra,0xffffe
    80004db2:	1ca080e7          	jalr	458(ra) # 80002f78 <growproc>
    80004db6:	87aa                	mv	a5,a0
    80004db8:	0007d463          	bgez	a5,80004dc0 <sys_sbrk+0x50>
    return -1;
    80004dbc:	57fd                	li	a5,-1
    80004dbe:	a081                	j	80004dfe <sys_sbrk+0x8e>
    la nueva extensión en los hijos.

    No usamos growproc con el resto de procesos porque entonces estaríamos alocatando más 
    páginas fisicas.
  */
  if (p->referencias > 0 &&  n > 0){ //tiene threads
    80004dc0:	fe843703          	ld	a4,-24(s0)
    80004dc4:	67c9                	lui	a5,0x12
    80004dc6:	97ba                	add	a5,a5,a4
    80004dc8:	18c7a783          	lw	a5,396(a5) # 1218c <_entry-0x7ffede74>
    80004dcc:	02f05763          	blez	a5,80004dfa <sys_sbrk+0x8a>
    80004dd0:	fe042783          	lw	a5,-32(s0)
    80004dd4:	02f05363          	blez	a5,80004dfa <sys_sbrk+0x8a>
    if ((check_grow_threads (p, n,addr))<0){
    80004dd8:	fe042783          	lw	a5,-32(s0)
    80004ddc:	fe442703          	lw	a4,-28(s0)
    80004de0:	863a                	mv	a2,a4
    80004de2:	85be                	mv	a1,a5
    80004de4:	fe843503          	ld	a0,-24(s0)
    80004de8:	ffffe097          	auipc	ra,0xffffe
    80004dec:	246080e7          	jalr	582(ra) # 8000302e <check_grow_threads>
    80004df0:	87aa                	mv	a5,a0
    80004df2:	0007d463          	bgez	a5,80004dfa <sys_sbrk+0x8a>
      return -1;
    80004df6:	57fd                	li	a5,-1
    80004df8:	a019                	j	80004dfe <sys_sbrk+0x8e>

  



  return addr;
    80004dfa:	fe442783          	lw	a5,-28(s0)
}
    80004dfe:	853e                	mv	a0,a5
    80004e00:	60e2                	ld	ra,24(sp)
    80004e02:	6442                	ld	s0,16(sp)
    80004e04:	6105                	addi	sp,sp,32
    80004e06:	8082                	ret

0000000080004e08 <sys_sleep>:

uint64
sys_sleep(void)
{
    80004e08:	1101                	addi	sp,sp,-32
    80004e0a:	ec06                	sd	ra,24(sp)
    80004e0c:	e822                	sd	s0,16(sp)
    80004e0e:	1000                	addi	s0,sp,32
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80004e10:	fe840793          	addi	a5,s0,-24
    80004e14:	85be                	mv	a1,a5
    80004e16:	4501                	li	a0,0
    80004e18:	00000097          	auipc	ra,0x0
    80004e1c:	c00080e7          	jalr	-1024(ra) # 80004a18 <argint>
    80004e20:	87aa                	mv	a5,a0
    80004e22:	0007d463          	bgez	a5,80004e2a <sys_sleep+0x22>
    return -1;
    80004e26:	57fd                	li	a5,-1
    80004e28:	a071                	j	80004eb4 <sys_sleep+0xac>
  acquire(&tickslock);
    80004e2a:	00496517          	auipc	a0,0x496
    80004e2e:	c9e50513          	addi	a0,a0,-866 # 8049aac8 <tickslock>
    80004e32:	ffffc097          	auipc	ra,0xffffc
    80004e36:	438080e7          	jalr	1080(ra) # 8000126a <acquire>
  ticks0 = ticks;
    80004e3a:	00007797          	auipc	a5,0x7
    80004e3e:	1ee78793          	addi	a5,a5,494 # 8000c028 <ticks>
    80004e42:	439c                	lw	a5,0(a5)
    80004e44:	fef42623          	sw	a5,-20(s0)
  while(ticks - ticks0 < n){
    80004e48:	a835                	j	80004e84 <sys_sleep+0x7c>
    if(myproc()->killed){
    80004e4a:	ffffe097          	auipc	ra,0xffffe
    80004e4e:	bce080e7          	jalr	-1074(ra) # 80002a18 <myproc>
    80004e52:	87aa                	mv	a5,a0
    80004e54:	579c                	lw	a5,40(a5)
    80004e56:	cb99                	beqz	a5,80004e6c <sys_sleep+0x64>
      release(&tickslock);
    80004e58:	00496517          	auipc	a0,0x496
    80004e5c:	c7050513          	addi	a0,a0,-912 # 8049aac8 <tickslock>
    80004e60:	ffffc097          	auipc	ra,0xffffc
    80004e64:	46e080e7          	jalr	1134(ra) # 800012ce <release>
      return -1;
    80004e68:	57fd                	li	a5,-1
    80004e6a:	a0a9                	j	80004eb4 <sys_sleep+0xac>
    }
    sleep(&ticks, &tickslock);
    80004e6c:	00496597          	auipc	a1,0x496
    80004e70:	c5c58593          	addi	a1,a1,-932 # 8049aac8 <tickslock>
    80004e74:	00007517          	auipc	a0,0x7
    80004e78:	1b450513          	addi	a0,a0,436 # 8000c028 <ticks>
    80004e7c:	fffff097          	auipc	ra,0xfffff
    80004e80:	a78080e7          	jalr	-1416(ra) # 800038f4 <sleep>
  while(ticks - ticks0 < n){
    80004e84:	00007797          	auipc	a5,0x7
    80004e88:	1a478793          	addi	a5,a5,420 # 8000c028 <ticks>
    80004e8c:	439c                	lw	a5,0(a5)
    80004e8e:	fec42703          	lw	a4,-20(s0)
    80004e92:	9f99                	subw	a5,a5,a4
    80004e94:	0007871b          	sext.w	a4,a5
    80004e98:	fe842783          	lw	a5,-24(s0)
    80004e9c:	2781                	sext.w	a5,a5
    80004e9e:	faf766e3          	bltu	a4,a5,80004e4a <sys_sleep+0x42>
  }
  release(&tickslock);
    80004ea2:	00496517          	auipc	a0,0x496
    80004ea6:	c2650513          	addi	a0,a0,-986 # 8049aac8 <tickslock>
    80004eaa:	ffffc097          	auipc	ra,0xffffc
    80004eae:	424080e7          	jalr	1060(ra) # 800012ce <release>
  return 0;
    80004eb2:	4781                	li	a5,0
}
    80004eb4:	853e                	mv	a0,a5
    80004eb6:	60e2                	ld	ra,24(sp)
    80004eb8:	6442                	ld	s0,16(sp)
    80004eba:	6105                	addi	sp,sp,32
    80004ebc:	8082                	ret

0000000080004ebe <sys_kill>:

uint64
sys_kill(void)
{
    80004ebe:	1101                	addi	sp,sp,-32
    80004ec0:	ec06                	sd	ra,24(sp)
    80004ec2:	e822                	sd	s0,16(sp)
    80004ec4:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80004ec6:	fec40793          	addi	a5,s0,-20
    80004eca:	85be                	mv	a1,a5
    80004ecc:	4501                	li	a0,0
    80004ece:	00000097          	auipc	ra,0x0
    80004ed2:	b4a080e7          	jalr	-1206(ra) # 80004a18 <argint>
    80004ed6:	87aa                	mv	a5,a0
    80004ed8:	0007d463          	bgez	a5,80004ee0 <sys_kill+0x22>
    return -1;
    80004edc:	57fd                	li	a5,-1
    80004ede:	a809                	j	80004ef0 <sys_kill+0x32>
  return kill(pid);
    80004ee0:	fec42783          	lw	a5,-20(s0)
    80004ee4:	853e                	mv	a0,a5
    80004ee6:	fffff097          	auipc	ra,0xfffff
    80004eea:	b22080e7          	jalr	-1246(ra) # 80003a08 <kill>
    80004eee:	87aa                	mv	a5,a0
}
    80004ef0:	853e                	mv	a0,a5
    80004ef2:	60e2                	ld	ra,24(sp)
    80004ef4:	6442                	ld	s0,16(sp)
    80004ef6:	6105                	addi	sp,sp,32
    80004ef8:	8082                	ret

0000000080004efa <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80004efa:	1101                	addi	sp,sp,-32
    80004efc:	ec06                	sd	ra,24(sp)
    80004efe:	e822                	sd	s0,16(sp)
    80004f00:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80004f02:	00496517          	auipc	a0,0x496
    80004f06:	bc650513          	addi	a0,a0,-1082 # 8049aac8 <tickslock>
    80004f0a:	ffffc097          	auipc	ra,0xffffc
    80004f0e:	360080e7          	jalr	864(ra) # 8000126a <acquire>
  xticks = ticks;
    80004f12:	00007797          	auipc	a5,0x7
    80004f16:	11678793          	addi	a5,a5,278 # 8000c028 <ticks>
    80004f1a:	439c                	lw	a5,0(a5)
    80004f1c:	fef42623          	sw	a5,-20(s0)
  release(&tickslock);
    80004f20:	00496517          	auipc	a0,0x496
    80004f24:	ba850513          	addi	a0,a0,-1112 # 8049aac8 <tickslock>
    80004f28:	ffffc097          	auipc	ra,0xffffc
    80004f2c:	3a6080e7          	jalr	934(ra) # 800012ce <release>
  return xticks;
    80004f30:	fec46783          	lwu	a5,-20(s0)
}
    80004f34:	853e                	mv	a0,a5
    80004f36:	60e2                	ld	ra,24(sp)
    80004f38:	6442                	ld	s0,16(sp)
    80004f3a:	6105                	addi	sp,sp,32
    80004f3c:	8082                	ret

0000000080004f3e <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80004f3e:	1101                	addi	sp,sp,-32
    80004f40:	ec06                	sd	ra,24(sp)
    80004f42:	e822                	sd	s0,16(sp)
    80004f44:	1000                	addi	s0,sp,32
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80004f46:	00006597          	auipc	a1,0x6
    80004f4a:	66258593          	addi	a1,a1,1634 # 8000b5a8 <etext+0x5a8>
    80004f4e:	00496517          	auipc	a0,0x496
    80004f52:	b9250513          	addi	a0,a0,-1134 # 8049aae0 <bcache>
    80004f56:	ffffc097          	auipc	ra,0xffffc
    80004f5a:	2e4080e7          	jalr	740(ra) # 8000123a <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80004f5e:	00496717          	auipc	a4,0x496
    80004f62:	b8270713          	addi	a4,a4,-1150 # 8049aae0 <bcache>
    80004f66:	67a1                	lui	a5,0x8
    80004f68:	97ba                	add	a5,a5,a4
    80004f6a:	0049e717          	auipc	a4,0x49e
    80004f6e:	dde70713          	addi	a4,a4,-546 # 804a2d48 <bcache+0x8268>
    80004f72:	2ae7b823          	sd	a4,688(a5) # 82b0 <_entry-0x7fff7d50>
  bcache.head.next = &bcache.head;
    80004f76:	00496717          	auipc	a4,0x496
    80004f7a:	b6a70713          	addi	a4,a4,-1174 # 8049aae0 <bcache>
    80004f7e:	67a1                	lui	a5,0x8
    80004f80:	97ba                	add	a5,a5,a4
    80004f82:	0049e717          	auipc	a4,0x49e
    80004f86:	dc670713          	addi	a4,a4,-570 # 804a2d48 <bcache+0x8268>
    80004f8a:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80004f8e:	00496797          	auipc	a5,0x496
    80004f92:	b6a78793          	addi	a5,a5,-1174 # 8049aaf8 <bcache+0x18>
    80004f96:	fef43423          	sd	a5,-24(s0)
    80004f9a:	a895                	j	8000500e <binit+0xd0>
    b->next = bcache.head.next;
    80004f9c:	00496717          	auipc	a4,0x496
    80004fa0:	b4470713          	addi	a4,a4,-1212 # 8049aae0 <bcache>
    80004fa4:	67a1                	lui	a5,0x8
    80004fa6:	97ba                	add	a5,a5,a4
    80004fa8:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004fac:	fe843783          	ld	a5,-24(s0)
    80004fb0:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    80004fb2:	fe843783          	ld	a5,-24(s0)
    80004fb6:	0049e717          	auipc	a4,0x49e
    80004fba:	d9270713          	addi	a4,a4,-622 # 804a2d48 <bcache+0x8268>
    80004fbe:	e7b8                	sd	a4,72(a5)
    initsleeplock(&b->lock, "buffer");
    80004fc0:	fe843783          	ld	a5,-24(s0)
    80004fc4:	07c1                	addi	a5,a5,16
    80004fc6:	00006597          	auipc	a1,0x6
    80004fca:	5ea58593          	addi	a1,a1,1514 # 8000b5b0 <etext+0x5b0>
    80004fce:	853e                	mv	a0,a5
    80004fd0:	00002097          	auipc	ra,0x2
    80004fd4:	fee080e7          	jalr	-18(ra) # 80006fbe <initsleeplock>
    bcache.head.next->prev = b;
    80004fd8:	00496717          	auipc	a4,0x496
    80004fdc:	b0870713          	addi	a4,a4,-1272 # 8049aae0 <bcache>
    80004fe0:	67a1                	lui	a5,0x8
    80004fe2:	97ba                	add	a5,a5,a4
    80004fe4:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004fe8:	fe843703          	ld	a4,-24(s0)
    80004fec:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    80004fee:	00496717          	auipc	a4,0x496
    80004ff2:	af270713          	addi	a4,a4,-1294 # 8049aae0 <bcache>
    80004ff6:	67a1                	lui	a5,0x8
    80004ff8:	97ba                	add	a5,a5,a4
    80004ffa:	fe843703          	ld	a4,-24(s0)
    80004ffe:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80005002:	fe843783          	ld	a5,-24(s0)
    80005006:	45878793          	addi	a5,a5,1112
    8000500a:	fef43423          	sd	a5,-24(s0)
    8000500e:	0049e797          	auipc	a5,0x49e
    80005012:	d3a78793          	addi	a5,a5,-710 # 804a2d48 <bcache+0x8268>
    80005016:	fe843703          	ld	a4,-24(s0)
    8000501a:	f8f761e3          	bltu	a4,a5,80004f9c <binit+0x5e>
  }
}
    8000501e:	0001                	nop
    80005020:	0001                	nop
    80005022:	60e2                	ld	ra,24(sp)
    80005024:	6442                	ld	s0,16(sp)
    80005026:	6105                	addi	sp,sp,32
    80005028:	8082                	ret

000000008000502a <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    8000502a:	7179                	addi	sp,sp,-48
    8000502c:	f406                	sd	ra,40(sp)
    8000502e:	f022                	sd	s0,32(sp)
    80005030:	1800                	addi	s0,sp,48
    80005032:	87aa                	mv	a5,a0
    80005034:	872e                	mv	a4,a1
    80005036:	fcf42e23          	sw	a5,-36(s0)
    8000503a:	87ba                	mv	a5,a4
    8000503c:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  acquire(&bcache.lock);
    80005040:	00496517          	auipc	a0,0x496
    80005044:	aa050513          	addi	a0,a0,-1376 # 8049aae0 <bcache>
    80005048:	ffffc097          	auipc	ra,0xffffc
    8000504c:	222080e7          	jalr	546(ra) # 8000126a <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80005050:	00496717          	auipc	a4,0x496
    80005054:	a9070713          	addi	a4,a4,-1392 # 8049aae0 <bcache>
    80005058:	67a1                	lui	a5,0x8
    8000505a:	97ba                	add	a5,a5,a4
    8000505c:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80005060:	fef43423          	sd	a5,-24(s0)
    80005064:	a095                	j	800050c8 <bget+0x9e>
    if(b->dev == dev && b->blockno == blockno){
    80005066:	fe843783          	ld	a5,-24(s0)
    8000506a:	4798                	lw	a4,8(a5)
    8000506c:	fdc42783          	lw	a5,-36(s0)
    80005070:	2781                	sext.w	a5,a5
    80005072:	04e79663          	bne	a5,a4,800050be <bget+0x94>
    80005076:	fe843783          	ld	a5,-24(s0)
    8000507a:	47d8                	lw	a4,12(a5)
    8000507c:	fd842783          	lw	a5,-40(s0)
    80005080:	2781                	sext.w	a5,a5
    80005082:	02e79e63          	bne	a5,a4,800050be <bget+0x94>
      b->refcnt++;
    80005086:	fe843783          	ld	a5,-24(s0)
    8000508a:	43bc                	lw	a5,64(a5)
    8000508c:	2785                	addiw	a5,a5,1
    8000508e:	0007871b          	sext.w	a4,a5
    80005092:	fe843783          	ld	a5,-24(s0)
    80005096:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    80005098:	00496517          	auipc	a0,0x496
    8000509c:	a4850513          	addi	a0,a0,-1464 # 8049aae0 <bcache>
    800050a0:	ffffc097          	auipc	ra,0xffffc
    800050a4:	22e080e7          	jalr	558(ra) # 800012ce <release>
      acquiresleep(&b->lock);
    800050a8:	fe843783          	ld	a5,-24(s0)
    800050ac:	07c1                	addi	a5,a5,16
    800050ae:	853e                	mv	a0,a5
    800050b0:	00002097          	auipc	ra,0x2
    800050b4:	f5a080e7          	jalr	-166(ra) # 8000700a <acquiresleep>
      return b;
    800050b8:	fe843783          	ld	a5,-24(s0)
    800050bc:	a07d                	j	8000516a <bget+0x140>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800050be:	fe843783          	ld	a5,-24(s0)
    800050c2:	6bbc                	ld	a5,80(a5)
    800050c4:	fef43423          	sd	a5,-24(s0)
    800050c8:	fe843703          	ld	a4,-24(s0)
    800050cc:	0049e797          	auipc	a5,0x49e
    800050d0:	c7c78793          	addi	a5,a5,-900 # 804a2d48 <bcache+0x8268>
    800050d4:	f8f719e3          	bne	a4,a5,80005066 <bget+0x3c>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800050d8:	00496717          	auipc	a4,0x496
    800050dc:	a0870713          	addi	a4,a4,-1528 # 8049aae0 <bcache>
    800050e0:	67a1                	lui	a5,0x8
    800050e2:	97ba                	add	a5,a5,a4
    800050e4:	2b07b783          	ld	a5,688(a5) # 82b0 <_entry-0x7fff7d50>
    800050e8:	fef43423          	sd	a5,-24(s0)
    800050ec:	a8b9                	j	8000514a <bget+0x120>
    if(b->refcnt == 0) {
    800050ee:	fe843783          	ld	a5,-24(s0)
    800050f2:	43bc                	lw	a5,64(a5)
    800050f4:	e7b1                	bnez	a5,80005140 <bget+0x116>
      b->dev = dev;
    800050f6:	fe843783          	ld	a5,-24(s0)
    800050fa:	fdc42703          	lw	a4,-36(s0)
    800050fe:	c798                	sw	a4,8(a5)
      b->blockno = blockno;
    80005100:	fe843783          	ld	a5,-24(s0)
    80005104:	fd842703          	lw	a4,-40(s0)
    80005108:	c7d8                	sw	a4,12(a5)
      b->valid = 0;
    8000510a:	fe843783          	ld	a5,-24(s0)
    8000510e:	0007a023          	sw	zero,0(a5)
      b->refcnt = 1;
    80005112:	fe843783          	ld	a5,-24(s0)
    80005116:	4705                	li	a4,1
    80005118:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    8000511a:	00496517          	auipc	a0,0x496
    8000511e:	9c650513          	addi	a0,a0,-1594 # 8049aae0 <bcache>
    80005122:	ffffc097          	auipc	ra,0xffffc
    80005126:	1ac080e7          	jalr	428(ra) # 800012ce <release>
      acquiresleep(&b->lock);
    8000512a:	fe843783          	ld	a5,-24(s0)
    8000512e:	07c1                	addi	a5,a5,16
    80005130:	853e                	mv	a0,a5
    80005132:	00002097          	auipc	ra,0x2
    80005136:	ed8080e7          	jalr	-296(ra) # 8000700a <acquiresleep>
      return b;
    8000513a:	fe843783          	ld	a5,-24(s0)
    8000513e:	a035                	j	8000516a <bget+0x140>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80005140:	fe843783          	ld	a5,-24(s0)
    80005144:	67bc                	ld	a5,72(a5)
    80005146:	fef43423          	sd	a5,-24(s0)
    8000514a:	fe843703          	ld	a4,-24(s0)
    8000514e:	0049e797          	auipc	a5,0x49e
    80005152:	bfa78793          	addi	a5,a5,-1030 # 804a2d48 <bcache+0x8268>
    80005156:	f8f71ce3          	bne	a4,a5,800050ee <bget+0xc4>
    }
  }
  panic("bget: no buffers");
    8000515a:	00006517          	auipc	a0,0x6
    8000515e:	45e50513          	addi	a0,a0,1118 # 8000b5b8 <etext+0x5b8>
    80005162:	ffffc097          	auipc	ra,0xffffc
    80005166:	b18080e7          	jalr	-1256(ra) # 80000c7a <panic>
}
    8000516a:	853e                	mv	a0,a5
    8000516c:	70a2                	ld	ra,40(sp)
    8000516e:	7402                	ld	s0,32(sp)
    80005170:	6145                	addi	sp,sp,48
    80005172:	8082                	ret

0000000080005174 <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80005174:	7179                	addi	sp,sp,-48
    80005176:	f406                	sd	ra,40(sp)
    80005178:	f022                	sd	s0,32(sp)
    8000517a:	1800                	addi	s0,sp,48
    8000517c:	87aa                	mv	a5,a0
    8000517e:	872e                	mv	a4,a1
    80005180:	fcf42e23          	sw	a5,-36(s0)
    80005184:	87ba                	mv	a5,a4
    80005186:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  b = bget(dev, blockno);
    8000518a:	fd842703          	lw	a4,-40(s0)
    8000518e:	fdc42783          	lw	a5,-36(s0)
    80005192:	85ba                	mv	a1,a4
    80005194:	853e                	mv	a0,a5
    80005196:	00000097          	auipc	ra,0x0
    8000519a:	e94080e7          	jalr	-364(ra) # 8000502a <bget>
    8000519e:	fea43423          	sd	a0,-24(s0)
  if(!b->valid) {
    800051a2:	fe843783          	ld	a5,-24(s0)
    800051a6:	439c                	lw	a5,0(a5)
    800051a8:	ef81                	bnez	a5,800051c0 <bread+0x4c>
    virtio_disk_rw(b, 0);
    800051aa:	4581                	li	a1,0
    800051ac:	fe843503          	ld	a0,-24(s0)
    800051b0:	00004097          	auipc	ra,0x4
    800051b4:	73c080e7          	jalr	1852(ra) # 800098ec <virtio_disk_rw>
    b->valid = 1;
    800051b8:	fe843783          	ld	a5,-24(s0)
    800051bc:	4705                	li	a4,1
    800051be:	c398                	sw	a4,0(a5)
  }
  return b;
    800051c0:	fe843783          	ld	a5,-24(s0)
}
    800051c4:	853e                	mv	a0,a5
    800051c6:	70a2                	ld	ra,40(sp)
    800051c8:	7402                	ld	s0,32(sp)
    800051ca:	6145                	addi	sp,sp,48
    800051cc:	8082                	ret

00000000800051ce <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800051ce:	1101                	addi	sp,sp,-32
    800051d0:	ec06                	sd	ra,24(sp)
    800051d2:	e822                	sd	s0,16(sp)
    800051d4:	1000                	addi	s0,sp,32
    800051d6:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    800051da:	fe843783          	ld	a5,-24(s0)
    800051de:	07c1                	addi	a5,a5,16
    800051e0:	853e                	mv	a0,a5
    800051e2:	00002097          	auipc	ra,0x2
    800051e6:	ee8080e7          	jalr	-280(ra) # 800070ca <holdingsleep>
    800051ea:	87aa                	mv	a5,a0
    800051ec:	eb89                	bnez	a5,800051fe <bwrite+0x30>
    panic("bwrite");
    800051ee:	00006517          	auipc	a0,0x6
    800051f2:	3e250513          	addi	a0,a0,994 # 8000b5d0 <etext+0x5d0>
    800051f6:	ffffc097          	auipc	ra,0xffffc
    800051fa:	a84080e7          	jalr	-1404(ra) # 80000c7a <panic>
  virtio_disk_rw(b, 1);
    800051fe:	4585                	li	a1,1
    80005200:	fe843503          	ld	a0,-24(s0)
    80005204:	00004097          	auipc	ra,0x4
    80005208:	6e8080e7          	jalr	1768(ra) # 800098ec <virtio_disk_rw>
}
    8000520c:	0001                	nop
    8000520e:	60e2                	ld	ra,24(sp)
    80005210:	6442                	ld	s0,16(sp)
    80005212:	6105                	addi	sp,sp,32
    80005214:	8082                	ret

0000000080005216 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80005216:	1101                	addi	sp,sp,-32
    80005218:	ec06                	sd	ra,24(sp)
    8000521a:	e822                	sd	s0,16(sp)
    8000521c:	1000                	addi	s0,sp,32
    8000521e:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    80005222:	fe843783          	ld	a5,-24(s0)
    80005226:	07c1                	addi	a5,a5,16
    80005228:	853e                	mv	a0,a5
    8000522a:	00002097          	auipc	ra,0x2
    8000522e:	ea0080e7          	jalr	-352(ra) # 800070ca <holdingsleep>
    80005232:	87aa                	mv	a5,a0
    80005234:	eb89                	bnez	a5,80005246 <brelse+0x30>
    panic("brelse");
    80005236:	00006517          	auipc	a0,0x6
    8000523a:	3a250513          	addi	a0,a0,930 # 8000b5d8 <etext+0x5d8>
    8000523e:	ffffc097          	auipc	ra,0xffffc
    80005242:	a3c080e7          	jalr	-1476(ra) # 80000c7a <panic>

  releasesleep(&b->lock);
    80005246:	fe843783          	ld	a5,-24(s0)
    8000524a:	07c1                	addi	a5,a5,16
    8000524c:	853e                	mv	a0,a5
    8000524e:	00002097          	auipc	ra,0x2
    80005252:	e2a080e7          	jalr	-470(ra) # 80007078 <releasesleep>

  acquire(&bcache.lock);
    80005256:	00496517          	auipc	a0,0x496
    8000525a:	88a50513          	addi	a0,a0,-1910 # 8049aae0 <bcache>
    8000525e:	ffffc097          	auipc	ra,0xffffc
    80005262:	00c080e7          	jalr	12(ra) # 8000126a <acquire>
  b->refcnt--;
    80005266:	fe843783          	ld	a5,-24(s0)
    8000526a:	43bc                	lw	a5,64(a5)
    8000526c:	37fd                	addiw	a5,a5,-1
    8000526e:	0007871b          	sext.w	a4,a5
    80005272:	fe843783          	ld	a5,-24(s0)
    80005276:	c3b8                	sw	a4,64(a5)
  if (b->refcnt == 0) {
    80005278:	fe843783          	ld	a5,-24(s0)
    8000527c:	43bc                	lw	a5,64(a5)
    8000527e:	e7b5                	bnez	a5,800052ea <brelse+0xd4>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80005280:	fe843783          	ld	a5,-24(s0)
    80005284:	6bbc                	ld	a5,80(a5)
    80005286:	fe843703          	ld	a4,-24(s0)
    8000528a:	6738                	ld	a4,72(a4)
    8000528c:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    8000528e:	fe843783          	ld	a5,-24(s0)
    80005292:	67bc                	ld	a5,72(a5)
    80005294:	fe843703          	ld	a4,-24(s0)
    80005298:	6b38                	ld	a4,80(a4)
    8000529a:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8000529c:	00496717          	auipc	a4,0x496
    800052a0:	84470713          	addi	a4,a4,-1980 # 8049aae0 <bcache>
    800052a4:	67a1                	lui	a5,0x8
    800052a6:	97ba                	add	a5,a5,a4
    800052a8:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    800052ac:	fe843783          	ld	a5,-24(s0)
    800052b0:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    800052b2:	fe843783          	ld	a5,-24(s0)
    800052b6:	0049e717          	auipc	a4,0x49e
    800052ba:	a9270713          	addi	a4,a4,-1390 # 804a2d48 <bcache+0x8268>
    800052be:	e7b8                	sd	a4,72(a5)
    bcache.head.next->prev = b;
    800052c0:	00496717          	auipc	a4,0x496
    800052c4:	82070713          	addi	a4,a4,-2016 # 8049aae0 <bcache>
    800052c8:	67a1                	lui	a5,0x8
    800052ca:	97ba                	add	a5,a5,a4
    800052cc:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    800052d0:	fe843703          	ld	a4,-24(s0)
    800052d4:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    800052d6:	00496717          	auipc	a4,0x496
    800052da:	80a70713          	addi	a4,a4,-2038 # 8049aae0 <bcache>
    800052de:	67a1                	lui	a5,0x8
    800052e0:	97ba                	add	a5,a5,a4
    800052e2:	fe843703          	ld	a4,-24(s0)
    800052e6:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  }
  
  release(&bcache.lock);
    800052ea:	00495517          	auipc	a0,0x495
    800052ee:	7f650513          	addi	a0,a0,2038 # 8049aae0 <bcache>
    800052f2:	ffffc097          	auipc	ra,0xffffc
    800052f6:	fdc080e7          	jalr	-36(ra) # 800012ce <release>
}
    800052fa:	0001                	nop
    800052fc:	60e2                	ld	ra,24(sp)
    800052fe:	6442                	ld	s0,16(sp)
    80005300:	6105                	addi	sp,sp,32
    80005302:	8082                	ret

0000000080005304 <bpin>:

void
bpin(struct buf *b) {
    80005304:	1101                	addi	sp,sp,-32
    80005306:	ec06                	sd	ra,24(sp)
    80005308:	e822                	sd	s0,16(sp)
    8000530a:	1000                	addi	s0,sp,32
    8000530c:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80005310:	00495517          	auipc	a0,0x495
    80005314:	7d050513          	addi	a0,a0,2000 # 8049aae0 <bcache>
    80005318:	ffffc097          	auipc	ra,0xffffc
    8000531c:	f52080e7          	jalr	-174(ra) # 8000126a <acquire>
  b->refcnt++;
    80005320:	fe843783          	ld	a5,-24(s0)
    80005324:	43bc                	lw	a5,64(a5)
    80005326:	2785                	addiw	a5,a5,1
    80005328:	0007871b          	sext.w	a4,a5
    8000532c:	fe843783          	ld	a5,-24(s0)
    80005330:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80005332:	00495517          	auipc	a0,0x495
    80005336:	7ae50513          	addi	a0,a0,1966 # 8049aae0 <bcache>
    8000533a:	ffffc097          	auipc	ra,0xffffc
    8000533e:	f94080e7          	jalr	-108(ra) # 800012ce <release>
}
    80005342:	0001                	nop
    80005344:	60e2                	ld	ra,24(sp)
    80005346:	6442                	ld	s0,16(sp)
    80005348:	6105                	addi	sp,sp,32
    8000534a:	8082                	ret

000000008000534c <bunpin>:

void
bunpin(struct buf *b) {
    8000534c:	1101                	addi	sp,sp,-32
    8000534e:	ec06                	sd	ra,24(sp)
    80005350:	e822                	sd	s0,16(sp)
    80005352:	1000                	addi	s0,sp,32
    80005354:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80005358:	00495517          	auipc	a0,0x495
    8000535c:	78850513          	addi	a0,a0,1928 # 8049aae0 <bcache>
    80005360:	ffffc097          	auipc	ra,0xffffc
    80005364:	f0a080e7          	jalr	-246(ra) # 8000126a <acquire>
  b->refcnt--;
    80005368:	fe843783          	ld	a5,-24(s0)
    8000536c:	43bc                	lw	a5,64(a5)
    8000536e:	37fd                	addiw	a5,a5,-1
    80005370:	0007871b          	sext.w	a4,a5
    80005374:	fe843783          	ld	a5,-24(s0)
    80005378:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    8000537a:	00495517          	auipc	a0,0x495
    8000537e:	76650513          	addi	a0,a0,1894 # 8049aae0 <bcache>
    80005382:	ffffc097          	auipc	ra,0xffffc
    80005386:	f4c080e7          	jalr	-180(ra) # 800012ce <release>
}
    8000538a:	0001                	nop
    8000538c:	60e2                	ld	ra,24(sp)
    8000538e:	6442                	ld	s0,16(sp)
    80005390:	6105                	addi	sp,sp,32
    80005392:	8082                	ret

0000000080005394 <readsb>:
struct superblock sb; 

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
    80005394:	7179                	addi	sp,sp,-48
    80005396:	f406                	sd	ra,40(sp)
    80005398:	f022                	sd	s0,32(sp)
    8000539a:	1800                	addi	s0,sp,48
    8000539c:	87aa                	mv	a5,a0
    8000539e:	fcb43823          	sd	a1,-48(s0)
    800053a2:	fcf42e23          	sw	a5,-36(s0)
  struct buf *bp;

  bp = bread(dev, 1);
    800053a6:	fdc42783          	lw	a5,-36(s0)
    800053aa:	4585                	li	a1,1
    800053ac:	853e                	mv	a0,a5
    800053ae:	00000097          	auipc	ra,0x0
    800053b2:	dc6080e7          	jalr	-570(ra) # 80005174 <bread>
    800053b6:	fea43423          	sd	a0,-24(s0)
  memmove(sb, bp->data, sizeof(*sb));
    800053ba:	fe843783          	ld	a5,-24(s0)
    800053be:	05878793          	addi	a5,a5,88
    800053c2:	02000613          	li	a2,32
    800053c6:	85be                	mv	a1,a5
    800053c8:	fd043503          	ld	a0,-48(s0)
    800053cc:	ffffc097          	auipc	ra,0xffffc
    800053d0:	156080e7          	jalr	342(ra) # 80001522 <memmove>
  brelse(bp);
    800053d4:	fe843503          	ld	a0,-24(s0)
    800053d8:	00000097          	auipc	ra,0x0
    800053dc:	e3e080e7          	jalr	-450(ra) # 80005216 <brelse>
}
    800053e0:	0001                	nop
    800053e2:	70a2                	ld	ra,40(sp)
    800053e4:	7402                	ld	s0,32(sp)
    800053e6:	6145                	addi	sp,sp,48
    800053e8:	8082                	ret

00000000800053ea <fsinit>:

// Init fs
void
fsinit(int dev) {
    800053ea:	1101                	addi	sp,sp,-32
    800053ec:	ec06                	sd	ra,24(sp)
    800053ee:	e822                	sd	s0,16(sp)
    800053f0:	1000                	addi	s0,sp,32
    800053f2:	87aa                	mv	a5,a0
    800053f4:	fef42623          	sw	a5,-20(s0)
  readsb(dev, &sb);
    800053f8:	fec42783          	lw	a5,-20(s0)
    800053fc:	0049e597          	auipc	a1,0x49e
    80005400:	da458593          	addi	a1,a1,-604 # 804a31a0 <sb>
    80005404:	853e                	mv	a0,a5
    80005406:	00000097          	auipc	ra,0x0
    8000540a:	f8e080e7          	jalr	-114(ra) # 80005394 <readsb>
  if(sb.magic != FSMAGIC)
    8000540e:	0049e797          	auipc	a5,0x49e
    80005412:	d9278793          	addi	a5,a5,-622 # 804a31a0 <sb>
    80005416:	439c                	lw	a5,0(a5)
    80005418:	873e                	mv	a4,a5
    8000541a:	102037b7          	lui	a5,0x10203
    8000541e:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80005422:	00f70a63          	beq	a4,a5,80005436 <fsinit+0x4c>
    panic("invalid file system");
    80005426:	00006517          	auipc	a0,0x6
    8000542a:	1ba50513          	addi	a0,a0,442 # 8000b5e0 <etext+0x5e0>
    8000542e:	ffffc097          	auipc	ra,0xffffc
    80005432:	84c080e7          	jalr	-1972(ra) # 80000c7a <panic>
  initlog(dev, &sb);
    80005436:	fec42783          	lw	a5,-20(s0)
    8000543a:	0049e597          	auipc	a1,0x49e
    8000543e:	d6658593          	addi	a1,a1,-666 # 804a31a0 <sb>
    80005442:	853e                	mv	a0,a5
    80005444:	00001097          	auipc	ra,0x1
    80005448:	45e080e7          	jalr	1118(ra) # 800068a2 <initlog>
}
    8000544c:	0001                	nop
    8000544e:	60e2                	ld	ra,24(sp)
    80005450:	6442                	ld	s0,16(sp)
    80005452:	6105                	addi	sp,sp,32
    80005454:	8082                	ret

0000000080005456 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
    80005456:	7179                	addi	sp,sp,-48
    80005458:	f406                	sd	ra,40(sp)
    8000545a:	f022                	sd	s0,32(sp)
    8000545c:	1800                	addi	s0,sp,48
    8000545e:	87aa                	mv	a5,a0
    80005460:	872e                	mv	a4,a1
    80005462:	fcf42e23          	sw	a5,-36(s0)
    80005466:	87ba                	mv	a5,a4
    80005468:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;

  bp = bread(dev, bno);
    8000546c:	fdc42783          	lw	a5,-36(s0)
    80005470:	fd842703          	lw	a4,-40(s0)
    80005474:	85ba                	mv	a1,a4
    80005476:	853e                	mv	a0,a5
    80005478:	00000097          	auipc	ra,0x0
    8000547c:	cfc080e7          	jalr	-772(ra) # 80005174 <bread>
    80005480:	fea43423          	sd	a0,-24(s0)
  memset(bp->data, 0, BSIZE);
    80005484:	fe843783          	ld	a5,-24(s0)
    80005488:	05878793          	addi	a5,a5,88
    8000548c:	40000613          	li	a2,1024
    80005490:	4581                	li	a1,0
    80005492:	853e                	mv	a0,a5
    80005494:	ffffc097          	auipc	ra,0xffffc
    80005498:	faa080e7          	jalr	-86(ra) # 8000143e <memset>
  log_write(bp);
    8000549c:	fe843503          	ld	a0,-24(s0)
    800054a0:	00002097          	auipc	ra,0x2
    800054a4:	9ea080e7          	jalr	-1558(ra) # 80006e8a <log_write>
  brelse(bp);
    800054a8:	fe843503          	ld	a0,-24(s0)
    800054ac:	00000097          	auipc	ra,0x0
    800054b0:	d6a080e7          	jalr	-662(ra) # 80005216 <brelse>
}
    800054b4:	0001                	nop
    800054b6:	70a2                	ld	ra,40(sp)
    800054b8:	7402                	ld	s0,32(sp)
    800054ba:	6145                	addi	sp,sp,48
    800054bc:	8082                	ret

00000000800054be <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
    800054be:	7139                	addi	sp,sp,-64
    800054c0:	fc06                	sd	ra,56(sp)
    800054c2:	f822                	sd	s0,48(sp)
    800054c4:	0080                	addi	s0,sp,64
    800054c6:	87aa                	mv	a5,a0
    800054c8:	fcf42623          	sw	a5,-52(s0)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
    800054cc:	fe043023          	sd	zero,-32(s0)
  for(b = 0; b < sb.size; b += BPB){
    800054d0:	fe042623          	sw	zero,-20(s0)
    800054d4:	a295                	j	80005638 <balloc+0x17a>
    bp = bread(dev, BBLOCK(b, sb));
    800054d6:	fec42783          	lw	a5,-20(s0)
    800054da:	41f7d71b          	sraiw	a4,a5,0x1f
    800054de:	0137571b          	srliw	a4,a4,0x13
    800054e2:	9fb9                	addw	a5,a5,a4
    800054e4:	40d7d79b          	sraiw	a5,a5,0xd
    800054e8:	2781                	sext.w	a5,a5
    800054ea:	0007871b          	sext.w	a4,a5
    800054ee:	0049e797          	auipc	a5,0x49e
    800054f2:	cb278793          	addi	a5,a5,-846 # 804a31a0 <sb>
    800054f6:	4fdc                	lw	a5,28(a5)
    800054f8:	9fb9                	addw	a5,a5,a4
    800054fa:	0007871b          	sext.w	a4,a5
    800054fe:	fcc42783          	lw	a5,-52(s0)
    80005502:	85ba                	mv	a1,a4
    80005504:	853e                	mv	a0,a5
    80005506:	00000097          	auipc	ra,0x0
    8000550a:	c6e080e7          	jalr	-914(ra) # 80005174 <bread>
    8000550e:	fea43023          	sd	a0,-32(s0)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80005512:	fe042423          	sw	zero,-24(s0)
    80005516:	a8e9                	j	800055f0 <balloc+0x132>
      m = 1 << (bi % 8);
    80005518:	fe842783          	lw	a5,-24(s0)
    8000551c:	8b9d                	andi	a5,a5,7
    8000551e:	2781                	sext.w	a5,a5
    80005520:	4705                	li	a4,1
    80005522:	00f717bb          	sllw	a5,a4,a5
    80005526:	fcf42e23          	sw	a5,-36(s0)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    8000552a:	fe842783          	lw	a5,-24(s0)
    8000552e:	41f7d71b          	sraiw	a4,a5,0x1f
    80005532:	01d7571b          	srliw	a4,a4,0x1d
    80005536:	9fb9                	addw	a5,a5,a4
    80005538:	4037d79b          	sraiw	a5,a5,0x3
    8000553c:	2781                	sext.w	a5,a5
    8000553e:	fe043703          	ld	a4,-32(s0)
    80005542:	97ba                	add	a5,a5,a4
    80005544:	0587c783          	lbu	a5,88(a5)
    80005548:	2781                	sext.w	a5,a5
    8000554a:	fdc42703          	lw	a4,-36(s0)
    8000554e:	8ff9                	and	a5,a5,a4
    80005550:	2781                	sext.w	a5,a5
    80005552:	ebd1                	bnez	a5,800055e6 <balloc+0x128>
        bp->data[bi/8] |= m;  // Mark block in use.
    80005554:	fe842783          	lw	a5,-24(s0)
    80005558:	41f7d71b          	sraiw	a4,a5,0x1f
    8000555c:	01d7571b          	srliw	a4,a4,0x1d
    80005560:	9fb9                	addw	a5,a5,a4
    80005562:	4037d79b          	sraiw	a5,a5,0x3
    80005566:	2781                	sext.w	a5,a5
    80005568:	fe043703          	ld	a4,-32(s0)
    8000556c:	973e                	add	a4,a4,a5
    8000556e:	05874703          	lbu	a4,88(a4)
    80005572:	0187169b          	slliw	a3,a4,0x18
    80005576:	4186d69b          	sraiw	a3,a3,0x18
    8000557a:	fdc42703          	lw	a4,-36(s0)
    8000557e:	0187171b          	slliw	a4,a4,0x18
    80005582:	4187571b          	sraiw	a4,a4,0x18
    80005586:	8f55                	or	a4,a4,a3
    80005588:	0187171b          	slliw	a4,a4,0x18
    8000558c:	4187571b          	sraiw	a4,a4,0x18
    80005590:	0ff77713          	zext.b	a4,a4
    80005594:	fe043683          	ld	a3,-32(s0)
    80005598:	97b6                	add	a5,a5,a3
    8000559a:	04e78c23          	sb	a4,88(a5)
        log_write(bp);
    8000559e:	fe043503          	ld	a0,-32(s0)
    800055a2:	00002097          	auipc	ra,0x2
    800055a6:	8e8080e7          	jalr	-1816(ra) # 80006e8a <log_write>
        brelse(bp);
    800055aa:	fe043503          	ld	a0,-32(s0)
    800055ae:	00000097          	auipc	ra,0x0
    800055b2:	c68080e7          	jalr	-920(ra) # 80005216 <brelse>
        bzero(dev, b + bi);
    800055b6:	fcc42783          	lw	a5,-52(s0)
    800055ba:	fec42703          	lw	a4,-20(s0)
    800055be:	86ba                	mv	a3,a4
    800055c0:	fe842703          	lw	a4,-24(s0)
    800055c4:	9f35                	addw	a4,a4,a3
    800055c6:	2701                	sext.w	a4,a4
    800055c8:	85ba                	mv	a1,a4
    800055ca:	853e                	mv	a0,a5
    800055cc:	00000097          	auipc	ra,0x0
    800055d0:	e8a080e7          	jalr	-374(ra) # 80005456 <bzero>
        return b + bi;
    800055d4:	fec42783          	lw	a5,-20(s0)
    800055d8:	873e                	mv	a4,a5
    800055da:	fe842783          	lw	a5,-24(s0)
    800055de:	9fb9                	addw	a5,a5,a4
    800055e0:	2781                	sext.w	a5,a5
    800055e2:	2781                	sext.w	a5,a5
    800055e4:	a89d                	j	8000565a <balloc+0x19c>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800055e6:	fe842783          	lw	a5,-24(s0)
    800055ea:	2785                	addiw	a5,a5,1
    800055ec:	fef42423          	sw	a5,-24(s0)
    800055f0:	fe842783          	lw	a5,-24(s0)
    800055f4:	0007871b          	sext.w	a4,a5
    800055f8:	6789                	lui	a5,0x2
    800055fa:	02f75263          	bge	a4,a5,8000561e <balloc+0x160>
    800055fe:	fec42783          	lw	a5,-20(s0)
    80005602:	873e                	mv	a4,a5
    80005604:	fe842783          	lw	a5,-24(s0)
    80005608:	9fb9                	addw	a5,a5,a4
    8000560a:	2781                	sext.w	a5,a5
    8000560c:	0007871b          	sext.w	a4,a5
    80005610:	0049e797          	auipc	a5,0x49e
    80005614:	b9078793          	addi	a5,a5,-1136 # 804a31a0 <sb>
    80005618:	43dc                	lw	a5,4(a5)
    8000561a:	eef76fe3          	bltu	a4,a5,80005518 <balloc+0x5a>
      }
    }
    brelse(bp);
    8000561e:	fe043503          	ld	a0,-32(s0)
    80005622:	00000097          	auipc	ra,0x0
    80005626:	bf4080e7          	jalr	-1036(ra) # 80005216 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000562a:	fec42783          	lw	a5,-20(s0)
    8000562e:	873e                	mv	a4,a5
    80005630:	6789                	lui	a5,0x2
    80005632:	9fb9                	addw	a5,a5,a4
    80005634:	fef42623          	sw	a5,-20(s0)
    80005638:	0049e797          	auipc	a5,0x49e
    8000563c:	b6878793          	addi	a5,a5,-1176 # 804a31a0 <sb>
    80005640:	43d8                	lw	a4,4(a5)
    80005642:	fec42783          	lw	a5,-20(s0)
    80005646:	e8e7e8e3          	bltu	a5,a4,800054d6 <balloc+0x18>
  }
  panic("balloc: out of blocks");
    8000564a:	00006517          	auipc	a0,0x6
    8000564e:	fae50513          	addi	a0,a0,-82 # 8000b5f8 <etext+0x5f8>
    80005652:	ffffb097          	auipc	ra,0xffffb
    80005656:	628080e7          	jalr	1576(ra) # 80000c7a <panic>
}
    8000565a:	853e                	mv	a0,a5
    8000565c:	70e2                	ld	ra,56(sp)
    8000565e:	7442                	ld	s0,48(sp)
    80005660:	6121                	addi	sp,sp,64
    80005662:	8082                	ret

0000000080005664 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80005664:	7179                	addi	sp,sp,-48
    80005666:	f406                	sd	ra,40(sp)
    80005668:	f022                	sd	s0,32(sp)
    8000566a:	1800                	addi	s0,sp,48
    8000566c:	87aa                	mv	a5,a0
    8000566e:	872e                	mv	a4,a1
    80005670:	fcf42e23          	sw	a5,-36(s0)
    80005674:	87ba                	mv	a5,a4
    80005676:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    8000567a:	fdc42683          	lw	a3,-36(s0)
    8000567e:	fd842783          	lw	a5,-40(s0)
    80005682:	00d7d79b          	srliw	a5,a5,0xd
    80005686:	0007871b          	sext.w	a4,a5
    8000568a:	0049e797          	auipc	a5,0x49e
    8000568e:	b1678793          	addi	a5,a5,-1258 # 804a31a0 <sb>
    80005692:	4fdc                	lw	a5,28(a5)
    80005694:	9fb9                	addw	a5,a5,a4
    80005696:	2781                	sext.w	a5,a5
    80005698:	85be                	mv	a1,a5
    8000569a:	8536                	mv	a0,a3
    8000569c:	00000097          	auipc	ra,0x0
    800056a0:	ad8080e7          	jalr	-1320(ra) # 80005174 <bread>
    800056a4:	fea43423          	sd	a0,-24(s0)
  bi = b % BPB;
    800056a8:	fd842703          	lw	a4,-40(s0)
    800056ac:	6789                	lui	a5,0x2
    800056ae:	17fd                	addi	a5,a5,-1
    800056b0:	8ff9                	and	a5,a5,a4
    800056b2:	fef42223          	sw	a5,-28(s0)
  m = 1 << (bi % 8);
    800056b6:	fe442783          	lw	a5,-28(s0)
    800056ba:	8b9d                	andi	a5,a5,7
    800056bc:	2781                	sext.w	a5,a5
    800056be:	4705                	li	a4,1
    800056c0:	00f717bb          	sllw	a5,a4,a5
    800056c4:	fef42023          	sw	a5,-32(s0)
  if((bp->data[bi/8] & m) == 0)
    800056c8:	fe442783          	lw	a5,-28(s0)
    800056cc:	41f7d71b          	sraiw	a4,a5,0x1f
    800056d0:	01d7571b          	srliw	a4,a4,0x1d
    800056d4:	9fb9                	addw	a5,a5,a4
    800056d6:	4037d79b          	sraiw	a5,a5,0x3
    800056da:	2781                	sext.w	a5,a5
    800056dc:	fe843703          	ld	a4,-24(s0)
    800056e0:	97ba                	add	a5,a5,a4
    800056e2:	0587c783          	lbu	a5,88(a5) # 2058 <_entry-0x7fffdfa8>
    800056e6:	2781                	sext.w	a5,a5
    800056e8:	fe042703          	lw	a4,-32(s0)
    800056ec:	8ff9                	and	a5,a5,a4
    800056ee:	2781                	sext.w	a5,a5
    800056f0:	eb89                	bnez	a5,80005702 <bfree+0x9e>
    panic("freeing free block");
    800056f2:	00006517          	auipc	a0,0x6
    800056f6:	f1e50513          	addi	a0,a0,-226 # 8000b610 <etext+0x610>
    800056fa:	ffffb097          	auipc	ra,0xffffb
    800056fe:	580080e7          	jalr	1408(ra) # 80000c7a <panic>
  bp->data[bi/8] &= ~m;
    80005702:	fe442783          	lw	a5,-28(s0)
    80005706:	41f7d71b          	sraiw	a4,a5,0x1f
    8000570a:	01d7571b          	srliw	a4,a4,0x1d
    8000570e:	9fb9                	addw	a5,a5,a4
    80005710:	4037d79b          	sraiw	a5,a5,0x3
    80005714:	2781                	sext.w	a5,a5
    80005716:	fe843703          	ld	a4,-24(s0)
    8000571a:	973e                	add	a4,a4,a5
    8000571c:	05874703          	lbu	a4,88(a4)
    80005720:	0187169b          	slliw	a3,a4,0x18
    80005724:	4186d69b          	sraiw	a3,a3,0x18
    80005728:	fe042703          	lw	a4,-32(s0)
    8000572c:	0187171b          	slliw	a4,a4,0x18
    80005730:	4187571b          	sraiw	a4,a4,0x18
    80005734:	fff74713          	not	a4,a4
    80005738:	0187171b          	slliw	a4,a4,0x18
    8000573c:	4187571b          	sraiw	a4,a4,0x18
    80005740:	8f75                	and	a4,a4,a3
    80005742:	0187171b          	slliw	a4,a4,0x18
    80005746:	4187571b          	sraiw	a4,a4,0x18
    8000574a:	0ff77713          	zext.b	a4,a4
    8000574e:	fe843683          	ld	a3,-24(s0)
    80005752:	97b6                	add	a5,a5,a3
    80005754:	04e78c23          	sb	a4,88(a5)
  log_write(bp);
    80005758:	fe843503          	ld	a0,-24(s0)
    8000575c:	00001097          	auipc	ra,0x1
    80005760:	72e080e7          	jalr	1838(ra) # 80006e8a <log_write>
  brelse(bp);
    80005764:	fe843503          	ld	a0,-24(s0)
    80005768:	00000097          	auipc	ra,0x0
    8000576c:	aae080e7          	jalr	-1362(ra) # 80005216 <brelse>
}
    80005770:	0001                	nop
    80005772:	70a2                	ld	ra,40(sp)
    80005774:	7402                	ld	s0,32(sp)
    80005776:	6145                	addi	sp,sp,48
    80005778:	8082                	ret

000000008000577a <iinit>:
  struct inode inode[NINODE];
} itable;

void
iinit()
{
    8000577a:	1101                	addi	sp,sp,-32
    8000577c:	ec06                	sd	ra,24(sp)
    8000577e:	e822                	sd	s0,16(sp)
    80005780:	1000                	addi	s0,sp,32
  int i = 0;
    80005782:	fe042623          	sw	zero,-20(s0)
  
  initlock(&itable.lock, "itable");
    80005786:	00006597          	auipc	a1,0x6
    8000578a:	ea258593          	addi	a1,a1,-350 # 8000b628 <etext+0x628>
    8000578e:	0049e517          	auipc	a0,0x49e
    80005792:	a3250513          	addi	a0,a0,-1486 # 804a31c0 <itable>
    80005796:	ffffc097          	auipc	ra,0xffffc
    8000579a:	aa4080e7          	jalr	-1372(ra) # 8000123a <initlock>
  for(i = 0; i < NINODE; i++) {
    8000579e:	fe042623          	sw	zero,-20(s0)
    800057a2:	a82d                	j	800057dc <iinit+0x62>
    initsleeplock(&itable.inode[i].lock, "inode");
    800057a4:	fec42703          	lw	a4,-20(s0)
    800057a8:	87ba                	mv	a5,a4
    800057aa:	0792                	slli	a5,a5,0x4
    800057ac:	97ba                	add	a5,a5,a4
    800057ae:	078e                	slli	a5,a5,0x3
    800057b0:	02078713          	addi	a4,a5,32
    800057b4:	0049e797          	auipc	a5,0x49e
    800057b8:	a0c78793          	addi	a5,a5,-1524 # 804a31c0 <itable>
    800057bc:	97ba                	add	a5,a5,a4
    800057be:	07a1                	addi	a5,a5,8
    800057c0:	00006597          	auipc	a1,0x6
    800057c4:	e7058593          	addi	a1,a1,-400 # 8000b630 <etext+0x630>
    800057c8:	853e                	mv	a0,a5
    800057ca:	00001097          	auipc	ra,0x1
    800057ce:	7f4080e7          	jalr	2036(ra) # 80006fbe <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    800057d2:	fec42783          	lw	a5,-20(s0)
    800057d6:	2785                	addiw	a5,a5,1
    800057d8:	fef42623          	sw	a5,-20(s0)
    800057dc:	fec42783          	lw	a5,-20(s0)
    800057e0:	0007871b          	sext.w	a4,a5
    800057e4:	03100793          	li	a5,49
    800057e8:	fae7dee3          	bge	a5,a4,800057a4 <iinit+0x2a>
  }
}
    800057ec:	0001                	nop
    800057ee:	0001                	nop
    800057f0:	60e2                	ld	ra,24(sp)
    800057f2:	6442                	ld	s0,16(sp)
    800057f4:	6105                	addi	sp,sp,32
    800057f6:	8082                	ret

00000000800057f8 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
    800057f8:	7139                	addi	sp,sp,-64
    800057fa:	fc06                	sd	ra,56(sp)
    800057fc:	f822                	sd	s0,48(sp)
    800057fe:	0080                	addi	s0,sp,64
    80005800:	87aa                	mv	a5,a0
    80005802:	872e                	mv	a4,a1
    80005804:	fcf42623          	sw	a5,-52(s0)
    80005808:	87ba                	mv	a5,a4
    8000580a:	fcf41523          	sh	a5,-54(s0)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    8000580e:	4785                	li	a5,1
    80005810:	fef42623          	sw	a5,-20(s0)
    80005814:	a855                	j	800058c8 <ialloc+0xd0>
    bp = bread(dev, IBLOCK(inum, sb));
    80005816:	fec42783          	lw	a5,-20(s0)
    8000581a:	8391                	srli	a5,a5,0x4
    8000581c:	0007871b          	sext.w	a4,a5
    80005820:	0049e797          	auipc	a5,0x49e
    80005824:	98078793          	addi	a5,a5,-1664 # 804a31a0 <sb>
    80005828:	4f9c                	lw	a5,24(a5)
    8000582a:	9fb9                	addw	a5,a5,a4
    8000582c:	0007871b          	sext.w	a4,a5
    80005830:	fcc42783          	lw	a5,-52(s0)
    80005834:	85ba                	mv	a1,a4
    80005836:	853e                	mv	a0,a5
    80005838:	00000097          	auipc	ra,0x0
    8000583c:	93c080e7          	jalr	-1732(ra) # 80005174 <bread>
    80005840:	fea43023          	sd	a0,-32(s0)
    dip = (struct dinode*)bp->data + inum%IPB;
    80005844:	fe043783          	ld	a5,-32(s0)
    80005848:	05878713          	addi	a4,a5,88
    8000584c:	fec42783          	lw	a5,-20(s0)
    80005850:	8bbd                	andi	a5,a5,15
    80005852:	079a                	slli	a5,a5,0x6
    80005854:	97ba                	add	a5,a5,a4
    80005856:	fcf43c23          	sd	a5,-40(s0)
    if(dip->type == 0){  // a free inode
    8000585a:	fd843783          	ld	a5,-40(s0)
    8000585e:	00079783          	lh	a5,0(a5)
    80005862:	eba1                	bnez	a5,800058b2 <ialloc+0xba>
      memset(dip, 0, sizeof(*dip));
    80005864:	04000613          	li	a2,64
    80005868:	4581                	li	a1,0
    8000586a:	fd843503          	ld	a0,-40(s0)
    8000586e:	ffffc097          	auipc	ra,0xffffc
    80005872:	bd0080e7          	jalr	-1072(ra) # 8000143e <memset>
      dip->type = type;
    80005876:	fd843783          	ld	a5,-40(s0)
    8000587a:	fca45703          	lhu	a4,-54(s0)
    8000587e:	00e79023          	sh	a4,0(a5)
      log_write(bp);   // mark it allocated on the disk
    80005882:	fe043503          	ld	a0,-32(s0)
    80005886:	00001097          	auipc	ra,0x1
    8000588a:	604080e7          	jalr	1540(ra) # 80006e8a <log_write>
      brelse(bp);
    8000588e:	fe043503          	ld	a0,-32(s0)
    80005892:	00000097          	auipc	ra,0x0
    80005896:	984080e7          	jalr	-1660(ra) # 80005216 <brelse>
      return iget(dev, inum);
    8000589a:	fec42703          	lw	a4,-20(s0)
    8000589e:	fcc42783          	lw	a5,-52(s0)
    800058a2:	85ba                	mv	a1,a4
    800058a4:	853e                	mv	a0,a5
    800058a6:	00000097          	auipc	ra,0x0
    800058aa:	136080e7          	jalr	310(ra) # 800059dc <iget>
    800058ae:	87aa                	mv	a5,a0
    800058b0:	a82d                	j	800058ea <ialloc+0xf2>
    }
    brelse(bp);
    800058b2:	fe043503          	ld	a0,-32(s0)
    800058b6:	00000097          	auipc	ra,0x0
    800058ba:	960080e7          	jalr	-1696(ra) # 80005216 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    800058be:	fec42783          	lw	a5,-20(s0)
    800058c2:	2785                	addiw	a5,a5,1
    800058c4:	fef42623          	sw	a5,-20(s0)
    800058c8:	0049e797          	auipc	a5,0x49e
    800058cc:	8d878793          	addi	a5,a5,-1832 # 804a31a0 <sb>
    800058d0:	47d8                	lw	a4,12(a5)
    800058d2:	fec42783          	lw	a5,-20(s0)
    800058d6:	f4e7e0e3          	bltu	a5,a4,80005816 <ialloc+0x1e>
  }
  panic("ialloc: no inodes");
    800058da:	00006517          	auipc	a0,0x6
    800058de:	d5e50513          	addi	a0,a0,-674 # 8000b638 <etext+0x638>
    800058e2:	ffffb097          	auipc	ra,0xffffb
    800058e6:	398080e7          	jalr	920(ra) # 80000c7a <panic>
}
    800058ea:	853e                	mv	a0,a5
    800058ec:	70e2                	ld	ra,56(sp)
    800058ee:	7442                	ld	s0,48(sp)
    800058f0:	6121                	addi	sp,sp,64
    800058f2:	8082                	ret

00000000800058f4 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
    800058f4:	7179                	addi	sp,sp,-48
    800058f6:	f406                	sd	ra,40(sp)
    800058f8:	f022                	sd	s0,32(sp)
    800058fa:	1800                	addi	s0,sp,48
    800058fc:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80005900:	fd843783          	ld	a5,-40(s0)
    80005904:	4394                	lw	a3,0(a5)
    80005906:	fd843783          	ld	a5,-40(s0)
    8000590a:	43dc                	lw	a5,4(a5)
    8000590c:	0047d79b          	srliw	a5,a5,0x4
    80005910:	0007871b          	sext.w	a4,a5
    80005914:	0049e797          	auipc	a5,0x49e
    80005918:	88c78793          	addi	a5,a5,-1908 # 804a31a0 <sb>
    8000591c:	4f9c                	lw	a5,24(a5)
    8000591e:	9fb9                	addw	a5,a5,a4
    80005920:	2781                	sext.w	a5,a5
    80005922:	85be                	mv	a1,a5
    80005924:	8536                	mv	a0,a3
    80005926:	00000097          	auipc	ra,0x0
    8000592a:	84e080e7          	jalr	-1970(ra) # 80005174 <bread>
    8000592e:	fea43423          	sd	a0,-24(s0)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80005932:	fe843783          	ld	a5,-24(s0)
    80005936:	05878713          	addi	a4,a5,88
    8000593a:	fd843783          	ld	a5,-40(s0)
    8000593e:	43dc                	lw	a5,4(a5)
    80005940:	1782                	slli	a5,a5,0x20
    80005942:	9381                	srli	a5,a5,0x20
    80005944:	8bbd                	andi	a5,a5,15
    80005946:	079a                	slli	a5,a5,0x6
    80005948:	97ba                	add	a5,a5,a4
    8000594a:	fef43023          	sd	a5,-32(s0)
  dip->type = ip->type;
    8000594e:	fd843783          	ld	a5,-40(s0)
    80005952:	04479703          	lh	a4,68(a5)
    80005956:	fe043783          	ld	a5,-32(s0)
    8000595a:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    8000595e:	fd843783          	ld	a5,-40(s0)
    80005962:	04679703          	lh	a4,70(a5)
    80005966:	fe043783          	ld	a5,-32(s0)
    8000596a:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    8000596e:	fd843783          	ld	a5,-40(s0)
    80005972:	04879703          	lh	a4,72(a5)
    80005976:	fe043783          	ld	a5,-32(s0)
    8000597a:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    8000597e:	fd843783          	ld	a5,-40(s0)
    80005982:	04a79703          	lh	a4,74(a5)
    80005986:	fe043783          	ld	a5,-32(s0)
    8000598a:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    8000598e:	fd843783          	ld	a5,-40(s0)
    80005992:	47f8                	lw	a4,76(a5)
    80005994:	fe043783          	ld	a5,-32(s0)
    80005998:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    8000599a:	fe043783          	ld	a5,-32(s0)
    8000599e:	00c78713          	addi	a4,a5,12
    800059a2:	fd843783          	ld	a5,-40(s0)
    800059a6:	05078793          	addi	a5,a5,80
    800059aa:	03400613          	li	a2,52
    800059ae:	85be                	mv	a1,a5
    800059b0:	853a                	mv	a0,a4
    800059b2:	ffffc097          	auipc	ra,0xffffc
    800059b6:	b70080e7          	jalr	-1168(ra) # 80001522 <memmove>
  log_write(bp);
    800059ba:	fe843503          	ld	a0,-24(s0)
    800059be:	00001097          	auipc	ra,0x1
    800059c2:	4cc080e7          	jalr	1228(ra) # 80006e8a <log_write>
  brelse(bp);
    800059c6:	fe843503          	ld	a0,-24(s0)
    800059ca:	00000097          	auipc	ra,0x0
    800059ce:	84c080e7          	jalr	-1972(ra) # 80005216 <brelse>
}
    800059d2:	0001                	nop
    800059d4:	70a2                	ld	ra,40(sp)
    800059d6:	7402                	ld	s0,32(sp)
    800059d8:	6145                	addi	sp,sp,48
    800059da:	8082                	ret

00000000800059dc <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
    800059dc:	7179                	addi	sp,sp,-48
    800059de:	f406                	sd	ra,40(sp)
    800059e0:	f022                	sd	s0,32(sp)
    800059e2:	1800                	addi	s0,sp,48
    800059e4:	87aa                	mv	a5,a0
    800059e6:	872e                	mv	a4,a1
    800059e8:	fcf42e23          	sw	a5,-36(s0)
    800059ec:	87ba                	mv	a5,a4
    800059ee:	fcf42c23          	sw	a5,-40(s0)
  struct inode *ip, *empty;

  acquire(&itable.lock);
    800059f2:	0049d517          	auipc	a0,0x49d
    800059f6:	7ce50513          	addi	a0,a0,1998 # 804a31c0 <itable>
    800059fa:	ffffc097          	auipc	ra,0xffffc
    800059fe:	870080e7          	jalr	-1936(ra) # 8000126a <acquire>

  // Is the inode already in the table?
  empty = 0;
    80005a02:	fe043023          	sd	zero,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80005a06:	0049d797          	auipc	a5,0x49d
    80005a0a:	7d278793          	addi	a5,a5,2002 # 804a31d8 <itable+0x18>
    80005a0e:	fef43423          	sd	a5,-24(s0)
    80005a12:	a89d                	j	80005a88 <iget+0xac>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80005a14:	fe843783          	ld	a5,-24(s0)
    80005a18:	479c                	lw	a5,8(a5)
    80005a1a:	04f05663          	blez	a5,80005a66 <iget+0x8a>
    80005a1e:	fe843783          	ld	a5,-24(s0)
    80005a22:	4398                	lw	a4,0(a5)
    80005a24:	fdc42783          	lw	a5,-36(s0)
    80005a28:	2781                	sext.w	a5,a5
    80005a2a:	02e79e63          	bne	a5,a4,80005a66 <iget+0x8a>
    80005a2e:	fe843783          	ld	a5,-24(s0)
    80005a32:	43d8                	lw	a4,4(a5)
    80005a34:	fd842783          	lw	a5,-40(s0)
    80005a38:	2781                	sext.w	a5,a5
    80005a3a:	02e79663          	bne	a5,a4,80005a66 <iget+0x8a>
      ip->ref++;
    80005a3e:	fe843783          	ld	a5,-24(s0)
    80005a42:	479c                	lw	a5,8(a5)
    80005a44:	2785                	addiw	a5,a5,1
    80005a46:	0007871b          	sext.w	a4,a5
    80005a4a:	fe843783          	ld	a5,-24(s0)
    80005a4e:	c798                	sw	a4,8(a5)
      release(&itable.lock);
    80005a50:	0049d517          	auipc	a0,0x49d
    80005a54:	77050513          	addi	a0,a0,1904 # 804a31c0 <itable>
    80005a58:	ffffc097          	auipc	ra,0xffffc
    80005a5c:	876080e7          	jalr	-1930(ra) # 800012ce <release>
      return ip;
    80005a60:	fe843783          	ld	a5,-24(s0)
    80005a64:	a069                	j	80005aee <iget+0x112>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80005a66:	fe043783          	ld	a5,-32(s0)
    80005a6a:	eb89                	bnez	a5,80005a7c <iget+0xa0>
    80005a6c:	fe843783          	ld	a5,-24(s0)
    80005a70:	479c                	lw	a5,8(a5)
    80005a72:	e789                	bnez	a5,80005a7c <iget+0xa0>
      empty = ip;
    80005a74:	fe843783          	ld	a5,-24(s0)
    80005a78:	fef43023          	sd	a5,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80005a7c:	fe843783          	ld	a5,-24(s0)
    80005a80:	08878793          	addi	a5,a5,136
    80005a84:	fef43423          	sd	a5,-24(s0)
    80005a88:	fe843703          	ld	a4,-24(s0)
    80005a8c:	0049f797          	auipc	a5,0x49f
    80005a90:	1dc78793          	addi	a5,a5,476 # 804a4c68 <log>
    80005a94:	f8f760e3          	bltu	a4,a5,80005a14 <iget+0x38>
  }

  // Recycle an inode entry.
  if(empty == 0)
    80005a98:	fe043783          	ld	a5,-32(s0)
    80005a9c:	eb89                	bnez	a5,80005aae <iget+0xd2>
    panic("iget: no inodes");
    80005a9e:	00006517          	auipc	a0,0x6
    80005aa2:	bb250513          	addi	a0,a0,-1102 # 8000b650 <etext+0x650>
    80005aa6:	ffffb097          	auipc	ra,0xffffb
    80005aaa:	1d4080e7          	jalr	468(ra) # 80000c7a <panic>

  ip = empty;
    80005aae:	fe043783          	ld	a5,-32(s0)
    80005ab2:	fef43423          	sd	a5,-24(s0)
  ip->dev = dev;
    80005ab6:	fe843783          	ld	a5,-24(s0)
    80005aba:	fdc42703          	lw	a4,-36(s0)
    80005abe:	c398                	sw	a4,0(a5)
  ip->inum = inum;
    80005ac0:	fe843783          	ld	a5,-24(s0)
    80005ac4:	fd842703          	lw	a4,-40(s0)
    80005ac8:	c3d8                	sw	a4,4(a5)
  ip->ref = 1;
    80005aca:	fe843783          	ld	a5,-24(s0)
    80005ace:	4705                	li	a4,1
    80005ad0:	c798                	sw	a4,8(a5)
  ip->valid = 0;
    80005ad2:	fe843783          	ld	a5,-24(s0)
    80005ad6:	0407a023          	sw	zero,64(a5)
  release(&itable.lock);
    80005ada:	0049d517          	auipc	a0,0x49d
    80005ade:	6e650513          	addi	a0,a0,1766 # 804a31c0 <itable>
    80005ae2:	ffffb097          	auipc	ra,0xffffb
    80005ae6:	7ec080e7          	jalr	2028(ra) # 800012ce <release>

  return ip;
    80005aea:	fe843783          	ld	a5,-24(s0)
}
    80005aee:	853e                	mv	a0,a5
    80005af0:	70a2                	ld	ra,40(sp)
    80005af2:	7402                	ld	s0,32(sp)
    80005af4:	6145                	addi	sp,sp,48
    80005af6:	8082                	ret

0000000080005af8 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
    80005af8:	1101                	addi	sp,sp,-32
    80005afa:	ec06                	sd	ra,24(sp)
    80005afc:	e822                	sd	s0,16(sp)
    80005afe:	1000                	addi	s0,sp,32
    80005b00:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    80005b04:	0049d517          	auipc	a0,0x49d
    80005b08:	6bc50513          	addi	a0,a0,1724 # 804a31c0 <itable>
    80005b0c:	ffffb097          	auipc	ra,0xffffb
    80005b10:	75e080e7          	jalr	1886(ra) # 8000126a <acquire>
  ip->ref++;
    80005b14:	fe843783          	ld	a5,-24(s0)
    80005b18:	479c                	lw	a5,8(a5)
    80005b1a:	2785                	addiw	a5,a5,1
    80005b1c:	0007871b          	sext.w	a4,a5
    80005b20:	fe843783          	ld	a5,-24(s0)
    80005b24:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80005b26:	0049d517          	auipc	a0,0x49d
    80005b2a:	69a50513          	addi	a0,a0,1690 # 804a31c0 <itable>
    80005b2e:	ffffb097          	auipc	ra,0xffffb
    80005b32:	7a0080e7          	jalr	1952(ra) # 800012ce <release>
  return ip;
    80005b36:	fe843783          	ld	a5,-24(s0)
}
    80005b3a:	853e                	mv	a0,a5
    80005b3c:	60e2                	ld	ra,24(sp)
    80005b3e:	6442                	ld	s0,16(sp)
    80005b40:	6105                	addi	sp,sp,32
    80005b42:	8082                	ret

0000000080005b44 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
    80005b44:	7179                	addi	sp,sp,-48
    80005b46:	f406                	sd	ra,40(sp)
    80005b48:	f022                	sd	s0,32(sp)
    80005b4a:	1800                	addi	s0,sp,48
    80005b4c:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    80005b50:	fd843783          	ld	a5,-40(s0)
    80005b54:	c791                	beqz	a5,80005b60 <ilock+0x1c>
    80005b56:	fd843783          	ld	a5,-40(s0)
    80005b5a:	479c                	lw	a5,8(a5)
    80005b5c:	00f04a63          	bgtz	a5,80005b70 <ilock+0x2c>
    panic("ilock");
    80005b60:	00006517          	auipc	a0,0x6
    80005b64:	b0050513          	addi	a0,a0,-1280 # 8000b660 <etext+0x660>
    80005b68:	ffffb097          	auipc	ra,0xffffb
    80005b6c:	112080e7          	jalr	274(ra) # 80000c7a <panic>

  acquiresleep(&ip->lock);
    80005b70:	fd843783          	ld	a5,-40(s0)
    80005b74:	07c1                	addi	a5,a5,16
    80005b76:	853e                	mv	a0,a5
    80005b78:	00001097          	auipc	ra,0x1
    80005b7c:	492080e7          	jalr	1170(ra) # 8000700a <acquiresleep>

  if(ip->valid == 0){
    80005b80:	fd843783          	ld	a5,-40(s0)
    80005b84:	43bc                	lw	a5,64(a5)
    80005b86:	e7e5                	bnez	a5,80005c6e <ilock+0x12a>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80005b88:	fd843783          	ld	a5,-40(s0)
    80005b8c:	4394                	lw	a3,0(a5)
    80005b8e:	fd843783          	ld	a5,-40(s0)
    80005b92:	43dc                	lw	a5,4(a5)
    80005b94:	0047d79b          	srliw	a5,a5,0x4
    80005b98:	0007871b          	sext.w	a4,a5
    80005b9c:	0049d797          	auipc	a5,0x49d
    80005ba0:	60478793          	addi	a5,a5,1540 # 804a31a0 <sb>
    80005ba4:	4f9c                	lw	a5,24(a5)
    80005ba6:	9fb9                	addw	a5,a5,a4
    80005ba8:	2781                	sext.w	a5,a5
    80005baa:	85be                	mv	a1,a5
    80005bac:	8536                	mv	a0,a3
    80005bae:	fffff097          	auipc	ra,0xfffff
    80005bb2:	5c6080e7          	jalr	1478(ra) # 80005174 <bread>
    80005bb6:	fea43423          	sd	a0,-24(s0)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80005bba:	fe843783          	ld	a5,-24(s0)
    80005bbe:	05878713          	addi	a4,a5,88
    80005bc2:	fd843783          	ld	a5,-40(s0)
    80005bc6:	43dc                	lw	a5,4(a5)
    80005bc8:	1782                	slli	a5,a5,0x20
    80005bca:	9381                	srli	a5,a5,0x20
    80005bcc:	8bbd                	andi	a5,a5,15
    80005bce:	079a                	slli	a5,a5,0x6
    80005bd0:	97ba                	add	a5,a5,a4
    80005bd2:	fef43023          	sd	a5,-32(s0)
    ip->type = dip->type;
    80005bd6:	fe043783          	ld	a5,-32(s0)
    80005bda:	00079703          	lh	a4,0(a5)
    80005bde:	fd843783          	ld	a5,-40(s0)
    80005be2:	04e79223          	sh	a4,68(a5)
    ip->major = dip->major;
    80005be6:	fe043783          	ld	a5,-32(s0)
    80005bea:	00279703          	lh	a4,2(a5)
    80005bee:	fd843783          	ld	a5,-40(s0)
    80005bf2:	04e79323          	sh	a4,70(a5)
    ip->minor = dip->minor;
    80005bf6:	fe043783          	ld	a5,-32(s0)
    80005bfa:	00479703          	lh	a4,4(a5)
    80005bfe:	fd843783          	ld	a5,-40(s0)
    80005c02:	04e79423          	sh	a4,72(a5)
    ip->nlink = dip->nlink;
    80005c06:	fe043783          	ld	a5,-32(s0)
    80005c0a:	00679703          	lh	a4,6(a5)
    80005c0e:	fd843783          	ld	a5,-40(s0)
    80005c12:	04e79523          	sh	a4,74(a5)
    ip->size = dip->size;
    80005c16:	fe043783          	ld	a5,-32(s0)
    80005c1a:	4798                	lw	a4,8(a5)
    80005c1c:	fd843783          	ld	a5,-40(s0)
    80005c20:	c7f8                	sw	a4,76(a5)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80005c22:	fd843783          	ld	a5,-40(s0)
    80005c26:	05078713          	addi	a4,a5,80
    80005c2a:	fe043783          	ld	a5,-32(s0)
    80005c2e:	07b1                	addi	a5,a5,12
    80005c30:	03400613          	li	a2,52
    80005c34:	85be                	mv	a1,a5
    80005c36:	853a                	mv	a0,a4
    80005c38:	ffffc097          	auipc	ra,0xffffc
    80005c3c:	8ea080e7          	jalr	-1814(ra) # 80001522 <memmove>
    brelse(bp);
    80005c40:	fe843503          	ld	a0,-24(s0)
    80005c44:	fffff097          	auipc	ra,0xfffff
    80005c48:	5d2080e7          	jalr	1490(ra) # 80005216 <brelse>
    ip->valid = 1;
    80005c4c:	fd843783          	ld	a5,-40(s0)
    80005c50:	4705                	li	a4,1
    80005c52:	c3b8                	sw	a4,64(a5)
    if(ip->type == 0)
    80005c54:	fd843783          	ld	a5,-40(s0)
    80005c58:	04479783          	lh	a5,68(a5)
    80005c5c:	eb89                	bnez	a5,80005c6e <ilock+0x12a>
      panic("ilock: no type");
    80005c5e:	00006517          	auipc	a0,0x6
    80005c62:	a0a50513          	addi	a0,a0,-1526 # 8000b668 <etext+0x668>
    80005c66:	ffffb097          	auipc	ra,0xffffb
    80005c6a:	014080e7          	jalr	20(ra) # 80000c7a <panic>
  }
}
    80005c6e:	0001                	nop
    80005c70:	70a2                	ld	ra,40(sp)
    80005c72:	7402                	ld	s0,32(sp)
    80005c74:	6145                	addi	sp,sp,48
    80005c76:	8082                	ret

0000000080005c78 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
    80005c78:	1101                	addi	sp,sp,-32
    80005c7a:	ec06                	sd	ra,24(sp)
    80005c7c:	e822                	sd	s0,16(sp)
    80005c7e:	1000                	addi	s0,sp,32
    80005c80:	fea43423          	sd	a0,-24(s0)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80005c84:	fe843783          	ld	a5,-24(s0)
    80005c88:	c385                	beqz	a5,80005ca8 <iunlock+0x30>
    80005c8a:	fe843783          	ld	a5,-24(s0)
    80005c8e:	07c1                	addi	a5,a5,16
    80005c90:	853e                	mv	a0,a5
    80005c92:	00001097          	auipc	ra,0x1
    80005c96:	438080e7          	jalr	1080(ra) # 800070ca <holdingsleep>
    80005c9a:	87aa                	mv	a5,a0
    80005c9c:	c791                	beqz	a5,80005ca8 <iunlock+0x30>
    80005c9e:	fe843783          	ld	a5,-24(s0)
    80005ca2:	479c                	lw	a5,8(a5)
    80005ca4:	00f04a63          	bgtz	a5,80005cb8 <iunlock+0x40>
    panic("iunlock");
    80005ca8:	00006517          	auipc	a0,0x6
    80005cac:	9d050513          	addi	a0,a0,-1584 # 8000b678 <etext+0x678>
    80005cb0:	ffffb097          	auipc	ra,0xffffb
    80005cb4:	fca080e7          	jalr	-54(ra) # 80000c7a <panic>

  releasesleep(&ip->lock);
    80005cb8:	fe843783          	ld	a5,-24(s0)
    80005cbc:	07c1                	addi	a5,a5,16
    80005cbe:	853e                	mv	a0,a5
    80005cc0:	00001097          	auipc	ra,0x1
    80005cc4:	3b8080e7          	jalr	952(ra) # 80007078 <releasesleep>
}
    80005cc8:	0001                	nop
    80005cca:	60e2                	ld	ra,24(sp)
    80005ccc:	6442                	ld	s0,16(sp)
    80005cce:	6105                	addi	sp,sp,32
    80005cd0:	8082                	ret

0000000080005cd2 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
    80005cd2:	1101                	addi	sp,sp,-32
    80005cd4:	ec06                	sd	ra,24(sp)
    80005cd6:	e822                	sd	s0,16(sp)
    80005cd8:	1000                	addi	s0,sp,32
    80005cda:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    80005cde:	0049d517          	auipc	a0,0x49d
    80005ce2:	4e250513          	addi	a0,a0,1250 # 804a31c0 <itable>
    80005ce6:	ffffb097          	auipc	ra,0xffffb
    80005cea:	584080e7          	jalr	1412(ra) # 8000126a <acquire>

  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80005cee:	fe843783          	ld	a5,-24(s0)
    80005cf2:	479c                	lw	a5,8(a5)
    80005cf4:	873e                	mv	a4,a5
    80005cf6:	4785                	li	a5,1
    80005cf8:	06f71f63          	bne	a4,a5,80005d76 <iput+0xa4>
    80005cfc:	fe843783          	ld	a5,-24(s0)
    80005d00:	43bc                	lw	a5,64(a5)
    80005d02:	cbb5                	beqz	a5,80005d76 <iput+0xa4>
    80005d04:	fe843783          	ld	a5,-24(s0)
    80005d08:	04a79783          	lh	a5,74(a5)
    80005d0c:	e7ad                	bnez	a5,80005d76 <iput+0xa4>
    // inode has no links and no other references: truncate and free.

    // ip->ref == 1 means no other process can have ip locked,
    // so this acquiresleep() won't block (or deadlock).
    acquiresleep(&ip->lock);
    80005d0e:	fe843783          	ld	a5,-24(s0)
    80005d12:	07c1                	addi	a5,a5,16
    80005d14:	853e                	mv	a0,a5
    80005d16:	00001097          	auipc	ra,0x1
    80005d1a:	2f4080e7          	jalr	756(ra) # 8000700a <acquiresleep>

    release(&itable.lock);
    80005d1e:	0049d517          	auipc	a0,0x49d
    80005d22:	4a250513          	addi	a0,a0,1186 # 804a31c0 <itable>
    80005d26:	ffffb097          	auipc	ra,0xffffb
    80005d2a:	5a8080e7          	jalr	1448(ra) # 800012ce <release>

    itrunc(ip);
    80005d2e:	fe843503          	ld	a0,-24(s0)
    80005d32:	00000097          	auipc	ra,0x0
    80005d36:	1fa080e7          	jalr	506(ra) # 80005f2c <itrunc>
    ip->type = 0;
    80005d3a:	fe843783          	ld	a5,-24(s0)
    80005d3e:	04079223          	sh	zero,68(a5)
    iupdate(ip);
    80005d42:	fe843503          	ld	a0,-24(s0)
    80005d46:	00000097          	auipc	ra,0x0
    80005d4a:	bae080e7          	jalr	-1106(ra) # 800058f4 <iupdate>
    ip->valid = 0;
    80005d4e:	fe843783          	ld	a5,-24(s0)
    80005d52:	0407a023          	sw	zero,64(a5)

    releasesleep(&ip->lock);
    80005d56:	fe843783          	ld	a5,-24(s0)
    80005d5a:	07c1                	addi	a5,a5,16
    80005d5c:	853e                	mv	a0,a5
    80005d5e:	00001097          	auipc	ra,0x1
    80005d62:	31a080e7          	jalr	794(ra) # 80007078 <releasesleep>

    acquire(&itable.lock);
    80005d66:	0049d517          	auipc	a0,0x49d
    80005d6a:	45a50513          	addi	a0,a0,1114 # 804a31c0 <itable>
    80005d6e:	ffffb097          	auipc	ra,0xffffb
    80005d72:	4fc080e7          	jalr	1276(ra) # 8000126a <acquire>
  }

  ip->ref--;
    80005d76:	fe843783          	ld	a5,-24(s0)
    80005d7a:	479c                	lw	a5,8(a5)
    80005d7c:	37fd                	addiw	a5,a5,-1
    80005d7e:	0007871b          	sext.w	a4,a5
    80005d82:	fe843783          	ld	a5,-24(s0)
    80005d86:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80005d88:	0049d517          	auipc	a0,0x49d
    80005d8c:	43850513          	addi	a0,a0,1080 # 804a31c0 <itable>
    80005d90:	ffffb097          	auipc	ra,0xffffb
    80005d94:	53e080e7          	jalr	1342(ra) # 800012ce <release>
}
    80005d98:	0001                	nop
    80005d9a:	60e2                	ld	ra,24(sp)
    80005d9c:	6442                	ld	s0,16(sp)
    80005d9e:	6105                	addi	sp,sp,32
    80005da0:	8082                	ret

0000000080005da2 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
    80005da2:	1101                	addi	sp,sp,-32
    80005da4:	ec06                	sd	ra,24(sp)
    80005da6:	e822                	sd	s0,16(sp)
    80005da8:	1000                	addi	s0,sp,32
    80005daa:	fea43423          	sd	a0,-24(s0)
  iunlock(ip);
    80005dae:	fe843503          	ld	a0,-24(s0)
    80005db2:	00000097          	auipc	ra,0x0
    80005db6:	ec6080e7          	jalr	-314(ra) # 80005c78 <iunlock>
  iput(ip);
    80005dba:	fe843503          	ld	a0,-24(s0)
    80005dbe:	00000097          	auipc	ra,0x0
    80005dc2:	f14080e7          	jalr	-236(ra) # 80005cd2 <iput>
}
    80005dc6:	0001                	nop
    80005dc8:	60e2                	ld	ra,24(sp)
    80005dca:	6442                	ld	s0,16(sp)
    80005dcc:	6105                	addi	sp,sp,32
    80005dce:	8082                	ret

0000000080005dd0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80005dd0:	7139                	addi	sp,sp,-64
    80005dd2:	fc06                	sd	ra,56(sp)
    80005dd4:	f822                	sd	s0,48(sp)
    80005dd6:	0080                	addi	s0,sp,64
    80005dd8:	fca43423          	sd	a0,-56(s0)
    80005ddc:	87ae                	mv	a5,a1
    80005dde:	fcf42223          	sw	a5,-60(s0)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80005de2:	fc442783          	lw	a5,-60(s0)
    80005de6:	0007871b          	sext.w	a4,a5
    80005dea:	47ad                	li	a5,11
    80005dec:	04e7e863          	bltu	a5,a4,80005e3c <bmap+0x6c>
    if((addr = ip->addrs[bn]) == 0)
    80005df0:	fc843703          	ld	a4,-56(s0)
    80005df4:	fc446783          	lwu	a5,-60(s0)
    80005df8:	07d1                	addi	a5,a5,20
    80005dfa:	078a                	slli	a5,a5,0x2
    80005dfc:	97ba                	add	a5,a5,a4
    80005dfe:	439c                	lw	a5,0(a5)
    80005e00:	fef42623          	sw	a5,-20(s0)
    80005e04:	fec42783          	lw	a5,-20(s0)
    80005e08:	2781                	sext.w	a5,a5
    80005e0a:	e795                	bnez	a5,80005e36 <bmap+0x66>
      ip->addrs[bn] = addr = balloc(ip->dev);
    80005e0c:	fc843783          	ld	a5,-56(s0)
    80005e10:	439c                	lw	a5,0(a5)
    80005e12:	853e                	mv	a0,a5
    80005e14:	fffff097          	auipc	ra,0xfffff
    80005e18:	6aa080e7          	jalr	1706(ra) # 800054be <balloc>
    80005e1c:	87aa                	mv	a5,a0
    80005e1e:	fef42623          	sw	a5,-20(s0)
    80005e22:	fc843703          	ld	a4,-56(s0)
    80005e26:	fc446783          	lwu	a5,-60(s0)
    80005e2a:	07d1                	addi	a5,a5,20
    80005e2c:	078a                	slli	a5,a5,0x2
    80005e2e:	97ba                	add	a5,a5,a4
    80005e30:	fec42703          	lw	a4,-20(s0)
    80005e34:	c398                	sw	a4,0(a5)
    return addr;
    80005e36:	fec42783          	lw	a5,-20(s0)
    80005e3a:	a0e5                	j	80005f22 <bmap+0x152>
  }
  bn -= NDIRECT;
    80005e3c:	fc442783          	lw	a5,-60(s0)
    80005e40:	37d1                	addiw	a5,a5,-12
    80005e42:	fcf42223          	sw	a5,-60(s0)

  if(bn < NINDIRECT){
    80005e46:	fc442783          	lw	a5,-60(s0)
    80005e4a:	0007871b          	sext.w	a4,a5
    80005e4e:	0ff00793          	li	a5,255
    80005e52:	0ce7e063          	bltu	a5,a4,80005f12 <bmap+0x142>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80005e56:	fc843783          	ld	a5,-56(s0)
    80005e5a:	0807a783          	lw	a5,128(a5)
    80005e5e:	fef42623          	sw	a5,-20(s0)
    80005e62:	fec42783          	lw	a5,-20(s0)
    80005e66:	2781                	sext.w	a5,a5
    80005e68:	e395                	bnez	a5,80005e8c <bmap+0xbc>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80005e6a:	fc843783          	ld	a5,-56(s0)
    80005e6e:	439c                	lw	a5,0(a5)
    80005e70:	853e                	mv	a0,a5
    80005e72:	fffff097          	auipc	ra,0xfffff
    80005e76:	64c080e7          	jalr	1612(ra) # 800054be <balloc>
    80005e7a:	87aa                	mv	a5,a0
    80005e7c:	fef42623          	sw	a5,-20(s0)
    80005e80:	fc843783          	ld	a5,-56(s0)
    80005e84:	fec42703          	lw	a4,-20(s0)
    80005e88:	08e7a023          	sw	a4,128(a5)
    bp = bread(ip->dev, addr);
    80005e8c:	fc843783          	ld	a5,-56(s0)
    80005e90:	439c                	lw	a5,0(a5)
    80005e92:	fec42703          	lw	a4,-20(s0)
    80005e96:	85ba                	mv	a1,a4
    80005e98:	853e                	mv	a0,a5
    80005e9a:	fffff097          	auipc	ra,0xfffff
    80005e9e:	2da080e7          	jalr	730(ra) # 80005174 <bread>
    80005ea2:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    80005ea6:	fe043783          	ld	a5,-32(s0)
    80005eaa:	05878793          	addi	a5,a5,88
    80005eae:	fcf43c23          	sd	a5,-40(s0)
    if((addr = a[bn]) == 0){
    80005eb2:	fc446783          	lwu	a5,-60(s0)
    80005eb6:	078a                	slli	a5,a5,0x2
    80005eb8:	fd843703          	ld	a4,-40(s0)
    80005ebc:	97ba                	add	a5,a5,a4
    80005ebe:	439c                	lw	a5,0(a5)
    80005ec0:	fef42623          	sw	a5,-20(s0)
    80005ec4:	fec42783          	lw	a5,-20(s0)
    80005ec8:	2781                	sext.w	a5,a5
    80005eca:	eb9d                	bnez	a5,80005f00 <bmap+0x130>
      a[bn] = addr = balloc(ip->dev);
    80005ecc:	fc843783          	ld	a5,-56(s0)
    80005ed0:	439c                	lw	a5,0(a5)
    80005ed2:	853e                	mv	a0,a5
    80005ed4:	fffff097          	auipc	ra,0xfffff
    80005ed8:	5ea080e7          	jalr	1514(ra) # 800054be <balloc>
    80005edc:	87aa                	mv	a5,a0
    80005ede:	fef42623          	sw	a5,-20(s0)
    80005ee2:	fc446783          	lwu	a5,-60(s0)
    80005ee6:	078a                	slli	a5,a5,0x2
    80005ee8:	fd843703          	ld	a4,-40(s0)
    80005eec:	97ba                	add	a5,a5,a4
    80005eee:	fec42703          	lw	a4,-20(s0)
    80005ef2:	c398                	sw	a4,0(a5)
      log_write(bp);
    80005ef4:	fe043503          	ld	a0,-32(s0)
    80005ef8:	00001097          	auipc	ra,0x1
    80005efc:	f92080e7          	jalr	-110(ra) # 80006e8a <log_write>
    }
    brelse(bp);
    80005f00:	fe043503          	ld	a0,-32(s0)
    80005f04:	fffff097          	auipc	ra,0xfffff
    80005f08:	312080e7          	jalr	786(ra) # 80005216 <brelse>
    return addr;
    80005f0c:	fec42783          	lw	a5,-20(s0)
    80005f10:	a809                	j	80005f22 <bmap+0x152>
  }

  panic("bmap: out of range");
    80005f12:	00005517          	auipc	a0,0x5
    80005f16:	76e50513          	addi	a0,a0,1902 # 8000b680 <etext+0x680>
    80005f1a:	ffffb097          	auipc	ra,0xffffb
    80005f1e:	d60080e7          	jalr	-672(ra) # 80000c7a <panic>
}
    80005f22:	853e                	mv	a0,a5
    80005f24:	70e2                	ld	ra,56(sp)
    80005f26:	7442                	ld	s0,48(sp)
    80005f28:	6121                	addi	sp,sp,64
    80005f2a:	8082                	ret

0000000080005f2c <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80005f2c:	7139                	addi	sp,sp,-64
    80005f2e:	fc06                	sd	ra,56(sp)
    80005f30:	f822                	sd	s0,48(sp)
    80005f32:	0080                	addi	s0,sp,64
    80005f34:	fca43423          	sd	a0,-56(s0)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80005f38:	fe042623          	sw	zero,-20(s0)
    80005f3c:	a899                	j	80005f92 <itrunc+0x66>
    if(ip->addrs[i]){
    80005f3e:	fc843703          	ld	a4,-56(s0)
    80005f42:	fec42783          	lw	a5,-20(s0)
    80005f46:	07d1                	addi	a5,a5,20
    80005f48:	078a                	slli	a5,a5,0x2
    80005f4a:	97ba                	add	a5,a5,a4
    80005f4c:	439c                	lw	a5,0(a5)
    80005f4e:	cf8d                	beqz	a5,80005f88 <itrunc+0x5c>
      bfree(ip->dev, ip->addrs[i]);
    80005f50:	fc843783          	ld	a5,-56(s0)
    80005f54:	439c                	lw	a5,0(a5)
    80005f56:	0007869b          	sext.w	a3,a5
    80005f5a:	fc843703          	ld	a4,-56(s0)
    80005f5e:	fec42783          	lw	a5,-20(s0)
    80005f62:	07d1                	addi	a5,a5,20
    80005f64:	078a                	slli	a5,a5,0x2
    80005f66:	97ba                	add	a5,a5,a4
    80005f68:	439c                	lw	a5,0(a5)
    80005f6a:	85be                	mv	a1,a5
    80005f6c:	8536                	mv	a0,a3
    80005f6e:	fffff097          	auipc	ra,0xfffff
    80005f72:	6f6080e7          	jalr	1782(ra) # 80005664 <bfree>
      ip->addrs[i] = 0;
    80005f76:	fc843703          	ld	a4,-56(s0)
    80005f7a:	fec42783          	lw	a5,-20(s0)
    80005f7e:	07d1                	addi	a5,a5,20
    80005f80:	078a                	slli	a5,a5,0x2
    80005f82:	97ba                	add	a5,a5,a4
    80005f84:	0007a023          	sw	zero,0(a5)
  for(i = 0; i < NDIRECT; i++){
    80005f88:	fec42783          	lw	a5,-20(s0)
    80005f8c:	2785                	addiw	a5,a5,1
    80005f8e:	fef42623          	sw	a5,-20(s0)
    80005f92:	fec42783          	lw	a5,-20(s0)
    80005f96:	0007871b          	sext.w	a4,a5
    80005f9a:	47ad                	li	a5,11
    80005f9c:	fae7d1e3          	bge	a5,a4,80005f3e <itrunc+0x12>
    }
  }

  if(ip->addrs[NDIRECT]){
    80005fa0:	fc843783          	ld	a5,-56(s0)
    80005fa4:	0807a783          	lw	a5,128(a5)
    80005fa8:	cbc5                	beqz	a5,80006058 <itrunc+0x12c>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80005faa:	fc843783          	ld	a5,-56(s0)
    80005fae:	4398                	lw	a4,0(a5)
    80005fb0:	fc843783          	ld	a5,-56(s0)
    80005fb4:	0807a783          	lw	a5,128(a5)
    80005fb8:	85be                	mv	a1,a5
    80005fba:	853a                	mv	a0,a4
    80005fbc:	fffff097          	auipc	ra,0xfffff
    80005fc0:	1b8080e7          	jalr	440(ra) # 80005174 <bread>
    80005fc4:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    80005fc8:	fe043783          	ld	a5,-32(s0)
    80005fcc:	05878793          	addi	a5,a5,88
    80005fd0:	fcf43c23          	sd	a5,-40(s0)
    for(j = 0; j < NINDIRECT; j++){
    80005fd4:	fe042423          	sw	zero,-24(s0)
    80005fd8:	a081                	j	80006018 <itrunc+0xec>
      if(a[j])
    80005fda:	fe842783          	lw	a5,-24(s0)
    80005fde:	078a                	slli	a5,a5,0x2
    80005fe0:	fd843703          	ld	a4,-40(s0)
    80005fe4:	97ba                	add	a5,a5,a4
    80005fe6:	439c                	lw	a5,0(a5)
    80005fe8:	c39d                	beqz	a5,8000600e <itrunc+0xe2>
        bfree(ip->dev, a[j]);
    80005fea:	fc843783          	ld	a5,-56(s0)
    80005fee:	439c                	lw	a5,0(a5)
    80005ff0:	0007869b          	sext.w	a3,a5
    80005ff4:	fe842783          	lw	a5,-24(s0)
    80005ff8:	078a                	slli	a5,a5,0x2
    80005ffa:	fd843703          	ld	a4,-40(s0)
    80005ffe:	97ba                	add	a5,a5,a4
    80006000:	439c                	lw	a5,0(a5)
    80006002:	85be                	mv	a1,a5
    80006004:	8536                	mv	a0,a3
    80006006:	fffff097          	auipc	ra,0xfffff
    8000600a:	65e080e7          	jalr	1630(ra) # 80005664 <bfree>
    for(j = 0; j < NINDIRECT; j++){
    8000600e:	fe842783          	lw	a5,-24(s0)
    80006012:	2785                	addiw	a5,a5,1
    80006014:	fef42423          	sw	a5,-24(s0)
    80006018:	fe842783          	lw	a5,-24(s0)
    8000601c:	873e                	mv	a4,a5
    8000601e:	0ff00793          	li	a5,255
    80006022:	fae7fce3          	bgeu	a5,a4,80005fda <itrunc+0xae>
    }
    brelse(bp);
    80006026:	fe043503          	ld	a0,-32(s0)
    8000602a:	fffff097          	auipc	ra,0xfffff
    8000602e:	1ec080e7          	jalr	492(ra) # 80005216 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80006032:	fc843783          	ld	a5,-56(s0)
    80006036:	439c                	lw	a5,0(a5)
    80006038:	0007871b          	sext.w	a4,a5
    8000603c:	fc843783          	ld	a5,-56(s0)
    80006040:	0807a783          	lw	a5,128(a5)
    80006044:	85be                	mv	a1,a5
    80006046:	853a                	mv	a0,a4
    80006048:	fffff097          	auipc	ra,0xfffff
    8000604c:	61c080e7          	jalr	1564(ra) # 80005664 <bfree>
    ip->addrs[NDIRECT] = 0;
    80006050:	fc843783          	ld	a5,-56(s0)
    80006054:	0807a023          	sw	zero,128(a5)
  }

  ip->size = 0;
    80006058:	fc843783          	ld	a5,-56(s0)
    8000605c:	0407a623          	sw	zero,76(a5)
  iupdate(ip);
    80006060:	fc843503          	ld	a0,-56(s0)
    80006064:	00000097          	auipc	ra,0x0
    80006068:	890080e7          	jalr	-1904(ra) # 800058f4 <iupdate>
}
    8000606c:	0001                	nop
    8000606e:	70e2                	ld	ra,56(sp)
    80006070:	7442                	ld	s0,48(sp)
    80006072:	6121                	addi	sp,sp,64
    80006074:	8082                	ret

0000000080006076 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80006076:	1101                	addi	sp,sp,-32
    80006078:	ec22                	sd	s0,24(sp)
    8000607a:	1000                	addi	s0,sp,32
    8000607c:	fea43423          	sd	a0,-24(s0)
    80006080:	feb43023          	sd	a1,-32(s0)
  st->dev = ip->dev;
    80006084:	fe843783          	ld	a5,-24(s0)
    80006088:	439c                	lw	a5,0(a5)
    8000608a:	0007871b          	sext.w	a4,a5
    8000608e:	fe043783          	ld	a5,-32(s0)
    80006092:	c398                	sw	a4,0(a5)
  st->ino = ip->inum;
    80006094:	fe843783          	ld	a5,-24(s0)
    80006098:	43d8                	lw	a4,4(a5)
    8000609a:	fe043783          	ld	a5,-32(s0)
    8000609e:	c3d8                	sw	a4,4(a5)
  st->type = ip->type;
    800060a0:	fe843783          	ld	a5,-24(s0)
    800060a4:	04479703          	lh	a4,68(a5)
    800060a8:	fe043783          	ld	a5,-32(s0)
    800060ac:	00e79423          	sh	a4,8(a5)
  st->nlink = ip->nlink;
    800060b0:	fe843783          	ld	a5,-24(s0)
    800060b4:	04a79703          	lh	a4,74(a5)
    800060b8:	fe043783          	ld	a5,-32(s0)
    800060bc:	00e79523          	sh	a4,10(a5)
  st->size = ip->size;
    800060c0:	fe843783          	ld	a5,-24(s0)
    800060c4:	47fc                	lw	a5,76(a5)
    800060c6:	02079713          	slli	a4,a5,0x20
    800060ca:	9301                	srli	a4,a4,0x20
    800060cc:	fe043783          	ld	a5,-32(s0)
    800060d0:	eb98                	sd	a4,16(a5)
}
    800060d2:	0001                	nop
    800060d4:	6462                	ld	s0,24(sp)
    800060d6:	6105                	addi	sp,sp,32
    800060d8:	8082                	ret

00000000800060da <readi>:
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.
int
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    800060da:	711d                	addi	sp,sp,-96
    800060dc:	ec86                	sd	ra,88(sp)
    800060de:	e8a2                	sd	s0,80(sp)
    800060e0:	e4a6                	sd	s1,72(sp)
    800060e2:	1080                	addi	s0,sp,96
    800060e4:	faa43c23          	sd	a0,-72(s0)
    800060e8:	87ae                	mv	a5,a1
    800060ea:	fac43423          	sd	a2,-88(s0)
    800060ee:	faf42a23          	sw	a5,-76(s0)
    800060f2:	87b6                	mv	a5,a3
    800060f4:	faf42823          	sw	a5,-80(s0)
    800060f8:	87ba                	mv	a5,a4
    800060fa:	faf42223          	sw	a5,-92(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800060fe:	fb843783          	ld	a5,-72(s0)
    80006102:	47f8                	lw	a4,76(a5)
    80006104:	fb042783          	lw	a5,-80(s0)
    80006108:	2781                	sext.w	a5,a5
    8000610a:	00f76f63          	bltu	a4,a5,80006128 <readi+0x4e>
    8000610e:	fb042783          	lw	a5,-80(s0)
    80006112:	873e                	mv	a4,a5
    80006114:	fa442783          	lw	a5,-92(s0)
    80006118:	9fb9                	addw	a5,a5,a4
    8000611a:	0007871b          	sext.w	a4,a5
    8000611e:	fb042783          	lw	a5,-80(s0)
    80006122:	2781                	sext.w	a5,a5
    80006124:	00f77463          	bgeu	a4,a5,8000612c <readi+0x52>
    return 0;
    80006128:	4781                	li	a5,0
    8000612a:	aa15                	j	8000625e <readi+0x184>
  if(off + n > ip->size)
    8000612c:	fb042783          	lw	a5,-80(s0)
    80006130:	873e                	mv	a4,a5
    80006132:	fa442783          	lw	a5,-92(s0)
    80006136:	9fb9                	addw	a5,a5,a4
    80006138:	0007871b          	sext.w	a4,a5
    8000613c:	fb843783          	ld	a5,-72(s0)
    80006140:	47fc                	lw	a5,76(a5)
    80006142:	00e7fa63          	bgeu	a5,a4,80006156 <readi+0x7c>
    n = ip->size - off;
    80006146:	fb843783          	ld	a5,-72(s0)
    8000614a:	47fc                	lw	a5,76(a5)
    8000614c:	fb042703          	lw	a4,-80(s0)
    80006150:	9f99                	subw	a5,a5,a4
    80006152:	faf42223          	sw	a5,-92(s0)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80006156:	fc042e23          	sw	zero,-36(s0)
    8000615a:	a0fd                	j	80006248 <readi+0x16e>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    8000615c:	fb843783          	ld	a5,-72(s0)
    80006160:	4384                	lw	s1,0(a5)
    80006162:	fb042783          	lw	a5,-80(s0)
    80006166:	00a7d79b          	srliw	a5,a5,0xa
    8000616a:	2781                	sext.w	a5,a5
    8000616c:	85be                	mv	a1,a5
    8000616e:	fb843503          	ld	a0,-72(s0)
    80006172:	00000097          	auipc	ra,0x0
    80006176:	c5e080e7          	jalr	-930(ra) # 80005dd0 <bmap>
    8000617a:	87aa                	mv	a5,a0
    8000617c:	2781                	sext.w	a5,a5
    8000617e:	85be                	mv	a1,a5
    80006180:	8526                	mv	a0,s1
    80006182:	fffff097          	auipc	ra,0xfffff
    80006186:	ff2080e7          	jalr	-14(ra) # 80005174 <bread>
    8000618a:	fca43823          	sd	a0,-48(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    8000618e:	fb042783          	lw	a5,-80(s0)
    80006192:	3ff7f793          	andi	a5,a5,1023
    80006196:	2781                	sext.w	a5,a5
    80006198:	40000713          	li	a4,1024
    8000619c:	40f707bb          	subw	a5,a4,a5
    800061a0:	2781                	sext.w	a5,a5
    800061a2:	fa442703          	lw	a4,-92(s0)
    800061a6:	86ba                	mv	a3,a4
    800061a8:	fdc42703          	lw	a4,-36(s0)
    800061ac:	40e6873b          	subw	a4,a3,a4
    800061b0:	2701                	sext.w	a4,a4
    800061b2:	863a                	mv	a2,a4
    800061b4:	0007869b          	sext.w	a3,a5
    800061b8:	0006071b          	sext.w	a4,a2
    800061bc:	00d77363          	bgeu	a4,a3,800061c2 <readi+0xe8>
    800061c0:	87b2                	mv	a5,a2
    800061c2:	fcf42623          	sw	a5,-52(s0)
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    800061c6:	fd043783          	ld	a5,-48(s0)
    800061ca:	05878713          	addi	a4,a5,88
    800061ce:	fb046783          	lwu	a5,-80(s0)
    800061d2:	3ff7f793          	andi	a5,a5,1023
    800061d6:	973e                	add	a4,a4,a5
    800061d8:	fcc46683          	lwu	a3,-52(s0)
    800061dc:	fb442783          	lw	a5,-76(s0)
    800061e0:	863a                	mv	a2,a4
    800061e2:	fa843583          	ld	a1,-88(s0)
    800061e6:	853e                	mv	a0,a5
    800061e8:	ffffe097          	auipc	ra,0xffffe
    800061ec:	8c4080e7          	jalr	-1852(ra) # 80003aac <either_copyout>
    800061f0:	87aa                	mv	a5,a0
    800061f2:	873e                	mv	a4,a5
    800061f4:	57fd                	li	a5,-1
    800061f6:	00f71c63          	bne	a4,a5,8000620e <readi+0x134>
      brelse(bp);
    800061fa:	fd043503          	ld	a0,-48(s0)
    800061fe:	fffff097          	auipc	ra,0xfffff
    80006202:	018080e7          	jalr	24(ra) # 80005216 <brelse>
      tot = -1;
    80006206:	57fd                	li	a5,-1
    80006208:	fcf42e23          	sw	a5,-36(s0)
      break;
    8000620c:	a0b9                	j	8000625a <readi+0x180>
    }
    brelse(bp);
    8000620e:	fd043503          	ld	a0,-48(s0)
    80006212:	fffff097          	auipc	ra,0xfffff
    80006216:	004080e7          	jalr	4(ra) # 80005216 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000621a:	fdc42783          	lw	a5,-36(s0)
    8000621e:	873e                	mv	a4,a5
    80006220:	fcc42783          	lw	a5,-52(s0)
    80006224:	9fb9                	addw	a5,a5,a4
    80006226:	fcf42e23          	sw	a5,-36(s0)
    8000622a:	fb042783          	lw	a5,-80(s0)
    8000622e:	873e                	mv	a4,a5
    80006230:	fcc42783          	lw	a5,-52(s0)
    80006234:	9fb9                	addw	a5,a5,a4
    80006236:	faf42823          	sw	a5,-80(s0)
    8000623a:	fcc46783          	lwu	a5,-52(s0)
    8000623e:	fa843703          	ld	a4,-88(s0)
    80006242:	97ba                	add	a5,a5,a4
    80006244:	faf43423          	sd	a5,-88(s0)
    80006248:	fdc42783          	lw	a5,-36(s0)
    8000624c:	873e                	mv	a4,a5
    8000624e:	fa442783          	lw	a5,-92(s0)
    80006252:	2701                	sext.w	a4,a4
    80006254:	2781                	sext.w	a5,a5
    80006256:	f0f763e3          	bltu	a4,a5,8000615c <readi+0x82>
  }
  return tot;
    8000625a:	fdc42783          	lw	a5,-36(s0)
}
    8000625e:	853e                	mv	a0,a5
    80006260:	60e6                	ld	ra,88(sp)
    80006262:	6446                	ld	s0,80(sp)
    80006264:	64a6                	ld	s1,72(sp)
    80006266:	6125                	addi	sp,sp,96
    80006268:	8082                	ret

000000008000626a <writei>:
// Returns the number of bytes successfully written.
// If the return value is less than the requested n,
// there was an error of some kind.
int
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    8000626a:	711d                	addi	sp,sp,-96
    8000626c:	ec86                	sd	ra,88(sp)
    8000626e:	e8a2                	sd	s0,80(sp)
    80006270:	e4a6                	sd	s1,72(sp)
    80006272:	1080                	addi	s0,sp,96
    80006274:	faa43c23          	sd	a0,-72(s0)
    80006278:	87ae                	mv	a5,a1
    8000627a:	fac43423          	sd	a2,-88(s0)
    8000627e:	faf42a23          	sw	a5,-76(s0)
    80006282:	87b6                	mv	a5,a3
    80006284:	faf42823          	sw	a5,-80(s0)
    80006288:	87ba                	mv	a5,a4
    8000628a:	faf42223          	sw	a5,-92(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    8000628e:	fb843783          	ld	a5,-72(s0)
    80006292:	47f8                	lw	a4,76(a5)
    80006294:	fb042783          	lw	a5,-80(s0)
    80006298:	2781                	sext.w	a5,a5
    8000629a:	00f76f63          	bltu	a4,a5,800062b8 <writei+0x4e>
    8000629e:	fb042783          	lw	a5,-80(s0)
    800062a2:	873e                	mv	a4,a5
    800062a4:	fa442783          	lw	a5,-92(s0)
    800062a8:	9fb9                	addw	a5,a5,a4
    800062aa:	0007871b          	sext.w	a4,a5
    800062ae:	fb042783          	lw	a5,-80(s0)
    800062b2:	2781                	sext.w	a5,a5
    800062b4:	00f77463          	bgeu	a4,a5,800062bc <writei+0x52>
    return -1;
    800062b8:	57fd                	li	a5,-1
    800062ba:	aa89                	j	8000640c <writei+0x1a2>
  if(off + n > MAXFILE*BSIZE)
    800062bc:	fb042783          	lw	a5,-80(s0)
    800062c0:	873e                	mv	a4,a5
    800062c2:	fa442783          	lw	a5,-92(s0)
    800062c6:	9fb9                	addw	a5,a5,a4
    800062c8:	2781                	sext.w	a5,a5
    800062ca:	873e                	mv	a4,a5
    800062cc:	000437b7          	lui	a5,0x43
    800062d0:	00e7f463          	bgeu	a5,a4,800062d8 <writei+0x6e>
    return -1;
    800062d4:	57fd                	li	a5,-1
    800062d6:	aa1d                	j	8000640c <writei+0x1a2>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800062d8:	fc042e23          	sw	zero,-36(s0)
    800062dc:	a8d5                	j	800063d0 <writei+0x166>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    800062de:	fb843783          	ld	a5,-72(s0)
    800062e2:	4384                	lw	s1,0(a5)
    800062e4:	fb042783          	lw	a5,-80(s0)
    800062e8:	00a7d79b          	srliw	a5,a5,0xa
    800062ec:	2781                	sext.w	a5,a5
    800062ee:	85be                	mv	a1,a5
    800062f0:	fb843503          	ld	a0,-72(s0)
    800062f4:	00000097          	auipc	ra,0x0
    800062f8:	adc080e7          	jalr	-1316(ra) # 80005dd0 <bmap>
    800062fc:	87aa                	mv	a5,a0
    800062fe:	2781                	sext.w	a5,a5
    80006300:	85be                	mv	a1,a5
    80006302:	8526                	mv	a0,s1
    80006304:	fffff097          	auipc	ra,0xfffff
    80006308:	e70080e7          	jalr	-400(ra) # 80005174 <bread>
    8000630c:	fca43823          	sd	a0,-48(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    80006310:	fb042783          	lw	a5,-80(s0)
    80006314:	3ff7f793          	andi	a5,a5,1023
    80006318:	2781                	sext.w	a5,a5
    8000631a:	40000713          	li	a4,1024
    8000631e:	40f707bb          	subw	a5,a4,a5
    80006322:	2781                	sext.w	a5,a5
    80006324:	fa442703          	lw	a4,-92(s0)
    80006328:	86ba                	mv	a3,a4
    8000632a:	fdc42703          	lw	a4,-36(s0)
    8000632e:	40e6873b          	subw	a4,a3,a4
    80006332:	2701                	sext.w	a4,a4
    80006334:	863a                	mv	a2,a4
    80006336:	0007869b          	sext.w	a3,a5
    8000633a:	0006071b          	sext.w	a4,a2
    8000633e:	00d77363          	bgeu	a4,a3,80006344 <writei+0xda>
    80006342:	87b2                	mv	a5,a2
    80006344:	fcf42623          	sw	a5,-52(s0)
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80006348:	fd043783          	ld	a5,-48(s0)
    8000634c:	05878713          	addi	a4,a5,88 # 43058 <_entry-0x7ffbcfa8>
    80006350:	fb046783          	lwu	a5,-80(s0)
    80006354:	3ff7f793          	andi	a5,a5,1023
    80006358:	97ba                	add	a5,a5,a4
    8000635a:	fcc46683          	lwu	a3,-52(s0)
    8000635e:	fb442703          	lw	a4,-76(s0)
    80006362:	fa843603          	ld	a2,-88(s0)
    80006366:	85ba                	mv	a1,a4
    80006368:	853e                	mv	a0,a5
    8000636a:	ffffd097          	auipc	ra,0xffffd
    8000636e:	7b6080e7          	jalr	1974(ra) # 80003b20 <either_copyin>
    80006372:	87aa                	mv	a5,a0
    80006374:	873e                	mv	a4,a5
    80006376:	57fd                	li	a5,-1
    80006378:	00f71963          	bne	a4,a5,8000638a <writei+0x120>
      brelse(bp);
    8000637c:	fd043503          	ld	a0,-48(s0)
    80006380:	fffff097          	auipc	ra,0xfffff
    80006384:	e96080e7          	jalr	-362(ra) # 80005216 <brelse>
      break;
    80006388:	a8a9                	j	800063e2 <writei+0x178>
    }
    log_write(bp);
    8000638a:	fd043503          	ld	a0,-48(s0)
    8000638e:	00001097          	auipc	ra,0x1
    80006392:	afc080e7          	jalr	-1284(ra) # 80006e8a <log_write>
    brelse(bp);
    80006396:	fd043503          	ld	a0,-48(s0)
    8000639a:	fffff097          	auipc	ra,0xfffff
    8000639e:	e7c080e7          	jalr	-388(ra) # 80005216 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800063a2:	fdc42783          	lw	a5,-36(s0)
    800063a6:	873e                	mv	a4,a5
    800063a8:	fcc42783          	lw	a5,-52(s0)
    800063ac:	9fb9                	addw	a5,a5,a4
    800063ae:	fcf42e23          	sw	a5,-36(s0)
    800063b2:	fb042783          	lw	a5,-80(s0)
    800063b6:	873e                	mv	a4,a5
    800063b8:	fcc42783          	lw	a5,-52(s0)
    800063bc:	9fb9                	addw	a5,a5,a4
    800063be:	faf42823          	sw	a5,-80(s0)
    800063c2:	fcc46783          	lwu	a5,-52(s0)
    800063c6:	fa843703          	ld	a4,-88(s0)
    800063ca:	97ba                	add	a5,a5,a4
    800063cc:	faf43423          	sd	a5,-88(s0)
    800063d0:	fdc42783          	lw	a5,-36(s0)
    800063d4:	873e                	mv	a4,a5
    800063d6:	fa442783          	lw	a5,-92(s0)
    800063da:	2701                	sext.w	a4,a4
    800063dc:	2781                	sext.w	a5,a5
    800063de:	f0f760e3          	bltu	a4,a5,800062de <writei+0x74>
  }

  if(off > ip->size)
    800063e2:	fb843783          	ld	a5,-72(s0)
    800063e6:	47f8                	lw	a4,76(a5)
    800063e8:	fb042783          	lw	a5,-80(s0)
    800063ec:	2781                	sext.w	a5,a5
    800063ee:	00f77763          	bgeu	a4,a5,800063fc <writei+0x192>
    ip->size = off;
    800063f2:	fb843783          	ld	a5,-72(s0)
    800063f6:	fb042703          	lw	a4,-80(s0)
    800063fa:	c7f8                	sw	a4,76(a5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    800063fc:	fb843503          	ld	a0,-72(s0)
    80006400:	fffff097          	auipc	ra,0xfffff
    80006404:	4f4080e7          	jalr	1268(ra) # 800058f4 <iupdate>

  return tot;
    80006408:	fdc42783          	lw	a5,-36(s0)
}
    8000640c:	853e                	mv	a0,a5
    8000640e:	60e6                	ld	ra,88(sp)
    80006410:	6446                	ld	s0,80(sp)
    80006412:	64a6                	ld	s1,72(sp)
    80006414:	6125                	addi	sp,sp,96
    80006416:	8082                	ret

0000000080006418 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80006418:	1101                	addi	sp,sp,-32
    8000641a:	ec06                	sd	ra,24(sp)
    8000641c:	e822                	sd	s0,16(sp)
    8000641e:	1000                	addi	s0,sp,32
    80006420:	fea43423          	sd	a0,-24(s0)
    80006424:	feb43023          	sd	a1,-32(s0)
  return strncmp(s, t, DIRSIZ);
    80006428:	4639                	li	a2,14
    8000642a:	fe043583          	ld	a1,-32(s0)
    8000642e:	fe843503          	ld	a0,-24(s0)
    80006432:	ffffb097          	auipc	ra,0xffffb
    80006436:	204080e7          	jalr	516(ra) # 80001636 <strncmp>
    8000643a:	87aa                	mv	a5,a0
}
    8000643c:	853e                	mv	a0,a5
    8000643e:	60e2                	ld	ra,24(sp)
    80006440:	6442                	ld	s0,16(sp)
    80006442:	6105                	addi	sp,sp,32
    80006444:	8082                	ret

0000000080006446 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80006446:	715d                	addi	sp,sp,-80
    80006448:	e486                	sd	ra,72(sp)
    8000644a:	e0a2                	sd	s0,64(sp)
    8000644c:	0880                	addi	s0,sp,80
    8000644e:	fca43423          	sd	a0,-56(s0)
    80006452:	fcb43023          	sd	a1,-64(s0)
    80006456:	fac43c23          	sd	a2,-72(s0)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    8000645a:	fc843783          	ld	a5,-56(s0)
    8000645e:	04479783          	lh	a5,68(a5)
    80006462:	0007871b          	sext.w	a4,a5
    80006466:	4785                	li	a5,1
    80006468:	00f70a63          	beq	a4,a5,8000647c <dirlookup+0x36>
    panic("dirlookup not DIR");
    8000646c:	00005517          	auipc	a0,0x5
    80006470:	22c50513          	addi	a0,a0,556 # 8000b698 <etext+0x698>
    80006474:	ffffb097          	auipc	ra,0xffffb
    80006478:	806080e7          	jalr	-2042(ra) # 80000c7a <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
    8000647c:	fe042623          	sw	zero,-20(s0)
    80006480:	a849                	j	80006512 <dirlookup+0xcc>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80006482:	fd840793          	addi	a5,s0,-40
    80006486:	fec42683          	lw	a3,-20(s0)
    8000648a:	4741                	li	a4,16
    8000648c:	863e                	mv	a2,a5
    8000648e:	4581                	li	a1,0
    80006490:	fc843503          	ld	a0,-56(s0)
    80006494:	00000097          	auipc	ra,0x0
    80006498:	c46080e7          	jalr	-954(ra) # 800060da <readi>
    8000649c:	87aa                	mv	a5,a0
    8000649e:	873e                	mv	a4,a5
    800064a0:	47c1                	li	a5,16
    800064a2:	00f70a63          	beq	a4,a5,800064b6 <dirlookup+0x70>
      panic("dirlookup read");
    800064a6:	00005517          	auipc	a0,0x5
    800064aa:	20a50513          	addi	a0,a0,522 # 8000b6b0 <etext+0x6b0>
    800064ae:	ffffa097          	auipc	ra,0xffffa
    800064b2:	7cc080e7          	jalr	1996(ra) # 80000c7a <panic>
    if(de.inum == 0)
    800064b6:	fd845783          	lhu	a5,-40(s0)
    800064ba:	c7b1                	beqz	a5,80006506 <dirlookup+0xc0>
      continue;
    if(namecmp(name, de.name) == 0){
    800064bc:	fd840793          	addi	a5,s0,-40
    800064c0:	0789                	addi	a5,a5,2
    800064c2:	85be                	mv	a1,a5
    800064c4:	fc043503          	ld	a0,-64(s0)
    800064c8:	00000097          	auipc	ra,0x0
    800064cc:	f50080e7          	jalr	-176(ra) # 80006418 <namecmp>
    800064d0:	87aa                	mv	a5,a0
    800064d2:	eb9d                	bnez	a5,80006508 <dirlookup+0xc2>
      // entry matches path element
      if(poff)
    800064d4:	fb843783          	ld	a5,-72(s0)
    800064d8:	c791                	beqz	a5,800064e4 <dirlookup+0x9e>
        *poff = off;
    800064da:	fb843783          	ld	a5,-72(s0)
    800064de:	fec42703          	lw	a4,-20(s0)
    800064e2:	c398                	sw	a4,0(a5)
      inum = de.inum;
    800064e4:	fd845783          	lhu	a5,-40(s0)
    800064e8:	fef42423          	sw	a5,-24(s0)
      return iget(dp->dev, inum);
    800064ec:	fc843783          	ld	a5,-56(s0)
    800064f0:	439c                	lw	a5,0(a5)
    800064f2:	fe842703          	lw	a4,-24(s0)
    800064f6:	85ba                	mv	a1,a4
    800064f8:	853e                	mv	a0,a5
    800064fa:	fffff097          	auipc	ra,0xfffff
    800064fe:	4e2080e7          	jalr	1250(ra) # 800059dc <iget>
    80006502:	87aa                	mv	a5,a0
    80006504:	a005                	j	80006524 <dirlookup+0xde>
      continue;
    80006506:	0001                	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
    80006508:	fec42783          	lw	a5,-20(s0)
    8000650c:	27c1                	addiw	a5,a5,16
    8000650e:	fef42623          	sw	a5,-20(s0)
    80006512:	fc843783          	ld	a5,-56(s0)
    80006516:	47f8                	lw	a4,76(a5)
    80006518:	fec42783          	lw	a5,-20(s0)
    8000651c:	2781                	sext.w	a5,a5
    8000651e:	f6e7e2e3          	bltu	a5,a4,80006482 <dirlookup+0x3c>
    }
  }

  return 0;
    80006522:	4781                	li	a5,0
}
    80006524:	853e                	mv	a0,a5
    80006526:	60a6                	ld	ra,72(sp)
    80006528:	6406                	ld	s0,64(sp)
    8000652a:	6161                	addi	sp,sp,80
    8000652c:	8082                	ret

000000008000652e <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
    8000652e:	715d                	addi	sp,sp,-80
    80006530:	e486                	sd	ra,72(sp)
    80006532:	e0a2                	sd	s0,64(sp)
    80006534:	0880                	addi	s0,sp,80
    80006536:	fca43423          	sd	a0,-56(s0)
    8000653a:	fcb43023          	sd	a1,-64(s0)
    8000653e:	87b2                	mv	a5,a2
    80006540:	faf42e23          	sw	a5,-68(s0)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    80006544:	4601                	li	a2,0
    80006546:	fc043583          	ld	a1,-64(s0)
    8000654a:	fc843503          	ld	a0,-56(s0)
    8000654e:	00000097          	auipc	ra,0x0
    80006552:	ef8080e7          	jalr	-264(ra) # 80006446 <dirlookup>
    80006556:	fea43023          	sd	a0,-32(s0)
    8000655a:	fe043783          	ld	a5,-32(s0)
    8000655e:	cb89                	beqz	a5,80006570 <dirlink+0x42>
    iput(ip);
    80006560:	fe043503          	ld	a0,-32(s0)
    80006564:	fffff097          	auipc	ra,0xfffff
    80006568:	76e080e7          	jalr	1902(ra) # 80005cd2 <iput>
    return -1;
    8000656c:	57fd                	li	a5,-1
    8000656e:	a865                	j	80006626 <dirlink+0xf8>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    80006570:	fe042623          	sw	zero,-20(s0)
    80006574:	a0a1                	j	800065bc <dirlink+0x8e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80006576:	fd040793          	addi	a5,s0,-48
    8000657a:	fec42683          	lw	a3,-20(s0)
    8000657e:	4741                	li	a4,16
    80006580:	863e                	mv	a2,a5
    80006582:	4581                	li	a1,0
    80006584:	fc843503          	ld	a0,-56(s0)
    80006588:	00000097          	auipc	ra,0x0
    8000658c:	b52080e7          	jalr	-1198(ra) # 800060da <readi>
    80006590:	87aa                	mv	a5,a0
    80006592:	873e                	mv	a4,a5
    80006594:	47c1                	li	a5,16
    80006596:	00f70a63          	beq	a4,a5,800065aa <dirlink+0x7c>
      panic("dirlink read");
    8000659a:	00005517          	auipc	a0,0x5
    8000659e:	12650513          	addi	a0,a0,294 # 8000b6c0 <etext+0x6c0>
    800065a2:	ffffa097          	auipc	ra,0xffffa
    800065a6:	6d8080e7          	jalr	1752(ra) # 80000c7a <panic>
    if(de.inum == 0)
    800065aa:	fd045783          	lhu	a5,-48(s0)
    800065ae:	cf99                	beqz	a5,800065cc <dirlink+0x9e>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800065b0:	fec42783          	lw	a5,-20(s0)
    800065b4:	27c1                	addiw	a5,a5,16
    800065b6:	2781                	sext.w	a5,a5
    800065b8:	fef42623          	sw	a5,-20(s0)
    800065bc:	fc843783          	ld	a5,-56(s0)
    800065c0:	47f8                	lw	a4,76(a5)
    800065c2:	fec42783          	lw	a5,-20(s0)
    800065c6:	fae7e8e3          	bltu	a5,a4,80006576 <dirlink+0x48>
    800065ca:	a011                	j	800065ce <dirlink+0xa0>
      break;
    800065cc:	0001                	nop
  }

  strncpy(de.name, name, DIRSIZ);
    800065ce:	fd040793          	addi	a5,s0,-48
    800065d2:	0789                	addi	a5,a5,2
    800065d4:	4639                	li	a2,14
    800065d6:	fc043583          	ld	a1,-64(s0)
    800065da:	853e                	mv	a0,a5
    800065dc:	ffffb097          	auipc	ra,0xffffb
    800065e0:	0e4080e7          	jalr	228(ra) # 800016c0 <strncpy>
  de.inum = inum;
    800065e4:	fbc42783          	lw	a5,-68(s0)
    800065e8:	17c2                	slli	a5,a5,0x30
    800065ea:	93c1                	srli	a5,a5,0x30
    800065ec:	fcf41823          	sh	a5,-48(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800065f0:	fd040793          	addi	a5,s0,-48
    800065f4:	fec42683          	lw	a3,-20(s0)
    800065f8:	4741                	li	a4,16
    800065fa:	863e                	mv	a2,a5
    800065fc:	4581                	li	a1,0
    800065fe:	fc843503          	ld	a0,-56(s0)
    80006602:	00000097          	auipc	ra,0x0
    80006606:	c68080e7          	jalr	-920(ra) # 8000626a <writei>
    8000660a:	87aa                	mv	a5,a0
    8000660c:	873e                	mv	a4,a5
    8000660e:	47c1                	li	a5,16
    80006610:	00f70a63          	beq	a4,a5,80006624 <dirlink+0xf6>
    panic("dirlink");
    80006614:	00005517          	auipc	a0,0x5
    80006618:	0bc50513          	addi	a0,a0,188 # 8000b6d0 <etext+0x6d0>
    8000661c:	ffffa097          	auipc	ra,0xffffa
    80006620:	65e080e7          	jalr	1630(ra) # 80000c7a <panic>

  return 0;
    80006624:	4781                	li	a5,0
}
    80006626:	853e                	mv	a0,a5
    80006628:	60a6                	ld	ra,72(sp)
    8000662a:	6406                	ld	s0,64(sp)
    8000662c:	6161                	addi	sp,sp,80
    8000662e:	8082                	ret

0000000080006630 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
    80006630:	7179                	addi	sp,sp,-48
    80006632:	f406                	sd	ra,40(sp)
    80006634:	f022                	sd	s0,32(sp)
    80006636:	1800                	addi	s0,sp,48
    80006638:	fca43c23          	sd	a0,-40(s0)
    8000663c:	fcb43823          	sd	a1,-48(s0)
  char *s;
  int len;

  while(*path == '/')
    80006640:	a031                	j	8000664c <skipelem+0x1c>
    path++;
    80006642:	fd843783          	ld	a5,-40(s0)
    80006646:	0785                	addi	a5,a5,1
    80006648:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    8000664c:	fd843783          	ld	a5,-40(s0)
    80006650:	0007c783          	lbu	a5,0(a5)
    80006654:	873e                	mv	a4,a5
    80006656:	02f00793          	li	a5,47
    8000665a:	fef704e3          	beq	a4,a5,80006642 <skipelem+0x12>
  if(*path == 0)
    8000665e:	fd843783          	ld	a5,-40(s0)
    80006662:	0007c783          	lbu	a5,0(a5)
    80006666:	e399                	bnez	a5,8000666c <skipelem+0x3c>
    return 0;
    80006668:	4781                	li	a5,0
    8000666a:	a06d                	j	80006714 <skipelem+0xe4>
  s = path;
    8000666c:	fd843783          	ld	a5,-40(s0)
    80006670:	fef43423          	sd	a5,-24(s0)
  while(*path != '/' && *path != 0)
    80006674:	a031                	j	80006680 <skipelem+0x50>
    path++;
    80006676:	fd843783          	ld	a5,-40(s0)
    8000667a:	0785                	addi	a5,a5,1
    8000667c:	fcf43c23          	sd	a5,-40(s0)
  while(*path != '/' && *path != 0)
    80006680:	fd843783          	ld	a5,-40(s0)
    80006684:	0007c783          	lbu	a5,0(a5)
    80006688:	873e                	mv	a4,a5
    8000668a:	02f00793          	li	a5,47
    8000668e:	00f70763          	beq	a4,a5,8000669c <skipelem+0x6c>
    80006692:	fd843783          	ld	a5,-40(s0)
    80006696:	0007c783          	lbu	a5,0(a5)
    8000669a:	fff1                	bnez	a5,80006676 <skipelem+0x46>
  len = path - s;
    8000669c:	fd843703          	ld	a4,-40(s0)
    800066a0:	fe843783          	ld	a5,-24(s0)
    800066a4:	40f707b3          	sub	a5,a4,a5
    800066a8:	fef42223          	sw	a5,-28(s0)
  if(len >= DIRSIZ)
    800066ac:	fe442783          	lw	a5,-28(s0)
    800066b0:	0007871b          	sext.w	a4,a5
    800066b4:	47b5                	li	a5,13
    800066b6:	00e7dc63          	bge	a5,a4,800066ce <skipelem+0x9e>
    memmove(name, s, DIRSIZ);
    800066ba:	4639                	li	a2,14
    800066bc:	fe843583          	ld	a1,-24(s0)
    800066c0:	fd043503          	ld	a0,-48(s0)
    800066c4:	ffffb097          	auipc	ra,0xffffb
    800066c8:	e5e080e7          	jalr	-418(ra) # 80001522 <memmove>
    800066cc:	a80d                	j	800066fe <skipelem+0xce>
  else {
    memmove(name, s, len);
    800066ce:	fe442783          	lw	a5,-28(s0)
    800066d2:	863e                	mv	a2,a5
    800066d4:	fe843583          	ld	a1,-24(s0)
    800066d8:	fd043503          	ld	a0,-48(s0)
    800066dc:	ffffb097          	auipc	ra,0xffffb
    800066e0:	e46080e7          	jalr	-442(ra) # 80001522 <memmove>
    name[len] = 0;
    800066e4:	fe442783          	lw	a5,-28(s0)
    800066e8:	fd043703          	ld	a4,-48(s0)
    800066ec:	97ba                	add	a5,a5,a4
    800066ee:	00078023          	sb	zero,0(a5)
  }
  while(*path == '/')
    800066f2:	a031                	j	800066fe <skipelem+0xce>
    path++;
    800066f4:	fd843783          	ld	a5,-40(s0)
    800066f8:	0785                	addi	a5,a5,1
    800066fa:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    800066fe:	fd843783          	ld	a5,-40(s0)
    80006702:	0007c783          	lbu	a5,0(a5)
    80006706:	873e                	mv	a4,a5
    80006708:	02f00793          	li	a5,47
    8000670c:	fef704e3          	beq	a4,a5,800066f4 <skipelem+0xc4>
  return path;
    80006710:	fd843783          	ld	a5,-40(s0)
}
    80006714:	853e                	mv	a0,a5
    80006716:	70a2                	ld	ra,40(sp)
    80006718:	7402                	ld	s0,32(sp)
    8000671a:	6145                	addi	sp,sp,48
    8000671c:	8082                	ret

000000008000671e <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    8000671e:	7139                	addi	sp,sp,-64
    80006720:	fc06                	sd	ra,56(sp)
    80006722:	f822                	sd	s0,48(sp)
    80006724:	0080                	addi	s0,sp,64
    80006726:	fca43c23          	sd	a0,-40(s0)
    8000672a:	87ae                	mv	a5,a1
    8000672c:	fcc43423          	sd	a2,-56(s0)
    80006730:	fcf42a23          	sw	a5,-44(s0)
  struct inode *ip, *next;

  if(*path == '/')
    80006734:	fd843783          	ld	a5,-40(s0)
    80006738:	0007c783          	lbu	a5,0(a5)
    8000673c:	873e                	mv	a4,a5
    8000673e:	02f00793          	li	a5,47
    80006742:	00f71b63          	bne	a4,a5,80006758 <namex+0x3a>
    ip = iget(ROOTDEV, ROOTINO);
    80006746:	4585                	li	a1,1
    80006748:	4505                	li	a0,1
    8000674a:	fffff097          	auipc	ra,0xfffff
    8000674e:	292080e7          	jalr	658(ra) # 800059dc <iget>
    80006752:	fea43423          	sd	a0,-24(s0)
    80006756:	a84d                	j	80006808 <namex+0xea>
  else
    ip = idup(myproc()->cwd);
    80006758:	ffffc097          	auipc	ra,0xffffc
    8000675c:	2c0080e7          	jalr	704(ra) # 80002a18 <myproc>
    80006760:	87aa                	mv	a5,a0
    80006762:	1607b783          	ld	a5,352(a5)
    80006766:	853e                	mv	a0,a5
    80006768:	fffff097          	auipc	ra,0xfffff
    8000676c:	390080e7          	jalr	912(ra) # 80005af8 <idup>
    80006770:	fea43423          	sd	a0,-24(s0)

  while((path = skipelem(path, name)) != 0){
    80006774:	a851                	j	80006808 <namex+0xea>
    ilock(ip);
    80006776:	fe843503          	ld	a0,-24(s0)
    8000677a:	fffff097          	auipc	ra,0xfffff
    8000677e:	3ca080e7          	jalr	970(ra) # 80005b44 <ilock>
    if(ip->type != T_DIR){
    80006782:	fe843783          	ld	a5,-24(s0)
    80006786:	04479783          	lh	a5,68(a5)
    8000678a:	0007871b          	sext.w	a4,a5
    8000678e:	4785                	li	a5,1
    80006790:	00f70a63          	beq	a4,a5,800067a4 <namex+0x86>
      iunlockput(ip);
    80006794:	fe843503          	ld	a0,-24(s0)
    80006798:	fffff097          	auipc	ra,0xfffff
    8000679c:	60a080e7          	jalr	1546(ra) # 80005da2 <iunlockput>
      return 0;
    800067a0:	4781                	li	a5,0
    800067a2:	a871                	j	8000683e <namex+0x120>
    }
    if(nameiparent && *path == '\0'){
    800067a4:	fd442783          	lw	a5,-44(s0)
    800067a8:	2781                	sext.w	a5,a5
    800067aa:	cf99                	beqz	a5,800067c8 <namex+0xaa>
    800067ac:	fd843783          	ld	a5,-40(s0)
    800067b0:	0007c783          	lbu	a5,0(a5)
    800067b4:	eb91                	bnez	a5,800067c8 <namex+0xaa>
      // Stop one level early.
      iunlock(ip);
    800067b6:	fe843503          	ld	a0,-24(s0)
    800067ba:	fffff097          	auipc	ra,0xfffff
    800067be:	4be080e7          	jalr	1214(ra) # 80005c78 <iunlock>
      return ip;
    800067c2:	fe843783          	ld	a5,-24(s0)
    800067c6:	a8a5                	j	8000683e <namex+0x120>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
    800067c8:	4601                	li	a2,0
    800067ca:	fc843583          	ld	a1,-56(s0)
    800067ce:	fe843503          	ld	a0,-24(s0)
    800067d2:	00000097          	auipc	ra,0x0
    800067d6:	c74080e7          	jalr	-908(ra) # 80006446 <dirlookup>
    800067da:	fea43023          	sd	a0,-32(s0)
    800067de:	fe043783          	ld	a5,-32(s0)
    800067e2:	eb89                	bnez	a5,800067f4 <namex+0xd6>
      iunlockput(ip);
    800067e4:	fe843503          	ld	a0,-24(s0)
    800067e8:	fffff097          	auipc	ra,0xfffff
    800067ec:	5ba080e7          	jalr	1466(ra) # 80005da2 <iunlockput>
      return 0;
    800067f0:	4781                	li	a5,0
    800067f2:	a0b1                	j	8000683e <namex+0x120>
    }
    iunlockput(ip);
    800067f4:	fe843503          	ld	a0,-24(s0)
    800067f8:	fffff097          	auipc	ra,0xfffff
    800067fc:	5aa080e7          	jalr	1450(ra) # 80005da2 <iunlockput>
    ip = next;
    80006800:	fe043783          	ld	a5,-32(s0)
    80006804:	fef43423          	sd	a5,-24(s0)
  while((path = skipelem(path, name)) != 0){
    80006808:	fc843583          	ld	a1,-56(s0)
    8000680c:	fd843503          	ld	a0,-40(s0)
    80006810:	00000097          	auipc	ra,0x0
    80006814:	e20080e7          	jalr	-480(ra) # 80006630 <skipelem>
    80006818:	fca43c23          	sd	a0,-40(s0)
    8000681c:	fd843783          	ld	a5,-40(s0)
    80006820:	fbb9                	bnez	a5,80006776 <namex+0x58>
  }
  if(nameiparent){
    80006822:	fd442783          	lw	a5,-44(s0)
    80006826:	2781                	sext.w	a5,a5
    80006828:	cb89                	beqz	a5,8000683a <namex+0x11c>
    iput(ip);
    8000682a:	fe843503          	ld	a0,-24(s0)
    8000682e:	fffff097          	auipc	ra,0xfffff
    80006832:	4a4080e7          	jalr	1188(ra) # 80005cd2 <iput>
    return 0;
    80006836:	4781                	li	a5,0
    80006838:	a019                	j	8000683e <namex+0x120>
  }
  return ip;
    8000683a:	fe843783          	ld	a5,-24(s0)
}
    8000683e:	853e                	mv	a0,a5
    80006840:	70e2                	ld	ra,56(sp)
    80006842:	7442                	ld	s0,48(sp)
    80006844:	6121                	addi	sp,sp,64
    80006846:	8082                	ret

0000000080006848 <namei>:

struct inode*
namei(char *path)
{
    80006848:	7179                	addi	sp,sp,-48
    8000684a:	f406                	sd	ra,40(sp)
    8000684c:	f022                	sd	s0,32(sp)
    8000684e:	1800                	addi	s0,sp,48
    80006850:	fca43c23          	sd	a0,-40(s0)
  char name[DIRSIZ];
  return namex(path, 0, name);
    80006854:	fe040793          	addi	a5,s0,-32
    80006858:	863e                	mv	a2,a5
    8000685a:	4581                	li	a1,0
    8000685c:	fd843503          	ld	a0,-40(s0)
    80006860:	00000097          	auipc	ra,0x0
    80006864:	ebe080e7          	jalr	-322(ra) # 8000671e <namex>
    80006868:	87aa                	mv	a5,a0
}
    8000686a:	853e                	mv	a0,a5
    8000686c:	70a2                	ld	ra,40(sp)
    8000686e:	7402                	ld	s0,32(sp)
    80006870:	6145                	addi	sp,sp,48
    80006872:	8082                	ret

0000000080006874 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80006874:	1101                	addi	sp,sp,-32
    80006876:	ec06                	sd	ra,24(sp)
    80006878:	e822                	sd	s0,16(sp)
    8000687a:	1000                	addi	s0,sp,32
    8000687c:	fea43423          	sd	a0,-24(s0)
    80006880:	feb43023          	sd	a1,-32(s0)
  return namex(path, 1, name);
    80006884:	fe043603          	ld	a2,-32(s0)
    80006888:	4585                	li	a1,1
    8000688a:	fe843503          	ld	a0,-24(s0)
    8000688e:	00000097          	auipc	ra,0x0
    80006892:	e90080e7          	jalr	-368(ra) # 8000671e <namex>
    80006896:	87aa                	mv	a5,a0
}
    80006898:	853e                	mv	a0,a5
    8000689a:	60e2                	ld	ra,24(sp)
    8000689c:	6442                	ld	s0,16(sp)
    8000689e:	6105                	addi	sp,sp,32
    800068a0:	8082                	ret

00000000800068a2 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev, struct superblock *sb)
{
    800068a2:	1101                	addi	sp,sp,-32
    800068a4:	ec06                	sd	ra,24(sp)
    800068a6:	e822                	sd	s0,16(sp)
    800068a8:	1000                	addi	s0,sp,32
    800068aa:	87aa                	mv	a5,a0
    800068ac:	feb43023          	sd	a1,-32(s0)
    800068b0:	fef42623          	sw	a5,-20(s0)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  initlock(&log.lock, "log");
    800068b4:	00005597          	auipc	a1,0x5
    800068b8:	e2458593          	addi	a1,a1,-476 # 8000b6d8 <etext+0x6d8>
    800068bc:	0049e517          	auipc	a0,0x49e
    800068c0:	3ac50513          	addi	a0,a0,940 # 804a4c68 <log>
    800068c4:	ffffb097          	auipc	ra,0xffffb
    800068c8:	976080e7          	jalr	-1674(ra) # 8000123a <initlock>
  log.start = sb->logstart;
    800068cc:	fe043783          	ld	a5,-32(s0)
    800068d0:	4bdc                	lw	a5,20(a5)
    800068d2:	0007871b          	sext.w	a4,a5
    800068d6:	0049e797          	auipc	a5,0x49e
    800068da:	39278793          	addi	a5,a5,914 # 804a4c68 <log>
    800068de:	cf98                	sw	a4,24(a5)
  log.size = sb->nlog;
    800068e0:	fe043783          	ld	a5,-32(s0)
    800068e4:	4b9c                	lw	a5,16(a5)
    800068e6:	0007871b          	sext.w	a4,a5
    800068ea:	0049e797          	auipc	a5,0x49e
    800068ee:	37e78793          	addi	a5,a5,894 # 804a4c68 <log>
    800068f2:	cfd8                	sw	a4,28(a5)
  log.dev = dev;
    800068f4:	0049e797          	auipc	a5,0x49e
    800068f8:	37478793          	addi	a5,a5,884 # 804a4c68 <log>
    800068fc:	fec42703          	lw	a4,-20(s0)
    80006900:	d798                	sw	a4,40(a5)
  recover_from_log();
    80006902:	00000097          	auipc	ra,0x0
    80006906:	272080e7          	jalr	626(ra) # 80006b74 <recover_from_log>
}
    8000690a:	0001                	nop
    8000690c:	60e2                	ld	ra,24(sp)
    8000690e:	6442                	ld	s0,16(sp)
    80006910:	6105                	addi	sp,sp,32
    80006912:	8082                	ret

0000000080006914 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(int recovering)
{
    80006914:	7139                	addi	sp,sp,-64
    80006916:	fc06                	sd	ra,56(sp)
    80006918:	f822                	sd	s0,48(sp)
    8000691a:	0080                	addi	s0,sp,64
    8000691c:	87aa                	mv	a5,a0
    8000691e:	fcf42623          	sw	a5,-52(s0)
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    80006922:	fe042623          	sw	zero,-20(s0)
    80006926:	a0f9                	j	800069f4 <install_trans+0xe0>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80006928:	0049e797          	auipc	a5,0x49e
    8000692c:	34078793          	addi	a5,a5,832 # 804a4c68 <log>
    80006930:	579c                	lw	a5,40(a5)
    80006932:	0007871b          	sext.w	a4,a5
    80006936:	0049e797          	auipc	a5,0x49e
    8000693a:	33278793          	addi	a5,a5,818 # 804a4c68 <log>
    8000693e:	4f9c                	lw	a5,24(a5)
    80006940:	fec42683          	lw	a3,-20(s0)
    80006944:	9fb5                	addw	a5,a5,a3
    80006946:	2781                	sext.w	a5,a5
    80006948:	2785                	addiw	a5,a5,1
    8000694a:	2781                	sext.w	a5,a5
    8000694c:	2781                	sext.w	a5,a5
    8000694e:	85be                	mv	a1,a5
    80006950:	853a                	mv	a0,a4
    80006952:	fffff097          	auipc	ra,0xfffff
    80006956:	822080e7          	jalr	-2014(ra) # 80005174 <bread>
    8000695a:	fea43023          	sd	a0,-32(s0)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    8000695e:	0049e797          	auipc	a5,0x49e
    80006962:	30a78793          	addi	a5,a5,778 # 804a4c68 <log>
    80006966:	579c                	lw	a5,40(a5)
    80006968:	0007869b          	sext.w	a3,a5
    8000696c:	0049e717          	auipc	a4,0x49e
    80006970:	2fc70713          	addi	a4,a4,764 # 804a4c68 <log>
    80006974:	fec42783          	lw	a5,-20(s0)
    80006978:	07a1                	addi	a5,a5,8
    8000697a:	078a                	slli	a5,a5,0x2
    8000697c:	97ba                	add	a5,a5,a4
    8000697e:	4b9c                	lw	a5,16(a5)
    80006980:	2781                	sext.w	a5,a5
    80006982:	85be                	mv	a1,a5
    80006984:	8536                	mv	a0,a3
    80006986:	ffffe097          	auipc	ra,0xffffe
    8000698a:	7ee080e7          	jalr	2030(ra) # 80005174 <bread>
    8000698e:	fca43c23          	sd	a0,-40(s0)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80006992:	fd843783          	ld	a5,-40(s0)
    80006996:	05878713          	addi	a4,a5,88
    8000699a:	fe043783          	ld	a5,-32(s0)
    8000699e:	05878793          	addi	a5,a5,88
    800069a2:	40000613          	li	a2,1024
    800069a6:	85be                	mv	a1,a5
    800069a8:	853a                	mv	a0,a4
    800069aa:	ffffb097          	auipc	ra,0xffffb
    800069ae:	b78080e7          	jalr	-1160(ra) # 80001522 <memmove>
    bwrite(dbuf);  // write dst to disk
    800069b2:	fd843503          	ld	a0,-40(s0)
    800069b6:	fffff097          	auipc	ra,0xfffff
    800069ba:	818080e7          	jalr	-2024(ra) # 800051ce <bwrite>
    if(recovering == 0)
    800069be:	fcc42783          	lw	a5,-52(s0)
    800069c2:	2781                	sext.w	a5,a5
    800069c4:	e799                	bnez	a5,800069d2 <install_trans+0xbe>
      bunpin(dbuf);
    800069c6:	fd843503          	ld	a0,-40(s0)
    800069ca:	fffff097          	auipc	ra,0xfffff
    800069ce:	982080e7          	jalr	-1662(ra) # 8000534c <bunpin>
    brelse(lbuf);
    800069d2:	fe043503          	ld	a0,-32(s0)
    800069d6:	fffff097          	auipc	ra,0xfffff
    800069da:	840080e7          	jalr	-1984(ra) # 80005216 <brelse>
    brelse(dbuf);
    800069de:	fd843503          	ld	a0,-40(s0)
    800069e2:	fffff097          	auipc	ra,0xfffff
    800069e6:	834080e7          	jalr	-1996(ra) # 80005216 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800069ea:	fec42783          	lw	a5,-20(s0)
    800069ee:	2785                	addiw	a5,a5,1
    800069f0:	fef42623          	sw	a5,-20(s0)
    800069f4:	0049e797          	auipc	a5,0x49e
    800069f8:	27478793          	addi	a5,a5,628 # 804a4c68 <log>
    800069fc:	57d8                	lw	a4,44(a5)
    800069fe:	fec42783          	lw	a5,-20(s0)
    80006a02:	2781                	sext.w	a5,a5
    80006a04:	f2e7c2e3          	blt	a5,a4,80006928 <install_trans+0x14>
  }
}
    80006a08:	0001                	nop
    80006a0a:	0001                	nop
    80006a0c:	70e2                	ld	ra,56(sp)
    80006a0e:	7442                	ld	s0,48(sp)
    80006a10:	6121                	addi	sp,sp,64
    80006a12:	8082                	ret

0000000080006a14 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
    80006a14:	7179                	addi	sp,sp,-48
    80006a16:	f406                	sd	ra,40(sp)
    80006a18:	f022                	sd	s0,32(sp)
    80006a1a:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80006a1c:	0049e797          	auipc	a5,0x49e
    80006a20:	24c78793          	addi	a5,a5,588 # 804a4c68 <log>
    80006a24:	579c                	lw	a5,40(a5)
    80006a26:	0007871b          	sext.w	a4,a5
    80006a2a:	0049e797          	auipc	a5,0x49e
    80006a2e:	23e78793          	addi	a5,a5,574 # 804a4c68 <log>
    80006a32:	4f9c                	lw	a5,24(a5)
    80006a34:	2781                	sext.w	a5,a5
    80006a36:	85be                	mv	a1,a5
    80006a38:	853a                	mv	a0,a4
    80006a3a:	ffffe097          	auipc	ra,0xffffe
    80006a3e:	73a080e7          	jalr	1850(ra) # 80005174 <bread>
    80006a42:	fea43023          	sd	a0,-32(s0)
  struct logheader *lh = (struct logheader *) (buf->data);
    80006a46:	fe043783          	ld	a5,-32(s0)
    80006a4a:	05878793          	addi	a5,a5,88
    80006a4e:	fcf43c23          	sd	a5,-40(s0)
  int i;
  log.lh.n = lh->n;
    80006a52:	fd843783          	ld	a5,-40(s0)
    80006a56:	4398                	lw	a4,0(a5)
    80006a58:	0049e797          	auipc	a5,0x49e
    80006a5c:	21078793          	addi	a5,a5,528 # 804a4c68 <log>
    80006a60:	d7d8                	sw	a4,44(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006a62:	fe042623          	sw	zero,-20(s0)
    80006a66:	a03d                	j	80006a94 <read_head+0x80>
    log.lh.block[i] = lh->block[i];
    80006a68:	fd843703          	ld	a4,-40(s0)
    80006a6c:	fec42783          	lw	a5,-20(s0)
    80006a70:	078a                	slli	a5,a5,0x2
    80006a72:	97ba                	add	a5,a5,a4
    80006a74:	43d8                	lw	a4,4(a5)
    80006a76:	0049e697          	auipc	a3,0x49e
    80006a7a:	1f268693          	addi	a3,a3,498 # 804a4c68 <log>
    80006a7e:	fec42783          	lw	a5,-20(s0)
    80006a82:	07a1                	addi	a5,a5,8
    80006a84:	078a                	slli	a5,a5,0x2
    80006a86:	97b6                	add	a5,a5,a3
    80006a88:	cb98                	sw	a4,16(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006a8a:	fec42783          	lw	a5,-20(s0)
    80006a8e:	2785                	addiw	a5,a5,1
    80006a90:	fef42623          	sw	a5,-20(s0)
    80006a94:	0049e797          	auipc	a5,0x49e
    80006a98:	1d478793          	addi	a5,a5,468 # 804a4c68 <log>
    80006a9c:	57d8                	lw	a4,44(a5)
    80006a9e:	fec42783          	lw	a5,-20(s0)
    80006aa2:	2781                	sext.w	a5,a5
    80006aa4:	fce7c2e3          	blt	a5,a4,80006a68 <read_head+0x54>
  }
  brelse(buf);
    80006aa8:	fe043503          	ld	a0,-32(s0)
    80006aac:	ffffe097          	auipc	ra,0xffffe
    80006ab0:	76a080e7          	jalr	1898(ra) # 80005216 <brelse>
}
    80006ab4:	0001                	nop
    80006ab6:	70a2                	ld	ra,40(sp)
    80006ab8:	7402                	ld	s0,32(sp)
    80006aba:	6145                	addi	sp,sp,48
    80006abc:	8082                	ret

0000000080006abe <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80006abe:	7179                	addi	sp,sp,-48
    80006ac0:	f406                	sd	ra,40(sp)
    80006ac2:	f022                	sd	s0,32(sp)
    80006ac4:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80006ac6:	0049e797          	auipc	a5,0x49e
    80006aca:	1a278793          	addi	a5,a5,418 # 804a4c68 <log>
    80006ace:	579c                	lw	a5,40(a5)
    80006ad0:	0007871b          	sext.w	a4,a5
    80006ad4:	0049e797          	auipc	a5,0x49e
    80006ad8:	19478793          	addi	a5,a5,404 # 804a4c68 <log>
    80006adc:	4f9c                	lw	a5,24(a5)
    80006ade:	2781                	sext.w	a5,a5
    80006ae0:	85be                	mv	a1,a5
    80006ae2:	853a                	mv	a0,a4
    80006ae4:	ffffe097          	auipc	ra,0xffffe
    80006ae8:	690080e7          	jalr	1680(ra) # 80005174 <bread>
    80006aec:	fea43023          	sd	a0,-32(s0)
  struct logheader *hb = (struct logheader *) (buf->data);
    80006af0:	fe043783          	ld	a5,-32(s0)
    80006af4:	05878793          	addi	a5,a5,88
    80006af8:	fcf43c23          	sd	a5,-40(s0)
  int i;
  hb->n = log.lh.n;
    80006afc:	0049e797          	auipc	a5,0x49e
    80006b00:	16c78793          	addi	a5,a5,364 # 804a4c68 <log>
    80006b04:	57d8                	lw	a4,44(a5)
    80006b06:	fd843783          	ld	a5,-40(s0)
    80006b0a:	c398                	sw	a4,0(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006b0c:	fe042623          	sw	zero,-20(s0)
    80006b10:	a03d                	j	80006b3e <write_head+0x80>
    hb->block[i] = log.lh.block[i];
    80006b12:	0049e717          	auipc	a4,0x49e
    80006b16:	15670713          	addi	a4,a4,342 # 804a4c68 <log>
    80006b1a:	fec42783          	lw	a5,-20(s0)
    80006b1e:	07a1                	addi	a5,a5,8
    80006b20:	078a                	slli	a5,a5,0x2
    80006b22:	97ba                	add	a5,a5,a4
    80006b24:	4b98                	lw	a4,16(a5)
    80006b26:	fd843683          	ld	a3,-40(s0)
    80006b2a:	fec42783          	lw	a5,-20(s0)
    80006b2e:	078a                	slli	a5,a5,0x2
    80006b30:	97b6                	add	a5,a5,a3
    80006b32:	c3d8                	sw	a4,4(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006b34:	fec42783          	lw	a5,-20(s0)
    80006b38:	2785                	addiw	a5,a5,1
    80006b3a:	fef42623          	sw	a5,-20(s0)
    80006b3e:	0049e797          	auipc	a5,0x49e
    80006b42:	12a78793          	addi	a5,a5,298 # 804a4c68 <log>
    80006b46:	57d8                	lw	a4,44(a5)
    80006b48:	fec42783          	lw	a5,-20(s0)
    80006b4c:	2781                	sext.w	a5,a5
    80006b4e:	fce7c2e3          	blt	a5,a4,80006b12 <write_head+0x54>
  }
  bwrite(buf);
    80006b52:	fe043503          	ld	a0,-32(s0)
    80006b56:	ffffe097          	auipc	ra,0xffffe
    80006b5a:	678080e7          	jalr	1656(ra) # 800051ce <bwrite>
  brelse(buf);
    80006b5e:	fe043503          	ld	a0,-32(s0)
    80006b62:	ffffe097          	auipc	ra,0xffffe
    80006b66:	6b4080e7          	jalr	1716(ra) # 80005216 <brelse>
}
    80006b6a:	0001                	nop
    80006b6c:	70a2                	ld	ra,40(sp)
    80006b6e:	7402                	ld	s0,32(sp)
    80006b70:	6145                	addi	sp,sp,48
    80006b72:	8082                	ret

0000000080006b74 <recover_from_log>:

static void
recover_from_log(void)
{
    80006b74:	1141                	addi	sp,sp,-16
    80006b76:	e406                	sd	ra,8(sp)
    80006b78:	e022                	sd	s0,0(sp)
    80006b7a:	0800                	addi	s0,sp,16
  read_head();
    80006b7c:	00000097          	auipc	ra,0x0
    80006b80:	e98080e7          	jalr	-360(ra) # 80006a14 <read_head>
  install_trans(1); // if committed, copy from log to disk
    80006b84:	4505                	li	a0,1
    80006b86:	00000097          	auipc	ra,0x0
    80006b8a:	d8e080e7          	jalr	-626(ra) # 80006914 <install_trans>
  log.lh.n = 0;
    80006b8e:	0049e797          	auipc	a5,0x49e
    80006b92:	0da78793          	addi	a5,a5,218 # 804a4c68 <log>
    80006b96:	0207a623          	sw	zero,44(a5)
  write_head(); // clear the log
    80006b9a:	00000097          	auipc	ra,0x0
    80006b9e:	f24080e7          	jalr	-220(ra) # 80006abe <write_head>
}
    80006ba2:	0001                	nop
    80006ba4:	60a2                	ld	ra,8(sp)
    80006ba6:	6402                	ld	s0,0(sp)
    80006ba8:	0141                	addi	sp,sp,16
    80006baa:	8082                	ret

0000000080006bac <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
    80006bac:	1141                	addi	sp,sp,-16
    80006bae:	e406                	sd	ra,8(sp)
    80006bb0:	e022                	sd	s0,0(sp)
    80006bb2:	0800                	addi	s0,sp,16
  acquire(&log.lock);
    80006bb4:	0049e517          	auipc	a0,0x49e
    80006bb8:	0b450513          	addi	a0,a0,180 # 804a4c68 <log>
    80006bbc:	ffffa097          	auipc	ra,0xffffa
    80006bc0:	6ae080e7          	jalr	1710(ra) # 8000126a <acquire>
  while(1){
    if(log.committing){
    80006bc4:	0049e797          	auipc	a5,0x49e
    80006bc8:	0a478793          	addi	a5,a5,164 # 804a4c68 <log>
    80006bcc:	53dc                	lw	a5,36(a5)
    80006bce:	cf91                	beqz	a5,80006bea <begin_op+0x3e>
      sleep(&log, &log.lock);
    80006bd0:	0049e597          	auipc	a1,0x49e
    80006bd4:	09858593          	addi	a1,a1,152 # 804a4c68 <log>
    80006bd8:	0049e517          	auipc	a0,0x49e
    80006bdc:	09050513          	addi	a0,a0,144 # 804a4c68 <log>
    80006be0:	ffffd097          	auipc	ra,0xffffd
    80006be4:	d14080e7          	jalr	-748(ra) # 800038f4 <sleep>
    80006be8:	bff1                	j	80006bc4 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80006bea:	0049e797          	auipc	a5,0x49e
    80006bee:	07e78793          	addi	a5,a5,126 # 804a4c68 <log>
    80006bf2:	57d8                	lw	a4,44(a5)
    80006bf4:	0049e797          	auipc	a5,0x49e
    80006bf8:	07478793          	addi	a5,a5,116 # 804a4c68 <log>
    80006bfc:	539c                	lw	a5,32(a5)
    80006bfe:	2785                	addiw	a5,a5,1
    80006c00:	2781                	sext.w	a5,a5
    80006c02:	86be                	mv	a3,a5
    80006c04:	87b6                	mv	a5,a3
    80006c06:	0027979b          	slliw	a5,a5,0x2
    80006c0a:	9fb5                	addw	a5,a5,a3
    80006c0c:	0017979b          	slliw	a5,a5,0x1
    80006c10:	2781                	sext.w	a5,a5
    80006c12:	9fb9                	addw	a5,a5,a4
    80006c14:	2781                	sext.w	a5,a5
    80006c16:	873e                	mv	a4,a5
    80006c18:	47f9                	li	a5,30
    80006c1a:	00e7df63          	bge	a5,a4,80006c38 <begin_op+0x8c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80006c1e:	0049e597          	auipc	a1,0x49e
    80006c22:	04a58593          	addi	a1,a1,74 # 804a4c68 <log>
    80006c26:	0049e517          	auipc	a0,0x49e
    80006c2a:	04250513          	addi	a0,a0,66 # 804a4c68 <log>
    80006c2e:	ffffd097          	auipc	ra,0xffffd
    80006c32:	cc6080e7          	jalr	-826(ra) # 800038f4 <sleep>
    80006c36:	b779                	j	80006bc4 <begin_op+0x18>
    } else {
      log.outstanding += 1;
    80006c38:	0049e797          	auipc	a5,0x49e
    80006c3c:	03078793          	addi	a5,a5,48 # 804a4c68 <log>
    80006c40:	539c                	lw	a5,32(a5)
    80006c42:	2785                	addiw	a5,a5,1
    80006c44:	0007871b          	sext.w	a4,a5
    80006c48:	0049e797          	auipc	a5,0x49e
    80006c4c:	02078793          	addi	a5,a5,32 # 804a4c68 <log>
    80006c50:	d398                	sw	a4,32(a5)
      release(&log.lock);
    80006c52:	0049e517          	auipc	a0,0x49e
    80006c56:	01650513          	addi	a0,a0,22 # 804a4c68 <log>
    80006c5a:	ffffa097          	auipc	ra,0xffffa
    80006c5e:	674080e7          	jalr	1652(ra) # 800012ce <release>
      break;
    80006c62:	0001                	nop
    }
  }
}
    80006c64:	0001                	nop
    80006c66:	60a2                	ld	ra,8(sp)
    80006c68:	6402                	ld	s0,0(sp)
    80006c6a:	0141                	addi	sp,sp,16
    80006c6c:	8082                	ret

0000000080006c6e <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80006c6e:	1101                	addi	sp,sp,-32
    80006c70:	ec06                	sd	ra,24(sp)
    80006c72:	e822                	sd	s0,16(sp)
    80006c74:	1000                	addi	s0,sp,32
  int do_commit = 0;
    80006c76:	fe042623          	sw	zero,-20(s0)

  acquire(&log.lock);
    80006c7a:	0049e517          	auipc	a0,0x49e
    80006c7e:	fee50513          	addi	a0,a0,-18 # 804a4c68 <log>
    80006c82:	ffffa097          	auipc	ra,0xffffa
    80006c86:	5e8080e7          	jalr	1512(ra) # 8000126a <acquire>
  log.outstanding -= 1;
    80006c8a:	0049e797          	auipc	a5,0x49e
    80006c8e:	fde78793          	addi	a5,a5,-34 # 804a4c68 <log>
    80006c92:	539c                	lw	a5,32(a5)
    80006c94:	37fd                	addiw	a5,a5,-1
    80006c96:	0007871b          	sext.w	a4,a5
    80006c9a:	0049e797          	auipc	a5,0x49e
    80006c9e:	fce78793          	addi	a5,a5,-50 # 804a4c68 <log>
    80006ca2:	d398                	sw	a4,32(a5)
  if(log.committing)
    80006ca4:	0049e797          	auipc	a5,0x49e
    80006ca8:	fc478793          	addi	a5,a5,-60 # 804a4c68 <log>
    80006cac:	53dc                	lw	a5,36(a5)
    80006cae:	cb89                	beqz	a5,80006cc0 <end_op+0x52>
    panic("log.committing");
    80006cb0:	00005517          	auipc	a0,0x5
    80006cb4:	a3050513          	addi	a0,a0,-1488 # 8000b6e0 <etext+0x6e0>
    80006cb8:	ffffa097          	auipc	ra,0xffffa
    80006cbc:	fc2080e7          	jalr	-62(ra) # 80000c7a <panic>
  if(log.outstanding == 0){
    80006cc0:	0049e797          	auipc	a5,0x49e
    80006cc4:	fa878793          	addi	a5,a5,-88 # 804a4c68 <log>
    80006cc8:	539c                	lw	a5,32(a5)
    80006cca:	eb99                	bnez	a5,80006ce0 <end_op+0x72>
    do_commit = 1;
    80006ccc:	4785                	li	a5,1
    80006cce:	fef42623          	sw	a5,-20(s0)
    log.committing = 1;
    80006cd2:	0049e797          	auipc	a5,0x49e
    80006cd6:	f9678793          	addi	a5,a5,-106 # 804a4c68 <log>
    80006cda:	4705                	li	a4,1
    80006cdc:	d3d8                	sw	a4,36(a5)
    80006cde:	a809                	j	80006cf0 <end_op+0x82>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
    80006ce0:	0049e517          	auipc	a0,0x49e
    80006ce4:	f8850513          	addi	a0,a0,-120 # 804a4c68 <log>
    80006ce8:	ffffd097          	auipc	ra,0xffffd
    80006cec:	c88080e7          	jalr	-888(ra) # 80003970 <wakeup>
  }
  release(&log.lock);
    80006cf0:	0049e517          	auipc	a0,0x49e
    80006cf4:	f7850513          	addi	a0,a0,-136 # 804a4c68 <log>
    80006cf8:	ffffa097          	auipc	ra,0xffffa
    80006cfc:	5d6080e7          	jalr	1494(ra) # 800012ce <release>

  if(do_commit){
    80006d00:	fec42783          	lw	a5,-20(s0)
    80006d04:	2781                	sext.w	a5,a5
    80006d06:	c3b9                	beqz	a5,80006d4c <end_op+0xde>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    80006d08:	00000097          	auipc	ra,0x0
    80006d0c:	134080e7          	jalr	308(ra) # 80006e3c <commit>
    acquire(&log.lock);
    80006d10:	0049e517          	auipc	a0,0x49e
    80006d14:	f5850513          	addi	a0,a0,-168 # 804a4c68 <log>
    80006d18:	ffffa097          	auipc	ra,0xffffa
    80006d1c:	552080e7          	jalr	1362(ra) # 8000126a <acquire>
    log.committing = 0;
    80006d20:	0049e797          	auipc	a5,0x49e
    80006d24:	f4878793          	addi	a5,a5,-184 # 804a4c68 <log>
    80006d28:	0207a223          	sw	zero,36(a5)
    wakeup(&log);
    80006d2c:	0049e517          	auipc	a0,0x49e
    80006d30:	f3c50513          	addi	a0,a0,-196 # 804a4c68 <log>
    80006d34:	ffffd097          	auipc	ra,0xffffd
    80006d38:	c3c080e7          	jalr	-964(ra) # 80003970 <wakeup>
    release(&log.lock);
    80006d3c:	0049e517          	auipc	a0,0x49e
    80006d40:	f2c50513          	addi	a0,a0,-212 # 804a4c68 <log>
    80006d44:	ffffa097          	auipc	ra,0xffffa
    80006d48:	58a080e7          	jalr	1418(ra) # 800012ce <release>
  }
}
    80006d4c:	0001                	nop
    80006d4e:	60e2                	ld	ra,24(sp)
    80006d50:	6442                	ld	s0,16(sp)
    80006d52:	6105                	addi	sp,sp,32
    80006d54:	8082                	ret

0000000080006d56 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
    80006d56:	7179                	addi	sp,sp,-48
    80006d58:	f406                	sd	ra,40(sp)
    80006d5a:	f022                	sd	s0,32(sp)
    80006d5c:	1800                	addi	s0,sp,48
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    80006d5e:	fe042623          	sw	zero,-20(s0)
    80006d62:	a86d                	j	80006e1c <write_log+0xc6>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80006d64:	0049e797          	auipc	a5,0x49e
    80006d68:	f0478793          	addi	a5,a5,-252 # 804a4c68 <log>
    80006d6c:	579c                	lw	a5,40(a5)
    80006d6e:	0007871b          	sext.w	a4,a5
    80006d72:	0049e797          	auipc	a5,0x49e
    80006d76:	ef678793          	addi	a5,a5,-266 # 804a4c68 <log>
    80006d7a:	4f9c                	lw	a5,24(a5)
    80006d7c:	fec42683          	lw	a3,-20(s0)
    80006d80:	9fb5                	addw	a5,a5,a3
    80006d82:	2781                	sext.w	a5,a5
    80006d84:	2785                	addiw	a5,a5,1
    80006d86:	2781                	sext.w	a5,a5
    80006d88:	2781                	sext.w	a5,a5
    80006d8a:	85be                	mv	a1,a5
    80006d8c:	853a                	mv	a0,a4
    80006d8e:	ffffe097          	auipc	ra,0xffffe
    80006d92:	3e6080e7          	jalr	998(ra) # 80005174 <bread>
    80006d96:	fea43023          	sd	a0,-32(s0)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80006d9a:	0049e797          	auipc	a5,0x49e
    80006d9e:	ece78793          	addi	a5,a5,-306 # 804a4c68 <log>
    80006da2:	579c                	lw	a5,40(a5)
    80006da4:	0007869b          	sext.w	a3,a5
    80006da8:	0049e717          	auipc	a4,0x49e
    80006dac:	ec070713          	addi	a4,a4,-320 # 804a4c68 <log>
    80006db0:	fec42783          	lw	a5,-20(s0)
    80006db4:	07a1                	addi	a5,a5,8
    80006db6:	078a                	slli	a5,a5,0x2
    80006db8:	97ba                	add	a5,a5,a4
    80006dba:	4b9c                	lw	a5,16(a5)
    80006dbc:	2781                	sext.w	a5,a5
    80006dbe:	85be                	mv	a1,a5
    80006dc0:	8536                	mv	a0,a3
    80006dc2:	ffffe097          	auipc	ra,0xffffe
    80006dc6:	3b2080e7          	jalr	946(ra) # 80005174 <bread>
    80006dca:	fca43c23          	sd	a0,-40(s0)
    memmove(to->data, from->data, BSIZE);
    80006dce:	fe043783          	ld	a5,-32(s0)
    80006dd2:	05878713          	addi	a4,a5,88
    80006dd6:	fd843783          	ld	a5,-40(s0)
    80006dda:	05878793          	addi	a5,a5,88
    80006dde:	40000613          	li	a2,1024
    80006de2:	85be                	mv	a1,a5
    80006de4:	853a                	mv	a0,a4
    80006de6:	ffffa097          	auipc	ra,0xffffa
    80006dea:	73c080e7          	jalr	1852(ra) # 80001522 <memmove>
    bwrite(to);  // write the log
    80006dee:	fe043503          	ld	a0,-32(s0)
    80006df2:	ffffe097          	auipc	ra,0xffffe
    80006df6:	3dc080e7          	jalr	988(ra) # 800051ce <bwrite>
    brelse(from);
    80006dfa:	fd843503          	ld	a0,-40(s0)
    80006dfe:	ffffe097          	auipc	ra,0xffffe
    80006e02:	418080e7          	jalr	1048(ra) # 80005216 <brelse>
    brelse(to);
    80006e06:	fe043503          	ld	a0,-32(s0)
    80006e0a:	ffffe097          	auipc	ra,0xffffe
    80006e0e:	40c080e7          	jalr	1036(ra) # 80005216 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80006e12:	fec42783          	lw	a5,-20(s0)
    80006e16:	2785                	addiw	a5,a5,1
    80006e18:	fef42623          	sw	a5,-20(s0)
    80006e1c:	0049e797          	auipc	a5,0x49e
    80006e20:	e4c78793          	addi	a5,a5,-436 # 804a4c68 <log>
    80006e24:	57d8                	lw	a4,44(a5)
    80006e26:	fec42783          	lw	a5,-20(s0)
    80006e2a:	2781                	sext.w	a5,a5
    80006e2c:	f2e7cce3          	blt	a5,a4,80006d64 <write_log+0xe>
  }
}
    80006e30:	0001                	nop
    80006e32:	0001                	nop
    80006e34:	70a2                	ld	ra,40(sp)
    80006e36:	7402                	ld	s0,32(sp)
    80006e38:	6145                	addi	sp,sp,48
    80006e3a:	8082                	ret

0000000080006e3c <commit>:

static void
commit()
{
    80006e3c:	1141                	addi	sp,sp,-16
    80006e3e:	e406                	sd	ra,8(sp)
    80006e40:	e022                	sd	s0,0(sp)
    80006e42:	0800                	addi	s0,sp,16
  if (log.lh.n > 0) {
    80006e44:	0049e797          	auipc	a5,0x49e
    80006e48:	e2478793          	addi	a5,a5,-476 # 804a4c68 <log>
    80006e4c:	57dc                	lw	a5,44(a5)
    80006e4e:	02f05963          	blez	a5,80006e80 <commit+0x44>
    write_log();     // Write modified blocks from cache to log
    80006e52:	00000097          	auipc	ra,0x0
    80006e56:	f04080e7          	jalr	-252(ra) # 80006d56 <write_log>
    write_head();    // Write header to disk -- the real commit
    80006e5a:	00000097          	auipc	ra,0x0
    80006e5e:	c64080e7          	jalr	-924(ra) # 80006abe <write_head>
    install_trans(0); // Now install writes to home locations
    80006e62:	4501                	li	a0,0
    80006e64:	00000097          	auipc	ra,0x0
    80006e68:	ab0080e7          	jalr	-1360(ra) # 80006914 <install_trans>
    log.lh.n = 0;
    80006e6c:	0049e797          	auipc	a5,0x49e
    80006e70:	dfc78793          	addi	a5,a5,-516 # 804a4c68 <log>
    80006e74:	0207a623          	sw	zero,44(a5)
    write_head();    // Erase the transaction from the log
    80006e78:	00000097          	auipc	ra,0x0
    80006e7c:	c46080e7          	jalr	-954(ra) # 80006abe <write_head>
  }
}
    80006e80:	0001                	nop
    80006e82:	60a2                	ld	ra,8(sp)
    80006e84:	6402                	ld	s0,0(sp)
    80006e86:	0141                	addi	sp,sp,16
    80006e88:	8082                	ret

0000000080006e8a <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80006e8a:	7179                	addi	sp,sp,-48
    80006e8c:	f406                	sd	ra,40(sp)
    80006e8e:	f022                	sd	s0,32(sp)
    80006e90:	1800                	addi	s0,sp,48
    80006e92:	fca43c23          	sd	a0,-40(s0)
  int i;

  acquire(&log.lock);
    80006e96:	0049e517          	auipc	a0,0x49e
    80006e9a:	dd250513          	addi	a0,a0,-558 # 804a4c68 <log>
    80006e9e:	ffffa097          	auipc	ra,0xffffa
    80006ea2:	3cc080e7          	jalr	972(ra) # 8000126a <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80006ea6:	0049e797          	auipc	a5,0x49e
    80006eaa:	dc278793          	addi	a5,a5,-574 # 804a4c68 <log>
    80006eae:	57dc                	lw	a5,44(a5)
    80006eb0:	873e                	mv	a4,a5
    80006eb2:	47f5                	li	a5,29
    80006eb4:	02e7c063          	blt	a5,a4,80006ed4 <log_write+0x4a>
    80006eb8:	0049e797          	auipc	a5,0x49e
    80006ebc:	db078793          	addi	a5,a5,-592 # 804a4c68 <log>
    80006ec0:	57d8                	lw	a4,44(a5)
    80006ec2:	0049e797          	auipc	a5,0x49e
    80006ec6:	da678793          	addi	a5,a5,-602 # 804a4c68 <log>
    80006eca:	4fdc                	lw	a5,28(a5)
    80006ecc:	37fd                	addiw	a5,a5,-1
    80006ece:	2781                	sext.w	a5,a5
    80006ed0:	00f74a63          	blt	a4,a5,80006ee4 <log_write+0x5a>
    panic("too big a transaction");
    80006ed4:	00005517          	auipc	a0,0x5
    80006ed8:	81c50513          	addi	a0,a0,-2020 # 8000b6f0 <etext+0x6f0>
    80006edc:	ffffa097          	auipc	ra,0xffffa
    80006ee0:	d9e080e7          	jalr	-610(ra) # 80000c7a <panic>
  if (log.outstanding < 1)
    80006ee4:	0049e797          	auipc	a5,0x49e
    80006ee8:	d8478793          	addi	a5,a5,-636 # 804a4c68 <log>
    80006eec:	539c                	lw	a5,32(a5)
    80006eee:	00f04a63          	bgtz	a5,80006f02 <log_write+0x78>
    panic("log_write outside of trans");
    80006ef2:	00005517          	auipc	a0,0x5
    80006ef6:	81650513          	addi	a0,a0,-2026 # 8000b708 <etext+0x708>
    80006efa:	ffffa097          	auipc	ra,0xffffa
    80006efe:	d80080e7          	jalr	-640(ra) # 80000c7a <panic>

  for (i = 0; i < log.lh.n; i++) {
    80006f02:	fe042623          	sw	zero,-20(s0)
    80006f06:	a03d                	j	80006f34 <log_write+0xaa>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80006f08:	0049e717          	auipc	a4,0x49e
    80006f0c:	d6070713          	addi	a4,a4,-672 # 804a4c68 <log>
    80006f10:	fec42783          	lw	a5,-20(s0)
    80006f14:	07a1                	addi	a5,a5,8
    80006f16:	078a                	slli	a5,a5,0x2
    80006f18:	97ba                	add	a5,a5,a4
    80006f1a:	4b9c                	lw	a5,16(a5)
    80006f1c:	0007871b          	sext.w	a4,a5
    80006f20:	fd843783          	ld	a5,-40(s0)
    80006f24:	47dc                	lw	a5,12(a5)
    80006f26:	02f70263          	beq	a4,a5,80006f4a <log_write+0xc0>
  for (i = 0; i < log.lh.n; i++) {
    80006f2a:	fec42783          	lw	a5,-20(s0)
    80006f2e:	2785                	addiw	a5,a5,1
    80006f30:	fef42623          	sw	a5,-20(s0)
    80006f34:	0049e797          	auipc	a5,0x49e
    80006f38:	d3478793          	addi	a5,a5,-716 # 804a4c68 <log>
    80006f3c:	57d8                	lw	a4,44(a5)
    80006f3e:	fec42783          	lw	a5,-20(s0)
    80006f42:	2781                	sext.w	a5,a5
    80006f44:	fce7c2e3          	blt	a5,a4,80006f08 <log_write+0x7e>
    80006f48:	a011                	j	80006f4c <log_write+0xc2>
      break;
    80006f4a:	0001                	nop
  }
  log.lh.block[i] = b->blockno;
    80006f4c:	fd843783          	ld	a5,-40(s0)
    80006f50:	47dc                	lw	a5,12(a5)
    80006f52:	0007871b          	sext.w	a4,a5
    80006f56:	0049e697          	auipc	a3,0x49e
    80006f5a:	d1268693          	addi	a3,a3,-750 # 804a4c68 <log>
    80006f5e:	fec42783          	lw	a5,-20(s0)
    80006f62:	07a1                	addi	a5,a5,8
    80006f64:	078a                	slli	a5,a5,0x2
    80006f66:	97b6                	add	a5,a5,a3
    80006f68:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    80006f6a:	0049e797          	auipc	a5,0x49e
    80006f6e:	cfe78793          	addi	a5,a5,-770 # 804a4c68 <log>
    80006f72:	57d8                	lw	a4,44(a5)
    80006f74:	fec42783          	lw	a5,-20(s0)
    80006f78:	2781                	sext.w	a5,a5
    80006f7a:	02e79563          	bne	a5,a4,80006fa4 <log_write+0x11a>
    bpin(b);
    80006f7e:	fd843503          	ld	a0,-40(s0)
    80006f82:	ffffe097          	auipc	ra,0xffffe
    80006f86:	382080e7          	jalr	898(ra) # 80005304 <bpin>
    log.lh.n++;
    80006f8a:	0049e797          	auipc	a5,0x49e
    80006f8e:	cde78793          	addi	a5,a5,-802 # 804a4c68 <log>
    80006f92:	57dc                	lw	a5,44(a5)
    80006f94:	2785                	addiw	a5,a5,1
    80006f96:	0007871b          	sext.w	a4,a5
    80006f9a:	0049e797          	auipc	a5,0x49e
    80006f9e:	cce78793          	addi	a5,a5,-818 # 804a4c68 <log>
    80006fa2:	d7d8                	sw	a4,44(a5)
  }
  release(&log.lock);
    80006fa4:	0049e517          	auipc	a0,0x49e
    80006fa8:	cc450513          	addi	a0,a0,-828 # 804a4c68 <log>
    80006fac:	ffffa097          	auipc	ra,0xffffa
    80006fb0:	322080e7          	jalr	802(ra) # 800012ce <release>
}
    80006fb4:	0001                	nop
    80006fb6:	70a2                	ld	ra,40(sp)
    80006fb8:	7402                	ld	s0,32(sp)
    80006fba:	6145                	addi	sp,sp,48
    80006fbc:	8082                	ret

0000000080006fbe <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80006fbe:	1101                	addi	sp,sp,-32
    80006fc0:	ec06                	sd	ra,24(sp)
    80006fc2:	e822                	sd	s0,16(sp)
    80006fc4:	1000                	addi	s0,sp,32
    80006fc6:	fea43423          	sd	a0,-24(s0)
    80006fca:	feb43023          	sd	a1,-32(s0)
  initlock(&lk->lk, "sleep lock");
    80006fce:	fe843783          	ld	a5,-24(s0)
    80006fd2:	07a1                	addi	a5,a5,8
    80006fd4:	00004597          	auipc	a1,0x4
    80006fd8:	75458593          	addi	a1,a1,1876 # 8000b728 <etext+0x728>
    80006fdc:	853e                	mv	a0,a5
    80006fde:	ffffa097          	auipc	ra,0xffffa
    80006fe2:	25c080e7          	jalr	604(ra) # 8000123a <initlock>
  lk->name = name;
    80006fe6:	fe843783          	ld	a5,-24(s0)
    80006fea:	fe043703          	ld	a4,-32(s0)
    80006fee:	f398                	sd	a4,32(a5)
  lk->locked = 0;
    80006ff0:	fe843783          	ld	a5,-24(s0)
    80006ff4:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    80006ff8:	fe843783          	ld	a5,-24(s0)
    80006ffc:	0207a423          	sw	zero,40(a5)
}
    80007000:	0001                	nop
    80007002:	60e2                	ld	ra,24(sp)
    80007004:	6442                	ld	s0,16(sp)
    80007006:	6105                	addi	sp,sp,32
    80007008:	8082                	ret

000000008000700a <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    8000700a:	1101                	addi	sp,sp,-32
    8000700c:	ec06                	sd	ra,24(sp)
    8000700e:	e822                	sd	s0,16(sp)
    80007010:	1000                	addi	s0,sp,32
    80007012:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    80007016:	fe843783          	ld	a5,-24(s0)
    8000701a:	07a1                	addi	a5,a5,8
    8000701c:	853e                	mv	a0,a5
    8000701e:	ffffa097          	auipc	ra,0xffffa
    80007022:	24c080e7          	jalr	588(ra) # 8000126a <acquire>
  while (lk->locked) {
    80007026:	a819                	j	8000703c <acquiresleep+0x32>
    sleep(lk, &lk->lk);
    80007028:	fe843783          	ld	a5,-24(s0)
    8000702c:	07a1                	addi	a5,a5,8
    8000702e:	85be                	mv	a1,a5
    80007030:	fe843503          	ld	a0,-24(s0)
    80007034:	ffffd097          	auipc	ra,0xffffd
    80007038:	8c0080e7          	jalr	-1856(ra) # 800038f4 <sleep>
  while (lk->locked) {
    8000703c:	fe843783          	ld	a5,-24(s0)
    80007040:	439c                	lw	a5,0(a5)
    80007042:	f3fd                	bnez	a5,80007028 <acquiresleep+0x1e>
  }
  lk->locked = 1;
    80007044:	fe843783          	ld	a5,-24(s0)
    80007048:	4705                	li	a4,1
    8000704a:	c398                	sw	a4,0(a5)
  lk->pid = myproc()->pid;
    8000704c:	ffffc097          	auipc	ra,0xffffc
    80007050:	9cc080e7          	jalr	-1588(ra) # 80002a18 <myproc>
    80007054:	87aa                	mv	a5,a0
    80007056:	5b98                	lw	a4,48(a5)
    80007058:	fe843783          	ld	a5,-24(s0)
    8000705c:	d798                	sw	a4,40(a5)
  release(&lk->lk);
    8000705e:	fe843783          	ld	a5,-24(s0)
    80007062:	07a1                	addi	a5,a5,8
    80007064:	853e                	mv	a0,a5
    80007066:	ffffa097          	auipc	ra,0xffffa
    8000706a:	268080e7          	jalr	616(ra) # 800012ce <release>
}
    8000706e:	0001                	nop
    80007070:	60e2                	ld	ra,24(sp)
    80007072:	6442                	ld	s0,16(sp)
    80007074:	6105                	addi	sp,sp,32
    80007076:	8082                	ret

0000000080007078 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80007078:	1101                	addi	sp,sp,-32
    8000707a:	ec06                	sd	ra,24(sp)
    8000707c:	e822                	sd	s0,16(sp)
    8000707e:	1000                	addi	s0,sp,32
    80007080:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    80007084:	fe843783          	ld	a5,-24(s0)
    80007088:	07a1                	addi	a5,a5,8
    8000708a:	853e                	mv	a0,a5
    8000708c:	ffffa097          	auipc	ra,0xffffa
    80007090:	1de080e7          	jalr	478(ra) # 8000126a <acquire>
  lk->locked = 0;
    80007094:	fe843783          	ld	a5,-24(s0)
    80007098:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    8000709c:	fe843783          	ld	a5,-24(s0)
    800070a0:	0207a423          	sw	zero,40(a5)
  wakeup(lk);
    800070a4:	fe843503          	ld	a0,-24(s0)
    800070a8:	ffffd097          	auipc	ra,0xffffd
    800070ac:	8c8080e7          	jalr	-1848(ra) # 80003970 <wakeup>
  release(&lk->lk);
    800070b0:	fe843783          	ld	a5,-24(s0)
    800070b4:	07a1                	addi	a5,a5,8
    800070b6:	853e                	mv	a0,a5
    800070b8:	ffffa097          	auipc	ra,0xffffa
    800070bc:	216080e7          	jalr	534(ra) # 800012ce <release>
}
    800070c0:	0001                	nop
    800070c2:	60e2                	ld	ra,24(sp)
    800070c4:	6442                	ld	s0,16(sp)
    800070c6:	6105                	addi	sp,sp,32
    800070c8:	8082                	ret

00000000800070ca <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800070ca:	7139                	addi	sp,sp,-64
    800070cc:	fc06                	sd	ra,56(sp)
    800070ce:	f822                	sd	s0,48(sp)
    800070d0:	f426                	sd	s1,40(sp)
    800070d2:	0080                	addi	s0,sp,64
    800070d4:	fca43423          	sd	a0,-56(s0)
  int r;
  
  acquire(&lk->lk);
    800070d8:	fc843783          	ld	a5,-56(s0)
    800070dc:	07a1                	addi	a5,a5,8
    800070de:	853e                	mv	a0,a5
    800070e0:	ffffa097          	auipc	ra,0xffffa
    800070e4:	18a080e7          	jalr	394(ra) # 8000126a <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800070e8:	fc843783          	ld	a5,-56(s0)
    800070ec:	439c                	lw	a5,0(a5)
    800070ee:	cf99                	beqz	a5,8000710c <holdingsleep+0x42>
    800070f0:	fc843783          	ld	a5,-56(s0)
    800070f4:	5784                	lw	s1,40(a5)
    800070f6:	ffffc097          	auipc	ra,0xffffc
    800070fa:	922080e7          	jalr	-1758(ra) # 80002a18 <myproc>
    800070fe:	87aa                	mv	a5,a0
    80007100:	5b9c                	lw	a5,48(a5)
    80007102:	8726                	mv	a4,s1
    80007104:	00f71463          	bne	a4,a5,8000710c <holdingsleep+0x42>
    80007108:	4785                	li	a5,1
    8000710a:	a011                	j	8000710e <holdingsleep+0x44>
    8000710c:	4781                	li	a5,0
    8000710e:	fcf42e23          	sw	a5,-36(s0)
  release(&lk->lk);
    80007112:	fc843783          	ld	a5,-56(s0)
    80007116:	07a1                	addi	a5,a5,8
    80007118:	853e                	mv	a0,a5
    8000711a:	ffffa097          	auipc	ra,0xffffa
    8000711e:	1b4080e7          	jalr	436(ra) # 800012ce <release>
  return r;
    80007122:	fdc42783          	lw	a5,-36(s0)
}
    80007126:	853e                	mv	a0,a5
    80007128:	70e2                	ld	ra,56(sp)
    8000712a:	7442                	ld	s0,48(sp)
    8000712c:	74a2                	ld	s1,40(sp)
    8000712e:	6121                	addi	sp,sp,64
    80007130:	8082                	ret

0000000080007132 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80007132:	1141                	addi	sp,sp,-16
    80007134:	e406                	sd	ra,8(sp)
    80007136:	e022                	sd	s0,0(sp)
    80007138:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    8000713a:	00004597          	auipc	a1,0x4
    8000713e:	5fe58593          	addi	a1,a1,1534 # 8000b738 <etext+0x738>
    80007142:	0049e517          	auipc	a0,0x49e
    80007146:	c6e50513          	addi	a0,a0,-914 # 804a4db0 <ftable>
    8000714a:	ffffa097          	auipc	ra,0xffffa
    8000714e:	0f0080e7          	jalr	240(ra) # 8000123a <initlock>
}
    80007152:	0001                	nop
    80007154:	60a2                	ld	ra,8(sp)
    80007156:	6402                	ld	s0,0(sp)
    80007158:	0141                	addi	sp,sp,16
    8000715a:	8082                	ret

000000008000715c <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    8000715c:	1101                	addi	sp,sp,-32
    8000715e:	ec06                	sd	ra,24(sp)
    80007160:	e822                	sd	s0,16(sp)
    80007162:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80007164:	0049e517          	auipc	a0,0x49e
    80007168:	c4c50513          	addi	a0,a0,-948 # 804a4db0 <ftable>
    8000716c:	ffffa097          	auipc	ra,0xffffa
    80007170:	0fe080e7          	jalr	254(ra) # 8000126a <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80007174:	0049e797          	auipc	a5,0x49e
    80007178:	c5478793          	addi	a5,a5,-940 # 804a4dc8 <ftable+0x18>
    8000717c:	fef43423          	sd	a5,-24(s0)
    80007180:	a815                	j	800071b4 <filealloc+0x58>
    if(f->ref == 0){
    80007182:	fe843783          	ld	a5,-24(s0)
    80007186:	43dc                	lw	a5,4(a5)
    80007188:	e385                	bnez	a5,800071a8 <filealloc+0x4c>
      f->ref = 1;
    8000718a:	fe843783          	ld	a5,-24(s0)
    8000718e:	4705                	li	a4,1
    80007190:	c3d8                	sw	a4,4(a5)
      release(&ftable.lock);
    80007192:	0049e517          	auipc	a0,0x49e
    80007196:	c1e50513          	addi	a0,a0,-994 # 804a4db0 <ftable>
    8000719a:	ffffa097          	auipc	ra,0xffffa
    8000719e:	134080e7          	jalr	308(ra) # 800012ce <release>
      return f;
    800071a2:	fe843783          	ld	a5,-24(s0)
    800071a6:	a805                	j	800071d6 <filealloc+0x7a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800071a8:	fe843783          	ld	a5,-24(s0)
    800071ac:	02878793          	addi	a5,a5,40
    800071b0:	fef43423          	sd	a5,-24(s0)
    800071b4:	0049f797          	auipc	a5,0x49f
    800071b8:	bb478793          	addi	a5,a5,-1100 # 804a5d68 <ftable+0xfb8>
    800071bc:	fe843703          	ld	a4,-24(s0)
    800071c0:	fcf761e3          	bltu	a4,a5,80007182 <filealloc+0x26>
    }
  }
  release(&ftable.lock);
    800071c4:	0049e517          	auipc	a0,0x49e
    800071c8:	bec50513          	addi	a0,a0,-1044 # 804a4db0 <ftable>
    800071cc:	ffffa097          	auipc	ra,0xffffa
    800071d0:	102080e7          	jalr	258(ra) # 800012ce <release>
  return 0;
    800071d4:	4781                	li	a5,0
}
    800071d6:	853e                	mv	a0,a5
    800071d8:	60e2                	ld	ra,24(sp)
    800071da:	6442                	ld	s0,16(sp)
    800071dc:	6105                	addi	sp,sp,32
    800071de:	8082                	ret

00000000800071e0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    800071e0:	1101                	addi	sp,sp,-32
    800071e2:	ec06                	sd	ra,24(sp)
    800071e4:	e822                	sd	s0,16(sp)
    800071e6:	1000                	addi	s0,sp,32
    800071e8:	fea43423          	sd	a0,-24(s0)
  acquire(&ftable.lock);
    800071ec:	0049e517          	auipc	a0,0x49e
    800071f0:	bc450513          	addi	a0,a0,-1084 # 804a4db0 <ftable>
    800071f4:	ffffa097          	auipc	ra,0xffffa
    800071f8:	076080e7          	jalr	118(ra) # 8000126a <acquire>
  if(f->ref < 1)
    800071fc:	fe843783          	ld	a5,-24(s0)
    80007200:	43dc                	lw	a5,4(a5)
    80007202:	00f04a63          	bgtz	a5,80007216 <filedup+0x36>
    panic("filedup");
    80007206:	00004517          	auipc	a0,0x4
    8000720a:	53a50513          	addi	a0,a0,1338 # 8000b740 <etext+0x740>
    8000720e:	ffffa097          	auipc	ra,0xffffa
    80007212:	a6c080e7          	jalr	-1428(ra) # 80000c7a <panic>
  f->ref++;
    80007216:	fe843783          	ld	a5,-24(s0)
    8000721a:	43dc                	lw	a5,4(a5)
    8000721c:	2785                	addiw	a5,a5,1
    8000721e:	0007871b          	sext.w	a4,a5
    80007222:	fe843783          	ld	a5,-24(s0)
    80007226:	c3d8                	sw	a4,4(a5)
  release(&ftable.lock);
    80007228:	0049e517          	auipc	a0,0x49e
    8000722c:	b8850513          	addi	a0,a0,-1144 # 804a4db0 <ftable>
    80007230:	ffffa097          	auipc	ra,0xffffa
    80007234:	09e080e7          	jalr	158(ra) # 800012ce <release>
  return f;
    80007238:	fe843783          	ld	a5,-24(s0)
}
    8000723c:	853e                	mv	a0,a5
    8000723e:	60e2                	ld	ra,24(sp)
    80007240:	6442                	ld	s0,16(sp)
    80007242:	6105                	addi	sp,sp,32
    80007244:	8082                	ret

0000000080007246 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80007246:	715d                	addi	sp,sp,-80
    80007248:	e486                	sd	ra,72(sp)
    8000724a:	e0a2                	sd	s0,64(sp)
    8000724c:	0880                	addi	s0,sp,80
    8000724e:	faa43c23          	sd	a0,-72(s0)
  struct file ff;

  acquire(&ftable.lock);
    80007252:	0049e517          	auipc	a0,0x49e
    80007256:	b5e50513          	addi	a0,a0,-1186 # 804a4db0 <ftable>
    8000725a:	ffffa097          	auipc	ra,0xffffa
    8000725e:	010080e7          	jalr	16(ra) # 8000126a <acquire>
  if(f->ref < 1)
    80007262:	fb843783          	ld	a5,-72(s0)
    80007266:	43dc                	lw	a5,4(a5)
    80007268:	00f04a63          	bgtz	a5,8000727c <fileclose+0x36>
    panic("fileclose");
    8000726c:	00004517          	auipc	a0,0x4
    80007270:	4dc50513          	addi	a0,a0,1244 # 8000b748 <etext+0x748>
    80007274:	ffffa097          	auipc	ra,0xffffa
    80007278:	a06080e7          	jalr	-1530(ra) # 80000c7a <panic>
  if(--f->ref > 0){
    8000727c:	fb843783          	ld	a5,-72(s0)
    80007280:	43dc                	lw	a5,4(a5)
    80007282:	37fd                	addiw	a5,a5,-1
    80007284:	0007871b          	sext.w	a4,a5
    80007288:	fb843783          	ld	a5,-72(s0)
    8000728c:	c3d8                	sw	a4,4(a5)
    8000728e:	fb843783          	ld	a5,-72(s0)
    80007292:	43dc                	lw	a5,4(a5)
    80007294:	00f05b63          	blez	a5,800072aa <fileclose+0x64>
    release(&ftable.lock);
    80007298:	0049e517          	auipc	a0,0x49e
    8000729c:	b1850513          	addi	a0,a0,-1256 # 804a4db0 <ftable>
    800072a0:	ffffa097          	auipc	ra,0xffffa
    800072a4:	02e080e7          	jalr	46(ra) # 800012ce <release>
    800072a8:	a879                	j	80007346 <fileclose+0x100>
    return;
  }
  ff = *f;
    800072aa:	fb843783          	ld	a5,-72(s0)
    800072ae:	638c                	ld	a1,0(a5)
    800072b0:	6790                	ld	a2,8(a5)
    800072b2:	6b94                	ld	a3,16(a5)
    800072b4:	6f98                	ld	a4,24(a5)
    800072b6:	739c                	ld	a5,32(a5)
    800072b8:	fcb43423          	sd	a1,-56(s0)
    800072bc:	fcc43823          	sd	a2,-48(s0)
    800072c0:	fcd43c23          	sd	a3,-40(s0)
    800072c4:	fee43023          	sd	a4,-32(s0)
    800072c8:	fef43423          	sd	a5,-24(s0)
  f->ref = 0;
    800072cc:	fb843783          	ld	a5,-72(s0)
    800072d0:	0007a223          	sw	zero,4(a5)
  f->type = FD_NONE;
    800072d4:	fb843783          	ld	a5,-72(s0)
    800072d8:	0007a023          	sw	zero,0(a5)
  release(&ftable.lock);
    800072dc:	0049e517          	auipc	a0,0x49e
    800072e0:	ad450513          	addi	a0,a0,-1324 # 804a4db0 <ftable>
    800072e4:	ffffa097          	auipc	ra,0xffffa
    800072e8:	fea080e7          	jalr	-22(ra) # 800012ce <release>

  if(ff.type == FD_PIPE){
    800072ec:	fc842783          	lw	a5,-56(s0)
    800072f0:	873e                	mv	a4,a5
    800072f2:	4785                	li	a5,1
    800072f4:	00f71e63          	bne	a4,a5,80007310 <fileclose+0xca>
    pipeclose(ff.pipe, ff.writable);
    800072f8:	fd843783          	ld	a5,-40(s0)
    800072fc:	fd144703          	lbu	a4,-47(s0)
    80007300:	2701                	sext.w	a4,a4
    80007302:	85ba                	mv	a1,a4
    80007304:	853e                	mv	a0,a5
    80007306:	00000097          	auipc	ra,0x0
    8000730a:	5b6080e7          	jalr	1462(ra) # 800078bc <pipeclose>
    8000730e:	a825                	j	80007346 <fileclose+0x100>
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80007310:	fc842783          	lw	a5,-56(s0)
    80007314:	873e                	mv	a4,a5
    80007316:	4789                	li	a5,2
    80007318:	00f70863          	beq	a4,a5,80007328 <fileclose+0xe2>
    8000731c:	fc842783          	lw	a5,-56(s0)
    80007320:	873e                	mv	a4,a5
    80007322:	478d                	li	a5,3
    80007324:	02f71163          	bne	a4,a5,80007346 <fileclose+0x100>
    begin_op();
    80007328:	00000097          	auipc	ra,0x0
    8000732c:	884080e7          	jalr	-1916(ra) # 80006bac <begin_op>
    iput(ff.ip);
    80007330:	fe043783          	ld	a5,-32(s0)
    80007334:	853e                	mv	a0,a5
    80007336:	fffff097          	auipc	ra,0xfffff
    8000733a:	99c080e7          	jalr	-1636(ra) # 80005cd2 <iput>
    end_op();
    8000733e:	00000097          	auipc	ra,0x0
    80007342:	930080e7          	jalr	-1744(ra) # 80006c6e <end_op>
  }
}
    80007346:	60a6                	ld	ra,72(sp)
    80007348:	6406                	ld	s0,64(sp)
    8000734a:	6161                	addi	sp,sp,80
    8000734c:	8082                	ret

000000008000734e <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    8000734e:	7139                	addi	sp,sp,-64
    80007350:	fc06                	sd	ra,56(sp)
    80007352:	f822                	sd	s0,48(sp)
    80007354:	0080                	addi	s0,sp,64
    80007356:	fca43423          	sd	a0,-56(s0)
    8000735a:	fcb43023          	sd	a1,-64(s0)
  struct proc *p = myproc();
    8000735e:	ffffb097          	auipc	ra,0xffffb
    80007362:	6ba080e7          	jalr	1722(ra) # 80002a18 <myproc>
    80007366:	fea43423          	sd	a0,-24(s0)
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    8000736a:	fc843783          	ld	a5,-56(s0)
    8000736e:	439c                	lw	a5,0(a5)
    80007370:	873e                	mv	a4,a5
    80007372:	4789                	li	a5,2
    80007374:	00f70963          	beq	a4,a5,80007386 <filestat+0x38>
    80007378:	fc843783          	ld	a5,-56(s0)
    8000737c:	439c                	lw	a5,0(a5)
    8000737e:	873e                	mv	a4,a5
    80007380:	478d                	li	a5,3
    80007382:	06f71263          	bne	a4,a5,800073e6 <filestat+0x98>
    ilock(f->ip);
    80007386:	fc843783          	ld	a5,-56(s0)
    8000738a:	6f9c                	ld	a5,24(a5)
    8000738c:	853e                	mv	a0,a5
    8000738e:	ffffe097          	auipc	ra,0xffffe
    80007392:	7b6080e7          	jalr	1974(ra) # 80005b44 <ilock>
    stati(f->ip, &st);
    80007396:	fc843783          	ld	a5,-56(s0)
    8000739a:	6f9c                	ld	a5,24(a5)
    8000739c:	fd040713          	addi	a4,s0,-48
    800073a0:	85ba                	mv	a1,a4
    800073a2:	853e                	mv	a0,a5
    800073a4:	fffff097          	auipc	ra,0xfffff
    800073a8:	cd2080e7          	jalr	-814(ra) # 80006076 <stati>
    iunlock(f->ip);
    800073ac:	fc843783          	ld	a5,-56(s0)
    800073b0:	6f9c                	ld	a5,24(a5)
    800073b2:	853e                	mv	a0,a5
    800073b4:	fffff097          	auipc	ra,0xfffff
    800073b8:	8c4080e7          	jalr	-1852(ra) # 80005c78 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    800073bc:	fe843783          	ld	a5,-24(s0)
    800073c0:	6bbc                	ld	a5,80(a5)
    800073c2:	fd040713          	addi	a4,s0,-48
    800073c6:	46e1                	li	a3,24
    800073c8:	863a                	mv	a2,a4
    800073ca:	fc043583          	ld	a1,-64(s0)
    800073ce:	853e                	mv	a0,a5
    800073d0:	ffffb097          	auipc	ra,0xffffb
    800073d4:	ff6080e7          	jalr	-10(ra) # 800023c6 <copyout>
    800073d8:	87aa                	mv	a5,a0
    800073da:	0007d463          	bgez	a5,800073e2 <filestat+0x94>
      return -1;
    800073de:	57fd                	li	a5,-1
    800073e0:	a021                	j	800073e8 <filestat+0x9a>
    return 0;
    800073e2:	4781                	li	a5,0
    800073e4:	a011                	j	800073e8 <filestat+0x9a>
  }
  return -1;
    800073e6:	57fd                	li	a5,-1
}
    800073e8:	853e                	mv	a0,a5
    800073ea:	70e2                	ld	ra,56(sp)
    800073ec:	7442                	ld	s0,48(sp)
    800073ee:	6121                	addi	sp,sp,64
    800073f0:	8082                	ret

00000000800073f2 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    800073f2:	7139                	addi	sp,sp,-64
    800073f4:	fc06                	sd	ra,56(sp)
    800073f6:	f822                	sd	s0,48(sp)
    800073f8:	0080                	addi	s0,sp,64
    800073fa:	fca43c23          	sd	a0,-40(s0)
    800073fe:	fcb43823          	sd	a1,-48(s0)
    80007402:	87b2                	mv	a5,a2
    80007404:	fcf42623          	sw	a5,-52(s0)
  int r = 0;
    80007408:	fe042623          	sw	zero,-20(s0)

  if(f->readable == 0)
    8000740c:	fd843783          	ld	a5,-40(s0)
    80007410:	0087c783          	lbu	a5,8(a5)
    80007414:	e399                	bnez	a5,8000741a <fileread+0x28>
    return -1;
    80007416:	57fd                	li	a5,-1
    80007418:	aa1d                	j	8000754e <fileread+0x15c>

  if(f->type == FD_PIPE){
    8000741a:	fd843783          	ld	a5,-40(s0)
    8000741e:	439c                	lw	a5,0(a5)
    80007420:	873e                	mv	a4,a5
    80007422:	4785                	li	a5,1
    80007424:	02f71363          	bne	a4,a5,8000744a <fileread+0x58>
    r = piperead(f->pipe, addr, n);
    80007428:	fd843783          	ld	a5,-40(s0)
    8000742c:	6b9c                	ld	a5,16(a5)
    8000742e:	fcc42703          	lw	a4,-52(s0)
    80007432:	863a                	mv	a2,a4
    80007434:	fd043583          	ld	a1,-48(s0)
    80007438:	853e                	mv	a0,a5
    8000743a:	00000097          	auipc	ra,0x0
    8000743e:	676080e7          	jalr	1654(ra) # 80007ab0 <piperead>
    80007442:	87aa                	mv	a5,a0
    80007444:	fef42623          	sw	a5,-20(s0)
    80007448:	a209                	j	8000754a <fileread+0x158>
  } else if(f->type == FD_DEVICE){
    8000744a:	fd843783          	ld	a5,-40(s0)
    8000744e:	439c                	lw	a5,0(a5)
    80007450:	873e                	mv	a4,a5
    80007452:	478d                	li	a5,3
    80007454:	06f71863          	bne	a4,a5,800074c4 <fileread+0xd2>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80007458:	fd843783          	ld	a5,-40(s0)
    8000745c:	02479783          	lh	a5,36(a5)
    80007460:	2781                	sext.w	a5,a5
    80007462:	0207c863          	bltz	a5,80007492 <fileread+0xa0>
    80007466:	fd843783          	ld	a5,-40(s0)
    8000746a:	02479783          	lh	a5,36(a5)
    8000746e:	0007871b          	sext.w	a4,a5
    80007472:	47a5                	li	a5,9
    80007474:	00e7cf63          	blt	a5,a4,80007492 <fileread+0xa0>
    80007478:	fd843783          	ld	a5,-40(s0)
    8000747c:	02479783          	lh	a5,36(a5)
    80007480:	2781                	sext.w	a5,a5
    80007482:	0049e717          	auipc	a4,0x49e
    80007486:	88e70713          	addi	a4,a4,-1906 # 804a4d10 <devsw>
    8000748a:	0792                	slli	a5,a5,0x4
    8000748c:	97ba                	add	a5,a5,a4
    8000748e:	639c                	ld	a5,0(a5)
    80007490:	e399                	bnez	a5,80007496 <fileread+0xa4>
      return -1;
    80007492:	57fd                	li	a5,-1
    80007494:	a86d                	j	8000754e <fileread+0x15c>
    r = devsw[f->major].read(1, addr, n);
    80007496:	fd843783          	ld	a5,-40(s0)
    8000749a:	02479783          	lh	a5,36(a5)
    8000749e:	2781                	sext.w	a5,a5
    800074a0:	0049e717          	auipc	a4,0x49e
    800074a4:	87070713          	addi	a4,a4,-1936 # 804a4d10 <devsw>
    800074a8:	0792                	slli	a5,a5,0x4
    800074aa:	97ba                	add	a5,a5,a4
    800074ac:	6398                	ld	a4,0(a5)
    800074ae:	fcc42783          	lw	a5,-52(s0)
    800074b2:	863e                	mv	a2,a5
    800074b4:	fd043583          	ld	a1,-48(s0)
    800074b8:	4505                	li	a0,1
    800074ba:	9702                	jalr	a4
    800074bc:	87aa                	mv	a5,a0
    800074be:	fef42623          	sw	a5,-20(s0)
    800074c2:	a061                	j	8000754a <fileread+0x158>
  } else if(f->type == FD_INODE){
    800074c4:	fd843783          	ld	a5,-40(s0)
    800074c8:	439c                	lw	a5,0(a5)
    800074ca:	873e                	mv	a4,a5
    800074cc:	4789                	li	a5,2
    800074ce:	06f71663          	bne	a4,a5,8000753a <fileread+0x148>
    ilock(f->ip);
    800074d2:	fd843783          	ld	a5,-40(s0)
    800074d6:	6f9c                	ld	a5,24(a5)
    800074d8:	853e                	mv	a0,a5
    800074da:	ffffe097          	auipc	ra,0xffffe
    800074de:	66a080e7          	jalr	1642(ra) # 80005b44 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    800074e2:	fd843783          	ld	a5,-40(s0)
    800074e6:	6f88                	ld	a0,24(a5)
    800074e8:	fd843783          	ld	a5,-40(s0)
    800074ec:	539c                	lw	a5,32(a5)
    800074ee:	fcc42703          	lw	a4,-52(s0)
    800074f2:	86be                	mv	a3,a5
    800074f4:	fd043603          	ld	a2,-48(s0)
    800074f8:	4585                	li	a1,1
    800074fa:	fffff097          	auipc	ra,0xfffff
    800074fe:	be0080e7          	jalr	-1056(ra) # 800060da <readi>
    80007502:	87aa                	mv	a5,a0
    80007504:	fef42623          	sw	a5,-20(s0)
    80007508:	fec42783          	lw	a5,-20(s0)
    8000750c:	2781                	sext.w	a5,a5
    8000750e:	00f05d63          	blez	a5,80007528 <fileread+0x136>
      f->off += r;
    80007512:	fd843783          	ld	a5,-40(s0)
    80007516:	5398                	lw	a4,32(a5)
    80007518:	fec42783          	lw	a5,-20(s0)
    8000751c:	9fb9                	addw	a5,a5,a4
    8000751e:	0007871b          	sext.w	a4,a5
    80007522:	fd843783          	ld	a5,-40(s0)
    80007526:	d398                	sw	a4,32(a5)
    iunlock(f->ip);
    80007528:	fd843783          	ld	a5,-40(s0)
    8000752c:	6f9c                	ld	a5,24(a5)
    8000752e:	853e                	mv	a0,a5
    80007530:	ffffe097          	auipc	ra,0xffffe
    80007534:	748080e7          	jalr	1864(ra) # 80005c78 <iunlock>
    80007538:	a809                	j	8000754a <fileread+0x158>
  } else {
    panic("fileread");
    8000753a:	00004517          	auipc	a0,0x4
    8000753e:	21e50513          	addi	a0,a0,542 # 8000b758 <etext+0x758>
    80007542:	ffff9097          	auipc	ra,0xffff9
    80007546:	738080e7          	jalr	1848(ra) # 80000c7a <panic>
  }

  return r;
    8000754a:	fec42783          	lw	a5,-20(s0)
}
    8000754e:	853e                	mv	a0,a5
    80007550:	70e2                	ld	ra,56(sp)
    80007552:	7442                	ld	s0,48(sp)
    80007554:	6121                	addi	sp,sp,64
    80007556:	8082                	ret

0000000080007558 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80007558:	715d                	addi	sp,sp,-80
    8000755a:	e486                	sd	ra,72(sp)
    8000755c:	e0a2                	sd	s0,64(sp)
    8000755e:	0880                	addi	s0,sp,80
    80007560:	fca43423          	sd	a0,-56(s0)
    80007564:	fcb43023          	sd	a1,-64(s0)
    80007568:	87b2                	mv	a5,a2
    8000756a:	faf42e23          	sw	a5,-68(s0)
  int r, ret = 0;
    8000756e:	fe042623          	sw	zero,-20(s0)

  if(f->writable == 0)
    80007572:	fc843783          	ld	a5,-56(s0)
    80007576:	0097c783          	lbu	a5,9(a5)
    8000757a:	e399                	bnez	a5,80007580 <filewrite+0x28>
    return -1;
    8000757c:	57fd                	li	a5,-1
    8000757e:	a2c5                	j	8000775e <filewrite+0x206>

  if(f->type == FD_PIPE){
    80007580:	fc843783          	ld	a5,-56(s0)
    80007584:	439c                	lw	a5,0(a5)
    80007586:	873e                	mv	a4,a5
    80007588:	4785                	li	a5,1
    8000758a:	02f71363          	bne	a4,a5,800075b0 <filewrite+0x58>
    ret = pipewrite(f->pipe, addr, n);
    8000758e:	fc843783          	ld	a5,-56(s0)
    80007592:	6b9c                	ld	a5,16(a5)
    80007594:	fbc42703          	lw	a4,-68(s0)
    80007598:	863a                	mv	a2,a4
    8000759a:	fc043583          	ld	a1,-64(s0)
    8000759e:	853e                	mv	a0,a5
    800075a0:	00000097          	auipc	ra,0x0
    800075a4:	3c4080e7          	jalr	964(ra) # 80007964 <pipewrite>
    800075a8:	87aa                	mv	a5,a0
    800075aa:	fef42623          	sw	a5,-20(s0)
    800075ae:	a275                	j	8000775a <filewrite+0x202>
  } else if(f->type == FD_DEVICE){
    800075b0:	fc843783          	ld	a5,-56(s0)
    800075b4:	439c                	lw	a5,0(a5)
    800075b6:	873e                	mv	a4,a5
    800075b8:	478d                	li	a5,3
    800075ba:	06f71863          	bne	a4,a5,8000762a <filewrite+0xd2>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    800075be:	fc843783          	ld	a5,-56(s0)
    800075c2:	02479783          	lh	a5,36(a5)
    800075c6:	2781                	sext.w	a5,a5
    800075c8:	0207c863          	bltz	a5,800075f8 <filewrite+0xa0>
    800075cc:	fc843783          	ld	a5,-56(s0)
    800075d0:	02479783          	lh	a5,36(a5)
    800075d4:	0007871b          	sext.w	a4,a5
    800075d8:	47a5                	li	a5,9
    800075da:	00e7cf63          	blt	a5,a4,800075f8 <filewrite+0xa0>
    800075de:	fc843783          	ld	a5,-56(s0)
    800075e2:	02479783          	lh	a5,36(a5)
    800075e6:	2781                	sext.w	a5,a5
    800075e8:	0049d717          	auipc	a4,0x49d
    800075ec:	72870713          	addi	a4,a4,1832 # 804a4d10 <devsw>
    800075f0:	0792                	slli	a5,a5,0x4
    800075f2:	97ba                	add	a5,a5,a4
    800075f4:	679c                	ld	a5,8(a5)
    800075f6:	e399                	bnez	a5,800075fc <filewrite+0xa4>
      return -1;
    800075f8:	57fd                	li	a5,-1
    800075fa:	a295                	j	8000775e <filewrite+0x206>
    ret = devsw[f->major].write(1, addr, n);
    800075fc:	fc843783          	ld	a5,-56(s0)
    80007600:	02479783          	lh	a5,36(a5)
    80007604:	2781                	sext.w	a5,a5
    80007606:	0049d717          	auipc	a4,0x49d
    8000760a:	70a70713          	addi	a4,a4,1802 # 804a4d10 <devsw>
    8000760e:	0792                	slli	a5,a5,0x4
    80007610:	97ba                	add	a5,a5,a4
    80007612:	6798                	ld	a4,8(a5)
    80007614:	fbc42783          	lw	a5,-68(s0)
    80007618:	863e                	mv	a2,a5
    8000761a:	fc043583          	ld	a1,-64(s0)
    8000761e:	4505                	li	a0,1
    80007620:	9702                	jalr	a4
    80007622:	87aa                	mv	a5,a0
    80007624:	fef42623          	sw	a5,-20(s0)
    80007628:	aa0d                	j	8000775a <filewrite+0x202>
  } else if(f->type == FD_INODE){
    8000762a:	fc843783          	ld	a5,-56(s0)
    8000762e:	439c                	lw	a5,0(a5)
    80007630:	873e                	mv	a4,a5
    80007632:	4789                	li	a5,2
    80007634:	10f71b63          	bne	a4,a5,8000774a <filewrite+0x1f2>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    80007638:	6785                	lui	a5,0x1
    8000763a:	c0078793          	addi	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    8000763e:	fef42023          	sw	a5,-32(s0)
    int i = 0;
    80007642:	fe042423          	sw	zero,-24(s0)
    while(i < n){
    80007646:	a0f9                	j	80007714 <filewrite+0x1bc>
      int n1 = n - i;
    80007648:	fbc42783          	lw	a5,-68(s0)
    8000764c:	873e                	mv	a4,a5
    8000764e:	fe842783          	lw	a5,-24(s0)
    80007652:	40f707bb          	subw	a5,a4,a5
    80007656:	fef42223          	sw	a5,-28(s0)
      if(n1 > max)
    8000765a:	fe442783          	lw	a5,-28(s0)
    8000765e:	873e                	mv	a4,a5
    80007660:	fe042783          	lw	a5,-32(s0)
    80007664:	2701                	sext.w	a4,a4
    80007666:	2781                	sext.w	a5,a5
    80007668:	00e7d663          	bge	a5,a4,80007674 <filewrite+0x11c>
        n1 = max;
    8000766c:	fe042783          	lw	a5,-32(s0)
    80007670:	fef42223          	sw	a5,-28(s0)

      begin_op();
    80007674:	fffff097          	auipc	ra,0xfffff
    80007678:	538080e7          	jalr	1336(ra) # 80006bac <begin_op>
      ilock(f->ip);
    8000767c:	fc843783          	ld	a5,-56(s0)
    80007680:	6f9c                	ld	a5,24(a5)
    80007682:	853e                	mv	a0,a5
    80007684:	ffffe097          	auipc	ra,0xffffe
    80007688:	4c0080e7          	jalr	1216(ra) # 80005b44 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    8000768c:	fc843783          	ld	a5,-56(s0)
    80007690:	6f88                	ld	a0,24(a5)
    80007692:	fe842703          	lw	a4,-24(s0)
    80007696:	fc043783          	ld	a5,-64(s0)
    8000769a:	00f70633          	add	a2,a4,a5
    8000769e:	fc843783          	ld	a5,-56(s0)
    800076a2:	539c                	lw	a5,32(a5)
    800076a4:	fe442703          	lw	a4,-28(s0)
    800076a8:	86be                	mv	a3,a5
    800076aa:	4585                	li	a1,1
    800076ac:	fffff097          	auipc	ra,0xfffff
    800076b0:	bbe080e7          	jalr	-1090(ra) # 8000626a <writei>
    800076b4:	87aa                	mv	a5,a0
    800076b6:	fcf42e23          	sw	a5,-36(s0)
    800076ba:	fdc42783          	lw	a5,-36(s0)
    800076be:	2781                	sext.w	a5,a5
    800076c0:	00f05d63          	blez	a5,800076da <filewrite+0x182>
        f->off += r;
    800076c4:	fc843783          	ld	a5,-56(s0)
    800076c8:	5398                	lw	a4,32(a5)
    800076ca:	fdc42783          	lw	a5,-36(s0)
    800076ce:	9fb9                	addw	a5,a5,a4
    800076d0:	0007871b          	sext.w	a4,a5
    800076d4:	fc843783          	ld	a5,-56(s0)
    800076d8:	d398                	sw	a4,32(a5)
      iunlock(f->ip);
    800076da:	fc843783          	ld	a5,-56(s0)
    800076de:	6f9c                	ld	a5,24(a5)
    800076e0:	853e                	mv	a0,a5
    800076e2:	ffffe097          	auipc	ra,0xffffe
    800076e6:	596080e7          	jalr	1430(ra) # 80005c78 <iunlock>
      end_op();
    800076ea:	fffff097          	auipc	ra,0xfffff
    800076ee:	584080e7          	jalr	1412(ra) # 80006c6e <end_op>

      if(r != n1){
    800076f2:	fdc42783          	lw	a5,-36(s0)
    800076f6:	873e                	mv	a4,a5
    800076f8:	fe442783          	lw	a5,-28(s0)
    800076fc:	2701                	sext.w	a4,a4
    800076fe:	2781                	sext.w	a5,a5
    80007700:	02f71463          	bne	a4,a5,80007728 <filewrite+0x1d0>
        // error from writei
        break;
      }
      i += r;
    80007704:	fe842783          	lw	a5,-24(s0)
    80007708:	873e                	mv	a4,a5
    8000770a:	fdc42783          	lw	a5,-36(s0)
    8000770e:	9fb9                	addw	a5,a5,a4
    80007710:	fef42423          	sw	a5,-24(s0)
    while(i < n){
    80007714:	fe842783          	lw	a5,-24(s0)
    80007718:	873e                	mv	a4,a5
    8000771a:	fbc42783          	lw	a5,-68(s0)
    8000771e:	2701                	sext.w	a4,a4
    80007720:	2781                	sext.w	a5,a5
    80007722:	f2f743e3          	blt	a4,a5,80007648 <filewrite+0xf0>
    80007726:	a011                	j	8000772a <filewrite+0x1d2>
        break;
    80007728:	0001                	nop
    }
    ret = (i == n ? n : -1);
    8000772a:	fe842783          	lw	a5,-24(s0)
    8000772e:	873e                	mv	a4,a5
    80007730:	fbc42783          	lw	a5,-68(s0)
    80007734:	2701                	sext.w	a4,a4
    80007736:	2781                	sext.w	a5,a5
    80007738:	00f71563          	bne	a4,a5,80007742 <filewrite+0x1ea>
    8000773c:	fbc42783          	lw	a5,-68(s0)
    80007740:	a011                	j	80007744 <filewrite+0x1ec>
    80007742:	57fd                	li	a5,-1
    80007744:	fef42623          	sw	a5,-20(s0)
    80007748:	a809                	j	8000775a <filewrite+0x202>
  } else {
    panic("filewrite");
    8000774a:	00004517          	auipc	a0,0x4
    8000774e:	01e50513          	addi	a0,a0,30 # 8000b768 <etext+0x768>
    80007752:	ffff9097          	auipc	ra,0xffff9
    80007756:	528080e7          	jalr	1320(ra) # 80000c7a <panic>
  }

  return ret;
    8000775a:	fec42783          	lw	a5,-20(s0)
}
    8000775e:	853e                	mv	a0,a5
    80007760:	60a6                	ld	ra,72(sp)
    80007762:	6406                	ld	s0,64(sp)
    80007764:	6161                	addi	sp,sp,80
    80007766:	8082                	ret

0000000080007768 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80007768:	7179                	addi	sp,sp,-48
    8000776a:	f406                	sd	ra,40(sp)
    8000776c:	f022                	sd	s0,32(sp)
    8000776e:	1800                	addi	s0,sp,48
    80007770:	fca43c23          	sd	a0,-40(s0)
    80007774:	fcb43823          	sd	a1,-48(s0)
  struct pipe *pi;

  pi = 0;
    80007778:	fe043423          	sd	zero,-24(s0)
  *f0 = *f1 = 0;
    8000777c:	fd043783          	ld	a5,-48(s0)
    80007780:	0007b023          	sd	zero,0(a5)
    80007784:	fd043783          	ld	a5,-48(s0)
    80007788:	6398                	ld	a4,0(a5)
    8000778a:	fd843783          	ld	a5,-40(s0)
    8000778e:	e398                	sd	a4,0(a5)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80007790:	00000097          	auipc	ra,0x0
    80007794:	9cc080e7          	jalr	-1588(ra) # 8000715c <filealloc>
    80007798:	872a                	mv	a4,a0
    8000779a:	fd843783          	ld	a5,-40(s0)
    8000779e:	e398                	sd	a4,0(a5)
    800077a0:	fd843783          	ld	a5,-40(s0)
    800077a4:	639c                	ld	a5,0(a5)
    800077a6:	c3e9                	beqz	a5,80007868 <pipealloc+0x100>
    800077a8:	00000097          	auipc	ra,0x0
    800077ac:	9b4080e7          	jalr	-1612(ra) # 8000715c <filealloc>
    800077b0:	872a                	mv	a4,a0
    800077b2:	fd043783          	ld	a5,-48(s0)
    800077b6:	e398                	sd	a4,0(a5)
    800077b8:	fd043783          	ld	a5,-48(s0)
    800077bc:	639c                	ld	a5,0(a5)
    800077be:	c7cd                	beqz	a5,80007868 <pipealloc+0x100>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800077c0:	ffffa097          	auipc	ra,0xffffa
    800077c4:	956080e7          	jalr	-1706(ra) # 80001116 <kalloc>
    800077c8:	fea43423          	sd	a0,-24(s0)
    800077cc:	fe843783          	ld	a5,-24(s0)
    800077d0:	cfd1                	beqz	a5,8000786c <pipealloc+0x104>
    goto bad;
  pi->readopen = 1;
    800077d2:	fe843783          	ld	a5,-24(s0)
    800077d6:	4705                	li	a4,1
    800077d8:	22e7a023          	sw	a4,544(a5)
  pi->writeopen = 1;
    800077dc:	fe843783          	ld	a5,-24(s0)
    800077e0:	4705                	li	a4,1
    800077e2:	22e7a223          	sw	a4,548(a5)
  pi->nwrite = 0;
    800077e6:	fe843783          	ld	a5,-24(s0)
    800077ea:	2007ae23          	sw	zero,540(a5)
  pi->nread = 0;
    800077ee:	fe843783          	ld	a5,-24(s0)
    800077f2:	2007ac23          	sw	zero,536(a5)
  initlock(&pi->lock, "pipe");
    800077f6:	fe843783          	ld	a5,-24(s0)
    800077fa:	00004597          	auipc	a1,0x4
    800077fe:	f7e58593          	addi	a1,a1,-130 # 8000b778 <etext+0x778>
    80007802:	853e                	mv	a0,a5
    80007804:	ffffa097          	auipc	ra,0xffffa
    80007808:	a36080e7          	jalr	-1482(ra) # 8000123a <initlock>
  (*f0)->type = FD_PIPE;
    8000780c:	fd843783          	ld	a5,-40(s0)
    80007810:	639c                	ld	a5,0(a5)
    80007812:	4705                	li	a4,1
    80007814:	c398                	sw	a4,0(a5)
  (*f0)->readable = 1;
    80007816:	fd843783          	ld	a5,-40(s0)
    8000781a:	639c                	ld	a5,0(a5)
    8000781c:	4705                	li	a4,1
    8000781e:	00e78423          	sb	a4,8(a5)
  (*f0)->writable = 0;
    80007822:	fd843783          	ld	a5,-40(s0)
    80007826:	639c                	ld	a5,0(a5)
    80007828:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    8000782c:	fd843783          	ld	a5,-40(s0)
    80007830:	639c                	ld	a5,0(a5)
    80007832:	fe843703          	ld	a4,-24(s0)
    80007836:	eb98                	sd	a4,16(a5)
  (*f1)->type = FD_PIPE;
    80007838:	fd043783          	ld	a5,-48(s0)
    8000783c:	639c                	ld	a5,0(a5)
    8000783e:	4705                	li	a4,1
    80007840:	c398                	sw	a4,0(a5)
  (*f1)->readable = 0;
    80007842:	fd043783          	ld	a5,-48(s0)
    80007846:	639c                	ld	a5,0(a5)
    80007848:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    8000784c:	fd043783          	ld	a5,-48(s0)
    80007850:	639c                	ld	a5,0(a5)
    80007852:	4705                	li	a4,1
    80007854:	00e784a3          	sb	a4,9(a5)
  (*f1)->pipe = pi;
    80007858:	fd043783          	ld	a5,-48(s0)
    8000785c:	639c                	ld	a5,0(a5)
    8000785e:	fe843703          	ld	a4,-24(s0)
    80007862:	eb98                	sd	a4,16(a5)
  return 0;
    80007864:	4781                	li	a5,0
    80007866:	a0b1                	j	800078b2 <pipealloc+0x14a>
    goto bad;
    80007868:	0001                	nop
    8000786a:	a011                	j	8000786e <pipealloc+0x106>
    goto bad;
    8000786c:	0001                	nop

 bad:
  if(pi)
    8000786e:	fe843783          	ld	a5,-24(s0)
    80007872:	c799                	beqz	a5,80007880 <pipealloc+0x118>
    kfree((char*)pi);
    80007874:	fe843503          	ld	a0,-24(s0)
    80007878:	ffff9097          	auipc	ra,0xffff9
    8000787c:	7fa080e7          	jalr	2042(ra) # 80001072 <kfree>
  if(*f0)
    80007880:	fd843783          	ld	a5,-40(s0)
    80007884:	639c                	ld	a5,0(a5)
    80007886:	cb89                	beqz	a5,80007898 <pipealloc+0x130>
    fileclose(*f0);
    80007888:	fd843783          	ld	a5,-40(s0)
    8000788c:	639c                	ld	a5,0(a5)
    8000788e:	853e                	mv	a0,a5
    80007890:	00000097          	auipc	ra,0x0
    80007894:	9b6080e7          	jalr	-1610(ra) # 80007246 <fileclose>
  if(*f1)
    80007898:	fd043783          	ld	a5,-48(s0)
    8000789c:	639c                	ld	a5,0(a5)
    8000789e:	cb89                	beqz	a5,800078b0 <pipealloc+0x148>
    fileclose(*f1);
    800078a0:	fd043783          	ld	a5,-48(s0)
    800078a4:	639c                	ld	a5,0(a5)
    800078a6:	853e                	mv	a0,a5
    800078a8:	00000097          	auipc	ra,0x0
    800078ac:	99e080e7          	jalr	-1634(ra) # 80007246 <fileclose>
  return -1;
    800078b0:	57fd                	li	a5,-1
}
    800078b2:	853e                	mv	a0,a5
    800078b4:	70a2                	ld	ra,40(sp)
    800078b6:	7402                	ld	s0,32(sp)
    800078b8:	6145                	addi	sp,sp,48
    800078ba:	8082                	ret

00000000800078bc <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    800078bc:	1101                	addi	sp,sp,-32
    800078be:	ec06                	sd	ra,24(sp)
    800078c0:	e822                	sd	s0,16(sp)
    800078c2:	1000                	addi	s0,sp,32
    800078c4:	fea43423          	sd	a0,-24(s0)
    800078c8:	87ae                	mv	a5,a1
    800078ca:	fef42223          	sw	a5,-28(s0)
  acquire(&pi->lock);
    800078ce:	fe843783          	ld	a5,-24(s0)
    800078d2:	853e                	mv	a0,a5
    800078d4:	ffffa097          	auipc	ra,0xffffa
    800078d8:	996080e7          	jalr	-1642(ra) # 8000126a <acquire>
  if(writable){
    800078dc:	fe442783          	lw	a5,-28(s0)
    800078e0:	2781                	sext.w	a5,a5
    800078e2:	cf99                	beqz	a5,80007900 <pipeclose+0x44>
    pi->writeopen = 0;
    800078e4:	fe843783          	ld	a5,-24(s0)
    800078e8:	2207a223          	sw	zero,548(a5)
    wakeup(&pi->nread);
    800078ec:	fe843783          	ld	a5,-24(s0)
    800078f0:	21878793          	addi	a5,a5,536
    800078f4:	853e                	mv	a0,a5
    800078f6:	ffffc097          	auipc	ra,0xffffc
    800078fa:	07a080e7          	jalr	122(ra) # 80003970 <wakeup>
    800078fe:	a831                	j	8000791a <pipeclose+0x5e>
  } else {
    pi->readopen = 0;
    80007900:	fe843783          	ld	a5,-24(s0)
    80007904:	2207a023          	sw	zero,544(a5)
    wakeup(&pi->nwrite);
    80007908:	fe843783          	ld	a5,-24(s0)
    8000790c:	21c78793          	addi	a5,a5,540
    80007910:	853e                	mv	a0,a5
    80007912:	ffffc097          	auipc	ra,0xffffc
    80007916:	05e080e7          	jalr	94(ra) # 80003970 <wakeup>
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    8000791a:	fe843783          	ld	a5,-24(s0)
    8000791e:	2207a783          	lw	a5,544(a5)
    80007922:	e785                	bnez	a5,8000794a <pipeclose+0x8e>
    80007924:	fe843783          	ld	a5,-24(s0)
    80007928:	2247a783          	lw	a5,548(a5)
    8000792c:	ef99                	bnez	a5,8000794a <pipeclose+0x8e>
    release(&pi->lock);
    8000792e:	fe843783          	ld	a5,-24(s0)
    80007932:	853e                	mv	a0,a5
    80007934:	ffffa097          	auipc	ra,0xffffa
    80007938:	99a080e7          	jalr	-1638(ra) # 800012ce <release>
    kfree((char*)pi);
    8000793c:	fe843503          	ld	a0,-24(s0)
    80007940:	ffff9097          	auipc	ra,0xffff9
    80007944:	732080e7          	jalr	1842(ra) # 80001072 <kfree>
    80007948:	a809                	j	8000795a <pipeclose+0x9e>
  } else
    release(&pi->lock);
    8000794a:	fe843783          	ld	a5,-24(s0)
    8000794e:	853e                	mv	a0,a5
    80007950:	ffffa097          	auipc	ra,0xffffa
    80007954:	97e080e7          	jalr	-1666(ra) # 800012ce <release>
}
    80007958:	0001                	nop
    8000795a:	0001                	nop
    8000795c:	60e2                	ld	ra,24(sp)
    8000795e:	6442                	ld	s0,16(sp)
    80007960:	6105                	addi	sp,sp,32
    80007962:	8082                	ret

0000000080007964 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80007964:	715d                	addi	sp,sp,-80
    80007966:	e486                	sd	ra,72(sp)
    80007968:	e0a2                	sd	s0,64(sp)
    8000796a:	0880                	addi	s0,sp,80
    8000796c:	fca43423          	sd	a0,-56(s0)
    80007970:	fcb43023          	sd	a1,-64(s0)
    80007974:	87b2                	mv	a5,a2
    80007976:	faf42e23          	sw	a5,-68(s0)
  int i = 0;
    8000797a:	fe042623          	sw	zero,-20(s0)
  struct proc *pr = myproc();
    8000797e:	ffffb097          	auipc	ra,0xffffb
    80007982:	09a080e7          	jalr	154(ra) # 80002a18 <myproc>
    80007986:	fea43023          	sd	a0,-32(s0)

  acquire(&pi->lock);
    8000798a:	fc843783          	ld	a5,-56(s0)
    8000798e:	853e                	mv	a0,a5
    80007990:	ffffa097          	auipc	ra,0xffffa
    80007994:	8da080e7          	jalr	-1830(ra) # 8000126a <acquire>
  while(i < n){
    80007998:	a8d1                	j	80007a6c <pipewrite+0x108>
    if(pi->readopen == 0 || pr->killed){
    8000799a:	fc843783          	ld	a5,-56(s0)
    8000799e:	2207a783          	lw	a5,544(a5)
    800079a2:	c789                	beqz	a5,800079ac <pipewrite+0x48>
    800079a4:	fe043783          	ld	a5,-32(s0)
    800079a8:	579c                	lw	a5,40(a5)
    800079aa:	cb91                	beqz	a5,800079be <pipewrite+0x5a>
      release(&pi->lock);
    800079ac:	fc843783          	ld	a5,-56(s0)
    800079b0:	853e                	mv	a0,a5
    800079b2:	ffffa097          	auipc	ra,0xffffa
    800079b6:	91c080e7          	jalr	-1764(ra) # 800012ce <release>
      return -1;
    800079ba:	57fd                	li	a5,-1
    800079bc:	a0ed                	j	80007aa6 <pipewrite+0x142>
    }
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    800079be:	fc843783          	ld	a5,-56(s0)
    800079c2:	21c7a703          	lw	a4,540(a5)
    800079c6:	fc843783          	ld	a5,-56(s0)
    800079ca:	2187a783          	lw	a5,536(a5)
    800079ce:	2007879b          	addiw	a5,a5,512
    800079d2:	2781                	sext.w	a5,a5
    800079d4:	02f71863          	bne	a4,a5,80007a04 <pipewrite+0xa0>
      wakeup(&pi->nread);
    800079d8:	fc843783          	ld	a5,-56(s0)
    800079dc:	21878793          	addi	a5,a5,536
    800079e0:	853e                	mv	a0,a5
    800079e2:	ffffc097          	auipc	ra,0xffffc
    800079e6:	f8e080e7          	jalr	-114(ra) # 80003970 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    800079ea:	fc843783          	ld	a5,-56(s0)
    800079ee:	21c78793          	addi	a5,a5,540
    800079f2:	fc843703          	ld	a4,-56(s0)
    800079f6:	85ba                	mv	a1,a4
    800079f8:	853e                	mv	a0,a5
    800079fa:	ffffc097          	auipc	ra,0xffffc
    800079fe:	efa080e7          	jalr	-262(ra) # 800038f4 <sleep>
    80007a02:	a0ad                	j	80007a6c <pipewrite+0x108>
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80007a04:	fe043783          	ld	a5,-32(s0)
    80007a08:	6ba8                	ld	a0,80(a5)
    80007a0a:	fec42703          	lw	a4,-20(s0)
    80007a0e:	fc043783          	ld	a5,-64(s0)
    80007a12:	973e                	add	a4,a4,a5
    80007a14:	fdf40793          	addi	a5,s0,-33
    80007a18:	4685                	li	a3,1
    80007a1a:	863a                	mv	a2,a4
    80007a1c:	85be                	mv	a1,a5
    80007a1e:	ffffb097          	auipc	ra,0xffffb
    80007a22:	a76080e7          	jalr	-1418(ra) # 80002494 <copyin>
    80007a26:	87aa                	mv	a5,a0
    80007a28:	873e                	mv	a4,a5
    80007a2a:	57fd                	li	a5,-1
    80007a2c:	04f70a63          	beq	a4,a5,80007a80 <pipewrite+0x11c>
        break;
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80007a30:	fc843783          	ld	a5,-56(s0)
    80007a34:	21c7a783          	lw	a5,540(a5)
    80007a38:	2781                	sext.w	a5,a5
    80007a3a:	0017871b          	addiw	a4,a5,1
    80007a3e:	0007069b          	sext.w	a3,a4
    80007a42:	fc843703          	ld	a4,-56(s0)
    80007a46:	20d72e23          	sw	a3,540(a4)
    80007a4a:	1ff7f793          	andi	a5,a5,511
    80007a4e:	2781                	sext.w	a5,a5
    80007a50:	fdf44703          	lbu	a4,-33(s0)
    80007a54:	fc843683          	ld	a3,-56(s0)
    80007a58:	1782                	slli	a5,a5,0x20
    80007a5a:	9381                	srli	a5,a5,0x20
    80007a5c:	97b6                	add	a5,a5,a3
    80007a5e:	00e78c23          	sb	a4,24(a5)
      i++;
    80007a62:	fec42783          	lw	a5,-20(s0)
    80007a66:	2785                	addiw	a5,a5,1
    80007a68:	fef42623          	sw	a5,-20(s0)
  while(i < n){
    80007a6c:	fec42783          	lw	a5,-20(s0)
    80007a70:	873e                	mv	a4,a5
    80007a72:	fbc42783          	lw	a5,-68(s0)
    80007a76:	2701                	sext.w	a4,a4
    80007a78:	2781                	sext.w	a5,a5
    80007a7a:	f2f740e3          	blt	a4,a5,8000799a <pipewrite+0x36>
    80007a7e:	a011                	j	80007a82 <pipewrite+0x11e>
        break;
    80007a80:	0001                	nop
    }
  }
  wakeup(&pi->nread);
    80007a82:	fc843783          	ld	a5,-56(s0)
    80007a86:	21878793          	addi	a5,a5,536
    80007a8a:	853e                	mv	a0,a5
    80007a8c:	ffffc097          	auipc	ra,0xffffc
    80007a90:	ee4080e7          	jalr	-284(ra) # 80003970 <wakeup>
  release(&pi->lock);
    80007a94:	fc843783          	ld	a5,-56(s0)
    80007a98:	853e                	mv	a0,a5
    80007a9a:	ffffa097          	auipc	ra,0xffffa
    80007a9e:	834080e7          	jalr	-1996(ra) # 800012ce <release>

  return i;
    80007aa2:	fec42783          	lw	a5,-20(s0)
}
    80007aa6:	853e                	mv	a0,a5
    80007aa8:	60a6                	ld	ra,72(sp)
    80007aaa:	6406                	ld	s0,64(sp)
    80007aac:	6161                	addi	sp,sp,80
    80007aae:	8082                	ret

0000000080007ab0 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80007ab0:	715d                	addi	sp,sp,-80
    80007ab2:	e486                	sd	ra,72(sp)
    80007ab4:	e0a2                	sd	s0,64(sp)
    80007ab6:	0880                	addi	s0,sp,80
    80007ab8:	fca43423          	sd	a0,-56(s0)
    80007abc:	fcb43023          	sd	a1,-64(s0)
    80007ac0:	87b2                	mv	a5,a2
    80007ac2:	faf42e23          	sw	a5,-68(s0)
  int i;
  struct proc *pr = myproc();
    80007ac6:	ffffb097          	auipc	ra,0xffffb
    80007aca:	f52080e7          	jalr	-174(ra) # 80002a18 <myproc>
    80007ace:	fea43023          	sd	a0,-32(s0)
  char ch;

  acquire(&pi->lock);
    80007ad2:	fc843783          	ld	a5,-56(s0)
    80007ad6:	853e                	mv	a0,a5
    80007ad8:	ffff9097          	auipc	ra,0xffff9
    80007adc:	792080e7          	jalr	1938(ra) # 8000126a <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80007ae0:	a815                	j	80007b14 <piperead+0x64>
    if(pr->killed){
    80007ae2:	fe043783          	ld	a5,-32(s0)
    80007ae6:	579c                	lw	a5,40(a5)
    80007ae8:	cb91                	beqz	a5,80007afc <piperead+0x4c>
      release(&pi->lock);
    80007aea:	fc843783          	ld	a5,-56(s0)
    80007aee:	853e                	mv	a0,a5
    80007af0:	ffff9097          	auipc	ra,0xffff9
    80007af4:	7de080e7          	jalr	2014(ra) # 800012ce <release>
      return -1;
    80007af8:	57fd                	li	a5,-1
    80007afa:	a8e5                	j	80007bf2 <piperead+0x142>
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80007afc:	fc843783          	ld	a5,-56(s0)
    80007b00:	21878793          	addi	a5,a5,536
    80007b04:	fc843703          	ld	a4,-56(s0)
    80007b08:	85ba                	mv	a1,a4
    80007b0a:	853e                	mv	a0,a5
    80007b0c:	ffffc097          	auipc	ra,0xffffc
    80007b10:	de8080e7          	jalr	-536(ra) # 800038f4 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80007b14:	fc843783          	ld	a5,-56(s0)
    80007b18:	2187a703          	lw	a4,536(a5)
    80007b1c:	fc843783          	ld	a5,-56(s0)
    80007b20:	21c7a783          	lw	a5,540(a5)
    80007b24:	00f71763          	bne	a4,a5,80007b32 <piperead+0x82>
    80007b28:	fc843783          	ld	a5,-56(s0)
    80007b2c:	2247a783          	lw	a5,548(a5)
    80007b30:	fbcd                	bnez	a5,80007ae2 <piperead+0x32>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80007b32:	fe042623          	sw	zero,-20(s0)
    80007b36:	a8bd                	j	80007bb4 <piperead+0x104>
    if(pi->nread == pi->nwrite)
    80007b38:	fc843783          	ld	a5,-56(s0)
    80007b3c:	2187a703          	lw	a4,536(a5)
    80007b40:	fc843783          	ld	a5,-56(s0)
    80007b44:	21c7a783          	lw	a5,540(a5)
    80007b48:	08f70063          	beq	a4,a5,80007bc8 <piperead+0x118>
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    80007b4c:	fc843783          	ld	a5,-56(s0)
    80007b50:	2187a783          	lw	a5,536(a5)
    80007b54:	2781                	sext.w	a5,a5
    80007b56:	0017871b          	addiw	a4,a5,1
    80007b5a:	0007069b          	sext.w	a3,a4
    80007b5e:	fc843703          	ld	a4,-56(s0)
    80007b62:	20d72c23          	sw	a3,536(a4)
    80007b66:	1ff7f793          	andi	a5,a5,511
    80007b6a:	2781                	sext.w	a5,a5
    80007b6c:	fc843703          	ld	a4,-56(s0)
    80007b70:	1782                	slli	a5,a5,0x20
    80007b72:	9381                	srli	a5,a5,0x20
    80007b74:	97ba                	add	a5,a5,a4
    80007b76:	0187c783          	lbu	a5,24(a5)
    80007b7a:	fcf40fa3          	sb	a5,-33(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80007b7e:	fe043783          	ld	a5,-32(s0)
    80007b82:	6ba8                	ld	a0,80(a5)
    80007b84:	fec42703          	lw	a4,-20(s0)
    80007b88:	fc043783          	ld	a5,-64(s0)
    80007b8c:	97ba                	add	a5,a5,a4
    80007b8e:	fdf40713          	addi	a4,s0,-33
    80007b92:	4685                	li	a3,1
    80007b94:	863a                	mv	a2,a4
    80007b96:	85be                	mv	a1,a5
    80007b98:	ffffb097          	auipc	ra,0xffffb
    80007b9c:	82e080e7          	jalr	-2002(ra) # 800023c6 <copyout>
    80007ba0:	87aa                	mv	a5,a0
    80007ba2:	873e                	mv	a4,a5
    80007ba4:	57fd                	li	a5,-1
    80007ba6:	02f70363          	beq	a4,a5,80007bcc <piperead+0x11c>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80007baa:	fec42783          	lw	a5,-20(s0)
    80007bae:	2785                	addiw	a5,a5,1
    80007bb0:	fef42623          	sw	a5,-20(s0)
    80007bb4:	fec42783          	lw	a5,-20(s0)
    80007bb8:	873e                	mv	a4,a5
    80007bba:	fbc42783          	lw	a5,-68(s0)
    80007bbe:	2701                	sext.w	a4,a4
    80007bc0:	2781                	sext.w	a5,a5
    80007bc2:	f6f74be3          	blt	a4,a5,80007b38 <piperead+0x88>
    80007bc6:	a021                	j	80007bce <piperead+0x11e>
      break;
    80007bc8:	0001                	nop
    80007bca:	a011                	j	80007bce <piperead+0x11e>
      break;
    80007bcc:	0001                	nop
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80007bce:	fc843783          	ld	a5,-56(s0)
    80007bd2:	21c78793          	addi	a5,a5,540
    80007bd6:	853e                	mv	a0,a5
    80007bd8:	ffffc097          	auipc	ra,0xffffc
    80007bdc:	d98080e7          	jalr	-616(ra) # 80003970 <wakeup>
  release(&pi->lock);
    80007be0:	fc843783          	ld	a5,-56(s0)
    80007be4:	853e                	mv	a0,a5
    80007be6:	ffff9097          	auipc	ra,0xffff9
    80007bea:	6e8080e7          	jalr	1768(ra) # 800012ce <release>
  return i;
    80007bee:	fec42783          	lw	a5,-20(s0)
}
    80007bf2:	853e                	mv	a0,a5
    80007bf4:	60a6                	ld	ra,72(sp)
    80007bf6:	6406                	ld	s0,64(sp)
    80007bf8:	6161                	addi	sp,sp,80
    80007bfa:	8082                	ret

0000000080007bfc <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    80007bfc:	de010113          	addi	sp,sp,-544
    80007c00:	20113c23          	sd	ra,536(sp)
    80007c04:	20813823          	sd	s0,528(sp)
    80007c08:	20913423          	sd	s1,520(sp)
    80007c0c:	1400                	addi	s0,sp,544
    80007c0e:	dea43423          	sd	a0,-536(s0)
    80007c12:	deb43023          	sd	a1,-544(s0)
  char *s, *last;
  int i, off;
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80007c16:	fa043c23          	sd	zero,-72(s0)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
    80007c1a:	fa043023          	sd	zero,-96(s0)
  struct proc *p = myproc();
    80007c1e:	ffffb097          	auipc	ra,0xffffb
    80007c22:	dfa080e7          	jalr	-518(ra) # 80002a18 <myproc>
    80007c26:	f8a43c23          	sd	a0,-104(s0)

  begin_op();
    80007c2a:	fffff097          	auipc	ra,0xfffff
    80007c2e:	f82080e7          	jalr	-126(ra) # 80006bac <begin_op>

  if((ip = namei(path)) == 0){
    80007c32:	de843503          	ld	a0,-536(s0)
    80007c36:	fffff097          	auipc	ra,0xfffff
    80007c3a:	c12080e7          	jalr	-1006(ra) # 80006848 <namei>
    80007c3e:	faa43423          	sd	a0,-88(s0)
    80007c42:	fa843783          	ld	a5,-88(s0)
    80007c46:	e799                	bnez	a5,80007c54 <exec+0x58>
    end_op();
    80007c48:	fffff097          	auipc	ra,0xfffff
    80007c4c:	026080e7          	jalr	38(ra) # 80006c6e <end_op>
    return -1;
    80007c50:	57fd                	li	a5,-1
    80007c52:	a929                	j	8000806c <exec+0x470>
  }
  ilock(ip);
    80007c54:	fa843503          	ld	a0,-88(s0)
    80007c58:	ffffe097          	auipc	ra,0xffffe
    80007c5c:	eec080e7          	jalr	-276(ra) # 80005b44 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80007c60:	e3040793          	addi	a5,s0,-464
    80007c64:	04000713          	li	a4,64
    80007c68:	4681                	li	a3,0
    80007c6a:	863e                	mv	a2,a5
    80007c6c:	4581                	li	a1,0
    80007c6e:	fa843503          	ld	a0,-88(s0)
    80007c72:	ffffe097          	auipc	ra,0xffffe
    80007c76:	468080e7          	jalr	1128(ra) # 800060da <readi>
    80007c7a:	87aa                	mv	a5,a0
    80007c7c:	873e                	mv	a4,a5
    80007c7e:	04000793          	li	a5,64
    80007c82:	36f71f63          	bne	a4,a5,80008000 <exec+0x404>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80007c86:	e3042783          	lw	a5,-464(s0)
    80007c8a:	873e                	mv	a4,a5
    80007c8c:	464c47b7          	lui	a5,0x464c4
    80007c90:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80007c94:	36f71863          	bne	a4,a5,80008004 <exec+0x408>
    goto bad;

  if((pagetable = proc_pagetable(p)) == 0)
    80007c98:	f9843503          	ld	a0,-104(s0)
    80007c9c:	ffffb097          	auipc	ra,0xffffb
    80007ca0:	10e080e7          	jalr	270(ra) # 80002daa <proc_pagetable>
    80007ca4:	faa43023          	sd	a0,-96(s0)
    80007ca8:	fa043783          	ld	a5,-96(s0)
    80007cac:	34078e63          	beqz	a5,80008008 <exec+0x40c>
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80007cb0:	fc042623          	sw	zero,-52(s0)
    80007cb4:	e5043783          	ld	a5,-432(s0)
    80007cb8:	fcf42423          	sw	a5,-56(s0)
    80007cbc:	a8e1                	j	80007d94 <exec+0x198>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80007cbe:	df840793          	addi	a5,s0,-520
    80007cc2:	fc842683          	lw	a3,-56(s0)
    80007cc6:	03800713          	li	a4,56
    80007cca:	863e                	mv	a2,a5
    80007ccc:	4581                	li	a1,0
    80007cce:	fa843503          	ld	a0,-88(s0)
    80007cd2:	ffffe097          	auipc	ra,0xffffe
    80007cd6:	408080e7          	jalr	1032(ra) # 800060da <readi>
    80007cda:	87aa                	mv	a5,a0
    80007cdc:	873e                	mv	a4,a5
    80007cde:	03800793          	li	a5,56
    80007ce2:	32f71563          	bne	a4,a5,8000800c <exec+0x410>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
    80007ce6:	df842783          	lw	a5,-520(s0)
    80007cea:	873e                	mv	a4,a5
    80007cec:	4785                	li	a5,1
    80007cee:	08f71663          	bne	a4,a5,80007d7a <exec+0x17e>
      continue;
    if(ph.memsz < ph.filesz)
    80007cf2:	e2043703          	ld	a4,-480(s0)
    80007cf6:	e1843783          	ld	a5,-488(s0)
    80007cfa:	30f76b63          	bltu	a4,a5,80008010 <exec+0x414>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80007cfe:	e0843703          	ld	a4,-504(s0)
    80007d02:	e2043783          	ld	a5,-480(s0)
    80007d06:	973e                	add	a4,a4,a5
    80007d08:	e0843783          	ld	a5,-504(s0)
    80007d0c:	30f76463          	bltu	a4,a5,80008014 <exec+0x418>
      goto bad;
    uint64 sz1;
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80007d10:	e0843703          	ld	a4,-504(s0)
    80007d14:	e2043783          	ld	a5,-480(s0)
    80007d18:	97ba                	add	a5,a5,a4
    80007d1a:	863e                	mv	a2,a5
    80007d1c:	fb843583          	ld	a1,-72(s0)
    80007d20:	fa043503          	ld	a0,-96(s0)
    80007d24:	ffffa097          	auipc	ra,0xffffa
    80007d28:	1e4080e7          	jalr	484(ra) # 80001f08 <uvmalloc>
    80007d2c:	f6a43823          	sd	a0,-144(s0)
    80007d30:	f7043783          	ld	a5,-144(s0)
    80007d34:	2e078263          	beqz	a5,80008018 <exec+0x41c>
      goto bad;
    sz = sz1;
    80007d38:	f7043783          	ld	a5,-144(s0)
    80007d3c:	faf43c23          	sd	a5,-72(s0)
    if((ph.vaddr % PGSIZE) != 0)
    80007d40:	e0843703          	ld	a4,-504(s0)
    80007d44:	6785                	lui	a5,0x1
    80007d46:	17fd                	addi	a5,a5,-1
    80007d48:	8ff9                	and	a5,a5,a4
    80007d4a:	2c079963          	bnez	a5,8000801c <exec+0x420>
      goto bad;
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80007d4e:	e0843783          	ld	a5,-504(s0)
    80007d52:	e0043703          	ld	a4,-512(s0)
    80007d56:	0007069b          	sext.w	a3,a4
    80007d5a:	e1843703          	ld	a4,-488(s0)
    80007d5e:	2701                	sext.w	a4,a4
    80007d60:	fa843603          	ld	a2,-88(s0)
    80007d64:	85be                	mv	a1,a5
    80007d66:	fa043503          	ld	a0,-96(s0)
    80007d6a:	00000097          	auipc	ra,0x0
    80007d6e:	316080e7          	jalr	790(ra) # 80008080 <loadseg>
    80007d72:	87aa                	mv	a5,a0
    80007d74:	2a07c663          	bltz	a5,80008020 <exec+0x424>
    80007d78:	a011                	j	80007d7c <exec+0x180>
      continue;
    80007d7a:	0001                	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80007d7c:	fcc42783          	lw	a5,-52(s0)
    80007d80:	2785                	addiw	a5,a5,1
    80007d82:	fcf42623          	sw	a5,-52(s0)
    80007d86:	fc842783          	lw	a5,-56(s0)
    80007d8a:	0387879b          	addiw	a5,a5,56
    80007d8e:	2781                	sext.w	a5,a5
    80007d90:	fcf42423          	sw	a5,-56(s0)
    80007d94:	e6845783          	lhu	a5,-408(s0)
    80007d98:	0007871b          	sext.w	a4,a5
    80007d9c:	fcc42783          	lw	a5,-52(s0)
    80007da0:	2781                	sext.w	a5,a5
    80007da2:	f0e7cee3          	blt	a5,a4,80007cbe <exec+0xc2>
      goto bad;
  }
  iunlockput(ip);
    80007da6:	fa843503          	ld	a0,-88(s0)
    80007daa:	ffffe097          	auipc	ra,0xffffe
    80007dae:	ff8080e7          	jalr	-8(ra) # 80005da2 <iunlockput>
  end_op();
    80007db2:	fffff097          	auipc	ra,0xfffff
    80007db6:	ebc080e7          	jalr	-324(ra) # 80006c6e <end_op>
  ip = 0;
    80007dba:	fa043423          	sd	zero,-88(s0)

  p = myproc();
    80007dbe:	ffffb097          	auipc	ra,0xffffb
    80007dc2:	c5a080e7          	jalr	-934(ra) # 80002a18 <myproc>
    80007dc6:	f8a43c23          	sd	a0,-104(s0)
  uint64 oldsz = p->sz;
    80007dca:	f9843783          	ld	a5,-104(s0)
    80007dce:	67bc                	ld	a5,72(a5)
    80007dd0:	f8f43823          	sd	a5,-112(s0)

  // Allocate two pages at the next page boundary.
  // Use the second as the user stack.
  sz = PGROUNDUP(sz);
    80007dd4:	fb843703          	ld	a4,-72(s0)
    80007dd8:	6785                	lui	a5,0x1
    80007dda:	17fd                	addi	a5,a5,-1
    80007ddc:	973e                	add	a4,a4,a5
    80007dde:	77fd                	lui	a5,0xfffff
    80007de0:	8ff9                	and	a5,a5,a4
    80007de2:	faf43c23          	sd	a5,-72(s0)
  uint64 sz1;
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80007de6:	fb843703          	ld	a4,-72(s0)
    80007dea:	6789                	lui	a5,0x2
    80007dec:	97ba                	add	a5,a5,a4
    80007dee:	863e                	mv	a2,a5
    80007df0:	fb843583          	ld	a1,-72(s0)
    80007df4:	fa043503          	ld	a0,-96(s0)
    80007df8:	ffffa097          	auipc	ra,0xffffa
    80007dfc:	110080e7          	jalr	272(ra) # 80001f08 <uvmalloc>
    80007e00:	f8a43423          	sd	a0,-120(s0)
    80007e04:	f8843783          	ld	a5,-120(s0)
    80007e08:	20078e63          	beqz	a5,80008024 <exec+0x428>
    goto bad;
  sz = sz1;
    80007e0c:	f8843783          	ld	a5,-120(s0)
    80007e10:	faf43c23          	sd	a5,-72(s0)
  uvmclear(pagetable, sz-2*PGSIZE);
    80007e14:	fb843703          	ld	a4,-72(s0)
    80007e18:	77f9                	lui	a5,0xffffe
    80007e1a:	97ba                	add	a5,a5,a4
    80007e1c:	85be                	mv	a1,a5
    80007e1e:	fa043503          	ld	a0,-96(s0)
    80007e22:	ffffa097          	auipc	ra,0xffffa
    80007e26:	54e080e7          	jalr	1358(ra) # 80002370 <uvmclear>
  sp = sz;
    80007e2a:	fb843783          	ld	a5,-72(s0)
    80007e2e:	faf43823          	sd	a5,-80(s0)
  stackbase = sp - PGSIZE;
    80007e32:	fb043703          	ld	a4,-80(s0)
    80007e36:	77fd                	lui	a5,0xfffff
    80007e38:	97ba                	add	a5,a5,a4
    80007e3a:	f8f43023          	sd	a5,-128(s0)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    80007e3e:	fc043023          	sd	zero,-64(s0)
    80007e42:	a07d                	j	80007ef0 <exec+0x2f4>
    if(argc >= MAXARG)
    80007e44:	fc043703          	ld	a4,-64(s0)
    80007e48:	47fd                	li	a5,31
    80007e4a:	1ce7ef63          	bltu	a5,a4,80008028 <exec+0x42c>
      goto bad;
    sp -= strlen(argv[argc]) + 1;
    80007e4e:	fc043783          	ld	a5,-64(s0)
    80007e52:	078e                	slli	a5,a5,0x3
    80007e54:	de043703          	ld	a4,-544(s0)
    80007e58:	97ba                	add	a5,a5,a4
    80007e5a:	639c                	ld	a5,0(a5)
    80007e5c:	853e                	mv	a0,a5
    80007e5e:	ffffa097          	auipc	ra,0xffffa
    80007e62:	960080e7          	jalr	-1696(ra) # 800017be <strlen>
    80007e66:	87aa                	mv	a5,a0
    80007e68:	2785                	addiw	a5,a5,1
    80007e6a:	2781                	sext.w	a5,a5
    80007e6c:	873e                	mv	a4,a5
    80007e6e:	fb043783          	ld	a5,-80(s0)
    80007e72:	8f99                	sub	a5,a5,a4
    80007e74:	faf43823          	sd	a5,-80(s0)
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80007e78:	fb043783          	ld	a5,-80(s0)
    80007e7c:	9bc1                	andi	a5,a5,-16
    80007e7e:	faf43823          	sd	a5,-80(s0)
    if(sp < stackbase)
    80007e82:	fb043703          	ld	a4,-80(s0)
    80007e86:	f8043783          	ld	a5,-128(s0)
    80007e8a:	1af76163          	bltu	a4,a5,8000802c <exec+0x430>
      goto bad;
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80007e8e:	fc043783          	ld	a5,-64(s0)
    80007e92:	078e                	slli	a5,a5,0x3
    80007e94:	de043703          	ld	a4,-544(s0)
    80007e98:	97ba                	add	a5,a5,a4
    80007e9a:	6384                	ld	s1,0(a5)
    80007e9c:	fc043783          	ld	a5,-64(s0)
    80007ea0:	078e                	slli	a5,a5,0x3
    80007ea2:	de043703          	ld	a4,-544(s0)
    80007ea6:	97ba                	add	a5,a5,a4
    80007ea8:	639c                	ld	a5,0(a5)
    80007eaa:	853e                	mv	a0,a5
    80007eac:	ffffa097          	auipc	ra,0xffffa
    80007eb0:	912080e7          	jalr	-1774(ra) # 800017be <strlen>
    80007eb4:	87aa                	mv	a5,a0
    80007eb6:	2785                	addiw	a5,a5,1
    80007eb8:	2781                	sext.w	a5,a5
    80007eba:	86be                	mv	a3,a5
    80007ebc:	8626                	mv	a2,s1
    80007ebe:	fb043583          	ld	a1,-80(s0)
    80007ec2:	fa043503          	ld	a0,-96(s0)
    80007ec6:	ffffa097          	auipc	ra,0xffffa
    80007eca:	500080e7          	jalr	1280(ra) # 800023c6 <copyout>
    80007ece:	87aa                	mv	a5,a0
    80007ed0:	1607c063          	bltz	a5,80008030 <exec+0x434>
      goto bad;
    ustack[argc] = sp;
    80007ed4:	fc043783          	ld	a5,-64(s0)
    80007ed8:	078e                	slli	a5,a5,0x3
    80007eda:	1781                	addi	a5,a5,-32
    80007edc:	97a2                	add	a5,a5,s0
    80007ede:	fb043703          	ld	a4,-80(s0)
    80007ee2:	e8e7b823          	sd	a4,-368(a5) # ffffffffffffee90 <end+0xffffffff7fb55e90>
  for(argc = 0; argv[argc]; argc++) {
    80007ee6:	fc043783          	ld	a5,-64(s0)
    80007eea:	0785                	addi	a5,a5,1
    80007eec:	fcf43023          	sd	a5,-64(s0)
    80007ef0:	fc043783          	ld	a5,-64(s0)
    80007ef4:	078e                	slli	a5,a5,0x3
    80007ef6:	de043703          	ld	a4,-544(s0)
    80007efa:	97ba                	add	a5,a5,a4
    80007efc:	639c                	ld	a5,0(a5)
    80007efe:	f3b9                	bnez	a5,80007e44 <exec+0x248>
  }
  ustack[argc] = 0;
    80007f00:	fc043783          	ld	a5,-64(s0)
    80007f04:	078e                	slli	a5,a5,0x3
    80007f06:	1781                	addi	a5,a5,-32
    80007f08:	97a2                	add	a5,a5,s0
    80007f0a:	e807b823          	sd	zero,-368(a5)

  // push the array of argv[] pointers.

  sp -= sp % 16;
    80007f0e:	fb043783          	ld	a5,-80(s0)
    80007f12:	9bc1                	andi	a5,a5,-16
    80007f14:	faf43823          	sd	a5,-80(s0)
  if(sp < stackbase)
    80007f18:	fb043703          	ld	a4,-80(s0)
    80007f1c:	f8043783          	ld	a5,-128(s0)
    80007f20:	10f76a63          	bltu	a4,a5,80008034 <exec+0x438>
    goto bad;
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80007f24:	fc043783          	ld	a5,-64(s0)
    80007f28:	0785                	addi	a5,a5,1
    80007f2a:	00379713          	slli	a4,a5,0x3
    80007f2e:	e7040793          	addi	a5,s0,-400
    80007f32:	86ba                	mv	a3,a4
    80007f34:	863e                	mv	a2,a5
    80007f36:	fb043583          	ld	a1,-80(s0)
    80007f3a:	fa043503          	ld	a0,-96(s0)
    80007f3e:	ffffa097          	auipc	ra,0xffffa
    80007f42:	488080e7          	jalr	1160(ra) # 800023c6 <copyout>
    80007f46:	87aa                	mv	a5,a0
    80007f48:	0e07c863          	bltz	a5,80008038 <exec+0x43c>
    goto bad;

  // arguments to user main(argc, argv)
  // argc is returned via the system call return
  // value, which goes in a0.
  p->trapframe->a1 = sp;
    80007f4c:	f9843783          	ld	a5,-104(s0)
    80007f50:	73bc                	ld	a5,96(a5)
    80007f52:	fb043703          	ld	a4,-80(s0)
    80007f56:	ffb8                	sd	a4,120(a5)

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    80007f58:	de843783          	ld	a5,-536(s0)
    80007f5c:	fcf43c23          	sd	a5,-40(s0)
    80007f60:	fd843783          	ld	a5,-40(s0)
    80007f64:	fcf43823          	sd	a5,-48(s0)
    80007f68:	a025                	j	80007f90 <exec+0x394>
    if(*s == '/')
    80007f6a:	fd843783          	ld	a5,-40(s0)
    80007f6e:	0007c783          	lbu	a5,0(a5)
    80007f72:	873e                	mv	a4,a5
    80007f74:	02f00793          	li	a5,47
    80007f78:	00f71763          	bne	a4,a5,80007f86 <exec+0x38a>
      last = s+1;
    80007f7c:	fd843783          	ld	a5,-40(s0)
    80007f80:	0785                	addi	a5,a5,1
    80007f82:	fcf43823          	sd	a5,-48(s0)
  for(last=s=path; *s; s++)
    80007f86:	fd843783          	ld	a5,-40(s0)
    80007f8a:	0785                	addi	a5,a5,1
    80007f8c:	fcf43c23          	sd	a5,-40(s0)
    80007f90:	fd843783          	ld	a5,-40(s0)
    80007f94:	0007c783          	lbu	a5,0(a5)
    80007f98:	fbe9                	bnez	a5,80007f6a <exec+0x36e>
  safestrcpy(p->name, last, sizeof(p->name));
    80007f9a:	f9843783          	ld	a5,-104(s0)
    80007f9e:	16878793          	addi	a5,a5,360
    80007fa2:	4641                	li	a2,16
    80007fa4:	fd043583          	ld	a1,-48(s0)
    80007fa8:	853e                	mv	a0,a5
    80007faa:	ffff9097          	auipc	ra,0xffff9
    80007fae:	798080e7          	jalr	1944(ra) # 80001742 <safestrcpy>
    
  // Commit to the user image.
  oldpagetable = p->pagetable;
    80007fb2:	f9843783          	ld	a5,-104(s0)
    80007fb6:	6bbc                	ld	a5,80(a5)
    80007fb8:	f6f43c23          	sd	a5,-136(s0)
  p->pagetable = pagetable;
    80007fbc:	f9843783          	ld	a5,-104(s0)
    80007fc0:	fa043703          	ld	a4,-96(s0)
    80007fc4:	ebb8                	sd	a4,80(a5)
  p->sz = sz;
    80007fc6:	f9843783          	ld	a5,-104(s0)
    80007fca:	fb843703          	ld	a4,-72(s0)
    80007fce:	e7b8                	sd	a4,72(a5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80007fd0:	f9843783          	ld	a5,-104(s0)
    80007fd4:	73bc                	ld	a5,96(a5)
    80007fd6:	e4843703          	ld	a4,-440(s0)
    80007fda:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80007fdc:	f9843783          	ld	a5,-104(s0)
    80007fe0:	73bc                	ld	a5,96(a5)
    80007fe2:	fb043703          	ld	a4,-80(s0)
    80007fe6:	fb98                	sd	a4,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80007fe8:	f9043583          	ld	a1,-112(s0)
    80007fec:	f7843503          	ld	a0,-136(s0)
    80007ff0:	ffffb097          	auipc	ra,0xffffb
    80007ff4:	e7a080e7          	jalr	-390(ra) # 80002e6a <proc_freepagetable>

  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80007ff8:	fc043783          	ld	a5,-64(s0)
    80007ffc:	2781                	sext.w	a5,a5
    80007ffe:	a0bd                	j	8000806c <exec+0x470>
    goto bad;
    80008000:	0001                	nop
    80008002:	a825                	j	8000803a <exec+0x43e>
    goto bad;
    80008004:	0001                	nop
    80008006:	a815                	j	8000803a <exec+0x43e>
    goto bad;
    80008008:	0001                	nop
    8000800a:	a805                	j	8000803a <exec+0x43e>
      goto bad;
    8000800c:	0001                	nop
    8000800e:	a035                	j	8000803a <exec+0x43e>
      goto bad;
    80008010:	0001                	nop
    80008012:	a025                	j	8000803a <exec+0x43e>
      goto bad;
    80008014:	0001                	nop
    80008016:	a015                	j	8000803a <exec+0x43e>
      goto bad;
    80008018:	0001                	nop
    8000801a:	a005                	j	8000803a <exec+0x43e>
      goto bad;
    8000801c:	0001                	nop
    8000801e:	a831                	j	8000803a <exec+0x43e>
      goto bad;
    80008020:	0001                	nop
    80008022:	a821                	j	8000803a <exec+0x43e>
    goto bad;
    80008024:	0001                	nop
    80008026:	a811                	j	8000803a <exec+0x43e>
      goto bad;
    80008028:	0001                	nop
    8000802a:	a801                	j	8000803a <exec+0x43e>
      goto bad;
    8000802c:	0001                	nop
    8000802e:	a031                	j	8000803a <exec+0x43e>
      goto bad;
    80008030:	0001                	nop
    80008032:	a021                	j	8000803a <exec+0x43e>
    goto bad;
    80008034:	0001                	nop
    80008036:	a011                	j	8000803a <exec+0x43e>
    goto bad;
    80008038:	0001                	nop

 bad:
  if(pagetable)
    8000803a:	fa043783          	ld	a5,-96(s0)
    8000803e:	cb89                	beqz	a5,80008050 <exec+0x454>
    proc_freepagetable(pagetable, sz);
    80008040:	fb843583          	ld	a1,-72(s0)
    80008044:	fa043503          	ld	a0,-96(s0)
    80008048:	ffffb097          	auipc	ra,0xffffb
    8000804c:	e22080e7          	jalr	-478(ra) # 80002e6a <proc_freepagetable>
  if(ip){
    80008050:	fa843783          	ld	a5,-88(s0)
    80008054:	cb99                	beqz	a5,8000806a <exec+0x46e>
    iunlockput(ip);
    80008056:	fa843503          	ld	a0,-88(s0)
    8000805a:	ffffe097          	auipc	ra,0xffffe
    8000805e:	d48080e7          	jalr	-696(ra) # 80005da2 <iunlockput>
    end_op();
    80008062:	fffff097          	auipc	ra,0xfffff
    80008066:	c0c080e7          	jalr	-1012(ra) # 80006c6e <end_op>
  }
  return -1;
    8000806a:	57fd                	li	a5,-1
}
    8000806c:	853e                	mv	a0,a5
    8000806e:	21813083          	ld	ra,536(sp)
    80008072:	21013403          	ld	s0,528(sp)
    80008076:	20813483          	ld	s1,520(sp)
    8000807a:	22010113          	addi	sp,sp,544
    8000807e:	8082                	ret

0000000080008080 <loadseg>:
// va must be page-aligned
// and the pages from va to va+sz must already be mapped.
// Returns 0 on success, -1 on failure.
static int
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
    80008080:	7139                	addi	sp,sp,-64
    80008082:	fc06                	sd	ra,56(sp)
    80008084:	f822                	sd	s0,48(sp)
    80008086:	0080                	addi	s0,sp,64
    80008088:	fca43c23          	sd	a0,-40(s0)
    8000808c:	fcb43823          	sd	a1,-48(s0)
    80008090:	fcc43423          	sd	a2,-56(s0)
    80008094:	87b6                	mv	a5,a3
    80008096:	fcf42223          	sw	a5,-60(s0)
    8000809a:	87ba                	mv	a5,a4
    8000809c:	fcf42023          	sw	a5,-64(s0)
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    800080a0:	fe042623          	sw	zero,-20(s0)
    800080a4:	a07d                	j	80008152 <loadseg+0xd2>
    pa = walkaddr(pagetable, va + i);
    800080a6:	fec46703          	lwu	a4,-20(s0)
    800080aa:	fd043783          	ld	a5,-48(s0)
    800080ae:	97ba                	add	a5,a5,a4
    800080b0:	85be                	mv	a1,a5
    800080b2:	fd843503          	ld	a0,-40(s0)
    800080b6:	ffffa097          	auipc	ra,0xffffa
    800080ba:	ade080e7          	jalr	-1314(ra) # 80001b94 <walkaddr>
    800080be:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    800080c2:	fe043783          	ld	a5,-32(s0)
    800080c6:	eb89                	bnez	a5,800080d8 <loadseg+0x58>
      panic("loadseg: address should exist");
    800080c8:	00003517          	auipc	a0,0x3
    800080cc:	6b850513          	addi	a0,a0,1720 # 8000b780 <etext+0x780>
    800080d0:	ffff9097          	auipc	ra,0xffff9
    800080d4:	baa080e7          	jalr	-1110(ra) # 80000c7a <panic>
    if(sz - i < PGSIZE)
    800080d8:	fc042783          	lw	a5,-64(s0)
    800080dc:	873e                	mv	a4,a5
    800080de:	fec42783          	lw	a5,-20(s0)
    800080e2:	40f707bb          	subw	a5,a4,a5
    800080e6:	2781                	sext.w	a5,a5
    800080e8:	873e                	mv	a4,a5
    800080ea:	6785                	lui	a5,0x1
    800080ec:	00f77c63          	bgeu	a4,a5,80008104 <loadseg+0x84>
      n = sz - i;
    800080f0:	fc042783          	lw	a5,-64(s0)
    800080f4:	873e                	mv	a4,a5
    800080f6:	fec42783          	lw	a5,-20(s0)
    800080fa:	40f707bb          	subw	a5,a4,a5
    800080fe:	fef42423          	sw	a5,-24(s0)
    80008102:	a021                	j	8000810a <loadseg+0x8a>
    else
      n = PGSIZE;
    80008104:	6785                	lui	a5,0x1
    80008106:	fef42423          	sw	a5,-24(s0)
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    8000810a:	fc442783          	lw	a5,-60(s0)
    8000810e:	873e                	mv	a4,a5
    80008110:	fec42783          	lw	a5,-20(s0)
    80008114:	9fb9                	addw	a5,a5,a4
    80008116:	2781                	sext.w	a5,a5
    80008118:	fe842703          	lw	a4,-24(s0)
    8000811c:	86be                	mv	a3,a5
    8000811e:	fe043603          	ld	a2,-32(s0)
    80008122:	4581                	li	a1,0
    80008124:	fc843503          	ld	a0,-56(s0)
    80008128:	ffffe097          	auipc	ra,0xffffe
    8000812c:	fb2080e7          	jalr	-78(ra) # 800060da <readi>
    80008130:	87aa                	mv	a5,a0
    80008132:	0007871b          	sext.w	a4,a5
    80008136:	fe842783          	lw	a5,-24(s0)
    8000813a:	2781                	sext.w	a5,a5
    8000813c:	00e78463          	beq	a5,a4,80008144 <loadseg+0xc4>
      return -1;
    80008140:	57fd                	li	a5,-1
    80008142:	a015                	j	80008166 <loadseg+0xe6>
  for(i = 0; i < sz; i += PGSIZE){
    80008144:	fec42783          	lw	a5,-20(s0)
    80008148:	873e                	mv	a4,a5
    8000814a:	6785                	lui	a5,0x1
    8000814c:	9fb9                	addw	a5,a5,a4
    8000814e:	fef42623          	sw	a5,-20(s0)
    80008152:	fec42783          	lw	a5,-20(s0)
    80008156:	873e                	mv	a4,a5
    80008158:	fc042783          	lw	a5,-64(s0)
    8000815c:	2701                	sext.w	a4,a4
    8000815e:	2781                	sext.w	a5,a5
    80008160:	f4f763e3          	bltu	a4,a5,800080a6 <loadseg+0x26>
  }
  
  return 0;
    80008164:	4781                	li	a5,0
}
    80008166:	853e                	mv	a0,a5
    80008168:	70e2                	ld	ra,56(sp)
    8000816a:	7442                	ld	s0,48(sp)
    8000816c:	6121                	addi	sp,sp,64
    8000816e:	8082                	ret

0000000080008170 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80008170:	7139                	addi	sp,sp,-64
    80008172:	fc06                	sd	ra,56(sp)
    80008174:	f822                	sd	s0,48(sp)
    80008176:	0080                	addi	s0,sp,64
    80008178:	87aa                	mv	a5,a0
    8000817a:	fcb43823          	sd	a1,-48(s0)
    8000817e:	fcc43423          	sd	a2,-56(s0)
    80008182:	fcf42e23          	sw	a5,-36(s0)
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80008186:	fe440713          	addi	a4,s0,-28
    8000818a:	fdc42783          	lw	a5,-36(s0)
    8000818e:	85ba                	mv	a1,a4
    80008190:	853e                	mv	a0,a5
    80008192:	ffffd097          	auipc	ra,0xffffd
    80008196:	886080e7          	jalr	-1914(ra) # 80004a18 <argint>
    8000819a:	87aa                	mv	a5,a0
    8000819c:	0007d463          	bgez	a5,800081a4 <argfd+0x34>
    return -1;
    800081a0:	57fd                	li	a5,-1
    800081a2:	a8b1                	j	800081fe <argfd+0x8e>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    800081a4:	fe442783          	lw	a5,-28(s0)
    800081a8:	0207c863          	bltz	a5,800081d8 <argfd+0x68>
    800081ac:	fe442783          	lw	a5,-28(s0)
    800081b0:	873e                	mv	a4,a5
    800081b2:	47bd                	li	a5,15
    800081b4:	02e7c263          	blt	a5,a4,800081d8 <argfd+0x68>
    800081b8:	ffffb097          	auipc	ra,0xffffb
    800081bc:	860080e7          	jalr	-1952(ra) # 80002a18 <myproc>
    800081c0:	872a                	mv	a4,a0
    800081c2:	fe442783          	lw	a5,-28(s0)
    800081c6:	07f1                	addi	a5,a5,28
    800081c8:	078e                	slli	a5,a5,0x3
    800081ca:	97ba                	add	a5,a5,a4
    800081cc:	639c                	ld	a5,0(a5)
    800081ce:	fef43423          	sd	a5,-24(s0)
    800081d2:	fe843783          	ld	a5,-24(s0)
    800081d6:	e399                	bnez	a5,800081dc <argfd+0x6c>
    return -1;
    800081d8:	57fd                	li	a5,-1
    800081da:	a015                	j	800081fe <argfd+0x8e>
  if(pfd)
    800081dc:	fd043783          	ld	a5,-48(s0)
    800081e0:	c791                	beqz	a5,800081ec <argfd+0x7c>
    *pfd = fd;
    800081e2:	fe442703          	lw	a4,-28(s0)
    800081e6:	fd043783          	ld	a5,-48(s0)
    800081ea:	c398                	sw	a4,0(a5)
  if(pf)
    800081ec:	fc843783          	ld	a5,-56(s0)
    800081f0:	c791                	beqz	a5,800081fc <argfd+0x8c>
    *pf = f;
    800081f2:	fc843783          	ld	a5,-56(s0)
    800081f6:	fe843703          	ld	a4,-24(s0)
    800081fa:	e398                	sd	a4,0(a5)
  return 0;
    800081fc:	4781                	li	a5,0
}
    800081fe:	853e                	mv	a0,a5
    80008200:	70e2                	ld	ra,56(sp)
    80008202:	7442                	ld	s0,48(sp)
    80008204:	6121                	addi	sp,sp,64
    80008206:	8082                	ret

0000000080008208 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80008208:	7179                	addi	sp,sp,-48
    8000820a:	f406                	sd	ra,40(sp)
    8000820c:	f022                	sd	s0,32(sp)
    8000820e:	1800                	addi	s0,sp,48
    80008210:	fca43c23          	sd	a0,-40(s0)
  int fd;
  struct proc *p = myproc();
    80008214:	ffffb097          	auipc	ra,0xffffb
    80008218:	804080e7          	jalr	-2044(ra) # 80002a18 <myproc>
    8000821c:	fea43023          	sd	a0,-32(s0)

  for(fd = 0; fd < NOFILE; fd++){
    80008220:	fe042623          	sw	zero,-20(s0)
    80008224:	a825                	j	8000825c <fdalloc+0x54>
    if(p->ofile[fd] == 0){
    80008226:	fe043703          	ld	a4,-32(s0)
    8000822a:	fec42783          	lw	a5,-20(s0)
    8000822e:	07f1                	addi	a5,a5,28
    80008230:	078e                	slli	a5,a5,0x3
    80008232:	97ba                	add	a5,a5,a4
    80008234:	639c                	ld	a5,0(a5)
    80008236:	ef91                	bnez	a5,80008252 <fdalloc+0x4a>
      p->ofile[fd] = f;
    80008238:	fe043703          	ld	a4,-32(s0)
    8000823c:	fec42783          	lw	a5,-20(s0)
    80008240:	07f1                	addi	a5,a5,28
    80008242:	078e                	slli	a5,a5,0x3
    80008244:	97ba                	add	a5,a5,a4
    80008246:	fd843703          	ld	a4,-40(s0)
    8000824a:	e398                	sd	a4,0(a5)
      return fd;
    8000824c:	fec42783          	lw	a5,-20(s0)
    80008250:	a831                	j	8000826c <fdalloc+0x64>
  for(fd = 0; fd < NOFILE; fd++){
    80008252:	fec42783          	lw	a5,-20(s0)
    80008256:	2785                	addiw	a5,a5,1
    80008258:	fef42623          	sw	a5,-20(s0)
    8000825c:	fec42783          	lw	a5,-20(s0)
    80008260:	0007871b          	sext.w	a4,a5
    80008264:	47bd                	li	a5,15
    80008266:	fce7d0e3          	bge	a5,a4,80008226 <fdalloc+0x1e>
    }
  }
  return -1;
    8000826a:	57fd                	li	a5,-1
}
    8000826c:	853e                	mv	a0,a5
    8000826e:	70a2                	ld	ra,40(sp)
    80008270:	7402                	ld	s0,32(sp)
    80008272:	6145                	addi	sp,sp,48
    80008274:	8082                	ret

0000000080008276 <sys_dup>:

uint64
sys_dup(void)
{
    80008276:	1101                	addi	sp,sp,-32
    80008278:	ec06                	sd	ra,24(sp)
    8000827a:	e822                	sd	s0,16(sp)
    8000827c:	1000                	addi	s0,sp,32
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    8000827e:	fe040793          	addi	a5,s0,-32
    80008282:	863e                	mv	a2,a5
    80008284:	4581                	li	a1,0
    80008286:	4501                	li	a0,0
    80008288:	00000097          	auipc	ra,0x0
    8000828c:	ee8080e7          	jalr	-280(ra) # 80008170 <argfd>
    80008290:	87aa                	mv	a5,a0
    80008292:	0007d463          	bgez	a5,8000829a <sys_dup+0x24>
    return -1;
    80008296:	57fd                	li	a5,-1
    80008298:	a81d                	j	800082ce <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
    8000829a:	fe043783          	ld	a5,-32(s0)
    8000829e:	853e                	mv	a0,a5
    800082a0:	00000097          	auipc	ra,0x0
    800082a4:	f68080e7          	jalr	-152(ra) # 80008208 <fdalloc>
    800082a8:	87aa                	mv	a5,a0
    800082aa:	fef42623          	sw	a5,-20(s0)
    800082ae:	fec42783          	lw	a5,-20(s0)
    800082b2:	2781                	sext.w	a5,a5
    800082b4:	0007d463          	bgez	a5,800082bc <sys_dup+0x46>
    return -1;
    800082b8:	57fd                	li	a5,-1
    800082ba:	a811                	j	800082ce <sys_dup+0x58>
  filedup(f);
    800082bc:	fe043783          	ld	a5,-32(s0)
    800082c0:	853e                	mv	a0,a5
    800082c2:	fffff097          	auipc	ra,0xfffff
    800082c6:	f1e080e7          	jalr	-226(ra) # 800071e0 <filedup>
  return fd;
    800082ca:	fec42783          	lw	a5,-20(s0)
}
    800082ce:	853e                	mv	a0,a5
    800082d0:	60e2                	ld	ra,24(sp)
    800082d2:	6442                	ld	s0,16(sp)
    800082d4:	6105                	addi	sp,sp,32
    800082d6:	8082                	ret

00000000800082d8 <sys_read>:

uint64
sys_read(void)
{
    800082d8:	7179                	addi	sp,sp,-48
    800082da:	f406                	sd	ra,40(sp)
    800082dc:	f022                	sd	s0,32(sp)
    800082de:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800082e0:	fe840793          	addi	a5,s0,-24
    800082e4:	863e                	mv	a2,a5
    800082e6:	4581                	li	a1,0
    800082e8:	4501                	li	a0,0
    800082ea:	00000097          	auipc	ra,0x0
    800082ee:	e86080e7          	jalr	-378(ra) # 80008170 <argfd>
    800082f2:	87aa                	mv	a5,a0
    800082f4:	0207c863          	bltz	a5,80008324 <sys_read+0x4c>
    800082f8:	fe440793          	addi	a5,s0,-28
    800082fc:	85be                	mv	a1,a5
    800082fe:	4509                	li	a0,2
    80008300:	ffffc097          	auipc	ra,0xffffc
    80008304:	718080e7          	jalr	1816(ra) # 80004a18 <argint>
    80008308:	87aa                	mv	a5,a0
    8000830a:	0007cd63          	bltz	a5,80008324 <sys_read+0x4c>
    8000830e:	fd840793          	addi	a5,s0,-40
    80008312:	85be                	mv	a1,a5
    80008314:	4505                	li	a0,1
    80008316:	ffffc097          	auipc	ra,0xffffc
    8000831a:	73a080e7          	jalr	1850(ra) # 80004a50 <argaddr>
    8000831e:	87aa                	mv	a5,a0
    80008320:	0007d463          	bgez	a5,80008328 <sys_read+0x50>
    return -1;
    80008324:	57fd                	li	a5,-1
    80008326:	a839                	j	80008344 <sys_read+0x6c>
  return fileread(f, p, n);
    80008328:	fe843783          	ld	a5,-24(s0)
    8000832c:	fd843703          	ld	a4,-40(s0)
    80008330:	fe442683          	lw	a3,-28(s0)
    80008334:	8636                	mv	a2,a3
    80008336:	85ba                	mv	a1,a4
    80008338:	853e                	mv	a0,a5
    8000833a:	fffff097          	auipc	ra,0xfffff
    8000833e:	0b8080e7          	jalr	184(ra) # 800073f2 <fileread>
    80008342:	87aa                	mv	a5,a0
}
    80008344:	853e                	mv	a0,a5
    80008346:	70a2                	ld	ra,40(sp)
    80008348:	7402                	ld	s0,32(sp)
    8000834a:	6145                	addi	sp,sp,48
    8000834c:	8082                	ret

000000008000834e <sys_write>:

uint64
sys_write(void)
{
    8000834e:	7179                	addi	sp,sp,-48
    80008350:	f406                	sd	ra,40(sp)
    80008352:	f022                	sd	s0,32(sp)
    80008354:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80008356:	fe840793          	addi	a5,s0,-24
    8000835a:	863e                	mv	a2,a5
    8000835c:	4581                	li	a1,0
    8000835e:	4501                	li	a0,0
    80008360:	00000097          	auipc	ra,0x0
    80008364:	e10080e7          	jalr	-496(ra) # 80008170 <argfd>
    80008368:	87aa                	mv	a5,a0
    8000836a:	0207c863          	bltz	a5,8000839a <sys_write+0x4c>
    8000836e:	fe440793          	addi	a5,s0,-28
    80008372:	85be                	mv	a1,a5
    80008374:	4509                	li	a0,2
    80008376:	ffffc097          	auipc	ra,0xffffc
    8000837a:	6a2080e7          	jalr	1698(ra) # 80004a18 <argint>
    8000837e:	87aa                	mv	a5,a0
    80008380:	0007cd63          	bltz	a5,8000839a <sys_write+0x4c>
    80008384:	fd840793          	addi	a5,s0,-40
    80008388:	85be                	mv	a1,a5
    8000838a:	4505                	li	a0,1
    8000838c:	ffffc097          	auipc	ra,0xffffc
    80008390:	6c4080e7          	jalr	1732(ra) # 80004a50 <argaddr>
    80008394:	87aa                	mv	a5,a0
    80008396:	0007d463          	bgez	a5,8000839e <sys_write+0x50>
    return -1;
    8000839a:	57fd                	li	a5,-1
    8000839c:	a839                	j	800083ba <sys_write+0x6c>

  return filewrite(f, p, n);
    8000839e:	fe843783          	ld	a5,-24(s0)
    800083a2:	fd843703          	ld	a4,-40(s0)
    800083a6:	fe442683          	lw	a3,-28(s0)
    800083aa:	8636                	mv	a2,a3
    800083ac:	85ba                	mv	a1,a4
    800083ae:	853e                	mv	a0,a5
    800083b0:	fffff097          	auipc	ra,0xfffff
    800083b4:	1a8080e7          	jalr	424(ra) # 80007558 <filewrite>
    800083b8:	87aa                	mv	a5,a0
}
    800083ba:	853e                	mv	a0,a5
    800083bc:	70a2                	ld	ra,40(sp)
    800083be:	7402                	ld	s0,32(sp)
    800083c0:	6145                	addi	sp,sp,48
    800083c2:	8082                	ret

00000000800083c4 <sys_close>:

uint64
sys_close(void)
{
    800083c4:	1101                	addi	sp,sp,-32
    800083c6:	ec06                	sd	ra,24(sp)
    800083c8:	e822                	sd	s0,16(sp)
    800083ca:	1000                	addi	s0,sp,32
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    800083cc:	fe040713          	addi	a4,s0,-32
    800083d0:	fec40793          	addi	a5,s0,-20
    800083d4:	863a                	mv	a2,a4
    800083d6:	85be                	mv	a1,a5
    800083d8:	4501                	li	a0,0
    800083da:	00000097          	auipc	ra,0x0
    800083de:	d96080e7          	jalr	-618(ra) # 80008170 <argfd>
    800083e2:	87aa                	mv	a5,a0
    800083e4:	0007d463          	bgez	a5,800083ec <sys_close+0x28>
    return -1;
    800083e8:	57fd                	li	a5,-1
    800083ea:	a02d                	j	80008414 <sys_close+0x50>
  myproc()->ofile[fd] = 0;
    800083ec:	ffffa097          	auipc	ra,0xffffa
    800083f0:	62c080e7          	jalr	1580(ra) # 80002a18 <myproc>
    800083f4:	872a                	mv	a4,a0
    800083f6:	fec42783          	lw	a5,-20(s0)
    800083fa:	07f1                	addi	a5,a5,28
    800083fc:	078e                	slli	a5,a5,0x3
    800083fe:	97ba                	add	a5,a5,a4
    80008400:	0007b023          	sd	zero,0(a5) # 1000 <_entry-0x7ffff000>
  fileclose(f);
    80008404:	fe043783          	ld	a5,-32(s0)
    80008408:	853e                	mv	a0,a5
    8000840a:	fffff097          	auipc	ra,0xfffff
    8000840e:	e3c080e7          	jalr	-452(ra) # 80007246 <fileclose>
  return 0;
    80008412:	4781                	li	a5,0
}
    80008414:	853e                	mv	a0,a5
    80008416:	60e2                	ld	ra,24(sp)
    80008418:	6442                	ld	s0,16(sp)
    8000841a:	6105                	addi	sp,sp,32
    8000841c:	8082                	ret

000000008000841e <sys_fstat>:

uint64
sys_fstat(void)
{
    8000841e:	1101                	addi	sp,sp,-32
    80008420:	ec06                	sd	ra,24(sp)
    80008422:	e822                	sd	s0,16(sp)
    80008424:	1000                	addi	s0,sp,32
  struct file *f;
  uint64 st; // user pointer to struct stat

  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80008426:	fe840793          	addi	a5,s0,-24
    8000842a:	863e                	mv	a2,a5
    8000842c:	4581                	li	a1,0
    8000842e:	4501                	li	a0,0
    80008430:	00000097          	auipc	ra,0x0
    80008434:	d40080e7          	jalr	-704(ra) # 80008170 <argfd>
    80008438:	87aa                	mv	a5,a0
    8000843a:	0007cd63          	bltz	a5,80008454 <sys_fstat+0x36>
    8000843e:	fe040793          	addi	a5,s0,-32
    80008442:	85be                	mv	a1,a5
    80008444:	4505                	li	a0,1
    80008446:	ffffc097          	auipc	ra,0xffffc
    8000844a:	60a080e7          	jalr	1546(ra) # 80004a50 <argaddr>
    8000844e:	87aa                	mv	a5,a0
    80008450:	0007d463          	bgez	a5,80008458 <sys_fstat+0x3a>
    return -1;
    80008454:	57fd                	li	a5,-1
    80008456:	a821                	j	8000846e <sys_fstat+0x50>
  return filestat(f, st);
    80008458:	fe843783          	ld	a5,-24(s0)
    8000845c:	fe043703          	ld	a4,-32(s0)
    80008460:	85ba                	mv	a1,a4
    80008462:	853e                	mv	a0,a5
    80008464:	fffff097          	auipc	ra,0xfffff
    80008468:	eea080e7          	jalr	-278(ra) # 8000734e <filestat>
    8000846c:	87aa                	mv	a5,a0
}
    8000846e:	853e                	mv	a0,a5
    80008470:	60e2                	ld	ra,24(sp)
    80008472:	6442                	ld	s0,16(sp)
    80008474:	6105                	addi	sp,sp,32
    80008476:	8082                	ret

0000000080008478 <sys_link>:

// Create the path new as a link to the same inode as old.
uint64
sys_link(void)
{
    80008478:	7169                	addi	sp,sp,-304
    8000847a:	f606                	sd	ra,296(sp)
    8000847c:	f222                	sd	s0,288(sp)
    8000847e:	1a00                	addi	s0,sp,304
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;

  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80008480:	ed040793          	addi	a5,s0,-304
    80008484:	08000613          	li	a2,128
    80008488:	85be                	mv	a1,a5
    8000848a:	4501                	li	a0,0
    8000848c:	ffffc097          	auipc	ra,0xffffc
    80008490:	5f8080e7          	jalr	1528(ra) # 80004a84 <argstr>
    80008494:	87aa                	mv	a5,a0
    80008496:	0007cf63          	bltz	a5,800084b4 <sys_link+0x3c>
    8000849a:	f5040793          	addi	a5,s0,-176
    8000849e:	08000613          	li	a2,128
    800084a2:	85be                	mv	a1,a5
    800084a4:	4505                	li	a0,1
    800084a6:	ffffc097          	auipc	ra,0xffffc
    800084aa:	5de080e7          	jalr	1502(ra) # 80004a84 <argstr>
    800084ae:	87aa                	mv	a5,a0
    800084b0:	0007d463          	bgez	a5,800084b8 <sys_link+0x40>
    return -1;
    800084b4:	57fd                	li	a5,-1
    800084b6:	aab5                	j	80008632 <sys_link+0x1ba>

  begin_op();
    800084b8:	ffffe097          	auipc	ra,0xffffe
    800084bc:	6f4080e7          	jalr	1780(ra) # 80006bac <begin_op>
  if((ip = namei(old)) == 0){
    800084c0:	ed040793          	addi	a5,s0,-304
    800084c4:	853e                	mv	a0,a5
    800084c6:	ffffe097          	auipc	ra,0xffffe
    800084ca:	382080e7          	jalr	898(ra) # 80006848 <namei>
    800084ce:	fea43423          	sd	a0,-24(s0)
    800084d2:	fe843783          	ld	a5,-24(s0)
    800084d6:	e799                	bnez	a5,800084e4 <sys_link+0x6c>
    end_op();
    800084d8:	ffffe097          	auipc	ra,0xffffe
    800084dc:	796080e7          	jalr	1942(ra) # 80006c6e <end_op>
    return -1;
    800084e0:	57fd                	li	a5,-1
    800084e2:	aa81                	j	80008632 <sys_link+0x1ba>
  }

  ilock(ip);
    800084e4:	fe843503          	ld	a0,-24(s0)
    800084e8:	ffffd097          	auipc	ra,0xffffd
    800084ec:	65c080e7          	jalr	1628(ra) # 80005b44 <ilock>
  if(ip->type == T_DIR){
    800084f0:	fe843783          	ld	a5,-24(s0)
    800084f4:	04479783          	lh	a5,68(a5)
    800084f8:	0007871b          	sext.w	a4,a5
    800084fc:	4785                	li	a5,1
    800084fe:	00f71e63          	bne	a4,a5,8000851a <sys_link+0xa2>
    iunlockput(ip);
    80008502:	fe843503          	ld	a0,-24(s0)
    80008506:	ffffe097          	auipc	ra,0xffffe
    8000850a:	89c080e7          	jalr	-1892(ra) # 80005da2 <iunlockput>
    end_op();
    8000850e:	ffffe097          	auipc	ra,0xffffe
    80008512:	760080e7          	jalr	1888(ra) # 80006c6e <end_op>
    return -1;
    80008516:	57fd                	li	a5,-1
    80008518:	aa29                	j	80008632 <sys_link+0x1ba>
  }

  ip->nlink++;
    8000851a:	fe843783          	ld	a5,-24(s0)
    8000851e:	04a79783          	lh	a5,74(a5)
    80008522:	17c2                	slli	a5,a5,0x30
    80008524:	93c1                	srli	a5,a5,0x30
    80008526:	2785                	addiw	a5,a5,1
    80008528:	17c2                	slli	a5,a5,0x30
    8000852a:	93c1                	srli	a5,a5,0x30
    8000852c:	0107971b          	slliw	a4,a5,0x10
    80008530:	4107571b          	sraiw	a4,a4,0x10
    80008534:	fe843783          	ld	a5,-24(s0)
    80008538:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    8000853c:	fe843503          	ld	a0,-24(s0)
    80008540:	ffffd097          	auipc	ra,0xffffd
    80008544:	3b4080e7          	jalr	948(ra) # 800058f4 <iupdate>
  iunlock(ip);
    80008548:	fe843503          	ld	a0,-24(s0)
    8000854c:	ffffd097          	auipc	ra,0xffffd
    80008550:	72c080e7          	jalr	1836(ra) # 80005c78 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
    80008554:	fd040713          	addi	a4,s0,-48
    80008558:	f5040793          	addi	a5,s0,-176
    8000855c:	85ba                	mv	a1,a4
    8000855e:	853e                	mv	a0,a5
    80008560:	ffffe097          	auipc	ra,0xffffe
    80008564:	314080e7          	jalr	788(ra) # 80006874 <nameiparent>
    80008568:	fea43023          	sd	a0,-32(s0)
    8000856c:	fe043783          	ld	a5,-32(s0)
    80008570:	cba5                	beqz	a5,800085e0 <sys_link+0x168>
    goto bad;
  ilock(dp);
    80008572:	fe043503          	ld	a0,-32(s0)
    80008576:	ffffd097          	auipc	ra,0xffffd
    8000857a:	5ce080e7          	jalr	1486(ra) # 80005b44 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    8000857e:	fe043783          	ld	a5,-32(s0)
    80008582:	4398                	lw	a4,0(a5)
    80008584:	fe843783          	ld	a5,-24(s0)
    80008588:	439c                	lw	a5,0(a5)
    8000858a:	02f71263          	bne	a4,a5,800085ae <sys_link+0x136>
    8000858e:	fe843783          	ld	a5,-24(s0)
    80008592:	43d8                	lw	a4,4(a5)
    80008594:	fd040793          	addi	a5,s0,-48
    80008598:	863a                	mv	a2,a4
    8000859a:	85be                	mv	a1,a5
    8000859c:	fe043503          	ld	a0,-32(s0)
    800085a0:	ffffe097          	auipc	ra,0xffffe
    800085a4:	f8e080e7          	jalr	-114(ra) # 8000652e <dirlink>
    800085a8:	87aa                	mv	a5,a0
    800085aa:	0007d963          	bgez	a5,800085bc <sys_link+0x144>
    iunlockput(dp);
    800085ae:	fe043503          	ld	a0,-32(s0)
    800085b2:	ffffd097          	auipc	ra,0xffffd
    800085b6:	7f0080e7          	jalr	2032(ra) # 80005da2 <iunlockput>
    goto bad;
    800085ba:	a025                	j	800085e2 <sys_link+0x16a>
  }
  iunlockput(dp);
    800085bc:	fe043503          	ld	a0,-32(s0)
    800085c0:	ffffd097          	auipc	ra,0xffffd
    800085c4:	7e2080e7          	jalr	2018(ra) # 80005da2 <iunlockput>
  iput(ip);
    800085c8:	fe843503          	ld	a0,-24(s0)
    800085cc:	ffffd097          	auipc	ra,0xffffd
    800085d0:	706080e7          	jalr	1798(ra) # 80005cd2 <iput>

  end_op();
    800085d4:	ffffe097          	auipc	ra,0xffffe
    800085d8:	69a080e7          	jalr	1690(ra) # 80006c6e <end_op>

  return 0;
    800085dc:	4781                	li	a5,0
    800085de:	a891                	j	80008632 <sys_link+0x1ba>
    goto bad;
    800085e0:	0001                	nop

bad:
  ilock(ip);
    800085e2:	fe843503          	ld	a0,-24(s0)
    800085e6:	ffffd097          	auipc	ra,0xffffd
    800085ea:	55e080e7          	jalr	1374(ra) # 80005b44 <ilock>
  ip->nlink--;
    800085ee:	fe843783          	ld	a5,-24(s0)
    800085f2:	04a79783          	lh	a5,74(a5)
    800085f6:	17c2                	slli	a5,a5,0x30
    800085f8:	93c1                	srli	a5,a5,0x30
    800085fa:	37fd                	addiw	a5,a5,-1
    800085fc:	17c2                	slli	a5,a5,0x30
    800085fe:	93c1                	srli	a5,a5,0x30
    80008600:	0107971b          	slliw	a4,a5,0x10
    80008604:	4107571b          	sraiw	a4,a4,0x10
    80008608:	fe843783          	ld	a5,-24(s0)
    8000860c:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80008610:	fe843503          	ld	a0,-24(s0)
    80008614:	ffffd097          	auipc	ra,0xffffd
    80008618:	2e0080e7          	jalr	736(ra) # 800058f4 <iupdate>
  iunlockput(ip);
    8000861c:	fe843503          	ld	a0,-24(s0)
    80008620:	ffffd097          	auipc	ra,0xffffd
    80008624:	782080e7          	jalr	1922(ra) # 80005da2 <iunlockput>
  end_op();
    80008628:	ffffe097          	auipc	ra,0xffffe
    8000862c:	646080e7          	jalr	1606(ra) # 80006c6e <end_op>
  return -1;
    80008630:	57fd                	li	a5,-1
}
    80008632:	853e                	mv	a0,a5
    80008634:	70b2                	ld	ra,296(sp)
    80008636:	7412                	ld	s0,288(sp)
    80008638:	6155                	addi	sp,sp,304
    8000863a:	8082                	ret

000000008000863c <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
    8000863c:	7139                	addi	sp,sp,-64
    8000863e:	fc06                	sd	ra,56(sp)
    80008640:	f822                	sd	s0,48(sp)
    80008642:	0080                	addi	s0,sp,64
    80008644:	fca43423          	sd	a0,-56(s0)
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80008648:	02000793          	li	a5,32
    8000864c:	fef42623          	sw	a5,-20(s0)
    80008650:	a0b1                	j	8000869c <isdirempty+0x60>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80008652:	fd840793          	addi	a5,s0,-40
    80008656:	fec42683          	lw	a3,-20(s0)
    8000865a:	4741                	li	a4,16
    8000865c:	863e                	mv	a2,a5
    8000865e:	4581                	li	a1,0
    80008660:	fc843503          	ld	a0,-56(s0)
    80008664:	ffffe097          	auipc	ra,0xffffe
    80008668:	a76080e7          	jalr	-1418(ra) # 800060da <readi>
    8000866c:	87aa                	mv	a5,a0
    8000866e:	873e                	mv	a4,a5
    80008670:	47c1                	li	a5,16
    80008672:	00f70a63          	beq	a4,a5,80008686 <isdirempty+0x4a>
      panic("isdirempty: readi");
    80008676:	00003517          	auipc	a0,0x3
    8000867a:	12a50513          	addi	a0,a0,298 # 8000b7a0 <etext+0x7a0>
    8000867e:	ffff8097          	auipc	ra,0xffff8
    80008682:	5fc080e7          	jalr	1532(ra) # 80000c7a <panic>
    if(de.inum != 0)
    80008686:	fd845783          	lhu	a5,-40(s0)
    8000868a:	c399                	beqz	a5,80008690 <isdirempty+0x54>
      return 0;
    8000868c:	4781                	li	a5,0
    8000868e:	a839                	j	800086ac <isdirempty+0x70>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80008690:	fec42783          	lw	a5,-20(s0)
    80008694:	27c1                	addiw	a5,a5,16
    80008696:	2781                	sext.w	a5,a5
    80008698:	fef42623          	sw	a5,-20(s0)
    8000869c:	fc843783          	ld	a5,-56(s0)
    800086a0:	47f8                	lw	a4,76(a5)
    800086a2:	fec42783          	lw	a5,-20(s0)
    800086a6:	fae7e6e3          	bltu	a5,a4,80008652 <isdirempty+0x16>
  }
  return 1;
    800086aa:	4785                	li	a5,1
}
    800086ac:	853e                	mv	a0,a5
    800086ae:	70e2                	ld	ra,56(sp)
    800086b0:	7442                	ld	s0,48(sp)
    800086b2:	6121                	addi	sp,sp,64
    800086b4:	8082                	ret

00000000800086b6 <sys_unlink>:

uint64
sys_unlink(void)
{
    800086b6:	7155                	addi	sp,sp,-208
    800086b8:	e586                	sd	ra,200(sp)
    800086ba:	e1a2                	sd	s0,192(sp)
    800086bc:	0980                	addi	s0,sp,208
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;

  if(argstr(0, path, MAXPATH) < 0)
    800086be:	f4040793          	addi	a5,s0,-192
    800086c2:	08000613          	li	a2,128
    800086c6:	85be                	mv	a1,a5
    800086c8:	4501                	li	a0,0
    800086ca:	ffffc097          	auipc	ra,0xffffc
    800086ce:	3ba080e7          	jalr	954(ra) # 80004a84 <argstr>
    800086d2:	87aa                	mv	a5,a0
    800086d4:	0007d463          	bgez	a5,800086dc <sys_unlink+0x26>
    return -1;
    800086d8:	57fd                	li	a5,-1
    800086da:	a2ed                	j	800088c4 <sys_unlink+0x20e>

  begin_op();
    800086dc:	ffffe097          	auipc	ra,0xffffe
    800086e0:	4d0080e7          	jalr	1232(ra) # 80006bac <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800086e4:	fc040713          	addi	a4,s0,-64
    800086e8:	f4040793          	addi	a5,s0,-192
    800086ec:	85ba                	mv	a1,a4
    800086ee:	853e                	mv	a0,a5
    800086f0:	ffffe097          	auipc	ra,0xffffe
    800086f4:	184080e7          	jalr	388(ra) # 80006874 <nameiparent>
    800086f8:	fea43423          	sd	a0,-24(s0)
    800086fc:	fe843783          	ld	a5,-24(s0)
    80008700:	e799                	bnez	a5,8000870e <sys_unlink+0x58>
    end_op();
    80008702:	ffffe097          	auipc	ra,0xffffe
    80008706:	56c080e7          	jalr	1388(ra) # 80006c6e <end_op>
    return -1;
    8000870a:	57fd                	li	a5,-1
    8000870c:	aa65                	j	800088c4 <sys_unlink+0x20e>
  }

  ilock(dp);
    8000870e:	fe843503          	ld	a0,-24(s0)
    80008712:	ffffd097          	auipc	ra,0xffffd
    80008716:	432080e7          	jalr	1074(ra) # 80005b44 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    8000871a:	fc040793          	addi	a5,s0,-64
    8000871e:	00003597          	auipc	a1,0x3
    80008722:	09a58593          	addi	a1,a1,154 # 8000b7b8 <etext+0x7b8>
    80008726:	853e                	mv	a0,a5
    80008728:	ffffe097          	auipc	ra,0xffffe
    8000872c:	cf0080e7          	jalr	-784(ra) # 80006418 <namecmp>
    80008730:	87aa                	mv	a5,a0
    80008732:	16078b63          	beqz	a5,800088a8 <sys_unlink+0x1f2>
    80008736:	fc040793          	addi	a5,s0,-64
    8000873a:	00003597          	auipc	a1,0x3
    8000873e:	08658593          	addi	a1,a1,134 # 8000b7c0 <etext+0x7c0>
    80008742:	853e                	mv	a0,a5
    80008744:	ffffe097          	auipc	ra,0xffffe
    80008748:	cd4080e7          	jalr	-812(ra) # 80006418 <namecmp>
    8000874c:	87aa                	mv	a5,a0
    8000874e:	14078d63          	beqz	a5,800088a8 <sys_unlink+0x1f2>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    80008752:	f3c40713          	addi	a4,s0,-196
    80008756:	fc040793          	addi	a5,s0,-64
    8000875a:	863a                	mv	a2,a4
    8000875c:	85be                	mv	a1,a5
    8000875e:	fe843503          	ld	a0,-24(s0)
    80008762:	ffffe097          	auipc	ra,0xffffe
    80008766:	ce4080e7          	jalr	-796(ra) # 80006446 <dirlookup>
    8000876a:	fea43023          	sd	a0,-32(s0)
    8000876e:	fe043783          	ld	a5,-32(s0)
    80008772:	12078d63          	beqz	a5,800088ac <sys_unlink+0x1f6>
    goto bad;
  ilock(ip);
    80008776:	fe043503          	ld	a0,-32(s0)
    8000877a:	ffffd097          	auipc	ra,0xffffd
    8000877e:	3ca080e7          	jalr	970(ra) # 80005b44 <ilock>

  if(ip->nlink < 1)
    80008782:	fe043783          	ld	a5,-32(s0)
    80008786:	04a79783          	lh	a5,74(a5)
    8000878a:	2781                	sext.w	a5,a5
    8000878c:	00f04a63          	bgtz	a5,800087a0 <sys_unlink+0xea>
    panic("unlink: nlink < 1");
    80008790:	00003517          	auipc	a0,0x3
    80008794:	03850513          	addi	a0,a0,56 # 8000b7c8 <etext+0x7c8>
    80008798:	ffff8097          	auipc	ra,0xffff8
    8000879c:	4e2080e7          	jalr	1250(ra) # 80000c7a <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
    800087a0:	fe043783          	ld	a5,-32(s0)
    800087a4:	04479783          	lh	a5,68(a5)
    800087a8:	0007871b          	sext.w	a4,a5
    800087ac:	4785                	li	a5,1
    800087ae:	02f71163          	bne	a4,a5,800087d0 <sys_unlink+0x11a>
    800087b2:	fe043503          	ld	a0,-32(s0)
    800087b6:	00000097          	auipc	ra,0x0
    800087ba:	e86080e7          	jalr	-378(ra) # 8000863c <isdirempty>
    800087be:	87aa                	mv	a5,a0
    800087c0:	eb81                	bnez	a5,800087d0 <sys_unlink+0x11a>
    iunlockput(ip);
    800087c2:	fe043503          	ld	a0,-32(s0)
    800087c6:	ffffd097          	auipc	ra,0xffffd
    800087ca:	5dc080e7          	jalr	1500(ra) # 80005da2 <iunlockput>
    goto bad;
    800087ce:	a0c5                	j	800088ae <sys_unlink+0x1f8>
  }

  memset(&de, 0, sizeof(de));
    800087d0:	fd040793          	addi	a5,s0,-48
    800087d4:	4641                	li	a2,16
    800087d6:	4581                	li	a1,0
    800087d8:	853e                	mv	a0,a5
    800087da:	ffff9097          	auipc	ra,0xffff9
    800087de:	c64080e7          	jalr	-924(ra) # 8000143e <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800087e2:	fd040793          	addi	a5,s0,-48
    800087e6:	f3c42683          	lw	a3,-196(s0)
    800087ea:	4741                	li	a4,16
    800087ec:	863e                	mv	a2,a5
    800087ee:	4581                	li	a1,0
    800087f0:	fe843503          	ld	a0,-24(s0)
    800087f4:	ffffe097          	auipc	ra,0xffffe
    800087f8:	a76080e7          	jalr	-1418(ra) # 8000626a <writei>
    800087fc:	87aa                	mv	a5,a0
    800087fe:	873e                	mv	a4,a5
    80008800:	47c1                	li	a5,16
    80008802:	00f70a63          	beq	a4,a5,80008816 <sys_unlink+0x160>
    panic("unlink: writei");
    80008806:	00003517          	auipc	a0,0x3
    8000880a:	fda50513          	addi	a0,a0,-38 # 8000b7e0 <etext+0x7e0>
    8000880e:	ffff8097          	auipc	ra,0xffff8
    80008812:	46c080e7          	jalr	1132(ra) # 80000c7a <panic>
  if(ip->type == T_DIR){
    80008816:	fe043783          	ld	a5,-32(s0)
    8000881a:	04479783          	lh	a5,68(a5)
    8000881e:	0007871b          	sext.w	a4,a5
    80008822:	4785                	li	a5,1
    80008824:	02f71963          	bne	a4,a5,80008856 <sys_unlink+0x1a0>
    dp->nlink--;
    80008828:	fe843783          	ld	a5,-24(s0)
    8000882c:	04a79783          	lh	a5,74(a5)
    80008830:	17c2                	slli	a5,a5,0x30
    80008832:	93c1                	srli	a5,a5,0x30
    80008834:	37fd                	addiw	a5,a5,-1
    80008836:	17c2                	slli	a5,a5,0x30
    80008838:	93c1                	srli	a5,a5,0x30
    8000883a:	0107971b          	slliw	a4,a5,0x10
    8000883e:	4107571b          	sraiw	a4,a4,0x10
    80008842:	fe843783          	ld	a5,-24(s0)
    80008846:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    8000884a:	fe843503          	ld	a0,-24(s0)
    8000884e:	ffffd097          	auipc	ra,0xffffd
    80008852:	0a6080e7          	jalr	166(ra) # 800058f4 <iupdate>
  }
  iunlockput(dp);
    80008856:	fe843503          	ld	a0,-24(s0)
    8000885a:	ffffd097          	auipc	ra,0xffffd
    8000885e:	548080e7          	jalr	1352(ra) # 80005da2 <iunlockput>

  ip->nlink--;
    80008862:	fe043783          	ld	a5,-32(s0)
    80008866:	04a79783          	lh	a5,74(a5)
    8000886a:	17c2                	slli	a5,a5,0x30
    8000886c:	93c1                	srli	a5,a5,0x30
    8000886e:	37fd                	addiw	a5,a5,-1
    80008870:	17c2                	slli	a5,a5,0x30
    80008872:	93c1                	srli	a5,a5,0x30
    80008874:	0107971b          	slliw	a4,a5,0x10
    80008878:	4107571b          	sraiw	a4,a4,0x10
    8000887c:	fe043783          	ld	a5,-32(s0)
    80008880:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80008884:	fe043503          	ld	a0,-32(s0)
    80008888:	ffffd097          	auipc	ra,0xffffd
    8000888c:	06c080e7          	jalr	108(ra) # 800058f4 <iupdate>
  iunlockput(ip);
    80008890:	fe043503          	ld	a0,-32(s0)
    80008894:	ffffd097          	auipc	ra,0xffffd
    80008898:	50e080e7          	jalr	1294(ra) # 80005da2 <iunlockput>

  end_op();
    8000889c:	ffffe097          	auipc	ra,0xffffe
    800088a0:	3d2080e7          	jalr	978(ra) # 80006c6e <end_op>

  return 0;
    800088a4:	4781                	li	a5,0
    800088a6:	a839                	j	800088c4 <sys_unlink+0x20e>
    goto bad;
    800088a8:	0001                	nop
    800088aa:	a011                	j	800088ae <sys_unlink+0x1f8>
    goto bad;
    800088ac:	0001                	nop

bad:
  iunlockput(dp);
    800088ae:	fe843503          	ld	a0,-24(s0)
    800088b2:	ffffd097          	auipc	ra,0xffffd
    800088b6:	4f0080e7          	jalr	1264(ra) # 80005da2 <iunlockput>
  end_op();
    800088ba:	ffffe097          	auipc	ra,0xffffe
    800088be:	3b4080e7          	jalr	948(ra) # 80006c6e <end_op>
  return -1;
    800088c2:	57fd                	li	a5,-1
}
    800088c4:	853e                	mv	a0,a5
    800088c6:	60ae                	ld	ra,200(sp)
    800088c8:	640e                	ld	s0,192(sp)
    800088ca:	6169                	addi	sp,sp,208
    800088cc:	8082                	ret

00000000800088ce <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
    800088ce:	7139                	addi	sp,sp,-64
    800088d0:	fc06                	sd	ra,56(sp)
    800088d2:	f822                	sd	s0,48(sp)
    800088d4:	0080                	addi	s0,sp,64
    800088d6:	fca43423          	sd	a0,-56(s0)
    800088da:	87ae                	mv	a5,a1
    800088dc:	8736                	mv	a4,a3
    800088de:	fcf41323          	sh	a5,-58(s0)
    800088e2:	87b2                	mv	a5,a2
    800088e4:	fcf41223          	sh	a5,-60(s0)
    800088e8:	87ba                	mv	a5,a4
    800088ea:	fcf41123          	sh	a5,-62(s0)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800088ee:	fd040793          	addi	a5,s0,-48
    800088f2:	85be                	mv	a1,a5
    800088f4:	fc843503          	ld	a0,-56(s0)
    800088f8:	ffffe097          	auipc	ra,0xffffe
    800088fc:	f7c080e7          	jalr	-132(ra) # 80006874 <nameiparent>
    80008900:	fea43423          	sd	a0,-24(s0)
    80008904:	fe843783          	ld	a5,-24(s0)
    80008908:	e399                	bnez	a5,8000890e <create+0x40>
    return 0;
    8000890a:	4781                	li	a5,0
    8000890c:	a2d9                	j	80008ad2 <create+0x204>

  ilock(dp);
    8000890e:	fe843503          	ld	a0,-24(s0)
    80008912:	ffffd097          	auipc	ra,0xffffd
    80008916:	232080e7          	jalr	562(ra) # 80005b44 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    8000891a:	fd040793          	addi	a5,s0,-48
    8000891e:	4601                	li	a2,0
    80008920:	85be                	mv	a1,a5
    80008922:	fe843503          	ld	a0,-24(s0)
    80008926:	ffffe097          	auipc	ra,0xffffe
    8000892a:	b20080e7          	jalr	-1248(ra) # 80006446 <dirlookup>
    8000892e:	fea43023          	sd	a0,-32(s0)
    80008932:	fe043783          	ld	a5,-32(s0)
    80008936:	c3ad                	beqz	a5,80008998 <create+0xca>
    iunlockput(dp);
    80008938:	fe843503          	ld	a0,-24(s0)
    8000893c:	ffffd097          	auipc	ra,0xffffd
    80008940:	466080e7          	jalr	1126(ra) # 80005da2 <iunlockput>
    ilock(ip);
    80008944:	fe043503          	ld	a0,-32(s0)
    80008948:	ffffd097          	auipc	ra,0xffffd
    8000894c:	1fc080e7          	jalr	508(ra) # 80005b44 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80008950:	fc641783          	lh	a5,-58(s0)
    80008954:	0007871b          	sext.w	a4,a5
    80008958:	4789                	li	a5,2
    8000895a:	02f71763          	bne	a4,a5,80008988 <create+0xba>
    8000895e:	fe043783          	ld	a5,-32(s0)
    80008962:	04479783          	lh	a5,68(a5)
    80008966:	0007871b          	sext.w	a4,a5
    8000896a:	4789                	li	a5,2
    8000896c:	00f70b63          	beq	a4,a5,80008982 <create+0xb4>
    80008970:	fe043783          	ld	a5,-32(s0)
    80008974:	04479783          	lh	a5,68(a5)
    80008978:	0007871b          	sext.w	a4,a5
    8000897c:	478d                	li	a5,3
    8000897e:	00f71563          	bne	a4,a5,80008988 <create+0xba>
      return ip;
    80008982:	fe043783          	ld	a5,-32(s0)
    80008986:	a2b1                	j	80008ad2 <create+0x204>
    iunlockput(ip);
    80008988:	fe043503          	ld	a0,-32(s0)
    8000898c:	ffffd097          	auipc	ra,0xffffd
    80008990:	416080e7          	jalr	1046(ra) # 80005da2 <iunlockput>
    return 0;
    80008994:	4781                	li	a5,0
    80008996:	aa35                	j	80008ad2 <create+0x204>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    80008998:	fe843783          	ld	a5,-24(s0)
    8000899c:	439c                	lw	a5,0(a5)
    8000899e:	fc641703          	lh	a4,-58(s0)
    800089a2:	85ba                	mv	a1,a4
    800089a4:	853e                	mv	a0,a5
    800089a6:	ffffd097          	auipc	ra,0xffffd
    800089aa:	e52080e7          	jalr	-430(ra) # 800057f8 <ialloc>
    800089ae:	fea43023          	sd	a0,-32(s0)
    800089b2:	fe043783          	ld	a5,-32(s0)
    800089b6:	eb89                	bnez	a5,800089c8 <create+0xfa>
    panic("create: ialloc");
    800089b8:	00003517          	auipc	a0,0x3
    800089bc:	e3850513          	addi	a0,a0,-456 # 8000b7f0 <etext+0x7f0>
    800089c0:	ffff8097          	auipc	ra,0xffff8
    800089c4:	2ba080e7          	jalr	698(ra) # 80000c7a <panic>

  ilock(ip);
    800089c8:	fe043503          	ld	a0,-32(s0)
    800089cc:	ffffd097          	auipc	ra,0xffffd
    800089d0:	178080e7          	jalr	376(ra) # 80005b44 <ilock>
  ip->major = major;
    800089d4:	fe043783          	ld	a5,-32(s0)
    800089d8:	fc445703          	lhu	a4,-60(s0)
    800089dc:	04e79323          	sh	a4,70(a5)
  ip->minor = minor;
    800089e0:	fe043783          	ld	a5,-32(s0)
    800089e4:	fc245703          	lhu	a4,-62(s0)
    800089e8:	04e79423          	sh	a4,72(a5)
  ip->nlink = 1;
    800089ec:	fe043783          	ld	a5,-32(s0)
    800089f0:	4705                	li	a4,1
    800089f2:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    800089f6:	fe043503          	ld	a0,-32(s0)
    800089fa:	ffffd097          	auipc	ra,0xffffd
    800089fe:	efa080e7          	jalr	-262(ra) # 800058f4 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
    80008a02:	fc641783          	lh	a5,-58(s0)
    80008a06:	0007871b          	sext.w	a4,a5
    80008a0a:	4785                	li	a5,1
    80008a0c:	08f71363          	bne	a4,a5,80008a92 <create+0x1c4>
    dp->nlink++;  // for ".."
    80008a10:	fe843783          	ld	a5,-24(s0)
    80008a14:	04a79783          	lh	a5,74(a5)
    80008a18:	17c2                	slli	a5,a5,0x30
    80008a1a:	93c1                	srli	a5,a5,0x30
    80008a1c:	2785                	addiw	a5,a5,1
    80008a1e:	17c2                	slli	a5,a5,0x30
    80008a20:	93c1                	srli	a5,a5,0x30
    80008a22:	0107971b          	slliw	a4,a5,0x10
    80008a26:	4107571b          	sraiw	a4,a4,0x10
    80008a2a:	fe843783          	ld	a5,-24(s0)
    80008a2e:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80008a32:	fe843503          	ld	a0,-24(s0)
    80008a36:	ffffd097          	auipc	ra,0xffffd
    80008a3a:	ebe080e7          	jalr	-322(ra) # 800058f4 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80008a3e:	fe043783          	ld	a5,-32(s0)
    80008a42:	43dc                	lw	a5,4(a5)
    80008a44:	863e                	mv	a2,a5
    80008a46:	00003597          	auipc	a1,0x3
    80008a4a:	d7258593          	addi	a1,a1,-654 # 8000b7b8 <etext+0x7b8>
    80008a4e:	fe043503          	ld	a0,-32(s0)
    80008a52:	ffffe097          	auipc	ra,0xffffe
    80008a56:	adc080e7          	jalr	-1316(ra) # 8000652e <dirlink>
    80008a5a:	87aa                	mv	a5,a0
    80008a5c:	0207c363          	bltz	a5,80008a82 <create+0x1b4>
    80008a60:	fe843783          	ld	a5,-24(s0)
    80008a64:	43dc                	lw	a5,4(a5)
    80008a66:	863e                	mv	a2,a5
    80008a68:	00003597          	auipc	a1,0x3
    80008a6c:	d5858593          	addi	a1,a1,-680 # 8000b7c0 <etext+0x7c0>
    80008a70:	fe043503          	ld	a0,-32(s0)
    80008a74:	ffffe097          	auipc	ra,0xffffe
    80008a78:	aba080e7          	jalr	-1350(ra) # 8000652e <dirlink>
    80008a7c:	87aa                	mv	a5,a0
    80008a7e:	0007da63          	bgez	a5,80008a92 <create+0x1c4>
      panic("create dots");
    80008a82:	00003517          	auipc	a0,0x3
    80008a86:	d7e50513          	addi	a0,a0,-642 # 8000b800 <etext+0x800>
    80008a8a:	ffff8097          	auipc	ra,0xffff8
    80008a8e:	1f0080e7          	jalr	496(ra) # 80000c7a <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    80008a92:	fe043783          	ld	a5,-32(s0)
    80008a96:	43d8                	lw	a4,4(a5)
    80008a98:	fd040793          	addi	a5,s0,-48
    80008a9c:	863a                	mv	a2,a4
    80008a9e:	85be                	mv	a1,a5
    80008aa0:	fe843503          	ld	a0,-24(s0)
    80008aa4:	ffffe097          	auipc	ra,0xffffe
    80008aa8:	a8a080e7          	jalr	-1398(ra) # 8000652e <dirlink>
    80008aac:	87aa                	mv	a5,a0
    80008aae:	0007da63          	bgez	a5,80008ac2 <create+0x1f4>
    panic("create: dirlink");
    80008ab2:	00003517          	auipc	a0,0x3
    80008ab6:	d5e50513          	addi	a0,a0,-674 # 8000b810 <etext+0x810>
    80008aba:	ffff8097          	auipc	ra,0xffff8
    80008abe:	1c0080e7          	jalr	448(ra) # 80000c7a <panic>

  iunlockput(dp);
    80008ac2:	fe843503          	ld	a0,-24(s0)
    80008ac6:	ffffd097          	auipc	ra,0xffffd
    80008aca:	2dc080e7          	jalr	732(ra) # 80005da2 <iunlockput>

  return ip;
    80008ace:	fe043783          	ld	a5,-32(s0)
}
    80008ad2:	853e                	mv	a0,a5
    80008ad4:	70e2                	ld	ra,56(sp)
    80008ad6:	7442                	ld	s0,48(sp)
    80008ad8:	6121                	addi	sp,sp,64
    80008ada:	8082                	ret

0000000080008adc <sys_open>:

uint64
sys_open(void)
{
    80008adc:	7131                	addi	sp,sp,-192
    80008ade:	fd06                	sd	ra,184(sp)
    80008ae0:	f922                	sd	s0,176(sp)
    80008ae2:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80008ae4:	f5040793          	addi	a5,s0,-176
    80008ae8:	08000613          	li	a2,128
    80008aec:	85be                	mv	a1,a5
    80008aee:	4501                	li	a0,0
    80008af0:	ffffc097          	auipc	ra,0xffffc
    80008af4:	f94080e7          	jalr	-108(ra) # 80004a84 <argstr>
    80008af8:	87aa                	mv	a5,a0
    80008afa:	fef42223          	sw	a5,-28(s0)
    80008afe:	fe442783          	lw	a5,-28(s0)
    80008b02:	2781                	sext.w	a5,a5
    80008b04:	0007cd63          	bltz	a5,80008b1e <sys_open+0x42>
    80008b08:	f4c40793          	addi	a5,s0,-180
    80008b0c:	85be                	mv	a1,a5
    80008b0e:	4505                	li	a0,1
    80008b10:	ffffc097          	auipc	ra,0xffffc
    80008b14:	f08080e7          	jalr	-248(ra) # 80004a18 <argint>
    80008b18:	87aa                	mv	a5,a0
    80008b1a:	0007d463          	bgez	a5,80008b22 <sys_open+0x46>
    return -1;
    80008b1e:	57fd                	li	a5,-1
    80008b20:	a429                	j	80008d2a <sys_open+0x24e>

  begin_op();
    80008b22:	ffffe097          	auipc	ra,0xffffe
    80008b26:	08a080e7          	jalr	138(ra) # 80006bac <begin_op>

  if(omode & O_CREATE){
    80008b2a:	f4c42783          	lw	a5,-180(s0)
    80008b2e:	2007f793          	andi	a5,a5,512
    80008b32:	2781                	sext.w	a5,a5
    80008b34:	c795                	beqz	a5,80008b60 <sys_open+0x84>
    ip = create(path, T_FILE, 0, 0);
    80008b36:	f5040793          	addi	a5,s0,-176
    80008b3a:	4681                	li	a3,0
    80008b3c:	4601                	li	a2,0
    80008b3e:	4589                	li	a1,2
    80008b40:	853e                	mv	a0,a5
    80008b42:	00000097          	auipc	ra,0x0
    80008b46:	d8c080e7          	jalr	-628(ra) # 800088ce <create>
    80008b4a:	fea43423          	sd	a0,-24(s0)
    if(ip == 0){
    80008b4e:	fe843783          	ld	a5,-24(s0)
    80008b52:	e7bd                	bnez	a5,80008bc0 <sys_open+0xe4>
      end_op();
    80008b54:	ffffe097          	auipc	ra,0xffffe
    80008b58:	11a080e7          	jalr	282(ra) # 80006c6e <end_op>
      return -1;
    80008b5c:	57fd                	li	a5,-1
    80008b5e:	a2f1                	j	80008d2a <sys_open+0x24e>
    }
  } else {
    if((ip = namei(path)) == 0){
    80008b60:	f5040793          	addi	a5,s0,-176
    80008b64:	853e                	mv	a0,a5
    80008b66:	ffffe097          	auipc	ra,0xffffe
    80008b6a:	ce2080e7          	jalr	-798(ra) # 80006848 <namei>
    80008b6e:	fea43423          	sd	a0,-24(s0)
    80008b72:	fe843783          	ld	a5,-24(s0)
    80008b76:	e799                	bnez	a5,80008b84 <sys_open+0xa8>
      end_op();
    80008b78:	ffffe097          	auipc	ra,0xffffe
    80008b7c:	0f6080e7          	jalr	246(ra) # 80006c6e <end_op>
      return -1;
    80008b80:	57fd                	li	a5,-1
    80008b82:	a265                	j	80008d2a <sys_open+0x24e>
    }
    ilock(ip);
    80008b84:	fe843503          	ld	a0,-24(s0)
    80008b88:	ffffd097          	auipc	ra,0xffffd
    80008b8c:	fbc080e7          	jalr	-68(ra) # 80005b44 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80008b90:	fe843783          	ld	a5,-24(s0)
    80008b94:	04479783          	lh	a5,68(a5)
    80008b98:	0007871b          	sext.w	a4,a5
    80008b9c:	4785                	li	a5,1
    80008b9e:	02f71163          	bne	a4,a5,80008bc0 <sys_open+0xe4>
    80008ba2:	f4c42783          	lw	a5,-180(s0)
    80008ba6:	cf89                	beqz	a5,80008bc0 <sys_open+0xe4>
      iunlockput(ip);
    80008ba8:	fe843503          	ld	a0,-24(s0)
    80008bac:	ffffd097          	auipc	ra,0xffffd
    80008bb0:	1f6080e7          	jalr	502(ra) # 80005da2 <iunlockput>
      end_op();
    80008bb4:	ffffe097          	auipc	ra,0xffffe
    80008bb8:	0ba080e7          	jalr	186(ra) # 80006c6e <end_op>
      return -1;
    80008bbc:	57fd                	li	a5,-1
    80008bbe:	a2b5                	j	80008d2a <sys_open+0x24e>
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80008bc0:	fe843783          	ld	a5,-24(s0)
    80008bc4:	04479783          	lh	a5,68(a5)
    80008bc8:	0007871b          	sext.w	a4,a5
    80008bcc:	478d                	li	a5,3
    80008bce:	02f71e63          	bne	a4,a5,80008c0a <sys_open+0x12e>
    80008bd2:	fe843783          	ld	a5,-24(s0)
    80008bd6:	04679783          	lh	a5,70(a5)
    80008bda:	2781                	sext.w	a5,a5
    80008bdc:	0007cb63          	bltz	a5,80008bf2 <sys_open+0x116>
    80008be0:	fe843783          	ld	a5,-24(s0)
    80008be4:	04679783          	lh	a5,70(a5)
    80008be8:	0007871b          	sext.w	a4,a5
    80008bec:	47a5                	li	a5,9
    80008bee:	00e7de63          	bge	a5,a4,80008c0a <sys_open+0x12e>
    iunlockput(ip);
    80008bf2:	fe843503          	ld	a0,-24(s0)
    80008bf6:	ffffd097          	auipc	ra,0xffffd
    80008bfa:	1ac080e7          	jalr	428(ra) # 80005da2 <iunlockput>
    end_op();
    80008bfe:	ffffe097          	auipc	ra,0xffffe
    80008c02:	070080e7          	jalr	112(ra) # 80006c6e <end_op>
    return -1;
    80008c06:	57fd                	li	a5,-1
    80008c08:	a20d                	j	80008d2a <sys_open+0x24e>
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80008c0a:	ffffe097          	auipc	ra,0xffffe
    80008c0e:	552080e7          	jalr	1362(ra) # 8000715c <filealloc>
    80008c12:	fca43c23          	sd	a0,-40(s0)
    80008c16:	fd843783          	ld	a5,-40(s0)
    80008c1a:	cf99                	beqz	a5,80008c38 <sys_open+0x15c>
    80008c1c:	fd843503          	ld	a0,-40(s0)
    80008c20:	fffff097          	auipc	ra,0xfffff
    80008c24:	5e8080e7          	jalr	1512(ra) # 80008208 <fdalloc>
    80008c28:	87aa                	mv	a5,a0
    80008c2a:	fcf42a23          	sw	a5,-44(s0)
    80008c2e:	fd442783          	lw	a5,-44(s0)
    80008c32:	2781                	sext.w	a5,a5
    80008c34:	0207d763          	bgez	a5,80008c62 <sys_open+0x186>
    if(f)
    80008c38:	fd843783          	ld	a5,-40(s0)
    80008c3c:	c799                	beqz	a5,80008c4a <sys_open+0x16e>
      fileclose(f);
    80008c3e:	fd843503          	ld	a0,-40(s0)
    80008c42:	ffffe097          	auipc	ra,0xffffe
    80008c46:	604080e7          	jalr	1540(ra) # 80007246 <fileclose>
    iunlockput(ip);
    80008c4a:	fe843503          	ld	a0,-24(s0)
    80008c4e:	ffffd097          	auipc	ra,0xffffd
    80008c52:	154080e7          	jalr	340(ra) # 80005da2 <iunlockput>
    end_op();
    80008c56:	ffffe097          	auipc	ra,0xffffe
    80008c5a:	018080e7          	jalr	24(ra) # 80006c6e <end_op>
    return -1;
    80008c5e:	57fd                	li	a5,-1
    80008c60:	a0e9                	j	80008d2a <sys_open+0x24e>
  }

  if(ip->type == T_DEVICE){
    80008c62:	fe843783          	ld	a5,-24(s0)
    80008c66:	04479783          	lh	a5,68(a5)
    80008c6a:	0007871b          	sext.w	a4,a5
    80008c6e:	478d                	li	a5,3
    80008c70:	00f71f63          	bne	a4,a5,80008c8e <sys_open+0x1b2>
    f->type = FD_DEVICE;
    80008c74:	fd843783          	ld	a5,-40(s0)
    80008c78:	470d                	li	a4,3
    80008c7a:	c398                	sw	a4,0(a5)
    f->major = ip->major;
    80008c7c:	fe843783          	ld	a5,-24(s0)
    80008c80:	04679703          	lh	a4,70(a5)
    80008c84:	fd843783          	ld	a5,-40(s0)
    80008c88:	02e79223          	sh	a4,36(a5)
    80008c8c:	a809                	j	80008c9e <sys_open+0x1c2>
  } else {
    f->type = FD_INODE;
    80008c8e:	fd843783          	ld	a5,-40(s0)
    80008c92:	4709                	li	a4,2
    80008c94:	c398                	sw	a4,0(a5)
    f->off = 0;
    80008c96:	fd843783          	ld	a5,-40(s0)
    80008c9a:	0207a023          	sw	zero,32(a5)
  }
  f->ip = ip;
    80008c9e:	fd843783          	ld	a5,-40(s0)
    80008ca2:	fe843703          	ld	a4,-24(s0)
    80008ca6:	ef98                	sd	a4,24(a5)
  f->readable = !(omode & O_WRONLY);
    80008ca8:	f4c42783          	lw	a5,-180(s0)
    80008cac:	8b85                	andi	a5,a5,1
    80008cae:	2781                	sext.w	a5,a5
    80008cb0:	0017b793          	seqz	a5,a5
    80008cb4:	0ff7f793          	zext.b	a5,a5
    80008cb8:	873e                	mv	a4,a5
    80008cba:	fd843783          	ld	a5,-40(s0)
    80008cbe:	00e78423          	sb	a4,8(a5)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80008cc2:	f4c42783          	lw	a5,-180(s0)
    80008cc6:	8b85                	andi	a5,a5,1
    80008cc8:	2781                	sext.w	a5,a5
    80008cca:	e791                	bnez	a5,80008cd6 <sys_open+0x1fa>
    80008ccc:	f4c42783          	lw	a5,-180(s0)
    80008cd0:	8b89                	andi	a5,a5,2
    80008cd2:	2781                	sext.w	a5,a5
    80008cd4:	c399                	beqz	a5,80008cda <sys_open+0x1fe>
    80008cd6:	4785                	li	a5,1
    80008cd8:	a011                	j	80008cdc <sys_open+0x200>
    80008cda:	4781                	li	a5,0
    80008cdc:	0ff7f713          	zext.b	a4,a5
    80008ce0:	fd843783          	ld	a5,-40(s0)
    80008ce4:	00e784a3          	sb	a4,9(a5)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80008ce8:	f4c42783          	lw	a5,-180(s0)
    80008cec:	4007f793          	andi	a5,a5,1024
    80008cf0:	2781                	sext.w	a5,a5
    80008cf2:	c385                	beqz	a5,80008d12 <sys_open+0x236>
    80008cf4:	fe843783          	ld	a5,-24(s0)
    80008cf8:	04479783          	lh	a5,68(a5)
    80008cfc:	0007871b          	sext.w	a4,a5
    80008d00:	4789                	li	a5,2
    80008d02:	00f71863          	bne	a4,a5,80008d12 <sys_open+0x236>
    itrunc(ip);
    80008d06:	fe843503          	ld	a0,-24(s0)
    80008d0a:	ffffd097          	auipc	ra,0xffffd
    80008d0e:	222080e7          	jalr	546(ra) # 80005f2c <itrunc>
  }

  iunlock(ip);
    80008d12:	fe843503          	ld	a0,-24(s0)
    80008d16:	ffffd097          	auipc	ra,0xffffd
    80008d1a:	f62080e7          	jalr	-158(ra) # 80005c78 <iunlock>
  end_op();
    80008d1e:	ffffe097          	auipc	ra,0xffffe
    80008d22:	f50080e7          	jalr	-176(ra) # 80006c6e <end_op>

  return fd;
    80008d26:	fd442783          	lw	a5,-44(s0)
}
    80008d2a:	853e                	mv	a0,a5
    80008d2c:	70ea                	ld	ra,184(sp)
    80008d2e:	744a                	ld	s0,176(sp)
    80008d30:	6129                	addi	sp,sp,192
    80008d32:	8082                	ret

0000000080008d34 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80008d34:	7135                	addi	sp,sp,-160
    80008d36:	ed06                	sd	ra,152(sp)
    80008d38:	e922                	sd	s0,144(sp)
    80008d3a:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80008d3c:	ffffe097          	auipc	ra,0xffffe
    80008d40:	e70080e7          	jalr	-400(ra) # 80006bac <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80008d44:	f6840793          	addi	a5,s0,-152
    80008d48:	08000613          	li	a2,128
    80008d4c:	85be                	mv	a1,a5
    80008d4e:	4501                	li	a0,0
    80008d50:	ffffc097          	auipc	ra,0xffffc
    80008d54:	d34080e7          	jalr	-716(ra) # 80004a84 <argstr>
    80008d58:	87aa                	mv	a5,a0
    80008d5a:	0207c163          	bltz	a5,80008d7c <sys_mkdir+0x48>
    80008d5e:	f6840793          	addi	a5,s0,-152
    80008d62:	4681                	li	a3,0
    80008d64:	4601                	li	a2,0
    80008d66:	4585                	li	a1,1
    80008d68:	853e                	mv	a0,a5
    80008d6a:	00000097          	auipc	ra,0x0
    80008d6e:	b64080e7          	jalr	-1180(ra) # 800088ce <create>
    80008d72:	fea43423          	sd	a0,-24(s0)
    80008d76:	fe843783          	ld	a5,-24(s0)
    80008d7a:	e799                	bnez	a5,80008d88 <sys_mkdir+0x54>
    end_op();
    80008d7c:	ffffe097          	auipc	ra,0xffffe
    80008d80:	ef2080e7          	jalr	-270(ra) # 80006c6e <end_op>
    return -1;
    80008d84:	57fd                	li	a5,-1
    80008d86:	a821                	j	80008d9e <sys_mkdir+0x6a>
  }
  iunlockput(ip);
    80008d88:	fe843503          	ld	a0,-24(s0)
    80008d8c:	ffffd097          	auipc	ra,0xffffd
    80008d90:	016080e7          	jalr	22(ra) # 80005da2 <iunlockput>
  end_op();
    80008d94:	ffffe097          	auipc	ra,0xffffe
    80008d98:	eda080e7          	jalr	-294(ra) # 80006c6e <end_op>
  return 0;
    80008d9c:	4781                	li	a5,0
}
    80008d9e:	853e                	mv	a0,a5
    80008da0:	60ea                	ld	ra,152(sp)
    80008da2:	644a                	ld	s0,144(sp)
    80008da4:	610d                	addi	sp,sp,160
    80008da6:	8082                	ret

0000000080008da8 <sys_mknod>:

uint64
sys_mknod(void)
{
    80008da8:	7135                	addi	sp,sp,-160
    80008daa:	ed06                	sd	ra,152(sp)
    80008dac:	e922                	sd	s0,144(sp)
    80008dae:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80008db0:	ffffe097          	auipc	ra,0xffffe
    80008db4:	dfc080e7          	jalr	-516(ra) # 80006bac <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80008db8:	f6840793          	addi	a5,s0,-152
    80008dbc:	08000613          	li	a2,128
    80008dc0:	85be                	mv	a1,a5
    80008dc2:	4501                	li	a0,0
    80008dc4:	ffffc097          	auipc	ra,0xffffc
    80008dc8:	cc0080e7          	jalr	-832(ra) # 80004a84 <argstr>
    80008dcc:	87aa                	mv	a5,a0
    80008dce:	0607c263          	bltz	a5,80008e32 <sys_mknod+0x8a>
     argint(1, &major) < 0 ||
    80008dd2:	f6440793          	addi	a5,s0,-156
    80008dd6:	85be                	mv	a1,a5
    80008dd8:	4505                	li	a0,1
    80008dda:	ffffc097          	auipc	ra,0xffffc
    80008dde:	c3e080e7          	jalr	-962(ra) # 80004a18 <argint>
    80008de2:	87aa                	mv	a5,a0
  if((argstr(0, path, MAXPATH)) < 0 ||
    80008de4:	0407c763          	bltz	a5,80008e32 <sys_mknod+0x8a>
     argint(2, &minor) < 0 ||
    80008de8:	f6040793          	addi	a5,s0,-160
    80008dec:	85be                	mv	a1,a5
    80008dee:	4509                	li	a0,2
    80008df0:	ffffc097          	auipc	ra,0xffffc
    80008df4:	c28080e7          	jalr	-984(ra) # 80004a18 <argint>
    80008df8:	87aa                	mv	a5,a0
     argint(1, &major) < 0 ||
    80008dfa:	0207cc63          	bltz	a5,80008e32 <sys_mknod+0x8a>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80008dfe:	f6442783          	lw	a5,-156(s0)
    80008e02:	0107971b          	slliw	a4,a5,0x10
    80008e06:	4107571b          	sraiw	a4,a4,0x10
    80008e0a:	f6042783          	lw	a5,-160(s0)
    80008e0e:	0107969b          	slliw	a3,a5,0x10
    80008e12:	4106d69b          	sraiw	a3,a3,0x10
    80008e16:	f6840793          	addi	a5,s0,-152
    80008e1a:	863a                	mv	a2,a4
    80008e1c:	458d                	li	a1,3
    80008e1e:	853e                	mv	a0,a5
    80008e20:	00000097          	auipc	ra,0x0
    80008e24:	aae080e7          	jalr	-1362(ra) # 800088ce <create>
    80008e28:	fea43423          	sd	a0,-24(s0)
     argint(2, &minor) < 0 ||
    80008e2c:	fe843783          	ld	a5,-24(s0)
    80008e30:	e799                	bnez	a5,80008e3e <sys_mknod+0x96>
    end_op();
    80008e32:	ffffe097          	auipc	ra,0xffffe
    80008e36:	e3c080e7          	jalr	-452(ra) # 80006c6e <end_op>
    return -1;
    80008e3a:	57fd                	li	a5,-1
    80008e3c:	a821                	j	80008e54 <sys_mknod+0xac>
  }
  iunlockput(ip);
    80008e3e:	fe843503          	ld	a0,-24(s0)
    80008e42:	ffffd097          	auipc	ra,0xffffd
    80008e46:	f60080e7          	jalr	-160(ra) # 80005da2 <iunlockput>
  end_op();
    80008e4a:	ffffe097          	auipc	ra,0xffffe
    80008e4e:	e24080e7          	jalr	-476(ra) # 80006c6e <end_op>
  return 0;
    80008e52:	4781                	li	a5,0
}
    80008e54:	853e                	mv	a0,a5
    80008e56:	60ea                	ld	ra,152(sp)
    80008e58:	644a                	ld	s0,144(sp)
    80008e5a:	610d                	addi	sp,sp,160
    80008e5c:	8082                	ret

0000000080008e5e <sys_chdir>:

uint64
sys_chdir(void)
{
    80008e5e:	7135                	addi	sp,sp,-160
    80008e60:	ed06                	sd	ra,152(sp)
    80008e62:	e922                	sd	s0,144(sp)
    80008e64:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80008e66:	ffffa097          	auipc	ra,0xffffa
    80008e6a:	bb2080e7          	jalr	-1102(ra) # 80002a18 <myproc>
    80008e6e:	fea43423          	sd	a0,-24(s0)
  
  begin_op();
    80008e72:	ffffe097          	auipc	ra,0xffffe
    80008e76:	d3a080e7          	jalr	-710(ra) # 80006bac <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80008e7a:	f6040793          	addi	a5,s0,-160
    80008e7e:	08000613          	li	a2,128
    80008e82:	85be                	mv	a1,a5
    80008e84:	4501                	li	a0,0
    80008e86:	ffffc097          	auipc	ra,0xffffc
    80008e8a:	bfe080e7          	jalr	-1026(ra) # 80004a84 <argstr>
    80008e8e:	87aa                	mv	a5,a0
    80008e90:	0007ce63          	bltz	a5,80008eac <sys_chdir+0x4e>
    80008e94:	f6040793          	addi	a5,s0,-160
    80008e98:	853e                	mv	a0,a5
    80008e9a:	ffffe097          	auipc	ra,0xffffe
    80008e9e:	9ae080e7          	jalr	-1618(ra) # 80006848 <namei>
    80008ea2:	fea43023          	sd	a0,-32(s0)
    80008ea6:	fe043783          	ld	a5,-32(s0)
    80008eaa:	e799                	bnez	a5,80008eb8 <sys_chdir+0x5a>
    end_op();
    80008eac:	ffffe097          	auipc	ra,0xffffe
    80008eb0:	dc2080e7          	jalr	-574(ra) # 80006c6e <end_op>
    return -1;
    80008eb4:	57fd                	li	a5,-1
    80008eb6:	a0b5                	j	80008f22 <sys_chdir+0xc4>
  }
  ilock(ip);
    80008eb8:	fe043503          	ld	a0,-32(s0)
    80008ebc:	ffffd097          	auipc	ra,0xffffd
    80008ec0:	c88080e7          	jalr	-888(ra) # 80005b44 <ilock>
  if(ip->type != T_DIR){
    80008ec4:	fe043783          	ld	a5,-32(s0)
    80008ec8:	04479783          	lh	a5,68(a5)
    80008ecc:	0007871b          	sext.w	a4,a5
    80008ed0:	4785                	li	a5,1
    80008ed2:	00f70e63          	beq	a4,a5,80008eee <sys_chdir+0x90>
    iunlockput(ip);
    80008ed6:	fe043503          	ld	a0,-32(s0)
    80008eda:	ffffd097          	auipc	ra,0xffffd
    80008ede:	ec8080e7          	jalr	-312(ra) # 80005da2 <iunlockput>
    end_op();
    80008ee2:	ffffe097          	auipc	ra,0xffffe
    80008ee6:	d8c080e7          	jalr	-628(ra) # 80006c6e <end_op>
    return -1;
    80008eea:	57fd                	li	a5,-1
    80008eec:	a81d                	j	80008f22 <sys_chdir+0xc4>
  }
  iunlock(ip);
    80008eee:	fe043503          	ld	a0,-32(s0)
    80008ef2:	ffffd097          	auipc	ra,0xffffd
    80008ef6:	d86080e7          	jalr	-634(ra) # 80005c78 <iunlock>
  iput(p->cwd);
    80008efa:	fe843783          	ld	a5,-24(s0)
    80008efe:	1607b783          	ld	a5,352(a5)
    80008f02:	853e                	mv	a0,a5
    80008f04:	ffffd097          	auipc	ra,0xffffd
    80008f08:	dce080e7          	jalr	-562(ra) # 80005cd2 <iput>
  end_op();
    80008f0c:	ffffe097          	auipc	ra,0xffffe
    80008f10:	d62080e7          	jalr	-670(ra) # 80006c6e <end_op>
  p->cwd = ip;
    80008f14:	fe843783          	ld	a5,-24(s0)
    80008f18:	fe043703          	ld	a4,-32(s0)
    80008f1c:	16e7b023          	sd	a4,352(a5)
  return 0;
    80008f20:	4781                	li	a5,0
}
    80008f22:	853e                	mv	a0,a5
    80008f24:	60ea                	ld	ra,152(sp)
    80008f26:	644a                	ld	s0,144(sp)
    80008f28:	610d                	addi	sp,sp,160
    80008f2a:	8082                	ret

0000000080008f2c <sys_exec>:

uint64
sys_exec(void)
{
    80008f2c:	7161                	addi	sp,sp,-432
    80008f2e:	f706                	sd	ra,424(sp)
    80008f30:	f322                	sd	s0,416(sp)
    80008f32:	1b00                	addi	s0,sp,432
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80008f34:	f6840793          	addi	a5,s0,-152
    80008f38:	08000613          	li	a2,128
    80008f3c:	85be                	mv	a1,a5
    80008f3e:	4501                	li	a0,0
    80008f40:	ffffc097          	auipc	ra,0xffffc
    80008f44:	b44080e7          	jalr	-1212(ra) # 80004a84 <argstr>
    80008f48:	87aa                	mv	a5,a0
    80008f4a:	0007cd63          	bltz	a5,80008f64 <sys_exec+0x38>
    80008f4e:	e6040793          	addi	a5,s0,-416
    80008f52:	85be                	mv	a1,a5
    80008f54:	4505                	li	a0,1
    80008f56:	ffffc097          	auipc	ra,0xffffc
    80008f5a:	afa080e7          	jalr	-1286(ra) # 80004a50 <argaddr>
    80008f5e:	87aa                	mv	a5,a0
    80008f60:	0007d463          	bgez	a5,80008f68 <sys_exec+0x3c>
    return -1;
    80008f64:	57fd                	li	a5,-1
    80008f66:	aa8d                	j	800090d8 <sys_exec+0x1ac>
  }
  memset(argv, 0, sizeof(argv));
    80008f68:	e6840793          	addi	a5,s0,-408
    80008f6c:	10000613          	li	a2,256
    80008f70:	4581                	li	a1,0
    80008f72:	853e                	mv	a0,a5
    80008f74:	ffff8097          	auipc	ra,0xffff8
    80008f78:	4ca080e7          	jalr	1226(ra) # 8000143e <memset>
  for(i=0;; i++){
    80008f7c:	fe042623          	sw	zero,-20(s0)
    if(i >= NELEM(argv)){
    80008f80:	fec42783          	lw	a5,-20(s0)
    80008f84:	873e                	mv	a4,a5
    80008f86:	47fd                	li	a5,31
    80008f88:	0ee7ee63          	bltu	a5,a4,80009084 <sys_exec+0x158>
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80008f8c:	fec42783          	lw	a5,-20(s0)
    80008f90:	00379713          	slli	a4,a5,0x3
    80008f94:	e6043783          	ld	a5,-416(s0)
    80008f98:	97ba                	add	a5,a5,a4
    80008f9a:	e5840713          	addi	a4,s0,-424
    80008f9e:	85ba                	mv	a1,a4
    80008fa0:	853e                	mv	a0,a5
    80008fa2:	ffffc097          	auipc	ra,0xffffc
    80008fa6:	8f8080e7          	jalr	-1800(ra) # 8000489a <fetchaddr>
    80008faa:	87aa                	mv	a5,a0
    80008fac:	0c07ce63          	bltz	a5,80009088 <sys_exec+0x15c>
      goto bad;
    }
    if(uarg == 0){
    80008fb0:	e5843783          	ld	a5,-424(s0)
    80008fb4:	eb8d                	bnez	a5,80008fe6 <sys_exec+0xba>
      argv[i] = 0;
    80008fb6:	fec42783          	lw	a5,-20(s0)
    80008fba:	078e                	slli	a5,a5,0x3
    80008fbc:	17c1                	addi	a5,a5,-16
    80008fbe:	97a2                	add	a5,a5,s0
    80008fc0:	e607bc23          	sd	zero,-392(a5)
      break;
    80008fc4:	0001                	nop
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
      goto bad;
  }

  int ret = exec(path, argv);
    80008fc6:	e6840713          	addi	a4,s0,-408
    80008fca:	f6840793          	addi	a5,s0,-152
    80008fce:	85ba                	mv	a1,a4
    80008fd0:	853e                	mv	a0,a5
    80008fd2:	fffff097          	auipc	ra,0xfffff
    80008fd6:	c2a080e7          	jalr	-982(ra) # 80007bfc <exec>
    80008fda:	87aa                	mv	a5,a0
    80008fdc:	fef42423          	sw	a5,-24(s0)

  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80008fe0:	fe042623          	sw	zero,-20(s0)
    80008fe4:	a8bd                	j	80009062 <sys_exec+0x136>
    argv[i] = kalloc();
    80008fe6:	ffff8097          	auipc	ra,0xffff8
    80008fea:	130080e7          	jalr	304(ra) # 80001116 <kalloc>
    80008fee:	872a                	mv	a4,a0
    80008ff0:	fec42783          	lw	a5,-20(s0)
    80008ff4:	078e                	slli	a5,a5,0x3
    80008ff6:	17c1                	addi	a5,a5,-16
    80008ff8:	97a2                	add	a5,a5,s0
    80008ffa:	e6e7bc23          	sd	a4,-392(a5)
    if(argv[i] == 0)
    80008ffe:	fec42783          	lw	a5,-20(s0)
    80009002:	078e                	slli	a5,a5,0x3
    80009004:	17c1                	addi	a5,a5,-16
    80009006:	97a2                	add	a5,a5,s0
    80009008:	e787b783          	ld	a5,-392(a5)
    8000900c:	c3c1                	beqz	a5,8000908c <sys_exec+0x160>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8000900e:	e5843703          	ld	a4,-424(s0)
    80009012:	fec42783          	lw	a5,-20(s0)
    80009016:	078e                	slli	a5,a5,0x3
    80009018:	17c1                	addi	a5,a5,-16
    8000901a:	97a2                	add	a5,a5,s0
    8000901c:	e787b783          	ld	a5,-392(a5)
    80009020:	6605                	lui	a2,0x1
    80009022:	85be                	mv	a1,a5
    80009024:	853a                	mv	a0,a4
    80009026:	ffffc097          	auipc	ra,0xffffc
    8000902a:	8e2080e7          	jalr	-1822(ra) # 80004908 <fetchstr>
    8000902e:	87aa                	mv	a5,a0
    80009030:	0607c063          	bltz	a5,80009090 <sys_exec+0x164>
  for(i=0;; i++){
    80009034:	fec42783          	lw	a5,-20(s0)
    80009038:	2785                	addiw	a5,a5,1
    8000903a:	fef42623          	sw	a5,-20(s0)
    if(i >= NELEM(argv)){
    8000903e:	b789                	j	80008f80 <sys_exec+0x54>
    kfree(argv[i]);
    80009040:	fec42783          	lw	a5,-20(s0)
    80009044:	078e                	slli	a5,a5,0x3
    80009046:	17c1                	addi	a5,a5,-16
    80009048:	97a2                	add	a5,a5,s0
    8000904a:	e787b783          	ld	a5,-392(a5)
    8000904e:	853e                	mv	a0,a5
    80009050:	ffff8097          	auipc	ra,0xffff8
    80009054:	022080e7          	jalr	34(ra) # 80001072 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80009058:	fec42783          	lw	a5,-20(s0)
    8000905c:	2785                	addiw	a5,a5,1
    8000905e:	fef42623          	sw	a5,-20(s0)
    80009062:	fec42783          	lw	a5,-20(s0)
    80009066:	873e                	mv	a4,a5
    80009068:	47fd                	li	a5,31
    8000906a:	00e7ea63          	bltu	a5,a4,8000907e <sys_exec+0x152>
    8000906e:	fec42783          	lw	a5,-20(s0)
    80009072:	078e                	slli	a5,a5,0x3
    80009074:	17c1                	addi	a5,a5,-16
    80009076:	97a2                	add	a5,a5,s0
    80009078:	e787b783          	ld	a5,-392(a5)
    8000907c:	f3f1                	bnez	a5,80009040 <sys_exec+0x114>

  return ret;
    8000907e:	fe842783          	lw	a5,-24(s0)
    80009082:	a899                	j	800090d8 <sys_exec+0x1ac>
      goto bad;
    80009084:	0001                	nop
    80009086:	a031                	j	80009092 <sys_exec+0x166>
      goto bad;
    80009088:	0001                	nop
    8000908a:	a021                	j	80009092 <sys_exec+0x166>
      goto bad;
    8000908c:	0001                	nop
    8000908e:	a011                	j	80009092 <sys_exec+0x166>
      goto bad;
    80009090:	0001                	nop

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80009092:	fe042623          	sw	zero,-20(s0)
    80009096:	a015                	j	800090ba <sys_exec+0x18e>
    kfree(argv[i]);
    80009098:	fec42783          	lw	a5,-20(s0)
    8000909c:	078e                	slli	a5,a5,0x3
    8000909e:	17c1                	addi	a5,a5,-16
    800090a0:	97a2                	add	a5,a5,s0
    800090a2:	e787b783          	ld	a5,-392(a5)
    800090a6:	853e                	mv	a0,a5
    800090a8:	ffff8097          	auipc	ra,0xffff8
    800090ac:	fca080e7          	jalr	-54(ra) # 80001072 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800090b0:	fec42783          	lw	a5,-20(s0)
    800090b4:	2785                	addiw	a5,a5,1
    800090b6:	fef42623          	sw	a5,-20(s0)
    800090ba:	fec42783          	lw	a5,-20(s0)
    800090be:	873e                	mv	a4,a5
    800090c0:	47fd                	li	a5,31
    800090c2:	00e7ea63          	bltu	a5,a4,800090d6 <sys_exec+0x1aa>
    800090c6:	fec42783          	lw	a5,-20(s0)
    800090ca:	078e                	slli	a5,a5,0x3
    800090cc:	17c1                	addi	a5,a5,-16
    800090ce:	97a2                	add	a5,a5,s0
    800090d0:	e787b783          	ld	a5,-392(a5)
    800090d4:	f3f1                	bnez	a5,80009098 <sys_exec+0x16c>
  return -1;
    800090d6:	57fd                	li	a5,-1
}
    800090d8:	853e                	mv	a0,a5
    800090da:	70ba                	ld	ra,424(sp)
    800090dc:	741a                	ld	s0,416(sp)
    800090de:	615d                	addi	sp,sp,432
    800090e0:	8082                	ret

00000000800090e2 <sys_pipe>:

uint64
sys_pipe(void)
{
    800090e2:	7139                	addi	sp,sp,-64
    800090e4:	fc06                	sd	ra,56(sp)
    800090e6:	f822                	sd	s0,48(sp)
    800090e8:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    800090ea:	ffffa097          	auipc	ra,0xffffa
    800090ee:	92e080e7          	jalr	-1746(ra) # 80002a18 <myproc>
    800090f2:	fea43423          	sd	a0,-24(s0)

  if(argaddr(0, &fdarray) < 0)
    800090f6:	fe040793          	addi	a5,s0,-32
    800090fa:	85be                	mv	a1,a5
    800090fc:	4501                	li	a0,0
    800090fe:	ffffc097          	auipc	ra,0xffffc
    80009102:	952080e7          	jalr	-1710(ra) # 80004a50 <argaddr>
    80009106:	87aa                	mv	a5,a0
    80009108:	0007d463          	bgez	a5,80009110 <sys_pipe+0x2e>
    return -1;
    8000910c:	57fd                	li	a5,-1
    8000910e:	a215                	j	80009232 <sys_pipe+0x150>
  if(pipealloc(&rf, &wf) < 0)
    80009110:	fd040713          	addi	a4,s0,-48
    80009114:	fd840793          	addi	a5,s0,-40
    80009118:	85ba                	mv	a1,a4
    8000911a:	853e                	mv	a0,a5
    8000911c:	ffffe097          	auipc	ra,0xffffe
    80009120:	64c080e7          	jalr	1612(ra) # 80007768 <pipealloc>
    80009124:	87aa                	mv	a5,a0
    80009126:	0007d463          	bgez	a5,8000912e <sys_pipe+0x4c>
    return -1;
    8000912a:	57fd                	li	a5,-1
    8000912c:	a219                	j	80009232 <sys_pipe+0x150>
  fd0 = -1;
    8000912e:	57fd                	li	a5,-1
    80009130:	fcf42623          	sw	a5,-52(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80009134:	fd843783          	ld	a5,-40(s0)
    80009138:	853e                	mv	a0,a5
    8000913a:	fffff097          	auipc	ra,0xfffff
    8000913e:	0ce080e7          	jalr	206(ra) # 80008208 <fdalloc>
    80009142:	87aa                	mv	a5,a0
    80009144:	fcf42623          	sw	a5,-52(s0)
    80009148:	fcc42783          	lw	a5,-52(s0)
    8000914c:	0207c063          	bltz	a5,8000916c <sys_pipe+0x8a>
    80009150:	fd043783          	ld	a5,-48(s0)
    80009154:	853e                	mv	a0,a5
    80009156:	fffff097          	auipc	ra,0xfffff
    8000915a:	0b2080e7          	jalr	178(ra) # 80008208 <fdalloc>
    8000915e:	87aa                	mv	a5,a0
    80009160:	fcf42423          	sw	a5,-56(s0)
    80009164:	fc842783          	lw	a5,-56(s0)
    80009168:	0207df63          	bgez	a5,800091a6 <sys_pipe+0xc4>
    if(fd0 >= 0)
    8000916c:	fcc42783          	lw	a5,-52(s0)
    80009170:	0007cb63          	bltz	a5,80009186 <sys_pipe+0xa4>
      p->ofile[fd0] = 0;
    80009174:	fcc42783          	lw	a5,-52(s0)
    80009178:	fe843703          	ld	a4,-24(s0)
    8000917c:	07f1                	addi	a5,a5,28
    8000917e:	078e                	slli	a5,a5,0x3
    80009180:	97ba                	add	a5,a5,a4
    80009182:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80009186:	fd843783          	ld	a5,-40(s0)
    8000918a:	853e                	mv	a0,a5
    8000918c:	ffffe097          	auipc	ra,0xffffe
    80009190:	0ba080e7          	jalr	186(ra) # 80007246 <fileclose>
    fileclose(wf);
    80009194:	fd043783          	ld	a5,-48(s0)
    80009198:	853e                	mv	a0,a5
    8000919a:	ffffe097          	auipc	ra,0xffffe
    8000919e:	0ac080e7          	jalr	172(ra) # 80007246 <fileclose>
    return -1;
    800091a2:	57fd                	li	a5,-1
    800091a4:	a079                	j	80009232 <sys_pipe+0x150>
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800091a6:	fe843783          	ld	a5,-24(s0)
    800091aa:	6bbc                	ld	a5,80(a5)
    800091ac:	fe043703          	ld	a4,-32(s0)
    800091b0:	fcc40613          	addi	a2,s0,-52
    800091b4:	4691                	li	a3,4
    800091b6:	85ba                	mv	a1,a4
    800091b8:	853e                	mv	a0,a5
    800091ba:	ffff9097          	auipc	ra,0xffff9
    800091be:	20c080e7          	jalr	524(ra) # 800023c6 <copyout>
    800091c2:	87aa                	mv	a5,a0
    800091c4:	0207c463          	bltz	a5,800091ec <sys_pipe+0x10a>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    800091c8:	fe843783          	ld	a5,-24(s0)
    800091cc:	6bb8                	ld	a4,80(a5)
    800091ce:	fe043783          	ld	a5,-32(s0)
    800091d2:	0791                	addi	a5,a5,4
    800091d4:	fc840613          	addi	a2,s0,-56
    800091d8:	4691                	li	a3,4
    800091da:	85be                	mv	a1,a5
    800091dc:	853a                	mv	a0,a4
    800091de:	ffff9097          	auipc	ra,0xffff9
    800091e2:	1e8080e7          	jalr	488(ra) # 800023c6 <copyout>
    800091e6:	87aa                	mv	a5,a0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800091e8:	0407d463          	bgez	a5,80009230 <sys_pipe+0x14e>
    p->ofile[fd0] = 0;
    800091ec:	fcc42783          	lw	a5,-52(s0)
    800091f0:	fe843703          	ld	a4,-24(s0)
    800091f4:	07f1                	addi	a5,a5,28
    800091f6:	078e                	slli	a5,a5,0x3
    800091f8:	97ba                	add	a5,a5,a4
    800091fa:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    800091fe:	fc842783          	lw	a5,-56(s0)
    80009202:	fe843703          	ld	a4,-24(s0)
    80009206:	07f1                	addi	a5,a5,28
    80009208:	078e                	slli	a5,a5,0x3
    8000920a:	97ba                	add	a5,a5,a4
    8000920c:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80009210:	fd843783          	ld	a5,-40(s0)
    80009214:	853e                	mv	a0,a5
    80009216:	ffffe097          	auipc	ra,0xffffe
    8000921a:	030080e7          	jalr	48(ra) # 80007246 <fileclose>
    fileclose(wf);
    8000921e:	fd043783          	ld	a5,-48(s0)
    80009222:	853e                	mv	a0,a5
    80009224:	ffffe097          	auipc	ra,0xffffe
    80009228:	022080e7          	jalr	34(ra) # 80007246 <fileclose>
    return -1;
    8000922c:	57fd                	li	a5,-1
    8000922e:	a011                	j	80009232 <sys_pipe+0x150>
  }
  return 0;
    80009230:	4781                	li	a5,0
}
    80009232:	853e                	mv	a0,a5
    80009234:	70e2                	ld	ra,56(sp)
    80009236:	7442                	ld	s0,48(sp)
    80009238:	6121                	addi	sp,sp,64
    8000923a:	8082                	ret
    8000923c:	0000                	unimp
	...

0000000080009240 <kernelvec>:
    80009240:	7111                	addi	sp,sp,-256
    80009242:	e006                	sd	ra,0(sp)
    80009244:	e40a                	sd	sp,8(sp)
    80009246:	e80e                	sd	gp,16(sp)
    80009248:	ec12                	sd	tp,24(sp)
    8000924a:	f016                	sd	t0,32(sp)
    8000924c:	f41a                	sd	t1,40(sp)
    8000924e:	f81e                	sd	t2,48(sp)
    80009250:	fc22                	sd	s0,56(sp)
    80009252:	e0a6                	sd	s1,64(sp)
    80009254:	e4aa                	sd	a0,72(sp)
    80009256:	e8ae                	sd	a1,80(sp)
    80009258:	ecb2                	sd	a2,88(sp)
    8000925a:	f0b6                	sd	a3,96(sp)
    8000925c:	f4ba                	sd	a4,104(sp)
    8000925e:	f8be                	sd	a5,112(sp)
    80009260:	fcc2                	sd	a6,120(sp)
    80009262:	e146                	sd	a7,128(sp)
    80009264:	e54a                	sd	s2,136(sp)
    80009266:	e94e                	sd	s3,144(sp)
    80009268:	ed52                	sd	s4,152(sp)
    8000926a:	f156                	sd	s5,160(sp)
    8000926c:	f55a                	sd	s6,168(sp)
    8000926e:	f95e                	sd	s7,176(sp)
    80009270:	fd62                	sd	s8,184(sp)
    80009272:	e1e6                	sd	s9,192(sp)
    80009274:	e5ea                	sd	s10,200(sp)
    80009276:	e9ee                	sd	s11,208(sp)
    80009278:	edf2                	sd	t3,216(sp)
    8000927a:	f1f6                	sd	t4,224(sp)
    8000927c:	f5fa                	sd	t5,232(sp)
    8000927e:	f9fe                	sd	t6,240(sp)
    80009280:	bb2fb0ef          	jal	ra,80004632 <kerneltrap>
    80009284:	6082                	ld	ra,0(sp)
    80009286:	6122                	ld	sp,8(sp)
    80009288:	61c2                	ld	gp,16(sp)
    8000928a:	7282                	ld	t0,32(sp)
    8000928c:	7322                	ld	t1,40(sp)
    8000928e:	73c2                	ld	t2,48(sp)
    80009290:	7462                	ld	s0,56(sp)
    80009292:	6486                	ld	s1,64(sp)
    80009294:	6526                	ld	a0,72(sp)
    80009296:	65c6                	ld	a1,80(sp)
    80009298:	6666                	ld	a2,88(sp)
    8000929a:	7686                	ld	a3,96(sp)
    8000929c:	7726                	ld	a4,104(sp)
    8000929e:	77c6                	ld	a5,112(sp)
    800092a0:	7866                	ld	a6,120(sp)
    800092a2:	688a                	ld	a7,128(sp)
    800092a4:	692a                	ld	s2,136(sp)
    800092a6:	69ca                	ld	s3,144(sp)
    800092a8:	6a6a                	ld	s4,152(sp)
    800092aa:	7a8a                	ld	s5,160(sp)
    800092ac:	7b2a                	ld	s6,168(sp)
    800092ae:	7bca                	ld	s7,176(sp)
    800092b0:	7c6a                	ld	s8,184(sp)
    800092b2:	6c8e                	ld	s9,192(sp)
    800092b4:	6d2e                	ld	s10,200(sp)
    800092b6:	6dce                	ld	s11,208(sp)
    800092b8:	6e6e                	ld	t3,216(sp)
    800092ba:	7e8e                	ld	t4,224(sp)
    800092bc:	7f2e                	ld	t5,232(sp)
    800092be:	7fce                	ld	t6,240(sp)
    800092c0:	6111                	addi	sp,sp,256
    800092c2:	10200073          	sret
    800092c6:	00000013          	nop
    800092ca:	00000013          	nop
    800092ce:	0001                	nop

00000000800092d0 <timervec>:
    800092d0:	34051573          	csrrw	a0,mscratch,a0
    800092d4:	e10c                	sd	a1,0(a0)
    800092d6:	e510                	sd	a2,8(a0)
    800092d8:	e914                	sd	a3,16(a0)
    800092da:	6d0c                	ld	a1,24(a0)
    800092dc:	7110                	ld	a2,32(a0)
    800092de:	6194                	ld	a3,0(a1)
    800092e0:	96b2                	add	a3,a3,a2
    800092e2:	e194                	sd	a3,0(a1)
    800092e4:	4589                	li	a1,2
    800092e6:	14459073          	csrw	sip,a1
    800092ea:	6914                	ld	a3,16(a0)
    800092ec:	6510                	ld	a2,8(a0)
    800092ee:	610c                	ld	a1,0(a0)
    800092f0:	34051573          	csrrw	a0,mscratch,a0
    800092f4:	30200073          	mret
	...

00000000800092fa <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    800092fa:	1141                	addi	sp,sp,-16
    800092fc:	e422                	sd	s0,8(sp)
    800092fe:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80009300:	0c0007b7          	lui	a5,0xc000
    80009304:	02878793          	addi	a5,a5,40 # c000028 <_entry-0x73ffffd8>
    80009308:	4705                	li	a4,1
    8000930a:	c398                	sw	a4,0(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    8000930c:	0c0007b7          	lui	a5,0xc000
    80009310:	0791                	addi	a5,a5,4
    80009312:	4705                	li	a4,1
    80009314:	c398                	sw	a4,0(a5)
}
    80009316:	0001                	nop
    80009318:	6422                	ld	s0,8(sp)
    8000931a:	0141                	addi	sp,sp,16
    8000931c:	8082                	ret

000000008000931e <plicinithart>:

void
plicinithart(void)
{
    8000931e:	1101                	addi	sp,sp,-32
    80009320:	ec06                	sd	ra,24(sp)
    80009322:	e822                	sd	s0,16(sp)
    80009324:	1000                	addi	s0,sp,32
  int hart = cpuid();
    80009326:	ffff9097          	auipc	ra,0xffff9
    8000932a:	694080e7          	jalr	1684(ra) # 800029ba <cpuid>
    8000932e:	87aa                	mv	a5,a0
    80009330:	fef42623          	sw	a5,-20(s0)
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80009334:	fec42783          	lw	a5,-20(s0)
    80009338:	0087979b          	slliw	a5,a5,0x8
    8000933c:	2781                	sext.w	a5,a5
    8000933e:	873e                	mv	a4,a5
    80009340:	0c0027b7          	lui	a5,0xc002
    80009344:	08078793          	addi	a5,a5,128 # c002080 <_entry-0x73ffdf80>
    80009348:	97ba                	add	a5,a5,a4
    8000934a:	873e                	mv	a4,a5
    8000934c:	40200793          	li	a5,1026
    80009350:	c31c                	sw	a5,0(a4)

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80009352:	fec42783          	lw	a5,-20(s0)
    80009356:	00d7979b          	slliw	a5,a5,0xd
    8000935a:	2781                	sext.w	a5,a5
    8000935c:	873e                	mv	a4,a5
    8000935e:	0c2017b7          	lui	a5,0xc201
    80009362:	97ba                	add	a5,a5,a4
    80009364:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80009368:	0001                	nop
    8000936a:	60e2                	ld	ra,24(sp)
    8000936c:	6442                	ld	s0,16(sp)
    8000936e:	6105                	addi	sp,sp,32
    80009370:	8082                	ret

0000000080009372 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80009372:	1101                	addi	sp,sp,-32
    80009374:	ec06                	sd	ra,24(sp)
    80009376:	e822                	sd	s0,16(sp)
    80009378:	1000                	addi	s0,sp,32
  int hart = cpuid();
    8000937a:	ffff9097          	auipc	ra,0xffff9
    8000937e:	640080e7          	jalr	1600(ra) # 800029ba <cpuid>
    80009382:	87aa                	mv	a5,a0
    80009384:	fef42623          	sw	a5,-20(s0)
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80009388:	fec42783          	lw	a5,-20(s0)
    8000938c:	00d7979b          	slliw	a5,a5,0xd
    80009390:	2781                	sext.w	a5,a5
    80009392:	873e                	mv	a4,a5
    80009394:	0c2017b7          	lui	a5,0xc201
    80009398:	0791                	addi	a5,a5,4
    8000939a:	97ba                	add	a5,a5,a4
    8000939c:	439c                	lw	a5,0(a5)
    8000939e:	fef42423          	sw	a5,-24(s0)
  return irq;
    800093a2:	fe842783          	lw	a5,-24(s0)
}
    800093a6:	853e                	mv	a0,a5
    800093a8:	60e2                	ld	ra,24(sp)
    800093aa:	6442                	ld	s0,16(sp)
    800093ac:	6105                	addi	sp,sp,32
    800093ae:	8082                	ret

00000000800093b0 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800093b0:	7179                	addi	sp,sp,-48
    800093b2:	f406                	sd	ra,40(sp)
    800093b4:	f022                	sd	s0,32(sp)
    800093b6:	1800                	addi	s0,sp,48
    800093b8:	87aa                	mv	a5,a0
    800093ba:	fcf42e23          	sw	a5,-36(s0)
  int hart = cpuid();
    800093be:	ffff9097          	auipc	ra,0xffff9
    800093c2:	5fc080e7          	jalr	1532(ra) # 800029ba <cpuid>
    800093c6:	87aa                	mv	a5,a0
    800093c8:	fef42623          	sw	a5,-20(s0)
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800093cc:	fec42783          	lw	a5,-20(s0)
    800093d0:	00d7979b          	slliw	a5,a5,0xd
    800093d4:	2781                	sext.w	a5,a5
    800093d6:	873e                	mv	a4,a5
    800093d8:	0c2017b7          	lui	a5,0xc201
    800093dc:	0791                	addi	a5,a5,4
    800093de:	97ba                	add	a5,a5,a4
    800093e0:	873e                	mv	a4,a5
    800093e2:	fdc42783          	lw	a5,-36(s0)
    800093e6:	c31c                	sw	a5,0(a4)
}
    800093e8:	0001                	nop
    800093ea:	70a2                	ld	ra,40(sp)
    800093ec:	7402                	ld	s0,32(sp)
    800093ee:	6145                	addi	sp,sp,48
    800093f0:	8082                	ret

00000000800093f2 <virtio_disk_init>:
  
} __attribute__ ((aligned (PGSIZE))) disk;

void
virtio_disk_init(void)
{
    800093f2:	7179                	addi	sp,sp,-48
    800093f4:	f406                	sd	ra,40(sp)
    800093f6:	f022                	sd	s0,32(sp)
    800093f8:	1800                	addi	s0,sp,48
  uint32 status = 0;
    800093fa:	fe042423          	sw	zero,-24(s0)

  initlock(&disk.vdisk_lock, "virtio_disk");
    800093fe:	00002597          	auipc	a1,0x2
    80009402:	42258593          	addi	a1,a1,1058 # 8000b820 <etext+0x820>
    80009406:	0049f517          	auipc	a0,0x49f
    8000940a:	d2250513          	addi	a0,a0,-734 # 804a8128 <disk+0x2128>
    8000940e:	ffff8097          	auipc	ra,0xffff8
    80009412:	e2c080e7          	jalr	-468(ra) # 8000123a <initlock>

  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80009416:	100017b7          	lui	a5,0x10001
    8000941a:	439c                	lw	a5,0(a5)
    8000941c:	2781                	sext.w	a5,a5
    8000941e:	873e                	mv	a4,a5
    80009420:	747277b7          	lui	a5,0x74727
    80009424:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80009428:	04f71063          	bne	a4,a5,80009468 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    8000942c:	100017b7          	lui	a5,0x10001
    80009430:	0791                	addi	a5,a5,4
    80009432:	439c                	lw	a5,0(a5)
    80009434:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80009436:	873e                	mv	a4,a5
    80009438:	4785                	li	a5,1
    8000943a:	02f71763          	bne	a4,a5,80009468 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000943e:	100017b7          	lui	a5,0x10001
    80009442:	07a1                	addi	a5,a5,8
    80009444:	439c                	lw	a5,0(a5)
    80009446:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80009448:	873e                	mv	a4,a5
    8000944a:	4789                	li	a5,2
    8000944c:	00f71e63          	bne	a4,a5,80009468 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80009450:	100017b7          	lui	a5,0x10001
    80009454:	07b1                	addi	a5,a5,12
    80009456:	439c                	lw	a5,0(a5)
    80009458:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000945a:	873e                	mv	a4,a5
    8000945c:	554d47b7          	lui	a5,0x554d4
    80009460:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80009464:	00f70a63          	beq	a4,a5,80009478 <virtio_disk_init+0x86>
    panic("could not find virtio disk");
    80009468:	00002517          	auipc	a0,0x2
    8000946c:	3c850513          	addi	a0,a0,968 # 8000b830 <etext+0x830>
    80009470:	ffff8097          	auipc	ra,0xffff8
    80009474:	80a080e7          	jalr	-2038(ra) # 80000c7a <panic>
  }
  
  status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    80009478:	fe842783          	lw	a5,-24(s0)
    8000947c:	0017e793          	ori	a5,a5,1
    80009480:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80009484:	100017b7          	lui	a5,0x10001
    80009488:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    8000948c:	fe842703          	lw	a4,-24(s0)
    80009490:	c398                	sw	a4,0(a5)

  status |= VIRTIO_CONFIG_S_DRIVER;
    80009492:	fe842783          	lw	a5,-24(s0)
    80009496:	0027e793          	ori	a5,a5,2
    8000949a:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000949e:	100017b7          	lui	a5,0x10001
    800094a2:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    800094a6:	fe842703          	lw	a4,-24(s0)
    800094aa:	c398                	sw	a4,0(a5)

  // negotiate features
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800094ac:	100017b7          	lui	a5,0x10001
    800094b0:	07c1                	addi	a5,a5,16
    800094b2:	439c                	lw	a5,0(a5)
    800094b4:	2781                	sext.w	a5,a5
    800094b6:	1782                	slli	a5,a5,0x20
    800094b8:	9381                	srli	a5,a5,0x20
    800094ba:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_RO);
    800094be:	fe043783          	ld	a5,-32(s0)
    800094c2:	fdf7f793          	andi	a5,a5,-33
    800094c6:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_SCSI);
    800094ca:	fe043783          	ld	a5,-32(s0)
    800094ce:	f7f7f793          	andi	a5,a5,-129
    800094d2:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    800094d6:	fe043703          	ld	a4,-32(s0)
    800094da:	77fd                	lui	a5,0xfffff
    800094dc:	7ff78793          	addi	a5,a5,2047 # fffffffffffff7ff <end+0xffffffff7fb567ff>
    800094e0:	8ff9                	and	a5,a5,a4
    800094e2:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_MQ);
    800094e6:	fe043703          	ld	a4,-32(s0)
    800094ea:	77fd                	lui	a5,0xfffff
    800094ec:	17fd                	addi	a5,a5,-1
    800094ee:	8ff9                	and	a5,a5,a4
    800094f0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    800094f4:	fe043703          	ld	a4,-32(s0)
    800094f8:	f80007b7          	lui	a5,0xf8000
    800094fc:	17fd                	addi	a5,a5,-1
    800094fe:	8ff9                	and	a5,a5,a4
    80009500:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    80009504:	fe043703          	ld	a4,-32(s0)
    80009508:	e00007b7          	lui	a5,0xe0000
    8000950c:	17fd                	addi	a5,a5,-1
    8000950e:	8ff9                	and	a5,a5,a4
    80009510:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80009514:	fe043703          	ld	a4,-32(s0)
    80009518:	f00007b7          	lui	a5,0xf0000
    8000951c:	17fd                	addi	a5,a5,-1
    8000951e:	8ff9                	and	a5,a5,a4
    80009520:	fef43023          	sd	a5,-32(s0)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80009524:	100017b7          	lui	a5,0x10001
    80009528:	02078793          	addi	a5,a5,32 # 10001020 <_entry-0x6fffefe0>
    8000952c:	fe043703          	ld	a4,-32(s0)
    80009530:	2701                	sext.w	a4,a4
    80009532:	c398                	sw	a4,0(a5)

  // tell device that feature negotiation is complete.
  status |= VIRTIO_CONFIG_S_FEATURES_OK;
    80009534:	fe842783          	lw	a5,-24(s0)
    80009538:	0087e793          	ori	a5,a5,8
    8000953c:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80009540:	100017b7          	lui	a5,0x10001
    80009544:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80009548:	fe842703          	lw	a4,-24(s0)
    8000954c:	c398                	sw	a4,0(a5)

  // tell device we're completely ready.
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    8000954e:	fe842783          	lw	a5,-24(s0)
    80009552:	0047e793          	ori	a5,a5,4
    80009556:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000955a:	100017b7          	lui	a5,0x10001
    8000955e:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80009562:	fe842703          	lw	a4,-24(s0)
    80009566:	c398                	sw	a4,0(a5)

  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    80009568:	100017b7          	lui	a5,0x10001
    8000956c:	02878793          	addi	a5,a5,40 # 10001028 <_entry-0x6fffefd8>
    80009570:	6705                	lui	a4,0x1
    80009572:	c398                	sw	a4,0(a5)

  // initialize queue 0.
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80009574:	100017b7          	lui	a5,0x10001
    80009578:	03078793          	addi	a5,a5,48 # 10001030 <_entry-0x6fffefd0>
    8000957c:	0007a023          	sw	zero,0(a5)
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80009580:	100017b7          	lui	a5,0x10001
    80009584:	03478793          	addi	a5,a5,52 # 10001034 <_entry-0x6fffefcc>
    80009588:	439c                	lw	a5,0(a5)
    8000958a:	fcf42e23          	sw	a5,-36(s0)
  if(max == 0)
    8000958e:	fdc42783          	lw	a5,-36(s0)
    80009592:	2781                	sext.w	a5,a5
    80009594:	eb89                	bnez	a5,800095a6 <virtio_disk_init+0x1b4>
    panic("virtio disk has no queue 0");
    80009596:	00002517          	auipc	a0,0x2
    8000959a:	2ba50513          	addi	a0,a0,698 # 8000b850 <etext+0x850>
    8000959e:	ffff7097          	auipc	ra,0xffff7
    800095a2:	6dc080e7          	jalr	1756(ra) # 80000c7a <panic>
  if(max < NUM)
    800095a6:	fdc42783          	lw	a5,-36(s0)
    800095aa:	0007871b          	sext.w	a4,a5
    800095ae:	479d                	li	a5,7
    800095b0:	00e7ea63          	bltu	a5,a4,800095c4 <virtio_disk_init+0x1d2>
    panic("virtio disk max queue too short");
    800095b4:	00002517          	auipc	a0,0x2
    800095b8:	2bc50513          	addi	a0,a0,700 # 8000b870 <etext+0x870>
    800095bc:	ffff7097          	auipc	ra,0xffff7
    800095c0:	6be080e7          	jalr	1726(ra) # 80000c7a <panic>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800095c4:	100017b7          	lui	a5,0x10001
    800095c8:	03878793          	addi	a5,a5,56 # 10001038 <_entry-0x6fffefc8>
    800095cc:	4721                	li	a4,8
    800095ce:	c398                	sw	a4,0(a5)
  memset(disk.pages, 0, sizeof(disk.pages));
    800095d0:	6609                	lui	a2,0x2
    800095d2:	4581                	li	a1,0
    800095d4:	0049d517          	auipc	a0,0x49d
    800095d8:	a2c50513          	addi	a0,a0,-1492 # 804a6000 <disk>
    800095dc:	ffff8097          	auipc	ra,0xffff8
    800095e0:	e62080e7          	jalr	-414(ra) # 8000143e <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    800095e4:	0049d797          	auipc	a5,0x49d
    800095e8:	a1c78793          	addi	a5,a5,-1508 # 804a6000 <disk>
    800095ec:	00c7d713          	srli	a4,a5,0xc
    800095f0:	100017b7          	lui	a5,0x10001
    800095f4:	04078793          	addi	a5,a5,64 # 10001040 <_entry-0x6fffefc0>
    800095f8:	2701                	sext.w	a4,a4
    800095fa:	c398                	sw	a4,0(a5)

  // desc = pages -- num * virtq_desc
  // avail = pages + 0x40 -- 2 * uint16, then num * uint16
  // used = pages + 4096 -- 2 * uint16, then num * vRingUsedElem

  disk.desc = (struct virtq_desc *) disk.pages;
    800095fc:	0049d717          	auipc	a4,0x49d
    80009600:	a0470713          	addi	a4,a4,-1532 # 804a6000 <disk>
    80009604:	6789                	lui	a5,0x2
    80009606:	97ba                	add	a5,a5,a4
    80009608:	0049d717          	auipc	a4,0x49d
    8000960c:	9f870713          	addi	a4,a4,-1544 # 804a6000 <disk>
    80009610:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    80009612:	0049d717          	auipc	a4,0x49d
    80009616:	a6e70713          	addi	a4,a4,-1426 # 804a6080 <disk+0x80>
    8000961a:	0049d697          	auipc	a3,0x49d
    8000961e:	9e668693          	addi	a3,a3,-1562 # 804a6000 <disk>
    80009622:	6789                	lui	a5,0x2
    80009624:	97b6                	add	a5,a5,a3
    80009626:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    80009628:	0049e717          	auipc	a4,0x49e
    8000962c:	9d870713          	addi	a4,a4,-1576 # 804a7000 <disk+0x1000>
    80009630:	0049d697          	auipc	a3,0x49d
    80009634:	9d068693          	addi	a3,a3,-1584 # 804a6000 <disk>
    80009638:	6789                	lui	a5,0x2
    8000963a:	97b6                	add	a5,a5,a3
    8000963c:	eb98                	sd	a4,16(a5)

  // all NUM descriptors start out unused.
  for(int i = 0; i < NUM; i++)
    8000963e:	fe042623          	sw	zero,-20(s0)
    80009642:	a015                	j	80009666 <virtio_disk_init+0x274>
    disk.free[i] = 1;
    80009644:	0049d717          	auipc	a4,0x49d
    80009648:	9bc70713          	addi	a4,a4,-1604 # 804a6000 <disk>
    8000964c:	fec42783          	lw	a5,-20(s0)
    80009650:	97ba                	add	a5,a5,a4
    80009652:	6709                	lui	a4,0x2
    80009654:	97ba                	add	a5,a5,a4
    80009656:	4705                	li	a4,1
    80009658:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  for(int i = 0; i < NUM; i++)
    8000965c:	fec42783          	lw	a5,-20(s0)
    80009660:	2785                	addiw	a5,a5,1
    80009662:	fef42623          	sw	a5,-20(s0)
    80009666:	fec42783          	lw	a5,-20(s0)
    8000966a:	0007871b          	sext.w	a4,a5
    8000966e:	479d                	li	a5,7
    80009670:	fce7dae3          	bge	a5,a4,80009644 <virtio_disk_init+0x252>

  // plic.c and trap.c arrange for interrupts from VIRTIO0_IRQ.
}
    80009674:	0001                	nop
    80009676:	0001                	nop
    80009678:	70a2                	ld	ra,40(sp)
    8000967a:	7402                	ld	s0,32(sp)
    8000967c:	6145                	addi	sp,sp,48
    8000967e:	8082                	ret

0000000080009680 <alloc_desc>:

// find a free descriptor, mark it non-free, return its index.
static int
alloc_desc()
{
    80009680:	1101                	addi	sp,sp,-32
    80009682:	ec22                	sd	s0,24(sp)
    80009684:	1000                	addi	s0,sp,32
  for(int i = 0; i < NUM; i++){
    80009686:	fe042623          	sw	zero,-20(s0)
    8000968a:	a081                	j	800096ca <alloc_desc+0x4a>
    if(disk.free[i]){
    8000968c:	0049d717          	auipc	a4,0x49d
    80009690:	97470713          	addi	a4,a4,-1676 # 804a6000 <disk>
    80009694:	fec42783          	lw	a5,-20(s0)
    80009698:	97ba                	add	a5,a5,a4
    8000969a:	6709                	lui	a4,0x2
    8000969c:	97ba                	add	a5,a5,a4
    8000969e:	0187c783          	lbu	a5,24(a5)
    800096a2:	cf99                	beqz	a5,800096c0 <alloc_desc+0x40>
      disk.free[i] = 0;
    800096a4:	0049d717          	auipc	a4,0x49d
    800096a8:	95c70713          	addi	a4,a4,-1700 # 804a6000 <disk>
    800096ac:	fec42783          	lw	a5,-20(s0)
    800096b0:	97ba                	add	a5,a5,a4
    800096b2:	6709                	lui	a4,0x2
    800096b4:	97ba                	add	a5,a5,a4
    800096b6:	00078c23          	sb	zero,24(a5)
      return i;
    800096ba:	fec42783          	lw	a5,-20(s0)
    800096be:	a831                	j	800096da <alloc_desc+0x5a>
  for(int i = 0; i < NUM; i++){
    800096c0:	fec42783          	lw	a5,-20(s0)
    800096c4:	2785                	addiw	a5,a5,1
    800096c6:	fef42623          	sw	a5,-20(s0)
    800096ca:	fec42783          	lw	a5,-20(s0)
    800096ce:	0007871b          	sext.w	a4,a5
    800096d2:	479d                	li	a5,7
    800096d4:	fae7dce3          	bge	a5,a4,8000968c <alloc_desc+0xc>
    }
  }
  return -1;
    800096d8:	57fd                	li	a5,-1
}
    800096da:	853e                	mv	a0,a5
    800096dc:	6462                	ld	s0,24(sp)
    800096de:	6105                	addi	sp,sp,32
    800096e0:	8082                	ret

00000000800096e2 <free_desc>:

// mark a descriptor as free.
static void
free_desc(int i)
{
    800096e2:	1101                	addi	sp,sp,-32
    800096e4:	ec06                	sd	ra,24(sp)
    800096e6:	e822                	sd	s0,16(sp)
    800096e8:	1000                	addi	s0,sp,32
    800096ea:	87aa                	mv	a5,a0
    800096ec:	fef42623          	sw	a5,-20(s0)
  if(i >= NUM)
    800096f0:	fec42783          	lw	a5,-20(s0)
    800096f4:	0007871b          	sext.w	a4,a5
    800096f8:	479d                	li	a5,7
    800096fa:	00e7da63          	bge	a5,a4,8000970e <free_desc+0x2c>
    panic("free_desc 1");
    800096fe:	00002517          	auipc	a0,0x2
    80009702:	19250513          	addi	a0,a0,402 # 8000b890 <etext+0x890>
    80009706:	ffff7097          	auipc	ra,0xffff7
    8000970a:	574080e7          	jalr	1396(ra) # 80000c7a <panic>
  if(disk.free[i])
    8000970e:	0049d717          	auipc	a4,0x49d
    80009712:	8f270713          	addi	a4,a4,-1806 # 804a6000 <disk>
    80009716:	fec42783          	lw	a5,-20(s0)
    8000971a:	97ba                	add	a5,a5,a4
    8000971c:	6709                	lui	a4,0x2
    8000971e:	97ba                	add	a5,a5,a4
    80009720:	0187c783          	lbu	a5,24(a5)
    80009724:	cb89                	beqz	a5,80009736 <free_desc+0x54>
    panic("free_desc 2");
    80009726:	00002517          	auipc	a0,0x2
    8000972a:	17a50513          	addi	a0,a0,378 # 8000b8a0 <etext+0x8a0>
    8000972e:	ffff7097          	auipc	ra,0xffff7
    80009732:	54c080e7          	jalr	1356(ra) # 80000c7a <panic>
  disk.desc[i].addr = 0;
    80009736:	0049d717          	auipc	a4,0x49d
    8000973a:	8ca70713          	addi	a4,a4,-1846 # 804a6000 <disk>
    8000973e:	6789                	lui	a5,0x2
    80009740:	97ba                	add	a5,a5,a4
    80009742:	6398                	ld	a4,0(a5)
    80009744:	fec42783          	lw	a5,-20(s0)
    80009748:	0792                	slli	a5,a5,0x4
    8000974a:	97ba                	add	a5,a5,a4
    8000974c:	0007b023          	sd	zero,0(a5) # 2000 <_entry-0x7fffe000>
  disk.desc[i].len = 0;
    80009750:	0049d717          	auipc	a4,0x49d
    80009754:	8b070713          	addi	a4,a4,-1872 # 804a6000 <disk>
    80009758:	6789                	lui	a5,0x2
    8000975a:	97ba                	add	a5,a5,a4
    8000975c:	6398                	ld	a4,0(a5)
    8000975e:	fec42783          	lw	a5,-20(s0)
    80009762:	0792                	slli	a5,a5,0x4
    80009764:	97ba                	add	a5,a5,a4
    80009766:	0007a423          	sw	zero,8(a5) # 2008 <_entry-0x7fffdff8>
  disk.desc[i].flags = 0;
    8000976a:	0049d717          	auipc	a4,0x49d
    8000976e:	89670713          	addi	a4,a4,-1898 # 804a6000 <disk>
    80009772:	6789                	lui	a5,0x2
    80009774:	97ba                	add	a5,a5,a4
    80009776:	6398                	ld	a4,0(a5)
    80009778:	fec42783          	lw	a5,-20(s0)
    8000977c:	0792                	slli	a5,a5,0x4
    8000977e:	97ba                	add	a5,a5,a4
    80009780:	00079623          	sh	zero,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[i].next = 0;
    80009784:	0049d717          	auipc	a4,0x49d
    80009788:	87c70713          	addi	a4,a4,-1924 # 804a6000 <disk>
    8000978c:	6789                	lui	a5,0x2
    8000978e:	97ba                	add	a5,a5,a4
    80009790:	6398                	ld	a4,0(a5)
    80009792:	fec42783          	lw	a5,-20(s0)
    80009796:	0792                	slli	a5,a5,0x4
    80009798:	97ba                	add	a5,a5,a4
    8000979a:	00079723          	sh	zero,14(a5) # 200e <_entry-0x7fffdff2>
  disk.free[i] = 1;
    8000979e:	0049d717          	auipc	a4,0x49d
    800097a2:	86270713          	addi	a4,a4,-1950 # 804a6000 <disk>
    800097a6:	fec42783          	lw	a5,-20(s0)
    800097aa:	97ba                	add	a5,a5,a4
    800097ac:	6709                	lui	a4,0x2
    800097ae:	97ba                	add	a5,a5,a4
    800097b0:	4705                	li	a4,1
    800097b2:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    800097b6:	0049f517          	auipc	a0,0x49f
    800097ba:	86250513          	addi	a0,a0,-1950 # 804a8018 <disk+0x2018>
    800097be:	ffffa097          	auipc	ra,0xffffa
    800097c2:	1b2080e7          	jalr	434(ra) # 80003970 <wakeup>
}
    800097c6:	0001                	nop
    800097c8:	60e2                	ld	ra,24(sp)
    800097ca:	6442                	ld	s0,16(sp)
    800097cc:	6105                	addi	sp,sp,32
    800097ce:	8082                	ret

00000000800097d0 <free_chain>:

// free a chain of descriptors.
static void
free_chain(int i)
{
    800097d0:	7179                	addi	sp,sp,-48
    800097d2:	f406                	sd	ra,40(sp)
    800097d4:	f022                	sd	s0,32(sp)
    800097d6:	1800                	addi	s0,sp,48
    800097d8:	87aa                	mv	a5,a0
    800097da:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    int flag = disk.desc[i].flags;
    800097de:	0049d717          	auipc	a4,0x49d
    800097e2:	82270713          	addi	a4,a4,-2014 # 804a6000 <disk>
    800097e6:	6789                	lui	a5,0x2
    800097e8:	97ba                	add	a5,a5,a4
    800097ea:	6398                	ld	a4,0(a5)
    800097ec:	fdc42783          	lw	a5,-36(s0)
    800097f0:	0792                	slli	a5,a5,0x4
    800097f2:	97ba                	add	a5,a5,a4
    800097f4:	00c7d783          	lhu	a5,12(a5) # 200c <_entry-0x7fffdff4>
    800097f8:	fef42623          	sw	a5,-20(s0)
    int nxt = disk.desc[i].next;
    800097fc:	0049d717          	auipc	a4,0x49d
    80009800:	80470713          	addi	a4,a4,-2044 # 804a6000 <disk>
    80009804:	6789                	lui	a5,0x2
    80009806:	97ba                	add	a5,a5,a4
    80009808:	6398                	ld	a4,0(a5)
    8000980a:	fdc42783          	lw	a5,-36(s0)
    8000980e:	0792                	slli	a5,a5,0x4
    80009810:	97ba                	add	a5,a5,a4
    80009812:	00e7d783          	lhu	a5,14(a5) # 200e <_entry-0x7fffdff2>
    80009816:	fef42423          	sw	a5,-24(s0)
    free_desc(i);
    8000981a:	fdc42783          	lw	a5,-36(s0)
    8000981e:	853e                	mv	a0,a5
    80009820:	00000097          	auipc	ra,0x0
    80009824:	ec2080e7          	jalr	-318(ra) # 800096e2 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80009828:	fec42783          	lw	a5,-20(s0)
    8000982c:	8b85                	andi	a5,a5,1
    8000982e:	2781                	sext.w	a5,a5
    80009830:	c791                	beqz	a5,8000983c <free_chain+0x6c>
      i = nxt;
    80009832:	fe842783          	lw	a5,-24(s0)
    80009836:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    8000983a:	b755                	j	800097de <free_chain+0xe>
    else
      break;
    8000983c:	0001                	nop
  }
}
    8000983e:	0001                	nop
    80009840:	70a2                	ld	ra,40(sp)
    80009842:	7402                	ld	s0,32(sp)
    80009844:	6145                	addi	sp,sp,48
    80009846:	8082                	ret

0000000080009848 <alloc3_desc>:

// allocate three descriptors (they need not be contiguous).
// disk transfers always use three descriptors.
static int
alloc3_desc(int *idx)
{
    80009848:	7139                	addi	sp,sp,-64
    8000984a:	fc06                	sd	ra,56(sp)
    8000984c:	f822                	sd	s0,48(sp)
    8000984e:	f426                	sd	s1,40(sp)
    80009850:	0080                	addi	s0,sp,64
    80009852:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 3; i++){
    80009856:	fc042e23          	sw	zero,-36(s0)
    8000985a:	a89d                	j	800098d0 <alloc3_desc+0x88>
    idx[i] = alloc_desc();
    8000985c:	fdc42783          	lw	a5,-36(s0)
    80009860:	078a                	slli	a5,a5,0x2
    80009862:	fc843703          	ld	a4,-56(s0)
    80009866:	00f704b3          	add	s1,a4,a5
    8000986a:	00000097          	auipc	ra,0x0
    8000986e:	e16080e7          	jalr	-490(ra) # 80009680 <alloc_desc>
    80009872:	87aa                	mv	a5,a0
    80009874:	c09c                	sw	a5,0(s1)
    if(idx[i] < 0){
    80009876:	fdc42783          	lw	a5,-36(s0)
    8000987a:	078a                	slli	a5,a5,0x2
    8000987c:	fc843703          	ld	a4,-56(s0)
    80009880:	97ba                	add	a5,a5,a4
    80009882:	439c                	lw	a5,0(a5)
    80009884:	0407d163          	bgez	a5,800098c6 <alloc3_desc+0x7e>
      for(int j = 0; j < i; j++)
    80009888:	fc042c23          	sw	zero,-40(s0)
    8000988c:	a015                	j	800098b0 <alloc3_desc+0x68>
        free_desc(idx[j]);
    8000988e:	fd842783          	lw	a5,-40(s0)
    80009892:	078a                	slli	a5,a5,0x2
    80009894:	fc843703          	ld	a4,-56(s0)
    80009898:	97ba                	add	a5,a5,a4
    8000989a:	439c                	lw	a5,0(a5)
    8000989c:	853e                	mv	a0,a5
    8000989e:	00000097          	auipc	ra,0x0
    800098a2:	e44080e7          	jalr	-444(ra) # 800096e2 <free_desc>
      for(int j = 0; j < i; j++)
    800098a6:	fd842783          	lw	a5,-40(s0)
    800098aa:	2785                	addiw	a5,a5,1
    800098ac:	fcf42c23          	sw	a5,-40(s0)
    800098b0:	fd842783          	lw	a5,-40(s0)
    800098b4:	873e                	mv	a4,a5
    800098b6:	fdc42783          	lw	a5,-36(s0)
    800098ba:	2701                	sext.w	a4,a4
    800098bc:	2781                	sext.w	a5,a5
    800098be:	fcf748e3          	blt	a4,a5,8000988e <alloc3_desc+0x46>
      return -1;
    800098c2:	57fd                	li	a5,-1
    800098c4:	a831                	j	800098e0 <alloc3_desc+0x98>
  for(int i = 0; i < 3; i++){
    800098c6:	fdc42783          	lw	a5,-36(s0)
    800098ca:	2785                	addiw	a5,a5,1
    800098cc:	fcf42e23          	sw	a5,-36(s0)
    800098d0:	fdc42783          	lw	a5,-36(s0)
    800098d4:	0007871b          	sext.w	a4,a5
    800098d8:	4789                	li	a5,2
    800098da:	f8e7d1e3          	bge	a5,a4,8000985c <alloc3_desc+0x14>
    }
  }
  return 0;
    800098de:	4781                	li	a5,0
}
    800098e0:	853e                	mv	a0,a5
    800098e2:	70e2                	ld	ra,56(sp)
    800098e4:	7442                	ld	s0,48(sp)
    800098e6:	74a2                	ld	s1,40(sp)
    800098e8:	6121                	addi	sp,sp,64
    800098ea:	8082                	ret

00000000800098ec <virtio_disk_rw>:

void
virtio_disk_rw(struct buf *b, int write)
{
    800098ec:	7139                	addi	sp,sp,-64
    800098ee:	fc06                	sd	ra,56(sp)
    800098f0:	f822                	sd	s0,48(sp)
    800098f2:	0080                	addi	s0,sp,64
    800098f4:	fca43423          	sd	a0,-56(s0)
    800098f8:	87ae                	mv	a5,a1
    800098fa:	fcf42223          	sw	a5,-60(s0)
  uint64 sector = b->blockno * (BSIZE / 512);
    800098fe:	fc843783          	ld	a5,-56(s0)
    80009902:	47dc                	lw	a5,12(a5)
    80009904:	0017979b          	slliw	a5,a5,0x1
    80009908:	2781                	sext.w	a5,a5
    8000990a:	1782                	slli	a5,a5,0x20
    8000990c:	9381                	srli	a5,a5,0x20
    8000990e:	fef43423          	sd	a5,-24(s0)

  acquire(&disk.vdisk_lock);
    80009912:	0049f517          	auipc	a0,0x49f
    80009916:	81650513          	addi	a0,a0,-2026 # 804a8128 <disk+0x2128>
    8000991a:	ffff8097          	auipc	ra,0xffff8
    8000991e:	950080e7          	jalr	-1712(ra) # 8000126a <acquire>
  // data, one for a 1-byte status result.

  // allocate the three descriptors.
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
    80009922:	fd040793          	addi	a5,s0,-48
    80009926:	853e                	mv	a0,a5
    80009928:	00000097          	auipc	ra,0x0
    8000992c:	f20080e7          	jalr	-224(ra) # 80009848 <alloc3_desc>
    80009930:	87aa                	mv	a5,a0
    80009932:	cf91                	beqz	a5,8000994e <virtio_disk_rw+0x62>
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80009934:	0049e597          	auipc	a1,0x49e
    80009938:	7f458593          	addi	a1,a1,2036 # 804a8128 <disk+0x2128>
    8000993c:	0049e517          	auipc	a0,0x49e
    80009940:	6dc50513          	addi	a0,a0,1756 # 804a8018 <disk+0x2018>
    80009944:	ffffa097          	auipc	ra,0xffffa
    80009948:	fb0080e7          	jalr	-80(ra) # 800038f4 <sleep>
    if(alloc3_desc(idx) == 0) {
    8000994c:	bfd9                	j	80009922 <virtio_disk_rw+0x36>
      break;
    8000994e:	0001                	nop
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80009950:	fd042783          	lw	a5,-48(s0)
    80009954:	20078793          	addi	a5,a5,512
    80009958:	00479713          	slli	a4,a5,0x4
    8000995c:	0049c797          	auipc	a5,0x49c
    80009960:	6a478793          	addi	a5,a5,1700 # 804a6000 <disk>
    80009964:	97ba                	add	a5,a5,a4
    80009966:	0a878793          	addi	a5,a5,168
    8000996a:	fef43023          	sd	a5,-32(s0)

  if(write)
    8000996e:	fc442783          	lw	a5,-60(s0)
    80009972:	2781                	sext.w	a5,a5
    80009974:	c791                	beqz	a5,80009980 <virtio_disk_rw+0x94>
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80009976:	fe043783          	ld	a5,-32(s0)
    8000997a:	4705                	li	a4,1
    8000997c:	c398                	sw	a4,0(a5)
    8000997e:	a029                	j	80009988 <virtio_disk_rw+0x9c>
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    80009980:	fe043783          	ld	a5,-32(s0)
    80009984:	0007a023          	sw	zero,0(a5)
  buf0->reserved = 0;
    80009988:	fe043783          	ld	a5,-32(s0)
    8000998c:	0007a223          	sw	zero,4(a5)
  buf0->sector = sector;
    80009990:	fe043783          	ld	a5,-32(s0)
    80009994:	fe843703          	ld	a4,-24(s0)
    80009998:	e798                	sd	a4,8(a5)

  disk.desc[idx[0]].addr = (uint64) buf0;
    8000999a:	0049c717          	auipc	a4,0x49c
    8000999e:	66670713          	addi	a4,a4,1638 # 804a6000 <disk>
    800099a2:	6789                	lui	a5,0x2
    800099a4:	97ba                	add	a5,a5,a4
    800099a6:	6398                	ld	a4,0(a5)
    800099a8:	fd042783          	lw	a5,-48(s0)
    800099ac:	0792                	slli	a5,a5,0x4
    800099ae:	97ba                	add	a5,a5,a4
    800099b0:	fe043703          	ld	a4,-32(s0)
    800099b4:	e398                	sd	a4,0(a5)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800099b6:	0049c717          	auipc	a4,0x49c
    800099ba:	64a70713          	addi	a4,a4,1610 # 804a6000 <disk>
    800099be:	6789                	lui	a5,0x2
    800099c0:	97ba                	add	a5,a5,a4
    800099c2:	6398                	ld	a4,0(a5)
    800099c4:	fd042783          	lw	a5,-48(s0)
    800099c8:	0792                	slli	a5,a5,0x4
    800099ca:	97ba                	add	a5,a5,a4
    800099cc:	4741                	li	a4,16
    800099ce:	c798                	sw	a4,8(a5)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800099d0:	0049c717          	auipc	a4,0x49c
    800099d4:	63070713          	addi	a4,a4,1584 # 804a6000 <disk>
    800099d8:	6789                	lui	a5,0x2
    800099da:	97ba                	add	a5,a5,a4
    800099dc:	6398                	ld	a4,0(a5)
    800099de:	fd042783          	lw	a5,-48(s0)
    800099e2:	0792                	slli	a5,a5,0x4
    800099e4:	97ba                	add	a5,a5,a4
    800099e6:	4705                	li	a4,1
    800099e8:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[0]].next = idx[1];
    800099ec:	fd442683          	lw	a3,-44(s0)
    800099f0:	0049c717          	auipc	a4,0x49c
    800099f4:	61070713          	addi	a4,a4,1552 # 804a6000 <disk>
    800099f8:	6789                	lui	a5,0x2
    800099fa:	97ba                	add	a5,a5,a4
    800099fc:	6398                	ld	a4,0(a5)
    800099fe:	fd042783          	lw	a5,-48(s0)
    80009a02:	0792                	slli	a5,a5,0x4
    80009a04:	97ba                	add	a5,a5,a4
    80009a06:	03069713          	slli	a4,a3,0x30
    80009a0a:	9341                	srli	a4,a4,0x30
    80009a0c:	00e79723          	sh	a4,14(a5) # 200e <_entry-0x7fffdff2>

  disk.desc[idx[1]].addr = (uint64) b->data;
    80009a10:	fc843783          	ld	a5,-56(s0)
    80009a14:	05878693          	addi	a3,a5,88
    80009a18:	0049c717          	auipc	a4,0x49c
    80009a1c:	5e870713          	addi	a4,a4,1512 # 804a6000 <disk>
    80009a20:	6789                	lui	a5,0x2
    80009a22:	97ba                	add	a5,a5,a4
    80009a24:	6398                	ld	a4,0(a5)
    80009a26:	fd442783          	lw	a5,-44(s0)
    80009a2a:	0792                	slli	a5,a5,0x4
    80009a2c:	97ba                	add	a5,a5,a4
    80009a2e:	8736                	mv	a4,a3
    80009a30:	e398                	sd	a4,0(a5)
  disk.desc[idx[1]].len = BSIZE;
    80009a32:	0049c717          	auipc	a4,0x49c
    80009a36:	5ce70713          	addi	a4,a4,1486 # 804a6000 <disk>
    80009a3a:	6789                	lui	a5,0x2
    80009a3c:	97ba                	add	a5,a5,a4
    80009a3e:	6398                	ld	a4,0(a5)
    80009a40:	fd442783          	lw	a5,-44(s0)
    80009a44:	0792                	slli	a5,a5,0x4
    80009a46:	97ba                	add	a5,a5,a4
    80009a48:	40000713          	li	a4,1024
    80009a4c:	c798                	sw	a4,8(a5)
  if(write)
    80009a4e:	fc442783          	lw	a5,-60(s0)
    80009a52:	2781                	sext.w	a5,a5
    80009a54:	cf99                	beqz	a5,80009a72 <virtio_disk_rw+0x186>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80009a56:	0049c717          	auipc	a4,0x49c
    80009a5a:	5aa70713          	addi	a4,a4,1450 # 804a6000 <disk>
    80009a5e:	6789                	lui	a5,0x2
    80009a60:	97ba                	add	a5,a5,a4
    80009a62:	6398                	ld	a4,0(a5)
    80009a64:	fd442783          	lw	a5,-44(s0)
    80009a68:	0792                	slli	a5,a5,0x4
    80009a6a:	97ba                	add	a5,a5,a4
    80009a6c:	00079623          	sh	zero,12(a5) # 200c <_entry-0x7fffdff4>
    80009a70:	a839                	j	80009a8e <virtio_disk_rw+0x1a2>
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80009a72:	0049c717          	auipc	a4,0x49c
    80009a76:	58e70713          	addi	a4,a4,1422 # 804a6000 <disk>
    80009a7a:	6789                	lui	a5,0x2
    80009a7c:	97ba                	add	a5,a5,a4
    80009a7e:	6398                	ld	a4,0(a5)
    80009a80:	fd442783          	lw	a5,-44(s0)
    80009a84:	0792                	slli	a5,a5,0x4
    80009a86:	97ba                	add	a5,a5,a4
    80009a88:	4709                	li	a4,2
    80009a8a:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80009a8e:	0049c717          	auipc	a4,0x49c
    80009a92:	57270713          	addi	a4,a4,1394 # 804a6000 <disk>
    80009a96:	6789                	lui	a5,0x2
    80009a98:	97ba                	add	a5,a5,a4
    80009a9a:	6398                	ld	a4,0(a5)
    80009a9c:	fd442783          	lw	a5,-44(s0)
    80009aa0:	0792                	slli	a5,a5,0x4
    80009aa2:	97ba                	add	a5,a5,a4
    80009aa4:	00c7d703          	lhu	a4,12(a5) # 200c <_entry-0x7fffdff4>
    80009aa8:	0049c697          	auipc	a3,0x49c
    80009aac:	55868693          	addi	a3,a3,1368 # 804a6000 <disk>
    80009ab0:	6789                	lui	a5,0x2
    80009ab2:	97b6                	add	a5,a5,a3
    80009ab4:	6394                	ld	a3,0(a5)
    80009ab6:	fd442783          	lw	a5,-44(s0)
    80009aba:	0792                	slli	a5,a5,0x4
    80009abc:	97b6                	add	a5,a5,a3
    80009abe:	00176713          	ori	a4,a4,1
    80009ac2:	1742                	slli	a4,a4,0x30
    80009ac4:	9341                	srli	a4,a4,0x30
    80009ac6:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[1]].next = idx[2];
    80009aca:	fd842683          	lw	a3,-40(s0)
    80009ace:	0049c717          	auipc	a4,0x49c
    80009ad2:	53270713          	addi	a4,a4,1330 # 804a6000 <disk>
    80009ad6:	6789                	lui	a5,0x2
    80009ad8:	97ba                	add	a5,a5,a4
    80009ada:	6398                	ld	a4,0(a5)
    80009adc:	fd442783          	lw	a5,-44(s0)
    80009ae0:	0792                	slli	a5,a5,0x4
    80009ae2:	97ba                	add	a5,a5,a4
    80009ae4:	03069713          	slli	a4,a3,0x30
    80009ae8:	9341                	srli	a4,a4,0x30
    80009aea:	00e79723          	sh	a4,14(a5) # 200e <_entry-0x7fffdff2>

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80009aee:	fd042783          	lw	a5,-48(s0)
    80009af2:	0049c717          	auipc	a4,0x49c
    80009af6:	50e70713          	addi	a4,a4,1294 # 804a6000 <disk>
    80009afa:	20078793          	addi	a5,a5,512
    80009afe:	0792                	slli	a5,a5,0x4
    80009b00:	97ba                	add	a5,a5,a4
    80009b02:	577d                	li	a4,-1
    80009b04:	02e78823          	sb	a4,48(a5)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80009b08:	fd042783          	lw	a5,-48(s0)
    80009b0c:	20078793          	addi	a5,a5,512
    80009b10:	00479713          	slli	a4,a5,0x4
    80009b14:	0049c797          	auipc	a5,0x49c
    80009b18:	4ec78793          	addi	a5,a5,1260 # 804a6000 <disk>
    80009b1c:	97ba                	add	a5,a5,a4
    80009b1e:	03078693          	addi	a3,a5,48
    80009b22:	0049c717          	auipc	a4,0x49c
    80009b26:	4de70713          	addi	a4,a4,1246 # 804a6000 <disk>
    80009b2a:	6789                	lui	a5,0x2
    80009b2c:	97ba                	add	a5,a5,a4
    80009b2e:	6398                	ld	a4,0(a5)
    80009b30:	fd842783          	lw	a5,-40(s0)
    80009b34:	0792                	slli	a5,a5,0x4
    80009b36:	97ba                	add	a5,a5,a4
    80009b38:	8736                	mv	a4,a3
    80009b3a:	e398                	sd	a4,0(a5)
  disk.desc[idx[2]].len = 1;
    80009b3c:	0049c717          	auipc	a4,0x49c
    80009b40:	4c470713          	addi	a4,a4,1220 # 804a6000 <disk>
    80009b44:	6789                	lui	a5,0x2
    80009b46:	97ba                	add	a5,a5,a4
    80009b48:	6398                	ld	a4,0(a5)
    80009b4a:	fd842783          	lw	a5,-40(s0)
    80009b4e:	0792                	slli	a5,a5,0x4
    80009b50:	97ba                	add	a5,a5,a4
    80009b52:	4705                	li	a4,1
    80009b54:	c798                	sw	a4,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80009b56:	0049c717          	auipc	a4,0x49c
    80009b5a:	4aa70713          	addi	a4,a4,1194 # 804a6000 <disk>
    80009b5e:	6789                	lui	a5,0x2
    80009b60:	97ba                	add	a5,a5,a4
    80009b62:	6398                	ld	a4,0(a5)
    80009b64:	fd842783          	lw	a5,-40(s0)
    80009b68:	0792                	slli	a5,a5,0x4
    80009b6a:	97ba                	add	a5,a5,a4
    80009b6c:	4709                	li	a4,2
    80009b6e:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[2]].next = 0;
    80009b72:	0049c717          	auipc	a4,0x49c
    80009b76:	48e70713          	addi	a4,a4,1166 # 804a6000 <disk>
    80009b7a:	6789                	lui	a5,0x2
    80009b7c:	97ba                	add	a5,a5,a4
    80009b7e:	6398                	ld	a4,0(a5)
    80009b80:	fd842783          	lw	a5,-40(s0)
    80009b84:	0792                	slli	a5,a5,0x4
    80009b86:	97ba                	add	a5,a5,a4
    80009b88:	00079723          	sh	zero,14(a5) # 200e <_entry-0x7fffdff2>

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80009b8c:	fc843783          	ld	a5,-56(s0)
    80009b90:	4705                	li	a4,1
    80009b92:	c3d8                	sw	a4,4(a5)
  disk.info[idx[0]].b = b;
    80009b94:	fd042783          	lw	a5,-48(s0)
    80009b98:	0049c717          	auipc	a4,0x49c
    80009b9c:	46870713          	addi	a4,a4,1128 # 804a6000 <disk>
    80009ba0:	20078793          	addi	a5,a5,512
    80009ba4:	0792                	slli	a5,a5,0x4
    80009ba6:	97ba                	add	a5,a5,a4
    80009ba8:	fc843703          	ld	a4,-56(s0)
    80009bac:	f798                	sd	a4,40(a5)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80009bae:	fd042603          	lw	a2,-48(s0)
    80009bb2:	0049c717          	auipc	a4,0x49c
    80009bb6:	44e70713          	addi	a4,a4,1102 # 804a6000 <disk>
    80009bba:	6789                	lui	a5,0x2
    80009bbc:	97ba                	add	a5,a5,a4
    80009bbe:	6794                	ld	a3,8(a5)
    80009bc0:	0049c717          	auipc	a4,0x49c
    80009bc4:	44070713          	addi	a4,a4,1088 # 804a6000 <disk>
    80009bc8:	6789                	lui	a5,0x2
    80009bca:	97ba                	add	a5,a5,a4
    80009bcc:	679c                	ld	a5,8(a5)
    80009bce:	0027d783          	lhu	a5,2(a5) # 2002 <_entry-0x7fffdffe>
    80009bd2:	2781                	sext.w	a5,a5
    80009bd4:	8b9d                	andi	a5,a5,7
    80009bd6:	2781                	sext.w	a5,a5
    80009bd8:	03061713          	slli	a4,a2,0x30
    80009bdc:	9341                	srli	a4,a4,0x30
    80009bde:	0786                	slli	a5,a5,0x1
    80009be0:	97b6                	add	a5,a5,a3
    80009be2:	00e79223          	sh	a4,4(a5)

  __sync_synchronize();
    80009be6:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80009bea:	0049c717          	auipc	a4,0x49c
    80009bee:	41670713          	addi	a4,a4,1046 # 804a6000 <disk>
    80009bf2:	6789                	lui	a5,0x2
    80009bf4:	97ba                	add	a5,a5,a4
    80009bf6:	679c                	ld	a5,8(a5)
    80009bf8:	0027d703          	lhu	a4,2(a5) # 2002 <_entry-0x7fffdffe>
    80009bfc:	0049c697          	auipc	a3,0x49c
    80009c00:	40468693          	addi	a3,a3,1028 # 804a6000 <disk>
    80009c04:	6789                	lui	a5,0x2
    80009c06:	97b6                	add	a5,a5,a3
    80009c08:	679c                	ld	a5,8(a5)
    80009c0a:	2705                	addiw	a4,a4,1
    80009c0c:	1742                	slli	a4,a4,0x30
    80009c0e:	9341                	srli	a4,a4,0x30
    80009c10:	00e79123          	sh	a4,2(a5) # 2002 <_entry-0x7fffdffe>

  __sync_synchronize();
    80009c14:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80009c18:	100017b7          	lui	a5,0x10001
    80009c1c:	05078793          	addi	a5,a5,80 # 10001050 <_entry-0x6fffefb0>
    80009c20:	0007a023          	sw	zero,0(a5)

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80009c24:	a819                	j	80009c3a <virtio_disk_rw+0x34e>
    sleep(b, &disk.vdisk_lock);
    80009c26:	0049e597          	auipc	a1,0x49e
    80009c2a:	50258593          	addi	a1,a1,1282 # 804a8128 <disk+0x2128>
    80009c2e:	fc843503          	ld	a0,-56(s0)
    80009c32:	ffffa097          	auipc	ra,0xffffa
    80009c36:	cc2080e7          	jalr	-830(ra) # 800038f4 <sleep>
  while(b->disk == 1) {
    80009c3a:	fc843783          	ld	a5,-56(s0)
    80009c3e:	43dc                	lw	a5,4(a5)
    80009c40:	873e                	mv	a4,a5
    80009c42:	4785                	li	a5,1
    80009c44:	fef701e3          	beq	a4,a5,80009c26 <virtio_disk_rw+0x33a>
  }

  disk.info[idx[0]].b = 0;
    80009c48:	fd042783          	lw	a5,-48(s0)
    80009c4c:	0049c717          	auipc	a4,0x49c
    80009c50:	3b470713          	addi	a4,a4,948 # 804a6000 <disk>
    80009c54:	20078793          	addi	a5,a5,512
    80009c58:	0792                	slli	a5,a5,0x4
    80009c5a:	97ba                	add	a5,a5,a4
    80009c5c:	0207b423          	sd	zero,40(a5)
  free_chain(idx[0]);
    80009c60:	fd042783          	lw	a5,-48(s0)
    80009c64:	853e                	mv	a0,a5
    80009c66:	00000097          	auipc	ra,0x0
    80009c6a:	b6a080e7          	jalr	-1174(ra) # 800097d0 <free_chain>

  release(&disk.vdisk_lock);
    80009c6e:	0049e517          	auipc	a0,0x49e
    80009c72:	4ba50513          	addi	a0,a0,1210 # 804a8128 <disk+0x2128>
    80009c76:	ffff7097          	auipc	ra,0xffff7
    80009c7a:	658080e7          	jalr	1624(ra) # 800012ce <release>
}
    80009c7e:	0001                	nop
    80009c80:	70e2                	ld	ra,56(sp)
    80009c82:	7442                	ld	s0,48(sp)
    80009c84:	6121                	addi	sp,sp,64
    80009c86:	8082                	ret

0000000080009c88 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80009c88:	1101                	addi	sp,sp,-32
    80009c8a:	ec06                	sd	ra,24(sp)
    80009c8c:	e822                	sd	s0,16(sp)
    80009c8e:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80009c90:	0049e517          	auipc	a0,0x49e
    80009c94:	49850513          	addi	a0,a0,1176 # 804a8128 <disk+0x2128>
    80009c98:	ffff7097          	auipc	ra,0xffff7
    80009c9c:	5d2080e7          	jalr	1490(ra) # 8000126a <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80009ca0:	100017b7          	lui	a5,0x10001
    80009ca4:	06078793          	addi	a5,a5,96 # 10001060 <_entry-0x6fffefa0>
    80009ca8:	439c                	lw	a5,0(a5)
    80009caa:	0007871b          	sext.w	a4,a5
    80009cae:	100017b7          	lui	a5,0x10001
    80009cb2:	06478793          	addi	a5,a5,100 # 10001064 <_entry-0x6fffef9c>
    80009cb6:	8b0d                	andi	a4,a4,3
    80009cb8:	2701                	sext.w	a4,a4
    80009cba:	c398                	sw	a4,0(a5)

  __sync_synchronize();
    80009cbc:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80009cc0:	a855                	j	80009d74 <virtio_disk_intr+0xec>
    __sync_synchronize();
    80009cc2:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80009cc6:	0049c717          	auipc	a4,0x49c
    80009cca:	33a70713          	addi	a4,a4,826 # 804a6000 <disk>
    80009cce:	6789                	lui	a5,0x2
    80009cd0:	97ba                	add	a5,a5,a4
    80009cd2:	6b98                	ld	a4,16(a5)
    80009cd4:	0049c697          	auipc	a3,0x49c
    80009cd8:	32c68693          	addi	a3,a3,812 # 804a6000 <disk>
    80009cdc:	6789                	lui	a5,0x2
    80009cde:	97b6                	add	a5,a5,a3
    80009ce0:	0207d783          	lhu	a5,32(a5) # 2020 <_entry-0x7fffdfe0>
    80009ce4:	2781                	sext.w	a5,a5
    80009ce6:	8b9d                	andi	a5,a5,7
    80009ce8:	2781                	sext.w	a5,a5
    80009cea:	078e                	slli	a5,a5,0x3
    80009cec:	97ba                	add	a5,a5,a4
    80009cee:	43dc                	lw	a5,4(a5)
    80009cf0:	fef42623          	sw	a5,-20(s0)

    if(disk.info[id].status != 0)
    80009cf4:	0049c717          	auipc	a4,0x49c
    80009cf8:	30c70713          	addi	a4,a4,780 # 804a6000 <disk>
    80009cfc:	fec42783          	lw	a5,-20(s0)
    80009d00:	20078793          	addi	a5,a5,512
    80009d04:	0792                	slli	a5,a5,0x4
    80009d06:	97ba                	add	a5,a5,a4
    80009d08:	0307c783          	lbu	a5,48(a5)
    80009d0c:	cb89                	beqz	a5,80009d1e <virtio_disk_intr+0x96>
      panic("virtio_disk_intr status");
    80009d0e:	00002517          	auipc	a0,0x2
    80009d12:	ba250513          	addi	a0,a0,-1118 # 8000b8b0 <etext+0x8b0>
    80009d16:	ffff7097          	auipc	ra,0xffff7
    80009d1a:	f64080e7          	jalr	-156(ra) # 80000c7a <panic>

    struct buf *b = disk.info[id].b;
    80009d1e:	0049c717          	auipc	a4,0x49c
    80009d22:	2e270713          	addi	a4,a4,738 # 804a6000 <disk>
    80009d26:	fec42783          	lw	a5,-20(s0)
    80009d2a:	20078793          	addi	a5,a5,512
    80009d2e:	0792                	slli	a5,a5,0x4
    80009d30:	97ba                	add	a5,a5,a4
    80009d32:	779c                	ld	a5,40(a5)
    80009d34:	fef43023          	sd	a5,-32(s0)
    b->disk = 0;   // disk is done with buf
    80009d38:	fe043783          	ld	a5,-32(s0)
    80009d3c:	0007a223          	sw	zero,4(a5)
    wakeup(b);
    80009d40:	fe043503          	ld	a0,-32(s0)
    80009d44:	ffffa097          	auipc	ra,0xffffa
    80009d48:	c2c080e7          	jalr	-980(ra) # 80003970 <wakeup>

    disk.used_idx += 1;
    80009d4c:	0049c717          	auipc	a4,0x49c
    80009d50:	2b470713          	addi	a4,a4,692 # 804a6000 <disk>
    80009d54:	6789                	lui	a5,0x2
    80009d56:	97ba                	add	a5,a5,a4
    80009d58:	0207d783          	lhu	a5,32(a5) # 2020 <_entry-0x7fffdfe0>
    80009d5c:	2785                	addiw	a5,a5,1
    80009d5e:	03079713          	slli	a4,a5,0x30
    80009d62:	9341                	srli	a4,a4,0x30
    80009d64:	0049c697          	auipc	a3,0x49c
    80009d68:	29c68693          	addi	a3,a3,668 # 804a6000 <disk>
    80009d6c:	6789                	lui	a5,0x2
    80009d6e:	97b6                	add	a5,a5,a3
    80009d70:	02e79023          	sh	a4,32(a5) # 2020 <_entry-0x7fffdfe0>
  while(disk.used_idx != disk.used->idx){
    80009d74:	0049c717          	auipc	a4,0x49c
    80009d78:	28c70713          	addi	a4,a4,652 # 804a6000 <disk>
    80009d7c:	6789                	lui	a5,0x2
    80009d7e:	97ba                	add	a5,a5,a4
    80009d80:	0207d683          	lhu	a3,32(a5) # 2020 <_entry-0x7fffdfe0>
    80009d84:	0049c717          	auipc	a4,0x49c
    80009d88:	27c70713          	addi	a4,a4,636 # 804a6000 <disk>
    80009d8c:	6789                	lui	a5,0x2
    80009d8e:	97ba                	add	a5,a5,a4
    80009d90:	6b9c                	ld	a5,16(a5)
    80009d92:	0027d783          	lhu	a5,2(a5) # 2002 <_entry-0x7fffdffe>
    80009d96:	0006871b          	sext.w	a4,a3
    80009d9a:	2781                	sext.w	a5,a5
    80009d9c:	f2f713e3          	bne	a4,a5,80009cc2 <virtio_disk_intr+0x3a>
  }

  release(&disk.vdisk_lock);
    80009da0:	0049e517          	auipc	a0,0x49e
    80009da4:	38850513          	addi	a0,a0,904 # 804a8128 <disk+0x2128>
    80009da8:	ffff7097          	auipc	ra,0xffff7
    80009dac:	526080e7          	jalr	1318(ra) # 800012ce <release>
}
    80009db0:	0001                	nop
    80009db2:	60e2                	ld	ra,24(sp)
    80009db4:	6442                	ld	s0,16(sp)
    80009db6:	6105                	addi	sp,sp,32
    80009db8:	8082                	ret
	...

000000008000a000 <_trampoline>:
    8000a000:	14051573          	csrrw	a0,sscratch,a0
    8000a004:	02153423          	sd	ra,40(a0)
    8000a008:	02253823          	sd	sp,48(a0)
    8000a00c:	02353c23          	sd	gp,56(a0)
    8000a010:	04453023          	sd	tp,64(a0)
    8000a014:	04553423          	sd	t0,72(a0)
    8000a018:	04653823          	sd	t1,80(a0)
    8000a01c:	04753c23          	sd	t2,88(a0)
    8000a020:	f120                	sd	s0,96(a0)
    8000a022:	f524                	sd	s1,104(a0)
    8000a024:	fd2c                	sd	a1,120(a0)
    8000a026:	e150                	sd	a2,128(a0)
    8000a028:	e554                	sd	a3,136(a0)
    8000a02a:	e958                	sd	a4,144(a0)
    8000a02c:	ed5c                	sd	a5,152(a0)
    8000a02e:	0b053023          	sd	a6,160(a0)
    8000a032:	0b153423          	sd	a7,168(a0)
    8000a036:	0b253823          	sd	s2,176(a0)
    8000a03a:	0b353c23          	sd	s3,184(a0)
    8000a03e:	0d453023          	sd	s4,192(a0)
    8000a042:	0d553423          	sd	s5,200(a0)
    8000a046:	0d653823          	sd	s6,208(a0)
    8000a04a:	0d753c23          	sd	s7,216(a0)
    8000a04e:	0f853023          	sd	s8,224(a0)
    8000a052:	0f953423          	sd	s9,232(a0)
    8000a056:	0fa53823          	sd	s10,240(a0)
    8000a05a:	0fb53c23          	sd	s11,248(a0)
    8000a05e:	11c53023          	sd	t3,256(a0)
    8000a062:	11d53423          	sd	t4,264(a0)
    8000a066:	11e53823          	sd	t5,272(a0)
    8000a06a:	11f53c23          	sd	t6,280(a0)
    8000a06e:	140022f3          	csrr	t0,sscratch
    8000a072:	06553823          	sd	t0,112(a0)
    8000a076:	00853103          	ld	sp,8(a0)
    8000a07a:	02053203          	ld	tp,32(a0)
    8000a07e:	01053283          	ld	t0,16(a0)
    8000a082:	00053303          	ld	t1,0(a0)
    8000a086:	18031073          	csrw	satp,t1
    8000a08a:	12000073          	sfence.vma
    8000a08e:	8282                	jr	t0

000000008000a090 <userret>:
    8000a090:	18059073          	csrw	satp,a1
    8000a094:	12000073          	sfence.vma
    8000a098:	07053283          	ld	t0,112(a0)
    8000a09c:	14029073          	csrw	sscratch,t0
    8000a0a0:	02853083          	ld	ra,40(a0)
    8000a0a4:	03053103          	ld	sp,48(a0)
    8000a0a8:	03853183          	ld	gp,56(a0)
    8000a0ac:	04053203          	ld	tp,64(a0)
    8000a0b0:	04853283          	ld	t0,72(a0)
    8000a0b4:	05053303          	ld	t1,80(a0)
    8000a0b8:	05853383          	ld	t2,88(a0)
    8000a0bc:	7120                	ld	s0,96(a0)
    8000a0be:	7524                	ld	s1,104(a0)
    8000a0c0:	7d2c                	ld	a1,120(a0)
    8000a0c2:	6150                	ld	a2,128(a0)
    8000a0c4:	6554                	ld	a3,136(a0)
    8000a0c6:	6958                	ld	a4,144(a0)
    8000a0c8:	6d5c                	ld	a5,152(a0)
    8000a0ca:	0a053803          	ld	a6,160(a0)
    8000a0ce:	0a853883          	ld	a7,168(a0)
    8000a0d2:	0b053903          	ld	s2,176(a0)
    8000a0d6:	0b853983          	ld	s3,184(a0)
    8000a0da:	0c053a03          	ld	s4,192(a0)
    8000a0de:	0c853a83          	ld	s5,200(a0)
    8000a0e2:	0d053b03          	ld	s6,208(a0)
    8000a0e6:	0d853b83          	ld	s7,216(a0)
    8000a0ea:	0e053c03          	ld	s8,224(a0)
    8000a0ee:	0e853c83          	ld	s9,232(a0)
    8000a0f2:	0f053d03          	ld	s10,240(a0)
    8000a0f6:	0f853d83          	ld	s11,248(a0)
    8000a0fa:	10053e03          	ld	t3,256(a0)
    8000a0fe:	10853e83          	ld	t4,264(a0)
    8000a102:	11053f03          	ld	t5,272(a0)
    8000a106:	11853f83          	ld	t6,280(a0)
    8000a10a:	14051573          	csrrw	a0,sscratch,a0
    8000a10e:	10200073          	sret
	...
