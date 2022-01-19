
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
    8000032c:	16878793          	addi	a5,a5,360 # 80009490 <timervec>
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
    8000040a:	728080e7          	jalr	1832(ra) # 80003b2e <either_copyin>
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
    800004c0:	446080e7          	jalr	1094(ra) # 80003902 <sleep>
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
    8000057c:	542080e7          	jalr	1346(ra) # 80003aba <either_copyout>
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
    80000666:	540080e7          	jalr	1344(ra) # 80003ba2 <procdump>
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
    8000082a:	158080e7          	jalr	344(ra) # 8000397e <wakeup>
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
    80000dda:	b2c080e7          	jalr	-1236(ra) # 80003902 <sleep>
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
    80000f18:	a6a080e7          	jalr	-1430(ra) # 8000397e <wakeup>
    
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
    8000186c:	c44080e7          	jalr	-956(ra) # 800044ac <trapinit>
    trapinithart();  // install kernel trap vector
    80001870:	00003097          	auipc	ra,0x3
    80001874:	c66080e7          	jalr	-922(ra) # 800044d6 <trapinithart>
    plicinit();      // set up interrupt controller
    80001878:	00008097          	auipc	ra,0x8
    8000187c:	c42080e7          	jalr	-958(ra) # 800094ba <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80001880:	00008097          	auipc	ra,0x8
    80001884:	c5e080e7          	jalr	-930(ra) # 800094de <plicinithart>
    binit();         // buffer cache
    80001888:	00004097          	auipc	ra,0x4
    8000188c:	870080e7          	jalr	-1936(ra) # 800050f8 <binit>
    iinit();         // inode table
    80001890:	00004097          	auipc	ra,0x4
    80001894:	0a4080e7          	jalr	164(ra) # 80005934 <iinit>
    fileinit();      // file table
    80001898:	00006097          	auipc	ra,0x6
    8000189c:	a54080e7          	jalr	-1452(ra) # 800072ec <fileinit>
    virtio_disk_init(); // emulated hard disk
    800018a0:	00008097          	auipc	ra,0x8
    800018a4:	d12080e7          	jalr	-750(ra) # 800095b2 <virtio_disk_init>
    userinit();      // first user process
    800018a8:	00001097          	auipc	ra,0x1
    800018ac:	62c080e7          	jalr	1580(ra) # 80002ed4 <userinit>
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
    800018fe:	bdc080e7          	jalr	-1060(ra) # 800044d6 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80001902:	00008097          	auipc	ra,0x8
    80001906:	bdc080e7          	jalr	-1060(ra) # 800094de <plicinithart>
  }

  scheduler();        
    8000190a:	00002097          	auipc	ra,0x2
    8000190e:	dc8080e7          	jalr	-568(ra) # 800036d2 <scheduler>

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
    80002ba6:	214080e7          	jalr	532(ra) # 80002db6 <proc_pagetable>
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
    80002bf4:	cc270713          	addi	a4,a4,-830 # 800038b2 <forkret>
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
    80002c64:	216080e7          	jalr	534(ra) # 80002e76 <proc_freepagetable>
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
    kfree((void*)p->pagetable); //kernel free de la tabla de páginas, no se están recorriendo todos los niveles
    80002d54:	fe843783          	ld	a5,-24(s0)
    80002d58:	6bbc                	ld	a5,80(a5)
    80002d5a:	853e                	mv	a0,a5
    80002d5c:	ffffe097          	auipc	ra,0xffffe
    80002d60:	316080e7          	jalr	790(ra) # 80001072 <kfree>

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
}
    80002dac:	0001                	nop
    80002dae:	60e2                	ld	ra,24(sp)
    80002db0:	6442                	ld	s0,16(sp)
    80002db2:	6105                	addi	sp,sp,32
    80002db4:	8082                	ret

0000000080002db6 <proc_pagetable>:

// Create a user page table for a given process,
// with no user memory, but with trampoline pages.
pagetable_t
proc_pagetable(struct proc *p)
{
    80002db6:	7179                	addi	sp,sp,-48
    80002db8:	f406                	sd	ra,40(sp)
    80002dba:	f022                	sd	s0,32(sp)
    80002dbc:	1800                	addi	s0,sp,48
    80002dbe:	fca43c23          	sd	a0,-40(s0)
  pagetable_t pagetable;

  // An empty page table.
  pagetable = uvmcreate();
    80002dc2:	fffff097          	auipc	ra,0xfffff
    80002dc6:	082080e7          	jalr	130(ra) # 80001e44 <uvmcreate>
    80002dca:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80002dce:	fe843783          	ld	a5,-24(s0)
    80002dd2:	e399                	bnez	a5,80002dd8 <proc_pagetable+0x22>
    return 0;
    80002dd4:	4781                	li	a5,0
    80002dd6:	a859                	j	80002e6c <proc_pagetable+0xb6>

  // map the trampoline code (for system call return)
  // at the highest user virtual address.
  // only the supervisor uses it, on the way
  // to/from user space, so not PTE_U.
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80002dd8:	00007797          	auipc	a5,0x7
    80002ddc:	22878793          	addi	a5,a5,552 # 8000a000 <_trampoline>
    80002de0:	4729                	li	a4,10
    80002de2:	86be                	mv	a3,a5
    80002de4:	6605                	lui	a2,0x1
    80002de6:	040007b7          	lui	a5,0x4000
    80002dea:	17fd                	addi	a5,a5,-1
    80002dec:	00c79593          	slli	a1,a5,0xc
    80002df0:	fe843503          	ld	a0,-24(s0)
    80002df4:	fffff097          	auipc	ra,0xfffff
    80002df8:	e72080e7          	jalr	-398(ra) # 80001c66 <mappages>
    80002dfc:	87aa                	mv	a5,a0
    80002dfe:	0007db63          	bgez	a5,80002e14 <proc_pagetable+0x5e>
              (uint64)trampoline, PTE_R | PTE_X) < 0){
    uvmfree(pagetable, 0);
    80002e02:	4581                	li	a1,0
    80002e04:	fe843503          	ld	a0,-24(s0)
    80002e08:	fffff097          	auipc	ra,0xfffff
    80002e0c:	32a080e7          	jalr	810(ra) # 80002132 <uvmfree>
    return 0;
    80002e10:	4781                	li	a5,0
    80002e12:	a8a9                	j	80002e6c <proc_pagetable+0xb6>
  }

  // map the trapframe just below TRAMPOLINE, for trampoline.S.
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
              (uint64)(p->trapframe), PTE_R | PTE_W) < 0){
    80002e14:	fd843783          	ld	a5,-40(s0)
    80002e18:	73bc                	ld	a5,96(a5)
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80002e1a:	4719                	li	a4,6
    80002e1c:	86be                	mv	a3,a5
    80002e1e:	6605                	lui	a2,0x1
    80002e20:	020007b7          	lui	a5,0x2000
    80002e24:	17fd                	addi	a5,a5,-1
    80002e26:	00d79593          	slli	a1,a5,0xd
    80002e2a:	fe843503          	ld	a0,-24(s0)
    80002e2e:	fffff097          	auipc	ra,0xfffff
    80002e32:	e38080e7          	jalr	-456(ra) # 80001c66 <mappages>
    80002e36:	87aa                	mv	a5,a0
    80002e38:	0207d863          	bgez	a5,80002e68 <proc_pagetable+0xb2>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002e3c:	4681                	li	a3,0
    80002e3e:	4605                	li	a2,1
    80002e40:	040007b7          	lui	a5,0x4000
    80002e44:	17fd                	addi	a5,a5,-1
    80002e46:	00c79593          	slli	a1,a5,0xc
    80002e4a:	fe843503          	ld	a0,-24(s0)
    80002e4e:	fffff097          	auipc	ra,0xfffff
    80002e52:	ef6080e7          	jalr	-266(ra) # 80001d44 <uvmunmap>
    uvmfree(pagetable, 0);
    80002e56:	4581                	li	a1,0
    80002e58:	fe843503          	ld	a0,-24(s0)
    80002e5c:	fffff097          	auipc	ra,0xfffff
    80002e60:	2d6080e7          	jalr	726(ra) # 80002132 <uvmfree>
    return 0;
    80002e64:	4781                	li	a5,0
    80002e66:	a019                	j	80002e6c <proc_pagetable+0xb6>
  }

  return pagetable;
    80002e68:	fe843783          	ld	a5,-24(s0)
}
    80002e6c:	853e                	mv	a0,a5
    80002e6e:	70a2                	ld	ra,40(sp)
    80002e70:	7402                	ld	s0,32(sp)
    80002e72:	6145                	addi	sp,sp,48
    80002e74:	8082                	ret

0000000080002e76 <proc_freepagetable>:

// Free a process's page table, and free the
// physical memory it refers to.
void
proc_freepagetable(pagetable_t pagetable, uint64 sz)
{
    80002e76:	1101                	addi	sp,sp,-32
    80002e78:	ec06                	sd	ra,24(sp)
    80002e7a:	e822                	sd	s0,16(sp)
    80002e7c:	1000                	addi	s0,sp,32
    80002e7e:	fea43423          	sd	a0,-24(s0)
    80002e82:	feb43023          	sd	a1,-32(s0)
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002e86:	4681                	li	a3,0
    80002e88:	4605                	li	a2,1
    80002e8a:	040007b7          	lui	a5,0x4000
    80002e8e:	17fd                	addi	a5,a5,-1
    80002e90:	00c79593          	slli	a1,a5,0xc
    80002e94:	fe843503          	ld	a0,-24(s0)
    80002e98:	fffff097          	auipc	ra,0xfffff
    80002e9c:	eac080e7          	jalr	-340(ra) # 80001d44 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80002ea0:	4681                	li	a3,0
    80002ea2:	4605                	li	a2,1
    80002ea4:	020007b7          	lui	a5,0x2000
    80002ea8:	17fd                	addi	a5,a5,-1
    80002eaa:	00d79593          	slli	a1,a5,0xd
    80002eae:	fe843503          	ld	a0,-24(s0)
    80002eb2:	fffff097          	auipc	ra,0xfffff
    80002eb6:	e92080e7          	jalr	-366(ra) # 80001d44 <uvmunmap>
  uvmfree(pagetable, sz);
    80002eba:	fe043583          	ld	a1,-32(s0)
    80002ebe:	fe843503          	ld	a0,-24(s0)
    80002ec2:	fffff097          	auipc	ra,0xfffff
    80002ec6:	270080e7          	jalr	624(ra) # 80002132 <uvmfree>
}
    80002eca:	0001                	nop
    80002ecc:	60e2                	ld	ra,24(sp)
    80002ece:	6442                	ld	s0,16(sp)
    80002ed0:	6105                	addi	sp,sp,32
    80002ed2:	8082                	ret

0000000080002ed4 <userinit>:
};

// Set up first user process.
void
userinit(void)
{
    80002ed4:	1101                	addi	sp,sp,-32
    80002ed6:	ec06                	sd	ra,24(sp)
    80002ed8:	e822                	sd	s0,16(sp)
    80002eda:	1000                	addi	s0,sp,32
  struct proc *p;

  p = allocproc();
    80002edc:	00000097          	auipc	ra,0x0
    80002ee0:	bd6080e7          	jalr	-1066(ra) # 80002ab2 <allocproc>
    80002ee4:	fea43423          	sd	a0,-24(s0)
  initproc = p;
    80002ee8:	00009797          	auipc	a5,0x9
    80002eec:	13878793          	addi	a5,a5,312 # 8000c020 <initproc>
    80002ef0:	fe843703          	ld	a4,-24(s0)
    80002ef4:	e398                	sd	a4,0(a5)
  
  // allocate one user page and copy init's instructions
  // and data into it.
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80002ef6:	fe843783          	ld	a5,-24(s0)
    80002efa:	6bbc                	ld	a5,80(a5)
    80002efc:	03400613          	li	a2,52
    80002f00:	00009597          	auipc	a1,0x9
    80002f04:	9f858593          	addi	a1,a1,-1544 # 8000b8f8 <initcode>
    80002f08:	853e                	mv	a0,a5
    80002f0a:	fffff097          	auipc	ra,0xfffff
    80002f0e:	f76080e7          	jalr	-138(ra) # 80001e80 <uvminit>
  p->sz = PGSIZE;
    80002f12:	fe843783          	ld	a5,-24(s0)
    80002f16:	6705                	lui	a4,0x1
    80002f18:	e7b8                	sd	a4,72(a5)

  // prepare for the very first "return" from kernel to user.
  p->trapframe->epc = 0;      // user program counter
    80002f1a:	fe843783          	ld	a5,-24(s0)
    80002f1e:	73bc                	ld	a5,96(a5)
    80002f20:	0007bc23          	sd	zero,24(a5)
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80002f24:	fe843783          	ld	a5,-24(s0)
    80002f28:	73bc                	ld	a5,96(a5)
    80002f2a:	6705                	lui	a4,0x1
    80002f2c:	fb98                	sd	a4,48(a5)

  safestrcpy(p->name, "initcode", sizeof(p->name));
    80002f2e:	fe843783          	ld	a5,-24(s0)
    80002f32:	16878793          	addi	a5,a5,360
    80002f36:	4641                	li	a2,16
    80002f38:	00008597          	auipc	a1,0x8
    80002f3c:	2e058593          	addi	a1,a1,736 # 8000b218 <etext+0x218>
    80002f40:	853e                	mv	a0,a5
    80002f42:	fffff097          	auipc	ra,0xfffff
    80002f46:	800080e7          	jalr	-2048(ra) # 80001742 <safestrcpy>
  p->cwd = namei("/");
    80002f4a:	00008517          	auipc	a0,0x8
    80002f4e:	2de50513          	addi	a0,a0,734 # 8000b228 <etext+0x228>
    80002f52:	00004097          	auipc	ra,0x4
    80002f56:	ab0080e7          	jalr	-1360(ra) # 80006a02 <namei>
    80002f5a:	872a                	mv	a4,a0
    80002f5c:	fe843783          	ld	a5,-24(s0)
    80002f60:	16e7b023          	sd	a4,352(a5)

  p->state = RUNNABLE;
    80002f64:	fe843783          	ld	a5,-24(s0)
    80002f68:	470d                	li	a4,3
    80002f6a:	cf98                	sw	a4,24(a5)

  release(&p->lock);
    80002f6c:	fe843783          	ld	a5,-24(s0)
    80002f70:	853e                	mv	a0,a5
    80002f72:	ffffe097          	auipc	ra,0xffffe
    80002f76:	35c080e7          	jalr	860(ra) # 800012ce <release>
}
    80002f7a:	0001                	nop
    80002f7c:	60e2                	ld	ra,24(sp)
    80002f7e:	6442                	ld	s0,16(sp)
    80002f80:	6105                	addi	sp,sp,32
    80002f82:	8082                	ret

0000000080002f84 <growproc>:

// Grow or shrink user memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
    80002f84:	7179                	addi	sp,sp,-48
    80002f86:	f406                	sd	ra,40(sp)
    80002f88:	f022                	sd	s0,32(sp)
    80002f8a:	1800                	addi	s0,sp,48
    80002f8c:	87aa                	mv	a5,a0
    80002f8e:	fcf42e23          	sw	a5,-36(s0)
  uint sz;
  struct proc *p = myproc();
    80002f92:	00000097          	auipc	ra,0x0
    80002f96:	a86080e7          	jalr	-1402(ra) # 80002a18 <myproc>
    80002f9a:	fea43023          	sd	a0,-32(s0)

  sz = p->sz;
    80002f9e:	fe043783          	ld	a5,-32(s0)
    80002fa2:	67bc                	ld	a5,72(a5)
    80002fa4:	fef42623          	sw	a5,-20(s0)
  if(n > 0){
    80002fa8:	fdc42783          	lw	a5,-36(s0)
    80002fac:	2781                	sext.w	a5,a5
    80002fae:	02f05f63          	blez	a5,80002fec <growproc+0x68>
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80002fb2:	fe043783          	ld	a5,-32(s0)
    80002fb6:	6bb8                	ld	a4,80(a5)
    80002fb8:	fec46683          	lwu	a3,-20(s0)
    80002fbc:	fdc42783          	lw	a5,-36(s0)
    80002fc0:	fec42603          	lw	a2,-20(s0)
    80002fc4:	9fb1                	addw	a5,a5,a2
    80002fc6:	2781                	sext.w	a5,a5
    80002fc8:	1782                	slli	a5,a5,0x20
    80002fca:	9381                	srli	a5,a5,0x20
    80002fcc:	863e                	mv	a2,a5
    80002fce:	85b6                	mv	a1,a3
    80002fd0:	853a                	mv	a0,a4
    80002fd2:	fffff097          	auipc	ra,0xfffff
    80002fd6:	f36080e7          	jalr	-202(ra) # 80001f08 <uvmalloc>
    80002fda:	87aa                	mv	a5,a0
    80002fdc:	fef42623          	sw	a5,-20(s0)
    80002fe0:	fec42783          	lw	a5,-20(s0)
    80002fe4:	2781                	sext.w	a5,a5
    80002fe6:	ef9d                	bnez	a5,80003024 <growproc+0xa0>
      return -1;
    80002fe8:	57fd                	li	a5,-1
    80002fea:	a099                	j	80003030 <growproc+0xac>
    }
  } else if(n < 0){
    80002fec:	fdc42783          	lw	a5,-36(s0)
    80002ff0:	2781                	sext.w	a5,a5
    80002ff2:	0207d963          	bgez	a5,80003024 <growproc+0xa0>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80002ff6:	fe043783          	ld	a5,-32(s0)
    80002ffa:	6bb8                	ld	a4,80(a5)
    80002ffc:	fec46683          	lwu	a3,-20(s0)
    80003000:	fdc42783          	lw	a5,-36(s0)
    80003004:	fec42603          	lw	a2,-20(s0)
    80003008:	9fb1                	addw	a5,a5,a2
    8000300a:	2781                	sext.w	a5,a5
    8000300c:	1782                	slli	a5,a5,0x20
    8000300e:	9381                	srli	a5,a5,0x20
    80003010:	863e                	mv	a2,a5
    80003012:	85b6                	mv	a1,a3
    80003014:	853a                	mv	a0,a4
    80003016:	fffff097          	auipc	ra,0xfffff
    8000301a:	fd6080e7          	jalr	-42(ra) # 80001fec <uvmdealloc>
    8000301e:	87aa                	mv	a5,a0
    80003020:	fef42623          	sw	a5,-20(s0)
  }
  p->sz = sz;
    80003024:	fec46703          	lwu	a4,-20(s0)
    80003028:	fe043783          	ld	a5,-32(s0)
    8000302c:	e7b8                	sd	a4,72(a5)
  return 0;
    8000302e:	4781                	li	a5,0
}
    80003030:	853e                	mv	a0,a5
    80003032:	70a2                	ld	ra,40(sp)
    80003034:	7402                	ld	s0,32(sp)
    80003036:	6145                	addi	sp,sp,48
    80003038:	8082                	ret

000000008000303a <check_grow_threads>:



int check_grow_threads (struct proc *parent, int n, int sz)
{
    8000303a:	7179                	addi	sp,sp,-48
    8000303c:	f406                	sd	ra,40(sp)
    8000303e:	f022                	sd	s0,32(sp)
    80003040:	1800                	addi	s0,sp,48
    80003042:	fca43c23          	sd	a0,-40(s0)
    80003046:	87ae                	mv	a5,a1
    80003048:	8732                	mv	a4,a2
    8000304a:	fcf42a23          	sw	a5,-44(s0)
    8000304e:	87ba                	mv	a5,a4
    80003050:	fcf42823          	sw	a5,-48(s0)
  struct proc *np;
  for(np = proc; np < &proc[NPROC]; np++){
    80003054:	00011797          	auipc	a5,0x11
    80003058:	64478793          	addi	a5,a5,1604 # 80014698 <proc>
    8000305c:	fef43423          	sd	a5,-24(s0)
    80003060:	a885                	j	800030d0 <check_grow_threads+0x96>
      if(np->thread == 1 && np->ASID == parent->ASID){
    80003062:	fe843703          	ld	a4,-24(s0)
    80003066:	67c9                	lui	a5,0x12
    80003068:	97ba                	add	a5,a5,a4
    8000306a:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    8000306e:	873e                	mv	a4,a5
    80003070:	4785                	li	a5,1
    80003072:	04f71763          	bne	a4,a5,800030c0 <check_grow_threads+0x86>
    80003076:	fe843783          	ld	a5,-24(s0)
    8000307a:	5bd8                	lw	a4,52(a5)
    8000307c:	fd843783          	ld	a5,-40(s0)
    80003080:	5bdc                	lw	a5,52(a5)
    80003082:	02f71f63          	bne	a4,a5,800030c0 <check_grow_threads+0x86>
        if((growproc_thread(parent->pagetable, np->pagetable, sz, n))<0){
    80003086:	fd843783          	ld	a5,-40(s0)
    8000308a:	6bb8                	ld	a4,80(a5)
    8000308c:	fe843783          	ld	a5,-24(s0)
    80003090:	6bbc                	ld	a5,80(a5)
    80003092:	fd042603          	lw	a2,-48(s0)
    80003096:	fd442683          	lw	a3,-44(s0)
    8000309a:	85be                	mv	a1,a5
    8000309c:	853a                	mv	a0,a4
    8000309e:	00000097          	auipc	ra,0x0
    800030a2:	04e080e7          	jalr	78(ra) # 800030ec <growproc_thread>
    800030a6:	87aa                	mv	a5,a0
    800030a8:	0007dc63          	bgez	a5,800030c0 <check_grow_threads+0x86>
          printf ("Fallo al expandir en los hijos.\n");
    800030ac:	00008517          	auipc	a0,0x8
    800030b0:	18450513          	addi	a0,a0,388 # 8000b230 <etext+0x230>
    800030b4:	ffffe097          	auipc	ra,0xffffe
    800030b8:	970080e7          	jalr	-1680(ra) # 80000a24 <printf>
          return -1;
    800030bc:	57fd                	li	a5,-1
    800030be:	a015                	j	800030e2 <check_grow_threads+0xa8>
  for(np = proc; np < &proc[NPROC]; np++){
    800030c0:	fe843703          	ld	a4,-24(s0)
    800030c4:	67c9                	lui	a5,0x12
    800030c6:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    800030ca:	97ba                	add	a5,a5,a4
    800030cc:	fef43423          	sd	a5,-24(s0)
    800030d0:	fe843703          	ld	a4,-24(s0)
    800030d4:	00498797          	auipc	a5,0x498
    800030d8:	9c478793          	addi	a5,a5,-1596 # 8049aa98 <pid_lock>
    800030dc:	f8f763e3          	bltu	a4,a5,80003062 <check_grow_threads+0x28>
        }

      }
  }

  return 0;
    800030e0:	4781                	li	a5,0
}
    800030e2:	853e                	mv	a0,a5
    800030e4:	70a2                	ld	ra,40(sp)
    800030e6:	7402                	ld	s0,32(sp)
    800030e8:	6145                	addi	sp,sp,48
    800030ea:	8082                	ret

00000000800030ec <growproc_thread>:



int
growproc_thread(pagetable_t old, pagetable_t new, uint64 sz, int n)
{
    800030ec:	715d                	addi	sp,sp,-80
    800030ee:	e486                	sd	ra,72(sp)
    800030f0:	e0a2                	sd	s0,64(sp)
    800030f2:	0880                	addi	s0,sp,80
    800030f4:	fca43423          	sd	a0,-56(s0)
    800030f8:	fcb43023          	sd	a1,-64(s0)
    800030fc:	fac43c23          	sd	a2,-72(s0)
    80003100:	87b6                	mv	a5,a3
    80003102:	faf42a23          	sw	a5,-76(s0)
  pte_t *pte;
  uint64 pa, i;
  uint flags;

  for(i = sz; i < sz + n; i += PGSIZE){
    80003106:	fb843783          	ld	a5,-72(s0)
    8000310a:	fef43423          	sd	a5,-24(s0)
    8000310e:	a849                	j	800031a0 <growproc_thread+0xb4>
    if((pte = walk(old, i, 0)) == 0)
    80003110:	4601                	li	a2,0
    80003112:	fe843583          	ld	a1,-24(s0)
    80003116:	fc843503          	ld	a0,-56(s0)
    8000311a:	fffff097          	auipc	ra,0xfffff
    8000311e:	988080e7          	jalr	-1656(ra) # 80001aa2 <walk>
    80003122:	fea43023          	sd	a0,-32(s0)
    80003126:	fe043783          	ld	a5,-32(s0)
    8000312a:	eb89                	bnez	a5,8000313c <growproc_thread+0x50>
      panic("uvmcopy: pte should exist");
    8000312c:	00008517          	auipc	a0,0x8
    80003130:	12c50513          	addi	a0,a0,300 # 8000b258 <etext+0x258>
    80003134:	ffffe097          	auipc	ra,0xffffe
    80003138:	b46080e7          	jalr	-1210(ra) # 80000c7a <panic>
    if((*pte & PTE_V) == 0)
    8000313c:	fe043783          	ld	a5,-32(s0)
    80003140:	639c                	ld	a5,0(a5)
    80003142:	8b85                	andi	a5,a5,1
    80003144:	eb89                	bnez	a5,80003156 <growproc_thread+0x6a>
      panic("uvmcopy: page not present");
    80003146:	00008517          	auipc	a0,0x8
    8000314a:	13250513          	addi	a0,a0,306 # 8000b278 <etext+0x278>
    8000314e:	ffffe097          	auipc	ra,0xffffe
    80003152:	b2c080e7          	jalr	-1236(ra) # 80000c7a <panic>
    pa = PTE2PA(*pte);
    80003156:	fe043783          	ld	a5,-32(s0)
    8000315a:	639c                	ld	a5,0(a5)
    8000315c:	83a9                	srli	a5,a5,0xa
    8000315e:	07b2                	slli	a5,a5,0xc
    80003160:	fcf43c23          	sd	a5,-40(s0)
    flags = PTE_FLAGS(*pte);
    80003164:	fe043783          	ld	a5,-32(s0)
    80003168:	639c                	ld	a5,0(a5)
    8000316a:	2781                	sext.w	a5,a5
    8000316c:	3ff7f793          	andi	a5,a5,1023
    80003170:	fcf42a23          	sw	a5,-44(s0)
    /*if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE);*/
    if(mappages(new, i, PGSIZE, (uint64)pa, flags) != 0){
    80003174:	fd442783          	lw	a5,-44(s0)
    80003178:	873e                	mv	a4,a5
    8000317a:	fd843683          	ld	a3,-40(s0)
    8000317e:	6605                	lui	a2,0x1
    80003180:	fe843583          	ld	a1,-24(s0)
    80003184:	fc043503          	ld	a0,-64(s0)
    80003188:	fffff097          	auipc	ra,0xfffff
    8000318c:	ade080e7          	jalr	-1314(ra) # 80001c66 <mappages>
    80003190:	87aa                	mv	a5,a0
    80003192:	e395                	bnez	a5,800031b6 <growproc_thread+0xca>
  for(i = sz; i < sz + n; i += PGSIZE){
    80003194:	fe843703          	ld	a4,-24(s0)
    80003198:	6785                	lui	a5,0x1
    8000319a:	97ba                	add	a5,a5,a4
    8000319c:	fef43423          	sd	a5,-24(s0)
    800031a0:	fb442703          	lw	a4,-76(s0)
    800031a4:	fb843783          	ld	a5,-72(s0)
    800031a8:	97ba                	add	a5,a5,a4
    800031aa:	fe843703          	ld	a4,-24(s0)
    800031ae:	f6f761e3          	bltu	a4,a5,80003110 <growproc_thread+0x24>
      goto err;
    }
  }
  return 0;
    800031b2:	4781                	li	a5,0
    800031b4:	a839                	j	800031d2 <growproc_thread+0xe6>
      goto err;
    800031b6:	0001                	nop

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    800031b8:	fe843783          	ld	a5,-24(s0)
    800031bc:	83b1                	srli	a5,a5,0xc
    800031be:	4685                	li	a3,1
    800031c0:	863e                	mv	a2,a5
    800031c2:	4581                	li	a1,0
    800031c4:	fc043503          	ld	a0,-64(s0)
    800031c8:	fffff097          	auipc	ra,0xfffff
    800031cc:	b7c080e7          	jalr	-1156(ra) # 80001d44 <uvmunmap>
  return -1;
    800031d0:	57fd                	li	a5,-1
}
    800031d2:	853e                	mv	a0,a5
    800031d4:	60a6                	ld	ra,72(sp)
    800031d6:	6406                	ld	s0,64(sp)
    800031d8:	6161                	addi	sp,sp,80
    800031da:	8082                	ret

00000000800031dc <fork>:

// Create a new process, copying the parent.
// Sets up child kernel stack to return as if from fork() system call.
int
fork(void)
{
    800031dc:	7179                	addi	sp,sp,-48
    800031de:	f406                	sd	ra,40(sp)
    800031e0:	f022                	sd	s0,32(sp)
    800031e2:	1800                	addi	s0,sp,48
  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    800031e4:	00000097          	auipc	ra,0x0
    800031e8:	834080e7          	jalr	-1996(ra) # 80002a18 <myproc>
    800031ec:	fea43023          	sd	a0,-32(s0)

  // Allocate process.
  if((np = allocproc()) == 0){
    800031f0:	00000097          	auipc	ra,0x0
    800031f4:	8c2080e7          	jalr	-1854(ra) # 80002ab2 <allocproc>
    800031f8:	fca43c23          	sd	a0,-40(s0)
    800031fc:	fd843783          	ld	a5,-40(s0)
    80003200:	e399                	bnez	a5,80003206 <fork+0x2a>
    return -1;
    80003202:	57fd                	li	a5,-1
    80003204:	aab5                	j	80003380 <fork+0x1a4>
  }

  // Copy user memory from parent to child.
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80003206:	fe043783          	ld	a5,-32(s0)
    8000320a:	6bb8                	ld	a4,80(a5)
    8000320c:	fd843783          	ld	a5,-40(s0)
    80003210:	6bb4                	ld	a3,80(a5)
    80003212:	fe043783          	ld	a5,-32(s0)
    80003216:	67bc                	ld	a5,72(a5)
    80003218:	863e                	mv	a2,a5
    8000321a:	85b6                	mv	a1,a3
    8000321c:	853a                	mv	a0,a4
    8000321e:	fffff097          	auipc	ra,0xfffff
    80003222:	f5e080e7          	jalr	-162(ra) # 8000217c <uvmcopy>
    80003226:	87aa                	mv	a5,a0
    80003228:	0207d163          	bgez	a5,8000324a <fork+0x6e>
    freeproc(np);
    8000322c:	fd843503          	ld	a0,-40(s0)
    80003230:	00000097          	auipc	ra,0x0
    80003234:	9ec080e7          	jalr	-1556(ra) # 80002c1c <freeproc>
    release(&np->lock);
    80003238:	fd843783          	ld	a5,-40(s0)
    8000323c:	853e                	mv	a0,a5
    8000323e:	ffffe097          	auipc	ra,0xffffe
    80003242:	090080e7          	jalr	144(ra) # 800012ce <release>
    return -1;
    80003246:	57fd                	li	a5,-1
    80003248:	aa25                	j	80003380 <fork+0x1a4>
  }
  np->sz = p->sz;
    8000324a:	fe043783          	ld	a5,-32(s0)
    8000324e:	67b8                	ld	a4,72(a5)
    80003250:	fd843783          	ld	a5,-40(s0)
    80003254:	e7b8                	sd	a4,72(a5)

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    80003256:	fe043783          	ld	a5,-32(s0)
    8000325a:	73b8                	ld	a4,96(a5)
    8000325c:	fd843783          	ld	a5,-40(s0)
    80003260:	73bc                	ld	a5,96(a5)
    80003262:	86be                	mv	a3,a5
    80003264:	12000793          	li	a5,288
    80003268:	863e                	mv	a2,a5
    8000326a:	85ba                	mv	a1,a4
    8000326c:	8536                	mv	a0,a3
    8000326e:	ffffe097          	auipc	ra,0xffffe
    80003272:	390080e7          	jalr	912(ra) # 800015fe <memcpy>


  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;
    80003276:	fd843783          	ld	a5,-40(s0)
    8000327a:	73bc                	ld	a5,96(a5)
    8000327c:	0607b823          	sd	zero,112(a5) # 1070 <_entry-0x7fffef90>

  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    80003280:	fe042623          	sw	zero,-20(s0)
    80003284:	a0a9                	j	800032ce <fork+0xf2>
    if(p->ofile[i])
    80003286:	fe043703          	ld	a4,-32(s0)
    8000328a:	fec42783          	lw	a5,-20(s0)
    8000328e:	07f1                	addi	a5,a5,28
    80003290:	078e                	slli	a5,a5,0x3
    80003292:	97ba                	add	a5,a5,a4
    80003294:	639c                	ld	a5,0(a5)
    80003296:	c79d                	beqz	a5,800032c4 <fork+0xe8>
      np->ofile[i] = filedup(p->ofile[i]);
    80003298:	fe043703          	ld	a4,-32(s0)
    8000329c:	fec42783          	lw	a5,-20(s0)
    800032a0:	07f1                	addi	a5,a5,28
    800032a2:	078e                	slli	a5,a5,0x3
    800032a4:	97ba                	add	a5,a5,a4
    800032a6:	639c                	ld	a5,0(a5)
    800032a8:	853e                	mv	a0,a5
    800032aa:	00004097          	auipc	ra,0x4
    800032ae:	0f0080e7          	jalr	240(ra) # 8000739a <filedup>
    800032b2:	86aa                	mv	a3,a0
    800032b4:	fd843703          	ld	a4,-40(s0)
    800032b8:	fec42783          	lw	a5,-20(s0)
    800032bc:	07f1                	addi	a5,a5,28
    800032be:	078e                	slli	a5,a5,0x3
    800032c0:	97ba                	add	a5,a5,a4
    800032c2:	e394                	sd	a3,0(a5)
  for(i = 0; i < NOFILE; i++)
    800032c4:	fec42783          	lw	a5,-20(s0)
    800032c8:	2785                	addiw	a5,a5,1
    800032ca:	fef42623          	sw	a5,-20(s0)
    800032ce:	fec42783          	lw	a5,-20(s0)
    800032d2:	0007871b          	sext.w	a4,a5
    800032d6:	47bd                	li	a5,15
    800032d8:	fae7d7e3          	bge	a5,a4,80003286 <fork+0xaa>
  np->cwd = idup(p->cwd);
    800032dc:	fe043783          	ld	a5,-32(s0)
    800032e0:	1607b783          	ld	a5,352(a5)
    800032e4:	853e                	mv	a0,a5
    800032e6:	00003097          	auipc	ra,0x3
    800032ea:	9cc080e7          	jalr	-1588(ra) # 80005cb2 <idup>
    800032ee:	872a                	mv	a4,a0
    800032f0:	fd843783          	ld	a5,-40(s0)
    800032f4:	16e7b023          	sd	a4,352(a5)

  safestrcpy(np->name, p->name, sizeof(p->name));
    800032f8:	fd843783          	ld	a5,-40(s0)
    800032fc:	16878713          	addi	a4,a5,360
    80003300:	fe043783          	ld	a5,-32(s0)
    80003304:	16878793          	addi	a5,a5,360
    80003308:	4641                	li	a2,16
    8000330a:	85be                	mv	a1,a5
    8000330c:	853a                	mv	a0,a4
    8000330e:	ffffe097          	auipc	ra,0xffffe
    80003312:	434080e7          	jalr	1076(ra) # 80001742 <safestrcpy>

  pid = np->pid;
    80003316:	fd843783          	ld	a5,-40(s0)
    8000331a:	5b9c                	lw	a5,48(a5)
    8000331c:	fcf42a23          	sw	a5,-44(s0)

  release(&np->lock);
    80003320:	fd843783          	ld	a5,-40(s0)
    80003324:	853e                	mv	a0,a5
    80003326:	ffffe097          	auipc	ra,0xffffe
    8000332a:	fa8080e7          	jalr	-88(ra) # 800012ce <release>

  acquire(&wait_lock);
    8000332e:	00497517          	auipc	a0,0x497
    80003332:	78250513          	addi	a0,a0,1922 # 8049aab0 <wait_lock>
    80003336:	ffffe097          	auipc	ra,0xffffe
    8000333a:	f34080e7          	jalr	-204(ra) # 8000126a <acquire>
  np->parent = p;
    8000333e:	fd843783          	ld	a5,-40(s0)
    80003342:	fe043703          	ld	a4,-32(s0)
    80003346:	ff98                	sd	a4,56(a5)
  release(&wait_lock);
    80003348:	00497517          	auipc	a0,0x497
    8000334c:	76850513          	addi	a0,a0,1896 # 8049aab0 <wait_lock>
    80003350:	ffffe097          	auipc	ra,0xffffe
    80003354:	f7e080e7          	jalr	-130(ra) # 800012ce <release>

  acquire(&np->lock);
    80003358:	fd843783          	ld	a5,-40(s0)
    8000335c:	853e                	mv	a0,a5
    8000335e:	ffffe097          	auipc	ra,0xffffe
    80003362:	f0c080e7          	jalr	-244(ra) # 8000126a <acquire>
  np->state = RUNNABLE;
    80003366:	fd843783          	ld	a5,-40(s0)
    8000336a:	470d                	li	a4,3
    8000336c:	cf98                	sw	a4,24(a5)
  release(&np->lock);
    8000336e:	fd843783          	ld	a5,-40(s0)
    80003372:	853e                	mv	a0,a5
    80003374:	ffffe097          	auipc	ra,0xffffe
    80003378:	f5a080e7          	jalr	-166(ra) # 800012ce <release>

  return pid;
    8000337c:	fd442783          	lw	a5,-44(s0)
}
    80003380:	853e                	mv	a0,a5
    80003382:	70a2                	ld	ra,40(sp)
    80003384:	7402                	ld	s0,32(sp)
    80003386:	6145                	addi	sp,sp,48
    80003388:	8082                	ret

000000008000338a <reparent>:

// Pass p's abandoned children to init.
// Caller must hold wait_lock.
void
reparent(struct proc *p)
{
    8000338a:	7179                	addi	sp,sp,-48
    8000338c:	f406                	sd	ra,40(sp)
    8000338e:	f022                	sd	s0,32(sp)
    80003390:	1800                	addi	s0,sp,48
    80003392:	fca43c23          	sd	a0,-40(s0)
  struct proc *pp;

  for(pp = proc; pp < &proc[NPROC]; pp++){
    80003396:	00011797          	auipc	a5,0x11
    8000339a:	30278793          	addi	a5,a5,770 # 80014698 <proc>
    8000339e:	fef43423          	sd	a5,-24(s0)
    800033a2:	a091                	j	800033e6 <reparent+0x5c>
    if(pp->parent == p){
    800033a4:	fe843783          	ld	a5,-24(s0)
    800033a8:	7f9c                	ld	a5,56(a5)
    800033aa:	fd843703          	ld	a4,-40(s0)
    800033ae:	02f71463          	bne	a4,a5,800033d6 <reparent+0x4c>
      pp->parent = initproc;
    800033b2:	00009797          	auipc	a5,0x9
    800033b6:	c6e78793          	addi	a5,a5,-914 # 8000c020 <initproc>
    800033ba:	6398                	ld	a4,0(a5)
    800033bc:	fe843783          	ld	a5,-24(s0)
    800033c0:	ff98                	sd	a4,56(a5)
      wakeup(initproc);
    800033c2:	00009797          	auipc	a5,0x9
    800033c6:	c5e78793          	addi	a5,a5,-930 # 8000c020 <initproc>
    800033ca:	639c                	ld	a5,0(a5)
    800033cc:	853e                	mv	a0,a5
    800033ce:	00000097          	auipc	ra,0x0
    800033d2:	5b0080e7          	jalr	1456(ra) # 8000397e <wakeup>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800033d6:	fe843703          	ld	a4,-24(s0)
    800033da:	67c9                	lui	a5,0x12
    800033dc:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    800033e0:	97ba                	add	a5,a5,a4
    800033e2:	fef43423          	sd	a5,-24(s0)
    800033e6:	fe843703          	ld	a4,-24(s0)
    800033ea:	00497797          	auipc	a5,0x497
    800033ee:	6ae78793          	addi	a5,a5,1710 # 8049aa98 <pid_lock>
    800033f2:	faf769e3          	bltu	a4,a5,800033a4 <reparent+0x1a>
    }
  }
}
    800033f6:	0001                	nop
    800033f8:	0001                	nop
    800033fa:	70a2                	ld	ra,40(sp)
    800033fc:	7402                	ld	s0,32(sp)
    800033fe:	6145                	addi	sp,sp,48
    80003400:	8082                	ret

0000000080003402 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait().
void
exit(int status)
{
    80003402:	7139                	addi	sp,sp,-64
    80003404:	fc06                	sd	ra,56(sp)
    80003406:	f822                	sd	s0,48(sp)
    80003408:	0080                	addi	s0,sp,64
    8000340a:	87aa                	mv	a5,a0
    8000340c:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    80003410:	fffff097          	auipc	ra,0xfffff
    80003414:	608080e7          	jalr	1544(ra) # 80002a18 <myproc>
    80003418:	fea43023          	sd	a0,-32(s0)

  if(p == initproc)
    8000341c:	00009797          	auipc	a5,0x9
    80003420:	c0478793          	addi	a5,a5,-1020 # 8000c020 <initproc>
    80003424:	639c                	ld	a5,0(a5)
    80003426:	fe043703          	ld	a4,-32(s0)
    8000342a:	00f71a63          	bne	a4,a5,8000343e <exit+0x3c>
    panic("init exiting");
    8000342e:	00008517          	auipc	a0,0x8
    80003432:	e6a50513          	addi	a0,a0,-406 # 8000b298 <etext+0x298>
    80003436:	ffffe097          	auipc	ra,0xffffe
    8000343a:	844080e7          	jalr	-1980(ra) # 80000c7a <panic>

  // Close all open files.
  for(int fd = 0; fd < NOFILE; fd++){
    8000343e:	fe042623          	sw	zero,-20(s0)
    80003442:	a881                	j	80003492 <exit+0x90>
    if(p->ofile[fd]){
    80003444:	fe043703          	ld	a4,-32(s0)
    80003448:	fec42783          	lw	a5,-20(s0)
    8000344c:	07f1                	addi	a5,a5,28
    8000344e:	078e                	slli	a5,a5,0x3
    80003450:	97ba                	add	a5,a5,a4
    80003452:	639c                	ld	a5,0(a5)
    80003454:	cb95                	beqz	a5,80003488 <exit+0x86>
      struct file *f = p->ofile[fd];
    80003456:	fe043703          	ld	a4,-32(s0)
    8000345a:	fec42783          	lw	a5,-20(s0)
    8000345e:	07f1                	addi	a5,a5,28
    80003460:	078e                	slli	a5,a5,0x3
    80003462:	97ba                	add	a5,a5,a4
    80003464:	639c                	ld	a5,0(a5)
    80003466:	fcf43c23          	sd	a5,-40(s0)
      fileclose(f);
    8000346a:	fd843503          	ld	a0,-40(s0)
    8000346e:	00004097          	auipc	ra,0x4
    80003472:	f92080e7          	jalr	-110(ra) # 80007400 <fileclose>
      p->ofile[fd] = 0;
    80003476:	fe043703          	ld	a4,-32(s0)
    8000347a:	fec42783          	lw	a5,-20(s0)
    8000347e:	07f1                	addi	a5,a5,28
    80003480:	078e                	slli	a5,a5,0x3
    80003482:	97ba                	add	a5,a5,a4
    80003484:	0007b023          	sd	zero,0(a5)
  for(int fd = 0; fd < NOFILE; fd++){
    80003488:	fec42783          	lw	a5,-20(s0)
    8000348c:	2785                	addiw	a5,a5,1
    8000348e:	fef42623          	sw	a5,-20(s0)
    80003492:	fec42783          	lw	a5,-20(s0)
    80003496:	0007871b          	sext.w	a4,a5
    8000349a:	47bd                	li	a5,15
    8000349c:	fae7d4e3          	bge	a5,a4,80003444 <exit+0x42>
    }
  }

  begin_op();
    800034a0:	00004097          	auipc	ra,0x4
    800034a4:	8c6080e7          	jalr	-1850(ra) # 80006d66 <begin_op>
  iput(p->cwd);
    800034a8:	fe043783          	ld	a5,-32(s0)
    800034ac:	1607b783          	ld	a5,352(a5)
    800034b0:	853e                	mv	a0,a5
    800034b2:	00003097          	auipc	ra,0x3
    800034b6:	9da080e7          	jalr	-1574(ra) # 80005e8c <iput>
  end_op();
    800034ba:	00004097          	auipc	ra,0x4
    800034be:	96e080e7          	jalr	-1682(ra) # 80006e28 <end_op>
  p->cwd = 0;
    800034c2:	fe043783          	ld	a5,-32(s0)
    800034c6:	1607b023          	sd	zero,352(a5)

  acquire(&wait_lock);
    800034ca:	00497517          	auipc	a0,0x497
    800034ce:	5e650513          	addi	a0,a0,1510 # 8049aab0 <wait_lock>
    800034d2:	ffffe097          	auipc	ra,0xffffe
    800034d6:	d98080e7          	jalr	-616(ra) # 8000126a <acquire>

  // Give any children to init.
  reparent(p);
    800034da:	fe043503          	ld	a0,-32(s0)
    800034de:	00000097          	auipc	ra,0x0
    800034e2:	eac080e7          	jalr	-340(ra) # 8000338a <reparent>

  // Parent might be sleeping in wait().
  wakeup(p->parent);
    800034e6:	fe043783          	ld	a5,-32(s0)
    800034ea:	7f9c                	ld	a5,56(a5)
    800034ec:	853e                	mv	a0,a5
    800034ee:	00000097          	auipc	ra,0x0
    800034f2:	490080e7          	jalr	1168(ra) # 8000397e <wakeup>
  
  acquire(&p->lock);
    800034f6:	fe043783          	ld	a5,-32(s0)
    800034fa:	853e                	mv	a0,a5
    800034fc:	ffffe097          	auipc	ra,0xffffe
    80003500:	d6e080e7          	jalr	-658(ra) # 8000126a <acquire>

  p->xstate = status;
    80003504:	fe043783          	ld	a5,-32(s0)
    80003508:	fcc42703          	lw	a4,-52(s0)
    8000350c:	d7d8                	sw	a4,44(a5)
  p->state = ZOMBIE;
    8000350e:	fe043783          	ld	a5,-32(s0)
    80003512:	4715                	li	a4,5
    80003514:	cf98                	sw	a4,24(a5)

  release(&wait_lock);
    80003516:	00497517          	auipc	a0,0x497
    8000351a:	59a50513          	addi	a0,a0,1434 # 8049aab0 <wait_lock>
    8000351e:	ffffe097          	auipc	ra,0xffffe
    80003522:	db0080e7          	jalr	-592(ra) # 800012ce <release>

  // Jump into the scheduler, never to return.
  sched();
    80003526:	00000097          	auipc	ra,0x0
    8000352a:	260080e7          	jalr	608(ra) # 80003786 <sched>
  panic("zombie exit");
    8000352e:	00008517          	auipc	a0,0x8
    80003532:	d7a50513          	addi	a0,a0,-646 # 8000b2a8 <etext+0x2a8>
    80003536:	ffffd097          	auipc	ra,0xffffd
    8000353a:	744080e7          	jalr	1860(ra) # 80000c7a <panic>

000000008000353e <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(uint64 addr)
{
    8000353e:	7139                	addi	sp,sp,-64
    80003540:	fc06                	sd	ra,56(sp)
    80003542:	f822                	sd	s0,48(sp)
    80003544:	0080                	addi	s0,sp,64
    80003546:	fca43423          	sd	a0,-56(s0)
  struct proc *np;
  int havekids, pid;
  struct proc *p = myproc();
    8000354a:	fffff097          	auipc	ra,0xfffff
    8000354e:	4ce080e7          	jalr	1230(ra) # 80002a18 <myproc>
    80003552:	fca43c23          	sd	a0,-40(s0)

  acquire(&wait_lock);
    80003556:	00497517          	auipc	a0,0x497
    8000355a:	55a50513          	addi	a0,a0,1370 # 8049aab0 <wait_lock>
    8000355e:	ffffe097          	auipc	ra,0xffffe
    80003562:	d0c080e7          	jalr	-756(ra) # 8000126a <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    80003566:	fe042223          	sw	zero,-28(s0)
    for(np = proc; np < &proc[NPROC]; np++){
    8000356a:	00011797          	auipc	a5,0x11
    8000356e:	12e78793          	addi	a5,a5,302 # 80014698 <proc>
    80003572:	fef43423          	sd	a5,-24(s0)
    80003576:	a221                	j	8000367e <wait+0x140>
      if(np->parent == p && !np->thread){ //Proceso hijo no puede compartir el espacio de direcciones el padre
    80003578:	fe843783          	ld	a5,-24(s0)
    8000357c:	7f9c                	ld	a5,56(a5)
    8000357e:	fd843703          	ld	a4,-40(s0)
    80003582:	0ef71663          	bne	a4,a5,8000366e <wait+0x130>
    80003586:	fe843703          	ld	a4,-24(s0)
    8000358a:	67c9                	lui	a5,0x12
    8000358c:	97ba                	add	a5,a5,a4
    8000358e:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    80003592:	eff1                	bnez	a5,8000366e <wait+0x130>
        // make sure the child isn't still in exit() or swtch().
        acquire(&np->lock);
    80003594:	fe843783          	ld	a5,-24(s0)
    80003598:	853e                	mv	a0,a5
    8000359a:	ffffe097          	auipc	ra,0xffffe
    8000359e:	cd0080e7          	jalr	-816(ra) # 8000126a <acquire>

        havekids = 1;
    800035a2:	4785                	li	a5,1
    800035a4:	fef42223          	sw	a5,-28(s0)
        if(np->state == ZOMBIE){ 
    800035a8:	fe843783          	ld	a5,-24(s0)
    800035ac:	4f9c                	lw	a5,24(a5)
    800035ae:	873e                	mv	a4,a5
    800035b0:	4795                	li	a5,5
    800035b2:	0af71763          	bne	a4,a5,80003660 <wait+0x122>
          // Found one.
          pid = np->pid;
    800035b6:	fe843783          	ld	a5,-24(s0)
    800035ba:	5b9c                	lw	a5,48(a5)
    800035bc:	fcf42a23          	sw	a5,-44(s0)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    800035c0:	fc843783          	ld	a5,-56(s0)
    800035c4:	c7a9                	beqz	a5,8000360e <wait+0xd0>
    800035c6:	fd843783          	ld	a5,-40(s0)
    800035ca:	6bb8                	ld	a4,80(a5)
    800035cc:	fe843783          	ld	a5,-24(s0)
    800035d0:	02c78793          	addi	a5,a5,44
    800035d4:	4691                	li	a3,4
    800035d6:	863e                	mv	a2,a5
    800035d8:	fc843583          	ld	a1,-56(s0)
    800035dc:	853a                	mv	a0,a4
    800035de:	fffff097          	auipc	ra,0xfffff
    800035e2:	de8080e7          	jalr	-536(ra) # 800023c6 <copyout>
    800035e6:	87aa                	mv	a5,a0
    800035e8:	0207d363          	bgez	a5,8000360e <wait+0xd0>
                                  sizeof(np->xstate)) < 0) {
            release(&np->lock);
    800035ec:	fe843783          	ld	a5,-24(s0)
    800035f0:	853e                	mv	a0,a5
    800035f2:	ffffe097          	auipc	ra,0xffffe
    800035f6:	cdc080e7          	jalr	-804(ra) # 800012ce <release>
            release(&wait_lock);
    800035fa:	00497517          	auipc	a0,0x497
    800035fe:	4b650513          	addi	a0,a0,1206 # 8049aab0 <wait_lock>
    80003602:	ffffe097          	auipc	ra,0xffffe
    80003606:	ccc080e7          	jalr	-820(ra) # 800012ce <release>
            return -1;
    8000360a:	57fd                	li	a5,-1
    8000360c:	a875                	j	800036c8 <wait+0x18a>
          }
          
          if (np->thread == 1){
    8000360e:	fe843703          	ld	a4,-24(s0)
    80003612:	67c9                	lui	a5,0x12
    80003614:	97ba                	add	a5,a5,a4
    80003616:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    8000361a:	873e                	mv	a4,a5
    8000361c:	4785                	li	a5,1
    8000361e:	00f71963          	bne	a4,a5,80003630 <wait+0xf2>
            freethread(np);
    80003622:	fe843503          	ld	a0,-24(s0)
    80003626:	fffff097          	auipc	ra,0xfffff
    8000362a:	694080e7          	jalr	1684(ra) # 80002cba <freethread>
    8000362e:	a039                	j	8000363c <wait+0xfe>
          } else {
              freeproc(np);
    80003630:	fe843503          	ld	a0,-24(s0)
    80003634:	fffff097          	auipc	ra,0xfffff
    80003638:	5e8080e7          	jalr	1512(ra) # 80002c1c <freeproc>
          }

          release(&np->lock);
    8000363c:	fe843783          	ld	a5,-24(s0)
    80003640:	853e                	mv	a0,a5
    80003642:	ffffe097          	auipc	ra,0xffffe
    80003646:	c8c080e7          	jalr	-884(ra) # 800012ce <release>
          release(&wait_lock);
    8000364a:	00497517          	auipc	a0,0x497
    8000364e:	46650513          	addi	a0,a0,1126 # 8049aab0 <wait_lock>
    80003652:	ffffe097          	auipc	ra,0xffffe
    80003656:	c7c080e7          	jalr	-900(ra) # 800012ce <release>
          return pid;
    8000365a:	fd442783          	lw	a5,-44(s0)
    8000365e:	a0ad                	j	800036c8 <wait+0x18a>
        }
        release(&np->lock);
    80003660:	fe843783          	ld	a5,-24(s0)
    80003664:	853e                	mv	a0,a5
    80003666:	ffffe097          	auipc	ra,0xffffe
    8000366a:	c68080e7          	jalr	-920(ra) # 800012ce <release>
    for(np = proc; np < &proc[NPROC]; np++){
    8000366e:	fe843703          	ld	a4,-24(s0)
    80003672:	67c9                	lui	a5,0x12
    80003674:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80003678:	97ba                	add	a5,a5,a4
    8000367a:	fef43423          	sd	a5,-24(s0)
    8000367e:	fe843703          	ld	a4,-24(s0)
    80003682:	00497797          	auipc	a5,0x497
    80003686:	41678793          	addi	a5,a5,1046 # 8049aa98 <pid_lock>
    8000368a:	eef767e3          	bltu	a4,a5,80003578 <wait+0x3a>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || p->killed){
    8000368e:	fe442783          	lw	a5,-28(s0)
    80003692:	2781                	sext.w	a5,a5
    80003694:	c789                	beqz	a5,8000369e <wait+0x160>
    80003696:	fd843783          	ld	a5,-40(s0)
    8000369a:	579c                	lw	a5,40(a5)
    8000369c:	cb99                	beqz	a5,800036b2 <wait+0x174>
      release(&wait_lock);
    8000369e:	00497517          	auipc	a0,0x497
    800036a2:	41250513          	addi	a0,a0,1042 # 8049aab0 <wait_lock>
    800036a6:	ffffe097          	auipc	ra,0xffffe
    800036aa:	c28080e7          	jalr	-984(ra) # 800012ce <release>
      return -1;
    800036ae:	57fd                	li	a5,-1
    800036b0:	a821                	j	800036c8 <wait+0x18a>
    }
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800036b2:	00497597          	auipc	a1,0x497
    800036b6:	3fe58593          	addi	a1,a1,1022 # 8049aab0 <wait_lock>
    800036ba:	fd843503          	ld	a0,-40(s0)
    800036be:	00000097          	auipc	ra,0x0
    800036c2:	244080e7          	jalr	580(ra) # 80003902 <sleep>
    havekids = 0;
    800036c6:	b545                	j	80003566 <wait+0x28>
  }
}
    800036c8:	853e                	mv	a0,a5
    800036ca:	70e2                	ld	ra,56(sp)
    800036cc:	7442                	ld	s0,48(sp)
    800036ce:	6121                	addi	sp,sp,64
    800036d0:	8082                	ret

00000000800036d2 <scheduler>:
//  - swtch to start running that process.
//  - eventually that process transfers control
//    via swtch back to the scheduler.
void
scheduler(void)
{
    800036d2:	1101                	addi	sp,sp,-32
    800036d4:	ec06                	sd	ra,24(sp)
    800036d6:	e822                	sd	s0,16(sp)
    800036d8:	1000                	addi	s0,sp,32
  struct proc *p;
  struct cpu *c = mycpu();
    800036da:	fffff097          	auipc	ra,0xfffff
    800036de:	304080e7          	jalr	772(ra) # 800029de <mycpu>
    800036e2:	fea43023          	sd	a0,-32(s0)
  
  c->proc = 0;
    800036e6:	fe043783          	ld	a5,-32(s0)
    800036ea:	0007b023          	sd	zero,0(a5)
  for(;;){
    // Avoid deadlock by ensuring that devices can interrupt.
    intr_on();
    800036ee:	fffff097          	auipc	ra,0xfffff
    800036f2:	0d2080e7          	jalr	210(ra) # 800027c0 <intr_on>

    for(p = proc; p < &proc[NPROC]; p++) {
    800036f6:	00011797          	auipc	a5,0x11
    800036fa:	fa278793          	addi	a5,a5,-94 # 80014698 <proc>
    800036fe:	fef43423          	sd	a5,-24(s0)
    80003702:	a88d                	j	80003774 <scheduler+0xa2>
      acquire(&p->lock);
    80003704:	fe843783          	ld	a5,-24(s0)
    80003708:	853e                	mv	a0,a5
    8000370a:	ffffe097          	auipc	ra,0xffffe
    8000370e:	b60080e7          	jalr	-1184(ra) # 8000126a <acquire>
      if(p->state == RUNNABLE) {
    80003712:	fe843783          	ld	a5,-24(s0)
    80003716:	4f9c                	lw	a5,24(a5)
    80003718:	873e                	mv	a4,a5
    8000371a:	478d                	li	a5,3
    8000371c:	02f71d63          	bne	a4,a5,80003756 <scheduler+0x84>
        // Switch to chosen process.  It is the process's job
        // to release its lock and then reacquire it
        // before jumping back to us.
        p->state = RUNNING;
    80003720:	fe843783          	ld	a5,-24(s0)
    80003724:	4711                	li	a4,4
    80003726:	cf98                	sw	a4,24(a5)
        c->proc = p;
    80003728:	fe043783          	ld	a5,-32(s0)
    8000372c:	fe843703          	ld	a4,-24(s0)
    80003730:	e398                	sd	a4,0(a5)
        swtch(&c->context, &p->context);
    80003732:	fe043783          	ld	a5,-32(s0)
    80003736:	00878713          	addi	a4,a5,8
    8000373a:	fe843783          	ld	a5,-24(s0)
    8000373e:	07078793          	addi	a5,a5,112
    80003742:	85be                	mv	a1,a5
    80003744:	853a                	mv	a0,a4
    80003746:	00001097          	auipc	ra,0x1
    8000374a:	b60080e7          	jalr	-1184(ra) # 800042a6 <swtch>

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
    8000374e:	fe043783          	ld	a5,-32(s0)
    80003752:	0007b023          	sd	zero,0(a5)
      }
      release(&p->lock);
    80003756:	fe843783          	ld	a5,-24(s0)
    8000375a:	853e                	mv	a0,a5
    8000375c:	ffffe097          	auipc	ra,0xffffe
    80003760:	b72080e7          	jalr	-1166(ra) # 800012ce <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80003764:	fe843703          	ld	a4,-24(s0)
    80003768:	67c9                	lui	a5,0x12
    8000376a:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    8000376e:	97ba                	add	a5,a5,a4
    80003770:	fef43423          	sd	a5,-24(s0)
    80003774:	fe843703          	ld	a4,-24(s0)
    80003778:	00497797          	auipc	a5,0x497
    8000377c:	32078793          	addi	a5,a5,800 # 8049aa98 <pid_lock>
    80003780:	f8f762e3          	bltu	a4,a5,80003704 <scheduler+0x32>
    intr_on();
    80003784:	b7ad                	j	800036ee <scheduler+0x1c>

0000000080003786 <sched>:
// be proc->intena and proc->noff, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
    80003786:	7179                	addi	sp,sp,-48
    80003788:	f406                	sd	ra,40(sp)
    8000378a:	f022                	sd	s0,32(sp)
    8000378c:	ec26                	sd	s1,24(sp)
    8000378e:	1800                	addi	s0,sp,48
  int intena;
  struct proc *p = myproc();
    80003790:	fffff097          	auipc	ra,0xfffff
    80003794:	288080e7          	jalr	648(ra) # 80002a18 <myproc>
    80003798:	fca43c23          	sd	a0,-40(s0)

  if(!holding(&p->lock))
    8000379c:	fd843783          	ld	a5,-40(s0)
    800037a0:	853e                	mv	a0,a5
    800037a2:	ffffe097          	auipc	ra,0xffffe
    800037a6:	b82080e7          	jalr	-1150(ra) # 80001324 <holding>
    800037aa:	87aa                	mv	a5,a0
    800037ac:	eb89                	bnez	a5,800037be <sched+0x38>
    panic("sched p->lock");
    800037ae:	00008517          	auipc	a0,0x8
    800037b2:	b0a50513          	addi	a0,a0,-1270 # 8000b2b8 <etext+0x2b8>
    800037b6:	ffffd097          	auipc	ra,0xffffd
    800037ba:	4c4080e7          	jalr	1220(ra) # 80000c7a <panic>
  if(mycpu()->noff != 1)
    800037be:	fffff097          	auipc	ra,0xfffff
    800037c2:	220080e7          	jalr	544(ra) # 800029de <mycpu>
    800037c6:	87aa                	mv	a5,a0
    800037c8:	5fbc                	lw	a5,120(a5)
    800037ca:	873e                	mv	a4,a5
    800037cc:	4785                	li	a5,1
    800037ce:	00f70a63          	beq	a4,a5,800037e2 <sched+0x5c>
    panic("sched locks");
    800037d2:	00008517          	auipc	a0,0x8
    800037d6:	af650513          	addi	a0,a0,-1290 # 8000b2c8 <etext+0x2c8>
    800037da:	ffffd097          	auipc	ra,0xffffd
    800037de:	4a0080e7          	jalr	1184(ra) # 80000c7a <panic>
  if(p->state == RUNNING)
    800037e2:	fd843783          	ld	a5,-40(s0)
    800037e6:	4f9c                	lw	a5,24(a5)
    800037e8:	873e                	mv	a4,a5
    800037ea:	4791                	li	a5,4
    800037ec:	00f71a63          	bne	a4,a5,80003800 <sched+0x7a>
    panic("sched running");
    800037f0:	00008517          	auipc	a0,0x8
    800037f4:	ae850513          	addi	a0,a0,-1304 # 8000b2d8 <etext+0x2d8>
    800037f8:	ffffd097          	auipc	ra,0xffffd
    800037fc:	482080e7          	jalr	1154(ra) # 80000c7a <panic>
  if(intr_get())
    80003800:	fffff097          	auipc	ra,0xfffff
    80003804:	fea080e7          	jalr	-22(ra) # 800027ea <intr_get>
    80003808:	87aa                	mv	a5,a0
    8000380a:	cb89                	beqz	a5,8000381c <sched+0x96>
    panic("sched interruptible");
    8000380c:	00008517          	auipc	a0,0x8
    80003810:	adc50513          	addi	a0,a0,-1316 # 8000b2e8 <etext+0x2e8>
    80003814:	ffffd097          	auipc	ra,0xffffd
    80003818:	466080e7          	jalr	1126(ra) # 80000c7a <panic>

  intena = mycpu()->intena;
    8000381c:	fffff097          	auipc	ra,0xfffff
    80003820:	1c2080e7          	jalr	450(ra) # 800029de <mycpu>
    80003824:	87aa                	mv	a5,a0
    80003826:	5ffc                	lw	a5,124(a5)
    80003828:	fcf42a23          	sw	a5,-44(s0)
  swtch(&p->context, &mycpu()->context);
    8000382c:	fd843783          	ld	a5,-40(s0)
    80003830:	07078493          	addi	s1,a5,112
    80003834:	fffff097          	auipc	ra,0xfffff
    80003838:	1aa080e7          	jalr	426(ra) # 800029de <mycpu>
    8000383c:	87aa                	mv	a5,a0
    8000383e:	07a1                	addi	a5,a5,8
    80003840:	85be                	mv	a1,a5
    80003842:	8526                	mv	a0,s1
    80003844:	00001097          	auipc	ra,0x1
    80003848:	a62080e7          	jalr	-1438(ra) # 800042a6 <swtch>
  mycpu()->intena = intena;
    8000384c:	fffff097          	auipc	ra,0xfffff
    80003850:	192080e7          	jalr	402(ra) # 800029de <mycpu>
    80003854:	872a                	mv	a4,a0
    80003856:	fd442783          	lw	a5,-44(s0)
    8000385a:	df7c                	sw	a5,124(a4)
}
    8000385c:	0001                	nop
    8000385e:	70a2                	ld	ra,40(sp)
    80003860:	7402                	ld	s0,32(sp)
    80003862:	64e2                	ld	s1,24(sp)
    80003864:	6145                	addi	sp,sp,48
    80003866:	8082                	ret

0000000080003868 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
    80003868:	1101                	addi	sp,sp,-32
    8000386a:	ec06                	sd	ra,24(sp)
    8000386c:	e822                	sd	s0,16(sp)
    8000386e:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80003870:	fffff097          	auipc	ra,0xfffff
    80003874:	1a8080e7          	jalr	424(ra) # 80002a18 <myproc>
    80003878:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    8000387c:	fe843783          	ld	a5,-24(s0)
    80003880:	853e                	mv	a0,a5
    80003882:	ffffe097          	auipc	ra,0xffffe
    80003886:	9e8080e7          	jalr	-1560(ra) # 8000126a <acquire>
  p->state = RUNNABLE;
    8000388a:	fe843783          	ld	a5,-24(s0)
    8000388e:	470d                	li	a4,3
    80003890:	cf98                	sw	a4,24(a5)
  sched();
    80003892:	00000097          	auipc	ra,0x0
    80003896:	ef4080e7          	jalr	-268(ra) # 80003786 <sched>
  release(&p->lock);
    8000389a:	fe843783          	ld	a5,-24(s0)
    8000389e:	853e                	mv	a0,a5
    800038a0:	ffffe097          	auipc	ra,0xffffe
    800038a4:	a2e080e7          	jalr	-1490(ra) # 800012ce <release>
}
    800038a8:	0001                	nop
    800038aa:	60e2                	ld	ra,24(sp)
    800038ac:	6442                	ld	s0,16(sp)
    800038ae:	6105                	addi	sp,sp,32
    800038b0:	8082                	ret

00000000800038b2 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    800038b2:	1141                	addi	sp,sp,-16
    800038b4:	e406                	sd	ra,8(sp)
    800038b6:	e022                	sd	s0,0(sp)
    800038b8:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    800038ba:	fffff097          	auipc	ra,0xfffff
    800038be:	15e080e7          	jalr	350(ra) # 80002a18 <myproc>
    800038c2:	87aa                	mv	a5,a0
    800038c4:	853e                	mv	a0,a5
    800038c6:	ffffe097          	auipc	ra,0xffffe
    800038ca:	a08080e7          	jalr	-1528(ra) # 800012ce <release>

  if (first) {
    800038ce:	00008797          	auipc	a5,0x8
    800038d2:	00678793          	addi	a5,a5,6 # 8000b8d4 <first.1>
    800038d6:	439c                	lw	a5,0(a5)
    800038d8:	cf81                	beqz	a5,800038f0 <forkret+0x3e>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    first = 0;
    800038da:	00008797          	auipc	a5,0x8
    800038de:	ffa78793          	addi	a5,a5,-6 # 8000b8d4 <first.1>
    800038e2:	0007a023          	sw	zero,0(a5)
    fsinit(ROOTDEV);
    800038e6:	4505                	li	a0,1
    800038e8:	00002097          	auipc	ra,0x2
    800038ec:	cbc080e7          	jalr	-836(ra) # 800055a4 <fsinit>
  }

  usertrapret();
    800038f0:	00001097          	auipc	ra,0x1
    800038f4:	d54080e7          	jalr	-684(ra) # 80004644 <usertrapret>
}
    800038f8:	0001                	nop
    800038fa:	60a2                	ld	ra,8(sp)
    800038fc:	6402                	ld	s0,0(sp)
    800038fe:	0141                	addi	sp,sp,16
    80003900:	8082                	ret

0000000080003902 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80003902:	7179                	addi	sp,sp,-48
    80003904:	f406                	sd	ra,40(sp)
    80003906:	f022                	sd	s0,32(sp)
    80003908:	1800                	addi	s0,sp,48
    8000390a:	fca43c23          	sd	a0,-40(s0)
    8000390e:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    80003912:	fffff097          	auipc	ra,0xfffff
    80003916:	106080e7          	jalr	262(ra) # 80002a18 <myproc>
    8000391a:	fea43423          	sd	a0,-24(s0)
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    8000391e:	fe843783          	ld	a5,-24(s0)
    80003922:	853e                	mv	a0,a5
    80003924:	ffffe097          	auipc	ra,0xffffe
    80003928:	946080e7          	jalr	-1722(ra) # 8000126a <acquire>
  release(lk);
    8000392c:	fd043503          	ld	a0,-48(s0)
    80003930:	ffffe097          	auipc	ra,0xffffe
    80003934:	99e080e7          	jalr	-1634(ra) # 800012ce <release>

  // Go to sleep.
  p->chan = chan;
    80003938:	fe843783          	ld	a5,-24(s0)
    8000393c:	fd843703          	ld	a4,-40(s0)
    80003940:	f398                	sd	a4,32(a5)
  p->state = SLEEPING;
    80003942:	fe843783          	ld	a5,-24(s0)
    80003946:	4709                	li	a4,2
    80003948:	cf98                	sw	a4,24(a5)

  sched();
    8000394a:	00000097          	auipc	ra,0x0
    8000394e:	e3c080e7          	jalr	-452(ra) # 80003786 <sched>

  // Tidy up.
  p->chan = 0;
    80003952:	fe843783          	ld	a5,-24(s0)
    80003956:	0207b023          	sd	zero,32(a5)

  // Reacquire original lock.
  release(&p->lock);
    8000395a:	fe843783          	ld	a5,-24(s0)
    8000395e:	853e                	mv	a0,a5
    80003960:	ffffe097          	auipc	ra,0xffffe
    80003964:	96e080e7          	jalr	-1682(ra) # 800012ce <release>
  acquire(lk);
    80003968:	fd043503          	ld	a0,-48(s0)
    8000396c:	ffffe097          	auipc	ra,0xffffe
    80003970:	8fe080e7          	jalr	-1794(ra) # 8000126a <acquire>
}
    80003974:	0001                	nop
    80003976:	70a2                	ld	ra,40(sp)
    80003978:	7402                	ld	s0,32(sp)
    8000397a:	6145                	addi	sp,sp,48
    8000397c:	8082                	ret

000000008000397e <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    8000397e:	7179                	addi	sp,sp,-48
    80003980:	f406                	sd	ra,40(sp)
    80003982:	f022                	sd	s0,32(sp)
    80003984:	1800                	addi	s0,sp,48
    80003986:	fca43c23          	sd	a0,-40(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    8000398a:	00011797          	auipc	a5,0x11
    8000398e:	d0e78793          	addi	a5,a5,-754 # 80014698 <proc>
    80003992:	fef43423          	sd	a5,-24(s0)
    80003996:	a095                	j	800039fa <wakeup+0x7c>
    if(p != myproc()){
    80003998:	fffff097          	auipc	ra,0xfffff
    8000399c:	080080e7          	jalr	128(ra) # 80002a18 <myproc>
    800039a0:	872a                	mv	a4,a0
    800039a2:	fe843783          	ld	a5,-24(s0)
    800039a6:	04e78263          	beq	a5,a4,800039ea <wakeup+0x6c>
      acquire(&p->lock);
    800039aa:	fe843783          	ld	a5,-24(s0)
    800039ae:	853e                	mv	a0,a5
    800039b0:	ffffe097          	auipc	ra,0xffffe
    800039b4:	8ba080e7          	jalr	-1862(ra) # 8000126a <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800039b8:	fe843783          	ld	a5,-24(s0)
    800039bc:	4f9c                	lw	a5,24(a5)
    800039be:	873e                	mv	a4,a5
    800039c0:	4789                	li	a5,2
    800039c2:	00f71d63          	bne	a4,a5,800039dc <wakeup+0x5e>
    800039c6:	fe843783          	ld	a5,-24(s0)
    800039ca:	739c                	ld	a5,32(a5)
    800039cc:	fd843703          	ld	a4,-40(s0)
    800039d0:	00f71663          	bne	a4,a5,800039dc <wakeup+0x5e>
        p->state = RUNNABLE;
    800039d4:	fe843783          	ld	a5,-24(s0)
    800039d8:	470d                	li	a4,3
    800039da:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    800039dc:	fe843783          	ld	a5,-24(s0)
    800039e0:	853e                	mv	a0,a5
    800039e2:	ffffe097          	auipc	ra,0xffffe
    800039e6:	8ec080e7          	jalr	-1812(ra) # 800012ce <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800039ea:	fe843703          	ld	a4,-24(s0)
    800039ee:	67c9                	lui	a5,0x12
    800039f0:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    800039f4:	97ba                	add	a5,a5,a4
    800039f6:	fef43423          	sd	a5,-24(s0)
    800039fa:	fe843703          	ld	a4,-24(s0)
    800039fe:	00497797          	auipc	a5,0x497
    80003a02:	09a78793          	addi	a5,a5,154 # 8049aa98 <pid_lock>
    80003a06:	f8f769e3          	bltu	a4,a5,80003998 <wakeup+0x1a>
    }
  }
}
    80003a0a:	0001                	nop
    80003a0c:	0001                	nop
    80003a0e:	70a2                	ld	ra,40(sp)
    80003a10:	7402                	ld	s0,32(sp)
    80003a12:	6145                	addi	sp,sp,48
    80003a14:	8082                	ret

0000000080003a16 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80003a16:	7179                	addi	sp,sp,-48
    80003a18:	f406                	sd	ra,40(sp)
    80003a1a:	f022                	sd	s0,32(sp)
    80003a1c:	1800                	addi	s0,sp,48
    80003a1e:	87aa                	mv	a5,a0
    80003a20:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80003a24:	00011797          	auipc	a5,0x11
    80003a28:	c7478793          	addi	a5,a5,-908 # 80014698 <proc>
    80003a2c:	fef43423          	sd	a5,-24(s0)
    80003a30:	a0bd                	j	80003a9e <kill+0x88>
    acquire(&p->lock);
    80003a32:	fe843783          	ld	a5,-24(s0)
    80003a36:	853e                	mv	a0,a5
    80003a38:	ffffe097          	auipc	ra,0xffffe
    80003a3c:	832080e7          	jalr	-1998(ra) # 8000126a <acquire>
    if(p->pid == pid){
    80003a40:	fe843783          	ld	a5,-24(s0)
    80003a44:	5b98                	lw	a4,48(a5)
    80003a46:	fdc42783          	lw	a5,-36(s0)
    80003a4a:	2781                	sext.w	a5,a5
    80003a4c:	02e79a63          	bne	a5,a4,80003a80 <kill+0x6a>
      p->killed = 1;
    80003a50:	fe843783          	ld	a5,-24(s0)
    80003a54:	4705                	li	a4,1
    80003a56:	d798                	sw	a4,40(a5)
      if(p->state == SLEEPING){
    80003a58:	fe843783          	ld	a5,-24(s0)
    80003a5c:	4f9c                	lw	a5,24(a5)
    80003a5e:	873e                	mv	a4,a5
    80003a60:	4789                	li	a5,2
    80003a62:	00f71663          	bne	a4,a5,80003a6e <kill+0x58>
        // Wake process from sleep().
        p->state = RUNNABLE;
    80003a66:	fe843783          	ld	a5,-24(s0)
    80003a6a:	470d                	li	a4,3
    80003a6c:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    80003a6e:	fe843783          	ld	a5,-24(s0)
    80003a72:	853e                	mv	a0,a5
    80003a74:	ffffe097          	auipc	ra,0xffffe
    80003a78:	85a080e7          	jalr	-1958(ra) # 800012ce <release>
      return 0;
    80003a7c:	4781                	li	a5,0
    80003a7e:	a80d                	j	80003ab0 <kill+0x9a>
    }
    release(&p->lock);
    80003a80:	fe843783          	ld	a5,-24(s0)
    80003a84:	853e                	mv	a0,a5
    80003a86:	ffffe097          	auipc	ra,0xffffe
    80003a8a:	848080e7          	jalr	-1976(ra) # 800012ce <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80003a8e:	fe843703          	ld	a4,-24(s0)
    80003a92:	67c9                	lui	a5,0x12
    80003a94:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80003a98:	97ba                	add	a5,a5,a4
    80003a9a:	fef43423          	sd	a5,-24(s0)
    80003a9e:	fe843703          	ld	a4,-24(s0)
    80003aa2:	00497797          	auipc	a5,0x497
    80003aa6:	ff678793          	addi	a5,a5,-10 # 8049aa98 <pid_lock>
    80003aaa:	f8f764e3          	bltu	a4,a5,80003a32 <kill+0x1c>
  }
  return -1;
    80003aae:	57fd                	li	a5,-1
}
    80003ab0:	853e                	mv	a0,a5
    80003ab2:	70a2                	ld	ra,40(sp)
    80003ab4:	7402                	ld	s0,32(sp)
    80003ab6:	6145                	addi	sp,sp,48
    80003ab8:	8082                	ret

0000000080003aba <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80003aba:	7139                	addi	sp,sp,-64
    80003abc:	fc06                	sd	ra,56(sp)
    80003abe:	f822                	sd	s0,48(sp)
    80003ac0:	0080                	addi	s0,sp,64
    80003ac2:	87aa                	mv	a5,a0
    80003ac4:	fcb43823          	sd	a1,-48(s0)
    80003ac8:	fcc43423          	sd	a2,-56(s0)
    80003acc:	fcd43023          	sd	a3,-64(s0)
    80003ad0:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80003ad4:	fffff097          	auipc	ra,0xfffff
    80003ad8:	f44080e7          	jalr	-188(ra) # 80002a18 <myproc>
    80003adc:	fea43423          	sd	a0,-24(s0)
  if(user_dst){
    80003ae0:	fdc42783          	lw	a5,-36(s0)
    80003ae4:	2781                	sext.w	a5,a5
    80003ae6:	c38d                	beqz	a5,80003b08 <either_copyout+0x4e>
    return copyout(p->pagetable, dst, src, len);
    80003ae8:	fe843783          	ld	a5,-24(s0)
    80003aec:	6bbc                	ld	a5,80(a5)
    80003aee:	fc043683          	ld	a3,-64(s0)
    80003af2:	fc843603          	ld	a2,-56(s0)
    80003af6:	fd043583          	ld	a1,-48(s0)
    80003afa:	853e                	mv	a0,a5
    80003afc:	fffff097          	auipc	ra,0xfffff
    80003b00:	8ca080e7          	jalr	-1846(ra) # 800023c6 <copyout>
    80003b04:	87aa                	mv	a5,a0
    80003b06:	a839                	j	80003b24 <either_copyout+0x6a>
  } else {
    memmove((char *)dst, src, len);
    80003b08:	fd043783          	ld	a5,-48(s0)
    80003b0c:	fc043703          	ld	a4,-64(s0)
    80003b10:	2701                	sext.w	a4,a4
    80003b12:	863a                	mv	a2,a4
    80003b14:	fc843583          	ld	a1,-56(s0)
    80003b18:	853e                	mv	a0,a5
    80003b1a:	ffffe097          	auipc	ra,0xffffe
    80003b1e:	a08080e7          	jalr	-1528(ra) # 80001522 <memmove>
    return 0;
    80003b22:	4781                	li	a5,0
  }
}
    80003b24:	853e                	mv	a0,a5
    80003b26:	70e2                	ld	ra,56(sp)
    80003b28:	7442                	ld	s0,48(sp)
    80003b2a:	6121                	addi	sp,sp,64
    80003b2c:	8082                	ret

0000000080003b2e <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80003b2e:	7139                	addi	sp,sp,-64
    80003b30:	fc06                	sd	ra,56(sp)
    80003b32:	f822                	sd	s0,48(sp)
    80003b34:	0080                	addi	s0,sp,64
    80003b36:	fca43c23          	sd	a0,-40(s0)
    80003b3a:	87ae                	mv	a5,a1
    80003b3c:	fcc43423          	sd	a2,-56(s0)
    80003b40:	fcd43023          	sd	a3,-64(s0)
    80003b44:	fcf42a23          	sw	a5,-44(s0)
  struct proc *p = myproc();
    80003b48:	fffff097          	auipc	ra,0xfffff
    80003b4c:	ed0080e7          	jalr	-304(ra) # 80002a18 <myproc>
    80003b50:	fea43423          	sd	a0,-24(s0)
  if(user_src){
    80003b54:	fd442783          	lw	a5,-44(s0)
    80003b58:	2781                	sext.w	a5,a5
    80003b5a:	c38d                	beqz	a5,80003b7c <either_copyin+0x4e>
    return copyin(p->pagetable, dst, src, len);
    80003b5c:	fe843783          	ld	a5,-24(s0)
    80003b60:	6bbc                	ld	a5,80(a5)
    80003b62:	fc043683          	ld	a3,-64(s0)
    80003b66:	fc843603          	ld	a2,-56(s0)
    80003b6a:	fd843583          	ld	a1,-40(s0)
    80003b6e:	853e                	mv	a0,a5
    80003b70:	fffff097          	auipc	ra,0xfffff
    80003b74:	924080e7          	jalr	-1756(ra) # 80002494 <copyin>
    80003b78:	87aa                	mv	a5,a0
    80003b7a:	a839                	j	80003b98 <either_copyin+0x6a>
  } else {
    memmove(dst, (char*)src, len);
    80003b7c:	fc843783          	ld	a5,-56(s0)
    80003b80:	fc043703          	ld	a4,-64(s0)
    80003b84:	2701                	sext.w	a4,a4
    80003b86:	863a                	mv	a2,a4
    80003b88:	85be                	mv	a1,a5
    80003b8a:	fd843503          	ld	a0,-40(s0)
    80003b8e:	ffffe097          	auipc	ra,0xffffe
    80003b92:	994080e7          	jalr	-1644(ra) # 80001522 <memmove>
    return 0;
    80003b96:	4781                	li	a5,0
  }
}
    80003b98:	853e                	mv	a0,a5
    80003b9a:	70e2                	ld	ra,56(sp)
    80003b9c:	7442                	ld	s0,48(sp)
    80003b9e:	6121                	addi	sp,sp,64
    80003ba0:	8082                	ret

0000000080003ba2 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80003ba2:	1101                	addi	sp,sp,-32
    80003ba4:	ec06                	sd	ra,24(sp)
    80003ba6:	e822                	sd	s0,16(sp)
    80003ba8:	1000                	addi	s0,sp,32
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80003baa:	00007517          	auipc	a0,0x7
    80003bae:	75650513          	addi	a0,a0,1878 # 8000b300 <etext+0x300>
    80003bb2:	ffffd097          	auipc	ra,0xffffd
    80003bb6:	e72080e7          	jalr	-398(ra) # 80000a24 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80003bba:	00011797          	auipc	a5,0x11
    80003bbe:	ade78793          	addi	a5,a5,-1314 # 80014698 <proc>
    80003bc2:	fef43423          	sd	a5,-24(s0)
    80003bc6:	a05d                	j	80003c6c <procdump+0xca>
    if(p->state == UNUSED)
    80003bc8:	fe843783          	ld	a5,-24(s0)
    80003bcc:	4f9c                	lw	a5,24(a5)
    80003bce:	c7d1                	beqz	a5,80003c5a <procdump+0xb8>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80003bd0:	fe843783          	ld	a5,-24(s0)
    80003bd4:	4f9c                	lw	a5,24(a5)
    80003bd6:	873e                	mv	a4,a5
    80003bd8:	4795                	li	a5,5
    80003bda:	02e7ee63          	bltu	a5,a4,80003c16 <procdump+0x74>
    80003bde:	fe843783          	ld	a5,-24(s0)
    80003be2:	4f9c                	lw	a5,24(a5)
    80003be4:	00008717          	auipc	a4,0x8
    80003be8:	d4c70713          	addi	a4,a4,-692 # 8000b930 <states.0>
    80003bec:	1782                	slli	a5,a5,0x20
    80003bee:	9381                	srli	a5,a5,0x20
    80003bf0:	078e                	slli	a5,a5,0x3
    80003bf2:	97ba                	add	a5,a5,a4
    80003bf4:	639c                	ld	a5,0(a5)
    80003bf6:	c385                	beqz	a5,80003c16 <procdump+0x74>
      state = states[p->state];
    80003bf8:	fe843783          	ld	a5,-24(s0)
    80003bfc:	4f9c                	lw	a5,24(a5)
    80003bfe:	00008717          	auipc	a4,0x8
    80003c02:	d3270713          	addi	a4,a4,-718 # 8000b930 <states.0>
    80003c06:	1782                	slli	a5,a5,0x20
    80003c08:	9381                	srli	a5,a5,0x20
    80003c0a:	078e                	slli	a5,a5,0x3
    80003c0c:	97ba                	add	a5,a5,a4
    80003c0e:	639c                	ld	a5,0(a5)
    80003c10:	fef43023          	sd	a5,-32(s0)
    80003c14:	a039                	j	80003c22 <procdump+0x80>
    else
      state = "???";
    80003c16:	00007797          	auipc	a5,0x7
    80003c1a:	6f278793          	addi	a5,a5,1778 # 8000b308 <etext+0x308>
    80003c1e:	fef43023          	sd	a5,-32(s0)
    printf("%d %s %s", p->pid, state, p->name);
    80003c22:	fe843783          	ld	a5,-24(s0)
    80003c26:	5b98                	lw	a4,48(a5)
    80003c28:	fe843783          	ld	a5,-24(s0)
    80003c2c:	16878793          	addi	a5,a5,360
    80003c30:	86be                	mv	a3,a5
    80003c32:	fe043603          	ld	a2,-32(s0)
    80003c36:	85ba                	mv	a1,a4
    80003c38:	00007517          	auipc	a0,0x7
    80003c3c:	6d850513          	addi	a0,a0,1752 # 8000b310 <etext+0x310>
    80003c40:	ffffd097          	auipc	ra,0xffffd
    80003c44:	de4080e7          	jalr	-540(ra) # 80000a24 <printf>
    printf("\n");
    80003c48:	00007517          	auipc	a0,0x7
    80003c4c:	6b850513          	addi	a0,a0,1720 # 8000b300 <etext+0x300>
    80003c50:	ffffd097          	auipc	ra,0xffffd
    80003c54:	dd4080e7          	jalr	-556(ra) # 80000a24 <printf>
    80003c58:	a011                	j	80003c5c <procdump+0xba>
      continue;
    80003c5a:	0001                	nop
  for(p = proc; p < &proc[NPROC]; p++){
    80003c5c:	fe843703          	ld	a4,-24(s0)
    80003c60:	67c9                	lui	a5,0x12
    80003c62:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80003c66:	97ba                	add	a5,a5,a4
    80003c68:	fef43423          	sd	a5,-24(s0)
    80003c6c:	fe843703          	ld	a4,-24(s0)
    80003c70:	00497797          	auipc	a5,0x497
    80003c74:	e2878793          	addi	a5,a5,-472 # 8049aa98 <pid_lock>
    80003c78:	f4f768e3          	bltu	a4,a5,80003bc8 <procdump+0x26>
  }
}
    80003c7c:	0001                	nop
    80003c7e:	0001                	nop
    80003c80:	60e2                	ld	ra,24(sp)
    80003c82:	6442                	ld	s0,16(sp)
    80003c84:	6105                	addi	sp,sp,32
    80003c86:	8082                	ret

0000000080003c88 <clone>:


int clone(void(*fcn)(void*), void *arg, void*stack)
{
    80003c88:	711d                	addi	sp,sp,-96
    80003c8a:	ec86                	sd	ra,88(sp)
    80003c8c:	e8a2                	sd	s0,80(sp)
    80003c8e:	1080                	addi	s0,sp,96
    80003c90:	faa43c23          	sd	a0,-72(s0)
    80003c94:	fab43823          	sd	a1,-80(s0)
    80003c98:	fac43423          	sd	a2,-88(s0)

  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    80003c9c:	fffff097          	auipc	ra,0xfffff
    80003ca0:	d7c080e7          	jalr	-644(ra) # 80002a18 <myproc>
    80003ca4:	fea43023          	sd	a0,-32(s0)

  // Allocate process.
  if((np = allocproc()) == 0){
    80003ca8:	fffff097          	auipc	ra,0xfffff
    80003cac:	e0a080e7          	jalr	-502(ra) # 80002ab2 <allocproc>
    80003cb0:	fca43c23          	sd	a0,-40(s0)
    80003cb4:	fd843783          	ld	a5,-40(s0)
    80003cb8:	e399                	bnez	a5,80003cbe <clone+0x36>
    return -1;
    80003cba:	57fd                	li	a5,-1
    80003cbc:	a45d                	j	80003f62 <clone+0x2da>
  }

  // Copy user memory from parent to child.
  if(uvmcopyThread(p->pagetable, np->pagetable, p->sz) < 0){
    80003cbe:	fe043783          	ld	a5,-32(s0)
    80003cc2:	6bb8                	ld	a4,80(a5)
    80003cc4:	fd843783          	ld	a5,-40(s0)
    80003cc8:	6bb4                	ld	a3,80(a5)
    80003cca:	fe043783          	ld	a5,-32(s0)
    80003cce:	67bc                	ld	a5,72(a5)
    80003cd0:	863e                	mv	a2,a5
    80003cd2:	85b6                	mv	a1,a3
    80003cd4:	853a                	mv	a0,a4
    80003cd6:	ffffe097          	auipc	ra,0xffffe
    80003cda:	5ba080e7          	jalr	1466(ra) # 80002290 <uvmcopyThread>
    80003cde:	87aa                	mv	a5,a0
    80003ce0:	0207d163          	bgez	a5,80003d02 <clone+0x7a>
    freeproc(np);
    80003ce4:	fd843503          	ld	a0,-40(s0)
    80003ce8:	fffff097          	auipc	ra,0xfffff
    80003cec:	f34080e7          	jalr	-204(ra) # 80002c1c <freeproc>
    release(&np->lock);
    80003cf0:	fd843783          	ld	a5,-40(s0)
    80003cf4:	853e                	mv	a0,a5
    80003cf6:	ffffd097          	auipc	ra,0xffffd
    80003cfa:	5d8080e7          	jalr	1496(ra) # 800012ce <release>
    return -1;
    80003cfe:	57fd                	li	a5,-1
    80003d00:	a48d                	j	80003f62 <clone+0x2da>
  }

   //comparten el mismo espacio de direcciones
  //np->pagetable = p->pagetable;

  np->thread = 1;
    80003d02:	fd843703          	ld	a4,-40(s0)
    80003d06:	67c9                	lui	a5,0x12
    80003d08:	97ba                	add	a5,a5,a4
    80003d0a:	4705                	li	a4,1
    80003d0c:	18e7a423          	sw	a4,392(a5) # 12188 <_entry-0x7ffede78>
  np->sz = p->sz;
    80003d10:	fe043783          	ld	a5,-32(s0)
    80003d14:	67b8                	ld	a4,72(a5)
    80003d16:	fd843783          	ld	a5,-40(s0)
    80003d1a:	e7b8                	sd	a4,72(a5)


  //ASID thread = PID padre
  np->ASID = p->ASID;
    80003d1c:	fe043783          	ld	a5,-32(s0)
    80003d20:	5bd8                	lw	a4,52(a5)
    80003d22:	fd843783          	ld	a5,-40(s0)
    80003d26:	dbd8                	sw	a4,52(a5)


  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    80003d28:	fe043783          	ld	a5,-32(s0)
    80003d2c:	73b8                	ld	a4,96(a5)
    80003d2e:	fd843783          	ld	a5,-40(s0)
    80003d32:	73bc                	ld	a5,96(a5)
    80003d34:	86be                	mv	a3,a5
    80003d36:	12000793          	li	a5,288
    80003d3a:	863e                	mv	a2,a5
    80003d3c:	85ba                	mv	a1,a4
    80003d3e:	8536                	mv	a0,a3
    80003d40:	ffffe097          	auipc	ra,0xffffe
    80003d44:	8be080e7          	jalr	-1858(ra) # 800015fe <memcpy>

  //indicamos al hijo que empiece ejecutando en la función
  np->trapframe->epc = (uint64) fcn;
    80003d48:	fd843783          	ld	a5,-40(s0)
    80003d4c:	73bc                	ld	a5,96(a5)
    80003d4e:	fb843703          	ld	a4,-72(s0)
    80003d52:	ef98                	sd	a4,24(a5)

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = (uint64)arg;
    80003d54:	fd843783          	ld	a5,-40(s0)
    80003d58:	73bc                	ld	a5,96(a5)
    80003d5a:	fb043703          	ld	a4,-80(s0)
    80003d5e:	fbb8                	sd	a4,112(a5)



  //Apuntamos al final del stack y luego vamos insertamos
  uint64 stack_args[2]; 
  stack_args[0] =  0xffffffff; 
    80003d60:	57fd                	li	a5,-1
    80003d62:	9381                	srli	a5,a5,0x20
    80003d64:	fcf43023          	sd	a5,-64(s0)
  stack_args[1] =  (uint64)arg;
    80003d68:	fb043783          	ld	a5,-80(s0)
    80003d6c:	fcf43423          	sd	a5,-56(s0)
  
  np->bottom_ustack = (uint64) stack; //base de stack, para liberar en join
    80003d70:	fa843703          	ld	a4,-88(s0)
    80003d74:	fd843683          	ld	a3,-40(s0)
    80003d78:	6789                	lui	a5,0x2
    80003d7a:	97b6                	add	a5,a5,a3
    80003d7c:	18e7b023          	sd	a4,384(a5) # 2180 <_entry-0x7fffde80>
  np->top_ustack = np->bottom_ustack + PGSIZE; //tope de stack
    80003d80:	fd843703          	ld	a4,-40(s0)
    80003d84:	6789                	lui	a5,0x2
    80003d86:	97ba                	add	a5,a5,a4
    80003d88:	1807b703          	ld	a4,384(a5) # 2180 <_entry-0x7fffde80>
    80003d8c:	6785                	lui	a5,0x1
    80003d8e:	973e                	add	a4,a4,a5
    80003d90:	fd843683          	ld	a3,-40(s0)
    80003d94:	6789                	lui	a5,0x2
    80003d96:	97b6                	add	a5,a5,a3
    80003d98:	16e7bc23          	sd	a4,376(a5) # 2178 <_entry-0x7fffde88>
  np->top_ustack -= 16;
    80003d9c:	fd843703          	ld	a4,-40(s0)
    80003da0:	6789                	lui	a5,0x2
    80003da2:	97ba                	add	a5,a5,a4
    80003da4:	1787b783          	ld	a5,376(a5) # 2178 <_entry-0x7fffde88>
    80003da8:	ff078713          	addi	a4,a5,-16
    80003dac:	fd843683          	ld	a3,-40(s0)
    80003db0:	6789                	lui	a5,0x2
    80003db2:	97b6                	add	a5,a5,a3
    80003db4:	16e7bc23          	sd	a4,376(a5) # 2178 <_entry-0x7fffde88>
  //np->top_ustack -=  np->top_ustack %16;


  printf ("Antes de hacer copyout.\n");
    80003db8:	00007517          	auipc	a0,0x7
    80003dbc:	56850513          	addi	a0,a0,1384 # 8000b320 <etext+0x320>
    80003dc0:	ffffd097          	auipc	ra,0xffffd
    80003dc4:	c64080e7          	jalr	-924(ra) # 80000a24 <printf>

  //copyout
  if (copyout(np->pagetable, np->top_ustack, (char *) stack_args, 16) < 0) {
    80003dc8:	fd843783          	ld	a5,-40(s0)
    80003dcc:	6ba8                	ld	a0,80(a5)
    80003dce:	fd843703          	ld	a4,-40(s0)
    80003dd2:	6789                	lui	a5,0x2
    80003dd4:	97ba                	add	a5,a5,a4
    80003dd6:	1787b783          	ld	a5,376(a5) # 2178 <_entry-0x7fffde88>
    80003dda:	fc040713          	addi	a4,s0,-64
    80003dde:	46c1                	li	a3,16
    80003de0:	863a                	mv	a2,a4
    80003de2:	85be                	mv	a1,a5
    80003de4:	ffffe097          	auipc	ra,0xffffe
    80003de8:	5e2080e7          	jalr	1506(ra) # 800023c6 <copyout>
    80003dec:	87aa                	mv	a5,a0
    80003dee:	0007db63          	bgez	a5,80003e04 <clone+0x17c>
     release(&np->lock);
    80003df2:	fd843783          	ld	a5,-40(s0)
    80003df6:	853e                	mv	a0,a5
    80003df8:	ffffd097          	auipc	ra,0xffffd
    80003dfc:	4d6080e7          	jalr	1238(ra) # 800012ce <release>
     //elease(&wait_lock);
        return -1;
    80003e00:	57fd                	li	a5,-1
    80003e02:	a285                	j	80003f62 <clone+0x2da>
    }



  printf ("Copyout correcto al stack del thread.\n");
    80003e04:	00007517          	auipc	a0,0x7
    80003e08:	53c50513          	addi	a0,a0,1340 # 8000b340 <etext+0x340>
    80003e0c:	ffffd097          	auipc	ra,0xffffd
    80003e10:	c18080e7          	jalr	-1000(ra) # 80000a24 <printf>

  //actualiza stack pointer
  np->trapframe->sp= np->top_ustack; 
    80003e14:	fd843783          	ld	a5,-40(s0)
    80003e18:	73bc                	ld	a5,96(a5)
    80003e1a:	fd843683          	ld	a3,-40(s0)
    80003e1e:	6709                	lui	a4,0x2
    80003e20:	9736                	add	a4,a4,a3
    80003e22:	17873703          	ld	a4,376(a4) # 2178 <_entry-0x7fffde88>
    80003e26:	fb98                	sd	a4,48(a5)



  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    80003e28:	fe042623          	sw	zero,-20(s0)
    80003e2c:	a0a9                	j	80003e76 <clone+0x1ee>
    if(p->ofile[i])
    80003e2e:	fe043703          	ld	a4,-32(s0)
    80003e32:	fec42783          	lw	a5,-20(s0)
    80003e36:	07f1                	addi	a5,a5,28
    80003e38:	078e                	slli	a5,a5,0x3
    80003e3a:	97ba                	add	a5,a5,a4
    80003e3c:	639c                	ld	a5,0(a5)
    80003e3e:	c79d                	beqz	a5,80003e6c <clone+0x1e4>
      np->ofile[i] = filedup(p->ofile[i]);
    80003e40:	fe043703          	ld	a4,-32(s0)
    80003e44:	fec42783          	lw	a5,-20(s0)
    80003e48:	07f1                	addi	a5,a5,28
    80003e4a:	078e                	slli	a5,a5,0x3
    80003e4c:	97ba                	add	a5,a5,a4
    80003e4e:	639c                	ld	a5,0(a5)
    80003e50:	853e                	mv	a0,a5
    80003e52:	00003097          	auipc	ra,0x3
    80003e56:	548080e7          	jalr	1352(ra) # 8000739a <filedup>
    80003e5a:	86aa                	mv	a3,a0
    80003e5c:	fd843703          	ld	a4,-40(s0)
    80003e60:	fec42783          	lw	a5,-20(s0)
    80003e64:	07f1                	addi	a5,a5,28
    80003e66:	078e                	slli	a5,a5,0x3
    80003e68:	97ba                	add	a5,a5,a4
    80003e6a:	e394                	sd	a3,0(a5)
  for(i = 0; i < NOFILE; i++)
    80003e6c:	fec42783          	lw	a5,-20(s0)
    80003e70:	2785                	addiw	a5,a5,1
    80003e72:	fef42623          	sw	a5,-20(s0)
    80003e76:	fec42783          	lw	a5,-20(s0)
    80003e7a:	0007871b          	sext.w	a4,a5
    80003e7e:	47bd                	li	a5,15
    80003e80:	fae7d7e3          	bge	a5,a4,80003e2e <clone+0x1a6>
  np->cwd = idup(p->cwd);
    80003e84:	fe043783          	ld	a5,-32(s0)
    80003e88:	1607b783          	ld	a5,352(a5)
    80003e8c:	853e                	mv	a0,a5
    80003e8e:	00002097          	auipc	ra,0x2
    80003e92:	e24080e7          	jalr	-476(ra) # 80005cb2 <idup>
    80003e96:	872a                	mv	a4,a0
    80003e98:	fd843783          	ld	a5,-40(s0)
    80003e9c:	16e7b023          	sd	a4,352(a5)

  safestrcpy(np->name, p->name, sizeof(p->name));
    80003ea0:	fd843783          	ld	a5,-40(s0)
    80003ea4:	16878713          	addi	a4,a5,360
    80003ea8:	fe043783          	ld	a5,-32(s0)
    80003eac:	16878793          	addi	a5,a5,360
    80003eb0:	4641                	li	a2,16
    80003eb2:	85be                	mv	a1,a5
    80003eb4:	853a                	mv	a0,a4
    80003eb6:	ffffe097          	auipc	ra,0xffffe
    80003eba:	88c080e7          	jalr	-1908(ra) # 80001742 <safestrcpy>

  pid = np->pid;
    80003ebe:	fd843783          	ld	a5,-40(s0)
    80003ec2:	5b9c                	lw	a5,48(a5)
    80003ec4:	fcf42a23          	sw	a5,-44(s0)

  release(&np->lock);
    80003ec8:	fd843783          	ld	a5,-40(s0)
    80003ecc:	853e                	mv	a0,a5
    80003ece:	ffffd097          	auipc	ra,0xffffd
    80003ed2:	400080e7          	jalr	1024(ra) # 800012ce <release>

  acquire(&wait_lock);
    80003ed6:	00497517          	auipc	a0,0x497
    80003eda:	bda50513          	addi	a0,a0,-1062 # 8049aab0 <wait_lock>
    80003ede:	ffffd097          	auipc	ra,0xffffd
    80003ee2:	38c080e7          	jalr	908(ra) # 8000126a <acquire>
  np->parent = p;
    80003ee6:	fd843783          	ld	a5,-40(s0)
    80003eea:	fe043703          	ld	a4,-32(s0)
    80003eee:	ff98                	sd	a4,56(a5)
  release(&wait_lock);
    80003ef0:	00497517          	auipc	a0,0x497
    80003ef4:	bc050513          	addi	a0,a0,-1088 # 8049aab0 <wait_lock>
    80003ef8:	ffffd097          	auipc	ra,0xffffd
    80003efc:	3d6080e7          	jalr	982(ra) # 800012ce <release>

  acquire(&p->lock);
    80003f00:	fe043783          	ld	a5,-32(s0)
    80003f04:	853e                	mv	a0,a5
    80003f06:	ffffd097          	auipc	ra,0xffffd
    80003f0a:	364080e7          	jalr	868(ra) # 8000126a <acquire>
  p->referencias++;
    80003f0e:	fe043703          	ld	a4,-32(s0)
    80003f12:	67c9                	lui	a5,0x12
    80003f14:	97ba                	add	a5,a5,a4
    80003f16:	18c7a783          	lw	a5,396(a5) # 1218c <_entry-0x7ffede74>
    80003f1a:	2785                	addiw	a5,a5,1
    80003f1c:	0007871b          	sext.w	a4,a5
    80003f20:	fe043683          	ld	a3,-32(s0)
    80003f24:	67c9                	lui	a5,0x12
    80003f26:	97b6                	add	a5,a5,a3
    80003f28:	18e7a623          	sw	a4,396(a5) # 1218c <_entry-0x7ffede74>
  release(&p->lock);
    80003f2c:	fe043783          	ld	a5,-32(s0)
    80003f30:	853e                	mv	a0,a5
    80003f32:	ffffd097          	auipc	ra,0xffffd
    80003f36:	39c080e7          	jalr	924(ra) # 800012ce <release>



  acquire(&np->lock);
    80003f3a:	fd843783          	ld	a5,-40(s0)
    80003f3e:	853e                	mv	a0,a5
    80003f40:	ffffd097          	auipc	ra,0xffffd
    80003f44:	32a080e7          	jalr	810(ra) # 8000126a <acquire>
  np->state = RUNNABLE;
    80003f48:	fd843783          	ld	a5,-40(s0)
    80003f4c:	470d                	li	a4,3
    80003f4e:	cf98                	sw	a4,24(a5)
  release(&np->lock);
    80003f50:	fd843783          	ld	a5,-40(s0)
    80003f54:	853e                	mv	a0,a5
    80003f56:	ffffd097          	auipc	ra,0xffffd
    80003f5a:	378080e7          	jalr	888(ra) # 800012ce <release>


  //actualizamos las referencias
  

  return pid;
    80003f5e:	fd442783          	lw	a5,-44(s0)


}
    80003f62:	853e                	mv	a0,a5
    80003f64:	60e6                	ld	ra,88(sp)
    80003f66:	6446                	ld	s0,80(sp)
    80003f68:	6125                	addi	sp,sp,96
    80003f6a:	8082                	ret

0000000080003f6c <join>:


int join (uint64 addr_stack){
    80003f6c:	715d                	addi	sp,sp,-80
    80003f6e:	e486                	sd	ra,72(sp)
    80003f70:	e0a2                	sd	s0,64(sp)
    80003f72:	0880                	addi	s0,sp,80
    80003f74:	faa43c23          	sd	a0,-72(s0)

  struct proc *np;
  int havekids, pid;
  void **stack;
  struct proc *p = myproc();
    80003f78:	fffff097          	auipc	ra,0xfffff
    80003f7c:	aa0080e7          	jalr	-1376(ra) # 80002a18 <myproc>
    80003f80:	fca43c23          	sd	a0,-40(s0)

  
  acquire(&wait_lock);
    80003f84:	00497517          	auipc	a0,0x497
    80003f88:	b2c50513          	addi	a0,a0,-1236 # 8049aab0 <wait_lock>
    80003f8c:	ffffd097          	auipc	ra,0xffffd
    80003f90:	2de080e7          	jalr	734(ra) # 8000126a <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    80003f94:	fe042223          	sw	zero,-28(s0)
    for(np = proc; np < &proc[NPROC]; np++){
    80003f98:	00010797          	auipc	a5,0x10
    80003f9c:	70078793          	addi	a5,a5,1792 # 80014698 <proc>
    80003fa0:	fef43423          	sd	a5,-24(s0)
    80003fa4:	aa59                	j	8000413a <join+0x1ce>
      if(np->parent == p && np->thread == 1){ //modificamos la condición para que se seleccione solo al thread hijo del proceso
    80003fa6:	fe843783          	ld	a5,-24(s0)
    80003faa:	7f9c                	ld	a5,56(a5)
    80003fac:	fd843703          	ld	a4,-40(s0)
    80003fb0:	16f71d63          	bne	a4,a5,8000412a <join+0x1be>
    80003fb4:	fe843703          	ld	a4,-24(s0)
    80003fb8:	67c9                	lui	a5,0x12
    80003fba:	97ba                	add	a5,a5,a4
    80003fbc:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    80003fc0:	873e                	mv	a4,a5
    80003fc2:	4785                	li	a5,1
    80003fc4:	16f71363          	bne	a4,a5,8000412a <join+0x1be>


        // make sure the child isn't still in exit() or swtch().
        acquire(&np->lock);
    80003fc8:	fe843783          	ld	a5,-24(s0)
    80003fcc:	853e                	mv	a0,a5
    80003fce:	ffffd097          	auipc	ra,0xffffd
    80003fd2:	29c080e7          	jalr	668(ra) # 8000126a <acquire>

        havekids = 1;
    80003fd6:	4785                	li	a5,1
    80003fd8:	fef42223          	sw	a5,-28(s0)
        if(np->state == ZOMBIE){
    80003fdc:	fe843783          	ld	a5,-24(s0)
    80003fe0:	4f9c                	lw	a5,24(a5)
    80003fe2:	873e                	mv	a4,a5
    80003fe4:	4795                	li	a5,5
    80003fe6:	12f71b63          	bne	a4,a5,8000411c <join+0x1b0>
          // Found one.

          //copiamos en el argumento stack la dirección del stack de usuario para que pueda liberarse después con free
          stack = (void**)np->bottom_ustack; 
    80003fea:	fe843703          	ld	a4,-24(s0)
    80003fee:	6789                	lui	a5,0x2
    80003ff0:	97ba                	add	a5,a5,a4
    80003ff2:	1807b783          	ld	a5,384(a5) # 2180 <_entry-0x7fffde80>
    80003ff6:	fcf43423          	sd	a5,-56(s0)
          pid = np->pid;
    80003ffa:	fe843783          	ld	a5,-24(s0)
    80003ffe:	5b9c                	lw	a5,48(a5)
    80004000:	fcf42a23          	sw	a5,-44(s0)

          np->sz = np->parent->sz;
    80004004:	fe843783          	ld	a5,-24(s0)
    80004008:	7f9c                	ld	a5,56(a5)
    8000400a:	67b8                	ld	a4,72(a5)
    8000400c:	fe843783          	ld	a5,-24(s0)
    80004010:	e7b8                	sd	a4,72(a5)

          printf ("ADDR: %d\n", addr_stack);
    80004012:	fb843583          	ld	a1,-72(s0)
    80004016:	00007517          	auipc	a0,0x7
    8000401a:	35250513          	addi	a0,a0,850 # 8000b368 <etext+0x368>
    8000401e:	ffffd097          	auipc	ra,0xffffd
    80004022:	a06080e7          	jalr	-1530(ra) # 80000a24 <printf>
          printf ("Voy a hacer copyout en join\n");
    80004026:	00007517          	auipc	a0,0x7
    8000402a:	35250513          	addi	a0,a0,850 # 8000b378 <etext+0x378>
    8000402e:	ffffd097          	auipc	ra,0xffffd
    80004032:	9f6080e7          	jalr	-1546(ra) # 80000a24 <printf>
          if ((copyout (np->pagetable, addr_stack, (char *)&stack, sizeof(uint64))) < 0){
    80004036:	fe843783          	ld	a5,-24(s0)
    8000403a:	6bbc                	ld	a5,80(a5)
    8000403c:	fc840713          	addi	a4,s0,-56
    80004040:	46a1                	li	a3,8
    80004042:	863a                	mv	a2,a4
    80004044:	fb843583          	ld	a1,-72(s0)
    80004048:	853e                	mv	a0,a5
    8000404a:	ffffe097          	auipc	ra,0xffffe
    8000404e:	37c080e7          	jalr	892(ra) # 800023c6 <copyout>
    80004052:	87aa                	mv	a5,a0
    80004054:	0207d363          	bgez	a5,8000407a <join+0x10e>
             release(&np->lock); //libera thread
    80004058:	fe843783          	ld	a5,-24(s0)
    8000405c:	853e                	mv	a0,a5
    8000405e:	ffffd097          	auipc	ra,0xffffd
    80004062:	270080e7          	jalr	624(ra) # 800012ce <release>
             release(&wait_lock);
    80004066:	00497517          	auipc	a0,0x497
    8000406a:	a4a50513          	addi	a0,a0,-1462 # 8049aab0 <wait_lock>
    8000406e:	ffffd097          	auipc	ra,0xffffd
    80004072:	260080e7          	jalr	608(ra) # 800012ce <release>
             return -1;
    80004076:	57fd                	li	a5,-1
    80004078:	a231                	j	80004184 <join+0x218>
          }
         

          printf ("Stack del join: %d\n", stack);
    8000407a:	fc843783          	ld	a5,-56(s0)
    8000407e:	85be                	mv	a1,a5
    80004080:	00007517          	auipc	a0,0x7
    80004084:	31850513          	addi	a0,a0,792 # 8000b398 <etext+0x398>
    80004088:	ffffd097          	auipc	ra,0xffffd
    8000408c:	99c080e7          	jalr	-1636(ra) # 80000a24 <printf>

          acquire(&p->lock);
    80004090:	fd843783          	ld	a5,-40(s0)
    80004094:	853e                	mv	a0,a5
    80004096:	ffffd097          	auipc	ra,0xffffd
    8000409a:	1d4080e7          	jalr	468(ra) # 8000126a <acquire>
          p->referencias--;
    8000409e:	fd843703          	ld	a4,-40(s0)
    800040a2:	67c9                	lui	a5,0x12
    800040a4:	97ba                	add	a5,a5,a4
    800040a6:	18c7a783          	lw	a5,396(a5) # 1218c <_entry-0x7ffede74>
    800040aa:	37fd                	addiw	a5,a5,-1
    800040ac:	0007871b          	sext.w	a4,a5
    800040b0:	fd843683          	ld	a3,-40(s0)
    800040b4:	67c9                	lui	a5,0x12
    800040b6:	97b6                	add	a5,a5,a3
    800040b8:	18e7a623          	sw	a4,396(a5) # 1218c <_entry-0x7ffede74>
          release(&p->lock);
    800040bc:	fd843783          	ld	a5,-40(s0)
    800040c0:	853e                	mv	a0,a5
    800040c2:	ffffd097          	auipc	ra,0xffffd
    800040c6:	20c080e7          	jalr	524(ra) # 800012ce <release>
          
          if (np->thread == 1){
    800040ca:	fe843703          	ld	a4,-24(s0)
    800040ce:	67c9                	lui	a5,0x12
    800040d0:	97ba                	add	a5,a5,a4
    800040d2:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    800040d6:	873e                	mv	a4,a5
    800040d8:	4785                	li	a5,1
    800040da:	00f71963          	bne	a4,a5,800040ec <join+0x180>
              freethread(np);
    800040de:	fe843503          	ld	a0,-24(s0)
    800040e2:	fffff097          	auipc	ra,0xfffff
    800040e6:	bd8080e7          	jalr	-1064(ra) # 80002cba <freethread>
    800040ea:	a039                	j	800040f8 <join+0x18c>

          } else {
              freeproc(np);
    800040ec:	fe843503          	ld	a0,-24(s0)
    800040f0:	fffff097          	auipc	ra,0xfffff
    800040f4:	b2c080e7          	jalr	-1236(ra) # 80002c1c <freeproc>
          }


          release(&np->lock); //libera thread
    800040f8:	fe843783          	ld	a5,-24(s0)
    800040fc:	853e                	mv	a0,a5
    800040fe:	ffffd097          	auipc	ra,0xffffd
    80004102:	1d0080e7          	jalr	464(ra) # 800012ce <release>
          release(&wait_lock);
    80004106:	00497517          	auipc	a0,0x497
    8000410a:	9aa50513          	addi	a0,a0,-1622 # 8049aab0 <wait_lock>
    8000410e:	ffffd097          	auipc	ra,0xffffd
    80004112:	1c0080e7          	jalr	448(ra) # 800012ce <release>
          
          return pid; //devolvemos TID 
    80004116:	fd442783          	lw	a5,-44(s0)
    8000411a:	a0ad                	j	80004184 <join+0x218>
        }
        release(&np->lock);
    8000411c:	fe843783          	ld	a5,-24(s0)
    80004120:	853e                	mv	a0,a5
    80004122:	ffffd097          	auipc	ra,0xffffd
    80004126:	1ac080e7          	jalr	428(ra) # 800012ce <release>
    for(np = proc; np < &proc[NPROC]; np++){
    8000412a:	fe843703          	ld	a4,-24(s0)
    8000412e:	67c9                	lui	a5,0x12
    80004130:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80004134:	97ba                	add	a5,a5,a4
    80004136:	fef43423          	sd	a5,-24(s0)
    8000413a:	fe843703          	ld	a4,-24(s0)
    8000413e:	00497797          	auipc	a5,0x497
    80004142:	95a78793          	addi	a5,a5,-1702 # 8049aa98 <pid_lock>
    80004146:	e6f760e3          	bltu	a4,a5,80003fa6 <join+0x3a>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || p->killed){
    8000414a:	fe442783          	lw	a5,-28(s0)
    8000414e:	2781                	sext.w	a5,a5
    80004150:	c789                	beqz	a5,8000415a <join+0x1ee>
    80004152:	fd843783          	ld	a5,-40(s0)
    80004156:	579c                	lw	a5,40(a5)
    80004158:	cb99                	beqz	a5,8000416e <join+0x202>
      release(&wait_lock);
    8000415a:	00497517          	auipc	a0,0x497
    8000415e:	95650513          	addi	a0,a0,-1706 # 8049aab0 <wait_lock>
    80004162:	ffffd097          	auipc	ra,0xffffd
    80004166:	16c080e7          	jalr	364(ra) # 800012ce <release>
      return -1;
    8000416a:	57fd                	li	a5,-1
    8000416c:	a821                	j	80004184 <join+0x218>
    }

    
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000416e:	00497597          	auipc	a1,0x497
    80004172:	94258593          	addi	a1,a1,-1726 # 8049aab0 <wait_lock>
    80004176:	fd843503          	ld	a0,-40(s0)
    8000417a:	fffff097          	auipc	ra,0xfffff
    8000417e:	788080e7          	jalr	1928(ra) # 80003902 <sleep>
    havekids = 0;
    80004182:	bd09                	j	80003f94 <join+0x28>

  }

}
    80004184:	853e                	mv	a0,a5
    80004186:	60a6                	ld	ra,72(sp)
    80004188:	6406                	ld	s0,64(sp)
    8000418a:	6161                	addi	sp,sp,80
    8000418c:	8082                	ret

000000008000418e <growproc_proceso_padre>:

// Grow or shrink user memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc_proceso_padre(int n, struct proc *padre)
{
    8000418e:	7179                	addi	sp,sp,-48
    80004190:	f406                	sd	ra,40(sp)
    80004192:	f022                	sd	s0,32(sp)
    80004194:	1800                	addi	s0,sp,48
    80004196:	87aa                	mv	a5,a0
    80004198:	fcb43823          	sd	a1,-48(s0)
    8000419c:	fcf42e23          	sw	a5,-36(s0)
  uint sz;
  //struct proc *p = myproc();

  sz = padre->sz;
    800041a0:	fd043783          	ld	a5,-48(s0)
    800041a4:	67bc                	ld	a5,72(a5)
    800041a6:	fef42623          	sw	a5,-20(s0)
  if(n > 0){
    800041aa:	fdc42783          	lw	a5,-36(s0)
    800041ae:	2781                	sext.w	a5,a5
    800041b0:	02f05f63          	blez	a5,800041ee <growproc_proceso_padre+0x60>
    if((sz = uvmalloc(padre->pagetable, sz, sz + n)) == 0) {
    800041b4:	fd043783          	ld	a5,-48(s0)
    800041b8:	6bb8                	ld	a4,80(a5)
    800041ba:	fec46683          	lwu	a3,-20(s0)
    800041be:	fdc42783          	lw	a5,-36(s0)
    800041c2:	fec42603          	lw	a2,-20(s0)
    800041c6:	9fb1                	addw	a5,a5,a2
    800041c8:	2781                	sext.w	a5,a5
    800041ca:	1782                	slli	a5,a5,0x20
    800041cc:	9381                	srli	a5,a5,0x20
    800041ce:	863e                	mv	a2,a5
    800041d0:	85b6                	mv	a1,a3
    800041d2:	853a                	mv	a0,a4
    800041d4:	ffffe097          	auipc	ra,0xffffe
    800041d8:	d34080e7          	jalr	-716(ra) # 80001f08 <uvmalloc>
    800041dc:	87aa                	mv	a5,a0
    800041de:	fef42623          	sw	a5,-20(s0)
    800041e2:	fec42783          	lw	a5,-20(s0)
    800041e6:	2781                	sext.w	a5,a5
    800041e8:	ef9d                	bnez	a5,80004226 <growproc_proceso_padre+0x98>
      return -1;
    800041ea:	57fd                	li	a5,-1
    800041ec:	a099                	j	80004232 <growproc_proceso_padre+0xa4>
    }
  } else if(n < 0){
    800041ee:	fdc42783          	lw	a5,-36(s0)
    800041f2:	2781                	sext.w	a5,a5
    800041f4:	0207d963          	bgez	a5,80004226 <growproc_proceso_padre+0x98>
    sz = uvmdealloc(padre->pagetable, sz, sz + n);
    800041f8:	fd043783          	ld	a5,-48(s0)
    800041fc:	6bb8                	ld	a4,80(a5)
    800041fe:	fec46683          	lwu	a3,-20(s0)
    80004202:	fdc42783          	lw	a5,-36(s0)
    80004206:	fec42603          	lw	a2,-20(s0)
    8000420a:	9fb1                	addw	a5,a5,a2
    8000420c:	2781                	sext.w	a5,a5
    8000420e:	1782                	slli	a5,a5,0x20
    80004210:	9381                	srli	a5,a5,0x20
    80004212:	863e                	mv	a2,a5
    80004214:	85b6                	mv	a1,a3
    80004216:	853a                	mv	a0,a4
    80004218:	ffffe097          	auipc	ra,0xffffe
    8000421c:	dd4080e7          	jalr	-556(ra) # 80001fec <uvmdealloc>
    80004220:	87aa                	mv	a5,a0
    80004222:	fef42623          	sw	a5,-20(s0)
  }
  padre->sz = sz;
    80004226:	fec46703          	lwu	a4,-20(s0)
    8000422a:	fd043783          	ld	a5,-48(s0)
    8000422e:	e7b8                	sd	a4,72(a5)
  return 0;
    80004230:	4781                	li	a5,0
}
    80004232:	853e                	mv	a0,a5
    80004234:	70a2                	ld	ra,40(sp)
    80004236:	7402                	ld	s0,32(sp)
    80004238:	6145                	addi	sp,sp,48
    8000423a:	8082                	ret

000000008000423c <busca_padre>:


struct proc* busca_padre (int pid_padre){
    8000423c:	7179                	addi	sp,sp,-48
    8000423e:	f406                	sd	ra,40(sp)
    80004240:	f022                	sd	s0,32(sp)
    80004242:	1800                	addi	s0,sp,48
    80004244:	87aa                	mv	a5,a0
    80004246:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    8000424a:	ffffe097          	auipc	ra,0xffffe
    8000424e:	7ce080e7          	jalr	1998(ra) # 80002a18 <myproc>
    80004252:	fea43423          	sd	a0,-24(s0)
  for(p = proc; p < &proc[NPROC]; p++){
    80004256:	00010797          	auipc	a5,0x10
    8000425a:	44278793          	addi	a5,a5,1090 # 80014698 <proc>
    8000425e:	fef43423          	sd	a5,-24(s0)
    80004262:	a025                	j	8000428a <busca_padre+0x4e>
      if (p->pid == pid_padre){
    80004264:	fe843783          	ld	a5,-24(s0)
    80004268:	5b98                	lw	a4,48(a5)
    8000426a:	fdc42783          	lw	a5,-36(s0)
    8000426e:	2781                	sext.w	a5,a5
    80004270:	00e79563          	bne	a5,a4,8000427a <busca_padre+0x3e>
        return p;
    80004274:	fe843783          	ld	a5,-24(s0)
    80004278:	a015                	j	8000429c <busca_padre+0x60>
  for(p = proc; p < &proc[NPROC]; p++){
    8000427a:	fe843703          	ld	a4,-24(s0)
    8000427e:	67c9                	lui	a5,0x12
    80004280:	19078793          	addi	a5,a5,400 # 12190 <_entry-0x7ffede70>
    80004284:	97ba                	add	a5,a5,a4
    80004286:	fef43423          	sd	a5,-24(s0)
    8000428a:	fe843703          	ld	a4,-24(s0)
    8000428e:	00497797          	auipc	a5,0x497
    80004292:	80a78793          	addi	a5,a5,-2038 # 8049aa98 <pid_lock>
    80004296:	fcf767e3          	bltu	a4,a5,80004264 <busca_padre+0x28>
      }
  }

  return 0;
    8000429a:	4781                	li	a5,0
    8000429c:	853e                	mv	a0,a5
    8000429e:	70a2                	ld	ra,40(sp)
    800042a0:	7402                	ld	s0,32(sp)
    800042a2:	6145                	addi	sp,sp,48
    800042a4:	8082                	ret

00000000800042a6 <swtch>:
    800042a6:	00153023          	sd	ra,0(a0)
    800042aa:	00253423          	sd	sp,8(a0)
    800042ae:	e900                	sd	s0,16(a0)
    800042b0:	ed04                	sd	s1,24(a0)
    800042b2:	03253023          	sd	s2,32(a0)
    800042b6:	03353423          	sd	s3,40(a0)
    800042ba:	03453823          	sd	s4,48(a0)
    800042be:	03553c23          	sd	s5,56(a0)
    800042c2:	05653023          	sd	s6,64(a0)
    800042c6:	05753423          	sd	s7,72(a0)
    800042ca:	05853823          	sd	s8,80(a0)
    800042ce:	05953c23          	sd	s9,88(a0)
    800042d2:	07a53023          	sd	s10,96(a0)
    800042d6:	07b53423          	sd	s11,104(a0)
    800042da:	0005b083          	ld	ra,0(a1)
    800042de:	0085b103          	ld	sp,8(a1)
    800042e2:	6980                	ld	s0,16(a1)
    800042e4:	6d84                	ld	s1,24(a1)
    800042e6:	0205b903          	ld	s2,32(a1)
    800042ea:	0285b983          	ld	s3,40(a1)
    800042ee:	0305ba03          	ld	s4,48(a1)
    800042f2:	0385ba83          	ld	s5,56(a1)
    800042f6:	0405bb03          	ld	s6,64(a1)
    800042fa:	0485bb83          	ld	s7,72(a1)
    800042fe:	0505bc03          	ld	s8,80(a1)
    80004302:	0585bc83          	ld	s9,88(a1)
    80004306:	0605bd03          	ld	s10,96(a1)
    8000430a:	0685bd83          	ld	s11,104(a1)
    8000430e:	8082                	ret

0000000080004310 <r_sstatus>:
{
    80004310:	1101                	addi	sp,sp,-32
    80004312:	ec22                	sd	s0,24(sp)
    80004314:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80004316:	100027f3          	csrr	a5,sstatus
    8000431a:	fef43423          	sd	a5,-24(s0)
  return x;
    8000431e:	fe843783          	ld	a5,-24(s0)
}
    80004322:	853e                	mv	a0,a5
    80004324:	6462                	ld	s0,24(sp)
    80004326:	6105                	addi	sp,sp,32
    80004328:	8082                	ret

000000008000432a <w_sstatus>:
{
    8000432a:	1101                	addi	sp,sp,-32
    8000432c:	ec22                	sd	s0,24(sp)
    8000432e:	1000                	addi	s0,sp,32
    80004330:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80004334:	fe843783          	ld	a5,-24(s0)
    80004338:	10079073          	csrw	sstatus,a5
}
    8000433c:	0001                	nop
    8000433e:	6462                	ld	s0,24(sp)
    80004340:	6105                	addi	sp,sp,32
    80004342:	8082                	ret

0000000080004344 <r_sip>:
{
    80004344:	1101                	addi	sp,sp,-32
    80004346:	ec22                	sd	s0,24(sp)
    80004348:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sip" : "=r" (x) );
    8000434a:	144027f3          	csrr	a5,sip
    8000434e:	fef43423          	sd	a5,-24(s0)
  return x;
    80004352:	fe843783          	ld	a5,-24(s0)
}
    80004356:	853e                	mv	a0,a5
    80004358:	6462                	ld	s0,24(sp)
    8000435a:	6105                	addi	sp,sp,32
    8000435c:	8082                	ret

000000008000435e <w_sip>:
{
    8000435e:	1101                	addi	sp,sp,-32
    80004360:	ec22                	sd	s0,24(sp)
    80004362:	1000                	addi	s0,sp,32
    80004364:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sip, %0" : : "r" (x));
    80004368:	fe843783          	ld	a5,-24(s0)
    8000436c:	14479073          	csrw	sip,a5
}
    80004370:	0001                	nop
    80004372:	6462                	ld	s0,24(sp)
    80004374:	6105                	addi	sp,sp,32
    80004376:	8082                	ret

0000000080004378 <w_sepc>:
{
    80004378:	1101                	addi	sp,sp,-32
    8000437a:	ec22                	sd	s0,24(sp)
    8000437c:	1000                	addi	s0,sp,32
    8000437e:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80004382:	fe843783          	ld	a5,-24(s0)
    80004386:	14179073          	csrw	sepc,a5
}
    8000438a:	0001                	nop
    8000438c:	6462                	ld	s0,24(sp)
    8000438e:	6105                	addi	sp,sp,32
    80004390:	8082                	ret

0000000080004392 <r_sepc>:
{
    80004392:	1101                	addi	sp,sp,-32
    80004394:	ec22                	sd	s0,24(sp)
    80004396:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80004398:	141027f3          	csrr	a5,sepc
    8000439c:	fef43423          	sd	a5,-24(s0)
  return x;
    800043a0:	fe843783          	ld	a5,-24(s0)
}
    800043a4:	853e                	mv	a0,a5
    800043a6:	6462                	ld	s0,24(sp)
    800043a8:	6105                	addi	sp,sp,32
    800043aa:	8082                	ret

00000000800043ac <w_stvec>:
{
    800043ac:	1101                	addi	sp,sp,-32
    800043ae:	ec22                	sd	s0,24(sp)
    800043b0:	1000                	addi	s0,sp,32
    800043b2:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw stvec, %0" : : "r" (x));
    800043b6:	fe843783          	ld	a5,-24(s0)
    800043ba:	10579073          	csrw	stvec,a5
}
    800043be:	0001                	nop
    800043c0:	6462                	ld	s0,24(sp)
    800043c2:	6105                	addi	sp,sp,32
    800043c4:	8082                	ret

00000000800043c6 <r_satp>:
{
    800043c6:	1101                	addi	sp,sp,-32
    800043c8:	ec22                	sd	s0,24(sp)
    800043ca:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, satp" : "=r" (x) );
    800043cc:	180027f3          	csrr	a5,satp
    800043d0:	fef43423          	sd	a5,-24(s0)
  return x;
    800043d4:	fe843783          	ld	a5,-24(s0)
}
    800043d8:	853e                	mv	a0,a5
    800043da:	6462                	ld	s0,24(sp)
    800043dc:	6105                	addi	sp,sp,32
    800043de:	8082                	ret

00000000800043e0 <r_scause>:
{
    800043e0:	1101                	addi	sp,sp,-32
    800043e2:	ec22                	sd	s0,24(sp)
    800043e4:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    800043e6:	142027f3          	csrr	a5,scause
    800043ea:	fef43423          	sd	a5,-24(s0)
  return x;
    800043ee:	fe843783          	ld	a5,-24(s0)
}
    800043f2:	853e                	mv	a0,a5
    800043f4:	6462                	ld	s0,24(sp)
    800043f6:	6105                	addi	sp,sp,32
    800043f8:	8082                	ret

00000000800043fa <r_stval>:
{
    800043fa:	1101                	addi	sp,sp,-32
    800043fc:	ec22                	sd	s0,24(sp)
    800043fe:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, stval" : "=r" (x) );
    80004400:	143027f3          	csrr	a5,stval
    80004404:	fef43423          	sd	a5,-24(s0)
  return x;
    80004408:	fe843783          	ld	a5,-24(s0)
}
    8000440c:	853e                	mv	a0,a5
    8000440e:	6462                	ld	s0,24(sp)
    80004410:	6105                	addi	sp,sp,32
    80004412:	8082                	ret

0000000080004414 <intr_on>:
{
    80004414:	1141                	addi	sp,sp,-16
    80004416:	e406                	sd	ra,8(sp)
    80004418:	e022                	sd	s0,0(sp)
    8000441a:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000441c:	00000097          	auipc	ra,0x0
    80004420:	ef4080e7          	jalr	-268(ra) # 80004310 <r_sstatus>
    80004424:	87aa                	mv	a5,a0
    80004426:	0027e793          	ori	a5,a5,2
    8000442a:	853e                	mv	a0,a5
    8000442c:	00000097          	auipc	ra,0x0
    80004430:	efe080e7          	jalr	-258(ra) # 8000432a <w_sstatus>
}
    80004434:	0001                	nop
    80004436:	60a2                	ld	ra,8(sp)
    80004438:	6402                	ld	s0,0(sp)
    8000443a:	0141                	addi	sp,sp,16
    8000443c:	8082                	ret

000000008000443e <intr_off>:
{
    8000443e:	1141                	addi	sp,sp,-16
    80004440:	e406                	sd	ra,8(sp)
    80004442:	e022                	sd	s0,0(sp)
    80004444:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80004446:	00000097          	auipc	ra,0x0
    8000444a:	eca080e7          	jalr	-310(ra) # 80004310 <r_sstatus>
    8000444e:	87aa                	mv	a5,a0
    80004450:	9bf5                	andi	a5,a5,-3
    80004452:	853e                	mv	a0,a5
    80004454:	00000097          	auipc	ra,0x0
    80004458:	ed6080e7          	jalr	-298(ra) # 8000432a <w_sstatus>
}
    8000445c:	0001                	nop
    8000445e:	60a2                	ld	ra,8(sp)
    80004460:	6402                	ld	s0,0(sp)
    80004462:	0141                	addi	sp,sp,16
    80004464:	8082                	ret

0000000080004466 <intr_get>:
{
    80004466:	1101                	addi	sp,sp,-32
    80004468:	ec06                	sd	ra,24(sp)
    8000446a:	e822                	sd	s0,16(sp)
    8000446c:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    8000446e:	00000097          	auipc	ra,0x0
    80004472:	ea2080e7          	jalr	-350(ra) # 80004310 <r_sstatus>
    80004476:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    8000447a:	fe843783          	ld	a5,-24(s0)
    8000447e:	8b89                	andi	a5,a5,2
    80004480:	00f037b3          	snez	a5,a5
    80004484:	0ff7f793          	zext.b	a5,a5
    80004488:	2781                	sext.w	a5,a5
}
    8000448a:	853e                	mv	a0,a5
    8000448c:	60e2                	ld	ra,24(sp)
    8000448e:	6442                	ld	s0,16(sp)
    80004490:	6105                	addi	sp,sp,32
    80004492:	8082                	ret

0000000080004494 <r_tp>:
{
    80004494:	1101                	addi	sp,sp,-32
    80004496:	ec22                	sd	s0,24(sp)
    80004498:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    8000449a:	8792                	mv	a5,tp
    8000449c:	fef43423          	sd	a5,-24(s0)
  return x;
    800044a0:	fe843783          	ld	a5,-24(s0)
}
    800044a4:	853e                	mv	a0,a5
    800044a6:	6462                	ld	s0,24(sp)
    800044a8:	6105                	addi	sp,sp,32
    800044aa:	8082                	ret

00000000800044ac <trapinit>:

extern int devintr();

void
trapinit(void)
{
    800044ac:	1141                	addi	sp,sp,-16
    800044ae:	e406                	sd	ra,8(sp)
    800044b0:	e022                	sd	s0,0(sp)
    800044b2:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    800044b4:	00007597          	auipc	a1,0x7
    800044b8:	f2c58593          	addi	a1,a1,-212 # 8000b3e0 <etext+0x3e0>
    800044bc:	00496517          	auipc	a0,0x496
    800044c0:	60c50513          	addi	a0,a0,1548 # 8049aac8 <tickslock>
    800044c4:	ffffd097          	auipc	ra,0xffffd
    800044c8:	d76080e7          	jalr	-650(ra) # 8000123a <initlock>
}
    800044cc:	0001                	nop
    800044ce:	60a2                	ld	ra,8(sp)
    800044d0:	6402                	ld	s0,0(sp)
    800044d2:	0141                	addi	sp,sp,16
    800044d4:	8082                	ret

00000000800044d6 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    800044d6:	1141                	addi	sp,sp,-16
    800044d8:	e406                	sd	ra,8(sp)
    800044da:	e022                	sd	s0,0(sp)
    800044dc:	0800                	addi	s0,sp,16
  w_stvec((uint64)kernelvec);
    800044de:	00005797          	auipc	a5,0x5
    800044e2:	f2278793          	addi	a5,a5,-222 # 80009400 <kernelvec>
    800044e6:	853e                	mv	a0,a5
    800044e8:	00000097          	auipc	ra,0x0
    800044ec:	ec4080e7          	jalr	-316(ra) # 800043ac <w_stvec>
}
    800044f0:	0001                	nop
    800044f2:	60a2                	ld	ra,8(sp)
    800044f4:	6402                	ld	s0,0(sp)
    800044f6:	0141                	addi	sp,sp,16
    800044f8:	8082                	ret

00000000800044fa <usertrap>:
// handle an interrupt, exception, or system call from user space.
// called from trampoline.S
//
void
usertrap(void)
{
    800044fa:	7179                	addi	sp,sp,-48
    800044fc:	f406                	sd	ra,40(sp)
    800044fe:	f022                	sd	s0,32(sp)
    80004500:	ec26                	sd	s1,24(sp)
    80004502:	1800                	addi	s0,sp,48
  int which_dev = 0;
    80004504:	fc042e23          	sw	zero,-36(s0)

  if((r_sstatus() & SSTATUS_SPP) != 0)
    80004508:	00000097          	auipc	ra,0x0
    8000450c:	e08080e7          	jalr	-504(ra) # 80004310 <r_sstatus>
    80004510:	87aa                	mv	a5,a0
    80004512:	1007f793          	andi	a5,a5,256
    80004516:	cb89                	beqz	a5,80004528 <usertrap+0x2e>
    panic("usertrap: not from user mode");
    80004518:	00007517          	auipc	a0,0x7
    8000451c:	ed050513          	addi	a0,a0,-304 # 8000b3e8 <etext+0x3e8>
    80004520:	ffffc097          	auipc	ra,0xffffc
    80004524:	75a080e7          	jalr	1882(ra) # 80000c7a <panic>

  // send interrupts and exceptions to kerneltrap(),
  // since we're now in the kernel.
  w_stvec((uint64)kernelvec);
    80004528:	00005797          	auipc	a5,0x5
    8000452c:	ed878793          	addi	a5,a5,-296 # 80009400 <kernelvec>
    80004530:	853e                	mv	a0,a5
    80004532:	00000097          	auipc	ra,0x0
    80004536:	e7a080e7          	jalr	-390(ra) # 800043ac <w_stvec>

  struct proc *p = myproc();
    8000453a:	ffffe097          	auipc	ra,0xffffe
    8000453e:	4de080e7          	jalr	1246(ra) # 80002a18 <myproc>
    80004542:	fca43823          	sd	a0,-48(s0)
  
  // save user program counter.
  p->trapframe->epc = r_sepc();
    80004546:	fd043783          	ld	a5,-48(s0)
    8000454a:	73a4                	ld	s1,96(a5)
    8000454c:	00000097          	auipc	ra,0x0
    80004550:	e46080e7          	jalr	-442(ra) # 80004392 <r_sepc>
    80004554:	87aa                	mv	a5,a0
    80004556:	ec9c                	sd	a5,24(s1)
  
  if(r_scause() == 8){
    80004558:	00000097          	auipc	ra,0x0
    8000455c:	e88080e7          	jalr	-376(ra) # 800043e0 <r_scause>
    80004560:	872a                	mv	a4,a0
    80004562:	47a1                	li	a5,8
    80004564:	02f71d63          	bne	a4,a5,8000459e <usertrap+0xa4>
    // system call

    if(p->killed)
    80004568:	fd043783          	ld	a5,-48(s0)
    8000456c:	579c                	lw	a5,40(a5)
    8000456e:	c791                	beqz	a5,8000457a <usertrap+0x80>
      exit(-1);
    80004570:	557d                	li	a0,-1
    80004572:	fffff097          	auipc	ra,0xfffff
    80004576:	e90080e7          	jalr	-368(ra) # 80003402 <exit>

    // sepc points to the ecall instruction,
    // but we want to return to the next instruction.
    p->trapframe->epc += 4;
    8000457a:	fd043783          	ld	a5,-48(s0)
    8000457e:	73bc                	ld	a5,96(a5)
    80004580:	6f98                	ld	a4,24(a5)
    80004582:	fd043783          	ld	a5,-48(s0)
    80004586:	73bc                	ld	a5,96(a5)
    80004588:	0711                	addi	a4,a4,4
    8000458a:	ef98                	sd	a4,24(a5)

    // an interrupt will change sstatus &c registers,
    // so don't enable until done with those registers.
    intr_on();
    8000458c:	00000097          	auipc	ra,0x0
    80004590:	e88080e7          	jalr	-376(ra) # 80004414 <intr_on>

    syscall();
    80004594:	00000097          	auipc	ra,0x0
    80004598:	67e080e7          	jalr	1662(ra) # 80004c12 <syscall>
    8000459c:	a0b5                	j	80004608 <usertrap+0x10e>
  } else if((which_dev = devintr()) != 0){
    8000459e:	00000097          	auipc	ra,0x0
    800045a2:	346080e7          	jalr	838(ra) # 800048e4 <devintr>
    800045a6:	87aa                	mv	a5,a0
    800045a8:	fcf42e23          	sw	a5,-36(s0)
    800045ac:	fdc42783          	lw	a5,-36(s0)
    800045b0:	2781                	sext.w	a5,a5
    800045b2:	ebb9                	bnez	a5,80004608 <usertrap+0x10e>
    // ok
  } else {
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    800045b4:	00000097          	auipc	ra,0x0
    800045b8:	e2c080e7          	jalr	-468(ra) # 800043e0 <r_scause>
    800045bc:	872a                	mv	a4,a0
    800045be:	fd043783          	ld	a5,-48(s0)
    800045c2:	5b9c                	lw	a5,48(a5)
    800045c4:	863e                	mv	a2,a5
    800045c6:	85ba                	mv	a1,a4
    800045c8:	00007517          	auipc	a0,0x7
    800045cc:	e4050513          	addi	a0,a0,-448 # 8000b408 <etext+0x408>
    800045d0:	ffffc097          	auipc	ra,0xffffc
    800045d4:	454080e7          	jalr	1108(ra) # 80000a24 <printf>
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    800045d8:	00000097          	auipc	ra,0x0
    800045dc:	dba080e7          	jalr	-582(ra) # 80004392 <r_sepc>
    800045e0:	84aa                	mv	s1,a0
    800045e2:	00000097          	auipc	ra,0x0
    800045e6:	e18080e7          	jalr	-488(ra) # 800043fa <r_stval>
    800045ea:	87aa                	mv	a5,a0
    800045ec:	863e                	mv	a2,a5
    800045ee:	85a6                	mv	a1,s1
    800045f0:	00007517          	auipc	a0,0x7
    800045f4:	e4850513          	addi	a0,a0,-440 # 8000b438 <etext+0x438>
    800045f8:	ffffc097          	auipc	ra,0xffffc
    800045fc:	42c080e7          	jalr	1068(ra) # 80000a24 <printf>
    p->killed = 1;
    80004600:	fd043783          	ld	a5,-48(s0)
    80004604:	4705                	li	a4,1
    80004606:	d798                	sw	a4,40(a5)
  }

  if(p->killed)
    80004608:	fd043783          	ld	a5,-48(s0)
    8000460c:	579c                	lw	a5,40(a5)
    8000460e:	c791                	beqz	a5,8000461a <usertrap+0x120>
    exit(-1);
    80004610:	557d                	li	a0,-1
    80004612:	fffff097          	auipc	ra,0xfffff
    80004616:	df0080e7          	jalr	-528(ra) # 80003402 <exit>

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2)
    8000461a:	fdc42783          	lw	a5,-36(s0)
    8000461e:	0007871b          	sext.w	a4,a5
    80004622:	4789                	li	a5,2
    80004624:	00f71663          	bne	a4,a5,80004630 <usertrap+0x136>
    yield();
    80004628:	fffff097          	auipc	ra,0xfffff
    8000462c:	240080e7          	jalr	576(ra) # 80003868 <yield>

  usertrapret();
    80004630:	00000097          	auipc	ra,0x0
    80004634:	014080e7          	jalr	20(ra) # 80004644 <usertrapret>
}
    80004638:	0001                	nop
    8000463a:	70a2                	ld	ra,40(sp)
    8000463c:	7402                	ld	s0,32(sp)
    8000463e:	64e2                	ld	s1,24(sp)
    80004640:	6145                	addi	sp,sp,48
    80004642:	8082                	ret

0000000080004644 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80004644:	7139                	addi	sp,sp,-64
    80004646:	fc06                	sd	ra,56(sp)
    80004648:	f822                	sd	s0,48(sp)
    8000464a:	f426                	sd	s1,40(sp)
    8000464c:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    8000464e:	ffffe097          	auipc	ra,0xffffe
    80004652:	3ca080e7          	jalr	970(ra) # 80002a18 <myproc>
    80004656:	fca43c23          	sd	a0,-40(s0)

  // we're about to switch the destination of traps from
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();
    8000465a:	00000097          	auipc	ra,0x0
    8000465e:	de4080e7          	jalr	-540(ra) # 8000443e <intr_off>

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80004662:	00006717          	auipc	a4,0x6
    80004666:	99e70713          	addi	a4,a4,-1634 # 8000a000 <_trampoline>
    8000466a:	00006797          	auipc	a5,0x6
    8000466e:	99678793          	addi	a5,a5,-1642 # 8000a000 <_trampoline>
    80004672:	8f1d                	sub	a4,a4,a5
    80004674:	040007b7          	lui	a5,0x4000
    80004678:	17fd                	addi	a5,a5,-1
    8000467a:	07b2                	slli	a5,a5,0xc
    8000467c:	97ba                	add	a5,a5,a4
    8000467e:	853e                	mv	a0,a5
    80004680:	00000097          	auipc	ra,0x0
    80004684:	d2c080e7          	jalr	-724(ra) # 800043ac <w_stvec>

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80004688:	fd843783          	ld	a5,-40(s0)
    8000468c:	73a4                	ld	s1,96(a5)
    8000468e:	00000097          	auipc	ra,0x0
    80004692:	d38080e7          	jalr	-712(ra) # 800043c6 <r_satp>
    80004696:	87aa                	mv	a5,a0
    80004698:	e09c                	sd	a5,0(s1)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    8000469a:	fd843783          	ld	a5,-40(s0)
    8000469e:	63b4                	ld	a3,64(a5)
    800046a0:	fd843783          	ld	a5,-40(s0)
    800046a4:	73bc                	ld	a5,96(a5)
    800046a6:	6705                	lui	a4,0x1
    800046a8:	9736                	add	a4,a4,a3
    800046aa:	e798                	sd	a4,8(a5)
  p->trapframe->kernel_trap = (uint64)usertrap;
    800046ac:	fd843783          	ld	a5,-40(s0)
    800046b0:	73bc                	ld	a5,96(a5)
    800046b2:	00000717          	auipc	a4,0x0
    800046b6:	e4870713          	addi	a4,a4,-440 # 800044fa <usertrap>
    800046ba:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    800046bc:	fd843783          	ld	a5,-40(s0)
    800046c0:	73a4                	ld	s1,96(a5)
    800046c2:	00000097          	auipc	ra,0x0
    800046c6:	dd2080e7          	jalr	-558(ra) # 80004494 <r_tp>
    800046ca:	87aa                	mv	a5,a0
    800046cc:	f09c                	sd	a5,32(s1)

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
    800046ce:	00000097          	auipc	ra,0x0
    800046d2:	c42080e7          	jalr	-958(ra) # 80004310 <r_sstatus>
    800046d6:	fca43823          	sd	a0,-48(s0)
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800046da:	fd043783          	ld	a5,-48(s0)
    800046de:	eff7f793          	andi	a5,a5,-257
    800046e2:	fcf43823          	sd	a5,-48(s0)
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800046e6:	fd043783          	ld	a5,-48(s0)
    800046ea:	0207e793          	ori	a5,a5,32
    800046ee:	fcf43823          	sd	a5,-48(s0)
  w_sstatus(x);
    800046f2:	fd043503          	ld	a0,-48(s0)
    800046f6:	00000097          	auipc	ra,0x0
    800046fa:	c34080e7          	jalr	-972(ra) # 8000432a <w_sstatus>

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    800046fe:	fd843783          	ld	a5,-40(s0)
    80004702:	73bc                	ld	a5,96(a5)
    80004704:	6f9c                	ld	a5,24(a5)
    80004706:	853e                	mv	a0,a5
    80004708:	00000097          	auipc	ra,0x0
    8000470c:	c70080e7          	jalr	-912(ra) # 80004378 <w_sepc>

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80004710:	fd843783          	ld	a5,-40(s0)
    80004714:	6bbc                	ld	a5,80(a5)
    80004716:	00c7d713          	srli	a4,a5,0xc
    8000471a:	57fd                	li	a5,-1
    8000471c:	17fe                	slli	a5,a5,0x3f
    8000471e:	8fd9                	or	a5,a5,a4
    80004720:	fcf43423          	sd	a5,-56(s0)

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80004724:	00006717          	auipc	a4,0x6
    80004728:	96c70713          	addi	a4,a4,-1684 # 8000a090 <userret>
    8000472c:	00006797          	auipc	a5,0x6
    80004730:	8d478793          	addi	a5,a5,-1836 # 8000a000 <_trampoline>
    80004734:	8f1d                	sub	a4,a4,a5
    80004736:	040007b7          	lui	a5,0x4000
    8000473a:	17fd                	addi	a5,a5,-1
    8000473c:	07b2                	slli	a5,a5,0xc
    8000473e:	97ba                	add	a5,a5,a4
    80004740:	fcf43023          	sd	a5,-64(s0)
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80004744:	fc043703          	ld	a4,-64(s0)
    80004748:	fc843583          	ld	a1,-56(s0)
    8000474c:	020007b7          	lui	a5,0x2000
    80004750:	17fd                	addi	a5,a5,-1
    80004752:	00d79513          	slli	a0,a5,0xd
    80004756:	9702                	jalr	a4
}
    80004758:	0001                	nop
    8000475a:	70e2                	ld	ra,56(sp)
    8000475c:	7442                	ld	s0,48(sp)
    8000475e:	74a2                	ld	s1,40(sp)
    80004760:	6121                	addi	sp,sp,64
    80004762:	8082                	ret

0000000080004764 <kerneltrap>:

// interrupts and exceptions from kernel code go here via kernelvec,
// on whatever the current kernel stack is.
void 
kerneltrap()
{
    80004764:	7139                	addi	sp,sp,-64
    80004766:	fc06                	sd	ra,56(sp)
    80004768:	f822                	sd	s0,48(sp)
    8000476a:	f426                	sd	s1,40(sp)
    8000476c:	0080                	addi	s0,sp,64
  int which_dev = 0;
    8000476e:	fc042e23          	sw	zero,-36(s0)
  uint64 sepc = r_sepc();
    80004772:	00000097          	auipc	ra,0x0
    80004776:	c20080e7          	jalr	-992(ra) # 80004392 <r_sepc>
    8000477a:	fca43823          	sd	a0,-48(s0)
  uint64 sstatus = r_sstatus();
    8000477e:	00000097          	auipc	ra,0x0
    80004782:	b92080e7          	jalr	-1134(ra) # 80004310 <r_sstatus>
    80004786:	fca43423          	sd	a0,-56(s0)
  uint64 scause = r_scause();
    8000478a:	00000097          	auipc	ra,0x0
    8000478e:	c56080e7          	jalr	-938(ra) # 800043e0 <r_scause>
    80004792:	fca43023          	sd	a0,-64(s0)
  
  if((sstatus & SSTATUS_SPP) == 0)
    80004796:	fc843783          	ld	a5,-56(s0)
    8000479a:	1007f793          	andi	a5,a5,256
    8000479e:	eb89                	bnez	a5,800047b0 <kerneltrap+0x4c>
    panic("kerneltrap: not from supervisor mode");
    800047a0:	00007517          	auipc	a0,0x7
    800047a4:	cb850513          	addi	a0,a0,-840 # 8000b458 <etext+0x458>
    800047a8:	ffffc097          	auipc	ra,0xffffc
    800047ac:	4d2080e7          	jalr	1234(ra) # 80000c7a <panic>
  if(intr_get() != 0)
    800047b0:	00000097          	auipc	ra,0x0
    800047b4:	cb6080e7          	jalr	-842(ra) # 80004466 <intr_get>
    800047b8:	87aa                	mv	a5,a0
    800047ba:	cb89                	beqz	a5,800047cc <kerneltrap+0x68>
    panic("kerneltrap: interrupts enabled");
    800047bc:	00007517          	auipc	a0,0x7
    800047c0:	cc450513          	addi	a0,a0,-828 # 8000b480 <etext+0x480>
    800047c4:	ffffc097          	auipc	ra,0xffffc
    800047c8:	4b6080e7          	jalr	1206(ra) # 80000c7a <panic>

  if((which_dev = devintr()) == 0){
    800047cc:	00000097          	auipc	ra,0x0
    800047d0:	118080e7          	jalr	280(ra) # 800048e4 <devintr>
    800047d4:	87aa                	mv	a5,a0
    800047d6:	fcf42e23          	sw	a5,-36(s0)
    800047da:	fdc42783          	lw	a5,-36(s0)
    800047de:	2781                	sext.w	a5,a5
    800047e0:	e7b9                	bnez	a5,8000482e <kerneltrap+0xca>
    printf("scause %p\n", scause);
    800047e2:	fc043583          	ld	a1,-64(s0)
    800047e6:	00007517          	auipc	a0,0x7
    800047ea:	cba50513          	addi	a0,a0,-838 # 8000b4a0 <etext+0x4a0>
    800047ee:	ffffc097          	auipc	ra,0xffffc
    800047f2:	236080e7          	jalr	566(ra) # 80000a24 <printf>
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    800047f6:	00000097          	auipc	ra,0x0
    800047fa:	b9c080e7          	jalr	-1124(ra) # 80004392 <r_sepc>
    800047fe:	84aa                	mv	s1,a0
    80004800:	00000097          	auipc	ra,0x0
    80004804:	bfa080e7          	jalr	-1030(ra) # 800043fa <r_stval>
    80004808:	87aa                	mv	a5,a0
    8000480a:	863e                	mv	a2,a5
    8000480c:	85a6                	mv	a1,s1
    8000480e:	00007517          	auipc	a0,0x7
    80004812:	ca250513          	addi	a0,a0,-862 # 8000b4b0 <etext+0x4b0>
    80004816:	ffffc097          	auipc	ra,0xffffc
    8000481a:	20e080e7          	jalr	526(ra) # 80000a24 <printf>
    panic("kerneltrap");
    8000481e:	00007517          	auipc	a0,0x7
    80004822:	caa50513          	addi	a0,a0,-854 # 8000b4c8 <etext+0x4c8>
    80004826:	ffffc097          	auipc	ra,0xffffc
    8000482a:	454080e7          	jalr	1108(ra) # 80000c7a <panic>
  }

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    8000482e:	fdc42783          	lw	a5,-36(s0)
    80004832:	0007871b          	sext.w	a4,a5
    80004836:	4789                	li	a5,2
    80004838:	02f71663          	bne	a4,a5,80004864 <kerneltrap+0x100>
    8000483c:	ffffe097          	auipc	ra,0xffffe
    80004840:	1dc080e7          	jalr	476(ra) # 80002a18 <myproc>
    80004844:	87aa                	mv	a5,a0
    80004846:	cf99                	beqz	a5,80004864 <kerneltrap+0x100>
    80004848:	ffffe097          	auipc	ra,0xffffe
    8000484c:	1d0080e7          	jalr	464(ra) # 80002a18 <myproc>
    80004850:	87aa                	mv	a5,a0
    80004852:	4f9c                	lw	a5,24(a5)
    80004854:	873e                	mv	a4,a5
    80004856:	4791                	li	a5,4
    80004858:	00f71663          	bne	a4,a5,80004864 <kerneltrap+0x100>
    yield();
    8000485c:	fffff097          	auipc	ra,0xfffff
    80004860:	00c080e7          	jalr	12(ra) # 80003868 <yield>

  // the yield() may have caused some traps to occur,
  // so restore trap registers for use by kernelvec.S's sepc instruction.
  w_sepc(sepc);
    80004864:	fd043503          	ld	a0,-48(s0)
    80004868:	00000097          	auipc	ra,0x0
    8000486c:	b10080e7          	jalr	-1264(ra) # 80004378 <w_sepc>
  w_sstatus(sstatus);
    80004870:	fc843503          	ld	a0,-56(s0)
    80004874:	00000097          	auipc	ra,0x0
    80004878:	ab6080e7          	jalr	-1354(ra) # 8000432a <w_sstatus>
}
    8000487c:	0001                	nop
    8000487e:	70e2                	ld	ra,56(sp)
    80004880:	7442                	ld	s0,48(sp)
    80004882:	74a2                	ld	s1,40(sp)
    80004884:	6121                	addi	sp,sp,64
    80004886:	8082                	ret

0000000080004888 <clockintr>:

void
clockintr()
{
    80004888:	1141                	addi	sp,sp,-16
    8000488a:	e406                	sd	ra,8(sp)
    8000488c:	e022                	sd	s0,0(sp)
    8000488e:	0800                	addi	s0,sp,16
  acquire(&tickslock);
    80004890:	00496517          	auipc	a0,0x496
    80004894:	23850513          	addi	a0,a0,568 # 8049aac8 <tickslock>
    80004898:	ffffd097          	auipc	ra,0xffffd
    8000489c:	9d2080e7          	jalr	-1582(ra) # 8000126a <acquire>
  ticks++;
    800048a0:	00007797          	auipc	a5,0x7
    800048a4:	78878793          	addi	a5,a5,1928 # 8000c028 <ticks>
    800048a8:	439c                	lw	a5,0(a5)
    800048aa:	2785                	addiw	a5,a5,1
    800048ac:	0007871b          	sext.w	a4,a5
    800048b0:	00007797          	auipc	a5,0x7
    800048b4:	77878793          	addi	a5,a5,1912 # 8000c028 <ticks>
    800048b8:	c398                	sw	a4,0(a5)
  wakeup(&ticks);
    800048ba:	00007517          	auipc	a0,0x7
    800048be:	76e50513          	addi	a0,a0,1902 # 8000c028 <ticks>
    800048c2:	fffff097          	auipc	ra,0xfffff
    800048c6:	0bc080e7          	jalr	188(ra) # 8000397e <wakeup>
  release(&tickslock);
    800048ca:	00496517          	auipc	a0,0x496
    800048ce:	1fe50513          	addi	a0,a0,510 # 8049aac8 <tickslock>
    800048d2:	ffffd097          	auipc	ra,0xffffd
    800048d6:	9fc080e7          	jalr	-1540(ra) # 800012ce <release>
}
    800048da:	0001                	nop
    800048dc:	60a2                	ld	ra,8(sp)
    800048de:	6402                	ld	s0,0(sp)
    800048e0:	0141                	addi	sp,sp,16
    800048e2:	8082                	ret

00000000800048e4 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    800048e4:	1101                	addi	sp,sp,-32
    800048e6:	ec06                	sd	ra,24(sp)
    800048e8:	e822                	sd	s0,16(sp)
    800048ea:	1000                	addi	s0,sp,32
  uint64 scause = r_scause();
    800048ec:	00000097          	auipc	ra,0x0
    800048f0:	af4080e7          	jalr	-1292(ra) # 800043e0 <r_scause>
    800048f4:	fea43423          	sd	a0,-24(s0)

  if((scause & 0x8000000000000000L) &&
    800048f8:	fe843783          	ld	a5,-24(s0)
    800048fc:	0807d463          	bgez	a5,80004984 <devintr+0xa0>
     (scause & 0xff) == 9){
    80004900:	fe843783          	ld	a5,-24(s0)
    80004904:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    80004908:	47a5                	li	a5,9
    8000490a:	06f71d63          	bne	a4,a5,80004984 <devintr+0xa0>
    // this is a supervisor external interrupt, via PLIC.

    // irq indicates which device interrupted.
    int irq = plic_claim();
    8000490e:	00005097          	auipc	ra,0x5
    80004912:	c24080e7          	jalr	-988(ra) # 80009532 <plic_claim>
    80004916:	87aa                	mv	a5,a0
    80004918:	fef42223          	sw	a5,-28(s0)

    if(irq == UART0_IRQ){
    8000491c:	fe442783          	lw	a5,-28(s0)
    80004920:	0007871b          	sext.w	a4,a5
    80004924:	47a9                	li	a5,10
    80004926:	00f71763          	bne	a4,a5,80004934 <devintr+0x50>
      uartintr();
    8000492a:	ffffc097          	auipc	ra,0xffffc
    8000492e:	648080e7          	jalr	1608(ra) # 80000f72 <uartintr>
    80004932:	a825                	j	8000496a <devintr+0x86>
    } else if(irq == VIRTIO0_IRQ){
    80004934:	fe442783          	lw	a5,-28(s0)
    80004938:	0007871b          	sext.w	a4,a5
    8000493c:	4785                	li	a5,1
    8000493e:	00f71763          	bne	a4,a5,8000494c <devintr+0x68>
      virtio_disk_intr();
    80004942:	00005097          	auipc	ra,0x5
    80004946:	506080e7          	jalr	1286(ra) # 80009e48 <virtio_disk_intr>
    8000494a:	a005                	j	8000496a <devintr+0x86>
    } else if(irq){
    8000494c:	fe442783          	lw	a5,-28(s0)
    80004950:	2781                	sext.w	a5,a5
    80004952:	cf81                	beqz	a5,8000496a <devintr+0x86>
      printf("unexpected interrupt irq=%d\n", irq);
    80004954:	fe442783          	lw	a5,-28(s0)
    80004958:	85be                	mv	a1,a5
    8000495a:	00007517          	auipc	a0,0x7
    8000495e:	b7e50513          	addi	a0,a0,-1154 # 8000b4d8 <etext+0x4d8>
    80004962:	ffffc097          	auipc	ra,0xffffc
    80004966:	0c2080e7          	jalr	194(ra) # 80000a24 <printf>
    }

    // the PLIC allows each device to raise at most one
    // interrupt at a time; tell the PLIC the device is
    // now allowed to interrupt again.
    if(irq)
    8000496a:	fe442783          	lw	a5,-28(s0)
    8000496e:	2781                	sext.w	a5,a5
    80004970:	cb81                	beqz	a5,80004980 <devintr+0x9c>
      plic_complete(irq);
    80004972:	fe442783          	lw	a5,-28(s0)
    80004976:	853e                	mv	a0,a5
    80004978:	00005097          	auipc	ra,0x5
    8000497c:	bf8080e7          	jalr	-1032(ra) # 80009570 <plic_complete>

    return 1;
    80004980:	4785                	li	a5,1
    80004982:	a081                	j	800049c2 <devintr+0xde>
  } else if(scause == 0x8000000000000001L){
    80004984:	fe843703          	ld	a4,-24(s0)
    80004988:	57fd                	li	a5,-1
    8000498a:	17fe                	slli	a5,a5,0x3f
    8000498c:	0785                	addi	a5,a5,1
    8000498e:	02f71963          	bne	a4,a5,800049c0 <devintr+0xdc>
    // software interrupt from a machine-mode timer interrupt,
    // forwarded by timervec in kernelvec.S.

    if(cpuid() == 0){
    80004992:	ffffe097          	auipc	ra,0xffffe
    80004996:	028080e7          	jalr	40(ra) # 800029ba <cpuid>
    8000499a:	87aa                	mv	a5,a0
    8000499c:	e789                	bnez	a5,800049a6 <devintr+0xc2>
      clockintr();
    8000499e:	00000097          	auipc	ra,0x0
    800049a2:	eea080e7          	jalr	-278(ra) # 80004888 <clockintr>
    }
    
    // acknowledge the software interrupt by clearing
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);
    800049a6:	00000097          	auipc	ra,0x0
    800049aa:	99e080e7          	jalr	-1634(ra) # 80004344 <r_sip>
    800049ae:	87aa                	mv	a5,a0
    800049b0:	9bf5                	andi	a5,a5,-3
    800049b2:	853e                	mv	a0,a5
    800049b4:	00000097          	auipc	ra,0x0
    800049b8:	9aa080e7          	jalr	-1622(ra) # 8000435e <w_sip>

    return 2;
    800049bc:	4789                	li	a5,2
    800049be:	a011                	j	800049c2 <devintr+0xde>
  } else {
    return 0;
    800049c0:	4781                	li	a5,0
  }
}
    800049c2:	853e                	mv	a0,a5
    800049c4:	60e2                	ld	ra,24(sp)
    800049c6:	6442                	ld	s0,16(sp)
    800049c8:	6105                	addi	sp,sp,32
    800049ca:	8082                	ret

00000000800049cc <fetchaddr>:
#include "defs.h"

// Fetch the uint64 at addr from the current process.
int
fetchaddr(uint64 addr, uint64 *ip)
{
    800049cc:	7179                	addi	sp,sp,-48
    800049ce:	f406                	sd	ra,40(sp)
    800049d0:	f022                	sd	s0,32(sp)
    800049d2:	1800                	addi	s0,sp,48
    800049d4:	fca43c23          	sd	a0,-40(s0)
    800049d8:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    800049dc:	ffffe097          	auipc	ra,0xffffe
    800049e0:	03c080e7          	jalr	60(ra) # 80002a18 <myproc>
    800049e4:	fea43423          	sd	a0,-24(s0)
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    800049e8:	fe843783          	ld	a5,-24(s0)
    800049ec:	67bc                	ld	a5,72(a5)
    800049ee:	fd843703          	ld	a4,-40(s0)
    800049f2:	00f77b63          	bgeu	a4,a5,80004a08 <fetchaddr+0x3c>
    800049f6:	fd843783          	ld	a5,-40(s0)
    800049fa:	00878713          	addi	a4,a5,8
    800049fe:	fe843783          	ld	a5,-24(s0)
    80004a02:	67bc                	ld	a5,72(a5)
    80004a04:	00e7f463          	bgeu	a5,a4,80004a0c <fetchaddr+0x40>
    return -1;
    80004a08:	57fd                	li	a5,-1
    80004a0a:	a01d                	j	80004a30 <fetchaddr+0x64>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80004a0c:	fe843783          	ld	a5,-24(s0)
    80004a10:	6bbc                	ld	a5,80(a5)
    80004a12:	46a1                	li	a3,8
    80004a14:	fd843603          	ld	a2,-40(s0)
    80004a18:	fd043583          	ld	a1,-48(s0)
    80004a1c:	853e                	mv	a0,a5
    80004a1e:	ffffe097          	auipc	ra,0xffffe
    80004a22:	a76080e7          	jalr	-1418(ra) # 80002494 <copyin>
    80004a26:	87aa                	mv	a5,a0
    80004a28:	c399                	beqz	a5,80004a2e <fetchaddr+0x62>
    return -1;
    80004a2a:	57fd                	li	a5,-1
    80004a2c:	a011                	j	80004a30 <fetchaddr+0x64>
  return 0;
    80004a2e:	4781                	li	a5,0
}
    80004a30:	853e                	mv	a0,a5
    80004a32:	70a2                	ld	ra,40(sp)
    80004a34:	7402                	ld	s0,32(sp)
    80004a36:	6145                	addi	sp,sp,48
    80004a38:	8082                	ret

0000000080004a3a <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Returns length of string, not including nul, or -1 for error.
int
fetchstr(uint64 addr, char *buf, int max)
{
    80004a3a:	7139                	addi	sp,sp,-64
    80004a3c:	fc06                	sd	ra,56(sp)
    80004a3e:	f822                	sd	s0,48(sp)
    80004a40:	0080                	addi	s0,sp,64
    80004a42:	fca43c23          	sd	a0,-40(s0)
    80004a46:	fcb43823          	sd	a1,-48(s0)
    80004a4a:	87b2                	mv	a5,a2
    80004a4c:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    80004a50:	ffffe097          	auipc	ra,0xffffe
    80004a54:	fc8080e7          	jalr	-56(ra) # 80002a18 <myproc>
    80004a58:	fea43423          	sd	a0,-24(s0)
  int err = copyinstr(p->pagetable, buf, addr, max);
    80004a5c:	fe843783          	ld	a5,-24(s0)
    80004a60:	6bbc                	ld	a5,80(a5)
    80004a62:	fcc42703          	lw	a4,-52(s0)
    80004a66:	86ba                	mv	a3,a4
    80004a68:	fd843603          	ld	a2,-40(s0)
    80004a6c:	fd043583          	ld	a1,-48(s0)
    80004a70:	853e                	mv	a0,a5
    80004a72:	ffffe097          	auipc	ra,0xffffe
    80004a76:	af0080e7          	jalr	-1296(ra) # 80002562 <copyinstr>
    80004a7a:	87aa                	mv	a5,a0
    80004a7c:	fef42223          	sw	a5,-28(s0)
  if(err < 0)
    80004a80:	fe442783          	lw	a5,-28(s0)
    80004a84:	2781                	sext.w	a5,a5
    80004a86:	0007d563          	bgez	a5,80004a90 <fetchstr+0x56>
    return err;
    80004a8a:	fe442783          	lw	a5,-28(s0)
    80004a8e:	a801                	j	80004a9e <fetchstr+0x64>
  return strlen(buf);
    80004a90:	fd043503          	ld	a0,-48(s0)
    80004a94:	ffffd097          	auipc	ra,0xffffd
    80004a98:	d2a080e7          	jalr	-726(ra) # 800017be <strlen>
    80004a9c:	87aa                	mv	a5,a0
}
    80004a9e:	853e                	mv	a0,a5
    80004aa0:	70e2                	ld	ra,56(sp)
    80004aa2:	7442                	ld	s0,48(sp)
    80004aa4:	6121                	addi	sp,sp,64
    80004aa6:	8082                	ret

0000000080004aa8 <argraw>:

static uint64
argraw(int n)
{
    80004aa8:	7179                	addi	sp,sp,-48
    80004aaa:	f406                	sd	ra,40(sp)
    80004aac:	f022                	sd	s0,32(sp)
    80004aae:	1800                	addi	s0,sp,48
    80004ab0:	87aa                	mv	a5,a0
    80004ab2:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80004ab6:	ffffe097          	auipc	ra,0xffffe
    80004aba:	f62080e7          	jalr	-158(ra) # 80002a18 <myproc>
    80004abe:	fea43423          	sd	a0,-24(s0)
  switch (n) {
    80004ac2:	fdc42783          	lw	a5,-36(s0)
    80004ac6:	0007871b          	sext.w	a4,a5
    80004aca:	4795                	li	a5,5
    80004acc:	06e7e263          	bltu	a5,a4,80004b30 <argraw+0x88>
    80004ad0:	fdc46783          	lwu	a5,-36(s0)
    80004ad4:	00279713          	slli	a4,a5,0x2
    80004ad8:	00007797          	auipc	a5,0x7
    80004adc:	a2878793          	addi	a5,a5,-1496 # 8000b500 <etext+0x500>
    80004ae0:	97ba                	add	a5,a5,a4
    80004ae2:	439c                	lw	a5,0(a5)
    80004ae4:	0007871b          	sext.w	a4,a5
    80004ae8:	00007797          	auipc	a5,0x7
    80004aec:	a1878793          	addi	a5,a5,-1512 # 8000b500 <etext+0x500>
    80004af0:	97ba                	add	a5,a5,a4
    80004af2:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80004af4:	fe843783          	ld	a5,-24(s0)
    80004af8:	73bc                	ld	a5,96(a5)
    80004afa:	7bbc                	ld	a5,112(a5)
    80004afc:	a091                	j	80004b40 <argraw+0x98>
  case 1:
    return p->trapframe->a1;
    80004afe:	fe843783          	ld	a5,-24(s0)
    80004b02:	73bc                	ld	a5,96(a5)
    80004b04:	7fbc                	ld	a5,120(a5)
    80004b06:	a82d                	j	80004b40 <argraw+0x98>
  case 2:
    return p->trapframe->a2;
    80004b08:	fe843783          	ld	a5,-24(s0)
    80004b0c:	73bc                	ld	a5,96(a5)
    80004b0e:	63dc                	ld	a5,128(a5)
    80004b10:	a805                	j	80004b40 <argraw+0x98>
  case 3:
    return p->trapframe->a3;
    80004b12:	fe843783          	ld	a5,-24(s0)
    80004b16:	73bc                	ld	a5,96(a5)
    80004b18:	67dc                	ld	a5,136(a5)
    80004b1a:	a01d                	j	80004b40 <argraw+0x98>
  case 4:
    return p->trapframe->a4;
    80004b1c:	fe843783          	ld	a5,-24(s0)
    80004b20:	73bc                	ld	a5,96(a5)
    80004b22:	6bdc                	ld	a5,144(a5)
    80004b24:	a831                	j	80004b40 <argraw+0x98>
  case 5:
    return p->trapframe->a5;
    80004b26:	fe843783          	ld	a5,-24(s0)
    80004b2a:	73bc                	ld	a5,96(a5)
    80004b2c:	6fdc                	ld	a5,152(a5)
    80004b2e:	a809                	j	80004b40 <argraw+0x98>
  }
  panic("argraw");
    80004b30:	00007517          	auipc	a0,0x7
    80004b34:	9c850513          	addi	a0,a0,-1592 # 8000b4f8 <etext+0x4f8>
    80004b38:	ffffc097          	auipc	ra,0xffffc
    80004b3c:	142080e7          	jalr	322(ra) # 80000c7a <panic>
  return -1;
}
    80004b40:	853e                	mv	a0,a5
    80004b42:	70a2                	ld	ra,40(sp)
    80004b44:	7402                	ld	s0,32(sp)
    80004b46:	6145                	addi	sp,sp,48
    80004b48:	8082                	ret

0000000080004b4a <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80004b4a:	1101                	addi	sp,sp,-32
    80004b4c:	ec06                	sd	ra,24(sp)
    80004b4e:	e822                	sd	s0,16(sp)
    80004b50:	1000                	addi	s0,sp,32
    80004b52:	87aa                	mv	a5,a0
    80004b54:	feb43023          	sd	a1,-32(s0)
    80004b58:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    80004b5c:	fec42783          	lw	a5,-20(s0)
    80004b60:	853e                	mv	a0,a5
    80004b62:	00000097          	auipc	ra,0x0
    80004b66:	f46080e7          	jalr	-186(ra) # 80004aa8 <argraw>
    80004b6a:	87aa                	mv	a5,a0
    80004b6c:	0007871b          	sext.w	a4,a5
    80004b70:	fe043783          	ld	a5,-32(s0)
    80004b74:	c398                	sw	a4,0(a5)
  return 0;
    80004b76:	4781                	li	a5,0
}
    80004b78:	853e                	mv	a0,a5
    80004b7a:	60e2                	ld	ra,24(sp)
    80004b7c:	6442                	ld	s0,16(sp)
    80004b7e:	6105                	addi	sp,sp,32
    80004b80:	8082                	ret

0000000080004b82 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80004b82:	1101                	addi	sp,sp,-32
    80004b84:	ec06                	sd	ra,24(sp)
    80004b86:	e822                	sd	s0,16(sp)
    80004b88:	1000                	addi	s0,sp,32
    80004b8a:	87aa                	mv	a5,a0
    80004b8c:	feb43023          	sd	a1,-32(s0)
    80004b90:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    80004b94:	fec42783          	lw	a5,-20(s0)
    80004b98:	853e                	mv	a0,a5
    80004b9a:	00000097          	auipc	ra,0x0
    80004b9e:	f0e080e7          	jalr	-242(ra) # 80004aa8 <argraw>
    80004ba2:	872a                	mv	a4,a0
    80004ba4:	fe043783          	ld	a5,-32(s0)
    80004ba8:	e398                	sd	a4,0(a5)
  return 0;
    80004baa:	4781                	li	a5,0
}
    80004bac:	853e                	mv	a0,a5
    80004bae:	60e2                	ld	ra,24(sp)
    80004bb0:	6442                	ld	s0,16(sp)
    80004bb2:	6105                	addi	sp,sp,32
    80004bb4:	8082                	ret

0000000080004bb6 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80004bb6:	7179                	addi	sp,sp,-48
    80004bb8:	f406                	sd	ra,40(sp)
    80004bba:	f022                	sd	s0,32(sp)
    80004bbc:	1800                	addi	s0,sp,48
    80004bbe:	87aa                	mv	a5,a0
    80004bc0:	fcb43823          	sd	a1,-48(s0)
    80004bc4:	8732                	mv	a4,a2
    80004bc6:	fcf42e23          	sw	a5,-36(s0)
    80004bca:	87ba                	mv	a5,a4
    80004bcc:	fcf42c23          	sw	a5,-40(s0)
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    80004bd0:	fe840713          	addi	a4,s0,-24
    80004bd4:	fdc42783          	lw	a5,-36(s0)
    80004bd8:	85ba                	mv	a1,a4
    80004bda:	853e                	mv	a0,a5
    80004bdc:	00000097          	auipc	ra,0x0
    80004be0:	fa6080e7          	jalr	-90(ra) # 80004b82 <argaddr>
    80004be4:	87aa                	mv	a5,a0
    80004be6:	0007d463          	bgez	a5,80004bee <argstr+0x38>
    return -1;
    80004bea:	57fd                	li	a5,-1
    80004bec:	a831                	j	80004c08 <argstr+0x52>
  return fetchstr(addr, buf, max);
    80004bee:	fe843783          	ld	a5,-24(s0)
    80004bf2:	fd842703          	lw	a4,-40(s0)
    80004bf6:	863a                	mv	a2,a4
    80004bf8:	fd043583          	ld	a1,-48(s0)
    80004bfc:	853e                	mv	a0,a5
    80004bfe:	00000097          	auipc	ra,0x0
    80004c02:	e3c080e7          	jalr	-452(ra) # 80004a3a <fetchstr>
    80004c06:	87aa                	mv	a5,a0
}
    80004c08:	853e                	mv	a0,a5
    80004c0a:	70a2                	ld	ra,40(sp)
    80004c0c:	7402                	ld	s0,32(sp)
    80004c0e:	6145                	addi	sp,sp,48
    80004c10:	8082                	ret

0000000080004c12 <syscall>:
[SYS_join]    sys_join
};

void
syscall(void)
{
    80004c12:	7179                	addi	sp,sp,-48
    80004c14:	f406                	sd	ra,40(sp)
    80004c16:	f022                	sd	s0,32(sp)
    80004c18:	ec26                	sd	s1,24(sp)
    80004c1a:	1800                	addi	s0,sp,48
  int num;
  struct proc *p = myproc();
    80004c1c:	ffffe097          	auipc	ra,0xffffe
    80004c20:	dfc080e7          	jalr	-516(ra) # 80002a18 <myproc>
    80004c24:	fca43c23          	sd	a0,-40(s0)

  num = p->trapframe->a7;
    80004c28:	fd843783          	ld	a5,-40(s0)
    80004c2c:	73bc                	ld	a5,96(a5)
    80004c2e:	77dc                	ld	a5,168(a5)
    80004c30:	fcf42a23          	sw	a5,-44(s0)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80004c34:	fd442783          	lw	a5,-44(s0)
    80004c38:	2781                	sext.w	a5,a5
    80004c3a:	04f05263          	blez	a5,80004c7e <syscall+0x6c>
    80004c3e:	fd442783          	lw	a5,-44(s0)
    80004c42:	873e                	mv	a4,a5
    80004c44:	47dd                	li	a5,23
    80004c46:	02e7ec63          	bltu	a5,a4,80004c7e <syscall+0x6c>
    80004c4a:	00007717          	auipc	a4,0x7
    80004c4e:	d1670713          	addi	a4,a4,-746 # 8000b960 <syscalls>
    80004c52:	fd442783          	lw	a5,-44(s0)
    80004c56:	078e                	slli	a5,a5,0x3
    80004c58:	97ba                	add	a5,a5,a4
    80004c5a:	639c                	ld	a5,0(a5)
    80004c5c:	c38d                	beqz	a5,80004c7e <syscall+0x6c>
    p->trapframe->a0 = syscalls[num]();
    80004c5e:	00007717          	auipc	a4,0x7
    80004c62:	d0270713          	addi	a4,a4,-766 # 8000b960 <syscalls>
    80004c66:	fd442783          	lw	a5,-44(s0)
    80004c6a:	078e                	slli	a5,a5,0x3
    80004c6c:	97ba                	add	a5,a5,a4
    80004c6e:	6398                	ld	a4,0(a5)
    80004c70:	fd843783          	ld	a5,-40(s0)
    80004c74:	73a4                	ld	s1,96(a5)
    80004c76:	9702                	jalr	a4
    80004c78:	87aa                	mv	a5,a0
    80004c7a:	f8bc                	sd	a5,112(s1)
    80004c7c:	a815                	j	80004cb0 <syscall+0x9e>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80004c7e:	fd843783          	ld	a5,-40(s0)
    80004c82:	5b98                	lw	a4,48(a5)
            p->pid, p->name, num);
    80004c84:	fd843783          	ld	a5,-40(s0)
    80004c88:	16878793          	addi	a5,a5,360
    printf("%d %s: unknown sys call %d\n",
    80004c8c:	fd442683          	lw	a3,-44(s0)
    80004c90:	863e                	mv	a2,a5
    80004c92:	85ba                	mv	a1,a4
    80004c94:	00007517          	auipc	a0,0x7
    80004c98:	88450513          	addi	a0,a0,-1916 # 8000b518 <etext+0x518>
    80004c9c:	ffffc097          	auipc	ra,0xffffc
    80004ca0:	d88080e7          	jalr	-632(ra) # 80000a24 <printf>
    p->trapframe->a0 = -1;
    80004ca4:	fd843783          	ld	a5,-40(s0)
    80004ca8:	73bc                	ld	a5,96(a5)
    80004caa:	577d                	li	a4,-1
    80004cac:	fbb8                	sd	a4,112(a5)
  }
}
    80004cae:	0001                	nop
    80004cb0:	0001                	nop
    80004cb2:	70a2                	ld	ra,40(sp)
    80004cb4:	7402                	ld	s0,32(sp)
    80004cb6:	64e2                	ld	s1,24(sp)
    80004cb8:	6145                	addi	sp,sp,48
    80004cba:	8082                	ret

0000000080004cbc <sys_clone>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_clone (void)
{
    80004cbc:	7139                	addi	sp,sp,-64
    80004cbe:	fc06                	sd	ra,56(sp)
    80004cc0:	f822                	sd	s0,48(sp)
    80004cc2:	0080                	addi	s0,sp,64
  uint64 stack;
  uint64 arg;
  uint64 fcn;

   //obtenemos puntero función
   if(argaddr(0, &fcn) < 0){
    80004cc4:	fc840793          	addi	a5,s0,-56
    80004cc8:	85be                	mv	a1,a5
    80004cca:	4501                	li	a0,0
    80004ccc:	00000097          	auipc	ra,0x0
    80004cd0:	eb6080e7          	jalr	-330(ra) # 80004b82 <argaddr>
    80004cd4:	87aa                	mv	a5,a0
    80004cd6:	0007d463          	bgez	a5,80004cde <sys_clone+0x22>
     return -1;
    80004cda:	57fd                	li	a5,-1
    80004cdc:	a071                	j	80004d68 <sys_clone+0xac>
   }

   //obtenemos puntero a argumento de función
   if(argaddr(1, &arg) < 0){
    80004cde:	fd040793          	addi	a5,s0,-48
    80004ce2:	85be                	mv	a1,a5
    80004ce4:	4505                	li	a0,1
    80004ce6:	00000097          	auipc	ra,0x0
    80004cea:	e9c080e7          	jalr	-356(ra) # 80004b82 <argaddr>
    80004cee:	87aa                	mv	a5,a0
    80004cf0:	0007d463          	bgez	a5,80004cf8 <sys_clone+0x3c>
     return -1;
    80004cf4:	57fd                	li	a5,-1
    80004cf6:	a88d                	j	80004d68 <sys_clone+0xac>
   }

   //obtenemos putnero a stack de usuario
   if(argaddr(2, &stack) < 0){
    80004cf8:	fd840793          	addi	a5,s0,-40
    80004cfc:	85be                	mv	a1,a5
    80004cfe:	4509                	li	a0,2
    80004d00:	00000097          	auipc	ra,0x0
    80004d04:	e82080e7          	jalr	-382(ra) # 80004b82 <argaddr>
    80004d08:	87aa                	mv	a5,a0
    80004d0a:	0007d463          	bgez	a5,80004d12 <sys_clone+0x56>
     return -1;
    80004d0e:	57fd                	li	a5,-1
    80004d10:	a8a1                	j	80004d68 <sys_clone+0xac>
   }

  struct proc *p = myproc();
    80004d12:	ffffe097          	auipc	ra,0xffffe
    80004d16:	d06080e7          	jalr	-762(ra) # 80002a18 <myproc>
    80004d1a:	fea43423          	sd	a0,-24(s0)
  uint64 sz = p->sz;
    80004d1e:	fe843783          	ld	a5,-24(s0)
    80004d22:	67bc                	ld	a5,72(a5)
    80004d24:	fef43023          	sd	a5,-32(s0)

   //comprobamos que stack este alineado a pagina
   if ((stack % PGSIZE) != 0 || ((sz - stack) < PGSIZE)){
    80004d28:	fd843703          	ld	a4,-40(s0)
    80004d2c:	6785                	lui	a5,0x1
    80004d2e:	17fd                	addi	a5,a5,-1
    80004d30:	8ff9                	and	a5,a5,a4
    80004d32:	eb89                	bnez	a5,80004d44 <sys_clone+0x88>
    80004d34:	fd843783          	ld	a5,-40(s0)
    80004d38:	fe043703          	ld	a4,-32(s0)
    80004d3c:	8f1d                	sub	a4,a4,a5
    80004d3e:	6785                	lui	a5,0x1
    80004d40:	00f77463          	bgeu	a4,a5,80004d48 <sys_clone+0x8c>
     return -1;
    80004d44:	57fd                	li	a5,-1
    80004d46:	a00d                	j	80004d68 <sys_clone+0xac>
   }

  return clone((void *)fcn, (void *)arg, (void *)stack);
    80004d48:	fc843783          	ld	a5,-56(s0)
    80004d4c:	873e                	mv	a4,a5
    80004d4e:	fd043783          	ld	a5,-48(s0)
    80004d52:	86be                	mv	a3,a5
    80004d54:	fd843783          	ld	a5,-40(s0)
    80004d58:	863e                	mv	a2,a5
    80004d5a:	85b6                	mv	a1,a3
    80004d5c:	853a                	mv	a0,a4
    80004d5e:	fffff097          	auipc	ra,0xfffff
    80004d62:	f2a080e7          	jalr	-214(ra) # 80003c88 <clone>
    80004d66:	87aa                	mv	a5,a0
}
    80004d68:	853e                	mv	a0,a5
    80004d6a:	70e2                	ld	ra,56(sp)
    80004d6c:	7442                	ld	s0,48(sp)
    80004d6e:	6121                	addi	sp,sp,64
    80004d70:	8082                	ret

0000000080004d72 <sys_join>:

uint64
sys_join (void)
{
    80004d72:	1101                	addi	sp,sp,-32
    80004d74:	ec06                	sd	ra,24(sp)
    80004d76:	e822                	sd	s0,16(sp)
    80004d78:	1000                	addi	s0,sp,32
  uint64 stack;
  if(argaddr(0, &stack) < 0){
    80004d7a:	fe840793          	addi	a5,s0,-24
    80004d7e:	85be                	mv	a1,a5
    80004d80:	4501                	li	a0,0
    80004d82:	00000097          	auipc	ra,0x0
    80004d86:	e00080e7          	jalr	-512(ra) # 80004b82 <argaddr>
    80004d8a:	87aa                	mv	a5,a0
    80004d8c:	0007dc63          	bgez	a5,80004da4 <sys_join+0x32>
     printf ("SYSPROC: argumento no valido\n");
    80004d90:	00006517          	auipc	a0,0x6
    80004d94:	7a850513          	addi	a0,a0,1960 # 8000b538 <etext+0x538>
    80004d98:	ffffc097          	auipc	ra,0xffffc
    80004d9c:	c8c080e7          	jalr	-884(ra) # 80000a24 <printf>
     return -1;
    80004da0:	57fd                	li	a5,-1
    80004da2:	a091                	j	80004de6 <sys_join+0x74>
  }

  printf ("SYSPROC: lo que vale stack es: %d\n", stack);
    80004da4:	fe843783          	ld	a5,-24(s0)
    80004da8:	85be                	mv	a1,a5
    80004daa:	00006517          	auipc	a0,0x6
    80004dae:	7ae50513          	addi	a0,a0,1966 # 8000b558 <etext+0x558>
    80004db2:	ffffc097          	auipc	ra,0xffffc
    80004db6:	c72080e7          	jalr	-910(ra) # 80000a24 <printf>

  if (stack % 4 != 0){
    80004dba:	fe843783          	ld	a5,-24(s0)
    80004dbe:	8b8d                	andi	a5,a5,3
    80004dc0:	cb99                	beqz	a5,80004dd6 <sys_join+0x64>
    printf ("SYSPROC: Dirección no alineada a word\n");
    80004dc2:	00006517          	auipc	a0,0x6
    80004dc6:	7be50513          	addi	a0,a0,1982 # 8000b580 <etext+0x580>
    80004dca:	ffffc097          	auipc	ra,0xffffc
    80004dce:	c5a080e7          	jalr	-934(ra) # 80000a24 <printf>
    return -1;
    80004dd2:	57fd                	li	a5,-1
    80004dd4:	a809                	j	80004de6 <sys_join+0x74>
  }

  //hay que comprobar que en la dirección hay algo (aqui o en proc.c)

  return join (stack);
    80004dd6:	fe843783          	ld	a5,-24(s0)
    80004dda:	853e                	mv	a0,a5
    80004ddc:	fffff097          	auipc	ra,0xfffff
    80004de0:	190080e7          	jalr	400(ra) # 80003f6c <join>
    80004de4:	87aa                	mv	a5,a0
}
    80004de6:	853e                	mv	a0,a5
    80004de8:	60e2                	ld	ra,24(sp)
    80004dea:	6442                	ld	s0,16(sp)
    80004dec:	6105                	addi	sp,sp,32
    80004dee:	8082                	ret

0000000080004df0 <sys_exit>:


uint64
sys_exit(void)
{
    80004df0:	1101                	addi	sp,sp,-32
    80004df2:	ec06                	sd	ra,24(sp)
    80004df4:	e822                	sd	s0,16(sp)
    80004df6:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80004df8:	fec40793          	addi	a5,s0,-20
    80004dfc:	85be                	mv	a1,a5
    80004dfe:	4501                	li	a0,0
    80004e00:	00000097          	auipc	ra,0x0
    80004e04:	d4a080e7          	jalr	-694(ra) # 80004b4a <argint>
    80004e08:	87aa                	mv	a5,a0
    80004e0a:	0007d463          	bgez	a5,80004e12 <sys_exit+0x22>
    return -1;
    80004e0e:	57fd                	li	a5,-1
    80004e10:	a809                	j	80004e22 <sys_exit+0x32>
  exit(n);
    80004e12:	fec42783          	lw	a5,-20(s0)
    80004e16:	853e                	mv	a0,a5
    80004e18:	ffffe097          	auipc	ra,0xffffe
    80004e1c:	5ea080e7          	jalr	1514(ra) # 80003402 <exit>
  return 0;  // not reached
    80004e20:	4781                	li	a5,0
}
    80004e22:	853e                	mv	a0,a5
    80004e24:	60e2                	ld	ra,24(sp)
    80004e26:	6442                	ld	s0,16(sp)
    80004e28:	6105                	addi	sp,sp,32
    80004e2a:	8082                	ret

0000000080004e2c <sys_getpid>:

uint64
sys_getpid(void)
{
    80004e2c:	1141                	addi	sp,sp,-16
    80004e2e:	e406                	sd	ra,8(sp)
    80004e30:	e022                	sd	s0,0(sp)
    80004e32:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80004e34:	ffffe097          	auipc	ra,0xffffe
    80004e38:	be4080e7          	jalr	-1052(ra) # 80002a18 <myproc>
    80004e3c:	87aa                	mv	a5,a0
    80004e3e:	5b9c                	lw	a5,48(a5)
}
    80004e40:	853e                	mv	a0,a5
    80004e42:	60a2                	ld	ra,8(sp)
    80004e44:	6402                	ld	s0,0(sp)
    80004e46:	0141                	addi	sp,sp,16
    80004e48:	8082                	ret

0000000080004e4a <sys_fork>:

uint64
sys_fork(void)
{
    80004e4a:	1141                	addi	sp,sp,-16
    80004e4c:	e406                	sd	ra,8(sp)
    80004e4e:	e022                	sd	s0,0(sp)
    80004e50:	0800                	addi	s0,sp,16
  return fork();
    80004e52:	ffffe097          	auipc	ra,0xffffe
    80004e56:	38a080e7          	jalr	906(ra) # 800031dc <fork>
    80004e5a:	87aa                	mv	a5,a0
}
    80004e5c:	853e                	mv	a0,a5
    80004e5e:	60a2                	ld	ra,8(sp)
    80004e60:	6402                	ld	s0,0(sp)
    80004e62:	0141                	addi	sp,sp,16
    80004e64:	8082                	ret

0000000080004e66 <sys_wait>:

uint64
sys_wait(void)
{
    80004e66:	1101                	addi	sp,sp,-32
    80004e68:	ec06                	sd	ra,24(sp)
    80004e6a:	e822                	sd	s0,16(sp)
    80004e6c:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80004e6e:	fe840793          	addi	a5,s0,-24
    80004e72:	85be                	mv	a1,a5
    80004e74:	4501                	li	a0,0
    80004e76:	00000097          	auipc	ra,0x0
    80004e7a:	d0c080e7          	jalr	-756(ra) # 80004b82 <argaddr>
    80004e7e:	87aa                	mv	a5,a0
    80004e80:	0007d463          	bgez	a5,80004e88 <sys_wait+0x22>
    return -1;
    80004e84:	57fd                	li	a5,-1
    80004e86:	a809                	j	80004e98 <sys_wait+0x32>
  return wait(p);
    80004e88:	fe843783          	ld	a5,-24(s0)
    80004e8c:	853e                	mv	a0,a5
    80004e8e:	ffffe097          	auipc	ra,0xffffe
    80004e92:	6b0080e7          	jalr	1712(ra) # 8000353e <wait>
    80004e96:	87aa                	mv	a5,a0
}
    80004e98:	853e                	mv	a0,a5
    80004e9a:	60e2                	ld	ra,24(sp)
    80004e9c:	6442                	ld	s0,16(sp)
    80004e9e:	6105                	addi	sp,sp,32
    80004ea0:	8082                	ret

0000000080004ea2 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80004ea2:	7139                	addi	sp,sp,-64
    80004ea4:	fc06                	sd	ra,56(sp)
    80004ea6:	f822                	sd	s0,48(sp)
    80004ea8:	0080                	addi	s0,sp,64
  int addr;
  int n;
  int referencias;

  if(argint(0, &n) < 0)
    80004eaa:	fcc40793          	addi	a5,s0,-52
    80004eae:	85be                	mv	a1,a5
    80004eb0:	4501                	li	a0,0
    80004eb2:	00000097          	auipc	ra,0x0
    80004eb6:	c98080e7          	jalr	-872(ra) # 80004b4a <argint>
    80004eba:	87aa                	mv	a5,a0
    80004ebc:	0007d463          	bgez	a5,80004ec4 <sys_sbrk+0x22>
    return -1;
    80004ec0:	57fd                	li	a5,-1
    80004ec2:	a8dd                	j	80004fb8 <sys_sbrk+0x116>
  /*Cuando tenemos thrads, realizaremos la misma operación con sbrk.
  El proceso consiste en que desde el proceso padre, se alocata la pagina física
  y se mapea en el resto de threads hijos recursivos (solucionado por el ASID).
  */
  
  struct proc *p = myproc();
    80004ec4:	ffffe097          	auipc	ra,0xffffe
    80004ec8:	b54080e7          	jalr	-1196(ra) # 80002a18 <myproc>
    80004ecc:	fca43c23          	sd	a0,-40(s0)
  struct proc *proceso_padre_threads;
  //tenemos que determinar si somos el proceso padre o thread


  if (p->thread == 0){ //soy proceso
    80004ed0:	fd843703          	ld	a4,-40(s0)
    80004ed4:	67c9                	lui	a5,0x12
    80004ed6:	97ba                	add	a5,a5,a4
    80004ed8:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    80004edc:	ef9d                	bnez	a5,80004f1a <sys_sbrk+0x78>
    
    addr = p->sz;
    80004ede:	fd843783          	ld	a5,-40(s0)
    80004ee2:	67bc                	ld	a5,72(a5)
    80004ee4:	fef42623          	sw	a5,-20(s0)
    if(growproc(n) < 0){
    80004ee8:	fcc42783          	lw	a5,-52(s0)
    80004eec:	853e                	mv	a0,a5
    80004eee:	ffffe097          	auipc	ra,0xffffe
    80004ef2:	096080e7          	jalr	150(ra) # 80002f84 <growproc>
    80004ef6:	87aa                	mv	a5,a0
    80004ef8:	0007d463          	bgez	a5,80004f00 <sys_sbrk+0x5e>
      return -1;
    80004efc:	57fd                	li	a5,-1
    80004efe:	a86d                	j	80004fb8 <sys_sbrk+0x116>
    }

    proceso_padre_threads = p;
    80004f00:	fd843783          	ld	a5,-40(s0)
    80004f04:	fef43023          	sd	a5,-32(s0)
    referencias = p->referencias;
    80004f08:	fd843703          	ld	a4,-40(s0)
    80004f0c:	67c9                	lui	a5,0x12
    80004f0e:	97ba                	add	a5,a5,a4
    80004f10:	18c7a783          	lw	a5,396(a5) # 1218c <_entry-0x7ffede74>
    80004f14:	fef42423          	sw	a5,-24(s0)
    80004f18:	a891                	j	80004f6c <sys_sbrk+0xca>
  } else { //soy thread hijo

      //tengo que buscar al proceso padre o abuelo, bisabuelo... propietario del espacio de direcciones con ASID = pid

      struct proc *proceso;
       if ((proceso = busca_padre(p->ASID)) == 0);
    80004f1a:	fd843783          	ld	a5,-40(s0)
    80004f1e:	5bdc                	lw	a5,52(a5)
    80004f20:	853e                	mv	a0,a5
    80004f22:	fffff097          	auipc	ra,0xfffff
    80004f26:	31a080e7          	jalr	794(ra) # 8000423c <busca_padre>
    80004f2a:	fca43823          	sd	a0,-48(s0)

      addr = proceso->sz;
    80004f2e:	fd043783          	ld	a5,-48(s0)
    80004f32:	67bc                	ld	a5,72(a5)
    80004f34:	fef42623          	sw	a5,-20(s0)
      if(growproc_proceso_padre(n, proceso) < 0){
    80004f38:	fcc42783          	lw	a5,-52(s0)
    80004f3c:	fd043583          	ld	a1,-48(s0)
    80004f40:	853e                	mv	a0,a5
    80004f42:	fffff097          	auipc	ra,0xfffff
    80004f46:	24c080e7          	jalr	588(ra) # 8000418e <growproc_proceso_padre>
    80004f4a:	87aa                	mv	a5,a0
    80004f4c:	0007d463          	bgez	a5,80004f54 <sys_sbrk+0xb2>
        return -1;
    80004f50:	57fd                	li	a5,-1
    80004f52:	a09d                	j	80004fb8 <sys_sbrk+0x116>
      }

      proceso_padre_threads = proceso;
    80004f54:	fd043783          	ld	a5,-48(s0)
    80004f58:	fef43023          	sd	a5,-32(s0)
      referencias = proceso->referencias;
    80004f5c:	fd043703          	ld	a4,-48(s0)
    80004f60:	67c9                	lui	a5,0x12
    80004f62:	97ba                	add	a5,a5,a4
    80004f64:	18c7a783          	lw	a5,396(a5) # 1218c <_entry-0x7ffede74>
    80004f68:	fef42423          	sw	a5,-24(s0)
    páginas fisicas.

    De nuevo, si lo ejecuta un thread, debe pasar el puntero del padre proceso.
  */

  if ((n > 0 && referencias > 0) || p->thread == 1){ //O el proceso que ejecuta sbrk tiene más de una referencia o es un thread, alocatamos y mapeamos del padre a todos los procesos hijo
    80004f6c:	fcc42783          	lw	a5,-52(s0)
    80004f70:	00f05763          	blez	a5,80004f7e <sys_sbrk+0xdc>
    80004f74:	fe842783          	lw	a5,-24(s0)
    80004f78:	2781                	sext.w	a5,a5
    80004f7a:	00f04c63          	bgtz	a5,80004f92 <sys_sbrk+0xf0>
    80004f7e:	fd843703          	ld	a4,-40(s0)
    80004f82:	67c9                	lui	a5,0x12
    80004f84:	97ba                	add	a5,a5,a4
    80004f86:	1887a783          	lw	a5,392(a5) # 12188 <_entry-0x7ffede78>
    80004f8a:	873e                	mv	a4,a5
    80004f8c:	4785                	li	a5,1
    80004f8e:	02f71363          	bne	a4,a5,80004fb4 <sys_sbrk+0x112>
    if ((check_grow_threads (proceso_padre_threads, n,addr))<0){
    80004f92:	fcc42783          	lw	a5,-52(s0)
    80004f96:	fec42703          	lw	a4,-20(s0)
    80004f9a:	863a                	mv	a2,a4
    80004f9c:	85be                	mv	a1,a5
    80004f9e:	fe043503          	ld	a0,-32(s0)
    80004fa2:	ffffe097          	auipc	ra,0xffffe
    80004fa6:	098080e7          	jalr	152(ra) # 8000303a <check_grow_threads>
    80004faa:	87aa                	mv	a5,a0
    80004fac:	0007d463          	bgez	a5,80004fb4 <sys_sbrk+0x112>
      return -1;
    80004fb0:	57fd                	li	a5,-1
    80004fb2:	a019                	j	80004fb8 <sys_sbrk+0x116>
    }

  }

  return addr;
    80004fb4:	fec42783          	lw	a5,-20(s0)
}
    80004fb8:	853e                	mv	a0,a5
    80004fba:	70e2                	ld	ra,56(sp)
    80004fbc:	7442                	ld	s0,48(sp)
    80004fbe:	6121                	addi	sp,sp,64
    80004fc0:	8082                	ret

0000000080004fc2 <sys_sleep>:

uint64
sys_sleep(void)
{
    80004fc2:	1101                	addi	sp,sp,-32
    80004fc4:	ec06                	sd	ra,24(sp)
    80004fc6:	e822                	sd	s0,16(sp)
    80004fc8:	1000                	addi	s0,sp,32
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80004fca:	fe840793          	addi	a5,s0,-24
    80004fce:	85be                	mv	a1,a5
    80004fd0:	4501                	li	a0,0
    80004fd2:	00000097          	auipc	ra,0x0
    80004fd6:	b78080e7          	jalr	-1160(ra) # 80004b4a <argint>
    80004fda:	87aa                	mv	a5,a0
    80004fdc:	0007d463          	bgez	a5,80004fe4 <sys_sleep+0x22>
    return -1;
    80004fe0:	57fd                	li	a5,-1
    80004fe2:	a071                	j	8000506e <sys_sleep+0xac>
  acquire(&tickslock);
    80004fe4:	00496517          	auipc	a0,0x496
    80004fe8:	ae450513          	addi	a0,a0,-1308 # 8049aac8 <tickslock>
    80004fec:	ffffc097          	auipc	ra,0xffffc
    80004ff0:	27e080e7          	jalr	638(ra) # 8000126a <acquire>
  ticks0 = ticks;
    80004ff4:	00007797          	auipc	a5,0x7
    80004ff8:	03478793          	addi	a5,a5,52 # 8000c028 <ticks>
    80004ffc:	439c                	lw	a5,0(a5)
    80004ffe:	fef42623          	sw	a5,-20(s0)
  while(ticks - ticks0 < n){
    80005002:	a835                	j	8000503e <sys_sleep+0x7c>
    if(myproc()->killed){
    80005004:	ffffe097          	auipc	ra,0xffffe
    80005008:	a14080e7          	jalr	-1516(ra) # 80002a18 <myproc>
    8000500c:	87aa                	mv	a5,a0
    8000500e:	579c                	lw	a5,40(a5)
    80005010:	cb99                	beqz	a5,80005026 <sys_sleep+0x64>
      release(&tickslock);
    80005012:	00496517          	auipc	a0,0x496
    80005016:	ab650513          	addi	a0,a0,-1354 # 8049aac8 <tickslock>
    8000501a:	ffffc097          	auipc	ra,0xffffc
    8000501e:	2b4080e7          	jalr	692(ra) # 800012ce <release>
      return -1;
    80005022:	57fd                	li	a5,-1
    80005024:	a0a9                	j	8000506e <sys_sleep+0xac>
    }
    sleep(&ticks, &tickslock);
    80005026:	00496597          	auipc	a1,0x496
    8000502a:	aa258593          	addi	a1,a1,-1374 # 8049aac8 <tickslock>
    8000502e:	00007517          	auipc	a0,0x7
    80005032:	ffa50513          	addi	a0,a0,-6 # 8000c028 <ticks>
    80005036:	fffff097          	auipc	ra,0xfffff
    8000503a:	8cc080e7          	jalr	-1844(ra) # 80003902 <sleep>
  while(ticks - ticks0 < n){
    8000503e:	00007797          	auipc	a5,0x7
    80005042:	fea78793          	addi	a5,a5,-22 # 8000c028 <ticks>
    80005046:	439c                	lw	a5,0(a5)
    80005048:	fec42703          	lw	a4,-20(s0)
    8000504c:	9f99                	subw	a5,a5,a4
    8000504e:	0007871b          	sext.w	a4,a5
    80005052:	fe842783          	lw	a5,-24(s0)
    80005056:	2781                	sext.w	a5,a5
    80005058:	faf766e3          	bltu	a4,a5,80005004 <sys_sleep+0x42>
  }
  release(&tickslock);
    8000505c:	00496517          	auipc	a0,0x496
    80005060:	a6c50513          	addi	a0,a0,-1428 # 8049aac8 <tickslock>
    80005064:	ffffc097          	auipc	ra,0xffffc
    80005068:	26a080e7          	jalr	618(ra) # 800012ce <release>
  return 0;
    8000506c:	4781                	li	a5,0
}
    8000506e:	853e                	mv	a0,a5
    80005070:	60e2                	ld	ra,24(sp)
    80005072:	6442                	ld	s0,16(sp)
    80005074:	6105                	addi	sp,sp,32
    80005076:	8082                	ret

0000000080005078 <sys_kill>:

uint64
sys_kill(void)
{
    80005078:	1101                	addi	sp,sp,-32
    8000507a:	ec06                	sd	ra,24(sp)
    8000507c:	e822                	sd	s0,16(sp)
    8000507e:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80005080:	fec40793          	addi	a5,s0,-20
    80005084:	85be                	mv	a1,a5
    80005086:	4501                	li	a0,0
    80005088:	00000097          	auipc	ra,0x0
    8000508c:	ac2080e7          	jalr	-1342(ra) # 80004b4a <argint>
    80005090:	87aa                	mv	a5,a0
    80005092:	0007d463          	bgez	a5,8000509a <sys_kill+0x22>
    return -1;
    80005096:	57fd                	li	a5,-1
    80005098:	a809                	j	800050aa <sys_kill+0x32>
  return kill(pid);
    8000509a:	fec42783          	lw	a5,-20(s0)
    8000509e:	853e                	mv	a0,a5
    800050a0:	fffff097          	auipc	ra,0xfffff
    800050a4:	976080e7          	jalr	-1674(ra) # 80003a16 <kill>
    800050a8:	87aa                	mv	a5,a0
}
    800050aa:	853e                	mv	a0,a5
    800050ac:	60e2                	ld	ra,24(sp)
    800050ae:	6442                	ld	s0,16(sp)
    800050b0:	6105                	addi	sp,sp,32
    800050b2:	8082                	ret

00000000800050b4 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800050b4:	1101                	addi	sp,sp,-32
    800050b6:	ec06                	sd	ra,24(sp)
    800050b8:	e822                	sd	s0,16(sp)
    800050ba:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800050bc:	00496517          	auipc	a0,0x496
    800050c0:	a0c50513          	addi	a0,a0,-1524 # 8049aac8 <tickslock>
    800050c4:	ffffc097          	auipc	ra,0xffffc
    800050c8:	1a6080e7          	jalr	422(ra) # 8000126a <acquire>
  xticks = ticks;
    800050cc:	00007797          	auipc	a5,0x7
    800050d0:	f5c78793          	addi	a5,a5,-164 # 8000c028 <ticks>
    800050d4:	439c                	lw	a5,0(a5)
    800050d6:	fef42623          	sw	a5,-20(s0)
  release(&tickslock);
    800050da:	00496517          	auipc	a0,0x496
    800050de:	9ee50513          	addi	a0,a0,-1554 # 8049aac8 <tickslock>
    800050e2:	ffffc097          	auipc	ra,0xffffc
    800050e6:	1ec080e7          	jalr	492(ra) # 800012ce <release>
  return xticks;
    800050ea:	fec46783          	lwu	a5,-20(s0)
}
    800050ee:	853e                	mv	a0,a5
    800050f0:	60e2                	ld	ra,24(sp)
    800050f2:	6442                	ld	s0,16(sp)
    800050f4:	6105                	addi	sp,sp,32
    800050f6:	8082                	ret

00000000800050f8 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    800050f8:	1101                	addi	sp,sp,-32
    800050fa:	ec06                	sd	ra,24(sp)
    800050fc:	e822                	sd	s0,16(sp)
    800050fe:	1000                	addi	s0,sp,32
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80005100:	00006597          	auipc	a1,0x6
    80005104:	4a858593          	addi	a1,a1,1192 # 8000b5a8 <etext+0x5a8>
    80005108:	00496517          	auipc	a0,0x496
    8000510c:	9d850513          	addi	a0,a0,-1576 # 8049aae0 <bcache>
    80005110:	ffffc097          	auipc	ra,0xffffc
    80005114:	12a080e7          	jalr	298(ra) # 8000123a <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80005118:	00496717          	auipc	a4,0x496
    8000511c:	9c870713          	addi	a4,a4,-1592 # 8049aae0 <bcache>
    80005120:	67a1                	lui	a5,0x8
    80005122:	97ba                	add	a5,a5,a4
    80005124:	0049e717          	auipc	a4,0x49e
    80005128:	c2470713          	addi	a4,a4,-988 # 804a2d48 <bcache+0x8268>
    8000512c:	2ae7b823          	sd	a4,688(a5) # 82b0 <_entry-0x7fff7d50>
  bcache.head.next = &bcache.head;
    80005130:	00496717          	auipc	a4,0x496
    80005134:	9b070713          	addi	a4,a4,-1616 # 8049aae0 <bcache>
    80005138:	67a1                	lui	a5,0x8
    8000513a:	97ba                	add	a5,a5,a4
    8000513c:	0049e717          	auipc	a4,0x49e
    80005140:	c0c70713          	addi	a4,a4,-1012 # 804a2d48 <bcache+0x8268>
    80005144:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80005148:	00496797          	auipc	a5,0x496
    8000514c:	9b078793          	addi	a5,a5,-1616 # 8049aaf8 <bcache+0x18>
    80005150:	fef43423          	sd	a5,-24(s0)
    80005154:	a895                	j	800051c8 <binit+0xd0>
    b->next = bcache.head.next;
    80005156:	00496717          	auipc	a4,0x496
    8000515a:	98a70713          	addi	a4,a4,-1654 # 8049aae0 <bcache>
    8000515e:	67a1                	lui	a5,0x8
    80005160:	97ba                	add	a5,a5,a4
    80005162:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    80005166:	fe843783          	ld	a5,-24(s0)
    8000516a:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    8000516c:	fe843783          	ld	a5,-24(s0)
    80005170:	0049e717          	auipc	a4,0x49e
    80005174:	bd870713          	addi	a4,a4,-1064 # 804a2d48 <bcache+0x8268>
    80005178:	e7b8                	sd	a4,72(a5)
    initsleeplock(&b->lock, "buffer");
    8000517a:	fe843783          	ld	a5,-24(s0)
    8000517e:	07c1                	addi	a5,a5,16
    80005180:	00006597          	auipc	a1,0x6
    80005184:	43058593          	addi	a1,a1,1072 # 8000b5b0 <etext+0x5b0>
    80005188:	853e                	mv	a0,a5
    8000518a:	00002097          	auipc	ra,0x2
    8000518e:	fee080e7          	jalr	-18(ra) # 80007178 <initsleeplock>
    bcache.head.next->prev = b;
    80005192:	00496717          	auipc	a4,0x496
    80005196:	94e70713          	addi	a4,a4,-1714 # 8049aae0 <bcache>
    8000519a:	67a1                	lui	a5,0x8
    8000519c:	97ba                	add	a5,a5,a4
    8000519e:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    800051a2:	fe843703          	ld	a4,-24(s0)
    800051a6:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    800051a8:	00496717          	auipc	a4,0x496
    800051ac:	93870713          	addi	a4,a4,-1736 # 8049aae0 <bcache>
    800051b0:	67a1                	lui	a5,0x8
    800051b2:	97ba                	add	a5,a5,a4
    800051b4:	fe843703          	ld	a4,-24(s0)
    800051b8:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800051bc:	fe843783          	ld	a5,-24(s0)
    800051c0:	45878793          	addi	a5,a5,1112
    800051c4:	fef43423          	sd	a5,-24(s0)
    800051c8:	0049e797          	auipc	a5,0x49e
    800051cc:	b8078793          	addi	a5,a5,-1152 # 804a2d48 <bcache+0x8268>
    800051d0:	fe843703          	ld	a4,-24(s0)
    800051d4:	f8f761e3          	bltu	a4,a5,80005156 <binit+0x5e>
  }
}
    800051d8:	0001                	nop
    800051da:	0001                	nop
    800051dc:	60e2                	ld	ra,24(sp)
    800051de:	6442                	ld	s0,16(sp)
    800051e0:	6105                	addi	sp,sp,32
    800051e2:	8082                	ret

00000000800051e4 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    800051e4:	7179                	addi	sp,sp,-48
    800051e6:	f406                	sd	ra,40(sp)
    800051e8:	f022                	sd	s0,32(sp)
    800051ea:	1800                	addi	s0,sp,48
    800051ec:	87aa                	mv	a5,a0
    800051ee:	872e                	mv	a4,a1
    800051f0:	fcf42e23          	sw	a5,-36(s0)
    800051f4:	87ba                	mv	a5,a4
    800051f6:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  acquire(&bcache.lock);
    800051fa:	00496517          	auipc	a0,0x496
    800051fe:	8e650513          	addi	a0,a0,-1818 # 8049aae0 <bcache>
    80005202:	ffffc097          	auipc	ra,0xffffc
    80005206:	068080e7          	jalr	104(ra) # 8000126a <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    8000520a:	00496717          	auipc	a4,0x496
    8000520e:	8d670713          	addi	a4,a4,-1834 # 8049aae0 <bcache>
    80005212:	67a1                	lui	a5,0x8
    80005214:	97ba                	add	a5,a5,a4
    80005216:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    8000521a:	fef43423          	sd	a5,-24(s0)
    8000521e:	a095                	j	80005282 <bget+0x9e>
    if(b->dev == dev && b->blockno == blockno){
    80005220:	fe843783          	ld	a5,-24(s0)
    80005224:	4798                	lw	a4,8(a5)
    80005226:	fdc42783          	lw	a5,-36(s0)
    8000522a:	2781                	sext.w	a5,a5
    8000522c:	04e79663          	bne	a5,a4,80005278 <bget+0x94>
    80005230:	fe843783          	ld	a5,-24(s0)
    80005234:	47d8                	lw	a4,12(a5)
    80005236:	fd842783          	lw	a5,-40(s0)
    8000523a:	2781                	sext.w	a5,a5
    8000523c:	02e79e63          	bne	a5,a4,80005278 <bget+0x94>
      b->refcnt++;
    80005240:	fe843783          	ld	a5,-24(s0)
    80005244:	43bc                	lw	a5,64(a5)
    80005246:	2785                	addiw	a5,a5,1
    80005248:	0007871b          	sext.w	a4,a5
    8000524c:	fe843783          	ld	a5,-24(s0)
    80005250:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    80005252:	00496517          	auipc	a0,0x496
    80005256:	88e50513          	addi	a0,a0,-1906 # 8049aae0 <bcache>
    8000525a:	ffffc097          	auipc	ra,0xffffc
    8000525e:	074080e7          	jalr	116(ra) # 800012ce <release>
      acquiresleep(&b->lock);
    80005262:	fe843783          	ld	a5,-24(s0)
    80005266:	07c1                	addi	a5,a5,16
    80005268:	853e                	mv	a0,a5
    8000526a:	00002097          	auipc	ra,0x2
    8000526e:	f5a080e7          	jalr	-166(ra) # 800071c4 <acquiresleep>
      return b;
    80005272:	fe843783          	ld	a5,-24(s0)
    80005276:	a07d                	j	80005324 <bget+0x140>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80005278:	fe843783          	ld	a5,-24(s0)
    8000527c:	6bbc                	ld	a5,80(a5)
    8000527e:	fef43423          	sd	a5,-24(s0)
    80005282:	fe843703          	ld	a4,-24(s0)
    80005286:	0049e797          	auipc	a5,0x49e
    8000528a:	ac278793          	addi	a5,a5,-1342 # 804a2d48 <bcache+0x8268>
    8000528e:	f8f719e3          	bne	a4,a5,80005220 <bget+0x3c>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80005292:	00496717          	auipc	a4,0x496
    80005296:	84e70713          	addi	a4,a4,-1970 # 8049aae0 <bcache>
    8000529a:	67a1                	lui	a5,0x8
    8000529c:	97ba                	add	a5,a5,a4
    8000529e:	2b07b783          	ld	a5,688(a5) # 82b0 <_entry-0x7fff7d50>
    800052a2:	fef43423          	sd	a5,-24(s0)
    800052a6:	a8b9                	j	80005304 <bget+0x120>
    if(b->refcnt == 0) {
    800052a8:	fe843783          	ld	a5,-24(s0)
    800052ac:	43bc                	lw	a5,64(a5)
    800052ae:	e7b1                	bnez	a5,800052fa <bget+0x116>
      b->dev = dev;
    800052b0:	fe843783          	ld	a5,-24(s0)
    800052b4:	fdc42703          	lw	a4,-36(s0)
    800052b8:	c798                	sw	a4,8(a5)
      b->blockno = blockno;
    800052ba:	fe843783          	ld	a5,-24(s0)
    800052be:	fd842703          	lw	a4,-40(s0)
    800052c2:	c7d8                	sw	a4,12(a5)
      b->valid = 0;
    800052c4:	fe843783          	ld	a5,-24(s0)
    800052c8:	0007a023          	sw	zero,0(a5)
      b->refcnt = 1;
    800052cc:	fe843783          	ld	a5,-24(s0)
    800052d0:	4705                	li	a4,1
    800052d2:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    800052d4:	00496517          	auipc	a0,0x496
    800052d8:	80c50513          	addi	a0,a0,-2036 # 8049aae0 <bcache>
    800052dc:	ffffc097          	auipc	ra,0xffffc
    800052e0:	ff2080e7          	jalr	-14(ra) # 800012ce <release>
      acquiresleep(&b->lock);
    800052e4:	fe843783          	ld	a5,-24(s0)
    800052e8:	07c1                	addi	a5,a5,16
    800052ea:	853e                	mv	a0,a5
    800052ec:	00002097          	auipc	ra,0x2
    800052f0:	ed8080e7          	jalr	-296(ra) # 800071c4 <acquiresleep>
      return b;
    800052f4:	fe843783          	ld	a5,-24(s0)
    800052f8:	a035                	j	80005324 <bget+0x140>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800052fa:	fe843783          	ld	a5,-24(s0)
    800052fe:	67bc                	ld	a5,72(a5)
    80005300:	fef43423          	sd	a5,-24(s0)
    80005304:	fe843703          	ld	a4,-24(s0)
    80005308:	0049e797          	auipc	a5,0x49e
    8000530c:	a4078793          	addi	a5,a5,-1472 # 804a2d48 <bcache+0x8268>
    80005310:	f8f71ce3          	bne	a4,a5,800052a8 <bget+0xc4>
    }
  }
  panic("bget: no buffers");
    80005314:	00006517          	auipc	a0,0x6
    80005318:	2a450513          	addi	a0,a0,676 # 8000b5b8 <etext+0x5b8>
    8000531c:	ffffc097          	auipc	ra,0xffffc
    80005320:	95e080e7          	jalr	-1698(ra) # 80000c7a <panic>
}
    80005324:	853e                	mv	a0,a5
    80005326:	70a2                	ld	ra,40(sp)
    80005328:	7402                	ld	s0,32(sp)
    8000532a:	6145                	addi	sp,sp,48
    8000532c:	8082                	ret

000000008000532e <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    8000532e:	7179                	addi	sp,sp,-48
    80005330:	f406                	sd	ra,40(sp)
    80005332:	f022                	sd	s0,32(sp)
    80005334:	1800                	addi	s0,sp,48
    80005336:	87aa                	mv	a5,a0
    80005338:	872e                	mv	a4,a1
    8000533a:	fcf42e23          	sw	a5,-36(s0)
    8000533e:	87ba                	mv	a5,a4
    80005340:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  b = bget(dev, blockno);
    80005344:	fd842703          	lw	a4,-40(s0)
    80005348:	fdc42783          	lw	a5,-36(s0)
    8000534c:	85ba                	mv	a1,a4
    8000534e:	853e                	mv	a0,a5
    80005350:	00000097          	auipc	ra,0x0
    80005354:	e94080e7          	jalr	-364(ra) # 800051e4 <bget>
    80005358:	fea43423          	sd	a0,-24(s0)
  if(!b->valid) {
    8000535c:	fe843783          	ld	a5,-24(s0)
    80005360:	439c                	lw	a5,0(a5)
    80005362:	ef81                	bnez	a5,8000537a <bread+0x4c>
    virtio_disk_rw(b, 0);
    80005364:	4581                	li	a1,0
    80005366:	fe843503          	ld	a0,-24(s0)
    8000536a:	00004097          	auipc	ra,0x4
    8000536e:	742080e7          	jalr	1858(ra) # 80009aac <virtio_disk_rw>
    b->valid = 1;
    80005372:	fe843783          	ld	a5,-24(s0)
    80005376:	4705                	li	a4,1
    80005378:	c398                	sw	a4,0(a5)
  }
  return b;
    8000537a:	fe843783          	ld	a5,-24(s0)
}
    8000537e:	853e                	mv	a0,a5
    80005380:	70a2                	ld	ra,40(sp)
    80005382:	7402                	ld	s0,32(sp)
    80005384:	6145                	addi	sp,sp,48
    80005386:	8082                	ret

0000000080005388 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80005388:	1101                	addi	sp,sp,-32
    8000538a:	ec06                	sd	ra,24(sp)
    8000538c:	e822                	sd	s0,16(sp)
    8000538e:	1000                	addi	s0,sp,32
    80005390:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    80005394:	fe843783          	ld	a5,-24(s0)
    80005398:	07c1                	addi	a5,a5,16
    8000539a:	853e                	mv	a0,a5
    8000539c:	00002097          	auipc	ra,0x2
    800053a0:	ee8080e7          	jalr	-280(ra) # 80007284 <holdingsleep>
    800053a4:	87aa                	mv	a5,a0
    800053a6:	eb89                	bnez	a5,800053b8 <bwrite+0x30>
    panic("bwrite");
    800053a8:	00006517          	auipc	a0,0x6
    800053ac:	22850513          	addi	a0,a0,552 # 8000b5d0 <etext+0x5d0>
    800053b0:	ffffc097          	auipc	ra,0xffffc
    800053b4:	8ca080e7          	jalr	-1846(ra) # 80000c7a <panic>
  virtio_disk_rw(b, 1);
    800053b8:	4585                	li	a1,1
    800053ba:	fe843503          	ld	a0,-24(s0)
    800053be:	00004097          	auipc	ra,0x4
    800053c2:	6ee080e7          	jalr	1774(ra) # 80009aac <virtio_disk_rw>
}
    800053c6:	0001                	nop
    800053c8:	60e2                	ld	ra,24(sp)
    800053ca:	6442                	ld	s0,16(sp)
    800053cc:	6105                	addi	sp,sp,32
    800053ce:	8082                	ret

00000000800053d0 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800053d0:	1101                	addi	sp,sp,-32
    800053d2:	ec06                	sd	ra,24(sp)
    800053d4:	e822                	sd	s0,16(sp)
    800053d6:	1000                	addi	s0,sp,32
    800053d8:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    800053dc:	fe843783          	ld	a5,-24(s0)
    800053e0:	07c1                	addi	a5,a5,16
    800053e2:	853e                	mv	a0,a5
    800053e4:	00002097          	auipc	ra,0x2
    800053e8:	ea0080e7          	jalr	-352(ra) # 80007284 <holdingsleep>
    800053ec:	87aa                	mv	a5,a0
    800053ee:	eb89                	bnez	a5,80005400 <brelse+0x30>
    panic("brelse");
    800053f0:	00006517          	auipc	a0,0x6
    800053f4:	1e850513          	addi	a0,a0,488 # 8000b5d8 <etext+0x5d8>
    800053f8:	ffffc097          	auipc	ra,0xffffc
    800053fc:	882080e7          	jalr	-1918(ra) # 80000c7a <panic>

  releasesleep(&b->lock);
    80005400:	fe843783          	ld	a5,-24(s0)
    80005404:	07c1                	addi	a5,a5,16
    80005406:	853e                	mv	a0,a5
    80005408:	00002097          	auipc	ra,0x2
    8000540c:	e2a080e7          	jalr	-470(ra) # 80007232 <releasesleep>

  acquire(&bcache.lock);
    80005410:	00495517          	auipc	a0,0x495
    80005414:	6d050513          	addi	a0,a0,1744 # 8049aae0 <bcache>
    80005418:	ffffc097          	auipc	ra,0xffffc
    8000541c:	e52080e7          	jalr	-430(ra) # 8000126a <acquire>
  b->refcnt--;
    80005420:	fe843783          	ld	a5,-24(s0)
    80005424:	43bc                	lw	a5,64(a5)
    80005426:	37fd                	addiw	a5,a5,-1
    80005428:	0007871b          	sext.w	a4,a5
    8000542c:	fe843783          	ld	a5,-24(s0)
    80005430:	c3b8                	sw	a4,64(a5)
  if (b->refcnt == 0) {
    80005432:	fe843783          	ld	a5,-24(s0)
    80005436:	43bc                	lw	a5,64(a5)
    80005438:	e7b5                	bnez	a5,800054a4 <brelse+0xd4>
    // no one is waiting for it.
    b->next->prev = b->prev;
    8000543a:	fe843783          	ld	a5,-24(s0)
    8000543e:	6bbc                	ld	a5,80(a5)
    80005440:	fe843703          	ld	a4,-24(s0)
    80005444:	6738                	ld	a4,72(a4)
    80005446:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80005448:	fe843783          	ld	a5,-24(s0)
    8000544c:	67bc                	ld	a5,72(a5)
    8000544e:	fe843703          	ld	a4,-24(s0)
    80005452:	6b38                	ld	a4,80(a4)
    80005454:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80005456:	00495717          	auipc	a4,0x495
    8000545a:	68a70713          	addi	a4,a4,1674 # 8049aae0 <bcache>
    8000545e:	67a1                	lui	a5,0x8
    80005460:	97ba                	add	a5,a5,a4
    80005462:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    80005466:	fe843783          	ld	a5,-24(s0)
    8000546a:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    8000546c:	fe843783          	ld	a5,-24(s0)
    80005470:	0049e717          	auipc	a4,0x49e
    80005474:	8d870713          	addi	a4,a4,-1832 # 804a2d48 <bcache+0x8268>
    80005478:	e7b8                	sd	a4,72(a5)
    bcache.head.next->prev = b;
    8000547a:	00495717          	auipc	a4,0x495
    8000547e:	66670713          	addi	a4,a4,1638 # 8049aae0 <bcache>
    80005482:	67a1                	lui	a5,0x8
    80005484:	97ba                	add	a5,a5,a4
    80005486:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    8000548a:	fe843703          	ld	a4,-24(s0)
    8000548e:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    80005490:	00495717          	auipc	a4,0x495
    80005494:	65070713          	addi	a4,a4,1616 # 8049aae0 <bcache>
    80005498:	67a1                	lui	a5,0x8
    8000549a:	97ba                	add	a5,a5,a4
    8000549c:	fe843703          	ld	a4,-24(s0)
    800054a0:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  }
  
  release(&bcache.lock);
    800054a4:	00495517          	auipc	a0,0x495
    800054a8:	63c50513          	addi	a0,a0,1596 # 8049aae0 <bcache>
    800054ac:	ffffc097          	auipc	ra,0xffffc
    800054b0:	e22080e7          	jalr	-478(ra) # 800012ce <release>
}
    800054b4:	0001                	nop
    800054b6:	60e2                	ld	ra,24(sp)
    800054b8:	6442                	ld	s0,16(sp)
    800054ba:	6105                	addi	sp,sp,32
    800054bc:	8082                	ret

00000000800054be <bpin>:

void
bpin(struct buf *b) {
    800054be:	1101                	addi	sp,sp,-32
    800054c0:	ec06                	sd	ra,24(sp)
    800054c2:	e822                	sd	s0,16(sp)
    800054c4:	1000                	addi	s0,sp,32
    800054c6:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    800054ca:	00495517          	auipc	a0,0x495
    800054ce:	61650513          	addi	a0,a0,1558 # 8049aae0 <bcache>
    800054d2:	ffffc097          	auipc	ra,0xffffc
    800054d6:	d98080e7          	jalr	-616(ra) # 8000126a <acquire>
  b->refcnt++;
    800054da:	fe843783          	ld	a5,-24(s0)
    800054de:	43bc                	lw	a5,64(a5)
    800054e0:	2785                	addiw	a5,a5,1
    800054e2:	0007871b          	sext.w	a4,a5
    800054e6:	fe843783          	ld	a5,-24(s0)
    800054ea:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    800054ec:	00495517          	auipc	a0,0x495
    800054f0:	5f450513          	addi	a0,a0,1524 # 8049aae0 <bcache>
    800054f4:	ffffc097          	auipc	ra,0xffffc
    800054f8:	dda080e7          	jalr	-550(ra) # 800012ce <release>
}
    800054fc:	0001                	nop
    800054fe:	60e2                	ld	ra,24(sp)
    80005500:	6442                	ld	s0,16(sp)
    80005502:	6105                	addi	sp,sp,32
    80005504:	8082                	ret

0000000080005506 <bunpin>:

void
bunpin(struct buf *b) {
    80005506:	1101                	addi	sp,sp,-32
    80005508:	ec06                	sd	ra,24(sp)
    8000550a:	e822                	sd	s0,16(sp)
    8000550c:	1000                	addi	s0,sp,32
    8000550e:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80005512:	00495517          	auipc	a0,0x495
    80005516:	5ce50513          	addi	a0,a0,1486 # 8049aae0 <bcache>
    8000551a:	ffffc097          	auipc	ra,0xffffc
    8000551e:	d50080e7          	jalr	-688(ra) # 8000126a <acquire>
  b->refcnt--;
    80005522:	fe843783          	ld	a5,-24(s0)
    80005526:	43bc                	lw	a5,64(a5)
    80005528:	37fd                	addiw	a5,a5,-1
    8000552a:	0007871b          	sext.w	a4,a5
    8000552e:	fe843783          	ld	a5,-24(s0)
    80005532:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80005534:	00495517          	auipc	a0,0x495
    80005538:	5ac50513          	addi	a0,a0,1452 # 8049aae0 <bcache>
    8000553c:	ffffc097          	auipc	ra,0xffffc
    80005540:	d92080e7          	jalr	-622(ra) # 800012ce <release>
}
    80005544:	0001                	nop
    80005546:	60e2                	ld	ra,24(sp)
    80005548:	6442                	ld	s0,16(sp)
    8000554a:	6105                	addi	sp,sp,32
    8000554c:	8082                	ret

000000008000554e <readsb>:
struct superblock sb; 

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
    8000554e:	7179                	addi	sp,sp,-48
    80005550:	f406                	sd	ra,40(sp)
    80005552:	f022                	sd	s0,32(sp)
    80005554:	1800                	addi	s0,sp,48
    80005556:	87aa                	mv	a5,a0
    80005558:	fcb43823          	sd	a1,-48(s0)
    8000555c:	fcf42e23          	sw	a5,-36(s0)
  struct buf *bp;

  bp = bread(dev, 1);
    80005560:	fdc42783          	lw	a5,-36(s0)
    80005564:	4585                	li	a1,1
    80005566:	853e                	mv	a0,a5
    80005568:	00000097          	auipc	ra,0x0
    8000556c:	dc6080e7          	jalr	-570(ra) # 8000532e <bread>
    80005570:	fea43423          	sd	a0,-24(s0)
  memmove(sb, bp->data, sizeof(*sb));
    80005574:	fe843783          	ld	a5,-24(s0)
    80005578:	05878793          	addi	a5,a5,88
    8000557c:	02000613          	li	a2,32
    80005580:	85be                	mv	a1,a5
    80005582:	fd043503          	ld	a0,-48(s0)
    80005586:	ffffc097          	auipc	ra,0xffffc
    8000558a:	f9c080e7          	jalr	-100(ra) # 80001522 <memmove>
  brelse(bp);
    8000558e:	fe843503          	ld	a0,-24(s0)
    80005592:	00000097          	auipc	ra,0x0
    80005596:	e3e080e7          	jalr	-450(ra) # 800053d0 <brelse>
}
    8000559a:	0001                	nop
    8000559c:	70a2                	ld	ra,40(sp)
    8000559e:	7402                	ld	s0,32(sp)
    800055a0:	6145                	addi	sp,sp,48
    800055a2:	8082                	ret

00000000800055a4 <fsinit>:

// Init fs
void
fsinit(int dev) {
    800055a4:	1101                	addi	sp,sp,-32
    800055a6:	ec06                	sd	ra,24(sp)
    800055a8:	e822                	sd	s0,16(sp)
    800055aa:	1000                	addi	s0,sp,32
    800055ac:	87aa                	mv	a5,a0
    800055ae:	fef42623          	sw	a5,-20(s0)
  readsb(dev, &sb);
    800055b2:	fec42783          	lw	a5,-20(s0)
    800055b6:	0049e597          	auipc	a1,0x49e
    800055ba:	bea58593          	addi	a1,a1,-1046 # 804a31a0 <sb>
    800055be:	853e                	mv	a0,a5
    800055c0:	00000097          	auipc	ra,0x0
    800055c4:	f8e080e7          	jalr	-114(ra) # 8000554e <readsb>
  if(sb.magic != FSMAGIC)
    800055c8:	0049e797          	auipc	a5,0x49e
    800055cc:	bd878793          	addi	a5,a5,-1064 # 804a31a0 <sb>
    800055d0:	439c                	lw	a5,0(a5)
    800055d2:	873e                	mv	a4,a5
    800055d4:	102037b7          	lui	a5,0x10203
    800055d8:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    800055dc:	00f70a63          	beq	a4,a5,800055f0 <fsinit+0x4c>
    panic("invalid file system");
    800055e0:	00006517          	auipc	a0,0x6
    800055e4:	00050513          	mv	a0,a0
    800055e8:	ffffb097          	auipc	ra,0xffffb
    800055ec:	692080e7          	jalr	1682(ra) # 80000c7a <panic>
  initlog(dev, &sb);
    800055f0:	fec42783          	lw	a5,-20(s0)
    800055f4:	0049e597          	auipc	a1,0x49e
    800055f8:	bac58593          	addi	a1,a1,-1108 # 804a31a0 <sb>
    800055fc:	853e                	mv	a0,a5
    800055fe:	00001097          	auipc	ra,0x1
    80005602:	45e080e7          	jalr	1118(ra) # 80006a5c <initlog>
}
    80005606:	0001                	nop
    80005608:	60e2                	ld	ra,24(sp)
    8000560a:	6442                	ld	s0,16(sp)
    8000560c:	6105                	addi	sp,sp,32
    8000560e:	8082                	ret

0000000080005610 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
    80005610:	7179                	addi	sp,sp,-48
    80005612:	f406                	sd	ra,40(sp)
    80005614:	f022                	sd	s0,32(sp)
    80005616:	1800                	addi	s0,sp,48
    80005618:	87aa                	mv	a5,a0
    8000561a:	872e                	mv	a4,a1
    8000561c:	fcf42e23          	sw	a5,-36(s0)
    80005620:	87ba                	mv	a5,a4
    80005622:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;

  bp = bread(dev, bno);
    80005626:	fdc42783          	lw	a5,-36(s0)
    8000562a:	fd842703          	lw	a4,-40(s0)
    8000562e:	85ba                	mv	a1,a4
    80005630:	853e                	mv	a0,a5
    80005632:	00000097          	auipc	ra,0x0
    80005636:	cfc080e7          	jalr	-772(ra) # 8000532e <bread>
    8000563a:	fea43423          	sd	a0,-24(s0)
  memset(bp->data, 0, BSIZE);
    8000563e:	fe843783          	ld	a5,-24(s0)
    80005642:	05878793          	addi	a5,a5,88
    80005646:	40000613          	li	a2,1024
    8000564a:	4581                	li	a1,0
    8000564c:	853e                	mv	a0,a5
    8000564e:	ffffc097          	auipc	ra,0xffffc
    80005652:	df0080e7          	jalr	-528(ra) # 8000143e <memset>
  log_write(bp);
    80005656:	fe843503          	ld	a0,-24(s0)
    8000565a:	00002097          	auipc	ra,0x2
    8000565e:	9ea080e7          	jalr	-1558(ra) # 80007044 <log_write>
  brelse(bp);
    80005662:	fe843503          	ld	a0,-24(s0)
    80005666:	00000097          	auipc	ra,0x0
    8000566a:	d6a080e7          	jalr	-662(ra) # 800053d0 <brelse>
}
    8000566e:	0001                	nop
    80005670:	70a2                	ld	ra,40(sp)
    80005672:	7402                	ld	s0,32(sp)
    80005674:	6145                	addi	sp,sp,48
    80005676:	8082                	ret

0000000080005678 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
    80005678:	7139                	addi	sp,sp,-64
    8000567a:	fc06                	sd	ra,56(sp)
    8000567c:	f822                	sd	s0,48(sp)
    8000567e:	0080                	addi	s0,sp,64
    80005680:	87aa                	mv	a5,a0
    80005682:	fcf42623          	sw	a5,-52(s0)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
    80005686:	fe043023          	sd	zero,-32(s0)
  for(b = 0; b < sb.size; b += BPB){
    8000568a:	fe042623          	sw	zero,-20(s0)
    8000568e:	a295                	j	800057f2 <balloc+0x17a>
    bp = bread(dev, BBLOCK(b, sb));
    80005690:	fec42783          	lw	a5,-20(s0)
    80005694:	41f7d71b          	sraiw	a4,a5,0x1f
    80005698:	0137571b          	srliw	a4,a4,0x13
    8000569c:	9fb9                	addw	a5,a5,a4
    8000569e:	40d7d79b          	sraiw	a5,a5,0xd
    800056a2:	2781                	sext.w	a5,a5
    800056a4:	0007871b          	sext.w	a4,a5
    800056a8:	0049e797          	auipc	a5,0x49e
    800056ac:	af878793          	addi	a5,a5,-1288 # 804a31a0 <sb>
    800056b0:	4fdc                	lw	a5,28(a5)
    800056b2:	9fb9                	addw	a5,a5,a4
    800056b4:	0007871b          	sext.w	a4,a5
    800056b8:	fcc42783          	lw	a5,-52(s0)
    800056bc:	85ba                	mv	a1,a4
    800056be:	853e                	mv	a0,a5
    800056c0:	00000097          	auipc	ra,0x0
    800056c4:	c6e080e7          	jalr	-914(ra) # 8000532e <bread>
    800056c8:	fea43023          	sd	a0,-32(s0)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800056cc:	fe042423          	sw	zero,-24(s0)
    800056d0:	a8e9                	j	800057aa <balloc+0x132>
      m = 1 << (bi % 8);
    800056d2:	fe842783          	lw	a5,-24(s0)
    800056d6:	8b9d                	andi	a5,a5,7
    800056d8:	2781                	sext.w	a5,a5
    800056da:	4705                	li	a4,1
    800056dc:	00f717bb          	sllw	a5,a4,a5
    800056e0:	fcf42e23          	sw	a5,-36(s0)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800056e4:	fe842783          	lw	a5,-24(s0)
    800056e8:	41f7d71b          	sraiw	a4,a5,0x1f
    800056ec:	01d7571b          	srliw	a4,a4,0x1d
    800056f0:	9fb9                	addw	a5,a5,a4
    800056f2:	4037d79b          	sraiw	a5,a5,0x3
    800056f6:	2781                	sext.w	a5,a5
    800056f8:	fe043703          	ld	a4,-32(s0)
    800056fc:	97ba                	add	a5,a5,a4
    800056fe:	0587c783          	lbu	a5,88(a5)
    80005702:	2781                	sext.w	a5,a5
    80005704:	fdc42703          	lw	a4,-36(s0)
    80005708:	8ff9                	and	a5,a5,a4
    8000570a:	2781                	sext.w	a5,a5
    8000570c:	ebd1                	bnez	a5,800057a0 <balloc+0x128>
        bp->data[bi/8] |= m;  // Mark block in use.
    8000570e:	fe842783          	lw	a5,-24(s0)
    80005712:	41f7d71b          	sraiw	a4,a5,0x1f
    80005716:	01d7571b          	srliw	a4,a4,0x1d
    8000571a:	9fb9                	addw	a5,a5,a4
    8000571c:	4037d79b          	sraiw	a5,a5,0x3
    80005720:	2781                	sext.w	a5,a5
    80005722:	fe043703          	ld	a4,-32(s0)
    80005726:	973e                	add	a4,a4,a5
    80005728:	05874703          	lbu	a4,88(a4)
    8000572c:	0187169b          	slliw	a3,a4,0x18
    80005730:	4186d69b          	sraiw	a3,a3,0x18
    80005734:	fdc42703          	lw	a4,-36(s0)
    80005738:	0187171b          	slliw	a4,a4,0x18
    8000573c:	4187571b          	sraiw	a4,a4,0x18
    80005740:	8f55                	or	a4,a4,a3
    80005742:	0187171b          	slliw	a4,a4,0x18
    80005746:	4187571b          	sraiw	a4,a4,0x18
    8000574a:	0ff77713          	zext.b	a4,a4
    8000574e:	fe043683          	ld	a3,-32(s0)
    80005752:	97b6                	add	a5,a5,a3
    80005754:	04e78c23          	sb	a4,88(a5)
        log_write(bp);
    80005758:	fe043503          	ld	a0,-32(s0)
    8000575c:	00002097          	auipc	ra,0x2
    80005760:	8e8080e7          	jalr	-1816(ra) # 80007044 <log_write>
        brelse(bp);
    80005764:	fe043503          	ld	a0,-32(s0)
    80005768:	00000097          	auipc	ra,0x0
    8000576c:	c68080e7          	jalr	-920(ra) # 800053d0 <brelse>
        bzero(dev, b + bi);
    80005770:	fcc42783          	lw	a5,-52(s0)
    80005774:	fec42703          	lw	a4,-20(s0)
    80005778:	86ba                	mv	a3,a4
    8000577a:	fe842703          	lw	a4,-24(s0)
    8000577e:	9f35                	addw	a4,a4,a3
    80005780:	2701                	sext.w	a4,a4
    80005782:	85ba                	mv	a1,a4
    80005784:	853e                	mv	a0,a5
    80005786:	00000097          	auipc	ra,0x0
    8000578a:	e8a080e7          	jalr	-374(ra) # 80005610 <bzero>
        return b + bi;
    8000578e:	fec42783          	lw	a5,-20(s0)
    80005792:	873e                	mv	a4,a5
    80005794:	fe842783          	lw	a5,-24(s0)
    80005798:	9fb9                	addw	a5,a5,a4
    8000579a:	2781                	sext.w	a5,a5
    8000579c:	2781                	sext.w	a5,a5
    8000579e:	a89d                	j	80005814 <balloc+0x19c>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800057a0:	fe842783          	lw	a5,-24(s0)
    800057a4:	2785                	addiw	a5,a5,1
    800057a6:	fef42423          	sw	a5,-24(s0)
    800057aa:	fe842783          	lw	a5,-24(s0)
    800057ae:	0007871b          	sext.w	a4,a5
    800057b2:	6789                	lui	a5,0x2
    800057b4:	02f75263          	bge	a4,a5,800057d8 <balloc+0x160>
    800057b8:	fec42783          	lw	a5,-20(s0)
    800057bc:	873e                	mv	a4,a5
    800057be:	fe842783          	lw	a5,-24(s0)
    800057c2:	9fb9                	addw	a5,a5,a4
    800057c4:	2781                	sext.w	a5,a5
    800057c6:	0007871b          	sext.w	a4,a5
    800057ca:	0049e797          	auipc	a5,0x49e
    800057ce:	9d678793          	addi	a5,a5,-1578 # 804a31a0 <sb>
    800057d2:	43dc                	lw	a5,4(a5)
    800057d4:	eef76fe3          	bltu	a4,a5,800056d2 <balloc+0x5a>
      }
    }
    brelse(bp);
    800057d8:	fe043503          	ld	a0,-32(s0)
    800057dc:	00000097          	auipc	ra,0x0
    800057e0:	bf4080e7          	jalr	-1036(ra) # 800053d0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    800057e4:	fec42783          	lw	a5,-20(s0)
    800057e8:	873e                	mv	a4,a5
    800057ea:	6789                	lui	a5,0x2
    800057ec:	9fb9                	addw	a5,a5,a4
    800057ee:	fef42623          	sw	a5,-20(s0)
    800057f2:	0049e797          	auipc	a5,0x49e
    800057f6:	9ae78793          	addi	a5,a5,-1618 # 804a31a0 <sb>
    800057fa:	43d8                	lw	a4,4(a5)
    800057fc:	fec42783          	lw	a5,-20(s0)
    80005800:	e8e7e8e3          	bltu	a5,a4,80005690 <balloc+0x18>
  }
  panic("balloc: out of blocks");
    80005804:	00006517          	auipc	a0,0x6
    80005808:	df450513          	addi	a0,a0,-524 # 8000b5f8 <etext+0x5f8>
    8000580c:	ffffb097          	auipc	ra,0xffffb
    80005810:	46e080e7          	jalr	1134(ra) # 80000c7a <panic>
}
    80005814:	853e                	mv	a0,a5
    80005816:	70e2                	ld	ra,56(sp)
    80005818:	7442                	ld	s0,48(sp)
    8000581a:	6121                	addi	sp,sp,64
    8000581c:	8082                	ret

000000008000581e <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
    8000581e:	7179                	addi	sp,sp,-48
    80005820:	f406                	sd	ra,40(sp)
    80005822:	f022                	sd	s0,32(sp)
    80005824:	1800                	addi	s0,sp,48
    80005826:	87aa                	mv	a5,a0
    80005828:	872e                	mv	a4,a1
    8000582a:	fcf42e23          	sw	a5,-36(s0)
    8000582e:	87ba                	mv	a5,a4
    80005830:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80005834:	fdc42683          	lw	a3,-36(s0)
    80005838:	fd842783          	lw	a5,-40(s0)
    8000583c:	00d7d79b          	srliw	a5,a5,0xd
    80005840:	0007871b          	sext.w	a4,a5
    80005844:	0049e797          	auipc	a5,0x49e
    80005848:	95c78793          	addi	a5,a5,-1700 # 804a31a0 <sb>
    8000584c:	4fdc                	lw	a5,28(a5)
    8000584e:	9fb9                	addw	a5,a5,a4
    80005850:	2781                	sext.w	a5,a5
    80005852:	85be                	mv	a1,a5
    80005854:	8536                	mv	a0,a3
    80005856:	00000097          	auipc	ra,0x0
    8000585a:	ad8080e7          	jalr	-1320(ra) # 8000532e <bread>
    8000585e:	fea43423          	sd	a0,-24(s0)
  bi = b % BPB;
    80005862:	fd842703          	lw	a4,-40(s0)
    80005866:	6789                	lui	a5,0x2
    80005868:	17fd                	addi	a5,a5,-1
    8000586a:	8ff9                	and	a5,a5,a4
    8000586c:	fef42223          	sw	a5,-28(s0)
  m = 1 << (bi % 8);
    80005870:	fe442783          	lw	a5,-28(s0)
    80005874:	8b9d                	andi	a5,a5,7
    80005876:	2781                	sext.w	a5,a5
    80005878:	4705                	li	a4,1
    8000587a:	00f717bb          	sllw	a5,a4,a5
    8000587e:	fef42023          	sw	a5,-32(s0)
  if((bp->data[bi/8] & m) == 0)
    80005882:	fe442783          	lw	a5,-28(s0)
    80005886:	41f7d71b          	sraiw	a4,a5,0x1f
    8000588a:	01d7571b          	srliw	a4,a4,0x1d
    8000588e:	9fb9                	addw	a5,a5,a4
    80005890:	4037d79b          	sraiw	a5,a5,0x3
    80005894:	2781                	sext.w	a5,a5
    80005896:	fe843703          	ld	a4,-24(s0)
    8000589a:	97ba                	add	a5,a5,a4
    8000589c:	0587c783          	lbu	a5,88(a5) # 2058 <_entry-0x7fffdfa8>
    800058a0:	2781                	sext.w	a5,a5
    800058a2:	fe042703          	lw	a4,-32(s0)
    800058a6:	8ff9                	and	a5,a5,a4
    800058a8:	2781                	sext.w	a5,a5
    800058aa:	eb89                	bnez	a5,800058bc <bfree+0x9e>
    panic("freeing free block");
    800058ac:	00006517          	auipc	a0,0x6
    800058b0:	d6450513          	addi	a0,a0,-668 # 8000b610 <etext+0x610>
    800058b4:	ffffb097          	auipc	ra,0xffffb
    800058b8:	3c6080e7          	jalr	966(ra) # 80000c7a <panic>
  bp->data[bi/8] &= ~m;
    800058bc:	fe442783          	lw	a5,-28(s0)
    800058c0:	41f7d71b          	sraiw	a4,a5,0x1f
    800058c4:	01d7571b          	srliw	a4,a4,0x1d
    800058c8:	9fb9                	addw	a5,a5,a4
    800058ca:	4037d79b          	sraiw	a5,a5,0x3
    800058ce:	2781                	sext.w	a5,a5
    800058d0:	fe843703          	ld	a4,-24(s0)
    800058d4:	973e                	add	a4,a4,a5
    800058d6:	05874703          	lbu	a4,88(a4)
    800058da:	0187169b          	slliw	a3,a4,0x18
    800058de:	4186d69b          	sraiw	a3,a3,0x18
    800058e2:	fe042703          	lw	a4,-32(s0)
    800058e6:	0187171b          	slliw	a4,a4,0x18
    800058ea:	4187571b          	sraiw	a4,a4,0x18
    800058ee:	fff74713          	not	a4,a4
    800058f2:	0187171b          	slliw	a4,a4,0x18
    800058f6:	4187571b          	sraiw	a4,a4,0x18
    800058fa:	8f75                	and	a4,a4,a3
    800058fc:	0187171b          	slliw	a4,a4,0x18
    80005900:	4187571b          	sraiw	a4,a4,0x18
    80005904:	0ff77713          	zext.b	a4,a4
    80005908:	fe843683          	ld	a3,-24(s0)
    8000590c:	97b6                	add	a5,a5,a3
    8000590e:	04e78c23          	sb	a4,88(a5)
  log_write(bp);
    80005912:	fe843503          	ld	a0,-24(s0)
    80005916:	00001097          	auipc	ra,0x1
    8000591a:	72e080e7          	jalr	1838(ra) # 80007044 <log_write>
  brelse(bp);
    8000591e:	fe843503          	ld	a0,-24(s0)
    80005922:	00000097          	auipc	ra,0x0
    80005926:	aae080e7          	jalr	-1362(ra) # 800053d0 <brelse>
}
    8000592a:	0001                	nop
    8000592c:	70a2                	ld	ra,40(sp)
    8000592e:	7402                	ld	s0,32(sp)
    80005930:	6145                	addi	sp,sp,48
    80005932:	8082                	ret

0000000080005934 <iinit>:
  struct inode inode[NINODE];
} itable;

void
iinit()
{
    80005934:	1101                	addi	sp,sp,-32
    80005936:	ec06                	sd	ra,24(sp)
    80005938:	e822                	sd	s0,16(sp)
    8000593a:	1000                	addi	s0,sp,32
  int i = 0;
    8000593c:	fe042623          	sw	zero,-20(s0)
  
  initlock(&itable.lock, "itable");
    80005940:	00006597          	auipc	a1,0x6
    80005944:	ce858593          	addi	a1,a1,-792 # 8000b628 <etext+0x628>
    80005948:	0049e517          	auipc	a0,0x49e
    8000594c:	87850513          	addi	a0,a0,-1928 # 804a31c0 <itable>
    80005950:	ffffc097          	auipc	ra,0xffffc
    80005954:	8ea080e7          	jalr	-1814(ra) # 8000123a <initlock>
  for(i = 0; i < NINODE; i++) {
    80005958:	fe042623          	sw	zero,-20(s0)
    8000595c:	a82d                	j	80005996 <iinit+0x62>
    initsleeplock(&itable.inode[i].lock, "inode");
    8000595e:	fec42703          	lw	a4,-20(s0)
    80005962:	87ba                	mv	a5,a4
    80005964:	0792                	slli	a5,a5,0x4
    80005966:	97ba                	add	a5,a5,a4
    80005968:	078e                	slli	a5,a5,0x3
    8000596a:	02078713          	addi	a4,a5,32
    8000596e:	0049e797          	auipc	a5,0x49e
    80005972:	85278793          	addi	a5,a5,-1966 # 804a31c0 <itable>
    80005976:	97ba                	add	a5,a5,a4
    80005978:	07a1                	addi	a5,a5,8
    8000597a:	00006597          	auipc	a1,0x6
    8000597e:	cb658593          	addi	a1,a1,-842 # 8000b630 <etext+0x630>
    80005982:	853e                	mv	a0,a5
    80005984:	00001097          	auipc	ra,0x1
    80005988:	7f4080e7          	jalr	2036(ra) # 80007178 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    8000598c:	fec42783          	lw	a5,-20(s0)
    80005990:	2785                	addiw	a5,a5,1
    80005992:	fef42623          	sw	a5,-20(s0)
    80005996:	fec42783          	lw	a5,-20(s0)
    8000599a:	0007871b          	sext.w	a4,a5
    8000599e:	03100793          	li	a5,49
    800059a2:	fae7dee3          	bge	a5,a4,8000595e <iinit+0x2a>
  }
}
    800059a6:	0001                	nop
    800059a8:	0001                	nop
    800059aa:	60e2                	ld	ra,24(sp)
    800059ac:	6442                	ld	s0,16(sp)
    800059ae:	6105                	addi	sp,sp,32
    800059b0:	8082                	ret

00000000800059b2 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
    800059b2:	7139                	addi	sp,sp,-64
    800059b4:	fc06                	sd	ra,56(sp)
    800059b6:	f822                	sd	s0,48(sp)
    800059b8:	0080                	addi	s0,sp,64
    800059ba:	87aa                	mv	a5,a0
    800059bc:	872e                	mv	a4,a1
    800059be:	fcf42623          	sw	a5,-52(s0)
    800059c2:	87ba                	mv	a5,a4
    800059c4:	fcf41523          	sh	a5,-54(s0)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    800059c8:	4785                	li	a5,1
    800059ca:	fef42623          	sw	a5,-20(s0)
    800059ce:	a855                	j	80005a82 <ialloc+0xd0>
    bp = bread(dev, IBLOCK(inum, sb));
    800059d0:	fec42783          	lw	a5,-20(s0)
    800059d4:	8391                	srli	a5,a5,0x4
    800059d6:	0007871b          	sext.w	a4,a5
    800059da:	0049d797          	auipc	a5,0x49d
    800059de:	7c678793          	addi	a5,a5,1990 # 804a31a0 <sb>
    800059e2:	4f9c                	lw	a5,24(a5)
    800059e4:	9fb9                	addw	a5,a5,a4
    800059e6:	0007871b          	sext.w	a4,a5
    800059ea:	fcc42783          	lw	a5,-52(s0)
    800059ee:	85ba                	mv	a1,a4
    800059f0:	853e                	mv	a0,a5
    800059f2:	00000097          	auipc	ra,0x0
    800059f6:	93c080e7          	jalr	-1732(ra) # 8000532e <bread>
    800059fa:	fea43023          	sd	a0,-32(s0)
    dip = (struct dinode*)bp->data + inum%IPB;
    800059fe:	fe043783          	ld	a5,-32(s0)
    80005a02:	05878713          	addi	a4,a5,88
    80005a06:	fec42783          	lw	a5,-20(s0)
    80005a0a:	8bbd                	andi	a5,a5,15
    80005a0c:	079a                	slli	a5,a5,0x6
    80005a0e:	97ba                	add	a5,a5,a4
    80005a10:	fcf43c23          	sd	a5,-40(s0)
    if(dip->type == 0){  // a free inode
    80005a14:	fd843783          	ld	a5,-40(s0)
    80005a18:	00079783          	lh	a5,0(a5)
    80005a1c:	eba1                	bnez	a5,80005a6c <ialloc+0xba>
      memset(dip, 0, sizeof(*dip));
    80005a1e:	04000613          	li	a2,64
    80005a22:	4581                	li	a1,0
    80005a24:	fd843503          	ld	a0,-40(s0)
    80005a28:	ffffc097          	auipc	ra,0xffffc
    80005a2c:	a16080e7          	jalr	-1514(ra) # 8000143e <memset>
      dip->type = type;
    80005a30:	fd843783          	ld	a5,-40(s0)
    80005a34:	fca45703          	lhu	a4,-54(s0)
    80005a38:	00e79023          	sh	a4,0(a5)
      log_write(bp);   // mark it allocated on the disk
    80005a3c:	fe043503          	ld	a0,-32(s0)
    80005a40:	00001097          	auipc	ra,0x1
    80005a44:	604080e7          	jalr	1540(ra) # 80007044 <log_write>
      brelse(bp);
    80005a48:	fe043503          	ld	a0,-32(s0)
    80005a4c:	00000097          	auipc	ra,0x0
    80005a50:	984080e7          	jalr	-1660(ra) # 800053d0 <brelse>
      return iget(dev, inum);
    80005a54:	fec42703          	lw	a4,-20(s0)
    80005a58:	fcc42783          	lw	a5,-52(s0)
    80005a5c:	85ba                	mv	a1,a4
    80005a5e:	853e                	mv	a0,a5
    80005a60:	00000097          	auipc	ra,0x0
    80005a64:	136080e7          	jalr	310(ra) # 80005b96 <iget>
    80005a68:	87aa                	mv	a5,a0
    80005a6a:	a82d                	j	80005aa4 <ialloc+0xf2>
    }
    brelse(bp);
    80005a6c:	fe043503          	ld	a0,-32(s0)
    80005a70:	00000097          	auipc	ra,0x0
    80005a74:	960080e7          	jalr	-1696(ra) # 800053d0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80005a78:	fec42783          	lw	a5,-20(s0)
    80005a7c:	2785                	addiw	a5,a5,1
    80005a7e:	fef42623          	sw	a5,-20(s0)
    80005a82:	0049d797          	auipc	a5,0x49d
    80005a86:	71e78793          	addi	a5,a5,1822 # 804a31a0 <sb>
    80005a8a:	47d8                	lw	a4,12(a5)
    80005a8c:	fec42783          	lw	a5,-20(s0)
    80005a90:	f4e7e0e3          	bltu	a5,a4,800059d0 <ialloc+0x1e>
  }
  panic("ialloc: no inodes");
    80005a94:	00006517          	auipc	a0,0x6
    80005a98:	ba450513          	addi	a0,a0,-1116 # 8000b638 <etext+0x638>
    80005a9c:	ffffb097          	auipc	ra,0xffffb
    80005aa0:	1de080e7          	jalr	478(ra) # 80000c7a <panic>
}
    80005aa4:	853e                	mv	a0,a5
    80005aa6:	70e2                	ld	ra,56(sp)
    80005aa8:	7442                	ld	s0,48(sp)
    80005aaa:	6121                	addi	sp,sp,64
    80005aac:	8082                	ret

0000000080005aae <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
    80005aae:	7179                	addi	sp,sp,-48
    80005ab0:	f406                	sd	ra,40(sp)
    80005ab2:	f022                	sd	s0,32(sp)
    80005ab4:	1800                	addi	s0,sp,48
    80005ab6:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80005aba:	fd843783          	ld	a5,-40(s0)
    80005abe:	4394                	lw	a3,0(a5)
    80005ac0:	fd843783          	ld	a5,-40(s0)
    80005ac4:	43dc                	lw	a5,4(a5)
    80005ac6:	0047d79b          	srliw	a5,a5,0x4
    80005aca:	0007871b          	sext.w	a4,a5
    80005ace:	0049d797          	auipc	a5,0x49d
    80005ad2:	6d278793          	addi	a5,a5,1746 # 804a31a0 <sb>
    80005ad6:	4f9c                	lw	a5,24(a5)
    80005ad8:	9fb9                	addw	a5,a5,a4
    80005ada:	2781                	sext.w	a5,a5
    80005adc:	85be                	mv	a1,a5
    80005ade:	8536                	mv	a0,a3
    80005ae0:	00000097          	auipc	ra,0x0
    80005ae4:	84e080e7          	jalr	-1970(ra) # 8000532e <bread>
    80005ae8:	fea43423          	sd	a0,-24(s0)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80005aec:	fe843783          	ld	a5,-24(s0)
    80005af0:	05878713          	addi	a4,a5,88
    80005af4:	fd843783          	ld	a5,-40(s0)
    80005af8:	43dc                	lw	a5,4(a5)
    80005afa:	1782                	slli	a5,a5,0x20
    80005afc:	9381                	srli	a5,a5,0x20
    80005afe:	8bbd                	andi	a5,a5,15
    80005b00:	079a                	slli	a5,a5,0x6
    80005b02:	97ba                	add	a5,a5,a4
    80005b04:	fef43023          	sd	a5,-32(s0)
  dip->type = ip->type;
    80005b08:	fd843783          	ld	a5,-40(s0)
    80005b0c:	04479703          	lh	a4,68(a5)
    80005b10:	fe043783          	ld	a5,-32(s0)
    80005b14:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80005b18:	fd843783          	ld	a5,-40(s0)
    80005b1c:	04679703          	lh	a4,70(a5)
    80005b20:	fe043783          	ld	a5,-32(s0)
    80005b24:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80005b28:	fd843783          	ld	a5,-40(s0)
    80005b2c:	04879703          	lh	a4,72(a5)
    80005b30:	fe043783          	ld	a5,-32(s0)
    80005b34:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80005b38:	fd843783          	ld	a5,-40(s0)
    80005b3c:	04a79703          	lh	a4,74(a5)
    80005b40:	fe043783          	ld	a5,-32(s0)
    80005b44:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80005b48:	fd843783          	ld	a5,-40(s0)
    80005b4c:	47f8                	lw	a4,76(a5)
    80005b4e:	fe043783          	ld	a5,-32(s0)
    80005b52:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80005b54:	fe043783          	ld	a5,-32(s0)
    80005b58:	00c78713          	addi	a4,a5,12
    80005b5c:	fd843783          	ld	a5,-40(s0)
    80005b60:	05078793          	addi	a5,a5,80
    80005b64:	03400613          	li	a2,52
    80005b68:	85be                	mv	a1,a5
    80005b6a:	853a                	mv	a0,a4
    80005b6c:	ffffc097          	auipc	ra,0xffffc
    80005b70:	9b6080e7          	jalr	-1610(ra) # 80001522 <memmove>
  log_write(bp);
    80005b74:	fe843503          	ld	a0,-24(s0)
    80005b78:	00001097          	auipc	ra,0x1
    80005b7c:	4cc080e7          	jalr	1228(ra) # 80007044 <log_write>
  brelse(bp);
    80005b80:	fe843503          	ld	a0,-24(s0)
    80005b84:	00000097          	auipc	ra,0x0
    80005b88:	84c080e7          	jalr	-1972(ra) # 800053d0 <brelse>
}
    80005b8c:	0001                	nop
    80005b8e:	70a2                	ld	ra,40(sp)
    80005b90:	7402                	ld	s0,32(sp)
    80005b92:	6145                	addi	sp,sp,48
    80005b94:	8082                	ret

0000000080005b96 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
    80005b96:	7179                	addi	sp,sp,-48
    80005b98:	f406                	sd	ra,40(sp)
    80005b9a:	f022                	sd	s0,32(sp)
    80005b9c:	1800                	addi	s0,sp,48
    80005b9e:	87aa                	mv	a5,a0
    80005ba0:	872e                	mv	a4,a1
    80005ba2:	fcf42e23          	sw	a5,-36(s0)
    80005ba6:	87ba                	mv	a5,a4
    80005ba8:	fcf42c23          	sw	a5,-40(s0)
  struct inode *ip, *empty;

  acquire(&itable.lock);
    80005bac:	0049d517          	auipc	a0,0x49d
    80005bb0:	61450513          	addi	a0,a0,1556 # 804a31c0 <itable>
    80005bb4:	ffffb097          	auipc	ra,0xffffb
    80005bb8:	6b6080e7          	jalr	1718(ra) # 8000126a <acquire>

  // Is the inode already in the table?
  empty = 0;
    80005bbc:	fe043023          	sd	zero,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80005bc0:	0049d797          	auipc	a5,0x49d
    80005bc4:	61878793          	addi	a5,a5,1560 # 804a31d8 <itable+0x18>
    80005bc8:	fef43423          	sd	a5,-24(s0)
    80005bcc:	a89d                	j	80005c42 <iget+0xac>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80005bce:	fe843783          	ld	a5,-24(s0)
    80005bd2:	479c                	lw	a5,8(a5)
    80005bd4:	04f05663          	blez	a5,80005c20 <iget+0x8a>
    80005bd8:	fe843783          	ld	a5,-24(s0)
    80005bdc:	4398                	lw	a4,0(a5)
    80005bde:	fdc42783          	lw	a5,-36(s0)
    80005be2:	2781                	sext.w	a5,a5
    80005be4:	02e79e63          	bne	a5,a4,80005c20 <iget+0x8a>
    80005be8:	fe843783          	ld	a5,-24(s0)
    80005bec:	43d8                	lw	a4,4(a5)
    80005bee:	fd842783          	lw	a5,-40(s0)
    80005bf2:	2781                	sext.w	a5,a5
    80005bf4:	02e79663          	bne	a5,a4,80005c20 <iget+0x8a>
      ip->ref++;
    80005bf8:	fe843783          	ld	a5,-24(s0)
    80005bfc:	479c                	lw	a5,8(a5)
    80005bfe:	2785                	addiw	a5,a5,1
    80005c00:	0007871b          	sext.w	a4,a5
    80005c04:	fe843783          	ld	a5,-24(s0)
    80005c08:	c798                	sw	a4,8(a5)
      release(&itable.lock);
    80005c0a:	0049d517          	auipc	a0,0x49d
    80005c0e:	5b650513          	addi	a0,a0,1462 # 804a31c0 <itable>
    80005c12:	ffffb097          	auipc	ra,0xffffb
    80005c16:	6bc080e7          	jalr	1724(ra) # 800012ce <release>
      return ip;
    80005c1a:	fe843783          	ld	a5,-24(s0)
    80005c1e:	a069                	j	80005ca8 <iget+0x112>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80005c20:	fe043783          	ld	a5,-32(s0)
    80005c24:	eb89                	bnez	a5,80005c36 <iget+0xa0>
    80005c26:	fe843783          	ld	a5,-24(s0)
    80005c2a:	479c                	lw	a5,8(a5)
    80005c2c:	e789                	bnez	a5,80005c36 <iget+0xa0>
      empty = ip;
    80005c2e:	fe843783          	ld	a5,-24(s0)
    80005c32:	fef43023          	sd	a5,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80005c36:	fe843783          	ld	a5,-24(s0)
    80005c3a:	08878793          	addi	a5,a5,136
    80005c3e:	fef43423          	sd	a5,-24(s0)
    80005c42:	fe843703          	ld	a4,-24(s0)
    80005c46:	0049f797          	auipc	a5,0x49f
    80005c4a:	02278793          	addi	a5,a5,34 # 804a4c68 <log>
    80005c4e:	f8f760e3          	bltu	a4,a5,80005bce <iget+0x38>
  }

  // Recycle an inode entry.
  if(empty == 0)
    80005c52:	fe043783          	ld	a5,-32(s0)
    80005c56:	eb89                	bnez	a5,80005c68 <iget+0xd2>
    panic("iget: no inodes");
    80005c58:	00006517          	auipc	a0,0x6
    80005c5c:	9f850513          	addi	a0,a0,-1544 # 8000b650 <etext+0x650>
    80005c60:	ffffb097          	auipc	ra,0xffffb
    80005c64:	01a080e7          	jalr	26(ra) # 80000c7a <panic>

  ip = empty;
    80005c68:	fe043783          	ld	a5,-32(s0)
    80005c6c:	fef43423          	sd	a5,-24(s0)
  ip->dev = dev;
    80005c70:	fe843783          	ld	a5,-24(s0)
    80005c74:	fdc42703          	lw	a4,-36(s0)
    80005c78:	c398                	sw	a4,0(a5)
  ip->inum = inum;
    80005c7a:	fe843783          	ld	a5,-24(s0)
    80005c7e:	fd842703          	lw	a4,-40(s0)
    80005c82:	c3d8                	sw	a4,4(a5)
  ip->ref = 1;
    80005c84:	fe843783          	ld	a5,-24(s0)
    80005c88:	4705                	li	a4,1
    80005c8a:	c798                	sw	a4,8(a5)
  ip->valid = 0;
    80005c8c:	fe843783          	ld	a5,-24(s0)
    80005c90:	0407a023          	sw	zero,64(a5)
  release(&itable.lock);
    80005c94:	0049d517          	auipc	a0,0x49d
    80005c98:	52c50513          	addi	a0,a0,1324 # 804a31c0 <itable>
    80005c9c:	ffffb097          	auipc	ra,0xffffb
    80005ca0:	632080e7          	jalr	1586(ra) # 800012ce <release>

  return ip;
    80005ca4:	fe843783          	ld	a5,-24(s0)
}
    80005ca8:	853e                	mv	a0,a5
    80005caa:	70a2                	ld	ra,40(sp)
    80005cac:	7402                	ld	s0,32(sp)
    80005cae:	6145                	addi	sp,sp,48
    80005cb0:	8082                	ret

0000000080005cb2 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
    80005cb2:	1101                	addi	sp,sp,-32
    80005cb4:	ec06                	sd	ra,24(sp)
    80005cb6:	e822                	sd	s0,16(sp)
    80005cb8:	1000                	addi	s0,sp,32
    80005cba:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    80005cbe:	0049d517          	auipc	a0,0x49d
    80005cc2:	50250513          	addi	a0,a0,1282 # 804a31c0 <itable>
    80005cc6:	ffffb097          	auipc	ra,0xffffb
    80005cca:	5a4080e7          	jalr	1444(ra) # 8000126a <acquire>
  ip->ref++;
    80005cce:	fe843783          	ld	a5,-24(s0)
    80005cd2:	479c                	lw	a5,8(a5)
    80005cd4:	2785                	addiw	a5,a5,1
    80005cd6:	0007871b          	sext.w	a4,a5
    80005cda:	fe843783          	ld	a5,-24(s0)
    80005cde:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80005ce0:	0049d517          	auipc	a0,0x49d
    80005ce4:	4e050513          	addi	a0,a0,1248 # 804a31c0 <itable>
    80005ce8:	ffffb097          	auipc	ra,0xffffb
    80005cec:	5e6080e7          	jalr	1510(ra) # 800012ce <release>
  return ip;
    80005cf0:	fe843783          	ld	a5,-24(s0)
}
    80005cf4:	853e                	mv	a0,a5
    80005cf6:	60e2                	ld	ra,24(sp)
    80005cf8:	6442                	ld	s0,16(sp)
    80005cfa:	6105                	addi	sp,sp,32
    80005cfc:	8082                	ret

0000000080005cfe <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
    80005cfe:	7179                	addi	sp,sp,-48
    80005d00:	f406                	sd	ra,40(sp)
    80005d02:	f022                	sd	s0,32(sp)
    80005d04:	1800                	addi	s0,sp,48
    80005d06:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    80005d0a:	fd843783          	ld	a5,-40(s0)
    80005d0e:	c791                	beqz	a5,80005d1a <ilock+0x1c>
    80005d10:	fd843783          	ld	a5,-40(s0)
    80005d14:	479c                	lw	a5,8(a5)
    80005d16:	00f04a63          	bgtz	a5,80005d2a <ilock+0x2c>
    panic("ilock");
    80005d1a:	00006517          	auipc	a0,0x6
    80005d1e:	94650513          	addi	a0,a0,-1722 # 8000b660 <etext+0x660>
    80005d22:	ffffb097          	auipc	ra,0xffffb
    80005d26:	f58080e7          	jalr	-168(ra) # 80000c7a <panic>

  acquiresleep(&ip->lock);
    80005d2a:	fd843783          	ld	a5,-40(s0)
    80005d2e:	07c1                	addi	a5,a5,16
    80005d30:	853e                	mv	a0,a5
    80005d32:	00001097          	auipc	ra,0x1
    80005d36:	492080e7          	jalr	1170(ra) # 800071c4 <acquiresleep>

  if(ip->valid == 0){
    80005d3a:	fd843783          	ld	a5,-40(s0)
    80005d3e:	43bc                	lw	a5,64(a5)
    80005d40:	e7e5                	bnez	a5,80005e28 <ilock+0x12a>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80005d42:	fd843783          	ld	a5,-40(s0)
    80005d46:	4394                	lw	a3,0(a5)
    80005d48:	fd843783          	ld	a5,-40(s0)
    80005d4c:	43dc                	lw	a5,4(a5)
    80005d4e:	0047d79b          	srliw	a5,a5,0x4
    80005d52:	0007871b          	sext.w	a4,a5
    80005d56:	0049d797          	auipc	a5,0x49d
    80005d5a:	44a78793          	addi	a5,a5,1098 # 804a31a0 <sb>
    80005d5e:	4f9c                	lw	a5,24(a5)
    80005d60:	9fb9                	addw	a5,a5,a4
    80005d62:	2781                	sext.w	a5,a5
    80005d64:	85be                	mv	a1,a5
    80005d66:	8536                	mv	a0,a3
    80005d68:	fffff097          	auipc	ra,0xfffff
    80005d6c:	5c6080e7          	jalr	1478(ra) # 8000532e <bread>
    80005d70:	fea43423          	sd	a0,-24(s0)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80005d74:	fe843783          	ld	a5,-24(s0)
    80005d78:	05878713          	addi	a4,a5,88
    80005d7c:	fd843783          	ld	a5,-40(s0)
    80005d80:	43dc                	lw	a5,4(a5)
    80005d82:	1782                	slli	a5,a5,0x20
    80005d84:	9381                	srli	a5,a5,0x20
    80005d86:	8bbd                	andi	a5,a5,15
    80005d88:	079a                	slli	a5,a5,0x6
    80005d8a:	97ba                	add	a5,a5,a4
    80005d8c:	fef43023          	sd	a5,-32(s0)
    ip->type = dip->type;
    80005d90:	fe043783          	ld	a5,-32(s0)
    80005d94:	00079703          	lh	a4,0(a5)
    80005d98:	fd843783          	ld	a5,-40(s0)
    80005d9c:	04e79223          	sh	a4,68(a5)
    ip->major = dip->major;
    80005da0:	fe043783          	ld	a5,-32(s0)
    80005da4:	00279703          	lh	a4,2(a5)
    80005da8:	fd843783          	ld	a5,-40(s0)
    80005dac:	04e79323          	sh	a4,70(a5)
    ip->minor = dip->minor;
    80005db0:	fe043783          	ld	a5,-32(s0)
    80005db4:	00479703          	lh	a4,4(a5)
    80005db8:	fd843783          	ld	a5,-40(s0)
    80005dbc:	04e79423          	sh	a4,72(a5)
    ip->nlink = dip->nlink;
    80005dc0:	fe043783          	ld	a5,-32(s0)
    80005dc4:	00679703          	lh	a4,6(a5)
    80005dc8:	fd843783          	ld	a5,-40(s0)
    80005dcc:	04e79523          	sh	a4,74(a5)
    ip->size = dip->size;
    80005dd0:	fe043783          	ld	a5,-32(s0)
    80005dd4:	4798                	lw	a4,8(a5)
    80005dd6:	fd843783          	ld	a5,-40(s0)
    80005dda:	c7f8                	sw	a4,76(a5)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80005ddc:	fd843783          	ld	a5,-40(s0)
    80005de0:	05078713          	addi	a4,a5,80
    80005de4:	fe043783          	ld	a5,-32(s0)
    80005de8:	07b1                	addi	a5,a5,12
    80005dea:	03400613          	li	a2,52
    80005dee:	85be                	mv	a1,a5
    80005df0:	853a                	mv	a0,a4
    80005df2:	ffffb097          	auipc	ra,0xffffb
    80005df6:	730080e7          	jalr	1840(ra) # 80001522 <memmove>
    brelse(bp);
    80005dfa:	fe843503          	ld	a0,-24(s0)
    80005dfe:	fffff097          	auipc	ra,0xfffff
    80005e02:	5d2080e7          	jalr	1490(ra) # 800053d0 <brelse>
    ip->valid = 1;
    80005e06:	fd843783          	ld	a5,-40(s0)
    80005e0a:	4705                	li	a4,1
    80005e0c:	c3b8                	sw	a4,64(a5)
    if(ip->type == 0)
    80005e0e:	fd843783          	ld	a5,-40(s0)
    80005e12:	04479783          	lh	a5,68(a5)
    80005e16:	eb89                	bnez	a5,80005e28 <ilock+0x12a>
      panic("ilock: no type");
    80005e18:	00006517          	auipc	a0,0x6
    80005e1c:	85050513          	addi	a0,a0,-1968 # 8000b668 <etext+0x668>
    80005e20:	ffffb097          	auipc	ra,0xffffb
    80005e24:	e5a080e7          	jalr	-422(ra) # 80000c7a <panic>
  }
}
    80005e28:	0001                	nop
    80005e2a:	70a2                	ld	ra,40(sp)
    80005e2c:	7402                	ld	s0,32(sp)
    80005e2e:	6145                	addi	sp,sp,48
    80005e30:	8082                	ret

0000000080005e32 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
    80005e32:	1101                	addi	sp,sp,-32
    80005e34:	ec06                	sd	ra,24(sp)
    80005e36:	e822                	sd	s0,16(sp)
    80005e38:	1000                	addi	s0,sp,32
    80005e3a:	fea43423          	sd	a0,-24(s0)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80005e3e:	fe843783          	ld	a5,-24(s0)
    80005e42:	c385                	beqz	a5,80005e62 <iunlock+0x30>
    80005e44:	fe843783          	ld	a5,-24(s0)
    80005e48:	07c1                	addi	a5,a5,16
    80005e4a:	853e                	mv	a0,a5
    80005e4c:	00001097          	auipc	ra,0x1
    80005e50:	438080e7          	jalr	1080(ra) # 80007284 <holdingsleep>
    80005e54:	87aa                	mv	a5,a0
    80005e56:	c791                	beqz	a5,80005e62 <iunlock+0x30>
    80005e58:	fe843783          	ld	a5,-24(s0)
    80005e5c:	479c                	lw	a5,8(a5)
    80005e5e:	00f04a63          	bgtz	a5,80005e72 <iunlock+0x40>
    panic("iunlock");
    80005e62:	00006517          	auipc	a0,0x6
    80005e66:	81650513          	addi	a0,a0,-2026 # 8000b678 <etext+0x678>
    80005e6a:	ffffb097          	auipc	ra,0xffffb
    80005e6e:	e10080e7          	jalr	-496(ra) # 80000c7a <panic>

  releasesleep(&ip->lock);
    80005e72:	fe843783          	ld	a5,-24(s0)
    80005e76:	07c1                	addi	a5,a5,16
    80005e78:	853e                	mv	a0,a5
    80005e7a:	00001097          	auipc	ra,0x1
    80005e7e:	3b8080e7          	jalr	952(ra) # 80007232 <releasesleep>
}
    80005e82:	0001                	nop
    80005e84:	60e2                	ld	ra,24(sp)
    80005e86:	6442                	ld	s0,16(sp)
    80005e88:	6105                	addi	sp,sp,32
    80005e8a:	8082                	ret

0000000080005e8c <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
    80005e8c:	1101                	addi	sp,sp,-32
    80005e8e:	ec06                	sd	ra,24(sp)
    80005e90:	e822                	sd	s0,16(sp)
    80005e92:	1000                	addi	s0,sp,32
    80005e94:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    80005e98:	0049d517          	auipc	a0,0x49d
    80005e9c:	32850513          	addi	a0,a0,808 # 804a31c0 <itable>
    80005ea0:	ffffb097          	auipc	ra,0xffffb
    80005ea4:	3ca080e7          	jalr	970(ra) # 8000126a <acquire>

  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80005ea8:	fe843783          	ld	a5,-24(s0)
    80005eac:	479c                	lw	a5,8(a5)
    80005eae:	873e                	mv	a4,a5
    80005eb0:	4785                	li	a5,1
    80005eb2:	06f71f63          	bne	a4,a5,80005f30 <iput+0xa4>
    80005eb6:	fe843783          	ld	a5,-24(s0)
    80005eba:	43bc                	lw	a5,64(a5)
    80005ebc:	cbb5                	beqz	a5,80005f30 <iput+0xa4>
    80005ebe:	fe843783          	ld	a5,-24(s0)
    80005ec2:	04a79783          	lh	a5,74(a5)
    80005ec6:	e7ad                	bnez	a5,80005f30 <iput+0xa4>
    // inode has no links and no other references: truncate and free.

    // ip->ref == 1 means no other process can have ip locked,
    // so this acquiresleep() won't block (or deadlock).
    acquiresleep(&ip->lock);
    80005ec8:	fe843783          	ld	a5,-24(s0)
    80005ecc:	07c1                	addi	a5,a5,16
    80005ece:	853e                	mv	a0,a5
    80005ed0:	00001097          	auipc	ra,0x1
    80005ed4:	2f4080e7          	jalr	756(ra) # 800071c4 <acquiresleep>

    release(&itable.lock);
    80005ed8:	0049d517          	auipc	a0,0x49d
    80005edc:	2e850513          	addi	a0,a0,744 # 804a31c0 <itable>
    80005ee0:	ffffb097          	auipc	ra,0xffffb
    80005ee4:	3ee080e7          	jalr	1006(ra) # 800012ce <release>

    itrunc(ip);
    80005ee8:	fe843503          	ld	a0,-24(s0)
    80005eec:	00000097          	auipc	ra,0x0
    80005ef0:	1fa080e7          	jalr	506(ra) # 800060e6 <itrunc>
    ip->type = 0;
    80005ef4:	fe843783          	ld	a5,-24(s0)
    80005ef8:	04079223          	sh	zero,68(a5)
    iupdate(ip);
    80005efc:	fe843503          	ld	a0,-24(s0)
    80005f00:	00000097          	auipc	ra,0x0
    80005f04:	bae080e7          	jalr	-1106(ra) # 80005aae <iupdate>
    ip->valid = 0;
    80005f08:	fe843783          	ld	a5,-24(s0)
    80005f0c:	0407a023          	sw	zero,64(a5)

    releasesleep(&ip->lock);
    80005f10:	fe843783          	ld	a5,-24(s0)
    80005f14:	07c1                	addi	a5,a5,16
    80005f16:	853e                	mv	a0,a5
    80005f18:	00001097          	auipc	ra,0x1
    80005f1c:	31a080e7          	jalr	794(ra) # 80007232 <releasesleep>

    acquire(&itable.lock);
    80005f20:	0049d517          	auipc	a0,0x49d
    80005f24:	2a050513          	addi	a0,a0,672 # 804a31c0 <itable>
    80005f28:	ffffb097          	auipc	ra,0xffffb
    80005f2c:	342080e7          	jalr	834(ra) # 8000126a <acquire>
  }

  ip->ref--;
    80005f30:	fe843783          	ld	a5,-24(s0)
    80005f34:	479c                	lw	a5,8(a5)
    80005f36:	37fd                	addiw	a5,a5,-1
    80005f38:	0007871b          	sext.w	a4,a5
    80005f3c:	fe843783          	ld	a5,-24(s0)
    80005f40:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80005f42:	0049d517          	auipc	a0,0x49d
    80005f46:	27e50513          	addi	a0,a0,638 # 804a31c0 <itable>
    80005f4a:	ffffb097          	auipc	ra,0xffffb
    80005f4e:	384080e7          	jalr	900(ra) # 800012ce <release>
}
    80005f52:	0001                	nop
    80005f54:	60e2                	ld	ra,24(sp)
    80005f56:	6442                	ld	s0,16(sp)
    80005f58:	6105                	addi	sp,sp,32
    80005f5a:	8082                	ret

0000000080005f5c <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
    80005f5c:	1101                	addi	sp,sp,-32
    80005f5e:	ec06                	sd	ra,24(sp)
    80005f60:	e822                	sd	s0,16(sp)
    80005f62:	1000                	addi	s0,sp,32
    80005f64:	fea43423          	sd	a0,-24(s0)
  iunlock(ip);
    80005f68:	fe843503          	ld	a0,-24(s0)
    80005f6c:	00000097          	auipc	ra,0x0
    80005f70:	ec6080e7          	jalr	-314(ra) # 80005e32 <iunlock>
  iput(ip);
    80005f74:	fe843503          	ld	a0,-24(s0)
    80005f78:	00000097          	auipc	ra,0x0
    80005f7c:	f14080e7          	jalr	-236(ra) # 80005e8c <iput>
}
    80005f80:	0001                	nop
    80005f82:	60e2                	ld	ra,24(sp)
    80005f84:	6442                	ld	s0,16(sp)
    80005f86:	6105                	addi	sp,sp,32
    80005f88:	8082                	ret

0000000080005f8a <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80005f8a:	7139                	addi	sp,sp,-64
    80005f8c:	fc06                	sd	ra,56(sp)
    80005f8e:	f822                	sd	s0,48(sp)
    80005f90:	0080                	addi	s0,sp,64
    80005f92:	fca43423          	sd	a0,-56(s0)
    80005f96:	87ae                	mv	a5,a1
    80005f98:	fcf42223          	sw	a5,-60(s0)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80005f9c:	fc442783          	lw	a5,-60(s0)
    80005fa0:	0007871b          	sext.w	a4,a5
    80005fa4:	47ad                	li	a5,11
    80005fa6:	04e7e863          	bltu	a5,a4,80005ff6 <bmap+0x6c>
    if((addr = ip->addrs[bn]) == 0)
    80005faa:	fc843703          	ld	a4,-56(s0)
    80005fae:	fc446783          	lwu	a5,-60(s0)
    80005fb2:	07d1                	addi	a5,a5,20
    80005fb4:	078a                	slli	a5,a5,0x2
    80005fb6:	97ba                	add	a5,a5,a4
    80005fb8:	439c                	lw	a5,0(a5)
    80005fba:	fef42623          	sw	a5,-20(s0)
    80005fbe:	fec42783          	lw	a5,-20(s0)
    80005fc2:	2781                	sext.w	a5,a5
    80005fc4:	e795                	bnez	a5,80005ff0 <bmap+0x66>
      ip->addrs[bn] = addr = balloc(ip->dev);
    80005fc6:	fc843783          	ld	a5,-56(s0)
    80005fca:	439c                	lw	a5,0(a5)
    80005fcc:	853e                	mv	a0,a5
    80005fce:	fffff097          	auipc	ra,0xfffff
    80005fd2:	6aa080e7          	jalr	1706(ra) # 80005678 <balloc>
    80005fd6:	87aa                	mv	a5,a0
    80005fd8:	fef42623          	sw	a5,-20(s0)
    80005fdc:	fc843703          	ld	a4,-56(s0)
    80005fe0:	fc446783          	lwu	a5,-60(s0)
    80005fe4:	07d1                	addi	a5,a5,20
    80005fe6:	078a                	slli	a5,a5,0x2
    80005fe8:	97ba                	add	a5,a5,a4
    80005fea:	fec42703          	lw	a4,-20(s0)
    80005fee:	c398                	sw	a4,0(a5)
    return addr;
    80005ff0:	fec42783          	lw	a5,-20(s0)
    80005ff4:	a0e5                	j	800060dc <bmap+0x152>
  }
  bn -= NDIRECT;
    80005ff6:	fc442783          	lw	a5,-60(s0)
    80005ffa:	37d1                	addiw	a5,a5,-12
    80005ffc:	fcf42223          	sw	a5,-60(s0)

  if(bn < NINDIRECT){
    80006000:	fc442783          	lw	a5,-60(s0)
    80006004:	0007871b          	sext.w	a4,a5
    80006008:	0ff00793          	li	a5,255
    8000600c:	0ce7e063          	bltu	a5,a4,800060cc <bmap+0x142>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80006010:	fc843783          	ld	a5,-56(s0)
    80006014:	0807a783          	lw	a5,128(a5)
    80006018:	fef42623          	sw	a5,-20(s0)
    8000601c:	fec42783          	lw	a5,-20(s0)
    80006020:	2781                	sext.w	a5,a5
    80006022:	e395                	bnez	a5,80006046 <bmap+0xbc>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80006024:	fc843783          	ld	a5,-56(s0)
    80006028:	439c                	lw	a5,0(a5)
    8000602a:	853e                	mv	a0,a5
    8000602c:	fffff097          	auipc	ra,0xfffff
    80006030:	64c080e7          	jalr	1612(ra) # 80005678 <balloc>
    80006034:	87aa                	mv	a5,a0
    80006036:	fef42623          	sw	a5,-20(s0)
    8000603a:	fc843783          	ld	a5,-56(s0)
    8000603e:	fec42703          	lw	a4,-20(s0)
    80006042:	08e7a023          	sw	a4,128(a5)
    bp = bread(ip->dev, addr);
    80006046:	fc843783          	ld	a5,-56(s0)
    8000604a:	439c                	lw	a5,0(a5)
    8000604c:	fec42703          	lw	a4,-20(s0)
    80006050:	85ba                	mv	a1,a4
    80006052:	853e                	mv	a0,a5
    80006054:	fffff097          	auipc	ra,0xfffff
    80006058:	2da080e7          	jalr	730(ra) # 8000532e <bread>
    8000605c:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    80006060:	fe043783          	ld	a5,-32(s0)
    80006064:	05878793          	addi	a5,a5,88
    80006068:	fcf43c23          	sd	a5,-40(s0)
    if((addr = a[bn]) == 0){
    8000606c:	fc446783          	lwu	a5,-60(s0)
    80006070:	078a                	slli	a5,a5,0x2
    80006072:	fd843703          	ld	a4,-40(s0)
    80006076:	97ba                	add	a5,a5,a4
    80006078:	439c                	lw	a5,0(a5)
    8000607a:	fef42623          	sw	a5,-20(s0)
    8000607e:	fec42783          	lw	a5,-20(s0)
    80006082:	2781                	sext.w	a5,a5
    80006084:	eb9d                	bnez	a5,800060ba <bmap+0x130>
      a[bn] = addr = balloc(ip->dev);
    80006086:	fc843783          	ld	a5,-56(s0)
    8000608a:	439c                	lw	a5,0(a5)
    8000608c:	853e                	mv	a0,a5
    8000608e:	fffff097          	auipc	ra,0xfffff
    80006092:	5ea080e7          	jalr	1514(ra) # 80005678 <balloc>
    80006096:	87aa                	mv	a5,a0
    80006098:	fef42623          	sw	a5,-20(s0)
    8000609c:	fc446783          	lwu	a5,-60(s0)
    800060a0:	078a                	slli	a5,a5,0x2
    800060a2:	fd843703          	ld	a4,-40(s0)
    800060a6:	97ba                	add	a5,a5,a4
    800060a8:	fec42703          	lw	a4,-20(s0)
    800060ac:	c398                	sw	a4,0(a5)
      log_write(bp);
    800060ae:	fe043503          	ld	a0,-32(s0)
    800060b2:	00001097          	auipc	ra,0x1
    800060b6:	f92080e7          	jalr	-110(ra) # 80007044 <log_write>
    }
    brelse(bp);
    800060ba:	fe043503          	ld	a0,-32(s0)
    800060be:	fffff097          	auipc	ra,0xfffff
    800060c2:	312080e7          	jalr	786(ra) # 800053d0 <brelse>
    return addr;
    800060c6:	fec42783          	lw	a5,-20(s0)
    800060ca:	a809                	j	800060dc <bmap+0x152>
  }

  panic("bmap: out of range");
    800060cc:	00005517          	auipc	a0,0x5
    800060d0:	5b450513          	addi	a0,a0,1460 # 8000b680 <etext+0x680>
    800060d4:	ffffb097          	auipc	ra,0xffffb
    800060d8:	ba6080e7          	jalr	-1114(ra) # 80000c7a <panic>
}
    800060dc:	853e                	mv	a0,a5
    800060de:	70e2                	ld	ra,56(sp)
    800060e0:	7442                	ld	s0,48(sp)
    800060e2:	6121                	addi	sp,sp,64
    800060e4:	8082                	ret

00000000800060e6 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    800060e6:	7139                	addi	sp,sp,-64
    800060e8:	fc06                	sd	ra,56(sp)
    800060ea:	f822                	sd	s0,48(sp)
    800060ec:	0080                	addi	s0,sp,64
    800060ee:	fca43423          	sd	a0,-56(s0)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    800060f2:	fe042623          	sw	zero,-20(s0)
    800060f6:	a899                	j	8000614c <itrunc+0x66>
    if(ip->addrs[i]){
    800060f8:	fc843703          	ld	a4,-56(s0)
    800060fc:	fec42783          	lw	a5,-20(s0)
    80006100:	07d1                	addi	a5,a5,20
    80006102:	078a                	slli	a5,a5,0x2
    80006104:	97ba                	add	a5,a5,a4
    80006106:	439c                	lw	a5,0(a5)
    80006108:	cf8d                	beqz	a5,80006142 <itrunc+0x5c>
      bfree(ip->dev, ip->addrs[i]);
    8000610a:	fc843783          	ld	a5,-56(s0)
    8000610e:	439c                	lw	a5,0(a5)
    80006110:	0007869b          	sext.w	a3,a5
    80006114:	fc843703          	ld	a4,-56(s0)
    80006118:	fec42783          	lw	a5,-20(s0)
    8000611c:	07d1                	addi	a5,a5,20
    8000611e:	078a                	slli	a5,a5,0x2
    80006120:	97ba                	add	a5,a5,a4
    80006122:	439c                	lw	a5,0(a5)
    80006124:	85be                	mv	a1,a5
    80006126:	8536                	mv	a0,a3
    80006128:	fffff097          	auipc	ra,0xfffff
    8000612c:	6f6080e7          	jalr	1782(ra) # 8000581e <bfree>
      ip->addrs[i] = 0;
    80006130:	fc843703          	ld	a4,-56(s0)
    80006134:	fec42783          	lw	a5,-20(s0)
    80006138:	07d1                	addi	a5,a5,20
    8000613a:	078a                	slli	a5,a5,0x2
    8000613c:	97ba                	add	a5,a5,a4
    8000613e:	0007a023          	sw	zero,0(a5)
  for(i = 0; i < NDIRECT; i++){
    80006142:	fec42783          	lw	a5,-20(s0)
    80006146:	2785                	addiw	a5,a5,1
    80006148:	fef42623          	sw	a5,-20(s0)
    8000614c:	fec42783          	lw	a5,-20(s0)
    80006150:	0007871b          	sext.w	a4,a5
    80006154:	47ad                	li	a5,11
    80006156:	fae7d1e3          	bge	a5,a4,800060f8 <itrunc+0x12>
    }
  }

  if(ip->addrs[NDIRECT]){
    8000615a:	fc843783          	ld	a5,-56(s0)
    8000615e:	0807a783          	lw	a5,128(a5)
    80006162:	cbc5                	beqz	a5,80006212 <itrunc+0x12c>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80006164:	fc843783          	ld	a5,-56(s0)
    80006168:	4398                	lw	a4,0(a5)
    8000616a:	fc843783          	ld	a5,-56(s0)
    8000616e:	0807a783          	lw	a5,128(a5)
    80006172:	85be                	mv	a1,a5
    80006174:	853a                	mv	a0,a4
    80006176:	fffff097          	auipc	ra,0xfffff
    8000617a:	1b8080e7          	jalr	440(ra) # 8000532e <bread>
    8000617e:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    80006182:	fe043783          	ld	a5,-32(s0)
    80006186:	05878793          	addi	a5,a5,88
    8000618a:	fcf43c23          	sd	a5,-40(s0)
    for(j = 0; j < NINDIRECT; j++){
    8000618e:	fe042423          	sw	zero,-24(s0)
    80006192:	a081                	j	800061d2 <itrunc+0xec>
      if(a[j])
    80006194:	fe842783          	lw	a5,-24(s0)
    80006198:	078a                	slli	a5,a5,0x2
    8000619a:	fd843703          	ld	a4,-40(s0)
    8000619e:	97ba                	add	a5,a5,a4
    800061a0:	439c                	lw	a5,0(a5)
    800061a2:	c39d                	beqz	a5,800061c8 <itrunc+0xe2>
        bfree(ip->dev, a[j]);
    800061a4:	fc843783          	ld	a5,-56(s0)
    800061a8:	439c                	lw	a5,0(a5)
    800061aa:	0007869b          	sext.w	a3,a5
    800061ae:	fe842783          	lw	a5,-24(s0)
    800061b2:	078a                	slli	a5,a5,0x2
    800061b4:	fd843703          	ld	a4,-40(s0)
    800061b8:	97ba                	add	a5,a5,a4
    800061ba:	439c                	lw	a5,0(a5)
    800061bc:	85be                	mv	a1,a5
    800061be:	8536                	mv	a0,a3
    800061c0:	fffff097          	auipc	ra,0xfffff
    800061c4:	65e080e7          	jalr	1630(ra) # 8000581e <bfree>
    for(j = 0; j < NINDIRECT; j++){
    800061c8:	fe842783          	lw	a5,-24(s0)
    800061cc:	2785                	addiw	a5,a5,1
    800061ce:	fef42423          	sw	a5,-24(s0)
    800061d2:	fe842783          	lw	a5,-24(s0)
    800061d6:	873e                	mv	a4,a5
    800061d8:	0ff00793          	li	a5,255
    800061dc:	fae7fce3          	bgeu	a5,a4,80006194 <itrunc+0xae>
    }
    brelse(bp);
    800061e0:	fe043503          	ld	a0,-32(s0)
    800061e4:	fffff097          	auipc	ra,0xfffff
    800061e8:	1ec080e7          	jalr	492(ra) # 800053d0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    800061ec:	fc843783          	ld	a5,-56(s0)
    800061f0:	439c                	lw	a5,0(a5)
    800061f2:	0007871b          	sext.w	a4,a5
    800061f6:	fc843783          	ld	a5,-56(s0)
    800061fa:	0807a783          	lw	a5,128(a5)
    800061fe:	85be                	mv	a1,a5
    80006200:	853a                	mv	a0,a4
    80006202:	fffff097          	auipc	ra,0xfffff
    80006206:	61c080e7          	jalr	1564(ra) # 8000581e <bfree>
    ip->addrs[NDIRECT] = 0;
    8000620a:	fc843783          	ld	a5,-56(s0)
    8000620e:	0807a023          	sw	zero,128(a5)
  }

  ip->size = 0;
    80006212:	fc843783          	ld	a5,-56(s0)
    80006216:	0407a623          	sw	zero,76(a5)
  iupdate(ip);
    8000621a:	fc843503          	ld	a0,-56(s0)
    8000621e:	00000097          	auipc	ra,0x0
    80006222:	890080e7          	jalr	-1904(ra) # 80005aae <iupdate>
}
    80006226:	0001                	nop
    80006228:	70e2                	ld	ra,56(sp)
    8000622a:	7442                	ld	s0,48(sp)
    8000622c:	6121                	addi	sp,sp,64
    8000622e:	8082                	ret

0000000080006230 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80006230:	1101                	addi	sp,sp,-32
    80006232:	ec22                	sd	s0,24(sp)
    80006234:	1000                	addi	s0,sp,32
    80006236:	fea43423          	sd	a0,-24(s0)
    8000623a:	feb43023          	sd	a1,-32(s0)
  st->dev = ip->dev;
    8000623e:	fe843783          	ld	a5,-24(s0)
    80006242:	439c                	lw	a5,0(a5)
    80006244:	0007871b          	sext.w	a4,a5
    80006248:	fe043783          	ld	a5,-32(s0)
    8000624c:	c398                	sw	a4,0(a5)
  st->ino = ip->inum;
    8000624e:	fe843783          	ld	a5,-24(s0)
    80006252:	43d8                	lw	a4,4(a5)
    80006254:	fe043783          	ld	a5,-32(s0)
    80006258:	c3d8                	sw	a4,4(a5)
  st->type = ip->type;
    8000625a:	fe843783          	ld	a5,-24(s0)
    8000625e:	04479703          	lh	a4,68(a5)
    80006262:	fe043783          	ld	a5,-32(s0)
    80006266:	00e79423          	sh	a4,8(a5)
  st->nlink = ip->nlink;
    8000626a:	fe843783          	ld	a5,-24(s0)
    8000626e:	04a79703          	lh	a4,74(a5)
    80006272:	fe043783          	ld	a5,-32(s0)
    80006276:	00e79523          	sh	a4,10(a5)
  st->size = ip->size;
    8000627a:	fe843783          	ld	a5,-24(s0)
    8000627e:	47fc                	lw	a5,76(a5)
    80006280:	02079713          	slli	a4,a5,0x20
    80006284:	9301                	srli	a4,a4,0x20
    80006286:	fe043783          	ld	a5,-32(s0)
    8000628a:	eb98                	sd	a4,16(a5)
}
    8000628c:	0001                	nop
    8000628e:	6462                	ld	s0,24(sp)
    80006290:	6105                	addi	sp,sp,32
    80006292:	8082                	ret

0000000080006294 <readi>:
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.
int
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    80006294:	711d                	addi	sp,sp,-96
    80006296:	ec86                	sd	ra,88(sp)
    80006298:	e8a2                	sd	s0,80(sp)
    8000629a:	e4a6                	sd	s1,72(sp)
    8000629c:	1080                	addi	s0,sp,96
    8000629e:	faa43c23          	sd	a0,-72(s0)
    800062a2:	87ae                	mv	a5,a1
    800062a4:	fac43423          	sd	a2,-88(s0)
    800062a8:	faf42a23          	sw	a5,-76(s0)
    800062ac:	87b6                	mv	a5,a3
    800062ae:	faf42823          	sw	a5,-80(s0)
    800062b2:	87ba                	mv	a5,a4
    800062b4:	faf42223          	sw	a5,-92(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800062b8:	fb843783          	ld	a5,-72(s0)
    800062bc:	47f8                	lw	a4,76(a5)
    800062be:	fb042783          	lw	a5,-80(s0)
    800062c2:	2781                	sext.w	a5,a5
    800062c4:	00f76f63          	bltu	a4,a5,800062e2 <readi+0x4e>
    800062c8:	fb042783          	lw	a5,-80(s0)
    800062cc:	873e                	mv	a4,a5
    800062ce:	fa442783          	lw	a5,-92(s0)
    800062d2:	9fb9                	addw	a5,a5,a4
    800062d4:	0007871b          	sext.w	a4,a5
    800062d8:	fb042783          	lw	a5,-80(s0)
    800062dc:	2781                	sext.w	a5,a5
    800062de:	00f77463          	bgeu	a4,a5,800062e6 <readi+0x52>
    return 0;
    800062e2:	4781                	li	a5,0
    800062e4:	aa15                	j	80006418 <readi+0x184>
  if(off + n > ip->size)
    800062e6:	fb042783          	lw	a5,-80(s0)
    800062ea:	873e                	mv	a4,a5
    800062ec:	fa442783          	lw	a5,-92(s0)
    800062f0:	9fb9                	addw	a5,a5,a4
    800062f2:	0007871b          	sext.w	a4,a5
    800062f6:	fb843783          	ld	a5,-72(s0)
    800062fa:	47fc                	lw	a5,76(a5)
    800062fc:	00e7fa63          	bgeu	a5,a4,80006310 <readi+0x7c>
    n = ip->size - off;
    80006300:	fb843783          	ld	a5,-72(s0)
    80006304:	47fc                	lw	a5,76(a5)
    80006306:	fb042703          	lw	a4,-80(s0)
    8000630a:	9f99                	subw	a5,a5,a4
    8000630c:	faf42223          	sw	a5,-92(s0)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80006310:	fc042e23          	sw	zero,-36(s0)
    80006314:	a0fd                	j	80006402 <readi+0x16e>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80006316:	fb843783          	ld	a5,-72(s0)
    8000631a:	4384                	lw	s1,0(a5)
    8000631c:	fb042783          	lw	a5,-80(s0)
    80006320:	00a7d79b          	srliw	a5,a5,0xa
    80006324:	2781                	sext.w	a5,a5
    80006326:	85be                	mv	a1,a5
    80006328:	fb843503          	ld	a0,-72(s0)
    8000632c:	00000097          	auipc	ra,0x0
    80006330:	c5e080e7          	jalr	-930(ra) # 80005f8a <bmap>
    80006334:	87aa                	mv	a5,a0
    80006336:	2781                	sext.w	a5,a5
    80006338:	85be                	mv	a1,a5
    8000633a:	8526                	mv	a0,s1
    8000633c:	fffff097          	auipc	ra,0xfffff
    80006340:	ff2080e7          	jalr	-14(ra) # 8000532e <bread>
    80006344:	fca43823          	sd	a0,-48(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    80006348:	fb042783          	lw	a5,-80(s0)
    8000634c:	3ff7f793          	andi	a5,a5,1023
    80006350:	2781                	sext.w	a5,a5
    80006352:	40000713          	li	a4,1024
    80006356:	40f707bb          	subw	a5,a4,a5
    8000635a:	2781                	sext.w	a5,a5
    8000635c:	fa442703          	lw	a4,-92(s0)
    80006360:	86ba                	mv	a3,a4
    80006362:	fdc42703          	lw	a4,-36(s0)
    80006366:	40e6873b          	subw	a4,a3,a4
    8000636a:	2701                	sext.w	a4,a4
    8000636c:	863a                	mv	a2,a4
    8000636e:	0007869b          	sext.w	a3,a5
    80006372:	0006071b          	sext.w	a4,a2
    80006376:	00d77363          	bgeu	a4,a3,8000637c <readi+0xe8>
    8000637a:	87b2                	mv	a5,a2
    8000637c:	fcf42623          	sw	a5,-52(s0)
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80006380:	fd043783          	ld	a5,-48(s0)
    80006384:	05878713          	addi	a4,a5,88
    80006388:	fb046783          	lwu	a5,-80(s0)
    8000638c:	3ff7f793          	andi	a5,a5,1023
    80006390:	973e                	add	a4,a4,a5
    80006392:	fcc46683          	lwu	a3,-52(s0)
    80006396:	fb442783          	lw	a5,-76(s0)
    8000639a:	863a                	mv	a2,a4
    8000639c:	fa843583          	ld	a1,-88(s0)
    800063a0:	853e                	mv	a0,a5
    800063a2:	ffffd097          	auipc	ra,0xffffd
    800063a6:	718080e7          	jalr	1816(ra) # 80003aba <either_copyout>
    800063aa:	87aa                	mv	a5,a0
    800063ac:	873e                	mv	a4,a5
    800063ae:	57fd                	li	a5,-1
    800063b0:	00f71c63          	bne	a4,a5,800063c8 <readi+0x134>
      brelse(bp);
    800063b4:	fd043503          	ld	a0,-48(s0)
    800063b8:	fffff097          	auipc	ra,0xfffff
    800063bc:	018080e7          	jalr	24(ra) # 800053d0 <brelse>
      tot = -1;
    800063c0:	57fd                	li	a5,-1
    800063c2:	fcf42e23          	sw	a5,-36(s0)
      break;
    800063c6:	a0b9                	j	80006414 <readi+0x180>
    }
    brelse(bp);
    800063c8:	fd043503          	ld	a0,-48(s0)
    800063cc:	fffff097          	auipc	ra,0xfffff
    800063d0:	004080e7          	jalr	4(ra) # 800053d0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800063d4:	fdc42783          	lw	a5,-36(s0)
    800063d8:	873e                	mv	a4,a5
    800063da:	fcc42783          	lw	a5,-52(s0)
    800063de:	9fb9                	addw	a5,a5,a4
    800063e0:	fcf42e23          	sw	a5,-36(s0)
    800063e4:	fb042783          	lw	a5,-80(s0)
    800063e8:	873e                	mv	a4,a5
    800063ea:	fcc42783          	lw	a5,-52(s0)
    800063ee:	9fb9                	addw	a5,a5,a4
    800063f0:	faf42823          	sw	a5,-80(s0)
    800063f4:	fcc46783          	lwu	a5,-52(s0)
    800063f8:	fa843703          	ld	a4,-88(s0)
    800063fc:	97ba                	add	a5,a5,a4
    800063fe:	faf43423          	sd	a5,-88(s0)
    80006402:	fdc42783          	lw	a5,-36(s0)
    80006406:	873e                	mv	a4,a5
    80006408:	fa442783          	lw	a5,-92(s0)
    8000640c:	2701                	sext.w	a4,a4
    8000640e:	2781                	sext.w	a5,a5
    80006410:	f0f763e3          	bltu	a4,a5,80006316 <readi+0x82>
  }
  return tot;
    80006414:	fdc42783          	lw	a5,-36(s0)
}
    80006418:	853e                	mv	a0,a5
    8000641a:	60e6                	ld	ra,88(sp)
    8000641c:	6446                	ld	s0,80(sp)
    8000641e:	64a6                	ld	s1,72(sp)
    80006420:	6125                	addi	sp,sp,96
    80006422:	8082                	ret

0000000080006424 <writei>:
// Returns the number of bytes successfully written.
// If the return value is less than the requested n,
// there was an error of some kind.
int
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    80006424:	711d                	addi	sp,sp,-96
    80006426:	ec86                	sd	ra,88(sp)
    80006428:	e8a2                	sd	s0,80(sp)
    8000642a:	e4a6                	sd	s1,72(sp)
    8000642c:	1080                	addi	s0,sp,96
    8000642e:	faa43c23          	sd	a0,-72(s0)
    80006432:	87ae                	mv	a5,a1
    80006434:	fac43423          	sd	a2,-88(s0)
    80006438:	faf42a23          	sw	a5,-76(s0)
    8000643c:	87b6                	mv	a5,a3
    8000643e:	faf42823          	sw	a5,-80(s0)
    80006442:	87ba                	mv	a5,a4
    80006444:	faf42223          	sw	a5,-92(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80006448:	fb843783          	ld	a5,-72(s0)
    8000644c:	47f8                	lw	a4,76(a5)
    8000644e:	fb042783          	lw	a5,-80(s0)
    80006452:	2781                	sext.w	a5,a5
    80006454:	00f76f63          	bltu	a4,a5,80006472 <writei+0x4e>
    80006458:	fb042783          	lw	a5,-80(s0)
    8000645c:	873e                	mv	a4,a5
    8000645e:	fa442783          	lw	a5,-92(s0)
    80006462:	9fb9                	addw	a5,a5,a4
    80006464:	0007871b          	sext.w	a4,a5
    80006468:	fb042783          	lw	a5,-80(s0)
    8000646c:	2781                	sext.w	a5,a5
    8000646e:	00f77463          	bgeu	a4,a5,80006476 <writei+0x52>
    return -1;
    80006472:	57fd                	li	a5,-1
    80006474:	aa89                	j	800065c6 <writei+0x1a2>
  if(off + n > MAXFILE*BSIZE)
    80006476:	fb042783          	lw	a5,-80(s0)
    8000647a:	873e                	mv	a4,a5
    8000647c:	fa442783          	lw	a5,-92(s0)
    80006480:	9fb9                	addw	a5,a5,a4
    80006482:	2781                	sext.w	a5,a5
    80006484:	873e                	mv	a4,a5
    80006486:	000437b7          	lui	a5,0x43
    8000648a:	00e7f463          	bgeu	a5,a4,80006492 <writei+0x6e>
    return -1;
    8000648e:	57fd                	li	a5,-1
    80006490:	aa1d                	j	800065c6 <writei+0x1a2>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80006492:	fc042e23          	sw	zero,-36(s0)
    80006496:	a8d5                	j	8000658a <writei+0x166>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80006498:	fb843783          	ld	a5,-72(s0)
    8000649c:	4384                	lw	s1,0(a5)
    8000649e:	fb042783          	lw	a5,-80(s0)
    800064a2:	00a7d79b          	srliw	a5,a5,0xa
    800064a6:	2781                	sext.w	a5,a5
    800064a8:	85be                	mv	a1,a5
    800064aa:	fb843503          	ld	a0,-72(s0)
    800064ae:	00000097          	auipc	ra,0x0
    800064b2:	adc080e7          	jalr	-1316(ra) # 80005f8a <bmap>
    800064b6:	87aa                	mv	a5,a0
    800064b8:	2781                	sext.w	a5,a5
    800064ba:	85be                	mv	a1,a5
    800064bc:	8526                	mv	a0,s1
    800064be:	fffff097          	auipc	ra,0xfffff
    800064c2:	e70080e7          	jalr	-400(ra) # 8000532e <bread>
    800064c6:	fca43823          	sd	a0,-48(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    800064ca:	fb042783          	lw	a5,-80(s0)
    800064ce:	3ff7f793          	andi	a5,a5,1023
    800064d2:	2781                	sext.w	a5,a5
    800064d4:	40000713          	li	a4,1024
    800064d8:	40f707bb          	subw	a5,a4,a5
    800064dc:	2781                	sext.w	a5,a5
    800064de:	fa442703          	lw	a4,-92(s0)
    800064e2:	86ba                	mv	a3,a4
    800064e4:	fdc42703          	lw	a4,-36(s0)
    800064e8:	40e6873b          	subw	a4,a3,a4
    800064ec:	2701                	sext.w	a4,a4
    800064ee:	863a                	mv	a2,a4
    800064f0:	0007869b          	sext.w	a3,a5
    800064f4:	0006071b          	sext.w	a4,a2
    800064f8:	00d77363          	bgeu	a4,a3,800064fe <writei+0xda>
    800064fc:	87b2                	mv	a5,a2
    800064fe:	fcf42623          	sw	a5,-52(s0)
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80006502:	fd043783          	ld	a5,-48(s0)
    80006506:	05878713          	addi	a4,a5,88 # 43058 <_entry-0x7ffbcfa8>
    8000650a:	fb046783          	lwu	a5,-80(s0)
    8000650e:	3ff7f793          	andi	a5,a5,1023
    80006512:	97ba                	add	a5,a5,a4
    80006514:	fcc46683          	lwu	a3,-52(s0)
    80006518:	fb442703          	lw	a4,-76(s0)
    8000651c:	fa843603          	ld	a2,-88(s0)
    80006520:	85ba                	mv	a1,a4
    80006522:	853e                	mv	a0,a5
    80006524:	ffffd097          	auipc	ra,0xffffd
    80006528:	60a080e7          	jalr	1546(ra) # 80003b2e <either_copyin>
    8000652c:	87aa                	mv	a5,a0
    8000652e:	873e                	mv	a4,a5
    80006530:	57fd                	li	a5,-1
    80006532:	00f71963          	bne	a4,a5,80006544 <writei+0x120>
      brelse(bp);
    80006536:	fd043503          	ld	a0,-48(s0)
    8000653a:	fffff097          	auipc	ra,0xfffff
    8000653e:	e96080e7          	jalr	-362(ra) # 800053d0 <brelse>
      break;
    80006542:	a8a9                	j	8000659c <writei+0x178>
    }
    log_write(bp);
    80006544:	fd043503          	ld	a0,-48(s0)
    80006548:	00001097          	auipc	ra,0x1
    8000654c:	afc080e7          	jalr	-1284(ra) # 80007044 <log_write>
    brelse(bp);
    80006550:	fd043503          	ld	a0,-48(s0)
    80006554:	fffff097          	auipc	ra,0xfffff
    80006558:	e7c080e7          	jalr	-388(ra) # 800053d0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000655c:	fdc42783          	lw	a5,-36(s0)
    80006560:	873e                	mv	a4,a5
    80006562:	fcc42783          	lw	a5,-52(s0)
    80006566:	9fb9                	addw	a5,a5,a4
    80006568:	fcf42e23          	sw	a5,-36(s0)
    8000656c:	fb042783          	lw	a5,-80(s0)
    80006570:	873e                	mv	a4,a5
    80006572:	fcc42783          	lw	a5,-52(s0)
    80006576:	9fb9                	addw	a5,a5,a4
    80006578:	faf42823          	sw	a5,-80(s0)
    8000657c:	fcc46783          	lwu	a5,-52(s0)
    80006580:	fa843703          	ld	a4,-88(s0)
    80006584:	97ba                	add	a5,a5,a4
    80006586:	faf43423          	sd	a5,-88(s0)
    8000658a:	fdc42783          	lw	a5,-36(s0)
    8000658e:	873e                	mv	a4,a5
    80006590:	fa442783          	lw	a5,-92(s0)
    80006594:	2701                	sext.w	a4,a4
    80006596:	2781                	sext.w	a5,a5
    80006598:	f0f760e3          	bltu	a4,a5,80006498 <writei+0x74>
  }

  if(off > ip->size)
    8000659c:	fb843783          	ld	a5,-72(s0)
    800065a0:	47f8                	lw	a4,76(a5)
    800065a2:	fb042783          	lw	a5,-80(s0)
    800065a6:	2781                	sext.w	a5,a5
    800065a8:	00f77763          	bgeu	a4,a5,800065b6 <writei+0x192>
    ip->size = off;
    800065ac:	fb843783          	ld	a5,-72(s0)
    800065b0:	fb042703          	lw	a4,-80(s0)
    800065b4:	c7f8                	sw	a4,76(a5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    800065b6:	fb843503          	ld	a0,-72(s0)
    800065ba:	fffff097          	auipc	ra,0xfffff
    800065be:	4f4080e7          	jalr	1268(ra) # 80005aae <iupdate>

  return tot;
    800065c2:	fdc42783          	lw	a5,-36(s0)
}
    800065c6:	853e                	mv	a0,a5
    800065c8:	60e6                	ld	ra,88(sp)
    800065ca:	6446                	ld	s0,80(sp)
    800065cc:	64a6                	ld	s1,72(sp)
    800065ce:	6125                	addi	sp,sp,96
    800065d0:	8082                	ret

00000000800065d2 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    800065d2:	1101                	addi	sp,sp,-32
    800065d4:	ec06                	sd	ra,24(sp)
    800065d6:	e822                	sd	s0,16(sp)
    800065d8:	1000                	addi	s0,sp,32
    800065da:	fea43423          	sd	a0,-24(s0)
    800065de:	feb43023          	sd	a1,-32(s0)
  return strncmp(s, t, DIRSIZ);
    800065e2:	4639                	li	a2,14
    800065e4:	fe043583          	ld	a1,-32(s0)
    800065e8:	fe843503          	ld	a0,-24(s0)
    800065ec:	ffffb097          	auipc	ra,0xffffb
    800065f0:	04a080e7          	jalr	74(ra) # 80001636 <strncmp>
    800065f4:	87aa                	mv	a5,a0
}
    800065f6:	853e                	mv	a0,a5
    800065f8:	60e2                	ld	ra,24(sp)
    800065fa:	6442                	ld	s0,16(sp)
    800065fc:	6105                	addi	sp,sp,32
    800065fe:	8082                	ret

0000000080006600 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80006600:	715d                	addi	sp,sp,-80
    80006602:	e486                	sd	ra,72(sp)
    80006604:	e0a2                	sd	s0,64(sp)
    80006606:	0880                	addi	s0,sp,80
    80006608:	fca43423          	sd	a0,-56(s0)
    8000660c:	fcb43023          	sd	a1,-64(s0)
    80006610:	fac43c23          	sd	a2,-72(s0)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80006614:	fc843783          	ld	a5,-56(s0)
    80006618:	04479783          	lh	a5,68(a5)
    8000661c:	0007871b          	sext.w	a4,a5
    80006620:	4785                	li	a5,1
    80006622:	00f70a63          	beq	a4,a5,80006636 <dirlookup+0x36>
    panic("dirlookup not DIR");
    80006626:	00005517          	auipc	a0,0x5
    8000662a:	07250513          	addi	a0,a0,114 # 8000b698 <etext+0x698>
    8000662e:	ffffa097          	auipc	ra,0xffffa
    80006632:	64c080e7          	jalr	1612(ra) # 80000c7a <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
    80006636:	fe042623          	sw	zero,-20(s0)
    8000663a:	a849                	j	800066cc <dirlookup+0xcc>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000663c:	fd840793          	addi	a5,s0,-40
    80006640:	fec42683          	lw	a3,-20(s0)
    80006644:	4741                	li	a4,16
    80006646:	863e                	mv	a2,a5
    80006648:	4581                	li	a1,0
    8000664a:	fc843503          	ld	a0,-56(s0)
    8000664e:	00000097          	auipc	ra,0x0
    80006652:	c46080e7          	jalr	-954(ra) # 80006294 <readi>
    80006656:	87aa                	mv	a5,a0
    80006658:	873e                	mv	a4,a5
    8000665a:	47c1                	li	a5,16
    8000665c:	00f70a63          	beq	a4,a5,80006670 <dirlookup+0x70>
      panic("dirlookup read");
    80006660:	00005517          	auipc	a0,0x5
    80006664:	05050513          	addi	a0,a0,80 # 8000b6b0 <etext+0x6b0>
    80006668:	ffffa097          	auipc	ra,0xffffa
    8000666c:	612080e7          	jalr	1554(ra) # 80000c7a <panic>
    if(de.inum == 0)
    80006670:	fd845783          	lhu	a5,-40(s0)
    80006674:	c7b1                	beqz	a5,800066c0 <dirlookup+0xc0>
      continue;
    if(namecmp(name, de.name) == 0){
    80006676:	fd840793          	addi	a5,s0,-40
    8000667a:	0789                	addi	a5,a5,2
    8000667c:	85be                	mv	a1,a5
    8000667e:	fc043503          	ld	a0,-64(s0)
    80006682:	00000097          	auipc	ra,0x0
    80006686:	f50080e7          	jalr	-176(ra) # 800065d2 <namecmp>
    8000668a:	87aa                	mv	a5,a0
    8000668c:	eb9d                	bnez	a5,800066c2 <dirlookup+0xc2>
      // entry matches path element
      if(poff)
    8000668e:	fb843783          	ld	a5,-72(s0)
    80006692:	c791                	beqz	a5,8000669e <dirlookup+0x9e>
        *poff = off;
    80006694:	fb843783          	ld	a5,-72(s0)
    80006698:	fec42703          	lw	a4,-20(s0)
    8000669c:	c398                	sw	a4,0(a5)
      inum = de.inum;
    8000669e:	fd845783          	lhu	a5,-40(s0)
    800066a2:	fef42423          	sw	a5,-24(s0)
      return iget(dp->dev, inum);
    800066a6:	fc843783          	ld	a5,-56(s0)
    800066aa:	439c                	lw	a5,0(a5)
    800066ac:	fe842703          	lw	a4,-24(s0)
    800066b0:	85ba                	mv	a1,a4
    800066b2:	853e                	mv	a0,a5
    800066b4:	fffff097          	auipc	ra,0xfffff
    800066b8:	4e2080e7          	jalr	1250(ra) # 80005b96 <iget>
    800066bc:	87aa                	mv	a5,a0
    800066be:	a005                	j	800066de <dirlookup+0xde>
      continue;
    800066c0:	0001                	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
    800066c2:	fec42783          	lw	a5,-20(s0)
    800066c6:	27c1                	addiw	a5,a5,16
    800066c8:	fef42623          	sw	a5,-20(s0)
    800066cc:	fc843783          	ld	a5,-56(s0)
    800066d0:	47f8                	lw	a4,76(a5)
    800066d2:	fec42783          	lw	a5,-20(s0)
    800066d6:	2781                	sext.w	a5,a5
    800066d8:	f6e7e2e3          	bltu	a5,a4,8000663c <dirlookup+0x3c>
    }
  }

  return 0;
    800066dc:	4781                	li	a5,0
}
    800066de:	853e                	mv	a0,a5
    800066e0:	60a6                	ld	ra,72(sp)
    800066e2:	6406                	ld	s0,64(sp)
    800066e4:	6161                	addi	sp,sp,80
    800066e6:	8082                	ret

00000000800066e8 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
    800066e8:	715d                	addi	sp,sp,-80
    800066ea:	e486                	sd	ra,72(sp)
    800066ec:	e0a2                	sd	s0,64(sp)
    800066ee:	0880                	addi	s0,sp,80
    800066f0:	fca43423          	sd	a0,-56(s0)
    800066f4:	fcb43023          	sd	a1,-64(s0)
    800066f8:	87b2                	mv	a5,a2
    800066fa:	faf42e23          	sw	a5,-68(s0)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    800066fe:	4601                	li	a2,0
    80006700:	fc043583          	ld	a1,-64(s0)
    80006704:	fc843503          	ld	a0,-56(s0)
    80006708:	00000097          	auipc	ra,0x0
    8000670c:	ef8080e7          	jalr	-264(ra) # 80006600 <dirlookup>
    80006710:	fea43023          	sd	a0,-32(s0)
    80006714:	fe043783          	ld	a5,-32(s0)
    80006718:	cb89                	beqz	a5,8000672a <dirlink+0x42>
    iput(ip);
    8000671a:	fe043503          	ld	a0,-32(s0)
    8000671e:	fffff097          	auipc	ra,0xfffff
    80006722:	76e080e7          	jalr	1902(ra) # 80005e8c <iput>
    return -1;
    80006726:	57fd                	li	a5,-1
    80006728:	a865                	j	800067e0 <dirlink+0xf8>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000672a:	fe042623          	sw	zero,-20(s0)
    8000672e:	a0a1                	j	80006776 <dirlink+0x8e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80006730:	fd040793          	addi	a5,s0,-48
    80006734:	fec42683          	lw	a3,-20(s0)
    80006738:	4741                	li	a4,16
    8000673a:	863e                	mv	a2,a5
    8000673c:	4581                	li	a1,0
    8000673e:	fc843503          	ld	a0,-56(s0)
    80006742:	00000097          	auipc	ra,0x0
    80006746:	b52080e7          	jalr	-1198(ra) # 80006294 <readi>
    8000674a:	87aa                	mv	a5,a0
    8000674c:	873e                	mv	a4,a5
    8000674e:	47c1                	li	a5,16
    80006750:	00f70a63          	beq	a4,a5,80006764 <dirlink+0x7c>
      panic("dirlink read");
    80006754:	00005517          	auipc	a0,0x5
    80006758:	f6c50513          	addi	a0,a0,-148 # 8000b6c0 <etext+0x6c0>
    8000675c:	ffffa097          	auipc	ra,0xffffa
    80006760:	51e080e7          	jalr	1310(ra) # 80000c7a <panic>
    if(de.inum == 0)
    80006764:	fd045783          	lhu	a5,-48(s0)
    80006768:	cf99                	beqz	a5,80006786 <dirlink+0x9e>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000676a:	fec42783          	lw	a5,-20(s0)
    8000676e:	27c1                	addiw	a5,a5,16
    80006770:	2781                	sext.w	a5,a5
    80006772:	fef42623          	sw	a5,-20(s0)
    80006776:	fc843783          	ld	a5,-56(s0)
    8000677a:	47f8                	lw	a4,76(a5)
    8000677c:	fec42783          	lw	a5,-20(s0)
    80006780:	fae7e8e3          	bltu	a5,a4,80006730 <dirlink+0x48>
    80006784:	a011                	j	80006788 <dirlink+0xa0>
      break;
    80006786:	0001                	nop
  }

  strncpy(de.name, name, DIRSIZ);
    80006788:	fd040793          	addi	a5,s0,-48
    8000678c:	0789                	addi	a5,a5,2
    8000678e:	4639                	li	a2,14
    80006790:	fc043583          	ld	a1,-64(s0)
    80006794:	853e                	mv	a0,a5
    80006796:	ffffb097          	auipc	ra,0xffffb
    8000679a:	f2a080e7          	jalr	-214(ra) # 800016c0 <strncpy>
  de.inum = inum;
    8000679e:	fbc42783          	lw	a5,-68(s0)
    800067a2:	17c2                	slli	a5,a5,0x30
    800067a4:	93c1                	srli	a5,a5,0x30
    800067a6:	fcf41823          	sh	a5,-48(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800067aa:	fd040793          	addi	a5,s0,-48
    800067ae:	fec42683          	lw	a3,-20(s0)
    800067b2:	4741                	li	a4,16
    800067b4:	863e                	mv	a2,a5
    800067b6:	4581                	li	a1,0
    800067b8:	fc843503          	ld	a0,-56(s0)
    800067bc:	00000097          	auipc	ra,0x0
    800067c0:	c68080e7          	jalr	-920(ra) # 80006424 <writei>
    800067c4:	87aa                	mv	a5,a0
    800067c6:	873e                	mv	a4,a5
    800067c8:	47c1                	li	a5,16
    800067ca:	00f70a63          	beq	a4,a5,800067de <dirlink+0xf6>
    panic("dirlink");
    800067ce:	00005517          	auipc	a0,0x5
    800067d2:	f0250513          	addi	a0,a0,-254 # 8000b6d0 <etext+0x6d0>
    800067d6:	ffffa097          	auipc	ra,0xffffa
    800067da:	4a4080e7          	jalr	1188(ra) # 80000c7a <panic>

  return 0;
    800067de:	4781                	li	a5,0
}
    800067e0:	853e                	mv	a0,a5
    800067e2:	60a6                	ld	ra,72(sp)
    800067e4:	6406                	ld	s0,64(sp)
    800067e6:	6161                	addi	sp,sp,80
    800067e8:	8082                	ret

00000000800067ea <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
    800067ea:	7179                	addi	sp,sp,-48
    800067ec:	f406                	sd	ra,40(sp)
    800067ee:	f022                	sd	s0,32(sp)
    800067f0:	1800                	addi	s0,sp,48
    800067f2:	fca43c23          	sd	a0,-40(s0)
    800067f6:	fcb43823          	sd	a1,-48(s0)
  char *s;
  int len;

  while(*path == '/')
    800067fa:	a031                	j	80006806 <skipelem+0x1c>
    path++;
    800067fc:	fd843783          	ld	a5,-40(s0)
    80006800:	0785                	addi	a5,a5,1
    80006802:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80006806:	fd843783          	ld	a5,-40(s0)
    8000680a:	0007c783          	lbu	a5,0(a5)
    8000680e:	873e                	mv	a4,a5
    80006810:	02f00793          	li	a5,47
    80006814:	fef704e3          	beq	a4,a5,800067fc <skipelem+0x12>
  if(*path == 0)
    80006818:	fd843783          	ld	a5,-40(s0)
    8000681c:	0007c783          	lbu	a5,0(a5)
    80006820:	e399                	bnez	a5,80006826 <skipelem+0x3c>
    return 0;
    80006822:	4781                	li	a5,0
    80006824:	a06d                	j	800068ce <skipelem+0xe4>
  s = path;
    80006826:	fd843783          	ld	a5,-40(s0)
    8000682a:	fef43423          	sd	a5,-24(s0)
  while(*path != '/' && *path != 0)
    8000682e:	a031                	j	8000683a <skipelem+0x50>
    path++;
    80006830:	fd843783          	ld	a5,-40(s0)
    80006834:	0785                	addi	a5,a5,1
    80006836:	fcf43c23          	sd	a5,-40(s0)
  while(*path != '/' && *path != 0)
    8000683a:	fd843783          	ld	a5,-40(s0)
    8000683e:	0007c783          	lbu	a5,0(a5)
    80006842:	873e                	mv	a4,a5
    80006844:	02f00793          	li	a5,47
    80006848:	00f70763          	beq	a4,a5,80006856 <skipelem+0x6c>
    8000684c:	fd843783          	ld	a5,-40(s0)
    80006850:	0007c783          	lbu	a5,0(a5)
    80006854:	fff1                	bnez	a5,80006830 <skipelem+0x46>
  len = path - s;
    80006856:	fd843703          	ld	a4,-40(s0)
    8000685a:	fe843783          	ld	a5,-24(s0)
    8000685e:	40f707b3          	sub	a5,a4,a5
    80006862:	fef42223          	sw	a5,-28(s0)
  if(len >= DIRSIZ)
    80006866:	fe442783          	lw	a5,-28(s0)
    8000686a:	0007871b          	sext.w	a4,a5
    8000686e:	47b5                	li	a5,13
    80006870:	00e7dc63          	bge	a5,a4,80006888 <skipelem+0x9e>
    memmove(name, s, DIRSIZ);
    80006874:	4639                	li	a2,14
    80006876:	fe843583          	ld	a1,-24(s0)
    8000687a:	fd043503          	ld	a0,-48(s0)
    8000687e:	ffffb097          	auipc	ra,0xffffb
    80006882:	ca4080e7          	jalr	-860(ra) # 80001522 <memmove>
    80006886:	a80d                	j	800068b8 <skipelem+0xce>
  else {
    memmove(name, s, len);
    80006888:	fe442783          	lw	a5,-28(s0)
    8000688c:	863e                	mv	a2,a5
    8000688e:	fe843583          	ld	a1,-24(s0)
    80006892:	fd043503          	ld	a0,-48(s0)
    80006896:	ffffb097          	auipc	ra,0xffffb
    8000689a:	c8c080e7          	jalr	-884(ra) # 80001522 <memmove>
    name[len] = 0;
    8000689e:	fe442783          	lw	a5,-28(s0)
    800068a2:	fd043703          	ld	a4,-48(s0)
    800068a6:	97ba                	add	a5,a5,a4
    800068a8:	00078023          	sb	zero,0(a5)
  }
  while(*path == '/')
    800068ac:	a031                	j	800068b8 <skipelem+0xce>
    path++;
    800068ae:	fd843783          	ld	a5,-40(s0)
    800068b2:	0785                	addi	a5,a5,1
    800068b4:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    800068b8:	fd843783          	ld	a5,-40(s0)
    800068bc:	0007c783          	lbu	a5,0(a5)
    800068c0:	873e                	mv	a4,a5
    800068c2:	02f00793          	li	a5,47
    800068c6:	fef704e3          	beq	a4,a5,800068ae <skipelem+0xc4>
  return path;
    800068ca:	fd843783          	ld	a5,-40(s0)
}
    800068ce:	853e                	mv	a0,a5
    800068d0:	70a2                	ld	ra,40(sp)
    800068d2:	7402                	ld	s0,32(sp)
    800068d4:	6145                	addi	sp,sp,48
    800068d6:	8082                	ret

00000000800068d8 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    800068d8:	7139                	addi	sp,sp,-64
    800068da:	fc06                	sd	ra,56(sp)
    800068dc:	f822                	sd	s0,48(sp)
    800068de:	0080                	addi	s0,sp,64
    800068e0:	fca43c23          	sd	a0,-40(s0)
    800068e4:	87ae                	mv	a5,a1
    800068e6:	fcc43423          	sd	a2,-56(s0)
    800068ea:	fcf42a23          	sw	a5,-44(s0)
  struct inode *ip, *next;

  if(*path == '/')
    800068ee:	fd843783          	ld	a5,-40(s0)
    800068f2:	0007c783          	lbu	a5,0(a5)
    800068f6:	873e                	mv	a4,a5
    800068f8:	02f00793          	li	a5,47
    800068fc:	00f71b63          	bne	a4,a5,80006912 <namex+0x3a>
    ip = iget(ROOTDEV, ROOTINO);
    80006900:	4585                	li	a1,1
    80006902:	4505                	li	a0,1
    80006904:	fffff097          	auipc	ra,0xfffff
    80006908:	292080e7          	jalr	658(ra) # 80005b96 <iget>
    8000690c:	fea43423          	sd	a0,-24(s0)
    80006910:	a84d                	j	800069c2 <namex+0xea>
  else
    ip = idup(myproc()->cwd);
    80006912:	ffffc097          	auipc	ra,0xffffc
    80006916:	106080e7          	jalr	262(ra) # 80002a18 <myproc>
    8000691a:	87aa                	mv	a5,a0
    8000691c:	1607b783          	ld	a5,352(a5)
    80006920:	853e                	mv	a0,a5
    80006922:	fffff097          	auipc	ra,0xfffff
    80006926:	390080e7          	jalr	912(ra) # 80005cb2 <idup>
    8000692a:	fea43423          	sd	a0,-24(s0)

  while((path = skipelem(path, name)) != 0){
    8000692e:	a851                	j	800069c2 <namex+0xea>
    ilock(ip);
    80006930:	fe843503          	ld	a0,-24(s0)
    80006934:	fffff097          	auipc	ra,0xfffff
    80006938:	3ca080e7          	jalr	970(ra) # 80005cfe <ilock>
    if(ip->type != T_DIR){
    8000693c:	fe843783          	ld	a5,-24(s0)
    80006940:	04479783          	lh	a5,68(a5)
    80006944:	0007871b          	sext.w	a4,a5
    80006948:	4785                	li	a5,1
    8000694a:	00f70a63          	beq	a4,a5,8000695e <namex+0x86>
      iunlockput(ip);
    8000694e:	fe843503          	ld	a0,-24(s0)
    80006952:	fffff097          	auipc	ra,0xfffff
    80006956:	60a080e7          	jalr	1546(ra) # 80005f5c <iunlockput>
      return 0;
    8000695a:	4781                	li	a5,0
    8000695c:	a871                	j	800069f8 <namex+0x120>
    }
    if(nameiparent && *path == '\0'){
    8000695e:	fd442783          	lw	a5,-44(s0)
    80006962:	2781                	sext.w	a5,a5
    80006964:	cf99                	beqz	a5,80006982 <namex+0xaa>
    80006966:	fd843783          	ld	a5,-40(s0)
    8000696a:	0007c783          	lbu	a5,0(a5)
    8000696e:	eb91                	bnez	a5,80006982 <namex+0xaa>
      // Stop one level early.
      iunlock(ip);
    80006970:	fe843503          	ld	a0,-24(s0)
    80006974:	fffff097          	auipc	ra,0xfffff
    80006978:	4be080e7          	jalr	1214(ra) # 80005e32 <iunlock>
      return ip;
    8000697c:	fe843783          	ld	a5,-24(s0)
    80006980:	a8a5                	j	800069f8 <namex+0x120>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
    80006982:	4601                	li	a2,0
    80006984:	fc843583          	ld	a1,-56(s0)
    80006988:	fe843503          	ld	a0,-24(s0)
    8000698c:	00000097          	auipc	ra,0x0
    80006990:	c74080e7          	jalr	-908(ra) # 80006600 <dirlookup>
    80006994:	fea43023          	sd	a0,-32(s0)
    80006998:	fe043783          	ld	a5,-32(s0)
    8000699c:	eb89                	bnez	a5,800069ae <namex+0xd6>
      iunlockput(ip);
    8000699e:	fe843503          	ld	a0,-24(s0)
    800069a2:	fffff097          	auipc	ra,0xfffff
    800069a6:	5ba080e7          	jalr	1466(ra) # 80005f5c <iunlockput>
      return 0;
    800069aa:	4781                	li	a5,0
    800069ac:	a0b1                	j	800069f8 <namex+0x120>
    }
    iunlockput(ip);
    800069ae:	fe843503          	ld	a0,-24(s0)
    800069b2:	fffff097          	auipc	ra,0xfffff
    800069b6:	5aa080e7          	jalr	1450(ra) # 80005f5c <iunlockput>
    ip = next;
    800069ba:	fe043783          	ld	a5,-32(s0)
    800069be:	fef43423          	sd	a5,-24(s0)
  while((path = skipelem(path, name)) != 0){
    800069c2:	fc843583          	ld	a1,-56(s0)
    800069c6:	fd843503          	ld	a0,-40(s0)
    800069ca:	00000097          	auipc	ra,0x0
    800069ce:	e20080e7          	jalr	-480(ra) # 800067ea <skipelem>
    800069d2:	fca43c23          	sd	a0,-40(s0)
    800069d6:	fd843783          	ld	a5,-40(s0)
    800069da:	fbb9                	bnez	a5,80006930 <namex+0x58>
  }
  if(nameiparent){
    800069dc:	fd442783          	lw	a5,-44(s0)
    800069e0:	2781                	sext.w	a5,a5
    800069e2:	cb89                	beqz	a5,800069f4 <namex+0x11c>
    iput(ip);
    800069e4:	fe843503          	ld	a0,-24(s0)
    800069e8:	fffff097          	auipc	ra,0xfffff
    800069ec:	4a4080e7          	jalr	1188(ra) # 80005e8c <iput>
    return 0;
    800069f0:	4781                	li	a5,0
    800069f2:	a019                	j	800069f8 <namex+0x120>
  }
  return ip;
    800069f4:	fe843783          	ld	a5,-24(s0)
}
    800069f8:	853e                	mv	a0,a5
    800069fa:	70e2                	ld	ra,56(sp)
    800069fc:	7442                	ld	s0,48(sp)
    800069fe:	6121                	addi	sp,sp,64
    80006a00:	8082                	ret

0000000080006a02 <namei>:

struct inode*
namei(char *path)
{
    80006a02:	7179                	addi	sp,sp,-48
    80006a04:	f406                	sd	ra,40(sp)
    80006a06:	f022                	sd	s0,32(sp)
    80006a08:	1800                	addi	s0,sp,48
    80006a0a:	fca43c23          	sd	a0,-40(s0)
  char name[DIRSIZ];
  return namex(path, 0, name);
    80006a0e:	fe040793          	addi	a5,s0,-32
    80006a12:	863e                	mv	a2,a5
    80006a14:	4581                	li	a1,0
    80006a16:	fd843503          	ld	a0,-40(s0)
    80006a1a:	00000097          	auipc	ra,0x0
    80006a1e:	ebe080e7          	jalr	-322(ra) # 800068d8 <namex>
    80006a22:	87aa                	mv	a5,a0
}
    80006a24:	853e                	mv	a0,a5
    80006a26:	70a2                	ld	ra,40(sp)
    80006a28:	7402                	ld	s0,32(sp)
    80006a2a:	6145                	addi	sp,sp,48
    80006a2c:	8082                	ret

0000000080006a2e <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80006a2e:	1101                	addi	sp,sp,-32
    80006a30:	ec06                	sd	ra,24(sp)
    80006a32:	e822                	sd	s0,16(sp)
    80006a34:	1000                	addi	s0,sp,32
    80006a36:	fea43423          	sd	a0,-24(s0)
    80006a3a:	feb43023          	sd	a1,-32(s0)
  return namex(path, 1, name);
    80006a3e:	fe043603          	ld	a2,-32(s0)
    80006a42:	4585                	li	a1,1
    80006a44:	fe843503          	ld	a0,-24(s0)
    80006a48:	00000097          	auipc	ra,0x0
    80006a4c:	e90080e7          	jalr	-368(ra) # 800068d8 <namex>
    80006a50:	87aa                	mv	a5,a0
}
    80006a52:	853e                	mv	a0,a5
    80006a54:	60e2                	ld	ra,24(sp)
    80006a56:	6442                	ld	s0,16(sp)
    80006a58:	6105                	addi	sp,sp,32
    80006a5a:	8082                	ret

0000000080006a5c <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev, struct superblock *sb)
{
    80006a5c:	1101                	addi	sp,sp,-32
    80006a5e:	ec06                	sd	ra,24(sp)
    80006a60:	e822                	sd	s0,16(sp)
    80006a62:	1000                	addi	s0,sp,32
    80006a64:	87aa                	mv	a5,a0
    80006a66:	feb43023          	sd	a1,-32(s0)
    80006a6a:	fef42623          	sw	a5,-20(s0)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  initlock(&log.lock, "log");
    80006a6e:	00005597          	auipc	a1,0x5
    80006a72:	c6a58593          	addi	a1,a1,-918 # 8000b6d8 <etext+0x6d8>
    80006a76:	0049e517          	auipc	a0,0x49e
    80006a7a:	1f250513          	addi	a0,a0,498 # 804a4c68 <log>
    80006a7e:	ffffa097          	auipc	ra,0xffffa
    80006a82:	7bc080e7          	jalr	1980(ra) # 8000123a <initlock>
  log.start = sb->logstart;
    80006a86:	fe043783          	ld	a5,-32(s0)
    80006a8a:	4bdc                	lw	a5,20(a5)
    80006a8c:	0007871b          	sext.w	a4,a5
    80006a90:	0049e797          	auipc	a5,0x49e
    80006a94:	1d878793          	addi	a5,a5,472 # 804a4c68 <log>
    80006a98:	cf98                	sw	a4,24(a5)
  log.size = sb->nlog;
    80006a9a:	fe043783          	ld	a5,-32(s0)
    80006a9e:	4b9c                	lw	a5,16(a5)
    80006aa0:	0007871b          	sext.w	a4,a5
    80006aa4:	0049e797          	auipc	a5,0x49e
    80006aa8:	1c478793          	addi	a5,a5,452 # 804a4c68 <log>
    80006aac:	cfd8                	sw	a4,28(a5)
  log.dev = dev;
    80006aae:	0049e797          	auipc	a5,0x49e
    80006ab2:	1ba78793          	addi	a5,a5,442 # 804a4c68 <log>
    80006ab6:	fec42703          	lw	a4,-20(s0)
    80006aba:	d798                	sw	a4,40(a5)
  recover_from_log();
    80006abc:	00000097          	auipc	ra,0x0
    80006ac0:	272080e7          	jalr	626(ra) # 80006d2e <recover_from_log>
}
    80006ac4:	0001                	nop
    80006ac6:	60e2                	ld	ra,24(sp)
    80006ac8:	6442                	ld	s0,16(sp)
    80006aca:	6105                	addi	sp,sp,32
    80006acc:	8082                	ret

0000000080006ace <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(int recovering)
{
    80006ace:	7139                	addi	sp,sp,-64
    80006ad0:	fc06                	sd	ra,56(sp)
    80006ad2:	f822                	sd	s0,48(sp)
    80006ad4:	0080                	addi	s0,sp,64
    80006ad6:	87aa                	mv	a5,a0
    80006ad8:	fcf42623          	sw	a5,-52(s0)
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    80006adc:	fe042623          	sw	zero,-20(s0)
    80006ae0:	a0f9                	j	80006bae <install_trans+0xe0>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80006ae2:	0049e797          	auipc	a5,0x49e
    80006ae6:	18678793          	addi	a5,a5,390 # 804a4c68 <log>
    80006aea:	579c                	lw	a5,40(a5)
    80006aec:	0007871b          	sext.w	a4,a5
    80006af0:	0049e797          	auipc	a5,0x49e
    80006af4:	17878793          	addi	a5,a5,376 # 804a4c68 <log>
    80006af8:	4f9c                	lw	a5,24(a5)
    80006afa:	fec42683          	lw	a3,-20(s0)
    80006afe:	9fb5                	addw	a5,a5,a3
    80006b00:	2781                	sext.w	a5,a5
    80006b02:	2785                	addiw	a5,a5,1
    80006b04:	2781                	sext.w	a5,a5
    80006b06:	2781                	sext.w	a5,a5
    80006b08:	85be                	mv	a1,a5
    80006b0a:	853a                	mv	a0,a4
    80006b0c:	fffff097          	auipc	ra,0xfffff
    80006b10:	822080e7          	jalr	-2014(ra) # 8000532e <bread>
    80006b14:	fea43023          	sd	a0,-32(s0)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80006b18:	0049e797          	auipc	a5,0x49e
    80006b1c:	15078793          	addi	a5,a5,336 # 804a4c68 <log>
    80006b20:	579c                	lw	a5,40(a5)
    80006b22:	0007869b          	sext.w	a3,a5
    80006b26:	0049e717          	auipc	a4,0x49e
    80006b2a:	14270713          	addi	a4,a4,322 # 804a4c68 <log>
    80006b2e:	fec42783          	lw	a5,-20(s0)
    80006b32:	07a1                	addi	a5,a5,8
    80006b34:	078a                	slli	a5,a5,0x2
    80006b36:	97ba                	add	a5,a5,a4
    80006b38:	4b9c                	lw	a5,16(a5)
    80006b3a:	2781                	sext.w	a5,a5
    80006b3c:	85be                	mv	a1,a5
    80006b3e:	8536                	mv	a0,a3
    80006b40:	ffffe097          	auipc	ra,0xffffe
    80006b44:	7ee080e7          	jalr	2030(ra) # 8000532e <bread>
    80006b48:	fca43c23          	sd	a0,-40(s0)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80006b4c:	fd843783          	ld	a5,-40(s0)
    80006b50:	05878713          	addi	a4,a5,88
    80006b54:	fe043783          	ld	a5,-32(s0)
    80006b58:	05878793          	addi	a5,a5,88
    80006b5c:	40000613          	li	a2,1024
    80006b60:	85be                	mv	a1,a5
    80006b62:	853a                	mv	a0,a4
    80006b64:	ffffb097          	auipc	ra,0xffffb
    80006b68:	9be080e7          	jalr	-1602(ra) # 80001522 <memmove>
    bwrite(dbuf);  // write dst to disk
    80006b6c:	fd843503          	ld	a0,-40(s0)
    80006b70:	fffff097          	auipc	ra,0xfffff
    80006b74:	818080e7          	jalr	-2024(ra) # 80005388 <bwrite>
    if(recovering == 0)
    80006b78:	fcc42783          	lw	a5,-52(s0)
    80006b7c:	2781                	sext.w	a5,a5
    80006b7e:	e799                	bnez	a5,80006b8c <install_trans+0xbe>
      bunpin(dbuf);
    80006b80:	fd843503          	ld	a0,-40(s0)
    80006b84:	fffff097          	auipc	ra,0xfffff
    80006b88:	982080e7          	jalr	-1662(ra) # 80005506 <bunpin>
    brelse(lbuf);
    80006b8c:	fe043503          	ld	a0,-32(s0)
    80006b90:	fffff097          	auipc	ra,0xfffff
    80006b94:	840080e7          	jalr	-1984(ra) # 800053d0 <brelse>
    brelse(dbuf);
    80006b98:	fd843503          	ld	a0,-40(s0)
    80006b9c:	fffff097          	auipc	ra,0xfffff
    80006ba0:	834080e7          	jalr	-1996(ra) # 800053d0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80006ba4:	fec42783          	lw	a5,-20(s0)
    80006ba8:	2785                	addiw	a5,a5,1
    80006baa:	fef42623          	sw	a5,-20(s0)
    80006bae:	0049e797          	auipc	a5,0x49e
    80006bb2:	0ba78793          	addi	a5,a5,186 # 804a4c68 <log>
    80006bb6:	57d8                	lw	a4,44(a5)
    80006bb8:	fec42783          	lw	a5,-20(s0)
    80006bbc:	2781                	sext.w	a5,a5
    80006bbe:	f2e7c2e3          	blt	a5,a4,80006ae2 <install_trans+0x14>
  }
}
    80006bc2:	0001                	nop
    80006bc4:	0001                	nop
    80006bc6:	70e2                	ld	ra,56(sp)
    80006bc8:	7442                	ld	s0,48(sp)
    80006bca:	6121                	addi	sp,sp,64
    80006bcc:	8082                	ret

0000000080006bce <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
    80006bce:	7179                	addi	sp,sp,-48
    80006bd0:	f406                	sd	ra,40(sp)
    80006bd2:	f022                	sd	s0,32(sp)
    80006bd4:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80006bd6:	0049e797          	auipc	a5,0x49e
    80006bda:	09278793          	addi	a5,a5,146 # 804a4c68 <log>
    80006bde:	579c                	lw	a5,40(a5)
    80006be0:	0007871b          	sext.w	a4,a5
    80006be4:	0049e797          	auipc	a5,0x49e
    80006be8:	08478793          	addi	a5,a5,132 # 804a4c68 <log>
    80006bec:	4f9c                	lw	a5,24(a5)
    80006bee:	2781                	sext.w	a5,a5
    80006bf0:	85be                	mv	a1,a5
    80006bf2:	853a                	mv	a0,a4
    80006bf4:	ffffe097          	auipc	ra,0xffffe
    80006bf8:	73a080e7          	jalr	1850(ra) # 8000532e <bread>
    80006bfc:	fea43023          	sd	a0,-32(s0)
  struct logheader *lh = (struct logheader *) (buf->data);
    80006c00:	fe043783          	ld	a5,-32(s0)
    80006c04:	05878793          	addi	a5,a5,88
    80006c08:	fcf43c23          	sd	a5,-40(s0)
  int i;
  log.lh.n = lh->n;
    80006c0c:	fd843783          	ld	a5,-40(s0)
    80006c10:	4398                	lw	a4,0(a5)
    80006c12:	0049e797          	auipc	a5,0x49e
    80006c16:	05678793          	addi	a5,a5,86 # 804a4c68 <log>
    80006c1a:	d7d8                	sw	a4,44(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006c1c:	fe042623          	sw	zero,-20(s0)
    80006c20:	a03d                	j	80006c4e <read_head+0x80>
    log.lh.block[i] = lh->block[i];
    80006c22:	fd843703          	ld	a4,-40(s0)
    80006c26:	fec42783          	lw	a5,-20(s0)
    80006c2a:	078a                	slli	a5,a5,0x2
    80006c2c:	97ba                	add	a5,a5,a4
    80006c2e:	43d8                	lw	a4,4(a5)
    80006c30:	0049e697          	auipc	a3,0x49e
    80006c34:	03868693          	addi	a3,a3,56 # 804a4c68 <log>
    80006c38:	fec42783          	lw	a5,-20(s0)
    80006c3c:	07a1                	addi	a5,a5,8
    80006c3e:	078a                	slli	a5,a5,0x2
    80006c40:	97b6                	add	a5,a5,a3
    80006c42:	cb98                	sw	a4,16(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006c44:	fec42783          	lw	a5,-20(s0)
    80006c48:	2785                	addiw	a5,a5,1
    80006c4a:	fef42623          	sw	a5,-20(s0)
    80006c4e:	0049e797          	auipc	a5,0x49e
    80006c52:	01a78793          	addi	a5,a5,26 # 804a4c68 <log>
    80006c56:	57d8                	lw	a4,44(a5)
    80006c58:	fec42783          	lw	a5,-20(s0)
    80006c5c:	2781                	sext.w	a5,a5
    80006c5e:	fce7c2e3          	blt	a5,a4,80006c22 <read_head+0x54>
  }
  brelse(buf);
    80006c62:	fe043503          	ld	a0,-32(s0)
    80006c66:	ffffe097          	auipc	ra,0xffffe
    80006c6a:	76a080e7          	jalr	1898(ra) # 800053d0 <brelse>
}
    80006c6e:	0001                	nop
    80006c70:	70a2                	ld	ra,40(sp)
    80006c72:	7402                	ld	s0,32(sp)
    80006c74:	6145                	addi	sp,sp,48
    80006c76:	8082                	ret

0000000080006c78 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80006c78:	7179                	addi	sp,sp,-48
    80006c7a:	f406                	sd	ra,40(sp)
    80006c7c:	f022                	sd	s0,32(sp)
    80006c7e:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80006c80:	0049e797          	auipc	a5,0x49e
    80006c84:	fe878793          	addi	a5,a5,-24 # 804a4c68 <log>
    80006c88:	579c                	lw	a5,40(a5)
    80006c8a:	0007871b          	sext.w	a4,a5
    80006c8e:	0049e797          	auipc	a5,0x49e
    80006c92:	fda78793          	addi	a5,a5,-38 # 804a4c68 <log>
    80006c96:	4f9c                	lw	a5,24(a5)
    80006c98:	2781                	sext.w	a5,a5
    80006c9a:	85be                	mv	a1,a5
    80006c9c:	853a                	mv	a0,a4
    80006c9e:	ffffe097          	auipc	ra,0xffffe
    80006ca2:	690080e7          	jalr	1680(ra) # 8000532e <bread>
    80006ca6:	fea43023          	sd	a0,-32(s0)
  struct logheader *hb = (struct logheader *) (buf->data);
    80006caa:	fe043783          	ld	a5,-32(s0)
    80006cae:	05878793          	addi	a5,a5,88
    80006cb2:	fcf43c23          	sd	a5,-40(s0)
  int i;
  hb->n = log.lh.n;
    80006cb6:	0049e797          	auipc	a5,0x49e
    80006cba:	fb278793          	addi	a5,a5,-78 # 804a4c68 <log>
    80006cbe:	57d8                	lw	a4,44(a5)
    80006cc0:	fd843783          	ld	a5,-40(s0)
    80006cc4:	c398                	sw	a4,0(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006cc6:	fe042623          	sw	zero,-20(s0)
    80006cca:	a03d                	j	80006cf8 <write_head+0x80>
    hb->block[i] = log.lh.block[i];
    80006ccc:	0049e717          	auipc	a4,0x49e
    80006cd0:	f9c70713          	addi	a4,a4,-100 # 804a4c68 <log>
    80006cd4:	fec42783          	lw	a5,-20(s0)
    80006cd8:	07a1                	addi	a5,a5,8
    80006cda:	078a                	slli	a5,a5,0x2
    80006cdc:	97ba                	add	a5,a5,a4
    80006cde:	4b98                	lw	a4,16(a5)
    80006ce0:	fd843683          	ld	a3,-40(s0)
    80006ce4:	fec42783          	lw	a5,-20(s0)
    80006ce8:	078a                	slli	a5,a5,0x2
    80006cea:	97b6                	add	a5,a5,a3
    80006cec:	c3d8                	sw	a4,4(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006cee:	fec42783          	lw	a5,-20(s0)
    80006cf2:	2785                	addiw	a5,a5,1
    80006cf4:	fef42623          	sw	a5,-20(s0)
    80006cf8:	0049e797          	auipc	a5,0x49e
    80006cfc:	f7078793          	addi	a5,a5,-144 # 804a4c68 <log>
    80006d00:	57d8                	lw	a4,44(a5)
    80006d02:	fec42783          	lw	a5,-20(s0)
    80006d06:	2781                	sext.w	a5,a5
    80006d08:	fce7c2e3          	blt	a5,a4,80006ccc <write_head+0x54>
  }
  bwrite(buf);
    80006d0c:	fe043503          	ld	a0,-32(s0)
    80006d10:	ffffe097          	auipc	ra,0xffffe
    80006d14:	678080e7          	jalr	1656(ra) # 80005388 <bwrite>
  brelse(buf);
    80006d18:	fe043503          	ld	a0,-32(s0)
    80006d1c:	ffffe097          	auipc	ra,0xffffe
    80006d20:	6b4080e7          	jalr	1716(ra) # 800053d0 <brelse>
}
    80006d24:	0001                	nop
    80006d26:	70a2                	ld	ra,40(sp)
    80006d28:	7402                	ld	s0,32(sp)
    80006d2a:	6145                	addi	sp,sp,48
    80006d2c:	8082                	ret

0000000080006d2e <recover_from_log>:

static void
recover_from_log(void)
{
    80006d2e:	1141                	addi	sp,sp,-16
    80006d30:	e406                	sd	ra,8(sp)
    80006d32:	e022                	sd	s0,0(sp)
    80006d34:	0800                	addi	s0,sp,16
  read_head();
    80006d36:	00000097          	auipc	ra,0x0
    80006d3a:	e98080e7          	jalr	-360(ra) # 80006bce <read_head>
  install_trans(1); // if committed, copy from log to disk
    80006d3e:	4505                	li	a0,1
    80006d40:	00000097          	auipc	ra,0x0
    80006d44:	d8e080e7          	jalr	-626(ra) # 80006ace <install_trans>
  log.lh.n = 0;
    80006d48:	0049e797          	auipc	a5,0x49e
    80006d4c:	f2078793          	addi	a5,a5,-224 # 804a4c68 <log>
    80006d50:	0207a623          	sw	zero,44(a5)
  write_head(); // clear the log
    80006d54:	00000097          	auipc	ra,0x0
    80006d58:	f24080e7          	jalr	-220(ra) # 80006c78 <write_head>
}
    80006d5c:	0001                	nop
    80006d5e:	60a2                	ld	ra,8(sp)
    80006d60:	6402                	ld	s0,0(sp)
    80006d62:	0141                	addi	sp,sp,16
    80006d64:	8082                	ret

0000000080006d66 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
    80006d66:	1141                	addi	sp,sp,-16
    80006d68:	e406                	sd	ra,8(sp)
    80006d6a:	e022                	sd	s0,0(sp)
    80006d6c:	0800                	addi	s0,sp,16
  acquire(&log.lock);
    80006d6e:	0049e517          	auipc	a0,0x49e
    80006d72:	efa50513          	addi	a0,a0,-262 # 804a4c68 <log>
    80006d76:	ffffa097          	auipc	ra,0xffffa
    80006d7a:	4f4080e7          	jalr	1268(ra) # 8000126a <acquire>
  while(1){
    if(log.committing){
    80006d7e:	0049e797          	auipc	a5,0x49e
    80006d82:	eea78793          	addi	a5,a5,-278 # 804a4c68 <log>
    80006d86:	53dc                	lw	a5,36(a5)
    80006d88:	cf91                	beqz	a5,80006da4 <begin_op+0x3e>
      sleep(&log, &log.lock);
    80006d8a:	0049e597          	auipc	a1,0x49e
    80006d8e:	ede58593          	addi	a1,a1,-290 # 804a4c68 <log>
    80006d92:	0049e517          	auipc	a0,0x49e
    80006d96:	ed650513          	addi	a0,a0,-298 # 804a4c68 <log>
    80006d9a:	ffffd097          	auipc	ra,0xffffd
    80006d9e:	b68080e7          	jalr	-1176(ra) # 80003902 <sleep>
    80006da2:	bff1                	j	80006d7e <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80006da4:	0049e797          	auipc	a5,0x49e
    80006da8:	ec478793          	addi	a5,a5,-316 # 804a4c68 <log>
    80006dac:	57d8                	lw	a4,44(a5)
    80006dae:	0049e797          	auipc	a5,0x49e
    80006db2:	eba78793          	addi	a5,a5,-326 # 804a4c68 <log>
    80006db6:	539c                	lw	a5,32(a5)
    80006db8:	2785                	addiw	a5,a5,1
    80006dba:	2781                	sext.w	a5,a5
    80006dbc:	86be                	mv	a3,a5
    80006dbe:	87b6                	mv	a5,a3
    80006dc0:	0027979b          	slliw	a5,a5,0x2
    80006dc4:	9fb5                	addw	a5,a5,a3
    80006dc6:	0017979b          	slliw	a5,a5,0x1
    80006dca:	2781                	sext.w	a5,a5
    80006dcc:	9fb9                	addw	a5,a5,a4
    80006dce:	2781                	sext.w	a5,a5
    80006dd0:	873e                	mv	a4,a5
    80006dd2:	47f9                	li	a5,30
    80006dd4:	00e7df63          	bge	a5,a4,80006df2 <begin_op+0x8c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80006dd8:	0049e597          	auipc	a1,0x49e
    80006ddc:	e9058593          	addi	a1,a1,-368 # 804a4c68 <log>
    80006de0:	0049e517          	auipc	a0,0x49e
    80006de4:	e8850513          	addi	a0,a0,-376 # 804a4c68 <log>
    80006de8:	ffffd097          	auipc	ra,0xffffd
    80006dec:	b1a080e7          	jalr	-1254(ra) # 80003902 <sleep>
    80006df0:	b779                	j	80006d7e <begin_op+0x18>
    } else {
      log.outstanding += 1;
    80006df2:	0049e797          	auipc	a5,0x49e
    80006df6:	e7678793          	addi	a5,a5,-394 # 804a4c68 <log>
    80006dfa:	539c                	lw	a5,32(a5)
    80006dfc:	2785                	addiw	a5,a5,1
    80006dfe:	0007871b          	sext.w	a4,a5
    80006e02:	0049e797          	auipc	a5,0x49e
    80006e06:	e6678793          	addi	a5,a5,-410 # 804a4c68 <log>
    80006e0a:	d398                	sw	a4,32(a5)
      release(&log.lock);
    80006e0c:	0049e517          	auipc	a0,0x49e
    80006e10:	e5c50513          	addi	a0,a0,-420 # 804a4c68 <log>
    80006e14:	ffffa097          	auipc	ra,0xffffa
    80006e18:	4ba080e7          	jalr	1210(ra) # 800012ce <release>
      break;
    80006e1c:	0001                	nop
    }
  }
}
    80006e1e:	0001                	nop
    80006e20:	60a2                	ld	ra,8(sp)
    80006e22:	6402                	ld	s0,0(sp)
    80006e24:	0141                	addi	sp,sp,16
    80006e26:	8082                	ret

0000000080006e28 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80006e28:	1101                	addi	sp,sp,-32
    80006e2a:	ec06                	sd	ra,24(sp)
    80006e2c:	e822                	sd	s0,16(sp)
    80006e2e:	1000                	addi	s0,sp,32
  int do_commit = 0;
    80006e30:	fe042623          	sw	zero,-20(s0)

  acquire(&log.lock);
    80006e34:	0049e517          	auipc	a0,0x49e
    80006e38:	e3450513          	addi	a0,a0,-460 # 804a4c68 <log>
    80006e3c:	ffffa097          	auipc	ra,0xffffa
    80006e40:	42e080e7          	jalr	1070(ra) # 8000126a <acquire>
  log.outstanding -= 1;
    80006e44:	0049e797          	auipc	a5,0x49e
    80006e48:	e2478793          	addi	a5,a5,-476 # 804a4c68 <log>
    80006e4c:	539c                	lw	a5,32(a5)
    80006e4e:	37fd                	addiw	a5,a5,-1
    80006e50:	0007871b          	sext.w	a4,a5
    80006e54:	0049e797          	auipc	a5,0x49e
    80006e58:	e1478793          	addi	a5,a5,-492 # 804a4c68 <log>
    80006e5c:	d398                	sw	a4,32(a5)
  if(log.committing)
    80006e5e:	0049e797          	auipc	a5,0x49e
    80006e62:	e0a78793          	addi	a5,a5,-502 # 804a4c68 <log>
    80006e66:	53dc                	lw	a5,36(a5)
    80006e68:	cb89                	beqz	a5,80006e7a <end_op+0x52>
    panic("log.committing");
    80006e6a:	00005517          	auipc	a0,0x5
    80006e6e:	87650513          	addi	a0,a0,-1930 # 8000b6e0 <etext+0x6e0>
    80006e72:	ffffa097          	auipc	ra,0xffffa
    80006e76:	e08080e7          	jalr	-504(ra) # 80000c7a <panic>
  if(log.outstanding == 0){
    80006e7a:	0049e797          	auipc	a5,0x49e
    80006e7e:	dee78793          	addi	a5,a5,-530 # 804a4c68 <log>
    80006e82:	539c                	lw	a5,32(a5)
    80006e84:	eb99                	bnez	a5,80006e9a <end_op+0x72>
    do_commit = 1;
    80006e86:	4785                	li	a5,1
    80006e88:	fef42623          	sw	a5,-20(s0)
    log.committing = 1;
    80006e8c:	0049e797          	auipc	a5,0x49e
    80006e90:	ddc78793          	addi	a5,a5,-548 # 804a4c68 <log>
    80006e94:	4705                	li	a4,1
    80006e96:	d3d8                	sw	a4,36(a5)
    80006e98:	a809                	j	80006eaa <end_op+0x82>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
    80006e9a:	0049e517          	auipc	a0,0x49e
    80006e9e:	dce50513          	addi	a0,a0,-562 # 804a4c68 <log>
    80006ea2:	ffffd097          	auipc	ra,0xffffd
    80006ea6:	adc080e7          	jalr	-1316(ra) # 8000397e <wakeup>
  }
  release(&log.lock);
    80006eaa:	0049e517          	auipc	a0,0x49e
    80006eae:	dbe50513          	addi	a0,a0,-578 # 804a4c68 <log>
    80006eb2:	ffffa097          	auipc	ra,0xffffa
    80006eb6:	41c080e7          	jalr	1052(ra) # 800012ce <release>

  if(do_commit){
    80006eba:	fec42783          	lw	a5,-20(s0)
    80006ebe:	2781                	sext.w	a5,a5
    80006ec0:	c3b9                	beqz	a5,80006f06 <end_op+0xde>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    80006ec2:	00000097          	auipc	ra,0x0
    80006ec6:	134080e7          	jalr	308(ra) # 80006ff6 <commit>
    acquire(&log.lock);
    80006eca:	0049e517          	auipc	a0,0x49e
    80006ece:	d9e50513          	addi	a0,a0,-610 # 804a4c68 <log>
    80006ed2:	ffffa097          	auipc	ra,0xffffa
    80006ed6:	398080e7          	jalr	920(ra) # 8000126a <acquire>
    log.committing = 0;
    80006eda:	0049e797          	auipc	a5,0x49e
    80006ede:	d8e78793          	addi	a5,a5,-626 # 804a4c68 <log>
    80006ee2:	0207a223          	sw	zero,36(a5)
    wakeup(&log);
    80006ee6:	0049e517          	auipc	a0,0x49e
    80006eea:	d8250513          	addi	a0,a0,-638 # 804a4c68 <log>
    80006eee:	ffffd097          	auipc	ra,0xffffd
    80006ef2:	a90080e7          	jalr	-1392(ra) # 8000397e <wakeup>
    release(&log.lock);
    80006ef6:	0049e517          	auipc	a0,0x49e
    80006efa:	d7250513          	addi	a0,a0,-654 # 804a4c68 <log>
    80006efe:	ffffa097          	auipc	ra,0xffffa
    80006f02:	3d0080e7          	jalr	976(ra) # 800012ce <release>
  }
}
    80006f06:	0001                	nop
    80006f08:	60e2                	ld	ra,24(sp)
    80006f0a:	6442                	ld	s0,16(sp)
    80006f0c:	6105                	addi	sp,sp,32
    80006f0e:	8082                	ret

0000000080006f10 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
    80006f10:	7179                	addi	sp,sp,-48
    80006f12:	f406                	sd	ra,40(sp)
    80006f14:	f022                	sd	s0,32(sp)
    80006f16:	1800                	addi	s0,sp,48
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    80006f18:	fe042623          	sw	zero,-20(s0)
    80006f1c:	a86d                	j	80006fd6 <write_log+0xc6>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80006f1e:	0049e797          	auipc	a5,0x49e
    80006f22:	d4a78793          	addi	a5,a5,-694 # 804a4c68 <log>
    80006f26:	579c                	lw	a5,40(a5)
    80006f28:	0007871b          	sext.w	a4,a5
    80006f2c:	0049e797          	auipc	a5,0x49e
    80006f30:	d3c78793          	addi	a5,a5,-708 # 804a4c68 <log>
    80006f34:	4f9c                	lw	a5,24(a5)
    80006f36:	fec42683          	lw	a3,-20(s0)
    80006f3a:	9fb5                	addw	a5,a5,a3
    80006f3c:	2781                	sext.w	a5,a5
    80006f3e:	2785                	addiw	a5,a5,1
    80006f40:	2781                	sext.w	a5,a5
    80006f42:	2781                	sext.w	a5,a5
    80006f44:	85be                	mv	a1,a5
    80006f46:	853a                	mv	a0,a4
    80006f48:	ffffe097          	auipc	ra,0xffffe
    80006f4c:	3e6080e7          	jalr	998(ra) # 8000532e <bread>
    80006f50:	fea43023          	sd	a0,-32(s0)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80006f54:	0049e797          	auipc	a5,0x49e
    80006f58:	d1478793          	addi	a5,a5,-748 # 804a4c68 <log>
    80006f5c:	579c                	lw	a5,40(a5)
    80006f5e:	0007869b          	sext.w	a3,a5
    80006f62:	0049e717          	auipc	a4,0x49e
    80006f66:	d0670713          	addi	a4,a4,-762 # 804a4c68 <log>
    80006f6a:	fec42783          	lw	a5,-20(s0)
    80006f6e:	07a1                	addi	a5,a5,8
    80006f70:	078a                	slli	a5,a5,0x2
    80006f72:	97ba                	add	a5,a5,a4
    80006f74:	4b9c                	lw	a5,16(a5)
    80006f76:	2781                	sext.w	a5,a5
    80006f78:	85be                	mv	a1,a5
    80006f7a:	8536                	mv	a0,a3
    80006f7c:	ffffe097          	auipc	ra,0xffffe
    80006f80:	3b2080e7          	jalr	946(ra) # 8000532e <bread>
    80006f84:	fca43c23          	sd	a0,-40(s0)
    memmove(to->data, from->data, BSIZE);
    80006f88:	fe043783          	ld	a5,-32(s0)
    80006f8c:	05878713          	addi	a4,a5,88
    80006f90:	fd843783          	ld	a5,-40(s0)
    80006f94:	05878793          	addi	a5,a5,88
    80006f98:	40000613          	li	a2,1024
    80006f9c:	85be                	mv	a1,a5
    80006f9e:	853a                	mv	a0,a4
    80006fa0:	ffffa097          	auipc	ra,0xffffa
    80006fa4:	582080e7          	jalr	1410(ra) # 80001522 <memmove>
    bwrite(to);  // write the log
    80006fa8:	fe043503          	ld	a0,-32(s0)
    80006fac:	ffffe097          	auipc	ra,0xffffe
    80006fb0:	3dc080e7          	jalr	988(ra) # 80005388 <bwrite>
    brelse(from);
    80006fb4:	fd843503          	ld	a0,-40(s0)
    80006fb8:	ffffe097          	auipc	ra,0xffffe
    80006fbc:	418080e7          	jalr	1048(ra) # 800053d0 <brelse>
    brelse(to);
    80006fc0:	fe043503          	ld	a0,-32(s0)
    80006fc4:	ffffe097          	auipc	ra,0xffffe
    80006fc8:	40c080e7          	jalr	1036(ra) # 800053d0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80006fcc:	fec42783          	lw	a5,-20(s0)
    80006fd0:	2785                	addiw	a5,a5,1
    80006fd2:	fef42623          	sw	a5,-20(s0)
    80006fd6:	0049e797          	auipc	a5,0x49e
    80006fda:	c9278793          	addi	a5,a5,-878 # 804a4c68 <log>
    80006fde:	57d8                	lw	a4,44(a5)
    80006fe0:	fec42783          	lw	a5,-20(s0)
    80006fe4:	2781                	sext.w	a5,a5
    80006fe6:	f2e7cce3          	blt	a5,a4,80006f1e <write_log+0xe>
  }
}
    80006fea:	0001                	nop
    80006fec:	0001                	nop
    80006fee:	70a2                	ld	ra,40(sp)
    80006ff0:	7402                	ld	s0,32(sp)
    80006ff2:	6145                	addi	sp,sp,48
    80006ff4:	8082                	ret

0000000080006ff6 <commit>:

static void
commit()
{
    80006ff6:	1141                	addi	sp,sp,-16
    80006ff8:	e406                	sd	ra,8(sp)
    80006ffa:	e022                	sd	s0,0(sp)
    80006ffc:	0800                	addi	s0,sp,16
  if (log.lh.n > 0) {
    80006ffe:	0049e797          	auipc	a5,0x49e
    80007002:	c6a78793          	addi	a5,a5,-918 # 804a4c68 <log>
    80007006:	57dc                	lw	a5,44(a5)
    80007008:	02f05963          	blez	a5,8000703a <commit+0x44>
    write_log();     // Write modified blocks from cache to log
    8000700c:	00000097          	auipc	ra,0x0
    80007010:	f04080e7          	jalr	-252(ra) # 80006f10 <write_log>
    write_head();    // Write header to disk -- the real commit
    80007014:	00000097          	auipc	ra,0x0
    80007018:	c64080e7          	jalr	-924(ra) # 80006c78 <write_head>
    install_trans(0); // Now install writes to home locations
    8000701c:	4501                	li	a0,0
    8000701e:	00000097          	auipc	ra,0x0
    80007022:	ab0080e7          	jalr	-1360(ra) # 80006ace <install_trans>
    log.lh.n = 0;
    80007026:	0049e797          	auipc	a5,0x49e
    8000702a:	c4278793          	addi	a5,a5,-958 # 804a4c68 <log>
    8000702e:	0207a623          	sw	zero,44(a5)
    write_head();    // Erase the transaction from the log
    80007032:	00000097          	auipc	ra,0x0
    80007036:	c46080e7          	jalr	-954(ra) # 80006c78 <write_head>
  }
}
    8000703a:	0001                	nop
    8000703c:	60a2                	ld	ra,8(sp)
    8000703e:	6402                	ld	s0,0(sp)
    80007040:	0141                	addi	sp,sp,16
    80007042:	8082                	ret

0000000080007044 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80007044:	7179                	addi	sp,sp,-48
    80007046:	f406                	sd	ra,40(sp)
    80007048:	f022                	sd	s0,32(sp)
    8000704a:	1800                	addi	s0,sp,48
    8000704c:	fca43c23          	sd	a0,-40(s0)
  int i;

  acquire(&log.lock);
    80007050:	0049e517          	auipc	a0,0x49e
    80007054:	c1850513          	addi	a0,a0,-1000 # 804a4c68 <log>
    80007058:	ffffa097          	auipc	ra,0xffffa
    8000705c:	212080e7          	jalr	530(ra) # 8000126a <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80007060:	0049e797          	auipc	a5,0x49e
    80007064:	c0878793          	addi	a5,a5,-1016 # 804a4c68 <log>
    80007068:	57dc                	lw	a5,44(a5)
    8000706a:	873e                	mv	a4,a5
    8000706c:	47f5                	li	a5,29
    8000706e:	02e7c063          	blt	a5,a4,8000708e <log_write+0x4a>
    80007072:	0049e797          	auipc	a5,0x49e
    80007076:	bf678793          	addi	a5,a5,-1034 # 804a4c68 <log>
    8000707a:	57d8                	lw	a4,44(a5)
    8000707c:	0049e797          	auipc	a5,0x49e
    80007080:	bec78793          	addi	a5,a5,-1044 # 804a4c68 <log>
    80007084:	4fdc                	lw	a5,28(a5)
    80007086:	37fd                	addiw	a5,a5,-1
    80007088:	2781                	sext.w	a5,a5
    8000708a:	00f74a63          	blt	a4,a5,8000709e <log_write+0x5a>
    panic("too big a transaction");
    8000708e:	00004517          	auipc	a0,0x4
    80007092:	66250513          	addi	a0,a0,1634 # 8000b6f0 <etext+0x6f0>
    80007096:	ffffa097          	auipc	ra,0xffffa
    8000709a:	be4080e7          	jalr	-1052(ra) # 80000c7a <panic>
  if (log.outstanding < 1)
    8000709e:	0049e797          	auipc	a5,0x49e
    800070a2:	bca78793          	addi	a5,a5,-1078 # 804a4c68 <log>
    800070a6:	539c                	lw	a5,32(a5)
    800070a8:	00f04a63          	bgtz	a5,800070bc <log_write+0x78>
    panic("log_write outside of trans");
    800070ac:	00004517          	auipc	a0,0x4
    800070b0:	65c50513          	addi	a0,a0,1628 # 8000b708 <etext+0x708>
    800070b4:	ffffa097          	auipc	ra,0xffffa
    800070b8:	bc6080e7          	jalr	-1082(ra) # 80000c7a <panic>

  for (i = 0; i < log.lh.n; i++) {
    800070bc:	fe042623          	sw	zero,-20(s0)
    800070c0:	a03d                	j	800070ee <log_write+0xaa>
    if (log.lh.block[i] == b->blockno)   // log absorption
    800070c2:	0049e717          	auipc	a4,0x49e
    800070c6:	ba670713          	addi	a4,a4,-1114 # 804a4c68 <log>
    800070ca:	fec42783          	lw	a5,-20(s0)
    800070ce:	07a1                	addi	a5,a5,8
    800070d0:	078a                	slli	a5,a5,0x2
    800070d2:	97ba                	add	a5,a5,a4
    800070d4:	4b9c                	lw	a5,16(a5)
    800070d6:	0007871b          	sext.w	a4,a5
    800070da:	fd843783          	ld	a5,-40(s0)
    800070de:	47dc                	lw	a5,12(a5)
    800070e0:	02f70263          	beq	a4,a5,80007104 <log_write+0xc0>
  for (i = 0; i < log.lh.n; i++) {
    800070e4:	fec42783          	lw	a5,-20(s0)
    800070e8:	2785                	addiw	a5,a5,1
    800070ea:	fef42623          	sw	a5,-20(s0)
    800070ee:	0049e797          	auipc	a5,0x49e
    800070f2:	b7a78793          	addi	a5,a5,-1158 # 804a4c68 <log>
    800070f6:	57d8                	lw	a4,44(a5)
    800070f8:	fec42783          	lw	a5,-20(s0)
    800070fc:	2781                	sext.w	a5,a5
    800070fe:	fce7c2e3          	blt	a5,a4,800070c2 <log_write+0x7e>
    80007102:	a011                	j	80007106 <log_write+0xc2>
      break;
    80007104:	0001                	nop
  }
  log.lh.block[i] = b->blockno;
    80007106:	fd843783          	ld	a5,-40(s0)
    8000710a:	47dc                	lw	a5,12(a5)
    8000710c:	0007871b          	sext.w	a4,a5
    80007110:	0049e697          	auipc	a3,0x49e
    80007114:	b5868693          	addi	a3,a3,-1192 # 804a4c68 <log>
    80007118:	fec42783          	lw	a5,-20(s0)
    8000711c:	07a1                	addi	a5,a5,8
    8000711e:	078a                	slli	a5,a5,0x2
    80007120:	97b6                	add	a5,a5,a3
    80007122:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    80007124:	0049e797          	auipc	a5,0x49e
    80007128:	b4478793          	addi	a5,a5,-1212 # 804a4c68 <log>
    8000712c:	57d8                	lw	a4,44(a5)
    8000712e:	fec42783          	lw	a5,-20(s0)
    80007132:	2781                	sext.w	a5,a5
    80007134:	02e79563          	bne	a5,a4,8000715e <log_write+0x11a>
    bpin(b);
    80007138:	fd843503          	ld	a0,-40(s0)
    8000713c:	ffffe097          	auipc	ra,0xffffe
    80007140:	382080e7          	jalr	898(ra) # 800054be <bpin>
    log.lh.n++;
    80007144:	0049e797          	auipc	a5,0x49e
    80007148:	b2478793          	addi	a5,a5,-1244 # 804a4c68 <log>
    8000714c:	57dc                	lw	a5,44(a5)
    8000714e:	2785                	addiw	a5,a5,1
    80007150:	0007871b          	sext.w	a4,a5
    80007154:	0049e797          	auipc	a5,0x49e
    80007158:	b1478793          	addi	a5,a5,-1260 # 804a4c68 <log>
    8000715c:	d7d8                	sw	a4,44(a5)
  }
  release(&log.lock);
    8000715e:	0049e517          	auipc	a0,0x49e
    80007162:	b0a50513          	addi	a0,a0,-1270 # 804a4c68 <log>
    80007166:	ffffa097          	auipc	ra,0xffffa
    8000716a:	168080e7          	jalr	360(ra) # 800012ce <release>
}
    8000716e:	0001                	nop
    80007170:	70a2                	ld	ra,40(sp)
    80007172:	7402                	ld	s0,32(sp)
    80007174:	6145                	addi	sp,sp,48
    80007176:	8082                	ret

0000000080007178 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80007178:	1101                	addi	sp,sp,-32
    8000717a:	ec06                	sd	ra,24(sp)
    8000717c:	e822                	sd	s0,16(sp)
    8000717e:	1000                	addi	s0,sp,32
    80007180:	fea43423          	sd	a0,-24(s0)
    80007184:	feb43023          	sd	a1,-32(s0)
  initlock(&lk->lk, "sleep lock");
    80007188:	fe843783          	ld	a5,-24(s0)
    8000718c:	07a1                	addi	a5,a5,8
    8000718e:	00004597          	auipc	a1,0x4
    80007192:	59a58593          	addi	a1,a1,1434 # 8000b728 <etext+0x728>
    80007196:	853e                	mv	a0,a5
    80007198:	ffffa097          	auipc	ra,0xffffa
    8000719c:	0a2080e7          	jalr	162(ra) # 8000123a <initlock>
  lk->name = name;
    800071a0:	fe843783          	ld	a5,-24(s0)
    800071a4:	fe043703          	ld	a4,-32(s0)
    800071a8:	f398                	sd	a4,32(a5)
  lk->locked = 0;
    800071aa:	fe843783          	ld	a5,-24(s0)
    800071ae:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    800071b2:	fe843783          	ld	a5,-24(s0)
    800071b6:	0207a423          	sw	zero,40(a5)
}
    800071ba:	0001                	nop
    800071bc:	60e2                	ld	ra,24(sp)
    800071be:	6442                	ld	s0,16(sp)
    800071c0:	6105                	addi	sp,sp,32
    800071c2:	8082                	ret

00000000800071c4 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800071c4:	1101                	addi	sp,sp,-32
    800071c6:	ec06                	sd	ra,24(sp)
    800071c8:	e822                	sd	s0,16(sp)
    800071ca:	1000                	addi	s0,sp,32
    800071cc:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    800071d0:	fe843783          	ld	a5,-24(s0)
    800071d4:	07a1                	addi	a5,a5,8
    800071d6:	853e                	mv	a0,a5
    800071d8:	ffffa097          	auipc	ra,0xffffa
    800071dc:	092080e7          	jalr	146(ra) # 8000126a <acquire>
  while (lk->locked) {
    800071e0:	a819                	j	800071f6 <acquiresleep+0x32>
    sleep(lk, &lk->lk);
    800071e2:	fe843783          	ld	a5,-24(s0)
    800071e6:	07a1                	addi	a5,a5,8
    800071e8:	85be                	mv	a1,a5
    800071ea:	fe843503          	ld	a0,-24(s0)
    800071ee:	ffffc097          	auipc	ra,0xffffc
    800071f2:	714080e7          	jalr	1812(ra) # 80003902 <sleep>
  while (lk->locked) {
    800071f6:	fe843783          	ld	a5,-24(s0)
    800071fa:	439c                	lw	a5,0(a5)
    800071fc:	f3fd                	bnez	a5,800071e2 <acquiresleep+0x1e>
  }
  lk->locked = 1;
    800071fe:	fe843783          	ld	a5,-24(s0)
    80007202:	4705                	li	a4,1
    80007204:	c398                	sw	a4,0(a5)
  lk->pid = myproc()->pid;
    80007206:	ffffc097          	auipc	ra,0xffffc
    8000720a:	812080e7          	jalr	-2030(ra) # 80002a18 <myproc>
    8000720e:	87aa                	mv	a5,a0
    80007210:	5b98                	lw	a4,48(a5)
    80007212:	fe843783          	ld	a5,-24(s0)
    80007216:	d798                	sw	a4,40(a5)
  release(&lk->lk);
    80007218:	fe843783          	ld	a5,-24(s0)
    8000721c:	07a1                	addi	a5,a5,8
    8000721e:	853e                	mv	a0,a5
    80007220:	ffffa097          	auipc	ra,0xffffa
    80007224:	0ae080e7          	jalr	174(ra) # 800012ce <release>
}
    80007228:	0001                	nop
    8000722a:	60e2                	ld	ra,24(sp)
    8000722c:	6442                	ld	s0,16(sp)
    8000722e:	6105                	addi	sp,sp,32
    80007230:	8082                	ret

0000000080007232 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80007232:	1101                	addi	sp,sp,-32
    80007234:	ec06                	sd	ra,24(sp)
    80007236:	e822                	sd	s0,16(sp)
    80007238:	1000                	addi	s0,sp,32
    8000723a:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    8000723e:	fe843783          	ld	a5,-24(s0)
    80007242:	07a1                	addi	a5,a5,8
    80007244:	853e                	mv	a0,a5
    80007246:	ffffa097          	auipc	ra,0xffffa
    8000724a:	024080e7          	jalr	36(ra) # 8000126a <acquire>
  lk->locked = 0;
    8000724e:	fe843783          	ld	a5,-24(s0)
    80007252:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    80007256:	fe843783          	ld	a5,-24(s0)
    8000725a:	0207a423          	sw	zero,40(a5)
  wakeup(lk);
    8000725e:	fe843503          	ld	a0,-24(s0)
    80007262:	ffffc097          	auipc	ra,0xffffc
    80007266:	71c080e7          	jalr	1820(ra) # 8000397e <wakeup>
  release(&lk->lk);
    8000726a:	fe843783          	ld	a5,-24(s0)
    8000726e:	07a1                	addi	a5,a5,8
    80007270:	853e                	mv	a0,a5
    80007272:	ffffa097          	auipc	ra,0xffffa
    80007276:	05c080e7          	jalr	92(ra) # 800012ce <release>
}
    8000727a:	0001                	nop
    8000727c:	60e2                	ld	ra,24(sp)
    8000727e:	6442                	ld	s0,16(sp)
    80007280:	6105                	addi	sp,sp,32
    80007282:	8082                	ret

0000000080007284 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80007284:	7139                	addi	sp,sp,-64
    80007286:	fc06                	sd	ra,56(sp)
    80007288:	f822                	sd	s0,48(sp)
    8000728a:	f426                	sd	s1,40(sp)
    8000728c:	0080                	addi	s0,sp,64
    8000728e:	fca43423          	sd	a0,-56(s0)
  int r;
  
  acquire(&lk->lk);
    80007292:	fc843783          	ld	a5,-56(s0)
    80007296:	07a1                	addi	a5,a5,8
    80007298:	853e                	mv	a0,a5
    8000729a:	ffffa097          	auipc	ra,0xffffa
    8000729e:	fd0080e7          	jalr	-48(ra) # 8000126a <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800072a2:	fc843783          	ld	a5,-56(s0)
    800072a6:	439c                	lw	a5,0(a5)
    800072a8:	cf99                	beqz	a5,800072c6 <holdingsleep+0x42>
    800072aa:	fc843783          	ld	a5,-56(s0)
    800072ae:	5784                	lw	s1,40(a5)
    800072b0:	ffffb097          	auipc	ra,0xffffb
    800072b4:	768080e7          	jalr	1896(ra) # 80002a18 <myproc>
    800072b8:	87aa                	mv	a5,a0
    800072ba:	5b9c                	lw	a5,48(a5)
    800072bc:	8726                	mv	a4,s1
    800072be:	00f71463          	bne	a4,a5,800072c6 <holdingsleep+0x42>
    800072c2:	4785                	li	a5,1
    800072c4:	a011                	j	800072c8 <holdingsleep+0x44>
    800072c6:	4781                	li	a5,0
    800072c8:	fcf42e23          	sw	a5,-36(s0)
  release(&lk->lk);
    800072cc:	fc843783          	ld	a5,-56(s0)
    800072d0:	07a1                	addi	a5,a5,8
    800072d2:	853e                	mv	a0,a5
    800072d4:	ffffa097          	auipc	ra,0xffffa
    800072d8:	ffa080e7          	jalr	-6(ra) # 800012ce <release>
  return r;
    800072dc:	fdc42783          	lw	a5,-36(s0)
}
    800072e0:	853e                	mv	a0,a5
    800072e2:	70e2                	ld	ra,56(sp)
    800072e4:	7442                	ld	s0,48(sp)
    800072e6:	74a2                	ld	s1,40(sp)
    800072e8:	6121                	addi	sp,sp,64
    800072ea:	8082                	ret

00000000800072ec <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    800072ec:	1141                	addi	sp,sp,-16
    800072ee:	e406                	sd	ra,8(sp)
    800072f0:	e022                	sd	s0,0(sp)
    800072f2:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    800072f4:	00004597          	auipc	a1,0x4
    800072f8:	44458593          	addi	a1,a1,1092 # 8000b738 <etext+0x738>
    800072fc:	0049e517          	auipc	a0,0x49e
    80007300:	ab450513          	addi	a0,a0,-1356 # 804a4db0 <ftable>
    80007304:	ffffa097          	auipc	ra,0xffffa
    80007308:	f36080e7          	jalr	-202(ra) # 8000123a <initlock>
}
    8000730c:	0001                	nop
    8000730e:	60a2                	ld	ra,8(sp)
    80007310:	6402                	ld	s0,0(sp)
    80007312:	0141                	addi	sp,sp,16
    80007314:	8082                	ret

0000000080007316 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80007316:	1101                	addi	sp,sp,-32
    80007318:	ec06                	sd	ra,24(sp)
    8000731a:	e822                	sd	s0,16(sp)
    8000731c:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    8000731e:	0049e517          	auipc	a0,0x49e
    80007322:	a9250513          	addi	a0,a0,-1390 # 804a4db0 <ftable>
    80007326:	ffffa097          	auipc	ra,0xffffa
    8000732a:	f44080e7          	jalr	-188(ra) # 8000126a <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000732e:	0049e797          	auipc	a5,0x49e
    80007332:	a9a78793          	addi	a5,a5,-1382 # 804a4dc8 <ftable+0x18>
    80007336:	fef43423          	sd	a5,-24(s0)
    8000733a:	a815                	j	8000736e <filealloc+0x58>
    if(f->ref == 0){
    8000733c:	fe843783          	ld	a5,-24(s0)
    80007340:	43dc                	lw	a5,4(a5)
    80007342:	e385                	bnez	a5,80007362 <filealloc+0x4c>
      f->ref = 1;
    80007344:	fe843783          	ld	a5,-24(s0)
    80007348:	4705                	li	a4,1
    8000734a:	c3d8                	sw	a4,4(a5)
      release(&ftable.lock);
    8000734c:	0049e517          	auipc	a0,0x49e
    80007350:	a6450513          	addi	a0,a0,-1436 # 804a4db0 <ftable>
    80007354:	ffffa097          	auipc	ra,0xffffa
    80007358:	f7a080e7          	jalr	-134(ra) # 800012ce <release>
      return f;
    8000735c:	fe843783          	ld	a5,-24(s0)
    80007360:	a805                	j	80007390 <filealloc+0x7a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80007362:	fe843783          	ld	a5,-24(s0)
    80007366:	02878793          	addi	a5,a5,40
    8000736a:	fef43423          	sd	a5,-24(s0)
    8000736e:	0049f797          	auipc	a5,0x49f
    80007372:	9fa78793          	addi	a5,a5,-1542 # 804a5d68 <ftable+0xfb8>
    80007376:	fe843703          	ld	a4,-24(s0)
    8000737a:	fcf761e3          	bltu	a4,a5,8000733c <filealloc+0x26>
    }
  }
  release(&ftable.lock);
    8000737e:	0049e517          	auipc	a0,0x49e
    80007382:	a3250513          	addi	a0,a0,-1486 # 804a4db0 <ftable>
    80007386:	ffffa097          	auipc	ra,0xffffa
    8000738a:	f48080e7          	jalr	-184(ra) # 800012ce <release>
  return 0;
    8000738e:	4781                	li	a5,0
}
    80007390:	853e                	mv	a0,a5
    80007392:	60e2                	ld	ra,24(sp)
    80007394:	6442                	ld	s0,16(sp)
    80007396:	6105                	addi	sp,sp,32
    80007398:	8082                	ret

000000008000739a <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    8000739a:	1101                	addi	sp,sp,-32
    8000739c:	ec06                	sd	ra,24(sp)
    8000739e:	e822                	sd	s0,16(sp)
    800073a0:	1000                	addi	s0,sp,32
    800073a2:	fea43423          	sd	a0,-24(s0)
  acquire(&ftable.lock);
    800073a6:	0049e517          	auipc	a0,0x49e
    800073aa:	a0a50513          	addi	a0,a0,-1526 # 804a4db0 <ftable>
    800073ae:	ffffa097          	auipc	ra,0xffffa
    800073b2:	ebc080e7          	jalr	-324(ra) # 8000126a <acquire>
  if(f->ref < 1)
    800073b6:	fe843783          	ld	a5,-24(s0)
    800073ba:	43dc                	lw	a5,4(a5)
    800073bc:	00f04a63          	bgtz	a5,800073d0 <filedup+0x36>
    panic("filedup");
    800073c0:	00004517          	auipc	a0,0x4
    800073c4:	38050513          	addi	a0,a0,896 # 8000b740 <etext+0x740>
    800073c8:	ffffa097          	auipc	ra,0xffffa
    800073cc:	8b2080e7          	jalr	-1870(ra) # 80000c7a <panic>
  f->ref++;
    800073d0:	fe843783          	ld	a5,-24(s0)
    800073d4:	43dc                	lw	a5,4(a5)
    800073d6:	2785                	addiw	a5,a5,1
    800073d8:	0007871b          	sext.w	a4,a5
    800073dc:	fe843783          	ld	a5,-24(s0)
    800073e0:	c3d8                	sw	a4,4(a5)
  release(&ftable.lock);
    800073e2:	0049e517          	auipc	a0,0x49e
    800073e6:	9ce50513          	addi	a0,a0,-1586 # 804a4db0 <ftable>
    800073ea:	ffffa097          	auipc	ra,0xffffa
    800073ee:	ee4080e7          	jalr	-284(ra) # 800012ce <release>
  return f;
    800073f2:	fe843783          	ld	a5,-24(s0)
}
    800073f6:	853e                	mv	a0,a5
    800073f8:	60e2                	ld	ra,24(sp)
    800073fa:	6442                	ld	s0,16(sp)
    800073fc:	6105                	addi	sp,sp,32
    800073fe:	8082                	ret

0000000080007400 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80007400:	715d                	addi	sp,sp,-80
    80007402:	e486                	sd	ra,72(sp)
    80007404:	e0a2                	sd	s0,64(sp)
    80007406:	0880                	addi	s0,sp,80
    80007408:	faa43c23          	sd	a0,-72(s0)
  struct file ff;

  acquire(&ftable.lock);
    8000740c:	0049e517          	auipc	a0,0x49e
    80007410:	9a450513          	addi	a0,a0,-1628 # 804a4db0 <ftable>
    80007414:	ffffa097          	auipc	ra,0xffffa
    80007418:	e56080e7          	jalr	-426(ra) # 8000126a <acquire>
  if(f->ref < 1)
    8000741c:	fb843783          	ld	a5,-72(s0)
    80007420:	43dc                	lw	a5,4(a5)
    80007422:	00f04a63          	bgtz	a5,80007436 <fileclose+0x36>
    panic("fileclose");
    80007426:	00004517          	auipc	a0,0x4
    8000742a:	32250513          	addi	a0,a0,802 # 8000b748 <etext+0x748>
    8000742e:	ffffa097          	auipc	ra,0xffffa
    80007432:	84c080e7          	jalr	-1972(ra) # 80000c7a <panic>
  if(--f->ref > 0){
    80007436:	fb843783          	ld	a5,-72(s0)
    8000743a:	43dc                	lw	a5,4(a5)
    8000743c:	37fd                	addiw	a5,a5,-1
    8000743e:	0007871b          	sext.w	a4,a5
    80007442:	fb843783          	ld	a5,-72(s0)
    80007446:	c3d8                	sw	a4,4(a5)
    80007448:	fb843783          	ld	a5,-72(s0)
    8000744c:	43dc                	lw	a5,4(a5)
    8000744e:	00f05b63          	blez	a5,80007464 <fileclose+0x64>
    release(&ftable.lock);
    80007452:	0049e517          	auipc	a0,0x49e
    80007456:	95e50513          	addi	a0,a0,-1698 # 804a4db0 <ftable>
    8000745a:	ffffa097          	auipc	ra,0xffffa
    8000745e:	e74080e7          	jalr	-396(ra) # 800012ce <release>
    80007462:	a879                	j	80007500 <fileclose+0x100>
    return;
  }
  ff = *f;
    80007464:	fb843783          	ld	a5,-72(s0)
    80007468:	638c                	ld	a1,0(a5)
    8000746a:	6790                	ld	a2,8(a5)
    8000746c:	6b94                	ld	a3,16(a5)
    8000746e:	6f98                	ld	a4,24(a5)
    80007470:	739c                	ld	a5,32(a5)
    80007472:	fcb43423          	sd	a1,-56(s0)
    80007476:	fcc43823          	sd	a2,-48(s0)
    8000747a:	fcd43c23          	sd	a3,-40(s0)
    8000747e:	fee43023          	sd	a4,-32(s0)
    80007482:	fef43423          	sd	a5,-24(s0)
  f->ref = 0;
    80007486:	fb843783          	ld	a5,-72(s0)
    8000748a:	0007a223          	sw	zero,4(a5)
  f->type = FD_NONE;
    8000748e:	fb843783          	ld	a5,-72(s0)
    80007492:	0007a023          	sw	zero,0(a5)
  release(&ftable.lock);
    80007496:	0049e517          	auipc	a0,0x49e
    8000749a:	91a50513          	addi	a0,a0,-1766 # 804a4db0 <ftable>
    8000749e:	ffffa097          	auipc	ra,0xffffa
    800074a2:	e30080e7          	jalr	-464(ra) # 800012ce <release>

  if(ff.type == FD_PIPE){
    800074a6:	fc842783          	lw	a5,-56(s0)
    800074aa:	873e                	mv	a4,a5
    800074ac:	4785                	li	a5,1
    800074ae:	00f71e63          	bne	a4,a5,800074ca <fileclose+0xca>
    pipeclose(ff.pipe, ff.writable);
    800074b2:	fd843783          	ld	a5,-40(s0)
    800074b6:	fd144703          	lbu	a4,-47(s0)
    800074ba:	2701                	sext.w	a4,a4
    800074bc:	85ba                	mv	a1,a4
    800074be:	853e                	mv	a0,a5
    800074c0:	00000097          	auipc	ra,0x0
    800074c4:	5b6080e7          	jalr	1462(ra) # 80007a76 <pipeclose>
    800074c8:	a825                	j	80007500 <fileclose+0x100>
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    800074ca:	fc842783          	lw	a5,-56(s0)
    800074ce:	873e                	mv	a4,a5
    800074d0:	4789                	li	a5,2
    800074d2:	00f70863          	beq	a4,a5,800074e2 <fileclose+0xe2>
    800074d6:	fc842783          	lw	a5,-56(s0)
    800074da:	873e                	mv	a4,a5
    800074dc:	478d                	li	a5,3
    800074de:	02f71163          	bne	a4,a5,80007500 <fileclose+0x100>
    begin_op();
    800074e2:	00000097          	auipc	ra,0x0
    800074e6:	884080e7          	jalr	-1916(ra) # 80006d66 <begin_op>
    iput(ff.ip);
    800074ea:	fe043783          	ld	a5,-32(s0)
    800074ee:	853e                	mv	a0,a5
    800074f0:	fffff097          	auipc	ra,0xfffff
    800074f4:	99c080e7          	jalr	-1636(ra) # 80005e8c <iput>
    end_op();
    800074f8:	00000097          	auipc	ra,0x0
    800074fc:	930080e7          	jalr	-1744(ra) # 80006e28 <end_op>
  }
}
    80007500:	60a6                	ld	ra,72(sp)
    80007502:	6406                	ld	s0,64(sp)
    80007504:	6161                	addi	sp,sp,80
    80007506:	8082                	ret

0000000080007508 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80007508:	7139                	addi	sp,sp,-64
    8000750a:	fc06                	sd	ra,56(sp)
    8000750c:	f822                	sd	s0,48(sp)
    8000750e:	0080                	addi	s0,sp,64
    80007510:	fca43423          	sd	a0,-56(s0)
    80007514:	fcb43023          	sd	a1,-64(s0)
  struct proc *p = myproc();
    80007518:	ffffb097          	auipc	ra,0xffffb
    8000751c:	500080e7          	jalr	1280(ra) # 80002a18 <myproc>
    80007520:	fea43423          	sd	a0,-24(s0)
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80007524:	fc843783          	ld	a5,-56(s0)
    80007528:	439c                	lw	a5,0(a5)
    8000752a:	873e                	mv	a4,a5
    8000752c:	4789                	li	a5,2
    8000752e:	00f70963          	beq	a4,a5,80007540 <filestat+0x38>
    80007532:	fc843783          	ld	a5,-56(s0)
    80007536:	439c                	lw	a5,0(a5)
    80007538:	873e                	mv	a4,a5
    8000753a:	478d                	li	a5,3
    8000753c:	06f71263          	bne	a4,a5,800075a0 <filestat+0x98>
    ilock(f->ip);
    80007540:	fc843783          	ld	a5,-56(s0)
    80007544:	6f9c                	ld	a5,24(a5)
    80007546:	853e                	mv	a0,a5
    80007548:	ffffe097          	auipc	ra,0xffffe
    8000754c:	7b6080e7          	jalr	1974(ra) # 80005cfe <ilock>
    stati(f->ip, &st);
    80007550:	fc843783          	ld	a5,-56(s0)
    80007554:	6f9c                	ld	a5,24(a5)
    80007556:	fd040713          	addi	a4,s0,-48
    8000755a:	85ba                	mv	a1,a4
    8000755c:	853e                	mv	a0,a5
    8000755e:	fffff097          	auipc	ra,0xfffff
    80007562:	cd2080e7          	jalr	-814(ra) # 80006230 <stati>
    iunlock(f->ip);
    80007566:	fc843783          	ld	a5,-56(s0)
    8000756a:	6f9c                	ld	a5,24(a5)
    8000756c:	853e                	mv	a0,a5
    8000756e:	fffff097          	auipc	ra,0xfffff
    80007572:	8c4080e7          	jalr	-1852(ra) # 80005e32 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80007576:	fe843783          	ld	a5,-24(s0)
    8000757a:	6bbc                	ld	a5,80(a5)
    8000757c:	fd040713          	addi	a4,s0,-48
    80007580:	46e1                	li	a3,24
    80007582:	863a                	mv	a2,a4
    80007584:	fc043583          	ld	a1,-64(s0)
    80007588:	853e                	mv	a0,a5
    8000758a:	ffffb097          	auipc	ra,0xffffb
    8000758e:	e3c080e7          	jalr	-452(ra) # 800023c6 <copyout>
    80007592:	87aa                	mv	a5,a0
    80007594:	0007d463          	bgez	a5,8000759c <filestat+0x94>
      return -1;
    80007598:	57fd                	li	a5,-1
    8000759a:	a021                	j	800075a2 <filestat+0x9a>
    return 0;
    8000759c:	4781                	li	a5,0
    8000759e:	a011                	j	800075a2 <filestat+0x9a>
  }
  return -1;
    800075a0:	57fd                	li	a5,-1
}
    800075a2:	853e                	mv	a0,a5
    800075a4:	70e2                	ld	ra,56(sp)
    800075a6:	7442                	ld	s0,48(sp)
    800075a8:	6121                	addi	sp,sp,64
    800075aa:	8082                	ret

00000000800075ac <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    800075ac:	7139                	addi	sp,sp,-64
    800075ae:	fc06                	sd	ra,56(sp)
    800075b0:	f822                	sd	s0,48(sp)
    800075b2:	0080                	addi	s0,sp,64
    800075b4:	fca43c23          	sd	a0,-40(s0)
    800075b8:	fcb43823          	sd	a1,-48(s0)
    800075bc:	87b2                	mv	a5,a2
    800075be:	fcf42623          	sw	a5,-52(s0)
  int r = 0;
    800075c2:	fe042623          	sw	zero,-20(s0)

  if(f->readable == 0)
    800075c6:	fd843783          	ld	a5,-40(s0)
    800075ca:	0087c783          	lbu	a5,8(a5)
    800075ce:	e399                	bnez	a5,800075d4 <fileread+0x28>
    return -1;
    800075d0:	57fd                	li	a5,-1
    800075d2:	aa1d                	j	80007708 <fileread+0x15c>

  if(f->type == FD_PIPE){
    800075d4:	fd843783          	ld	a5,-40(s0)
    800075d8:	439c                	lw	a5,0(a5)
    800075da:	873e                	mv	a4,a5
    800075dc:	4785                	li	a5,1
    800075de:	02f71363          	bne	a4,a5,80007604 <fileread+0x58>
    r = piperead(f->pipe, addr, n);
    800075e2:	fd843783          	ld	a5,-40(s0)
    800075e6:	6b9c                	ld	a5,16(a5)
    800075e8:	fcc42703          	lw	a4,-52(s0)
    800075ec:	863a                	mv	a2,a4
    800075ee:	fd043583          	ld	a1,-48(s0)
    800075f2:	853e                	mv	a0,a5
    800075f4:	00000097          	auipc	ra,0x0
    800075f8:	676080e7          	jalr	1654(ra) # 80007c6a <piperead>
    800075fc:	87aa                	mv	a5,a0
    800075fe:	fef42623          	sw	a5,-20(s0)
    80007602:	a209                	j	80007704 <fileread+0x158>
  } else if(f->type == FD_DEVICE){
    80007604:	fd843783          	ld	a5,-40(s0)
    80007608:	439c                	lw	a5,0(a5)
    8000760a:	873e                	mv	a4,a5
    8000760c:	478d                	li	a5,3
    8000760e:	06f71863          	bne	a4,a5,8000767e <fileread+0xd2>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80007612:	fd843783          	ld	a5,-40(s0)
    80007616:	02479783          	lh	a5,36(a5)
    8000761a:	2781                	sext.w	a5,a5
    8000761c:	0207c863          	bltz	a5,8000764c <fileread+0xa0>
    80007620:	fd843783          	ld	a5,-40(s0)
    80007624:	02479783          	lh	a5,36(a5)
    80007628:	0007871b          	sext.w	a4,a5
    8000762c:	47a5                	li	a5,9
    8000762e:	00e7cf63          	blt	a5,a4,8000764c <fileread+0xa0>
    80007632:	fd843783          	ld	a5,-40(s0)
    80007636:	02479783          	lh	a5,36(a5)
    8000763a:	2781                	sext.w	a5,a5
    8000763c:	0049d717          	auipc	a4,0x49d
    80007640:	6d470713          	addi	a4,a4,1748 # 804a4d10 <devsw>
    80007644:	0792                	slli	a5,a5,0x4
    80007646:	97ba                	add	a5,a5,a4
    80007648:	639c                	ld	a5,0(a5)
    8000764a:	e399                	bnez	a5,80007650 <fileread+0xa4>
      return -1;
    8000764c:	57fd                	li	a5,-1
    8000764e:	a86d                	j	80007708 <fileread+0x15c>
    r = devsw[f->major].read(1, addr, n);
    80007650:	fd843783          	ld	a5,-40(s0)
    80007654:	02479783          	lh	a5,36(a5)
    80007658:	2781                	sext.w	a5,a5
    8000765a:	0049d717          	auipc	a4,0x49d
    8000765e:	6b670713          	addi	a4,a4,1718 # 804a4d10 <devsw>
    80007662:	0792                	slli	a5,a5,0x4
    80007664:	97ba                	add	a5,a5,a4
    80007666:	6398                	ld	a4,0(a5)
    80007668:	fcc42783          	lw	a5,-52(s0)
    8000766c:	863e                	mv	a2,a5
    8000766e:	fd043583          	ld	a1,-48(s0)
    80007672:	4505                	li	a0,1
    80007674:	9702                	jalr	a4
    80007676:	87aa                	mv	a5,a0
    80007678:	fef42623          	sw	a5,-20(s0)
    8000767c:	a061                	j	80007704 <fileread+0x158>
  } else if(f->type == FD_INODE){
    8000767e:	fd843783          	ld	a5,-40(s0)
    80007682:	439c                	lw	a5,0(a5)
    80007684:	873e                	mv	a4,a5
    80007686:	4789                	li	a5,2
    80007688:	06f71663          	bne	a4,a5,800076f4 <fileread+0x148>
    ilock(f->ip);
    8000768c:	fd843783          	ld	a5,-40(s0)
    80007690:	6f9c                	ld	a5,24(a5)
    80007692:	853e                	mv	a0,a5
    80007694:	ffffe097          	auipc	ra,0xffffe
    80007698:	66a080e7          	jalr	1642(ra) # 80005cfe <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    8000769c:	fd843783          	ld	a5,-40(s0)
    800076a0:	6f88                	ld	a0,24(a5)
    800076a2:	fd843783          	ld	a5,-40(s0)
    800076a6:	539c                	lw	a5,32(a5)
    800076a8:	fcc42703          	lw	a4,-52(s0)
    800076ac:	86be                	mv	a3,a5
    800076ae:	fd043603          	ld	a2,-48(s0)
    800076b2:	4585                	li	a1,1
    800076b4:	fffff097          	auipc	ra,0xfffff
    800076b8:	be0080e7          	jalr	-1056(ra) # 80006294 <readi>
    800076bc:	87aa                	mv	a5,a0
    800076be:	fef42623          	sw	a5,-20(s0)
    800076c2:	fec42783          	lw	a5,-20(s0)
    800076c6:	2781                	sext.w	a5,a5
    800076c8:	00f05d63          	blez	a5,800076e2 <fileread+0x136>
      f->off += r;
    800076cc:	fd843783          	ld	a5,-40(s0)
    800076d0:	5398                	lw	a4,32(a5)
    800076d2:	fec42783          	lw	a5,-20(s0)
    800076d6:	9fb9                	addw	a5,a5,a4
    800076d8:	0007871b          	sext.w	a4,a5
    800076dc:	fd843783          	ld	a5,-40(s0)
    800076e0:	d398                	sw	a4,32(a5)
    iunlock(f->ip);
    800076e2:	fd843783          	ld	a5,-40(s0)
    800076e6:	6f9c                	ld	a5,24(a5)
    800076e8:	853e                	mv	a0,a5
    800076ea:	ffffe097          	auipc	ra,0xffffe
    800076ee:	748080e7          	jalr	1864(ra) # 80005e32 <iunlock>
    800076f2:	a809                	j	80007704 <fileread+0x158>
  } else {
    panic("fileread");
    800076f4:	00004517          	auipc	a0,0x4
    800076f8:	06450513          	addi	a0,a0,100 # 8000b758 <etext+0x758>
    800076fc:	ffff9097          	auipc	ra,0xffff9
    80007700:	57e080e7          	jalr	1406(ra) # 80000c7a <panic>
  }

  return r;
    80007704:	fec42783          	lw	a5,-20(s0)
}
    80007708:	853e                	mv	a0,a5
    8000770a:	70e2                	ld	ra,56(sp)
    8000770c:	7442                	ld	s0,48(sp)
    8000770e:	6121                	addi	sp,sp,64
    80007710:	8082                	ret

0000000080007712 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80007712:	715d                	addi	sp,sp,-80
    80007714:	e486                	sd	ra,72(sp)
    80007716:	e0a2                	sd	s0,64(sp)
    80007718:	0880                	addi	s0,sp,80
    8000771a:	fca43423          	sd	a0,-56(s0)
    8000771e:	fcb43023          	sd	a1,-64(s0)
    80007722:	87b2                	mv	a5,a2
    80007724:	faf42e23          	sw	a5,-68(s0)
  int r, ret = 0;
    80007728:	fe042623          	sw	zero,-20(s0)

  if(f->writable == 0)
    8000772c:	fc843783          	ld	a5,-56(s0)
    80007730:	0097c783          	lbu	a5,9(a5)
    80007734:	e399                	bnez	a5,8000773a <filewrite+0x28>
    return -1;
    80007736:	57fd                	li	a5,-1
    80007738:	a2c5                	j	80007918 <filewrite+0x206>

  if(f->type == FD_PIPE){
    8000773a:	fc843783          	ld	a5,-56(s0)
    8000773e:	439c                	lw	a5,0(a5)
    80007740:	873e                	mv	a4,a5
    80007742:	4785                	li	a5,1
    80007744:	02f71363          	bne	a4,a5,8000776a <filewrite+0x58>
    ret = pipewrite(f->pipe, addr, n);
    80007748:	fc843783          	ld	a5,-56(s0)
    8000774c:	6b9c                	ld	a5,16(a5)
    8000774e:	fbc42703          	lw	a4,-68(s0)
    80007752:	863a                	mv	a2,a4
    80007754:	fc043583          	ld	a1,-64(s0)
    80007758:	853e                	mv	a0,a5
    8000775a:	00000097          	auipc	ra,0x0
    8000775e:	3c4080e7          	jalr	964(ra) # 80007b1e <pipewrite>
    80007762:	87aa                	mv	a5,a0
    80007764:	fef42623          	sw	a5,-20(s0)
    80007768:	a275                	j	80007914 <filewrite+0x202>
  } else if(f->type == FD_DEVICE){
    8000776a:	fc843783          	ld	a5,-56(s0)
    8000776e:	439c                	lw	a5,0(a5)
    80007770:	873e                	mv	a4,a5
    80007772:	478d                	li	a5,3
    80007774:	06f71863          	bne	a4,a5,800077e4 <filewrite+0xd2>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80007778:	fc843783          	ld	a5,-56(s0)
    8000777c:	02479783          	lh	a5,36(a5)
    80007780:	2781                	sext.w	a5,a5
    80007782:	0207c863          	bltz	a5,800077b2 <filewrite+0xa0>
    80007786:	fc843783          	ld	a5,-56(s0)
    8000778a:	02479783          	lh	a5,36(a5)
    8000778e:	0007871b          	sext.w	a4,a5
    80007792:	47a5                	li	a5,9
    80007794:	00e7cf63          	blt	a5,a4,800077b2 <filewrite+0xa0>
    80007798:	fc843783          	ld	a5,-56(s0)
    8000779c:	02479783          	lh	a5,36(a5)
    800077a0:	2781                	sext.w	a5,a5
    800077a2:	0049d717          	auipc	a4,0x49d
    800077a6:	56e70713          	addi	a4,a4,1390 # 804a4d10 <devsw>
    800077aa:	0792                	slli	a5,a5,0x4
    800077ac:	97ba                	add	a5,a5,a4
    800077ae:	679c                	ld	a5,8(a5)
    800077b0:	e399                	bnez	a5,800077b6 <filewrite+0xa4>
      return -1;
    800077b2:	57fd                	li	a5,-1
    800077b4:	a295                	j	80007918 <filewrite+0x206>
    ret = devsw[f->major].write(1, addr, n);
    800077b6:	fc843783          	ld	a5,-56(s0)
    800077ba:	02479783          	lh	a5,36(a5)
    800077be:	2781                	sext.w	a5,a5
    800077c0:	0049d717          	auipc	a4,0x49d
    800077c4:	55070713          	addi	a4,a4,1360 # 804a4d10 <devsw>
    800077c8:	0792                	slli	a5,a5,0x4
    800077ca:	97ba                	add	a5,a5,a4
    800077cc:	6798                	ld	a4,8(a5)
    800077ce:	fbc42783          	lw	a5,-68(s0)
    800077d2:	863e                	mv	a2,a5
    800077d4:	fc043583          	ld	a1,-64(s0)
    800077d8:	4505                	li	a0,1
    800077da:	9702                	jalr	a4
    800077dc:	87aa                	mv	a5,a0
    800077de:	fef42623          	sw	a5,-20(s0)
    800077e2:	aa0d                	j	80007914 <filewrite+0x202>
  } else if(f->type == FD_INODE){
    800077e4:	fc843783          	ld	a5,-56(s0)
    800077e8:	439c                	lw	a5,0(a5)
    800077ea:	873e                	mv	a4,a5
    800077ec:	4789                	li	a5,2
    800077ee:	10f71b63          	bne	a4,a5,80007904 <filewrite+0x1f2>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    800077f2:	6785                	lui	a5,0x1
    800077f4:	c0078793          	addi	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    800077f8:	fef42023          	sw	a5,-32(s0)
    int i = 0;
    800077fc:	fe042423          	sw	zero,-24(s0)
    while(i < n){
    80007800:	a0f9                	j	800078ce <filewrite+0x1bc>
      int n1 = n - i;
    80007802:	fbc42783          	lw	a5,-68(s0)
    80007806:	873e                	mv	a4,a5
    80007808:	fe842783          	lw	a5,-24(s0)
    8000780c:	40f707bb          	subw	a5,a4,a5
    80007810:	fef42223          	sw	a5,-28(s0)
      if(n1 > max)
    80007814:	fe442783          	lw	a5,-28(s0)
    80007818:	873e                	mv	a4,a5
    8000781a:	fe042783          	lw	a5,-32(s0)
    8000781e:	2701                	sext.w	a4,a4
    80007820:	2781                	sext.w	a5,a5
    80007822:	00e7d663          	bge	a5,a4,8000782e <filewrite+0x11c>
        n1 = max;
    80007826:	fe042783          	lw	a5,-32(s0)
    8000782a:	fef42223          	sw	a5,-28(s0)

      begin_op();
    8000782e:	fffff097          	auipc	ra,0xfffff
    80007832:	538080e7          	jalr	1336(ra) # 80006d66 <begin_op>
      ilock(f->ip);
    80007836:	fc843783          	ld	a5,-56(s0)
    8000783a:	6f9c                	ld	a5,24(a5)
    8000783c:	853e                	mv	a0,a5
    8000783e:	ffffe097          	auipc	ra,0xffffe
    80007842:	4c0080e7          	jalr	1216(ra) # 80005cfe <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80007846:	fc843783          	ld	a5,-56(s0)
    8000784a:	6f88                	ld	a0,24(a5)
    8000784c:	fe842703          	lw	a4,-24(s0)
    80007850:	fc043783          	ld	a5,-64(s0)
    80007854:	00f70633          	add	a2,a4,a5
    80007858:	fc843783          	ld	a5,-56(s0)
    8000785c:	539c                	lw	a5,32(a5)
    8000785e:	fe442703          	lw	a4,-28(s0)
    80007862:	86be                	mv	a3,a5
    80007864:	4585                	li	a1,1
    80007866:	fffff097          	auipc	ra,0xfffff
    8000786a:	bbe080e7          	jalr	-1090(ra) # 80006424 <writei>
    8000786e:	87aa                	mv	a5,a0
    80007870:	fcf42e23          	sw	a5,-36(s0)
    80007874:	fdc42783          	lw	a5,-36(s0)
    80007878:	2781                	sext.w	a5,a5
    8000787a:	00f05d63          	blez	a5,80007894 <filewrite+0x182>
        f->off += r;
    8000787e:	fc843783          	ld	a5,-56(s0)
    80007882:	5398                	lw	a4,32(a5)
    80007884:	fdc42783          	lw	a5,-36(s0)
    80007888:	9fb9                	addw	a5,a5,a4
    8000788a:	0007871b          	sext.w	a4,a5
    8000788e:	fc843783          	ld	a5,-56(s0)
    80007892:	d398                	sw	a4,32(a5)
      iunlock(f->ip);
    80007894:	fc843783          	ld	a5,-56(s0)
    80007898:	6f9c                	ld	a5,24(a5)
    8000789a:	853e                	mv	a0,a5
    8000789c:	ffffe097          	auipc	ra,0xffffe
    800078a0:	596080e7          	jalr	1430(ra) # 80005e32 <iunlock>
      end_op();
    800078a4:	fffff097          	auipc	ra,0xfffff
    800078a8:	584080e7          	jalr	1412(ra) # 80006e28 <end_op>

      if(r != n1){
    800078ac:	fdc42783          	lw	a5,-36(s0)
    800078b0:	873e                	mv	a4,a5
    800078b2:	fe442783          	lw	a5,-28(s0)
    800078b6:	2701                	sext.w	a4,a4
    800078b8:	2781                	sext.w	a5,a5
    800078ba:	02f71463          	bne	a4,a5,800078e2 <filewrite+0x1d0>
        // error from writei
        break;
      }
      i += r;
    800078be:	fe842783          	lw	a5,-24(s0)
    800078c2:	873e                	mv	a4,a5
    800078c4:	fdc42783          	lw	a5,-36(s0)
    800078c8:	9fb9                	addw	a5,a5,a4
    800078ca:	fef42423          	sw	a5,-24(s0)
    while(i < n){
    800078ce:	fe842783          	lw	a5,-24(s0)
    800078d2:	873e                	mv	a4,a5
    800078d4:	fbc42783          	lw	a5,-68(s0)
    800078d8:	2701                	sext.w	a4,a4
    800078da:	2781                	sext.w	a5,a5
    800078dc:	f2f743e3          	blt	a4,a5,80007802 <filewrite+0xf0>
    800078e0:	a011                	j	800078e4 <filewrite+0x1d2>
        break;
    800078e2:	0001                	nop
    }
    ret = (i == n ? n : -1);
    800078e4:	fe842783          	lw	a5,-24(s0)
    800078e8:	873e                	mv	a4,a5
    800078ea:	fbc42783          	lw	a5,-68(s0)
    800078ee:	2701                	sext.w	a4,a4
    800078f0:	2781                	sext.w	a5,a5
    800078f2:	00f71563          	bne	a4,a5,800078fc <filewrite+0x1ea>
    800078f6:	fbc42783          	lw	a5,-68(s0)
    800078fa:	a011                	j	800078fe <filewrite+0x1ec>
    800078fc:	57fd                	li	a5,-1
    800078fe:	fef42623          	sw	a5,-20(s0)
    80007902:	a809                	j	80007914 <filewrite+0x202>
  } else {
    panic("filewrite");
    80007904:	00004517          	auipc	a0,0x4
    80007908:	e6450513          	addi	a0,a0,-412 # 8000b768 <etext+0x768>
    8000790c:	ffff9097          	auipc	ra,0xffff9
    80007910:	36e080e7          	jalr	878(ra) # 80000c7a <panic>
  }

  return ret;
    80007914:	fec42783          	lw	a5,-20(s0)
}
    80007918:	853e                	mv	a0,a5
    8000791a:	60a6                	ld	ra,72(sp)
    8000791c:	6406                	ld	s0,64(sp)
    8000791e:	6161                	addi	sp,sp,80
    80007920:	8082                	ret

0000000080007922 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80007922:	7179                	addi	sp,sp,-48
    80007924:	f406                	sd	ra,40(sp)
    80007926:	f022                	sd	s0,32(sp)
    80007928:	1800                	addi	s0,sp,48
    8000792a:	fca43c23          	sd	a0,-40(s0)
    8000792e:	fcb43823          	sd	a1,-48(s0)
  struct pipe *pi;

  pi = 0;
    80007932:	fe043423          	sd	zero,-24(s0)
  *f0 = *f1 = 0;
    80007936:	fd043783          	ld	a5,-48(s0)
    8000793a:	0007b023          	sd	zero,0(a5)
    8000793e:	fd043783          	ld	a5,-48(s0)
    80007942:	6398                	ld	a4,0(a5)
    80007944:	fd843783          	ld	a5,-40(s0)
    80007948:	e398                	sd	a4,0(a5)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    8000794a:	00000097          	auipc	ra,0x0
    8000794e:	9cc080e7          	jalr	-1588(ra) # 80007316 <filealloc>
    80007952:	872a                	mv	a4,a0
    80007954:	fd843783          	ld	a5,-40(s0)
    80007958:	e398                	sd	a4,0(a5)
    8000795a:	fd843783          	ld	a5,-40(s0)
    8000795e:	639c                	ld	a5,0(a5)
    80007960:	c3e9                	beqz	a5,80007a22 <pipealloc+0x100>
    80007962:	00000097          	auipc	ra,0x0
    80007966:	9b4080e7          	jalr	-1612(ra) # 80007316 <filealloc>
    8000796a:	872a                	mv	a4,a0
    8000796c:	fd043783          	ld	a5,-48(s0)
    80007970:	e398                	sd	a4,0(a5)
    80007972:	fd043783          	ld	a5,-48(s0)
    80007976:	639c                	ld	a5,0(a5)
    80007978:	c7cd                	beqz	a5,80007a22 <pipealloc+0x100>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    8000797a:	ffff9097          	auipc	ra,0xffff9
    8000797e:	79c080e7          	jalr	1948(ra) # 80001116 <kalloc>
    80007982:	fea43423          	sd	a0,-24(s0)
    80007986:	fe843783          	ld	a5,-24(s0)
    8000798a:	cfd1                	beqz	a5,80007a26 <pipealloc+0x104>
    goto bad;
  pi->readopen = 1;
    8000798c:	fe843783          	ld	a5,-24(s0)
    80007990:	4705                	li	a4,1
    80007992:	22e7a023          	sw	a4,544(a5)
  pi->writeopen = 1;
    80007996:	fe843783          	ld	a5,-24(s0)
    8000799a:	4705                	li	a4,1
    8000799c:	22e7a223          	sw	a4,548(a5)
  pi->nwrite = 0;
    800079a0:	fe843783          	ld	a5,-24(s0)
    800079a4:	2007ae23          	sw	zero,540(a5)
  pi->nread = 0;
    800079a8:	fe843783          	ld	a5,-24(s0)
    800079ac:	2007ac23          	sw	zero,536(a5)
  initlock(&pi->lock, "pipe");
    800079b0:	fe843783          	ld	a5,-24(s0)
    800079b4:	00004597          	auipc	a1,0x4
    800079b8:	dc458593          	addi	a1,a1,-572 # 8000b778 <etext+0x778>
    800079bc:	853e                	mv	a0,a5
    800079be:	ffffa097          	auipc	ra,0xffffa
    800079c2:	87c080e7          	jalr	-1924(ra) # 8000123a <initlock>
  (*f0)->type = FD_PIPE;
    800079c6:	fd843783          	ld	a5,-40(s0)
    800079ca:	639c                	ld	a5,0(a5)
    800079cc:	4705                	li	a4,1
    800079ce:	c398                	sw	a4,0(a5)
  (*f0)->readable = 1;
    800079d0:	fd843783          	ld	a5,-40(s0)
    800079d4:	639c                	ld	a5,0(a5)
    800079d6:	4705                	li	a4,1
    800079d8:	00e78423          	sb	a4,8(a5)
  (*f0)->writable = 0;
    800079dc:	fd843783          	ld	a5,-40(s0)
    800079e0:	639c                	ld	a5,0(a5)
    800079e2:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    800079e6:	fd843783          	ld	a5,-40(s0)
    800079ea:	639c                	ld	a5,0(a5)
    800079ec:	fe843703          	ld	a4,-24(s0)
    800079f0:	eb98                	sd	a4,16(a5)
  (*f1)->type = FD_PIPE;
    800079f2:	fd043783          	ld	a5,-48(s0)
    800079f6:	639c                	ld	a5,0(a5)
    800079f8:	4705                	li	a4,1
    800079fa:	c398                	sw	a4,0(a5)
  (*f1)->readable = 0;
    800079fc:	fd043783          	ld	a5,-48(s0)
    80007a00:	639c                	ld	a5,0(a5)
    80007a02:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80007a06:	fd043783          	ld	a5,-48(s0)
    80007a0a:	639c                	ld	a5,0(a5)
    80007a0c:	4705                	li	a4,1
    80007a0e:	00e784a3          	sb	a4,9(a5)
  (*f1)->pipe = pi;
    80007a12:	fd043783          	ld	a5,-48(s0)
    80007a16:	639c                	ld	a5,0(a5)
    80007a18:	fe843703          	ld	a4,-24(s0)
    80007a1c:	eb98                	sd	a4,16(a5)
  return 0;
    80007a1e:	4781                	li	a5,0
    80007a20:	a0b1                	j	80007a6c <pipealloc+0x14a>
    goto bad;
    80007a22:	0001                	nop
    80007a24:	a011                	j	80007a28 <pipealloc+0x106>
    goto bad;
    80007a26:	0001                	nop

 bad:
  if(pi)
    80007a28:	fe843783          	ld	a5,-24(s0)
    80007a2c:	c799                	beqz	a5,80007a3a <pipealloc+0x118>
    kfree((char*)pi);
    80007a2e:	fe843503          	ld	a0,-24(s0)
    80007a32:	ffff9097          	auipc	ra,0xffff9
    80007a36:	640080e7          	jalr	1600(ra) # 80001072 <kfree>
  if(*f0)
    80007a3a:	fd843783          	ld	a5,-40(s0)
    80007a3e:	639c                	ld	a5,0(a5)
    80007a40:	cb89                	beqz	a5,80007a52 <pipealloc+0x130>
    fileclose(*f0);
    80007a42:	fd843783          	ld	a5,-40(s0)
    80007a46:	639c                	ld	a5,0(a5)
    80007a48:	853e                	mv	a0,a5
    80007a4a:	00000097          	auipc	ra,0x0
    80007a4e:	9b6080e7          	jalr	-1610(ra) # 80007400 <fileclose>
  if(*f1)
    80007a52:	fd043783          	ld	a5,-48(s0)
    80007a56:	639c                	ld	a5,0(a5)
    80007a58:	cb89                	beqz	a5,80007a6a <pipealloc+0x148>
    fileclose(*f1);
    80007a5a:	fd043783          	ld	a5,-48(s0)
    80007a5e:	639c                	ld	a5,0(a5)
    80007a60:	853e                	mv	a0,a5
    80007a62:	00000097          	auipc	ra,0x0
    80007a66:	99e080e7          	jalr	-1634(ra) # 80007400 <fileclose>
  return -1;
    80007a6a:	57fd                	li	a5,-1
}
    80007a6c:	853e                	mv	a0,a5
    80007a6e:	70a2                	ld	ra,40(sp)
    80007a70:	7402                	ld	s0,32(sp)
    80007a72:	6145                	addi	sp,sp,48
    80007a74:	8082                	ret

0000000080007a76 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80007a76:	1101                	addi	sp,sp,-32
    80007a78:	ec06                	sd	ra,24(sp)
    80007a7a:	e822                	sd	s0,16(sp)
    80007a7c:	1000                	addi	s0,sp,32
    80007a7e:	fea43423          	sd	a0,-24(s0)
    80007a82:	87ae                	mv	a5,a1
    80007a84:	fef42223          	sw	a5,-28(s0)
  acquire(&pi->lock);
    80007a88:	fe843783          	ld	a5,-24(s0)
    80007a8c:	853e                	mv	a0,a5
    80007a8e:	ffff9097          	auipc	ra,0xffff9
    80007a92:	7dc080e7          	jalr	2012(ra) # 8000126a <acquire>
  if(writable){
    80007a96:	fe442783          	lw	a5,-28(s0)
    80007a9a:	2781                	sext.w	a5,a5
    80007a9c:	cf99                	beqz	a5,80007aba <pipeclose+0x44>
    pi->writeopen = 0;
    80007a9e:	fe843783          	ld	a5,-24(s0)
    80007aa2:	2207a223          	sw	zero,548(a5)
    wakeup(&pi->nread);
    80007aa6:	fe843783          	ld	a5,-24(s0)
    80007aaa:	21878793          	addi	a5,a5,536
    80007aae:	853e                	mv	a0,a5
    80007ab0:	ffffc097          	auipc	ra,0xffffc
    80007ab4:	ece080e7          	jalr	-306(ra) # 8000397e <wakeup>
    80007ab8:	a831                	j	80007ad4 <pipeclose+0x5e>
  } else {
    pi->readopen = 0;
    80007aba:	fe843783          	ld	a5,-24(s0)
    80007abe:	2207a023          	sw	zero,544(a5)
    wakeup(&pi->nwrite);
    80007ac2:	fe843783          	ld	a5,-24(s0)
    80007ac6:	21c78793          	addi	a5,a5,540
    80007aca:	853e                	mv	a0,a5
    80007acc:	ffffc097          	auipc	ra,0xffffc
    80007ad0:	eb2080e7          	jalr	-334(ra) # 8000397e <wakeup>
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80007ad4:	fe843783          	ld	a5,-24(s0)
    80007ad8:	2207a783          	lw	a5,544(a5)
    80007adc:	e785                	bnez	a5,80007b04 <pipeclose+0x8e>
    80007ade:	fe843783          	ld	a5,-24(s0)
    80007ae2:	2247a783          	lw	a5,548(a5)
    80007ae6:	ef99                	bnez	a5,80007b04 <pipeclose+0x8e>
    release(&pi->lock);
    80007ae8:	fe843783          	ld	a5,-24(s0)
    80007aec:	853e                	mv	a0,a5
    80007aee:	ffff9097          	auipc	ra,0xffff9
    80007af2:	7e0080e7          	jalr	2016(ra) # 800012ce <release>
    kfree((char*)pi);
    80007af6:	fe843503          	ld	a0,-24(s0)
    80007afa:	ffff9097          	auipc	ra,0xffff9
    80007afe:	578080e7          	jalr	1400(ra) # 80001072 <kfree>
    80007b02:	a809                	j	80007b14 <pipeclose+0x9e>
  } else
    release(&pi->lock);
    80007b04:	fe843783          	ld	a5,-24(s0)
    80007b08:	853e                	mv	a0,a5
    80007b0a:	ffff9097          	auipc	ra,0xffff9
    80007b0e:	7c4080e7          	jalr	1988(ra) # 800012ce <release>
}
    80007b12:	0001                	nop
    80007b14:	0001                	nop
    80007b16:	60e2                	ld	ra,24(sp)
    80007b18:	6442                	ld	s0,16(sp)
    80007b1a:	6105                	addi	sp,sp,32
    80007b1c:	8082                	ret

0000000080007b1e <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80007b1e:	715d                	addi	sp,sp,-80
    80007b20:	e486                	sd	ra,72(sp)
    80007b22:	e0a2                	sd	s0,64(sp)
    80007b24:	0880                	addi	s0,sp,80
    80007b26:	fca43423          	sd	a0,-56(s0)
    80007b2a:	fcb43023          	sd	a1,-64(s0)
    80007b2e:	87b2                	mv	a5,a2
    80007b30:	faf42e23          	sw	a5,-68(s0)
  int i = 0;
    80007b34:	fe042623          	sw	zero,-20(s0)
  struct proc *pr = myproc();
    80007b38:	ffffb097          	auipc	ra,0xffffb
    80007b3c:	ee0080e7          	jalr	-288(ra) # 80002a18 <myproc>
    80007b40:	fea43023          	sd	a0,-32(s0)

  acquire(&pi->lock);
    80007b44:	fc843783          	ld	a5,-56(s0)
    80007b48:	853e                	mv	a0,a5
    80007b4a:	ffff9097          	auipc	ra,0xffff9
    80007b4e:	720080e7          	jalr	1824(ra) # 8000126a <acquire>
  while(i < n){
    80007b52:	a8d1                	j	80007c26 <pipewrite+0x108>
    if(pi->readopen == 0 || pr->killed){
    80007b54:	fc843783          	ld	a5,-56(s0)
    80007b58:	2207a783          	lw	a5,544(a5)
    80007b5c:	c789                	beqz	a5,80007b66 <pipewrite+0x48>
    80007b5e:	fe043783          	ld	a5,-32(s0)
    80007b62:	579c                	lw	a5,40(a5)
    80007b64:	cb91                	beqz	a5,80007b78 <pipewrite+0x5a>
      release(&pi->lock);
    80007b66:	fc843783          	ld	a5,-56(s0)
    80007b6a:	853e                	mv	a0,a5
    80007b6c:	ffff9097          	auipc	ra,0xffff9
    80007b70:	762080e7          	jalr	1890(ra) # 800012ce <release>
      return -1;
    80007b74:	57fd                	li	a5,-1
    80007b76:	a0ed                	j	80007c60 <pipewrite+0x142>
    }
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80007b78:	fc843783          	ld	a5,-56(s0)
    80007b7c:	21c7a703          	lw	a4,540(a5)
    80007b80:	fc843783          	ld	a5,-56(s0)
    80007b84:	2187a783          	lw	a5,536(a5)
    80007b88:	2007879b          	addiw	a5,a5,512
    80007b8c:	2781                	sext.w	a5,a5
    80007b8e:	02f71863          	bne	a4,a5,80007bbe <pipewrite+0xa0>
      wakeup(&pi->nread);
    80007b92:	fc843783          	ld	a5,-56(s0)
    80007b96:	21878793          	addi	a5,a5,536
    80007b9a:	853e                	mv	a0,a5
    80007b9c:	ffffc097          	auipc	ra,0xffffc
    80007ba0:	de2080e7          	jalr	-542(ra) # 8000397e <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80007ba4:	fc843783          	ld	a5,-56(s0)
    80007ba8:	21c78793          	addi	a5,a5,540
    80007bac:	fc843703          	ld	a4,-56(s0)
    80007bb0:	85ba                	mv	a1,a4
    80007bb2:	853e                	mv	a0,a5
    80007bb4:	ffffc097          	auipc	ra,0xffffc
    80007bb8:	d4e080e7          	jalr	-690(ra) # 80003902 <sleep>
    80007bbc:	a0ad                	j	80007c26 <pipewrite+0x108>
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80007bbe:	fe043783          	ld	a5,-32(s0)
    80007bc2:	6ba8                	ld	a0,80(a5)
    80007bc4:	fec42703          	lw	a4,-20(s0)
    80007bc8:	fc043783          	ld	a5,-64(s0)
    80007bcc:	973e                	add	a4,a4,a5
    80007bce:	fdf40793          	addi	a5,s0,-33
    80007bd2:	4685                	li	a3,1
    80007bd4:	863a                	mv	a2,a4
    80007bd6:	85be                	mv	a1,a5
    80007bd8:	ffffb097          	auipc	ra,0xffffb
    80007bdc:	8bc080e7          	jalr	-1860(ra) # 80002494 <copyin>
    80007be0:	87aa                	mv	a5,a0
    80007be2:	873e                	mv	a4,a5
    80007be4:	57fd                	li	a5,-1
    80007be6:	04f70a63          	beq	a4,a5,80007c3a <pipewrite+0x11c>
        break;
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80007bea:	fc843783          	ld	a5,-56(s0)
    80007bee:	21c7a783          	lw	a5,540(a5)
    80007bf2:	2781                	sext.w	a5,a5
    80007bf4:	0017871b          	addiw	a4,a5,1
    80007bf8:	0007069b          	sext.w	a3,a4
    80007bfc:	fc843703          	ld	a4,-56(s0)
    80007c00:	20d72e23          	sw	a3,540(a4)
    80007c04:	1ff7f793          	andi	a5,a5,511
    80007c08:	2781                	sext.w	a5,a5
    80007c0a:	fdf44703          	lbu	a4,-33(s0)
    80007c0e:	fc843683          	ld	a3,-56(s0)
    80007c12:	1782                	slli	a5,a5,0x20
    80007c14:	9381                	srli	a5,a5,0x20
    80007c16:	97b6                	add	a5,a5,a3
    80007c18:	00e78c23          	sb	a4,24(a5)
      i++;
    80007c1c:	fec42783          	lw	a5,-20(s0)
    80007c20:	2785                	addiw	a5,a5,1
    80007c22:	fef42623          	sw	a5,-20(s0)
  while(i < n){
    80007c26:	fec42783          	lw	a5,-20(s0)
    80007c2a:	873e                	mv	a4,a5
    80007c2c:	fbc42783          	lw	a5,-68(s0)
    80007c30:	2701                	sext.w	a4,a4
    80007c32:	2781                	sext.w	a5,a5
    80007c34:	f2f740e3          	blt	a4,a5,80007b54 <pipewrite+0x36>
    80007c38:	a011                	j	80007c3c <pipewrite+0x11e>
        break;
    80007c3a:	0001                	nop
    }
  }
  wakeup(&pi->nread);
    80007c3c:	fc843783          	ld	a5,-56(s0)
    80007c40:	21878793          	addi	a5,a5,536
    80007c44:	853e                	mv	a0,a5
    80007c46:	ffffc097          	auipc	ra,0xffffc
    80007c4a:	d38080e7          	jalr	-712(ra) # 8000397e <wakeup>
  release(&pi->lock);
    80007c4e:	fc843783          	ld	a5,-56(s0)
    80007c52:	853e                	mv	a0,a5
    80007c54:	ffff9097          	auipc	ra,0xffff9
    80007c58:	67a080e7          	jalr	1658(ra) # 800012ce <release>

  return i;
    80007c5c:	fec42783          	lw	a5,-20(s0)
}
    80007c60:	853e                	mv	a0,a5
    80007c62:	60a6                	ld	ra,72(sp)
    80007c64:	6406                	ld	s0,64(sp)
    80007c66:	6161                	addi	sp,sp,80
    80007c68:	8082                	ret

0000000080007c6a <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80007c6a:	715d                	addi	sp,sp,-80
    80007c6c:	e486                	sd	ra,72(sp)
    80007c6e:	e0a2                	sd	s0,64(sp)
    80007c70:	0880                	addi	s0,sp,80
    80007c72:	fca43423          	sd	a0,-56(s0)
    80007c76:	fcb43023          	sd	a1,-64(s0)
    80007c7a:	87b2                	mv	a5,a2
    80007c7c:	faf42e23          	sw	a5,-68(s0)
  int i;
  struct proc *pr = myproc();
    80007c80:	ffffb097          	auipc	ra,0xffffb
    80007c84:	d98080e7          	jalr	-616(ra) # 80002a18 <myproc>
    80007c88:	fea43023          	sd	a0,-32(s0)
  char ch;

  acquire(&pi->lock);
    80007c8c:	fc843783          	ld	a5,-56(s0)
    80007c90:	853e                	mv	a0,a5
    80007c92:	ffff9097          	auipc	ra,0xffff9
    80007c96:	5d8080e7          	jalr	1496(ra) # 8000126a <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80007c9a:	a815                	j	80007cce <piperead+0x64>
    if(pr->killed){
    80007c9c:	fe043783          	ld	a5,-32(s0)
    80007ca0:	579c                	lw	a5,40(a5)
    80007ca2:	cb91                	beqz	a5,80007cb6 <piperead+0x4c>
      release(&pi->lock);
    80007ca4:	fc843783          	ld	a5,-56(s0)
    80007ca8:	853e                	mv	a0,a5
    80007caa:	ffff9097          	auipc	ra,0xffff9
    80007cae:	624080e7          	jalr	1572(ra) # 800012ce <release>
      return -1;
    80007cb2:	57fd                	li	a5,-1
    80007cb4:	a8e5                	j	80007dac <piperead+0x142>
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80007cb6:	fc843783          	ld	a5,-56(s0)
    80007cba:	21878793          	addi	a5,a5,536
    80007cbe:	fc843703          	ld	a4,-56(s0)
    80007cc2:	85ba                	mv	a1,a4
    80007cc4:	853e                	mv	a0,a5
    80007cc6:	ffffc097          	auipc	ra,0xffffc
    80007cca:	c3c080e7          	jalr	-964(ra) # 80003902 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80007cce:	fc843783          	ld	a5,-56(s0)
    80007cd2:	2187a703          	lw	a4,536(a5)
    80007cd6:	fc843783          	ld	a5,-56(s0)
    80007cda:	21c7a783          	lw	a5,540(a5)
    80007cde:	00f71763          	bne	a4,a5,80007cec <piperead+0x82>
    80007ce2:	fc843783          	ld	a5,-56(s0)
    80007ce6:	2247a783          	lw	a5,548(a5)
    80007cea:	fbcd                	bnez	a5,80007c9c <piperead+0x32>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80007cec:	fe042623          	sw	zero,-20(s0)
    80007cf0:	a8bd                	j	80007d6e <piperead+0x104>
    if(pi->nread == pi->nwrite)
    80007cf2:	fc843783          	ld	a5,-56(s0)
    80007cf6:	2187a703          	lw	a4,536(a5)
    80007cfa:	fc843783          	ld	a5,-56(s0)
    80007cfe:	21c7a783          	lw	a5,540(a5)
    80007d02:	08f70063          	beq	a4,a5,80007d82 <piperead+0x118>
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    80007d06:	fc843783          	ld	a5,-56(s0)
    80007d0a:	2187a783          	lw	a5,536(a5)
    80007d0e:	2781                	sext.w	a5,a5
    80007d10:	0017871b          	addiw	a4,a5,1
    80007d14:	0007069b          	sext.w	a3,a4
    80007d18:	fc843703          	ld	a4,-56(s0)
    80007d1c:	20d72c23          	sw	a3,536(a4)
    80007d20:	1ff7f793          	andi	a5,a5,511
    80007d24:	2781                	sext.w	a5,a5
    80007d26:	fc843703          	ld	a4,-56(s0)
    80007d2a:	1782                	slli	a5,a5,0x20
    80007d2c:	9381                	srli	a5,a5,0x20
    80007d2e:	97ba                	add	a5,a5,a4
    80007d30:	0187c783          	lbu	a5,24(a5)
    80007d34:	fcf40fa3          	sb	a5,-33(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80007d38:	fe043783          	ld	a5,-32(s0)
    80007d3c:	6ba8                	ld	a0,80(a5)
    80007d3e:	fec42703          	lw	a4,-20(s0)
    80007d42:	fc043783          	ld	a5,-64(s0)
    80007d46:	97ba                	add	a5,a5,a4
    80007d48:	fdf40713          	addi	a4,s0,-33
    80007d4c:	4685                	li	a3,1
    80007d4e:	863a                	mv	a2,a4
    80007d50:	85be                	mv	a1,a5
    80007d52:	ffffa097          	auipc	ra,0xffffa
    80007d56:	674080e7          	jalr	1652(ra) # 800023c6 <copyout>
    80007d5a:	87aa                	mv	a5,a0
    80007d5c:	873e                	mv	a4,a5
    80007d5e:	57fd                	li	a5,-1
    80007d60:	02f70363          	beq	a4,a5,80007d86 <piperead+0x11c>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80007d64:	fec42783          	lw	a5,-20(s0)
    80007d68:	2785                	addiw	a5,a5,1
    80007d6a:	fef42623          	sw	a5,-20(s0)
    80007d6e:	fec42783          	lw	a5,-20(s0)
    80007d72:	873e                	mv	a4,a5
    80007d74:	fbc42783          	lw	a5,-68(s0)
    80007d78:	2701                	sext.w	a4,a4
    80007d7a:	2781                	sext.w	a5,a5
    80007d7c:	f6f74be3          	blt	a4,a5,80007cf2 <piperead+0x88>
    80007d80:	a021                	j	80007d88 <piperead+0x11e>
      break;
    80007d82:	0001                	nop
    80007d84:	a011                	j	80007d88 <piperead+0x11e>
      break;
    80007d86:	0001                	nop
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80007d88:	fc843783          	ld	a5,-56(s0)
    80007d8c:	21c78793          	addi	a5,a5,540
    80007d90:	853e                	mv	a0,a5
    80007d92:	ffffc097          	auipc	ra,0xffffc
    80007d96:	bec080e7          	jalr	-1044(ra) # 8000397e <wakeup>
  release(&pi->lock);
    80007d9a:	fc843783          	ld	a5,-56(s0)
    80007d9e:	853e                	mv	a0,a5
    80007da0:	ffff9097          	auipc	ra,0xffff9
    80007da4:	52e080e7          	jalr	1326(ra) # 800012ce <release>
  return i;
    80007da8:	fec42783          	lw	a5,-20(s0)
}
    80007dac:	853e                	mv	a0,a5
    80007dae:	60a6                	ld	ra,72(sp)
    80007db0:	6406                	ld	s0,64(sp)
    80007db2:	6161                	addi	sp,sp,80
    80007db4:	8082                	ret

0000000080007db6 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    80007db6:	de010113          	addi	sp,sp,-544
    80007dba:	20113c23          	sd	ra,536(sp)
    80007dbe:	20813823          	sd	s0,528(sp)
    80007dc2:	20913423          	sd	s1,520(sp)
    80007dc6:	1400                	addi	s0,sp,544
    80007dc8:	dea43423          	sd	a0,-536(s0)
    80007dcc:	deb43023          	sd	a1,-544(s0)
  char *s, *last;
  int i, off;
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80007dd0:	fa043c23          	sd	zero,-72(s0)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
    80007dd4:	fa043023          	sd	zero,-96(s0)
  struct proc *p = myproc();
    80007dd8:	ffffb097          	auipc	ra,0xffffb
    80007ddc:	c40080e7          	jalr	-960(ra) # 80002a18 <myproc>
    80007de0:	f8a43c23          	sd	a0,-104(s0)

  begin_op();
    80007de4:	fffff097          	auipc	ra,0xfffff
    80007de8:	f82080e7          	jalr	-126(ra) # 80006d66 <begin_op>

  if((ip = namei(path)) == 0){
    80007dec:	de843503          	ld	a0,-536(s0)
    80007df0:	fffff097          	auipc	ra,0xfffff
    80007df4:	c12080e7          	jalr	-1006(ra) # 80006a02 <namei>
    80007df8:	faa43423          	sd	a0,-88(s0)
    80007dfc:	fa843783          	ld	a5,-88(s0)
    80007e00:	e799                	bnez	a5,80007e0e <exec+0x58>
    end_op();
    80007e02:	fffff097          	auipc	ra,0xfffff
    80007e06:	026080e7          	jalr	38(ra) # 80006e28 <end_op>
    return -1;
    80007e0a:	57fd                	li	a5,-1
    80007e0c:	a929                	j	80008226 <exec+0x470>
  }
  ilock(ip);
    80007e0e:	fa843503          	ld	a0,-88(s0)
    80007e12:	ffffe097          	auipc	ra,0xffffe
    80007e16:	eec080e7          	jalr	-276(ra) # 80005cfe <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80007e1a:	e3040793          	addi	a5,s0,-464
    80007e1e:	04000713          	li	a4,64
    80007e22:	4681                	li	a3,0
    80007e24:	863e                	mv	a2,a5
    80007e26:	4581                	li	a1,0
    80007e28:	fa843503          	ld	a0,-88(s0)
    80007e2c:	ffffe097          	auipc	ra,0xffffe
    80007e30:	468080e7          	jalr	1128(ra) # 80006294 <readi>
    80007e34:	87aa                	mv	a5,a0
    80007e36:	873e                	mv	a4,a5
    80007e38:	04000793          	li	a5,64
    80007e3c:	36f71f63          	bne	a4,a5,800081ba <exec+0x404>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80007e40:	e3042783          	lw	a5,-464(s0)
    80007e44:	873e                	mv	a4,a5
    80007e46:	464c47b7          	lui	a5,0x464c4
    80007e4a:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80007e4e:	36f71863          	bne	a4,a5,800081be <exec+0x408>
    goto bad;

  if((pagetable = proc_pagetable(p)) == 0)
    80007e52:	f9843503          	ld	a0,-104(s0)
    80007e56:	ffffb097          	auipc	ra,0xffffb
    80007e5a:	f60080e7          	jalr	-160(ra) # 80002db6 <proc_pagetable>
    80007e5e:	faa43023          	sd	a0,-96(s0)
    80007e62:	fa043783          	ld	a5,-96(s0)
    80007e66:	34078e63          	beqz	a5,800081c2 <exec+0x40c>
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80007e6a:	fc042623          	sw	zero,-52(s0)
    80007e6e:	e5043783          	ld	a5,-432(s0)
    80007e72:	fcf42423          	sw	a5,-56(s0)
    80007e76:	a8e1                	j	80007f4e <exec+0x198>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80007e78:	df840793          	addi	a5,s0,-520
    80007e7c:	fc842683          	lw	a3,-56(s0)
    80007e80:	03800713          	li	a4,56
    80007e84:	863e                	mv	a2,a5
    80007e86:	4581                	li	a1,0
    80007e88:	fa843503          	ld	a0,-88(s0)
    80007e8c:	ffffe097          	auipc	ra,0xffffe
    80007e90:	408080e7          	jalr	1032(ra) # 80006294 <readi>
    80007e94:	87aa                	mv	a5,a0
    80007e96:	873e                	mv	a4,a5
    80007e98:	03800793          	li	a5,56
    80007e9c:	32f71563          	bne	a4,a5,800081c6 <exec+0x410>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
    80007ea0:	df842783          	lw	a5,-520(s0)
    80007ea4:	873e                	mv	a4,a5
    80007ea6:	4785                	li	a5,1
    80007ea8:	08f71663          	bne	a4,a5,80007f34 <exec+0x17e>
      continue;
    if(ph.memsz < ph.filesz)
    80007eac:	e2043703          	ld	a4,-480(s0)
    80007eb0:	e1843783          	ld	a5,-488(s0)
    80007eb4:	30f76b63          	bltu	a4,a5,800081ca <exec+0x414>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80007eb8:	e0843703          	ld	a4,-504(s0)
    80007ebc:	e2043783          	ld	a5,-480(s0)
    80007ec0:	973e                	add	a4,a4,a5
    80007ec2:	e0843783          	ld	a5,-504(s0)
    80007ec6:	30f76463          	bltu	a4,a5,800081ce <exec+0x418>
      goto bad;
    uint64 sz1;
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80007eca:	e0843703          	ld	a4,-504(s0)
    80007ece:	e2043783          	ld	a5,-480(s0)
    80007ed2:	97ba                	add	a5,a5,a4
    80007ed4:	863e                	mv	a2,a5
    80007ed6:	fb843583          	ld	a1,-72(s0)
    80007eda:	fa043503          	ld	a0,-96(s0)
    80007ede:	ffffa097          	auipc	ra,0xffffa
    80007ee2:	02a080e7          	jalr	42(ra) # 80001f08 <uvmalloc>
    80007ee6:	f6a43823          	sd	a0,-144(s0)
    80007eea:	f7043783          	ld	a5,-144(s0)
    80007eee:	2e078263          	beqz	a5,800081d2 <exec+0x41c>
      goto bad;
    sz = sz1;
    80007ef2:	f7043783          	ld	a5,-144(s0)
    80007ef6:	faf43c23          	sd	a5,-72(s0)
    if((ph.vaddr % PGSIZE) != 0)
    80007efa:	e0843703          	ld	a4,-504(s0)
    80007efe:	6785                	lui	a5,0x1
    80007f00:	17fd                	addi	a5,a5,-1
    80007f02:	8ff9                	and	a5,a5,a4
    80007f04:	2c079963          	bnez	a5,800081d6 <exec+0x420>
      goto bad;
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80007f08:	e0843783          	ld	a5,-504(s0)
    80007f0c:	e0043703          	ld	a4,-512(s0)
    80007f10:	0007069b          	sext.w	a3,a4
    80007f14:	e1843703          	ld	a4,-488(s0)
    80007f18:	2701                	sext.w	a4,a4
    80007f1a:	fa843603          	ld	a2,-88(s0)
    80007f1e:	85be                	mv	a1,a5
    80007f20:	fa043503          	ld	a0,-96(s0)
    80007f24:	00000097          	auipc	ra,0x0
    80007f28:	316080e7          	jalr	790(ra) # 8000823a <loadseg>
    80007f2c:	87aa                	mv	a5,a0
    80007f2e:	2a07c663          	bltz	a5,800081da <exec+0x424>
    80007f32:	a011                	j	80007f36 <exec+0x180>
      continue;
    80007f34:	0001                	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80007f36:	fcc42783          	lw	a5,-52(s0)
    80007f3a:	2785                	addiw	a5,a5,1
    80007f3c:	fcf42623          	sw	a5,-52(s0)
    80007f40:	fc842783          	lw	a5,-56(s0)
    80007f44:	0387879b          	addiw	a5,a5,56
    80007f48:	2781                	sext.w	a5,a5
    80007f4a:	fcf42423          	sw	a5,-56(s0)
    80007f4e:	e6845783          	lhu	a5,-408(s0)
    80007f52:	0007871b          	sext.w	a4,a5
    80007f56:	fcc42783          	lw	a5,-52(s0)
    80007f5a:	2781                	sext.w	a5,a5
    80007f5c:	f0e7cee3          	blt	a5,a4,80007e78 <exec+0xc2>
      goto bad;
  }
  iunlockput(ip);
    80007f60:	fa843503          	ld	a0,-88(s0)
    80007f64:	ffffe097          	auipc	ra,0xffffe
    80007f68:	ff8080e7          	jalr	-8(ra) # 80005f5c <iunlockput>
  end_op();
    80007f6c:	fffff097          	auipc	ra,0xfffff
    80007f70:	ebc080e7          	jalr	-324(ra) # 80006e28 <end_op>
  ip = 0;
    80007f74:	fa043423          	sd	zero,-88(s0)

  p = myproc();
    80007f78:	ffffb097          	auipc	ra,0xffffb
    80007f7c:	aa0080e7          	jalr	-1376(ra) # 80002a18 <myproc>
    80007f80:	f8a43c23          	sd	a0,-104(s0)
  uint64 oldsz = p->sz;
    80007f84:	f9843783          	ld	a5,-104(s0)
    80007f88:	67bc                	ld	a5,72(a5)
    80007f8a:	f8f43823          	sd	a5,-112(s0)

  // Allocate two pages at the next page boundary.
  // Use the second as the user stack.
  sz = PGROUNDUP(sz);
    80007f8e:	fb843703          	ld	a4,-72(s0)
    80007f92:	6785                	lui	a5,0x1
    80007f94:	17fd                	addi	a5,a5,-1
    80007f96:	973e                	add	a4,a4,a5
    80007f98:	77fd                	lui	a5,0xfffff
    80007f9a:	8ff9                	and	a5,a5,a4
    80007f9c:	faf43c23          	sd	a5,-72(s0)
  uint64 sz1;
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80007fa0:	fb843703          	ld	a4,-72(s0)
    80007fa4:	6789                	lui	a5,0x2
    80007fa6:	97ba                	add	a5,a5,a4
    80007fa8:	863e                	mv	a2,a5
    80007faa:	fb843583          	ld	a1,-72(s0)
    80007fae:	fa043503          	ld	a0,-96(s0)
    80007fb2:	ffffa097          	auipc	ra,0xffffa
    80007fb6:	f56080e7          	jalr	-170(ra) # 80001f08 <uvmalloc>
    80007fba:	f8a43423          	sd	a0,-120(s0)
    80007fbe:	f8843783          	ld	a5,-120(s0)
    80007fc2:	20078e63          	beqz	a5,800081de <exec+0x428>
    goto bad;
  sz = sz1;
    80007fc6:	f8843783          	ld	a5,-120(s0)
    80007fca:	faf43c23          	sd	a5,-72(s0)
  uvmclear(pagetable, sz-2*PGSIZE);
    80007fce:	fb843703          	ld	a4,-72(s0)
    80007fd2:	77f9                	lui	a5,0xffffe
    80007fd4:	97ba                	add	a5,a5,a4
    80007fd6:	85be                	mv	a1,a5
    80007fd8:	fa043503          	ld	a0,-96(s0)
    80007fdc:	ffffa097          	auipc	ra,0xffffa
    80007fe0:	394080e7          	jalr	916(ra) # 80002370 <uvmclear>
  sp = sz;
    80007fe4:	fb843783          	ld	a5,-72(s0)
    80007fe8:	faf43823          	sd	a5,-80(s0)
  stackbase = sp - PGSIZE;
    80007fec:	fb043703          	ld	a4,-80(s0)
    80007ff0:	77fd                	lui	a5,0xfffff
    80007ff2:	97ba                	add	a5,a5,a4
    80007ff4:	f8f43023          	sd	a5,-128(s0)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    80007ff8:	fc043023          	sd	zero,-64(s0)
    80007ffc:	a07d                	j	800080aa <exec+0x2f4>
    if(argc >= MAXARG)
    80007ffe:	fc043703          	ld	a4,-64(s0)
    80008002:	47fd                	li	a5,31
    80008004:	1ce7ef63          	bltu	a5,a4,800081e2 <exec+0x42c>
      goto bad;
    sp -= strlen(argv[argc]) + 1;
    80008008:	fc043783          	ld	a5,-64(s0)
    8000800c:	078e                	slli	a5,a5,0x3
    8000800e:	de043703          	ld	a4,-544(s0)
    80008012:	97ba                	add	a5,a5,a4
    80008014:	639c                	ld	a5,0(a5)
    80008016:	853e                	mv	a0,a5
    80008018:	ffff9097          	auipc	ra,0xffff9
    8000801c:	7a6080e7          	jalr	1958(ra) # 800017be <strlen>
    80008020:	87aa                	mv	a5,a0
    80008022:	2785                	addiw	a5,a5,1
    80008024:	2781                	sext.w	a5,a5
    80008026:	873e                	mv	a4,a5
    80008028:	fb043783          	ld	a5,-80(s0)
    8000802c:	8f99                	sub	a5,a5,a4
    8000802e:	faf43823          	sd	a5,-80(s0)
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80008032:	fb043783          	ld	a5,-80(s0)
    80008036:	9bc1                	andi	a5,a5,-16
    80008038:	faf43823          	sd	a5,-80(s0)
    if(sp < stackbase)
    8000803c:	fb043703          	ld	a4,-80(s0)
    80008040:	f8043783          	ld	a5,-128(s0)
    80008044:	1af76163          	bltu	a4,a5,800081e6 <exec+0x430>
      goto bad;
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80008048:	fc043783          	ld	a5,-64(s0)
    8000804c:	078e                	slli	a5,a5,0x3
    8000804e:	de043703          	ld	a4,-544(s0)
    80008052:	97ba                	add	a5,a5,a4
    80008054:	6384                	ld	s1,0(a5)
    80008056:	fc043783          	ld	a5,-64(s0)
    8000805a:	078e                	slli	a5,a5,0x3
    8000805c:	de043703          	ld	a4,-544(s0)
    80008060:	97ba                	add	a5,a5,a4
    80008062:	639c                	ld	a5,0(a5)
    80008064:	853e                	mv	a0,a5
    80008066:	ffff9097          	auipc	ra,0xffff9
    8000806a:	758080e7          	jalr	1880(ra) # 800017be <strlen>
    8000806e:	87aa                	mv	a5,a0
    80008070:	2785                	addiw	a5,a5,1
    80008072:	2781                	sext.w	a5,a5
    80008074:	86be                	mv	a3,a5
    80008076:	8626                	mv	a2,s1
    80008078:	fb043583          	ld	a1,-80(s0)
    8000807c:	fa043503          	ld	a0,-96(s0)
    80008080:	ffffa097          	auipc	ra,0xffffa
    80008084:	346080e7          	jalr	838(ra) # 800023c6 <copyout>
    80008088:	87aa                	mv	a5,a0
    8000808a:	1607c063          	bltz	a5,800081ea <exec+0x434>
      goto bad;
    ustack[argc] = sp;
    8000808e:	fc043783          	ld	a5,-64(s0)
    80008092:	078e                	slli	a5,a5,0x3
    80008094:	1781                	addi	a5,a5,-32
    80008096:	97a2                	add	a5,a5,s0
    80008098:	fb043703          	ld	a4,-80(s0)
    8000809c:	e8e7b823          	sd	a4,-368(a5) # ffffffffffffee90 <end+0xffffffff7fb55e90>
  for(argc = 0; argv[argc]; argc++) {
    800080a0:	fc043783          	ld	a5,-64(s0)
    800080a4:	0785                	addi	a5,a5,1
    800080a6:	fcf43023          	sd	a5,-64(s0)
    800080aa:	fc043783          	ld	a5,-64(s0)
    800080ae:	078e                	slli	a5,a5,0x3
    800080b0:	de043703          	ld	a4,-544(s0)
    800080b4:	97ba                	add	a5,a5,a4
    800080b6:	639c                	ld	a5,0(a5)
    800080b8:	f3b9                	bnez	a5,80007ffe <exec+0x248>
  }
  ustack[argc] = 0;
    800080ba:	fc043783          	ld	a5,-64(s0)
    800080be:	078e                	slli	a5,a5,0x3
    800080c0:	1781                	addi	a5,a5,-32
    800080c2:	97a2                	add	a5,a5,s0
    800080c4:	e807b823          	sd	zero,-368(a5)

  // push the array of argv[] pointers.

  sp -= sp % 16;
    800080c8:	fb043783          	ld	a5,-80(s0)
    800080cc:	9bc1                	andi	a5,a5,-16
    800080ce:	faf43823          	sd	a5,-80(s0)
  if(sp < stackbase)
    800080d2:	fb043703          	ld	a4,-80(s0)
    800080d6:	f8043783          	ld	a5,-128(s0)
    800080da:	10f76a63          	bltu	a4,a5,800081ee <exec+0x438>
    goto bad;
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    800080de:	fc043783          	ld	a5,-64(s0)
    800080e2:	0785                	addi	a5,a5,1
    800080e4:	00379713          	slli	a4,a5,0x3
    800080e8:	e7040793          	addi	a5,s0,-400
    800080ec:	86ba                	mv	a3,a4
    800080ee:	863e                	mv	a2,a5
    800080f0:	fb043583          	ld	a1,-80(s0)
    800080f4:	fa043503          	ld	a0,-96(s0)
    800080f8:	ffffa097          	auipc	ra,0xffffa
    800080fc:	2ce080e7          	jalr	718(ra) # 800023c6 <copyout>
    80008100:	87aa                	mv	a5,a0
    80008102:	0e07c863          	bltz	a5,800081f2 <exec+0x43c>
    goto bad;

  // arguments to user main(argc, argv)
  // argc is returned via the system call return
  // value, which goes in a0.
  p->trapframe->a1 = sp;
    80008106:	f9843783          	ld	a5,-104(s0)
    8000810a:	73bc                	ld	a5,96(a5)
    8000810c:	fb043703          	ld	a4,-80(s0)
    80008110:	ffb8                	sd	a4,120(a5)

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    80008112:	de843783          	ld	a5,-536(s0)
    80008116:	fcf43c23          	sd	a5,-40(s0)
    8000811a:	fd843783          	ld	a5,-40(s0)
    8000811e:	fcf43823          	sd	a5,-48(s0)
    80008122:	a025                	j	8000814a <exec+0x394>
    if(*s == '/')
    80008124:	fd843783          	ld	a5,-40(s0)
    80008128:	0007c783          	lbu	a5,0(a5)
    8000812c:	873e                	mv	a4,a5
    8000812e:	02f00793          	li	a5,47
    80008132:	00f71763          	bne	a4,a5,80008140 <exec+0x38a>
      last = s+1;
    80008136:	fd843783          	ld	a5,-40(s0)
    8000813a:	0785                	addi	a5,a5,1
    8000813c:	fcf43823          	sd	a5,-48(s0)
  for(last=s=path; *s; s++)
    80008140:	fd843783          	ld	a5,-40(s0)
    80008144:	0785                	addi	a5,a5,1
    80008146:	fcf43c23          	sd	a5,-40(s0)
    8000814a:	fd843783          	ld	a5,-40(s0)
    8000814e:	0007c783          	lbu	a5,0(a5)
    80008152:	fbe9                	bnez	a5,80008124 <exec+0x36e>
  safestrcpy(p->name, last, sizeof(p->name));
    80008154:	f9843783          	ld	a5,-104(s0)
    80008158:	16878793          	addi	a5,a5,360
    8000815c:	4641                	li	a2,16
    8000815e:	fd043583          	ld	a1,-48(s0)
    80008162:	853e                	mv	a0,a5
    80008164:	ffff9097          	auipc	ra,0xffff9
    80008168:	5de080e7          	jalr	1502(ra) # 80001742 <safestrcpy>
    
  // Commit to the user image.
  oldpagetable = p->pagetable;
    8000816c:	f9843783          	ld	a5,-104(s0)
    80008170:	6bbc                	ld	a5,80(a5)
    80008172:	f6f43c23          	sd	a5,-136(s0)
  p->pagetable = pagetable;
    80008176:	f9843783          	ld	a5,-104(s0)
    8000817a:	fa043703          	ld	a4,-96(s0)
    8000817e:	ebb8                	sd	a4,80(a5)
  p->sz = sz;
    80008180:	f9843783          	ld	a5,-104(s0)
    80008184:	fb843703          	ld	a4,-72(s0)
    80008188:	e7b8                	sd	a4,72(a5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    8000818a:	f9843783          	ld	a5,-104(s0)
    8000818e:	73bc                	ld	a5,96(a5)
    80008190:	e4843703          	ld	a4,-440(s0)
    80008194:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80008196:	f9843783          	ld	a5,-104(s0)
    8000819a:	73bc                	ld	a5,96(a5)
    8000819c:	fb043703          	ld	a4,-80(s0)
    800081a0:	fb98                	sd	a4,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800081a2:	f9043583          	ld	a1,-112(s0)
    800081a6:	f7843503          	ld	a0,-136(s0)
    800081aa:	ffffb097          	auipc	ra,0xffffb
    800081ae:	ccc080e7          	jalr	-820(ra) # 80002e76 <proc_freepagetable>

  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800081b2:	fc043783          	ld	a5,-64(s0)
    800081b6:	2781                	sext.w	a5,a5
    800081b8:	a0bd                	j	80008226 <exec+0x470>
    goto bad;
    800081ba:	0001                	nop
    800081bc:	a825                	j	800081f4 <exec+0x43e>
    goto bad;
    800081be:	0001                	nop
    800081c0:	a815                	j	800081f4 <exec+0x43e>
    goto bad;
    800081c2:	0001                	nop
    800081c4:	a805                	j	800081f4 <exec+0x43e>
      goto bad;
    800081c6:	0001                	nop
    800081c8:	a035                	j	800081f4 <exec+0x43e>
      goto bad;
    800081ca:	0001                	nop
    800081cc:	a025                	j	800081f4 <exec+0x43e>
      goto bad;
    800081ce:	0001                	nop
    800081d0:	a015                	j	800081f4 <exec+0x43e>
      goto bad;
    800081d2:	0001                	nop
    800081d4:	a005                	j	800081f4 <exec+0x43e>
      goto bad;
    800081d6:	0001                	nop
    800081d8:	a831                	j	800081f4 <exec+0x43e>
      goto bad;
    800081da:	0001                	nop
    800081dc:	a821                	j	800081f4 <exec+0x43e>
    goto bad;
    800081de:	0001                	nop
    800081e0:	a811                	j	800081f4 <exec+0x43e>
      goto bad;
    800081e2:	0001                	nop
    800081e4:	a801                	j	800081f4 <exec+0x43e>
      goto bad;
    800081e6:	0001                	nop
    800081e8:	a031                	j	800081f4 <exec+0x43e>
      goto bad;
    800081ea:	0001                	nop
    800081ec:	a021                	j	800081f4 <exec+0x43e>
    goto bad;
    800081ee:	0001                	nop
    800081f0:	a011                	j	800081f4 <exec+0x43e>
    goto bad;
    800081f2:	0001                	nop

 bad:
  if(pagetable)
    800081f4:	fa043783          	ld	a5,-96(s0)
    800081f8:	cb89                	beqz	a5,8000820a <exec+0x454>
    proc_freepagetable(pagetable, sz);
    800081fa:	fb843583          	ld	a1,-72(s0)
    800081fe:	fa043503          	ld	a0,-96(s0)
    80008202:	ffffb097          	auipc	ra,0xffffb
    80008206:	c74080e7          	jalr	-908(ra) # 80002e76 <proc_freepagetable>
  if(ip){
    8000820a:	fa843783          	ld	a5,-88(s0)
    8000820e:	cb99                	beqz	a5,80008224 <exec+0x46e>
    iunlockput(ip);
    80008210:	fa843503          	ld	a0,-88(s0)
    80008214:	ffffe097          	auipc	ra,0xffffe
    80008218:	d48080e7          	jalr	-696(ra) # 80005f5c <iunlockput>
    end_op();
    8000821c:	fffff097          	auipc	ra,0xfffff
    80008220:	c0c080e7          	jalr	-1012(ra) # 80006e28 <end_op>
  }
  return -1;
    80008224:	57fd                	li	a5,-1
}
    80008226:	853e                	mv	a0,a5
    80008228:	21813083          	ld	ra,536(sp)
    8000822c:	21013403          	ld	s0,528(sp)
    80008230:	20813483          	ld	s1,520(sp)
    80008234:	22010113          	addi	sp,sp,544
    80008238:	8082                	ret

000000008000823a <loadseg>:
// va must be page-aligned
// and the pages from va to va+sz must already be mapped.
// Returns 0 on success, -1 on failure.
static int
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
    8000823a:	7139                	addi	sp,sp,-64
    8000823c:	fc06                	sd	ra,56(sp)
    8000823e:	f822                	sd	s0,48(sp)
    80008240:	0080                	addi	s0,sp,64
    80008242:	fca43c23          	sd	a0,-40(s0)
    80008246:	fcb43823          	sd	a1,-48(s0)
    8000824a:	fcc43423          	sd	a2,-56(s0)
    8000824e:	87b6                	mv	a5,a3
    80008250:	fcf42223          	sw	a5,-60(s0)
    80008254:	87ba                	mv	a5,a4
    80008256:	fcf42023          	sw	a5,-64(s0)
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    8000825a:	fe042623          	sw	zero,-20(s0)
    8000825e:	a07d                	j	8000830c <loadseg+0xd2>
    pa = walkaddr(pagetable, va + i);
    80008260:	fec46703          	lwu	a4,-20(s0)
    80008264:	fd043783          	ld	a5,-48(s0)
    80008268:	97ba                	add	a5,a5,a4
    8000826a:	85be                	mv	a1,a5
    8000826c:	fd843503          	ld	a0,-40(s0)
    80008270:	ffffa097          	auipc	ra,0xffffa
    80008274:	924080e7          	jalr	-1756(ra) # 80001b94 <walkaddr>
    80008278:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    8000827c:	fe043783          	ld	a5,-32(s0)
    80008280:	eb89                	bnez	a5,80008292 <loadseg+0x58>
      panic("loadseg: address should exist");
    80008282:	00003517          	auipc	a0,0x3
    80008286:	4fe50513          	addi	a0,a0,1278 # 8000b780 <etext+0x780>
    8000828a:	ffff9097          	auipc	ra,0xffff9
    8000828e:	9f0080e7          	jalr	-1552(ra) # 80000c7a <panic>
    if(sz - i < PGSIZE)
    80008292:	fc042783          	lw	a5,-64(s0)
    80008296:	873e                	mv	a4,a5
    80008298:	fec42783          	lw	a5,-20(s0)
    8000829c:	40f707bb          	subw	a5,a4,a5
    800082a0:	2781                	sext.w	a5,a5
    800082a2:	873e                	mv	a4,a5
    800082a4:	6785                	lui	a5,0x1
    800082a6:	00f77c63          	bgeu	a4,a5,800082be <loadseg+0x84>
      n = sz - i;
    800082aa:	fc042783          	lw	a5,-64(s0)
    800082ae:	873e                	mv	a4,a5
    800082b0:	fec42783          	lw	a5,-20(s0)
    800082b4:	40f707bb          	subw	a5,a4,a5
    800082b8:	fef42423          	sw	a5,-24(s0)
    800082bc:	a021                	j	800082c4 <loadseg+0x8a>
    else
      n = PGSIZE;
    800082be:	6785                	lui	a5,0x1
    800082c0:	fef42423          	sw	a5,-24(s0)
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800082c4:	fc442783          	lw	a5,-60(s0)
    800082c8:	873e                	mv	a4,a5
    800082ca:	fec42783          	lw	a5,-20(s0)
    800082ce:	9fb9                	addw	a5,a5,a4
    800082d0:	2781                	sext.w	a5,a5
    800082d2:	fe842703          	lw	a4,-24(s0)
    800082d6:	86be                	mv	a3,a5
    800082d8:	fe043603          	ld	a2,-32(s0)
    800082dc:	4581                	li	a1,0
    800082de:	fc843503          	ld	a0,-56(s0)
    800082e2:	ffffe097          	auipc	ra,0xffffe
    800082e6:	fb2080e7          	jalr	-78(ra) # 80006294 <readi>
    800082ea:	87aa                	mv	a5,a0
    800082ec:	0007871b          	sext.w	a4,a5
    800082f0:	fe842783          	lw	a5,-24(s0)
    800082f4:	2781                	sext.w	a5,a5
    800082f6:	00e78463          	beq	a5,a4,800082fe <loadseg+0xc4>
      return -1;
    800082fa:	57fd                	li	a5,-1
    800082fc:	a015                	j	80008320 <loadseg+0xe6>
  for(i = 0; i < sz; i += PGSIZE){
    800082fe:	fec42783          	lw	a5,-20(s0)
    80008302:	873e                	mv	a4,a5
    80008304:	6785                	lui	a5,0x1
    80008306:	9fb9                	addw	a5,a5,a4
    80008308:	fef42623          	sw	a5,-20(s0)
    8000830c:	fec42783          	lw	a5,-20(s0)
    80008310:	873e                	mv	a4,a5
    80008312:	fc042783          	lw	a5,-64(s0)
    80008316:	2701                	sext.w	a4,a4
    80008318:	2781                	sext.w	a5,a5
    8000831a:	f4f763e3          	bltu	a4,a5,80008260 <loadseg+0x26>
  }
  
  return 0;
    8000831e:	4781                	li	a5,0
}
    80008320:	853e                	mv	a0,a5
    80008322:	70e2                	ld	ra,56(sp)
    80008324:	7442                	ld	s0,48(sp)
    80008326:	6121                	addi	sp,sp,64
    80008328:	8082                	ret

000000008000832a <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    8000832a:	7139                	addi	sp,sp,-64
    8000832c:	fc06                	sd	ra,56(sp)
    8000832e:	f822                	sd	s0,48(sp)
    80008330:	0080                	addi	s0,sp,64
    80008332:	87aa                	mv	a5,a0
    80008334:	fcb43823          	sd	a1,-48(s0)
    80008338:	fcc43423          	sd	a2,-56(s0)
    8000833c:	fcf42e23          	sw	a5,-36(s0)
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80008340:	fe440713          	addi	a4,s0,-28
    80008344:	fdc42783          	lw	a5,-36(s0)
    80008348:	85ba                	mv	a1,a4
    8000834a:	853e                	mv	a0,a5
    8000834c:	ffffc097          	auipc	ra,0xffffc
    80008350:	7fe080e7          	jalr	2046(ra) # 80004b4a <argint>
    80008354:	87aa                	mv	a5,a0
    80008356:	0007d463          	bgez	a5,8000835e <argfd+0x34>
    return -1;
    8000835a:	57fd                	li	a5,-1
    8000835c:	a8b1                	j	800083b8 <argfd+0x8e>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    8000835e:	fe442783          	lw	a5,-28(s0)
    80008362:	0207c863          	bltz	a5,80008392 <argfd+0x68>
    80008366:	fe442783          	lw	a5,-28(s0)
    8000836a:	873e                	mv	a4,a5
    8000836c:	47bd                	li	a5,15
    8000836e:	02e7c263          	blt	a5,a4,80008392 <argfd+0x68>
    80008372:	ffffa097          	auipc	ra,0xffffa
    80008376:	6a6080e7          	jalr	1702(ra) # 80002a18 <myproc>
    8000837a:	872a                	mv	a4,a0
    8000837c:	fe442783          	lw	a5,-28(s0)
    80008380:	07f1                	addi	a5,a5,28
    80008382:	078e                	slli	a5,a5,0x3
    80008384:	97ba                	add	a5,a5,a4
    80008386:	639c                	ld	a5,0(a5)
    80008388:	fef43423          	sd	a5,-24(s0)
    8000838c:	fe843783          	ld	a5,-24(s0)
    80008390:	e399                	bnez	a5,80008396 <argfd+0x6c>
    return -1;
    80008392:	57fd                	li	a5,-1
    80008394:	a015                	j	800083b8 <argfd+0x8e>
  if(pfd)
    80008396:	fd043783          	ld	a5,-48(s0)
    8000839a:	c791                	beqz	a5,800083a6 <argfd+0x7c>
    *pfd = fd;
    8000839c:	fe442703          	lw	a4,-28(s0)
    800083a0:	fd043783          	ld	a5,-48(s0)
    800083a4:	c398                	sw	a4,0(a5)
  if(pf)
    800083a6:	fc843783          	ld	a5,-56(s0)
    800083aa:	c791                	beqz	a5,800083b6 <argfd+0x8c>
    *pf = f;
    800083ac:	fc843783          	ld	a5,-56(s0)
    800083b0:	fe843703          	ld	a4,-24(s0)
    800083b4:	e398                	sd	a4,0(a5)
  return 0;
    800083b6:	4781                	li	a5,0
}
    800083b8:	853e                	mv	a0,a5
    800083ba:	70e2                	ld	ra,56(sp)
    800083bc:	7442                	ld	s0,48(sp)
    800083be:	6121                	addi	sp,sp,64
    800083c0:	8082                	ret

00000000800083c2 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800083c2:	7179                	addi	sp,sp,-48
    800083c4:	f406                	sd	ra,40(sp)
    800083c6:	f022                	sd	s0,32(sp)
    800083c8:	1800                	addi	s0,sp,48
    800083ca:	fca43c23          	sd	a0,-40(s0)
  int fd;
  struct proc *p = myproc();
    800083ce:	ffffa097          	auipc	ra,0xffffa
    800083d2:	64a080e7          	jalr	1610(ra) # 80002a18 <myproc>
    800083d6:	fea43023          	sd	a0,-32(s0)

  for(fd = 0; fd < NOFILE; fd++){
    800083da:	fe042623          	sw	zero,-20(s0)
    800083de:	a825                	j	80008416 <fdalloc+0x54>
    if(p->ofile[fd] == 0){
    800083e0:	fe043703          	ld	a4,-32(s0)
    800083e4:	fec42783          	lw	a5,-20(s0)
    800083e8:	07f1                	addi	a5,a5,28
    800083ea:	078e                	slli	a5,a5,0x3
    800083ec:	97ba                	add	a5,a5,a4
    800083ee:	639c                	ld	a5,0(a5)
    800083f0:	ef91                	bnez	a5,8000840c <fdalloc+0x4a>
      p->ofile[fd] = f;
    800083f2:	fe043703          	ld	a4,-32(s0)
    800083f6:	fec42783          	lw	a5,-20(s0)
    800083fa:	07f1                	addi	a5,a5,28
    800083fc:	078e                	slli	a5,a5,0x3
    800083fe:	97ba                	add	a5,a5,a4
    80008400:	fd843703          	ld	a4,-40(s0)
    80008404:	e398                	sd	a4,0(a5)
      return fd;
    80008406:	fec42783          	lw	a5,-20(s0)
    8000840a:	a831                	j	80008426 <fdalloc+0x64>
  for(fd = 0; fd < NOFILE; fd++){
    8000840c:	fec42783          	lw	a5,-20(s0)
    80008410:	2785                	addiw	a5,a5,1
    80008412:	fef42623          	sw	a5,-20(s0)
    80008416:	fec42783          	lw	a5,-20(s0)
    8000841a:	0007871b          	sext.w	a4,a5
    8000841e:	47bd                	li	a5,15
    80008420:	fce7d0e3          	bge	a5,a4,800083e0 <fdalloc+0x1e>
    }
  }
  return -1;
    80008424:	57fd                	li	a5,-1
}
    80008426:	853e                	mv	a0,a5
    80008428:	70a2                	ld	ra,40(sp)
    8000842a:	7402                	ld	s0,32(sp)
    8000842c:	6145                	addi	sp,sp,48
    8000842e:	8082                	ret

0000000080008430 <sys_dup>:

uint64
sys_dup(void)
{
    80008430:	1101                	addi	sp,sp,-32
    80008432:	ec06                	sd	ra,24(sp)
    80008434:	e822                	sd	s0,16(sp)
    80008436:	1000                	addi	s0,sp,32
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    80008438:	fe040793          	addi	a5,s0,-32
    8000843c:	863e                	mv	a2,a5
    8000843e:	4581                	li	a1,0
    80008440:	4501                	li	a0,0
    80008442:	00000097          	auipc	ra,0x0
    80008446:	ee8080e7          	jalr	-280(ra) # 8000832a <argfd>
    8000844a:	87aa                	mv	a5,a0
    8000844c:	0007d463          	bgez	a5,80008454 <sys_dup+0x24>
    return -1;
    80008450:	57fd                	li	a5,-1
    80008452:	a81d                	j	80008488 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
    80008454:	fe043783          	ld	a5,-32(s0)
    80008458:	853e                	mv	a0,a5
    8000845a:	00000097          	auipc	ra,0x0
    8000845e:	f68080e7          	jalr	-152(ra) # 800083c2 <fdalloc>
    80008462:	87aa                	mv	a5,a0
    80008464:	fef42623          	sw	a5,-20(s0)
    80008468:	fec42783          	lw	a5,-20(s0)
    8000846c:	2781                	sext.w	a5,a5
    8000846e:	0007d463          	bgez	a5,80008476 <sys_dup+0x46>
    return -1;
    80008472:	57fd                	li	a5,-1
    80008474:	a811                	j	80008488 <sys_dup+0x58>
  filedup(f);
    80008476:	fe043783          	ld	a5,-32(s0)
    8000847a:	853e                	mv	a0,a5
    8000847c:	fffff097          	auipc	ra,0xfffff
    80008480:	f1e080e7          	jalr	-226(ra) # 8000739a <filedup>
  return fd;
    80008484:	fec42783          	lw	a5,-20(s0)
}
    80008488:	853e                	mv	a0,a5
    8000848a:	60e2                	ld	ra,24(sp)
    8000848c:	6442                	ld	s0,16(sp)
    8000848e:	6105                	addi	sp,sp,32
    80008490:	8082                	ret

0000000080008492 <sys_read>:

uint64
sys_read(void)
{
    80008492:	7179                	addi	sp,sp,-48
    80008494:	f406                	sd	ra,40(sp)
    80008496:	f022                	sd	s0,32(sp)
    80008498:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000849a:	fe840793          	addi	a5,s0,-24
    8000849e:	863e                	mv	a2,a5
    800084a0:	4581                	li	a1,0
    800084a2:	4501                	li	a0,0
    800084a4:	00000097          	auipc	ra,0x0
    800084a8:	e86080e7          	jalr	-378(ra) # 8000832a <argfd>
    800084ac:	87aa                	mv	a5,a0
    800084ae:	0207c863          	bltz	a5,800084de <sys_read+0x4c>
    800084b2:	fe440793          	addi	a5,s0,-28
    800084b6:	85be                	mv	a1,a5
    800084b8:	4509                	li	a0,2
    800084ba:	ffffc097          	auipc	ra,0xffffc
    800084be:	690080e7          	jalr	1680(ra) # 80004b4a <argint>
    800084c2:	87aa                	mv	a5,a0
    800084c4:	0007cd63          	bltz	a5,800084de <sys_read+0x4c>
    800084c8:	fd840793          	addi	a5,s0,-40
    800084cc:	85be                	mv	a1,a5
    800084ce:	4505                	li	a0,1
    800084d0:	ffffc097          	auipc	ra,0xffffc
    800084d4:	6b2080e7          	jalr	1714(ra) # 80004b82 <argaddr>
    800084d8:	87aa                	mv	a5,a0
    800084da:	0007d463          	bgez	a5,800084e2 <sys_read+0x50>
    return -1;
    800084de:	57fd                	li	a5,-1
    800084e0:	a839                	j	800084fe <sys_read+0x6c>
  return fileread(f, p, n);
    800084e2:	fe843783          	ld	a5,-24(s0)
    800084e6:	fd843703          	ld	a4,-40(s0)
    800084ea:	fe442683          	lw	a3,-28(s0)
    800084ee:	8636                	mv	a2,a3
    800084f0:	85ba                	mv	a1,a4
    800084f2:	853e                	mv	a0,a5
    800084f4:	fffff097          	auipc	ra,0xfffff
    800084f8:	0b8080e7          	jalr	184(ra) # 800075ac <fileread>
    800084fc:	87aa                	mv	a5,a0
}
    800084fe:	853e                	mv	a0,a5
    80008500:	70a2                	ld	ra,40(sp)
    80008502:	7402                	ld	s0,32(sp)
    80008504:	6145                	addi	sp,sp,48
    80008506:	8082                	ret

0000000080008508 <sys_write>:

uint64
sys_write(void)
{
    80008508:	7179                	addi	sp,sp,-48
    8000850a:	f406                	sd	ra,40(sp)
    8000850c:	f022                	sd	s0,32(sp)
    8000850e:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80008510:	fe840793          	addi	a5,s0,-24
    80008514:	863e                	mv	a2,a5
    80008516:	4581                	li	a1,0
    80008518:	4501                	li	a0,0
    8000851a:	00000097          	auipc	ra,0x0
    8000851e:	e10080e7          	jalr	-496(ra) # 8000832a <argfd>
    80008522:	87aa                	mv	a5,a0
    80008524:	0207c863          	bltz	a5,80008554 <sys_write+0x4c>
    80008528:	fe440793          	addi	a5,s0,-28
    8000852c:	85be                	mv	a1,a5
    8000852e:	4509                	li	a0,2
    80008530:	ffffc097          	auipc	ra,0xffffc
    80008534:	61a080e7          	jalr	1562(ra) # 80004b4a <argint>
    80008538:	87aa                	mv	a5,a0
    8000853a:	0007cd63          	bltz	a5,80008554 <sys_write+0x4c>
    8000853e:	fd840793          	addi	a5,s0,-40
    80008542:	85be                	mv	a1,a5
    80008544:	4505                	li	a0,1
    80008546:	ffffc097          	auipc	ra,0xffffc
    8000854a:	63c080e7          	jalr	1596(ra) # 80004b82 <argaddr>
    8000854e:	87aa                	mv	a5,a0
    80008550:	0007d463          	bgez	a5,80008558 <sys_write+0x50>
    return -1;
    80008554:	57fd                	li	a5,-1
    80008556:	a839                	j	80008574 <sys_write+0x6c>

  return filewrite(f, p, n);
    80008558:	fe843783          	ld	a5,-24(s0)
    8000855c:	fd843703          	ld	a4,-40(s0)
    80008560:	fe442683          	lw	a3,-28(s0)
    80008564:	8636                	mv	a2,a3
    80008566:	85ba                	mv	a1,a4
    80008568:	853e                	mv	a0,a5
    8000856a:	fffff097          	auipc	ra,0xfffff
    8000856e:	1a8080e7          	jalr	424(ra) # 80007712 <filewrite>
    80008572:	87aa                	mv	a5,a0
}
    80008574:	853e                	mv	a0,a5
    80008576:	70a2                	ld	ra,40(sp)
    80008578:	7402                	ld	s0,32(sp)
    8000857a:	6145                	addi	sp,sp,48
    8000857c:	8082                	ret

000000008000857e <sys_close>:

uint64
sys_close(void)
{
    8000857e:	1101                	addi	sp,sp,-32
    80008580:	ec06                	sd	ra,24(sp)
    80008582:	e822                	sd	s0,16(sp)
    80008584:	1000                	addi	s0,sp,32
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    80008586:	fe040713          	addi	a4,s0,-32
    8000858a:	fec40793          	addi	a5,s0,-20
    8000858e:	863a                	mv	a2,a4
    80008590:	85be                	mv	a1,a5
    80008592:	4501                	li	a0,0
    80008594:	00000097          	auipc	ra,0x0
    80008598:	d96080e7          	jalr	-618(ra) # 8000832a <argfd>
    8000859c:	87aa                	mv	a5,a0
    8000859e:	0007d463          	bgez	a5,800085a6 <sys_close+0x28>
    return -1;
    800085a2:	57fd                	li	a5,-1
    800085a4:	a02d                	j	800085ce <sys_close+0x50>
  myproc()->ofile[fd] = 0;
    800085a6:	ffffa097          	auipc	ra,0xffffa
    800085aa:	472080e7          	jalr	1138(ra) # 80002a18 <myproc>
    800085ae:	872a                	mv	a4,a0
    800085b0:	fec42783          	lw	a5,-20(s0)
    800085b4:	07f1                	addi	a5,a5,28
    800085b6:	078e                	slli	a5,a5,0x3
    800085b8:	97ba                	add	a5,a5,a4
    800085ba:	0007b023          	sd	zero,0(a5) # 1000 <_entry-0x7ffff000>
  fileclose(f);
    800085be:	fe043783          	ld	a5,-32(s0)
    800085c2:	853e                	mv	a0,a5
    800085c4:	fffff097          	auipc	ra,0xfffff
    800085c8:	e3c080e7          	jalr	-452(ra) # 80007400 <fileclose>
  return 0;
    800085cc:	4781                	li	a5,0
}
    800085ce:	853e                	mv	a0,a5
    800085d0:	60e2                	ld	ra,24(sp)
    800085d2:	6442                	ld	s0,16(sp)
    800085d4:	6105                	addi	sp,sp,32
    800085d6:	8082                	ret

00000000800085d8 <sys_fstat>:

uint64
sys_fstat(void)
{
    800085d8:	1101                	addi	sp,sp,-32
    800085da:	ec06                	sd	ra,24(sp)
    800085dc:	e822                	sd	s0,16(sp)
    800085de:	1000                	addi	s0,sp,32
  struct file *f;
  uint64 st; // user pointer to struct stat

  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800085e0:	fe840793          	addi	a5,s0,-24
    800085e4:	863e                	mv	a2,a5
    800085e6:	4581                	li	a1,0
    800085e8:	4501                	li	a0,0
    800085ea:	00000097          	auipc	ra,0x0
    800085ee:	d40080e7          	jalr	-704(ra) # 8000832a <argfd>
    800085f2:	87aa                	mv	a5,a0
    800085f4:	0007cd63          	bltz	a5,8000860e <sys_fstat+0x36>
    800085f8:	fe040793          	addi	a5,s0,-32
    800085fc:	85be                	mv	a1,a5
    800085fe:	4505                	li	a0,1
    80008600:	ffffc097          	auipc	ra,0xffffc
    80008604:	582080e7          	jalr	1410(ra) # 80004b82 <argaddr>
    80008608:	87aa                	mv	a5,a0
    8000860a:	0007d463          	bgez	a5,80008612 <sys_fstat+0x3a>
    return -1;
    8000860e:	57fd                	li	a5,-1
    80008610:	a821                	j	80008628 <sys_fstat+0x50>
  return filestat(f, st);
    80008612:	fe843783          	ld	a5,-24(s0)
    80008616:	fe043703          	ld	a4,-32(s0)
    8000861a:	85ba                	mv	a1,a4
    8000861c:	853e                	mv	a0,a5
    8000861e:	fffff097          	auipc	ra,0xfffff
    80008622:	eea080e7          	jalr	-278(ra) # 80007508 <filestat>
    80008626:	87aa                	mv	a5,a0
}
    80008628:	853e                	mv	a0,a5
    8000862a:	60e2                	ld	ra,24(sp)
    8000862c:	6442                	ld	s0,16(sp)
    8000862e:	6105                	addi	sp,sp,32
    80008630:	8082                	ret

0000000080008632 <sys_link>:

// Create the path new as a link to the same inode as old.
uint64
sys_link(void)
{
    80008632:	7169                	addi	sp,sp,-304
    80008634:	f606                	sd	ra,296(sp)
    80008636:	f222                	sd	s0,288(sp)
    80008638:	1a00                	addi	s0,sp,304
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;

  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000863a:	ed040793          	addi	a5,s0,-304
    8000863e:	08000613          	li	a2,128
    80008642:	85be                	mv	a1,a5
    80008644:	4501                	li	a0,0
    80008646:	ffffc097          	auipc	ra,0xffffc
    8000864a:	570080e7          	jalr	1392(ra) # 80004bb6 <argstr>
    8000864e:	87aa                	mv	a5,a0
    80008650:	0007cf63          	bltz	a5,8000866e <sys_link+0x3c>
    80008654:	f5040793          	addi	a5,s0,-176
    80008658:	08000613          	li	a2,128
    8000865c:	85be                	mv	a1,a5
    8000865e:	4505                	li	a0,1
    80008660:	ffffc097          	auipc	ra,0xffffc
    80008664:	556080e7          	jalr	1366(ra) # 80004bb6 <argstr>
    80008668:	87aa                	mv	a5,a0
    8000866a:	0007d463          	bgez	a5,80008672 <sys_link+0x40>
    return -1;
    8000866e:	57fd                	li	a5,-1
    80008670:	aab5                	j	800087ec <sys_link+0x1ba>

  begin_op();
    80008672:	ffffe097          	auipc	ra,0xffffe
    80008676:	6f4080e7          	jalr	1780(ra) # 80006d66 <begin_op>
  if((ip = namei(old)) == 0){
    8000867a:	ed040793          	addi	a5,s0,-304
    8000867e:	853e                	mv	a0,a5
    80008680:	ffffe097          	auipc	ra,0xffffe
    80008684:	382080e7          	jalr	898(ra) # 80006a02 <namei>
    80008688:	fea43423          	sd	a0,-24(s0)
    8000868c:	fe843783          	ld	a5,-24(s0)
    80008690:	e799                	bnez	a5,8000869e <sys_link+0x6c>
    end_op();
    80008692:	ffffe097          	auipc	ra,0xffffe
    80008696:	796080e7          	jalr	1942(ra) # 80006e28 <end_op>
    return -1;
    8000869a:	57fd                	li	a5,-1
    8000869c:	aa81                	j	800087ec <sys_link+0x1ba>
  }

  ilock(ip);
    8000869e:	fe843503          	ld	a0,-24(s0)
    800086a2:	ffffd097          	auipc	ra,0xffffd
    800086a6:	65c080e7          	jalr	1628(ra) # 80005cfe <ilock>
  if(ip->type == T_DIR){
    800086aa:	fe843783          	ld	a5,-24(s0)
    800086ae:	04479783          	lh	a5,68(a5)
    800086b2:	0007871b          	sext.w	a4,a5
    800086b6:	4785                	li	a5,1
    800086b8:	00f71e63          	bne	a4,a5,800086d4 <sys_link+0xa2>
    iunlockput(ip);
    800086bc:	fe843503          	ld	a0,-24(s0)
    800086c0:	ffffe097          	auipc	ra,0xffffe
    800086c4:	89c080e7          	jalr	-1892(ra) # 80005f5c <iunlockput>
    end_op();
    800086c8:	ffffe097          	auipc	ra,0xffffe
    800086cc:	760080e7          	jalr	1888(ra) # 80006e28 <end_op>
    return -1;
    800086d0:	57fd                	li	a5,-1
    800086d2:	aa29                	j	800087ec <sys_link+0x1ba>
  }

  ip->nlink++;
    800086d4:	fe843783          	ld	a5,-24(s0)
    800086d8:	04a79783          	lh	a5,74(a5)
    800086dc:	17c2                	slli	a5,a5,0x30
    800086de:	93c1                	srli	a5,a5,0x30
    800086e0:	2785                	addiw	a5,a5,1
    800086e2:	17c2                	slli	a5,a5,0x30
    800086e4:	93c1                	srli	a5,a5,0x30
    800086e6:	0107971b          	slliw	a4,a5,0x10
    800086ea:	4107571b          	sraiw	a4,a4,0x10
    800086ee:	fe843783          	ld	a5,-24(s0)
    800086f2:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    800086f6:	fe843503          	ld	a0,-24(s0)
    800086fa:	ffffd097          	auipc	ra,0xffffd
    800086fe:	3b4080e7          	jalr	948(ra) # 80005aae <iupdate>
  iunlock(ip);
    80008702:	fe843503          	ld	a0,-24(s0)
    80008706:	ffffd097          	auipc	ra,0xffffd
    8000870a:	72c080e7          	jalr	1836(ra) # 80005e32 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
    8000870e:	fd040713          	addi	a4,s0,-48
    80008712:	f5040793          	addi	a5,s0,-176
    80008716:	85ba                	mv	a1,a4
    80008718:	853e                	mv	a0,a5
    8000871a:	ffffe097          	auipc	ra,0xffffe
    8000871e:	314080e7          	jalr	788(ra) # 80006a2e <nameiparent>
    80008722:	fea43023          	sd	a0,-32(s0)
    80008726:	fe043783          	ld	a5,-32(s0)
    8000872a:	cba5                	beqz	a5,8000879a <sys_link+0x168>
    goto bad;
  ilock(dp);
    8000872c:	fe043503          	ld	a0,-32(s0)
    80008730:	ffffd097          	auipc	ra,0xffffd
    80008734:	5ce080e7          	jalr	1486(ra) # 80005cfe <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80008738:	fe043783          	ld	a5,-32(s0)
    8000873c:	4398                	lw	a4,0(a5)
    8000873e:	fe843783          	ld	a5,-24(s0)
    80008742:	439c                	lw	a5,0(a5)
    80008744:	02f71263          	bne	a4,a5,80008768 <sys_link+0x136>
    80008748:	fe843783          	ld	a5,-24(s0)
    8000874c:	43d8                	lw	a4,4(a5)
    8000874e:	fd040793          	addi	a5,s0,-48
    80008752:	863a                	mv	a2,a4
    80008754:	85be                	mv	a1,a5
    80008756:	fe043503          	ld	a0,-32(s0)
    8000875a:	ffffe097          	auipc	ra,0xffffe
    8000875e:	f8e080e7          	jalr	-114(ra) # 800066e8 <dirlink>
    80008762:	87aa                	mv	a5,a0
    80008764:	0007d963          	bgez	a5,80008776 <sys_link+0x144>
    iunlockput(dp);
    80008768:	fe043503          	ld	a0,-32(s0)
    8000876c:	ffffd097          	auipc	ra,0xffffd
    80008770:	7f0080e7          	jalr	2032(ra) # 80005f5c <iunlockput>
    goto bad;
    80008774:	a025                	j	8000879c <sys_link+0x16a>
  }
  iunlockput(dp);
    80008776:	fe043503          	ld	a0,-32(s0)
    8000877a:	ffffd097          	auipc	ra,0xffffd
    8000877e:	7e2080e7          	jalr	2018(ra) # 80005f5c <iunlockput>
  iput(ip);
    80008782:	fe843503          	ld	a0,-24(s0)
    80008786:	ffffd097          	auipc	ra,0xffffd
    8000878a:	706080e7          	jalr	1798(ra) # 80005e8c <iput>

  end_op();
    8000878e:	ffffe097          	auipc	ra,0xffffe
    80008792:	69a080e7          	jalr	1690(ra) # 80006e28 <end_op>

  return 0;
    80008796:	4781                	li	a5,0
    80008798:	a891                	j	800087ec <sys_link+0x1ba>
    goto bad;
    8000879a:	0001                	nop

bad:
  ilock(ip);
    8000879c:	fe843503          	ld	a0,-24(s0)
    800087a0:	ffffd097          	auipc	ra,0xffffd
    800087a4:	55e080e7          	jalr	1374(ra) # 80005cfe <ilock>
  ip->nlink--;
    800087a8:	fe843783          	ld	a5,-24(s0)
    800087ac:	04a79783          	lh	a5,74(a5)
    800087b0:	17c2                	slli	a5,a5,0x30
    800087b2:	93c1                	srli	a5,a5,0x30
    800087b4:	37fd                	addiw	a5,a5,-1
    800087b6:	17c2                	slli	a5,a5,0x30
    800087b8:	93c1                	srli	a5,a5,0x30
    800087ba:	0107971b          	slliw	a4,a5,0x10
    800087be:	4107571b          	sraiw	a4,a4,0x10
    800087c2:	fe843783          	ld	a5,-24(s0)
    800087c6:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    800087ca:	fe843503          	ld	a0,-24(s0)
    800087ce:	ffffd097          	auipc	ra,0xffffd
    800087d2:	2e0080e7          	jalr	736(ra) # 80005aae <iupdate>
  iunlockput(ip);
    800087d6:	fe843503          	ld	a0,-24(s0)
    800087da:	ffffd097          	auipc	ra,0xffffd
    800087de:	782080e7          	jalr	1922(ra) # 80005f5c <iunlockput>
  end_op();
    800087e2:	ffffe097          	auipc	ra,0xffffe
    800087e6:	646080e7          	jalr	1606(ra) # 80006e28 <end_op>
  return -1;
    800087ea:	57fd                	li	a5,-1
}
    800087ec:	853e                	mv	a0,a5
    800087ee:	70b2                	ld	ra,296(sp)
    800087f0:	7412                	ld	s0,288(sp)
    800087f2:	6155                	addi	sp,sp,304
    800087f4:	8082                	ret

00000000800087f6 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
    800087f6:	7139                	addi	sp,sp,-64
    800087f8:	fc06                	sd	ra,56(sp)
    800087fa:	f822                	sd	s0,48(sp)
    800087fc:	0080                	addi	s0,sp,64
    800087fe:	fca43423          	sd	a0,-56(s0)
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80008802:	02000793          	li	a5,32
    80008806:	fef42623          	sw	a5,-20(s0)
    8000880a:	a0b1                	j	80008856 <isdirempty+0x60>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000880c:	fd840793          	addi	a5,s0,-40
    80008810:	fec42683          	lw	a3,-20(s0)
    80008814:	4741                	li	a4,16
    80008816:	863e                	mv	a2,a5
    80008818:	4581                	li	a1,0
    8000881a:	fc843503          	ld	a0,-56(s0)
    8000881e:	ffffe097          	auipc	ra,0xffffe
    80008822:	a76080e7          	jalr	-1418(ra) # 80006294 <readi>
    80008826:	87aa                	mv	a5,a0
    80008828:	873e                	mv	a4,a5
    8000882a:	47c1                	li	a5,16
    8000882c:	00f70a63          	beq	a4,a5,80008840 <isdirempty+0x4a>
      panic("isdirempty: readi");
    80008830:	00003517          	auipc	a0,0x3
    80008834:	f7050513          	addi	a0,a0,-144 # 8000b7a0 <etext+0x7a0>
    80008838:	ffff8097          	auipc	ra,0xffff8
    8000883c:	442080e7          	jalr	1090(ra) # 80000c7a <panic>
    if(de.inum != 0)
    80008840:	fd845783          	lhu	a5,-40(s0)
    80008844:	c399                	beqz	a5,8000884a <isdirempty+0x54>
      return 0;
    80008846:	4781                	li	a5,0
    80008848:	a839                	j	80008866 <isdirempty+0x70>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    8000884a:	fec42783          	lw	a5,-20(s0)
    8000884e:	27c1                	addiw	a5,a5,16
    80008850:	2781                	sext.w	a5,a5
    80008852:	fef42623          	sw	a5,-20(s0)
    80008856:	fc843783          	ld	a5,-56(s0)
    8000885a:	47f8                	lw	a4,76(a5)
    8000885c:	fec42783          	lw	a5,-20(s0)
    80008860:	fae7e6e3          	bltu	a5,a4,8000880c <isdirempty+0x16>
  }
  return 1;
    80008864:	4785                	li	a5,1
}
    80008866:	853e                	mv	a0,a5
    80008868:	70e2                	ld	ra,56(sp)
    8000886a:	7442                	ld	s0,48(sp)
    8000886c:	6121                	addi	sp,sp,64
    8000886e:	8082                	ret

0000000080008870 <sys_unlink>:

uint64
sys_unlink(void)
{
    80008870:	7155                	addi	sp,sp,-208
    80008872:	e586                	sd	ra,200(sp)
    80008874:	e1a2                	sd	s0,192(sp)
    80008876:	0980                	addi	s0,sp,208
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;

  if(argstr(0, path, MAXPATH) < 0)
    80008878:	f4040793          	addi	a5,s0,-192
    8000887c:	08000613          	li	a2,128
    80008880:	85be                	mv	a1,a5
    80008882:	4501                	li	a0,0
    80008884:	ffffc097          	auipc	ra,0xffffc
    80008888:	332080e7          	jalr	818(ra) # 80004bb6 <argstr>
    8000888c:	87aa                	mv	a5,a0
    8000888e:	0007d463          	bgez	a5,80008896 <sys_unlink+0x26>
    return -1;
    80008892:	57fd                	li	a5,-1
    80008894:	a2ed                	j	80008a7e <sys_unlink+0x20e>

  begin_op();
    80008896:	ffffe097          	auipc	ra,0xffffe
    8000889a:	4d0080e7          	jalr	1232(ra) # 80006d66 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    8000889e:	fc040713          	addi	a4,s0,-64
    800088a2:	f4040793          	addi	a5,s0,-192
    800088a6:	85ba                	mv	a1,a4
    800088a8:	853e                	mv	a0,a5
    800088aa:	ffffe097          	auipc	ra,0xffffe
    800088ae:	184080e7          	jalr	388(ra) # 80006a2e <nameiparent>
    800088b2:	fea43423          	sd	a0,-24(s0)
    800088b6:	fe843783          	ld	a5,-24(s0)
    800088ba:	e799                	bnez	a5,800088c8 <sys_unlink+0x58>
    end_op();
    800088bc:	ffffe097          	auipc	ra,0xffffe
    800088c0:	56c080e7          	jalr	1388(ra) # 80006e28 <end_op>
    return -1;
    800088c4:	57fd                	li	a5,-1
    800088c6:	aa65                	j	80008a7e <sys_unlink+0x20e>
  }

  ilock(dp);
    800088c8:	fe843503          	ld	a0,-24(s0)
    800088cc:	ffffd097          	auipc	ra,0xffffd
    800088d0:	432080e7          	jalr	1074(ra) # 80005cfe <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    800088d4:	fc040793          	addi	a5,s0,-64
    800088d8:	00003597          	auipc	a1,0x3
    800088dc:	ee058593          	addi	a1,a1,-288 # 8000b7b8 <etext+0x7b8>
    800088e0:	853e                	mv	a0,a5
    800088e2:	ffffe097          	auipc	ra,0xffffe
    800088e6:	cf0080e7          	jalr	-784(ra) # 800065d2 <namecmp>
    800088ea:	87aa                	mv	a5,a0
    800088ec:	16078b63          	beqz	a5,80008a62 <sys_unlink+0x1f2>
    800088f0:	fc040793          	addi	a5,s0,-64
    800088f4:	00003597          	auipc	a1,0x3
    800088f8:	ecc58593          	addi	a1,a1,-308 # 8000b7c0 <etext+0x7c0>
    800088fc:	853e                	mv	a0,a5
    800088fe:	ffffe097          	auipc	ra,0xffffe
    80008902:	cd4080e7          	jalr	-812(ra) # 800065d2 <namecmp>
    80008906:	87aa                	mv	a5,a0
    80008908:	14078d63          	beqz	a5,80008a62 <sys_unlink+0x1f2>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    8000890c:	f3c40713          	addi	a4,s0,-196
    80008910:	fc040793          	addi	a5,s0,-64
    80008914:	863a                	mv	a2,a4
    80008916:	85be                	mv	a1,a5
    80008918:	fe843503          	ld	a0,-24(s0)
    8000891c:	ffffe097          	auipc	ra,0xffffe
    80008920:	ce4080e7          	jalr	-796(ra) # 80006600 <dirlookup>
    80008924:	fea43023          	sd	a0,-32(s0)
    80008928:	fe043783          	ld	a5,-32(s0)
    8000892c:	12078d63          	beqz	a5,80008a66 <sys_unlink+0x1f6>
    goto bad;
  ilock(ip);
    80008930:	fe043503          	ld	a0,-32(s0)
    80008934:	ffffd097          	auipc	ra,0xffffd
    80008938:	3ca080e7          	jalr	970(ra) # 80005cfe <ilock>

  if(ip->nlink < 1)
    8000893c:	fe043783          	ld	a5,-32(s0)
    80008940:	04a79783          	lh	a5,74(a5)
    80008944:	2781                	sext.w	a5,a5
    80008946:	00f04a63          	bgtz	a5,8000895a <sys_unlink+0xea>
    panic("unlink: nlink < 1");
    8000894a:	00003517          	auipc	a0,0x3
    8000894e:	e7e50513          	addi	a0,a0,-386 # 8000b7c8 <etext+0x7c8>
    80008952:	ffff8097          	auipc	ra,0xffff8
    80008956:	328080e7          	jalr	808(ra) # 80000c7a <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
    8000895a:	fe043783          	ld	a5,-32(s0)
    8000895e:	04479783          	lh	a5,68(a5)
    80008962:	0007871b          	sext.w	a4,a5
    80008966:	4785                	li	a5,1
    80008968:	02f71163          	bne	a4,a5,8000898a <sys_unlink+0x11a>
    8000896c:	fe043503          	ld	a0,-32(s0)
    80008970:	00000097          	auipc	ra,0x0
    80008974:	e86080e7          	jalr	-378(ra) # 800087f6 <isdirempty>
    80008978:	87aa                	mv	a5,a0
    8000897a:	eb81                	bnez	a5,8000898a <sys_unlink+0x11a>
    iunlockput(ip);
    8000897c:	fe043503          	ld	a0,-32(s0)
    80008980:	ffffd097          	auipc	ra,0xffffd
    80008984:	5dc080e7          	jalr	1500(ra) # 80005f5c <iunlockput>
    goto bad;
    80008988:	a0c5                	j	80008a68 <sys_unlink+0x1f8>
  }

  memset(&de, 0, sizeof(de));
    8000898a:	fd040793          	addi	a5,s0,-48
    8000898e:	4641                	li	a2,16
    80008990:	4581                	li	a1,0
    80008992:	853e                	mv	a0,a5
    80008994:	ffff9097          	auipc	ra,0xffff9
    80008998:	aaa080e7          	jalr	-1366(ra) # 8000143e <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000899c:	fd040793          	addi	a5,s0,-48
    800089a0:	f3c42683          	lw	a3,-196(s0)
    800089a4:	4741                	li	a4,16
    800089a6:	863e                	mv	a2,a5
    800089a8:	4581                	li	a1,0
    800089aa:	fe843503          	ld	a0,-24(s0)
    800089ae:	ffffe097          	auipc	ra,0xffffe
    800089b2:	a76080e7          	jalr	-1418(ra) # 80006424 <writei>
    800089b6:	87aa                	mv	a5,a0
    800089b8:	873e                	mv	a4,a5
    800089ba:	47c1                	li	a5,16
    800089bc:	00f70a63          	beq	a4,a5,800089d0 <sys_unlink+0x160>
    panic("unlink: writei");
    800089c0:	00003517          	auipc	a0,0x3
    800089c4:	e2050513          	addi	a0,a0,-480 # 8000b7e0 <etext+0x7e0>
    800089c8:	ffff8097          	auipc	ra,0xffff8
    800089cc:	2b2080e7          	jalr	690(ra) # 80000c7a <panic>
  if(ip->type == T_DIR){
    800089d0:	fe043783          	ld	a5,-32(s0)
    800089d4:	04479783          	lh	a5,68(a5)
    800089d8:	0007871b          	sext.w	a4,a5
    800089dc:	4785                	li	a5,1
    800089de:	02f71963          	bne	a4,a5,80008a10 <sys_unlink+0x1a0>
    dp->nlink--;
    800089e2:	fe843783          	ld	a5,-24(s0)
    800089e6:	04a79783          	lh	a5,74(a5)
    800089ea:	17c2                	slli	a5,a5,0x30
    800089ec:	93c1                	srli	a5,a5,0x30
    800089ee:	37fd                	addiw	a5,a5,-1
    800089f0:	17c2                	slli	a5,a5,0x30
    800089f2:	93c1                	srli	a5,a5,0x30
    800089f4:	0107971b          	slliw	a4,a5,0x10
    800089f8:	4107571b          	sraiw	a4,a4,0x10
    800089fc:	fe843783          	ld	a5,-24(s0)
    80008a00:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80008a04:	fe843503          	ld	a0,-24(s0)
    80008a08:	ffffd097          	auipc	ra,0xffffd
    80008a0c:	0a6080e7          	jalr	166(ra) # 80005aae <iupdate>
  }
  iunlockput(dp);
    80008a10:	fe843503          	ld	a0,-24(s0)
    80008a14:	ffffd097          	auipc	ra,0xffffd
    80008a18:	548080e7          	jalr	1352(ra) # 80005f5c <iunlockput>

  ip->nlink--;
    80008a1c:	fe043783          	ld	a5,-32(s0)
    80008a20:	04a79783          	lh	a5,74(a5)
    80008a24:	17c2                	slli	a5,a5,0x30
    80008a26:	93c1                	srli	a5,a5,0x30
    80008a28:	37fd                	addiw	a5,a5,-1
    80008a2a:	17c2                	slli	a5,a5,0x30
    80008a2c:	93c1                	srli	a5,a5,0x30
    80008a2e:	0107971b          	slliw	a4,a5,0x10
    80008a32:	4107571b          	sraiw	a4,a4,0x10
    80008a36:	fe043783          	ld	a5,-32(s0)
    80008a3a:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80008a3e:	fe043503          	ld	a0,-32(s0)
    80008a42:	ffffd097          	auipc	ra,0xffffd
    80008a46:	06c080e7          	jalr	108(ra) # 80005aae <iupdate>
  iunlockput(ip);
    80008a4a:	fe043503          	ld	a0,-32(s0)
    80008a4e:	ffffd097          	auipc	ra,0xffffd
    80008a52:	50e080e7          	jalr	1294(ra) # 80005f5c <iunlockput>

  end_op();
    80008a56:	ffffe097          	auipc	ra,0xffffe
    80008a5a:	3d2080e7          	jalr	978(ra) # 80006e28 <end_op>

  return 0;
    80008a5e:	4781                	li	a5,0
    80008a60:	a839                	j	80008a7e <sys_unlink+0x20e>
    goto bad;
    80008a62:	0001                	nop
    80008a64:	a011                	j	80008a68 <sys_unlink+0x1f8>
    goto bad;
    80008a66:	0001                	nop

bad:
  iunlockput(dp);
    80008a68:	fe843503          	ld	a0,-24(s0)
    80008a6c:	ffffd097          	auipc	ra,0xffffd
    80008a70:	4f0080e7          	jalr	1264(ra) # 80005f5c <iunlockput>
  end_op();
    80008a74:	ffffe097          	auipc	ra,0xffffe
    80008a78:	3b4080e7          	jalr	948(ra) # 80006e28 <end_op>
  return -1;
    80008a7c:	57fd                	li	a5,-1
}
    80008a7e:	853e                	mv	a0,a5
    80008a80:	60ae                	ld	ra,200(sp)
    80008a82:	640e                	ld	s0,192(sp)
    80008a84:	6169                	addi	sp,sp,208
    80008a86:	8082                	ret

0000000080008a88 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
    80008a88:	7139                	addi	sp,sp,-64
    80008a8a:	fc06                	sd	ra,56(sp)
    80008a8c:	f822                	sd	s0,48(sp)
    80008a8e:	0080                	addi	s0,sp,64
    80008a90:	fca43423          	sd	a0,-56(s0)
    80008a94:	87ae                	mv	a5,a1
    80008a96:	8736                	mv	a4,a3
    80008a98:	fcf41323          	sh	a5,-58(s0)
    80008a9c:	87b2                	mv	a5,a2
    80008a9e:	fcf41223          	sh	a5,-60(s0)
    80008aa2:	87ba                	mv	a5,a4
    80008aa4:	fcf41123          	sh	a5,-62(s0)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80008aa8:	fd040793          	addi	a5,s0,-48
    80008aac:	85be                	mv	a1,a5
    80008aae:	fc843503          	ld	a0,-56(s0)
    80008ab2:	ffffe097          	auipc	ra,0xffffe
    80008ab6:	f7c080e7          	jalr	-132(ra) # 80006a2e <nameiparent>
    80008aba:	fea43423          	sd	a0,-24(s0)
    80008abe:	fe843783          	ld	a5,-24(s0)
    80008ac2:	e399                	bnez	a5,80008ac8 <create+0x40>
    return 0;
    80008ac4:	4781                	li	a5,0
    80008ac6:	a2d9                	j	80008c8c <create+0x204>

  ilock(dp);
    80008ac8:	fe843503          	ld	a0,-24(s0)
    80008acc:	ffffd097          	auipc	ra,0xffffd
    80008ad0:	232080e7          	jalr	562(ra) # 80005cfe <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80008ad4:	fd040793          	addi	a5,s0,-48
    80008ad8:	4601                	li	a2,0
    80008ada:	85be                	mv	a1,a5
    80008adc:	fe843503          	ld	a0,-24(s0)
    80008ae0:	ffffe097          	auipc	ra,0xffffe
    80008ae4:	b20080e7          	jalr	-1248(ra) # 80006600 <dirlookup>
    80008ae8:	fea43023          	sd	a0,-32(s0)
    80008aec:	fe043783          	ld	a5,-32(s0)
    80008af0:	c3ad                	beqz	a5,80008b52 <create+0xca>
    iunlockput(dp);
    80008af2:	fe843503          	ld	a0,-24(s0)
    80008af6:	ffffd097          	auipc	ra,0xffffd
    80008afa:	466080e7          	jalr	1126(ra) # 80005f5c <iunlockput>
    ilock(ip);
    80008afe:	fe043503          	ld	a0,-32(s0)
    80008b02:	ffffd097          	auipc	ra,0xffffd
    80008b06:	1fc080e7          	jalr	508(ra) # 80005cfe <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80008b0a:	fc641783          	lh	a5,-58(s0)
    80008b0e:	0007871b          	sext.w	a4,a5
    80008b12:	4789                	li	a5,2
    80008b14:	02f71763          	bne	a4,a5,80008b42 <create+0xba>
    80008b18:	fe043783          	ld	a5,-32(s0)
    80008b1c:	04479783          	lh	a5,68(a5)
    80008b20:	0007871b          	sext.w	a4,a5
    80008b24:	4789                	li	a5,2
    80008b26:	00f70b63          	beq	a4,a5,80008b3c <create+0xb4>
    80008b2a:	fe043783          	ld	a5,-32(s0)
    80008b2e:	04479783          	lh	a5,68(a5)
    80008b32:	0007871b          	sext.w	a4,a5
    80008b36:	478d                	li	a5,3
    80008b38:	00f71563          	bne	a4,a5,80008b42 <create+0xba>
      return ip;
    80008b3c:	fe043783          	ld	a5,-32(s0)
    80008b40:	a2b1                	j	80008c8c <create+0x204>
    iunlockput(ip);
    80008b42:	fe043503          	ld	a0,-32(s0)
    80008b46:	ffffd097          	auipc	ra,0xffffd
    80008b4a:	416080e7          	jalr	1046(ra) # 80005f5c <iunlockput>
    return 0;
    80008b4e:	4781                	li	a5,0
    80008b50:	aa35                	j	80008c8c <create+0x204>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    80008b52:	fe843783          	ld	a5,-24(s0)
    80008b56:	439c                	lw	a5,0(a5)
    80008b58:	fc641703          	lh	a4,-58(s0)
    80008b5c:	85ba                	mv	a1,a4
    80008b5e:	853e                	mv	a0,a5
    80008b60:	ffffd097          	auipc	ra,0xffffd
    80008b64:	e52080e7          	jalr	-430(ra) # 800059b2 <ialloc>
    80008b68:	fea43023          	sd	a0,-32(s0)
    80008b6c:	fe043783          	ld	a5,-32(s0)
    80008b70:	eb89                	bnez	a5,80008b82 <create+0xfa>
    panic("create: ialloc");
    80008b72:	00003517          	auipc	a0,0x3
    80008b76:	c7e50513          	addi	a0,a0,-898 # 8000b7f0 <etext+0x7f0>
    80008b7a:	ffff8097          	auipc	ra,0xffff8
    80008b7e:	100080e7          	jalr	256(ra) # 80000c7a <panic>

  ilock(ip);
    80008b82:	fe043503          	ld	a0,-32(s0)
    80008b86:	ffffd097          	auipc	ra,0xffffd
    80008b8a:	178080e7          	jalr	376(ra) # 80005cfe <ilock>
  ip->major = major;
    80008b8e:	fe043783          	ld	a5,-32(s0)
    80008b92:	fc445703          	lhu	a4,-60(s0)
    80008b96:	04e79323          	sh	a4,70(a5)
  ip->minor = minor;
    80008b9a:	fe043783          	ld	a5,-32(s0)
    80008b9e:	fc245703          	lhu	a4,-62(s0)
    80008ba2:	04e79423          	sh	a4,72(a5)
  ip->nlink = 1;
    80008ba6:	fe043783          	ld	a5,-32(s0)
    80008baa:	4705                	li	a4,1
    80008bac:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80008bb0:	fe043503          	ld	a0,-32(s0)
    80008bb4:	ffffd097          	auipc	ra,0xffffd
    80008bb8:	efa080e7          	jalr	-262(ra) # 80005aae <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
    80008bbc:	fc641783          	lh	a5,-58(s0)
    80008bc0:	0007871b          	sext.w	a4,a5
    80008bc4:	4785                	li	a5,1
    80008bc6:	08f71363          	bne	a4,a5,80008c4c <create+0x1c4>
    dp->nlink++;  // for ".."
    80008bca:	fe843783          	ld	a5,-24(s0)
    80008bce:	04a79783          	lh	a5,74(a5)
    80008bd2:	17c2                	slli	a5,a5,0x30
    80008bd4:	93c1                	srli	a5,a5,0x30
    80008bd6:	2785                	addiw	a5,a5,1
    80008bd8:	17c2                	slli	a5,a5,0x30
    80008bda:	93c1                	srli	a5,a5,0x30
    80008bdc:	0107971b          	slliw	a4,a5,0x10
    80008be0:	4107571b          	sraiw	a4,a4,0x10
    80008be4:	fe843783          	ld	a5,-24(s0)
    80008be8:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80008bec:	fe843503          	ld	a0,-24(s0)
    80008bf0:	ffffd097          	auipc	ra,0xffffd
    80008bf4:	ebe080e7          	jalr	-322(ra) # 80005aae <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80008bf8:	fe043783          	ld	a5,-32(s0)
    80008bfc:	43dc                	lw	a5,4(a5)
    80008bfe:	863e                	mv	a2,a5
    80008c00:	00003597          	auipc	a1,0x3
    80008c04:	bb858593          	addi	a1,a1,-1096 # 8000b7b8 <etext+0x7b8>
    80008c08:	fe043503          	ld	a0,-32(s0)
    80008c0c:	ffffe097          	auipc	ra,0xffffe
    80008c10:	adc080e7          	jalr	-1316(ra) # 800066e8 <dirlink>
    80008c14:	87aa                	mv	a5,a0
    80008c16:	0207c363          	bltz	a5,80008c3c <create+0x1b4>
    80008c1a:	fe843783          	ld	a5,-24(s0)
    80008c1e:	43dc                	lw	a5,4(a5)
    80008c20:	863e                	mv	a2,a5
    80008c22:	00003597          	auipc	a1,0x3
    80008c26:	b9e58593          	addi	a1,a1,-1122 # 8000b7c0 <etext+0x7c0>
    80008c2a:	fe043503          	ld	a0,-32(s0)
    80008c2e:	ffffe097          	auipc	ra,0xffffe
    80008c32:	aba080e7          	jalr	-1350(ra) # 800066e8 <dirlink>
    80008c36:	87aa                	mv	a5,a0
    80008c38:	0007da63          	bgez	a5,80008c4c <create+0x1c4>
      panic("create dots");
    80008c3c:	00003517          	auipc	a0,0x3
    80008c40:	bc450513          	addi	a0,a0,-1084 # 8000b800 <etext+0x800>
    80008c44:	ffff8097          	auipc	ra,0xffff8
    80008c48:	036080e7          	jalr	54(ra) # 80000c7a <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    80008c4c:	fe043783          	ld	a5,-32(s0)
    80008c50:	43d8                	lw	a4,4(a5)
    80008c52:	fd040793          	addi	a5,s0,-48
    80008c56:	863a                	mv	a2,a4
    80008c58:	85be                	mv	a1,a5
    80008c5a:	fe843503          	ld	a0,-24(s0)
    80008c5e:	ffffe097          	auipc	ra,0xffffe
    80008c62:	a8a080e7          	jalr	-1398(ra) # 800066e8 <dirlink>
    80008c66:	87aa                	mv	a5,a0
    80008c68:	0007da63          	bgez	a5,80008c7c <create+0x1f4>
    panic("create: dirlink");
    80008c6c:	00003517          	auipc	a0,0x3
    80008c70:	ba450513          	addi	a0,a0,-1116 # 8000b810 <etext+0x810>
    80008c74:	ffff8097          	auipc	ra,0xffff8
    80008c78:	006080e7          	jalr	6(ra) # 80000c7a <panic>

  iunlockput(dp);
    80008c7c:	fe843503          	ld	a0,-24(s0)
    80008c80:	ffffd097          	auipc	ra,0xffffd
    80008c84:	2dc080e7          	jalr	732(ra) # 80005f5c <iunlockput>

  return ip;
    80008c88:	fe043783          	ld	a5,-32(s0)
}
    80008c8c:	853e                	mv	a0,a5
    80008c8e:	70e2                	ld	ra,56(sp)
    80008c90:	7442                	ld	s0,48(sp)
    80008c92:	6121                	addi	sp,sp,64
    80008c94:	8082                	ret

0000000080008c96 <sys_open>:

uint64
sys_open(void)
{
    80008c96:	7131                	addi	sp,sp,-192
    80008c98:	fd06                	sd	ra,184(sp)
    80008c9a:	f922                	sd	s0,176(sp)
    80008c9c:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80008c9e:	f5040793          	addi	a5,s0,-176
    80008ca2:	08000613          	li	a2,128
    80008ca6:	85be                	mv	a1,a5
    80008ca8:	4501                	li	a0,0
    80008caa:	ffffc097          	auipc	ra,0xffffc
    80008cae:	f0c080e7          	jalr	-244(ra) # 80004bb6 <argstr>
    80008cb2:	87aa                	mv	a5,a0
    80008cb4:	fef42223          	sw	a5,-28(s0)
    80008cb8:	fe442783          	lw	a5,-28(s0)
    80008cbc:	2781                	sext.w	a5,a5
    80008cbe:	0007cd63          	bltz	a5,80008cd8 <sys_open+0x42>
    80008cc2:	f4c40793          	addi	a5,s0,-180
    80008cc6:	85be                	mv	a1,a5
    80008cc8:	4505                	li	a0,1
    80008cca:	ffffc097          	auipc	ra,0xffffc
    80008cce:	e80080e7          	jalr	-384(ra) # 80004b4a <argint>
    80008cd2:	87aa                	mv	a5,a0
    80008cd4:	0007d463          	bgez	a5,80008cdc <sys_open+0x46>
    return -1;
    80008cd8:	57fd                	li	a5,-1
    80008cda:	a429                	j	80008ee4 <sys_open+0x24e>

  begin_op();
    80008cdc:	ffffe097          	auipc	ra,0xffffe
    80008ce0:	08a080e7          	jalr	138(ra) # 80006d66 <begin_op>

  if(omode & O_CREATE){
    80008ce4:	f4c42783          	lw	a5,-180(s0)
    80008ce8:	2007f793          	andi	a5,a5,512
    80008cec:	2781                	sext.w	a5,a5
    80008cee:	c795                	beqz	a5,80008d1a <sys_open+0x84>
    ip = create(path, T_FILE, 0, 0);
    80008cf0:	f5040793          	addi	a5,s0,-176
    80008cf4:	4681                	li	a3,0
    80008cf6:	4601                	li	a2,0
    80008cf8:	4589                	li	a1,2
    80008cfa:	853e                	mv	a0,a5
    80008cfc:	00000097          	auipc	ra,0x0
    80008d00:	d8c080e7          	jalr	-628(ra) # 80008a88 <create>
    80008d04:	fea43423          	sd	a0,-24(s0)
    if(ip == 0){
    80008d08:	fe843783          	ld	a5,-24(s0)
    80008d0c:	e7bd                	bnez	a5,80008d7a <sys_open+0xe4>
      end_op();
    80008d0e:	ffffe097          	auipc	ra,0xffffe
    80008d12:	11a080e7          	jalr	282(ra) # 80006e28 <end_op>
      return -1;
    80008d16:	57fd                	li	a5,-1
    80008d18:	a2f1                	j	80008ee4 <sys_open+0x24e>
    }
  } else {
    if((ip = namei(path)) == 0){
    80008d1a:	f5040793          	addi	a5,s0,-176
    80008d1e:	853e                	mv	a0,a5
    80008d20:	ffffe097          	auipc	ra,0xffffe
    80008d24:	ce2080e7          	jalr	-798(ra) # 80006a02 <namei>
    80008d28:	fea43423          	sd	a0,-24(s0)
    80008d2c:	fe843783          	ld	a5,-24(s0)
    80008d30:	e799                	bnez	a5,80008d3e <sys_open+0xa8>
      end_op();
    80008d32:	ffffe097          	auipc	ra,0xffffe
    80008d36:	0f6080e7          	jalr	246(ra) # 80006e28 <end_op>
      return -1;
    80008d3a:	57fd                	li	a5,-1
    80008d3c:	a265                	j	80008ee4 <sys_open+0x24e>
    }
    ilock(ip);
    80008d3e:	fe843503          	ld	a0,-24(s0)
    80008d42:	ffffd097          	auipc	ra,0xffffd
    80008d46:	fbc080e7          	jalr	-68(ra) # 80005cfe <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80008d4a:	fe843783          	ld	a5,-24(s0)
    80008d4e:	04479783          	lh	a5,68(a5)
    80008d52:	0007871b          	sext.w	a4,a5
    80008d56:	4785                	li	a5,1
    80008d58:	02f71163          	bne	a4,a5,80008d7a <sys_open+0xe4>
    80008d5c:	f4c42783          	lw	a5,-180(s0)
    80008d60:	cf89                	beqz	a5,80008d7a <sys_open+0xe4>
      iunlockput(ip);
    80008d62:	fe843503          	ld	a0,-24(s0)
    80008d66:	ffffd097          	auipc	ra,0xffffd
    80008d6a:	1f6080e7          	jalr	502(ra) # 80005f5c <iunlockput>
      end_op();
    80008d6e:	ffffe097          	auipc	ra,0xffffe
    80008d72:	0ba080e7          	jalr	186(ra) # 80006e28 <end_op>
      return -1;
    80008d76:	57fd                	li	a5,-1
    80008d78:	a2b5                	j	80008ee4 <sys_open+0x24e>
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80008d7a:	fe843783          	ld	a5,-24(s0)
    80008d7e:	04479783          	lh	a5,68(a5)
    80008d82:	0007871b          	sext.w	a4,a5
    80008d86:	478d                	li	a5,3
    80008d88:	02f71e63          	bne	a4,a5,80008dc4 <sys_open+0x12e>
    80008d8c:	fe843783          	ld	a5,-24(s0)
    80008d90:	04679783          	lh	a5,70(a5)
    80008d94:	2781                	sext.w	a5,a5
    80008d96:	0007cb63          	bltz	a5,80008dac <sys_open+0x116>
    80008d9a:	fe843783          	ld	a5,-24(s0)
    80008d9e:	04679783          	lh	a5,70(a5)
    80008da2:	0007871b          	sext.w	a4,a5
    80008da6:	47a5                	li	a5,9
    80008da8:	00e7de63          	bge	a5,a4,80008dc4 <sys_open+0x12e>
    iunlockput(ip);
    80008dac:	fe843503          	ld	a0,-24(s0)
    80008db0:	ffffd097          	auipc	ra,0xffffd
    80008db4:	1ac080e7          	jalr	428(ra) # 80005f5c <iunlockput>
    end_op();
    80008db8:	ffffe097          	auipc	ra,0xffffe
    80008dbc:	070080e7          	jalr	112(ra) # 80006e28 <end_op>
    return -1;
    80008dc0:	57fd                	li	a5,-1
    80008dc2:	a20d                	j	80008ee4 <sys_open+0x24e>
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80008dc4:	ffffe097          	auipc	ra,0xffffe
    80008dc8:	552080e7          	jalr	1362(ra) # 80007316 <filealloc>
    80008dcc:	fca43c23          	sd	a0,-40(s0)
    80008dd0:	fd843783          	ld	a5,-40(s0)
    80008dd4:	cf99                	beqz	a5,80008df2 <sys_open+0x15c>
    80008dd6:	fd843503          	ld	a0,-40(s0)
    80008dda:	fffff097          	auipc	ra,0xfffff
    80008dde:	5e8080e7          	jalr	1512(ra) # 800083c2 <fdalloc>
    80008de2:	87aa                	mv	a5,a0
    80008de4:	fcf42a23          	sw	a5,-44(s0)
    80008de8:	fd442783          	lw	a5,-44(s0)
    80008dec:	2781                	sext.w	a5,a5
    80008dee:	0207d763          	bgez	a5,80008e1c <sys_open+0x186>
    if(f)
    80008df2:	fd843783          	ld	a5,-40(s0)
    80008df6:	c799                	beqz	a5,80008e04 <sys_open+0x16e>
      fileclose(f);
    80008df8:	fd843503          	ld	a0,-40(s0)
    80008dfc:	ffffe097          	auipc	ra,0xffffe
    80008e00:	604080e7          	jalr	1540(ra) # 80007400 <fileclose>
    iunlockput(ip);
    80008e04:	fe843503          	ld	a0,-24(s0)
    80008e08:	ffffd097          	auipc	ra,0xffffd
    80008e0c:	154080e7          	jalr	340(ra) # 80005f5c <iunlockput>
    end_op();
    80008e10:	ffffe097          	auipc	ra,0xffffe
    80008e14:	018080e7          	jalr	24(ra) # 80006e28 <end_op>
    return -1;
    80008e18:	57fd                	li	a5,-1
    80008e1a:	a0e9                	j	80008ee4 <sys_open+0x24e>
  }

  if(ip->type == T_DEVICE){
    80008e1c:	fe843783          	ld	a5,-24(s0)
    80008e20:	04479783          	lh	a5,68(a5)
    80008e24:	0007871b          	sext.w	a4,a5
    80008e28:	478d                	li	a5,3
    80008e2a:	00f71f63          	bne	a4,a5,80008e48 <sys_open+0x1b2>
    f->type = FD_DEVICE;
    80008e2e:	fd843783          	ld	a5,-40(s0)
    80008e32:	470d                	li	a4,3
    80008e34:	c398                	sw	a4,0(a5)
    f->major = ip->major;
    80008e36:	fe843783          	ld	a5,-24(s0)
    80008e3a:	04679703          	lh	a4,70(a5)
    80008e3e:	fd843783          	ld	a5,-40(s0)
    80008e42:	02e79223          	sh	a4,36(a5)
    80008e46:	a809                	j	80008e58 <sys_open+0x1c2>
  } else {
    f->type = FD_INODE;
    80008e48:	fd843783          	ld	a5,-40(s0)
    80008e4c:	4709                	li	a4,2
    80008e4e:	c398                	sw	a4,0(a5)
    f->off = 0;
    80008e50:	fd843783          	ld	a5,-40(s0)
    80008e54:	0207a023          	sw	zero,32(a5)
  }
  f->ip = ip;
    80008e58:	fd843783          	ld	a5,-40(s0)
    80008e5c:	fe843703          	ld	a4,-24(s0)
    80008e60:	ef98                	sd	a4,24(a5)
  f->readable = !(omode & O_WRONLY);
    80008e62:	f4c42783          	lw	a5,-180(s0)
    80008e66:	8b85                	andi	a5,a5,1
    80008e68:	2781                	sext.w	a5,a5
    80008e6a:	0017b793          	seqz	a5,a5
    80008e6e:	0ff7f793          	zext.b	a5,a5
    80008e72:	873e                	mv	a4,a5
    80008e74:	fd843783          	ld	a5,-40(s0)
    80008e78:	00e78423          	sb	a4,8(a5)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80008e7c:	f4c42783          	lw	a5,-180(s0)
    80008e80:	8b85                	andi	a5,a5,1
    80008e82:	2781                	sext.w	a5,a5
    80008e84:	e791                	bnez	a5,80008e90 <sys_open+0x1fa>
    80008e86:	f4c42783          	lw	a5,-180(s0)
    80008e8a:	8b89                	andi	a5,a5,2
    80008e8c:	2781                	sext.w	a5,a5
    80008e8e:	c399                	beqz	a5,80008e94 <sys_open+0x1fe>
    80008e90:	4785                	li	a5,1
    80008e92:	a011                	j	80008e96 <sys_open+0x200>
    80008e94:	4781                	li	a5,0
    80008e96:	0ff7f713          	zext.b	a4,a5
    80008e9a:	fd843783          	ld	a5,-40(s0)
    80008e9e:	00e784a3          	sb	a4,9(a5)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80008ea2:	f4c42783          	lw	a5,-180(s0)
    80008ea6:	4007f793          	andi	a5,a5,1024
    80008eaa:	2781                	sext.w	a5,a5
    80008eac:	c385                	beqz	a5,80008ecc <sys_open+0x236>
    80008eae:	fe843783          	ld	a5,-24(s0)
    80008eb2:	04479783          	lh	a5,68(a5)
    80008eb6:	0007871b          	sext.w	a4,a5
    80008eba:	4789                	li	a5,2
    80008ebc:	00f71863          	bne	a4,a5,80008ecc <sys_open+0x236>
    itrunc(ip);
    80008ec0:	fe843503          	ld	a0,-24(s0)
    80008ec4:	ffffd097          	auipc	ra,0xffffd
    80008ec8:	222080e7          	jalr	546(ra) # 800060e6 <itrunc>
  }

  iunlock(ip);
    80008ecc:	fe843503          	ld	a0,-24(s0)
    80008ed0:	ffffd097          	auipc	ra,0xffffd
    80008ed4:	f62080e7          	jalr	-158(ra) # 80005e32 <iunlock>
  end_op();
    80008ed8:	ffffe097          	auipc	ra,0xffffe
    80008edc:	f50080e7          	jalr	-176(ra) # 80006e28 <end_op>

  return fd;
    80008ee0:	fd442783          	lw	a5,-44(s0)
}
    80008ee4:	853e                	mv	a0,a5
    80008ee6:	70ea                	ld	ra,184(sp)
    80008ee8:	744a                	ld	s0,176(sp)
    80008eea:	6129                	addi	sp,sp,192
    80008eec:	8082                	ret

0000000080008eee <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80008eee:	7135                	addi	sp,sp,-160
    80008ef0:	ed06                	sd	ra,152(sp)
    80008ef2:	e922                	sd	s0,144(sp)
    80008ef4:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80008ef6:	ffffe097          	auipc	ra,0xffffe
    80008efa:	e70080e7          	jalr	-400(ra) # 80006d66 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80008efe:	f6840793          	addi	a5,s0,-152
    80008f02:	08000613          	li	a2,128
    80008f06:	85be                	mv	a1,a5
    80008f08:	4501                	li	a0,0
    80008f0a:	ffffc097          	auipc	ra,0xffffc
    80008f0e:	cac080e7          	jalr	-852(ra) # 80004bb6 <argstr>
    80008f12:	87aa                	mv	a5,a0
    80008f14:	0207c163          	bltz	a5,80008f36 <sys_mkdir+0x48>
    80008f18:	f6840793          	addi	a5,s0,-152
    80008f1c:	4681                	li	a3,0
    80008f1e:	4601                	li	a2,0
    80008f20:	4585                	li	a1,1
    80008f22:	853e                	mv	a0,a5
    80008f24:	00000097          	auipc	ra,0x0
    80008f28:	b64080e7          	jalr	-1180(ra) # 80008a88 <create>
    80008f2c:	fea43423          	sd	a0,-24(s0)
    80008f30:	fe843783          	ld	a5,-24(s0)
    80008f34:	e799                	bnez	a5,80008f42 <sys_mkdir+0x54>
    end_op();
    80008f36:	ffffe097          	auipc	ra,0xffffe
    80008f3a:	ef2080e7          	jalr	-270(ra) # 80006e28 <end_op>
    return -1;
    80008f3e:	57fd                	li	a5,-1
    80008f40:	a821                	j	80008f58 <sys_mkdir+0x6a>
  }
  iunlockput(ip);
    80008f42:	fe843503          	ld	a0,-24(s0)
    80008f46:	ffffd097          	auipc	ra,0xffffd
    80008f4a:	016080e7          	jalr	22(ra) # 80005f5c <iunlockput>
  end_op();
    80008f4e:	ffffe097          	auipc	ra,0xffffe
    80008f52:	eda080e7          	jalr	-294(ra) # 80006e28 <end_op>
  return 0;
    80008f56:	4781                	li	a5,0
}
    80008f58:	853e                	mv	a0,a5
    80008f5a:	60ea                	ld	ra,152(sp)
    80008f5c:	644a                	ld	s0,144(sp)
    80008f5e:	610d                	addi	sp,sp,160
    80008f60:	8082                	ret

0000000080008f62 <sys_mknod>:

uint64
sys_mknod(void)
{
    80008f62:	7135                	addi	sp,sp,-160
    80008f64:	ed06                	sd	ra,152(sp)
    80008f66:	e922                	sd	s0,144(sp)
    80008f68:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80008f6a:	ffffe097          	auipc	ra,0xffffe
    80008f6e:	dfc080e7          	jalr	-516(ra) # 80006d66 <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80008f72:	f6840793          	addi	a5,s0,-152
    80008f76:	08000613          	li	a2,128
    80008f7a:	85be                	mv	a1,a5
    80008f7c:	4501                	li	a0,0
    80008f7e:	ffffc097          	auipc	ra,0xffffc
    80008f82:	c38080e7          	jalr	-968(ra) # 80004bb6 <argstr>
    80008f86:	87aa                	mv	a5,a0
    80008f88:	0607c263          	bltz	a5,80008fec <sys_mknod+0x8a>
     argint(1, &major) < 0 ||
    80008f8c:	f6440793          	addi	a5,s0,-156
    80008f90:	85be                	mv	a1,a5
    80008f92:	4505                	li	a0,1
    80008f94:	ffffc097          	auipc	ra,0xffffc
    80008f98:	bb6080e7          	jalr	-1098(ra) # 80004b4a <argint>
    80008f9c:	87aa                	mv	a5,a0
  if((argstr(0, path, MAXPATH)) < 0 ||
    80008f9e:	0407c763          	bltz	a5,80008fec <sys_mknod+0x8a>
     argint(2, &minor) < 0 ||
    80008fa2:	f6040793          	addi	a5,s0,-160
    80008fa6:	85be                	mv	a1,a5
    80008fa8:	4509                	li	a0,2
    80008faa:	ffffc097          	auipc	ra,0xffffc
    80008fae:	ba0080e7          	jalr	-1120(ra) # 80004b4a <argint>
    80008fb2:	87aa                	mv	a5,a0
     argint(1, &major) < 0 ||
    80008fb4:	0207cc63          	bltz	a5,80008fec <sys_mknod+0x8a>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80008fb8:	f6442783          	lw	a5,-156(s0)
    80008fbc:	0107971b          	slliw	a4,a5,0x10
    80008fc0:	4107571b          	sraiw	a4,a4,0x10
    80008fc4:	f6042783          	lw	a5,-160(s0)
    80008fc8:	0107969b          	slliw	a3,a5,0x10
    80008fcc:	4106d69b          	sraiw	a3,a3,0x10
    80008fd0:	f6840793          	addi	a5,s0,-152
    80008fd4:	863a                	mv	a2,a4
    80008fd6:	458d                	li	a1,3
    80008fd8:	853e                	mv	a0,a5
    80008fda:	00000097          	auipc	ra,0x0
    80008fde:	aae080e7          	jalr	-1362(ra) # 80008a88 <create>
    80008fe2:	fea43423          	sd	a0,-24(s0)
     argint(2, &minor) < 0 ||
    80008fe6:	fe843783          	ld	a5,-24(s0)
    80008fea:	e799                	bnez	a5,80008ff8 <sys_mknod+0x96>
    end_op();
    80008fec:	ffffe097          	auipc	ra,0xffffe
    80008ff0:	e3c080e7          	jalr	-452(ra) # 80006e28 <end_op>
    return -1;
    80008ff4:	57fd                	li	a5,-1
    80008ff6:	a821                	j	8000900e <sys_mknod+0xac>
  }
  iunlockput(ip);
    80008ff8:	fe843503          	ld	a0,-24(s0)
    80008ffc:	ffffd097          	auipc	ra,0xffffd
    80009000:	f60080e7          	jalr	-160(ra) # 80005f5c <iunlockput>
  end_op();
    80009004:	ffffe097          	auipc	ra,0xffffe
    80009008:	e24080e7          	jalr	-476(ra) # 80006e28 <end_op>
  return 0;
    8000900c:	4781                	li	a5,0
}
    8000900e:	853e                	mv	a0,a5
    80009010:	60ea                	ld	ra,152(sp)
    80009012:	644a                	ld	s0,144(sp)
    80009014:	610d                	addi	sp,sp,160
    80009016:	8082                	ret

0000000080009018 <sys_chdir>:

uint64
sys_chdir(void)
{
    80009018:	7135                	addi	sp,sp,-160
    8000901a:	ed06                	sd	ra,152(sp)
    8000901c:	e922                	sd	s0,144(sp)
    8000901e:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80009020:	ffffa097          	auipc	ra,0xffffa
    80009024:	9f8080e7          	jalr	-1544(ra) # 80002a18 <myproc>
    80009028:	fea43423          	sd	a0,-24(s0)
  
  begin_op();
    8000902c:	ffffe097          	auipc	ra,0xffffe
    80009030:	d3a080e7          	jalr	-710(ra) # 80006d66 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80009034:	f6040793          	addi	a5,s0,-160
    80009038:	08000613          	li	a2,128
    8000903c:	85be                	mv	a1,a5
    8000903e:	4501                	li	a0,0
    80009040:	ffffc097          	auipc	ra,0xffffc
    80009044:	b76080e7          	jalr	-1162(ra) # 80004bb6 <argstr>
    80009048:	87aa                	mv	a5,a0
    8000904a:	0007ce63          	bltz	a5,80009066 <sys_chdir+0x4e>
    8000904e:	f6040793          	addi	a5,s0,-160
    80009052:	853e                	mv	a0,a5
    80009054:	ffffe097          	auipc	ra,0xffffe
    80009058:	9ae080e7          	jalr	-1618(ra) # 80006a02 <namei>
    8000905c:	fea43023          	sd	a0,-32(s0)
    80009060:	fe043783          	ld	a5,-32(s0)
    80009064:	e799                	bnez	a5,80009072 <sys_chdir+0x5a>
    end_op();
    80009066:	ffffe097          	auipc	ra,0xffffe
    8000906a:	dc2080e7          	jalr	-574(ra) # 80006e28 <end_op>
    return -1;
    8000906e:	57fd                	li	a5,-1
    80009070:	a0b5                	j	800090dc <sys_chdir+0xc4>
  }
  ilock(ip);
    80009072:	fe043503          	ld	a0,-32(s0)
    80009076:	ffffd097          	auipc	ra,0xffffd
    8000907a:	c88080e7          	jalr	-888(ra) # 80005cfe <ilock>
  if(ip->type != T_DIR){
    8000907e:	fe043783          	ld	a5,-32(s0)
    80009082:	04479783          	lh	a5,68(a5)
    80009086:	0007871b          	sext.w	a4,a5
    8000908a:	4785                	li	a5,1
    8000908c:	00f70e63          	beq	a4,a5,800090a8 <sys_chdir+0x90>
    iunlockput(ip);
    80009090:	fe043503          	ld	a0,-32(s0)
    80009094:	ffffd097          	auipc	ra,0xffffd
    80009098:	ec8080e7          	jalr	-312(ra) # 80005f5c <iunlockput>
    end_op();
    8000909c:	ffffe097          	auipc	ra,0xffffe
    800090a0:	d8c080e7          	jalr	-628(ra) # 80006e28 <end_op>
    return -1;
    800090a4:	57fd                	li	a5,-1
    800090a6:	a81d                	j	800090dc <sys_chdir+0xc4>
  }
  iunlock(ip);
    800090a8:	fe043503          	ld	a0,-32(s0)
    800090ac:	ffffd097          	auipc	ra,0xffffd
    800090b0:	d86080e7          	jalr	-634(ra) # 80005e32 <iunlock>
  iput(p->cwd);
    800090b4:	fe843783          	ld	a5,-24(s0)
    800090b8:	1607b783          	ld	a5,352(a5)
    800090bc:	853e                	mv	a0,a5
    800090be:	ffffd097          	auipc	ra,0xffffd
    800090c2:	dce080e7          	jalr	-562(ra) # 80005e8c <iput>
  end_op();
    800090c6:	ffffe097          	auipc	ra,0xffffe
    800090ca:	d62080e7          	jalr	-670(ra) # 80006e28 <end_op>
  p->cwd = ip;
    800090ce:	fe843783          	ld	a5,-24(s0)
    800090d2:	fe043703          	ld	a4,-32(s0)
    800090d6:	16e7b023          	sd	a4,352(a5)
  return 0;
    800090da:	4781                	li	a5,0
}
    800090dc:	853e                	mv	a0,a5
    800090de:	60ea                	ld	ra,152(sp)
    800090e0:	644a                	ld	s0,144(sp)
    800090e2:	610d                	addi	sp,sp,160
    800090e4:	8082                	ret

00000000800090e6 <sys_exec>:

uint64
sys_exec(void)
{
    800090e6:	7161                	addi	sp,sp,-432
    800090e8:	f706                	sd	ra,424(sp)
    800090ea:	f322                	sd	s0,416(sp)
    800090ec:	1b00                	addi	s0,sp,432
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    800090ee:	f6840793          	addi	a5,s0,-152
    800090f2:	08000613          	li	a2,128
    800090f6:	85be                	mv	a1,a5
    800090f8:	4501                	li	a0,0
    800090fa:	ffffc097          	auipc	ra,0xffffc
    800090fe:	abc080e7          	jalr	-1348(ra) # 80004bb6 <argstr>
    80009102:	87aa                	mv	a5,a0
    80009104:	0007cd63          	bltz	a5,8000911e <sys_exec+0x38>
    80009108:	e6040793          	addi	a5,s0,-416
    8000910c:	85be                	mv	a1,a5
    8000910e:	4505                	li	a0,1
    80009110:	ffffc097          	auipc	ra,0xffffc
    80009114:	a72080e7          	jalr	-1422(ra) # 80004b82 <argaddr>
    80009118:	87aa                	mv	a5,a0
    8000911a:	0007d463          	bgez	a5,80009122 <sys_exec+0x3c>
    return -1;
    8000911e:	57fd                	li	a5,-1
    80009120:	aa8d                	j	80009292 <sys_exec+0x1ac>
  }
  memset(argv, 0, sizeof(argv));
    80009122:	e6840793          	addi	a5,s0,-408
    80009126:	10000613          	li	a2,256
    8000912a:	4581                	li	a1,0
    8000912c:	853e                	mv	a0,a5
    8000912e:	ffff8097          	auipc	ra,0xffff8
    80009132:	310080e7          	jalr	784(ra) # 8000143e <memset>
  for(i=0;; i++){
    80009136:	fe042623          	sw	zero,-20(s0)
    if(i >= NELEM(argv)){
    8000913a:	fec42783          	lw	a5,-20(s0)
    8000913e:	873e                	mv	a4,a5
    80009140:	47fd                	li	a5,31
    80009142:	0ee7ee63          	bltu	a5,a4,8000923e <sys_exec+0x158>
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80009146:	fec42783          	lw	a5,-20(s0)
    8000914a:	00379713          	slli	a4,a5,0x3
    8000914e:	e6043783          	ld	a5,-416(s0)
    80009152:	97ba                	add	a5,a5,a4
    80009154:	e5840713          	addi	a4,s0,-424
    80009158:	85ba                	mv	a1,a4
    8000915a:	853e                	mv	a0,a5
    8000915c:	ffffc097          	auipc	ra,0xffffc
    80009160:	870080e7          	jalr	-1936(ra) # 800049cc <fetchaddr>
    80009164:	87aa                	mv	a5,a0
    80009166:	0c07ce63          	bltz	a5,80009242 <sys_exec+0x15c>
      goto bad;
    }
    if(uarg == 0){
    8000916a:	e5843783          	ld	a5,-424(s0)
    8000916e:	eb8d                	bnez	a5,800091a0 <sys_exec+0xba>
      argv[i] = 0;
    80009170:	fec42783          	lw	a5,-20(s0)
    80009174:	078e                	slli	a5,a5,0x3
    80009176:	17c1                	addi	a5,a5,-16
    80009178:	97a2                	add	a5,a5,s0
    8000917a:	e607bc23          	sd	zero,-392(a5)
      break;
    8000917e:	0001                	nop
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
      goto bad;
  }

  int ret = exec(path, argv);
    80009180:	e6840713          	addi	a4,s0,-408
    80009184:	f6840793          	addi	a5,s0,-152
    80009188:	85ba                	mv	a1,a4
    8000918a:	853e                	mv	a0,a5
    8000918c:	fffff097          	auipc	ra,0xfffff
    80009190:	c2a080e7          	jalr	-982(ra) # 80007db6 <exec>
    80009194:	87aa                	mv	a5,a0
    80009196:	fef42423          	sw	a5,-24(s0)

  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000919a:	fe042623          	sw	zero,-20(s0)
    8000919e:	a8bd                	j	8000921c <sys_exec+0x136>
    argv[i] = kalloc();
    800091a0:	ffff8097          	auipc	ra,0xffff8
    800091a4:	f76080e7          	jalr	-138(ra) # 80001116 <kalloc>
    800091a8:	872a                	mv	a4,a0
    800091aa:	fec42783          	lw	a5,-20(s0)
    800091ae:	078e                	slli	a5,a5,0x3
    800091b0:	17c1                	addi	a5,a5,-16
    800091b2:	97a2                	add	a5,a5,s0
    800091b4:	e6e7bc23          	sd	a4,-392(a5)
    if(argv[i] == 0)
    800091b8:	fec42783          	lw	a5,-20(s0)
    800091bc:	078e                	slli	a5,a5,0x3
    800091be:	17c1                	addi	a5,a5,-16
    800091c0:	97a2                	add	a5,a5,s0
    800091c2:	e787b783          	ld	a5,-392(a5)
    800091c6:	c3c1                	beqz	a5,80009246 <sys_exec+0x160>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800091c8:	e5843703          	ld	a4,-424(s0)
    800091cc:	fec42783          	lw	a5,-20(s0)
    800091d0:	078e                	slli	a5,a5,0x3
    800091d2:	17c1                	addi	a5,a5,-16
    800091d4:	97a2                	add	a5,a5,s0
    800091d6:	e787b783          	ld	a5,-392(a5)
    800091da:	6605                	lui	a2,0x1
    800091dc:	85be                	mv	a1,a5
    800091de:	853a                	mv	a0,a4
    800091e0:	ffffc097          	auipc	ra,0xffffc
    800091e4:	85a080e7          	jalr	-1958(ra) # 80004a3a <fetchstr>
    800091e8:	87aa                	mv	a5,a0
    800091ea:	0607c063          	bltz	a5,8000924a <sys_exec+0x164>
  for(i=0;; i++){
    800091ee:	fec42783          	lw	a5,-20(s0)
    800091f2:	2785                	addiw	a5,a5,1
    800091f4:	fef42623          	sw	a5,-20(s0)
    if(i >= NELEM(argv)){
    800091f8:	b789                	j	8000913a <sys_exec+0x54>
    kfree(argv[i]);
    800091fa:	fec42783          	lw	a5,-20(s0)
    800091fe:	078e                	slli	a5,a5,0x3
    80009200:	17c1                	addi	a5,a5,-16
    80009202:	97a2                	add	a5,a5,s0
    80009204:	e787b783          	ld	a5,-392(a5)
    80009208:	853e                	mv	a0,a5
    8000920a:	ffff8097          	auipc	ra,0xffff8
    8000920e:	e68080e7          	jalr	-408(ra) # 80001072 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80009212:	fec42783          	lw	a5,-20(s0)
    80009216:	2785                	addiw	a5,a5,1
    80009218:	fef42623          	sw	a5,-20(s0)
    8000921c:	fec42783          	lw	a5,-20(s0)
    80009220:	873e                	mv	a4,a5
    80009222:	47fd                	li	a5,31
    80009224:	00e7ea63          	bltu	a5,a4,80009238 <sys_exec+0x152>
    80009228:	fec42783          	lw	a5,-20(s0)
    8000922c:	078e                	slli	a5,a5,0x3
    8000922e:	17c1                	addi	a5,a5,-16
    80009230:	97a2                	add	a5,a5,s0
    80009232:	e787b783          	ld	a5,-392(a5)
    80009236:	f3f1                	bnez	a5,800091fa <sys_exec+0x114>

  return ret;
    80009238:	fe842783          	lw	a5,-24(s0)
    8000923c:	a899                	j	80009292 <sys_exec+0x1ac>
      goto bad;
    8000923e:	0001                	nop
    80009240:	a031                	j	8000924c <sys_exec+0x166>
      goto bad;
    80009242:	0001                	nop
    80009244:	a021                	j	8000924c <sys_exec+0x166>
      goto bad;
    80009246:	0001                	nop
    80009248:	a011                	j	8000924c <sys_exec+0x166>
      goto bad;
    8000924a:	0001                	nop

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000924c:	fe042623          	sw	zero,-20(s0)
    80009250:	a015                	j	80009274 <sys_exec+0x18e>
    kfree(argv[i]);
    80009252:	fec42783          	lw	a5,-20(s0)
    80009256:	078e                	slli	a5,a5,0x3
    80009258:	17c1                	addi	a5,a5,-16
    8000925a:	97a2                	add	a5,a5,s0
    8000925c:	e787b783          	ld	a5,-392(a5)
    80009260:	853e                	mv	a0,a5
    80009262:	ffff8097          	auipc	ra,0xffff8
    80009266:	e10080e7          	jalr	-496(ra) # 80001072 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000926a:	fec42783          	lw	a5,-20(s0)
    8000926e:	2785                	addiw	a5,a5,1
    80009270:	fef42623          	sw	a5,-20(s0)
    80009274:	fec42783          	lw	a5,-20(s0)
    80009278:	873e                	mv	a4,a5
    8000927a:	47fd                	li	a5,31
    8000927c:	00e7ea63          	bltu	a5,a4,80009290 <sys_exec+0x1aa>
    80009280:	fec42783          	lw	a5,-20(s0)
    80009284:	078e                	slli	a5,a5,0x3
    80009286:	17c1                	addi	a5,a5,-16
    80009288:	97a2                	add	a5,a5,s0
    8000928a:	e787b783          	ld	a5,-392(a5)
    8000928e:	f3f1                	bnez	a5,80009252 <sys_exec+0x16c>
  return -1;
    80009290:	57fd                	li	a5,-1
}
    80009292:	853e                	mv	a0,a5
    80009294:	70ba                	ld	ra,424(sp)
    80009296:	741a                	ld	s0,416(sp)
    80009298:	615d                	addi	sp,sp,432
    8000929a:	8082                	ret

000000008000929c <sys_pipe>:

uint64
sys_pipe(void)
{
    8000929c:	7139                	addi	sp,sp,-64
    8000929e:	fc06                	sd	ra,56(sp)
    800092a0:	f822                	sd	s0,48(sp)
    800092a2:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    800092a4:	ffff9097          	auipc	ra,0xffff9
    800092a8:	774080e7          	jalr	1908(ra) # 80002a18 <myproc>
    800092ac:	fea43423          	sd	a0,-24(s0)

  if(argaddr(0, &fdarray) < 0)
    800092b0:	fe040793          	addi	a5,s0,-32
    800092b4:	85be                	mv	a1,a5
    800092b6:	4501                	li	a0,0
    800092b8:	ffffc097          	auipc	ra,0xffffc
    800092bc:	8ca080e7          	jalr	-1846(ra) # 80004b82 <argaddr>
    800092c0:	87aa                	mv	a5,a0
    800092c2:	0007d463          	bgez	a5,800092ca <sys_pipe+0x2e>
    return -1;
    800092c6:	57fd                	li	a5,-1
    800092c8:	a215                	j	800093ec <sys_pipe+0x150>
  if(pipealloc(&rf, &wf) < 0)
    800092ca:	fd040713          	addi	a4,s0,-48
    800092ce:	fd840793          	addi	a5,s0,-40
    800092d2:	85ba                	mv	a1,a4
    800092d4:	853e                	mv	a0,a5
    800092d6:	ffffe097          	auipc	ra,0xffffe
    800092da:	64c080e7          	jalr	1612(ra) # 80007922 <pipealloc>
    800092de:	87aa                	mv	a5,a0
    800092e0:	0007d463          	bgez	a5,800092e8 <sys_pipe+0x4c>
    return -1;
    800092e4:	57fd                	li	a5,-1
    800092e6:	a219                	j	800093ec <sys_pipe+0x150>
  fd0 = -1;
    800092e8:	57fd                	li	a5,-1
    800092ea:	fcf42623          	sw	a5,-52(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800092ee:	fd843783          	ld	a5,-40(s0)
    800092f2:	853e                	mv	a0,a5
    800092f4:	fffff097          	auipc	ra,0xfffff
    800092f8:	0ce080e7          	jalr	206(ra) # 800083c2 <fdalloc>
    800092fc:	87aa                	mv	a5,a0
    800092fe:	fcf42623          	sw	a5,-52(s0)
    80009302:	fcc42783          	lw	a5,-52(s0)
    80009306:	0207c063          	bltz	a5,80009326 <sys_pipe+0x8a>
    8000930a:	fd043783          	ld	a5,-48(s0)
    8000930e:	853e                	mv	a0,a5
    80009310:	fffff097          	auipc	ra,0xfffff
    80009314:	0b2080e7          	jalr	178(ra) # 800083c2 <fdalloc>
    80009318:	87aa                	mv	a5,a0
    8000931a:	fcf42423          	sw	a5,-56(s0)
    8000931e:	fc842783          	lw	a5,-56(s0)
    80009322:	0207df63          	bgez	a5,80009360 <sys_pipe+0xc4>
    if(fd0 >= 0)
    80009326:	fcc42783          	lw	a5,-52(s0)
    8000932a:	0007cb63          	bltz	a5,80009340 <sys_pipe+0xa4>
      p->ofile[fd0] = 0;
    8000932e:	fcc42783          	lw	a5,-52(s0)
    80009332:	fe843703          	ld	a4,-24(s0)
    80009336:	07f1                	addi	a5,a5,28
    80009338:	078e                	slli	a5,a5,0x3
    8000933a:	97ba                	add	a5,a5,a4
    8000933c:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80009340:	fd843783          	ld	a5,-40(s0)
    80009344:	853e                	mv	a0,a5
    80009346:	ffffe097          	auipc	ra,0xffffe
    8000934a:	0ba080e7          	jalr	186(ra) # 80007400 <fileclose>
    fileclose(wf);
    8000934e:	fd043783          	ld	a5,-48(s0)
    80009352:	853e                	mv	a0,a5
    80009354:	ffffe097          	auipc	ra,0xffffe
    80009358:	0ac080e7          	jalr	172(ra) # 80007400 <fileclose>
    return -1;
    8000935c:	57fd                	li	a5,-1
    8000935e:	a079                	j	800093ec <sys_pipe+0x150>
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80009360:	fe843783          	ld	a5,-24(s0)
    80009364:	6bbc                	ld	a5,80(a5)
    80009366:	fe043703          	ld	a4,-32(s0)
    8000936a:	fcc40613          	addi	a2,s0,-52
    8000936e:	4691                	li	a3,4
    80009370:	85ba                	mv	a1,a4
    80009372:	853e                	mv	a0,a5
    80009374:	ffff9097          	auipc	ra,0xffff9
    80009378:	052080e7          	jalr	82(ra) # 800023c6 <copyout>
    8000937c:	87aa                	mv	a5,a0
    8000937e:	0207c463          	bltz	a5,800093a6 <sys_pipe+0x10a>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80009382:	fe843783          	ld	a5,-24(s0)
    80009386:	6bb8                	ld	a4,80(a5)
    80009388:	fe043783          	ld	a5,-32(s0)
    8000938c:	0791                	addi	a5,a5,4
    8000938e:	fc840613          	addi	a2,s0,-56
    80009392:	4691                	li	a3,4
    80009394:	85be                	mv	a1,a5
    80009396:	853a                	mv	a0,a4
    80009398:	ffff9097          	auipc	ra,0xffff9
    8000939c:	02e080e7          	jalr	46(ra) # 800023c6 <copyout>
    800093a0:	87aa                	mv	a5,a0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800093a2:	0407d463          	bgez	a5,800093ea <sys_pipe+0x14e>
    p->ofile[fd0] = 0;
    800093a6:	fcc42783          	lw	a5,-52(s0)
    800093aa:	fe843703          	ld	a4,-24(s0)
    800093ae:	07f1                	addi	a5,a5,28
    800093b0:	078e                	slli	a5,a5,0x3
    800093b2:	97ba                	add	a5,a5,a4
    800093b4:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    800093b8:	fc842783          	lw	a5,-56(s0)
    800093bc:	fe843703          	ld	a4,-24(s0)
    800093c0:	07f1                	addi	a5,a5,28
    800093c2:	078e                	slli	a5,a5,0x3
    800093c4:	97ba                	add	a5,a5,a4
    800093c6:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800093ca:	fd843783          	ld	a5,-40(s0)
    800093ce:	853e                	mv	a0,a5
    800093d0:	ffffe097          	auipc	ra,0xffffe
    800093d4:	030080e7          	jalr	48(ra) # 80007400 <fileclose>
    fileclose(wf);
    800093d8:	fd043783          	ld	a5,-48(s0)
    800093dc:	853e                	mv	a0,a5
    800093de:	ffffe097          	auipc	ra,0xffffe
    800093e2:	022080e7          	jalr	34(ra) # 80007400 <fileclose>
    return -1;
    800093e6:	57fd                	li	a5,-1
    800093e8:	a011                	j	800093ec <sys_pipe+0x150>
  }
  return 0;
    800093ea:	4781                	li	a5,0
}
    800093ec:	853e                	mv	a0,a5
    800093ee:	70e2                	ld	ra,56(sp)
    800093f0:	7442                	ld	s0,48(sp)
    800093f2:	6121                	addi	sp,sp,64
    800093f4:	8082                	ret
	...

0000000080009400 <kernelvec>:
    80009400:	7111                	addi	sp,sp,-256
    80009402:	e006                	sd	ra,0(sp)
    80009404:	e40a                	sd	sp,8(sp)
    80009406:	e80e                	sd	gp,16(sp)
    80009408:	ec12                	sd	tp,24(sp)
    8000940a:	f016                	sd	t0,32(sp)
    8000940c:	f41a                	sd	t1,40(sp)
    8000940e:	f81e                	sd	t2,48(sp)
    80009410:	fc22                	sd	s0,56(sp)
    80009412:	e0a6                	sd	s1,64(sp)
    80009414:	e4aa                	sd	a0,72(sp)
    80009416:	e8ae                	sd	a1,80(sp)
    80009418:	ecb2                	sd	a2,88(sp)
    8000941a:	f0b6                	sd	a3,96(sp)
    8000941c:	f4ba                	sd	a4,104(sp)
    8000941e:	f8be                	sd	a5,112(sp)
    80009420:	fcc2                	sd	a6,120(sp)
    80009422:	e146                	sd	a7,128(sp)
    80009424:	e54a                	sd	s2,136(sp)
    80009426:	e94e                	sd	s3,144(sp)
    80009428:	ed52                	sd	s4,152(sp)
    8000942a:	f156                	sd	s5,160(sp)
    8000942c:	f55a                	sd	s6,168(sp)
    8000942e:	f95e                	sd	s7,176(sp)
    80009430:	fd62                	sd	s8,184(sp)
    80009432:	e1e6                	sd	s9,192(sp)
    80009434:	e5ea                	sd	s10,200(sp)
    80009436:	e9ee                	sd	s11,208(sp)
    80009438:	edf2                	sd	t3,216(sp)
    8000943a:	f1f6                	sd	t4,224(sp)
    8000943c:	f5fa                	sd	t5,232(sp)
    8000943e:	f9fe                	sd	t6,240(sp)
    80009440:	b24fb0ef          	jal	ra,80004764 <kerneltrap>
    80009444:	6082                	ld	ra,0(sp)
    80009446:	6122                	ld	sp,8(sp)
    80009448:	61c2                	ld	gp,16(sp)
    8000944a:	7282                	ld	t0,32(sp)
    8000944c:	7322                	ld	t1,40(sp)
    8000944e:	73c2                	ld	t2,48(sp)
    80009450:	7462                	ld	s0,56(sp)
    80009452:	6486                	ld	s1,64(sp)
    80009454:	6526                	ld	a0,72(sp)
    80009456:	65c6                	ld	a1,80(sp)
    80009458:	6666                	ld	a2,88(sp)
    8000945a:	7686                	ld	a3,96(sp)
    8000945c:	7726                	ld	a4,104(sp)
    8000945e:	77c6                	ld	a5,112(sp)
    80009460:	7866                	ld	a6,120(sp)
    80009462:	688a                	ld	a7,128(sp)
    80009464:	692a                	ld	s2,136(sp)
    80009466:	69ca                	ld	s3,144(sp)
    80009468:	6a6a                	ld	s4,152(sp)
    8000946a:	7a8a                	ld	s5,160(sp)
    8000946c:	7b2a                	ld	s6,168(sp)
    8000946e:	7bca                	ld	s7,176(sp)
    80009470:	7c6a                	ld	s8,184(sp)
    80009472:	6c8e                	ld	s9,192(sp)
    80009474:	6d2e                	ld	s10,200(sp)
    80009476:	6dce                	ld	s11,208(sp)
    80009478:	6e6e                	ld	t3,216(sp)
    8000947a:	7e8e                	ld	t4,224(sp)
    8000947c:	7f2e                	ld	t5,232(sp)
    8000947e:	7fce                	ld	t6,240(sp)
    80009480:	6111                	addi	sp,sp,256
    80009482:	10200073          	sret
    80009486:	00000013          	nop
    8000948a:	00000013          	nop
    8000948e:	0001                	nop

0000000080009490 <timervec>:
    80009490:	34051573          	csrrw	a0,mscratch,a0
    80009494:	e10c                	sd	a1,0(a0)
    80009496:	e510                	sd	a2,8(a0)
    80009498:	e914                	sd	a3,16(a0)
    8000949a:	6d0c                	ld	a1,24(a0)
    8000949c:	7110                	ld	a2,32(a0)
    8000949e:	6194                	ld	a3,0(a1)
    800094a0:	96b2                	add	a3,a3,a2
    800094a2:	e194                	sd	a3,0(a1)
    800094a4:	4589                	li	a1,2
    800094a6:	14459073          	csrw	sip,a1
    800094aa:	6914                	ld	a3,16(a0)
    800094ac:	6510                	ld	a2,8(a0)
    800094ae:	610c                	ld	a1,0(a0)
    800094b0:	34051573          	csrrw	a0,mscratch,a0
    800094b4:	30200073          	mret
	...

00000000800094ba <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    800094ba:	1141                	addi	sp,sp,-16
    800094bc:	e422                	sd	s0,8(sp)
    800094be:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    800094c0:	0c0007b7          	lui	a5,0xc000
    800094c4:	02878793          	addi	a5,a5,40 # c000028 <_entry-0x73ffffd8>
    800094c8:	4705                	li	a4,1
    800094ca:	c398                	sw	a4,0(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    800094cc:	0c0007b7          	lui	a5,0xc000
    800094d0:	0791                	addi	a5,a5,4
    800094d2:	4705                	li	a4,1
    800094d4:	c398                	sw	a4,0(a5)
}
    800094d6:	0001                	nop
    800094d8:	6422                	ld	s0,8(sp)
    800094da:	0141                	addi	sp,sp,16
    800094dc:	8082                	ret

00000000800094de <plicinithart>:

void
plicinithart(void)
{
    800094de:	1101                	addi	sp,sp,-32
    800094e0:	ec06                	sd	ra,24(sp)
    800094e2:	e822                	sd	s0,16(sp)
    800094e4:	1000                	addi	s0,sp,32
  int hart = cpuid();
    800094e6:	ffff9097          	auipc	ra,0xffff9
    800094ea:	4d4080e7          	jalr	1236(ra) # 800029ba <cpuid>
    800094ee:	87aa                	mv	a5,a0
    800094f0:	fef42623          	sw	a5,-20(s0)
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800094f4:	fec42783          	lw	a5,-20(s0)
    800094f8:	0087979b          	slliw	a5,a5,0x8
    800094fc:	2781                	sext.w	a5,a5
    800094fe:	873e                	mv	a4,a5
    80009500:	0c0027b7          	lui	a5,0xc002
    80009504:	08078793          	addi	a5,a5,128 # c002080 <_entry-0x73ffdf80>
    80009508:	97ba                	add	a5,a5,a4
    8000950a:	873e                	mv	a4,a5
    8000950c:	40200793          	li	a5,1026
    80009510:	c31c                	sw	a5,0(a4)

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80009512:	fec42783          	lw	a5,-20(s0)
    80009516:	00d7979b          	slliw	a5,a5,0xd
    8000951a:	2781                	sext.w	a5,a5
    8000951c:	873e                	mv	a4,a5
    8000951e:	0c2017b7          	lui	a5,0xc201
    80009522:	97ba                	add	a5,a5,a4
    80009524:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80009528:	0001                	nop
    8000952a:	60e2                	ld	ra,24(sp)
    8000952c:	6442                	ld	s0,16(sp)
    8000952e:	6105                	addi	sp,sp,32
    80009530:	8082                	ret

0000000080009532 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80009532:	1101                	addi	sp,sp,-32
    80009534:	ec06                	sd	ra,24(sp)
    80009536:	e822                	sd	s0,16(sp)
    80009538:	1000                	addi	s0,sp,32
  int hart = cpuid();
    8000953a:	ffff9097          	auipc	ra,0xffff9
    8000953e:	480080e7          	jalr	1152(ra) # 800029ba <cpuid>
    80009542:	87aa                	mv	a5,a0
    80009544:	fef42623          	sw	a5,-20(s0)
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80009548:	fec42783          	lw	a5,-20(s0)
    8000954c:	00d7979b          	slliw	a5,a5,0xd
    80009550:	2781                	sext.w	a5,a5
    80009552:	873e                	mv	a4,a5
    80009554:	0c2017b7          	lui	a5,0xc201
    80009558:	0791                	addi	a5,a5,4
    8000955a:	97ba                	add	a5,a5,a4
    8000955c:	439c                	lw	a5,0(a5)
    8000955e:	fef42423          	sw	a5,-24(s0)
  return irq;
    80009562:	fe842783          	lw	a5,-24(s0)
}
    80009566:	853e                	mv	a0,a5
    80009568:	60e2                	ld	ra,24(sp)
    8000956a:	6442                	ld	s0,16(sp)
    8000956c:	6105                	addi	sp,sp,32
    8000956e:	8082                	ret

0000000080009570 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80009570:	7179                	addi	sp,sp,-48
    80009572:	f406                	sd	ra,40(sp)
    80009574:	f022                	sd	s0,32(sp)
    80009576:	1800                	addi	s0,sp,48
    80009578:	87aa                	mv	a5,a0
    8000957a:	fcf42e23          	sw	a5,-36(s0)
  int hart = cpuid();
    8000957e:	ffff9097          	auipc	ra,0xffff9
    80009582:	43c080e7          	jalr	1084(ra) # 800029ba <cpuid>
    80009586:	87aa                	mv	a5,a0
    80009588:	fef42623          	sw	a5,-20(s0)
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    8000958c:	fec42783          	lw	a5,-20(s0)
    80009590:	00d7979b          	slliw	a5,a5,0xd
    80009594:	2781                	sext.w	a5,a5
    80009596:	873e                	mv	a4,a5
    80009598:	0c2017b7          	lui	a5,0xc201
    8000959c:	0791                	addi	a5,a5,4
    8000959e:	97ba                	add	a5,a5,a4
    800095a0:	873e                	mv	a4,a5
    800095a2:	fdc42783          	lw	a5,-36(s0)
    800095a6:	c31c                	sw	a5,0(a4)
}
    800095a8:	0001                	nop
    800095aa:	70a2                	ld	ra,40(sp)
    800095ac:	7402                	ld	s0,32(sp)
    800095ae:	6145                	addi	sp,sp,48
    800095b0:	8082                	ret

00000000800095b2 <virtio_disk_init>:
  
} __attribute__ ((aligned (PGSIZE))) disk;

void
virtio_disk_init(void)
{
    800095b2:	7179                	addi	sp,sp,-48
    800095b4:	f406                	sd	ra,40(sp)
    800095b6:	f022                	sd	s0,32(sp)
    800095b8:	1800                	addi	s0,sp,48
  uint32 status = 0;
    800095ba:	fe042423          	sw	zero,-24(s0)

  initlock(&disk.vdisk_lock, "virtio_disk");
    800095be:	00002597          	auipc	a1,0x2
    800095c2:	26258593          	addi	a1,a1,610 # 8000b820 <etext+0x820>
    800095c6:	0049f517          	auipc	a0,0x49f
    800095ca:	b6250513          	addi	a0,a0,-1182 # 804a8128 <disk+0x2128>
    800095ce:	ffff8097          	auipc	ra,0xffff8
    800095d2:	c6c080e7          	jalr	-916(ra) # 8000123a <initlock>

  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800095d6:	100017b7          	lui	a5,0x10001
    800095da:	439c                	lw	a5,0(a5)
    800095dc:	2781                	sext.w	a5,a5
    800095de:	873e                	mv	a4,a5
    800095e0:	747277b7          	lui	a5,0x74727
    800095e4:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800095e8:	04f71063          	bne	a4,a5,80009628 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    800095ec:	100017b7          	lui	a5,0x10001
    800095f0:	0791                	addi	a5,a5,4
    800095f2:	439c                	lw	a5,0(a5)
    800095f4:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800095f6:	873e                	mv	a4,a5
    800095f8:	4785                	li	a5,1
    800095fa:	02f71763          	bne	a4,a5,80009628 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800095fe:	100017b7          	lui	a5,0x10001
    80009602:	07a1                	addi	a5,a5,8
    80009604:	439c                	lw	a5,0(a5)
    80009606:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80009608:	873e                	mv	a4,a5
    8000960a:	4789                	li	a5,2
    8000960c:	00f71e63          	bne	a4,a5,80009628 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80009610:	100017b7          	lui	a5,0x10001
    80009614:	07b1                	addi	a5,a5,12
    80009616:	439c                	lw	a5,0(a5)
    80009618:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000961a:	873e                	mv	a4,a5
    8000961c:	554d47b7          	lui	a5,0x554d4
    80009620:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80009624:	00f70a63          	beq	a4,a5,80009638 <virtio_disk_init+0x86>
    panic("could not find virtio disk");
    80009628:	00002517          	auipc	a0,0x2
    8000962c:	20850513          	addi	a0,a0,520 # 8000b830 <etext+0x830>
    80009630:	ffff7097          	auipc	ra,0xffff7
    80009634:	64a080e7          	jalr	1610(ra) # 80000c7a <panic>
  }
  
  status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    80009638:	fe842783          	lw	a5,-24(s0)
    8000963c:	0017e793          	ori	a5,a5,1
    80009640:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80009644:	100017b7          	lui	a5,0x10001
    80009648:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    8000964c:	fe842703          	lw	a4,-24(s0)
    80009650:	c398                	sw	a4,0(a5)

  status |= VIRTIO_CONFIG_S_DRIVER;
    80009652:	fe842783          	lw	a5,-24(s0)
    80009656:	0027e793          	ori	a5,a5,2
    8000965a:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000965e:	100017b7          	lui	a5,0x10001
    80009662:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80009666:	fe842703          	lw	a4,-24(s0)
    8000966a:	c398                	sw	a4,0(a5)

  // negotiate features
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    8000966c:	100017b7          	lui	a5,0x10001
    80009670:	07c1                	addi	a5,a5,16
    80009672:	439c                	lw	a5,0(a5)
    80009674:	2781                	sext.w	a5,a5
    80009676:	1782                	slli	a5,a5,0x20
    80009678:	9381                	srli	a5,a5,0x20
    8000967a:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_RO);
    8000967e:	fe043783          	ld	a5,-32(s0)
    80009682:	fdf7f793          	andi	a5,a5,-33
    80009686:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_SCSI);
    8000968a:	fe043783          	ld	a5,-32(s0)
    8000968e:	f7f7f793          	andi	a5,a5,-129
    80009692:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    80009696:	fe043703          	ld	a4,-32(s0)
    8000969a:	77fd                	lui	a5,0xfffff
    8000969c:	7ff78793          	addi	a5,a5,2047 # fffffffffffff7ff <end+0xffffffff7fb567ff>
    800096a0:	8ff9                	and	a5,a5,a4
    800096a2:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_MQ);
    800096a6:	fe043703          	ld	a4,-32(s0)
    800096aa:	77fd                	lui	a5,0xfffff
    800096ac:	17fd                	addi	a5,a5,-1
    800096ae:	8ff9                	and	a5,a5,a4
    800096b0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    800096b4:	fe043703          	ld	a4,-32(s0)
    800096b8:	f80007b7          	lui	a5,0xf8000
    800096bc:	17fd                	addi	a5,a5,-1
    800096be:	8ff9                	and	a5,a5,a4
    800096c0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    800096c4:	fe043703          	ld	a4,-32(s0)
    800096c8:	e00007b7          	lui	a5,0xe0000
    800096cc:	17fd                	addi	a5,a5,-1
    800096ce:	8ff9                	and	a5,a5,a4
    800096d0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    800096d4:	fe043703          	ld	a4,-32(s0)
    800096d8:	f00007b7          	lui	a5,0xf0000
    800096dc:	17fd                	addi	a5,a5,-1
    800096de:	8ff9                	and	a5,a5,a4
    800096e0:	fef43023          	sd	a5,-32(s0)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800096e4:	100017b7          	lui	a5,0x10001
    800096e8:	02078793          	addi	a5,a5,32 # 10001020 <_entry-0x6fffefe0>
    800096ec:	fe043703          	ld	a4,-32(s0)
    800096f0:	2701                	sext.w	a4,a4
    800096f2:	c398                	sw	a4,0(a5)

  // tell device that feature negotiation is complete.
  status |= VIRTIO_CONFIG_S_FEATURES_OK;
    800096f4:	fe842783          	lw	a5,-24(s0)
    800096f8:	0087e793          	ori	a5,a5,8
    800096fc:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80009700:	100017b7          	lui	a5,0x10001
    80009704:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80009708:	fe842703          	lw	a4,-24(s0)
    8000970c:	c398                	sw	a4,0(a5)

  // tell device we're completely ready.
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    8000970e:	fe842783          	lw	a5,-24(s0)
    80009712:	0047e793          	ori	a5,a5,4
    80009716:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000971a:	100017b7          	lui	a5,0x10001
    8000971e:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80009722:	fe842703          	lw	a4,-24(s0)
    80009726:	c398                	sw	a4,0(a5)

  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    80009728:	100017b7          	lui	a5,0x10001
    8000972c:	02878793          	addi	a5,a5,40 # 10001028 <_entry-0x6fffefd8>
    80009730:	6705                	lui	a4,0x1
    80009732:	c398                	sw	a4,0(a5)

  // initialize queue 0.
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80009734:	100017b7          	lui	a5,0x10001
    80009738:	03078793          	addi	a5,a5,48 # 10001030 <_entry-0x6fffefd0>
    8000973c:	0007a023          	sw	zero,0(a5)
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80009740:	100017b7          	lui	a5,0x10001
    80009744:	03478793          	addi	a5,a5,52 # 10001034 <_entry-0x6fffefcc>
    80009748:	439c                	lw	a5,0(a5)
    8000974a:	fcf42e23          	sw	a5,-36(s0)
  if(max == 0)
    8000974e:	fdc42783          	lw	a5,-36(s0)
    80009752:	2781                	sext.w	a5,a5
    80009754:	eb89                	bnez	a5,80009766 <virtio_disk_init+0x1b4>
    panic("virtio disk has no queue 0");
    80009756:	00002517          	auipc	a0,0x2
    8000975a:	0fa50513          	addi	a0,a0,250 # 8000b850 <etext+0x850>
    8000975e:	ffff7097          	auipc	ra,0xffff7
    80009762:	51c080e7          	jalr	1308(ra) # 80000c7a <panic>
  if(max < NUM)
    80009766:	fdc42783          	lw	a5,-36(s0)
    8000976a:	0007871b          	sext.w	a4,a5
    8000976e:	479d                	li	a5,7
    80009770:	00e7ea63          	bltu	a5,a4,80009784 <virtio_disk_init+0x1d2>
    panic("virtio disk max queue too short");
    80009774:	00002517          	auipc	a0,0x2
    80009778:	0fc50513          	addi	a0,a0,252 # 8000b870 <etext+0x870>
    8000977c:	ffff7097          	auipc	ra,0xffff7
    80009780:	4fe080e7          	jalr	1278(ra) # 80000c7a <panic>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80009784:	100017b7          	lui	a5,0x10001
    80009788:	03878793          	addi	a5,a5,56 # 10001038 <_entry-0x6fffefc8>
    8000978c:	4721                	li	a4,8
    8000978e:	c398                	sw	a4,0(a5)
  memset(disk.pages, 0, sizeof(disk.pages));
    80009790:	6609                	lui	a2,0x2
    80009792:	4581                	li	a1,0
    80009794:	0049d517          	auipc	a0,0x49d
    80009798:	86c50513          	addi	a0,a0,-1940 # 804a6000 <disk>
    8000979c:	ffff8097          	auipc	ra,0xffff8
    800097a0:	ca2080e7          	jalr	-862(ra) # 8000143e <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    800097a4:	0049d797          	auipc	a5,0x49d
    800097a8:	85c78793          	addi	a5,a5,-1956 # 804a6000 <disk>
    800097ac:	00c7d713          	srli	a4,a5,0xc
    800097b0:	100017b7          	lui	a5,0x10001
    800097b4:	04078793          	addi	a5,a5,64 # 10001040 <_entry-0x6fffefc0>
    800097b8:	2701                	sext.w	a4,a4
    800097ba:	c398                	sw	a4,0(a5)

  // desc = pages -- num * virtq_desc
  // avail = pages + 0x40 -- 2 * uint16, then num * uint16
  // used = pages + 4096 -- 2 * uint16, then num * vRingUsedElem

  disk.desc = (struct virtq_desc *) disk.pages;
    800097bc:	0049d717          	auipc	a4,0x49d
    800097c0:	84470713          	addi	a4,a4,-1980 # 804a6000 <disk>
    800097c4:	6789                	lui	a5,0x2
    800097c6:	97ba                	add	a5,a5,a4
    800097c8:	0049d717          	auipc	a4,0x49d
    800097cc:	83870713          	addi	a4,a4,-1992 # 804a6000 <disk>
    800097d0:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    800097d2:	0049d717          	auipc	a4,0x49d
    800097d6:	8ae70713          	addi	a4,a4,-1874 # 804a6080 <disk+0x80>
    800097da:	0049d697          	auipc	a3,0x49d
    800097de:	82668693          	addi	a3,a3,-2010 # 804a6000 <disk>
    800097e2:	6789                	lui	a5,0x2
    800097e4:	97b6                	add	a5,a5,a3
    800097e6:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    800097e8:	0049e717          	auipc	a4,0x49e
    800097ec:	81870713          	addi	a4,a4,-2024 # 804a7000 <disk+0x1000>
    800097f0:	0049d697          	auipc	a3,0x49d
    800097f4:	81068693          	addi	a3,a3,-2032 # 804a6000 <disk>
    800097f8:	6789                	lui	a5,0x2
    800097fa:	97b6                	add	a5,a5,a3
    800097fc:	eb98                	sd	a4,16(a5)

  // all NUM descriptors start out unused.
  for(int i = 0; i < NUM; i++)
    800097fe:	fe042623          	sw	zero,-20(s0)
    80009802:	a015                	j	80009826 <virtio_disk_init+0x274>
    disk.free[i] = 1;
    80009804:	0049c717          	auipc	a4,0x49c
    80009808:	7fc70713          	addi	a4,a4,2044 # 804a6000 <disk>
    8000980c:	fec42783          	lw	a5,-20(s0)
    80009810:	97ba                	add	a5,a5,a4
    80009812:	6709                	lui	a4,0x2
    80009814:	97ba                	add	a5,a5,a4
    80009816:	4705                	li	a4,1
    80009818:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  for(int i = 0; i < NUM; i++)
    8000981c:	fec42783          	lw	a5,-20(s0)
    80009820:	2785                	addiw	a5,a5,1
    80009822:	fef42623          	sw	a5,-20(s0)
    80009826:	fec42783          	lw	a5,-20(s0)
    8000982a:	0007871b          	sext.w	a4,a5
    8000982e:	479d                	li	a5,7
    80009830:	fce7dae3          	bge	a5,a4,80009804 <virtio_disk_init+0x252>

  // plic.c and trap.c arrange for interrupts from VIRTIO0_IRQ.
}
    80009834:	0001                	nop
    80009836:	0001                	nop
    80009838:	70a2                	ld	ra,40(sp)
    8000983a:	7402                	ld	s0,32(sp)
    8000983c:	6145                	addi	sp,sp,48
    8000983e:	8082                	ret

0000000080009840 <alloc_desc>:

// find a free descriptor, mark it non-free, return its index.
static int
alloc_desc()
{
    80009840:	1101                	addi	sp,sp,-32
    80009842:	ec22                	sd	s0,24(sp)
    80009844:	1000                	addi	s0,sp,32
  for(int i = 0; i < NUM; i++){
    80009846:	fe042623          	sw	zero,-20(s0)
    8000984a:	a081                	j	8000988a <alloc_desc+0x4a>
    if(disk.free[i]){
    8000984c:	0049c717          	auipc	a4,0x49c
    80009850:	7b470713          	addi	a4,a4,1972 # 804a6000 <disk>
    80009854:	fec42783          	lw	a5,-20(s0)
    80009858:	97ba                	add	a5,a5,a4
    8000985a:	6709                	lui	a4,0x2
    8000985c:	97ba                	add	a5,a5,a4
    8000985e:	0187c783          	lbu	a5,24(a5)
    80009862:	cf99                	beqz	a5,80009880 <alloc_desc+0x40>
      disk.free[i] = 0;
    80009864:	0049c717          	auipc	a4,0x49c
    80009868:	79c70713          	addi	a4,a4,1948 # 804a6000 <disk>
    8000986c:	fec42783          	lw	a5,-20(s0)
    80009870:	97ba                	add	a5,a5,a4
    80009872:	6709                	lui	a4,0x2
    80009874:	97ba                	add	a5,a5,a4
    80009876:	00078c23          	sb	zero,24(a5)
      return i;
    8000987a:	fec42783          	lw	a5,-20(s0)
    8000987e:	a831                	j	8000989a <alloc_desc+0x5a>
  for(int i = 0; i < NUM; i++){
    80009880:	fec42783          	lw	a5,-20(s0)
    80009884:	2785                	addiw	a5,a5,1
    80009886:	fef42623          	sw	a5,-20(s0)
    8000988a:	fec42783          	lw	a5,-20(s0)
    8000988e:	0007871b          	sext.w	a4,a5
    80009892:	479d                	li	a5,7
    80009894:	fae7dce3          	bge	a5,a4,8000984c <alloc_desc+0xc>
    }
  }
  return -1;
    80009898:	57fd                	li	a5,-1
}
    8000989a:	853e                	mv	a0,a5
    8000989c:	6462                	ld	s0,24(sp)
    8000989e:	6105                	addi	sp,sp,32
    800098a0:	8082                	ret

00000000800098a2 <free_desc>:

// mark a descriptor as free.
static void
free_desc(int i)
{
    800098a2:	1101                	addi	sp,sp,-32
    800098a4:	ec06                	sd	ra,24(sp)
    800098a6:	e822                	sd	s0,16(sp)
    800098a8:	1000                	addi	s0,sp,32
    800098aa:	87aa                	mv	a5,a0
    800098ac:	fef42623          	sw	a5,-20(s0)
  if(i >= NUM)
    800098b0:	fec42783          	lw	a5,-20(s0)
    800098b4:	0007871b          	sext.w	a4,a5
    800098b8:	479d                	li	a5,7
    800098ba:	00e7da63          	bge	a5,a4,800098ce <free_desc+0x2c>
    panic("free_desc 1");
    800098be:	00002517          	auipc	a0,0x2
    800098c2:	fd250513          	addi	a0,a0,-46 # 8000b890 <etext+0x890>
    800098c6:	ffff7097          	auipc	ra,0xffff7
    800098ca:	3b4080e7          	jalr	948(ra) # 80000c7a <panic>
  if(disk.free[i])
    800098ce:	0049c717          	auipc	a4,0x49c
    800098d2:	73270713          	addi	a4,a4,1842 # 804a6000 <disk>
    800098d6:	fec42783          	lw	a5,-20(s0)
    800098da:	97ba                	add	a5,a5,a4
    800098dc:	6709                	lui	a4,0x2
    800098de:	97ba                	add	a5,a5,a4
    800098e0:	0187c783          	lbu	a5,24(a5)
    800098e4:	cb89                	beqz	a5,800098f6 <free_desc+0x54>
    panic("free_desc 2");
    800098e6:	00002517          	auipc	a0,0x2
    800098ea:	fba50513          	addi	a0,a0,-70 # 8000b8a0 <etext+0x8a0>
    800098ee:	ffff7097          	auipc	ra,0xffff7
    800098f2:	38c080e7          	jalr	908(ra) # 80000c7a <panic>
  disk.desc[i].addr = 0;
    800098f6:	0049c717          	auipc	a4,0x49c
    800098fa:	70a70713          	addi	a4,a4,1802 # 804a6000 <disk>
    800098fe:	6789                	lui	a5,0x2
    80009900:	97ba                	add	a5,a5,a4
    80009902:	6398                	ld	a4,0(a5)
    80009904:	fec42783          	lw	a5,-20(s0)
    80009908:	0792                	slli	a5,a5,0x4
    8000990a:	97ba                	add	a5,a5,a4
    8000990c:	0007b023          	sd	zero,0(a5) # 2000 <_entry-0x7fffe000>
  disk.desc[i].len = 0;
    80009910:	0049c717          	auipc	a4,0x49c
    80009914:	6f070713          	addi	a4,a4,1776 # 804a6000 <disk>
    80009918:	6789                	lui	a5,0x2
    8000991a:	97ba                	add	a5,a5,a4
    8000991c:	6398                	ld	a4,0(a5)
    8000991e:	fec42783          	lw	a5,-20(s0)
    80009922:	0792                	slli	a5,a5,0x4
    80009924:	97ba                	add	a5,a5,a4
    80009926:	0007a423          	sw	zero,8(a5) # 2008 <_entry-0x7fffdff8>
  disk.desc[i].flags = 0;
    8000992a:	0049c717          	auipc	a4,0x49c
    8000992e:	6d670713          	addi	a4,a4,1750 # 804a6000 <disk>
    80009932:	6789                	lui	a5,0x2
    80009934:	97ba                	add	a5,a5,a4
    80009936:	6398                	ld	a4,0(a5)
    80009938:	fec42783          	lw	a5,-20(s0)
    8000993c:	0792                	slli	a5,a5,0x4
    8000993e:	97ba                	add	a5,a5,a4
    80009940:	00079623          	sh	zero,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[i].next = 0;
    80009944:	0049c717          	auipc	a4,0x49c
    80009948:	6bc70713          	addi	a4,a4,1724 # 804a6000 <disk>
    8000994c:	6789                	lui	a5,0x2
    8000994e:	97ba                	add	a5,a5,a4
    80009950:	6398                	ld	a4,0(a5)
    80009952:	fec42783          	lw	a5,-20(s0)
    80009956:	0792                	slli	a5,a5,0x4
    80009958:	97ba                	add	a5,a5,a4
    8000995a:	00079723          	sh	zero,14(a5) # 200e <_entry-0x7fffdff2>
  disk.free[i] = 1;
    8000995e:	0049c717          	auipc	a4,0x49c
    80009962:	6a270713          	addi	a4,a4,1698 # 804a6000 <disk>
    80009966:	fec42783          	lw	a5,-20(s0)
    8000996a:	97ba                	add	a5,a5,a4
    8000996c:	6709                	lui	a4,0x2
    8000996e:	97ba                	add	a5,a5,a4
    80009970:	4705                	li	a4,1
    80009972:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    80009976:	0049e517          	auipc	a0,0x49e
    8000997a:	6a250513          	addi	a0,a0,1698 # 804a8018 <disk+0x2018>
    8000997e:	ffffa097          	auipc	ra,0xffffa
    80009982:	000080e7          	jalr	ra # 8000397e <wakeup>
}
    80009986:	0001                	nop
    80009988:	60e2                	ld	ra,24(sp)
    8000998a:	6442                	ld	s0,16(sp)
    8000998c:	6105                	addi	sp,sp,32
    8000998e:	8082                	ret

0000000080009990 <free_chain>:

// free a chain of descriptors.
static void
free_chain(int i)
{
    80009990:	7179                	addi	sp,sp,-48
    80009992:	f406                	sd	ra,40(sp)
    80009994:	f022                	sd	s0,32(sp)
    80009996:	1800                	addi	s0,sp,48
    80009998:	87aa                	mv	a5,a0
    8000999a:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    int flag = disk.desc[i].flags;
    8000999e:	0049c717          	auipc	a4,0x49c
    800099a2:	66270713          	addi	a4,a4,1634 # 804a6000 <disk>
    800099a6:	6789                	lui	a5,0x2
    800099a8:	97ba                	add	a5,a5,a4
    800099aa:	6398                	ld	a4,0(a5)
    800099ac:	fdc42783          	lw	a5,-36(s0)
    800099b0:	0792                	slli	a5,a5,0x4
    800099b2:	97ba                	add	a5,a5,a4
    800099b4:	00c7d783          	lhu	a5,12(a5) # 200c <_entry-0x7fffdff4>
    800099b8:	fef42623          	sw	a5,-20(s0)
    int nxt = disk.desc[i].next;
    800099bc:	0049c717          	auipc	a4,0x49c
    800099c0:	64470713          	addi	a4,a4,1604 # 804a6000 <disk>
    800099c4:	6789                	lui	a5,0x2
    800099c6:	97ba                	add	a5,a5,a4
    800099c8:	6398                	ld	a4,0(a5)
    800099ca:	fdc42783          	lw	a5,-36(s0)
    800099ce:	0792                	slli	a5,a5,0x4
    800099d0:	97ba                	add	a5,a5,a4
    800099d2:	00e7d783          	lhu	a5,14(a5) # 200e <_entry-0x7fffdff2>
    800099d6:	fef42423          	sw	a5,-24(s0)
    free_desc(i);
    800099da:	fdc42783          	lw	a5,-36(s0)
    800099de:	853e                	mv	a0,a5
    800099e0:	00000097          	auipc	ra,0x0
    800099e4:	ec2080e7          	jalr	-318(ra) # 800098a2 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800099e8:	fec42783          	lw	a5,-20(s0)
    800099ec:	8b85                	andi	a5,a5,1
    800099ee:	2781                	sext.w	a5,a5
    800099f0:	c791                	beqz	a5,800099fc <free_chain+0x6c>
      i = nxt;
    800099f2:	fe842783          	lw	a5,-24(s0)
    800099f6:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    800099fa:	b755                	j	8000999e <free_chain+0xe>
    else
      break;
    800099fc:	0001                	nop
  }
}
    800099fe:	0001                	nop
    80009a00:	70a2                	ld	ra,40(sp)
    80009a02:	7402                	ld	s0,32(sp)
    80009a04:	6145                	addi	sp,sp,48
    80009a06:	8082                	ret

0000000080009a08 <alloc3_desc>:

// allocate three descriptors (they need not be contiguous).
// disk transfers always use three descriptors.
static int
alloc3_desc(int *idx)
{
    80009a08:	7139                	addi	sp,sp,-64
    80009a0a:	fc06                	sd	ra,56(sp)
    80009a0c:	f822                	sd	s0,48(sp)
    80009a0e:	f426                	sd	s1,40(sp)
    80009a10:	0080                	addi	s0,sp,64
    80009a12:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 3; i++){
    80009a16:	fc042e23          	sw	zero,-36(s0)
    80009a1a:	a89d                	j	80009a90 <alloc3_desc+0x88>
    idx[i] = alloc_desc();
    80009a1c:	fdc42783          	lw	a5,-36(s0)
    80009a20:	078a                	slli	a5,a5,0x2
    80009a22:	fc843703          	ld	a4,-56(s0)
    80009a26:	00f704b3          	add	s1,a4,a5
    80009a2a:	00000097          	auipc	ra,0x0
    80009a2e:	e16080e7          	jalr	-490(ra) # 80009840 <alloc_desc>
    80009a32:	87aa                	mv	a5,a0
    80009a34:	c09c                	sw	a5,0(s1)
    if(idx[i] < 0){
    80009a36:	fdc42783          	lw	a5,-36(s0)
    80009a3a:	078a                	slli	a5,a5,0x2
    80009a3c:	fc843703          	ld	a4,-56(s0)
    80009a40:	97ba                	add	a5,a5,a4
    80009a42:	439c                	lw	a5,0(a5)
    80009a44:	0407d163          	bgez	a5,80009a86 <alloc3_desc+0x7e>
      for(int j = 0; j < i; j++)
    80009a48:	fc042c23          	sw	zero,-40(s0)
    80009a4c:	a015                	j	80009a70 <alloc3_desc+0x68>
        free_desc(idx[j]);
    80009a4e:	fd842783          	lw	a5,-40(s0)
    80009a52:	078a                	slli	a5,a5,0x2
    80009a54:	fc843703          	ld	a4,-56(s0)
    80009a58:	97ba                	add	a5,a5,a4
    80009a5a:	439c                	lw	a5,0(a5)
    80009a5c:	853e                	mv	a0,a5
    80009a5e:	00000097          	auipc	ra,0x0
    80009a62:	e44080e7          	jalr	-444(ra) # 800098a2 <free_desc>
      for(int j = 0; j < i; j++)
    80009a66:	fd842783          	lw	a5,-40(s0)
    80009a6a:	2785                	addiw	a5,a5,1
    80009a6c:	fcf42c23          	sw	a5,-40(s0)
    80009a70:	fd842783          	lw	a5,-40(s0)
    80009a74:	873e                	mv	a4,a5
    80009a76:	fdc42783          	lw	a5,-36(s0)
    80009a7a:	2701                	sext.w	a4,a4
    80009a7c:	2781                	sext.w	a5,a5
    80009a7e:	fcf748e3          	blt	a4,a5,80009a4e <alloc3_desc+0x46>
      return -1;
    80009a82:	57fd                	li	a5,-1
    80009a84:	a831                	j	80009aa0 <alloc3_desc+0x98>
  for(int i = 0; i < 3; i++){
    80009a86:	fdc42783          	lw	a5,-36(s0)
    80009a8a:	2785                	addiw	a5,a5,1
    80009a8c:	fcf42e23          	sw	a5,-36(s0)
    80009a90:	fdc42783          	lw	a5,-36(s0)
    80009a94:	0007871b          	sext.w	a4,a5
    80009a98:	4789                	li	a5,2
    80009a9a:	f8e7d1e3          	bge	a5,a4,80009a1c <alloc3_desc+0x14>
    }
  }
  return 0;
    80009a9e:	4781                	li	a5,0
}
    80009aa0:	853e                	mv	a0,a5
    80009aa2:	70e2                	ld	ra,56(sp)
    80009aa4:	7442                	ld	s0,48(sp)
    80009aa6:	74a2                	ld	s1,40(sp)
    80009aa8:	6121                	addi	sp,sp,64
    80009aaa:	8082                	ret

0000000080009aac <virtio_disk_rw>:

void
virtio_disk_rw(struct buf *b, int write)
{
    80009aac:	7139                	addi	sp,sp,-64
    80009aae:	fc06                	sd	ra,56(sp)
    80009ab0:	f822                	sd	s0,48(sp)
    80009ab2:	0080                	addi	s0,sp,64
    80009ab4:	fca43423          	sd	a0,-56(s0)
    80009ab8:	87ae                	mv	a5,a1
    80009aba:	fcf42223          	sw	a5,-60(s0)
  uint64 sector = b->blockno * (BSIZE / 512);
    80009abe:	fc843783          	ld	a5,-56(s0)
    80009ac2:	47dc                	lw	a5,12(a5)
    80009ac4:	0017979b          	slliw	a5,a5,0x1
    80009ac8:	2781                	sext.w	a5,a5
    80009aca:	1782                	slli	a5,a5,0x20
    80009acc:	9381                	srli	a5,a5,0x20
    80009ace:	fef43423          	sd	a5,-24(s0)

  acquire(&disk.vdisk_lock);
    80009ad2:	0049e517          	auipc	a0,0x49e
    80009ad6:	65650513          	addi	a0,a0,1622 # 804a8128 <disk+0x2128>
    80009ada:	ffff7097          	auipc	ra,0xffff7
    80009ade:	790080e7          	jalr	1936(ra) # 8000126a <acquire>
  // data, one for a 1-byte status result.

  // allocate the three descriptors.
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
    80009ae2:	fd040793          	addi	a5,s0,-48
    80009ae6:	853e                	mv	a0,a5
    80009ae8:	00000097          	auipc	ra,0x0
    80009aec:	f20080e7          	jalr	-224(ra) # 80009a08 <alloc3_desc>
    80009af0:	87aa                	mv	a5,a0
    80009af2:	cf91                	beqz	a5,80009b0e <virtio_disk_rw+0x62>
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80009af4:	0049e597          	auipc	a1,0x49e
    80009af8:	63458593          	addi	a1,a1,1588 # 804a8128 <disk+0x2128>
    80009afc:	0049e517          	auipc	a0,0x49e
    80009b00:	51c50513          	addi	a0,a0,1308 # 804a8018 <disk+0x2018>
    80009b04:	ffffa097          	auipc	ra,0xffffa
    80009b08:	dfe080e7          	jalr	-514(ra) # 80003902 <sleep>
    if(alloc3_desc(idx) == 0) {
    80009b0c:	bfd9                	j	80009ae2 <virtio_disk_rw+0x36>
      break;
    80009b0e:	0001                	nop
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80009b10:	fd042783          	lw	a5,-48(s0)
    80009b14:	20078793          	addi	a5,a5,512
    80009b18:	00479713          	slli	a4,a5,0x4
    80009b1c:	0049c797          	auipc	a5,0x49c
    80009b20:	4e478793          	addi	a5,a5,1252 # 804a6000 <disk>
    80009b24:	97ba                	add	a5,a5,a4
    80009b26:	0a878793          	addi	a5,a5,168
    80009b2a:	fef43023          	sd	a5,-32(s0)

  if(write)
    80009b2e:	fc442783          	lw	a5,-60(s0)
    80009b32:	2781                	sext.w	a5,a5
    80009b34:	c791                	beqz	a5,80009b40 <virtio_disk_rw+0x94>
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80009b36:	fe043783          	ld	a5,-32(s0)
    80009b3a:	4705                	li	a4,1
    80009b3c:	c398                	sw	a4,0(a5)
    80009b3e:	a029                	j	80009b48 <virtio_disk_rw+0x9c>
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    80009b40:	fe043783          	ld	a5,-32(s0)
    80009b44:	0007a023          	sw	zero,0(a5)
  buf0->reserved = 0;
    80009b48:	fe043783          	ld	a5,-32(s0)
    80009b4c:	0007a223          	sw	zero,4(a5)
  buf0->sector = sector;
    80009b50:	fe043783          	ld	a5,-32(s0)
    80009b54:	fe843703          	ld	a4,-24(s0)
    80009b58:	e798                	sd	a4,8(a5)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80009b5a:	0049c717          	auipc	a4,0x49c
    80009b5e:	4a670713          	addi	a4,a4,1190 # 804a6000 <disk>
    80009b62:	6789                	lui	a5,0x2
    80009b64:	97ba                	add	a5,a5,a4
    80009b66:	6398                	ld	a4,0(a5)
    80009b68:	fd042783          	lw	a5,-48(s0)
    80009b6c:	0792                	slli	a5,a5,0x4
    80009b6e:	97ba                	add	a5,a5,a4
    80009b70:	fe043703          	ld	a4,-32(s0)
    80009b74:	e398                	sd	a4,0(a5)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80009b76:	0049c717          	auipc	a4,0x49c
    80009b7a:	48a70713          	addi	a4,a4,1162 # 804a6000 <disk>
    80009b7e:	6789                	lui	a5,0x2
    80009b80:	97ba                	add	a5,a5,a4
    80009b82:	6398                	ld	a4,0(a5)
    80009b84:	fd042783          	lw	a5,-48(s0)
    80009b88:	0792                	slli	a5,a5,0x4
    80009b8a:	97ba                	add	a5,a5,a4
    80009b8c:	4741                	li	a4,16
    80009b8e:	c798                	sw	a4,8(a5)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80009b90:	0049c717          	auipc	a4,0x49c
    80009b94:	47070713          	addi	a4,a4,1136 # 804a6000 <disk>
    80009b98:	6789                	lui	a5,0x2
    80009b9a:	97ba                	add	a5,a5,a4
    80009b9c:	6398                	ld	a4,0(a5)
    80009b9e:	fd042783          	lw	a5,-48(s0)
    80009ba2:	0792                	slli	a5,a5,0x4
    80009ba4:	97ba                	add	a5,a5,a4
    80009ba6:	4705                	li	a4,1
    80009ba8:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[0]].next = idx[1];
    80009bac:	fd442683          	lw	a3,-44(s0)
    80009bb0:	0049c717          	auipc	a4,0x49c
    80009bb4:	45070713          	addi	a4,a4,1104 # 804a6000 <disk>
    80009bb8:	6789                	lui	a5,0x2
    80009bba:	97ba                	add	a5,a5,a4
    80009bbc:	6398                	ld	a4,0(a5)
    80009bbe:	fd042783          	lw	a5,-48(s0)
    80009bc2:	0792                	slli	a5,a5,0x4
    80009bc4:	97ba                	add	a5,a5,a4
    80009bc6:	03069713          	slli	a4,a3,0x30
    80009bca:	9341                	srli	a4,a4,0x30
    80009bcc:	00e79723          	sh	a4,14(a5) # 200e <_entry-0x7fffdff2>

  disk.desc[idx[1]].addr = (uint64) b->data;
    80009bd0:	fc843783          	ld	a5,-56(s0)
    80009bd4:	05878693          	addi	a3,a5,88
    80009bd8:	0049c717          	auipc	a4,0x49c
    80009bdc:	42870713          	addi	a4,a4,1064 # 804a6000 <disk>
    80009be0:	6789                	lui	a5,0x2
    80009be2:	97ba                	add	a5,a5,a4
    80009be4:	6398                	ld	a4,0(a5)
    80009be6:	fd442783          	lw	a5,-44(s0)
    80009bea:	0792                	slli	a5,a5,0x4
    80009bec:	97ba                	add	a5,a5,a4
    80009bee:	8736                	mv	a4,a3
    80009bf0:	e398                	sd	a4,0(a5)
  disk.desc[idx[1]].len = BSIZE;
    80009bf2:	0049c717          	auipc	a4,0x49c
    80009bf6:	40e70713          	addi	a4,a4,1038 # 804a6000 <disk>
    80009bfa:	6789                	lui	a5,0x2
    80009bfc:	97ba                	add	a5,a5,a4
    80009bfe:	6398                	ld	a4,0(a5)
    80009c00:	fd442783          	lw	a5,-44(s0)
    80009c04:	0792                	slli	a5,a5,0x4
    80009c06:	97ba                	add	a5,a5,a4
    80009c08:	40000713          	li	a4,1024
    80009c0c:	c798                	sw	a4,8(a5)
  if(write)
    80009c0e:	fc442783          	lw	a5,-60(s0)
    80009c12:	2781                	sext.w	a5,a5
    80009c14:	cf99                	beqz	a5,80009c32 <virtio_disk_rw+0x186>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80009c16:	0049c717          	auipc	a4,0x49c
    80009c1a:	3ea70713          	addi	a4,a4,1002 # 804a6000 <disk>
    80009c1e:	6789                	lui	a5,0x2
    80009c20:	97ba                	add	a5,a5,a4
    80009c22:	6398                	ld	a4,0(a5)
    80009c24:	fd442783          	lw	a5,-44(s0)
    80009c28:	0792                	slli	a5,a5,0x4
    80009c2a:	97ba                	add	a5,a5,a4
    80009c2c:	00079623          	sh	zero,12(a5) # 200c <_entry-0x7fffdff4>
    80009c30:	a839                	j	80009c4e <virtio_disk_rw+0x1a2>
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80009c32:	0049c717          	auipc	a4,0x49c
    80009c36:	3ce70713          	addi	a4,a4,974 # 804a6000 <disk>
    80009c3a:	6789                	lui	a5,0x2
    80009c3c:	97ba                	add	a5,a5,a4
    80009c3e:	6398                	ld	a4,0(a5)
    80009c40:	fd442783          	lw	a5,-44(s0)
    80009c44:	0792                	slli	a5,a5,0x4
    80009c46:	97ba                	add	a5,a5,a4
    80009c48:	4709                	li	a4,2
    80009c4a:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80009c4e:	0049c717          	auipc	a4,0x49c
    80009c52:	3b270713          	addi	a4,a4,946 # 804a6000 <disk>
    80009c56:	6789                	lui	a5,0x2
    80009c58:	97ba                	add	a5,a5,a4
    80009c5a:	6398                	ld	a4,0(a5)
    80009c5c:	fd442783          	lw	a5,-44(s0)
    80009c60:	0792                	slli	a5,a5,0x4
    80009c62:	97ba                	add	a5,a5,a4
    80009c64:	00c7d703          	lhu	a4,12(a5) # 200c <_entry-0x7fffdff4>
    80009c68:	0049c697          	auipc	a3,0x49c
    80009c6c:	39868693          	addi	a3,a3,920 # 804a6000 <disk>
    80009c70:	6789                	lui	a5,0x2
    80009c72:	97b6                	add	a5,a5,a3
    80009c74:	6394                	ld	a3,0(a5)
    80009c76:	fd442783          	lw	a5,-44(s0)
    80009c7a:	0792                	slli	a5,a5,0x4
    80009c7c:	97b6                	add	a5,a5,a3
    80009c7e:	00176713          	ori	a4,a4,1
    80009c82:	1742                	slli	a4,a4,0x30
    80009c84:	9341                	srli	a4,a4,0x30
    80009c86:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[1]].next = idx[2];
    80009c8a:	fd842683          	lw	a3,-40(s0)
    80009c8e:	0049c717          	auipc	a4,0x49c
    80009c92:	37270713          	addi	a4,a4,882 # 804a6000 <disk>
    80009c96:	6789                	lui	a5,0x2
    80009c98:	97ba                	add	a5,a5,a4
    80009c9a:	6398                	ld	a4,0(a5)
    80009c9c:	fd442783          	lw	a5,-44(s0)
    80009ca0:	0792                	slli	a5,a5,0x4
    80009ca2:	97ba                	add	a5,a5,a4
    80009ca4:	03069713          	slli	a4,a3,0x30
    80009ca8:	9341                	srli	a4,a4,0x30
    80009caa:	00e79723          	sh	a4,14(a5) # 200e <_entry-0x7fffdff2>

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80009cae:	fd042783          	lw	a5,-48(s0)
    80009cb2:	0049c717          	auipc	a4,0x49c
    80009cb6:	34e70713          	addi	a4,a4,846 # 804a6000 <disk>
    80009cba:	20078793          	addi	a5,a5,512
    80009cbe:	0792                	slli	a5,a5,0x4
    80009cc0:	97ba                	add	a5,a5,a4
    80009cc2:	577d                	li	a4,-1
    80009cc4:	02e78823          	sb	a4,48(a5)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80009cc8:	fd042783          	lw	a5,-48(s0)
    80009ccc:	20078793          	addi	a5,a5,512
    80009cd0:	00479713          	slli	a4,a5,0x4
    80009cd4:	0049c797          	auipc	a5,0x49c
    80009cd8:	32c78793          	addi	a5,a5,812 # 804a6000 <disk>
    80009cdc:	97ba                	add	a5,a5,a4
    80009cde:	03078693          	addi	a3,a5,48
    80009ce2:	0049c717          	auipc	a4,0x49c
    80009ce6:	31e70713          	addi	a4,a4,798 # 804a6000 <disk>
    80009cea:	6789                	lui	a5,0x2
    80009cec:	97ba                	add	a5,a5,a4
    80009cee:	6398                	ld	a4,0(a5)
    80009cf0:	fd842783          	lw	a5,-40(s0)
    80009cf4:	0792                	slli	a5,a5,0x4
    80009cf6:	97ba                	add	a5,a5,a4
    80009cf8:	8736                	mv	a4,a3
    80009cfa:	e398                	sd	a4,0(a5)
  disk.desc[idx[2]].len = 1;
    80009cfc:	0049c717          	auipc	a4,0x49c
    80009d00:	30470713          	addi	a4,a4,772 # 804a6000 <disk>
    80009d04:	6789                	lui	a5,0x2
    80009d06:	97ba                	add	a5,a5,a4
    80009d08:	6398                	ld	a4,0(a5)
    80009d0a:	fd842783          	lw	a5,-40(s0)
    80009d0e:	0792                	slli	a5,a5,0x4
    80009d10:	97ba                	add	a5,a5,a4
    80009d12:	4705                	li	a4,1
    80009d14:	c798                	sw	a4,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80009d16:	0049c717          	auipc	a4,0x49c
    80009d1a:	2ea70713          	addi	a4,a4,746 # 804a6000 <disk>
    80009d1e:	6789                	lui	a5,0x2
    80009d20:	97ba                	add	a5,a5,a4
    80009d22:	6398                	ld	a4,0(a5)
    80009d24:	fd842783          	lw	a5,-40(s0)
    80009d28:	0792                	slli	a5,a5,0x4
    80009d2a:	97ba                	add	a5,a5,a4
    80009d2c:	4709                	li	a4,2
    80009d2e:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[2]].next = 0;
    80009d32:	0049c717          	auipc	a4,0x49c
    80009d36:	2ce70713          	addi	a4,a4,718 # 804a6000 <disk>
    80009d3a:	6789                	lui	a5,0x2
    80009d3c:	97ba                	add	a5,a5,a4
    80009d3e:	6398                	ld	a4,0(a5)
    80009d40:	fd842783          	lw	a5,-40(s0)
    80009d44:	0792                	slli	a5,a5,0x4
    80009d46:	97ba                	add	a5,a5,a4
    80009d48:	00079723          	sh	zero,14(a5) # 200e <_entry-0x7fffdff2>

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80009d4c:	fc843783          	ld	a5,-56(s0)
    80009d50:	4705                	li	a4,1
    80009d52:	c3d8                	sw	a4,4(a5)
  disk.info[idx[0]].b = b;
    80009d54:	fd042783          	lw	a5,-48(s0)
    80009d58:	0049c717          	auipc	a4,0x49c
    80009d5c:	2a870713          	addi	a4,a4,680 # 804a6000 <disk>
    80009d60:	20078793          	addi	a5,a5,512
    80009d64:	0792                	slli	a5,a5,0x4
    80009d66:	97ba                	add	a5,a5,a4
    80009d68:	fc843703          	ld	a4,-56(s0)
    80009d6c:	f798                	sd	a4,40(a5)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80009d6e:	fd042603          	lw	a2,-48(s0)
    80009d72:	0049c717          	auipc	a4,0x49c
    80009d76:	28e70713          	addi	a4,a4,654 # 804a6000 <disk>
    80009d7a:	6789                	lui	a5,0x2
    80009d7c:	97ba                	add	a5,a5,a4
    80009d7e:	6794                	ld	a3,8(a5)
    80009d80:	0049c717          	auipc	a4,0x49c
    80009d84:	28070713          	addi	a4,a4,640 # 804a6000 <disk>
    80009d88:	6789                	lui	a5,0x2
    80009d8a:	97ba                	add	a5,a5,a4
    80009d8c:	679c                	ld	a5,8(a5)
    80009d8e:	0027d783          	lhu	a5,2(a5) # 2002 <_entry-0x7fffdffe>
    80009d92:	2781                	sext.w	a5,a5
    80009d94:	8b9d                	andi	a5,a5,7
    80009d96:	2781                	sext.w	a5,a5
    80009d98:	03061713          	slli	a4,a2,0x30
    80009d9c:	9341                	srli	a4,a4,0x30
    80009d9e:	0786                	slli	a5,a5,0x1
    80009da0:	97b6                	add	a5,a5,a3
    80009da2:	00e79223          	sh	a4,4(a5)

  __sync_synchronize();
    80009da6:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80009daa:	0049c717          	auipc	a4,0x49c
    80009dae:	25670713          	addi	a4,a4,598 # 804a6000 <disk>
    80009db2:	6789                	lui	a5,0x2
    80009db4:	97ba                	add	a5,a5,a4
    80009db6:	679c                	ld	a5,8(a5)
    80009db8:	0027d703          	lhu	a4,2(a5) # 2002 <_entry-0x7fffdffe>
    80009dbc:	0049c697          	auipc	a3,0x49c
    80009dc0:	24468693          	addi	a3,a3,580 # 804a6000 <disk>
    80009dc4:	6789                	lui	a5,0x2
    80009dc6:	97b6                	add	a5,a5,a3
    80009dc8:	679c                	ld	a5,8(a5)
    80009dca:	2705                	addiw	a4,a4,1
    80009dcc:	1742                	slli	a4,a4,0x30
    80009dce:	9341                	srli	a4,a4,0x30
    80009dd0:	00e79123          	sh	a4,2(a5) # 2002 <_entry-0x7fffdffe>

  __sync_synchronize();
    80009dd4:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80009dd8:	100017b7          	lui	a5,0x10001
    80009ddc:	05078793          	addi	a5,a5,80 # 10001050 <_entry-0x6fffefb0>
    80009de0:	0007a023          	sw	zero,0(a5)

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80009de4:	a819                	j	80009dfa <virtio_disk_rw+0x34e>
    sleep(b, &disk.vdisk_lock);
    80009de6:	0049e597          	auipc	a1,0x49e
    80009dea:	34258593          	addi	a1,a1,834 # 804a8128 <disk+0x2128>
    80009dee:	fc843503          	ld	a0,-56(s0)
    80009df2:	ffffa097          	auipc	ra,0xffffa
    80009df6:	b10080e7          	jalr	-1264(ra) # 80003902 <sleep>
  while(b->disk == 1) {
    80009dfa:	fc843783          	ld	a5,-56(s0)
    80009dfe:	43dc                	lw	a5,4(a5)
    80009e00:	873e                	mv	a4,a5
    80009e02:	4785                	li	a5,1
    80009e04:	fef701e3          	beq	a4,a5,80009de6 <virtio_disk_rw+0x33a>
  }

  disk.info[idx[0]].b = 0;
    80009e08:	fd042783          	lw	a5,-48(s0)
    80009e0c:	0049c717          	auipc	a4,0x49c
    80009e10:	1f470713          	addi	a4,a4,500 # 804a6000 <disk>
    80009e14:	20078793          	addi	a5,a5,512
    80009e18:	0792                	slli	a5,a5,0x4
    80009e1a:	97ba                	add	a5,a5,a4
    80009e1c:	0207b423          	sd	zero,40(a5)
  free_chain(idx[0]);
    80009e20:	fd042783          	lw	a5,-48(s0)
    80009e24:	853e                	mv	a0,a5
    80009e26:	00000097          	auipc	ra,0x0
    80009e2a:	b6a080e7          	jalr	-1174(ra) # 80009990 <free_chain>

  release(&disk.vdisk_lock);
    80009e2e:	0049e517          	auipc	a0,0x49e
    80009e32:	2fa50513          	addi	a0,a0,762 # 804a8128 <disk+0x2128>
    80009e36:	ffff7097          	auipc	ra,0xffff7
    80009e3a:	498080e7          	jalr	1176(ra) # 800012ce <release>
}
    80009e3e:	0001                	nop
    80009e40:	70e2                	ld	ra,56(sp)
    80009e42:	7442                	ld	s0,48(sp)
    80009e44:	6121                	addi	sp,sp,64
    80009e46:	8082                	ret

0000000080009e48 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80009e48:	1101                	addi	sp,sp,-32
    80009e4a:	ec06                	sd	ra,24(sp)
    80009e4c:	e822                	sd	s0,16(sp)
    80009e4e:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80009e50:	0049e517          	auipc	a0,0x49e
    80009e54:	2d850513          	addi	a0,a0,728 # 804a8128 <disk+0x2128>
    80009e58:	ffff7097          	auipc	ra,0xffff7
    80009e5c:	412080e7          	jalr	1042(ra) # 8000126a <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80009e60:	100017b7          	lui	a5,0x10001
    80009e64:	06078793          	addi	a5,a5,96 # 10001060 <_entry-0x6fffefa0>
    80009e68:	439c                	lw	a5,0(a5)
    80009e6a:	0007871b          	sext.w	a4,a5
    80009e6e:	100017b7          	lui	a5,0x10001
    80009e72:	06478793          	addi	a5,a5,100 # 10001064 <_entry-0x6fffef9c>
    80009e76:	8b0d                	andi	a4,a4,3
    80009e78:	2701                	sext.w	a4,a4
    80009e7a:	c398                	sw	a4,0(a5)

  __sync_synchronize();
    80009e7c:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80009e80:	a855                	j	80009f34 <virtio_disk_intr+0xec>
    __sync_synchronize();
    80009e82:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80009e86:	0049c717          	auipc	a4,0x49c
    80009e8a:	17a70713          	addi	a4,a4,378 # 804a6000 <disk>
    80009e8e:	6789                	lui	a5,0x2
    80009e90:	97ba                	add	a5,a5,a4
    80009e92:	6b98                	ld	a4,16(a5)
    80009e94:	0049c697          	auipc	a3,0x49c
    80009e98:	16c68693          	addi	a3,a3,364 # 804a6000 <disk>
    80009e9c:	6789                	lui	a5,0x2
    80009e9e:	97b6                	add	a5,a5,a3
    80009ea0:	0207d783          	lhu	a5,32(a5) # 2020 <_entry-0x7fffdfe0>
    80009ea4:	2781                	sext.w	a5,a5
    80009ea6:	8b9d                	andi	a5,a5,7
    80009ea8:	2781                	sext.w	a5,a5
    80009eaa:	078e                	slli	a5,a5,0x3
    80009eac:	97ba                	add	a5,a5,a4
    80009eae:	43dc                	lw	a5,4(a5)
    80009eb0:	fef42623          	sw	a5,-20(s0)

    if(disk.info[id].status != 0)
    80009eb4:	0049c717          	auipc	a4,0x49c
    80009eb8:	14c70713          	addi	a4,a4,332 # 804a6000 <disk>
    80009ebc:	fec42783          	lw	a5,-20(s0)
    80009ec0:	20078793          	addi	a5,a5,512
    80009ec4:	0792                	slli	a5,a5,0x4
    80009ec6:	97ba                	add	a5,a5,a4
    80009ec8:	0307c783          	lbu	a5,48(a5)
    80009ecc:	cb89                	beqz	a5,80009ede <virtio_disk_intr+0x96>
      panic("virtio_disk_intr status");
    80009ece:	00002517          	auipc	a0,0x2
    80009ed2:	9e250513          	addi	a0,a0,-1566 # 8000b8b0 <etext+0x8b0>
    80009ed6:	ffff7097          	auipc	ra,0xffff7
    80009eda:	da4080e7          	jalr	-604(ra) # 80000c7a <panic>

    struct buf *b = disk.info[id].b;
    80009ede:	0049c717          	auipc	a4,0x49c
    80009ee2:	12270713          	addi	a4,a4,290 # 804a6000 <disk>
    80009ee6:	fec42783          	lw	a5,-20(s0)
    80009eea:	20078793          	addi	a5,a5,512
    80009eee:	0792                	slli	a5,a5,0x4
    80009ef0:	97ba                	add	a5,a5,a4
    80009ef2:	779c                	ld	a5,40(a5)
    80009ef4:	fef43023          	sd	a5,-32(s0)
    b->disk = 0;   // disk is done with buf
    80009ef8:	fe043783          	ld	a5,-32(s0)
    80009efc:	0007a223          	sw	zero,4(a5)
    wakeup(b);
    80009f00:	fe043503          	ld	a0,-32(s0)
    80009f04:	ffffa097          	auipc	ra,0xffffa
    80009f08:	a7a080e7          	jalr	-1414(ra) # 8000397e <wakeup>

    disk.used_idx += 1;
    80009f0c:	0049c717          	auipc	a4,0x49c
    80009f10:	0f470713          	addi	a4,a4,244 # 804a6000 <disk>
    80009f14:	6789                	lui	a5,0x2
    80009f16:	97ba                	add	a5,a5,a4
    80009f18:	0207d783          	lhu	a5,32(a5) # 2020 <_entry-0x7fffdfe0>
    80009f1c:	2785                	addiw	a5,a5,1
    80009f1e:	03079713          	slli	a4,a5,0x30
    80009f22:	9341                	srli	a4,a4,0x30
    80009f24:	0049c697          	auipc	a3,0x49c
    80009f28:	0dc68693          	addi	a3,a3,220 # 804a6000 <disk>
    80009f2c:	6789                	lui	a5,0x2
    80009f2e:	97b6                	add	a5,a5,a3
    80009f30:	02e79023          	sh	a4,32(a5) # 2020 <_entry-0x7fffdfe0>
  while(disk.used_idx != disk.used->idx){
    80009f34:	0049c717          	auipc	a4,0x49c
    80009f38:	0cc70713          	addi	a4,a4,204 # 804a6000 <disk>
    80009f3c:	6789                	lui	a5,0x2
    80009f3e:	97ba                	add	a5,a5,a4
    80009f40:	0207d683          	lhu	a3,32(a5) # 2020 <_entry-0x7fffdfe0>
    80009f44:	0049c717          	auipc	a4,0x49c
    80009f48:	0bc70713          	addi	a4,a4,188 # 804a6000 <disk>
    80009f4c:	6789                	lui	a5,0x2
    80009f4e:	97ba                	add	a5,a5,a4
    80009f50:	6b9c                	ld	a5,16(a5)
    80009f52:	0027d783          	lhu	a5,2(a5) # 2002 <_entry-0x7fffdffe>
    80009f56:	0006871b          	sext.w	a4,a3
    80009f5a:	2781                	sext.w	a5,a5
    80009f5c:	f2f713e3          	bne	a4,a5,80009e82 <virtio_disk_intr+0x3a>
  }

  release(&disk.vdisk_lock);
    80009f60:	0049e517          	auipc	a0,0x49e
    80009f64:	1c850513          	addi	a0,a0,456 # 804a8128 <disk+0x2128>
    80009f68:	ffff7097          	auipc	ra,0xffff7
    80009f6c:	366080e7          	jalr	870(ra) # 800012ce <release>
}
    80009f70:	0001                	nop
    80009f72:	60e2                	ld	ra,24(sp)
    80009f74:	6442                	ld	s0,16(sp)
    80009f76:	6105                	addi	sp,sp,32
    80009f78:	8082                	ret
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
