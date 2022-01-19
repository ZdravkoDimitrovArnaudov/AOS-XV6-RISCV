
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
    8000032c:	17878793          	addi	a5,a5,376 # 800094a0 <timervec>
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
    8000040a:	748080e7          	jalr	1864(ra) # 80003b4e <either_copyin>
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
    800004c0:	466080e7          	jalr	1126(ra) # 80003922 <sleep>
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
    8000057c:	562080e7          	jalr	1378(ra) # 80003ada <either_copyout>
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
    80000666:	560080e7          	jalr	1376(ra) # 80003bc2 <procdump>
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
    8000082a:	178080e7          	jalr	376(ra) # 8000399e <wakeup>
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
    80000dda:	b4c080e7          	jalr	-1204(ra) # 80003922 <sleep>
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
    80000f18:	a8a080e7          	jalr	-1398(ra) # 8000399e <wakeup>
    
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
    8000186c:	c56080e7          	jalr	-938(ra) # 800044be <trapinit>
    trapinithart();  // install kernel trap vector
    80001870:	00003097          	auipc	ra,0x3
    80001874:	c78080e7          	jalr	-904(ra) # 800044e8 <trapinithart>
    plicinit();      // set up interrupt controller
    80001878:	00008097          	auipc	ra,0x8
    8000187c:	c52080e7          	jalr	-942(ra) # 800094ca <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80001880:	00008097          	auipc	ra,0x8
    80001884:	c6e080e7          	jalr	-914(ra) # 800094ee <plicinithart>
    binit();         // buffer cache
    80001888:	00004097          	auipc	ra,0x4
    8000188c:	882080e7          	jalr	-1918(ra) # 8000510a <binit>
    iinit();         // inode table
    80001890:	00004097          	auipc	ra,0x4
    80001894:	0b6080e7          	jalr	182(ra) # 80005946 <iinit>
    fileinit();      // file table
    80001898:	00006097          	auipc	ra,0x6
    8000189c:	a66080e7          	jalr	-1434(ra) # 800072fe <fileinit>
    virtio_disk_init(); // emulated hard disk
    800018a0:	00008097          	auipc	ra,0x8
    800018a4:	d22080e7          	jalr	-734(ra) # 800095c2 <virtio_disk_init>
    userinit();      // first user process
    800018a8:	00001097          	auipc	ra,0x1
    800018ac:	64c080e7          	jalr	1612(ra) # 80002ef4 <userinit>
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
    800018fe:	bee080e7          	jalr	-1042(ra) # 800044e8 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80001902:	00008097          	auipc	ra,0x8
    80001906:	bec080e7          	jalr	-1044(ra) # 800094ee <plicinithart>
  }

  scheduler();        
    8000190a:	00002097          	auipc	ra,0x2
    8000190e:	de8080e7          	jalr	-536(ra) # 800036f2 <scheduler>

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
    80002b0e:	a211                	j	80002c12 <allocproc+0x160>
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
  p->ASID = p->pid;
    80002b2c:	fe843783          	ld	a5,-24(s0)
    80002b30:	5b98                	lw	a4,48(a5)
    80002b32:	fe843783          	ld	a5,-24(s0)
    80002b36:	dbd8                	sw	a4,52(a5)


  //inicializamos campos nuevos
  p->bottom_ustack = 0;
    80002b38:	fe843703          	ld	a4,-24(s0)
    80002b3c:	6789                	lui	a5,0x2
    80002b3e:	97ba                	add	a5,a5,a4
    80002b40:	1807b023          	sd	zero,384(a5) # 2180 <_entry-0x7fffde80>
  p->top_ustack = 0;  
    80002b44:	fe843703          	ld	a4,-24(s0)
    80002b48:	6789                	lui	a5,0x2
    80002b4a:	97ba                	add	a5,a5,a4
    80002b4c:	1607bc23          	sd	zero,376(a5) # 2178 <_entry-0x7fffde88>
  p->referencias = 0;
    80002b50:	fe843703          	ld	a4,-24(s0)
    80002b54:	67c9                	lui	a5,0x12
    80002b56:	97ba                	add	a5,a5,a4
    80002b58:	1807a623          	sw	zero,396(a5) # 1218c <_entry-0x7ffede74>
  p->thread = 0;
    80002b5c:	fe843703          	ld	a4,-24(s0)
    80002b60:	67c9                	lui	a5,0x12
    80002b62:	97ba                	add	a5,a5,a4
    80002b64:	1807a423          	sw	zero,392(a5) # 12188 <_entry-0x7ffede78>


  // Allocate a trapframe page. Se alocata para el trapframe privado
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80002b68:	ffffe097          	auipc	ra,0xffffe
    80002b6c:	5ae080e7          	jalr	1454(ra) # 80001116 <kalloc>
    80002b70:	872a                	mv	a4,a0
    80002b72:	fe843783          	ld	a5,-24(s0)
    80002b76:	f3b8                	sd	a4,96(a5)
    80002b78:	fe843783          	ld	a5,-24(s0)
    80002b7c:	73bc                	ld	a5,96(a5)
    80002b7e:	e385                	bnez	a5,80002b9e <allocproc+0xec>
    freeproc(p);
    80002b80:	fe843503          	ld	a0,-24(s0)
    80002b84:	00000097          	auipc	ra,0x0
    80002b88:	098080e7          	jalr	152(ra) # 80002c1c <freeproc>
    release(&p->lock);
    80002b8c:	fe843783          	ld	a5,-24(s0)
    80002b90:	853e                	mv	a0,a5
    80002b92:	ffffe097          	auipc	ra,0xffffe
    80002b96:	73c080e7          	jalr	1852(ra) # 800012ce <release>
    return 0;
    80002b9a:	4781                	li	a5,0
    80002b9c:	a89d                	j	80002c12 <allocproc+0x160>
  }

  // An empty user page table.
  p->pagetable = proc_pagetable(p);
    80002b9e:	fe843503          	ld	a0,-24(s0)
    80002ba2:	00000097          	auipc	ra,0x0
    80002ba6:	234080e7          	jalr	564(ra) # 80002dd6 <proc_pagetable>
    80002baa:	872a                	mv	a4,a0
    80002bac:	fe843783          	ld	a5,-24(s0)
    80002bb0:	ebb8                	sd	a4,80(a5)
  if(p->pagetable == 0){
    80002bb2:	fe843783          	ld	a5,-24(s0)
    80002bb6:	6bbc                	ld	a5,80(a5)
    80002bb8:	e385                	bnez	a5,80002bd8 <allocproc+0x126>
    freeproc(p);
    80002bba:	fe843503          	ld	a0,-24(s0)
    80002bbe:	00000097          	auipc	ra,0x0
    80002bc2:	05e080e7          	jalr	94(ra) # 80002c1c <freeproc>
    release(&p->lock);
    80002bc6:	fe843783          	ld	a5,-24(s0)
    80002bca:	853e                	mv	a0,a5
    80002bcc:	ffffe097          	auipc	ra,0xffffe
    80002bd0:	702080e7          	jalr	1794(ra) # 800012ce <release>
    return 0;
    80002bd4:	4781                	li	a5,0
    80002bd6:	a835                	j	80002c12 <allocproc+0x160>
  }

  // Set up new context to start executing at forkret,
  // which returns to user space.
  memset(&p->context, 0, sizeof(p->context));
    80002bd8:	fe843783          	ld	a5,-24(s0)
    80002bdc:	07078793          	addi	a5,a5,112
    80002be0:	07000613          	li	a2,112
    80002be4:	4581                	li	a1,0
    80002be6:	853e                	mv	a0,a5
    80002be8:	fffff097          	auipc	ra,0xfffff
    80002bec:	856080e7          	jalr	-1962(ra) # 8000143e <memset>
  p->context.ra = (uint64)forkret;
    80002bf0:	00001717          	auipc	a4,0x1
    80002bf4:	ce270713          	addi	a4,a4,-798 # 800038d2 <forkret>
    80002bf8:	fe843783          	ld	a5,-24(s0)
    80002bfc:	fbb8                	sd	a4,112(a5)
  p->context.sp = p->kstack + PGSIZE;
    80002bfe:	fe843783          	ld	a5,-24(s0)
    80002c02:	63b8                	ld	a4,64(a5)
    80002c04:	6785                	lui	a5,0x1
    80002c06:	973e                	add	a4,a4,a5
    80002c08:	fe843783          	ld	a5,-24(s0)
    80002c0c:	ffb8                	sd	a4,120(a5)

  return p;
    80002c0e:	fe843783          	ld	a5,-24(s0)
}
    80002c12:	853e                	mv	a0,a5
    80002c14:	60e2                	ld	ra,24(sp)
    80002c16:	6442                	ld	s0,16(sp)
    80002c18:	6105                	addi	sp,sp,32
    80002c1a:	8082                	ret

0000000080002c1c <freeproc>:
// free a proc structure and the data hanging from it,
// including user pages.
// p->lock must be held.
static void
freeproc(struct proc *p)
{
    80002c1c:	1101                	addi	sp,sp,-32
    80002c1e:	ec06                	sd	ra,24(sp)
    80002c20:	e822                	sd	s0,16(sp)
    80002c22:	1000                	addi	s0,sp,32
    80002c24:	fea43423          	sd	a0,-24(s0)
  if(p->trapframe)
    80002c28:	fe843783          	ld	a5,-24(s0)
    80002c2c:	73bc                	ld	a5,96(a5)
    80002c2e:	cb89                	beqz	a5,80002c40 <freeproc+0x24>
    kfree((void*)p->trapframe);
    80002c30:	fe843783          	ld	a5,-24(s0)
    80002c34:	73bc                	ld	a5,96(a5)
    80002c36:	853e                	mv	a0,a5
    80002c38:	ffffe097          	auipc	ra,0xffffe
    80002c3c:	43a080e7          	jalr	1082(ra) # 80001072 <kfree>
  p->trapframe = 0;
    80002c40:	fe843783          	ld	a5,-24(s0)
    80002c44:	0607b023          	sd	zero,96(a5) # 1060 <_entry-0x7fffefa0>
  if(p->pagetable)
    80002c48:	fe843783          	ld	a5,-24(s0)
    80002c4c:	6bbc                	ld	a5,80(a5)
    80002c4e:	cf89                	beqz	a5,80002c68 <freeproc+0x4c>
    proc_freepagetable(p->pagetable, p->sz);
    80002c50:	fe843783          	ld	a5,-24(s0)
    80002c54:	6bb8                	ld	a4,80(a5)
    80002c56:	fe843783          	ld	a5,-24(s0)
    80002c5a:	67bc                	ld	a5,72(a5)
    80002c5c:	85be                	mv	a1,a5
    80002c5e:	853a                	mv	a0,a4
    80002c60:	00000097          	auipc	ra,0x0
    80002c64:	236080e7          	jalr	566(ra) # 80002e96 <proc_freepagetable>
  p->pagetable = 0;
    80002c68:	fe843783          	ld	a5,-24(s0)
    80002c6c:	0407b823          	sd	zero,80(a5)
  p->sz = 0;
    80002c70:	fe843783          	ld	a5,-24(s0)
    80002c74:	0407b423          	sd	zero,72(a5)
  p->pid = 0;
    80002c78:	fe843783          	ld	a5,-24(s0)
    80002c7c:	0207a823          	sw	zero,48(a5)
  p->parent = 0;
    80002c80:	fe843783          	ld	a5,-24(s0)
    80002c84:	0207bc23          	sd	zero,56(a5)
  p->name[0] = 0;
    80002c88:	fe843783          	ld	a5,-24(s0)
    80002c8c:	16078423          	sb	zero,360(a5)
  p->chan = 0;
    80002c90:	fe843783          	ld	a5,-24(s0)
    80002c94:	0207b023          	sd	zero,32(a5)
  p->killed = 0;
    80002c98:	fe843783          	ld	a5,-24(s0)
    80002c9c:	0207a423          	sw	zero,40(a5)
  p->xstate = 0;
    80002ca0:	fe843783          	ld	a5,-24(s0)
    80002ca4:	0207a623          	sw	zero,44(a5)
  p->state = UNUSED;
    80002ca8:	fe843783          	ld	a5,-24(s0)
    80002cac:	0007ac23          	sw	zero,24(a5)
}
    80002cb0:	0001                	nop
    80002cb2:	60e2                	ld	ra,24(sp)
    80002cb4:	6442                	ld	s0,16(sp)
    80002cb6:	6105                	addi	sp,sp,32
    80002cb8:	8082                	ret

0000000080002cba <freethread>:


static void
freethread(struct proc *p)
{
    80002cba:	1101                	addi	sp,sp,-32
    80002cbc:	ec06                	sd	ra,24(sp)
    80002cbe:	e822                	sd	s0,16(sp)
    80002cc0:	1000                	addi	s0,sp,32
    80002cc2:	fea43423          	sd	a0,-24(s0)
  if(p->trapframe)
    80002cc6:	fe843783          	ld	a5,-24(s0)
    80002cca:	73bc                	ld	a5,96(a5)
    80002ccc:	cb89                	beqz	a5,80002cde <freethread+0x24>
    kfree((void*)p->trapframe);
    80002cce:	fe843783          	ld	a5,-24(s0)
    80002cd2:	73bc                	ld	a5,96(a5)
    80002cd4:	853e                	mv	a0,a5
    80002cd6:	ffffe097          	auipc	ra,0xffffe
    80002cda:	39c080e7          	jalr	924(ra) # 80001072 <kfree>
  p->trapframe = 0;
    80002cde:	fe843783          	ld	a5,-24(s0)
    80002ce2:	0607b023          	sd	zero,96(a5)
  if(p->pagetable){
    80002ce6:	fe843783          	ld	a5,-24(s0)
    80002cea:	6bbc                	ld	a5,80(a5)
    80002cec:	cfa5                	beqz	a5,80002d64 <freethread+0xaa>
    uvmunmap(p->pagetable, TRAMPOLINE, 1, 0); //desmapea pagina trampoline
    80002cee:	fe843783          	ld	a5,-24(s0)
    80002cf2:	6bb8                	ld	a4,80(a5)
    80002cf4:	4681                	li	a3,0
    80002cf6:	4605                	li	a2,1
    80002cf8:	040007b7          	lui	a5,0x4000
    80002cfc:	17fd                	addi	a5,a5,-1
    80002cfe:	00c79593          	slli	a1,a5,0xc
    80002d02:	853a                	mv	a0,a4
    80002d04:	fffff097          	auipc	ra,0xfffff
    80002d08:	040080e7          	jalr	64(ra) # 80001d44 <uvmunmap>
    uvmunmap(p->pagetable, TRAPFRAME, 1, 0); //desmapea pagina trapframe
    80002d0c:	fe843783          	ld	a5,-24(s0)
    80002d10:	6bb8                	ld	a4,80(a5)
    80002d12:	4681                	li	a3,0
    80002d14:	4605                	li	a2,1
    80002d16:	020007b7          	lui	a5,0x2000
    80002d1a:	17fd                	addi	a5,a5,-1
    80002d1c:	00d79593          	slli	a1,a5,0xd
    80002d20:	853a                	mv	a0,a4
    80002d22:	fffff097          	auipc	ra,0xfffff
    80002d26:	022080e7          	jalr	34(ra) # 80001d44 <uvmunmap>
    if(p->sz > 0)
    80002d2a:	fe843783          	ld	a5,-24(s0)
    80002d2e:	67bc                	ld	a5,72(a5)
    80002d30:	c395                	beqz	a5,80002d54 <freethread+0x9a>
      uvmunmap(p->pagetable, 0, PGROUNDUP(p->sz)/PGSIZE, 0); //desmapea todo de 0 a sz, sin liberar las paginas fisicas
    80002d32:	fe843783          	ld	a5,-24(s0)
    80002d36:	6ba8                	ld	a0,80(a5)
    80002d38:	fe843783          	ld	a5,-24(s0)
    80002d3c:	67b8                	ld	a4,72(a5)
    80002d3e:	6785                	lui	a5,0x1
    80002d40:	17fd                	addi	a5,a5,-1
    80002d42:	97ba                	add	a5,a5,a4
    80002d44:	83b1                	srli	a5,a5,0xc
    80002d46:	4681                	li	a3,0
    80002d48:	863e                	mv	a2,a5
    80002d4a:	4581                	li	a1,0
    80002d4c:	fffff097          	auipc	ra,0xfffff
    80002d50:	ff8080e7          	jalr	-8(ra) # 80001d44 <uvmunmap>
    freewalk(p->pagetable); //libera todas las páginas de forma recursiva
    80002d54:	fe843783          	ld	a5,-24(s0)
    80002d58:	6bbc                	ld	a5,80(a5)
    80002d5a:	853e                	mv	a0,a5
    80002d5c:	fffff097          	auipc	ra,0xfffff
    80002d60:	32e080e7          	jalr	814(ra) # 8000208a <freewalk>

  }
  p->pagetable = 0;
    80002d64:	fe843783          	ld	a5,-24(s0)
    80002d68:	0407b823          	sd	zero,80(a5) # 1050 <_entry-0x7fffefb0>
  p->sz = 0;
    80002d6c:	fe843783          	ld	a5,-24(s0)
    80002d70:	0407b423          	sd	zero,72(a5)
  p->pid = 0;
    80002d74:	fe843783          	ld	a5,-24(s0)
    80002d78:	0207a823          	sw	zero,48(a5)
  p->parent = 0;
    80002d7c:	fe843783          	ld	a5,-24(s0)
    80002d80:	0207bc23          	sd	zero,56(a5)
  p->name[0] = 0;
    80002d84:	fe843783          	ld	a5,-24(s0)
    80002d88:	16078423          	sb	zero,360(a5)
  p->chan = 0;
    80002d8c:	fe843783          	ld	a5,-24(s0)
    80002d90:	0207b023          	sd	zero,32(a5)
  p->killed = 0;
    80002d94:	fe843783          	ld	a5,-24(s0)
    80002d98:	0207a423          	sw	zero,40(a5)
  p->xstate = 0;
    80002d9c:	fe843783          	ld	a5,-24(s0)
    80002da0:	0207a623          	sw	zero,44(a5)
  p->state = UNUSED;
    80002da4:	fe843783          	ld	a5,-24(s0)
    80002da8:	0007ac23          	sw	zero,24(a5)
  p->ASID = 0;
    80002dac:	fe843783          	ld	a5,-24(s0)
    80002db0:	0207aa23          	sw	zero,52(a5)
  p->bottom_ustack = 0;
    80002db4:	fe843703          	ld	a4,-24(s0)
    80002db8:	6789                	lui	a5,0x2
    80002dba:	97ba                	add	a5,a5,a4
    80002dbc:	1807b023          	sd	zero,384(a5) # 2180 <_entry-0x7fffde80>
  p->top_ustack = 0;
    80002dc0:	fe843703          	ld	a4,-24(s0)
    80002dc4:	6789                	lui	a5,0x2
    80002dc6:	97ba                	add	a5,a5,a4
    80002dc8:	1607bc23          	sd	zero,376(a5) # 2178 <_entry-0x7fffde88>

}
    80002dcc:	0001                	nop
    80002dce:	60e2                	ld	ra,24(sp)
    80002dd0:	6442                	ld	s0,16(sp)
    80002dd2:	6105                	addi	sp,sp,32
    80002dd4:	8082                	ret

0000000080002dd6 <proc_pagetable>:

// Create a user page table for a given process,
// with no user memory, but with trampoline pages.
pagetable_t
proc_pagetable(struct proc *p)
{
    80002dd6:	7179                	addi	sp,sp,-48
    80002dd8:	f406                	sd	ra,40(sp)
    80002dda:	f022                	sd	s0,32(sp)
    80002ddc:	1800                	addi	s0,sp,48
    80002dde:	fca43c23          	sd	a0,-40(s0)
  pagetable_t pagetable;

  // An empty page table.
  pagetable = uvmcreate();
    80002de2:	fffff097          	auipc	ra,0xfffff
    80002de6:	062080e7          	jalr	98(ra) # 80001e44 <uvmcreate>
    80002dea:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80002dee:	fe843783          	ld	a5,-24(s0)
    80002df2:	e399                	bnez	a5,80002df8 <proc_pagetable+0x22>
    return 0;
    80002df4:	4781                	li	a5,0
    80002df6:	a859                	j	80002e8c <proc_pagetable+0xb6>

  // map the trampoline code (for system call return)
  // at the highest user virtual address.
  // only the supervisor uses it, on the way
  // to/from user space, so not PTE_U.
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80002df8:	00007797          	auipc	a5,0x7
    80002dfc:	20878793          	addi	a5,a5,520 # 8000a000 <_trampoline>
    80002e00:	4729                	li	a4,10
    80002e02:	86be                	mv	a3,a5
    80002e04:	6605                	lui	a2,0x1
    80002e06:	040007b7          	lui	a5,0x4000
    80002e0a:	17fd                	addi	a5,a5,-1
    80002e0c:	00c79593          	slli	a1,a5,0xc
    80002e10:	fe843503          	ld	a0,-24(s0)
    80002e14:	fffff097          	auipc	ra,0xfffff
    80002e18:	e52080e7          	jalr	-430(ra) # 80001c66 <mappages>
    80002e1c:	87aa                	mv	a5,a0
    80002e1e:	0007db63          	bgez	a5,80002e34 <proc_pagetable+0x5e>
              (uint64)trampoline, PTE_R | PTE_X) < 0){
    uvmfree(pagetable, 0);
    80002e22:	4581                	li	a1,0
    80002e24:	fe843503          	ld	a0,-24(s0)
    80002e28:	fffff097          	auipc	ra,0xfffff
    80002e2c:	30a080e7          	jalr	778(ra) # 80002132 <uvmfree>
    return 0;
    80002e30:	4781                	li	a5,0
    80002e32:	a8a9                	j	80002e8c <proc_pagetable+0xb6>
  }

  // map the trapframe just below TRAMPOLINE, for trampoline.S.
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
              (uint64)(p->trapframe), PTE_R | PTE_W) < 0){
    80002e34:	fd843783          	ld	a5,-40(s0)
    80002e38:	73bc                	ld	a5,96(a5)
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80002e3a:	4719                	li	a4,6
    80002e3c:	86be                	mv	a3,a5
    80002e3e:	6605                	lui	a2,0x1
    80002e40:	020007b7          	lui	a5,0x2000
    80002e44:	17fd                	addi	a5,a5,-1
    80002e46:	00d79593          	slli	a1,a5,0xd
    80002e4a:	fe843503          	ld	a0,-24(s0)
    80002e4e:	fffff097          	auipc	ra,0xfffff
    80002e52:	e18080e7          	jalr	-488(ra) # 80001c66 <mappages>
    80002e56:	87aa                	mv	a5,a0
    80002e58:	0207d863          	bgez	a5,80002e88 <proc_pagetable+0xb2>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002e5c:	4681                	li	a3,0
    80002e5e:	4605                	li	a2,1
    80002e60:	040007b7          	lui	a5,0x4000
    80002e64:	17fd                	addi	a5,a5,-1
    80002e66:	00c79593          	slli	a1,a5,0xc
    80002e6a:	fe843503          	ld	a0,-24(s0)
    80002e6e:	fffff097          	auipc	ra,0xfffff
    80002e72:	ed6080e7          	jalr	-298(ra) # 80001d44 <uvmunmap>
    uvmfree(pagetable, 0);
    80002e76:	4581                	li	a1,0
    80002e78:	fe843503          	ld	a0,-24(s0)
    80002e7c:	fffff097          	auipc	ra,0xfffff
    80002e80:	2b6080e7          	jalr	694(ra) # 80002132 <uvmfree>
    return 0;
    80002e84:	4781                	li	a5,0
    80002e86:	a019                	j	80002e8c <proc_pagetable+0xb6>
  }

  return pagetable;
    80002e88:	fe843783          	ld	a5,-24(s0)
}
    80002e8c:	853e                	mv	a0,a5
    80002e8e:	70a2                	ld	ra,40(sp)
    80002e90:	7402                	ld	s0,32(sp)
    80002e92:	6145                	addi	sp,sp,48
    80002e94:	8082                	ret

0000000080002e96 <proc_freepagetable>:

// Free a process's page table, and free the
// physical memory it refers to.
void
proc_freepagetable(pagetable_t pagetable, uint64 sz)
{
    80002e96:	1101                	addi	sp,sp,-32
    80002e98:	ec06                	sd	ra,24(sp)
    80002e9a:	e822                	sd	s0,16(sp)
    80002e9c:	1000                	addi	s0,sp,32
    80002e9e:	fea43423          	sd	a0,-24(s0)
    80002ea2:	feb43023          	sd	a1,-32(s0)
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002ea6:	4681                	li	a3,0
    80002ea8:	4605                	li	a2,1
    80002eaa:	040007b7          	lui	a5,0x4000
    80002eae:	17fd                	addi	a5,a5,-1
    80002eb0:	00c79593          	slli	a1,a5,0xc
    80002eb4:	fe843503          	ld	a0,-24(s0)
    80002eb8:	fffff097          	auipc	ra,0xfffff
    80002ebc:	e8c080e7          	jalr	-372(ra) # 80001d44 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80002ec0:	4681                	li	a3,0
    80002ec2:	4605                	li	a2,1
    80002ec4:	020007b7          	lui	a5,0x2000
    80002ec8:	17fd                	addi	a5,a5,-1
    80002eca:	00d79593          	slli	a1,a5,0xd
    80002ece:	fe843503          	ld	a0,-24(s0)
    80002ed2:	fffff097          	auipc	ra,0xfffff
    80002ed6:	e72080e7          	jalr	-398(ra) # 80001d44 <uvmunmap>
  uvmfree(pagetable, sz);
    80002eda:	fe043583          	ld	a1,-32(s0)
    80002ede:	fe843503          	ld	a0,-24(s0)
    80002ee2:	fffff097          	auipc	ra,0xfffff
    80002ee6:	250080e7          	jalr	592(ra) # 80002132 <uvmfree>
}
    80002eea:	0001                	nop
    80002eec:	60e2                	ld	ra,24(sp)
    80002eee:	6442                	ld	s0,16(sp)
    80002ef0:	6105                	addi	sp,sp,32
    80002ef2:	8082                	ret

0000000080002ef4 <userinit>:
};

// Set up first user process.
void
userinit(void)
{
    80002ef4:	1101                	addi	sp,sp,-32
    80002ef6:	ec06                	sd	ra,24(sp)
    80002ef8:	e822                	sd	s0,16(sp)
    80002efa:	1000                	addi	s0,sp,32
  struct proc *p;

  p = allocproc();
    80002efc:	00000097          	auipc	ra,0x0
    80002f00:	bb6080e7          	jalr	-1098(ra) # 80002ab2 <allocproc>
    80002f04:	fea43423          	sd	a0,-24(s0)
  initproc = p;
    80002f08:	00009797          	auipc	a5,0x9
    80002f0c:	11878793          	addi	a5,a5,280 # 8000c020 <initproc>
    80002f10:	fe843703          	ld	a4,-24(s0)
    80002f14:	e398                	sd	a4,0(a5)
  
  // allocate one user page and copy init's instructions
  // and data into it.
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80002f16:	fe843783          	ld	a5,-24(s0)
    80002f1a:	6bbc                	ld	a5,80(a5)
    80002f1c:	03400613          	li	a2,52
    80002f20:	00009597          	auipc	a1,0x9
    80002f24:	9d858593          	addi	a1,a1,-1576 # 8000b8f8 <initcode>
    80002f28:	853e                	mv	a0,a5
    80002f2a:	fffff097          	auipc	ra,0xfffff
    80002f2e:	f56080e7          	jalr	-170(ra) # 80001e80 <uvminit>
  p->sz = PGSIZE;
    80002f32:	fe843783          	ld	a5,-24(s0)
    80002f36:	6705                	lui	a4,0x1
    80002f38:	e7b8                	sd	a4,72(a5)

  // prepare for the very first "return" from kernel to user.
  p->trapframe->epc = 0;      // user program counter
    80002f3a:	fe843783          	ld	a5,-24(s0)
    80002f3e:	73bc                	ld	a5,96(a5)
    80002f40:	0007bc23          	sd	zero,24(a5)
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80002f44:	fe843783          	ld	a5,-24(s0)
    80002f48:	73bc                	ld	a5,96(a5)
    80002f4a:	6705                	lui	a4,0x1
    80002f4c:	fb98                	sd	a4,48(a5)

  safestrcpy(p->name, "initcode", sizeof(p->name));
    80002f4e:	fe843783          	ld	a5,-24(s0)
    80002f52:	16878793          	addi	a5,a5,360
    80002f56:	4641                	li	a2,16
    80002f58:	00008597          	auipc	a1,0x8
    80002f5c:	2c058593          	addi	a1,a1,704 # 8000b218 <etext+0x218>
    80002f60:	853e                	mv	a0,a5
    80002f62:	ffffe097          	auipc	ra,0xffffe
    80002f66:	7e0080e7          	jalr	2016(ra) # 80001742 <safestrcpy>
  p->cwd = namei("/");
    80002f6a:	00008517          	auipc	a0,0x8
    80002f6e:	2be50513          	addi	a0,a0,702 # 8000b228 <etext+0x228>
    80002f72:	00004097          	auipc	ra,0x4
    80002f76:	aa2080e7          	jalr	-1374(ra) # 80006a14 <namei>
    80002f7a:	872a                	mv	a4,a0
    80002f7c:	fe843783          	ld	a5,-24(s0)
    80002f80:	16e7b023          	sd	a4,352(a5)

  p->state = RUNNABLE;
    80002f84:	fe843783          	ld	a5,-24(s0)
    80002f88:	470d                	li	a4,3
    80002f8a:	cf98                	sw	a4,24(a5)

  release(&p->lock);
    80002f8c:	fe843783          	ld	a5,-24(s0)
    80002f90:	853e                	mv	a0,a5
    80002f92:	ffffe097          	auipc	ra,0xffffe
    80002f96:	33c080e7          	jalr	828(ra) # 800012ce <release>
}
    80002f9a:	0001                	nop
    80002f9c:	60e2                	ld	ra,24(sp)
    80002f9e:	6442                	ld	s0,16(sp)
    80002fa0:	6105                	addi	sp,sp,32
    80002fa2:	8082                	ret

0000000080002fa4 <growproc>:

// Grow or shrink user memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
    80002fa4:	7179                	addi	sp,sp,-48
    80002fa6:	f406                	sd	ra,40(sp)
    80002fa8:	f022                	sd	s0,32(sp)
    80002faa:	1800                	addi	s0,sp,48
    80002fac:	87aa                	mv	a5,a0
    80002fae:	fcf42e23          	sw	a5,-36(s0)
  uint sz;
  struct proc *p = myproc();
    80002fb2:	00000097          	auipc	ra,0x0
    80002fb6:	a66080e7          	jalr	-1434(ra) # 80002a18 <myproc>
    80002fba:	fea43023          	sd	a0,-32(s0)

  sz = p->sz;
    80002fbe:	fe043783          	ld	a5,-32(s0)
    80002fc2:	67bc                	ld	a5,72(a5)
    80002fc4:	fef42623          	sw	a5,-20(s0)
  if(n > 0){
    80002fc8:	fdc42783          	lw	a5,-36(s0)
    80002fcc:	2781                	sext.w	a5,a5
    80002fce:	02f05f63          	blez	a5,8000300c <growproc+0x68>
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80002fd2:	fe043783          	ld	a5,-32(s0)
    80002fd6:	6bb8                	ld	a4,80(a5)
    80002fd8:	fec46683          	lwu	a3,-20(s0)
    80002fdc:	fdc42783          	lw	a5,-36(s0)
    80002fe0:	fec42603          	lw	a2,-20(s0)
    80002fe4:	9fb1                	addw	a5,a5,a2
    80002fe6:	2781                	sext.w	a5,a5
    80002fe8:	1782                	slli	a5,a5,0x20
    80002fea:	9381                	srli	a5,a5,0x20
    80002fec:	863e                	mv	a2,a5
    80002fee:	85b6                	mv	a1,a3
    80002ff0:	853a                	mv	a0,a4
    80002ff2:	fffff097          	auipc	ra,0xfffff
    80002ff6:	f16080e7          	jalr	-234(ra) # 80001f08 <uvmalloc>
    80002ffa:	87aa                	mv	a5,a0
    80002ffc:	fef42623          	sw	a5,-20(s0)
    80003000:	fec42783          	lw	a5,-20(s0)
    80003004:	2781                	sext.w	a5,a5
    80003006:	ef9d                	bnez	a5,80003044 <growproc+0xa0>
      return -1;
    80003008:	57fd                	li	a5,-1
    8000300a:	a099                	j	80003050 <growproc+0xac>
    }
  } else if(n < 0){
    8000300c:	fdc42783          	lw	a5,-36(s0)
    80003010:	2781                	sext.w	a5,a5
    80003012:	0207d963          	bgez	a5,80003044 <growproc+0xa0>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80003016:	fe043783          	ld	a5,-32(s0)
    8000301a:	6bb8                	ld	a4,80(a5)
    8000301c:	fec46683          	lwu	a3,-20(s0)
    80003020:	fdc42783          	lw	a5,-36(s0)
    80003024:	fec42603          	lw	a2,-20(s0)
    80003028:	9fb1                	addw	a5,a5,a2
    8000302a:	2781                	sext.w	a5,a5
    8000302c:	1782                	slli	a5,a5,0x20
    8000302e:	9381                	srli	a5,a5,0x20
    80003030:	863e                	mv	a2,a5
    80003032:	85b6                	mv	a1,a3
    80003034:	853a                	mv	a0,a4
    80003036:	fffff097          	auipc	ra,0xfffff
    8000303a:	fb6080e7          	jalr	-74(ra) # 80001fec <uvmdealloc>
    8000303e:	87aa                	mv	a5,a0
    80003040:	fef42623          	sw	a5,-20(s0)
  }
  p->sz = sz;
    80003044:	fec46703          	lwu	a4,-20(s0)
    80003048:	fe043783          	ld	a5,-32(s0)
    8000304c:	e7b8                	sd	a4,72(a5)
  return 0;
    8000304e:	4781                	li	a5,0
}
    80003050:	853e                	mv	a0,a5
    80003052:	70a2                	ld	ra,40(sp)
    80003054:	7402                	ld	s0,32(sp)
    80003056:	6145                	addi	sp,sp,48
    80003058:	8082                	ret

000000008000305a <check_grow_threads>:



int check_grow_threads (struct proc *parent, int n, int sz)
{
    8000305a:	7179                	addi	sp,sp,-48
    8000305c:	f406                	sd	ra,40(sp)
    8000305e:	f022                	sd	s0,32(sp)
    80003060:	1800                	addi	s0,sp,48
    80003062:	fca43c23          	sd	a0,-40(s0)
    80003066:	87ae                	mv	a5,a1
    80003068:	8732                	mv	a4,a2
    8000306a:	fcf42a23          	sw	a5,-44(s0)
    8000306e:	87ba                	mv	a5,a4
    80003070:	fcf42823          	sw	a5,-48(s0)
  struct proc *np;
  for(np = proc; np < &proc[NPROC]; np++){
    80003074:	00011797          	auipc	a5,0x11
    80003078:	62478793          	addi	a5,a5,1572 # 80014698 <proc>
    8000307c:	fef43423          	sd	a5,-24(s0)
    80003080:	a885                	j	800030f0 <check_grow_threads+0x96>
      if(np->thread == 1 && np->ASID == parent->ASID){
    80003082:	fe843703          	ld	a4,-24(s0)
    80003086:	67c9                	lui	a5,0x12
    80003088:	97ba                	add	a5,a5,a4
    8000308a:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    8000308e:	873e                	mv	a4,a5
    80003090:	4785                	li	a5,1
    80003092:	04f71763          	bne	a4,a5,800030e0 <check_grow_threads+0x86>
    80003096:	fe843783          	ld	a5,-24(s0)
    8000309a:	5bd8                	lw	a4,52(a5)
    8000309c:	fd843783          	ld	a5,-40(s0)
    800030a0:	5bdc                	lw	a5,52(a5)
    800030a2:	02f71f63          	bne	a4,a5,800030e0 <check_grow_threads+0x86>
        if((growproc_thread(parent->pagetable, np->pagetable, sz, n))<0){
    800030a6:	fd843783          	ld	a5,-40(s0)
    800030aa:	6bb8                	ld	a4,80(a5)
    800030ac:	fe843783          	ld	a5,-24(s0)
    800030b0:	6bbc                	ld	a5,80(a5)
    800030b2:	fd042603          	lw	a2,-48(s0)
    800030b6:	fd442683          	lw	a3,-44(s0)
    800030ba:	85be                	mv	a1,a5
    800030bc:	853a                	mv	a0,a4
    800030be:	00000097          	auipc	ra,0x0
    800030c2:	04e080e7          	jalr	78(ra) # 8000310c <growproc_thread>
    800030c6:	87aa                	mv	a5,a0
    800030c8:	0007dc63          	bgez	a5,800030e0 <check_grow_threads+0x86>
          printf ("Fallo al expandir en los hijos.\n");
    800030cc:	00008517          	auipc	a0,0x8
    800030d0:	16450513          	addi	a0,a0,356 # 8000b230 <etext+0x230>
    800030d4:	ffffe097          	auipc	ra,0xffffe
    800030d8:	950080e7          	jalr	-1712(ra) # 80000a24 <printf>
          return -1;
    800030dc:	57fd                	li	a5,-1
    800030de:	a015                	j	80003102 <check_grow_threads+0xa8>
  for(np = proc; np < &proc[NPROC]; np++){
    800030e0:	fe843703          	ld	a4,-24(s0)
    800030e4:	67c9                	lui	a5,0x12
    800030e6:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    800030ea:	97ba                	add	a5,a5,a4
    800030ec:	fef43423          	sd	a5,-24(s0)
    800030f0:	fe843703          	ld	a4,-24(s0)
    800030f4:	00498797          	auipc	a5,0x498
    800030f8:	9a478793          	addi	a5,a5,-1628 # 8049aa98 <pid_lock>
    800030fc:	f8f763e3          	bltu	a4,a5,80003082 <check_grow_threads+0x28>
        }

      }
  }

  return 0;
    80003100:	4781                	li	a5,0
}
    80003102:	853e                	mv	a0,a5
    80003104:	70a2                	ld	ra,40(sp)
    80003106:	7402                	ld	s0,32(sp)
    80003108:	6145                	addi	sp,sp,48
    8000310a:	8082                	ret

000000008000310c <growproc_thread>:



int
growproc_thread(pagetable_t old, pagetable_t new, uint64 sz, int n)
{
    8000310c:	715d                	addi	sp,sp,-80
    8000310e:	e486                	sd	ra,72(sp)
    80003110:	e0a2                	sd	s0,64(sp)
    80003112:	0880                	addi	s0,sp,80
    80003114:	fca43423          	sd	a0,-56(s0)
    80003118:	fcb43023          	sd	a1,-64(s0)
    8000311c:	fac43c23          	sd	a2,-72(s0)
    80003120:	87b6                	mv	a5,a3
    80003122:	faf42a23          	sw	a5,-76(s0)
  pte_t *pte;
  uint64 pa, i;
  uint flags;

  for(i = sz; i < sz + n; i += PGSIZE){
    80003126:	fb843783          	ld	a5,-72(s0)
    8000312a:	fef43423          	sd	a5,-24(s0)
    8000312e:	a849                	j	800031c0 <growproc_thread+0xb4>
    if((pte = walk(old, i, 0)) == 0)
    80003130:	4601                	li	a2,0
    80003132:	fe843583          	ld	a1,-24(s0)
    80003136:	fc843503          	ld	a0,-56(s0)
    8000313a:	fffff097          	auipc	ra,0xfffff
    8000313e:	968080e7          	jalr	-1688(ra) # 80001aa2 <walk>
    80003142:	fea43023          	sd	a0,-32(s0)
    80003146:	fe043783          	ld	a5,-32(s0)
    8000314a:	eb89                	bnez	a5,8000315c <growproc_thread+0x50>
      panic("uvmcopy: pte should exist");
    8000314c:	00008517          	auipc	a0,0x8
    80003150:	10c50513          	addi	a0,a0,268 # 8000b258 <etext+0x258>
    80003154:	ffffe097          	auipc	ra,0xffffe
    80003158:	b26080e7          	jalr	-1242(ra) # 80000c7a <panic>
    if((*pte & PTE_V) == 0)
    8000315c:	fe043783          	ld	a5,-32(s0)
    80003160:	639c                	ld	a5,0(a5)
    80003162:	8b85                	andi	a5,a5,1
    80003164:	eb89                	bnez	a5,80003176 <growproc_thread+0x6a>
      panic("uvmcopy: page not present");
    80003166:	00008517          	auipc	a0,0x8
    8000316a:	11250513          	addi	a0,a0,274 # 8000b278 <etext+0x278>
    8000316e:	ffffe097          	auipc	ra,0xffffe
    80003172:	b0c080e7          	jalr	-1268(ra) # 80000c7a <panic>
    pa = PTE2PA(*pte);
    80003176:	fe043783          	ld	a5,-32(s0)
    8000317a:	639c                	ld	a5,0(a5)
    8000317c:	83a9                	srli	a5,a5,0xa
    8000317e:	07b2                	slli	a5,a5,0xc
    80003180:	fcf43c23          	sd	a5,-40(s0)
    flags = PTE_FLAGS(*pte);
    80003184:	fe043783          	ld	a5,-32(s0)
    80003188:	639c                	ld	a5,0(a5)
    8000318a:	2781                	sext.w	a5,a5
    8000318c:	3ff7f793          	andi	a5,a5,1023
    80003190:	fcf42a23          	sw	a5,-44(s0)
    /*if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE);*/
    if(mappages(new, i, PGSIZE, (uint64)pa, flags) != 0){
    80003194:	fd442783          	lw	a5,-44(s0)
    80003198:	873e                	mv	a4,a5
    8000319a:	fd843683          	ld	a3,-40(s0)
    8000319e:	6605                	lui	a2,0x1
    800031a0:	fe843583          	ld	a1,-24(s0)
    800031a4:	fc043503          	ld	a0,-64(s0)
    800031a8:	fffff097          	auipc	ra,0xfffff
    800031ac:	abe080e7          	jalr	-1346(ra) # 80001c66 <mappages>
    800031b0:	87aa                	mv	a5,a0
    800031b2:	e395                	bnez	a5,800031d6 <growproc_thread+0xca>
  for(i = sz; i < sz + n; i += PGSIZE){
    800031b4:	fe843703          	ld	a4,-24(s0)
    800031b8:	6785                	lui	a5,0x1
    800031ba:	97ba                	add	a5,a5,a4
    800031bc:	fef43423          	sd	a5,-24(s0)
    800031c0:	fb442703          	lw	a4,-76(s0)
    800031c4:	fb843783          	ld	a5,-72(s0)
    800031c8:	97ba                	add	a5,a5,a4
    800031ca:	fe843703          	ld	a4,-24(s0)
    800031ce:	f6f761e3          	bltu	a4,a5,80003130 <growproc_thread+0x24>
      goto err;
    }
  }
  return 0;
    800031d2:	4781                	li	a5,0
    800031d4:	a839                	j	800031f2 <growproc_thread+0xe6>
      goto err;
    800031d6:	0001                	nop

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    800031d8:	fe843783          	ld	a5,-24(s0)
    800031dc:	83b1                	srli	a5,a5,0xc
    800031de:	4685                	li	a3,1
    800031e0:	863e                	mv	a2,a5
    800031e2:	4581                	li	a1,0
    800031e4:	fc043503          	ld	a0,-64(s0)
    800031e8:	fffff097          	auipc	ra,0xfffff
    800031ec:	b5c080e7          	jalr	-1188(ra) # 80001d44 <uvmunmap>
  return -1;
    800031f0:	57fd                	li	a5,-1
}
    800031f2:	853e                	mv	a0,a5
    800031f4:	60a6                	ld	ra,72(sp)
    800031f6:	6406                	ld	s0,64(sp)
    800031f8:	6161                	addi	sp,sp,80
    800031fa:	8082                	ret

00000000800031fc <fork>:

// Create a new process, copying the parent.
// Sets up child kernel stack to return as if from fork() system call.
int
fork(void)
{
    800031fc:	7179                	addi	sp,sp,-48
    800031fe:	f406                	sd	ra,40(sp)
    80003200:	f022                	sd	s0,32(sp)
    80003202:	1800                	addi	s0,sp,48
  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    80003204:	00000097          	auipc	ra,0x0
    80003208:	814080e7          	jalr	-2028(ra) # 80002a18 <myproc>
    8000320c:	fea43023          	sd	a0,-32(s0)

  // Allocate process.
  if((np = allocproc()) == 0){
    80003210:	00000097          	auipc	ra,0x0
    80003214:	8a2080e7          	jalr	-1886(ra) # 80002ab2 <allocproc>
    80003218:	fca43c23          	sd	a0,-40(s0)
    8000321c:	fd843783          	ld	a5,-40(s0)
    80003220:	e399                	bnez	a5,80003226 <fork+0x2a>
    return -1;
    80003222:	57fd                	li	a5,-1
    80003224:	aab5                	j	800033a0 <fork+0x1a4>
  }

  // Copy user memory from parent to child.
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80003226:	fe043783          	ld	a5,-32(s0)
    8000322a:	6bb8                	ld	a4,80(a5)
    8000322c:	fd843783          	ld	a5,-40(s0)
    80003230:	6bb4                	ld	a3,80(a5)
    80003232:	fe043783          	ld	a5,-32(s0)
    80003236:	67bc                	ld	a5,72(a5)
    80003238:	863e                	mv	a2,a5
    8000323a:	85b6                	mv	a1,a3
    8000323c:	853a                	mv	a0,a4
    8000323e:	fffff097          	auipc	ra,0xfffff
    80003242:	f3e080e7          	jalr	-194(ra) # 8000217c <uvmcopy>
    80003246:	87aa                	mv	a5,a0
    80003248:	0207d163          	bgez	a5,8000326a <fork+0x6e>
    freeproc(np);
    8000324c:	fd843503          	ld	a0,-40(s0)
    80003250:	00000097          	auipc	ra,0x0
    80003254:	9cc080e7          	jalr	-1588(ra) # 80002c1c <freeproc>
    release(&np->lock);
    80003258:	fd843783          	ld	a5,-40(s0)
    8000325c:	853e                	mv	a0,a5
    8000325e:	ffffe097          	auipc	ra,0xffffe
    80003262:	070080e7          	jalr	112(ra) # 800012ce <release>
    return -1;
    80003266:	57fd                	li	a5,-1
    80003268:	aa25                	j	800033a0 <fork+0x1a4>
  }
  np->sz = p->sz;
    8000326a:	fe043783          	ld	a5,-32(s0)
    8000326e:	67b8                	ld	a4,72(a5)
    80003270:	fd843783          	ld	a5,-40(s0)
    80003274:	e7b8                	sd	a4,72(a5)

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    80003276:	fe043783          	ld	a5,-32(s0)
    8000327a:	73b8                	ld	a4,96(a5)
    8000327c:	fd843783          	ld	a5,-40(s0)
    80003280:	73bc                	ld	a5,96(a5)
    80003282:	86be                	mv	a3,a5
    80003284:	12000793          	li	a5,288
    80003288:	863e                	mv	a2,a5
    8000328a:	85ba                	mv	a1,a4
    8000328c:	8536                	mv	a0,a3
    8000328e:	ffffe097          	auipc	ra,0xffffe
    80003292:	370080e7          	jalr	880(ra) # 800015fe <memcpy>


  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;
    80003296:	fd843783          	ld	a5,-40(s0)
    8000329a:	73bc                	ld	a5,96(a5)
    8000329c:	0607b823          	sd	zero,112(a5) # 1070 <_entry-0x7fffef90>

  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    800032a0:	fe042623          	sw	zero,-20(s0)
    800032a4:	a0a9                	j	800032ee <fork+0xf2>
    if(p->ofile[i])
    800032a6:	fe043703          	ld	a4,-32(s0)
    800032aa:	fec42783          	lw	a5,-20(s0)
    800032ae:	07f1                	addi	a5,a5,28
    800032b0:	078e                	slli	a5,a5,0x3
    800032b2:	97ba                	add	a5,a5,a4
    800032b4:	639c                	ld	a5,0(a5)
    800032b6:	c79d                	beqz	a5,800032e4 <fork+0xe8>
      np->ofile[i] = filedup(p->ofile[i]);
    800032b8:	fe043703          	ld	a4,-32(s0)
    800032bc:	fec42783          	lw	a5,-20(s0)
    800032c0:	07f1                	addi	a5,a5,28
    800032c2:	078e                	slli	a5,a5,0x3
    800032c4:	97ba                	add	a5,a5,a4
    800032c6:	639c                	ld	a5,0(a5)
    800032c8:	853e                	mv	a0,a5
    800032ca:	00004097          	auipc	ra,0x4
    800032ce:	0e2080e7          	jalr	226(ra) # 800073ac <filedup>
    800032d2:	86aa                	mv	a3,a0
    800032d4:	fd843703          	ld	a4,-40(s0)
    800032d8:	fec42783          	lw	a5,-20(s0)
    800032dc:	07f1                	addi	a5,a5,28
    800032de:	078e                	slli	a5,a5,0x3
    800032e0:	97ba                	add	a5,a5,a4
    800032e2:	e394                	sd	a3,0(a5)
  for(i = 0; i < NOFILE; i++)
    800032e4:	fec42783          	lw	a5,-20(s0)
    800032e8:	2785                	addiw	a5,a5,1
    800032ea:	fef42623          	sw	a5,-20(s0)
    800032ee:	fec42783          	lw	a5,-20(s0)
    800032f2:	0007871b          	sext.w	a4,a5
    800032f6:	47bd                	li	a5,15
    800032f8:	fae7d7e3          	bge	a5,a4,800032a6 <fork+0xaa>
  np->cwd = idup(p->cwd);
    800032fc:	fe043783          	ld	a5,-32(s0)
    80003300:	1607b783          	ld	a5,352(a5)
    80003304:	853e                	mv	a0,a5
    80003306:	00003097          	auipc	ra,0x3
    8000330a:	9be080e7          	jalr	-1602(ra) # 80005cc4 <idup>
    8000330e:	872a                	mv	a4,a0
    80003310:	fd843783          	ld	a5,-40(s0)
    80003314:	16e7b023          	sd	a4,352(a5)

  safestrcpy(np->name, p->name, sizeof(p->name));
    80003318:	fd843783          	ld	a5,-40(s0)
    8000331c:	16878713          	addi	a4,a5,360
    80003320:	fe043783          	ld	a5,-32(s0)
    80003324:	16878793          	addi	a5,a5,360
    80003328:	4641                	li	a2,16
    8000332a:	85be                	mv	a1,a5
    8000332c:	853a                	mv	a0,a4
    8000332e:	ffffe097          	auipc	ra,0xffffe
    80003332:	414080e7          	jalr	1044(ra) # 80001742 <safestrcpy>

  pid = np->pid;
    80003336:	fd843783          	ld	a5,-40(s0)
    8000333a:	5b9c                	lw	a5,48(a5)
    8000333c:	fcf42a23          	sw	a5,-44(s0)

  release(&np->lock);
    80003340:	fd843783          	ld	a5,-40(s0)
    80003344:	853e                	mv	a0,a5
    80003346:	ffffe097          	auipc	ra,0xffffe
    8000334a:	f88080e7          	jalr	-120(ra) # 800012ce <release>

  acquire(&wait_lock);
    8000334e:	00497517          	auipc	a0,0x497
    80003352:	76250513          	addi	a0,a0,1890 # 8049aab0 <wait_lock>
    80003356:	ffffe097          	auipc	ra,0xffffe
    8000335a:	f14080e7          	jalr	-236(ra) # 8000126a <acquire>
  np->parent = p;
    8000335e:	fd843783          	ld	a5,-40(s0)
    80003362:	fe043703          	ld	a4,-32(s0)
    80003366:	ff98                	sd	a4,56(a5)
  release(&wait_lock);
    80003368:	00497517          	auipc	a0,0x497
    8000336c:	74850513          	addi	a0,a0,1864 # 8049aab0 <wait_lock>
    80003370:	ffffe097          	auipc	ra,0xffffe
    80003374:	f5e080e7          	jalr	-162(ra) # 800012ce <release>

  acquire(&np->lock);
    80003378:	fd843783          	ld	a5,-40(s0)
    8000337c:	853e                	mv	a0,a5
    8000337e:	ffffe097          	auipc	ra,0xffffe
    80003382:	eec080e7          	jalr	-276(ra) # 8000126a <acquire>
  np->state = RUNNABLE;
    80003386:	fd843783          	ld	a5,-40(s0)
    8000338a:	470d                	li	a4,3
    8000338c:	cf98                	sw	a4,24(a5)
  release(&np->lock);
    8000338e:	fd843783          	ld	a5,-40(s0)
    80003392:	853e                	mv	a0,a5
    80003394:	ffffe097          	auipc	ra,0xffffe
    80003398:	f3a080e7          	jalr	-198(ra) # 800012ce <release>

  return pid;
    8000339c:	fd442783          	lw	a5,-44(s0)
}
    800033a0:	853e                	mv	a0,a5
    800033a2:	70a2                	ld	ra,40(sp)
    800033a4:	7402                	ld	s0,32(sp)
    800033a6:	6145                	addi	sp,sp,48
    800033a8:	8082                	ret

00000000800033aa <reparent>:

// Pass p's abandoned children to init.
// Caller must hold wait_lock.
void
reparent(struct proc *p)
{
    800033aa:	7179                	addi	sp,sp,-48
    800033ac:	f406                	sd	ra,40(sp)
    800033ae:	f022                	sd	s0,32(sp)
    800033b0:	1800                	addi	s0,sp,48
    800033b2:	fca43c23          	sd	a0,-40(s0)
  struct proc *pp;

  for(pp = proc; pp < &proc[NPROC]; pp++){
    800033b6:	00011797          	auipc	a5,0x11
    800033ba:	2e278793          	addi	a5,a5,738 # 80014698 <proc>
    800033be:	fef43423          	sd	a5,-24(s0)
    800033c2:	a091                	j	80003406 <reparent+0x5c>
    if(pp->parent == p){
    800033c4:	fe843783          	ld	a5,-24(s0)
    800033c8:	7f9c                	ld	a5,56(a5)
    800033ca:	fd843703          	ld	a4,-40(s0)
    800033ce:	02f71463          	bne	a4,a5,800033f6 <reparent+0x4c>
      pp->parent = initproc;
    800033d2:	00009797          	auipc	a5,0x9
    800033d6:	c4e78793          	addi	a5,a5,-946 # 8000c020 <initproc>
    800033da:	6398                	ld	a4,0(a5)
    800033dc:	fe843783          	ld	a5,-24(s0)
    800033e0:	ff98                	sd	a4,56(a5)
      wakeup(initproc);
    800033e2:	00009797          	auipc	a5,0x9
    800033e6:	c3e78793          	addi	a5,a5,-962 # 8000c020 <initproc>
    800033ea:	639c                	ld	a5,0(a5)
    800033ec:	853e                	mv	a0,a5
    800033ee:	00000097          	auipc	ra,0x0
    800033f2:	5b0080e7          	jalr	1456(ra) # 8000399e <wakeup>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800033f6:	fe843703          	ld	a4,-24(s0)
    800033fa:	67c9                	lui	a5,0x12
    800033fc:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80003400:	97ba                	add	a5,a5,a4
    80003402:	fef43423          	sd	a5,-24(s0)
    80003406:	fe843703          	ld	a4,-24(s0)
    8000340a:	00497797          	auipc	a5,0x497
    8000340e:	68e78793          	addi	a5,a5,1678 # 8049aa98 <pid_lock>
    80003412:	faf769e3          	bltu	a4,a5,800033c4 <reparent+0x1a>
    }
  }
}
    80003416:	0001                	nop
    80003418:	0001                	nop
    8000341a:	70a2                	ld	ra,40(sp)
    8000341c:	7402                	ld	s0,32(sp)
    8000341e:	6145                	addi	sp,sp,48
    80003420:	8082                	ret

0000000080003422 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait().
void
exit(int status)
{
    80003422:	7139                	addi	sp,sp,-64
    80003424:	fc06                	sd	ra,56(sp)
    80003426:	f822                	sd	s0,48(sp)
    80003428:	0080                	addi	s0,sp,64
    8000342a:	87aa                	mv	a5,a0
    8000342c:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    80003430:	fffff097          	auipc	ra,0xfffff
    80003434:	5e8080e7          	jalr	1512(ra) # 80002a18 <myproc>
    80003438:	fea43023          	sd	a0,-32(s0)

  if(p == initproc)
    8000343c:	00009797          	auipc	a5,0x9
    80003440:	be478793          	addi	a5,a5,-1052 # 8000c020 <initproc>
    80003444:	639c                	ld	a5,0(a5)
    80003446:	fe043703          	ld	a4,-32(s0)
    8000344a:	00f71a63          	bne	a4,a5,8000345e <exit+0x3c>
    panic("init exiting");
    8000344e:	00008517          	auipc	a0,0x8
    80003452:	e4a50513          	addi	a0,a0,-438 # 8000b298 <etext+0x298>
    80003456:	ffffe097          	auipc	ra,0xffffe
    8000345a:	824080e7          	jalr	-2012(ra) # 80000c7a <panic>

  // Close all open files.
  for(int fd = 0; fd < NOFILE; fd++){
    8000345e:	fe042623          	sw	zero,-20(s0)
    80003462:	a881                	j	800034b2 <exit+0x90>
    if(p->ofile[fd]){
    80003464:	fe043703          	ld	a4,-32(s0)
    80003468:	fec42783          	lw	a5,-20(s0)
    8000346c:	07f1                	addi	a5,a5,28
    8000346e:	078e                	slli	a5,a5,0x3
    80003470:	97ba                	add	a5,a5,a4
    80003472:	639c                	ld	a5,0(a5)
    80003474:	cb95                	beqz	a5,800034a8 <exit+0x86>
      struct file *f = p->ofile[fd];
    80003476:	fe043703          	ld	a4,-32(s0)
    8000347a:	fec42783          	lw	a5,-20(s0)
    8000347e:	07f1                	addi	a5,a5,28
    80003480:	078e                	slli	a5,a5,0x3
    80003482:	97ba                	add	a5,a5,a4
    80003484:	639c                	ld	a5,0(a5)
    80003486:	fcf43c23          	sd	a5,-40(s0)
      fileclose(f);
    8000348a:	fd843503          	ld	a0,-40(s0)
    8000348e:	00004097          	auipc	ra,0x4
    80003492:	f84080e7          	jalr	-124(ra) # 80007412 <fileclose>
      p->ofile[fd] = 0;
    80003496:	fe043703          	ld	a4,-32(s0)
    8000349a:	fec42783          	lw	a5,-20(s0)
    8000349e:	07f1                	addi	a5,a5,28
    800034a0:	078e                	slli	a5,a5,0x3
    800034a2:	97ba                	add	a5,a5,a4
    800034a4:	0007b023          	sd	zero,0(a5)
  for(int fd = 0; fd < NOFILE; fd++){
    800034a8:	fec42783          	lw	a5,-20(s0)
    800034ac:	2785                	addiw	a5,a5,1
    800034ae:	fef42623          	sw	a5,-20(s0)
    800034b2:	fec42783          	lw	a5,-20(s0)
    800034b6:	0007871b          	sext.w	a4,a5
    800034ba:	47bd                	li	a5,15
    800034bc:	fae7d4e3          	bge	a5,a4,80003464 <exit+0x42>
    }
  }

  begin_op();
    800034c0:	00004097          	auipc	ra,0x4
    800034c4:	8b8080e7          	jalr	-1864(ra) # 80006d78 <begin_op>
  iput(p->cwd);
    800034c8:	fe043783          	ld	a5,-32(s0)
    800034cc:	1607b783          	ld	a5,352(a5)
    800034d0:	853e                	mv	a0,a5
    800034d2:	00003097          	auipc	ra,0x3
    800034d6:	9cc080e7          	jalr	-1588(ra) # 80005e9e <iput>
  end_op();
    800034da:	00004097          	auipc	ra,0x4
    800034de:	960080e7          	jalr	-1696(ra) # 80006e3a <end_op>
  p->cwd = 0;
    800034e2:	fe043783          	ld	a5,-32(s0)
    800034e6:	1607b023          	sd	zero,352(a5)

  acquire(&wait_lock);
    800034ea:	00497517          	auipc	a0,0x497
    800034ee:	5c650513          	addi	a0,a0,1478 # 8049aab0 <wait_lock>
    800034f2:	ffffe097          	auipc	ra,0xffffe
    800034f6:	d78080e7          	jalr	-648(ra) # 8000126a <acquire>

  // Give any children to init.
  reparent(p);
    800034fa:	fe043503          	ld	a0,-32(s0)
    800034fe:	00000097          	auipc	ra,0x0
    80003502:	eac080e7          	jalr	-340(ra) # 800033aa <reparent>

  // Parent might be sleeping in wait().
  wakeup(p->parent);
    80003506:	fe043783          	ld	a5,-32(s0)
    8000350a:	7f9c                	ld	a5,56(a5)
    8000350c:	853e                	mv	a0,a5
    8000350e:	00000097          	auipc	ra,0x0
    80003512:	490080e7          	jalr	1168(ra) # 8000399e <wakeup>
  
  acquire(&p->lock);
    80003516:	fe043783          	ld	a5,-32(s0)
    8000351a:	853e                	mv	a0,a5
    8000351c:	ffffe097          	auipc	ra,0xffffe
    80003520:	d4e080e7          	jalr	-690(ra) # 8000126a <acquire>

  p->xstate = status;
    80003524:	fe043783          	ld	a5,-32(s0)
    80003528:	fcc42703          	lw	a4,-52(s0)
    8000352c:	d7d8                	sw	a4,44(a5)
  p->state = ZOMBIE;
    8000352e:	fe043783          	ld	a5,-32(s0)
    80003532:	4715                	li	a4,5
    80003534:	cf98                	sw	a4,24(a5)

  release(&wait_lock);
    80003536:	00497517          	auipc	a0,0x497
    8000353a:	57a50513          	addi	a0,a0,1402 # 8049aab0 <wait_lock>
    8000353e:	ffffe097          	auipc	ra,0xffffe
    80003542:	d90080e7          	jalr	-624(ra) # 800012ce <release>

  // Jump into the scheduler, never to return.
  sched();
    80003546:	00000097          	auipc	ra,0x0
    8000354a:	260080e7          	jalr	608(ra) # 800037a6 <sched>
  panic("zombie exit");
    8000354e:	00008517          	auipc	a0,0x8
    80003552:	d5a50513          	addi	a0,a0,-678 # 8000b2a8 <etext+0x2a8>
    80003556:	ffffd097          	auipc	ra,0xffffd
    8000355a:	724080e7          	jalr	1828(ra) # 80000c7a <panic>

000000008000355e <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(uint64 addr)
{
    8000355e:	7139                	addi	sp,sp,-64
    80003560:	fc06                	sd	ra,56(sp)
    80003562:	f822                	sd	s0,48(sp)
    80003564:	0080                	addi	s0,sp,64
    80003566:	fca43423          	sd	a0,-56(s0)
  struct proc *np;
  int havekids, pid;
  struct proc *p = myproc();
    8000356a:	fffff097          	auipc	ra,0xfffff
    8000356e:	4ae080e7          	jalr	1198(ra) # 80002a18 <myproc>
    80003572:	fca43c23          	sd	a0,-40(s0)

  acquire(&wait_lock);
    80003576:	00497517          	auipc	a0,0x497
    8000357a:	53a50513          	addi	a0,a0,1338 # 8049aab0 <wait_lock>
    8000357e:	ffffe097          	auipc	ra,0xffffe
    80003582:	cec080e7          	jalr	-788(ra) # 8000126a <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    80003586:	fe042223          	sw	zero,-28(s0)
    for(np = proc; np < &proc[NPROC]; np++){
    8000358a:	00011797          	auipc	a5,0x11
    8000358e:	10e78793          	addi	a5,a5,270 # 80014698 <proc>
    80003592:	fef43423          	sd	a5,-24(s0)
    80003596:	a221                	j	8000369e <wait+0x140>
      if(np->parent == p && !np->thread){ //Proceso hijo no puede compartir el espacio de direcciones el padre
    80003598:	fe843783          	ld	a5,-24(s0)
    8000359c:	7f9c                	ld	a5,56(a5)
    8000359e:	fd843703          	ld	a4,-40(s0)
    800035a2:	0ef71663          	bne	a4,a5,8000368e <wait+0x130>
    800035a6:	fe843703          	ld	a4,-24(s0)
    800035aa:	67c9                	lui	a5,0x12
    800035ac:	97ba                	add	a5,a5,a4
    800035ae:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    800035b2:	eff1                	bnez	a5,8000368e <wait+0x130>
        // make sure the child isn't still in exit() or swtch().
        acquire(&np->lock);
    800035b4:	fe843783          	ld	a5,-24(s0)
    800035b8:	853e                	mv	a0,a5
    800035ba:	ffffe097          	auipc	ra,0xffffe
    800035be:	cb0080e7          	jalr	-848(ra) # 8000126a <acquire>

        havekids = 1;
    800035c2:	4785                	li	a5,1
    800035c4:	fef42223          	sw	a5,-28(s0)
        if(np->state == ZOMBIE){ 
    800035c8:	fe843783          	ld	a5,-24(s0)
    800035cc:	4f9c                	lw	a5,24(a5)
    800035ce:	873e                	mv	a4,a5
    800035d0:	4795                	li	a5,5
    800035d2:	0af71763          	bne	a4,a5,80003680 <wait+0x122>
          // Found one.
          pid = np->pid;
    800035d6:	fe843783          	ld	a5,-24(s0)
    800035da:	5b9c                	lw	a5,48(a5)
    800035dc:	fcf42a23          	sw	a5,-44(s0)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    800035e0:	fc843783          	ld	a5,-56(s0)
    800035e4:	c7a9                	beqz	a5,8000362e <wait+0xd0>
    800035e6:	fd843783          	ld	a5,-40(s0)
    800035ea:	6bb8                	ld	a4,80(a5)
    800035ec:	fe843783          	ld	a5,-24(s0)
    800035f0:	02c78793          	addi	a5,a5,44
    800035f4:	4691                	li	a3,4
    800035f6:	863e                	mv	a2,a5
    800035f8:	fc843583          	ld	a1,-56(s0)
    800035fc:	853a                	mv	a0,a4
    800035fe:	fffff097          	auipc	ra,0xfffff
    80003602:	dc8080e7          	jalr	-568(ra) # 800023c6 <copyout>
    80003606:	87aa                	mv	a5,a0
    80003608:	0207d363          	bgez	a5,8000362e <wait+0xd0>
                                  sizeof(np->xstate)) < 0) {
            release(&np->lock);
    8000360c:	fe843783          	ld	a5,-24(s0)
    80003610:	853e                	mv	a0,a5
    80003612:	ffffe097          	auipc	ra,0xffffe
    80003616:	cbc080e7          	jalr	-836(ra) # 800012ce <release>
            release(&wait_lock);
    8000361a:	00497517          	auipc	a0,0x497
    8000361e:	49650513          	addi	a0,a0,1174 # 8049aab0 <wait_lock>
    80003622:	ffffe097          	auipc	ra,0xffffe
    80003626:	cac080e7          	jalr	-852(ra) # 800012ce <release>
            return -1;
    8000362a:	57fd                	li	a5,-1
    8000362c:	a875                	j	800036e8 <wait+0x18a>
          }
          
          if (np->thread == 1){
    8000362e:	fe843703          	ld	a4,-24(s0)
    80003632:	67c9                	lui	a5,0x12
    80003634:	97ba                	add	a5,a5,a4
    80003636:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    8000363a:	873e                	mv	a4,a5
    8000363c:	4785                	li	a5,1
    8000363e:	00f71963          	bne	a4,a5,80003650 <wait+0xf2>
            freethread(np);
    80003642:	fe843503          	ld	a0,-24(s0)
    80003646:	fffff097          	auipc	ra,0xfffff
    8000364a:	674080e7          	jalr	1652(ra) # 80002cba <freethread>
    8000364e:	a039                	j	8000365c <wait+0xfe>
          } else {
              freeproc(np);
    80003650:	fe843503          	ld	a0,-24(s0)
    80003654:	fffff097          	auipc	ra,0xfffff
    80003658:	5c8080e7          	jalr	1480(ra) # 80002c1c <freeproc>
          }

          release(&np->lock);
    8000365c:	fe843783          	ld	a5,-24(s0)
    80003660:	853e                	mv	a0,a5
    80003662:	ffffe097          	auipc	ra,0xffffe
    80003666:	c6c080e7          	jalr	-916(ra) # 800012ce <release>
          release(&wait_lock);
    8000366a:	00497517          	auipc	a0,0x497
    8000366e:	44650513          	addi	a0,a0,1094 # 8049aab0 <wait_lock>
    80003672:	ffffe097          	auipc	ra,0xffffe
    80003676:	c5c080e7          	jalr	-932(ra) # 800012ce <release>
          return pid;
    8000367a:	fd442783          	lw	a5,-44(s0)
    8000367e:	a0ad                	j	800036e8 <wait+0x18a>
        }
        release(&np->lock);
    80003680:	fe843783          	ld	a5,-24(s0)
    80003684:	853e                	mv	a0,a5
    80003686:	ffffe097          	auipc	ra,0xffffe
    8000368a:	c48080e7          	jalr	-952(ra) # 800012ce <release>
    for(np = proc; np < &proc[NPROC]; np++){
    8000368e:	fe843703          	ld	a4,-24(s0)
    80003692:	67c9                	lui	a5,0x12
    80003694:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80003698:	97ba                	add	a5,a5,a4
    8000369a:	fef43423          	sd	a5,-24(s0)
    8000369e:	fe843703          	ld	a4,-24(s0)
    800036a2:	00497797          	auipc	a5,0x497
    800036a6:	3f678793          	addi	a5,a5,1014 # 8049aa98 <pid_lock>
    800036aa:	eef767e3          	bltu	a4,a5,80003598 <wait+0x3a>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || p->killed){
    800036ae:	fe442783          	lw	a5,-28(s0)
    800036b2:	2781                	sext.w	a5,a5
    800036b4:	c789                	beqz	a5,800036be <wait+0x160>
    800036b6:	fd843783          	ld	a5,-40(s0)
    800036ba:	579c                	lw	a5,40(a5)
    800036bc:	cb99                	beqz	a5,800036d2 <wait+0x174>
      release(&wait_lock);
    800036be:	00497517          	auipc	a0,0x497
    800036c2:	3f250513          	addi	a0,a0,1010 # 8049aab0 <wait_lock>
    800036c6:	ffffe097          	auipc	ra,0xffffe
    800036ca:	c08080e7          	jalr	-1016(ra) # 800012ce <release>
      return -1;
    800036ce:	57fd                	li	a5,-1
    800036d0:	a821                	j	800036e8 <wait+0x18a>
    }
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800036d2:	00497597          	auipc	a1,0x497
    800036d6:	3de58593          	addi	a1,a1,990 # 8049aab0 <wait_lock>
    800036da:	fd843503          	ld	a0,-40(s0)
    800036de:	00000097          	auipc	ra,0x0
    800036e2:	244080e7          	jalr	580(ra) # 80003922 <sleep>
    havekids = 0;
    800036e6:	b545                	j	80003586 <wait+0x28>
  }
}
    800036e8:	853e                	mv	a0,a5
    800036ea:	70e2                	ld	ra,56(sp)
    800036ec:	7442                	ld	s0,48(sp)
    800036ee:	6121                	addi	sp,sp,64
    800036f0:	8082                	ret

00000000800036f2 <scheduler>:
//  - swtch to start running that process.
//  - eventually that process transfers control
//    via swtch back to the scheduler.
void
scheduler(void)
{
    800036f2:	1101                	addi	sp,sp,-32
    800036f4:	ec06                	sd	ra,24(sp)
    800036f6:	e822                	sd	s0,16(sp)
    800036f8:	1000                	addi	s0,sp,32
  struct proc *p;
  struct cpu *c = mycpu();
    800036fa:	fffff097          	auipc	ra,0xfffff
    800036fe:	2e4080e7          	jalr	740(ra) # 800029de <mycpu>
    80003702:	fea43023          	sd	a0,-32(s0)
  
  c->proc = 0;
    80003706:	fe043783          	ld	a5,-32(s0)
    8000370a:	0007b023          	sd	zero,0(a5)
  for(;;){
    // Avoid deadlock by ensuring that devices can interrupt.
    intr_on();
    8000370e:	fffff097          	auipc	ra,0xfffff
    80003712:	0b2080e7          	jalr	178(ra) # 800027c0 <intr_on>

    for(p = proc; p < &proc[NPROC]; p++) {
    80003716:	00011797          	auipc	a5,0x11
    8000371a:	f8278793          	addi	a5,a5,-126 # 80014698 <proc>
    8000371e:	fef43423          	sd	a5,-24(s0)
    80003722:	a88d                	j	80003794 <scheduler+0xa2>
      acquire(&p->lock);
    80003724:	fe843783          	ld	a5,-24(s0)
    80003728:	853e                	mv	a0,a5
    8000372a:	ffffe097          	auipc	ra,0xffffe
    8000372e:	b40080e7          	jalr	-1216(ra) # 8000126a <acquire>
      if(p->state == RUNNABLE) {
    80003732:	fe843783          	ld	a5,-24(s0)
    80003736:	4f9c                	lw	a5,24(a5)
    80003738:	873e                	mv	a4,a5
    8000373a:	478d                	li	a5,3
    8000373c:	02f71d63          	bne	a4,a5,80003776 <scheduler+0x84>
        // Switch to chosen process.  It is the process's job
        // to release its lock and then reacquire it
        // before jumping back to us.
        p->state = RUNNING;
    80003740:	fe843783          	ld	a5,-24(s0)
    80003744:	4711                	li	a4,4
    80003746:	cf98                	sw	a4,24(a5)
        c->proc = p;
    80003748:	fe043783          	ld	a5,-32(s0)
    8000374c:	fe843703          	ld	a4,-24(s0)
    80003750:	e398                	sd	a4,0(a5)
        swtch(&c->context, &p->context);
    80003752:	fe043783          	ld	a5,-32(s0)
    80003756:	00878713          	addi	a4,a5,8
    8000375a:	fe843783          	ld	a5,-24(s0)
    8000375e:	07078793          	addi	a5,a5,112
    80003762:	85be                	mv	a1,a5
    80003764:	853a                	mv	a0,a4
    80003766:	00001097          	auipc	ra,0x1
    8000376a:	b52080e7          	jalr	-1198(ra) # 800042b8 <swtch>

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
    8000376e:	fe043783          	ld	a5,-32(s0)
    80003772:	0007b023          	sd	zero,0(a5)
      }
      release(&p->lock);
    80003776:	fe843783          	ld	a5,-24(s0)
    8000377a:	853e                	mv	a0,a5
    8000377c:	ffffe097          	auipc	ra,0xffffe
    80003780:	b52080e7          	jalr	-1198(ra) # 800012ce <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80003784:	fe843703          	ld	a4,-24(s0)
    80003788:	67c9                	lui	a5,0x12
    8000378a:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    8000378e:	97ba                	add	a5,a5,a4
    80003790:	fef43423          	sd	a5,-24(s0)
    80003794:	fe843703          	ld	a4,-24(s0)
    80003798:	00497797          	auipc	a5,0x497
    8000379c:	30078793          	addi	a5,a5,768 # 8049aa98 <pid_lock>
    800037a0:	f8f762e3          	bltu	a4,a5,80003724 <scheduler+0x32>
    intr_on();
    800037a4:	b7ad                	j	8000370e <scheduler+0x1c>

00000000800037a6 <sched>:
// be proc->intena and proc->noff, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
    800037a6:	7179                	addi	sp,sp,-48
    800037a8:	f406                	sd	ra,40(sp)
    800037aa:	f022                	sd	s0,32(sp)
    800037ac:	ec26                	sd	s1,24(sp)
    800037ae:	1800                	addi	s0,sp,48
  int intena;
  struct proc *p = myproc();
    800037b0:	fffff097          	auipc	ra,0xfffff
    800037b4:	268080e7          	jalr	616(ra) # 80002a18 <myproc>
    800037b8:	fca43c23          	sd	a0,-40(s0)

  if(!holding(&p->lock))
    800037bc:	fd843783          	ld	a5,-40(s0)
    800037c0:	853e                	mv	a0,a5
    800037c2:	ffffe097          	auipc	ra,0xffffe
    800037c6:	b62080e7          	jalr	-1182(ra) # 80001324 <holding>
    800037ca:	87aa                	mv	a5,a0
    800037cc:	eb89                	bnez	a5,800037de <sched+0x38>
    panic("sched p->lock");
    800037ce:	00008517          	auipc	a0,0x8
    800037d2:	aea50513          	addi	a0,a0,-1302 # 8000b2b8 <etext+0x2b8>
    800037d6:	ffffd097          	auipc	ra,0xffffd
    800037da:	4a4080e7          	jalr	1188(ra) # 80000c7a <panic>
  if(mycpu()->noff != 1)
    800037de:	fffff097          	auipc	ra,0xfffff
    800037e2:	200080e7          	jalr	512(ra) # 800029de <mycpu>
    800037e6:	87aa                	mv	a5,a0
    800037e8:	5fbc                	lw	a5,120(a5)
    800037ea:	873e                	mv	a4,a5
    800037ec:	4785                	li	a5,1
    800037ee:	00f70a63          	beq	a4,a5,80003802 <sched+0x5c>
    panic("sched locks");
    800037f2:	00008517          	auipc	a0,0x8
    800037f6:	ad650513          	addi	a0,a0,-1322 # 8000b2c8 <etext+0x2c8>
    800037fa:	ffffd097          	auipc	ra,0xffffd
    800037fe:	480080e7          	jalr	1152(ra) # 80000c7a <panic>
  if(p->state == RUNNING)
    80003802:	fd843783          	ld	a5,-40(s0)
    80003806:	4f9c                	lw	a5,24(a5)
    80003808:	873e                	mv	a4,a5
    8000380a:	4791                	li	a5,4
    8000380c:	00f71a63          	bne	a4,a5,80003820 <sched+0x7a>
    panic("sched running");
    80003810:	00008517          	auipc	a0,0x8
    80003814:	ac850513          	addi	a0,a0,-1336 # 8000b2d8 <etext+0x2d8>
    80003818:	ffffd097          	auipc	ra,0xffffd
    8000381c:	462080e7          	jalr	1122(ra) # 80000c7a <panic>
  if(intr_get())
    80003820:	fffff097          	auipc	ra,0xfffff
    80003824:	fca080e7          	jalr	-54(ra) # 800027ea <intr_get>
    80003828:	87aa                	mv	a5,a0
    8000382a:	cb89                	beqz	a5,8000383c <sched+0x96>
    panic("sched interruptible");
    8000382c:	00008517          	auipc	a0,0x8
    80003830:	abc50513          	addi	a0,a0,-1348 # 8000b2e8 <etext+0x2e8>
    80003834:	ffffd097          	auipc	ra,0xffffd
    80003838:	446080e7          	jalr	1094(ra) # 80000c7a <panic>

  intena = mycpu()->intena;
    8000383c:	fffff097          	auipc	ra,0xfffff
    80003840:	1a2080e7          	jalr	418(ra) # 800029de <mycpu>
    80003844:	87aa                	mv	a5,a0
    80003846:	5ffc                	lw	a5,124(a5)
    80003848:	fcf42a23          	sw	a5,-44(s0)
  swtch(&p->context, &mycpu()->context);
    8000384c:	fd843783          	ld	a5,-40(s0)
    80003850:	07078493          	addi	s1,a5,112
    80003854:	fffff097          	auipc	ra,0xfffff
    80003858:	18a080e7          	jalr	394(ra) # 800029de <mycpu>
    8000385c:	87aa                	mv	a5,a0
    8000385e:	07a1                	addi	a5,a5,8
    80003860:	85be                	mv	a1,a5
    80003862:	8526                	mv	a0,s1
    80003864:	00001097          	auipc	ra,0x1
    80003868:	a54080e7          	jalr	-1452(ra) # 800042b8 <swtch>
  mycpu()->intena = intena;
    8000386c:	fffff097          	auipc	ra,0xfffff
    80003870:	172080e7          	jalr	370(ra) # 800029de <mycpu>
    80003874:	872a                	mv	a4,a0
    80003876:	fd442783          	lw	a5,-44(s0)
    8000387a:	df7c                	sw	a5,124(a4)
}
    8000387c:	0001                	nop
    8000387e:	70a2                	ld	ra,40(sp)
    80003880:	7402                	ld	s0,32(sp)
    80003882:	64e2                	ld	s1,24(sp)
    80003884:	6145                	addi	sp,sp,48
    80003886:	8082                	ret

0000000080003888 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
    80003888:	1101                	addi	sp,sp,-32
    8000388a:	ec06                	sd	ra,24(sp)
    8000388c:	e822                	sd	s0,16(sp)
    8000388e:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80003890:	fffff097          	auipc	ra,0xfffff
    80003894:	188080e7          	jalr	392(ra) # 80002a18 <myproc>
    80003898:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    8000389c:	fe843783          	ld	a5,-24(s0)
    800038a0:	853e                	mv	a0,a5
    800038a2:	ffffe097          	auipc	ra,0xffffe
    800038a6:	9c8080e7          	jalr	-1592(ra) # 8000126a <acquire>
  p->state = RUNNABLE;
    800038aa:	fe843783          	ld	a5,-24(s0)
    800038ae:	470d                	li	a4,3
    800038b0:	cf98                	sw	a4,24(a5)
  sched();
    800038b2:	00000097          	auipc	ra,0x0
    800038b6:	ef4080e7          	jalr	-268(ra) # 800037a6 <sched>
  release(&p->lock);
    800038ba:	fe843783          	ld	a5,-24(s0)
    800038be:	853e                	mv	a0,a5
    800038c0:	ffffe097          	auipc	ra,0xffffe
    800038c4:	a0e080e7          	jalr	-1522(ra) # 800012ce <release>
}
    800038c8:	0001                	nop
    800038ca:	60e2                	ld	ra,24(sp)
    800038cc:	6442                	ld	s0,16(sp)
    800038ce:	6105                	addi	sp,sp,32
    800038d0:	8082                	ret

00000000800038d2 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    800038d2:	1141                	addi	sp,sp,-16
    800038d4:	e406                	sd	ra,8(sp)
    800038d6:	e022                	sd	s0,0(sp)
    800038d8:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    800038da:	fffff097          	auipc	ra,0xfffff
    800038de:	13e080e7          	jalr	318(ra) # 80002a18 <myproc>
    800038e2:	87aa                	mv	a5,a0
    800038e4:	853e                	mv	a0,a5
    800038e6:	ffffe097          	auipc	ra,0xffffe
    800038ea:	9e8080e7          	jalr	-1560(ra) # 800012ce <release>

  if (first) {
    800038ee:	00008797          	auipc	a5,0x8
    800038f2:	fe678793          	addi	a5,a5,-26 # 8000b8d4 <first.1>
    800038f6:	439c                	lw	a5,0(a5)
    800038f8:	cf81                	beqz	a5,80003910 <forkret+0x3e>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    first = 0;
    800038fa:	00008797          	auipc	a5,0x8
    800038fe:	fda78793          	addi	a5,a5,-38 # 8000b8d4 <first.1>
    80003902:	0007a023          	sw	zero,0(a5)
    fsinit(ROOTDEV);
    80003906:	4505                	li	a0,1
    80003908:	00002097          	auipc	ra,0x2
    8000390c:	cae080e7          	jalr	-850(ra) # 800055b6 <fsinit>
  }

  usertrapret();
    80003910:	00001097          	auipc	ra,0x1
    80003914:	d46080e7          	jalr	-698(ra) # 80004656 <usertrapret>
}
    80003918:	0001                	nop
    8000391a:	60a2                	ld	ra,8(sp)
    8000391c:	6402                	ld	s0,0(sp)
    8000391e:	0141                	addi	sp,sp,16
    80003920:	8082                	ret

0000000080003922 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80003922:	7179                	addi	sp,sp,-48
    80003924:	f406                	sd	ra,40(sp)
    80003926:	f022                	sd	s0,32(sp)
    80003928:	1800                	addi	s0,sp,48
    8000392a:	fca43c23          	sd	a0,-40(s0)
    8000392e:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    80003932:	fffff097          	auipc	ra,0xfffff
    80003936:	0e6080e7          	jalr	230(ra) # 80002a18 <myproc>
    8000393a:	fea43423          	sd	a0,-24(s0)
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    8000393e:	fe843783          	ld	a5,-24(s0)
    80003942:	853e                	mv	a0,a5
    80003944:	ffffe097          	auipc	ra,0xffffe
    80003948:	926080e7          	jalr	-1754(ra) # 8000126a <acquire>
  release(lk);
    8000394c:	fd043503          	ld	a0,-48(s0)
    80003950:	ffffe097          	auipc	ra,0xffffe
    80003954:	97e080e7          	jalr	-1666(ra) # 800012ce <release>

  // Go to sleep.
  p->chan = chan;
    80003958:	fe843783          	ld	a5,-24(s0)
    8000395c:	fd843703          	ld	a4,-40(s0)
    80003960:	f398                	sd	a4,32(a5)
  p->state = SLEEPING;
    80003962:	fe843783          	ld	a5,-24(s0)
    80003966:	4709                	li	a4,2
    80003968:	cf98                	sw	a4,24(a5)

  sched();
    8000396a:	00000097          	auipc	ra,0x0
    8000396e:	e3c080e7          	jalr	-452(ra) # 800037a6 <sched>

  // Tidy up.
  p->chan = 0;
    80003972:	fe843783          	ld	a5,-24(s0)
    80003976:	0207b023          	sd	zero,32(a5)

  // Reacquire original lock.
  release(&p->lock);
    8000397a:	fe843783          	ld	a5,-24(s0)
    8000397e:	853e                	mv	a0,a5
    80003980:	ffffe097          	auipc	ra,0xffffe
    80003984:	94e080e7          	jalr	-1714(ra) # 800012ce <release>
  acquire(lk);
    80003988:	fd043503          	ld	a0,-48(s0)
    8000398c:	ffffe097          	auipc	ra,0xffffe
    80003990:	8de080e7          	jalr	-1826(ra) # 8000126a <acquire>
}
    80003994:	0001                	nop
    80003996:	70a2                	ld	ra,40(sp)
    80003998:	7402                	ld	s0,32(sp)
    8000399a:	6145                	addi	sp,sp,48
    8000399c:	8082                	ret

000000008000399e <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    8000399e:	7179                	addi	sp,sp,-48
    800039a0:	f406                	sd	ra,40(sp)
    800039a2:	f022                	sd	s0,32(sp)
    800039a4:	1800                	addi	s0,sp,48
    800039a6:	fca43c23          	sd	a0,-40(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800039aa:	00011797          	auipc	a5,0x11
    800039ae:	cee78793          	addi	a5,a5,-786 # 80014698 <proc>
    800039b2:	fef43423          	sd	a5,-24(s0)
    800039b6:	a095                	j	80003a1a <wakeup+0x7c>
    if(p != myproc()){
    800039b8:	fffff097          	auipc	ra,0xfffff
    800039bc:	060080e7          	jalr	96(ra) # 80002a18 <myproc>
    800039c0:	872a                	mv	a4,a0
    800039c2:	fe843783          	ld	a5,-24(s0)
    800039c6:	04e78263          	beq	a5,a4,80003a0a <wakeup+0x6c>
      acquire(&p->lock);
    800039ca:	fe843783          	ld	a5,-24(s0)
    800039ce:	853e                	mv	a0,a5
    800039d0:	ffffe097          	auipc	ra,0xffffe
    800039d4:	89a080e7          	jalr	-1894(ra) # 8000126a <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800039d8:	fe843783          	ld	a5,-24(s0)
    800039dc:	4f9c                	lw	a5,24(a5)
    800039de:	873e                	mv	a4,a5
    800039e0:	4789                	li	a5,2
    800039e2:	00f71d63          	bne	a4,a5,800039fc <wakeup+0x5e>
    800039e6:	fe843783          	ld	a5,-24(s0)
    800039ea:	739c                	ld	a5,32(a5)
    800039ec:	fd843703          	ld	a4,-40(s0)
    800039f0:	00f71663          	bne	a4,a5,800039fc <wakeup+0x5e>
        p->state = RUNNABLE;
    800039f4:	fe843783          	ld	a5,-24(s0)
    800039f8:	470d                	li	a4,3
    800039fa:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    800039fc:	fe843783          	ld	a5,-24(s0)
    80003a00:	853e                	mv	a0,a5
    80003a02:	ffffe097          	auipc	ra,0xffffe
    80003a06:	8cc080e7          	jalr	-1844(ra) # 800012ce <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80003a0a:	fe843703          	ld	a4,-24(s0)
    80003a0e:	67c9                	lui	a5,0x12
    80003a10:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80003a14:	97ba                	add	a5,a5,a4
    80003a16:	fef43423          	sd	a5,-24(s0)
    80003a1a:	fe843703          	ld	a4,-24(s0)
    80003a1e:	00497797          	auipc	a5,0x497
    80003a22:	07a78793          	addi	a5,a5,122 # 8049aa98 <pid_lock>
    80003a26:	f8f769e3          	bltu	a4,a5,800039b8 <wakeup+0x1a>
    }
  }
}
    80003a2a:	0001                	nop
    80003a2c:	0001                	nop
    80003a2e:	70a2                	ld	ra,40(sp)
    80003a30:	7402                	ld	s0,32(sp)
    80003a32:	6145                	addi	sp,sp,48
    80003a34:	8082                	ret

0000000080003a36 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80003a36:	7179                	addi	sp,sp,-48
    80003a38:	f406                	sd	ra,40(sp)
    80003a3a:	f022                	sd	s0,32(sp)
    80003a3c:	1800                	addi	s0,sp,48
    80003a3e:	87aa                	mv	a5,a0
    80003a40:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80003a44:	00011797          	auipc	a5,0x11
    80003a48:	c5478793          	addi	a5,a5,-940 # 80014698 <proc>
    80003a4c:	fef43423          	sd	a5,-24(s0)
    80003a50:	a0bd                	j	80003abe <kill+0x88>
    acquire(&p->lock);
    80003a52:	fe843783          	ld	a5,-24(s0)
    80003a56:	853e                	mv	a0,a5
    80003a58:	ffffe097          	auipc	ra,0xffffe
    80003a5c:	812080e7          	jalr	-2030(ra) # 8000126a <acquire>
    if(p->pid == pid){
    80003a60:	fe843783          	ld	a5,-24(s0)
    80003a64:	5b98                	lw	a4,48(a5)
    80003a66:	fdc42783          	lw	a5,-36(s0)
    80003a6a:	2781                	sext.w	a5,a5
    80003a6c:	02e79a63          	bne	a5,a4,80003aa0 <kill+0x6a>
      p->killed = 1;
    80003a70:	fe843783          	ld	a5,-24(s0)
    80003a74:	4705                	li	a4,1
    80003a76:	d798                	sw	a4,40(a5)
      if(p->state == SLEEPING){
    80003a78:	fe843783          	ld	a5,-24(s0)
    80003a7c:	4f9c                	lw	a5,24(a5)
    80003a7e:	873e                	mv	a4,a5
    80003a80:	4789                	li	a5,2
    80003a82:	00f71663          	bne	a4,a5,80003a8e <kill+0x58>
        // Wake process from sleep().
        p->state = RUNNABLE;
    80003a86:	fe843783          	ld	a5,-24(s0)
    80003a8a:	470d                	li	a4,3
    80003a8c:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    80003a8e:	fe843783          	ld	a5,-24(s0)
    80003a92:	853e                	mv	a0,a5
    80003a94:	ffffe097          	auipc	ra,0xffffe
    80003a98:	83a080e7          	jalr	-1990(ra) # 800012ce <release>
      return 0;
    80003a9c:	4781                	li	a5,0
    80003a9e:	a80d                	j	80003ad0 <kill+0x9a>
    }
    release(&p->lock);
    80003aa0:	fe843783          	ld	a5,-24(s0)
    80003aa4:	853e                	mv	a0,a5
    80003aa6:	ffffe097          	auipc	ra,0xffffe
    80003aaa:	828080e7          	jalr	-2008(ra) # 800012ce <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80003aae:	fe843703          	ld	a4,-24(s0)
    80003ab2:	67c9                	lui	a5,0x12
    80003ab4:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80003ab8:	97ba                	add	a5,a5,a4
    80003aba:	fef43423          	sd	a5,-24(s0)
    80003abe:	fe843703          	ld	a4,-24(s0)
    80003ac2:	00497797          	auipc	a5,0x497
    80003ac6:	fd678793          	addi	a5,a5,-42 # 8049aa98 <pid_lock>
    80003aca:	f8f764e3          	bltu	a4,a5,80003a52 <kill+0x1c>
  }
  return -1;
    80003ace:	57fd                	li	a5,-1
}
    80003ad0:	853e                	mv	a0,a5
    80003ad2:	70a2                	ld	ra,40(sp)
    80003ad4:	7402                	ld	s0,32(sp)
    80003ad6:	6145                	addi	sp,sp,48
    80003ad8:	8082                	ret

0000000080003ada <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80003ada:	7139                	addi	sp,sp,-64
    80003adc:	fc06                	sd	ra,56(sp)
    80003ade:	f822                	sd	s0,48(sp)
    80003ae0:	0080                	addi	s0,sp,64
    80003ae2:	87aa                	mv	a5,a0
    80003ae4:	fcb43823          	sd	a1,-48(s0)
    80003ae8:	fcc43423          	sd	a2,-56(s0)
    80003aec:	fcd43023          	sd	a3,-64(s0)
    80003af0:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80003af4:	fffff097          	auipc	ra,0xfffff
    80003af8:	f24080e7          	jalr	-220(ra) # 80002a18 <myproc>
    80003afc:	fea43423          	sd	a0,-24(s0)
  if(user_dst){
    80003b00:	fdc42783          	lw	a5,-36(s0)
    80003b04:	2781                	sext.w	a5,a5
    80003b06:	c38d                	beqz	a5,80003b28 <either_copyout+0x4e>
    return copyout(p->pagetable, dst, src, len);
    80003b08:	fe843783          	ld	a5,-24(s0)
    80003b0c:	6bbc                	ld	a5,80(a5)
    80003b0e:	fc043683          	ld	a3,-64(s0)
    80003b12:	fc843603          	ld	a2,-56(s0)
    80003b16:	fd043583          	ld	a1,-48(s0)
    80003b1a:	853e                	mv	a0,a5
    80003b1c:	fffff097          	auipc	ra,0xfffff
    80003b20:	8aa080e7          	jalr	-1878(ra) # 800023c6 <copyout>
    80003b24:	87aa                	mv	a5,a0
    80003b26:	a839                	j	80003b44 <either_copyout+0x6a>
  } else {
    memmove((char *)dst, src, len);
    80003b28:	fd043783          	ld	a5,-48(s0)
    80003b2c:	fc043703          	ld	a4,-64(s0)
    80003b30:	2701                	sext.w	a4,a4
    80003b32:	863a                	mv	a2,a4
    80003b34:	fc843583          	ld	a1,-56(s0)
    80003b38:	853e                	mv	a0,a5
    80003b3a:	ffffe097          	auipc	ra,0xffffe
    80003b3e:	9e8080e7          	jalr	-1560(ra) # 80001522 <memmove>
    return 0;
    80003b42:	4781                	li	a5,0
  }
}
    80003b44:	853e                	mv	a0,a5
    80003b46:	70e2                	ld	ra,56(sp)
    80003b48:	7442                	ld	s0,48(sp)
    80003b4a:	6121                	addi	sp,sp,64
    80003b4c:	8082                	ret

0000000080003b4e <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80003b4e:	7139                	addi	sp,sp,-64
    80003b50:	fc06                	sd	ra,56(sp)
    80003b52:	f822                	sd	s0,48(sp)
    80003b54:	0080                	addi	s0,sp,64
    80003b56:	fca43c23          	sd	a0,-40(s0)
    80003b5a:	87ae                	mv	a5,a1
    80003b5c:	fcc43423          	sd	a2,-56(s0)
    80003b60:	fcd43023          	sd	a3,-64(s0)
    80003b64:	fcf42a23          	sw	a5,-44(s0)
  struct proc *p = myproc();
    80003b68:	fffff097          	auipc	ra,0xfffff
    80003b6c:	eb0080e7          	jalr	-336(ra) # 80002a18 <myproc>
    80003b70:	fea43423          	sd	a0,-24(s0)
  if(user_src){
    80003b74:	fd442783          	lw	a5,-44(s0)
    80003b78:	2781                	sext.w	a5,a5
    80003b7a:	c38d                	beqz	a5,80003b9c <either_copyin+0x4e>
    return copyin(p->pagetable, dst, src, len);
    80003b7c:	fe843783          	ld	a5,-24(s0)
    80003b80:	6bbc                	ld	a5,80(a5)
    80003b82:	fc043683          	ld	a3,-64(s0)
    80003b86:	fc843603          	ld	a2,-56(s0)
    80003b8a:	fd843583          	ld	a1,-40(s0)
    80003b8e:	853e                	mv	a0,a5
    80003b90:	fffff097          	auipc	ra,0xfffff
    80003b94:	904080e7          	jalr	-1788(ra) # 80002494 <copyin>
    80003b98:	87aa                	mv	a5,a0
    80003b9a:	a839                	j	80003bb8 <either_copyin+0x6a>
  } else {
    memmove(dst, (char*)src, len);
    80003b9c:	fc843783          	ld	a5,-56(s0)
    80003ba0:	fc043703          	ld	a4,-64(s0)
    80003ba4:	2701                	sext.w	a4,a4
    80003ba6:	863a                	mv	a2,a4
    80003ba8:	85be                	mv	a1,a5
    80003baa:	fd843503          	ld	a0,-40(s0)
    80003bae:	ffffe097          	auipc	ra,0xffffe
    80003bb2:	974080e7          	jalr	-1676(ra) # 80001522 <memmove>
    return 0;
    80003bb6:	4781                	li	a5,0
  }
}
    80003bb8:	853e                	mv	a0,a5
    80003bba:	70e2                	ld	ra,56(sp)
    80003bbc:	7442                	ld	s0,48(sp)
    80003bbe:	6121                	addi	sp,sp,64
    80003bc0:	8082                	ret

0000000080003bc2 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80003bc2:	1101                	addi	sp,sp,-32
    80003bc4:	ec06                	sd	ra,24(sp)
    80003bc6:	e822                	sd	s0,16(sp)
    80003bc8:	1000                	addi	s0,sp,32
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80003bca:	00007517          	auipc	a0,0x7
    80003bce:	73650513          	addi	a0,a0,1846 # 8000b300 <etext+0x300>
    80003bd2:	ffffd097          	auipc	ra,0xffffd
    80003bd6:	e52080e7          	jalr	-430(ra) # 80000a24 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80003bda:	00011797          	auipc	a5,0x11
    80003bde:	abe78793          	addi	a5,a5,-1346 # 80014698 <proc>
    80003be2:	fef43423          	sd	a5,-24(s0)
    80003be6:	a05d                	j	80003c8c <procdump+0xca>
    if(p->state == UNUSED)
    80003be8:	fe843783          	ld	a5,-24(s0)
    80003bec:	4f9c                	lw	a5,24(a5)
    80003bee:	c7d1                	beqz	a5,80003c7a <procdump+0xb8>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80003bf0:	fe843783          	ld	a5,-24(s0)
    80003bf4:	4f9c                	lw	a5,24(a5)
    80003bf6:	873e                	mv	a4,a5
    80003bf8:	4795                	li	a5,5
    80003bfa:	02e7ee63          	bltu	a5,a4,80003c36 <procdump+0x74>
    80003bfe:	fe843783          	ld	a5,-24(s0)
    80003c02:	4f9c                	lw	a5,24(a5)
    80003c04:	00008717          	auipc	a4,0x8
    80003c08:	d2c70713          	addi	a4,a4,-724 # 8000b930 <states.0>
    80003c0c:	1782                	slli	a5,a5,0x20
    80003c0e:	9381                	srli	a5,a5,0x20
    80003c10:	078e                	slli	a5,a5,0x3
    80003c12:	97ba                	add	a5,a5,a4
    80003c14:	639c                	ld	a5,0(a5)
    80003c16:	c385                	beqz	a5,80003c36 <procdump+0x74>
      state = states[p->state];
    80003c18:	fe843783          	ld	a5,-24(s0)
    80003c1c:	4f9c                	lw	a5,24(a5)
    80003c1e:	00008717          	auipc	a4,0x8
    80003c22:	d1270713          	addi	a4,a4,-750 # 8000b930 <states.0>
    80003c26:	1782                	slli	a5,a5,0x20
    80003c28:	9381                	srli	a5,a5,0x20
    80003c2a:	078e                	slli	a5,a5,0x3
    80003c2c:	97ba                	add	a5,a5,a4
    80003c2e:	639c                	ld	a5,0(a5)
    80003c30:	fef43023          	sd	a5,-32(s0)
    80003c34:	a039                	j	80003c42 <procdump+0x80>
    else
      state = "???";
    80003c36:	00007797          	auipc	a5,0x7
    80003c3a:	6d278793          	addi	a5,a5,1746 # 8000b308 <etext+0x308>
    80003c3e:	fef43023          	sd	a5,-32(s0)
    printf("%d %s %s", p->pid, state, p->name);
    80003c42:	fe843783          	ld	a5,-24(s0)
    80003c46:	5b98                	lw	a4,48(a5)
    80003c48:	fe843783          	ld	a5,-24(s0)
    80003c4c:	16878793          	addi	a5,a5,360
    80003c50:	86be                	mv	a3,a5
    80003c52:	fe043603          	ld	a2,-32(s0)
    80003c56:	85ba                	mv	a1,a4
    80003c58:	00007517          	auipc	a0,0x7
    80003c5c:	6b850513          	addi	a0,a0,1720 # 8000b310 <etext+0x310>
    80003c60:	ffffd097          	auipc	ra,0xffffd
    80003c64:	dc4080e7          	jalr	-572(ra) # 80000a24 <printf>
    printf("\n");
    80003c68:	00007517          	auipc	a0,0x7
    80003c6c:	69850513          	addi	a0,a0,1688 # 8000b300 <etext+0x300>
    80003c70:	ffffd097          	auipc	ra,0xffffd
    80003c74:	db4080e7          	jalr	-588(ra) # 80000a24 <printf>
    80003c78:	a011                	j	80003c7c <procdump+0xba>
      continue;
    80003c7a:	0001                	nop
  for(p = proc; p < &proc[NPROC]; p++){
    80003c7c:	fe843703          	ld	a4,-24(s0)
    80003c80:	67c9                	lui	a5,0x12
    80003c82:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80003c86:	97ba                	add	a5,a5,a4
    80003c88:	fef43423          	sd	a5,-24(s0)
    80003c8c:	fe843703          	ld	a4,-24(s0)
    80003c90:	00497797          	auipc	a5,0x497
    80003c94:	e0878793          	addi	a5,a5,-504 # 8049aa98 <pid_lock>
    80003c98:	f4f768e3          	bltu	a4,a5,80003be8 <procdump+0x26>
  }
}
    80003c9c:	0001                	nop
    80003c9e:	0001                	nop
    80003ca0:	60e2                	ld	ra,24(sp)
    80003ca2:	6442                	ld	s0,16(sp)
    80003ca4:	6105                	addi	sp,sp,32
    80003ca6:	8082                	ret

0000000080003ca8 <clone>:


int clone(void(*fcn)(void*), void *arg, void*stack)
{
    80003ca8:	711d                	addi	sp,sp,-96
    80003caa:	ec86                	sd	ra,88(sp)
    80003cac:	e8a2                	sd	s0,80(sp)
    80003cae:	1080                	addi	s0,sp,96
    80003cb0:	faa43c23          	sd	a0,-72(s0)
    80003cb4:	fab43823          	sd	a1,-80(s0)
    80003cb8:	fac43423          	sd	a2,-88(s0)

  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    80003cbc:	fffff097          	auipc	ra,0xfffff
    80003cc0:	d5c080e7          	jalr	-676(ra) # 80002a18 <myproc>
    80003cc4:	fea43023          	sd	a0,-32(s0)

  // Allocate process.
  if((np = allocproc()) == 0){
    80003cc8:	fffff097          	auipc	ra,0xfffff
    80003ccc:	dea080e7          	jalr	-534(ra) # 80002ab2 <allocproc>
    80003cd0:	fca43c23          	sd	a0,-40(s0)
    80003cd4:	fd843783          	ld	a5,-40(s0)
    80003cd8:	e399                	bnez	a5,80003cde <clone+0x36>
    return -1;
    80003cda:	57fd                	li	a5,-1
    80003cdc:	a45d                	j	80003f82 <clone+0x2da>
  }

  // Copy user memory from parent to child.
  if(uvmcopyThread(p->pagetable, np->pagetable, p->sz) < 0){
    80003cde:	fe043783          	ld	a5,-32(s0)
    80003ce2:	6bb8                	ld	a4,80(a5)
    80003ce4:	fd843783          	ld	a5,-40(s0)
    80003ce8:	6bb4                	ld	a3,80(a5)
    80003cea:	fe043783          	ld	a5,-32(s0)
    80003cee:	67bc                	ld	a5,72(a5)
    80003cf0:	863e                	mv	a2,a5
    80003cf2:	85b6                	mv	a1,a3
    80003cf4:	853a                	mv	a0,a4
    80003cf6:	ffffe097          	auipc	ra,0xffffe
    80003cfa:	59a080e7          	jalr	1434(ra) # 80002290 <uvmcopyThread>
    80003cfe:	87aa                	mv	a5,a0
    80003d00:	0207d163          	bgez	a5,80003d22 <clone+0x7a>
    freeproc(np);
    80003d04:	fd843503          	ld	a0,-40(s0)
    80003d08:	fffff097          	auipc	ra,0xfffff
    80003d0c:	f14080e7          	jalr	-236(ra) # 80002c1c <freeproc>
    release(&np->lock);
    80003d10:	fd843783          	ld	a5,-40(s0)
    80003d14:	853e                	mv	a0,a5
    80003d16:	ffffd097          	auipc	ra,0xffffd
    80003d1a:	5b8080e7          	jalr	1464(ra) # 800012ce <release>
    return -1;
    80003d1e:	57fd                	li	a5,-1
    80003d20:	a48d                	j	80003f82 <clone+0x2da>
  }

   //comparten el mismo espacio de direcciones
  //np->pagetable = p->pagetable;

  np->thread = 1;
    80003d22:	fd843703          	ld	a4,-40(s0)
    80003d26:	67c9                	lui	a5,0x12
    80003d28:	97ba                	add	a5,a5,a4
    80003d2a:	4705                	li	a4,1
    80003d2c:	18e7a423          	sw	a4,392(a5) # 12188 <_entry-0x7ffede78>
  np->sz = p->sz;
    80003d30:	fe043783          	ld	a5,-32(s0)
    80003d34:	67b8                	ld	a4,72(a5)
    80003d36:	fd843783          	ld	a5,-40(s0)
    80003d3a:	e7b8                	sd	a4,72(a5)


  //ASID thread = PID padre
  np->ASID = p->ASID;
    80003d3c:	fe043783          	ld	a5,-32(s0)
    80003d40:	5bd8                	lw	a4,52(a5)
    80003d42:	fd843783          	ld	a5,-40(s0)
    80003d46:	dbd8                	sw	a4,52(a5)


  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    80003d48:	fe043783          	ld	a5,-32(s0)
    80003d4c:	73b8                	ld	a4,96(a5)
    80003d4e:	fd843783          	ld	a5,-40(s0)
    80003d52:	73bc                	ld	a5,96(a5)
    80003d54:	86be                	mv	a3,a5
    80003d56:	12000793          	li	a5,288
    80003d5a:	863e                	mv	a2,a5
    80003d5c:	85ba                	mv	a1,a4
    80003d5e:	8536                	mv	a0,a3
    80003d60:	ffffe097          	auipc	ra,0xffffe
    80003d64:	89e080e7          	jalr	-1890(ra) # 800015fe <memcpy>

  //indicamos al hijo que empiece ejecutando en la función
  np->trapframe->epc = (uint64) fcn;
    80003d68:	fd843783          	ld	a5,-40(s0)
    80003d6c:	73bc                	ld	a5,96(a5)
    80003d6e:	fb843703          	ld	a4,-72(s0)
    80003d72:	ef98                	sd	a4,24(a5)

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = (uint64)arg;
    80003d74:	fd843783          	ld	a5,-40(s0)
    80003d78:	73bc                	ld	a5,96(a5)
    80003d7a:	fb043703          	ld	a4,-80(s0)
    80003d7e:	fbb8                	sd	a4,112(a5)



  //Apuntamos al final del stack y luego vamos insertamos
  uint64 stack_args[2]; 
  stack_args[0] =  0xffffffff; 
    80003d80:	57fd                	li	a5,-1
    80003d82:	9381                	srli	a5,a5,0x20
    80003d84:	fcf43023          	sd	a5,-64(s0)
  stack_args[1] =  (uint64)arg;
    80003d88:	fb043783          	ld	a5,-80(s0)
    80003d8c:	fcf43423          	sd	a5,-56(s0)
  
  np->bottom_ustack = (uint64) stack; //base de stack, para liberar en join
    80003d90:	fa843703          	ld	a4,-88(s0)
    80003d94:	fd843683          	ld	a3,-40(s0)
    80003d98:	6789                	lui	a5,0x2
    80003d9a:	97b6                	add	a5,a5,a3
    80003d9c:	18e7b023          	sd	a4,384(a5) # 2180 <_entry-0x7fffde80>
  np->top_ustack = np->bottom_ustack + PGSIZE; //tope de stack
    80003da0:	fd843703          	ld	a4,-40(s0)
    80003da4:	6789                	lui	a5,0x2
    80003da6:	97ba                	add	a5,a5,a4
    80003da8:	1807b703          	ld	a4,384(a5) # 2180 <_entry-0x7fffde80>
    80003dac:	6785                	lui	a5,0x1
    80003dae:	973e                	add	a4,a4,a5
    80003db0:	fd843683          	ld	a3,-40(s0)
    80003db4:	6789                	lui	a5,0x2
    80003db6:	97b6                	add	a5,a5,a3
    80003db8:	16e7bc23          	sd	a4,376(a5) # 2178 <_entry-0x7fffde88>
  np->top_ustack -= 16;
    80003dbc:	fd843703          	ld	a4,-40(s0)
    80003dc0:	6789                	lui	a5,0x2
    80003dc2:	97ba                	add	a5,a5,a4
    80003dc4:	1787b783          	ld	a5,376(a5) # 2178 <_entry-0x7fffde88>
    80003dc8:	ff078713          	addi	a4,a5,-16
    80003dcc:	fd843683          	ld	a3,-40(s0)
    80003dd0:	6789                	lui	a5,0x2
    80003dd2:	97b6                	add	a5,a5,a3
    80003dd4:	16e7bc23          	sd	a4,376(a5) # 2178 <_entry-0x7fffde88>
  //np->top_ustack -=  np->top_ustack %16;


  printf ("Antes de hacer copyout.\n");
    80003dd8:	00007517          	auipc	a0,0x7
    80003ddc:	54850513          	addi	a0,a0,1352 # 8000b320 <etext+0x320>
    80003de0:	ffffd097          	auipc	ra,0xffffd
    80003de4:	c44080e7          	jalr	-956(ra) # 80000a24 <printf>

  //copyout
  if (copyout(np->pagetable, np->top_ustack, (char *) stack_args, 16) < 0) {
    80003de8:	fd843783          	ld	a5,-40(s0)
    80003dec:	6ba8                	ld	a0,80(a5)
    80003dee:	fd843703          	ld	a4,-40(s0)
    80003df2:	6789                	lui	a5,0x2
    80003df4:	97ba                	add	a5,a5,a4
    80003df6:	1787b783          	ld	a5,376(a5) # 2178 <_entry-0x7fffde88>
    80003dfa:	fc040713          	addi	a4,s0,-64
    80003dfe:	46c1                	li	a3,16
    80003e00:	863a                	mv	a2,a4
    80003e02:	85be                	mv	a1,a5
    80003e04:	ffffe097          	auipc	ra,0xffffe
    80003e08:	5c2080e7          	jalr	1474(ra) # 800023c6 <copyout>
    80003e0c:	87aa                	mv	a5,a0
    80003e0e:	0007db63          	bgez	a5,80003e24 <clone+0x17c>
     release(&np->lock);
    80003e12:	fd843783          	ld	a5,-40(s0)
    80003e16:	853e                	mv	a0,a5
    80003e18:	ffffd097          	auipc	ra,0xffffd
    80003e1c:	4b6080e7          	jalr	1206(ra) # 800012ce <release>
     //elease(&wait_lock);
        return -1;
    80003e20:	57fd                	li	a5,-1
    80003e22:	a285                	j	80003f82 <clone+0x2da>
    }



  printf ("Copyout correcto al stack del thread.\n");
    80003e24:	00007517          	auipc	a0,0x7
    80003e28:	51c50513          	addi	a0,a0,1308 # 8000b340 <etext+0x340>
    80003e2c:	ffffd097          	auipc	ra,0xffffd
    80003e30:	bf8080e7          	jalr	-1032(ra) # 80000a24 <printf>

  //actualiza stack pointer
  np->trapframe->sp= np->top_ustack; 
    80003e34:	fd843783          	ld	a5,-40(s0)
    80003e38:	73bc                	ld	a5,96(a5)
    80003e3a:	fd843683          	ld	a3,-40(s0)
    80003e3e:	6709                	lui	a4,0x2
    80003e40:	9736                	add	a4,a4,a3
    80003e42:	17873703          	ld	a4,376(a4) # 2178 <_entry-0x7fffde88>
    80003e46:	fb98                	sd	a4,48(a5)



  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    80003e48:	fe042623          	sw	zero,-20(s0)
    80003e4c:	a0a9                	j	80003e96 <clone+0x1ee>
    if(p->ofile[i])
    80003e4e:	fe043703          	ld	a4,-32(s0)
    80003e52:	fec42783          	lw	a5,-20(s0)
    80003e56:	07f1                	addi	a5,a5,28
    80003e58:	078e                	slli	a5,a5,0x3
    80003e5a:	97ba                	add	a5,a5,a4
    80003e5c:	639c                	ld	a5,0(a5)
    80003e5e:	c79d                	beqz	a5,80003e8c <clone+0x1e4>
      np->ofile[i] = filedup(p->ofile[i]);
    80003e60:	fe043703          	ld	a4,-32(s0)
    80003e64:	fec42783          	lw	a5,-20(s0)
    80003e68:	07f1                	addi	a5,a5,28
    80003e6a:	078e                	slli	a5,a5,0x3
    80003e6c:	97ba                	add	a5,a5,a4
    80003e6e:	639c                	ld	a5,0(a5)
    80003e70:	853e                	mv	a0,a5
    80003e72:	00003097          	auipc	ra,0x3
    80003e76:	53a080e7          	jalr	1338(ra) # 800073ac <filedup>
    80003e7a:	86aa                	mv	a3,a0
    80003e7c:	fd843703          	ld	a4,-40(s0)
    80003e80:	fec42783          	lw	a5,-20(s0)
    80003e84:	07f1                	addi	a5,a5,28
    80003e86:	078e                	slli	a5,a5,0x3
    80003e88:	97ba                	add	a5,a5,a4
    80003e8a:	e394                	sd	a3,0(a5)
  for(i = 0; i < NOFILE; i++)
    80003e8c:	fec42783          	lw	a5,-20(s0)
    80003e90:	2785                	addiw	a5,a5,1
    80003e92:	fef42623          	sw	a5,-20(s0)
    80003e96:	fec42783          	lw	a5,-20(s0)
    80003e9a:	0007871b          	sext.w	a4,a5
    80003e9e:	47bd                	li	a5,15
    80003ea0:	fae7d7e3          	bge	a5,a4,80003e4e <clone+0x1a6>
  np->cwd = idup(p->cwd);
    80003ea4:	fe043783          	ld	a5,-32(s0)
    80003ea8:	1607b783          	ld	a5,352(a5)
    80003eac:	853e                	mv	a0,a5
    80003eae:	00002097          	auipc	ra,0x2
    80003eb2:	e16080e7          	jalr	-490(ra) # 80005cc4 <idup>
    80003eb6:	872a                	mv	a4,a0
    80003eb8:	fd843783          	ld	a5,-40(s0)
    80003ebc:	16e7b023          	sd	a4,352(a5)

  safestrcpy(np->name, p->name, sizeof(p->name));
    80003ec0:	fd843783          	ld	a5,-40(s0)
    80003ec4:	16878713          	addi	a4,a5,360
    80003ec8:	fe043783          	ld	a5,-32(s0)
    80003ecc:	16878793          	addi	a5,a5,360
    80003ed0:	4641                	li	a2,16
    80003ed2:	85be                	mv	a1,a5
    80003ed4:	853a                	mv	a0,a4
    80003ed6:	ffffe097          	auipc	ra,0xffffe
    80003eda:	86c080e7          	jalr	-1940(ra) # 80001742 <safestrcpy>

  pid = np->pid;
    80003ede:	fd843783          	ld	a5,-40(s0)
    80003ee2:	5b9c                	lw	a5,48(a5)
    80003ee4:	fcf42a23          	sw	a5,-44(s0)

  release(&np->lock);
    80003ee8:	fd843783          	ld	a5,-40(s0)
    80003eec:	853e                	mv	a0,a5
    80003eee:	ffffd097          	auipc	ra,0xffffd
    80003ef2:	3e0080e7          	jalr	992(ra) # 800012ce <release>

  acquire(&wait_lock);
    80003ef6:	00497517          	auipc	a0,0x497
    80003efa:	bba50513          	addi	a0,a0,-1094 # 8049aab0 <wait_lock>
    80003efe:	ffffd097          	auipc	ra,0xffffd
    80003f02:	36c080e7          	jalr	876(ra) # 8000126a <acquire>
  np->parent = p;
    80003f06:	fd843783          	ld	a5,-40(s0)
    80003f0a:	fe043703          	ld	a4,-32(s0)
    80003f0e:	ff98                	sd	a4,56(a5)
  release(&wait_lock);
    80003f10:	00497517          	auipc	a0,0x497
    80003f14:	ba050513          	addi	a0,a0,-1120 # 8049aab0 <wait_lock>
    80003f18:	ffffd097          	auipc	ra,0xffffd
    80003f1c:	3b6080e7          	jalr	950(ra) # 800012ce <release>

  acquire(&p->lock);
    80003f20:	fe043783          	ld	a5,-32(s0)
    80003f24:	853e                	mv	a0,a5
    80003f26:	ffffd097          	auipc	ra,0xffffd
    80003f2a:	344080e7          	jalr	836(ra) # 8000126a <acquire>
  p->referencias++;
    80003f2e:	fe043703          	ld	a4,-32(s0)
    80003f32:	67c9                	lui	a5,0x12
    80003f34:	97ba                	add	a5,a5,a4
    80003f36:	18c7a783          	lw	a5,396(a5) # 1218c <_entry-0x7ffede74>
    80003f3a:	2785                	addiw	a5,a5,1
    80003f3c:	0007871b          	sext.w	a4,a5
    80003f40:	fe043683          	ld	a3,-32(s0)
    80003f44:	67c9                	lui	a5,0x12
    80003f46:	97b6                	add	a5,a5,a3
    80003f48:	18e7a623          	sw	a4,396(a5) # 1218c <_entry-0x7ffede74>
  release(&p->lock);
    80003f4c:	fe043783          	ld	a5,-32(s0)
    80003f50:	853e                	mv	a0,a5
    80003f52:	ffffd097          	auipc	ra,0xffffd
    80003f56:	37c080e7          	jalr	892(ra) # 800012ce <release>



  acquire(&np->lock);
    80003f5a:	fd843783          	ld	a5,-40(s0)
    80003f5e:	853e                	mv	a0,a5
    80003f60:	ffffd097          	auipc	ra,0xffffd
    80003f64:	30a080e7          	jalr	778(ra) # 8000126a <acquire>
  np->state = RUNNABLE;
    80003f68:	fd843783          	ld	a5,-40(s0)
    80003f6c:	470d                	li	a4,3
    80003f6e:	cf98                	sw	a4,24(a5)
  release(&np->lock);
    80003f70:	fd843783          	ld	a5,-40(s0)
    80003f74:	853e                	mv	a0,a5
    80003f76:	ffffd097          	auipc	ra,0xffffd
    80003f7a:	358080e7          	jalr	856(ra) # 800012ce <release>


  //actualizamos las referencias
  

  return pid;
    80003f7e:	fd442783          	lw	a5,-44(s0)


}
    80003f82:	853e                	mv	a0,a5
    80003f84:	60e6                	ld	ra,88(sp)
    80003f86:	6446                	ld	s0,80(sp)
    80003f88:	6125                	addi	sp,sp,96
    80003f8a:	8082                	ret

0000000080003f8c <join>:


int join (uint64 addr_stack){
    80003f8c:	715d                	addi	sp,sp,-80
    80003f8e:	e486                	sd	ra,72(sp)
    80003f90:	e0a2                	sd	s0,64(sp)
    80003f92:	0880                	addi	s0,sp,80
    80003f94:	faa43c23          	sd	a0,-72(s0)

  struct proc *np;
  int havekids, pid;
  void **stack;
  struct proc *p = myproc();
    80003f98:	fffff097          	auipc	ra,0xfffff
    80003f9c:	a80080e7          	jalr	-1408(ra) # 80002a18 <myproc>
    80003fa0:	fca43c23          	sd	a0,-40(s0)

  
  acquire(&wait_lock);
    80003fa4:	00497517          	auipc	a0,0x497
    80003fa8:	b0c50513          	addi	a0,a0,-1268 # 8049aab0 <wait_lock>
    80003fac:	ffffd097          	auipc	ra,0xffffd
    80003fb0:	2be080e7          	jalr	702(ra) # 8000126a <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    80003fb4:	fe042223          	sw	zero,-28(s0)
    for(np = proc; np < &proc[NPROC]; np++){
    80003fb8:	00010797          	auipc	a5,0x10
    80003fbc:	6e078793          	addi	a5,a5,1760 # 80014698 <proc>
    80003fc0:	fef43423          	sd	a5,-24(s0)
    80003fc4:	a261                	j	8000414c <join+0x1c0>
      if(np->parent == p && np->thread == 1){ //modificamos la condición para que se seleccione solo al thread hijo del proceso
    80003fc6:	fe843783          	ld	a5,-24(s0)
    80003fca:	7f9c                	ld	a5,56(a5)
    80003fcc:	fd843703          	ld	a4,-40(s0)
    80003fd0:	16f71663          	bne	a4,a5,8000413c <join+0x1b0>
    80003fd4:	fe843703          	ld	a4,-24(s0)
    80003fd8:	67c9                	lui	a5,0x12
    80003fda:	97ba                	add	a5,a5,a4
    80003fdc:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    80003fe0:	873e                	mv	a4,a5
    80003fe2:	4785                	li	a5,1
    80003fe4:	14f71c63          	bne	a4,a5,8000413c <join+0x1b0>


        // make sure the child isn't still in exit() or swtch().
        acquire(&np->lock);
    80003fe8:	fe843783          	ld	a5,-24(s0)
    80003fec:	853e                	mv	a0,a5
    80003fee:	ffffd097          	auipc	ra,0xffffd
    80003ff2:	27c080e7          	jalr	636(ra) # 8000126a <acquire>

        havekids = 1;
    80003ff6:	4785                	li	a5,1
    80003ff8:	fef42223          	sw	a5,-28(s0)
        if(np->state == ZOMBIE){
    80003ffc:	fe843783          	ld	a5,-24(s0)
    80004000:	4f9c                	lw	a5,24(a5)
    80004002:	873e                	mv	a4,a5
    80004004:	4795                	li	a5,5
    80004006:	12f71463          	bne	a4,a5,8000412e <join+0x1a2>
          // Found one.

          //copiamos en el argumento stack la dirección del stack de usuario para que pueda liberarse después con free
          stack = (void**)np->bottom_ustack; 
    8000400a:	fe843703          	ld	a4,-24(s0)
    8000400e:	6789                	lui	a5,0x2
    80004010:	97ba                	add	a5,a5,a4
    80004012:	1807b783          	ld	a5,384(a5) # 2180 <_entry-0x7fffde80>
    80004016:	fcf43423          	sd	a5,-56(s0)
          pid = np->pid;
    8000401a:	fe843783          	ld	a5,-24(s0)
    8000401e:	5b9c                	lw	a5,48(a5)
    80004020:	fcf42a23          	sw	a5,-44(s0)

   

          printf ("ADDR: %d\n", addr_stack);
    80004024:	fb843583          	ld	a1,-72(s0)
    80004028:	00007517          	auipc	a0,0x7
    8000402c:	34050513          	addi	a0,a0,832 # 8000b368 <etext+0x368>
    80004030:	ffffd097          	auipc	ra,0xffffd
    80004034:	9f4080e7          	jalr	-1548(ra) # 80000a24 <printf>
          printf ("Voy a hacer copyout en join\n");
    80004038:	00007517          	auipc	a0,0x7
    8000403c:	34050513          	addi	a0,a0,832 # 8000b378 <etext+0x378>
    80004040:	ffffd097          	auipc	ra,0xffffd
    80004044:	9e4080e7          	jalr	-1564(ra) # 80000a24 <printf>
          if ((copyout (np->pagetable, addr_stack, (char *)&stack, sizeof(uint64))) < 0){
    80004048:	fe843783          	ld	a5,-24(s0)
    8000404c:	6bbc                	ld	a5,80(a5)
    8000404e:	fc840713          	addi	a4,s0,-56
    80004052:	46a1                	li	a3,8
    80004054:	863a                	mv	a2,a4
    80004056:	fb843583          	ld	a1,-72(s0)
    8000405a:	853e                	mv	a0,a5
    8000405c:	ffffe097          	auipc	ra,0xffffe
    80004060:	36a080e7          	jalr	874(ra) # 800023c6 <copyout>
    80004064:	87aa                	mv	a5,a0
    80004066:	0207d363          	bgez	a5,8000408c <join+0x100>
             release(&np->lock); //libera thread
    8000406a:	fe843783          	ld	a5,-24(s0)
    8000406e:	853e                	mv	a0,a5
    80004070:	ffffd097          	auipc	ra,0xffffd
    80004074:	25e080e7          	jalr	606(ra) # 800012ce <release>
             release(&wait_lock);
    80004078:	00497517          	auipc	a0,0x497
    8000407c:	a3850513          	addi	a0,a0,-1480 # 8049aab0 <wait_lock>
    80004080:	ffffd097          	auipc	ra,0xffffd
    80004084:	24e080e7          	jalr	590(ra) # 800012ce <release>
             return -1;
    80004088:	57fd                	li	a5,-1
    8000408a:	a231                	j	80004196 <join+0x20a>
          }
         

          printf ("Stack del join: %d\n", stack);
    8000408c:	fc843783          	ld	a5,-56(s0)
    80004090:	85be                	mv	a1,a5
    80004092:	00007517          	auipc	a0,0x7
    80004096:	30650513          	addi	a0,a0,774 # 8000b398 <etext+0x398>
    8000409a:	ffffd097          	auipc	ra,0xffffd
    8000409e:	98a080e7          	jalr	-1654(ra) # 80000a24 <printf>

          acquire(&p->lock);
    800040a2:	fd843783          	ld	a5,-40(s0)
    800040a6:	853e                	mv	a0,a5
    800040a8:	ffffd097          	auipc	ra,0xffffd
    800040ac:	1c2080e7          	jalr	450(ra) # 8000126a <acquire>
          p->referencias--;
    800040b0:	fd843703          	ld	a4,-40(s0)
    800040b4:	67c9                	lui	a5,0x12
    800040b6:	97ba                	add	a5,a5,a4
    800040b8:	18c7a783          	lw	a5,396(a5) # 1218c <_entry-0x7ffede74>
    800040bc:	37fd                	addiw	a5,a5,-1
    800040be:	0007871b          	sext.w	a4,a5
    800040c2:	fd843683          	ld	a3,-40(s0)
    800040c6:	67c9                	lui	a5,0x12
    800040c8:	97b6                	add	a5,a5,a3
    800040ca:	18e7a623          	sw	a4,396(a5) # 1218c <_entry-0x7ffede74>
          release(&p->lock);
    800040ce:	fd843783          	ld	a5,-40(s0)
    800040d2:	853e                	mv	a0,a5
    800040d4:	ffffd097          	auipc	ra,0xffffd
    800040d8:	1fa080e7          	jalr	506(ra) # 800012ce <release>
          
          if (np->thread == 1){
    800040dc:	fe843703          	ld	a4,-24(s0)
    800040e0:	67c9                	lui	a5,0x12
    800040e2:	97ba                	add	a5,a5,a4
    800040e4:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    800040e8:	873e                	mv	a4,a5
    800040ea:	4785                	li	a5,1
    800040ec:	00f71963          	bne	a4,a5,800040fe <join+0x172>
              freethread(np);
    800040f0:	fe843503          	ld	a0,-24(s0)
    800040f4:	fffff097          	auipc	ra,0xfffff
    800040f8:	bc6080e7          	jalr	-1082(ra) # 80002cba <freethread>
    800040fc:	a039                	j	8000410a <join+0x17e>

          } else {
              freeproc(np);
    800040fe:	fe843503          	ld	a0,-24(s0)
    80004102:	fffff097          	auipc	ra,0xfffff
    80004106:	b1a080e7          	jalr	-1254(ra) # 80002c1c <freeproc>
          }


          release(&np->lock); //libera thread
    8000410a:	fe843783          	ld	a5,-24(s0)
    8000410e:	853e                	mv	a0,a5
    80004110:	ffffd097          	auipc	ra,0xffffd
    80004114:	1be080e7          	jalr	446(ra) # 800012ce <release>
          release(&wait_lock);
    80004118:	00497517          	auipc	a0,0x497
    8000411c:	99850513          	addi	a0,a0,-1640 # 8049aab0 <wait_lock>
    80004120:	ffffd097          	auipc	ra,0xffffd
    80004124:	1ae080e7          	jalr	430(ra) # 800012ce <release>
          
          return pid; //devolvemos TID 
    80004128:	fd442783          	lw	a5,-44(s0)
    8000412c:	a0ad                	j	80004196 <join+0x20a>
        }
        release(&np->lock);
    8000412e:	fe843783          	ld	a5,-24(s0)
    80004132:	853e                	mv	a0,a5
    80004134:	ffffd097          	auipc	ra,0xffffd
    80004138:	19a080e7          	jalr	410(ra) # 800012ce <release>
    for(np = proc; np < &proc[NPROC]; np++){
    8000413c:	fe843703          	ld	a4,-24(s0)
    80004140:	67c9                	lui	a5,0x12
    80004142:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80004146:	97ba                	add	a5,a5,a4
    80004148:	fef43423          	sd	a5,-24(s0)
    8000414c:	fe843703          	ld	a4,-24(s0)
    80004150:	00497797          	auipc	a5,0x497
    80004154:	94878793          	addi	a5,a5,-1720 # 8049aa98 <pid_lock>
    80004158:	e6f767e3          	bltu	a4,a5,80003fc6 <join+0x3a>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || p->killed){
    8000415c:	fe442783          	lw	a5,-28(s0)
    80004160:	2781                	sext.w	a5,a5
    80004162:	c789                	beqz	a5,8000416c <join+0x1e0>
    80004164:	fd843783          	ld	a5,-40(s0)
    80004168:	579c                	lw	a5,40(a5)
    8000416a:	cb99                	beqz	a5,80004180 <join+0x1f4>
      release(&wait_lock);
    8000416c:	00497517          	auipc	a0,0x497
    80004170:	94450513          	addi	a0,a0,-1724 # 8049aab0 <wait_lock>
    80004174:	ffffd097          	auipc	ra,0xffffd
    80004178:	15a080e7          	jalr	346(ra) # 800012ce <release>
      return -1;
    8000417c:	57fd                	li	a5,-1
    8000417e:	a821                	j	80004196 <join+0x20a>
    }

    
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80004180:	00497597          	auipc	a1,0x497
    80004184:	93058593          	addi	a1,a1,-1744 # 8049aab0 <wait_lock>
    80004188:	fd843503          	ld	a0,-40(s0)
    8000418c:	fffff097          	auipc	ra,0xfffff
    80004190:	796080e7          	jalr	1942(ra) # 80003922 <sleep>
    havekids = 0;
    80004194:	b505                	j	80003fb4 <join+0x28>

  }

}
    80004196:	853e                	mv	a0,a5
    80004198:	60a6                	ld	ra,72(sp)
    8000419a:	6406                	ld	s0,64(sp)
    8000419c:	6161                	addi	sp,sp,80
    8000419e:	8082                	ret

00000000800041a0 <growproc_proceso_padre>:

// Grow or shrink user memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc_proceso_padre(int n, struct proc *padre)
{
    800041a0:	7179                	addi	sp,sp,-48
    800041a2:	f406                	sd	ra,40(sp)
    800041a4:	f022                	sd	s0,32(sp)
    800041a6:	1800                	addi	s0,sp,48
    800041a8:	87aa                	mv	a5,a0
    800041aa:	fcb43823          	sd	a1,-48(s0)
    800041ae:	fcf42e23          	sw	a5,-36(s0)
  uint sz;
  //struct proc *p = myproc();

  sz = padre->sz;
    800041b2:	fd043783          	ld	a5,-48(s0)
    800041b6:	67bc                	ld	a5,72(a5)
    800041b8:	fef42623          	sw	a5,-20(s0)
  if(n > 0){
    800041bc:	fdc42783          	lw	a5,-36(s0)
    800041c0:	2781                	sext.w	a5,a5
    800041c2:	02f05f63          	blez	a5,80004200 <growproc_proceso_padre+0x60>
    if((sz = uvmalloc(padre->pagetable, sz, sz + n)) == 0) {
    800041c6:	fd043783          	ld	a5,-48(s0)
    800041ca:	6bb8                	ld	a4,80(a5)
    800041cc:	fec46683          	lwu	a3,-20(s0)
    800041d0:	fdc42783          	lw	a5,-36(s0)
    800041d4:	fec42603          	lw	a2,-20(s0)
    800041d8:	9fb1                	addw	a5,a5,a2
    800041da:	2781                	sext.w	a5,a5
    800041dc:	1782                	slli	a5,a5,0x20
    800041de:	9381                	srli	a5,a5,0x20
    800041e0:	863e                	mv	a2,a5
    800041e2:	85b6                	mv	a1,a3
    800041e4:	853a                	mv	a0,a4
    800041e6:	ffffe097          	auipc	ra,0xffffe
    800041ea:	d22080e7          	jalr	-734(ra) # 80001f08 <uvmalloc>
    800041ee:	87aa                	mv	a5,a0
    800041f0:	fef42623          	sw	a5,-20(s0)
    800041f4:	fec42783          	lw	a5,-20(s0)
    800041f8:	2781                	sext.w	a5,a5
    800041fa:	ef9d                	bnez	a5,80004238 <growproc_proceso_padre+0x98>
      return -1;
    800041fc:	57fd                	li	a5,-1
    800041fe:	a099                	j	80004244 <growproc_proceso_padre+0xa4>
    }
  } else if(n < 0){
    80004200:	fdc42783          	lw	a5,-36(s0)
    80004204:	2781                	sext.w	a5,a5
    80004206:	0207d963          	bgez	a5,80004238 <growproc_proceso_padre+0x98>
    sz = uvmdealloc(padre->pagetable, sz, sz + n);
    8000420a:	fd043783          	ld	a5,-48(s0)
    8000420e:	6bb8                	ld	a4,80(a5)
    80004210:	fec46683          	lwu	a3,-20(s0)
    80004214:	fdc42783          	lw	a5,-36(s0)
    80004218:	fec42603          	lw	a2,-20(s0)
    8000421c:	9fb1                	addw	a5,a5,a2
    8000421e:	2781                	sext.w	a5,a5
    80004220:	1782                	slli	a5,a5,0x20
    80004222:	9381                	srli	a5,a5,0x20
    80004224:	863e                	mv	a2,a5
    80004226:	85b6                	mv	a1,a3
    80004228:	853a                	mv	a0,a4
    8000422a:	ffffe097          	auipc	ra,0xffffe
    8000422e:	dc2080e7          	jalr	-574(ra) # 80001fec <uvmdealloc>
    80004232:	87aa                	mv	a5,a0
    80004234:	fef42623          	sw	a5,-20(s0)
  }
  padre->sz = sz;
    80004238:	fec46703          	lwu	a4,-20(s0)
    8000423c:	fd043783          	ld	a5,-48(s0)
    80004240:	e7b8                	sd	a4,72(a5)
  return 0;
    80004242:	4781                	li	a5,0
}
    80004244:	853e                	mv	a0,a5
    80004246:	70a2                	ld	ra,40(sp)
    80004248:	7402                	ld	s0,32(sp)
    8000424a:	6145                	addi	sp,sp,48
    8000424c:	8082                	ret

000000008000424e <busca_padre>:


struct proc* busca_padre (int pid_padre){
    8000424e:	7179                	addi	sp,sp,-48
    80004250:	f406                	sd	ra,40(sp)
    80004252:	f022                	sd	s0,32(sp)
    80004254:	1800                	addi	s0,sp,48
    80004256:	87aa                	mv	a5,a0
    80004258:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    8000425c:	ffffe097          	auipc	ra,0xffffe
    80004260:	7bc080e7          	jalr	1980(ra) # 80002a18 <myproc>
    80004264:	fea43423          	sd	a0,-24(s0)
  for(p = proc; p < &proc[NPROC]; p++){
    80004268:	00010797          	auipc	a5,0x10
    8000426c:	43078793          	addi	a5,a5,1072 # 80014698 <proc>
    80004270:	fef43423          	sd	a5,-24(s0)
    80004274:	a025                	j	8000429c <busca_padre+0x4e>
      if (p->pid == pid_padre){
    80004276:	fe843783          	ld	a5,-24(s0)
    8000427a:	5b98                	lw	a4,48(a5)
    8000427c:	fdc42783          	lw	a5,-36(s0)
    80004280:	2781                	sext.w	a5,a5
    80004282:	00e79563          	bne	a5,a4,8000428c <busca_padre+0x3e>
        return p;
    80004286:	fe843783          	ld	a5,-24(s0)
    8000428a:	a015                	j	800042ae <busca_padre+0x60>
  for(p = proc; p < &proc[NPROC]; p++){
    8000428c:	fe843703          	ld	a4,-24(s0)
    80004290:	67c9                	lui	a5,0x12
    80004292:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80004296:	97ba                	add	a5,a5,a4
    80004298:	fef43423          	sd	a5,-24(s0)
    8000429c:	fe843703          	ld	a4,-24(s0)
    800042a0:	00496797          	auipc	a5,0x496
    800042a4:	7f878793          	addi	a5,a5,2040 # 8049aa98 <pid_lock>
    800042a8:	fcf767e3          	bltu	a4,a5,80004276 <busca_padre+0x28>
      }
  }

  return 0;
    800042ac:	4781                	li	a5,0
    800042ae:	853e                	mv	a0,a5
    800042b0:	70a2                	ld	ra,40(sp)
    800042b2:	7402                	ld	s0,32(sp)
    800042b4:	6145                	addi	sp,sp,48
    800042b6:	8082                	ret

00000000800042b8 <swtch>:
    800042b8:	00153023          	sd	ra,0(a0)
    800042bc:	00253423          	sd	sp,8(a0)
    800042c0:	e900                	sd	s0,16(a0)
    800042c2:	ed04                	sd	s1,24(a0)
    800042c4:	03253023          	sd	s2,32(a0)
    800042c8:	03353423          	sd	s3,40(a0)
    800042cc:	03453823          	sd	s4,48(a0)
    800042d0:	03553c23          	sd	s5,56(a0)
    800042d4:	05653023          	sd	s6,64(a0)
    800042d8:	05753423          	sd	s7,72(a0)
    800042dc:	05853823          	sd	s8,80(a0)
    800042e0:	05953c23          	sd	s9,88(a0)
    800042e4:	07a53023          	sd	s10,96(a0)
    800042e8:	07b53423          	sd	s11,104(a0)
    800042ec:	0005b083          	ld	ra,0(a1)
    800042f0:	0085b103          	ld	sp,8(a1)
    800042f4:	6980                	ld	s0,16(a1)
    800042f6:	6d84                	ld	s1,24(a1)
    800042f8:	0205b903          	ld	s2,32(a1)
    800042fc:	0285b983          	ld	s3,40(a1)
    80004300:	0305ba03          	ld	s4,48(a1)
    80004304:	0385ba83          	ld	s5,56(a1)
    80004308:	0405bb03          	ld	s6,64(a1)
    8000430c:	0485bb83          	ld	s7,72(a1)
    80004310:	0505bc03          	ld	s8,80(a1)
    80004314:	0585bc83          	ld	s9,88(a1)
    80004318:	0605bd03          	ld	s10,96(a1)
    8000431c:	0685bd83          	ld	s11,104(a1)
    80004320:	8082                	ret

0000000080004322 <r_sstatus>:
{
    80004322:	1101                	addi	sp,sp,-32
    80004324:	ec22                	sd	s0,24(sp)
    80004326:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80004328:	100027f3          	csrr	a5,sstatus
    8000432c:	fef43423          	sd	a5,-24(s0)
  return x;
    80004330:	fe843783          	ld	a5,-24(s0)
}
    80004334:	853e                	mv	a0,a5
    80004336:	6462                	ld	s0,24(sp)
    80004338:	6105                	addi	sp,sp,32
    8000433a:	8082                	ret

000000008000433c <w_sstatus>:
{
    8000433c:	1101                	addi	sp,sp,-32
    8000433e:	ec22                	sd	s0,24(sp)
    80004340:	1000                	addi	s0,sp,32
    80004342:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80004346:	fe843783          	ld	a5,-24(s0)
    8000434a:	10079073          	csrw	sstatus,a5
}
    8000434e:	0001                	nop
    80004350:	6462                	ld	s0,24(sp)
    80004352:	6105                	addi	sp,sp,32
    80004354:	8082                	ret

0000000080004356 <r_sip>:
{
    80004356:	1101                	addi	sp,sp,-32
    80004358:	ec22                	sd	s0,24(sp)
    8000435a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sip" : "=r" (x) );
    8000435c:	144027f3          	csrr	a5,sip
    80004360:	fef43423          	sd	a5,-24(s0)
  return x;
    80004364:	fe843783          	ld	a5,-24(s0)
}
    80004368:	853e                	mv	a0,a5
    8000436a:	6462                	ld	s0,24(sp)
    8000436c:	6105                	addi	sp,sp,32
    8000436e:	8082                	ret

0000000080004370 <w_sip>:
{
    80004370:	1101                	addi	sp,sp,-32
    80004372:	ec22                	sd	s0,24(sp)
    80004374:	1000                	addi	s0,sp,32
    80004376:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sip, %0" : : "r" (x));
    8000437a:	fe843783          	ld	a5,-24(s0)
    8000437e:	14479073          	csrw	sip,a5
}
    80004382:	0001                	nop
    80004384:	6462                	ld	s0,24(sp)
    80004386:	6105                	addi	sp,sp,32
    80004388:	8082                	ret

000000008000438a <w_sepc>:
{
    8000438a:	1101                	addi	sp,sp,-32
    8000438c:	ec22                	sd	s0,24(sp)
    8000438e:	1000                	addi	s0,sp,32
    80004390:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80004394:	fe843783          	ld	a5,-24(s0)
    80004398:	14179073          	csrw	sepc,a5
}
    8000439c:	0001                	nop
    8000439e:	6462                	ld	s0,24(sp)
    800043a0:	6105                	addi	sp,sp,32
    800043a2:	8082                	ret

00000000800043a4 <r_sepc>:
{
    800043a4:	1101                	addi	sp,sp,-32
    800043a6:	ec22                	sd	s0,24(sp)
    800043a8:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800043aa:	141027f3          	csrr	a5,sepc
    800043ae:	fef43423          	sd	a5,-24(s0)
  return x;
    800043b2:	fe843783          	ld	a5,-24(s0)
}
    800043b6:	853e                	mv	a0,a5
    800043b8:	6462                	ld	s0,24(sp)
    800043ba:	6105                	addi	sp,sp,32
    800043bc:	8082                	ret

00000000800043be <w_stvec>:
{
    800043be:	1101                	addi	sp,sp,-32
    800043c0:	ec22                	sd	s0,24(sp)
    800043c2:	1000                	addi	s0,sp,32
    800043c4:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw stvec, %0" : : "r" (x));
    800043c8:	fe843783          	ld	a5,-24(s0)
    800043cc:	10579073          	csrw	stvec,a5
}
    800043d0:	0001                	nop
    800043d2:	6462                	ld	s0,24(sp)
    800043d4:	6105                	addi	sp,sp,32
    800043d6:	8082                	ret

00000000800043d8 <r_satp>:
{
    800043d8:	1101                	addi	sp,sp,-32
    800043da:	ec22                	sd	s0,24(sp)
    800043dc:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, satp" : "=r" (x) );
    800043de:	180027f3          	csrr	a5,satp
    800043e2:	fef43423          	sd	a5,-24(s0)
  return x;
    800043e6:	fe843783          	ld	a5,-24(s0)
}
    800043ea:	853e                	mv	a0,a5
    800043ec:	6462                	ld	s0,24(sp)
    800043ee:	6105                	addi	sp,sp,32
    800043f0:	8082                	ret

00000000800043f2 <r_scause>:
{
    800043f2:	1101                	addi	sp,sp,-32
    800043f4:	ec22                	sd	s0,24(sp)
    800043f6:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    800043f8:	142027f3          	csrr	a5,scause
    800043fc:	fef43423          	sd	a5,-24(s0)
  return x;
    80004400:	fe843783          	ld	a5,-24(s0)
}
    80004404:	853e                	mv	a0,a5
    80004406:	6462                	ld	s0,24(sp)
    80004408:	6105                	addi	sp,sp,32
    8000440a:	8082                	ret

000000008000440c <r_stval>:
{
    8000440c:	1101                	addi	sp,sp,-32
    8000440e:	ec22                	sd	s0,24(sp)
    80004410:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, stval" : "=r" (x) );
    80004412:	143027f3          	csrr	a5,stval
    80004416:	fef43423          	sd	a5,-24(s0)
  return x;
    8000441a:	fe843783          	ld	a5,-24(s0)
}
    8000441e:	853e                	mv	a0,a5
    80004420:	6462                	ld	s0,24(sp)
    80004422:	6105                	addi	sp,sp,32
    80004424:	8082                	ret

0000000080004426 <intr_on>:
{
    80004426:	1141                	addi	sp,sp,-16
    80004428:	e406                	sd	ra,8(sp)
    8000442a:	e022                	sd	s0,0(sp)
    8000442c:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000442e:	00000097          	auipc	ra,0x0
    80004432:	ef4080e7          	jalr	-268(ra) # 80004322 <r_sstatus>
    80004436:	87aa                	mv	a5,a0
    80004438:	0027e793          	ori	a5,a5,2
    8000443c:	853e                	mv	a0,a5
    8000443e:	00000097          	auipc	ra,0x0
    80004442:	efe080e7          	jalr	-258(ra) # 8000433c <w_sstatus>
}
    80004446:	0001                	nop
    80004448:	60a2                	ld	ra,8(sp)
    8000444a:	6402                	ld	s0,0(sp)
    8000444c:	0141                	addi	sp,sp,16
    8000444e:	8082                	ret

0000000080004450 <intr_off>:
{
    80004450:	1141                	addi	sp,sp,-16
    80004452:	e406                	sd	ra,8(sp)
    80004454:	e022                	sd	s0,0(sp)
    80004456:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80004458:	00000097          	auipc	ra,0x0
    8000445c:	eca080e7          	jalr	-310(ra) # 80004322 <r_sstatus>
    80004460:	87aa                	mv	a5,a0
    80004462:	9bf5                	andi	a5,a5,-3
    80004464:	853e                	mv	a0,a5
    80004466:	00000097          	auipc	ra,0x0
    8000446a:	ed6080e7          	jalr	-298(ra) # 8000433c <w_sstatus>
}
    8000446e:	0001                	nop
    80004470:	60a2                	ld	ra,8(sp)
    80004472:	6402                	ld	s0,0(sp)
    80004474:	0141                	addi	sp,sp,16
    80004476:	8082                	ret

0000000080004478 <intr_get>:
{
    80004478:	1101                	addi	sp,sp,-32
    8000447a:	ec06                	sd	ra,24(sp)
    8000447c:	e822                	sd	s0,16(sp)
    8000447e:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    80004480:	00000097          	auipc	ra,0x0
    80004484:	ea2080e7          	jalr	-350(ra) # 80004322 <r_sstatus>
    80004488:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    8000448c:	fe843783          	ld	a5,-24(s0)
    80004490:	8b89                	andi	a5,a5,2
    80004492:	00f037b3          	snez	a5,a5
    80004496:	0ff7f793          	zext.b	a5,a5
    8000449a:	2781                	sext.w	a5,a5
}
    8000449c:	853e                	mv	a0,a5
    8000449e:	60e2                	ld	ra,24(sp)
    800044a0:	6442                	ld	s0,16(sp)
    800044a2:	6105                	addi	sp,sp,32
    800044a4:	8082                	ret

00000000800044a6 <r_tp>:
{
    800044a6:	1101                	addi	sp,sp,-32
    800044a8:	ec22                	sd	s0,24(sp)
    800044aa:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    800044ac:	8792                	mv	a5,tp
    800044ae:	fef43423          	sd	a5,-24(s0)
  return x;
    800044b2:	fe843783          	ld	a5,-24(s0)
}
    800044b6:	853e                	mv	a0,a5
    800044b8:	6462                	ld	s0,24(sp)
    800044ba:	6105                	addi	sp,sp,32
    800044bc:	8082                	ret

00000000800044be <trapinit>:

extern int devintr();

void
trapinit(void)
{
    800044be:	1141                	addi	sp,sp,-16
    800044c0:	e406                	sd	ra,8(sp)
    800044c2:	e022                	sd	s0,0(sp)
    800044c4:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    800044c6:	00007597          	auipc	a1,0x7
    800044ca:	f1a58593          	addi	a1,a1,-230 # 8000b3e0 <etext+0x3e0>
    800044ce:	00496517          	auipc	a0,0x496
    800044d2:	5fa50513          	addi	a0,a0,1530 # 8049aac8 <tickslock>
    800044d6:	ffffd097          	auipc	ra,0xffffd
    800044da:	d64080e7          	jalr	-668(ra) # 8000123a <initlock>
}
    800044de:	0001                	nop
    800044e0:	60a2                	ld	ra,8(sp)
    800044e2:	6402                	ld	s0,0(sp)
    800044e4:	0141                	addi	sp,sp,16
    800044e6:	8082                	ret

00000000800044e8 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    800044e8:	1141                	addi	sp,sp,-16
    800044ea:	e406                	sd	ra,8(sp)
    800044ec:	e022                	sd	s0,0(sp)
    800044ee:	0800                	addi	s0,sp,16
  w_stvec((uint64)kernelvec);
    800044f0:	00005797          	auipc	a5,0x5
    800044f4:	f2078793          	addi	a5,a5,-224 # 80009410 <kernelvec>
    800044f8:	853e                	mv	a0,a5
    800044fa:	00000097          	auipc	ra,0x0
    800044fe:	ec4080e7          	jalr	-316(ra) # 800043be <w_stvec>
}
    80004502:	0001                	nop
    80004504:	60a2                	ld	ra,8(sp)
    80004506:	6402                	ld	s0,0(sp)
    80004508:	0141                	addi	sp,sp,16
    8000450a:	8082                	ret

000000008000450c <usertrap>:
// handle an interrupt, exception, or system call from user space.
// called from trampoline.S
//
void
usertrap(void)
{
    8000450c:	7179                	addi	sp,sp,-48
    8000450e:	f406                	sd	ra,40(sp)
    80004510:	f022                	sd	s0,32(sp)
    80004512:	ec26                	sd	s1,24(sp)
    80004514:	1800                	addi	s0,sp,48
  int which_dev = 0;
    80004516:	fc042e23          	sw	zero,-36(s0)

  if((r_sstatus() & SSTATUS_SPP) != 0)
    8000451a:	00000097          	auipc	ra,0x0
    8000451e:	e08080e7          	jalr	-504(ra) # 80004322 <r_sstatus>
    80004522:	87aa                	mv	a5,a0
    80004524:	1007f793          	andi	a5,a5,256
    80004528:	cb89                	beqz	a5,8000453a <usertrap+0x2e>
    panic("usertrap: not from user mode");
    8000452a:	00007517          	auipc	a0,0x7
    8000452e:	ebe50513          	addi	a0,a0,-322 # 8000b3e8 <etext+0x3e8>
    80004532:	ffffc097          	auipc	ra,0xffffc
    80004536:	748080e7          	jalr	1864(ra) # 80000c7a <panic>

  // send interrupts and exceptions to kerneltrap(),
  // since we're now in the kernel.
  w_stvec((uint64)kernelvec);
    8000453a:	00005797          	auipc	a5,0x5
    8000453e:	ed678793          	addi	a5,a5,-298 # 80009410 <kernelvec>
    80004542:	853e                	mv	a0,a5
    80004544:	00000097          	auipc	ra,0x0
    80004548:	e7a080e7          	jalr	-390(ra) # 800043be <w_stvec>

  struct proc *p = myproc();
    8000454c:	ffffe097          	auipc	ra,0xffffe
    80004550:	4cc080e7          	jalr	1228(ra) # 80002a18 <myproc>
    80004554:	fca43823          	sd	a0,-48(s0)
  
  // save user program counter.
  p->trapframe->epc = r_sepc();
    80004558:	fd043783          	ld	a5,-48(s0)
    8000455c:	73a4                	ld	s1,96(a5)
    8000455e:	00000097          	auipc	ra,0x0
    80004562:	e46080e7          	jalr	-442(ra) # 800043a4 <r_sepc>
    80004566:	87aa                	mv	a5,a0
    80004568:	ec9c                	sd	a5,24(s1)
  
  if(r_scause() == 8){
    8000456a:	00000097          	auipc	ra,0x0
    8000456e:	e88080e7          	jalr	-376(ra) # 800043f2 <r_scause>
    80004572:	872a                	mv	a4,a0
    80004574:	47a1                	li	a5,8
    80004576:	02f71d63          	bne	a4,a5,800045b0 <usertrap+0xa4>
    // system call

    if(p->killed)
    8000457a:	fd043783          	ld	a5,-48(s0)
    8000457e:	579c                	lw	a5,40(a5)
    80004580:	c791                	beqz	a5,8000458c <usertrap+0x80>
      exit(-1);
    80004582:	557d                	li	a0,-1
    80004584:	fffff097          	auipc	ra,0xfffff
    80004588:	e9e080e7          	jalr	-354(ra) # 80003422 <exit>

    // sepc points to the ecall instruction,
    // but we want to return to the next instruction.
    p->trapframe->epc += 4;
    8000458c:	fd043783          	ld	a5,-48(s0)
    80004590:	73bc                	ld	a5,96(a5)
    80004592:	6f98                	ld	a4,24(a5)
    80004594:	fd043783          	ld	a5,-48(s0)
    80004598:	73bc                	ld	a5,96(a5)
    8000459a:	0711                	addi	a4,a4,4
    8000459c:	ef98                	sd	a4,24(a5)

    // an interrupt will change sstatus &c registers,
    // so don't enable until done with those registers.
    intr_on();
    8000459e:	00000097          	auipc	ra,0x0
    800045a2:	e88080e7          	jalr	-376(ra) # 80004426 <intr_on>

    syscall();
    800045a6:	00000097          	auipc	ra,0x0
    800045aa:	67e080e7          	jalr	1662(ra) # 80004c24 <syscall>
    800045ae:	a0b5                	j	8000461a <usertrap+0x10e>
  } else if((which_dev = devintr()) != 0){
    800045b0:	00000097          	auipc	ra,0x0
    800045b4:	346080e7          	jalr	838(ra) # 800048f6 <devintr>
    800045b8:	87aa                	mv	a5,a0
    800045ba:	fcf42e23          	sw	a5,-36(s0)
    800045be:	fdc42783          	lw	a5,-36(s0)
    800045c2:	2781                	sext.w	a5,a5
    800045c4:	ebb9                	bnez	a5,8000461a <usertrap+0x10e>
    // ok
  } else {
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    800045c6:	00000097          	auipc	ra,0x0
    800045ca:	e2c080e7          	jalr	-468(ra) # 800043f2 <r_scause>
    800045ce:	872a                	mv	a4,a0
    800045d0:	fd043783          	ld	a5,-48(s0)
    800045d4:	5b9c                	lw	a5,48(a5)
    800045d6:	863e                	mv	a2,a5
    800045d8:	85ba                	mv	a1,a4
    800045da:	00007517          	auipc	a0,0x7
    800045de:	e2e50513          	addi	a0,a0,-466 # 8000b408 <etext+0x408>
    800045e2:	ffffc097          	auipc	ra,0xffffc
    800045e6:	442080e7          	jalr	1090(ra) # 80000a24 <printf>
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    800045ea:	00000097          	auipc	ra,0x0
    800045ee:	dba080e7          	jalr	-582(ra) # 800043a4 <r_sepc>
    800045f2:	84aa                	mv	s1,a0
    800045f4:	00000097          	auipc	ra,0x0
    800045f8:	e18080e7          	jalr	-488(ra) # 8000440c <r_stval>
    800045fc:	87aa                	mv	a5,a0
    800045fe:	863e                	mv	a2,a5
    80004600:	85a6                	mv	a1,s1
    80004602:	00007517          	auipc	a0,0x7
    80004606:	e3650513          	addi	a0,a0,-458 # 8000b438 <etext+0x438>
    8000460a:	ffffc097          	auipc	ra,0xffffc
    8000460e:	41a080e7          	jalr	1050(ra) # 80000a24 <printf>
    p->killed = 1;
    80004612:	fd043783          	ld	a5,-48(s0)
    80004616:	4705                	li	a4,1
    80004618:	d798                	sw	a4,40(a5)
  }

  if(p->killed)
    8000461a:	fd043783          	ld	a5,-48(s0)
    8000461e:	579c                	lw	a5,40(a5)
    80004620:	c791                	beqz	a5,8000462c <usertrap+0x120>
    exit(-1);
    80004622:	557d                	li	a0,-1
    80004624:	fffff097          	auipc	ra,0xfffff
    80004628:	dfe080e7          	jalr	-514(ra) # 80003422 <exit>

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2)
    8000462c:	fdc42783          	lw	a5,-36(s0)
    80004630:	0007871b          	sext.w	a4,a5
    80004634:	4789                	li	a5,2
    80004636:	00f71663          	bne	a4,a5,80004642 <usertrap+0x136>
    yield();
    8000463a:	fffff097          	auipc	ra,0xfffff
    8000463e:	24e080e7          	jalr	590(ra) # 80003888 <yield>

  usertrapret();
    80004642:	00000097          	auipc	ra,0x0
    80004646:	014080e7          	jalr	20(ra) # 80004656 <usertrapret>
}
    8000464a:	0001                	nop
    8000464c:	70a2                	ld	ra,40(sp)
    8000464e:	7402                	ld	s0,32(sp)
    80004650:	64e2                	ld	s1,24(sp)
    80004652:	6145                	addi	sp,sp,48
    80004654:	8082                	ret

0000000080004656 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80004656:	7139                	addi	sp,sp,-64
    80004658:	fc06                	sd	ra,56(sp)
    8000465a:	f822                	sd	s0,48(sp)
    8000465c:	f426                	sd	s1,40(sp)
    8000465e:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80004660:	ffffe097          	auipc	ra,0xffffe
    80004664:	3b8080e7          	jalr	952(ra) # 80002a18 <myproc>
    80004668:	fca43c23          	sd	a0,-40(s0)

  // we're about to switch the destination of traps from
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();
    8000466c:	00000097          	auipc	ra,0x0
    80004670:	de4080e7          	jalr	-540(ra) # 80004450 <intr_off>

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80004674:	00006717          	auipc	a4,0x6
    80004678:	98c70713          	addi	a4,a4,-1652 # 8000a000 <_trampoline>
    8000467c:	00006797          	auipc	a5,0x6
    80004680:	98478793          	addi	a5,a5,-1660 # 8000a000 <_trampoline>
    80004684:	8f1d                	sub	a4,a4,a5
    80004686:	040007b7          	lui	a5,0x4000
    8000468a:	17fd                	addi	a5,a5,-1
    8000468c:	07b2                	slli	a5,a5,0xc
    8000468e:	97ba                	add	a5,a5,a4
    80004690:	853e                	mv	a0,a5
    80004692:	00000097          	auipc	ra,0x0
    80004696:	d2c080e7          	jalr	-724(ra) # 800043be <w_stvec>

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    8000469a:	fd843783          	ld	a5,-40(s0)
    8000469e:	73a4                	ld	s1,96(a5)
    800046a0:	00000097          	auipc	ra,0x0
    800046a4:	d38080e7          	jalr	-712(ra) # 800043d8 <r_satp>
    800046a8:	87aa                	mv	a5,a0
    800046aa:	e09c                	sd	a5,0(s1)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    800046ac:	fd843783          	ld	a5,-40(s0)
    800046b0:	63b4                	ld	a3,64(a5)
    800046b2:	fd843783          	ld	a5,-40(s0)
    800046b6:	73bc                	ld	a5,96(a5)
    800046b8:	6705                	lui	a4,0x1
    800046ba:	9736                	add	a4,a4,a3
    800046bc:	e798                	sd	a4,8(a5)
  p->trapframe->kernel_trap = (uint64)usertrap;
    800046be:	fd843783          	ld	a5,-40(s0)
    800046c2:	73bc                	ld	a5,96(a5)
    800046c4:	00000717          	auipc	a4,0x0
    800046c8:	e4870713          	addi	a4,a4,-440 # 8000450c <usertrap>
    800046cc:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    800046ce:	fd843783          	ld	a5,-40(s0)
    800046d2:	73a4                	ld	s1,96(a5)
    800046d4:	00000097          	auipc	ra,0x0
    800046d8:	dd2080e7          	jalr	-558(ra) # 800044a6 <r_tp>
    800046dc:	87aa                	mv	a5,a0
    800046de:	f09c                	sd	a5,32(s1)

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
    800046e0:	00000097          	auipc	ra,0x0
    800046e4:	c42080e7          	jalr	-958(ra) # 80004322 <r_sstatus>
    800046e8:	fca43823          	sd	a0,-48(s0)
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800046ec:	fd043783          	ld	a5,-48(s0)
    800046f0:	eff7f793          	andi	a5,a5,-257
    800046f4:	fcf43823          	sd	a5,-48(s0)
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800046f8:	fd043783          	ld	a5,-48(s0)
    800046fc:	0207e793          	ori	a5,a5,32
    80004700:	fcf43823          	sd	a5,-48(s0)
  w_sstatus(x);
    80004704:	fd043503          	ld	a0,-48(s0)
    80004708:	00000097          	auipc	ra,0x0
    8000470c:	c34080e7          	jalr	-972(ra) # 8000433c <w_sstatus>

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80004710:	fd843783          	ld	a5,-40(s0)
    80004714:	73bc                	ld	a5,96(a5)
    80004716:	6f9c                	ld	a5,24(a5)
    80004718:	853e                	mv	a0,a5
    8000471a:	00000097          	auipc	ra,0x0
    8000471e:	c70080e7          	jalr	-912(ra) # 8000438a <w_sepc>

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80004722:	fd843783          	ld	a5,-40(s0)
    80004726:	6bbc                	ld	a5,80(a5)
    80004728:	00c7d713          	srli	a4,a5,0xc
    8000472c:	57fd                	li	a5,-1
    8000472e:	17fe                	slli	a5,a5,0x3f
    80004730:	8fd9                	or	a5,a5,a4
    80004732:	fcf43423          	sd	a5,-56(s0)

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80004736:	00006717          	auipc	a4,0x6
    8000473a:	95a70713          	addi	a4,a4,-1702 # 8000a090 <userret>
    8000473e:	00006797          	auipc	a5,0x6
    80004742:	8c278793          	addi	a5,a5,-1854 # 8000a000 <_trampoline>
    80004746:	8f1d                	sub	a4,a4,a5
    80004748:	040007b7          	lui	a5,0x4000
    8000474c:	17fd                	addi	a5,a5,-1
    8000474e:	07b2                	slli	a5,a5,0xc
    80004750:	97ba                	add	a5,a5,a4
    80004752:	fcf43023          	sd	a5,-64(s0)
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80004756:	fc043703          	ld	a4,-64(s0)
    8000475a:	fc843583          	ld	a1,-56(s0)
    8000475e:	020007b7          	lui	a5,0x2000
    80004762:	17fd                	addi	a5,a5,-1
    80004764:	00d79513          	slli	a0,a5,0xd
    80004768:	9702                	jalr	a4
}
    8000476a:	0001                	nop
    8000476c:	70e2                	ld	ra,56(sp)
    8000476e:	7442                	ld	s0,48(sp)
    80004770:	74a2                	ld	s1,40(sp)
    80004772:	6121                	addi	sp,sp,64
    80004774:	8082                	ret

0000000080004776 <kerneltrap>:

// interrupts and exceptions from kernel code go here via kernelvec,
// on whatever the current kernel stack is.
void 
kerneltrap()
{
    80004776:	7139                	addi	sp,sp,-64
    80004778:	fc06                	sd	ra,56(sp)
    8000477a:	f822                	sd	s0,48(sp)
    8000477c:	f426                	sd	s1,40(sp)
    8000477e:	0080                	addi	s0,sp,64
  int which_dev = 0;
    80004780:	fc042e23          	sw	zero,-36(s0)
  uint64 sepc = r_sepc();
    80004784:	00000097          	auipc	ra,0x0
    80004788:	c20080e7          	jalr	-992(ra) # 800043a4 <r_sepc>
    8000478c:	fca43823          	sd	a0,-48(s0)
  uint64 sstatus = r_sstatus();
    80004790:	00000097          	auipc	ra,0x0
    80004794:	b92080e7          	jalr	-1134(ra) # 80004322 <r_sstatus>
    80004798:	fca43423          	sd	a0,-56(s0)
  uint64 scause = r_scause();
    8000479c:	00000097          	auipc	ra,0x0
    800047a0:	c56080e7          	jalr	-938(ra) # 800043f2 <r_scause>
    800047a4:	fca43023          	sd	a0,-64(s0)
  
  if((sstatus & SSTATUS_SPP) == 0)
    800047a8:	fc843783          	ld	a5,-56(s0)
    800047ac:	1007f793          	andi	a5,a5,256
    800047b0:	eb89                	bnez	a5,800047c2 <kerneltrap+0x4c>
    panic("kerneltrap: not from supervisor mode");
    800047b2:	00007517          	auipc	a0,0x7
    800047b6:	ca650513          	addi	a0,a0,-858 # 8000b458 <etext+0x458>
    800047ba:	ffffc097          	auipc	ra,0xffffc
    800047be:	4c0080e7          	jalr	1216(ra) # 80000c7a <panic>
  if(intr_get() != 0)
    800047c2:	00000097          	auipc	ra,0x0
    800047c6:	cb6080e7          	jalr	-842(ra) # 80004478 <intr_get>
    800047ca:	87aa                	mv	a5,a0
    800047cc:	cb89                	beqz	a5,800047de <kerneltrap+0x68>
    panic("kerneltrap: interrupts enabled");
    800047ce:	00007517          	auipc	a0,0x7
    800047d2:	cb250513          	addi	a0,a0,-846 # 8000b480 <etext+0x480>
    800047d6:	ffffc097          	auipc	ra,0xffffc
    800047da:	4a4080e7          	jalr	1188(ra) # 80000c7a <panic>

  if((which_dev = devintr()) == 0){
    800047de:	00000097          	auipc	ra,0x0
    800047e2:	118080e7          	jalr	280(ra) # 800048f6 <devintr>
    800047e6:	87aa                	mv	a5,a0
    800047e8:	fcf42e23          	sw	a5,-36(s0)
    800047ec:	fdc42783          	lw	a5,-36(s0)
    800047f0:	2781                	sext.w	a5,a5
    800047f2:	e7b9                	bnez	a5,80004840 <kerneltrap+0xca>
    printf("scause %p\n", scause);
    800047f4:	fc043583          	ld	a1,-64(s0)
    800047f8:	00007517          	auipc	a0,0x7
    800047fc:	ca850513          	addi	a0,a0,-856 # 8000b4a0 <etext+0x4a0>
    80004800:	ffffc097          	auipc	ra,0xffffc
    80004804:	224080e7          	jalr	548(ra) # 80000a24 <printf>
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80004808:	00000097          	auipc	ra,0x0
    8000480c:	b9c080e7          	jalr	-1124(ra) # 800043a4 <r_sepc>
    80004810:	84aa                	mv	s1,a0
    80004812:	00000097          	auipc	ra,0x0
    80004816:	bfa080e7          	jalr	-1030(ra) # 8000440c <r_stval>
    8000481a:	87aa                	mv	a5,a0
    8000481c:	863e                	mv	a2,a5
    8000481e:	85a6                	mv	a1,s1
    80004820:	00007517          	auipc	a0,0x7
    80004824:	c9050513          	addi	a0,a0,-880 # 8000b4b0 <etext+0x4b0>
    80004828:	ffffc097          	auipc	ra,0xffffc
    8000482c:	1fc080e7          	jalr	508(ra) # 80000a24 <printf>
    panic("kerneltrap");
    80004830:	00007517          	auipc	a0,0x7
    80004834:	c9850513          	addi	a0,a0,-872 # 8000b4c8 <etext+0x4c8>
    80004838:	ffffc097          	auipc	ra,0xffffc
    8000483c:	442080e7          	jalr	1090(ra) # 80000c7a <panic>
  }

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80004840:	fdc42783          	lw	a5,-36(s0)
    80004844:	0007871b          	sext.w	a4,a5
    80004848:	4789                	li	a5,2
    8000484a:	02f71663          	bne	a4,a5,80004876 <kerneltrap+0x100>
    8000484e:	ffffe097          	auipc	ra,0xffffe
    80004852:	1ca080e7          	jalr	458(ra) # 80002a18 <myproc>
    80004856:	87aa                	mv	a5,a0
    80004858:	cf99                	beqz	a5,80004876 <kerneltrap+0x100>
    8000485a:	ffffe097          	auipc	ra,0xffffe
    8000485e:	1be080e7          	jalr	446(ra) # 80002a18 <myproc>
    80004862:	87aa                	mv	a5,a0
    80004864:	4f9c                	lw	a5,24(a5)
    80004866:	873e                	mv	a4,a5
    80004868:	4791                	li	a5,4
    8000486a:	00f71663          	bne	a4,a5,80004876 <kerneltrap+0x100>
    yield();
    8000486e:	fffff097          	auipc	ra,0xfffff
    80004872:	01a080e7          	jalr	26(ra) # 80003888 <yield>

  // the yield() may have caused some traps to occur,
  // so restore trap registers for use by kernelvec.S's sepc instruction.
  w_sepc(sepc);
    80004876:	fd043503          	ld	a0,-48(s0)
    8000487a:	00000097          	auipc	ra,0x0
    8000487e:	b10080e7          	jalr	-1264(ra) # 8000438a <w_sepc>
  w_sstatus(sstatus);
    80004882:	fc843503          	ld	a0,-56(s0)
    80004886:	00000097          	auipc	ra,0x0
    8000488a:	ab6080e7          	jalr	-1354(ra) # 8000433c <w_sstatus>
}
    8000488e:	0001                	nop
    80004890:	70e2                	ld	ra,56(sp)
    80004892:	7442                	ld	s0,48(sp)
    80004894:	74a2                	ld	s1,40(sp)
    80004896:	6121                	addi	sp,sp,64
    80004898:	8082                	ret

000000008000489a <clockintr>:

void
clockintr()
{
    8000489a:	1141                	addi	sp,sp,-16
    8000489c:	e406                	sd	ra,8(sp)
    8000489e:	e022                	sd	s0,0(sp)
    800048a0:	0800                	addi	s0,sp,16
  acquire(&tickslock);
    800048a2:	00496517          	auipc	a0,0x496
    800048a6:	22650513          	addi	a0,a0,550 # 8049aac8 <tickslock>
    800048aa:	ffffd097          	auipc	ra,0xffffd
    800048ae:	9c0080e7          	jalr	-1600(ra) # 8000126a <acquire>
  ticks++;
    800048b2:	00007797          	auipc	a5,0x7
    800048b6:	77678793          	addi	a5,a5,1910 # 8000c028 <ticks>
    800048ba:	439c                	lw	a5,0(a5)
    800048bc:	2785                	addiw	a5,a5,1
    800048be:	0007871b          	sext.w	a4,a5
    800048c2:	00007797          	auipc	a5,0x7
    800048c6:	76678793          	addi	a5,a5,1894 # 8000c028 <ticks>
    800048ca:	c398                	sw	a4,0(a5)
  wakeup(&ticks);
    800048cc:	00007517          	auipc	a0,0x7
    800048d0:	75c50513          	addi	a0,a0,1884 # 8000c028 <ticks>
    800048d4:	fffff097          	auipc	ra,0xfffff
    800048d8:	0ca080e7          	jalr	202(ra) # 8000399e <wakeup>
  release(&tickslock);
    800048dc:	00496517          	auipc	a0,0x496
    800048e0:	1ec50513          	addi	a0,a0,492 # 8049aac8 <tickslock>
    800048e4:	ffffd097          	auipc	ra,0xffffd
    800048e8:	9ea080e7          	jalr	-1558(ra) # 800012ce <release>
}
    800048ec:	0001                	nop
    800048ee:	60a2                	ld	ra,8(sp)
    800048f0:	6402                	ld	s0,0(sp)
    800048f2:	0141                	addi	sp,sp,16
    800048f4:	8082                	ret

00000000800048f6 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    800048f6:	1101                	addi	sp,sp,-32
    800048f8:	ec06                	sd	ra,24(sp)
    800048fa:	e822                	sd	s0,16(sp)
    800048fc:	1000                	addi	s0,sp,32
  uint64 scause = r_scause();
    800048fe:	00000097          	auipc	ra,0x0
    80004902:	af4080e7          	jalr	-1292(ra) # 800043f2 <r_scause>
    80004906:	fea43423          	sd	a0,-24(s0)

  if((scause & 0x8000000000000000L) &&
    8000490a:	fe843783          	ld	a5,-24(s0)
    8000490e:	0807d463          	bgez	a5,80004996 <devintr+0xa0>
     (scause & 0xff) == 9){
    80004912:	fe843783          	ld	a5,-24(s0)
    80004916:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    8000491a:	47a5                	li	a5,9
    8000491c:	06f71d63          	bne	a4,a5,80004996 <devintr+0xa0>
    // this is a supervisor external interrupt, via PLIC.

    // irq indicates which device interrupted.
    int irq = plic_claim();
    80004920:	00005097          	auipc	ra,0x5
    80004924:	c22080e7          	jalr	-990(ra) # 80009542 <plic_claim>
    80004928:	87aa                	mv	a5,a0
    8000492a:	fef42223          	sw	a5,-28(s0)

    if(irq == UART0_IRQ){
    8000492e:	fe442783          	lw	a5,-28(s0)
    80004932:	0007871b          	sext.w	a4,a5
    80004936:	47a9                	li	a5,10
    80004938:	00f71763          	bne	a4,a5,80004946 <devintr+0x50>
      uartintr();
    8000493c:	ffffc097          	auipc	ra,0xffffc
    80004940:	636080e7          	jalr	1590(ra) # 80000f72 <uartintr>
    80004944:	a825                	j	8000497c <devintr+0x86>
    } else if(irq == VIRTIO0_IRQ){
    80004946:	fe442783          	lw	a5,-28(s0)
    8000494a:	0007871b          	sext.w	a4,a5
    8000494e:	4785                	li	a5,1
    80004950:	00f71763          	bne	a4,a5,8000495e <devintr+0x68>
      virtio_disk_intr();
    80004954:	00005097          	auipc	ra,0x5
    80004958:	504080e7          	jalr	1284(ra) # 80009e58 <virtio_disk_intr>
    8000495c:	a005                	j	8000497c <devintr+0x86>
    } else if(irq){
    8000495e:	fe442783          	lw	a5,-28(s0)
    80004962:	2781                	sext.w	a5,a5
    80004964:	cf81                	beqz	a5,8000497c <devintr+0x86>
      printf("unexpected interrupt irq=%d\n", irq);
    80004966:	fe442783          	lw	a5,-28(s0)
    8000496a:	85be                	mv	a1,a5
    8000496c:	00007517          	auipc	a0,0x7
    80004970:	b6c50513          	addi	a0,a0,-1172 # 8000b4d8 <etext+0x4d8>
    80004974:	ffffc097          	auipc	ra,0xffffc
    80004978:	0b0080e7          	jalr	176(ra) # 80000a24 <printf>
    }

    // the PLIC allows each device to raise at most one
    // interrupt at a time; tell the PLIC the device is
    // now allowed to interrupt again.
    if(irq)
    8000497c:	fe442783          	lw	a5,-28(s0)
    80004980:	2781                	sext.w	a5,a5
    80004982:	cb81                	beqz	a5,80004992 <devintr+0x9c>
      plic_complete(irq);
    80004984:	fe442783          	lw	a5,-28(s0)
    80004988:	853e                	mv	a0,a5
    8000498a:	00005097          	auipc	ra,0x5
    8000498e:	bf6080e7          	jalr	-1034(ra) # 80009580 <plic_complete>

    return 1;
    80004992:	4785                	li	a5,1
    80004994:	a081                	j	800049d4 <devintr+0xde>
  } else if(scause == 0x8000000000000001L){
    80004996:	fe843703          	ld	a4,-24(s0)
    8000499a:	57fd                	li	a5,-1
    8000499c:	17fe                	slli	a5,a5,0x3f
    8000499e:	0785                	addi	a5,a5,1
    800049a0:	02f71963          	bne	a4,a5,800049d2 <devintr+0xdc>
    // software interrupt from a machine-mode timer interrupt,
    // forwarded by timervec in kernelvec.S.

    if(cpuid() == 0){
    800049a4:	ffffe097          	auipc	ra,0xffffe
    800049a8:	016080e7          	jalr	22(ra) # 800029ba <cpuid>
    800049ac:	87aa                	mv	a5,a0
    800049ae:	e789                	bnez	a5,800049b8 <devintr+0xc2>
      clockintr();
    800049b0:	00000097          	auipc	ra,0x0
    800049b4:	eea080e7          	jalr	-278(ra) # 8000489a <clockintr>
    }
    
    // acknowledge the software interrupt by clearing
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);
    800049b8:	00000097          	auipc	ra,0x0
    800049bc:	99e080e7          	jalr	-1634(ra) # 80004356 <r_sip>
    800049c0:	87aa                	mv	a5,a0
    800049c2:	9bf5                	andi	a5,a5,-3
    800049c4:	853e                	mv	a0,a5
    800049c6:	00000097          	auipc	ra,0x0
    800049ca:	9aa080e7          	jalr	-1622(ra) # 80004370 <w_sip>

    return 2;
    800049ce:	4789                	li	a5,2
    800049d0:	a011                	j	800049d4 <devintr+0xde>
  } else {
    return 0;
    800049d2:	4781                	li	a5,0
  }
}
    800049d4:	853e                	mv	a0,a5
    800049d6:	60e2                	ld	ra,24(sp)
    800049d8:	6442                	ld	s0,16(sp)
    800049da:	6105                	addi	sp,sp,32
    800049dc:	8082                	ret

00000000800049de <fetchaddr>:
#include "defs.h"

// Fetch the uint64 at addr from the current process.
int
fetchaddr(uint64 addr, uint64 *ip)
{
    800049de:	7179                	addi	sp,sp,-48
    800049e0:	f406                	sd	ra,40(sp)
    800049e2:	f022                	sd	s0,32(sp)
    800049e4:	1800                	addi	s0,sp,48
    800049e6:	fca43c23          	sd	a0,-40(s0)
    800049ea:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    800049ee:	ffffe097          	auipc	ra,0xffffe
    800049f2:	02a080e7          	jalr	42(ra) # 80002a18 <myproc>
    800049f6:	fea43423          	sd	a0,-24(s0)
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    800049fa:	fe843783          	ld	a5,-24(s0)
    800049fe:	67bc                	ld	a5,72(a5)
    80004a00:	fd843703          	ld	a4,-40(s0)
    80004a04:	00f77b63          	bgeu	a4,a5,80004a1a <fetchaddr+0x3c>
    80004a08:	fd843783          	ld	a5,-40(s0)
    80004a0c:	00878713          	addi	a4,a5,8
    80004a10:	fe843783          	ld	a5,-24(s0)
    80004a14:	67bc                	ld	a5,72(a5)
    80004a16:	00e7f463          	bgeu	a5,a4,80004a1e <fetchaddr+0x40>
    return -1;
    80004a1a:	57fd                	li	a5,-1
    80004a1c:	a01d                	j	80004a42 <fetchaddr+0x64>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80004a1e:	fe843783          	ld	a5,-24(s0)
    80004a22:	6bbc                	ld	a5,80(a5)
    80004a24:	46a1                	li	a3,8
    80004a26:	fd843603          	ld	a2,-40(s0)
    80004a2a:	fd043583          	ld	a1,-48(s0)
    80004a2e:	853e                	mv	a0,a5
    80004a30:	ffffe097          	auipc	ra,0xffffe
    80004a34:	a64080e7          	jalr	-1436(ra) # 80002494 <copyin>
    80004a38:	87aa                	mv	a5,a0
    80004a3a:	c399                	beqz	a5,80004a40 <fetchaddr+0x62>
    return -1;
    80004a3c:	57fd                	li	a5,-1
    80004a3e:	a011                	j	80004a42 <fetchaddr+0x64>
  return 0;
    80004a40:	4781                	li	a5,0
}
    80004a42:	853e                	mv	a0,a5
    80004a44:	70a2                	ld	ra,40(sp)
    80004a46:	7402                	ld	s0,32(sp)
    80004a48:	6145                	addi	sp,sp,48
    80004a4a:	8082                	ret

0000000080004a4c <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Returns length of string, not including nul, or -1 for error.
int
fetchstr(uint64 addr, char *buf, int max)
{
    80004a4c:	7139                	addi	sp,sp,-64
    80004a4e:	fc06                	sd	ra,56(sp)
    80004a50:	f822                	sd	s0,48(sp)
    80004a52:	0080                	addi	s0,sp,64
    80004a54:	fca43c23          	sd	a0,-40(s0)
    80004a58:	fcb43823          	sd	a1,-48(s0)
    80004a5c:	87b2                	mv	a5,a2
    80004a5e:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    80004a62:	ffffe097          	auipc	ra,0xffffe
    80004a66:	fb6080e7          	jalr	-74(ra) # 80002a18 <myproc>
    80004a6a:	fea43423          	sd	a0,-24(s0)
  int err = copyinstr(p->pagetable, buf, addr, max);
    80004a6e:	fe843783          	ld	a5,-24(s0)
    80004a72:	6bbc                	ld	a5,80(a5)
    80004a74:	fcc42703          	lw	a4,-52(s0)
    80004a78:	86ba                	mv	a3,a4
    80004a7a:	fd843603          	ld	a2,-40(s0)
    80004a7e:	fd043583          	ld	a1,-48(s0)
    80004a82:	853e                	mv	a0,a5
    80004a84:	ffffe097          	auipc	ra,0xffffe
    80004a88:	ade080e7          	jalr	-1314(ra) # 80002562 <copyinstr>
    80004a8c:	87aa                	mv	a5,a0
    80004a8e:	fef42223          	sw	a5,-28(s0)
  if(err < 0)
    80004a92:	fe442783          	lw	a5,-28(s0)
    80004a96:	2781                	sext.w	a5,a5
    80004a98:	0007d563          	bgez	a5,80004aa2 <fetchstr+0x56>
    return err;
    80004a9c:	fe442783          	lw	a5,-28(s0)
    80004aa0:	a801                	j	80004ab0 <fetchstr+0x64>
  return strlen(buf);
    80004aa2:	fd043503          	ld	a0,-48(s0)
    80004aa6:	ffffd097          	auipc	ra,0xffffd
    80004aaa:	d18080e7          	jalr	-744(ra) # 800017be <strlen>
    80004aae:	87aa                	mv	a5,a0
}
    80004ab0:	853e                	mv	a0,a5
    80004ab2:	70e2                	ld	ra,56(sp)
    80004ab4:	7442                	ld	s0,48(sp)
    80004ab6:	6121                	addi	sp,sp,64
    80004ab8:	8082                	ret

0000000080004aba <argraw>:

static uint64
argraw(int n)
{
    80004aba:	7179                	addi	sp,sp,-48
    80004abc:	f406                	sd	ra,40(sp)
    80004abe:	f022                	sd	s0,32(sp)
    80004ac0:	1800                	addi	s0,sp,48
    80004ac2:	87aa                	mv	a5,a0
    80004ac4:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80004ac8:	ffffe097          	auipc	ra,0xffffe
    80004acc:	f50080e7          	jalr	-176(ra) # 80002a18 <myproc>
    80004ad0:	fea43423          	sd	a0,-24(s0)
  switch (n) {
    80004ad4:	fdc42783          	lw	a5,-36(s0)
    80004ad8:	0007871b          	sext.w	a4,a5
    80004adc:	4795                	li	a5,5
    80004ade:	06e7e263          	bltu	a5,a4,80004b42 <argraw+0x88>
    80004ae2:	fdc46783          	lwu	a5,-36(s0)
    80004ae6:	00279713          	slli	a4,a5,0x2
    80004aea:	00007797          	auipc	a5,0x7
    80004aee:	a1678793          	addi	a5,a5,-1514 # 8000b500 <etext+0x500>
    80004af2:	97ba                	add	a5,a5,a4
    80004af4:	439c                	lw	a5,0(a5)
    80004af6:	0007871b          	sext.w	a4,a5
    80004afa:	00007797          	auipc	a5,0x7
    80004afe:	a0678793          	addi	a5,a5,-1530 # 8000b500 <etext+0x500>
    80004b02:	97ba                	add	a5,a5,a4
    80004b04:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80004b06:	fe843783          	ld	a5,-24(s0)
    80004b0a:	73bc                	ld	a5,96(a5)
    80004b0c:	7bbc                	ld	a5,112(a5)
    80004b0e:	a091                	j	80004b52 <argraw+0x98>
  case 1:
    return p->trapframe->a1;
    80004b10:	fe843783          	ld	a5,-24(s0)
    80004b14:	73bc                	ld	a5,96(a5)
    80004b16:	7fbc                	ld	a5,120(a5)
    80004b18:	a82d                	j	80004b52 <argraw+0x98>
  case 2:
    return p->trapframe->a2;
    80004b1a:	fe843783          	ld	a5,-24(s0)
    80004b1e:	73bc                	ld	a5,96(a5)
    80004b20:	63dc                	ld	a5,128(a5)
    80004b22:	a805                	j	80004b52 <argraw+0x98>
  case 3:
    return p->trapframe->a3;
    80004b24:	fe843783          	ld	a5,-24(s0)
    80004b28:	73bc                	ld	a5,96(a5)
    80004b2a:	67dc                	ld	a5,136(a5)
    80004b2c:	a01d                	j	80004b52 <argraw+0x98>
  case 4:
    return p->trapframe->a4;
    80004b2e:	fe843783          	ld	a5,-24(s0)
    80004b32:	73bc                	ld	a5,96(a5)
    80004b34:	6bdc                	ld	a5,144(a5)
    80004b36:	a831                	j	80004b52 <argraw+0x98>
  case 5:
    return p->trapframe->a5;
    80004b38:	fe843783          	ld	a5,-24(s0)
    80004b3c:	73bc                	ld	a5,96(a5)
    80004b3e:	6fdc                	ld	a5,152(a5)
    80004b40:	a809                	j	80004b52 <argraw+0x98>
  }
  panic("argraw");
    80004b42:	00007517          	auipc	a0,0x7
    80004b46:	9b650513          	addi	a0,a0,-1610 # 8000b4f8 <etext+0x4f8>
    80004b4a:	ffffc097          	auipc	ra,0xffffc
    80004b4e:	130080e7          	jalr	304(ra) # 80000c7a <panic>
  return -1;
}
    80004b52:	853e                	mv	a0,a5
    80004b54:	70a2                	ld	ra,40(sp)
    80004b56:	7402                	ld	s0,32(sp)
    80004b58:	6145                	addi	sp,sp,48
    80004b5a:	8082                	ret

0000000080004b5c <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80004b5c:	1101                	addi	sp,sp,-32
    80004b5e:	ec06                	sd	ra,24(sp)
    80004b60:	e822                	sd	s0,16(sp)
    80004b62:	1000                	addi	s0,sp,32
    80004b64:	87aa                	mv	a5,a0
    80004b66:	feb43023          	sd	a1,-32(s0)
    80004b6a:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    80004b6e:	fec42783          	lw	a5,-20(s0)
    80004b72:	853e                	mv	a0,a5
    80004b74:	00000097          	auipc	ra,0x0
    80004b78:	f46080e7          	jalr	-186(ra) # 80004aba <argraw>
    80004b7c:	87aa                	mv	a5,a0
    80004b7e:	0007871b          	sext.w	a4,a5
    80004b82:	fe043783          	ld	a5,-32(s0)
    80004b86:	c398                	sw	a4,0(a5)
  return 0;
    80004b88:	4781                	li	a5,0
}
    80004b8a:	853e                	mv	a0,a5
    80004b8c:	60e2                	ld	ra,24(sp)
    80004b8e:	6442                	ld	s0,16(sp)
    80004b90:	6105                	addi	sp,sp,32
    80004b92:	8082                	ret

0000000080004b94 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80004b94:	1101                	addi	sp,sp,-32
    80004b96:	ec06                	sd	ra,24(sp)
    80004b98:	e822                	sd	s0,16(sp)
    80004b9a:	1000                	addi	s0,sp,32
    80004b9c:	87aa                	mv	a5,a0
    80004b9e:	feb43023          	sd	a1,-32(s0)
    80004ba2:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    80004ba6:	fec42783          	lw	a5,-20(s0)
    80004baa:	853e                	mv	a0,a5
    80004bac:	00000097          	auipc	ra,0x0
    80004bb0:	f0e080e7          	jalr	-242(ra) # 80004aba <argraw>
    80004bb4:	872a                	mv	a4,a0
    80004bb6:	fe043783          	ld	a5,-32(s0)
    80004bba:	e398                	sd	a4,0(a5)
  return 0;
    80004bbc:	4781                	li	a5,0
}
    80004bbe:	853e                	mv	a0,a5
    80004bc0:	60e2                	ld	ra,24(sp)
    80004bc2:	6442                	ld	s0,16(sp)
    80004bc4:	6105                	addi	sp,sp,32
    80004bc6:	8082                	ret

0000000080004bc8 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80004bc8:	7179                	addi	sp,sp,-48
    80004bca:	f406                	sd	ra,40(sp)
    80004bcc:	f022                	sd	s0,32(sp)
    80004bce:	1800                	addi	s0,sp,48
    80004bd0:	87aa                	mv	a5,a0
    80004bd2:	fcb43823          	sd	a1,-48(s0)
    80004bd6:	8732                	mv	a4,a2
    80004bd8:	fcf42e23          	sw	a5,-36(s0)
    80004bdc:	87ba                	mv	a5,a4
    80004bde:	fcf42c23          	sw	a5,-40(s0)
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    80004be2:	fe840713          	addi	a4,s0,-24
    80004be6:	fdc42783          	lw	a5,-36(s0)
    80004bea:	85ba                	mv	a1,a4
    80004bec:	853e                	mv	a0,a5
    80004bee:	00000097          	auipc	ra,0x0
    80004bf2:	fa6080e7          	jalr	-90(ra) # 80004b94 <argaddr>
    80004bf6:	87aa                	mv	a5,a0
    80004bf8:	0007d463          	bgez	a5,80004c00 <argstr+0x38>
    return -1;
    80004bfc:	57fd                	li	a5,-1
    80004bfe:	a831                	j	80004c1a <argstr+0x52>
  return fetchstr(addr, buf, max);
    80004c00:	fe843783          	ld	a5,-24(s0)
    80004c04:	fd842703          	lw	a4,-40(s0)
    80004c08:	863a                	mv	a2,a4
    80004c0a:	fd043583          	ld	a1,-48(s0)
    80004c0e:	853e                	mv	a0,a5
    80004c10:	00000097          	auipc	ra,0x0
    80004c14:	e3c080e7          	jalr	-452(ra) # 80004a4c <fetchstr>
    80004c18:	87aa                	mv	a5,a0
}
    80004c1a:	853e                	mv	a0,a5
    80004c1c:	70a2                	ld	ra,40(sp)
    80004c1e:	7402                	ld	s0,32(sp)
    80004c20:	6145                	addi	sp,sp,48
    80004c22:	8082                	ret

0000000080004c24 <syscall>:
[SYS_join]    sys_join
};

void
syscall(void)
{
    80004c24:	7179                	addi	sp,sp,-48
    80004c26:	f406                	sd	ra,40(sp)
    80004c28:	f022                	sd	s0,32(sp)
    80004c2a:	ec26                	sd	s1,24(sp)
    80004c2c:	1800                	addi	s0,sp,48
  int num;
  struct proc *p = myproc();
    80004c2e:	ffffe097          	auipc	ra,0xffffe
    80004c32:	dea080e7          	jalr	-534(ra) # 80002a18 <myproc>
    80004c36:	fca43c23          	sd	a0,-40(s0)

  num = p->trapframe->a7;
    80004c3a:	fd843783          	ld	a5,-40(s0)
    80004c3e:	73bc                	ld	a5,96(a5)
    80004c40:	77dc                	ld	a5,168(a5)
    80004c42:	fcf42a23          	sw	a5,-44(s0)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80004c46:	fd442783          	lw	a5,-44(s0)
    80004c4a:	2781                	sext.w	a5,a5
    80004c4c:	04f05263          	blez	a5,80004c90 <syscall+0x6c>
    80004c50:	fd442783          	lw	a5,-44(s0)
    80004c54:	873e                	mv	a4,a5
    80004c56:	47dd                	li	a5,23
    80004c58:	02e7ec63          	bltu	a5,a4,80004c90 <syscall+0x6c>
    80004c5c:	00007717          	auipc	a4,0x7
    80004c60:	d0470713          	addi	a4,a4,-764 # 8000b960 <syscalls>
    80004c64:	fd442783          	lw	a5,-44(s0)
    80004c68:	078e                	slli	a5,a5,0x3
    80004c6a:	97ba                	add	a5,a5,a4
    80004c6c:	639c                	ld	a5,0(a5)
    80004c6e:	c38d                	beqz	a5,80004c90 <syscall+0x6c>
    p->trapframe->a0 = syscalls[num]();
    80004c70:	00007717          	auipc	a4,0x7
    80004c74:	cf070713          	addi	a4,a4,-784 # 8000b960 <syscalls>
    80004c78:	fd442783          	lw	a5,-44(s0)
    80004c7c:	078e                	slli	a5,a5,0x3
    80004c7e:	97ba                	add	a5,a5,a4
    80004c80:	6398                	ld	a4,0(a5)
    80004c82:	fd843783          	ld	a5,-40(s0)
    80004c86:	73a4                	ld	s1,96(a5)
    80004c88:	9702                	jalr	a4
    80004c8a:	87aa                	mv	a5,a0
    80004c8c:	f8bc                	sd	a5,112(s1)
    80004c8e:	a815                	j	80004cc2 <syscall+0x9e>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80004c90:	fd843783          	ld	a5,-40(s0)
    80004c94:	5b98                	lw	a4,48(a5)
            p->pid, p->name, num);
    80004c96:	fd843783          	ld	a5,-40(s0)
    80004c9a:	16878793          	addi	a5,a5,360
    printf("%d %s: unknown sys call %d\n",
    80004c9e:	fd442683          	lw	a3,-44(s0)
    80004ca2:	863e                	mv	a2,a5
    80004ca4:	85ba                	mv	a1,a4
    80004ca6:	00007517          	auipc	a0,0x7
    80004caa:	87250513          	addi	a0,a0,-1934 # 8000b518 <etext+0x518>
    80004cae:	ffffc097          	auipc	ra,0xffffc
    80004cb2:	d76080e7          	jalr	-650(ra) # 80000a24 <printf>
    p->trapframe->a0 = -1;
    80004cb6:	fd843783          	ld	a5,-40(s0)
    80004cba:	73bc                	ld	a5,96(a5)
    80004cbc:	577d                	li	a4,-1
    80004cbe:	fbb8                	sd	a4,112(a5)
  }
}
    80004cc0:	0001                	nop
    80004cc2:	0001                	nop
    80004cc4:	70a2                	ld	ra,40(sp)
    80004cc6:	7402                	ld	s0,32(sp)
    80004cc8:	64e2                	ld	s1,24(sp)
    80004cca:	6145                	addi	sp,sp,48
    80004ccc:	8082                	ret

0000000080004cce <sys_clone>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_clone (void)
{
    80004cce:	7139                	addi	sp,sp,-64
    80004cd0:	fc06                	sd	ra,56(sp)
    80004cd2:	f822                	sd	s0,48(sp)
    80004cd4:	0080                	addi	s0,sp,64
  uint64 stack;
  uint64 arg;
  uint64 fcn;

   //obtenemos puntero función
   if(argaddr(0, &fcn) < 0){
    80004cd6:	fc840793          	addi	a5,s0,-56
    80004cda:	85be                	mv	a1,a5
    80004cdc:	4501                	li	a0,0
    80004cde:	00000097          	auipc	ra,0x0
    80004ce2:	eb6080e7          	jalr	-330(ra) # 80004b94 <argaddr>
    80004ce6:	87aa                	mv	a5,a0
    80004ce8:	0007d463          	bgez	a5,80004cf0 <sys_clone+0x22>
     return -1;
    80004cec:	57fd                	li	a5,-1
    80004cee:	a071                	j	80004d7a <sys_clone+0xac>
   }

   //obtenemos puntero a argumento de función
   if(argaddr(1, &arg) < 0){
    80004cf0:	fd040793          	addi	a5,s0,-48
    80004cf4:	85be                	mv	a1,a5
    80004cf6:	4505                	li	a0,1
    80004cf8:	00000097          	auipc	ra,0x0
    80004cfc:	e9c080e7          	jalr	-356(ra) # 80004b94 <argaddr>
    80004d00:	87aa                	mv	a5,a0
    80004d02:	0007d463          	bgez	a5,80004d0a <sys_clone+0x3c>
     return -1;
    80004d06:	57fd                	li	a5,-1
    80004d08:	a88d                	j	80004d7a <sys_clone+0xac>
   }

   //obtenemos putnero a stack de usuario
   if(argaddr(2, &stack) < 0){
    80004d0a:	fd840793          	addi	a5,s0,-40
    80004d0e:	85be                	mv	a1,a5
    80004d10:	4509                	li	a0,2
    80004d12:	00000097          	auipc	ra,0x0
    80004d16:	e82080e7          	jalr	-382(ra) # 80004b94 <argaddr>
    80004d1a:	87aa                	mv	a5,a0
    80004d1c:	0007d463          	bgez	a5,80004d24 <sys_clone+0x56>
     return -1;
    80004d20:	57fd                	li	a5,-1
    80004d22:	a8a1                	j	80004d7a <sys_clone+0xac>
   }

  struct proc *p = myproc();
    80004d24:	ffffe097          	auipc	ra,0xffffe
    80004d28:	cf4080e7          	jalr	-780(ra) # 80002a18 <myproc>
    80004d2c:	fea43423          	sd	a0,-24(s0)
  uint64 sz = p->sz;
    80004d30:	fe843783          	ld	a5,-24(s0)
    80004d34:	67bc                	ld	a5,72(a5)
    80004d36:	fef43023          	sd	a5,-32(s0)

   //comprobamos que stack este alineado a pagina
   if ((stack % PGSIZE) != 0 || ((sz - stack) < PGSIZE)){
    80004d3a:	fd843703          	ld	a4,-40(s0)
    80004d3e:	6785                	lui	a5,0x1
    80004d40:	17fd                	addi	a5,a5,-1
    80004d42:	8ff9                	and	a5,a5,a4
    80004d44:	eb89                	bnez	a5,80004d56 <sys_clone+0x88>
    80004d46:	fd843783          	ld	a5,-40(s0)
    80004d4a:	fe043703          	ld	a4,-32(s0)
    80004d4e:	8f1d                	sub	a4,a4,a5
    80004d50:	6785                	lui	a5,0x1
    80004d52:	00f77463          	bgeu	a4,a5,80004d5a <sys_clone+0x8c>
     return -1;
    80004d56:	57fd                	li	a5,-1
    80004d58:	a00d                	j	80004d7a <sys_clone+0xac>
   }

  return clone((void *)fcn, (void *)arg, (void *)stack);
    80004d5a:	fc843783          	ld	a5,-56(s0)
    80004d5e:	873e                	mv	a4,a5
    80004d60:	fd043783          	ld	a5,-48(s0)
    80004d64:	86be                	mv	a3,a5
    80004d66:	fd843783          	ld	a5,-40(s0)
    80004d6a:	863e                	mv	a2,a5
    80004d6c:	85b6                	mv	a1,a3
    80004d6e:	853a                	mv	a0,a4
    80004d70:	fffff097          	auipc	ra,0xfffff
    80004d74:	f38080e7          	jalr	-200(ra) # 80003ca8 <clone>
    80004d78:	87aa                	mv	a5,a0
}
    80004d7a:	853e                	mv	a0,a5
    80004d7c:	70e2                	ld	ra,56(sp)
    80004d7e:	7442                	ld	s0,48(sp)
    80004d80:	6121                	addi	sp,sp,64
    80004d82:	8082                	ret

0000000080004d84 <sys_join>:

uint64
sys_join (void)
{
    80004d84:	1101                	addi	sp,sp,-32
    80004d86:	ec06                	sd	ra,24(sp)
    80004d88:	e822                	sd	s0,16(sp)
    80004d8a:	1000                	addi	s0,sp,32
  uint64 stack;
  if(argaddr(0, &stack) < 0){
    80004d8c:	fe840793          	addi	a5,s0,-24
    80004d90:	85be                	mv	a1,a5
    80004d92:	4501                	li	a0,0
    80004d94:	00000097          	auipc	ra,0x0
    80004d98:	e00080e7          	jalr	-512(ra) # 80004b94 <argaddr>
    80004d9c:	87aa                	mv	a5,a0
    80004d9e:	0007dc63          	bgez	a5,80004db6 <sys_join+0x32>
     printf ("SYSPROC: argumento no valido\n");
    80004da2:	00006517          	auipc	a0,0x6
    80004da6:	79650513          	addi	a0,a0,1942 # 8000b538 <etext+0x538>
    80004daa:	ffffc097          	auipc	ra,0xffffc
    80004dae:	c7a080e7          	jalr	-902(ra) # 80000a24 <printf>
     return -1;
    80004db2:	57fd                	li	a5,-1
    80004db4:	a091                	j	80004df8 <sys_join+0x74>
  }

  printf ("SYSPROC: lo que vale stack es: %d\n", stack);
    80004db6:	fe843783          	ld	a5,-24(s0)
    80004dba:	85be                	mv	a1,a5
    80004dbc:	00006517          	auipc	a0,0x6
    80004dc0:	79c50513          	addi	a0,a0,1948 # 8000b558 <etext+0x558>
    80004dc4:	ffffc097          	auipc	ra,0xffffc
    80004dc8:	c60080e7          	jalr	-928(ra) # 80000a24 <printf>

  if (stack % 4 != 0){
    80004dcc:	fe843783          	ld	a5,-24(s0)
    80004dd0:	8b8d                	andi	a5,a5,3
    80004dd2:	cb99                	beqz	a5,80004de8 <sys_join+0x64>
    printf ("SYSPROC: Dirección no alineada a word\n");
    80004dd4:	00006517          	auipc	a0,0x6
    80004dd8:	7ac50513          	addi	a0,a0,1964 # 8000b580 <etext+0x580>
    80004ddc:	ffffc097          	auipc	ra,0xffffc
    80004de0:	c48080e7          	jalr	-952(ra) # 80000a24 <printf>
    return -1;
    80004de4:	57fd                	li	a5,-1
    80004de6:	a809                	j	80004df8 <sys_join+0x74>
  }

  //hay que comprobar que en la dirección hay algo (aqui o en proc.c)

  return join (stack);
    80004de8:	fe843783          	ld	a5,-24(s0)
    80004dec:	853e                	mv	a0,a5
    80004dee:	fffff097          	auipc	ra,0xfffff
    80004df2:	19e080e7          	jalr	414(ra) # 80003f8c <join>
    80004df6:	87aa                	mv	a5,a0
}
    80004df8:	853e                	mv	a0,a5
    80004dfa:	60e2                	ld	ra,24(sp)
    80004dfc:	6442                	ld	s0,16(sp)
    80004dfe:	6105                	addi	sp,sp,32
    80004e00:	8082                	ret

0000000080004e02 <sys_exit>:


uint64
sys_exit(void)
{
    80004e02:	1101                	addi	sp,sp,-32
    80004e04:	ec06                	sd	ra,24(sp)
    80004e06:	e822                	sd	s0,16(sp)
    80004e08:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80004e0a:	fec40793          	addi	a5,s0,-20
    80004e0e:	85be                	mv	a1,a5
    80004e10:	4501                	li	a0,0
    80004e12:	00000097          	auipc	ra,0x0
    80004e16:	d4a080e7          	jalr	-694(ra) # 80004b5c <argint>
    80004e1a:	87aa                	mv	a5,a0
    80004e1c:	0007d463          	bgez	a5,80004e24 <sys_exit+0x22>
    return -1;
    80004e20:	57fd                	li	a5,-1
    80004e22:	a809                	j	80004e34 <sys_exit+0x32>
  exit(n);
    80004e24:	fec42783          	lw	a5,-20(s0)
    80004e28:	853e                	mv	a0,a5
    80004e2a:	ffffe097          	auipc	ra,0xffffe
    80004e2e:	5f8080e7          	jalr	1528(ra) # 80003422 <exit>
  return 0;  // not reached
    80004e32:	4781                	li	a5,0
}
    80004e34:	853e                	mv	a0,a5
    80004e36:	60e2                	ld	ra,24(sp)
    80004e38:	6442                	ld	s0,16(sp)
    80004e3a:	6105                	addi	sp,sp,32
    80004e3c:	8082                	ret

0000000080004e3e <sys_getpid>:

uint64
sys_getpid(void)
{
    80004e3e:	1141                	addi	sp,sp,-16
    80004e40:	e406                	sd	ra,8(sp)
    80004e42:	e022                	sd	s0,0(sp)
    80004e44:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80004e46:	ffffe097          	auipc	ra,0xffffe
    80004e4a:	bd2080e7          	jalr	-1070(ra) # 80002a18 <myproc>
    80004e4e:	87aa                	mv	a5,a0
    80004e50:	5b9c                	lw	a5,48(a5)
}
    80004e52:	853e                	mv	a0,a5
    80004e54:	60a2                	ld	ra,8(sp)
    80004e56:	6402                	ld	s0,0(sp)
    80004e58:	0141                	addi	sp,sp,16
    80004e5a:	8082                	ret

0000000080004e5c <sys_fork>:

uint64
sys_fork(void)
{
    80004e5c:	1141                	addi	sp,sp,-16
    80004e5e:	e406                	sd	ra,8(sp)
    80004e60:	e022                	sd	s0,0(sp)
    80004e62:	0800                	addi	s0,sp,16
  return fork();
    80004e64:	ffffe097          	auipc	ra,0xffffe
    80004e68:	398080e7          	jalr	920(ra) # 800031fc <fork>
    80004e6c:	87aa                	mv	a5,a0
}
    80004e6e:	853e                	mv	a0,a5
    80004e70:	60a2                	ld	ra,8(sp)
    80004e72:	6402                	ld	s0,0(sp)
    80004e74:	0141                	addi	sp,sp,16
    80004e76:	8082                	ret

0000000080004e78 <sys_wait>:

uint64
sys_wait(void)
{
    80004e78:	1101                	addi	sp,sp,-32
    80004e7a:	ec06                	sd	ra,24(sp)
    80004e7c:	e822                	sd	s0,16(sp)
    80004e7e:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80004e80:	fe840793          	addi	a5,s0,-24
    80004e84:	85be                	mv	a1,a5
    80004e86:	4501                	li	a0,0
    80004e88:	00000097          	auipc	ra,0x0
    80004e8c:	d0c080e7          	jalr	-756(ra) # 80004b94 <argaddr>
    80004e90:	87aa                	mv	a5,a0
    80004e92:	0007d463          	bgez	a5,80004e9a <sys_wait+0x22>
    return -1;
    80004e96:	57fd                	li	a5,-1
    80004e98:	a809                	j	80004eaa <sys_wait+0x32>
  return wait(p);
    80004e9a:	fe843783          	ld	a5,-24(s0)
    80004e9e:	853e                	mv	a0,a5
    80004ea0:	ffffe097          	auipc	ra,0xffffe
    80004ea4:	6be080e7          	jalr	1726(ra) # 8000355e <wait>
    80004ea8:	87aa                	mv	a5,a0
}
    80004eaa:	853e                	mv	a0,a5
    80004eac:	60e2                	ld	ra,24(sp)
    80004eae:	6442                	ld	s0,16(sp)
    80004eb0:	6105                	addi	sp,sp,32
    80004eb2:	8082                	ret

0000000080004eb4 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80004eb4:	7139                	addi	sp,sp,-64
    80004eb6:	fc06                	sd	ra,56(sp)
    80004eb8:	f822                	sd	s0,48(sp)
    80004eba:	0080                	addi	s0,sp,64
  int addr;
  int n;
  int referencias;

  if(argint(0, &n) < 0)
    80004ebc:	fcc40793          	addi	a5,s0,-52
    80004ec0:	85be                	mv	a1,a5
    80004ec2:	4501                	li	a0,0
    80004ec4:	00000097          	auipc	ra,0x0
    80004ec8:	c98080e7          	jalr	-872(ra) # 80004b5c <argint>
    80004ecc:	87aa                	mv	a5,a0
    80004ece:	0007d463          	bgez	a5,80004ed6 <sys_sbrk+0x22>
    return -1;
    80004ed2:	57fd                	li	a5,-1
    80004ed4:	a8dd                	j	80004fca <sys_sbrk+0x116>
  /*Cuando tenemos thrads, realizaremos la misma operación con sbrk.
  El proceso consiste en que desde el proceso padre, se alocata la pagina física
  y se mapea en el resto de threads hijos recursivos (solucionado por el ASID).
  */
  
  struct proc *p = myproc();
    80004ed6:	ffffe097          	auipc	ra,0xffffe
    80004eda:	b42080e7          	jalr	-1214(ra) # 80002a18 <myproc>
    80004ede:	fca43c23          	sd	a0,-40(s0)
  struct proc *proceso_padre_threads;
  //tenemos que determinar si somos el proceso padre o thread


  if (p->thread == 0){ //soy proceso
    80004ee2:	fd843703          	ld	a4,-40(s0)
    80004ee6:	67c9                	lui	a5,0x12
    80004ee8:	97ba                	add	a5,a5,a4
    80004eea:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    80004eee:	ef9d                	bnez	a5,80004f2c <sys_sbrk+0x78>
    
    addr = p->sz;
    80004ef0:	fd843783          	ld	a5,-40(s0)
    80004ef4:	67bc                	ld	a5,72(a5)
    80004ef6:	fef42623          	sw	a5,-20(s0)
    if(growproc(n) < 0){
    80004efa:	fcc42783          	lw	a5,-52(s0)
    80004efe:	853e                	mv	a0,a5
    80004f00:	ffffe097          	auipc	ra,0xffffe
    80004f04:	0a4080e7          	jalr	164(ra) # 80002fa4 <growproc>
    80004f08:	87aa                	mv	a5,a0
    80004f0a:	0007d463          	bgez	a5,80004f12 <sys_sbrk+0x5e>
      return -1;
    80004f0e:	57fd                	li	a5,-1
    80004f10:	a86d                	j	80004fca <sys_sbrk+0x116>
    }

    proceso_padre_threads = p;
    80004f12:	fd843783          	ld	a5,-40(s0)
    80004f16:	fef43023          	sd	a5,-32(s0)
    referencias = p->referencias;
    80004f1a:	fd843703          	ld	a4,-40(s0)
    80004f1e:	67c9                	lui	a5,0x12
    80004f20:	97ba                	add	a5,a5,a4
    80004f22:	18c7a783          	lw	a5,396(a5) # 1218c <_entry-0x7ffede74>
    80004f26:	fef42423          	sw	a5,-24(s0)
    80004f2a:	a891                	j	80004f7e <sys_sbrk+0xca>
  } else { //soy thread hijo

      //tengo que buscar al proceso padre o abuelo, bisabuelo... propietario del espacio de direcciones con ASID = pid

      struct proc *proceso;
       if ((proceso = busca_padre(p->ASID)) == 0);
    80004f2c:	fd843783          	ld	a5,-40(s0)
    80004f30:	5bdc                	lw	a5,52(a5)
    80004f32:	853e                	mv	a0,a5
    80004f34:	fffff097          	auipc	ra,0xfffff
    80004f38:	31a080e7          	jalr	794(ra) # 8000424e <busca_padre>
    80004f3c:	fca43823          	sd	a0,-48(s0)

      addr = proceso->sz;
    80004f40:	fd043783          	ld	a5,-48(s0)
    80004f44:	67bc                	ld	a5,72(a5)
    80004f46:	fef42623          	sw	a5,-20(s0)
      if(growproc_proceso_padre(n, proceso) < 0){
    80004f4a:	fcc42783          	lw	a5,-52(s0)
    80004f4e:	fd043583          	ld	a1,-48(s0)
    80004f52:	853e                	mv	a0,a5
    80004f54:	fffff097          	auipc	ra,0xfffff
    80004f58:	24c080e7          	jalr	588(ra) # 800041a0 <growproc_proceso_padre>
    80004f5c:	87aa                	mv	a5,a0
    80004f5e:	0007d463          	bgez	a5,80004f66 <sys_sbrk+0xb2>
        return -1;
    80004f62:	57fd                	li	a5,-1
    80004f64:	a09d                	j	80004fca <sys_sbrk+0x116>
      }

      proceso_padre_threads = proceso;
    80004f66:	fd043783          	ld	a5,-48(s0)
    80004f6a:	fef43023          	sd	a5,-32(s0)
      referencias = proceso->referencias;
    80004f6e:	fd043703          	ld	a4,-48(s0)
    80004f72:	67c9                	lui	a5,0x12
    80004f74:	97ba                	add	a5,a5,a4
    80004f76:	18c7a783          	lw	a5,396(a5) # 1218c <_entry-0x7ffede74>
    80004f7a:	fef42423          	sw	a5,-24(s0)
    páginas fisicas.

    De nuevo, si lo ejecuta un thread, debe pasar el puntero del padre proceso.
  */

  if ((n > 0 && referencias > 0) || p->thread == 1){ //O el proceso que ejecuta sbrk tiene más de una referencia o es un thread, alocatamos y mapeamos del padre a todos los procesos hijo
    80004f7e:	fcc42783          	lw	a5,-52(s0)
    80004f82:	00f05763          	blez	a5,80004f90 <sys_sbrk+0xdc>
    80004f86:	fe842783          	lw	a5,-24(s0)
    80004f8a:	2781                	sext.w	a5,a5
    80004f8c:	00f04c63          	bgtz	a5,80004fa4 <sys_sbrk+0xf0>
    80004f90:	fd843703          	ld	a4,-40(s0)
    80004f94:	67c9                	lui	a5,0x12
    80004f96:	97ba                	add	a5,a5,a4
    80004f98:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    80004f9c:	873e                	mv	a4,a5
    80004f9e:	4785                	li	a5,1
    80004fa0:	02f71363          	bne	a4,a5,80004fc6 <sys_sbrk+0x112>
    if ((check_grow_threads (proceso_padre_threads, n,addr))<0){
    80004fa4:	fcc42783          	lw	a5,-52(s0)
    80004fa8:	fec42703          	lw	a4,-20(s0)
    80004fac:	863a                	mv	a2,a4
    80004fae:	85be                	mv	a1,a5
    80004fb0:	fe043503          	ld	a0,-32(s0)
    80004fb4:	ffffe097          	auipc	ra,0xffffe
    80004fb8:	0a6080e7          	jalr	166(ra) # 8000305a <check_grow_threads>
    80004fbc:	87aa                	mv	a5,a0
    80004fbe:	0007d463          	bgez	a5,80004fc6 <sys_sbrk+0x112>
      return -1;
    80004fc2:	57fd                	li	a5,-1
    80004fc4:	a019                	j	80004fca <sys_sbrk+0x116>
    }

  }

  return addr;
    80004fc6:	fec42783          	lw	a5,-20(s0)
}
    80004fca:	853e                	mv	a0,a5
    80004fcc:	70e2                	ld	ra,56(sp)
    80004fce:	7442                	ld	s0,48(sp)
    80004fd0:	6121                	addi	sp,sp,64
    80004fd2:	8082                	ret

0000000080004fd4 <sys_sleep>:

uint64
sys_sleep(void)
{
    80004fd4:	1101                	addi	sp,sp,-32
    80004fd6:	ec06                	sd	ra,24(sp)
    80004fd8:	e822                	sd	s0,16(sp)
    80004fda:	1000                	addi	s0,sp,32
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80004fdc:	fe840793          	addi	a5,s0,-24
    80004fe0:	85be                	mv	a1,a5
    80004fe2:	4501                	li	a0,0
    80004fe4:	00000097          	auipc	ra,0x0
    80004fe8:	b78080e7          	jalr	-1160(ra) # 80004b5c <argint>
    80004fec:	87aa                	mv	a5,a0
    80004fee:	0007d463          	bgez	a5,80004ff6 <sys_sleep+0x22>
    return -1;
    80004ff2:	57fd                	li	a5,-1
    80004ff4:	a071                	j	80005080 <sys_sleep+0xac>
  acquire(&tickslock);
    80004ff6:	00496517          	auipc	a0,0x496
    80004ffa:	ad250513          	addi	a0,a0,-1326 # 8049aac8 <tickslock>
    80004ffe:	ffffc097          	auipc	ra,0xffffc
    80005002:	26c080e7          	jalr	620(ra) # 8000126a <acquire>
  ticks0 = ticks;
    80005006:	00007797          	auipc	a5,0x7
    8000500a:	02278793          	addi	a5,a5,34 # 8000c028 <ticks>
    8000500e:	439c                	lw	a5,0(a5)
    80005010:	fef42623          	sw	a5,-20(s0)
  while(ticks - ticks0 < n){
    80005014:	a835                	j	80005050 <sys_sleep+0x7c>
    if(myproc()->killed){
    80005016:	ffffe097          	auipc	ra,0xffffe
    8000501a:	a02080e7          	jalr	-1534(ra) # 80002a18 <myproc>
    8000501e:	87aa                	mv	a5,a0
    80005020:	579c                	lw	a5,40(a5)
    80005022:	cb99                	beqz	a5,80005038 <sys_sleep+0x64>
      release(&tickslock);
    80005024:	00496517          	auipc	a0,0x496
    80005028:	aa450513          	addi	a0,a0,-1372 # 8049aac8 <tickslock>
    8000502c:	ffffc097          	auipc	ra,0xffffc
    80005030:	2a2080e7          	jalr	674(ra) # 800012ce <release>
      return -1;
    80005034:	57fd                	li	a5,-1
    80005036:	a0a9                	j	80005080 <sys_sleep+0xac>
    }
    sleep(&ticks, &tickslock);
    80005038:	00496597          	auipc	a1,0x496
    8000503c:	a9058593          	addi	a1,a1,-1392 # 8049aac8 <tickslock>
    80005040:	00007517          	auipc	a0,0x7
    80005044:	fe850513          	addi	a0,a0,-24 # 8000c028 <ticks>
    80005048:	fffff097          	auipc	ra,0xfffff
    8000504c:	8da080e7          	jalr	-1830(ra) # 80003922 <sleep>
  while(ticks - ticks0 < n){
    80005050:	00007797          	auipc	a5,0x7
    80005054:	fd878793          	addi	a5,a5,-40 # 8000c028 <ticks>
    80005058:	439c                	lw	a5,0(a5)
    8000505a:	fec42703          	lw	a4,-20(s0)
    8000505e:	9f99                	subw	a5,a5,a4
    80005060:	0007871b          	sext.w	a4,a5
    80005064:	fe842783          	lw	a5,-24(s0)
    80005068:	2781                	sext.w	a5,a5
    8000506a:	faf766e3          	bltu	a4,a5,80005016 <sys_sleep+0x42>
  }
  release(&tickslock);
    8000506e:	00496517          	auipc	a0,0x496
    80005072:	a5a50513          	addi	a0,a0,-1446 # 8049aac8 <tickslock>
    80005076:	ffffc097          	auipc	ra,0xffffc
    8000507a:	258080e7          	jalr	600(ra) # 800012ce <release>
  return 0;
    8000507e:	4781                	li	a5,0
}
    80005080:	853e                	mv	a0,a5
    80005082:	60e2                	ld	ra,24(sp)
    80005084:	6442                	ld	s0,16(sp)
    80005086:	6105                	addi	sp,sp,32
    80005088:	8082                	ret

000000008000508a <sys_kill>:

uint64
sys_kill(void)
{
    8000508a:	1101                	addi	sp,sp,-32
    8000508c:	ec06                	sd	ra,24(sp)
    8000508e:	e822                	sd	s0,16(sp)
    80005090:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80005092:	fec40793          	addi	a5,s0,-20
    80005096:	85be                	mv	a1,a5
    80005098:	4501                	li	a0,0
    8000509a:	00000097          	auipc	ra,0x0
    8000509e:	ac2080e7          	jalr	-1342(ra) # 80004b5c <argint>
    800050a2:	87aa                	mv	a5,a0
    800050a4:	0007d463          	bgez	a5,800050ac <sys_kill+0x22>
    return -1;
    800050a8:	57fd                	li	a5,-1
    800050aa:	a809                	j	800050bc <sys_kill+0x32>
  return kill(pid);
    800050ac:	fec42783          	lw	a5,-20(s0)
    800050b0:	853e                	mv	a0,a5
    800050b2:	fffff097          	auipc	ra,0xfffff
    800050b6:	984080e7          	jalr	-1660(ra) # 80003a36 <kill>
    800050ba:	87aa                	mv	a5,a0
}
    800050bc:	853e                	mv	a0,a5
    800050be:	60e2                	ld	ra,24(sp)
    800050c0:	6442                	ld	s0,16(sp)
    800050c2:	6105                	addi	sp,sp,32
    800050c4:	8082                	ret

00000000800050c6 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800050c6:	1101                	addi	sp,sp,-32
    800050c8:	ec06                	sd	ra,24(sp)
    800050ca:	e822                	sd	s0,16(sp)
    800050cc:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800050ce:	00496517          	auipc	a0,0x496
    800050d2:	9fa50513          	addi	a0,a0,-1542 # 8049aac8 <tickslock>
    800050d6:	ffffc097          	auipc	ra,0xffffc
    800050da:	194080e7          	jalr	404(ra) # 8000126a <acquire>
  xticks = ticks;
    800050de:	00007797          	auipc	a5,0x7
    800050e2:	f4a78793          	addi	a5,a5,-182 # 8000c028 <ticks>
    800050e6:	439c                	lw	a5,0(a5)
    800050e8:	fef42623          	sw	a5,-20(s0)
  release(&tickslock);
    800050ec:	00496517          	auipc	a0,0x496
    800050f0:	9dc50513          	addi	a0,a0,-1572 # 8049aac8 <tickslock>
    800050f4:	ffffc097          	auipc	ra,0xffffc
    800050f8:	1da080e7          	jalr	474(ra) # 800012ce <release>
  return xticks;
    800050fc:	fec46783          	lwu	a5,-20(s0)
}
    80005100:	853e                	mv	a0,a5
    80005102:	60e2                	ld	ra,24(sp)
    80005104:	6442                	ld	s0,16(sp)
    80005106:	6105                	addi	sp,sp,32
    80005108:	8082                	ret

000000008000510a <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    8000510a:	1101                	addi	sp,sp,-32
    8000510c:	ec06                	sd	ra,24(sp)
    8000510e:	e822                	sd	s0,16(sp)
    80005110:	1000                	addi	s0,sp,32
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80005112:	00006597          	auipc	a1,0x6
    80005116:	49658593          	addi	a1,a1,1174 # 8000b5a8 <etext+0x5a8>
    8000511a:	00496517          	auipc	a0,0x496
    8000511e:	9c650513          	addi	a0,a0,-1594 # 8049aae0 <bcache>
    80005122:	ffffc097          	auipc	ra,0xffffc
    80005126:	118080e7          	jalr	280(ra) # 8000123a <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    8000512a:	00496717          	auipc	a4,0x496
    8000512e:	9b670713          	addi	a4,a4,-1610 # 8049aae0 <bcache>
    80005132:	67a1                	lui	a5,0x8
    80005134:	97ba                	add	a5,a5,a4
    80005136:	0049e717          	auipc	a4,0x49e
    8000513a:	c1270713          	addi	a4,a4,-1006 # 804a2d48 <bcache+0x8268>
    8000513e:	2ae7b823          	sd	a4,688(a5) # 82b0 <_entry-0x7fff7d50>
  bcache.head.next = &bcache.head;
    80005142:	00496717          	auipc	a4,0x496
    80005146:	99e70713          	addi	a4,a4,-1634 # 8049aae0 <bcache>
    8000514a:	67a1                	lui	a5,0x8
    8000514c:	97ba                	add	a5,a5,a4
    8000514e:	0049e717          	auipc	a4,0x49e
    80005152:	bfa70713          	addi	a4,a4,-1030 # 804a2d48 <bcache+0x8268>
    80005156:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000515a:	00496797          	auipc	a5,0x496
    8000515e:	99e78793          	addi	a5,a5,-1634 # 8049aaf8 <bcache+0x18>
    80005162:	fef43423          	sd	a5,-24(s0)
    80005166:	a895                	j	800051da <binit+0xd0>
    b->next = bcache.head.next;
    80005168:	00496717          	auipc	a4,0x496
    8000516c:	97870713          	addi	a4,a4,-1672 # 8049aae0 <bcache>
    80005170:	67a1                	lui	a5,0x8
    80005172:	97ba                	add	a5,a5,a4
    80005174:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    80005178:	fe843783          	ld	a5,-24(s0)
    8000517c:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    8000517e:	fe843783          	ld	a5,-24(s0)
    80005182:	0049e717          	auipc	a4,0x49e
    80005186:	bc670713          	addi	a4,a4,-1082 # 804a2d48 <bcache+0x8268>
    8000518a:	e7b8                	sd	a4,72(a5)
    initsleeplock(&b->lock, "buffer");
    8000518c:	fe843783          	ld	a5,-24(s0)
    80005190:	07c1                	addi	a5,a5,16
    80005192:	00006597          	auipc	a1,0x6
    80005196:	41e58593          	addi	a1,a1,1054 # 8000b5b0 <etext+0x5b0>
    8000519a:	853e                	mv	a0,a5
    8000519c:	00002097          	auipc	ra,0x2
    800051a0:	fee080e7          	jalr	-18(ra) # 8000718a <initsleeplock>
    bcache.head.next->prev = b;
    800051a4:	00496717          	auipc	a4,0x496
    800051a8:	93c70713          	addi	a4,a4,-1732 # 8049aae0 <bcache>
    800051ac:	67a1                	lui	a5,0x8
    800051ae:	97ba                	add	a5,a5,a4
    800051b0:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    800051b4:	fe843703          	ld	a4,-24(s0)
    800051b8:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    800051ba:	00496717          	auipc	a4,0x496
    800051be:	92670713          	addi	a4,a4,-1754 # 8049aae0 <bcache>
    800051c2:	67a1                	lui	a5,0x8
    800051c4:	97ba                	add	a5,a5,a4
    800051c6:	fe843703          	ld	a4,-24(s0)
    800051ca:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800051ce:	fe843783          	ld	a5,-24(s0)
    800051d2:	45878793          	addi	a5,a5,1112
    800051d6:	fef43423          	sd	a5,-24(s0)
    800051da:	0049e797          	auipc	a5,0x49e
    800051de:	b6e78793          	addi	a5,a5,-1170 # 804a2d48 <bcache+0x8268>
    800051e2:	fe843703          	ld	a4,-24(s0)
    800051e6:	f8f761e3          	bltu	a4,a5,80005168 <binit+0x5e>
  }
}
    800051ea:	0001                	nop
    800051ec:	0001                	nop
    800051ee:	60e2                	ld	ra,24(sp)
    800051f0:	6442                	ld	s0,16(sp)
    800051f2:	6105                	addi	sp,sp,32
    800051f4:	8082                	ret

00000000800051f6 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    800051f6:	7179                	addi	sp,sp,-48
    800051f8:	f406                	sd	ra,40(sp)
    800051fa:	f022                	sd	s0,32(sp)
    800051fc:	1800                	addi	s0,sp,48
    800051fe:	87aa                	mv	a5,a0
    80005200:	872e                	mv	a4,a1
    80005202:	fcf42e23          	sw	a5,-36(s0)
    80005206:	87ba                	mv	a5,a4
    80005208:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  acquire(&bcache.lock);
    8000520c:	00496517          	auipc	a0,0x496
    80005210:	8d450513          	addi	a0,a0,-1836 # 8049aae0 <bcache>
    80005214:	ffffc097          	auipc	ra,0xffffc
    80005218:	056080e7          	jalr	86(ra) # 8000126a <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    8000521c:	00496717          	auipc	a4,0x496
    80005220:	8c470713          	addi	a4,a4,-1852 # 8049aae0 <bcache>
    80005224:	67a1                	lui	a5,0x8
    80005226:	97ba                	add	a5,a5,a4
    80005228:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    8000522c:	fef43423          	sd	a5,-24(s0)
    80005230:	a095                	j	80005294 <bget+0x9e>
    if(b->dev == dev && b->blockno == blockno){
    80005232:	fe843783          	ld	a5,-24(s0)
    80005236:	4798                	lw	a4,8(a5)
    80005238:	fdc42783          	lw	a5,-36(s0)
    8000523c:	2781                	sext.w	a5,a5
    8000523e:	04e79663          	bne	a5,a4,8000528a <bget+0x94>
    80005242:	fe843783          	ld	a5,-24(s0)
    80005246:	47d8                	lw	a4,12(a5)
    80005248:	fd842783          	lw	a5,-40(s0)
    8000524c:	2781                	sext.w	a5,a5
    8000524e:	02e79e63          	bne	a5,a4,8000528a <bget+0x94>
      b->refcnt++;
    80005252:	fe843783          	ld	a5,-24(s0)
    80005256:	43bc                	lw	a5,64(a5)
    80005258:	2785                	addiw	a5,a5,1
    8000525a:	0007871b          	sext.w	a4,a5
    8000525e:	fe843783          	ld	a5,-24(s0)
    80005262:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    80005264:	00496517          	auipc	a0,0x496
    80005268:	87c50513          	addi	a0,a0,-1924 # 8049aae0 <bcache>
    8000526c:	ffffc097          	auipc	ra,0xffffc
    80005270:	062080e7          	jalr	98(ra) # 800012ce <release>
      acquiresleep(&b->lock);
    80005274:	fe843783          	ld	a5,-24(s0)
    80005278:	07c1                	addi	a5,a5,16
    8000527a:	853e                	mv	a0,a5
    8000527c:	00002097          	auipc	ra,0x2
    80005280:	f5a080e7          	jalr	-166(ra) # 800071d6 <acquiresleep>
      return b;
    80005284:	fe843783          	ld	a5,-24(s0)
    80005288:	a07d                	j	80005336 <bget+0x140>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    8000528a:	fe843783          	ld	a5,-24(s0)
    8000528e:	6bbc                	ld	a5,80(a5)
    80005290:	fef43423          	sd	a5,-24(s0)
    80005294:	fe843703          	ld	a4,-24(s0)
    80005298:	0049e797          	auipc	a5,0x49e
    8000529c:	ab078793          	addi	a5,a5,-1360 # 804a2d48 <bcache+0x8268>
    800052a0:	f8f719e3          	bne	a4,a5,80005232 <bget+0x3c>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800052a4:	00496717          	auipc	a4,0x496
    800052a8:	83c70713          	addi	a4,a4,-1988 # 8049aae0 <bcache>
    800052ac:	67a1                	lui	a5,0x8
    800052ae:	97ba                	add	a5,a5,a4
    800052b0:	2b07b783          	ld	a5,688(a5) # 82b0 <_entry-0x7fff7d50>
    800052b4:	fef43423          	sd	a5,-24(s0)
    800052b8:	a8b9                	j	80005316 <bget+0x120>
    if(b->refcnt == 0) {
    800052ba:	fe843783          	ld	a5,-24(s0)
    800052be:	43bc                	lw	a5,64(a5)
    800052c0:	e7b1                	bnez	a5,8000530c <bget+0x116>
      b->dev = dev;
    800052c2:	fe843783          	ld	a5,-24(s0)
    800052c6:	fdc42703          	lw	a4,-36(s0)
    800052ca:	c798                	sw	a4,8(a5)
      b->blockno = blockno;
    800052cc:	fe843783          	ld	a5,-24(s0)
    800052d0:	fd842703          	lw	a4,-40(s0)
    800052d4:	c7d8                	sw	a4,12(a5)
      b->valid = 0;
    800052d6:	fe843783          	ld	a5,-24(s0)
    800052da:	0007a023          	sw	zero,0(a5)
      b->refcnt = 1;
    800052de:	fe843783          	ld	a5,-24(s0)
    800052e2:	4705                	li	a4,1
    800052e4:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    800052e6:	00495517          	auipc	a0,0x495
    800052ea:	7fa50513          	addi	a0,a0,2042 # 8049aae0 <bcache>
    800052ee:	ffffc097          	auipc	ra,0xffffc
    800052f2:	fe0080e7          	jalr	-32(ra) # 800012ce <release>
      acquiresleep(&b->lock);
    800052f6:	fe843783          	ld	a5,-24(s0)
    800052fa:	07c1                	addi	a5,a5,16
    800052fc:	853e                	mv	a0,a5
    800052fe:	00002097          	auipc	ra,0x2
    80005302:	ed8080e7          	jalr	-296(ra) # 800071d6 <acquiresleep>
      return b;
    80005306:	fe843783          	ld	a5,-24(s0)
    8000530a:	a035                	j	80005336 <bget+0x140>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8000530c:	fe843783          	ld	a5,-24(s0)
    80005310:	67bc                	ld	a5,72(a5)
    80005312:	fef43423          	sd	a5,-24(s0)
    80005316:	fe843703          	ld	a4,-24(s0)
    8000531a:	0049e797          	auipc	a5,0x49e
    8000531e:	a2e78793          	addi	a5,a5,-1490 # 804a2d48 <bcache+0x8268>
    80005322:	f8f71ce3          	bne	a4,a5,800052ba <bget+0xc4>
    }
  }
  panic("bget: no buffers");
    80005326:	00006517          	auipc	a0,0x6
    8000532a:	29250513          	addi	a0,a0,658 # 8000b5b8 <etext+0x5b8>
    8000532e:	ffffc097          	auipc	ra,0xffffc
    80005332:	94c080e7          	jalr	-1716(ra) # 80000c7a <panic>
}
    80005336:	853e                	mv	a0,a5
    80005338:	70a2                	ld	ra,40(sp)
    8000533a:	7402                	ld	s0,32(sp)
    8000533c:	6145                	addi	sp,sp,48
    8000533e:	8082                	ret

0000000080005340 <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80005340:	7179                	addi	sp,sp,-48
    80005342:	f406                	sd	ra,40(sp)
    80005344:	f022                	sd	s0,32(sp)
    80005346:	1800                	addi	s0,sp,48
    80005348:	87aa                	mv	a5,a0
    8000534a:	872e                	mv	a4,a1
    8000534c:	fcf42e23          	sw	a5,-36(s0)
    80005350:	87ba                	mv	a5,a4
    80005352:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  b = bget(dev, blockno);
    80005356:	fd842703          	lw	a4,-40(s0)
    8000535a:	fdc42783          	lw	a5,-36(s0)
    8000535e:	85ba                	mv	a1,a4
    80005360:	853e                	mv	a0,a5
    80005362:	00000097          	auipc	ra,0x0
    80005366:	e94080e7          	jalr	-364(ra) # 800051f6 <bget>
    8000536a:	fea43423          	sd	a0,-24(s0)
  if(!b->valid) {
    8000536e:	fe843783          	ld	a5,-24(s0)
    80005372:	439c                	lw	a5,0(a5)
    80005374:	ef81                	bnez	a5,8000538c <bread+0x4c>
    virtio_disk_rw(b, 0);
    80005376:	4581                	li	a1,0
    80005378:	fe843503          	ld	a0,-24(s0)
    8000537c:	00004097          	auipc	ra,0x4
    80005380:	740080e7          	jalr	1856(ra) # 80009abc <virtio_disk_rw>
    b->valid = 1;
    80005384:	fe843783          	ld	a5,-24(s0)
    80005388:	4705                	li	a4,1
    8000538a:	c398                	sw	a4,0(a5)
  }
  return b;
    8000538c:	fe843783          	ld	a5,-24(s0)
}
    80005390:	853e                	mv	a0,a5
    80005392:	70a2                	ld	ra,40(sp)
    80005394:	7402                	ld	s0,32(sp)
    80005396:	6145                	addi	sp,sp,48
    80005398:	8082                	ret

000000008000539a <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    8000539a:	1101                	addi	sp,sp,-32
    8000539c:	ec06                	sd	ra,24(sp)
    8000539e:	e822                	sd	s0,16(sp)
    800053a0:	1000                	addi	s0,sp,32
    800053a2:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    800053a6:	fe843783          	ld	a5,-24(s0)
    800053aa:	07c1                	addi	a5,a5,16
    800053ac:	853e                	mv	a0,a5
    800053ae:	00002097          	auipc	ra,0x2
    800053b2:	ee8080e7          	jalr	-280(ra) # 80007296 <holdingsleep>
    800053b6:	87aa                	mv	a5,a0
    800053b8:	eb89                	bnez	a5,800053ca <bwrite+0x30>
    panic("bwrite");
    800053ba:	00006517          	auipc	a0,0x6
    800053be:	21650513          	addi	a0,a0,534 # 8000b5d0 <etext+0x5d0>
    800053c2:	ffffc097          	auipc	ra,0xffffc
    800053c6:	8b8080e7          	jalr	-1864(ra) # 80000c7a <panic>
  virtio_disk_rw(b, 1);
    800053ca:	4585                	li	a1,1
    800053cc:	fe843503          	ld	a0,-24(s0)
    800053d0:	00004097          	auipc	ra,0x4
    800053d4:	6ec080e7          	jalr	1772(ra) # 80009abc <virtio_disk_rw>
}
    800053d8:	0001                	nop
    800053da:	60e2                	ld	ra,24(sp)
    800053dc:	6442                	ld	s0,16(sp)
    800053de:	6105                	addi	sp,sp,32
    800053e0:	8082                	ret

00000000800053e2 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800053e2:	1101                	addi	sp,sp,-32
    800053e4:	ec06                	sd	ra,24(sp)
    800053e6:	e822                	sd	s0,16(sp)
    800053e8:	1000                	addi	s0,sp,32
    800053ea:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    800053ee:	fe843783          	ld	a5,-24(s0)
    800053f2:	07c1                	addi	a5,a5,16
    800053f4:	853e                	mv	a0,a5
    800053f6:	00002097          	auipc	ra,0x2
    800053fa:	ea0080e7          	jalr	-352(ra) # 80007296 <holdingsleep>
    800053fe:	87aa                	mv	a5,a0
    80005400:	eb89                	bnez	a5,80005412 <brelse+0x30>
    panic("brelse");
    80005402:	00006517          	auipc	a0,0x6
    80005406:	1d650513          	addi	a0,a0,470 # 8000b5d8 <etext+0x5d8>
    8000540a:	ffffc097          	auipc	ra,0xffffc
    8000540e:	870080e7          	jalr	-1936(ra) # 80000c7a <panic>

  releasesleep(&b->lock);
    80005412:	fe843783          	ld	a5,-24(s0)
    80005416:	07c1                	addi	a5,a5,16
    80005418:	853e                	mv	a0,a5
    8000541a:	00002097          	auipc	ra,0x2
    8000541e:	e2a080e7          	jalr	-470(ra) # 80007244 <releasesleep>

  acquire(&bcache.lock);
    80005422:	00495517          	auipc	a0,0x495
    80005426:	6be50513          	addi	a0,a0,1726 # 8049aae0 <bcache>
    8000542a:	ffffc097          	auipc	ra,0xffffc
    8000542e:	e40080e7          	jalr	-448(ra) # 8000126a <acquire>
  b->refcnt--;
    80005432:	fe843783          	ld	a5,-24(s0)
    80005436:	43bc                	lw	a5,64(a5)
    80005438:	37fd                	addiw	a5,a5,-1
    8000543a:	0007871b          	sext.w	a4,a5
    8000543e:	fe843783          	ld	a5,-24(s0)
    80005442:	c3b8                	sw	a4,64(a5)
  if (b->refcnt == 0) {
    80005444:	fe843783          	ld	a5,-24(s0)
    80005448:	43bc                	lw	a5,64(a5)
    8000544a:	e7b5                	bnez	a5,800054b6 <brelse+0xd4>
    // no one is waiting for it.
    b->next->prev = b->prev;
    8000544c:	fe843783          	ld	a5,-24(s0)
    80005450:	6bbc                	ld	a5,80(a5)
    80005452:	fe843703          	ld	a4,-24(s0)
    80005456:	6738                	ld	a4,72(a4)
    80005458:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    8000545a:	fe843783          	ld	a5,-24(s0)
    8000545e:	67bc                	ld	a5,72(a5)
    80005460:	fe843703          	ld	a4,-24(s0)
    80005464:	6b38                	ld	a4,80(a4)
    80005466:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80005468:	00495717          	auipc	a4,0x495
    8000546c:	67870713          	addi	a4,a4,1656 # 8049aae0 <bcache>
    80005470:	67a1                	lui	a5,0x8
    80005472:	97ba                	add	a5,a5,a4
    80005474:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    80005478:	fe843783          	ld	a5,-24(s0)
    8000547c:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    8000547e:	fe843783          	ld	a5,-24(s0)
    80005482:	0049e717          	auipc	a4,0x49e
    80005486:	8c670713          	addi	a4,a4,-1850 # 804a2d48 <bcache+0x8268>
    8000548a:	e7b8                	sd	a4,72(a5)
    bcache.head.next->prev = b;
    8000548c:	00495717          	auipc	a4,0x495
    80005490:	65470713          	addi	a4,a4,1620 # 8049aae0 <bcache>
    80005494:	67a1                	lui	a5,0x8
    80005496:	97ba                	add	a5,a5,a4
    80005498:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    8000549c:	fe843703          	ld	a4,-24(s0)
    800054a0:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    800054a2:	00495717          	auipc	a4,0x495
    800054a6:	63e70713          	addi	a4,a4,1598 # 8049aae0 <bcache>
    800054aa:	67a1                	lui	a5,0x8
    800054ac:	97ba                	add	a5,a5,a4
    800054ae:	fe843703          	ld	a4,-24(s0)
    800054b2:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  }
  
  release(&bcache.lock);
    800054b6:	00495517          	auipc	a0,0x495
    800054ba:	62a50513          	addi	a0,a0,1578 # 8049aae0 <bcache>
    800054be:	ffffc097          	auipc	ra,0xffffc
    800054c2:	e10080e7          	jalr	-496(ra) # 800012ce <release>
}
    800054c6:	0001                	nop
    800054c8:	60e2                	ld	ra,24(sp)
    800054ca:	6442                	ld	s0,16(sp)
    800054cc:	6105                	addi	sp,sp,32
    800054ce:	8082                	ret

00000000800054d0 <bpin>:

void
bpin(struct buf *b) {
    800054d0:	1101                	addi	sp,sp,-32
    800054d2:	ec06                	sd	ra,24(sp)
    800054d4:	e822                	sd	s0,16(sp)
    800054d6:	1000                	addi	s0,sp,32
    800054d8:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    800054dc:	00495517          	auipc	a0,0x495
    800054e0:	60450513          	addi	a0,a0,1540 # 8049aae0 <bcache>
    800054e4:	ffffc097          	auipc	ra,0xffffc
    800054e8:	d86080e7          	jalr	-634(ra) # 8000126a <acquire>
  b->refcnt++;
    800054ec:	fe843783          	ld	a5,-24(s0)
    800054f0:	43bc                	lw	a5,64(a5)
    800054f2:	2785                	addiw	a5,a5,1
    800054f4:	0007871b          	sext.w	a4,a5
    800054f8:	fe843783          	ld	a5,-24(s0)
    800054fc:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    800054fe:	00495517          	auipc	a0,0x495
    80005502:	5e250513          	addi	a0,a0,1506 # 8049aae0 <bcache>
    80005506:	ffffc097          	auipc	ra,0xffffc
    8000550a:	dc8080e7          	jalr	-568(ra) # 800012ce <release>
}
    8000550e:	0001                	nop
    80005510:	60e2                	ld	ra,24(sp)
    80005512:	6442                	ld	s0,16(sp)
    80005514:	6105                	addi	sp,sp,32
    80005516:	8082                	ret

0000000080005518 <bunpin>:

void
bunpin(struct buf *b) {
    80005518:	1101                	addi	sp,sp,-32
    8000551a:	ec06                	sd	ra,24(sp)
    8000551c:	e822                	sd	s0,16(sp)
    8000551e:	1000                	addi	s0,sp,32
    80005520:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80005524:	00495517          	auipc	a0,0x495
    80005528:	5bc50513          	addi	a0,a0,1468 # 8049aae0 <bcache>
    8000552c:	ffffc097          	auipc	ra,0xffffc
    80005530:	d3e080e7          	jalr	-706(ra) # 8000126a <acquire>
  b->refcnt--;
    80005534:	fe843783          	ld	a5,-24(s0)
    80005538:	43bc                	lw	a5,64(a5)
    8000553a:	37fd                	addiw	a5,a5,-1
    8000553c:	0007871b          	sext.w	a4,a5
    80005540:	fe843783          	ld	a5,-24(s0)
    80005544:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80005546:	00495517          	auipc	a0,0x495
    8000554a:	59a50513          	addi	a0,a0,1434 # 8049aae0 <bcache>
    8000554e:	ffffc097          	auipc	ra,0xffffc
    80005552:	d80080e7          	jalr	-640(ra) # 800012ce <release>
}
    80005556:	0001                	nop
    80005558:	60e2                	ld	ra,24(sp)
    8000555a:	6442                	ld	s0,16(sp)
    8000555c:	6105                	addi	sp,sp,32
    8000555e:	8082                	ret

0000000080005560 <readsb>:
struct superblock sb; 

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
    80005560:	7179                	addi	sp,sp,-48
    80005562:	f406                	sd	ra,40(sp)
    80005564:	f022                	sd	s0,32(sp)
    80005566:	1800                	addi	s0,sp,48
    80005568:	87aa                	mv	a5,a0
    8000556a:	fcb43823          	sd	a1,-48(s0)
    8000556e:	fcf42e23          	sw	a5,-36(s0)
  struct buf *bp;

  bp = bread(dev, 1);
    80005572:	fdc42783          	lw	a5,-36(s0)
    80005576:	4585                	li	a1,1
    80005578:	853e                	mv	a0,a5
    8000557a:	00000097          	auipc	ra,0x0
    8000557e:	dc6080e7          	jalr	-570(ra) # 80005340 <bread>
    80005582:	fea43423          	sd	a0,-24(s0)
  memmove(sb, bp->data, sizeof(*sb));
    80005586:	fe843783          	ld	a5,-24(s0)
    8000558a:	05878793          	addi	a5,a5,88
    8000558e:	02000613          	li	a2,32
    80005592:	85be                	mv	a1,a5
    80005594:	fd043503          	ld	a0,-48(s0)
    80005598:	ffffc097          	auipc	ra,0xffffc
    8000559c:	f8a080e7          	jalr	-118(ra) # 80001522 <memmove>
  brelse(bp);
    800055a0:	fe843503          	ld	a0,-24(s0)
    800055a4:	00000097          	auipc	ra,0x0
    800055a8:	e3e080e7          	jalr	-450(ra) # 800053e2 <brelse>
}
    800055ac:	0001                	nop
    800055ae:	70a2                	ld	ra,40(sp)
    800055b0:	7402                	ld	s0,32(sp)
    800055b2:	6145                	addi	sp,sp,48
    800055b4:	8082                	ret

00000000800055b6 <fsinit>:

// Init fs
void
fsinit(int dev) {
    800055b6:	1101                	addi	sp,sp,-32
    800055b8:	ec06                	sd	ra,24(sp)
    800055ba:	e822                	sd	s0,16(sp)
    800055bc:	1000                	addi	s0,sp,32
    800055be:	87aa                	mv	a5,a0
    800055c0:	fef42623          	sw	a5,-20(s0)
  readsb(dev, &sb);
    800055c4:	fec42783          	lw	a5,-20(s0)
    800055c8:	0049e597          	auipc	a1,0x49e
    800055cc:	bd858593          	addi	a1,a1,-1064 # 804a31a0 <sb>
    800055d0:	853e                	mv	a0,a5
    800055d2:	00000097          	auipc	ra,0x0
    800055d6:	f8e080e7          	jalr	-114(ra) # 80005560 <readsb>
  if(sb.magic != FSMAGIC)
    800055da:	0049e797          	auipc	a5,0x49e
    800055de:	bc678793          	addi	a5,a5,-1082 # 804a31a0 <sb>
    800055e2:	439c                	lw	a5,0(a5)
    800055e4:	873e                	mv	a4,a5
    800055e6:	102037b7          	lui	a5,0x10203
    800055ea:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    800055ee:	00f70a63          	beq	a4,a5,80005602 <fsinit+0x4c>
    panic("invalid file system");
    800055f2:	00006517          	auipc	a0,0x6
    800055f6:	fee50513          	addi	a0,a0,-18 # 8000b5e0 <etext+0x5e0>
    800055fa:	ffffb097          	auipc	ra,0xffffb
    800055fe:	680080e7          	jalr	1664(ra) # 80000c7a <panic>
  initlog(dev, &sb);
    80005602:	fec42783          	lw	a5,-20(s0)
    80005606:	0049e597          	auipc	a1,0x49e
    8000560a:	b9a58593          	addi	a1,a1,-1126 # 804a31a0 <sb>
    8000560e:	853e                	mv	a0,a5
    80005610:	00001097          	auipc	ra,0x1
    80005614:	45e080e7          	jalr	1118(ra) # 80006a6e <initlog>
}
    80005618:	0001                	nop
    8000561a:	60e2                	ld	ra,24(sp)
    8000561c:	6442                	ld	s0,16(sp)
    8000561e:	6105                	addi	sp,sp,32
    80005620:	8082                	ret

0000000080005622 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
    80005622:	7179                	addi	sp,sp,-48
    80005624:	f406                	sd	ra,40(sp)
    80005626:	f022                	sd	s0,32(sp)
    80005628:	1800                	addi	s0,sp,48
    8000562a:	87aa                	mv	a5,a0
    8000562c:	872e                	mv	a4,a1
    8000562e:	fcf42e23          	sw	a5,-36(s0)
    80005632:	87ba                	mv	a5,a4
    80005634:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;

  bp = bread(dev, bno);
    80005638:	fdc42783          	lw	a5,-36(s0)
    8000563c:	fd842703          	lw	a4,-40(s0)
    80005640:	85ba                	mv	a1,a4
    80005642:	853e                	mv	a0,a5
    80005644:	00000097          	auipc	ra,0x0
    80005648:	cfc080e7          	jalr	-772(ra) # 80005340 <bread>
    8000564c:	fea43423          	sd	a0,-24(s0)
  memset(bp->data, 0, BSIZE);
    80005650:	fe843783          	ld	a5,-24(s0)
    80005654:	05878793          	addi	a5,a5,88
    80005658:	40000613          	li	a2,1024
    8000565c:	4581                	li	a1,0
    8000565e:	853e                	mv	a0,a5
    80005660:	ffffc097          	auipc	ra,0xffffc
    80005664:	dde080e7          	jalr	-546(ra) # 8000143e <memset>
  log_write(bp);
    80005668:	fe843503          	ld	a0,-24(s0)
    8000566c:	00002097          	auipc	ra,0x2
    80005670:	9ea080e7          	jalr	-1558(ra) # 80007056 <log_write>
  brelse(bp);
    80005674:	fe843503          	ld	a0,-24(s0)
    80005678:	00000097          	auipc	ra,0x0
    8000567c:	d6a080e7          	jalr	-662(ra) # 800053e2 <brelse>
}
    80005680:	0001                	nop
    80005682:	70a2                	ld	ra,40(sp)
    80005684:	7402                	ld	s0,32(sp)
    80005686:	6145                	addi	sp,sp,48
    80005688:	8082                	ret

000000008000568a <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
    8000568a:	7139                	addi	sp,sp,-64
    8000568c:	fc06                	sd	ra,56(sp)
    8000568e:	f822                	sd	s0,48(sp)
    80005690:	0080                	addi	s0,sp,64
    80005692:	87aa                	mv	a5,a0
    80005694:	fcf42623          	sw	a5,-52(s0)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
    80005698:	fe043023          	sd	zero,-32(s0)
  for(b = 0; b < sb.size; b += BPB){
    8000569c:	fe042623          	sw	zero,-20(s0)
    800056a0:	a295                	j	80005804 <balloc+0x17a>
    bp = bread(dev, BBLOCK(b, sb));
    800056a2:	fec42783          	lw	a5,-20(s0)
    800056a6:	41f7d71b          	sraiw	a4,a5,0x1f
    800056aa:	0137571b          	srliw	a4,a4,0x13
    800056ae:	9fb9                	addw	a5,a5,a4
    800056b0:	40d7d79b          	sraiw	a5,a5,0xd
    800056b4:	2781                	sext.w	a5,a5
    800056b6:	0007871b          	sext.w	a4,a5
    800056ba:	0049e797          	auipc	a5,0x49e
    800056be:	ae678793          	addi	a5,a5,-1306 # 804a31a0 <sb>
    800056c2:	4fdc                	lw	a5,28(a5)
    800056c4:	9fb9                	addw	a5,a5,a4
    800056c6:	0007871b          	sext.w	a4,a5
    800056ca:	fcc42783          	lw	a5,-52(s0)
    800056ce:	85ba                	mv	a1,a4
    800056d0:	853e                	mv	a0,a5
    800056d2:	00000097          	auipc	ra,0x0
    800056d6:	c6e080e7          	jalr	-914(ra) # 80005340 <bread>
    800056da:	fea43023          	sd	a0,-32(s0)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800056de:	fe042423          	sw	zero,-24(s0)
    800056e2:	a8e9                	j	800057bc <balloc+0x132>
      m = 1 << (bi % 8);
    800056e4:	fe842783          	lw	a5,-24(s0)
    800056e8:	8b9d                	andi	a5,a5,7
    800056ea:	2781                	sext.w	a5,a5
    800056ec:	4705                	li	a4,1
    800056ee:	00f717bb          	sllw	a5,a4,a5
    800056f2:	fcf42e23          	sw	a5,-36(s0)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800056f6:	fe842783          	lw	a5,-24(s0)
    800056fa:	41f7d71b          	sraiw	a4,a5,0x1f
    800056fe:	01d7571b          	srliw	a4,a4,0x1d
    80005702:	9fb9                	addw	a5,a5,a4
    80005704:	4037d79b          	sraiw	a5,a5,0x3
    80005708:	2781                	sext.w	a5,a5
    8000570a:	fe043703          	ld	a4,-32(s0)
    8000570e:	97ba                	add	a5,a5,a4
    80005710:	0587c783          	lbu	a5,88(a5)
    80005714:	2781                	sext.w	a5,a5
    80005716:	fdc42703          	lw	a4,-36(s0)
    8000571a:	8ff9                	and	a5,a5,a4
    8000571c:	2781                	sext.w	a5,a5
    8000571e:	ebd1                	bnez	a5,800057b2 <balloc+0x128>
        bp->data[bi/8] |= m;  // Mark block in use.
    80005720:	fe842783          	lw	a5,-24(s0)
    80005724:	41f7d71b          	sraiw	a4,a5,0x1f
    80005728:	01d7571b          	srliw	a4,a4,0x1d
    8000572c:	9fb9                	addw	a5,a5,a4
    8000572e:	4037d79b          	sraiw	a5,a5,0x3
    80005732:	2781                	sext.w	a5,a5
    80005734:	fe043703          	ld	a4,-32(s0)
    80005738:	973e                	add	a4,a4,a5
    8000573a:	05874703          	lbu	a4,88(a4)
    8000573e:	0187169b          	slliw	a3,a4,0x18
    80005742:	4186d69b          	sraiw	a3,a3,0x18
    80005746:	fdc42703          	lw	a4,-36(s0)
    8000574a:	0187171b          	slliw	a4,a4,0x18
    8000574e:	4187571b          	sraiw	a4,a4,0x18
    80005752:	8f55                	or	a4,a4,a3
    80005754:	0187171b          	slliw	a4,a4,0x18
    80005758:	4187571b          	sraiw	a4,a4,0x18
    8000575c:	0ff77713          	zext.b	a4,a4
    80005760:	fe043683          	ld	a3,-32(s0)
    80005764:	97b6                	add	a5,a5,a3
    80005766:	04e78c23          	sb	a4,88(a5)
        log_write(bp);
    8000576a:	fe043503          	ld	a0,-32(s0)
    8000576e:	00002097          	auipc	ra,0x2
    80005772:	8e8080e7          	jalr	-1816(ra) # 80007056 <log_write>
        brelse(bp);
    80005776:	fe043503          	ld	a0,-32(s0)
    8000577a:	00000097          	auipc	ra,0x0
    8000577e:	c68080e7          	jalr	-920(ra) # 800053e2 <brelse>
        bzero(dev, b + bi);
    80005782:	fcc42783          	lw	a5,-52(s0)
    80005786:	fec42703          	lw	a4,-20(s0)
    8000578a:	86ba                	mv	a3,a4
    8000578c:	fe842703          	lw	a4,-24(s0)
    80005790:	9f35                	addw	a4,a4,a3
    80005792:	2701                	sext.w	a4,a4
    80005794:	85ba                	mv	a1,a4
    80005796:	853e                	mv	a0,a5
    80005798:	00000097          	auipc	ra,0x0
    8000579c:	e8a080e7          	jalr	-374(ra) # 80005622 <bzero>
        return b + bi;
    800057a0:	fec42783          	lw	a5,-20(s0)
    800057a4:	873e                	mv	a4,a5
    800057a6:	fe842783          	lw	a5,-24(s0)
    800057aa:	9fb9                	addw	a5,a5,a4
    800057ac:	2781                	sext.w	a5,a5
    800057ae:	2781                	sext.w	a5,a5
    800057b0:	a89d                	j	80005826 <balloc+0x19c>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800057b2:	fe842783          	lw	a5,-24(s0)
    800057b6:	2785                	addiw	a5,a5,1
    800057b8:	fef42423          	sw	a5,-24(s0)
    800057bc:	fe842783          	lw	a5,-24(s0)
    800057c0:	0007871b          	sext.w	a4,a5
    800057c4:	6789                	lui	a5,0x2
    800057c6:	02f75263          	bge	a4,a5,800057ea <balloc+0x160>
    800057ca:	fec42783          	lw	a5,-20(s0)
    800057ce:	873e                	mv	a4,a5
    800057d0:	fe842783          	lw	a5,-24(s0)
    800057d4:	9fb9                	addw	a5,a5,a4
    800057d6:	2781                	sext.w	a5,a5
    800057d8:	0007871b          	sext.w	a4,a5
    800057dc:	0049e797          	auipc	a5,0x49e
    800057e0:	9c478793          	addi	a5,a5,-1596 # 804a31a0 <sb>
    800057e4:	43dc                	lw	a5,4(a5)
    800057e6:	eef76fe3          	bltu	a4,a5,800056e4 <balloc+0x5a>
      }
    }
    brelse(bp);
    800057ea:	fe043503          	ld	a0,-32(s0)
    800057ee:	00000097          	auipc	ra,0x0
    800057f2:	bf4080e7          	jalr	-1036(ra) # 800053e2 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    800057f6:	fec42783          	lw	a5,-20(s0)
    800057fa:	873e                	mv	a4,a5
    800057fc:	6789                	lui	a5,0x2
    800057fe:	9fb9                	addw	a5,a5,a4
    80005800:	fef42623          	sw	a5,-20(s0)
    80005804:	0049e797          	auipc	a5,0x49e
    80005808:	99c78793          	addi	a5,a5,-1636 # 804a31a0 <sb>
    8000580c:	43d8                	lw	a4,4(a5)
    8000580e:	fec42783          	lw	a5,-20(s0)
    80005812:	e8e7e8e3          	bltu	a5,a4,800056a2 <balloc+0x18>
  }
  panic("balloc: out of blocks");
    80005816:	00006517          	auipc	a0,0x6
    8000581a:	de250513          	addi	a0,a0,-542 # 8000b5f8 <etext+0x5f8>
    8000581e:	ffffb097          	auipc	ra,0xffffb
    80005822:	45c080e7          	jalr	1116(ra) # 80000c7a <panic>
}
    80005826:	853e                	mv	a0,a5
    80005828:	70e2                	ld	ra,56(sp)
    8000582a:	7442                	ld	s0,48(sp)
    8000582c:	6121                	addi	sp,sp,64
    8000582e:	8082                	ret

0000000080005830 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80005830:	7179                	addi	sp,sp,-48
    80005832:	f406                	sd	ra,40(sp)
    80005834:	f022                	sd	s0,32(sp)
    80005836:	1800                	addi	s0,sp,48
    80005838:	87aa                	mv	a5,a0
    8000583a:	872e                	mv	a4,a1
    8000583c:	fcf42e23          	sw	a5,-36(s0)
    80005840:	87ba                	mv	a5,a4
    80005842:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80005846:	fdc42683          	lw	a3,-36(s0)
    8000584a:	fd842783          	lw	a5,-40(s0)
    8000584e:	00d7d79b          	srliw	a5,a5,0xd
    80005852:	0007871b          	sext.w	a4,a5
    80005856:	0049e797          	auipc	a5,0x49e
    8000585a:	94a78793          	addi	a5,a5,-1718 # 804a31a0 <sb>
    8000585e:	4fdc                	lw	a5,28(a5)
    80005860:	9fb9                	addw	a5,a5,a4
    80005862:	2781                	sext.w	a5,a5
    80005864:	85be                	mv	a1,a5
    80005866:	8536                	mv	a0,a3
    80005868:	00000097          	auipc	ra,0x0
    8000586c:	ad8080e7          	jalr	-1320(ra) # 80005340 <bread>
    80005870:	fea43423          	sd	a0,-24(s0)
  bi = b % BPB;
    80005874:	fd842703          	lw	a4,-40(s0)
    80005878:	6789                	lui	a5,0x2
    8000587a:	17fd                	addi	a5,a5,-1
    8000587c:	8ff9                	and	a5,a5,a4
    8000587e:	fef42223          	sw	a5,-28(s0)
  m = 1 << (bi % 8);
    80005882:	fe442783          	lw	a5,-28(s0)
    80005886:	8b9d                	andi	a5,a5,7
    80005888:	2781                	sext.w	a5,a5
    8000588a:	4705                	li	a4,1
    8000588c:	00f717bb          	sllw	a5,a4,a5
    80005890:	fef42023          	sw	a5,-32(s0)
  if((bp->data[bi/8] & m) == 0)
    80005894:	fe442783          	lw	a5,-28(s0)
    80005898:	41f7d71b          	sraiw	a4,a5,0x1f
    8000589c:	01d7571b          	srliw	a4,a4,0x1d
    800058a0:	9fb9                	addw	a5,a5,a4
    800058a2:	4037d79b          	sraiw	a5,a5,0x3
    800058a6:	2781                	sext.w	a5,a5
    800058a8:	fe843703          	ld	a4,-24(s0)
    800058ac:	97ba                	add	a5,a5,a4
    800058ae:	0587c783          	lbu	a5,88(a5) # 2058 <_entry-0x7fffdfa8>
    800058b2:	2781                	sext.w	a5,a5
    800058b4:	fe042703          	lw	a4,-32(s0)
    800058b8:	8ff9                	and	a5,a5,a4
    800058ba:	2781                	sext.w	a5,a5
    800058bc:	eb89                	bnez	a5,800058ce <bfree+0x9e>
    panic("freeing free block");
    800058be:	00006517          	auipc	a0,0x6
    800058c2:	d5250513          	addi	a0,a0,-686 # 8000b610 <etext+0x610>
    800058c6:	ffffb097          	auipc	ra,0xffffb
    800058ca:	3b4080e7          	jalr	948(ra) # 80000c7a <panic>
  bp->data[bi/8] &= ~m;
    800058ce:	fe442783          	lw	a5,-28(s0)
    800058d2:	41f7d71b          	sraiw	a4,a5,0x1f
    800058d6:	01d7571b          	srliw	a4,a4,0x1d
    800058da:	9fb9                	addw	a5,a5,a4
    800058dc:	4037d79b          	sraiw	a5,a5,0x3
    800058e0:	2781                	sext.w	a5,a5
    800058e2:	fe843703          	ld	a4,-24(s0)
    800058e6:	973e                	add	a4,a4,a5
    800058e8:	05874703          	lbu	a4,88(a4)
    800058ec:	0187169b          	slliw	a3,a4,0x18
    800058f0:	4186d69b          	sraiw	a3,a3,0x18
    800058f4:	fe042703          	lw	a4,-32(s0)
    800058f8:	0187171b          	slliw	a4,a4,0x18
    800058fc:	4187571b          	sraiw	a4,a4,0x18
    80005900:	fff74713          	not	a4,a4
    80005904:	0187171b          	slliw	a4,a4,0x18
    80005908:	4187571b          	sraiw	a4,a4,0x18
    8000590c:	8f75                	and	a4,a4,a3
    8000590e:	0187171b          	slliw	a4,a4,0x18
    80005912:	4187571b          	sraiw	a4,a4,0x18
    80005916:	0ff77713          	zext.b	a4,a4
    8000591a:	fe843683          	ld	a3,-24(s0)
    8000591e:	97b6                	add	a5,a5,a3
    80005920:	04e78c23          	sb	a4,88(a5)
  log_write(bp);
    80005924:	fe843503          	ld	a0,-24(s0)
    80005928:	00001097          	auipc	ra,0x1
    8000592c:	72e080e7          	jalr	1838(ra) # 80007056 <log_write>
  brelse(bp);
    80005930:	fe843503          	ld	a0,-24(s0)
    80005934:	00000097          	auipc	ra,0x0
    80005938:	aae080e7          	jalr	-1362(ra) # 800053e2 <brelse>
}
    8000593c:	0001                	nop
    8000593e:	70a2                	ld	ra,40(sp)
    80005940:	7402                	ld	s0,32(sp)
    80005942:	6145                	addi	sp,sp,48
    80005944:	8082                	ret

0000000080005946 <iinit>:
  struct inode inode[NINODE];
} itable;

void
iinit()
{
    80005946:	1101                	addi	sp,sp,-32
    80005948:	ec06                	sd	ra,24(sp)
    8000594a:	e822                	sd	s0,16(sp)
    8000594c:	1000                	addi	s0,sp,32
  int i = 0;
    8000594e:	fe042623          	sw	zero,-20(s0)
  
  initlock(&itable.lock, "itable");
    80005952:	00006597          	auipc	a1,0x6
    80005956:	cd658593          	addi	a1,a1,-810 # 8000b628 <etext+0x628>
    8000595a:	0049e517          	auipc	a0,0x49e
    8000595e:	86650513          	addi	a0,a0,-1946 # 804a31c0 <itable>
    80005962:	ffffc097          	auipc	ra,0xffffc
    80005966:	8d8080e7          	jalr	-1832(ra) # 8000123a <initlock>
  for(i = 0; i < NINODE; i++) {
    8000596a:	fe042623          	sw	zero,-20(s0)
    8000596e:	a82d                	j	800059a8 <iinit+0x62>
    initsleeplock(&itable.inode[i].lock, "inode");
    80005970:	fec42703          	lw	a4,-20(s0)
    80005974:	87ba                	mv	a5,a4
    80005976:	0792                	slli	a5,a5,0x4
    80005978:	97ba                	add	a5,a5,a4
    8000597a:	078e                	slli	a5,a5,0x3
    8000597c:	02078713          	addi	a4,a5,32
    80005980:	0049e797          	auipc	a5,0x49e
    80005984:	84078793          	addi	a5,a5,-1984 # 804a31c0 <itable>
    80005988:	97ba                	add	a5,a5,a4
    8000598a:	07a1                	addi	a5,a5,8
    8000598c:	00006597          	auipc	a1,0x6
    80005990:	ca458593          	addi	a1,a1,-860 # 8000b630 <etext+0x630>
    80005994:	853e                	mv	a0,a5
    80005996:	00001097          	auipc	ra,0x1
    8000599a:	7f4080e7          	jalr	2036(ra) # 8000718a <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    8000599e:	fec42783          	lw	a5,-20(s0)
    800059a2:	2785                	addiw	a5,a5,1
    800059a4:	fef42623          	sw	a5,-20(s0)
    800059a8:	fec42783          	lw	a5,-20(s0)
    800059ac:	0007871b          	sext.w	a4,a5
    800059b0:	03100793          	li	a5,49
    800059b4:	fae7dee3          	bge	a5,a4,80005970 <iinit+0x2a>
  }
}
    800059b8:	0001                	nop
    800059ba:	0001                	nop
    800059bc:	60e2                	ld	ra,24(sp)
    800059be:	6442                	ld	s0,16(sp)
    800059c0:	6105                	addi	sp,sp,32
    800059c2:	8082                	ret

00000000800059c4 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
    800059c4:	7139                	addi	sp,sp,-64
    800059c6:	fc06                	sd	ra,56(sp)
    800059c8:	f822                	sd	s0,48(sp)
    800059ca:	0080                	addi	s0,sp,64
    800059cc:	87aa                	mv	a5,a0
    800059ce:	872e                	mv	a4,a1
    800059d0:	fcf42623          	sw	a5,-52(s0)
    800059d4:	87ba                	mv	a5,a4
    800059d6:	fcf41523          	sh	a5,-54(s0)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    800059da:	4785                	li	a5,1
    800059dc:	fef42623          	sw	a5,-20(s0)
    800059e0:	a855                	j	80005a94 <ialloc+0xd0>
    bp = bread(dev, IBLOCK(inum, sb));
    800059e2:	fec42783          	lw	a5,-20(s0)
    800059e6:	8391                	srli	a5,a5,0x4
    800059e8:	0007871b          	sext.w	a4,a5
    800059ec:	0049d797          	auipc	a5,0x49d
    800059f0:	7b478793          	addi	a5,a5,1972 # 804a31a0 <sb>
    800059f4:	4f9c                	lw	a5,24(a5)
    800059f6:	9fb9                	addw	a5,a5,a4
    800059f8:	0007871b          	sext.w	a4,a5
    800059fc:	fcc42783          	lw	a5,-52(s0)
    80005a00:	85ba                	mv	a1,a4
    80005a02:	853e                	mv	a0,a5
    80005a04:	00000097          	auipc	ra,0x0
    80005a08:	93c080e7          	jalr	-1732(ra) # 80005340 <bread>
    80005a0c:	fea43023          	sd	a0,-32(s0)
    dip = (struct dinode*)bp->data + inum%IPB;
    80005a10:	fe043783          	ld	a5,-32(s0)
    80005a14:	05878713          	addi	a4,a5,88
    80005a18:	fec42783          	lw	a5,-20(s0)
    80005a1c:	8bbd                	andi	a5,a5,15
    80005a1e:	079a                	slli	a5,a5,0x6
    80005a20:	97ba                	add	a5,a5,a4
    80005a22:	fcf43c23          	sd	a5,-40(s0)
    if(dip->type == 0){  // a free inode
    80005a26:	fd843783          	ld	a5,-40(s0)
    80005a2a:	00079783          	lh	a5,0(a5)
    80005a2e:	eba1                	bnez	a5,80005a7e <ialloc+0xba>
      memset(dip, 0, sizeof(*dip));
    80005a30:	04000613          	li	a2,64
    80005a34:	4581                	li	a1,0
    80005a36:	fd843503          	ld	a0,-40(s0)
    80005a3a:	ffffc097          	auipc	ra,0xffffc
    80005a3e:	a04080e7          	jalr	-1532(ra) # 8000143e <memset>
      dip->type = type;
    80005a42:	fd843783          	ld	a5,-40(s0)
    80005a46:	fca45703          	lhu	a4,-54(s0)
    80005a4a:	00e79023          	sh	a4,0(a5)
      log_write(bp);   // mark it allocated on the disk
    80005a4e:	fe043503          	ld	a0,-32(s0)
    80005a52:	00001097          	auipc	ra,0x1
    80005a56:	604080e7          	jalr	1540(ra) # 80007056 <log_write>
      brelse(bp);
    80005a5a:	fe043503          	ld	a0,-32(s0)
    80005a5e:	00000097          	auipc	ra,0x0
    80005a62:	984080e7          	jalr	-1660(ra) # 800053e2 <brelse>
      return iget(dev, inum);
    80005a66:	fec42703          	lw	a4,-20(s0)
    80005a6a:	fcc42783          	lw	a5,-52(s0)
    80005a6e:	85ba                	mv	a1,a4
    80005a70:	853e                	mv	a0,a5
    80005a72:	00000097          	auipc	ra,0x0
    80005a76:	136080e7          	jalr	310(ra) # 80005ba8 <iget>
    80005a7a:	87aa                	mv	a5,a0
    80005a7c:	a82d                	j	80005ab6 <ialloc+0xf2>
    }
    brelse(bp);
    80005a7e:	fe043503          	ld	a0,-32(s0)
    80005a82:	00000097          	auipc	ra,0x0
    80005a86:	960080e7          	jalr	-1696(ra) # 800053e2 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80005a8a:	fec42783          	lw	a5,-20(s0)
    80005a8e:	2785                	addiw	a5,a5,1
    80005a90:	fef42623          	sw	a5,-20(s0)
    80005a94:	0049d797          	auipc	a5,0x49d
    80005a98:	70c78793          	addi	a5,a5,1804 # 804a31a0 <sb>
    80005a9c:	47d8                	lw	a4,12(a5)
    80005a9e:	fec42783          	lw	a5,-20(s0)
    80005aa2:	f4e7e0e3          	bltu	a5,a4,800059e2 <ialloc+0x1e>
  }
  panic("ialloc: no inodes");
    80005aa6:	00006517          	auipc	a0,0x6
    80005aaa:	b9250513          	addi	a0,a0,-1134 # 8000b638 <etext+0x638>
    80005aae:	ffffb097          	auipc	ra,0xffffb
    80005ab2:	1cc080e7          	jalr	460(ra) # 80000c7a <panic>
}
    80005ab6:	853e                	mv	a0,a5
    80005ab8:	70e2                	ld	ra,56(sp)
    80005aba:	7442                	ld	s0,48(sp)
    80005abc:	6121                	addi	sp,sp,64
    80005abe:	8082                	ret

0000000080005ac0 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
    80005ac0:	7179                	addi	sp,sp,-48
    80005ac2:	f406                	sd	ra,40(sp)
    80005ac4:	f022                	sd	s0,32(sp)
    80005ac6:	1800                	addi	s0,sp,48
    80005ac8:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80005acc:	fd843783          	ld	a5,-40(s0)
    80005ad0:	4394                	lw	a3,0(a5)
    80005ad2:	fd843783          	ld	a5,-40(s0)
    80005ad6:	43dc                	lw	a5,4(a5)
    80005ad8:	0047d79b          	srliw	a5,a5,0x4
    80005adc:	0007871b          	sext.w	a4,a5
    80005ae0:	0049d797          	auipc	a5,0x49d
    80005ae4:	6c078793          	addi	a5,a5,1728 # 804a31a0 <sb>
    80005ae8:	4f9c                	lw	a5,24(a5)
    80005aea:	9fb9                	addw	a5,a5,a4
    80005aec:	2781                	sext.w	a5,a5
    80005aee:	85be                	mv	a1,a5
    80005af0:	8536                	mv	a0,a3
    80005af2:	00000097          	auipc	ra,0x0
    80005af6:	84e080e7          	jalr	-1970(ra) # 80005340 <bread>
    80005afa:	fea43423          	sd	a0,-24(s0)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80005afe:	fe843783          	ld	a5,-24(s0)
    80005b02:	05878713          	addi	a4,a5,88
    80005b06:	fd843783          	ld	a5,-40(s0)
    80005b0a:	43dc                	lw	a5,4(a5)
    80005b0c:	1782                	slli	a5,a5,0x20
    80005b0e:	9381                	srli	a5,a5,0x20
    80005b10:	8bbd                	andi	a5,a5,15
    80005b12:	079a                	slli	a5,a5,0x6
    80005b14:	97ba                	add	a5,a5,a4
    80005b16:	fef43023          	sd	a5,-32(s0)
  dip->type = ip->type;
    80005b1a:	fd843783          	ld	a5,-40(s0)
    80005b1e:	04479703          	lh	a4,68(a5)
    80005b22:	fe043783          	ld	a5,-32(s0)
    80005b26:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80005b2a:	fd843783          	ld	a5,-40(s0)
    80005b2e:	04679703          	lh	a4,70(a5)
    80005b32:	fe043783          	ld	a5,-32(s0)
    80005b36:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80005b3a:	fd843783          	ld	a5,-40(s0)
    80005b3e:	04879703          	lh	a4,72(a5)
    80005b42:	fe043783          	ld	a5,-32(s0)
    80005b46:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80005b4a:	fd843783          	ld	a5,-40(s0)
    80005b4e:	04a79703          	lh	a4,74(a5)
    80005b52:	fe043783          	ld	a5,-32(s0)
    80005b56:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80005b5a:	fd843783          	ld	a5,-40(s0)
    80005b5e:	47f8                	lw	a4,76(a5)
    80005b60:	fe043783          	ld	a5,-32(s0)
    80005b64:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80005b66:	fe043783          	ld	a5,-32(s0)
    80005b6a:	00c78713          	addi	a4,a5,12
    80005b6e:	fd843783          	ld	a5,-40(s0)
    80005b72:	05078793          	addi	a5,a5,80
    80005b76:	03400613          	li	a2,52
    80005b7a:	85be                	mv	a1,a5
    80005b7c:	853a                	mv	a0,a4
    80005b7e:	ffffc097          	auipc	ra,0xffffc
    80005b82:	9a4080e7          	jalr	-1628(ra) # 80001522 <memmove>
  log_write(bp);
    80005b86:	fe843503          	ld	a0,-24(s0)
    80005b8a:	00001097          	auipc	ra,0x1
    80005b8e:	4cc080e7          	jalr	1228(ra) # 80007056 <log_write>
  brelse(bp);
    80005b92:	fe843503          	ld	a0,-24(s0)
    80005b96:	00000097          	auipc	ra,0x0
    80005b9a:	84c080e7          	jalr	-1972(ra) # 800053e2 <brelse>
}
    80005b9e:	0001                	nop
    80005ba0:	70a2                	ld	ra,40(sp)
    80005ba2:	7402                	ld	s0,32(sp)
    80005ba4:	6145                	addi	sp,sp,48
    80005ba6:	8082                	ret

0000000080005ba8 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
    80005ba8:	7179                	addi	sp,sp,-48
    80005baa:	f406                	sd	ra,40(sp)
    80005bac:	f022                	sd	s0,32(sp)
    80005bae:	1800                	addi	s0,sp,48
    80005bb0:	87aa                	mv	a5,a0
    80005bb2:	872e                	mv	a4,a1
    80005bb4:	fcf42e23          	sw	a5,-36(s0)
    80005bb8:	87ba                	mv	a5,a4
    80005bba:	fcf42c23          	sw	a5,-40(s0)
  struct inode *ip, *empty;

  acquire(&itable.lock);
    80005bbe:	0049d517          	auipc	a0,0x49d
    80005bc2:	60250513          	addi	a0,a0,1538 # 804a31c0 <itable>
    80005bc6:	ffffb097          	auipc	ra,0xffffb
    80005bca:	6a4080e7          	jalr	1700(ra) # 8000126a <acquire>

  // Is the inode already in the table?
  empty = 0;
    80005bce:	fe043023          	sd	zero,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80005bd2:	0049d797          	auipc	a5,0x49d
    80005bd6:	60678793          	addi	a5,a5,1542 # 804a31d8 <itable+0x18>
    80005bda:	fef43423          	sd	a5,-24(s0)
    80005bde:	a89d                	j	80005c54 <iget+0xac>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80005be0:	fe843783          	ld	a5,-24(s0)
    80005be4:	479c                	lw	a5,8(a5)
    80005be6:	04f05663          	blez	a5,80005c32 <iget+0x8a>
    80005bea:	fe843783          	ld	a5,-24(s0)
    80005bee:	4398                	lw	a4,0(a5)
    80005bf0:	fdc42783          	lw	a5,-36(s0)
    80005bf4:	2781                	sext.w	a5,a5
    80005bf6:	02e79e63          	bne	a5,a4,80005c32 <iget+0x8a>
    80005bfa:	fe843783          	ld	a5,-24(s0)
    80005bfe:	43d8                	lw	a4,4(a5)
    80005c00:	fd842783          	lw	a5,-40(s0)
    80005c04:	2781                	sext.w	a5,a5
    80005c06:	02e79663          	bne	a5,a4,80005c32 <iget+0x8a>
      ip->ref++;
    80005c0a:	fe843783          	ld	a5,-24(s0)
    80005c0e:	479c                	lw	a5,8(a5)
    80005c10:	2785                	addiw	a5,a5,1
    80005c12:	0007871b          	sext.w	a4,a5
    80005c16:	fe843783          	ld	a5,-24(s0)
    80005c1a:	c798                	sw	a4,8(a5)
      release(&itable.lock);
    80005c1c:	0049d517          	auipc	a0,0x49d
    80005c20:	5a450513          	addi	a0,a0,1444 # 804a31c0 <itable>
    80005c24:	ffffb097          	auipc	ra,0xffffb
    80005c28:	6aa080e7          	jalr	1706(ra) # 800012ce <release>
      return ip;
    80005c2c:	fe843783          	ld	a5,-24(s0)
    80005c30:	a069                	j	80005cba <iget+0x112>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80005c32:	fe043783          	ld	a5,-32(s0)
    80005c36:	eb89                	bnez	a5,80005c48 <iget+0xa0>
    80005c38:	fe843783          	ld	a5,-24(s0)
    80005c3c:	479c                	lw	a5,8(a5)
    80005c3e:	e789                	bnez	a5,80005c48 <iget+0xa0>
      empty = ip;
    80005c40:	fe843783          	ld	a5,-24(s0)
    80005c44:	fef43023          	sd	a5,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80005c48:	fe843783          	ld	a5,-24(s0)
    80005c4c:	08878793          	addi	a5,a5,136
    80005c50:	fef43423          	sd	a5,-24(s0)
    80005c54:	fe843703          	ld	a4,-24(s0)
    80005c58:	0049f797          	auipc	a5,0x49f
    80005c5c:	01078793          	addi	a5,a5,16 # 804a4c68 <log>
    80005c60:	f8f760e3          	bltu	a4,a5,80005be0 <iget+0x38>
  }

  // Recycle an inode entry.
  if(empty == 0)
    80005c64:	fe043783          	ld	a5,-32(s0)
    80005c68:	eb89                	bnez	a5,80005c7a <iget+0xd2>
    panic("iget: no inodes");
    80005c6a:	00006517          	auipc	a0,0x6
    80005c6e:	9e650513          	addi	a0,a0,-1562 # 8000b650 <etext+0x650>
    80005c72:	ffffb097          	auipc	ra,0xffffb
    80005c76:	008080e7          	jalr	8(ra) # 80000c7a <panic>

  ip = empty;
    80005c7a:	fe043783          	ld	a5,-32(s0)
    80005c7e:	fef43423          	sd	a5,-24(s0)
  ip->dev = dev;
    80005c82:	fe843783          	ld	a5,-24(s0)
    80005c86:	fdc42703          	lw	a4,-36(s0)
    80005c8a:	c398                	sw	a4,0(a5)
  ip->inum = inum;
    80005c8c:	fe843783          	ld	a5,-24(s0)
    80005c90:	fd842703          	lw	a4,-40(s0)
    80005c94:	c3d8                	sw	a4,4(a5)
  ip->ref = 1;
    80005c96:	fe843783          	ld	a5,-24(s0)
    80005c9a:	4705                	li	a4,1
    80005c9c:	c798                	sw	a4,8(a5)
  ip->valid = 0;
    80005c9e:	fe843783          	ld	a5,-24(s0)
    80005ca2:	0407a023          	sw	zero,64(a5)
  release(&itable.lock);
    80005ca6:	0049d517          	auipc	a0,0x49d
    80005caa:	51a50513          	addi	a0,a0,1306 # 804a31c0 <itable>
    80005cae:	ffffb097          	auipc	ra,0xffffb
    80005cb2:	620080e7          	jalr	1568(ra) # 800012ce <release>

  return ip;
    80005cb6:	fe843783          	ld	a5,-24(s0)
}
    80005cba:	853e                	mv	a0,a5
    80005cbc:	70a2                	ld	ra,40(sp)
    80005cbe:	7402                	ld	s0,32(sp)
    80005cc0:	6145                	addi	sp,sp,48
    80005cc2:	8082                	ret

0000000080005cc4 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
    80005cc4:	1101                	addi	sp,sp,-32
    80005cc6:	ec06                	sd	ra,24(sp)
    80005cc8:	e822                	sd	s0,16(sp)
    80005cca:	1000                	addi	s0,sp,32
    80005ccc:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    80005cd0:	0049d517          	auipc	a0,0x49d
    80005cd4:	4f050513          	addi	a0,a0,1264 # 804a31c0 <itable>
    80005cd8:	ffffb097          	auipc	ra,0xffffb
    80005cdc:	592080e7          	jalr	1426(ra) # 8000126a <acquire>
  ip->ref++;
    80005ce0:	fe843783          	ld	a5,-24(s0)
    80005ce4:	479c                	lw	a5,8(a5)
    80005ce6:	2785                	addiw	a5,a5,1
    80005ce8:	0007871b          	sext.w	a4,a5
    80005cec:	fe843783          	ld	a5,-24(s0)
    80005cf0:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80005cf2:	0049d517          	auipc	a0,0x49d
    80005cf6:	4ce50513          	addi	a0,a0,1230 # 804a31c0 <itable>
    80005cfa:	ffffb097          	auipc	ra,0xffffb
    80005cfe:	5d4080e7          	jalr	1492(ra) # 800012ce <release>
  return ip;
    80005d02:	fe843783          	ld	a5,-24(s0)
}
    80005d06:	853e                	mv	a0,a5
    80005d08:	60e2                	ld	ra,24(sp)
    80005d0a:	6442                	ld	s0,16(sp)
    80005d0c:	6105                	addi	sp,sp,32
    80005d0e:	8082                	ret

0000000080005d10 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
    80005d10:	7179                	addi	sp,sp,-48
    80005d12:	f406                	sd	ra,40(sp)
    80005d14:	f022                	sd	s0,32(sp)
    80005d16:	1800                	addi	s0,sp,48
    80005d18:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    80005d1c:	fd843783          	ld	a5,-40(s0)
    80005d20:	c791                	beqz	a5,80005d2c <ilock+0x1c>
    80005d22:	fd843783          	ld	a5,-40(s0)
    80005d26:	479c                	lw	a5,8(a5)
    80005d28:	00f04a63          	bgtz	a5,80005d3c <ilock+0x2c>
    panic("ilock");
    80005d2c:	00006517          	auipc	a0,0x6
    80005d30:	93450513          	addi	a0,a0,-1740 # 8000b660 <etext+0x660>
    80005d34:	ffffb097          	auipc	ra,0xffffb
    80005d38:	f46080e7          	jalr	-186(ra) # 80000c7a <panic>

  acquiresleep(&ip->lock);
    80005d3c:	fd843783          	ld	a5,-40(s0)
    80005d40:	07c1                	addi	a5,a5,16
    80005d42:	853e                	mv	a0,a5
    80005d44:	00001097          	auipc	ra,0x1
    80005d48:	492080e7          	jalr	1170(ra) # 800071d6 <acquiresleep>

  if(ip->valid == 0){
    80005d4c:	fd843783          	ld	a5,-40(s0)
    80005d50:	43bc                	lw	a5,64(a5)
    80005d52:	e7e5                	bnez	a5,80005e3a <ilock+0x12a>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80005d54:	fd843783          	ld	a5,-40(s0)
    80005d58:	4394                	lw	a3,0(a5)
    80005d5a:	fd843783          	ld	a5,-40(s0)
    80005d5e:	43dc                	lw	a5,4(a5)
    80005d60:	0047d79b          	srliw	a5,a5,0x4
    80005d64:	0007871b          	sext.w	a4,a5
    80005d68:	0049d797          	auipc	a5,0x49d
    80005d6c:	43878793          	addi	a5,a5,1080 # 804a31a0 <sb>
    80005d70:	4f9c                	lw	a5,24(a5)
    80005d72:	9fb9                	addw	a5,a5,a4
    80005d74:	2781                	sext.w	a5,a5
    80005d76:	85be                	mv	a1,a5
    80005d78:	8536                	mv	a0,a3
    80005d7a:	fffff097          	auipc	ra,0xfffff
    80005d7e:	5c6080e7          	jalr	1478(ra) # 80005340 <bread>
    80005d82:	fea43423          	sd	a0,-24(s0)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80005d86:	fe843783          	ld	a5,-24(s0)
    80005d8a:	05878713          	addi	a4,a5,88
    80005d8e:	fd843783          	ld	a5,-40(s0)
    80005d92:	43dc                	lw	a5,4(a5)
    80005d94:	1782                	slli	a5,a5,0x20
    80005d96:	9381                	srli	a5,a5,0x20
    80005d98:	8bbd                	andi	a5,a5,15
    80005d9a:	079a                	slli	a5,a5,0x6
    80005d9c:	97ba                	add	a5,a5,a4
    80005d9e:	fef43023          	sd	a5,-32(s0)
    ip->type = dip->type;
    80005da2:	fe043783          	ld	a5,-32(s0)
    80005da6:	00079703          	lh	a4,0(a5)
    80005daa:	fd843783          	ld	a5,-40(s0)
    80005dae:	04e79223          	sh	a4,68(a5)
    ip->major = dip->major;
    80005db2:	fe043783          	ld	a5,-32(s0)
    80005db6:	00279703          	lh	a4,2(a5)
    80005dba:	fd843783          	ld	a5,-40(s0)
    80005dbe:	04e79323          	sh	a4,70(a5)
    ip->minor = dip->minor;
    80005dc2:	fe043783          	ld	a5,-32(s0)
    80005dc6:	00479703          	lh	a4,4(a5)
    80005dca:	fd843783          	ld	a5,-40(s0)
    80005dce:	04e79423          	sh	a4,72(a5)
    ip->nlink = dip->nlink;
    80005dd2:	fe043783          	ld	a5,-32(s0)
    80005dd6:	00679703          	lh	a4,6(a5)
    80005dda:	fd843783          	ld	a5,-40(s0)
    80005dde:	04e79523          	sh	a4,74(a5)
    ip->size = dip->size;
    80005de2:	fe043783          	ld	a5,-32(s0)
    80005de6:	4798                	lw	a4,8(a5)
    80005de8:	fd843783          	ld	a5,-40(s0)
    80005dec:	c7f8                	sw	a4,76(a5)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80005dee:	fd843783          	ld	a5,-40(s0)
    80005df2:	05078713          	addi	a4,a5,80
    80005df6:	fe043783          	ld	a5,-32(s0)
    80005dfa:	07b1                	addi	a5,a5,12
    80005dfc:	03400613          	li	a2,52
    80005e00:	85be                	mv	a1,a5
    80005e02:	853a                	mv	a0,a4
    80005e04:	ffffb097          	auipc	ra,0xffffb
    80005e08:	71e080e7          	jalr	1822(ra) # 80001522 <memmove>
    brelse(bp);
    80005e0c:	fe843503          	ld	a0,-24(s0)
    80005e10:	fffff097          	auipc	ra,0xfffff
    80005e14:	5d2080e7          	jalr	1490(ra) # 800053e2 <brelse>
    ip->valid = 1;
    80005e18:	fd843783          	ld	a5,-40(s0)
    80005e1c:	4705                	li	a4,1
    80005e1e:	c3b8                	sw	a4,64(a5)
    if(ip->type == 0)
    80005e20:	fd843783          	ld	a5,-40(s0)
    80005e24:	04479783          	lh	a5,68(a5)
    80005e28:	eb89                	bnez	a5,80005e3a <ilock+0x12a>
      panic("ilock: no type");
    80005e2a:	00006517          	auipc	a0,0x6
    80005e2e:	83e50513          	addi	a0,a0,-1986 # 8000b668 <etext+0x668>
    80005e32:	ffffb097          	auipc	ra,0xffffb
    80005e36:	e48080e7          	jalr	-440(ra) # 80000c7a <panic>
  }
}
    80005e3a:	0001                	nop
    80005e3c:	70a2                	ld	ra,40(sp)
    80005e3e:	7402                	ld	s0,32(sp)
    80005e40:	6145                	addi	sp,sp,48
    80005e42:	8082                	ret

0000000080005e44 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
    80005e44:	1101                	addi	sp,sp,-32
    80005e46:	ec06                	sd	ra,24(sp)
    80005e48:	e822                	sd	s0,16(sp)
    80005e4a:	1000                	addi	s0,sp,32
    80005e4c:	fea43423          	sd	a0,-24(s0)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80005e50:	fe843783          	ld	a5,-24(s0)
    80005e54:	c385                	beqz	a5,80005e74 <iunlock+0x30>
    80005e56:	fe843783          	ld	a5,-24(s0)
    80005e5a:	07c1                	addi	a5,a5,16
    80005e5c:	853e                	mv	a0,a5
    80005e5e:	00001097          	auipc	ra,0x1
    80005e62:	438080e7          	jalr	1080(ra) # 80007296 <holdingsleep>
    80005e66:	87aa                	mv	a5,a0
    80005e68:	c791                	beqz	a5,80005e74 <iunlock+0x30>
    80005e6a:	fe843783          	ld	a5,-24(s0)
    80005e6e:	479c                	lw	a5,8(a5)
    80005e70:	00f04a63          	bgtz	a5,80005e84 <iunlock+0x40>
    panic("iunlock");
    80005e74:	00006517          	auipc	a0,0x6
    80005e78:	80450513          	addi	a0,a0,-2044 # 8000b678 <etext+0x678>
    80005e7c:	ffffb097          	auipc	ra,0xffffb
    80005e80:	dfe080e7          	jalr	-514(ra) # 80000c7a <panic>

  releasesleep(&ip->lock);
    80005e84:	fe843783          	ld	a5,-24(s0)
    80005e88:	07c1                	addi	a5,a5,16
    80005e8a:	853e                	mv	a0,a5
    80005e8c:	00001097          	auipc	ra,0x1
    80005e90:	3b8080e7          	jalr	952(ra) # 80007244 <releasesleep>
}
    80005e94:	0001                	nop
    80005e96:	60e2                	ld	ra,24(sp)
    80005e98:	6442                	ld	s0,16(sp)
    80005e9a:	6105                	addi	sp,sp,32
    80005e9c:	8082                	ret

0000000080005e9e <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
    80005e9e:	1101                	addi	sp,sp,-32
    80005ea0:	ec06                	sd	ra,24(sp)
    80005ea2:	e822                	sd	s0,16(sp)
    80005ea4:	1000                	addi	s0,sp,32
    80005ea6:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    80005eaa:	0049d517          	auipc	a0,0x49d
    80005eae:	31650513          	addi	a0,a0,790 # 804a31c0 <itable>
    80005eb2:	ffffb097          	auipc	ra,0xffffb
    80005eb6:	3b8080e7          	jalr	952(ra) # 8000126a <acquire>

  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80005eba:	fe843783          	ld	a5,-24(s0)
    80005ebe:	479c                	lw	a5,8(a5)
    80005ec0:	873e                	mv	a4,a5
    80005ec2:	4785                	li	a5,1
    80005ec4:	06f71f63          	bne	a4,a5,80005f42 <iput+0xa4>
    80005ec8:	fe843783          	ld	a5,-24(s0)
    80005ecc:	43bc                	lw	a5,64(a5)
    80005ece:	cbb5                	beqz	a5,80005f42 <iput+0xa4>
    80005ed0:	fe843783          	ld	a5,-24(s0)
    80005ed4:	04a79783          	lh	a5,74(a5)
    80005ed8:	e7ad                	bnez	a5,80005f42 <iput+0xa4>
    // inode has no links and no other references: truncate and free.

    // ip->ref == 1 means no other process can have ip locked,
    // so this acquiresleep() won't block (or deadlock).
    acquiresleep(&ip->lock);
    80005eda:	fe843783          	ld	a5,-24(s0)
    80005ede:	07c1                	addi	a5,a5,16
    80005ee0:	853e                	mv	a0,a5
    80005ee2:	00001097          	auipc	ra,0x1
    80005ee6:	2f4080e7          	jalr	756(ra) # 800071d6 <acquiresleep>

    release(&itable.lock);
    80005eea:	0049d517          	auipc	a0,0x49d
    80005eee:	2d650513          	addi	a0,a0,726 # 804a31c0 <itable>
    80005ef2:	ffffb097          	auipc	ra,0xffffb
    80005ef6:	3dc080e7          	jalr	988(ra) # 800012ce <release>

    itrunc(ip);
    80005efa:	fe843503          	ld	a0,-24(s0)
    80005efe:	00000097          	auipc	ra,0x0
    80005f02:	1fa080e7          	jalr	506(ra) # 800060f8 <itrunc>
    ip->type = 0;
    80005f06:	fe843783          	ld	a5,-24(s0)
    80005f0a:	04079223          	sh	zero,68(a5)
    iupdate(ip);
    80005f0e:	fe843503          	ld	a0,-24(s0)
    80005f12:	00000097          	auipc	ra,0x0
    80005f16:	bae080e7          	jalr	-1106(ra) # 80005ac0 <iupdate>
    ip->valid = 0;
    80005f1a:	fe843783          	ld	a5,-24(s0)
    80005f1e:	0407a023          	sw	zero,64(a5)

    releasesleep(&ip->lock);
    80005f22:	fe843783          	ld	a5,-24(s0)
    80005f26:	07c1                	addi	a5,a5,16
    80005f28:	853e                	mv	a0,a5
    80005f2a:	00001097          	auipc	ra,0x1
    80005f2e:	31a080e7          	jalr	794(ra) # 80007244 <releasesleep>

    acquire(&itable.lock);
    80005f32:	0049d517          	auipc	a0,0x49d
    80005f36:	28e50513          	addi	a0,a0,654 # 804a31c0 <itable>
    80005f3a:	ffffb097          	auipc	ra,0xffffb
    80005f3e:	330080e7          	jalr	816(ra) # 8000126a <acquire>
  }

  ip->ref--;
    80005f42:	fe843783          	ld	a5,-24(s0)
    80005f46:	479c                	lw	a5,8(a5)
    80005f48:	37fd                	addiw	a5,a5,-1
    80005f4a:	0007871b          	sext.w	a4,a5
    80005f4e:	fe843783          	ld	a5,-24(s0)
    80005f52:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80005f54:	0049d517          	auipc	a0,0x49d
    80005f58:	26c50513          	addi	a0,a0,620 # 804a31c0 <itable>
    80005f5c:	ffffb097          	auipc	ra,0xffffb
    80005f60:	372080e7          	jalr	882(ra) # 800012ce <release>
}
    80005f64:	0001                	nop
    80005f66:	60e2                	ld	ra,24(sp)
    80005f68:	6442                	ld	s0,16(sp)
    80005f6a:	6105                	addi	sp,sp,32
    80005f6c:	8082                	ret

0000000080005f6e <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
    80005f6e:	1101                	addi	sp,sp,-32
    80005f70:	ec06                	sd	ra,24(sp)
    80005f72:	e822                	sd	s0,16(sp)
    80005f74:	1000                	addi	s0,sp,32
    80005f76:	fea43423          	sd	a0,-24(s0)
  iunlock(ip);
    80005f7a:	fe843503          	ld	a0,-24(s0)
    80005f7e:	00000097          	auipc	ra,0x0
    80005f82:	ec6080e7          	jalr	-314(ra) # 80005e44 <iunlock>
  iput(ip);
    80005f86:	fe843503          	ld	a0,-24(s0)
    80005f8a:	00000097          	auipc	ra,0x0
    80005f8e:	f14080e7          	jalr	-236(ra) # 80005e9e <iput>
}
    80005f92:	0001                	nop
    80005f94:	60e2                	ld	ra,24(sp)
    80005f96:	6442                	ld	s0,16(sp)
    80005f98:	6105                	addi	sp,sp,32
    80005f9a:	8082                	ret

0000000080005f9c <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80005f9c:	7139                	addi	sp,sp,-64
    80005f9e:	fc06                	sd	ra,56(sp)
    80005fa0:	f822                	sd	s0,48(sp)
    80005fa2:	0080                	addi	s0,sp,64
    80005fa4:	fca43423          	sd	a0,-56(s0)
    80005fa8:	87ae                	mv	a5,a1
    80005faa:	fcf42223          	sw	a5,-60(s0)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80005fae:	fc442783          	lw	a5,-60(s0)
    80005fb2:	0007871b          	sext.w	a4,a5
    80005fb6:	47ad                	li	a5,11
    80005fb8:	04e7e863          	bltu	a5,a4,80006008 <bmap+0x6c>
    if((addr = ip->addrs[bn]) == 0)
    80005fbc:	fc843703          	ld	a4,-56(s0)
    80005fc0:	fc446783          	lwu	a5,-60(s0)
    80005fc4:	07d1                	addi	a5,a5,20
    80005fc6:	078a                	slli	a5,a5,0x2
    80005fc8:	97ba                	add	a5,a5,a4
    80005fca:	439c                	lw	a5,0(a5)
    80005fcc:	fef42623          	sw	a5,-20(s0)
    80005fd0:	fec42783          	lw	a5,-20(s0)
    80005fd4:	2781                	sext.w	a5,a5
    80005fd6:	e795                	bnez	a5,80006002 <bmap+0x66>
      ip->addrs[bn] = addr = balloc(ip->dev);
    80005fd8:	fc843783          	ld	a5,-56(s0)
    80005fdc:	439c                	lw	a5,0(a5)
    80005fde:	853e                	mv	a0,a5
    80005fe0:	fffff097          	auipc	ra,0xfffff
    80005fe4:	6aa080e7          	jalr	1706(ra) # 8000568a <balloc>
    80005fe8:	87aa                	mv	a5,a0
    80005fea:	fef42623          	sw	a5,-20(s0)
    80005fee:	fc843703          	ld	a4,-56(s0)
    80005ff2:	fc446783          	lwu	a5,-60(s0)
    80005ff6:	07d1                	addi	a5,a5,20
    80005ff8:	078a                	slli	a5,a5,0x2
    80005ffa:	97ba                	add	a5,a5,a4
    80005ffc:	fec42703          	lw	a4,-20(s0)
    80006000:	c398                	sw	a4,0(a5)
    return addr;
    80006002:	fec42783          	lw	a5,-20(s0)
    80006006:	a0e5                	j	800060ee <bmap+0x152>
  }
  bn -= NDIRECT;
    80006008:	fc442783          	lw	a5,-60(s0)
    8000600c:	37d1                	addiw	a5,a5,-12
    8000600e:	fcf42223          	sw	a5,-60(s0)

  if(bn < NINDIRECT){
    80006012:	fc442783          	lw	a5,-60(s0)
    80006016:	0007871b          	sext.w	a4,a5
    8000601a:	0ff00793          	li	a5,255
    8000601e:	0ce7e063          	bltu	a5,a4,800060de <bmap+0x142>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80006022:	fc843783          	ld	a5,-56(s0)
    80006026:	0807a783          	lw	a5,128(a5)
    8000602a:	fef42623          	sw	a5,-20(s0)
    8000602e:	fec42783          	lw	a5,-20(s0)
    80006032:	2781                	sext.w	a5,a5
    80006034:	e395                	bnez	a5,80006058 <bmap+0xbc>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80006036:	fc843783          	ld	a5,-56(s0)
    8000603a:	439c                	lw	a5,0(a5)
    8000603c:	853e                	mv	a0,a5
    8000603e:	fffff097          	auipc	ra,0xfffff
    80006042:	64c080e7          	jalr	1612(ra) # 8000568a <balloc>
    80006046:	87aa                	mv	a5,a0
    80006048:	fef42623          	sw	a5,-20(s0)
    8000604c:	fc843783          	ld	a5,-56(s0)
    80006050:	fec42703          	lw	a4,-20(s0)
    80006054:	08e7a023          	sw	a4,128(a5)
    bp = bread(ip->dev, addr);
    80006058:	fc843783          	ld	a5,-56(s0)
    8000605c:	439c                	lw	a5,0(a5)
    8000605e:	fec42703          	lw	a4,-20(s0)
    80006062:	85ba                	mv	a1,a4
    80006064:	853e                	mv	a0,a5
    80006066:	fffff097          	auipc	ra,0xfffff
    8000606a:	2da080e7          	jalr	730(ra) # 80005340 <bread>
    8000606e:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    80006072:	fe043783          	ld	a5,-32(s0)
    80006076:	05878793          	addi	a5,a5,88
    8000607a:	fcf43c23          	sd	a5,-40(s0)
    if((addr = a[bn]) == 0){
    8000607e:	fc446783          	lwu	a5,-60(s0)
    80006082:	078a                	slli	a5,a5,0x2
    80006084:	fd843703          	ld	a4,-40(s0)
    80006088:	97ba                	add	a5,a5,a4
    8000608a:	439c                	lw	a5,0(a5)
    8000608c:	fef42623          	sw	a5,-20(s0)
    80006090:	fec42783          	lw	a5,-20(s0)
    80006094:	2781                	sext.w	a5,a5
    80006096:	eb9d                	bnez	a5,800060cc <bmap+0x130>
      a[bn] = addr = balloc(ip->dev);
    80006098:	fc843783          	ld	a5,-56(s0)
    8000609c:	439c                	lw	a5,0(a5)
    8000609e:	853e                	mv	a0,a5
    800060a0:	fffff097          	auipc	ra,0xfffff
    800060a4:	5ea080e7          	jalr	1514(ra) # 8000568a <balloc>
    800060a8:	87aa                	mv	a5,a0
    800060aa:	fef42623          	sw	a5,-20(s0)
    800060ae:	fc446783          	lwu	a5,-60(s0)
    800060b2:	078a                	slli	a5,a5,0x2
    800060b4:	fd843703          	ld	a4,-40(s0)
    800060b8:	97ba                	add	a5,a5,a4
    800060ba:	fec42703          	lw	a4,-20(s0)
    800060be:	c398                	sw	a4,0(a5)
      log_write(bp);
    800060c0:	fe043503          	ld	a0,-32(s0)
    800060c4:	00001097          	auipc	ra,0x1
    800060c8:	f92080e7          	jalr	-110(ra) # 80007056 <log_write>
    }
    brelse(bp);
    800060cc:	fe043503          	ld	a0,-32(s0)
    800060d0:	fffff097          	auipc	ra,0xfffff
    800060d4:	312080e7          	jalr	786(ra) # 800053e2 <brelse>
    return addr;
    800060d8:	fec42783          	lw	a5,-20(s0)
    800060dc:	a809                	j	800060ee <bmap+0x152>
  }

  panic("bmap: out of range");
    800060de:	00005517          	auipc	a0,0x5
    800060e2:	5a250513          	addi	a0,a0,1442 # 8000b680 <etext+0x680>
    800060e6:	ffffb097          	auipc	ra,0xffffb
    800060ea:	b94080e7          	jalr	-1132(ra) # 80000c7a <panic>
}
    800060ee:	853e                	mv	a0,a5
    800060f0:	70e2                	ld	ra,56(sp)
    800060f2:	7442                	ld	s0,48(sp)
    800060f4:	6121                	addi	sp,sp,64
    800060f6:	8082                	ret

00000000800060f8 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    800060f8:	7139                	addi	sp,sp,-64
    800060fa:	fc06                	sd	ra,56(sp)
    800060fc:	f822                	sd	s0,48(sp)
    800060fe:	0080                	addi	s0,sp,64
    80006100:	fca43423          	sd	a0,-56(s0)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80006104:	fe042623          	sw	zero,-20(s0)
    80006108:	a899                	j	8000615e <itrunc+0x66>
    if(ip->addrs[i]){
    8000610a:	fc843703          	ld	a4,-56(s0)
    8000610e:	fec42783          	lw	a5,-20(s0)
    80006112:	07d1                	addi	a5,a5,20
    80006114:	078a                	slli	a5,a5,0x2
    80006116:	97ba                	add	a5,a5,a4
    80006118:	439c                	lw	a5,0(a5)
    8000611a:	cf8d                	beqz	a5,80006154 <itrunc+0x5c>
      bfree(ip->dev, ip->addrs[i]);
    8000611c:	fc843783          	ld	a5,-56(s0)
    80006120:	439c                	lw	a5,0(a5)
    80006122:	0007869b          	sext.w	a3,a5
    80006126:	fc843703          	ld	a4,-56(s0)
    8000612a:	fec42783          	lw	a5,-20(s0)
    8000612e:	07d1                	addi	a5,a5,20
    80006130:	078a                	slli	a5,a5,0x2
    80006132:	97ba                	add	a5,a5,a4
    80006134:	439c                	lw	a5,0(a5)
    80006136:	85be                	mv	a1,a5
    80006138:	8536                	mv	a0,a3
    8000613a:	fffff097          	auipc	ra,0xfffff
    8000613e:	6f6080e7          	jalr	1782(ra) # 80005830 <bfree>
      ip->addrs[i] = 0;
    80006142:	fc843703          	ld	a4,-56(s0)
    80006146:	fec42783          	lw	a5,-20(s0)
    8000614a:	07d1                	addi	a5,a5,20
    8000614c:	078a                	slli	a5,a5,0x2
    8000614e:	97ba                	add	a5,a5,a4
    80006150:	0007a023          	sw	zero,0(a5)
  for(i = 0; i < NDIRECT; i++){
    80006154:	fec42783          	lw	a5,-20(s0)
    80006158:	2785                	addiw	a5,a5,1
    8000615a:	fef42623          	sw	a5,-20(s0)
    8000615e:	fec42783          	lw	a5,-20(s0)
    80006162:	0007871b          	sext.w	a4,a5
    80006166:	47ad                	li	a5,11
    80006168:	fae7d1e3          	bge	a5,a4,8000610a <itrunc+0x12>
    }
  }

  if(ip->addrs[NDIRECT]){
    8000616c:	fc843783          	ld	a5,-56(s0)
    80006170:	0807a783          	lw	a5,128(a5)
    80006174:	cbc5                	beqz	a5,80006224 <itrunc+0x12c>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80006176:	fc843783          	ld	a5,-56(s0)
    8000617a:	4398                	lw	a4,0(a5)
    8000617c:	fc843783          	ld	a5,-56(s0)
    80006180:	0807a783          	lw	a5,128(a5)
    80006184:	85be                	mv	a1,a5
    80006186:	853a                	mv	a0,a4
    80006188:	fffff097          	auipc	ra,0xfffff
    8000618c:	1b8080e7          	jalr	440(ra) # 80005340 <bread>
    80006190:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    80006194:	fe043783          	ld	a5,-32(s0)
    80006198:	05878793          	addi	a5,a5,88
    8000619c:	fcf43c23          	sd	a5,-40(s0)
    for(j = 0; j < NINDIRECT; j++){
    800061a0:	fe042423          	sw	zero,-24(s0)
    800061a4:	a081                	j	800061e4 <itrunc+0xec>
      if(a[j])
    800061a6:	fe842783          	lw	a5,-24(s0)
    800061aa:	078a                	slli	a5,a5,0x2
    800061ac:	fd843703          	ld	a4,-40(s0)
    800061b0:	97ba                	add	a5,a5,a4
    800061b2:	439c                	lw	a5,0(a5)
    800061b4:	c39d                	beqz	a5,800061da <itrunc+0xe2>
        bfree(ip->dev, a[j]);
    800061b6:	fc843783          	ld	a5,-56(s0)
    800061ba:	439c                	lw	a5,0(a5)
    800061bc:	0007869b          	sext.w	a3,a5
    800061c0:	fe842783          	lw	a5,-24(s0)
    800061c4:	078a                	slli	a5,a5,0x2
    800061c6:	fd843703          	ld	a4,-40(s0)
    800061ca:	97ba                	add	a5,a5,a4
    800061cc:	439c                	lw	a5,0(a5)
    800061ce:	85be                	mv	a1,a5
    800061d0:	8536                	mv	a0,a3
    800061d2:	fffff097          	auipc	ra,0xfffff
    800061d6:	65e080e7          	jalr	1630(ra) # 80005830 <bfree>
    for(j = 0; j < NINDIRECT; j++){
    800061da:	fe842783          	lw	a5,-24(s0)
    800061de:	2785                	addiw	a5,a5,1
    800061e0:	fef42423          	sw	a5,-24(s0)
    800061e4:	fe842783          	lw	a5,-24(s0)
    800061e8:	873e                	mv	a4,a5
    800061ea:	0ff00793          	li	a5,255
    800061ee:	fae7fce3          	bgeu	a5,a4,800061a6 <itrunc+0xae>
    }
    brelse(bp);
    800061f2:	fe043503          	ld	a0,-32(s0)
    800061f6:	fffff097          	auipc	ra,0xfffff
    800061fa:	1ec080e7          	jalr	492(ra) # 800053e2 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    800061fe:	fc843783          	ld	a5,-56(s0)
    80006202:	439c                	lw	a5,0(a5)
    80006204:	0007871b          	sext.w	a4,a5
    80006208:	fc843783          	ld	a5,-56(s0)
    8000620c:	0807a783          	lw	a5,128(a5)
    80006210:	85be                	mv	a1,a5
    80006212:	853a                	mv	a0,a4
    80006214:	fffff097          	auipc	ra,0xfffff
    80006218:	61c080e7          	jalr	1564(ra) # 80005830 <bfree>
    ip->addrs[NDIRECT] = 0;
    8000621c:	fc843783          	ld	a5,-56(s0)
    80006220:	0807a023          	sw	zero,128(a5)
  }

  ip->size = 0;
    80006224:	fc843783          	ld	a5,-56(s0)
    80006228:	0407a623          	sw	zero,76(a5)
  iupdate(ip);
    8000622c:	fc843503          	ld	a0,-56(s0)
    80006230:	00000097          	auipc	ra,0x0
    80006234:	890080e7          	jalr	-1904(ra) # 80005ac0 <iupdate>
}
    80006238:	0001                	nop
    8000623a:	70e2                	ld	ra,56(sp)
    8000623c:	7442                	ld	s0,48(sp)
    8000623e:	6121                	addi	sp,sp,64
    80006240:	8082                	ret

0000000080006242 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80006242:	1101                	addi	sp,sp,-32
    80006244:	ec22                	sd	s0,24(sp)
    80006246:	1000                	addi	s0,sp,32
    80006248:	fea43423          	sd	a0,-24(s0)
    8000624c:	feb43023          	sd	a1,-32(s0)
  st->dev = ip->dev;
    80006250:	fe843783          	ld	a5,-24(s0)
    80006254:	439c                	lw	a5,0(a5)
    80006256:	0007871b          	sext.w	a4,a5
    8000625a:	fe043783          	ld	a5,-32(s0)
    8000625e:	c398                	sw	a4,0(a5)
  st->ino = ip->inum;
    80006260:	fe843783          	ld	a5,-24(s0)
    80006264:	43d8                	lw	a4,4(a5)
    80006266:	fe043783          	ld	a5,-32(s0)
    8000626a:	c3d8                	sw	a4,4(a5)
  st->type = ip->type;
    8000626c:	fe843783          	ld	a5,-24(s0)
    80006270:	04479703          	lh	a4,68(a5)
    80006274:	fe043783          	ld	a5,-32(s0)
    80006278:	00e79423          	sh	a4,8(a5)
  st->nlink = ip->nlink;
    8000627c:	fe843783          	ld	a5,-24(s0)
    80006280:	04a79703          	lh	a4,74(a5)
    80006284:	fe043783          	ld	a5,-32(s0)
    80006288:	00e79523          	sh	a4,10(a5)
  st->size = ip->size;
    8000628c:	fe843783          	ld	a5,-24(s0)
    80006290:	47fc                	lw	a5,76(a5)
    80006292:	02079713          	slli	a4,a5,0x20
    80006296:	9301                	srli	a4,a4,0x20
    80006298:	fe043783          	ld	a5,-32(s0)
    8000629c:	eb98                	sd	a4,16(a5)
}
    8000629e:	0001                	nop
    800062a0:	6462                	ld	s0,24(sp)
    800062a2:	6105                	addi	sp,sp,32
    800062a4:	8082                	ret

00000000800062a6 <readi>:
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.
int
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    800062a6:	711d                	addi	sp,sp,-96
    800062a8:	ec86                	sd	ra,88(sp)
    800062aa:	e8a2                	sd	s0,80(sp)
    800062ac:	e4a6                	sd	s1,72(sp)
    800062ae:	1080                	addi	s0,sp,96
    800062b0:	faa43c23          	sd	a0,-72(s0)
    800062b4:	87ae                	mv	a5,a1
    800062b6:	fac43423          	sd	a2,-88(s0)
    800062ba:	faf42a23          	sw	a5,-76(s0)
    800062be:	87b6                	mv	a5,a3
    800062c0:	faf42823          	sw	a5,-80(s0)
    800062c4:	87ba                	mv	a5,a4
    800062c6:	faf42223          	sw	a5,-92(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800062ca:	fb843783          	ld	a5,-72(s0)
    800062ce:	47f8                	lw	a4,76(a5)
    800062d0:	fb042783          	lw	a5,-80(s0)
    800062d4:	2781                	sext.w	a5,a5
    800062d6:	00f76f63          	bltu	a4,a5,800062f4 <readi+0x4e>
    800062da:	fb042783          	lw	a5,-80(s0)
    800062de:	873e                	mv	a4,a5
    800062e0:	fa442783          	lw	a5,-92(s0)
    800062e4:	9fb9                	addw	a5,a5,a4
    800062e6:	0007871b          	sext.w	a4,a5
    800062ea:	fb042783          	lw	a5,-80(s0)
    800062ee:	2781                	sext.w	a5,a5
    800062f0:	00f77463          	bgeu	a4,a5,800062f8 <readi+0x52>
    return 0;
    800062f4:	4781                	li	a5,0
    800062f6:	aa15                	j	8000642a <readi+0x184>
  if(off + n > ip->size)
    800062f8:	fb042783          	lw	a5,-80(s0)
    800062fc:	873e                	mv	a4,a5
    800062fe:	fa442783          	lw	a5,-92(s0)
    80006302:	9fb9                	addw	a5,a5,a4
    80006304:	0007871b          	sext.w	a4,a5
    80006308:	fb843783          	ld	a5,-72(s0)
    8000630c:	47fc                	lw	a5,76(a5)
    8000630e:	00e7fa63          	bgeu	a5,a4,80006322 <readi+0x7c>
    n = ip->size - off;
    80006312:	fb843783          	ld	a5,-72(s0)
    80006316:	47fc                	lw	a5,76(a5)
    80006318:	fb042703          	lw	a4,-80(s0)
    8000631c:	9f99                	subw	a5,a5,a4
    8000631e:	faf42223          	sw	a5,-92(s0)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80006322:	fc042e23          	sw	zero,-36(s0)
    80006326:	a0fd                	j	80006414 <readi+0x16e>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80006328:	fb843783          	ld	a5,-72(s0)
    8000632c:	4384                	lw	s1,0(a5)
    8000632e:	fb042783          	lw	a5,-80(s0)
    80006332:	00a7d79b          	srliw	a5,a5,0xa
    80006336:	2781                	sext.w	a5,a5
    80006338:	85be                	mv	a1,a5
    8000633a:	fb843503          	ld	a0,-72(s0)
    8000633e:	00000097          	auipc	ra,0x0
    80006342:	c5e080e7          	jalr	-930(ra) # 80005f9c <bmap>
    80006346:	87aa                	mv	a5,a0
    80006348:	2781                	sext.w	a5,a5
    8000634a:	85be                	mv	a1,a5
    8000634c:	8526                	mv	a0,s1
    8000634e:	fffff097          	auipc	ra,0xfffff
    80006352:	ff2080e7          	jalr	-14(ra) # 80005340 <bread>
    80006356:	fca43823          	sd	a0,-48(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    8000635a:	fb042783          	lw	a5,-80(s0)
    8000635e:	3ff7f793          	andi	a5,a5,1023
    80006362:	2781                	sext.w	a5,a5
    80006364:	40000713          	li	a4,1024
    80006368:	40f707bb          	subw	a5,a4,a5
    8000636c:	2781                	sext.w	a5,a5
    8000636e:	fa442703          	lw	a4,-92(s0)
    80006372:	86ba                	mv	a3,a4
    80006374:	fdc42703          	lw	a4,-36(s0)
    80006378:	40e6873b          	subw	a4,a3,a4
    8000637c:	2701                	sext.w	a4,a4
    8000637e:	863a                	mv	a2,a4
    80006380:	0007869b          	sext.w	a3,a5
    80006384:	0006071b          	sext.w	a4,a2
    80006388:	00d77363          	bgeu	a4,a3,8000638e <readi+0xe8>
    8000638c:	87b2                	mv	a5,a2
    8000638e:	fcf42623          	sw	a5,-52(s0)
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80006392:	fd043783          	ld	a5,-48(s0)
    80006396:	05878713          	addi	a4,a5,88
    8000639a:	fb046783          	lwu	a5,-80(s0)
    8000639e:	3ff7f793          	andi	a5,a5,1023
    800063a2:	973e                	add	a4,a4,a5
    800063a4:	fcc46683          	lwu	a3,-52(s0)
    800063a8:	fb442783          	lw	a5,-76(s0)
    800063ac:	863a                	mv	a2,a4
    800063ae:	fa843583          	ld	a1,-88(s0)
    800063b2:	853e                	mv	a0,a5
    800063b4:	ffffd097          	auipc	ra,0xffffd
    800063b8:	726080e7          	jalr	1830(ra) # 80003ada <either_copyout>
    800063bc:	87aa                	mv	a5,a0
    800063be:	873e                	mv	a4,a5
    800063c0:	57fd                	li	a5,-1
    800063c2:	00f71c63          	bne	a4,a5,800063da <readi+0x134>
      brelse(bp);
    800063c6:	fd043503          	ld	a0,-48(s0)
    800063ca:	fffff097          	auipc	ra,0xfffff
    800063ce:	018080e7          	jalr	24(ra) # 800053e2 <brelse>
      tot = -1;
    800063d2:	57fd                	li	a5,-1
    800063d4:	fcf42e23          	sw	a5,-36(s0)
      break;
    800063d8:	a0b9                	j	80006426 <readi+0x180>
    }
    brelse(bp);
    800063da:	fd043503          	ld	a0,-48(s0)
    800063de:	fffff097          	auipc	ra,0xfffff
    800063e2:	004080e7          	jalr	4(ra) # 800053e2 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800063e6:	fdc42783          	lw	a5,-36(s0)
    800063ea:	873e                	mv	a4,a5
    800063ec:	fcc42783          	lw	a5,-52(s0)
    800063f0:	9fb9                	addw	a5,a5,a4
    800063f2:	fcf42e23          	sw	a5,-36(s0)
    800063f6:	fb042783          	lw	a5,-80(s0)
    800063fa:	873e                	mv	a4,a5
    800063fc:	fcc42783          	lw	a5,-52(s0)
    80006400:	9fb9                	addw	a5,a5,a4
    80006402:	faf42823          	sw	a5,-80(s0)
    80006406:	fcc46783          	lwu	a5,-52(s0)
    8000640a:	fa843703          	ld	a4,-88(s0)
    8000640e:	97ba                	add	a5,a5,a4
    80006410:	faf43423          	sd	a5,-88(s0)
    80006414:	fdc42783          	lw	a5,-36(s0)
    80006418:	873e                	mv	a4,a5
    8000641a:	fa442783          	lw	a5,-92(s0)
    8000641e:	2701                	sext.w	a4,a4
    80006420:	2781                	sext.w	a5,a5
    80006422:	f0f763e3          	bltu	a4,a5,80006328 <readi+0x82>
  }
  return tot;
    80006426:	fdc42783          	lw	a5,-36(s0)
}
    8000642a:	853e                	mv	a0,a5
    8000642c:	60e6                	ld	ra,88(sp)
    8000642e:	6446                	ld	s0,80(sp)
    80006430:	64a6                	ld	s1,72(sp)
    80006432:	6125                	addi	sp,sp,96
    80006434:	8082                	ret

0000000080006436 <writei>:
// Returns the number of bytes successfully written.
// If the return value is less than the requested n,
// there was an error of some kind.
int
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    80006436:	711d                	addi	sp,sp,-96
    80006438:	ec86                	sd	ra,88(sp)
    8000643a:	e8a2                	sd	s0,80(sp)
    8000643c:	e4a6                	sd	s1,72(sp)
    8000643e:	1080                	addi	s0,sp,96
    80006440:	faa43c23          	sd	a0,-72(s0)
    80006444:	87ae                	mv	a5,a1
    80006446:	fac43423          	sd	a2,-88(s0)
    8000644a:	faf42a23          	sw	a5,-76(s0)
    8000644e:	87b6                	mv	a5,a3
    80006450:	faf42823          	sw	a5,-80(s0)
    80006454:	87ba                	mv	a5,a4
    80006456:	faf42223          	sw	a5,-92(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    8000645a:	fb843783          	ld	a5,-72(s0)
    8000645e:	47f8                	lw	a4,76(a5)
    80006460:	fb042783          	lw	a5,-80(s0)
    80006464:	2781                	sext.w	a5,a5
    80006466:	00f76f63          	bltu	a4,a5,80006484 <writei+0x4e>
    8000646a:	fb042783          	lw	a5,-80(s0)
    8000646e:	873e                	mv	a4,a5
    80006470:	fa442783          	lw	a5,-92(s0)
    80006474:	9fb9                	addw	a5,a5,a4
    80006476:	0007871b          	sext.w	a4,a5
    8000647a:	fb042783          	lw	a5,-80(s0)
    8000647e:	2781                	sext.w	a5,a5
    80006480:	00f77463          	bgeu	a4,a5,80006488 <writei+0x52>
    return -1;
    80006484:	57fd                	li	a5,-1
    80006486:	aa89                	j	800065d8 <writei+0x1a2>
  if(off + n > MAXFILE*BSIZE)
    80006488:	fb042783          	lw	a5,-80(s0)
    8000648c:	873e                	mv	a4,a5
    8000648e:	fa442783          	lw	a5,-92(s0)
    80006492:	9fb9                	addw	a5,a5,a4
    80006494:	2781                	sext.w	a5,a5
    80006496:	873e                	mv	a4,a5
    80006498:	000437b7          	lui	a5,0x43
    8000649c:	00e7f463          	bgeu	a5,a4,800064a4 <writei+0x6e>
    return -1;
    800064a0:	57fd                	li	a5,-1
    800064a2:	aa1d                	j	800065d8 <writei+0x1a2>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800064a4:	fc042e23          	sw	zero,-36(s0)
    800064a8:	a8d5                	j	8000659c <writei+0x166>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    800064aa:	fb843783          	ld	a5,-72(s0)
    800064ae:	4384                	lw	s1,0(a5)
    800064b0:	fb042783          	lw	a5,-80(s0)
    800064b4:	00a7d79b          	srliw	a5,a5,0xa
    800064b8:	2781                	sext.w	a5,a5
    800064ba:	85be                	mv	a1,a5
    800064bc:	fb843503          	ld	a0,-72(s0)
    800064c0:	00000097          	auipc	ra,0x0
    800064c4:	adc080e7          	jalr	-1316(ra) # 80005f9c <bmap>
    800064c8:	87aa                	mv	a5,a0
    800064ca:	2781                	sext.w	a5,a5
    800064cc:	85be                	mv	a1,a5
    800064ce:	8526                	mv	a0,s1
    800064d0:	fffff097          	auipc	ra,0xfffff
    800064d4:	e70080e7          	jalr	-400(ra) # 80005340 <bread>
    800064d8:	fca43823          	sd	a0,-48(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    800064dc:	fb042783          	lw	a5,-80(s0)
    800064e0:	3ff7f793          	andi	a5,a5,1023
    800064e4:	2781                	sext.w	a5,a5
    800064e6:	40000713          	li	a4,1024
    800064ea:	40f707bb          	subw	a5,a4,a5
    800064ee:	2781                	sext.w	a5,a5
    800064f0:	fa442703          	lw	a4,-92(s0)
    800064f4:	86ba                	mv	a3,a4
    800064f6:	fdc42703          	lw	a4,-36(s0)
    800064fa:	40e6873b          	subw	a4,a3,a4
    800064fe:	2701                	sext.w	a4,a4
    80006500:	863a                	mv	a2,a4
    80006502:	0007869b          	sext.w	a3,a5
    80006506:	0006071b          	sext.w	a4,a2
    8000650a:	00d77363          	bgeu	a4,a3,80006510 <writei+0xda>
    8000650e:	87b2                	mv	a5,a2
    80006510:	fcf42623          	sw	a5,-52(s0)
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80006514:	fd043783          	ld	a5,-48(s0)
    80006518:	05878713          	addi	a4,a5,88 # 43058 <_entry-0x7ffbcfa8>
    8000651c:	fb046783          	lwu	a5,-80(s0)
    80006520:	3ff7f793          	andi	a5,a5,1023
    80006524:	97ba                	add	a5,a5,a4
    80006526:	fcc46683          	lwu	a3,-52(s0)
    8000652a:	fb442703          	lw	a4,-76(s0)
    8000652e:	fa843603          	ld	a2,-88(s0)
    80006532:	85ba                	mv	a1,a4
    80006534:	853e                	mv	a0,a5
    80006536:	ffffd097          	auipc	ra,0xffffd
    8000653a:	618080e7          	jalr	1560(ra) # 80003b4e <either_copyin>
    8000653e:	87aa                	mv	a5,a0
    80006540:	873e                	mv	a4,a5
    80006542:	57fd                	li	a5,-1
    80006544:	00f71963          	bne	a4,a5,80006556 <writei+0x120>
      brelse(bp);
    80006548:	fd043503          	ld	a0,-48(s0)
    8000654c:	fffff097          	auipc	ra,0xfffff
    80006550:	e96080e7          	jalr	-362(ra) # 800053e2 <brelse>
      break;
    80006554:	a8a9                	j	800065ae <writei+0x178>
    }
    log_write(bp);
    80006556:	fd043503          	ld	a0,-48(s0)
    8000655a:	00001097          	auipc	ra,0x1
    8000655e:	afc080e7          	jalr	-1284(ra) # 80007056 <log_write>
    brelse(bp);
    80006562:	fd043503          	ld	a0,-48(s0)
    80006566:	fffff097          	auipc	ra,0xfffff
    8000656a:	e7c080e7          	jalr	-388(ra) # 800053e2 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000656e:	fdc42783          	lw	a5,-36(s0)
    80006572:	873e                	mv	a4,a5
    80006574:	fcc42783          	lw	a5,-52(s0)
    80006578:	9fb9                	addw	a5,a5,a4
    8000657a:	fcf42e23          	sw	a5,-36(s0)
    8000657e:	fb042783          	lw	a5,-80(s0)
    80006582:	873e                	mv	a4,a5
    80006584:	fcc42783          	lw	a5,-52(s0)
    80006588:	9fb9                	addw	a5,a5,a4
    8000658a:	faf42823          	sw	a5,-80(s0)
    8000658e:	fcc46783          	lwu	a5,-52(s0)
    80006592:	fa843703          	ld	a4,-88(s0)
    80006596:	97ba                	add	a5,a5,a4
    80006598:	faf43423          	sd	a5,-88(s0)
    8000659c:	fdc42783          	lw	a5,-36(s0)
    800065a0:	873e                	mv	a4,a5
    800065a2:	fa442783          	lw	a5,-92(s0)
    800065a6:	2701                	sext.w	a4,a4
    800065a8:	2781                	sext.w	a5,a5
    800065aa:	f0f760e3          	bltu	a4,a5,800064aa <writei+0x74>
  }

  if(off > ip->size)
    800065ae:	fb843783          	ld	a5,-72(s0)
    800065b2:	47f8                	lw	a4,76(a5)
    800065b4:	fb042783          	lw	a5,-80(s0)
    800065b8:	2781                	sext.w	a5,a5
    800065ba:	00f77763          	bgeu	a4,a5,800065c8 <writei+0x192>
    ip->size = off;
    800065be:	fb843783          	ld	a5,-72(s0)
    800065c2:	fb042703          	lw	a4,-80(s0)
    800065c6:	c7f8                	sw	a4,76(a5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    800065c8:	fb843503          	ld	a0,-72(s0)
    800065cc:	fffff097          	auipc	ra,0xfffff
    800065d0:	4f4080e7          	jalr	1268(ra) # 80005ac0 <iupdate>

  return tot;
    800065d4:	fdc42783          	lw	a5,-36(s0)
}
    800065d8:	853e                	mv	a0,a5
    800065da:	60e6                	ld	ra,88(sp)
    800065dc:	6446                	ld	s0,80(sp)
    800065de:	64a6                	ld	s1,72(sp)
    800065e0:	6125                	addi	sp,sp,96
    800065e2:	8082                	ret

00000000800065e4 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    800065e4:	1101                	addi	sp,sp,-32
    800065e6:	ec06                	sd	ra,24(sp)
    800065e8:	e822                	sd	s0,16(sp)
    800065ea:	1000                	addi	s0,sp,32
    800065ec:	fea43423          	sd	a0,-24(s0)
    800065f0:	feb43023          	sd	a1,-32(s0)
  return strncmp(s, t, DIRSIZ);
    800065f4:	4639                	li	a2,14
    800065f6:	fe043583          	ld	a1,-32(s0)
    800065fa:	fe843503          	ld	a0,-24(s0)
    800065fe:	ffffb097          	auipc	ra,0xffffb
    80006602:	038080e7          	jalr	56(ra) # 80001636 <strncmp>
    80006606:	87aa                	mv	a5,a0
}
    80006608:	853e                	mv	a0,a5
    8000660a:	60e2                	ld	ra,24(sp)
    8000660c:	6442                	ld	s0,16(sp)
    8000660e:	6105                	addi	sp,sp,32
    80006610:	8082                	ret

0000000080006612 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80006612:	715d                	addi	sp,sp,-80
    80006614:	e486                	sd	ra,72(sp)
    80006616:	e0a2                	sd	s0,64(sp)
    80006618:	0880                	addi	s0,sp,80
    8000661a:	fca43423          	sd	a0,-56(s0)
    8000661e:	fcb43023          	sd	a1,-64(s0)
    80006622:	fac43c23          	sd	a2,-72(s0)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80006626:	fc843783          	ld	a5,-56(s0)
    8000662a:	04479783          	lh	a5,68(a5)
    8000662e:	0007871b          	sext.w	a4,a5
    80006632:	4785                	li	a5,1
    80006634:	00f70a63          	beq	a4,a5,80006648 <dirlookup+0x36>
    panic("dirlookup not DIR");
    80006638:	00005517          	auipc	a0,0x5
    8000663c:	06050513          	addi	a0,a0,96 # 8000b698 <etext+0x698>
    80006640:	ffffa097          	auipc	ra,0xffffa
    80006644:	63a080e7          	jalr	1594(ra) # 80000c7a <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
    80006648:	fe042623          	sw	zero,-20(s0)
    8000664c:	a849                	j	800066de <dirlookup+0xcc>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000664e:	fd840793          	addi	a5,s0,-40
    80006652:	fec42683          	lw	a3,-20(s0)
    80006656:	4741                	li	a4,16
    80006658:	863e                	mv	a2,a5
    8000665a:	4581                	li	a1,0
    8000665c:	fc843503          	ld	a0,-56(s0)
    80006660:	00000097          	auipc	ra,0x0
    80006664:	c46080e7          	jalr	-954(ra) # 800062a6 <readi>
    80006668:	87aa                	mv	a5,a0
    8000666a:	873e                	mv	a4,a5
    8000666c:	47c1                	li	a5,16
    8000666e:	00f70a63          	beq	a4,a5,80006682 <dirlookup+0x70>
      panic("dirlookup read");
    80006672:	00005517          	auipc	a0,0x5
    80006676:	03e50513          	addi	a0,a0,62 # 8000b6b0 <etext+0x6b0>
    8000667a:	ffffa097          	auipc	ra,0xffffa
    8000667e:	600080e7          	jalr	1536(ra) # 80000c7a <panic>
    if(de.inum == 0)
    80006682:	fd845783          	lhu	a5,-40(s0)
    80006686:	c7b1                	beqz	a5,800066d2 <dirlookup+0xc0>
      continue;
    if(namecmp(name, de.name) == 0){
    80006688:	fd840793          	addi	a5,s0,-40
    8000668c:	0789                	addi	a5,a5,2
    8000668e:	85be                	mv	a1,a5
    80006690:	fc043503          	ld	a0,-64(s0)
    80006694:	00000097          	auipc	ra,0x0
    80006698:	f50080e7          	jalr	-176(ra) # 800065e4 <namecmp>
    8000669c:	87aa                	mv	a5,a0
    8000669e:	eb9d                	bnez	a5,800066d4 <dirlookup+0xc2>
      // entry matches path element
      if(poff)
    800066a0:	fb843783          	ld	a5,-72(s0)
    800066a4:	c791                	beqz	a5,800066b0 <dirlookup+0x9e>
        *poff = off;
    800066a6:	fb843783          	ld	a5,-72(s0)
    800066aa:	fec42703          	lw	a4,-20(s0)
    800066ae:	c398                	sw	a4,0(a5)
      inum = de.inum;
    800066b0:	fd845783          	lhu	a5,-40(s0)
    800066b4:	fef42423          	sw	a5,-24(s0)
      return iget(dp->dev, inum);
    800066b8:	fc843783          	ld	a5,-56(s0)
    800066bc:	439c                	lw	a5,0(a5)
    800066be:	fe842703          	lw	a4,-24(s0)
    800066c2:	85ba                	mv	a1,a4
    800066c4:	853e                	mv	a0,a5
    800066c6:	fffff097          	auipc	ra,0xfffff
    800066ca:	4e2080e7          	jalr	1250(ra) # 80005ba8 <iget>
    800066ce:	87aa                	mv	a5,a0
    800066d0:	a005                	j	800066f0 <dirlookup+0xde>
      continue;
    800066d2:	0001                	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
    800066d4:	fec42783          	lw	a5,-20(s0)
    800066d8:	27c1                	addiw	a5,a5,16
    800066da:	fef42623          	sw	a5,-20(s0)
    800066de:	fc843783          	ld	a5,-56(s0)
    800066e2:	47f8                	lw	a4,76(a5)
    800066e4:	fec42783          	lw	a5,-20(s0)
    800066e8:	2781                	sext.w	a5,a5
    800066ea:	f6e7e2e3          	bltu	a5,a4,8000664e <dirlookup+0x3c>
    }
  }

  return 0;
    800066ee:	4781                	li	a5,0
}
    800066f0:	853e                	mv	a0,a5
    800066f2:	60a6                	ld	ra,72(sp)
    800066f4:	6406                	ld	s0,64(sp)
    800066f6:	6161                	addi	sp,sp,80
    800066f8:	8082                	ret

00000000800066fa <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
    800066fa:	715d                	addi	sp,sp,-80
    800066fc:	e486                	sd	ra,72(sp)
    800066fe:	e0a2                	sd	s0,64(sp)
    80006700:	0880                	addi	s0,sp,80
    80006702:	fca43423          	sd	a0,-56(s0)
    80006706:	fcb43023          	sd	a1,-64(s0)
    8000670a:	87b2                	mv	a5,a2
    8000670c:	faf42e23          	sw	a5,-68(s0)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    80006710:	4601                	li	a2,0
    80006712:	fc043583          	ld	a1,-64(s0)
    80006716:	fc843503          	ld	a0,-56(s0)
    8000671a:	00000097          	auipc	ra,0x0
    8000671e:	ef8080e7          	jalr	-264(ra) # 80006612 <dirlookup>
    80006722:	fea43023          	sd	a0,-32(s0)
    80006726:	fe043783          	ld	a5,-32(s0)
    8000672a:	cb89                	beqz	a5,8000673c <dirlink+0x42>
    iput(ip);
    8000672c:	fe043503          	ld	a0,-32(s0)
    80006730:	fffff097          	auipc	ra,0xfffff
    80006734:	76e080e7          	jalr	1902(ra) # 80005e9e <iput>
    return -1;
    80006738:	57fd                	li	a5,-1
    8000673a:	a865                	j	800067f2 <dirlink+0xf8>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000673c:	fe042623          	sw	zero,-20(s0)
    80006740:	a0a1                	j	80006788 <dirlink+0x8e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80006742:	fd040793          	addi	a5,s0,-48
    80006746:	fec42683          	lw	a3,-20(s0)
    8000674a:	4741                	li	a4,16
    8000674c:	863e                	mv	a2,a5
    8000674e:	4581                	li	a1,0
    80006750:	fc843503          	ld	a0,-56(s0)
    80006754:	00000097          	auipc	ra,0x0
    80006758:	b52080e7          	jalr	-1198(ra) # 800062a6 <readi>
    8000675c:	87aa                	mv	a5,a0
    8000675e:	873e                	mv	a4,a5
    80006760:	47c1                	li	a5,16
    80006762:	00f70a63          	beq	a4,a5,80006776 <dirlink+0x7c>
      panic("dirlink read");
    80006766:	00005517          	auipc	a0,0x5
    8000676a:	f5a50513          	addi	a0,a0,-166 # 8000b6c0 <etext+0x6c0>
    8000676e:	ffffa097          	auipc	ra,0xffffa
    80006772:	50c080e7          	jalr	1292(ra) # 80000c7a <panic>
    if(de.inum == 0)
    80006776:	fd045783          	lhu	a5,-48(s0)
    8000677a:	cf99                	beqz	a5,80006798 <dirlink+0x9e>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000677c:	fec42783          	lw	a5,-20(s0)
    80006780:	27c1                	addiw	a5,a5,16
    80006782:	2781                	sext.w	a5,a5
    80006784:	fef42623          	sw	a5,-20(s0)
    80006788:	fc843783          	ld	a5,-56(s0)
    8000678c:	47f8                	lw	a4,76(a5)
    8000678e:	fec42783          	lw	a5,-20(s0)
    80006792:	fae7e8e3          	bltu	a5,a4,80006742 <dirlink+0x48>
    80006796:	a011                	j	8000679a <dirlink+0xa0>
      break;
    80006798:	0001                	nop
  }

  strncpy(de.name, name, DIRSIZ);
    8000679a:	fd040793          	addi	a5,s0,-48
    8000679e:	0789                	addi	a5,a5,2
    800067a0:	4639                	li	a2,14
    800067a2:	fc043583          	ld	a1,-64(s0)
    800067a6:	853e                	mv	a0,a5
    800067a8:	ffffb097          	auipc	ra,0xffffb
    800067ac:	f18080e7          	jalr	-232(ra) # 800016c0 <strncpy>
  de.inum = inum;
    800067b0:	fbc42783          	lw	a5,-68(s0)
    800067b4:	17c2                	slli	a5,a5,0x30
    800067b6:	93c1                	srli	a5,a5,0x30
    800067b8:	fcf41823          	sh	a5,-48(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800067bc:	fd040793          	addi	a5,s0,-48
    800067c0:	fec42683          	lw	a3,-20(s0)
    800067c4:	4741                	li	a4,16
    800067c6:	863e                	mv	a2,a5
    800067c8:	4581                	li	a1,0
    800067ca:	fc843503          	ld	a0,-56(s0)
    800067ce:	00000097          	auipc	ra,0x0
    800067d2:	c68080e7          	jalr	-920(ra) # 80006436 <writei>
    800067d6:	87aa                	mv	a5,a0
    800067d8:	873e                	mv	a4,a5
    800067da:	47c1                	li	a5,16
    800067dc:	00f70a63          	beq	a4,a5,800067f0 <dirlink+0xf6>
    panic("dirlink");
    800067e0:	00005517          	auipc	a0,0x5
    800067e4:	ef050513          	addi	a0,a0,-272 # 8000b6d0 <etext+0x6d0>
    800067e8:	ffffa097          	auipc	ra,0xffffa
    800067ec:	492080e7          	jalr	1170(ra) # 80000c7a <panic>

  return 0;
    800067f0:	4781                	li	a5,0
}
    800067f2:	853e                	mv	a0,a5
    800067f4:	60a6                	ld	ra,72(sp)
    800067f6:	6406                	ld	s0,64(sp)
    800067f8:	6161                	addi	sp,sp,80
    800067fa:	8082                	ret

00000000800067fc <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
    800067fc:	7179                	addi	sp,sp,-48
    800067fe:	f406                	sd	ra,40(sp)
    80006800:	f022                	sd	s0,32(sp)
    80006802:	1800                	addi	s0,sp,48
    80006804:	fca43c23          	sd	a0,-40(s0)
    80006808:	fcb43823          	sd	a1,-48(s0)
  char *s;
  int len;

  while(*path == '/')
    8000680c:	a031                	j	80006818 <skipelem+0x1c>
    path++;
    8000680e:	fd843783          	ld	a5,-40(s0)
    80006812:	0785                	addi	a5,a5,1
    80006814:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80006818:	fd843783          	ld	a5,-40(s0)
    8000681c:	0007c783          	lbu	a5,0(a5)
    80006820:	873e                	mv	a4,a5
    80006822:	02f00793          	li	a5,47
    80006826:	fef704e3          	beq	a4,a5,8000680e <skipelem+0x12>
  if(*path == 0)
    8000682a:	fd843783          	ld	a5,-40(s0)
    8000682e:	0007c783          	lbu	a5,0(a5)
    80006832:	e399                	bnez	a5,80006838 <skipelem+0x3c>
    return 0;
    80006834:	4781                	li	a5,0
    80006836:	a06d                	j	800068e0 <skipelem+0xe4>
  s = path;
    80006838:	fd843783          	ld	a5,-40(s0)
    8000683c:	fef43423          	sd	a5,-24(s0)
  while(*path != '/' && *path != 0)
    80006840:	a031                	j	8000684c <skipelem+0x50>
    path++;
    80006842:	fd843783          	ld	a5,-40(s0)
    80006846:	0785                	addi	a5,a5,1
    80006848:	fcf43c23          	sd	a5,-40(s0)
  while(*path != '/' && *path != 0)
    8000684c:	fd843783          	ld	a5,-40(s0)
    80006850:	0007c783          	lbu	a5,0(a5)
    80006854:	873e                	mv	a4,a5
    80006856:	02f00793          	li	a5,47
    8000685a:	00f70763          	beq	a4,a5,80006868 <skipelem+0x6c>
    8000685e:	fd843783          	ld	a5,-40(s0)
    80006862:	0007c783          	lbu	a5,0(a5)
    80006866:	fff1                	bnez	a5,80006842 <skipelem+0x46>
  len = path - s;
    80006868:	fd843703          	ld	a4,-40(s0)
    8000686c:	fe843783          	ld	a5,-24(s0)
    80006870:	40f707b3          	sub	a5,a4,a5
    80006874:	fef42223          	sw	a5,-28(s0)
  if(len >= DIRSIZ)
    80006878:	fe442783          	lw	a5,-28(s0)
    8000687c:	0007871b          	sext.w	a4,a5
    80006880:	47b5                	li	a5,13
    80006882:	00e7dc63          	bge	a5,a4,8000689a <skipelem+0x9e>
    memmove(name, s, DIRSIZ);
    80006886:	4639                	li	a2,14
    80006888:	fe843583          	ld	a1,-24(s0)
    8000688c:	fd043503          	ld	a0,-48(s0)
    80006890:	ffffb097          	auipc	ra,0xffffb
    80006894:	c92080e7          	jalr	-878(ra) # 80001522 <memmove>
    80006898:	a80d                	j	800068ca <skipelem+0xce>
  else {
    memmove(name, s, len);
    8000689a:	fe442783          	lw	a5,-28(s0)
    8000689e:	863e                	mv	a2,a5
    800068a0:	fe843583          	ld	a1,-24(s0)
    800068a4:	fd043503          	ld	a0,-48(s0)
    800068a8:	ffffb097          	auipc	ra,0xffffb
    800068ac:	c7a080e7          	jalr	-902(ra) # 80001522 <memmove>
    name[len] = 0;
    800068b0:	fe442783          	lw	a5,-28(s0)
    800068b4:	fd043703          	ld	a4,-48(s0)
    800068b8:	97ba                	add	a5,a5,a4
    800068ba:	00078023          	sb	zero,0(a5)
  }
  while(*path == '/')
    800068be:	a031                	j	800068ca <skipelem+0xce>
    path++;
    800068c0:	fd843783          	ld	a5,-40(s0)
    800068c4:	0785                	addi	a5,a5,1
    800068c6:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    800068ca:	fd843783          	ld	a5,-40(s0)
    800068ce:	0007c783          	lbu	a5,0(a5)
    800068d2:	873e                	mv	a4,a5
    800068d4:	02f00793          	li	a5,47
    800068d8:	fef704e3          	beq	a4,a5,800068c0 <skipelem+0xc4>
  return path;
    800068dc:	fd843783          	ld	a5,-40(s0)
}
    800068e0:	853e                	mv	a0,a5
    800068e2:	70a2                	ld	ra,40(sp)
    800068e4:	7402                	ld	s0,32(sp)
    800068e6:	6145                	addi	sp,sp,48
    800068e8:	8082                	ret

00000000800068ea <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    800068ea:	7139                	addi	sp,sp,-64
    800068ec:	fc06                	sd	ra,56(sp)
    800068ee:	f822                	sd	s0,48(sp)
    800068f0:	0080                	addi	s0,sp,64
    800068f2:	fca43c23          	sd	a0,-40(s0)
    800068f6:	87ae                	mv	a5,a1
    800068f8:	fcc43423          	sd	a2,-56(s0)
    800068fc:	fcf42a23          	sw	a5,-44(s0)
  struct inode *ip, *next;

  if(*path == '/')
    80006900:	fd843783          	ld	a5,-40(s0)
    80006904:	0007c783          	lbu	a5,0(a5)
    80006908:	873e                	mv	a4,a5
    8000690a:	02f00793          	li	a5,47
    8000690e:	00f71b63          	bne	a4,a5,80006924 <namex+0x3a>
    ip = iget(ROOTDEV, ROOTINO);
    80006912:	4585                	li	a1,1
    80006914:	4505                	li	a0,1
    80006916:	fffff097          	auipc	ra,0xfffff
    8000691a:	292080e7          	jalr	658(ra) # 80005ba8 <iget>
    8000691e:	fea43423          	sd	a0,-24(s0)
    80006922:	a84d                	j	800069d4 <namex+0xea>
  else
    ip = idup(myproc()->cwd);
    80006924:	ffffc097          	auipc	ra,0xffffc
    80006928:	0f4080e7          	jalr	244(ra) # 80002a18 <myproc>
    8000692c:	87aa                	mv	a5,a0
    8000692e:	1607b783          	ld	a5,352(a5)
    80006932:	853e                	mv	a0,a5
    80006934:	fffff097          	auipc	ra,0xfffff
    80006938:	390080e7          	jalr	912(ra) # 80005cc4 <idup>
    8000693c:	fea43423          	sd	a0,-24(s0)

  while((path = skipelem(path, name)) != 0){
    80006940:	a851                	j	800069d4 <namex+0xea>
    ilock(ip);
    80006942:	fe843503          	ld	a0,-24(s0)
    80006946:	fffff097          	auipc	ra,0xfffff
    8000694a:	3ca080e7          	jalr	970(ra) # 80005d10 <ilock>
    if(ip->type != T_DIR){
    8000694e:	fe843783          	ld	a5,-24(s0)
    80006952:	04479783          	lh	a5,68(a5)
    80006956:	0007871b          	sext.w	a4,a5
    8000695a:	4785                	li	a5,1
    8000695c:	00f70a63          	beq	a4,a5,80006970 <namex+0x86>
      iunlockput(ip);
    80006960:	fe843503          	ld	a0,-24(s0)
    80006964:	fffff097          	auipc	ra,0xfffff
    80006968:	60a080e7          	jalr	1546(ra) # 80005f6e <iunlockput>
      return 0;
    8000696c:	4781                	li	a5,0
    8000696e:	a871                	j	80006a0a <namex+0x120>
    }
    if(nameiparent && *path == '\0'){
    80006970:	fd442783          	lw	a5,-44(s0)
    80006974:	2781                	sext.w	a5,a5
    80006976:	cf99                	beqz	a5,80006994 <namex+0xaa>
    80006978:	fd843783          	ld	a5,-40(s0)
    8000697c:	0007c783          	lbu	a5,0(a5)
    80006980:	eb91                	bnez	a5,80006994 <namex+0xaa>
      // Stop one level early.
      iunlock(ip);
    80006982:	fe843503          	ld	a0,-24(s0)
    80006986:	fffff097          	auipc	ra,0xfffff
    8000698a:	4be080e7          	jalr	1214(ra) # 80005e44 <iunlock>
      return ip;
    8000698e:	fe843783          	ld	a5,-24(s0)
    80006992:	a8a5                	j	80006a0a <namex+0x120>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
    80006994:	4601                	li	a2,0
    80006996:	fc843583          	ld	a1,-56(s0)
    8000699a:	fe843503          	ld	a0,-24(s0)
    8000699e:	00000097          	auipc	ra,0x0
    800069a2:	c74080e7          	jalr	-908(ra) # 80006612 <dirlookup>
    800069a6:	fea43023          	sd	a0,-32(s0)
    800069aa:	fe043783          	ld	a5,-32(s0)
    800069ae:	eb89                	bnez	a5,800069c0 <namex+0xd6>
      iunlockput(ip);
    800069b0:	fe843503          	ld	a0,-24(s0)
    800069b4:	fffff097          	auipc	ra,0xfffff
    800069b8:	5ba080e7          	jalr	1466(ra) # 80005f6e <iunlockput>
      return 0;
    800069bc:	4781                	li	a5,0
    800069be:	a0b1                	j	80006a0a <namex+0x120>
    }
    iunlockput(ip);
    800069c0:	fe843503          	ld	a0,-24(s0)
    800069c4:	fffff097          	auipc	ra,0xfffff
    800069c8:	5aa080e7          	jalr	1450(ra) # 80005f6e <iunlockput>
    ip = next;
    800069cc:	fe043783          	ld	a5,-32(s0)
    800069d0:	fef43423          	sd	a5,-24(s0)
  while((path = skipelem(path, name)) != 0){
    800069d4:	fc843583          	ld	a1,-56(s0)
    800069d8:	fd843503          	ld	a0,-40(s0)
    800069dc:	00000097          	auipc	ra,0x0
    800069e0:	e20080e7          	jalr	-480(ra) # 800067fc <skipelem>
    800069e4:	fca43c23          	sd	a0,-40(s0)
    800069e8:	fd843783          	ld	a5,-40(s0)
    800069ec:	fbb9                	bnez	a5,80006942 <namex+0x58>
  }
  if(nameiparent){
    800069ee:	fd442783          	lw	a5,-44(s0)
    800069f2:	2781                	sext.w	a5,a5
    800069f4:	cb89                	beqz	a5,80006a06 <namex+0x11c>
    iput(ip);
    800069f6:	fe843503          	ld	a0,-24(s0)
    800069fa:	fffff097          	auipc	ra,0xfffff
    800069fe:	4a4080e7          	jalr	1188(ra) # 80005e9e <iput>
    return 0;
    80006a02:	4781                	li	a5,0
    80006a04:	a019                	j	80006a0a <namex+0x120>
  }
  return ip;
    80006a06:	fe843783          	ld	a5,-24(s0)
}
    80006a0a:	853e                	mv	a0,a5
    80006a0c:	70e2                	ld	ra,56(sp)
    80006a0e:	7442                	ld	s0,48(sp)
    80006a10:	6121                	addi	sp,sp,64
    80006a12:	8082                	ret

0000000080006a14 <namei>:

struct inode*
namei(char *path)
{
    80006a14:	7179                	addi	sp,sp,-48
    80006a16:	f406                	sd	ra,40(sp)
    80006a18:	f022                	sd	s0,32(sp)
    80006a1a:	1800                	addi	s0,sp,48
    80006a1c:	fca43c23          	sd	a0,-40(s0)
  char name[DIRSIZ];
  return namex(path, 0, name);
    80006a20:	fe040793          	addi	a5,s0,-32
    80006a24:	863e                	mv	a2,a5
    80006a26:	4581                	li	a1,0
    80006a28:	fd843503          	ld	a0,-40(s0)
    80006a2c:	00000097          	auipc	ra,0x0
    80006a30:	ebe080e7          	jalr	-322(ra) # 800068ea <namex>
    80006a34:	87aa                	mv	a5,a0
}
    80006a36:	853e                	mv	a0,a5
    80006a38:	70a2                	ld	ra,40(sp)
    80006a3a:	7402                	ld	s0,32(sp)
    80006a3c:	6145                	addi	sp,sp,48
    80006a3e:	8082                	ret

0000000080006a40 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80006a40:	1101                	addi	sp,sp,-32
    80006a42:	ec06                	sd	ra,24(sp)
    80006a44:	e822                	sd	s0,16(sp)
    80006a46:	1000                	addi	s0,sp,32
    80006a48:	fea43423          	sd	a0,-24(s0)
    80006a4c:	feb43023          	sd	a1,-32(s0)
  return namex(path, 1, name);
    80006a50:	fe043603          	ld	a2,-32(s0)
    80006a54:	4585                	li	a1,1
    80006a56:	fe843503          	ld	a0,-24(s0)
    80006a5a:	00000097          	auipc	ra,0x0
    80006a5e:	e90080e7          	jalr	-368(ra) # 800068ea <namex>
    80006a62:	87aa                	mv	a5,a0
}
    80006a64:	853e                	mv	a0,a5
    80006a66:	60e2                	ld	ra,24(sp)
    80006a68:	6442                	ld	s0,16(sp)
    80006a6a:	6105                	addi	sp,sp,32
    80006a6c:	8082                	ret

0000000080006a6e <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev, struct superblock *sb)
{
    80006a6e:	1101                	addi	sp,sp,-32
    80006a70:	ec06                	sd	ra,24(sp)
    80006a72:	e822                	sd	s0,16(sp)
    80006a74:	1000                	addi	s0,sp,32
    80006a76:	87aa                	mv	a5,a0
    80006a78:	feb43023          	sd	a1,-32(s0)
    80006a7c:	fef42623          	sw	a5,-20(s0)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  initlock(&log.lock, "log");
    80006a80:	00005597          	auipc	a1,0x5
    80006a84:	c5858593          	addi	a1,a1,-936 # 8000b6d8 <etext+0x6d8>
    80006a88:	0049e517          	auipc	a0,0x49e
    80006a8c:	1e050513          	addi	a0,a0,480 # 804a4c68 <log>
    80006a90:	ffffa097          	auipc	ra,0xffffa
    80006a94:	7aa080e7          	jalr	1962(ra) # 8000123a <initlock>
  log.start = sb->logstart;
    80006a98:	fe043783          	ld	a5,-32(s0)
    80006a9c:	4bdc                	lw	a5,20(a5)
    80006a9e:	0007871b          	sext.w	a4,a5
    80006aa2:	0049e797          	auipc	a5,0x49e
    80006aa6:	1c678793          	addi	a5,a5,454 # 804a4c68 <log>
    80006aaa:	cf98                	sw	a4,24(a5)
  log.size = sb->nlog;
    80006aac:	fe043783          	ld	a5,-32(s0)
    80006ab0:	4b9c                	lw	a5,16(a5)
    80006ab2:	0007871b          	sext.w	a4,a5
    80006ab6:	0049e797          	auipc	a5,0x49e
    80006aba:	1b278793          	addi	a5,a5,434 # 804a4c68 <log>
    80006abe:	cfd8                	sw	a4,28(a5)
  log.dev = dev;
    80006ac0:	0049e797          	auipc	a5,0x49e
    80006ac4:	1a878793          	addi	a5,a5,424 # 804a4c68 <log>
    80006ac8:	fec42703          	lw	a4,-20(s0)
    80006acc:	d798                	sw	a4,40(a5)
  recover_from_log();
    80006ace:	00000097          	auipc	ra,0x0
    80006ad2:	272080e7          	jalr	626(ra) # 80006d40 <recover_from_log>
}
    80006ad6:	0001                	nop
    80006ad8:	60e2                	ld	ra,24(sp)
    80006ada:	6442                	ld	s0,16(sp)
    80006adc:	6105                	addi	sp,sp,32
    80006ade:	8082                	ret

0000000080006ae0 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(int recovering)
{
    80006ae0:	7139                	addi	sp,sp,-64
    80006ae2:	fc06                	sd	ra,56(sp)
    80006ae4:	f822                	sd	s0,48(sp)
    80006ae6:	0080                	addi	s0,sp,64
    80006ae8:	87aa                	mv	a5,a0
    80006aea:	fcf42623          	sw	a5,-52(s0)
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    80006aee:	fe042623          	sw	zero,-20(s0)
    80006af2:	a0f9                	j	80006bc0 <install_trans+0xe0>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80006af4:	0049e797          	auipc	a5,0x49e
    80006af8:	17478793          	addi	a5,a5,372 # 804a4c68 <log>
    80006afc:	579c                	lw	a5,40(a5)
    80006afe:	0007871b          	sext.w	a4,a5
    80006b02:	0049e797          	auipc	a5,0x49e
    80006b06:	16678793          	addi	a5,a5,358 # 804a4c68 <log>
    80006b0a:	4f9c                	lw	a5,24(a5)
    80006b0c:	fec42683          	lw	a3,-20(s0)
    80006b10:	9fb5                	addw	a5,a5,a3
    80006b12:	2781                	sext.w	a5,a5
    80006b14:	2785                	addiw	a5,a5,1
    80006b16:	2781                	sext.w	a5,a5
    80006b18:	2781                	sext.w	a5,a5
    80006b1a:	85be                	mv	a1,a5
    80006b1c:	853a                	mv	a0,a4
    80006b1e:	fffff097          	auipc	ra,0xfffff
    80006b22:	822080e7          	jalr	-2014(ra) # 80005340 <bread>
    80006b26:	fea43023          	sd	a0,-32(s0)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80006b2a:	0049e797          	auipc	a5,0x49e
    80006b2e:	13e78793          	addi	a5,a5,318 # 804a4c68 <log>
    80006b32:	579c                	lw	a5,40(a5)
    80006b34:	0007869b          	sext.w	a3,a5
    80006b38:	0049e717          	auipc	a4,0x49e
    80006b3c:	13070713          	addi	a4,a4,304 # 804a4c68 <log>
    80006b40:	fec42783          	lw	a5,-20(s0)
    80006b44:	07a1                	addi	a5,a5,8
    80006b46:	078a                	slli	a5,a5,0x2
    80006b48:	97ba                	add	a5,a5,a4
    80006b4a:	4b9c                	lw	a5,16(a5)
    80006b4c:	2781                	sext.w	a5,a5
    80006b4e:	85be                	mv	a1,a5
    80006b50:	8536                	mv	a0,a3
    80006b52:	ffffe097          	auipc	ra,0xffffe
    80006b56:	7ee080e7          	jalr	2030(ra) # 80005340 <bread>
    80006b5a:	fca43c23          	sd	a0,-40(s0)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80006b5e:	fd843783          	ld	a5,-40(s0)
    80006b62:	05878713          	addi	a4,a5,88
    80006b66:	fe043783          	ld	a5,-32(s0)
    80006b6a:	05878793          	addi	a5,a5,88
    80006b6e:	40000613          	li	a2,1024
    80006b72:	85be                	mv	a1,a5
    80006b74:	853a                	mv	a0,a4
    80006b76:	ffffb097          	auipc	ra,0xffffb
    80006b7a:	9ac080e7          	jalr	-1620(ra) # 80001522 <memmove>
    bwrite(dbuf);  // write dst to disk
    80006b7e:	fd843503          	ld	a0,-40(s0)
    80006b82:	fffff097          	auipc	ra,0xfffff
    80006b86:	818080e7          	jalr	-2024(ra) # 8000539a <bwrite>
    if(recovering == 0)
    80006b8a:	fcc42783          	lw	a5,-52(s0)
    80006b8e:	2781                	sext.w	a5,a5
    80006b90:	e799                	bnez	a5,80006b9e <install_trans+0xbe>
      bunpin(dbuf);
    80006b92:	fd843503          	ld	a0,-40(s0)
    80006b96:	fffff097          	auipc	ra,0xfffff
    80006b9a:	982080e7          	jalr	-1662(ra) # 80005518 <bunpin>
    brelse(lbuf);
    80006b9e:	fe043503          	ld	a0,-32(s0)
    80006ba2:	fffff097          	auipc	ra,0xfffff
    80006ba6:	840080e7          	jalr	-1984(ra) # 800053e2 <brelse>
    brelse(dbuf);
    80006baa:	fd843503          	ld	a0,-40(s0)
    80006bae:	fffff097          	auipc	ra,0xfffff
    80006bb2:	834080e7          	jalr	-1996(ra) # 800053e2 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80006bb6:	fec42783          	lw	a5,-20(s0)
    80006bba:	2785                	addiw	a5,a5,1
    80006bbc:	fef42623          	sw	a5,-20(s0)
    80006bc0:	0049e797          	auipc	a5,0x49e
    80006bc4:	0a878793          	addi	a5,a5,168 # 804a4c68 <log>
    80006bc8:	57d8                	lw	a4,44(a5)
    80006bca:	fec42783          	lw	a5,-20(s0)
    80006bce:	2781                	sext.w	a5,a5
    80006bd0:	f2e7c2e3          	blt	a5,a4,80006af4 <install_trans+0x14>
  }
}
    80006bd4:	0001                	nop
    80006bd6:	0001                	nop
    80006bd8:	70e2                	ld	ra,56(sp)
    80006bda:	7442                	ld	s0,48(sp)
    80006bdc:	6121                	addi	sp,sp,64
    80006bde:	8082                	ret

0000000080006be0 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
    80006be0:	7179                	addi	sp,sp,-48
    80006be2:	f406                	sd	ra,40(sp)
    80006be4:	f022                	sd	s0,32(sp)
    80006be6:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80006be8:	0049e797          	auipc	a5,0x49e
    80006bec:	08078793          	addi	a5,a5,128 # 804a4c68 <log>
    80006bf0:	579c                	lw	a5,40(a5)
    80006bf2:	0007871b          	sext.w	a4,a5
    80006bf6:	0049e797          	auipc	a5,0x49e
    80006bfa:	07278793          	addi	a5,a5,114 # 804a4c68 <log>
    80006bfe:	4f9c                	lw	a5,24(a5)
    80006c00:	2781                	sext.w	a5,a5
    80006c02:	85be                	mv	a1,a5
    80006c04:	853a                	mv	a0,a4
    80006c06:	ffffe097          	auipc	ra,0xffffe
    80006c0a:	73a080e7          	jalr	1850(ra) # 80005340 <bread>
    80006c0e:	fea43023          	sd	a0,-32(s0)
  struct logheader *lh = (struct logheader *) (buf->data);
    80006c12:	fe043783          	ld	a5,-32(s0)
    80006c16:	05878793          	addi	a5,a5,88
    80006c1a:	fcf43c23          	sd	a5,-40(s0)
  int i;
  log.lh.n = lh->n;
    80006c1e:	fd843783          	ld	a5,-40(s0)
    80006c22:	4398                	lw	a4,0(a5)
    80006c24:	0049e797          	auipc	a5,0x49e
    80006c28:	04478793          	addi	a5,a5,68 # 804a4c68 <log>
    80006c2c:	d7d8                	sw	a4,44(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006c2e:	fe042623          	sw	zero,-20(s0)
    80006c32:	a03d                	j	80006c60 <read_head+0x80>
    log.lh.block[i] = lh->block[i];
    80006c34:	fd843703          	ld	a4,-40(s0)
    80006c38:	fec42783          	lw	a5,-20(s0)
    80006c3c:	078a                	slli	a5,a5,0x2
    80006c3e:	97ba                	add	a5,a5,a4
    80006c40:	43d8                	lw	a4,4(a5)
    80006c42:	0049e697          	auipc	a3,0x49e
    80006c46:	02668693          	addi	a3,a3,38 # 804a4c68 <log>
    80006c4a:	fec42783          	lw	a5,-20(s0)
    80006c4e:	07a1                	addi	a5,a5,8
    80006c50:	078a                	slli	a5,a5,0x2
    80006c52:	97b6                	add	a5,a5,a3
    80006c54:	cb98                	sw	a4,16(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006c56:	fec42783          	lw	a5,-20(s0)
    80006c5a:	2785                	addiw	a5,a5,1
    80006c5c:	fef42623          	sw	a5,-20(s0)
    80006c60:	0049e797          	auipc	a5,0x49e
    80006c64:	00878793          	addi	a5,a5,8 # 804a4c68 <log>
    80006c68:	57d8                	lw	a4,44(a5)
    80006c6a:	fec42783          	lw	a5,-20(s0)
    80006c6e:	2781                	sext.w	a5,a5
    80006c70:	fce7c2e3          	blt	a5,a4,80006c34 <read_head+0x54>
  }
  brelse(buf);
    80006c74:	fe043503          	ld	a0,-32(s0)
    80006c78:	ffffe097          	auipc	ra,0xffffe
    80006c7c:	76a080e7          	jalr	1898(ra) # 800053e2 <brelse>
}
    80006c80:	0001                	nop
    80006c82:	70a2                	ld	ra,40(sp)
    80006c84:	7402                	ld	s0,32(sp)
    80006c86:	6145                	addi	sp,sp,48
    80006c88:	8082                	ret

0000000080006c8a <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80006c8a:	7179                	addi	sp,sp,-48
    80006c8c:	f406                	sd	ra,40(sp)
    80006c8e:	f022                	sd	s0,32(sp)
    80006c90:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80006c92:	0049e797          	auipc	a5,0x49e
    80006c96:	fd678793          	addi	a5,a5,-42 # 804a4c68 <log>
    80006c9a:	579c                	lw	a5,40(a5)
    80006c9c:	0007871b          	sext.w	a4,a5
    80006ca0:	0049e797          	auipc	a5,0x49e
    80006ca4:	fc878793          	addi	a5,a5,-56 # 804a4c68 <log>
    80006ca8:	4f9c                	lw	a5,24(a5)
    80006caa:	2781                	sext.w	a5,a5
    80006cac:	85be                	mv	a1,a5
    80006cae:	853a                	mv	a0,a4
    80006cb0:	ffffe097          	auipc	ra,0xffffe
    80006cb4:	690080e7          	jalr	1680(ra) # 80005340 <bread>
    80006cb8:	fea43023          	sd	a0,-32(s0)
  struct logheader *hb = (struct logheader *) (buf->data);
    80006cbc:	fe043783          	ld	a5,-32(s0)
    80006cc0:	05878793          	addi	a5,a5,88
    80006cc4:	fcf43c23          	sd	a5,-40(s0)
  int i;
  hb->n = log.lh.n;
    80006cc8:	0049e797          	auipc	a5,0x49e
    80006ccc:	fa078793          	addi	a5,a5,-96 # 804a4c68 <log>
    80006cd0:	57d8                	lw	a4,44(a5)
    80006cd2:	fd843783          	ld	a5,-40(s0)
    80006cd6:	c398                	sw	a4,0(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006cd8:	fe042623          	sw	zero,-20(s0)
    80006cdc:	a03d                	j	80006d0a <write_head+0x80>
    hb->block[i] = log.lh.block[i];
    80006cde:	0049e717          	auipc	a4,0x49e
    80006ce2:	f8a70713          	addi	a4,a4,-118 # 804a4c68 <log>
    80006ce6:	fec42783          	lw	a5,-20(s0)
    80006cea:	07a1                	addi	a5,a5,8
    80006cec:	078a                	slli	a5,a5,0x2
    80006cee:	97ba                	add	a5,a5,a4
    80006cf0:	4b98                	lw	a4,16(a5)
    80006cf2:	fd843683          	ld	a3,-40(s0)
    80006cf6:	fec42783          	lw	a5,-20(s0)
    80006cfa:	078a                	slli	a5,a5,0x2
    80006cfc:	97b6                	add	a5,a5,a3
    80006cfe:	c3d8                	sw	a4,4(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006d00:	fec42783          	lw	a5,-20(s0)
    80006d04:	2785                	addiw	a5,a5,1
    80006d06:	fef42623          	sw	a5,-20(s0)
    80006d0a:	0049e797          	auipc	a5,0x49e
    80006d0e:	f5e78793          	addi	a5,a5,-162 # 804a4c68 <log>
    80006d12:	57d8                	lw	a4,44(a5)
    80006d14:	fec42783          	lw	a5,-20(s0)
    80006d18:	2781                	sext.w	a5,a5
    80006d1a:	fce7c2e3          	blt	a5,a4,80006cde <write_head+0x54>
  }
  bwrite(buf);
    80006d1e:	fe043503          	ld	a0,-32(s0)
    80006d22:	ffffe097          	auipc	ra,0xffffe
    80006d26:	678080e7          	jalr	1656(ra) # 8000539a <bwrite>
  brelse(buf);
    80006d2a:	fe043503          	ld	a0,-32(s0)
    80006d2e:	ffffe097          	auipc	ra,0xffffe
    80006d32:	6b4080e7          	jalr	1716(ra) # 800053e2 <brelse>
}
    80006d36:	0001                	nop
    80006d38:	70a2                	ld	ra,40(sp)
    80006d3a:	7402                	ld	s0,32(sp)
    80006d3c:	6145                	addi	sp,sp,48
    80006d3e:	8082                	ret

0000000080006d40 <recover_from_log>:

static void
recover_from_log(void)
{
    80006d40:	1141                	addi	sp,sp,-16
    80006d42:	e406                	sd	ra,8(sp)
    80006d44:	e022                	sd	s0,0(sp)
    80006d46:	0800                	addi	s0,sp,16
  read_head();
    80006d48:	00000097          	auipc	ra,0x0
    80006d4c:	e98080e7          	jalr	-360(ra) # 80006be0 <read_head>
  install_trans(1); // if committed, copy from log to disk
    80006d50:	4505                	li	a0,1
    80006d52:	00000097          	auipc	ra,0x0
    80006d56:	d8e080e7          	jalr	-626(ra) # 80006ae0 <install_trans>
  log.lh.n = 0;
    80006d5a:	0049e797          	auipc	a5,0x49e
    80006d5e:	f0e78793          	addi	a5,a5,-242 # 804a4c68 <log>
    80006d62:	0207a623          	sw	zero,44(a5)
  write_head(); // clear the log
    80006d66:	00000097          	auipc	ra,0x0
    80006d6a:	f24080e7          	jalr	-220(ra) # 80006c8a <write_head>
}
    80006d6e:	0001                	nop
    80006d70:	60a2                	ld	ra,8(sp)
    80006d72:	6402                	ld	s0,0(sp)
    80006d74:	0141                	addi	sp,sp,16
    80006d76:	8082                	ret

0000000080006d78 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
    80006d78:	1141                	addi	sp,sp,-16
    80006d7a:	e406                	sd	ra,8(sp)
    80006d7c:	e022                	sd	s0,0(sp)
    80006d7e:	0800                	addi	s0,sp,16
  acquire(&log.lock);
    80006d80:	0049e517          	auipc	a0,0x49e
    80006d84:	ee850513          	addi	a0,a0,-280 # 804a4c68 <log>
    80006d88:	ffffa097          	auipc	ra,0xffffa
    80006d8c:	4e2080e7          	jalr	1250(ra) # 8000126a <acquire>
  while(1){
    if(log.committing){
    80006d90:	0049e797          	auipc	a5,0x49e
    80006d94:	ed878793          	addi	a5,a5,-296 # 804a4c68 <log>
    80006d98:	53dc                	lw	a5,36(a5)
    80006d9a:	cf91                	beqz	a5,80006db6 <begin_op+0x3e>
      sleep(&log, &log.lock);
    80006d9c:	0049e597          	auipc	a1,0x49e
    80006da0:	ecc58593          	addi	a1,a1,-308 # 804a4c68 <log>
    80006da4:	0049e517          	auipc	a0,0x49e
    80006da8:	ec450513          	addi	a0,a0,-316 # 804a4c68 <log>
    80006dac:	ffffd097          	auipc	ra,0xffffd
    80006db0:	b76080e7          	jalr	-1162(ra) # 80003922 <sleep>
    80006db4:	bff1                	j	80006d90 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80006db6:	0049e797          	auipc	a5,0x49e
    80006dba:	eb278793          	addi	a5,a5,-334 # 804a4c68 <log>
    80006dbe:	57d8                	lw	a4,44(a5)
    80006dc0:	0049e797          	auipc	a5,0x49e
    80006dc4:	ea878793          	addi	a5,a5,-344 # 804a4c68 <log>
    80006dc8:	539c                	lw	a5,32(a5)
    80006dca:	2785                	addiw	a5,a5,1
    80006dcc:	2781                	sext.w	a5,a5
    80006dce:	86be                	mv	a3,a5
    80006dd0:	87b6                	mv	a5,a3
    80006dd2:	0027979b          	slliw	a5,a5,0x2
    80006dd6:	9fb5                	addw	a5,a5,a3
    80006dd8:	0017979b          	slliw	a5,a5,0x1
    80006ddc:	2781                	sext.w	a5,a5
    80006dde:	9fb9                	addw	a5,a5,a4
    80006de0:	2781                	sext.w	a5,a5
    80006de2:	873e                	mv	a4,a5
    80006de4:	47f9                	li	a5,30
    80006de6:	00e7df63          	bge	a5,a4,80006e04 <begin_op+0x8c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80006dea:	0049e597          	auipc	a1,0x49e
    80006dee:	e7e58593          	addi	a1,a1,-386 # 804a4c68 <log>
    80006df2:	0049e517          	auipc	a0,0x49e
    80006df6:	e7650513          	addi	a0,a0,-394 # 804a4c68 <log>
    80006dfa:	ffffd097          	auipc	ra,0xffffd
    80006dfe:	b28080e7          	jalr	-1240(ra) # 80003922 <sleep>
    80006e02:	b779                	j	80006d90 <begin_op+0x18>
    } else {
      log.outstanding += 1;
    80006e04:	0049e797          	auipc	a5,0x49e
    80006e08:	e6478793          	addi	a5,a5,-412 # 804a4c68 <log>
    80006e0c:	539c                	lw	a5,32(a5)
    80006e0e:	2785                	addiw	a5,a5,1
    80006e10:	0007871b          	sext.w	a4,a5
    80006e14:	0049e797          	auipc	a5,0x49e
    80006e18:	e5478793          	addi	a5,a5,-428 # 804a4c68 <log>
    80006e1c:	d398                	sw	a4,32(a5)
      release(&log.lock);
    80006e1e:	0049e517          	auipc	a0,0x49e
    80006e22:	e4a50513          	addi	a0,a0,-438 # 804a4c68 <log>
    80006e26:	ffffa097          	auipc	ra,0xffffa
    80006e2a:	4a8080e7          	jalr	1192(ra) # 800012ce <release>
      break;
    80006e2e:	0001                	nop
    }
  }
}
    80006e30:	0001                	nop
    80006e32:	60a2                	ld	ra,8(sp)
    80006e34:	6402                	ld	s0,0(sp)
    80006e36:	0141                	addi	sp,sp,16
    80006e38:	8082                	ret

0000000080006e3a <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80006e3a:	1101                	addi	sp,sp,-32
    80006e3c:	ec06                	sd	ra,24(sp)
    80006e3e:	e822                	sd	s0,16(sp)
    80006e40:	1000                	addi	s0,sp,32
  int do_commit = 0;
    80006e42:	fe042623          	sw	zero,-20(s0)

  acquire(&log.lock);
    80006e46:	0049e517          	auipc	a0,0x49e
    80006e4a:	e2250513          	addi	a0,a0,-478 # 804a4c68 <log>
    80006e4e:	ffffa097          	auipc	ra,0xffffa
    80006e52:	41c080e7          	jalr	1052(ra) # 8000126a <acquire>
  log.outstanding -= 1;
    80006e56:	0049e797          	auipc	a5,0x49e
    80006e5a:	e1278793          	addi	a5,a5,-494 # 804a4c68 <log>
    80006e5e:	539c                	lw	a5,32(a5)
    80006e60:	37fd                	addiw	a5,a5,-1
    80006e62:	0007871b          	sext.w	a4,a5
    80006e66:	0049e797          	auipc	a5,0x49e
    80006e6a:	e0278793          	addi	a5,a5,-510 # 804a4c68 <log>
    80006e6e:	d398                	sw	a4,32(a5)
  if(log.committing)
    80006e70:	0049e797          	auipc	a5,0x49e
    80006e74:	df878793          	addi	a5,a5,-520 # 804a4c68 <log>
    80006e78:	53dc                	lw	a5,36(a5)
    80006e7a:	cb89                	beqz	a5,80006e8c <end_op+0x52>
    panic("log.committing");
    80006e7c:	00005517          	auipc	a0,0x5
    80006e80:	86450513          	addi	a0,a0,-1948 # 8000b6e0 <etext+0x6e0>
    80006e84:	ffffa097          	auipc	ra,0xffffa
    80006e88:	df6080e7          	jalr	-522(ra) # 80000c7a <panic>
  if(log.outstanding == 0){
    80006e8c:	0049e797          	auipc	a5,0x49e
    80006e90:	ddc78793          	addi	a5,a5,-548 # 804a4c68 <log>
    80006e94:	539c                	lw	a5,32(a5)
    80006e96:	eb99                	bnez	a5,80006eac <end_op+0x72>
    do_commit = 1;
    80006e98:	4785                	li	a5,1
    80006e9a:	fef42623          	sw	a5,-20(s0)
    log.committing = 1;
    80006e9e:	0049e797          	auipc	a5,0x49e
    80006ea2:	dca78793          	addi	a5,a5,-566 # 804a4c68 <log>
    80006ea6:	4705                	li	a4,1
    80006ea8:	d3d8                	sw	a4,36(a5)
    80006eaa:	a809                	j	80006ebc <end_op+0x82>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
    80006eac:	0049e517          	auipc	a0,0x49e
    80006eb0:	dbc50513          	addi	a0,a0,-580 # 804a4c68 <log>
    80006eb4:	ffffd097          	auipc	ra,0xffffd
    80006eb8:	aea080e7          	jalr	-1302(ra) # 8000399e <wakeup>
  }
  release(&log.lock);
    80006ebc:	0049e517          	auipc	a0,0x49e
    80006ec0:	dac50513          	addi	a0,a0,-596 # 804a4c68 <log>
    80006ec4:	ffffa097          	auipc	ra,0xffffa
    80006ec8:	40a080e7          	jalr	1034(ra) # 800012ce <release>

  if(do_commit){
    80006ecc:	fec42783          	lw	a5,-20(s0)
    80006ed0:	2781                	sext.w	a5,a5
    80006ed2:	c3b9                	beqz	a5,80006f18 <end_op+0xde>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    80006ed4:	00000097          	auipc	ra,0x0
    80006ed8:	134080e7          	jalr	308(ra) # 80007008 <commit>
    acquire(&log.lock);
    80006edc:	0049e517          	auipc	a0,0x49e
    80006ee0:	d8c50513          	addi	a0,a0,-628 # 804a4c68 <log>
    80006ee4:	ffffa097          	auipc	ra,0xffffa
    80006ee8:	386080e7          	jalr	902(ra) # 8000126a <acquire>
    log.committing = 0;
    80006eec:	0049e797          	auipc	a5,0x49e
    80006ef0:	d7c78793          	addi	a5,a5,-644 # 804a4c68 <log>
    80006ef4:	0207a223          	sw	zero,36(a5)
    wakeup(&log);
    80006ef8:	0049e517          	auipc	a0,0x49e
    80006efc:	d7050513          	addi	a0,a0,-656 # 804a4c68 <log>
    80006f00:	ffffd097          	auipc	ra,0xffffd
    80006f04:	a9e080e7          	jalr	-1378(ra) # 8000399e <wakeup>
    release(&log.lock);
    80006f08:	0049e517          	auipc	a0,0x49e
    80006f0c:	d6050513          	addi	a0,a0,-672 # 804a4c68 <log>
    80006f10:	ffffa097          	auipc	ra,0xffffa
    80006f14:	3be080e7          	jalr	958(ra) # 800012ce <release>
  }
}
    80006f18:	0001                	nop
    80006f1a:	60e2                	ld	ra,24(sp)
    80006f1c:	6442                	ld	s0,16(sp)
    80006f1e:	6105                	addi	sp,sp,32
    80006f20:	8082                	ret

0000000080006f22 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
    80006f22:	7179                	addi	sp,sp,-48
    80006f24:	f406                	sd	ra,40(sp)
    80006f26:	f022                	sd	s0,32(sp)
    80006f28:	1800                	addi	s0,sp,48
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    80006f2a:	fe042623          	sw	zero,-20(s0)
    80006f2e:	a86d                	j	80006fe8 <write_log+0xc6>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80006f30:	0049e797          	auipc	a5,0x49e
    80006f34:	d3878793          	addi	a5,a5,-712 # 804a4c68 <log>
    80006f38:	579c                	lw	a5,40(a5)
    80006f3a:	0007871b          	sext.w	a4,a5
    80006f3e:	0049e797          	auipc	a5,0x49e
    80006f42:	d2a78793          	addi	a5,a5,-726 # 804a4c68 <log>
    80006f46:	4f9c                	lw	a5,24(a5)
    80006f48:	fec42683          	lw	a3,-20(s0)
    80006f4c:	9fb5                	addw	a5,a5,a3
    80006f4e:	2781                	sext.w	a5,a5
    80006f50:	2785                	addiw	a5,a5,1
    80006f52:	2781                	sext.w	a5,a5
    80006f54:	2781                	sext.w	a5,a5
    80006f56:	85be                	mv	a1,a5
    80006f58:	853a                	mv	a0,a4
    80006f5a:	ffffe097          	auipc	ra,0xffffe
    80006f5e:	3e6080e7          	jalr	998(ra) # 80005340 <bread>
    80006f62:	fea43023          	sd	a0,-32(s0)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80006f66:	0049e797          	auipc	a5,0x49e
    80006f6a:	d0278793          	addi	a5,a5,-766 # 804a4c68 <log>
    80006f6e:	579c                	lw	a5,40(a5)
    80006f70:	0007869b          	sext.w	a3,a5
    80006f74:	0049e717          	auipc	a4,0x49e
    80006f78:	cf470713          	addi	a4,a4,-780 # 804a4c68 <log>
    80006f7c:	fec42783          	lw	a5,-20(s0)
    80006f80:	07a1                	addi	a5,a5,8
    80006f82:	078a                	slli	a5,a5,0x2
    80006f84:	97ba                	add	a5,a5,a4
    80006f86:	4b9c                	lw	a5,16(a5)
    80006f88:	2781                	sext.w	a5,a5
    80006f8a:	85be                	mv	a1,a5
    80006f8c:	8536                	mv	a0,a3
    80006f8e:	ffffe097          	auipc	ra,0xffffe
    80006f92:	3b2080e7          	jalr	946(ra) # 80005340 <bread>
    80006f96:	fca43c23          	sd	a0,-40(s0)
    memmove(to->data, from->data, BSIZE);
    80006f9a:	fe043783          	ld	a5,-32(s0)
    80006f9e:	05878713          	addi	a4,a5,88
    80006fa2:	fd843783          	ld	a5,-40(s0)
    80006fa6:	05878793          	addi	a5,a5,88
    80006faa:	40000613          	li	a2,1024
    80006fae:	85be                	mv	a1,a5
    80006fb0:	853a                	mv	a0,a4
    80006fb2:	ffffa097          	auipc	ra,0xffffa
    80006fb6:	570080e7          	jalr	1392(ra) # 80001522 <memmove>
    bwrite(to);  // write the log
    80006fba:	fe043503          	ld	a0,-32(s0)
    80006fbe:	ffffe097          	auipc	ra,0xffffe
    80006fc2:	3dc080e7          	jalr	988(ra) # 8000539a <bwrite>
    brelse(from);
    80006fc6:	fd843503          	ld	a0,-40(s0)
    80006fca:	ffffe097          	auipc	ra,0xffffe
    80006fce:	418080e7          	jalr	1048(ra) # 800053e2 <brelse>
    brelse(to);
    80006fd2:	fe043503          	ld	a0,-32(s0)
    80006fd6:	ffffe097          	auipc	ra,0xffffe
    80006fda:	40c080e7          	jalr	1036(ra) # 800053e2 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80006fde:	fec42783          	lw	a5,-20(s0)
    80006fe2:	2785                	addiw	a5,a5,1
    80006fe4:	fef42623          	sw	a5,-20(s0)
    80006fe8:	0049e797          	auipc	a5,0x49e
    80006fec:	c8078793          	addi	a5,a5,-896 # 804a4c68 <log>
    80006ff0:	57d8                	lw	a4,44(a5)
    80006ff2:	fec42783          	lw	a5,-20(s0)
    80006ff6:	2781                	sext.w	a5,a5
    80006ff8:	f2e7cce3          	blt	a5,a4,80006f30 <write_log+0xe>
  }
}
    80006ffc:	0001                	nop
    80006ffe:	0001                	nop
    80007000:	70a2                	ld	ra,40(sp)
    80007002:	7402                	ld	s0,32(sp)
    80007004:	6145                	addi	sp,sp,48
    80007006:	8082                	ret

0000000080007008 <commit>:

static void
commit()
{
    80007008:	1141                	addi	sp,sp,-16
    8000700a:	e406                	sd	ra,8(sp)
    8000700c:	e022                	sd	s0,0(sp)
    8000700e:	0800                	addi	s0,sp,16
  if (log.lh.n > 0) {
    80007010:	0049e797          	auipc	a5,0x49e
    80007014:	c5878793          	addi	a5,a5,-936 # 804a4c68 <log>
    80007018:	57dc                	lw	a5,44(a5)
    8000701a:	02f05963          	blez	a5,8000704c <commit+0x44>
    write_log();     // Write modified blocks from cache to log
    8000701e:	00000097          	auipc	ra,0x0
    80007022:	f04080e7          	jalr	-252(ra) # 80006f22 <write_log>
    write_head();    // Write header to disk -- the real commit
    80007026:	00000097          	auipc	ra,0x0
    8000702a:	c64080e7          	jalr	-924(ra) # 80006c8a <write_head>
    install_trans(0); // Now install writes to home locations
    8000702e:	4501                	li	a0,0
    80007030:	00000097          	auipc	ra,0x0
    80007034:	ab0080e7          	jalr	-1360(ra) # 80006ae0 <install_trans>
    log.lh.n = 0;
    80007038:	0049e797          	auipc	a5,0x49e
    8000703c:	c3078793          	addi	a5,a5,-976 # 804a4c68 <log>
    80007040:	0207a623          	sw	zero,44(a5)
    write_head();    // Erase the transaction from the log
    80007044:	00000097          	auipc	ra,0x0
    80007048:	c46080e7          	jalr	-954(ra) # 80006c8a <write_head>
  }
}
    8000704c:	0001                	nop
    8000704e:	60a2                	ld	ra,8(sp)
    80007050:	6402                	ld	s0,0(sp)
    80007052:	0141                	addi	sp,sp,16
    80007054:	8082                	ret

0000000080007056 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80007056:	7179                	addi	sp,sp,-48
    80007058:	f406                	sd	ra,40(sp)
    8000705a:	f022                	sd	s0,32(sp)
    8000705c:	1800                	addi	s0,sp,48
    8000705e:	fca43c23          	sd	a0,-40(s0)
  int i;

  acquire(&log.lock);
    80007062:	0049e517          	auipc	a0,0x49e
    80007066:	c0650513          	addi	a0,a0,-1018 # 804a4c68 <log>
    8000706a:	ffffa097          	auipc	ra,0xffffa
    8000706e:	200080e7          	jalr	512(ra) # 8000126a <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80007072:	0049e797          	auipc	a5,0x49e
    80007076:	bf678793          	addi	a5,a5,-1034 # 804a4c68 <log>
    8000707a:	57dc                	lw	a5,44(a5)
    8000707c:	873e                	mv	a4,a5
    8000707e:	47f5                	li	a5,29
    80007080:	02e7c063          	blt	a5,a4,800070a0 <log_write+0x4a>
    80007084:	0049e797          	auipc	a5,0x49e
    80007088:	be478793          	addi	a5,a5,-1052 # 804a4c68 <log>
    8000708c:	57d8                	lw	a4,44(a5)
    8000708e:	0049e797          	auipc	a5,0x49e
    80007092:	bda78793          	addi	a5,a5,-1062 # 804a4c68 <log>
    80007096:	4fdc                	lw	a5,28(a5)
    80007098:	37fd                	addiw	a5,a5,-1
    8000709a:	2781                	sext.w	a5,a5
    8000709c:	00f74a63          	blt	a4,a5,800070b0 <log_write+0x5a>
    panic("too big a transaction");
    800070a0:	00004517          	auipc	a0,0x4
    800070a4:	65050513          	addi	a0,a0,1616 # 8000b6f0 <etext+0x6f0>
    800070a8:	ffffa097          	auipc	ra,0xffffa
    800070ac:	bd2080e7          	jalr	-1070(ra) # 80000c7a <panic>
  if (log.outstanding < 1)
    800070b0:	0049e797          	auipc	a5,0x49e
    800070b4:	bb878793          	addi	a5,a5,-1096 # 804a4c68 <log>
    800070b8:	539c                	lw	a5,32(a5)
    800070ba:	00f04a63          	bgtz	a5,800070ce <log_write+0x78>
    panic("log_write outside of trans");
    800070be:	00004517          	auipc	a0,0x4
    800070c2:	64a50513          	addi	a0,a0,1610 # 8000b708 <etext+0x708>
    800070c6:	ffffa097          	auipc	ra,0xffffa
    800070ca:	bb4080e7          	jalr	-1100(ra) # 80000c7a <panic>

  for (i = 0; i < log.lh.n; i++) {
    800070ce:	fe042623          	sw	zero,-20(s0)
    800070d2:	a03d                	j	80007100 <log_write+0xaa>
    if (log.lh.block[i] == b->blockno)   // log absorption
    800070d4:	0049e717          	auipc	a4,0x49e
    800070d8:	b9470713          	addi	a4,a4,-1132 # 804a4c68 <log>
    800070dc:	fec42783          	lw	a5,-20(s0)
    800070e0:	07a1                	addi	a5,a5,8
    800070e2:	078a                	slli	a5,a5,0x2
    800070e4:	97ba                	add	a5,a5,a4
    800070e6:	4b9c                	lw	a5,16(a5)
    800070e8:	0007871b          	sext.w	a4,a5
    800070ec:	fd843783          	ld	a5,-40(s0)
    800070f0:	47dc                	lw	a5,12(a5)
    800070f2:	02f70263          	beq	a4,a5,80007116 <log_write+0xc0>
  for (i = 0; i < log.lh.n; i++) {
    800070f6:	fec42783          	lw	a5,-20(s0)
    800070fa:	2785                	addiw	a5,a5,1
    800070fc:	fef42623          	sw	a5,-20(s0)
    80007100:	0049e797          	auipc	a5,0x49e
    80007104:	b6878793          	addi	a5,a5,-1176 # 804a4c68 <log>
    80007108:	57d8                	lw	a4,44(a5)
    8000710a:	fec42783          	lw	a5,-20(s0)
    8000710e:	2781                	sext.w	a5,a5
    80007110:	fce7c2e3          	blt	a5,a4,800070d4 <log_write+0x7e>
    80007114:	a011                	j	80007118 <log_write+0xc2>
      break;
    80007116:	0001                	nop
  }
  log.lh.block[i] = b->blockno;
    80007118:	fd843783          	ld	a5,-40(s0)
    8000711c:	47dc                	lw	a5,12(a5)
    8000711e:	0007871b          	sext.w	a4,a5
    80007122:	0049e697          	auipc	a3,0x49e
    80007126:	b4668693          	addi	a3,a3,-1210 # 804a4c68 <log>
    8000712a:	fec42783          	lw	a5,-20(s0)
    8000712e:	07a1                	addi	a5,a5,8
    80007130:	078a                	slli	a5,a5,0x2
    80007132:	97b6                	add	a5,a5,a3
    80007134:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    80007136:	0049e797          	auipc	a5,0x49e
    8000713a:	b3278793          	addi	a5,a5,-1230 # 804a4c68 <log>
    8000713e:	57d8                	lw	a4,44(a5)
    80007140:	fec42783          	lw	a5,-20(s0)
    80007144:	2781                	sext.w	a5,a5
    80007146:	02e79563          	bne	a5,a4,80007170 <log_write+0x11a>
    bpin(b);
    8000714a:	fd843503          	ld	a0,-40(s0)
    8000714e:	ffffe097          	auipc	ra,0xffffe
    80007152:	382080e7          	jalr	898(ra) # 800054d0 <bpin>
    log.lh.n++;
    80007156:	0049e797          	auipc	a5,0x49e
    8000715a:	b1278793          	addi	a5,a5,-1262 # 804a4c68 <log>
    8000715e:	57dc                	lw	a5,44(a5)
    80007160:	2785                	addiw	a5,a5,1
    80007162:	0007871b          	sext.w	a4,a5
    80007166:	0049e797          	auipc	a5,0x49e
    8000716a:	b0278793          	addi	a5,a5,-1278 # 804a4c68 <log>
    8000716e:	d7d8                	sw	a4,44(a5)
  }
  release(&log.lock);
    80007170:	0049e517          	auipc	a0,0x49e
    80007174:	af850513          	addi	a0,a0,-1288 # 804a4c68 <log>
    80007178:	ffffa097          	auipc	ra,0xffffa
    8000717c:	156080e7          	jalr	342(ra) # 800012ce <release>
}
    80007180:	0001                	nop
    80007182:	70a2                	ld	ra,40(sp)
    80007184:	7402                	ld	s0,32(sp)
    80007186:	6145                	addi	sp,sp,48
    80007188:	8082                	ret

000000008000718a <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    8000718a:	1101                	addi	sp,sp,-32
    8000718c:	ec06                	sd	ra,24(sp)
    8000718e:	e822                	sd	s0,16(sp)
    80007190:	1000                	addi	s0,sp,32
    80007192:	fea43423          	sd	a0,-24(s0)
    80007196:	feb43023          	sd	a1,-32(s0)
  initlock(&lk->lk, "sleep lock");
    8000719a:	fe843783          	ld	a5,-24(s0)
    8000719e:	07a1                	addi	a5,a5,8
    800071a0:	00004597          	auipc	a1,0x4
    800071a4:	58858593          	addi	a1,a1,1416 # 8000b728 <etext+0x728>
    800071a8:	853e                	mv	a0,a5
    800071aa:	ffffa097          	auipc	ra,0xffffa
    800071ae:	090080e7          	jalr	144(ra) # 8000123a <initlock>
  lk->name = name;
    800071b2:	fe843783          	ld	a5,-24(s0)
    800071b6:	fe043703          	ld	a4,-32(s0)
    800071ba:	f398                	sd	a4,32(a5)
  lk->locked = 0;
    800071bc:	fe843783          	ld	a5,-24(s0)
    800071c0:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    800071c4:	fe843783          	ld	a5,-24(s0)
    800071c8:	0207a423          	sw	zero,40(a5)
}
    800071cc:	0001                	nop
    800071ce:	60e2                	ld	ra,24(sp)
    800071d0:	6442                	ld	s0,16(sp)
    800071d2:	6105                	addi	sp,sp,32
    800071d4:	8082                	ret

00000000800071d6 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800071d6:	1101                	addi	sp,sp,-32
    800071d8:	ec06                	sd	ra,24(sp)
    800071da:	e822                	sd	s0,16(sp)
    800071dc:	1000                	addi	s0,sp,32
    800071de:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    800071e2:	fe843783          	ld	a5,-24(s0)
    800071e6:	07a1                	addi	a5,a5,8
    800071e8:	853e                	mv	a0,a5
    800071ea:	ffffa097          	auipc	ra,0xffffa
    800071ee:	080080e7          	jalr	128(ra) # 8000126a <acquire>
  while (lk->locked) {
    800071f2:	a819                	j	80007208 <acquiresleep+0x32>
    sleep(lk, &lk->lk);
    800071f4:	fe843783          	ld	a5,-24(s0)
    800071f8:	07a1                	addi	a5,a5,8
    800071fa:	85be                	mv	a1,a5
    800071fc:	fe843503          	ld	a0,-24(s0)
    80007200:	ffffc097          	auipc	ra,0xffffc
    80007204:	722080e7          	jalr	1826(ra) # 80003922 <sleep>
  while (lk->locked) {
    80007208:	fe843783          	ld	a5,-24(s0)
    8000720c:	439c                	lw	a5,0(a5)
    8000720e:	f3fd                	bnez	a5,800071f4 <acquiresleep+0x1e>
  }
  lk->locked = 1;
    80007210:	fe843783          	ld	a5,-24(s0)
    80007214:	4705                	li	a4,1
    80007216:	c398                	sw	a4,0(a5)
  lk->pid = myproc()->pid;
    80007218:	ffffc097          	auipc	ra,0xffffc
    8000721c:	800080e7          	jalr	-2048(ra) # 80002a18 <myproc>
    80007220:	87aa                	mv	a5,a0
    80007222:	5b98                	lw	a4,48(a5)
    80007224:	fe843783          	ld	a5,-24(s0)
    80007228:	d798                	sw	a4,40(a5)
  release(&lk->lk);
    8000722a:	fe843783          	ld	a5,-24(s0)
    8000722e:	07a1                	addi	a5,a5,8
    80007230:	853e                	mv	a0,a5
    80007232:	ffffa097          	auipc	ra,0xffffa
    80007236:	09c080e7          	jalr	156(ra) # 800012ce <release>
}
    8000723a:	0001                	nop
    8000723c:	60e2                	ld	ra,24(sp)
    8000723e:	6442                	ld	s0,16(sp)
    80007240:	6105                	addi	sp,sp,32
    80007242:	8082                	ret

0000000080007244 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80007244:	1101                	addi	sp,sp,-32
    80007246:	ec06                	sd	ra,24(sp)
    80007248:	e822                	sd	s0,16(sp)
    8000724a:	1000                	addi	s0,sp,32
    8000724c:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    80007250:	fe843783          	ld	a5,-24(s0)
    80007254:	07a1                	addi	a5,a5,8
    80007256:	853e                	mv	a0,a5
    80007258:	ffffa097          	auipc	ra,0xffffa
    8000725c:	012080e7          	jalr	18(ra) # 8000126a <acquire>
  lk->locked = 0;
    80007260:	fe843783          	ld	a5,-24(s0)
    80007264:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    80007268:	fe843783          	ld	a5,-24(s0)
    8000726c:	0207a423          	sw	zero,40(a5)
  wakeup(lk);
    80007270:	fe843503          	ld	a0,-24(s0)
    80007274:	ffffc097          	auipc	ra,0xffffc
    80007278:	72a080e7          	jalr	1834(ra) # 8000399e <wakeup>
  release(&lk->lk);
    8000727c:	fe843783          	ld	a5,-24(s0)
    80007280:	07a1                	addi	a5,a5,8
    80007282:	853e                	mv	a0,a5
    80007284:	ffffa097          	auipc	ra,0xffffa
    80007288:	04a080e7          	jalr	74(ra) # 800012ce <release>
}
    8000728c:	0001                	nop
    8000728e:	60e2                	ld	ra,24(sp)
    80007290:	6442                	ld	s0,16(sp)
    80007292:	6105                	addi	sp,sp,32
    80007294:	8082                	ret

0000000080007296 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80007296:	7139                	addi	sp,sp,-64
    80007298:	fc06                	sd	ra,56(sp)
    8000729a:	f822                	sd	s0,48(sp)
    8000729c:	f426                	sd	s1,40(sp)
    8000729e:	0080                	addi	s0,sp,64
    800072a0:	fca43423          	sd	a0,-56(s0)
  int r;
  
  acquire(&lk->lk);
    800072a4:	fc843783          	ld	a5,-56(s0)
    800072a8:	07a1                	addi	a5,a5,8
    800072aa:	853e                	mv	a0,a5
    800072ac:	ffffa097          	auipc	ra,0xffffa
    800072b0:	fbe080e7          	jalr	-66(ra) # 8000126a <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800072b4:	fc843783          	ld	a5,-56(s0)
    800072b8:	439c                	lw	a5,0(a5)
    800072ba:	cf99                	beqz	a5,800072d8 <holdingsleep+0x42>
    800072bc:	fc843783          	ld	a5,-56(s0)
    800072c0:	5784                	lw	s1,40(a5)
    800072c2:	ffffb097          	auipc	ra,0xffffb
    800072c6:	756080e7          	jalr	1878(ra) # 80002a18 <myproc>
    800072ca:	87aa                	mv	a5,a0
    800072cc:	5b9c                	lw	a5,48(a5)
    800072ce:	8726                	mv	a4,s1
    800072d0:	00f71463          	bne	a4,a5,800072d8 <holdingsleep+0x42>
    800072d4:	4785                	li	a5,1
    800072d6:	a011                	j	800072da <holdingsleep+0x44>
    800072d8:	4781                	li	a5,0
    800072da:	fcf42e23          	sw	a5,-36(s0)
  release(&lk->lk);
    800072de:	fc843783          	ld	a5,-56(s0)
    800072e2:	07a1                	addi	a5,a5,8
    800072e4:	853e                	mv	a0,a5
    800072e6:	ffffa097          	auipc	ra,0xffffa
    800072ea:	fe8080e7          	jalr	-24(ra) # 800012ce <release>
  return r;
    800072ee:	fdc42783          	lw	a5,-36(s0)
}
    800072f2:	853e                	mv	a0,a5
    800072f4:	70e2                	ld	ra,56(sp)
    800072f6:	7442                	ld	s0,48(sp)
    800072f8:	74a2                	ld	s1,40(sp)
    800072fa:	6121                	addi	sp,sp,64
    800072fc:	8082                	ret

00000000800072fe <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    800072fe:	1141                	addi	sp,sp,-16
    80007300:	e406                	sd	ra,8(sp)
    80007302:	e022                	sd	s0,0(sp)
    80007304:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80007306:	00004597          	auipc	a1,0x4
    8000730a:	43258593          	addi	a1,a1,1074 # 8000b738 <etext+0x738>
    8000730e:	0049e517          	auipc	a0,0x49e
    80007312:	aa250513          	addi	a0,a0,-1374 # 804a4db0 <ftable>
    80007316:	ffffa097          	auipc	ra,0xffffa
    8000731a:	f24080e7          	jalr	-220(ra) # 8000123a <initlock>
}
    8000731e:	0001                	nop
    80007320:	60a2                	ld	ra,8(sp)
    80007322:	6402                	ld	s0,0(sp)
    80007324:	0141                	addi	sp,sp,16
    80007326:	8082                	ret

0000000080007328 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80007328:	1101                	addi	sp,sp,-32
    8000732a:	ec06                	sd	ra,24(sp)
    8000732c:	e822                	sd	s0,16(sp)
    8000732e:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80007330:	0049e517          	auipc	a0,0x49e
    80007334:	a8050513          	addi	a0,a0,-1408 # 804a4db0 <ftable>
    80007338:	ffffa097          	auipc	ra,0xffffa
    8000733c:	f32080e7          	jalr	-206(ra) # 8000126a <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80007340:	0049e797          	auipc	a5,0x49e
    80007344:	a8878793          	addi	a5,a5,-1400 # 804a4dc8 <ftable+0x18>
    80007348:	fef43423          	sd	a5,-24(s0)
    8000734c:	a815                	j	80007380 <filealloc+0x58>
    if(f->ref == 0){
    8000734e:	fe843783          	ld	a5,-24(s0)
    80007352:	43dc                	lw	a5,4(a5)
    80007354:	e385                	bnez	a5,80007374 <filealloc+0x4c>
      f->ref = 1;
    80007356:	fe843783          	ld	a5,-24(s0)
    8000735a:	4705                	li	a4,1
    8000735c:	c3d8                	sw	a4,4(a5)
      release(&ftable.lock);
    8000735e:	0049e517          	auipc	a0,0x49e
    80007362:	a5250513          	addi	a0,a0,-1454 # 804a4db0 <ftable>
    80007366:	ffffa097          	auipc	ra,0xffffa
    8000736a:	f68080e7          	jalr	-152(ra) # 800012ce <release>
      return f;
    8000736e:	fe843783          	ld	a5,-24(s0)
    80007372:	a805                	j	800073a2 <filealloc+0x7a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80007374:	fe843783          	ld	a5,-24(s0)
    80007378:	02878793          	addi	a5,a5,40
    8000737c:	fef43423          	sd	a5,-24(s0)
    80007380:	0049f797          	auipc	a5,0x49f
    80007384:	9e878793          	addi	a5,a5,-1560 # 804a5d68 <ftable+0xfb8>
    80007388:	fe843703          	ld	a4,-24(s0)
    8000738c:	fcf761e3          	bltu	a4,a5,8000734e <filealloc+0x26>
    }
  }
  release(&ftable.lock);
    80007390:	0049e517          	auipc	a0,0x49e
    80007394:	a2050513          	addi	a0,a0,-1504 # 804a4db0 <ftable>
    80007398:	ffffa097          	auipc	ra,0xffffa
    8000739c:	f36080e7          	jalr	-202(ra) # 800012ce <release>
  return 0;
    800073a0:	4781                	li	a5,0
}
    800073a2:	853e                	mv	a0,a5
    800073a4:	60e2                	ld	ra,24(sp)
    800073a6:	6442                	ld	s0,16(sp)
    800073a8:	6105                	addi	sp,sp,32
    800073aa:	8082                	ret

00000000800073ac <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    800073ac:	1101                	addi	sp,sp,-32
    800073ae:	ec06                	sd	ra,24(sp)
    800073b0:	e822                	sd	s0,16(sp)
    800073b2:	1000                	addi	s0,sp,32
    800073b4:	fea43423          	sd	a0,-24(s0)
  acquire(&ftable.lock);
    800073b8:	0049e517          	auipc	a0,0x49e
    800073bc:	9f850513          	addi	a0,a0,-1544 # 804a4db0 <ftable>
    800073c0:	ffffa097          	auipc	ra,0xffffa
    800073c4:	eaa080e7          	jalr	-342(ra) # 8000126a <acquire>
  if(f->ref < 1)
    800073c8:	fe843783          	ld	a5,-24(s0)
    800073cc:	43dc                	lw	a5,4(a5)
    800073ce:	00f04a63          	bgtz	a5,800073e2 <filedup+0x36>
    panic("filedup");
    800073d2:	00004517          	auipc	a0,0x4
    800073d6:	36e50513          	addi	a0,a0,878 # 8000b740 <etext+0x740>
    800073da:	ffffa097          	auipc	ra,0xffffa
    800073de:	8a0080e7          	jalr	-1888(ra) # 80000c7a <panic>
  f->ref++;
    800073e2:	fe843783          	ld	a5,-24(s0)
    800073e6:	43dc                	lw	a5,4(a5)
    800073e8:	2785                	addiw	a5,a5,1
    800073ea:	0007871b          	sext.w	a4,a5
    800073ee:	fe843783          	ld	a5,-24(s0)
    800073f2:	c3d8                	sw	a4,4(a5)
  release(&ftable.lock);
    800073f4:	0049e517          	auipc	a0,0x49e
    800073f8:	9bc50513          	addi	a0,a0,-1604 # 804a4db0 <ftable>
    800073fc:	ffffa097          	auipc	ra,0xffffa
    80007400:	ed2080e7          	jalr	-302(ra) # 800012ce <release>
  return f;
    80007404:	fe843783          	ld	a5,-24(s0)
}
    80007408:	853e                	mv	a0,a5
    8000740a:	60e2                	ld	ra,24(sp)
    8000740c:	6442                	ld	s0,16(sp)
    8000740e:	6105                	addi	sp,sp,32
    80007410:	8082                	ret

0000000080007412 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80007412:	715d                	addi	sp,sp,-80
    80007414:	e486                	sd	ra,72(sp)
    80007416:	e0a2                	sd	s0,64(sp)
    80007418:	0880                	addi	s0,sp,80
    8000741a:	faa43c23          	sd	a0,-72(s0)
  struct file ff;

  acquire(&ftable.lock);
    8000741e:	0049e517          	auipc	a0,0x49e
    80007422:	99250513          	addi	a0,a0,-1646 # 804a4db0 <ftable>
    80007426:	ffffa097          	auipc	ra,0xffffa
    8000742a:	e44080e7          	jalr	-444(ra) # 8000126a <acquire>
  if(f->ref < 1)
    8000742e:	fb843783          	ld	a5,-72(s0)
    80007432:	43dc                	lw	a5,4(a5)
    80007434:	00f04a63          	bgtz	a5,80007448 <fileclose+0x36>
    panic("fileclose");
    80007438:	00004517          	auipc	a0,0x4
    8000743c:	31050513          	addi	a0,a0,784 # 8000b748 <etext+0x748>
    80007440:	ffffa097          	auipc	ra,0xffffa
    80007444:	83a080e7          	jalr	-1990(ra) # 80000c7a <panic>
  if(--f->ref > 0){
    80007448:	fb843783          	ld	a5,-72(s0)
    8000744c:	43dc                	lw	a5,4(a5)
    8000744e:	37fd                	addiw	a5,a5,-1
    80007450:	0007871b          	sext.w	a4,a5
    80007454:	fb843783          	ld	a5,-72(s0)
    80007458:	c3d8                	sw	a4,4(a5)
    8000745a:	fb843783          	ld	a5,-72(s0)
    8000745e:	43dc                	lw	a5,4(a5)
    80007460:	00f05b63          	blez	a5,80007476 <fileclose+0x64>
    release(&ftable.lock);
    80007464:	0049e517          	auipc	a0,0x49e
    80007468:	94c50513          	addi	a0,a0,-1716 # 804a4db0 <ftable>
    8000746c:	ffffa097          	auipc	ra,0xffffa
    80007470:	e62080e7          	jalr	-414(ra) # 800012ce <release>
    80007474:	a879                	j	80007512 <fileclose+0x100>
    return;
  }
  ff = *f;
    80007476:	fb843783          	ld	a5,-72(s0)
    8000747a:	638c                	ld	a1,0(a5)
    8000747c:	6790                	ld	a2,8(a5)
    8000747e:	6b94                	ld	a3,16(a5)
    80007480:	6f98                	ld	a4,24(a5)
    80007482:	739c                	ld	a5,32(a5)
    80007484:	fcb43423          	sd	a1,-56(s0)
    80007488:	fcc43823          	sd	a2,-48(s0)
    8000748c:	fcd43c23          	sd	a3,-40(s0)
    80007490:	fee43023          	sd	a4,-32(s0)
    80007494:	fef43423          	sd	a5,-24(s0)
  f->ref = 0;
    80007498:	fb843783          	ld	a5,-72(s0)
    8000749c:	0007a223          	sw	zero,4(a5)
  f->type = FD_NONE;
    800074a0:	fb843783          	ld	a5,-72(s0)
    800074a4:	0007a023          	sw	zero,0(a5)
  release(&ftable.lock);
    800074a8:	0049e517          	auipc	a0,0x49e
    800074ac:	90850513          	addi	a0,a0,-1784 # 804a4db0 <ftable>
    800074b0:	ffffa097          	auipc	ra,0xffffa
    800074b4:	e1e080e7          	jalr	-482(ra) # 800012ce <release>

  if(ff.type == FD_PIPE){
    800074b8:	fc842783          	lw	a5,-56(s0)
    800074bc:	873e                	mv	a4,a5
    800074be:	4785                	li	a5,1
    800074c0:	00f71e63          	bne	a4,a5,800074dc <fileclose+0xca>
    pipeclose(ff.pipe, ff.writable);
    800074c4:	fd843783          	ld	a5,-40(s0)
    800074c8:	fd144703          	lbu	a4,-47(s0)
    800074cc:	2701                	sext.w	a4,a4
    800074ce:	85ba                	mv	a1,a4
    800074d0:	853e                	mv	a0,a5
    800074d2:	00000097          	auipc	ra,0x0
    800074d6:	5b6080e7          	jalr	1462(ra) # 80007a88 <pipeclose>
    800074da:	a825                	j	80007512 <fileclose+0x100>
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    800074dc:	fc842783          	lw	a5,-56(s0)
    800074e0:	873e                	mv	a4,a5
    800074e2:	4789                	li	a5,2
    800074e4:	00f70863          	beq	a4,a5,800074f4 <fileclose+0xe2>
    800074e8:	fc842783          	lw	a5,-56(s0)
    800074ec:	873e                	mv	a4,a5
    800074ee:	478d                	li	a5,3
    800074f0:	02f71163          	bne	a4,a5,80007512 <fileclose+0x100>
    begin_op();
    800074f4:	00000097          	auipc	ra,0x0
    800074f8:	884080e7          	jalr	-1916(ra) # 80006d78 <begin_op>
    iput(ff.ip);
    800074fc:	fe043783          	ld	a5,-32(s0)
    80007500:	853e                	mv	a0,a5
    80007502:	fffff097          	auipc	ra,0xfffff
    80007506:	99c080e7          	jalr	-1636(ra) # 80005e9e <iput>
    end_op();
    8000750a:	00000097          	auipc	ra,0x0
    8000750e:	930080e7          	jalr	-1744(ra) # 80006e3a <end_op>
  }
}
    80007512:	60a6                	ld	ra,72(sp)
    80007514:	6406                	ld	s0,64(sp)
    80007516:	6161                	addi	sp,sp,80
    80007518:	8082                	ret

000000008000751a <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    8000751a:	7139                	addi	sp,sp,-64
    8000751c:	fc06                	sd	ra,56(sp)
    8000751e:	f822                	sd	s0,48(sp)
    80007520:	0080                	addi	s0,sp,64
    80007522:	fca43423          	sd	a0,-56(s0)
    80007526:	fcb43023          	sd	a1,-64(s0)
  struct proc *p = myproc();
    8000752a:	ffffb097          	auipc	ra,0xffffb
    8000752e:	4ee080e7          	jalr	1262(ra) # 80002a18 <myproc>
    80007532:	fea43423          	sd	a0,-24(s0)
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80007536:	fc843783          	ld	a5,-56(s0)
    8000753a:	439c                	lw	a5,0(a5)
    8000753c:	873e                	mv	a4,a5
    8000753e:	4789                	li	a5,2
    80007540:	00f70963          	beq	a4,a5,80007552 <filestat+0x38>
    80007544:	fc843783          	ld	a5,-56(s0)
    80007548:	439c                	lw	a5,0(a5)
    8000754a:	873e                	mv	a4,a5
    8000754c:	478d                	li	a5,3
    8000754e:	06f71263          	bne	a4,a5,800075b2 <filestat+0x98>
    ilock(f->ip);
    80007552:	fc843783          	ld	a5,-56(s0)
    80007556:	6f9c                	ld	a5,24(a5)
    80007558:	853e                	mv	a0,a5
    8000755a:	ffffe097          	auipc	ra,0xffffe
    8000755e:	7b6080e7          	jalr	1974(ra) # 80005d10 <ilock>
    stati(f->ip, &st);
    80007562:	fc843783          	ld	a5,-56(s0)
    80007566:	6f9c                	ld	a5,24(a5)
    80007568:	fd040713          	addi	a4,s0,-48
    8000756c:	85ba                	mv	a1,a4
    8000756e:	853e                	mv	a0,a5
    80007570:	fffff097          	auipc	ra,0xfffff
    80007574:	cd2080e7          	jalr	-814(ra) # 80006242 <stati>
    iunlock(f->ip);
    80007578:	fc843783          	ld	a5,-56(s0)
    8000757c:	6f9c                	ld	a5,24(a5)
    8000757e:	853e                	mv	a0,a5
    80007580:	fffff097          	auipc	ra,0xfffff
    80007584:	8c4080e7          	jalr	-1852(ra) # 80005e44 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80007588:	fe843783          	ld	a5,-24(s0)
    8000758c:	6bbc                	ld	a5,80(a5)
    8000758e:	fd040713          	addi	a4,s0,-48
    80007592:	46e1                	li	a3,24
    80007594:	863a                	mv	a2,a4
    80007596:	fc043583          	ld	a1,-64(s0)
    8000759a:	853e                	mv	a0,a5
    8000759c:	ffffb097          	auipc	ra,0xffffb
    800075a0:	e2a080e7          	jalr	-470(ra) # 800023c6 <copyout>
    800075a4:	87aa                	mv	a5,a0
    800075a6:	0007d463          	bgez	a5,800075ae <filestat+0x94>
      return -1;
    800075aa:	57fd                	li	a5,-1
    800075ac:	a021                	j	800075b4 <filestat+0x9a>
    return 0;
    800075ae:	4781                	li	a5,0
    800075b0:	a011                	j	800075b4 <filestat+0x9a>
  }
  return -1;
    800075b2:	57fd                	li	a5,-1
}
    800075b4:	853e                	mv	a0,a5
    800075b6:	70e2                	ld	ra,56(sp)
    800075b8:	7442                	ld	s0,48(sp)
    800075ba:	6121                	addi	sp,sp,64
    800075bc:	8082                	ret

00000000800075be <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    800075be:	7139                	addi	sp,sp,-64
    800075c0:	fc06                	sd	ra,56(sp)
    800075c2:	f822                	sd	s0,48(sp)
    800075c4:	0080                	addi	s0,sp,64
    800075c6:	fca43c23          	sd	a0,-40(s0)
    800075ca:	fcb43823          	sd	a1,-48(s0)
    800075ce:	87b2                	mv	a5,a2
    800075d0:	fcf42623          	sw	a5,-52(s0)
  int r = 0;
    800075d4:	fe042623          	sw	zero,-20(s0)

  if(f->readable == 0)
    800075d8:	fd843783          	ld	a5,-40(s0)
    800075dc:	0087c783          	lbu	a5,8(a5)
    800075e0:	e399                	bnez	a5,800075e6 <fileread+0x28>
    return -1;
    800075e2:	57fd                	li	a5,-1
    800075e4:	aa1d                	j	8000771a <fileread+0x15c>

  if(f->type == FD_PIPE){
    800075e6:	fd843783          	ld	a5,-40(s0)
    800075ea:	439c                	lw	a5,0(a5)
    800075ec:	873e                	mv	a4,a5
    800075ee:	4785                	li	a5,1
    800075f0:	02f71363          	bne	a4,a5,80007616 <fileread+0x58>
    r = piperead(f->pipe, addr, n);
    800075f4:	fd843783          	ld	a5,-40(s0)
    800075f8:	6b9c                	ld	a5,16(a5)
    800075fa:	fcc42703          	lw	a4,-52(s0)
    800075fe:	863a                	mv	a2,a4
    80007600:	fd043583          	ld	a1,-48(s0)
    80007604:	853e                	mv	a0,a5
    80007606:	00000097          	auipc	ra,0x0
    8000760a:	676080e7          	jalr	1654(ra) # 80007c7c <piperead>
    8000760e:	87aa                	mv	a5,a0
    80007610:	fef42623          	sw	a5,-20(s0)
    80007614:	a209                	j	80007716 <fileread+0x158>
  } else if(f->type == FD_DEVICE){
    80007616:	fd843783          	ld	a5,-40(s0)
    8000761a:	439c                	lw	a5,0(a5)
    8000761c:	873e                	mv	a4,a5
    8000761e:	478d                	li	a5,3
    80007620:	06f71863          	bne	a4,a5,80007690 <fileread+0xd2>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80007624:	fd843783          	ld	a5,-40(s0)
    80007628:	02479783          	lh	a5,36(a5)
    8000762c:	2781                	sext.w	a5,a5
    8000762e:	0207c863          	bltz	a5,8000765e <fileread+0xa0>
    80007632:	fd843783          	ld	a5,-40(s0)
    80007636:	02479783          	lh	a5,36(a5)
    8000763a:	0007871b          	sext.w	a4,a5
    8000763e:	47a5                	li	a5,9
    80007640:	00e7cf63          	blt	a5,a4,8000765e <fileread+0xa0>
    80007644:	fd843783          	ld	a5,-40(s0)
    80007648:	02479783          	lh	a5,36(a5)
    8000764c:	2781                	sext.w	a5,a5
    8000764e:	0049d717          	auipc	a4,0x49d
    80007652:	6c270713          	addi	a4,a4,1730 # 804a4d10 <devsw>
    80007656:	0792                	slli	a5,a5,0x4
    80007658:	97ba                	add	a5,a5,a4
    8000765a:	639c                	ld	a5,0(a5)
    8000765c:	e399                	bnez	a5,80007662 <fileread+0xa4>
      return -1;
    8000765e:	57fd                	li	a5,-1
    80007660:	a86d                	j	8000771a <fileread+0x15c>
    r = devsw[f->major].read(1, addr, n);
    80007662:	fd843783          	ld	a5,-40(s0)
    80007666:	02479783          	lh	a5,36(a5)
    8000766a:	2781                	sext.w	a5,a5
    8000766c:	0049d717          	auipc	a4,0x49d
    80007670:	6a470713          	addi	a4,a4,1700 # 804a4d10 <devsw>
    80007674:	0792                	slli	a5,a5,0x4
    80007676:	97ba                	add	a5,a5,a4
    80007678:	6398                	ld	a4,0(a5)
    8000767a:	fcc42783          	lw	a5,-52(s0)
    8000767e:	863e                	mv	a2,a5
    80007680:	fd043583          	ld	a1,-48(s0)
    80007684:	4505                	li	a0,1
    80007686:	9702                	jalr	a4
    80007688:	87aa                	mv	a5,a0
    8000768a:	fef42623          	sw	a5,-20(s0)
    8000768e:	a061                	j	80007716 <fileread+0x158>
  } else if(f->type == FD_INODE){
    80007690:	fd843783          	ld	a5,-40(s0)
    80007694:	439c                	lw	a5,0(a5)
    80007696:	873e                	mv	a4,a5
    80007698:	4789                	li	a5,2
    8000769a:	06f71663          	bne	a4,a5,80007706 <fileread+0x148>
    ilock(f->ip);
    8000769e:	fd843783          	ld	a5,-40(s0)
    800076a2:	6f9c                	ld	a5,24(a5)
    800076a4:	853e                	mv	a0,a5
    800076a6:	ffffe097          	auipc	ra,0xffffe
    800076aa:	66a080e7          	jalr	1642(ra) # 80005d10 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    800076ae:	fd843783          	ld	a5,-40(s0)
    800076b2:	6f88                	ld	a0,24(a5)
    800076b4:	fd843783          	ld	a5,-40(s0)
    800076b8:	539c                	lw	a5,32(a5)
    800076ba:	fcc42703          	lw	a4,-52(s0)
    800076be:	86be                	mv	a3,a5
    800076c0:	fd043603          	ld	a2,-48(s0)
    800076c4:	4585                	li	a1,1
    800076c6:	fffff097          	auipc	ra,0xfffff
    800076ca:	be0080e7          	jalr	-1056(ra) # 800062a6 <readi>
    800076ce:	87aa                	mv	a5,a0
    800076d0:	fef42623          	sw	a5,-20(s0)
    800076d4:	fec42783          	lw	a5,-20(s0)
    800076d8:	2781                	sext.w	a5,a5
    800076da:	00f05d63          	blez	a5,800076f4 <fileread+0x136>
      f->off += r;
    800076de:	fd843783          	ld	a5,-40(s0)
    800076e2:	5398                	lw	a4,32(a5)
    800076e4:	fec42783          	lw	a5,-20(s0)
    800076e8:	9fb9                	addw	a5,a5,a4
    800076ea:	0007871b          	sext.w	a4,a5
    800076ee:	fd843783          	ld	a5,-40(s0)
    800076f2:	d398                	sw	a4,32(a5)
    iunlock(f->ip);
    800076f4:	fd843783          	ld	a5,-40(s0)
    800076f8:	6f9c                	ld	a5,24(a5)
    800076fa:	853e                	mv	a0,a5
    800076fc:	ffffe097          	auipc	ra,0xffffe
    80007700:	748080e7          	jalr	1864(ra) # 80005e44 <iunlock>
    80007704:	a809                	j	80007716 <fileread+0x158>
  } else {
    panic("fileread");
    80007706:	00004517          	auipc	a0,0x4
    8000770a:	05250513          	addi	a0,a0,82 # 8000b758 <etext+0x758>
    8000770e:	ffff9097          	auipc	ra,0xffff9
    80007712:	56c080e7          	jalr	1388(ra) # 80000c7a <panic>
  }

  return r;
    80007716:	fec42783          	lw	a5,-20(s0)
}
    8000771a:	853e                	mv	a0,a5
    8000771c:	70e2                	ld	ra,56(sp)
    8000771e:	7442                	ld	s0,48(sp)
    80007720:	6121                	addi	sp,sp,64
    80007722:	8082                	ret

0000000080007724 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80007724:	715d                	addi	sp,sp,-80
    80007726:	e486                	sd	ra,72(sp)
    80007728:	e0a2                	sd	s0,64(sp)
    8000772a:	0880                	addi	s0,sp,80
    8000772c:	fca43423          	sd	a0,-56(s0)
    80007730:	fcb43023          	sd	a1,-64(s0)
    80007734:	87b2                	mv	a5,a2
    80007736:	faf42e23          	sw	a5,-68(s0)
  int r, ret = 0;
    8000773a:	fe042623          	sw	zero,-20(s0)

  if(f->writable == 0)
    8000773e:	fc843783          	ld	a5,-56(s0)
    80007742:	0097c783          	lbu	a5,9(a5)
    80007746:	e399                	bnez	a5,8000774c <filewrite+0x28>
    return -1;
    80007748:	57fd                	li	a5,-1
    8000774a:	a2c5                	j	8000792a <filewrite+0x206>

  if(f->type == FD_PIPE){
    8000774c:	fc843783          	ld	a5,-56(s0)
    80007750:	439c                	lw	a5,0(a5)
    80007752:	873e                	mv	a4,a5
    80007754:	4785                	li	a5,1
    80007756:	02f71363          	bne	a4,a5,8000777c <filewrite+0x58>
    ret = pipewrite(f->pipe, addr, n);
    8000775a:	fc843783          	ld	a5,-56(s0)
    8000775e:	6b9c                	ld	a5,16(a5)
    80007760:	fbc42703          	lw	a4,-68(s0)
    80007764:	863a                	mv	a2,a4
    80007766:	fc043583          	ld	a1,-64(s0)
    8000776a:	853e                	mv	a0,a5
    8000776c:	00000097          	auipc	ra,0x0
    80007770:	3c4080e7          	jalr	964(ra) # 80007b30 <pipewrite>
    80007774:	87aa                	mv	a5,a0
    80007776:	fef42623          	sw	a5,-20(s0)
    8000777a:	a275                	j	80007926 <filewrite+0x202>
  } else if(f->type == FD_DEVICE){
    8000777c:	fc843783          	ld	a5,-56(s0)
    80007780:	439c                	lw	a5,0(a5)
    80007782:	873e                	mv	a4,a5
    80007784:	478d                	li	a5,3
    80007786:	06f71863          	bne	a4,a5,800077f6 <filewrite+0xd2>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    8000778a:	fc843783          	ld	a5,-56(s0)
    8000778e:	02479783          	lh	a5,36(a5)
    80007792:	2781                	sext.w	a5,a5
    80007794:	0207c863          	bltz	a5,800077c4 <filewrite+0xa0>
    80007798:	fc843783          	ld	a5,-56(s0)
    8000779c:	02479783          	lh	a5,36(a5)
    800077a0:	0007871b          	sext.w	a4,a5
    800077a4:	47a5                	li	a5,9
    800077a6:	00e7cf63          	blt	a5,a4,800077c4 <filewrite+0xa0>
    800077aa:	fc843783          	ld	a5,-56(s0)
    800077ae:	02479783          	lh	a5,36(a5)
    800077b2:	2781                	sext.w	a5,a5
    800077b4:	0049d717          	auipc	a4,0x49d
    800077b8:	55c70713          	addi	a4,a4,1372 # 804a4d10 <devsw>
    800077bc:	0792                	slli	a5,a5,0x4
    800077be:	97ba                	add	a5,a5,a4
    800077c0:	679c                	ld	a5,8(a5)
    800077c2:	e399                	bnez	a5,800077c8 <filewrite+0xa4>
      return -1;
    800077c4:	57fd                	li	a5,-1
    800077c6:	a295                	j	8000792a <filewrite+0x206>
    ret = devsw[f->major].write(1, addr, n);
    800077c8:	fc843783          	ld	a5,-56(s0)
    800077cc:	02479783          	lh	a5,36(a5)
    800077d0:	2781                	sext.w	a5,a5
    800077d2:	0049d717          	auipc	a4,0x49d
    800077d6:	53e70713          	addi	a4,a4,1342 # 804a4d10 <devsw>
    800077da:	0792                	slli	a5,a5,0x4
    800077dc:	97ba                	add	a5,a5,a4
    800077de:	6798                	ld	a4,8(a5)
    800077e0:	fbc42783          	lw	a5,-68(s0)
    800077e4:	863e                	mv	a2,a5
    800077e6:	fc043583          	ld	a1,-64(s0)
    800077ea:	4505                	li	a0,1
    800077ec:	9702                	jalr	a4
    800077ee:	87aa                	mv	a5,a0
    800077f0:	fef42623          	sw	a5,-20(s0)
    800077f4:	aa0d                	j	80007926 <filewrite+0x202>
  } else if(f->type == FD_INODE){
    800077f6:	fc843783          	ld	a5,-56(s0)
    800077fa:	439c                	lw	a5,0(a5)
    800077fc:	873e                	mv	a4,a5
    800077fe:	4789                	li	a5,2
    80007800:	10f71b63          	bne	a4,a5,80007916 <filewrite+0x1f2>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    80007804:	6785                	lui	a5,0x1
    80007806:	c0078793          	addi	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    8000780a:	fef42023          	sw	a5,-32(s0)
    int i = 0;
    8000780e:	fe042423          	sw	zero,-24(s0)
    while(i < n){
    80007812:	a0f9                	j	800078e0 <filewrite+0x1bc>
      int n1 = n - i;
    80007814:	fbc42783          	lw	a5,-68(s0)
    80007818:	873e                	mv	a4,a5
    8000781a:	fe842783          	lw	a5,-24(s0)
    8000781e:	40f707bb          	subw	a5,a4,a5
    80007822:	fef42223          	sw	a5,-28(s0)
      if(n1 > max)
    80007826:	fe442783          	lw	a5,-28(s0)
    8000782a:	873e                	mv	a4,a5
    8000782c:	fe042783          	lw	a5,-32(s0)
    80007830:	2701                	sext.w	a4,a4
    80007832:	2781                	sext.w	a5,a5
    80007834:	00e7d663          	bge	a5,a4,80007840 <filewrite+0x11c>
        n1 = max;
    80007838:	fe042783          	lw	a5,-32(s0)
    8000783c:	fef42223          	sw	a5,-28(s0)

      begin_op();
    80007840:	fffff097          	auipc	ra,0xfffff
    80007844:	538080e7          	jalr	1336(ra) # 80006d78 <begin_op>
      ilock(f->ip);
    80007848:	fc843783          	ld	a5,-56(s0)
    8000784c:	6f9c                	ld	a5,24(a5)
    8000784e:	853e                	mv	a0,a5
    80007850:	ffffe097          	auipc	ra,0xffffe
    80007854:	4c0080e7          	jalr	1216(ra) # 80005d10 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80007858:	fc843783          	ld	a5,-56(s0)
    8000785c:	6f88                	ld	a0,24(a5)
    8000785e:	fe842703          	lw	a4,-24(s0)
    80007862:	fc043783          	ld	a5,-64(s0)
    80007866:	00f70633          	add	a2,a4,a5
    8000786a:	fc843783          	ld	a5,-56(s0)
    8000786e:	539c                	lw	a5,32(a5)
    80007870:	fe442703          	lw	a4,-28(s0)
    80007874:	86be                	mv	a3,a5
    80007876:	4585                	li	a1,1
    80007878:	fffff097          	auipc	ra,0xfffff
    8000787c:	bbe080e7          	jalr	-1090(ra) # 80006436 <writei>
    80007880:	87aa                	mv	a5,a0
    80007882:	fcf42e23          	sw	a5,-36(s0)
    80007886:	fdc42783          	lw	a5,-36(s0)
    8000788a:	2781                	sext.w	a5,a5
    8000788c:	00f05d63          	blez	a5,800078a6 <filewrite+0x182>
        f->off += r;
    80007890:	fc843783          	ld	a5,-56(s0)
    80007894:	5398                	lw	a4,32(a5)
    80007896:	fdc42783          	lw	a5,-36(s0)
    8000789a:	9fb9                	addw	a5,a5,a4
    8000789c:	0007871b          	sext.w	a4,a5
    800078a0:	fc843783          	ld	a5,-56(s0)
    800078a4:	d398                	sw	a4,32(a5)
      iunlock(f->ip);
    800078a6:	fc843783          	ld	a5,-56(s0)
    800078aa:	6f9c                	ld	a5,24(a5)
    800078ac:	853e                	mv	a0,a5
    800078ae:	ffffe097          	auipc	ra,0xffffe
    800078b2:	596080e7          	jalr	1430(ra) # 80005e44 <iunlock>
      end_op();
    800078b6:	fffff097          	auipc	ra,0xfffff
    800078ba:	584080e7          	jalr	1412(ra) # 80006e3a <end_op>

      if(r != n1){
    800078be:	fdc42783          	lw	a5,-36(s0)
    800078c2:	873e                	mv	a4,a5
    800078c4:	fe442783          	lw	a5,-28(s0)
    800078c8:	2701                	sext.w	a4,a4
    800078ca:	2781                	sext.w	a5,a5
    800078cc:	02f71463          	bne	a4,a5,800078f4 <filewrite+0x1d0>
        // error from writei
        break;
      }
      i += r;
    800078d0:	fe842783          	lw	a5,-24(s0)
    800078d4:	873e                	mv	a4,a5
    800078d6:	fdc42783          	lw	a5,-36(s0)
    800078da:	9fb9                	addw	a5,a5,a4
    800078dc:	fef42423          	sw	a5,-24(s0)
    while(i < n){
    800078e0:	fe842783          	lw	a5,-24(s0)
    800078e4:	873e                	mv	a4,a5
    800078e6:	fbc42783          	lw	a5,-68(s0)
    800078ea:	2701                	sext.w	a4,a4
    800078ec:	2781                	sext.w	a5,a5
    800078ee:	f2f743e3          	blt	a4,a5,80007814 <filewrite+0xf0>
    800078f2:	a011                	j	800078f6 <filewrite+0x1d2>
        break;
    800078f4:	0001                	nop
    }
    ret = (i == n ? n : -1);
    800078f6:	fe842783          	lw	a5,-24(s0)
    800078fa:	873e                	mv	a4,a5
    800078fc:	fbc42783          	lw	a5,-68(s0)
    80007900:	2701                	sext.w	a4,a4
    80007902:	2781                	sext.w	a5,a5
    80007904:	00f71563          	bne	a4,a5,8000790e <filewrite+0x1ea>
    80007908:	fbc42783          	lw	a5,-68(s0)
    8000790c:	a011                	j	80007910 <filewrite+0x1ec>
    8000790e:	57fd                	li	a5,-1
    80007910:	fef42623          	sw	a5,-20(s0)
    80007914:	a809                	j	80007926 <filewrite+0x202>
  } else {
    panic("filewrite");
    80007916:	00004517          	auipc	a0,0x4
    8000791a:	e5250513          	addi	a0,a0,-430 # 8000b768 <etext+0x768>
    8000791e:	ffff9097          	auipc	ra,0xffff9
    80007922:	35c080e7          	jalr	860(ra) # 80000c7a <panic>
  }

  return ret;
    80007926:	fec42783          	lw	a5,-20(s0)
}
    8000792a:	853e                	mv	a0,a5
    8000792c:	60a6                	ld	ra,72(sp)
    8000792e:	6406                	ld	s0,64(sp)
    80007930:	6161                	addi	sp,sp,80
    80007932:	8082                	ret

0000000080007934 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80007934:	7179                	addi	sp,sp,-48
    80007936:	f406                	sd	ra,40(sp)
    80007938:	f022                	sd	s0,32(sp)
    8000793a:	1800                	addi	s0,sp,48
    8000793c:	fca43c23          	sd	a0,-40(s0)
    80007940:	fcb43823          	sd	a1,-48(s0)
  struct pipe *pi;

  pi = 0;
    80007944:	fe043423          	sd	zero,-24(s0)
  *f0 = *f1 = 0;
    80007948:	fd043783          	ld	a5,-48(s0)
    8000794c:	0007b023          	sd	zero,0(a5)
    80007950:	fd043783          	ld	a5,-48(s0)
    80007954:	6398                	ld	a4,0(a5)
    80007956:	fd843783          	ld	a5,-40(s0)
    8000795a:	e398                	sd	a4,0(a5)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    8000795c:	00000097          	auipc	ra,0x0
    80007960:	9cc080e7          	jalr	-1588(ra) # 80007328 <filealloc>
    80007964:	872a                	mv	a4,a0
    80007966:	fd843783          	ld	a5,-40(s0)
    8000796a:	e398                	sd	a4,0(a5)
    8000796c:	fd843783          	ld	a5,-40(s0)
    80007970:	639c                	ld	a5,0(a5)
    80007972:	c3e9                	beqz	a5,80007a34 <pipealloc+0x100>
    80007974:	00000097          	auipc	ra,0x0
    80007978:	9b4080e7          	jalr	-1612(ra) # 80007328 <filealloc>
    8000797c:	872a                	mv	a4,a0
    8000797e:	fd043783          	ld	a5,-48(s0)
    80007982:	e398                	sd	a4,0(a5)
    80007984:	fd043783          	ld	a5,-48(s0)
    80007988:	639c                	ld	a5,0(a5)
    8000798a:	c7cd                	beqz	a5,80007a34 <pipealloc+0x100>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    8000798c:	ffff9097          	auipc	ra,0xffff9
    80007990:	78a080e7          	jalr	1930(ra) # 80001116 <kalloc>
    80007994:	fea43423          	sd	a0,-24(s0)
    80007998:	fe843783          	ld	a5,-24(s0)
    8000799c:	cfd1                	beqz	a5,80007a38 <pipealloc+0x104>
    goto bad;
  pi->readopen = 1;
    8000799e:	fe843783          	ld	a5,-24(s0)
    800079a2:	4705                	li	a4,1
    800079a4:	22e7a023          	sw	a4,544(a5)
  pi->writeopen = 1;
    800079a8:	fe843783          	ld	a5,-24(s0)
    800079ac:	4705                	li	a4,1
    800079ae:	22e7a223          	sw	a4,548(a5)
  pi->nwrite = 0;
    800079b2:	fe843783          	ld	a5,-24(s0)
    800079b6:	2007ae23          	sw	zero,540(a5)
  pi->nread = 0;
    800079ba:	fe843783          	ld	a5,-24(s0)
    800079be:	2007ac23          	sw	zero,536(a5)
  initlock(&pi->lock, "pipe");
    800079c2:	fe843783          	ld	a5,-24(s0)
    800079c6:	00004597          	auipc	a1,0x4
    800079ca:	db258593          	addi	a1,a1,-590 # 8000b778 <etext+0x778>
    800079ce:	853e                	mv	a0,a5
    800079d0:	ffffa097          	auipc	ra,0xffffa
    800079d4:	86a080e7          	jalr	-1942(ra) # 8000123a <initlock>
  (*f0)->type = FD_PIPE;
    800079d8:	fd843783          	ld	a5,-40(s0)
    800079dc:	639c                	ld	a5,0(a5)
    800079de:	4705                	li	a4,1
    800079e0:	c398                	sw	a4,0(a5)
  (*f0)->readable = 1;
    800079e2:	fd843783          	ld	a5,-40(s0)
    800079e6:	639c                	ld	a5,0(a5)
    800079e8:	4705                	li	a4,1
    800079ea:	00e78423          	sb	a4,8(a5)
  (*f0)->writable = 0;
    800079ee:	fd843783          	ld	a5,-40(s0)
    800079f2:	639c                	ld	a5,0(a5)
    800079f4:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    800079f8:	fd843783          	ld	a5,-40(s0)
    800079fc:	639c                	ld	a5,0(a5)
    800079fe:	fe843703          	ld	a4,-24(s0)
    80007a02:	eb98                	sd	a4,16(a5)
  (*f1)->type = FD_PIPE;
    80007a04:	fd043783          	ld	a5,-48(s0)
    80007a08:	639c                	ld	a5,0(a5)
    80007a0a:	4705                	li	a4,1
    80007a0c:	c398                	sw	a4,0(a5)
  (*f1)->readable = 0;
    80007a0e:	fd043783          	ld	a5,-48(s0)
    80007a12:	639c                	ld	a5,0(a5)
    80007a14:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80007a18:	fd043783          	ld	a5,-48(s0)
    80007a1c:	639c                	ld	a5,0(a5)
    80007a1e:	4705                	li	a4,1
    80007a20:	00e784a3          	sb	a4,9(a5)
  (*f1)->pipe = pi;
    80007a24:	fd043783          	ld	a5,-48(s0)
    80007a28:	639c                	ld	a5,0(a5)
    80007a2a:	fe843703          	ld	a4,-24(s0)
    80007a2e:	eb98                	sd	a4,16(a5)
  return 0;
    80007a30:	4781                	li	a5,0
    80007a32:	a0b1                	j	80007a7e <pipealloc+0x14a>
    goto bad;
    80007a34:	0001                	nop
    80007a36:	a011                	j	80007a3a <pipealloc+0x106>
    goto bad;
    80007a38:	0001                	nop

 bad:
  if(pi)
    80007a3a:	fe843783          	ld	a5,-24(s0)
    80007a3e:	c799                	beqz	a5,80007a4c <pipealloc+0x118>
    kfree((char*)pi);
    80007a40:	fe843503          	ld	a0,-24(s0)
    80007a44:	ffff9097          	auipc	ra,0xffff9
    80007a48:	62e080e7          	jalr	1582(ra) # 80001072 <kfree>
  if(*f0)
    80007a4c:	fd843783          	ld	a5,-40(s0)
    80007a50:	639c                	ld	a5,0(a5)
    80007a52:	cb89                	beqz	a5,80007a64 <pipealloc+0x130>
    fileclose(*f0);
    80007a54:	fd843783          	ld	a5,-40(s0)
    80007a58:	639c                	ld	a5,0(a5)
    80007a5a:	853e                	mv	a0,a5
    80007a5c:	00000097          	auipc	ra,0x0
    80007a60:	9b6080e7          	jalr	-1610(ra) # 80007412 <fileclose>
  if(*f1)
    80007a64:	fd043783          	ld	a5,-48(s0)
    80007a68:	639c                	ld	a5,0(a5)
    80007a6a:	cb89                	beqz	a5,80007a7c <pipealloc+0x148>
    fileclose(*f1);
    80007a6c:	fd043783          	ld	a5,-48(s0)
    80007a70:	639c                	ld	a5,0(a5)
    80007a72:	853e                	mv	a0,a5
    80007a74:	00000097          	auipc	ra,0x0
    80007a78:	99e080e7          	jalr	-1634(ra) # 80007412 <fileclose>
  return -1;
    80007a7c:	57fd                	li	a5,-1
}
    80007a7e:	853e                	mv	a0,a5
    80007a80:	70a2                	ld	ra,40(sp)
    80007a82:	7402                	ld	s0,32(sp)
    80007a84:	6145                	addi	sp,sp,48
    80007a86:	8082                	ret

0000000080007a88 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80007a88:	1101                	addi	sp,sp,-32
    80007a8a:	ec06                	sd	ra,24(sp)
    80007a8c:	e822                	sd	s0,16(sp)
    80007a8e:	1000                	addi	s0,sp,32
    80007a90:	fea43423          	sd	a0,-24(s0)
    80007a94:	87ae                	mv	a5,a1
    80007a96:	fef42223          	sw	a5,-28(s0)
  acquire(&pi->lock);
    80007a9a:	fe843783          	ld	a5,-24(s0)
    80007a9e:	853e                	mv	a0,a5
    80007aa0:	ffff9097          	auipc	ra,0xffff9
    80007aa4:	7ca080e7          	jalr	1994(ra) # 8000126a <acquire>
  if(writable){
    80007aa8:	fe442783          	lw	a5,-28(s0)
    80007aac:	2781                	sext.w	a5,a5
    80007aae:	cf99                	beqz	a5,80007acc <pipeclose+0x44>
    pi->writeopen = 0;
    80007ab0:	fe843783          	ld	a5,-24(s0)
    80007ab4:	2207a223          	sw	zero,548(a5)
    wakeup(&pi->nread);
    80007ab8:	fe843783          	ld	a5,-24(s0)
    80007abc:	21878793          	addi	a5,a5,536
    80007ac0:	853e                	mv	a0,a5
    80007ac2:	ffffc097          	auipc	ra,0xffffc
    80007ac6:	edc080e7          	jalr	-292(ra) # 8000399e <wakeup>
    80007aca:	a831                	j	80007ae6 <pipeclose+0x5e>
  } else {
    pi->readopen = 0;
    80007acc:	fe843783          	ld	a5,-24(s0)
    80007ad0:	2207a023          	sw	zero,544(a5)
    wakeup(&pi->nwrite);
    80007ad4:	fe843783          	ld	a5,-24(s0)
    80007ad8:	21c78793          	addi	a5,a5,540
    80007adc:	853e                	mv	a0,a5
    80007ade:	ffffc097          	auipc	ra,0xffffc
    80007ae2:	ec0080e7          	jalr	-320(ra) # 8000399e <wakeup>
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80007ae6:	fe843783          	ld	a5,-24(s0)
    80007aea:	2207a783          	lw	a5,544(a5)
    80007aee:	e785                	bnez	a5,80007b16 <pipeclose+0x8e>
    80007af0:	fe843783          	ld	a5,-24(s0)
    80007af4:	2247a783          	lw	a5,548(a5)
    80007af8:	ef99                	bnez	a5,80007b16 <pipeclose+0x8e>
    release(&pi->lock);
    80007afa:	fe843783          	ld	a5,-24(s0)
    80007afe:	853e                	mv	a0,a5
    80007b00:	ffff9097          	auipc	ra,0xffff9
    80007b04:	7ce080e7          	jalr	1998(ra) # 800012ce <release>
    kfree((char*)pi);
    80007b08:	fe843503          	ld	a0,-24(s0)
    80007b0c:	ffff9097          	auipc	ra,0xffff9
    80007b10:	566080e7          	jalr	1382(ra) # 80001072 <kfree>
    80007b14:	a809                	j	80007b26 <pipeclose+0x9e>
  } else
    release(&pi->lock);
    80007b16:	fe843783          	ld	a5,-24(s0)
    80007b1a:	853e                	mv	a0,a5
    80007b1c:	ffff9097          	auipc	ra,0xffff9
    80007b20:	7b2080e7          	jalr	1970(ra) # 800012ce <release>
}
    80007b24:	0001                	nop
    80007b26:	0001                	nop
    80007b28:	60e2                	ld	ra,24(sp)
    80007b2a:	6442                	ld	s0,16(sp)
    80007b2c:	6105                	addi	sp,sp,32
    80007b2e:	8082                	ret

0000000080007b30 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80007b30:	715d                	addi	sp,sp,-80
    80007b32:	e486                	sd	ra,72(sp)
    80007b34:	e0a2                	sd	s0,64(sp)
    80007b36:	0880                	addi	s0,sp,80
    80007b38:	fca43423          	sd	a0,-56(s0)
    80007b3c:	fcb43023          	sd	a1,-64(s0)
    80007b40:	87b2                	mv	a5,a2
    80007b42:	faf42e23          	sw	a5,-68(s0)
  int i = 0;
    80007b46:	fe042623          	sw	zero,-20(s0)
  struct proc *pr = myproc();
    80007b4a:	ffffb097          	auipc	ra,0xffffb
    80007b4e:	ece080e7          	jalr	-306(ra) # 80002a18 <myproc>
    80007b52:	fea43023          	sd	a0,-32(s0)

  acquire(&pi->lock);
    80007b56:	fc843783          	ld	a5,-56(s0)
    80007b5a:	853e                	mv	a0,a5
    80007b5c:	ffff9097          	auipc	ra,0xffff9
    80007b60:	70e080e7          	jalr	1806(ra) # 8000126a <acquire>
  while(i < n){
    80007b64:	a8d1                	j	80007c38 <pipewrite+0x108>
    if(pi->readopen == 0 || pr->killed){
    80007b66:	fc843783          	ld	a5,-56(s0)
    80007b6a:	2207a783          	lw	a5,544(a5)
    80007b6e:	c789                	beqz	a5,80007b78 <pipewrite+0x48>
    80007b70:	fe043783          	ld	a5,-32(s0)
    80007b74:	579c                	lw	a5,40(a5)
    80007b76:	cb91                	beqz	a5,80007b8a <pipewrite+0x5a>
      release(&pi->lock);
    80007b78:	fc843783          	ld	a5,-56(s0)
    80007b7c:	853e                	mv	a0,a5
    80007b7e:	ffff9097          	auipc	ra,0xffff9
    80007b82:	750080e7          	jalr	1872(ra) # 800012ce <release>
      return -1;
    80007b86:	57fd                	li	a5,-1
    80007b88:	a0ed                	j	80007c72 <pipewrite+0x142>
    }
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80007b8a:	fc843783          	ld	a5,-56(s0)
    80007b8e:	21c7a703          	lw	a4,540(a5)
    80007b92:	fc843783          	ld	a5,-56(s0)
    80007b96:	2187a783          	lw	a5,536(a5)
    80007b9a:	2007879b          	addiw	a5,a5,512
    80007b9e:	2781                	sext.w	a5,a5
    80007ba0:	02f71863          	bne	a4,a5,80007bd0 <pipewrite+0xa0>
      wakeup(&pi->nread);
    80007ba4:	fc843783          	ld	a5,-56(s0)
    80007ba8:	21878793          	addi	a5,a5,536
    80007bac:	853e                	mv	a0,a5
    80007bae:	ffffc097          	auipc	ra,0xffffc
    80007bb2:	df0080e7          	jalr	-528(ra) # 8000399e <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80007bb6:	fc843783          	ld	a5,-56(s0)
    80007bba:	21c78793          	addi	a5,a5,540
    80007bbe:	fc843703          	ld	a4,-56(s0)
    80007bc2:	85ba                	mv	a1,a4
    80007bc4:	853e                	mv	a0,a5
    80007bc6:	ffffc097          	auipc	ra,0xffffc
    80007bca:	d5c080e7          	jalr	-676(ra) # 80003922 <sleep>
    80007bce:	a0ad                	j	80007c38 <pipewrite+0x108>
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80007bd0:	fe043783          	ld	a5,-32(s0)
    80007bd4:	6ba8                	ld	a0,80(a5)
    80007bd6:	fec42703          	lw	a4,-20(s0)
    80007bda:	fc043783          	ld	a5,-64(s0)
    80007bde:	973e                	add	a4,a4,a5
    80007be0:	fdf40793          	addi	a5,s0,-33
    80007be4:	4685                	li	a3,1
    80007be6:	863a                	mv	a2,a4
    80007be8:	85be                	mv	a1,a5
    80007bea:	ffffb097          	auipc	ra,0xffffb
    80007bee:	8aa080e7          	jalr	-1878(ra) # 80002494 <copyin>
    80007bf2:	87aa                	mv	a5,a0
    80007bf4:	873e                	mv	a4,a5
    80007bf6:	57fd                	li	a5,-1
    80007bf8:	04f70a63          	beq	a4,a5,80007c4c <pipewrite+0x11c>
        break;
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80007bfc:	fc843783          	ld	a5,-56(s0)
    80007c00:	21c7a783          	lw	a5,540(a5)
    80007c04:	2781                	sext.w	a5,a5
    80007c06:	0017871b          	addiw	a4,a5,1
    80007c0a:	0007069b          	sext.w	a3,a4
    80007c0e:	fc843703          	ld	a4,-56(s0)
    80007c12:	20d72e23          	sw	a3,540(a4)
    80007c16:	1ff7f793          	andi	a5,a5,511
    80007c1a:	2781                	sext.w	a5,a5
    80007c1c:	fdf44703          	lbu	a4,-33(s0)
    80007c20:	fc843683          	ld	a3,-56(s0)
    80007c24:	1782                	slli	a5,a5,0x20
    80007c26:	9381                	srli	a5,a5,0x20
    80007c28:	97b6                	add	a5,a5,a3
    80007c2a:	00e78c23          	sb	a4,24(a5)
      i++;
    80007c2e:	fec42783          	lw	a5,-20(s0)
    80007c32:	2785                	addiw	a5,a5,1
    80007c34:	fef42623          	sw	a5,-20(s0)
  while(i < n){
    80007c38:	fec42783          	lw	a5,-20(s0)
    80007c3c:	873e                	mv	a4,a5
    80007c3e:	fbc42783          	lw	a5,-68(s0)
    80007c42:	2701                	sext.w	a4,a4
    80007c44:	2781                	sext.w	a5,a5
    80007c46:	f2f740e3          	blt	a4,a5,80007b66 <pipewrite+0x36>
    80007c4a:	a011                	j	80007c4e <pipewrite+0x11e>
        break;
    80007c4c:	0001                	nop
    }
  }
  wakeup(&pi->nread);
    80007c4e:	fc843783          	ld	a5,-56(s0)
    80007c52:	21878793          	addi	a5,a5,536
    80007c56:	853e                	mv	a0,a5
    80007c58:	ffffc097          	auipc	ra,0xffffc
    80007c5c:	d46080e7          	jalr	-698(ra) # 8000399e <wakeup>
  release(&pi->lock);
    80007c60:	fc843783          	ld	a5,-56(s0)
    80007c64:	853e                	mv	a0,a5
    80007c66:	ffff9097          	auipc	ra,0xffff9
    80007c6a:	668080e7          	jalr	1640(ra) # 800012ce <release>

  return i;
    80007c6e:	fec42783          	lw	a5,-20(s0)
}
    80007c72:	853e                	mv	a0,a5
    80007c74:	60a6                	ld	ra,72(sp)
    80007c76:	6406                	ld	s0,64(sp)
    80007c78:	6161                	addi	sp,sp,80
    80007c7a:	8082                	ret

0000000080007c7c <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80007c7c:	715d                	addi	sp,sp,-80
    80007c7e:	e486                	sd	ra,72(sp)
    80007c80:	e0a2                	sd	s0,64(sp)
    80007c82:	0880                	addi	s0,sp,80
    80007c84:	fca43423          	sd	a0,-56(s0)
    80007c88:	fcb43023          	sd	a1,-64(s0)
    80007c8c:	87b2                	mv	a5,a2
    80007c8e:	faf42e23          	sw	a5,-68(s0)
  int i;
  struct proc *pr = myproc();
    80007c92:	ffffb097          	auipc	ra,0xffffb
    80007c96:	d86080e7          	jalr	-634(ra) # 80002a18 <myproc>
    80007c9a:	fea43023          	sd	a0,-32(s0)
  char ch;

  acquire(&pi->lock);
    80007c9e:	fc843783          	ld	a5,-56(s0)
    80007ca2:	853e                	mv	a0,a5
    80007ca4:	ffff9097          	auipc	ra,0xffff9
    80007ca8:	5c6080e7          	jalr	1478(ra) # 8000126a <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80007cac:	a815                	j	80007ce0 <piperead+0x64>
    if(pr->killed){
    80007cae:	fe043783          	ld	a5,-32(s0)
    80007cb2:	579c                	lw	a5,40(a5)
    80007cb4:	cb91                	beqz	a5,80007cc8 <piperead+0x4c>
      release(&pi->lock);
    80007cb6:	fc843783          	ld	a5,-56(s0)
    80007cba:	853e                	mv	a0,a5
    80007cbc:	ffff9097          	auipc	ra,0xffff9
    80007cc0:	612080e7          	jalr	1554(ra) # 800012ce <release>
      return -1;
    80007cc4:	57fd                	li	a5,-1
    80007cc6:	a8e5                	j	80007dbe <piperead+0x142>
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80007cc8:	fc843783          	ld	a5,-56(s0)
    80007ccc:	21878793          	addi	a5,a5,536
    80007cd0:	fc843703          	ld	a4,-56(s0)
    80007cd4:	85ba                	mv	a1,a4
    80007cd6:	853e                	mv	a0,a5
    80007cd8:	ffffc097          	auipc	ra,0xffffc
    80007cdc:	c4a080e7          	jalr	-950(ra) # 80003922 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80007ce0:	fc843783          	ld	a5,-56(s0)
    80007ce4:	2187a703          	lw	a4,536(a5)
    80007ce8:	fc843783          	ld	a5,-56(s0)
    80007cec:	21c7a783          	lw	a5,540(a5)
    80007cf0:	00f71763          	bne	a4,a5,80007cfe <piperead+0x82>
    80007cf4:	fc843783          	ld	a5,-56(s0)
    80007cf8:	2247a783          	lw	a5,548(a5)
    80007cfc:	fbcd                	bnez	a5,80007cae <piperead+0x32>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80007cfe:	fe042623          	sw	zero,-20(s0)
    80007d02:	a8bd                	j	80007d80 <piperead+0x104>
    if(pi->nread == pi->nwrite)
    80007d04:	fc843783          	ld	a5,-56(s0)
    80007d08:	2187a703          	lw	a4,536(a5)
    80007d0c:	fc843783          	ld	a5,-56(s0)
    80007d10:	21c7a783          	lw	a5,540(a5)
    80007d14:	08f70063          	beq	a4,a5,80007d94 <piperead+0x118>
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    80007d18:	fc843783          	ld	a5,-56(s0)
    80007d1c:	2187a783          	lw	a5,536(a5)
    80007d20:	2781                	sext.w	a5,a5
    80007d22:	0017871b          	addiw	a4,a5,1
    80007d26:	0007069b          	sext.w	a3,a4
    80007d2a:	fc843703          	ld	a4,-56(s0)
    80007d2e:	20d72c23          	sw	a3,536(a4)
    80007d32:	1ff7f793          	andi	a5,a5,511
    80007d36:	2781                	sext.w	a5,a5
    80007d38:	fc843703          	ld	a4,-56(s0)
    80007d3c:	1782                	slli	a5,a5,0x20
    80007d3e:	9381                	srli	a5,a5,0x20
    80007d40:	97ba                	add	a5,a5,a4
    80007d42:	0187c783          	lbu	a5,24(a5)
    80007d46:	fcf40fa3          	sb	a5,-33(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80007d4a:	fe043783          	ld	a5,-32(s0)
    80007d4e:	6ba8                	ld	a0,80(a5)
    80007d50:	fec42703          	lw	a4,-20(s0)
    80007d54:	fc043783          	ld	a5,-64(s0)
    80007d58:	97ba                	add	a5,a5,a4
    80007d5a:	fdf40713          	addi	a4,s0,-33
    80007d5e:	4685                	li	a3,1
    80007d60:	863a                	mv	a2,a4
    80007d62:	85be                	mv	a1,a5
    80007d64:	ffffa097          	auipc	ra,0xffffa
    80007d68:	662080e7          	jalr	1634(ra) # 800023c6 <copyout>
    80007d6c:	87aa                	mv	a5,a0
    80007d6e:	873e                	mv	a4,a5
    80007d70:	57fd                	li	a5,-1
    80007d72:	02f70363          	beq	a4,a5,80007d98 <piperead+0x11c>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80007d76:	fec42783          	lw	a5,-20(s0)
    80007d7a:	2785                	addiw	a5,a5,1
    80007d7c:	fef42623          	sw	a5,-20(s0)
    80007d80:	fec42783          	lw	a5,-20(s0)
    80007d84:	873e                	mv	a4,a5
    80007d86:	fbc42783          	lw	a5,-68(s0)
    80007d8a:	2701                	sext.w	a4,a4
    80007d8c:	2781                	sext.w	a5,a5
    80007d8e:	f6f74be3          	blt	a4,a5,80007d04 <piperead+0x88>
    80007d92:	a021                	j	80007d9a <piperead+0x11e>
      break;
    80007d94:	0001                	nop
    80007d96:	a011                	j	80007d9a <piperead+0x11e>
      break;
    80007d98:	0001                	nop
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80007d9a:	fc843783          	ld	a5,-56(s0)
    80007d9e:	21c78793          	addi	a5,a5,540
    80007da2:	853e                	mv	a0,a5
    80007da4:	ffffc097          	auipc	ra,0xffffc
    80007da8:	bfa080e7          	jalr	-1030(ra) # 8000399e <wakeup>
  release(&pi->lock);
    80007dac:	fc843783          	ld	a5,-56(s0)
    80007db0:	853e                	mv	a0,a5
    80007db2:	ffff9097          	auipc	ra,0xffff9
    80007db6:	51c080e7          	jalr	1308(ra) # 800012ce <release>
  return i;
    80007dba:	fec42783          	lw	a5,-20(s0)
}
    80007dbe:	853e                	mv	a0,a5
    80007dc0:	60a6                	ld	ra,72(sp)
    80007dc2:	6406                	ld	s0,64(sp)
    80007dc4:	6161                	addi	sp,sp,80
    80007dc6:	8082                	ret

0000000080007dc8 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    80007dc8:	de010113          	addi	sp,sp,-544
    80007dcc:	20113c23          	sd	ra,536(sp)
    80007dd0:	20813823          	sd	s0,528(sp)
    80007dd4:	20913423          	sd	s1,520(sp)
    80007dd8:	1400                	addi	s0,sp,544
    80007dda:	dea43423          	sd	a0,-536(s0)
    80007dde:	deb43023          	sd	a1,-544(s0)
  char *s, *last;
  int i, off;
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80007de2:	fa043c23          	sd	zero,-72(s0)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
    80007de6:	fa043023          	sd	zero,-96(s0)
  struct proc *p = myproc();
    80007dea:	ffffb097          	auipc	ra,0xffffb
    80007dee:	c2e080e7          	jalr	-978(ra) # 80002a18 <myproc>
    80007df2:	f8a43c23          	sd	a0,-104(s0)

  begin_op();
    80007df6:	fffff097          	auipc	ra,0xfffff
    80007dfa:	f82080e7          	jalr	-126(ra) # 80006d78 <begin_op>

  if((ip = namei(path)) == 0){
    80007dfe:	de843503          	ld	a0,-536(s0)
    80007e02:	fffff097          	auipc	ra,0xfffff
    80007e06:	c12080e7          	jalr	-1006(ra) # 80006a14 <namei>
    80007e0a:	faa43423          	sd	a0,-88(s0)
    80007e0e:	fa843783          	ld	a5,-88(s0)
    80007e12:	e799                	bnez	a5,80007e20 <exec+0x58>
    end_op();
    80007e14:	fffff097          	auipc	ra,0xfffff
    80007e18:	026080e7          	jalr	38(ra) # 80006e3a <end_op>
    return -1;
    80007e1c:	57fd                	li	a5,-1
    80007e1e:	a929                	j	80008238 <exec+0x470>
  }
  ilock(ip);
    80007e20:	fa843503          	ld	a0,-88(s0)
    80007e24:	ffffe097          	auipc	ra,0xffffe
    80007e28:	eec080e7          	jalr	-276(ra) # 80005d10 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80007e2c:	e3040793          	addi	a5,s0,-464
    80007e30:	04000713          	li	a4,64
    80007e34:	4681                	li	a3,0
    80007e36:	863e                	mv	a2,a5
    80007e38:	4581                	li	a1,0
    80007e3a:	fa843503          	ld	a0,-88(s0)
    80007e3e:	ffffe097          	auipc	ra,0xffffe
    80007e42:	468080e7          	jalr	1128(ra) # 800062a6 <readi>
    80007e46:	87aa                	mv	a5,a0
    80007e48:	873e                	mv	a4,a5
    80007e4a:	04000793          	li	a5,64
    80007e4e:	36f71f63          	bne	a4,a5,800081cc <exec+0x404>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80007e52:	e3042783          	lw	a5,-464(s0)
    80007e56:	873e                	mv	a4,a5
    80007e58:	464c47b7          	lui	a5,0x464c4
    80007e5c:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80007e60:	36f71863          	bne	a4,a5,800081d0 <exec+0x408>
    goto bad;

  if((pagetable = proc_pagetable(p)) == 0)
    80007e64:	f9843503          	ld	a0,-104(s0)
    80007e68:	ffffb097          	auipc	ra,0xffffb
    80007e6c:	f6e080e7          	jalr	-146(ra) # 80002dd6 <proc_pagetable>
    80007e70:	faa43023          	sd	a0,-96(s0)
    80007e74:	fa043783          	ld	a5,-96(s0)
    80007e78:	34078e63          	beqz	a5,800081d4 <exec+0x40c>
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80007e7c:	fc042623          	sw	zero,-52(s0)
    80007e80:	e5043783          	ld	a5,-432(s0)
    80007e84:	fcf42423          	sw	a5,-56(s0)
    80007e88:	a8e1                	j	80007f60 <exec+0x198>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80007e8a:	df840793          	addi	a5,s0,-520
    80007e8e:	fc842683          	lw	a3,-56(s0)
    80007e92:	03800713          	li	a4,56
    80007e96:	863e                	mv	a2,a5
    80007e98:	4581                	li	a1,0
    80007e9a:	fa843503          	ld	a0,-88(s0)
    80007e9e:	ffffe097          	auipc	ra,0xffffe
    80007ea2:	408080e7          	jalr	1032(ra) # 800062a6 <readi>
    80007ea6:	87aa                	mv	a5,a0
    80007ea8:	873e                	mv	a4,a5
    80007eaa:	03800793          	li	a5,56
    80007eae:	32f71563          	bne	a4,a5,800081d8 <exec+0x410>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
    80007eb2:	df842783          	lw	a5,-520(s0)
    80007eb6:	873e                	mv	a4,a5
    80007eb8:	4785                	li	a5,1
    80007eba:	08f71663          	bne	a4,a5,80007f46 <exec+0x17e>
      continue;
    if(ph.memsz < ph.filesz)
    80007ebe:	e2043703          	ld	a4,-480(s0)
    80007ec2:	e1843783          	ld	a5,-488(s0)
    80007ec6:	30f76b63          	bltu	a4,a5,800081dc <exec+0x414>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80007eca:	e0843703          	ld	a4,-504(s0)
    80007ece:	e2043783          	ld	a5,-480(s0)
    80007ed2:	973e                	add	a4,a4,a5
    80007ed4:	e0843783          	ld	a5,-504(s0)
    80007ed8:	30f76463          	bltu	a4,a5,800081e0 <exec+0x418>
      goto bad;
    uint64 sz1;
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80007edc:	e0843703          	ld	a4,-504(s0)
    80007ee0:	e2043783          	ld	a5,-480(s0)
    80007ee4:	97ba                	add	a5,a5,a4
    80007ee6:	863e                	mv	a2,a5
    80007ee8:	fb843583          	ld	a1,-72(s0)
    80007eec:	fa043503          	ld	a0,-96(s0)
    80007ef0:	ffffa097          	auipc	ra,0xffffa
    80007ef4:	018080e7          	jalr	24(ra) # 80001f08 <uvmalloc>
    80007ef8:	f6a43823          	sd	a0,-144(s0)
    80007efc:	f7043783          	ld	a5,-144(s0)
    80007f00:	2e078263          	beqz	a5,800081e4 <exec+0x41c>
      goto bad;
    sz = sz1;
    80007f04:	f7043783          	ld	a5,-144(s0)
    80007f08:	faf43c23          	sd	a5,-72(s0)
    if((ph.vaddr % PGSIZE) != 0)
    80007f0c:	e0843703          	ld	a4,-504(s0)
    80007f10:	6785                	lui	a5,0x1
    80007f12:	17fd                	addi	a5,a5,-1
    80007f14:	8ff9                	and	a5,a5,a4
    80007f16:	2c079963          	bnez	a5,800081e8 <exec+0x420>
      goto bad;
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80007f1a:	e0843783          	ld	a5,-504(s0)
    80007f1e:	e0043703          	ld	a4,-512(s0)
    80007f22:	0007069b          	sext.w	a3,a4
    80007f26:	e1843703          	ld	a4,-488(s0)
    80007f2a:	2701                	sext.w	a4,a4
    80007f2c:	fa843603          	ld	a2,-88(s0)
    80007f30:	85be                	mv	a1,a5
    80007f32:	fa043503          	ld	a0,-96(s0)
    80007f36:	00000097          	auipc	ra,0x0
    80007f3a:	316080e7          	jalr	790(ra) # 8000824c <loadseg>
    80007f3e:	87aa                	mv	a5,a0
    80007f40:	2a07c663          	bltz	a5,800081ec <exec+0x424>
    80007f44:	a011                	j	80007f48 <exec+0x180>
      continue;
    80007f46:	0001                	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80007f48:	fcc42783          	lw	a5,-52(s0)
    80007f4c:	2785                	addiw	a5,a5,1
    80007f4e:	fcf42623          	sw	a5,-52(s0)
    80007f52:	fc842783          	lw	a5,-56(s0)
    80007f56:	0387879b          	addiw	a5,a5,56
    80007f5a:	2781                	sext.w	a5,a5
    80007f5c:	fcf42423          	sw	a5,-56(s0)
    80007f60:	e6845783          	lhu	a5,-408(s0)
    80007f64:	0007871b          	sext.w	a4,a5
    80007f68:	fcc42783          	lw	a5,-52(s0)
    80007f6c:	2781                	sext.w	a5,a5
    80007f6e:	f0e7cee3          	blt	a5,a4,80007e8a <exec+0xc2>
      goto bad;
  }
  iunlockput(ip);
    80007f72:	fa843503          	ld	a0,-88(s0)
    80007f76:	ffffe097          	auipc	ra,0xffffe
    80007f7a:	ff8080e7          	jalr	-8(ra) # 80005f6e <iunlockput>
  end_op();
    80007f7e:	fffff097          	auipc	ra,0xfffff
    80007f82:	ebc080e7          	jalr	-324(ra) # 80006e3a <end_op>
  ip = 0;
    80007f86:	fa043423          	sd	zero,-88(s0)

  p = myproc();
    80007f8a:	ffffb097          	auipc	ra,0xffffb
    80007f8e:	a8e080e7          	jalr	-1394(ra) # 80002a18 <myproc>
    80007f92:	f8a43c23          	sd	a0,-104(s0)
  uint64 oldsz = p->sz;
    80007f96:	f9843783          	ld	a5,-104(s0)
    80007f9a:	67bc                	ld	a5,72(a5)
    80007f9c:	f8f43823          	sd	a5,-112(s0)

  // Allocate two pages at the next page boundary.
  // Use the second as the user stack.
  sz = PGROUNDUP(sz);
    80007fa0:	fb843703          	ld	a4,-72(s0)
    80007fa4:	6785                	lui	a5,0x1
    80007fa6:	17fd                	addi	a5,a5,-1
    80007fa8:	973e                	add	a4,a4,a5
    80007faa:	77fd                	lui	a5,0xfffff
    80007fac:	8ff9                	and	a5,a5,a4
    80007fae:	faf43c23          	sd	a5,-72(s0)
  uint64 sz1;
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80007fb2:	fb843703          	ld	a4,-72(s0)
    80007fb6:	6789                	lui	a5,0x2
    80007fb8:	97ba                	add	a5,a5,a4
    80007fba:	863e                	mv	a2,a5
    80007fbc:	fb843583          	ld	a1,-72(s0)
    80007fc0:	fa043503          	ld	a0,-96(s0)
    80007fc4:	ffffa097          	auipc	ra,0xffffa
    80007fc8:	f44080e7          	jalr	-188(ra) # 80001f08 <uvmalloc>
    80007fcc:	f8a43423          	sd	a0,-120(s0)
    80007fd0:	f8843783          	ld	a5,-120(s0)
    80007fd4:	20078e63          	beqz	a5,800081f0 <exec+0x428>
    goto bad;
  sz = sz1;
    80007fd8:	f8843783          	ld	a5,-120(s0)
    80007fdc:	faf43c23          	sd	a5,-72(s0)
  uvmclear(pagetable, sz-2*PGSIZE);
    80007fe0:	fb843703          	ld	a4,-72(s0)
    80007fe4:	77f9                	lui	a5,0xffffe
    80007fe6:	97ba                	add	a5,a5,a4
    80007fe8:	85be                	mv	a1,a5
    80007fea:	fa043503          	ld	a0,-96(s0)
    80007fee:	ffffa097          	auipc	ra,0xffffa
    80007ff2:	382080e7          	jalr	898(ra) # 80002370 <uvmclear>
  sp = sz;
    80007ff6:	fb843783          	ld	a5,-72(s0)
    80007ffa:	faf43823          	sd	a5,-80(s0)
  stackbase = sp - PGSIZE;
    80007ffe:	fb043703          	ld	a4,-80(s0)
    80008002:	77fd                	lui	a5,0xfffff
    80008004:	97ba                	add	a5,a5,a4
    80008006:	f8f43023          	sd	a5,-128(s0)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    8000800a:	fc043023          	sd	zero,-64(s0)
    8000800e:	a07d                	j	800080bc <exec+0x2f4>
    if(argc >= MAXARG)
    80008010:	fc043703          	ld	a4,-64(s0)
    80008014:	47fd                	li	a5,31
    80008016:	1ce7ef63          	bltu	a5,a4,800081f4 <exec+0x42c>
      goto bad;
    sp -= strlen(argv[argc]) + 1;
    8000801a:	fc043783          	ld	a5,-64(s0)
    8000801e:	078e                	slli	a5,a5,0x3
    80008020:	de043703          	ld	a4,-544(s0)
    80008024:	97ba                	add	a5,a5,a4
    80008026:	639c                	ld	a5,0(a5)
    80008028:	853e                	mv	a0,a5
    8000802a:	ffff9097          	auipc	ra,0xffff9
    8000802e:	794080e7          	jalr	1940(ra) # 800017be <strlen>
    80008032:	87aa                	mv	a5,a0
    80008034:	2785                	addiw	a5,a5,1
    80008036:	2781                	sext.w	a5,a5
    80008038:	873e                	mv	a4,a5
    8000803a:	fb043783          	ld	a5,-80(s0)
    8000803e:	8f99                	sub	a5,a5,a4
    80008040:	faf43823          	sd	a5,-80(s0)
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80008044:	fb043783          	ld	a5,-80(s0)
    80008048:	9bc1                	andi	a5,a5,-16
    8000804a:	faf43823          	sd	a5,-80(s0)
    if(sp < stackbase)
    8000804e:	fb043703          	ld	a4,-80(s0)
    80008052:	f8043783          	ld	a5,-128(s0)
    80008056:	1af76163          	bltu	a4,a5,800081f8 <exec+0x430>
      goto bad;
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    8000805a:	fc043783          	ld	a5,-64(s0)
    8000805e:	078e                	slli	a5,a5,0x3
    80008060:	de043703          	ld	a4,-544(s0)
    80008064:	97ba                	add	a5,a5,a4
    80008066:	6384                	ld	s1,0(a5)
    80008068:	fc043783          	ld	a5,-64(s0)
    8000806c:	078e                	slli	a5,a5,0x3
    8000806e:	de043703          	ld	a4,-544(s0)
    80008072:	97ba                	add	a5,a5,a4
    80008074:	639c                	ld	a5,0(a5)
    80008076:	853e                	mv	a0,a5
    80008078:	ffff9097          	auipc	ra,0xffff9
    8000807c:	746080e7          	jalr	1862(ra) # 800017be <strlen>
    80008080:	87aa                	mv	a5,a0
    80008082:	2785                	addiw	a5,a5,1
    80008084:	2781                	sext.w	a5,a5
    80008086:	86be                	mv	a3,a5
    80008088:	8626                	mv	a2,s1
    8000808a:	fb043583          	ld	a1,-80(s0)
    8000808e:	fa043503          	ld	a0,-96(s0)
    80008092:	ffffa097          	auipc	ra,0xffffa
    80008096:	334080e7          	jalr	820(ra) # 800023c6 <copyout>
    8000809a:	87aa                	mv	a5,a0
    8000809c:	1607c063          	bltz	a5,800081fc <exec+0x434>
      goto bad;
    ustack[argc] = sp;
    800080a0:	fc043783          	ld	a5,-64(s0)
    800080a4:	078e                	slli	a5,a5,0x3
    800080a6:	1781                	addi	a5,a5,-32
    800080a8:	97a2                	add	a5,a5,s0
    800080aa:	fb043703          	ld	a4,-80(s0)
    800080ae:	e8e7b823          	sd	a4,-368(a5) # ffffffffffffee90 <end+0xffffffff7fb55e90>
  for(argc = 0; argv[argc]; argc++) {
    800080b2:	fc043783          	ld	a5,-64(s0)
    800080b6:	0785                	addi	a5,a5,1
    800080b8:	fcf43023          	sd	a5,-64(s0)
    800080bc:	fc043783          	ld	a5,-64(s0)
    800080c0:	078e                	slli	a5,a5,0x3
    800080c2:	de043703          	ld	a4,-544(s0)
    800080c6:	97ba                	add	a5,a5,a4
    800080c8:	639c                	ld	a5,0(a5)
    800080ca:	f3b9                	bnez	a5,80008010 <exec+0x248>
  }
  ustack[argc] = 0;
    800080cc:	fc043783          	ld	a5,-64(s0)
    800080d0:	078e                	slli	a5,a5,0x3
    800080d2:	1781                	addi	a5,a5,-32
    800080d4:	97a2                	add	a5,a5,s0
    800080d6:	e807b823          	sd	zero,-368(a5)

  // push the array of argv[] pointers.

  sp -= sp % 16;
    800080da:	fb043783          	ld	a5,-80(s0)
    800080de:	9bc1                	andi	a5,a5,-16
    800080e0:	faf43823          	sd	a5,-80(s0)
  if(sp < stackbase)
    800080e4:	fb043703          	ld	a4,-80(s0)
    800080e8:	f8043783          	ld	a5,-128(s0)
    800080ec:	10f76a63          	bltu	a4,a5,80008200 <exec+0x438>
    goto bad;
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    800080f0:	fc043783          	ld	a5,-64(s0)
    800080f4:	0785                	addi	a5,a5,1
    800080f6:	00379713          	slli	a4,a5,0x3
    800080fa:	e7040793          	addi	a5,s0,-400
    800080fe:	86ba                	mv	a3,a4
    80008100:	863e                	mv	a2,a5
    80008102:	fb043583          	ld	a1,-80(s0)
    80008106:	fa043503          	ld	a0,-96(s0)
    8000810a:	ffffa097          	auipc	ra,0xffffa
    8000810e:	2bc080e7          	jalr	700(ra) # 800023c6 <copyout>
    80008112:	87aa                	mv	a5,a0
    80008114:	0e07c863          	bltz	a5,80008204 <exec+0x43c>
    goto bad;

  // arguments to user main(argc, argv)
  // argc is returned via the system call return
  // value, which goes in a0.
  p->trapframe->a1 = sp;
    80008118:	f9843783          	ld	a5,-104(s0)
    8000811c:	73bc                	ld	a5,96(a5)
    8000811e:	fb043703          	ld	a4,-80(s0)
    80008122:	ffb8                	sd	a4,120(a5)

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    80008124:	de843783          	ld	a5,-536(s0)
    80008128:	fcf43c23          	sd	a5,-40(s0)
    8000812c:	fd843783          	ld	a5,-40(s0)
    80008130:	fcf43823          	sd	a5,-48(s0)
    80008134:	a025                	j	8000815c <exec+0x394>
    if(*s == '/')
    80008136:	fd843783          	ld	a5,-40(s0)
    8000813a:	0007c783          	lbu	a5,0(a5)
    8000813e:	873e                	mv	a4,a5
    80008140:	02f00793          	li	a5,47
    80008144:	00f71763          	bne	a4,a5,80008152 <exec+0x38a>
      last = s+1;
    80008148:	fd843783          	ld	a5,-40(s0)
    8000814c:	0785                	addi	a5,a5,1
    8000814e:	fcf43823          	sd	a5,-48(s0)
  for(last=s=path; *s; s++)
    80008152:	fd843783          	ld	a5,-40(s0)
    80008156:	0785                	addi	a5,a5,1
    80008158:	fcf43c23          	sd	a5,-40(s0)
    8000815c:	fd843783          	ld	a5,-40(s0)
    80008160:	0007c783          	lbu	a5,0(a5)
    80008164:	fbe9                	bnez	a5,80008136 <exec+0x36e>
  safestrcpy(p->name, last, sizeof(p->name));
    80008166:	f9843783          	ld	a5,-104(s0)
    8000816a:	16878793          	addi	a5,a5,360
    8000816e:	4641                	li	a2,16
    80008170:	fd043583          	ld	a1,-48(s0)
    80008174:	853e                	mv	a0,a5
    80008176:	ffff9097          	auipc	ra,0xffff9
    8000817a:	5cc080e7          	jalr	1484(ra) # 80001742 <safestrcpy>
    
  // Commit to the user image.
  oldpagetable = p->pagetable;
    8000817e:	f9843783          	ld	a5,-104(s0)
    80008182:	6bbc                	ld	a5,80(a5)
    80008184:	f6f43c23          	sd	a5,-136(s0)
  p->pagetable = pagetable;
    80008188:	f9843783          	ld	a5,-104(s0)
    8000818c:	fa043703          	ld	a4,-96(s0)
    80008190:	ebb8                	sd	a4,80(a5)
  p->sz = sz;
    80008192:	f9843783          	ld	a5,-104(s0)
    80008196:	fb843703          	ld	a4,-72(s0)
    8000819a:	e7b8                	sd	a4,72(a5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    8000819c:	f9843783          	ld	a5,-104(s0)
    800081a0:	73bc                	ld	a5,96(a5)
    800081a2:	e4843703          	ld	a4,-440(s0)
    800081a6:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800081a8:	f9843783          	ld	a5,-104(s0)
    800081ac:	73bc                	ld	a5,96(a5)
    800081ae:	fb043703          	ld	a4,-80(s0)
    800081b2:	fb98                	sd	a4,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800081b4:	f9043583          	ld	a1,-112(s0)
    800081b8:	f7843503          	ld	a0,-136(s0)
    800081bc:	ffffb097          	auipc	ra,0xffffb
    800081c0:	cda080e7          	jalr	-806(ra) # 80002e96 <proc_freepagetable>

  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800081c4:	fc043783          	ld	a5,-64(s0)
    800081c8:	2781                	sext.w	a5,a5
    800081ca:	a0bd                	j	80008238 <exec+0x470>
    goto bad;
    800081cc:	0001                	nop
    800081ce:	a825                	j	80008206 <exec+0x43e>
    goto bad;
    800081d0:	0001                	nop
    800081d2:	a815                	j	80008206 <exec+0x43e>
    goto bad;
    800081d4:	0001                	nop
    800081d6:	a805                	j	80008206 <exec+0x43e>
      goto bad;
    800081d8:	0001                	nop
    800081da:	a035                	j	80008206 <exec+0x43e>
      goto bad;
    800081dc:	0001                	nop
    800081de:	a025                	j	80008206 <exec+0x43e>
      goto bad;
    800081e0:	0001                	nop
    800081e2:	a015                	j	80008206 <exec+0x43e>
      goto bad;
    800081e4:	0001                	nop
    800081e6:	a005                	j	80008206 <exec+0x43e>
      goto bad;
    800081e8:	0001                	nop
    800081ea:	a831                	j	80008206 <exec+0x43e>
      goto bad;
    800081ec:	0001                	nop
    800081ee:	a821                	j	80008206 <exec+0x43e>
    goto bad;
    800081f0:	0001                	nop
    800081f2:	a811                	j	80008206 <exec+0x43e>
      goto bad;
    800081f4:	0001                	nop
    800081f6:	a801                	j	80008206 <exec+0x43e>
      goto bad;
    800081f8:	0001                	nop
    800081fa:	a031                	j	80008206 <exec+0x43e>
      goto bad;
    800081fc:	0001                	nop
    800081fe:	a021                	j	80008206 <exec+0x43e>
    goto bad;
    80008200:	0001                	nop
    80008202:	a011                	j	80008206 <exec+0x43e>
    goto bad;
    80008204:	0001                	nop

 bad:
  if(pagetable)
    80008206:	fa043783          	ld	a5,-96(s0)
    8000820a:	cb89                	beqz	a5,8000821c <exec+0x454>
    proc_freepagetable(pagetable, sz);
    8000820c:	fb843583          	ld	a1,-72(s0)
    80008210:	fa043503          	ld	a0,-96(s0)
    80008214:	ffffb097          	auipc	ra,0xffffb
    80008218:	c82080e7          	jalr	-894(ra) # 80002e96 <proc_freepagetable>
  if(ip){
    8000821c:	fa843783          	ld	a5,-88(s0)
    80008220:	cb99                	beqz	a5,80008236 <exec+0x46e>
    iunlockput(ip);
    80008222:	fa843503          	ld	a0,-88(s0)
    80008226:	ffffe097          	auipc	ra,0xffffe
    8000822a:	d48080e7          	jalr	-696(ra) # 80005f6e <iunlockput>
    end_op();
    8000822e:	fffff097          	auipc	ra,0xfffff
    80008232:	c0c080e7          	jalr	-1012(ra) # 80006e3a <end_op>
  }
  return -1;
    80008236:	57fd                	li	a5,-1
}
    80008238:	853e                	mv	a0,a5
    8000823a:	21813083          	ld	ra,536(sp)
    8000823e:	21013403          	ld	s0,528(sp)
    80008242:	20813483          	ld	s1,520(sp)
    80008246:	22010113          	addi	sp,sp,544
    8000824a:	8082                	ret

000000008000824c <loadseg>:
// va must be page-aligned
// and the pages from va to va+sz must already be mapped.
// Returns 0 on success, -1 on failure.
static int
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
    8000824c:	7139                	addi	sp,sp,-64
    8000824e:	fc06                	sd	ra,56(sp)
    80008250:	f822                	sd	s0,48(sp)
    80008252:	0080                	addi	s0,sp,64
    80008254:	fca43c23          	sd	a0,-40(s0)
    80008258:	fcb43823          	sd	a1,-48(s0)
    8000825c:	fcc43423          	sd	a2,-56(s0)
    80008260:	87b6                	mv	a5,a3
    80008262:	fcf42223          	sw	a5,-60(s0)
    80008266:	87ba                	mv	a5,a4
    80008268:	fcf42023          	sw	a5,-64(s0)
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    8000826c:	fe042623          	sw	zero,-20(s0)
    80008270:	a07d                	j	8000831e <loadseg+0xd2>
    pa = walkaddr(pagetable, va + i);
    80008272:	fec46703          	lwu	a4,-20(s0)
    80008276:	fd043783          	ld	a5,-48(s0)
    8000827a:	97ba                	add	a5,a5,a4
    8000827c:	85be                	mv	a1,a5
    8000827e:	fd843503          	ld	a0,-40(s0)
    80008282:	ffffa097          	auipc	ra,0xffffa
    80008286:	912080e7          	jalr	-1774(ra) # 80001b94 <walkaddr>
    8000828a:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    8000828e:	fe043783          	ld	a5,-32(s0)
    80008292:	eb89                	bnez	a5,800082a4 <loadseg+0x58>
      panic("loadseg: address should exist");
    80008294:	00003517          	auipc	a0,0x3
    80008298:	4ec50513          	addi	a0,a0,1260 # 8000b780 <etext+0x780>
    8000829c:	ffff9097          	auipc	ra,0xffff9
    800082a0:	9de080e7          	jalr	-1570(ra) # 80000c7a <panic>
    if(sz - i < PGSIZE)
    800082a4:	fc042783          	lw	a5,-64(s0)
    800082a8:	873e                	mv	a4,a5
    800082aa:	fec42783          	lw	a5,-20(s0)
    800082ae:	40f707bb          	subw	a5,a4,a5
    800082b2:	2781                	sext.w	a5,a5
    800082b4:	873e                	mv	a4,a5
    800082b6:	6785                	lui	a5,0x1
    800082b8:	00f77c63          	bgeu	a4,a5,800082d0 <loadseg+0x84>
      n = sz - i;
    800082bc:	fc042783          	lw	a5,-64(s0)
    800082c0:	873e                	mv	a4,a5
    800082c2:	fec42783          	lw	a5,-20(s0)
    800082c6:	40f707bb          	subw	a5,a4,a5
    800082ca:	fef42423          	sw	a5,-24(s0)
    800082ce:	a021                	j	800082d6 <loadseg+0x8a>
    else
      n = PGSIZE;
    800082d0:	6785                	lui	a5,0x1
    800082d2:	fef42423          	sw	a5,-24(s0)
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800082d6:	fc442783          	lw	a5,-60(s0)
    800082da:	873e                	mv	a4,a5
    800082dc:	fec42783          	lw	a5,-20(s0)
    800082e0:	9fb9                	addw	a5,a5,a4
    800082e2:	2781                	sext.w	a5,a5
    800082e4:	fe842703          	lw	a4,-24(s0)
    800082e8:	86be                	mv	a3,a5
    800082ea:	fe043603          	ld	a2,-32(s0)
    800082ee:	4581                	li	a1,0
    800082f0:	fc843503          	ld	a0,-56(s0)
    800082f4:	ffffe097          	auipc	ra,0xffffe
    800082f8:	fb2080e7          	jalr	-78(ra) # 800062a6 <readi>
    800082fc:	87aa                	mv	a5,a0
    800082fe:	0007871b          	sext.w	a4,a5
    80008302:	fe842783          	lw	a5,-24(s0)
    80008306:	2781                	sext.w	a5,a5
    80008308:	00e78463          	beq	a5,a4,80008310 <loadseg+0xc4>
      return -1;
    8000830c:	57fd                	li	a5,-1
    8000830e:	a015                	j	80008332 <loadseg+0xe6>
  for(i = 0; i < sz; i += PGSIZE){
    80008310:	fec42783          	lw	a5,-20(s0)
    80008314:	873e                	mv	a4,a5
    80008316:	6785                	lui	a5,0x1
    80008318:	9fb9                	addw	a5,a5,a4
    8000831a:	fef42623          	sw	a5,-20(s0)
    8000831e:	fec42783          	lw	a5,-20(s0)
    80008322:	873e                	mv	a4,a5
    80008324:	fc042783          	lw	a5,-64(s0)
    80008328:	2701                	sext.w	a4,a4
    8000832a:	2781                	sext.w	a5,a5
    8000832c:	f4f763e3          	bltu	a4,a5,80008272 <loadseg+0x26>
  }
  
  return 0;
    80008330:	4781                	li	a5,0
}
    80008332:	853e                	mv	a0,a5
    80008334:	70e2                	ld	ra,56(sp)
    80008336:	7442                	ld	s0,48(sp)
    80008338:	6121                	addi	sp,sp,64
    8000833a:	8082                	ret

000000008000833c <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    8000833c:	7139                	addi	sp,sp,-64
    8000833e:	fc06                	sd	ra,56(sp)
    80008340:	f822                	sd	s0,48(sp)
    80008342:	0080                	addi	s0,sp,64
    80008344:	87aa                	mv	a5,a0
    80008346:	fcb43823          	sd	a1,-48(s0)
    8000834a:	fcc43423          	sd	a2,-56(s0)
    8000834e:	fcf42e23          	sw	a5,-36(s0)
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80008352:	fe440713          	addi	a4,s0,-28
    80008356:	fdc42783          	lw	a5,-36(s0)
    8000835a:	85ba                	mv	a1,a4
    8000835c:	853e                	mv	a0,a5
    8000835e:	ffffc097          	auipc	ra,0xffffc
    80008362:	7fe080e7          	jalr	2046(ra) # 80004b5c <argint>
    80008366:	87aa                	mv	a5,a0
    80008368:	0007d463          	bgez	a5,80008370 <argfd+0x34>
    return -1;
    8000836c:	57fd                	li	a5,-1
    8000836e:	a8b1                	j	800083ca <argfd+0x8e>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80008370:	fe442783          	lw	a5,-28(s0)
    80008374:	0207c863          	bltz	a5,800083a4 <argfd+0x68>
    80008378:	fe442783          	lw	a5,-28(s0)
    8000837c:	873e                	mv	a4,a5
    8000837e:	47bd                	li	a5,15
    80008380:	02e7c263          	blt	a5,a4,800083a4 <argfd+0x68>
    80008384:	ffffa097          	auipc	ra,0xffffa
    80008388:	694080e7          	jalr	1684(ra) # 80002a18 <myproc>
    8000838c:	872a                	mv	a4,a0
    8000838e:	fe442783          	lw	a5,-28(s0)
    80008392:	07f1                	addi	a5,a5,28
    80008394:	078e                	slli	a5,a5,0x3
    80008396:	97ba                	add	a5,a5,a4
    80008398:	639c                	ld	a5,0(a5)
    8000839a:	fef43423          	sd	a5,-24(s0)
    8000839e:	fe843783          	ld	a5,-24(s0)
    800083a2:	e399                	bnez	a5,800083a8 <argfd+0x6c>
    return -1;
    800083a4:	57fd                	li	a5,-1
    800083a6:	a015                	j	800083ca <argfd+0x8e>
  if(pfd)
    800083a8:	fd043783          	ld	a5,-48(s0)
    800083ac:	c791                	beqz	a5,800083b8 <argfd+0x7c>
    *pfd = fd;
    800083ae:	fe442703          	lw	a4,-28(s0)
    800083b2:	fd043783          	ld	a5,-48(s0)
    800083b6:	c398                	sw	a4,0(a5)
  if(pf)
    800083b8:	fc843783          	ld	a5,-56(s0)
    800083bc:	c791                	beqz	a5,800083c8 <argfd+0x8c>
    *pf = f;
    800083be:	fc843783          	ld	a5,-56(s0)
    800083c2:	fe843703          	ld	a4,-24(s0)
    800083c6:	e398                	sd	a4,0(a5)
  return 0;
    800083c8:	4781                	li	a5,0
}
    800083ca:	853e                	mv	a0,a5
    800083cc:	70e2                	ld	ra,56(sp)
    800083ce:	7442                	ld	s0,48(sp)
    800083d0:	6121                	addi	sp,sp,64
    800083d2:	8082                	ret

00000000800083d4 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800083d4:	7179                	addi	sp,sp,-48
    800083d6:	f406                	sd	ra,40(sp)
    800083d8:	f022                	sd	s0,32(sp)
    800083da:	1800                	addi	s0,sp,48
    800083dc:	fca43c23          	sd	a0,-40(s0)
  int fd;
  struct proc *p = myproc();
    800083e0:	ffffa097          	auipc	ra,0xffffa
    800083e4:	638080e7          	jalr	1592(ra) # 80002a18 <myproc>
    800083e8:	fea43023          	sd	a0,-32(s0)

  for(fd = 0; fd < NOFILE; fd++){
    800083ec:	fe042623          	sw	zero,-20(s0)
    800083f0:	a825                	j	80008428 <fdalloc+0x54>
    if(p->ofile[fd] == 0){
    800083f2:	fe043703          	ld	a4,-32(s0)
    800083f6:	fec42783          	lw	a5,-20(s0)
    800083fa:	07f1                	addi	a5,a5,28
    800083fc:	078e                	slli	a5,a5,0x3
    800083fe:	97ba                	add	a5,a5,a4
    80008400:	639c                	ld	a5,0(a5)
    80008402:	ef91                	bnez	a5,8000841e <fdalloc+0x4a>
      p->ofile[fd] = f;
    80008404:	fe043703          	ld	a4,-32(s0)
    80008408:	fec42783          	lw	a5,-20(s0)
    8000840c:	07f1                	addi	a5,a5,28
    8000840e:	078e                	slli	a5,a5,0x3
    80008410:	97ba                	add	a5,a5,a4
    80008412:	fd843703          	ld	a4,-40(s0)
    80008416:	e398                	sd	a4,0(a5)
      return fd;
    80008418:	fec42783          	lw	a5,-20(s0)
    8000841c:	a831                	j	80008438 <fdalloc+0x64>
  for(fd = 0; fd < NOFILE; fd++){
    8000841e:	fec42783          	lw	a5,-20(s0)
    80008422:	2785                	addiw	a5,a5,1
    80008424:	fef42623          	sw	a5,-20(s0)
    80008428:	fec42783          	lw	a5,-20(s0)
    8000842c:	0007871b          	sext.w	a4,a5
    80008430:	47bd                	li	a5,15
    80008432:	fce7d0e3          	bge	a5,a4,800083f2 <fdalloc+0x1e>
    }
  }
  return -1;
    80008436:	57fd                	li	a5,-1
}
    80008438:	853e                	mv	a0,a5
    8000843a:	70a2                	ld	ra,40(sp)
    8000843c:	7402                	ld	s0,32(sp)
    8000843e:	6145                	addi	sp,sp,48
    80008440:	8082                	ret

0000000080008442 <sys_dup>:

uint64
sys_dup(void)
{
    80008442:	1101                	addi	sp,sp,-32
    80008444:	ec06                	sd	ra,24(sp)
    80008446:	e822                	sd	s0,16(sp)
    80008448:	1000                	addi	s0,sp,32
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    8000844a:	fe040793          	addi	a5,s0,-32
    8000844e:	863e                	mv	a2,a5
    80008450:	4581                	li	a1,0
    80008452:	4501                	li	a0,0
    80008454:	00000097          	auipc	ra,0x0
    80008458:	ee8080e7          	jalr	-280(ra) # 8000833c <argfd>
    8000845c:	87aa                	mv	a5,a0
    8000845e:	0007d463          	bgez	a5,80008466 <sys_dup+0x24>
    return -1;
    80008462:	57fd                	li	a5,-1
    80008464:	a81d                	j	8000849a <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
    80008466:	fe043783          	ld	a5,-32(s0)
    8000846a:	853e                	mv	a0,a5
    8000846c:	00000097          	auipc	ra,0x0
    80008470:	f68080e7          	jalr	-152(ra) # 800083d4 <fdalloc>
    80008474:	87aa                	mv	a5,a0
    80008476:	fef42623          	sw	a5,-20(s0)
    8000847a:	fec42783          	lw	a5,-20(s0)
    8000847e:	2781                	sext.w	a5,a5
    80008480:	0007d463          	bgez	a5,80008488 <sys_dup+0x46>
    return -1;
    80008484:	57fd                	li	a5,-1
    80008486:	a811                	j	8000849a <sys_dup+0x58>
  filedup(f);
    80008488:	fe043783          	ld	a5,-32(s0)
    8000848c:	853e                	mv	a0,a5
    8000848e:	fffff097          	auipc	ra,0xfffff
    80008492:	f1e080e7          	jalr	-226(ra) # 800073ac <filedup>
  return fd;
    80008496:	fec42783          	lw	a5,-20(s0)
}
    8000849a:	853e                	mv	a0,a5
    8000849c:	60e2                	ld	ra,24(sp)
    8000849e:	6442                	ld	s0,16(sp)
    800084a0:	6105                	addi	sp,sp,32
    800084a2:	8082                	ret

00000000800084a4 <sys_read>:

uint64
sys_read(void)
{
    800084a4:	7179                	addi	sp,sp,-48
    800084a6:	f406                	sd	ra,40(sp)
    800084a8:	f022                	sd	s0,32(sp)
    800084aa:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800084ac:	fe840793          	addi	a5,s0,-24
    800084b0:	863e                	mv	a2,a5
    800084b2:	4581                	li	a1,0
    800084b4:	4501                	li	a0,0
    800084b6:	00000097          	auipc	ra,0x0
    800084ba:	e86080e7          	jalr	-378(ra) # 8000833c <argfd>
    800084be:	87aa                	mv	a5,a0
    800084c0:	0207c863          	bltz	a5,800084f0 <sys_read+0x4c>
    800084c4:	fe440793          	addi	a5,s0,-28
    800084c8:	85be                	mv	a1,a5
    800084ca:	4509                	li	a0,2
    800084cc:	ffffc097          	auipc	ra,0xffffc
    800084d0:	690080e7          	jalr	1680(ra) # 80004b5c <argint>
    800084d4:	87aa                	mv	a5,a0
    800084d6:	0007cd63          	bltz	a5,800084f0 <sys_read+0x4c>
    800084da:	fd840793          	addi	a5,s0,-40
    800084de:	85be                	mv	a1,a5
    800084e0:	4505                	li	a0,1
    800084e2:	ffffc097          	auipc	ra,0xffffc
    800084e6:	6b2080e7          	jalr	1714(ra) # 80004b94 <argaddr>
    800084ea:	87aa                	mv	a5,a0
    800084ec:	0007d463          	bgez	a5,800084f4 <sys_read+0x50>
    return -1;
    800084f0:	57fd                	li	a5,-1
    800084f2:	a839                	j	80008510 <sys_read+0x6c>
  return fileread(f, p, n);
    800084f4:	fe843783          	ld	a5,-24(s0)
    800084f8:	fd843703          	ld	a4,-40(s0)
    800084fc:	fe442683          	lw	a3,-28(s0)
    80008500:	8636                	mv	a2,a3
    80008502:	85ba                	mv	a1,a4
    80008504:	853e                	mv	a0,a5
    80008506:	fffff097          	auipc	ra,0xfffff
    8000850a:	0b8080e7          	jalr	184(ra) # 800075be <fileread>
    8000850e:	87aa                	mv	a5,a0
}
    80008510:	853e                	mv	a0,a5
    80008512:	70a2                	ld	ra,40(sp)
    80008514:	7402                	ld	s0,32(sp)
    80008516:	6145                	addi	sp,sp,48
    80008518:	8082                	ret

000000008000851a <sys_write>:

uint64
sys_write(void)
{
    8000851a:	7179                	addi	sp,sp,-48
    8000851c:	f406                	sd	ra,40(sp)
    8000851e:	f022                	sd	s0,32(sp)
    80008520:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80008522:	fe840793          	addi	a5,s0,-24
    80008526:	863e                	mv	a2,a5
    80008528:	4581                	li	a1,0
    8000852a:	4501                	li	a0,0
    8000852c:	00000097          	auipc	ra,0x0
    80008530:	e10080e7          	jalr	-496(ra) # 8000833c <argfd>
    80008534:	87aa                	mv	a5,a0
    80008536:	0207c863          	bltz	a5,80008566 <sys_write+0x4c>
    8000853a:	fe440793          	addi	a5,s0,-28
    8000853e:	85be                	mv	a1,a5
    80008540:	4509                	li	a0,2
    80008542:	ffffc097          	auipc	ra,0xffffc
    80008546:	61a080e7          	jalr	1562(ra) # 80004b5c <argint>
    8000854a:	87aa                	mv	a5,a0
    8000854c:	0007cd63          	bltz	a5,80008566 <sys_write+0x4c>
    80008550:	fd840793          	addi	a5,s0,-40
    80008554:	85be                	mv	a1,a5
    80008556:	4505                	li	a0,1
    80008558:	ffffc097          	auipc	ra,0xffffc
    8000855c:	63c080e7          	jalr	1596(ra) # 80004b94 <argaddr>
    80008560:	87aa                	mv	a5,a0
    80008562:	0007d463          	bgez	a5,8000856a <sys_write+0x50>
    return -1;
    80008566:	57fd                	li	a5,-1
    80008568:	a839                	j	80008586 <sys_write+0x6c>

  return filewrite(f, p, n);
    8000856a:	fe843783          	ld	a5,-24(s0)
    8000856e:	fd843703          	ld	a4,-40(s0)
    80008572:	fe442683          	lw	a3,-28(s0)
    80008576:	8636                	mv	a2,a3
    80008578:	85ba                	mv	a1,a4
    8000857a:	853e                	mv	a0,a5
    8000857c:	fffff097          	auipc	ra,0xfffff
    80008580:	1a8080e7          	jalr	424(ra) # 80007724 <filewrite>
    80008584:	87aa                	mv	a5,a0
}
    80008586:	853e                	mv	a0,a5
    80008588:	70a2                	ld	ra,40(sp)
    8000858a:	7402                	ld	s0,32(sp)
    8000858c:	6145                	addi	sp,sp,48
    8000858e:	8082                	ret

0000000080008590 <sys_close>:

uint64
sys_close(void)
{
    80008590:	1101                	addi	sp,sp,-32
    80008592:	ec06                	sd	ra,24(sp)
    80008594:	e822                	sd	s0,16(sp)
    80008596:	1000                	addi	s0,sp,32
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    80008598:	fe040713          	addi	a4,s0,-32
    8000859c:	fec40793          	addi	a5,s0,-20
    800085a0:	863a                	mv	a2,a4
    800085a2:	85be                	mv	a1,a5
    800085a4:	4501                	li	a0,0
    800085a6:	00000097          	auipc	ra,0x0
    800085aa:	d96080e7          	jalr	-618(ra) # 8000833c <argfd>
    800085ae:	87aa                	mv	a5,a0
    800085b0:	0007d463          	bgez	a5,800085b8 <sys_close+0x28>
    return -1;
    800085b4:	57fd                	li	a5,-1
    800085b6:	a02d                	j	800085e0 <sys_close+0x50>
  myproc()->ofile[fd] = 0;
    800085b8:	ffffa097          	auipc	ra,0xffffa
    800085bc:	460080e7          	jalr	1120(ra) # 80002a18 <myproc>
    800085c0:	872a                	mv	a4,a0
    800085c2:	fec42783          	lw	a5,-20(s0)
    800085c6:	07f1                	addi	a5,a5,28
    800085c8:	078e                	slli	a5,a5,0x3
    800085ca:	97ba                	add	a5,a5,a4
    800085cc:	0007b023          	sd	zero,0(a5) # 1000 <_entry-0x7ffff000>
  fileclose(f);
    800085d0:	fe043783          	ld	a5,-32(s0)
    800085d4:	853e                	mv	a0,a5
    800085d6:	fffff097          	auipc	ra,0xfffff
    800085da:	e3c080e7          	jalr	-452(ra) # 80007412 <fileclose>
  return 0;
    800085de:	4781                	li	a5,0
}
    800085e0:	853e                	mv	a0,a5
    800085e2:	60e2                	ld	ra,24(sp)
    800085e4:	6442                	ld	s0,16(sp)
    800085e6:	6105                	addi	sp,sp,32
    800085e8:	8082                	ret

00000000800085ea <sys_fstat>:

uint64
sys_fstat(void)
{
    800085ea:	1101                	addi	sp,sp,-32
    800085ec:	ec06                	sd	ra,24(sp)
    800085ee:	e822                	sd	s0,16(sp)
    800085f0:	1000                	addi	s0,sp,32
  struct file *f;
  uint64 st; // user pointer to struct stat

  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800085f2:	fe840793          	addi	a5,s0,-24
    800085f6:	863e                	mv	a2,a5
    800085f8:	4581                	li	a1,0
    800085fa:	4501                	li	a0,0
    800085fc:	00000097          	auipc	ra,0x0
    80008600:	d40080e7          	jalr	-704(ra) # 8000833c <argfd>
    80008604:	87aa                	mv	a5,a0
    80008606:	0007cd63          	bltz	a5,80008620 <sys_fstat+0x36>
    8000860a:	fe040793          	addi	a5,s0,-32
    8000860e:	85be                	mv	a1,a5
    80008610:	4505                	li	a0,1
    80008612:	ffffc097          	auipc	ra,0xffffc
    80008616:	582080e7          	jalr	1410(ra) # 80004b94 <argaddr>
    8000861a:	87aa                	mv	a5,a0
    8000861c:	0007d463          	bgez	a5,80008624 <sys_fstat+0x3a>
    return -1;
    80008620:	57fd                	li	a5,-1
    80008622:	a821                	j	8000863a <sys_fstat+0x50>
  return filestat(f, st);
    80008624:	fe843783          	ld	a5,-24(s0)
    80008628:	fe043703          	ld	a4,-32(s0)
    8000862c:	85ba                	mv	a1,a4
    8000862e:	853e                	mv	a0,a5
    80008630:	fffff097          	auipc	ra,0xfffff
    80008634:	eea080e7          	jalr	-278(ra) # 8000751a <filestat>
    80008638:	87aa                	mv	a5,a0
}
    8000863a:	853e                	mv	a0,a5
    8000863c:	60e2                	ld	ra,24(sp)
    8000863e:	6442                	ld	s0,16(sp)
    80008640:	6105                	addi	sp,sp,32
    80008642:	8082                	ret

0000000080008644 <sys_link>:

// Create the path new as a link to the same inode as old.
uint64
sys_link(void)
{
    80008644:	7169                	addi	sp,sp,-304
    80008646:	f606                	sd	ra,296(sp)
    80008648:	f222                	sd	s0,288(sp)
    8000864a:	1a00                	addi	s0,sp,304
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;

  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000864c:	ed040793          	addi	a5,s0,-304
    80008650:	08000613          	li	a2,128
    80008654:	85be                	mv	a1,a5
    80008656:	4501                	li	a0,0
    80008658:	ffffc097          	auipc	ra,0xffffc
    8000865c:	570080e7          	jalr	1392(ra) # 80004bc8 <argstr>
    80008660:	87aa                	mv	a5,a0
    80008662:	0007cf63          	bltz	a5,80008680 <sys_link+0x3c>
    80008666:	f5040793          	addi	a5,s0,-176
    8000866a:	08000613          	li	a2,128
    8000866e:	85be                	mv	a1,a5
    80008670:	4505                	li	a0,1
    80008672:	ffffc097          	auipc	ra,0xffffc
    80008676:	556080e7          	jalr	1366(ra) # 80004bc8 <argstr>
    8000867a:	87aa                	mv	a5,a0
    8000867c:	0007d463          	bgez	a5,80008684 <sys_link+0x40>
    return -1;
    80008680:	57fd                	li	a5,-1
    80008682:	aab5                	j	800087fe <sys_link+0x1ba>

  begin_op();
    80008684:	ffffe097          	auipc	ra,0xffffe
    80008688:	6f4080e7          	jalr	1780(ra) # 80006d78 <begin_op>
  if((ip = namei(old)) == 0){
    8000868c:	ed040793          	addi	a5,s0,-304
    80008690:	853e                	mv	a0,a5
    80008692:	ffffe097          	auipc	ra,0xffffe
    80008696:	382080e7          	jalr	898(ra) # 80006a14 <namei>
    8000869a:	fea43423          	sd	a0,-24(s0)
    8000869e:	fe843783          	ld	a5,-24(s0)
    800086a2:	e799                	bnez	a5,800086b0 <sys_link+0x6c>
    end_op();
    800086a4:	ffffe097          	auipc	ra,0xffffe
    800086a8:	796080e7          	jalr	1942(ra) # 80006e3a <end_op>
    return -1;
    800086ac:	57fd                	li	a5,-1
    800086ae:	aa81                	j	800087fe <sys_link+0x1ba>
  }

  ilock(ip);
    800086b0:	fe843503          	ld	a0,-24(s0)
    800086b4:	ffffd097          	auipc	ra,0xffffd
    800086b8:	65c080e7          	jalr	1628(ra) # 80005d10 <ilock>
  if(ip->type == T_DIR){
    800086bc:	fe843783          	ld	a5,-24(s0)
    800086c0:	04479783          	lh	a5,68(a5)
    800086c4:	0007871b          	sext.w	a4,a5
    800086c8:	4785                	li	a5,1
    800086ca:	00f71e63          	bne	a4,a5,800086e6 <sys_link+0xa2>
    iunlockput(ip);
    800086ce:	fe843503          	ld	a0,-24(s0)
    800086d2:	ffffe097          	auipc	ra,0xffffe
    800086d6:	89c080e7          	jalr	-1892(ra) # 80005f6e <iunlockput>
    end_op();
    800086da:	ffffe097          	auipc	ra,0xffffe
    800086de:	760080e7          	jalr	1888(ra) # 80006e3a <end_op>
    return -1;
    800086e2:	57fd                	li	a5,-1
    800086e4:	aa29                	j	800087fe <sys_link+0x1ba>
  }

  ip->nlink++;
    800086e6:	fe843783          	ld	a5,-24(s0)
    800086ea:	04a79783          	lh	a5,74(a5)
    800086ee:	17c2                	slli	a5,a5,0x30
    800086f0:	93c1                	srli	a5,a5,0x30
    800086f2:	2785                	addiw	a5,a5,1
    800086f4:	17c2                	slli	a5,a5,0x30
    800086f6:	93c1                	srli	a5,a5,0x30
    800086f8:	0107971b          	slliw	a4,a5,0x10
    800086fc:	4107571b          	sraiw	a4,a4,0x10
    80008700:	fe843783          	ld	a5,-24(s0)
    80008704:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80008708:	fe843503          	ld	a0,-24(s0)
    8000870c:	ffffd097          	auipc	ra,0xffffd
    80008710:	3b4080e7          	jalr	948(ra) # 80005ac0 <iupdate>
  iunlock(ip);
    80008714:	fe843503          	ld	a0,-24(s0)
    80008718:	ffffd097          	auipc	ra,0xffffd
    8000871c:	72c080e7          	jalr	1836(ra) # 80005e44 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
    80008720:	fd040713          	addi	a4,s0,-48
    80008724:	f5040793          	addi	a5,s0,-176
    80008728:	85ba                	mv	a1,a4
    8000872a:	853e                	mv	a0,a5
    8000872c:	ffffe097          	auipc	ra,0xffffe
    80008730:	314080e7          	jalr	788(ra) # 80006a40 <nameiparent>
    80008734:	fea43023          	sd	a0,-32(s0)
    80008738:	fe043783          	ld	a5,-32(s0)
    8000873c:	cba5                	beqz	a5,800087ac <sys_link+0x168>
    goto bad;
  ilock(dp);
    8000873e:	fe043503          	ld	a0,-32(s0)
    80008742:	ffffd097          	auipc	ra,0xffffd
    80008746:	5ce080e7          	jalr	1486(ra) # 80005d10 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    8000874a:	fe043783          	ld	a5,-32(s0)
    8000874e:	4398                	lw	a4,0(a5)
    80008750:	fe843783          	ld	a5,-24(s0)
    80008754:	439c                	lw	a5,0(a5)
    80008756:	02f71263          	bne	a4,a5,8000877a <sys_link+0x136>
    8000875a:	fe843783          	ld	a5,-24(s0)
    8000875e:	43d8                	lw	a4,4(a5)
    80008760:	fd040793          	addi	a5,s0,-48
    80008764:	863a                	mv	a2,a4
    80008766:	85be                	mv	a1,a5
    80008768:	fe043503          	ld	a0,-32(s0)
    8000876c:	ffffe097          	auipc	ra,0xffffe
    80008770:	f8e080e7          	jalr	-114(ra) # 800066fa <dirlink>
    80008774:	87aa                	mv	a5,a0
    80008776:	0007d963          	bgez	a5,80008788 <sys_link+0x144>
    iunlockput(dp);
    8000877a:	fe043503          	ld	a0,-32(s0)
    8000877e:	ffffd097          	auipc	ra,0xffffd
    80008782:	7f0080e7          	jalr	2032(ra) # 80005f6e <iunlockput>
    goto bad;
    80008786:	a025                	j	800087ae <sys_link+0x16a>
  }
  iunlockput(dp);
    80008788:	fe043503          	ld	a0,-32(s0)
    8000878c:	ffffd097          	auipc	ra,0xffffd
    80008790:	7e2080e7          	jalr	2018(ra) # 80005f6e <iunlockput>
  iput(ip);
    80008794:	fe843503          	ld	a0,-24(s0)
    80008798:	ffffd097          	auipc	ra,0xffffd
    8000879c:	706080e7          	jalr	1798(ra) # 80005e9e <iput>

  end_op();
    800087a0:	ffffe097          	auipc	ra,0xffffe
    800087a4:	69a080e7          	jalr	1690(ra) # 80006e3a <end_op>

  return 0;
    800087a8:	4781                	li	a5,0
    800087aa:	a891                	j	800087fe <sys_link+0x1ba>
    goto bad;
    800087ac:	0001                	nop

bad:
  ilock(ip);
    800087ae:	fe843503          	ld	a0,-24(s0)
    800087b2:	ffffd097          	auipc	ra,0xffffd
    800087b6:	55e080e7          	jalr	1374(ra) # 80005d10 <ilock>
  ip->nlink--;
    800087ba:	fe843783          	ld	a5,-24(s0)
    800087be:	04a79783          	lh	a5,74(a5)
    800087c2:	17c2                	slli	a5,a5,0x30
    800087c4:	93c1                	srli	a5,a5,0x30
    800087c6:	37fd                	addiw	a5,a5,-1
    800087c8:	17c2                	slli	a5,a5,0x30
    800087ca:	93c1                	srli	a5,a5,0x30
    800087cc:	0107971b          	slliw	a4,a5,0x10
    800087d0:	4107571b          	sraiw	a4,a4,0x10
    800087d4:	fe843783          	ld	a5,-24(s0)
    800087d8:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    800087dc:	fe843503          	ld	a0,-24(s0)
    800087e0:	ffffd097          	auipc	ra,0xffffd
    800087e4:	2e0080e7          	jalr	736(ra) # 80005ac0 <iupdate>
  iunlockput(ip);
    800087e8:	fe843503          	ld	a0,-24(s0)
    800087ec:	ffffd097          	auipc	ra,0xffffd
    800087f0:	782080e7          	jalr	1922(ra) # 80005f6e <iunlockput>
  end_op();
    800087f4:	ffffe097          	auipc	ra,0xffffe
    800087f8:	646080e7          	jalr	1606(ra) # 80006e3a <end_op>
  return -1;
    800087fc:	57fd                	li	a5,-1
}
    800087fe:	853e                	mv	a0,a5
    80008800:	70b2                	ld	ra,296(sp)
    80008802:	7412                	ld	s0,288(sp)
    80008804:	6155                	addi	sp,sp,304
    80008806:	8082                	ret

0000000080008808 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
    80008808:	7139                	addi	sp,sp,-64
    8000880a:	fc06                	sd	ra,56(sp)
    8000880c:	f822                	sd	s0,48(sp)
    8000880e:	0080                	addi	s0,sp,64
    80008810:	fca43423          	sd	a0,-56(s0)
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80008814:	02000793          	li	a5,32
    80008818:	fef42623          	sw	a5,-20(s0)
    8000881c:	a0b1                	j	80008868 <isdirempty+0x60>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000881e:	fd840793          	addi	a5,s0,-40
    80008822:	fec42683          	lw	a3,-20(s0)
    80008826:	4741                	li	a4,16
    80008828:	863e                	mv	a2,a5
    8000882a:	4581                	li	a1,0
    8000882c:	fc843503          	ld	a0,-56(s0)
    80008830:	ffffe097          	auipc	ra,0xffffe
    80008834:	a76080e7          	jalr	-1418(ra) # 800062a6 <readi>
    80008838:	87aa                	mv	a5,a0
    8000883a:	873e                	mv	a4,a5
    8000883c:	47c1                	li	a5,16
    8000883e:	00f70a63          	beq	a4,a5,80008852 <isdirempty+0x4a>
      panic("isdirempty: readi");
    80008842:	00003517          	auipc	a0,0x3
    80008846:	f5e50513          	addi	a0,a0,-162 # 8000b7a0 <etext+0x7a0>
    8000884a:	ffff8097          	auipc	ra,0xffff8
    8000884e:	430080e7          	jalr	1072(ra) # 80000c7a <panic>
    if(de.inum != 0)
    80008852:	fd845783          	lhu	a5,-40(s0)
    80008856:	c399                	beqz	a5,8000885c <isdirempty+0x54>
      return 0;
    80008858:	4781                	li	a5,0
    8000885a:	a839                	j	80008878 <isdirempty+0x70>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    8000885c:	fec42783          	lw	a5,-20(s0)
    80008860:	27c1                	addiw	a5,a5,16
    80008862:	2781                	sext.w	a5,a5
    80008864:	fef42623          	sw	a5,-20(s0)
    80008868:	fc843783          	ld	a5,-56(s0)
    8000886c:	47f8                	lw	a4,76(a5)
    8000886e:	fec42783          	lw	a5,-20(s0)
    80008872:	fae7e6e3          	bltu	a5,a4,8000881e <isdirempty+0x16>
  }
  return 1;
    80008876:	4785                	li	a5,1
}
    80008878:	853e                	mv	a0,a5
    8000887a:	70e2                	ld	ra,56(sp)
    8000887c:	7442                	ld	s0,48(sp)
    8000887e:	6121                	addi	sp,sp,64
    80008880:	8082                	ret

0000000080008882 <sys_unlink>:

uint64
sys_unlink(void)
{
    80008882:	7155                	addi	sp,sp,-208
    80008884:	e586                	sd	ra,200(sp)
    80008886:	e1a2                	sd	s0,192(sp)
    80008888:	0980                	addi	s0,sp,208
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;

  if(argstr(0, path, MAXPATH) < 0)
    8000888a:	f4040793          	addi	a5,s0,-192
    8000888e:	08000613          	li	a2,128
    80008892:	85be                	mv	a1,a5
    80008894:	4501                	li	a0,0
    80008896:	ffffc097          	auipc	ra,0xffffc
    8000889a:	332080e7          	jalr	818(ra) # 80004bc8 <argstr>
    8000889e:	87aa                	mv	a5,a0
    800088a0:	0007d463          	bgez	a5,800088a8 <sys_unlink+0x26>
    return -1;
    800088a4:	57fd                	li	a5,-1
    800088a6:	a2ed                	j	80008a90 <sys_unlink+0x20e>

  begin_op();
    800088a8:	ffffe097          	auipc	ra,0xffffe
    800088ac:	4d0080e7          	jalr	1232(ra) # 80006d78 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800088b0:	fc040713          	addi	a4,s0,-64
    800088b4:	f4040793          	addi	a5,s0,-192
    800088b8:	85ba                	mv	a1,a4
    800088ba:	853e                	mv	a0,a5
    800088bc:	ffffe097          	auipc	ra,0xffffe
    800088c0:	184080e7          	jalr	388(ra) # 80006a40 <nameiparent>
    800088c4:	fea43423          	sd	a0,-24(s0)
    800088c8:	fe843783          	ld	a5,-24(s0)
    800088cc:	e799                	bnez	a5,800088da <sys_unlink+0x58>
    end_op();
    800088ce:	ffffe097          	auipc	ra,0xffffe
    800088d2:	56c080e7          	jalr	1388(ra) # 80006e3a <end_op>
    return -1;
    800088d6:	57fd                	li	a5,-1
    800088d8:	aa65                	j	80008a90 <sys_unlink+0x20e>
  }

  ilock(dp);
    800088da:	fe843503          	ld	a0,-24(s0)
    800088de:	ffffd097          	auipc	ra,0xffffd
    800088e2:	432080e7          	jalr	1074(ra) # 80005d10 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    800088e6:	fc040793          	addi	a5,s0,-64
    800088ea:	00003597          	auipc	a1,0x3
    800088ee:	ece58593          	addi	a1,a1,-306 # 8000b7b8 <etext+0x7b8>
    800088f2:	853e                	mv	a0,a5
    800088f4:	ffffe097          	auipc	ra,0xffffe
    800088f8:	cf0080e7          	jalr	-784(ra) # 800065e4 <namecmp>
    800088fc:	87aa                	mv	a5,a0
    800088fe:	16078b63          	beqz	a5,80008a74 <sys_unlink+0x1f2>
    80008902:	fc040793          	addi	a5,s0,-64
    80008906:	00003597          	auipc	a1,0x3
    8000890a:	eba58593          	addi	a1,a1,-326 # 8000b7c0 <etext+0x7c0>
    8000890e:	853e                	mv	a0,a5
    80008910:	ffffe097          	auipc	ra,0xffffe
    80008914:	cd4080e7          	jalr	-812(ra) # 800065e4 <namecmp>
    80008918:	87aa                	mv	a5,a0
    8000891a:	14078d63          	beqz	a5,80008a74 <sys_unlink+0x1f2>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    8000891e:	f3c40713          	addi	a4,s0,-196
    80008922:	fc040793          	addi	a5,s0,-64
    80008926:	863a                	mv	a2,a4
    80008928:	85be                	mv	a1,a5
    8000892a:	fe843503          	ld	a0,-24(s0)
    8000892e:	ffffe097          	auipc	ra,0xffffe
    80008932:	ce4080e7          	jalr	-796(ra) # 80006612 <dirlookup>
    80008936:	fea43023          	sd	a0,-32(s0)
    8000893a:	fe043783          	ld	a5,-32(s0)
    8000893e:	12078d63          	beqz	a5,80008a78 <sys_unlink+0x1f6>
    goto bad;
  ilock(ip);
    80008942:	fe043503          	ld	a0,-32(s0)
    80008946:	ffffd097          	auipc	ra,0xffffd
    8000894a:	3ca080e7          	jalr	970(ra) # 80005d10 <ilock>

  if(ip->nlink < 1)
    8000894e:	fe043783          	ld	a5,-32(s0)
    80008952:	04a79783          	lh	a5,74(a5)
    80008956:	2781                	sext.w	a5,a5
    80008958:	00f04a63          	bgtz	a5,8000896c <sys_unlink+0xea>
    panic("unlink: nlink < 1");
    8000895c:	00003517          	auipc	a0,0x3
    80008960:	e6c50513          	addi	a0,a0,-404 # 8000b7c8 <etext+0x7c8>
    80008964:	ffff8097          	auipc	ra,0xffff8
    80008968:	316080e7          	jalr	790(ra) # 80000c7a <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
    8000896c:	fe043783          	ld	a5,-32(s0)
    80008970:	04479783          	lh	a5,68(a5)
    80008974:	0007871b          	sext.w	a4,a5
    80008978:	4785                	li	a5,1
    8000897a:	02f71163          	bne	a4,a5,8000899c <sys_unlink+0x11a>
    8000897e:	fe043503          	ld	a0,-32(s0)
    80008982:	00000097          	auipc	ra,0x0
    80008986:	e86080e7          	jalr	-378(ra) # 80008808 <isdirempty>
    8000898a:	87aa                	mv	a5,a0
    8000898c:	eb81                	bnez	a5,8000899c <sys_unlink+0x11a>
    iunlockput(ip);
    8000898e:	fe043503          	ld	a0,-32(s0)
    80008992:	ffffd097          	auipc	ra,0xffffd
    80008996:	5dc080e7          	jalr	1500(ra) # 80005f6e <iunlockput>
    goto bad;
    8000899a:	a0c5                	j	80008a7a <sys_unlink+0x1f8>
  }

  memset(&de, 0, sizeof(de));
    8000899c:	fd040793          	addi	a5,s0,-48
    800089a0:	4641                	li	a2,16
    800089a2:	4581                	li	a1,0
    800089a4:	853e                	mv	a0,a5
    800089a6:	ffff9097          	auipc	ra,0xffff9
    800089aa:	a98080e7          	jalr	-1384(ra) # 8000143e <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800089ae:	fd040793          	addi	a5,s0,-48
    800089b2:	f3c42683          	lw	a3,-196(s0)
    800089b6:	4741                	li	a4,16
    800089b8:	863e                	mv	a2,a5
    800089ba:	4581                	li	a1,0
    800089bc:	fe843503          	ld	a0,-24(s0)
    800089c0:	ffffe097          	auipc	ra,0xffffe
    800089c4:	a76080e7          	jalr	-1418(ra) # 80006436 <writei>
    800089c8:	87aa                	mv	a5,a0
    800089ca:	873e                	mv	a4,a5
    800089cc:	47c1                	li	a5,16
    800089ce:	00f70a63          	beq	a4,a5,800089e2 <sys_unlink+0x160>
    panic("unlink: writei");
    800089d2:	00003517          	auipc	a0,0x3
    800089d6:	e0e50513          	addi	a0,a0,-498 # 8000b7e0 <etext+0x7e0>
    800089da:	ffff8097          	auipc	ra,0xffff8
    800089de:	2a0080e7          	jalr	672(ra) # 80000c7a <panic>
  if(ip->type == T_DIR){
    800089e2:	fe043783          	ld	a5,-32(s0)
    800089e6:	04479783          	lh	a5,68(a5)
    800089ea:	0007871b          	sext.w	a4,a5
    800089ee:	4785                	li	a5,1
    800089f0:	02f71963          	bne	a4,a5,80008a22 <sys_unlink+0x1a0>
    dp->nlink--;
    800089f4:	fe843783          	ld	a5,-24(s0)
    800089f8:	04a79783          	lh	a5,74(a5)
    800089fc:	17c2                	slli	a5,a5,0x30
    800089fe:	93c1                	srli	a5,a5,0x30
    80008a00:	37fd                	addiw	a5,a5,-1
    80008a02:	17c2                	slli	a5,a5,0x30
    80008a04:	93c1                	srli	a5,a5,0x30
    80008a06:	0107971b          	slliw	a4,a5,0x10
    80008a0a:	4107571b          	sraiw	a4,a4,0x10
    80008a0e:	fe843783          	ld	a5,-24(s0)
    80008a12:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80008a16:	fe843503          	ld	a0,-24(s0)
    80008a1a:	ffffd097          	auipc	ra,0xffffd
    80008a1e:	0a6080e7          	jalr	166(ra) # 80005ac0 <iupdate>
  }
  iunlockput(dp);
    80008a22:	fe843503          	ld	a0,-24(s0)
    80008a26:	ffffd097          	auipc	ra,0xffffd
    80008a2a:	548080e7          	jalr	1352(ra) # 80005f6e <iunlockput>

  ip->nlink--;
    80008a2e:	fe043783          	ld	a5,-32(s0)
    80008a32:	04a79783          	lh	a5,74(a5)
    80008a36:	17c2                	slli	a5,a5,0x30
    80008a38:	93c1                	srli	a5,a5,0x30
    80008a3a:	37fd                	addiw	a5,a5,-1
    80008a3c:	17c2                	slli	a5,a5,0x30
    80008a3e:	93c1                	srli	a5,a5,0x30
    80008a40:	0107971b          	slliw	a4,a5,0x10
    80008a44:	4107571b          	sraiw	a4,a4,0x10
    80008a48:	fe043783          	ld	a5,-32(s0)
    80008a4c:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80008a50:	fe043503          	ld	a0,-32(s0)
    80008a54:	ffffd097          	auipc	ra,0xffffd
    80008a58:	06c080e7          	jalr	108(ra) # 80005ac0 <iupdate>
  iunlockput(ip);
    80008a5c:	fe043503          	ld	a0,-32(s0)
    80008a60:	ffffd097          	auipc	ra,0xffffd
    80008a64:	50e080e7          	jalr	1294(ra) # 80005f6e <iunlockput>

  end_op();
    80008a68:	ffffe097          	auipc	ra,0xffffe
    80008a6c:	3d2080e7          	jalr	978(ra) # 80006e3a <end_op>

  return 0;
    80008a70:	4781                	li	a5,0
    80008a72:	a839                	j	80008a90 <sys_unlink+0x20e>
    goto bad;
    80008a74:	0001                	nop
    80008a76:	a011                	j	80008a7a <sys_unlink+0x1f8>
    goto bad;
    80008a78:	0001                	nop

bad:
  iunlockput(dp);
    80008a7a:	fe843503          	ld	a0,-24(s0)
    80008a7e:	ffffd097          	auipc	ra,0xffffd
    80008a82:	4f0080e7          	jalr	1264(ra) # 80005f6e <iunlockput>
  end_op();
    80008a86:	ffffe097          	auipc	ra,0xffffe
    80008a8a:	3b4080e7          	jalr	948(ra) # 80006e3a <end_op>
  return -1;
    80008a8e:	57fd                	li	a5,-1
}
    80008a90:	853e                	mv	a0,a5
    80008a92:	60ae                	ld	ra,200(sp)
    80008a94:	640e                	ld	s0,192(sp)
    80008a96:	6169                	addi	sp,sp,208
    80008a98:	8082                	ret

0000000080008a9a <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
    80008a9a:	7139                	addi	sp,sp,-64
    80008a9c:	fc06                	sd	ra,56(sp)
    80008a9e:	f822                	sd	s0,48(sp)
    80008aa0:	0080                	addi	s0,sp,64
    80008aa2:	fca43423          	sd	a0,-56(s0)
    80008aa6:	87ae                	mv	a5,a1
    80008aa8:	8736                	mv	a4,a3
    80008aaa:	fcf41323          	sh	a5,-58(s0)
    80008aae:	87b2                	mv	a5,a2
    80008ab0:	fcf41223          	sh	a5,-60(s0)
    80008ab4:	87ba                	mv	a5,a4
    80008ab6:	fcf41123          	sh	a5,-62(s0)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80008aba:	fd040793          	addi	a5,s0,-48
    80008abe:	85be                	mv	a1,a5
    80008ac0:	fc843503          	ld	a0,-56(s0)
    80008ac4:	ffffe097          	auipc	ra,0xffffe
    80008ac8:	f7c080e7          	jalr	-132(ra) # 80006a40 <nameiparent>
    80008acc:	fea43423          	sd	a0,-24(s0)
    80008ad0:	fe843783          	ld	a5,-24(s0)
    80008ad4:	e399                	bnez	a5,80008ada <create+0x40>
    return 0;
    80008ad6:	4781                	li	a5,0
    80008ad8:	a2d9                	j	80008c9e <create+0x204>

  ilock(dp);
    80008ada:	fe843503          	ld	a0,-24(s0)
    80008ade:	ffffd097          	auipc	ra,0xffffd
    80008ae2:	232080e7          	jalr	562(ra) # 80005d10 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80008ae6:	fd040793          	addi	a5,s0,-48
    80008aea:	4601                	li	a2,0
    80008aec:	85be                	mv	a1,a5
    80008aee:	fe843503          	ld	a0,-24(s0)
    80008af2:	ffffe097          	auipc	ra,0xffffe
    80008af6:	b20080e7          	jalr	-1248(ra) # 80006612 <dirlookup>
    80008afa:	fea43023          	sd	a0,-32(s0)
    80008afe:	fe043783          	ld	a5,-32(s0)
    80008b02:	c3ad                	beqz	a5,80008b64 <create+0xca>
    iunlockput(dp);
    80008b04:	fe843503          	ld	a0,-24(s0)
    80008b08:	ffffd097          	auipc	ra,0xffffd
    80008b0c:	466080e7          	jalr	1126(ra) # 80005f6e <iunlockput>
    ilock(ip);
    80008b10:	fe043503          	ld	a0,-32(s0)
    80008b14:	ffffd097          	auipc	ra,0xffffd
    80008b18:	1fc080e7          	jalr	508(ra) # 80005d10 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80008b1c:	fc641783          	lh	a5,-58(s0)
    80008b20:	0007871b          	sext.w	a4,a5
    80008b24:	4789                	li	a5,2
    80008b26:	02f71763          	bne	a4,a5,80008b54 <create+0xba>
    80008b2a:	fe043783          	ld	a5,-32(s0)
    80008b2e:	04479783          	lh	a5,68(a5)
    80008b32:	0007871b          	sext.w	a4,a5
    80008b36:	4789                	li	a5,2
    80008b38:	00f70b63          	beq	a4,a5,80008b4e <create+0xb4>
    80008b3c:	fe043783          	ld	a5,-32(s0)
    80008b40:	04479783          	lh	a5,68(a5)
    80008b44:	0007871b          	sext.w	a4,a5
    80008b48:	478d                	li	a5,3
    80008b4a:	00f71563          	bne	a4,a5,80008b54 <create+0xba>
      return ip;
    80008b4e:	fe043783          	ld	a5,-32(s0)
    80008b52:	a2b1                	j	80008c9e <create+0x204>
    iunlockput(ip);
    80008b54:	fe043503          	ld	a0,-32(s0)
    80008b58:	ffffd097          	auipc	ra,0xffffd
    80008b5c:	416080e7          	jalr	1046(ra) # 80005f6e <iunlockput>
    return 0;
    80008b60:	4781                	li	a5,0
    80008b62:	aa35                	j	80008c9e <create+0x204>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    80008b64:	fe843783          	ld	a5,-24(s0)
    80008b68:	439c                	lw	a5,0(a5)
    80008b6a:	fc641703          	lh	a4,-58(s0)
    80008b6e:	85ba                	mv	a1,a4
    80008b70:	853e                	mv	a0,a5
    80008b72:	ffffd097          	auipc	ra,0xffffd
    80008b76:	e52080e7          	jalr	-430(ra) # 800059c4 <ialloc>
    80008b7a:	fea43023          	sd	a0,-32(s0)
    80008b7e:	fe043783          	ld	a5,-32(s0)
    80008b82:	eb89                	bnez	a5,80008b94 <create+0xfa>
    panic("create: ialloc");
    80008b84:	00003517          	auipc	a0,0x3
    80008b88:	c6c50513          	addi	a0,a0,-916 # 8000b7f0 <etext+0x7f0>
    80008b8c:	ffff8097          	auipc	ra,0xffff8
    80008b90:	0ee080e7          	jalr	238(ra) # 80000c7a <panic>

  ilock(ip);
    80008b94:	fe043503          	ld	a0,-32(s0)
    80008b98:	ffffd097          	auipc	ra,0xffffd
    80008b9c:	178080e7          	jalr	376(ra) # 80005d10 <ilock>
  ip->major = major;
    80008ba0:	fe043783          	ld	a5,-32(s0)
    80008ba4:	fc445703          	lhu	a4,-60(s0)
    80008ba8:	04e79323          	sh	a4,70(a5)
  ip->minor = minor;
    80008bac:	fe043783          	ld	a5,-32(s0)
    80008bb0:	fc245703          	lhu	a4,-62(s0)
    80008bb4:	04e79423          	sh	a4,72(a5)
  ip->nlink = 1;
    80008bb8:	fe043783          	ld	a5,-32(s0)
    80008bbc:	4705                	li	a4,1
    80008bbe:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80008bc2:	fe043503          	ld	a0,-32(s0)
    80008bc6:	ffffd097          	auipc	ra,0xffffd
    80008bca:	efa080e7          	jalr	-262(ra) # 80005ac0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
    80008bce:	fc641783          	lh	a5,-58(s0)
    80008bd2:	0007871b          	sext.w	a4,a5
    80008bd6:	4785                	li	a5,1
    80008bd8:	08f71363          	bne	a4,a5,80008c5e <create+0x1c4>
    dp->nlink++;  // for ".."
    80008bdc:	fe843783          	ld	a5,-24(s0)
    80008be0:	04a79783          	lh	a5,74(a5)
    80008be4:	17c2                	slli	a5,a5,0x30
    80008be6:	93c1                	srli	a5,a5,0x30
    80008be8:	2785                	addiw	a5,a5,1
    80008bea:	17c2                	slli	a5,a5,0x30
    80008bec:	93c1                	srli	a5,a5,0x30
    80008bee:	0107971b          	slliw	a4,a5,0x10
    80008bf2:	4107571b          	sraiw	a4,a4,0x10
    80008bf6:	fe843783          	ld	a5,-24(s0)
    80008bfa:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80008bfe:	fe843503          	ld	a0,-24(s0)
    80008c02:	ffffd097          	auipc	ra,0xffffd
    80008c06:	ebe080e7          	jalr	-322(ra) # 80005ac0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80008c0a:	fe043783          	ld	a5,-32(s0)
    80008c0e:	43dc                	lw	a5,4(a5)
    80008c10:	863e                	mv	a2,a5
    80008c12:	00003597          	auipc	a1,0x3
    80008c16:	ba658593          	addi	a1,a1,-1114 # 8000b7b8 <etext+0x7b8>
    80008c1a:	fe043503          	ld	a0,-32(s0)
    80008c1e:	ffffe097          	auipc	ra,0xffffe
    80008c22:	adc080e7          	jalr	-1316(ra) # 800066fa <dirlink>
    80008c26:	87aa                	mv	a5,a0
    80008c28:	0207c363          	bltz	a5,80008c4e <create+0x1b4>
    80008c2c:	fe843783          	ld	a5,-24(s0)
    80008c30:	43dc                	lw	a5,4(a5)
    80008c32:	863e                	mv	a2,a5
    80008c34:	00003597          	auipc	a1,0x3
    80008c38:	b8c58593          	addi	a1,a1,-1140 # 8000b7c0 <etext+0x7c0>
    80008c3c:	fe043503          	ld	a0,-32(s0)
    80008c40:	ffffe097          	auipc	ra,0xffffe
    80008c44:	aba080e7          	jalr	-1350(ra) # 800066fa <dirlink>
    80008c48:	87aa                	mv	a5,a0
    80008c4a:	0007da63          	bgez	a5,80008c5e <create+0x1c4>
      panic("create dots");
    80008c4e:	00003517          	auipc	a0,0x3
    80008c52:	bb250513          	addi	a0,a0,-1102 # 8000b800 <etext+0x800>
    80008c56:	ffff8097          	auipc	ra,0xffff8
    80008c5a:	024080e7          	jalr	36(ra) # 80000c7a <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    80008c5e:	fe043783          	ld	a5,-32(s0)
    80008c62:	43d8                	lw	a4,4(a5)
    80008c64:	fd040793          	addi	a5,s0,-48
    80008c68:	863a                	mv	a2,a4
    80008c6a:	85be                	mv	a1,a5
    80008c6c:	fe843503          	ld	a0,-24(s0)
    80008c70:	ffffe097          	auipc	ra,0xffffe
    80008c74:	a8a080e7          	jalr	-1398(ra) # 800066fa <dirlink>
    80008c78:	87aa                	mv	a5,a0
    80008c7a:	0007da63          	bgez	a5,80008c8e <create+0x1f4>
    panic("create: dirlink");
    80008c7e:	00003517          	auipc	a0,0x3
    80008c82:	b9250513          	addi	a0,a0,-1134 # 8000b810 <etext+0x810>
    80008c86:	ffff8097          	auipc	ra,0xffff8
    80008c8a:	ff4080e7          	jalr	-12(ra) # 80000c7a <panic>

  iunlockput(dp);
    80008c8e:	fe843503          	ld	a0,-24(s0)
    80008c92:	ffffd097          	auipc	ra,0xffffd
    80008c96:	2dc080e7          	jalr	732(ra) # 80005f6e <iunlockput>

  return ip;
    80008c9a:	fe043783          	ld	a5,-32(s0)
}
    80008c9e:	853e                	mv	a0,a5
    80008ca0:	70e2                	ld	ra,56(sp)
    80008ca2:	7442                	ld	s0,48(sp)
    80008ca4:	6121                	addi	sp,sp,64
    80008ca6:	8082                	ret

0000000080008ca8 <sys_open>:

uint64
sys_open(void)
{
    80008ca8:	7131                	addi	sp,sp,-192
    80008caa:	fd06                	sd	ra,184(sp)
    80008cac:	f922                	sd	s0,176(sp)
    80008cae:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80008cb0:	f5040793          	addi	a5,s0,-176
    80008cb4:	08000613          	li	a2,128
    80008cb8:	85be                	mv	a1,a5
    80008cba:	4501                	li	a0,0
    80008cbc:	ffffc097          	auipc	ra,0xffffc
    80008cc0:	f0c080e7          	jalr	-244(ra) # 80004bc8 <argstr>
    80008cc4:	87aa                	mv	a5,a0
    80008cc6:	fef42223          	sw	a5,-28(s0)
    80008cca:	fe442783          	lw	a5,-28(s0)
    80008cce:	2781                	sext.w	a5,a5
    80008cd0:	0007cd63          	bltz	a5,80008cea <sys_open+0x42>
    80008cd4:	f4c40793          	addi	a5,s0,-180
    80008cd8:	85be                	mv	a1,a5
    80008cda:	4505                	li	a0,1
    80008cdc:	ffffc097          	auipc	ra,0xffffc
    80008ce0:	e80080e7          	jalr	-384(ra) # 80004b5c <argint>
    80008ce4:	87aa                	mv	a5,a0
    80008ce6:	0007d463          	bgez	a5,80008cee <sys_open+0x46>
    return -1;
    80008cea:	57fd                	li	a5,-1
    80008cec:	a429                	j	80008ef6 <sys_open+0x24e>

  begin_op();
    80008cee:	ffffe097          	auipc	ra,0xffffe
    80008cf2:	08a080e7          	jalr	138(ra) # 80006d78 <begin_op>

  if(omode & O_CREATE){
    80008cf6:	f4c42783          	lw	a5,-180(s0)
    80008cfa:	2007f793          	andi	a5,a5,512
    80008cfe:	2781                	sext.w	a5,a5
    80008d00:	c795                	beqz	a5,80008d2c <sys_open+0x84>
    ip = create(path, T_FILE, 0, 0);
    80008d02:	f5040793          	addi	a5,s0,-176
    80008d06:	4681                	li	a3,0
    80008d08:	4601                	li	a2,0
    80008d0a:	4589                	li	a1,2
    80008d0c:	853e                	mv	a0,a5
    80008d0e:	00000097          	auipc	ra,0x0
    80008d12:	d8c080e7          	jalr	-628(ra) # 80008a9a <create>
    80008d16:	fea43423          	sd	a0,-24(s0)
    if(ip == 0){
    80008d1a:	fe843783          	ld	a5,-24(s0)
    80008d1e:	e7bd                	bnez	a5,80008d8c <sys_open+0xe4>
      end_op();
    80008d20:	ffffe097          	auipc	ra,0xffffe
    80008d24:	11a080e7          	jalr	282(ra) # 80006e3a <end_op>
      return -1;
    80008d28:	57fd                	li	a5,-1
    80008d2a:	a2f1                	j	80008ef6 <sys_open+0x24e>
    }
  } else {
    if((ip = namei(path)) == 0){
    80008d2c:	f5040793          	addi	a5,s0,-176
    80008d30:	853e                	mv	a0,a5
    80008d32:	ffffe097          	auipc	ra,0xffffe
    80008d36:	ce2080e7          	jalr	-798(ra) # 80006a14 <namei>
    80008d3a:	fea43423          	sd	a0,-24(s0)
    80008d3e:	fe843783          	ld	a5,-24(s0)
    80008d42:	e799                	bnez	a5,80008d50 <sys_open+0xa8>
      end_op();
    80008d44:	ffffe097          	auipc	ra,0xffffe
    80008d48:	0f6080e7          	jalr	246(ra) # 80006e3a <end_op>
      return -1;
    80008d4c:	57fd                	li	a5,-1
    80008d4e:	a265                	j	80008ef6 <sys_open+0x24e>
    }
    ilock(ip);
    80008d50:	fe843503          	ld	a0,-24(s0)
    80008d54:	ffffd097          	auipc	ra,0xffffd
    80008d58:	fbc080e7          	jalr	-68(ra) # 80005d10 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80008d5c:	fe843783          	ld	a5,-24(s0)
    80008d60:	04479783          	lh	a5,68(a5)
    80008d64:	0007871b          	sext.w	a4,a5
    80008d68:	4785                	li	a5,1
    80008d6a:	02f71163          	bne	a4,a5,80008d8c <sys_open+0xe4>
    80008d6e:	f4c42783          	lw	a5,-180(s0)
    80008d72:	cf89                	beqz	a5,80008d8c <sys_open+0xe4>
      iunlockput(ip);
    80008d74:	fe843503          	ld	a0,-24(s0)
    80008d78:	ffffd097          	auipc	ra,0xffffd
    80008d7c:	1f6080e7          	jalr	502(ra) # 80005f6e <iunlockput>
      end_op();
    80008d80:	ffffe097          	auipc	ra,0xffffe
    80008d84:	0ba080e7          	jalr	186(ra) # 80006e3a <end_op>
      return -1;
    80008d88:	57fd                	li	a5,-1
    80008d8a:	a2b5                	j	80008ef6 <sys_open+0x24e>
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80008d8c:	fe843783          	ld	a5,-24(s0)
    80008d90:	04479783          	lh	a5,68(a5)
    80008d94:	0007871b          	sext.w	a4,a5
    80008d98:	478d                	li	a5,3
    80008d9a:	02f71e63          	bne	a4,a5,80008dd6 <sys_open+0x12e>
    80008d9e:	fe843783          	ld	a5,-24(s0)
    80008da2:	04679783          	lh	a5,70(a5)
    80008da6:	2781                	sext.w	a5,a5
    80008da8:	0007cb63          	bltz	a5,80008dbe <sys_open+0x116>
    80008dac:	fe843783          	ld	a5,-24(s0)
    80008db0:	04679783          	lh	a5,70(a5)
    80008db4:	0007871b          	sext.w	a4,a5
    80008db8:	47a5                	li	a5,9
    80008dba:	00e7de63          	bge	a5,a4,80008dd6 <sys_open+0x12e>
    iunlockput(ip);
    80008dbe:	fe843503          	ld	a0,-24(s0)
    80008dc2:	ffffd097          	auipc	ra,0xffffd
    80008dc6:	1ac080e7          	jalr	428(ra) # 80005f6e <iunlockput>
    end_op();
    80008dca:	ffffe097          	auipc	ra,0xffffe
    80008dce:	070080e7          	jalr	112(ra) # 80006e3a <end_op>
    return -1;
    80008dd2:	57fd                	li	a5,-1
    80008dd4:	a20d                	j	80008ef6 <sys_open+0x24e>
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80008dd6:	ffffe097          	auipc	ra,0xffffe
    80008dda:	552080e7          	jalr	1362(ra) # 80007328 <filealloc>
    80008dde:	fca43c23          	sd	a0,-40(s0)
    80008de2:	fd843783          	ld	a5,-40(s0)
    80008de6:	cf99                	beqz	a5,80008e04 <sys_open+0x15c>
    80008de8:	fd843503          	ld	a0,-40(s0)
    80008dec:	fffff097          	auipc	ra,0xfffff
    80008df0:	5e8080e7          	jalr	1512(ra) # 800083d4 <fdalloc>
    80008df4:	87aa                	mv	a5,a0
    80008df6:	fcf42a23          	sw	a5,-44(s0)
    80008dfa:	fd442783          	lw	a5,-44(s0)
    80008dfe:	2781                	sext.w	a5,a5
    80008e00:	0207d763          	bgez	a5,80008e2e <sys_open+0x186>
    if(f)
    80008e04:	fd843783          	ld	a5,-40(s0)
    80008e08:	c799                	beqz	a5,80008e16 <sys_open+0x16e>
      fileclose(f);
    80008e0a:	fd843503          	ld	a0,-40(s0)
    80008e0e:	ffffe097          	auipc	ra,0xffffe
    80008e12:	604080e7          	jalr	1540(ra) # 80007412 <fileclose>
    iunlockput(ip);
    80008e16:	fe843503          	ld	a0,-24(s0)
    80008e1a:	ffffd097          	auipc	ra,0xffffd
    80008e1e:	154080e7          	jalr	340(ra) # 80005f6e <iunlockput>
    end_op();
    80008e22:	ffffe097          	auipc	ra,0xffffe
    80008e26:	018080e7          	jalr	24(ra) # 80006e3a <end_op>
    return -1;
    80008e2a:	57fd                	li	a5,-1
    80008e2c:	a0e9                	j	80008ef6 <sys_open+0x24e>
  }

  if(ip->type == T_DEVICE){
    80008e2e:	fe843783          	ld	a5,-24(s0)
    80008e32:	04479783          	lh	a5,68(a5)
    80008e36:	0007871b          	sext.w	a4,a5
    80008e3a:	478d                	li	a5,3
    80008e3c:	00f71f63          	bne	a4,a5,80008e5a <sys_open+0x1b2>
    f->type = FD_DEVICE;
    80008e40:	fd843783          	ld	a5,-40(s0)
    80008e44:	470d                	li	a4,3
    80008e46:	c398                	sw	a4,0(a5)
    f->major = ip->major;
    80008e48:	fe843783          	ld	a5,-24(s0)
    80008e4c:	04679703          	lh	a4,70(a5)
    80008e50:	fd843783          	ld	a5,-40(s0)
    80008e54:	02e79223          	sh	a4,36(a5)
    80008e58:	a809                	j	80008e6a <sys_open+0x1c2>
  } else {
    f->type = FD_INODE;
    80008e5a:	fd843783          	ld	a5,-40(s0)
    80008e5e:	4709                	li	a4,2
    80008e60:	c398                	sw	a4,0(a5)
    f->off = 0;
    80008e62:	fd843783          	ld	a5,-40(s0)
    80008e66:	0207a023          	sw	zero,32(a5)
  }
  f->ip = ip;
    80008e6a:	fd843783          	ld	a5,-40(s0)
    80008e6e:	fe843703          	ld	a4,-24(s0)
    80008e72:	ef98                	sd	a4,24(a5)
  f->readable = !(omode & O_WRONLY);
    80008e74:	f4c42783          	lw	a5,-180(s0)
    80008e78:	8b85                	andi	a5,a5,1
    80008e7a:	2781                	sext.w	a5,a5
    80008e7c:	0017b793          	seqz	a5,a5
    80008e80:	0ff7f793          	zext.b	a5,a5
    80008e84:	873e                	mv	a4,a5
    80008e86:	fd843783          	ld	a5,-40(s0)
    80008e8a:	00e78423          	sb	a4,8(a5)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80008e8e:	f4c42783          	lw	a5,-180(s0)
    80008e92:	8b85                	andi	a5,a5,1
    80008e94:	2781                	sext.w	a5,a5
    80008e96:	e791                	bnez	a5,80008ea2 <sys_open+0x1fa>
    80008e98:	f4c42783          	lw	a5,-180(s0)
    80008e9c:	8b89                	andi	a5,a5,2
    80008e9e:	2781                	sext.w	a5,a5
    80008ea0:	c399                	beqz	a5,80008ea6 <sys_open+0x1fe>
    80008ea2:	4785                	li	a5,1
    80008ea4:	a011                	j	80008ea8 <sys_open+0x200>
    80008ea6:	4781                	li	a5,0
    80008ea8:	0ff7f713          	zext.b	a4,a5
    80008eac:	fd843783          	ld	a5,-40(s0)
    80008eb0:	00e784a3          	sb	a4,9(a5)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80008eb4:	f4c42783          	lw	a5,-180(s0)
    80008eb8:	4007f793          	andi	a5,a5,1024
    80008ebc:	2781                	sext.w	a5,a5
    80008ebe:	c385                	beqz	a5,80008ede <sys_open+0x236>
    80008ec0:	fe843783          	ld	a5,-24(s0)
    80008ec4:	04479783          	lh	a5,68(a5)
    80008ec8:	0007871b          	sext.w	a4,a5
    80008ecc:	4789                	li	a5,2
    80008ece:	00f71863          	bne	a4,a5,80008ede <sys_open+0x236>
    itrunc(ip);
    80008ed2:	fe843503          	ld	a0,-24(s0)
    80008ed6:	ffffd097          	auipc	ra,0xffffd
    80008eda:	222080e7          	jalr	546(ra) # 800060f8 <itrunc>
  }

  iunlock(ip);
    80008ede:	fe843503          	ld	a0,-24(s0)
    80008ee2:	ffffd097          	auipc	ra,0xffffd
    80008ee6:	f62080e7          	jalr	-158(ra) # 80005e44 <iunlock>
  end_op();
    80008eea:	ffffe097          	auipc	ra,0xffffe
    80008eee:	f50080e7          	jalr	-176(ra) # 80006e3a <end_op>

  return fd;
    80008ef2:	fd442783          	lw	a5,-44(s0)
}
    80008ef6:	853e                	mv	a0,a5
    80008ef8:	70ea                	ld	ra,184(sp)
    80008efa:	744a                	ld	s0,176(sp)
    80008efc:	6129                	addi	sp,sp,192
    80008efe:	8082                	ret

0000000080008f00 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80008f00:	7135                	addi	sp,sp,-160
    80008f02:	ed06                	sd	ra,152(sp)
    80008f04:	e922                	sd	s0,144(sp)
    80008f06:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80008f08:	ffffe097          	auipc	ra,0xffffe
    80008f0c:	e70080e7          	jalr	-400(ra) # 80006d78 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80008f10:	f6840793          	addi	a5,s0,-152
    80008f14:	08000613          	li	a2,128
    80008f18:	85be                	mv	a1,a5
    80008f1a:	4501                	li	a0,0
    80008f1c:	ffffc097          	auipc	ra,0xffffc
    80008f20:	cac080e7          	jalr	-852(ra) # 80004bc8 <argstr>
    80008f24:	87aa                	mv	a5,a0
    80008f26:	0207c163          	bltz	a5,80008f48 <sys_mkdir+0x48>
    80008f2a:	f6840793          	addi	a5,s0,-152
    80008f2e:	4681                	li	a3,0
    80008f30:	4601                	li	a2,0
    80008f32:	4585                	li	a1,1
    80008f34:	853e                	mv	a0,a5
    80008f36:	00000097          	auipc	ra,0x0
    80008f3a:	b64080e7          	jalr	-1180(ra) # 80008a9a <create>
    80008f3e:	fea43423          	sd	a0,-24(s0)
    80008f42:	fe843783          	ld	a5,-24(s0)
    80008f46:	e799                	bnez	a5,80008f54 <sys_mkdir+0x54>
    end_op();
    80008f48:	ffffe097          	auipc	ra,0xffffe
    80008f4c:	ef2080e7          	jalr	-270(ra) # 80006e3a <end_op>
    return -1;
    80008f50:	57fd                	li	a5,-1
    80008f52:	a821                	j	80008f6a <sys_mkdir+0x6a>
  }
  iunlockput(ip);
    80008f54:	fe843503          	ld	a0,-24(s0)
    80008f58:	ffffd097          	auipc	ra,0xffffd
    80008f5c:	016080e7          	jalr	22(ra) # 80005f6e <iunlockput>
  end_op();
    80008f60:	ffffe097          	auipc	ra,0xffffe
    80008f64:	eda080e7          	jalr	-294(ra) # 80006e3a <end_op>
  return 0;
    80008f68:	4781                	li	a5,0
}
    80008f6a:	853e                	mv	a0,a5
    80008f6c:	60ea                	ld	ra,152(sp)
    80008f6e:	644a                	ld	s0,144(sp)
    80008f70:	610d                	addi	sp,sp,160
    80008f72:	8082                	ret

0000000080008f74 <sys_mknod>:

uint64
sys_mknod(void)
{
    80008f74:	7135                	addi	sp,sp,-160
    80008f76:	ed06                	sd	ra,152(sp)
    80008f78:	e922                	sd	s0,144(sp)
    80008f7a:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80008f7c:	ffffe097          	auipc	ra,0xffffe
    80008f80:	dfc080e7          	jalr	-516(ra) # 80006d78 <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80008f84:	f6840793          	addi	a5,s0,-152
    80008f88:	08000613          	li	a2,128
    80008f8c:	85be                	mv	a1,a5
    80008f8e:	4501                	li	a0,0
    80008f90:	ffffc097          	auipc	ra,0xffffc
    80008f94:	c38080e7          	jalr	-968(ra) # 80004bc8 <argstr>
    80008f98:	87aa                	mv	a5,a0
    80008f9a:	0607c263          	bltz	a5,80008ffe <sys_mknod+0x8a>
     argint(1, &major) < 0 ||
    80008f9e:	f6440793          	addi	a5,s0,-156
    80008fa2:	85be                	mv	a1,a5
    80008fa4:	4505                	li	a0,1
    80008fa6:	ffffc097          	auipc	ra,0xffffc
    80008faa:	bb6080e7          	jalr	-1098(ra) # 80004b5c <argint>
    80008fae:	87aa                	mv	a5,a0
  if((argstr(0, path, MAXPATH)) < 0 ||
    80008fb0:	0407c763          	bltz	a5,80008ffe <sys_mknod+0x8a>
     argint(2, &minor) < 0 ||
    80008fb4:	f6040793          	addi	a5,s0,-160
    80008fb8:	85be                	mv	a1,a5
    80008fba:	4509                	li	a0,2
    80008fbc:	ffffc097          	auipc	ra,0xffffc
    80008fc0:	ba0080e7          	jalr	-1120(ra) # 80004b5c <argint>
    80008fc4:	87aa                	mv	a5,a0
     argint(1, &major) < 0 ||
    80008fc6:	0207cc63          	bltz	a5,80008ffe <sys_mknod+0x8a>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80008fca:	f6442783          	lw	a5,-156(s0)
    80008fce:	0107971b          	slliw	a4,a5,0x10
    80008fd2:	4107571b          	sraiw	a4,a4,0x10
    80008fd6:	f6042783          	lw	a5,-160(s0)
    80008fda:	0107969b          	slliw	a3,a5,0x10
    80008fde:	4106d69b          	sraiw	a3,a3,0x10
    80008fe2:	f6840793          	addi	a5,s0,-152
    80008fe6:	863a                	mv	a2,a4
    80008fe8:	458d                	li	a1,3
    80008fea:	853e                	mv	a0,a5
    80008fec:	00000097          	auipc	ra,0x0
    80008ff0:	aae080e7          	jalr	-1362(ra) # 80008a9a <create>
    80008ff4:	fea43423          	sd	a0,-24(s0)
     argint(2, &minor) < 0 ||
    80008ff8:	fe843783          	ld	a5,-24(s0)
    80008ffc:	e799                	bnez	a5,8000900a <sys_mknod+0x96>
    end_op();
    80008ffe:	ffffe097          	auipc	ra,0xffffe
    80009002:	e3c080e7          	jalr	-452(ra) # 80006e3a <end_op>
    return -1;
    80009006:	57fd                	li	a5,-1
    80009008:	a821                	j	80009020 <sys_mknod+0xac>
  }
  iunlockput(ip);
    8000900a:	fe843503          	ld	a0,-24(s0)
    8000900e:	ffffd097          	auipc	ra,0xffffd
    80009012:	f60080e7          	jalr	-160(ra) # 80005f6e <iunlockput>
  end_op();
    80009016:	ffffe097          	auipc	ra,0xffffe
    8000901a:	e24080e7          	jalr	-476(ra) # 80006e3a <end_op>
  return 0;
    8000901e:	4781                	li	a5,0
}
    80009020:	853e                	mv	a0,a5
    80009022:	60ea                	ld	ra,152(sp)
    80009024:	644a                	ld	s0,144(sp)
    80009026:	610d                	addi	sp,sp,160
    80009028:	8082                	ret

000000008000902a <sys_chdir>:

uint64
sys_chdir(void)
{
    8000902a:	7135                	addi	sp,sp,-160
    8000902c:	ed06                	sd	ra,152(sp)
    8000902e:	e922                	sd	s0,144(sp)
    80009030:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80009032:	ffffa097          	auipc	ra,0xffffa
    80009036:	9e6080e7          	jalr	-1562(ra) # 80002a18 <myproc>
    8000903a:	fea43423          	sd	a0,-24(s0)
  
  begin_op();
    8000903e:	ffffe097          	auipc	ra,0xffffe
    80009042:	d3a080e7          	jalr	-710(ra) # 80006d78 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80009046:	f6040793          	addi	a5,s0,-160
    8000904a:	08000613          	li	a2,128
    8000904e:	85be                	mv	a1,a5
    80009050:	4501                	li	a0,0
    80009052:	ffffc097          	auipc	ra,0xffffc
    80009056:	b76080e7          	jalr	-1162(ra) # 80004bc8 <argstr>
    8000905a:	87aa                	mv	a5,a0
    8000905c:	0007ce63          	bltz	a5,80009078 <sys_chdir+0x4e>
    80009060:	f6040793          	addi	a5,s0,-160
    80009064:	853e                	mv	a0,a5
    80009066:	ffffe097          	auipc	ra,0xffffe
    8000906a:	9ae080e7          	jalr	-1618(ra) # 80006a14 <namei>
    8000906e:	fea43023          	sd	a0,-32(s0)
    80009072:	fe043783          	ld	a5,-32(s0)
    80009076:	e799                	bnez	a5,80009084 <sys_chdir+0x5a>
    end_op();
    80009078:	ffffe097          	auipc	ra,0xffffe
    8000907c:	dc2080e7          	jalr	-574(ra) # 80006e3a <end_op>
    return -1;
    80009080:	57fd                	li	a5,-1
    80009082:	a0b5                	j	800090ee <sys_chdir+0xc4>
  }
  ilock(ip);
    80009084:	fe043503          	ld	a0,-32(s0)
    80009088:	ffffd097          	auipc	ra,0xffffd
    8000908c:	c88080e7          	jalr	-888(ra) # 80005d10 <ilock>
  if(ip->type != T_DIR){
    80009090:	fe043783          	ld	a5,-32(s0)
    80009094:	04479783          	lh	a5,68(a5)
    80009098:	0007871b          	sext.w	a4,a5
    8000909c:	4785                	li	a5,1
    8000909e:	00f70e63          	beq	a4,a5,800090ba <sys_chdir+0x90>
    iunlockput(ip);
    800090a2:	fe043503          	ld	a0,-32(s0)
    800090a6:	ffffd097          	auipc	ra,0xffffd
    800090aa:	ec8080e7          	jalr	-312(ra) # 80005f6e <iunlockput>
    end_op();
    800090ae:	ffffe097          	auipc	ra,0xffffe
    800090b2:	d8c080e7          	jalr	-628(ra) # 80006e3a <end_op>
    return -1;
    800090b6:	57fd                	li	a5,-1
    800090b8:	a81d                	j	800090ee <sys_chdir+0xc4>
  }
  iunlock(ip);
    800090ba:	fe043503          	ld	a0,-32(s0)
    800090be:	ffffd097          	auipc	ra,0xffffd
    800090c2:	d86080e7          	jalr	-634(ra) # 80005e44 <iunlock>
  iput(p->cwd);
    800090c6:	fe843783          	ld	a5,-24(s0)
    800090ca:	1607b783          	ld	a5,352(a5)
    800090ce:	853e                	mv	a0,a5
    800090d0:	ffffd097          	auipc	ra,0xffffd
    800090d4:	dce080e7          	jalr	-562(ra) # 80005e9e <iput>
  end_op();
    800090d8:	ffffe097          	auipc	ra,0xffffe
    800090dc:	d62080e7          	jalr	-670(ra) # 80006e3a <end_op>
  p->cwd = ip;
    800090e0:	fe843783          	ld	a5,-24(s0)
    800090e4:	fe043703          	ld	a4,-32(s0)
    800090e8:	16e7b023          	sd	a4,352(a5)
  return 0;
    800090ec:	4781                	li	a5,0
}
    800090ee:	853e                	mv	a0,a5
    800090f0:	60ea                	ld	ra,152(sp)
    800090f2:	644a                	ld	s0,144(sp)
    800090f4:	610d                	addi	sp,sp,160
    800090f6:	8082                	ret

00000000800090f8 <sys_exec>:

uint64
sys_exec(void)
{
    800090f8:	7161                	addi	sp,sp,-432
    800090fa:	f706                	sd	ra,424(sp)
    800090fc:	f322                	sd	s0,416(sp)
    800090fe:	1b00                	addi	s0,sp,432
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80009100:	f6840793          	addi	a5,s0,-152
    80009104:	08000613          	li	a2,128
    80009108:	85be                	mv	a1,a5
    8000910a:	4501                	li	a0,0
    8000910c:	ffffc097          	auipc	ra,0xffffc
    80009110:	abc080e7          	jalr	-1348(ra) # 80004bc8 <argstr>
    80009114:	87aa                	mv	a5,a0
    80009116:	0007cd63          	bltz	a5,80009130 <sys_exec+0x38>
    8000911a:	e6040793          	addi	a5,s0,-416
    8000911e:	85be                	mv	a1,a5
    80009120:	4505                	li	a0,1
    80009122:	ffffc097          	auipc	ra,0xffffc
    80009126:	a72080e7          	jalr	-1422(ra) # 80004b94 <argaddr>
    8000912a:	87aa                	mv	a5,a0
    8000912c:	0007d463          	bgez	a5,80009134 <sys_exec+0x3c>
    return -1;
    80009130:	57fd                	li	a5,-1
    80009132:	aa8d                	j	800092a4 <sys_exec+0x1ac>
  }
  memset(argv, 0, sizeof(argv));
    80009134:	e6840793          	addi	a5,s0,-408
    80009138:	10000613          	li	a2,256
    8000913c:	4581                	li	a1,0
    8000913e:	853e                	mv	a0,a5
    80009140:	ffff8097          	auipc	ra,0xffff8
    80009144:	2fe080e7          	jalr	766(ra) # 8000143e <memset>
  for(i=0;; i++){
    80009148:	fe042623          	sw	zero,-20(s0)
    if(i >= NELEM(argv)){
    8000914c:	fec42783          	lw	a5,-20(s0)
    80009150:	873e                	mv	a4,a5
    80009152:	47fd                	li	a5,31
    80009154:	0ee7ee63          	bltu	a5,a4,80009250 <sys_exec+0x158>
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80009158:	fec42783          	lw	a5,-20(s0)
    8000915c:	00379713          	slli	a4,a5,0x3
    80009160:	e6043783          	ld	a5,-416(s0)
    80009164:	97ba                	add	a5,a5,a4
    80009166:	e5840713          	addi	a4,s0,-424
    8000916a:	85ba                	mv	a1,a4
    8000916c:	853e                	mv	a0,a5
    8000916e:	ffffc097          	auipc	ra,0xffffc
    80009172:	870080e7          	jalr	-1936(ra) # 800049de <fetchaddr>
    80009176:	87aa                	mv	a5,a0
    80009178:	0c07ce63          	bltz	a5,80009254 <sys_exec+0x15c>
      goto bad;
    }
    if(uarg == 0){
    8000917c:	e5843783          	ld	a5,-424(s0)
    80009180:	eb8d                	bnez	a5,800091b2 <sys_exec+0xba>
      argv[i] = 0;
    80009182:	fec42783          	lw	a5,-20(s0)
    80009186:	078e                	slli	a5,a5,0x3
    80009188:	17c1                	addi	a5,a5,-16
    8000918a:	97a2                	add	a5,a5,s0
    8000918c:	e607bc23          	sd	zero,-392(a5)
      break;
    80009190:	0001                	nop
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
      goto bad;
  }

  int ret = exec(path, argv);
    80009192:	e6840713          	addi	a4,s0,-408
    80009196:	f6840793          	addi	a5,s0,-152
    8000919a:	85ba                	mv	a1,a4
    8000919c:	853e                	mv	a0,a5
    8000919e:	fffff097          	auipc	ra,0xfffff
    800091a2:	c2a080e7          	jalr	-982(ra) # 80007dc8 <exec>
    800091a6:	87aa                	mv	a5,a0
    800091a8:	fef42423          	sw	a5,-24(s0)

  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800091ac:	fe042623          	sw	zero,-20(s0)
    800091b0:	a8bd                	j	8000922e <sys_exec+0x136>
    argv[i] = kalloc();
    800091b2:	ffff8097          	auipc	ra,0xffff8
    800091b6:	f64080e7          	jalr	-156(ra) # 80001116 <kalloc>
    800091ba:	872a                	mv	a4,a0
    800091bc:	fec42783          	lw	a5,-20(s0)
    800091c0:	078e                	slli	a5,a5,0x3
    800091c2:	17c1                	addi	a5,a5,-16
    800091c4:	97a2                	add	a5,a5,s0
    800091c6:	e6e7bc23          	sd	a4,-392(a5)
    if(argv[i] == 0)
    800091ca:	fec42783          	lw	a5,-20(s0)
    800091ce:	078e                	slli	a5,a5,0x3
    800091d0:	17c1                	addi	a5,a5,-16
    800091d2:	97a2                	add	a5,a5,s0
    800091d4:	e787b783          	ld	a5,-392(a5)
    800091d8:	c3c1                	beqz	a5,80009258 <sys_exec+0x160>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800091da:	e5843703          	ld	a4,-424(s0)
    800091de:	fec42783          	lw	a5,-20(s0)
    800091e2:	078e                	slli	a5,a5,0x3
    800091e4:	17c1                	addi	a5,a5,-16
    800091e6:	97a2                	add	a5,a5,s0
    800091e8:	e787b783          	ld	a5,-392(a5)
    800091ec:	6605                	lui	a2,0x1
    800091ee:	85be                	mv	a1,a5
    800091f0:	853a                	mv	a0,a4
    800091f2:	ffffc097          	auipc	ra,0xffffc
    800091f6:	85a080e7          	jalr	-1958(ra) # 80004a4c <fetchstr>
    800091fa:	87aa                	mv	a5,a0
    800091fc:	0607c063          	bltz	a5,8000925c <sys_exec+0x164>
  for(i=0;; i++){
    80009200:	fec42783          	lw	a5,-20(s0)
    80009204:	2785                	addiw	a5,a5,1
    80009206:	fef42623          	sw	a5,-20(s0)
    if(i >= NELEM(argv)){
    8000920a:	b789                	j	8000914c <sys_exec+0x54>
    kfree(argv[i]);
    8000920c:	fec42783          	lw	a5,-20(s0)
    80009210:	078e                	slli	a5,a5,0x3
    80009212:	17c1                	addi	a5,a5,-16
    80009214:	97a2                	add	a5,a5,s0
    80009216:	e787b783          	ld	a5,-392(a5)
    8000921a:	853e                	mv	a0,a5
    8000921c:	ffff8097          	auipc	ra,0xffff8
    80009220:	e56080e7          	jalr	-426(ra) # 80001072 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80009224:	fec42783          	lw	a5,-20(s0)
    80009228:	2785                	addiw	a5,a5,1
    8000922a:	fef42623          	sw	a5,-20(s0)
    8000922e:	fec42783          	lw	a5,-20(s0)
    80009232:	873e                	mv	a4,a5
    80009234:	47fd                	li	a5,31
    80009236:	00e7ea63          	bltu	a5,a4,8000924a <sys_exec+0x152>
    8000923a:	fec42783          	lw	a5,-20(s0)
    8000923e:	078e                	slli	a5,a5,0x3
    80009240:	17c1                	addi	a5,a5,-16
    80009242:	97a2                	add	a5,a5,s0
    80009244:	e787b783          	ld	a5,-392(a5)
    80009248:	f3f1                	bnez	a5,8000920c <sys_exec+0x114>

  return ret;
    8000924a:	fe842783          	lw	a5,-24(s0)
    8000924e:	a899                	j	800092a4 <sys_exec+0x1ac>
      goto bad;
    80009250:	0001                	nop
    80009252:	a031                	j	8000925e <sys_exec+0x166>
      goto bad;
    80009254:	0001                	nop
    80009256:	a021                	j	8000925e <sys_exec+0x166>
      goto bad;
    80009258:	0001                	nop
    8000925a:	a011                	j	8000925e <sys_exec+0x166>
      goto bad;
    8000925c:	0001                	nop

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000925e:	fe042623          	sw	zero,-20(s0)
    80009262:	a015                	j	80009286 <sys_exec+0x18e>
    kfree(argv[i]);
    80009264:	fec42783          	lw	a5,-20(s0)
    80009268:	078e                	slli	a5,a5,0x3
    8000926a:	17c1                	addi	a5,a5,-16
    8000926c:	97a2                	add	a5,a5,s0
    8000926e:	e787b783          	ld	a5,-392(a5)
    80009272:	853e                	mv	a0,a5
    80009274:	ffff8097          	auipc	ra,0xffff8
    80009278:	dfe080e7          	jalr	-514(ra) # 80001072 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000927c:	fec42783          	lw	a5,-20(s0)
    80009280:	2785                	addiw	a5,a5,1
    80009282:	fef42623          	sw	a5,-20(s0)
    80009286:	fec42783          	lw	a5,-20(s0)
    8000928a:	873e                	mv	a4,a5
    8000928c:	47fd                	li	a5,31
    8000928e:	00e7ea63          	bltu	a5,a4,800092a2 <sys_exec+0x1aa>
    80009292:	fec42783          	lw	a5,-20(s0)
    80009296:	078e                	slli	a5,a5,0x3
    80009298:	17c1                	addi	a5,a5,-16
    8000929a:	97a2                	add	a5,a5,s0
    8000929c:	e787b783          	ld	a5,-392(a5)
    800092a0:	f3f1                	bnez	a5,80009264 <sys_exec+0x16c>
  return -1;
    800092a2:	57fd                	li	a5,-1
}
    800092a4:	853e                	mv	a0,a5
    800092a6:	70ba                	ld	ra,424(sp)
    800092a8:	741a                	ld	s0,416(sp)
    800092aa:	615d                	addi	sp,sp,432
    800092ac:	8082                	ret

00000000800092ae <sys_pipe>:

uint64
sys_pipe(void)
{
    800092ae:	7139                	addi	sp,sp,-64
    800092b0:	fc06                	sd	ra,56(sp)
    800092b2:	f822                	sd	s0,48(sp)
    800092b4:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    800092b6:	ffff9097          	auipc	ra,0xffff9
    800092ba:	762080e7          	jalr	1890(ra) # 80002a18 <myproc>
    800092be:	fea43423          	sd	a0,-24(s0)

  if(argaddr(0, &fdarray) < 0)
    800092c2:	fe040793          	addi	a5,s0,-32
    800092c6:	85be                	mv	a1,a5
    800092c8:	4501                	li	a0,0
    800092ca:	ffffc097          	auipc	ra,0xffffc
    800092ce:	8ca080e7          	jalr	-1846(ra) # 80004b94 <argaddr>
    800092d2:	87aa                	mv	a5,a0
    800092d4:	0007d463          	bgez	a5,800092dc <sys_pipe+0x2e>
    return -1;
    800092d8:	57fd                	li	a5,-1
    800092da:	a215                	j	800093fe <sys_pipe+0x150>
  if(pipealloc(&rf, &wf) < 0)
    800092dc:	fd040713          	addi	a4,s0,-48
    800092e0:	fd840793          	addi	a5,s0,-40
    800092e4:	85ba                	mv	a1,a4
    800092e6:	853e                	mv	a0,a5
    800092e8:	ffffe097          	auipc	ra,0xffffe
    800092ec:	64c080e7          	jalr	1612(ra) # 80007934 <pipealloc>
    800092f0:	87aa                	mv	a5,a0
    800092f2:	0007d463          	bgez	a5,800092fa <sys_pipe+0x4c>
    return -1;
    800092f6:	57fd                	li	a5,-1
    800092f8:	a219                	j	800093fe <sys_pipe+0x150>
  fd0 = -1;
    800092fa:	57fd                	li	a5,-1
    800092fc:	fcf42623          	sw	a5,-52(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80009300:	fd843783          	ld	a5,-40(s0)
    80009304:	853e                	mv	a0,a5
    80009306:	fffff097          	auipc	ra,0xfffff
    8000930a:	0ce080e7          	jalr	206(ra) # 800083d4 <fdalloc>
    8000930e:	87aa                	mv	a5,a0
    80009310:	fcf42623          	sw	a5,-52(s0)
    80009314:	fcc42783          	lw	a5,-52(s0)
    80009318:	0207c063          	bltz	a5,80009338 <sys_pipe+0x8a>
    8000931c:	fd043783          	ld	a5,-48(s0)
    80009320:	853e                	mv	a0,a5
    80009322:	fffff097          	auipc	ra,0xfffff
    80009326:	0b2080e7          	jalr	178(ra) # 800083d4 <fdalloc>
    8000932a:	87aa                	mv	a5,a0
    8000932c:	fcf42423          	sw	a5,-56(s0)
    80009330:	fc842783          	lw	a5,-56(s0)
    80009334:	0207df63          	bgez	a5,80009372 <sys_pipe+0xc4>
    if(fd0 >= 0)
    80009338:	fcc42783          	lw	a5,-52(s0)
    8000933c:	0007cb63          	bltz	a5,80009352 <sys_pipe+0xa4>
      p->ofile[fd0] = 0;
    80009340:	fcc42783          	lw	a5,-52(s0)
    80009344:	fe843703          	ld	a4,-24(s0)
    80009348:	07f1                	addi	a5,a5,28
    8000934a:	078e                	slli	a5,a5,0x3
    8000934c:	97ba                	add	a5,a5,a4
    8000934e:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80009352:	fd843783          	ld	a5,-40(s0)
    80009356:	853e                	mv	a0,a5
    80009358:	ffffe097          	auipc	ra,0xffffe
    8000935c:	0ba080e7          	jalr	186(ra) # 80007412 <fileclose>
    fileclose(wf);
    80009360:	fd043783          	ld	a5,-48(s0)
    80009364:	853e                	mv	a0,a5
    80009366:	ffffe097          	auipc	ra,0xffffe
    8000936a:	0ac080e7          	jalr	172(ra) # 80007412 <fileclose>
    return -1;
    8000936e:	57fd                	li	a5,-1
    80009370:	a079                	j	800093fe <sys_pipe+0x150>
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80009372:	fe843783          	ld	a5,-24(s0)
    80009376:	6bbc                	ld	a5,80(a5)
    80009378:	fe043703          	ld	a4,-32(s0)
    8000937c:	fcc40613          	addi	a2,s0,-52
    80009380:	4691                	li	a3,4
    80009382:	85ba                	mv	a1,a4
    80009384:	853e                	mv	a0,a5
    80009386:	ffff9097          	auipc	ra,0xffff9
    8000938a:	040080e7          	jalr	64(ra) # 800023c6 <copyout>
    8000938e:	87aa                	mv	a5,a0
    80009390:	0207c463          	bltz	a5,800093b8 <sys_pipe+0x10a>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80009394:	fe843783          	ld	a5,-24(s0)
    80009398:	6bb8                	ld	a4,80(a5)
    8000939a:	fe043783          	ld	a5,-32(s0)
    8000939e:	0791                	addi	a5,a5,4
    800093a0:	fc840613          	addi	a2,s0,-56
    800093a4:	4691                	li	a3,4
    800093a6:	85be                	mv	a1,a5
    800093a8:	853a                	mv	a0,a4
    800093aa:	ffff9097          	auipc	ra,0xffff9
    800093ae:	01c080e7          	jalr	28(ra) # 800023c6 <copyout>
    800093b2:	87aa                	mv	a5,a0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800093b4:	0407d463          	bgez	a5,800093fc <sys_pipe+0x14e>
    p->ofile[fd0] = 0;
    800093b8:	fcc42783          	lw	a5,-52(s0)
    800093bc:	fe843703          	ld	a4,-24(s0)
    800093c0:	07f1                	addi	a5,a5,28
    800093c2:	078e                	slli	a5,a5,0x3
    800093c4:	97ba                	add	a5,a5,a4
    800093c6:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    800093ca:	fc842783          	lw	a5,-56(s0)
    800093ce:	fe843703          	ld	a4,-24(s0)
    800093d2:	07f1                	addi	a5,a5,28
    800093d4:	078e                	slli	a5,a5,0x3
    800093d6:	97ba                	add	a5,a5,a4
    800093d8:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800093dc:	fd843783          	ld	a5,-40(s0)
    800093e0:	853e                	mv	a0,a5
    800093e2:	ffffe097          	auipc	ra,0xffffe
    800093e6:	030080e7          	jalr	48(ra) # 80007412 <fileclose>
    fileclose(wf);
    800093ea:	fd043783          	ld	a5,-48(s0)
    800093ee:	853e                	mv	a0,a5
    800093f0:	ffffe097          	auipc	ra,0xffffe
    800093f4:	022080e7          	jalr	34(ra) # 80007412 <fileclose>
    return -1;
    800093f8:	57fd                	li	a5,-1
    800093fa:	a011                	j	800093fe <sys_pipe+0x150>
  }
  return 0;
    800093fc:	4781                	li	a5,0
}
    800093fe:	853e                	mv	a0,a5
    80009400:	70e2                	ld	ra,56(sp)
    80009402:	7442                	ld	s0,48(sp)
    80009404:	6121                	addi	sp,sp,64
    80009406:	8082                	ret
	...

0000000080009410 <kernelvec>:
    80009410:	7111                	addi	sp,sp,-256
    80009412:	e006                	sd	ra,0(sp)
    80009414:	e40a                	sd	sp,8(sp)
    80009416:	e80e                	sd	gp,16(sp)
    80009418:	ec12                	sd	tp,24(sp)
    8000941a:	f016                	sd	t0,32(sp)
    8000941c:	f41a                	sd	t1,40(sp)
    8000941e:	f81e                	sd	t2,48(sp)
    80009420:	fc22                	sd	s0,56(sp)
    80009422:	e0a6                	sd	s1,64(sp)
    80009424:	e4aa                	sd	a0,72(sp)
    80009426:	e8ae                	sd	a1,80(sp)
    80009428:	ecb2                	sd	a2,88(sp)
    8000942a:	f0b6                	sd	a3,96(sp)
    8000942c:	f4ba                	sd	a4,104(sp)
    8000942e:	f8be                	sd	a5,112(sp)
    80009430:	fcc2                	sd	a6,120(sp)
    80009432:	e146                	sd	a7,128(sp)
    80009434:	e54a                	sd	s2,136(sp)
    80009436:	e94e                	sd	s3,144(sp)
    80009438:	ed52                	sd	s4,152(sp)
    8000943a:	f156                	sd	s5,160(sp)
    8000943c:	f55a                	sd	s6,168(sp)
    8000943e:	f95e                	sd	s7,176(sp)
    80009440:	fd62                	sd	s8,184(sp)
    80009442:	e1e6                	sd	s9,192(sp)
    80009444:	e5ea                	sd	s10,200(sp)
    80009446:	e9ee                	sd	s11,208(sp)
    80009448:	edf2                	sd	t3,216(sp)
    8000944a:	f1f6                	sd	t4,224(sp)
    8000944c:	f5fa                	sd	t5,232(sp)
    8000944e:	f9fe                	sd	t6,240(sp)
    80009450:	b26fb0ef          	jal	ra,80004776 <kerneltrap>
    80009454:	6082                	ld	ra,0(sp)
    80009456:	6122                	ld	sp,8(sp)
    80009458:	61c2                	ld	gp,16(sp)
    8000945a:	7282                	ld	t0,32(sp)
    8000945c:	7322                	ld	t1,40(sp)
    8000945e:	73c2                	ld	t2,48(sp)
    80009460:	7462                	ld	s0,56(sp)
    80009462:	6486                	ld	s1,64(sp)
    80009464:	6526                	ld	a0,72(sp)
    80009466:	65c6                	ld	a1,80(sp)
    80009468:	6666                	ld	a2,88(sp)
    8000946a:	7686                	ld	a3,96(sp)
    8000946c:	7726                	ld	a4,104(sp)
    8000946e:	77c6                	ld	a5,112(sp)
    80009470:	7866                	ld	a6,120(sp)
    80009472:	688a                	ld	a7,128(sp)
    80009474:	692a                	ld	s2,136(sp)
    80009476:	69ca                	ld	s3,144(sp)
    80009478:	6a6a                	ld	s4,152(sp)
    8000947a:	7a8a                	ld	s5,160(sp)
    8000947c:	7b2a                	ld	s6,168(sp)
    8000947e:	7bca                	ld	s7,176(sp)
    80009480:	7c6a                	ld	s8,184(sp)
    80009482:	6c8e                	ld	s9,192(sp)
    80009484:	6d2e                	ld	s10,200(sp)
    80009486:	6dce                	ld	s11,208(sp)
    80009488:	6e6e                	ld	t3,216(sp)
    8000948a:	7e8e                	ld	t4,224(sp)
    8000948c:	7f2e                	ld	t5,232(sp)
    8000948e:	7fce                	ld	t6,240(sp)
    80009490:	6111                	addi	sp,sp,256
    80009492:	10200073          	sret
    80009496:	00000013          	nop
    8000949a:	00000013          	nop
    8000949e:	0001                	nop

00000000800094a0 <timervec>:
    800094a0:	34051573          	csrrw	a0,mscratch,a0
    800094a4:	e10c                	sd	a1,0(a0)
    800094a6:	e510                	sd	a2,8(a0)
    800094a8:	e914                	sd	a3,16(a0)
    800094aa:	6d0c                	ld	a1,24(a0)
    800094ac:	7110                	ld	a2,32(a0)
    800094ae:	6194                	ld	a3,0(a1)
    800094b0:	96b2                	add	a3,a3,a2
    800094b2:	e194                	sd	a3,0(a1)
    800094b4:	4589                	li	a1,2
    800094b6:	14459073          	csrw	sip,a1
    800094ba:	6914                	ld	a3,16(a0)
    800094bc:	6510                	ld	a2,8(a0)
    800094be:	610c                	ld	a1,0(a0)
    800094c0:	34051573          	csrrw	a0,mscratch,a0
    800094c4:	30200073          	mret
	...

00000000800094ca <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    800094ca:	1141                	addi	sp,sp,-16
    800094cc:	e422                	sd	s0,8(sp)
    800094ce:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    800094d0:	0c0007b7          	lui	a5,0xc000
    800094d4:	02878793          	addi	a5,a5,40 # c000028 <_entry-0x73ffffd8>
    800094d8:	4705                	li	a4,1
    800094da:	c398                	sw	a4,0(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    800094dc:	0c0007b7          	lui	a5,0xc000
    800094e0:	0791                	addi	a5,a5,4
    800094e2:	4705                	li	a4,1
    800094e4:	c398                	sw	a4,0(a5)
}
    800094e6:	0001                	nop
    800094e8:	6422                	ld	s0,8(sp)
    800094ea:	0141                	addi	sp,sp,16
    800094ec:	8082                	ret

00000000800094ee <plicinithart>:

void
plicinithart(void)
{
    800094ee:	1101                	addi	sp,sp,-32
    800094f0:	ec06                	sd	ra,24(sp)
    800094f2:	e822                	sd	s0,16(sp)
    800094f4:	1000                	addi	s0,sp,32
  int hart = cpuid();
    800094f6:	ffff9097          	auipc	ra,0xffff9
    800094fa:	4c4080e7          	jalr	1220(ra) # 800029ba <cpuid>
    800094fe:	87aa                	mv	a5,a0
    80009500:	fef42623          	sw	a5,-20(s0)
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80009504:	fec42783          	lw	a5,-20(s0)
    80009508:	0087979b          	slliw	a5,a5,0x8
    8000950c:	2781                	sext.w	a5,a5
    8000950e:	873e                	mv	a4,a5
    80009510:	0c0027b7          	lui	a5,0xc002
    80009514:	08078793          	addi	a5,a5,128 # c002080 <_entry-0x73ffdf80>
    80009518:	97ba                	add	a5,a5,a4
    8000951a:	873e                	mv	a4,a5
    8000951c:	40200793          	li	a5,1026
    80009520:	c31c                	sw	a5,0(a4)

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80009522:	fec42783          	lw	a5,-20(s0)
    80009526:	00d7979b          	slliw	a5,a5,0xd
    8000952a:	2781                	sext.w	a5,a5
    8000952c:	873e                	mv	a4,a5
    8000952e:	0c2017b7          	lui	a5,0xc201
    80009532:	97ba                	add	a5,a5,a4
    80009534:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80009538:	0001                	nop
    8000953a:	60e2                	ld	ra,24(sp)
    8000953c:	6442                	ld	s0,16(sp)
    8000953e:	6105                	addi	sp,sp,32
    80009540:	8082                	ret

0000000080009542 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80009542:	1101                	addi	sp,sp,-32
    80009544:	ec06                	sd	ra,24(sp)
    80009546:	e822                	sd	s0,16(sp)
    80009548:	1000                	addi	s0,sp,32
  int hart = cpuid();
    8000954a:	ffff9097          	auipc	ra,0xffff9
    8000954e:	470080e7          	jalr	1136(ra) # 800029ba <cpuid>
    80009552:	87aa                	mv	a5,a0
    80009554:	fef42623          	sw	a5,-20(s0)
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80009558:	fec42783          	lw	a5,-20(s0)
    8000955c:	00d7979b          	slliw	a5,a5,0xd
    80009560:	2781                	sext.w	a5,a5
    80009562:	873e                	mv	a4,a5
    80009564:	0c2017b7          	lui	a5,0xc201
    80009568:	0791                	addi	a5,a5,4
    8000956a:	97ba                	add	a5,a5,a4
    8000956c:	439c                	lw	a5,0(a5)
    8000956e:	fef42423          	sw	a5,-24(s0)
  return irq;
    80009572:	fe842783          	lw	a5,-24(s0)
}
    80009576:	853e                	mv	a0,a5
    80009578:	60e2                	ld	ra,24(sp)
    8000957a:	6442                	ld	s0,16(sp)
    8000957c:	6105                	addi	sp,sp,32
    8000957e:	8082                	ret

0000000080009580 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80009580:	7179                	addi	sp,sp,-48
    80009582:	f406                	sd	ra,40(sp)
    80009584:	f022                	sd	s0,32(sp)
    80009586:	1800                	addi	s0,sp,48
    80009588:	87aa                	mv	a5,a0
    8000958a:	fcf42e23          	sw	a5,-36(s0)
  int hart = cpuid();
    8000958e:	ffff9097          	auipc	ra,0xffff9
    80009592:	42c080e7          	jalr	1068(ra) # 800029ba <cpuid>
    80009596:	87aa                	mv	a5,a0
    80009598:	fef42623          	sw	a5,-20(s0)
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    8000959c:	fec42783          	lw	a5,-20(s0)
    800095a0:	00d7979b          	slliw	a5,a5,0xd
    800095a4:	2781                	sext.w	a5,a5
    800095a6:	873e                	mv	a4,a5
    800095a8:	0c2017b7          	lui	a5,0xc201
    800095ac:	0791                	addi	a5,a5,4
    800095ae:	97ba                	add	a5,a5,a4
    800095b0:	873e                	mv	a4,a5
    800095b2:	fdc42783          	lw	a5,-36(s0)
    800095b6:	c31c                	sw	a5,0(a4)
}
    800095b8:	0001                	nop
    800095ba:	70a2                	ld	ra,40(sp)
    800095bc:	7402                	ld	s0,32(sp)
    800095be:	6145                	addi	sp,sp,48
    800095c0:	8082                	ret

00000000800095c2 <virtio_disk_init>:
  
} __attribute__ ((aligned (PGSIZE))) disk;

void
virtio_disk_init(void)
{
    800095c2:	7179                	addi	sp,sp,-48
    800095c4:	f406                	sd	ra,40(sp)
    800095c6:	f022                	sd	s0,32(sp)
    800095c8:	1800                	addi	s0,sp,48
  uint32 status = 0;
    800095ca:	fe042423          	sw	zero,-24(s0)

  initlock(&disk.vdisk_lock, "virtio_disk");
    800095ce:	00002597          	auipc	a1,0x2
    800095d2:	25258593          	addi	a1,a1,594 # 8000b820 <etext+0x820>
    800095d6:	0049f517          	auipc	a0,0x49f
    800095da:	b5250513          	addi	a0,a0,-1198 # 804a8128 <disk+0x2128>
    800095de:	ffff8097          	auipc	ra,0xffff8
    800095e2:	c5c080e7          	jalr	-932(ra) # 8000123a <initlock>

  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800095e6:	100017b7          	lui	a5,0x10001
    800095ea:	439c                	lw	a5,0(a5)
    800095ec:	2781                	sext.w	a5,a5
    800095ee:	873e                	mv	a4,a5
    800095f0:	747277b7          	lui	a5,0x74727
    800095f4:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800095f8:	04f71063          	bne	a4,a5,80009638 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    800095fc:	100017b7          	lui	a5,0x10001
    80009600:	0791                	addi	a5,a5,4
    80009602:	439c                	lw	a5,0(a5)
    80009604:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80009606:	873e                	mv	a4,a5
    80009608:	4785                	li	a5,1
    8000960a:	02f71763          	bne	a4,a5,80009638 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000960e:	100017b7          	lui	a5,0x10001
    80009612:	07a1                	addi	a5,a5,8
    80009614:	439c                	lw	a5,0(a5)
    80009616:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80009618:	873e                	mv	a4,a5
    8000961a:	4789                	li	a5,2
    8000961c:	00f71e63          	bne	a4,a5,80009638 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80009620:	100017b7          	lui	a5,0x10001
    80009624:	07b1                	addi	a5,a5,12
    80009626:	439c                	lw	a5,0(a5)
    80009628:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000962a:	873e                	mv	a4,a5
    8000962c:	554d47b7          	lui	a5,0x554d4
    80009630:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80009634:	00f70a63          	beq	a4,a5,80009648 <virtio_disk_init+0x86>
    panic("could not find virtio disk");
    80009638:	00002517          	auipc	a0,0x2
    8000963c:	1f850513          	addi	a0,a0,504 # 8000b830 <etext+0x830>
    80009640:	ffff7097          	auipc	ra,0xffff7
    80009644:	63a080e7          	jalr	1594(ra) # 80000c7a <panic>
  }
  
  status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    80009648:	fe842783          	lw	a5,-24(s0)
    8000964c:	0017e793          	ori	a5,a5,1
    80009650:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80009654:	100017b7          	lui	a5,0x10001
    80009658:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    8000965c:	fe842703          	lw	a4,-24(s0)
    80009660:	c398                	sw	a4,0(a5)

  status |= VIRTIO_CONFIG_S_DRIVER;
    80009662:	fe842783          	lw	a5,-24(s0)
    80009666:	0027e793          	ori	a5,a5,2
    8000966a:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000966e:	100017b7          	lui	a5,0x10001
    80009672:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80009676:	fe842703          	lw	a4,-24(s0)
    8000967a:	c398                	sw	a4,0(a5)

  // negotiate features
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    8000967c:	100017b7          	lui	a5,0x10001
    80009680:	07c1                	addi	a5,a5,16
    80009682:	439c                	lw	a5,0(a5)
    80009684:	2781                	sext.w	a5,a5
    80009686:	1782                	slli	a5,a5,0x20
    80009688:	9381                	srli	a5,a5,0x20
    8000968a:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_RO);
    8000968e:	fe043783          	ld	a5,-32(s0)
    80009692:	fdf7f793          	andi	a5,a5,-33
    80009696:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_SCSI);
    8000969a:	fe043783          	ld	a5,-32(s0)
    8000969e:	f7f7f793          	andi	a5,a5,-129
    800096a2:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    800096a6:	fe043703          	ld	a4,-32(s0)
    800096aa:	77fd                	lui	a5,0xfffff
    800096ac:	7ff78793          	addi	a5,a5,2047 # fffffffffffff7ff <end+0xffffffff7fb567ff>
    800096b0:	8ff9                	and	a5,a5,a4
    800096b2:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_MQ);
    800096b6:	fe043703          	ld	a4,-32(s0)
    800096ba:	77fd                	lui	a5,0xfffff
    800096bc:	17fd                	addi	a5,a5,-1
    800096be:	8ff9                	and	a5,a5,a4
    800096c0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    800096c4:	fe043703          	ld	a4,-32(s0)
    800096c8:	f80007b7          	lui	a5,0xf8000
    800096cc:	17fd                	addi	a5,a5,-1
    800096ce:	8ff9                	and	a5,a5,a4
    800096d0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    800096d4:	fe043703          	ld	a4,-32(s0)
    800096d8:	e00007b7          	lui	a5,0xe0000
    800096dc:	17fd                	addi	a5,a5,-1
    800096de:	8ff9                	and	a5,a5,a4
    800096e0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    800096e4:	fe043703          	ld	a4,-32(s0)
    800096e8:	f00007b7          	lui	a5,0xf0000
    800096ec:	17fd                	addi	a5,a5,-1
    800096ee:	8ff9                	and	a5,a5,a4
    800096f0:	fef43023          	sd	a5,-32(s0)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800096f4:	100017b7          	lui	a5,0x10001
    800096f8:	02078793          	addi	a5,a5,32 # 10001020 <_entry-0x6fffefe0>
    800096fc:	fe043703          	ld	a4,-32(s0)
    80009700:	2701                	sext.w	a4,a4
    80009702:	c398                	sw	a4,0(a5)

  // tell device that feature negotiation is complete.
  status |= VIRTIO_CONFIG_S_FEATURES_OK;
    80009704:	fe842783          	lw	a5,-24(s0)
    80009708:	0087e793          	ori	a5,a5,8
    8000970c:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80009710:	100017b7          	lui	a5,0x10001
    80009714:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80009718:	fe842703          	lw	a4,-24(s0)
    8000971c:	c398                	sw	a4,0(a5)

  // tell device we're completely ready.
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    8000971e:	fe842783          	lw	a5,-24(s0)
    80009722:	0047e793          	ori	a5,a5,4
    80009726:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000972a:	100017b7          	lui	a5,0x10001
    8000972e:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80009732:	fe842703          	lw	a4,-24(s0)
    80009736:	c398                	sw	a4,0(a5)

  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    80009738:	100017b7          	lui	a5,0x10001
    8000973c:	02878793          	addi	a5,a5,40 # 10001028 <_entry-0x6fffefd8>
    80009740:	6705                	lui	a4,0x1
    80009742:	c398                	sw	a4,0(a5)

  // initialize queue 0.
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80009744:	100017b7          	lui	a5,0x10001
    80009748:	03078793          	addi	a5,a5,48 # 10001030 <_entry-0x6fffefd0>
    8000974c:	0007a023          	sw	zero,0(a5)
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80009750:	100017b7          	lui	a5,0x10001
    80009754:	03478793          	addi	a5,a5,52 # 10001034 <_entry-0x6fffefcc>
    80009758:	439c                	lw	a5,0(a5)
    8000975a:	fcf42e23          	sw	a5,-36(s0)
  if(max == 0)
    8000975e:	fdc42783          	lw	a5,-36(s0)
    80009762:	2781                	sext.w	a5,a5
    80009764:	eb89                	bnez	a5,80009776 <virtio_disk_init+0x1b4>
    panic("virtio disk has no queue 0");
    80009766:	00002517          	auipc	a0,0x2
    8000976a:	0ea50513          	addi	a0,a0,234 # 8000b850 <etext+0x850>
    8000976e:	ffff7097          	auipc	ra,0xffff7
    80009772:	50c080e7          	jalr	1292(ra) # 80000c7a <panic>
  if(max < NUM)
    80009776:	fdc42783          	lw	a5,-36(s0)
    8000977a:	0007871b          	sext.w	a4,a5
    8000977e:	479d                	li	a5,7
    80009780:	00e7ea63          	bltu	a5,a4,80009794 <virtio_disk_init+0x1d2>
    panic("virtio disk max queue too short");
    80009784:	00002517          	auipc	a0,0x2
    80009788:	0ec50513          	addi	a0,a0,236 # 8000b870 <etext+0x870>
    8000978c:	ffff7097          	auipc	ra,0xffff7
    80009790:	4ee080e7          	jalr	1262(ra) # 80000c7a <panic>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80009794:	100017b7          	lui	a5,0x10001
    80009798:	03878793          	addi	a5,a5,56 # 10001038 <_entry-0x6fffefc8>
    8000979c:	4721                	li	a4,8
    8000979e:	c398                	sw	a4,0(a5)
  memset(disk.pages, 0, sizeof(disk.pages));
    800097a0:	6609                	lui	a2,0x2
    800097a2:	4581                	li	a1,0
    800097a4:	0049d517          	auipc	a0,0x49d
    800097a8:	85c50513          	addi	a0,a0,-1956 # 804a6000 <disk>
    800097ac:	ffff8097          	auipc	ra,0xffff8
    800097b0:	c92080e7          	jalr	-878(ra) # 8000143e <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    800097b4:	0049d797          	auipc	a5,0x49d
    800097b8:	84c78793          	addi	a5,a5,-1972 # 804a6000 <disk>
    800097bc:	00c7d713          	srli	a4,a5,0xc
    800097c0:	100017b7          	lui	a5,0x10001
    800097c4:	04078793          	addi	a5,a5,64 # 10001040 <_entry-0x6fffefc0>
    800097c8:	2701                	sext.w	a4,a4
    800097ca:	c398                	sw	a4,0(a5)

  // desc = pages -- num * virtq_desc
  // avail = pages + 0x40 -- 2 * uint16, then num * uint16
  // used = pages + 4096 -- 2 * uint16, then num * vRingUsedElem

  disk.desc = (struct virtq_desc *) disk.pages;
    800097cc:	0049d717          	auipc	a4,0x49d
    800097d0:	83470713          	addi	a4,a4,-1996 # 804a6000 <disk>
    800097d4:	6789                	lui	a5,0x2
    800097d6:	97ba                	add	a5,a5,a4
    800097d8:	0049d717          	auipc	a4,0x49d
    800097dc:	82870713          	addi	a4,a4,-2008 # 804a6000 <disk>
    800097e0:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    800097e2:	0049d717          	auipc	a4,0x49d
    800097e6:	89e70713          	addi	a4,a4,-1890 # 804a6080 <disk+0x80>
    800097ea:	0049d697          	auipc	a3,0x49d
    800097ee:	81668693          	addi	a3,a3,-2026 # 804a6000 <disk>
    800097f2:	6789                	lui	a5,0x2
    800097f4:	97b6                	add	a5,a5,a3
    800097f6:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    800097f8:	0049e717          	auipc	a4,0x49e
    800097fc:	80870713          	addi	a4,a4,-2040 # 804a7000 <disk+0x1000>
    80009800:	0049d697          	auipc	a3,0x49d
    80009804:	80068693          	addi	a3,a3,-2048 # 804a6000 <disk>
    80009808:	6789                	lui	a5,0x2
    8000980a:	97b6                	add	a5,a5,a3
    8000980c:	eb98                	sd	a4,16(a5)

  // all NUM descriptors start out unused.
  for(int i = 0; i < NUM; i++)
    8000980e:	fe042623          	sw	zero,-20(s0)
    80009812:	a015                	j	80009836 <virtio_disk_init+0x274>
    disk.free[i] = 1;
    80009814:	0049c717          	auipc	a4,0x49c
    80009818:	7ec70713          	addi	a4,a4,2028 # 804a6000 <disk>
    8000981c:	fec42783          	lw	a5,-20(s0)
    80009820:	97ba                	add	a5,a5,a4
    80009822:	6709                	lui	a4,0x2
    80009824:	97ba                	add	a5,a5,a4
    80009826:	4705                	li	a4,1
    80009828:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  for(int i = 0; i < NUM; i++)
    8000982c:	fec42783          	lw	a5,-20(s0)
    80009830:	2785                	addiw	a5,a5,1
    80009832:	fef42623          	sw	a5,-20(s0)
    80009836:	fec42783          	lw	a5,-20(s0)
    8000983a:	0007871b          	sext.w	a4,a5
    8000983e:	479d                	li	a5,7
    80009840:	fce7dae3          	bge	a5,a4,80009814 <virtio_disk_init+0x252>

  // plic.c and trap.c arrange for interrupts from VIRTIO0_IRQ.
}
    80009844:	0001                	nop
    80009846:	0001                	nop
    80009848:	70a2                	ld	ra,40(sp)
    8000984a:	7402                	ld	s0,32(sp)
    8000984c:	6145                	addi	sp,sp,48
    8000984e:	8082                	ret

0000000080009850 <alloc_desc>:

// find a free descriptor, mark it non-free, return its index.
static int
alloc_desc()
{
    80009850:	1101                	addi	sp,sp,-32
    80009852:	ec22                	sd	s0,24(sp)
    80009854:	1000                	addi	s0,sp,32
  for(int i = 0; i < NUM; i++){
    80009856:	fe042623          	sw	zero,-20(s0)
    8000985a:	a081                	j	8000989a <alloc_desc+0x4a>
    if(disk.free[i]){
    8000985c:	0049c717          	auipc	a4,0x49c
    80009860:	7a470713          	addi	a4,a4,1956 # 804a6000 <disk>
    80009864:	fec42783          	lw	a5,-20(s0)
    80009868:	97ba                	add	a5,a5,a4
    8000986a:	6709                	lui	a4,0x2
    8000986c:	97ba                	add	a5,a5,a4
    8000986e:	0187c783          	lbu	a5,24(a5)
    80009872:	cf99                	beqz	a5,80009890 <alloc_desc+0x40>
      disk.free[i] = 0;
    80009874:	0049c717          	auipc	a4,0x49c
    80009878:	78c70713          	addi	a4,a4,1932 # 804a6000 <disk>
    8000987c:	fec42783          	lw	a5,-20(s0)
    80009880:	97ba                	add	a5,a5,a4
    80009882:	6709                	lui	a4,0x2
    80009884:	97ba                	add	a5,a5,a4
    80009886:	00078c23          	sb	zero,24(a5)
      return i;
    8000988a:	fec42783          	lw	a5,-20(s0)
    8000988e:	a831                	j	800098aa <alloc_desc+0x5a>
  for(int i = 0; i < NUM; i++){
    80009890:	fec42783          	lw	a5,-20(s0)
    80009894:	2785                	addiw	a5,a5,1
    80009896:	fef42623          	sw	a5,-20(s0)
    8000989a:	fec42783          	lw	a5,-20(s0)
    8000989e:	0007871b          	sext.w	a4,a5
    800098a2:	479d                	li	a5,7
    800098a4:	fae7dce3          	bge	a5,a4,8000985c <alloc_desc+0xc>
    }
  }
  return -1;
    800098a8:	57fd                	li	a5,-1
}
    800098aa:	853e                	mv	a0,a5
    800098ac:	6462                	ld	s0,24(sp)
    800098ae:	6105                	addi	sp,sp,32
    800098b0:	8082                	ret

00000000800098b2 <free_desc>:

// mark a descriptor as free.
static void
free_desc(int i)
{
    800098b2:	1101                	addi	sp,sp,-32
    800098b4:	ec06                	sd	ra,24(sp)
    800098b6:	e822                	sd	s0,16(sp)
    800098b8:	1000                	addi	s0,sp,32
    800098ba:	87aa                	mv	a5,a0
    800098bc:	fef42623          	sw	a5,-20(s0)
  if(i >= NUM)
    800098c0:	fec42783          	lw	a5,-20(s0)
    800098c4:	0007871b          	sext.w	a4,a5
    800098c8:	479d                	li	a5,7
    800098ca:	00e7da63          	bge	a5,a4,800098de <free_desc+0x2c>
    panic("free_desc 1");
    800098ce:	00002517          	auipc	a0,0x2
    800098d2:	fc250513          	addi	a0,a0,-62 # 8000b890 <etext+0x890>
    800098d6:	ffff7097          	auipc	ra,0xffff7
    800098da:	3a4080e7          	jalr	932(ra) # 80000c7a <panic>
  if(disk.free[i])
    800098de:	0049c717          	auipc	a4,0x49c
    800098e2:	72270713          	addi	a4,a4,1826 # 804a6000 <disk>
    800098e6:	fec42783          	lw	a5,-20(s0)
    800098ea:	97ba                	add	a5,a5,a4
    800098ec:	6709                	lui	a4,0x2
    800098ee:	97ba                	add	a5,a5,a4
    800098f0:	0187c783          	lbu	a5,24(a5)
    800098f4:	cb89                	beqz	a5,80009906 <free_desc+0x54>
    panic("free_desc 2");
    800098f6:	00002517          	auipc	a0,0x2
    800098fa:	faa50513          	addi	a0,a0,-86 # 8000b8a0 <etext+0x8a0>
    800098fe:	ffff7097          	auipc	ra,0xffff7
    80009902:	37c080e7          	jalr	892(ra) # 80000c7a <panic>
  disk.desc[i].addr = 0;
    80009906:	0049c717          	auipc	a4,0x49c
    8000990a:	6fa70713          	addi	a4,a4,1786 # 804a6000 <disk>
    8000990e:	6789                	lui	a5,0x2
    80009910:	97ba                	add	a5,a5,a4
    80009912:	6398                	ld	a4,0(a5)
    80009914:	fec42783          	lw	a5,-20(s0)
    80009918:	0792                	slli	a5,a5,0x4
    8000991a:	97ba                	add	a5,a5,a4
    8000991c:	0007b023          	sd	zero,0(a5) # 2000 <_entry-0x7fffe000>
  disk.desc[i].len = 0;
    80009920:	0049c717          	auipc	a4,0x49c
    80009924:	6e070713          	addi	a4,a4,1760 # 804a6000 <disk>
    80009928:	6789                	lui	a5,0x2
    8000992a:	97ba                	add	a5,a5,a4
    8000992c:	6398                	ld	a4,0(a5)
    8000992e:	fec42783          	lw	a5,-20(s0)
    80009932:	0792                	slli	a5,a5,0x4
    80009934:	97ba                	add	a5,a5,a4
    80009936:	0007a423          	sw	zero,8(a5) # 2008 <_entry-0x7fffdff8>
  disk.desc[i].flags = 0;
    8000993a:	0049c717          	auipc	a4,0x49c
    8000993e:	6c670713          	addi	a4,a4,1734 # 804a6000 <disk>
    80009942:	6789                	lui	a5,0x2
    80009944:	97ba                	add	a5,a5,a4
    80009946:	6398                	ld	a4,0(a5)
    80009948:	fec42783          	lw	a5,-20(s0)
    8000994c:	0792                	slli	a5,a5,0x4
    8000994e:	97ba                	add	a5,a5,a4
    80009950:	00079623          	sh	zero,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[i].next = 0;
    80009954:	0049c717          	auipc	a4,0x49c
    80009958:	6ac70713          	addi	a4,a4,1708 # 804a6000 <disk>
    8000995c:	6789                	lui	a5,0x2
    8000995e:	97ba                	add	a5,a5,a4
    80009960:	6398                	ld	a4,0(a5)
    80009962:	fec42783          	lw	a5,-20(s0)
    80009966:	0792                	slli	a5,a5,0x4
    80009968:	97ba                	add	a5,a5,a4
    8000996a:	00079723          	sh	zero,14(a5) # 200e <_entry-0x7fffdff2>
  disk.free[i] = 1;
    8000996e:	0049c717          	auipc	a4,0x49c
    80009972:	69270713          	addi	a4,a4,1682 # 804a6000 <disk>
    80009976:	fec42783          	lw	a5,-20(s0)
    8000997a:	97ba                	add	a5,a5,a4
    8000997c:	6709                	lui	a4,0x2
    8000997e:	97ba                	add	a5,a5,a4
    80009980:	4705                	li	a4,1
    80009982:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    80009986:	0049e517          	auipc	a0,0x49e
    8000998a:	69250513          	addi	a0,a0,1682 # 804a8018 <disk+0x2018>
    8000998e:	ffffa097          	auipc	ra,0xffffa
    80009992:	010080e7          	jalr	16(ra) # 8000399e <wakeup>
}
    80009996:	0001                	nop
    80009998:	60e2                	ld	ra,24(sp)
    8000999a:	6442                	ld	s0,16(sp)
    8000999c:	6105                	addi	sp,sp,32
    8000999e:	8082                	ret

00000000800099a0 <free_chain>:

// free a chain of descriptors.
static void
free_chain(int i)
{
    800099a0:	7179                	addi	sp,sp,-48
    800099a2:	f406                	sd	ra,40(sp)
    800099a4:	f022                	sd	s0,32(sp)
    800099a6:	1800                	addi	s0,sp,48
    800099a8:	87aa                	mv	a5,a0
    800099aa:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    int flag = disk.desc[i].flags;
    800099ae:	0049c717          	auipc	a4,0x49c
    800099b2:	65270713          	addi	a4,a4,1618 # 804a6000 <disk>
    800099b6:	6789                	lui	a5,0x2
    800099b8:	97ba                	add	a5,a5,a4
    800099ba:	6398                	ld	a4,0(a5)
    800099bc:	fdc42783          	lw	a5,-36(s0)
    800099c0:	0792                	slli	a5,a5,0x4
    800099c2:	97ba                	add	a5,a5,a4
    800099c4:	00c7d783          	lhu	a5,12(a5) # 200c <_entry-0x7fffdff4>
    800099c8:	fef42623          	sw	a5,-20(s0)
    int nxt = disk.desc[i].next;
    800099cc:	0049c717          	auipc	a4,0x49c
    800099d0:	63470713          	addi	a4,a4,1588 # 804a6000 <disk>
    800099d4:	6789                	lui	a5,0x2
    800099d6:	97ba                	add	a5,a5,a4
    800099d8:	6398                	ld	a4,0(a5)
    800099da:	fdc42783          	lw	a5,-36(s0)
    800099de:	0792                	slli	a5,a5,0x4
    800099e0:	97ba                	add	a5,a5,a4
    800099e2:	00e7d783          	lhu	a5,14(a5) # 200e <_entry-0x7fffdff2>
    800099e6:	fef42423          	sw	a5,-24(s0)
    free_desc(i);
    800099ea:	fdc42783          	lw	a5,-36(s0)
    800099ee:	853e                	mv	a0,a5
    800099f0:	00000097          	auipc	ra,0x0
    800099f4:	ec2080e7          	jalr	-318(ra) # 800098b2 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800099f8:	fec42783          	lw	a5,-20(s0)
    800099fc:	8b85                	andi	a5,a5,1
    800099fe:	2781                	sext.w	a5,a5
    80009a00:	c791                	beqz	a5,80009a0c <free_chain+0x6c>
      i = nxt;
    80009a02:	fe842783          	lw	a5,-24(s0)
    80009a06:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    80009a0a:	b755                	j	800099ae <free_chain+0xe>
    else
      break;
    80009a0c:	0001                	nop
  }
}
    80009a0e:	0001                	nop
    80009a10:	70a2                	ld	ra,40(sp)
    80009a12:	7402                	ld	s0,32(sp)
    80009a14:	6145                	addi	sp,sp,48
    80009a16:	8082                	ret

0000000080009a18 <alloc3_desc>:

// allocate three descriptors (they need not be contiguous).
// disk transfers always use three descriptors.
static int
alloc3_desc(int *idx)
{
    80009a18:	7139                	addi	sp,sp,-64
    80009a1a:	fc06                	sd	ra,56(sp)
    80009a1c:	f822                	sd	s0,48(sp)
    80009a1e:	f426                	sd	s1,40(sp)
    80009a20:	0080                	addi	s0,sp,64
    80009a22:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 3; i++){
    80009a26:	fc042e23          	sw	zero,-36(s0)
    80009a2a:	a89d                	j	80009aa0 <alloc3_desc+0x88>
    idx[i] = alloc_desc();
    80009a2c:	fdc42783          	lw	a5,-36(s0)
    80009a30:	078a                	slli	a5,a5,0x2
    80009a32:	fc843703          	ld	a4,-56(s0)
    80009a36:	00f704b3          	add	s1,a4,a5
    80009a3a:	00000097          	auipc	ra,0x0
    80009a3e:	e16080e7          	jalr	-490(ra) # 80009850 <alloc_desc>
    80009a42:	87aa                	mv	a5,a0
    80009a44:	c09c                	sw	a5,0(s1)
    if(idx[i] < 0){
    80009a46:	fdc42783          	lw	a5,-36(s0)
    80009a4a:	078a                	slli	a5,a5,0x2
    80009a4c:	fc843703          	ld	a4,-56(s0)
    80009a50:	97ba                	add	a5,a5,a4
    80009a52:	439c                	lw	a5,0(a5)
    80009a54:	0407d163          	bgez	a5,80009a96 <alloc3_desc+0x7e>
      for(int j = 0; j < i; j++)
    80009a58:	fc042c23          	sw	zero,-40(s0)
    80009a5c:	a015                	j	80009a80 <alloc3_desc+0x68>
        free_desc(idx[j]);
    80009a5e:	fd842783          	lw	a5,-40(s0)
    80009a62:	078a                	slli	a5,a5,0x2
    80009a64:	fc843703          	ld	a4,-56(s0)
    80009a68:	97ba                	add	a5,a5,a4
    80009a6a:	439c                	lw	a5,0(a5)
    80009a6c:	853e                	mv	a0,a5
    80009a6e:	00000097          	auipc	ra,0x0
    80009a72:	e44080e7          	jalr	-444(ra) # 800098b2 <free_desc>
      for(int j = 0; j < i; j++)
    80009a76:	fd842783          	lw	a5,-40(s0)
    80009a7a:	2785                	addiw	a5,a5,1
    80009a7c:	fcf42c23          	sw	a5,-40(s0)
    80009a80:	fd842783          	lw	a5,-40(s0)
    80009a84:	873e                	mv	a4,a5
    80009a86:	fdc42783          	lw	a5,-36(s0)
    80009a8a:	2701                	sext.w	a4,a4
    80009a8c:	2781                	sext.w	a5,a5
    80009a8e:	fcf748e3          	blt	a4,a5,80009a5e <alloc3_desc+0x46>
      return -1;
    80009a92:	57fd                	li	a5,-1
    80009a94:	a831                	j	80009ab0 <alloc3_desc+0x98>
  for(int i = 0; i < 3; i++){
    80009a96:	fdc42783          	lw	a5,-36(s0)
    80009a9a:	2785                	addiw	a5,a5,1
    80009a9c:	fcf42e23          	sw	a5,-36(s0)
    80009aa0:	fdc42783          	lw	a5,-36(s0)
    80009aa4:	0007871b          	sext.w	a4,a5
    80009aa8:	4789                	li	a5,2
    80009aaa:	f8e7d1e3          	bge	a5,a4,80009a2c <alloc3_desc+0x14>
    }
  }
  return 0;
    80009aae:	4781                	li	a5,0
}
    80009ab0:	853e                	mv	a0,a5
    80009ab2:	70e2                	ld	ra,56(sp)
    80009ab4:	7442                	ld	s0,48(sp)
    80009ab6:	74a2                	ld	s1,40(sp)
    80009ab8:	6121                	addi	sp,sp,64
    80009aba:	8082                	ret

0000000080009abc <virtio_disk_rw>:

void
virtio_disk_rw(struct buf *b, int write)
{
    80009abc:	7139                	addi	sp,sp,-64
    80009abe:	fc06                	sd	ra,56(sp)
    80009ac0:	f822                	sd	s0,48(sp)
    80009ac2:	0080                	addi	s0,sp,64
    80009ac4:	fca43423          	sd	a0,-56(s0)
    80009ac8:	87ae                	mv	a5,a1
    80009aca:	fcf42223          	sw	a5,-60(s0)
  uint64 sector = b->blockno * (BSIZE / 512);
    80009ace:	fc843783          	ld	a5,-56(s0)
    80009ad2:	47dc                	lw	a5,12(a5)
    80009ad4:	0017979b          	slliw	a5,a5,0x1
    80009ad8:	2781                	sext.w	a5,a5
    80009ada:	1782                	slli	a5,a5,0x20
    80009adc:	9381                	srli	a5,a5,0x20
    80009ade:	fef43423          	sd	a5,-24(s0)

  acquire(&disk.vdisk_lock);
    80009ae2:	0049e517          	auipc	a0,0x49e
    80009ae6:	64650513          	addi	a0,a0,1606 # 804a8128 <disk+0x2128>
    80009aea:	ffff7097          	auipc	ra,0xffff7
    80009aee:	780080e7          	jalr	1920(ra) # 8000126a <acquire>
  // data, one for a 1-byte status result.

  // allocate the three descriptors.
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
    80009af2:	fd040793          	addi	a5,s0,-48
    80009af6:	853e                	mv	a0,a5
    80009af8:	00000097          	auipc	ra,0x0
    80009afc:	f20080e7          	jalr	-224(ra) # 80009a18 <alloc3_desc>
    80009b00:	87aa                	mv	a5,a0
    80009b02:	cf91                	beqz	a5,80009b1e <virtio_disk_rw+0x62>
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80009b04:	0049e597          	auipc	a1,0x49e
    80009b08:	62458593          	addi	a1,a1,1572 # 804a8128 <disk+0x2128>
    80009b0c:	0049e517          	auipc	a0,0x49e
    80009b10:	50c50513          	addi	a0,a0,1292 # 804a8018 <disk+0x2018>
    80009b14:	ffffa097          	auipc	ra,0xffffa
    80009b18:	e0e080e7          	jalr	-498(ra) # 80003922 <sleep>
    if(alloc3_desc(idx) == 0) {
    80009b1c:	bfd9                	j	80009af2 <virtio_disk_rw+0x36>
      break;
    80009b1e:	0001                	nop
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80009b20:	fd042783          	lw	a5,-48(s0)
    80009b24:	20078793          	addi	a5,a5,512
    80009b28:	00479713          	slli	a4,a5,0x4
    80009b2c:	0049c797          	auipc	a5,0x49c
    80009b30:	4d478793          	addi	a5,a5,1236 # 804a6000 <disk>
    80009b34:	97ba                	add	a5,a5,a4
    80009b36:	0a878793          	addi	a5,a5,168
    80009b3a:	fef43023          	sd	a5,-32(s0)

  if(write)
    80009b3e:	fc442783          	lw	a5,-60(s0)
    80009b42:	2781                	sext.w	a5,a5
    80009b44:	c791                	beqz	a5,80009b50 <virtio_disk_rw+0x94>
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80009b46:	fe043783          	ld	a5,-32(s0)
    80009b4a:	4705                	li	a4,1
    80009b4c:	c398                	sw	a4,0(a5)
    80009b4e:	a029                	j	80009b58 <virtio_disk_rw+0x9c>
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    80009b50:	fe043783          	ld	a5,-32(s0)
    80009b54:	0007a023          	sw	zero,0(a5)
  buf0->reserved = 0;
    80009b58:	fe043783          	ld	a5,-32(s0)
    80009b5c:	0007a223          	sw	zero,4(a5)
  buf0->sector = sector;
    80009b60:	fe043783          	ld	a5,-32(s0)
    80009b64:	fe843703          	ld	a4,-24(s0)
    80009b68:	e798                	sd	a4,8(a5)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80009b6a:	0049c717          	auipc	a4,0x49c
    80009b6e:	49670713          	addi	a4,a4,1174 # 804a6000 <disk>
    80009b72:	6789                	lui	a5,0x2
    80009b74:	97ba                	add	a5,a5,a4
    80009b76:	6398                	ld	a4,0(a5)
    80009b78:	fd042783          	lw	a5,-48(s0)
    80009b7c:	0792                	slli	a5,a5,0x4
    80009b7e:	97ba                	add	a5,a5,a4
    80009b80:	fe043703          	ld	a4,-32(s0)
    80009b84:	e398                	sd	a4,0(a5)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80009b86:	0049c717          	auipc	a4,0x49c
    80009b8a:	47a70713          	addi	a4,a4,1146 # 804a6000 <disk>
    80009b8e:	6789                	lui	a5,0x2
    80009b90:	97ba                	add	a5,a5,a4
    80009b92:	6398                	ld	a4,0(a5)
    80009b94:	fd042783          	lw	a5,-48(s0)
    80009b98:	0792                	slli	a5,a5,0x4
    80009b9a:	97ba                	add	a5,a5,a4
    80009b9c:	4741                	li	a4,16
    80009b9e:	c798                	sw	a4,8(a5)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80009ba0:	0049c717          	auipc	a4,0x49c
    80009ba4:	46070713          	addi	a4,a4,1120 # 804a6000 <disk>
    80009ba8:	6789                	lui	a5,0x2
    80009baa:	97ba                	add	a5,a5,a4
    80009bac:	6398                	ld	a4,0(a5)
    80009bae:	fd042783          	lw	a5,-48(s0)
    80009bb2:	0792                	slli	a5,a5,0x4
    80009bb4:	97ba                	add	a5,a5,a4
    80009bb6:	4705                	li	a4,1
    80009bb8:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[0]].next = idx[1];
    80009bbc:	fd442683          	lw	a3,-44(s0)
    80009bc0:	0049c717          	auipc	a4,0x49c
    80009bc4:	44070713          	addi	a4,a4,1088 # 804a6000 <disk>
    80009bc8:	6789                	lui	a5,0x2
    80009bca:	97ba                	add	a5,a5,a4
    80009bcc:	6398                	ld	a4,0(a5)
    80009bce:	fd042783          	lw	a5,-48(s0)
    80009bd2:	0792                	slli	a5,a5,0x4
    80009bd4:	97ba                	add	a5,a5,a4
    80009bd6:	03069713          	slli	a4,a3,0x30
    80009bda:	9341                	srli	a4,a4,0x30
    80009bdc:	00e79723          	sh	a4,14(a5) # 200e <_entry-0x7fffdff2>

  disk.desc[idx[1]].addr = (uint64) b->data;
    80009be0:	fc843783          	ld	a5,-56(s0)
    80009be4:	05878693          	addi	a3,a5,88
    80009be8:	0049c717          	auipc	a4,0x49c
    80009bec:	41870713          	addi	a4,a4,1048 # 804a6000 <disk>
    80009bf0:	6789                	lui	a5,0x2
    80009bf2:	97ba                	add	a5,a5,a4
    80009bf4:	6398                	ld	a4,0(a5)
    80009bf6:	fd442783          	lw	a5,-44(s0)
    80009bfa:	0792                	slli	a5,a5,0x4
    80009bfc:	97ba                	add	a5,a5,a4
    80009bfe:	8736                	mv	a4,a3
    80009c00:	e398                	sd	a4,0(a5)
  disk.desc[idx[1]].len = BSIZE;
    80009c02:	0049c717          	auipc	a4,0x49c
    80009c06:	3fe70713          	addi	a4,a4,1022 # 804a6000 <disk>
    80009c0a:	6789                	lui	a5,0x2
    80009c0c:	97ba                	add	a5,a5,a4
    80009c0e:	6398                	ld	a4,0(a5)
    80009c10:	fd442783          	lw	a5,-44(s0)
    80009c14:	0792                	slli	a5,a5,0x4
    80009c16:	97ba                	add	a5,a5,a4
    80009c18:	40000713          	li	a4,1024
    80009c1c:	c798                	sw	a4,8(a5)
  if(write)
    80009c1e:	fc442783          	lw	a5,-60(s0)
    80009c22:	2781                	sext.w	a5,a5
    80009c24:	cf99                	beqz	a5,80009c42 <virtio_disk_rw+0x186>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80009c26:	0049c717          	auipc	a4,0x49c
    80009c2a:	3da70713          	addi	a4,a4,986 # 804a6000 <disk>
    80009c2e:	6789                	lui	a5,0x2
    80009c30:	97ba                	add	a5,a5,a4
    80009c32:	6398                	ld	a4,0(a5)
    80009c34:	fd442783          	lw	a5,-44(s0)
    80009c38:	0792                	slli	a5,a5,0x4
    80009c3a:	97ba                	add	a5,a5,a4
    80009c3c:	00079623          	sh	zero,12(a5) # 200c <_entry-0x7fffdff4>
    80009c40:	a839                	j	80009c5e <virtio_disk_rw+0x1a2>
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80009c42:	0049c717          	auipc	a4,0x49c
    80009c46:	3be70713          	addi	a4,a4,958 # 804a6000 <disk>
    80009c4a:	6789                	lui	a5,0x2
    80009c4c:	97ba                	add	a5,a5,a4
    80009c4e:	6398                	ld	a4,0(a5)
    80009c50:	fd442783          	lw	a5,-44(s0)
    80009c54:	0792                	slli	a5,a5,0x4
    80009c56:	97ba                	add	a5,a5,a4
    80009c58:	4709                	li	a4,2
    80009c5a:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80009c5e:	0049c717          	auipc	a4,0x49c
    80009c62:	3a270713          	addi	a4,a4,930 # 804a6000 <disk>
    80009c66:	6789                	lui	a5,0x2
    80009c68:	97ba                	add	a5,a5,a4
    80009c6a:	6398                	ld	a4,0(a5)
    80009c6c:	fd442783          	lw	a5,-44(s0)
    80009c70:	0792                	slli	a5,a5,0x4
    80009c72:	97ba                	add	a5,a5,a4
    80009c74:	00c7d703          	lhu	a4,12(a5) # 200c <_entry-0x7fffdff4>
    80009c78:	0049c697          	auipc	a3,0x49c
    80009c7c:	38868693          	addi	a3,a3,904 # 804a6000 <disk>
    80009c80:	6789                	lui	a5,0x2
    80009c82:	97b6                	add	a5,a5,a3
    80009c84:	6394                	ld	a3,0(a5)
    80009c86:	fd442783          	lw	a5,-44(s0)
    80009c8a:	0792                	slli	a5,a5,0x4
    80009c8c:	97b6                	add	a5,a5,a3
    80009c8e:	00176713          	ori	a4,a4,1
    80009c92:	1742                	slli	a4,a4,0x30
    80009c94:	9341                	srli	a4,a4,0x30
    80009c96:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[1]].next = idx[2];
    80009c9a:	fd842683          	lw	a3,-40(s0)
    80009c9e:	0049c717          	auipc	a4,0x49c
    80009ca2:	36270713          	addi	a4,a4,866 # 804a6000 <disk>
    80009ca6:	6789                	lui	a5,0x2
    80009ca8:	97ba                	add	a5,a5,a4
    80009caa:	6398                	ld	a4,0(a5)
    80009cac:	fd442783          	lw	a5,-44(s0)
    80009cb0:	0792                	slli	a5,a5,0x4
    80009cb2:	97ba                	add	a5,a5,a4
    80009cb4:	03069713          	slli	a4,a3,0x30
    80009cb8:	9341                	srli	a4,a4,0x30
    80009cba:	00e79723          	sh	a4,14(a5) # 200e <_entry-0x7fffdff2>

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80009cbe:	fd042783          	lw	a5,-48(s0)
    80009cc2:	0049c717          	auipc	a4,0x49c
    80009cc6:	33e70713          	addi	a4,a4,830 # 804a6000 <disk>
    80009cca:	20078793          	addi	a5,a5,512
    80009cce:	0792                	slli	a5,a5,0x4
    80009cd0:	97ba                	add	a5,a5,a4
    80009cd2:	577d                	li	a4,-1
    80009cd4:	02e78823          	sb	a4,48(a5)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80009cd8:	fd042783          	lw	a5,-48(s0)
    80009cdc:	20078793          	addi	a5,a5,512
    80009ce0:	00479713          	slli	a4,a5,0x4
    80009ce4:	0049c797          	auipc	a5,0x49c
    80009ce8:	31c78793          	addi	a5,a5,796 # 804a6000 <disk>
    80009cec:	97ba                	add	a5,a5,a4
    80009cee:	03078693          	addi	a3,a5,48
    80009cf2:	0049c717          	auipc	a4,0x49c
    80009cf6:	30e70713          	addi	a4,a4,782 # 804a6000 <disk>
    80009cfa:	6789                	lui	a5,0x2
    80009cfc:	97ba                	add	a5,a5,a4
    80009cfe:	6398                	ld	a4,0(a5)
    80009d00:	fd842783          	lw	a5,-40(s0)
    80009d04:	0792                	slli	a5,a5,0x4
    80009d06:	97ba                	add	a5,a5,a4
    80009d08:	8736                	mv	a4,a3
    80009d0a:	e398                	sd	a4,0(a5)
  disk.desc[idx[2]].len = 1;
    80009d0c:	0049c717          	auipc	a4,0x49c
    80009d10:	2f470713          	addi	a4,a4,756 # 804a6000 <disk>
    80009d14:	6789                	lui	a5,0x2
    80009d16:	97ba                	add	a5,a5,a4
    80009d18:	6398                	ld	a4,0(a5)
    80009d1a:	fd842783          	lw	a5,-40(s0)
    80009d1e:	0792                	slli	a5,a5,0x4
    80009d20:	97ba                	add	a5,a5,a4
    80009d22:	4705                	li	a4,1
    80009d24:	c798                	sw	a4,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80009d26:	0049c717          	auipc	a4,0x49c
    80009d2a:	2da70713          	addi	a4,a4,730 # 804a6000 <disk>
    80009d2e:	6789                	lui	a5,0x2
    80009d30:	97ba                	add	a5,a5,a4
    80009d32:	6398                	ld	a4,0(a5)
    80009d34:	fd842783          	lw	a5,-40(s0)
    80009d38:	0792                	slli	a5,a5,0x4
    80009d3a:	97ba                	add	a5,a5,a4
    80009d3c:	4709                	li	a4,2
    80009d3e:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[2]].next = 0;
    80009d42:	0049c717          	auipc	a4,0x49c
    80009d46:	2be70713          	addi	a4,a4,702 # 804a6000 <disk>
    80009d4a:	6789                	lui	a5,0x2
    80009d4c:	97ba                	add	a5,a5,a4
    80009d4e:	6398                	ld	a4,0(a5)
    80009d50:	fd842783          	lw	a5,-40(s0)
    80009d54:	0792                	slli	a5,a5,0x4
    80009d56:	97ba                	add	a5,a5,a4
    80009d58:	00079723          	sh	zero,14(a5) # 200e <_entry-0x7fffdff2>

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80009d5c:	fc843783          	ld	a5,-56(s0)
    80009d60:	4705                	li	a4,1
    80009d62:	c3d8                	sw	a4,4(a5)
  disk.info[idx[0]].b = b;
    80009d64:	fd042783          	lw	a5,-48(s0)
    80009d68:	0049c717          	auipc	a4,0x49c
    80009d6c:	29870713          	addi	a4,a4,664 # 804a6000 <disk>
    80009d70:	20078793          	addi	a5,a5,512
    80009d74:	0792                	slli	a5,a5,0x4
    80009d76:	97ba                	add	a5,a5,a4
    80009d78:	fc843703          	ld	a4,-56(s0)
    80009d7c:	f798                	sd	a4,40(a5)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80009d7e:	fd042603          	lw	a2,-48(s0)
    80009d82:	0049c717          	auipc	a4,0x49c
    80009d86:	27e70713          	addi	a4,a4,638 # 804a6000 <disk>
    80009d8a:	6789                	lui	a5,0x2
    80009d8c:	97ba                	add	a5,a5,a4
    80009d8e:	6794                	ld	a3,8(a5)
    80009d90:	0049c717          	auipc	a4,0x49c
    80009d94:	27070713          	addi	a4,a4,624 # 804a6000 <disk>
    80009d98:	6789                	lui	a5,0x2
    80009d9a:	97ba                	add	a5,a5,a4
    80009d9c:	679c                	ld	a5,8(a5)
    80009d9e:	0027d783          	lhu	a5,2(a5) # 2002 <_entry-0x7fffdffe>
    80009da2:	2781                	sext.w	a5,a5
    80009da4:	8b9d                	andi	a5,a5,7
    80009da6:	2781                	sext.w	a5,a5
    80009da8:	03061713          	slli	a4,a2,0x30
    80009dac:	9341                	srli	a4,a4,0x30
    80009dae:	0786                	slli	a5,a5,0x1
    80009db0:	97b6                	add	a5,a5,a3
    80009db2:	00e79223          	sh	a4,4(a5)

  __sync_synchronize();
    80009db6:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80009dba:	0049c717          	auipc	a4,0x49c
    80009dbe:	24670713          	addi	a4,a4,582 # 804a6000 <disk>
    80009dc2:	6789                	lui	a5,0x2
    80009dc4:	97ba                	add	a5,a5,a4
    80009dc6:	679c                	ld	a5,8(a5)
    80009dc8:	0027d703          	lhu	a4,2(a5) # 2002 <_entry-0x7fffdffe>
    80009dcc:	0049c697          	auipc	a3,0x49c
    80009dd0:	23468693          	addi	a3,a3,564 # 804a6000 <disk>
    80009dd4:	6789                	lui	a5,0x2
    80009dd6:	97b6                	add	a5,a5,a3
    80009dd8:	679c                	ld	a5,8(a5)
    80009dda:	2705                	addiw	a4,a4,1
    80009ddc:	1742                	slli	a4,a4,0x30
    80009dde:	9341                	srli	a4,a4,0x30
    80009de0:	00e79123          	sh	a4,2(a5) # 2002 <_entry-0x7fffdffe>

  __sync_synchronize();
    80009de4:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80009de8:	100017b7          	lui	a5,0x10001
    80009dec:	05078793          	addi	a5,a5,80 # 10001050 <_entry-0x6fffefb0>
    80009df0:	0007a023          	sw	zero,0(a5)

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80009df4:	a819                	j	80009e0a <virtio_disk_rw+0x34e>
    sleep(b, &disk.vdisk_lock);
    80009df6:	0049e597          	auipc	a1,0x49e
    80009dfa:	33258593          	addi	a1,a1,818 # 804a8128 <disk+0x2128>
    80009dfe:	fc843503          	ld	a0,-56(s0)
    80009e02:	ffffa097          	auipc	ra,0xffffa
    80009e06:	b20080e7          	jalr	-1248(ra) # 80003922 <sleep>
  while(b->disk == 1) {
    80009e0a:	fc843783          	ld	a5,-56(s0)
    80009e0e:	43dc                	lw	a5,4(a5)
    80009e10:	873e                	mv	a4,a5
    80009e12:	4785                	li	a5,1
    80009e14:	fef701e3          	beq	a4,a5,80009df6 <virtio_disk_rw+0x33a>
  }

  disk.info[idx[0]].b = 0;
    80009e18:	fd042783          	lw	a5,-48(s0)
    80009e1c:	0049c717          	auipc	a4,0x49c
    80009e20:	1e470713          	addi	a4,a4,484 # 804a6000 <disk>
    80009e24:	20078793          	addi	a5,a5,512
    80009e28:	0792                	slli	a5,a5,0x4
    80009e2a:	97ba                	add	a5,a5,a4
    80009e2c:	0207b423          	sd	zero,40(a5)
  free_chain(idx[0]);
    80009e30:	fd042783          	lw	a5,-48(s0)
    80009e34:	853e                	mv	a0,a5
    80009e36:	00000097          	auipc	ra,0x0
    80009e3a:	b6a080e7          	jalr	-1174(ra) # 800099a0 <free_chain>

  release(&disk.vdisk_lock);
    80009e3e:	0049e517          	auipc	a0,0x49e
    80009e42:	2ea50513          	addi	a0,a0,746 # 804a8128 <disk+0x2128>
    80009e46:	ffff7097          	auipc	ra,0xffff7
    80009e4a:	488080e7          	jalr	1160(ra) # 800012ce <release>
}
    80009e4e:	0001                	nop
    80009e50:	70e2                	ld	ra,56(sp)
    80009e52:	7442                	ld	s0,48(sp)
    80009e54:	6121                	addi	sp,sp,64
    80009e56:	8082                	ret

0000000080009e58 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80009e58:	1101                	addi	sp,sp,-32
    80009e5a:	ec06                	sd	ra,24(sp)
    80009e5c:	e822                	sd	s0,16(sp)
    80009e5e:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80009e60:	0049e517          	auipc	a0,0x49e
    80009e64:	2c850513          	addi	a0,a0,712 # 804a8128 <disk+0x2128>
    80009e68:	ffff7097          	auipc	ra,0xffff7
    80009e6c:	402080e7          	jalr	1026(ra) # 8000126a <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80009e70:	100017b7          	lui	a5,0x10001
    80009e74:	06078793          	addi	a5,a5,96 # 10001060 <_entry-0x6fffefa0>
    80009e78:	439c                	lw	a5,0(a5)
    80009e7a:	0007871b          	sext.w	a4,a5
    80009e7e:	100017b7          	lui	a5,0x10001
    80009e82:	06478793          	addi	a5,a5,100 # 10001064 <_entry-0x6fffef9c>
    80009e86:	8b0d                	andi	a4,a4,3
    80009e88:	2701                	sext.w	a4,a4
    80009e8a:	c398                	sw	a4,0(a5)

  __sync_synchronize();
    80009e8c:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80009e90:	a855                	j	80009f44 <virtio_disk_intr+0xec>
    __sync_synchronize();
    80009e92:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80009e96:	0049c717          	auipc	a4,0x49c
    80009e9a:	16a70713          	addi	a4,a4,362 # 804a6000 <disk>
    80009e9e:	6789                	lui	a5,0x2
    80009ea0:	97ba                	add	a5,a5,a4
    80009ea2:	6b98                	ld	a4,16(a5)
    80009ea4:	0049c697          	auipc	a3,0x49c
    80009ea8:	15c68693          	addi	a3,a3,348 # 804a6000 <disk>
    80009eac:	6789                	lui	a5,0x2
    80009eae:	97b6                	add	a5,a5,a3
    80009eb0:	0207d783          	lhu	a5,32(a5) # 2020 <_entry-0x7fffdfe0>
    80009eb4:	2781                	sext.w	a5,a5
    80009eb6:	8b9d                	andi	a5,a5,7
    80009eb8:	2781                	sext.w	a5,a5
    80009eba:	078e                	slli	a5,a5,0x3
    80009ebc:	97ba                	add	a5,a5,a4
    80009ebe:	43dc                	lw	a5,4(a5)
    80009ec0:	fef42623          	sw	a5,-20(s0)

    if(disk.info[id].status != 0)
    80009ec4:	0049c717          	auipc	a4,0x49c
    80009ec8:	13c70713          	addi	a4,a4,316 # 804a6000 <disk>
    80009ecc:	fec42783          	lw	a5,-20(s0)
    80009ed0:	20078793          	addi	a5,a5,512
    80009ed4:	0792                	slli	a5,a5,0x4
    80009ed6:	97ba                	add	a5,a5,a4
    80009ed8:	0307c783          	lbu	a5,48(a5)
    80009edc:	cb89                	beqz	a5,80009eee <virtio_disk_intr+0x96>
      panic("virtio_disk_intr status");
    80009ede:	00002517          	auipc	a0,0x2
    80009ee2:	9d250513          	addi	a0,a0,-1582 # 8000b8b0 <etext+0x8b0>
    80009ee6:	ffff7097          	auipc	ra,0xffff7
    80009eea:	d94080e7          	jalr	-620(ra) # 80000c7a <panic>

    struct buf *b = disk.info[id].b;
    80009eee:	0049c717          	auipc	a4,0x49c
    80009ef2:	11270713          	addi	a4,a4,274 # 804a6000 <disk>
    80009ef6:	fec42783          	lw	a5,-20(s0)
    80009efa:	20078793          	addi	a5,a5,512
    80009efe:	0792                	slli	a5,a5,0x4
    80009f00:	97ba                	add	a5,a5,a4
    80009f02:	779c                	ld	a5,40(a5)
    80009f04:	fef43023          	sd	a5,-32(s0)
    b->disk = 0;   // disk is done with buf
    80009f08:	fe043783          	ld	a5,-32(s0)
    80009f0c:	0007a223          	sw	zero,4(a5)
    wakeup(b);
    80009f10:	fe043503          	ld	a0,-32(s0)
    80009f14:	ffffa097          	auipc	ra,0xffffa
    80009f18:	a8a080e7          	jalr	-1398(ra) # 8000399e <wakeup>

    disk.used_idx += 1;
    80009f1c:	0049c717          	auipc	a4,0x49c
    80009f20:	0e470713          	addi	a4,a4,228 # 804a6000 <disk>
    80009f24:	6789                	lui	a5,0x2
    80009f26:	97ba                	add	a5,a5,a4
    80009f28:	0207d783          	lhu	a5,32(a5) # 2020 <_entry-0x7fffdfe0>
    80009f2c:	2785                	addiw	a5,a5,1
    80009f2e:	03079713          	slli	a4,a5,0x30
    80009f32:	9341                	srli	a4,a4,0x30
    80009f34:	0049c697          	auipc	a3,0x49c
    80009f38:	0cc68693          	addi	a3,a3,204 # 804a6000 <disk>
    80009f3c:	6789                	lui	a5,0x2
    80009f3e:	97b6                	add	a5,a5,a3
    80009f40:	02e79023          	sh	a4,32(a5) # 2020 <_entry-0x7fffdfe0>
  while(disk.used_idx != disk.used->idx){
    80009f44:	0049c717          	auipc	a4,0x49c
    80009f48:	0bc70713          	addi	a4,a4,188 # 804a6000 <disk>
    80009f4c:	6789                	lui	a5,0x2
    80009f4e:	97ba                	add	a5,a5,a4
    80009f50:	0207d683          	lhu	a3,32(a5) # 2020 <_entry-0x7fffdfe0>
    80009f54:	0049c717          	auipc	a4,0x49c
    80009f58:	0ac70713          	addi	a4,a4,172 # 804a6000 <disk>
    80009f5c:	6789                	lui	a5,0x2
    80009f5e:	97ba                	add	a5,a5,a4
    80009f60:	6b9c                	ld	a5,16(a5)
    80009f62:	0027d783          	lhu	a5,2(a5) # 2002 <_entry-0x7fffdffe>
    80009f66:	0006871b          	sext.w	a4,a3
    80009f6a:	2781                	sext.w	a5,a5
    80009f6c:	f2f713e3          	bne	a4,a5,80009e92 <virtio_disk_intr+0x3a>
  }

  release(&disk.vdisk_lock);
    80009f70:	0049e517          	auipc	a0,0x49e
    80009f74:	1b850513          	addi	a0,a0,440 # 804a8128 <disk+0x2128>
    80009f78:	ffff7097          	auipc	ra,0xffff7
    80009f7c:	356080e7          	jalr	854(ra) # 800012ce <release>
}
    80009f80:	0001                	nop
    80009f82:	60e2                	ld	ra,24(sp)
    80009f84:	6442                	ld	s0,16(sp)
    80009f86:	6105                	addi	sp,sp,32
    80009f88:	8082                	ret
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
